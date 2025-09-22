Return-Path: <stable+bounces-180908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C5B8FBBE
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 11:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF9318A011F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E31F4E4F;
	Mon, 22 Sep 2025 09:21:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384A188734
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532892; cv=none; b=BZ5YUr/bu6ryjDaaM8F3UYOlBY45bDO0W4B+CnLWk5RQooe7e0OMNelmmcvJZvwOUsWzTgSsUPiz7qjlRCDLxT3BJrWd0iZYM1FXP4kTiHBq2ORzR9np3qECyYLTAA2cYBipfnr6WrZlLx+jQtDvKLfUDUdKPfU3WA0DezD/kc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532892; c=relaxed/simple;
	bh=9JrWEg4nRUPQ0c4UssG+3KfveXvJyaWiL/913pVnU8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5pRh+wFjmEa+Lv01lY2AHVTLS/brbXrx0RVJsUzeg/iFmGkZAYRlL0JhUshUCudQEdcCHYV/DB8SI3V5mOPLf/mz9Z3ffkUPNzcY03F3qRNphRoffJ7AVcS0jgh0DuKNKw+TRDwUB+voOhW0zAh+MlbkMWnn+ItZgg25vzk+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54a8d35ebccso1630368e0c.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 02:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532889; x=1759137689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVYuCYK9Kvj3QHdD1tvpgcDHhvVlI3yo7fnDbEKQFYo=;
        b=dSYI4MFIbs9WwLy0TPK1OI+Q/AZ8E7cMB/OZQ0V3bPSRKnfQrStFAlyUkVk1yA3iBX
         6PzGe1p5+bEQYeXLkcgyhaTbLAOXRfqUtzID9lv/I0s8e55b1PSb2ltRunKNkLUBskau
         DA/X8CDOjAkqHxfHGa0YpNLEs4wBaStE6OPopLou9uNxuakgx2WGEbyLkbwS+vdkt8Ib
         g1GuvP39hYCCElvsXFy17He19RcLEwerCAY0z75P+n69hs/YSuogEywSvdKEBjKD5ZcO
         7kYXHSLZq/e25KaxPwLyXumtTE8TaC9BNR4SoPBXliLL1+n1G3+EADCIDSlEW8WUBNo7
         KGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOgmuOI/h5M7rDrV6HZrPCCQXY7M10kpurNWUkXTLEP8BGfwg2UVU4FbEZM0cEvExQK6eG65A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbvo7KtG1CBLdchNo9vTO9wqc4G8W0RTkxt6iHAQF3xDCxuWIW
	yN7JPjUFRBvrjdQwcIDLCrHI76pAu7TlUXKuKTqTRfr9LBen7jgTVOko0/BvEb5Z
X-Gm-Gg: ASbGncspCjgbMJBwUyC79zUOcrX2jMjkYmh8/irjmRTd72HVZXeYpecewpBeSmxc9vI
	Xf/gBGiWn57YnhPQXLFGsTMfydyHoEFVBEX/SIyxZuT4GX2y90UNGqMO1lBN1IS9Zczj4fkx+Cv
	8ylXaPM+2Z4rUCRgtEfzlPjEnEbc+CkCv9oYQ3by+GWhyHp8dTlD+ca2raA4j9SQ5YCW4+ewqpe
	OnqeiI+JL5VN4NGrT+bzfT0FASsdkdybiesSqCtyhgSO3wRFQHxu0RfCeaRVrwSpLl+NDTn9jo9
	YV+gfv6qqtPbSjOP1OxYidbUK/MuDLY/aXQMZGGl12hB4/sbKYfMqaStXvUmjzPg338z4M4q8JP
	KGtqu9dLe7Gzsy+tXiNBm6pxoVaZ3l388NiImowhRBpRGxEmcUWYdHCTp21QR
