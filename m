Return-Path: <stable+bounces-251489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLnpDG31DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-251489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1026594E97
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDF53308D53A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8DF39B975;
	Wed, 20 May 2026 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/SJ4Tlb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52564331220;
	Wed, 20 May 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298116; cv=none; b=mruXWXVvO+2NLKaLm8KwhehoPfAe+viTGWEJqEat0PoUcVE6blfft2nYPIKbi9CRVtLkrMn/QuLocqXCgDV9MW+YAOpmpImfpcwQ/CrRKFer3q90MgQLe4duQ0GW80BuSViJwukkvN5VB4RhG/cHzwB6jJYoA+sb5IgOjyg+vio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298116; c=relaxed/simple;
	bh=fBJ6d7c1bzBro+YKVQcfehTlBj3EVp1fS059w54vHIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnc/gFf3Aojg7EEWd2/4s4/V1DKLgFd6kfwEc5BN/edHepb9GdegY9fcKIYk8l640gxAzV1b51rh6ZnMPR501e4Jep/riJH8Zy4rtJqW2/drYUvSavvux7mdnLdhVZDDzaerYTXEtre6iXhC5azd0wMVskpvW4NdQarW5DkTCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/SJ4Tlb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71081F000E9;
	Wed, 20 May 2026 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298115;
	bh=ggUzo0RJuyuKwZk7TbNk75a3n17WQteAXSFel/Ej1aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r/SJ4TlbMIHfsORWT48x85eVnjMRXBsLxfoyivQ3g/BNeJVojFDKwoTFu5Pf8Zmo5
	 KGGDrCz4+9+HhftsMOqd43t+t3zD/Lg5CO1+/r9InFq0qT29KsBJS10FvbqdaeJfRf
	 mhifvaSwYl+jwur5GwzrewAkzV0Mbf/Xt+ccqPWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 288/957] ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
Date: Wed, 20 May 2026 18:12:51 +0200
Message-ID: <20260520162140.784215259@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251489-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: D1026594E97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit e5785093b1b45af7ee57d18619b2854a8aed073a ]

ALSA controls should return 1 if the value in the control changed but the
control put operation micfil_quality_set() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the quality variable.

Also enable pm runtime before calling the function micfil_set_quality()
to make the regmap cache data align with the value in hardware.

Fixes: bea1d61d5892 ("ASoC: fsl_micfil: rework quality setting")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20260401094226.2900532-7-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 980c6e1d9b1ce..09deb880bd37d 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -210,10 +210,34 @@ static int micfil_quality_set(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
 	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(cmpnt);
+	int val = ucontrol->value.integer.value[0];
+	bool change = false;
+	int old_val;
+	int ret;
+
+	if (val < QUALITY_HIGH || val > QUALITY_VLOW2)
+		return -EINVAL;
+
+	if (micfil->quality != val) {
+		ret = pm_runtime_resume_and_get(cmpnt->dev);
+		if (ret)
+			return ret;
+
+		old_val = micfil->quality;
+		micfil->quality = val;
+		ret = micfil_set_quality(micfil);
 
-	micfil->quality = ucontrol->value.integer.value[0];
+		pm_runtime_put_autosuspend(cmpnt->dev);
 
-	return micfil_set_quality(micfil);
+		if (ret) {
+			micfil->quality = old_val;
+			return ret;
+		}
+
+		change = true;
+	}
+
+	return change;
 }
 
 static const char * const micfil_hwvad_enable[] = {
-- 
2.53.0




