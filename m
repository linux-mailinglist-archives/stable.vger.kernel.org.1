Return-Path: <stable+bounces-121433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE699A56FC2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA016961B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDE2417D9;
	Fri,  7 Mar 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inXyiNGO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD6241663;
	Fri,  7 Mar 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370127; cv=none; b=obh6VGi33p+WhUq4pXoK5A+rXWQjVN6egqhmZ+MBXj1dINFyalmOH5xAB03/a8/7bff+I7S9o7EYhu6iSwQP4OP8iZUEFLqehqj9EYgPW2RDDt1WZMyh32DvPpjmYpLBaEQIqmjXAdgOA5iB9qFAsJPAa5x+AFN3EVfVhjopHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370127; c=relaxed/simple;
	bh=7dFM6zsugukDhCV8oEtjcoZILG5023fpt5kircdNGZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx/czbSzJQ/pKxzF04Z45MGjC2As1YiucjywOxieTycQXhxnELxWa6+ClnzlACRX3nqDNnC56OawRXodW2Q+Q+FMingu+rcI/4K1sMe3F9ABr4eTr8HyoHFddaZDZJUFXbZU2B0/7HuJi4mRODSrKvkI/+JxIJspiH80AelSF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inXyiNGO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390e702d481so1164609f8f.1;
        Fri, 07 Mar 2025 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741370123; x=1741974923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJJYheKsNCMVQQfa9ViKmHAAohtaSnoelqkEakX6MFg=;
        b=inXyiNGOBam+I69M+Gc2BqyKlSdC7gzwgU8HrtBeFPZ5Opp2TnGVn+dgPe2uIguDZ7
         WMRiUhKj3A6urqpdYfMuZW9VxaN+iqq8g2k0bASKHE764sU7ybLzwFTkRjRbqExQADVb
         f9uQaZusELt1C1XoiZXZ0Qsus1bwNjf8SEgu5yvp1UD3WxEV95us5xBdU6Swq6bfkq62
         0wTV4GJbgdo+9q+FUJVhM/nl/yLpViMRq8jD5Q7Ggo4fwQ79UGOIwZnD8XKMIQ6LWlHQ
         KKVgVg+crAc9vRu5TcwqUjZ4AXeTE80sYT46sJWr4XVasW5uRo5L1nM/Wy7WH+3UFUzI
         EbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370123; x=1741974923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJJYheKsNCMVQQfa9ViKmHAAohtaSnoelqkEakX6MFg=;
        b=AqrJjPptTejj9xiHCz5slqD6i7zkECNWUniNYfBBtcfc4ZHcD3ClnqP08L2+iA8cXl
         Z9dn+0uLEvFaAqf/FjQGZ7WAnKCqHJdQLitk6yjuohwz21HHWsrUr8cZ3z1jExFUkGiJ
         WWAnerx/5x4kuH+syPjS9pY98lGvxyqzqufV9v4KxxKlYDzlLKS4zXBW7/SjAcZHdWAp
         ZDVJTgUZDi53iGUzv6R6gZL4hmZKNqhuN9STa9gAHfAu9g4IWrtNY+mzxxivrpV+re7P
         MlpPrgjHhMvWdcfrnoomzB2Ce5tGa4plZ4b5yKZRZdff+tnQ8DPP4wVJSW1xpbrGxgHh
         cIHw==
X-Forwarded-Encrypted: i=1; AJvYcCV/qfX2VRUYTQx802E0LbhSscTYiyZh5lrQ4eOIRaoGc6adP5WOumPrULny34jemkGFCP+lhqYbFit1LBQ=@vger.kernel.org, AJvYcCVwDoY/S+2TeMQYDK/vQ5y141hen0NCgQ681qaEsgTat59eGE1OczuqJtewEOvEPU8XqjDooa13@vger.kernel.org, AJvYcCXCnXEqz3t8dS5qEUXe22YnSHpfaU7Fc4EYn5zmHMQcALCAPLm5wg1sBnu7CaaGJ7omlHousd0uDpGn@vger.kernel.org, AJvYcCXZVh/QT4LzR4ToPrO79/i/ayQYPz/Uz4hwZyhm37E5Tfq9X4sxHEfpqAcio/Me7eEFllONrgd9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7UhPs096a9VbcwQDUkmt5s8t6SpCTHtCGCT205xPyEDMCz/Q
	qACp3RlB8l8Mw5cFiimNrIx0Uf1eS9GIyhGMq6JhbZqxQMgu0wfh
