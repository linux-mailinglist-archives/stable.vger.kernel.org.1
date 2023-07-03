Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D0745BCB
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCMB5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 08:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGCMB5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 08:01:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449891;
        Mon,  3 Jul 2023 05:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxZCd30835jnW4y/8/aKrDaWlXd+PFVbjhF5Zly/NjwXX9oIjIR5UCObP+qrpLSheazf9asRRVW5hTofLBYduEJg7RXaNoBTq8hIoEbzUpGaLswzxnN5r2irKYBcf+x56Az33DY4VXVOHteOPaQ6ymjAkl2ait3Ez8on/AM8M723lLtrTpjJYaUym6PqwyFdmAlRSqy//ss/vNrXxmexkvJ0IczLKR3UZLbY8QjkWJrJEUp2ruYVpsknLE//gU5EI5QiSNZXYvRgfbzvSsQIkpHzd0QOOmJDgWkqsAlHiYjGF8KeQmFypza/LfA5OK1T4DS5FnrG7kjqDbx4yaE9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkU1QIG+dakhGA8Knzt5FKGD0gN6Swajh3L/eYAgsoQ=;
 b=iZIET5KToB2695qV/20WhbU0oTe4RL3ipbis8esx3uXKnPEazUI2Rq5V40KPFVlS+W7H1uPqMB471EW6hQZiLnO3B374xDQfBLIzy3n6TRcWfHHs+r1QPV1oKiLELLNfpwPY99wEtcDk4dmz4umRkDkEEPsdm9gWTo+Mv4PiktClC1sPDef20QUxLwjSIAZFAbrsLHTezwJU7lNIAcyb21DiUWKsqEhbuFkIjeXkAthZJOO55Dn2aSy+akldQuTfljRJ0KkcuzxCFjye9ra8fGmerHFdIbCll7OSz0wpxlZkHGPj6qiIKNPWiQcFhPqHacpkar0qR1o7dzFN2KC2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkU1QIG+dakhGA8Knzt5FKGD0gN6Swajh3L/eYAgsoQ=;
 b=AX4OBiKbipkOBfiDTh95MM+I3I6Nr2paCqWwaMos6yLw6YEtCvAgYJq6iwBN8Z2VGVjnb94zbIlJhRGH8X1zI7AGOBt3Nz8Y43IvfzDeJP8I+vIANCJd0y3CcrNysUEugtPjIRmTibWVxPOufUijzUxkcVHHDvSBjyn83B7FOPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 BY5PR13MB3892.namprd13.prod.outlook.com (2603:10b6:a03:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:01:51 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:01:51 +0000
From:   Louis Peens <louis.peens@corigine.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        oss-drivers@corigine.com
Subject: [PATCH net v2] nfp: clean mc addresses in application firmware when closing port
Date:   Mon,  3 Jul 2023 14:01:16 +0200
Message-Id: <20230703120116.37444-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|BY5PR13MB3892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed8157d-53c2-4cf3-fa1b-08db7bbd4928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngh75n21Bn6S0/uINjZ7KiM3886Hjce1ktEPJu/0GTLteQrNNq+RnStVXM1DdNeScrfqcY3xRWIdDpjp7GwwuRsnss7feAkc/px6TmEqkyV8khxg9ywKLuk9VuwoKqPYnKJ4HpQYTvjAMRAI4fkfLTMSrKns/o+wZECh0pgeEAJQU2vVH71V4wdrJXTbxwfNelXgu6ckiKvmd+yKxrEYG9FJP3J7GGfWvLosm51nOw1C4ZVGwG25ae2WICEVQcsTdhJA69VK6XCB2rnKfWzv0JLV62QITNNUu/DrBL67B6qEPUjAU21xdhNvHiz8QWap8RXbKhpptzFLmVL0TKw4OYe0EU7ShcNI+OTWDaIjOruBl8iv4RlFcp3VR3KWzkYEc/XoDSwEvrP9AVOj0pRu1SwyXYxqKEq0aVl+eOpO/Xx4Kx/y2uwKQ3WOS5LUZPMBCtY2uXD9J/TqR1Ljr8ZNan6urPy9rpH4q5l/D5OcqPbUNeLb6YmQE3Gs2nWq6F50ihutu/QUxRY9e/54Iyet+QxUPW3IlMB+76kUV5vtUvkgEowricWo3tgv0vBXlrWzCjSvW2nkSc/AA/0Hn7xaEZJvLpKot+wQj1m7V5P0WTFgbWesiro0Awc+rjv7wete/5sAOd7arO6QFp1ZIy35kB2aSGoPtxzCOJyI6wncZto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39830400003)(346002)(376002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(186003)(2616005)(478600001)(107886003)(26005)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(54906003)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JOzp0g30ywKyQR0Bdp/QsSGPpOH5LKoDNoHA7a0PjHD2SLEiGuwLXI6cGCPf?=
 =?us-ascii?Q?+3I6Oed/nLPG4XXQBNHNv7SljrzR6b8WCgKCBZHwqm4vTM6WgGz7OjnatJ2r?=
 =?us-ascii?Q?e3GhrkwscewpkjLFEwaIHOKhlTbr1Hlss2n+cKLAJc898fFht0R0RaO9whbn?=
 =?us-ascii?Q?Pni/ws5I7n7WoE8rvc0lG1fRiJcyBaBxHsWeTAUtojcpozmMwjVh2jMf5Qqw?=
 =?us-ascii?Q?KKr0Pjf8Djw9eW81rVyLrm7yxXAUxvNoEOJmhSRA7voIfVP08BoSLUTsO80b?=
 =?us-ascii?Q?/UGSjgWtyF3ZbCxbPOswtrBAhWevSl7K2r+qyk7HQF8G4nUUep5lWn/jTbJ5?=
 =?us-ascii?Q?5rHDpKHC9kJAox9z1sxDIdBJUMJyHbZKO3VRW455uzvBVQlHSnxkoM7krwWe?=
 =?us-ascii?Q?0n56K65aVAgGv2j3GexZiHvhj4WUdgqyX4CN2Tr3uMvD/vkSN88X0Wad7EJL?=
 =?us-ascii?Q?L9Wuy/CRNtTiCeJe9j9GryFu3F3Sf8xc89p31lUIiLUCI+8pLy/5iMwtgwI5?=
 =?us-ascii?Q?W0ETKCekLrb8Tz6f7ItA3ufWMOjqmh+jROOwGiwM3VZHc5Pc+jXx4c8bIH58?=
 =?us-ascii?Q?4l5BgPsnmzi0LpUTj3YXst/YynBGxjCL0XrySLTbZVESXQyOPRhmLDU0RUZh?=
 =?us-ascii?Q?gZ1brC1yiGvyNoiSeGw9n9jJvlsHcO/MS/wyDuuZbM0/Xgf3pYUdI2Wzygw2?=
 =?us-ascii?Q?GPnyvya12b/Yka53g/JwsJ0CeeEG3e3O3ZQQBZjfISigQdlds1MCgsPiGtZ5?=
 =?us-ascii?Q?9ikOAyUSvQpXcrZfbtfHvoFV6W2zwlWVGYlHPmIOV58DnuUxwtJAxLRPl5YD?=
 =?us-ascii?Q?Sztdjey4jlJCs7oSuecnZVtpSQOJKaDaMbwBOohX3kDCsHjDi/vdwmXGSF/G?=
 =?us-ascii?Q?x3tj40ynRfeZIOQtNf6Nl0T9AqeBaxwN8L1Wmi/isk9SCnvYqxg2C0D4uAq8?=
 =?us-ascii?Q?R+5RbJYqEWDdu4UE5W2ac8rSvoqpNP30Re39G71pY52/F7XukzeskYT8Uqtb?=
 =?us-ascii?Q?TlEQrcCajiF5IQzR9B7czRYrm4PnF0tV8b+EaiyNTIjw+I0+32t0gVbfGuhf?=
 =?us-ascii?Q?vD0PnMDUK0Gz6fxJBSgoP1cxcZ2FJJSU+rDx2WNxPmXA+2kMhe0cvSeP0HbN?=
 =?us-ascii?Q?O87KJLftghxKCZQeHzbecG9BMBGEBGYX3sxDnOAumNDKLSLaiKQ71Ugi9XLB?=
 =?us-ascii?Q?GTbg6gHwQnovMx3edp1HKhMnLJtXqHFzI9h9zdKzePsDHO3ASL+SxNysiqi5?=
 =?us-ascii?Q?kaA/+iX3whrIF5Ch1lv3mzRSP63FQNB8V3z2s1w+vbxMIv6TxZNGFZTwjIPu?=
 =?us-ascii?Q?BRVLSfsvvrltWx/tp8mY3E6JOT7LUGkhAkf3ZnjAB6rWIrlFBA/iT1ZmLZlV?=
 =?us-ascii?Q?gNEO/YqhAMOj3CC9WIDItaicP343oOf/qy52ElKZnnnLYP4H2tjzW1OVLm48?=
 =?us-ascii?Q?m6zxqhtk4kYyZJmVLpgDkyFDFOMV1giBe1rHiofzNmS86hzvaWzYSUvWQ+Ll?=
 =?us-ascii?Q?jgvBAi2Vj0Cc5oO9GOnvoc5BGUKtEj4o8WQs6ea9foE3po/47LSGfHZw7zu4?=
 =?us-ascii?Q?oe+BETcmKafNXA+ierz8YE65PxH4LLbkTYs0GLev32Mz6raV/Rhrxbb+b+In?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed8157d-53c2-4cf3-fa1b-08db7bbd4928
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 12:01:51.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PALUJAHYT0l6NepKnQpQ/7ZqNCUS8M9migO84P0tF8+TQYSAaNxQp74qjayvFhmtkLU4hy8KXOfW7rGqpna9U0atI6/a5mNfnHt1Uqy/K9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3892
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yinjun Zhang <yinjun.zhang@corigine.com>

When moving devices from one namespace to another, mc addresses are
cleaned in software while not removed from application firmware. Thus
the mc addresses are remained and will cause resource leak.

Now use `__dev_mc_unsync` to clean mc addresses when closing port.

Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc address")
Cc: stable@vger.kernel.org
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
Changes since v1:

* Use __dev_mc_unsyc to clean mc addresses instead of tracking mc addresses by
  driver itself.
* Clean mc addresses when closing port instead of driver exits,
  so that the issue of moving devices between namespaces can be fixed.
* Modify commit message accordingly.

 .../ethernet/netronome/nfp/nfp_net_common.c   | 171 +++++++++---------
 1 file changed, 87 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 49f2f081ebb5..37b6a034c5d2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -914,6 +914,90 @@ static void nfp_net_write_mac_addr(struct nfp_net *nn, const u8 *addr)
 	nn_writew(nn, NFP_NET_CFG_MACADDR + 6, get_unaligned_be16(addr + 4));
 }
 
