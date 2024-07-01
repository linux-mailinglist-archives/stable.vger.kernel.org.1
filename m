Return-Path: <stable+bounces-56278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B3291EA00
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5531C21229
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA3171651;
	Mon,  1 Jul 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJQhR4Ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3A381C4;
	Mon,  1 Jul 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868355; cv=none; b=jZg1C0Jke/AvEWw3ys4HgQZ+fKPC1TTWgwRQrGRduvcsr00yKqc2p43Y/Itf1wZiVPR05VV7QggEAoIOxY5BtuNXPRZ1z8k5y3A9lSLlmRZmAoYO+40v2aKtQKsvWoudRaBftYCWjv9B9yeI9hvneeYdgXf0ic+rFgHySmMeZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868355; c=relaxed/simple;
	bh=Shdabns7UjGsGuuq/Qq+fiXoDzt60pi2ZVDdlrUlCgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McMXj803/QgrlgvoS+Rw51cp40Z5vOP05kTlc/cm45NGIhkzAP2AKVwqQeRM7xo83iPGhNee2gWTR4WQIueegq6Dc4yTuUUR9KMiX+jBReQEK+pcKC6VlQnhb47Jdd/4Vj2nI3lcLE/FVutR9VW8VjO/HtBszVR3lHSMBDay6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJQhR4Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8505EC116B1;
	Mon,  1 Jul 2024 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868355;
	bh=Shdabns7UjGsGuuq/Qq+fiXoDzt60pi2ZVDdlrUlCgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJQhR4YaujpBrueoSHJ9nuj8qsGxnfrluhXHEo9hqV5wvi77yaUuzQ1elJ7V7jS+x
	 B17v07wxplY2om4Es7wYgdAojXctP+7WD65izmYrofgb8b0H1DrM+smI8jeRVfh4Xu
	 RfC//HG3dS7kOho7I9GKECbPuYrKtjZH+RdM+W0ivX6oMShGDPqr7Vtza/XzzGDCjz
	 MZrs12VBx2GEEBxgxgJoY70w/SMDYpz6zGusgjMoyF4FUI/8kg8MXmMCEq2awCcCVj
	 YT3T6hMcxGfYb3OLEVIhkQ6LYV9leewTy4Ag6+nqXktc0uTg4Y1GJVUZTimElFjx7P
	 98w3XyEQPa0ow==
Date: Mon, 1 Jul 2024 23:12:30 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 3/8] ata: libata-scsi: Honour the D_SENSE bit for
 CK_COND=1 and no error
Message-ID: <ZoMbviAryO5WdaJZ@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-4-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701195758.1045917-4-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:53PM +0000, Igor Pylypiv wrote:
> SAT-5 revision 8 specification removed the text about the ANSI INCITS
> 431-2007 compliance which was requiring SCSI/ATA Translation (SAT) to
> return descriptor format sense data for the ATA PASS-THROUGH commands
> regardless of the setting of the D_SENSE bit.
> 
> Let's honour the D_SENSE bit for CK_COND=1 commands that had no error.
> Kernel already honours the D_SENSE bit when creating the sense buffer
> for commands that had an error.

Nit: we also honor it when creating the sense buffer for successful NCQ
commands (e.g. CDL policy 0xD).


> 
> SAT-5 revision 7
> ================
> 
> 12.2.2.8 Fixed format sense data
> 
> Table 212 shows the fields returned in the fixed format sense data
> (see SPC-5) for ATA PASS-THROUGH commands. SATLs compliant with ANSI
> INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor format
> sense data for the ATA PASS-THROUGH commands regardless of the setting
> of the D_SENSE bit.
> 
> SAT-5 revision 8
> ================
> 
> 12.2.2.8 Fixed format sense data
> 
> Table 211 shows the fields returned in the fixed format sense data
> (see SPC-5) for ATA PASS-THROUGH commands.
> 
> Cc: stable@vger.kernel.org # 4.19+
> Reported-by: Niklas Cassel <cassel@kernel.org>
> Closes: https://lore.kernel.org/linux-ide/Zn1WUhmLglM4iais@ryzen.lan
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 26b1263f5c7c..ace6b009e7ff 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -941,11 +941,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  				   &sense_key, &asc, &ascq);
>  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
>  	} else {
> -		/*
> -		 * ATA PASS-THROUGH INFORMATION AVAILABLE
> -		 * Always in descriptor format sense.
> -		 */
> -		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> +		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
> +		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
>  	}
>  }
>  
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

With or without nit fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

