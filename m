Return-Path: <stable+bounces-150608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F9ACB9F5
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9E01883FFE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFB14EC60;
	Mon,  2 Jun 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVgnPAAt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371F8EAF9;
	Mon,  2 Jun 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883820; cv=none; b=czRr6C0CbWUgtM/ucOY61wIK24LIhmPIfbOTELwVQ5ErQfKaxggFtIt31zc1AwaOtDobA67M17BWRffEfRhhdKAVuLp2fyKxaUtTHqZiZzg6WX9dMUwV5FCcncC5o8qjMGkxQfWoTe4e+CttbLKUKqmx+ren5E7ievg49u4o1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883820; c=relaxed/simple;
	bh=VMaer+x2LjRkIyNhCPgGhMCgkxjOf58plLCkqARWbt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U90tW7FjXllosUO5JhBWIyT5P8EjNa9SAKov0J2DPPSWg3V8K3rV9hcjvcttz2MTzroN1XnX9Nu/Ce74zKrWzWrqDBwk9sD0WCUl01+gxbHeP1UB8q9E4e7dLeCUL0MXINypm6IC/RzxtROHkyOfYdq1MnBqGKebXmRYou+ZZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVgnPAAt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso3535208b3a.2;
        Mon, 02 Jun 2025 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748883818; x=1749488618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fll3hWF4pol/LM2L7XdwKp07jcPy9V6QGOSoLodOnKA=;
        b=QVgnPAAt6Yw9NL3+h4RIeqglZwxmjc683wyWtAcIULyKTLE1j1LV7q9+HOzdwkVYsT
         y4i+jgBi92MBeUlSBN4wfAgmTiW0AgKNUtXQq1jYWqDdVVEvuEuOLp5/yh2diuVCjwEP
         YLiJPQHPOjqumrmAV/HLQYn2dL4qocdJv13ltUY2D3epI3s7aKbHPxLNUab3MSTjBVkT
         QFI3ZEBPk8U6Wno2le81agGceJfOK9BcTyPK4DWgwJ8L4geEvhTNxqG/hhanMQLvSV4e
         aWsDWHXCcsAFkEOvOhue810518TsHP6+SEgo87anTg0nUkC4HWCijl+37O3KlRESTa12
         pE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883818; x=1749488618;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fll3hWF4pol/LM2L7XdwKp07jcPy9V6QGOSoLodOnKA=;
        b=gUxpyXPQloZgHR9Rdr1svTvy3fWHByy/txIufBKwM+hAfKY6wRAdRGUhbcmyzgFSUn
         5tck5JHTP+a6Qly/fAxjPtmrg0Wm/Qn8wUtuy/bXGV1uwfUJ9ZmLmcbtS2hpY/Yz551J
         aTOJM+EO3Uvn3+h5Nwkg16h6cBOBWB4817U1FS2vJhKviEp+RFLwPfD2zcEPMxnaGQCU
         qgLZA+wrZWyeQK2ac4wbfSkrK1hizyjMLFYeR39IGvryUlEFTxZuYvRVGAISQ0h6qpPy
         ntsmLGHzlbGPCls7EhJF7rL4XS+XdPgNqoP5cgP5fRztc8VGrSR9cur4xf6PfiyyY4l/
         lXLg==
X-Forwarded-Encrypted: i=1; AJvYcCVeSJQqAJ4CgB3vkIsMxEFJInJaFnUiJsxYh4ehoWcxSXZI9qsS6Cd7jpHc8bRJ2eGSiJOLApE5@vger.kernel.org, AJvYcCVnq5+8v26uMCi+q1tx2/KzGgjJGGUI2JZqnB9mSh6Cbox0C36TRfsgV/BF3TMpIwVSNnTdctP8kRaWZZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKNJU2V37f1vHhqBvShXeFGUrI7+N7MffBC9sR7sG8cef3Czm
	rqnXlTjyB0IIw6K8dROF2d3GzIa3qG34s9aTAuOeyr2aRmEcLwCnSwZWqE7aRHyS
X-Gm-Gg: ASbGnctvl0DRqDrxhlywambPv8u9UpcATZea+fXOYI6I3U1qjfx/1J4cGx8eThYMI1W
	yf4ZzBVyWvkKS0o7Twm0DdLZrj9s/0zO6D8QNMXyXnaATZmx9ZJ6lxmFoghS/O9zpzdS0rC5UsO
	3mJmiixJM2NB7NxKT586sqRnYj/RC6Ipe2xpCKlvVDpne9zgGHrbfBcz2l1giNFWASSpxKA5xK8
	R12vEJY1imbKZa8wjnhr/iHPCAddeErvRXOxpCpvWX9pF/0blYNAdvV2WoVAjOr7Xw7b7vIiWn2
	xj+d3uuFAEsv7tZ0BFJnstdq5lRPAW+wWosXX/ybH6Uqt6sqTMz86y+5wt4M81v1fWO6NcRrtyF
	I6sw=
X-Google-Smtp-Source: AGHT+IHFSNHnyO+CDl/RuvZSWW0apRaWa2HraPjvF6RPXFQovk1bTYvNCry87zOPF++XkqEjDNbdxQ==
X-Received: by 2002:a05:6a21:9998:b0:215:e9aa:7fff with SMTP id adf61e73a8af0-21ae00b198cmr22928496637.31.1748883818354;
        Mon, 02 Jun 2025 10:03:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeb2bc1sm7874247b3a.47.2025.06.02.10.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 10:03:37 -0700 (PDT)
Message-ID: <50d6ee44-f7c7-4fe7-848d-dc31cddc19f9@gmail.com>
Date: Mon, 2 Jun 2025 10:03:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/207] 5.15.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134258.769974467@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 06:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.185 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

