Return-Path: <stable+bounces-43152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60928BD678
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEA51F21C3B
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF5256B76;
	Mon,  6 May 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uZOeA04D"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAE15B563
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028368; cv=none; b=FCkbMO+7NoKaQCHPLo/fizAADSERYYDT1z7sCNdEM6VBCGEvazsNeV1nz4yPgbIBpFBXPoyORkB1mfbTxcxS9O9BQh6h82vkcI8rbbIj0pzAGjVH1ks+EdHZVTe8WjS+yEBi45YlZLGF/zI3GTKY4hux7zbwchuhdwxQrogoV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028368; c=relaxed/simple;
	bh=Ra7Miwbb9yPi6B4tuG1EBgnpXqVweIcnyAzdTu2yJCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lm0uM+Azj5w2TZczHGktRlYhgYe5BCa7ll4G1bPDs7PtmTUaiJeIYywZ/irhdLOYrrF1kTw5Q9DfbIFbRa3d6J8qMaMUmXcjnBK9z8lpc7QYgG4QSh1B7Let/u+ZVs34WDHpMmp9wjneP2oLCe44bESpwOsojjN26gUz7/KmMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uZOeA04D; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c96871b854so1120892b6e.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028367; x=1715633167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhxBCPAz4wWF9t0XFfk9CyGaDUlTNsi+7DnFiAKDa1M=;
        b=uZOeA04DV08H9kABHHobAoHjcwvPab8PwMTYLU4wYYqD8kvyx9QSv2w1h4gKVF69nl
         W7RuGPr3wDA+RNvnjVPfke7XA01//T71z2c/IZNu2KZdXt55cPqy/1MwZcFYhtNJUxO3
         2495e6T8wXEHeervLrUpYmoj61a6MbvUNhHgrPsdk6+BnadpTLbe3SWGCmEUVP5PP1O4
         uYxfAOe4YVhwYMDtM5kCbW/TV0mLHzt+fb3I3G31XXXsHpRTFlCMWReyoSYHfkneb5dd
         QpRQjRgYNvID1ltYvCYIpsKFUEDYzWPAp8Y7YuagUb3wLm7MLHOwbIhHl/kLzPs5y1aZ
         SVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028367; x=1715633167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhxBCPAz4wWF9t0XFfk9CyGaDUlTNsi+7DnFiAKDa1M=;
        b=ORSG1Kk2kvw1dZSsgOvqki1nRBs4Xwco0IfHHvbYWXrNxnLW46kUAXBwkCIA/jmc+q
         McWZ/T8T5fp5VKi4fVVDP+3cVJeYB2Fo20hfhsWeTMrCA8H3bpN/3SGeul8kEqQyKjGp
         XaRdSRTADuMeIwfXqXy13R/WN5F4HGQVQjsYHxMc5b7r+5a0TpY4l2MN/bdiMsrwBq6W
         eOKjCCqY7btw3xm97rNlAswjTW0u6s+qRX2zH3BADN8/8L929G14AyQzlwfW5yLAoAXT
         qCS9Hy0O9v/TVPgU9wS0goFsSx8B1gjmFbbbrJ9VGrDRn7RfSfbQr3ICW5ch34Gto1SY
         6L5w==
X-Gm-Message-State: AOJu0YxwbIoKsrklIVs7WgpgNyRHKZnYY6oMjDgc414zOIlNUcwNBj3k
	NT6q4BIDeUsjEzBuhafB6eK/LZ5mMY5h+ouoU07gX6QPxFrWpmgxf0/hG1pECasj9nmFqs2/b+u
	nroo=
X-Google-Smtp-Source: AGHT+IFXZgVHM78pXiMoiyFgIS8YYtb4TDGY7DOjp+zZGz1pCVm/F1mHx8cM9UEcimuqngqlG7tjeQ==
X-Received: by 2002:a05:6870:5708:b0:23c:82fd:46b7 with SMTP id k8-20020a056870570800b0023c82fd46b7mr13594645oap.2.1715028366643;
        Mon, 06 May 2024 13:46:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id fz23-20020a056870ed9700b0022e9d283a9asm2116419oab.56.2024.05.06.13.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:46:06 -0700 (PDT)
Message-ID: <b01a4f64-9cef-48b8-9334-79428a2ab664@baylibre.com>
Date: Mon, 6 May 2024 15:46:05 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: move msg state to new struct" has
 been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193020.271958-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193020.271958-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: move msg state to new struct
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-move-msg-state-to-new-struct.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 


Does not meet the criteria for stable.



