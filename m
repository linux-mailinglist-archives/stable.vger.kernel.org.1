Return-Path: <stable+bounces-180907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5306B8FB51
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024051882B26
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0510286D56;
	Mon, 22 Sep 2025 09:14:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FF264FB5
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532491; cv=none; b=p7VK6i3+awfi7uNbbWMjteuP7nz76jG5Yzf+U7+worzA/WbHvsaV0YgRUPq6QcFi/0ResRYIfUy/7PIvIZPDMVAhe/98KEgzGn6wmCI5wuunaIeA6YTwX66ZndtKeUwrMHef7BcHGWVvzOmJPAK+TJ+FjzyZ4jBhYJiatCG0D/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532491; c=relaxed/simple;
	bh=6KHJcEnIVlCxmXhX0OhfMBaFaMVz1ecRFiMG3CflXoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUuWt7OClCBCTFMmBnatKitDGJd/pPqcUHlczIp2QVagn+lyjZH0IL+bp6mMu49HkvsgG9Wsv56Bhp6+3o99HfRwp7S1qQJZbsHbqLgLUVsidKkG7FkaNz7SwEHqG0VGgXc5qHfLUJJ9nlDMpJaM7SVLVR74TPTyakkqqz5wpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-50f8bf5c518so3166595137.3
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 02:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532489; x=1759137289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLwAIW/7uzQCGM18tYiubcKSm7XfD2QdDVkO6Wb+rco=;
        b=elFmAr/tP/cISqh02155PJkk/MpzjRl/YLS72jV2P9puxHUnuhrJDliu4vC1zP+q6P
         RDNaFnovg2ybOr+SV1oZ7d6BYW74jnMI65BpSNkiJtvl6NSNREkCa59Bg1Y6lpTgxq3J
         +BOa+7IrzdaO+WYoAwBiIjQdVsTTd9Gf/LF9b0gRnTuWhHjrHBYECDU+nIIyAichgcYh
         VAzEqXzU0gbgG6OMlkP+v5OmVNMpJGqKdZjTNO38B/D4Aruo8u19SgQXdglA1t53M7oL
         vsMT4EhlhCXfpDGxOZtugK4h6TbQinKzeoqEbqROz57utwFEWyMoBeFn2vaxc75orNd3
         FiJw==
X-Forwarded-Encrypted: i=1; AJvYcCXGUaYWUBpwkcO81BCA+OJmsdGKhePDVbzEkreBIN0Xo/XXqlOXMDRm8l4LZHwNVGx1K5QSszQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9Xe6xQHcEreJiwT/bbBy90bwXS6sBgruWT8TN+C8tOj7VC48
	olKhuWsGuW9NMMhln/s/v7RhJ0PeOh1s4HPba8ZLzhFR4tI4KtvVbWHF33Vytw5x
X-Gm-Gg: ASbGncvwH1jtwjUqZ8jDZJGk5Xhy80138axxQO4h7haaaWJueAcwODe/XLLJXgC8HlC
	0TI9qbWb6ZUAYg6NOAVhX/Ht8DCHgjKSTVCN/rt8XIkpnxADacdaSRWq2gaKENXU34pr9K6mECw
	bHyyfyT0b10G1ofmE+HvwfUvuQUn8gZM/ke6xZvfxnggCt8g7f0XuJ55Bu4dJMp85UwtxpU53es
	OzpEswVvvf8YoFr2wUWyHnPEtDbxhku97x5/uKg5p4GB93lIelnXssLXRp11eBmhNd7SMJhYMC6
	HgpJKQfK40+Ys1tGpwss4Lq2fK5KE+acj3W3Okl5CMsYJ4LxjjTijH1pY0uB8MWq81hFQnZWfaX
	e+/WW1NuYhKR2+4NyblkCq1YfT9GjXrcqFzBZikhfD6RdMsuWNVv8/3lNziCs
X-Google-Smtp-Source: AGHT+IExD55OHj+QnYBzo7JYh5dVeucjhJHiKhUkAstWV2286UA4d34BpmYFBuBTkwwfs3BpgGD4hg==
X-Received: by 2002:a05:6102:3347:b0:530:f657:c25 with SMTP id ada2fe7eead31-588d9c520f7mr3325514137.5.1758532488645;
        Mon, 22 Sep 2025 02:14:48 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9000129f5adsm458805241.14.2025.09.22.02.14.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:14:47 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018ec3597so2659996241.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 02:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4F0x8RW+5OQO7blaEwXh9ZpfZ+9go7pC7WTA0YKLzEQW0/aDEADb8jnJHF2gAU2/1Z72x5wo=@vger.kernel.org
X-Received: by 2002:a05:6102:3053:b0:5a4:420c:6f94 with SMTP id
 ada2fe7eead31-5a4420c955emr87759137.4.1758532486911; Mon, 22 Sep 2025
 02:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 11:14:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
X-Gm-Features: AS18NWCy28oVP6aNkng2frgdJoNjIFwDpm5d2hI--F1SYyy5KYW3QCIN2mFvGL4
Message-ID: <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

CC tglx

On Tue, 9 Sept 2025 at 18:27, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The pmsr_lock spinlock used to be necessary to synchronize access to the
> PMSR register, because that access could have been triggered from either
> config space access in rcar_pcie_config_access() or an exception handler
> rcar_pcie_aarch32_abort_handler().
>
> The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
> commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
> which triggered an exception"), which performs more accurate, controlled
> invocation of the exception, and a fixup.
>
> This leaves rcar_pcie_config_access() as the only call site from which
> rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
> called from the controller struct pci_ops .read and .write callbacks,
> and those are serialized in drivers/pci/access.c using raw spinlock
> 'pci_lock' . CONFIG_PCI_LOCKLESS_CONFIG is never set on this platform.
>
> Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
> raw spinlock, this constellation triggers 'BUG: Invalid wait context'
> with CONFIG_PROVE_RAW_LOCK_NESTING=y .
>
> Remove the pmsr_lock to fix the locking.
>
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

Your reasoning above LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

My only worry is that PCI_LOCKLESS_CONFIG may be selected on non-x86
one day, breaking your assumptions.  IMHO, the mechanism behind this
config option, introduced in commit 714fe383d6c9bd95 ("PCI: Provide
Kconfig option for lockless config space accessors") looks very fragile
to me: it is intended to be selected by an architecture, if "all" low
level PCI configuration space accessors use their own serialization or
can operate completely lockless.  Usually we use the safer, inverted
approach (PCI_NOLOCKLESS_CONFIG), to be selected by all drivers that
do not adhere to the assumption.
But perhaps I am missing something, and this does not depend on
individual PCIe host drivers?

Regardless, improving that is clearly out-of-scope for this patch...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

