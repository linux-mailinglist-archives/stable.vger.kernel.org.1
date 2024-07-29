Return-Path: <stable+bounces-62452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63893F273
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF0328123F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1854143C57;
	Mon, 29 Jul 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msy6SQms"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42BB5F873;
	Mon, 29 Jul 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248312; cv=none; b=KuAIb9MRTvQQGGUzLeMBvZtfSVSUTzvgGPb7qyzf+jsnSdGNMjwxfYI2rMYa41MvGsOkLB+0kogsxGomIqoaGln7HR0TE3+mt6aGI3Nqocvnybpe0S96GLTysIM6qj3CaGOC0ZTcG580OmHGCS3Cuj0N3VoM+4OHtXIxBqfje94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248312; c=relaxed/simple;
	bh=Fm9RTXSGnH0y/BmAEzolz2nfAJS55MrZOWKzYJnwnK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EC8LXbo1OitsbKHTZL4VZYCnTZPTvHPpyrpkYocL3718VSsLQu42EO+qhfKcT1BTyyjw/9jJDh43aMjcVDCK6eVC6t+RYCVcN+i56FV4BYIR2TreE2nIFeAEJebq9CflOmMU3xtSaOm7NbgSrySXxahDZSwrLwpiXUYUGDCH8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msy6SQms; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368584f9e36so1181635f8f.2;
        Mon, 29 Jul 2024 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722248309; x=1722853109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4070wEPuCK+XBMXivSVC69hgE/A0jjc0lrf2/fMWbNo=;
        b=Msy6SQmsgqk76/2DpQayZhgLu7myCtYG86XPQf+Xd2+xBrUA/idgW2X8vCv9DJ+xBD
         01hlSkRyf35mxIZ1wTwSjI4mKJMZAe7/w+B0JAK26cQ1rJMSQweCeCKKW6aJkbouSaw2
         lvAWRymJg2mTTUuK49lRa7mw6o5OMeezq+1LK8Us2dNDwqrQO4Hz/do9v+ZJElaH1ix3
         0iNJ/F7GZUXB5w7TgiVm8kF0xaKmC/NZhGcRZPIe6MzS7RfCimyzPg1jOOR9GyI0RgXT
         x6XJW+U15k8FKoCi3UJhUZp5jbs5o7dZ4gco35qKVvV/CrJSeDnXHEWNADGVHBosftUs
         E+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248309; x=1722853109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4070wEPuCK+XBMXivSVC69hgE/A0jjc0lrf2/fMWbNo=;
        b=UKnP70yeBJF3E0Jl7zTtZO2QRsH3V1e5o4YdYfQXaDMD+OjZNndLdkIMOsaGyiEych
         2+v93O6egztghjI0SXwAh/+ET9OytuueqEc8W9NVYSb/XtkOx3XFuC2RMiUL0h7Fa/ex
         azkosUf3a2p2xgwZ8sdlPDxPNCdZvc7YP2NlohNAN6/eEXSp82XKktjq+Oe2eBW0bXkO
         T4tTm8ifxxJBZG41fCIf3wvVSugbK9+/kOzn12zgme2BJSOFk8k0K6oqx9vM0kvSR3is
         3tvreIOUtK119Jyp4gE7TR6APW8JgEoMJWrqpliz24QUBhv5hUNxRYMSQ93oIudfcitO
         5gUw==
X-Forwarded-Encrypted: i=1; AJvYcCWybDxnTPeyI4Czbn4FCHyYbDZd5xSQe9jLehzVe0kQ7pObuPUtxnOMa98A74UsOFBiiLZbrrTydMStNLrNlyPKaVu2i2x7QyB7NpCQojDT1uUleufZCpfdwJ/mlqphXfNh3HcK
X-Gm-Message-State: AOJu0Yyr7yC4602RUKp3ylBN/o1nIONpjbIub3BsHQBLUlM16vxJYyxT
	DG+WNcXo/JNmDD7kM63KcabMA3uFh2uVY48YvWQQ6Ddu5fl5GVg8
X-Google-Smtp-Source: AGHT+IH7A1lqUuwH5k0M8ObbYrSicUxsMy3T+JnKuD/B22l4fGLT5uoDvyU5FVapfs8Pb+B9+abbkQ==
X-Received: by 2002:a5d:5f51:0:b0:35f:1f8a:e69a with SMTP id ffacd0b85a97d-36b5d073f43mr7723052f8f.49.1722248308956;
        Mon, 29 Jul 2024 03:18:28 -0700 (PDT)
Received: from [192.168.1.17] (net-2-44-141-41.cust.vodafonedsl.it. [2.44.141.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9b30sm11889527f8f.40.2024.07.29.03.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 03:18:28 -0700 (PDT)
Message-ID: <0b96911d-a6f3-44d9-a273-0e9c71da2e9b@gmail.com>
Date: Mon, 29 Jul 2024 12:18:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: devtree: fix missing device_node cleanup
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux@armlinux.org.uk,
 robh@kernel.org, rmk+kernel@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, stable@vger.kernel.org
References: <20240712094448.159784-1-vincenzo.mezzela@gmail.com>
 <2917e82b-eaf7-4db2-9c16-d164568df1bc@gmail.com>
Content-Language: en-US
From: vincenzo mezzela <vincenzo.mezzela@gmail.com>
In-Reply-To: <2917e82b-eaf7-4db2-9c16-d164568df1bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 11:47, Javier Carrasco wrote:
> On 12/07/2024 11:44, Vincenzo Mezzela wrote:
>> Device node `cpus` is allocated but never released using `of_node_put`.
>>
>> This patch introduces the __free attribute for `cpus` device_node that
>> automatically handle the cleanup of the resource by adding a call to
>> `of_node_put` at the end of the current scope. This enhancement aims to
>> mitigate memory management issues associated with forgetting to release
>> the resources.
>>
>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>> ---
>>   arch/arm/kernel/devtree.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
>> index fdb74e64206a..223d66a5fff3 100644
>> --- a/arch/arm/kernel/devtree.c
>> +++ b/arch/arm/kernel/devtree.c
>> @@ -70,14 +70,14 @@ void __init arm_dt_init_cpu_maps(void)
>>   	 * contain a list of MPIDR[23:0] values where MPIDR[31:24] must
>>   	 * read as 0.
>>   	 */
>> -	struct device_node *cpu, *cpus;
>>   	int found_method = 0;
>>   	u32 i, j, cpuidx = 1;
>>   	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
>>   
>>   	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
>>   	bool bootcpu_valid = false;
>> -	cpus = of_find_node_by_path("/cpus");
>> +	struct device_node *cpu;
>> +	struct device_node *cpus __free(device_node) = of_find_node_by_path("/cpus");
>>   
>>   	if (!cpus)
>>   		return;
> Hello Vincenzo,
>
> If this is a fix, please provide the Fixes: tag as well as Cc: for
> stable if it applies.
>
> Best regards, Javier Carrasco

Sure, will do. :)


Best regards,

Vincenzo


Fixes: a0ae02405076a ("ARM: kernel: add device tree init map function")
Cc: stable@vger.kernel.org


