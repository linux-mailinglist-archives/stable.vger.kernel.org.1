Return-Path: <stable+bounces-245120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIVOIduGAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:35:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3E509501
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 508CB300599C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B03382F2D;
	Mon, 11 May 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SaVmE+eC"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782333822AA;
	Mon, 11 May 2026 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484951; cv=none; b=opuzXfBPZWFqSvWYds7Ig4juyxTUvvfNiZsvba35KGF/NTnEZJk5uDN4CDzhJhW9lg+M9I2zPspfRLXk816VH8acRBh8ydbs82v0yleCZP8U+Q/0clpuliwP4Gn9XbBo0YxzPxJ0zWcp7SkuVbEK35++5B90+qHwmw5REx6Q6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484951; c=relaxed/simple;
	bh=JekxQ3jhAEWwckKcTZ1KtXX5cs1axMVv72xdmWNzLC0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ehXNTkmlHlvl8NwRzY+zVWGnBM46JtW8rwqu7eRuT81eNb8/cX2igndVI+4WncuHfP5MfJanId6E+uA7UFq7S1ufM1TtralOaAf64T+7YTUFroVraGctrEKKSo4evWvw+lz+GLJsBdDI7dLWCxEhPc+RPIiTjgAmzef8npa/SOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SaVmE+eC; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gDWjT0lbPz41YZ;
	Mon, 11 May 2026 09:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778484941;
	bh=JekxQ3jhAEWwckKcTZ1KtXX5cs1axMVv72xdmWNzLC0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SaVmE+eCwtnk+V7y6Fc+oBUmBkHhRzHxhauDGaXbgSZO01Nj9EqZsUbuLsbYvrgqr
	 7VOZ1jiSFQr4GxlLKz04WCYIJrEcNWl939fBtlXodSi8QgWPOacKNrLxrzUcxmyu8Q
	 UDgUbSeSX2r/BWQmHRpvdC4d0WRNFb7JShsoY3Jyn7N4+N7zjzty4sx9nFOLezsWIT
	 5A163bJ2c46kPmWNtv7yawU11yEtyvDWUV42u0L18+rHqpqUP/ILRndvX4BGc6jC3M
	 iKUHTuV5RUOFZfnyg50gEBwjvgoi0DsFXdpCZZMJqsSgXgpSs4zpjx4ePXfR+/uplc
	 UPKGdmZCicHqg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gDWjS74qGz41YQ;
	Mon, 11 May 2026 09:35:40 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gDWjS1W60z8sgW;
	Mon, 11 May 2026 09:35:40 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2E7F56183D;
	Mon, 11 May 2026 09:35:39 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f07da4c5-cdb9-42c8-b4e7-f5122254ed8a@leemhuis.info>
Date: Mon, 11 May 2026 09:35:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since
 v6.18
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jensen Huang <jensenhuang@friendlyarm.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
References: 
 <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
 <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
 <5308c658-7d4c-4292-b091-a51546ea4d23@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <5308c658-7d4c-4292-b091-a51546ea4d23@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177848493954.3705305.4101896583574132066@mxe9fb.netcup.net>
X-NC-CID: ly4E+x+yMjHTTvk5EYhBSqPUYKsrNng/6ZNrMOBTFRTtmW+g2rA=
X-Rspamd-Queue-Id: 70A3E509501
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org,friendlyarm.com,renesas.com];
	TAGGED_FROM(0.00)[bounces-245120-lists,stable=lfdr.de];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:email,leemhuis.info:mid,leemhuis.info:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Greg, Sasha, could you please cherry-pick c171e679ee66d7 ("net: stmmac:
Disable EEE RX clock stop when VLAN is enabled") [v6.19-rc1] to 6.18.y?
It fixes a regression for Jensen Huang (for details see below; it was
later confirmed that c171e679ee66d7 really fixes this) caused by
dd557266cf5fb0 ("net: stmmac: block PHY RXC clock-stop") [v6.15-rc1]. tia!

Ciao, Thorsten

On 5/7/26 15:13, Thorsten Leemhuis wrote:
> [+Ovidiu Panait]
> On 5/7/26 14:49, Jensen Huang wrote:
>> On Tue, May 5, 2026 at 4:26 PM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>> On 4/29/26 14:53, Jensen Huang wrote:
>>
>>>> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
>>>> When a network cable is connected during boot, the DMA reset
>>>> occasionally fails with the error message: "Failed to reset the dma".
>>>>
>>>> This appears to be a timing issue related to the EEE RX clock-stop
>>>> logic. Based on my investigation with the RTL8211E PHY, I monitored
>>>> the PHY register PS1R (MMD device 3, address 0x01) and observed a
>>>> value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
>>>> clock may have already stopped.
>>>>
>>>> While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
>>>
>>> Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
>>> affected? This is something that is always a good advisable (some people
>>> would call it required). In this case even more, as it since a while
>>> contains a fix for the change you mentioned, that wasn't backported:
>>> c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
>>> enabled"). But this is not my area of expertise (and in different area
>>> of the code), so that fix might be unrelated to your issue.
>>
>> Thanks for the pointer.
>> As you suggested, I have tested the mainline and confirmed that the
>> issue is not present in v7.1-rc2, nor as early as v6.19-rc1. However,
>> I verified that the issue persists in the latest stable v6.18.26.
>> I performed a git bisect and the result pointed exactly to the commit
>> you mentioned: c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
>> when VLAN is enabled").
> 
> Great! Could you please cherry-pick c171e679ee66d7 to 6.18.y and see if
> that fixes things? It sounds like it should.
> 
> @Ovidiu Panait: c171e679ee66d7 is a commit of yours. If Jensen confirms
> that cherry-picking fixed the problem, I'd say we ask Greg to pick it up
> for 6.18.y -- unless you see any reasons why that might be a bad idea.
> 
>> Additionally, I tested the case where CONFIG_VLAN_8021Q is not set,
>> and the DMA reset issue occurs again.
> 
> I'd say that is likely best discussed in a new thread you might want to
> start. Also wondering if it was like that earlier. Or iow: if that is a
> regression or not.
> 
> Ciao, Thorsten
> 
>>>> ensures the clock is running before the DMA reset, my tests suggest
>>>> that the phylink_rx_clk_stop_block() call might not provide a
>>>> sufficiently stable RX clock in time for the immediate DMA reset that
>>>> follows.
>>>>
>>>> Since stmmac already sets mac_requires_rxc = true, I modified
>>>> phylink_bringup_phy() to honor this flag. This avoids toggling the
>>>> PHY's clk_stop_enable during the initialization sequence, ensuring the
>>>> RX clock remains active and stable throughout.
>>>> With the change below, I achieved 200/200 successful reboots with the
>>>> cable connected (previously ~50% failure rate).
>>>>
>>>> --- a/drivers/net/phy/phylink.c
>>>> +++ b/drivers/net/phy/phylink.c
>>>> @@ -2171,7 +2171,7 @@ static int phylink_bringup_phy(struct phylink
>>>> *pl, struct phy_device *phy,
>>>>      /* Allow the MAC to stop its clock if the PHY has the capability */
>>>>      pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
>>>>
>>>> -    if (pl->mac_supports_eee_ops) {
>>>> +    if (pl->mac_supports_eee_ops && !pl->config->mac_requires_rxc) {
>>>>          /* Explicitly configure whether the PHY is allowed to stop it's
>>>>           * receive clock.
>>>>           */
>>>>
>>>> Any feedback/testing on this would be appreciated.
>>>>
>>>> Best regards,
>>>> Jensen Huang
>>>>
>>>
> 


