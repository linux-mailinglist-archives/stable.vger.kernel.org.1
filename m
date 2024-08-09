Return-Path: <stable+bounces-66274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2E94D232
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 16:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF53281B03
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE61DA53;
	Fri,  9 Aug 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4gbTjfj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2A946F;
	Fri,  9 Aug 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213817; cv=none; b=PVr1K8J4MhcOP3zFCS+vup+iKl7UdhY2eTSmdRPIRSlGZDQAVnNhuvHbcucCqeMQMBOm4qgWaqVxRjgl7IN9KrpeYCTVhsfxp7d+3mBkryE+MRuBX4P9yuTdhD5Jb1vAGKxivjq9FqVrjsyouZ7AHiM6p82cVSOVOfT3/bCQMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213817; c=relaxed/simple;
	bh=aGFkexEDKtcDtxI/9TDhesstY2pikbzLP7u4D0LRlUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmPLIKbneBVmlomrm8gaaIJJo67ow8ItvfulpgkiFr1iJ4imhwLRTDesmxv0whZ9GiCRWT2+s74DngqvTDniB3sNmWmh4Jrh+DTNJmj1zjF/OYT8FYWKp/7mVXUSVbWwb0z+2fYZ02KFCMDu/qIHKF3mKzQAPG+Ybicm9xZMpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4gbTjfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEF4C32782;
	Fri,  9 Aug 2024 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213817;
	bh=aGFkexEDKtcDtxI/9TDhesstY2pikbzLP7u4D0LRlUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4gbTjfjcsbCptOy4nBEML23fxmSs4nzwEezuzx4nEpGiIcSlj8CfC1iWEAyl88lb
	 gqPrKw779mt2r9rcDJ9slTW7IgclafZQdpUfujCGx3MUMU1TbFAnGdLJ+/2CBikGG0
	 RZbz/UzgzfZVDQFFDeuV/Go+RYikL/080j/3NT0DlLXkupyHtZlDzGiheRa5EFhUTx
	 xBAMpLssao0YJBHt57nW7yKKt+gepnLOpvu3Sr9GKYRB+9hAcVJD3k6kP7PgAlclJk
	 9nwbeAbohC+QKdUpjY3fjI3MEQexgejRVAuSSfosRmolBlJIP7FNt27/6kI5BWzOk+
	 fgoDE0vveVCkw==
Date: Fri, 9 Aug 2024 16:30:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>,
	Igor Pylypiv <ipylypiv@google.com>, linux-ide@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
Message-ID: <ZrYn9CL1uLJEwpdT@ryzen.lan>
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPw5m9LwMH5NQYy@x1-carbon.lan>

Hello Damien,

If we want to no longer respect the D_SENSE bit for successful ATA-passthrough
commands, e.g. by replacing the ata_scsi_set_sense() call with a
scsi_build_sense() call in the else clause:
https://github.com/torvalds/linux/blob/v6.11-rc2/drivers/ata/libata-scsi.c#L955

...then I think that we should also replace the ata_scsi_set_sense() call with
a scsi_build_sense() call for failed ATA-passthrough commands too
(in the non-else clause):
https://github.com/torvalds/linux/blob/v6.11-rc2/drivers/ata/libata-scsi.c#L952

..however, that does not sound like a very nice solution IMO.


Another option, if there are a lot of user space programs that incorrectly
assume that the sense data (for both successful and failed commands) is in
descriptor format, without bothering to check the sense data type, one option
might be to change the default value of D_SENSE in the control mode page to 1
in libata's SATL, i.e. set ATA_DFLAG_D_SENSE in dev->flags by default.

That way, we will still respect D_SENSE while generating the sense data
(in case the user issues a mode select to modify the bit), and the default
will be to generate the sense data in descriptor format, as it has been
since 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense").


Kind regards,
Niklas

