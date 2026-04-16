Return-Path: <stable+bounces-238375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFkvIHFp4WkWtAAAu9opvQ
	(envelope-from <stable+bounces-238375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:57:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41227415689
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3E4E301BEC5
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388A38F632;
	Thu, 16 Apr 2026 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enb/HGvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413536AB47;
	Thu, 16 Apr 2026 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380267; cv=none; b=KFppTgYjo7pDaQ4js90Ot+hYHo+zuHudxDLmnyVtA45crbgiQzVktkmXQFhSuG4/d4hC8p99GG1ruwjpIrfLG/XLX9nk4wXdqMGs+4yRIESjTl/lpDURsZ8Vr2f4GzXL3v9P+k9c5WkSrbejaIebL4HjqxWEFlePyFmlocFUs/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380267; c=relaxed/simple;
	bh=INsj20KDfG23/jzsGs2wubVcaAApLPgZTwJiiSFc1Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BObSpackZN2Y2w7OaCs9UTssIJuqrB/MR4vi0QbJqhK1Q+K83xNCe95pefg9/zmxs5pjEk3k/sjX1+ab66WTcbrzDpow6h8aNYsvRce+/ljDAQu6AKoAYcTQ24e84N1lc3dmBBZJQgsGuTcDwV/KOn01BM2+hFbAhSfSs2bHtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enb/HGvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862DEC2BCAF;
	Thu, 16 Apr 2026 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776380266;
	bh=INsj20KDfG23/jzsGs2wubVcaAApLPgZTwJiiSFc1Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Enb/HGvBZ/uCmFzDSjEWKnkalJ1LFOsoHS2bHok65YiPFV11EkSIC0kRZGhttxo9+
	 01SQlzHWUWAfTRZgHBG+jIyR8EA95XKirshquCRTKM7buv8taphES0h4S7mCSu7HF5
	 lPtKL6uA3tIn6KuOyCvmf8N1Q97vWQA+nkr1Bcaqs/QDcowbPlHgm8KwBsXwDPDupJ
	 Ok0dF/2W5CRAA1VJK5a4YTs2tvuEQTWLVZjKzkBaEO0ZZN9RSEiUvv2h0INO6LyThs
	 FhqaiZt884HV7VxzyWHww2lbpqCUivbsHJ/X/jDFYX/FjlWpNgsudGdCA9GHUU7gbF
	 ByfMJitlc4fIQ==
Date: Thu, 16 Apr 2026 17:57:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marco Nenciarini <mnencia@kcore.it>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Fix out-of-bounds access in
 sriov_restore_vf_rebar_state()
Message-ID: <20260416225745.GA41850@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408163922.1740497-1-mnencia@kcore.it>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238375-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,kcore.it:email]
X-Rspamd-Queue-Id: 41227415689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[+cc Rafael, Eric, Alex, Lukas, generic pci_restore_state() question]

On Wed, Apr 08, 2026 at 06:39:22PM +0200, Marco Nenciarini wrote:
> sriov_restore_vf_rebar_state() extracts bar_idx from the VF Resizable
> BAR control register using a 3-bit field (PCI_VF_REBAR_CTRL_BAR_IDX,
> bits 0-2), which yields values in the range 0-7. This value is then
> used to index into dev->sriov->barsz[], which has PCI_SRIOV_NUM_BARS
> (6) entries.
> 
> If the PCI config space read returns garbage data (e.g. 0xffffffff when
> the device is no longer accessible on the bus), bar_idx is 7, causing
> an out-of-bounds array access. UBSAN reports this as:
> 
>   UBSAN: array-index-out-of-bounds in drivers/pci/iov.c:948:51
>   index 7 is out of range for type 'resource_size_t [6]'
> 
> This was observed on an NVIDIA RTX PRO 1000 GPU (GB207GLM) that fell
> off the PCIe bus during a failed GC6 power state exit. The subsequent
> pci_restore_state() call triggered the UBSAN splat in
> sriov_restore_vf_rebar_state() since all config space reads returned
> 0xffffffff.

I think all of pci_restore_state() is problematic for all devices, not
just this GPU.  If these config reads fail, all the previous config
writes probably failed (silently) as well.

And we have this weird retry loop in pci_restore_config_dword():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?id=v7.0#n1766,
which was originally added by
https://git.kernel.org/linus/26f41062f28d ("PCI: check for pci bar
restore completion and retry") to fix an actual problem:

  On some OEM systems, pci_restore_state() is called while FLR has not
  yet completed.  As a result, PCI BAR register restore is not
  successful.  This fix reads back the restored value and compares it
  with saved value and re-tries 10 times before giving up.

This just gives me the heebie-jeebies.  If we still need this retry
loop, it means all the previous state restoration (PCIe, LTR, ASPM,
IOV, PRI, ATS, DPC, etc.) probably failed, and we end up with a device
where the BARs got restored but none of the previous stuff.  That
sounds like a mess.

> Add a bounds check on bar_idx before using it as an array index to
> prevent the out-of-bounds access.
> 
> Fixes: 5a8f77e24a30 ("PCI/IOV: Restore VF resizable BAR state after reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marco Nenciarini <mnencia@kcore.it>
> ---
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
>  drivers/pci/iov.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 00784a60b..521f2cb64 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -946,6 +946,8 @@ static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
>  
>  		pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
>  		bar_idx = FIELD_GET(PCI_VF_REBAR_CTRL_BAR_IDX, ctrl);
> +		if (bar_idx >= PCI_SRIOV_NUM_BARS)
> +			continue;
>  		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
>  		ctrl &= ~PCI_VF_REBAR_CTRL_BAR_SIZE;
>  		ctrl |= FIELD_PREP(PCI_VF_REBAR_CTRL_BAR_SIZE, size);
> -- 
> 2.47.3
> 

