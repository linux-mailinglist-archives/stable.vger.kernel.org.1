Return-Path: <stable+bounces-194936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E891C62FBF
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 09:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5B80628AAB
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933F30FC1C;
	Mon, 17 Nov 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mUFSSRHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fj+7GrfF"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FC31DD98;
	Mon, 17 Nov 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369638; cv=none; b=TOck91Rd5JefuDqXuMT6hcJG9yoP8yoIgr5ruKN9xU8Og1j8LLwIHBQS/807KYJ7cnjxDiGx2j9+QQdhwfT9A/MhLlH+JtaJLWIt5AN6V0xB+AUDjCeCXXzUYglacXpOLzq/98dCdkuRotopvZgULdwkhxlHap9uSS6tQsBdYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369638; c=relaxed/simple;
	bh=+XwGh2InT/jOvLSeEd3s9JoXUK8VNyLLsVvWqjtA/3I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z9jdMcsTbDOxdWImsPoDpGIeWRjhWTqiUlsZ6/ATesqvcJ3rqE8ZMhxfn0wmC4aWM0i0ebEguWZl+MF+rsKfA/vjQK+/9gXhs1m6sHf7MOxlf/NHYj3qkxkOwieSMFCnQRm/nUbiN4aVkqlam6zrDj8AvWGmwkwIfaEdJyTQSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mUFSSRHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fj+7GrfF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D971AEC0171;
	Mon, 17 Nov 2025 03:53:52 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 17 Nov 2025 03:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763369632;
	 x=1763456032; bh=b7EAVyYC4388fQn/O8BhgvxdKAbjDZgqvyRrtSQ9BZE=; b=
	mUFSSRHHfKieh0uUiysRstw7VV32oLzs2SUl1Ip6o5KCnMdAhLPT4Lp5nxrgVAQ2
	ZDhoSUaByLQshOlr2sewPVheOT0j8vfxw9iFrW5MqAHQY8u1A+dUQoQnP6Euhqf7
	zPBOWRNpt56kGJCdDfOroYkB/45QGUOIV8yKXaMsztbkAZpvUHMcdxY3By4lpT50
	Kfnl7jnnhq/2QHUObZ+8AgDrSesWsA/LYxmsy+aku+GHgO8ke9UryoWb4pp1JJnl
	Z7rNDzAu82fV9KYJGZusfxMWoOME0UntQbDnZ6yc1e2E6P09C4NUXcP/WQWVycu/
	wT7VdRtVy+E8FndCmupuDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763369632; x=
	1763456032; bh=b7EAVyYC4388fQn/O8BhgvxdKAbjDZgqvyRrtSQ9BZE=; b=f
	j+7GrfF7d3POP7/iMHRLGwbpgd6fGizfN2G9fUflZFuR6u6f2WdJ4jvn6ub9tlpG
	kRcHA3tebz9pDn3NNm8KfPutcXi//xc3F0m/uXOtOq+YpdMDrdXCmWwxKXCa7G/P
	uObpjUZBMupO0sx1HgtLai/pkm+bGi/9EJXYZf+oZUT5yzhYfuSHiVPMlBWa60oA
	aTj1JuWFcOrhMZBHLdAd1oxa/kqwtyxr0M0tPnGrzUdZqOkGPiXcxUaO1/bSShPc
	JMCehov34DZ7cSEinLmDlM0I4MHFpcbKeWI5crl6rSScnQsA++4YL5jus1NEfM2j
	de79nV1D7ZIgGTNUXogtA==
