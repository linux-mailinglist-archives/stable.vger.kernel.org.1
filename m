Return-Path: <stable+bounces-152573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5AEAD7963
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 19:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CB817B06B
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D21E5B68;
	Thu, 12 Jun 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DXkUhiBn"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E91DF751
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750592; cv=none; b=Pqatnibm2BfsDHIBtbGnQFtiX99GyKqzVDDT1KVNz1D4frHg6mWIQrbcMhQP3q5iPH3kygFp/dLo8GoIFoX21sgSxCTOB4kc7Zl2YvGj3EkbidNZZM2wMuzb/ZtIxVyefjW02Yb7m4ITH0F3+Qnpbna0YFBObQ8RCl9gRmBCdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750592; c=relaxed/simple;
	bh=kSnGKw6ppdH16FyaoLH44jXvnqQIZBHIS1VOymDZFJc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uMMpINsFInaUbq10u4wbB46KKMS+nqq8pj6rTuWaHM6uLwioMku40IkMqesWtCBDuTkYOwzcRc2mam6QqLXe0msP7Kzi4ZstWv1wrmZt0SwebWLiNZTWxGgpGimBynyQfYLtOhKrTcZeOXErRHq2yIkulezA/d3FaS+kU4zTvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DXkUhiBn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ddc9872e69so4927865ab.1
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749750587; x=1750355387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N5G4x6YlA32+z52B3jzCE12E1x6h5Dn5opdE9UV79Q=;
        b=DXkUhiBnHBvtgCi+uQf6IO0q1UNZ3vMzh3eCKyXfp/hqYSqfY2KAakJiQt8vCNoor1
         6J9znMQQKEcq2gg2hnL1Iyxll/uX4oRNtnkzlZAIl/CI5KMJQjA1Bxf23g2Vi3hPzw3o
         uDXnpm8Uqi+3+qZucaliGjb0+0w/yJwARy1Ztrul0g/Nma/QnepBiFn7dVqring9/iN2
         z4QEL72ezK8I8kfJ+JbyfENUhndUFJfGa/HnOQj2iw0z1BfjoD+mVy/G9P/oJs8FMlpU
         wu8CacwSteqCtan9MKqLjreCeCLIOMbAlcDiAVlv6Lr/iOoh35agXF7o5D5DsTvEbYZ8
         4bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749750587; x=1750355387;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9N5G4x6YlA32+z52B3jzCE12E1x6h5Dn5opdE9UV79Q=;
        b=bLkqE5peN90z4QNWXldneUaFHk5krFnSsOr7uX3jQP/KiBDyHXZwDEk1OKHaXhSY6a
         2BHniEmZS/HIoZqTzkn2P+hp70K0nRPiAj2JY1xczw6vj1FXjA80xOZF0obTfnadosga
         g9T5kUgb3EBG3GdVHR873Lye2eIaS23HC11vS09gxm8UNaSRP1b+zuvsIsLtTjVZ8Av9
         HWRDvimxS7a+sCrfCz+Hmugzi1vHC+mZ+bztv3jbtrD5MH19IGc0lAKtg0CLEiLSznGD
         n91oYKeC6SyP/q1sCuDH2VqQiNZoxPwT46gUPjyHDfjPJxb5zoFA+pwkVAzR4ZisKIra
         oNCw==
X-Gm-Message-State: AOJu0YxpGtgXMtTrOzfLhRXUd2xpQl1hGAF0sb8Q3ggkC0uEH+RZJQIs
	jnGTRwNELX+LS8y/rVp0CdJnlq5q4YaUdJvMJ/oBENf04u8yt1bbFtCKRoURsHhbrnO17JkSTiG
	MQBZD
X-Gm-Gg: ASbGnctKWfzFUqE/1JPjyzMA9m2Pa81kQ57UhVIN8d1M31bB6VpSmUYoOPIR/+BXzUC
	565eiZylfVGeVTbF7PXhhvi90CYQYkcR0oDQRGsZdtHmsG5DW0qU6+uAMd19h6ql3bGQbsW5/IQ
	cITFLh4tE5nBKVTXSqQyVS+6K9puA68mkm1UW+Mz26ybekdBlZRnrvukKMbhTzWeahkrbjOQLrc
	cRvgVETIiyrMy0Ij/08FPsROKRlvC/Z9HOrZn6Gz3idw7Fbus2uPMVST4MX0ysCHjtkcOVWMQrq
	nwYd3AU34JTEY3Lx52C3cfk34fCmfS9wSM70ejSSybaKZ17RPQ+qnhO/Dw==
X-Google-Smtp-Source: AGHT+IGlAYxMgiCot64Ouvv9P0j51p4J5Nmd3YIf5XquOjO/6DZKFhoaWq2FLDZMBmY1XAYdhuyoNg==
X-Received: by 2002:a05:6e02:2482:b0:3dd:ca82:6fc3 with SMTP id e9e14a558f8ab-3ddfffcb445mr10366615ab.3.1749750587562;
        Thu, 12 Jun 2025 10:49:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddfbace949sm5091945ab.33.2025.06.12.10.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:49:46 -0700 (PDT)
Message-ID: <313f2335-626f-4eea-8502-d5c3773db35a@kernel.dk>
Date: Thu, 12 Jun 2025 11:49:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Revert of a commit in 6.6-stable
From: Jens Axboe <axboe@kernel.dk>
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <906ba919-32e6-4534-bbad-2cd18e1098ca@kernel.dk>
Content-Language: en-US
In-Reply-To: <906ba919-32e6-4534-bbad-2cd18e1098ca@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 11:38 AM, Jens Axboe wrote:
> Hi Greg and crew,
> 
> Can you revert:
> 
> commit 746e7d285dcb96caa1845fbbb62b14bf4010cdfb
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed May 7 08:07:09 2025 -0600
> 
>     io_uring: ensure deferred completions are posted for multishot
> 
> in 6.6-stable? There's some missing dependencies that makes this not
> work right, I'll bring it back in a series instead.

Oh, and revert it in 6.1-stable as well. Here's the 6.1-stable
commit:

commit b82c386898f7b00cb49abe3fbd622017aaa61230
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed May 7 08:07:09 2025 -0600

    io_uring: ensure deferred completions are posted for multishot

Thanks,
-- 
Jens Axboe


