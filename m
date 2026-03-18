Return-Path: <stable+bounces-227002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEWXOUNnumklWAIAu9opvQ
	(envelope-from <stable+bounces-227002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:50:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4DF2B86D4
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2C1A300BC89
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E2D39151C;
	Wed, 18 Mar 2026 08:50:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C4284665
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823805; cv=none; b=FUdcti2mh2lOT8Im09+wyA63wbr0Z3bzR5qJDQfq+Ty3U7Aw973b1skecc/gta3Im+h00+ZfGEbMejpaW5QE+Kg3ZoiNSgfThY1XXkDJQOJ/kz52NJvzPG7TXlvWX6EM8MrZ4WiHIL0/DCOIfYvsZ+NfJRrGh6LA5siJ4XBRgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823805; c=relaxed/simple;
	bh=1Q3Co6bxbshrYxrPl4jn/U2T1xBX3gjFWpDnRI8lYDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsXtNXLEnGFHjT/IwSdxEN1VIhyk2Sofn+Gbw3X+WlWVbLsUQ5kVQUz8Hkf6foQnuIWo4Vrt38R398RqasUzO3DsYcb9xDModGtI8SCHW2QhAARfbByvxKbVb6RLOQnJeMRF7M7Ew/HhwCDG8M8Yj5OHSWgjTWfyokU9NU7NRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb4136d865so882808985a.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 01:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773823799; x=1774428599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqPUDw6RZ7tI/8SbuWaBeZ31o+A7cvn/glmx6dclWwI=;
        b=o9ZsySZs7U9buK8LX4Dwrb8QniBNDNHF7bpyD2qdYeLy9aMdBbgzFLoB4wxc1z1TYq
         Zc7MtS4rM1TrAhhqWz7t96/1ibWZipJp5wh12/lANCcdpiJIyrBJrucHjrODEvlGMu6r
         dd+iz/GkCx0P4GRaT5MGZZ4wHg3rYScHC7J7DK4Rd3XUWxiopK0jbQXh/0afmYwMeX/0
         tklq4sfP5wMQhZJbTiePawTV2mzF8q2Za52bK6vB+VGas77jQ3eWJiFbPzx1xi8Z0HbR
         6EK1aKOIh1Xbyg64fAmWMOVxFXwJuD+pazV9Z30Kr6w93W0poY/xiLyfJWJ0IeBTWvle
         Pq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVevjc4S8M1Ep4+Oe1+cRLtEchCbGOgL37hrMPgk/n8+Ql1+lpaRch6BmZ29uqHUAIB6ohRUdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0u4VoVMZUmUIZlGZj1NOVgkAJtV+7S/dxn8a/RyMGWEHlNrV
	OqWs0ocosCzW4G8yA00JpeNxFU5DMiMRgnrAkuUMBaWsnAp2Yq520NEE38Rgr/mPURI=
X-Gm-Gg: ATEYQzzatWMchgML+9SrbvX+VwpZLXJJffJoA+fGUyjF2LtMCUO86h2CyceOhUqjI4+
	/TLBUKfciZBTqwtsRmPulDJ0C6LA9HNWYk+xyjHZyTVO50L2NbqkjpLoFf1ijr0ODe5ILJEeUSi
	Mxl8bNM2fGwTIbs6NdMl3UYVw6Wptl6wXkVmU+ZY/t6BbvXjp/8BuhbT7UPJxNic+5cn4i34IN2
	dDuPz6tSne84LFTuvxnbu71FvdsK1l7ZeBMei5Jp40Xsyg/8ZKVzzt+0OC1iEFbqXBGzNX3MM82
	Uevl947zbX2VBQudq1+ca1JJp4LW5SMe72KtyXxj44fWAfrVOpbYUU97YgXj2t2xqAOcy0C6Dpv
	izA0RWdx2Dm2oC8hrvSXSvk60luR6W/43HGV2jl29yCP4YOWY2W2EcyccfW1CY774NNK3bJIaE8
	DNYinSeVZFZtz5zYTP0rj83pcaXW1mvr3LbVmC2IetAu4E/eh1aeZ2dqvKzgGNkSMJ
X-Received: by 2002:a05:620a:44c4:b0:8cd:99de:6b5c with SMTP id af79cd13be357-8cfad3942famr335580285a.74.1773823798835;
        Wed, 18 Mar 2026 01:49:58 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad16691asm156899985a.23.2026.03.18.01.49.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:49:58 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb4136d865so882807685a.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 01:49:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9oO2vOUKWGnc2LbNZvLgW9F11rMvkIMKBCwYbXAi0ZJM5v0/JgiFcjxn+aPs6ITwyzI9enaU=@vger.kernel.org
X-Received: by 2002:a05:6102:5087:b0:5ff:e39d:9f9b with SMTP id
 ada2fe7eead31-6027d159e7fmr1126209137.16.1773823315107; Wed, 18 Mar 2026
 01:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
In-Reply-To: <abkD-VLprcbbEbB1@ashevche-desk.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:41:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
X-Gm-Features: AaiRm52_MgNfiAr79FL-62Ac0xXnTx-AfzVYThIE_IN0tF6AadQcPRzCkdJNUOc
Message-ID: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sang-engineering.com,chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,linux.intel.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227002-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.841];
	TAGGED_RCPT(0.00)[stable,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EB4DF2B86D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy,

On Tue, 17 Mar 2026 at 08:34, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:
>
> ...
>
> > Thanks for tackling this issue! I agree it should be fixed, just
> > wondered about one thing:
> >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> >
> > Is it a possibility to use the lock in all code paths instead?
> > Because...
> >
> > >     struct list_head consumers;
> > > -   u8 flags;
> > > +   unsigned long flags;
> >
> > ... this change costs some memory on every system. Maybe it can be
> > avoided?
>
> How much memory does it cost? On most 64-bit architectures is +4 bytes,
> rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> +0 bytes. I expect that 64-bit machines will cope with this bump.

On all architectures with natural alignment of pointers and longs,
it won't cost a thing: struct list_head contains pointers, so the
struct must be padded to a multiple of 4 or 8 bytes anyway.
On m68k[*],  it will cost 2 bytes, as the existing padding is just a
single byte.

[*] Iff m68k ever switches to 32-bit alignment, there won't be an
    additional cost due to the change of flags here, but of course
    there would be a cost all over the place.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

