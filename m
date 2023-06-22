Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7F739BF9
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjFVJGE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjFVJEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:04:20 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1449D5
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 01:58:06 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M6tRX1011762;
        Thu, 22 Jun 2023 01:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=mvSa6n+xjZIBMqATaM
        6GiNq5F/UfnOhfZIFFMZwr73E=; b=G4nDV9fOBWiIMm10HqxRS0AwRn/renCrX8
        S7TLYwqEhhSF2zAXrvgnGOaYDMiDZIE4tvvE+WgekJNPfrk9q80I7z/D5ME+JfFe
        PE1XVZTHg56Kc7tEACqdC3FpJ/4BaG2YsxrZNfiIO3Yx9tjh5XyLz3PkFZFldwHZ
        am+DZ5VGyC2j+ieZ+bvNuYD2j9hP+f0EQ0w08m/nsbUhVbvKAJMaGkuNxYenLPyo
        Qf0awkPCOpTT01GwhNKTyvrDWk7qvNbpeh18UzZWYFjhd+RRTkJQ37aLoZkl4Gwi
        jmjqlQsg4aqYvQaWQa6unFV0PWDr3Y34HluPBg5qjLIojmV0+a/A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rcdctg7qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 01:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAeHS51oQOWIUh9JOVlYbULjymItRxV6TV4tibphGchRhK4y0sbJWjNO01gNjfYAuPYHO+YkaS/CGHTE/L+n+gyvZILBG46kTrB4VWU9xiyU5nhfYgsT1TyAkyMYBoCd9F2pnkseSO+v5R+IPsn1IQGk5INj76IMvZvVdu0AuS2zTjMLwIMma4fBPl/CVRpJqrlKSUtIYBLNOJ4J6pWUmiBrNTTgVnNXv8gtrbrUIgk68dnpPBKa4Fxerbk/m8Jj0DkivdHEv7khlKz+cEGF7ltQFENfVEuZJrcBDmlHV5hI6shwVqnHU6DsCh4tgG7WIvHSmcyq+WTsfhZZj9v7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvSa6n+xjZIBMqATaM6GiNq5F/UfnOhfZIFFMZwr73E=;
 b=BA+5VsCpOPHsvQwQPC7JazwYEMzI7HPLaqUtgksbOxmKCJ6NeKCcxXbSz1zx7ieEygmVymkzA1GPW14aq4eFExMj1X/vQ5sTdQ4u6rcuDV4m1lItJfYzSoZH551fA0ffOHSSXaV9n6TsNn9HxrAg4CBaFGCrJd0w8r2XP7cDbsyNTPDoqL5VydYZFbElWkTapMWNqe4lioB9HCbYeDXb/eFFeQ5ZnZfz2yqUhAJX3RT3CliGgYNU5NqecL6ZzPrP3BUm+ai+D57cVXROTXUtPCEFGepKhGcDSbI7A8BVDeLHSkJerCe0LpbLK38cPsPLVZIIq1JfPClylVH0LOXrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 08:57:04 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 08:57:04 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 1/3] media: dvbdev: Fix memleak in dvb_register_device
