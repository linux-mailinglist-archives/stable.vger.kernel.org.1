Return-Path: <stable+bounces-244111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKsAIbfX+WmbEgMAu9opvQ
	(envelope-from <stable+bounces-244111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0094CCDC6
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015083134403
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282EA31F9A5;
	Tue,  5 May 2026 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rC3oyAgU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578E382384
	for <stable@vger.kernel.org>; Tue,  5 May 2026 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979932; cv=none; b=tUpZHeEEq9uSQMY1AcJzwWudqCmDgIkVJuCCZaof94sv3PKRZZQrYg1WOvh46hMOMil/WJ231an8/VwptngWxT8knXcEkvZmYYtPZ3yYFSed98CmHMe5FK2Sm9v4dCWUv6mDaJbxAUVS0j5eLvj8aP9f9+kc5l/ZbDOQVLkjIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979932; c=relaxed/simple;
	bh=RfgrVvknme6vhAOFjjbtHTulvqGle3JEa4VWxijNxXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcHOZizclQ9VEjY4RCkpdBh2PeYsZaRX15iqGPtceaXN6fmm6OxxZf6K38xpKvizK/2r/xXvkYgoS6xnNyuMtczcaGX+FzxQqTsct16qTe4cCUZdQeLscFnvynOE4aywi9xpuYUfjFcpWg4z3Clc51syDezSEAkvX3/dQuVRDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rC3oyAgU; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-130b2295ed0so1570220c88.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777979930; x=1778584730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjBFmY6oME3TcUT9msMQ0JkYRg8U/8GzZccCOVqrKM4=;
        b=rC3oyAgUHIJkr355S3bBR/5MWnGJ5LgxDe2/oxws1oMVSpiH6KFtVO0jDzt+Ae6YDd
         24RjyQj41hWY1aDniruNvqCvR4GZCitMGhKHkKXSrXCpYBAHJFi3xC/v9flEsmrXpsru
         ++eFOP/aabul9/LE0BiRdNHMygLh2+3X/Nh6ymOOLdo7SrYvbv1v9ywD0h4/vqPGTyVR
         udxKRMtyYYOXegmvi2rpvgICYa8dYcqoQb9Ta67i+ImCvPYGijsFehHcoBGKsmSEu19K
         Hm4HVmueku2R6DS0H3tzRmNX07AndA3uRMqb0JYUj6jB38NFj6mnnituZwGMhuzDKAv2
         tQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979930; x=1778584730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjBFmY6oME3TcUT9msMQ0JkYRg8U/8GzZccCOVqrKM4=;
        b=bQn7sZKzEO/YrxdpP994B7YjlnWJZSJ/8jsB6R1C+yi6zZ/DG8h6wLw1FmLrI8ruGl
         EpEWd5CHOV/DqI5q1u+n9v+qGm53N1GGccOQncskNkJO5vVs0cMY2MlRbw9CG2eFNwwP
         27VN0AoVFco9AeeM5haeMgWKQUliB4dm+Ko7f3XIvMONLMzW087a0DXfVkH+ifEK5TDv
         b9RJpfZuk8LCWoah8fA+fga50AED1aZlPfPJoZuIRTMTeJelNNSwpOsorlm9rQbub6CP
         O6gNsKDZNRLs3EEB354LaMyd0sicmjgcC5CB/gSRQ4fiSs8ENiTnB2Tvds+/GWLCYZmx
         ozxg==
X-Forwarded-Encrypted: i=1; AFNElJ+UVOO8VTYorrmp89HEWcd4M6k/VzXVXSK5M6eZPyVVRLMIVvN9qW1uwPPZFCNX3CHrEreGAus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfH4v9Z6nqHOeXl5aToiLSCFCgNzMJ2VZ2GEmPGIRtoKGMh04
	hVSWVm6+1kDPoIVb8mxGYbztg6OpwAiu67cs42dpU+r8oLrA6bWwAWG1
X-Gm-Gg: AeBDievR/9oMEI1tfaUFBzogAXhFOQ+XEXfv7Qqz7f3+fmwG9RbI785ZRuQLZXC7aqm
	aC/7D38y9griBI0hfW/4OCH577DUGLoiwFzabzMEPrCEpUKGvqydGegpPpR7kYOLdzbmNLuYpwz
	8AAVWoY7cjQ28P1kmkPCxHXMRChXadk1kHLSsCBnjbXWMBW/rHFf0as7Q/G0tKpqU/2FnZ3g77o
	3kT70sw4EtcUfxrNmYw7jHEEq7iSX24vTdRTKC3gmBQG5ZQGKm6gFjgxB1xZw8tllkeetGGwJ+M
	Xh7MKU/mAiAddKDCUVvzoMCOg5YHLWIAfdYzC5Ox+JuWt39qbU0iUxaQFjlXjHqrxEDrk2jEBAb
	TXLXtVnUzZxHgZAnXw+Y8IacmW+OWt/gHHNYsXlbKnPro3NslzYcGAcGWLGNnEIAwyYxvh8f+oc
	yjaGlDk7X98525p4tnVK7XQujKLZnpIxD2hWcOfwuxVeT1VKfuBmf10hRjScXe52FmKFY6eJwnc
	N1hfvMKrK7J
X-Received: by 2002:a05:7022:6998:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-130b1b6785emr1279909c88.28.1777979930401;
        Tue, 05 May 2026 04:18:50 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df828849dsm17247290c88.5.2026.05.05.04.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:18:49 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 05 May 2026 08:18:17 -0300
Subject: [PATCH v4 2/2] ALSA: hda/tas2781: Cancel async firmware request at
 unbind
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-2-e7c4bf930dc8@gmail.com>
References: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com>
In-Reply-To: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com>
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
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJk/L/Fa1/D3LvgQOr/TvCNz0psnhmaM62cdmaLwrrxMX
 yM3IjC7o5SFQYyLQVZMkWV10iLLPV0PrtbHrfCAmcPKBDKEgYtTACZy6RrDP4OES5/L2+dM+bT3
 HpNKnyHbv7oSpryvepclv2+/N6fZXIqRYftsHvU1UVN+MH+9d7brqpuE5A6vpVcbvrQt2bD1vue
 k/8wA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: DF0094CCDC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244111-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


