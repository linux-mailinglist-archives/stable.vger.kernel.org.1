Return-Path: <stable+bounces-54417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6E90EE13
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B51C20CAA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50C145FEF;
	Wed, 19 Jun 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lg59T4xX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC52143757;
	Wed, 19 Jun 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803519; cv=none; b=UbL8P1FfjOa4hYeiCJAmO53AbUxkIcLJsEePjlDZGgHSw/NhvzzK2klPJUAhMVKORU3CKVVlm+lvL/1xhHCkmhzy1H9YKKDOgbL+wxNnMyIn8OUNOtdlruXCNr4YByELUwWbGAtTfyVZEiDk/PRXUFv46peEwth3TeZNHYId/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803519; c=relaxed/simple;
	bh=4DatPNcI1fXOgNn1BRefa5ywb8lcdaMlFJYiqSC29Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeD1p81ptUmLNOAEyBtJDSRoH19asJMbKN0FLefWTIhuO7A6tySBGiNou3jJy5ygDgV9C4jSoXFNGZi1Sde6DekD5Iav11Fi36PQ0BvLKkcW7x3UMAqt4GT/e8G9IDiHPr/lzG9+u1VyEeu280DnV3RAE2OR97NsyrhGE7cqRHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lg59T4xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B17C2BBFC;
	Wed, 19 Jun 2024 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803518;
	bh=4DatPNcI1fXOgNn1BRefa5ywb8lcdaMlFJYiqSC29Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lg59T4xXW8QbSaETod5zPW88L8Rz0hIz1NggQk9hOdOZ+4Dsb6jtYfGV3zyetLsP9
	 icpo4LaLjHOJRDLM3yANiTVAgBX7Z1YIv9WodZkwJMwKmGqNJiVM7yK6tU5Xl+umJI
	 HAesnS2UX9sMIYy8FV1p0v2NA+5r0ONHmMsC7kcg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Delevoryas <peter@pjd.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/217] net/ncsi: Simplify Kconfig/dts control flow
Date: Wed, 19 Jun 2024 14:54:16 +0200
Message-ID: <20240619125557.151050423@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Delevoryas <peter@pjd.dev>

[ Upstream commit c797ce168930ce3d62a9b7fc4d7040963ee6a01e ]

Background:

1. CONFIG_NCSI_OEM_CMD_KEEP_PHY

If this is enabled, we send an extra OEM Intel command in the probe
sequence immediately after discovering a channel (e.g. after "Clear
Initial State").

2. CONFIG_NCSI_OEM_CMD_GET_MAC

If this is enabled, we send one of 3 OEM "Get MAC Address" commands from
Broadcom, Mellanox (Nvidida), and Intel in the *configuration* sequence
for a channel.

3. mellanox,multi-host (or mlx,multi-host)

Introduced by this patch:

https://lore.kernel.org/all/20200108234341.2590674-1-vijaykhemka@fb.com/

Which was actually originally from cosmo.chou@quantatw.com:

https://github.com/facebook/openbmc-linux/commit/9f132a10ec48db84613519258cd8a317fb9c8f1b

Cosmo claimed that the Nvidia ConnectX-4 and ConnectX-6 NIC's don't
respond to Get Version ID, et. al in the probe sequence unless you send
the Set MC Affinity command first.

Problem Statement:

We've been using a combination of #ifdef code blocks and IS_ENABLED()
conditions to conditionally send these OEM commands.

It makes adding any new code around these commands hard to understand.

Solution:

In this patch, I just want to remove the conditionally compiled blocks
of code, and always use IS_ENABLED(...) to do dynamic control flow.

I don't think the small amount of code this adds to non-users of the OEM
Kconfigs is a big deal.

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e85e271dec02 ("net/ncsi: Fix the multi thread manner of NCSI driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ncsi/ncsi-manage.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 80713febfac6d..f567957698935 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -689,8 +689,6 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY)
-
 static int ncsi_oem_keep_phy_intel(struct ncsi_cmd_arg *nca)
 {
 	unsigned char data[NCSI_OEM_INTEL_CMD_KEEP_PHY_LEN];
@@ -716,10 +714,6 @@ static int ncsi_oem_keep_phy_intel(struct ncsi_cmd_arg *nca)
 	return ret;
 }
 
-#endif
-
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
-
 /* NCSI OEM Command APIs */
 static int ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
 {
@@ -856,8 +850,6 @@ static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
 	return nch->handler(nca);
 }
 
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-
 /* Determine if a given channel from the channel_queue should be used for Tx */
 static bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp,
 			       struct ncsi_channel *nc)
@@ -1039,20 +1031,18 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			goto error;
 		}
 
-		nd->state = ncsi_dev_state_config_oem_gma;
+		nd->state = IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
+			  ? ncsi_dev_state_config_oem_gma
+			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
 		nd->state = ncsi_dev_state_config_clear_vids;
-		ret = -1;
 
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
 		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = np->id;
 		nca.channel = nc->id;
 		ndp->pending_req_num = 1;
 		ret = ncsi_gma_handler(&nca, nc->version.mf_id);
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
-
 		if (ret < 0)
 			schedule_work(&ndp->work);
 
@@ -1404,7 +1394,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		schedule_work(&ndp->work);
 		break;
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
 	case ncsi_dev_state_probe_mlx_gma:
 		ndp->pending_req_num = 1;
 
@@ -1429,7 +1418,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_cis;
 		break;
-#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
 	case ncsi_dev_state_probe_cis:
 		ndp->pending_req_num = NCSI_RESERVED_CHANNEL;
 
@@ -1447,7 +1435,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		if (IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY))
 			nd->state = ncsi_dev_state_probe_keep_phy;
 		break;
-#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_KEEP_PHY)
 	case ncsi_dev_state_probe_keep_phy:
 		ndp->pending_req_num = 1;
 
@@ -1460,7 +1447,6 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 
 		nd->state = ncsi_dev_state_probe_gvi;
 		break;
-#endif /* CONFIG_NCSI_OEM_CMD_KEEP_PHY */
 	case ncsi_dev_state_probe_gvi:
 	case ncsi_dev_state_probe_gc:
 	case ncsi_dev_state_probe_gls:
-- 
2.43.0




