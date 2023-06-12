Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075F472C02E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjFLKug (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbjFLKuD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01804699
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B042F61D7A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40EAC433EF;
        Mon, 12 Jun 2023 10:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566088;
        bh=YN1bklJ9l4GaY/e0Lc6NtWObUCfUJHASn+Fx43m3zeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7ekizK/toyskzSB30hJYd2df2Hr4ux4EiCeaGRCGIxpivm7Afg8BJ5G7HOpZx3KK
         qx7GNTQreNph7CU9kNU/thGH3exl9DKGSfih0sMwA+q09xWoOm3IhOPHrZZHukweom
         AGYZlnd+6jFiDUodK7xf2CzTOvbAmCvSLzwK95Bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 60/68] Revert "ext4: dont clear SB_RDONLY when remounting r/w until quota is re-enabled"
Date:   Mon, 12 Jun 2023 12:26:52 +0200
Message-ID: <20230612101700.942454171@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 1b29243933098cdbc31b579b5616e183b4275e2f upstream.

This reverts commit a44be64bbecb15a452496f60db6eacfee2b59c79.

Link: https://lore.kernel.org/r/653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5799,7 +5799,6 @@ static int ext4_remount(struct super_blo
 	ext4_group_t g;
 	unsigned int journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -5992,7 +5991,7 @@ static int ext4_remount(struct super_blo
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6039,9 +6038,6 @@ static int ext4_remount(struct super_blo
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings


