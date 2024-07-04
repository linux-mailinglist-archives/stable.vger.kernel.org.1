Return-Path: <stable+bounces-58042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615799274BB
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 13:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850A41C2206B
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE061AC238;
	Thu,  4 Jul 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njearGOw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B80210EE;
	Thu,  4 Jul 2024 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091801; cv=none; b=KQIzOA51Bw+g9p5mJ4gsgg3L6WzJ/NeS/Wh7gORf1iGE6nQqIrMES9d3BTR0A+i+IJJNduk4yjVWnlbn9d+3xChAogDhVnWlcPnt6zTMloEW+mEHuYr2VlL3d7IHKEpTwXRBOoKBGhZ8yK07QRTdxRkJY5y1Dah9xH7d3SY8nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091801; c=relaxed/simple;
	bh=OlUPwbm3C0naWrFm94xQDd2733KQLboF4jpJiDriZCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsYYSFELs6x/03v4gHyoyQ3E8K+UI7KBgxxVQFY8lozL34LFDnxF8/RcPDdp0q45JwUdRwu7osGjBRwUm4XCT6Ix+6H40tXh32Ei7MLDR3sXkeiaaitCi33I842uhUZXjS4TuDSw7NcEDhFbccocDoPSkZxSfZils4YNGH0h/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njearGOw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so1875875ad.0;
        Thu, 04 Jul 2024 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720091799; x=1720696599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VRWUHckXq3BNRPnOd0HDIJh7WrGHyU1e90iq+AknEGE=;
        b=njearGOwZJf5/GjHOT/9PdYw1p4HGgM4Zf5z9G2wP317FzsbBF63rKHcNORaTIPLcx
         GaIC1tDkfiWuL1MFl9VTBdqX8Mgm3CvG0S4idyqE3KpcDu1vXvOIT6jkWb1nfd7O7+ck
         lwXGrKz23TUo7QRhIDAslLInNTVeToh25ppY6o0iz3Is+ZN/gJEqLFYIUT1cUeNYQqHe
         5asCBQy414fME+M/ylQYxMOsJ5yQ3E+WDB/XI/mLWN/kWbgZYQ/hg0bocxLHw2u8qSCu
         B+JtLRfSn90gMN2uykWii5P6BS92dx0F9H8CAWL8c5NEJs+GEHSWSSy2sbg2h6u5Y7DI
         lVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091799; x=1720696599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRWUHckXq3BNRPnOd0HDIJh7WrGHyU1e90iq+AknEGE=;
        b=FTTxkE4nTAqC32iweqJYtkFZpmonC/H9R5COzNqps19CxmvTyREY+/lzQPNPwSA3bJ
         z2u3zWPf1OIWgSasKdHgWYXk4hK6I7e5qe/ZudVWBe4Xx/BO7cujCPiGz54GQDPZspEq
         c2AcqZUmhOklm36TY1f2ma+Cut6IWf8YuGa9FF4VUa6UrtBFVn7LX5ftClqT6Bx5KZ9W
         nJQCKmWALk/QRGviL1/XIxsJ1iEfPOs2X3XWLtbaV9RNpMY4YH9GPioPUkUueUtNEMrP
         3KdWTtSUm6tscK58J/Xjf45K7WNDPs3F+N0MLIv5ACMMmvSOsO+0iB6cC8USldari0/H
         oNRA==
X-Forwarded-Encrypted: i=1; AJvYcCWyodfBdZP3tP6q5XdB0HR03YA/Kn3UD1gx7Ti96+YP2Y/mn+UD7nxqR/tG2EEzPgAcJ/KwvRsE8V5t+PnBpL1kgGSkDKMrKUUTPitjKd4yenUg5W9mzXKr1zyiVti2Mnawcth1bnbY16X1qbOFJ2lAwkDoOlm3OM2YbZjBFykucJIImsDTMFmm
X-Gm-Message-State: AOJu0YyIwQ+2zf3nqw1KIKaipA3nd///7jJ0usghJQYifxt6k9gr/NAJ
	GsVz1uUc2TT1MMCq+n6bG9YeDM28cVstwqFLAsSdluXdpYfRnMZ0
X-Google-Smtp-Source: AGHT+IGWNH/d4DiodPEdB26qrebgsENU+INw6QtOxlRY2mFtLN0Dgz4d/3ACwf2nEdp+Zxpu9Y8Ymw==
X-Received: by 2002:a17:902:e54f:b0:1fa:ff88:894a with SMTP id d9443c01a7336-1fb33e199bemr9149485ad.20.1720091799398;
        Thu, 04 Jul 2024 04:16:39 -0700 (PDT)
Received: from [10.150.96.32] ([14.34.86.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faceb78c6csm112263165ad.271.2024.07.04.04.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 04:16:38 -0700 (PDT)
Message-ID: <6391f34a-b401-47e8-8093-d3b067f26c1b@gmail.com>
Date: Thu, 4 Jul 2024 20:16:34 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Taehee Yoo <ap420073@gmail.com>, Pedro Tammela <pctammela@mojatatu.com>,
 Austin Kim <austindh.kim@gmail.com>, MichelleJin <shjy180909@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, ppbuk5246@gmail.com,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20240702180146.5126-2-yskelg@gmail.com>
 <20240703191835.2cc2606f@kernel.org>
 <2024070400-slideshow-professor-af80@gregkh>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <2024070400-slideshow-professor-af80@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Hi Jakub

On 7/4/24 6:32 오후, Greg Kroah-Hartman wrote:
> On Wed, Jul 03, 2024 at 07:18:35PM -0700, Jakub Kicinski wrote:
>> On Wed,  3 Jul 2024 03:01:47 +0900 Yunseong Kim wrote:
>>> Support backports for stable version. There are two places where null
>>> deref could happen before
>>> commit 2c92ca849fcc ("tracing/treewide: Remove second parameter of __assign_str()")
>>> Link: https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/
>>>
>>> I've checked +v6.1.82 +v6.6.22 +v6.7.10, +v6.8, +6.9, this version need
>>> to be applied, So, I applied the patch, tested it again, and confirmed
>>> working fine.
>>
>> You're missing the customary "[ Upstream commit <upstream commit> ]"
>> line, not sure Greg will pick this up.
>>
> 
> Yeah, I missed this, needs to be very obvious what is happening here.
> I'll replace the version in the queues with this one now, thanks.
> 
> greg k-h


Thank you for your hard work.


This fix need to be applied versions in +v5.10.213, +v5.15.152, +v6.1.82
+v6.6.22, +v6.7.10, +v6.8, +6.9


Warm regards,

Yunseong Kim




