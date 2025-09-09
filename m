Return-Path: <stable+bounces-179008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D869AB49F27
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061941BC3F4C
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 02:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B72571C5;
	Tue,  9 Sep 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGDFUtKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A797256C84;
	Tue,  9 Sep 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384565; cv=none; b=ib3hw/rbf8e7Hcw/XCvq9vDjbMy28odc2OgezJpHj17v+qiWxlC5s5/DNnw2UuIjhncJkXhxw22+7ZVsjLMLCE5KjuNyg4ZlTX6vZautlsYnutibna3szqdlHqqc9VeWxexghn2P/892UcbcXZPzwHAPyD3EKN1R0p+mHlOiM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384565; c=relaxed/simple;
	bh=CB5KTCrWLMEdIF9ZzZSCMis1Zik0Tvcul4qLyUj2Xrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDMnZiWQi/iRHcpTdGsBVVKxkwlOJHCgX2r0hg+y6/lkBLWLMrent4pFbU6HkSYhg21Zbs5Xz0+P4ygDL7gFzVZAgw5R7kweg8bk6Nqfe2exM3cI56BSoIWuMPftWD4KCQjcILznOvCaKKQyFhAhfo5GHZtxcLmDM9atK9DdLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGDFUtKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01951C4CEF8;
	Tue,  9 Sep 2025 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384565;
	bh=CB5KTCrWLMEdIF9ZzZSCMis1Zik0Tvcul4qLyUj2Xrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGDFUtKyB2aBLklonbKqRX1K/OAwoFApnAAISTqDhc3Z65P5N01TsAk+x46RRDyER
	 SjzbfPnU3GKG/8DK9KPAeuhuV+j/XMIEkoX/Eqd+KdhETEkjrDTWpCKSXQ7Kp+q6DM
	 iWx3/E8YYW57igz2Rew49DmXqvQyH+SuJf0uqBLXP+41qQJFy0GkF+nvwcdNha86wu
	 ewGzVsz4Rmf8PlY55nv79k4NwScDJdlzghmCojMoz+3Dp528wuX3W0kn0Lu3QYqKKt
	 NyFbKoSuZANRagwvcx12ZXolv4MHUPCCaKTT0NxhHS4SQsEG9IlRjPjpdguqOMqyZE
	 i4w+y9XloLzJg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17-rc1" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] samples/damon/mtier: avoid starting DAMON before initialization
Date: Mon,  8 Sep 2025 19:22:38 -0700
Message-Id: <20250909022238.2989-4-sj@kernel.org>
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

Commit 964314344eab ("samples/damon/mtier: support boot time enable
setup") is somehow incompletely applying the origin patch [1].  It is
missing the part that avoids starting DAMON before module
initialization.  Probably a mistake during a merge has happened.  Fix it
by applying the missed part again.

[1] https://lore.kernel.org/20250706193207.39810-4-sj@kernel.org

Fixes: 964314344eab ("samples/damon/mtier: support boot time enable setup")
Cc: <stable@vger.kernel.org> # 6.17-rc1
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 7ebd352138e4..beaf36657dea 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -208,6 +208,9 @@ static int damon_sample_mtier_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-- 
2.39.5

