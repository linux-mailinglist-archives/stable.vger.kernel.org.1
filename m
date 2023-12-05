Return-Path: <stable+bounces-4381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F94280473F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994A0B20C75
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F38BF2;
	Tue,  5 Dec 2023 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F42X0QMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD56FB1;
	Tue,  5 Dec 2023 03:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D581C433C7;
	Tue,  5 Dec 2023 03:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747392;
	bh=ek9h/DlBnedH/VtwyMHB8d/tRmHQfvvqDVCZSByIZuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F42X0QMg335bXfdhMEjepKrIaqYldn76UOjfOGN2Q5oKrwndBB/DFlhtvcx/DFC+/
	 4OKhvdoOiWf6wRa2wxa3qWd8ZNV3Iyc+89Vfo/1Gg/TBPVJ6d8Ch+LqgJQauV9MGIu
	 Jq4BqjRblqaGfW7zsOGb9ogR4VipTYye3qOuUr9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 035/135] lockdep: Fix block chain corruption
Date: Tue,  5 Dec 2023 12:15:56 +0900
Message-ID: <20231205031532.882473089@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit bca4104b00fec60be330cd32818dd5c70db3d469 ]

Kent reported an occasional KASAN splat in lockdep. Mark then noted:

> I suspect the dodgy access is to chain_block_buckets[-1], which hits the last 4
> bytes of the redzone and gets (incorrectly/misleadingly) attributed to
> nr_large_chain_blocks.

That would mean @size == 0, at which point size_to_bucket() returns -1
and the above happens.

alloc_chain_hlocks() has 'size - req', for the first with the
precondition 'size >= rq', which allows the 0.

This code is trying to split a block, del_chain_block() takes what we
need, and add_chain_block() puts back the remainder, except in the
above case the remainder is 0 sized and things go sideways.

Fixes: 810507fe6fd5 ("locking/lockdep: Reuse freed chain_hlocks entries")
Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kent Overstreet <kent.overstreet@linux.dev>
Link: https://lkml.kernel.org/r/20231121114126.GH8262@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6cbd2b4444769..7471d85f54ae5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3357,7 +3357,8 @@ static int alloc_chain_hlocks(int req)
 		size = chain_block_size(curr);
 		if (likely(size >= req)) {
 			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
+			if (size > req)
+				add_chain_block(curr + req, size - req);
 			return curr;
 		}
 	}
-- 
2.42.0




