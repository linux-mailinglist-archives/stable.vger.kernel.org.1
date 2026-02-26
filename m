Return-Path: <stable+bounces-219759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E4mENnon2l7ewQAu9opvQ
	(envelope-from <stable+bounces-219759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:31:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F081A1523
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CD930467C9
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAEF330B2C;
	Thu, 26 Feb 2026 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPQR+jTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAB2DC783;
	Thu, 26 Feb 2026 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087505; cv=none; b=WzHYjPfaJvYfc3IuuyuffDITwVNf9I7UCStnpvBGdob+V0baCsC6JLCz2mcIY9xV+MnnsqjZGPcNMSvVATXSxmUZnV45yhMhajX1utaggfNJaJURWRUKQ0/2AcH+Ozs/L36HeDCQQzto/Fxfp+K09IsZ6L/L/XNWHubzemW+/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087505; c=relaxed/simple;
	bh=Rg0sp/qeKk/n/CsiBDt2E7lGex79tuAYp/erhRShyug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2xSYVdiw1cLLpeSQu8OPjSDy1cnZpzgp7o9m4rT/0h+KmElnx5Oe58n4x+GRmiYyMIcOSqN5qISPnyoaF7ojI1pux4zQR6zDfOvDHvGqFM5HzzAhtcOpI6WFZgrf9puqnq1hY9WqdLMrZ58j2L6/4P06MRlruoM1CnCvL8qCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPQR+jTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDB9C19422;
	Thu, 26 Feb 2026 06:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772087505;
	bh=Rg0sp/qeKk/n/CsiBDt2E7lGex79tuAYp/erhRShyug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPQR+jTQSJz6TSsWLbsn3O8vlUzTcBNji1CEN7eWZJQzN+4Akb7098a5E/LsDAuiQ
	 ZUU7W9o/lphLNVpypXqOdJ21HxbSOwc+r65cEPGuKytsoLEWohea+MwHvGzE+uEVJu
	 LforkieBEEmic1/nMstjnqy+uxmgzpUKgVKH6aFD1gg3i7TxbqWFIrQoEDp78ssLbO
	 EGufe8yZprk3xNmt+h//UE+CV2P0uNkTLOUxZ7jZaF1r0MvvuMz5SFAku3oCmRWa6i
	 rzuYLg2TX4SkU6PV/0zjJBvSPIh9r404NuqCqGGS01XIwxlKMekfnLnDEQe6hUDjb6
	 XNvdulBv0HTHQ==
Date: Thu, 26 Feb 2026 12:01:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: liziyao@uniontech.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, niecheng1@uniontech.com, zhanjun@uniontech.com, 
	guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, kernel@uniontech.com, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>, 
	Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v7] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Message-ID: <taoupjxwaewzvolh2n6bciji36j4dx6jtvjf7k6tt5hdt54hjw@rrgbu47umz4v>
References: <20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219759-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,xry111.site];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,live.com:email,yeah.net:email]
X-Rspamd-Queue-Id: D0F081A1523
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:22:40PM +0800, Ziyao Li via B4 Relay wrote:
> From: Ziyao Li <liziyao@uniontech.com>
> 
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
> 
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
> 
> Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
> amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
> clocks and lanes in power management. We hope this patch can prevent
> similar problems in future driver changes (similar checks may be
> implemented in other GPU, storage controller, NIC, etc. drivers).
> 
> Manually override the `supported_speeds` field for affected PCIe bridges
> with those found on the upstream bus to correctly reflect the supported
> link speeds.
> 
> This patch was originally found from AOSC OS[1].
> 
> Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
> Tested-by: Lain Fearyncess Yang <fsf@live.com>
> Tested-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> [Xi Ruoyao: Fix falling through logic and add kernel log output.]
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
> [Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
> Signed-off-by: Ziyao Li <liziyao@uniontech.com>
> Tested-by: Mingcong Bai <jeffbai@aosc.io>
> Cc: stable@vger.kernel.org

Since this is a bug fix which needs to be backported, what is the commit SHA for
the Fixes tag? The one which added Loongson-3C6000 support to this driver.

- Mani

> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> The reason of not just copying pdev->bus->self->supported_speeds is
> that we're concerned that this approach assumes the upstream port
> reports the same capabilities as bridge, which may not always be the
> case in future silicon revisions.
> 
> Our current conservative approach ensures we only enable speeds that
> are physically supported by checking the actual max_bus_speed. For
> example, if there's a future Loongson-3C9999 where the virtual bridge
> reports Gen4 support but the physical bridge only supports Gen3.
> 
> In this scenario, directly copying the upstream port's supported_speeds
> would incorrectly report Gen4 support for the downstream bridge. The
> current patch ensures we only set speed bits up to what the hardware
> actually supports, based on the measured max_bus_speed. This seems
> safer for future silicon.
> 
> Changes in v7:
> - adjust commit message
> - Link to v6: https://lore.kernel.org/r/20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com
> 
> Changes in v6:
> - adjust commit message
> - Link to v5: https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com
> 
> Changes in v5:
> - style adjust
> - Link to v4: https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com
> 
> Changes in v4:
> - rename subject
> - use 0x3c19/0x3c29 instead of 3c19/3c29
> - Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com
> 
> Changes in v3:
> - Adjust commit message
> - Make the program flow more intuitive
> - Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com
> 
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
> - Fix falling through logic and add kernel log output by Xi Ruoyao
> ---
>  drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index bc630ab8a283..a4250d7af1bf 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
>  
> +/*
> + * Older steppings of the Loongson-3C6000 series incorrectly report the
> + * supported link speeds on their PCIe bridges (device IDs 0x3c19,
> + * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
> + * from 2.5 GT/s up to 16 GT/s.
> + */
> +static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
> +{
> +	u8 old_supported_speeds = pdev->supported_speeds;
> +
> +	switch (pdev->bus->max_bus_speed) {
> +	case PCIE_SPEED_16_0GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_8_0GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_5_0GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
> +		fallthrough;
> +	case PCIE_SPEED_2_5GT:
> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
> +		break;
> +	default:
> +		pci_warn(pdev, "unexpected max bus speed");
> +
> +		return;
> +	}
> +
> +	if (pdev->supported_speeds != old_supported_speeds)
> +		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",
> +			 old_supported_speeds, pdev->supported_speeds);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
> +
>  static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>  {
>  	struct pci_config_window *cfg;
> 
> ---
> base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
> change-id: 20250822-loongson-pci1-4ded0d78f1bb
> 
> Best regards,
> -- 
> Ziyao Li <liziyao@uniontech.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

