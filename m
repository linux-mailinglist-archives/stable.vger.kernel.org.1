Return-Path: <stable+bounces-120126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE0A4C7A3
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7FA16C212
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16F251799;
	Mon,  3 Mar 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3gUlljn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAD2512F7;
	Mon,  3 Mar 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019458; cv=none; b=a2l5BeysqP01bQA1e/LSuIuKPyCiRb0ev5TwUok/i5yWJAI4LBXdMdab+MK60NoN72+7+DJu1gGq2JbegHdnFXrVuSLRk21Lts3hmkwd7TrLp2Yr+XoAGJzSl5kwoDS2O4svRxG0u6YGceBSkViiskH1Y9tTEamkiVQ4To9/kAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019458; c=relaxed/simple;
	bh=EcMoZDyhfEGwC7vuvbc89eWn4NI27qz5OwiisG3k6oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nd+urtoOQWbqDwI2JP/Eerg1CgTCPei/PUZ2pBePfh8QjY+Rio+cTISdODenFSOZKxCvvVweuHfLPcJWUrnvwf1qVfGHEbJ8d3HrdyqMdC/2Rv30KBiFZA7Md/p7r2GK8TcUDdmQiY55pRbH9ByI+fA3ps7I6pc0/N3JVJJ5k8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3gUlljn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7CDC4CEE4;
	Mon,  3 Mar 2025 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019458;
	bh=EcMoZDyhfEGwC7vuvbc89eWn4NI27qz5OwiisG3k6oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3gUlljng3NDojnl1yqJmWbEXGxnagbLGKlM/XlZf1B48O0kwgstA8vphF9/ymmw9
	 IQrYG+xFjwlbHP2KKBhePlFLnWuzStnfnjpd0lrwyQnSiKraCRnwP2DcwT98kMZnFW
	 PmOjyDgEQo7f90+Jy/ou2RswOmr4fid26oLIxnP1tPqRlZpWj8YqG31rM7NKbhitYO
	 5PM7TiwQaCrgP2m0jvIzN4xfx8X1wsaoJphu0YeNixr3SoS8/SIRwzzVb7vIsgztyF
	 EpQ2vZKM+g3KwypwTqaPf8KLugwaWuvTdpvoRMFObxmyXopKp/UcVzxiaVcJbVEAnz
	 YspNARflOb8YA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>,
	Ingo Molnar <mingo@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/17] perf/x86/rapl: Add support for Intel Arrow Lake U
Date: Mon,  3 Mar 2025 11:30:24 -0500
Message-Id: <20250303163031.3763651-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit 68a9b0e313302451468c0b0eda53c383fa51a8f4 ]

Add Arrow Lake U model for RAPL:

  $ ls -1 /sys/devices/power/events/
  energy-cores
  energy-cores.scale
  energy-cores.unit
  energy-gpu
  energy-gpu.scale
  energy-gpu.unit
  energy-pkg
  energy-pkg.scale
  energy-pkg.unit
  energy-psys
  energy-psys.scale
  energy-psys.unit

The same output as ArrowLake:

  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241224145516.349028-1-aaron.ma@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a481a939862e5..fc06b216aacdb 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -846,6 +846,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&model_skl),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
 	{},
 };
-- 
2.39.5


