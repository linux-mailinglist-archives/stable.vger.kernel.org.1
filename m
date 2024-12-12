Return-Path: <stable+bounces-102779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1C9EF547
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4244A189130A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE35229671;
	Thu, 12 Dec 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4F1CDLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DD216E14;
	Thu, 12 Dec 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022461; cv=none; b=AM/a4G+fZOER0aK1itXNxphoUSlGjh5cqW7LBRl5POIHaagw3A5PldWOHbsHnZNhT0LFpjusUZyf36eOdrpbuT0wioVCjQgM8J+Ga3NMGSSD56cdSEnWTn1USIPTQg9fy5a/kTEdFTsHuiWPxlbQg+cLVJLvtKKmmoeBDDiWKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022461; c=relaxed/simple;
	bh=SMXr52G3UIWNzMVCQNW15iletGQDmsNya3meIDXvhjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxP16AH04Eez9bFSoCAhz2xpv1MRDWVUnRRXSQS2RYL1mKl9u9JCjkKAGCMTk64dWj2TBD06w8kvAgXvSpUE4KZvjY08cIfepfPDyCGQeHcfwNwrKSfNzsIi9y8d0OMNRQJrdRnpEy3n/m6GDtcL/Ho00SolfNzcclaMRyOTAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4F1CDLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B324C4CED3;
	Thu, 12 Dec 2024 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022461;
	bh=SMXr52G3UIWNzMVCQNW15iletGQDmsNya3meIDXvhjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v4F1CDLFCEYWywrVcDsg+5aWJ3QauyWO7Af5lb5ecl8xHr/b6gYDnMoB9EAiKrV8l
	 yvDl6S7in9uYWa7Xt7NHTMalls+d+9IVpX7cw4EXyGIwp+Hx2ahCc18AMc4zvJbbTd
	 UNeBxaEUM47wXR3/RcZbfabf+RPXZnI0/QWw9PbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	LongPing Wei <weilongping@oppo.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 247/565] f2fs: fix the wrong f2fs_bug_on condition in f2fs_do_replace_block
Date: Thu, 12 Dec 2024 15:57:22 +0100
Message-ID: <20241212144321.238808444@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: LongPing Wei <weilongping@oppo.com>

[ Upstream commit c3af1f13476ec23fd99c98d060a89be28c1e8871 ]

This f2fs_bug_on was introduced by commit 2c1905042c8c ("f2fs: check
segment type in __f2fs_replace_block") when there were only 6 curseg types.
After commit d0b9e42ab615 ("f2fs: introduce inmem curseg") was introduced,
the condition should be changed to checking curseg->seg_type.

Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
Signed-off-by: LongPing Wei <weilongping@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dc33b4e5c07b8..9e6c4a475d6d0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3698,8 +3698,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		}
 	}
 
-	f2fs_bug_on(sbi, !IS_DATASEG(type));
 	curseg = CURSEG_I(sbi, type);
+	f2fs_bug_on(sbi, !IS_DATASEG(curseg->seg_type));
 
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&sit_i->sentry_lock);
-- 
2.43.0




