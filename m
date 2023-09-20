Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91417A8093
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjITMiF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbjITMiA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:38:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7293
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:37:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC68C433C8;
        Wed, 20 Sep 2023 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213474;
        bh=FwqdeRgHPAjFXInKwcrnlj5729dPqStP4kK0GWghxBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1hnubG1n9wQGlvIEwN5P9QF/6pB+CeCM7/A5tTueKhiLUUqu/ffJaK0EjkRqrSG/
         5Lu4DvrHwAKbcFWOiijwCiOisC18eVFSTIFqdCoGMtxVof8pGuMp8g/EiZ0OJV9wKc
         mWzUrcbz3EoO3lX89wHrb8wqnTwKlle3rValD9yQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.4 251/367] NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
Date:   Wed, 20 Sep 2023 13:30:28 +0200
Message-ID: <20230920112905.053999118@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -152,7 +152,7 @@ nfs4_get_device_info(struct nfs_server *
 		set_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 
 out_free_pages:
-	for (i = 0; i < max_pages; i++)
+	while (--i >= 0)
 		__free_page(pages[i]);
 	kfree(pages);
 out_free_pdev:


