Return-Path: <stable+bounces-213260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAB0O5oJgmmCOQMAu9opvQ
	(envelope-from <stable+bounces-213260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:43:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2CDDABF5
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09284306E83E
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581D3AA1AE;
	Tue,  3 Feb 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hewQJ+Hc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1C3AA1A5;
	Tue,  3 Feb 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129585; cv=none; b=RgIjN55SEUpYz8wD3FiMvMIqDWzQXVJUojNNXj/ZOL/gri3XtIecqQWjbXuTv14w9RSCFS5CSKzMa2DLPWHXxD5nCLUR3O3rEjh6JJItkPWJ+cjmN2xICJ5uwkO22d/4068w7VAHRpXN77F4TgYN8DwuyD0WUoo2RZB3laQI1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129585; c=relaxed/simple;
	bh=Semr3uEiGiShmGO9CVwC5NBZLb/lp/IEe9ZwonDXKV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5kPwUvleCYcsbTIQQEtrKu441mOQW1tkqOX7YXCy8YrqnZNFDIbCWeg5n8vuRNPauvKuOv2nyv3TTaiWwGBq2tE+o8pn7ysJpw/N2DgJSboAGd2eQFkXrceQ4rk0gGURzJlBYIDmNiKTLy86oNwSHIY02+OnzXcehhuPCy0Mlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hewQJ+Hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C2C116D0;
	Tue,  3 Feb 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770129584;
	bh=Semr3uEiGiShmGO9CVwC5NBZLb/lp/IEe9ZwonDXKV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hewQJ+HcFEDt62zCsKCXEJGHf0fhtySxgM1IZBexQADTeQLHm3VZnnUnVSOQie7rY
	 dSoCemA98AiLqJxrclFF366infkmIPJ4qLuwT688Ad/EFJYJU4IGY1amFCkNZeWicR
	 dSrv4+FqotGTvK13kV46udZlNLyVUzfFj/ocWHyw=
Date: Tue, 3 Feb 2026 15:39:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6.18.8] Revert "drm/amd: Check if ASPM is enabled from
 PCIe subsystem"
Message-ID: <2026020334-vividly-cognitive-e0b6@gregkh>
References: <20260201002508.1293510-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201002508.1293510-1-spasswolf@web.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213260-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4A2CDDABF5
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 01:25:06AM +0100, Bert Karwatzki wrote:
> This reverts commit 7294863a6f01248d72b61d38478978d638641bee.
> 
> This commit was erroneously applied again after commit 0ab5d711ec74 
> ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
> removed it, leading to very hard to debug crashes, when used with a system with two
> AMD GPUs of which only one supports ASPM.
> 
> Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@web.de/
> Link: https://github.com/acpica/acpica/issues/1060
> Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7333e19291cf..ec9516d6ae97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2334,9 +2334,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			return -ENODEV;
>  	}
>  
> -	if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> -		amdgpu_aspm = 0;
> -
>  	if (amdgpu_virtual_display ||
>  	    amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
>  		supports_atomic = true;
> -- 
> 2.47.3
> 
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

