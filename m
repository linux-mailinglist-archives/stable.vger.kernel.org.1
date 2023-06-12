Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE772C62B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjFLNjp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjFLNjo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 09:39:44 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B1E9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:39:39 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBqONt032722;
        Mon, 12 Jun 2023 13:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=8bxo+BDDSFIpvf/YefYXUsnwKcf38zRSom5LXY71jSQ=;
 b=hcRHDJrhw2z3ubQEYB5YzBO++La9auhTSA9v95+EhaPRVDuvJNyt3a3/olHXqyl1MDXw
 IzDkPewyM9U85NTplj8Sar0paCJLH0l/0FWqcdDQjw/LpE3+vvY00lbUB5IWB73jwmEp
 7GbzzUglp8EfocDu6ECKXuxcWZrjT+7xxc/cgSOUkgtS/NU27v8IJOpBNsO4B0D1LYlc
 ctzPrgUNRLb9fHz96u1V5ETM7FODyAlsuGmwcGwoxtIP34TFZNapyqwi57xtPySZmYnN
 yKTSSkcNYvdJPMS/5ZyuRS7OYa+VUzuBorc87Hq5qexFbfNnBLeKU3gi8o4+R2CfYOJ3 AA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4ed01nb4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAvFfb57gSpwAIT620v15C2/oRlDkX89p6YF+jCc3c3eMVdSonAXDavNsB2epIEpmTUCOmmnXSjgtrE7/mwf022NVl7v2iQL9XW4lfeE6Suwywr8xchhtDVnA9ZJABcgDtdMqTMGY38rm1TdJOKLUAtuO9Zu2pkjJufFpd2IW+IxFBP//tyWuqFfcmJwGZV38zgDUx1mn+Tbh9Jl3pLtIqr3BSltCatm6WGH7/IMX8HtGb9Vl4fIEdoi+yWpMdJTUShJscW+4JDMv5CLUjEfCmBDRie9t5PMcxi2AsR0wS3yOARg2vaAOa+yCg/iuf+dMuaAzqonyIgujyZNMUCq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bxo+BDDSFIpvf/YefYXUsnwKcf38zRSom5LXY71jSQ=;
 b=JWF10keNzl+TDLxdjvNERN8e69D3m0ZLApqE1DAHd2EIZCh4lWhNqg6M6yUwG19qDFZPbzkhoNWT8szf12NlnBofx1pjoj+9UOBnU/vudUbSi1Md/z0Ps+kXXhsr9SxHzFaF87g+Ce/Hvy9mKTC0ck58wFnSVteYk1HDAAvXZXrGtOod7VqUeUGTjX8xbfumh+mMdffxv3TDC7DdfzUh7lTCGkf66nYAQGKgggF1z1QvipwTBq7noLhLl/My+eMKU1QWOw0B5LMz4hqCxwk8/rCJF6aqkvnd5Uf+9F0qQTD/zXwTaCOQPZ9MJDpogJ8OossuA80yT9uciVqxPD1JNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 13:39:26 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:39:26 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 2/3] media: dvbdev: fix error logic at dvb_register_device()
