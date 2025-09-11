Return-Path: <stable+bounces-179298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E79FB53A95
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058881885AB5
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8A362079;
	Thu, 11 Sep 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3ftaxQ0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5D31B131
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612686; cv=none; b=rcyEKdTPY+1ygfQ/WYMBUxav8ALmDypRm4e1K5qPWBgjdWmnZlDKjj/MdCAtwcIFZbj5xWMzlu6V6tDWWWXNxhiThPa1eCcaOYx6Al+Tf3X9K8Es7tL1IXZ+Y9VYs5T6nAYhw3YvOGoYVfRZmV+I6YbbmVoulKMJ0xCkUrHTcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612686; c=relaxed/simple;
	bh=pbhMO13ZY5GqoqdYOtMMsHmtwMybBAHzcr1+lrCzXbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1mCqGqJ9amCIMV9Z1VAub6ewQwSdBMGbe91KP/hMTRV7YmdTVV9PgdzwbvObBBoGYwb4AWWng2xX8UMfw+ljYodRWJI1634JJO0TYOYxhJ++KTN4wRxRHR+oBSo3sskm+Ycw0CdqRyuyIDjqhivdIwoJs4jc0oO0bdQCzMsvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3ftaxQ0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-25c5e597cfcso8390565ad.1
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757612684; x=1758217484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz1KF1fng6KUijdJHOF61HINUn1DY6RMLW+n7igx57A=;
        b=o3ftaxQ0jcC/wXlHi54vgazVyRwwr4iH8pciBU2bbKJ8AWB9qy3pz4ScKLBtPGF5Xj
         Yvg5pjGAe9epKi7NHbumSBNwqXihUdBSyP4C5UcgI/nKXNafEoYbLGCM87KVbI69Rgui
         uKuiA5fjoow53xNIMCzDrz3Eznwdmsi0C0KZvL4qggBXSVoT6ixtK4l5OV1ULS6GwWEl
         gndOtRw+S3/qU4qKbuqezI2gba/56KPTmsR8QCS0P7tsVEs+oj3IVheafqylgfMb+Jpj
         5TjVk/H6Q37uE7KYm9BnTVgEGlcBFCC6h49fiNHM7GYRrP/2bi4Z4g9VkXO0H9E87vOM
         BoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757612684; x=1758217484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz1KF1fng6KUijdJHOF61HINUn1DY6RMLW+n7igx57A=;
        b=LWOx3gPD83gjjGSuyPgpY7AZwyekPlVWXFER92wdzaO2JKSf3mqkSodtGRpjLn/faC
         6PPraHaftv+NcBZpOlEGp+uJZNQbGaunQo9rx/zdNRdqZQMmMpQH/wqgxIDHNqgA6cPG
         l+rYUbTjwPcfXmlX13Dnk0yg/B4K5bGB3uUQSPKVeP1r8x3+Ywvt8vyS0jqA54+pWvQJ
         0QL7BBId5Z+A3yUcEdb9TW5uc4kvNabWMJF+iTlgRPGVT26ExazJZZQVgNjbYNPKnQwm
         Nzj4EIFceRTUmJ2lgS19vo+qEKAif0ejR5BDsj+fbwTzArOkOivnQdlDkbV41FGgohsv
         vBMg==
X-Forwarded-Encrypted: i=1; AJvYcCUV8mUvj5hHeVT5zi7jYvBbv87GLB47X1lqvOS12+E7YthK1v7d4uvFs5sVcHgHYgLt0dVGTx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTpCOcFx1h019F5g0n/Y0EmpkWQlgNPr/bT0VQkiPaC5L46HY
	pbJMmtP3Gv9yJXMOyaxn09RNbVFgIw+dQ0pLeFhviVdv72eLEFeDS5jDtrEvn8w+p65J/N8/u3k
	gfkkyN5vT6SGxeWjT5vpyugenQ+CwBcmuWur62MY2OA==
X-Gm-Gg: ASbGncvrrbpkXEaOW0HrQfkOh2rMYsRJO6VxkB1UNB7lhqLE9Swshwry8jrLZWBPTeS
	xuGoNeHCvMoCNJVFI21PzQje6OIt9sRsKxVRb/UT7eb6eOuxdZOqTBJBVHMvE+JesBziZRWccRS
	KCAxytCHGsVvoT0pyyrxk2wMcNdFIh3AQODU9KBzp+IWiZ4lZsLWmgtzP8BmDWFxMGrPd50eYEk
	ppX8Q9bRu0r/cWxb+9zn3nR7+4OKobElwfsmXe39U9bAALh1LpCj3jq5X+yjrYOrHEhKBM=
X-Google-Smtp-Source: AGHT+IHKvaF18ohXsPsL72THHHDkwdYvNLb3qlPEho/vRrC5yGFzk7JsCnpNSS1pajW0C+okn9T5G60r8QGqr7wiZ+k=
X-Received: by 2002:a17:903:41ca:b0:24c:e6a6:9e59 with SMTP id
 d9443c01a7336-25d245dd6f8mr3157985ad.6.1757612684132; Thu, 11 Sep 2025
 10:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
In-Reply-To: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Sep 2025 23:14:32 +0530
X-Gm-Features: AS18NWC_m5FW6D-agm1h0PvPSN-t5mnK-nNZJhLfFxbja72xJDHUDp2R2a5Rjwc
Message-ID: <CA+G9fYv_h22MCs380DwW+G5_M=H-GdFvGGo4vq_-gARL8trCOQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT platforms
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
	Anders Roxell <anders.roxell@linaro.org>, Pavankumar Kondeti <quic_pkondeti@quicinc.com>, 
	Xingang Wang <wangxingang5@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	stable@vger.kernel.org, lkft-triage@lists.linaro.org, LKFT <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 23:09, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> Hi,
