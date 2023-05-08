Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00F86FAB92
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjEHLOz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjEHLOx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:14:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE53656A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EBFE62BAE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C1C433EF;
        Mon,  8 May 2023 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544491;
        bh=515YoEgZZ/ABmXF/5cW49bGIDlpvMojKx5q1APCPmy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nto1ZeMXe1gCDfsebSsulRhi2/iqX/kbCjkTq4KK85QZGfnBg4Ub45WeuUMACVn6U
         Gs57BpB3HqW4Whvwk7hoQMJWD2l9gbL2Bl8Txqof8yYAeEDyelhFsOUU8OucGFvPvV
         zTF2UCt5wlEir0Sn1MJQip9dgAIui5zbt6DZO2GE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 428/694] jdb2: Dont refuse invalidation of already invalidated buffers
Date:   Mon,  8 May 2023 11:44:23 +0200
Message-Id: <20230508094447.237940761@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit bd159398a2d2234de07d310132865706964aaaa7 ]

When invalidating buffers under the partial tail page,
jbd2_journal_invalidate_folio() returns -EBUSY if the buffer is part of
the committing transaction as we cannot safely modify buffer state.
However if the buffer is already invalidated (due to previous
invalidation attempts from ext4_wait_for_tail_page_commit()), there's
nothing to do and there's no point in returning -EBUSY. This fixes
occasional warnings from ext4_journalled_invalidate_folio() triggered by
generic/051 fstest when blocksize < pagesize.

Fixes: 53e872681fed ("ext4: fix deadlock in journal_unmap_buffer()")
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230329154950.19720-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 15de1385012eb..18611241f4513 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2387,6 +2387,9 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			spin_unlock(&jh->b_state_lock);
 			write_unlock(&journal->j_state_lock);
 			jbd2_journal_put_journal_head(jh);
+			/* Already zapped buffer? Nothing to do... */
+			if (!bh->b_bdev)
+				return 0;
 			return -EBUSY;
 		}
 		/*
-- 
2.39.2



