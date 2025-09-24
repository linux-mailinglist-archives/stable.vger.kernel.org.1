Return-Path: <stable+bounces-181553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E7B97C87
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 01:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE611AE193F
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE443112DD;
	Tue, 23 Sep 2025 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XpigEz1u"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073F3112D0
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668854; cv=none; b=ZesVUqj8x7QsR3kgMiIuZ3m1ZBPQ0J0a+eswkE5KFH29RN+nAfjIeCU0lindxSqDnRjWwiTjs9J3WHVyBjQXBlMruZB4LUPLq/JwUEL2sc+xx4HFu4+CQvRLnlWscRcSH8S0mjSnd50kO4ggXhslRoCmX5wLkTyEOwUj0EZBuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668854; c=relaxed/simple;
	bh=YnYd/gKeEekdgcs7OqQ/sMRYsiqPBgufePpEuqafhLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTAYSV8JtTsILG07/YwQ6Ar+PxXOFufafuAA82jzxveilh4qDrZK2LjvukDwvNxewK82Q1JbhMe3Y5ORK1i1mKVozkMx1K3G5uvoJuES4bZ2gPfqpDpdwfqQVVJzdrVSjVe9uFYVtCPqua5c6obpMSNJSyVywn+yunTMQY5d1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XpigEz1u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2570bf6058aso83020535ad.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758668852; x=1759273652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFOv8LRjpZLWIF9uYfzl4ykO48TjCgwNklWa0BlqT0g=;
        b=XpigEz1uCSrov6c/1QrojDRCSgFjddeMlxAm1zT2fDyVz5yLJ38QjdUCX+2S83rBYN
         bDZmuDv8DrRmhLMjqGD4CT3mjuu8aHaCqdxvRcUXYvgv7HzJl5SJIrBJt5ZI1Oh2gOJd
         JetNBFmqHg5tk8eQKXh+XuUYksZD7icSMioxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758668852; x=1759273652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFOv8LRjpZLWIF9uYfzl4ykO48TjCgwNklWa0BlqT0g=;
        b=jc6RPDr0Mz6Mgv1g/bJtMw/o+B+UVFZRAVVw/LSnAy/Tm/CKLPptzPdNXM6O7A3lv5
         OFtR1bXQ82wSdaa8ArbwxM77Gae5aPTAvsVgKuHc0/3J8LNnab8ubze3HZ8+TPIaHBa9
         q2/+Fk/7uMjx/xN5Fxb5w/LndiYXXAA5cqYjI+TCkKoAYnbIPQPRK5ZoXGRRCjcwFqOW
         fWSpVkwW7yirEMcdjEKYNbXhBAFtG2hSu0XqCCe5Zd6yrprn2BysDwIxMBMkM8bpLDKw
         pCc0T+3k4jT4M7m3dpRGrzOgwdh5oHKw9/wxVL0ThF070GO1NnZPJjy80zHGwogwjdvD
         g15w==
X-Forwarded-Encrypted: i=1; AJvYcCUg8oNTyGAIZwZ7mOfKzyhKqDyCa882kADGii9EOClxfDbmT8aM5+iA5Q0zZOdSZpwVCW2rLLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQ/XC3lRxBNbVMh+jyDTs3X7x4qTZQLgs6n1va+pW5mdOqi7H
	FHYmD0VYIG6R7OQfwj1s/7w11Twjp926zn9iihE7SYX4lyP4F1nbMrrdBFREKwMhhQ==
X-Gm-Gg: ASbGncuhN7rftDnLcMyraNDs1ukgS88hC4zfOn7Dwra1ew9C7D3NbErBpW3kjlT6zI2
	2teA9767L0rg037Wm5HR7qNHc0N2krFiPnCvEY3Ei3NlO0jQVvNb9uOwTCkdTuJo1R+B7/r+qUl
	4c0rV3WN9k/GoH3Rsbnm1qWoCl8hUxcXd+nOrDBhiRzkuFGqx66foUmXKisApPrCeOZb5SVOPZu
	HLjdtR5jXt9WhRd5CF9o4ySN+zpLlFG5HSgw7lcxBk1TeEu4bShCk8jF7R8wkrrwE+5P2xdrZL3
	oUJQ4cwKrJXle0jqzHiPCGTDOI3Z/rnQ7sEeTSwmEDOLcdPfPrmza7bRHHmJzWxIPXzXEUWHxi1
	qF19bNxHfLTrXcr/MSU5UoXO+hUMKVVaT67iakZKUKEmoEimRhNKqo+iRRVj5
