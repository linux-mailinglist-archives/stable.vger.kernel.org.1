Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5CC7DE3A2
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbjKAOmG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbjKAOmF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 10:42:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37C83
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 07:42:01 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1AnwkW027734;
        Wed, 1 Nov 2023 14:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WQq4ejQ2rVIzdhV/0dqEIR62F4BFSLQ4AIVr6CsIC9I=;
 b=Ww9aklX1saAYXADI4mNXXfruIg5DJc9ob8vtgxaVkzxdW+GvWyfTN5RjUvjhZFTkeGz7
 RBB9u/RvzRV80kEcxssWWYRCaxFSkDI+e74N6qr/ykBPvnfQNC8jAZm5AWsQtHeKfsX7
 Jxb9gmF/BdCmiVM4pMDNU7fgmfZ4W5hkgv/YNW3ENdRr1qJwVDq+QLNqzHT2W4pdbdk/
 XsTOgetgrDIWmeGKVrG/xBipw7olt3rr3Ch2IL0vk8069qsZhfZzNdKrbeIeA6hipYtU
 GCYTkEyIKM9VuVgNIBb0ERufqKURCxPuB/K+2Yy8bo1kf8C8sxDbHDdixPzY6Xgno1r+ og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7byjqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:41:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1EAsBJ038146;
        Wed, 1 Nov 2023 14:41:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrdc5pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:41:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVpI2lolNQTp5yfBvhM7k2L7P2tZzWn2uCdYLYaHByzzQHlBoRTYpej0NLPtvmXjnod9igtxNlN3ZBG8rWDYWdnrgwPOb56NlLZufoMuuBAIlKjsFs/uKGs3DG06Tx9oD/skceC5ZSwQhW/SxaHg35kxEucfBse23Z6aIqGtPPzaWrwz5vfO99HdpQWyCVDaTBMe1rMNqBS/Wswa70sxKwhxCxIPmikte2dQST9sSdkIAj8KWD7km54RR1D0zAawXcBjM53u6sp4+H0//y0XxC3u/uIzSYHImeh4egaeNF1hpuVlDMt4/MsNQOxbUQXoYkOqXTcj+yNEyDffIFB4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQq4ejQ2rVIzdhV/0dqEIR62F4BFSLQ4AIVr6CsIC9I=;
 b=Ak6Am24A3RMRQkGh0sKaWXGdTTOJ5ITtUuldaU9fVpi6+AT8ioIFFDVM2A/SvPNyXMhwxpd3Z79oZnxAR+I8Tpglaj1Us8SiwXxqumncX9eVn0mRmK5ZT1EeA+z1lyUAxHq6ZuImwMC2xlQ1Exv0vETTGJL5b+efoM6Xs+s0uft2f90u8/R/dpAMcoS7vVkaIkXH9Fg7Q+0bac8vzca0X3xXruXBZo7Bp7g4H/8oJ8FWqtYaAvO7WFXa/InuFl6KpaVkOhGQqaeMrhYbpTlo4kX3ADFo41Yg7N6aieqhBgzPy42G3/Ro7OMr8Hc7D/rTX3Xb1vVM7aiiBHtyB6gsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQq4ejQ2rVIzdhV/0dqEIR62F4BFSLQ4AIVr6CsIC9I=;
 b=OvlrhM8EBZAnALS3C9fmbMGHHoMKDxE5H08VMLJT3Ei0Hv5tzxl6JpnXqSB7X+vlpV58ldNbunpbsZuwTVc0eOpQbbIRl3FAK4QsAS98cfrrx74n8zUrNm8uwhpHkwdZDxLOMQf3BHJJYusBn1C0dyOmSFdPJesxEoJemFY9OuY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6529.namprd10.prod.outlook.com (2603:10b6:510:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 14:41:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 14:41:46 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5.y] mmap: fix error paths with dup_anon_vma()
