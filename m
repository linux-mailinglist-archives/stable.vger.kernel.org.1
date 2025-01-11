Return-Path: <stable+bounces-108264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C1A0A335
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9016B82B
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2019342F;
	Sat, 11 Jan 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVpzVPar"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF80192D68;
	Sat, 11 Jan 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736593355; cv=none; b=bKjbT+FT06zH4Xj/i9rB43h713VPtEiTizoVsH5N9c+rd3mFkYx79XMEc1XYXxIZTNz9I9rqfYCLGD6rLFdGiECLd5hzf/EbU3RJx4ByVs3pG4NB713neEyM3L5YGY7CQz+2Kuw/YsvScTfv31nQXPpMFo61p/LllVNlAVDBOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736593355; c=relaxed/simple;
	bh=Y6KhVL19YV85Fry25EY0/X1r2wmsqcdo/rcDS2pSbuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HlOuXfNTvGlarKily/Xdh3v6LVA6aNbmXyviP9dgyH4iQaov7TPyYU2LFN+AootUcCnh8WeqrF/sA/BHhqm/Bdg+0zzLRgvhC6XFdUEn+t6RhGZnYhnQrlEWAaaKasgnOVo81K3BorJvqNCSOnScmiPYz3qkgVj50n2ba6MRl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVpzVPar; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21631789fcdso51208745ad.1;
        Sat, 11 Jan 2025 03:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736593353; x=1737198153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVpCT3rcttjqBCAryOiu/i2BhEIjXBBLZY4oPFbVZO8=;
        b=FVpzVParttcJbaUjPPnUdWR0MyuMExDhfPDbyAdU5BeAefJbvIClK8CzEzHSrTv+2T
         idwDVAS//vr5LO0CzVK++Svyrrk5Y3GaKUQcJNE+4qqXgTkD7JmU4AgGUbbN5Ghaql7k
         is29GfZT6YaQXyRVX6w7hHNV76YcCh+ZBXNEjrpZYLGfiVu5vZReLeAs48F/ARpEvlw2
         1w/tg1qyblC95R0Lvzl5bsOuLclqNTEF3EmmsYhpco+gka2ZVt376qPjp+9y3eKLwgki
         CWCUioBc8a38qsAWGAQKYd0v1frt6Z7lj3Lhi9U4csv9/sNnlVtKPe40pzyJpp1rC+v+
         v4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736593353; x=1737198153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVpCT3rcttjqBCAryOiu/i2BhEIjXBBLZY4oPFbVZO8=;
        b=d5aucKX3QhIAmohhyQHWZm/RxqZU46Y9j4KFsfHJuedSA0NbM/4sbgFQZcyNPhihgr
         obxnOjPdU0W03/iB4plIznhHsmRpYj4t33OEbHjr29CRhJCXcOi/JmnOQgB8hhdSwEeW
         Hx4RnfKUwIRZx7o87a6POl9TByCs8QtTDbsN5FswkcjM404r+cmLRbyXwb6mYzq3yzOl
         WtMsu3dLL6yuxb8yTk74FORIcpHnIF7XMQ58YZvOkyvWE/Mu5eA+FbaZ6hneMQT4ZyjP
         zT45PHhVRUnDqSzi73jGV5QwTqn7Owp2rDFeRq/HHQVTrfYIgMaM2KWaP/LgDAbV8Kc6
         RRRg==
X-Forwarded-Encrypted: i=1; AJvYcCUY7tNott+usAc+SGagL5kXpiHseW9GvAzfBpwlneE5Fht+iOrvaLFlz5CTZYYIow3dH5hkj+lGQoMlFFE=@vger.kernel.org, AJvYcCXhZHWht0lxKy0rc+flGWPcPjhGR9NZfUjglj3WTNOoaUWRg6rzsGtqvHavhtydNCWy0CBHO2zR@vger.kernel.org
X-Gm-Message-State: AOJu0YwEY69LzvK70EAzU5m+9wI0dkxJqgrRY2rgHuUE8wc5ZGPaQ7N5
	bTXqKchK87l1iERS30Nvgy9dYLPJLQyI4WOB2pxv2TwEoQbil+YA
X-Gm-Gg: ASbGncspC/eO43RLkKzJtAGduDxpkJK1mr2N6akoT6duhJb1/dmY/iHyaWj+SL0+26c
	uxE6WCy7leng7f3VTwhjjdEwdOi7itZrUa8XC3TCuWXU/kgsPrmUVwXtssCpDvedoMxsGLyoIiv
	h5kwOPw0oY2HnY4oiGawXR3GEFGqKVfuUspJFX+3YlG1qA6trgm2NmAtD+GodBwfSuZERQBGmBm
	1CuMZ1xWV1h/3cWoSVfkxNqZLUXgnxO6KWPSgqJYb1tS8bVh4CXFThqnoMZ2AtH4EUR+KO9v86N
	TaTGGS39vj+Zru4YbepD0YbP5PeGPzRGnA==
X-Google-Smtp-Source: AGHT+IEcD9OT11Ou4Y2pyiA193+J6lV+T/yvDgGlAPaw+09HcDol3efs3vXKL3WRKfcOw4uW2c6xPQ==
X-Received: by 2002:a05:6a00:170a:b0:725:4915:c0f with SMTP id d2e1a72fcca58-72d32506c6fmr13542406b3a.11.1736593352792;
        Sat, 11 Jan 2025 03:02:32 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e5csm2953826b3a.143.2025.01.11.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 03:02:32 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Sat, 11 Jan 2025 18:59:43 +0800
Subject: [PATCH v2 1/2] net/ncsi: fix locking in Get MAC Address handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-fix-ncsi-mac-v2-1-838e0a1a233a@gmail.com>
References: <20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com>
In-Reply-To: <20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Paul Fertser <fercerpav@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736593346; l=4642;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=cFqw/9YqoODz1OY0OrdpTECRIy/akueGHaQLjcYInTk=;
 b=VSDFIlISZcdXBGHiAP9eXB9tASxrJb4HYzysgZyjMOYOvD/dQj0ifvZdaKEItbTs0xSGGsaBi
 Qz5mtsiVyKxB2zZQnZUWAioOyyAo+lMYVaH2bVbgQWvqzZh6ySPdVF8
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


