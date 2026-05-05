Return-Path: <stable+bounces-244088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNpgGmbL+Wn3EAMAu9opvQ
	(envelope-from <stable+bounces-244088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:50:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC34CBD67
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 12:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D0A73019E42
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8B382F23;
	Tue,  5 May 2026 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vHze8FD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zD3CBxtp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882343815D8;
	Tue,  5 May 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978203; cv=none; b=dS+anLHnmk5auNn+kbts1WvctUv3ZxZ6o41igLG5PtaIqcUoRRDXOwr+trAPIbfOhUrcO6oc2HUr/7+Tqd3gHr2WCPuUBXRCTpS4ZJDpXthExdhmB6IYOfAh0ogjjeFO2qL4gG52zUjOkk9ErIZM4ux6fpeLboxYm3UVySdHyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978203; c=relaxed/simple;
	bh=RMr7gm2T2nKQld8wNeM1EyNBkDO4gJh6f1xIqORpV7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MQD4xo6fLEjsoYhv2eIoWqOEyA9N2L117UW6z8etaf1yEOTal0Opgy+C8htTwqaSdBdIYfSQ9qD9Xjllm6fYN2XH7ewFqDSdeeaza9JN0mDsfRyRgUow8x8uXXYNw1jOprjv82Ort07VuMuC8pwNm9q7QYu4K/deaIrV4sVCpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vHze8FD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zD3CBxtp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 10:49:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777978199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heXpN705P6sSVC1MdsKdmk9KznGVWfGnxyALakEnQDA=;
	b=4vHze8FDLmql5U2XVHm4TBZDj8Wglrb4kaSFS4P7hH3LsvhN9LOL4UqgWdyUv0bUVvyQ85
	0rE6arAauWtgbvf+HHrKxKtFNOm6xiH2J1lXpTRo7P1WXDxUDogg0wJ3ia9NUjEs/tNx5D
	uDTKpd1kEyGlyULP4a1ePD0MfLZqxqNm4WrAI5qMGKFSPHJO6qUzlGokTnmgQ9ukgU5NRM
	FFmFelMgcfcUj1xMAv8eAXAHdx3g9pYw/YrOoaP1hyQPgqQbfYvXSHcOF2JJHpN2xmuVrH
	SSnXwa6S6O4IyNn9NE4M+ocBQC//SNgB7e4GsJxnwvtIz2Eu4Ew4L60VfyTTqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777978199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heXpN705P6sSVC1MdsKdmk9KznGVWfGnxyALakEnQDA=;
	b=zD3CBxtp29bF1/Bw+LmDUpbDOjSUzerQUeKlFyDXR6ItSO6zriwxfs/3unjUH82xMjQ6ck
	udADsNBERhIZdmAQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Enable auto counter reload for DMR
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260430002558.712334-5-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177797819817.424702.9165761201281951852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 55CC34CBD67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244088-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aa4384bc8f4360167f3c3d5322121fe892289ea2
Gitweb:        https://git.kernel.org/tip/aa4384bc8f4360167f3c3d5322121fe8922=
89ea2
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Thu, 30 Apr 2026 08:25:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 12:47:22 +02:00

perf/x86/intel: Enable auto counter reload for DMR

Panther cove =C2=B5arch starts to support auto counter reload (ACR), but the
static_call intel_pmu_enable_acr_event() is not updated for the Panther
Cove =C2=B5arch used by DMR. It leads to the auto counter reload is not
really enabled on DMR.

Update static_call intel_pmu_enable_acr_event() in intel_pmu_init_pnc().

Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260430002558.712334-5-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ead6d95..dd1e3aa 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7531,6 +7531,7 @@ static __always_inline void intel_pmu_init_pnc(struct p=
mu *pmu)
 	hybrid(pmu, event_constraints) =3D intel_pnc_event_constraints;
 	hybrid(pmu, pebs_constraints) =3D intel_pnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) =3D intel_pnc_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
=20
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)

