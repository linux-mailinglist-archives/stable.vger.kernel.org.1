Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF0739BF3
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjFVJGG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjFVJEG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:04:06 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A28449C5
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 01:58:02 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 35M8mStO031970;
        Thu, 22 Jun 2023 01:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=2QIQjOHXM11LoybmuYnDiUXEmlE8GhgVEMbAaiXh2zw=; b=
        LyRtgO08kNLwDxTqhkm4ufqccDgGs9clelrU3/j/wLm2Jbq7S+gEFPL3sjq5aEHA
        D7OL8Covg6QXMg9MRi7prexPXMG9BETqcVtbxGjLBGoqIuclA59mbwmgD0O1IgLq
        UpOv3VLkOl4uvcYaMAbLzIvFlINWiffWi0ayfrk6jZw+uloZgs1fgLByOPkA3SUA
        NruN5wtvQIG07BE5AxIZNPAiQzPGa7mA2eHPcLe9jo80i8R4Kb3jTZcKhcMqP/Zt
        rADnqnDn34Incqhg3VaR/dC0BHYUbDEraYTN9zkVaQhOYFRXYrJg6k1ilh7+akah
        N+eEibiJP7Uaryy4ca0wKw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rcd6yg7sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 01:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4kQvgYJwGlwprFNHd8kDGE2Awq0ooGd8W53vkjdf1kolsRl/JPnbnxgP8A0IB7yFhkIEJcmncyQz3oaArhRdhZShgeAaSklBvImvaTuCb7+U2rdna/u6giQXRPTTw5Ap0RWxImJVHekkCLDqLLsyvu9aHOSz1nFtQrbUUeUHANslolFtBRKh6sqhuO//ozAkKD7zo7TN0dI0LbX7eJ9/NYi7Ytw546t+8mkPG5hFYQvGgzYVICqR63EjTCcgfY6RfM5zq/3mH5hyyCckKogIQIazno8Lw2AGJOr5J/do6JHwc0H+g9f0bLmUnVTFDWE+6/pLcxVyRSWDZdiK96gGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QIQjOHXM11LoybmuYnDiUXEmlE8GhgVEMbAaiXh2zw=;
 b=OwEAsEELgz1FS2SvhjjSvyYuXgAzbDZVrEu9p5/1VsITj74VG2ErcTr5NHLjfFn6VZht8ZvSTU8tz44fpT0gYPo+ewTM4WIVKzx4iBhCI6Ot88WU0m32D+sWwVkeM5srNEuogOtXxSCu+RUlLpAj9xQ6+TDEluNLGRfwFhu6s6qhJokl3qwxZ2bAOXPwq6xhCDF3D2HmLMqnv7AHMWhsKghgzY12WOK+oO+Q7x9wJtj6u4SZsKr4V+NhjyJsRteMm5muvN/MuGAa05LB6SJgJ+dyCNLmSauvhJGpg1hA+zd7wozLpVog9FAQpi0h+FVm47hY6BdueusOXzXCCDybYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 08:57:06 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 08:57:05 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 2/3] media: dvbdev: fix error logic at dvb_register_device()
