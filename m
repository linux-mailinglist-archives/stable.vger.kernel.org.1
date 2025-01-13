Return-Path: <stable+bounces-108352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2DAA0AD78
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C65B3A648D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982B13B7B3;
	Mon, 13 Jan 2025 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCRJCbd1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D113A3ED;
	Mon, 13 Jan 2025 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735853; cv=none; b=kLnxPHkEFYiiiHqiRV0qymjFNkdGOFa3Gl/aHiA+7jZt0IMTsLvUIh0NY8eABpUh7BhoLJ41sLx22+QpDE5qCRIefhHH3wUugSeGHx0BeC8F8D+UZRh6rc9VE/lEuRhXZBAE0QsNORq7vGMFgspEmNcPGmdKidXeQUv2UzS6HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735853; c=relaxed/simple;
	bh=Y6KhVL19YV85Fry25EY0/X1r2wmsqcdo/rcDS2pSbuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q56mE0lsNHJxW8arm8TIPbSdydIuHX0HmaOTynC7p2jLz1j+DrLoRXKNRuY4VK5sfWjgOZ9dmkI63LOcgdWUnUw81aA0fgccwLqRo4qyjoILx3esp+VtH/miuZYM04kN3EurKZV8xwzhTyFzD1nHXliEQL6SRfu9bEiC9b/lbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCRJCbd1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21644aca3a0so82459945ad.3;
        Sun, 12 Jan 2025 18:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736735850; x=1737340650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVpCT3rcttjqBCAryOiu/i2BhEIjXBBLZY4oPFbVZO8=;
        b=KCRJCbd13b4attLj4iwzB+gsOoZ1j+vyHNy2mnVxJ2cqvBzc5R3al0/030xn/9H5um
         7rn8yMf8ny9YdHZ0ux0cA6MqdlHQtjTqTYBMPbvrsa6TekHov2hafGB3LKk6r2mcBMFy
         +Dqxtjm0TvI8eu1Si9Q3Zme244nZ10CowBkTI15v9FGmj61pGAGdvzCQK3yydOf+U4Xc
         RvLrj8f3B093zUxhZgU6HT2DVs0cWJwXZModcxAm/FRNQti1yDbfrqPDqRPdmuSOZZlY
         lyKaq9a/yv+uE4oELDadQm07/RNW8aN2bfavSq+DphYm8DLwKR11B/7carpJoWiYCTRL
         2QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735850; x=1737340650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVpCT3rcttjqBCAryOiu/i2BhEIjXBBLZY4oPFbVZO8=;
        b=EKhS3g3q6ei3T9dISS+LOHTMLClIUL45edB45vDhYTVofaergFEV0NYLG6Rtpa9Np5
         +qGlyFTt0lV13ClTVE/eaWEo70O/Mz0ESqrxiw4lrN7RwASDvNAGUlMLRRsROc6L+2d6
         0OcHFmHkbhY4mUH8QCoLa7ZDUPkMJiNGJqABnZKpYJFcB+1ilTJvyu0G6AVkQH0eElqc
         nqBX9v+dr+E7bnov5IaEDH7sUxH+/zGCJ11/xnH27kDri+kCTn15ctYOjmUu939rc50y
         Sbf9FEKZgbQe4F+cEY6aB9g662i/0s2G3UUbWZQdeI8YSBMa9SzNRpUXSYyZ51WJaKl+
         syng==
X-Forwarded-Encrypted: i=1; AJvYcCVbH6gLZZbNocb6c6RafJQnAZKHRobBn9wZl5owR/7P8MPhplsax4qx8tjbovoSF1to+7sJS3o5@vger.kernel.org, AJvYcCXciO8u+Ra2LnPAH8MtPAumNe+bOzcv6E0x9cdRISjkj63krkaf+4hmYsGyVQJ/Rsw2erzJZlTR3/xTuJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxED3UHQZ6fPjVkiIQ8B/drwJZJDum2bz6rEJAUVGFEkbLs7IQR
	N1IeF0WIDI8dxu4Xaw+lLEw1tu3Eewg2Y7kMzDYx/7dUhUtuP3p3
X-Gm-Gg: ASbGnctMw/Z/f5z/n2CZ5LQ7DH/61kzhLbH7E5mXeM6ayH9gU/lXcQ4qhdjn4hlENmO
	7JKz/ot13W3tlLZZdLITggW1l/sYuT15GibUZiQ4qbCEdVsGdEmeN7XTCbm65bF/LzY1z6ddNWV
	OgtHdPmuv1i29MOemTQDWVkOpD9aBAwv6cei4II9zvnX6zJvwqs3Ztabc1ObWiLqn8gNq9hB5OA
	UbKEVvHjMyDVswhoFe4qE6SwMNICz2P+8kJgQIk6aUruZX0WSsLTDgzwpOqk8RPZ+dRGOQE8HrL
	WC+ejCAD2A2w0Qq0yEWeWHF+igcQZP0w4g==
