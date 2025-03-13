Return-Path: <stable+bounces-124275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30AA5F3CA
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157953ABFE3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736D266EF5;
	Thu, 13 Mar 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D0mSEVa2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E231FAC51
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867590; cv=none; b=bpBuSJuNybCsC+qY5nc4YsKWFn1e3QfUf3H8IB0rILlIK3/s2Zl50X1r+uXNTkQXPypKSjHAjaw+pOnVxhyYhmeIz6etdJ6JeeQJC85j3sJ/Diualye+O70KrN20v26TzBTLTKT/S1rxAPZ6kK24K8ArkGBrBn5cYjXxFhChDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867590; c=relaxed/simple;
	bh=YgUq00/8AbhG4t9L/nSWQetaZNYQQMmFFe2guzrS0oQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jn5OTZ0WsmV4dnZiZhFbT4ZvuA83BC/SYH8ZlTyL4Oz5n+bId/nmKRHbAehAXb+Tuy0aedW937DCsoviHkJv7QbTI6il8KqAn3pBEp1k8AugJkLq5BDs+nklub62epeCqtKcG5LlDVEYyJcZDozCLXDcgkEVq+rZY2OS2N5biww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D0mSEVa2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0e135e953so78727185a.2
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741867587; x=1742472387; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HHfyOLpdx1aPPgPI4Rp9Zj3D1LYRLFjWWXAeeSzzaQ=;
        b=D0mSEVa2Ni2Y5XtUTXWkGBJ8YuVZHcfBIgmzF0tGh8UyDZVqIc9cu5Zi9HSyN2d7LX
         Ah+dZtjCQXN1IjE39meiablIUScuOPzXwC4GL5lEMn+RlcksAawkZLJx5jAwRmPmweif
         1Jnq9rX2lwwQbHu0Q692XBf0XEzhI62+4wQDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741867587; x=1742472387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HHfyOLpdx1aPPgPI4Rp9Zj3D1LYRLFjWWXAeeSzzaQ=;
        b=lC4vspp1WvSiIrBYbzZCca2q2VtRwzzTnpkLkaXWGqMGm4W04sbaV8zwTpAogGlcRq
         Ce9HUYunOICV3/2MgozrDt372TSLwtZiH5XU5cnoeBkW45D9VHcWhPEUKBcFBMfYFGtQ
         yKA0WCe491QsBZKAsg82PGg2sGk52co29U6nUtTHEv+QSo8/0z8dMbiaXbiKv0S/RX4n
         d6haoiNvRzpB7fXLFsQHkS6sTzc/HodjpYZtKJRY5lqlzeckC4nQITOI0uJ73ygR2oLe
         3RdqP4+FaRRUrpA4kbrOSCbN6jz8Ye20VFoj2SBzovr3OqpX9edhtzMUG8kmDGSUCCVT
         oIng==
X-Forwarded-Encrypted: i=1; AJvYcCVvLL40FFMMVaTxk98kbv/FDP+yJHUJz+JxHdP798LMqVYvVihYrO2ZQ9p2bscYKRv7BKhkJ3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrzh9KRpkYiyLUAAmYk1ubwVA0M1JoEm3yNld09XtYUgB8tbxL
	JU48OHNJH9UI8hd4D1sbrZra4jcE5H5jsMsWgketeHyn3xON0cOiPc6zZvMhwQ==
X-Gm-Gg: ASbGncvJDpLoaYxI0Ebc1n2d/ufX06X8Z/L6HIsU1p7i1cSj2X7/EFZVBiVs+I5FzUU
	t/pw3CQXTczMz2xguImzxlXLd4m2ZAGFRmpMz1MTbryQKV7AD1q6tgs36XDiR6bj7bwYbVjx/in
	WP7mZfJP0oq+25py9uNgsQPPtwGhBQuRIt8gDg9Q9pJF18gXsLD/FumKCwqUe8VuNjsMYcSZSMe
	gudWzumj9Ca8SV0hS+wjRNQtoYRvDJ86AjDs4o8vDMwzCU+AwkoBBFI0gIjBCBbvwIMt9u3XdEf
	p2Gk48VIZrB0zuqLAtwpeHcBVEqTGHRT20u2jIIbXHvGm8xTyXJdfu4JSfZ+98MCBG1gT0QgQ7U
	ZwUfAhGWsuJ2wableFbKAgg==
X-Google-Smtp-Source: AGHT+IGLSM49dNKretr2HZ5V+KCsqhUkgKSImjMwSG2jKqCqMqncxxsSoTFy9uuqSCOzVvGsMJ0i0Q==
X-Received: by 2002:a05:620a:86cc:b0:7c5:5883:8fbf with SMTP id af79cd13be357-7c558839293mr2121678685a.21.1741867587461;
        Thu, 13 Mar 2025 05:06:27 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4db57sm92117685a.8.2025.03.13.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:06:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/3] media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM
 + other meta fixes
Date: Thu, 13 Mar 2025 12:06:24 +0000
Message-Id: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDK0mcC/3WMQQ6DIBAAv2I4dxtcBWtP/UfTA4VVOSgNIGlj/
 HvRSxOTHmeSmYUF8pYCuxYL85RssG7KUJ0Kpgc19QTWZGbIUXBECXPSMFJURkUFSA3VtWilNMR
 y8vLU2fe+uz8yDzZE5z/7PZWb/TNKJZQgtZEdCdKonzc9eDfaeTw737PtlfDXV/zYI3BoqK3ai
 2i0MuLQr+v6BUORt83rAAAA
X-Change-ID: 20250226-uvc-metadata-2e7e445966de
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

This series introduces a new metadata format for UVC cameras and adds a
couple of improvements to the UVC metadata handling.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Fix doc syntax errors.
- Link to v2: https://lore.kernel.org/r/20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org

Changes in v2:
- Add metadata invalid fix
- Move doc note to a separate patch
- Introuce V4L2_META_FMT_UVC_CUSTOM (thanks HdG!).
- Link to v1: https://lore.kernel.org/r/20250226-uvc-metadata-v1-1-6cd6fe5ec2cb@chromium.org

---
Ricardo Ribalda (3):
      media: uvcvideo: Do not mark valid metadata as invalid
      media: Documentation: Add note about UVCH length field
      media: uvcvideo: Introduce V4L2_META_FMT_UVC_CUSTOM

 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 .../userspace-api/media/v4l/metafmt-uvc-custom.rst | 31 +++++++++++++++++
 .../userspace-api/media/v4l/metafmt-uvc.rst        |  4 ++-
 MAINTAINERS                                        |  1 +
 drivers/media/usb/uvc/uvc_metadata.c               | 40 ++++++++++++++++++----
 drivers/media/usb/uvc/uvc_video.c                  | 12 +++----
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 8 files changed, 78 insertions(+), 13 deletions(-)
---
base-commit: 36cef585e2a31e4ddf33a004b0584a7a572246de
change-id: 20250226-uvc-metadata-2e7e445966de

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


