Return-Path: <stable+bounces-218879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL6EEDNWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B651901F8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6550D32BA99B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C3F28AAEE;
	Wed, 25 Feb 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNOQ5DTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755127F73A;
	Wed, 25 Feb 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983766; cv=none; b=ux+gHIubX5rlCGahBpz7+IR67mBcuxGGvFaXWKyF9K9V9AP8LEbbOkI8xbxLTUJsUFQcF2bI+XTLvD6wTZL9CgeMPtJWw13ZXc8/hBYUJR06HsiODDxs25nwxpakL7lVuFnZREDvv8GKyMkqR31Xz20xQdaKuxqOl/DpKRLcx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983766; c=relaxed/simple;
	bh=sDpGstOQwx7ypF31LxC5rPu7ToCKDUVSkj89mczTOxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOxonSGW6NVbZKpbVQRs+04Wu3T6t3HWyuN9QxM+9jzSKRQx+M72EuDsHS5gwvOPi8ulbH8LM8fVe69lErtIE3SWo/VQpWt+ZzaHD0EA6AMHwGV1KOc63aiKJXDCngk9Wn5SIv85OyUF9reTETZyOh3olqr3n6juBr4t3OUPc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNOQ5DTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC01C116D0;
	Wed, 25 Feb 2026 01:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983766;
	bh=sDpGstOQwx7ypF31LxC5rPu7ToCKDUVSkj89mczTOxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNOQ5DTr6b/m/d8II2fkKBaPbwYV6bc2mRbSDCAMRMEWJfHBikA88T/hEruiSLJPr
	 ZvuH4iX7Kov9UJvEKnQ9+e/hwOH3ZxekaMWQRxkCvdnojGTQlclq38zIYa1VSeO5p3
	 KZNmkQ5foB8MMPKGysfc2TAmQfd4MlvpUGSS/THc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 058/641] perf: arm_spe: Properly set hw.state on failures
Date: Tue, 24 Feb 2026 17:16:24 -0800
Message-ID: <20260225012350.454059668@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218879-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B9B651901F8
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit 283182c1c239f6873d1a50e9e710c1a699f2256b ]

When arm_spe_pmu_next_off() fails to calculate a valid limit, it returns
zero to indicate that tracing should not start.  However, the caller
arm_spe_perf_aux_output_begin() does not propagate this failure by
updating hwc->state, cause the error to be silently ignored by upper
layers.

Because hwc->state remains zero after a failure, arm_spe_pmu_start()
continues to programs filter registers unnecessarily.  The driver
still reports success to the perf core, so the core assumes the SPE
event was enabled and proceeds to enable other events.  This breaks
event group semantics: SPE is already stopped while other events in the
same group are enabled.

Fix this by updating arm_spe_perf_aux_output_begin() to return a status
code indicating success (0) or failure (-EIO).  Both the interrupt
handler and arm_spe_pmu_start() check the return value and call
arm_spe_pmu_stop() to set PERF_HES_STOPPED in hwc->state.

In the interrupt handler, the period (e.g., period_left) needs to be
updated, so PERF_EF_UPDATE is passed to arm_spe_pmu_stop().  When the
error occurs during event start, the trace unit is not yet enabled, so
a flag '0' is used to drain buffer and update state only.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_spe_pmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645feddad..e4e4e63c64c42 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -105,6 +105,8 @@ struct arm_spe_pmu {
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;
 
+static void arm_spe_pmu_stop(struct perf_event *event, int flags);
+
 enum arm_spe_pmu_buf_fault_action {
 	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
 	SPE_PMU_BUF_FAULT_ACT_FATAL,
@@ -582,8 +584,8 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
 	return limit;
 }
 
-static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
-					  struct perf_event *event)
+static int arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
+					 struct perf_event *event)
 {
 	u64 base, limit;
 	struct arm_spe_pmu_buf *buf;
@@ -597,7 +599,6 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	/* Start a new aux session */
 	buf = perf_aux_output_begin(handle, event);
 	if (!buf) {
-		event->hw.state |= PERF_HES_STOPPED;
 		/*
 		 * We still need to clear the limit pointer, since the
 		 * profiler might only be disabled by virtue of a fault.
@@ -617,6 +618,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 
 out_write_limit:
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
+	return (limit & PMBLIMITR_EL1_E) ? 0 : -EIO;
 }
 
 static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
@@ -756,7 +758,10 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
 		 * when we get to it.
 		 */
 		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
-			arm_spe_perf_aux_output_begin(handle, event);
+			if (arm_spe_perf_aux_output_begin(handle, event)) {
+				arm_spe_pmu_stop(event, PERF_EF_UPDATE);
+				break;
+			}
 			isb();
 		}
 		break;
@@ -851,9 +856,10 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 	struct perf_output_handle *handle = this_cpu_ptr(spe_pmu->handle);
 
 	hwc->state = 0;
-	arm_spe_perf_aux_output_begin(handle, event);
-	if (hwc->state)
+	if (arm_spe_perf_aux_output_begin(handle, event)) {
+		arm_spe_pmu_stop(event, 0);
 		return;
+	}
 
 	reg = arm_spe_event_to_pmsfcr(event);
 	write_sysreg_s(reg, SYS_PMSFCR_EL1);
-- 
2.51.0




