Return-Path: <stable+bounces-1991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8207F824A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956A4B23B12
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8533CFD;
	Fri, 24 Nov 2023 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMIk/4Hf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692312C87B;
	Fri, 24 Nov 2023 19:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96830C433C7;
	Fri, 24 Nov 2023 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852779;
	bh=ZcfM/dDrEupyHktlpBUYvT8dMaBmU0dATCdOGfKfOfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMIk/4HfXXN8cu09EE9FJ3vfjokHJgh7NEvOgwLf1Y++WRUf616fe/La4/tlZNlXq
	 aiNdASZkaQS3Sd7ynl9oOBcZUtK3Bg8kGR+FEOsMpxlmnodlimpRjJEv73jJo2NYoB
	 406Rh679ixcsYbOOFcZefy4ngRh3AG7af8sEp36M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gal Pressman <gal@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 085/193] macvlan: Dont propagate promisc change to lower dev in passthru
Date: Fri, 24 Nov 2023 17:53:32 +0000
Message-ID: <20231124171950.644835484@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 7e1caeace0418381f36b3aa8403dfd82fc57fc53 ]

Macvlan device in passthru mode sets its lower device promiscuous mode
according to its MACVLAN_FLAG_NOPROMISC flag instead of synchronizing it to
its own promiscuity setting. However, macvlan_change_rx_flags() function
doesn't check the mode before propagating such changes to the lower device
which can cause net_device->promiscuity counter overflow as illustrated by
reproduction example [0] and resulting dmesg log [1]. Fix the issue by
first verifying the mode in macvlan_change_rx_flags() function before
propagating promiscuous mode change to the lower device.

[0]:
ip link add macvlan1 link enp8s0f0 type macvlan mode passthru
ip link set macvlan1 promisc on
ip l set dev macvlan1 up
ip link set macvlan1 promisc off
ip l set dev macvlan1 down
ip l set dev macvlan1 up

[1]:
[ 5156.281724] macvlan1: entered promiscuous mode
[ 5156.285467] mlx5_core 0000:08:00.0 enp8s0f0: entered promiscuous mode
[ 5156.287639] macvlan1: left promiscuous mode
[ 5156.288339] mlx5_core 0000:08:00.0 enp8s0f0: left promiscuous mode
[ 5156.290907] mlx5_core 0000:08:00.0 enp8s0f0: entered promiscuous mode
[ 5156.317197] mlx5_core 0000:08:00.0 enp8s0f0: promiscuity touches roof, set promiscuity failed. promiscuity feature of device might be broken.

Fixes: efdbd2b30caa ("macvlan: Propagate promiscuity setting to lower devices.")
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20231114175915.1649154-1-vladbu@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macvlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 5869bc2c3aa79..9c77e6ab2b307 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -765,7 +765,7 @@ static void macvlan_change_rx_flags(struct net_device *dev, int change)
 	if (dev->flags & IFF_UP) {
 		if (change & IFF_ALLMULTI)
 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
+		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
 			dev_set_promiscuity(lowerdev,
 					    dev->flags & IFF_PROMISC ? 1 : -1);
 
-- 
2.42.0




