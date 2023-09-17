Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF87A39DB
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbjIQTzN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjIQTyy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:54:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A03F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95D3C433C7;
        Sun, 17 Sep 2023 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980488;
        bh=egCKt7TXu4Qc0ilwWMzuAlfaKrdnwpfhWv2GYIPtfu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zsi1u6OYrwKGoQ1Kep5F2lwy+GKLfQ/2Ux1S9upicA6AtN+Gjt7ikW8x7lQwC/y6/
         DlDG7smYm6nUPD91f6I6uoE2WFKAgbxB40zMSvxAv0A1gTNwURLW1/JZ102dIaoyxz
         qv6goKOu4LV8K457wBIw7ywgXSusk+pefGsI4yJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.5 207/285] btrfs: zoned: re-enable metadata over-commit for zoned mode
Date:   Sun, 17 Sep 2023 21:13:27 +0200
Message-ID: <20230917191058.737926200@linuxfoundation.org>
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

From: Naohiro Aota <naohiro.aota@wdc.com>

commit 5b135b382a360f4c87cf8896d1465b0b07f10cb0 upstream.

Now that, we can re-enable metadata over-commit. As we moved the activation
from the reservation time to the write time, we no longer need to ensure
all the reserved bytes is properly activated.

Without the metadata over-commit, it suffers from lower performance because
it needs to flush the delalloc items more often and allocate more block
groups. Re-enabling metadata over-commit will solve the issue.

Fixes: 79417d040f4f ("btrfs: zoned: disable metadata overcommit for zoned")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/space-info.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -389,11 +389,7 @@ int btrfs_can_overcommit(struct btrfs_fs
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags) &&
-	    (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
-		avail = 0;
-	else
-		avail = calc_available_free_space(fs_info, space_info, flush);
+	avail = calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < space_info->total_bytes + avail)
 		return 1;


