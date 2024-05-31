Return-Path: <stable+bounces-47751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF608D56AE
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 02:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5786D286792
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760B186286;
	Fri, 31 May 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SalGgp5/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87312BD0F;
	Fri, 31 May 2024 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113613; cv=none; b=f+QOSHuTCFZ41c0Gd24UNUg5upi9NfuhkygL+FgVB2A7O6arJqs1LH6RxsXYuRiB25aLDSsF8JwBOk3SOCoex+59zGXSzX5lXBTAIZxBlLy9OH/U/3I/amyx3EwWNxWw+NVXbjx72ki/OhgiwFu0PM8wRznl8gE/KmfXd/3rWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113613; c=relaxed/simple;
	bh=VtCMaBcbV0Wr/asaqBEHQdJ9OUYxT1etF8QWfK79Yos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q28oFPjF1F5vuOqUiRlWUbxIx+vlBbjKPwRnXHFmdap/QppUq47tmQy6JrKg4B+3RHd0nix//66zqKv7qdTMK+u3qPLRv9u6pb8ap/uEurRLFcGC5ieeKPOByXPVM8a2f1p8q27AI+sqtjlY6QkkGoaXYBcYLBguAIJklK6uu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SalGgp5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF3FC2BBFC;
	Fri, 31 May 2024 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717113612;
	bh=VtCMaBcbV0Wr/asaqBEHQdJ9OUYxT1etF8QWfK79Yos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SalGgp5/cWk/EjhaZWN8yy89nMFqH8Tbd7nGgy+AmrRy1m2dRGE/eSJjQW7nLRled
	 WPejVG3MzdGF+D2bZ/gOrOOAbP1pt2Mhb8YWRiX3Dmv0wyU74rsViCSsM+yFDB1YfH
	 6fEAcdo49CfJ42yxEfH+p1lV/ZEGk9SS0tnjyl13A78L+UoqiOSkezBVGT94rvHNvf
	 iQ5+CvZbzVHC+/6hqGj5ZbuQhHi0GUJhZU0iGCSOby1lQU7KhAMBhbKCXfgqM/XUBr
	 JaI0wdExq64EXx0zCnhkR1dj8w03AATGalp+E1NXwGQKL5c1jcE15+AL8C57fn1Obv
	 02EnAVE/GdNFA==
Message-ID: <b7e8b2df-7cfc-415c-99e7-f3fcd953d26d@kernel.org>
Date: Fri, 31 May 2024 09:00:09 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
To: Niklas Cassel <cassel@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jian-Hong Pan <jhp@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org, Tim Teichmann <teichmanntim@outlook.de>,
 linux-ide@vger.kernel.org
References: <20240530212703.561517-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240530212703.561517-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 6:27 AM, Niklas Cassel wrote:
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
> The problem is that Apacer AS340 drives do not handle low power modes
> correctly. The problem was most likely not seen before because no one
> had used this drive with a AHCI controller with LPM enabled.
> 
> Add a quirk so that we do not enable LPM for this drive, since we see
> command timeouts if we do (even though the drive claims to support DIPM).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Tim Teichmann <teichmanntim@outlook.de>
> Closes: https://lore.kernel.org/linux-ide/87bk4pbve8.ffs@tglx/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


