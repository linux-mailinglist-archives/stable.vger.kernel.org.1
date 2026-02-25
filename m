Return-Path: <stable+bounces-219500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPkuLFKenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8637E192C28
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 460CB301BA9C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D6318ED6;
	Wed, 25 Feb 2026 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UMzU4xbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459612FB08C;
	Wed, 25 Feb 2026 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002757; cv=none; b=pyD9Ed/8E+VQ8E7hfcB9mvrG8hFpc7yFK9UrlEGhiLATDF9twguLEpsZwKGUmBSBJRQyDHCvbUedAaP4D83ZLrU/idOlGFo1h4DdFpluf3B+K715Old5j+wmwWBaflMOYYWAmQkym7Gmwj+C5mhhdRt5c8FKe6aBBy1cOLOTXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002757; c=relaxed/simple;
	bh=u5X+C1g3xRrrwFjIGq7xA800WZpfHB5u2E4wKlnJCtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEJbGpschN28v0ZEEXGlNCxoDFy5Dh0RdZRiashKU3CX+MbMy1ynF96vVK3dPyqbWw8tHLM391p383UErwu19qJPF10TifONHwkx1bsUZIKJlBFf7cDJWGie7onjQDzFB9vGBnM1e2VAyE5xzCzM5g6WE6dXmO4W1P1kvO0ZqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UMzU4xbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA67C116D0;
	Wed, 25 Feb 2026 06:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002757;
	bh=u5X+C1g3xRrrwFjIGq7xA800WZpfHB5u2E4wKlnJCtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMzU4xbIfTb/ooBK/ugcU9UK9OmR0MIKTGDd+juAlg4jJK2GjQ6Fe/NENz3aCwrkf
	 IkGvhV5S7QKDU8eIRZmy65mTeUHzMJxnNKB5ZcxDQljB+NP6jw0aqlU226DgYrsejs
	 0/K2YL0AdNE8ncgcO8B84Y4V9OfQ8uzZYlM8fWFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	"Jesse.Zhang" <Jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 584/641] drm/amdgpu/sdma6: enable queue resets unconditionally
Date: Tue, 24 Feb 2026 17:25:10 -0800
Message-ID: <20260225012402.662040564@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219500-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8637E192C28
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 56423871e9eef1dd069bddef895207fa5ce275fe ]

There is no firmware version dependency.  This also
enables sdma queue resets on all SDMA 6.x based
chips.

Fixes: 59fd50b8663b ("drm/amdgpu: Add sysfs interface for sdma reset mask")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Jesse.Zhang <Jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2170400449872..6809c6d4be5b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1351,18 +1351,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
-	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 2):
-	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 21) &&
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
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
-- 
2.51.0




