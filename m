Return-Path: <stable+bounces-67758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC10952C0B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364151F24753
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CCF1BE874;
	Thu, 15 Aug 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eefXyQUH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B419CCED
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713707; cv=none; b=qy7tp5J5IcP4bKkBOh8EDbvxaTZt14k44azDSa/DVt8+OVzBqK2D7yHkYRTp7O9k7YWO/3eX4FXRbohfkASJNYYM15Vt6G73jlOADziAkdr3svIYasTob0GmNDvoT2V7dclgTiZ0nk3q5OtXom2w3DNEp4JdSC0nz39Jqe6xbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713707; c=relaxed/simple;
	bh=nats+0AUfpeNoegI+vGDrbNjh5mZV5ISbmLZ1Eq+z7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+qA0f6Zh5QYr4HbrMm4NsmpmWXmiSWzmQSbZpIliDF9nE8pp+qRxF9rLxr7NalwLHpxhapSFus1OCEgTKx8WLTgI/A1TLJ4k2wAsJZKFmM89nasBG6qJhMq9R3cujQu8WO2NXh69lSGpJK2QcY34aLbRlMmT4p4vaGsjFfU16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eefXyQUH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so168463a12.0
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723713704; x=1724318504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XC00O8mHJaP2PFpA++QvM0IPgaX3SHsT829pcUcGZE=;
        b=eefXyQUHbQknGOvrJAdZhu3gBvs1v8WPobs/m0iJ/GUw998otZQu5hbb1ZMws4Zwg9
         0NFUrWvVnsM3ru7IhSFsQgfU+Ab6DLUznaMjuWVQ5IyPY/wfBJRf3vwopG1mqoFaB3Qh
         VR8S6b0T/7oeV33F4JNkOnBVNE0gqIE6xpIDf17nMhx1Zl6m0Xoxk4JC/az566hn7egu
         PnSwuUVSQAFObiLjKRrRQIgb61/Ik8V9lwIehoIlHoUxIgp3JbEkNxsXHPpNspUXwmAz
         oEfJqoY1bdvsFkrQv6OR1K6MEFj9/+aiv0otEkkJv3+1JdXrKO/sGxNpMIU1jMOeDG/j
         /itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713704; x=1724318504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XC00O8mHJaP2PFpA++QvM0IPgaX3SHsT829pcUcGZE=;
        b=hS10RMEj/yWWa6jVLAwTsTKPuH4ISgL2zczBjiMi+arzfBdIJ8OCbSwV7sYMAgYWvD
         pFvi60j07vrsosk6J18P5ZedpcFJkYU18J0MwJjZxLasYTcNTlLHxCmkdcee5q4dAde2
         4Q8g1yVkPJxNnUbGe+2xUXLG8teI9nP61CZBDa3vSDptx5W0oUelvBXWpjzcPKc0CfZD
         aJ3tsbLcVZBi3tHj9513K/6E10odXT4qrfesBsifLR+mU49SGrZtd/VxeoWoJzwmzy02
         aT0JY1vkRTirGZECSbjwS0wdm/2Tqt/X3adGMZQBxSFanJmtNkiJsfvuzlJZk19VbuOj
         EdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgd/nk17CZ6N1XYdmruDLA8dnSKI97i5Wk+hCaC53CynjBzM5oB82Lo5TWQClVws2nv1OkQGJNmHzvfHK1RoTKd5ke/fTR
X-Gm-Message-State: AOJu0YylBYrZA3W06o7F5nltEJGGcrvlU94JTya7Y/Z1jl6odYi0iDbL
	+V+mDf7mDmDTh49uPlkKXHaaCZQRPltqvkuxJwAu9TZgUVP9zwWEzGKN9sd8HE8=
X-Google-Smtp-Source: AGHT+IHekcCMNCw17uEnoC/sPv658hIQ1jXVkSlnpEtHHcLImpGFQ1SQ55ptRhDzyDLAxMUtve5/pQ==
X-Received: by 2002:a05:6402:268f:b0:5b8:5851:66cd with SMTP id 4fb4d7f45d1cf-5bea1c6ab89mr3531550a12.2.1723713703685;
        Thu, 15 Aug 2024 02:21:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081cf5sm635471a12.90.2024.08.15.02.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 02:21:43 -0700 (PDT)
Message-ID: <8289dff0-2415-4538-8c86-1c4919458023@linaro.org>
Date: Thu, 15 Aug 2024 11:21:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] MIPS misc patches
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 stable@vger.kernel.org
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/6/24 15:11, Jiaxun Yang wrote:
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - v1 was sent in mistake, b4 messed up with QEMU again
> - Link to v1: https://lore.kernel.org/r/20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com
> 
> ---
> Jiaxun Yang (3):
>        hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
>        hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection

Patches 1 & 2 queued,

>        linux-user/mips64: Use MIPS64R2-generic as default CPU type

patch 3 superseded by
https://lore.kernel.org/qemu-devel/20240814133928.6746-4-philmd@linaro.org/

Thanks.

