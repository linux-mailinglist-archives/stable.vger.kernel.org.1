Return-Path: <stable+bounces-263397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EVV0M2coMGrJPAUAu9opvQ
	(envelope-from <stable+bounces-263397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:29:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BCB688601
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Ae1aOWZj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263397-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263397-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A4333056FEA
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6C40962B;
	Mon, 15 Jun 2026 16:22:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE526A08F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:22:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540522; cv=none; b=h7lgJE/vCRVYgdIvRodlMKrQcitJdDQdpMg83mwIzUKhAcgntARfU4N9Xt9bb44uxIY9WmE6bNLBF5lX9M0ZX7UkFtdDn5J+ijyzkTOesqbjuBXIPlKEzeGZPqemdFfX7bEB4eVHCF7a4cuzGNJygeEP62w8cPTyxpapoSdGGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540522; c=relaxed/simple;
	bh=4WbA5viBWbPpe+gKQu6vYQ7dnDIJV9n6EXZIA5q15cI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C3BVcV96k/qtYJ2rqI/+CNLEMtWg0IbI7HwUhgEO7MACXCaiwMvdlhwAF8fG6O+5D84ERB401VVR2/d7/E+vwI+KSxG/Jr/VJmhvIOkcgSFdI/Fb9ABsM4z6bkDNRWjAU5yaiZeRWSm2JIEGHUmmmLRhwKj/KNouCL5KiVWlpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ae1aOWZj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0739C1F000E9;
	Mon, 15 Jun 2026 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781540520;
	bh=yCCq5siqI45AqB9MWbHylMCAf8FueweZkvBe1rzpNco=;
	h=Subject:To:Cc:From:Date;
	b=Ae1aOWZj8KRPimV+RDn2Ml/FlHxLt/P0k/iaxffWmL9vGPktb5UHUEq9s435Uc7k1
	 fA3hkhffZGP5xLYjrq9irvN9hP6BoqiybQyGF5JKk0jEJCSH0oi1TYXo/JpAxLdmth
	 IxTpVMgalxPtvzkPfV/bvLcTbSjIbRK510eWDIgc=
Subject: FAILED: patch "[PATCH] drm/v3d: Skip CSD when it has zeroed workgroups" failed to apply to 5.15-stable tree
To: mcanal@igalia.com,itoral@igalia.com,jmcasanova@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 18:01:28 +0200
Message-ID: <2026061528-cytoplast-unretired-0932@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263397-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mcanal@igalia.com,m:itoral@igalia.com,m:jmcasanova@igalia.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,igalia.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28BCB688601


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7f93fad5ea0affc9e1505dd0f7596c0fdb496213
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061528-cytoplast-unretired-0932@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f93fad5ea0affc9e1505dd0f7596c0fdb496213 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Tue, 2 Jun 2026 14:50:15 -0300
Subject: [PATCH] drm/v3d: Skip CSD when it has zeroed workgroups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A compute shader dispatch encodes its workgroup counts in the CFG0..CFG2
registers. Kicking off a dispatch with a zero count in any of the three
dimensions is invalid. First, the hardware will process 0 as 65536,
while the user-space driver exposes a maximum of 65535. Over that, a
submission with a zeroed workgroup dimension should be a no-op.

These zeroed counts can reach the dispatch path through an indirect CSD
job, whose workgroup counts are only known once the indirect buffer is
read and may legitimately be zero, but such scenario should only result in
a no-op.

Overwrite the indirect CSD job workgroup counts with the indirect BO
ones, even if they are zeroed, and don't submit the job to the hardware
when any of the workgroup counts is zero, so the job completes immediately
instead of running the shader.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260602-v3d-fix-indirect-csd-v4-2-654309e32bc0@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 47f83936cd73..8a635a9ec046 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -352,6 +352,16 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 		return NULL;
 	}
 
+	/* The HW interprets a workgroup size of 0 as 65536; however, the
+	 * user-space driver exposes a maximum of 65535. Therefore, a 0 in
+	 * any dimension means that we have no workgroups and the compute
+	 * shader should not be dispatched.
+	 */
+	if (!V3D_GET_FIELD(job->args.cfg[0], V3D_CSD_QUEUED_CFG0_NUM_WGS_X) ||
+	    !V3D_GET_FIELD(job->args.cfg[1], V3D_CSD_QUEUED_CFG1_NUM_WGS_Y) ||
+	    !V3D_GET_FIELD(job->args.cfg[2], V3D_CSD_QUEUED_CFG2_NUM_WGS_Z))
+		return NULL;
+
 	v3d->queue[V3D_CSD].active_job = &job->base;
 
 	v3d_invalidate_caches(v3d);
@@ -402,13 +412,13 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 
 	wg_counts = (uint32_t *)(bo->vaddr + indirect_csd->offset);
 
-	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
-		goto unmap_bo;
-
 	args->cfg[0] = wg_counts[0] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[1] = wg_counts[1] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[2] = wg_counts[2] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 
+	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
+		goto unmap_bo;
+
 	num_batches = DIV_ROUND_UP(indirect_csd->wg_size, 16) *
 		      (wg_counts[0] * wg_counts[1] * wg_counts[2]);
 


