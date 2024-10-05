Return-Path: <stable+bounces-81151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0BB9913BE
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 03:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBBD284864
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BAAC125;
	Sat,  5 Oct 2024 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g/VGASgz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F517AD4B
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728091349; cv=none; b=DSeVRW/ciFdUO8Pp3QqiFxA28CSTI5Bix5nxeE+71oNAoIoyqkjdCr8YCsfw4Wvhi5tkxM0swMynhXZw1dlqKj+EvYznIiPeIR/JOK3gx8pnBDC3ohJAQXKddrEMuwVsQkswI6oaZhyVKNV8Y1StekS53wh1WSnY2IZQD9QHYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728091349; c=relaxed/simple;
	bh=7HWjQznNYb08ZHhERH0pXjoZ10eAQNT8u4oZKb/GxHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBfKAJFt7aRSSyG1N9e2Eo8YpayZVg5s4lwudcEwc7xAkKRE85CUIBAqeO3rxyAVP4aKDt1qs331k2xMcM/UOdiI1ja5LuPu0I0tRRwX9aiKZPv3AeVGwujGmcFTYj0f5IpdvxWp42+wKfF2rQUPLSJ/4Modiv/7q4Mltj5qQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g/VGASgz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20bb39d97d1so24092585ad.2
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728091346; x=1728696146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwUOdcuwOOimjt9LDoWFqhrfU+jsI9408hnb1NpCV18=;
        b=g/VGASgztpVWh/Q34nB21H4XTjutCak8T2NPMILUOQNJJHuQ6POnyFzLWjwtMrbUOI
         auVn6dSXGuDKoCx+ox9eKIlnVQzbDKrMu4ymmPXS03LY94AGo3ni/DhEmu1IenLFvz3q
         QhLy/ek5baRgZjuwoojfsc7sLZKsEVTmQl/TxfGsGmkj+O6MoBLEcKmOopOLGICMwm5g
         BJxzTxrGW3t7MqCiEXMAop5UpPgaMTuZiTjruo1ij7+onIaYd73qXqxrwqud/seADRxX
         F/cGxPVpveWLriTiPpia5FtROIxUp0wLf0z+Aq8ZgRlTNzM7vVV9Uu6qb97p+9r0WkZI
         c7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728091346; x=1728696146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwUOdcuwOOimjt9LDoWFqhrfU+jsI9408hnb1NpCV18=;
        b=CJG0//Y2vCpvDqS8Zy9+qlYNUeuZ1In597EPZfUY92YJSWJ8kDiOepu0nFeG7KlGzB
         Vk3D9klXmji/w5nJ3IcR+XpljqMlAQjZRKveFgHJnRQdtW4z1RjO9OZl/GEJ6UuDocn/
         cuP7h6y4FNlLSxP7CvuSWrVaEKQraYqGMUaEvja22RhylpOutNdCcBNwHSje7Kh5UNgK
         ewkd4ZnI3FpAGB/f8GqMCRgykH9IR1FQ1+MHhdBYIbAq8uPnDM2fl32RvhKv8eO/4MkY
         gmpWPAse1fhDsfLTjp52VypSlFRM2bDMRjNPFZuDUFVgQV4muWbmbD43qtXCZxKZ3Kz5
         YUZA==
X-Gm-Message-State: AOJu0YyUL1KjvOLOq6WCi4VPjZab8Jalm+z9KtI+S7G/oa4qD3zzIz5i
	OP8IwYZMbCi+3BmeH32AmVZkggDZr63jP1xHFPzW/7Ug9GrtXhw/zH7m2rvZqRo=
X-Google-Smtp-Source: AGHT+IGoA2zRhIDde1IwSrkk3aqJJokT9h8Mgql1pe2fjGK6eSANH0L734iLI27o7bzT3eXlzqcZ3A==
X-Received: by 2002:a17:902:e851:b0:207:1708:734c with SMTP id d9443c01a7336-20bfe022d08mr57774625ad.11.1728091346106;
        Fri, 04 Oct 2024 18:22:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930715sm4447135ad.145.2024.10.04.18.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 18:22:25 -0700 (PDT)
Message-ID: <65e41cfb-ad68-440f-9e2b-8b3341ed3005@kernel.dk>
Date: Fri, 4 Oct 2024 19:22:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Stable backport request (was Re: read regression for dm-snapshot with
 loopback)
To: Leah Rumancik <leah.rumancik@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, bvanassche@acm.org, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
 <20241004055854.GA14489@lst.de>
 <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 6:41 PM, Leah Rumancik wrote:
> Cool, thanks. I'll poke around some more next week, but sounds good,
> let's go ahead with 667ea36378 for 6.6 and 6.1 then.

Greg, can you pickup 667ea36378cf for 6.1-stable and 6.6-stable?

-- 
Jens Axboe


