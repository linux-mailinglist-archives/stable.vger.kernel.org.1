Return-Path: <stable+bounces-240486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKMxAKEb6mkOuQIAu9opvQ
	(envelope-from <stable+bounces-240486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:16:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 919CD452A34
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FE3E308DBAF
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B03E3EF665;
	Thu, 23 Apr 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KljHhsBJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510B3EF0B7
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949904; cv=none; b=EaTPVP/Oc7stSNzagmQm50kz6G67GrkjFCwMVHqyi56Hrx3sW7wWxMXwNZe+HoMC7PLBPYG3UKdh7ZiktFJuHUChhqKMPy2zpC7XMKtFnXQx1l6tDiP0JCoi6JBoaYharqFbapsM5DPqDtGVuIr3pA2B5h+N+iOY2UKKS67zGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949904; c=relaxed/simple;
	bh=ejM1Zmsj5fEcYO+eOjD7aSvSj+6S4bU9vJee6fm5kjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vl6JKdw369U5lQv2Y9FwLnZjiLSu2NAF/ZKP4gVoIxOfyiczLBPV9lEe1TlH1MO47zWQLCFTd9WH65rrhAyJ+lUeFOrmBH5GZNGAm7ItoGd/X1Ue+tSNP73W/uGbNyA1zXNsp7jfVKsEelNcIqGE3p0zGS9B/sDd8Hb+hFZcR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KljHhsBJ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso5474519eec.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776949903; x=1777554703; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sF0+se07evB4kXx7iQu5RCnYJG9uujVMlzreUGv6DlA=;
        b=KljHhsBJjA86ah4HJEGytG1NoK6AudumaRRcEAMlsnYvlnGn1CPRt56SJNbgXdt5CT
         gPD/G/XwATcIP1lMkhDaeKyVkP6ttuoXQ2fH0d6y0L1iWRDuYaDkN0MpXJc5SpiqU3aC
         gf1V9USaIhAY3jziWCSUuD2br+Cxp3WBRDDGfwyhtYORcnEuXpuz4M6WHHxvW1NibNKO
         NDfm5e+IrBSMzbSzkunKvN+I7kFoimA1DsCs0lm3bYNxq1EC+QYR3MffYAhMpucQIRHa
         1PpTPduIVR7iTKY6oSqGNElAGynS4NdRYSGGfynhHiK1Ek4WRpaWqV+Y2odWxZ+DQwkh
         JcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776949903; x=1777554703;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF0+se07evB4kXx7iQu5RCnYJG9uujVMlzreUGv6DlA=;
        b=iu994HEHOIvIOKS7Bcuvn7vmg6VagvwMD/DwLr1twre9D3fXuVibowRaL4kQ2s8Wow
         /5AQlcay/tOX6aSRP9bD3ItRVYXe2sKfXxzpc58Cledn7zC4FP+yn1iHDBr4HgExpSdo
         IpgznwNR6unVx62iUpXl1400ZjVMwYt0HKo7RLDFYgoB3rzg456/pI4h3o9xYCEbvW1X
         q/6cBjpfRB9hjelpj8QnK8b0ATZ143NWNW/UfHQFbe83dS+HT2BqmwTf551IfRZdLslx
         B7Ix1JgOkd/t6mNzAUiRPNbbn01eNQnuzthZ0T+CGpRZRBjMdPPJ6n79a6IMxO1gifsr
         Z6bQ==
X-Forwarded-Encrypted: i=1; AFNElJ91Njy1Ihu2p+pbk+MkEAmYK8rUqZSiDMy/LEd7SDv1P6aySwGC3yX0t9iJFbY6T8km0qGttuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx427luo3ZOCy30lDZUIyp4llS/kc/+l7uYiIVxq2DyO0mVtCFk
	RlSoEyveyxTyf5vCPwyl7eJCQ+DdyWwDA0fhYXzhKOMIP4Jh7j4JQD7S
X-Gm-Gg: AeBDiesOK+IxQMDunVa3p6WQMDR/wvhitfpqD481sEzlHIbS2IPpOimOtOrL/AmePwU
	Hx3w8+pdw12XT7n1W7be/rY62gcJvu2b+5W8N/GIs7rQQb1RsCrpQ8Sqa7CKUA1JfEkEF+LiBHg
	wsPIxwcJnqzIoLfw30VA2ak4+4NyyojwBvNiYCtWfItYp8ZTZR+BrIY9Vb9Cg66CQ9URDNJrSvu
	y7y6FK3Va1xpg0EdSckRxSvt60RJX1ujNZ3L6IKdtBD08dc1vpnKWWGhlgjsrnaHH1MT6kJD5ZQ
	XrKozIHgo9Yt0EVv5bwBynUyTjbKXrhjjAAXGzQUqB07POPpcDdzyU9Fj1zpVi8Drh43u9oqbIo
	mc/RmIRfaZ4CFVm+h/Uvxnk5N+q2vbzNJJ4NpYXZAd8a58+EvsGz2xCqsrGxje5bJ6W4CwCx4WB
	9jD2sXzT2HNQsagzIcsWguj5fHxmq7EDOThA8kFDT06qrDNrsbK3RU9Sz7YJxXXX42ZIsyDMIiF
	Ut5YxoVbTnX
X-Received: by 2002:a05:693c:3011:b0:2df:7882:1cf3 with SMTP id 5a478bee46e88-2e42c15cf81mr12036056eec.2.1776949902444;
        Thu, 23 Apr 2026 06:11:42 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm36088988eec.29.2026.04.23.06.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:11:41 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 23 Apr 2026 10:11:31 -0300
Subject: [PATCH] ALSA: hda: cs35l56: Propagate ASP TX source control errors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260423-alsa-cs35l56-asp-tx-source-errors-v1-1-17ea7c62ec31@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQqDMAyA4VeRnBeIrRXZq4wduhi3DrGS6BDEd
 183j9/l/3cw0SQG12oHlU+ylKeC+lIBv+L0FEx9MThyLTWOMI4Wkc2HMbQYbcZlQ8ursqCoZjX
 s+prYu9B5aqB0ZpUhbf/H7X7a1sdbePmF4Ti+q6CooIUAAAA=
X-Change-ID: 20260420-alsa-cs35l56-asp-tx-source-errors-8d10c3258304
To: Takashi Iwai <tiwai@suse.com>, David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, 
 Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=ejM1Zmsj5fEcYO+eOjD7aSvSj+6S4bU9vJee6fm5kjg=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmvpDrkPvv0JZwTMRLcw2/GlepVUtzkuf7zzdkTLbtm5
 5bGTF/SUcrCIMbFICumyLI6aZHlnq4HV+vjVnjAzGFlAhnCwMUpABN5YMbI8JZjdv/ZyTb7zjca
 LJ+4zv/doZjXu9VfN5XJ1i5ZL57il83IsOSJFu8peQ65zYlPHOMeOi/R55/04Oedu16p8asFW9g
 +MwMA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,opensource.cirrus.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240486-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 919CD452A34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cs35l56_hda_mixer_get() ignores regmap_read() and
cs35l56_hda_mixer_put() ignores regmap_update_bits_check().

This makes the ASP TX source controls report success when a regmap
access fails. The write path returns no change instead of an error,
and the read path continues after a failed read instead of aborting
the control callback.

Propagate the regmap errors, matching the posture and volume controls
in this driver.

Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/hda/codecs/side-codecs/cs35l56_hda.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 1ace4beef508..dc25960a4f23 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -180,11 +180,15 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 {
 	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int reg_val;
-	int i;
+	int i, ret;
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
 
-	regmap_read(cs35l56->base.regmap, kcontrol->private_value, &reg_val);
+	ret = regmap_read(cs35l56->base.regmap, kcontrol->private_value,
+			  &reg_val);
+	if (ret)
+		return ret;
+
 	reg_val &= CS35L56_ASP_TXn_SRC_MASK;
 
 	for (i = 0; i < CS35L56_NUM_INPUT_SRC; ++i) {
@@ -203,15 +207,20 @@ static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
 	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int item = ucontrol->value.enumerated.item[0];
 	bool changed;
+	int ret;
 
 	if (item >= CS35L56_NUM_INPUT_SRC)
 		return -EINVAL;
 
 	cs35l56_hda_wait_dsp_ready(cs35l56);
 
-	regmap_update_bits_check(cs35l56->base.regmap, kcontrol->private_value,
-				 CS35L56_INPUT_MASK, cs35l56_tx_input_values[item],
-				 &changed);
+	ret = regmap_update_bits_check(cs35l56->base.regmap,
+				       kcontrol->private_value,
+				       CS35L56_INPUT_MASK,
+				       cs35l56_tx_input_values[item],
+				       &changed);
+	if (ret)
+		return ret;
 
 	return changed;
 }

---
base-commit: 876c495d412ef67bd4d0bdc4b74b0bd3d9f4e890
change-id: 20260420-alsa-cs35l56-asp-tx-source-errors-8d10c3258304

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


