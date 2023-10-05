Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632247BAB28
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjJET7y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjJET7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 15:59:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D0DE
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:59:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IaJ0d016048;
        Thu, 5 Oct 2023 19:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1DF/F46Y5EdNbqbXn8hu9PyvPIuFQvXY7lndVT/s0r8=;
 b=PBEtso77g7LQb+mVodGsTC7qN2PPxyO1+8Y7KzUawq4xNAi8rLQs7unPBZ/jfU3/fCbd
 jQeiS+EIdQYzayz4kS6E3h2llfVgsYJJhrQvEfVXIr/aAHJYhCeb0vAuxobooy4oduoX
 aY3izAlRsIo8j7jQ+c0CbtFLkhGMv+mRmur/sbKdJTJ7bDMY5Yo8bQLiIuoaZ+cuiRu7
 N7HeEI2TmKCiejogi+zguTbowR5Z3mK2aO4NugIPu1GKYukwDOhSsEyt25mzPWwutKcu
 FBUq6/d6ZqdacJwgWXk9Oqf4KwRecwaMg1s4rXLBgDodcz12voadSczdoCvEi/vzOOU0 Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcjha7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:59:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395I9Hpo000427;
        Thu, 5 Oct 2023 19:59:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49hc64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL67KmO2+crhvWbY701n/X+GvUIYslJxdsizumNp1hFVwY1lwIf9iBL0++KT8F/AGqvAGJKiqiub7ox+zS6jE8+aKgVB2EJ7u0xRHJ2B6wwripbWyS8EG8+/zFFvkbpGci9Tv+eya1aPK3rRgYmIjIT+pkDqd1bcl4qxiHgV3oCV04PBCjOwHbMI2qlr8tb5Wdm60Aeh6QxUoCB6u6RTxUx+WXIVvkgvpBQ/ITQIwNYdKd+nl2mQN7ZVeGcDNr5ELAybZ36Mb8fEH99NJYOLy9yUD1kHp2Y3+kiPM6ZYg7M/pEbwHIFeSCYcRSLBccvO1GYO47keiDIaiLOroinNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DF/F46Y5EdNbqbXn8hu9PyvPIuFQvXY7lndVT/s0r8=;
 b=mwPM2d94tr3ahKr+Rf7SYU774ZEe/poQErCTLVt02GXzZKbr/Dy7By51hUDxv87f7z5RLOsZz727XziurFOxUV/xtJ8wBtfyt32n8WUwWfwPCUNjDlCFSfbdaP7t30WrxHuGX3Cr8RL9Deq0zXSwNdh9EHfvKVq97+wlfenwJFeMEn5SX8IhL5LRMiBO2+hp90xNr7KNck3ddVKsFBPWxlbRK2/Ph26ffJBNg7y8tnmtvnU3XhzNNdjikSTNYtemfAhFRQemCKz9bMMHb98bOod1eOhhi5MvfxkKlyPTvA3VJzj2pBShd3chTzN8EbN+5wt6df20lKDxnog6MxgKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DF/F46Y5EdNbqbXn8hu9PyvPIuFQvXY7lndVT/s0r8=;
 b=Dm/J5N8sj4smIFxv4W26RBNGMWEzjOmtz9llm32n42d+ERdVGEKfBXCchHA8T8Dzp+YhHQPwsnIUcRPeJ4Jwz1MO2qR63KkYaYG0vLABxZFCXKVuSdxMteSr8eAr3K5S+Mmr/G0EoIJUCb3NGp4TsP16FHPOF71sNQWWs+4TRQc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 19:59:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:59:40 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5.y 1/3] maple_tree: add mas_is_active() to detect in-tree walks
