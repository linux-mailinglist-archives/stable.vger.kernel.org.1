Return-Path: <stable+bounces-109300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A3A13F0A
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17663A1677
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519922CBF6;
	Thu, 16 Jan 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YKhE67Pm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2A22CA11;
	Thu, 16 Jan 2025 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044104; cv=none; b=COsvxqs5QpRE9JW2Ttq2wsc9s1nJib+7+hCEpGhKLhfy/lI+ruSZ24g54Dzw3k0wFqdip5i/CUzBUtYXZjmkI9WlOoEwVmg52uYwgRds6oLIdim8shjXx2BgW1YYYui+OoY5nmWgCRR11jB6KTgxFFqjzVHurWMjYZxpVmdjRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044104; c=relaxed/simple;
	bh=e97NZRxFTHXwumOHDQOxRyqCJc+Pdhf1lTQ9AKRojj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kj9TwUqMmAMJZrIPW8siQLwCSZf+yyeTtHaak1NlEo/N2PXkEQ6Ban2W5llXzwAjMODoU6mXhdVOryxoP7MRY4/o0BIL7wnFMRw9q+LkYsq1ROf6p5oCFcjFHsCWAZM1lNRePcMhb9OBBucPp7QHQAw0RKgEzKV6recnacE3cuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YKhE67Pm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so10724645e9.1;
        Thu, 16 Jan 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737044101; x=1737648901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Np8lu20undRAmUJgoAy37KKJdXjkLeFtZ823vKXu0tI=;
        b=YKhE67PmrqLVY0F+4Al/3QqDcr115vrBeYqUsf9P0zqP0P/NrAQdiWo8/eGrOAXAvr
         PrP8ufvfONgDGtCN8ZpUTlSlJOIArKzmJRlZJb3ZR3I7xjJif395QZmYn8UXNrENFlSr
         tUVPw80t83GqBn0PZiSe2l1eo6NDx08KmJ2j+bixmC2I3pKztYvSjCXWrM700iwh6+Mn
         p7Q0C3DAb3sqMzDBsPmzO6rSI6hFEswYHW9H9wbfaXw8Hw2XlM9qozdtioTtLlYEsbWF
         T9ZHLVvpBCu2TMKRHpF6X+HyB0pJrNGopA6glZ4YeWFGkDwu8noo51dwWMDKIeKBq66Y
         PJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044101; x=1737648901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Np8lu20undRAmUJgoAy37KKJdXjkLeFtZ823vKXu0tI=;
        b=AvKKya95jnLIKgEQdq2eY6sG/HPtVScV1xR7vYELL42Wj6qW15LYdYNttBvHQSoXem
         rJWkPzN1EfQhwcCN7RjKMO+5jZp3IILVP/nH6Ry3Q1NvcCrD8de/BLCgBmAFqQzryxlK
         5/8DWzv2VLEPscYQMM/WpSLMAR3l9GKIzCPE585WEgbeTcicIFzkkTXW8UcsItby2pSF
         pQ1f8UEuAGQj0+ugLxGAGi3xLO/hCJnATVe5Ov49lYbHjo0BmzoiOmhT4OpVshg5AQOx
         cxtj6862qXuCXAsX0c+8ev0hriCnytzs97OiOd/NbMZ164r6UQkA12sLSTQxgKihVOFE
         xq/A==
X-Forwarded-Encrypted: i=1; AJvYcCWfZWouAmbwT/nkMVCRbtKBrRngDn4L5+8BFhi3uZNc1xVOeUZZmF3HNV9rPyw870p7rCEjbndmxtjxX98=@vger.kernel.org, AJvYcCXLi6vtLJ4xED/XtPb4XNREfOgRNidrP22/eofkOkIbsEZdCGh/Tdv6VhCmzUNEx2/zSPwGfGDX@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJFemlmXOPNAoy0Kv4dYcDpaTFunXSF7oNArIQBH249CnWnz6
	UuclqajeCTYvELQ6HPFlwOztMF1mzASTwpFAdiHqjRU2YrdhcAU=
X-Gm-Gg: ASbGncv5145d4yUc5ru+EXM3/wfmpPiqFR4qdXEFQnrQ6/ERmlWfcoEWi0dPs4/d2/B
	nkOemc1B7Aa4kvtKfGzmTD44uz6JV997oqixCmLvmfVCOcvXhVdTOWzh7GpvDpYNStXhT0XcU6A
	QUprW1F2YMauq8Obs/jI+c0I6eAmX2/E13+qvWP4ceAdBv8QiWoCmZ/JomxQ3MuH3Gvh4tJ6Rz/
	Rr7C+tX+7fbYu4vjO2IHA4LdmWmgw3lLNes6OmMNyDt+kIzybcnaHoETiHQn6NiBhXwc0FW1A3L
	P8UWUVr5O5BkTwgASI4RaS7uoRERvj7v
X-Google-Smtp-Source: AGHT+IE2qKW3c8SbncuZnQOZGGUIMJWQPwRDi4JdlTSUXCecSyp4t26/SMUMUt8Wpjq1dILjwjB8aw==
X-Received: by 2002:a05:600c:4f06:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-436e26d018emr365824505e9.16.1737044100645;
        Thu, 16 Jan 2025 08:15:00 -0800 (PST)
Received: from [192.168.1.3] (p5b2acf03.dip0.t-ipconnect.de. [91.42.207.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468869sm3464095e9.35.2025.01.16.08.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 08:15:00 -0800 (PST)
Message-ID: <727b8fc0-0536-44b7-ad8d-38a43e83fbdd@googlemail.com>
Date: Thu, 16 Jan 2025 17:14:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103606.357764746@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2025 um 11:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
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