X-ME-Sender: <xms:n-IaaQBlm_72udvTnx8KuPJXAm9VZ4RF4BLNHyfoI7n3hnvqFIiJeg>
    <xme:n-IaadXUdvwEJAJZNxIkN7HOYsE4p7Z8y5BY12ocKJN13UNx6k_f1PezXyr_tWBn5
    p-stwOoFPXxv-tNHGNIxmIbrjVBoiNElXTYrzeqUPeRazXgvuaNDEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsthhighhgvgesrghnthgtohhmrdguvgdprhgtphhtthhopehmrg
    hkvgdvgeesihhstggrshdrrggtrdgtnhdprhgtphhtthhopegrkhhpmheslhhinhhugidq
    fhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfh
    houhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhn
    vghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhiisehmlh
    gvihgrrdgtohhmpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghr
    ugdrvgguuhdprhgtphhtthhopehpihhothhrrdifohhjthgrshiitgiihihksehtihhmvg
    hshihsrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n-IaaT-W4wAKWyR-NET1UzLnPhX3qOVAKOPXZkn-8GBQzn5L4OpECQ>
    <xmx:n-IaaWERYlC8UZcc3hDUmvAtfF1uktYEllaj0VGgUad5NCfJwj13XA>
    <xmx:n-IaadStuvWE83BaF8gH8qo8Msjo_LmVApfdiVRX2sL5HlOt5vgyLQ>
    <xmx:n-IaadQahtVV2LqJfMmqoR08DURcHJyZ0UAKRHvsS49qmVwF2xzduQ>
    <xmx:oOIaae95SXimFtEFYHXCELJorvkC4rFO44IFaHDw_k2yDCWrT4tRtmlr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BF8A2700054; Mon, 17 Nov 2025 03:53:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADv9w-7PmNmc
Date: Mon, 17 Nov 2025 09:53:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ma Ke" <make24@iscas.ac.cn>, "Alan Stern" <stern@rowland.harvard.edu>,
 "Vladimir Zapolskiy" <vz@mleia.com>, piotr.wojtaszczyk@timesys.com,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, stigge@antcom.de
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Message-Id: <4fe5b63e-072c-419c-a1b9-bc21aec7e083@app.fastmail.com>
In-Reply-To: <20251117013428.21840-1-make24@iscas.ac.cn>
References: <20251117013428.21840-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] USB: ohci-nxp: Fix error handling in ohci-hcd-nxp driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 17, 2025, at 02:34, Ma Ke wrote:
> When obtaining the ISP1301 I2C client through the device tree, the
> driver does not release the device reference in the probe failure path
> or in the remove function. This could cause a reference count leak,
> which may prevent the device from being properly unbound or freed,
> leading to resource leakage.
>
> Fix this by storing whether the client was obtained via device tree
> and only releasing the reference in that case.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

The patch looks fine in principle, however I don't see any way
this driver would be probed without devicetree, and I think
it would be better to remove all the traces of the pre-DT
logic in it.

The lpc32xx platform was converted to DT back in 2012, so
any reference to the old variant is dead code. Something like
the patch below should work here.

Other thoughts on this driver, though I I'm not sure anyone
is going to have the energy to implement these:

 - the reference to isp1301_i2c_client should be kept in
   the hcd private data, after allocating a structure, by
   setting driver->hcd_priv_size.
 - instead of looking for the i2c device, I would suppose
   it should look for a usb_phy instead, as there is no
   guarantee on the initialization being ordered at the
   moment.
 - instead of a usb_phy, the driver should probably use
   a generic phy (a much larger rework).

     Arnd

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 24d5a1dc5056..4c072ce02f4d 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -155,22 +155,12 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 	struct device_node *isp1301_node;
 	struct clk *usb_host_clk;
 
-	if (pdev->dev.of_node) {
-		isp1301_node = of_parse_phandle(pdev->dev.of_node,
-						"transceiver", 0);
-	} else {
-		isp1301_node = NULL;
-	}
-
-	isp1301_i2c_client = isp1301_get_client(isp1301_node);
+	isp1301_node = of_parse_phandle(pdev->dev.of_node, "transceiver", 0);
+	isp1301_i2c_client = of_find_i2c_device_by_node(isp1301_node);
 	of_node_put(isp1301_node);
 	if (!isp1301_i2c_client)
 		return -EPROBE_DEFER;
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		goto fail_disable;
-
 	dev_dbg(&pdev->dev, "%s: " DRIVER_DESC " (nxp)\n", hcd_name);
 	if (usb_disabled()) {
 		dev_err(&pdev->dev, "USB is disabled\n");
@@ -223,7 +213,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
-	isp1301_i2c_client = NULL;
+	put_device(isp1301_i2c_client);
 	return ret;
 }
 
