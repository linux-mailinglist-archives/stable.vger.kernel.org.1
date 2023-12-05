Return-Path: <stable+bounces-4648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA55804DC3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 10:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253C01F214C4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55C3F8CE;
	Tue,  5 Dec 2023 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="W9cEHt8s"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9929B;
	Tue,  5 Dec 2023 01:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWZz6YuGiBv64Qi7qj/V04CXbY8nkYfqF3GhjpVK5zVHDlYamKLHHg5b6ALmtNgxTQq+tLPiP/+tkUrjNim1bSS6lAxOYiRg3burSTBPKg6c7s8ukSR3rvBDrsIFJ+sqz7IVz8XDxkR6A7Uq5DuItX8ebAdyGbqpFzyMAIO4DO/xt5SqUNcC8fVp8BFM5/ZxAI7avoRK99+3vATatgk7xkHg5svn1EhOkrtH4c7cuXayj7hNYIWnfjnR50pNVHnqZ/w2d5GlYfwGsz5XQh/5/jBRnQE0qnYC+0wkMXbVwZkAts7S0nvNRXTLsXqecrr7wpOa/0N1t4bWsybC1SbpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh/c4zDWCo2LFkRQjLlHRBGyKUIDFJSOkBUwQRI079k=;
 b=h2gRzDjoPdTi7gN7oohtxyRl/6AvUF2S/S17OUaQXId970UGWMPR8rT3VWqS0vpn9+kIJ4fqn2K+nhp55wg4kC0lbzgxSyrw/R01eu6P7qV0P+niIGER+EaoZms8vJfRuxwpTXszTo8onlmZv2NxPIreeUnbWXAWfMMs+zsfuHcRyZUr935WuPqNWtZ9B/dPQHcjstnU7OTDPbX53zpUfaeYbqmKINUMFCBUCkLJJnLFwbJuXS01YJpZjLoWAWLZZcAiyCejXECNx6Rsha9sLTeGxC6LrO9+Lkm8/DtrjfokOh9QJGGwtwyBKC+oU5vdjw/sNYPIZ6wPo/l+rzkF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh/c4zDWCo2LFkRQjLlHRBGyKUIDFJSOkBUwQRI079k=;
 b=W9cEHt8s64n4tV0EeI9jutJYn4d5TfKufc7XdGcDoXCbfErER7PSo2HMqBMxde8JT423COjGN5B1tix8sdJ8+pRkws2x8hCFuBVRodOIdC6eeUScCqqhb57NrN/+sV6PDnPorEetpoDIs43wpd+NOVFy+IECVjRMPy4UfpGTsSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by BY3PR13MB4772.namprd13.prod.outlook.com (2603:10b6:a03:36b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:26:47 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 09:26:47 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net] nfp: flower: fix for take a mutex lock in soft irq context and rcu lock
