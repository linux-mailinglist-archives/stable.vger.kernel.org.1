Return-Path: <stable+bounces-178837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74BB482B9
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258B17AB0C1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F541FDA92;
	Mon,  8 Sep 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmPqTzos"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9559157487;
	Mon,  8 Sep 2025 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300443; cv=none; b=oyf41j332vq9dn+J28otijRhE9Hpw2Ig5YRQ4jwXcvGBGzHAcnEfjdbCDn2uJCVL/9HhvoYwF0nep3EyFg+xG3YmL4GhZRhoqhbP8aMfRhnFK1S+nVWfQjYuo6HSZRRpPOttkPSiNAPqykgHLSEeCvjv8BYPRdstvLBEs5cEfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300443; c=relaxed/simple;
	bh=T5ZhbXKly4qM6QgfOHXDuNQzGu3EBG1+Fd/h0Lzfihw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyZ7QbuhYuIVu0m9vuJwZ+4djYDND56ZaWZ0ai8xkSrmaQ4PuYmxvkCNNJD6wFcK+FAmPibARFtoQkxy141oXzv76cTwn0tvIV6kFhX+Vg6jM5QaD5QfR8ajQcOecc4YGLkzx+dyUBKzC2qf1/GkXwvEhpWb2cWeGgk9NzTodGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmPqTzos; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24cde6c65d1so26714675ad.3;
        Sun, 07 Sep 2025 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757300441; x=1757905241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FPoZm8vJfS/oNYy/TGDbhsWmWQ48pnNg0NhQ9OtAi0=;
        b=gmPqTzosXZTm8h8FYxXXlWfhQxKLNjC8Treo91rbmISdEeeEGCn3HyqMyBDzTAafpy
         m8Vj7h/Pl4D7gsyVEDtzJ6Cn9lAgnEeb9WTeQwCzyJumVdzpRrRkJNX+/Yn8nyeFwPJf
         9BkhY0SriWtfkXrdhukV7Ff99egS0CEDmZ+a4MTLs88m/PtpQa8f87ouvgoT8txnIZPj
         Axhodxpdntpd0N0skgR09LhrL54UbHu0IATBmnIUr98J5azKd2H0la5kK04YFcLLddNC
         ohgnPDJkDPMitDNSPSe2Z+IEin4meE7W9Gc/iGqQ3H56U3flvonRQowKDa8mjGUbKv/y
         gw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757300441; x=1757905241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FPoZm8vJfS/oNYy/TGDbhsWmWQ48pnNg0NhQ9OtAi0=;
        b=cs8p027rE9kUs7+ik2oxGi6o7GMXz7wGFVWAkeoNmn/c6uDTLLRIEgdKLI9IC4i9zV
         z3bmumqIFZROynoocJbirVqBYlgXEFm6jv9vXEIwi3LYY6OqawLUEkXdSN+aSe6LtnoH
         royUT6C5WTtJiYtRw6FpNnO3aHtnMB2JlkUOwLL+cbDng6D/NovRUltKEvuCdxe/NPKN
         VYxPKVLjBOipPAoX0yiEFqug0+8mkCZSf9fZ5G+RzkUhXd+uex+QN/TvD+zx0JqyyaKP
         fFrZ+OHAouLpOthpmaeShrPvPcQwC+ZFCL0OqAoaEFA6pkleLtkcccWcWbIA0qFz+ne1
         9fcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCLVOlzWV+PnF/WjMbMSB0ieyzwEqaUGo6P5HOxdjxstrY08dZQLOfCG1jlbo7BwYM4DeifArmv2UdkMw=@vger.kernel.org, AJvYcCWGnm1UICPHWf0H7/HnqZ3Bvu74WQf/wnzubCcp+5jOVtDNtBEG3gY5iQr9cT063HDOwsR0LSho@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HGHv0CUtMXhfsqZAlWxWR8J2sIx5Rw+RnCDiaMbboeLOYpQX
	H+4tyqrqM6SG/qJbhq5E1nfKRfahUUwYpjKT+UK/X1aFr7+7AVD0nJKa
X-Gm-Gg: ASbGnctdvboehqwFPtjPplTUX63K9TmYKV0lya23GDb7AtfPe2I1lEEWM6s4DUxVzqj
	oFflbr0zvA8KnJaNzR8JHKtDT5WPlhQcNDh9e30ruZTvjPr/KNBa9GAlQQr76qrnUTktuQ18xHQ
	/CHXbHbk5kU8+KdOjRLQAU/9LD3YuHe9Pcou4SU56U4tYBvYgutDBc8dUHZu3ad7MBKHDVsPQbT
	PF2tIWilHn1Mdked/A+J+7Z+/xSv5lbeVFh9G5kzxKwhgi8CD5dXnjz8qwucxXt1zjY/8hrc8uj
	5IJqVXI8owpin4EUUpPU4mEX9/wnNi6VZ3uSdNWa9tA19z/U9jAoazMrwwH3HjqBylNhYlleUW8
	7J+YksQ7MdvTfmJM+NVnyvTbyRGp/eB4gL+0ea3i5RHlKKpa9vxYKO43nypAaLyEVyZPLb/M8Sl
	U=
X-Google-Smtp-Source: AGHT+IETTbiAXs/1GXxiYYI7GifjMnzgPvlZg13nmb9R6LYjegKg+PmdWgu81MkIfyknzH4vU/L6Vg==
X-Received: by 2002:a17:903:2450:b0:246:a543:199 with SMTP id d9443c01a7336-25173301e63mr96025445ad.54.1757300440890;
        Sun, 07 Sep 2025 20:00:40 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1d2c2833sm153726625ad.52.2025.09.07.20.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 20:00:40 -0700 (PDT)
Message-ID: <6a53318e-13f1-4c38-a9cb-88955247b666@gmail.com>
Date: Sun, 7 Sep 2025 20:00:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/104] 6.1.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195607.664912704@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195607.664912704@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.151 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

util/bpf-utils.c: In function 'get_bpf_prog_info_linear':
util/bpf-utils.c:129:26: error: '__MAX_BPF_PROG_TYPE' undeclared (first 
use in this function); did you mean 'MAX_BPF_LINK_TYPE'?
   129 |         if (info.type >= __MAX_BPF_PROG_TYPE)
       |                          ^~~~~~~~~~~~~~~~~~~
       |                          MAX_BPF_LINK_TYPE
util/bpf-utils.c:129:26: note: each undeclared identifier is reported 
only once for each function it appears in

which is due to  05c6ce9491f1851d63c40e918ed5cf7902fd43d3 ("perf 
bpf-utils: Harden get_bpf_prog_info_linear")

Looks like we need caf8f28e036c4ba1e823355da6c0c01c39e70ab9 ("bpf: Add 
BPF token support to BPF_PROG_LOAD command") which adds the definition 
for __MAX_BPF_PROG_TYPE, unfortunately there is a lot going on there 
that this won't apply cleanly.
-- 
Florian