Date:   Wed,  1 Nov 2023 10:41:38 -0400
Message-Id: <20231101144138.3513378-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102742-carnation-spinach-79d8@gregkh>
References: <2023102742-carnation-spinach-79d8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a59315-baf6-4d45-8001-08dbdae8ac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ9CeE6Dn6RHgUEpAsPvZJutddKpp56aIO2JwxZuOw28bFsFlhR8sQ/wFDXu2ikBuZ1mdDkQlvwoRx5ZU/Apc+Rg60UIltCdMTzfH7sBHQ5qg1JRwymSEqOf9Qe03XpHZtsHFCn5csw8hGpxW67iLYBzE98b4yC2Bqz7VaKkq2/nXk3FQMwdv2Rb8jxzXi0pxa9SuyoXO9UUygb7ingAGfyTe00xPKoy27VViXYlKS93dVKrMC45FXUOvkwFKFHor3jwsSo/WgdwxwqdHq2RhhPsGIkjChGzChB3/IGfNvFRRtsfZf7E0x6DhQHkD8GEwMOqu7cb/KdUcap/S1riKxGVYVO6wW9cXmOf2DN7ucGrTPcgQudB760O8js64/FOgcSuoUnSfOU1Je/e0nNEeF0Q1vpVKpOMOLrKmXHNrA1HQuBXKVtKUAyu32KUTZqWjSf7vsRM85HG0eCJ+mzayEDZUJ6j8FzEzi13EqtSP6K56QKwFWCid0Bz5qNIpZSSP+s/38ibeLExt3jCHHJoiljSH5k2GCmFWC1gKwnYe3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(478600001)(6506007)(36756003)(6512007)(38100700002)(66946007)(66556008)(5660300002)(966005)(6486002)(4326008)(8936002)(8676002)(6666004)(86362001)(2616005)(6916009)(316002)(54906003)(26005)(83380400001)(66476007)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RSB0zslS22ysW5h6Ot3O49zyvCApl91QuEAZ6dlNKhplW+vxLhQWXWmoOE7?=
 =?us-ascii?Q?djIC6pzTJ8WKZrkKKChy2Q9L0A95wAwTgSWkVaHPIILF9pxvoWXdPnMKEroT?=
 =?us-ascii?Q?3K/AMLH2RI9z3g+Lus15SKOWwi3jcRkpnqlIzanRh33PzY4x/8TXJizyNjz/?=
 =?us-ascii?Q?Jf4xoB6BH8f8jVGKkRrcgDjVayk3U/HJXJjmnRryqnbSGoDOwngBstWgmBs/?=
 =?us-ascii?Q?RYkqHRFmObtb228/DymfpOtuhagpFMWUoN+cW4OlHMy2lwTj2XqW1+Bi/6HA?=
 =?us-ascii?Q?Ow65BtcgJ/hFqwP4ZJDxeHebiKtyb/S2FVOmNGmMvoebgaT6AbmmRnyvBuIi?=
 =?us-ascii?Q?zdCs0Fk+ZleA3kVwKkEy7IddRI0715uGEcHm6pCvhwKDXbT+4l2V7GxAqsyU?=
 =?us-ascii?Q?eh1vioESRW5GjPW0v/RR82gpJRDolUPQuQB8MkNeAA19jVoJKVgVJ2Ym76H9?=
 =?us-ascii?Q?e0qxFcr0uAO+cDh5YrjMdJd43uwN/2HV7uvwUJ96PFthpdSkI1SVT7jX+GoO?=
 =?us-ascii?Q?PYkRI5dZ1U/unvz+BHYyl+ifVkTVQiRDWzTYiRBD7fvF2ER5jJr2nr1+nGv5?=
 =?us-ascii?Q?RJAv7oBQPHU+SwovfY/BPZoM1wdGIHlu9BukJM7DSE3wALzhxTjHwbPlpDNK?=
 =?us-ascii?Q?5Dl0ptvXEatUmIj0N79tlO9gxhVsclia6e4yuN5NKlyQ5Li5JHlJ1nDRHg8O?=
 =?us-ascii?Q?sT5zZVAEJL2aO+ScUiN2cwfUoFNS056CTt3kkQieOgG93npNOTcqaU2iqeBs?=
 =?us-ascii?Q?b7i4tPj10tgIGGMwgQMAqnfG3i5bGxjpSZrvLYO3WkXy554cOShZGth9fc6G?=
 =?us-ascii?Q?3ho9QczPB3OYv/qKHy3c+o291Z0h5tEHjZOxhoI7gCZhHnv8+2C6JvYorqci?=
 =?us-ascii?Q?lyQk0RTZIItpaJYNzDtL+ECDA78JoyMPYOc8/LiSAIZ8IRPmTDDcsHiquLJX?=
 =?us-ascii?Q?QbKGLrE8Ly/1dKzM+ucOvUn4PQ/LMJ3iAps3Fp2PAywhI02Gu3Kcsamnd2O3?=
 =?us-ascii?Q?eZVVKvoUWLJvrBhMu0KbNcIZgx3xMNGjCWMcWxgZ9150aSZOhezi7DKFMxXi?=
 =?us-ascii?Q?yLBjxtValD35Dd6dJf5PXx/R5+ru1kfx0+FBvuTIVYost71fbBRuivrCYZA5?=
 =?us-ascii?Q?dwLzqmUsy1fw8rgsLLbIZkzBKBwIb7rCQVZF9Sj46z45r/3F8R57fRZNGWFJ?=
 =?us-ascii?Q?LEBj2BJUWHDJ3Rr6AMpJXR8gBRr11Kh5Q7lqQ8yzzMEN71t3EoAHbrrz2aRR?=
 =?us-ascii?Q?FJP/2KuxE9mEl6p9OqoWiDtxZg3btrBiaBuFKJIEXDB8oxHuoXSv9UZdrJhP?=
 =?us-ascii?Q?kfn7+4EkF07MK36TwFub3C42nZsDUqFKSPoDQF0JinrHAvMi3FyEmE0mQPTJ?=
 =?us-ascii?Q?CCsfgAX1b6D5uvQ5R6bWO02z3OrIrhky3rniFjvO6bhcwyPnNL83AQgSIxvE?=
 =?us-ascii?Q?95bQohCRHjH/P+bpBiRN6MKVf6EP7s+7re7sv6Jd4h5HvXJzKdQOpzr5zV9w?=
 =?us-ascii?Q?UEXBRLbN95JBUNrPJdV2XOejJq4z3Whm2rc5Qkgznqd/giFiHakm3vEVeyNL?=
 =?us-ascii?Q?9xb3fji8kruaOFwrHxtUKpdhsGwcV81mWH+zCYyo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JnXixk14/Ap8Owi2ZVlfTlMESU+DY+6v1TFcqOUbD2aZXZjwshKTjZujwSHy?=
 =?us-ascii?Q?9sUosW9YqbwOcoLznTuZN+JRDRYchCfsAHWGnjPnmvWr7bFkuqlGb3EV1wtg?=
 =?us-ascii?Q?FXFAo3viZJazBulc4a3qU4wYcksW6vLmU19ES/h1UA4C0SudI1DvBBBizS8y?=
 =?us-ascii?Q?kfyfF6639Z+8MVAvAbWhywnL3sD5HWvSZ5wPhNyXo/DV2GAz66YCUnNhOpLD?=
 =?us-ascii?Q?c4y8lcFazw9R2CtjHGubh5ie9N1K2tl6+atvbdq69kxYMU4KcBx1oR63qykr?=
 =?us-ascii?Q?1CHYsChvBDAyZo5HMFV5RGTE8yQTcDL7VfPNx8m8MVf3cEo9KaDCPwQcRdtZ?=
 =?us-ascii?Q?/X/ETejC7WnB+mGeKL/GGZoEw7YejPl13YT1j/N0qQkIA2WJ3uUQrMn0IWOI?=
 =?us-ascii?Q?nfV2R9cZCF2m9e3Rj+/gUguDy2LwMavUW8Vyzp7N2FfY9IHzUn/96B83b40a?=
 =?us-ascii?Q?/OHYREgLqUUaqvQKjE4uA02O8iVxndS40g5B+bjmKxW9a5/5WZSo+ZDm+b8Y?=
 =?us-ascii?Q?jswarrUCsTaSXbE1i7vSEPy/iCsgeft6c4BJ2wXe42qV2TkXbwb2u4WH4eCc?=
 =?us-ascii?Q?chkZWnlsvsVpSRGCzuOEkYNnWgySmXcbm9vcesrRs0qYus5b59vHSpaSTFzM?=
 =?us-ascii?Q?Y/5XBqCM8w8KevwJ6ezrorvI5SL/SkbDPRelSrZyT8DKMWRSRRhXMT1VUr8A?=
 =?us-ascii?Q?4HDhtQ2li78mCfVOq7bahiYDNJAib9pG+93wtIT1GIVxx5AC+WSygQp1p/pL?=
 =?us-ascii?Q?fpoVn0NwA/GZ9c1+PDy3QWD7Ta3RQKHPmbrA7KAOxVL/QqBTNps06hcP6zKg?=
 =?us-ascii?Q?f3rja1Qzon5Ys/NHKwj5vmCSqb/M3LXGiMzfceBFCGDrb269MgCGsYHbFIAU?=
 =?us-ascii?Q?rxXpVyLu3sjOqNGXuKkIWrMarujSR2F5qBTfM9VhDeHXdwSmxujd/r7uBKdM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a59315-baf6-4d45-8001-08dbdae8ac72
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 14:41:46.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3k7aWi+D69QGwO/3Q+UCI8epzjywIZ0P5kElbGVu7XfPNQZgGhX9ehTkAnfgGwEcXjQBR+jTkz+/C2Vk+SFFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6529
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=892 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010122
X-Proofpoint-GUID: B_kc2ZbKnnqKU9LvPeSKzD-y4AGZUrme
X-Proofpoint-ORIG-GUID: B_kc2ZbKnnqKU9LvPeSKzD-y4AGZUrme
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 824135c46b00df7fb369ec7f1f8607427bbebeb0 upstream

