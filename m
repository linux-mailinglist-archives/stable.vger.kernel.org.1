Return-Path: <stable+bounces-73801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BC296F8F2
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 18:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AF81C222CF
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCFB1D363A;
	Fri,  6 Sep 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qfAUdljz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5291CBEA6
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638453; cv=none; b=C6/55RwcDt4KHVZ6tZhF+HqyEGUhCNMPjv5RmRBvdTeCVtX8lL7amuK6V/fXc8WN/pzP28woyPubWa48VWb1Uv5rsviiWXzS8aYlosOk/vMnyuRpzQlFsmOPSqGFCvebzVMW80+Q7xHzbSrZp+d3FsKuHP4/e86domhpPghaMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638453; c=relaxed/simple;
	bh=FI2hw+6HcjnnxY6LjbMOiMJt2XjJYF5zS+t74ASRsiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZRdxs/TFdFcwlgBRpR2tAUDuHMKagVdsK3zyjBZZSvqYuQdGrLDc4yNIDaK/AvakjIKsaOXpCkejN5UIFtLBmmaCcKeAUfBoL99jIQ8QiDkbMz3TTytiW/c/aYwLWIg2GOJBQqqBDjj2kSHXBRJVWsIURfVZGC1GVnH+gsUubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qfAUdljz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2054e22ce3fso21547915ad.2
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725638449; x=1726243249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fumQXNe9T3zSTl+3b1d/T/4RSkPo08KSVg60ocgmDKI=;
        b=qfAUdljz0/RCMEcDqzNMXvS1ErKF3gDt3yzErd+nO1JRQP7Dlk6fT+4DXjL42O/7AT
         hq9sujJy1AlTX9pi1Vo+mE0rFaF6RTuLN2QKo2qwFMQp8OWmYmxR9A+xhw2Y96pGV9dK
         SkFbkpnIbXj7bxc/uMRzYl5uFEoZ6Zk5Tt5nW5HDxVEUqt90S74FkcB9YNyPXuuW5/+l
         TR6eAFtm1RFqYZfKv5sVhnPMfSR21BZlF4nyTpXxngbwOkeB966GqqOlkHzb4CCHv8Ms
         dfHg0hrkYm0NEuBaUMSWqW/tbeQ8TWs45rKQytuTSlPBaL0Vl3hVoywV0v/csSlT1kv6
         6pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725638449; x=1726243249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fumQXNe9T3zSTl+3b1d/T/4RSkPo08KSVg60ocgmDKI=;
        b=p4yC5ea73NKuoU3jehLfvXRvNC4BFL76ibSaItLZW2N4LvZIWQGlKxgTVmPlAHpBnI
         d8+GaDK5gC2YFR40PEQMfFv6QkPCJ1C0Lt4K8/JTL61Hdb8W2Yom5L6chOpzsTFJzPNi
         etqEc8Ibq6CMf2qjTwMQvwnptiEufhkvHsuceMI+u/etNr/4vS4zxR1vd9/hJqllmWyS
         ER7mlVb9a1j1cVbZYQmKF353CaxK/fiU0pBC0ZlYKvQezwEyog0SfzmlRNhdyJD948Wh
         xmHXNaAnqPtq4pimFVdFzk80ymrVZzIRMPSqCbDkdRO81FVOvC4pjBboGtRe07D1R7pa
         AB7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9w5hmZ7i4p8L5nvSkXr6D2n/bITPqQpQAlXv2nHczziUZ8BHxxernnuJBYHa4HS/M2fxVdo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytsWGMScMdYC3cSiMUVuxXCjjhayw9u5y/iMiADsxL+daipf3e
	ruspAIIxV70xFL/4Y0ukwycMEiPOgJN5Zj6bnZfv9ogd60xLDXE+8gmdY/yPvxQ=
X-Google-Smtp-Source: AGHT+IHGMgYDK+TViSs2t8VPMBLmgxXoD0EfCk0s/Nd4Z9vDo3MMdA1btm26NnNNOtl5JTDhdKT3lg==
X-Received: by 2002:a17:902:e74a:b0:205:7b04:ddf2 with SMTP id d9443c01a7336-206f053b49bmr28195355ad.29.1725638449415;
        Fri, 06 Sep 2024 09:00:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9558cfsm44683805ad.101.2024.09.06.09.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 09:00:48 -0700 (PDT)
Message-ID: <ed995e2d-23b7-44c5-b064-2927dc20420f@kernel.dk>
Date: Fri, 6 Sep 2024 10:00:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/sqpoll: inherit cpumask of creating process
To: Felix Moessbauer <felix.moessbauer@siemens.com>, asml.silence@gmail.com
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 cgroups@vger.kernel.org, dqminh@cloudflare.com, longman@redhat.com,
 adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com,
 stable@vger.kernel.org
References: <20240906134433.433083-1-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240906134433.433083-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 7:44 AM, Felix Moessbauer wrote:
> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
> index 3b50dc9586d1..4681b2c41a96 100644
> --- a/io_uring/sqpoll.c
> +++ b/io_uring/sqpoll.c
> @@ -289,7 +289,7 @@ static int io_sq_thread(void *data)
>  	if (sqd->sq_cpu != -1) {
>  		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
>  	} else {
> -		set_cpus_allowed_ptr(current, cpu_online_mask);
> +		set_cpus_allowed_ptr(current, sqd->thread->cpus_ptr);
>  		sqd->sq_cpu = raw_smp_processor_id();
>  	}

On second thought, why are we even setting this in the first place?
sqd->thread == current here, it should be a no-op to do:

	set_cpus_allowed_ptr(current, current->cpus_ptr);

IOW, the line should just get deleted. Can you send out a v2?

-- 
Jens Axboe


