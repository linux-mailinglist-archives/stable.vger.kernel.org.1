Return-Path: <stable+bounces-233721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEV+Fitw1WmN6QcAu9opvQ
	(envelope-from <stable+bounces-233721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:59:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97AE3B4C9C
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4793033D22
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170B379973;
	Tue,  7 Apr 2026 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="hHuYgiE5";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="hHuYgiE5"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF41286D4D;
	Tue,  7 Apr 2026 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595529; cv=none; b=a5rLJglmScQ2XIK9cayyUufsXI6mxT0HvSPxy/0xmZrF7h7hLjV6OWVatsyTrtGd+GpvkNxd/PcOxC10JRl6B7nhZQrYLijqCDMka2jGisWh6P0IHCJX/lq09TwLDvpuuSh36KXbAnIbZGH9CC0ZsC2h3/BuAkXVQEvb8nuqXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595529; c=relaxed/simple;
	bh=UwJUOGjr3wF6gP3UKq3tPA0H8IjhbtQZEg5uOq1j9W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2Xy2NUfMshCJgG+ASGQ/NEFCo8CD4nrBtCpvLup7EwKlU1c3aHaXcxE5uHNNynGOOD1KlTM/1uumPBNvVPH4DUTXcNqmRwG9Bmeo27av4GXbuCRIRxk8C7YS5Se30ouIEkMGUqkm8KH9cs4Rmvs8OTKnaUFSzBzKO4BMrJ83bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=hHuYgiE5; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=hHuYgiE5; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1775595525; bh=UwJUOGjr3wF6gP3UKq3tPA0H8IjhbtQZEg5uOq1j9W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hHuYgiE5ISRXBkqFp3zAZepkjMVBT9j/eUuxTMlzZSQrCNGb1y0CpY8S3XyvUa4ev
	 yBgICoY72dnoGvmZm1/K6Jv5pqm5nywZhhVfJ9EG5UXViC+lIZZHSEIRiwzG0lBw5S
	 gvLZ+ecPEZ0PmyZ0gIgcCVfvm6nK+/TuIHpWFIlJnr8YsPdf3y9fm1kF9mab3sAyp3
	 w5vGPWK9hjlGWcer8TXMZyUBAmbbDU+FmIYMbpsiehRK88F7RytCBC/oZfEE3ko/Zr
	 i69k4J8cYkfP/q9sbXT31L9sQCKLPCticWr4fr3a6HP3QjCDQirfW2LWFdLP1G9Yku
	 oo5ls0QWvE2sQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 9DD913829B6;
	Tue,  7 Apr 2026 20:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1775595525; bh=UwJUOGjr3wF6gP3UKq3tPA0H8IjhbtQZEg5uOq1j9W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hHuYgiE5ISRXBkqFp3zAZepkjMVBT9j/eUuxTMlzZSQrCNGb1y0CpY8S3XyvUa4ev
	 yBgICoY72dnoGvmZm1/K6Jv5pqm5nywZhhVfJ9EG5UXViC+lIZZHSEIRiwzG0lBw5S
	 gvLZ+ecPEZ0PmyZ0gIgcCVfvm6nK+/TuIHpWFIlJnr8YsPdf3y9fm1kF9mab3sAyp3
	 w5vGPWK9hjlGWcer8TXMZyUBAmbbDU+FmIYMbpsiehRK88F7RytCBC/oZfEE3ko/Zr
	 i69k4J8cYkfP/q9sbXT31L9sQCKLPCticWr4fr3a6HP3QjCDQirfW2LWFdLP1G9Yku
	 oo5ls0QWvE2sQ==
Message-ID: <60dea9e5-9890-49ab-b806-713c388d6e08@mleia.com>
Date: Tue, 7 Apr 2026 23:58:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lpc_eth: Fix a possible memory leak in
 lpc_mii_probe()
To: Ma Ke <make24@iscas.ac.cn>
Cc: alexandre.belloni@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, piotr.wojtaszczyk@timesys.com,
 stable@vger.kernel.org
References: <b44db9e6-f820-439d-a7ed-c1e2514579a8@mleia.com>
 <20260401131813.139167-1-make24@iscas.ac.cn>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260401131813.139167-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260407_205845_664179_DEA539B3 
X-CRM114-Status: GOOD (  23.93  )
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mleia.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mleia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233721-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vz@mleia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mleia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mleia.com:dkim,mleia.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: D97AE3B4C9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Ma Ke.

On 4/1/26 16:18, Ma Ke wrote:
> On 3/30/26 13:04, Vladimir Zapolskiy wrote:
>> On 3/30/26 11:16, Ma Ke wrote:
>>> lpc_mii_probe() calls of_phy_find_device() to obtain a phy_device
>>> pointer. of_phy_find_device() increments the refcount of the device.
>>> The current implementation does not decrement the refcount after using
>>> the pointer, which leads to a memory leak.
>>
>> this is correct, there is an actual detected bug.
>>
>>>
>>> Add phy_device_free() to balance the refcount.
>>
>> But this does not sound right, you shoud use of_node_put(pldat->phy_node).
>>
>>>
>>> Found by code review.
>>>
>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
>>> ---
>>>    drivers/net/ethernet/nxp/lpc_eth.c | 11 ++++++-----
>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
>>> index 8b9a3e3bba30..8ce7c9bb6dd6 100644
>>> --- a/drivers/net/ethernet/nxp/lpc_eth.c
>>> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
>>> @@ -751,7 +751,7 @@ static void lpc_handle_link_change(struct net_device *ndev)
>>>    static int lpc_mii_probe(struct net_device *ndev)
>>>    {
>>>    	struct netdata_local *pldat = netdev_priv(ndev);
>>> -	struct phy_device *phydev;
>>> +	struct phy_device *phydev, *phydev_tmp;
>>>    
>>>    	/* Attach to the PHY */
>>>    	if (lpc_phy_interface_mode(&pldat->pdev->dev) == PHY_INTERFACE_MODE_MII)
>>> @@ -760,17 +760,18 @@ static int lpc_mii_probe(struct net_device *ndev)
>>>    		netdev_info(ndev, "using RMII interface\n");
>>>    
>>>    	if (pldat->phy_node)
>>> -		phydev =  of_phy_find_device(pldat->phy_node);
>>> +		phydev_tmp =  of_phy_find_device(pldat->phy_node);
>>>    	else
>>> -		phydev = phy_find_first(pldat->mii_bus);
>>> -	if (!phydev) {
>>> +		phydev_tmp = phy_find_first(pldat->mii_bus);
>>> +	if (!phydev_tmp) {
>>
>> I didn't get it, why the new phydev_tmp is needed above, please
>> restore the original code above.
>>
>>>    		netdev_err(ndev, "no PHY found\n");
>>>    		return -ENODEV;
>>>    	}
>>>    
>>> -	phydev = phy_connect(ndev, phydev_name(phydev),
>>> +	phydev = phy_connect(ndev, phydev_name(phydev_tmp),
>>>    			     &lpc_handle_link_change,
>>>    			     lpc_phy_interface_mode(&pldat->pdev->dev));
>>> +	phy_device_free(phydev_tmp);
>>
>> This is plainly wrong and has to be dropped or changed to
>>
>> 	if (pldat->phy_node)
>> 		of_node_put(pldat->phy_node);
>>
>>>    	if (IS_ERR(phydev)) {
>>>    		netdev_err(ndev, "Could not attach to PHY\n");
>>>    		return PTR_ERR(phydev);
>>
>> Is it AI generated fix or what?.. The change looks bad, it introduces
>> more severe issues than it fixes.
>>
>> If you think you cannot create a proper change, let me know.
>>
> Thank you very much for your detailed review and guidance.
> 
> Now I think your point probably is: you are saying that the real leak
> is not from of_phy_find_device(), but from the device node

I was pretty indelicate in my comment, let's split the change into parts.

1) I still do not understand, why phydev_tmp is introduced, please explain
or remove this part of the change;

2) phydev = of_phy_find_device() requires phy_device_free(phydev), but
I do not see why phy_find_first() requires it, while it was added in your
change.

Let's start from resolving these two points.

> pldat->phy_node which was obtained earlier (probably by
> of_parse_phandle()) and never freed by of_node_put(). And you suggest
> to add of_node_put(pldat->phy_node) instead of my wrong
> phy_device_free().
> 
> However, I am still a little confused. In lpc_mii_probe(),
> of_phy_find_device() is called. From my understanding, this function
> increases the reference count of the device. To balance it, I thought
> phy_device_free() (which calls put_device()) should be used.
> 
> Could you please kindly advise the correct patch? I will follow your
> guidance and submit a proper fix.
> 
> I apologize again for my previous wrong patch. Thank you very much for
> your help.

-- 
Best wishes,
Vladimir

