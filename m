Return-Path: <stable+bounces-64794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25E943468
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A86A1C21AD3
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13391BE221;
	Wed, 31 Jul 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a56fyTbl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEA1BD515
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444589; cv=none; b=dNWKpOwGf9VfiEIoUO0XF9onFmARqnnOO2884xjGBx53BFDMdxobYUjC77K7HGLAcxGxeUnqd+/L/nqcVPYEsqVBBS61s8bMJYCMMpqJ//2W+MDCQK17P7kYFtTTf6qc56yr3UR+EAjL2OIduZU/ELD+7Ig7nWsSOUv9eR4jhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444589; c=relaxed/simple;
	bh=8COUR4jon3L8f5VLwM53D1JRLAKJ/oJmYgFrKUa37Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtJUGO7ZOgE6NcJOxxCMM97kRM14+rJzmbWZ3VSbwG/qb2aWSSEvx66R9VjfeIq0f6oKLt4v8CQVJZR0CuH+De3wgi/Ve0plPVZAEJmR/vvLLBlFlII84n+QCFynUMSfH6Fv/orb6iTSqoHq6O70LqnUQwS1F2iwuil0UTMyTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a56fyTbl; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f82478b70so31808939f.0
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722444586; x=1723049386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9Gf2Q4Tk9nOZbWGuUSF4zfICmpYu5ZWAJDD+PJGym8=;
        b=a56fyTblju1VkljlT35HghqyruhAehBE4lbQnJMn+CsQjocg/d03bB8q3RUQOKcpn8
         2228aW18UJc+BOS6DSknq3mu8oJCvsVuZgAz8fNjeSJA8pbV6wlxhT+Qe4c7YblZ/PXW
         nNCCFwYlp1iZEKv7FLGXCb4v4cZEqTpPlTHYSYu3q4hJPagybOlBY/Zdl1elSpCHMAS/
         Fy/FpDfd+DmmozEoYf2c4t4jQMRiTRTvXmGRDsqVAMmiOZqerp+p7MviqkezKv4d3Vue
         coVIfiSMuaSW+dbK95Y4KLReWrbe5NlxCfP6Bvp5uX3bIXl/CK4mNVuqMChS4bQ44bm2
         EP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444586; x=1723049386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9Gf2Q4Tk9nOZbWGuUSF4zfICmpYu5ZWAJDD+PJGym8=;
        b=GH42iteppWXUT7XKDTQFGAIZ7a1u794z1rmhCa3DCFxv8tnhr1hzCCS3dFwTAmAeae
         CuYjdhLfu76t7G7oZe4k9sdD9I5fEk7Eqg26GFYO+JmlV2CE2Nu+hgmSK4HsUSSIC4l/
         ZN2YeUjTOxOwwM4sNVKZ+r6Ah5/X5f3sZDuuRJV7l2+hfQHnA+u5h1WP5qTRiZcda+iA
         sdliZVlJ9u17kTXkSqJSwBTU5RDHGrCSqNk8DW4wgZLfUFmy4pXx/qv3JV1c2WkoKkT7
         DNcHYa2My4veNuM46ZCGXD2KmlUWpSeMxy2inAxwA2R4nZopdiOFbeZ629axnhMjvp30
         JShg==
X-Forwarded-Encrypted: i=1; AJvYcCU1WvXOkVs11lBOACsh6N7TGfDAJbgQtKjYHSwjbZUAfPcdgsilo5Ss1ODkkgrKSaa3+wqpYRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqbysi9P7hYkST0YMKvN7Vd86m5DAHjqrF0a73t4F383Laiar
	B4BukW3bFRymIcBrsWitMlrqzYsVQ2/VcFqBMHCLnyaL8cxiHlNHshESx8VZn4I=
X-Google-Smtp-Source: AGHT+IEk+lGB0Kz5JVSDo0ASBT9BQfvixOonepbfiFsTxqUQPKZroqdGrUESKpSIwV9EY/KvPOv8jA==
X-Received: by 2002:a5e:c116:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81f92194514mr1019042139f.2.1722444586625;
        Wed, 31 Jul 2024 09:49:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc0a133sm3243209173.125.2024.07.31.09.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:49:45 -0700 (PDT)
Message-ID: <45a5132a-592b-4fcb-abaa-89cec26a0334@kernel.dk>
Date: Wed, 31 Jul 2024 10:49:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20240730151615.753688326@linuxfoundation.org>
 <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
 <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>
 <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/24 10:46 AM, Dan Carpenter wrote:
> On Wed, Jul 31, 2024 at 10:13:26AM -0600, Jens Axboe wrote:
>>> ----------
>>>   ## Build
>>> * kernel: 6.1.103-rc1
>>> * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>> * git commit: a90fe3a941868870c281a880358b14d42f530b07
>>> * git describe: v6.1.102-441-ga90fe3a94186
>>> * test details:
>>> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186
>>
>> I built and booted 6.1.103-rc3 and didn't hit anything. Does it still
>> trigger with that one? If yes, how do I reproduce this?
>>
>> There are no deadline changes since 6.1.102, and the block side is just
>> some integrity bits, which don't look suspicious. The other part this
>> could potentially be is the sbitmap changes, but...
>>
> 
> I believe these were fixed in -rc2.  We're on -rc3 now.

OK good, thanks.

-- 
Jens Axboe



