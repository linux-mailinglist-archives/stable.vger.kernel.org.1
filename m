Return-Path: <stable+bounces-242209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHnrDtLG82ni6wEAu9opvQ
	(envelope-from <stable+bounces-242209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:17:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF64A8179
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1BFB3063A85
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186C3242B5;
	Thu, 30 Apr 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKxwnJEG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A329D26B
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583733; cv=none; b=S3YRe2IXPZKearxAvHutu6vwkzUokI3i9cEUZa/YxZr9L2rJPbpcUVU1Rglo3/efs/h+iAIfxFe3hxbfgQMuTn+SkAnziejGakHFfsFItFUDjagg2wVcKClReYrDQbP2yH/ghYoz3TWJg0cxtxZfQuyuePZcwtGzLlLKEL31Lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583733; c=relaxed/simple;
	bh=a2/4NZb1cq6S5TUZgGQmvZJsMsttNjgFGxtg5rSSmVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sW7SKr45CWRW1xSJZX0L7o/M7e/DcyIr8bLvsuEIUO2GKVu4t1Qx4q4uAmAnCelrmshX02ibaaHFxbM2uW7qb5ABPdGCv8slsJ/qlMtiy6w77jp5yvyV/I8ZsuYIi9+85g5R9VYfZcCk6je4p0due9FZTlvOSEW6im+PZlqu5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKxwnJEG; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2098781eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777583732; x=1778188532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5HU0juTrz/+bwfhVRVrLsU2IXIIJwo9lCW9lyuPHrs=;
        b=kKxwnJEGCtsHTgv4VoUkOt1Th28Qyo02lxw30BFbeDfYQyLew/K+5otDe21Ogss4eG
         6BJitBwQfeU0jaKi6qb3nEfmaQXS5oO04PLigJyVNMpGG2SN0AHpgb+BxCQdkReRZUzo
         ukgcnAC/z8M7FBNJy4SI2IDxqJap0IWqkXShs2ou3A6DOclsLEGzE/m+Q9dLyTmQA0zn
         9OCtZfQa3myC9btptJeW2wh5JqNDZtMagARtDC9vrKiOSub6QqcuoBu8dzcbPaGebBkG
         hxtvXpTfE992B+mz1ZeGfh4QIe/WCIP2ylM3oCg+ym1IbmHd9Y8MGcz/WEoWkdHonTTO
         3muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583732; x=1778188532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u5HU0juTrz/+bwfhVRVrLsU2IXIIJwo9lCW9lyuPHrs=;
        b=QRC8lGDB4lj1jh/ROMgjqV9f3XZd48fJGm4uZ+aP18IppfoJsFZhKTMCaokfljhkUD
         hzPvzlB782eodTriTf1mhuBCvLU39kc4oQs4CTmInTne0LrZp+y7ctubbHrhid6o0awP
         FYUJTHPjick2/SekfWToPiVzqLCEjcwXiooOkTFDWxpCma4bNTjnbgLpLDh2e6HyiocL
         boNhvHK3Ni8j4moM06ah+YtoJm5ZlBJVID7P2qThDS7n2CBsv2JKNFubUQJmF6ye1Pz4
         nZKVf+1JEjlHPbVMulCeWFfN5zM9IqOmVXOFsNT6SVCi91sOFxaWeSUCmp3RFKv2NHDx
         0dVw==
X-Forwarded-Encrypted: i=1; AFNElJ/5bId6vX51AQKw1YymReeyCyseNXNm5cradU7qSSA8nqdU4yuxv5nvIEmBFV2zpCp8X8H5M+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUywZVMjhiUp0FKA7aSe94hzAdQyuN2+t7X/Ds27CsqkCR18bD
	gBCafhNCecQZahuaiSGVn1ESetgy/t44DUU6a+XNWv83XkXD7iuHYGOZ
X-Gm-Gg: AeBDietk1ZZsZSLR0bqn+xWrG3xCoH5YnZqKYonNyziyiv0IAfdWNr+cLJrsY4R5Knr
	EB8ypOTpNZDuh5RQW5r3/mFe6wS9eEdnzqnzDL8Jy8IBLGezqWAbKnkNvlPFEpKIL+4GYc3sFfM
	mQ/yU/M2m72IY5alf+YSMFgHtN8jyyr0ZnCGQ3fDYiXwOstz6mseiCTcyjJt1BTdMQo6bWzR0Qz
	1mFxuLAWs+h8rS0YX1ye9Y2uqcBeQa5rHeD7Gw2fReRDW4bK+skpbAQn0Gt/+x3aIRCDe875CcI
	d1yIQ73mq+ktKvvwREF1zAakqBKLO+3JE9mvhkOneDN4vHLIyDnbkxbtqO+hMf0ZAjx2j3TL6vE
	8m9c43DticbS0wZKTWNv+AXy509aqkVaIRYkqFALHfeD9B0ei/Ip9RiEH6WKR9DEm2iJTjY7h3Q
	3i+oTyjNKPp3FAZnmm21LDNb0Qw3h0r9fRK08ESaZEIKCN6Rr0XI4LzItT1FNZmun4BqS3LQK6S
	uET5M0SgNTB
X-Received: by 2002:a05:7300:cac8:b0:2ce:25be:c8e8 with SMTP id 5a478bee46e88-2ed3f15d4e0mr2351042eec.17.1777583731421;
        Thu, 30 Apr 2026 14:15:31 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b783a95sm1581959eec.22.2026.04.30.14.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:15:31 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 30 Apr 2026 18:15:11 -0300
Subject: [PATCH v2 2/2] ALSA: hda/tas2781: Cancel async firmware request at
 unbind
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-alsa-hda-tas2781-fw-callback-teardown-v2-2-2c7d89cb3175@gmail.com>
References: <20260430-alsa-hda-tas2781-fw-callback-teardown-v2-0-2c7d89cb3175@gmail.com>
In-Reply-To: <20260430-alsa-hda-tas2781-fw-callback-teardown-v2-0-2c7d89cb3175@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=a2/4NZb1cq6S5TUZgGQmvZJsMsttNjgFGxtg5rSSmVY=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmfj6W+ZUkUXdEW9+/VnoZpvg5rn7+9absxJKC+v2dqp
 7FQ6bGDHaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjCRL3EM/1S+9qy722QU1d+t
 lBwu6vzwg32OG3/QW6Pp0zpMxRWZvzIyLHQPWvF4+95dJxoMtv6+VurxX0XFy3vVFMfrmtktnYk
 feAA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: ABAF64A8179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,suse.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-242209-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 ++
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 67240ce184e1..34c6940f3521 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -588,6 +588,8 @@ static void tas2781_hda_unbind(struct device *dev,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_hda->priv->dev, tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_hda->priv);
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 0e4f3553f273..6b0d6c764009 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -750,6 +750,8 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_priv->dev, tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_priv);

-- 
2.54.0


