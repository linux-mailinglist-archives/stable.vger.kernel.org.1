Return-Path: <stable+bounces-73096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAA96C5E6
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 20:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8D21C24E86
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39D1E0B80;
	Wed,  4 Sep 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="qqQgpnx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3/Qllhn"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256161DFE2D;
	Wed,  4 Sep 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472859; cv=none; b=UmAjkjstRleJSqdkUpo147ygpZFFHPrD4jmt1GBUjF094no2/3nhVtscQfvZnAphCxNlNiLvjx2S2bDL4+YtcbvwNrdCzYo/m4ThBxLO4YI9RQ5Tcf310zBKxj6HmKpPVoIsBR5aVcBDVWzMAK4C0c9/J5wfxn3dgNXOrVPDsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472859; c=relaxed/simple;
	bh=OFxSGvAjXNZ7ytB4MYeQGtkeD+O3f4xSW3UPNBksefU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mz0Au2GoWpuiScowUHWp0ih4CGrmJ8mpZk/qfjJhyxLJYFO+Lf+ynPrbIAilxhyX6hMtUsRyLuYd1nfEo2oeW659HfuSj3FTRmUwvZAg7Zn7ENllSAN7yIK4Ss4utvGIB8rx15V8jWEoZtbaxdmNhMpLmWhQChlxcfyVISUCKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=qqQgpnx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3/Qllhn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 37449138021D;
	Wed,  4 Sep 2024 14:00:56 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Wed, 04 Sep 2024 14:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725472856;
	 x=1725559256; bh=j8W5SCKmD2R4b08np+tquZ9l2yUGtvyX0ThJStovGYA=; b=
	qqQgpnx5OYTDqNRXZuaw1y098hknUIfwEgHyKJxcLRByMeYZB3YspG0DlWZRj4+8
	2QASCOrKtJJ6C2h0TKelO+1Jz7OdSpSKAdRXfIkphFRKA7sNi3f4M2aqy0uJtCtB
	/6xQXJwrlaztkb2KXfR+5wCBK5nfSZ/nT82kSBYULSaORXWANlTnvc+op3cK/oE6
	11ouu4Rzj6Xk2ip3U/5q2xeQtvlkQIhJ1ieWLRwhf2JbLu8tI2Rnnm1Das9cSczh
	L5vKkL9Zexh404JP9Ym7zCwwBYWofQxjSxIDXv6bi2XjHeRPyFmcvPm7J1lE43cQ
	MFKfX/YWqjwWxAaH78qBaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725472856; x=
	1725559256; bh=j8W5SCKmD2R4b08np+tquZ9l2yUGtvyX0ThJStovGYA=; b=T
	3/QllhntLycXOjsBG88GsrNnVkj2At0YjRQWRF6F4Jz7WIxoc0iLz9db3N9sNywn
	mgjLYugwLWntv6wHq1ggITcWbkaqaAv2Znn0uoiGkXO1mh/NzxIM8ryLcvCoXDhy
	ZqOcitaXOvLYC2wJ5rL9Y0Zs5fuJaTO0AdBfxlkIh3kg2+r9ksqBHxm9GzjP9iHB
	mvsWWRRr6WxleAtznHYJ3H8R/unQOiWcGQGfFbP+i6YR6fNbgJZghw/DS8Jd4jWW
	xKTodoUvQm65uDF/1PUbGIhG0LeROjolZjYwMMmRuls9dOkkDNiEy+hVQ/UsuQFI
	JahD7HVrOnZs/RUNbffaA==
