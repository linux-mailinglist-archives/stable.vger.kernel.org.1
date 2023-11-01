Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75C7DE3CA
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKAPSZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjKAPSY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 11:18:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8510F
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 08:18:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1B0IFN028343;
        Wed, 1 Nov 2023 15:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9lZaMcbyG9VNgOXXhOpHzSG54MVORRboHxLhguytEgw=;
 b=aSUWT1P6QFLvVnhpgVezNIaPEELfk0eIpTBgEsNNuVLi6AL4ym5Hc1mC/a6aGXKQ0osv
 WC/HWhIkH22qEUIEKzAsyRwW7SNLuuhMiRbfSd5vKPl8X1/Qz7Cc+sFI88crXvMCoopb
 cucqa5HNudFFaY9YIAYGw314Lqqroa3ilEvuGHDBysX0mvgUhbbDctu6dKDh1tYdHX+O
 SCB6iV8tcBdZ7X9+YZCk+HfFwgXWEcUM2wCPLeX8Hda24y8mnU1UptkP9DLhIo69qFZX
 RYq8i6HWkeMybOZoC3X6c3R/XRG8uOC+47KDYfSM0Rqy1GBHBjlbYsYyKs83+EYgtW8O wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7bynmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:18:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1EBwS0009234;
        Wed, 1 Nov 2023 15:18:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x72256-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXZ/0CVAZAxEoKvcDUOYeuh51h+5+043fGy//ankKHCp8gNZd9RhhkA5zrWuATLuu2dN8E6A0WsH6G/Qh45Xjs+RyLdxBLWwUW2ahHrF5i//QHsfzhHTAb9pBcL9tSCK1JkFXaP36OSmIzjQa5JrrExmrCd2D2U6cv3PIft34F3fX0Q8+0VmeHR35wiLii25/eUWQT8677FL837rHM9cD3bQ5pJfAzXxGR7U0ILPFsx9N80JwcOicMFzuZNYWZlLJHAjfC1hLdX2S/whKwXImbS5RcJQ7MQav6hKsnmC6LZ1VzynE8jTYUADZZz/Y9eS5PVJj8TXmz/MDVzgZErOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lZaMcbyG9VNgOXXhOpHzSG54MVORRboHxLhguytEgw=;
 b=fywu8vvNJhE/x58PKGnuZp7otvYX1qWqRuc8VlsIYPOY8A2uKAkTIwq50N+sZTt/1V7phFzDMvXs3TjgcHKM9G0li2XwwLeB3t1tndzPXjw9u46xHWgiB+DEVYRj1KvozHQiErzkKWKELZfnrVZvoQ3Ix28I/1gfzqi2Kiytt22fp+8cKC/F7ajk8vVchu/rIK3x9RsYWDppNoDVNuPoRlM7rPCXkFV6j3xAR0ozHbZ/lEKseobB9v9YuX2Tj/tY7t+9KzO7PVaMRV0Hv6wB1XlqJv0G+jNMBy35eQk7CfEIb+zSXS5cXy9qf+YCefjbPouEfqwlGuqGUMipf4N8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lZaMcbyG9VNgOXXhOpHzSG54MVORRboHxLhguytEgw=;
 b=peeY2u2eiFrr5nyem4BXjtHDyQ9FW/ZQ9TjGyXBOwklFT5KlS0ox1iDaL5OGoNNQia+z6Ruq5+NnEmhdSJqisPy6tpnt6h/bU7kOkg+yEe9hSpclI55aLV7zYmYRfoV0tl7hi5ubu3dKwy1x5crzoJm1dAZ0cQP0FJa+EciZ9Sc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Wed, 1 Nov
 2023 15:17:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 15:17:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yikebaer Aizezi <yikebaer61@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
