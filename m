Return-Path: <stable+bounces-56077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B23C91C2EC
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 17:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B4A282580
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F81C689D;
	Fri, 28 Jun 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE3fXaFx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3871DFFB;
	Fri, 28 Jun 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589768; cv=none; b=nuz95v3Y1uTb2PB+mFjEaZxw8Dh4OZHaUpSgQl9guqJxWnjr+qmY/L+SKKiGncd0lmrCBWPvqvjLyBKx23o9z8CpuJLjhS5AAtITPKrtyYCcHmbFlTjLQvLn9W7y3NSQUTgr4t91n07e352JhQNIkm+nx3IDLTqmfmJIOGk+DwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589768; c=relaxed/simple;
	bh=ZWoGkvRBYm3yrCpfNumHr+jeYorOXA8KfCQtFdrxRto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE7OFauP9daPLBqBObCCztEsoll9HXInzyY137KF4Hi4SgxzdmtKjbpaWYJh5C3UN6Y8ZuGY1wsn27+Q4veaNrPVZOzxeVcDWK2rGipD2zIruKmbj/JZcw3wUH23ecZpU6fuUgd00ULeocq7h74jssmDhBTYKM5xVukGPnkm1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE3fXaFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8394DC116B1;
	Fri, 28 Jun 2024 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719589767;
	bh=ZWoGkvRBYm3yrCpfNumHr+jeYorOXA8KfCQtFdrxRto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dE3fXaFx2mNsixe+U6jdMlDL61W8Nk4IFr2pIO8b/FxrrgR9ga30hkU9ShFVXOpBG
	 cAlpmWBXgXPvOYzCajKBwBcGUTlnZYqJs3N84N41v4NmPUVH2vmrnxlB+GK9XKj1WJ
	 CofTvM4pq09/HSqK5FukvkHHObuCximz2bRHIK+MpSkJO9F7pbOdVJ0BFLeXuR7dmg
	 fybWtOuZdZelwNOYwPqHDnEDQahC/FuGjBAZbAe5V7sXHpYt5wHAVszfF2eQWALQf+
	 CUPzW7JUMrS9kFPsm51mN8gB91qBcF7ZkM9hl4N0vWGp5OqoUoonq+VteYyatiTIUg
	 /GIfGVbjVU6AA==
Date: Fri, 28 Jun 2024 17:49:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <Zn7bghgsMR062xbb@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com>
 <Zn1WUhmLglM4iais@ryzen.lan>
 <0fbf1756-5b97-44fc-9802-d481190d2bd8@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fbf1756-5b97-44fc-9802-d481190d2bd8@suse.de>

On Fri, Jun 28, 2024 at 08:47:03AM +0200, Hannes Reinecke wrote:
> On 6/27/24 14:08, Niklas Cassel wrote:
> > Hello Igor, Hannes,
> > 
> > The changes in this patch looks good, however, there is still one thing that
> > bothers me:
> > https://github.com/torvalds/linux/blob/v6.10-rc5/drivers/ata/libata-scsi.c#L873-L877
> > 
> > Specifically the code in the else statement below:
> > 
> > 	if (qc->err_mask ||
> > 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> > 				   &sense_key, &asc, &ascq);
> > 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> > 	} else {
> > 		/*
> > 		 * ATA PASS-THROUGH INFORMATION AVAILABLE
> > 		 * Always in descriptor format sense.
> > 		 */
> > 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> > 	}
> > 
> > Looking at sat6r01, I see that this is table:
> > Table 217 — ATA command results
> > 
> > And this text:
> > No error, successful completion or command in progress. The SATL
> > shall terminate the command with CHECK CONDITION status with
> > the sense key set to RECOVERED ERROR with the additional
> > sense code set to ATA PASS-THROUGH INFORMATION
> > AVAILABLE (see SPC-5). Descriptor format sense data shall include
> > the ATA Status Return sense data descriptor (see 12.2.2.7).
> > 
> > However, I don't see anything in this text that says that the
> > sense key should always be in descriptor format sense.
> > 
> > In fact, what will happen if the user has not set the D_SENSE bit
> > (libata will default not set it), is that:
> > 
> > The else statement above will be executed, filling in sense key in
> > descriptor format, after this if/else, we will continue checking
> > if the sense buffer is in descriptor format, or fixed format.
> > 
> > Since the scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> > is called with (..., 1, ..., ..., ...) it will always generate
> > the sense data in descriptor format, regardless of
> > dev->flags ATA_DFLAG_D_SENSE being set or not.
> > 
> > Should perhaps the code in the else statement be:
> > 
> > } else {
> > 	ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
> > }
> > 
> > So that we actually respect the D_SENSE bit?
> > 
> > (We currently respect if when filling the sense data buffer with
> > sense data from REQUEST SENSE EXT, so I'm not sure why we shouldn't
> > respect it for successful ATA PASS-THROUGH commands.)
> > 
> I guess that we've misread the spec.

I think I might have an idea where you got this from:

In sat5r06.pdf
"""
12.2.2.8 Fixed format sense data

Table 212 shows the fields returned in the fixed format sense data (see SPC-5) for ATA PASS-THROUGH
commands. SATLs compliant with ANSI INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor
format sense data for the ATA PASS-THROUGH commands regardless of the setting of the D_SENSE bit.
"""

In sat6r01.pdf:
"""
12.2.2.8 Fixed format sense data

Table 219 shows the fields returned in the fixed format sense data (see SPC-5)
for ATA PASS-THROUGH
commands.
"""

In SAT-6 there is no mention of compliance with ANSI INCITS 431-2007 should
ignore D_SENSE bit and unconditionally return sense data in descriptor format.

Anyway, considering that:
1) I'm not sure how a SAT would expose that it is compliant with ANSI INCITS
   431-2007.
2) This text has been removed from SAT-6.
3) We currently honour the D_SENSE bit when creating the sense buffer with the
   SK/ASC/ASCQ that we get from the device.

I think that it makes sense to honour the D_SENSE bit also when generating
sense data for successful ATA PASS-THROUGH commands (from ATA registers).


Kind regards,
Niklas

