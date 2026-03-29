Return-Path: <stable+bounces-230938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO5tHmA/yWk7wgUAu9opvQ
	(envelope-from <stable+bounces-230938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D4352845
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D381300FEF9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D637998F;
	Sun, 29 Mar 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="PYJM/xmG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046A286D4D
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774796636; cv=pass; b=FOs83jZYytFqx9kgGJVkDbtz5yJ0O1q1JS6J83a2pyco8ox/FAM1fKAcTs1stnlquFlf6NZ2B9m+qAwIBIcmkYpm/K+VTVNjnbI5uyJbCsn0RJBcx508PgUnFOc9bv78Dwp4zSpEN/YsSwLApBwxcFt2M/o+OQki0SV13Qn4t0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774796636; c=relaxed/simple;
	bh=7fn3Z+2dnye8ym96U8WpPLIEbXEMZnKCkPCfscZBs5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFBNgq9UoMaXQ9+eMxrMFleGR9pYXyMOB3CCkq2d5nmZkTRt5vhivPC2w+I2NaC7N1oTRIVZRa14vC4HjULMZkAK68DhtQKZZ3cnJKl9oggfbR1Dj1xzmqT6vSgHmdZ+QhRwLCkwE+u39h5souJoOlk6ilQLKKf5yopUM+d5hzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=PYJM/xmG; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64f48a5c3d8so4943550d50.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 08:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774796634; cv=none;
        d=google.com; s=arc-20240605;
        b=FoiRI62UcxhOIHl+dADl38J/n2sFZW2JGnHwTsNQ2W+tGXFS5IxfLpeu5NGQRZfth2
         NqZ+U9NJ56ZJkHdYlfs4xNUkFWsw9Rcd5oabl8cbJ9nNISn6p9s50TZzBUr5IiTQU2xX
         0+nUtICfY+ERdE48Ig0ZwWj5ZiGDYuzICTWlWwutiGCx1wz1cOxqGwwyR1+QpEpOKB2l
         hSj/dGl8ff+M8ZPAb7c2mdaq62asu3qFToIBUO8fmXfVZexS2CU1cLP3+vEgJAN+BI13
         aPoWKRIuVuDEXOnM6BdZfk+G7Y/StvzdOyKM57fvPwf7QkiYhq5lM1UlvcjpdNHPIwpX
         yZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fkpr6x8ZyyJkz5iE6Uzz9ElyoBGLMbtXkFG8ALfJ6/c=;
        fh=RwEWWDC3rGSX1Xhw5kP/tFkiR+SJip6MZKMOQ46tIP8=;
        b=P1CHE2H2r7piwcmpma3d1y4TVyrFZIbTV5mESRNpY8BUEZ2r6k9mK0KGmzmC9QjWMD
         Lr6zWmsfb8Q+ZD83ibekCDh4eyCHxnLs09YLQCkBReuyzgZvyD7xcKBRrlHg4MZZ3m9w
         3uvdyzZGSF62frsqs3tFKqCamEerd5H25s3tsFqYYQ3BbZGpldQ2+sXFWUNXkDW7vo0Z
         G+mysekq+H3IjmYigXL+9MDfM1P+kvrcv31M1u/FeWvqVWkMjBEQRROt7wjtv++XFJ+c
         d7cfXzqNyA8cX5aCXKdKAOf0lx9ZV0oBo9oIwYA7YYqNM5arf6w1bfE0ApDUPKGIdj1N
         MmVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774796634; x=1775401434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fkpr6x8ZyyJkz5iE6Uzz9ElyoBGLMbtXkFG8ALfJ6/c=;
        b=PYJM/xmGj4WlXxJz3E7rYM16yoPekuH/t0vpGv5havGLAAuo2ANVyVZH0dGqwKF811
         uvv4SBd1KoUdDAKyQUHplWJPyqJPzRBvMqIh96SQSb9+A3HO0hvUIfaiRR3Puxe3WJSd
         zQEf1N1d6EM1d1BHTCCQFiTP5L5gHggivWmvrIBJta2mM5pcfen2BrPwLCxoIn1wTRYN
         SiPaEduwkeHBadCioL3rHyF3Ua9BzIc5yuZCgHZ0skXyUjn2uRaElvHwesHIpUXBKCi+
         USKp4nO1XPhRIIoCqVcK/o3CCYws0zx+GZKig0YnQgRjuqVNaFlX55tWeKD0asZLAwq4
         SIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774796634; x=1775401434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fkpr6x8ZyyJkz5iE6Uzz9ElyoBGLMbtXkFG8ALfJ6/c=;
        b=SVvWr751qJWHW2sVPPZsWn6RwlYvXYYipBhowIMdP2lcpc17qVtNHhqRbgg1rmROJn
         AeF2TcIOe5CaIFXCTdSIBal6gY3jNd5NXEOAeF5x5LcjWeozT8+udTW9EsEa86/rvKJ0
         Qqpx3ZMlPtrlf681epMQEWGKzkJGXWbUX9r8GsjXHxMqb3VwRddKSqqH0TolIeT2yOSr
         +ufMd4huxo3hGrS5ydNFreNuxQkm/WWWjZiblCCDznjX+i0oVlK3MvmE38teaPSHWU/W
         HH/LCkjzNEDOF/DjHF9CHPNIbMrF6il+RjKO7T5oPpQ4eKgd+92w3OpG++GcK+f1rmHz
         /Prw==
X-Forwarded-Encrypted: i=1; AJvYcCVqHmVhrZgbJ/uH3wke+cZdgMZ7/cSX6/w2ZTpWeGeVFgNaQ+5Lll1eQAVQSEUfqyj3cmhBBTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7MqbeizLFxgOnpOx926YI0SrnYWYnwKrS29tXZ05ggTR6RdJ
	XdqIffXbLYWApqBSWKuHqUlUWNWNiLQqhrhLO/gE3rLWo2ba04kuYB6OHWgvBAER8fquWDNQuMH
	zSTg0kmp5z6Bk9d21m7mOQ4C4UeYVo/Nj0ZZbW/B6
X-Gm-Gg: ATEYQzzAtdWceJW2+HXqoxlc5I0yi8gE6y+muCBSiETjh7QUxNfP9ntF52AiqR6TPuK
	cpxI8HYHJhPffUIaO2efU7kh1MKH+7QKe25bGuXiCzyQynYnYfPuA3NGQRFUc2o06oQgJDwcoT+
	hh0l1nabXJMnRTv0Xw/rvt9jBE2Dd2ESM9Rg6pMfdHXTXvFrX6F21xR6i1a5lIf/lxAqnWtT+FT
	4Orrh0ZkXxuz5Odtluq7ElK4tbHjLPx9U+UTHtBXn013GwxSq23Oz66PDMLweFlfEs7EvDOK6D2
	8XOIN7T1XFLOL24=
X-Received: by 2002:a05:690e:1c08:b0:64c:9ec3:d710 with SMTP id
 956f58d0204a3-64ff73acdb5mr9325664d50.41.1774796633749; Sun, 29 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321223713.1219297-1-jp@jphein.com> <20260322055354.03399a32.michal.pecio@gmail.com>
 <CAD5VvzBE8Oq80EhFZnZ7kNrRC_rpoR25Ct5-Fg62yDZUHVtWzw@mail.gmail.com> <20260323085845.6bf57b3b.michal.pecio@gmail.com>
In-Reply-To: <20260323085845.6bf57b3b.michal.pecio@gmail.com>
From: Jeffrey Hein <jp@jphein.com>
Date: Sun, 29 Mar 2026 08:03:42 -0700
X-Gm-Features: AQROBzD7GC_TrwPeTrvW3mp5jNE4JvirNKJp_EKtrLyJ9BYIvabbB9bj_SkkwFk
Message-ID: <CAD5VvzDWF7SO0Aytp3K_uXV6ZYoqEqN1dhfv7VtMAHSpHP+qTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] USB/UVC: Add quirks to prevent Razer Kiyo Pro xHCI
 cascade failure
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230938-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[jphein.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,techempower.org:url]
X-Rspamd-Queue-Id: D06D4352845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michal,