Date:   Wed,  1 Nov 2023 11:17:55 -0400
Message-Id: <20231101151755.3594032-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102704-surrogate-dole-2888@gregkh>
References: <2023102704-surrogate-dole-2888@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ad6a4d-a123-417e-da85-08dbdaedbb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: derG7OihSq13hqWeNyA9YxW2lae0xlZWLoFrxvZm1UZxk1hjqCjmwmZnR+iQMIptKexDV+zoqsbMdvN5rmc/awxIgxsmvDP0cpAiBwvyBEkhGjnbxeiFVzTwi73cqKTe87imSUleTIIY6M20/V+wpgArHRQDd8DUZh/JU3mzvOwNJYi6B/BToOf4sLveRabkaYWwKv0gQgwx75WZgnfRoBRx+ctLKXAzTNOW4eFLXLhMWEuQsQgc7RlyNFNuZGtyumI6yQN6RlfacCXqpG/DY+DJBmGrkBVgT8oHfT5/SvwcXnPn/WAT6ZHdAqDyuvnij1r+rAx83eSnuwxnqPRzw/cUrIBTpSSzEcd+xInGEiGiZFW+iMDqms+Gg90G+PRsgzx77/oMDdwkeddM/vl8zRniH6IdzY6uMUmQQr6ih/7Nip7wuE0vkffq2tqSjf+JhQUjgmmDR3MMdZkTyrVb3Qe6ummJE0yteZ6CXW+/VvD1eqsBFcNrJuE6IhDg+hXIQTnvKxJJZ8fjiBIKTXV12mhLxYbyvI+WhoaMNztJ0ocl9+LUFc+4f6asGZR6/otuxO1nW7WWXKe8Mmqk1uTyYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(966005)(6512007)(2616005)(41300700001)(1076003)(26005)(8936002)(478600001)(8676002)(6916009)(36756003)(4326008)(66476007)(54906003)(316002)(66556008)(6486002)(66946007)(6506007)(6666004)(5660300002)(2906002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DpskprSshgRX0EGSIYNihOf8ZHdj3G3gkG94LCtKoCyf63f+/wpMJXhY8d7v?=
 =?us-ascii?Q?AHGJyJ1I1Byzp0v8zCOvYzOJBiFFlMc2BkwSgsAcGzJuV/MBz3VB6nHQSb0J?=
 =?us-ascii?Q?BGg8NBpfstD6DZK+zr0Y+TYnZcHA2i/KidOubUqg3odZMn+qbHEswml9C3z/?=
 =?us-ascii?Q?QLRHFfk30wmIrVdq6yydTWbSP1dM05/DkTqdUWoSGJmazmUbNoFZR77qeYsk?=
 =?us-ascii?Q?dN0f7WTmSy86x7tsETQYu0knPP8Y4lYmREvS2P8aazq7VPhiQpQXlOwPTx5h?=
 =?us-ascii?Q?l03Pqvyj7s5oCXXRVkHRHwFOx/AOzEbaPx2kB6TJHEpF8YXQjDVgBhQE2aGa?=
 =?us-ascii?Q?Ktv8ccAp8tRVyoN1swqyxAl+sq0Xp6Vj1h+UauLCxFtm13mGXykT//tPTZn4?=
 =?us-ascii?Q?3pLNVEUYjimzICCa9TogYeaQDNvOViKxkQvN9W9lyGehqkbNkcCQ9YE37n1o?=
 =?us-ascii?Q?vyHkEPGhIrlkNiCDmbxji0kOFvL6Mjm6NCwpbtQOsvXELpaa1EH89LWsNrsc?=
 =?us-ascii?Q?CVUVQxNJJ+MfWKeA0jI36er1O3I6RR6o8drYDqFEnxMPy6ZlV/48Rnf/b3wo?=
 =?us-ascii?Q?+3axjTrazYrdpNR+RYgoo9ZVSldFVua91K0J2F8Xl+XGs3CcwMZ9nSuHRmGI?=
 =?us-ascii?Q?TEsFzupuTbj6m6ISjM/Ae8/41fTWR/aGSEKdcrTLfyho3CJJuN/BQayOpBFt?=
 =?us-ascii?Q?g0WsCpeQycG/UOZflVgU5BEm+yXzlGnPzUod9HI2eJ0EmR4xVfy78t1sAmj4?=
 =?us-ascii?Q?/lBUXXT/nMttFeA2g3csvkxwRRQOqMoKzNofpqhnqDdzrI17Fyl6ox6NQcG0?=
 =?us-ascii?Q?Fx1cIODjJxCmBMG+SESXMA3/UceIXibKGePEBADMDoZOKr8B1Vasb4dipp7J?=
 =?us-ascii?Q?HZCTTb6L98lAF7+fZcIwC+M2nL1CC2odsEpmzTncEsYkUAaNX7VIUqzFcsv1?=
 =?us-ascii?Q?gbcahkbSrby0Qk+gkXIZ9E9rUsNDJVkBmXmddX1dMs5oKa5NZZmQb7RxIGS6?=
 =?us-ascii?Q?f+CUmIJROq3li4h1WCbk8zC9fBgPIVcijXVIxw3F4ytEiuyLPf49VPR8Zdm6?=
 =?us-ascii?Q?/m297xOss35D8je6vLaaGZUPlloA4+AqTQ04faQDCtsQndva0nfuURCme0VL?=
 =?us-ascii?Q?LVRkiVh8koX/uK4WHOrI+iZqfXVRBU55pLyRwyo0CjEBghN7EHF8TH0dw3Cx?=
 =?us-ascii?Q?z7rLeckWllp2SiqCP7blyOgU/QQNBAOdsvPN4gy3ZY1N32/NhMHol6K53cmv?=
 =?us-ascii?Q?uUbQzTfpnz+zgYxK6Oh/ihQ5WoYBpRaPb2rhBgikOcNSNdLKhTNNHFTjgdQa?=
 =?us-ascii?Q?T3XV6jZU12XMViD/4zCanN+SqO56eFIaa4O0ix4OuV/Zm55wUOoNB32T11KY?=
 =?us-ascii?Q?mbQT/4wkJMV/CvzNjnnt/9TSleRGCDSS0XNIAYTpkoSG/Xv6bfWF4kJn2VOO?=
 =?us-ascii?Q?894aCyuHgHIA1oUSjNMa1qFpM2B7ByWDc6xH24p4fGddQbBa6i3SLo3eh/kh?=
 =?us-ascii?Q?43nWCw+8bhTXwAc+ArysCKNCFnfU93eaXJbXdqWQIAmn38VRiaVOEx7NEsPS?=
 =?us-ascii?Q?sBO6CrfP5tbttEUlQDBg6oXiIMoetN3m5aguEo/i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OqKk50194fvmIApUnPOvMIiV3EPlpGI8agxN2GMSPEnBuBpD89zBN2vv6X4ELeZx46/H7DM/agwJcK3kNdJFC28Pc2vVpKqR+uTA51aJuPw4m95KMJI7RFrge/ZwJvCkDhWt3wnwrW76ncPrFatJfjOxj/4L01Sqlr7W2juGXykrBfqvebCm1foAflaILgXDNAFa4Nx951ufV9TCXboEO73xInFo9i56F3ZMHBBmmLLll48wsd82hx3fNACz9obic0o+kUzZ3ZRZspaX+0q5fpMlvTcvzYBme3xfISmcEbEppRjo0KP8fuu8VmJo9sG3I6Z1l33w8JPns5YbKZyB2pPWkrba9uEEFWHudUZ/D11bReoDYNeZFTByg8F88vmTgkESj/TrPgw6uAba0aJuob6A2kK9kAenkblOLmnix8lOtq6+jQ8NYAynGjNNPXn/pLS3lIQqLofFp484MiFzSne6yvskokKC7nBO9xxxZ9uTsAyrEe59mjknyjjYQb6LuDq4OU2mKsGIEGEcL8n2LEf/bI6PdzQ1P9qB6qWcOXGZlwHT6WRgDsTh1e33/OV5shZhV7ACS0AJHzyOH5kzbobzMTViUgWLjdLHKH23jPFC5VEOvMD/0QmMcP2BB5cxb4pBvA4olEoxIgrlZRSkirr1zxyCQPn1MojWxvBtvc03bnPAZW4qP7ZY+ac87RfCK2uinSNyquXxv2ol4AIiUleOKxs9rxu+XJwfQwq7dnQEFH/2J7EwEsLiH8hJ01g2aFVlUZt0eK2pFjl0QUWLFGESq7cc1TuybGssefipvNrtkXT+BI9G59KJnwNtCYcXJC6GgG5gK8/2lkTvPHTChA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ad6a4d-a123-417e-da85-08dbdaedbb6e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:17:59.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5Ygb7/bWwvZPoYVsZOJvSVuBmOfFCFI0hXJPRRYK15paIruLPdiw9qoqUykf94l0i7wl3bR31F9raHOdAFnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010126
X-Proofpoint-GUID: KFxjJiFgRdR4NXIZpnmkXkMdqGrbltj1
X-Proofpoint-ORIG-GUID: KFxjJiFgRdR4NXIZpnmkXkMdqGrbltj1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 51f625377561e5b167da2db5aafb7ee268f691c5 upstream.

The two users of mbind_range() are expecting that mbind_range() will
update the pointer to the previous VMA, or return an error.  However,
set_mempolicy_home_node() does not call mbind_range() if there is no VMA
policy.  The fix is to update the pointer to the previous VMA prior to
continuing iterating the VMAs when there is no policy.

Users may experience a WARN_ON() during VMA policy updates when updating
a range of VMAs on the home node.

Link: https://lkml.kernel.org/r/20230928172432.2246534-1-Liam.Howlett@oracle.com
Link: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
Closes: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bfe2d1d50fbe..84e11c2caae4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1525,8 +1525,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		/*
 		 * Only update home node if there is an existing vma policy
 		 */
-		if (!new)
+		if (!new) {
+			prev = vma;
 			continue;
+		}
 
 		/*
 		 * If any vma in the range got policy other than MPOL_BIND
-- 
2.40.1

