Return-Path: <stable+bounces-195220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C8C71FF4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 04:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8064129EFA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 03:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055822EFD8C;
	Thu, 20 Nov 2025 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="olHkaj1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4D2E7F00
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609628; cv=none; b=ccqwFgMK5NRpvoezxk4HC5dRhsuLU9xwZmNZMhsH5qhaXWn4SOnpwFCZNo6pa9+26Umm6JdUpZ1lvQraY0uHo1I2+CaBfU/dfB2c6TrRdxo6DFql3k3zQnT55L0CQ05/iv1ITmsYj37A0Hcad9pLP2ylD3g1gzdBtFdi1HYSR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609628; c=relaxed/simple;
	bh=c4qb+fotShdtlLxPqtxXLntQf20vEAp5tknmYAoo0Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssNAjmRmVomSr5Qf/6hf8QpI6dnN8qrJkDzpsaw6j01c2acmVT/SUYSct3S1XL50X8msi3WgoA7bcar76RTbCniQWS1e5jThWuyWHvDGcT+LU0aNbznDMNuoIX2UusN4orLIbgmL0e0kit9kvnNALrvA/v6Ft+Fnl9/gp2YfPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=olHkaj1F; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b28f983333so40919085a.3
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 19:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1763609626; x=1764214426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Po3nWzBR7b5wfTW9kvRDG15juDb9jkcpoW9chiUBsA=;
        b=olHkaj1FrwOyqwJntdWJ56zNFbN07LSqVCz/Vg8FZw2LknCC5kvIe+3zQKt+K9P60u
         35MUmVC383vzoVpWIPI9yg7tYlD2YCtaot0U8uUvAF1Kxpaw0QnprqNpzDNgNx5OihVy
         JK9uTdUf/YNUG3ubPpVQgkNdU/pQgbleEZUShMdbyGIwa0Jr0LqosD50BdrCZjdXEyWz
         67O+owNhpZW7ee5gW0T5llJ2rBbjvnzqysTyz15jBjpkD9Y1Q+c4A0fAH/PAf4E2xzKn
         /eEadEiecMzu15kcsIoA/W/ZMko5jG8Ayj48tuJ/JEl9JJet0QY/WWLdvser/QOgA5OV
         tZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609626; x=1764214426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Po3nWzBR7b5wfTW9kvRDG15juDb9jkcpoW9chiUBsA=;
        b=XA29UA7GtFT28zoLc3gSuDSWz4FOpdEwPYY/DLv/GQ+/E2eArBCPlJYDZs2b5tMuBN
         t3UajL1lxo72TUkbRDkA9nYKLKueZny7w9qOPHgYS+99NoZs6TwJ+wWwtjBgXYJhP+e9
         IjL2TutG+MROOP6ZEEQqoyVP46zbxaOEfhoRTAMA86v4M/n/fRlBX/z9CBkbGdW+ZE09
         wSl5zEAx3nJVU9AJTKyBVRDjZnKPYGTzsRa205ITxMksh+tLO6iPf3L9D0mxw8NTRkzK
         qYV0r/s2UkS6+eXKA2KCppiT/EVc2P8/+S2EfUVBkO75t+oBfyCRET6QYJ7E7yLRlL/Q
         jYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+haX/3/Aw+oaNMbs5169IY1dqf9krqV5P5n6xrnb0Me0yrMcbFeLzdzOuzntstXqoODLvSi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAW/7izpWmZh7KfzNkW+HwL7uuu7zJqtDTc7MvEtEDUZ/H9Tu
	yquVxb+1cwmfrKl65ozGuYc6CVdL5oSIgcGu8askO6OhxNw7nEw3hxBHelUMFQmw5w==
X-Gm-Gg: ASbGnculBXatC/qxIN+LrgBFfu5ZXBzoz1K8g/ckoDhKrcc9bMvaEJaFK6nNgToOAlc
	1JjekfLXbttb9ykUaAACIpB6TsPpm9RmwvccdPvNVvHh8cRnZE18H9akVMaO1/McwlBs0g7j6fb
	NvRrQIC7o9hMapwWAomD80Fif/e+MVNyzFALgUk9roHsLdFdDHQ6tyrvfz/DzaXDaW6TN8X6P+m
	4ctTWXEpcy2K//CuH2eSksaznAjYhVK5Ctgxg0/n6G6W+USJTI74CAWp866mfjbEpU4zhQ4uQE2
	udK+l+ZxBAngMueLTnnwlzm5C/XrT8aG+CoizM6wOphMMdF30gRsK0YXj8I4/bDiDr6XqQ0abB4
	KcR7eVkK6dYpCu4CGqVblKAmZQE5wvWnzkH6oTzMMIMPif+calNA/h9vgmbPazIUR68hiOXOtCh
	qR0P8+CkMuymZv