Date:   Thu,  5 Oct 2023 15:58:58 -0400
Message-Id: <20231005195900.252077-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023100439-obtuse-unchain-b580@gregkh>
References: <2023100439-obtuse-unchain-b580@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: d20f08e5-2424-4062-7104-08dbc5dd9c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7guZztubOJMPjmXVIkMUnOwpAVk2YdFKGvguyP5GqeavjTI1vKsaCLXb8tFk+TbtNUrW/gxlAleSye86998R0eF1GU2tcrmSWlX6CoHsvk7MESYwwOR/B9H7Nblkc3YXrmF0tezWqma/w3l4joXSr3gtLemGI5HKb7Q76CBSsDPNT0rXz5jKUhjpmWjVOchPeMo93Pjm24B9Fq5maUx8Py6ZWxJr0+yVdjbgYKmTTQHbv5Lk+4AT7xdiFZ525aVlgcFWbdl//EsIG9JAoZiROJUKV3H753WqZDvM4oxKPbXWIJEmT+I3tC/U/ddfqkm0wGZ+cVhFYgLXIqQavwmSEHnywEQphTHwQ5kWLpV7/mUledquckymSQkA6IjebzSuP8I3ViX/FkAKxnnNNnzdV+3za6pa6WKbEP+3uvA/F5GuvB4hl0v868OelHmlrOFZAgtIezejQGIB6qycNZU+zqgt9t0M5ko7lXdEkSmvIhANN1Yeha427GEpuo03xNZSSaW1SWDZEhOk/wYGz3f0n46K1iJtFGnlFcJgxo4jCMvSqPCjSFhUFBohjo1M9HkNcLvpuaO/1YMnM9XZ9HzTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(66946007)(6916009)(316002)(66556008)(66476007)(54906003)(36756003)(6666004)(6506007)(2616005)(1076003)(6512007)(83380400001)(86362001)(6486002)(478600001)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrPf6hbi5rsVtgzWpSBEx0W8Z806ri/a7Xfc5m+79jtFy1Sj+WnSTm1CWoHv?=
 =?us-ascii?Q?X/uGd0TTGnOhMKnuDwYXAn/LZN0RcAZLGypM+2QvC5rY6KRkXmHnTQkkX0CL?=
 =?us-ascii?Q?zM39HDHY471NAlCJOE6tvPFKfbLxhv3OVhjoAWk/Q/7Uqwpr6rJsE15HMqL2?=
 =?us-ascii?Q?BWJM/LsgfBO+wHaXKVUwHGtUVhhgIt4ow/wQFJw8H5nroaOh8bnkHWEi7xPA?=
 =?us-ascii?Q?g4YQ8hX0TyNHLtD0NgexJgyAhp4HqG90yGLik5IMxQEsi/nks7bvVxsZD4De?=
 =?us-ascii?Q?uy7UmRqYOHHEAI4YyzJQ/mR5fNSCOYlFzQ4SQR7NP2PgBkbpCEpyLlWKVKff?=
 =?us-ascii?Q?cyCI7ODFtxJv3y6G0a6WeigBgJLu31+vGWlCCKM+6iBcgr/XAANEHEiUn85U?=
 =?us-ascii?Q?HHSKtjqao4oEngv8c+uwyyUIa2bwItwkPO/FdlcYpdLKd8y6pXAUZNmQci88?=
 =?us-ascii?Q?A2e505aCRQ+UlRytMdeNxkK2vwB8SF1yixKA/eWanHEvXF1X1FdQGkwsvvXb?=
 =?us-ascii?Q?xxPdkYBb5um9gIjr1g/jcQnoNUDtZkeWswmRr9ASS3cXfl2qgSldFW+6rXLK?=
 =?us-ascii?Q?8Wo6nBSPKPxSKHyS6UP5V1WU0MOXDfbIndlY5Bx9j7CqlIi4vo3D6KnORdjU?=
 =?us-ascii?Q?LiI8X/TZ9DurAyK/CbulYkhgQtyDPLaQ7x4S9BkVV4eC4SmM+JfTO6iMNrMw?=
 =?us-ascii?Q?7lZJbuptf4gsM5JFAfDR5POpG1qDOXDnotBMxhs9AGuOytXZkONQf9Q2qKAs?=
 =?us-ascii?Q?g7CdWv/LxbDPIIG65NFX+BidRHDG0NxBZcHaOsMJt/+w5PpDYErCic3KnIwZ?=
 =?us-ascii?Q?kQ2wILnxZ9ge1B/3prF8DgGf/YFhQzDN08Xw+HXri+sHLWkdndQSLZwQbxzO?=
 =?us-ascii?Q?JJ8FUmhvIFOdXiackgLspp0MdrpVWOry1W1317I3HAxTXDLcWv//Ago2vXni?=
 =?us-ascii?Q?dy5LX8eINiYS1KvGvtdUPu/YNaPuZt4RLU4uD/DCK2/DG0mlZJBruECXvFnw?=
 =?us-ascii?Q?o9Gz0cE4ixFGzEzAKYgSSIBqmG6zugUUHt4jajnlyB0lwY4xKmOZ3rkIczhH?=
 =?us-ascii?Q?3WYHGpCtg7mHtjo3m6rQFi/rIOUpjiumAZuQqlJ/Gh2N/mYOvFywXXdi+T6C?=
 =?us-ascii?Q?B0PORVyISRUm+KQ+EZRWp8VJxIJIRVjSFN2JgIjB+IRe5TfzeOLqLcPoyLMR?=
 =?us-ascii?Q?IrD6kzTfLPlv0A9DxvQw36X8UVoNkHG8MVsz4Fw83jByWtI0Kn4l/nArdpty?=
 =?us-ascii?Q?C9sOnYBlS62+DY88+02U9B6h1GHYTkbBwpXtH+mmhuOgBsoDA42bEohov6fF?=
 =?us-ascii?Q?JvqHu8K2gtpZ02wncGqaXTZoFoqoWI8iunZsPQzTm3827T8IbjjxM58DxIQO?=
 =?us-ascii?Q?2ucOmPMcuX6VgZ3GwI8EGqJOsmMkYITOoefAyjG7/fiqBJ+8w4i57XLCP09w?=
 =?us-ascii?Q?DIf+UwaNXh/DX+2Gjc5X2ob9rofQQCb9mIQHtLwX3vbZiy8kCNIXKXcnFzh1?=
 =?us-ascii?Q?uIhndLv2vie3ub43ZvNfLO4Y5LIwD+tZpi4PZCe784BumvIvOjkZYWaoQNmr?=
 =?us-ascii?Q?CqG6qljWIh2+qm/7uOFVWboEqy8AeAdJiEjVQBvWHz0lLEjL3cjPVmDBskm+?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WDfnr6fXT/pJvfeeLVg/dd53hgpTnf9vMZGW/295/j2I0XlFBpN8VHKP2bJD3ENOYgXOb6Mz4+Go1EQ9T7ypb7w1zs93tjVdMw79Jp1wiCga7Ek2pyeULwmg0hxpdVIJ2CFwcDUqoEYuBY6Ki2q9xhGnkTF1/pEKm2HuMFnFwqzJ4h6876x2Jo2ueeEeqXh7EbDUoKxKmYpssRvH1iQP1vAjfa+EElkEl18HrNu47He6iI6o+N92FFeIsr+RyGvdCw2eCNj1kzqbovaYBvOLBk0+LeSo0fD2GL1z4hZ8UmplHdmqY14e0Vag7OeFUQ3dXL9s9ue3IFZ4yoOtnpgIkufBl6hyYju1qFylRvgxZZdWnMs82b3ua3WWw8FFoC5V2NgSrbq1LHVaDyqyxtHOZZNKDqHC/UpsSGz9MC7IML0XOp5vNEC765gUWtaZRXshJPOuqCWGHTgOhDGoVtdaDplt+3KzYRbVIm56GrQUji+HNQo/vEQ9CLv+abxo06ZosHcdvhNRLAy82NtleWo2vHALa8QgcJsGRagvQooNxcgPw7dFwI7SHxBDdnYmIFeuVVGJjZ34JPWQhvmUSkmv9c5lAZjz8JbuOXG1fKBBeOZluXXePjfARXXuLzEYOMmTW/WSGskhjop1XSAX2Rp2i3AtEqjQ+ljYt0I9jUW9gahL3ljtN3GdpEaj99fUtUYJHjXETrLEwquXxqLSPtFxFfGEJcIWkIkwXlT4L/eWPE1Gvnfp7omJWcv6jSADxnJ68QJxMBC1CCcMoBn7gRoj83mivMBksyNWZTR/iSwyBoTxGnjIvxYUqCnW3JIBmMkhNHBhGVqVtdlL/dVjJFG0Og==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20f08e5-2424-4062-7104-08dbc5dd9c47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:59:40.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyhC3Ze3/fzRhbocXD3SBupVQ3AXutvHl3CvhOwjQtwxQ60xFRXmeHXm8lQEDfLvh4+r5Qn+R6eLbaPyQsnO7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_15,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050152