I have now tested on 6.17.0-19-generic (Ubuntu 25.04) with dynamic
debug enabled for xhci_hcd and usbcore, and without any of my proposed
patches or workarounds applied. No udev quirks, no LPM disable, no
control throttle -- completely stock kernel.

Results: the stress test passes 50/50 rounds with 0ms delay. On
6.8.0-106-generic the same test crashed consistently around round 25.

The xHCI error handling changes between 6.8 and 6.17 appear to have
resolved the cascade failure. The controller no longer escalates to
hc_died() when the device firmware stalls.

The UVC probe control EPIPE (-32) still occurs at device init:

    uvcvideo 2-3.4:1.1: Failed to set UVC probe control : -32 (exp. 26).

And with dynamic debug enabled, the kernel logs show it dynamically
disabling U1 LPM when the device responds slowly:

    usb 2-3.4: Hub-initiated U1 disabled due to long timeout 16800us

So the kernel is now handling both the LPM issues and the error
recovery gracefully without needing the quirks I proposed.

I have not tested on non-Intel hardware. The firmware is already at
the latest version (1.5.0.1) per Razer's standalone updater.

Full debug log from the stress test is available at:

    https://github.com/jphein/kiyo-xhci-fix

Given these results, it seems like the patch series may no longer be
needed for current kernels. Happy to provide any additional testing or
logs.