Date: Tue,  5 Dec 2023 11:26:25 +0200
Message-Id: <20231205092625.18197-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::36)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|BY3PR13MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: f457f86a-c0e4-4c40-0d14-08dbf5744dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eX7HbOmnVsGLl/r3CX8G2xCCzhB1adoAI1955vrbKWje+aWs4GVKEU+FM+xE+E+yjVblDwyQcAP80RagmYPd1N5q7o60Ubm48gMHD0xwkqCF2KOTd0Ncrb1adq6OT9hxb28v1LjC26WX0k8ezGOF/TAemKv9xAbU6kU+CulpnclA2PL9K3+ADx60NwmY7R/ZuDzhNgfJTL48qxGEbcH45WFQgQuEp27M99SvVhR7JBL7IEQbGnnvzfM2h5oXk1nkBArYNpG2vmWCt+odvWLRU5u1B6ruBg9xUQcX81ph9N8C6S/Gf60EmjYo2Ggz49qVLjSzB01kHmi6Xu7UOkGMtzMCB8W6sTjZ3bK/zCDf6NI3JKGgc0VwpPmLS/yuK1I7pLiJKMgupxf1G2Wxa9IpHtSw7IXOObR7kMTWY1jh0vqrpnOkuJplmKXPmxP7RY/weLrKros3iB+bOIPz4Hb2bETYpuCoP15PxGTtAoynsSotE1mDS3roN/QduKY+gLNHeYELR/1x/oRaQvES8g+jjwQInLRxOYaj2cjpemo9/ip/MQpFK3bqoVtpfyMG8Os85PsDage2GgWhvW5l0IFf14JHZyAq+ueuUt+KsfdzPn7QhGaExMct7Y5SP6R9KJtaSCY+arZCzN+C9miBwoXafZbp71E2X1yjtp6Ej4xiytE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39840400004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(107886003)(1076003)(2616005)(4326008)(8936002)(8676002)(6512007)(6506007)(55236004)(52116002)(83380400001)(26005)(6486002)(478600001)(6666004)(66556008)(66946007)(110136005)(66476007)(38100700002)(316002)(2906002)(38350700005)(41300700001)(36756003)(44832011)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nsUz3TURydUS1Wzs4LB7h70XTs9GMUDtGKz3JTkT5Qw5pcX4AHZkvYoYuH6?=
 =?us-ascii?Q?eDA5csj7JNPHGN/+i0HljVG663we6yVuvcMyekLXakqGR25KWNWU5AXlt7EM?=
 =?us-ascii?Q?GBV++tgDOygeNY4KPdSiQjRm/00ZI8reM7eM5fqmLIHeouMqe5V3pVZPx6Cw?=
 =?us-ascii?Q?L6EGUi/nfXzmKtzf6vjYoAHXQgd8E/AMHlbek3NBj8J/e5QLB+kX/IluNgup?=
 =?us-ascii?Q?wvzbXthYq0/j50GwNXC9PmsugP60COrTsn0sB7gUvzorcOMdHMR58uUDAqCB?=
 =?us-ascii?Q?v17DUdvfZmjzACM9TmLmqYrC8j7GXWBXXePYzX+32NBb3B8n/NOsK8cdZEmu?=
 =?us-ascii?Q?KbyBPllfEhaDd/SqjvQ0EJSZHGMdm2nJgVXqmJKh8vliYCE4XmXkL/XY4Jtz?=
 =?us-ascii?Q?xd+RtL6uZwaL2aqVcY+AIG9oxxcBK6NUIWNK3PbY2HsCCYx4JxlJ7jDAVmDr?=
 =?us-ascii?Q?Wg6FzfkeK3AuJesuikse+sG2giLrL/En4EVVGCQzyOREHUHcP0wMN0RKOcFa?=
 =?us-ascii?Q?a/G8HtwjILX20T7yRwOGx26orUGifopqJznn3SMg7DH0JN7dNmbij/MhPaCw?=
 =?us-ascii?Q?F1XTaREE0PonlimPcrO0F80/kkwTXEmHwyDlttGR0KfUuMRqMTupzjfXesm5?=
 =?us-ascii?Q?oUsVZmLdLmCCK/uj7UZFwcQp15JHzja6ATpYQHuu8NQG3qhH3W9TFSS6Ysl3?=
 =?us-ascii?Q?D/eCoNapzgtMWH4qRwxi+hVBaAV5jMF4FiyEUAJvVa7Qj6CRpNMLj09nbjOM?=
 =?us-ascii?Q?Kso1Wez+tmq3pheHpfNMF7fg5CtSdh08D9gPqfrWKlsFTQhYMv1VoGCHvfDn?=
 =?us-ascii?Q?Y6cF3OngjGJ+cZ2dFscbg+pqPm1e9deRFEP0Vy06/iJHfOPigbJottYoAOem?=
 =?us-ascii?Q?cIlHFfcGd9ZzQDFFsinYYiJGFcANyQqHonCdqOUmkgRHnQ8RiCycs21TJr8S?=
 =?us-ascii?Q?xH5XbADPEZcGDFcKy7PwU5qF6my1gZzavqQ5MjIjBFvbPO02nWoW1QJsqwiF?=
 =?us-ascii?Q?8LwkfsLAcTw5W7CtkwQuAC1+iUVJbrbv7+U6RY/gVy+dr0JsA3ad2lDkZm0e?=
 =?us-ascii?Q?DC3lvpWDTFYn3JJZBOv1DDtZW2L2TLOadISiNdI7pUs6pxfp0rPdXiFTTF0k?=
 =?us-ascii?Q?NHZrj2q8O2zfJUIRfS6/97wMVHJReJ3L7Lltxdvttpvz3Vq/qwRy9Adti7nc?=
 =?us-ascii?Q?SYxQFoi32A6+6SH39LTdSUFm06+NYJ2maN9aqH2yWfmAGHOXVtQGAteLaUB/?=
 =?us-ascii?Q?+vnwHZ1gpa2hz//Y57Hn86YlxTeHsCHOV1YsscsdUfy8T3QikJz6xPRECDQL?=
 =?us-ascii?Q?gOOD86sIHhZaNkQm235cwa5oAUFbmde8APYEI2I5qsWV31vj+LndHohrPox/?=
 =?us-ascii?Q?R/bbf6uShtKeMid4S1RydfVBAprZEF6KJHcixanVHUCQduvLDsz8L4isXlof?=
 =?us-ascii?Q?HxKm54NtUS27DAbrgln6YzrJJEE7H2nOFE4kUG/Lf2PmdkzbrRlXQWZgrWXq?=
 =?us-ascii?Q?cS2VItWEkKWtVgZCsNl5m6XdktdVOXaW10doq1LVVCUQLi+ubXCdjtTj5s2J?=
 =?us-ascii?Q?sRqhunxcU7prPyWyICvFmpS0uDxurBGGFIYxfZjXkXPg5zvzuGFaw24VIhUO?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f457f86a-c0e4-4c40-0d14-08dbf5744dad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:26:47.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS6ZoT69jF4u4GgC+I6BactgzETynjdMCI0olrwWPa4LhUMcDG5yohKmPo8xxeNeJdDVykdv90eb+RrIHagzWgwQJ/btFzfz7kyb2ktfnDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4772

