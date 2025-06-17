Return-Path: <stable+bounces-152746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 538B2ADBFE5
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 05:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32AD166A0A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 03:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A51922FB;
	Tue, 17 Jun 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVsMuar8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A51BC3F
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131107; cv=none; b=JSDiAOsh4UBrbpjeh/DFU+/LmzB3MI3sYCIpI0K9aNk3bxCSfS/G5gDhnopAUksf7IEvHQ6I2ipTAkRbVXPn55d80uByW4/DmQ0rvc5cDrBsHzGGiBRCn1w1jcOvwGub8UmDgGmb91LJjN3AFobZa/ffK3bIqaXmRtXZOjIsb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131107; c=relaxed/simple;
	bh=ieph6lxJ3Hbp+Rp377DeV7BoLQycTf5gx8twwmnu68g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+RFzj0Pyfie2D4It/0jmCbsCdwMukF2rpauk7WKuxtZMjuz95HYvsXIcjOQ6qBC6RNJRU2A5MMAc+bNjeLlc8/ON1l72DHt0wudZ5rmxwCq8P0+Z/Y9aGj8H2qQm1LIt8pnk2SILq0dnI3S3fJFk0aCKSod2FTz/s1BHJWgneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVsMuar8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-551f007a303so2340e87.1
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750131104; x=1750735904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwhOByNmuLKBhb5Mlg+5pTuchaKObMpIf2JB0S1ADBY=;
        b=dVsMuar8yrm/G2igr5QLyMut8oumHNdvZ+caLjegkbHueNVglAbTmx5qO6NH/MjyPL
         l2Egjfts32ZxPXFcETD1Cq3swij9aywwkQmjoE0Ji8c49tovTcApwBMYxFKuFcEsKP5R
         ObOcnqpDNRkD6iY48hVioCOb34EEr/E6t8zJK9WZkQ2VezXkisLyZZRVRJfuEgBpANQc
         PRZ8JAsuqLzztuXPBhmx/WCP8sxXHx/9GESGEsNSBTNlXIIyhO0ByJ+rRwXly9/NV0ji
         F/M8JKkEV0XMeEypiy6rqZhvfDXokKaGKDql7rK0DTX9iAx5U7+XhA4yrkts9FGXymA9
         WNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750131104; x=1750735904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwhOByNmuLKBhb5Mlg+5pTuchaKObMpIf2JB0S1ADBY=;
        b=OUE/rpX1WvQ54ineuJgdceb9jnJrp0YbGgf9EF7da9j/h9y2NsC5MibQoKYOF+QHzI
         ODZyQNbdAqHNxytFk9Yhza+ofgroNZGJL+1B4oz87DnZx3a6scNjRAYxA/lO1sHDxMCu
         sTaAScu4plc6WBRvhKh/Wi1NXgsni2/xUU5eTKI7/nT6D9L/oG+rTgDJxAZpe6/CVcpw
         Cnd1YDd9o6JyhLKwKObjNJmvGU9FTR1cUIEVnoqs46SSVQcJjYVBM7r8ORuse0TtGK+3
         YVgw3MsduBZLOd3AOKIi/UMZoDXiIQCnBBGSaBTA2qdRPCZSXesUk2+iYZHNz7sSu7fg
         KBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnyOWox3x2xh8/AzUxgxHT99AZMndN3jNXoJx19Gfk6RVpeFHa7gQhCLkRJHYrxTZM0efdM0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MCf5LYKrb+XyT0wIGVRHhsE2xgP5PAtv1BbTEArgEG3I5NIy
	kKdLDvrDOpI2DbuYBN9XcQ4ZD/VquDRrQa3KMMX9T/S667MvWeFvG0LDDxSkfgHYJhD3osXOKKI
	gU6Lg0Vy/UE0Mzs8eZnF3wSgcb3n7t5WGoBCcsHb7
X-Gm-Gg: ASbGnctSJJYm0Yf94mUMrn1inVlua/oa+TcPmndsMcrQh50BYc9Dzf5xMjC2251I80I
	0zDPrA2s1cn29SqlZXuc1iv42ulj4lNmc7ZW128tzQYNvf6vEp0xj9aVVDVHpEflHA9XU4E5GCw
	GGZwu1dMr6MzEYFZn5i499YXBqLXslhOVlE4H/LWnjuHRu5lbpFieMCDWsVXrZidEQgf0cWfY=
