Return-Path: <stable+bounces-214097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PaLK9Jrg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:54:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8CCE992B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84EF931E7E27
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847342314D;
	Wed,  4 Feb 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gW3opK1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC19421EED;
	Wed,  4 Feb 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218553; cv=none; b=G+D7W+W/eb8R5BUB0LV+pm+ump6+mUY4Jo/98vsheq8KGd+Xsf415G2/vEunmmJd+sC8jZYcG8fSGlrr3t4OtG56ILrbOeWm5QUERZbEBNVue1pGkZciHGg4eWMyhjfLu8iCq2czKStJIvUHe81ixNAf48jaYmw7zQFX1VdKLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218553; c=relaxed/simple;
	bh=2m2y2mQJQRom29y3ZJF4L+jBuZB18ByTOkuaJN1W2Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LR3qbx1tdP//ahj4dBfzOZuh4Hie4nBMQ/Cbb+ZJChYrTfBPRHaUzoVug7RJ1apPuUSwYmETVkSG51XvqlFfQgs1zrO45vSEZmQcXfFOt5Ce5EVeCJ+rU5dayD/5BF8ZSzrF9q6nXpRnaNaHJW0FVhw4YdskbZzyhGsrKB14GKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gW3opK1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEE9C4CEF7;
	Wed,  4 Feb 2026 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218553;
	bh=2m2y2mQJQRom29y3ZJF4L+jBuZB18ByTOkuaJN1W2Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gW3opK1fWEULW4RXKxIkeHkdwwHxiyw6z+4grm9MfCipaeb1Yx4O5+SksQWOJ3k2Z
	 FK0gDLGzITizLdCEsk86EwguGy0Un9Vqi/v8EO8aJKuttus1Qr05dYPKMMydJb+ggG
	 d8vF8DEia+4x002VbAR31MjK52mrzExUH3F7ucg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 64/72] drm/amdkfd: Dont use sw fault filter if retry cam enabled
Date: Wed,  4 Feb 2026 15:41:07 +0100
Message-ID: <20260204143847.957649630@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214097-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CF8CCE992B
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit e61801f162ddcf8874c820639483ec4849b0fb0b ]

If retry cam enabled, we don't use sw retry fault filter and add fault
into sw filter ring, so we shouldn't remove fault from sw filter.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 8b1ecc9377bc ("drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,7 +452,10 @@ void amdgpu_gmc_filter_faults_remove(str
 	uint32_t hash;
 	uint64_t tmp;
 
-	ih = adev->irq.retry_cam_enabled ? &adev->irq.ih_soft : &adev->irq.ih1;
+	if (adev->irq.retry_cam_enabled)
+		return;
+
+	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */



