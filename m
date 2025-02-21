Return-Path: <stable+bounces-118534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B019A3E910
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 01:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EFE4229F6
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226D9111AD;
	Fri, 21 Feb 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9UqhShd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19688F9E6;
	Fri, 21 Feb 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096619; cv=none; b=UDIb/pQRapy67Lmyt9QEfotEYSjTqS+3sF63YvkItEThWVERFqPS7u3JA17WxMr7gkTpa+5ZfacGkC/hflIOxPeaO6FcrYVEzfWfCTOqLqHMIGM0//m6JfhCGnfKKTNVZ5kOgfSN+r6h52haIvja6M64CcTss8rggNeRDIuNbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096619; c=relaxed/simple;
	bh=vXCYwQLSvKIptQcJVs0ex9tqncT35sXQaqqioY+05h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTnMV0K4c2E7v8JyB4kXbmjI4NFoJqS14TQbaKLtTohiuCZMDJflZh+v3WYUDJFgOrom32hzhXwGW3Vv0ZnudBnBwqYE5drD5FT1lJqsFWkaxQoD3Df+P5ZzsuONoClaHaeciKVfTt5UfqWsPtsJI2vLh9uGQAUfPqaBDKEoSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9UqhShd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so9830715e9.1;
        Thu, 20 Feb 2025 16:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740096616; x=1740701416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ltM/d0CNg9/b6oyJiIqSMkzVa+3F9bgYF4M2wUIeWo=;
        b=c9UqhShdo7Qe8ydhew8K0JEmxlKNQni6IFdtDgpbuB9/w1o/mFPZHj/SMXAPBifTVm
         SqIyxofBEeSaLCuFtTMdak+KM+37yOw5Msg1AhjZqaj0wrG+1+B3qIoIUsl5GyYnvC/A
         arw57asEYfzZNLGjE+g+X+msp/ybchwgUGvKuuIGJqC9plbHkUx76BXhbRK8h093PkzX
         HXRDT0dzpiCd7veK0ylccxvAVxtoAaWVIw4/kOuyykyZWjJRclI7Zt8CtBufppW9re4q
         +cf4LBsZdm65FaR2Akd0tVwJmDkwhYqBA7XeztyZDzqQTAnbRrKLI0I5ynA/jgdQnkZv
         CbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096616; x=1740701416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ltM/d0CNg9/b6oyJiIqSMkzVa+3F9bgYF4M2wUIeWo=;
        b=q67zbOtFaNSjZbAPThTQdaE7f9c90GbMpWHYpUTBCRUbrQVgiPuX6tYPpNYYIrjY0S
         W9aJBPs9yIMZDPrMpnCaNH7MKeGwxeNUwI5wpu1KmAxjIvp9W5WisXRTgonUsBNnhwz8
         FqPexbSMgdDjjRG6TxeAdDj3KQQXmldTPwvDsMY4PCFSID2vJ1WwW7bntlxOM1gmge92
         0ZqODh6uVTaTas5tAe6+k3mJMgyFWyTgYYRg955YVlEtFvUTBuc7L0FJwWj9u4g/Rh7t
         34T1zlq+opsJU9b/nDcP7w1Tkc8NWVTvmZCQNejVWo5hpAXbVteeDaWszfDWd1LLpMxK
         V0IA==
X-Forwarded-Encrypted: i=1; AJvYcCWNi8mEL6EOi7257F45nIKrp3q1zVUGPO2ApACbDbj8rDvqlQGg4AXtGghnNQr2q85+ZJTc8Mm1@vger.kernel.org, AJvYcCXSX1FXG7qIZ6NWF8KftHaquZcSRg9IJz/JHBJO835CscAmy1xOWBPRkrBdvyMEP9OjvyyM/VHbUCDclsvwRVg=@vger.kernel.org, AJvYcCXW6dTFp6/hMIribj/809v2PXp41Zi3Vikqj/sZxULXfnGnHVq7DwtPTNdlybkdY2KIzPcHLgb8x93evNaN@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHFU5kaunbbrk68fuaEJZ91NX0J679vyBRM7hleDiCK8fj0FQ
	3TsX3wAiFWUMw3/pifeOOdz2NnV8B9Tce7uAxQEzjkszST9FJ2VS
X-Gm-Gg: ASbGncv8kw1LzhE82vsQQOOM+5O00CJvDCRt7kvr0ETwodKdG5jbuE1b3hPYItNULLS
	kwXRU/weCfdlS6+n9nOXfy/eNCGJ27wT2REz/b6f+Jje0faBJ1tVwssAw3IiHqPW63l0DypvmAj
	V+FH6iG+uQcZh0s3Lc0+oFbDgBmtV4/fPuuKSfjHfJbgMbCMFcGrLhClPJL3iOkRrA7HKfYtojd
	Juh6toCsq47943tt00mqjWYiGIz0mst402Q1yYSuDO7ClGyxDIOD/+sIX9y74fEFYqiVGTFbVzB
	2M6qnTDx94Uh
