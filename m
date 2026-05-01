Return-Path: <stable+bounces-242336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCpCCGuP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:32:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2754AC0B0
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF2CD3005580
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E60363C4C;
	Fri,  1 May 2026 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7THG5Cs"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3A33A6E2
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635176; cv=none; b=lzA83VbM7vEOOF6iCC7iUhV2E/IC7i0R10slcOsGmmRZQ3sbYIbVFtUV8ZF42ws7cMy5k5p0t3WKt0oMhxpSlN50qog/Wkb3balPh1Hn9tN01mR0Fl+xsMu17dLwfYpT3Vkf3ftnnwmbhKVl16X+snHIgvC3FZPrpWGamfNDDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635176; c=relaxed/simple;
	bh=lNE0nPjKixAgd1P12CjQb2oJjktRa0U2UO4AEVXrWtc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jncQWMu70ry8tyQJF/k11X/Lkyhe+0EUFv3mUq3U5AKX5FOdoUJ02AYtbaeWdabbYR20SuW2d81OdzNamWTDWmQDsZeyj+jsYc0wNrKWY7DQn5U28fsEv6Kk5JH4g1FkZjwJaOcQOAvLSVfAZIS9ypDiYqg3AcZlXKIFpZh2w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P7THG5Cs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e4a04f059so2787831e87.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777635173; x=1778239973; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Io9wfmVyuN/9T/zzUi+4EApFsonZHuvDhFNcgPKwqIU=;
        b=P7THG5CsHpbEZxxKLFVqL6PPQwB7XoKXmw1XI7ZcRUrLmfLC7VO9/z8NxvpTERQ57V
         //RuIp88VhTef0zpoCevipVsABfZxFSJhTfNqf2qA0XDgj9/PgUg2WgCmSszHtJqPbqs
         VUDwJNYZxVYaAd3nqUOSn0vKwKnEFMpy4fJK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777635173; x=1778239973;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io9wfmVyuN/9T/zzUi+4EApFsonZHuvDhFNcgPKwqIU=;
        b=Rl6M0EWVitV7lH/h9srWIFFd8BujYlGvuQWytINzpjZTLaYTgogjugdPg8WLfQJTUb
         IccXJCGCi5GfJUz2RQmY+YXoxLYNqP2LZtpTzKm95Xwwv84lbPKLO2cD6zL3FVxAvXAM
         AvlTTWy6mzkCPQCgAdRIU2aCjD9lHtEXzvvsvjy3rQ5q1khdme1/aehHcr3pN7b4ZobR
         /jtwKBPl2XxnTbF0OvRF5Tgz2+fb8+lpFfsSyVAjlX3lUc1bQubCXbAy7JHxt0ge9KrS
         HUm5WintPyNbcTwTNwAefR4FfVbWdEEQX71wGx6s3zQThZYTP0aInBjtsREWpjfFmGPG
         b7sw==
X-Forwarded-Encrypted: i=1; AFNElJ8pZw39nq4PDLDBlp/87ZEL5dbb0whm9+VFe8kM/b9gNjWq0qedfJJeZ3zPYIhAzj7bWN+BSv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Q1D9YpKrxc1ioJ/aXoyQB4HiOUu2f17SqIKJnBa2XV1YhB/Q
	XIG7TOHhBaZsunP7Kv/0sm8JOByllWuhaArUhn/pOSEIiFEV3TNPiB+cZK7vscwI+g==
X-Gm-Gg: AeBDievvl5Eb1RT6Cy2pjMe7cgvkAv2b2ILe/xkD0c9sB0Dc0yiABO3QXbwSLjptGJX
	8wpApmbitax8WJrFCI+OZs9fawmlQ66GoriwwOP3lL0vLLe2hfI902/ZkcU1J2nPr2w85i8qffI
	M2scWorMkR8P39MM7IC4GIk8UebZhuoTRsJbx0PnGX054ZabrwOqs0dTSHKYym6C1pqvo/Z+hHF
	3tyRYObVdqyjYnxSR3N38ymxKPOsRlt/X2/524s8LG4MkJ1Hy+EV3pJHpm5kFC7Re8kdYIoSU+X
	tjwcOFWZatdjT7u/0RzPHro2yD+1bK9A9+aC/B+Gs2op/tNZTtYcR1x56u8zTf7Gxp7qMHqkX0j
	PC75L9u/uwRs2E1BqvL+7U1onBKcEsC4ZMoZ1ZT6S5t3RCMCtQ8C7X36TVMTSaavdBDBm8/chda
	dI36OYI5gPpyK1SjvQIGHBJypnYvrSKR8ZHMCV5zL/jMf/VWpQs+xldLBSSX2/HY7GNn8FQJnon
	YMonxp46z+gwPn19S1LEwpzuGxl
