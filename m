Return-Path: <stable+bounces-67444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798B950163
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194581F23DF5
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA31A187554;
	Tue, 13 Aug 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6WxzItL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A117C7C2;
	Tue, 13 Aug 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542094; cv=none; b=EEFnt3blIIiZLptIe1Ikkp9eFQMLpq+7O9dwlIYfeRKsEqfruvX7T+pRLh93vALFLkcJQPEcssiGmeztMgoqanDWfIdab0LAUx5xZEg/1M97ihiHa5/334s7nLIhYXRIhVoUS+TNDIW10Vvfjp5eMOcT5rNg6hHijdvEevZ+dSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542094; c=relaxed/simple;
	bh=NCGCn0f/k1kMXI1ZHWQh2En1c2YY4FaEGdxpfvUv04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J63VqHSaj5LiRFSXPiKgGH5OyftJ7G1X15Pc8QXlIbOr/iy5lS5DzQN1A+HQGt6dUbmekymFHu34rulVQLb0QPiQodqRW9PDfzhU6e1GWMFJZEFwCS32Zgpz6H8c4U4cZJBDiQXjx3md1b4VOleRSkw8eGxelF1fr7UriUGQwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6WxzItL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE5C4AF0B;
	Tue, 13 Aug 2024 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542094;
	bh=NCGCn0f/k1kMXI1ZHWQh2En1c2YY4FaEGdxpfvUv04A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6WxzItLFZM4yKGMikPRuYhUlgBe21AHfONkK/fjrmvEeuF5gUnUus2gurw6f+sSA
	 N3JSrH8sLiKxSdm+zVv7DcUQu6ejhHEj1pgB38Px2ru5bErF/fFHD6WW3ldKC6BeFT
	 2pcgg9zgyQdnhM1EMNiwwFR7cx9BCfvq7NDq9uFTvmZYtF1wzmy1fguZTzpVIfpdOi
	 QNilMH5s1ViwuX9COXG8K/FvVsRW1eS/3oSiGs2Y/pLYV8LwDMXr8U+cmE/flP0pNk
	 bK5RuwMQctb+zfLm5mF6BgI67xCz78r5DetodGN4SqkdiwED91xBVHT+bx0lwtguvw
	 pFJ2OS9PNU1gg==
Date: Tue, 13 Aug 2024 11:41:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Igor Pylypiv <ipylypiv@google.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	stable@vger.kernel.org, Stephan Eisvogel <eisvogel@seitics.de>,
	Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ata: libata-core: Return sense data in descriptor format
 by default
Message-ID: <ZrsqSA7P30vss6b9@x1-carbon.wireless.wdc>
References: <20240812151517.1162241-2-cassel@kernel.org>
 <ZrpXu_vfI-wpCFVc@ryzen.lan>
 <3d3beb8d-4c93-4eef-b3ee-c92eb9df9009@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3beb8d-4c93-4eef-b3ee-c92eb9df9009@suse.de>

