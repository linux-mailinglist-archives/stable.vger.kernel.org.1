Return-Path: <stable+bounces-251013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULhFGz/2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54F595036
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8071031D4FBD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C63F1AA4;
	Wed, 20 May 2026 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w22HejWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802D364E89;
	Wed, 20 May 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296876; cv=none; b=pl1KcXxp7jRHR/PIHO0vlQIfsIP0TQJlKWF9RiaGVD4uMu0enDUOV3Qf16q+S7BsuJBDNbEMjHCNG80OOenq8sQogvnFb5Ym6JSQxyRslGymq7AJoQR2K/b2Cy7J8LiN0JymrF9hs4L6BrAOgyPu2jwG9MZN6CsUSS7I1r20SRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296876; c=relaxed/simple;
	bh=PxsfjviGd4zAmg/OnO97ZarOxuIAF9AIuudH1JRvJK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAwIjYjwSHuadyV0VNvZy3xrAJXjcfjISYHc9Q2S0XUZ78nRhK6D1f2KOc0B4ROljdCFjGpIM8AL206HhmjipxnABNOL0xlClucWky9+DLWOExl5w1WUUzY9C3p7fNeHkiU823ilMvJtzzdxbXU73WqIA0zXtpkhawRYyvnSpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w22HejWr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF7B1F000E9;
	Wed, 20 May 2026 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296875;
	bh=qUngSeu5JD3RYEmQpUm6gk0NlaCalK4t3h4Ymh//ROQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w22HejWrqtlnML+V56LQ/YzeL10bcIGn04csNOYVboPZk+n6sWLtDcmEg92dGDUIJ
	 z60gRtTkWWGTYJVfftAdzzUpbDg9bUzNtpMc3bdxUiigK1AQFrs5dQnfzhc0pRf797
	 aRLLRcZIyWd2fh8gVnmQyJsjGDRMPNk7GoB1qUNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Yinjie Yao <yinjie.yao@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0966/1146] drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring
Date: Wed, 20 May 2026 18:20:16 +0200
Message-ID: <20260520162210.093367340@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251013-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 7B54F595036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yinjie Yao <yinjie.yao@amd.com>

[ Upstream commit 51f694221047c84fa185be98210eb2c354ffb8c6 ]

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit fd852c048b46f9825e904a4f3f4538fe9d8827d9)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 63d37b475c2c3..ff7269bafae8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1996,6 +1996,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
-- 
2.53.0




