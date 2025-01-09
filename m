Return-Path: <stable+bounces-108125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A32A079C5
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AB93A0565
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902DC21B1AC;
	Thu,  9 Jan 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgASOfba"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B6218ADF;
	Thu,  9 Jan 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434367; cv=none; b=gwlSLS0KoOJo9C0T1nZChYIKWjWOrRX+e/psCst3empvH3GEum1Lhqf60i+qaYHebc+cn7//DsfU1/xpAOdtbpTbphp2I3+Bj1F4iYPpRKXDMT8cHJ9b0ENdvbp2f4HSH2qoDeOdNXIe04ELEBxdxQqWCFlGw8cdk7B66RfcpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434367; c=relaxed/simple;
	bh=8SUyeztxSfYEuPf867UH7332ILLd29BhGKf4E6KJPlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Srka2gHbb5xLrK6WxE/Ia48j+VFdt763NsZdpTqEFYFlkRQZc3sgCzcGpWxN/Ll0l7ZKHqt/F3u5BGVPS+FebyDA2iSU55F4fERO1J8FALBJNWVusPBopgVCvl1rehaAqX+s5GmvCv6s22X/S5oQxrDTp06HygI9eLdbSKukjjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgASOfba; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30219437e63so20032101fa.1;
        Thu, 09 Jan 2025 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736434364; x=1737039164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83q224DqQuNm+zNoQ5EstSn/VzVVCcXHF26zX26V9f0=;
        b=OgASOfba9nXDBmWnJYKpQawxM6Vm49V5ektcnTEVYzI4XB3l8uChaGVStwOznTooyl
         fm5aczqb+yUFhKH2unShn0UZg5VF2ydY2i/YPocMdvnMmaPx68GSnfHE1N3bdFmnDlmr
         A0A0e/zb9hCI0oM4w8PtBqpsR2tscbdxhCwr1y4GSST7QSAid6CUbSLzcRFyr1jtWUMq
         mvUN3Ptxc1me/77P5aWMm/XMK7pXMCt/r3q52svKpV9D4o8OdY+Za2YlM8Jba4W9VEDy
         0nRZyGLt9LBv8kUNXHzLwXPyPPN6PFWaUA3hy7nGJSUMNLm9Siz/akDvuQVmuaaMq9h+
         Vg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434364; x=1737039164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83q224DqQuNm+zNoQ5EstSn/VzVVCcXHF26zX26V9f0=;
        b=UuHzuSpa2QFPy94ijxMMVoYWychFsc6aFj5JKq+M9CVIJcu8f+Th7WLufpxPtp+REY
         NgrEPhrAwJuRMB5rHEH8u71W9gmi+r0iZAxqAN5jwk9mAH2TvBotWY36aPHRzjbbh89e
         K2zQRY4qykE/kl7uBg3sADLfxqNLVB5t8zSDn30Nzw5dUYNCEy8GNK6nx+NewGA1WNhL
         kqTxZ0GXWc3uslVzYOTU1hl585ZxpvfEF056lsSbfZtqJ5TK1o1pAenpLqwIj8QoNlkD
         eup3mzmJOOMgaQ1MNKkg/R1xZsKYoXvewgWNrBWB2kBALd+64gr63YRFLB9/kmoscBVh
         cRwg==
X-Forwarded-Encrypted: i=1; AJvYcCUySZaTTV1Qq4JBqoJrzuovUQQeQKixuiNmoJQ3Pyo9ZKHfwSq04B/NVFigGeUpKlgqfUXytAby@vger.kernel.org, AJvYcCWatBxB1ovtVdddJjlGlZHzVdD1jIZJ4fSjGig9nzXm2pX6aEobCFz/kKF9pMIlTHyvqrA9IuqH8+htB4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvV/YyiD8afvP2R2384aHwkfW5p1X0DZb5r4rxr0Pb+TjvM4cx
	yjJ82ZbEJbh8fkuOrN9wXDrnxw3/8jDJNPdcrO3LeL8joSZ1A3bI
X-Gm-Gg: ASbGncuZsrw7tzTQzE/o2N8DCSWgA3dwj/BYq/JXU8phnr2x5MUanEk4dzsL/mDSUL2
	wFGn1bjiHokr2+yAC7QW1Z/ymC4pU8NYOXHpnUo52EHZdZ/lIMIAw0kWc/7tuxKtqHZWJbHgWqR
	ENg4mI4FdYLI15bB1Wwox1foZ//RJPhenhbTkeUProBVb961igtY6WLDH3/8xk2AteJSOLDnKA1
	Ov0KAAunKZ1gXjkm1KrUKxceikxKWXNSpYF/j1b+Krqni7jQYGV3rei1hYUGadBkg5LCPY=
X-Google-Smtp-Source: AGHT+IFUYX7eQj92D1sisHWByPjp4i9BK/xkr+0gP2+UCnHOL9rqbl4Kb6y7twxPfLE8zJ97IBNq8Q==
X-Received: by 2002:a05:6512:b0f:b0:541:3175:19b4 with SMTP id 2adb3069b0e04-5428a603e75mr999592e87.11.1736434363326;
        Thu, 09 Jan 2025 06:52:43 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bea6b48sm219053e87.153.2025.01.09.06.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:52:42 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 509EqdAF030969;
	Thu, 9 Jan 2025 17:52:40 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 509Eqb4r030968;
	Thu, 9 Jan 2025 17:52:37 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Potin Lai <potin.lai@quantatw.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] net/ncsi: fix locking in Get MAC Address handling
Date: Thu,  9 Jan 2025 17:50:54 +0300
Message-Id: <20250109145054.30925-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250108192346.2646627-1-kuba@kernel.org>
References: <20250108192346.2646627-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.34.1


