Return-Path: <stable+bounces-141458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E86BAAB387
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED98170E88
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056B298271;
	Tue,  6 May 2025 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgpYSeLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE51239E89;
	Mon,  5 May 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486359; cv=none; b=tHG2icB8xs/RjsotQN+CRr8a1hKP9u3vEp9VHxQ8ho7W7czREhvUgOF9i6PW/igOxoMb6YBsMTwqLlaF+VOPeSEvAaQUfY2WqcjZ+HA32yyEGHGmi39lxLOUtgkguyEsKWCYAeRlQ6ymRM6R6BKQ1dDSJ2Cd77eTRdjFpmxC6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486359; c=relaxed/simple;
	bh=+mZAvTDf4lljc6lIkQQj9jtGcjET6YW7WsFqVIF/1yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szC+7XnxS53Q3H5gtwrdW2oxGqBXSVkzFh9b4rf/6xmx4scFeSoM33LdjxIL/yXT7CyHyObqTN2K6FJ5WdIalJFCtjrUr3hhrdkLk0qYr6/F6XyN5cPKXqbYxBOppuXvk1uduqARBFfYJ+eqmNbZd/m4nvBGY4gEMO7TbRjW74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgpYSeLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12731C4CEE4;
	Mon,  5 May 2025 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486358;
	bh=+mZAvTDf4lljc6lIkQQj9jtGcjET6YW7WsFqVIF/1yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgpYSeLTCl6p6V5HsV/ZON8P/KkThcAFCWITi7HTA3TPuSGEQBaO3/Tae0+8Tr7H3
	 Pa5tl79Kn5EVad1cmgbg9iyG+Bah6TXLetA6iKkZY4KWhSuQFCKdIokGD57gOtsicj
	 tHRAHX0JrOI9Z4aSLR7hQXf4+0KJUqkHWq14ItmkUqR+ndnLMXvn4KgbgNnr+HUHKY
	 t/bsVQm9CV0RWUDzXPrnEi8n3xbTfjFU9A5QsL1vDW51TtNkrm1JfdEIIcjC2vOrkl
	 S61B6nfm0l6VrNFkflbgfw27wPP8oqG8l+3B9XRu1P78hPfQOaheCgvmLpVGV40yEz
	 i0aBEgA0YLIvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 279/294] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Date: Mon,  5 May 2025 18:56:19 -0400
Message-Id: <20250505225634.2688578-279-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit 46dcf85566170d4528b842bf83ffc350d71771fa ]

IBS Op uses two counters: MaxCnt and CurCnt. MaxCnt is programmed with
the desired sample period. IBS hw generates sample when CurCnt reaches
to MaxCnt. The size of these counter used to be 20 bits but later they
were extended to 27 bits. The 7 bit extension is indicated by CPUID
Fn8000_001B_EAX[6 / OpCntExt].

perf_ibs->cnt_mask variable contains bit masks for MaxCnt and CurCnt.
But IBS driver does not set upper 7 bits of CurCnt in cnt_mask even
when OpCntExt CPUID bit is set. Fix this.

IBS driver uses cnt_mask[CurCnt] bits only while disabling an event.
Fortunately, CurCnt bits are not read from MSR while re-enabling the
event, instead MaxCnt is programmed with desired period and CurCnt is
set to 0. Hence, we did not see any issues so far.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-5-ravi.bangoria@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/ibs.c         | 3 ++-
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f483874fa20f1..85731f121feb5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1219,7 +1219,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 384e8a7db4827..ba2a3935dc624 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -501,6 +501,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
-- 
2.39.5


