Return-Path: <stable+bounces-131861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56568A81853
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469CF1BA6434
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C0255222;
	Tue,  8 Apr 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k1RRUXIn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7D21129A;
	Tue,  8 Apr 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150504; cv=none; b=ZkDNCxLnfgqlkmkr3zg74EvEb4wFDfXL/2emcyLd7xAr2L0puv7lYGMIpQla/4llz1IrIlfvjqEp/sFbHj4UWYuGaVvVVGVRxqhrn4Iw09zFwIr5vromTbimsik6h65s+PxinBlkCiTPX42P6jvaoLVAiWaNO1iCnllWfu0L4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150504; c=relaxed/simple;
	bh=yNPMLWXMXg/oHCO7t+Q51JUSk9n9yr8NF3EteyZegt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3xbc+JB9GdWBlNXiqj6HtxVtB0m+tlSmYNKitQy/0zoU3Rdoz/3ShrxsFNwoi80P7M/23/AmX98oyDD2se/uvft9/yh4RBGucyiwyvJc8i+pLaMgw+ekCmltsO8QKqz2LZji/2+ZCOTTt3vg0jYS2QBkTZZfS+eGzX4pXIlsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k1RRUXIn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edb40f357so34610245e9.0;
        Tue, 08 Apr 2025 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744150501; x=1744755301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRS1OGyHhHpYmNn9iGJIxuZ7ViF3cufNEb6RfYV7hCI=;
        b=k1RRUXIn4LqWipP5Kom6DrWFXqH6ruQn0D60JCBGFB9wzdRplhS3KLhgg/hG2hIoDh
         YCIwQCxJSvT/uUavkQYbxrdReYzf41wD8l4SIWnzvywl7tmeneg/R0AI2xzqrJ0bh6sM
         KVwOT9iqEPiVXjzXsP63v5sSEs8j9IhmysRfwAOiWKiVYFr85FC3L2VPr2UeazNlFNeL
         g1rGvbK11lvFLvIU9yfytDUzv4BrrUxacSotKBP/DxeI8/luUtJ+YCPo0uH/SkCqkLYc
         HhwtdGcyVVvyWwgVgkXkUpUyXfgNdNeiQzoM4xYlK4vEwpXTMQ+1irGbyQtvINjT+u6P
         hUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744150501; x=1744755301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRS1OGyHhHpYmNn9iGJIxuZ7ViF3cufNEb6RfYV7hCI=;
        b=EuwBgwdwKee5GMI+GaoWtlWjSdcHaMjhPSu5sli0TaC1SgpdE7ikKuoaQgaCMYBXdN
         JAEuBvn/Bw9nANdEThiVgcff5+kLeoTsuleazhfLYPNp3CFJ/smHWx/axKvnwO7dihd4
         E5zn2GRRphZLrtI3IjgXP1vP4hREr/HZLriSWfdYmDcbeclG8fX74RRUdKkHtaguTUt2
         UqvjsSYiFzqLNTr6pZy+Hf1xqHkSeAbbvgJ7+HP9Ow5MubHiQoLj4uOnQgIMUk3du5a1
         iM7zVaRD2PBEPjnPlRp4dCWtFHiYUk3L73lgnM7MXitn4lxU7mWjVJ0pACs7kJYB2Ibx
         LpLA==
X-Forwarded-Encrypted: i=1; AJvYcCU8iue8g9xAhZOW4nIN2e4ngtKjNwAvvwNklsL30/ivIw7Z7DiYC3EIJb3+vnC0flXvW8GwN/sM@vger.kernel.org, AJvYcCWE1FxGxD9DcoHgG/Jgtjma/GBX2QqiGopzX6K0iyKjG5wd3N6j1uhlCELDorS2+n4vlU/RjsIuZsXVePw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ1hdPTxMHnvslH8CcAnLHXfmgH1/3ktNclf4bJIpbV4j2VIQ
	LuXPh7xNVuD5k9IIk/6bJlYXI8KBcoAhVmceG697uTFgLIEcpNk=
X-Gm-Gg: ASbGncvuLiTQIZqKeLP49XlLfuqdUfuJRGLL+0EUg2He/GGMJCgXZzqBfwX2mnUTvzo
	NC0cuzC5giz1bR7Te0pcK4Wwkx2XoaDvy2DMch76X+YZ341KXI6eJ//9isfWt+DPNZmQNm1ATkg
	6XS9uEhTITel2frs/e7O/ZCDs83xPq+8hhhcKL9SlCzRsBN2fXgSPA567n6qLR4vWBLUS6uubpZ
	HN5pK86R+VJ6na3fjyZKT/M5nMlfPSY9MCis+Vz2KbvbzlZ+Gjnig7mek9BG1BxesYyAxpVcVXX
	veOVRbP7ppm+jPKqWz/WkpUUPbp5MrkZFLHhk0P5grMRk6AnIb52K/e60BFbYZ9RnzqBG9WdfoE
	FVUnsQikIlBQ9mXN4EBDfKQ==
X-Google-Smtp-Source: AGHT+IGiGB6OFuUz7sIb4TOmtR7pqHQogU2eZskpSuMvx8vOED/K8195tN+6oJZzL9Xyd5/yh6XqzA==
X-Received: by 2002:a5d:584b:0:b0:39c:1258:2dca with SMTP id ffacd0b85a97d-39d87ce27dfmr564354f8f.59.1744150500685;
        Tue, 08 Apr 2025 15:15:00 -0700 (PDT)
Received: from [192.168.1.3] (p5b057de8.dip0.t-ipconnect.de. [91.5.125.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34ae0c5sm172129695e9.15.2025.04.08.15.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:14:59 -0700 (PDT)
Message-ID: <e76b8661-7825-4497-97fd-cd673a242459@googlemail.com>
Date: Wed, 9 Apr 2025 00:14:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/204] 6.1.134-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104820.266892317@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.2025 um 12:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 204 patches in this series, all will be posted as a response
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

