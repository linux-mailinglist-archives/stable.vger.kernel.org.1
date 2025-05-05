Return-Path: <stable+bounces-140332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F6AAA79C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048F116A8A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209BB33CC75;
	Mon,  5 May 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsxVU75m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32C33CC6C;
	Mon,  5 May 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484649; cv=none; b=RG/XNWT1wq96EPVqptq8JOSSP4r4LI2DRcGWe6AhwGOT5BYAKO8zDhif0lLf02OzwKSSwZXrPuygBNQPSCon6JKrIunWONhG2lV79r+H2bRs8kd3V5mtlqBEgrT3r97PUg6T6XJY2gGyHuj+bzdF+2bkLCUJKFhwLZ8wF573+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484649; c=relaxed/simple;
	bh=v5IvEfryJ1AT+Qpk4h/gIHPnhL2txwlgWoaZAXpcqdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E5IarWaPbS0ZznG94pKCP6EVPta4ylY7rEScO7oH32ZEkYoOwp6ZB0dzvz/zydvQipilUuX3hPEZyuF9DMcRAx0MTnbn74DLX6j5xHEeZKJ6QNMWwoyAwTt6fiHPaTLUBxWjhZp4BpMJ6+2u5TfFsMFcXITbdoTe5kJKNQcs/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsxVU75m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5D5C4CEED;
	Mon,  5 May 2025 22:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484649;
	bh=v5IvEfryJ1AT+Qpk4h/gIHPnhL2txwlgWoaZAXpcqdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsxVU75m25hy9ljG5l7V3nt3Gl7HYqWbBDH+VSuXCcTG8KNd/q9RY7teECw1yQ2LR
	 f1X+QOIHc+YrptGM5LNAs+PZxwgSoGyC/cw41QXoZef+hxbynlYH3K66henWQXP15C
	 BzRUdbIBl7Adieym02+qpzkQUsD/YgIFckPTfzGZt30eNZCmFRCde5phVR58Norvb4
	 0x3otBvyFDGRBDAIzUkDzTP1KyMCvAMzs6eX3QcCef4jpGm2C9gYY74YPIwgArRkAK
	 23JryzU54dZ/8ygfsvm8nGM+pVXE6xpdqOC3P7qGAJUXwto6/fVSleJH5Zeito7s/z
	 oOwoKNgnbvsPw==
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
Subject: [PATCH AUTOSEL 6.14 583/642] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Date: Mon,  5 May 2025 18:13:19 -0400
Message-Id: <20250505221419.2672473-583-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e36c9c63c97cc..5d975c39701cb 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1318,7 +1318,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0ba8d20f2d1d5..d37c1c32e74b9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -536,6 +536,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
-- 
2.39.5


