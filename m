Return-Path: <stable+bounces-192670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B51C3E4C1
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 04:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181E8188B877
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DA276046;
	Fri,  7 Nov 2025 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="cn57xZ0o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2272040B6
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484777; cv=none; b=aNKisf+rpXwvv5BbA+7/2j2IR/s92lYcM+i1MfzCroCdC4N22pRT2zLXKiPFGp62ecxQ4C8YzJk+2TZhFhUaQbzXt2hPDTg9l+O9snho1ypQTTKl2XFsIN/mIpEwjjmxkQT2CGBxQIxsBtFLGtpbAVQagJQNP12hz98sSVBgl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484777; c=relaxed/simple;
	bh=SqF6cjAe5fIGfKljFwR84iVXlUipV5ARm6YRakF57pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQSL5ImdhcjrT1inkJTDXukg55qxTh0xo6QeBhewbbhDLiNjVi1pk45U2QKuIChSQbqoT5TwF1kTxGgMeEkhDYfDdHXFIYpqmha5DivicCJ4xaBKUHM/5mcUglCxJTgyXPNyc43xiAkt1kWqflHhO4FfPxoalDB0LTKKSDB7GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=cn57xZ0o; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88033f09ffeso3491966d6.1
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 19:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762484775; x=1763089575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E56miCz2ucyW7p5RTNikjLhgl4gC4pK61qcfT2Qpt0U=;
        b=cn57xZ0oPlgAD+CBSKMswSkoX9xKQS1HixdXW5ECEdl1/YgEelftUJw1DUcEfh+duA
         CqyX7f9UdS2NaP2m4VEwp/qSKjRqSQDW17RbaRWRXGTqnivMrDDO91IRo5di4cHofFo4
         dDmQShLEs015pKEKpL5+2L1UsNOF0CCOCELwr7VtTZodwebonazUVnNh52D0rcis0esS
         z9KV+2j1vbSwr3RhKOGq0fn9HINj478kHnk0DOEWVuwsrTs0VH637mEM4F+1mdG3XZr6
         s+cYsLKU+BMUC+arbyjobnJQiPwtQZS8rT7DMBjEc8kNkXUA+YVqrxCLg6UDZ1dBhD6f
         oIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484775; x=1763089575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E56miCz2ucyW7p5RTNikjLhgl4gC4pK61qcfT2Qpt0U=;
        b=AkH6M9DTrh3JRcJgQ7mCKi34hpLEyjZl5t5KjXOXmKZcCtHIY1Fhuy9ijIjwU3IXVO
         vDtSvZ9IY30gZxO7YrlQsKOSLYOs/W5E9UeCR+DGmcA1lRD36PImF/a3/c395EPKhzrc
         vvi+lge7RkW4k9wPivfvmkUJL2C1z4u5rNrxbMB3XabbERQ5nogo6Y+MgV6QwLd7uTIY
         e+BpLFExZxuQQO9skCND8geAcEIgk6WmMF0LsELcSj2gtvVfnUNlc/OWHlspJE4u5Vg7
         Z8oj6LRMUblG4hClpgp3U1WnZAn8ttjfxr+ymo4zx7GCr7RCg4pjU4wiToJ3mGfP0i/n
         NkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAtIx2Su5H8UQPLU5U86i9tejPITXGpYp5+byiB9n/ejjUsFeW04E20WhjXVms2xAM9y1Uytc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/wn32VEjQ7nWHIIwSHVmwCtAgSAMsgS2FfGhPxHNEbsezKA3
	EejApAC5d9Fiof0BFjKCSYqer3KKeG4aBxwyHRkkw6FBZEMvz9ul8mJqHLjRgVuS6UmQCqkeJnQ
	41Dz3w24=
X-Gm-Gg: ASbGncspvALK3Fuut/pgn1wRfYd/ChHBPf9im4VNkuAFaheMOc4BHX308mEV9Twpank
	jrKKjTcYNzS8f1IHizVTikQmJEuBibwyHWBZX8TilCPP7KQ4oyfJHUGJUBM/27mNsJ4eYEML3Uz
	RaU7QR2Um8IiiSyQJLl1KLl0nr13X6Bo9mK0x5ypwQ3KH9kg2LVpmCQEpQ3zHSMbKx3nMzc9xkW
	xsU1Z8o26pWVVGgyVlLVrArNCHVJ6IN+Bby7TdTQ/iJLqhEKUljveGAnyKnS6KsPj0yC2gnCqwk
	JNo8C+oEwx2cRzh9bSz8HxYIIKdmy/ZCyGq0hKHT/+mm/+ilQLxeX7i/lLCPx9yG4/Z2rac+chp
	ywHXFsJDh3vE0w4PBgN2njStyBSkMxAWICrvsZppOn/0q81pBl3OwXpmEgZg2TMELEaSAoCnjdM
	r2xaOnMa/vGscn6uQf2qPpqpnowBF5m0yp34ZyOyVW
X-Google-Smtp-Source: AGHT+IEwrtDh+N2RU8TdlIkL8MsNx2X7a1H9tD28kPSplx5JFVcsb0223J9Fj+vOzbjZ1jDImx6R0g==
X-Received: by 2002:a05:6214:4004:b0:87c:108f:676c with SMTP id 6a1803df08f44-88167b17ed2mr26261796d6.25.1762484774711;
        Thu, 06 Nov 2025 19:06:14 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88082a38210sm30548476d6.55.2025.11.06.19.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:06:14 -0800 (PST)
Date: Thu, 6 Nov 2025 22:06:12 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Esben Haabendal <esben@geanix.com>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, linux-rtc@vger.kernel.org, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <e7ezfmqnbduq7jdc7osicqp4rnztu466gpbcxaoj54jfigsvvp@iroscsnamy3c>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
 <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>
 <ni6gdeax2itvzagwbqkw6oj5xsbx6vqsidop6cbj2oqneovjib@mrwzqakbla35>
 <35bd11bf-23fa-4ce9-96fb-d10ad6cd546e@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bd11bf-23fa-4ce9-96fb-d10ad6cd546e@leemhuis.info>

On Thu, Nov 06, 2025 at 11:25:55AM +0100, Thorsten Leemhuis wrote:
> Just wondering: was this fixed in between? Just asking, as I noticed the
> culprit was backported to various stable/longterm series recently

I am not aware of any fix.  I just retested both 6.18-rc4 and 6.17.7 and
there is no change in behaviour.

Thanks,
  Nick