X-Gm-Gg: ASbGncuipxgLDpa264XcveawykXSgeexYLPqo+HHkpGpASLvVzDUr4L1eWVKvB6Cdkx
	4NlPMLCY9pKrUfFlyaiTFQArUEn3XAGLWerBWCqpv+ftAB14Lsvig/MhLFY7GkkSuJ0OsgGrC5T
	1Tfr+h3iCT/ACz3OAnI8UtbmTCaI32lBhgP2Kqa2z83yrCYv+LBoEfWVQ3KoI2JRyxFGu4rcdgv
	rS2S2SKEtKvbut2ZCQz3TJWEP6XdU9MWRzxklWgXfM4wHhzuB2FPGKHsDX5C7eqBMxhb683mX+J
	DOUMif72I5nzjszT2eLJsmjAgxWns8SKAAtm12x8APAhCJyU
X-Google-Smtp-Source: AGHT+IFpW7liXg/4SrI25udqjnIuR8F7NjVffjlaIF9SNzSZrihXb0ckgoZWYdOJg1iD0zmuLhUbLg==
X-Received: by 2002:a05:6000:1541:b0:38f:3c01:fb1f with SMTP id ffacd0b85a97d-39132d7ed99mr2501232f8f.30.1741370123352;
        Fri, 07 Mar 2025 09:55:23 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:f433:8dda:2940:b016])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015d2bsm5898846f8f.43.2025.03.07.09.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:55:22 -0800 (PST)
Date: Fri, 7 Mar 2025 17:55:10 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <Z8sywbV8B3Nm3BKR@qasdev.system>
References: <Z7R6uet1dJ1UJsJ1@qasdev.system>
 <418ddcf6-e7c9-4a8e-ba1a-38a83cb2b5f8@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418ddcf6-e7c9-4a8e-ba1a-38a83cb2b5f8@lunn.ch>

On Wed, Feb 26, 2025 at 02:43:31PM +0100, Andrew Lunn wrote:
> On Tue, Feb 18, 2025 at 12:19:57PM +0000, Qasim Ijaz wrote:
> > On Tue, Feb 18, 2025 at 02:10:08AM +0100, Andrew Lunn wrote:
> > > On Tue, Feb 18, 2025 at 12:24:43AM +0000, Qasim Ijaz wrote:
> > > > In mii_nway_restart() during the line:
> > > > 
> > > > 	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > > > 
> > > > The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> > > > 
> > > > ch9200_mdio_read() utilises a local buffer, which is initialised 
> > > > with control_read():
> > > > 
> > > > 	unsigned char buff[2];
> > > > 	
> > > > However buff is conditionally initialised inside control_read():
> > > > 
> > > > 	if (err == size) {
> > > > 		memcpy(data, buf, size);
> > > > 	}
> > > > 
> > > > If the condition of "err == size" is not met, then buff remains 
> > > > uninitialised. Once this happens the uninitialised buff is accessed 
> > > > and returned during ch9200_mdio_read():
> > > > 
> > > > 	return (buff[0] | buff[1] << 8);
> > > > 	
> > > > The problem stems from the fact that ch9200_mdio_read() ignores the
> > > > return value of control_read(), leading to uinit-access of buff.
> > > > 
> > > > To fix this we should check the return value of control_read()
> > > > and return early on error.
> > > 
> > > What about get_mac_address()?
> > > 
> > > If you find a bug, it is a good idea to look around and see if there
> > > are any more instances of the same bug. I could be wrong, but it seems
> > > like get_mac_address() suffers from the same problem?
> > 
> > Thank you for the feedback Andrew. I checked get_mac_address() before
> > sending this patch and to me it looks like it does check the return value of
> > control_read(). It accumulates the return value of each control_read() call into 
> > rd_mac_len and then checks if it not equal to what is expected (ETH_ALEN which is 6),
> > I believe each call should return 2.
> 
> It is unlikely a real device could trigger an issue, but a USB Rubber
> Ducky might be able to. So the question is, are you interested in
> protecting against malicious devices, or just making a static analyser
> happy? Feel free to submit the patch as is.
> 
> 	Andrew

Hi Andrew,

Just following up on my patch regarding the uninitialized access fix in mii_nway_restart(). 
As I mentioned in my previous message, how about an approach similar to the patch for ch9200_mdio_read() 
for get_mac_address() where we immediately check the return value of each control_read() call and return 
an error if any call fails? This way we don't continue if failure occurs. If you're good with this approach, 
should I submit a patch v2?

Thanks,
Qasim
> 

