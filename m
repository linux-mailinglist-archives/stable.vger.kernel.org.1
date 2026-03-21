Return-Path: <stable+bounces-227729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OKKCWtKvmkFLwMAu9opvQ
	(envelope-from <stable+bounces-227729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:36:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F12E3FD6
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71963303A86D
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274131AA8F;
	Sat, 21 Mar 2026 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LdqgUubU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008C313E3D
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078553; cv=none; b=lEm5u/I5KxrNGNDaqXNUhmVBpFT2k9m/UPGBACasEaIGnPzAJnTzG8E2lCW5KxNSXW7h8tiqu76WIJ5mVRS06KVLqnBaILnP3BfJlESKrV2yzOUBHzCNy33qEk+L15JHQq0F9CvRj+zdAPqtnnUqgff5BNtkAyeAvTbb8thO8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078553; c=relaxed/simple;
	bh=0kfRGZVCR2radla1OyEeVDoEeTXAXSdO//I39xjPpcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGLzBrgvoezKoJy+FQAl2wrFywtjUyqx8NtZ91qiywooNhWG4WIYXr2iWkm7TARx5yI29S9VS5gU0AIQ4t3bVGNR7cD7yIa7PqD/wfdb/LzkYLaXClpivYZBsITZmjnDjPpPxzxo5N7nqHe7tHWcvQSPWwbPxVKNsRPBm28utd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LdqgUubU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b982d56dac4so114566966b.3
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774078545; x=1774683345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACkMXGUasnKboN1EbrjjGxUNRQtGrlOWqhf8xARdNug=;
        b=LdqgUubUfC6Wh2SLbnpu4SEQgxN7LF6yDTrRmNp7V5z+fEpQ2zSpQY6VUVh8TQ56fG
         h3Bek6Z6qJA3w7f6qp7Yo3Neal+zgWGTvvBv1Yzd4rTtijXa+uEn6C5GRo9l0Or7jpW0
         GpTRBJ963VCTa4r+QPOsNy6eTE0Qxjmho8sF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078545; x=1774683345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACkMXGUasnKboN1EbrjjGxUNRQtGrlOWqhf8xARdNug=;
        b=UyEs8c6ARMg9uQ135YmDYOzkkTO51Z5sbetQ8uga6N+ggycBnGWduJwguDaWZUkc8L
         SHDAQVKl0MRRqgalBwD/Zk6J1/KcjUsw+8hBPfodwYngLd4njQyJxM8Pu4FV4okZ6UsG
         RzHdYqK9G2u7QA5N/a5k0U0pNo8b2K1BYe8be2nQsopJDfRoBBvj0SyOVMYOCp8n68/v
         wA5YBAFnV2B+VLyv85OMUPMBM+QfOG/30/lpBxgRmwykDfHY0sf+kA2v3EVKMVuxB/iT
         TtbbHQ526l40njiWUY270vscVvZ0nWIGF8M7enzb5Lak3jXMhSi3d7TzRS2JgbFeSNAo
         B2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK040BtsMiY4qKuc+WFAG7P+MIpGXQVmmR5Mhwqtt2mw4CDlQ7m6KDkwMOu5h2LI3jWlZdei4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQ+aTItkESJPmOI1ElImgrTawfaocGt2evisZ9xmdYebqDicm
	k7sZ1fDz8YF6Xz8Q+DFYdYmly87Jj9QsjaphQD7GKX9njG2HsS3UHi7Foq4+j0Hb7rSVMmQQeLC
	+kD7zVGKO
X-Gm-Gg: ATEYQzyJh/JwCoPu1df4jqEbShwONMHL+b/PjrZuuz6uJInwRPF+JZC1JZUUdnmfgRh
	hjDEn1QG5PnseqjQ8RTKIZ7XOUPDC1ds+DgyUZ7oPIyYs4aDuwhvxQ+2wW5X/A/QrKLmLV+Zrxs
	Fm+7IrVirjnTuKIWhFppNXUQxWWCicOODfEaLyXCWQO0OZH/WLux8Cnj0rH20QWW5qfc7q7e54C
	VuIrXyyQej1n7zNqxrIplHph0pfbhUhjffzxJThLlD7zDWmHQbHs2sGJnjaBgocr51NIrx2tiVo
	qrITDzot1Nak4n1Eu7hRJ8ekHS+5c3ByPFIUFMebtz0cRYs/DUKNCLeed6VFSEKbveaQx1SO5Nk
	wEz0wcV6joGqHiurW3kOH1/otOfihbW6eYVTDpwnN+fBkD/wCJ2c7RCRvumGJpf2508gqt9Uuki
	40uWMPbN0WQErftEmhCSeRjVFLgR+xt3OcNBK618fPicM1WLktI3xPxbMqeBKNIA==
X-Received: by 2002:a17:906:494b:b0:b97:f120:80f7 with SMTP id a640c23a62f3a-b982f4f026dmr341811966b.48.1774078545272;
        Sat, 21 Mar 2026 00:35:45 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8dff5sm242827366b.24.2026.03.21.00.35.44
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 00:35:44 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1851473f8f.0
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 00:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5Fs3OYIVelkARdxvQfwAiYZOze7afv32SdawzYcxUF0KuMoA8dOU6JDKZR9TknuJ0CJB5aDo=@vger.kernel.org
X-Received: by 2002:a05:6000:220b:b0:439:a958:4342 with SMTP id
 ffacd0b85a97d-43b6427d9c2mr8600460f8f.34.1774078543454; Sat, 21 Mar 2026
 00:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026032152-getting-carmaker-29d5@gregkh>
In-Reply-To: <2026032152-getting-carmaker-29d5@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 21 Mar 2026 00:35:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
X-Gm-Features: AaiRm51BmC3o8HV2Y1InLkH4yrHdWTPi4-FQK8nvRqkR1RYKzTpEt6W1De7LA08
Message-ID: <CAD=FV=Wag5qx9RXkAHrf+zbwtQgVQW1UUc6DRhUzudBtjbD8ug@mail.gmail.com>
Subject: Re: [RFC PATCH] driver core: Don't link the device to the bus until
 we're ready to probe
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227729-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 9E8F12E3FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, Mar 20, 2026 at 10:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 20, 2026 at 08:06:58PM -0700, Douglas Anderson wrote:
> > The moment we link a "struct device" into the list of devices for the
> > bus, it's possible probe can happen. This is because another thread
> > can load the driver at any time and that can cause the device to
> > probe. This has been seen in practice with a stack crawl that looks
> > like this [1]:
> >
> >   really_probe()
> >   __driver_probe_device()
> >   driver_probe_device()
> >   __driver_attach()
> >   bus_for_each_dev()
> >   driver_attach()
> >   bus_add_driver()
> >   driver_register()
> >   __platform_driver_register()
> >   init_module() [some module]
> >   do_one_initcall()
> >   do_init_module()
> >   load_module()
> >   __arm64_sys_finit_module()
> >   invoke_syscall()
>
> Are you sure this isn't just a platform bus issue?  A bus should NOT be
> allowing a driver to be added at the same time a device is being added
> for that bus, ideally there should be a bus-specific lock somewhere for
> this.

Sure, if the right fix for this is somewhere in the platform bus code
then I'd be happy with a patch there to fix it. ...but from my quick
glance (admittedly, it's Friday night and I'm tired), it seems like
the problem is just with driver_register() being called at the same
time as device_add().

Certainly adding some sort of locking could be a solution (happy for
someone to tell me where to place them), but we'd have to make sure we
aren't regressing performance for the normal case...


> When a device is added to the bus, yes, a probe can happen, and is
> expected to happen, for that device, so this feels odd.
>
> that being said, your patch does seem sane, and I don't see anything
> obviously wrong with it.  But it feels odd that this is just now showing
> up for something that has been this way for a few decades...

I suspect it's a latent bug that was triggered by a new Android
feature. It's showing up on phones that have
"ro.boot.load_modules_parallel" set. I think you can get to the
relevant source code at:

https://cs.android.com/android/platform/superproject/main/+/main:system/cor=
e/libmodprobe/libmodprobe.cpp?q=3DLoadModulesParallel

I suspect the bug is never triggered with more normal module loading
schemes. Indeed, one phone that has nearly the same set of drivers but
has parallel module loading turned off has no reports of this
problem...

I'd also note that the only actual symptom we're seeing is with
fw_devlink misbehaving (because dev->fwnode->dev wasn't set early
enough). fw_devlink is a "new" (ish) feature, is officially optional,
and isn't used on all hardware.

...so I think there are enough reasons to explain why we're seeing
this now even though it seems like it's been wrong for a few decades.

-Doug

