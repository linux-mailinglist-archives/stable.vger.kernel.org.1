Return-Path: <stable+bounces-250403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJCpBwUQDmrB5wUAu9opvQ
	(envelope-from <stable+bounces-250403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:48:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB7598C11
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D21DC32DD7CC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7E35201E;
	Wed, 20 May 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIwKYN31"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0534041C;
	Wed, 20 May 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295323; cv=none; b=lu3NwrajOFQrXoE/baWMr16dS+GQWfraL8pA9egTzW5VXIwSmGDEtiW9UP1RtDN0OTTR+idtBcSzoEOgdMwjE+CugKHLeq+yMnWU6UZ1xTfWuoTWWG9RfCGXfk+eTsYH6b88ShjGu24UwFzd9gJ2QNX0KHbbC5X4s8FY2AlZUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295323; c=relaxed/simple;
	bh=JBwV0Kx1mlCs1Rkep4SLLLK7jzxRBkqUyt9TqP8PjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGREOSZPYljjse1F1EuKmaOFB4I4xxLHPLv5LpZ4Kr+bl/UF8hfJiPGXjogGOIaVH9eMsi4gyK7r/a7/5btwQ7WbU4D0WrPTuRyLm2w7VO6Ii9W4B1bkJSaNeEATTGjKUjZgz4opkSYRnUgU1QZBMDlbc2Qux6g4PGSFaEDu/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AIwKYN31; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FDF1F000E9;
	Wed, 20 May 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295322;
	bh=SvzKr2l3URApJnPho2tznW4TJEQ6XOeDUOmj4VSh9mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AIwKYN31YjHraIOZj+mBPJ/RtLAuwFOfhMd6QJbxz7039Y/+AUKWCfWePe+M5o2hf
	 ZoPJLKuSls3ErgwwyhMYeeC5tqCE9LrT5zzCyjyk1fKE7HERz0JXtN7ct8Etu7Pz4i
	 m0DBERs44kXrR4XSIlthNlQtUd/QhjnnjZhzYLcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0374/1146] ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
Date: Wed, 20 May 2026 18:10:24 +0200
Message-ID: <20260520162156.664354707@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250403-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: F0EB7598C11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 983805bbaae27..2e887f1f1f361 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -289,10 +289,34 @@ static int micfil_quality_set(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *cmpnt = snd_kcontrol_chip(kcontrol);
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




