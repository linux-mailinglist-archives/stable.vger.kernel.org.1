Return-Path: <stable+bounces-53800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04990E71A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C961C20AF2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94F7E78E;
	Wed, 19 Jun 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0UA7Fa/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C75D78C91
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789454; cv=none; b=maEW4Kb9Z6qt0C8G5Pa/dbvIdSO8b59yesaqY9EQB9ACo0HyRjdzV2PaDIpOQFlqmN9ka4IEhRrSztPQ+5LRd0KjrnoC7CXCAaykSYuGfcLUHxFtbODS4INVt0uid7vdQrYwT3Ao1ae71DsECvF1Qunxr/EOvu/MsKwOjXe2RM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789454; c=relaxed/simple;
	bh=WrYh67gyZpTdbgQmoJs9dGlfImgBLdmRLfPZaKjZDvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJbDE72XMzeyCQQOZcBH+a66rWy1C4ppxZEX1+AxSiDiI2SW9sq4o0TZId3aFZ3z9H3e4wCuiSyS8l59L7pcxK8loHrrbhyCsOQVyC8YC3x/dYDy2OAICgJHHLhQgJlnttOYi51GmTenDhWImQ0GG02yUzUMbHr/PGla1NtCdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0UA7Fa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700C3C2BBFC;
	Wed, 19 Jun 2024 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718789453;
	bh=WrYh67gyZpTdbgQmoJs9dGlfImgBLdmRLfPZaKjZDvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0UA7Fa/nKEKuWBN2fpOSHVPBiA5FCLSAInYE/azsBX3XLO7hJfiMvAG5t95W1EGD
	 Fkw7dPEDQa4X0rx61g1ePnYd9mVs0Wowwj4Q5bvhN7jnLmlNuq2D1TCZ8blLNbX4er
	 Z1a5uei7P0wEIcP0CbLboDJzbu9WSqt5PyZmCM3g=
Date: Wed, 19 Jun 2024 11:30:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] scsi: mpi3mr: Fix ATA NCQ priority support
Message-ID: <2024061940-guidable-headband-eaff@gregkh>
References: <2024061714-judo-railway-20f6@gregkh>
 <20240618030345.485545-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618030345.485545-1-dlemoal@kernel.org>

On Tue, Jun 18, 2024 at 12:03:45PM +0900, Damien Le Moal wrote:
> Commit 90e6f08915ec6efe46570420412a65050ec826b2 upstream.
> 
> The function mpi3mr_qcmd() of the mpi3mr driver is able to indicate to
> the HBA if a read or write command directed at an ATA device should be
> translated to an NCQ read/write command with the high prioiryt bit set
> when the request uses the RT priority class and the user has enabled NCQ
> priority through sysfs.
> 
> However, unlike the mpt3sas driver, the mpi3mr driver does not define
> the sas_ncq_prio_supported and sas_ncq_prio_enable sysfs attributes, so
> the ncq_prio_enable field of struct mpi3mr_sdev_priv_data is never
> actually set and NCQ Priority cannot ever be used.
> 
> Fix this by defining these missing atributes to allow a user to check if
> an ATA device supports NCQ priority and to enable/disable the use of NCQ
> priority. To do this, lift the function scsih_ncq_prio_supp() out of the
> mpt3sas driver and make it the generic SCSI SAS transport function
> sas_ata_ncq_prio_supported(). Nothing in that function is hardware
> specific, so this function can be used in both the mpt3sas driver and
> the mpi3mr driver.
> 
> Reported-by: Scott McCoy <scott.mccoy@wdc.com>
> Fixes: 023ab2a9b4ed ("scsi: mpi3mr: Add support for queue command processing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Link: https://lore.kernel.org/r/20240611083435.92961-1-dlemoal@kernel.org
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> (cherry picked from commit 90e6f08915ec6efe46570420412a65050ec826b2)

Now queued up, thanks.

greg k-h

