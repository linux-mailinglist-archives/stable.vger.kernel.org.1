Return-Path: <stable+bounces-242467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFWlGgzb9GmfFQIAu9opvQ
	(envelope-from <stable+bounces-242467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:55:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B04AE38F
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43BA3024C85
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031340629B;
	Fri,  1 May 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S30PcIKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC933F9F3B;
	Fri,  1 May 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654450; cv=none; b=JE5PYQQWXemufHHyqvyZ4DdgZixGkH8DxKL/O/InM33N3LAoWlhcGfin1GZ7SCqk52xzwguzmpAC0aSeyZqa04RfeW72Bajzkv5ZCM1Ac5KBJn6HGClQpnDkBT5n7ElOTmo5eqiH05JDiGQG7QXC0lxSldKZR1KoV+p2CAjQXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654450; c=relaxed/simple;
	bh=56PrMhQcqP8AT3QF86gLf69QqCuuy3MnxUjgUbDZhUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io6sguXdJP8knqrlYnVzWHRKte+aV7WG/mC96TsQJufhoHuHEHy/0pJHiyrCH1gREltWgQoTL/gwzcJ3q+u6MoQ8X4uZQmzdaUCl2Pqj4KZQlVoj8b+JU30Z1yICz8cBUvbZNaQr+LGwfjpdScVoaprctlTXirjqvayzQ+KfRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S30PcIKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D7C2BCB4;
	Fri,  1 May 2026 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654449;
	bh=56PrMhQcqP8AT3QF86gLf69QqCuuy3MnxUjgUbDZhUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S30PcIKDMLC46S80j0J9tke22W1b6vtv5JA+GSDwguH6mC/8+wl2TxL301k90R0nn
	 eLCa5RK7N20QAqhWRi3KvLSbcfvJDznVcSScx72GsYEZ9JdKC6BTLOu0jDUb9zbKUB
	 ET/WcVdeY8vwaIAA1nUbg2Qeb3zUz1nNRwzxMhLazthoBLNQJOMCZ5dsmwtDGYiAnj
	 OtogOybJzG7XBm+n8ItMtk4Vpi0yHUo2OgQZ+8yirO+iWSffob3X7OJXgxDGazX5Sx
	 YshjnfCOEMklcTX6FSCweXxkbNXvGG3mYQSNSzMDMy4Id4g5zxprDVRIkgENSRuY3/
	 Nu/G2tayN+9Rg==
Date: Fri, 1 May 2026 22:23:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Lukas Wunner <lukas@wunner.de>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
	Inochi Amaoto <inochiama@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331175658.1015829-3-gaohan@iscas.ac.cn>
X-Rspamd-Queue-Id: BA1B04AE38F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,baylibre.com,huawei.com,wunner.de,linux.intel.com,kernel.org,outlook.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmail.com,iscas.ac.cn,ziyao.cc];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 01, 2026 at 01:56:58AM +0800, Han Gao wrote:
> SG2042's PCIe root ports [1f1c:2042] fail to deliver MSI interrupts to
> downstream devices when native port services are enabled. Devices under
> an affected root port receive zero interrupts despite successful vector
> allocation, causing driver timeouts (e.g. amdgpu fence fallback timer
> expired on all rings).
> 

Have you investigated why the endpoint is not able to deliver MSIs to host when
Port services are enabled? Is it because the portdrv driver consumes all MSIs or
MSIs are masked in hw (if so why? due to hardware issue?) or something else?

Currently, the problem description is very vague.

- Mani

> Set PCI_DEV_FLAGS_NO_PORT_SERVICES on SG2042 root ports to prevent the
> port service driver from probing, restoring correct MSI delivery.
> 
> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  drivers/pci/quirks.c    | 12 ++++++++++++
>  include/linux/pci_ids.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be7..bbde482ff7cb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6380,3 +6380,15 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * SG2042's PCIe root ports do not correctly deliver MSI interrupts to
> + * downstream devices when native PCIe port services are enabled. All
> + * services including bwctrl must be disabled, equivalent to pcie_ports=compat.
> + */
> +static void quirk_sg2042_no_port_services(struct pci_dev *dev)
> +{
> +	pci_info(dev, "SG2042: disabling native PCIe port services\n");
> +	dev->dev_flags |= PCI_DEV_FLAGS_NO_PORT_SERVICES;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOPHGO, 0x2042, quirk_sg2042_no_port_services);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 406abf629be2..9663be526dd0 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2630,6 +2630,8 @@
>  
>  #define PCI_VENDOR_ID_CXL		0x1e98
>  
> +#define PCI_VENDOR_ID_SOPHGO		0x1f1c
> +
>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