X-Google-Smtp-Source: AGHT+IHzQb00IT/xQi2PLs1OtEEakKf6SOBYnWtWCCLXFLPsxm1vI7OKGItK8GqSJmiwVaQq2Ht1/Q==
X-Received: by 2002:a05:6122:a1a:b0:544:9313:8387 with SMTP id 71dfb90a1353d-54a83b1d703mr3966363e0c.15.1758532889223;
        Mon, 22 Sep 2025 02:21:29 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a9928f33asm1042713e0c.5.2025.09.22.02.21.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:21:28 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018ec3597so2663587241.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 02:21:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDHqxoq/DeyGJfF9SnNuUUdL/g0CxM+RNvxAE9ojDbS30gKe81t0jPr+qlVHCaPgc//gnh6hQ=@vger.kernel.org
X-Received: by 2002:a05:6102:15ac:b0:529:96b9:1fce with SMTP id
 ada2fe7eead31-588f3728e13mr4100170137.27.1758532888150; Mon, 22 Sep 2025
 02:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162707.13927-1-marek.vasut+renesas@mailbox.org> <20250909162707.13927-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250909162707.13927-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 11:21:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_xVfhay9r5pmj=E6k6EFts3YS8xmQFCUgTdm=eh8OZA@mail.gmail.com>
X-Gm-Features: AS18NWB7sUqLUtredbr9YhKbzrCa7HLSwrRuHzfalv-EHnhLzadagftJ0EPTHk0
Message-ID: <CAMuHMdU_xVfhay9r5pmj=E6k6EFts3YS8xmQFCUgTdm=eh8OZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: rcar-host: Convert struct rcar_msi mask_lock
 into raw spinlock
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, stable@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

CC tegra

On Tue, 9 Sept 2025 at 18:27, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The rcar_msi_irq_unmask() function may be called from a PCI driver
> request_threaded_irq() function. This triggers kernel/irq/manage.c
> __setup_irq() which locks raw spinlock &desc->lock descriptor lock
> and with that descriptor lock held, calls rcar_msi_irq_unmask().
>
> Since the &desc->lock descriptor lock is a raw spinlock , and the
> rcar_msi .mask_lock is not a raw spinlock, this setup triggers
> 'BUG: Invalid wait context' with CONFIG_PROVE_RAW_LOCK_NESTING=y .
>
> Use scoped_guard() to simplify the locking.
>
> Fixes: 83ed8d4fa656 ("PCI: rcar: Convert to MSI domains")
> Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

drivers/pci/controller/pci-tegra.c seems to have the same issue.

