Return-Path: <stable+bounces-67448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D4195021D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621222886D6
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FCF16DEB2;
	Tue, 13 Aug 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P8zKUR1L"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B309189F30;
	Tue, 13 Aug 2024 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543784; cv=none; b=VBcgBpMbQRCcRqfA6zWiF64xZwq+WuomV95kiTQ9NNy+9xUrmfYGDHs0gXie5Fw04E+Y2BYHrXAjQLK/Z9DB/cIt/LCmvqat4aGoGAnvsbFbQRDdxey4++MAo1CzIQ7G21xKqqdLh33rRUcXeJWEVv/6s2XAMJk+Qrfy18OIKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543784; c=relaxed/simple;
	bh=cmu6cP6fL/3husJRB14FqGnNMhdCIb/BhtgJUDPFZlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3EgNTnuHSiN5auAxNrcGdMk8w9nYewtYSGmR7bvZHkiA2Xzg+ShrOcoSgwcU5sTrAIkZ7U2GtlhiegcFwUwUZq74nDN99oOi6ZqGBEFJo+5PnDS69WRphpckGj2hPlAtAVR5cEr65YZo8tZs2WdOjuAGlDMKVd3zIr0ZnDsaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P8zKUR1L; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3686b285969so2975823f8f.0;
        Tue, 13 Aug 2024 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723543781; x=1724148581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PquCqhSeNls1CSskkoL5zD2TuWsNdcMF+oenJmTY7EA=;
        b=P8zKUR1LddyqmoNO6h1ZBYkeeKi2CwPOekTMfoNmx/+jyH8/l3Fn6wEopzX8syH2Jb
         po2P5JJ1LN19mw6WRWEo6KZ4FT4xya9ho9d/ZOuCbMo4GPIEsjuOALVs4hZec8yp2Hjx
         cubOAUqOxOCJDioKzoJCX4Mm1H8I8Cb1fBCMLqG/fnr28I9SO65eX8tv62i6dle/+07l
         fBxCubOcSdKBToGNBt9IFH2lU+AzpVH1iwWxOCFeXwNwheIMSswU3+zNUdhNYNIjMAzH
         YeFt4kYpI/nlR/l5lcC4KwcUEI3Fuh7eB0dsF3ZVJXHmXtRP8s6hnAE4EO4qgJjJxRtu
         UBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543781; x=1724148581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PquCqhSeNls1CSskkoL5zD2TuWsNdcMF+oenJmTY7EA=;
        b=WhBnbDHCIkMlC6Kv5Gy+RJ8LaAlUQgs03psi9q5Dhlt7rupIoJ+GAgpDW3vcAFP93d
         Kg5klkJR3w4P7+0m0xVFMPmRdTehFgEPBztcfDGcY74HG7JYnPvYWk2ycBV8eWGyIPMz
         6S45ilShB32VhOCnmDKs2+ANAnII7lm6s06IZxJJ3XnR4KjoDeL7JD3hqpa47j69NPo1
         5Nc2kReZ7b0tqlZsku3EicIDOzOfCGv/h7zn47tJqjbzRM41HWeXsaDisWSy8uKQYHIP
         NGeyUxSKmOemTMFz/5nuPC0k6NYMmz9Vijxdcu+MQSf6qFP0+6G1V7rrmj1WaSgXDYTf
         h+ug==
X-Forwarded-Encrypted: i=1; AJvYcCVwodIdG1L0qijjHINbKYWHbiAGQzWmJc+yU2ymUgouNGjO3Hs+SUiCmpVCBjrSco0v7IZmG9WbWAiaAllcPsTRSD8U+UtN9eE72nStJT6qzfNQzXY71I0q0dByxeLGswur+iSc
X-Gm-Message-State: AOJu0Yz+qoi7L7l9/tg+LMGgQv2newI+8NNpP7OeX+Ws9mJM7JAVGFd+
	doziXcOqEBThD90cWfIEgy2T4cezSH+iVRd55KrNC76fC7xbib8=
X-Google-Smtp-Source: AGHT+IFpQAx5ayMlEwbx/OMjBFzh+DZbiGWwxkB5cXYBIgSDq0DF7hj0eOZeGCY03/PhkfcwYtKnTg==
X-Received: by 2002:a5d:664a:0:b0:367:9516:ffb4 with SMTP id ffacd0b85a97d-3716cceee06mr1846715f8f.19.1723543781097;
        Tue, 13 Aug 2024 03:09:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac34a.dip0.t-ipconnect.de. [91.42.195.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bce0sm9817816f8f.3.2024.08.13.03.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:09:40 -0700 (PDT)
Message-ID: <c281acfa-9313-4b20-9fae-f418cc32cc48@googlemail.com>
Date: Tue, 13 Aug 2024 12:09:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240812160132.135168257@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2024 um 18:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
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

