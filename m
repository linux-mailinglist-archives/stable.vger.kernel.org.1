Return-Path: <stable+bounces-114396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498BA2D719
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1877A3091
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E192500CE;
	Sat,  8 Feb 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANsFnXT6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DD248171;
	Sat,  8 Feb 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739030173; cv=none; b=sFELtoCv6qE+Hn+ij6YPFe8NOaWbKpiYdFB1Xo7pECaIGmYmRjnqJVYIhw45iGqpNTDJAbZadMsd4KRBsHhNx3n+VNiVBDHFYVNyFMYUT7RKNb8/Dk+wY9tpl1AB2rWoY3L7hjLrDOxCcEt6Z4u+mYXGGemSstYMfYMiRyY8pIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739030173; c=relaxed/simple;
	bh=BRk7BBm7oSdWplPPvfzhGPnNM6vM2mjwIOaR+mXLbRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UEQdgqBm52oufTXuuG9ld3fPkABR8rWtgitts8mH1OUgQ9FWvjRGCsuckVlzyhnHR/Vu3zMkkHrs3Ki23RnP6TUZZFPAUa6kiTAevWKLE1lWU4wBAshF6WXhRZDdkBwgxca+Mz+kITrZoY9d7Hen+D/gpW9rmKi5totQOb670ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANsFnXT6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so29426865e9.1;
        Sat, 08 Feb 2025 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739030170; x=1739634970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gghYPUNRCdyG2yLo4ZGDDboCtEVr9fYIBuiGTMEQtB8=;
        b=ANsFnXT6HjfphsLvjZI/EFQ0a3Z9hVKd2nPpoqURwz3pcQ+Q9ZNM0ujyWSlfzPNeql
         C2gGMsDYA6OZrMpqMX9yNsFoMNSrcVNh2Eutt7R0XQ9Z1yhWviE21gY6mCV0D23f/TU+
         jijhu10nd3ibtr6JimhQFOQFDewALVLQ7mq/RpB2pKtnOWSG/jc9KCbmB4rJNPaaCMex
         09KDPr6mrxoeTXEfS8fEskDJTw369l5z8QA/OLmXuYMYIeluYEZ/AnKOSVwNd8g4p5oG
         il6tSWkfcvRcYEiSxWGGMuHvTfJqoExHg7z7xjgDok3hpJvJDFxxSs31pjjvl7iRS/XG
         hcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739030170; x=1739634970;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gghYPUNRCdyG2yLo4ZGDDboCtEVr9fYIBuiGTMEQtB8=;
        b=GYUkvDnJp9A+q3gvk6rfzf0kaS4AGElhptgw3q43Wy78zPJu3sTuRTvLxtIb6nB+ie
         6fI3cT7A+RcNTrjGwT16GAdBfgdl3ooMVthd3cri5AQMLwDEZ07Nk/+GxyNidUY7DqrQ
         CkFs0/ygemyuI06uAKhGqPf21WTp9ArNnykn2RixyhmLSiCNplr65H6Wno02KowwQm9W
         W31E9dSZcO0DBe3YmiUwm6xRiApPMdON+DWrLvSn6jj/Ohzb83nGJSGoEj0WHKJKb0xe
         XHm246Zv/pvvGOIlgWrLHOyGK/3a9kA6uZFd1ElUjH1OiCAYJCaS9cIHAc6InelOWaTT
         vxOw==
X-Forwarded-Encrypted: i=1; AJvYcCU//KWqGZ5382xnDQq2sI3gm1L1PQkZVmOBSl8tb6hMpeWq9cummm4VLfNdPUOQah2rwu4G5aLy@vger.kernel.org, AJvYcCXg9GQhKsvxsgBrjiSqBr7GEs2ObwWnlX0DCdzA/DlTv600UfWODTdcTn1K5DIby2LyH+NyeaSByejzvxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c/lo3avrk7z/G2FuLQODq6mSpgekPsa0LQ79/eR0Qs+7U5A/
	o7d4tFf8UoZElm2+n0PFXA8XFEws7jo2ZmAOSWkll7X74RzRrrEWWdoh0M6E
X-Gm-Gg: ASbGncvlnecyebuH8hotNEITK1Ye9KhrqHzp5jaSRpPmzkluW9PlZt3DupU/FYVvIs+
	fzYeaeqojsJcqUqOE4Nt4uuQY/NiYKBAEP8K/rE0/dfVE6gALV8EbN0pzLl/476buaaqwGGfCLM
	NMX+T/XlY4glgZh4/niTKulXr9BOl3U6hncfbL3g9Neh4WaRN19GlWFrkN+m5FzXwYhmnPgWyVH
	MEcAvthZcZp3/u/jiF91PfRmWX8lf63hWYwH0IxKEyQ2quCyO6rhkDLs1DwyPspWS/xSeq73IFg
	6A639xUBjy8YVw3HuYMdmbFndbED6l5zWIvOx8DrmkQn0Ox/
X-Google-Smtp-Source: AGHT+IEXT4VHtoN7BWCb9b46QkhkIIkudo6GwKbhv3dYWDQ39vj5aKhwilizZwe5JyZGlUhGnb2oMA==
X-Received: by 2002:a7b:c001:0:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-439250df455mr58897315e9.29.1739030169469;
        Sat, 08 Feb 2025 07:56:09 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dcae129sm88297535e9.17.2025.02.08.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 07:56:08 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 18929BE2EE7; Sat, 08 Feb 2025 16:56:07 +0100 (CET)
