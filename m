Return-Path: <stable+bounces-200737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7DCB393E
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 18:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156033058FB6
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6574326951;
	Wed, 10 Dec 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSYCeALF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0750324B3E
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387030; cv=none; b=X7xbYWVEOZnB3bUMiQTtIGpHF12GqpafZmNeMZktdu5JIiAJrPd9/hcNnrIvRfA4yfMSwhK6VjzkXQUZamDll5PcdZF5VS6ZoMppsTFA5neYRzV+KntbPXy+BBJqVw3CLQaXayAT/19tRPZIbIb1+Oh3eoZSuvqGQp4OPJbQMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387030; c=relaxed/simple;
	bh=8fve6gmVdjKxtT7KpwkSfLuyzw4Ekfqcp/fLflsSjHY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1qlmkIuxa10w+ZxuIecncwWq1+fdPmBoJ2zNXO4k9Po7gVYcMFtpvpJy4UfEfeRrCINZ8HjlbhXZfT8wiYDZPpYmXvfkHzQsoR2i67aAfl5mk6sRPcQ9mLMvqBTPmw86cYAiF4mHV3Hvlpdhyp/RFJrLJa3D8gGcIVqz/7JThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSYCeALF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so416105e9.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765387027; x=1765991827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6hFo41XcPPply/FI538h06+gGYf20ouIY7Y9ZDaKEeQ=;
        b=WSYCeALFSIrg3vFmpmQ2lPJEZp5A4KYpy4GJ2DJYb1OHJptURhnsmUdSxBkgc/PPqL
         QZGbahf59zoUPy/alo8Y9E6fVGxm2apRrn+4KLGILFNv+79jz3K7+2Vtxn48/czbKUlN
         YqDaClqkHJP6YOriIvpEKkkmVouVq4eK1TQE2JhrCwmDZgHHSQ4iOiymE3IM19EcTjzn
         joyaCSnpGghkpibH0vMhXs0fOipmE+t3kZR/KkdjYrOtIyPrJfLnxKOtUOrV9qlmr/I9
         tiXlP7+9bCiXK/TypHQowrOk3l6ikT+l8+dYWjIUrWTSuy31JkgbMZMMmQWAVsVc6uFD
         OB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765387027; x=1765991827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hFo41XcPPply/FI538h06+gGYf20ouIY7Y9ZDaKEeQ=;
        b=swV6QBVuai02FqPe30Rzrjf4+ySjlCfZUm1SGgIJdgFZ27eSs1qbaLQLpN73ANZknn
         evGAWZMeHRizs/cHt2omW6Wv6dV/Af9Llckvcn9YJBHxSlAndbA2lcWLzauR58PexiiF
         LxL1CCyFfYJqZEpTmp3BScHMJcjdK45rzvi1Dmo6F2KvbOHEx0MmL6FvLEvMJL5sbwYK
         SHzv/+HLzDo9BgCssVZyW1VS9bTOEfHHqiBs+DRppbm8NKIzKjmz7uAe16y8Ini2fRGz
         3izxUqjJy4R2uTVSzf6RKbKKA9X6cgVk03TfWfNToVkAUfQqM7fH3CiOpaMQF2XXdLuU
         DsWg==
X-Forwarded-Encrypted: i=1; AJvYcCVpyXysLUs921E1bOgxuigjNi+BhoeTuFuQDoYojRAyMRbXxS9vmepXPBotRD4m944GikZZGn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCASXyL3wEgkNgB968M0BYPuZSGpkVR3aWfOt6rQp1HMCSk9SN
	tcyWRVe03PGmWsiaSAvoxEc/2TiCL5u8+ZuGQppxe8gZ2fZN43kWqi5X
