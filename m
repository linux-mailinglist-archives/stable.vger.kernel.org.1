Return-Path: <stable+bounces-98171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE159E2DF4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644CF28342C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68720A5ED;
	Tue,  3 Dec 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UaTaLJ3y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF3209F53
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260820; cv=none; b=A+4afDI1a0ky36jNkyfZ0HTvzHiMfxwqP4OuBJaG7U8aW1jpRSlQ5IkJw7PEZjkpLV+xBmNayYnDupzD1dIr+QOFQSQomLUmfP8rJDpxhtiGlSWqfZZaxlrkWZs1wGmyMqtBUnPHSYEtJaOf8y+IFMxqgQkKqhGZNfCKJXt9y4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260820; c=relaxed/simple;
	bh=yiWDnaKGAQEWPrsfioXG/kObvCMvGeal7SEo5lhjLR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KDErFDZs3xrZSbC1WBSoceESRjygn7Dhh/rOLiNzDYs/95Hl7c/Tu5o0pJwAsW5hy4xDvOiTnITulODEXGlNhwuxworXgexPfw0lEX4YO8MbM9BIq792b84tUreOWTTr7q5Eqkqod1OqaDauTfdZnou1E+UAFaCFe3P/MKj4Qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UaTaLJ3y; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d5eabaec6so2491284a34.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260817; x=1733865617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUqstwO6CPdmwqX+lS/TVSPD1mImadQ02+TDMxhYNVY=;
        b=UaTaLJ3yKVdZtfZDQV3rJNRFw/oMdFed8PoD75MW+FXE4eDEo58bgf5TBrLWaE/8ei
         24FIxKOl6amFASh7hMzgcjfuS1OVwE2lpP1UrBkmi2VqmEKfc9XbSZzJIoYbo6bvNgaz
         srJhf3D2dwbxowyk9e0E+CX6Ks4nN0W1JNEuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260817; x=1733865617;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUqstwO6CPdmwqX+lS/TVSPD1mImadQ02+TDMxhYNVY=;
        b=WlCo5KrylMxlKD77O4tvNh+pZfOyNRySGFWpf0FN9/TMN4cKbqnrEBpMCUEGTPk0AU
         96gUdmKvo7FIxScv9VIbjXQ3B3J4kB3DG0lqUM+oVv4A1fqv1PcU/gwoReRltv8q7UP6
         BwnQXgcUCqJE7cQ0ZP/CCk4LMOYmuHUZuzxB6+B7kNT8cFmjQ6V2lUfI5wBPPSPlfEjf
         BR9m/WuFJTD9CaRcSn9cOfktKLFSvX903l7En5fo6xrb07+x9PmgcolCYDbT54y1fMhq
         NJ48Ewy28txTKJTloVvka21CcAnz70H1S0En9dVFYkNQ/DRSY73MCIU163359NzIe8DC
         ZzMA==
X-Forwarded-Encrypted: i=1; AJvYcCVKd0gc0JgJ0ClxbRB5bp6opDotZHR37IugmroNqdXER1HGINOsFM87WFycF578tYxNE8OwCIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAlZLyz9j34xqYEVcCtSYqVBiz7OzXFmvCWzgtscK7DpByTXr
	DYTIfMavKvlzCpQSy4eLgZz2GlGcr/VtBQ6uBRUHobBp7Z30Gsu2OjMDacKlvA==
X-Gm-Gg: ASbGncsQhLVMtuxLE0q4WcoQIhPwgpNdzdrhoWtayxvxW16cgMN+fi56JI/Ogcj8B7h
	S1tzW+mpA/MvnJm2sKBy4OSvsM+FB17q+G2bFbqbo8CodIPm08K4zQO8uLTUU15shk76P79b10L
	WH06XZQNimu84s1YFpnZO7ZmRb9SMrFK1jIoqcKOVV5C/2sOyiOZS3nAE7Vcl6PLDiFxuJcRuiA
	wxbXNQld5ifxOqj9gUmI/91NWcam9f4Vrzv76orbWCGyTC1G17r+C1m7IJlDWyr4fCndcW14+DI
	YCWPRENrP7ijSog+RSDd/fr1
X-Google-Smtp-Source: AGHT+IFnyLClwQKx37V6c/n+dQbcqXTB6MUoxPxvurt9+oxmPu3dvp2pF9OjaExGvkUIISSviNv1Sw==
X-Received: by 2002:a05:6358:310f:b0:1c3:98de:facf with SMTP id e5c5f4694b2df-1caeaaba9a2mr420928655d.13.1733260816848;
        Tue, 03 Dec 2024 13:20:16 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2140364241.8.2024.12.03.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:20:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 0/5] media: uvcvideo: Two +1 fixes for async controls
Date: Tue, 03 Dec 2024 21:20:07 +0000
Message-Id: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAh2T2cC/33MO27DMAyA4asEmqtCpJ7u1HsUHfRyrCF2IDVCg
 8B3L5OlheFmIfCT4HdjLdeSG3s73FjNvbSyzBTm5cDi5Odj5iVRMxSoANDyS498LN/ct+scOcY
 hKaFA+uQY/ZxrpuPD+/iknkr7Wur1wXe4b/+TOnDBc3AWUUsILr7HqS6ncjm9LvXI7ljHpwASo
 EF4HwZtRUo7gPwLDFtAEuCDsTpmY1KwO4B6CigCRpTWqRS8E+MOoH8BGltAE2CMdhHGLAHDBlj
 X9QdU6pzssQEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two +1 bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v6:
- Swap order of patches
- Use uvc_ctrl_set_handle again
- Move loaded=0 to uvc_ctrl_status_event()
- Link to v5: https://lore.kernel.org/r/20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org

Changes in v5:
- Move set handle to the entity_commit
- Replace uvc_ctrl_set_handle with get/put_handle.
- Add a patch to flush the cache of async controls.
- Link to v4: https://lore.kernel.org/r/20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org

Changes in v4:
- Fix implementation of uvc_ctrl_set_handle.
- Link to v3: https://lore.kernel.org/r/20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org

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
Ricardo Ribalda (5):
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove redundant NULL assignment
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Flush the control cache when we get an event

 drivers/media/usb/uvc/uvc_ctrl.c | 83 ++++++++++++++++++++++++++++++++++------
 drivers/media/usb/uvc/uvc_v4l2.c |  2 +
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
 3 files changed, 82 insertions(+), 12 deletions(-)
---
base-commit: 291a8d98186f0a704cb954855d2ae3233971f07d
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


