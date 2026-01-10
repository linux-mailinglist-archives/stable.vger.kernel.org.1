Return-Path: <stable+bounces-207966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 639AED0D7D3
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 16:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77948300A50D
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB183446BC;
	Sat, 10 Jan 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="N0J+c1cl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50B25A33F
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057224; cv=none; b=B/FnheL+akiUV7FSl4TxF4zZM+aKcpvLK7vIsDhLGeHi5+BOzFfNKmjg+KrVxLFOdndYUdZrZ5M2Cl1daZj1TLhRQj4Vhewm5/qwIDKr1588HMG6mFiMl1N6beGEfzTBph55b52gd++vq4vJnqb7c388KKxGdg5syMzqH7mvung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057224; c=relaxed/simple;
	bh=Fdg3VUgKEuGoQsmS3W7RMnv0Czg5awojHrCxG3WBS6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNJIOVd0CC5lcm/JB6zBqxFVPcPTHxB2UFtboVtbUMoBvVFO6MbDAe9rCFQeVUK5a6EQCMKKm2MzvVaJhDzQvcJHGdEXfDgnakJR5V/BIFyD08RGexbw3jsCB1ITAiKae6NUQ0sJKeyC8IGmdAWV+30JDppv3OHb3v6g/WEXOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=N0J+c1cl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c0d16bb24dso480448885a.0
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1768057222; x=1768662022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAtmem3iFCasTDCpGTLe5nm4nO45+wonDJ0VZ3vLsHw=;
        b=N0J+c1cl/G9VGv6KgrtONDETUwvzD54pn5R1L8ZUf6qITk6gpbvHyk3Pav9b3h7mkr
         odj1r8X9UIsCrZVMl/zXdTFnECziqA7fV7/Ew9pSRnmtRX9y4DRUlEP8h2JiOQ55zgmP
         dGdmo/N1+xNWWPGAqYLxZzVUJz1+v2jqwFDsxsH0C8LVe/0Rblkrfx1K9ZLYG1D8sbi6
         9Qw0B3KI6PotfJqDOYQGpTTR7RhFIIuYGpYefRXeJWxnA6sVwQeTSBKMDhtmL2nv7XqG
         3TPuSfCbR84+dzjb/OujCB+dVgKNwcky5YYjMiO45HBtG9no8AufkF0HztSQDXdy+rKd
         vAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057222; x=1768662022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAtmem3iFCasTDCpGTLe5nm4nO45+wonDJ0VZ3vLsHw=;
        b=GGVQLQQCsIeIo6jeGyLgi5IKUpXz88PDpo5zKEcppc3YIeLGotL/5Af29Raxc/pUVr
         iN+mphCLRVsuNzqQf2UWFa3+CUSk9u9TJ0/5ibyuTUWnNyFI0U33CzoUqADAySKNPuJa
         9jiyl+sDfvsal1MXGoFm0k1iuehxDJoBubvnRv2x5anzwnQ/jcuxflGDuRce7QV56fAt
         obiHiSVNIBW4YbPvzJX8Chw9ICRsyjqYB90PZ3CsQ6sgUArAvsxeXbzA6Z+81EufO6iD
         nIqfYUlzlNEBYQNF9FJ5T9NXVuzhDIdp7ZfwZElS5XFgp13maI1NGejCsuZDmeEl9lOJ
         0dbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh2DRUeQnrW+plm/F0i2t4VfvBCrP/oxL3Peyxgj6SJANw2N5OeUeeM/xd1orHXUHPOgcimxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5P8geMn/8dQ/IXzDyiLPISK8V0A2OX6NS2eW4uSQZHlx20JR
	tLcfMzNe4vKhJ47Mjzr9YIO+964VHKKrUtVSj1F3FHFjeuuYmPUBO3BRzPmSD7H2aA==
