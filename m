Return-Path: <stable+bounces-106716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58693A00C9A
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266C916451D
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3DA1FAC57;
	Fri,  3 Jan 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIf7RanJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387D12C499;
	Fri,  3 Jan 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924670; cv=none; b=actGxLWQrflBgHgF1tIJTOuuUo1p60FhylDE6tsYJUhCVoQ1NfHjfSWWzL8JnB4OtgmZIfgUkwglZ5eMBOkg3RHJPQlIl2RhY9ODrgMhxIs+Ee6NwCThDXILC+f6CS8QEv2bf4CohcZ4kXpjkaVIvs3Eq8OMukpU5c+7ltTk64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924670; c=relaxed/simple;
	bh=lrvfhLvsWhVh8vTC8QXkYxmNihN0CivEa+G/I+yJ8r8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7f+YZ96k+XYfPu3Z1E+3QoikSllafCXBG+8PzZeVDjNwY7HEcxubQonaubniyJ+vQ36IouDcOINfL3bEVRJaDn1Z6i1WzbJXQm5LbGUegzkVAV3SUbq2V6IzfnkoU3GMxLj0tTn5OvGtv4e9LGod7Wlut0FDtpH4CmjYV25xxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIf7RanJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E253C4CECE;
	Fri,  3 Jan 2025 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924668;
	bh=lrvfhLvsWhVh8vTC8QXkYxmNihN0CivEa+G/I+yJ8r8=;
	h=From:To:Cc:Subject:Date:From;
	b=CIf7RanJJhjNXgjV4NoEWHCTtrWjBfL019KF8tjr4lvQ90r29L8dKb+J70lDZ//sp
	 ifmsbpLia5ru2LxaPGUDc+eemagKv3RvGErbCa0d9eCwmkAFfFsJMstDc/3+PMbCj+
	 f7dYC8aiWzykFe2iMCj1H5maXE9WlLu21wUwDCObMdpq36iKgN7+8aEcRoC7xlaNb+
	 jV5pWwhK+y1J/5K4Dcec8Mqce20G1y/nQS9+jsOxxgYKQxpmY5PKBVGBaUs2dk9hfH
	 qDlyLVUr9gfXG5lAavRBem5pYCLhtKvJDwqQmKDlRaiY8N5PJapcBYWHKPT6gkTe32
	 RfiM1mNytJXQQ==
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
Subject: [PATCH AUTOSEL 6.12 1/4] perf/x86/intel/uncore: Add Clearwater Forest support
Date: Fri,  3 Jan 2025 12:17:42 -0500
Message-Id: <20250103171746.492127-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit b6ccddd6fe1fd49c7a82b6fbed01cccad21a29c7 ]

From the perspective of the uncore PMU, the Clearwater Forest is the
same as the previous Sierra Forest. The only difference is the event
list, which will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241211161146.235253-1-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d98fac567684..e7aba7349231 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1910,6 +1910,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&gnr_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
-- 
2.39.5


