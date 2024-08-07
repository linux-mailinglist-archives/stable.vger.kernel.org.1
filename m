Return-Path: <stable+bounces-65948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A494AFAC
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F398BB26B79
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE314036D;
	Wed,  7 Aug 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNpUT1HT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA313F012;
	Wed,  7 Aug 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055208; cv=none; b=QppFfPORdAANrg5I4fiC+5cFasblKJwbzPghubuYH+Y+ffNRFmb6ggPkWo3xQzBDgtmVXteyoWDgDQ82At2c6K1XVGnwXHYFXuNAE/9vX/U6ruA2hoVe/S/ysnsjjxeCuIN+dg/d4nH7nSUsweezn0mgokypy44UtTefzP4kd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055208; c=relaxed/simple;
	bh=qiQ964hV5kDZS/RItHahPQgdcg5kxk6+8N4yNvf/Trg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceH+Otq0Sn8EDdMKSDBpVdEvmVOB1MOZXolwPo1dW/xwQ7DL31cOmoOgY8/VZ4aubxVGnKfmIuzvc1UvK396PbfItMEDqf1i+P90u9nL1qY7MEnY0RzrR6uYdus4CcBssyhpRdBD0a3BaGZvdB1pGtMUhUCVLOWY1f6qAB4EtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNpUT1HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36309C32781;
	Wed,  7 Aug 2024 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723055207;
	bh=qiQ964hV5kDZS/RItHahPQgdcg5kxk6+8N4yNvf/Trg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UNpUT1HTP3iOXlZ2uIs6pmVjUc0GPwhCg5jRbvrSz/cv0bQ2yn3Oem6Bfd4HGrCRs
	 0lXM8ecAkMOGThEgPNj3i2ZaoBvFUo2X94KRawQC+bHpYdN7AZDJs2iWBRfqbqHCr3
	 nR7h/ssu7CI0L1Ml/WxcPPNGtTE5p6cvFOw2i+toEnUTp0ZxJ/O4wdn8BFotivq63X
	 tvjtZ2ahT4hGZZzCPyVes3hxvoIwiN4zfQQZFrNW6Zp5sUV3iU2IQllGOSGAPzne8R
	 HKa6xL2cmInpcJGkwJR9H1KFfKhSDSXu/tL/iUzHgaBANbpVGcZ3GAav44O6mTBKPq
	 f0NUN9eGtyvyA==
Message-ID: <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
Date: Wed, 7 Aug 2024 11:26:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
To: Christian Heusel <christian@heusel.eu>, Igor Pylypiv
 <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/07 10:23, Christian Heusel wrote:
> Hello Igor, hello Niklas,
> 
> on my NAS I am encountering the following issue since v6.6.44 (LTS),
> when executing the hdparm command for my WD-WCC7K4NLX884 drives to get
> the active or standby state:
> 
>     $ hdparm -C /dev/sda
>     /dev/sda:
>     SG_IO: bad/missing sense data, sb[]:  f0 00 01 00 50 40 ff 0a 00 00 78 00 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>      drive state is:  unknown
> 
> 
> While the expected output is the following:
> 
>     $ hdparm -C /dev/sda
>     /dev/sda:
>      drive state is:  active/idle
> 
> I did a bisection within the stable series and found the following
> commit to be the first bad one:
> 
>     28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
> 
> According to kernel.dance the same commit was also backported to the
> v6.10.3 and v6.1.103 stable kernels and I could not find any commit or
> pending patch with a "Fixes:" tag for the offending commit.
> 
> So far I have not been able to test with the mainline kernel as this is
> a remote device which I couldn't rescue in case of a boot failure. Also
> just for transparency it does have the out of tree ZFS module loaded,
> but AFAIU this shouldn't be an issue here, as the commit seems clearly
> related to the error. If needed I can test with an untainted mainline
> kernel on Friday when I'm near the device.
> 
> I have attached the output of hdparm -I below and would be happy to
> provide further debug information or test patches.

I confirm this, using 6.11-rc2. The problem is actually hdparm code which
assumes that the sense data is in descriptor format without ever looking at the
D_SENSE bit to verify that. So commit 28ab9769117c reveals this issue because as
its title explains, it (correctly) honors D_SENSE instead of always generating
sense data in descriptor format.

Hmm... This is annoying. The kernel is fixed to be spec compliant but that
breaks old/non-compliant applications... We definitely should fix hdparm code,
but I think we still need to revert 28ab9769117c...

Niklas, Igor, thoughts ?

