Return-Path: <stable+bounces-210789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPfrH835cGmgbAAAu9opvQ
	(envelope-from <stable+bounces-210789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A359AF2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04E3FAA4A48
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC583D646D;
	Wed, 21 Jan 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZt4z/dw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5Hd1dvd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCB357A50;
	Wed, 21 Jan 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010629; cv=none; b=h//HJqoUMyAkl1EO7vb/EmZTV8+NeFmCVnqEpbS3FMF+tkBDfM6NnC0f2FXPgQgfDRUCGdsHwdVhSXjb2f4AZgTHQFkQo/MarHqQ9Z2LTpP/MI5ttisuWIOF1nfyZNoxSV2+o8SaXgk/bTNhUlY3ZalOnqcxFZ6OIOAThnDg3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010629; c=relaxed/simple;
	bh=TKFMVPUVrcoo260mLYBi9FLX21eB1CR9J8mFOcu+z7Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s/LJZqXpeGMtLmbr5YOYjL7/gMqBEvVksC04Mgvl2pCUA3FQ3vzkWHTkP8Eyq9vARboRQr/9S108ImtZbnIdWneUPbnQ6mJbA2uTAF9tPCEf+HnhOsCVbicU1QVS14qO4pZRoOpvgrgd/QS4QbakRZfBEBbCMc825Gb0Rin35EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZt4z/dw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5Hd1dvd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Jan 2026 15:50:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769010625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfPZWxOWTFBc/34iB9b9dmMdVm9Nhcvz3eklJlZaZW0=;
	b=vZt4z/dwgqlbATu4ANOydpKk9yM8vUfRo+UCHfPUkN1C+S9dXujsXb8DwEExsjUKYCIw+Q
	bZgT1UN0R4K5DFtGWX1JYfPLuwFTJ4Jk/xd22QI55+kLZ2nlr0VNoXAdepfIrCQ23stJTz
	Y++Z3ZPbmRjnUS2ohtRZBd5ppq6OrCCtCX97YdSGDSHqjmexq94NpJhRwbi6oVK6pT7gqw
	CTJCkpAFBLzDN7QJNP1GvNxX/iqUubH2PvM+HiL/12Mk4bZqwnyshG/1WvxpGaVj0/R34e
	AKekw1a7jqtBleam+s2i1RC//E1bbK3Caf3YrCR25h4Y0wlSSEgSTug/Sj7naQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769010625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfPZWxOWTFBc/34iB9b9dmMdVm9Nhcvz3eklJlZaZW0=;
	b=I5Hd1dvdOGJjDpTg5aPIXlATlyd7vaS8kI/nCx2jZLKKzq9S7QH4SIxmAsSCV8bCVjtyh1
	EVu4xuBm5y98z7Dw==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Do not enable BTS for guests
Cc: jschoenh@amazon.de, Peter Zijlstra <peterz@infradead.org>,
 Fernand Sieber <sieberf@amazon.com>,  <stable@vger.kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251211183604.868641-1-sieberf@amazon.com>
References: <20251211183604.868641-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176901062386.510.18286224975679497732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-210789-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,amazon.de:email,msgid.link:url,vger.kernel.org:replyto,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linutronix.de:dkim]
X-Rspamd-Queue-Id: E82A359AF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     91dcfae0ff2b9b9ab03c1ec95babaceefbffb9f4
Gitweb:        https://git.kernel.org/tip/91dcfae0ff2b9b9ab03c1ec95babaceefbf=
fb9f4
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Thu, 11 Dec 2025 20:36:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Jan 2026 16:28:59 +01:00

perf/x86/intel: Do not enable BTS for guests

By default when users program perf to sample branch instructions
(PERF_COUNT_HW_BRANCH_INSTRUCTIONS) with a sample period of 1, perf
interprets this as a special case and enables BTS (Branch Trace Store)
as an optimization to avoid taking an interrupt on every branch.

Since BTS doesn't virtualize, this optimization doesn't make sense when
the request originates from a guest. Add an additional check that
prevents this optimization for virtualized events (exclude_host).

Reported-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20251211183604.868641-1-sieberf@amazon.com
---
 arch/x86/events/perf_event.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6296302..ad35c54 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1574,13 +1574,22 @@ static inline bool intel_pmu_has_bts_period(struct pe=
rf_event *event, u64 period
 	struct hw_perf_event *hwc =3D &event->hw;
 	unsigned int hw_event, bts_event;
=20
-	if (event->attr.freq)
+	/*
+	 * Only use BTS for fixed rate period=3D=3D1 events.
+	 */
+	if (event->attr.freq || period !=3D 1)
+		return false;
+
+	/*
+	 * BTS doesn't virtualize.
+	 */
+	if (event->attr.exclude_host)
 		return false;
=20
 	hw_event =3D hwc->config & INTEL_ARCH_EVENT_MASK;
 	bts_event =3D x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
=20
-	return hw_event =3D=3D bts_event && period =3D=3D 1;
+	return hw_event =3D=3D bts_event;
 }
=20
 static inline bool intel_pmu_has_bts(struct perf_event *event)

