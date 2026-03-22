Return-Path: <stable+bounces-227864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILr5EgtpwGlkHgQAu9opvQ
	(envelope-from <stable+bounces-227864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:11:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F812EAFA9
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE15300A3B9
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2F37E2E6;
	Sun, 22 Mar 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="IuGXGlHa"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5F2472AA
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217442; cv=pass; b=j7khmymdt7S7/DFnfrvjBDYs7Uh4UJlmaE66TjLAFS9zrCFsdW6fOFw5iCsQy4Y54zdmiv5d9IsOix2Pg+1ZDi4oS0ZtCLTJkfMlYguR7YLoYsFj6w9zkNqW31sopY3fAitTWcktOGMbH/hohr9VpyXgMyxGWJFjsVx8EoVL6cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217442; c=relaxed/simple;
	bh=x1w5Bh0hXE+R1kbLYv8/Hm/OkWz4e0lUE37K2HZ1y7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auLcB67iplgV0gQqki3jZMAkiDC0Lk0mBMvhixuP1R8ReP8m4Sqv8XrZ3CYSoOj9dX+T4Fp4+r1zuIuAe7O1nNooJUBJaA3/9vbHNudfgCvD2hxiD5OaRVetTJGqwAWCjdSChndGzWHGTgUDBguOHu0aB/if9kMLqBgmGHF3BHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=IuGXGlHa; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79ab0e9c6a9so3233257b3.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774217440; cv=none;
        d=google.com; s=arc-20240605;
        b=cQ3GUAo3S7PffKvyC5t3A8PpXK3/la02Wd99egde078JootNtFb8JkKURs8UvTykBz
         4Etcs4Ev8wo8tLkKg3Wk7vhEaUFoVo+sKv3xQ3R6wssIRQkztnhbTxizw49L/dzkH7Jm
         fCHeQ3VfZrrp4E7CEFZbY+aIVF98oFevy6LdFZLreuRew99DS+h0oqv+W6D1foh3Lrml
         4+NHhlS6U7lKUAYE5qZHM+ES2rB2SIVt+NhzzPsPhJANmnOLQD8MkIAW2fohd5py3aHV
         VzuJa2mNMnQ1BbnKCklKkNPuYJaB+UQDY4AVlD6lwpdkajBwYgpSmJIs6CHve6h9+EOI
         1lUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=maqbUFDVU1fBNlyXTgUimX3uQ68hwxMNeXFRVOxQKxo=;
        fh=wdQ+KbHNPO44iz4Tm/oV3JWJUfHRaDrUBWkH3kW9Sag=;
        b=Ri9a/MADRb/scv1dDlYiXID+N127YpdhrGRYYdhBhAD5b552hnTCFogq+DP5cecOGj
         Y06vTywGDg95fQfBOjhSXFnqhJ+MXG6cFjgDoasj8dPe7Eyc/R+dKHbJcHv8He3ReC5F
         78tU9B6F1lONkl0ug22xYx+Me+scBZELH063wlChql9/fVNv9oYu35/5Khv8zMJAoUGG
         0m93FOX14EaWusQPBfDg+GkUlSk2TUk/w1212yQbG8DLYlyKcEjoM3rvneLI7jwvxqc/
         S9jIDfHj8RgLrF5n1SkS0a2iEpnKxnzJk+tOPmYbOIumKrtDAlaIkgqchTN/rXOo7Kpo
         7uJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774217440; x=1774822240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maqbUFDVU1fBNlyXTgUimX3uQ68hwxMNeXFRVOxQKxo=;
        b=IuGXGlHa4iH+Gcl8bb3EaOnNcJ9RRFEMwHQ7+dvu13CvZhC/k8a3BpgiCxclaCRjTn
         h6P5bT1AnsG2fo+JKsMCnbAUTsuoS2xMMFrI94Q0QQLd+1NYC1X0CkKdBhf1KGNwc+kt
         x41naSrQPydOKrO26TQeN0r48fMo7Vs9SkLPlZjrj22lQT/uN2sWjmwFslMe53ofXxcn
         Gmj4oFHqB1ONXUpdyIPGpPEyIV9OjGL77vmNNznDy6qk14/CM+4+++6kwGrHRQvlAb6Q
         HRFJqNoD/gVQi9cCF1EtjMJRNgVbIYGKZuy0d8hsWLGQFYgkXHHvwf+igorImMOVi/yv
         FeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774217440; x=1774822240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maqbUFDVU1fBNlyXTgUimX3uQ68hwxMNeXFRVOxQKxo=;
        b=V1esjED+Y6jbru1lbZBOequAo/NyUBoGbFQXxDBRwc+0YbKb8AIPLzdRPvLuIgA7uc
         hE2CrR2WWlTgFCSPGCOTRQi05XGHBElldqvGwj/umDQ4Vd1TSlrZA65Lexzv5EGEYgOG
         mLnHDdp9MlrOxfz2r7SoXnZmihEnWzIwfq1HHJT1gv8Qto2PgSdE8zBKIjxIB18YC8dM
         hXCaqZLJ+/kEXLpYDUbOK34GHst+gL/XsesM9hLcWoQ637bV8ZQ/WTKSX4NbHrNcM59V
         S9Ulqg8AA8dnLY9rlvB8SMGSCows/0GPaB9ympWD/YjH513zyP5l4MwasLbFRssGzgDk
         NOnA==
X-Forwarded-Encrypted: i=1; AJvYcCWUoBFclA8xlKKZmUBjhuMIq28sM0wOpX9R/dElS+REuETgKEVnip3OoEwJaf9L4u842C3dT80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZD2PUAZCknz9rRHD2WdNpRJATq72vomNsxjmXkC0CivA6CN5
	Hsf8essvmukYWE+iKJVvv1scRlaB9gZ63tEPlwNA+28U/08LVLIUpoIiu2zp8mhdVd54HPlxcIX
	yuezm7D8iETv3pUO0y86m5cGQBO/LFZ1hZD0Z9ehz
X-Gm-Gg: ATEYQzzzTl677mwdSw7v9DARKToyfkwIMtKzypWlUhO3leq1ACF8bPSujhfdqQqCDTO
	MeHjaJE4If76Xnwr7t1mSP3pu0omHJQRs27m2ogsvEpj3SzhAMyYzZ1YqdFKK8QCN0pnFOS2nrD
	80P5mV0XUTf5N/C6WpK8YQkeT4mq7xR2g9X7RjVDdp+1x17yTibTFGZTOCnLCURiKNc1U3fRYiD
	XTdhuHrwh5X4drGLR8uTxnm8AiKEate65tmH2bXuM2+PdI2lFU2glz5WBLHOKeErTmZOYbt+K2k
	Igu/
X-Received: by 2002:a05:690c:112:b0:79a:ac83:ac7a with SMTP id
 00721157ae682-79aac83b0ebmr30223357b3.36.1774217439889; Sun, 22 Mar 2026
 15:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321223713.1219297-1-jp@jphein.com> <20260322055354.03399a32.michal.pecio@gmail.com>
In-Reply-To: <20260322055354.03399a32.michal.pecio@gmail.com>
From: Jeffrey Hein <jp@jphein.com>
Date: Sun, 22 Mar 2026 15:10:28 -0700
X-Gm-Features: AaiRm50oRG8Mr0cjFR7cCSGQaef51kLZ44-yoCLNOycpoaWX8w5YS5O5MF0Hd74
Message-ID: <CAD5VvzBE8Oq80EhFZnZ7kNrRC_rpoR25Ct5-Fg62yDZUHVtWzw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227864-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,jphein.com:dkim,jphein.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stress-test-kiyo.sh:url,techempower.org:url]
X-Rspamd-Queue-Id: C1F812EAFA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 09:54:00PM -0700, Michal Pecio wrote:
> On Sat, 21 Mar 2026 15:37:02 -0700, JP Hein wrote:
> > This has been reported as Ubuntu Launchpad Bug #2061177 and affects
> > multiple kernel versions (tested on 6.5.x through 6.8.x).
>
> > Tested on:
> >   - Kernel: 6.8.0-106-generic (Ubuntu 24.04)
>
> How many of those problems still exist on current releases,
> where these patches would end up applied?

