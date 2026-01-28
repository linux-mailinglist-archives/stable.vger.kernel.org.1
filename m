Return-Path: <stable+bounces-212380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP/BBYAxemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:55:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110EA4BBC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC3A030BFDF6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B932E2F745C;
	Wed, 28 Jan 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kk+aemPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7842C2346;
	Wed, 28 Jan 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615326; cv=none; b=N1GhpgxKqtcj4CRM8Y52IUe7dc47d7losW0clOZDbiuA2FMVfE83evVOEMi0qwyrftrY/sJyd71W03mARIgqK8vnQUiW41RWkyhrO5yGdxaun21FJfrJ3v3+Xstm2/+nI6Yo1DHYTcPW103iTHl9Ve0ABY+8DjoxVzUM8H8W940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615326; c=relaxed/simple;
	bh=oVqPr1YDXF2LPC15bgKtZR91erQ0evolbt4sCxH0ky0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBz8Ff/EI8Lgnw8U9jy0g81VUdN7QhHWnf3E05dno43uhCMTiPQCL51fdtidOGoSwSWz6xTidbgkeyhQUv4XezYN1MeoeOk3hok7nVLooMFpBLdyyP6VrP9vIQqw90CZX+8Uy5ZP9XwLg0R8ZVPk4sYSOtlPciix4bQG+7Qekzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kk+aemPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B80C4CEF1;
	Wed, 28 Jan 2026 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615326;
	bh=oVqPr1YDXF2LPC15bgKtZR91erQ0evolbt4sCxH0ky0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kk+aemPo3WZet5Ads++i6iTgznV8OK4r+1aWpjOANYBbYyj2GdCyTPXf8ShZvsmkT
	 v6cN1DANYnvNA8cIeg1EGjdDyf72wgISe1KJgSY1EudoXwgQT2F9ZoAQtk1LTApYgl
	 ili45WOXjHt5nuSkOYpMlf9RvZEclbY75Wm5Se9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Likun Gao <Likun.Gao@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 144/169] drm/amdgpu: remove frame cntl for gfx v12
Date: Wed, 28 Jan 2026 16:23:47 +0100
Message-ID: <20260128145339.187988820@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212380-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7110EA4BBC
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Likun Gao <Likun.Gao@amd.com>

commit 10343253328e0dbdb465bff709a2619a08fe01ad upstream.

Remove emit_frame_cntl function for gfx v12, which is not support.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5aaa5058dec5bfdcb24c42fe17ad91565a3037ca)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -248,7 +248,6 @@ static void gfx_v12_0_select_se_sh(struc
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
 
-static void gfx_v12_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
 static void gfx_v12_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t val);
 static int gfx_v12_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
@@ -4556,16 +4555,6 @@ static int gfx_v12_0_ring_preempt_ib(str
 	return r;
 }
 
-static void gfx_v12_0_ring_emit_frame_cntl(struct amdgpu_ring *ring,
-					   bool start,
-					   bool secure)
-{
-	uint32_t v = secure ? FRAME_TMZ : 0;
-
-	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
-}
-
 static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t reg_val_offs)
 {
@@ -5316,7 +5305,6 @@ static const struct amdgpu_ring_funcs gf
 	.emit_cntxcntl = gfx_v12_0_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v12_0_ring_emit_init_cond_exec,
 	.preempt_ib = gfx_v12_0_ring_preempt_ib,
-	.emit_frame_cntl = gfx_v12_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,



