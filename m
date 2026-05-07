Return-Path: <stable+bounces-244636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDNwLZ79/GmxVwAAu9opvQ
	(envelope-from <stable+bounces-244636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:01:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 345874EF149
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855333058BA1
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3E33F5AA;
	Thu,  7 May 2026 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CnjSDjVl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BE331A46
	for <stable@vger.kernel.org>; Thu,  7 May 2026 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187492; cv=none; b=j74LoNokSYy4zHcS+feDhHc41Yt7Tu3nmsyVibYBACUice2nQHOe5H2T1jxMT+Fa8FA74qC6CA4KFmXx+7lJMGYy/8g4jfmd00b7e5Qb/SJ89Z1msx3ZR+uRmv9Zz2h8bPRY/C4LUDUm13PxjHfWq/k6H45qkWfb8CdZvsINXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187492; c=relaxed/simple;
	bh=8FJ0YC1C7mKRk5Lk2bVVdnmIyr3CW9ccH76l3a/ceD8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nH8kJnrS0CpKoAeJQRO/UuiAbCy2ncZ6K4Rz35rAf74ShpSJQJcrKJQLSZpxxjcsRUX5OD4/Bk63m0++gxaIbIUtY6rs3DmDnSRsg5HPWk5Mc6/Kj1Nww0J/p/iCxT8vmMMxjROwYaV3txpHX13EfsvMmNN1eKW5AX2lCXGHdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CnjSDjVl; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3938cc204a7so10947931fa.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778187489; x=1778792289; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mptjggwKNBAMYYz+Dgc2U3TxZpTOkEIkNLS43/L3gyY=;
        b=CnjSDjVlX0y9we15cqwXCSvlaq8CFILYEpHz/SFkp3aowzxORZoAq0+jXYNJ0qEWSW
         3bhM5+tM4RC77JHaqKI4jXAZjv1RP4xHQDVUD+ivKD8/GqpPoQ35cO9PD/C55D82dqLA
         n5PxQnjBSvWqQYGTmysM0naS2Lcv25KH2Pp+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187489; x=1778792289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mptjggwKNBAMYYz+Dgc2U3TxZpTOkEIkNLS43/L3gyY=;
        b=K3REOAznBR4vY0WGv/3Vk2h+pRt5uC7sm7cxLXabNiCq1hKmYJGj7twfS/QRA4ivW8
         LQ+tAvURDUO7HwRIhcY4mV7DFfekypQ91+nyomj/greZOX9jRAlMoaZetkaaIdpSt3wG
         Dq/uWyZqaBWW5C4v1/UamRdl3U/3vx09X0VbRf21aXl2L1PPghqOXLI7waMn2wbdvjdE
         59+UGAB9qAYBIaODYGvNV5xKxcwosFB5C36ImIP95CrGPCk/hxEx2dDjDdL1JWf3TKeN
         4NJL+CzVMbl/mqZGKCSLnn/DWw5ZPrplxPw0yjbRIxNvjOyGXRiFGjOt3WtpLwIn5eyr
         GG2A==
X-Forwarded-Encrypted: i=1; AFNElJ+uw4rzO5Uo1gha1AjoVGqgoq15NLXmRHBY5fqu9LQqOfnp+WM49892i9/GmOw16t3uNaL2H8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCDVON9YqHwKwLjR8VaxbrLG88JE8D9kZXTXhAoNz+LtAUOtL
	s9ahfge2Ruuh+9JK3SGhMfB6EWjDH4wMp/dl0o8khIdwQMVfxHrqJzQkbG72FgcgtA==
X-Gm-Gg: AeBDiet/qJ1JWYAJPQH9MHrpK5Y2JbkVDk1gv5rdAnmGT0IK4kSz0HaaQoOxqTnjVXQ
	lZCFVKefnrUC3OVm4rgT+GwMEiXfnAT96jqLy9TH92G0JpI1uni1qY58R3aWHPsy6qrww04PNKb
	UOOwCTOUs/Lpqc8UquFDItqnpbzVvFeg26aCp3fTBoyOvzItOGz2177J0fb+0/s+9Obn564tg3Y
	RJCBet9SkBNx04G05UD6rf8cJnYgiwmALP6qPV8cDSnmJN1E2TRbaBxvBQC1K5yR/cPZpJG5CrN
	DlJ7pTQMvG3AzqDy7hL/f69NrrJkAe1eZS/VjV932lHKixofOAHmiMVuPrV9IIEJKVkYwYJWdYI
	9x0yIz8VOlsiB2H+8rAjgUjriGJ/Qluz4Si4B6EU689hwqKiiEjJyer5Awt7MgsZO6QAX2I2snJ
	WCWoqqudgUbqPRxdT/yKz7h+dNq+VPiAFtwBhWPCpUwI6ELx7n1iID+141252wQuD5xdBg7r+zW
	0ZeV5+cRP+rRaNh8w==
X-Received: by 2002:a2e:be14:0:b0:393:5920:2c5d with SMTP id 38308e7fff4ca-393c432462bmr42881891fa.28.1778187489368;
        Thu, 07 May 2026 13:58:09 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393eee53655sm2325571fa.0.2026.05.07.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:58:08 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/6] media: Fix new smatch warnings
