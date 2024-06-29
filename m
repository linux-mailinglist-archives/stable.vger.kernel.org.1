Return-Path: <stable+bounces-56112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B22E91CACA
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 05:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986031F22D78
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327C1CFA0;
	Sat, 29 Jun 2024 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi+zLacS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A91CF90;
	Sat, 29 Jun 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630600; cv=none; b=SM+DOd+gmYITGrQo11qq+9P7Xl3izYkMUEmXboX40/fTYKNA0RSNcJtvwZNuHKDeotmhjAi8L7pvEYJDTfHDgX764blFCjG+9/adTZiZsDKigsvWEPd7U24K2JpHlhGTpIsDMXhfsfTWB/P+20P3SwGsDD/uq1vnr+uU6Mhpyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630600; c=relaxed/simple;
	bh=f3l1q+6TnZPwqbHcnPQ46pla6sNSv0vzO2Ms+sBmZVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDht9S1MHfGbK5zjDWB1jqJwfOnqKp1m5FMtDHdeF0axP2jHGG1YaIl5VLIpE20NGx8dOk1ndwAdSmG2+GMmi34D/z+ksgAlJGxRHZqB90/Dc6D7PyWbM2tuyWsrBqbIwLovCTrHHD5bPzU35mwMbsvLhBvM6Ks0pQ3J86TJZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi+zLacS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADABC116B1;
	Sat, 29 Jun 2024 03:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719630599;
	bh=f3l1q+6TnZPwqbHcnPQ46pla6sNSv0vzO2Ms+sBmZVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zi+zLacSovRHGT4+Eu6tPTB1T3KOx2Iv4Pxf6M+/VKoPuBplriWdmczVXieIlsAF9
	 1qyuE1ipCkRu3i5ZgcN540sVJu29JecR4lE+8hVZQUDF2AvoMuFjwgSCIveKTLzkQM
	 FGPYCyzLDXJKNys9uUoeMP0SQ3UrbFIuONjV+G7783yacjYlYPSf7bqgincdJYs3+u
	 xQ3BuJ9c5NhM4xxF/ftdHLc98/F5PnjIXBE7x7dX9eWkKKSyoyuwQbFDwiGwWxY5TW
	 QaObChfThuAA6atbSOqktMdEwJ9WW8pALLrlLORt9jzS6sNev0fvQokH+Z0JIvzLG2
	 HuW7ZW8HU1iCg==
Date: Sat, 29 Jun 2024 05:09:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn97AtP4IC7T1NoO@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
 <Zn3ffnqsN4pVZA4m@google.com>
 <Zn8EmT1fefVzgy0F@ryzen.lan>
 <Zn9H17FoDDg9hpUr@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn9H17FoDDg9hpUr@google.com>

On Fri, Jun 28, 2024 at 11:31:35PM +0000, Igor Pylypiv wrote:
> On Fri, Jun 28, 2024 at 08:44:41PM +0200, Niklas Cassel wrote:
> > On Thu, Jun 27, 2024 at 09:54:06PM +0000, Igor Pylypiv wrote:
> > > 
> > > Thank you, Niklas! I agree that this code is too complicated and should be
> > > simplified. I don't think we should change the code too much in this patch
> > > since it is going to be backported to stable releases.
> > > 
> > > Would you mind sending a patch for the proposed simplifications following
> > > this patch series?
> > > 
> > 
> > I would prefer if we changed it as part of this commit to be honest.
> > 
> > 
> > I also re-read the SAT spec, and found that it says that:
> > """
> > If the CK_COND bit is set to:
> > a) one, then the SATL shall return a status of CHECK CONDITION upon ATA command completion,
> > without interpreting the contents of the STATUS field and returning the ATA fields from the request
> > completion in the sense data as specified in table 209; and
> > b) zero, then the SATL shall terminate the command with CHECK CONDITION status only if an error
> > occurs in processing the command. See clause 11 for a description of ATA error conditions.
> > """
> > 
> > So it seems quite clear that if CK_COND == 1, we should set CHECK CONDITION,
> > so that answers the question/uncertainty I asked/expressed in earlier emails.
> > 
> > 
> > I think this patch (which should be applied on top of your v3 series),
> > makes the code way easier to read/understand:
> > 
> 
> Agree, having self-explanatory variable names makes the code much more
> readable. I'll add the patch in v4.
> 
> Do you mind if I set you as the author of the patch with the corresponding
> Signed-off-by tag?

I still think that you are the author.

But if you want, feel free to add me as: Co-developed-by
(which would also require you to add my Signed-off-by), see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by


> 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index d5874d4b9253..5b211551ac10 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1659,26 +1656,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  {
> >         struct scsi_cmnd *cmd = qc->scsicmd;
> >         u8 *cdb = cmd->cmnd;
> > -       int need_sense = (qc->err_mask != 0) &&
> > -               !(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > -       int need_passthru_sense = (qc->err_mask != 0) ||
> > -               (qc->flags & ATA_QCFLAG_SENSE_VALID);
> > +       bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> > +       bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
> > +       bool is_ck_cond_request = cdb[2] & 0x20;
> > +       bool is_error = qc->err_mask != 0;
> >  
> >         /* For ATA pass thru (SAT) commands, generate a sense block if
> >          * user mandated it or if there's an error.  Note that if we
> > -        * generate because the user forced us to [CK_COND =1], a check
> > +        * generate because the user forced us to [CK_COND=1], a check
> >          * condition is generated and the ATA register values are returned
> >          * whether the command completed successfully or not. If there
> > -        * was no error, we use the following sense data:
> > +        * was no error, and CK_COND=1, we use the following sense data:
> >          * sk = RECOVERED ERROR
> >          * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> >          */
> > -       if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > -           ((cdb[2] & 0x20) || need_passthru_sense)) {
> > -               if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> > +       if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
> > +               if (!have_sense)
> >                         ata_gen_passthru_sense(qc);
> >                 ata_scsi_set_passthru_sense_fields(qc);
> > -       } else if (need_sense) {
> > +               if (is_ck_cond_request)
> > +                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> 
> SAM_STAT_CHECK_CONDITION will be set by ata_gen_passthru_sense(). Perhaps we
> can move the SAM_STAT_CHECK_CONDITION setting into else if?

I think it is fine that:
if (is_ck_cond_request)
	set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);

might set SAM_STAT_CHECK_CONDITION even if it is already set.

Personally, I think that my suggestion is slightly clearer when it comes
to highlight the behavior of CK_COND. (CK_COND will set CHECK_CONDITION,
regardless if successful command or error command, and regardless if
we already had sense or not.)

And considering that we finally make this hard to read code slightly more
readable than it was to start off with, I would prefer my alternative.


Kind regards,
Niklas