X-Gm-Gg: AY/fxX5s7yjzxueNUmhIHF3rEkUwcwiBRlp114rARTAhFt9INqUgIqiPZsWER4g7tzO
	nttPuN3qYE0CIOplvSFv7S4p4iCDzTzlEv7IMIj/EEtmJe3dk9DvvpIymf24Ryn/wvBPmbcbwJI
	auNi8dft0eaqGhjDOM4D0lbT28tc6oVvzxkfETLLod7bvpJDZY16BZdSfgQz3NgiofbO6hzmEOP
	aQMqqJQm9sJjGM1iMO+Vf+SFuIWn6zhHIzARKNCMRmeV8MXIowdUAMhvyEZEkylQPO42AQ9dcxP
	9iSIcVxziog/fxhvnyLsy66Rkl1FsWaNx6u+8Kjmf1pTHzhxX3ttqJNoItD9VGczIpLgARFfo52
	M1DdPqLrjSulig1KFPcaW2Cqt3wyMF8tFNhPdTHBS83UtQn8OKYxUM6PCiCcuMiDyzIRzy2/ty4
	HVEp2pHDgVZuxs
X-Google-Smtp-Source: AGHT+IEV3jV4AdKvuTC/8uuHZMVrsBX7rlYSWqRCbMQ/RrgvHpoEFKPD4MQCxw5ld2273kc1QY8Z/A==
X-Received: by 2002:a05:620a:bc4:b0:8a9:ef98:6835 with SMTP id af79cd13be357-8c38938540amr1835922985a.33.1768057222161;
        Sat, 10 Jan 2026 07:00:22 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7a0a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f53c422sm1114021685a.46.2026.01.10.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:00:21 -0800 (PST)
Date: Sat, 10 Jan 2026 10:00:17 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Diederik de Haas <diederik@cknow-tech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@loongson.cn>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengwen Xiao <atzlinux@sina.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
Message-ID: <e6a02bff-6371-4a03-910e-b47c5eec726c@rowland.harvard.edu>
References: <73d472ea-e660-474c-b319-b0e8758406c0@rowland.harvard.edu>
 <CAAhV-H6drj1df3Y4_Z67t4TzJ5n6YiexsEHKTPvi1caNvw5H9A@mail.gmail.com>
 <0c85d288-405f-4aaf-944e-b1d452d0f275@rowland.harvard.edu>
 <CAAhV-H5GdkMg-uzMpDQPGLs+gWNAy6ZOH33VoLqnNyWbRenNDw@mail.gmail.com>
 <34c7edd0-3c0c-4a57-b0ea-71e4cba2ef26@rowland.harvard.edu>
 <CAAhV-H7j=cD9dkaB5bWxNdPtoVR4NUFvFs=n46TaNte1zGqoOA@mail.gmail.com>
 <98e36c6f-f0ee-40d2-be7f-d2ad9f36de07@rowland.harvard.edu>
 <CAAhV-H601B96D9rFrnARho4Lr9A+ah7Cx7eKiPr=epbG17ODHQ@mail.gmail.com>
 <561129d8-67ff-406c-afe8-73430484bd96@rowland.harvard.edu>
 <CAAhV-H41kwndL+oz2Gcfpe3-MCagaQd2X21gK9kMO2vpw_thhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H41kwndL+oz2Gcfpe3-MCagaQd2X21gK9kMO2vpw_thhA@mail.gmail.com>

On Sat, Jan 10, 2026 at 12:05:19PM +0800, Huacai Chen wrote:
> So I think we need a softdep between ohci-platform/uhci-platform and
> ehci-platform, which is similar to the PCI case.

Yes, on your platform.  But not on other platforms.  (For example, not 
on a platform that doesn't have an EHCI controller.)

I think the best way to do this is to create a new CONFIG_EHCI_SOFTDEPS 
Kconfig symbol, and add the soft dependency only if the symbol is 
defined.  Normally it will be undefined by default, but on your platform 
(and any others that need it) you can select it.

How does that sound?

> > There are other issues involving companion controllers, connected with
> > hibernation.  You should take a look at commit 6d19c009cc78 ("USB:
> > implement non-tree resume ordering constraints for PCI host
> > controllers"), which was later modified by commit 05768918b9a1 ("USB:
> > improve port transitions when EHCI starts up") and a few others.
> >
> > Also, read through the current code in hcd-pci.c (for_each_companion(),
> > ehci_pre_add(), ehci_post_add(), non_ehci_add(), ehci_remove(), and
> > ehci_wait_for_companions()).  Your non-PCI system will need to implement
> > some sort of equivalent to all these things.
> At least for the device probe, a softdep seems enough.

Does this platform support hibernation at all?

Alan Stern

