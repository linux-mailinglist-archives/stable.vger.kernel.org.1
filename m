Return-Path: <stable+bounces-203403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF2CDDDE0
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 15:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69CF300E3D0
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB51E3DE8;
	Thu, 25 Dec 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LSL3XT14"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932D1CF7D5
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766674696; cv=none; b=HmaJCkqt/0IP+zykNBXk9laurdbyxZo9TyPfKTB29UOtSj2JG3DEsqJ5BEsAgM++FFbuRTDYSL5+A8pjUz8u0leCHXAs0QLsor1zme0Y0nneOjQmTDWL0HcDgzl2EnS8232VTpxzHt66Id8MNpOb5CMmIY6KmtQatz1rmiZKfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766674696; c=relaxed/simple;
	bh=jhTPnm3oFKXz+ipm0uIVJtKtcYoNuBr7fAjHpdYN3Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dizw+I26Da4ULYlxaqbWVUyOxcNM/WaRs4PXP1pN79hUW1ahZbbt1O4/hkM/mKT5I2nobFxcYURmZUpFuioOtvpcIoBhdva1b1bQgLLpRnwoSO6OTFcikP4hNcMqa0doMYuungdcT5duFNV1zD80kcSEWTtc22DVQ51jsETAlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LSL3XT14; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c52fa75cd3so7056947a34.3
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766674693; x=1767279493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hji0XicsQUErLbiGDeZxt0h7DdgSYTr09a/lmErjN3k=;
        b=LSL3XT14eYfRHLYQpmcNNry5SJFcXGyVmrwU50G8uJTjnuWxtyMceIiIquH6tVBDug
         3KWGrDpL1rFXV+ZiapNg8QLxo9tjTOH8cxfIAmV4HqPd1ZYSlIyLtGve+DJt3d2pV8xP
         AAoj/AWdg2I6JA7UBS9m2e0ehRInlDvoFe6pW2rzy2xxuRDKKKh2HUBqCneAEVbHW2ov
         WXVRAW8bJxxvoa51L1xFcDJ1T8yQJk0Bfj4382MQ2633QNkwoP/PRXKL0M1riFroRAs9
         6SSykEu2BgOk1HNWMaKZcO3L7vQZnrju9Gh1/6lTYb0Ry2vFT9O0F3y/pMCJ8Wc0SvPP
         VEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766674693; x=1767279493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hji0XicsQUErLbiGDeZxt0h7DdgSYTr09a/lmErjN3k=;
        b=Xv92R2x9zyJCxXmAVgXg9VG0c2kISqhzmeRrOi/mCyGZBHZdbWalLjscBdu97xVmL2
         XyISwGPtMLs8WOpOmQMZG1ogM6Bd15ZBOYvjK6T2grccw9TIVvrtlEPJwdcQ57T+ZxFM
         EHGlAYtYGSDhViAQhzPCd1niTPGGFAIXZrt1xUHicdyySG4sig4HEf3dA2Cf9qO3SXf2
         pFJVjP26JTbJiffabemra+x1ZqN6Xhs2bL9XcJHNIIutZydMTovBQ8FcXEw6J51/Q5SQ
         OY3UcEGJ3H5P2RXjYBzE5BlmMCpg4Zk6zu4AA0ngymzIKPdnnnj/3iS+hKI1GylHD2mJ
         T5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWJsyURjm9n22+Ln9IVg+szmX9Qs51SNgPTXUsyH1vyNf+cqb1r2InJvJiaIT2vO4PtbdIHR1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ts2RUk17nPGtn54rGq06xSqjrMYIrMiAGR26BSgyU7kP5x3U
	H6e3HfEX3/2w7sbtt9BLaZO+Da4nBs1nBEhSD+qT2U+oLjdBf8jKq8i4n9juUEth6Nc=
X-Gm-Gg: AY/fxX7wvCSQx1BatlN8/6TyoicD9RHAeE1VgCGGgBHoYe4Q7w7c+OvWIqjl2OOCbJl
	2TsK/xWwIwZNuCLsJyEJAn2k4lO02mawvgysCynnfIGIFXxIx1WAsfFpbr0CliMm8uNwYAh69HU
	BunUQLolv4B433c4AOdSAF6o/DHL+acMBgX7xkqxXViBzknKYNSMzqR12rlPY35xvE614YwUjcg
	RjAnML46dpzB7PpNEgZetLQQk/kVZEpGfUqVOVuYZxl4NAfBrgXWmyYGgZi973t7Xxa7ea+Hv6n
	Ugjz0IO77Hm5c3eqmozko64oH4Vm1BHeoUTun2k5LJBs9DcZLSGxSdFT2HfJtC1SOT/3Zqr3OIF
	fE1uyo3B+4yTSre/aMSLQ4jVbELU5XmOp2fnFv07U4PDYFHgWGpz6bOnDGk+LuVulqXJtbMj68H
	boVYMlGqmg
X-Google-Smtp-Source: AGHT+IEl06568X86BVzNgKQ7sr4wYLSEd+yHkAPiNbCo94xUa63OAJFZtsNW2hDsBmep5OZidthgGw==
X-Received: by 2002:a05:6830:410a:b0:7ca:f50d:b2fd with SMTP id 46e09a7af769-7cc668b669fmr12509788a34.13.1766674693021;
        Thu, 25 Dec 2025 06:58:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ead3asm13308380a34.20.2025.12.25.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 06:58:11 -0800 (PST)
Message-ID: <564afab7-a894-4da8-9980-7d68a0a1babc@kernel.dk>
Date: Thu, 25 Dec 2025 07:58:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: io-uring@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251225072829.44646-1-activprithvi@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251225072829.44646-1-activprithvi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/25 12:28 AM, Prithvi Tambewagh wrote:
>  __io_openat_prep() allocates a struct filename using getname(). However,
> for the condition of the file being installed in the fixed file table as
> well as having O_CLOEXEC flag set, the function returns early. At that
> point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
> the memory for the newly allocated struct filename is not cleaned up,
> causing a memory leak.
> 
> Fix this by setting the REQ_F_NEED_CLEANUP for the request just after the
> successful getname() call, so that when the request is torn down, the
> filename will be cleaned up, along with other resources needing cleanup.
> 
> Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
> Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>

Thanks, just missing a:

Fixes: b9445598d8c6 ("io_uring: openat directly into fixed fd table")

which I'll add when applying.

-- 
Jens Axboe