X-Google-Smtp-Source: AGHT+IESXNVFkG0iILEEgotVDpm45DxMQ/ic89gzIihAXdvMHbx/sLissRXUpyAYoKRhDIFHoznvAg==
X-Received: by 2002:a05:600c:510f:b0:439:9898:f18c with SMTP id 5b1f17b1804b1-439ae220a50mr8091265e9.26.1740096616064;
        Thu, 20 Feb 2025 16:10:16 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258dab74sm22174894f8f.32.2025.02.20.16.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:10:15 -0800 (PST)
Date: Fri, 21 Feb 2025 01:10:11 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Jared Finder <jared@finder.org>, hanno@hboeck.de
Cc: kees@kernel.org, gnoack@google.com, gregkh@linuxfoundation.org,
	jannh@google.com, jirislaby@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
Message-ID: <20250221.0a947528d8f3@gnoack.org>
References: <202501100850.5E4D0A5@keescook>
 <cd83bd96b0b536dd96965329e282122c@finder.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd83bd96b0b536dd96965329e282122c@finder.org>

Hello Jared and Hanno!

On Sat, Feb 08, 2025 at 07:18:22AM -0800, Jared Finder wrote:
> Hi, I'm the original reporter of this regression (noticed because it
> impacted GNU Emacs) and I'm wondering if there's any traction on creating an
> updated patch? This thread appears to have stalled out. I haven't seen any
> reply for three weeks.
> 
>   -- MJF

Jared, can you please confirm whether Emacs works now with this patch
in the kernel?

I am asking this because I realized that the patch had a bug.  We are
erring in the "secure" direction, but not all TIOCL_SELMOUSEREPORT
invocations work without CAP_SYS_ADMIN.

(TIOCL_SELMOUSEREPORT has to be put into the sel_mode field of the
argument struct, and that field looked like an enum to me, but as it
turns out, the TIOCL_SELMOUSEREPORT is 16 and the lower 4 bits of that
integer are used as an additional argument to indicate the mouse
button status and modifier keys.  I had overlooked that the
implementation was doing this.  As a result, TIOCL_SELMOUSEREPORT
works without CAP_SYS_ADMIN, but only if all four lower bits are 0.)

So, I apologize for the oversight.  -- Jared, can you please confirm
whether TIOCL_SELMOUSEREPORT is called directly from Emacs (rather
than from gpm)?  I tried to trace it with perf but could not reproduce
a scenario where Emacs called it.

If this specific selection mode is not needed by Emacs, I think *the
best thing would be to keep it guarded by CAP_SYS_ADMIN, after all*.

As it turns out, the following scenario is possible:

* A root shell invokes malicious program P and changes its UID to a
  less privileged user, but it passes a FD to the TTY.  (Instead of
  UID switch, it can also be a sandboxed program or another way of
  lowering privileges.)
* Program P enables mouse tracking mode by writing "\033[?1000h".
* Program P sends IOCTL TIOCLINUX with TIOCL_SETSEL with
  TIOCL_SELMOUSEREPORT and passes suitable mouse coordinate and button
  press arguments.  As a response, the terminal writes the escape
  sequence \033[MBXY, where B, X and Y are bytes indicating the button
  press mask and the 1-based mouse X and Y coordinates, all added to
  0x20 (space).

It is an obscure scenario and probably requires a console with a
character width and height above 256 (to control the full byte range),
but it seems that this can in principle be used to simulate short
keyboard inputs to programs (like bash) that are not expecting this
old mouse protocol. - This sort of keypress-simulation is exactly why
we created the CAP_SYS_ADMIN restriction for TIOCL_SETSEL in the first
place.

For background on this mouse tracking mechanism, I had to read up on
it myself, but found the following two links helpful:
https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Normal-tracking-mode
https://www.ibm.com/docs/en/aix/7.2?topic=x-xterm-command#xterm__mouse

(Remark on the side, the GPM client library normally gets its mouse
coordinates through a Unix Domain socket from the GPM daemon. It has
support for this xterm emulation mode as well, but it is only enabled
if $TERM starts with "xterm".)

In summary:

If it is not absolutely needed, I think it would be better to not
permit access to TIOCL_SELMOUSEREPORT after all.  It does not let
attackers simulate keypresses quite as easily as the other features,
but it does let them send such input with more limited control, and it
seems like an unnecessary risk if the feature is not needed by
anything but mouse daemons running as root, such as GPM and
Consolation.

Does this seem reasonable?  (Hanno, do you agree with this
assessment?)  I am by no means an expert in this terminal-mouse
interaction, I am happy to stand corrected if I am wrong here.

–Günther

