Return-Path: <stable+bounces-95547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A99D9B3B
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0073A167850
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287E1D86F6;
	Tue, 26 Nov 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ROAGRC8a"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631ACBE46
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638025; cv=none; b=ONKzadnwy8ahFMfy93LYXoxdAuNIFbngGWQUtfNk3SCU2kAr4ksNvRHYPmyl1S75qsZvNXfxRr/l36hQ3cdXMVlWRWqvYIFt2cQPSTdn8rTjwNzss8F5UVLVY7egGDmyJMtXHTuY1sVLkapvVAhEpBsgZ1uUZTfffW3jIzEhDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638025; c=relaxed/simple;
	bh=dSQ7ETPxUqr7Y8jY5HOOpL2zd0d1eXHqZdnF61NKGPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N69laKbOghVpDM7hm6rkPZzBiKGX+0iZs3m7KK6nMyQyQElPD11vjlTHzuOXkhggyWntK7xmDRoq7crwtM43Kn4qxYWDt8fS+12RpQunm3hFEwgVbmf3f07bxperHJcb1N5N51CPj/uFtyYTlvHyTW1hoKRIKQ9Drok3FtkVqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ROAGRC8a; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71d579d9658so845853a34.2
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638023; x=1733242823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5h6wJYoG8v14a/k7G0R4omEhI1WXt8Qcm4fv6qiXWkk=;
        b=ROAGRC8anXQPCtnU370jhvfT3931HKw/C2oPcy/HQu5YA5ZhxKv5h13r2Asldx8WFM
         FIa+aPq1osYo9oNHrYAl5+vaqr7FhptZstKRAaGoOis7+N9M/0bILWHn8BwWzgiIllTZ
         8xEdI7hwYkdubCKnjgZBv9shoubMIJDeHZhsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638023; x=1733242823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5h6wJYoG8v14a/k7G0R4omEhI1WXt8Qcm4fv6qiXWkk=;
        b=wtz5upB9cpxi6u2FbYO15jsMSzi0Iiv/806D0WqMMLE//0WyhI6+JtDTnYHyfLp6sH
         8lBtH79BPrCOWkfwr6AkdwLmOTH1opmZmyCyq1kzjfbaBTMxGAJSkjOwNR5FXI2iJEyp
         ZeFeVwasO2G4viMZqY0FRdeUPgQjVWe42WeWy59IIfflYmizSZUnZ5i07Vdggg68HmIR
         qY6HNO7ZEsKSxOLaI4cjC7HU8IeeuheNWGiPsARm1y/7aq0NNwo70jStaiz+w8chB34p
         qv9Y+flKXsKZJZ/502LvjbAiqJQEF4FSCf5nvjKfstNhhDEWKIfoLPstE9sOyiELOBZt
         oiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCmondwvCnkU5DMadofvEvKqsTDTo+UYMuXiuSVeOocaNrq11jis8qrU2qVZFIHEtXJcI1O6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcLRjfaylnkgt/7Tun9BYynSwQjHhrvCpiJ3RurAP/tUMhLcn
	1ri/UkUVqHbYaNrV9+6JIPxikIP5DbK5R7ceZdvDtvYUI6vUxSScV78U2XdOnQ==
X-Gm-Gg: ASbGnctMo1O3XRObhhtCfo8rHLxU02jq8VmIoLJOGW2axxW5T7E8FfphBBu5ZYdHWwx
	6nSXyBsjXuKDRIyJFINTWGJZcx7UWGa54oVFgFAVC2INSufA7hECPu88SqE7kZ3eUO8hI0/HjEy
	KGzg82TG0tLPvw7f5Ure0JPSX3IXGCuPkL3kyCQ5OzTsAojs06bej2Cja8xDjkXLoBVHrajnbX6
	+W2ZB4o8M5rqQ/DLRW/5tpxRCiOGl6lOTDnPtnThreszFeaX6GtPc3tKYl3p2JoDB9O04oZTyed
	VtfNBgnhJssd04ZtUH5SYhh/
X-Google-Smtp-Source: AGHT+IFG2bZ2P5Zn41kVEQ+tyZFJfQtiniQ3kN0ylxwnAa8drHufHNkYqM3/xaK/IlGeahhM3vi+qQ==
X-Received: by 2002:a05:6358:1281:b0:1b5:fa8a:791b with SMTP id e5c5f4694b2df-1ca79805541mr991681755d.23.1732638023341;
        Tue, 26 Nov 2024 08:20:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/9] media: uvcvideo: Implement Granular Power Saving
Date: Tue, 26 Nov 2024 16:18:50 +0000
Message-Id: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOr0RWcC/x3MywqAIBBA0V+JWTeQYvb4lWghOdlsLEZ6QPjvS
 cuzuPeFRMKUYKxeELo48R4LVF3BsrkYCNkXg260UUpbPK8Fg7h47DcJxoCNHVTfOutNZ6Bkh9D
 Kz7+c5pw/KV0QamIAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Right now we power-up the device when a user open() the device and we
power it off when the last user close() the first video node.

This behaviour affects the power consumption of the device is multiple
use cases, such as:
- Polling the privacy gpio
- udev probing the device

This patchset introduces a more granular power saving behaviour where
the camera is only awaken when needed. It is compatible with
asynchronous controls.

While developing this patchset, two bugs were found. The patchset has
been developed so these fixes can be taken independently.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (9):
      media: uvcvideo: Do not set an async control owned by other fh
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Keep streaming state in the file handle
      media: uvcvideo: Move usb_autopm_(get|put)_interface to status_get
      media: uvcvideo: Add a uvc_status guard
      media: uvcvideo: Increase/decrease the PM counter per IOCTL
      media: uvcvideo: Make power management granular
      media: uvcvideo: Do not turn on the camera for some ioctls
      media: uvcvideo: Remove duplicated cap/out code

 drivers/media/usb/uvc/uvc_ctrl.c   |  52 +++++++++-
 drivers/media/usb/uvc/uvc_status.c |  38 +++++++-
 drivers/media/usb/uvc/uvc_v4l2.c   | 190 +++++++++++++++----------------------
 drivers/media/usb/uvc/uvcvideo.h   |   6 ++
 4 files changed, 166 insertions(+), 120 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241126-uvc-granpower-ng-069185a6d474

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


