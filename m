Return-Path: <stable+bounces-195219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08087C71FEE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 04:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8D94346670
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BE298CB2;
	Thu, 20 Nov 2025 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sedr4ZvS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F261CEADB;
	Thu, 20 Nov 2025 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609601; cv=none; b=u+vu7rMXGQEvwJdj2rLJpPj0ofRgfV8W6d+ljoh7B1C+8Ig4gwP8msWJiIALj5qv2xr3b9tdsNjBnn3Jig3+aQX8tT5+SSeea+c/PpNoyjneDyCVG7CkTflBsrXhjCFBBpS9bbrXc8SWHe6wMzNpqFguZFjufbegh5+vFatwPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609601; c=relaxed/simple;
	bh=ThChOhFBo8fuy9hm3jBvNhyeCuXV6lWU90VSlTkk1yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucGmuzJYscmeDSzsaP+KjePAmhV55Iedzs6N+lBpIQcnzEygAwImhFM2ea6ogie0jVf46TvUuJiUkCah0NGljBAVM1s+ywhvFEEPdgvvCeVLLpdxg+55xSqDREfy3O6kaTV+2wG1NMMxd3cH7ixbX+TDUnxHNYdcGEuY9dVJyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sedr4ZvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DABDC4CEF5;
	Thu, 20 Nov 2025 03:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763609601;
	bh=ThChOhFBo8fuy9hm3jBvNhyeCuXV6lWU90VSlTkk1yI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sedr4ZvSOzm6Jn3+0Mk+BVD7y4K7ORsJ2sPtDk2JTw9rmYx+8cPbMOzqFH4G6g/uA
	 2k7x+kvmHy/OaAC1dspcYIpaTEmvUdqQVgAM0LfsDEeIMfftZDe1ubpQ/9iRXXKrVX
	 aU4xP+TAYtAYsmNiaykE98YaNa1fyozmB8pacESi4K8ZL39gZk1XTS3sEdoBGhrePd
	 ykl+1NrqfHekkbmDI7fUscBQpKjAFQZyomY2RYbiVzedleGGxZPtiEmvg2+b6YMGvI
	 gzBd7Kkw2mIDJjXVB4CmlyMosb2L3wn3N643H6CL5AotbvdAGnufx+CUx9ZcDz8SFW
	 +c1hK3J/ikDNQ==
Message-ID: <a131abb5-b79b-4a22-a768-55db348b1bde@kernel.org>
Date: Thu, 20 Nov 2025 12:29:14 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix system suspend for a security
 locked drive
To: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ilia Baryshnikov <qwelias@gmail.com>, stable@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <20251119141313.2220084-3-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251119141313.2220084-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:13 PM, Niklas Cassel wrote:
> Commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status
> handling") fixed ata_to_sense_error() to properly generate sense key
> ABORTED COMMAND (without any additional sense code), instead of the
> previous bogus sense key ILLEGAL REQUEST with the additional sense code
> UNALIGNED WRITE COMMAND, for a failed command.
> 
> However, this broke suspend for Security locked drives (drives that have
> Security enabled, and have not been Security unlocked by boot firmware).
> 
> The reason for this is that the SCSI disk driver, for the Synchronize
> Cache command only, treats any sense data with sense key ILLEGAL REQUEST
> as a successful command (regardless of ASC / ASCQ).
> 
> After commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error()
> status handling") the code that treats any sense data with sense key
> ILLEGAL REQUEST as a successful command is no longer applicable, so the
> command fails, which causes the system suspend to be aborted:
> 
>   sd 1:0:0:0: PM: dpm_run_callback(): scsi_bus_suspend returns -5
>   sd 1:0:0:0: PM: failed to suspend async: error -5
>   PM: Some devices failed to suspend, or early wake event detected
> 
> To make suspend work once again, for a Security locked device only,
> return sense data LOGICAL UNIT ACCESS NOT AUTHORIZED, the actual sense
> data which a real SCSI device would have returned if locked.
> The SCSI disk driver treats this sense data as a successful command.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Ilia Baryshnikov <qwelias@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220704
> Fixes: cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status handling")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

I think that adding this to ata_scsi_flush_xlat() would be better, but this way
may be able to catch more cases like sync failure. So for now, let's go with this.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