Date: Sat, 8 Feb 2025 16:56:07 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Radoslav =?iso-8859-1?Q?Bod=F3?= <radoslav.bodo@igalileo.cz>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
Message-ID: <Z6d-l2nCO1mB4_wx@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Juergen, hi all,

Radoslav Bodó reported in Debian an issue after updating our kernel
from 6.1.112 to 6.1.115. His report in full is at:

https://bugs.debian.org/1088159

He reports that after switching to 6.1.115 (and present in any of the
later 6.1.y series) booting under xen, the mptsas devices are not
anymore accessible, the boot shows:

mpt3sas version 43.100.00.00 loaded
mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (8086116 kB)
mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
mpt3sas_cm0: MSI-X vectors supported: 96
mpt3sas_cm0:  0 40 40
mpt3sas_cm0: High IOPs queues : disabled
mpt3sas0-msix0: PCI-MSI-X enabled: IRQ 447
mpt3sas0-msix1: PCI-MSI-X enabled: IRQ 448
mpt3sas0-msix2: PCI-MSI-X enabled: IRQ 449
mpt3sas0-msix3: PCI-MSI-X enabled: IRQ 450
mpt3sas0-msix4: PCI-MSI-X enabled: IRQ 451
mpt3sas0-msix5: PCI-MSI-X enabled: IRQ 452
mpt3sas0-msix6: PCI-MSI-X enabled: IRQ 453
mpt3sas0-msix7: PCI-MSI-X enabled: IRQ 454
mpt3sas0-msix8: PCI-MSI-X enabled: IRQ 455
mpt3sas0-msix9: PCI-MSI-X enabled: IRQ 456
mpt3sas0-msix10: PCI-MSI-X enabled: IRQ 457
mpt3sas0-msix11: PCI-MSI-X enabled: IRQ 458
mpt3sas0-msix12: PCI-MSI-X enabled: IRQ 459
mpt3sas0-msix13: PCI-MSI-X enabled: IRQ 460
mpt3sas0-msix14: PCI-MSI-X enabled: IRQ 461
mpt3sas0-msix15: PCI-MSI-X enabled: IRQ 462
mpt3sas0-msix16: PCI-MSI-X enabled: IRQ 463
mpt3sas0-msix17: PCI-MSI-X enabled: IRQ 464
mpt3sas0-msix18: PCI-MSI-X enabled: IRQ 465
mpt3sas0-msix19: PCI-MSI-X enabled: IRQ 466
mpt3sas0-msix20: PCI-MSI-X enabled: IRQ 467
mpt3sas0-msix21: PCI-MSI-X enabled: IRQ 468
mpt3sas0-msix22: PCI-MSI-X enabled: IRQ 469
mpt3sas0-msix23: PCI-MSI-X enabled: IRQ 470
mpt3sas0-msix24: PCI-MSI-X enabled: IRQ 471
mpt3sas0-msix25: PCI-MSI-X enabled: IRQ 472
mpt3sas0-msix26: PCI-MSI-X enabled: IRQ 473
mpt3sas0-msix27: PCI-MSI-X enabled: IRQ 474
mpt3sas0-msix28: PCI-MSI-X enabled: IRQ 475
mpt3sas0-msix29: PCI-MSI-X enabled: IRQ 476
mpt3sas0-msix30: PCI-MSI-X enabled: IRQ 477
mpt3sas0-msix31: PCI-MSI-X enabled: IRQ 478
mpt3sas0-msix32: PCI-MSI-X enabled: IRQ 479
mpt3sas0-msix33: PCI-MSI-X enabled: IRQ 480
mpt3sas0-msix34: PCI-MSI-X enabled: IRQ 481
mpt3sas0-msix35: PCI-MSI-X enabled: IRQ 482
mpt3sas0-msix36: PCI-MSI-X enabled: IRQ 483
mpt3sas0-msix37: PCI-MSI-X enabled: IRQ 484
mpt3sas0-msix38: PCI-MSI-X enabled: IRQ 485
mpt3sas0-msix39: PCI-MSI-X enabled: IRQ 486
mpt3sas_cm0: iomem(0x00000000ac400000), mapped(0x00000000d9f45f61), size(65536)
mpt3sas_cm0: ioport(0x0000000000006000), size(256)
mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
mpt3sas_cm0: scatter gather: sge_in_main_msg(1), sge_per_chain(7), sge_per_io(128), chains_per_io(19)
mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:12348/_scsih_probe()!

We were able to bissect the changes (see https://bugs.debian.org/1088159#64) down to

b1e6e80a1b42 ("xen/swiotlb: add alignment check for dma buffers")

#regzbot introduced: b1e6e80a1b42
#regzbot link: https://bugs.debian.org/1088159

reverting the commit resolves the issue.

Does that ring some bells?

In fact we have two more bugs reported with similar symptoms but not
yet confirmed they are the same, but I'm referencing them here as well
in case we are able to cross-match to root cause:

https://bugs.debian.org/1093371 (megaraid_sas didn't work anymore with
Xen)

and

https://bugs.debian.org/1087807 (Unable to boot: i40e swiotlb buffer
is full)

(but again the these are yet not confirmed to have the same root
cause).

Thanks in advance,

Regards,
Salvatore