From: Hui Zhou <hui.zhou@corigine.com>

The neighbour event callback call the function nfp_tun_write_neigh,
this function will take a mutex lock and it is in soft irq context,
change the work queue to process the neighbour event.

Move the nfp_tun_write_neigh function out of range rcu_read_lock/unlock()
in function nfp_tunnel_request_route_v4 and nfp_tunnel_request_route_v6.

Fixes: abc210952af7 ("nfp: flower: tunnel neigh support bond offload")
CC: stable@vger.kernel.org # 6.2+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../netronome/nfp/flower/tunnel_conf.c        | 127 +++++++++++++-----
 1 file changed, 95 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 060a77f2265d..e522845c7c21 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -160,6 +160,18 @@ struct nfp_tun_mac_addr_offload {
 	u8 addr[ETH_ALEN];
 };
 
+/**
+ * struct nfp_neigh_update_work - update neighbour information to nfp
+ * @work:	Work queue for writing neigh to the nfp
+ * @n:		neighbour entry
+ * @app:	Back pointer to app
+ */
+struct nfp_neigh_update_work {
+	struct work_struct work;
+	struct neighbour *n;
+	struct nfp_app *app;
+};
+
 enum nfp_flower_mac_offload_cmd {
 	NFP_TUNNEL_MAC_OFFLOAD_ADD =		0,
 	NFP_TUNNEL_MAC_OFFLOAD_DEL =		1,
@@ -607,38 +619,30 @@ nfp_tun_write_neigh(struct net_device *netdev, struct nfp_app *app,
 	nfp_flower_cmsg_warn(app, "Neighbour configuration failed.\n");
 }
 
-static int
-nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
-			    void *ptr)
+static void
+nfp_tun_release_neigh_update_work(struct nfp_neigh_update_work *update_work)
 {
-	struct nfp_flower_priv *app_priv;
-	struct netevent_redirect *redir;
-	struct neighbour *n;
+	neigh_release(update_work->n);
+	kfree(update_work);
+}
+
+static void nfp_tun_neigh_update(struct work_struct *work)
+{
+	struct nfp_neigh_update_work *update_work;
 	struct nfp_app *app;
+	struct neighbour *n;
 	bool neigh_invalid;
 	int err;
 
-	switch (event) {
-	case NETEVENT_REDIRECT:
-		redir = (struct netevent_redirect *)ptr;
-		n = redir->neigh;
-		break;
-	case NETEVENT_NEIGH_UPDATE:
-		n = (struct neighbour *)ptr;
-		break;
-	default:
-		return NOTIFY_DONE;
-	}
-
-	neigh_invalid = !(n->nud_state & NUD_VALID) || n->dead;
-
-	app_priv = container_of(nb, struct nfp_flower_priv, tun.neigh_nb);
-	app = app_priv->app;
+	update_work = container_of(work, struct nfp_neigh_update_work, work);
+	app = update_work->app;
+	n = update_work->n;
 
 	if (!nfp_flower_get_port_id_from_netdev(app, n->dev))
-		return NOTIFY_DONE;
+		goto out;
 
 #if IS_ENABLED(CONFIG_INET)
+	neigh_invalid = !(n->nud_state & NUD_VALID) || n->dead;
 	if (n->tbl->family == AF_INET6) {
 #if IS_ENABLED(CONFIG_IPV6)
 		struct flowi6 flow6 = {};
@@ -655,13 +659,11 @@ nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
 			dst = ip6_dst_lookup_flow(dev_net(n->dev), NULL,
 						  &flow6, NULL);
 			if (IS_ERR(dst))
-				return NOTIFY_DONE;
+				goto out;
 
 			dst_release(dst);
 		}
 		nfp_tun_write_neigh(n->dev, app, &flow6, n, true, false);
-#else
-		return NOTIFY_DONE;
 #endif /* CONFIG_IPV6 */
 	} else {
 		struct flowi4 flow4 = {};
@@ -678,17 +680,71 @@ nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
 			rt = ip_route_output_key(dev_net(n->dev), &flow4);
 			err = PTR_ERR_OR_ZERO(rt);
 			if (err)
-				return NOTIFY_DONE;
+				goto out;
 
 			ip_rt_put(rt);
 		}
 		nfp_tun_write_neigh(n->dev, app, &flow4, n, false, false);
 	}