+int nfp_net_sched_mbox_amsg_work(struct nfp_net *nn, u32 cmd, const void *data, size_t len,
+				 int (*cb)(struct nfp_net *, struct nfp_mbox_amsg_entry *))
+{
+	struct nfp_mbox_amsg_entry *entry;
+
+	entry = kmalloc(sizeof(*entry) + len, GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->msg, data, len);
+	entry->cmd = cmd;
+	entry->cfg = cb;
+
+	spin_lock_bh(&nn->mbox_amsg.lock);
+	list_add_tail(&entry->list, &nn->mbox_amsg.list);
+	spin_unlock_bh(&nn->mbox_amsg.lock);
+
+	schedule_work(&nn->mbox_amsg.work);
+
+	return 0;
+}
+
+static void nfp_net_mbox_amsg_work(struct work_struct *work)
+{
+	struct nfp_net *nn = container_of(work, struct nfp_net, mbox_amsg.work);
+	struct nfp_mbox_amsg_entry *entry, *tmp;
+	struct list_head tmp_list;
+
+	INIT_LIST_HEAD(&tmp_list);
+
+	spin_lock_bh(&nn->mbox_amsg.lock);
+	list_splice_init(&nn->mbox_amsg.list, &tmp_list);
+	spin_unlock_bh(&nn->mbox_amsg.lock);
+
+	list_for_each_entry_safe(entry, tmp, &tmp_list, list) {
+		int err = entry->cfg(nn, entry);
+
+		if (err)
+			nn_err(nn, "Config cmd %d to HW failed %d.\n", entry->cmd, err);
+
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
+{
+	unsigned char *addr = entry->msg;
+	int ret;
+
+	ret = nfp_net_mbox_lock(nn, NFP_NET_CFG_MULTICAST_SZ);
+	if (ret)
+		return ret;
+
+	nn_writel(nn, nn->tlv_caps.mbox_off + NFP_NET_CFG_MULTICAST_MAC_HI,
+		  get_unaligned_be32(addr));
+	nn_writew(nn, nn->tlv_caps.mbox_off + NFP_NET_CFG_MULTICAST_MAC_LO,
+		  get_unaligned_be16(addr + 4));
+
+	return nfp_net_mbox_reconfig_and_unlock(nn, entry->cmd);
+}
+
+static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct nfp_net *nn = netdev_priv(netdev);
+
+	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
+		nn_err(nn, "Requested number of MC addresses (%d) exceeds maximum (%d).\n",
+		       netdev_mc_count(netdev), NFP_NET_CFG_MAC_MC_MAX);
+		return -EINVAL;
+	}
+
+	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
+					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
+}
+
+static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr)
+{
+	struct nfp_net *nn = netdev_priv(netdev);
+
+	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
+					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
+}
+
 /**
  * nfp_net_clear_config_and_disable() - Clear control BAR and disable NFP
  * @nn:      NFP Net device to reconfigure
@@ -1084,6 +1168,9 @@ static int nfp_net_netdev_close(struct net_device *netdev)
 
 	/* Step 2: Tell NFP
 	 */
