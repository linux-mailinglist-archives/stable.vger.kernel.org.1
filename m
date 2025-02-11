Return-Path: <stable+bounces-114852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D71A30543
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFBD3A4EDA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB81EEA48;
	Tue, 11 Feb 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNJ/M+P4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB671EDA2B
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261293; cv=none; b=Ga9ekoPK+dbbFVoDnodiFFgY0/IsbS7jVIBcYtJm2yztUg6KIW9cp915Pk8/4EwAvdOA+Gr5X8MP0VgWC2yfB0z1tSUv8eOD8kVQw+X41a35TRmmGuXVkzHqcM3UMn8iWClOhV4yaFoYjArQ0ZgDJZCLCMDmxTC1FMWI1D6GYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261293; c=relaxed/simple;
	bh=sSpoVF5tKRxtaZqs6uZeX1TfHNKBHsN9FJ2ZMpPBbCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxQ65uKuddjfX+44029nEoB8oDalLYk5U3Pl4YPkt+R83zZm6/xdlyfb9inDcHek7gIsl/gCBsScbnZUqTLYdO5jv4Qa2V8uQqq7BsmnsDDQWrmJCLBJUherHea9tDjs8b2y6HGfn7WIUlyg4GsBuASgRr3YSVxdzyOXsXbVYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNJ/M+P4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so1912217f8f.2
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739261289; x=1739866089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiK7BHSVgTdQkQZzP88yLZAKhA2S6bWhUg1LMOvnPkc=;
        b=MNJ/M+P44eCpvjNzhHf+T9kXx8foal5f8Jnktvpw+2I/lFKyFtcVVrR9E5PGbVYp5k
         2nqq0spvzUITEVqIZkkXWL71H0zknQ7lpVPzWrSoMp3OEG3Of336/LFERHEaG0tOf5Vw
         Yb8YXX240uaaEUWDk6iTywKWqYUj4B+nN8H09uS9fA/0eAnpgVuCWEgEFCuNLTR0Q6Xb
         PXvjTPLbFxwNBcidp4QYnJMJsbLVprlXzMKuopJOsoInH76/KA0aD3U+3cX0cFP984TH
         zrm/RH8TYZ55+Af/vdd0B2KLEoq1PxK/wzUgmq85iBwu/6y2JRATl8/dZ4tFCk7BN514
         tbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261289; x=1739866089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiK7BHSVgTdQkQZzP88yLZAKhA2S6bWhUg1LMOvnPkc=;
        b=hB98tTogQwIpnRfwT5iJqVE1HYb0YlNi8vP45uSvNZGINXWfm3jYgGUdhfrar6hjub
         fWwcJpy2XnsihmQs1MRmQQz6TMGhs6QZBPWNXiao1rQrnnZf+rRoVuAui0K4ldaj8m44
         M/Akss9Tu6loOwBEGBiiQkXs8fBW8XsG+K/8ywoBHVmXwEjNv4Tu3frMnIyHxdQ1z5qB
         5n0IDHXhorYUFfaFbytuKF232wxyDIRW9fRKMym+10d3rSCjE8u5NbAooGx9+xLXxL2M
         eGjDY6coPo/VkFywzk2teBPgfawC5BALnPFi4PfVF8UOjg2GOm6y7SCNemtlDhlKvR/C
         nbIw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Q/7zRp4ZC7uVDAYpFlJjWAD97ZGrTKUajnx9Oy4OUi4/yRyrCJwqZVlnTCWINvtJdkDHBmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyU/dhsPAmiOTwz1srtFZ39gDlokz3ndBZD2GgNOW8j8Mx4VfA
	hmaEr2uShPDhGwS03KL3a9ydQCXCesSZz8GtJQ3t7xzccsl8wJT5z2ZK6eC0oG4=
X-Gm-Gg: ASbGncvKGNZQaDXeoTTY+mginpnOy93Y8JkpWi+9yxHM65ztduKBScRGHRo6VXxB7jW
	Grw8XbSmtPgJcuAvJ21+tb1b98TL/UOWuIFczTw//my+wy6NmA/YeWr8F2rbwrGrRUiMLDtDrxd
	serqAZ+kF8uUzqxfjsllf/2KSsEsstUGP1rqwLHEEfLk/Z89BnnpGZZ5kNlO81zh3SnCGGa0Yjz
	FqNPu9q56LrMD4NOcrHmuIPCt4HQMuwGNvSuUnq2XdMZmptlrByqFqcINQLgN+baF322k0HPK1A
	ud/yFt6KVoWKiYEQqYNyvJ3v77ef170bu579A9tvGHwj70NI1WG+dIs=
X-Google-Smtp-Source: AGHT+IE2oWYuWjmjvpu3ABr0HEe1925aEaOPbTS7VONKBvqKWoMObjwVOs9MsKRzrKKQMRmZMw7JGQ==
X-Received: by 2002:a05:6000:1561:b0:38d:e38a:5910 with SMTP id ffacd0b85a97d-38de38a59bfmr2866271f8f.28.1739261289162;
        Tue, 11 Feb 2025 00:08:09 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4392fc7ceacsm102977005e9.20.2025.02.11.00.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:08:08 -0800 (PST)
Message-ID: <0b37e5e1-6dd6-49fc-b874-741e75c8d56a@linaro.org>
Date: Tue, 11 Feb 2025 09:08:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal/drivers/rockchip: add missing rk3328 mapping
 entry
To: Dragan Simic <dsimic@manjaro.org>, Trevor Woerner <twoerner@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Heiko Stuebner <heiko@sntech.de>, Caesar Wang <wxt@rock-chips.com>,
 Rocky Hao <rocky.hao@rock-chips.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
References: <20250207175048.35959-1-twoerner@gmail.com>
 <5f9cf65221690452d7e842ee98535192@manjaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5f9cf65221690452d7e842ee98535192@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/02/2025 02:40, Dragan Simic wrote:
> Hello Trevor,
> 
> On 2025-02-07 18:50, Trevor Woerner wrote:
>> The mapping table for the rk3328 is missing the entry for -25C which is
>> found in the TRM section 9.5.2 "Temperature-to-code mapping".
>>
>> NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
>>       4096-<code in table>. Whereas the table in the TRM gives the code
>>       "3774" for -25C, the kernel uses 4096-3774=322.
> 
> After going through the RK3308 and RK3328 TRMs, as well as through the
> downstream kernel code, it seems we may have some troubles at our hands.
> Let me explain, please.
> 
> To sum it up, part 1 of the RK3308 TRM v1.1 says on page 538 that the
> equation for the output when tsadc_q_sel equals 1 is (4096 - tsadc_q),
> while part 1 of the RK3328 TRM v1.2 says that the output equation is
> (1024 - tsadc_q) in that case.
> 
> The downstream kernel code, however, treats the RK3308 and RK3328
> tables and their values as being the same.  It even mentions 1024 as
> the "offset" value in a comment block for the rk_tsadcv3_control()
> function, just like the upstream code does, which is obviously wrong
> "offset" value when correlated with the table on page 544 of part 1
> of the RK3308 TRM v1.1.
> 
> With all this in mind, it's obvious that more work is needed to make
> it clear where's the actual mistake (it could be that the TRM is wrong),
> which I'll volunteer for as part of the SoC binning project.  In the
> meantime, this patch looks fine as-is to me, by offering what's a clear
> improvement to the current state of the upstream code, so please feel
> free to include:
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
> However, it would be good to include some additional notes into the
> patch description in the v3, which would briefly sum up the above-
> described issues and discrepancies, for future reference.


Applied and added the additional notes in the patch description.

Thanks

   -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

