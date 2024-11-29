Return-Path: <stable+bounces-95844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D19DECE8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7014516378A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346315B99E;
	Fri, 29 Nov 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J62llk9P"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6C3224
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915828; cv=none; b=lXjNAnLsEDv8vetHycyLZxanILA4XA2F2GDoylW2Yqf9Jyd4/tGNAip4Qu9yIW2QBLY54O719BOxZ6CgHR56uqbt6LaMPEqMa8QlfY8U+3944rJoCaytd9K/j77MuPsh/Nfiog0xjfxD0RfBMN3rsIGV1Bjp1VpGXIoaIjzPIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915828; c=relaxed/simple;
	bh=nYkHkRvpkNdvIZJn2YLIhlMUISS+4WYqIuvfld/m/PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cizexvSeEvys+s4ZPzA1uzfFSuM1WOzVyLp0AFrrioSrnP3BgkyqwrUR7LGELHddia8KDLSr1KgcVBdq+FuR+lI2uGLUqIvihfdD64UlVff6RulK0y5gA8mv1S7tpUAZf/591uxEB/78onPpCyzJrrXh11vHg92AmVrxy5zE5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J62llk9P; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-515285c340fso548235e0c.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915826; x=1733520626; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEtOYUhTm1yMl8PMnYbRP1+IklxVsjQpfdhOS7bdpKM=;
        b=J62llk9PlZKsdAkyP+lqGQ5De0sfnsBUWFhobFwV5uUn5E0IFZUoelz3V/4IgWs/jV
         HTreuBCfqDR2hgt9U90Q2Av0RWZAJPm5Y+MxLo81PfDziaSBKFzdoDkj8+5BnaHGKjiX
         Sae32WCzC0rI/DbKZ+1KdmyBhYZPbZxM/K3+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915826; x=1733520626;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEtOYUhTm1yMl8PMnYbRP1+IklxVsjQpfdhOS7bdpKM=;
        b=uMDx5SoYGw/Bzd4/jT3uG1qLW246RQ3kePhjZLpNRB3bOzJgs9VNUTb5ogqLbhc9kP
         X67bS2CUYmaSh8Ib++hMvGFmvL3wELtQRlls/pow4/FZzB3ebESbUhDeXqLE3Bv2ggAf
         F4T19grlkQ9Qx5+fbvqoWBO7GPBv/cEl0Y9dJwBUhwUVL0PifJ9JZ7/KnL3JLYD6Vw/8
         mDnLcMlAblxi+OkOMIBr4H2LcFyL0W/toamf+xwr7OJcEhLcvOohKthxbpfYd0Qbo1wY
         dEbeNAXvXY+rQbMgJ+TJ+FZDB4wUBnJwIsDm5Fx8V8SeXNDSfsAp1o4mcbiiWmUOpjZh
         K27Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/KD4xt6HnRpjIvY2ALgI/B4Dcyw7RjFxCOmht9Lx+ecT+yOhJ7na3EjyYLEqGowd3P3+KUBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVELl+Ef3vPmPTGDiZDPSdFbeBg3UnPquFBj7M3/Jb2aZpx/NE
	Zg1MO3mswn4JAFJQYysJ1m4fPhcWhJ11A1fy0GhqO0qmnme6A+buGTiAAS6kAn+jgRvBaVu4Qxg
	=
X-Gm-Gg: ASbGncuI8M0WQGP4SzwoSacwa4dUEnpVLX0KjCTBjZlqKK1pmKOlMZPsqIq9cjjYzQF
	eb1TjTSi4EeUKA562MsTOQRKEUy36jsm7un9D/J2yrRyS8xpaEKnCnbiN2RBZgglCM175dcCSV2
	O5emEuvmcpTNFI0+SQkIPNZxkGYQYrXUciKMyUUqc63wSK6gRJKn1GpUbap3OKxR/zP/4kVIReR
	P/F5+w9FNWgjxzGmhnlLv7ZDlB4JfGtcEa6v4df8hP52E4PjWJ7UBf77VejerQQcox3gBmhTTCk
	C8CA5MSpaPi/7cenZFrU57Xz
X-Google-Smtp-Source: AGHT+IGNpp6QJ5chVFfuFB5iPzglq9eZ6jrKyiQH4gSZcL34SNi57YCR7FzR3uBuvx5B9lJaPSfVYg==
X-Received: by 2002:a05:6122:2002:b0:514:e4b9:7605 with SMTP id 71dfb90a1353d-515569dda9amr17740611e0c.8.1732915826133;
        Fri, 29 Nov 2024 13:30:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0c1b7asm607254e0c.36.2024.11.29.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:30:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/4] media: uvcvideo: Two fixes for async controls
Date: Fri, 29 Nov 2024 21:30:14 +0000
Message-Id: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGcySmcC/33MTQ7CIBCG4as0rMXAAKV15T2MC/5sWVgMWGLT9
 O7SrkyjLt+ZfM+MkoveJXSqZhRd9smHoQQ/VMj0augc9rY0AgKcUpB4zAbf/AurNA0Gg2ktJ5w
 yZRtUNo/oynPzLtfSvU/PEKeNz3S9/pIyxQQ73UgAwahuzNn0Mdz9eD+G2KEVy/AXgAIISpTSr
 ZDE2i8A+wTaPcAKoHQthXF1bbXcAcuyvAGaqKXOLwEAAA==
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
Ricardo Ribalda (4):
      media: uvcvideo: Do not replace the handler of an async ctrl
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Remove redundant NULL assignment

 drivers/media/usb/uvc/uvc_ctrl.c | 62 ++++++++++++++++++++++++++++++++++++----
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h | 14 +++++++--
 3 files changed, 70 insertions(+), 8 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


