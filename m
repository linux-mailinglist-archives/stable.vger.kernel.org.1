Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E047A3934
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjIQTqN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbjIQTp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70634103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E930C433C8;
        Sun, 17 Sep 2023 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979953;
        bh=hMrmL8O9gKdfEZZP5+qHXRJTFmONbmVIu5cpr9kMuyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxObcOzxHRiw4evpTHh0hCoHce7dyl7laUOpUhgra0uo/+jTq1EqDjhKmMOprnu9w
         38KFMqw+4f/ISELVbdJVL6ZiLXCRDLBO+X9upkHBSi9t1S/qrEKuK3bxP3/rH9tS42
         jPI+Oi7X8aGR0Jg1/Imw4tmqKAfDCeOXZrQoDBgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 6.5 054/285] NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
Date:   Sun, 17 Sep 2023 21:10:54 +0200
Message-ID: <20230917191053.552843867@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 96562c45af5c31b89a197af28f79bfa838fb8391 upstream.

It is an almost improbable error case but when page allocating loop in
nfs4_get_device_info() fails then we should only free the already
allocated pages, as __free_page() can't deal with NULL arguments.

Found by Linux Verification Center (linuxtesting.org).

Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -154,7 +154,7 @@ nfs4_get_device_info(struct nfs_server *
 		set_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 
 out_free_pages:
-	for (i = 0; i < max_pages; i++)
+	while (--i >= 0)
 		__free_page(pages[i]);
 	kfree(pages);
 out_free_pdev:


