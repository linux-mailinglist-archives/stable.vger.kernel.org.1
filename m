Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3476AD98
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjHAJao (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjHAJa1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6198D2690
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D4B614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83284C433C8;
        Tue,  1 Aug 2023 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882143;
        bh=qzIFV1Uoj9rwDVZPipW7h6dAuo6u+hfIRfNvdNBuIbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brYEoQy1CbXGmFcDunJS5jw+WcHKI/b6vb73qfd2kSDmKw6XhpEDpLpSbJBDdJovI
         wd1f7iaWLPbwo2J0NZz3/lJM2DMOEzn/OXdzoVHK9uAB3WxD/OcBRoy5JTumtZhg5e
         DMd/RfX+sQpGa/dVgQ1lyb3wTn30BvePsTNIq+S0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 5.15 146/155] rbd: harden get_lock_owner_info() a bit
Date:   Tue,  1 Aug 2023 11:20:58 +0200
Message-ID: <20230801091915.352868409@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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
@@ -3864,10 +3864,9 @@ static struct ceph_locker *get_lock_owne
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
@@ -3888,18 +3887,28 @@ static struct ceph_locker *get_lock_owne
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
@@ -1144,6 +1144,7 @@ bool ceph_addr_is_blank(const struct cep
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {


