Return-Path: <stable+bounces-121108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C9A50C13
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E653D3A21B4
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6223254B12;
	Wed,  5 Mar 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJnfnsy7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC29249E5;
	Wed,  5 Mar 2025 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204681; cv=none; b=nZCWAs1XI3XRQpH5IfXVcmhn98nLC81ykA1of+zNyHgN0N+0uYJ6FKVoCfOrDr8eKfKjLIXYyYGIJWmlRHnOIjulQPjihd3wnErPV28/G8Kaal5I6fOTcCKJpFQI+I0YPcBB/UPKTvq+nc2aWAs6VKnp88fxaBruDskdJOMgpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204681; c=relaxed/simple;
	bh=3SofOfUEe1y4VYfO2piZ8r/sTxcae5BWEc8HQTleXOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXuRdIWja4RBB4zJcwWPXyywxywYxghgJCTP3cTbjC75aUMCdHhXaYkSUH0BODBF7gq1agdewNxQ9BH1Wii1JkWeoUft6OmfikHsIj0iv9U0cy3c5tKVA7SZs1PIZfQ31qzlEDnKYk57ARwLGDxlYgusDo+PtBCLtHZh20VVmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJnfnsy7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso9728745a12.2;
        Wed, 05 Mar 2025 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204678; x=1741809478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/ZXpjJi+S5vVQ+v/vLI8CHzh++7gcgmV+BrUYvx3Nk=;
        b=hJnfnsy7Ed3T4rfVM7OKM4UZDtCJePkp6ZDWXaOKrEmhRyw3b/L9RXVBIsEZsOSZ1G
         5FuAEFKSJNsdQDXodVAs4jrv4GOddAnxd4vvuPjn9Z+Ot/mjLR8ldTUeRCK+/o/S0zsh
         g8hHaqrhT6qDeOGCq9rylOavsHQlU2w+Ugg5Tae9xmUir40wfvArJfRWxqqhiP+hA10l
         1V3xzks3RZyibn3kVEmgrZSRjAorrecL3+Tx/xLhZIziJ1St524GLvSIGb37BtZlD643
         8I+cvtmkUvCH+dEo5JFxGYEUOz7NFVszD+xxAo5ra+fFUNdOsTuOGdstqZ5jYqdAXMJM
         AHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204678; x=1741809478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/ZXpjJi+S5vVQ+v/vLI8CHzh++7gcgmV+BrUYvx3Nk=;
        b=j9//xN9GI01AlcDGX2EH1pyVIrEWm6sUgEHpcW5lkD/eDXn3NHg3o57OKRJcgg/By2
         3q0Efg+njUwMEBN1quUcmbyzLJ3gdryVdxjJEmfpywBj/RRLVmxyR+Ct40MfadX4CTUJ
         imgqFvNMzbZt5E9Gdb942RCQQfNTdOK+jEmcxZJ6CPvikhaOR7p2HSqEy88SqVWXydTW
         cF5HzMvgE12O9sVK+9MVbJWuyfIl815rzuqu9pbjLziknMo6T6KZMcG6A4XuSd65QbzV
         f69VolsUU4OqRO7RfJC7kpPE3whRg5jGgU2YRmIlALPuMxbbOdLeYGLaB2co/jFXpJ7t
         VvVw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KhubH7J4D1CsFql7AGcI8LeI/DxY+PRzShHC6UW2hQ+5E0SX7bOfxU/u//naOZa+9CO5/tlK@vger.kernel.org, AJvYcCW+dnMXW+vEQpaDH+9UzqNLClIyeRfgb7rQ2QoaNd44UXeebW6V8t/Ne6L6zEm5kLsDpj8xMSuucPLtF8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZmCWY2pYXkdHuWAuWOWoWHK+f5hALtH4axs8fOfQY337t7EH
	0ZfNyCEjTwtnm/PyD9Ct3p1gEQTI4D4yFsQS7monPaOAIDUeoJSXdZ1VAEacpVCdyCZzlBw29bp
	PtcML6xWgTX5o5kgFvgctDe1Dk7E=
X-Gm-Gg: ASbGncvcx1FjhYk/EKrVfWB8KL219bKu7z/q+KllKl5tKpy7U9r2ry6KF0dq16pNsuz
	XABOiaH62VQtFiBC5V8675Zk3K2Pz+FrGiInoh3iSWawFSS0NWBXNVcJj4vkHHqcYDJtpOUscGN
	VswOQpweI4SYiOgwEnZQwDIYTv
X-Google-Smtp-Source: AGHT+IEuPBQlxzGis7PUyBClL+qVCjee9w2SsaScpchDplJcvi/zqf/o++iTiWSQpCI+U46NgmAzyGnlqYNRUYoLkUw=
X-Received: by 2002:a17:907:2da2:b0:abf:7af6:ea64 with SMTP id
 a640c23a62f3a-ac20da89861mr509314966b.45.1741204677419; Wed, 05 Mar 2025
 11:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
 <2025030559-radiated-reviver-eebb@gregkh>
