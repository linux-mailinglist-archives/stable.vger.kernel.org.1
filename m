Return-Path: <stable+bounces-242208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IxDM9LG82ni6wEAu9opvQ
	(envelope-from <stable+bounces-242208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:17:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D40294A817A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70D513015826
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865CE3BA25B;
	Thu, 30 Apr 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjUTQk/j"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04913A7F6E
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583724; cv=none; b=b8g3kHoJpB3BDJ80B1jRhKifpEgEjZI0yrANfp1jwswYqBvo7t1SBc36iK63i/xY/KhldeRipVzYNcK15sCxWoY3b/XzmVxrZEwC/7PEGf86j6l8olN9EZCeBG5kz+eHJ9Ip1CWMfBMaxvoOkxZAogfXaxXkDlDoFJZPhnBLJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583724; c=relaxed/simple;
	bh=KTwLEUWIT+e8jUbhS98OO0Qav97udJRTNz9JCBY3tFI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NfyrvdP7mpAaD+/Uu3nHRcIrG/+LLYZxJIOJQbfou4kAxCT/KS4viWdQ2seIt3aCguJY4rqxtEHoNP9ClCN4l4KWNNhLdjUEIfNFYOLoAJqnhB99qXrHY3n1Sy0H1kqdbvFeQCeZQNebM73PWqWoJcoMg8YVmU1wBvxIpndCyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjUTQk/j; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2098583eec.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777583722; x=1778188522; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfBNagKOT++Xre4nZSTbTP+Vsr/9/6AIqRC97WNWrdQ=;
        b=CjUTQk/j5DK0IvsAtA87sziSaeSAe3myqOEawYAJzPewcH5Ng/gNvL2HWly/1jm9Vm
         kp4aLPHK/KSdnBSAK5JFYPOOuYMG1VNV74qcLlR0uMlSijymXvvflRDzcI00pQbOlTZs
         PVKCtJUXFKdqy73+a0oEYOPcoG72QnQBnGIafatTzEfVf6pkvDfI7M04sRjoBUVIrOQB
         mr1siBYqF/CBIR90xYQjjsD+W0wjw6/1ZRrsXGTv4BmEGYLeVfeRbaIFPXytmQv0OnxS
         oW3VSljH6HuSMCexhAKCxm9Z05X78JNI6Z815S7B7LN3d1bP5L3tlvljDNFn5eMDHE6K
         C5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583722; x=1778188522;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfBNagKOT++Xre4nZSTbTP+Vsr/9/6AIqRC97WNWrdQ=;
        b=GoCML3jl9uigZw84PkUjaklvz+W9R9gyMXAQ566x4i4vWethWszAFxHZjQPmA6HIKI
         2OtTi6tRzehftHqcunxopU5Do8UJVnbxVAFSMacGsiEGqJsTyZyJB59qBEJkZyJPKGNG
         pIuHTnnr0t/L4iSZvlrzbZoV+prNyWqjZSGetP04Q2U2EMuTgXulk/AtImsQNMjAP+Tq
         CU+fknksxWKXjqWLfzwtMUog+84WC0uguCGHl4FY/xzwBMOIMjsvZwXO74cudqyuDybP
         ymAyon8zb9xBDEdCvUAYiLhg7UnlKENkgElwTh+5yqyDA324Dw+Y27Mz2C9TGzvVjKAT
         uQPA==
X-Forwarded-Encrypted: i=1; AFNElJ/zoOsqsPWD9Hu3fp4gsOsfL7SMvd6sks0EN+/WBV8AkZW040ej4pk5afXjMpFCiYDxjE/jYdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySQImX5Uxo2ch0+ykuy19ZULoCLbf9QRb0kDxUSwR2MsFVTLrF
	ptvxJi5LVuBG84UDXfrQ6upqBehX+Ct8IwKcor3TEfA+EEMnXNBMozcW
X-Gm-Gg: AeBDieuNpdU9nisbFkyXfbY7gredvsGPt5AjL8FiohaD41ISNNmN7Fe2zKzyBu0LV+B
	D+34rPnX+2FI1lZe43g9uMZIj1Xogqf2rF5y3k8bPgOVlYgOfKursXzvOlEW/qUx2OgaQHKy8fg
	z2o9tX3w+oVzhLKMHWhK0rtaiSfb0s4iUjWqiYpAmGGuZm+f+g3E8MgtrMsLpM4EmgpgslWG/DX
	tHhTCjqgrowR8TBZfbFNmoGtqt4TsWH8mtrkG1OgCUHUO0L4CJb0dEtv16VJ9uMLjtQjGxVLpuU
	WUk9yEuzW+6NP6NJ3usThoitLcJBY3zyG932H8PTb5+jwAHMdvZK5JQca0FmN78AlY6hKOWd442
	Iyo+yG0LVE44RZbMvGENTlGlqojF9gsTzdG1HnP6awCwVk342IvYLFfyE2HsjAwAMV+drydhliB
	aqRMgS7gfFAEde8dB0EcywNREfHVWWmPYDJX985PneETw6V8H0q6s5LJsxjj1girZ8ET9aqtWoY
	11zjoG66rKQ
X-Received: by 2002:a05:7301:fa13:b0:2da:10f0:a8df with SMTP id 5a478bee46e88-2ed3d8c5045mr2082996eec.12.1777583721885;
        Thu, 30 Apr 2026 14:15:21 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b783a95sm1581959eec.22.2026.04.30.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:15:21 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH v2 0/2] firmware_loader/ALSA: Fix TAS2781 async firmware
 teardown
