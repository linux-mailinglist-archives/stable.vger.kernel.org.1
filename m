Return-Path: <stable+bounces-75845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A483C975612
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68471C227DE
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB2215C13F;
	Wed, 11 Sep 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="eizSyDBx"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB918F6C
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066357; cv=none; b=Hrc/bOj5vD8s2SoM8kvpZToeNFf17x8ktkAtItxieEiHrEjifUPOLgX1R3ZDv30JJ0SWCkGFfCYvlSyMMmkY8frnhQGtTy1jQDoVNrNc+U1tkprBDeJ29cCPpfjE/2LLVDWzoyp5N4lvv0PwjInEzxNwomzWX9BYqU86RQ0pQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066357; c=relaxed/simple;
	bh=f/128AteF2svPgXo8CH8dthfp+5ydTjymU4vIkiJJe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ua3fUQlpClOJ/qAt3Bn0HdXb1dDPEFvO0hGyqjg/pVdMjlqn3hWRDvsPcGLD/50H0IJKMhNC0iMoWL/ckoX6TYFZmokFWZ231Ke+DNNvp2okwsuZwlbw/1TCCXr/vIVwK/OVQHoPWV8ERjrTWpyj4ZwHOaTw9riojssTak7JrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=eizSyDBx; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202409111442165e00cd909981832c6c
        for <stable@vger.kernel.org>;
        Wed, 11 Sep 2024 16:42:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=c9PcQZFfNdq8cUu9sqpnFLswW6Zin2UTvho5Wq+tuEE=;
 b=eizSyDBxVpSvjni1XMMj6PhpkbTUBjCbkU/8EclL0rc/j2HAXGp6cFI5VV6J9NsnFZ65Ff
 Rs2XfVJLw04GNsVDnkIUVXLS0Q08s2MFeADXPip+FUkIstZDVp03Xyrk6XWKM3C8K+YvmVK2
 JHzWHkIbhsA6iFJZWT24DnqS0YoqqFLICVAPud3Vu4J8z0zbQRNHa5EGMvyUr7/lHPZ7LrKt
 ukm4xi/CXhO5KFDOMaKfeFfFg4JzgW+rLWN8/F90RXny/Tp9XbsDqSI2/wvSGVCiDw5ZT/oT
 VLUtQUfANBzjBNmVCspZj6VGRUQAwuBgQgQEzMgNVhRvioB7i5oRHzrg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Date: Wed, 11 Sep 2024 16:40:03 +0200
Message-ID: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

dsa_switch_shutdown() doesn't bring down any ports, but only disconnects
slaves from master. Packets still come afterwards into master port and the
ports are being polled for link status. This leads to crashes:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
CPU: 0 PID: 442 Comm: kworker/0:3 Tainted: G O 6.1.99+ #1
Workqueue: events_power_efficient phy_state_machine
pc : lan9303_mdio_phy_read
lr : lan9303_phy_read
Call trace:
 lan9303_mdio_phy_read
 lan9303_phy_read
 dsa_slave_phy_read
 __mdiobus_read
 mdiobus_read
 genphy_update_link
 genphy_read_status
 phy_check_link_status
 phy_state_machine
 process_one_work
 worker_thread

Call lan9303_remove() instead to really unregister all ports before zeroing
drvdata and dsa_ptr.

Fixes: 0650bf52b31f ("net: dsa: be compatible with masters which unregister on shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/lan9303-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 268949939636..ecd507355f51 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1477,7 +1477,7 @@ EXPORT_SYMBOL(lan9303_remove);
 
 void lan9303_shutdown(struct lan9303 *chip)
 {
-	dsa_switch_shutdown(chip->ds);
+	lan9303_remove(chip);
 }
 EXPORT_SYMBOL(lan9303_shutdown);
 
-- 
2.46.0


