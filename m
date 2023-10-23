Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2066F7D310B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjJWLEz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjJWLEy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16004D7F
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53984C433C9;
        Mon, 23 Oct 2023 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059091;
        bh=3335+NKtU7MtJIyvyXf3/RcJESUsqEjRaBvLWsVrtuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIZle4BH/KPfHoRIIntOzHXO6DMDGdxXdOZN2CJOuQM0AsbetJk6pzmlJaahWGONs
         VvCaN0mlm42RbUWMdgkDLM6Qmp+2A8XJ4mud0CxbMnAUW+xnES+Q0wP+7zD0D5neqJ
         8Qj5CDkU9c2NV2BP9x1Zjf+/lHd/JGllx4H0jrOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.5 033/241] fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
Date:   Mon, 23 Oct 2023 12:53:39 +0200
Message-ID: <20231023104834.733247360@linuxfoundation.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 91a4b1ee78cb100b19b70f077c247f211110348f upstream.

Reported-by: syzbot+478c1bf0e6bf4a8f3a04@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/ntfs_fs.h |    2 ++
 fs/ntfs3/super.c   |   26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -906,9 +906,17 @@ check_boot:
 		goto out;
 	}
 
-	sbi->record_size = record_size =
-		boot->record_size < 0 ? 1 << (-boot->record_size) :
-					(u32)boot->record_size << cluster_bits;
+	if (boot->record_size >= 0) {
+		record_size = (u32)boot->record_size << cluster_bits;
+	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+		record_size = 1u << (-boot->record_size);
+	} else {
+		ntfs_err(sb, "%s: invalid record size %d.", hint,
+			 boot->record_size);
+		goto out;
+	}
+
+	sbi->record_size = record_size;
 	sbi->record_bits = blksize_bits(record_size);
 	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
 
@@ -925,9 +933,15 @@ check_boot:
 		goto out;
 	}
 
-	sbi->index_size = boot->index_size < 0 ?
-				  1u << (-boot->index_size) :
-				  (u32)boot->index_size << cluster_bits;
+	if (boot->index_size >= 0) {
+		sbi->index_size = (u32)boot->index_size << cluster_bits;
+	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+		sbi->index_size = 1u << (-boot->index_size);
+	} else {
+		ntfs_err(sb, "%s: invalid index size %d.", hint,
+			 boot->index_size);
+		goto out;
+	}
 
 	/* Check index record size. */
 	if (sbi->index_size < SECTOR_SIZE || !is_power_of_2(sbi->index_size)) {


