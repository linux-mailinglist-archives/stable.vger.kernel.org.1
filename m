Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D5740D33
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1JjM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 05:39:12 -0400
Received: from mail-bn8nam04on2092.outbound.protection.outlook.com ([40.107.100.92]:2784
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234799AbjF1JdI (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Jun 2023 05:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIr75OPT75PtSSSmfs6eIlsDCJcNYmHZ+Fq5MGtQyRLRWD26AotGS+KBcKenE+qbxTKwu/vVvmfI8Xew5OVxU+64cpyMlRHFd6FFB7M0NGXI/+9+EIsZo1igY8qEC2eD73q/3OBQwUi5+cq4pY+brWgbEtdf51UUL57qCxKd7CKg8tP4H/kyznzHZ3veJu4cZTfJ6R3qizLxhWeJND4MOz1RPG3aKyOd8Fcy5U4WJHISq3BCFZo/BSpUPgSY57c90zfQYhOBtlnYh8BnXihT+3QuqK8b8M8akVV9mfCx9GLEjgdEkKUHURwpWO741YD0yPWf6yjqF5wXhGfaG0Oo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjSRQTW6XGeft8RU0JtnPzeNw9OKrnWqpKMGEO1ePTc=;
 b=ESHCIGmcMW8H3rCInYZerhyONR/Frv/7gt/6tR0Uf2cHp+ty6rJAKXX52UP5lvY4e1s+0XWkCBqQ8ehd+uM1aNiNFH3wGzvgtGvokZvIy+WMYOTyzH/DGMVNUFAafgO0y8/KZHS03CE3wd6F0xEcCRAwGFQsj355x7LJME/oLPn/JM5G1MPzGH/QkatdrOmyKM3g9ldB2WpbWmdrwgRlVWDp+ggAHpWz3zkc3aev1YG1rb8uIbjVQYta8uENqUkHn3iyf6l3GtXyVUK3kSaGl4VFBMnV9k+INxgL0uW6btKpmZeCTI7i8k811BfvRDDiKyzkltLoRFAhKTtaRrHD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjSRQTW6XGeft8RU0JtnPzeNw9OKrnWqpKMGEO1ePTc=;
 b=rsF+OQkHMmw2YtWoOJIw5p9y9HGs3KCNz414mJvnZlfTNgyTGmS06UXlqg/Qb9XeggTpyHm0qewREqnUh8wovmioKdVTemL2EJfUw1h7bmOKtJHpzCOTiv0Utq/0MCozIFSOqCAFX/AItPRNZdW4CXB8QSQLT2UsmCyWAlwFI9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 PH7PR13MB6294.namprd13.prod.outlook.com (2603:10b6:510:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 09:33:04 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 09:33:04 +0000
From:   Louis Peens <louis.peens@corigine.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        oss-drivers@corigine.com
Subject: [PATCH net] nfp: clean mc addresses in application firmware when driver exits
Date:   Wed, 28 Jun 2023 11:32:28 +0200
Message-Id: <20230628093228.12388-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::23)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|PH7PR13MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b69bff6-923a-4a01-5316-08db77baabef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujs4wVjXCVkehmjFYw4zZYPEZ6B36/AiTRXvVjP1sZGojbqa+SmGjq8yusOXnR9eLFFUPdp/hEsuasydngPdTlkxvdVv1JWgF+AsgFJr5CZsOSC5oh+AxdRKIWUOtTUvukCnirv/cpLm/UKAZOAmHLfq7lN1GcNzwYV5px6YvYRbqLOrzgDsF7vRZmkHGoOgHchvjcECduwX0STYoA/jWHVl4tUTGDTtT7lwTXB0aHNrOmTjlWmhJXUzd1ECmIH7k7KLPc5W1b0aEaL59T+Bno0LPVVGVRcgu8y2ovQPXriNDI04+gwNGbjCOjYqALLjqiS2uAfapj3TGz7WIbp1IYM0OEJ6oEWdkrZcH4uf4BB3ZIWKUxwdCxiT9Mctv0gXC3tS2jfaDz3K+drv+2SF4FRdHM1+0Q0vCq3xbRa1Dd8ZTzHyVh8HPiCQRqAxpD4F7mpw7wh6rWlSUY1r4YpsVeBSJDEY/sUq0MuU02GlIEq4JfvFHhi+WG8j7E0x1WaBgm0keD8J4dBO8MUwB4n8FmDbRv3dyKllLP5Lb3+zR/fxMgFDi6SdTFC21oZsSbKnCvuEA/AI0NJC8hNWHlKQI3wVFOSYbaj2IlHeAAWr0F4GGecJLVbzVbdWmP0ofZ393hwY5n/xK3s7TypGkOCufIOJz2GO3y1Jem+8mY4+jU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(451199021)(44832011)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8936002)(8676002)(2906002)(110136005)(54906003)(41300700001)(6486002)(52116002)(186003)(38350700002)(86362001)(26005)(6506007)(6512007)(6666004)(1076003)(107886003)(2616005)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0oEGZyqUWWuHHjAe6F/3P0lasjEjHW9+rJ0XDJB4/mAo1lJyIVuo0FGw8RzR?=
 =?us-ascii?Q?lfBV5bE3ba1AlHL1WxRNk/kQnHGJjy7aMR7FFLj30FlUxjBWhODTYx25IGig?=
 =?us-ascii?Q?CjvfVIS+qfsf64fEt9Yk52e/x1Y0foYeTIv0D6Jd3acO3oo21NGs/re3g5Py?=
 =?us-ascii?Q?PUmbAbRD/9TuzaMQke9WVJuPJpTLm/HMmqK34LrX2xVSe/hp5WN0zZbZSu/H?=
 =?us-ascii?Q?S0rkD2hK/vhqgMpv04+T8A2RP/gkEcGr9/QADmdjf/NJW1XhHZ1G9rM7xzWj?=
 =?us-ascii?Q?pUxs8Kxr07bUcByMwoGCrL05jlDU1Y3OrJMtMjkmPv2+kDea4U5nADlyglph?=
 =?us-ascii?Q?/lLRerWoGqkNcFOROZdWMOkBcJgluwJ+Zv8AiJ8pv9Xkvosmn49j9wBMA4DA?=
 =?us-ascii?Q?NKLIYIDZdx3i7zr5E9xMTQLiravhvAvvlx2cwXm3hUnXR0QISUZLC08mpOJz?=
 =?us-ascii?Q?L/bQG0whI4z3mMMBDfO7SgRufzltrch1RsVYzjCF2Ui2PTTQLeZ+TZqCueCM?=
 =?us-ascii?Q?zb5OU/W+RdKPdNxWoaYRzbBYPFKGe+keY3Avc1RzNVCJbtrD18B1H8LkUOp/?=
 =?us-ascii?Q?scSlAL0lNnrVd0Ts3aX5TnG/fqCOgolI2p4IQaZfHpT2xLfMRjZhURGof8XV?=
 =?us-ascii?Q?o3ylwLKMYzckKudyAbjNTTFx3TQ4Z1fGUrhpucwnQKSiNvUeiqLtDHkWwWX5?=
 =?us-ascii?Q?4X53sGlHdVQ+VfyVgQGYSo1pZwK3etPsDeibHCPRpO9zpumcKThMPdnADKJj?=
 =?us-ascii?Q?SqffSia8aQstgZfMgVQwyMYd+YYvkWntormXB751Ja3gwzh8G8zVeyxKsTt2?=
 =?us-ascii?Q?0m9LPiavBnz/8xISdCCx2R0cW8Q05RasyL5u+LxSDKUEQ1bhYD9lNiAz61MM?=
 =?us-ascii?Q?+ASty4fW/iArLm7E6nws4jMk+my6Yk2Y0AN7K6ODpz690CjZ5Nksfw+Cboi4?=
 =?us-ascii?Q?fc1l3cFmXxvhOTeu7bVFLazRvYl+AqfNve3cO85NdCXVuySle2O1EvLtnpMd?=
 =?us-ascii?Q?HCA+RLESOS7hN19n0oluyk3lKmNxO95HJV08+zpLZ9ImHAeQmM187kXNqEz0?=
 =?us-ascii?Q?5v5fwlcBJw9LWeBMTtStxwAHhoyJSZNOw7ATj+9wJQhKJN9fLNKUoERz2Frp?=
 =?us-ascii?Q?8ZZc0LyRvb1J/Yyb36v4vpn+Mr7tN9YXbb4Y1V0KRvfc2L5lpOCwPna7VLhG?=
 =?us-ascii?Q?vCPM1EOHLiwHSSo9U0uvlMRR1hzXNUcckuo+vwCxq3vzqygJs+A2qkB1O7g0?=
 =?us-ascii?Q?I3zIvleuuSmHGctwCdDFeTZVtjp79+E7vnI/MAEoLam8Ww/XENhgESRhCI+I?=
 =?us-ascii?Q?5XgA5TEtrOG15Hr46BYv/2HrZd7HXWzC7FlXOOzq1BLTK1cY1Uoy00p0KUZL?=
 =?us-ascii?Q?WyWP+zVFjZP3xgYj7N8RWdYdm1CUHe7sDRQ+TdIqL0U0HedpCKLWyIgo7sdY?=
 =?us-ascii?Q?2Aw/3WQRnOT/X9uBFZSHpoyscdqKT3z3BdUvtS5Dw7neerVYRUIpBlEmSB0Q?=
 =?us-ascii?Q?/ndBX6wcy//ezGyNbR8gVuOQ7QKdzhukFjv8dhL9+UmnlEgS8d0HTctwu2Ui?=
 =?us-ascii?Q?6YmDRkfB0MeNxSiVBtq4ACetiPQg0sPTxNKUtwIIcTbUHK3kbJXg5FNiYic4?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b69bff6-923a-4a01-5316-08db77baabef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:33:03.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7jB65dKC7m94q3WtXJiMfqCaxxfp/pf0umls7E108JdTGfpuZ0gQ78P6cxAZPBX/ujrCONr7LgMbcG25CgNc7VfAY6frK8L0gvTU6qMvCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6294
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yinjun Zhang <yinjun.zhang@corigine.com>

The configured mc addresses are not removed from application firmware
when driver exits. This will cause resource leak when repeatedly
creating and destroying VFs.

Now use list to track configured mc addresses and remove them when
corresponding driver exits.

Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc address")
Cc: stable@vger.kernel.org
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  8 +++
 .../ethernet/netronome/nfp/nfp_net_common.c   | 66 +++++++++++++++++--
 2 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index 939cfce15830..b079b7a92a1d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -621,6 +621,7 @@ struct nfp_net_dp {
  * @mbox_amsg.lock:	Protect message list
  * @mbox_amsg.list:	List of message to process
  * @mbox_amsg.work:	Work to process message asynchronously
+ * @mc_list:		List of multicast mac address
  * @app_priv:		APP private data for this vNIC
  */
 struct nfp_net {
@@ -728,6 +729,8 @@ struct nfp_net {
 		struct work_struct work;
 	} mbox_amsg;
 
+	struct list_head mc_list;
+
 	void *app_priv;
 };
 
@@ -738,6 +741,11 @@ struct nfp_mbox_amsg_entry {
 	char msg[];
 };
 
+struct nfp_mc_entry {
+	struct list_head list;
+	u8 addr[ETH_ALEN];
+};
+
 int nfp_net_sched_mbox_amsg_work(struct nfp_net *nn, u32 cmd, const void *data, size_t len,
 				 int (*cb)(struct nfp_net *, struct nfp_mbox_amsg_entry *));
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 49f2f081ebb5..ccc49b330b51 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1380,9 +1380,8 @@ static void nfp_net_mbox_amsg_work(struct work_struct *work)
 	}
 }
 
