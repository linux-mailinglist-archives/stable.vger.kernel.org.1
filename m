Return-Path: <stable+bounces-43456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C675D8BFD3C
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 14:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668741F2410D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8B3EA71;
	Wed,  8 May 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGZ18gdJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250281863C;
	Wed,  8 May 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171713; cv=none; b=o9y6h/oNwM9EM3NKnECOFPICeUlHySmTbYXii5OFlsD2qDWUkOg7rQTnAtbrBw3ayiC33xywWX0q9GVSjzFF/VWJcwa5j1SRVJNnJDTDoUnUgDARNCKclEvjkbB+NXFqyGCy6oA1mb8gmRQwMBIbnXojpSZkVd97keuDXRDTibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171713; c=relaxed/simple;
	bh=i2JLkQ5wqYLV4moBdZnxKtMAd2an5huS7pmMXcoLDiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKi4pWRKVG/rX4H7WweA0j31D/S2VP+TCflPLalLA8qXoPS8r6RtcEaiPjFJU3HKdE5lGwKH8N8wcSiR5S/i3OLVVFXPmf4GUhfighHvZmcF9vHuFQfD91bp8S28OGJPlzW8DeDN8wXYuujPG1HZ4YcwtLTKEsCmYc5jduooTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGZ18gdJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f45104ef0so4679569e87.3;
        Wed, 08 May 2024 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715171710; x=1715776510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGqJENKGu2VDw1JweApXY7Cnx0SgkltEUbGukf+76pw=;
        b=FGZ18gdJ/SAGTTsqWoU8XSnnqP+YjWXvazdqI3jkPGbfzQ+yApaMyd6MabtEWBP3Hv
         QIlTezCX3QPm9Z4fAAyYxei3JU9q9gfnGzCM1oCTuwxGxaTLdu4FDvyjUEXKhOy4X5io
         RBZZ/aImoqMdHdtCgqjGL0yNrqukxsZqEl4LaxVTekBGsMBHqjh/DlttsTTDYfupQMXQ
         V1+lfneGoxGN8vOlygxrSkm1+WYew4uMr6QnCBgwjVQfBcxKp2Ebc7t1ZoZEhyDveDTP
         URHBe88Y8xmwWjFfe1hlFl/RnfWOUrSj1+v7zYpfNM0tA/6jD27eikrs0F+lDpHFrb4W
         XYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715171710; x=1715776510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGqJENKGu2VDw1JweApXY7Cnx0SgkltEUbGukf+76pw=;
        b=ObUWbU6p6IXJGh5qyaQeTHLpBqfBFh7+Mi8exP09eNmLiI887wk0AkWC1B9knuAwXF
         a50sYCg072NLzQAJuqh0mGkXbD3Ly/Kkg/CNAwpQ6YMXwjeHDrEp+L1uZ7AMZKasahkk
         laFupF45LJkLpuAjNbKLflFIg0G5mkAH2cAn+Sm0qPAXBqxwA645HdOpRhmsNNHpmLHF
         gissLBrmQE8k5NHsXgxuHtGCaMnR33yiA/b7y+BdaQtlnfrYcPdqRQ2a2HFuqZkuHrHV
         10khfL41UkL/XzRkp8gEPfkxdPw9/fHEXYK9ZbLXqZ9DJE0QbfSEk6xy661WR7rAOYQg
         QFqg==
X-Forwarded-Encrypted: i=1; AJvYcCXsMUDPBTdSq6ScgXzB9LjzxBnDNweaqyeQaHkj6ywlP7ARxE779/dRua8pBVsdLxN2JcYbwSLS78Fny/9x803M4w6dcOmstbUOEop8bYj5iKhV9NV6V6FSV2uBWxtrJYe93cmf
X-Gm-Message-State: AOJu0YxYYqx8xMmwFv4EsWJ5AUZRbHMEE3bToN8q0juGxw9bPVpx/m/2
	rrveJ9jLuLLVqCLk6RxYdobvXUYajrPUk+w5uR+YrjfGb5NQD6jCsM0oTiv2
X-Google-Smtp-Source: AGHT+IGEhgoz0oL9QWFm1uMJ3wjDKHCYFTJDY7pYc8SqD9sY6qgDMaPrAs6eZsiz9jKDcFCAfaIogw==
X-Received: by 2002:ac2:4c2b:0:b0:51e:11d5:bcaa with SMTP id 2adb3069b0e04-5217c56e432mr1461968e87.39.1715171709955;
        Wed, 08 May 2024 05:35:09 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512060200b0051f0225e0a4sm2492021lfe.227.2024.05.08.05.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 05:35:09 -0700 (PDT)
Message-ID: <b57f8ede-5de6-4d3d-96a0-d2fdc6c31174@gmail.com>
Date: Wed, 8 May 2024 14:35:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.9.0: WARNING: workqueue: WQ_MEM_RECLAIM
 ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM
 events:qxl_gc_work [qxl]
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 David Wang <00107082@163.com>
Cc: airlied@gmail.com, airlied@redhat.com, daniel@ffwll.ch,
 dreaming.about.electric.sheep@gmail.com, dri-devel@lists.freedesktop.org,
 kraxel@redhat.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 spice-devel@lists.freedesktop.org, tzimmermann@suse.de,
 virtualization@lists.linux.dev, stable@vger.kernel.org
References: <20240430061337.764633-1-00107082@163.com>
 <20240506143003.4855-1-00107082@163.com>
 <ac41c761-27c9-48c3-bd80-d94d4db291e8@leemhuis.info>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <ac41c761-27c9-48c3-bd80-d94d4db291e8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-05-07 07:04, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> 
> On 06.05.24 16:30, David Wang wrote:
>>> On 30.04.24 08:13, David Wang wrote:
> 
>>> And confirmed that the warning is caused by
>>> 07ed11afb68d94eadd4ffc082b97c2331307c5ea and reverting it can fix.
>>
>> The kernel warning still shows up in 6.9.0-rc7.
>> (I think 4 high load processes on a 2-Core VM could easily trigger the kernel warning.)
> 
> Thx for the report. Linus just reverted the commit 07ed11afb68 you
> mentioned in your initial mail (I put that quote in again, see above):
> 
> 3628e0383dd349 ("Reapply "drm/qxl: simplify qxl_fence_wait"")
> https://git.kernel.org/torvalds/c/3628e0383dd349f02f882e612ab6184e4bb3dc10
> 
> So this hopefully should be history now.
> 
> Ciao, Thorsten
> 
Since this affects the 6.8 series (6.8.7 and onwards), I made a CC to stable@vger.kernel.org

/Anders

