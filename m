Return-Path: <stable+bounces-208362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE17D1F637
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B371A30A5B56
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29D72E173D;
	Wed, 14 Jan 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIMveaD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B52DC328;
	Wed, 14 Jan 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400270; cv=none; b=NytnAxEGxPJ4a9kO5hxX4I+aXRAWlGZies6JWw/ZNq6AF3PT1oSV34jEOcuRe/X3L4B9B84jBpEnVWgWUrY5/VNyor7U5zRhTT/JZEMDw31MYsnHRjCK6uWmyaXFxLyN/xdkG0B6BI/oc+00NNdZ8aH8REDzJxuRS/o/qOjpWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400270; c=relaxed/simple;
	bh=FhhEG9/ujbm4GR2q9EIOwLbYrd9vR9jJMCVNgoKqQ98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe9mAqZEX2YjuusnFgm/LARgWSumpr3DzSwnV6NxoXMAECAwgWZNNNCDXlGYIwtPG12wFoklsle6bxJ1rAq1EN9N3fB8Y80MojU/TLqxo3aJWWaMYsbrCu4kwxYu6F6iPmrtlry9HA/GUTiye0uRcTHziEbWhWysmxw2AaobHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIMveaD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A4FC16AAE;
	Wed, 14 Jan 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400270;
	bh=FhhEG9/ujbm4GR2q9EIOwLbYrd9vR9jJMCVNgoKqQ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIMveaD2pXO28a6VXVUq4Q8/L00siyXZJfN1GANwUX9+iOK/cLA1N5e8X5lpjpTAS
	 xtJ/0N3W9b11v8tEaLSbderGSWVxBEf4nzP0ksdAcRmAnX9go2O+QFyJcB8ljSe9kW
	 bTyxJIlTuIsOCj7Rv+54bPBla+/0IOeNAMjNaLRYWL1hn2XddI0045L988bF7eMZLP
	 DwkoZsiu/F4kgOrj0rChgpSV9YnxlCauija0NxrRREzlDkT5U+VeesD0Tlr/C5xAqP
	 qaQw5FaJiU6Y33zAGWYvQ5EsIps8LGamwDxcAncSMhFKkKHxDiaEVcLetma7SM7Jsh
	 0TriW904aCRIA==
Date: Wed, 14 Jan 2026 15:17:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	1120831@bugs.debian.org, snow.wolf.29@proton.me,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [regression] failed command: READ FPDMA QUEUED after boot for
 INTEL SSDSC2KG480G8, XCV10120 after 9b8b84879d4a ("block: Increase
 BLK_DEF_MAX_SECTORS_CAP")
Message-ID: <aWelaQYNJyulLBVc@ryzen>
References: <176839089913.2398366.61500945766820256@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176839089913.2398366.61500945766820256@eldamar.lan>

Hello Salvatore,

On Wed, Jan 14, 2026 at 12:47:45PM +0100, Salvatore Bonaccorso wrote:
> A user reported a regression affecting his devices after 9b8b84879d4a
> ("block: Increase BLK_DEF_MAX_SECTORS_CAP") which maybe needs a
> similar quirk like 2e9832713631 ("ata: libata-core: Quirk DELLBOSS VD
> max_sectors").

The drive:
> Dec 10 18:56:03 kernel: ata1.00: Model 'INTEL SSDSC2KG480G8', rev 'XCV10120', applying quirks: zeroaftertrim
> Dec 10 18:56:03 kernel: ata1.00: ATA-10: INTEL SSDSC2KG480G8, XCV10120, max UDMA/133

The SATA controller:
00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller [8086:a353] (rev 10) (prog-if 01 [AHCI 1.0])
	DeviceName: Onboard - SATA
	Subsystem: Dell Device [1028:0924]


Perhaps the user could run:
https://github.com/floatious/max-sectors-quirk/blob/master/find-max-sectors.sh

So we could find which max sectors value we should quirk the device with,
since while the drive obviously chokes on a command of size 4 MiB / 8192
sectors, it might be able to handle something larger than 1280 KiB / 2560
sectors.


Kind regard,
Niklas