>
> This series fixes the long standing issue with ACS in DT platforms. There are
> two fixes in this series, both fixing independent issues on their own, but both
> are needed to properly enable ACS on DT platforms (well, patch 1 is only needed
> for Juno board, but that was a blocker for patch 2, more below...).
>
> Issue(s) background
> ===================
>
> Back in 2024, Xingang Wang first noted a failure in attaching the HiSilicon SEC
> device to QEMU ARM64 pci-root-port device [1]. He then tracked down the issue to
> ACS not being enabled for the QEMU Root Port device and he proposed a patch to
> fix it [2].
>
> Once the patch got applied, people reported PCIe issues with linux-next on the
> ARM Juno Development boards, where they saw failure in enumerating the endpoint
> devices [3][4]. So soon, the patch got dropped, but the actual issue with the
> ARM Juno boards was left behind.
>
> Fast forward to 2024, Pavan resubmitted the same fix [5] for his own usecase,
> hoping that someone in the community would fix the issue with ARM Juno boards.
> But the patch was rightly rejected, as a patch that was known to cause issues
> should not be merged to the kernel. But again, no one investigated the Juno
> issue and it was left behind again.
>
> Now it ended up in my plate and I managed to track down the issue with the help
> of Naresh who got access to the Juno boards in LKFT. The Juno issue is with the
> PCIe switch from Microsemi/IDT, which triggers ACS Source Validation error on
> Completions received for the Configuration Read Request from a device connected
> to the downstream port that has not yet captured the PCIe bus number. As per the
> PCIe spec r6.0 sec 2.2.6.2, "Functions must capture the Bus and Device Numbers
> supplied with all Type 0 Configuration Write Requests completed by the Function
> and supply these numbers in the Bus and Device Number fields of the Requester ID
> for all Requests". So during the first Configuration Read Request issued by the
> switch downstream port during enumeration (for reading Vendor ID), Bus and
> Device numbers will be unknown to the device. So it responds to the Read Request
> with Completion having Bus and Device number as 0. The switch interprets the
> Completion as an ACS Source Validation error and drops the completion, leading
> to the failure in detecting the endpoint device. Though the PCIe spec r6.0, sec
> 6.12.1.1, states that "Completions are never affected by ACS Source Validation".
> This behavior is in violation of the spec.
>
> This issue was already found and addressed with a quirk for a different device
> from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> Source Validation erratum")'. Apparently, this issue seems to be documented in
> the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
>
> Solution for Juno issue
> =======================
>
> To fix this issue, I've extended the quirk to the Device ID of the switch
> found in Juno R2 boards. I believe the same switch is also present in Juno R1
> board as well.
>
> With Patch 1, the Juno R2 boards can now detect the endpoints even with ACS
> enabled for the Switch downstream ports. Finally, I added patch 2 that properly
> enables ACS for all the PCI devices on DT platforms.
>
> It should be noted that even without patch 2 which enables ACS for the Root
> Port, the Juno boards were failing since 'commit, bcb81ac6ae3c ("iommu: Get
> DT/ACPI parsing into the proper probe path")' as reported in LKFT [6]. I
> believe, this commit made sure pci_request_acs() gets called before the
> enumeration of the switch downstream ports. The LKFT team ended up disabling
> ACS using cmdline param 'pci=config_acs=000000@pci:0:0'. So I added the above
> mentioned commit as a Fixes tag for patch 1.
>
> Also, to mitigate this issue, one could enumerate all the PCIe devices in
> bootloader without enabling ACS (as also noted by Robin in the LKFT thread).
> This will make sure that the endpoint device has a valid bus number when it
> responds to the first Configuration Read Request from the switch downstream
> port. So the ACS Source Validation error doesn't get triggered.
>
> Solution for ACS issue
> ======================
>
> To fix this issue, I've kept the patch from Xingang as is (with rewording of the
> patch subject/description). This patch moves the pci_request_acs() call to
> devm_of_pci_bridge_init(), which gets called during the host bridge
> registration. This makes sure that the 'pci_acs_enable' flag set by
> pci_request_acs() is getting set before the enumeration of the Root Port device.
> So now, ACS will be enabled for all ACS capable devices of DT platforms.

I have applied this patch series on top of Linux next-20250910 and
next-20250911 tags and tested.

>
> [1] https://lore.kernel.org/all/038397a6-57e2-b6fc-6e1c-7c03b7be9d96@huawei.com
> [2] https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com
> [3] https://lore.kernel.org/all/01314d70-41e6-70f9-e496-84091948701a@samsung.com
> [4] https://lore.kernel.org/all/CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com
> [5] https://lore.kernel.org/linux-pci/20241107-pci_acs_fix-v1-1-185a2462a571@quicinc.com
> [6] https://lists.linaro.org/archives/list/lkft-triage@lists.linaro.org/message/CBYO7V3C5TGYPKCMWEMNFFMRYALCUDTK
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
> Manivannan Sadhasivam (1):
>       PCI: Extend pci_idt_bus_quirk() for IDT switch with Device ID 0x8090
>
> Xingang Wang (1):
>       iommu/of: Call pci_request_acs() before enumerating the Root Port device
>
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  drivers/pci/probe.c      | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250910-pci-acs-cb4fa3983a2c
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
>

--
Linaro LKFT