> 
> Cheers,
> Christian
> 
> ---
> 
> #regzbot introduced: 28ab9769117c
> #regzbot title: ata: libata-scsi: Sense data errors breaking hdparm with WD drives
> 
> ---
> 
> $ pacman -Q hdparm
> hdparm 9.65-2
> 
> $ hdparm -I /dev/sda
> 
> /dev/sda:
> 
> ATA device, with non-removable media
> 	Model Number:       WDC WD40EFRX-68N32N0
> 	Serial Number:      WD-WCC7K4NLX884
> 	Firmware Revision:  82.00A82
> 	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
> Standards:
> 	Used: unknown (minor revision code 0x006d) 
> 	Supported: 10 9 8 7 6 5 
> 	Likely used: 10
> Configuration:
> 	Logical		max	current
> 	cylinders	16383	0
> 	heads		16	0
> 	sectors/track	63	0
> 	--
> 	LBA    user addressable sectors:   268435455
> 	LBA48  user addressable sectors:  7814037168
> 	Logical  Sector size:                   512 bytes
> 	Physical Sector size:                  4096 bytes
> 	Logical Sector-0 offset:                  0 bytes
> 	device size with M = 1024*1024:     3815447 MBytes
> 	device size with M = 1000*1000:     4000787 MBytes (4000 GB)
> 	cache/buffer size  = unknown
> 	Form Factor: 3.5 inch
> 	Nominal Media Rotation Rate: 5400
> Capabilities:
> 	LBA, IORDY(can be disabled)
> 	Queue depth: 32
> 	Standby timer values: spec'd by Standard, with device specific minimum
> 	R/W multiple sector transfer: Max = 16	Current = 16
> 	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
> 	     Cycle time: min=120ns recommended=120ns
> 	PIO: pio0 pio1 pio2 pio3 pio4 
> 	     Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
> 	Enabled	Supported:
> 	   *	SMART feature set
> 	    	Security Mode feature set
> 	   *	Power Management feature set
> 	   *	Write cache
> 	   *	Look-ahead
> 	   *	Host Protected Area feature set
> 	   *	WRITE_BUFFER command
> 	   *	READ_BUFFER command
> 	   *	NOP cmd
> 	   *	DOWNLOAD_MICROCODE
> 	    	Power-Up In Standby feature set
> 	   *	SET_FEATURES required to spinup after power up
> 	    	SET_MAX security extension
> 	   *	48-bit Address feature set
> 	   *	Device Configuration Overlay feature set
> 	   *	Mandatory FLUSH_CACHE
> 	   *	FLUSH_CACHE_EXT
> 	   *	SMART error logging
> 	   *	SMART self-test
> 	   *	General Purpose Logging feature set
> 	   *	64-bit World wide name
> 	   *	IDLE_IMMEDIATE with UNLOAD
> 	   *	WRITE_UNCORRECTABLE_EXT command
> 	   *	{READ,WRITE}_DMA_EXT_GPL commands
> 	   *	Segmented DOWNLOAD_MICROCODE
> 	   *	Gen1 signaling speed (1.5Gb/s)
> 	   *	Gen2 signaling speed (3.0Gb/s)
> 	   *	Gen3 signaling speed (6.0Gb/s)
> 	   *	Native Command Queueing (NCQ)
> 	   *	Host-initiated interface power management
> 	   *	Phy event counters
> 	   *	Idle-Unload when NCQ is active
> 	   *	NCQ priority information
> 	   *	READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
> 	   *	DMA Setup Auto-Activate optimization
> 	   *	Device-initiated interface power management
> 	   *	Software settings preservation
> 	   *	SMART Command Transport (SCT) feature set
> 	   *	SCT Write Same (AC2)
> 	   *	SCT Error Recovery Control (AC3)
> 	   *	SCT Features Control (AC4)
> 	   *	SCT Data Tables (AC5)
> 	    	unknown 206[12] (vendor specific)
> 	    	unknown 206[13] (vendor specific)
> 	   *	DOWNLOAD MICROCODE DMA command
> 	   *	WRITE BUFFER DMA command
> 	   *	READ BUFFER DMA command
> Security: 
> 	Master password revision code = 65534
> 		supported
> 	not	enabled
> 	not	locked
> 		frozen
> 	not	expired: security count
> 		supported: enhanced erase
> 	504min for SECURITY ERASE UNIT. 504min for ENHANCED SECURITY ERASE UNIT.
> Logical Unit WWN Device Identifier: 50014ee2647735a1
> 	NAA		: 5
> 	IEEE OUI	: 0014ee
> 	Unique ID	: 2647735a1
> Checksum: correct

-- 
Damien Le Moal
Western Digital Research


