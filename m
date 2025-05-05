Return-Path: <stable+bounces-139698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C9AA94FC
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902F17A13B0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41C2747B;
	Mon,  5 May 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC65oLJU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630F19A
	for <stable@vger.kernel.org>; Mon,  5 May 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453636; cv=none; b=BKZ4MYHOnZSv8P5/5Ym0FpMnlXOB9d9OUR0HMTnFEQH59NQuWdk6ZBSHLZGc6O3MCpPFAwiM9X6nqs4u3elcm6rJhK2hdclDDgQZCFwCksupPgdKuVNYxAj/TNrETkImUmiaXROLyS8XqwkRmW5DX8EFxywUoFSIKElNfmTjZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453636; c=relaxed/simple;
	bh=8sx7iAwEY5wVEwk/YMijqbgIAFA0jCW8GzQqW/tcHzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDqf7JxIPrnk9FoDgx/NaP7rua2AA82ltDBrMdqmkM8bfTWLvBN8CX7cMrVBGF2luvx9nhHxzlxqWv25/zIjr5eElpZWbBUdT5v/wndhRsWbAZHC2UHRfu5ZeZZ4TLdI++/nQ7aElLFcjn/M+51bMf5oiqCLksENqW3lXyJyqqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC65oLJU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso8267768a12.3
        for <stable@vger.kernel.org>; Mon, 05 May 2025 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746453633; x=1747058433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4W415zBYc/FrcFDPh5CD7dEppC5URQ9rStPXLLgxUo=;
        b=OC65oLJU9BtOv4geBQa/x5cEOfIFKME36t/DNbGg4+5GtZ5Pkw9s386+Agv256XXQ/
         UcRxoaIJ/28xCcXR1NQpj2HKJPa/Byi7eLYGmctWru3ZnCFMZxctWTfykwmveb0LIqOv
         20ncWVG9XQ8sFVioe57zrVCrGOnsSp3HuF58hS23sduCkqUOa6yC09bz8EQrwDKiKWk8
         Fd9GmcdHx0xfNEUh+hBHRXDpT5Zh+NUT8pbwJyGh1suj1xjzvYtpZFQus10Y+72YiSua
         /cB2N9FQgZ2Ws9SdOlZPh4aUa1VkoHL5Y1BwNkOw9IyuuLrqq5RQSoJ7nxt5MCaQYjqy
         sw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746453633; x=1747058433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4W415zBYc/FrcFDPh5CD7dEppC5URQ9rStPXLLgxUo=;
        b=l21RPYyLR5REV5oG6v7IPNcuhcD//1lbl8AoTpaUGufQmXaVWl7fKGHoGHpGNlr71i
         qS8xQNcim8MJp3yB6bAj0t1T2L7rePDbeyMr7gSfgT2zeAJEVFgUP3cSb+R8DQWqct+y
         SKLP6nLN5ozrTe1YIJKfpggmIsSj1vSfw4Q4qYl/k6fNtSkiDv/DIjC/GA8u+rrNVUOL
         8I7GJLsjYht4pOg9f+7YHsU0sMt5ynXswGeK76PXfDUYzyaZZBvSU43YHBtDMk6DJIFE
         c4UKYVMdYp02Nvh067l3iGtuki6SyYJZ4DsE8saCzmjc2/1sGghNEI9+WRglt8H5nyr6
         CCIw==
X-Forwarded-Encrypted: i=1; AJvYcCU1NkMItbB8k/STsWXzsymZ2NVtVPYQVBNJ3COXdxvf8A62mRN2WECWTD113Bt2xo1D/9Z7dR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66YokiLT+w/FZxmjWtSTme3ry346BFxgnFWm8XJP4HlLe5O57
	pDqug185O4EniGjTL4cAgo4PrS2IR4FW88xPs0USXyi+18HWL0sJ
X-Gm-Gg: ASbGncsR6gQl86Zd+hiOy4wbZOQWOgfyc0cRm7oXiyk7GKnxMcJGcGikArasMQuDUJu
	y+HtkkWzgZay6P75ymfjX5MIeZh7yND2YD7N231O/Bm7asZ4JjlYSkVnRSmI8YoN4ghv4SXn+/6
	k8Tp0NWmHSVIUZaicZcrfPjZ8iCPQiW3xYOWnIqbyc7NSES076VQbYUCZxc7YOyPDZVsaVJxGFA
	dpLICIVkAPGPB2bBBa8y9nQW9GUR6SiklMCDmp3weBCt3MNYVM1t1Q8wdw0aygs0PwI4zQK9heM
	1/v6io7r0bJm4Lvjy7Ix1/X7Rxoe8zhrLFOR5TTzEWpQo+n3JVR4pNnkFOzXSs6v9uq04Nr/Srg
	erUYqF5FY
X-Google-Smtp-Source: AGHT+IEqvZxAOUpRWWOSk50ECa6+3yzmb1X6nK3mvLHxDq+btzuzepBxjyQWGpD8AtPBFgUV9KfA4w==
X-Received: by 2002:a17:907:72c9:b0:ac6:edd3:e466 with SMTP id a640c23a62f3a-ad1a491417dmr649282566b.19.1746453632606;
        Mon, 05 May 2025 07:00:32 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c032fsm492456566b.123.2025.05.05.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:00:31 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 26597BE2DE0; Mon, 05 May 2025 16:00:31 +0200 (CEST)
Date: Mon, 5 May 2025 16:00:31 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Moritz =?iso-8859-1?Q?M=FChlenhoff?= <jmm@inutil.org>
Cc: Yu Kuai <yukuai3@huawei.com>, Melvin Vermeeren <vermeeren@vermwa.re>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	1104460@bugs.debian.org, Coly Li <colyli@kernel.org>,
	Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [regression 6.1.y] discard/TRIM through RAID10 blocking (was:
 Re: Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard broken) with
 RAID10: BUG: kernel tried to execute user page (0) - exploit attempt?
Message-ID: <aBjEf5R7X9GaJg2T@eldamar.lan>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
 <aBJH6Nsh-7Zj55nN@eldamar.lan>
 <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBilQxLZ4MA4Tg8e@pisco.westfalen.local>

Hi Moritz,

On Mon, May 05, 2025 at 01:47:15PM +0200, Moritz Mühlenhoff wrote:
> Am Wed, Apr 30, 2025 at 05:55:20PM +0200 schrieb Salvatore Bonaccorso:
> > Hi
> > 
> > We got a regression report in Debian after the update from 6.1.133 to
> > 6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
> > stalls idefintively. The full report is inlined below and originates
> > from https://bugs.debian.org/1104460 .
> 
> JFTR, we ran into the same problem with a few Wikimedia servers running
> 6.1.135 and RAID 10: The servers started to lock up once fstrim.service
> got started. Full oops messages are available at
> https://phabricator.wikimedia.org/P75746

Thanks for this aditional datapoints. Assuming you wont be able to
thest the other stable series where the commit d05af90d6218
("md/raid10: fix missing discard IO accounting") went in, might you at
least be able to test the 6.1.y branch with the commit reverted again
and manually trigger the issue?

If needed I can provide a test Debian package of 6.1.135 (or 6.1.137)
with the patch reverted. 

Regards,
Salvatore

