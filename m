Return-Path: <stable+bounces-219013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D0xN7dVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-219013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:51:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 911451900CC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6131230C65D2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5039C27D782;
	Wed, 25 Feb 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L8sABbcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0927991E;
	Wed, 25 Feb 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983925; cv=none; b=SNxqWwayTV/PKe6BQJI4ZhuAazt5nNeFAa49Cgb8IUnWJ767TGMsLQ6ZuUQe5+lBcGtPOgdIzJrAEBJ2gu0X5BMfBIZrJKrZfmPoztIrOU6/4SB7ZN9h+52tHRwvnTYrvsCRWL2WuO1gtb3KMu+mr0eM1ZGDqyjaKy4gfAdwZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983925; c=relaxed/simple;
	bh=ZIjsVGgLjHxFUvP/uN/01BKKlzDoYmeodQybArGQ+Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5XxDjiy2pMN2NCevqv1Id612kDoU8uX0NY7O1nP4YtmipiCXQPHrB/6aSG5lMWkC1AZWLIPA9Jbu58cMNgKIqSDwHKi6XDvm65jDpH19mS6kVV1pWwKxt8qK6nMLIHH2Xx26u/LtFZN6BzW839VeTk9He3a6LmTAlVHeNKCeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L8sABbcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B04C116D0;
	Wed, 25 Feb 2026 01:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983924;
	bh=ZIjsVGgLjHxFUvP/uN/01BKKlzDoYmeodQybArGQ+Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8sABbcG0uRZDU4XzwJgGHRIvD9omNYxEbTfg9g6wjBaBmUfZkQiKL1TrklWuDax5
	 mVQPUwvORu3G67hJgNTqXHtS/mAbK6uz+wiGytYHm1Koj/aZK2nBE74qgSg9zYF7LU
	 3mIFG7jhUCWx5h2hdVI0ykuRmlyKwF5Hi5defbF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Teguh Sobirin <teguh@sobir.in>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 192/641] drm/msm/dpu: Set vsync source irrespective of mdp top support
Date: Tue, 24 Feb 2026 17:18:38 -0800
Message-ID: <20260225012353.650125160@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219013-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,somainline.org:email,qualcomm.com:email,sobir.in:email]
X-Rspamd-Queue-Id: 911451900CC
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Teguh Sobirin <teguh@sobir.in>

[ Upstream commit 1ad9880f059c9b0943e53714f9a59924cb035bbb ]

Since DPU 5.x the vsync source TE setup is split between MDP TOP and
INTF blocks. Currently all code to setup vsync_source is only executed
if MDP TOP implements the setup_vsync_source() callback. However on
DPU >= 8.x this callback is not implemented, making DPU driver skip all
vsync setup. Move the INTF part out of this condition, letting DPU
driver to setup TE vsync selection on all new DPU devices.

Signed-off-by: Teguh Sobirin <teguh@sobir.in>
Fixes: 2f69e5458447 ("drm/msm/dpu: skip watchdog timer programming through TOP on >= SM8450")
[DB: restored top->ops.setup_vsync_source call]
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/696584/
Link: https://lore.kernel.org/r/20251230-intf-fix-wd-v6-1-98203d150611@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 258edaa18fc02..7b90c59792f6b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -784,6 +784,8 @@ static void _dpu_encoder_update_vsync_source(struct dpu_encoder_virt *dpu_enc,
 		return;
 	}
 
+	vsync_cfg.vsync_source = disp_info->vsync_source;
+
 	if (hw_mdptop->ops.setup_vsync_source) {
 		for (i = 0; i < dpu_enc->num_phys_encs; i++)
 			vsync_cfg.ppnumber[i] = dpu_enc->hw_pp[i]->idx;
@@ -791,17 +793,15 @@ static void _dpu_encoder_update_vsync_source(struct dpu_encoder_virt *dpu_enc,
 		vsync_cfg.pp_count = dpu_enc->num_phys_encs;
 		vsync_cfg.frame_rate = drm_mode_vrefresh(&dpu_enc->base.crtc->state->adjusted_mode);
 
-		vsync_cfg.vsync_source = disp_info->vsync_source;
-
 		hw_mdptop->ops.setup_vsync_source(hw_mdptop, &vsync_cfg);
+	}
 
-		for (i = 0; i < dpu_enc->num_phys_encs; i++) {
-			phys_enc = dpu_enc->phys_encs[i];
+	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
+		phys_enc = dpu_enc->phys_encs[i];
 
-			if (phys_enc->has_intf_te && phys_enc->hw_intf->ops.vsync_sel)
-				phys_enc->hw_intf->ops.vsync_sel(phys_enc->hw_intf,
-						vsync_cfg.vsync_source);
-		}
+		if (phys_enc->has_intf_te && phys_enc->hw_intf->ops.vsync_sel)
+			phys_enc->hw_intf->ops.vsync_sel(phys_enc->hw_intf,
+							 vsync_cfg.vsync_source);
 	}
 }
 
-- 
2.51.0




