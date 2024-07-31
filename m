Return-Path: <stable+bounces-64796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A45943513
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 19:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB88B281D96
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006D33CFC;
	Wed, 31 Jul 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F3OeRkMG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FB0200CD;
	Wed, 31 Jul 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447609; cv=none; b=BqiEbP27bIVFcavnrYmmb5wU/fPmQOh840jju4ig2tWiFf5ojCTrQmxruXWoQ+X1aCvNl3vvseLmBY6u3TLzuRYLsxk+6XWPC8XAP/mqQVn7eFJ01qvc9rpq2TfLsijejUj+JkACHMskDKP370BMyqSf+NdnpjJRTlNqDckMx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447609; c=relaxed/simple;
	bh=qSbr8OvtWym6DEXzgOAzgjMAQzTFcZiG6JjJfcid5+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZU4SHCLH1SYqDImw0dsEpvcrwNQVKD6IAq/rfZEMvx/YWsn4nmVMvo05Y2T/DJi6fm7meFsII76UPref3BQcn0HeZG5zXWeWmRbfLSR/DWrxLDON4jYn69Ggq+wENsmEcMThBVIYfQFVmFRG4Hb5cZwRCYRxQ1yPeC619njeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=F3OeRkMG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281faefea9so27707085e9.2;
        Wed, 31 Jul 2024 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722447606; x=1723052406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqdkQ35fC7p3H1I0RUbNW3ITakHFi6YBp9Jz0zA9POc=;
        b=F3OeRkMGbIHdS2JEyVN3Gd9AVzd67tJttoaI5Wrv9sJoZty2128P3ogNhL/b0DYzeK
         jX4M4ZQnrkeblAxWr/OIyWjXTUqUQDFHWvnknLa/vBWXySWg39nNprWPGG2maacO6hxm
         2ty3icyDZQpK0IPY7oH6kBZ8zsZye0XI0lwm3ANbWpzBD6wFtNZmNODluh3QygsXJzpa
         4VO0Xz7lZsTu4QjpJUzhw1OsffpseuIlaLj6QwEiB9Tr2ftWzn4LFGqJkkB8KNwKxjB4
         YXJ+KIKCQtBV1QlzFv8wR48drRILWnHuKGfAOTuYM/jIkTdw3qRTpcs/tbpRXaMTDjEd
         kACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447606; x=1723052406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqdkQ35fC7p3H1I0RUbNW3ITakHFi6YBp9Jz0zA9POc=;
        b=EB3xei5P+j5idZPi0kChFQvYQHcTDS+UmhUxsWQBk+icZkeGPyKMrmVkS3wapC7Luh
         UInvW4haTebE4qcjsG08Cx4fM01M+/U9L4nF0TmwIm60pdyXDb1/H4A+eXVOrErGLs5C
         cD4A1N/Oj3IYjteDu9b4krzMRqZ66sBehw12/YueGTD3MzUziEENl5TKV9wwMuN1jxyv
         37Xf0/vwpdpWyZUpDaAKXHwSey//I/GA6aVK3JpPJPIb97rj8sODbZHAChkaUoVi50Rc
         8gSE+DNE/jieomxlgxuovqAXR2YRG2F10ZGvT0ctDMSQQyD73pURWaDG+DJSNpPvAs5L
         up+g==
X-Forwarded-Encrypted: i=1; AJvYcCWgMF5GVEJ0biD0hpgklLXxOZIPBYYg83E29YLrvte9jGAyqzeLPpm09f3fsSq/JmNQ+NvHCHcv3o9IzqUiLwnApaltf+YwvhGmsfw36rb0M4KcAbXCusjDAiP98+idEcY4zRWa
X-Gm-Message-State: AOJu0YyhntKLchGrmfQBd7MNRJy0wOyFHPIwCL77OZHYx+2NDkEgraBf
	vYD/TcH0zK5A3hsnbWuYukpIPC/Y9ljytQCcahyYPp2AxTm3acQ=
X-Google-Smtp-Source: AGHT+IGROOi3Jog7R7laQl63oVgL7DF1626ttLOvpuvHk1Fc6jzdWGkszuT+TKFYYdIs0lz92qpxQA==
X-Received: by 2002:a05:600c:4743:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-428b01fa085mr1295965e9.22.1722447606151;
        Wed, 31 Jul 2024 10:40:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b057724.dip0.t-ipconnect.de. [91.5.119.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d464sm29181655e9.42.2024.07.31.10.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:40:05 -0700 (PDT)
Message-ID: <b04044e0-d62c-494e-903a-331793163eb2@googlemail.com>
Date: Wed, 31 Jul 2024 19:40:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240730151639.792277039@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2024 um 17:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

