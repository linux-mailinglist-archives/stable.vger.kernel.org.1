Return-Path: <stable+bounces-99966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AC99E76C3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3156B1884737
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B381F3D49;
	Fri,  6 Dec 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVsu1gs/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44372206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505097; cv=none; b=aok+p1kjhK+Bgi6eg5cwJQDA6fu8/QKb0Dpby5zUMpWWUkO4Vql1gSn4oFBmLHN4HzVU9o2wpzG9A1sQ0EFjOUaH18vR32z6EF+DesVKEmYOKfk3BInGj0+QCfIndOml/l5dTZtue929f8dqVizwlQAF/Dg5X6KhkS6olSIVic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505097; c=relaxed/simple;
	bh=5ekITlpIjkDRYpU6jMjpl7ymzL7L9AE8hCNf1ASHqlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=louQsxqlaEKsC2K9KHCgXZZozFlIJXXmWZnVHGLAbkQjPJmbVjYit5ZvC23XFyRfdjbqX/HtEEWjlcBb/NsVK+l4tHZNCw875kQpHSyhv/JK8CS01//+IzsfF5azKOqvFByxsDn17rvUosfRSO0qTwyU3djQpHTXvJVAF9FiP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVsu1gs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471DAC4CED1;
	Fri,  6 Dec 2024 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505096;
	bh=5ekITlpIjkDRYpU6jMjpl7ymzL7L9AE8hCNf1ASHqlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVsu1gs/xAgk3oLhLXYT+XDw+5DBKVuT7Sig5dMC0Pu7SUmao5J0fT0JuZnHOwCmK
	 xlJZMQ9EYEa5GYklO7/ZR4uxHijfzUGF3oOuwHSftP7FnZ+lq6EGix2T5NzxPqHHSP
	 4XQGD3dt+7AamPZ/jxzzvEuyMCIcupBLpglL106Pjw2+YlF+WS1dWwZXQlvx98hrxG
	 KNVv1cxF9V4nJM+DPXWGBlM1BlPfMicAZjPyWeD3p7poa0I6/YIJsZnazpsNY7bywr
	 //nPWPH/21+LmOsqITcoOU3PLj8wOuf9WYxsXaZuXNKJAkXp96Ll1xz6tVmfWcmmpG
	 LdDXzYh0FFSxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] media: uvcvideo: Require entities to have a non-zero unique ID
Date: Fri,  6 Dec 2024 12:11:35 -0500
Message-ID: <20241206101637-f53e835a4a2c9d82@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206125901.49354-1-ribalda@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 3dd075fe8ebbc6fcbf998f81a75b8c4b159a6195

WARNING: Author mismatch between patch and found commit:
Backport author: Ricardo Ribalda <ribalda@chromium.org>
Commit author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3dd075fe8ebbc ! 1:  9b7a621838d34 media: uvcvideo: Require entities to have a non-zero unique ID
    @@ Commit message
         Link: https://lore.kernel.org/r/20240913180601.1400596-2-cascardo@igalia.com
         Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
         Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    +    (cherry picked from commit 3dd075fe8ebbc6fcbf998f81a75b8c4b159a6195)
     
      ## drivers/media/usb/uvc/uvc_driver.c ##
    -@@ drivers/media/usb/uvc/uvc_driver.c: static const u8 uvc_media_transport_input_guid[16] =
    - 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
    - static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
    +@@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_streaming(struct uvc_device *dev,
    + 	return ret;
    + }
      
    --static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
    +-static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
     -		unsigned int num_pads, unsigned int extra_size)
     +static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
     +					       u16 id, unsigned int num_pads,
    @@ drivers/media/usb/uvc/uvc_driver.c: static const u8 uvc_media_transport_input_gu
      	extra_size = roundup(extra_size, sizeof(*entity->pads));
      	if (num_pads)
      		num_inputs = type & UVC_TERM_OUTPUT ? num_pads : num_pads - 1;
    -@@ drivers/media/usb/uvc/uvc_driver.c: static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
    +@@ drivers/media/usb/uvc/uvc_driver.c: static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
      	     + num_inputs;
      	entity = kzalloc(size, GFP_KERNEL);
      	if (entity == NULL)
    @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_vendor_control(struct u
     +		if (IS_ERR(unit))
     +			return PTR_ERR(unit);
      
    - 		memcpy(unit->guid, &buffer[4], 16);
    + 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
      		unit->extension.bNumControls = buffer[20];
     @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_standard_control(struct uvc_device *dev,
      			return -EINVAL;
    @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_standard_control(struct
     +		if (IS_ERR(unit))
     +			return PTR_ERR(unit);
      
    - 		memcpy(unit->guid, &buffer[4], 16);
    + 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
      		unit->extension.bNumControls = buffer[20];
    -@@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_gpio_parse(struct uvc_device *dev)
    - 		return dev_err_probe(&dev->udev->dev, irq,
    - 				     "No IRQ for privacy GPIO\n");
    - 
    --	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
    --	if (!unit)
    --		return -ENOMEM;
    -+	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
    -+				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
    -+	if (IS_ERR(unit))
    -+		return PTR_ERR(unit);
    - 
    - 	unit->gpio.gpio_privacy = gpio_privacy;
    - 	unit->gpio.irq = irq;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

