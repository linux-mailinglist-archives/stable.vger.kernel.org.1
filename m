Return-Path: <stable+bounces-25771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3886F0FD
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03F71F21EDB
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DCA18C01;
	Sat,  2 Mar 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b="BVphM/uX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC118643
	for <stable@vger.kernel.org>; Sat,  2 Mar 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394912; cv=none; b=Wgpev5uFffwWcCaQ72ZqQaU4fD70NNPdgSJo1u1s/MLBeNdcksv/MXThvuOQ7ZYkwNUQvblbFNOURKRlHwvgM1pLWmBpuvJnS7ljvE/DV4uNDDLIY6blXsKWAxSI5ovR0NkaVHYyyxbtoq5w/RYdEnl5gTRAoczPlajkQvhwdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394912; c=relaxed/simple;
	bh=+lZd/t3aeJFOJkO3SAmJV5Dp1Qi1wNboqehWKCeKblw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iNF8Kqya1L/ekHv1WfzTjR8hC7SbmU8otkjCfEDHqgJH0vrJrI6K6NAmTnHZVTOnB7+S97cDZ2/e9FVkyX71oixsP4AbXSbQmGF+s9QCq/gSgVB5b19cig83AmeKonrenhkjRUMZjbAwSvzpDeSyjb6z8HSsmkVuvhaaR/Vii8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com; spf=pass smtp.mailfrom=totalphase.com; dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b=BVphM/uX; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=totalphase.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-7c835cfbff3so24128239f.2
        for <stable@vger.kernel.org>; Sat, 02 Mar 2024 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=totalphase-com.20230601.gappssmtp.com; s=20230601; t=1709394909; x=1709999709; darn=vger.kernel.org;
        h=thread-index:thread-topic:content-transfer-encoding:mime-version
         :subject:references:in-reply-to:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OV8vY35zr5cSwjKz+HhAMZSUpAUv0QIiybaMeTV+MCk=;
        b=BVphM/uXtK7dRzzJcGHeCBx6S+UP4iJ4/PbEtbE4qkEnerR1b68bvD+OFiCAH8FDvV
         3M16l9xqdis4SBzJLDh5BeC54ecUyfBC5rfl34hiJ6UV2WSvs91HjHNLs7iJvFzuL0xR
         hGeWkdJ6/dcF3t7RM/9ygEEiIS1QimK3upJ5wG9dGfnKFw80XS4rotW/bPusHkcXZr/z
         A6GQzGfLF34Q1tYjKmeJOsFt8wpztM1NouALaeprf7XxQOpesKiqtED7JaukriOQrcSs
         qmhvL27RuLmI2fYCU8unOn3uKF/qjUznKcQjJ8BztI05uodh/KkOhB9wfQhVeB6VADFA
         4GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394909; x=1709999709;
        h=thread-index:thread-topic:content-transfer-encoding:mime-version
         :subject:references:in-reply-to:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV8vY35zr5cSwjKz+HhAMZSUpAUv0QIiybaMeTV+MCk=;
        b=bLyOiotN4JRiKRF/Lm2l5un2Vz0SV6VQZwFuPFnNFqKAwjh0Xnrq5p2qzdf4frnr/G
         wEPVItosl7cy0/sKRW9lUajZ/JZAWrzU/1+xtkeAkmYv+VvGE4PJo52LS83jc1lOkPrx
         XJ2/wF5Fvr2vf+7lWZSr5SAEyBCGRYH25Wk6LHLw8OOeVabCATHOvFecz9qpdC54fcB5
         lrjRD1AjOUK+c9dGbYQ/1uvB7+BBLi3qsb5HXUvhS7wz2fbDJflU/STiyfKB2Cvt/Kgk
         SHEB1bbYauU6qj4v0mUQyH9Qwde6NyGLZGC+CfXVKHbXzHGLUhOfGkQ2fClLFYdV9Aax
         EfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv7XcXRFQ//ex9jGmOLmjEsVNCFwPynLF44fhzefJ4083Dr1H86kWGq/n/trM51FrFh9OiLbdduTX8wGra6PHywEgLqq74
X-Gm-Message-State: AOJu0YwXnmkHqd8eqm1ReXepJZ1OAyMNJGCJvJqA2bCFGNQeMACJSWYm
	qRnygxUd/6pQx5/E8wBq5CUwYxZRmKwpG+RT4VXOlco86KMR4B8chbzhPr66k0nRqoMTYv/Hn/z
	lh//WDOWxpXQjdpay2H6baS0PF6ER34Az
X-Google-Smtp-Source: AGHT+IEASUmJ8UX4EjiNghHA7OE6AVyT7bJS2HDj85FgxhLV3wyehvk9DvNqHnVTE9Zro9Fv4jBRg/drfrEl
X-Received: by 2002:a5e:db4d:0:b0:7c8:2702:404 with SMTP id r13-20020a5edb4d000000b007c827020404mr3980889iop.16.1709394909546;
        Sat, 02 Mar 2024 07:55:09 -0800 (PST)
