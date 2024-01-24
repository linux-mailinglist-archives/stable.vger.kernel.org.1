Return-Path: <stable+bounces-15720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2583AD1A
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 16:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAD6B23444
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E37A72D;
	Wed, 24 Jan 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="PHAUUD0Y"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2127.outbound.protection.outlook.com [40.107.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A877656;
	Wed, 24 Jan 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109575; cv=fail; b=r3GgpLoUluTqKWX7ZDVmRupEtffLLMu8Iughht3ORooIku7g/9+Brv3gvNG2tkZwhXoFGKtzl8k4fhXvRC1NIuvJPvHJ8dnQA5QuuU6maIqpwmXjpAJtTbDxxqWoaWtQIawp72wj1cPA93z2sSAOVRHohsiOWV0z6F+G5o8eBXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109575; c=relaxed/simple;
	bh=fcU4lQ2gYYSVqnOSX9jyZwcA2BpUR5OdM1iGHTaWkWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBd9oif+Za653VlT0iunt9tDtQ0uMmAHmb+KCjkM1LeB76TMSL1vRnxQNQXSaCMpNVvR3OZvY9cQN6PXw3P4qs4Nkr2PMpWSyQK/+iIEcxjNNXthrR6owASh/FrjGcJdsyVEvpHNJaLU3n5y5yZrrJZA62y244gFEFunx1bkWRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=PHAUUD0Y; arc=fail smtp.client-ip=40.107.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPbb6gYdZ481kZdGlI4pHVMxLACM+aaYnVdpz3gBSwU1Z2OWGZKUk8YLHSli0RyRjukHx0ZA5NpuqiWxgxjzLFRV9phXEBBJ3pn2gkjKTvt2pIVtZOKsTZNLRVi5PyEGxgV7GB48u0VkisDU2EQ9Z5FFbR++LAEDVU9ilOm1iJngQJUi3cxrZu/QSyxGflIo51GqycMem0cdf0kyIJOPPDepakQUAgV3gvVLl32cyi32uLgLPztE+QN57iadaj7ClYRjxGIh2etsEp5xhd4V04b6825dvcfoSPutxCOvZwTAecu0qAwZ+Q9eKAsUGXc4bfWcdz6C6vsrCnKnfdKILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEpBvXnyauIOGnyEmZYRwrA3SaIYkh6TAxeS2PiiHIA=;
 b=M9/P3zhm6kuB/1tNjIizZCqLnJDF2V1yfWRT/n71rwJpSPApGlEClEOWNzBml2YaqyeCzfHRBU6p9OcD/C73aGCFuIa/7L9FdCR3QDjHTtcOugFEBMEPgXfCAjR4aOG+RCEPyOPPXvVjyk/tc4xpONbioWSjc8dsRdY4mdhTA+W9FKgrLXQei+uqcgVX1XKH0FiyE7p6l0sfjr4SxeGwLM5YR2BaohqGB81gp5m8c1mNqoLe8VTTKHkt0gvm4p81xAAMiUpFYb3DHO4k7KjSDyqmoAkshaoQOxqxA5Otalft1B/De5/ilkozPsG8zEO7LAzi/EhjX4ZTrcw3UVF2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEpBvXnyauIOGnyEmZYRwrA3SaIYkh6TAxeS2PiiHIA=;
 b=PHAUUD0YPR3j24yhT8UBtePtvzmVccesRMcCQ9YOpa0xVaAxHtPa2iv+Mc0UPHGd6X9n7kWDzhPHS2BFhPMlClucX7Ju464STE7qNWrC8RQNWbzC0j2wWDzPAm6Zv73dTV7+Og0TXwMW/rtVeUBzqA8UP86/GK4+7P+y/jI9SMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DM6PR13MB4132.namprd13.prod.outlook.com (2603:10b6:5:2ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:19:31 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::8d5e:10cf:1f9e:c3aa]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::8d5e:10cf:1f9e:c3aa%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 15:19:31 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net v2 1/2] nfp: flower: add hardware offload check for post ct entry