When the calling function fails after the dup_anon_vma(), the
duplication of the anon_vma is not being undone.  Add the necessary
unlink_anon_vma() call to the error paths that are missing them.

This issue showed up during inspection of the error path in vma_merge()
for an unrelated vma iterator issue.

Users may experience increased memory usage, which may be problematic as
the failure would likely be caused by a low memory situation.

Link: https://lkml.kernel.org/r/20230929183041.2835469-3-Liam.Howlett@oracle.com
Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e9fa969f923..06cb4d0663c1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -603,11 +603,12 @@ static inline void vma_complete(struct vma_prepare *vp,
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
  * @src: The source VMA
+ * @dup: Pointer to the destination VMA when successful.
  *
  * Returns: 0 on success.
  */
 static inline int dup_anon_vma(struct vm_area_struct *dst,
-			       struct vm_area_struct *src)
+		struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
 	 * Easily overlooked: when mprotect shifts the boundary, make sure the
@@ -615,9 +616,15 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
+		int ret;
+
 		vma_start_write(dst);
 		dst->anon_vma = src->anon_vma;
-		return anon_vma_clone(dst, src);
+		ret = anon_vma_clone(dst, src);
+		if (ret)
+			return ret;
+
+		*dup = dst;
 	}
 
 	return 0;
@@ -644,6 +651,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff,
 	       struct vm_area_struct *next)
 {
+	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
 	struct vma_prepare vp;
 
@@ -651,7 +659,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		int ret;
 
 		remove_next = true;
-		ret = dup_anon_vma(vma, next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
 			return ret;
 	}
@@ -683,6 +691,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
 }
 
@@ -881,6 +891,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
 	pgoff_t vma_pgoff;
 	int err = 0;
@@ -945,16 +956,16 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next);
+		err = dup_anon_vma(prev, next, &anon_dup);
 		if (curr) {				/* case 6 */
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr);
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
-			err = dup_anon_vma(prev, curr);
+			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev);
+			err = dup_anon_vma(next, prev, &anon_dup);
 		} else {
 			/*
 			 * Note that cases 3 and 8 are the ONLY ones where prev
@@ -981,7 +992,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
 				remove = curr;
-				err = dup_anon_vma(next, curr);
+				err = dup_anon_vma(next, curr, &anon_dup);
 			}
 		}
 	}
@@ -1026,6 +1037,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	return res;
 
 prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 anon_vma_fail:
 	vma_iter_set(vmi, addr);
 	vma_iter_load(vmi);
-- 
2.40.1

