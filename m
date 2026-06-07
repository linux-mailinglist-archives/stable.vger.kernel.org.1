Return-Path: <stable+bounces-261747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3M+jHBlQJWpgGwIAu9opvQ
	(envelope-from <stable+bounces-261747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:03:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1759650456
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1mc5JITx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261747-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261747-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A6D3073F88
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D82EBB9E;
	Sun,  7 Jun 2026 10:54:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD54204E;
	Sun,  7 Jun 2026 10:54:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829689; cv=none; b=XQU1ALazGt0IBUkTFothaaI4/Zm/w54U6LKDnvW24s0GnKnqfWpOV43tGcquB2e4Zuu5uQTKI8T8XsdfHh3M7pqdBc/xrELs+D8mvcfDSfU39269nyanFCTOCw55pb1ZQ6A7ElgpRpbhN8AnnFHwDZQCgsGh2Jc6O7ZvqHQtWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829689; c=relaxed/simple;
	bh=wxlllxzmLH1Mkv1gTFI4N5X6r6cBhP49dCjJJPQm+64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNLhYX+uY614X+EnsQ10ptVUDg8x7NjpEbZBsNV6fOPYQkjz6qp/fDGCECM2ou4xr/y6v+DJ2wJqohcXrBHaBIj+5sbtP3D2xuSKcolEF7ac+SE1r9hadubIsPJHKkq3c3SuhibEourlUaiZ+lWPpJ7ZLTMd++yeVYd1aLrqQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1mc5JITx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348D61F00893;
	Sun,  7 Jun 2026 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829688;
	bh=DTBUj+PzswKO0n+RQduS7DfjjcaIqHd3pOhFhOe6kcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1mc5JITxS9jnL8Uj3y0xWfbIJ67VRJxRiBBHMG/0ncdGrSixpNyqG86iqod4wtPxn
	 zFzzALuBMAqShFLWgq4K91PXfq1dkrRKUDCz0Bt9QBOhgKHlHofg/riBOxUemeKSjb
	 kk4P3s9W/EIhAeWS+1o3Ca4X3GuWUv8O2dAGFk84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6.12 246/307] drm/amd/pm/si: Disregard vblank time when no displays are connected
Date: Sun,  7 Jun 2026 12:00:43 +0200
Message-ID: <20260607095736.732725496@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261747-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alexander.deucher@amd.com,m:jeremy.klarenbeek99@gmail.com,m:timur.kristof@gmail.com,m:jeremyklarenbeek99@gmail.com,m:timurkristof@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1759650456

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

commit dd4f3ee535b3b0ac027f75dbf9dc5fc88733c765 upstream.

When no displays are connected, there is no vblank
happening so the power management code shouldn't
worry about it.

This fixes a regression that caused the memory clock
to be stuck at maximum when there were no displays
connected to a SI GPU.

Fixes: 9003a0746864 ("drm/amd/pm: Treat zero vblank time as too short in si_dpm (v3)")
Fixes: 9d73b107a61b ("drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6d87e0199f7b83735b56e422d59f170a201897a8)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3062,6 +3062,10 @@ static bool si_dpm_vblank_too_short(void
 	/* we never hit the non-gddr5 limit so disable it */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
 
+	/* Disregard vblank time when there are no displays connected */
+	if (!adev->pm.pm_display_cfg.num_display)
+		return false;
+
 	/* Consider zero vblank time too short and disable MCLK switching.
 	 * Note that the vblank time is set to maximum when no displays are attached,
 	 * so we'll still enable MCLK switching in that case.



