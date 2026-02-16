Return-Path: <stable+bounces-216716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICrgL3Y3k2mV2gEAu9opvQ
	(envelope-from <stable+bounces-216716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:27:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC3D145902
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AC1C3053B1B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999132548E;
	Mon, 16 Feb 2026 15:21:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BC3242DD
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255306; cv=none; b=Ye8jo7uMkRGDF7DNemTZQ8QjlOr+IHeY29NmOo8aF+3p5M/EZ/kkZ8PRrgOrTQv1baTI1aym4PBXxvjYISCG9iHnsq8XhuvF+4+gjr/vYXoPIxP8Y/EJI5nHHreWz6PK+FwkGNdnWh/VwDR55hTiO2MXO2BKZka3ID7NVxtaho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255306; c=relaxed/simple;
	bh=lUf+rD+zK85EaecIl+MRfVINlsxw2aj22zOZLlA0ty8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLnKkiNQ5gCfYzjtiyYmeu6LeIJfs9j62eHgZG2JODZg0scu9z/p4CfFIonFKLfLxhCNtkzsL1wyMSf5QJBHkqnIhAE60BKKiqgDWevoKrWIVya/wCsKw8dyBteZbNkl3CRyJGsWfkTRQ3xtOXbVeeNpQix5Ur4MaNhg6kUen+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so2361688a12.2
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 07:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255303; x=1771860103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+0W63J01pKV+NBFDfR20YFl2vlCDVBGClMHBExbTTc=;
        b=jB1udAWJw18Wfri67q7R6sv/5esfyJdBhqTJrV3wDESi7YhKd80NjmrwM3m69CXht2
         JbirEYZ+XtO3qEZwu7Auf0x1cIS53DCzmS4d75ExxLpbsYJrKv4pBi8KbkqcuPFYysZu
         So3leto6F/1ol2P2T6IYHyCJVd7BKDZUW4oEsnO1UNnWZDyrfx5Lwx3B8I4SF1l6JNto
         HwnuyWiZX2jvV+tjmrQbRTWmJBlkKmjQ/w4A/cc9tEzglxt0DYkDcqe6BFYLr3EQbmuU
         zahON9wBcMFFmz2ewVVXbAbM1CZcpd0x6Z4ddZvVLwLf+dZs4dV9+AXkCETlYBHi3bOs
         DaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpjdyLQA6fOxmmJgMSzGrfbx3gHNMNYqZgbH5aCdPVZOuqmLBMS9DYPMQNDZwKexbMw5QNBG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZzaf9o8lYWrtWmKvR5sOyQbrR8uOwoqJi08Iqn2dB60TokIpo
	awVZYW+gG3nMy92G58oGuCRwjzENJZcy1KjptP6B8v4SnB5fsllmP9LpipB1sco6
X-Gm-Gg: AZuq6aLIl/WuKu/kHeRTENVvfz1uHRL4xRY2PBj7gRex8w1lO+yEI2jNAVcry1790mn
	PR5JvYl99V9VnVs5+WpnrLpiLFqLL0IsVJZEP/BMioOuxJLsqYur0F3IPIM4jHtWt9l4iTABN6u
	bLuGBjvFz0lyyXE5AKB7M99OZo2z2NtmJnbPgEcixxkrn3KYJrnvrP4NWRWPGgtseDxBXTcqmHX
	hvm2eZ3ZNVU/1leZLfPKpYWdrFC2S1sHSKkLITf6ohbvKi4dPLFV0LoVD/dz+u889zJoHZSwOQc
	cCJpcaPpCZgVLeTKt08LCDvMmXgJ0lLjYBWjRsbsz1jiuYQU/Cv0nDDjDpdpmDJdSMBSvuLH6J/
	mxVxLFu06hvgNbzlfZCO/gDyhyKcZCSiBgflLKRuv0Dj2im3PKQ2Gu9W7jxZZJxUff52c3f7qmv
	sBnWZ01AeyLfCnCD6ilLOrTqZKfC21S19IcjKLrkdPBFkqX5uB3wcvX8LRHpNK/07A
X-Received: by 2002:a05:6102:41a8:b0:5db:e909:aa0d with SMTP id ada2fe7eead31-5fe2afc4154mr2194791137.37.1771248506480;
        Mon, 16 Feb 2026 05:28:26 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde87fb840sm7378528137.3.2026.02.16.05.28.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 05:28:25 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56737fe4888so985668e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 05:28:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9SdzIMNz0gaksN9SGnAxeuyFlRlR6sMI5oc4GQClqcwVQ1ABhzf+KhnhgcgORE1tSQP5C1ek=@vger.kernel.org
X-Received: by 2002:a05:6122:4f83:b0:567:4722:66a3 with SMTP id
 71dfb90a1353d-56889ba5013mr1919672e0c.8.1771248505602; Mon, 16 Feb 2026
 05:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214005825.3665084-1-sashal@kernel.org> <CAMuHMdVeGv=f-Oo1=GQLghn_hwpe2YN5OS79fQsy2uccwyVUZg@mail.gmail.com>
 <aZMXwfvJjG0YkuF5@laps>
In-Reply-To: <aZMXwfvJjG0YkuF5@laps>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2026 14:28:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1Mdqp7+Oz9dqe3b2VqMzpp5L7AvBJxRZuUjb0vY6gCw@mail.gmail.com>
X-Gm-Features: AaiRm51__ksjmZ0Ow9FHNfsDCOhP3Z--ENwDCnxogABgCRny5CijpedZP6Vlq9U
Message-ID: <CAMuHMdX1Mdqp7+Oz9dqe3b2VqMzpp5L7AvBJxRZuUjb0vY6gCw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-5.10] parisc: Prevent interrupts during reboot
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, guoren@kernel.org, neil.armstrong@linaro.org, 
	brauner@kernel.org, yelangyan@huaqin.corp-partner.google.com, 
	schuster.simon@siemens-energy.com, linux-csky@vger.kernel.org, 
	Parisc List <linux-parisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,kernel.org,linaro.org,huaqin.corp-partner.google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216716-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,siemens-energy.com:email,linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email,linaro.org:email]
X-Rspamd-Queue-Id: 2BC3D145902
X-Rspamd-Action: no action

Hi Sasha,

On Mon, 16 Feb 2026 at 14:12, Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Feb 16, 2026 at 11:21:25AM +0100, Geert Uytterhoeven wrote:
> >Cc linux-parisc
> >
> >How did you (or the LLM?) came up with that CC list?!?
>
> Interesting...
>
> $ ~/linux/scripts/get_maintainer.pl --pattern-depth=1 --no-rolestats --nor --nos 0001-parisc-Prevent-interrupts-during-reboot.patch
> Neil Armstrong <neil.armstrong@linaro.org>
> "Guo Ren (Alibaba Damo Academy)" <guoren@kernel.org>
> Christian Brauner <brauner@kernel.org>
> Geert Uytterhoeven <geert@linux-m68k.org>
> Andreas Larsson <andreas@gaisler.com>
> Helge Deller <deller@gmx.de>
> Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> Simon Schuster <schuster.simon@siemens-energy.com>

Still doesn't explain linux-csky?

> I think that I'll fix it by replacing --pattern-depth with --nogit --nogit-fallback:
>
> $ ~/linux/scripts/get_maintainer.pl --no-git --nogit-fallback --no-rolestats --nor --nos 0001-parisc-Prevent-interrupts-during-reboot.patch
> "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Helge Deller <deller@gmx.de>
> linux-parisc@vger.kernel.org
> linux-kernel@vger.kernel.org

Much better!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