JP


On Mon, Mar 23, 2026 at 12:58=E2=80=AFAM Michal Pecio <michal.pecio@gmail.c=
om> wrote:
>
> On Sun, 22 Mar 2026 15:10:28 -0700, Jeffrey Hein wrote:
> > Both failure modes are in the device firmware (version 8.21), not the
> > kernel, so they exist on any kernel version.  On 6.8.0-106-generic
> > (where I tested), the TRB_STOP_RING case in
> > xhci_handle_command_timeout() goes straight to xhci_halt() +
> > xhci_hc_died() without attempting per-device recovery.
>
> Command timeout is a failure of the xHCI controller, not the device,
> and as Alan said, it's generally not supposed to happen so we are
> curious how it happens and if it can be prevented in xhci-hcd.
>
> Device behavior may be a contributing factor, as can be a kernel bug
> or controller HW bug. It would be helpful if somebody tried this on
> non-Intel hardware and on current kernels, because there were various
> changes to xHCI error handling over the last two years.
>
> > The stress test script is in the series repository:
> >
> >     https://github.com/jphein/kiyo-xhci-fix
> >
> > stress-test-kiyo.sh exercises UVC controls via v4l2-ctl at maximum
> > rate -- brightness, contrast, saturation, white balance, exposure,
> > focus, pan/tilt/zoom -- cycling through their full ranges each round.
> > With 0ms delay between controls, the crash consistently occurs around
> > round 25 of 50 (~5-10 seconds of sustained rapid SET_CUR).
>
> OK, I will see if it does anything interesting on my hardware, but it
> may be nothing because I don't have this camera.
>
> Did you try it on a different camera in the same USB port?
>
> > That said, the firmware lockup itself is controller-independent -- the
> > device stops responding to USB control transfers regardless of the
> > host controller.  What varies is the host controller's response to the
> > resulting stop-endpoint timeout.  On 6.8, xhci-hcd takes the
> > TRB_STOP_RING timeout straight to hc_died()
>
> Nope, this is controller dependent because Stop Endpoint is a command
> to the controller and it has no reason to fail. Something is broken.
>
> Could you boot a newer kernel (compile 7.0-rc5 yourself or at least get
> latest release (or beta) of your distribution), enable dynamic debug
>
> echo 'module xhci_hcd +p' >/proc/dynamic_debug/control
> echo 'module usbcore +p' >/proc/dynamic_debug/control
>
> then connect the camera, crash it again and send dmesg output?
>
> Regards,
> Michal



--=20
Jeffrey Pine Hein
Just plain helpful.
jphein.com =E2=98=80=EF=B8=8F techempower.org
(530) 798-4099