Both failure modes are in the device firmware (version 8.21), not the
kernel, so they exist on any kernel version.  On 6.8.0-106-generic
(where I tested), the TRB_STOP_RING case in
xhci_handle_command_timeout() goes straight to xhci_halt() +
xhci_hc_died() without attempting per-device recovery.  I have not
verified whether this path has changed in a more recent kernel.

I have personally reproduced the crash on 6.8.0-106-generic (Ubuntu
24.04).  The "6.5.x through 6.8.x" in the cover letter was overstated
-- I should have said the Launchpad bug has reports across those
versions, but I have only tested on 6.8.

> Does anyone have a repro?

Yes.  The stress test script is in the series repository:

    https://github.com/jphein/kiyo-xhci-fix

stress-test-kiyo.sh exercises UVC controls via v4l2-ctl at maximum
rate -- brightness, contrast, saturation, white balance, exposure,
focus, pan/tilt/zoom -- cycling through their full ranges each round.
With 0ms delay between controls, the crash consistently occurs around
round 25 of 50 (~5-10 seconds of sustained rapid SET_CUR).

To reproduce:

    bash stress-test-kiyo.sh 50

With the CTRL_THROTTLE patch applied (50ms rate limit), the same test
passes 50/50 rounds reliably.

> How does it behave on non-Intel USB controllers?

I have only tested on Intel Cannon Lake PCH xHCI (8086:a36d).  I do
not have a system with a non-Intel xHCI controller and this camera to
test with.

That said, the firmware lockup itself is controller-independent -- the
device stops responding to USB control transfers regardless of the host
controller.  What varies is the host controller's response to the
resulting stop-endpoint timeout.  On 6.8, xhci-hcd takes the
TRB_STOP_RING timeout straight to hc_died(), which kills the entire
bus.  A controller whose driver implemented per-device recovery could
isolate the failure to just the offending device.

The NO_LPM and CTRL_THROTTLE quirks operate at the USB core and UVC
driver level respectively, so they prevent the firmware from reaching
the lockup state regardless of which xHCI controller is underneath.

JP



On Sat, Mar 21, 2026 at 9:54=E2=80=AFPM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
>
> On Sat, 21 Mar 2026 15:37:02 -0700, JP Hein wrote:
> > This has been reported as Ubuntu Launchpad Bug #2061177 and affects
> > multiple kernel versions (tested on 6.5.x through 6.8.x).
>
> > Tested on:
> >   - Kernel: 6.8.0-106-generic (Ubuntu 24.04)
>
> How many of those problems still exist on current releases,
> where hese patches would end up applied?
>
> Does anyone have a repro?
>
> How does it behave on non-Intel USB controllers?
>
> Regards,
> Michal



--
Jeffrey Pine Hein
Just plain helpful.
jphein.com =E2=98=80=EF=B8=8F techempower.org
(530) 798-4099

