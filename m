Return-Path: <stable+bounces-214306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPVqFOhvg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:12:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A025E9FF1
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23AB730228C1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EDF2D879E;
	Wed,  4 Feb 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u1HnbfSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD942DBF75;
	Wed,  4 Feb 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219249; cv=none; b=LvhdsJuhD2Jr/8XuVou3czV+78KusVZPMwvG5Y3ilG8RK/Xr/mxEwUxyIGvT4Os8wYgGvP7U9t3guYsSMXmvkCzRYJ8vtsSoxV2CtcJTTZzZc1VMLEDxymKhVSunZR2Ei7w9dAFtRB993xmTz+D69mNJ5xkoiaFqW4FcmLxhEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219249; c=relaxed/simple;
	bh=G72Npa8tZEWy3UthssYqi1JErU2CWWC7B3NvXsEW71g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5iLwRjFcXnTLDDzdSMqZEn+iPAzrI4TMMPLnOLa7hTFRlTN7F9NE940Vh0/mCqNgPT6UddbRZgeFWJujziGt0Hdz6jp3JsBYWHxRkCFyhug98saEserjL6YgWXZeK5sF2vS4M4xst16vUwDcYAuE2uWqTVexDp4F12uwr0E7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u1HnbfSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA3C116C6;
	Wed,  4 Feb 2026 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219249;
	bh=G72Npa8tZEWy3UthssYqi1JErU2CWWC7B3NvXsEW71g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1HnbfSxzvYAVYluCm4pp9Lb3yShruvtneIvoKz+aZXG0XbFppn7gsqfcrAefktpg
	 x2G6W52tFTFXUXezUYjHO27erU8Wu9p7PO8xwCC0pvQbwKjq7VaBoN03InEh//jUwg
	 2EYH48ma5oTI4qDqNilsWx4xkGyczQSeK5lLXC84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 112/122] drm/amdgpu/gfx12: adjust KGQ reset sequence
Date: Wed,  4 Feb 2026 15:41:34 +0100
Message-ID: <20260204143855.883049930@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214306-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A025E9FF1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit dfd64f6e8cd7b59238cdaf8af7a55711f13a89db upstream.

Kernel gfx queues do not need to be reinitialized or
remapped after a reset.  Align with gfx11.

v2: preserve init and remap for MMIO case.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0a6d6ed694d72b66b0ed7a483d5effa01acd3951)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5296,11 +5296,12 @@ static int gfx_v12_0_reset_kgq(struct am
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = false;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
 		r = gfx_v12_reset_gfx_pipe(ring);
@@ -5308,16 +5309,18 @@ static int gfx_v12_0_reset_kgq(struct am
 			return r;
 	}
 
-	r = gfx_v12_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
+	if (use_mmio) {
+		r = gfx_v12_0_kgq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "failed to init kgq\n");
+			return r;
+		}
 
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
-		return r;
+		r = amdgpu_mes_map_legacy_queue(adev, ring);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kgq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);