Received: from postfix.totalphase.com ([65.19.189.126])
        by smtp-relay.gmail.com with ESMTPS id u8-20020a05663825c800b00474d7f5aac1sm56404jat.57.2024.03.02.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 07:55:09 -0800 (PST)
X-Relaying-Domain: totalphase.com
Date: Sat, 2 Mar 2024 07:55:06 -0800 (PST)
From: Chris Yokum <linux-usb@mail.totalphase.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, 
	Chris Yokum <linux-usb@mail.totalphase.com>, 
	stable <stable@vger.kernel.org>, linux-usb@vger.kernel.org
Message-ID: <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com>
In-Reply-To: <2024030246-wife-detoxify-08c0@gregkh>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com> <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info> <2024030246-wife-detoxify-08c0@gregkh>
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Thread-Topic: 6.5.0 broke XHCI URB submissions for count >512
Thread-Index: U7u/lEsn8LBuZiRKVfQo3d1lBXRc5Q==

Hi Greg,

Thank you for the quick follow-up!

The submission of >512 URBs is via usbfs, yes. This worked forever, and still works on EHCI, it's just been failing on xHCI once the indicated change was applied.

We see failures of our products due to this, which use usbfs. In order to create a simple repro case, we picked a few USB-to-serial devices that we assumed you would have in your possession, removed the kernel function driver, and accessed it in this way via usbfs.

There is no specific xHCI controller or USB-to-Serial adapter that always works or always fails. This is quite easy to make fail for us though. I primarily note this because the fail is not 100%, but it is pervasive.

We could reproduce within qemu, plus on older Celeron systems, i5-1240p, AMD Ryzen 7 5700U, and many other reported failures from the field.

Here is the output related to a failing case:

user@linux1:~/xhci_bug$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 10c4:ea60 Silicon Labs CP210x UART Bridge
Bus 001 Device 005: ID 0403:6001 Future Technology Devices International, Ltd FT232 Serial (UART) IC
Bus 001 Device 003: ID 0424:2514 Microchip Technology, Inc. (formerly SMSC) USB 2.0 Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
user@linux1:~/xhci_bug$ sudo ./xhci_bug cp210x 1 6 1024
Before URB submission:
512 /sys/kernel/debug/usb/xhci/0000:00:14.0/devices/05/ep04/trbs

Submitting 1024 URBs

After URB submission:
512 /sys/kernel/debug/usb/xhci/0000:00:14.0/devices/05/ep04/trbs

user@linux1:~/xhci_bug$ uname -a
Linux linux1 6.8.0-060800rc6-generic #202402251933 SMP PREEMPT_DYNAMIC Mon Feb 26 00:46:39 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
user@linux1:~/xhci_bug$ 



----- Original Message -----
From: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
To: "Linux regressions mailing list" <regressions@lists.linux.dev>
Cc: "Mathias Nyman" <mathias.nyman@linux.intel.com>, "Chris Yokum" <linux-usb@mail.totalphase.com>, "stable" <stable@vger.kernel.org>, linux-usb@vger.kernel.org
Sent: Friday, March 1, 2024 11:14:50 PM
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512

On Sat, Mar 02, 2024 at 07:53:12AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding the people involved in developing and applying the culprit to
> the list of recipients]
> 
> Hi! Thx for the report.
> 
> On 02.03.24 01:27, Chris Yokum wrote:
> > We have found a regression bug, where more than 512 URBs cannot be
> > reliably submitted to XHCI. URBs beyond that return 0x00 instead of
> > valid data in the buffer.

You mean 512 outstanding URBS that are not completed?  What in-kernel
driver does this?

> > Our software works reliably on kernel versions through 6.4.x and fails
> > on versions 6.5, 6.6, 6.7, and 6.8.0-rc6. This was discovered when
> > Ubuntu recently updated their latest kernel package to version 6.5.
> > 
> > The issue is limited to the XHCI driver and appears to be isolated to
> > this specific commit:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb?h=v6.5&id=f5af638f0609af889f15c700c60b93c06cc76675>
> 
> FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
> calculation") [v6.5-rc1] from Mathias.
> 
> > Attached is a test program that demonstrates the problem. We used a few
> > different USB-to-Serial adapters with no driver installed as a
> > convenient way to reproduce. We check the TRB debug information before
> > and after to verify the actual number of allocated TRBs.

Ah, so this is just through usbfs?

> > With some adapters on unaffected kernels, the TRB map gets expanded
> > correctly. This directly corresponds to correct functional behavior. On
> > affected kernels, the TRB ring does not expand, and our functional tests
> > also will fail.
> > 
> > We don't know exactly why this happens. Some adapters do work correctly,
> > so there seems to also be some subtle problem that was being masked by
> > the liberal expansion of the TRB ring in older kernels. We also saw on
> > one system that the TRB expansion did work correctly with one particular
> > adapter. However, on all systems at least two adapters did exhibit the
> > problem and fail.

Any chance you can provide the 'lspci' output for the controllers that
work and those that do not?

thanks,

greg k-h

