Return-Path: <stable+bounces-151383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837CACDDA0
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E623173B0C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C228ECCD;
	Wed,  4 Jun 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e+rSStwS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8324DD16
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039368; cv=none; b=dYbJSqhw5JEggHfs9SgRf71eM1b4rmFBAyDKSVh4LBEFy/a0n9jy8JJpgi++fTM1j5cprNmIxwkltVD4A6hj8w1Fg11HRZrXCNk6Tk0EX/zfnVXZdAOmAjMuTU348N4HuB2v7Cd8M9/CYC6uSBzcqhnKIMaFMMbNu7ObTIYBkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039368; c=relaxed/simple;
	bh=uY7D+jjddolNqhiti7y96EkPRMPxJ7Jd0zS9UX+scuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pRnuGL+NMpBNqt5cz5DgA8X2HVVcKHB51Tap9yFrgSxjtnyRWfWSb0SJroVMbV7tKDPjIPCQWCC6WjItd6qf4JIGKUpq29pdWOC5x+5IzjKkMOfAKmbtT750I0LJQXOG4FEUCUhpOhV31I82Izpk1wDfVPcailq3beiV7oneTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e+rSStwS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-551fe46934eso999484e87.1
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749039364; x=1749644164; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xekR2IKHK6b8xke32HrcPkFvXPWhwmXLd0wFiP/mSA=;
        b=e+rSStwSlpYjZMTFbC+RwFRtnoaWIJLzghpR/3qJeLlnfuleO8F00hOZPV5mNoGmn7
         agEznDImczaYKcQ9knU2uroN8XS1U+PLCor5EZFShjkUV4MOpzECC7Qz9I36yxIvGDxG
         r7joec8oZSWOgfU5Z6xuj+mITSrXHp9+helbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749039364; x=1749644164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xekR2IKHK6b8xke32HrcPkFvXPWhwmXLd0wFiP/mSA=;
        b=HY015J/MiZT0QC3CPvw0jjpLjcB5hpXva34YcpAl/yWOV4OvdyBmbURtbiCWRS9Owv
         b6nOvyI9NskdoGJWe4gmKp8tWMX2FrIKPpkRuIW2Ogf53+oBnXbZ/fM+ppKvpd3Rv4jC
         ewjJph6VCG3rioC0fyRPvHpbpKfb/DZ0blU/JSMIk8b1um4N2pvtWHOvdYcnIkbPgnP+
         dozeSUBSkOIgivH/I+r+1qDLQPmXN85tnWzBpwVb9L4RXg5i4wcqhqxcqsewwpw2dZIH
         CBfA0APYweQpn05ULdk9HdzimcOk0I81AOtxSB703VYNg/sqM9hkEt0jqPxSJneiq9Ik
         UeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx/hT4PuRAhCrV0SQUFVtUQOlezhDpR52obJNbv7l/91aeLZxxEcDBUGKKEd/3xGC2eTvPdco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznt8xpmj/O3iXsNj6i+pJALb5j8cX7jQGxbhJWFQxSAgy9J8cJ
	vNsRgaK7A2cC7Qn02NLMMpF3T4CgFrfh53lSbaOAzkXzy2dDlsPFmuuAyY30KnUajA==
X-Gm-Gg: ASbGnctZ6pnlLh1+NcJAafJFwCASujFPs1rqrlDpHnPKBR2bU9rQs+O6bHVWlbSTXy3
	WY61KkXJ4FT2CxsLEUViSvWbkIlLN3QWEMSW4HhOA2cwGB8YGNUQRMF/OnLQu3ww73uOPwgfgHY
	IQcDjSNvNOrhzdevsekDx10fainUcTbZ0z0I3+eyS5k0R77qadjtXLwQSEjoz+VwS6IpWARES5z
	idFx/TUnWTmMCTmxdlZLtanbikFfdCYDAZw/5p/JVpSCH11/8Qf/WVoDUO+Zi01fbcYcHIq1M7r
	pQ/tZQbwwPcjHMjPujvxdhHZv6mN1Jv6hZD4C7YG45NXQ2x6P2F4McplbM1N1hn20uC05Q0a8dK
	AmDOFcNqk/c6S8sA/yzFu3f9Ohg==
