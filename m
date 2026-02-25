Return-Path: <stable+bounces-218748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHyOCRJVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C00318FED0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB3631F4ED5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A16265CBE;
	Wed, 25 Feb 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kNzgcNlA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C096248881;
	Wed, 25 Feb 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983616; cv=none; b=AQVTqDTvavCmRv/HgD/iFf1M8rJX+dSHKkoCPl89PdOaj3wVJ6Au+smOpMSYmyXSdvLYOvZqVbMij/iL2yDK/vZDYTcAuCo5x4RSrZw9dqh4MiBT1xoI5ILtjMpJmPRitJP4ruSUCXxtpnd8zqXuhG5NwwBvR0zT6Dtb9C1/R20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983616; c=relaxed/simple;
	bh=+ENPOJvlMPhj7YaZ8BNNszM9zmAs0oAOjTfwbI4mxFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTBBi2FJBOEzE2gKfHFgzVyQTeO/O+aYjx/ngRqqL/nQwDkRLSbwbonGbvGd80jEwK6pTWaSJ9C5WSSsyKqmPHcplmK18ovqsOSkI9+uX1wck8xaVXdVSVknhzepql3HatJo9mRURPdPsca9MwbcMTG8FiXaKKYMP6EkaxtubrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kNzgcNlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F815C116D0;
	Wed, 25 Feb 2026 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983616;
	bh=+ENPOJvlMPhj7YaZ8BNNszM9zmAs0oAOjTfwbI4mxFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNzgcNlA4JT+4xuPVNo7Hn13w67Lhikb9HmnAOful5nuyNSnEHiqZTGNpF8xrvwJK
	 lRoSU1LE9WUrC7ylUTaufPijHHJkR7D6uwzih5qnjhaAuL7jVc3ZuLYm6bS5KOAYgh
	 ciAaVNK9RqOyW117TKLC+MUugsmB3bWrHfd0qQnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	"Jesse.Zhang" <Jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 710/781] drm/amdgpu/sdma5.2: enable queue resets unconditionally
Date: Tue, 24 Feb 2026 17:23:39 -0800
Message-ID: <20260225012417.163041201@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218748-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7C00318FED0
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 314d30ad50622fc0d70da71509f9dff21545be14 ]

There is no firmware version dependency.  This also
enables sdma queue resets on all SDMA 5.2.x based
chips.

Fixes: 59fd50b8663b ("drm/amdgpu: Add sysfs interface for sdma reset mask")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Jesse.Zhang <Jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 51101b0aa2fab..82b1d34a6533e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1342,25 +1342,9 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(5, 2, 0):
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 3):
-	case IP_VERSION(5, 2, 4):
-		if ((adev->sdma.instance[0].fw_version >= 76) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	case IP_VERSION(5, 2, 5):
-		if ((adev->sdma.instance[0].fw_version >= 34) &&
-		    !amdgpu_sriov_vf(adev) &&
-		    !adev->debug_disable_gpu_ring_reset)
-			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-		break;
-	default:
-		break;
-	}
+	if (!amdgpu_sriov_vf(adev) &&
+	    !adev->debug_disable_gpu_ring_reset)
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
-- 
2.51.0




