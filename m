Return-Path: <stable+bounces-47754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5D8D56B8
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF844288DC4
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 00:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B2A3D;
	Fri, 31 May 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1YPswiZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA8360;
	Fri, 31 May 2024 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113744; cv=none; b=obKl/9NJsd9xKPjlxtIILC3Z3wQEJrxVuWZbRQWa7cI4hyeNZ7YWZN97LnfD4rsw8yZ99ROcJPvIWGZr6Hs3E642LUMEYCMePy5x4vFHUffj1R3t5kUTh0O2w0q7R71xxKbZpCdfiDqtYkybYLxENrEvwBZ6Us1d4RZbj/gvlds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113744; c=relaxed/simple;
	bh=qA52jxsTXnijAkDZ8KGetiOchNqZkYViXYbZ0F/0E/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L94xJKFf0Lm8FHJGNKpjeMeuV8oHKTSVdni54kiQp2OSrjLbKHAS0c3CxXsGjHl4oK1rAkAgvyJr+Wc+PR9uIt8yuC9n56yxYOyztUmv8BCmtWtb80wsOLzttsB4X38eqOJBnTiHKpTBkoI/eDWCiXT3TA/ZWgM6GQpFNitk5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1YPswiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C2C2BBFC;
	Fri, 31 May 2024 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717113743;
	bh=qA52jxsTXnijAkDZ8KGetiOchNqZkYViXYbZ0F/0E/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u1YPswiZdp3aVsK/yKRVZTv6ENlVMN59nZqN90YwpP/K2eFqFT0Om3zCjvhDHDvTO
	 1QXCCnZAB6OsHs5x3UFuM5fsdj5Yg8iU/sdA6hudsK6UH3gaNoRchG/s02wxiLGc6o
	 2RbU92HyZwaWIMN+paY5p3QD2tNU4ZpaissSWCqMQB3l2YZpgP4sid1w7n/sNFBDKq
	 6grGphblA0zSZmslnfaCV2E84eMp1xdYogMik4qVVJUehi4tUx6dt/pBi1yAuD7muw
	 +uzHm2m81P3G2/CYs6uuxFKNFvilY9BrcBcCLrMXnZ6pspODcRNJzo+PaaRHy/bBtc
	 9S2T8zrgeB0/A==
Message-ID: <e5ba5188-c577-4fa4-9a82-bf457595f0b6@kernel.org>
Date: Fri, 31 May 2024 09:02:21 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon S3
 SSD
To: Niklas Cassel <cassel@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jian-Hong Pan <jhp@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org, Doru Iorgulescu <doru.iorgulescu1@gmail.com>,
 linux-ide@vger.kernel.org
References: <20240530213244.562464-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240530213244.562464-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 6:32 AM, Niklas Cassel wrote:
> Commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> dropped the board_ahci_low_power board type, and instead enables LPM if:
> -The AHCI controller reports that it supports LPM (Partial/Slumber), and
> -CONFIG_SATA_MOBILE_LPM_POLICY != 0, and
> -The port is not defined as external in the per port PxCMD register, and
> -The port is not defined as hotplug capable in the per port PxCMD
>  register.
> 
> Partial and Slumber LPM states can either be initiated by HIPM or DIPM.
> 
> For HIPM (host initiated power management) to get enabled, both the AHCI
> controller and the drive have to report that they support HIPM.
> 
> For DIPM (device initiated power management) to get enabled, only the
> drive has to report that it supports DIPM. However, the HBA will reject
> device requests to enter LPM states which the HBA does not support.
> 
> The problem is that AMD Radeon S3 SSD drives do not handle low power modes
> correctly. The problem was most likely not seen before because no one
> had used this drive with a AHCI controller with LPM enabled.
> 
> Add a quirk so that we do not enable LPM for this drive, since we see
> command timeouts if we do (even though the drive claims to support DIPM).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Doru Iorgulescu <doru.iorgulescu1@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


