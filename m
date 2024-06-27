Return-Path: <stable+bounces-55962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7591A642
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087111C210C9
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858B15216F;
	Thu, 27 Jun 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlQkpVbB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570B149009;
	Thu, 27 Jun 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490135; cv=none; b=HHrwfOsGHJ6MkT8/mnDZWO/jYWFr8jwBQZDhJFnVOxyQw3+ON0YbH5Zl8fQ0mSqpcxh+Oc0G2wM2axqc5tm9vlwbxPOMu6zLFc7mni9GI+bVouItJfzs9sCrZV+jPbNpY5rmKU0oSbQnDPlcS/rIG0fwWXJctyFe9BcEpf7rXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490135; c=relaxed/simple;
	bh=UB7x0u5Q/iMDfo1+7Br2MMRSaiMusyQx9H/tIR4MZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPTtxCYTpWUJ5TzYayH8GUYn0URH4RLTjkOIJp1YzU2aFLZvBaUqk0lqTR3UYNU6kLH5DDnbR32BarOdMfHiHnaCOE8mM14F4jWOCtea7DrgLSxw3b7hX63dIp4vy7HQJPkgSAy357+kQkPVYH9JJFhAzR2/0LcocThFyEqIa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlQkpVbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F335C2BBFC;
	Thu, 27 Jun 2024 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719490135;
	bh=UB7x0u5Q/iMDfo1+7Br2MMRSaiMusyQx9H/tIR4MZpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlQkpVbB3MLDEBXq3T/QVIeCquelKSLZ8y9uAjwvxMIxQ+bMCxz89ZhAlEcJuSuhW
	 RczOf1JESWNdj3pV7gMpFpD2ETVfoZhRCx6WgefwO/Duwl2EqaRwONjFWgypy0VFqG
	 zJ/cmK3EhefY9IaDr7CiburLpa/j/RKkx0CWWEdmnIg8YOHbQeA5rnJzADU64olSqA
	 ctwJVw9E21YOyBVbJxdPbCP88xsq1/i0qrqbBVCsYolcg+epU1uKrUb6A15CBf9+WZ
	 hMd7YyGl4jSF9BHSSEaSGIyL4qEm32u8eY2MK349MZVK8gjnJZYHXhsZz8BquYKX4n
	 Z2+cpCJWchNSA==
Date: Thu, 27 Jun 2024 14:08:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <Zn1WUhmLglM4iais@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626230411.3471543-2-ipylypiv@google.com>

Hello Igor, Hannes,

The changes in this patch looks good, however, there is still one thing that
bothers me:
https://github.com/torvalds/linux/blob/v6.10-rc5/drivers/ata/libata-scsi.c#L873-L877

Specifically the code in the else statement below:

	if (qc->err_mask ||
	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
				   &sense_key, &asc, &ascq);
		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
	} else {
		/*
		 * ATA PASS-THROUGH INFORMATION AVAILABLE
		 * Always in descriptor format sense.
		 */
		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
	}

Looking at sat6r01, I see that this is table:
Table 217 — ATA command results

And this text:
No error, successful completion or command in progress. The SATL
shall terminate the command with CHECK CONDITION status with
the sense key set to RECOVERED ERROR with the additional
sense code set to ATA PASS-THROUGH INFORMATION
AVAILABLE (see SPC-5). Descriptor format sense data shall include
the ATA Status Return sense data descriptor (see 12.2.2.7).

However, I don't see anything in this text that says that the
sense key should always be in descriptor format sense.

In fact, what will happen if the user has not set the D_SENSE bit
(libata will default not set it), is that:

The else statement above will be executed, filling in sense key in
descriptor format, after this if/else, we will continue checking
if the sense buffer is in descriptor format, or fixed format.

Since the scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
is called with (..., 1, ..., ..., ...) it will always generate
the sense data in descriptor format, regardless of
dev->flags ATA_DFLAG_D_SENSE being set or not.

Should perhaps the code in the else statement be:

} else {
	ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
}

So that we actually respect the D_SENSE bit?

(We currently respect if when filling the sense data buffer with
sense data from REQUEST SENSE EXT, so I'm not sure why we shouldn't
respect it for successful ATA PASS-THROUGH commands.)


Kind regards,
Niklas

