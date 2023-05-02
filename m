Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0B6F3CCD
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjEBEpu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 00:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjEBEpt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 00:45:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B5630FD
        for <stable@vger.kernel.org>; Mon,  1 May 2023 21:45:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7766d220so4053730276.2
        for <stable@vger.kernel.org>; Mon, 01 May 2023 21:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683002748; x=1685594748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6sxWYSiaqlrZO6oWaFJ48IPVT76D6VKSPj90MmENV0=;
        b=WqUrYCl02g+cRYOiS4BnfnhS+VNN7kpzFkLKegI84sP8QAJq+N36TFdyszIQ1hI4L5
         g9K7sNHluS6WcXUOEnGvWOiuO8oinzLRGUkpQT1zAZPn2F2jMFasI+sp5Nxfb4xK5IiW
         GuORRRwc83GmvMuGY0GZbOiqhKaHPR2ACgh4pIVRcCNjX8hevPM7r05f7on95Nbp0OzY
         iTfkU4I5EnzjuOzzWN5lQsiVOxJcegFvGw5EmDUq+xtbOd/Vund9iAJbGKk1SBGf1+PP
         dQXVGPpip2iczc5yBNkzUn0MvEm3oiGcQzP/LeOKoEdVPPSGZCDYK3z4DxATDkqg4YOK
         a+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683002748; x=1685594748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6sxWYSiaqlrZO6oWaFJ48IPVT76D6VKSPj90MmENV0=;
        b=VYvTs4X4fozoDu5Q+MH3cZPRc7TkkMgyOubWcW/kZPhbY/cZ73k1sPhwNUDxcKqFi3
         zphR1uzZ1DNq4pOda4MWrMQA9lKPXXqmNmUONH6GHguERW2wW8XlDL/yu+tjzOybv13u
         q8YviRb770dtz0OJ4y/fZKnlYDvv4tihoI1yjD5dgn1Vei6pZxVgiMyyJBnndRnoHi2m
         g6F9IPhcYsmDUCAxGwBRW15sRpkzgqJ3lJ5TjY7L8fBe4u9U/8JUeeCvyCESaCEyU8Oe
         ujmx+q2iv2IkoNcYTnn48oJXN6mVy++L8CqlgBIDU4q/D74Ghys147zER9adwotSVFVg
         LsrA==
X-Gm-Message-State: AC+VfDwHll3DGpQH0DqJegEmjlGbhatKdt+3ilNy952reo0dIZaTlJ9V
        JSJWSZx/t1iS2Q4oZVx6BhIaAwldh00USHTZ9QzxR78oysVI/BAO2rCrtnqqyMdvxHHbuaVaTN6
        NdY+wPsi0t/f4+wtAHjwYLUEu6Mj9vmlVaZSlKLSjg6KYcVHPDq0oTBsZPPW4l1w7ywfMOctf3I
        ewlIqGUVs=
X-Google-Smtp-Source: ACHHUZ7UG5ZnEt23f2F562ym+TspJ3qsWgP5E9vasXHvxErdBQTga0iLAX0H0151l0AzH2GtireVJBMe94YbdAFiRpOXSQ==
X-Received: from meenashanmugamspl.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2707])
 (user=meenashanmugam job=sendgmr) by 2002:a25:6a44:0:b0:b8f:6be0:1732 with
 SMTP id f65-20020a256a44000000b00b8f6be01732mr9742863ybc.2.1683002748241;
 Mon, 01 May 2023 21:45:48 -0700 (PDT)
Date:   Tue,  2 May 2023 04:45:27 +0000
In-Reply-To: <20230502044527.3062564-1-meenashanmugam@google.com>
Mime-Version: 1.0
References: <20230502044527.3062564-1-meenashanmugam@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502044527.3062564-2-meenashanmugam@google.com>
Subject: [PATCH 5.15 1/1] ext4: reduce computation of overhead during resize
From:   Meena Shanmugam <meenashanmugam@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org, tytso@mit.edu,
        okiselev@amazon.com, Meena Shanmugam <meenashanmugam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Kiselev, Oleg" <okiselev@amazon.com>

commit 026d0d27c4882303e4b071ca6d996640cc2932c3 upstream.

This patch avoids doing an O(n**2)-complexity walk through every flex group.
Instead, it uses the already computed overhead information for the newly
allocated space, and simply adds it to the previously calculated
overhead stored in the superblock.  This drastically reduces the time
taken to resize very large bigalloc filesystems (from 3+ hours for a
64TB fs down to milliseconds).

Signed-off-by: Oleg Kiselev <okiselev@amazon.com>
Link: https://lore.kernel.org/r/CE4F359F-4779-45E6-B6A9-8D67FDFF5AE2@amazon.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Meena Shanmugam <meenashanmugam@google.com>
---
 fs/ext4/resize.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 589ed99856f3..8cba3bc2dd8c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1368,6 +1368,17 @@ static int ext4_setup_new_descs(handle_t *handle, struct super_block *sb,
 	return err;
 }
 
+static void ext4_add_overhead(struct super_block *sb,
+                              const ext4_fsblk_t overhead)
+{
+       struct ext4_sb_info *sbi = EXT4_SB(sb);
+       struct ext4_super_block *es = sbi->s_es;
+
+       sbi->s_overhead += overhead;
+       es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
+       smp_wmb();
+}
+
 /*
  * ext4_update_super() updates the super block so that the newly added
  * groups can be seen by the filesystem.
@@ -1467,9 +1478,17 @@ static void ext4_update_super(struct super_block *sb,
 	}
 
 	/*
-	 * Update the fs overhead information
+	 * Update the fs overhead information.
+	 *
+	 * For bigalloc, if the superblock already has a properly calculated
+	 * overhead, update it with a value based on numbers already computed
+	 * above for the newly allocated capacity.
 	 */
-	ext4_calculate_overhead(sb);
+	if (ext4_has_feature_bigalloc(sb) && (sbi->s_overhead != 0))
+		ext4_add_overhead(sb,
+			EXT4_NUM_B2C(sbi, blocks_count - free_blocks));
+	else
+		ext4_calculate_overhead(sb);
 	es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
 
 	ext4_superblock_csum_set(sb);
-- 
2.40.1.495.gc816e09b53d-goog

