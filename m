Return-Path: <stable+bounces-192739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E4CC409F3
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 16:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD28F562BBA
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54432B9BA;
	Fri,  7 Nov 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FZ/RnJ6f"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CF32B9B0
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529840; cv=none; b=Iin4yvoMwTQlXJ+CQmMgIHdmf02513Sl8Oqg6WAUtLusybIcIKthoYdbk5kcqmAyMiQYcHFGJ+ZCZJzZXMTs2hvPluHZJlojcYt41H0+P3u2afD8Ab8F1rQzVonVW0Zr2mh6FF6s4P9j30uo1X3Av1ZmWpF2bO/zEMqSeQ8voqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529840; c=relaxed/simple;
	bh=YAtagVcx34LiTu2Em+AG4zrD5yn9L45QqXjTBIFCHBE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boH0DfRD5KvpU82B9ulJxscGMhUg+SRyK6tk6Al1avpd5BgJLNfqQrk5VU6s9NpiLHBWxfdgphwBYF+FI331aKgky0cesMoo57bzWmMUH5+s9WDePVBSph53671jtalEFXpcSbRCnNdn+O5dINymkoJNOgPMCIvwDvP+oR8n8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FZ/RnJ6f; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5930f751531so874977e87.3
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762529836; x=1763134636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTtcdT44O12GZqFLnS478W/Jpk+0DJ3d4h0jXmuqd2w=;
        b=FZ/RnJ6fWpPxXrB2+fvFJJZde+Vmv7M2WbHBwXXnJsLl529BoFWAb/F6fQUuE1SMkG
         EIDp94UvQU7xiUsXn7yVYAum3qPN9Tug63tdpkbry6XmHbMfgBXeBA3QgUza9AJrt8gr
         NTC7yy01wLjCDZ0AHLPZcSIB+LZckQIF7HRckGGC7cKh9mj3kwz0irNlIHEp0p0MqzsO
         tbHrFwWwjeGJQSjNn9c2wNbMD4S03m+6QSp/6EPzr+nebdXVL7fJ/t2V2+JBDWg+U7/w
         nYKQncAVBWHvguzUVBU7dXgs4mr1Qt6Ttq5uffS4VjbqXz65x8VnMoGmSsYm1vJkMR0v
         g/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529836; x=1763134636;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTtcdT44O12GZqFLnS478W/Jpk+0DJ3d4h0jXmuqd2w=;
        b=wCG+m2Vyta1Q5vcPYFiDRSkE6kM5DhjSGcvTMQSDnasqvHMBm2eIaiOpvWhCXwqB2l
         5gHp70gsNNt1fd/7xg21IAaZxi2+lEakYpU8GZ2LKhHrimO6IKZZ5rvHObXo1ZiJpfa0
         0VdlgcnUbst/PrVVD7Alqtn9IpQqCFoWt9X9iUXYeh3CWZGtrwJ6FGW2wOR7IfAJM9OK
         0om6j+nyOGIPt2mjxjCnXoW4UFTHxjfy9okbncte0y25Fr6MDIW/7YtQd5Yex+QoX41g
         VnopxotKjk1Nrp2p64DRQ/sazNfQgrcL6X3nVuVkPGHqgM/8b94TQIopdUhHGHqC3S3G
         mvug==
X-Forwarded-Encrypted: i=1; AJvYcCVC01QtbNWP9BDIPvnBa/kMJqmZ39URtjzpHNCsS4MpMvdFnLV5qhV453pyIo7E7SeFgZ+7Ri0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXMLTYb3DZqF3c0D8A2gPdjOyU65QsB9IDdSmZTv7i9FKLHVD
	ohDxZsFyinR1BslwQW/o/5ZUld3xv+YBW9y0Vm4j5/H4a9GZkcBLMKpQgcBTZIqVlurghz1D14C
	qA3KrnR+hv/qaDIYX3c8x0e9mH469HTFV/L1RUfOOiA==
X-Gm-Gg: ASbGncvwcFaDa3Z+aZaAM4VUr+UP1SuQ/ndPOgajR/xsYSAxg3iu6mzg8FEyWG7pHWA
	tBKYhYZD5mV6A0RTOYtijiOCnkKhveU9SFJg7ZGcDpGTNHaOhv/AQt0BeOG7evUBJOGOENeInVT
	+gnhYwcyZOUWwGULFOQKRleilh5H5SE1sQNXNeTYgrbbDuFPSdiWKPJPnYnqry7F0UY7/6AlMOS
	+995px108bg5ZyM2JF9KJjup4iyQmEulXOYgPmXhk2gB+I374Hd0PGa4igBlI2OlouiOtRiFa7z
	bfF7sUZ8s1RarX0=
X-Google-Smtp-Source: AGHT+IFIQWLvyizEJkA6WQQPfls6s2Ke/GDQq2r3QKt0gm0TI4N21r92bi9oP4EBFVG7CQqpb1Qa/kmwxqVMsaEgQbA=
X-Received: by 2002:a05:6512:114f:b0:57e:c1e6:ba8 with SMTP id
 2adb3069b0e04-59456b689ecmr1167747e87.12.1762529836073; Fri, 07 Nov 2025
 07:37:16 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:37:15 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Nov 2025 07:37:15 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
Date: Fri, 7 Nov 2025 07:37:15 -0800
X-Gm-Features: AWmQ_bm8xW_kPpRTsH9WNw3ymMoDp75e2yehSkvO8IUPn-NE_tXci0xOQuXb2kk
Message-ID: <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com> said:
> This patch series fixes delayed hw_error handling during SSR.
>
> Patch 1 adds a wakeup to ensure hw_error is processed promptly after coredump collection.
> Patch 2 corrects the timeout unit from jiffies to ms.
>
> Changes v3:
> - patch2 add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>
> Shuai Zhang (2):
>   Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
>     during SSR
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms
>
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