Date: Thu, 07 May 2026 20:58:05 +0000
Message-Id: <20260507-smatch-7-1-v4-0-cc195f142167@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN38/GkC/23MvQ7CIBiF4VtpmMXAB9Ti5H0YB8pPYagYqI2m6
 b1Lu2hNx3OS551QtinYjM7VhJIdQw7xXgY/VEh7de8sDqZsBARqwqHBuVeD9viEKTayliClMUw
 7VMAjWRdea+x6K9uHPMT0XtsjXd7dzEgxwbxuJDHOtTWlF+1T7MOzP8bUoaU0wlcLQjcailbgt
 GtBMKr0jma/mm80K9oZRUFoRoho/vQ8zx820rWOIwEAAA==
X-Change-ID: 20260428-smatch-7-1-d969299dd3cf
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Keke Li <keke.li@amlogic.com>, Yong Zhi <yong.zhi@intel.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 345874EF149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-244636-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung,renesas,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

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
Changes in v4:
- Fix commit message for: staging: ipu3-imgu:
- Link to v3: https://lore.kernel.org/r/20260504-smatch-7-1-v3-0-fda125c30058@chromium.org

Changes in v3:
- Rewrite mt9p031's bitmask to keep ~7
- Link to v2: https://lore.kernel.org/r/20260501-smatch-7-1-v2-0-a2fcfb2531ac@chromium.org

Changes in v2:
- Remove WARN_ON() in user triggerable checks.
- Add fixes for user triggerable errors.
- Remove pr_err in v4l-dev
- Link to v1: https://lore.kernel.org/r/20260428-smatch-7-1-v1-0-46890dffb611@chromium.org

---
Ricardo Ribalda (6):
      media: v4l2-dev: Add range check for vdev->minor
      media: i2c: mt9p031: Rewrite assignment to make smatch happy
      media: i2c: adv7604: Add range checks for chip info
      media: chips-media: wave5: Add range checks for dec_output_info
      media: staging: ipu3-imgu: Add range check for imgu_css_cfg_acc_stripe
      media: amlogic-c3: Add validations for ae and awb config

 drivers/media/i2c/adv7604.c                             |  6 ++++++
 drivers/media/i2c/mt9p031.c                             |  3 ++-
 drivers/media/platform/amlogic/c3/isp/c3-isp-params.c   |  4 ++++
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c | 11 +++++++++--
 drivers/media/v4l2-core/v4l2-dev.c                      |  5 +++++
 drivers/staging/media/ipu3/ipu3-css-params.c            |  8 ++++++--
 6 files changed, 32 insertions(+), 5 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260428-smatch-7-1-d969299dd3cf

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


