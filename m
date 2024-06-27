Return-Path: <stable+bounces-56000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8E91B1BE
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10C728399D
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 21:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8E19AD51;
	Thu, 27 Jun 2024 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXBB3l0J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249711A08B4
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525253; cv=none; b=Ipd15ps+61Za0dJQCWomsxAQ7zMxhKVn1+kq9SYW7FvclnvRoisPMOClfGjtqCFoSUAeKbUVbWUL1F2xiR61CBQy5s7eubd88vKL3x/RN/+F/IXF6WzeGA76S3bM6H+ypK4BH5MXdw5rCEQsjRCDTbU6plxkSCOoAdCnAXs4LzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525253; c=relaxed/simple;
	bh=CghmMDbzets4Pf3n0am8nQpiHR6bdQ7IAq5JZA9dFbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD1WCx4QV6zW42RZKLE3LER5bFKgEW5uM5ZZgffCuUogbaJ5j53+/gvQh1jJ6bZ70tYu0/RjxteTyFtv/eKGNcpZyS8G4HbsXGnY7nt0+YXnTW/F7juXw4dXIDAD47lJq4+SJ5rCL2hIDQ4UVBVm/DDTfkAYr9oez7ze5AlVKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXBB3l0J; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c86e3fb6e7so1392a91.1
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719525251; x=1720130051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwFU0+Ve1D1RlgQdsso7JBd7Ory/Gowu+D/c2nfTVjU=;
        b=IXBB3l0JPICE6pdto3gOWaOUmtml2PViEsM1nhHMVvwm+nsT4RHVe5RFaQKeVw807o
         stjA4LGIEzemmgR3GJljsyv/rNbjSNO6uT7zmPIADNOCwIOlT9faX96dblzJ/gHOGoqg
         +pGLfSm9f5XY/GNKNGThDMJ/h2GjFBdJ2aW3Go2gZeKr2ruPupxG6soQGheGyc8rmq+G
         RpxLPkMM7phdVR3vDgP4f2S2D7NQKLOCq7OScLxoZ/4Aud7t7T5c/z3Uv59PxnFp//kQ
         WPXsUGp+3UT7DssJlm1fi7xEH3gUJZnoY21QQA6LM5wSptz9VecowKANKPeYsPR9NCNv
         ZUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719525251; x=1720130051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwFU0+Ve1D1RlgQdsso7JBd7Ory/Gowu+D/c2nfTVjU=;
        b=tH/G108Ss9JUa2kaTzoBvR0/QsDqBUAmHUv6u76ZQzGT1aWPzSQnRfrOEGVQa+7iGt
         OrBsyervpAukhm5Yb0xbGg99WEwAnqoUFJGV7DCfcMAVh7WlpS/8ITZ+FtgjBO5XLC1s
         tS4nmDYKPZ0Iz2pEgEIBRfA52EXdBQBWkvR5XR9TgEb3p+MqSm+5t2Q7Evijvq9a4sxw
         hX9kXPGclo86V7rRXT88vzOjDdZoFpgtb6gR8XfYrI+eMP2dkjZRWx96IE7xB+sDlvOO
         79GVI32RrX8jrRaLedOn60Yey5CVO8V+S2Ext9f7/Q/46MeivJk/S0+m0ooriQh5D3bM
         tZpg==
X-Forwarded-Encrypted: i=1; AJvYcCXeRflyUkqV1wHnwgfdBz/QMnInk6hmTd+8030iHmgK9Pa5MVuZ/DC6wxI+mhwi3iwItAxzt+F+qvsnBq8KsoDc6CDyH708
X-Gm-Message-State: AOJu0Yy4QHqPPSM2UiS8fR09Lhfa5uaHyzdgLtw4uM1D3hKV0sbAwmkp
	7UlE+QOtCZ6R9qkia3yEah6V6Takqku1vcIZDlzCYt3Wn5+MXLjebjtRyRSLKg==
