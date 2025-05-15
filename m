Return-Path: <stable+bounces-144557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE77AB91D0
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 23:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8571B62731
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 21:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4B1228CBE;
	Thu, 15 May 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WzRM+9Xc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744B1922C4;
	Thu, 15 May 2025 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747345035; cv=none; b=AyXqKoFFPwPEofdF8C/1Q3FWLAJRJd18Wtso+I3KaS0YOj68ZhALbczvymLbW+6fpdPu1hbQOHonQlJvMuG4of+1Sk1A/oLLHCnDo1mLWnz24ntxpE2V+lGRk4CVSFMrbMZEbaxk+VQgv3MzRLV2zLipaXjAFODZLHhZXathVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747345035; c=relaxed/simple;
	bh=6uepYIsSs6iVLsyaTwSMa1emoHWojyYAxnIzLLnYpno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyKFZQgp5p51xz4GKGUvJCrc5LV8v9cEd8gGnSIyWbTsvWgVBomaWfX4ltFA3Yd1BM/v7WywHQDaILZSMGoCBOqKidSxGUURFrvf+31rdVjjxHyMc+JM8Yeu/D9QwRzSIWwgCO3ZG6QZgazglmLbc7rGVcYVucQIA65F9g3cYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WzRM+9Xc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so9465135e9.0;
        Thu, 15 May 2025 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747345032; x=1747949832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmT5q5U5QpFLoxGl0O1NThy+g8rCMO4busNalB/ZFBI=;
        b=WzRM+9XcX558vNJh0z5vjsVYOy+QwHMyp8yRm0wOkkCApOIm3orbYAgVd2+rRSv+0L
         IUdzefJlEomWpZOQqUiFr2b97+i3CS03KzNkbaygydGzx6JdlNeYO0j+gkI85kwWkXWc
         Z/czDtazfXNbJEkYrZd6Xitn2kxZHF5RwdrBeSo058ENTLc6LCRi0GjDJymgfvT77hYV
         27WdADBW4liBzPH+BuGvxt9PbUngVnnBLjZQe0F4fLSm5pvMZN5JFtU/HvIzII7jlJFC
         7r+SRRyD6jCSv/ZWO2I/Cgh+eyKhYvARMLxpCHroaB682LP9fjCG/PIuI6BQK4SK4olp
         RkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747345032; x=1747949832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmT5q5U5QpFLoxGl0O1NThy+g8rCMO4busNalB/ZFBI=;
        b=vt4oCUQfYgk1oWa+kn6IYwnkSLVrFxLDUJOABsj260G3kTiJVMiiyvpetHk+0AJIFo
         nU4VL91nbwxmlcRBysr0Glur6CCNJMqT9iTlPgtTyDO0b+o5cRCgHpT4VTL8VFHpIsgQ
         I8LfiscZ/KiRdSnoLAeWv0EZPH2XVaJHNFEw5of3wViw2Q1gGAKLunufjtvq4lFP0TT1
         eaeqvDDTzwp8RfLNEkbP3HCMzV+iR/rc3rxpJVlXmcvyRmzMKNCddnMQead+DArUXaMx
         iQe00oh/pIWlEZAY6CKD8002b2UVg4E+7EPHjl7Oy0IoPhoUtHuuKTNHZiRGK/7CmsNp
         /BNw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ikQ8Z9pqAgZRqn8s7SCPDyOUHcOzAjGbE6dYBn4+xKTNAzGs1FD62YsS2W0qluRxXzGVqaqM@vger.kernel.org, AJvYcCWQOZDwEX5lPMrJQFoEGabkwxRaC/QcNxkjQQA/gESb/D0+F6pPc35uKk5BKJlzs3t1LLcPcfC8R2TLwH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoy04mRqvXs6kNb/sj4/28uHzljhcaeMIzFor0c86lxHBaZcJ
	pAgr1oODGe3ykf2PRbuMJR//SZ55GcGKDUUWEJXZXZ2ZWkxtg86tOBw=
X-Gm-Gg: ASbGnctA79Rc0ncujhy2QBmLNC57r6DQw/opcLj60Wj6MgZQ1jUAebjeDIe3dkCzleT
	nyKFAXIwcnCx+xbCugHU41V8/NZ4/4Y5+eZrtSLKbcPj5RgYVPLhq0VSD19CtsRbJSQlQbuDBw5
	TlcDXLEQJThmykBteBszSYekRHVjNxLv2+tto+tmbPcqvq4iAA2+8/U0bPFsiwsq2BPYpTwOv9T
	E8+ax15ZDJ91tn9BLqOJIGSf/YLfs6wT9JjN+AMmTS+xjor0QTE+4v8XCuME1iANGV0FxgJUhGG
	iTgkvr0TMzTiS9H53am0fBYuud+E3LYn96bRyi7jtKzs7Q6qFgnAU8yGHnoElcLCmQbDDs4GBE3
	pHv96d/rEE1yzS7MPm9uGzEikiy3HX7qyD5nC
X-Google-Smtp-Source: AGHT+IGrVCsAbOfF2Z57AhIYHZhANi6KSxXgDZjVUW14yWJvdn190w6JMajAW56Qg1tsRmwVdCyqiQ==
X-Received: by 2002:a05:600c:4506:b0:43d:fa5f:7d30 with SMTP id 5b1f17b1804b1-442fd9a2be1mr6494175e9.16.1747345031811;
        Thu, 15 May 2025 14:37:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b057603.dip0.t-ipconnect.de. [91.5.118.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebdc362fsm78870425e9.1.2025.05.15.14.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 14:37:10 -0700 (PDT)
Message-ID: <d77efcd5-4b38-46b9-977f-226c53a7aadf@googlemail.com>
Date: Thu, 15 May 2025 23:37:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250514125625.496402993@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250514125625.496402993@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.05.2025 um 15:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
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

