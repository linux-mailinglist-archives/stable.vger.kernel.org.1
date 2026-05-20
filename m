Return-Path: <stable+bounces-251661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIFoKj73DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:02:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E95952AA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A93A30A82AF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF600370D54;
	Wed, 20 May 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z7ZghZCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8479136405A;
	Wed, 20 May 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298563; cv=none; b=GWh5sbDTCLbyzq5gnGSjyyTppG5YSnTKhec7n7OpRCOdq81Cp+NCCAmjQNJwELLwPWjJ41bvhEoeesvSkP+/FFtpAb+sZPtLJ4FVyGrbiTiq6EA4cjshOKLtxPB8faalEl1TeR58yWIk9aC1hNM5f1bpJbczxzugMIQS6ZWHDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298563; c=relaxed/simple;
	bh=e/CPLpCvbVRaL7fiCZaTFd95mHrbjURfG50GpiI+Fno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNJ+72RnNofYuTdASG1n7iTViiHxA+GL9tS5q9yv8Iq/f6FMx+GRWN3Kvm9494qEXmSWcHZ5LfZo+iALBvZ6rY5OKL8MzA7uZtpLXEUINVHWVCSGNp2WMzG4T2uVUI/XJDO1dW9yO32Xvr8wjhzzcD+QwnqS3lJeAnRAGM2/z8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z7ZghZCA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB21F000E9;
	Wed, 20 May 2026 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298562;
	bh=Kdpg6A65bT0HgbGEPxbG6aT3uZV3q5wlwwhKdgWp54s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z7ZghZCAtesnI7ONqqDcZVG57VLXy3R/lW+V7Sc8JJLwIhOrnfczTNO2cCNb6CSka
	 j7JgOdtz/QVwGeiqE9PmBH1pS45mFKVSEott392CIdFx27p3VoJugvp2YzafnWEji3
	 nFDzroW6QjDJvbADE9Nv/BF3tsNRYGDjpExjHvN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 458/957] remoteproc: imx_rproc: Check return value of regmap_attach_dev() in imx_rproc_mmio_detect_mode()
Date: Wed, 20 May 2026 18:15:41 +0200
Message-ID: <20260520162144.454855268@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251661-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linaro.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 618E95952AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit a48c6676912fb808d2af1b8344d8656815a3e108 ]

Add error checking for regmap_attach_dev() call in
imx_rproc_mmio_detect_mode() function to ensure proper error
propagation.

Return the value of regmap_attach_dev() if it fails to prevent
proceeding with an incomplete regmap setup.

Suggested-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Fixes: e14168bf3493 ("remoteproc: imx_rproc: Simplify IMX_RPROC_MMIO switch case")
Link: https://lore.kernel.org/r/20260209051407.1467660-1-nichen@iscas.ac.cn
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_rproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7ef99eac37f1a..8fa81d3779849 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -899,7 +899,11 @@ static int imx_rproc_mmio_detect_mode(struct rproc *rproc)
 	}
 
 	priv->regmap = regmap;
-	regmap_attach_dev(dev, regmap, &config);
+	ret = regmap_attach_dev(dev, regmap, &config);
+	if (ret) {
+		dev_err(dev, "regmap attach failed\n");
+		return ret;
+	}
 
 	if (priv->gpr) {
 		ret = regmap_read(priv->gpr, dcfg->gpr_reg, &val);
-- 
2.53.0