@@ -234,24 +224,19 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
-	isp1301_i2c_client = NULL;
+	put_device(isp1301_i2c_client);
 }
 
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:usb-ohci");
-
-#ifdef CONFIG_OF
 static const struct of_device_id ohci_hcd_nxp_match[] = {
 	{ .compatible = "nxp,ohci-nxp" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ohci_hcd_nxp_match);
-#endif
 
 static struct platform_driver ohci_hcd_nxp_driver = {
 	.driver = {
-		.name = "usb-ohci",
-		.of_match_table = of_match_ptr(ohci_hcd_nxp_match),
+		.name = "usb-ohci-lpc32xx",
+		.of_match_table = ohci_hcd_nxp_match,
 	},
 	.probe = ohci_hcd_nxp_probe,
 	.remove = ohci_hcd_nxp_remove,
diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
index f9b5c411aee4..3a8fa333a4f7 100644
--- a/drivers/usb/phy/phy-isp1301.c
+++ b/drivers/usb/phy/phy-isp1301.c
@@ -24,20 +24,12 @@ struct isp1301 {
 
 #define phy_to_isp(p)		(container_of((p), struct isp1301, phy))
 
-static const struct i2c_device_id isp1301_id[] = {
-	{ "isp1301" },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, isp1301_id);
-
 static const struct of_device_id isp1301_of_match[] = {
 	{.compatible = "nxp,isp1301" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isp1301_of_match);
 
-static struct i2c_client *isp1301_i2c_client;
-
 static int __isp1301_write(struct isp1301 *isp, u8 reg, u8 value, u8 clear)
 {
 	return i2c_smbus_write_byte_data(isp->client, reg | clear, value);
@@ -114,8 +106,6 @@ static int isp1301_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, isp);
 	usb_add_phy_dev(phy);
 
-	isp1301_i2c_client = client;
-
 	return 0;
 }
 
@@ -124,7 +114,6 @@ static void isp1301_remove(struct i2c_client *client)
 	struct isp1301 *isp = i2c_get_clientdata(client);
 
 	usb_remove_phy(&isp->phy);
-	isp1301_i2c_client = NULL;
 }
 
 static struct i2c_driver isp1301_driver = {
@@ -134,25 +123,10 @@ static struct i2c_driver isp1301_driver = {
 	},
 	.probe = isp1301_probe,
 	.remove = isp1301_remove,
-	.id_table = isp1301_id,
 };
 
 module_i2c_driver(isp1301_driver);
 
-struct i2c_client *isp1301_get_client(struct device_node *node)
-{
-	struct i2c_client *client;
-
-	/* reference of ISP1301 I2C node via DT */
-	client = of_find_i2c_device_by_node(node);
-	if (client)
-		return client;
-
-	/* non-DT: only one ISP1301 chip supported */
-	return isp1301_i2c_client;
-}
-EXPORT_SYMBOL_GPL(isp1301_get_client);
-
 MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
 MODULE_DESCRIPTION("NXP ISP1301 USB transceiver driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/usb/isp1301.h b/include/linux/usb/isp1301.h
index fa986b926a12..135dd785d984 100644
--- a/include/linux/usb/isp1301.h
+++ b/include/linux/usb/isp1301.h
@@ -66,6 +66,4 @@
 
 #define ISP1301_I2C_REG_CLEAR_ADDR	1	/* Register Address Modifier */
 
-struct i2c_client *isp1301_get_client(struct device_node *node);
-
 #endif /* __LINUX_USB_ISP1301_H */

