Return-Path: <stable+bounces-257475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPvVIwscG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B360F612
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA036306E1B2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7933F8A2;
	Sat, 30 May 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0Vnmv+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236C32B11F;
	Sat, 30 May 2026 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161124; cv=none; b=rgSnmKiow+hhEnb8u6yFWiQtr63gIfzKjEWk2UcPyo1Q5zNXkhkpgBye1GR1UwrKxqxJn4ogk0jN3FSNAm58+RXrb1TIbj8cWD8CdSlcOyZvcgUMzHM9dZzwEjVKdhk9QcLsgz36IyoAovphqrCCfzpMIc/sfF0p3xVUib+4RcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161124; c=relaxed/simple;
	bh=RDE0JMYQJ5IuQUDIJ+W9l/nqQtyS37gl6a0T29Rtgmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDFUmtnZgxCE/AYIq/ztaFAZUvJcdc6gG8km058gkEBC8EHu3Zdm9Gae4eikLNfxPMqfRK6nHRmC2iqRXQmpv8RnDDbyWDYmJTDvMFHRHix7vpBNpYwdLcKnUYt6SllThDc+O3oKBLpSYopftcUJCXf/01NPppdsaImNs1mD4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0Vnmv+j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57FB1F00893;
	Sat, 30 May 2026 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161123;
	bh=zPz53lYDNrjeJ3nS25/zb3wKrEdIcIlIRwu+l1Lcg+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0Vnmv+jrsXAqwKywT9sqiAb4aZY26+zLi0Utmw+sX4QTwuQwEOL+NmqX37ZGoMjE
	 wOGyUp1TyhJJlkkTNxwyk++Iy/Nq/Vcpx92/kuY50BXylOn6KUIFHDNNWTJMzLIhU2
	 8xlfYi88m8HFo1Mr1VMt8pWubY1RwppKntGqklsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 531/969] ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
Date: Sat, 30 May 2026 18:00:55 +0200
Message-ID: <20260530160315.026607318@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257475-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 293B360F612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 1b6f5e33ff93a..953192f7b6433 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -148,10 +148,34 @@ static int micfil_quality_set(struct snd_kcontrol *kcontrol,
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
+
+		if (ret) {
+			micfil->quality = old_val;
+			return ret;
+		}
+
+		change = true;
+	}
 
-	return micfil_set_quality(micfil);
+	return change;
 }
 
 static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
-- 
2.53.0




