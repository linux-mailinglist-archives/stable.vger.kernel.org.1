Return-Path: <stable+bounces-56277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF391E9FA
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 23:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5D4284324
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FA6171653;
	Mon,  1 Jul 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoC29VfQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760C170855;
	Mon,  1 Jul 2024 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868203; cv=none; b=cJHH46ZS9H4IRULjqGa3IjG+qF3glA4yYlKTGVVlYyR+93DmLT3rZpbkiD2hvILPtAt0WueO0zXB4nVeKDUuH4ER8TJe6h20Om/wVHuW7+YD4glg1wSeyw0Ssv1bto+mliZrz+miDJvrUOYEkEznivc6jTCpBTq74qEwgdt2XfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868203; c=relaxed/simple;
	bh=I+mbDCY+FeTTxdfJIQu5i2MerfDx039k/V9YynnPHVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTa1HdXi1dCZx1ULaNAfkzrfKHi448ILoFKw0DWbB1MI0dU/nEQR5ilfyA7xOa5GiyusnIt2D8QZmix1OwH6NvNXqXE4KLG2NQIAyMpkstSYTGww/eKHsQrmQEPQUP7Rl2P7geGj5NdQoFfuo0MbbeXrBxLrEqGe9ZVeBeFlXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoC29VfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EE0C116B1;
	Mon,  1 Jul 2024 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719868202;
	bh=I+mbDCY+FeTTxdfJIQu5i2MerfDx039k/V9YynnPHVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoC29VfQYzncc+fs+pTthq98KlbfZxPV6jYH7Ki0wO9dXJFLTl4WJRnLPfJjwsoAm
	 7KOFnMjorbahCWYb9zis9aC741vqohwUhzU51rL0bLNWI8qxVdhUMW8X9SgwTM7nc8
	 rMlIEsKyYQFx2u8KBXlHEwgj3LWIvy6FrFLhaLgb6wJZe82XeXcFoFybVK+ITubbPs
	 MYNZJmh3qoezvr/RvkjKVWGgxQ0lNVBDVeC4ljRPqenfSsSgR0BI39coMtFLu8LDYf
	 9aqsnw142+rrynovFm6yXSLC0sW8ZdrW1EAAxKFa5+QF5pHLAvy+uXHyBNh3coFAHh
	 42JI5dB8LIW3w==
Date: Mon, 1 Jul 2024 23:09:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/8] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <ZoMbJX7VupfIPfBp@ryzen.lan>
References: <20240701195758.1045917-1-ipylypiv@google.com>
 <20240701195758.1045917-2-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701195758.1045917-2-ipylypiv@google.com>

On Mon, Jul 01, 2024 at 07:57:51PM +0000, Igor Pylypiv wrote:
> Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
> to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
> indicate that the INFORMATION field contains valid information.
> 
> INFORMATION
> ===========
> 
> SAT-5 Table 212 — "Fixed format sense data INFORMATION field for the ATA
> PASS-THROUGH commands" defines the following format:
> 
> +------+------------+
> | Byte |   Field    |
> +------+------------+
> |    0 | ERROR      |
> |    1 | STATUS     |
> |    2 | DEVICE     |
> |    3 | COUNT(7:0) |
> +------+------------+
> 
> SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
> field starts at byte 3 in sense buffer resulting in the following offsets
> for the ATA PASS-THROUGH commands:
> 
> +------------+-------------------------+
> |   Field    |  Offset in sense buffer |
> +------------+-------------------------+
> | ERROR      |  3                      |
> | STATUS     |  4                      |
> | DEVICE     |  5                      |
> | COUNT(7:0) |  6                      |
> +------------+-------------------------+
> 
> COMMAND-SPECIFIC INFORMATION
> ============================
> 
> SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
> field for ATA PASS-THROUGH" defines the following format:
> 
> +------+-------------------+
> | Byte |        Field      |
> +------+-------------------+
> |    0 | FLAGS | LOG INDEX |
> |    1 | LBA (7:0)         |
> |    2 | LBA (15:8)        |
> |    3 | LBA (23:16)       |
> +------+-------------------+
> 
> SPC-6 Table 48 - "Fixed format sense data" specifies that
> the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
> in sense buffer resulting in the following offsets for
> the ATA PASS-THROUGH commands:
> 
> Offsets of these fields in the fixed sense format are as follows:
> 
> +-------------------+-------------------------+
> |       Field       |  Offset in sense buffer |
> +-------------------+-------------------------+
> | FLAGS | LOG INDEX |  8                      |
> | LBA (7:0)         |  9                      |
> | LBA (15:8)        |  10                     |
> | LBA (23:16)       |  11                     |
> +-------------------+-------------------------+
> 
> Reported-by: Akshat Jain <akshatzen@google.com>
> Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
> Cc: stable@vger.kernel.org
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index bb4d30d377ae..a9e44ad4c2de 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
>  	unsigned char *sb = cmd->sense_buffer;
> -	unsigned char *desc = sb + 8;
>  	u8 sense_key, asc, ascq;
>  
>  	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> @@ -877,7 +876,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
>  	}
>  
> -	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
> +	if ((sb[0] & 0x7f) >= 0x72) {
> +		unsigned char *desc;
>  		u8 len;
>  
>  		/* descriptor format */
> @@ -916,21 +916,21 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  		}
>  	} else {
>  		/* Fixed sense format */
> -		desc[0] = tf->error;
> -		desc[1] = tf->status;
> -		desc[2] = tf->device;
> -		desc[3] = tf->nsect;
> -		desc[7] = 0;
> +		sb[0] |= 0x80;
> +		sb[3] = tf->error;
> +		sb[4] = tf->status;
> +		sb[5] = tf->device;
> +		sb[6] = tf->nsect;
>  		if (tf->flags & ATA_TFLAG_LBA48)  {
> -			desc[8] |= 0x80;
> +			sb[8] |= 0x80;
>  			if (tf->hob_nsect)
> -				desc[8] |= 0x40;
> +				sb[8] |= 0x40;
>  			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> -				desc[8] |= 0x20;
> +				sb[8] |= 0x20;
>  		}
> -		desc[9] = tf->lbal;
> -		desc[10] = tf->lbam;
> -		desc[11] = tf->lbah;
> +		sb[9] = tf->lbal;
> +		sb[10] = tf->lbam;
> +		sb[11] = tf->lbah;
>  	}
>  }
>  
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