-static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
+static int _nfp_net_mc_cfg(struct nfp_net *nn, unsigned char *addr, u32 cmd)
 {
-	unsigned char *addr = entry->msg;
 	int ret;
 
 	ret = nfp_net_mbox_lock(nn, NFP_NET_CFG_MULTICAST_SZ);
@@ -1394,12 +1393,30 @@ static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
 	nn_writew(nn, nn->tlv_caps.mbox_off + NFP_NET_CFG_MULTICAST_MAC_LO,
 		  get_unaligned_be16(addr + 4));
 
-	return nfp_net_mbox_reconfig_and_unlock(nn, entry->cmd);
+	return nfp_net_mbox_reconfig_and_unlock(nn, cmd);
+}
+
+static void nfp_net_mc_clean(struct nfp_net *nn)
+{
+	struct nfp_mc_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &nn->mc_list, list) {
+		_nfp_net_mc_cfg(nn, entry->addr, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL);
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
+{
+	return _nfp_net_mc_cfg(nn, entry->msg, entry->cmd);
 }
 
 static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
+	struct nfp_mc_entry *entry, *tmp;
+	int err;
 
 	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
 		nn_err(nn, "Requested number of MC addresses (%d) exceeds maximum (%d).\n",
@@ -1407,16 +1424,48 @@ static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
 		return -EINVAL;
 	}
 
-	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
-					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
+	list_for_each_entry_safe(entry, tmp, &nn->mc_list, list) {
+		if (ether_addr_equal(entry->addr, addr)) /* already existed */
+			return 0;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	err = nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
+					   NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
+	if (!err) {
+		ether_addr_copy(entry->addr, addr);
+		list_add_tail(&entry->list, &nn->mc_list);
+	} else {
+		kfree(entry);
+	}
+
+	return err;
 }
 
 static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
+	struct nfp_mc_entry *entry, *tmp;
+	int err;
+
+	list_for_each_entry_safe(entry, tmp, &nn->mc_list, list) {
+		if (ether_addr_equal(entry->addr, addr)) {
+			err = nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL,
+							   addr, NFP_NET_CFG_MULTICAST_SZ,
+							   nfp_net_mc_cfg);
+			if (!err) {
+				list_del(&entry->list);
+				kfree(entry);
+			}
+
+			return err;
+		}
+	}
 
-	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
-					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
+	return -ENOENT;
 }
 
 static void nfp_net_set_rx_mode(struct net_device *netdev)
@@ -2687,6 +2736,8 @@ int nfp_net_init(struct nfp_net *nn)
 			goto err_clean_mbox;
 
 		nfp_net_ipsec_init(nn);
+
+		INIT_LIST_HEAD(&nn->mc_list);
 	}
 
 	nfp_net_vecs_init(nn);
@@ -2718,5 +2769,6 @@ void nfp_net_clean(struct nfp_net *nn)
 	nfp_net_ipsec_clean(nn);
 	nfp_ccm_mbox_clean(nn);
 	flush_work(&nn->mbox_amsg.work);
+	nfp_net_mc_clean(nn);
 	nfp_net_reconfig_wait_posted(nn);
 }
-- 
2.34.1

