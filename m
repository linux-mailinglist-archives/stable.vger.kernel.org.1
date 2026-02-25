Return-Path: <stable+bounces-218746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fj3Gw5Vnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E00318FEC2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F94C31190EE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDA26D4CA;
	Wed, 25 Feb 2026 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzf+5jCm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6C2494FE;
	Wed, 25 Feb 2026 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983614; cv=none; b=R/7/SfTSgQUk5W0LmEbU8bpFin42+zZuh1hY4cqKXNLYE5Ma65lixE57IKD5hg/fOMFbYQpxYK6/PUkYkODWLPVp29XIaGR6aMfL97aOCgYksbWY527oLimA0yFwrCQJin2JLlmqme4E+3bfczQa2h/gZNyBzNT9aEVAJgyvxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983614; c=relaxed/simple;
	bh=i5AZxb6SD3qG7kaFYzGDBj842WI2IIzqla4fnJv5p2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuYhRxlzkcvRsBoXYRulalrNn7G3/cWhXPJtgsTqGSY1qMZ4QEgCNqhDe11VRDglItwXuZwLa4cHxGp+p/5q+Stwx8r2GhVwTIv9HCzdP2l+ObyRH/0upQK1T/gjiaQLluVlFOBWM8nISWcNu5jNBzThj8x+Rk22QX6rNLY2Niw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzf+5jCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC861C116D0;
	Wed, 25 Feb 2026 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983614;
	bh=i5AZxb6SD3qG7kaFYzGDBj842WI2IIzqla4fnJv5p2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wzf+5jCmtt3eD0ZLPhW39vb5L0MXKJLWO1uvTGSpSIbHC8Stn4A8l39wk/n/SB+M9
	 IlB9eo1t+kf8H0guzvzYrpfhpw2LAKfw9zVH3nGjbBPFZpm1UaiSsXQSkYkV7aY12S
	 9KWVp2UxLo2RXb1EihkSr5Y0np6d5LEdYPiZQGF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tao Zhou <tao.zhou1@amd.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 708/781] drm/amdgpu: Fix memory leak in amdgpu_ras_init()
Date: Tue, 24 Feb 2026 17:23:37 -0800
Message-ID: <20260225012417.112604586@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218746-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,seu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1E00318FEC2
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit ee41e5b63c8210525c936ee637a2c8d185ce873c ]

When amdgpu_nbio_ras_sw_init() fails in amdgpu_ras_init(), the function
returns directly without freeing the allocated con structure, leading
to a memory leak.

Fix this by jumping to the release_con label to properly clean up the
allocated memory before returning the error code.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: fdc94d3a8c88 ("drm/amdgpu: Rework pcie_bif ras sw_init")
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2a6cf7963dde2..8de9f68f7bea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4343,7 +4343,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	 * to handle fatal error */
 	r = amdgpu_nbio_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto release_con;
 
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->init_ras_controller_interrupt) {
-- 
2.51.0




