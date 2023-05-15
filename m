Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B579970381F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbjEOR1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbjEOR1R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:27:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D28210A12
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D32C62CEE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A97C433EF;
        Mon, 15 May 2023 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171541;
        bh=bMM3M3/6iaUkQz5bnBelOCDckOMOPVJg0H7sSqX7GwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssePoZqc47mcNOMVli2bajHrx51u9WDup3eNqOwo7FAtakjxWV2N5Ie1Z2Pl4xII5
         5Seqp5BbuErh+3hHOzFFIzl0eUEj7LE0aNzAnicZFhs0wOfXpBrRVEMX/kNindAS5f
         EblpI9eaGH3EPC42aZWb+ihapTb7ONYbamV/w0QQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.2 235/242] ext4: remove a BUG_ON in ext4_mb_release_group_pa()
Date:   Mon, 15 May 2023 18:29:21 +0200
Message-Id: <20230515161728.959268131@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 463808f237cf73e98a1a45ff7460c2406a150a0b upstream.

If a malicious fuzzer overwrites the ext4 superblock while it is
mounted such that the s_first_data_block is set to a very large
number, the calculation of the block group can underflow, and trigger
a BUG_ON check.  Change this to be an ext4_warning so that we don't
crash the kernel.

Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20230430154311.579720-3-tytso@mit.edu
Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4820,7 +4820,11 @@ ext4_mb_release_group_pa(struct ext4_bud
 	trace_ext4_mb_release_group_pa(sb, pa);
 	BUG_ON(pa->pa_deleted == 0);
 	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
-	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
+	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
+		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
+			     e4b->bd_group, group, pa->pa_pstart);
+		return 0;
+	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);


