Return-Path: <stable+bounces-124543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16E4A6362A
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4180616DC6F
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF6D531;
	Sun, 16 Mar 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r8mzHAO9"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721C5228
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742137718; cv=none; b=ZEtqLnXgjIkLNzpGnesOup9aeknYrzWO8cAU32IQssbqXAnPHMTzWhR4Bs1TDIXn3vGwmvG/j2g9RsF2NyuAEbv5bTNikmqZoldAQ23GEs1jGl6gG8wN8hEdVVPr1mWo2XuIw3lgMcSdjTPXiBkchyozxXzOCYDUgEe7xlqArgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742137718; c=relaxed/simple;
	bh=12QpNJnwK1A/GZcytfQKTbYcR3t3UwBylMivGRWSRSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0TDx8zbzrCBgWykqQJIltoVXpaj5x/AEJ0ZolurSEhR3VbuYtet89mfmCazUenOvxl1ECDt4QGzaIlpCZK5vwQDKCNgfptAa2odAbkJHIHEpl+encYodxqggvOfKh7t3JLAuuYHPkChXOPq0nYi77/AG0fJb6ECXsdGlBh4blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r8mzHAO9; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso37257695ab.1
        for <stable@vger.kernel.org>; Sun, 16 Mar 2025 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742137713; x=1742742513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDbKF1QiuVmaMLTNA1HU+GkZklQOjtsIXZ5afKlhUfc=;
        b=r8mzHAO9eF5zaoRa7ObKr3xNrhhfKQmBojYgsgZ7lM+DUJEgtoRKckgtquRVL5Etvl
         Sb8N6fr7HX7KqnVTETJUCFdMTvz/bT+AJ0FTgKBVamAvHI6IGRVnFFzHc8XLavep2e2r
         cZslWVbMEEoaLKsU+bbBM2ZpByblKea+eBwstqkmMRy7r/bl3xr1gNtzmMFcdpiJHZjB
         IJedJ27uB1veVrasajN5xFtC3s9YgV85GtFjAJJBzGmAODNRUWHpb79IIvtJMjjOzPhS
         Rf8rWqtCXApai6l2Wqe1noCGlBdABC27m6crLuibtVVXGS3aEQh7MCi3wwXW95n7Xzpb
         d5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742137713; x=1742742513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDbKF1QiuVmaMLTNA1HU+GkZklQOjtsIXZ5afKlhUfc=;
        b=h81AbTipqvv6iIyNhv7jYD+rbZiN66M+LDa4W/N5SJMqOJEzS1FfOjAb+opx9Tq4tQ
         6zj0nuXoaCVi4ErnEJHhMiY9WwQALYbA5QPOaXaNIEzwd/9dR+903+uJIlHn5N9jA7Yj
         yEHBwM82QfVd0maaSJnOegZassKjd1d+nDFpEblk3L+HCXfrB5tRI+3wPHJqZCsFg3Je
         fNWc3hgMrmaAiFAyszJNmAHB5r6sBIi24AOZewnSKgTnb8bpoZcxbyOeDw4EJT2E2aws
         koW0qva9iDzog1btthJjltgjMkAa9hrtPEarNYyhU3KThEN3Lb0epRjOu/GWkf5U2URf
         96Ww==
X-Gm-Message-State: AOJu0Ywca9QvZTzR5tRtZRSN2w0b1jH6aPQqYo46RFF3ERPOnRcLJW9R
	2FP+o+hVbBZBoLDe25J2pk8J2gocZzVGSKuOeNqjfPP2oX9LeNIK/zxlod2foDbhzr59XtbcCPi
	R
X-Gm-Gg: ASbGncsaTFvdO0ja4QU/5fC8q63H3kNhv67uySInE3NBoUaH6ygQVUJno4+lxOxsl9p
	0EthwidfUEwkFBMIcCRhq3haLbQch+U0cVEiS+Ub2DBd5bnu+pNQg1+Ts4fsoJSAu/GoFt/jg4c
	majatxgL7CixSDiz6+F+tk4zMMrBkehKRNTv4auU2Uo21JhjWHYEQfiFxEctvLw+lAiVGFcdErs
	VfcPdxnimgwymJBRmCajdzW+HXg3xkXI0Btc44J462hjkp4GgjeJ+KRFp6Yw9jkNb0lEOTuqLlL
	R048qw0ol5szujvT//BVdz3ic2uI8axgl7YoLIIeO5/mEBXPcl4B
X-Google-Smtp-Source: AGHT+IFzKUcvu/2Fso24MzBWPZf6+y3f9Wr1dGT9oQadMzZhyIjq2kdGAB5K5Zr3yiTrv4PCEm0+uA==
X-Received: by 2002:a05:6e02:1f11:b0:3d1:a75e:65f6 with SMTP id e9e14a558f8ab-3d483a6eb23mr138344515ab.18.1742137713088;
        Sun, 16 Mar 2025 08:08:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a666ddcsm20897865ab.18.2025.03.16.08.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 08:08:32 -0700 (PDT)
Message-ID: <97581a2f-7272-4fb1-b1de-de54bc6b5a01@kernel.dk>
Date: Sun, 16 Mar 2025 09:08:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1 io_uring mmap backport
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
References: <9a29cdcc-c470-400a-a98c-8262a5210763@kernel.dk>
 <2025031600-unexposed-flyaway-eba4@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025031600-unexposed-flyaway-eba4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 12:01 AM, Greg Kroah-Hartman wrote:
> On Sat, Mar 15, 2025 at 06:59:55AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> I prepared this series about 6 months ago, but never got around to
>> sending it in. In mainline, we got rid of remap_pfn_range() on the
>> io_uring side, and this just backports it to 6.1-stable as well.
>> This eliminates issues with fragmented memory, and hence it'd
>> be nice to have it in 6.1 stable as well.
> 
> This and the 6.6 set now queued up, thanks.

Thanks Greg!

-- 
Jens Axboe


