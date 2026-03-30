Return-Path: <stable+bounces-231040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NyMAqAxymk66QUAu9opvQ
	(envelope-from <stable+bounces-231040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:17:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC8356FE1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 360993008692
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171233ACA72;
	Mon, 30 Mar 2026 08:17:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926737AA7E;
	Mon, 30 Mar 2026 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858628; cv=none; b=QrjaTHQNuTVWBF2FbMjXjKtmlVtbY4lrWzJtssv1yPwsBOdAmFGQyVx9xX0418VQwYb9fNNrjBpNQ1pKczH8y2lbpFfwc1mpXqUUBFGvHYAW4wkSqamT/rdl9CSKXd2O6FRtINeJ3anJjL5KMzSOx1di2blzazL6WZ6VDZ7+Pog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858628; c=relaxed/simple;
	bh=xnHmCxhyqMWoLyIWmZZIpt61n6pgyNmI+9Yb9fyppIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E59MBM/IBTzPYzrwGN71VmLftdVWPexHRc2DQlpcrYJUJoRPT0JCCRwMfYZcIZf5ElEVVdQskGkRI62hEKhx8N7+quVEWSFhxODuykNnwcV7os3Qr2MZyrYRmMWYRgHLRQl/dLv0m0Lt9ayYvzZwAtZi+9UfUlIORVD7dDrfA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu.. (unknown [202.112.113.208])
	by APP-05 (Coremail) with SMTP id zQCowAAntwplMcppbLvrCw--.46728S2;
	Mon, 30 Mar 2026 16:16:46 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandre.belloni@bootlin.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: lpc_eth: Fix a possible memory leak in lpc_mii_probe()
Date: Mon, 30 Mar 2026 16:16:36 +0800
Message-ID: <20260330081636.2887980-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntwplMcppbLvrCw--.46728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUAw1DXr4rZF47Jw1fZwb_yoW8ZF4xp3
	y3CFWfGFykGr17Wwn5ZayDAFyayw4Iy3yrKFW2ya90g3WrXryrA340y34aqr45CFWkWF47
	XrnIyFy7Za1kXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231040-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[make24@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 0DCC8356FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lpc_mii_probe() calls of_phy_find_device() to obtain a phy_device
pointer. of_phy_find_device() increments the refcount of the device.
The current implementation does not decrement the refcount after using
the pointer, which leads to a memory leak.

Add phy_device_free() to balance the refcount.

Found by code review.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Cc: stable@vger.kernel.org
Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
---
 drivers/net/ethernet/nxp/lpc_eth.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 8b9a3e3bba30..8ce7c9bb6dd6 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -751,7 +751,7 @@ static void lpc_handle_link_change(struct net_device *ndev)
 static int lpc_mii_probe(struct net_device *ndev)
 {
 	struct netdata_local *pldat = netdev_priv(ndev);
-	struct phy_device *phydev;
+	struct phy_device *phydev, *phydev_tmp;
 
 	/* Attach to the PHY */
 	if (lpc_phy_interface_mode(&pldat->pdev->dev) == PHY_INTERFACE_MODE_MII)
@@ -760,17 +760,18 @@ static int lpc_mii_probe(struct net_device *ndev)
 		netdev_info(ndev, "using RMII interface\n");
 
 	if (pldat->phy_node)
-		phydev =  of_phy_find_device(pldat->phy_node);
+		phydev_tmp =  of_phy_find_device(pldat->phy_node);
 	else
-		phydev = phy_find_first(pldat->mii_bus);
-	if (!phydev) {
+		phydev_tmp = phy_find_first(pldat->mii_bus);
+	if (!phydev_tmp) {
 		netdev_err(ndev, "no PHY found\n");
 		return -ENODEV;
 	}
 
-	phydev = phy_connect(ndev, phydev_name(phydev),
+	phydev = phy_connect(ndev, phydev_name(phydev_tmp),
 			     &lpc_handle_link_change,
 			     lpc_phy_interface_mode(&pldat->pdev->dev));
+	phy_device_free(phydev_tmp);
 	if (IS_ERR(phydev)) {
 		netdev_err(ndev, "Could not attach to PHY\n");
 		return PTR_ERR(phydev);
-- 
2.43.0