Date:   Thu, 22 Jun 2023 11:56:43 +0300
Message-Id: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::41) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: b89fa94a-fba9-4a19-2b04-08db72fea66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzfRGyIbsEDG3NYK2rAfN1VymPIL7t3APA/csZMCclTtQlMsNVRiBgCnnxizlGRJ48WWixsOXHif6GHGUN5O8HSXyqUs47HanPkfVXuN7Ba7KXW87rEk3zu/cTq9MjiWwGurFR4sk9Rn/jr35+ALzlJBxF5ix0y6w6KmRbohQmYvOcjCoYpMOKjJ3mgBl6McR2Z9I566xDv6p0LktfiEQ3H2sfrrapgWrGUJwjO6Btb2U3Q4d+6HOYoZQD/G8fI/Yod3VTVcWRE96GArmDvGTHgJgN0pYw+1QdxJN2At/CSlCrXlWJ/WLoj4ousOJE0q4AddDkHkYFklG8WN56mCpIlgcohEg2dJCf4BiDS9IEa0p3QQAMIzYfVafZjo+yiiYy/IkJ4WeZMByW10ZavExMt/GhXJBrtlmE09qgtbTcIIfDBe5qCHjBucpV/Tp5jqv7VvTG2yiwrITlxSSzFKP3G1tECTe0IP11EMlVE3dXB2vxUACka5/v8O/7RwMQ1oac5WenJ/cbbSqzKvTHW9xqyL2Q7JxbdF+yKMLUEsdEdwUWK/V10OoamzBk/6pc4baz3eoPTtyRB9iGNUldE7E2lrdsoPEBwxH2Qvg066kh0uReFFFfy4daqkgWjYF4Us
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39850400004)(136003)(451199021)(6666004)(478600001)(107886003)(52116002)(5660300002)(6506007)(1076003)(6486002)(54906003)(66946007)(4326008)(8676002)(41300700001)(66556008)(66476007)(6916009)(8936002)(2906002)(36756003)(9686003)(26005)(6512007)(186003)(38100700002)(38350700002)(316002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXNCo2LYCYYAfvC7xhBpniYAHw9LiKlSwMEkcHI03J7GqycVPpFvBBJp6P3f?=
 =?us-ascii?Q?Cfsv0cRAoEf48cCIyTGS9VDBR2iw7idocLqTuux2M54gmKlUjCOPLVUtL3Th?=
 =?us-ascii?Q?paMYlKyrnN7CctvfOlaciT5d9Bya74G/j1np9Cwsi2WzqutRIXMZa2yVccqh?=
 =?us-ascii?Q?R8+KTi7/i09tIekzYxrmXzKtS3aqGOvsMOcNL81teC2fVBnyhxEDhxAcUWUR?=
 =?us-ascii?Q?Sl4PhK3IFPAby9CqGAxgjfD2zeXQYF2vc11c8SxYUc+feTWQWO7yMnte+36s?=
 =?us-ascii?Q?JHJbMSZLtwlvs2P+kJzuxlaBXrQpYi1JU9J8vj1T7HzaPhyrfBIxvnvz5ljS?=
 =?us-ascii?Q?Ycbuuj5Cp9xkEQZ2Um7cXaFK1oLvIsBSSf1gsAzb32lCBVUUfKo3yJvSjPh1?=
 =?us-ascii?Q?xdGXdSzh/j/4h2SV7yUl8slRixgM5NNYqOWaTfxPAMiUr5pqdp9hh0IIHGEP?=
 =?us-ascii?Q?L2hOJqtazwkM3HTDPG/0R4i8lMeqQQcKv0A2b5b6Yw7Rsk6yko44H6L3Z9Ki?=
 =?us-ascii?Q?vcWJQHAfccC7YuJjkj/8ZzuWBODM8Z6xb0+nR8XqwflgYgI+fMTww/pzA9rr?=
 =?us-ascii?Q?LxJ+35F5YR+IBQDrhNniqKbkn60lYeAV4M5UCbInKBDIeeZdnKK2Mc6JHqtb?=
 =?us-ascii?Q?x/l1MQhudVGo7IfunJsc2Pz7V4vqSz7mwfCgPyUMlRvTY3XA3TUbIpRryeiO?=
 =?us-ascii?Q?K0PPKjabvJ4Q182Rya6+Nq34q5wqHIKEBb12Z3TCoz3SiTdjTpggr1Wsu+cT?=
 =?us-ascii?Q?hM26vGj0GQ4P62lMoxz1PCnm2N14iSwcGslhEFgTMtNNfDT+rG24pm3GuhfZ?=
 =?us-ascii?Q?ct69oyX8rooZFIA2Hqzx0D4SxndcFWE7WfMooE7oORjqVaHAWq5x0wkq7LR7?=
 =?us-ascii?Q?gA3Tjqr/GfQKnFxFxjKg1s8bmx9RK7O21+8Rj/ByV2OIWmfH8+SDIG3dZ3fS?=
 =?us-ascii?Q?OcBHCNwYYrcYtKJ7UJVrnYjiNGpAWfXA0Iu3etxz/OpPTRdEcKgedl5CQXXx?=
 =?us-ascii?Q?Cw9HrNo169jxR/ugby26NdYrNUFZ4xr9/B2MOAs4mmYGvfhTlxxQpqQjyhKM?=
 =?us-ascii?Q?dk6BS7krL0GGwoMWeniBdsMnUlueLsC573tVr1z3gt4d6XIfswfAnU/kiPyn?=
 =?us-ascii?Q?lKh910MWnleWh4p4MnZoMtnrakQs3iVnBii36qnBvXPyGgmBEcA6Ad5DifkJ?=
 =?us-ascii?Q?IYEAauUU/zi63JYdilHQSW1g6FADowUVsNhSnRv0LoO5xJ5tp6YDvQejg1pH?=
 =?us-ascii?Q?bUn9FG+Tij5Zjeua/st6c5b4SlcC+A6+/WucTW+CChyqYzxil5nCgm1PCDXN?=
 =?us-ascii?Q?6UtcUl/YqnbanANUriLmiONRIiddRNai1mT/Bl949dcpIZiR1rxQm/IJQewI?=
 =?us-ascii?Q?70FBKEO7uxAg5HH1qH4N6PMLf+gHsGRLHCwZwTLN/CrX1cNtx92apQQrWUeP?=
 =?us-ascii?Q?jCpsbhIBBYgu4mClASGfkDXk9hk2zsAVJgMOJyr8TfxaVi3xc3LMaMVO9PgZ?=
 =?us-ascii?Q?DNm3Kqt5PQHXYOcgYXghm/qTUzWI+rFD7Zr0XYOwPvzDWH9tI7vpjummfYcU?=
 =?us-ascii?Q?MiLqpOc3EjIOzPQMZfTeNjuV1afRb7xz3jHlc49fQleFCEaQf4sXlAksEtPT?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89fa94a-fba9-4a19-2b04-08db72fea66c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:57:04.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCWOTDCFsTIjZwEKGC0bbEuX0s4V/1v+kkAL9Zi3qo8xEci5/A5c5jqT5sUb6JCepIoHbQZR+/MEz5jMrK7WWpFcAGy1VIC3/a9zBVPBmDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-Proofpoint-ORIG-GUID: heOVUHEvq11fgcX-9U5BWJMlY84Q9Hef
X-Proofpoint-GUID: heOVUHEvq11fgcX-9U5BWJMlY84Q9Hef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2305260000
 definitions=main-2306220074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

commit 167faadfcf9339088910e9e85a1b711fcbbef8e9 upstream.

When device_create() fails, dvbdev and dvbdevfops should
be freed just like when dvb_register_media_device() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 drivers/media/dvb-core/dvbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 454301149a8f..242fd8d160b9 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -545,6 +545,9 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		dvb_media_device_free(dvbdev);
+		kfree(dvbdevfops);
+		kfree(dvbdev);
 		return PTR_ERR(clsdev);
 	}
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
-- 
2.39.1

