Return-Path: <stable+bounces-55967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5491A8EE
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFB6288B9F
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDD195F3B;
	Thu, 27 Jun 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqmySbIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305421946BB;
	Thu, 27 Jun 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497654; cv=none; b=I0+ona+Wf6XE9ccWFqrDsdMbbOPorALwR1Rl5wrprB14VFsBJCNW8KueFgSM4bnPyWpI9IRWd8rzDepWcIuqpLcMarL1MY5uyluw1nAqkd6Mt9LXDGToGPtAVOshrytOibsZe0U5+nmAhFNr5hv+Q8phNWZes/2tV1DsbCp31I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497654; c=relaxed/simple;
	bh=Gt4w3GmH/wiOInIdW9HmL5vYIZWb6qBc1afdxEgnJ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwo8rKnQYPUrusHwzziP2vzRebuH5Ru1DlZjUIJP7RiAwfauKkY6+eBMNplCM+gIxp53FzhdflQseS6N2rjlCfClvH9SmP9ap+tvDZ0Guhbe8eQ+8ta1BFFB6Rw1G7ZJiF4w4pdBQjPnhI214LHm2kr6t7nbFezVhj9Igqvhr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqmySbIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1549AC2BBFC;
	Thu, 27 Jun 2024 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497653;
	bh=Gt4w3GmH/wiOInIdW9HmL5vYIZWb6qBc1afdxEgnJ/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqmySbIw/u0/pIl77GI4ak29n0eFJQwffRHR1hF45egt31fxmjJuhMFhhoMQNTm5j
	 Pwnpxzv4Kq6xsfiPtFJPlgiJDLQC6cMQnmM1bdILt6VOlub2E+nmzjU/HJ+nW1bJtr
	 Lxs7fZZcmRfayOPHUWXmf/A1+m2KYVLqAcfCxzN2rexRmPoS3rN9fb1m8ho5vuepv/
	 JxZi5M3kEzymC3NT7w6NBAj9DHDiQkR0TdVrJOm684LPyuTtqAbaKD+FdCpqkfJhLY
	 QYrBvpjK3FSLq7r4T/MpyPMgMMQeQJpBo3mrGf5N3TzVV2bM4Yt9/nPu5Lv8Prd68F
	 Z/5ETNRC6cFCg==
Date: Thu, 27 Jun 2024 16:14:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn1zsaTLE3hYbSsK@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626230411.3471543-3-ipylypiv@google.com>

