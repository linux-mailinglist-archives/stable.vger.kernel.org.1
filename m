Return-Path: <stable+bounces-238684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOjsLu2c5Wm1mAEAu9opvQ
	(envelope-from <stable+bounces-238684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:26:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CA4268C9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01EED302F39C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 03:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17737F8CF;
	Mon, 20 Apr 2026 03:25:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04B35C185;
	Mon, 20 Apr 2026 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776655524; cv=none; b=NfRzBotACsQSc++4If0u/vazVRMxAH0zXqMFdtjRpxtdpeez3Z7dE97QCK6qzbq2jfrSdnKmRxOgBKhGUzVJ0NGW60X++o+ovYw+T8WpiT5tEiX7JKFGLismg+N4uBp4cNksgJ/m54HBQ1T9SB8mI938LbHWvSrbmpSs6yFKIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776655524; c=relaxed/simple;
	bh=o6WC5778xZWcRTJECjjLQorMrFwgvz0nLDUSBYqAmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAwHVFyqvsFFBivZh0jkGj1q6UzInxN/QI9tz5PRmG/Aiuz7tqKNUbgzr/x/h1svdEd271Ke5YXCn3ZyD5aPDX0QtFysT2k+xesCF600XBaN6CVvh0lRsWCJMgi/uPDq1aAO1Cr5ti1v7s+BSb1p8pyL4sZFT6Xjx3+056Sjrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-05 (Coremail) with SMTP id zQCowADndwt9nOVpj2cbDg--.31217S2;
	Mon, 20 Apr 2026 11:24:54 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vz@mleia.com
Cc: alexandre.belloni@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	make24@iscas.ac.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	piotr.wojtaszczyk@timesys.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: lpc_eth: Fix a possible memory leak in lpc_mii_probe()
Date: Mon, 20 Apr 2026 11:24:45 +0800
Message-ID: <20260420032445.2209758-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <60dea9e5-9890-49ab-b806-713c388d6e08@mleia.com>
References: <60dea9e5-9890-49ab-b806-713c388d6e08@mleia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADndwt9nOVpj2cbDg--.31217S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF15Cr43Xr48Ar17urWDCFg_yoW7Zr47p3
	yUGa4SkFykGr17Gw4vv3WUAryYvw42yw1rWFyjya45Wrn0qryfAry8trWY9r95CFZ7J3W0
	vryakFZ3ZaykXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238684-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[make24@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.268];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 666CA4268C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Hello Ma Ke.
>
>On 4/1/26 16:18, Ma Ke wrote:
>> On 3/30/26 13:04, Vladimir Zapolskiy wrote:
>>> On 3/30/26 11:16, Ma Ke wrote:
>>>> lpc_mii_probe() calls of_phy_find_device() to obtain a phy_device
>>>> pointer. of_phy_find_device() increments the refcount of the device.
>>>> The current implementation does not decrement the refcount after using
>>>> the pointer, which leads to a memory leak.
>>>
>>> this is correct, there is an actual detected bug.
>>>
>>>>
>>>> Add phy_device_free() to balance the refcount.
>>>
>>> But this does not sound right, you shoud use of_node_put(pldat->phy_node).
>>>
>>>>
>>>> Found by code review.
>>>>
>>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
>>>> ---
>>>>    drivers/net/ethernet/nxp/lpc_eth.c | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
>>>> index 8b9a3e3bba30..8ce7c9bb6dd6 100644
>>>> --- a/drivers/net/ethernet/nxp/lpc_eth.c
>>>> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
>>>> @@ -751,7 +751,7 @@ static void lpc_handle_link_change(struct net_device *ndev)
>>>>    static int lpc_mii_probe(struct net_device *ndev)
>>>>    {
>>>>    	struct netdata_local *pldat = netdev_priv(ndev);
>>>> -	struct phy_device *phydev;
>>>> +	struct phy_device *phydev, *phydev_tmp;
>>>>    
>>>>    	/* Attach to the PHY */
>>>>    	if (lpc_phy_interface_mode(&pldat->pdev->dev) == PHY_INTERFACE_MODE_MII)
>>>> @@ -760,17 +760,18 @@ static int lpc_mii_probe(struct net_device *ndev)
>>>>    		netdev_info(ndev, "using RMII interface\n");
>>>>    
>>>>    	if (pldat->phy_node)
>>>> -		phydev =  of_phy_find_device(pldat->phy_node);
>>>> +		phydev_tmp =  of_phy_find_device(pldat->phy_node);
>>>>    	else
>>>> -		phydev = phy_find_first(pldat->mii_bus);
>>>> -	if (!phydev) {
>>>> +		phydev_tmp = phy_find_first(pldat->mii_bus);
>>>> +	if (!phydev_tmp) {
>>>
>>> I didn't get it, why the new phydev_tmp is needed above, please
>>> restore the original code above.
>>>
>>>>    		netdev_err(ndev, "no PHY found\n");
>>>>    		return -ENODEV;
>>>>    	}
>>>>    
>>>> -	phydev = phy_connect(ndev, phydev_name(phydev),
>>>> +	phydev = phy_connect(ndev, phydev_name(phydev_tmp),
>>>>    			     &lpc_handle_link_change,
>>>>    			     lpc_phy_interface_mode(&pldat->pdev->dev));
>>>> +	phy_device_free(phydev_tmp);
>>>
>>> This is plainly wrong and has to be dropped or changed to
>>>
>>> 	if (pldat->phy_node)
>>> 		of_node_put(pldat->phy_node);
>>>
>>>>    	if (IS_ERR(phydev)) {
>>>>    		netdev_err(ndev, "Could not attach to PHY\n");
>>>>    		return PTR_ERR(phydev);
>>>
>>> Is it AI generated fix or what?.. The change looks bad, it introduces
>>> more severe issues than it fixes.
>>>
>>> If you think you cannot create a proper change, let me know.
>>>
>> Thank you very much for your detailed review and guidance.
>> 
>> Now I think your point probably is: you are saying that the real leak
>> is not from of_phy_find_device(), but from the device node
>
>I was pretty indelicate in my comment, let's split the change into parts.
>
>1) I still do not understand, why phydev_tmp is introduced, please explain
>or remove this part of the change;
>
>2) phydev = of_phy_find_device() requires phy_device_free(phydev), but
>I do not see why phy_find_first() requires it, while it was added in your
>change.
>
>Let's start from resolving these two points.
>
>> pldat->phy_node which was obtained earlier (probably by
>> of_parse_phandle()) and never freed by of_node_put(). And you suggest
>> to add of_node_put(pldat->phy_node) instead of my wrong
>> phy_device_free().
>> 
>> However, I am still a little confused. In lpc_mii_probe(),
>> of_phy_find_device() is called. From my understanding, this function
>> increases the reference count of the device. To balance it, I thought
>> phy_device_free() (which calls put_device()) should be used.
>> 
>> Could you please kindly advise the correct patch? I will follow your
>> guidance and submit a proper fix.
>> 
>> I apologize again for my previous wrong patch. Thank you very much for
>> your help.
>
> -- 
> Best wishes,
> Vladimir
Hello Vladimir,

Thank you for the detailed explanation and for pointing out my mistakes.

> 1) I still do not understand, why phydev_tmp is introduced, please explain
> or remove this part of the change;

I added phydev_tmp because I thought I needed to keep the original 
phy_device pointer for releasing after phy_connect(). But as you 
implied, it's perhaps unnecessary and only makes the code less 
readable. I will drop this change completely in the next version.

> 2) phydev = of_phy_find_device() requires phy_device_free(phydev), but
> I do not see why phy_find_first() requires it, while it was added in your
> change.

You are absolutely right. I mistakenly assumed that both functions 
return a reference-counted pointer. phy_find_first() does not 
increment the refcount, so calling phy_device_free() on it is wrong 
and dangerous. My patch introduced a new bug there.

Now I understand that only the of_phy_find_device() branch needs a 
corresponding put_device(). I will prepare a corrected patch that only
releases the reference in that specific path (including on the error 
path after phy_connect() failure). I will also look at the phy_node 
reference leak you hinted at.

Thank you again for your guidance. I will send a v2 after fixing it 
properly.

Best regards,
Ma Ke


