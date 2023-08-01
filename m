Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48B276AEC2
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjHAJlk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjHAJlQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186492135
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889C06126D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9834EC433C8;
        Tue,  1 Aug 2023 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882741;
        bh=ChY9JAkgqybK9cQlnUbYEfoq5MZSFtJFx2q5DO+1RoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=of8msWoouSq3dchS9x99GOpAaJm2B6JefY8iBlk9aaGC7YWNAI/O8j/VBpWyA3LYI
         DxbdoVSGVa1lST83PYeMQl5boJbT+ueN7egHikQIvIhdF3drpb6+o2mgG7EZZpE3SJ
         J17Uyj/allwXBCXtTeDCCod7J7uPptg30ckZ+P5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.1 215/228] rbd: harden get_lock_owner_info() a bit
Date:   Tue,  1 Aug 2023 11:21:13 +0200
Message-ID: <20230801091930.627316218@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit 8ff2c64c9765446c3cef804fb99da04916603e27 upstream.

- we want the exclusive lock type, so test for it directly
- use sscanf() to actually parse the lock cookie and avoid admitting
  invalid handles
- bail if locker has a blank address

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c  |   21 +++++++++++++++------
 net/ceph/messenger.c |    1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3863,10 +3863,9 @@ static struct ceph_locker *get_lock_owne
 	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
+	u64 handle;
 	int ret;
 
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
 				 &lock_type, &lock_tag, &lockers, &num_lockers);
@@ -3887,18 +3886,28 @@ static struct ceph_locker *get_lock_owne
 		goto err_busy;
 	}
 
-	if (lock_type == CEPH_CLS_LOCK_SHARED) {
-		rbd_warn(rbd_dev, "shared lock type detected");
+	if (lock_type != CEPH_CLS_LOCK_EXCLUSIVE) {
+		rbd_warn(rbd_dev, "incompatible lock type detected");
 		goto err_busy;
 	}
 
 	WARN_ON(num_lockers != 1);
-	if (strncmp(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
-		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
+	ret = sscanf(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu",
+		     &handle);
+	if (ret != 1) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
 			 lockers[0].id.cookie);
 		goto err_busy;
 	}
+	if (ceph_addr_is_blank(&lockers[0].info.addr)) {
+		rbd_warn(rbd_dev, "locker has a blank address");
+		goto err_busy;
+	}
+
+	dout("%s rbd_dev %p got locker %s%llu@%pISpc/%u handle %llu\n",
+	     __func__, rbd_dev, ENTITY_NAME(lockers[0].id.name),
+	     &lockers[0].info.addr.in_addr,
+	     le32_to_cpu(lockers[0].info.addr.nonce), handle);
 
 out:
 	kfree(lock_tag);
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1118,6 +1118,7 @@ bool ceph_addr_is_blank(const struct cep
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {


