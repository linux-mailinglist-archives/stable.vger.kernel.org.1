Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260FD7BAB2D
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 22:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJEUAK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJEUAI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 16:00:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B77111
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 13:00:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395ILkUV030006;
        Thu, 5 Oct 2023 19:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=stas0xhvQDUQoDjBd3lMw8g+4RHjetJC8L8xEteM/FA=;
 b=PEO/6VvVz1xnVWKFo2IpTIflBm0koZgH+cw/dhpjqS3+6mFWzNjQz298IZzA0uPu+pO0
 cOnuhtyevAUTZxINB97rzRXEdAxvdj15YOLwU31cBhcoi9nLOtBE43FqGHzi9L7F8lfo
 9iWKHqBBBzCABT99rIDFThljia/c1oqmeAWC1kRNXeWo8GPuaaSn5DVGAOC61d1le/OW
 hSpvUnsrBMYqidHmShDTBwKkBlUDt9jS/efzNeMYxgxr3BD5DE3uZE6komOcd8qXUAWr
 hKyGsE/aktZECR49ZFrFn6ML+gXE6271H6RIgKQzlZ3iOtYAzPMcmUBTKqQn5H2ZkIFk /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ujh1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:59:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395IFxtW033645;
        Thu, 5 Oct 2023 19:59:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49t0g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ1JsCRZs7wQMeye78n31PZkxItqwFFjt/LGqJi9UXmxE378zY1llzpJ1UyZUWP5m3rLakCuLMbN3qY/0uNPTgu7wXiWTBNb8El/sxzDCmZ7Uz60THE9w0L1YamNswO53Y8ggABVJl1ODYrZh/txlh2f2yOMAo/3dthw0wWclBcAySD0eILUdWbDwuOlwoNd22DzZlb5WyF44AGo+q12Or4J1WPrpiXLuAUHTMB2q99Do6pI7X0zFRQomIHLaPvDfaq8hkQeI5d6833mxpNTWD/kLFAz57sgd48TTvUT4niKveVdzfeo8938rNKRveFBLQ+d7S9sfN0E+mAz4xh0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stas0xhvQDUQoDjBd3lMw8g+4RHjetJC8L8xEteM/FA=;
 b=KlGK4g1x/SC9TooPGDT+/BwaqJFVb9jAsJ2fnuNLBCXxtDBnPmHwCcltR/1kS57/UHXWNCt28dmDuUi0hjhbrH90lHipJ+ctewELHJ501mlOvO7IuU6F74u/IItC7AtUF9cDHS0noPkP+kDH6sjt9nkBGoXrEu7fhBDZKj7Me0I93LA6o3S4/Jwxb7qY5p2O9NGiZTWeQER1y0aUfi4z6VAPRl6QmPIOYR8j0DPHhfO7OLYueF6yN35UM/eGmL21KT/THxdUnrV7RcIcfxGDFxPTlP+5yeFw8BaRXyHYexubsB3YcAzl23LfJXNvyO3om4787+Y+IVBbKqzkCNbaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stas0xhvQDUQoDjBd3lMw8g+4RHjetJC8L8xEteM/FA=;
 b=Ye1mi//rgTpbFBE+gWvhpHRpyQPuLjvD9xBggE2B37g7Ai4l2yA4c850HjTmBolyoYFYQ7SjKqQEtvO5syoEv2B5SUXU7eh6QZAw20mTFJ/mDhYIVye7DMN8BvkPPm7GbZ8DmZqpF8AVbnP6D5u53dtX5cEWWm1BaPV7m9gyfqI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 19:59:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:59:43 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5.y 2/3] maple_tree: reduce resets during store setup
Date:   Thu,  5 Oct 2023 15:58:59 -0400
Message-Id: <20231005195900.252077-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195900.252077-1-Liam.Howlett@oracle.com>
References: <2023100439-obtuse-unchain-b580@gregkh>
 <20231005195900.252077-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: bb506922-2013-4d4c-5389-08dbc5dd9e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwBBzxuMN2m+jir/gx17cioMmgHB4WHI6jFXoUijRByFJ4SC9YMrdJANumSc8boZzXKUPVVJECF+AOgZSfXAxkuuBCMWkEu5Uo/I4AXTzlKiC90RajQ3bMIOj43dmiaHpWCEg/G4bvik/tsMKLIjmO35KbH3MlP9Ek61rz9Wv1iZ6ArDIKTVbV/M+yaax9xvREeTbE8dyhLC1llod3r1WSSHOsDfRoX3hsST0wsIQC1TGzWaVHXAMQUnTArjE9o/xRT8od+f+hf8kyaYiD6CEUT5lNUFYYY1q4+G7ZCFq5qwdoT9czLzalfpnB7Lavzorn8hh7Ch6ohrTJuBT5sH4suck+eOx8g6gRZG5ZUY7nOQkk9eoi0Pk1S/lhG+T970M4UIA8gaoBxKv69V/SDDQxwXToaL8dpGPKoJFEl6dKDZokdptHs5EO9rIwbyv0gctZd7Wpd4PVxKG/4Aq1bi5kyuyeKCJGuqwez7uoPzjAdztYXpxD/URIoofDxj0xuJBRSaSa6s7ZFcsWXUnOg0bQeH0EL5YhOCNf2HH+g6BpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(66946007)(6916009)(316002)(66556008)(66476007)(54906003)(36756003)(6666004)(6506007)(2616005)(1076003)(6512007)(83380400001)(86362001)(6486002)(478600001)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wyc+CQtyclBT0PADpcZ+xZxjlERWLN2xSqobIIa+PK5OoGnjM3yKNC1ERUlA?=
 =?us-ascii?Q?KjCV/7bFu9utMNlCd85gOrljEHB75hQxNHn0KWSRA31izO6RIg15EydKhPyP?=
 =?us-ascii?Q?Hk4gwmZF6/pc0Nfs4K87KO9/k/b5r8ACi3cjDqBUX1MRfqxTAouPo8w5xzLD?=
 =?us-ascii?Q?fsBMxbzf+uyGYXRF1N0T3KMfszdM0pCFbIEuQRJlw5CYQGZTz5ePejXXKTyn?=
 =?us-ascii?Q?4QFjfdZU6c77gPptCQaYisZgXy+XLHdb3zQ7TsbFIfOfbfmnJK79S4+m8EpU?=
 =?us-ascii?Q?P8KmbEQba6oKoxE2rd33XvLmDO4FYr8Hwilcn19E+EqV61BO1WiAFxFOEyzh?=
 =?us-ascii?Q?Ij3WyfCqoKb8Ndsi3IvQ6YrYabkOGEN7rXlP5O//ws6pSLTuFvbj0yZOiPzN?=
 =?us-ascii?Q?dwS2wJ5PO0ZlkpUAmf3O+PuPgRrCQ5B/1VTASw4BTSoJNpu4IvtoWlsAZ3Ks?=
 =?us-ascii?Q?dN7CLe/gejJBilCVg5ZPZOOu5I6oTr60IEXhuBtz0d1RtiA9pd204cEGmC2+?=
 =?us-ascii?Q?anU9QGp7oRrQycDKPxd5kzRijO2I7utdxDyBtZHqBNn40zuYsDkdhzgXSzU5?=
 =?us-ascii?Q?T7oIkqNAHdlSOtlXjueIe0XtTLDDwCmkukZydhTO1k+Rker+fR4GI2qYL+4M?=
 =?us-ascii?Q?LgUY2FGvROi9sdowbjqwu5BYlSBm+5U0sOE39mfA9LlTb3IWtA7dgoH3B1X4?=
 =?us-ascii?Q?3B3JoV7ZRawYHUS5nreFUhsfcive0tgqgk69kVlyf9R1pPUsf9cPtgkgyZ9N?=
 =?us-ascii?Q?3c73bYbTPyRLFdYXm5e5TVM94NSG+PvqNBqPA1n6uSZT2JlxVUedqrkZhOix?=
 =?us-ascii?Q?w1yrl1zyxjn3PbRT6q0sczOgpZ2ESW27snYAuz5hu4RbEZ1UxaOTDGB4fGMp?=
 =?us-ascii?Q?gwm5XEyyZXJG5sLiqnovFn0WqH3Cq1EvzoCvkpgpVY5XFXqBLet1zo4Zqgz2?=
 =?us-ascii?Q?i0zZSmN78+k2t2+VFGuIOL+0zUimfutaWWWVmQmvBOA7d7woSvyF5/bHGOlw?=
 =?us-ascii?Q?j1AJDO9yQpniIVTZ6iwccW7pg15+oSRtHECiLYpWrrJgJsRK9VArO+ahNd6O?=
 =?us-ascii?Q?LmQzYgfQnccmdYg6TR8YXdQN9zP2tM0zU6SgxuPVCb+7unFCC6CeKGBQq571?=
 =?us-ascii?Q?dTdz25blgDcDl/BmJuGaP+yzYLVLEm3vR8WwB6HYnZ67ZiGcp85+/6IzY7zS?=
 =?us-ascii?Q?sLE37oXm6lFlVlPfBGgzzoPnc1OG1M6ZAUs0RX3j1uswLd+/Q7oJXYIErHqJ?=
 =?us-ascii?Q?QPkoJoLhqY/WeSCsaavbqYXJuZTf3cruPLEY8n5ro6IOHDImvOvkyhDxm5bg?=
 =?us-ascii?Q?YRd2EFr7nrz3XU4njlo8JhBw8Wr1n7rf+d4YHigi0hIcAbD5ih58qlZdX646?=
 =?us-ascii?Q?9YActx4sPLtIFlRuaN0GCxx+qJzgjG7yYWK33JLm+sbCpJH+KorH1ucoH3Yk?=
 =?us-ascii?Q?R9jiPEy0oLdLiIzbwVkf/pO1sT0+m0LlpkXiDeT9sKTbnXx3sDeieGbNYDXf?=
 =?us-ascii?Q?gAWeYhzVSaB9TT/eQ9Z+XnhhWgZBrKoQ4lO3IdAVHDkwFSBzURbMhkUxbhwU?=
 =?us-ascii?Q?IL+O+HfkRhcH7bIN+NG4h42RrIh3AVAH3Vd3qOP51Ie21i6mu8ZwlPm493pF?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0rbRQdhc5hMxpUrHwPj7LFZSQsY8wjBB7nSjlVsRJfIsK6/u8L83hSSOn3ib7Iv5nmjqFOsA/W6Q7M6QVaU1+E1Obypg2x6zBX5cW023Vimn3vtSJG+f/LojxovmIVkxH0dhuM67W53tlORkpA/572yKq/+abkLv4jscGDFS0Q6+9mlGSgDmu6wT6192l3F6Ux6Sg6UmToyhL5DoHa7He18r0AVuaT7pXbxwBuU4U8CiALWz/OVbTvhlosVJe0XtF0GaNi6JPEUlrhFb/3iL1xcxEdNC+l8optHFaQNVB0t9Q5RVDmfmadIatXMgE6Kwq/UdtKzRdhPj3eDxNtaG0F/veEJXH6ZIBYhd3g8Esx46Ohg+kAJTOZm32MFc+tNwYdQ0Yuwu1XWf9/2z7CZcdpL8UPbVsimDWPAElTdt6xqPtU3o62kWcZMZac/jLs2FvOvTNv1DigKyng3h2AW5YvZjqx9Y9ujoQZVrPFhb+eLV17Q9z5w6cRuvO4UF7+99S5r7wlmDOd/OlPF86ltJF4NtiCfNrIasl98Aqf3UuM/iwKgyJzkdN4HW/u5u1SBguC7ByUTrEShx83Ifk+7vEaR59iCRfRUtzIup9wyHu8lZEefsjBy9j7hetB5xoJww1dE4fbmCfU/UxcGQE0Fm73tqEcGPQOfiN8By9D4weQVvoMyU4TaZEGO4+h145JxqYk0zl2vjkTz7ydTrZ0llCr9gr2og5V7oXH67KYecSdyf4k9xySuP930scdDBUhkYl7MGcDp1eN31FfnHxvRzHuvFKnHN1QptaHZEqQ8QfIPdYE6BJ3KlTLfSeX/OKunyla6l2LmEZiWhIvg1ropIIcsP9m/fiEXraN3in8lk1mTMuo3Va31dgN2LrMlBLg6V
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb506922-2013-4d4c-5389-08dbc5dd9e18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:59:43.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR+VBlAFduevTRaMpcXIZ7lDJkqTmHPsPMqv4gyFvgKsW6Egd4r7VOPgkEi6LvO5vYm4Vp8rfzm1DtoGkD+Siw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_15,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050152
X-Proofpoint-ORIG-GUID: 1_G7QFRuIuK0RuVtHLTIBJf4Lcm-E3Fp
X-Proofpoint-GUID: 1_G7QFRuIuK0RuVtHLTIBJf4Lcm-E3Fp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

mas_prealloc() may walk partially down the tree before finding that a
split or spanning store is needed.  When the write occurs, relax the
logic on resetting the walk so that partial walks will not restart, but
walks that have gone too far (a store that affects beyond the current
node) should be restarted.

Link: https://lkml.kernel.org/r/20230724183157.3939892-15-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fec29364348fec535c55708b1f4025b321aba572)
---
 lib/maple_tree.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f723024e1426..86e06ec6ec35 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5439,19 +5439,34 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
+	if (mas_is_start(wr_mas->mas))
+		return;
+
 	if (unlikely(mas_is_paused(wr_mas->mas)))
-		mas_reset(wr_mas->mas);
+		goto reset;
 
-	if (!mas_is_start(wr_mas->mas)) {
-		if (mas_is_none(wr_mas->mas)) {
-			mas_reset(wr_mas->mas);
-		} else {
-			wr_mas->r_max = wr_mas->mas->max;
-			wr_mas->type = mte_node_type(wr_mas->mas->node);
-			if (mas_is_span_wr(wr_mas))
-				mas_reset(wr_mas->mas);
-		}
-	}
+	if (unlikely(mas_is_none(wr_mas->mas)))
+		goto reset;
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
 }
 
 /* Interface */
-- 
2.40.1

