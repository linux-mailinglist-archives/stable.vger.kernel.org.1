Return-Path: <stable+bounces-180809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1E8B8DC62
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096367B1AA0
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF54A1A;
	Sun, 21 Sep 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv5JSQVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DAA2D780A
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461862; cv=none; b=KeFc1/KPyZE8w3zsRVUsI+6WZDX9qoy9h0V+kcy71kKIGQRf4J8VimPhfM9/oLPQXsndHaGHmwA25E5lOqhA+fwYoEHUdKm2/DwyPo1ori4tEHRWeqHGQe4qaXbUCgYh5o/hqLz0FLfZdbyKVt7kHt3Z/SJZB+ZSVEgwmGMqZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461862; c=relaxed/simple;
	bh=DcDiMDsm8Y0lQnUW9LEt2qzEbD+wYpr0BYA/6UitqLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDIdy3NgF3X+jbBgMNrFgVmPFjCFB7qYusAwDXCZu3Us2XtCtrriMZDurO5JP9dBXoZy5o2qP5ZKBOQAYeOmzUVD3nPLJ3DPbGT/yJm+5EIPt32tWtVvhCIizP2cKtKU7BD3hLcbKyR5KVW+4BEQmxDrhpwRZvYQtq5JVKer83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv5JSQVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA02C4CEE7;
	Sun, 21 Sep 2025 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461862;
	bh=DcDiMDsm8Y0lQnUW9LEt2qzEbD+wYpr0BYA/6UitqLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fv5JSQVpm5slDr9+iIbMzuT4fHDFXWu9G/Iz6U1TA5GjjuHJ8ew10AVQztlVIBxCZ
	 GNGgQ+wYqQmBb1s+DQ+7XjJ6moyjsMuSaTbnVpGcyafBGEWioeIYy7nQ7mICIr8qrM
	 wtlzR/9KwirEUmc0LRFzsZD+/pMFfuMDtBq0y6aXXf8G8qrUowA99Rjx2DO72d+BMO
	 plk6AjkzX2jPUIrLug96LJwTMR9mCZl4UChCToKRfvGMPPENa14MbkHhUUS7c7iO9y
	 Woq2X+luVm/2vXW4Ky/bP4t1D8mav0uBl8pMc+IEG6Jj5duQsGT3oGGMZWOpMyxzfi
	 yM83YZnVbKYgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] samples/damon/wsse: avoid starting DAMON before initialization
Date: Sun, 21 Sep 2025 09:37:38 -0400
Message-ID: <20250921133738.2911582-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921133738.2911582-1-sashal@kernel.org>
References: <2025092111-specked-enviably-906d@gregkh>
 <20250921133738.2911582-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit f826edeb888c5a8bd1b6e95ae6a50b0db2b21902 ]

Patch series "samples/damon: fix boot time enable handling fixup merge
mistakes".

First three patches of the patch series "mm/damon: fix misc bugs in DAMON
modules" [1] were trying to fix boot time DAMON sample modules enabling
issues.  The issues are the modules can crash if those are enabled before
DAMON is enabled, like using boot time parameter options.  The three
patches were fixing the issues by avoiding starting DAMON before the
module initialization phase.

However, probably by a mistake during a merge, only half of the change is
merged, and the part for avoiding the starting of DAMON before the module
initialized is missed.  So the problem is not solved and thus the modules
can still crash if enabled before DAMON is initialized.  Fix those by
applying the unmerged parts again.

Note that the broken commits are merged into 6.17-rc1, but also backported
to relevant stable kernels.  So this series also needs to be merged into
the stable kernels.  Hence Cc-ing stable@.

This patch (of 3):

Commit 0ed1165c3727 ("samples/damon/wsse: fix boot time enable handling")
is somehow incompletely applying the origin patch [2].  It is missing the
part that avoids starting DAMON before module initialization.  Probably a
mistake during a merge has happened.  Fix it by applying the missed part
again.

Link: https://lkml.kernel.org/r/20250909022238.2989-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20250909022238.2989-2-sj@kernel.org
Link: https://lkml.kernel.org/r/20250706193207.39810-1-sj@kernel.org [1]
Link: https://lore.kernel.org/20250706193207.39810-2-sj@kernel.org [2]
Fixes: 0ed1165c3727 ("samples/damon/wsse: fix boot time enable handling")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/damon/wsse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index d50730ee65a7e..c434851d511e9 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -105,6 +105,9 @@ static int damon_sample_wsse_enable_store(
 		return 0;
 
 	if (enabled) {
+		if (!init_called)
+			return 0;
+
 		err = damon_sample_wsse_start();
 		if (err)
 			enabled = false;
-- 
2.51.0


