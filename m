Return-Path: <stable+bounces-191586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E4C19733
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 206F0502AA4
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9E33469C;
	Wed, 29 Oct 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2YdzbxJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W0DU3Npm"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A133373F;
	Wed, 29 Oct 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730592; cv=none; b=Bk5dicKVZ3B5RXgLATfV2SRoaNSWsyKJl0J794PZQcs9WhcUxKkTzuxB5A2xx89zOBFi6O8upMwIlCtH2F4VziUv3kh5WNxv3aNZ7TszJXV+1iLmCZ3hDTBvkPRgrZLRzOWpp1jpbZNhhJaStcybfokU84wXicrzu8WmYGzkUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730592; c=relaxed/simple;
	bh=BUMrDGj2Xx6q803AxyaYx4UV+qdQiihdd2JAu2lUn8Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kq1qqRPUGaAw5CGQRcLiVvzTmOmVFptSdeIRjjbU7IWQy9lpU18C4oGOVsTogH7/ItyxZ5TfRYz0THNTTqirr6I5wKItjtCc8AOvhcWm+6z5nley9m9FTGjvrY63L3/XbXiHVQshvVDWz6tHz9wx07+FkmVRkUKMM9qLP7Pnatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2YdzbxJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W0DU3Npm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9mF0vDfuKHSECLDIIdkP/D+7STvekMCkPiEO7VlFis=;
	b=Q2YdzbxJsGR21iCNhGp9loAU2rBud9fIcBeDfMbumA1W1NiumX/RzhlbufSJw8Qa9/K1z8
	yx6hvgjHBrJ1uy3yp9zMJqPaoJ+UY6tTLzvFMLInkbCUGHhOA57wEdFxzwP4WKtf8Gb3zR
	fFzB3+lWoUob9tbPIpHiXNIgR0+ZVZPKgG3s46oXwsy0dROvRHLlSRNZt8Czi1rODOI7F+
	6X4w9gzjIbfWnjjNzadKKduZs8c/AGRIrvCjV7USqCmhVEgbT5vc85wA7aOkCuyYBUYoSj
	3fmS9+tDwRiAYirecjCr3bAHNaAY4/YzcHeVcr3wN2i6I2UvyjFr6/m7jEHT8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9mF0vDfuKHSECLDIIdkP/D+7STvekMCkPiEO7VlFis=;
	b=W0DU3NpmC1auzAxF3eRkKQHbm0KlO0yS1PwpOyk3VhwuAovSVI0q3oxtzHjL3Adt8JIcor
	95nmsF0m005fa2Bg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/intel: Fix KASAN global-out-of-bounds warning
Cc: Xudong Hao <xudong.hao@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Zide Chen <zide.chen@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251028064214.1451968-1-dapeng1.mi@linux.intel.com>
References: <20251028064214.1451968-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058788.2601451.12428693188880937245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0ba6502ce167fc3d598c08c2cc3b4ed7ca5aa251
Gitweb:        https://git.kernel.org/tip/0ba6502ce167fc3d598c08c2cc3b4ed7ca5=
aa251
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 28 Oct 2025 14:42:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:52 +01:00

perf/x86/intel: Fix KASAN global-out-of-bounds warning

When running "perf mem record" command on CWF, the below KASAN
global-out-of-bounds warning is seen.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  BUG: KASAN: global-out-of-bounds in cmt_latency_data+0x176/0x1b0
  Read of size 4 at addr ffffffffb721d000 by task dtlb/9850

  Call Trace:

   kasan_report+0xb8/0xf0
   cmt_latency_data+0x176/0x1b0
   setup_arch_pebs_sample_data+0xf49/0x2560
   intel_pmu_drain_arch_pebs+0x577/0xb00
   handle_pmi_common+0x6c4/0xc80

The issue is caused by below code in __grt_latency_data(). The code
tries to access x86_hybrid_pmu structure which doesn't exist on
non-hybrid platform like CWF.

        WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type =3D=3D hybrid_big)

So add is_hybrid() check before calling this WARN_ON_ONCE to fix the
global-out-of-bounds access issue.

Fixes: 090262439f66 ("perf/x86/intel: Rename model-specific pebs_latency_data=
 functions")
Reported-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251028064214.1451968-1-dapeng1.mi@linux.inte=
l.com
---
 arch/x86/events/intel/ds.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1..01bc59e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -317,7 +317,8 @@ static u64 __grt_latency_data(struct perf_event *event, u=
64 status,
 {
 	u64 val;
=20
-	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type =3D=3D hybrid_big);
+	WARN_ON_ONCE(is_hybrid() &&
+		     hybrid_pmu(event->pmu)->pmu_type =3D=3D hybrid_big);
=20
 	dse &=3D PERF_PEBS_DATA_SOURCE_GRT_MASK;
 	val =3D hybrid_var(event->pmu, pebs_data_source)[dse];

