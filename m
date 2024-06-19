Return-Path: <stable+bounces-53678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B633190E20C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 05:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50543284F2F
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 03:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9141EB2C;
	Wed, 19 Jun 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwqMP2jh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761712139D3;
	Wed, 19 Jun 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718768754; cv=none; b=R63V2+o4ChNpyRIsVfhmiVswmGzL6XkcdsbGH9xBIVN2lNw2RWXjZ1731bShr42SMk9VPcP0clj3LqiQ5EZlNaFyX2v2yjO688WHO4TxhCNBjFC/KFNK2iwgDDPfJ5imJAO+CWENSr4CZRxHcXaodCrkmsf3z6PsthL137CAQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718768754; c=relaxed/simple;
	bh=QqYGHcyDPY9LWxGs+XmZSvVbr6bVLIuCDo6EWKGDoHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwVtG1MNzPxkrmu1MtjfmEqYMOXIR5BLQJB74S8kO4HAZNebsf3l3lQYrPlgJ/BfGn41BA2Cm26OMHkK34Y/YmHlrNIP60D6U7BXBWHKYHeMTn1/V7jWm3RYwlJf5UgLuU/vs7lmwst3IW8sBlyXGJbzdXzuousKgkzaLD2mcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwqMP2jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E40C2BBFC;
	Wed, 19 Jun 2024 03:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718768753;
	bh=QqYGHcyDPY9LWxGs+XmZSvVbr6bVLIuCDo6EWKGDoHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fwqMP2jhpXm+LNo5551atW6mBcgCBVrm6TuBoEBzd3mUaDx5lB1pmTYNrTLnHaiCQ
	 jlxPfifN9eRHAIwgOd4p0hw5EnQf2jupVYJNgQODdiX/q/0VU/xBXkk3/nbklZ6JH5
	 2NoQ6v0ti1eIfiAwIi117kiPqX0V3qy6EgY9qwW3rYznm4xpFYuIaOhIL5KC8BeSzB
	 UdERmRn8Xv7F/5rSQPDPO9qtdxCcNp7HvBJ0GdxILGShYkIROJ0zd1XaErxPrsFB5B
	 lLvAkxauEVYZUrJhr2dSXFcPqX+C42B/IVp5N+WRTT2SLgQTv9qWy+1M2dCo+Fqn2U
	 xeiCs2Gn4HKGg==
Message-ID: <4522f403-8419-4c59-b28b-9d460780c389@kernel.org>
Date: Wed, 19 Jun 2024 12:45:51 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Do not enable LPM if no LPM states are
 supported by the HBA
To: Niklas Cassel <cassel@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org
References: <20240618152828.2686771-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240618152828.2686771-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 00:28, Niklas Cassel wrote:
> LPM consists of HIPM (host initiated power management) and DIPM
> (device initiated power management).
> 
> ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
> supports it.
> 
> However, DIPM will be enabled as long as the device supports it.
> The HBA will later reject the device's request to enter a power state
> that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
> initiated by the device).
> 
> For a HBA that doesn't support any LPM states, simply don't set a LPM
> policy such that all the HIPM/DIPM probing/enabling will be skipped.
> 
> Not enabling HIPM or DIPM in the first place is safer than relying on
> the device following the AHCI specification and respecting the NAK.
> (There are comments in the code that some devices misbehave when
> receiving a NAK.)
> 
> Performing this check in ahci_update_initial_lpm_policy() also has the
> advantage that a HBA that doesn't support any LPM states will take the
> exact same code paths as a port that is external/hot plug capable.
> 
> Side note: the port in ata_port_dbg() has not been given a unique id yet,
> but this is not overly important as the debug print is disabled unless
> explicitly enabled using dynamic debug. A follow-up series will make sure
> that the unique id assignment will be done earlier. For now, the important
> thing is that the function returns before setting the LPM policy.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1: Add debug print as suggested by Mika.
> 
>  drivers/ata/ahci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 07d66d2c5f0d..5eb38fbbbecd 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1735,6 +1735,14 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  	if (ap->pflags & ATA_PFLAG_EXTERNAL)
>  		return;
>  
> +	/* If no LPM states are supported by the HBA, do not bother with LPM */
> +	if ((ap->host->flags & ATA_HOST_NO_PART) &&
> +	    (ap->host->flags & ATA_HOST_NO_SSC) &&
> +	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {

Nit: Maybe:

#define ATA_HOST_NO_LPM		\
	(ATA_HOST_NO_PART | ATA_HOST_NO_SSC | ATA_HOST_NO_DEVSLP)

and then the if becomes:

	if ((ap->host->flags & ATA_HOST_NO_LPM) == ATA_HOST_NO_LPM) {

But no strong feelings about it. So:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
> +		return;
> +	}
> +
>  	/* user modified policy via module param */
>  	if (mobile_lpm_policy != -1) {
>  		policy = mobile_lpm_policy;

-- 
Damien Le Moal
Western Digital Research