Date: Wed, 24 Jan 2024 17:19:08 +0200
Message-Id: <20240124151909.31603-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124151909.31603-1-louis.peens@corigine.com>
References: <20240124151909.31603-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::16)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DM6PR13MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d16391d-6bc5-4bdf-b07a-08dc1cefdd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+e89A0PmvNHS5BLtNQF1TIGo28rkDam/BHVCLyiv7yOuDUYXqqtwVpS5P8YMf8xSyaIsFOh+DbRN7WOeWAjnHeL4lqO+Uvn7O8eFTYPjUi1fiJJfCjqPQS6LklLzVCWoRi3w59TdxC0Ahot2iUxrnQBtaFQ99TJPQh71UzXbIfoSPE8QI2e6rjjNZztzfhI/NAn7U0JK0LLNN75izvPYchgfxvJzrf6FIW853BTVFfYJNMhc8ft7DQz6DjZWXg7xd+PC2UPRtz6LjUodmrstgWBXjvgjkNlEqysCnaBRv7qBz6cSgzPCg8EcFjo6orZ7IpFGACbr0lid0G1iBP5AbIufNhJF6Yc/9dtKU+1gW4wWCdBRE0gbyWRwBdZ+PdsmVGrpuGmoAKEX7jZHQNqE4YMa9Lef3tNRdri+e5ierip4VrKNAnfccZ8T5uf4a5fseflixdR/LIIkEyyLU1oYImecd1d7xw7Mjvyka5Rj3K/PWlLapzT43WLkAD+jtQTPiB3YiD59buderMq/EyMV8v9638vCUOPiQsoN0XDCVZKeSX47jUWOcvn8CcxhxqKtkwktzNP7WJOLA7IIdsAYyu1w1VJDKpYCLdgz2zYZxRrJiuWJQ2NjmIPAwOD3wg0j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39840400004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66946007)(4326008)(8936002)(8676002)(6486002)(44832011)(5660300002)(86362001)(66476007)(316002)(2906002)(110136005)(66556008)(36756003)(6666004)(38100700002)(38350700005)(52116002)(55236004)(83380400001)(6506007)(478600001)(6512007)(26005)(2616005)(1076003)(41300700001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ItpdMYg5WEt8zgfHmpQA1qzMM2t3JMBEDv+0TxrJrqYdEbWrX9mf6ybBHE5I?=
 =?us-ascii?Q?KAmK0zdhptevNQbOQaYINTxfhVN6a6vNvzOl46sdDmbXuvngwvkVfUWG8rBW?=
 =?us-ascii?Q?y5df8tjtydvzzcl/8hjXoOe6VT9JPOLPwResgUlYFz0j7x+j9LOFYl/LOwO6?=
 =?us-ascii?Q?UWhxDKoLM6JI1G8ybwHdmnh6QHj/CXFfr8vIoLd4Z5+wodxjG5en5GYQNcDh?=
 =?us-ascii?Q?LD0agxeYdU6LwIrjI/jK8vEFW9Ltb4qCCCaXa/n/aaXNuiOmxHWxi7OeOlBW?=
 =?us-ascii?Q?dS12Ctw48ptMCCfBPCfMRJT797m8tp+M/OzBRvKOYNYKprc/Agpr+i/u7d7U?=
 =?us-ascii?Q?NlLnbDs/5AJ7BsJhr00+aBytfy6Upz1avrImIltuJEqWjSuiEyl6iz9z8N8w?=
 =?us-ascii?Q?LOwlOv8Zyw5Hw6dDhHue+GLQO/xIbMY+zK3FJhYeryviEogLIp/sLafKGGYo?=
 =?us-ascii?Q?gu2o8NuKL9ZrGMvcvBgBOI1Fvl4LUlO8AxLNuiDY2p7JcIaxTe/5/rFfPNqC?=
 =?us-ascii?Q?ufTQOQYPTQ4UGXs0DInunzEQ7pcFFgjZpp+wckXtTnCdyZpHkZEVCCfNJOXR?=
 =?us-ascii?Q?RZINpxQFzTbyOZMzEIpHHg1xwgLNS4lApJ38/2QOkxjYmG7CoDoUepn56Vod?=
 =?us-ascii?Q?JMTayAMy0/5Sf3wD/jovhfktTl9LrY1TTsvjzjC/vbQ0b71qkTm9nAWOdKFv?=
 =?us-ascii?Q?hm+1DYbQbUzTNGZ0Hn4qPH6q9ELIYjB4tsuEot/MbPD3oDKLNykOGkHGeC01?=
 =?us-ascii?Q?MNmSE62clbNNi+ZE0XrxHeiC5Ev4QueLPukalGQY4j8JeEKRIzOeJ/MfyFP0?=
 =?us-ascii?Q?XZwYP9I2zMhExUxOuMtKtGw2O5YKHX+g1fiGcbyT9l/7l1vSK7CYA4xlyzx6?=
 =?us-ascii?Q?a7jCAmeYI8FgOrbEudGmTXA8KASnr8qyNZjy2rbI3THVK6Xbkja4draGtRG3?=
 =?us-ascii?Q?xaB2bu/hu9AT25UIW9AtcTh/tINi3IfUvyX8f/pCQq4AybJItZHPDUvbpUHg?=
 =?us-ascii?Q?G8aYOmk+fHgiaGKELB1SbCiT+l3mv+IT3jB23+XbRUMRF0VHTkIHVnsPe99Q?=
 =?us-ascii?Q?9FJkAqcG1BcW44SjE3U5xmTs6AGvZac7yOHgSsY0hYymLp7AtkkC7Y/uu+94?=
 =?us-ascii?Q?ivGs0Eneogw55kb2QjZB2IHTji83OFBynuvSDuUUzumrzGAZ1wfHHQRJHDf3?=
 =?us-ascii?Q?rJnRE2O07G64UJMqVGf82fsfWN/CiPLmpyxpkeySmv/QqLxcoFWLdz2xt2Qy?=
 =?us-ascii?Q?gFUj1W+CwijORnmXDGcLMQL+s5wu+gIcTx9hteLh7tF1UR8gHqy35abqxKuE?=
 =?us-ascii?Q?FBRjFJgihlenGtmfnXrT1QNKGm02ISbnL0kv8xFTYyWOFwZ0IQ5P1CXgcYOP?=
 =?us-ascii?Q?WujXjD6FeMkXLNAM2jbaVK0bQmtgDym7TtY2ZbimXeQMXu2jmrpWFoNLF832?=
 =?us-ascii?Q?B/YS81gdyhYdscj8VkfV7TSupgv/ZdGWy8gJWk9TayhwRrqAv2EVjLs+D3YC?=
 =?us-ascii?Q?TO/lAyjKwD/4UHv+lLptZgPz00lQPUqzn+/UDiq+h9Y6GfATbh2i7sgDmpNF?=
 =?us-ascii?Q?lkyFEsQKBvXkSVVuoalF05FqK0WTjNJ+6/Gb5iqPH1UERwv/kktpxwxrlydg?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d16391d-6bc5-4bdf-b07a-08dc1cefdd3a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:19:31.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cWFdKDXoPjVNOXqKh/bZzhmyn1cvVyY9NBse3BeamubwD0iJ/6NABQd/VRi2suCfBNciTk7qBQaEy0+iunQz3L63vQ7cM6NZjEwXxf1ZFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4132

From: Hui Zhou <hui.zhou@corigine.com>

The nfp offload flow pay will not allocate a mask id when the out port
is openvswitch internal port. This is because these flows are used to
configure the pre_tun table and are never actually send to the firmware
as an add-flow message. When a tc rule which action contains ct and
the post ct entry's out port is openvswitch internal port, the merge
offload flow pay with the wrong mask id of 0 will be send to the
firmware. Actually, the nfp can not support hardware offload for this
situation, so return EOPNOTSUPP.

Fixes: bd0fe7f96a3c ("nfp: flower-ct: add zone table entry when handling pre/post_ct flows")
CC: stable@vger.kernel.org # 5.14+
Signed-off-by: Hui Zhou <hui.zhou@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/flower/conntrack.c | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 2967bab72505..726d8cdf0b9c 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1864,10 +1864,30 @@ int nfp_fl_ct_handle_post_ct(struct nfp_flower_priv *priv,
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(flow);
 	struct nfp_fl_ct_flow_entry *ct_entry;
+	struct flow_action_entry *ct_goto;
 	struct nfp_fl_ct_zone_entry *zt;
+	struct flow_action_entry *act;
 	bool wildcarded = false;
 	struct flow_match_ct ct;
-	struct flow_action_entry *ct_goto;
+	int i;
+
+	flow_action_for_each(i, act, &rule->action) {
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+		case FLOW_ACTION_REDIRECT_INGRESS:
+		case FLOW_ACTION_MIRRED:
+		case FLOW_ACTION_MIRRED_INGRESS:
+			if (act->dev->rtnl_link_ops &&
+			    !strcmp(act->dev->rtnl_link_ops->kind, "openvswitch")) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "unsupported offload: out port is openvswitch internal port");
+				return -EOPNOTSUPP;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	flow_rule_match_ct(rule, &ct);
 	if (!ct.mask->ct_zone) {
-- 
2.34.1


