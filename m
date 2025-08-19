Return-Path: <stable+bounces-171698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F0B2B5C2
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589E2196221F
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448719ABC6;
	Tue, 19 Aug 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP+JUmgo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033247261A
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566135; cv=none; b=V6xbKc3ZTe2ZYmqi+5Cqyk3G2iLmmO3SQUjmobhHFXhoWUc0Ey8vxtaYv4wmsL8L8RhjQ3abPwX+BQeTUTbMnlW2osc9XA+uDbeE3gIRD1V8vomQUZWa/kCdzvjfhYy6veOTkF59J6YndyBPWs0L4IhN1zVwd3XX1kseh/xw4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566135; c=relaxed/simple;
	bh=YKBUZFNc5VrctlBFCWaEtPimNLgB9xqUpMRbmYQ6gaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7EwHU+x9ir/wzVM8vjhG3I2E2RpX11bJCdNsfk2EV8aElc98pW0O8qom5//UTeqNPkPs7IQQ1wtIoErz7eFnLLh6PSwqpfQA4Yx2I4Jw+e2E6S0DnOFE6AdSfiilB7+d98hUzTyLg27JkTBP6xkLtaAweeq0V+0ExJ6Z1CbEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP+JUmgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EBBC113D0;
	Tue, 19 Aug 2025 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566134;
	bh=YKBUZFNc5VrctlBFCWaEtPimNLgB9xqUpMRbmYQ6gaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NP+JUmgognxV2QqTtGTGnOJsGVU8A8+G93mtodd6hrwQwJMWZXLDodp6KUCfgroEX
	 8ZszUnXYSBdxj76/hVNpOlKEFGXk0EEGqnfm/MR0L4sGB72m+veGjUILA/Cvy12oia
	 mjC511zrz822Z3MoR/F+VFkXrGe22StawU96whabppJE3KFDtmni502ya6TpkXqFXF
	 iiv3wouTAMsTWxj9xN+aECMkJUnx/HVVj2y2wqnnlo5vprSw0P7yF2T88YfRzuHNbA
	 WkAk1Pa9v1BmBe763vpgD1hiiOX+BWYVzp1mFoO4Zg1m0v/nYdQUUmEe7FwMTo2rIs
	 X5C1Cwzm7IT4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/4] btrfs: add comment for optimization in free_extent_buffer()
Date: Mon, 18 Aug 2025 21:15:29 -0400
Message-ID: <20250819011531.242846-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819011531.242846-1-sashal@kernel.org>
References: <2025081814-monsoon-supermom-44bb@gregkh>
 <20250819011531.242846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 2697b6159744e5afae0f7715da9f830ba6f9e45a ]

There's this special atomic compare and exchange logic which serves to
avoid locking the extent buffers refs_lock spinlock and therefore reduce
lock contention, so add a comment to make it more obvious.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8590f8a4a139..9cf37693d609 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3493,6 +3493,7 @@ void free_extent_buffer(struct extent_buffer *eb)
 			break;
 		}
 
+		/* Optimization to avoid locking eb->refs_lock. */
 		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
 			return;
 	}
-- 
2.50.1


