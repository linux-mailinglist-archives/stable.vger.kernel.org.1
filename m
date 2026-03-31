Return-Path: <stable+bounces-231306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPxrAOMYy2lrDwYAu9opvQ
	(envelope-from <stable+bounces-231306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 02:44:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B171C362CBA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 02:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02CE23017AB7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880692F1FED;
	Tue, 31 Mar 2026 00:44:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBF40855;
	Tue, 31 Mar 2026 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917842; cv=none; b=ULY0F/T/llpTxG+5unqm+uJkd/zWEX9zFqQKVD7TfEnQmp3rA6OpjQiLggSJgMmmILgGmnhe5BHDcuRgDWr8sXgRemwBYTvvk8EbBpNGZdqnGYQU+sL9+DUgRbQquKlAWL0It773Gx+kPe7QYH0w+NwJwoUxqTTbLYyWq2nKODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917842; c=relaxed/simple;
	bh=OoYAJJ2IOn1C4pdT4r5UkIPxYoebCDjwcnjFxkun7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4mHDJ/J9zBfU+zzxpgfjAkomWXQmMaZcLO9Vig6yZLNiEtIgcnuXSL4/slJH+rjif7fDH4n4LLlZoS94oGE16Bmr1oM/jpncOehdzZg+p5GZItHzxz6bUADuedOxrfSQDT3UM4KuomOImsv9JepRWo25IHyE0YohhbDcgVy4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBCtGMtpnhv_Cw--.47429S2;
	Tue, 31 Mar 2026 08:43:36 +0800 (CST)
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
Date: Tue, 31 Mar 2026 08:43:25 +0800
Message-ID: <20260331004325.3304949-1-make24@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAC3TBCtGMtpnhv_Cw--.47429S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4ktw18AFWfWw1kWF4DJwb_yoW5Kw4Dp3
	y5GaySkFykGry7K395Za1UAryavw42yw1rGFy2yan0g3Z8XryrAryUKrWj93s8AFWkWF40
	vr1ayF93Xa1kXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
	5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231306-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[make24@iscas.ac.cn,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: B171C362CBA
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

Now I think your point probably is: you are saying that the real leak is not from of_phy_find_device(), but from the device node pldat->phy_node which was obtained earlier (probably by of_parse_phandle()) and never freed by of_node_put(). And you suggest to add of_node_put(pldat->phy_node) instead of my wrong phy_device_free().

However, I am still a little confused. In lpc_mii_probe(), of_phy_find_device() is called. From my understanding, this function increases the reference count of the device. To balance it, I thought phy_device_free() (which calls put_device()) should be used.

Could you please kindly advise the correct patch? I will follow your guidance and submit a proper fix.

I apologize again for my previous wrong patch. Thank you very much for your help.

Best regards,
Ma Ke





