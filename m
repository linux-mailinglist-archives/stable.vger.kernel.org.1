Return-Path: <stable+bounces-109569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A356A17209
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 18:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5583D162D23
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790691EE7B4;
	Mon, 20 Jan 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VioYsZ1+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE417BB21
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394570; cv=none; b=fMO6iVlFAyeMPhECXBujgf9AfgGpaA9fO+nj89xCKNjjecKN2SXdbuJbtLSoHoModSymYhweYdrLe80+Ft+WYIPTbNqvsUjeKbWxwvNfn1k3TTpjWh9forgamiR1ETvcBpQLf9VN5P1QS+6nZcTWBifzKiDtXP0u5Bta7pDIZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394570; c=relaxed/simple;
	bh=OWjCs7c3Z3OCyI44BJJJ8m95UEV9C/WJxLxyxMRcTSg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gQMUHrR2kG/RzaEZBahWCxaqs0V9FFepxu1bmy6m3WCg5K74jtUIzsZlpGz7YFgzYhHyctVfED/wKDK8bFGLHZqOLnDASSnkykEd3CiS1VzRWsRTow7aDs13PdAnXRN+q+AkwfpUKK3LWp1vQtLCKcn9ZHVMJg0nvUJ/uDPd5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VioYsZ1+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so7932434a12.2
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737394566; x=1737999366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvc2Rz1m9N2wS2uwg8ORhL6LSIX/Tdz2W8B7SCeMhIs=;
        b=VioYsZ1+N6F0wrpAy1AWNBvW6NenXCPevAlIuZBYRf9WCTBGo9AIce//FSetRm2Q6e
         /aFvvEQkkD9cKz6DaLYlGocisa4m5hmq3kpJsC4L25qTFwsNkdNUm9H+0gr9Ef/dqGBE
         5HmzmrOD/hMjsiKaNmTcj9zdGNW1P5E3kUHPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394566; x=1737999366;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvc2Rz1m9N2wS2uwg8ORhL6LSIX/Tdz2W8B7SCeMhIs=;
        b=XBoQGVoFVsNdFmlTXsEtbCu3UiQFg3INFWrbVBYgtfF6F2Lkwx85cL/tIFS+e6cxwU
         q3g4yNzxoarN1r6/miipBITDoQwLdql681OqyFoJmp0llNWxsN125m4GiixYovuyXBBB
         ncZ87dOUsbDBHz6/TJy39l6NwyRO7iDd9yiHkAUiYBY7aBeRIb3Z5WR56vSYxsYyURl4
         pmjumEZmWZonLkBZYP8EyVQ4Cmdqsq1klv6KO3vmtMZLM3vBN9L9byrix4iMkP7ZmSDZ
         3HHB36zHtWRDvI/RsK3fGYCyxLHWX3lPoWwgL30mC7VYF9Zyh/olMYOhfmtIS9p8RZ+s
         a7KA==
X-Forwarded-Encrypted: i=1; AJvYcCV07CRmNpjGhVi6slCppR4uhAHQtYXGLSRCU0RPen68Xh3unVEmCgJJHVcOsQn0ADK72zSy8z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEh90xaHKHd3dNXt+0X2jUVPxh168VUofX8+P2x5TiXoif2EKo
	Fxgp7MwjOkzFvB4xb5iU+K6E3EK3EXkvDPEgSL2AOHjqI8iw6CfX/wLLpUgexQ==
X-Gm-Gg: ASbGncs8T9GUOU2ii0cK342CXrDcnxkd0o+S7DHWM5XNZw3plOkaolxFKgL8P+kB6q1
	NBwfSw9EiS9o7S7ppszyYJo6KM07T7e+/4Ar/Zw2L8ZZkChJFI+TDdx/LO9rTiPiJ+XXVOnCQjk
	U33p6dYStKrewCmwLXPia5YVkp0p9cUdejnJlVoxouoa+p27xeQPoRkKnsaPgYbQLKq/s+EFKA7
	sZMyYfN2TZp7s2khl3vKHK0NZmVrdfcA/UInvFYmXYl7Prwpu1yc5bdIq+7MT1ahV0PUYD/pBur
	tMLzBfkErjJ+QB0yKWXVaxAFyMQ6iaFW
X-Google-Smtp-Source: AGHT+IG/GC+9Wg4EHK7qW88A9verjSDjN9AnXNYY3WDTI+/nRQs9bdq159c3rac7fk9Bt77tDBIoSQ==
X-Received: by 2002:a05:6402:34d2:b0:5d0:e410:468b with SMTP id 4fb4d7f45d1cf-5db7d2e3c09mr11110000a12.2.1737394565880;
        Mon, 20 Jan 2025 09:36:05 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73684dd3sm5955145a12.46.2025.01.20.09.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 09:36:05 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <gargaditya08@live.com>, Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>
CC: Orlando Chamberlain <orlandoch.dev@gmail.com>, <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Mon, 20 Jan 2025 18:36:03 +0100
Message-ID: <19484c927b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
References: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 20, 2025 5:50:56 PM Aditya Garg <gargaditya08@live.com> wrote:

> From: Aditya Garg <gargaditya08@live.com>
>
> Before 6.13, random seed to the firmware was given based on the logic
> whether the device had valid OTP or not, and such devices were found
> mainly on the T2 and Apple Silicon Macs. In 6.13, the logic was changed,
> and the device table was used for this purpose, so as to cover the special
> case of BCM43752 chip.
>
> During the transition, the device table for BCM4364 and BCM4355 Wi-Fi chips
> which had valid OTP was not modified, thus breaking Wi-Fi on these devices.
> This patch adds does the necessary changes, similar to the ones done for
> other chips.
>
> Fixes: ea11a89c3ac6 ("wifi: brcmfmac: add flag for random seed during 
> firmware download")
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)



