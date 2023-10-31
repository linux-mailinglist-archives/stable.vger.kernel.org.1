Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DF7DCF13
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJaOMx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjJaOMw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:12:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CBDDE
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:12:50 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VCnoL6004445;
        Tue, 31 Oct 2023 14:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Qz8SBFmm2EnLQDbJgwRRAxHoQSUDzjSuNxB+Y7W7XFE=;
 b=kMGoJtIUbqIA4902ANzfBKx2Ldwzohd3knaae9VU52HocpdCj8ZmdGT4JpbdDeoXug9y
 kM3e/KXSyB352YRnsLBHgzhbia59FG0e/XgGjVPvciSw1SXDz9gHe7h8vGf+KR3tHF/e
 cFfgRn1761XMVYY3CfWhekzLMh4RUSv7NW0j4vVLL/yRJD9y5tlYrxp/56VDBcxB588L
 EPG49heS+KENinVa96M7oeLkx1KqWvDr5jmdbTYSX4T/e/ijtQdmjz0iHMIEkhLZmy7f
 lhfM9gTpZsX1gdfnTW/6mjeoR5KfXwgKGED8MGFJnIgI61kGT0c6ly5g7gHUTjpoZUne jA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b52qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 14:12:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VDDFRd001166;
        Tue, 31 Oct 2023 14:12:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr62yn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 14:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7CCm1Z90GThZg/+AB5MwF+f0tsQP0oEAOFBzGdF2GHnjF43SvWWZN3BSmWViJjGMc0AihJzixQ49u6RH4K8O1RMA9gRT5KXs8L3HQvNicxqv7lUaXGHMCGZ0gIBAE+60pd2Qut9BV9O7p9PrgyAtpu7Zka5u3WffDEROvkp2cG7E5jzqbjZppSzR2eA22CP6bg6WvSRqkZtxh3ACH9StZL8HgUJKAG2Xt+KAylfixa1UE3OmhuE5npIgSgaudjn/J3dMwmTiH0QVecBddz+J1NwiilITOhny0eewoDF13KkROVirWK8oVpIm652toEnsPeEEk0y+NyxPTXyfpAYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz8SBFmm2EnLQDbJgwRRAxHoQSUDzjSuNxB+Y7W7XFE=;
 b=LSDm6/YHB6zlqpiAqtFgJj3S7Z++nM9fMadp4HkAU+TlMKn0MnK60mmIGc4DdAYtCbSd5aH+dWC/+b59XCAMs0ap9PmS1ekNN9AgSHTVvORdzILNMub6EGk/QAwwknuOcAmegxU+T9DKehjhv+9klzD+3rv1fIJEU9QFM5/AL27lecCsDMNmg+FSbdtq0P73f9AJfHv+5bJZk/RGtsIa6E9aOfoPtzXj7m0nnNboIUUXzg+AtrqtWHTXY4ozrxe9Xs+LJ/LgnPsoOS/ABCqegVBKzoporgxuKcbJIUelsI7esug9zzsZCrhipF3P/1zhpCzptA2fGkyWyMRpnbAfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz8SBFmm2EnLQDbJgwRRAxHoQSUDzjSuNxB+Y7W7XFE=;
 b=UacuR5NOF4FYzsvllPZjYazAe83Oa4DWnomOeSVz7U7dVV5/YL/oji34Ot/zS8W5gwHx+eCuGlac6Zs9wrWtUAvwiAa1K17b0apK419XtW4Qw2CyiYIgY89pXPTqy0TrJTxZOZU5/i3YcBkxQTuN23e4cxnaI+WRxqeLpyuDck4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5773.namprd10.prod.outlook.com (2603:10b6:303:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Tue, 31 Oct
 2023 14:12:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Tue, 31 Oct 2023
 14:12:34 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mmap: fix error paths with dup_anon_vma()
Date:   Tue, 31 Oct 2023 10:12:22 -0400
Message-Id: <20231031141222.3269783-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102743-frantic-sash-c381@gregkh>
References: <2023102743-frantic-sash-c381@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: f8374413-3f2e-4c1a-779b-08dbda1b6dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvH/hcgOswvtUMtHy2mA4ArKNOgzhiefwcbedeOhAZ4N3T4iI0f4VSPqTLBPvETVMb2uDt+UeJ0BhjUWODCaI8KIjWtpwQuhGWqafyVbMSAy+Fu3k8vkB3qEAx+pPBSxBhKzLNQNcRjzjxzuKlM/M1zQQ2WlZ0tg7cw+NRcYTD1sRI7tH9Wpu0rgbjfNIyav1MSTV26OJLk2eXB0NbNfRHnAIDMI9BDIJke7fPFMUE8HqH6jYPcgjKRw3e7P8MyCS18WFQ9gaXLdUrQXdJuo1TcgIyfbNC0VVmkjlWeqvClFK6cbKEezrD9+sG2oauRkFRhhhepBAQYLpNQmnyDRxvkr8ysDWIFAX3s3z3VJB+TB6wVZXxOdMKiBSCC9c9sI5ESe+ofLmw0UFLVMSyib+YZPhPZpEW5Jc3KhBbCG1WeDmCFGdOOknRQin7S3sZA5V1HubA3sEw2qrYFxYJX1RFYmwQuZMXa8KGBxYokdigWPv5w5SLLvF6rDJU/oFw8mAu3bh05kpYZyvfogtK3qjDdnoMFWN5PvS9NWC/YrCVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(6666004)(478600001)(86362001)(8676002)(5660300002)(38100700002)(6512007)(36756003)(4326008)(2616005)(26005)(1076003)(8936002)(41300700001)(66476007)(6506007)(6916009)(316002)(966005)(6486002)(2906002)(54906003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/26pnuw4mIV7zkgmY09yPi9qyTLha+HLxJYyzc2jV0CcxidH6rpgTPJEXCWG?=
 =?us-ascii?Q?jAUVdvcqidRvTcEg8hbBr4j0oA4yoq2NVA9BChUD5znjbsGhK0VRXaGpwsz8?=
 =?us-ascii?Q?Tprm1Ep96zxqBM5JE3Iplg7Oblo9SMZOr+gAE1UmcRKpag1vGngJWmnT0d94?=
 =?us-ascii?Q?eQOAqlRXKD38nPKx+SqxooQuJHQMTi/p1CHxI0gFy+VtSjNMJiamkUfb1vY7?=
 =?us-ascii?Q?2NsZTzSwkblsIpJsaiCbErgi6vCn4WhSRgI8N9s9kkpYcrz8qTbbmKdDhtZz?=
 =?us-ascii?Q?wsZet75Stg0i0Jsf4z+pKhDF4jaT/4qws/VyR1gCsaT+30qiqGLxeU5CTEmY?=
 =?us-ascii?Q?tlx7QTUGEMe3KYN/2Ib8F+dakP92ld1ua35F1S09bNI48CrAip6ErBfvoLKj?=
 =?us-ascii?Q?wAd8uhBgTPBV1jIjv/ZUI6SL5L7WJe6zCZQWujvfyzQKut6fILf2wFrkxT1l?=
 =?us-ascii?Q?H85gXSGIYPm+F+O4CLsgOKRLTW3MdQ01k1tPZ6LQ6851MHn75NVp7EGJr8gE?=
 =?us-ascii?Q?qIjcnJ3X1NcTAAzbcDZd9eh//suBgiY+McacZl4CZc3Yv6Evxj9zcp0r+UrM?=
 =?us-ascii?Q?cueAheewArxYPiCy6978B2mapZi7o57yiJdAC71mdVCuePQBiVJ6F8sYpcqw?=
 =?us-ascii?Q?GpYnisGyA6kh0IfccaWgmMICH3PtTogNUM3YCXkxBqJPbo8Omc5S8qW/MHpU?=
 =?us-ascii?Q?5I7S4cKEVqxC3nYjh7WqTUQH4XUxqSC1veKX/MGGKYAO+m8MKHLU8i9dSQoQ?=
 =?us-ascii?Q?BQ2zjbn4dw6pPp4EeuwDeVdgNvKodogiDJIv8vvhYTMADT63FHKj0shyEht8?=
 =?us-ascii?Q?gz0T3pS5k39eBNp2CIUl+Yzl/SksmEBO7yvZOSAF0gEKvJsOo/4Ht0zE5kaw?=
 =?us-ascii?Q?cR4vFM058S8iGWPvT+r84VhBw6MYFX+Pvw4rPyUPUCfUr/RjMAM6wYrFC71S?=
 =?us-ascii?Q?VyBoK5a7/NIPy+wGQHWKpBagW+b95+oBgqBCcwxb1324irWW0wkCmRZXb+y3?=
 =?us-ascii?Q?8olgrM9ObfwWjL6l5Ojxq8Hm0uTz0tybDz/SGa83P40/WYUs69F0HFpQmEE0?=
 =?us-ascii?Q?HUt37qhhAPrIif75tuKX1HhEVxXC7uW9Lj2PmiXDc3evN3DN+lmS6kqYZeOx?=
 =?us-ascii?Q?fCGi2dBpVx1YI5PgAFav1K5UYgXQMMn5q002gD8rLQeuBFcmbBmchk8a8r+s?=
 =?us-ascii?Q?nf+YfYo9m8tzdeRlkj+vzuGQjt+VQtP4O46wPVP1DuHtUmiKNage78vdUvgz?=
 =?us-ascii?Q?Vq5zZnKv8nuN6P2I3/h7CbrNnbKMJIgGoAn8MoF2TzfF5Wmk0sxxxSyhIMzK?=
 =?us-ascii?Q?csqykFykXUemdTMEhyvcSZIWrsF3wPFtkKgb+lYbog19+STs5HNsQbVzyU3h?=
 =?us-ascii?Q?VKVnvDrjPMH9CPHgqP7/pisdWYbQ+8NCtcgCW/5bOu9GkHFW820EHKbRU5Uf?=
 =?us-ascii?Q?Y8ejkORfjzA/6AjgOdGOIHpn0KBOxwpDl387SvzHjJqJ8o0fbjnKoqPkkxu5?=
 =?us-ascii?Q?MVfVDoiQhE7p4Ar3GITm1AJSafGcVWs53tfjt4ybaBBd6/6/kZ1Owzbjsj0O?=
 =?us-ascii?Q?ee3zpPcN/aFJ+F3PkaoYijWaNS/5jR2WIWHrqkGf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ppm+oTjJjUn3x0jiEci6hk0vDlcS08hUf3w4vb0wp0aPqQw7kfjZGMdELKNK?=
 =?us-ascii?Q?rAcHk+3rGvOjIDrDWDH6kYjTx9ei5+qdd8CcF1pk8wBAhPKK5A6x7pNC+ClM?=
 =?us-ascii?Q?zFmPOD58SwiG4sqnNXq7Z2TFa+xcTUbhgPNHnYs0F9Z1v6+I2rYFCFiP6Qxk?=
 =?us-ascii?Q?LrDpIpeUrEEDlgHplnTO6TTJkjRNiyvCGG17HZxwJADOpmHFq3YKr+MNvc/F?=
 =?us-ascii?Q?901AQzY4X9QfpRrkpJC2XRaAY5zN4Q5de2x9ZEQJz19Hn8n10kEDZ7AO+YFA?=
 =?us-ascii?Q?s6pCPs7O1IGbLAwt5LyDq+s1BmTCmPBSn3UvB8Z+6pkkFxhwrAIrzdglWJWz?=
 =?us-ascii?Q?/KhFXXY8+yJRw2GObeERi4ukXx1YbZYDx7LxuksQlUF3pEx/QL5bzFpJtuy2?=
 =?us-ascii?Q?S/6zrCqLjlXesSHnZ71MoGoxj8/fO4VVxYPoYsoIfGJpJFyiOnIkyapgQpus?=
 =?us-ascii?Q?tUmSAzNp9CaFPcz9bD2KRaf8iZMmxgIbxUhmMbQ9Z/e0AapvAKEVb2VSuJjH?=
 =?us-ascii?Q?89UXLJinSPUPZl/no44IKzf+TzAMpoxPrmJFIU7Pp2xKVPoC2JT97LJJejix?=
 =?us-ascii?Q?OOpmZyENbt0+w47TaTwa547zfTN/INmf08Tax92Uq+tyWC4QppfgnDw9mWNd?=
 =?us-ascii?Q?S0bwDddIVCK64uKOBnBlEv7/v5ajPI6wiJlqxuzB+/aiqnVdOPyTtYM8OVlo?=
 =?us-ascii?Q?sHrqc2XTO6R92sYnhlCjp3JyoKhF5Eg9stv2Y8hRZ2DBcnFlqMmfbZlpHvra?=
 =?us-ascii?Q?UYAS/73W7R9eNudYYjxTlt3KsxPq9DUCXWuqHo0abUV+vrTm6fimu0Vf4Dm1?=
 =?us-ascii?Q?+pZ+J+xC+3nu+5NTbHKahVCshrj8Z+C3jLld6xXwnl17aHA9oL5+O4JkWb0l?=
 =?us-ascii?Q?tslQWCXzXB00mIMXaYM7U0a2tNx/hqT0S24vMa7jlvsSBEEfUnWaWjM3v5cX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8374413-3f2e-4c1a-779b-08dbda1b6dc9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:12:34.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ5dRS9L8W51K5NiW0xeBagAPaxq9lCBOj6ZciQ1Y4gMRNHDi2egpAclShcsmvVK8GKBMPLIb4qP2bwg4gXF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310112
X-Proofpoint-GUID: ZajMNcU9I4knTK6RYSdtKFxJXHkh00Uz
X-Proofpoint-ORIG-GUID: ZajMNcU9I4knTK6RYSdtKFxJXHkh00Uz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 824135c46b00df7fb369ec7f1f8607427bbebeb0 upstream.

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
(cherry picked from commit 824135c46b00df7fb369ec7f1f8607427bbebeb0)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 41a240bd81df..c31a0ea7a4f5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -519,6 +519,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	struct anon_vma *anon_vma = vma->anon_vma;
 	struct file *file = vma->vm_file;
 	bool remove_next = false;
+	struct vm_area_struct *anon_dup = NULL;
 
 	if (next && (vma != next) && (end == next->vm_end)) {
 		remove_next = true;
@@ -530,6 +531,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 			error = anon_vma_clone(vma, next);
 			if (error)
 				return error;
+
+			anon_dup = vma;
 		}
 	}
 
@@ -602,6 +605,9 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	return 0;
 
 nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 	return -ENOMEM;
 }
 
@@ -629,6 +635,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	int remove_next = 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter = NULL, *importer = NULL;
+	struct vm_area_struct *anon_dup = NULL;
 
 	if (next && !insert) {
 		if (end >= next->vm_end) {
@@ -709,11 +716,17 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			error = anon_vma_clone(importer, exporter);
 			if (error)
 				return error;
+
+			anon_dup = importer;
 		}
 	}
 
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		if (anon_dup)
+			unlink_anon_vmas(anon_dup);
+
 		return -ENOMEM;
+	}
 
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
-- 
2.40.1

