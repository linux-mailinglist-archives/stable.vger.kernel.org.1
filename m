Return-Path: <stable+bounces-182880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD8BAE999
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 23:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD2D3212FA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7DE28D8FD;
	Tue, 30 Sep 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SlycOliT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEF228B7DE
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266640; cv=none; b=u4FhFgsZkBsJjzpmmXJzZbelqoZC4RsxkttVdZJWQ6YDy6V3tKnoo6dvq1CaVPr1hjqQVWSI17YM89bBRDjTk0eiier01C/sxF/9jT+18LdVz1JQZl6Axpf0v7bCuptWrSDQWZWywNCuAxQ4zaqD7qGhMdKPnrJrMMnQP+uYiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266640; c=relaxed/simple;
	bh=IY/T5MW0cQ6hRm9986aMUWP4hxXi0edg7BRspaUZmxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHoIHG9DUbjZwO+4Bb1wqIUgj7LRMtZbiDmc+3HXyTmuFglc56qjLvGdwuQBMDSCA8tNPYtZo/3eTcvl3lBs3CRzLM9rLII/JqkRfAeYKo7aw+IsXVtgtqEHPyVzdf0cQ8aanX75cPaPQ35YvKa3GfPaK4F+NGNIn8HdS9nGeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SlycOliT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e47cca387so45809975e9.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759266637; x=1759871437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHb1TeK0SDtTGD/hGQdOAwIIPezVefzkx8O/f8zdLfw=;
        b=SlycOliTrZ/v2davzRiKMEIc2I0gdO4U3p9lnmfSrGlduz5FX/LGu5BJcG1yuSRzi2
         vN/nje4LvAn5DuZ9PLhlSb1aHQSRo8GAWuvTB4xabCxYprROxbIjPvCJpfJihIKESNgT
         EHxW7Ox0Wpas9Ukqu4H+vGN/Y4F9NBGiYe/tzG3ixlNj1QG5KWjbl3tDwhPlnHpk66hW
         A64LzwoPTeSYsxGD0f7yUOvXJmImdRLpLBB6XFwmgi6qIFQkFKOSLhTKs3aYBTqJnROJ
         ZQxGhUyoK3EY3wWHcfjYyEPs7Ov7CNrm74KKkB5PFGd6RX4HPgB1EncA8qqklsjRceYp
         gBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759266637; x=1759871437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHb1TeK0SDtTGD/hGQdOAwIIPezVefzkx8O/f8zdLfw=;
        b=Bgl+qx2loi+ScmVKLZBK3ZHu85UCeRHJbXe5KjhUXcl3e8gLsW49vX81MgPQjVSgD3
         EMIZE0QlPExD0X67F4WfwiUCxXT4eFrshtplhDc3UOWWkK8yNOGdM9PreYTgjOneAF6e
         N9cxY28EofDzyVh9hKAA0Z3uaUszyfh/ZyojVogePb+5J9KZwA2TPgzbBI+m3JN2yoO2
         DNZfSzz+Jeu+W/rU59UfGeoNPNHSAY65XW6Ih2H7syFTf/6q3KsgRFMrFhTJpKgai5Ao
         rT3MKYJGiglCnH/LjEyl1OaGh3MeCEhZQ06M1HrYUb5IZZdJy3i4EkrDuXVMTH9c8BTG
         /rMg==
X-Forwarded-Encrypted: i=1; AJvYcCWNOLFwk2OX8VSf0lQKvzHKcEul3oOKyrosHsCqpwaIAgyEMaU5frrfLoiQOrZSyt/4Bb7A4W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0aElfqg4tEYkla7xUlLfzZQbsJ5RoYH3E+cLSUMJNDO5yQbE
	LF1onRJR7b2de8GZL8214dgvx0HaOVLT36IdpvkdOi6h3YkxrMIYwiE=
X-Gm-Gg: ASbGncu1kgfr/nqEfD4ISY+uKRKmOiTCBPAWyw2Rexku1zoQo0fQF4hmpW7D/ui0jBN
	tCP8UiRj31T3AGWh6I6dxzg6W6tRFKW01rIMSBLCkZKXtCfWTRTNv+aMJ8YsvLReLuSHEpQcxA5
	KneZCBBf86DFPA7pwmTG/xzJjlAhk6orcfXWJHIZQx6XPOklv+iHlG9M1r6hOfray7jqY2bYB4z
	4Gtkw4Uu1+SU6IUejkSpoXoKNpSl+lnqO9ZzZqrWLDqBRN9VgFLhxX9gdc/s8LK1dn6He/7/XDE
	U/it784EhDfge8HEfnFQ4Sc7uaufVf40qHyzsUpr/rx4cBXivf3wuItajD31KZz5SmRnMBPU8Zj
	dO8j8SqM/yXQj0+6KBJ75NZ8aH4rB/0YUhEILeKH1uSxu/EvsDYLssUdrtGr2JHAD7LNoa2ReZS
	wryL8uzx4+KEnoAfJ3FvTkows=
X-Google-Smtp-Source: AGHT+IEtRCdZtfm6bV+C3kHsNpx319GbRTyLtQCVbRdZ4EJBOZT09wV8Fky23E8en9rieAf9Q7cbwg==
X-Received: by 2002:a5d:584a:0:b0:402:4142:c7a7 with SMTP id ffacd0b85a97d-425577f325amr883446f8f.16.1759266637039;
        Tue, 30 Sep 2025 14:10:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4965.dip0.t-ipconnect.de. [91.43.73.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c3eca22sm21222835e9.4.2025.09.30.14.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 14:10:36 -0700 (PDT)
Message-ID: <4e557716-474d-4aa9-96f3-9bf154781582@googlemail.com>
Date: Tue, 30 Sep 2025 23:10:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143831.236060637@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2025 um 16:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

