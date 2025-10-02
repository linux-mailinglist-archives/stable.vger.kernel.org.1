Return-Path: <stable+bounces-183158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD6BB577B
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11514E6A3A
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094E1C861E;
	Thu,  2 Oct 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hXJEFJfm"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1827146D
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440607; cv=none; b=Be5A6UEm6cnRr0mBSbxH0HeEV6rx/txR81n1yNlGdJ7aRU7tKBnOdgP+oN3haLfHlVxqJr220kTaE0NHLqbDrCzs0YIloyaOUGXycNCgmSFvgvMNP4jNrnIzScaYJvgIpqOg7kNLmN7K34uRNNTqyuW/zv4tI6e1yGUJbeoQ/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440607; c=relaxed/simple;
	bh=R7gp+wUEBlsy8TXb5IZ7eoV7BMXWYpGmkv2yG7V6KXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XWjRgE2sBIJpFuL2aMakhRMpeKB52koxM9eyNzFZbyFo8W4KNakMLA1Yrgvxqr+wZiSUSp8iC6ohfP6ziVGv0ztb4WiYBBp80KjCJHrBgenNdmHRG91cAOsOkEKCu51ij5Jh4mmMCdpjSiPVrRsZHi+33nwv8rfrYjQ9AZrgmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hXJEFJfm; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-92aee734585so58530439f.3
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759440604; x=1760045404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLDl83AHQQg8jNm/Vtit4m6V+8FOHWhqpuduZuJjG4s=;
        b=hXJEFJfm60Ele7Kye0Urg1vcoLd39tKGflls9bpsBMaNqGYA6KgJAl/YOnyHGhkJFM
         XTNiH5gMNJw9l3losW05l4dsDWLa3MB4oH3B2ZP10eRQBY9rrA68Mtiz+DRg1kRkcgUA
         bQC3Gxmk8ZJtV5Qzyk/ogzyGM2dgsY8/1cfW1tHBMqGt/GIZrsV3l4Rc1ZWKfUFfJbNz
         Eyn0b+8VTuOs14klR/38ABi+2tigNkAOuSvWKyoFFGot6OCEWOE+H0SHW5arhRYxKPGK
         vDU1LnWqvSyuVp1zP62i2B0uTo0pNmKjwOVtkW7XWGvpYp34U72pvPO7/zersWrMJcJX
         +TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440604; x=1760045404;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLDl83AHQQg8jNm/Vtit4m6V+8FOHWhqpuduZuJjG4s=;
        b=s94tqv+IRXk+rl77HQPHXhTPGiO9hk3spBEGsqU16zS/RRGVpkzgnApW2767Yxp9sX
         KDyQQT8nlidzSPh8LRSWY4Ic7pDxZttXiufzFPMcsKYragofyQKuBzlviLksS/iwbYl8
         Zu9fjzbjRVnLwD1dFZwg9OUYax2ybDHtGaNZnGDCLhrSBhLJMZgkTXC2YjRl6Yo/AlFU
         BH1zcIxj4lHeWyljjN1ITy135uqBnZT/ZwmAUSCdRKuUhFUgwDnqDx3H2fPqE5Dhdmgq
         RKu58L4yJObqoIa/OXe5zszBcHfz+ZpKGJwPkMi5G+DcngIONt+0HPngh43XEAKh4Q5j
         p3yQ==
X-Gm-Message-State: AOJu0YxxNSImK3nxDluGXj+cQIIielKQeopJdjUKw424S7rOBTvxDk+V
	tC095oBDDO2x6NXFhpe7z0kv82Q+9o5s2ye2ij94UI4fJJFmdi6srw9dUjHF4NXpiGs=
X-Gm-Gg: ASbGncudNRGE86Mse4PEKvhwSw3Mzwq+NJyVc6w5OHcirZpjU2jODos+dzQqLNPqByW
	b/CSw8Bn6RJf0r6e8JsDBRY8Fz6zKwq3tDx3o7+X2HUYPV/MoUYrw2X/p153SUmkxT+uEW9LAZ4
	6yHZpiSgxMd19VYOL/+ef9pIiNs3xXcquQfUDk45W1EaWJ6bBHdu8cSfEH8h4sN0WHcMJONMd3a
	LEcv49cbtDa+2yrgCKbi/ekspLMSpzf7jXIG3hmhCcFSibpP6dW93zT45bG2w1nAzq2PbB1BBJt
	pwBpwBbNtgXXIK/Ch1wtpgWE9c7hbNXhg1iEk/TAw/l5iQYIwOvfSH5uZNmTD+2KL1OwrspxREb
	vjpEWGSdZDREhtjLKDqjmQDN2EYwX50gaVxhmTps=
X-Google-Smtp-Source: AGHT+IHxY87feeg8VR7DJ57L7THw1pnEuQD0gg/CzqqgunAYZfmnjkB3QilA5ylhsC2jeajxLrkP+A==
X-Received: by 2002:a05:6602:29c8:b0:887:4ba9:a0ee with SMTP id ca18e2360f4ac-93b96a59d49mr92375139f.10.1759440604235;
        Thu, 02 Oct 2025 14:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a7d81bf16sm119168039f.4.2025.10.02.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:30:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Lizhi Xu <lizhi.xu@windriver.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Li Chen <me@linux.beauty>
Cc: stable@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>, 
 Yang Erkun <yangerkun@huawei.com>, Ming Lei <ming.lei@redhat.com>, 
 Yu Kuai <yukuai1@huaweicloud.com>
In-Reply-To: <20250930003559.708798-1-me@linux.beauty>
References: <20250930003559.708798-1-me@linux.beauty>
Subject: Re: [PATCH v2] loop: fix backing file reference leak on validation
 error
Message-Id: <175944060261.1563810.3419677787520547910.b4-ty@kernel.dk>
Date: Thu, 02 Oct 2025 15:30:02 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 30 Sep 2025 08:35:59 +0800, Li Chen wrote:
> loop_change_fd() and loop_configure() call loop_check_backing_file()
> to validate the new backing file. If validation fails, the reference
> acquired by fget() was not dropped, leaking a file reference.
> 
> Fix this by calling fput(file) before returning the error.
> 
> 
> [...]

Applied, thanks!

[1/1] loop: fix backing file reference leak on validation error
      commit: 98b7bf54338b797e3a11e8178ce0e806060d8fa3

Best regards,
-- 
Jens Axboe




