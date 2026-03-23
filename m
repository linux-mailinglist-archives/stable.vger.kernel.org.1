Return-Path: <stable+bounces-229935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFmZLwh9wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:48:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29C2FA729
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D72AB3238A3B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430B3BD649;
	Mon, 23 Mar 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xklfccjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD13BED34;
	Mon, 23 Mar 2026 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283264; cv=none; b=WPKH6PR5CfKf/iCIKEzZoZ2B622qge4Sj7n8IS8+IqGVo5LyuLbYuSNQ/KUv0r0xFD+G8IeyAS1VaPIDjj9KM+rXbk73CVjJaZAqFgPewPPH0Qsapp1WN3ijvNYTdkaXsLAzP1J+eYUXb60cUtqWte33kOgz7FLYBmBQMRVBqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283264; c=relaxed/simple;
	bh=k4CpwRwoOIEGQiD8PwhvUuw3iTMM4B2A6abeZbCtY8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbgmrETaNc1NQAUR+uFVegzDm4ZXQmlvuUWuHQcGrUIAxEhptqrTRQ3yqPktNvssbm93DtiIAQQbGc7G8f2CQXqEcE2RMO3o6fjiub/93mz1ZNXKGWW0OKUHpgFnHLGH1zph4RE+3MDT1NvcSYKE8Ll2aAwRpEZ1YYT8qKkh0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xklfccjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBC0C4CEF7;
	Mon, 23 Mar 2026 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283263;
	bh=k4CpwRwoOIEGQiD8PwhvUuw3iTMM4B2A6abeZbCtY8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XklfccjjFNtwmUlvO4iWpYDkKF8GlcmZzhiEEB7wQnkwtcLMsuMEplDxYyDRHS6ZY
	 eHPRe0U4oKeSJRECyszQuEyzXYr/GirIj7htyU+9WlE/Ov+egxDdJgk7etwHIDNfxS
	 pecorSq+C04EvrbOmYSOFq6BBKGQtBk4E6nasml0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 6.1 459/481] drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
Date: Mon, 23 Mar 2026 14:47:21 +0100
Message-ID: <20260323134536.400614772@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229935-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 3F29C2FA729
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 96ce96f8773da4814622fd97e5226915a2c30706 ]

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domain
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif



