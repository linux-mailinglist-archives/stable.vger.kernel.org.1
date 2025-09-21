Return-Path: <stable+bounces-180813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60889B8DCD3
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B821899425
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85D2D8378;
	Sun, 21 Sep 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN2lfzRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375E34BA28
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463883; cv=none; b=KwE2ey2p/PjvLyaF8m9WrOD02J/xJi0QyOC4XEMIyMtodk1Yahgj/L/Pz2XhLp23sr9ghWIzpTHWEg4mnKrme9P+hTVGsTzYjc+L0+GDZYClnLSoa8m5Haqcx/XnKMx2lKrEunQzSbGXDtuXINB75EQamYMNZohdMefY/fPnDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463883; c=relaxed/simple;
	bh=Vh46aiRKgplGqUayNQaPARwsDwRbY32MzqdLa16/Ld4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7KqYlqfILBf/75/nJtKv6+C9Nxp2gt/j5S44iMFadK6qK0A8SGsvrKc5+vghCXcj1YYUUapVB8FrxXLBVu/+/kJs/az5ztQ87hrXL+gYltc1OEqkAqQAt4Bi2XsBMhOsDJEFNkdbYfEJ23NlPQEXaN2qq8yCRgs7jjjU8m6NZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN2lfzRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F13EC116C6;
	Sun, 21 Sep 2025 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758463883;
	bh=Vh46aiRKgplGqUayNQaPARwsDwRbY32MzqdLa16/Ld4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pN2lfzRnXP2xHiQkdB+J32ofXk5gwPHiu9Q6g9pJ4xE0DD4R8zfp5FovAbJ5xlczB
	 +3K/duKteKsg4jDLueLnPvzydoM5kiEDJyLxP1hY2xfPLw5PaO4bxD434KcNUTWcHK
	 8zuMQUkorUTsU5EU4tnR5IujpzKQTa81SGzGb5MrLm2E2FMiYFt812xjxju0x8ttwE
	 EZ63YAorH997ZeB8SnOzpuMkvB0RPwm8bElnCTyuEUYM09wDQ06Q1yg835YPFknKXV
	 upim7RjCxi850R0J1XH7mYY3rLO2nlC+gQJ4c6NRKBUJ/mHWOvGPTCaG7rkMDZXfyh
	 UdN4lwR5oBLlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] samples/damon/mtier: avoid starting DAMON before initialization
Date: Sun, 21 Sep 2025 10:11:19 -0400
Message-ID: <20250921141119.2917725-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921141119.2917725-1-sashal@kernel.org>
References: <2025092116-ceramics-stratus-5d18@gregkh>
 <20250921141119.2917725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit c62cff40481c037307a13becbda795f7afdcfebd ]

Commit 964314344eab ("samples/damon/mtier: support boot time enable
setup") is somehow incompletely applying the origin patch [1].  It is
missing the part that avoids starting DAMON before module initialization.
Probably a mistake during a merge has happened.  Fix it by applying the
missed part again.

Link: https://lkml.kernel.org/r/20250909022238.2989-4-sj@kernel.org
Link: https://lore.kernel.org/20250706193207.39810-4-sj@kernel.org [1]
Fixes: 964314344eab ("samples/damon/mtier: support boot time enable setup")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 11cbfea1af675..88156145172f1 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -166,6 +166,9 @@ static int damon_sample_mtier_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-- 
2.51.0


