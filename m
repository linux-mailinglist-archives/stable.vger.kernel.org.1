Return-Path: <stable+bounces-78543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B90198C094
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AC91F22057
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDB5130A47;
	Tue,  1 Oct 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Buv/Zfmm"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF455BA3F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793937; cv=none; b=CaIUmdZZDZq88rE1kiChsf6N3n1YXRH/jqXDozsML2aHzz8to+azMfs8uDdANphdLU32K3zyoAFlPXEhGT9p90/twvL8AWs7Xd/L0BeB6KG1xGVx+aEnsURD0JmVLJCRLjsFizB47odE3eFmsxgfYipc/C+wxE+6SHiptP8FwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793937; c=relaxed/simple;
	bh=CMoo4YhOSocjoNKYM4H6Emvc1PeKXYKfD+67gjmhtwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbMCfFzzVgjYqicLyVTsEOwIO46rjT9IOeWEaWQehtOULOs3ZoJmV+oPLHYdv9ef5l1NsWzDwRvGHXbltwwwGTq5qWtPGwyYBY2GsJ4sETN2jvfnXJsdhnjwaujpMy7OS6rliMKWSOd4t0/5DIo2UYJ4bbwDFVeJfq2QnddYxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Buv/Zfmm; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aab679b7bso214928939f.0
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727793935; x=1728398735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fIb5AfAe1vCccPP6pUjrjl5D4kTfyTI3ADBkFYcWXQ=;
        b=Buv/ZfmmlSwJ2BFHgNQE7wsbznexIcQUA7GZUgRzzHePBANO+7bSOjYFeqz/ZT6AhO
         5NeR/6XmTYfubwglR+0cRL1ynQX4JPqE+htMmhGg/mJ72IdOegkNmfNxedRTrBxKAgbv
         OCUW0m4I9HKKZewY9C4EuJvQ5Rz+ByPYSh498=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793935; x=1728398735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fIb5AfAe1vCccPP6pUjrjl5D4kTfyTI3ADBkFYcWXQ=;
        b=TO73TNrJFqKDjP3dTW0KD4AWVmGQEauFgX11lJx1ynNskdghYM/8MZah3zsmKn61O7
         DGDwHhYhKDzmsMBVOQqEr7wpYsUbsd6BmGjh7nX3Kv1bv1S+cfWHpUAsNOgtx4SN1AHf
         vt40A7kyShLGMDUswAVYoMXrUA63IcTZXzmwIcGv4XzJIh2e0zjEBZGMRa4bD936PLC/
         pNyaDJ2pmoNXXU5fUXCOUOOUzKv3UkUPS7vdJtuC6K5DU8bsZ5Onom+YXNTZ1YkteEEs
         wr32d+bw0j2Pl0HqpBY2nATbUhHw0Ku0/0zFX+stvCh5iBQx3eTDh3ze9z3K6XgoLx/J
         dQmA==
X-Gm-Message-State: AOJu0YwpphMscv1CuGsNbsxOwXpyIEck1uqvnQ1rlNWI+QmFI7l3A3+8
	LiADLS338AXfoLhPKn/ymjwdN2xWB1Xkxgb9kJohQpNnFowTEU2/Eam9rHTLTmnSTM/qYW17a2D
	P
X-Google-Smtp-Source: AGHT+IEGiLE7UjzVO6FDrurn6uDU+XK43N6lkEmD92YS2bsqIse3AVkMwSBxvWACpPFdOuHP5IgvPA==
X-Received: by 2002:a05:6602:630c:b0:82d:8a8:b9e with SMTP id ca18e2360f4ac-834d83c3b6cmr4246539f.3.1727793934933;
        Tue, 01 Oct 2024 07:45:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936e2583sm279971839f.25.2024.10.01.07.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:45:34 -0700 (PDT)
Message-ID: <87e2500f-a78f-4ddc-ba36-deb56e7a3bd1@linuxfoundation.org>
Date: Tue, 1 Oct 2024 08:45:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "selftests: vDSO: simplify getrandom thread local storage
 and structs" has been added to the 6.11-stable tree
To: Greg KH <greg@kroah.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930231438.2560642-1-sashal@kernel.org>
 <CAHmME9pBufdO91FK8A_ywNhOcpxSjvZJA3_pBCbhPf+1qHZaMw@mail.gmail.com>
 <2024100144-aloe-acronym-f34c@gregkh>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2024100144-aloe-acronym-f34c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 00:51, Greg KH wrote:
> On Tue, Oct 01, 2024 at 05:56:12AM +0200, Jason A. Donenfeld wrote:
>> This is not stable material and I didn't mark it as such. Do not backport.
> 
> It was taken as a dependancy of another patch, but I'll go drop them and
> see how it goes...
> 
> thanks,
> 
> greg k-h

Jason,

Unless this doesn't build I would say this should go into stables.
The ways selftests work is if config isn't supported, they get
skipped.

thanks,
-- Shuah

