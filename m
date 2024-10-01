Return-Path: <stable+bounces-78541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE7898C095
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE53B29FA4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339C1C9B71;
	Tue,  1 Oct 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cn6ZpmDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1F1C8FB2
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793788; cv=none; b=MA2cPaY/DGW3wZFj8zytzIIs3CzLnqZcFRXqa/i6kWrhVAoeLYtyMGiTcz2XiZOWNhl2QCEj2JpC3JpWfArckn5+rdOBK0wBvSD5zmBMoPeNMLZA1lINoCcBY2ymMBV1iELXa+OQQ/rbsR0VzXAD9wGdIBg17Tjtj8T9DCn3UZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793788; c=relaxed/simple;
	bh=YqFKGoWQnkufFcN2SEwu0+10kaaUuBMn7cd3+kx5FyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arrR90DoNNlJFklahV8xCqCnGolNgTEz4hMRhc0HhfDpVhZw51jr4PBwY2N1tMRI+4FMP8r1Ni2gSm4ktjBkYMBU6Pxhig5W5ijurYCrqQPQRIUuZ/zHOhewS/Sl9qeTacV5XEuPhcBHBWrKYwDHasceOQECmiiYpZmAVpVAAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cn6ZpmDg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso281254539f.3
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727793786; x=1728398586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqFKGoWQnkufFcN2SEwu0+10kaaUuBMn7cd3+kx5FyY=;
        b=Cn6ZpmDgVl8SekWoeN6ozvQj0i0WIKUoiR/TllfJ4TnnmkEjjUMD9hJSHEW1AW/AyY
         PhEO8rWj8PhTM30ndS05CVfLIClm4BEo8+nBMR6k3kIpXwhjLX7OL1lc/CdUbukdBbwR
         BquU1kJIobzQPXTFkHYDa7HlYOvIYKI0b46fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793786; x=1728398586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqFKGoWQnkufFcN2SEwu0+10kaaUuBMn7cd3+kx5FyY=;
        b=CJWHfMcA64wn2Gw/2onPjLVCbubQXEhXNY9i34I3/Wyd8icsTP2kwlw7od9MGbLEuG
         j/GSeD6ht0Kx3mUOnulAge/3gSWxXgtFsJl7xaEzW70yzpXrp9opd7R3ScAcu+sof83I
         mUMmceDG0AGF8pm/HNiJQksOiL/MQluHuccrTxKn4rM08UiX88ZZcbXb0aFtm8rpb1nE
         5QkCfRkLMKppUHUDq1ewUKcuGcC8tMK9WIPNu7vIINH8KxcgE3Qfe2Zzz6Pkhbb7ye1C
         4FCNoy/OAOalLimgWSwHLmdLWSV+V9OR4QCZii2xaTGL8CXm2N+Z/jEa0RI8xvsHmIoy
         60DA==
X-Forwarded-Encrypted: i=1; AJvYcCXEn1e5/sspbS1dvH1GLNOw7Uw/WjpFtFZXixq+2dHuIeO8mS3zfyLpuj1WNc6ajLaEVdqliaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CVhYCvcIeIrMWdveUQ+mtFLtGnCIRujthd+LVXAnVED6Co4q
	uCgHUenRQDzWNNSVBysxrJKf0SDXEB0QpYJ3I3z34rhnky/1gEgI+3l9ZRUao4I=
X-Google-Smtp-Source: AGHT+IH9iQbGNsaiW1M3YgTbNj0WdLULnmrYykCxV/hHL8lSXmOdjXn8BCs/zDd0M4RzR5yGC5bWsg==
X-Received: by 2002:a05:6e02:168f:b0:3a0:9fa5:8f2 with SMTP id e9e14a558f8ab-3a3451aeefdmr137892965ab.18.1727793786284;
        Tue, 01 Oct 2024 07:43:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888871e92sm2678908173.81.2024.10.01.07.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:43:05 -0700 (PDT)
Message-ID: <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
Date: Tue, 1 Oct 2024 08:43:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 21:56, Jason A. Donenfeld wrote:
> This is not stable material and I didn't mark it as such. Do not backport.

The way selftest work is they just skip if a feature isn't supported.
As such this test should run gracefully on stable releases.

I would say backport unless and skip if the feature isn't supported.

Does this build on stables?

thanks,
-- Shuah