Date: Thu, 30 Apr 2026 18:15:09 -0300
Message-Id: <20260430-alsa-hda-tas2781-fw-callback-teardown-v2-0-2c7d89cb3175@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OSw6CMBRFt0I69pm2NAUduQ/D4PUDVIGatoKGs
 HcBXYDDk5zcc2cSbXA2knM2k2BHF50fVuCHjOgWh8aCMysTTrmkgjPALiK0BiFh5EXJoJ5AY9c
 p1HdIFoPx0wC5KqSgQqkTL8m69Qi2dq+9c62+HJ/qZnXaxjejdTH58N6PjGzzfs2c/tkcGTAoC
 5HLwkglmLo0PbruqH1PqmVZPjzBxEDsAAAA
X-Change-ID: 20260421-alsa-hda-tas2781-fw-callback-teardown-3b76404bb928
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=KTwLEUWIT+e8jUbhS98OO0Qav97udJRTNz9JCBY3tFI=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmfj6WsXnRQfsuy2ROPl/9l9nlyz+Noxpxpi8LXNj40L
 3iaXfjhUUcpC4MYF4OsmCLL6qRFlnu6Hlytj1vhATOHlQlkCAMXpwBMRLiWkWH6xkPRb99OCveb
 9+DD/xeV/sylDOcMlxk8nFwukuJccXgWI8OXlCt27+JMd9jEnerJnPvIVVLb9VOV8ZfclBVimxJ
 u32UEAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: D40294A817A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,suse.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-242208-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

TAS2781 HDA I2C and SPI queue RCA firmware loading with
request_firmware_nowait() during component bind. The firmware loader
keeps the callback module pinned and holds a device reference, but it
does not provide a way for drivers to cancel or synchronize the queued
callback before tearing down driver-private state.

Add a small firmware-loader helper to cancel or synchronize async firmware
requests, then use it from TAS2781 HDA unbind before controls and DSP state
are removed.

No hardware runtime test was available.

---
Changes in v2:
- Add request_firmware_nowait_cancel() in the firmware loader instead of
  tracking the callback lifetime locally in the TAS2781 HDA driver.
- Keep the TAS2781 change to a cancel/sync call in I2C and SPI unbind.
- Drop the unrelated cached kcontrol pointer cleanup from the previous
  local-driver version.
- Link to v1: https://patch.msgid.link/20260430-alsa-hda-tas2781-fw-callback-teardown-v1-1-874367d6b41b@gmail.com

To: Luis Chamberlain <mcgrof@kernel.org>
To: Russ Weight <russ.weight@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Takashi Iwai <tiwai@suse.com>
To: Shenghao Ding <shenghao-ding@ti.com>
To: Kevin Lu <kevin-lu@ti.com>
To: Baojun Xu <baojun.xu@ti.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

---
Cássio Gabriel (2):
      firmware_loader: Add cancel helper for async requests
      ALSA: hda/tas2781: Cancel async firmware request at unbind

 drivers/base/firmware_loader/main.c            | 82 +++++++++++++++++++++++---
 include/linux/firmware.h                       |  9 +++
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c |  2 +
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c |  2 +
 4 files changed, 87 insertions(+), 8 deletions(-)
---
base-commit: 1bc46462f4c09f8d429ae8ec17f92886d604659f
change-id: 20260421-alsa-hda-tas2781-fw-callback-teardown-3b76404bb928

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


