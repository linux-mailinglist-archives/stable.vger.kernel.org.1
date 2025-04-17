Return-Path: <stable+bounces-133219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68EEA923F5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460BB189A86C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002022561B9;
	Thu, 17 Apr 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWrw2ZQl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786D255E58;
	Thu, 17 Apr 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910831; cv=none; b=sVAPZyyKdsaoOq1BryQrKrb1FnOK5cv0nRtwx8KyqpDwMinhYgoA94TzylsFtFpTEGZ3GCmUKLdQR3AFD/fKMTrkV8Um1S+/uRpVLicEvoJyuMXpW7vvr4K837TrX1CFk7F5Gt9AHLfUFzScePUAje0O3qVZuUFeVN18bPENVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910831; c=relaxed/simple;
	bh=sxkHYuOsrWQh8lOFfo/eXoJm5KYUTxqvZBDoPd6T/GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4kGq1e94cytI5dLl1ERra6919CAw76Zz2vXJvF/2O557igVGgzmhZ7L73422bdrD+6DaGNP7K7yXi42cQcwSlmKfP1bybpJAFlxiwAauspYdY4hiGdulctSaYUCCTf8JBiq3LDSvlfAISNSW1hP7drvTkK/FhjrNCK9oaZbhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWrw2ZQl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so803884f8f.2;
        Thu, 17 Apr 2025 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910828; x=1745515628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wixJu71NKSByWZRqz3ES0mQxxXn96JrVSVxJlIUxh48=;
        b=mWrw2ZQltygjybO13Zo6M+RsV/opDKzy0707ccqrHXdJ6MuQWrxzNtOt3CqIpec39F
         fD+Ohl71nbwo5y0niDbTQFtgISx1STyU58AiOv6ZvNAKnKV2GrhGws5PpBQNKshoos6G
         +EAr6Ydw7PloRacom8SS1irnBhfutK9Jqt7oozqm4/Hzlp3krkj8YbNVGvaq2ViP45mO
         cEb4dezP0VzLX3OMdCzd3IMKEy/Uo9OBYOk72u6C0bVpoTD7chh6S/jR25rZrpZgYJ8z
         f7UcoiM59fJZRyCzwsAZut0JagOqWRHtOdvNqdH/52wMGlOw716HqD3N2XvUAn/qRPoz
         uNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910828; x=1745515628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wixJu71NKSByWZRqz3ES0mQxxXn96JrVSVxJlIUxh48=;
        b=Rd2VdHecl7GNBcVMSgsG7QPvOGdGMfFu1TaqmnOOuHMU9d5M+pmTAogQb4mBVWiTN2
         nER25WyNzzgEsTH6mjXaa7ULTAWP46XrtWCSJxq6r+56CD4ikmfXSiy4gqclXx5s+SEv
         09zWEjLOjia0piTrf0AMvj9RdsUaJKi8lBffhGVwTrW9I7gYAt2GWu9nuMs1k+4wXnN1
         ryxhcrkqcTAM80IMImGe2270jtuWQqjlKYYTgmGGqhb569euzEzQpUaTncv+qRXTx4jz
         WnhI6CF8eZT7CqkROmsH7eLLKnFTdj4xtR4IP2v2bHjitJT8kldAnZWZHFrGrB4TzsGa
         inPA==
X-Forwarded-Encrypted: i=1; AJvYcCUdYbe/9N5VF6wslVMoerIhRwEdVK26vZksg56lXi6me6vdcJafkuz0pQov0dwwURY3vA1i2H6T3gxgYLE=@vger.kernel.org, AJvYcCVkpgLK5qoeBoDDajq2YKL18pQq7EWhdb5V+DJYaW5kyCmAE+5nST9G4Pc5rjQWv/+7tjIAfNH8@vger.kernel.org, AJvYcCX7LpZ4jSF0LkZLUZUDOeKXmyah8UTKaG4pwFK+m/gOi9g+qzGMdMEo9liKAOIhxHJ4iHu95GsVZR0y@vger.kernel.org, AJvYcCXa7CsPXJbQIS7q22pzQih0ivLpfF0pKqlrj5RwqemJvsv4wStM4tEr+QsfKY39UhfPHRGWa11N@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHHfXIu2F4H+1M1qS57CeaGALFzoOufw8acbv1B0CfaaiR5Ey
	UNGjMjehgmgrZItVanw8y+ZD2GSU79TaaGWyule85mMzNZAvDKEG