X-Proofpoint-GUID: IdDLH2dkspW5wPVMJcDYoIlngcZMwmeY
X-Proofpoint-ORIG-GUID: IdDLH2dkspW5wPVMJcDYoIlngcZMwmeY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Patch series "maple_tree: Fix mas_prev() state regression".

Pedro Falcato retported an mprotect regression [1] which was bisected back
to the iterator changes for maple tree.  Root cause analysis showed the
mas_prev() running off the end of the VMA space (previous from 0) followed
by mas_find(), would skip the first value.

This patchset introduces maple state underflow/overflow so the sequence of
calls on the maple state will return what the user expects.

Users who encounter this bug may see mprotect(), userfaultfd_register(),
and mlock() fail on VMAs mapped with address 0.

This patch (of 2):

Instead of constantly checking each possibility of the maple state,
create a fast path that will skip over checking unlikely states.

Link: https://lkml.kernel.org/r/20230921181236.509072-1-Liam.Howlett@oracle.com
Link: https://lkml.kernel.org/r/20230921181236.509072-2-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5c590804b6b0ff933ed4e5cee5d76de3a5048d9f)
---
 include/linux/maple_tree.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 295548cca8b3..e1e5f38384b2 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -503,6 +503,15 @@ static inline bool mas_is_paused(const struct ma_state *mas)
 	return mas->node == MAS_PAUSE;
 }
 
+/* Check if the mas is pointing to a node or not */
+static inline bool mas_is_active(struct ma_state *mas)
+{
+	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
+		return true;
+
+	return false;
+}
+
 /**
  * mas_reset() - Reset a Maple Tree operation state.
  * @mas: Maple Tree operation state.
-- 
2.40.1

