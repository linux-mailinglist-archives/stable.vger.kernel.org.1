Return-Path: <stable+bounces-27422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B2878E52
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 06:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA2CB21A05
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723B1EB3B;
	Tue, 12 Mar 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HFcNbfhP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12371E48C
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223045; cv=none; b=KZx/6SvKIY9EjMtQs3QfSEg/9EGUiB6fzowhTSNsoWWeVoouJzM93vbvrNDwIFBPYhuQ/dVMSLHsSPNpY+R/KbV0lVgCSGCpijhs7Ty74tUfFe0CyHeojbYoZ5AMGnF2lJMJkQMHDtBC2eVeixd06R/voe55XK0d6svXawcoaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223045; c=relaxed/simple;
	bh=0pS6UQNy4h2WS+dDycULSwfO0aZUSlRNLTgLNhuPNcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITc5Mpv0m7omxwjTcLsxTo9Ne85OTOoGDmR1Hwm0VqT6XwpG41vsndcb4vPZdTPPpGZgDb7CaH4bOsSm6fRLkajw/pyyLE8hzKAFyAVXtcjI/K9EWlTc7WahmGzx4F6d4Tan1Dv3jn5XAoDgCLHYd/HogqFDNyPQ0X+pSxcSh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HFcNbfhP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4133100bccdso4326255e9.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 22:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710223041; x=1710827841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OxjbKKzutr0qqrowHhw/czvhg2nFLhn6pvilJ3Okwo=;
        b=HFcNbfhP+685pKWpM7ZsFsOTRIrpJfT6m6HI/3R8vD+0KcH/LIvLTUhShkkgMoxPPP
         +aVfcWWizvXZBPCDV8Q3aB3+VvRFicg5DhsiTelSHOPeeihhpmgF/pL1egB/fGap68cd
         CX/j+NST4K+LluNVn20rEu/lv/4YOMcUzkPNIiSXGRW72zr4LEnZ8DBcJNsR75/9aqGP
         FhEd0+JpMTvWw3sD9jOO6EJxiGhjGTCWxP3NFwWvUCtup3EPBIuBxH8s9mSYx1dJfNY8
         57HIWyeeD7S7G7iBJkPPIIxM595r61HjY4e0cXsOs9TaP570ByLpK2yySQn+ZHZfJxfw
         tLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710223041; x=1710827841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OxjbKKzutr0qqrowHhw/czvhg2nFLhn6pvilJ3Okwo=;
        b=Enpq/pWEK1YXKLPr6/l2xiSUf3QGjeR1J3J4Pukh7P4ZSEV86HqGFdwfSxKf1i39k5
         4QD1gHLVO+zKyyPm/z0Migur3hEZjsYdWMs4uWSOc9NBVl6dv+B/8AUqk6fQpSTcAIlB
         E/JjwMjLVU05E0a8Dwl5eFoOWkmSvB1iqqZPgvYLLPorMlX5QbxiWYDDUqtx3rN32++i
         hWqzw87Ntagt7oiCm9EGCuM/uRC2sIa3UtfVqHpZOtawfQj81GZm2y6MrS4Nd7tGjtsg
         YNJIjBVGBK5JuaE6tBm2iUdT20NmVfQNQSZ/CEWti3bljZMn8VYBfmw5DfNOGxUaajwu
         si1w==
X-Gm-Message-State: AOJu0YyBLUK9eR/dj0xkoMCrrG7K8/PEYdQpdABaT+nDh+TxN5ja/+X2
	GqkENGKCK8/jrx3h7v2w7omOTD7daQJh9BUwztkC6/pUyRSglte9Lpw/v288lO8TnoLUBMVLOEy
	o
X-Google-Smtp-Source: AGHT+IHBwyW/uYtwd/JYeDG7vx6j6BiMDfVS8rzrOLQSWOz8koweCh3Cyb9XlyNBVKaOJL2xiFxpLg==
X-Received: by 2002:a05:600c:3d89:b0:413:33ab:23da with SMTP id bi9-20020a05600c3d8900b0041333ab23damr652954wmb.23.1710223040915;
        Mon, 11 Mar 2024 22:57:20 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:73a8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:73a8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b00412f8bf2d82sm17484023wmn.28.2024.03.11.22.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 22:57:20 -0700 (PDT)
Message-ID: <9055ecec-e5d5-4f12-928e-7c58d5a25de1@suse.com>
Date: Tue, 12 Mar 2024 07:57:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip)
 suffix
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>
References: <20240226122237.198921-1-nik.borisov@suse.com>
 <20240226122237.198921-2-nik.borisov@suse.com>
 <20240312013317.7k6vlhs6iqgxbbru@desk>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240312013317.7k6vlhs6iqgxbbru@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.03.24 г. 3:33 ч., Pawan Gupta wrote:
> On Mon, Feb 26, 2024 at 02:22:31PM +0200, Nikolay Borisov wrote:
>> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>>
>> [ Upstream commit 0576d1ed1e153bf34b54097e0561ede382ba88b0 ]
> 
> Looks like the correct sha is f87bc8dc7a7c438c70f97b4e51c76a183313272e

Indeed, 0576d1ed1e153bf34b54097e0561ede382ba88b0 is my local shaid of 
the backported commit. Thanks for catching it!

> 
>> Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
>> useful for immediate memory references where one doesn't want gcc
>> to possibly use a register indirection as it may in the case of an "m"
>> constraint.
>>
>> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>> Signed-off-by: Borislav Petkov <bp@suse.de>
>> Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

