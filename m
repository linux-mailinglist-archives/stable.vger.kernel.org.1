Return-Path: <stable+bounces-180942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D3B90472
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF0C3AC79B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A042882BD;
	Mon, 22 Sep 2025 10:53:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00031522F
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538428; cv=none; b=d5287F9TAuptT6Hl5gsGZ0puguXe5B+m873CN4q4AnF389Aovmrp4jP07XuY9Njs1Wpoawv+Q31WLRf+7w/7sPk/2b2MRC/MnPMKj6fe/DBpfwH/4cK/0L/3TGjSQWz7TPKhF1AatC5mGYs33ZFopAZ4B8L6hJSr5ShqFVPc620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538428; c=relaxed/simple;
	bh=eXihiG3aeC1WzVlWcj5zb88cbq/pGoIu+NxK5VsZC/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xeow4ldJG3arjXoN19nQXXEPBPCFSih5YRbBbkFKJzT5mgoahv5s9Nl/1oSY9s/pUKn4Typ+4Wj08wQZr+DgUFVVImhpG24MIaE/lk78n8hl51faTczcTu71+qNVTJIUn6rAM6QDeVWAkQ7xSvzkdkFXRmLKPynL1PCVhoH5Tqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54b21395093so579238e0c.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 03:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758538426; x=1759143226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeoWW6dZueQwB1hSDpJoXh/pdOSTxwozBB0k98T2GFM=;
        b=JzWoGf6tFGU8RVefL8IN2I2uEiYPP4/nOYWECfXMeTcbF2gOQTqirO5ePSo7nPv7hX
         SNKuEuZUuLc6r8uvVRJev7HRoEJHLI16s05GEebfK6osuODQB9vMNO6XlIEovyBE5wK1
         Ah/0JkzXE4i0TyC33h2nPbYoTd19DKQRn2rOzV4QWYJMvuE6oQyWeWU480HLedv6IN4g
         A8IhS5jYthxmf12D9zSa5skmV8X9Z03K5H/Ca1U3DUcolqPzr+QyXIY0AXrpzUp2+Rg1
         1r1XSfohvprUPAVcFuP8N7+Pv7pHu5e1bCxy6AcwiUGUd9jM2KB3XR60F/ftwA1ja0Sl
         11vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLCsjjANr/evdSx7tgEY4F8cxwuQlfpWCTCpCh5nOhsG9AbxdygEPH+FrACxFbW+2s262DOUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IIWHml5KWP6aArDcwGvF/iV/82T/eQOnBzu8r0PN9muIyJd4
	hdhHvun4BTAMwglvmHnPr819DptoltZHyrBnfw/9z6+mDGODQKHt0N1uNAbn1wBX
X-Gm-Gg: ASbGncttab+F6arZiC8CrZdDzkG8Wcxpvz/Go12oeWJXgbZ/PACz6JJvVJ0jfDgStIy
	u21lOuce0/AVP0AY2x+1boPvOP//2vccPoE+veJp5vLzvzKal8ikfCBDCfZIaaeyCYUHcUiuBqd
	bjwtWa6S4cCbpIDnRfeQYCcwnQIrj/NYEZ0I87webkxfloEsoW4ljpQQwj1AhPdf8O9Ip74hI40
	W416IvZYjhyptN+4XCm2u2qj5T+kCNUZbS6eSoAB+VZehuI4N/IjkhlrgAzIyolJb89gAB6Be16
	TH419qOptAmGWaj4EQ6siA7yEkXgP7puh23PTH43BM21XXl2JTq6FBuU6lgywVABYIDTRZbOWvR
	4dIYNeRQMe6vfEBpm5u2kTbuSpgmZVLnP1XvrFmoW4UjxLL+LVevhjjDOfQAK
