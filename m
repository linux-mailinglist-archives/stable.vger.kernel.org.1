Return-Path: <stable+bounces-169601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DDB26C69
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8260E189FB17
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0725334B;
	Thu, 14 Aug 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="SmRbd1SG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB71922DD
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188482; cv=none; b=bC9FQz17Ipq1nciLbn777SCeqlkfVL3i1qnzYJIFETok00xUDnRts1Yy2utoJJOM1E/s9GpzshBA0WpRy4w9ZCKWFh5lZEufuQEJxpr/Qjz2v4woxch2ltKXwnQzLi7vVwQqR23W7qKA6sygbwLaimMNcXenJzyuFTbiWVWmYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188482; c=relaxed/simple;
	bh=7EgwnlJAoFTq7SlPhZRA9IsnRZZ93ilNLs8d+YAd+lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc0yBCu2O5qqiHe6zKcPe0idhxccxMm/zG9NyPmuX3ak5G9MmLInpNCxjsqq6w378/ywDKPiHvWO+jizw8DVLVVpbhI5I3V5t9A36ytsLbqLE46/gyG7SzqRVPAqMghs6H0HPflHIbBWkmeOuhnEugbR6bgwe4bK7cUyO6STPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=SmRbd1SG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8706a6863so116241285a.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755188480; x=1755793280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=le3KUTgWjNTixhQays7FLtYINre7Udl52g4ue44pkrM=;
        b=SmRbd1SG8vkzK9HD9zbG7wpfzC3JNWBTUWpiQUUy1f2j94ISV4FNWw6svolmIvhEke
         RQExdM/zDPqf01byjy2U5N4lYfFPGU3OK6djda6niIWRMAFzoSyPsRwg8rH1oGUZeJqd
         KsBKLzKfS5XJdeqkproDv6nMCIoqLddQtI6zJUBUCn0yVhFm/kEPFnsfx6GWaS5jiOiV
         xXOUd/chTVRRLtWiY4gErpCyF4yxr4LB8KLlXru2ZA3n7/pbHmouKQAEOR1V1O4Pr8lp
         ychL51j0Pb2Om6E7qYPGGKRzFvDzsA5u9JlKkp+uMVDJePxrIVArUGaS1qYLucX9+VEX
         QyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188480; x=1755793280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le3KUTgWjNTixhQays7FLtYINre7Udl52g4ue44pkrM=;
        b=q00/ZC/dGjFjhoo52GgMuuF1sZ30iPp+S2G8LSrhu1TtZIDstwb26rzOFC/uosrwRc
         fyHnhbdW+uyHlZjMh/RiLGuWEocMDne0neaq6xoKeGXs8+hs1mJ60tf6QYyWwLEJep53
         nHCzUjXKb2zusgSUYTfX8rjt88DTdEbWoCZWnXxio9JqyKgIITXI0U/j4j4NyFup6i9W
         dgeILLwZ+tDR+5lc3g9qUuoQq+yzz5ESRkYHvlzfo3V1YSu4pg2SggQ6paxIq+IcQu6H
         wYjDD2rC/GBoqT9wAmiMq4yZAx0pSA7FJo+ooexomhH4IkZnD8iMU5C8NlNtQDpX2jkg
         Kz+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFrXbkCRXYyBZFPvDXXWulv7BZiU9TndGlDcjJiHCzJLlugRfC7qmQA5tRRDSg0QSiePgGdR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcRM1IgSdjcriVTZdP1OpIjo2YK6V/3uhE6vYQuvT81CbNlnb8
	moIqnwLlfIBrxPSvSEaf6UaRezB9RQ4dySicYduwueWeb9wFQZv9eG0ZFn5tiYaYgg==
X-Gm-Gg: ASbGncsorOrX7Q8vtYtnjhEmilocFFHhbTz2Up7qwxONazRhjxReKekx+86kep5ac6k
	jD9Vsp64tCYW0dvO99ruaduYubhcVZTQJhoWcvADyLTxUPoOh6wJZrd7+gzy9ryHMSCxsBezWMv
	3Iu2RzDiC/Hb2Sv7UXwqot5+JroXrZSu5S0Xl+U/4xgK94HLmRqrqVfMbuwLvdigDC3vCYlka94
	RBHy+hJIJ68nZW4sr2YDGJCxPi6B5Nr0H6teVNZzFTwa9/k1hgeHwv4Vm/nUGF+owqTRQlFleMD
	qbaPdNdmEZ3OzPPZHh3jgVgrK7/Tcm51Xa1X1z2/dJgMPTrrH0I1CZ4XyqeUM+N/ZttGJo3SHFJ
	3NUaDV9ywTE/6/EFt6F5ZMgTyez8=
