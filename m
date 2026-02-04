Return-Path: <stable+bounces-213670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCEuHyxhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88626E804B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA8C83085B19
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3264219F7;
	Wed,  4 Feb 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vLY117Bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6A4218A8;
	Wed,  4 Feb 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217113; cv=none; b=XxD2h/VRPjEBwayQWcqBtk8tYDP2oZ6HL2eVPVWA4yyMaZsdaKNuNQGCYky+GaDGL9NltAdYF2EdkNDzUS7727hzKS2odpH31VmVcKBMh5vKgZ/P6QOjaqWuThhW+0Wmym/nIUrYIRscVocP05GcLk3s9xHPukT+suw5AuxA0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217113; c=relaxed/simple;
	bh=AxvBq/tDhx19rNihNKLrGjPUjvp9H+hXgmFsIb+q09M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyU8hfsxHxrGFAvmp1WApFsLWObGmiaBVvjIg5U8DAfnuDtxkmcfIMFNwG9YKlie4xZtzJ3CIX50oL6F1VdJzciohIH2rJ0S6IhuHyidNZVc5k6ALSr6KM9umj/egM9VRiLGsQio9rGsbU7unf6aszS5ndhYv3R6W5oHLbiAHoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vLY117Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9420FC4CEF7;
	Wed,  4 Feb 2026 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217113;
	bh=AxvBq/tDhx19rNihNKLrGjPUjvp9H+hXgmFsIb+q09M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLY117Bq2UYCOYXXGqbtLj5l2CMxpgkXDUYNUPcB/kb/ZCAKPouuwZktbDSxYr3oc
	 Vewgd5NIHp4n/R5hsihu4Of8PWkC3RDdrT2vZLHrtDi26wIKodMixtm0218EFLTwiK
	 NnfCF7F0VlEFEpIOKMe7kl5hnT+zF915pM0NullI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Fernand Sieber <sieberf@amazon.com>
Subject: [PATCH 5.15 126/206] perf/x86/intel: Do not enable BTS for guests
Date: Wed,  4 Feb 2026 15:39:17 +0100
Message-ID: <20260204143902.739105439@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213670-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amazon.de:email]
X-Rspamd-Queue-Id: 88626E804B
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernand Sieber <sieberf@amazon.com>

commit 91dcfae0ff2b9b9ab03c1ec95babaceefbffb9f4 upstream.

By default when users program perf to sample branch instructions
(PERF_COUNT_HW_BRANCH_INSTRUCTIONS) with a sample period of 1, perf
interprets this as a special case and enables BTS (Branch Trace Store)
as an optimization to avoid taking an interrupt on every branch.

Since BTS doesn't virtualize, this optimization doesn't make sense when
the request originates from a guest. Add an additional check that
prevents this optimization for virtualized events (exclude_host).

Reported-by: Jan H. Schönherr <jschoenh@amazon.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20251211183604.868641-1-sieberf@amazon.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/perf_event.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1286,13 +1286,22 @@ static inline bool intel_pmu_has_bts_per
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int hw_event, bts_event;
 
-	if (event->attr.freq)
+	/*
+	 * Only use BTS for fixed rate period==1 events.
+	 */
+	if (event->attr.freq || period != 1)
+		return false;
+
+	/*
+	 * BTS doesn't virtualize.
+	 */
+	if (event->attr.exclude_host)
 		return false;
 
 	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
 	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return hw_event == bts_event && period == 1;
+	return hw_event == bts_event;
 }
 
 static inline bool intel_pmu_has_bts(struct perf_event *event)



