Return-Path: <stable+bounces-100888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49979EE49E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E80A165580
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D01EC4D2;
	Thu, 12 Dec 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NPE/sJrC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C31D934B
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001277; cv=none; b=EGyskyf9mt7E4SLbfZLpmAG0V2lEo/Shty71KgDH2g39pnyuRjIL7O0fuxe4YQmfLOZKMTlt40O4PrgxYCGiUx6XIbi/8nFA428sYrs5T8jS2OF0+IKsSkm5bzWnc/ac2pkYSGVh8UXfS8gbHN80magAchhZpGOBg58dwdX+K1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001277; c=relaxed/simple;
	bh=twVGA8ShMbfollzhVXm5TME2LGjGdXv4aWH/WyMId1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8TGEh8bIvuZeKleCtw4YwQkDmkOqMzPsm9tlZHV30msoHA8OX+DV7O4TFfkNsr9gQOEsB8RWRsATo3/cUGcXWQy17MM+1Ac0iX4oxeQ9ml2X5Cix2aJRa0f2ZvkvvbD+e7zTZ1LD6WrTOZpGsyhSPRSqPuPRLPHuRV+Zcs1s1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NPE/sJrC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-387897fae5dso34621f8f.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 03:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734001273; x=1734606073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z/A1NNbk9LFsqFidYQef1aR/SJg+4pPqIce2DoNjO0=;
        b=NPE/sJrCjenz0+TULpZOiJ8/Py7nKJm44ghR44c9/nIjJF8xkFrXmDDu2l7+A/zwdn
         9W0BVNsqJMITJNZZDuhLF7q7tnNeqpgj1Jj2VDeMEbsrGFKPENgWgqPCFgkhPytiEOnG
         bXMnZL5ipWDsazC9+/+d+gISFpnXQ/Eg65sLqmHsLIqhQfMSLH4UHpXOFWTMgxuVA+Yz
         YQqsXhT/ejYa705nwkBLsnxDw9lEFFospQU+NpfANjeZPpNSxO9iJAxKCoo40SDsgTk8
         chp91AwXHAVy5ZEqYkDfjxg3HRlfMYArXzQGwQDXHXTdkQpKQ6C+p03KjQk+41rOanq8
         uPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001273; x=1734606073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z/A1NNbk9LFsqFidYQef1aR/SJg+4pPqIce2DoNjO0=;
        b=AWoSYEAUTnSeJuSjPhSuqmInpUsDyk+nj2V66QC4IoH2UUpT64RUgnuk80vdxjqscA
         6hIOGZHB1R0fML7BLmJS0VpH2tFT0NLvVtmYvnXPSgG3XZ/w1K1EijK+ixppw0Z8iYZd
         Qg/EtVP5gNjx135xODLv6KrSwAbJzYVeEvRur4Q9WwDB2sXzJXIOnIZhMIbGklqHyFGh
         ujBKaRlu4awxhwzxgad54A2d1lyoMQKffLFvdBVcDK+Xl4WoD32nhUpLpv9C5VEuJs/l
         kdmRg7booQIYJKXEU5mGK4FWJ/c1b6BkTvqwWPMa1LlDC2wRndMDANjgPcsMeyUMcVkp
         Dtcw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4bjQnNGC9L/K+Zb5wkhxurv5I5T+GIAKppbsB82I5XOT9KFfOvQ0aDI2oP/GpCnId84Oieo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIPS46Zzm0WU7qFn8rG75WFfdPEK8w1SE9lRYzN+BG0zGJpJs
	b+aC3W1mbzEkULT8P2Xk6UIBpbqP4+jTM+m685MTpqGEwTq3QfzZJFR3Tc87HlA=
X-Gm-Gg: ASbGncsJWBO3vqseh/biHWzF+g6kWV9RJ0Usjn+R4WrAqzlE7il22ssxFuldb02E5Kt
	9J3bgkfb4YnUtzCQ6FgJjdSiE4IA2IOWyXwrFvGjBXnn0mEZhWPJYSVlxkW3gWn5ZoJ98OgfNAQ
	pJWgJzv65/TlSOKfszYEOLVekAS9DYgoB2NKeGSLpUbs5KZ3BAOG+5JFAdUVFNN6H7PSVDxsrKi
	VsSFnIb9F5cw5GZ/epcPqtgZ20CEsylkb1jj+/mvi/3vVWTpDh0jrl+mc4v
X-Google-Smtp-Source: AGHT+IEeOxzGb4p627Kx1TCAYRGi4FdbjCU9Sj1IwO+s4vfay9ExoJ+SwiuzUucyu1JxAhP0rnzoaA==
X-Received: by 2002:a05:6000:1f85:b0:385:faec:d93d with SMTP id ffacd0b85a97d-3864ced38d3mr1982606f8f.13.1734001272654;
        Thu, 12 Dec 2024 03:01:12 -0800 (PST)
Received: from [10.202.32.28] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd40e37fdcsm8085274a12.53.2024.12.12.03.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:01:12 -0800 (PST)
Message-ID: <a6054a83-2dda-4548-afd3-96dcea453159@suse.com>
Date: Thu, 12 Dec 2024 19:01:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
To: Greg KH <gregkh@linuxfoundation.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Thomas Voegtle <tv@lio96.de>, Su Yue <glass.su@suse.com>,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
 <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
 <2024121244-virtuous-avenge-f052@gregkh>
Content-Language: en-US
From: Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <2024121244-virtuous-avenge-f052@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 12/12/24 18:54, Greg KH wrote:
> On Thu, Dec 12, 2024 at 06:41:58PM +0800, Joseph Qi wrote:
>> See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t
> 
> And I need a working backport that I can apply to fix this :(

I submitted a v2 patch set [1], which has been passed review.

[1]:
https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#mc63e77487c4c7baba6d28fd536509e964ce3b892

-Heming