X-Gm-Gg: ASbGncuA+FuUWCo9DjVzoCjGr4AYtclo44A6GdcYiW5h0q7H1QFFTh0LLxIkdcURomq
	+GUJszcrceZiFiPS4NmTDW9vA/2xlC7dZuKyKToASLj9kdzl6jhnBSlMqSujxR/6paR2y9CFEak
	ZTupRTeu0MZa+UU2SkC4x+R3JAMD11f3+hjvVaz0lgtk0kEY2cqcvQUY7DT24WnnQTkaC3ByVXE
	qcIiWE6DzDaxcSHjytQq5gv6z12xG7IiB1oyCs4qXrfhDsfsOFeomeAx5bua5niDeJalgZ6c8/e
	UDrdML2Z34exE24buN5hr0Wf7EFn2+yX55Gieg==
X-Google-Smtp-Source: AGHT+IFj6moxoKvW3/0bIkk3LxXfaTi6KALUQz1SQ2f4BX4nkO2V9Ua92HwQT5Vm8Zv6SFZvNZOQxQ==
X-Received: by 2002:a5d:6d87:0:b0:391:2e31:c7e1 with SMTP id ffacd0b85a97d-39ee5b10f8cmr6323677f8f.4.1744910828006;
        Thu, 17 Apr 2025 10:27:08 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:1efa:2230:869a:758])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43c079sm240413f8f.50.2025.04.17.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:27:07 -0700 (PDT)
Date: Thu, 17 Apr 2025 18:27:04 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <aAE5wmi6MoYMzui7@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
 <aAD-RDUdJaL_sIqQ@gmail.com>
 <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>

On Thu, Apr 17, 2025 at 04:08:08PM +0200, Andrew Lunn wrote:
> On Thu, Apr 17, 2025 at 02:12:36PM +0100, Qasim Ijaz wrote:
> > On Tue, Apr 15, 2025 at 08:56:48PM -0700, Jakub Kicinski wrote:
> > > On Tue, 15 Apr 2025 20:52:30 -0700 Jakub Kicinski wrote:
> > > > On Tue, 15 Apr 2025 03:35:07 +0200 Andrew Lunn wrote:
> > > > > > @@ -182,7 +182,7 @@ static int ch9200_mdio_read(struct net_device *netdev, int phy_id, int loc)
> > > > > >  		   __func__, phy_id, loc);
> > > > > >  
> > > > > >  	if (phy_id != 0)
> > > > > > -		return -ENODEV;
> > > > > > +		return 0;    
> > > > > 
> > > > > An actually MDIO bus would return 0xffff is asked to read from a PHY
> > > > > which is not on the bus. But i've no idea how the ancient mii code
> > > > > handles this.
> > > > > 
> > > > > If this code every gets updated to using phylib, many of the changes
> > > > > you are making will need reverting because phylib actually wants to
> > > > > see the errors. So i'm somewhat reluctant to make changes like this.  
> > > > 
> > > > Right.
> > > > 
> > > > I mean most of the patches seem to be adding error checking, unlike
> > > > this one, but since Qasim doesn't have access to this HW they are
> > > > more likely to break stuff than fix. I'm going to apply the first
> > > > patch, Qasim if you'd like to clean up the rest I think it should
> > > > be done separately without the Fixes tags, if at all.
> > > 
> > > Ah, no, patch 1 also does return 0. Hm. Maybe let's propagate the real
> > > error to silence the syzbot error and if someone with access to the HW
> > 
> > Hi Andrew and Jakub
> > 
> > Since there is uncertainty on whether these patches would break things 
> > how about I refactor the patches to instead return what the function 
> > already returns, this way we include error handling but maintain consistency 
> > with what the function already returns and does so there is no chance of 
> > breaking stuff. I think including the error handling would be a good idea
> > overall because we have already seen 1 bug where the root cause is insufficient 
> > error handling right? Furthermore this driver has not been updated in 4 years, 
> > so for the near‑term surely improving these aspects can only be a good thing.
> 
> It is not a simple thing to decided if we should make changes or not,
> if we don't have the hardware. The test robot is saying things are
> potentially wrong, but we don't have any users complaining it is
> broken. If we make the test robot happy, without testing the changes,
> we can make users unhappy by breaking it. And that is the opposite of
> what we want.

For patch 2 the kernel test robot said it is missing a Cc stable tag in
the sign-off area, it didnt highlight any build or functional errors so
I don't understand what you mean there.

> 
> We also need to think about "return on investment". Is anybody
> actually using this device still? Would it be better to spend our time
> on other devices we know are actually used?
> 
> If you can find a board which actually has this device, or can find
> somebody to run tests, then great, we are likely to accept them. But
> otherwise please focus on minimum low risk changes which are obviously

So going forward what should we do? I gave my thoughts for each
patch above and how I think we should change it to minimise
breaking things while adding error handling, which ones do you 
agree/ don't agree with?

Thanks
Qasim
> correct, or just leave the test robot unhappy.
> 
> 	Andrew