-#else
-	return NOTIFY_DONE;
 #endif /* CONFIG_INET */
+out:
+	nfp_tun_release_neigh_update_work(update_work);
+}
 
-	return NOTIFY_OK;
+static struct nfp_neigh_update_work *
+nfp_tun_alloc_neigh_update_work(struct nfp_app *app, struct neighbour *n)
+{
+	struct nfp_neigh_update_work *update_work;
+
+	update_work = kzalloc(sizeof(*update_work), GFP_ATOMIC);
+	if (!update_work)
+		return NULL;
+
+	INIT_WORK(&update_work->work, nfp_tun_neigh_update);
+	neigh_hold(n);
+	update_work->n = n;
+	update_work->app = app;
+
+	return update_work;
+}
+
+static int
+nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
+			    void *ptr)
+{
+	struct nfp_neigh_update_work *update_work;
+	struct nfp_flower_priv *app_priv;
+	struct netevent_redirect *redir;
+	struct neighbour *n;
+	struct nfp_app *app;
+
+	switch (event) {
+	case NETEVENT_REDIRECT:
+		redir = (struct netevent_redirect *)ptr;
+		n = redir->neigh;
+		break;
+	case NETEVENT_NEIGH_UPDATE:
+		n = (struct neighbour *)ptr;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	if (n->tbl != ipv6_stub->nd_tbl && n->tbl != &arp_tbl)
+#else
+	if (n->tbl != &arp_tbl)
+#endif
+		return NOTIFY_DONE;
+
+	app_priv = container_of(nb, struct nfp_flower_priv, tun.neigh_nb);
+	app = app_priv->app;
+	update_work = nfp_tun_alloc_neigh_update_work(app, n);
+	if (!update_work)
+		return NOTIFY_DONE;
+
+	queue_work(system_highpri_wq, &update_work->work);
+
+	return NOTIFY_DONE;
 }
 
 void nfp_tunnel_request_route_v4(struct nfp_app *app, struct sk_buff *skb)
@@ -706,6 +762,7 @@ void nfp_tunnel_request_route_v4(struct nfp_app *app, struct sk_buff *skb)
 	netdev = nfp_app_dev_get(app, be32_to_cpu(payload->ingress_port), NULL);
 	if (!netdev)
 		goto fail_rcu_unlock;
+	dev_hold(netdev);
 
 	flow.daddr = payload->ipv4_addr;
 	flow.flowi4_proto = IPPROTO_UDP;
@@ -725,13 +782,16 @@ void nfp_tunnel_request_route_v4(struct nfp_app *app, struct sk_buff *skb)
 	ip_rt_put(rt);
 	if (!n)
 		goto fail_rcu_unlock;
+	rcu_read_unlock();
+
 	nfp_tun_write_neigh(n->dev, app, &flow, n, false, true);
 	neigh_release(n);
-	rcu_read_unlock();
+	dev_put(netdev);
 	return;
 
 fail_rcu_unlock:
 	rcu_read_unlock();
+	dev_put(netdev);
 	nfp_flower_cmsg_warn(app, "Requested route not found.\n");
 }
 
@@ -749,6 +809,7 @@ void nfp_tunnel_request_route_v6(struct nfp_app *app, struct sk_buff *skb)
 	netdev = nfp_app_dev_get(app, be32_to_cpu(payload->ingress_port), NULL);
 	if (!netdev)
 		goto fail_rcu_unlock;
+	dev_hold(netdev);
 
 	flow.daddr = payload->ipv6_addr;
 	flow.flowi6_proto = IPPROTO_UDP;
@@ -766,14 +827,16 @@ void nfp_tunnel_request_route_v6(struct nfp_app *app, struct sk_buff *skb)
 	dst_release(dst);
 	if (!n)
 		goto fail_rcu_unlock;
+	rcu_read_unlock();
 
 	nfp_tun_write_neigh(n->dev, app, &flow, n, true, true);
 	neigh_release(n);
-	rcu_read_unlock();
+	dev_put(netdev);
 	return;
 
 fail_rcu_unlock:
 	rcu_read_unlock();
+	dev_put(netdev);
 	nfp_flower_cmsg_warn(app, "Requested IPv6 route not found.\n");
 }
 
-- 
2.34.1


