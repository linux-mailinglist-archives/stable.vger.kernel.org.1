Return-Path: <stable+bounces-66392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86794E348
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 23:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1EA1F21F4A
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E00E158A23;
	Sun, 11 Aug 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqFV3P4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A1383AB;
	Sun, 11 Aug 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410999; cv=none; b=RbH3xsQ00Wd/ckTbSyH1pHJwEEK4921hqA1tHgn+jmDScPQGo7oo/OaQwDXttfp5cmIFFsCqt9ZtdVhYMf1ify30RLl3KuDEm7Qyf/nr6PReDyM5EYAQiJCCxQNCJhwBUl7al0wxWpVBKz8Twb39zkFMi94svSGDlTY8F76e8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410999; c=relaxed/simple;
	bh=fRlJMxs/wcR/vUjjha1a0SI0jWE8mPk5xBeDsIvx2ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvG1p5WGxx1wjiFrwAPQBJBoDyPzmTo/qMCuAn8GKICt1ft6UprbTkqhN0/UL7jgsZVko6r3qrFHnwUakhXo6ODbqL0elCOYPhGGtO09oMv6poejMjEDznswpqBDA5PFt5nG1JMVwSbqRYhDUWrmHL4up6F38fXITL7hIFa4Q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqFV3P4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A195AC32786;
	Sun, 11 Aug 2024 21:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723410998;
	bh=fRlJMxs/wcR/vUjjha1a0SI0jWE8mPk5xBeDsIvx2ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqFV3P4VOt8UDLWDdQ8yShtull9lEKI+g82SEwKdtvNR1xsGRz1e3snhhF3QXCsCU
	 R4TDrSSCJAWHQASy7obP48oM7sFxlus2aHekNt5WOL8wapQHDFDu9fByGPZKxknhRn
	 DUySAtEscS2BoqGzICYPj8pwyrv+K6xihViI6aBKdPvMdUcGD/GnFxyhmm4BWFxmHf
	 Mrak/RQoF6SVEey4CKHWFVdGHghIP68eWbwhRQQ5krZTErdmm6pQLNqaYGjX3T87QL
	 fuHkbt1SyqVh3elVWYXujeOOMNPUpCprjQ5ReqW/AE6+SM/YfbHSOQ9/qQNNpmfz4U
	 nf6j9h3kq6Whw==
Date: Sun, 11 Aug 2024 17:16:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, nic_swsd@realtek.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip
 version 11 (early RTL8168b)
Message-ID: <ZrkqNUHo5rGKtbf3@sashalap>
References: <20240728005329.1723272-1-sashal@kernel.org>
 <20240728005329.1723272-3-sashal@kernel.org>
 <111ac84e-0d22-43cb-953e-fc5f029fe37c@gmail.com>
 <Zrcu7-CfCIoGO18V@sashalap>
 <39b2fc1f-421a-4547-b7bb-47b207975d73@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39b2fc1f-421a-4547-b7bb-47b207975d73@gmail.com>

On Sun, Aug 11, 2024 at 04:32:07PM +0200, Heiner Kallweit wrote:
>On 10.08.2024 11:12, Sasha Levin wrote:
>> On Mon, Jul 29, 2024 at 10:45:15AM +0200, Heiner Kallweit wrote:
>>> On 28.07.2024 02:52, Sasha Levin wrote:
>>>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>>>
>>>> [ Upstream commit 982300c115d229565d7af8e8b38aa1ee7bb1f5bd ]
>>>>
>>>> This early RTL8168b version was the first PCIe chip version, and it's
>>>> quite quirky. Last sign of life is from more than 15 yrs ago.
>>>> Let's remove detection of this chip version, we'll see whether anybody
>>>> complains. If not, support for this chip version can be removed a few
>>>> kernel versions later.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> Link: https://lore.kernel.org/r/875cdcf4-843c-420a-ad5d-417447b68572@gmail.com
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>> ---
>>>>  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index 7b9e04884575e..d2d46fe17631a 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -2274,7 +2274,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>>>
>>>>          /* 8168B family. */
>>>>          { 0x7c8, 0x380,    RTL_GIGA_MAC_VER_17 },
>>>> -        { 0x7c8, 0x300,    RTL_GIGA_MAC_VER_11 },
>>>> +        /* This one is very old and rare, let's see if anybody complains.
>>>> +         * { 0x7c8, 0x300,    RTL_GIGA_MAC_VER_11 },
>>>> +         */
>>>>
>>>>          /* 8101 family. */
>>>>          { 0x7c8, 0x448,    RTL_GIGA_MAC_VER_39 },
>>>
>>> It may be the case that there are still few users out there with this ancient hw.
>>> We will know better once 6.11 is out for a few month. In this case we would have to
>>> revert this change.
>>> I don't think it's a change which should go to stable.
>>
>> Sure, I'll drop it.
>>
>Just saw that this patch has been added to stable again an hour ago.
>Technical issue?

Indeed, I ended up dropping from the wrong local branch yesterday,
sorry!

-- 
Thanks,
Sasha