Date:   Thu, 22 Jun 2023 11:56:44 +0300
Message-Id: <20230622085645.1298223-2-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
References: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::41) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|PH7PR11MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c73965f-0068-4e7f-524c-08db72fea740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZlIgf6QeD+a1UNzzR9rz2i54bOif5aLIaL1BuN/OXP57tnCjQMg3XFmn1Z8Yoydv3x1bbL6feyGBiPAkI1EX1wZXk795emFO6t4+Y4xtT/gL3iTggLiG/PhoqVmtRvjGgMXAdRo1QEjFhhbZA3B91SoAyZx5Ov/poMCNswDHHhtydqzEM9UihzJ6Vuo1KZl/pbO8lMUYZ3r9txrwvK/Djc2qoqLSRJym2nHAbZeCrRKXjGnA/Hje6NnM4v4sacmxN6fYyRlz1PnouUGQJqGstlm21yuj8OZpjvxVtnU7itcn8GyYIxJq/RlMwW1vNCZesm3Ch0AfpCDrHu2p84rRUgF02zyKXVxjsweXUs7qzZC9LwyAI9HxfswnI0YxOOkhM+TfvTH/7ziMReOR77lVtavqUa8Hr2ITw0Zx2DsUIKDL6YO1Xs4ubc2kHYrNAFyV6SKJiz3C0tfUdXwKgVtSUJjuos1x/TNji1QaVz4ghYnkpTKDaD1Y0GaOKLAVT2CXtatGtCIr3KJjvSAOn8GRRIRY106s9o6IaPhJTKvbGhHYLqPZTPRC2wjv7qFqrtn0UojXKms1tR1EdOdi+a/EL9TptUb5g54FfTRGyMAfy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39850400004)(451199021)(8676002)(4326008)(6486002)(52116002)(66556008)(66946007)(66476007)(6916009)(478600001)(36756003)(6666004)(316002)(54906003)(86362001)(83380400001)(6512007)(1076003)(26005)(6506007)(186003)(2616005)(38100700002)(9686003)(5660300002)(2906002)(41300700001)(38350700002)(8936002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9r7gEsL81mrKupy540Iq10HMaidr8RehRdxYWNMvjsubUXIDlgKllCt/Q2UE?=
 =?us-ascii?Q?RTGEee+lpchDe32KKipy+d5/+NaBqid4FIJPVXETC1hQaPjd/rKlZ3TYMBkN?=
 =?us-ascii?Q?5JAWcLM6Q2UU2pHSwf2qscLcSYu1E0G1i04tqqvEu+2biMK+Bmw9pOul7uha?=
 =?us-ascii?Q?72bqO8qvhUc2MuOR/3FM/SS+febcIicGd+6qaZgJGgt9u7J37ETrGH725T2I?=
 =?us-ascii?Q?ouDGg9f4y35X1dFbJP6i+ctotzUKOyyLIM/YBqQzJwnI/7ERdZioWzyGtiwf?=
 =?us-ascii?Q?pZtgpE9klpGkLOcCFHCfsqSoB5DVA9WCJm3mY04tbhJtf5EuMTl/k740d5qD?=
 =?us-ascii?Q?vv6trvYLsXf0wVeIj0G92cj8TelnMidAyz1coHBbSQGHH+jyxOpymtan6W/P?=
 =?us-ascii?Q?Z5NS8ly5eJgi0eiyCq61AMEOhfT6n5hIPCw18/N76KBHuGGPqghau/KwWc/z?=
 =?us-ascii?Q?zENmliA/zXPPv9eimj1bbXmq7gggqXSPSIVsmRxm+fE8qkPVDboXivjYVTYf?=
 =?us-ascii?Q?+rEoa02uycPkHUv/2gEgLkTKab3B+xcfuN1+qfNFyx5b57fVqOQ/1zf7OZna?=
 =?us-ascii?Q?Rxw/kn+s2BlgUUcoBX7gdXES56aaAEqtTc3KJoKppuCJl4qOGySa71dR1JJr?=
 =?us-ascii?Q?7xbHOiWADFtGRcbUMt1YLKWVDzYSuiU7lTaxGVK7miblugmDfJx8snubpbZR?=
 =?us-ascii?Q?mHMqeaiyGYLTNBynZM4sThjHgBfyp3BycNkv+NCKeZcoK4laH8Bi9GCudWpY?=
 =?us-ascii?Q?40zlP5rrKV6kKG/2Cy5rvade4hru0KY+6YxndQaDY6tXZ/y0scPv/HKYVarw?=
 =?us-ascii?Q?8snczit09c70QgXhMYidmfSV/WlLle2qpHnIujTNLz1TxfvbOA7LEFjXv9EN?=
 =?us-ascii?Q?+q7DRTa4MdcAEA0VGNBQRA+lMn1xgw6uJ5EC7ob0++CTHkxRBvZAZL8lzU7Y?=
 =?us-ascii?Q?xOcTkwy4QeFv5BycxdGPvJC0ahRfZF+5D6w7zZXuXsJJakpL32lzuLPWoOLb?=
 =?us-ascii?Q?U3sA1HjQgHTzWuGWOmt07JRaouK1oxvDFtfkkRBfp0ZOSxgfxWTvpbP/R89v?=
 =?us-ascii?Q?EV3E1onlXiPWmeY4rFDcaJAAxPyDuYj5wJBIxSVWzw70UB7pizeHJZCBhIBM?=
 =?us-ascii?Q?zNN2MIyBhlbbg4zXtu+wVTIAGX7wBF9u2V8tCUZOlhcorjh2hhIi+qziopRi?=
 =?us-ascii?Q?7Um77TrAD5nqDfrdisobQdN246By2FRxbDIeK0dP8Qh7s+j93dvDQ0dQIQzU?=
 =?us-ascii?Q?s5NYKY5sqMNsy3hog62402jhE8+f9oWnLYUeAaJ+nOtOF7YlizwOwuYwulEg?=
 =?us-ascii?Q?t2dZ8akyZMgq6D3iU1Q6ZRqWPGiM735DoJG3qHiFgQvDpZm84OCcUPLTukV/?=
 =?us-ascii?Q?Yfb1nb1uim4R3U0p0FOUwVXFmZdZrRgEREHuNXzJfCHp01dG/Ig1zZFs+ujy?=
 =?us-ascii?Q?eeE4rurHOA+rso0J8ByPGJU3C5tZCU3kpE5SmKJviylxZ2up/1J41wKg+iE2?=
 =?us-ascii?Q?QLnHSPlvIV2w8chOECL1PMMtSfkYIZNDQDEuKqU0QCQOB7EwrafDZD0Uv8s+?=
 =?us-ascii?Q?OvaTxteN8/dw1eLINbhU14sbQ6vT7v4GT/gooT92EjTfwfJogA9a1dqqg5+K?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c73965f-0068-4e7f-524c-08db72fea740
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:57:05.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU+3mSmirYb2x6XNfWbzoYgQW7r3VMnN1bMurcLo9KmemEJgJSwVHgdERKTM9eh3TeD35juQk49o/8aLTQo3npxHA0d6lEc3tzLKIfpP8uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Proofpoint-GUID: g2R5NpLF6_PnNn0GxKKaa1pchGD_jBIU
X-Proofpoint-ORIG-GUID: g2R5NpLF6_PnNn0GxKKaa1pchGD_jBIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2305260000 definitions=main-2306220074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 1fec2ecc252301110e4149e6183fa70460d29674 upstream.

As reported by smatch:

	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:510 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:530 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
	drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:545 dvb_register_device() warn: '&dvbdev->list_head' not removed from list

The error logic inside dvb_register_device() doesn't remove
devices from the dvb_adapter_list in case of errors.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 drivers/media/dvb-core/dvbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 242fd8d160b9..e8b0cc62c26e 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -511,6 +511,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			break;
 
 	if (minor == MAX_DVB_MINORS) {
+		list_del (&dvbdev->list_head);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
@@ -531,6 +532,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		      __func__);
 
 		dvb_media_device_free(dvbdev);
+		list_del (&dvbdev->list_head);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
@@ -546,6 +548,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
 		dvb_media_device_free(dvbdev);
+		list_del (&dvbdev->list_head);
 		kfree(dvbdevfops);
 		kfree(dvbdev);
 		return PTR_ERR(clsdev);
-- 
2.39.1

