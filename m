Return-Path: <stable+bounces-4949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379A8090F4
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 20:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DB91C20A81
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740EF4EB2A;
	Thu,  7 Dec 2023 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="wh/iLTry"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BAC1703;
	Thu,  7 Dec 2023 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=EmYqNryA82Op86uYZ0H5QaMB/eSGzqR2n7W9jmjjGtc=; b=wh/iLTrypcg5XadryGWrJkhJVa
	rZHwx+Ai/6dWZ9EkIvp9Ab2mheaxrAPnEB+YUPYlZZ503VinNenUtB0TRJrb66+k+QMMkBbXdDGIB
	cSxcxLUI4ZezRXZ1fOSkjr7IhHddQ3RmcvS8o7BiPcyuNqh9zoTC0HMAet1eEROJNxww=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37728 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rBJdd-0008TT-6y; Thu, 07 Dec 2023 14:02:22 -0500
Date: Thu, 7 Dec 2023 14:02:20 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, stable@vger.kernel.org
Message-Id: <20231207140220.370a61e0ca32bfd36ee8dbaf@hugovil.com>
In-Reply-To: <CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com>
References: <20231130191050.3165862-2-hugo@hugovil.com>
	<202312061443.Cknef7Uq-lkp@intel.com>
	<20231207125243.c056d5cd0f875ea6dfdfa194@hugovil.com>
	<CAHp75VebCZckUrNraYQj9k=Mrn2kbYs1Lx26f5-8rKJ3RXeh-w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 7 Dec 2023 20:24:45 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 7, 2023 at 7:52 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Wed, 6 Dec 2023 14:29:39 +0800
> > kernel test robot <lkp@intel.com> wrote:
> 
> ...
> 
> > >    drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_i2c_probe':
> > > >> drivers/tty/serial/sc16is7xx.c:1703:41: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
> > >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> > >          |                                         ^~
> > >    In function 'sc16is7xx_regmap_name',
> > >        inlined from 'sc16is7xx_i2c_probe' at drivers/tty/serial/sc16is7xx.c:1805:17:
> > >    drivers/tty/serial/sc16is7xx.c:1703:36: note: directive argument in the range [0, 4294967294]
> > >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> > >          |                                    ^~~~~~~~
> > >    drivers/tty/serial/sc16is7xx.c:1703:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
> > >     1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
> > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Hi,
> > the only solution I could find is to add this line just before snprintf:
> >
> >     BUG_ON(port_id > MAX310X_MAX_PORTS);
> >
> > it allows us to have the smallest buffer size possible.
> >
> > One other solution would be to change port_id from "unsigned int"
> > to "u8", and increase the buffer by an additional 2 bytes to silence
> > the warning, but then wasting 2 bytes for each channel, like so:
> 
> I didn't get this. It's a buffer that is rewritten on each port (why
> is it even static?). Just make sure it's enough for any given number
> and drop the static.

Yes, using static is not appropriate, as regmap will copy each name
into its internal buffer.

I will drop the static and refactor the code accordingly.


> While at it, can you look at the following items to improve?
> - sc16is7xx_alloc_line() can be updated to use IDA framework
> - move return xxx; to the default cases in a few functions
> - if (div > 0xffff) { --> if (div >= BIT(16)) { as it better shows why
> the limit is that (we have only 16 bits for the divider)
> - do {} while (0) in the sc16is7xx_port_irq, WTH?!
> - while (1) { -- do { } while (keep_polling); in sc16is7xx_irq()
> - use in_range() in sc16is7xx_setup_mctrl_ports() ? (maybe not, dunno)
> - for (i--; i >= 0; i--) { --> while (i--) {
> - use spi_get_device_match_data() and i2c_get_match_data()
> - 15000000 --> 15 * HZ_PER_MHZ ?
> - dropping MODULE_ALIAS (and fix the ID tables, _if_ needed)
> - split the code to the core / main + SPI + I2C glue drivers
> 
> * These just come on the first glance at the code, perhaps there is
> more room to improve.

Ok, no problem, I will have a look at it.

Thank you,
Hugo Villeneuve

