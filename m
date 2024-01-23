Return-Path: <stable+bounces-13773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881EF837DF8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDE1F29BB5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531455C21;
	Tue, 23 Jan 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXtUuaUx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B54524BD;
	Tue, 23 Jan 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970228; cv=none; b=ukQkcViWf28WS+iUb/HtfA5pxesyO3N2p8e7e4yTFpl9D1FteRnzRAmxxZQYmWlqq5KA9e3aoXinBS0yqJGfl85weC+gQCRPHQvsqeET/nePKl/S5dsLqG86qDXpEYFSTCS7ytMXNkpCzba/jYaL7P2bChDYyqJX+Ep3OZx4mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970228; c=relaxed/simple;
	bh=TndkChpOZECioYWZ9E5Jq7WskBr1Ov3fZyyLliWoOe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj9iPWbqOOqlFwiRfR3vqSQOpNxANr7re92tNiwzMf2wABCIKPpWdp3KLXkN20qwnUCzzzKWvP8OxQM+oMMIOpp6GIxrGbAclfTilg1EHHPxl8ouS29367rkqgkMwQ4vFBqphHV2xle2nNNwL2upQLqk3RyRjRxwKAIAt8G8AzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXtUuaUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5F2C433C7;
	Tue, 23 Jan 2024 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970227;
	bh=TndkChpOZECioYWZ9E5Jq7WskBr1Ov3fZyyLliWoOe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXtUuaUxI8eSnxB+fZ43HAhIN/usgndwXs47wfZc1F8UCWhyx4UdhdxUtiU9xHm3J
	 yyvgrOlNk93kWOfIAE3oTPnjnvxqqbiC3t/I4ko7OPM06k+3MrWLyNftCwCgpxUR+m
	 3krx+X2URRcvqkfHnZm+WQKVlCTnR1WBQnlaGnuE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 618/641] net: netdevsim: dont try to destroy PHC on VFs
Date: Mon, 22 Jan 2024 15:58:42 -0800
Message-ID: <20240122235837.583789943@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ea937f77208323d35ffe2f8d8fc81b00118bfcda ]

PHC gets initialized in nsim_init_netdevsim(), which
is only called if (nsim_dev_port_is_pf()).

Create a counterpart of nsim_init_netdevsim() and
move the mock_phc_destroy() there.

This fixes a crash trying to destroy netdevsim with
VFs instantiated, as caught by running the devlink.sh test:

    BUG: kernel NULL pointer dereference, address: 00000000000000b8
    RIP: 0010:mock_phc_destroy+0xd/0x30
    Call Trace:
     <TASK>
     nsim_destroy+0x4a/0x70 [netdevsim]
     __nsim_dev_port_del+0x47/0x70 [netdevsim]
     nsim_dev_reload_destroy+0x105/0x120 [netdevsim]
     nsim_drv_remove+0x2f/0xb0 [netdevsim]
     device_release_driver_internal+0x1a1/0x210
     bus_remove_device+0xd5/0x120
     device_del+0x159/0x490
     device_unregister+0x12/0x30
     del_device_store+0x11a/0x1a0 [netdevsim]
     kernfs_fop_write_iter+0x130/0x1d0
     vfs_write+0x30b/0x4b0
     ksys_write+0x69/0xf0
     do_syscall_64+0xcc/0x1e0
     entry_SYSCALL_64_after_hwframe+0x6f/0x77

Fixes: b63e78fca889 ("net: netdevsim: use mock PHC driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aecaf5f44374..77e8250282a5 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -369,6 +369,12 @@ static int nsim_init_netdevsim_vf(struct netdevsim *ns)
 	return err;
 }
 
+static void nsim_exit_netdevsim(struct netdevsim *ns)
+{
+	nsim_udp_tunnels_info_destroy(ns->netdev);
+	mock_phc_destroy(ns->phc);
+}
+
 struct netdevsim *
 nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 {
@@ -417,8 +423,7 @@ void nsim_destroy(struct netdevsim *ns)
 	}
 	rtnl_unlock();
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
-		nsim_udp_tunnels_info_destroy(dev);
-	mock_phc_destroy(ns->phc);
+		nsim_exit_netdevsim(ns);
 	free_netdev(dev);
 }
 
-- 
2.43.0