In-Reply-To: <2025030559-radiated-reviver-eebb@gregkh>
From: =?UTF-8?Q?Se=C3=AFfane_Idouchach?= <seifane53@gmail.com>
Date: Thu, 6 Mar 2025 03:57:41 +0800
X-Gm-Features: AQ5f1JpQ1z6G7iloHzXVBiJZ3GUkFE92JcFSnEm6C7EdbyJf1xaWNLQKx29oq8s
Message-ID: <CAMpRfLMQ=rWBpYCaco5X4Sh1ecHuiqa91TwsBo6m2MA_UMKM+g@mail.gmail.com>
Subject: Re: [REGRESSION] Long boot times due to USB enumeration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dirk.behme@de.bosch.com, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 2:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Mar 06, 2025 at 12:32:59AM +0800, Se=C3=AFfane Idouchach wrote:
> > Dear all,
> >
> > I am reporting what I believe to be regression due to
> > c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> >
> > After this change I am experiencing long boot times on a setup that
> > has what seems like a bad usb.
> > The progress of the boot gets halted while retrying (and ultimately
> > failing) to enumerate the USB device and is only allowed to continue
> > after giving up enumerating the USB device.
> > On Arch Linux this manifests itself by a message from SystemD having a
> > wait job on journald. Journald starts just after the enumeration fails
> > with "unable to enumerate USB device".
> > This results in longer boot times on average 1 minute longer than
> > usual (usually around 10s).
> > No stable kernel before this change exhibits the issue all stable
> > kernels after this change exhibit the issue.
> >
> > See the related USB messages attached below (these messages are
> > continuous and have not been snipped) :
> >
> > [...]
> > [    9.640854] usb 1-9: device descriptor read/64, error -110
> > [   25.147505] usb 1-9: device descriptor read/64, error -110
> > [   25.650779] usb 1-9: new high-speed USB device number 5 using xhci_h=
cd
> > [   30.907482] usb 1-9: device descriptor read/64, error -110
> > [   46.480900] usb 1-9: device descriptor read/64, error -110
> > [   46.589883] usb usb1-port9: attempt power cycle
> > [   46.990815] usb 1-9: new high-speed USB device number 6 using xhci_h=
cd
> > [   51.791571] usb 1-9: Device not responding to setup address.
> > [   56.801594] usb 1-9: Device not responding to setup address.
> > [   57.010803] usb 1-9: device not accepting address 6, error -71
> > [   57.137485] usb 1-9: new high-speed USB device number 7 using xhci_h=
cd
> > [   61.937624] usb 1-9: Device not responding to setup address.
> > [   66.947485] usb 1-9: Device not responding to setup address.
> > [   67.154086] usb 1-9: device not accepting address 7, error -71
> > [   67.156426] usb usb1-port9: unable to enumerate USB device
>
> That's a real issue, but should not be due to the commit id you
> referenced.
>
> > [...]
> >
> > This issue does not manifest in 44a45be57f85.
>
> What does that commit have to do with this?  That's just a build break
> fix.
>
> > I am available to test any patches to address this on my system since
> > I understand this could be quite hard to replicate on any system.
> > I am available to provide more information if I am able or with
> > guidance to help troubleshoot the issue further.
> >
> > Wishing you all a good day.
> >
> > #regzbot introduced: c0a40097f0bc81deafc15f9195d1fb54595cd6d0
> >
>
> We know there are issues here.  That commit was "fixed" by commit
> 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race"),
> but then that caused a different problem, so it was reverted by commit
> 9a71892cbcdb ("Revert "driver core: Fix uevent_show() vs driver detach
> race"").
>
> There are many discussions about this on the mailing list, with a
> proposal to add Dan's "fix" back.  If you could try that, it would be
> great to see.
>
> I think your USB problem is different here, but if you add 15fffc6a5624
> ("driver core: Fix uevent_show() vs driver detach race") to your kernel,
> that would be great to see.
>
> thanks,
>
> greg k-h

Hello Greg,

Thank you for your time.

> What does that commit have to do with this?  That's just a build break
> fix.
This commit comes right before what seems to be the bad commit. I got
to the cited (maybe) bad commit after a bisection and wanted to
confirm the results.

> I think your USB problem is different here, but if you add 15fffc6a5624
> ("driver core: Fix uevent_show() vs driver detach race") to your kernel,
> that would be great to see.

After reapplying the patch (15fffc6a5624) at v6.13 (ffd294d346d1), it
indeed does not resolve the issue.
The behavior is bit different than at the reported commit
(c0a40097f0bc) in the sense that it seems that the block is happening
earlier in the boot before even systemd has started because there is
no mention of a wait job.
However the end result is still the same; the boot will only continue
after the "unable to enumerate USB device" message.

staying available if you have anything else

