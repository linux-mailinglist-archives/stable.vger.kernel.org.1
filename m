Return-Path: <stable+bounces-264790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yY/kE7d+MWpYkwUAu9opvQ
	(envelope-from <stable+bounces-264790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:49:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5216927E8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:49:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=E5QvPefC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264790-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264790-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F415F3001876
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DF477995;
	Tue, 16 Jun 2026 16:38:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7435DA6A;
	Tue, 16 Jun 2026 16:38:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627903; cv=none; b=L5y2qvURJPtJ1PwmAzg8YH4kpO4lsav8dlWpnbojidALLjANwttx/WixXi8xwKSW9bn+urAWAQpSINnerEU2ACEWNod/FN0a1waaPsaGVJre4hl4B2FZXj42SJnKmLxfl9rqm/3tHMGEpodH/uaLThV6Jqs8jrN0KG9DkFaIb44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627903; c=relaxed/simple;
	bh=6ACequzEyGkH6J40f5xu9PiIUQ9AsJJHRTVb0r5l1Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krPwlWcLjjWl30mQtVRhjmxadJoCCWNc3JClamsc7bwTdAjW96D5oIjHj6OtxbVITMPrC2eIjbLLo3S2tLD1UxK/eK8cyA4J8P271QwTSJanCyuv4qcvTqG/j3vtpYJbsl8++dZGE/WoCPainEl1sX5kbu+pF8SINqUKZNp9CX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5QvPefC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79421F000E9;
	Tue, 16 Jun 2026 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627902;
	bh=uZlkB1Pa7iwqZCPucIFzMU70cTWUGbvDbk4s7F6F69g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5QvPefC25oBxr01JCbnKe0uUxzReggBrHQqy0i/7w45mzVa+Zj+8crx6cTcOYfvh
	 XQvS+Mzws1H1D274hoq3ENikRClDQt9SE/iv8oNflZzvsds9p0m6hX6DdlTcrNL280
	 WUkB5byw3nCOTq/gTh8tInnk/x54FKOSBsMvhoys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Martin <andrew.martin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 216/261] drm/amdkfd: Fix buffer overflow in SDMA queue checkpoint/restore on GFX11
Date: Tue, 16 Jun 2026 20:30:54 +0530
Message-ID: <20260616145055.038281739@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264790-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrew.martin@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B5216927E8

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Martin <andrew.martin@amd.com>

commit 352ea59028ea48a6fff77f19ae28f98f71946a80 upstream.

The v11 MQD manager incorrectly assigned the CP-compute variants of
checkpoint_mqd/restore_mqd for KFD_MQD_TYPE_SDMA queues. These functions
use sizeof(struct v11_compute_mqd) (2048 bytes) instead of sizeof(struct
v11_sdma_mqd) (512 bytes), causing a 1536-byte overflow.

During CRIU checkpoint of an SDMA queue on Navi3x:
- checkpoint_mqd() reads 2048 bytes from a 512-byte SDMA MQD buffer,
  leaking 1536 bytes of adjacent GTT memory to userspace

During CRIU restore:
- restore_mqd() writes 2048 bytes into a 512-byte SDMA MQD buffer,
  corrupting 1536 bytes of adjacent GTT memory (often the ring buffer
  or neighboring MQDs)

This is a copy-paste regression unique to v11. All other ASIC backends
(cik, vi, v9, v10, v12) correctly use the SDMA-specific variants.

Add checkpoint_mqd_sdma() and restore_mqd_sdma() functions that properly
handle the smaller v11_sdma_mqd structure, matching the pattern used in
other MQD managers.

Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Assisted-by: Claude:Sonnet 4-5
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6fa41db7ffdec97d62433adf03b7b9b759af8c2c)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |   49 +++++++++++++++++++----
 1 file changed, 41 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -334,8 +334,7 @@ static void checkpoint_mqd(struct mqd_ma
 
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
-			struct queue_properties *qp,
-			const void *mqd_src,
+			struct queue_properties *qp, const void *mqd_src,
 			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
@@ -351,14 +350,48 @@ static void restore_mqd(struct mqd_manag
 		*gart_addr = addr;
 
 	m->cp_hqd_pq_doorbell_control =
-		qp->doorbell_off <<
-			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
-	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
-			m->cp_hqd_pq_doorbell_control);
+		qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doorbell_control);
 
 	qp->is_active = 0;
 }
 
+static void checkpoint_mqd_sdma(struct mqd_manager *mm,
+				void *mqd,
+				void *mqd_dst,
+				void *ctl_stack_dst)
+{
+	struct v11_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v11_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src,
+			     const void *ctl_stack_src,
+			     const u32 ctl_stack_size)
+{
+	uint64_t addr;
+	struct v11_sdma_mqd *m;
+
+	m = (struct v11_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	m->sdmax_rlcx_doorbell_offset =
+		qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
 
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
@@ -543,8 +576,8 @@ struct mqd_manager *mqd_manager_init_v11
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
-		mqd->checkpoint_mqd = checkpoint_mqd;
-		mqd->restore_mqd = restore_mqd;
+		mqd->checkpoint_mqd = checkpoint_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)



