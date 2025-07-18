Return-Path: <stable+bounces-163396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD99B0AAC0
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141A73BC7BE
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED211B0F23;
	Fri, 18 Jul 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY7ZmU9D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACA16DEB3;
	Fri, 18 Jul 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867372; cv=none; b=GKnNF0OgIRygJ+ex4hLVwFvmrV9NdRWo55OmlA1BaG2Wz96BnLFl6zCb0uHGVYLVoSJjTKgZaHTsnj4Hb/BMnrb5uQklV9QeAmTb/aImbj3oEzF9H9Bva+X+m2jaZlhcF775Wd8T/Guk29t7Ef9ApR6sbDsgcusv1bpYTk16HJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867372; c=relaxed/simple;
	bh=zUocV2Iu/hooWg/xLrFDmecpoQnj7H08iDbfiOXKH1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lnj+RL/GQu3WrS1ZkV+mLEnCXjyJlj+ZRN+wTxv4Dz/OBDXTTnN5VTNAGeYmOZbV9XtdmN/OdVKwUY4c7x/K8Pw2TGjsnWYBWL6JqNy/QRjlrUG5OQiqjwJGoo+mfuryThCoSh7MRtktvMhnxhxG37P5QaTGcnLb6a3WlBJeiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UY7ZmU9D; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748d982e92cso1821165b3a.1;
        Fri, 18 Jul 2025 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752867371; x=1753472171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i7dfdxOwUi7/Jyy7cCnG3+Gt1jR1w3Vp0HZDygyI/NY=;
        b=UY7ZmU9Di8a3Wiit2u80zkJo/xXlES9fIsRFpx6wjbdXtAUbibYn8aZAzkyE/4ot5b
         aebnpE5DasoFOoOTDOrKNCuiS4eaY/C4MzWhdNyfy0Xwu7PWuCbRg3I+cyWv1qFaWrpO
         As/EzS4DFP7FmVxC63/RgWkhJ6nyQ/MynnkW7POU5pIBaVoxSGJnle3Il1LIHfvanNL2
         wdr4pYC7W/ag/ZqJdTY99a5SFMBc3eVqtQOeSYZsmoCVL5/3SV/gbpb4TcECx0eBjcx6
         XAipqy1upGeds/G6pMhz5AiUCuW/PTTEYeKpf4im8pjX53ChDiUNpheve6T855dVfmIw
         z4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867371; x=1753472171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7dfdxOwUi7/Jyy7cCnG3+Gt1jR1w3Vp0HZDygyI/NY=;
        b=P3TZAHVovLVN7OUV4cr0FzBGudyyKZqDrLwCbG+2KhVcqhaFzWipeV0xUqJSg5yCus
         cAHkpLNcIdUtG1UrvJcOUT2od6SuaOfkKeSTif5tBandT+J1dNZE+CMgMU6akOv4QCDg
         WhhiESe9OqE+3XWtKR9JXe8+iZxUg/EirfmIwfab9upkemQR113fTloLApd4OIaKv27w
         aFOWsCOeCmbz+C4Xr0tK4qZ24i0YLi3PvcMrAcpnZSsUj/tvCdjTI3Blen5razZQ3OIx
         YgKME3dqQ/gf5qK9ce8KwisbkApNo1UHIKOt++iN23z5XZh5nDQfTb+iWmEFvO/U2hvD
         DCxA==
X-Forwarded-Encrypted: i=1; AJvYcCWj1Bd9T4eRZPEeNfsF5e6lSg/C9G3daoF5jQ/jTQAqw1uxtAueFUsZTb3Gn2F/+q5kqXW5NCuA@vger.kernel.org, AJvYcCXl5zWZQbkcngrIham47CyZlXhUIUgpxC/6i68XioLofSoauSz5U7MRiEd5TH4QJB5MhXhWkdlgDv7sImo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVVPH1tSm8aFW1n5/Q7g3IbcWZsxs6jrHJQxX0Y9wPeJmcE5N
	nD1aBG1K4V5bivMb/6afGo93PWH1jB5hxhXOEaBsmksJS6vqjKl7EbfE
X-Gm-Gg: ASbGnctJ5Lb40X9x99elrsy3g9H9YANGeJKhwNhzw0hhm1C666AHwAGC/1LxX7nHq12
	u8C3/AksvAXv237b/Lm9r6JpwSzjFnnfhBvJzRznFa9fWL46OHvxbXPLkgcHYOhFycql8gggKfi
	tZI7hqb70ZK4AZIv8JvIJFS4go+6OIIaWgj7I9dtAOXoWFCDe6JeJXtARr7OEAgGa8aqhZLZl8k
	t+IDVe8zSodo5ucVAB0nWhDTG5oj0Hjsic+SZ0/MmQ7VUbIa/5hR4bBSx5ZRIRpXo9spxjiol2S
	H1thCHCYq5scw7orcqtA1rEICdfHxuBu4bh0sGHsE7Pwnr8Oxrtcl4E7jDUFNMfQTFc7cjM62m2
	C63sjVLDzRdRSckuHJ6zGGjIj6lML/us1gKWutfrUvEE98i21qNWDM98XWkB3LQo97gMJTAFFmj
	sdvvXsew==
X-Google-Smtp-Source: AGHT+IEFt5JFRpw2SaWW0SAOjjSSqwKJkWZzGcnDb4+fRvxZJQVCkuPc0pKJg628BJ+N6RgSZb4I5w==
X-Received: by 2002:a05:6a21:4598:b0:232:63d7:2738 with SMTP id adf61e73a8af0-237d5f292efmr20202057637.9.1752867370655;
        Fri, 18 Jul 2025 12:36:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe62d9fsm1629328a12.1.2025.07.18.12.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 12:36:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9aae2c65-47e6-4fad-8b8e-d9cc89d69602@roeck-us.net>
Date: Fri, 18 Jul 2025 12:36:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/78] 5.15.189-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250715163547.992191430@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250715163547.992191430@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 09:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 16:35:29 +0000.
> Anything received after that time might be too late.
> 

arm:allmodconfig builds have been failing since v5.15.186.


Building arm:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/meson/meson_vclk.c:399:17: error: this decimal constant is unsigned only in ISO C90 [-Werror]

and other similar errors. This is with gcc 12.4.0. To reduce testing noise
I'll stop testing this configuration for v5.15.y.

Guenter


