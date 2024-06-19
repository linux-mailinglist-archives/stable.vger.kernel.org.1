Return-Path: <stable+bounces-53811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417BD90E80E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD69A1F22C53
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D712FF88;
	Wed, 19 Jun 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrNv3JH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C212FB37;
	Wed, 19 Jun 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791988; cv=none; b=EjQHbnhD3xbsIRmu2aRWcSJ3EjhfYr7rxz7m0H3ugu36mKTx0YmqPqrlkzleCmy7OvFkNliMlQnjzZrIhrRE+EmQsWqhbGhvLy/tyCB5wk7U5Eg6/RJwpD5SFfM3CGkmT44e8FR8ibFbSU5kJ7u25sHKhUPViWn6KUAc7B2A8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791988; c=relaxed/simple;
	bh=NP0B7SlSGUBGAul8qyE+Revon1rkLfT8ghClH9lPF1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmGsuGaBtSUFsdyS7GI9kv/21i0fy5I+P/bI53CKuzaICZZ0iEz3LbcQ1e8QMtPedHj7ZHRRXVIZDIeS7JAnNfjDiYbnH3kFpQTuFm0KYOBYjkkF/ONUgoO6RAFvGFHFRZ/jzlkdeMCEromstmtOrqb+Vag2yZgloGJV7fKFkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrNv3JH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8B7C2BBFC;
	Wed, 19 Jun 2024 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718791988;
	bh=NP0B7SlSGUBGAul8qyE+Revon1rkLfT8ghClH9lPF1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WrNv3JH1lllExsc3t32OY99tM90JR8LS6TVTyXasgjuSKAiOakdZ1VycpBjqTvcwd
	 qjc/d/bR7WodhYycVLJhDQqUDSugEz7KfJfORm0rN6wdsEI+dk6VEWdHOTsa0M5Toc
	 JNYHAkCTGzaZs7eZy0Lu/SiRWxzeLp1sFIi7VQFtngIFtSJAT1tEs+bJdTniAcoACA
	 BoAOG84TLsqQ/r129n97i/wF3ownkpQEVjdb20IywKVS+qw+0rjUBpghwbG8f5DhYU
	 4/eKd5x3ju/vtE3khIzAGDSBXjlrS6uvYDHG+YiV7oGwlsZnT4jZ5o8ip3RKD42yJJ
	 ilqyj/Bwxx45w==
Date: Wed, 19 Jun 2024 12:13:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>, stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: ahci: Do not enable LPM if no LPM states are
 supported by the HBA
Message-ID: <ZnKvLy4_a3U6835Q@ryzen.lan>
References: <20240618152828.2686771-2-cassel@kernel.org>
 <4522f403-8419-4c59-b28b-9d460780c389@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522f403-8419-4c59-b28b-9d460780c389@kernel.org>

On Wed, Jun 19, 2024 at 12:45:51PM +0900, Damien Le Moal wrote:
> On 6/19/24 00:28, Niklas Cassel wrote:
> > LPM consists of HIPM (host initiated power management) and DIPM
> > (device initiated power management).
> > 
> > ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
> > supports it.
> > 
> > However, DIPM will be enabled as long as the device supports it.
> > The HBA will later reject the device's request to enter a power state
> > that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
> > initiated by the device).
> > 
> > For a HBA that doesn't support any LPM states, simply don't set a LPM
> > policy such that all the HIPM/DIPM probing/enabling will be skipped.
> > 
> > Not enabling HIPM or DIPM in the first place is safer than relying on
> > the device following the AHCI specification and respecting the NAK.
> > (There are comments in the code that some devices misbehave when
> > receiving a NAK.)
> > 
> > Performing this check in ahci_update_initial_lpm_policy() also has the
> > advantage that a HBA that doesn't support any LPM states will take the
> > exact same code paths as a port that is external/hot plug capable.
> > 
> > Side note: the port in ata_port_dbg() has not been given a unique id yet,
> > but this is not overly important as the debug print is disabled unless
> > explicitly enabled using dynamic debug. A follow-up series will make sure
> > that the unique id assignment will be done earlier. For now, the important
> > thing is that the function returns before setting the LPM policy.
> > 
> > Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v1: Add debug print as suggested by Mika.
> > 
> >  drivers/ata/ahci.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 07d66d2c5f0d..5eb38fbbbecd 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -1735,6 +1735,14 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
> >  	if (ap->pflags & ATA_PFLAG_EXTERNAL)
> >  		return;
> >  
> > +	/* If no LPM states are supported by the HBA, do not bother with LPM */
> > +	if ((ap->host->flags & ATA_HOST_NO_PART) &&
> > +	    (ap->host->flags & ATA_HOST_NO_SSC) &&
> > +	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
> 
> Nit: Maybe:
> 
> #define ATA_HOST_NO_LPM		\
> 	(ATA_HOST_NO_PART | ATA_HOST_NO_SSC | ATA_HOST_NO_DEVSLP)
> 
> and then the if becomes:
> 
> 	if ((ap->host->flags & ATA_HOST_NO_LPM) == ATA_HOST_NO_LPM) {
> 
> But no strong feelings about it. So:
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Thank you for the R-b and your suggestion.

Personally, I do not think that your suggestion is significantly easier to
read than what is already there (especially with the comment to give
context).

My brain always has to read a:
if ((foo & bar) == bar)
twice anyway.

I guess a:
if (!ata_host_has_lpm(ap->host))
would be clearer, but considering that we wouldn't be able to use this
helper function anywhere else in the libata subsystem, I'm not sure if
it is worth it, so I will just apply this patch as is.


Kind regards,
Niklas

