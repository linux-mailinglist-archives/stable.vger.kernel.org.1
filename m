Return-Path: <stable+bounces-33059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9988F93E
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AC42993AF
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C692F54672;
	Thu, 28 Mar 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqZubEzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75E51C34
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612510; cv=none; b=rj+8K6v9KMKNBNUKRIDhe4JquMwv3p44plb0u1ceFxW2bih6WxW6Ja012ywseY/nneDegyuDMn66XchVXe2V2sVti/kfozKpfyHA68c8lB9tSMCftMpAmGkbiz59SZAKsy7yUC9Dcz3/6UTL77g6VFTp11zmJszoqsnz+K1x5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612510; c=relaxed/simple;
	bh=gZ1qyJh2Qrd3XWQIyBxd5BobVBXzD3p79JpF8h4a0So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqZ9jQKiyNjroKaNJ5WB1crxsFB7o7QA/7X4Z446XCCni4SAstQ+pLRiA3WfqbLLL1bfQs1YGikPxeH1rCyARuoHylaIHJ3V21CSs0t8Xzig6FI5S3q90qeqNa2067Tne3UvUjOVY8CMBu4KYoegim/zxZdgzQhVqiRZmXenASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqZubEzo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-431347c6c99so168541cf.0
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711612508; x=1712217308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmYk1ChOh2+sYhuhWKZpvOeBoBDTF/kZuwK0JAtFJW0=;
        b=ZqZubEzo3KqxSua8J0qz0gZi9G7QfWI9cpXzhWXINjG3dPGaG9Gld7ufN4RFDv0kBV
         0vzv9NZNYAZhhLfawEHUe2w0RcFIdhJPysFJRnlNE+jyZX7Su+9o/1USw+mjmwsVtXk9
         krhqTxz0m81+Umtgf9SzXUupmbKMySGHhSWYO2+ye/JmupW86ryAHN2xjI2y9RHik7Bl
         r1jWJweXj3wNR3O190cb5DG9REkWz51OxvV36PIXg2Pv6Idf1sQqF90SP/vLqos/v9Ct
         pYPFZrew7NixNYw5ki1KTgJacyXb0x0A9oPoo+jXni7oIYogajsf40zSULLIDQWPIBd6
         8CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612508; x=1712217308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmYk1ChOh2+sYhuhWKZpvOeBoBDTF/kZuwK0JAtFJW0=;
        b=t4crbTaDTyOzHBKLyA5gN7idX8Fed5YTMsOhnTD5SLzPDePRDU7R+0af4sq+I1Thng
         SY+OXM9qM580++2KUCPqdTaGjfW6jPqHM3fE8a/iAYLLyOxxTqqkkC1iTjLVeysaOU6g
         TL/YEOc6Ry6w4EakRPt32h4F8xf58aFIszUYBBmIkkTO8GqNsWizlIqXZBpbS8JzwSS0
         4WBDmoTw0uXECJO+r9cXiAu89fb72ozGQEzapWy+YXZcFfDllwDN2SI4WBovBZZfq+JA
         MJ8YhRnyiHyFaLGN7wKz/9MTtEkfkHeB37J8Ip3i8hsdaVVvZfADlhtOSwedia+niml0
         w5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvLWS07BM2kyCMGAnGtjorDg38YO/ykQgfL8ucMpYAYeaQBKt6DeC4GPoAfrL13vKMSc1vij1B9Wr4RK9AR0fp3sdxprzS
X-Gm-Message-State: AOJu0Yyhri0kz/j+droO4m4kbIoCwFAu9C9do24QHKTNqG0OimI8ApHe
	QZwff1duXlLV1AuJtf/glE1u/dvmm7jPvx15OBXDpNJfytdewHVX0X0kyRj5o5iR5yENexn7IIc
	mWwDL77uCXjMpWRIxaqMB+f0vStVNOUFMBhMC
X-Google-Smtp-Source: AGHT+IE7qL4ZajIWelVJF5EIJxvF4LYzspcZJp+tq9C1DskYuPv5mLz3VhFsNepq9yGLX98SN7fOKG8JtHC6UySCzwo=
X-Received: by 2002:a05:622a:410a:b0:431:8151:e7c1 with SMTP id
 cc10-20020a05622a410a00b004318151e7c1mr239703qtb.4.1711612507578; Thu, 28 Mar
 2024 00:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141801.396398-1-khtsai@google.com> <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
 <2024012724-chirpy-google-51bb@gregkh> <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
 <CAKzKK0pmswLnGa8zabp_wo=6BcvCd9DR368FCJ5mcpZ38i4Jdw@mail.gmail.com>
