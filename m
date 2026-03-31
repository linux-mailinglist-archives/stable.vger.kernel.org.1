Return-Path: <stable+bounces-232588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBDBIqBFzGm+RgYAu9opvQ
	(envelope-from <stable+bounces-232588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2A3724D0
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 919223064649
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDAA450918;
	Tue, 31 Mar 2026 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2Ofvz/w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B938F647
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994696; cv=none; b=YUMK+hkcAynWxvCLmtGYlQqz4tyyhJ5gWEmV5vp19dtXrTQwMKzYeBbXZZxGqdJjLGlX48+7GKDUB0I9i5YJB6aoxYoONbc7yydvErQ6xmA8FSGPhJm/iER8LwiK81VNfKzvdWfAlALJFuzN/NdQk+gtUufd56JEa1ZT2RpaLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994696; c=relaxed/simple;
	bh=WjctfFZmGsUx6a6lgv/TNf96YHqARAzC7Zbemb1tscg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEgm8Ky7xEFIZTbtRkCOfA6XRzMwGs0yMl/0p41QNzdbmvgPwI+rokF9DWlFtaJj0WP1kA4bPC1KkcnjaC0jfALwNMyM5Qkj/OHuWJHR0p5pEGTVxdkejl8GcbBxuiUuOhDfL9KjoDyjEFBPEC8Zd7rUtUdzma55lp8IApV7dJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2Ofvz/w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so66580105e9.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774994693; x=1775599493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+cQN8/WkM3xxxuXSY+/LDGNdSNAwlkDI50XPvvPAQY=;
        b=f2Ofvz/w+HRclYkI9iS1EvUobHF9nj3myytjBiiwS2OXP0wSbYGTiY5y663Zxwu9Nw
         TlMxWPBYx33LF2pjHitBMZGaOk0AfFgtueEj+e2hEYQ0Cch2oQiTMhCBhje/XYQN2qi9
         FYVLisgnwbn39hlr02ntjf9oKjFRaadut/TsIplRxs+bZ1b+PImhRnq1lUVyss0N7lHV
         bI+pnq6rme5cZ1yBU/9eZ8IhKF2NgZ/u8jRikKaSkWcNr4/cJisX4ddvfdXwSUsF3Goj
         CSLCsQH68PVbxz+CTDbxFTSEsj7NkErJro3WcXmC2XvR/A9rp98x+Wxq/SX/mCytF7Tx
         Oc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994693; x=1775599493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+cQN8/WkM3xxxuXSY+/LDGNdSNAwlkDI50XPvvPAQY=;
        b=gwHDj8NJH1QDD+tBM6/mg+3unvhpubZPl3pRtUwI6xGuBBsQwGezJSV5NI4s09Uu01
         00OM7Sgoa64DKqbJRiu6P3SFKmb3S4nnJPQaY6ArpczYld5DOzQFSyYJkL5hEYzwO64j
         Bjt+1hG+xvw2pc2NwDoeAy66IHOUWQeQuNZYwH2bjGlKaw+w9vv96QXvY1nwGrCxgARb
         ebgPeVdi5rQXDMo7dzd7syCRo+MvbYiO/kt8zL1KGJcPLLO+NDfwAq8MltbaZ+xBghyn
         Mmju4JS8+7MD2/dg866E6uSWVdTkpqCHPhxGDhmoL4JmUCgsEUrStPPr2Ex4UuVNChVq
         wYEg==
X-Forwarded-Encrypted: i=1; AJvYcCXlLFLZUKtEm8eg9tsODPQNWf9IOPzoKE+43bCbtACYw/TFb5pcSgw9g2/rB9IkuWH8dVdOWf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznj/DoiYXA74nslbHxVWkhGMnIH62iCzLOu6MUnuRkvsFOW6Gh
	qxRH6UQCj748njXq+dz1OhTCtgMKZ6ezdr3gA+rI0EKuT8st+LHenHin
X-Gm-Gg: ATEYQzxCsOqMJpm8cHtrvGM265NafuYdNSZuRRcUlVZu642P71JcEuLer4fDIZZaZZ4
	gayYo2DLVRwwS85HG77DyHaNenTQC+pD3d0hUwRjtXyWHBPeYJ4viX64u/Ob/Y39tfNwTj8X6tK
	85VIr7Kdb/ORFz8iYP6HxNyyTHmJfHQe8MckcoM6Q02kzmsDqU1Bqz8jtcziHWliUgpxiTHAWim
	Mi+/IHv3KR1TGm53zGY3EcpRXF0aGGokn9v47sLr4SLkqMBhO6kDQvrFfR22aeGoxd3ldhY+QEg
	EMbJsTHm6u3IzEfNwLp/VB6xHUS07EaQYrOOutWombhzj8ZiP7AjL5Pp0b0xHPNvB4iCNXpYfx7
	aQljsUNlxJbtq42OohNKOUJnysojpQXX+c74Z0o9c12LZLh8WfvaQ/MBPdq8m/1XcQ3aDB1bnOe
	IoqJzzDE0FTTuk0/FzBCs5GmlhBl70yMvNS0Xn6QGeA2yyPWAf4JGI0th3t58Q
X-Received: by 2002:a05:600c:3516:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48883597e85mr16164905e9.15.1774994693263;
        Tue, 31 Mar 2026 15:04:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e82e669sm60760165e9.11.2026.03.31.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:04:52 -0700 (PDT)
Date: Tue, 31 Mar 2026 23:04:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Message-ID: <20260331230451.6c0bd155@pumpkin>
In-Reply-To: <acwTnoz0aFs_xCyO@ashevche-desk.local>
References: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
	<acuT8oTnaYujC0k6@ashevche-desk.local>
	<20260331162635.2d8c7f70@pumpkin>
	<acwTnoz0aFs_xCyO@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232588-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39D2A3724D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 21:34:06 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 31, 2026 at 04:26:35PM +0100, David Laight wrote:
> > On Tue, 31 Mar 2026 12:29:22 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:  
> 
> > > > iio_multiply_value() passes integers val and val2 directly to abs(). This
> > > > is problematic because if a signed argument to abs is the lowest value for
> > > > its type, then the result is undefined due to overflow.
> > > > 
> > > > Cast val and val2 to s64 before passing them to abs() to avoid this issue.    
> 
> ...
> 
> > I've just looked at the 'work of art' that is abs().
> > What is wrong with:
> > #define abs(x) (sizeof(x) == sizeof(long long) ? __abs(long long, x) : \
> > 		__abs(int, x))
> > #define __abs(type, x) \
> > 	({ type __abs_x = (x); __abs_x < 0 ? -__abs_x : __abs_x;})
> > 
> > It is just as broken for u128.
> > It will use the correct signedness for char (but it is unsigned now).
> > It doesn't cast back to char, but that is entirely pointless unless code
> > looks at the type of the expression, the return value itself is always
> > promoted to int before being used.
> > 
> > Actually replace the -__abs_x (UB for INT_MIN) with the safe:
> > 	(unsigned type)-(__abs_x + 1) + 1
> > and the return type will be unsigned with a correct value for -INT_MIN.
> > (Oh and the compiler sees through the mess.)  
> 
> And this is definitely wrong. We must keep type, because abs() might be used in
> the comparisons with signed or as parameter to multiplication or division where
> sign has to be preserved.

Thinks.... (bad at 11pm)
IIRC -INT_MIN is UB, but (~INT_MIN + 1) is fine provided -fno-strict-overflow
is set - which it is for kernel builds.
At least that guarantees the abs(-INT_MIN) == INT_MIN which is about the best
you can do.
It isn't as if it is ever going to happen.
There are all sorts of ways to break things in a driver.

	David