X-Received: by 2002:a05:6512:31c5:b0:5a4:4cc:7a52 with SMTP id 2adb3069b0e04-5a8522d0d4cmr2841534e87.17.1777635173080;
        Fri, 01 May 2026 04:32:53 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c346c02sm429166e87.74.2026.05.01.04.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:32:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/6] media: Fix new smatch warnings
Date: Fri, 01 May 2026 11:32:45 +0000
Message-Id: <20260501-smatch-7-1-v2-0-a2fcfb2531ac@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2P9GkC/23MSw7CIBSF4a00d+w1gA0WR92H6aDyKHdAMVCJp
 mHvYscO/5Ocb4dsE9kMt26HZAtlimsLcepA+3ldLJJpDYIJyXoxYA7zpj1ekaNRUgmljLloB+3
 wTNbR+8DuU2tPeYvpc9iF/9a/TOHIsJeDYsa5h+R81D7FQK9wjmmBqdb6BUdKOM6nAAAA
X-Change-ID: 20260428-smatch-7-1-d969299dd3cf
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Keke Li <keke.li@amlogic.com>, Yong Zhi <yong.zhi@intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: AF2754AC0B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242336-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim,chromium.org:mid]

Current version of smatch triggers some warnings for the media tree.
Most of them are inoffensive, but we would like to have zero smatch
warnings.

drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:111 c3_isp_params_awb_wt() error: buffer overflow 'cfg->zone_weight' 768 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:111 c3_isp_params_awb_wt() error: buffer overflow 'cfg->zone_weight' 768 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:227 c3_isp_params_ae_wt() error: buffer overflow 'cfg->zone_weight' 255 <= u32max
drivers/media/platform/amlogic/c3/isp/c3-isp-params.c:227 c3_isp_params_ae_wt() error: buffer overflow 'cfg->zone_weight' 255 <= u32max
drivers/media/v4l2-core/v4l2-dev.c:1036 __video_register_device() error: buffer overflow 'video_devices' 256 <= 288
drivers/media/v4l2-core/v4l2-dev.c:1043 __video_register_device() error: buffer overflow 'video_devices' 256 <= 288
drivers/media/v4l2-core/v4l2-dev.c:1101 __video_register_device() error: buffer overflow 'video_devices' 256 <= 288
drivers/media/platform/chips-media/wave5/wave5-vpuapi.c:588 wave5_vpu_dec_get_output_info() error: buffer overflow 'inst->frame_buf' 64 <= 127
drivers/staging/media/ipu3/ipu3-css-params.c:1792 imgu_css_cfg_acc_stripe() warn: 'acc->stripe.bds_out_stripes[0]->width - 2 * f' 4294967168 can't fit into 65535 'acc->stripe.bds_out_stripes[1]->offset'
drivers/media/i2c/adv7604.c:3672 adv76xx_probe() error: buffer overflow 'state->pads' 7 <= 4294967294
drivers/media/i2c/adv7604.c:3673 adv76xx_probe() error: buffer overflow 'state->pads' 7 <= u32max
drivers/media/i2c/mt9p031.c:799 mt9p031_s_ctrl() warn: assigning (-1952) to unsigned variable 'data'

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Remove WARN_ON() in user triggerable checks.
- Add fixes for user triggerable errors.
- Remove pr_err in v4l-dev
- Link to v1: https://lore.kernel.org/r/20260428-smatch-7-1-v1-0-46890dffb611@chromium.org

---
Ricardo Ribalda (6):
      media: v4l2-dev: Add range check for vdev->minor
      media: i2c: mt9p031: Rewrite a bitwise mask
      media: i2c: adv7604: Add range checks for chip info
      media: chips-media: wave5: Add range checks for dec_output_info
      media: staging: ipu3-imgu: Add range check for imgu_css_cfg_acc_stripe
      media: amlogic-c3: Add validations for ae and awb config

 drivers/media/i2c/adv7604.c                             |  6 ++++++
 drivers/media/i2c/mt9p031.c                             |  2 +-
 drivers/media/platform/amlogic/c3/isp/c3-isp-params.c   |  4 ++++
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c | 11 +++++++++--
 drivers/media/v4l2-core/v4l2-dev.c                      |  5 +++++
 drivers/staging/media/ipu3/ipu3-css-params.c            |  8 ++++++--
 6 files changed, 31 insertions(+), 5 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260428-smatch-7-1-d969299dd3cf

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


