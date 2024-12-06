Return-Path: <stable+bounces-99965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B69E76C2
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B1D282790
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B081E1A05;
	Fri,  6 Dec 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi9MC5qn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4E1F3D49
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505094; cv=none; b=HJUnFxGcJJLElPZLsl89VLYgyg6mYEANWQcMaByAv0Q77EP3WoOmSCZy/EThyxgbpLXTN60G14CsYvs0p9bG6fVnr615Gu7sDsM8UvEQI8K94V2CDXXdVDZUP7UT8y4tjmafXfPEV6biiu3/mjbumFEE+1YzQkHpiSeN+Ml04yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505094; c=relaxed/simple;
	bh=Uiu/rdqrGFvE3cPsx2zWaerx5CPPzjZf58ri7yfWMwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6AFJnws3Ig21Mq1YKaoGwkiEhJJld1uVpB1pDQnSYqfSq2GfG8BGE8TJ4TzSTEfmAWRMricaWwEoiw2D5uc73GqJkzODI3Yqp/C5h19/5tjY0WmowqGtHET07pNxNfwe1z8Y2p267E9FnkLEtBlIWE/fTEHRm8H8svTjLpdROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi9MC5qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B33EC4CED1;
	Fri,  6 Dec 2024 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505094;
	bh=Uiu/rdqrGFvE3cPsx2zWaerx5CPPzjZf58ri7yfWMwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qi9MC5qnhhsK8lptoJAfPl31AqAlhz0jejFXG4MQdcHmVCH8lQEVee2eVq2SpDZxv
	 FIUoS77BbKyZNQflJZtRGZQ0tNMdDH4PZ2lFQNk2Pf/VjLNHBqZgRsceoBythk1y9L
	 fzVn+idDj3+yIshlRMyPW6OZ1VRRSSnhvP8D655f1i+vgQVFprZ2bcVrJ7cSX0eTyP
	 cwwe/wIMSAH43obImT7LkUujz49ete6rUY/+BbJveDgov2r46KOUOJyz51fRPsRNOZ
	 Y68eG2iqzz6J3lNkZsqzIy2IXNB2zmlOJIuCBj4RGmn+EertXb5GUjRT8pUFS46Sya
	 8tMATy/eWyXHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCHv2 5.10.y] media: uvcvideo: Require entities to have a non-zero unique ID
Date: Fri,  6 Dec 2024 12:11:33 -0500
Message-ID: <20241206102915-20df271b3544413b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206131901.55182-1-ribalda@chromium.org>
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
1:  3dd075fe8ebbc ! 1:  24aa5750f7dec media: uvcvideo: Require entities to have a non-zero unique ID
    @@ Commit message
         Link: https://lore.kernel.org/r/20240913180601.1400596-2-cascardo@igalia.com
         Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
         Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
    +    (cherry picked from commit 3dd075fe8ebbc6fcbf998f81a75b8c4b159a6195)
    +    Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
    +    [ribalda: The context around the changes differs from master. This
    +    version is also missing the gpio unit, so that part is gone from the
    +    patch.]
     
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

