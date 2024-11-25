Return-Path: <stable+bounces-95386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B39D87D6
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF2E161F1B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805601AF0C1;
	Mon, 25 Nov 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWul6A7Z"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82321191F84
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544669; cv=none; b=j77tsjRbjnnQ9YvkEHWMnDvu2CT2vyk8HyC+2ucicoZ8oCAq6DpILt8TEMtp9Y1iIvP09aF2p/GdiwaFr9/GU4BW5J0l5acPwVML6SSt5vnB9dQCCi+wxIRdmaeDkfHoaFxTM9lvTDxeCm30M3vM1V5/AWggWp3Io9mh+QbeLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544669; c=relaxed/simple;
	bh=PAApblf5/yOuk9I4BzfC+hcjl0lxlkL+IWpwS5snJeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkWwpxElgZZ48GBOBVKX6XEqbJWPbtqL+938fs1AiPh17PnZJMfSy5DYJ9tkHRtiFxKF9vqnsHF4jaCLn4hhlfPZh9G2w/6dcJ6kHOPGomBg+8KFaY7uxGC1Ymz3uq3YOk436m5Zlfb6VcTCQT9TwV/tDsESUBZxx9EfrE0Rkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWul6A7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732544666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAej4OPlBRSwRD5hkCmUtBDLkFXG4Wh3poAJBOLJFhM=;
	b=RWul6A7ZYPPS8a2sxq+lD/MpD4oDa82ZEkOV+ptOGHhLYQd/5+eeBu+KOn42yKvDsIjd66
	ES0vimhSfPzr9jPI10mpPmt9tolwuhlEn+9Uy401L9mXlSw7HoLTweMGLo4BibkWh8R/hX
	t8ZDjAd1HY9D3q8LwJNdryT08nDVRhw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-O_wx4yPLOP-AhmQDwh9LKw-1; Mon, 25 Nov 2024 09:24:24 -0500
X-MC-Unique: O_wx4yPLOP-AhmQDwh9LKw-1
X-Mimecast-MFC-AGG-ID: O_wx4yPLOP-AhmQDwh9LKw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa52bfbdfebso167458366b.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 06:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732544663; x=1733149463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAej4OPlBRSwRD5hkCmUtBDLkFXG4Wh3poAJBOLJFhM=;
        b=riYCxYGsl1iKJNHZtArZhHgo6wguTE3dxBXM2GaTQsAsehVDjh1/h+Qt8DalNkGpPb
         9N/DthHzYFYamYFlBuW/6EIl/InXbvbZlSDjW0OQrMvKM0OzUC1uSrgsSXk3NhtIM4J0
         zzOl8RSCsfwfxACjjeL/J9Sw3tnTBo+mTlmh4cFV0j9fU3uTd4P0jMfG9k095oKbRFls
         wuQZKsNp3du/lO3oU3TENwBVttpP3VcuEErF0Wsi3vMMhB0CgU49WmopmEyt3rSthmAk
         V2vK0F7umEyqykeqymzneQ7qT6IJUcQZy3ODL2LNT6QEsIw4+WdPBp9QYiAVFEUDax1z
         Uenw==
X-Forwarded-Encrypted: i=1; AJvYcCWOVM2SAw55ydU1AHxfNtzOS/S8qIlvYboRriwbIq0oRPm+oc/JJA6cRafqyHSR42y5B/wbvgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWl+Dqgv4LfCnRCMLzUgWmsxL5UzaGy7vbSMmYLqPeQty7c60H
	f34IAi85XoBjlVgnDDwdMB4xlcwdbI7HmMygDLCCQG0dT9lWeDxA/L/N39ku26rTXUJx7okEVvm
	ClECVkRHeySK7h2KMuHXi9IERuQZmni32IL9shVVNXSzseMHdNP/TRw==
X-Gm-Gg: ASbGncvNIsYR4HK6049UnUWM49zNabDbBccN4JzqvqIW4ZBZlyyvZpjrXlf8fsmiPpq
	IiDLnTkmFwn+FceEYCkPsFka5pzXFDxpfvq44Fza/aPWxD/NJ0oPpxrqa8h47/ETkyxBTWfpbP3
	2Ww7mS4MVhY4JJ++Yt7gmBhpuQvwaIMQ7aTVh8N1Efilhp9ufo1+hZC8RyzPvqRFKTKlLUVKCVQ
	tyqK3clEw7mtofXKMTnaUpkpM4szgwD4EQs5ngetDGaLvtXd/VsLGd8CxfR0TgCByf8HxdYyt4o
	vlIOceGdaXIqfKoS7n0Gj0paU2SeN/jpRLQv/kq7OvbFJU1I/+8tpILgzHBzWNQvr34NONqJQqV
	PY9IizYWqH6PxMtKfOHrXSUSl
X-Received: by 2002:a17:906:3194:b0:aa5:274b:60ee with SMTP id a640c23a62f3a-aa5274b69famr1018207866b.39.1732544663473;
        Mon, 25 Nov 2024 06:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoGDD47dfwy9wZFvAqX4WMcfksgKqNJCU6tx7BOnVPBVTlVWMX5EUDMfzlOkKD2trMBOUnQw==
X-Received: by 2002:a17:906:3194:b0:aa5:274b:60ee with SMTP id a640c23a62f3a-aa5274b69famr1018205166b.39.1732544663087;
        Mon, 25 Nov 2024 06:24:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa537b4eae7sm302808966b.99.2024.11.25.06.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:24:22 -0800 (PST)
Message-ID: <a321900c-2be7-4fe8-b693-4a185f1d5aa4@redhat.com>
Date: Mon, 25 Nov 2024 15:24:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] media: uvcvideo: Support partial control reads and
 minor changes
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 20-Nov-24 4:26 PM, Ricardo Ribalda wrote:
> Some cameras do not return all the bytes requested from a control
> if it can fit in less bytes. Eg: returning 0xab instead of 0x00ab.
> Support these devices.
> 
> Also, now that we are at it, improve uvc_query_ctrl() logging.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you for your patches, I have pushed both patches to:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/next/

now.

Regards,

Hans



> ---
> Changes in v4:
> - Improve comment.
> - Keep old likely(ret == size)
> - Link to v3: https://lore.kernel.org/r/20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org
> 
> Changes in v3:
> - Improve documentation.
> - Do not change return sequence.
> - Use dev_ratelimit and dev_warn_once
> - Link to v2: https://lore.kernel.org/r/20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org
> 
> Changes in v2:
> - Rewrite error handling (Thanks Sakari)
> - Discard 2/3. It is not needed after rewriting the error handling.
> - Link to v1: https://lore.kernel.org/r/20241008-uvc-readless-v1-0-042ac4581f44@chromium.org
> 
> ---
> Ricardo Ribalda (2):
>       media: uvcvideo: Support partial control reads
>       media: uvcvideo: Add more logging to uvc_query_ctrl()
> 
>  drivers/media/usb/uvc/uvc_video.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241008-uvc-readless-23f9b8cad0b3
> 
> Best regards,


