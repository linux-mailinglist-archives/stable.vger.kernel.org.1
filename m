Return-Path: <stable+bounces-242850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG7DGJ5C+Gn9rwIAu9opvQ
	(envelope-from <stable+bounces-242850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:54:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC94B90A9
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A82F3300DD70
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 06:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC02D7DFE;
	Mon,  4 May 2026 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWA2HPew"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E92C08A8
	for <stable@vger.kernel.org>; Mon,  4 May 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877650; cv=none; b=A82YnrFAmSHZNqysh801wIIeK+nj8RHv57Y/TJz04E1swmQteZfI0tS7wp/q14edeD2nu72adyblYDjivvwmuSc4raC1/y6rjpeEV11kOSdKXbFT3V2dpAj5U33Mlx02HhBxGPB7En/yzNFqGCFvUSLoF8romzz410MyVAi/d+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877650; c=relaxed/simple;
	bh=wypT3/f64K5sDq91Et+10pxdZ4d+e//SJTgpXTubmZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ex50oZ/SEliQ7/gfwa1QG7T83+D6zrmddIHJyXJQB/tK2pzADmxJnPYtb52EuZRK/bDcwjhIPfEXjhf+udiQyzgsDMzUgpQteljGYZCv7b64GW5ktIg1vcl/k6rWo89K2wz4K1kv3xicRebvmeArC1oBt9TosPa0XmZqT/jwa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nWA2HPew; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso4014439e87.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777877647; x=1778482447; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uQAiVepCGgf4BwN62I0/iFSFpiKXW39s5/tMjTrHDw=;
        b=nWA2HPewWy6Na0/hJqfUCfuyYSLnoiUSbluNT83B1JKfPsxe+Yy7+Yy2rd+XI+lXeY
         Mt3vnmDPABfogISesuYiZP6CzSltl9JMDMdTpUoV6RdEcsaO5BmX69iYLwO7FPpqVcz/
         Phcx8LHdVoZBBl/wCJYHrkDnqU+xg5oy0VHDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777877647; x=1778482447;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uQAiVepCGgf4BwN62I0/iFSFpiKXW39s5/tMjTrHDw=;
        b=i80WbeW0mt0ITFWAqpxMaI2sRO7G3rUWzIJwq1mXfUHdstX3pHypaipUKh1EgAGTSk
         viddSmfgGlIab08r7a3mxv4/K2N/eSoYX+NBaiTNa/XCRSFFGWTMqiRt7WZ47hHxMQjE
         1aqsItY7NLGuZzPxlgg2Cl1Q0Qo0xTGHRoBnx1AjFtouUsfeiZi6GiwD1/pQW4ROVUwM
         cskc7TFk1uTOxBxriP+MPsO2f+XttSS49PyuMh9BmOL6wUt/DpzmvKTW9N5xYzvLzTA6
         Ovlnbe6q/qU/1VwjaFipxhl452JplaoChpJ5xefZJaur6nyPSwQ/Jb6Rz3lSRtYOkAps
         Hsvw==
X-Forwarded-Encrypted: i=1; AFNElJ+ffS3zXvzYASXIg6rr2YtvTHZFCEhzXySBvftSt2FFku0qX+WOCL/1Rc4RbF7MNlU6U5fiymw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPA3zOHfueOzYw/XLp7TcGJVzx1nvuyxy47jqr0AE58d7dqVzT
	4dSFrWXZjGa6sMx6VC90APuFp/b6NcdNwcXxkRmM9N2/zAt0LUOWV4Y8AEqTDeXeFg==
X-Gm-Gg: AeBDieu9WkHs0vIBDO9cy9C8hvFckeMrQahu/l+xwxnJdFKdIKZAE/R6zI8SN5jyYWk
	YTpUyJNNugsixo8uowmh2ADdK3aemgHN3H0jnGRaXs+Y2YCGNSSV9eDJvy3NqYAO7UIiUzaHTtZ
	yCoL+Oixf2Grbvk0LsLNTrNnsSuO/Q5A3gQ0KfrAYJwu6miQ/1Dahk6ccEnqEyBP8LnktO+6oJm
	gCnpKLDapeGPrHanJtrNDv5HkpOfynyaK47T5s+UgiBwqcJ2KolBjQgN2o6jwnhyS/4SCMOqbIL
	TN/B0g3YVsx66aVbeFBOL9TmuvqOkAKp3m8GIBYl+J/tgn5aQhIh0uQO2aYoEnTB7t3nrIXwNTx
	HFfUIu/cbgMDm0h1CPRyvY3G4OtZrnIQewOE0DyGBMyV11umReRHwtSWmJRTZNNqynHpxgJZx8q
	SPKUC3qiwoKBu0P3nWUAvfxYMPa33i6IClKHHdbdjW9Sl63kYokD4nxT5vSa0+7YXjIRz9LbHKZ
	f7oW8GvbWgBx/D7/A==
X-Received: by 2002:a05:6512:a89:b0:5a2:bedb:2119 with SMTP id 2adb3069b0e04-5a8631bdaa2mr2838842e87.26.1777877646839;
        Sun, 03 May 2026 23:54:06 -0700 (PDT)
Received: from ribalda.c.googlers.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c22e1d4sm2674579e87.9.2026.05.03.23.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 23:54:05 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/6] media: Fix new smatch warnings
Date: Mon, 04 May 2026 06:54:03 +0000
Message-Id: <20260504-smatch-7-1-v3-0-fda125c30058@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAItC+GkC/23MSw6CMBSF4a2Qjq3pvUCljtyHcVD6oB1ATYuNh
 rB3CxOjcXhO8v0LSSZ6k8i5Wkg02ScfpjLqQ0WUk9NgqNdlE2TIWYMdTaOclaMnClQLLlAIrWt
 lSQH3aKx/7rHrrWzn0xzia29n2N6/mQyU0YZ3gmlrew5wUS6G0T/GY4gD2UoZP7pl8KWxaIlW2
 R7bGqT60eu6vgFk5t5q5QAAAA==
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
X-Rspamd-Queue-Id: CBCC94B90A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242850-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,samsung,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


