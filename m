Return-Path: <stable+bounces-69426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18409956036
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 01:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397111C20EF4
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C051155A3C;
	Sun, 18 Aug 2024 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMIW7gbr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2541A291;
	Sun, 18 Aug 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025354; cv=none; b=jNiKTrMqYXbqs07RFppbhAf1LtQ+mXPxgBRrAqmjXclS09wwUSIQliIwKa27f1faN1cey5SNg9pmZaJg+Boz4SPPQKDYSQGS3HNUcejBPn2mStsvEWqFSDSkDsCoH087zCLnezXz53j2BWL+xIzttmQfZnR9mrCqDEWdz6mfJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025354; c=relaxed/simple;
	bh=XBPgRajQMF3kBFF2qXNj8VIXdwJb8ZAa2UAOgGyhnlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EU903+mCb2tZCkzDA7GDbWdBR4Kj5+JVNRokR77mhtUh/XwbG7dnbppCXiI66Ic6vbBOsl5mquktsCywvRtN1OZPobIn1uxsKoqGECSeSldERCkmoVJAwr5YE21nNPTSAPGlsoSkRhnK8HZFTLLcPyzIQ5FoMj4gKGNkxCTd+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMIW7gbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C2CC4AF0E;
	Sun, 18 Aug 2024 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724025353;
	bh=XBPgRajQMF3kBFF2qXNj8VIXdwJb8ZAa2UAOgGyhnlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RMIW7gbrHXOXxlWvy2z71DdGHQqWFV++aLjZnN0rA4Nu5ainHsPu70FobMhcYQegb
	 zxV9BCzm1Tuj/hb5wDHJu9mraFrcXlm8CXhyi+dxODxyFKRAtO57jAU+TfqJ1qgrZz
	 mNSJSq82IaRqlN+lj2H1sr1M+mEV4VvYp9Y3XfaXtYDF6anoy4/0ZbTGSvL2RnXsCy
	 26gTjrw3zyAnBl1WYlObfLeGOHAtah2gyPbV//+HgOhdRa+0tixoGRUrmNrmkMzZfW
	 x7B2xRqUPCOTK4b5dUnXRjf8zP/w5QF6EA9Jr5AYx8ZnMk0U/oXrIT65SMFJ1Q8s6l
	 sY0E8RCWVgykA==
Message-ID: <10c56cbc-a367-44c3-8b14-b846a3c4e4a0@kernel.org>
Date: Mon, 19 Aug 2024 08:55:51 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: sd: retry command SYNC CACHE if format in
 progress
To: Yihang Li <liyihang9@huawei.com>, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bvanassche@acm.org, linuxarm@huawei.com, prime.zeng@huawei.com,
 stable@vger.kernel.org
References: <20240817015019.3467765-1-liyihang9@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240817015019.3467765-1-liyihang9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/24 10:50, Yihang Li wrote:
> If formatting a suspended disk (such as formatting with different DIF
> type), the disk will be resuming first, and then the format command will
> submit to the disk through SG_IO ioctl.
> 
> When the disk is processing the format command, the system does not submit
> other commands to the disk. Therefore, the system attempts to suspend the
> disk again and sends the SYNC CACHE command. However, the SYNC CACHE

Why would the system try to suspend the disk with a request in flight ? Sounds
like there is a bug with PM reference counting, no ?

> command will fail because the disk is in the formatting process, which
> will cause the runtime_status of the disk to error and it is difficult
> for user to recover it. Error info like:
> 
> [  669.925325] sd 6:0:6:0: [sdg] Synchronizing SCSI cache
> [  670.202371] sd 6:0:6:0: [sdg] Synchronize Cache(10) failed: Result: hostbyte=0x00 driverbyte=DRIVER_OK
> [  670.216300] sd 6:0:6:0: [sdg] Sense Key : 0x2 [current]
> [  670.221860] sd 6:0:6:0: [sdg] ASC=0x4 ASCQ=0x4
> 
> To solve the issue, retry the command until format command is finished.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yihang Li <liyihang9@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> Changes since v3:
> - Add Cc tag for kernel stable.
> 
> Changes since v2:
> - Add Reviewed-by for Bart.
> 
> Changes since v1:
> - Updated and added error information to the patch description.
> 
> ---
>  drivers/scsi/sd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index adeaa8ab9951..5cd88a8eea73 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1823,6 +1823,11 @@ static int sd_sync_cache(struct scsi_disk *sdkp)
>  			    (sshdr.asc == 0x74 && sshdr.ascq == 0x71))	/* drive is password locked */
>  				/* this is no error here */
>  				return 0;
> +
> +			/* retry if format in progress */
> +			if (sshdr.asc == 0x4 && sshdr.ascq == 0x4)
> +				return -EBUSY;
> +
>  			/*
>  			 * This drive doesn't support sync and there's not much
>  			 * we can do because this is called during shutdown

-- 
Damien Le Moal
Western Digital Research


