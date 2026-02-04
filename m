Return-Path: <stable+bounces-213927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKOwN7hpg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-213927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:46:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92FE9530
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB2330AAB26
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1B421EFB;
	Wed,  4 Feb 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfhP9fb9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD7421EFE;
	Wed,  4 Feb 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217980; cv=none; b=WjlFO2/u92LPclSSGTcIDw76K0GnxW2Zu0CAPRwjXzD4Pw6VrIngA8exA2caX4/zVGJV5xQh/aRL4pUV8mYLZN7yTyW6oybqK18L1GcPsr1tJWnkz4JAGSiULoPfqAv816uCVo53lrQHxIjRLUuXQ90uENY/NSbsfuve67ZKuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217980; c=relaxed/simple;
	bh=Fwp8aShMoYTe8WepbfVD07pnX1xXZH3aQ5jZXEPCYe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f56C5J7vZaTzq/siMyp6a4vf0WL3kjpEMJFinHaqw/LEX8xm8K8D2SIOdVoea5SE71YHzRxy8nX8X9qg1snU+iYPKLLqNBScIaFgAXipGPde9ddrga4+Knhtqg08ikquTA1z5ytyhJjxjlvsna+iiHZWaqttQBRzfqttm/9pdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfhP9fb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7CBC116C6;
	Wed,  4 Feb 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217980;
	bh=Fwp8aShMoYTe8WepbfVD07pnX1xXZH3aQ5jZXEPCYe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfhP9fb9w+V6Ubx2hw24dDtspoNtjJwnWBfmODyvYqP2iFcx29InYdkt5av1akLWj
	 t+jXZw+7yTYq3ocUdvtA9ZT4JO3T6oAeZ1DsMSj4Yly4Oj6zMrjmFaYsAzz/HZNaAV
	 3KXK/rwwYGNXBXYDVWq6gD5bqStVsQKFAPv7qXD8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Fernand Sieber <sieberf@amazon.com>
Subject: [PATCH 6.1 177/280] perf/x86/intel: Do not enable BTS for guests
Date: Wed,  4 Feb 2026 15:39:11 +0100
Message-ID: <20260204143915.987867790@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213927-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D92FE9530
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1421,13 +1421,22 @@ static inline bool intel_pmu_has_bts_per
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