X-Google-Smtp-Source: AGHT+IHerc4oDiWRogp2WdCDE8/RYtX/ivFYZddOHU/efmu8diRGdlG759+ncTBWZ25cA9/xfK8/3A==
X-Received: by 2002:a05:620a:1a23:b0:89f:66a7:338a with SMTP id af79cd13be357-8b327311986mr241888985a.22.1763609625832;
        Wed, 19 Nov 2025 19:33:45 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7632])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932ba76sm78537285a.4.2025.11.19.19.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:33:45 -0800 (PST)
Date: Wed, 19 Nov 2025 22:33:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
	"dh10.jung@samsung.com" <dh10.jung@samsung.com>,
	"naushad@samsung.com" <naushad@samsung.com>,
	"akash.m5@samsung.com" <akash.m5@samsung.com>,
	"h10.kim@samsung.com" <h10.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Message-ID: <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
References: <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
 <20251119014858.5phpkofkveb2q2at@synopsys.com>
 <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
 <20251120020729.k6etudqwotodnnwp@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120020729.k6etudqwotodnnwp@synopsys.com>

On Thu, Nov 20, 2025 at 02:07:33AM +0000, Thinh Nguyen wrote:
> > Function drivers would have to go to great lengths to guarantee that 
> > requests had completed before the endpoint is re-enabled.  Right now 
> > their ->set_alt() callback routines are designed to run in interrupt 
> > context; they can't afford to wait for requests to complete.
> 
> Why is ->set_alt() designed for interrupt context? We can't expect
> requests to be completed before usb_ep_disable() completes _and_ also
> expect usb_ep_disable() be able to be called in interrupt context.

->set_alt() is called by the composite core when a Set-Interface or 
Set-Config control request arrives from the host.  It happens within the 
composite_setup() handler, which is called by the UDC driver when a 
control request arrives, which means it happens in the context of the 
UDC driver's interrupt handler.  Therefore ->set_alt() callbacks must 
not sleep.

> > The easiest way out is for usb_ep_disable() to do what the kerneldoc 
> > says: ensure that pending requests do complete before it returns.  Can 
> > dwc3 do this?  (And what if at some time in the future we want to start 
> 
> The dwc3 can do that, but we need to note that usb_ep_disable() must be
> executed in process context and might sleep. I suspect we may run into
> some issues from some function drivers that expected usb_ep_disable() to
> be executable in interrupt context.

Well, that's part of what I meant to ask.  Is it possible to wait for 
all pending requests to be given back while in interrupt context?

> > using an asynchronous bottom half for request completions, like usbcore 
> > does for URBs?)
> 
> Which one are you referring to? From what I see, even the host side
> expected ->endpoint_disable to be executed in process context.

I was referring to the way usb_hcd_giveback_urb() uses system_bh_wq or 
system_bh_highpri_wq to do its work.  This makes it impossible for an 
interrupt handler to wait for a giveback to complete.

If the gadget core also switches over to using a work queue for request 
completions, it will then likewise become impossible for an interrupt 
handler to wait for a request to complete.

> Perhaps we can introduce endpoint_flush() on gadget side for
> synchronization if we want to keep usb_ep_disable() to be asynchronous?
> 
> > 
> > Let's face it; the situation is a mess.
> > 
> 
> Glad you're here to help with the mess :)

To do this right, I can't think of any approach other than to make the 
composite core use a work queue or other kernel thread for handling 
Set-Interface and Set-Config calls.  

It would be nice if there was a way to invoke the ->set_alt() callback 
that would just disable the interface's endpoints without re-enabling 
anything.  Then the composite core could disable the existing 
altsetting, flush the old endpoints, and call ->set_alt() a second time 
to install the new altsetting and enable the new endpoints.  But 
implementing this would require us to update every function driver's 
->set_alt() callback routine.

Without that ability, we will have to audit every function driver to 
make sure the ->set_alt() callbacks do ensure that endpoints are flushed 
before they are re-enabled.

There does not seem to be any way to fix the problem just by changing 
the gadget core.

Alan Stern

