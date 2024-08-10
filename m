Return-Path: <stable+bounces-66310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1A494DBD7
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FBDB21E0C
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1C14D28C;
	Sat, 10 Aug 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ00lh7+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9B142E77;
	Sat, 10 Aug 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281088; cv=none; b=JauPMMVEbBs+D2aHBm4PYTgEYk3OBZKsUJ5WNmV7kGxLrR6dU4KPltQ0jTkls7A6Jt22c/pUvzsOPVB++FN0tYsJH/YLfbATg5ZYsdZKsY1mun7xB7fy3VGrddUO5EMlAAVe6itY0KA8iUaR/5WmHvDsGbQfZbIbbEcBnm6MiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281088; c=relaxed/simple;
	bh=AoiaDiMVpIuVwraGfhlzk6sMJ54zKrVKt3c+uuBiEhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eoner+W3H6U18VeCEpBNyDj9Hkgi8pynqXJw8SxH8qO/YzGd3epnqN2OzWNkfXnkT6mFvqb3mCY+OuD9iCXVzwQjIXCC/O1X+eYyZCBtth1DbzMGMaGdb94n2TYfisRTpYVz5AHhhrqQ1w9tffFRc8jvUyqwpBuFYkI0U/Zriao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ00lh7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4660EC32781;
	Sat, 10 Aug 2024 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281088;
	bh=AoiaDiMVpIuVwraGfhlzk6sMJ54zKrVKt3c+uuBiEhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQ00lh7+ONuVpLE68R0g/VlrsLTVqZ54r46Te9kxxtGcoU4SbvAyO0zhaqwUQi3/d
	 YIeA9FH4dd/OgvzWBDPRAh10MgfKZKCRSLcPwTch5ByN+NCSa60CybfFxLbJ5phZQQ
	 tNmjkuJKD5KPVNDeIpd8ZtVoGrB5esDuioDnBx9xYbWT0enR2zU3wuUCNvhYDaM/br
	 YCx7k4fofsqcCKOuYB+YzLKE6cwWYAIyMwo93BWzqw61ZDMowiLinvzPQAXcRuY2wa
	 25HPQLbt5193wjTufIDXHmMfDWvI0hlH90y/cFuwRMt2jTByoTgiR80x5kdXM0NRRl
	 eYa/Du1gQ+ERQ==
Date: Sat, 10 Aug 2024 05:11:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	James Morse <james.morse@arm.com>, Gavin Shan <gshan@redhat.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.10 14/16] irqchip/gic-v3: Don't return errors
 from gic_acpi_match_gicc()
Message-ID: <Zrcuvkiol0PsKu0l@sashalap>
References: <20240728004739.1698541-1-sashal@kernel.org>
 <20240728004739.1698541-14-sashal@kernel.org>
 <87zfq150r6.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87zfq150r6.wl-maz@kernel.org>

On Sun, Jul 28, 2024 at 10:22:53AM +0100, Marc Zyngier wrote:
>On Sun, 28 Jul 2024 01:47:31 +0100,
>Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: James Morse <james.morse@arm.com>
>>
>> [ Upstream commit fa2dabe57220e6af78ed7a2f7016bf250a618204 ]
>>
>> gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
>> It should only count the number of enabled redistributors, but it
>> also tries to sanity check the GICC entry, currently returning an
>> error if the Enabled bit is set, but the gicr_base_address is zero.
>>
>> Adding support for the online-capable bit to the sanity check will
>> complicate it, for no benefit. The existing check implicitly depends on
>> gic_acpi_count_gicr_regions() previous failing to find any GICR regions
>> (as it is valid to have gicr_base_address of zero if the redistributors
>> are described via a GICR entry).
>>
>> Instead of complicating the check, remove it. Failures that happen at
>> this point cause the irqchip not to register, meaning no irqs can be
>> requested. The kernel grinds to a panic() pretty quickly.
>>
>> Without the check, MADT tables that exhibit this problem are still
>> caught by gic_populate_rdist(), which helpfully also prints what went
>> wrong:
>> | CPU4: mpidr 100 has no re-distributor!
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Marc Zyngier <maz@kernel.org>
>> Link: https://lore.kernel.org/r/20240529133446.28446-14-Jonathan.Cameron@huawei.com
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please drop this. It has no purpose being backported to stable.

Ack, thanks!

-- 
Thanks,
Sasha