In-Reply-To: <CAKzKK0pmswLnGa8zabp_wo=6BcvCd9DR368FCJ5mcpZ38i4Jdw@mail.gmail.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Thu, 28 Mar 2024 15:54:41 +0800
Message-ID: <CAKzKK0rWPzEM8e76oY+PB3ZWUbUaQS21dLbcbTiPufbnFkxbgw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, quic_prashk@quicinc.com, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg and Jiri

On Fri, Mar 8, 2024 at 7:47=E2=80=AFPM Kuen-Han Tsai <khtsai@google.com> wr=
ote:
> On Sun, Jan 28, 2024 at 9:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Thu, Jan 18, 2024 at 10:27:54AM +0100, Jiri Slaby wrote:
> > > On 16. 01. 24, 15:16, Kuen-Han Tsai wrote:
> > > > Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check=
 in
> > > > gs_start_io") adds null pointer checks to gs_start_io(), but it doe=
sn't
> > > > fully fix the potential null pointer dereference issue. While
> > > > gserial_connect() calls gs_start_io() with port_lock held, gs_start=
_rx()
> > > > and gs_start_tx() release the lock during endpoint request submissi=
on.
> > > > This creates a window where gs_close() could set port->port_tty to =
NULL,
> > > > leading to a dereference when the lock is reacquired.
> > > >
> > > > This patch adds a null pointer check for port->port_tty after RX/TX
> > > > submission, and removes the initial null pointer check in gs_start_=
io()
> > > > since the caller must hold port_lock and guarantee non-null values =
for
> > > > port_usb and port_tty.
> > >
> > > Or you switch to tty_port refcounting and need not fiddling with this=
 at all
> > > ;).
> >
> > I agree, Kuen-Han, why not do that instead?
>
> The u_serial driver has already maintained the usage count of a TTY
> structure for open and close. While the driver tracks the usage count
> via open/close, it doesn't fully eliminate race conditions. Below are
> two potential scenarios:
>
> Case 1 (Observed):
> 1. gs_open() sets usage count to 1.
> 2. gserial_connect(), gs_start_io(), and gs_start_rx() execute in
> sequence (lock held).
> 3. Lock released, usb_ep_queue() called.
> 4. In parallel, gs_close() executes, sees count of 1, clears TTY, release=
s lock.
> 5. Original thread resumes in gs_start_rx(), potentially leading to
> kernel panic on an invalid TTY.

The same issue happens in the f_acm function.

[  369.926837][ T9731] Unable to handle kernel NULL pointer
dereference at virtual address 00000000000001f8
[  369.930098][ T9731] Call trace:
[  369.930108][ T9731]  tty_wakeup+0x28/0x160
[  369.930124][ T9731]  gs_start_io+0x128/0x214
[  369.930136][ T9731]  gserial_connect+0xb8/0x158
[  369.930150][ T9731]  acm_set_alt+0xf8/0x118
[  369.930162][ T9731]  set_config+0x258/0x3c0
[  369.930179][ T9731]  composite_setup+0x484/0x984
[  369.930193][ T9731]  android_setup+0x13c/0x24c
[  369.930206][ T9731]  dwc3_ep0_interrupt+0x8c4/0x122c
[  369.930224][ T9731]  dwc3_thread_interrupt+0xa4/0x1918
[  369.930238][ T9731]  irq_thread_fn+0x44/0xa4
[  369.930260][ T9731]  irq_thread+0x2a8/0x588
[  369.930272][ T9731]  kthread+0x1d0/0x23c
[  369.930289][ T9731]  ret_from_fork+0x10/0x20
[  369.930314][ T9731] Code: d5384108 aa0003f3 f9431d08 f81f83a8 (f940fc08)

> Since both gserial_connect() and gs_open() initiate gs_start_io(),
> there's a brief window where gs_start_rx() releases a spinlock for USB
> submission. If gs_close() executes during this window, it could
> acquire the lock and clear the TTY structure prematurely. This happens
> because the lock is released and the usage count remains 1, making it
> appear like a valid final reference, even though gs_start_io() is
> still in progress.

The f_acm function invokes gserial_connect while configuring the
altsetting. A similar issue arises when the TTY file node is already
opened but closed when the gs_start_io function is executing. The
current code includes a spinlock and the usage_count is 1; however,
the problem persists, suggesting that the existing spinlock and
usage_count are ineffective in preventing the issue. A straightforward
solution is to double-check the TTY status before calling the
tty_wakeup function.

> My only solution so far is to recheck the TTY structure after
> gs_start_rx() or gs_start_tx(). I would greatly appreciate your
> insights on how to address this race condition effectively.

I'd like to get your perspective on this issue. Do you have any ideas
on how we can move this solution forward?

Regards,
Kuen-Han

