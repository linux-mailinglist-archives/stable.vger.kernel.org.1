Return-Path: <stable+bounces-67376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6423E94F6DC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC29283059
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794218C33F;
	Mon, 12 Aug 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9orHc4c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED242B9B7;
	Mon, 12 Aug 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488193; cv=none; b=TS+E3TAEIsxK846TF14AixaCYDPzPk7ROKu65ol++pdhgIRuIpbCbVbIsSKXp1wGfUSErZ93kfBbCeP3r8ooQIOURi9xlMEr2WmF2fxWk1FtnYba/9glmArTcYjnI7T86VLalQLjf4MqNqpQ+jR05wU9Ja4WFj115VglYlhUoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488193; c=relaxed/simple;
	bh=01IqLb4YuleWzezo45NbbGlQazPNWMJIZZbNyAEroNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfvEH1Y4jhLY4UzXFLmochX2OLGytLZ2R3fWfmGasRNV67mFG21Zs0Ezwr2xj5VPqLOCBIZcRr0I737wwQ5C87seLljecZr/oDyoIX26JVUekiB56DcMf8hyH299lOHuefv927+Ly/m3Mxwe6Pn4Rt7G6tAYXZyUI95Sva8ClpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9orHc4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989D5C32782;
	Mon, 12 Aug 2024 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723488192;
	bh=01IqLb4YuleWzezo45NbbGlQazPNWMJIZZbNyAEroNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9orHc4cPIEx2Y8QRPqinpnwT9zy+wv3hdZ4hp0S+3OxXf3c83WvPDaHtOYfYAI52
	 M8tqF7Fw45NnMXROpIkP2xNe4pey/cQ3CJyo6r5jGamTL8E8Y3qDuWqmEbIeEZlBTE
	 fh5bJPs9AcDboWoq71aGK2BSFC3+v+WFZQumcqz+BWo2tQyDh6tVvCp2S7+mU9MYO6
	 28ENq/cGhvsF59p97AmUZEWLinz6819U4HcKuF98oTdwCEafWFbukHAZRgrOClBUqU
	 SDPHxftPT4X5bUMn7Xq/JTRHvlYZ/+2uLMXkO3sqvw/fTFHlYVduhn1RWvGoSvLQWC
	 /fP3OjTuGZAiw==
Date: Mon, 12 Aug 2024 20:43:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Igor Pylypiv <ipylypiv@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	stable@vger.kernel.org, Stephan Eisvogel <eisvogel@seitics.de>,
	Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ata: libata-core: Return sense data in descriptor format
 by default
Message-ID: <ZrpXu_vfI-wpCFVc@ryzen.lan>
References: <20240812151517.1162241-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812151517.1162241-2-cassel@kernel.org>

On Mon, Aug 12, 2024 at 05:15:18PM +0200, Niklas Cassel wrote:
> Sense data can be in either fixed format or descriptor format.
> 
> SAT-6 revision 1, 10.4.6 Control mode page, says that if the D_SENSE bit
> is set to zero (i.e., fixed format sense data), then the SATL should
> return fixed format sense data for ATA PASS-THROUGH commands.
> 
> A lot of user space programs incorrectly assume that the sense data is in
> descriptor format, without checking the RESPONSE CODE field of the
> returned sense data (to see which format the sense data is in).
> 
> The libata SATL has always kept D_SENSE set to zero by default.
> (It is however possible to change the value using a MODE SELECT command.)
> 
> For failed ATA PASS-THROUGH commands, we correctly generated sense data
> according to the D_SENSE bit. However, because of a bug, sense data for
> successful ATA PASS-THROUGH commands was always generated in the
> descriptor format.
> 
> This was fixed to consistently respect D_SENSE for both failed and
> successful ATA PASS-THROUGH commands in commit 28ab9769117c ("ata:
> libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error").
> 
> After commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
> CK_COND=1 and no error"), we started receiving bug reports that we broke
> these user space programs (these user space programs must never have
> encountered a failing command, as the sense data for failing commands has
> always correctly respected D_SENSE, which by default meant fixed format).
> 
> Since a lot of user space programs seem to assume that the sense data is
> in descriptor format (without checking the type), let's simply change the
> default to have D_SENSE set to one by default.
> 
> That way:
> -Broken user space programs will see no regression.
> -Both failed and successful ATA PASS-THROUGH commands will respect D_SENSE,
>  as per SAT-6 revision 1.
> -Apparently it seems way more common for user space applications to assume
>  that the sense data is in descriptor format, rather than fixed format.
>  (A user space program should of course support both, and check the
>  RESPONSE CODE field to see which format the returned sense data is in.)
> 
> Cc: stable@vger.kernel.org # 4.19+
> Reported-by: Stephan Eisvogel <eisvogel@seitics.de>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Closes: https://lore.kernel.org/linux-ide/0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu/
> Fixes: 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c7752dc80028..590bebe1354d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5368,6 +5368,13 @@ void ata_dev_init(struct ata_device *dev)
>  	 */
>  	spin_lock_irqsave(ap->lock, flags);
>  	dev->flags &= ~ATA_DFLAG_INIT_MASK;
> +
> +	/*
> +	 * A lot of user space programs incorrectly assume that the sense data
> +	 * is in descriptor format, without checking the RESPONSE CODE field of
> +	 * the returned sense data (to see which format the sense data is in).
> +	 */
> +	dev->flags |= ATA_DFLAG_D_SENSE;
>  	dev->horkage = 0;
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> -- 
> 2.46.0
> 

This patch will change so that the sense data will be generated in descriptor
format (by default) for passthrough (SG_IO) commands, not just SG_IO ATA
PASS-THROUGH commands.

Non-passthrough (SG_IO) commands are not relavant, as they will go via
scsi_finish_command(), which calls scsi_normalize_sense() before interpreting
the sense data, and for non-passthrough commands, the sense data is not
propagated to the user. (The SK/ASC/ASCQ is only printed to the log, and this
print will be the same as before.)

However, it is possible to send any command as passthrough (SG_IO), not only
ATA PASS-THROUGH (ATA-16 / ATA-12 commands).

So there will be a difference (by default) for SG_IO (passthrough) commands
that are not ATA PASS-THROUGH commands (ATA-16 / ATA-12 commands).
(E.g. if you send a regular SCSI read/write command via SG_IO to an ATA device,
and if that command generates sense data, the default sense data format would
be different.)

Is this a concern?

I have a feeling that some user space program that blindly assumes that the
sense data will be in fixed format (for e.g. a command that does an invalid
read) using SG_IO will start to complain because of a "regression".

Thus, perhaps it is safest to just drop this patch, and let users of
passthrough commands (SG_IO) simply learn how to parse sense data properly,
since there will/can always be someone complaining. My personal feeling is
that passthrough commands should simply follow the storage standard exactly,
and if a user space application does adhere to the standard, tough luck,
why are you using passthrough commands instead of regular commands then?
Passthrough commands by definition follow a specific storage standard,
and not the Linux kernel block layer API.


Kind regards,
Niklas