Date:   Mon, 12 Jun 2023 16:39:06 +0300
Message-Id: <20230612133907.2999114-2-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
References: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0151.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::29) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|CH3PR11MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: af47d9f0-0263-47fe-cbf6-08db6b4a7065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNgv3rqKJgtgKoTxoIH6DgmjQtvap1w1gS0TDPcmQ41f74uUv/IbCOBqCFicnhijCxLWrhKbq1FlBEiF0VTplo1IZw8YR8tbfF02OTA6cKmMe4JpLXOCQElLo17MsW0crlCdzoEPr6uDnvXf23p03E5j5cI5R2Hm4M2fOqskt70uRm1MT12HlYId0JXBbi9pza89OQhSpDv/JX9tMIVIJ0EdWXpe+KVrTWzoUe50TZMSU/T40bJXBh/Wmmr6bIIkA4eC4jeTPiNZUYCR9s0FbydfmlsfZcI+0mFXsJziMhiG5zpDp52i81p8oBG3NpOt1sQ+8K3TrL1xm9ucVTuhbh9Eg5rAW//gr+jcOq7g7mbN2o/UfHRTIG/1SuR8+JUa4ObcgFdlTa6yRjVMe2xXBOSOIC5Ds/jWvANWsHNXUZg39RA/yY/pAHTtRa/pCyiD71OxXaRVM1XxwPLs7t2o3wV27v2aQz9RAJvuFXHltiOeEtfVSIVgqM0Aek/53td7DlIZGnO2pMcx2pl5ATLPwjpoRhYyWPBym21qJGCpf0bJmfI98ZUYZn4V6hwZ2WbDRRmcDN43cSh6TQopk6QuAO2hGJYiORQLbSCzPxf+3hs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(2616005)(83380400001)(38100700002)(86362001)(38350700002)(36756003)(478600001)(54906003)(4326008)(6486002)(6666004)(8936002)(8676002)(2906002)(5660300002)(52116002)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(186003)(107886003)(6506007)(6512007)(9686003)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EVVgfQNqicPgfKZt9s7jYEJjQq5sc15rZjNGrb/DeKd6m2p5tmZ94yMtkg/?=
 =?us-ascii?Q?Av+pRfVq7FfoxTJKdId1fQbdLnbbDsxdZLOYkbMWeyjygxc3nx5TTdfGZXfR?=
 =?us-ascii?Q?N61kofVtMjEz5oj/gGls0a1wRoTiKVRfEgB2CEeykcUGMDRaSb6UJC0jsDiI?=
 =?us-ascii?Q?xU07kncvU+s2t28GhOSeEedqHtdQvhlwY/kBhBSSS1CdZ/48FYs58UGMOnBL?=
 =?us-ascii?Q?eDQC/q3crkyjF+Q6U/icUhq3CZZ7f3cMXzz3eoDJKyEe18nvf4lrKB6uIeNt?=
 =?us-ascii?Q?2uTYQYotwNp0lM4Bi8UtECLSxzQ8DYjawc7yALlDE5vK8bkOVsU3X+6CqryB?=
 =?us-ascii?Q?yka+Ii7JkWg9rba0l+AJ3ozmA4ygPl7LedJzK/afX92Ldrqp3l5uPnM0wYGN?=
 =?us-ascii?Q?80yInY58qi4pdVukLzZzhqSnFY6gsu7hOdIEYD7VrX+WrhiKKueuhBqSVxPc?=
 =?us-ascii?Q?RZGbFrOydXQSoejU06fhxwDc0JSJfL4+aaPGdpHDMU8pyCIOb7hLrRo7WV4/?=
 =?us-ascii?Q?VnZLbvgua3Q5/PndN6K1jCBh3xQMXnUHKLxEbCSkLlE+YluTX0EV+tz7vKYD?=
 =?us-ascii?Q?ASKfVAb/r07hJ2VfbqQsQrZ4RhUmThOI7ERLkchxtVL/q9ZbdkS2sqMrsi+s?=
 =?us-ascii?Q?H5pJcDdnElkmSgB07I+PYPKX3qEapYD1eNKhX8L8Py7uIKhLLqSNN6R5vMAh?=
 =?us-ascii?Q?2/ksgy9ofK70mlgILDyBW8h0aMp2IVeP3Q5nRXZhHkj1FoANmlbEGaKyhlEr?=
 =?us-ascii?Q?j+rC9OlvyMCkRIBTgfQJSv2eNgSHzq6whoOh63TiLGUeeeTQoJbcuHcSeZVR?=
 =?us-ascii?Q?xpiIzP/IMtAe3hCM9IBTy5dH+RmebGUrS6yXvt2mLV0EXmuUFJJEPMGQLHX1?=
 =?us-ascii?Q?MpTQcWE57yzLLOEAtNjcX+beALns65Iwx9oiYcZ0t5D/k+pvDDTLB73gVOfS?=
 =?us-ascii?Q?FHKcSbVb31F0LyfqS6D+6iwSMNiC7spgsZGB8Bbho2mHgZH4hohrUzKjUgQl?=
 =?us-ascii?Q?A2xFPvJHcj19PtE3RnyZjF3khxe2QpBYe4AcCPo0vtlctDKDu1RoKWCA4Yp2?=
 =?us-ascii?Q?iIVqaB5mB7w+JCz1Bg4+b6sgTwdbLqxIWe6I+N+umRo2scCByp2ALN81AXrS?=
 =?us-ascii?Q?l3khOHkp1Z9hk14QfhsucUuAsst/5q6PkHzxS0dSJ+NSvocNPjiz4eRJL0A2?=
 =?us-ascii?Q?429kkEUinSlOTQhX3gbrqjEDygvtbFSgP3lsY/Cc1BrVtV0wUm0+hyuwq5ad?=
 =?us-ascii?Q?C3uCUjxsnZ1QuHjqNkXI4diqnPFrVXG4+x9+Q22Ttwj24vaYXqQ+M+Zue5bv?=
 =?us-ascii?Q?KOgMwT+5k45C4csBsSZ8I9Rg7b0Flj1mwUGTSwPDZ3dx811oWFLrLX9nojJs?=
 =?us-ascii?Q?krnX9kM5iIKgBHvjsrfTgDVudglf1N9haYX1LFXXTkJqauvpErr3Oc1W+hEZ?=
 =?us-ascii?Q?bzIRUkEDDK9EHUSRmIQ+slX5u4fT/3iD+9cDgO5usyVFbaB1l5xtCJRv+EVp?=
 =?us-ascii?Q?VapvDh7zBwToPVxv9SLvpm2o//z6EJ3TyYiqXsMzdx29DvItZzdWV7/jysnd?=
 =?us-ascii?Q?Yux3+031qQKfmEZ0rGbWphHZpToqEkTrX9pXP4R4cRChfPfVXsNhAuyQUVLy?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af47d9f0-0263-47fe-cbf6-08db6b4a7065
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:39:26.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vEU854D1fyjeMSzCEzKniw2i7Fk0TVISibN35i/pol33cq0qzM4r4hjponq7VH/jKWoFxQbPVMJu0of+ZTL2lR9V13EamxYBZ5DMPdHwvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-Proofpoint-GUID: 4PXhA0iJm8SZH7HyQmy3Im7VH3cHg10n
X-Proofpoint-ORIG-GUID: 4PXhA0iJm8SZH7HyQmy3Im7VH3cHg10n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 52315434e0a9..6e2b7e97da17 100644
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

