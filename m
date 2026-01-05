Return-Path: <stable+bounces-204885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6053CF5304
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6B2B302D3A4
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 18:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59933BBD7;
	Mon,  5 Jan 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMS0fZK+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496F31AA92
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636858; cv=none; b=oQ06CJWYUq+kV/jqFVQfhxzRhngerZHCBNot3RoXjpmpFO55eb59l1goZ7fg0AcO6JNirABpTaw9Lfw0IL1BaUky6LmelpFBJ/1d8MOQbHz/JvejS94XVQ+QXDlHTNcZfUYMEw+vhKlln08dXrcehU75g2QVpXdxivN7gFkAZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636858; c=relaxed/simple;
	bh=bqtNUILbm6lJat/9Xu0gpKiAI1RZvgXVDpApnTxDQMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phRiL+z5ujClaAAar/q1/oKkx0OzfRoJ8jqMNneFp7bgZHP7lFJATximpuKtLcUGLNPx5gxJNfraQU4jB5mJsEJv53YaNDcwSH2BN7GD8ExAbKcJRHBbX+3o03Dur6UOi2IVekF6mBZ0sXN38Hk+V2CSHvHfU5GgOMWWQu3FZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMS0fZK+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-431048c4068so136127f8f.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767636855; x=1768241655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/oP9O+J1jrunuk+Y661pj013SgRFAFyNbhxBfEwCmlA=;
        b=LMS0fZK+OcvnH2SLJUlfefKr5m2N44kV8AVnzvzSavD+dOeuKvn0xwu6F0AKfW3qCu
         r3dtXyUjGdpyFV8SvoZ0RU7u05UyCyiMV4BRB2bfaCmpddUGrbgE69Slr562+ULf3FRJ
         gXc6VFYne2jdZb+1X/fZ/NbSn+b8xRQH5a692xPH2J2PpLt0+bb28Jk01n58fdWnphLv
         Rpx9rMXDGWlL9q5buhbwk0MlNiIeJSPDNesd1H+6s6wD0l/MIOnIekqr65xF7jOHbp2r
         8eWPLNcRX+dPpJUuNSDEf5+Jh6MNMkSAp268mq/MykE/K6P+4gPpOPi0B4NYitH21ekf
         9uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636855; x=1768241655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oP9O+J1jrunuk+Y661pj013SgRFAFyNbhxBfEwCmlA=;
        b=TrkmZahmaaSUCfgLU0ShYJYSyUSZ3YmgpCxbFMX/BKTQbdLfNwdx+oChHGzywztgM9
         7wiYkn9goLHKzoxVstJ9vhcDS2sdpMX9NE+Mweic9OUarXU4biMnnZ0fSZzCiX/QfzPE
         zjQfU83jC4+eZK06/cmJqIT72FUJVlYdkolgeMdxgpXvB6T2GC/K4x9aWRZLjPJEz3a/
         EVWkhP4dOk4XBRmdcciXT9bAFEkZjmXamo/8DDu6lBFtOJBSIwpNIalafmq6OVRTQDMn
         cDJ8nTsiqV1HV7Qrrvqz8MA6pkDOy7uf+ZaimekCTApu1adhmHh37x0fC8mX3gdn/XSy
         dnIw==
X-Forwarded-Encrypted: i=1; AJvYcCUENaCvRIrjPMv41QmpWLLLuuEct+0s0TS3nudRSEphR1HJmD4wvkQwlIIkW5V2yuy3Xi4zbl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjLZx9jcmDbKhMP0wBjip+DAiQIiHdwTgYBEJLtjAurnpha0o
	NYlIEzqjHC2UFFIcut8Df1CYbKsPNXQVl92ahNTyVWCljvVq0qmM7pfa
X-Gm-Gg: AY/fxX5tnddSfcvsCmK86oi5TjbAk9kdomPfc6TCLCq9CHNq1Uu6FXpKhYYI+AHW2jN
	TPgFzntoa+xtse/QWSXswFupGKvgGlCZFdgLAypXGSspJgdtn7j3KsH1VTE7AvN+zQu4sGMDCt+
	ljc7o4kIJ8rogd55/E2ad97C3z1kHfOuJiW7KrpmqhrFfC5ScczAaQLu84UD57q+evKFkhzcI8Q
	FzZJASjmOd8jJCiyb5fequdeTLlPC24UpTm7e8f5EBr56rq19xh36IJYqLtEIoNKgZCa1n3EU8q
	lnTqyqd7ne2svUV7XvpytoUjxUlrjCXDDumknLrcGq0RJB3aj6pSuzbNVbKAFI1e/jHpHO+KvXx
	j3fMQlYnx5L2bcoJ6zwy2GfSW3fBATdOYbIimpbHHafpD9zj58jDKEnckjIJPcasCQJAsPRih7z
	2nzPvTcrVtUf+DCXDqBAIpBk/q1MJ743sCE/l8UvlgSGSkB4isMJtu98I=
