Return-Path: <stable+bounces-179005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119BB49F21
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4380B1BC3F32
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFADA24BCE8;
	Tue,  9 Sep 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGoYLtFY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D852236F0;
	Tue,  9 Sep 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384562; cv=none; b=QwTfOWE6Ny2vxAgBA394SSNwoTLrH2mPWq5udAT4bSts3/ry+myQcojOk5dE3czYuIpr7kcJbPYbVAeWTv6grvBQCnazZ7+7xmNvcjEP9nYttUXLLCVPJcFyYA6LscT9V5ZwF0VjoIvm2CqagHj3kKlXH7FPXAnnyN4T1sPRabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384562; c=relaxed/simple;
	bh=5FcWvlgWyOInwHI579PO6gvjZ+U3iPu1CVD7USdbcBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqmdO+d/yHoDj+pNLDK1fo1e0kPPNVxzYt1V4JDKseu4jDS77Tb3iKYsRpvqfKIW0G2abHKnUM/3KpqRgSDz6c36Li9P8OwFGmpk4w7GJlEyFQaQWfpzlLjxQjdRJcGuVTxNSMBd7DxwY7dscbypdge1g+HlZxUMY6ANLauLX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGoYLtFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA16C4CEF1;
	Tue,  9 Sep 2025 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384562;
	bh=5FcWvlgWyOInwHI579PO6gvjZ+U3iPu1CVD7USdbcBw=;
	h=From:To:Cc:Subject:Date:From;
	b=KGoYLtFYjHjbWDmLJGQO81FoqOdz/d15SfaS+VVI1GviATuBnf92TxqZjYlAriCH2
	 z8XI+OOZx2YEXZuh+D92EnvR9Wt/wvjo+xzMh+zVeoIch44J3tRVGhYcUnvspuy5WG
	 i9PfFTIFk/DIJXhy3MJgq/HIR9v6nhuFfxQ8cQJs59vxfcpnIQuOHHWixNQHnaypL0
	 YN5aNXRnGlMSZNBnPBEyW4kVpPD/mQRJyGuu5tXUo0ELl4mmyBaumg0U0gcmR1vwbF
	 +voUh6OOueya2hBF+VdCY1ikYozmElJKr7A+aozzURM5xLm8SidmGV6l6LKlV+OnOB
	 kBc9WMbhDfqqw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17-rc1" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] samples/damon: fix boot time enable handling fixup merge mistakes
Date: Mon,  8 Sep 2025 19:22:35 -0700
Message-Id: <20250909022238.2989-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First three patches of the patch series "mm/damon: fix misc bugs in
DAMON modules" [1] was trying to fix boot time DAMON sample modules
enabling issues by avoiding starting DAMON before the module
initialization phase.  However, probably by a mistake during a merge,
only half of the change is merged, and the part for avoiding the
starting of DAMON before the module initialized is missed.  So the
problem is not solved.  Fix those.

Note that the broken commits are merged into 6.17-rc1, but also
backported to relevant stable kernels.  So this series also need to be
merged into the stable kernels.  Hence Cc-ing stable@.

[1] https://lore.kernel.org/20250706193207.39810-1-sj@kernel.org

SeongJae Park (3):
  samples/damon/wsse: avoid starting DAMON before initialization
  samples/damon/prcl: avoid starting DAMON before initialization
  samples/damon/mtier: avoid starting DAMON before initialization

 samples/damon/mtier.c | 3 +++
 samples/damon/prcl.c  | 3 +++
 samples/damon/wsse.c  | 3 +++
 3 files changed, 9 insertions(+)


base-commit: 186951910f4e44e20738d85c0421032634ddb298
-- 
2.39.5

