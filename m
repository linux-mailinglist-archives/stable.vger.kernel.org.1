Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93247BD976
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbjJILWi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346221AbjJILWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 07:22:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2134.outbound.protection.outlook.com [40.107.237.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E6C6;
        Mon,  9 Oct 2023 04:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNa+r3W46ccRGY9PL+PHfRdLAx1qrE43MiqE5bYqZBy4bcjxc6POtlCXE/+4wJuaVJ9SN3++zbclAJgDQqWsU/lh92gthjf38DChClK5DUJtfFzmeVm18ecRYp177dZg+lEIFprWEe5vjDCJsd4FsHvMY7hcrT8qElZJRD+cKNJbI/R2E9aL6ydyLKitiBflKWhDErgvKkkm+52trEHFAGa6BOjzxD8K1Da+dfdCTzWZQUe767MeHjirK6meUCOEUA/c90Ocy0wwKmEgtCDVzCAY7jpIz+g7v1WdK28rnvxlPakrLem3ltVsYCva+XNQKdrrsiJP7rRoDSyJrAkF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGv5Md6qqx8skK75Hio+sgI3jm7k3uXXrO4Ub8hZ0D4=;
 b=Mkt8K6yit1sTD5VHdO1lHpH1QhgYQ/onOQu9J5/BCAuJiHH8TaEzofUEVZm/OPOa2ZrtKXzfA1AO9oFtM9MU6kSHFFmQEh0Ah/2DocH3p+Dms9dWEhisqDyhkGwqLyErrAxy7sKN8r/q+BfjqRp/jWhYxDQMbntBt2IWWVSGv/+ic0YygqiVvOhxJZKe9MNyXD5NLe8DDbeiRxQLs56bLRD89ZbGRhS3HDh1NQOZ6m7C2gEUDjv2MIT/Ba/yWKrblbSBZuDZ0G1IHnUTyf/FsUH17hawYutP5Xt6dyJW/ztZGFufSWkxxfmbVQ1Gy+3FRyUFlLy9jF3wCCHkmmCqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGv5Md6qqx8skK75Hio+sgI3jm7k3uXXrO4Ub8hZ0D4=;
 b=W2YdgVYVfclFxbGkNzxlAxI1ECNMgiM+DjEP36lbsINNQaC5ZawYAusQAh2Ac6oOmDDxOKSr0VCjCrFiBV65wrv7Zs2FfzJki2P8s+mXjeFNDqsKBl6TDigQc/g4QcdSrwHMeeCP7Nuc6BpyHkfd29V34kgYLRmpxXIg8Zw++ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 BN0PR13MB5181.namprd13.prod.outlook.com (2603:10b6:408:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 11:22:28 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::6287:b0d7:3d05:a8b3%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 11:22:28 +0000
From:   Louis Peens <louis.peens@corigine.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <horms@kernel.org>,
        Yanguo Li <yanguo.li@corigine.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org, oss-drivers@corigine.com
Subject: [PATCH net] nfp: flower: avoid rmmod nfp crash issues
Date:   Mon,  9 Oct 2023 13:21:55 +0200
Message-Id: <20231009112155.13269-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|BN0PR13MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d6d75f-55eb-4f43-3d47-08dbc8ba057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1jGKGX5tr/xJ2WNVeIHt4eSn/v117MnBNjgfpAfcGHuN+4kbK/XObRXODClCVQ02C/8nuOu6QGApJiy1OICyvLCn2Cw2syTDIOZUSZUIRrQMKkw1idXVxYn1vRXrY7xxEPXmXfAZuHeg/ZnTNPkB2xSeBxjInyJP7/NDdP9nwUhfYd7fWzAZq1yCOnXsgPq6FgEY5+LNBreBktpRQcq4FSqyGGGMk0AhaPbuYFm1DUKegs6DEiP4C8wAdn2eh9jfuS/uykVl2m3KTqSwtbYeS+pnY69n2phUPRWb3gF2SZMgUgy4mKUg2pyZPKyBWqJb16+OssI2IdNpJ59eN+JMWW4z1y9/gtFoYdDFsnsCMU6dyL1Mev5ruJZhNjx0fB6xdq705UU/uAdN2Ab7gxvW8GADOiaED6bbOXb2uKidBBbbbx0WJ6K66zW9Tz8bOgJtZSleeJKFKlzeTOlpmJrJfZCCQXPELTFKZdk5VIxrnbimWpkpVAkmoMNYCNG2TFUZFw5/YRjiKjACqpChJJJXQSki+Ga3ziYH9EJSxqH5RtEZDBw9+0LkuQ0E5jENYqQtqpUafePNTaw2o14LbLwTS4Pl9zvm94Wne/vc1Cs2HKCX4gsxXzF429MjXw4wsaOYd1+/0vItYQoxN36OGt7lrGZZ9RidW28dyaAiAECMKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39840400004)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(86362001)(1076003)(107886003)(2616005)(6512007)(52116002)(6486002)(5660300002)(2906002)(44832011)(110136005)(478600001)(66476007)(66556008)(66946007)(316002)(41300700001)(54906003)(6506007)(6666004)(26005)(8936002)(4326008)(8676002)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdqb1hHLzZqc2xKTUx4R1FmUHlCNjlMOFA3V1VrY0N1TWZYaE1lWjVOREJ1?=
 =?utf-8?B?RW5LNVNJYVNVRTNabC9Hd3k3aVZvYlRMVlZ5c3AxUnI0MFk1ajJHSTJoWmFE?=
 =?utf-8?B?di9lcjF3L3N6YWVya0JOVFgxMGtBOURNUzRYSlBOaVBSUGwzb01naGVxaDdL?=
 =?utf-8?B?VEYxc3MyTmZRbmhWRXJjQzNwYVJXT2NSamNMbStMbElFQm82bW13MDVGaTN4?=
 =?utf-8?B?V1gxMXZ4ckxMYTFQSlVJckpDVlRidFpBS0FCRHRQVys5aHlIaFhKMDNCdWkw?=
 =?utf-8?B?SkxkeExOZDVHRjRjTEo0ajVnN3VVZU1wTStrdzkvdU1sdnZYTlIwMEtaSkN1?=
 =?utf-8?B?SHVoeW16dUxRSlUwem91cHE2TDhZKytBQ1dtRGVOUG9JdTRWd0hEb3BRSE9J?=
 =?utf-8?B?WmZJQ0Ywdzcrc2YwN04yTmVSRk1iTmt6aDVkOVNnRlRzVG1RenQzalBBZDZv?=
 =?utf-8?B?bDlscUt1aE5NVEhvRkRUbXZreUk2SUhlc05NVWg0WFJwSkJ0ZUh1TzVTZVhL?=
 =?utf-8?B?N0RlNGdERVkvWWZTelJHdklQM3oyNlZackU2QkhCZEpQT1Jtb3NNZjhqYkJD?=
 =?utf-8?B?WFl6N01UM0xXZmRablo2a1hOcjFCVE9JMk8wZWtxd0RrL0UrWW5WM2NkRnJv?=
 =?utf-8?B?dy9LbnZvdllWV05CcUlTYUtFVmpNcUk2aEtwWnliNWhKcG91bDFQVEVIN1ps?=
 =?utf-8?B?eGxaeFQzVG5qOWVBejVXU0YwbDVmNnBJdWFGblFlVDkvcWIvOEszckJXbzVH?=
 =?utf-8?B?N29NKzlXc0JKdm84VW4zRUYyb29FUzlHODY2dVB6RzFUVG1ZKzR6dXRvaTlS?=
 =?utf-8?B?N21aeXZ0aVE1YWIxaTQxVjZPQklXcnA2VjczTEpYWEdkVEgwNDdxTVNDdnhQ?=
 =?utf-8?B?UW9Kamx3Sno4Zy9Ebjh4VEV2c2NoZ3E0WUdURVR1MHFzTm5kODRBbzYzOUVI?=
 =?utf-8?B?TEZsMHU5dkZOSjBGeVFRSlloQ1pQaHBEKzlta2ExbVhUbCtKK2l3aW5TTkR0?=
 =?utf-8?B?cXZDTEpxU3BLenlyREkwSDJZZFRrVEFEci9RWURsQzlvRDd5emtBVDIwaHA0?=
 =?utf-8?B?ZU0wd2JEcW5BRlliNytvNlpZazJ1L3dsYWRGQm45SnJTM003MXp6NDA0UDNo?=
 =?utf-8?B?RWxvSUVZZ1J2Z2JRM3ZCc3pWcFNLRWNSUUt1aWdPd0R3Umx0aE9mMG9NZHlu?=
 =?utf-8?B?ajhsRW1Ga2d6dzIwMkhpajk2S2N4SS82Wk0zdlRYM3hjdTZ4eVhZVmMzV0FG?=
 =?utf-8?B?dXBNUjR2a0taVkwwbEtJQkNmaWJ6MGZQY0FXM204T0hOTGlSblJOWmNiWEJ1?=
 =?utf-8?B?MjdJR0JrWWIvYjlxZlBrYmJ0T1dyTlV4d3VoL0x4UDV6U3ZjS0t6ZXFOcG9k?=
 =?utf-8?B?d1B4TkdsSHJlUFkyUjVvNExxR3ZNR3l5ZkF1QVFmc1dmZTFWQTN5NVdqWm5N?=
 =?utf-8?B?UTVRcjZDVTdBU3VLQjA2QkxrR204NEhrMERnL3pTck1HR3h5THBmVnVhSkZk?=
 =?utf-8?B?OWFWbXp5c05LREp4eHE3aFg4am9YNVpNY2drKzB2M0VyTnVGaTV1ZGJDMGox?=
 =?utf-8?B?eWhqSGVpbG5zK1JjakloSU1Mczk0dnlnOE1ZcndjVjZrRXhILzJhSUpPRU5S?=
 =?utf-8?B?RmtkN0dydmR3YUhKbDE3K3hFbDJrK0Urd2RkWkNtMzJlbmZQSGFtcmFEQm5E?=
 =?utf-8?B?cnRjZGx5Yzk0amxwSklvVFJnZ05QV2hZelZXZWdCZmZzMTgrMU82aFJkSzNi?=
 =?utf-8?B?OEZsUmp0eHdoWUp1a1YxTmZkekE2bjNWVnNFNGxkclM0eElTUC9mdngwRGRs?=
 =?utf-8?B?ZUlzYnlVWFZOa1MwczVkTDJoRUFJOGd6N1hla1Nha3ZMTEU3TzZCMm5KUE9B?=
 =?utf-8?B?MnhXTGRPMHdXLzZ5cXJkYkVVWVNnOTdJbGtNNnZHMHRNU0ZqVWY2a1QxRzBi?=
 =?utf-8?B?SnovSmJyaElqZ3JkWnVNSEFORmRPUXBaZWhCeGlQcE9mTkRLT2F3NS9QVFF1?=
 =?utf-8?B?THRvZFU5UjkzN2Q4bEoxZlpyL244UFdrY0p0cEpDRTdtcjV2aGdaV3JBTmJG?=
 =?utf-8?B?dDdLZmtJRWZyeURCQVVDd3c3WFFHU2VJYUZTNG92dERhSEhrWUtnQ3NKaytN?=
 =?utf-8?B?TEVnMkd3UDV5QUl2aHE2VHFtUGhuTlZCNjBKL1pUOHl6ZXpqZzJ0YVpJWlUr?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d6d75f-55eb-4f43-3d47-08dbc8ba057a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:22:28.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmRh0m0wD5aI8QJCfrrbrQ7pXSke3TGVw6BP9ZmTk0eGckjYK9NC+6oUtMK9DXLZcw/7Lb2+3fuCRg5D50+3kmoScsZOpO+2S5+NAf1t60M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5181
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yanguo Li <yanguo.li@corigine.com>

When there are CT table entries, and you rmmod nfp, the following
events can happen:

task1：
    nfp_net_pci_remove
          ↓
    nfp_flower_stop->(asynchronous)tcf_ct_flow_table_cleanup_work(3)
          ↓
    nfp_zone_table_entry_destroy(1)

task2：
    nfp_fl_ct_handle_nft_flow(2)

When the execution order is (1)->(2)->(3), it will crash. Therefore, in
the function nfp_fl_ct_del_flow, nf_flow_table_offload_del_cb needs to
be executed synchronously.

At the same time, in order to solve the deadlock problem and the problem
of rtnl_lock sometimes failing, replace rtnl_lock with the private
nfp_fl_lock.

Fixes: 7cc93d888df7 ("nfp: flower-ct: remove callback delete deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Yanguo Li <yanguo.li@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../net/ethernet/netronome/nfp/flower/cmsg.c  | 10 ++++----
 .../ethernet/netronome/nfp/flower/conntrack.c | 19 ++++++++++-----
 .../net/ethernet/netronome/nfp/flower/main.h  |  2 ++
 .../ethernet/netronome/nfp/flower/metadata.c  |  2 ++
 .../ethernet/netronome/nfp/flower/offload.c   | 24 ++++++++++++++-----
 .../ethernet/netronome/nfp/flower/qos_conf.c  | 20 ++++++++++------
 6 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
index f21cf1f40f98..153533cd8f08 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
@@ -210,6 +210,7 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	unsigned int msg_len = nfp_flower_cmsg_get_data_len(skb);
 	struct nfp_flower_cmsg_merge_hint *msg;
 	struct nfp_fl_payload *sub_flows[2];
+	struct nfp_flower_priv *priv;
 	int err, i, flow_cnt;
 
 	msg = nfp_flower_cmsg_get_data(skb);
@@ -228,14 +229,15 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 		return;
 	}
 
-	rtnl_lock();
+	priv = app->priv;
+	mutex_lock(&priv->nfp_fl_lock);
 	for (i = 0; i < flow_cnt; i++) {
 		u32 ctx = be32_to_cpu(msg->flow[i].host_ctx);
 
 		sub_flows[i] = nfp_flower_get_fl_payload_from_ctx(app, ctx);
 		if (!sub_flows[i]) {
 			nfp_flower_cmsg_warn(app, "Invalid flow in merge hint\n");
-			goto err_rtnl_unlock;
+			goto err_mutex_unlock;
 		}
 	}
 
@@ -244,8 +246,8 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	if (err == -ENOMEM)
 		nfp_flower_cmsg_warn(app, "Flow merge memory fail.\n");
 
-err_rtnl_unlock:
-	rtnl_unlock();
+err_mutex_unlock:
+	mutex_unlock(&priv->nfp_fl_lock);
 }
 
 static void
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 2643c4b3ff1f..2967bab72505 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -2131,8 +2131,6 @@ nfp_fl_ct_offload_nft_flow(struct nfp_fl_ct_zone_entry *zt, struct flow_cls_offl
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct netlink_ext_ack *extack = NULL;
 
-	ASSERT_RTNL();
-
 	extack = flow->common.extack;
 	switch (flow->command) {
 	case FLOW_CLS_REPLACE:
@@ -2178,9 +2176,13 @@ int nfp_fl_ct_handle_nft_flow(enum tc_setup_type type, void *type_data, void *cb
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		rtnl_lock();
+		while (!mutex_trylock(&zt->priv->nfp_fl_lock)) {
+			if (!zt->nft) /* avoid deadlock */
+				return err;
+			msleep(20);
+		}
 		err = nfp_fl_ct_offload_nft_flow(zt, flow);
-		rtnl_unlock();
+		mutex_unlock(&zt->priv->nfp_fl_lock);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -2208,6 +2210,7 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct nfp_fl_ct_zone_entry *zt;
 	struct rhashtable *m_table;
+	struct nf_flowtable *nft;
 
 	if (!ct_map_ent)
 		return -ENOENT;
@@ -2226,8 +2229,12 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 		if (ct_map_ent->cookie > 0)
 			kfree(ct_map_ent);
 
-		if (!zt->pre_ct_count) {
-			zt->nft = NULL;
+		if (!zt->pre_ct_count && zt->nft) {
+			nft = zt->nft;
+			zt->nft = NULL; /* avoid deadlock */
+			nf_flow_table_offload_del_cb(nft,
+						     nfp_fl_ct_handle_nft_flow,
+						     zt);
 			nfp_fl_ct_clean_nft_entries(zt);
 		}
 		break;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index 40372545148e..2b7c947ff4f2 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -297,6 +297,7 @@ struct nfp_fl_internal_ports {
  * @predt_list:		List to keep track of decap pretun flows
  * @neigh_table:	Table to keep track of neighbor entries
  * @predt_lock:		Lock to serialise predt/neigh table updates
+ * @nfp_fl_lock:	Lock to protect the flow offload operation
  */
 struct nfp_flower_priv {
 	struct nfp_app *app;
@@ -339,6 +340,7 @@ struct nfp_flower_priv {
 	struct list_head predt_list;
 	struct rhashtable neigh_table;
 	spinlock_t predt_lock; /* Lock to serialise predt/neigh table updates */
+	struct mutex nfp_fl_lock; /* Protect the flow operation */
 };
 
 /**
diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 0f06ef6e24bf..80e4675582bf 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -528,6 +528,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 	if (err)
 		goto err_free_stats_ctx_table;
 
+	mutex_init(&priv->nfp_fl_lock);
+
 	err = rhashtable_init(&priv->ct_zone_table, &nfp_zone_table_params);
 	if (err)
 		goto err_free_merge_table;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index c153f0575b92..0aceef9fe582 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1009,8 +1009,6 @@ int nfp_flower_merge_offloaded_flows(struct nfp_app *app,
 	u64 parent_ctx = 0;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (sub_flow1 == sub_flow2 ||
 	    nfp_flower_is_merge_flow(sub_flow1) ||
 	    nfp_flower_is_merge_flow(sub_flow2))
@@ -1727,19 +1725,30 @@ static int
 nfp_flower_repr_offload(struct nfp_app *app, struct net_device *netdev,
 			struct flow_cls_offload *flower)
 {
+	struct nfp_flower_priv *priv = app->priv;
+	int ret;
+
 	if (!eth_proto_is_802_3(flower->common.protocol))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&priv->nfp_fl_lock);
 	switch (flower->command) {
 	case FLOW_CLS_REPLACE:
-		return nfp_flower_add_offload(app, netdev, flower);
+		ret = nfp_flower_add_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_DESTROY:
-		return nfp_flower_del_offload(app, netdev, flower);
+		ret = nfp_flower_del_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_STATS:
-		return nfp_flower_get_stats(app, netdev, flower);
+		ret = nfp_flower_get_stats(app, netdev, flower);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&priv->nfp_fl_lock);
+
+	return ret;
 }
 
 static int nfp_flower_setup_tc_block_cb(enum tc_setup_type type,
@@ -1778,6 +1787,7 @@ static int nfp_flower_setup_tc_block(struct net_device *netdev,
 	repr_priv = repr->app_priv;
 	repr_priv->block_shared = f->block_shared;
 	f->driver_block_list = &nfp_block_cb_list;
+	f->unlocked_driver_cb = true;
 
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
@@ -1876,6 +1886,8 @@ nfp_flower_setup_indr_tc_block(struct net_device *netdev, struct Qdisc *sch, str
 	     nfp_flower_internal_port_can_offload(app, netdev)))
 		return -EOPNOTSUPP;
 
+	f->unlocked_driver_cb = true;
+
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
 		cb_priv = nfp_flower_indr_block_cb_priv_lookup(app, netdev);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
index 99052a925d9e..e7180b4793c7 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
@@ -523,25 +523,31 @@ int nfp_flower_setup_qos_offload(struct nfp_app *app, struct net_device *netdev,
 {
 	struct netlink_ext_ack *extack = flow->common.extack;
 	struct nfp_flower_priv *fl_priv = app->priv;
+	int ret;
 
 	if (!(fl_priv->flower_ext_feats & NFP_FL_FEATS_VF_RLIM)) {
 		NL_SET_ERR_MSG_MOD(extack, "unsupported offload: loaded firmware does not support qos rate limit offload");
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&fl_priv->nfp_fl_lock);
 	switch (flow->command) {
 	case TC_CLSMATCHALL_REPLACE:
-		return nfp_flower_install_rate_limiter(app, netdev, flow,
-						       extack);
+		ret = nfp_flower_install_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_DESTROY:
-		return nfp_flower_remove_rate_limiter(app, netdev, flow,
-						      extack);
+		ret = nfp_flower_remove_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_STATS:
-		return nfp_flower_stats_rate_limiter(app, netdev, flow,
-						     extack);
+		ret = nfp_flower_stats_rate_limiter(app, netdev, flow, extack);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&fl_priv->nfp_fl_lock);
+
+	return ret;
 }
 
 /* Offload tc action, currently only for tc police */
-- 
2.34.1

