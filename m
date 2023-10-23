Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762E07D3108
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjJWLEq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjJWLEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076DD7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541BFC433C8;
        Mon, 23 Oct 2023 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059082;
        bh=EeqZBH3rjtD+n3stPzGBDxX/S9CX3KR4ZlbZ3VFvuM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSDus2aDlXVmJFZy57wnBki1QUg9uC21P+rpOCyLz6tzkLnVWLLf6eMkCeJHPvQ+p
         jc7uk68M2ArMB9r9A228kORuec3z5Ielzbue6vHGoOXPK+9WU05I80K31tbujMc5fF
         UjfCC0HgD8aem+8UXjzsXMRUSaW5cPL+9tFU+dps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com,
        Pavel Skripkin <paskripkin@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.5 030/241] fs/ntfs3: Fix OOB read in ntfs_init_from_boot
Date:   Mon, 23 Oct 2023 12:53:36 +0200
Message-ID: <20231023104834.663926761@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Skripkin <paskripkin@gmail.com>

commit 34e6552a442f268eefd408e47f4f2d471aa64829 upstream.

Syzbot was able to create a device which has the last sector of size
512.

After failing to boot from initial sector, reading from boot info from
offset 511 causes OOB read.

To prevent such reports add sanity check to validate if size of buffer_head
if big enough to hold ntfs3 bootinfo

Fixes: 6a4cd3ea7d77 ("fs/ntfs3: Alternative boot if primary boot is corrupted")
Reported-by: syzbot+53ce40c8c0322c06aea5@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/super.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -855,6 +855,11 @@ static int ntfs_init_from_boot(struct su
 
 check_boot:
 	err = -EINVAL;
+
+	/* Corrupted image; do not read OOB */
+	if (bh->b_size - sizeof(*boot) < boot_off)
+		goto out;
+
 	boot = (struct NTFS_BOOT *)Add2Ptr(bh->b_data, boot_off);
 
 	if (memcmp(boot->system_id, "NTFS    ", sizeof("NTFS    ") - 1)) {


