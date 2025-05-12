Return-Path: <stable+bounces-143275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB846AB39E1
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FAF863A4B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBA1DED78;
	Mon, 12 May 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HhqdGHQH"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EC1DE3D9
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058268; cv=none; b=VVMwcWJ2JAAAIHD/mYmCdDd3pX811t5RT+qaDCW7JpyiM4eiEO3ClYJgpHifRMgJC4YQplpwuJVpl+d3ylFLcPU8b9m1XMTNDl/vjJRnuEN/xpCnB6b1HRo2GDnyxWa10DygHcSOEbkNc0eeC4wZZt1yEpKhVfdR42q2oR3bxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058268; c=relaxed/simple;
	bh=bM1/Cr7jj2VbiX0lNMr+KcK58avkdChNKjkAtdZYOoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZDfz6dW/A7Qqbz9J1CHp57kPRoQrFO/UCc754XP6M9KprLStacqWp33FPq3ghtkl1uQCDG1QOrEhpvqBrUH+HsOJ+2d0UGsvY47YEZhgWO1qPLbLwH7+vMHvP7SJIOZvvN8Jb8ub9gyBUw2K5ad8r6jNUkaujZMSJNula4lryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HhqdGHQH; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86135d11760so381921639f.2
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747058266; x=1747663066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJaj+6DZIpAVbqemKbgjGzZjtF2vdWa+v8aFibZZ4ZI=;
        b=HhqdGHQHX81n2630JDXQUc9CpVr2MWQ6ijewJOXT6P54viRpd8naIaWfl4buMWGewv
         1BRPjVwcBePjqnsTZb2mfEOi6HHwWWPpwBR1evrT5o/avZ8IfsFz0WcrnOMumXQUUr1/
         4d5LgRJ4YgWpzuXY9RAvt2dPTai3BdyA9KsO6qLzYtwLuySnkUIMN6m3BZLIMD23bV7k
         Cqo1yiBoohq7i61aYGL7683pFW78h7wAgjwesAPcVzA4A+f4JAEsQKYnKVSxn+Dl5wmh
         HPToCdRJG8lodvPrOA+q0MxjD6gA0yl+AM2vVhwssyU2xKqkFwqR7mI4Wz9SBiBUr7Qe
         l6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058266; x=1747663066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJaj+6DZIpAVbqemKbgjGzZjtF2vdWa+v8aFibZZ4ZI=;
        b=JU2E0vtxDHEzd6XWSkkCP3dlYbgDATBpALDuK8Zixgc0yV2MVtA1HbvD1e/BC4H2vL
         7M6rz7rP013x8kHRsyyOvj+vt8YMCeOMAaIYpaLWWB0jHIcxiDmIDT2udicZ2ONdiJmF
         tn8CO7KmnLSP4EzzMSVJXmzd6R+6yLjMEhIJH+cJl9SAA+cA17da7XmeSnbAeVp3XWKA
         IHm2TsGmcFRjKDx2Vysb2wmPobcFP1q71NbU3+jVybbCOMXGdROBp8zeIQahJ+emKJZ3
         tcvCuWBdZmlYO8923MHOPWAqpwVxwj1mthvZ4cHnVtV9ubAJvuCXQRrbltpVViTjVraz
         lZGA==
X-Forwarded-Encrypted: i=1; AJvYcCVPiF8GFfIieoLs96HRyMY8WMC08+c1JjL+c05v6wwXS8UoOLBPaGGjcixHRWLsMla5M6p8VBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2XUqBaTSOy/OVOaFWm0yT3HKQ4grrHqilS8dGhSEAwsNg6OGU
	igK7MNbqgbl1L6SFiRU9r9Sb4ctAcNx6MIiHVGZFMy4FIA994GEMw4/mIWzQj/aibr1FWKkMlHx
	w
X-Gm-Gg: ASbGncsaBLHBsIcqffdfQc+ARx28nZFr+/Pz+txocUoOZIJmd8ZmAPXC+jrqu+Igtvz
	94Bf3msF/NlbJWl9al5mH94vjX/23HKosUFIPM0YkSkh9jwCaY+yS9kSlxsA1WhZCtZtsaYo9hD
	T4+X/mTrOgU85kMDMHn0Jkhu1fOVr98CH07vhmeM+ylSEYC/5LBZTJcxhgorebzklYgHgt7gI6d
	0xhTnFAUwOR+kgdQFUEqfM77oSHeJmdGRDwAj4ckZhzXSUzjF3uwCLc7U03g3HWufClwCjmfK0N
	G7oQuJq8VqbVDMzUr2I8kF9dJsNmAX2s97+VWCCAWZjeFVc=
X-Google-Smtp-Source: AGHT+IFWAsyWolLxmp6VOcBOzYAdrJqdLjMMZRgtHP2uD6XPoZy+m+vbEIz/mvH2Ll1GINke8Bmg4w==
X-Received: by 2002:a05:6602:29c8:b0:85b:3c49:8811 with SMTP id ca18e2360f4ac-8676352aaffmr1684586439f.4.1747058266085;
        Mon, 12 May 2025 06:57:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2ec25bccsm1344087173.90.2025.05.12.06.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:57:45 -0700 (PDT)
Message-ID: <eeecbb73-02ab-46d2-a67f-8e87cb0ad76b@kernel.dk>
Date: Mon, 12 May 2025 07:57:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure deferred completions are
 flushed for" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: christian.mazakas@gmail.com, norman_maurer@apple.com,
 stable@vger.kernel.org
References: <2025051212-antirust-outshoot-07f7@gregkh>
 <a7dc23a8-8696-47b7-bcb2-3d45993b6c5b@kernel.dk>
 <2025051246-cannabis-strongly-7d96@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051246-cannabis-strongly-7d96@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 7:54 AM, Greg KH wrote:
> On Mon, May 12, 2025 at 07:07:18AM -0600, Jens Axboe wrote:
>> On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
>>>
>>> The patch below does not apply to the 6.1-stable tree.
>>> If someone wants it applied there, or to any other stable or longterm
>>> tree, then please email the backport, including the original git commit
>>> id to <stable@vger.kernel.org>.
>>
>> Here's a tested 6.1-stable backport.
> 
> Thanks for them all, now queued up.

Thanks Greg!

-- 
Jens Axboe