X-ME-Sender: <xms:V6DYZpCB7yQyuqUNho4T5rIlN7h-6d59W2CX_hPVeAIN1_DY4e8XxQ>
    <xme:V6DYZnimF4EiyVElbPFZerQk9h1N3u5dYX1a2Eal3yVyQiz5gRjr24C2yrxg_pIAk
    saKH6aCuDWMcxJwWIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepleeutdfgueejheev
    fffgvdfgtdelkefgteeukeejhefgfeeigeevueeileekffehnecuffhomhgrihhnpehfrh
    gvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    dpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhho
    rhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrg
    hrmhdrtghomhdprhgtphhtthhopehjrghnihdrshgrrghrihhnvghnsehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrgholhhurdhluhes
    lhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehiohhmmhhusehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:V6DYZkkJorRd6dWTqyBOAq0ZEF41RINmvjD0mGXgOWB9ilH-YYG0ZA>
    <xmx:V6DYZjz2hJ_Lqq_QpQeVv-RT5cV7j0Nczz1hRdTsU9ZljuzBXaIslQ>
    <xmx:V6DYZuSDaqSVkEdr0ZSCgITEnvwrPP6r3oa09C4g8cDhXHId52KE6w>
    <xmx:V6DYZmac74LpCaxqsl7XCI8WJbrMGbhOEwjQMySWio5VyjK46jjx6A>
    <xmx:WKDYZhHW-e0egGswZQfGQQ7IHEyZAHAidoVjXoXVf-FAG5QSEmZi1dZa>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7CD053C0066; Wed,  4 Sep 2024 14:00:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 14:00:35 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Kevin Tian" <kevin.tian@intel.com>
Cc: jani.saarinen@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <0dc9ac00-1148-4c64-8c12-4d08a2a27429@app.fastmail.com>
In-Reply-To: <20240904060705.90452-1-baolu.lu@linux.intel.com>
References: <20240904060705.90452-1-baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices requiring ATS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Lu,

Tested this on an X1 Carbon G12 with a kernel built form drm-tip and this patch - and was able to boot successfully with pci=noats

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

PS - note on small typo below.

On Wed, Sep 4, 2024, at 2:07 AM, Lu Baolu wrote:
> SOC-integrated devices on some platforms require their PCI ATS enabled
> for operation when the IOMMU is in scalable mode. Those devices are
> reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
> field.
>
> The PCI subsystem offers the 'pci=noats' kernel command to disable PCI
> ATS on all devices. Using 'pci=noat' with devices that require PCI ATS

pci=noats

> can cause a conflict, leading to boot failure, especially if the device
> is a graphics device.
>
> To prevent this issue, check PCI ATS support before enumerating the IOMMU
> devices. If any device requires PCI ATS, but PCI ATS is disabled by
> 'pci=noats', switch the IOMMU to operate in legacy mode to ensure
> successful booting.
>
> Fixes: 97f2f2c5317f ("iommu/vt-d: Enable ATS for the devices in SATC table")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12036
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4aa070cf56e7..8f275e046e91 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3127,10 +3127,26 @@ int dmar_iommu_notify_scope_dev(struct 
> dmar_pci_notify_info *info)
>  					(void *)satc + satc->header.length,
>  					satc->segment, satcu->devices,
>  					satcu->devices_cnt);
> -			if (ret > 0)
> -				break;
> -			else if (ret < 0)
> +			if (ret < 0)
>  				return ret;
> +
> +			if (ret > 0) {
> +				/*
> +				 * The device requires PCI/ATS when the IOMMU
> +				 * works in the scalable mode. If PCI/ATS is
> +				 * disabled using the pci=noats kernel parameter,
> +				 * the IOMMU will default to legacy mode. Users
> +				 * are informed of this change.
> +				 */
> +				if (intel_iommu_sm && satcu->atc_required &&
> +				    !pci_ats_supported(info->dev)) {
> +					pci_warn(info->dev,
> +						 "PCI/ATS not supported, system working in IOMMU legacy mode\n");
> +					intel_iommu_sm = 0;
> +				}
> +
> +				break;
> +			}
>  		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
>  			if (dmar_remove_dev_scope(info, satc->segment,
>  					satcu->devices, satcu->devices_cnt))
> -- 
> 2.34.1

