Return-Path: <stable+bounces-242264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INA2JPh/9GmXBwIAu9opvQ
	(envelope-from <stable+bounces-242264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:27:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A64ABA08
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D55A3303E12C
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A338758C;
	Fri,  1 May 2026 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSbWxuCB"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6E3876A7
	for <stable@vger.kernel.org>; Fri,  1 May 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631177; cv=none; b=MaqCU50qpvNj9CccIRN5UQIl/pWDFtCGRY45M0guIZbDXK+O3CTEFnEOLu5nGpE8lV73jt/G2W20XDNyJbtW8qGBu6e9flY7PhcAzw32m7sZi6YDpiORJt92B4hgy0c39MlhGPsZGhQEw2ziGYr7Y/5NZVnYCFb26y0kC1HtskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631177; c=relaxed/simple;
	bh=RfgrVvknme6vhAOFjjbtHTulvqGle3JEa4VWxijNxXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJ49UBUzaBvHWBnY/sAe9e1jL1bZhuZwHwcPd9M6Psjgn3Iq/Q+PYW7UJwJZVsBw44jUs/e64DwmnTIsZm3rp3kl/TL7evfV3VLbxN8GsXZyqdIjqt4Ank6FaPhSleE9w3nmcYmHxT/fm7jQqaqMw0gOVqcmQqJN8CIgo4Y6g7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSbWxuCB; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12713e56abdso1278415c88.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777631175; x=1778235975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjBFmY6oME3TcUT9msMQ0JkYRg8U/8GzZccCOVqrKM4=;
        b=GSbWxuCBXPTkIyZx83x4CzYLnThWPFB7/IsNQ1foABe1Lj1gkqvMghqWYz4H7MZ7K/
         VI93VynO2oM9kM/SaUclaUZGFfJfApWYKCGgTyQ82buPiYfeSM5wQlEWm5vid8KR0skO
         0BXVoAwgvS1YxjhV2o2IKibpLKl8qQoJ/qXTOjn2QpDsvADyXSJ9YgWQvdUCSZctLr/r
         Ymbmo5xYTfFgyjmH8PicSG4MafHBZ3Ngyi0/2e5ilfc+jX7BkZBqMWg20i/kaKl2E59u
         24RGQStwdrj4/d0v2f6lktq+R2O/32/chz0j2SfPkQGs0tt1hcyAZ6roGdCEis1SXbpz
         TdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777631175; x=1778235975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjBFmY6oME3TcUT9msMQ0JkYRg8U/8GzZccCOVqrKM4=;
        b=BvgcG2eONi+0pQI3Qd0qg2x8JMsauNnAgcYm8wZcBqGss3kmR+82oq+QK5I0FNJDDi
         iVsaTahVvpUTjkLprVji3ZFYeMFGzzDW21MpuenT4yTJxey8hY127k2hOmyhdzigXHUJ
         2F12rpUflFFQetoaGo6zfRVjdR8n8RwZbI4OaFcUzWtsr5VUpJ4pfnvmwjaCb7/DInTH
         5bKqMa+R5TXsQCRobY+E6BW4L3svdupKF7rpMIOf0YEgsBUegpWBkStj4r5kA2P+B+4g
         XxFCzSkPkMvDz/EPCNSje064X7NlLmz8wVCefeyAXvCYXwv7/bJeyq0t1vDd2nA3VAVu
         ODxA==
X-Forwarded-Encrypted: i=1; AFNElJ8izT6KHK9osETe9YHx4aDruO1fD8GHXd62x0V9drdfrBD5KrRXo7xPJbF1FoN+W3S8Vt4enYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2V+cvBmOsW7BnMMR3V0k+MVh+29DXtQPMPCoB5N8zj3+Iwhos
	1ip2ARVDgPx5iqK7qmEUihT0rczwpy/ZzEIVrvSgt8Vpa2lTL9jq0uqi
X-Gm-Gg: AeBDietE6LJf3x90NG140lhDfi5lrNvXYUwVP+7ltvd8nlrmp6foV0fC4ZFqW+u72gP
	kxwX2P6jEi76u/DJOrB/EAxik18gGpVT+OfyyXtMgf+idbjwsk5BinKayRpLAuMrHKUzjCpyYUx
	ic4s5ncTNZ7dXkaQg8CpoKY3R/0Gzmtsrr32qVEIe2xLYW+iQ8Blg5WNoMmoIT0fkOSmV5KBSGY
	3IBRCi2DTueeIp/n6PFdBinPc4BrpC4aJiCbFX2S1x3Z6UsIqoc43esEcFyW1c02vRQFS4KoGPl
	gNlxm1thDJxOenDba/fAkKxV6iu1Qii29afPOu45wC8SgS+EqyydltUuNC0JocsEAx9cZQycjZ+
	UHuqwtAOxAX1gTecQVMbi/JH4lk1qJYZruWpYH4AxLB77336lYUHWDe3YlQtjgnzns0FaBXJqas
	B2Ta9RhNWyh1Zh1OjYJs9MDSqTyY2mGoXNF5np0qIzIObGJNdZrPOE1SMMpJXz/8ssPCmpMGuIs
	4TG5tN2pTp/
X-Received: by 2002:a05:7022:6087:b0:12c:1288:ce63 with SMTP id a92af1059eb24-12decc27261mr2509922c88.13.1777631175407;
        Fri, 01 May 2026 03:26:15 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df84250f1sm2621191c88.11.2026.05.01.03.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:26:14 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 01 May 2026 07:22:13 -0300
Subject: [PATCH v3 2/2] ALSA: hda/tas2781: Cancel async firmware request at
 unbind
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260501-alsa-hda-tas2781-fw-callback-teardown-v3-2-8d9f873b97bd@gmail.com>
References: <20260501-alsa-hda-tas2781-fw-callback-teardown-v3-0-8d9f873b97bd@gmail.com>
In-Reply-To: <20260501-alsa-hda-tas2781-fw-callback-teardown-v3-0-8d9f873b97bd@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2250;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=RfgrVvknme6vhAOFjjbtHTulvqGle3JEa4VWxijNxXc=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlf6nfs3t1hdLxfZ6JxjNJv/rtrFIIOtf2V/Sp10pM78
 K/Kq/1SHaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjCR7nWMDOtPtfhGXW7b8W45
 g+ofHaHW5GzGRwGF346GejO8bLs525nhr/zerSd9wth0XgTE2HGFKTgf2i5qoZSVuugqp+erhKU
 VbAA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 163A64ABA08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242264-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

TAS2781 HDA I2C and SPI queue RCA firmware loading from component
bind with request_firmware_nowait(). The firmware loader keeps the
callback module pinned and holds a device reference, but the callback
still uses driver-private HDA state.

Component unbind removes controls and DSP state immediately. Later
device removal tears down the TAS2781 private data, including
codec_lock. If the async firmware callback runs after unbind has
started, it can operate on state that is being torn down.

Cancel or synchronize the async firmware request before removing
controls and DSP state. A queued callback is cancelled, and an
already-running callback is allowed to finish before unbind continues.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 3 +++
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 67240ce184e1..dd1b0cc63ad6 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -588,6 +588,9 @@ static void tas2781_hda_unbind(struct device *dev,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_hda->priv->dev, tas_hda->priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_hda->priv);
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 0e4f3553f273..d243baff95a7 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -750,6 +750,9 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_priv->dev, tas_priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_priv);

-- 
2.54.0