X-Google-Smtp-Source: AGHT+IGyuaznBGQp3QUnLGhxV3KnZapR1/Gtg7nZI85N47EBN9ZMHFJ3qlouR/mC0M+rb+Bp7XeJeYNp9yNbpRoZJj4=
X-Received: by 2002:ac2:5deb:0:b0:553:50d2:5c20 with SMTP id
 2adb3069b0e04-553b80b051cmr508080e87.6.1750131103855; Mon, 16 Jun 2025
 20:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616132152.1544096-1-khtsai@google.com> <20250616132152.1544096-2-khtsai@google.com>
 <2025061634-heavily-outrage-603a@gregkh>
In-Reply-To: <2025061634-heavily-outrage-603a@gregkh>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Tue, 17 Jun 2025 11:31:17 +0800
X-Gm-Features: AX0GCFsjBA1PsPOxoPnvm17MTnEeKtIwkTEYPQhKjxWr5yq-Sg5ZoYFB0zEugGg
Message-ID: <CAKzKK0oB83B3EwX75NTFd55E0qQ=QwNpKv3hUf9Oe3ZF3AAzrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: u_serial: Fix race condition in TTY wakeup
To: Greg KH <gregkh@linuxfoundation.org>
Cc: prashanth.k@oss.qualcomm.com, hulianqin@vivo.com, 
	krzysztof.kozlowski@linaro.org, mwalle@kernel.org, jirislaby@kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 10:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jun 16, 2025 at 09:21:47PM +0800, Kuen-Han Tsai wrote:
> > A race condition occurs when gs_start_io() calls either gs_start_rx() o=
r
> > gs_start_tx(), as those functions briefly drop the port_lock for
> > usb_ep_queue(). This allows gs_close() and gserial_disconnect() to clea=
r
> > port.tty and port_usb, respectively.
> >
> > Use the null-safe TTY Port helper function to wake up TTY.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 35f95fd7f234 ("TTY: usb/u_serial, use tty from tty_port")
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> > Explanation:
> >     CPU1:                            CPU2:
> >     gserial_connect() // lock
> >                                      gs_close() // await lock
> >     gs_start_rx()     // unlock
> >     usb_ep_queue()
> >                                      gs_close() // lock, reset port_tty=
 and unlock
> >     gs_start_rx()     // lock
> >     tty_wakeup()      // dereference
>
> Why isn't this up in the changelog?

Thanks for the suggestion. I'll move this part up in the changelog.

>
> >
> > Stack traces:
> > [   51.494375][  T278] ttyGS1: shutdown
> > [   51.494817][  T269] android_work: sent uevent USB_STATE=3DDISCONNECT=
ED
> > [   52.115792][ T1508] usb: [dm_bind] generic ttyGS1: super speed IN/ep=
1in OUT/ep1out
> > [   52.516288][ T1026] android_work: sent uevent USB_STATE=3DCONNECTED
> > [   52.551667][ T1533] gserial_connect: start ttyGS1
> > [   52.565634][ T1533] [khtsai] enter gs_start_io, ttyGS1, port->port.t=
ty=3D0000000046bd4060
> > [   52.565671][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> > [   52.591552][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> > [   52.619901][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> > [   52.638659][ T1325] [khtsai] gs_close, lock port ttyGS1
> > [   52.656842][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be975=
0a5) ...
> > [   52.683005][ T1325] [khtsai] gs_close, clear ttyGS1
> > [   52.683007][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be975=
0a5) done!
> > [   52.708643][ T1325] [khtsai] gs_close, unlock port ttyGS1
> > [   52.747592][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> > [   52.747616][ T1533] [khtsai] gs_start_io, ttyGS1, going to call tty_=
wakeup(), port->port.tty=3D0000000000000000
> > [   52.747629][ T1533] Unable to handle kernel NULL pointer dereference=
 at virtual address 00000000000001f8
>
> What is [khtsai] from?
>
> thanks,
>
> greg k-h

I added the "[khtsai]" logs for debugging and left them in the traces
because they clearly reveal the sequence of events that led to the
problem.

Regards,
Kuen-Han

