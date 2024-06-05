Return-Path: <stable+bounces-48232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CF68FD159
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17A21F241BA
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495573A8C0;
	Wed,  5 Jun 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkoEiGH0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5822AF16
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599871; cv=none; b=ehDR6+Z8EACHQancy39VNDLgIpA5TYTFFT45HOMs0yojEiORbCuN+zzAwuUoubpsjl8w9NiHhaBdtNJnplz8WKFnbmX/x2REhxzXBXNBahdQeU49C5PJf+JijguSf7L5yZZF8jPbKxxcckwr7pM+0uPpTCVYWXdieuIkKpIvM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599871; c=relaxed/simple;
	bh=0i4ZIFKowiVLzbZGmNNJx1BYPXZWnjns88Nl9iqdTNQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mhAX/FfXBNxmAYI59EvZKgsN2dGKQHtVbxkpQY90svtUsTLCJfcu475f/JJYnF3jnCSTXWmZRiT2JrRRyrQULBq7gVKIrkwxR1cAUPao2KRHANoURpGUrMcGGXrfNqpnYDc7XDvuAvYEJMJUDkcot2RctkRbX/C2p2KJ6AaZWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkoEiGH0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a2529554eso874904a12.0
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717599868; x=1718204668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4TdhoV4OgLoUtr0nlLz/pI23UTLQeRjQ/hx+7uDjwQ=;
        b=hkoEiGH0gMse8l0Qk5zekFpndUbnHxSyTJEVzazawBghQpMGk2F8TZfNiU95hUsrN4
         OZBsGg7LhlB/uhrI8LUAr9hNas/L79QEIRzk2xQTAl9WyzZznGjADLcIexy2S/ZYoGhI
         wcuMSTm8C7A7KLgyoyY6xFPgZPryPKdl08pYhn+JeKq7RDyfaqk0CVsghgfb0zb4ByLx
         nwIc29ZnEtgKo3diDJ617VIc58c9ddT7/BRCtv6gv0C3ii1OUDG8rHdsZJ+psMO5+LBc
         8MjQc2NVgK8rqp2dNaQIS0GpEd7c+7UPGTQhZQkSMneqPgEPlVsAYpclLwCMewWuGF1h
         JsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717599868; x=1718204668;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4TdhoV4OgLoUtr0nlLz/pI23UTLQeRjQ/hx+7uDjwQ=;
        b=USR39UNgFjOu9/do0wQpg0wQTnPSWobS72+t8OcvvlAwNSFuYpkYWO45W2vRR3fMhi
         fzvOzks03QnS62tabkIY7o+Unh4bB7LMayG1iuPJEyzQijv7QU8GIbCRw0g32UUWjOQ9
         ww+Z16RBqXukrzU64lYwCvh43kX3NPK1iJdW7zFrd65pQu+F1MVIEK/NiPUJeKBXJ9Xw
         +yvmnBj+SOkEUTnYN/C4QX2OL92nuC1aSd/qr1K5jqy91KWvflq07prHlTYKOtd1Vk2F
         HEVRYZJXox8UZQz6ZNKe5qtYKL0vXNeizuFGuyr57pgNbbMqXnLmlbhp90k703vKsCvF
         9Wuw==
X-Gm-Message-State: AOJu0YwtvbXVl1at+2kNjnCNQY6DcQNeJgnKK/BprqaDdiqoLeXkUTKZ
	1C2AlubS+fNQfMs+8Zs3Ifc/5bpULF8I6j43BtgG6A/E+id2ctwlxiAqXAxr
X-Google-Smtp-Source: AGHT+IEPo4zGRSJoT7JuU5HC57LwQg+Ku7nXCGEHrwf/UlcTM1cBrlOk12Em/brZEWY40VeJQnAauA==
X-Received: by 2002:a50:9983:0:b0:57a:4c22:b7 with SMTP id 4fb4d7f45d1cf-57a8b674419mr1918867a12.1.1717599867464;
        Wed, 05 Jun 2024 08:04:27 -0700 (PDT)
Received: from [192.168.1.3] ([91.86.182.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4d468a4fsm7895009a12.79.2024.06.05.08.04.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 08:04:26 -0700 (PDT)
Message-ID: <7fcbb3c6-ae1a-460d-be2b-e2eca88151c9@gmail.com>
Date: Wed, 5 Jun 2024 17:04:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.6 18/18] null_blk: Do not allow runt zone with
 zone capacity smaller then zone size
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
To: stable@vger.kernel.org
References: <20240605120409.2967044-1-sashal@kernel.org>
 <20240605120409.2967044-18-sashal@kernel.org>
 <aef09490-f8bd-46e9-abbf-a4cc9acc49aa@gmail.com>
Content-Language: fr-FR
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <aef09490-f8bd-46e9-abbf-a4cc9acc49aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> 
> Is not 6.8 supposed to be end-of-life ?
> 
> François Valenduc
Sorry, I replied to the wrong message. But there is also an autosel 
series for 6.8 posted today. So is 6.8 really end-of-life ?

François Valenduc

