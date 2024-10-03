Return-Path: <stable+bounces-80634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2898EC55
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 11:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD38286B99
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEA1474A2;
	Thu,  3 Oct 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+e2eYVV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23C3AC2B
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948097; cv=none; b=JiSnixTkeOrfnNGRdKwH/SIkL7QUl0MFha3qglCY3HH+B8wIrbjVGMZFsPVbXU6TlGN0sVdCUoub7vwlGReNaMlAUc7qAwTeggNNVEUgqQHZlKO18YBf80ER/ufGgiiQx3dhEw++pTTbfeIxW9qBYtaTrv1UNW9t9IQ97lB0uIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948097; c=relaxed/simple;
	bh=8PNWb8f5FF5xUid5MxaKNsCFti1xv+NLEa0wWHyNbBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTZpWXa2cyYzQhuam4qGvRuZXCwLftuUvWQpoLJJHeHlOJCAuwzNmEBHavhKZsbedMJ5kU1W8KlqBiNwgBUSPfKV5exXFznm7a9sAV9dVkDS7e3mhx6U4sKhY4pHR3dYDefYswJmK7GPgo8LPdeLGR/63wr01ImoOD3wEY4p9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+e2eYVV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727948094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMpAb3wF74PmmdRNbw2eEeLnsh8xWYLhJFUtS51lww=;
	b=A+e2eYVVUacu50MGbFR8nGA+uCdA6zdKBZHwxakRgE2Sl2kstmPD5iu+dLNo6MTB8I4pvP
	cdlhQuUHSg7mVXSK//3ug47osyVt1Z9gAegh0qQby7Rp1jPs3KwkucLiG+va5Tf342dGLu
	jEpcYCxuzmc6GF6tQPfygAZSQRz+EzQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-asjpbj6fPqG5cj6UrvkBRA-1; Thu, 03 Oct 2024 05:34:53 -0400
X-MC-Unique: asjpbj6fPqG5cj6UrvkBRA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb808e9fcso3969055e9.0
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 02:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727948092; x=1728552892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXMpAb3wF74PmmdRNbw2eEeLnsh8xWYLhJFUtS51lww=;
        b=AlIRHFrf6T8Weq7nvgPS73I4n174rsXlr24dpSnY7lKJdwSsMUoyUOYx4m7NPxfVU8
         e8rQxKGeEB0tX6lDCIznvTBRYvNpGi6m/RvFDdDrmg4gcITbXsOWp8deNlzELuhooI1S
         p8q0U7dIqa6mkuYNCk9TjnnvMi5rjHh3z3tUQFIR+gbXXxZ5M+vdNh25TQAwfo6BCD8Y
         JHw4ZiJ66tmf+QA6FJuUECBWaIEgzyMV41ipP/4jMwTYCcKlKmLh6JmcMwUTCtPCKuq3
         qmeW+hG8AQb3+pYUoG+6BwjzxoQoPCpQjhjZ5I5EEdE79/U0odHVkZWt3Rk5syJYK8D8
         awDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaAX1TE1iF/UBdF4r+MT99diEPL4Z+PSrV45oQ1A6jh2xPa/+PyCyrmWxGiQf8Zl5d0rv7+Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PGLeEHb4vVpyllZFvmUdMCp50NKG5SHB1RkNocsjNfvZ1XZR
	gErFTh9XF0iI5u7kN8ExIckrYCddcmPS1L7fMDVZPynBrCqnwhYbmKEyg2tfSv64WEhWKntlok5
	Is8NwlZpBJi1EBlc5nJE88YDYu7V/f1HZskgHh8EJQwr0Wuw2XENkXg==
X-Received: by 2002:a05:600c:3510:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42f777bfa85mr41752515e9.12.1727948092112;
        Thu, 03 Oct 2024 02:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBowI5zhEycK9k+WgMuHJJtTO0OTPJ5Pur5BI9oIv9qrWES3L7uxAbpAFQkDhtkECemtMfmQ==
X-Received: by 2002:a05:600c:3510:b0:426:6ed5:d682 with SMTP id 5b1f17b1804b1-42f777bfa85mr41752385e9.12.1727948091654;
        Thu, 03 Oct 2024 02:34:51 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d3edsm39844885e9.7.2024.10.03.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:34:51 -0700 (PDT)
Message-ID: <a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
Date: Thu, 3 Oct 2024 11:34:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 edumazet@google.com, kuba@kernel.org, stephen@networkplumber.org,
 davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 22:54, Haiyang Zhang wrote:
> The existing code moves VF to the same namespace as the synthetic device
> during netvsc_register_vf(). But, if the synthetic device is moved to a
> new namespace after the VF registration, the VF won't be moved together.
> 
> To make the behavior more consistent, add a namespace check to netvsc_open(),
> and move the VF if it is not in the same namespace.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

This looks strange to me. Skimming over the code it looks like that with 
VF you really don't mean a Virtual Function...

Looking at the blamed commit, it looks like that having both the 
synthetic and the "VF" device in different namespaces is an intended 
use-case. This change would make such scenario more difficult and could 
possibly break existing use-cases.

Why do you think it will be more consistent? If the user moved the 
synthetic device in another netns, possibly/likely the user intended to 
keep both devices separated.

Thanks,

Paolo


