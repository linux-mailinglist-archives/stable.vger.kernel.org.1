Return-Path: <stable+bounces-214098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oADUJiNng2ntmQMAu9opvQ
	(envelope-from <stable+bounces-214098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:34:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C14E8E95
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E5C308CE0C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19425423152;
	Wed,  4 Feb 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l0+oysgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1453421EE4;
	Wed,  4 Feb 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218556; cv=none; b=Ha8FMd9jWnUVStYbHyBFJ43x4J6mtoyUozYea+fJ1GaauyOnG01A46QqVTOgZv97Uk7ZnukogVpYpJDRz/lf/gShDwPBhEh0s41ToJLCphEuuXfswIAjRp+Qq6PbacVkru/PpTZtnq/BmBxbJ6F38PzGKv26N9072rRuiaFg6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218556; c=relaxed/simple;
	bh=O3YfBDcgvcoqAL0uKbubhc3+yhMMtR2W4zBgdpg9PmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiaK1fw+686HrMACvkvBms3928kl0wUwmUbbUQZ8gOsrg5UvjOjbFau5lw91WqA1plA9LYFYHZZSlvGQoVjf9XXwmp7VPAXegOLGcfdPqU2wmVxGy90i9lfRiAxYwh/udt2Kipuuo+BOdWyttMPSOJJwNX1rjNDIBewA8J9M/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l0+oysgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E3EC4CEF7;
	Wed,  4 Feb 2026 15:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218556;
	bh=O3YfBDcgvcoqAL0uKbubhc3+yhMMtR2W4zBgdpg9PmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0+oysgOn18XV9agwfXPLww4ezKazfNpGxzjsUh6HYUAcgk29Po0YKR/zanyg33aw
	 yasJSRA6tiMDUDmWDHHOaJ/gYvMPqto4qu6hS76WmyY0u6WXUyG5jirwXRK7t+y4Kw
	 ewffvXuy+KhkPqMwZo21/K8wF3EDiYOiVqC/hPCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Philip Yang <Philip.Yang@amd.com>,
	Jon Doron <jond@wiz.io>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 65/72] drm/amdgpu: fix NULL pointer dereference in amdgpu_gmc_filter_faults_remove
Date: Wed,  4 Feb 2026 15:41:08 +0100
Message-ID: <20260204143847.994211614@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,wiz.io,kernel.org];
	TAGGED_FROM(0.00)[bounces-214098-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,wiz.io:email]
X-Rspamd-Queue-Id: 21C14E8E95
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Doron <jond@wiz.io>

[ Upstream commit 8b1ecc9377bc641533cd9e76dfa3aee3cd04a007 ]

On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
ih2 interrupt ring buffers are not initialized. This is by design, as
these secondary IH rings are only available on discrete GPUs. See
vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
AMD_IS_APU is set.

However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
get the timestamp of the last interrupt entry. When retry faults are
enabled on APUs (noretry=0), this function is called from the SVM page
fault recovery path, resulting in a NULL pointer dereference when
amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].

The crash manifests as:

  BUG: kernel NULL pointer dereference, address: 0000000000000004
  RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
  Call Trace:
   amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
   svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
   amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
   gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
   amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
   amdgpu_ih_process+0x84/0x100 [amdgpu]

This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
noretry=1 to noretry=0, enabling retry fault handling and thus
exercising the buggy code path.

Fix this by adding a check for ih1.ring_size before attempting to use
it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgpu:
Rework retry fault removal").  This is needed if the hardware doesn't
support secondary HW IH rings.

v2: additional updates (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Jon Doron <jond@wiz.io>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6ce8d536c80aa1f059e82184f0d1994436b1d526)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -454,8 +454,13 @@ void amdgpu_gmc_filter_faults_remove(str
 
 	if (adev->irq.retry_cam_enabled)
 		return;
+	else if (adev->irq.ih1.ring_size)
+		ih = &adev->irq.ih1;
+	else if (adev->irq.ih_soft.enabled)
+		ih = &adev->irq.ih_soft;
+	else
+		return;
 
-	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */



