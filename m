Return-Path: <stable+bounces-52303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B998F909CAA
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75662281A8C
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A93179641;
	Sun, 16 Jun 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKiBg/U0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5E178CCB;
	Sun, 16 Jun 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718528090; cv=none; b=Lcz++MU78/d3DTdHcMLAkjcBWcLepr0fbueC9+fuwqabJhYGgK2xpZrINGLyPZ9QUfrK5LlQ4xdEkIflKWFSId3BYovNm1gKoAuvPPaMDkheyk6lnQBE2DfJ24ZtoG8zxjdw3nQf82uNuu1hRxaOHNmBWkRsFdbDB8Q1fdUzR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718528090; c=relaxed/simple;
	bh=9u4X1h8+dSS2gV6fwWQ884huIkcSEjbT36eujB2qUg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XebR/iVpcGInQlCwzGFDy+MoplvzyiuZSl7P45yXEFs4OMXq8eElcfvGKZ8FYpQ/BlUFild3ElDiUvr6zs+qjQz92sOrgnyZxn+q7HvCxe/LeXkJqrqw5E1/BoB8v3Q3l+NABgSB4GXJoGPEJr34w+SKf852MfHPUBuChtKCoeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKiBg/U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACEBC2BBFC;
	Sun, 16 Jun 2024 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718528089;
	bh=9u4X1h8+dSS2gV6fwWQ884huIkcSEjbT36eujB2qUg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKiBg/U0oYM/+rbqSE4t7XhD+nWBQtsfKJ80bua+B8tH77U2po6miIqmPMcBWFPAx
	 I3UtCsVF7SBJZ+Mr5MRBjmp08QhraAqM8FtiB56HhfbWI4kYSKUdkLBXjENvh/KLCo
	 cEHQEgQCOS2rt2X4L9Klqxfu4lyhUpsnR4CtcTxMCPYYyIXygM5SJVQJ9zWaSifv5h
	 2aWSnUqeWvoNBP8SDn59SLsN1YrK3YKlND59Y9WSE+uNrBGrTx3WWwuETQcudz7tzx
	 fCGiTXmtUofQFC+FjISoHRlwsaK2sHFly1k0M3SEgubn0QDJ4AyxJvcZy24ryfp1lT
	 aFigZ2lFOSWoQ==
Date: Sun, 16 Jun 2024 10:54:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, stable@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Set the RMB bit only for removable
 media devices
Message-ID: <Zm6oVbQqY3Uckl4P@ryzen.lan>
References: <20240614122344.1577261-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614122344.1577261-2-cassel@kernel.org>

On Fri, Jun 14, 2024 at 02:23:45PM +0200, Niklas Cassel wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> The SCSI Removable Media Bit (RMB) should only be set for removable media,
> where the device stays and the media changes, e.g. CD-ROM or floppy.
> 
> The ATA removable media device bit is obsoleted since ATA-8 ACS (2006),
> but before that it was used to indicate that the device can have its media
> removed (while the device stays).
> 
> Commit 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as
> removable") introduced a change to set the RMB bit if the port has either
> the eSATA bit or the hot-plug capable bit set. The reasoning was that the
> author wanted his eSATA ports to get treated like a USB stick.
> 
> This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> Expectations" which has since been integrated to SPC, which states that:
> 
> """
> Reports have been received that some USB Memory Stick device servers set
> the removable medium (RMB) bit to one. The rub comes when the medium is
> actually removed, because... The device server is removed concurrently
> with the medium removal. If there is no device server, then there is no
> device server that is waiting to have removable medium inserted.
> 
> Sufficient numbers of SCSI analysts see such a device:
> - not as a device that supports removable medium;
> but
> - as a removable, hot pluggable device.
> """
> 
> The definition of the RMB bit in the SPC specification has since been
> clarified to match this.
> 
> Thus, a USB stick should not have the RMB bit set (and neither shall an
> eSATA nor a hot-plug capable port).
> 
> Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
> external/removable") then changed so that the RMB bit is only set for the
> eSATA bit (and not for the hot-plug capable bit), because of a lot of bug
> reports of SATA devices were being automounted by udisks. However,
> treating eSATA and hot-plug capable ports differently is not correct.
> 
> From the AHCI 1.3.1 spec:
> Hot Plug Capable Port (HPCP): When set to '1', indicates that this port's
> signal and power connectors are externally accessible via a joint signal
> and power connector for blindmate device hot plug.
> 
> So a hot-plug capable port is an external port, just like commit
> 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> claims.
> 
> In order to not violate the SPC specification, modify the SCSI INQUIRY
> data to only set the RMB bit if the ATA device can have its media removed.
> 
> This fixes a reported problem where GNOME/udisks was automounting devices
> connected to hot-plug capable ports.
> 
> Fixes: 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Tested-by: Thomas Weißschuh <linux@weissschuh.net>
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Closes: https://lore.kernel.org/linux-ide/c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de/
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> [cassel: wrote commit message]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Added Cc: stable.
> -Updated comment and commit message to correctly state that the
>  ATA removable media device bit is obsoleted since ATA-8 ACS.
> 
>  drivers/ata/libata-scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index cdf29b178ddc..bb4d30d377ae 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
>  		2
>  	};
>  
> -	/* set scsi removable (RMB) bit per ata bit, or if the
> -	 * AHCI port says it's external (Hotplug-capable, eSATA).
> +	/*
> +	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
> +	 * device bit (obsolete since ATA-8 ACS) is set.
>  	 */
> -	if (ata_id_removable(args->id) ||
> -	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
> +	if (ata_id_removable(args->id))
>  		hdr[1] |= (1 << 7);
>  
>  	if (args->dev->class == ATA_DEV_ZAC) {
> -- 
> 2.45.2
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.10-fixes

