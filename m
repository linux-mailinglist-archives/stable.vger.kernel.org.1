Return-Path: <stable+bounces-4973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6B809CC9
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D8D1F21333
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8934DF65;
	Fri,  8 Dec 2023 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="rIYSlyt7"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2104.outbound.protection.outlook.com [40.107.243.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B971991;
	Thu,  7 Dec 2023 23:00:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOZt4ZrBy9qGOLHQ6YSUICzDQwuMoM5f4X4+MvD5Pur/twJzetTS2LphQhaxL/ky/JS6Cdo0rc2k5a/kPB1LFUWeaIXgQGLZSre8R90nENnZv3B0GU2fFsDu1OFvOUVl79jnAAUpbPXIN+N5DRzHJQCoBAaBsfL9EZpj3EW7TO+o8Yof8obpiKWR7K6vAu8cCg/yVjfoyukz2gvoh6Mjp1/InbtArITUHupik89diejuduLulIxisz5FzoEiY/aopTyJd3brSPUcom9yphZo748EVQUCY8/9CEX/ssY88uCcgjiKj7VMN6jye1lI8Nvlm9npbME275Y/quP0C1KB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEpBvXnyauIOGnyEmZYRwrA3SaIYkh6TAxeS2PiiHIA=;
 b=Bx2yR59hFT38xs+VCX1lYBqIyTRxdMwdIvNPPcgBDt6uEOHW1mpQjWZ5hziXlDE1Hjd5p/iRP5TyNgW/fsisECtMtyGAA/bGqFqXiqiUxPMp2VYT76sa/FzHcp0AxgRQtu4gmcxAhO96BftX1yPJLwqidjImAsMJYV3iubAmy4JZcNZBssi0HT4e0/N4d8I33fFEeH6ijqlSJkJLiYxWNuoPiwa65VooxSk2WR04cyYABFALsLSuc12wIWdhpWQ+TyPGPzWx5VVYbM62EXdsHGfPvAJy9pePfqZ6P9LE24enZz+Bk5SQLK5DuXbsFAkvIgogrrnMOO1m6ow7ExaFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEpBvXnyauIOGnyEmZYRwrA3SaIYkh6TAxeS2PiiHIA=;
 b=rIYSlyt7W2Nlu4X46Y1Hi52HqO56ROGdxHMtqgSV8JodVVQ03cXJQgrHtLpvP5h50WLvhR66aVZcINZFLx+o5m90JZLp56dxaXA2IrogB/RZWTA7ikf0ZEktxL3v3182AVPRilIfoyjsjUk8rr5Ef88DtaHmA0V8n1ntXiHMgZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Fri, 8 Dec
 2023 07:00:25 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 07:00:25 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 1/2] nfp: flower: add hardware offload check for post ct entry
