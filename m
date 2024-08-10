Return-Path: <stable+bounces-66311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B56394DBD9
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D461F221C5
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9E14D6F5;
	Sat, 10 Aug 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd4qQF+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A421A0B;
	Sat, 10 Aug 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281137; cv=none; b=jbJTLmaJ5jwnoYIlO/zLtUlNga0KMls8CenwPhdcCPCQEIpJr8i1w5IjYdpA8ScrMezFFsMY0lgQPqQwWA5iHLBf3XoodOefrc79KqC3C9NJ5QGY73W7jhVZAqJ8sRTbvRf2blTAEa/3AN52MtPQpX7+yyQ9RjdQfZbnVX7DEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281137; c=relaxed/simple;
	bh=6fWma+A4UCcfcLG00G+S0Cq9e7F4xmhLzd2uZHGdky8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQrTzchMktVvpQAsKG8nXm7ZnbQ/B3SSbHQNRV1akB5MFqVLeE5E+w2Xc+UHzL4uMf65m8qxn20yJlAbhlnlsWNOPES7gC761WAV6n61x+aoDfPp383y9E2jddavtxO0ROuNw05ha0iI9RUpmoZ7FdMmMlOeMY9SIOzc0vcVR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd4qQF+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6CAC32781;
	Sat, 10 Aug 2024 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281137;
	bh=6fWma+A4UCcfcLG00G+S0Cq9e7F4xmhLzd2uZHGdky8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rd4qQF+MEz2PMSnAmGxXVqTHY0+/sSh+ymd9fdUNA07MmQFl7Y3iimtFj7t7D4fh/
	 FMD2VVJnxwlIa97ISsf2a2thxR2p8ll6peShQerJjXyesED+GlygcbfbbROMbMj581
	 iOeJqX96Xnuhg4+8sad4TfcOlSiXMiJ2ksNtVUCUHR+p1UFDcxhPKtIBDlckfXrogi
	 +V0KNCT8tUexZ+ELDRGfXG+mv17G1RSUdL9wUQy841n1YderZxze4RvHAL3IhGIvR+
	 164ryR19adjE+TbSuaLT2Sy4DCHA1DFq7KdbF0HQKaHgQDPkgPRCbq6VTdeeGyuoBh
	 GrqZe8AuAqK0A==
Date: Sat, 10 Aug 2024 05:12:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, nic_swsd@realtek.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip
 version 11 (early RTL8168b)
Message-ID: <Zrcu7-CfCIoGO18V@sashalap>
References: <20240728005329.1723272-1-sashal@kernel.org>
 <20240728005329.1723272-3-sashal@kernel.org>
 <111ac84e-0d22-43cb-953e-fc5f029fe37c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <111ac84e-0d22-43cb-953e-fc5f029fe37c@gmail.com>

On Mon, Jul 29, 2024 at 10:45:15AM +0200, Heiner Kallweit wrote:
>On 28.07.2024 02:52, Sasha Levin wrote:
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> [ Upstream commit 982300c115d229565d7af8e8b38aa1ee7bb1f5bd ]
>>
>> This early RTL8168b version was the first PCIe chip version, and it's
>> quite quirky. Last sign of life is from more than 15 yrs ago.
>> Let's remove detection of this chip version, we'll see whether anybody
>> complains. If not, support for this chip version can be removed a few
>> kernel versions later.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Link: https://lore.kernel.org/r/875cdcf4-843c-420a-ad5d-417447b68572@gmail.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 7b9e04884575e..d2d46fe17631a 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -2274,7 +2274,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>
>>  		/* 8168B family. */
>>  		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
>> -		{ 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
>> +		/* This one is very old and rare, let's see if anybody complains.
>> +		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
>> +		 */
>>
>>  		/* 8101 family. */
>>  		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },
>
>It may be the case that there are still few users out there with this ancient hw.
>We will know better once 6.11 is out for a few month. In this case we would have to
>revert this change.
>I don't think it's a change which should go to stable.

Sure, I'll drop it.

-- 
Thanks,
Sasha