X-Google-Smtp-Source: AGHT+IFVPYMKnS8TWlnAQXccka7DEPTB/RihRAWX3su86ixXqz/GV9aDNk1vsFjQk0na0d8kYCF0SQ==
X-Received: by 2002:a17:903:37c7:b0:269:7427:fe37 with SMTP id d9443c01a7336-27cc678593amr52570955ad.29.1758668851792;
        Tue, 23 Sep 2025 16:07:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:26d9:5758:328a:50f8])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3341bdc1cfesm262574a91.23.2025.09.23.16.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 16:07:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 16:07:29 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	Ethan Zhao <etzhao1900@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aNMoMY17CTR2_jQz@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <20250923190231.GA2052830@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923190231.GA2052830@bhelgaas>

Hi Bjorn,

On Tue, Sep 23, 2025 at 02:02:31PM -0500, Bjorn Helgaas wrote:
> [+cc Ethan, Andrey]
> 
> On Wed, Aug 20, 2025 at 10:26:08AM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > max_link_speed, max_link_width, current_link_speed, current_link_width,
> > secondary_bus_number, and subordinate_bus_number all access config
> > registers, but they don't check the runtime PM state. If the device is
> > in D3cold, we may see -EINVAL or even bogus values.
> > 
> > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > rest of the similar sysfs attributes.
> 
> Protecting the config reads seems right to me.
> 
> If the device is in D3cold, a config read will result in a Completion
> Timeout.  On most x86 platforms that's "fine" and merely results in ~0
> data.  But that's merely convention, not a PCIe spec requirement.
> 
> I think it's a potential issue with PCIe controllers used on arm64 and
> might result in an SError or synchronous abort from which we don't
> recover well.  I'd love to hear actual experience about how reading
> "current_link_speed" works on a device in D3cold in an arm64 system.

I'm working on a few such arm64 systems :) (pcie-qcom Chromebooks, and
non-upstream DWC-based Pixel phones; I have a little more knowledge of
the latter.) The answers may vary by SoC, and especially by PCIe
implementation. ARM SoCs are notoriously ... diverse.

To my knowledge, it can be several of the above on arm64 + DWC.

* pci_generic_config_read() -> pci_ops::map_bus() may return NULL, in
  which case we get PCIBIOS_DEVICE_NOT_FOUND / -EINVAL. And specifically
  on arm64 with DWC PCIe, dw_pcie_other_conf_map_bus() may see the link
  down on a suspended bridge and return NULL.

* The map_bus() check is admittedly racy, so we might still *actually*
  hit the hardware, at which point this gets even more
  implementation-defined:

  (a) if the PCIe HW is not powered (for example, if we put the link to
      L3 and fully powered off the controller to save power), we might
      not even get a completion timeout, and it depends on how the
      SoC is wired up. But I believe this tends to be SError, and a
      crash.

  (b) if the PCIe HW is powered but something else is down (e.g., link
      in L2, device in D3cold, etc.), we'll get a Completion Timeout,
      and a ~0 response. I also was under the impression a ~0 response
      is not spec-mandated, but I believe it's noted in the Synopsys
      documentation.

NB: I'm not sure there is really great upstream support for arm64 +
D3cold yet. If they're not using ACPI (as few arm64 systems do), they
probably don't have the appropriate platform_pci_* hooks to really
manage it properly. There have been some prior attempts at adding
non-x86/ACPI hooks for this, although for different reasons:

    https://lore.kernel.org/linux-pci/a38e76d6f3a90d7c968c32cee97604f3c41cbccf.camel@mediatek.com/
    [PATCH] PCI:PM: Support platforms that do not implement ACPI

That submission stalled because it didn't really have the whole picture
(in that case, the wwan/modem driver in question).

> As Ethan and Andrey pointed out, we could skip max_link_speed_show()
> because pcie_get_speed_cap() already uses a cached value and doesn't
> do a config access.

Ack, I'll drop that part of the change.

> max_link_width_show() is similar and also comes from PCI_EXP_LNKCAP
> but is not currently cached, so I think we do need that one.  Worth a
> comment to explain the non-obvious difference.

Sure, I'll add a comment for max_link_width.

> PCI_EXP_LNKCAP is ostensibly read-only and could conceivably be
> cached, but the ASPM exit latencies can change based on the Common
> Clock Configuration.

I'll plan not to add additional caching, unless excess wakeups becomes a
problem.

Brian

