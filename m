Return-Path: <stable+bounces-105433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C629F9781
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C9A160CCE
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C021A44E;
	Fri, 20 Dec 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU47C78d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0B1853;
	Fri, 20 Dec 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714693; cv=none; b=VyEZOMD9hDZL1ogadp5xg+D4KSBf0Drsz/qrpG7kOYVAKINl3Pb3f8zz+gqz1FocHUF3583Wc3UwEDnrBS0ngYZdCQwMyqBlfJpXGmqz8JN4HsYalkzrK8WaEAm3io2nX9BFC+DZxSppjVJU/Gzf623vWZB5OlqkXs5IEMyMjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714693; c=relaxed/simple;
	bh=a/mmhGrEzb5373DDRY9uU4VV1DaUT4hipb16YyZfKW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H20Z2Ey3UFFLFIR6440X2/Xl4KAEOStM2CuH0S2wS/MeesJMfdo/Ki8FfZrjTUFNUeUhVchijuk8EhwhedFvmelo2zncgrSdUBfdFPQ7N0WLzHw/xM1TTymWYW2xbYWYFS4J+zpx/+zlgdqXdDuMht/2RLMAEUI5On6C2I9utvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU47C78d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DAEC4CECD;
	Fri, 20 Dec 2024 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714693;
	bh=a/mmhGrEzb5373DDRY9uU4VV1DaUT4hipb16YyZfKW0=;
	h=From:To:Cc:Subject:Date:From;
	b=EU47C78dPWmmqI39Q0nMCprd1lKBw8niW1uE+jqb9Z3K4VVXrfZJQBTCUBSsuW+tJ
	 wZm4GguVDeId8jre8RQeL1xgGCNXU/cqSIVJw1xN5+r+NI+uo0U0Uv/ILWtQn/MsYG
	 Cvx5ZcXAbTlRlG/CjuMH9G73SBuHY5DEJdqS/g4O42mmFvC8g5o+eCW06B25MTC9PS
	 0qCDKRw8NzqSSLIbr4tw0+4Udm4i7c4JzMGtEoXEMF2YnudEE/yEhejKKJpdbkoTOe
	 s7uvGtVFPTumM8jnzFnL1dcMQTW3uEvdd6Pnh4RjDCpmPG3M/5hbyEjh2Ulw3wWqe0
	 iU/dtbtLY6fgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/29] perf/x86/intel: Add Arrow Lake U support
Date: Fri, 20 Dec 2024 12:11:02 -0500
Message-Id: <20241220171130.511389-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 4e54ed496343702837ddca5f5af720161c6a5407 ]

From PMU's perspective, the new Arrow Lake U is the same as the
Meteor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241121180526.2364759-1-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d879478db3f5..5e6dc07c298c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7057,6 +7057,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
+	case INTEL_ARROWLAKE_U:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;
-- 
2.39.5


