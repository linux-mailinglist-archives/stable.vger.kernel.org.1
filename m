Return-Path: <stable+bounces-48278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2D8FE134
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492151F22E9E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64713F433;
	Thu,  6 Jun 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0ssImOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7613DB8D;
	Thu,  6 Jun 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663088; cv=none; b=F6wS1meRTNzU6a38xI9K1hB0DRNgzAK20yGdIcIGW8876d3Nt6w0BcQ+WaH7yF1uT1gJKGXnWmAM37sfH/66SXhGPAEW/0fnkHnDCbrRwnQvDVrj3sFtU7xbwcEoRSRmPHfwIQaLm+N+1/n7PWKAwa0loVulSer50V6qdEwM85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663088; c=relaxed/simple;
	bh=eZpkYN1My8L0alqfBripkdov+U6NwJDEvmRjW7H7TrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC+NsjHFEuH/wn9bEqply7gffMTOydT8RhN+PdIc1M4ZGhbV0wSBE+7Z55SLqnAt84VayEfhgpLf2QKcNbsvKboZSZiIhcHZcvYBrw2F5rHlMopRvR+sBpruCDaNBWNyebekCnw1H0BzTaXANmCjP3yO6hWrM9/OSXdlSVphHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0ssImOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43C2C4AF08;
	Thu,  6 Jun 2024 08:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717663087;
	bh=eZpkYN1My8L0alqfBripkdov+U6NwJDEvmRjW7H7TrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z0ssImOxCls3XktDCYRtinxWEpufX07d73sxQPBmsmiSTJdiqog1pXPRBfXvJAE1F
	 /qV1iyYYBd1CY7imDXH3RWCvRWB/JfVVUlLVPh8oLYsH7gtq1HQ8WTAzFRINBL1WIG
	 Lm+pluRreSS29ZCs4j0bc7d6RB0E2KUq1/eosEqEb2vOxTiRSDsEe0iJW4x9y94ieq
	 nGhVzqP1kdEp/nrXw5g3dUWiLA0+v7mrcg1i0T8TokYrma3NLYGFKsDyKsT9qu1Bf9
	 aARw43yl5+4xEQ+ZmQuK3nOMf9Jl3X6m/n1xX6j+FUyPg5e4xoaiZAN5t9VjX7NmyY
	 1o02QNKsrzcmg==
Message-ID: <610ee49c-e936-43d4-991e-c39dd0f439d3@kernel.org>
Date: Thu, 6 Jun 2024 17:38:05 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Koshutin <koshutin.pavel@yandex.ru>,
 lvc-project@linuxtesting.org, Artem Sadovnikov <ancowi69@gmail.com>,
 Mikhail Ivanov <iwanov-23@bk.ru>
References: <20240605213428.4040-1-mish.uxin2012@yandex.ru>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240605213428.4040-1-mish.uxin2012@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 6:34 AM, Mikhail Ukhin wrote:
> No upstream commit exists for this patch.
> 
> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
> ata_scsi_pass_thru.
> 
> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
> cmd field from struct scsi_request") upstream.
> Backporting this commit would require significant changes to the code so
> it is bettter to use a simple fix for that particular error.
> 
> The problem is that the length of the received SCSI command is not
> validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
> reading if the user sends a request with SCSI command of length less than
> 32.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
> Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
> ---
>  v2: The new addresses were added and the text was updated.
>  v3: Checking has been moved to the function ata_scsi_var_len_cdb_xlat at
>  the request of Damien Le Moal
>  drivers/ata/libata-scsi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index dfa090ccd21c..38488bd813d1 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3948,7 +3948,11 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
>  	struct scsi_cmnd *scmd = qc->scsicmd;
>  	const u8 *cdb = scmd->cmnd;
>  	const u16 sa = get_unaligned_be16(&cdb[8]);
> +	u8 scsi_op = scmd->cmnd[0];
>  
> +	if (scsi_op == VARIABLE_LENGTH_CMD && scmd->cmd_len < 32)

This functions is called only when the opcode is VARIABLE_LENGTH_CMD. So there
is no need to check that again.

> +        	return 1;
> +	
>  	/*
>  	 * if service action represents a ata pass-thru(32) command,
>  	 * then pass it to ata_scsi_pass_thru handler.

-- 
Damien Le Moal
Western Digital Research