X-Gm-Gg: ASbGncuCMrVcbj4Kw12Ib10IH/gYWhM5iuvS2a8Xe9wn5GlpvrnmzOiQy7iaU5asSVw
	iuAtG1P7CLnm6YsyZJRIE7hGZ/Ffqgncj5NIXbgdniqtYifmBbIToklcOM8UxW37tbmiA3RMAhY
	NO4qrnoWGofv1g0JqL9+dGOSP1QFb421bg/ExsSztAvJlzg2JE291eCvEEtYOA8xEzDwAt/ILlR
	jvclm+l0bNfgQgxBfM4BgSx4UQphow3cbHkY8tcJ8G5Y1E3sqWtg0P/zQhah7dDQ9gHprJWqmHy
	WjOL71zDc3jxiXup3mcUWyHRPuuSwomW8tM2Km7I5wsqcOkAE2JPKRY8zHB/43xxXewYhvgzlF8
	w5nCR+PbUfx10ZIsHG3RC8xWKdE9bICxDgBDeyXfAGB5j102xlPs6tFFPSFl1tjKxrzN3QtfoKM
	o5tbp4QpkSmYKtxs++26AlLcfaH5yvUJUYiYT3iic=
X-Google-Smtp-Source: AGHT+IGAFUaoxDl1XO7WFPjWhj1fe2N2/CH3UpEX9fZkmDbnaCR/5zfcwYt/zvtVtsDrqaQ4Ad/MHw==
X-Received: by 2002:a05:600c:1e24:b0:479:3a88:de5e with SMTP id 5b1f17b1804b1-47a8385368dmr22664605e9.37.1765387026744;
        Wed, 10 Dec 2025 09:17:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a88923ce6sm397615e9.18.2025.12.10.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 09:17:06 -0800 (PST)
Message-ID: <6939ab12.050a0220.29891a.9a37@mx.google.com>
X-Google-Original-Message-ID: <aTmrDS-RCPT1OKmw@Ansuel-XPS.>
Date: Wed, 10 Dec 2025 18:17:01 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Use resource_set_range() that correctly sets
 ->end
References: <20251208145654.5294-1-ilpo.jarvinen@linux.intel.com>
 <20251210171319.GA3530931@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210171319.GA3530931@bhelgaas>

On Wed, Dec 10, 2025 at 11:13:19AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 08, 2025 at 04:56:54PM +0200, Ilpo Järvinen wrote:
> > __pci_read_base() sets resource start and end addresses when resource
> > is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
> > of representing 64-bit PCI addresses. This creates a problematic
> > resource that has non-zero flags but the start and end addresses do not
> > yield to resource size of 0 but 1.
> > 
> > Replace custom resource addresses setup with resource_set_range()
> > that correctly sets end address as -1 which results in resource_size()
> > returning 0.
> > 
> > For consistency, also use resource_set_range() in the other branch that
> > does size based resource setup.
> 
> IIUC this fixes an ath11k regression (and probably others).  And
> typically when booting a 32-bit kernel with a device with a BAR larger
> than 4GB?
> 
> Christian, is there any dmesg snippet we could include here to help
> users diagnose the problem?  I guess the "can't handle BAR larger than
> 4GB" message is probably one clue.
> 
> Are you able to test this and verify that it fixes the regression you
> saw?
>

No my regression was on a different section and for AHB cards, no PCI.
(I sent a fix for my regression on the net mailing list)

Could be hard to find a device with 4+ gb of ram that is not x86 or on
an ipq SoC.

> > Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
> > Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/probe.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 124d2d309c58..b8294a2f11f9 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
> >  		    && sz64 > 0x100000000ULL) {
> >  			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
> > -			res->start = 0;
> > -			res->end = 0;
> > +			resource_set_range(res, 0, 0);
> >  			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
> >  				res_name, (unsigned long long)sz64);
> >  			goto out;
> > @@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  		if ((sizeof(pci_bus_addr_t) < 8) && l) {
> >  			/* Above 32-bit boundary; try to reallocate */
> >  			res->flags |= IORESOURCE_UNSET;
> > -			res->start = 0;
> > -			res->end = sz64 - 1;
> > +			resource_set_range(res, 0, sz64);
> >  			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
> >  				 res_name, (unsigned long long)l64);
> >  			goto out;
> > 
> > base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
> > -- 
> > 2.39.5
> > 

-- 
	Ansuel

