Return-Path: <stable+bounces-91914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813B9C1A48
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC08CB21832
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF461E2853;
	Fri,  8 Nov 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y44aBSah"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692571E2603
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060878; cv=none; b=tR3XlmzDAPMNQWQcXaTfT5Fth5ZVQFoOAy2FIyrWXFuv+RMeoEp7UNaQDVmVOvq5pPMct/s7RE36Eu5GA4SVccItsLC3K/o0X6mJOqB0IQnVvlJ5zke3oHqRGQ6kQJIDUT3OO2moEsyfTrKF/45Q7whDP26oNKWlRA11MrT2ahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060878; c=relaxed/simple;
	bh=XkGgv5eX9hGP/+6vsdILQJodcuwb2z/IVmUjUdqJ/2g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDo2hTLtPOTVTF7jQxCkA4Re0d3N9WS5zZrBOTp6SQyFVAL9lGrqxz0QbTDf0cJLv25dLiJPUGpsSNAvQQ0GlrlR//gFDLJ/QtWNl/CiXUE/FYpIa6FynoUSCIEj54h0EHAcBF9pY80N80I4Ik0lHM9OR+Oj8R/F6a6RRQkGATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y44aBSah; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a99e3b3a411so517162666b.0
        for <stable@vger.kernel.org>; Fri, 08 Nov 2024 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731060873; x=1731665673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SnVZ0emV6bVkYUAc532QwJ4he0bCKDKGP+zZEkPy81k=;
        b=Y44aBSahMuLEW64kUDU8e5oWPxHX1p3+jAw2IQ+FDwJah7gKRz1KHXo5GAwFdlxy38
         ejBhlWG2pwG3x/RFPbF+gHpv3heebEVwAG1jqgJzUP7Vi3IDeP+zqc1xwtn3jO/+WkNG
         5lfE9hyQUoAwSgaCY/Eq5oB0FD5uDyCARVECCzN/zovWJAVed5P8cQ9/07gZxrqfmt7y
         HbRTXNZNfbPg9BzfuqxCkuFFEYP85FJbRTe9g1xblZnEQ8ZMv5U7CsLRLYKyWdZZzPUw
         QZYjNdeGhnBTwsgxJjs6FM879C+80DX6VT8jDLS1rxnZgdjLgGqF/kBB/hkEUzJ0t2j1
         nRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060873; x=1731665673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnVZ0emV6bVkYUAc532QwJ4he0bCKDKGP+zZEkPy81k=;
        b=nZR632/rZsEDMzrUcZ1jw7ojYD0u2j2tWkzPELCZPnWJDYTkZ460IS8PJqzpJpaAue
         nhKqKqBgwRVAHhWHOLyYPBDZB4fH87a6ib5Ax4v71+b9ks/sVI3dhbbVZg2ttePwJm2D
         +4J3H4evboP6nDoxCRCrYJ42Bgy7u8sOMs+h6oVnNXXHCK1C4z7FG7cdoYWN80ywKqeA
         /SMIdu26ciwKHlABb/Ikwg8DCYOc8vCdp1R8do8QLm1cgRYrjOMWb+hqRvSrtAsf/nHx
         e4MDxtZsHPBvGDQO2D9NjNarmr/VUrvB3MLF8tHSXluaWPw763+TgRl7jKwjwTe4iXn+
         bFpw==
X-Forwarded-Encrypted: i=1; AJvYcCVnTtAbWlwpx9oadjAI4+95u7s3cZTKil4HIUOv6jdd71PWRpD342BmDi41nDqSeMyhSnuEEHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNl/NyeyoRy0cKDgD/Vf4VsO3PwJxrF9aK/kbhFy+gvDPtEeqi
	ZE+P/Ju6sh3cAAyLSuF2TjHUPvuyJldavFSlPLA09lPzIEMbH4kKg6Vorq0dfDY=
X-Google-Smtp-Source: AGHT+IGMkZNj149mgtvYpa+dcdi+Hv2GUHkHisgCOmyCoj4UxPuG3y0YVKFRG6NnyfhzAQT2cBQMhA==
X-Received: by 2002:a17:907:9455:b0:a9a:b818:521d with SMTP id a640c23a62f3a-a9eec9cf03dmr279872866b.18.1731060872701;
        Fri, 08 Nov 2024 02:14:32 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4c7asm210184166b.96.2024.11.08.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:14:32 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 8 Nov 2024 11:14:59 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: of_property: Assign PCI instead of CPU bus address
 to dynamic PCI nodes
Message-ID: <Zy3koxz4KnV39__V@apocalypse>
References: <20241108094256.28933-1-andrea.porta@suse.com>
 <20241108110938.622014f5@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108110938.622014f5@bootlin.com>

Hi herve,

On 11:09 Fri 08 Nov     , Herve Codina wrote:
> Hi Andrea,
> 
> On Fri,  8 Nov 2024 10:42:56 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > When populating "ranges" property for a PCI bridge or endpoint,
> > of_pci_prop_ranges() incorrectly use the CPU bus address of the resource.
> > In such PCI nodes, the window should instead be in PCI address space. Call
> > pci_bus_address() on the resource in order to obtain the PCI bus
> > address.
> > 
> > Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> > This patch, originally preparatory for a bigger patchset (see [1]), has
> > been splitted in a standalone one for better management and because it
> > contains a bugfix which is probably of interest to stable branch.
> 
> Nothing to say for the patch itself.
> 
> Just here, you mentioned "see [1]" but you didn't provide the link.
> 
> IMHO, this is not blocking for applying the patch but, just for other people
> looking at this email in the mailing list, can you reply providing the link?

Thanks for pointing that out, sorry about that. Here it is:

[1] - https://lore.kernel.org/all/f6b445b764312fd8ab96745fe4e97fb22f91ae4c.1730123575.git.andrea.porta@suse.com/

Many thanks,
Andrea

> 
> Best regards,
> Hervé

