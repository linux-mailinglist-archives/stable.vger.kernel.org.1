Return-Path: <stable+bounces-119989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF38A4A87C
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225B5175A67
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC8132122;
	Sat,  1 Mar 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU+2byhF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FE2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802864; cv=none; b=Yq7fxQsmDrysqPAVrDjhSZA0ynQAfLGj6TPab0pU/zkEuWWQXuq+G0cish8eotcKtbJl32nZZfkXqg4BrT0CDY5PuylUeyyzqp0n/dz78heyH5eR1iozRh0xeQ+KroeC3cOqdcpbQu1MNV+S9D+7n9AMrcRBYDArtHRwmTW8ofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802864; c=relaxed/simple;
	bh=hpuj20jsdJCnsPpH1twBtfgvLPR2zBQZvDImSGspJCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ6OhfPzXjMnKSiWOTJLfsJi8n6zL7xm5Vq+FlptT/Nv8MHdnKWXcvP5dKb7LH3bfrkKp2Z4+GBw2mCPgqXIhKZIQutsN3c3f7HjuOf3h5BRQz0XhZdFpoUcGCi/2chEtMBPuj1lBCj0WiMcvXNOFQ8rw7+odImYXq0eU870E9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU+2byhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48197C4CEF3;
	Sat,  1 Mar 2025 04:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802864;
	bh=hpuj20jsdJCnsPpH1twBtfgvLPR2zBQZvDImSGspJCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LU+2byhFT4C1OeiRnRArxnWxaAQwXRIGXuZITVZz/OQynrLkvrzug8Azm3qC8uVbb
	 1v+Hay2NmtnPpHTk1S6G5WRnZz/IKipqJTzINNQbgT5ak3CIG8sHLcd5NrB7J53ZqL
	 4RHbFro5p5qS9UbBtQ3+EIKSZ8YtNFc8vPGjk+mdKelBTyRzU4NAbCgZnnx5oWCOZz
	 wNCiyt62/j8fTCCm3FHXHw1viMCzMWQCOO1KBrq7Lvs8pOMDiBCm4PsqED6/sgLNx4
	 zWXqRrjuZZG4l6vLaTIYhPO33M8ooq72gRz7XwgseUdtERgurXxz0e+rTsXrEQTVI/
	 vRuN5XWL0USqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ribalda@chromium.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] Revert "media: uvcvideo: Require entities to have a non-zero unique ID"
Date: Fri, 28 Feb 2025 23:20:41 -0500
Message-Id: <20250228175544-5e1eaa9ceaf2cafb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228075825.2638729-1-ribalda@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: 8004d635f27bbccaa5c083c50d4d5302a6ffa00e

WARNING: Author mismatch between patch and found commit:
Backport author: Ricardo Ribalda<ribalda@chromium.org>
Commit author: Thadeu Lima de Souza Cascardo<cascardo@igalia.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 69d44bc03db2)
6.12.y | Present (different SHA1: 0a14a2b84177)
6.6.y | Present (different SHA1: a80f82d31ca6)
6.1.y | Present (different SHA1: 996ca83c4610)
5.15.y | Present (different SHA1: 367c47db178d)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8004d635f27bb ! 1:  891a75127ec4c Revert "media: uvcvideo: Require entities to have a non-zero unique ID"
    @@ Commit message
         Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
         Link: https://lore.kernel.org/r/20250114200045.1401644-1-cascardo@igalia.com
         Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    +    (cherry picked from commit 8004d635f27bbccaa5c083c50d4d5302a6ffa00e)
     
      ## drivers/media/usb/uvc/uvc_driver.c ##
    -@@ drivers/media/usb/uvc/uvc_driver.c: static const u8 uvc_media_transport_input_guid[16] =
    - 	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
    - static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
    +@@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_streaming(struct uvc_device *dev,
    + 	return ret;
    + }
      
     -static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
     -					       u16 id, unsigned int num_pads,
     -					       unsigned int extra_size)
    -+static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
    ++static struct uvc_entity *uvc_alloc_entity(u16 type, u8 id,
     +		unsigned int num_pads, unsigned int extra_size)
      {
      	struct uvc_entity *entity;
    @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_vendor_control(struct u
     +		if (unit == NULL)
     +			return -ENOMEM;
      
    - 		memcpy(unit->guid, &buffer[4], 16);
    + 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
      		unit->extension.bNumControls = buffer[20];
     @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_standard_control(struct uvc_device *dev,
      			return -EINVAL;
    @@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_parse_standard_control(struct
     +		if (unit == NULL)
     +			return -ENOMEM;
      
    - 		memcpy(unit->guid, &buffer[4], 16);
    + 		memcpy(unit->extension.guidExtensionCode, &buffer[4], 16);
      		unit->extension.bNumControls = buffer[20];
    -@@ drivers/media/usb/uvc/uvc_driver.c: static int uvc_gpio_parse(struct uvc_device *dev)
    - 		return dev_err_probe(&dev->intf->dev, irq,
    - 				     "No IRQ for privacy GPIO\n");
    - 
    --	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
    --				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
    --	if (IS_ERR(unit))
    --		return PTR_ERR(unit);
    -+	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
    -+	if (!unit)
    -+		return -ENOMEM;
    - 
    - 	unit->gpio.gpio_privacy = gpio_privacy;
    - 	unit->gpio.irq = irq;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

