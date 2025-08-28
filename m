Return-Path: <stable+bounces-176589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A38B39A5C
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260323BC9B2
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335830ACFA;
	Thu, 28 Aug 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYgngK8p"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FD2E7F30
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377325; cv=none; b=iXigxP8pWZdIS5iL+z0Dxw6ZflQG9nAl0So/9lqx9YXaV9sMsYJ/brCEXEr2rt7EIWwJA1zRCG6NzvC00DKKbvSU7p2Dy/PKUMlJElORh9VxNfiHTs7Su4fU57fuvM34OJ4p1dL/YC1hN5exgXgMmQZku/2410FIdba9e4mPqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377325; c=relaxed/simple;
	bh=YBqvM7XD9rhPf/QZIHMHzzRfeAeDBLeryJu/pKtxx0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiddJlBiar84H9ZF7TLQkzCqMMlTSDpC3HjggDqGMwnbdZjKXIaLyTwkbAyUmvz9/Y25nrORAMZn3LhFEFAQ08Z0jAEoD5LqFT+Z2w42aAI/dm2A0GS2OprT2ijof12LBmtOLDUa6oj/eWjLIvCJVn7YIQOjEDwi5i5/I5DDt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYgngK8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C02piPLI6v0W2skD1ryvCSQgX2iEqThf0fPi4OBy2HY=;
	b=bYgngK8p1RSv9x7c5ZJe5KgbttInzEhPraMsJeKnwzi2X+JnU/GNrmUOcdlbbMeBlb7xQ+
	Vu30Op2+at5YFdl8HZ4bKWioJfw98TEze5PO63/KzRqp8JCRJGC//KJ1/vqF4E4IwgLoRD
	l9trL9jCZm9Ly/1YZmrM0jJZNxVoSaw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-FZx6lyFkPWGGRHOYMQ3jYg-1; Thu, 28 Aug 2025 06:35:22 -0400
X-MC-Unique: FZx6lyFkPWGGRHOYMQ3jYg-1
X-Mimecast-MFC-AGG-ID: FZx6lyFkPWGGRHOYMQ3jYg_1756377321
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c4c2cfso32799211cf.3
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 03:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377321; x=1756982121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C02piPLI6v0W2skD1ryvCSQgX2iEqThf0fPi4OBy2HY=;
        b=w+ERYqQSV5tV4zhVXD7XF8fCYhJ3Fos0lfFKh1hNiSb8ZmIZK7VQU7L2JVrf+7SHHB
         BS0JrzU7AbVvwSl9oFJZE8NsSB/+MPP3+uXRsR09XnFD4G9mqzDuak30fXEaeFDoWnbW
         cZSZEoR5UVFz4UWIwn0nn9C87/qROm2FkZKi0SyHAVSFHPoe3e14koWT1XmP0nNkV29e
         mHHTsaloPQeYJe/STDrZHJfMkpyE7VzXCvtHGkASa6B8LjZMAz5ek3cQj1+aIHP4EtKU
         m2pwH2KL+ahXFxA8FODxsbxy+xgKpSb2YgqCZFkjaB8BZhh8puyPjmfhabRNCCrFF9Pv
         BuQg==
X-Forwarded-Encrypted: i=1; AJvYcCXtdDf7ODQiVSZoRJbmmngdag5ocEpF3rTwn3BQDxqynQPXjK45eL8AJE6E+c5144bIDNq90gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCurE8lu27vddwo/k6YdzhvbMuol0ylswhXxWgJrwrkEdATNF
	0p3gvDOHWDlf/zsbnWlifIdgGhkYkR/5MuSqLP8OEz/bBzjuFdnbNDn/Y6HLI00U/10wiLaft9w
	biRYEEirz97K6nPW4qmOnYWvCxOk/n6JXR0tl1SfiDIdDO06dmyk9u7H4PA==
X-Gm-Gg: ASbGnctzKaVKETxhvgrIjQL8v7ty6TqEYMGD8PQo8ySWvbDLqCnN7BBzpPARPIUcGAz
	/j2tdT5J9/uCC5NZLpaNq7kI49woxmzbww1h7Ye7rySIzO5Z3pJ6Z1fzLUh46/SFNbakrT+E95W
	qJTbgCsvEoJfDu/PCUsuPBk+hHHziILE7KB5LkhbzVzXa3wFjWajooKwJTIaexOX0auzdyuPXg4
	CzyV9v7S3RDJW797PpU59CaK7ybfxs2waZbcthywk3kdoQVNH8bGkzQfL1aVSizxxIHJfmHIXht
	faj118Nze82KC6+Y3uo94u+rRlpQ+si2NgdeNZSLjg/cVsDacEaJAebbUVQfkGxUgRNyPImi1dk
	Bb90fc4Ae+vw=
X-Received: by 2002:a05:622a:550f:b0:4b0:7cb2:cec3 with SMTP id d75a77b69052e-4b2aab47d61mr372948751cf.38.1756377321323;
        Thu, 28 Aug 2025 03:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsh4vekrR3evrfrykNJt1W3/7S1JncvhmesTGIkRdX8pXGCxyUdMsfB9JJjtB2UfPg8BKFAw==
X-Received: by 2002:a05:622a:550f:b0:4b0:7cb2:cec3 with SMTP id d75a77b69052e-4b2aab47d61mr372948281cf.38.1756377320714;
        Thu, 28 Aug 2025 03:35:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2f52f650asm27706631cf.28.2025.08.28.03.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:35:20 -0700 (PDT)
Message-ID: <7090d5ae-c598-4db5-a051-b31720a27746@redhat.com>
Date: Thu, 28 Aug 2025 12:35:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
To: kernel test robot <oliver.sang@intel.com>,
 Brett A C Sheffield <bacs@librecast.net>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, netdev@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, oscmaes92@gmail.com, kuba@kernel.org
References: <202508281637.f1c00f73-lkp@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <202508281637.f1c00f73-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 10:17 AM, kernel test robot wrote:
> commit: a1b445e1dcd6ee9682d77347faf3545b53354d71 ("[REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes")
> url: https://github.com/intel-lab-lkp/linux/commits/Brett-A-C-Sheffield/net-ipv4-fix-regression-in-broadcast-routes/20250825-181407
> patch link: https://lore.kernel.org/all/20250822165231.4353-4-bacs@librecast.net/
> patch subject: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in broadcast routes
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20241228
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-04
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-104-20250826
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

Since I just merged v3 of the mentioned patch and I'm wrapping the PR
for Linus, the above scared me more than a bit.

AFAICS the issue reported here is the  unconditional 'fi' dereference
spotted and fixed during code review, so no real problem after all.

/P


