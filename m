Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2156D7039A4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbjEORog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbjEORoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC034C9EB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D1362E57
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4837AC433EF;
        Mon, 15 May 2023 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172512;
        bh=VTI1NBL+bA1K3E3BNiIU3+U//mjnGUdlJbe6G3k4vmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTNLOTekzfoZokXVFd8OZXsUgiua2W8Elk9mA7EIXMcx+3ZS6t4dEbFnG1eF5zWcn
         P27BqqpzW7hkkmKPPt/qI3V4cbdCiN6fJpi1yUCPOq8xdjESFSAZeydzCM5RTegN8x
         fVLap5DHHemS+4FRG/QhTMhZUO0RfNfkXmwPOgAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 178/381] jdb2: Dont refuse invalidation of already invalidated buffers
Date:   Mon, 15 May 2023 18:27:09 +0200
Message-Id: <20230515161744.863430369@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
index 1923528154b52..1baf2d607268f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2378,6 +2378,9 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
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