Date: Fri,  8 Dec 2023 08:59:55 +0200
Message-Id: <20231208065956.11917-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208065956.11917-1-louis.peens@corigine.com>
References: <20231208065956.11917-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB3702:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eba0251-72d1-4e0e-b338-08dbf7bb5a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hRji8vSGEZ0apq42SD53Jp4TQKv8zWEON1mWZmQ3mqkV5rbwlJxEBRcMD4F5WIOl61MzJr+wLs8E4DVJ65hj0dhZM11UvhtBgmkU9byD23B/KXC54cAh+JZ3vSYJ1Gh98tIp0CSoXsKjGnst2uSHr4AnwVo4AZjEqp+84a8v+8jchetEGdhhP7oDfEDbhNvATwayGusGstRjoW0A35jqTqe4njRHLvdgTALsC7y3xl1/iIGoeHoCA2oyg3UJnVQ+guj1Knrcs/zxYk+gjTGEz+Rjj+jSHbN8qOKuQMl0wwR8eDqLP1o0zVGWAXdFlA5O0P7btFjOmK5DX4OVs/q2zLQs0ENO5fB56YwH4WUtKwBYG8hW8FpLq0zgQ7u+DIsyvVLmrNaoxd2PeBjMBbp1Fu95fwNS4s3JH59tdlSsGnyhVU452sKVbrN4xODsWgPZzZA+XStBsHqqyuNsAWcZyIQukWLU0NFvY1RQO5oRZEepFkN1TVP6LbKMPLns5tHLLzAjRUmKEkaN7QecOBDu54XTaqKf4rQVfIV8Qc8UbPGca1yvauSKBTfkGDzfv2S6WqwoJ0p8NL4pePglGrGdwoUWS6fdRIyEvXusarnZTNLtKmDloXHX4uncm8BVOdEx8qAp7Ke0rv4YUuczb/UyZAD60OZHm6xG4IP34XA4OMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(26005)(1076003)(107886003)(2616005)(2906002)(66946007)(86362001)(44832011)(38100700002)(8936002)(4326008)(5660300002)(8676002)(110136005)(66556008)(66476007)(316002)(6512007)(6506007)(52116002)(36756003)(38350700005)(478600001)(6486002)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GBeMbBnJLnPVa/KTX35ytnDYGX+ePA+J4TXj81Rg5QvzIGyBfR+Tlr73AI2S?=
 =?us-ascii?Q?YYgYeNvNrxmMgeqifTTcTg9ELXbV8YhoAYZmwFOrcN0mhheXrFDH/4Iql/IA?=
 =?us-ascii?Q?QTgtO30d/mVbQiqySx2+XlU1RNyGGGQfrUnJpvSN8ni8GFbbhv+0qjH90TzC?=
 =?us-ascii?Q?INxMrjAJr6yjSU3tA/ChP0b8mke3f7M7p5uN4i0sXpAJpbrglW/gZHsQ6rlk?=
 =?us-ascii?Q?EKCdABKowgIalM8HolFGFt60RSwaBicGfZr6rWuhN5eFWWOftHniKoTxnYaW?=
 =?us-ascii?Q?ThkkFANrtotOwUXhJoh08feZdDPDofTjZqKHLyFZQd0tB9rX4rj+wl52xocn?=
 =?us-ascii?Q?ey/+m0R8ujZ6OdG8ruyOKY84lM9QWbSdu3aX9vQldAwu0ywcpdrR1pgs/gI/?=
 =?us-ascii?Q?WrPMaPw104upsMftancJ8TMojuZPLC4uLgptIwzItzJDHMN7VwJChSmVMhhR?=
 =?us-ascii?Q?DfnPpwIZOvGYqV9y96l5ScOJXa1l/NyfnOb2nBS1jo9dX/Iu0sF4NcOlS6lu?=
 =?us-ascii?Q?F1He+RSAPpKHomtW9LA4b1uxNdAwPmepi8CGCkZw1TBFDH+y5zcPSCuS+pzV?=
 =?us-ascii?Q?Tyk5A7KUbE4aKZf/0RdrsTJVH0Nz8UEDq5KkCzknTB/dVvW0H+XDVk8u1oKM?=
 =?us-ascii?Q?lMtEF1lSEPyc0Tq+4+Pb4soAdAswT7pBXk2SICsOQ6i8P2cOIFkiHPqK85mq?=
 =?us-ascii?Q?no2EOpJWhjKlWnwFkEEPjxvY5p9n9jQM3GdXUogqLmWIhmQ6/Do65KnyX5wX?=
 =?us-ascii?Q?qWav0yZPtlcNLXSlsxgvbXuEMhhG5eyCGqtatNExBD+TpccrVeBGOXS0Ys7/?=
 =?us-ascii?Q?vLyJ7Tgr93wddKVb/6K+KIdkQ0Zxt8gvEB6iS7WP4hTFchvT3GIyjdQ66NfG?=
 =?us-ascii?Q?conk2BKtSsQWg+R3Ag6EL2jNic81XuOg+D+tHTvCpC9Co53d6N4S9FirxpLA?=
 =?us-ascii?Q?mVJc9Xoppz12ZFMwxFwuirIpWPdU+kLw50fetGJVgp98eVipVE+9oeglRgBQ?=
 =?us-ascii?Q?PPkvfAdR/trkjM+SSRsueHBUDYOXNBZj8wTbgCE3P+dxH1gKcle314lnBigk?=
 =?us-ascii?Q?Qls9yqpkOmT7b2KhtVZc/zPCUfjVAkoUcIvPWjJY4urTeKvk7QU7eXN4KTZ5?=
 =?us-ascii?Q?iNQtIYMOnjjGoCthYdmOYSvpU3tBGNlBoUrbgk4vdgzfq07V1zhRn25X8qho?=
 =?us-ascii?Q?VSTjiHjVMN14iRBQyuLcEGYnrF1h7UeAxfTWppZ4JXwYrZbAO6u5oUmQBgrP?=
 =?us-ascii?Q?vNNSWOnqpOHDMMDqpDE+koub7Z5OvvAvHFaJLvvrbSv+N08X+7KYvKzTkFOj?=
 =?us-ascii?Q?wAlMuoEPGBBgDdybzooZS4h9uZtrr/h4s8vaiuh1iJKteRZydwKXHVaShLOn?=
 =?us-ascii?Q?wckBK/UFgFmoenJ4Gn6C30SoNbI24uZKmDUEwjtnK8souYB4QBDc/JmerQWL?=
 =?us-ascii?Q?lZH83ebEXouZ5aUfdFxmjo+5bD6wM2q3lGpxWSYK22htYnGjqq8FOEKzYp2L?=
 =?us-ascii?Q?SXk4XN61jNSfuuI/gCG5l6cNjHPsypiQUEz2I4WPmbiiHK4l2hpOJkVmp40z?=
 =?us-ascii?Q?r9JPY0Xf6RdGimdlwGM97MX9Nev3XSEeRAdTYmO2Hd23m188XXt3RtheiYkD?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eba0251-72d1-4e0e-b338-08dbf7bb5a78
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 07:00:25.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq9RPr3y2LQNHpssr1Fyos56VF+3TAgtHoIj8GcIZkBYLvMsGqfizh+aah1CJsehBjlJuJvx6Y8tpRA27BylUtuHaLXfwwj9MY0uFO+7gCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3702

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


