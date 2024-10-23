Return-Path: <stable+bounces-87823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1949AC95E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECC728694E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA315B0E2;
	Wed, 23 Oct 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw2ZaQuy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ABE156F28;
	Wed, 23 Oct 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684039; cv=none; b=tMS6NEkGMkgoafxUsz3AnWkxdvg3kYe4SihDQl2h2mmyZB9RxwUbacEC0b3P1YIoPO3pzHf+aDF8flsHp/H54liSiR/IleXqTV45eqXGUdpStSf+955/tEGytzIbQ0yeZKxua0AGBkOzZ4OIG3c/q23DIm/eUH8+kVZrlqSncug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684039; c=relaxed/simple;
	bh=9kTC8LDj7LFenRbZOOHgmqPR2KFGUyQiIpPsHo8Adso=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cUh0HI8Pz/O9Xl5dt8A/niA1yPAevJmyQnFaH7JRpYMbawkgUWZy3MkGNwCEbJuQ7PGEircCv7UEflakcseFaQecpXd6+0tqMHN4s/RLHBp7YTHcPyos2W4NatbQnaC3SLJ2Bid2CeOqnWp4DCHxnHhkxgpjWSPdLyeOKIz3YNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw2ZaQuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956E4C4CEC6;
	Wed, 23 Oct 2024 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684038;
	bh=9kTC8LDj7LFenRbZOOHgmqPR2KFGUyQiIpPsHo8Adso=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Bw2ZaQuyRI04DVoDdTBjxobVftPsPwWA7oVddQjok/UlT4IT7kSoraT3uccL+Ma0B
	 0gq14WPZPPiGEZuS0onkS1pcsNaVqwiqKf/Ki2UbHyZAwbGTWnWGeknjQrQ5oJ8ja4
	 Xe99fd+W93v/kSR2kr3q5WMOPKINo9oZLnMmXotjsf3s5FMKmRIPQIddezJM5yFuyd
	 oO705o0GhEHGtgOUldkNCfsJn7bUsmHj2QVhR5dHzJQRTZJ5ZDkZ9AXhZvXH9eaA54
	 PCI+/I/WDwUbnFdmD8ekT+3GhsiCSmyVNObdMxN3UlQl+DkmF2XAmnLH22gp6doiTX
	 XcdbHYziu+aXw==
Message-ID: <048a435c-367e-45fd-a00d-56c79870b9b7@kernel.org>
Date: Wed, 23 Oct 2024 20:47:16 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] ata: libata: Set DID_TIME_OUT for commands that actually
 timed out
To: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org,
 "Lai, Yi" <yi1.lai@linux.intel.com>, linux-ide@vger.kernel.org
References: <20241023105540.1070012-2-cassel@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241023105540.1070012-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 19:55, Niklas Cassel wrote:
> When ata_qc_complete() schedules a command for EH using
> ata_qc_schedule_eh(), blk_abort_request() will be called, which leads to
> req->q->mq_ops->timeout() / scsi_timeout() being called.
> 
> scsi_timeout(), if the LLDD has no abort handler (libata has no abort
> handler), will set host byte to DID_TIME_OUT, and then call
> scsi_eh_scmd_add() to add the command to EH.
> 
> Thus, when commands first enter libata's EH strategy_handler, all the
> commands that have been added to EH will have DID_TIME_OUT set.
> 
> Commit e5dd410acb34 ("ata: libata: Clear DID_TIME_OUT for ATA PT commands
> with sense data") clears this bogus DID_TIME_OUT flag for all commands
> that reached libata's EH strategy_handler.
> 
> libata has its own flag (AC_ERR_TIMEOUT), that it sets for commands that
> have not received a completion at the time of entering EH.
> 
> ata_eh_worth_retry() has no special handling for AC_ERR_TIMEOUT, so by
> default timed out commands will get flag ATA_QCFLAG_RETRY set and will be
> retried after the port has been reset (ata_eh_link_autopsy() always
> triggers a port reset if any command has AC_ERR_TIMEOUT set).
> 
> For commands that have ATA_QCFLAG_RETRY set, but also has an error flag
> set (e.g. AC_ERR_TIMEOUT), ata_eh_finish() will not increment
> scmd->allowed, so the command will at most be retried (scmd->allowed
> number of times, which by default is set to 3).
> 
> However, scsi_eh_flush_done_q() will only retry commands for which
> scsi_noretry_cmd() returns false.
> 
> For commands that has DID_TIME_OUT set, if the command is either
> has FAILFAST or if the command is a passthrough command, scsi_noretry_cmd()
> will return true. Thus, such commands will never be retried.
> 
> Thus, make sure that libata sets SCSI's DID_TIME_OUT flag for commands that
> actually timed out (libata's AC_ERR_TIMEOUT flag), such that timed out
> commands will once again not be retried if they are also a FAILFAST or
> passthrough command.
> 
> Cc: stable@vger.kernel.org
> Fixes: e5dd410acb34 ("ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data")
> Reported-by: Lai, Yi <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/linux-ide/ZxYz871I3Blsi30F@ly-workstation/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/ata/libata-eh.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index fa41ea57a978..3b303d4ae37a 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -651,6 +651,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  			/* the scmd has an associated qc */
>  			if (!(qc->flags & ATA_QCFLAG_EH)) {
>  				/* which hasn't failed yet, timeout */
> +				set_host_byte(scmd, DID_TIME_OUT);
>  				qc->err_mask |= AC_ERR_TIMEOUT;
>  				qc->flags |= ATA_QCFLAG_EH;
>  				nr_timedout++;


-- 
Damien Le Moal
Western Digital Research

