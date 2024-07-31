Return-Path: <stable+bounces-64721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A70A942847
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3E31C21C3E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E41A76C1;
	Wed, 31 Jul 2024 07:43:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB716D4E6
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411806; cv=none; b=n3tzlMswMbcNd80nh6C4QHTDusJNmBzn0J1ImIsk9M9zE0Uu3jTW1h52fW/MhvqBGNG8JL7PH0dprdX3njst5oQRGBYlzWDTfod2kfXnzrcN0fqp5ZW0jEE5LBWkaBt+Fb7rw1G4qYDiatP/mcdEiLhdOdzoSIJNd1thzjKUec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411806; c=relaxed/simple;
	bh=+RxIbRKdxBoqFwTrEcMqyr1qTFEZLj1r+9/p28lMvnE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tbFttqkz5VR2n3jkiYq+BwQvJ7BTjpQ6Nf9NuSzulbYucMAKI5+AYiCe8qMwBTq7+KFgCShpuFjTlBbNvc/zrmFnN1dQKkg3jvfZKHbsFFzU27yHxDw3Q29Q5Y4LL8rV0jQMKs1pzsaiA9ka/9upcG0mJ+4GYaztFZtChhs+iYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso7886327a12.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 00:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411803; x=1723016603;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu1EISL8BN9yanPqcsi5XTIGcrHTZAMrGA+WEofj3pE=;
        b=T8B4wCiupZG3pnYKhzeLoTLvsotuvV5qsv1ERY8ZZqQxxJqXXYS6cN7PV+ZmtlwsdV
         +X/swJmaBfH2Z8QoJBim6f1Aus/SnO3lWPE9cNPeI6QlAYZl1/p/Ki0Dlvinep5R8kEt
         fSMbpbd3GwL2HLOq6IS0hyD0Fuq74ryQVazqA4qPLnB8FT07b20T0bfFzwjw8meNobsf
         Kzn62lqBprXgpojF44D30WXPvle1LH8jtW2rtYAlQbAuLYaNakU5BkWVSgEd8YRA2+QK
         mJMVv6+9rCWkFe54KI6/RfvuT6HD3Gn40JUlrEpHhMGVAbjxJO4ix31zLs86NCDnicAn
         7cZA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/HAzMIC06luv7vhl/BEL5DoKInFXd4zVOB9ux03QNEZO5w5j/uzjuAWO9cReP5peZCEL8vOJEW3agaOwELiA9d5jUKFi
X-Gm-Message-State: AOJu0YzaDUjpmCJPqhrrPg7/5X2fi1CU45o1A4Wq2nkDk3WJ6qSM+iI8
	QkEQY6siUG/5+evBqV7hjn0RmadVQ6mLhRkgQN5GmnKGQYCD7+9D
X-Google-Smtp-Source: AGHT+IE4/ttD3GJt957JgBhXxJvnGVVx7VCFsQ7PrQvOcUgOUqBmlVvKqefdIdCHtvpIPn7TgUub6Q==
X-Received: by 2002:a17:907:eaa:b0:a7d:2c91:fb1b with SMTP id a640c23a62f3a-a7d40175b2cmr1070901466b.68.1722411802540;
        Wed, 31 Jul 2024 00:43:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb985csm732989666b.212.2024.07.31.00.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 00:43:22 -0700 (PDT)
Message-ID: <6f60115a-e69a-4ee8-b79b-cac016cac55d@kernel.org>
Date: Wed, 31 Jul 2024 09:43:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmap 0-th page
From: Jiri Slaby <jirislaby@kernel.org>
To: "michal.hrachovec@volny.cz" <michal.hrachovec@volny.cz>,
 stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <3855f3cf-9c63-4498-853a-d3a0a2f47e7f@volny.cz>
 <54b32f3f-1e5a-4429-b81d-4ab91ceb6bcb@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <54b32f3f-1e5a-4429-b81d-4ab91ceb6bcb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31. 07. 24, 9:39, Jiri Slaby wrote:
> On 26. 07. 24, 12:36, michal.hrachovec@volny.cz wrote:
>> I am trying to allocate the 0-th page with mmap function in my code.
>> I am always getting this error with this error-code: mmap error ffffffff
>> Then I was searching the internet for this topic and I have found the 
>> same topic at stackoverflow web pages.
> 
> 
>          char *zero = mmap(NULL, 4096, PROT_READ | PROT_WRITE, 
> MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>          *(char *)(NULL) = 'A';
>          printf("%c\n", *zero);
> 
> still yields 'A' here with 6.10.2 w/ vm.mmap_min_addr=0.
Yeah and mind LSMs...

-- 
-- 
js
suse labs


