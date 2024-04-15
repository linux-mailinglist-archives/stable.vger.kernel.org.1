Return-Path: <stable+bounces-39527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2E8A530B
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7BC1F227E7
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6476026;
	Mon, 15 Apr 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UsFz5ZBj"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA1757EB
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191041; cv=none; b=pFKzGnbUW8vdVd12le+oGvVqdR6GneWsFA8kTxJvgOX3B8aPXG+OWhYTuUHVGUpk1s1vxQjUmRd3mw1i9s5NVdbbFuF84yDg3FsXT7RbTjl57S4ByhJ0s5paQqS+QuXrf+pqliGd3MXXBC9IlwqhGq+4wbPT34uJFKeRVW0Bnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191041; c=relaxed/simple;
	bh=22680XQ5IuhOHoq85Tvo75ABonxLvwjGtbuOsRyW49Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hONzXQWKL0mwjEjXdoX7uzW2oDXEZKIOE+dkmfQWivWg7XB3N2CaH1qZWa63/9Ek2GH1rS/PIqcX//g4UcDDFdTluLfen7mhtZVgHHWlG5D/ZmRpRTg4fHftjkYFiuY0qXYHMVjEyiDP4OWFSYIecNSHHy+1HcgNgIbWm94Y3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UsFz5ZBj; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso27002139f.1
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713191039; x=1713795839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbgR7ZP2+YUgGP9k8sttRFgc1iMfPX460B3NSqBAY1I=;
        b=UsFz5ZBjrNnBuG9VAJMuXo8gXI1cC2s+p6SGWJ/RUJScL5GP14pc/ypM/NcWRT7xfW
         Q5qpNtzoN7gA2rMLb2z4ICxxInJfqbTQcvxBmaoKeoy+tFdNSwMprSld3YCdktRDgAxD
         HXA1DdQW11R7FXWRxUvMZTVdJ5V/YuKkDngoW3BbZlSbObvo8Dez7wFoXidY/hFnF80+
         2OLNDLAOoFhat3O3jl64/EGz+MErRJKXhIAakzVMoNZvkpTzUVRIU2CQfn71e0PI5q1a
         VdkbWXCsPZ5giSZJn2Vjy4xBe1pvprmYN89bdLg2s4dr1nyymTWNQNsgfsFjS8rmMJqd
         Ih/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191039; x=1713795839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbgR7ZP2+YUgGP9k8sttRFgc1iMfPX460B3NSqBAY1I=;
        b=b3Df525fyd6BNVBRpRiEj2iNN1sNjrTmlX038JT9MXm7/5/sOePEJpZfOyWhTApy8t
         kNZyIzuUaIzYzhnAkczncH6S95OB4BFKD0YamkpenEH6eKqYZDBhDOcg58qN5KBnbNiw
         hM1Bjq9n9hM8hrQr8uqMn6HyXucKIu7gqudM8/IBYeoZ9OogWBQOn9Y+Er68gc+PgtUs
         Lsn4UTX+EkzHVZ4Ad43HJxTXE6FhssJyb7+C03yaveWEQrfrNOhdmoFZiQ/NMKZvWuIU
         DDf2OzlZ9JEEMaDzTHVc/cyaYUrLEp3u90aKe5IgwU+7vMK5omxzTYIHbm0yHZxqKCla
         Qfyw==
X-Gm-Message-State: AOJu0YzeInS/Kza7ysMm7PUCbcu6JQR/kqG08zvzcneEo8AVTRQ/8KCi
	5JaMcYv5YVsbZ2BhlxdWWADcWVAReFoCHbJlnNYhL6W5vNoSUGpyeoAhdfqY6Pw=
X-Google-Smtp-Source: AGHT+IEmFFMb7sScKDf47ZF+H4Oq68lta8v4f1RVjhrB1CVgbdunr64SnY90pObmZtHK4qyFW2Blfw==
X-Received: by 2002:a05:6602:2cc6:b0:7d6:a792:3e32 with SMTP id j6-20020a0566022cc600b007d6a7923e32mr11471965iow.1.1713191038784;
        Mon, 15 Apr 2024 07:23:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e14-20020a056602044e00b007d5cf7cad86sm2807486iov.21.2024.04.15.07.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:23:58 -0700 (PDT)
Message-ID: <5260c6ac-dd8f-4211-b4ea-51da65b0c7e5@kernel.dk>
Date: Mon, 15 Apr 2024 08:23:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: disable io-wq execution of
 multishot NOWAIT" failed to apply to 6.8-stable tree
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <2024040826-handbrake-five-e04e@gregkh>
 <4d095453-00d6-471a-aafd-7586d94a76a7@kernel.dk>
 <2024041512-small-buzz-8df0@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024041512-small-buzz-8df0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 4:49 AM, Greg KH wrote:
> On Thu, Apr 11, 2024 at 10:28:54AM -0600, Jens Axboe wrote:
>> On 4/8/24 3:11 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.8-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>>
>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>
>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
>>> git checkout FETCH_HEAD
>>> git cherry-pick -x bee1d5becdf5bf23d4ca0cd9c6b60bdf3c61d72b
>>> # <resolve conflicts, build, test, etc.>
>>> git commit -s
>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040826-handbrake-five-e04e@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
>>
>> Here's the dependency and the patch itself backported, please add for
>> 6.8. Thanks!
> 
> Both now queued up, thanks!

Thanks Greg!

-- 
Jens Axboe



