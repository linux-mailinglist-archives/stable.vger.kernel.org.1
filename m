Return-Path: <stable+bounces-92796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A79C5B28
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A50F1F22C0B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BF201018;
	Tue, 12 Nov 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gIEqmWtg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BE1FF7CC
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423409; cv=none; b=mr5xwBvan3ZJzcD2G3MBjVD9H6HHfoV4UXkzkL2CCdexcTTvyCTFKSRFJ/PHWq+EHVTGNVAKj0OLgDtq75RVpzmL/t7+3VqHIAOWx5wOaI9MNZ4Iv7/lSZWZhzc7PBz46WDTKuYthr5D0Nxq8NYPgm9DS92RMvfk9QSPwvJMpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423409; c=relaxed/simple;
	bh=JLl330e2j7tfWty029veGRRd9qUDDTtseDUSMpn1H7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9BlCIV/y46534ZTQTNnPayPXOuIgfNVPn4K3BP34QxCUL2xluFdusZZtWfi20qG6XX/hpwbiAvm46CBsPCWH4lYYEgqagGOjkEJ0VDfZClVelNhLHNxgHGqYcK/z9IJlrO6zMzYgkgph49tZQZV+N9eCftiWmx37TJGb+V+IiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gIEqmWtg; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-295d27f9fc9so359723fac.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 06:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731423407; x=1732028207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqlcEqKbSmFEnYDc07f8q+V4wAaUlOtiLge+40toFCE=;
        b=gIEqmWtg5ZwdCUjK5PPT88v5ix3Jzx3GktebX0kfgAhorjh+nSLL/qWaCnVufd9xWG
         kEbvIu1hCP9MLZjbg35Zr2JskePzExbeUEb6dx0lYEQO22Zs27JjwJDz4nCk9TyoEwi9
         lwSIXNWIU0oa1wKwAAy8OTsOZ3MaAPvsXLQXcz6qTgurxbwXcarPzLjLaiNQEYvlAfms
         MUXY118tLWeyt/bzq5/cjSPyDP53Pb4YhmUSnCQx1DQKAvSgXD5CpTTw5LfXY5Oks7ME
         HKlTdy4fv2n9OFMcEgiGbiU4QZcf1cwpO8oG3074A78bH+BHXvryoHusMADT/kva/AA+
         T0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423407; x=1732028207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqlcEqKbSmFEnYDc07f8q+V4wAaUlOtiLge+40toFCE=;
        b=VJ5ZWtBX/AJoCzr/S19l76JTmFSHQ2nfo8CB6/KR3Z0DIgN9b+Cd/lE6ALYUGtDyxE
         5WQJDWg9HQ+bZSxO7UBpJBVnQWBZDl/9ZdIiGf2EzVQkr5KEtzqApz0Qr+j/HVLDpQLm
         cfBQguiVvy/FiiDGY8ypk9iDynuRewPnd7tFAT81K2fYoo1128GxAkaxTyLTKDWga3mn
         l26/YbdbUzZuUjyNhgJckZsEhEBjBf4+FSNH8pFNJMou3ZUy0fOIaHETVETKtyqbcF3B
         Ifi7aDfTIAkUWDBZjUqakgwgCHgmbtmax+JE+AlwsQeA+7Wp24nEb6omFsdruIUH83Nv
         rX+Q==
X-Gm-Message-State: AOJu0Yw91ZfyOoIMV6Rug4jJAxlexQhar2KhOue4v2n5PlMAJU80sCnG
	EfCAP0rrHZA6U8e6W2iXBJfbssRu/8wMUCbDC5wlh/S4Y1/cD4CtP3we+TF/hRA=
X-Google-Smtp-Source: AGHT+IEMBWlFc7WJVNM4x8SzafjvBUCN+VOD9k1aPxZXuwHR4elNWocsu7xAYERFQWQ8a7+VNaxpOg==
X-Received: by 2002:a05:6870:b61a:b0:286:f24f:c232 with SMTP id 586e51a60fabf-2956033577dmr14086225fac.42.1731423407293;
        Tue, 12 Nov 2024 06:56:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546f4f22esm3441825fac.52.2024.11.12.06.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:56:46 -0800 (PST)
Message-ID: <2f03db3f-b6cb-466f-8ab0-0ce73d31e46a@kernel.dk>
Date: Tue, 12 Nov 2024 07:56:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] io_uring: fix possible deadlock in
 io_register_iowq_max_workers()
To: Greg KH <gregkh@linuxfoundation.org>, Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, Maximilian Heyne <mheyne@amazon.de>
References: <20241112083006.19917-1-hagarhem@amazon.com>
 <2024111200-glimpse-refill-3204@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024111200-glimpse-refill-3204@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 1:39 AM, Greg KH wrote:
> On Tue, Nov 12, 2024 at 08:30:06AM +0000, Hagar Hemdan wrote:
>> commit 73254a297c2dd094abec7c9efee32455ae875bdf upstream.
>>
>> The io_register_iowq_max_workers() function calls io_put_sq_data(),
>> which acquires the sqd->lock without releasing the uring_lock.
>> Similar to the commit 009ad9f0c6ee ("io_uring: drop ctx->uring_lock
>> before acquiring sqd->lock"), this can lead to a potential deadlock
>> situation.
>>
>> To resolve this issue, the uring_lock is released before calling
>> io_put_sq_data(), and then it is re-acquired after the function call.
>>
>> This change ensures that the locks are acquired in the correct
>> order, preventing the possibility of a deadlock.
>>
>> Suggested-by: Maximilian Heyne <mheyne@amazon.de>
>> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
>> Link: https://lore.kernel.org/r/20240604130527.3597-1-hagarhem@amazon.com
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> [Hagar: Modified to apply on v6.1]
>> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
>> ---
>>  io_uring/io_uring.c | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> What about 6.6.y?  We can't just take patches for older branches and not
> newer ones, you know this :)

Hagar, thanks for doing the other ones too. Greg, they look fine to me.

-- 
Jens Axboe