X-Google-Smtp-Source: AGHT+IETYKUhXUI/s80KsiruWQi/4d7WoWfSNkwrM6Sadwzk1IDFpgY0fnSdhhgojhkcdG7n+wcj3g==
X-Received: by 2002:a05:6122:3b17:b0:54a:8ad3:7b5 with SMTP id 71dfb90a1353d-54a8ad30debmr2733289e0c.1.1758538425635;
        Mon, 22 Sep 2025 03:53:45 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bbc96cd18sm353309e0c.4.2025.09.22.03.53.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:53:45 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8e286a1afc6so2677613241.1
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 03:53:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhjU0v6sd+vcIUqfe+0bASDFQUVwYpI5oojfWh3+pKlWQcioF+2G3b3nlyhHAnnklEyJERmwc=@vger.kernel.org
X-Received: by 2002:a05:6102:3245:20b0:59e:73d5:8b57 with SMTP id
 ada2fe7eead31-59e73d624c1mr1043255137.16.1758538424823; Mon, 22 Sep 2025
 03:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org>
 <CAMuHMdXWWLGHJwxz6yYjhS2oQdmMO+Zfi4b3N3uTPN-NOeEpkA@mail.gmail.com> <575ae1bc-0478-4f69-9002-4a48742e04e8@mailbox.org>
In-Reply-To: <575ae1bc-0478-4f69-9002-4a48742e04e8@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 12:53:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUP26CELeqro3sdgHT9DK7keWhcUqnkG2eXH2zBP8RqzA@mail.gmail.com>
X-Gm-Features: AS18NWBwpjLmLylzl6CTlZVUem_pLbg-o8tzohuXff76IDjxQJjQ9EiGk1YUs34
Message-ID: <CAMuHMdUP26CELeqro3sdgHT9DK7keWhcUqnkG2eXH2zBP8RqzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar-host: Drop PMSR spinlock
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Mon, 22 Sept 2025 at 12:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/22/25 11:14 AM, Geert Uytterhoeven wrote:
> > On Tue, 9 Sept 2025 at 18:27, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >> The pmsr_lock spinlock used to be necessary to synchronize access to the
> >> PMSR register, because that access could have been triggered from either
> >> config space access in rcar_pcie_config_access() or an exception handler
> >> rcar_pcie_aarch32_abort_handler().
> >>
> >> The rcar_pcie_aarch32_abort_handler() case is no longer applicable since
> >> commit 6e36203bc14c ("PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
> >> which triggered an exception"), which performs more accurate, controlled
> >> invocation of the exception, and a fixup.
> >>
> >> This leaves rcar_pcie_config_access() as the only call site from which
> >> rcar_pcie_wakeup() is called. The rcar_pcie_config_access() can only be
> >> called from the controller struct pci_ops .read and .write callbacks,
> >> and those are serialized in drivers/pci/access.c using raw spinlock
> >> 'pci_lock' . CONFIG_PCI_LOCKLESS_CONFIG is never set on this platform.
> >>
> >> Since the 'pci_lock' is a raw spinlock , and the 'pmsr_lock' is not a
> >> raw spinlock, this constellation triggers 'BUG: Invalid wait context'
> >> with CONFIG_PROVE_RAW_LOCK_NESTING=y .
> >>
> >> Remove the pmsr_lock to fix the locking.
> >>
> >> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> >> Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> >> Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Thanks for your patch!
> >
> > Your reasoning above LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > My only worry is that PCI_LOCKLESS_CONFIG may be selected on non-x86
> > one day, breaking your assumptions.  IMHO, the mechanism behind this
> > config option, introduced in commit 714fe383d6c9bd95 ("PCI: Provide
> > Kconfig option for lockless config space accessors") looks very fragile
> > to me: it is intended to be selected by an architecture, if "all" low
> > level PCI configuration space accessors use their own serialization or
> > can operate completely lockless.  Usually we use the safer, inverted
> > approach (PCI_NOLOCKLESS_CONFIG), to be selected by all drivers that
> > do not adhere to the assumption.
> > But perhaps I am missing something, and this does not depend on
> > individual PCIe host drivers?
> >
> > Regardless, improving that is clearly out-of-scope for this patch...
>
> I could send a follow up patch which would add build-time assertion that
> PCI_LOCKLESS_CONFIG must not be selected for this driver to work. Would
> that be an option ?

Or simply just "depends on !CONFIG_PCI_LOCKLESS_CONFIG"?
What do the PCIe maintainers think?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

