Return-Path: <stable+bounces-92945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01559C7B46
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B52287EE8
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2D2036EE;
	Wed, 13 Nov 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eQ3qEljz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35315ADA4;
	Wed, 13 Nov 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522906; cv=none; b=gKruqqVjBdv2/meQKe+DsAu2uiVgHwRuUMIJUWOUF9XXh8VwqPlhahx5XZ0XOdAMLAuKBZgkxgxqivChXW91soasxXxDaMrMS3gpFke+XIbwuO/KHIq4AoG5YEXkr4IMwRoTJ2IekcjR7HBQpk3dR2EafrhBrTUpId3trdmeYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522906; c=relaxed/simple;
	bh=51y6F403UODXm3whUG/pdVxPEOiBvrwCx/j54xJhKgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdfjZe4tZenWpZgedjtvsgaAmZkMVE19f2OmFvV1Tsvcc9Ct/2VwOJv853dVEUZsBjyv1fXX3sdnEJY25KWDd3Q35etWEW5dQUTPyj4OibQbHb0yBWxWHNxdlA5sGMKqHn3vrpamTwSH1jFzc00V5s6WGKsg3AO51nyqgz2yVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eQ3qEljz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-432d86a3085so5202415e9.2;
        Wed, 13 Nov 2024 10:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731522903; x=1732127703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYIrf86hdksI77/Sc9tKNsGUwcT5OsY2/UWt/XQJeXc=;
        b=eQ3qEljzbq9bOcZnIf0vGlEoIyWGndY8wrCmi2j4uhiEChFNWOWWU30fzt7PH0qhlT
         XtMSvtKW61FobqxcNhf0IQmJAsir8bM7pc4W3yI+as1kjudjHCbzoqcKzsEsCeznS4vv
         JNs0CexiJ1vffAhhhVowPfKB+yT6TJUeIoLVEjkQzVt6OE2bU0ljvm9mYmNLIn/22N/2
         m/gt5MrzeaKjYE5sB8p9wXkiDU2wyLDFhUcAjuVpmyJwsxRT7eiqu9km6957m7MkMjmk
         wWS9KO6RnzH3EzUfQMlWf3rrFepl1xeQJQgKwVV3GfuMMrBFbWu4Lk00sGUHfkCd1+qu
         396w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522903; x=1732127703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYIrf86hdksI77/Sc9tKNsGUwcT5OsY2/UWt/XQJeXc=;
        b=QpVuQbP9zH5e0aGp8GEkZZR4sw/QJD2O2t/eiq5ZqnmFNXV0IC+lsqrxAQALe1XlVm
         XCLCbJbrs0T4xZwKIpT+6R59nrgZuE0QaB2lh5u53/+/nZcz6iJeLasIsHFXt2V23G+f
         gC4MGOue7ifb2NrdhzMQR19dLM9YHuFYbj6UiBjrCKTARZ6qlMaezHhH61k3wNRiM/nL
         G3fCM0fwDFoZEgFlIufxT3eT+oMGqZsvl/v5lpXVqAhSUmCDldC7gZJzzjVoGkhjg//v
         iS+T7+t5yuGBP7867IYflEYM6XBd0Am1Fqh2q1YIzoeuEbi8aLgdrLxeX1OqWmXM+Kx0
         ylVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCeAVCkZ5Xpzla9cHwXwpa/IlgEfUWzFwlH16U60o8CC8vohjuF/rYff+/69IQbJPAY7xHYqq7xTxEb9I=@vger.kernel.org, AJvYcCVXRl8sVdDUJQ0gtz6WA5fMLctg+9HbxqhbEB84ZuJbkSl1RseK21r8E+dzWHPmVL9zqUXLzacE@vger.kernel.org
X-Gm-Message-State: AOJu0YyYApQNcDw4gz8BXwOs2O6eSMnt56Wz/nH3MlwCLaTZdIgxJH3H
	i/YuZphSrN2rrMDHr7JUcYWbPAWU+0F/Kv5Ym/v/dfqtGvvUOLY=
X-Google-Smtp-Source: AGHT+IEeO4H3EiQmliZJ4Ro7Hz8QAOIdCTKTPH4cJ66FtGc576wuHJP+9pnAHNheyygcVbO6WfXt8w==
X-Received: by 2002:a5d:6483:0:b0:37d:5364:d738 with SMTP id ffacd0b85a97d-381f18813cdmr17524979f8f.45.1731522902692;
        Wed, 13 Nov 2024 10:35:02 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4ca6.dip0.t-ipconnect.de. [91.43.76.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05f89sm18952980f8f.98.2024.11.13.10.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:35:02 -0800 (PST)
Message-ID: <e7260f30-ee8c-45ac-b0d9-55f2f260989f@googlemail.com>
Date: Wed, 13 Nov 2024 19:35:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/98] 6.1.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101844.263449965@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.11.2024 um 11:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.117 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

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

