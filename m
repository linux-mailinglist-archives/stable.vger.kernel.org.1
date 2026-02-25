Return-Path: <stable+bounces-218388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RMIcKRZSnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3C18F1CA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4902730B214E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E922579E;
	Wed, 25 Feb 2026 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vh6Z0Psz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BA1D5ABA;
	Wed, 25 Feb 2026 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983201; cv=none; b=oBZdqiEzIUU/NxKn5DF/4+nr3xGpglKYWhyGcRENsITW1dBXuexT6OMyHHSnMBkaJaLT01xPPdCv8fbOmvbS1U0s+t31z7Z8MJ69XrJZlbbKLk02y06nKUSY4wFgjwIoCtGt2zxLch330iyqb3g/lM3y/kmP/p/UEbfeDLspk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983201; c=relaxed/simple;
	bh=l9uJwCHH54fRNWA2UWKuEtKPxE6cX7b82kmO36m2q6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hws6RSYfYKWZjDI1NuN8loY9oKVxTvQaLZG1k63ymiYwHOkQKHmfQS2Re7oDDIpnFUO8QKHSflsc7YxH7t0E24S6dWJxoYQvw0uhaTkZiNzGN8pueWGYEwrBEoaG7649URw/8ObE4tklyFECtDNtOiJimHlSZqzSzCxOPXokB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vh6Z0Psz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9552DC116D0;
	Wed, 25 Feb 2026 01:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983201;
	bh=l9uJwCHH54fRNWA2UWKuEtKPxE6cX7b82kmO36m2q6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vh6Z0Psz+EeHWCB63H5LVyj23T1PQbJUoHA4fKD+RRdziOesUgyFX/vl2Mw0ENKtB
	 rrz/yV/e0BR/weKoTmFxHeJyMjUACob1hPSNRPPKXxSKJFTf9wk7GEN7Fc1s2S5qAt
	 XMd2x8cC24DLAqQJ7J/sT2iP3pIL6URXi7GvAaPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 307/781] accel/amdxdna: Fix incorrect DPM level after suspend/resume
Date: Tue, 24 Feb 2026 17:16:56 -0800
Message-ID: <20260225012407.238103143@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218388-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 34F3C18F1CA
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit d19d963d2a4acb5bbf03e25733ba565a7f6e1422 ]

The suspend routine sets the DPM level to 0, which unintentionally
overwrites the previously saved DPM level. As a result, the device always
resumes with DPM level 0 instead of restoring the original value.

Fix this by ensuring the suspend path does not overwrite the saved DPM
level, allowing the correct DPM level to be restored during resume.

Fixes: f4d7b8a6bc8c ("accel/amdxdna: Enhance power management settings")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260204171048.3165580-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_pm.c  | 3 +++
 drivers/accel/amdxdna/aie2_smu.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
index afcd6d4683e56..579b8be13b180 100644
--- a/drivers/accel/amdxdna/aie2_pm.c
+++ b/drivers/accel/amdxdna/aie2_pm.c
@@ -36,6 +36,8 @@ int aie2_pm_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 		return ret;
 
 	ret = ndev->priv->hw_ops.set_dpm(ndev, dpm_level);
+	if (!ret)
+		ndev->dpm_level = dpm_level;
 	amdxdna_pm_suspend_put(ndev->xdna);
 
 	return ret;
@@ -65,6 +67,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
 	ret = ndev->priv->hw_ops.set_dpm(ndev, ndev->max_dpm_level);
 	if (ret)
 		return ret;
+	ndev->dpm_level = ndev->max_dpm_level;
 
 	ret = aie2_pm_set_clk_gating(ndev, AIE2_CLK_GATING_ENABLE);
 	if (ret)
diff --git a/drivers/accel/amdxdna/aie2_smu.c b/drivers/accel/amdxdna/aie2_smu.c
index 2d195e41f83dd..d8c31924e501b 100644
--- a/drivers/accel/amdxdna/aie2_smu.c
+++ b/drivers/accel/amdxdna/aie2_smu.c
@@ -84,7 +84,6 @@ int npu1_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 	}
 
 	ndev->hclk_freq = freq;
-	ndev->dpm_level = dpm_level;
 	ndev->max_tops = 2 * ndev->total_col;
 	ndev->curr_tops = ndev->max_tops * freq / 1028;
 
@@ -114,7 +113,6 @@ int npu4_set_dpm(struct amdxdna_dev_hdl *ndev, u32 dpm_level)
 
 	ndev->npuclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].npuclk;
 	ndev->hclk_freq = ndev->priv->dpm_clk_tbl[dpm_level].hclk;
-	ndev->dpm_level = dpm_level;
 	ndev->max_tops = NPU4_DPM_TOPS(ndev, ndev->max_dpm_level);
 	ndev->curr_tops = NPU4_DPM_TOPS(ndev, dpm_level);
 
-- 
2.51.0




