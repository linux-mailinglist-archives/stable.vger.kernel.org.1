Return-Path: <stable+bounces-163453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6359B0B428
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9503BE02D
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471B1D27B6;
	Sun, 20 Jul 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdeVuf0j"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B617A30F;
	Sun, 20 Jul 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752998750; cv=none; b=iXnHeyugSaywTsYoge6G2tSU8EC75+qGC9bZTqUo94Y6HQmGueeKNmTOOnkt2duHwyiiIhXq1lp6RTDe5/n8R7N7WXsbQqoU5lvjN8T0oODbJK7Ntvcnw/ACOozDQ7xRE2EvceAGBW+9AUA3BMsEgeoNlnMoXiyEjgM2UBxUlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752998750; c=relaxed/simple;
	bh=nBfUxGaO6llmDH/VJU09CFKoRpwqxviaZJVge2tryvU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mjzcWkD4jOkggJpRoKjVy74/M1wfm1eb39N9iZXih6JXrUqF+gmkH7it4AiMtEUJk1WM5Yz9KeDvXzHTYAfJaSXlV9MndQqnC1v8aQ/S7xqokPmb8YEwmM+ox3TpJvtRJn+67VUY75MWR937wIpLhjJdUjcXtAzy911UpSbDvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdeVuf0j; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b16a0e38so3034447e87.1;
        Sun, 20 Jul 2025 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752998747; x=1753603547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W6POjTCMc5vFHm17LQlJiIP5lnqBte4hoCPNHHXBAMQ=;
        b=fdeVuf0jUl0uArYT6HuSntBucebWJ1sTb5sezAMiUxYLkNxp96hJ2qSJwK9jBmbotU
         s6ldeGFwgHc/viFpopX17BEDPakUs51hMqqwxpH+3GcknjQwfQW8o7vzHYl7daBL3air
         piFAkknOaijnWpmIn7ss+Yu90ibzkhlv3Fu/uXH5lNF5eH3q/PmyoMkvMbE0MQWcoT59
         +OSzbi9zzUq1yngOvrcRps/mImNb5f75BD+QkeKgq2wUYXi80UwmKtUtkeJqaeGYQivF
         rSVnFJq91HSk0cL/boDqdZWRVVlluLr7SIf3BEvolzdNo3obmajeZLISJYqRh7Dz2KtA
         PGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752998747; x=1753603547;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6POjTCMc5vFHm17LQlJiIP5lnqBte4hoCPNHHXBAMQ=;
        b=LC5OFGaKtFjABOkfLFizqCvj6J5xgjUTrsKEhsLOUQcFv5NPi40ypucEWlXYoW0QZp
         8dstx3jJ7lIBbiSFQ3IklnFr8jT0nr95J6RVPlWoPSmi2eRscOhRGNWLyUShFblKyUX4
         cwFhRsUD+LvP4cgWR5ttd+G8TFGQlzlOr45C6ELzzYI0yu5aXylYigv+uHYXa7u1A3Ll
         NWSuBKXc3UsrrfKzGyNVEYzUlUGlKXzjsTqZ2v78/oHh27Ao3a5Ha3uh3UMiKYKKK6jB
         L+kferqx94t7KMV3JwNpof28L2jBTxMwqKCzYLH4Gs9tolNfAZdjt4P6K9LcL9ZGGw1z
         5tow==
X-Forwarded-Encrypted: i=1; AJvYcCXWGi6yd7L2slVr2bF71Rs9YH/jjV0fBYU9IQk7OL2mq1JDfdKX6TJ1x21ylYUplnBYNy2ndVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTbHaHZoXSKSecja2cUWUMhGaBiJBv1PkMK4FwCj4zJFaxxGs
	Pj7+6WzcsPT/DcR65JwHpgsaNUD4s8mPw5hR2xBoZKgzVAG1kJtrafgm
X-Gm-Gg: ASbGnctNZ5S0A+ZkQ9OWflInQsrIQRa6bEQeMsGzRwD7nqFQCfBU1gMjcjfpKtUnmVH
	HJ6qv7jwDOFzI8tAcZJrsW1I6CTUNU/4V5AY/+s5CsEx2qfOzgn7GeBiYlUiNOD9aZ+Io9PwLyS
	fFc3jkaIfOSX5YuwM4bI36gYKGF73RSe+WO38Z6n6uMpxMi8S6Gq1TOOHYNAfic8hKhcsm78aX3
	84uApf3poS00B+1FJ7gwRmr8jVbIrudC/zR8szmJe29ZFJXY8Jljd3DShkPXk4qy08+Wa5fkCwk
	53bCxqLVp5kazz8DIygTIXlxlW9x/1lEH3HKX4++casygxZ9fJJmpDWWt81Ao0iTM3ZzMqSvddw
	gtLkxTrOpBsQsWIIR3TU2JXWe32rt8Lj3+JyzttXpnZ2ddmorF4XE0oSz1A==
X-Google-Smtp-Source: AGHT+IGc0DYxlnSyWcPXw+OO/pa2EPi8q0f7cbZXWr/l+AOdrxjGZ9PIUWhQyNBIyqeAqE4HYGtOGg==
X-Received: by 2002:ac2:545b:0:b0:553:2868:6364 with SMTP id 2adb3069b0e04-55a3188e3admr1522359e87.33.1752998746133;
        Sun, 20 Jul 2025 01:05:46 -0700 (PDT)
Received: from [192.168.1.89] (c-85-228-54-30.bbcust.telenor.se. [85.228.54.30])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9bf3bsm1024636e87.40.2025.07.20.01.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 01:05:45 -0700 (PDT)
Message-ID: <7a86086f-5b3b-104c-f06d-4194464d84e3@outbound.gmail.com>
Date: Sun, 20 Jul 2025 10:05:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v4] char: xillybus: Fix error handling in
 xillybus_init_chrdev()
To: Ma Ke <make24@iscas.ac.cn>, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20250719131758.3458238-1-make24@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20250719131758.3458238-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 19/07/2025 15:17, Ma Ke wrote:
> Use cdev_del() instead of direct kobject_put() when cdev_add() fails.
> This aligns with standard kernel practice and maintains consistency
> within the driver's own error paths.
> 
Sorry, to the extent it matters, I'm not acknowledging this.

This is merely a code styling issue, and as far as I know, there is no 
"standard kernel practice" on this matter. If such standard practice 
exists, the correct way is to prepare a patchset of *all* occurrences of 
kobject_put() used this way, and replace them all (e.g. fs/char_dev.c, 
uio/uio.c and tty/tty_io.c). Should xillybus_class be included in this 
patchset, I will of course ack it, not that it would matter much.

In my opinion, using cdev_del() is incorrect, as you can't delete 
something that failed to be added. Practically this causes no problem, 
but as a question of style, the kobject_put() call acts as the reversal 
of cdev_alloc(). This is formally more accurate, and this is the reason 
I chose to do it this way.

But more than anything, I find this patch pointless, unless someone 
explains why it has any use. I'm open to new insights.

Regards,
    Eli

