Return-Path: <stable+bounces-70168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D26D95F002
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E112853AA
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F7154C0E;
	Mon, 26 Aug 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/5xOuRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA813DDD9
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672499; cv=none; b=rzIdHs6zjIlcErDoRvygyhJnMtlFqXpzXn+OxA9t8r65SXXZw/6htIRvs+xWhmB359JhAO626IDpONbxayvWRuunBfut+5O5BGoR7oYMWO4NdkqamscJM/PsAJ2czkUDz7/k4XyVJ34gs3LbQER6t+Auycki88bvFX8xnB/EyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672499; c=relaxed/simple;
	bh=+CSapbjRxF7bTsMKE25enye5LDuqUJNzEVUsLifROHs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fNFl2B4ieRPOwpfwPATOGp9qir1XxlcnpwQmU1C8ACEbYS9y7+eFxQniX1AI+I2m2N66U+5mXS2f10xT4e0sERZ6Qs9d9cAnLtSLDoB0CVC/CjdecHGU/l/bzH80Xct12CXCzN2pDQN6QLEUOQFYLRyjOtj0HzOTb5lWdsDN7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/5xOuRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736ACC5140F;
	Mon, 26 Aug 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672498;
	bh=+CSapbjRxF7bTsMKE25enye5LDuqUJNzEVUsLifROHs=;
	h=Subject:To:Cc:From:Date:From;
	b=W/5xOuRDFemi4577tGNj8kvAaXnbuwwH8FQ8oz14/tVYt/D4QQBhruYDrW6MSwV3X
	 aagcYz/jBRfOfSWZYJOw1zByGmbocTV5TBeEIMRQCCi+Ca3RnsymwfwFbK6mk2txlD
	 nq5FIMkiVLIpMsqJsSfVyFxBO2RXa9sXPBwNcpSo=
Subject: FAILED: patch "[PATCH] net: ngbe: Fix phy mode set to external phy" failed to apply to 6.6-stable tree
To: mengyuanlou@net-swift.com,jacob.e.keller@intel.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:41:35 +0200
Message-ID: <2024082635-dislike-tipping-1bee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f2916c83d746eb99f50f42c15cf4c47c2ea5f3b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082635-dislike-tipping-1bee@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f2916c83d746 ("net: ngbe: Fix phy mode set to external phy")
bc2426d74aa3 ("net: ngbe: convert phylib to phylink")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2916c83d746eb99f50f42c15cf4c47c2ea5f3b3 Mon Sep 17 00:00:00 2001
From: Mengyuan Lou <mengyuanlou@net-swift.com>
Date: Tue, 20 Aug 2024 11:04:25 +0800
Subject: [PATCH] net: ngbe: Fix phy mode set to external phy

The MAC only has add the TX delay and it can not be modified.
MAC and PHY are both set the TX delay cause transmission problems.
So just disable TX delay in PHY, when use rgmii to attach to
external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
And it is does not matter to internal phy.

Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: stable@vger.kernel.org # 6.3+
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index ec54b18c5fe7..a5e9b779c44d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -124,8 +124,12 @@ static int ngbe_phylink_init(struct wx *wx)
 				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 	config->mac_managed_pm = true;
 
-	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
-	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);
+	/* The MAC only has add the Tx delay and it can not be modified.
+	 * So just disable TX delay in PHY, and it is does not matter to
+	 * internal phy.
+	 */
+	phy_mode = PHY_INTERFACE_MODE_RGMII_RXID;
+	__set_bit(PHY_INTERFACE_MODE_RGMII_RXID, config->supported_interfaces);
 
 	phylink = phylink_create(config, NULL, phy_mode, &ngbe_mac_ops);
 	if (IS_ERR(phylink))