On Wed, Jun 26, 2024 at 11:04:07PM +0000, Igor Pylypiv wrote:
> Current ata_gen_passthru_sense() code performs two actions:
> 1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
> 2. Populates "ATA Status Return sense data descriptor" / "Fixed format
>    sense data" with ATA taskfile fields.
> 
> The problem is that #1 generates sense data even when a valid sense data
> is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
> a separate function allows us to generate sense data only when there is
> no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).
> 
> As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
> which states that we don't want to translate taskfile registers into
> sense descriptors for ATAPI.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
>  1 file changed, 86 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a9e44ad4c2de..26b1263f5c7c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -230,6 +230,80 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
>  				   SCSI_SENSE_BUFFERSIZE, information);
>  }
>  
> +/**
> + *	ata_scsi_set_passthru_sense_fields - Set ATA fields in sense buffer
> + *	@qc: ATA PASS-THROUGH command.
> + *
> + *	Populates "ATA Status Return sense data descriptor" / "Fixed format
> + *	sense data" with ATA taskfile fields.
> + *
> + *	LOCKING:
> + *	None.
> + */
> +static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> +{
> +	struct scsi_cmnd *cmd = qc->scsicmd;
> +	struct ata_taskfile *tf = &qc->result_tf;
> +	unsigned char *sb = cmd->sense_buffer;
> +
> +	if ((sb[0] & 0x7f) >= 0x72) {
> +		unsigned char *desc;
> +		u8 len;
> +
> +		/* descriptor format */
> +		len = sb[7];
> +		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> +		if (!desc) {
> +			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> +				return;
> +			sb[7] = len + 14;
> +			desc = sb + 8 + len;
> +		}
> +		desc[0] = 9;
> +		desc[1] = 12;
> +		/*
> +		 * Copy registers into sense buffer.
> +		 */
> +		desc[2] = 0x00;
> +		desc[3] = tf->error;
> +		desc[5] = tf->nsect;
> +		desc[7] = tf->lbal;
> +		desc[9] = tf->lbam;
> +		desc[11] = tf->lbah;
> +		desc[12] = tf->device;
> +		desc[13] = tf->status;
> +
> +		/*
> +		 * Fill in Extend bit, and the high order bytes
> +		 * if applicable.
> +		 */
> +		if (tf->flags & ATA_TFLAG_LBA48) {
> +			desc[2] |= 0x01;
> +			desc[4] = tf->hob_nsect;
> +			desc[6] = tf->hob_lbal;
> +			desc[8] = tf->hob_lbam;
> +			desc[10] = tf->hob_lbah;
> +		}
> +	} else {
> +		/* Fixed sense format */
> +		sb[0] |= 0x80;
> +		sb[3] = tf->error;
> +		sb[4] = tf->status;
> +		sb[5] = tf->device;
> +		sb[6] = tf->nsect;
> +		if (tf->flags & ATA_TFLAG_LBA48)  {
> +			sb[8] |= 0x80;
> +			if (tf->hob_nsect)
> +				sb[8] |= 0x40;
> +			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> +				sb[8] |= 0x20;
> +		}
> +		sb[9] = tf->lbal;
> +		sb[10] = tf->lbam;
> +		sb[11] = tf->lbah;
> +	}
> +}
> +
>  static void ata_scsi_set_invalid_field(struct ata_device *dev,
>  				       struct scsi_cmnd *cmd, u16 field, u8 bit)
>  {
> @@ -837,10 +911,8 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
>   *	ata_gen_passthru_sense - Generate check condition sense block.
>   *	@qc: Command that completed.
>   *
> - *	This function is specific to the ATA descriptor format sense
> - *	block specified for the ATA pass through commands.  Regardless
> - *	of whether the command errored or not, return a sense
> - *	block. Copy all controller registers into the sense
> + *	This function is specific to the ATA pass through commands.
> + *	Regardless of whether the command errored or not, return a sense
>   *	block. If there was no error, we get the request from an ATA
>   *	passthrough command, so we use the following sense data:
>   *	sk = RECOVERED ERROR
> @@ -875,63 +947,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  		 */
>  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
>  	}
> -
> -	if ((sb[0] & 0x7f) >= 0x72) {
> -		unsigned char *desc;
> -		u8 len;
> -
> -		/* descriptor format */
> -		len = sb[7];
> -		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> -		if (!desc) {
> -			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> -				return;
> -			sb[7] = len + 14;
> -			desc = sb + 8 + len;
> -		}
> -		desc[0] = 9;
> -		desc[1] = 12;
> -		/*
> -		 * Copy registers into sense buffer.
> -		 */
> -		desc[2] = 0x00;
> -		desc[3] = tf->error;
> -		desc[5] = tf->nsect;
> -		desc[7] = tf->lbal;
> -		desc[9] = tf->lbam;
> -		desc[11] = tf->lbah;
> -		desc[12] = tf->device;
> -		desc[13] = tf->status;
> -
> -		/*
> -		 * Fill in Extend bit, and the high order bytes
> -		 * if applicable.
> -		 */
> -		if (tf->flags & ATA_TFLAG_LBA48) {
> -			desc[2] |= 0x01;
> -			desc[4] = tf->hob_nsect;
> -			desc[6] = tf->hob_lbal;
> -			desc[8] = tf->hob_lbam;
> -			desc[10] = tf->hob_lbah;
> -		}
> -	} else {
> -		/* Fixed sense format */
> -		sb[0] |= 0x80;
> -		sb[3] = tf->error;
> -		sb[4] = tf->status;
> -		sb[5] = tf->device;
> -		sb[6] = tf->nsect;
> -		if (tf->flags & ATA_TFLAG_LBA48)  {
> -			sb[8] |= 0x80;
> -			if (tf->hob_nsect)
> -				sb[8] |= 0x40;
> -			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> -				sb[8] |= 0x20;
> -		}
> -		sb[9] = tf->lbal;
> -		sb[10] = tf->lbam;
> -		sb[11] = tf->lbah;
> -	}
>  }
>  
>  /**
> @@ -1634,6 +1649,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  	u8 *cdb = cmd->cmnd;
>  	int need_sense = (qc->err_mask != 0) &&
>  		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> +	int need_passthru_sense = (qc->err_mask != 0) ||
> +		(qc->flags & ATA_QCFLAG_SENSE_VALID);
>  
>  	/* For ATA pass thru (SAT) commands, generate a sense block if
>  	 * user mandated it or if there's an error.  Note that if we
> @@ -1645,13 +1662,16 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>  	 */
>  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -	    ((cdb[2] & 0x20) || need_sense))
> -		ata_gen_passthru_sense(qc);
> -	else if (need_sense)
> +	    ((cdb[2] & 0x20) || need_passthru_sense)) {
> +		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> +			ata_gen_passthru_sense(qc);
> +		ata_scsi_set_passthru_sense_fields(qc);

This whole logic looks too complicated to me.

Can't we do something to make it easier to read, e.g. something like:


{
	if (command_is_ata_passthru(cdb)) {
		handle_passthru_completion(qc);
		ata_qc_done();
		return;
	}

	if (need_sense)
		ata_gen_ata_sense(qc);
	else
		/* Keep the SCSI ML and status byte, clear host byte. */ 
		cmd->result &= 0x0000ffff;

	ata_qc_done();
}

And then put the complicated logic in handle_passthru_command() ?

/* CASES:
* a) IF error command (ERROR or DF set) and ATA_QCFLAG_SENSE_VALID (SK+ASC+ASCQ) set:
*    - don't touch SK/ASC/ASCQ in sense_buffer
*    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
* b) IF error command (ERROR or DF set) and ATA_QCFLAG_SENSE_VALID (SK+ASC+ASCQ) not set:
*    - generate the SK+ASC+ASCQ from ATA status and ATA error, and
*    - set CHECK_CONDITION in cmd->result (scsi_build_sense() does this)
*    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
* c) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID set, CK_COND set:
*    - don't touch SK/ASC/ASCQ in sense_buffer
*    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
*    - we should probably set CHECK_CONDITION status byte in cmd->result here.... but not sure...
* d) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID set, CK_COND not set:
*    - don't touch SK/ASC/ASCQ in sense_buffer
*    - don't fill ATA registers
*    - keep the SCSI ML and status byte, clear host byte, in cmd->result
* e) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID not set, CK_COND set:
*    - set SK to "RECOVERED ERROR" ASCQ to "ATA PASS-THROUGH INFORMATION AVAILABLE", ASC to 0.
*    - set ATA registers in fixed format or descriptor format (based on dev->flags ATA_DFLAG_D_SENSE)
*    - set CHECK_CONDITION status byte in cmd->result
* f) IF success command (ERROR and DF not set), and ATA_QCFLAG_SENSE_VALID not set, CK_COND not set:
*    - keep the SCSI ML and status byte, clear host byte, in cmd->result
*/
static void ata_handle_passthru_completion(struct ata_queued_cmd *qc);

So we should only copy the ATA registers when CK_COND is set, or if ERROR bit
or DF bit was set. CK_COND being set in the cdb (input command) basically means
that the user requested that the ATA registers should be copied into the sense
buffer (in the result).

The only tricky case is if we should set CHECK_CONDITION in case c) or not.
All other cases seems quite clear by looking at the SAT spec.


> +	} else if (need_sense) {
>  		ata_gen_ata_sense(qc);
> -	else
> +	} else {
>  		/* Keep the SCSI ML and status byte, clear host byte. */
>  		cmd->result &= 0x0000ffff;
> +	}
>  
>  	ata_qc_done(qc);
>  }
> @@ -2590,14 +2610,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
>  	/* handle completion from EH */
>  	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
>  
> -		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
> -			/* FIXME: not quite right; we don't want the
> -			 * translation of taskfile registers into a
> -			 * sense descriptors, since that's only
> -			 * correct for ATA, not ATAPI
> -			 */
> +		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
>  			ata_gen_passthru_sense(qc);
> -		}
>  
>  		/* SCSI EH automatically locks door if sdev->locked is
>  		 * set.  Sometimes door lock request continues to
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

