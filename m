Return-Path: <stable+bounces-232264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHg2K0gGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:37:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40936F042
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E49F03090903
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2C423A89;
	Tue, 31 Mar 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nBJlf8fl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A840710B;
	Tue, 31 Mar 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976300; cv=none; b=uEZceKj4Py3hS4DRA+1qwoxvcevBdeenyZCw3RUU5U5z4NK6LtZ5M5rEMqLsl8nZsZjOWicSce88i5FAOvZX3Z1I5OSqiEo7FAeNVEklRsu2KRUUwKCS0X53Mabowi4gAsAWiCiMv7NidA437OsR/gTmPAieLdHI/7IlG/yKYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976300; c=relaxed/simple;
	bh=iVQdkWcZ3MJbt1knKnXN+EzgQueffzTWcwh8WWDj3Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM37iRApzTADubanIIwsbsAj3bncg1pcvper0+uaridD3ojBkXSd4YJMgCsQKTUkW3w5oR0LDxxk1m7uqgAxIAbg+959qPQ4nW03Ims4HGMal1KF4eMUecn1ykemf6q0iS/EnV2fGDa5s/bZmAhWX6EHEA34D6vdzY0ChMERPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nBJlf8fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3771C19423;
	Tue, 31 Mar 2026 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976300;
	bh=iVQdkWcZ3MJbt1knKnXN+EzgQueffzTWcwh8WWDj3Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBJlf8flMeqsHzz19Ys35h8RWPclq8vjkTF9IUV8L5SQ2Qd9C0i99Gdxp5qteLd8p
	 EXhgnjZRJLWG2EsJTBOVTQErPpPmmdb5fnQ/xZGr1Zt23vxzNHarkYNdcDdp2tZ0Xq
	 rNE/d41ov0WZe26gLpARe/2e0A6jENsj5nEuY86o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 040/309] ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_set_reg()
Date: Tue, 31 Mar 2026 18:19:03 +0200
Message-ID: <20260331161754.959520988@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232264-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3E40936F042
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 31ddc62c1cd92e51b9db61d7954b85ae2ec224da ]

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_easrc_set_reg() only returns 0 or a negative
error code, causing ALSA to not generate any change events. Add a suitable
check by using regmap_update_bits_check() with the underlying regmap, this
is more clearly and simply correct than trying to verify that one of the
generic ops is exactly equivalent to this one.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20260205-asoc-fsl-easrc-fix-events-v1-2-39d4c766918b@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_easrc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index f404a39009e1a..ec49da2d1ebb2 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -93,14 +93,17 @@ static int fsl_easrc_set_reg(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
+	struct fsl_asrc *easrc = snd_soc_component_get_drvdata(component);
 	unsigned int regval = ucontrol->value.integer.value[0];
+	bool changed;
 	int ret;
 
-	ret = snd_soc_component_write(component, mc->regbase, regval);
-	if (ret < 0)
+	ret = regmap_update_bits_check(easrc->regmap, mc->regbase,
+				       GENMASK(31, 0), regval, &changed);
+	if (ret != 0)
 		return ret;
 
-	return 0;
+	return changed;
 }
 
 #define SOC_SINGLE_REG_RW(xname, xreg) \
-- 
2.51.0




