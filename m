Return-Path: <stable+bounces-47752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539BE8D56B4
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE769B25F13
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18617E9;
	Fri, 31 May 2024 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcND04y/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988443C099;
	Fri, 31 May 2024 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113648; cv=none; b=i0boRXLeSeUkfczMHGukpl6/Js+vfF1CCuX6KQy2jqBUBjx6WBw+Q+CALZ0Gdd7BPHaIwyAyWEJFtZH/3z1FvfukUrRppZV1jAxnOxKKmJ30jizYUgJos/Yd4jIqorfjuqQkjt+YxkBI0/5pjyVvfVU0Yi+GehWqHSYNSNyemTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113648; c=relaxed/simple;
	bh=H9wHMVMqkGB8t7ivnfp/RY3ryynAKFxKXyDGHu+Is1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQp6RC9cuWpuqHqdgVInXnuXh/aSxMRMEsjLfE0N1ULvk6XYjqVtrfwZqmxql41AumcRl9LC/SivptWbrKV6MQ/GoKmkjX1fF72hs1kSqqqnMI5ARrKNDY63jaH3Fj4EM7yrfRciXNO+2P805u+zDgpll5Y6TpMl5URLCZ24CGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcND04y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C60AC2BBFC;
	Fri, 31 May 2024 00:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717113648;
	bh=H9wHMVMqkGB8t7ivnfp/RY3ryynAKFxKXyDGHu+Is1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qcND04y/25JTbrDfBH+D+wtcgEP1kbqnJC8opMWg9WSlgl4YxaMyl9Dp0JwOWq3i+
	 NQhPn5OyookYh68IVrSHWkotN/v2Ijd8y21DinvdLzlQ3FayKWpbRpAUFKSDRI+1RE
	 NnG5dhDQwxizaVXcJ+39IT0DMmlCwmn4MBqT4S8jlC6nsD3UVNQAAdnrJCOaX+2xsn
	 EE/hlGR6Auclns5oums1uxbCgM61CfYKt0gIjK9TwajOMdXnqBS9phW+WCv7ZmkAw2
	 r+C2y9ZpK+qloq69mBRjn/WKB1h5m8Tc2A9llWlqWBMkhblJZN4RoFmme0GseXcm7u
	 Rz7joOwqnwRMw==
Message-ID: <c1a0a0b1-d3c0-409e-93e2-0dcf390a945b@kernel.org>
Date: Fri, 31 May 2024 09:00:46 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial
 CT240BX500SSD1
To: Niklas Cassel <cassel@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jian-Hong Pan <jhp@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org, Aarrayy <lp610mh@gmail.com>,
 linux-ide@vger.kernel.org
References: <20240530212816.561680-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240530212816.561680-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 6:28 AM, Niklas Cassel wrote:
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
> The problem is that Crucial CT240BX500SSD1 drives do not handle low power
> modes correctly. The problem was most likely not seen before because no
> one had used this drive with a AHCI controller with LPM enabled.
> 
> Add a quirk so that we do not enable LPM for this drive, since we see
> command timeouts if we do (even though the drive claims to support DIPM).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Aarrayy <lp610mh@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


