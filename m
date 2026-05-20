Return-Path: <stable+bounces-251026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PmcApPsDWo04wUAu9opvQ
	(envelope-from <stable+bounces-251026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:17:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B95933D5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D578308C9C7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02C3F39D1;
	Wed, 20 May 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnH1xMvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7D3EC2DB;
	Wed, 20 May 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296910; cv=none; b=nNw7JorQKc5eGIVkI8j+jmmO+pZfKkF2BWX3pV1Owr6fO3Hpkh0OEgSxSR/NAyOVfVfsf+j9ZTd3Jc5lQuFs6CQl3JJAmOXs6gnyQCRrwFIk3+vest8sVfkKKKbO/9huYQoLkq5u114OcFd/N0IcOr0oPBO0sgeV+yTmQvYsMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296910; c=relaxed/simple;
	bh=INHp4XD99RSU5vufhIV66vXYt/EVVdi16/GpKFY07lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXVL6jtzKrqsUpyw/xy3SIzEc1pVmnE9wT1UnruJtpSPdWpOm+NVLkhlzDLTF2oT+SoXbfhuqfTgSgj8cS2vNTnyryR3p+lskpxs/9Xyi6A7cx9Od0yXXZcHRrHIbMPaFVx7An7t9b2Y595+tjbRWcdmaOKYG+I+GV4LzZVmiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnH1xMvy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE46B1F000E9;
	Wed, 20 May 2026 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296909;
	bh=6VL6E518d9lplk0N2r8le5rQCQDchsbQSnHC6LqpoNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tnH1xMvy4LHBYADcftPAolAnH1sbRVwwO7UmDo1/gW6cD5Uy4K5hWLCNR6xvI+LWW
	 SNPNdlZQdz08pD5AR8QqLMI8yeLH1AokJWsxYA9ByOaW5n9UejVgvRlgL5mgLB73+8
	 coiFa5dkDfWB3VIzBwwzzBnfmlo9Olvtn+dHpmOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Yinjie Yao <yinjie.yao@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0978/1146] drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1 ring
Date: Wed, 20 May 2026 18:20:28 +0200
Message-ID: <20260520162210.365305890@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251026-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B56B95933D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yinjie Yao <yinjie.yao@amd.com>

[ Upstream commit 2f8e3da71a1b469b6e157aa3972f1448b3157840 ]

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: b8f57b69942b ("drm/amdgpu: Add JPEG5_0_1 support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 742a98e2e81702df8fe1b1eccee5223220a03dc2)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index edecbfe66c79a..250316704dfac 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -884,6 +884,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_1_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_1_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_1_dec_ring_set_wptr,
-- 
2.53.0




