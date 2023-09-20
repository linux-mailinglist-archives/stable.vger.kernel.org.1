Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A357A7E8C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjITMSr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjITMSq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C0C2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:18:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E88C433C9;
        Wed, 20 Sep 2023 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212320;
        bh=lwuY3JCMPpzFxUOSqDBa0Kri8cjAX1lBMgQ4CzugVqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOGac/RWgxD46zVWGz1JuYCAPDBO6JT0GPw+pjv9XW7Qp4AFdo87niIqvJ1urKKRq
         BF9PstiBWkXwzJkyPvM2+P9ec93PSB6weub0ATMQv+A7yZeSfYeEECErLiMeTXHqg7
         fdoieKYVQ6Tb40flUkeADIYJiK9f4zaA3a02qHB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 205/273] NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
Date:   Wed, 20 Sep 2023 13:30:45 +0200
Message-ID: <20230920112852.823301716@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