+	if (nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER)
+		__dev_mc_unsync(netdev, nfp_net_mc_unsync);
+
 	nfp_net_clear_config_and_disable(nn);
 	nfp_port_configure(netdev, false);
 
@@ -1335,90 +1422,6 @@ int nfp_ctrl_open(struct nfp_net *nn)
 	return err;
 }
 
-int nfp_net_sched_mbox_amsg_work(struct nfp_net *nn, u32 cmd, const void *data, size_t len,
-				 int (*cb)(struct nfp_net *, struct nfp_mbox_amsg_entry *))
-{
-	struct nfp_mbox_amsg_entry *entry;
-
-	entry = kmalloc(sizeof(*entry) + len, GFP_ATOMIC);
-	if (!entry)
-		return -ENOMEM;
-
-	memcpy(entry->msg, data, len);
-	entry->cmd = cmd;
-	entry->cfg = cb;
-
-	spin_lock_bh(&nn->mbox_amsg.lock);
-	list_add_tail(&entry->list, &nn->mbox_amsg.list);
-	spin_unlock_bh(&nn->mbox_amsg.lock);
-
-	schedule_work(&nn->mbox_amsg.work);
-
-	return 0;
-}
-
-static void nfp_net_mbox_amsg_work(struct work_struct *work)
-{
-	struct nfp_net *nn = container_of(work, struct nfp_net, mbox_amsg.work);
-	struct nfp_mbox_amsg_entry *entry, *tmp;
-	struct list_head tmp_list;
-
-	INIT_LIST_HEAD(&tmp_list);
-
-	spin_lock_bh(&nn->mbox_amsg.lock);
-	list_splice_init(&nn->mbox_amsg.list, &tmp_list);
-	spin_unlock_bh(&nn->mbox_amsg.lock);
-
-	list_for_each_entry_safe(entry, tmp, &tmp_list, list) {
-		int err = entry->cfg(nn, entry);
-
-		if (err)
-			nn_err(nn, "Config cmd %d to HW failed %d.\n", entry->cmd, err);
-
-		list_del(&entry->list);
-		kfree(entry);
-	}
-}
-
-static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
-{
-	unsigned char *addr = entry->msg;
-	int ret;
-
-	ret = nfp_net_mbox_lock(nn, NFP_NET_CFG_MULTICAST_SZ);
-	if (ret)
-		return ret;
-
-	nn_writel(nn, nn->tlv_caps.mbox_off + NFP_NET_CFG_MULTICAST_MAC_HI,
-		  get_unaligned_be32(addr));
-	nn_writew(nn, nn->tlv_caps.mbox_off + NFP_NET_CFG_MULTICAST_MAC_LO,
-		  get_unaligned_be16(addr + 4));
-
-	return nfp_net_mbox_reconfig_and_unlock(nn, entry->cmd);
-}
-
-static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
-{
-	struct nfp_net *nn = netdev_priv(netdev);
-
-	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
-		nn_err(nn, "Requested number of MC addresses (%d) exceeds maximum (%d).\n",
-		       netdev_mc_count(netdev), NFP_NET_CFG_MAC_MC_MAX);
-		return -EINVAL;
-	}
-
-	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
-					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
-}
-
-static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr)
-{
-	struct nfp_net *nn = netdev_priv(netdev);
-
-	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
-					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
-}
-
 static void nfp_net_set_rx_mode(struct net_device *netdev)
 {
 	struct nfp_net *nn = netdev_priv(netdev);
-- 
2.34.1