X-Google-Smtp-Source: AGHT+IE6TEt0QdUiRNlKK2ntZI2ZKHaBItsun11sKReyPJdRIak705h7rmhUqMxg6hSEle2xGwwwrg==
X-Received: by 2002:a05:620a:31a2:b0:7e6:9730:3d4e with SMTP id af79cd13be357-7e87057bb20mr438296185a.43.1755188479584;
        Thu, 14 Aug 2025 09:21:19 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::fa48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80c0e6ff2sm1563517685a.30.2025.08.14.09.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:21:19 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:21:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Zenm Chen <zenmchen@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, pkshih@realtek.com,
	rtl8821cerfe2@gmail.com, stable@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, usbwifi2024@gmail.com
Subject: Re: [usb-storage] Re: [PATCH] USB: storage: Ignore driver CD mode
 for Realtek multi-mode Wi-Fi dongles
Message-ID: <b938a764-6ded-4b76-a15c-82c0062abf42@rowland.harvard.edu>
References: <03d4c721-f96d-4ace-b01e-c7adef150209@rowland.harvard.edu>
 <20250814140329.2170-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814140329.2170-1-zenmchen@gmail.com>

On Thu, Aug 14, 2025 at 10:03:29PM +0800, Zenm Chen wrote:
> > Also, can you collect a usbmon trace showing what happens when the dongle is plugged in?
> 
> Hi Alan,
> 
> Today I removed usb_modeswitch from my system and grabbed some data, could you please take
> a look what was wrong? many thanks!

Yes, this shows the problem.  I'll skip the unimportant stuff below.

> D-Link AX9U

...

> ffff8ae1f0bee000 771359614 S Bo:2:053:5 -115 31 = 55534243 0a000000 08000000 80000a25 00000000 00000000 00000000 000000
> ffff8ae1f0bee000 771359684 C Bo:2:053:5 0 31 >
> ffff8ae1b52d83c0 771359702 S Bi:2:053:4 -115 8 <
> ffff8ae1b52d83c0 771359812 C Bi:2:053:4 0 8 = 00007bff 00000200
> ffff8ae1f0bee000 771359853 S Bi:2:053:4 -115 13 <
> ffff8ae1f0bee000 771359935 C Bi:2:053:4 0 13 = 55534253 0a000000 00000000 00

This is a READ CAPACITY(10) command.  It asks the device for the number
of data blocks it contains and the size of each block.  The reply says
there are 31744 blocks each containing 512 bytes (which is unheard-of
for CDs; they virtually always have 2048 bytes per block).

...

> ffff8ae1f0bee000 771366235 S Bo:2:053:5 -115 31 = 55534243 17000000 0c000000 00000615 1000000c 00000000 00000000 000000
> ffff8ae1f0bee000 771366306 C Bo:2:053:5 0 31 >
> ffff8ae218ff2900 771366317 S Bo:2:053:5 -115 12 = 00000008 00000000 00000800
> ffff8ae218ff2900 771366432 C Bo:2:053:5 0 12 >
> ffff8ae1f0bee000 771366443 S Bi:2:053:4 -115 13 <
> ffff8ae1f0bee000 771366556 C Bi:2:053:4 0 13 = 55534253 17000000 0c000000 01

This is a MODE SELECT(6) command.  This one tells the device to change
the block size to 2048.  The device responds with an error indication.

> ffff8ae1f0bee000 771366567 S Bo:2:053:5 -115 31 = 55534243 18000000 12000000 80000603 00000012 00000000 00000000 000000
> ffff8ae1f0bee000 801899370 C Bo:2:053:5 -104 0

This is a REQUEST SENSE command; it asks the device to report the
details of the error condition from the previous command.  But the
device doesn't reply and the command times out.  From this point on,
the trace shows nothing but repeated resets.  They don't help and the
device appears to be dead.

I don't know of any reasonable way to tell the kernel not to send that
MODE SELECT(6) command.

The log for the Mercury is generally similar although the details are
different.  Everything works okay until the computer sends a command
that the device doesn't like.  At that point the device dies and
resets don't revive it.

So it does indeed look like there is no alternative to making
usb-storage ignore the devices.

Greg, do you still have the original patch email that started this 
thread?  You can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

