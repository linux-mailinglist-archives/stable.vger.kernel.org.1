Return-Path: <stable+bounces-183323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C3BB8143
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB9F4C5A76
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E523AB94;
	Fri,  3 Oct 2025 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqNiRg7n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E21FBEAC;
	Fri,  3 Oct 2025 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522511; cv=none; b=jE57vQGsF5ROg6TK+ZM6TLXRcI5XL6Qxjp+xTinpiwpSnNacNhebsXInwDDwVcGwe2tti2INsP7Z5ra+l5qLKwG5hwtatNspBTWbmtCUAuRFauiDNwoKljYZSnDI3WfkwMvXpntYqvd4B2A82buuC1OoRPIoO5vX6TPUPw/wgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522511; c=relaxed/simple;
	bh=qtfz/YfEllIXjoRI/HBAplZP1lyB8MYFrVrD1QnzyoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EL1QAd91VO5ha317KY2MULzP2ZfTlDCEXfHry+VcqFeLpbg4dulgR7GS3wJC0PYAPv5XuVrZFj5ge/JtYwRLQyXCFJyXEaAGCzdnoQqm+8n+V3eoqhP3Q2r2WE7vNkycvFvsAUaE/6RRtbR3nUfz+eyn49mkfwCKFVp0ExQY/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqNiRg7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D740AC4CEF5;
	Fri,  3 Oct 2025 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759522511;
	bh=qtfz/YfEllIXjoRI/HBAplZP1lyB8MYFrVrD1QnzyoE=;
	h=From:To:Cc:Subject:Date:From;
	b=VqNiRg7nMuR+dDDL6d31WcMOXqHyGxsxV+xYD53aX9znF5dxsB3RypkLd+rWv1ovr
	 RRJCZ6Zfr3pEhrWCK+GKaXKLoMDgbM/p5qwRtlUZ77dfaS31ARj5iXv5m3gBvyYbs2
	 FWRSPSxWZpAkqB1PpcDNyP4GX9kuJSm3hDAamesOxnrpfJEY5JVpiNTaBFn6mE4wx4
	 5hKmMn+wEaLtaKQ4Vs35mZtrLTd/hcMVXKjz9badoLpFXiktjsppsy9bP0ibgP5IyE
	 CMwK8XANfTZlEbGFX+w/U//NY6eI9FMXPumY4UptgsfkYNKIrNV0UuZ1K+Hi9avsB1
	 +72RZ+7AgHEdQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/sysfs: fix commit test damon_ctx [de]allocation
Date: Fri,  3 Oct 2025 13:14:53 -0700
Message-Id: <20251003201455.41448-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface dynamically allocates and uses a damon_ctx object
for testing if given inputs for online DAMON parameters update is valid.
The object is being used without an allocation failure check, and leaked
when the test succeeds.  Fix the two bugs.

SeongJae Park (2):
  mm/damon/sysfs: catch commit test ctx alloc failure
  mm/damon/sysfs: dealloc commit test ctx always

 mm/damon/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)


base-commit: 3c39180d389ca58cf309b7aa58b6a3617151c226
-- 
2.39.5