> ---
> =============================
> [ BUG: Invalid wait context ]
> 6.17.0-rc4-next-20250905-00049-g13b74d3367a3-dirty #1117 Not tainted
> -----------------------------
> swapper/0/1 is trying to lock:
> ffffff84c1974e58 (&msi->mask_lock){....}-{3:3}, at: rcar_msi_irq_unmask+0x28/0x70
> other info that might help us debug this:
> context-{5:5}
> 6 locks held by swapper/0/1:
>  #0: ffffff84c0e0d0f8 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
>  #1: ffffffc0817675b0 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pci_lock_rescan_remove+0x18/0x20
>  #2: ffffff84c2a691b0 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
>  #3: ffffff84c1976108 (&dev->mutex){....}-{4:4}, at: device_lock+0x14/0x1c
>  #4: ffffff84c2a71640 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0xa4/0x5bc
>  #5: ffffff84c2a714c8 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0x230/0x5bc
> stack backtrace:
> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc4-next-20250905-00049-g13b74d3367a3-dirty #1117 PREEMPT
> Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> Call trace:
>  dump_backtrace+0x6c/0x7c (C)
>  show_stack+0x14/0x1c
>  dump_stack_lvl+0x68/0x8c
>  dump_stack+0x14/0x1c
>  __lock_acquire+0x3e8/0x1064
>  lock_acquire+0x17c/0x2ac
>  _raw_spin_lock_irqsave+0x54/0x70
>  rcar_msi_irq_unmask+0x28/0x70
>  irq_chip_unmask_parent+0x18/0x20
>  cond_startup_parent+0x40/0x44
>  pci_irq_startup_msi+0x20/0x58
>  __irq_startup+0x34/0x84
>  irq_startup+0x64/0x114
>  __setup_irq+0x3f8/0x5bc
>  request_threaded_irq+0x11c/0x148
>  pcie_pme_probe+0xec/0x190
>  pcie_port_probe_service+0x34/0x5c
>  really_probe+0x190/0x350
>  __driver_probe_device+0x120/0x138
>  driver_probe_device+0x38/0xec
>  __device_attach_driver+0x100/0x114
>  bus_for_each_drv+0xa8/0xd0
>  __device_attach+0xdc/0x15c
>  device_initial_probe+0x10/0x18
>  bus_probe_device+0x38/0xa0
>  device_add+0x554/0x68c
>  device_register+0x1c/0x28
>  pcie_portdrv_probe+0x480/0x518
>  pci_device_probe+0xcc/0x13c
>  really_probe+0x190/0x350
>  __driver_probe_device+0x120/0x138
>  driver_probe_device+0x38/0xec
>  __device_attach_driver+0x100/0x114
>  bus_for_each_drv+0xa8/0xd0
>  __device_attach+0xdc/0x15c
>  device_initial_probe+0x10/0x18
>  pci_bus_add_device+0xb8/0x130
>  pci_bus_add_devices+0x50/0x74
>  pci_host_probe+0x90/0xc4
>  rcar_pcie_probe+0x5e8/0x650

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -12,6 +12,7 @@
>   */
>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> @@ -38,7 +39,7 @@ struct rcar_msi {
>         DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>         struct irq_domain *domain;
>         struct mutex map_lock;
> -       spinlock_t mask_lock;
> +       raw_spinlock_t mask_lock;
>         int irq1;
>         int irq2;
>  };
> @@ -602,28 +603,26 @@ static void rcar_msi_irq_mask(struct irq_data *d)
>  {
>         struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
>         struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
> -       unsigned long flags;
>         u32 value;
>
> -       spin_lock_irqsave(&msi->mask_lock, flags);
> -       value = rcar_pci_read_reg(pcie, PCIEMSIIER);
> -       value &= ~BIT(d->hwirq);
> -       rcar_pci_write_reg(pcie, value, PCIEMSIIER);
> -       spin_unlock_irqrestore(&msi->mask_lock, flags);
> +       scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
> +               value = rcar_pci_read_reg(pcie, PCIEMSIIER);
> +               value &= ~BIT(d->hwirq);
> +               rcar_pci_write_reg(pcie, value, PCIEMSIIER);
> +       }
>  }
>
>  static void rcar_msi_irq_unmask(struct irq_data *d)
>  {
>         struct rcar_msi *msi = irq_data_get_irq_chip_data(d);
>         struct rcar_pcie *pcie = &msi_to_host(msi)->pcie;
> -       unsigned long flags;
>         u32 value;
>
> -       spin_lock_irqsave(&msi->mask_lock, flags);
> -       value = rcar_pci_read_reg(pcie, PCIEMSIIER);
> -       value |= BIT(d->hwirq);
> -       rcar_pci_write_reg(pcie, value, PCIEMSIIER);
> -       spin_unlock_irqrestore(&msi->mask_lock, flags);
> +       scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
> +               value = rcar_pci_read_reg(pcie, PCIEMSIIER);
> +               value |= BIT(d->hwirq);
> +               rcar_pci_write_reg(pcie, value, PCIEMSIIER);
> +       }
>  }
>
>  static void rcar_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> @@ -736,7 +735,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
>         int err;
>
>         mutex_init(&msi->map_lock);
> -       spin_lock_init(&msi->mask_lock);
> +       raw_spin_lock_init(&msi->mask_lock);
>
>         err = of_address_to_resource(dev->of_node, 0, &res);
>         if (err)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

