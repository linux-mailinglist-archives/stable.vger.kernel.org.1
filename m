Return-Path: <stable+bounces-217255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKytOCWXlWk1SgIAu9opvQ
	(envelope-from <stable+bounces-217255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:40:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 324881558EE
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFA86302CE1E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E12F549F;
	Wed, 18 Feb 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv+fghfg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CA2C0298
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410333; cv=none; b=d3UToGO17SX10j+H+dDl4c52tGcLPC6dtu3e/WgTU2eWBm5boIWCiPduMdHnCnmgtik17jlE2W//aUop4pKW80tBYUxQnT6tw8tZKV5cc6a4QY8IBV48RF3DlTr5mY4kHB8dhGNLNZoNVxa+VUVuPH1hZMewejetEudT/ayeqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410333; c=relaxed/simple;
	bh=k7H17ODo1qIu2wLMBILMgN4iOzh7MfTww2lLpZnSr+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dERXVADFMIxamamoHRtYPLofmBov2ldlebQ1419lvFYQ8BdWdbERgh9zpg1jvEJNUGo5obSs7hrHKz8y6/Nh00gmrm/KO69CXYYtS/b7nQcnafEdQ4fy68nyYbAyqsF0tsdRsD8vP8wNm2WXcZs8dlbQzG3KXp1KCNNLLqorGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv+fghfg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3932664f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771410330; x=1772015130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7NQZxcZg1dcvkijLdNdTKqEfWFpZRniREp+8Wrj2iY=;
        b=Sv+fghfgU0UPJvJ5WUGlNXSgBg6U5bulEgJfdUCWP1DcI9bJHiLUOHsX7ZVKl+5iJq
         WH7m/fLcv1LmswUDxdrvHpRXdN/Vo4a74BmSJAlDD33bc6gUGIfPFThc2hW1zmJT5zcq
         Ty4SpeWN6Gjnrq/2PiIqPSVnEBzgVoFU12pPaJGNFBH1uBvkcTYo9PGGTyuOTfBP+3OF
         YsxF12mjFQB64rLIZBqbYAgRsPZPtELdvhnhBKouzTlAUgagJKxcCxHsldBuZv/bAiTB
         LlwcyOcY12TI3qC4eonHy/ECDHFwdwEVyCAP82oU5H0fFyKWKVSAK72DeosOgdSRVm2J
         pmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771410330; x=1772015130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q7NQZxcZg1dcvkijLdNdTKqEfWFpZRniREp+8Wrj2iY=;
        b=wFSN5T25T3QJlGQZXTQItVluDaQqbAkVbIQSEr1fBXeRarWqOlN6HJy1uHc48XVVt0
         9nzBw2HxLFPd6EtiCEqGwXQvtgHofq5mf+jGULWeEC9WcV+Po9YidxFDdaAIOlSe9C0f
         Tqm/CTOxnb9UImosAsb8dfPXZFB4kisjQO7hThFlGsNLRUS16IpvTB/JMv3UFbg62aHm
         MiaNl59w/kB1eIVGVVN26sjkIKuno8kCJMaA09oQ4ll6OKizDMi/SqFGA39xq/m6t+6c
         JPjZO9BphADuEC8+UKlqyju0bLQ5s/WDsNMu198d1zldvK5Kup/UtZNb8kkg9ehHkbtA
         v2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAfRboc0quZ3a3at4ChsRkTC5ckABr8rb2fN2cXo4LuiKqmpJ/MWMqdsoRwp7ou/xefezq+1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKden3JRf8Xc0i1QQwnfKnGBNEMXxtnj4x41/yegJKwFfnUuC
	hkhPYYuHxZVi7GGiJGeMx+EURZxHa+PGmJhsBqWtUqXczesvawOlzphE
X-Gm-Gg: AZuq6aJFhbwcPF9AlfRFSFvwsWkQsWzQkRTFjznA+Se4WxR0YAb58eoUavjxas0QNvU
	P8ecvYF1L99/SAFDKcckriHj3YdH5b6zLVAg3gDlXYDagYlb5g3kxt43OWC7WwVlpY4EKoZriQV
	tHuEkntwxErsZprajXbJlS2OQmHpAVqVo0VsfcGZQ7SCgqplJYC0YH/OJ7QhI8ym+hRk2XMNGDj
	stMNITDHKsIHPaPGYebpv5byTPoqIJqmD1V6p/fOSP/1/H9wfv28gYfBWK48bsxJCwFoYVQr9CL
	BSP+5plRHGcf0rjTz8UjYOhbVaJSnxdPrKlGOhptqJkGdroviY50gxFxw3CUcck8M5FcnPGgo54
	Z1Gss1oGVu/dBPdd6fr/ipfjH+xoF2HnCbx7qX6G6Gir5bUyRvvIBfQg04tbfGE5dkOLcuie301
	YtD8bMPo6HGrYNoMhQVvIazt/68jr5/WhFzQuifYpWJiitf5kgX12fyMHLQe2mLF3pvfeYhmq70
	nNHLMeDTFZU6QAV/uZPrKtZVPTkCdht9k86FR5RSxPfPO14BMxImT5cGyDoBXX8jhDH+tCzU7zw
	8nulwmXwd+AydbtFSRSqEFCuGiuU7pY=
X-Received: by 2002:a5d:5d83:0:b0:437:6b6e:d114 with SMTP id ffacd0b85a97d-4379db9800dmr22987142f8f.30.1771410330122;
        Wed, 18 Feb 2026 02:25:30 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abcda5sm45039616f8f.19.2026.02.18.02.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 02:25:29 -0800 (PST)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: pf9453: Respect IRQ trigger settings from firmware
Date: Wed, 18 Feb 2026 11:25:14 +0100
Message-ID: <20260218102518.238943-2-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218102518.238943-1-fra.schnyder@gmail.com>
References: <20260218102518.238943-1-fra.schnyder@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217255-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 324881558EE
X-Rspamd-Action: no action

From: Franz Schnyder <franz.schnyder@toradex.com>

The datasheet specifies, that the IRQ_B pin is pulled low when any
unmasked interrupt bit status is changed, and it is released high once
the application processor reads the INT1 register. As it specifies a
level-low behavior, it should not force a falling-edge interrupt.

Remove the IRQF_TRIGGER_FALLING to not force the falling-edge interrupt
and instead rely on the flag from the device tree.

Fixes: 0959b6706325 ("regulator: pf9453: add PMIC PF9453 support")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 drivers/regulator/pf9453-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
index 779a6fdb0574..eed3055d1c1c 100644
--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -809,7 +809,7 @@ static int pf9453_i2c_probe(struct i2c_client *i2c)
 	}
 
 	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
-					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					IRQF_ONESHOT,
 					"pf9453-irq", pf9453);
 	if (ret)
 		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
-- 
2.43.0


