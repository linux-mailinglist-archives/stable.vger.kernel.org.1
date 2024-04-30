Return-Path: <stable+bounces-42569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00AD8B739F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DB1C23286
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFD12CDAE;
	Tue, 30 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DPCg/c3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893612C805;
	Tue, 30 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476085; cv=none; b=dmVXPwieT4ICc87UXawNCY1Jb1sSNwUzbX8L8+EEZxXoNtigvJcFhK1LG9Wp17+V7n0KDqt75+SxnSU76gX8xXYXUz+jX79rfM4iYvJs8mcLnMx3Jxh36CbkfxpJaRaCAf+xCxOoqX68t86UqH1avGe50ThKSkzH4JSeVrz7dVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476085; c=relaxed/simple;
	bh=p4txSBRjcjDbN5gWr0dPHdiXRsMhc9nhqNUEs/8oFUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCoQv1iMacpBZSf4hMTmydoN+udrxpUEAwXwu7eUMXrYz9go1ARgvMCCIhHyKljQXWCA0PTSw3tbQJ6b3MIrGYUyHICMOmxXkf2sx8HNc5W43MEpzwBeahd0Fs7kfvQPG3NJWy7azCYt8KD8rPLwJBpPN0SQ/qZe/qoO7KPm6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DPCg/c3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCC9C2BBFC;
	Tue, 30 Apr 2024 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476084;
	bh=p4txSBRjcjDbN5gWr0dPHdiXRsMhc9nhqNUEs/8oFUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPCg/c3uftG/CKPVLl5LiEu09d0QynM8QN5g/8/1dwaXBneDmWXf3gKCm+/5Nvfdl
	 GvU7ehwSkyraYnDnQMmkHoBePHTNLTjaoY70MjmpQB7KtMVdTLc3zJX2txqthZkDv2
	 K6b8qN6029rV1HmN65LfGvNe4P54YX0Xl0AZFJ+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 029/107] clk: Mark all_lists as const
Date: Tue, 30 Apr 2024 12:39:49 +0200
Message-ID: <20240430103045.521998640@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103044.655968143@linuxfoundation.org>
References: <20240430103044.655968143@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit 75061a6ff49ba3482c6319ded0c26e6a526b0967 ]

This list array doesn't change at runtime. Mark it const to move to RO
memory.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20220217220554.2711696-2-sboyd@kernel.org
Stable-dep-of: e581cf5d2162 ("clk: Get runtime PM before walking tree during disable_unused")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 85a043e8a9d57..f9d89b42b8f9d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -37,7 +37,7 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
-static struct hlist_head *all_lists[] = {
+static const struct hlist_head *all_lists[] = {
 	&clk_root_list,
 	&clk_orphan_list,
 	NULL,
@@ -3940,7 +3940,7 @@ static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
 /* Remove this clk from all parent caches */
 static void clk_core_evict_parent_cache(struct clk_core *core)
 {
-	struct hlist_head **lists;
+	const struct hlist_head **lists;
 	struct clk_core *root;
 
 	lockdep_assert_held(&prepare_lock);
-- 
2.43.0




