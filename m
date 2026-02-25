Return-Path: <stable+bounces-218316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMFMDZdSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A444B18F42D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26F663126A62
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9A251793;
	Wed, 25 Feb 2026 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaFBO+cq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32A24A05D;
	Wed, 25 Feb 2026 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983119; cv=none; b=am18fk072hAPEZy5pErr3J5KupIKPNcgQW5mxZsvP2K/cbz3gV7uklgp+AP2XEpGYQZhIAI744xq0NndWVgJzgLmAeBwh4s2o1wzql71YhDpgMy4VI/x3qOqZGH6phFWu0v4xoJTaOzi12N+q6mJkW2NPBNCHhYMe4bcPawAuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983119; c=relaxed/simple;
	bh=ZzcYt2BE+TkSO4toOYyfAfwIgY5RX6pPEiakiydwleE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOi4NB5y48ZAnUMz9fkWv3M4YlXcHW2TPMNdzN0vrwcCi81/p7fN98Zl+jNcClqGMDo2dRCVb/eCstgfQp/zvgX3VHPEk4/G1+YFnYFVW8DLBMwg4nnfPI6CzeV3Vc8gd1AWOX1JP9MJoct87pJywsiJ6r6QW1Pi7q7qpTz5kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaFBO+cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E9C116D0;
	Wed, 25 Feb 2026 01:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983118;
	bh=ZzcYt2BE+TkSO4toOYyfAfwIgY5RX6pPEiakiydwleE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaFBO+cqb22OWobRQ7UoGtlSRngeUo1Jv5k6BfzpzC+AY6knctfVep4dhWRumpE35
	 X8dH0aNyU1D1ubAwqwoEQfd+lONhBdJpajCClambzh2M64JW+8RRefdZH7C62C9GvT
	 E2GI4c9vzS2c3BDXggZuHoOrcXSIR7s6WVENZohI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	Val Packett <val@packett.cool>
Subject: [PATCH 6.19 278/781] drm/msm/mdss: correct HBB programmed on UBWC 5.x and 6.x devices
Date: Tue, 24 Feb 2026 17:16:27 -0800
Message-ID: <20260225012406.514306843@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218316-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,patchwork.freedesktop.org:url,packett.cool:email]
X-Rspamd-Queue-Id: A444B18F42D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit e6177c7a2401b87b016728b75992926971d871fc ]

As in the previous generations, on UBWC 5.x and 6.x devices the Highest
Bank Bit value should be programmed into the hardware with the offset of
-13.  Correct the value written into the register to prevent
unpredictable results.

Fixes: 227d4ce0b09e ("drm/msm: Offset MDSS HBB value by 13")
Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/699274/
Link: https://lore.kernel.org/r/20260119-msm-ubwc-fixes-v4-1-0987acc0427f@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index bf9a33e925ac8..910242f5a71f2 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -229,7 +229,7 @@ static void msm_mdss_setup_ubwc_dec_50(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
-		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
-- 
2.51.0