X-Google-Smtp-Source: AGHT+IEspPlGkcO6wFPv5PNakjMX5qZwsfh3/7Srf+ZM9ZcIiJeq555N/wrwUE0R3xfRuF5eQN0t+A==
X-Received: by 2002:a17:90a:1fc7:b0:2c7:700e:e2bf with SMTP id 98e67ed59e1d1-2c861250e64mr12555490a91.20.1719525250914;
        Thu, 27 Jun 2024 14:54:10 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce466f8sm286359a91.21.2024.06.27.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:54:09 -0700 (PDT)
Date: Thu, 27 Jun 2024 21:54:06 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn3ffnqsN4pVZA4m@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1zsaTLE3hYbSsK@ryzen.lan>

On Thu, Jun 27, 2024 at 04:14:09PM +0200, Niklas Cassel wrote:
> On Wed, Jun 26, 2024 at 11:04:07PM +0000, Igor Pylypiv wrote:
> > Current ata_gen_passthru_sense() code performs two actions:
> > 1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
> > 2. Populates "ATA Status Return sense data descriptor" / "Fixed format
> >    sense data" with ATA taskfile fields.
> > 
> > The problem is that #1 generates sense data even when a valid sense data
> > is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
> > a separate function allows us to generate sense data only when there is
> > no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).
> > 
> > As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
> > which states that we don't want to translate taskfile registers into
> > sense descriptors for ATAPI.
> > 
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
> >  1 file changed, 86 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index a9e44ad4c2de..26b1263f5c7c 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -230,6 +230,80 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
> >  				   SCSI_SENSE_BUFFERSIZE, information);
> >  }
> >  
> > +/**
> > + *	ata_scsi_set_passthru_sense_fields - Set ATA fields in sense buffer
> > + *	@qc: ATA PASS-THROUGH command.
> > + *
> > + *	Populates "ATA Status Return sense data descriptor" / "Fixed format
> > + *	sense data" with ATA taskfile fields.
> > + *
> > + *	LOCKING:
> > + *	None.
> > + */
> > +static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> > +{
> > +	struct scsi_cmnd *cmd = qc->scsicmd;
> > +	struct ata_taskfile *tf = &qc->result_tf;
> > +	unsigned char *sb = cmd->sense_buffer;
> > +
> > +	if ((sb[0] & 0x7f) >= 0x72) {
> > +		unsigned char *desc;
> > +		u8 len;
> > +
> > +		/* descriptor format */
> > +		len = sb[7];
> > +		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> > +		if (!desc) {
> > +			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> > +				return;
> > +			sb[7] = len + 14;
> > +			desc = sb + 8 + len;
> > +		}
> > +		desc[0] = 9;
> > +		desc[1] = 12;
> > +		/*
> > +		 * Copy registers into sense buffer.
> > +		 */
> > +		desc[2] = 0x00;
> > +		desc[3] = tf->error;
> > +		desc[5] = tf->nsect;
> > +		desc[7] = tf->lbal;
> > +		desc[9] = tf->lbam;
> > +		desc[11] = tf->lbah;
> > +		desc[12] = tf->device;
> > +		desc[13] = tf->status;
> > +
> > +		/*
> > +		 * Fill in Extend bit, and the high order bytes
> > +		 * if applicable.
> > +		 */
> > +		if (tf->flags & ATA_TFLAG_LBA48) {
> > +			desc[2] |= 0x01;
> > +			desc[4] = tf->hob_nsect;
> > +			desc[6] = tf->hob_lbal;
> > +			desc[8] = tf->hob_lbam;
> > +			desc[10] = tf->hob_lbah;
> > +		}
> > +	} else {
> > +		/* Fixed sense format */
> > +		sb[0] |= 0x80;
> > +		sb[3] = tf->error;
> > +		sb[4] = tf->status;
> > +		sb[5] = tf->device;
> > +		sb[6] = tf->nsect;
> > +		if (tf->flags & ATA_TFLAG_LBA48)  {
> > +			sb[8] |= 0x80;
> > +			if (tf->hob_nsect)
> > +				sb[8] |= 0x40;
> > +			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> > +				sb[8] |= 0x20;
> > +		}
> > +		sb[9] = tf->lbal;
> > +		sb[10] = tf->lbam;
> > +		sb[11] = tf->lbah;
> > +	}
> > +}
> > +
> >  static void ata_scsi_set_invalid_field(struct ata_device *dev,
> >  				       struct scsi_cmnd *cmd, u16 field, u8 bit)
> >  {
> > @@ -837,10 +911,8 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
> >   *	ata_gen_passthru_sense - Generate check condition sense block.
> >   *	@qc: Command that completed.
> >   *
> > - *	This function is specific to the ATA descriptor format sense
> > - *	block specified for the ATA pass through commands.  Regardless
> > - *	of whether the command errored or not, return a sense
> > - *	block. Copy all controller registers into the sense
> > + *	This function is specific to the ATA pass through commands.
> > + *	Regardless of whether the command errored or not, return a sense
> >   *	block. If there was no error, we get the request from an ATA
> >   *	passthrough command, so we use the following sense data:
> >   *	sk = RECOVERED ERROR
> > @@ -875,63 +947,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  		 */
> >  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> >  	}
> > -
> > -	if ((sb[0] & 0x7f) >= 0x72) {
> > -		unsigned char *desc;
> > -		u8 len;
> > -
> > -		/* descriptor format */
> > -		len = sb[7];
> > -		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> > -		if (!desc) {
> > -			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> > -				return;
> > -			sb[7] = len + 14;
> > -			desc = sb + 8 + len;
> > -		}
> > -		desc[0] = 9;
> > -		desc[1] = 12;
> > -		/*
> > -		 * Copy registers into sense buffer.
> > -		 */
> > -		desc[2] = 0x00;
> > -		desc[3] = tf->error;
> > -		desc[5] = tf->nsect;
> > -		desc[7] = tf->lbal;
> > -		desc[9] = tf->lbam;
> > -		desc[11] = tf->lbah;
> > -		desc[12] = tf->device;
> > -		desc[13] = tf->status;
> > -
> > -		/*
> > -		 * Fill in Extend bit, and the high order bytes
> > -		 * if applicable.
> > -		 */
> > -		if (tf->flags & ATA_TFLAG_LBA48) {
> > -			desc[2] |= 0x01;
> > -			desc[4] = tf->hob_nsect;
> > -			desc[6] = tf->hob_lbal;
> > -			desc[8] = tf->hob_lbam;
> > -			desc[10] = tf->hob_lbah;
> > -		}
> > -	} else {
> > -		/* Fixed sense format */
> > -		sb[0] |= 0x80;
> > -		sb[3] = tf->error;
> > -		sb[4] = tf->status;
> > -		sb[5] = tf->device;
> > -		sb[6] = tf->nsect;
> > -		if (tf->flags & ATA_TFLAG_LBA48)  {
> > -			sb[8] |= 0x80;
> > -			if (tf->hob_nsect)
> > -				sb[8] |= 0x40;
> > -			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> > -				sb[8] |= 0x20;
> > -		}
> > -		sb[9] = tf->lbal;
> > -		sb[10] = tf->lbam;
> > -		sb[11] = tf->lbah;
> > -	}
> >  }
> >  
> >  /**
> > @@ -1634,6 +1649,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  	u8 *cdb = cmd->cmnd;
> >  	int need_sense = (qc->err_mask != 0) &&
> >  		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > +	int need_passthru_sense = (qc->err_mask != 0) ||
> > +		(qc->flags & ATA_QCFLAG_SENSE_VALID);
> >  
> >  	/* For ATA pass thru (SAT) commands, generate a sense block if
> >  	 * user mandated it or if there's an error.  Note that if we
> > @@ -1645,13 +1662,16 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> >  	 */
> >  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > -	    ((cdb[2] & 0x20) || need_sense))
> > -		ata_gen_passthru_sense(qc);
> > -	else if (need_sense)
> > +	    ((cdb[2] & 0x20) || need_passthru_sense)) {
> > +		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> > +			ata_gen_passthru_sense(qc);
> > +		ata_scsi_set_passthru_sense_fields(qc);
> 
> This whole logic looks too complicated to me.
> 
> Can't we do something to make it easier to read, e.g. something like:
> 
> 
> {
> 	if (command_is_ata_passthru(cdb)) {
> 		handle_passthru_completion(qc);
> 		ata_qc_done();
> 		return;
> 	}
> 
> 	if (need_sense)
> 		ata_gen_ata_sense(qc);
> 	else
> 		/* Keep the SCSI ML and status byte, clear host byte. */ 
> 		cmd->result &= 0x0000ffff;
> 
> 	ata_qc_done();
> }
> 
> And then put the complicated logic in handle_passthru_command() ?
> 
> /* CASES:
> * a) IF error command (ERROR or DF set) and ATA_QCFLAG_SENSE_VALID (SK+ASC+ASCQ) set:
> *    - don't touch SK/ASC/ASCQ in sense_buffer
> *    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
> * b) IF error command (ERROR or DF set) and ATA_QCFLAG_SENSE_VALID (SK+ASC+ASCQ) not set:
> *    - generate the SK+ASC+ASCQ from ATA status and ATA error, and
> *    - set CHECK_CONDITION in cmd->result (scsi_build_sense() does this)
> *    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
> * c) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID set, CK_COND set:
> *    - don't touch SK/ASC/ASCQ in sense_buffer
> *    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
> *    - we should probably set CHECK_CONDITION status byte in cmd->result here.... but not sure...
> * d) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID set, CK_COND not set:
> *    - don't touch SK/ASC/ASCQ in sense_buffer
> *    - don't fill ATA registers
> *    - keep the SCSI ML and status byte, clear host byte, in cmd->result
> * e) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID not set, CK_COND set:
> *    - set SK to "RECOVERED ERROR" ASCQ to "ATA PASS-THROUGH INFORMATION AVAILABLE", ASC to 0.
> *    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
> *    - set CHECK_CONDITION status byte in cmd->result
> * f) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID not set, CK_COND not set:
> *    - keep the SCSI ML and status byte, clear host byte, in cmd->result
> */
> static void ata_handle_passthru_completion(struct ata_queued_cmd *qc);
>
> So we should only copy the ATA registers when CK_COND is set, or if ERROR bit
> or DF bit was set. CK_COND being set in the cdb (input command) basically means
> that the user requested that the ATA registers should be copied into the sense
> buffer (in the result).
> 
> The only tricky case is if we should set CHECK_CONDITION in case c) or not.
> All other cases seems quite clear by looking at the SAT spec.
> 

