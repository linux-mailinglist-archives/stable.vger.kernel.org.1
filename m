Return-Path: <stable+bounces-106082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA179FC17D
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 19:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858EA166123
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF0C212FB5;
	Tue, 24 Dec 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXXIMl/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R50Fy0H3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7792212F9D;
	Tue, 24 Dec 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066465; cv=none; b=c3oAlPLn8t7IV06gVt085qMHeD9hwYdBtuB92xGYui37ZBgZgps+rK9fVsvm7Abtdsyr2YTqeUrhyTWnMj39APTX1jLgwim4d2SOf4emdd4n+d+7Bh+THG6t3NDjbjpXO03nNi52Htqkn/CKR9JrGP9IVtxCMdhHHVJa7lLQV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066465; c=relaxed/simple;
	bh=CsciRzqNqyZ3vL0fgWGHcS6tIk23gdMvxo6Llwa1540=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fPMS57XtHQQ2ZStZY+Weu1QvWWiYfLfPaJJjUlGlNYKut5hlfIvY2wG3gdEGCtwyS7xbmuKTnhFGKKNoi093w6GwMg6NqgS5aDbQRfv/MaWEM/+iAtYHv8z7GhLpjHI3CPqZi4LgJ1TFa4p3xrUKrIsyXjTOwexLKG9iSL4RuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXXIMl/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R50Fy0H3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6zAL1gvrT1TWcfgSOqx/cM8bdD78KCgyU1oQH8unk8=;
	b=HXXIMl/+8jLbMgjo6P1sNIEKEDRorQ3L2ozwg6vlFmss0QdfybwE3kG9o6NfMc/0teIRxe
	ROdUPZkCKL/0A8kWCw45KhrxUbMHkuuXCpDgk4qt0DIppR7faVNsHSyrfOb3+9CvxxOOSK
	0ZfiAL9FX/gjmQ1CD8r9HxpOrcXrdAsq43rjjuabWwja/cyNRefA8aCeFLP9Lal+NVgKka
	Bh7bGoWRDXWTXdGn62ZCj+M4b6z7Q2tH3aXROAeKjj/8voGG0a4jw+cB9bk6n5W8Y8N7oK
	1X8+Sl6Pe5bcAWTmN/rZjaVKW/1/UO7DhdBWzpntxFzf2CF6CWgCCRhnF5x6uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6zAL1gvrT1TWcfgSOqx/cM8bdD78KCgyU1oQH8unk8=;
	b=R50Fy0H3xQO+HmfR+0qLz0d8v8w2G2QfjEn4k5Tp/y7B4OZHbohFppbHIVL699+iaYz44O
	0Z1gBBfWN5TeBXAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix bitmask of OCR and FRONTEND
 events for LNC
Cc: Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241216160252.430858-1-kan.liang@linux.intel.com>
References: <20241216160252.430858-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506646152.399.12766960837214090089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     aa5d2ca7c179c40669edb5e96d931bf9828dea3d
Gitweb:        https://git.kernel.org/tip/aa5d2ca7c179c40669edb5e96d931bf9828dea3d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 16 Dec 2024 08:02:52 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:14 +01:00

perf/x86/intel: Fix bitmask of OCR and FRONTEND events for LNC

The released OCR and FRONTEND events utilized more bits on Lunar Lake
p-core. The corresponding mask in the extra_regs has to be extended to
unblock the extra bits.

Add a dedicated intel_lnc_extra_regs.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20241216160252.430858-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2e1e268..99c590d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -429,6 +429,16 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct extra_reg intel_lnc_extra_regs[] __read_mostly = {
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0xfffffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0xfffffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
+	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
+	INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0xf, FE),
+	INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
+	EVENT_EXTRA_END
+};
 
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
@@ -6422,7 +6432,7 @@ static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
 	intel_pmu_init_glc(pmu);
 	hybrid(pmu, event_constraints) = intel_lnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_lnc_pebs_event_constraints;
-	hybrid(pmu, extra_regs) = intel_rwc_extra_regs;
+	hybrid(pmu, extra_regs) = intel_lnc_extra_regs;
 }
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)