X-Google-Smtp-Source: AGHT+IHhatcr0s6vMVBvq/OiXe1Yz6St2NxBtXXPB6neJC31+NPT+75ckWXgzHIGnO1tpnNzLm5vDQ==
X-Received: by 2002:a05:6512:104a:b0:550:d4fc:a0d with SMTP id 2adb3069b0e04-5535719cec5mr813991e87.24.1749039363950;
        Wed, 04 Jun 2025 05:16:03 -0700 (PDT)
Received: from ribalda.c.googlers.com (90.52.88.34.bc.googleusercontent.com. [34.88.52.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a12ecsm2289134e87.90.2025.06.04.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:16:03 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 0/4] media: uvcvideo: Introduce
 V4L2_META_FMT_UVC_MSXU_1_5 + other meta fixes
Date: Wed, 04 Jun 2025 12:16:01 +0000
Message-Id: <20250604-uvc-meta-v6-0-7141d48c322c@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAE5QGgC/22MQQ6CMBBFr0JmbU0tHUZceQ/joikDdAE1LTQaw
 t0trIhx+X7+ewtEDo4j3IoFAicXnR8zVKcCbG/GjoVrMoOSCqWWpZiTFQNPRjBiRVQ2F2UY8v0
 VuHXvPfV4Zu5dnHz47OWkt/VPJGkhxZXImEoT1oR32wc/uHk4+9DB1kl4dPXBxey2VNekW6saJ
 X/cdV2/1Izf+98AAAA=
X-Change-ID: 20250403-uvc-meta-e556773d12ae
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.2

This series introduces a new metadata format for UVC cameras and adds a
couple of improvements to the UVC metadata handling.

The new metadata format can be enabled in runtime with quirks.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v6 (Thanks Laurent):
- Fix typo in metafmt-uvc.rst
- Improve metafmt-uvc-msxu-1-5.rst
- uvc_meta_v4l2_try_format() block MSXU format unless the quirk is
  active
- Refactor uvc_enable_msxu
- Document uvc_meta_detect_msxu
- Rebase series
- Add R-b
- Link to v5: https://lore.kernel.org/r/20250404-uvc-meta-v5-0-f79974fc2d20@chromium.org

Changes in v5:
- Fix codestyle and kerneldoc warnings reported by media-ci
- Link to v4: https://lore.kernel.org/r/20250403-uvc-meta-v4-0-877aa6475975@chromium.org

Changes in v4:
- Rename format to V4L2_META_FMT_UVC_MSXU_1_5 (Thanks Mauro)
- Flag the new format with a quirk.
- Autodetect MSXU devices.
- Link to v3: https://lore.kernel.org/linux-media/20250313-uvc-metadata-v3-0-c467af869c60@chromium.org/

Changes in v3:
- Fix doc syntax errors.
- Link to v2: https://lore.kernel.org/r/20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org

Changes in v2:
- Add metadata invalid fix
- Move doc note to a separate patch
- Introduce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
- Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: Documentation: Add note about UVCH length field
      media: uvcvideo: Introduce V4L2_META_FMT_UVC_MSXU_1_5
      media: uvcvideo: Auto-set UVC_QUIRK_MSXU_META

 .../userspace-api/media/v4l/meta-formats.rst       |   1 +
 .../media/v4l/metafmt-uvc-msxu-1-5.rst             |  23 ++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |   4 +-
 MAINTAINERS                                        |   1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 116 +++++++++++++++++++--
 drivers/media/usb/uvc/uvc_video.c                  |  12 +--
 drivers/media/usb/uvc/uvcvideo.h                   |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +
 include/linux/usb/uvc.h                            |   3 +
 include/uapi/linux/videodev2.h                     |   1 +
 10 files changed, 150 insertions(+), 13 deletions(-)
---
base-commit: 5e1ff2314797bf53636468a97719a8222deca9ae
change-id: 20250403-uvc-meta-e556773d12ae

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


