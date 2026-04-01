Return-Path: <stable+bounces-232783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNP2JcwczWk0aQYAu9opvQ
	(envelope-from <stable+bounces-232783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:25:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B5837B2F2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DFE301027F
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918FA35F60A;
	Wed,  1 Apr 2026 13:18:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5638F25C;
	Wed,  1 Apr 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049524; cv=none; b=irfKitzBvYRgWmPHqXrZkGzsHUhTACitj/Afxpr+uD0n6SMZlXoRAYyRXfKmjooKxgRhkltAdNzY437tiHi2Cre8ObCwBVQ0VFvpkY50y/ATeYoAv2u78dV5bkWH9IXNa94l9kP7gezuJOKUm5p0vzzjRsqwc4g0Ec22QCoq8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049524; c=relaxed/simple;
	bh=uQ8xz5ZVCOaxajR/YZaBP19QeYVZgCHHYym7P/lBskI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjYhoO0ELZOSOTWZ9Y2ni8vbn66hIkdvrehEWSGEVKL0TxRmvWdQfBOwJvwBm1GxcnbqJyUdhpb9HXI4xuJ0/0g1sCcIPG6IAO1HsK+KEhIxwrn3KXYqHxMC+4j3RhGIS6MZsPF5zR+bEtJWuTB42vMOVZm9tFVpiB42OQDi078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-01 (Coremail) with SMTP id qwCowACnT2sVG81pSvbdCw--.49770S2;
	Wed, 01 Apr 2026 21:18:21 +0800 (CST)
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
Date: Wed,  1 Apr 2026 21:18:13 +0800
Message-ID: <20260401131813.139167-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b44db9e6-f820-439d-a7ed-c1e2514579a8@mleia.com>
References: <b44db9e6-f820-439d-a7ed-c1e2514579a8@mleia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnT2sVG81pSvbdCw--.49770S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4ktw18AFWfWw1kWF4DJwb_yoW5Kw4Dp3
	y5GaySkFykGry7K395Za1UAryavw42yw1rGFy2yan0g3Z8XryrAryUKrWj93s8AFWkWF40
	vr1ayF93Xa1kXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	W5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgvtAUUUUU
	=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232783-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	FROM_NEQ_ENVFROM(0.00)[make24@iscas.ac.cn,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 52B5837B2F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 13:04, Vladimir Zapolskiy wrote:
> On 3/30/26 11:16, Ma Ke wrote:
> > lpc_mii_probe() calls of_phy_find_device() to obtain a phy_device
> > pointer. of_phy_find_device() increments the refcount of the device.
> > The current implementation does not decrement the refcount after using
> > the pointer, which leads to a memory leak.
> 
> this is correct, there is an actual detected bug.
> 
> > 
> > Add phy_device_free() to balance the refcount.
> 
> But this does not sound right, you shoud use of_node_put(pldat->phy_node).
> 
> > 
> > Found by code review.
> > 
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > Cc: stable@vger.kernel.org
> > Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
> > ---
> >   drivers/net/ethernet/nxp/lpc_eth.c | 11 ++++++-----
> >   1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
> > index 8b9a3e3bba30..8ce7c9bb6dd6 100644
> > --- a/drivers/net/ethernet/nxp/lpc_eth.c
> > +++ b/drivers/net/ethernet/nxp/lpc_eth.c
> > @@ -751,7 +751,7 @@ static void lpc_handle_link_change(struct net_device *ndev)
> >   static int lpc_mii_probe(struct net_device *ndev)
> >   {
> >   	struct netdata_local *pldat = netdev_priv(ndev);
> > -	struct phy_device *phydev;
> > +	struct phy_device *phydev, *phydev_tmp;
> >   
> >   	/* Attach to the PHY */
> >   	if (lpc_phy_interface_mode(&pldat->pdev->dev) == PHY_INTERFACE_MODE_MII)
> > @@ -760,17 +760,18 @@ static int lpc_mii_probe(struct net_device *ndev)
> >   		netdev_info(ndev, "using RMII interface\n");
> >   
> >   	if (pldat->phy_node)
> > -		phydev =  of_phy_find_device(pldat->phy_node);
> > +		phydev_tmp =  of_phy_find_device(pldat->phy_node);
> >   	else
> > -		phydev = phy_find_first(pldat->mii_bus);
> > -	if (!phydev) {
> > +		phydev_tmp = phy_find_first(pldat->mii_bus);
> > +	if (!phydev_tmp) {
> 
> I didn't get it, why the new phydev_tmp is needed above, please
> restore the original code above.
> 
> >   		netdev_err(ndev, "no PHY found\n");
> >   		return -ENODEV;
> >   	}
> >   
> > -	phydev = phy_connect(ndev, phydev_name(phydev),
> > +	phydev = phy_connect(ndev, phydev_name(phydev_tmp),
> >   			     &lpc_handle_link_change,
> >   			     lpc_phy_interface_mode(&pldat->pdev->dev));
> > +	phy_device_free(phydev_tmp);
> 
> This is plainly wrong and has to be dropped or changed to
> 
> 	if (pldat->phy_node)
> 		of_node_put(pldat->phy_node);
> 
> >   	if (IS_ERR(phydev)) {
> >   		netdev_err(ndev, "Could not attach to PHY\n");
> >   		return PTR_ERR(phydev);
> 
> Is it AI generated fix or what?.. The change looks bad, it introduces
> more severe issues than it fixes.
> 
> If you think you cannot create a proper change, let me know.
> 
> -- 
> Best wishes,
> Vladimir
Thank you very much for your detailed review and guidance.

Now I think your point probably is: you are saying that the real leak 
is not from of_phy_find_device(), but from the device node 
pldat->phy_node which was obtained earlier (probably by 
of_parse_phandle()) and never freed by of_node_put(). And you suggest 
to add of_node_put(pldat->phy_node) instead of my wrong 
phy_device_free().

However, I am still a little confused. In lpc_mii_probe(), 
of_phy_find_device() is called. From my understanding, this function 
increases the reference count of the device. To balance it, I thought
phy_device_free() (which calls put_device()) should be used.

Could you please kindly advise the correct patch? I will follow your
guidance and submit a proper fix.

I apologize again for my previous wrong patch. Thank you very much for
your help.

Best regards,
Ma Ke


