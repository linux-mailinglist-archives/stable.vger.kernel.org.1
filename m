Return-Path: <stable+bounces-95827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F239DEC56
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2159C163AB8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23871A256A;
	Fri, 29 Nov 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVj/79Bh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0561A0BED
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908311; cv=none; b=k4Kr6M8QUoEoJv1y9bhyILCIEbu19wE7X/T5LI9T+pFxQYWbd4N/Zy6kKIzSjZgM5s6hv9TVblD4PqNB1r1iIQNQT9dcLEBMeVDrllRxIXXQ6pgOjb5Y7hLhCKGFE4Mi0jHTL83SHZtfAXxEmA2TgpUXIsjXC3DIdBKBul6aXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908311; c=relaxed/simple;
	bh=d3jo76PXC/T9EhC8p7wrOR6nkhpDa7Ba6c51n5/cPbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WMipEF/L3b46ifhDPBsyJgScJeCk9GYDYPA7vWO+o8NCX8QsHRmd1D+4aK4F5Qs91nDX20Ho/8Rrz3aIvws7WL38c0luC46OJgR805Zh3GcVEL7Cvh34qu4Ywqy1xOJRo7ZI/jpP+wvICLsHZd44h0UyJuFASJa12/Lu09Ud774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nVj/79Bh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d87a55bc50so11754176d6.3
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732908308; x=1733513108; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2P6kqxYG7hM9Q3T51ND+biicoWpc9nKwaL2ZX51qqtU=;
        b=nVj/79BhZOAjgaa9mcN9C/0rhbTz0TIk+YETGTCxjMf0R9dBzVoiyZ11Au2COMWwz/
         PCASjnVS9bZa3r90jbdV/3/Kl0zSGzlyddCbS8mzQEw7h/tsW8TtcubWnVk93X/Y8mL4
         Wws60iMpMF+j+1mDoLwfMbZmB6VCpTgFz8MTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908308; x=1733513108;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2P6kqxYG7hM9Q3T51ND+biicoWpc9nKwaL2ZX51qqtU=;
        b=GVKa58MqElX+QjaIX/F5ArqqEe3K1PJrdliOjVc+Ine2StSTnnnswCqNS+0yhqiTLw
         IuSK1Ez2vp4a4WHBwyAuOeCtX09V1+aPIqMSTG9i0daOpoLLB+L5udetLR64X4OKYhxC
         cfiC4g9R1RTp3IqC7tsbiYUZyyYmzCUNuFUAQeJt2OqJvuOegdDGjjCsdI0/xY8by0zs
         PfvXLQZITQ7Nzn1BQERXAZ5XwPm1+YdyCdZN6U3nVelX1aaBVqw9XOSd27DjTlWLvP6H
         J20zR38TgpWw/yy95yn95y0sK1Ur1C+rKyYK2/oodMmc0Jl0+cTM3SHDVfzD6Wv+m0wu
         a8DA==
X-Forwarded-Encrypted: i=1; AJvYcCUzMEA9pigiB6Ze0Kdl9E1pbPURLTS+pN/aigHCVIFNVsbQZtNXC4hCBVeetVq0y1zfhxGVFT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyeBfRWyiSGC30OOICBoPc0XI4L7LXD9NBCLjgE9jgH9ZNkSM
	RV2lWMr9pjuiRU/TNXCOW00IsaB37fDsGYfpMvUElOxV5rFBw44qbyjcD2OF5g==
X-Gm-Gg: ASbGncsPZTFuk/yz/50eENYuuJHwGRsDxvCLvmqrifjKepJvku/YCvbGYLeAY7ma1P/
	8Tb1NiumQKhH2PTonGM4vRejzQuroYrFHBgx0cKaMdPiEpLxtJu65I2+33rAitIUNkajJATFGwi
	B78xm7lmh/ij9BshBmkMo6YR6E8ahOxy92nqEsxPk4/vkJ+06bZYuMnLfwFQ3d1LtIPYtmhD4Ua
	4IIjFHiIt5+Zbm9asiLoynQhidffDWlSqXdMotp/beCtNEb4u5pIYi1H9ATgcLdcpG4iUy/vElx
	hJ9X9qMJMHihLQ4eBiW1acla
X-Google-Smtp-Source: AGHT+IF3hgYG3FdIyAGfBcYlUz8j+jglg5M77s2kJmvE8nmaEsoixoMlG1D63xrZAR1waGtasuM8rw==
X-Received: by 2002:a05:6214:20c6:b0:6d4:1dc0:2623 with SMTP id 6a1803df08f44-6d864dd30a1mr191445156d6.32.1732908308478;
        Fri, 29 Nov 2024 11:25:08 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87d899ec2sm14462146d6.50.2024.11.29.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:25:07 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/4] media: uvcvideo: Two fixes for async controls
Date: Fri, 29 Nov 2024 19:25:01 +0000
Message-Id: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4VSmcC/33MQQ6CMBCF4auQWTumM4UArryHcVHaCl1ATSuNh
 HB3C0sTXf4zed8K0QZnI1yKFYJNLjo/5ZCnAvSgpt6iM7mBBZdEXOOcND7cG1VcJo2sW1OKkqQ
 yDeTNM9j8PLzbPffg4suH5eAT7ddfUiIUaLumZq4kdY2+6iH40c3j2YcedizxX4AzUJFQqmurW
 hjzBWzb9gF5L88m7gAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- change again! order of patches.
- Introduce uvc_ctrl_set_handle.
- Do not change ctrl->handle if it is not NULL.

Changes in v2:
- Annotate lockdep
- ctrl->handle != handle
- Change order of patches
- Move documentation of mutex
- Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: Do not replace the handler of an async ctrl
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Remove redundant NULL assignment

 drivers/media/usb/uvc/uvc_ctrl.c | 52 +++++++++++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h | 14 +++++++++--
 3 files changed, 60 insertions(+), 8 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


