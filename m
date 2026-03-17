Return-Path: <stable+bounces-226193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAXeKIuFuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EBF2AE683
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F17A330C3F94
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA37308F3A;
	Tue, 17 Mar 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0f8X/Kh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CE3ECBE3;
	Tue, 17 Mar 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765664; cv=none; b=tPvPl5NI+9hFgAV0qT1bOlmjfTCK2YpC8eeZnu7RexzWTy0pgXvBWC0jQ+BHm3UHc6d0CBjOU4jqCF33CA2PPRQoR7Sb6r/IvG11Ddadmobt+CgYmlfEt5KWXGjE1cjpgHY/Upk6BqWSNgfsraTiMPusErmsabX+4cgu+OF6Z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765664; c=relaxed/simple;
	bh=BKLgql9xNHMXfrJv/b7UOWLtFG6Es4Tb/WOw+5lYI64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlHiPjUw8K43aQJJ1gqoZKPHV8F/qyygme23ZXnmmZMeB13upfRlsyi9UfJ6XXQiodxSrNiCSIqDpskXUq+2VEdKnhZzaXORJOvrO4gR0lYkUN6jFisr3cc1Q0qVj/4Ptf6h53hzKzwDqVyyUW9eV5ofA+9yJm7pJjXG+Kt9bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0f8X/Kh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BD1C4CEF7;
	Tue, 17 Mar 2026 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765663;
	bh=BKLgql9xNHMXfrJv/b7UOWLtFG6Es4Tb/WOw+5lYI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0f8X/Kh2QH/V+p0vSBQM6DaBXHNzOp7ZUGgnZLeQLPHE8sLXsAXQsryIvR5cEGGqb
	 +UcELLMSziLCEkx6Fdw+luJLfxaGhKgVJvuAk0p39VlqVBv6Z1RLOWW2OV/uJjuAUZ
	 z5nLnhhHZCCzjyJoLU/yhCmZPVrML6zmlocslypA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 031/378] drm/msm/a6xx: Fix the bogus protect error on X2-85
Date: Tue, 17 Mar 2026 17:29:48 +0100
Message-ID: <20260317163008.124791692@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226193-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 41EBF2AE683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil P Oommen <akhilpo@oss.qualcomm.com>

[ Upstream commit 20f644f42e3b8e729d3c3199d48e75c0b257de8f ]

Update the X2-85 gpu's register protect count configuration with the
correct count_max value to avoid blocking the entire MMIO region from the
UMD.

Protect configurations are a bit complicated on A8xx. There are 2 set of
protect registers with different counts: Global and Pipe-specific. The
last-span-unbound feature is available only on the Pipe-specific protect
registers. Due to this, we cannot use the BUILD_BUG sanity check for A8x
protect configurations, so remove the A840 entry from there.

Fixes: 01ff3bf27215 ("drm/msm/a8xx: Add support for Adreno X2-85 GPU")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/706944/
Message-ID: <20260225-glymur-protect-fix-v1-1-0deddedf9277@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 550a53a7865eb..38561f26837e3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1759,7 +1759,7 @@ static const u32 x285_protect_regs[] = {
 	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
 };
 
-DECLARE_ADRENO_PROTECT(x285_protect, 64);
+DECLARE_ADRENO_PROTECT(x285_protect, 15);
 
 static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
@@ -1966,5 +1966,4 @@ static inline __always_unused void __build_asserts(void)
 	BUILD_BUG_ON(a660_protect.count > a660_protect.count_max);
 	BUILD_BUG_ON(a690_protect.count > a690_protect.count_max);
 	BUILD_BUG_ON(a730_protect.count > a730_protect.count_max);
-	BUILD_BUG_ON(a840_protect.count > a840_protect.count_max);
 }
-- 
2.51.0




