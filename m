Return-Path: <stable+bounces-128548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E515A7E053
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D193AD56F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3DF1519A3;
	Mon,  7 Apr 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IdD+cUeV"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742B1A8F6D
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034182; cv=none; b=lAbb0WTe3BOWsTrIluPJfv9YvHupzpvop/TTmbMpYzV782rJW3a+U+0IIa4w449DpMX6v3coMaNU7PquuScA5Dnm3+7VDF8mI3Bw3/IIUWoGMmB8S1q/DhcG4YOJv1e49F8XnTbyZlMSSV3+d2QvO8PoBpZyVv9rIkG+qvUxGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034182; c=relaxed/simple;
	bh=SaxZcdzXx3KbjuP1bJzGfywn0grGUgP84yTm61Y+Q3o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UKrfaukgcDg8wM8N+siCSdfIuFXf5jBU0yA+TVDByErVOcMxUpCjeQRGEeqMsgii8nQDmqI50FJ27vChXTbpaJQh1Txk8hO8brAmA1b9jWH8zJe/VahapfaI3T1AH9aV3k9IMOQvNw8oA3jPWCIct1i+COV9ee91TuqjSW1DNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IdD+cUeV; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86135ae2a29so149350839f.2
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744034180; x=1744638980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba91YpsK4ieXMwcuDD0yhyhdRMwuhonXZAN6afP7CdQ=;
        b=IdD+cUeVL42v3QjZChdsgY8rlE99wrsjJkjoDOz9ny/xWnJbVYuWaEm8KXgQhHMU0r
         3EgEkBGMBAcDSHQhgDMTd4rEREpZSAGt2t+RMaGuyVw2B5vmg/Azd4IJl9/G7f3qAGNE
         Gx+LrEYX6o14eU6TykJlCwTibBfzB/z9U3J0utYDAmvjWinBBvSz1jD1kD7p4ZCf+Sy/
         CY1YSUiJMyqadv/NlryBA18SG/YGFgkBz3KBi287BoWLzajLndQIgRqRU3OlfjgufcvF
         wmVSSePZ1ksFhjnvb2h8Jes3/urLgketTwjFBTrdEGzYsvPTFjK6tNmbmctXZjpK2+VN
         7i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034180; x=1744638980;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ba91YpsK4ieXMwcuDD0yhyhdRMwuhonXZAN6afP7CdQ=;
        b=fRW+btEsoctggONJYObcfuYiiwKImlPLiK2SacWWfaT29Nfdq3tbsZgakg/8SCPl4T
         S+ViBGeR1Rd6/3ABJwUkbpSf2qK8GejT4FNTjIS+LkgcGAV5bhRpDbw1Ak5+IXI+H07D
         lBAmOIkPIXfIUUh3T9AEAiEd/944M6Tu14XnW2DLxhFmnF93/wIBoitUa3TxTLS1UT6x
         CI59zChJsHBgIJkW1Gj2i879JBoO0U8yDZNMwop3QVqV9IM9GwTit+8sg0l7xguRBD3M
         a8HcYI4ZgYoqJRO+9xWjB8CQChJR3Sns1ctguuefjqnkqAKuBbFI6LMqCy5cYL6f1uxe
         BLKw==
X-Forwarded-Encrypted: i=1; AJvYcCWEMG90arCzIiV5ayCSvnVD/JSeuhYDxwxC4GXri+VSFiCzIAFnqOV6T81mxnNVRKjy3U/6xC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZaPk/F7dwQTZKbX5l3x/LTpxdzIu2HrulM0WqdMj4lf8c1OK
	uwvmS9+IbAFkf0jobWQ9NLcNVam9Vq4kjf+uOjTHfIp/J+x/LTXXQ1MRqHyLmN6oJJMQvkUJDNG
	c
X-Gm-Gg: ASbGncsZeAvgFvxVRd62jdP0OsZrNCrkMEL9pFUX+sPYGvXqJ1CPF8uo1Hi6NnVsO8D
	cxFZfkN3oJC7l/bSLGvKcs/AJJ40Pp9vcHPRSa0ws98/SfECHsCBp2TuRauXj4YaamnFbx5ev37
	iFKm6r5BalBin2i33dnWK2ko1nG3hWptam21US2E95xurVYqLojX2x/7Kb0BRTpYtPndiY0mmdH
	PbIDlo+01IETCtaV2w+kMJCSNYjjJdned8CCknv9DjMzzIV97Y7msl21QxmTr25kXLsK6JrcwLJ
	l/FksV8uLd4AhGDvPm9f8sFX9Kw7qrnyR0NDogto
X-Google-Smtp-Source: AGHT+IGwXNskYEwDi9nFWD50m5xxWcX+rGHZjQixdxHZlJUjt9+i3jKjovGbRFkUS7XimRh0aRPizw==
X-Received: by 2002:a05:6602:b82:b0:85b:43a3:66ad with SMTP id ca18e2360f4ac-8611b465418mr1344617439f.8.1744034179874;
        Mon, 07 Apr 2025 06:56:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5d40990sm2357439173.110.2025.04.07.06.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 06:56:19 -0700 (PDT)
Message-ID: <c31bd917-2166-468f-a998-da44d250b274@kernel.dk>
Date: Mon, 7 Apr 2025 07:56:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1-stable fix
From: Jens Axboe <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
References: <0b556f07-d48a-4d01-84a9-1c79cb82f7dd@kernel.dk>
Content-Language: en-US
In-Reply-To: <0b556f07-d48a-4d01-84a9-1c79cb82f7dd@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/25 10:55 AM, Jens Axboe wrote:
> Hi,
> 
> Ran into an issue testing 6.1, which I discovered was introduced by
> a backport that was done. Here's the fix for it, please add it to
> the 6.1-stable mix. Thanks!

Ping on this - saw a 6.1 stable release this weekend, but this fix
wasn't in it.

-- 
Jens Axboe


