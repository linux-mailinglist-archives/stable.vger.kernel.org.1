Return-Path: <stable+bounces-179006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D59B49F23
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ACE1BC4BF1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031424EAB1;
	Tue,  9 Sep 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPzDToC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487424DCE9;
	Tue,  9 Sep 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384563; cv=none; b=cnPIyCBq08QvD1d1j9JNl9+Wn3x8t4XEN6hgyAFqR9oC65UPf2rRMQByqlbH9gZ5PDn1XoUAbfNuS/LfD764ub74zzIAYuTP2caondeO5oSuqvHz7+Rr3YJmRcDrvCMompuxy+VadN3YpU9HZjACXON2j6yzJ5rw5BDYvCI7jvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384563; c=relaxed/simple;
	bh=DHqTS3AzUjYGHdLzhzK2+dBwRPHotpFoyVLaW4sFFjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLDJtzGwnJfSA6QwfVg6ySNoSQ8CsL1spnwBp94yr6giXJqdsiZsKmXe9iNrjZPGgjUMlh2P8IvNRQ23ZOicrsTwwKyYin0POMZhmxEnoWKTYLoVKSmAu1+hMrE1zAeao3PwjoNzbLOt6D+AWG0a/1QNBiScU6Bu75Oq8ol5IIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPzDToC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB854C4CEF1;
	Tue,  9 Sep 2025 02:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384563;
	bh=DHqTS3AzUjYGHdLzhzK2+dBwRPHotpFoyVLaW4sFFjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPzDToC691DQi0WMja/yox6GhsLGehAPJrLbU4aKav/K0JwbbVH+XmLecKYHmwJ9y
	 ZDyHA//PDOfabF57QyqJQfms2JF7VrNzoyw1Nd2ohejk1fHE0ixbGm9APgWU1nJhnP
	 aYp9nnDwa4yl15YxOJcdsGCXffR3ZJq7Byj/BvNMTXX8FkPF2GClY6UQaqomc+aR3H
	 sr18Eb26hBMxjlml6lfk8jjHHfFK8L+S7yT7n98qnN93dBKVgZ3gnDO8OEA1Gw2t6+
	 jKI53vL7ntWYlxipnauHTDBULve+sjnmbtr2kyUfkqwvj0Enjm2FXZ6Ce6Jy9rwEUG
	 28rHW4+F5VQBQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17-rc1" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] samples/damon/wsse: avoid starting DAMON before initialization
Date: Mon,  8 Sep 2025 19:22:36 -0700
Message-Id: <20250909022238.2989-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909022238.2989-1-sj@kernel.org>
References: <20250909022238.2989-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0ed1165c3727 ("samples/damon/wsse: fix boot time enable
handling") is somehow incompletely applying the origin patch [1].  It is
missing the part that avoids starting DAMON before module
initialization.  Probably a mistake during a merge has happened.  Fix it
by applying the missed part again.

[1] https://lore.kernel.org/20250706193207.39810-2-sj@kernel.org

Fixes: 0ed1165c3727 ("samples/damon/wsse: fix boot time enable handling")
Cc: <stable@vger.kernel.org> # 6.17-rc1
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index da052023b099..21eaf15f987d 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -118,6 +118,9 @@ static int damon_sample_wsse_enable_store(
 		return 0;
 
 	if (enabled) {
+		if (!init_called)
+			return 0;
+
 		err = damon_sample_wsse_start();
 		if (err)
 			enabled = false;
-- 
2.39.5

