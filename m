Return-Path: <stable+bounces-87819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3339AC86F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174401C22A8F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8E1A2C0E;
	Wed, 23 Oct 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfwG1xO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFB19D075;
	Wed, 23 Oct 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681270; cv=none; b=BFZCgw/nEeGZ8B3MR7eZuPCzD9hWBvHNQeMhW2HYe/cjnVnPreq32GCEqTatNJG28+WV9yQGmbrN71NtC1opkPhHzSU+e3D/QsWtdHV6aSqFauVKdlZ2pBc6LylGYof8SdWqRsOznqMP3oN+PutvASdvHALu0FSKRVLcMSdoKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681270; c=relaxed/simple;
	bh=y/IT6jMjg+YMellE79DidjA7dGQm7oRdSPloo0dXCJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY9P47aqE1C0NSO3ZDBY8GuY/FA5GluYaZNmEf+6Nlua/trcscQPAgJoL8YvWRAyl1X+BmKbSpYLoML6Q+Eh6dci5JlD+wegsd7BW4fBPbEcBZkGomVFNzZ2jPrsRAnd4bD8070nGsBRZVcrGw6AQ66giD5TYe2S8GD/GyX7dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfwG1xO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EACDC4CEC6;
	Wed, 23 Oct 2024 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729681269;
	bh=y/IT6jMjg+YMellE79DidjA7dGQm7oRdSPloo0dXCJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfwG1xO36emSutGFtVdSCOJkaftuw5SxNRQDlGas4TE0xmvyGFWnRr27vXcwpnN2c
	 bvzbcDqoncQH9EhTKD8Sr0Lgf+txltYVyeHhJ+3XF0g+3nj1+nsYZZJzXzw0Q+EGGq
	 dMpaKU0z4pAZrUdQ7w2beBjg7NeZXXWReJqrveIbHz3ovNsyD+e+wWUsopcrps0TZr
	 xe2n8fmMEDVdaxhIPWsjWSF5n4EAfnu28vR0RNiRkegi5SNCA/C6HBVCF4Fb2+lt6x
	 6o0hEic+XACFm8wxIggeZmeuGmfA+qHXoeWO9M/gUx37E9n/s2zJtJwlT88FDtRn6t
	 G+VQlmzu1qo8w==
Date: Wed, 23 Oct 2024 13:01:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org,
	"Lai, Yi" <yi1.lai@linux.intel.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata: Set DID_TIME_OUT for commands that actually
 timed out
Message-ID: <ZxjXcR3lvReq8fuj@ryzen>
References: <20241023105540.1070012-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023105540.1070012-2-cassel@kernel.org>

On Wed, Oct 23, 2024 at 12:55:41PM +0200, Niklas Cassel wrote:
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

"if the command has either FAILFAST flag set or if ..."

I could fix up this sentence when applying.


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
> -- 
> 2.47.0
> 