Thank you, Niklas! I agree that this code is too complicated and should be
simplified. I don't think we should change the code too much in this patch
since it is going to be backported to stable releases.

Would you mind sending a patch for the proposed simplifications following
this patch series?

I think there are some additional simplifications that can be made,
e.g. both ata_gen_passthru_sense() and ata_gen_ata_sense() contain
the same exact code:

        /*                                                                      
         * Use ata_to_sense_error() to map status register bits                 
         * onto sense key, asc & ascq.                                          
         */                                                                     
        if (qc->err_mask ||                                                     
            tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {             
                ata_to_sense_error(tf->status, tf->error,                       
                                   &sense_key, &asc, &ascq);                    
                ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);         
        } else {

Perhaps it can be moved into a separate function, etc.

Thanks,
Igor

> 
> > +	} else if (need_sense) {
> >  		ata_gen_ata_sense(qc);
> > -	else
> > +	} else {
> >  		/* Keep the SCSI ML and status byte, clear host byte. */
> >  		cmd->result &= 0x0000ffff;
> > +	}
> >  
> >  	ata_qc_done(qc);
> >  }
> > @@ -2590,14 +2610,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
> >  	/* handle completion from EH */
> >  	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
> >  
> > -		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
> > -			/* FIXME: not quite right; we don't want the
> > -			 * translation of taskfile registers into a
> > -			 * sense descriptors, since that's only
> > -			 * correct for ATA, not ATAPI
> > -			 */
> > +		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> >  			ata_gen_passthru_sense(qc);
> > -		}
> >  
> >  		/* SCSI EH automatically locks door if sdev->locked is
> >  		 * set.  Sometimes door lock request continues to
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