X-Google-Smtp-Source: AGHT+IE/WbbnXt6m79lszz8chS7NFY/jLDyt4rB9ShhndFA1aa1Z8u6f+/lIFkSh4Lfi6OF6YByoxQ==
X-Received: by 2002:a05:6000:26ce:b0:430:f3bd:71f8 with SMTP id ffacd0b85a97d-432bcfde915mr70237f8f.25.1767636855046;
        Mon, 05 Jan 2026 10:14:15 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bca5a132sm688291f8f.39.2026.01.05.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:14:14 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 44C5FBE2EE7; Mon, 05 Jan 2026 19:14:13 +0100 (CET)
Date: Mon, 5 Jan 2026 19:14:13 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Ben Hutchings <benh@debian.org>,
	Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>, debian-kernel@lists.debian.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev, 1124549@bugs.debian.org
Subject: Re: [regression 5.10.y] Libvirt can no longer delete macvtap devices
 after backport of a6cec0bcd342 ("net: rtnetlink: add bulk delete support
 flag") to 5.10.y series (Debian 11)
Message-ID: <aVv_dewfbbgQ5o0J@eldamar.lan>
Mail-Followup-To: Thorsten Leemhuis <regressions@leemhuis.info>,
	Ben Hutchings <benh@debian.org>,
	Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>, debian-kernel@lists.debian.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev, 1124549@bugs.debian.org
References: <0b06eb09-b1a9-41f9-8655-67397be72b22@mathematik.uni-marburg.de>
 <aUMEVm1vb7bdhlcK@eldamar.lan>
 <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>
 <176608738558.457059.16166844651150713799@eldamar.lan>
 <d4b4a22e-c0cb-4e1f-8125-11e7a4f44562@leemhuis.info>
 <27c249d80c346a258cfbf32f1d131ad4fe64e77c.camel@debian.org>
 <6498cffd-5bf9-490a-910d-f64ab9b7f330@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6498cffd-5bf9-490a-910d-f64ab9b7f330@leemhuis.info>

Hi,

On Mon, Jan 05, 2026 at 01:30:59PM +0100, Thorsten Leemhuis wrote:
> @stable team and/or @net maintainers: this imho needs a judgement call
> from your side. See below for details.
> 
> On 1/2/26 21:18, Ben Hutchings wrote:
> > On Fri, 2025-12-19 at 10:19 +0100, Thorsten Leemhuis wrote:
> >> On 12/18/25 20:50, Salvatore Bonaccorso wrote:
> >>>
> >>> Is there soemthing missing?
> >>>
> >>> Roland I think it would be helpful if you can test as well more recent
> >>> stable series versions to confirm if the issue is present there as
> >>> well or not, which might indicate a 5.10.y specific backporting
> >>> problem.
> >>
> >> FWIW, it (as usual) would be very important to know if this happens with
> >> mainline as well, as that determines if it's a general problem or a
> >> backporting problem
> > [...]
> > 
> > The bug is this:
> > 
> > - libvirtd wrongly used to use NLM_F_CREATE (0x400) and NLM_F_EXCL
> >   (0x200) flags on an RTM_DELLINK operation.  These flags are only
> >   semantically valid for NEW-type operations.
> > 
> > - rtnetlink is rather lax about checking the flags on operations, so
> >   these unsupported flags had no effect.
> > 
> > - rtnetlink can now support NLM_F_BULK (0x200) on some DEL-type
> >   operations.  If the flag is used but is not valid for the specific
> >   operation then the operation now fails with EOPNOTSUPP.  Since
> >   NLM_F_EXCL == NLM_F_BULK and RTM_DELLINK does not support bulk
> >   operations, libvirtd now hits this error case.
> > 
> > I have not tested with mainline, but in principle the same issue should
> > occur with any other kernel version that has commit a6cec0bcd342 "net:
> > rtnetlink: add bulk delete support flag"
> 
> FWIW, merged for v5.19-rc1 and backported to v5.10.246 as 1550f3673972c5
> End of October 2025 in parallel with 5b22f62724a0a0 ("net: rtnetlink:
> fix module reference count leak issue in rtnetlink_rcv_msg") [v6.0-rc2],
> which is a fix for the former.
> 
> > together with an older version of libvirt.
> > 
> > This was fixed in libvirt commit 1334002340b, which appears to have gone
> > into version 7.1.0,
> 
> Could not find that commit when looking briefly, but that version was
> released 2021-03-01.

For reference it is this one I think:
https://gitlab.com/libvirt/libvirt/-/commit/81334002340be6bd3a1a34c6584a85fe25cc049c

Regards,
Salvatore