X-Google-Smtp-Source: AGHT+IE5TKvbOESyK9xXOwvGK+IBt5u58ji2MA/Uoomwstpjcm7V1SUxV/hdXfskw10cXRlCE66W5A==
X-Received: by 2002:a17:902:ea03:b0:216:2d42:2e05 with SMTP id d9443c01a7336-21a83f6fa87mr363502565ad.22.1736735850129;
        Sun, 12 Jan 2025 18:37:30 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d2dasm44639045ad.172.2025.01.12.18.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 18:37:29 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jan 2025 10:34:47 +0800
Subject: [PATCH v3 1/2] net/ncsi: fix locking in Get MAC Address handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-fix-ncsi-mac-v3-1-564c8277eb1d@gmail.com>
References: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
In-Reply-To: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Paul Fertser <fercerpav@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736735843; l=4642;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=cFqw/9YqoODz1OY0OrdpTECRIy/akueGHaQLjcYInTk=;
 b=aF9PMC6FRZuulNn9hyNXl5Syc4CTTDfVqO3hHLwj3mwYA4Rq5LUEJRlZlg9Taftw+vQkLiyRt
 O1vzrylk/67DkGxg3DL/OA5CzdE37W0HlrVVV2Vbe1aMtDoWuW9cmBJ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Paul Fertser <fercerpav@gmail.com>

Obtaining RTNL lock in a response handler is not allowed since it runs
in an atomic softirq context. Postpone setting the MAC address by adding
a dedicated step to the configuration FSM.

Fixes: 790071347a0a ("net/ncsi: change from ndo_set_mac_address to dev_set_mac_address")
Cc: stable@vger.kernel.org
Cc: Potin Lai <potin.lai@quantatw.com>
Link: https://lore.kernel.org/20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 net/ncsi/internal.h    |  2 ++
 net/ncsi/ncsi-manage.c | 16 ++++++++++++++--
 net/ncsi/ncsi-rsp.c    | 19 ++++++-------------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ef0f8f73826f..4e0842df5234 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -289,6 +289,7 @@ enum {
 	ncsi_dev_state_config_sp	= 0x0301,
 	ncsi_dev_state_config_cis,
 	ncsi_dev_state_config_oem_gma,
+	ncsi_dev_state_config_apply_mac,
 	ncsi_dev_state_config_clear_vids,
 	ncsi_dev_state_config_svf,
 	ncsi_dev_state_config_ev,
@@ -322,6 +323,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_RESHUFFLE	4
 #define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
+	struct sockaddr     pending_mac;     /* MAC address received from GMA */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5cf55bde366d..bf276eaf9330 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1038,7 +1038,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
-		nd->state = ncsi_dev_state_config_clear_vids;
+		nd->state = ncsi_dev_state_config_apply_mac;
 
 		nca.package = np->id;
 		nca.channel = nc->id;
@@ -1050,10 +1050,22 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_OEM;
 			ret = ncsi_gma_handler(&nca, nc->version.mf_id);
 		}
-		if (ret < 0)
+		if (ret < 0) {
+			nd->state = ncsi_dev_state_config_clear_vids;
 			schedule_work(&ndp->work);
+		}
 
 		break;
+	case ncsi_dev_state_config_apply_mac:
+		rtnl_lock();
+		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
+		rtnl_unlock();
+		if (ret < 0)
+			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
+
+		nd->state = ncsi_dev_state_config_clear_vids;
+
+		fallthrough;
 	case ncsi_dev_state_config_clear_vids:
 	case ncsi_dev_state_config_svf:
 	case ncsi_dev_state_config_ev:
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c..14bd66909ca4 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -628,16 +628,14 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
-	int ret = 0;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
 
-	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
 		mac_addr_off = BCM_MAC_ADDR_OFFSET;
@@ -646,22 +644,17 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
-	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	saddr->sa_family = ndev->type;
+	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		eth_addr_inc((u8 *)saddr->sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
 		return -ENXIO;
 
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	rtnl_lock();
-	ret = dev_set_mac_address(ndev, &saddr, NULL);
-	rtnl_unlock();
-	if (ret < 0)
-		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
+	return 0;
 }
 
 /* Response handler for Mellanox card */

-- 
2.31.1


