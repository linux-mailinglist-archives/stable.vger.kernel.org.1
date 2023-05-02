Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B546F3CEC
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 07:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjEBF0H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 01:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBF0G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 01:26:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A993B1FEE
        for <stable@vger.kernel.org>; Mon,  1 May 2023 22:26:05 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5144902c15eso1726329a12.2
        for <stable@vger.kernel.org>; Mon, 01 May 2023 22:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683005165; x=1685597165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inWjdeCM7ITc9r4hDO50miXuVervd1UWiQTtgu3x/sA=;
        b=u41kMLQIt5RoP71wribYdPtfTi2jnS4mooLzQ+UacJ3Bwu4MVZT+9K62mQKEfff47a
         7jqOx3QHGCWdP46bYo9x/d2AXr9Rpmu79PAz72OT+1mWrunryxa8VUX5yEGhQCRs2T4z
         YEqBHOW6Cs78IcluPAJWPNqjpIDYdZJI5GPa7s3VVsn/Evpxd93uRmCARUMJnZ3LmOC8
         J38NU0oRFMfEIAfQ/tSCtWMKK6+isoiVPXP1TSapvJSlDJTXoErp96lgwPNtTluseT2B
         HRvXlTovVrrKoj63G0272+bUDXG8rqNUlL5x+KW/wxeXYKm5ZWNiQXlqryWMcNrPxc+U
         gpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683005165; x=1685597165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inWjdeCM7ITc9r4hDO50miXuVervd1UWiQTtgu3x/sA=;
        b=jNQ3EAdQvPKIfp+vHYPh1ac4SAOuujOGJQ0YRTlrSo75mLB6W+Wrq707pAhNEaS/2R
         DhaEAYgid4jDlW+3UWRnTVcDYG9HGV73BFnB/QIgT272XuMNcMo4id5fFoIcvzZUJX4j
         fCZ7OGeXGwoPOehnCUbKXCVr572CtO8tZuCdQFBCxDZ9HyySTGk2x+91bz2usX9TgLWr
         HK8cHrMz0mimgIg7BGuxLno9qGpCNxwhl3b3X5q50Nzd/cgeKBvCWkcsdtRc1Sps9CnG
         dsmzrdifm7g5/QXN8DRmOe1O2jsFSmxbPkdmNZOT9UVPohFmgDLugUpCqB9K/HDQm9gE
         LyUQ==
X-Gm-Message-State: AC+VfDxjpi2LEK75vWVIxErvcvk7kzkGcpK7IJgpi6ObuLe/fLIqa3TK
        VfyQD0z3RjI67rR+cflpxrSaZ7HQ+fFQFu77qY4lTG+UDKApDHVh1Q7F/lTqBozBcN9VFFW6Qas
        Kg5XIs2PLBJOLBEYTDWrWknJzX4hxXFLK10PWyW/vayeK0YPTmPkpgB1mygUtXALkff67HqqBx0
        FxJWp6kBc=
X-Google-Smtp-Source: ACHHUZ4P7bAdccQAI6edMp+P8QOybkOXKUGbXLxREP0BpNbx3mJsQZ9tHZT/p+o6l/AKA+55NoXKQWDaVvhZgZ7S3JASVA==
X-Received: from meenashanmugamspl.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2707])
 (user=meenashanmugam job=sendgmr) by 2002:a63:2e05:0:b0:513:9753:46d2 with
 SMTP id bv5-20020a632e05000000b00513975346d2mr3955305pgb.2.1683005165009;
 Mon, 01 May 2023 22:26:05 -0700 (PDT)
Date:   Tue,  2 May 2023 05:25:54 +0000
In-Reply-To: <20230502052554.3068013-1-meenashanmugam@google.com>
Mime-Version: 1.0
References: <20230502052554.3068013-1-meenashanmugam@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502052554.3068013-2-meenashanmugam@google.com>
Subject: [PATCH 5.10 1/1] ext4: reduce computation of overhead during resize
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
index 51cebc1990eb..c606f16c94be 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1360,6 +1360,17 @@ static int ext4_setup_new_descs(handle_t *handle, struct super_block *sb,
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
@@ -1458,9 +1469,17 @@ static void ext4_update_super(struct super_block *sb,
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
 
 	if (test_opt(sb, DEBUG))
-- 
2.40.1.495.gc816e09b53d-goog