On Tue, Aug 13, 2024 at 08:37:42AM +0200, Hannes Reinecke wrote:
> On 8/12/24 20:43, Niklas Cassel wrote:
> > On Mon, Aug 12, 2024 at 05:15:18PM +0200, Niklas Cassel wrote:
> > > Sense data can be in either fixed format or descriptor format.
> > > 
> > > SAT-6 revision 1, 10.4.6 Control mode page, says that if the D_SENSE bit
> > > is set to zero (i.e., fixed format sense data), then the SATL should
> > > return fixed format sense data for ATA PASS-THROUGH commands.
> > > 
> > > A lot of user space programs incorrectly assume that the sense data is in
> > > descriptor format, without checking the RESPONSE CODE field of the
> > > returned sense data (to see which format the sense data is in).
> > > 
> > > The libata SATL has always kept D_SENSE set to zero by default.
> > > (It is however possible to change the value using a MODE SELECT command.)
> > > 
> > > For failed ATA PASS-THROUGH commands, we correctly generated sense data
> > > according to the D_SENSE bit. However, because of a bug, sense data for
> > > successful ATA PASS-THROUGH commands was always generated in the
> > > descriptor format.
> > > 
> > > This was fixed to consistently respect D_SENSE for both failed and
> > > successful ATA PASS-THROUGH commands in commit 28ab9769117c ("ata:
> > > libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error").
> > > 
> > > After commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
> > > CK_COND=1 and no error"), we started receiving bug reports that we broke
> > > these user space programs (these user space programs must never have
> > > encountered a failing command, as the sense data for failing commands has
> > > always correctly respected D_SENSE, which by default meant fixed format).
> > > 
> > > Since a lot of user space programs seem to assume that the sense data is
> > > in descriptor format (without checking the type), let's simply change the
> > > default to have D_SENSE set to one by default.
> > > 
> > > That way:
> > > -Broken user space programs will see no regression.
> > > -Both failed and successful ATA PASS-THROUGH commands will respect D_SENSE,
> > >   as per SAT-6 revision 1.
> > > -Apparently it seems way more common for user space applications to assume
> > >   that the sense data is in descriptor format, rather than fixed format.
> > >   (A user space program should of course support both, and check the
> > >   RESPONSE CODE field to see which format the returned sense data is in.)
> > > 
> > > Cc: stable@vger.kernel.org # 4.19+
> > > Reported-by: Stephan Eisvogel <eisvogel@seitics.de>
> > > Reported-by: Christian Heusel <christian@heusel.eu>
> > > Closes: https://lore.kernel.org/linux-ide/0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu/
> > > Fixes: 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >   drivers/ata/libata-core.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index c7752dc80028..590bebe1354d 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -5368,6 +5368,13 @@ void ata_dev_init(struct ata_device *dev)
> > >   	 */
> > >   	spin_lock_irqsave(ap->lock, flags);
> > >   	dev->flags &= ~ATA_DFLAG_INIT_MASK;
> > > +
> > > +	/*
> > > +	 * A lot of user space programs incorrectly assume that the sense data
> > > +	 * is in descriptor format, without checking the RESPONSE CODE field of
> > > +	 * the returned sense data (to see which format the sense data is in).
> > > +	 */
> > > +	dev->flags |= ATA_DFLAG_D_SENSE;
> > >   	dev->horkage = 0;
> > >   	spin_unlock_irqrestore(ap->lock, flags);
> > > -- 
> > > 2.46.0
> > > 
> > 
> > This patch will change so that the sense data will be generated in descriptor
> > format (by default) for passthrough (SG_IO) commands, not just SG_IO ATA
> > PASS-THROUGH commands.
> > 
> > Non-passthrough (SG_IO) commands are not relavant, as they will go via
> > scsi_finish_command(), which calls scsi_normalize_sense() before interpreting
> > the sense data, and for non-passthrough commands, the sense data is not
> > propagated to the user. (The SK/ASC/ASCQ is only printed to the log, and this
> > print will be the same as before.)
> > 
> > However, it is possible to send any command as passthrough (SG_IO), not only
> > ATA PASS-THROUGH (ATA-16 / ATA-12 commands).
> > 
> > So there will be a difference (by default) for SG_IO (passthrough) commands
> > that are not ATA PASS-THROUGH commands (ATA-16 / ATA-12 commands).
> > (E.g. if you send a regular SCSI read/write command via SG_IO to an ATA device,
> > and if that command generates sense data, the default sense data format would
> > be different.)
> > 
> > Is this a concern?
> > 
> > I have a feeling that some user space program that blindly assumes that the
> > sense data will be in fixed format (for e.g. a command that does an invalid
> > read) using SG_IO will start to complain because of a "regression".
> > 
> I really hate it when people start generalising which in fact was an
> occurrence with a single program, namely hdparm.

It is actually multiple programs, namely hdparm, hddtemp and udisks.

It is unfortunate that these applications do not handle sense data correctly,
and they would break even on older kernels if your do a MODE SELECT to change
the D_SENSE bit to one.

However, right now I don't see any other option than to revert commit
28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and
no error"), so that we are no longer spec compliant with SAT-6. This commit
got backported to stable, so now there is a bunch of users complaining that
hddtemp etc. is no longer working.

Perhaps we could re-visit this code to be spec compliant again in the
future (after the bad programs have been fixed).


Kind regards,
Niklas

