Return-Path: <stable+bounces-116944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CCA3AEF2
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AAA7A10B0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E413665A;
	Wed, 19 Feb 2025 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5xz0THW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6A2862BE
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928544; cv=none; b=XYsXvNPbt4Ww/RaZ3FDFZoXpdK8fmtC0QtvvNpLsLySdJdtoR2OyYsKgPutNimwJDO/BQHCiApHvE5hPkzoov4AY+PnVASavARF5H5MiZfTTKAHYfuuY6hFnpMjuefnRnShO9ZGXwXppwWc+2eNwGTvDxQaUG5dL852Y9j52VhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928544; c=relaxed/simple;
	bh=VPCUWab+aUzTp3dDUpPCkq1A3cn8DBb+mpRk1y8SSDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5DFn6zOTNc5G7S3UCl5oiEU1mbgaOjYNOruLxO210Cx8v2r+H1470NQxIVuILOq6CV3D+WPCL5xsveu+YXYvQRqwR5fGd+l9DmFbwGGkO+6csHI0aTw1w3SYpETh3BrL61NXRjesDqOyutB6RTU98gkNWQyc7CkzOyb331V/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5xz0THW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so42531125e9.0
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 17:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739928541; x=1740533341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7R3jhZYi++/ByHk1wh0bji6TXKixSvxzAdkrA+htOAk=;
        b=K5xz0THWzZuhP1ItSwIGBHDOarH2joIOvicefhWVcUDgOximL52lYIBMdAUKCrg2wV
         txkC9XKawBs3yULA7/N4IzQU2WDt2zM60+WfGndiOgVUXXc9meOeTF6D2uTFB5aQ08ic
         PKy9FjOfK6qQhlD9blMJpSiddzqJn0uj5LkyTiHk/oR4aTU8TOsv0Lre8mw8+XuPX75T
         1IJWj5j8ar+2pfTygy30qF5U/6w6z39SxYf6w01UfpU1z0QvjMR1oXezkDsu4wGNNLES
         2Am93pAd0JoiCNlSJkGAXosc+40dA0ML7Q9XAZ8JSEPNmivP5uZ0CiO1Rk0zS7BvnSct
         xHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928541; x=1740533341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7R3jhZYi++/ByHk1wh0bji6TXKixSvxzAdkrA+htOAk=;
        b=GhwqJk8SEW/zG60APgatzBFrHWkWMMHzFhhjQNtAZ1IlVDYy5KmQmb2I8nUOUFxGCI
         WW84y32btYtUtghINOTPaHFLWvEZvOCZ89LcgCl5P4jY9fSiBAvJ/t4Of4OomoJi5zL2
         t8fDX3PEVhv8luU0cvOO/7TBFXlAxrvNOenAUjsRFnbwh53jgijBzJwoPwH/zHFLfB5x
         4FrIHzJE9Z3vw39o4sXLsT0MVWW2rqBUAX/VnlM/N143LDJYImis+APkpV5NS7q/OUKQ
         QvbxbyfZYbXLnBbV83RpKF6IeEzbYK5qPwoRweaEzNv6F82Ve8HMoyxGTKBno2cE8j41
         8hDg==
X-Gm-Message-State: AOJu0YxGciJd+FjoX4xxlYyNnwcYmEp9pWp5nZREsFDsh6X4qPoTgr9b
	5B012ASlO09bAfcDOGyfAvSX+TU0709Tm6g3xw+H3FVfA+1nDJ+qKb1JqQ==
X-Gm-Gg: ASbGnctEyd+FAHSXV04AFRQiEWX8AFc+ahKPMICjb+1Pi67c+7+V/iRrt6XgyE8/BGx
	tlTeL2vgxU6JwEGjEoO4gKs9QO+xdzrJxnhS//Ism8aSXs5NmUXD1ZTAyJRlYWEuoLUA+ZPcJkO
	rK/EIAP6YXroA3LM+DC/tglqzB6nqLV+2GD+BPp0+UUjZMj/3ggZh2o2XRj8GrPh6PEVfV6wm7L
	jojOTY5OwW5kNb6g2niEuN/HWUtTOIE0eXCVfF8BaeahFFxKAOr005wBkBYoK7KmoLI2yrwHRxF
	1ZOebDDkvdlIAUf8ftTpfKQl
X-Google-Smtp-Source: AGHT+IHxnavgAVkldWc4njrNR3mNBW88fFEaljuvezAExXTtezglGhkVtvkaPUcGlBSSeIpKr07x3w==
X-Received: by 2002:a05:600c:4f47:b0:439:9377:fa22 with SMTP id 5b1f17b1804b1-4399377fc5bmr44392475e9.18.1739928540828;
        Tue, 18 Feb 2025 17:29:00 -0800 (PST)
Received: from [192.168.8.100] ([185.69.145.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm197065365e9.2.2025.02.18.17.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 17:28:59 -0800 (PST)
Message-ID: <de75fce7-a3ba-4bf9-bd06-c5713eb84fcb@gmail.com>
Date: Wed, 19 Feb 2025 01:30:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 6.13.y] io_uring/kbuf: reallocate buf lists on
 upgrade
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pumpkin Chang <pumpkin@devco.re>
References: <2025021855-snugly-hacked-a8fa@gregkh>
 <df02f3ce337d92947f14bdd4617b769265098e29.1739926925.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <df02f3ce337d92947f14bdd4617b769265098e29.1739926925.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:28, Pavel Begunkov wrote:
> [ upstream commit 8802766324e1f5d414a81ac43365c20142e85603 ]
> 
> IORING_REGISTER_PBUF_RING can reuse an old struct io_buffer_list if it
> was created for legacy selected buffer and has been emptied. It violates
> the requirement that most of the field should stay stable after publish.
> Always reallocate it instead.

Just a note that it should apply to 6.13 and 6.12, can you
pick it for both of them?

-- 
Pavel Begunkov


