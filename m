Return-Path: <stable+bounces-211549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBvHNLlKd2msdwEAu9opvQ
	(envelope-from <stable+bounces-211549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:06:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B7877B7
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67FC300F9D8
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615B30DEC7;
	Mon, 26 Jan 2026 11:06:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89132AAA1
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425589; cv=none; b=gWIZgJD0HPqt6rs3Y3KIU7mrtPZsA4/nH6rRAnoespWBCqyGMi88Db4D5cClRF5Y1qEYhM5Q8cnFF+a9REMbMgkGUi2Qvj31ovJHiImCZIMsFZpCRfLZB23VcE3hOKcbrv6MHSF/WblfMIzrJbsUf7tFbzPRYQTKwfqyYFiUB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425589; c=relaxed/simple;
	bh=2H0McNSW14YeB8QNJBi9kKZne48lu2V8yMUat775eL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3RPdo06FhxL6TSDHf5PBy6BlkLh0rpZ7SqS5RbkJBbOD03Vzac9guHMpokpSxNxavF/j/KWNBjnrjQDaOfyWCz622Vp2bpE5OkZUNmgOr+UVMkZXmbrhk3rUId0XSG8mo829N4sZxRYw9Dp09FTvLMVMwQ2Pcw1TZpiLsrHAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-563610de035so4173551e0c.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425586; x=1770030386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aS98Qbf9sAOaU61dqPi/K2l5V6UxS+EUsC0EMiIZcM=;
        b=AyUuDTnVY1ONrnzrCF1QF2A1vKRvsILJffKtqopIMp8Y2+cPoLPnsYBrWb0klPRcy6
         vxd4/NolCG9hXvGrrE4qXjQRGitmfxUsJCGTZ/Hi58NTNkKQ4qJWvsawHTFE5+QqbaOC
         yvybeXoksL9JUu+MhdSqseZ3uyPjgwqlL7fq4TChhSvuPFtHWN8OSg7mMu0wzrPgVGFL
         OAlUzgjzGjVUcm7wd0lA7g0B4u/P2z93coTEpw0FC96s5DEOeZthe8YG6VowKbwLWnPu
         LlkDl4ggO/zbarUQJC9Yiyo1nlxI2xysfGnecTe5+XZjyHKraWhcbn7d2QyY1NyBh0Yg
         e/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXboBVgQeJdnv+17lEYoRGVFLq4LNFOWhLkzyo4JaDobIYXnUPo3grpoJhKv5HnWKgw3C2s1qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dTSDdUUiHFzbo1aY3lZNbV5MR+uUvJhpGry8qpDC51GCAkrd
	TTMSgOXtdMHbkEU67Nb+y99Q5xvtX0vH0DfMumSW0OjzzzJMxj8PQyfrZyasBF/W
X-Gm-Gg: AZuq6aJh4EKByBKZ2jkclBts0Sl/rKjyC6iIqQX8rKitD8Mk+9yRz7eOnixbT1YhQC5
	mT7V9yBZ+cyJDPMrkFnP6ePQgv7NKaVisWxz0oI5/RkF6rG1IT8jwX8+n18yEhxqgDarDPqpJBR
	Jb+yQ+aA3vo2GB7R+C4qhwQd2l7+30VovvmsjglRXtYn9MZgV8MgZpmarobqBuPqQqmt8jVfMwb
	WIaVOOBkJSo7i0MPPNaleKpj2MghVYHKH07QLN2H8JQTlizfhNQcbqMGSW6yPBIZMuVlHA+apIH
	7st2ma9zsD5Oa1gsF+bJ9DX7Km8orXqOIsD3Ouqtk5CFomCZHhM5A23qy5CR4hItJdF2BZC8i6B
	ymUVeQhoWq1eNSamaNLzSdFQ8wirVJ5jRrx3V+ebEWmZ8TOGMg4HzEswMysHQjWC4gM4JJVSohu
	xYeQmmkn4shJrc0hVnAISR7tmV34575bYWlt0Rppd06E4BRBb5Ni4c
X-Received: by 2002:a05:6122:a04:b0:566:38f4:4753 with SMTP id 71dfb90a1353d-5665ca0f802mr1160875e0c.18.1769425586442;
        Mon, 26 Jan 2026 03:06:26 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5663fa632d8sm1617156e0c.1.2026.01.26.03.06.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:06:26 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-563610de035so4173545e0c.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:06:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQxn3QgZGMl36BkSLhW4gHAYQFJ3CtvZhoNNBLgSXFH4TIkp69gh36b4rUMQDmJU1nyugk5RE=@vger.kernel.org
X-Received: by 2002:a05:6102:953:b0:5ef:a8da:8b26 with SMTP id
 ada2fe7eead31-5f576492b87mr1267237137.27.1769425586050; Mon, 26 Jan 2026
 03:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121232657.155281-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260121232657.155281-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jan 2026 12:06:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVa5_Ad9fssBqQkM2MYevwebowmNZbFJ64AXirn0KfrRA@mail.gmail.com>
X-Gm-Features: AZwV_Qj5vhAcK_cpdHEhBGKru4FfHXAD4S81A5Q270vbDRN7RD5_nDM_1mnBenA
Message-ID: <CAMuHMdVa5_Ad9fssBqQkM2MYevwebowmNZbFJ64AXirn0KfrRA@mail.gmail.com>
Subject: Re: [PATCH v3] clk: rs9: Reserve 8 struct clk_hw slots for for 9FGV0841
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-clk@vger.kernel.org, stable@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-211549-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,baylibre.com:email,linux-m68k.org:email]
X-Rspamd-Queue-Id: 731B7877B7
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 at 00:27, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The 9FGV0841 has 8 outputs and registers 8 struct clk_hw, make sure
> there are 8 slots for those newly registered clk_hw pointers, else
> there is going to be out of bounds write when pointers 4..7 are set
> into struct rs9_driver_data .clk_dif[4..7] field.
>
> Since there are other structure members past this struct clk_hw
> pointer array, writing to .clk_dif[4..7] fields corrupts both
> the struct rs9_driver_data content and data around it, sometimes
> without crashing the kernel. However, the kernel does surely
> crash when the driver is unbound or during suspend.
>
> Fix this, increase the struct clk_hw pointer array size to the
> maximum output count of 9FGV0841, which is the biggest chip that
> is supported by this driver.
>
> Cc: stable@vger.kernel.org
> Fixes: f0e5e1800204 ("clk: rs9: Add support for 9FGV0841")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Closes: https://lore.kernel.org/CAMuHMdVyQpOBT+Ho+mXY07fndFN9bKJdaaWGn91WOFnnYErLyg@mail.gmail.com
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Update the commit message crash paragraph
>     - Add RB/TB from Geert
> V3: Add Closes:

It would be good if this would make v6.19 or v6.20-rc1, as it is a
hard dependency for adding 9FGV0841 device nodes to DT in v6.21.

Thank you!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

