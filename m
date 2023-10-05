Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24187BA6E3
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjJEQnR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjJEQlc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 12:41:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE02661A5
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 09:28:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395C4Ave030006;
        Thu, 5 Oct 2023 16:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=cM4Q5nGvlipMve/4OI5WqLPvGVOFp1qsv2wv6chQt/I=;
 b=WBgNpjPuOzovp3IV5174SdjngnntUFLMhuJdC3WETxC8BEUfmUykGaaRrOmatdCcDqNO
 PYLZ6ivvJ7SP4oocQwBOS6hUPceALzcHhHbBwkoRWzua2nfysOw8TdoODATR05AO+WVq
 nFtT+p1SZh6cB4HAkXUbE+gxkTI+Zkg13J/+erkPrXKNbXq6VvX+SnfcF4N8ZDi5w46W
 1PnqbAMBQ6mcnRKRnlGSdgdEUvjYFD96aI5spJzV9CcoKhn74gvdLnSMHlNtOspqEBju
 dd4puF6xVwQTQZ4kLdCm2rpUdTsZVMoWFIdXzzds8WaaOH8BSb8ZXxIA+a9NkjzuaPEA Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uj154-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 16:28:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395GGKiB005872;
        Thu, 5 Oct 2023 16:28:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49ck15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 16:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrWTFtv94HEabGnNY0c36e7RPgJmdYonTNfAF/SPh8uiRcxdvGuo/lQmgAh7B6mnkkRdAMj3Vvn+yc0AwKhYANcdAQx73YIJ/kwiPhTXXMCrzeZyrFvNWVIi0Peaq/OJL5yytwHyhiPSLymhqHbGjldXWk5639vw3dQwXaYijBXeKbaBr/0Q2hbSOVYXmljJLC1ZtNhX+WYx9CQtt0oPPQyUeWnbzqNRn7ktEjVcnM1AMjnvpTi7EpHtOVucrRUNTfNZj3MtFfB2nWIBs0w2SzHVBiWWeWjRYssNIFP2Fc6kgd+iDi/v0Aq83QP4rXAFOKIVGX69hy+n/3VE8AkRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM4Q5nGvlipMve/4OI5WqLPvGVOFp1qsv2wv6chQt/I=;
 b=S6c2cjOylb2atwg6lP8y4QM/07PPInyKPp75Rwkx1xZ3mhU7yp9TD0OkznM+Wakk8x8cW3swYa9R3FMW/7yX86wq5iOpeYi8PUGeQwrRxzEBh+p4M/uLyimMsteGDFHnMx6Zo0ihvOYf1LXoWQGYpxVNYxV7Bdh8iZzAcbdwXzGBe91AuBi7poboF93vSq65ARzXU5M02szyZnrFaiRFi1ySzFYIqRh6//lhV1PRO0x34HQzHQ0kBqBQqaOqO+1VQhHoLKTIPJfdrR9Z6apYZZKle31P1V4RHfsU+q+/0L2Sgp9M8BApQ6zwdxsMWC64XzAwNxsw/H456SvmdHmPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM4Q5nGvlipMve/4OI5WqLPvGVOFp1qsv2wv6chQt/I=;
 b=s+gw9I5wFjlCnyo3kMVQHsqg7tFqESwrk1PRQVVhaP3T4DSOoPMd3QrVoX1e2RblF9XC+vwZAzP+HSi6jUfc29R+kr/8IpGyQ5dMjz7Enl8csVs+5rDzxy9VnbvUqCtPv7lfLVE9faDJ+2kPQifp72o23okCUEM/nQm3Fax7IyM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6830.namprd10.prod.outlook.com (2603:10b6:208:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 5 Oct
 2023 16:27:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 16:27:57 +0000
Date:   Thu, 5 Oct 2023 12:27:54 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, pedro.falcato@gmail.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: add mas_is_active() to detect
 in-tree walks" failed to apply to 6.5-stable tree
Message-ID: <20231005162754.7f2nr4feb7exkfus@revolver>
References: <2023100439-obtuse-unchain-b580@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100439-obtuse-unchain-b580@gregkh>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0296.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef550f1-2e26-4dad-be0b-08dbc5c008cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpSOybSH9v+4BE67H9DkUN/UIfgRfRNE9xj+iHgyx+XSzGf+VF8ksJQtiUc2MtymiJG03XKjYf+fXAp1M3qwcODDsx+mkhQ1zQf2iWXhkuXeLgulFHtsBfaRBbCN/DehOuKoWMzRaB7zn4O8swx14+7jPXFkFQn6jbNzsehWsIQatf0Q45IkmBd2wjzn5oTwcPgdMCDX095XOP6fTmYMKx2BYR8wYMHWBFoixClihfywSYpZ5ftjfWklPLnk0R1t1It9tCaOxaHQ0CsNDwbU/m7KIciUq+yTxj6BOpkGkcTed5rkv6S5PPnoXVv8O2UqrRdTS102YbFvdyHVoEObx5l/Rs3joIxaofCJVsozCj6bwgPjrFv8KIEF778/8npzVOdP7LkY80eFcxJlWi1rHnsHTg4yaJd2u80VfUNx96p1kMw96vBLwspURMvrHVmhrBdPRVa7SsPx1e9hQtRJGy10z9nk+c23zJPx6im0SorbJ2j2owB+O5mI56/hHoD6qj5vbVU0xoooefkjMguzNq9ewqMCviQmti+R0KsIRJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(6486002)(6506007)(6666004)(478600001)(966005)(83380400001)(1076003)(4326008)(6512007)(26005)(9686003)(33716001)(6916009)(41300700001)(316002)(8676002)(5660300002)(66556008)(66946007)(66476007)(8936002)(4744005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cVFqt/Nw50RRRxy9w5mukLvA8erXiqB+pFuLieiDiJ1qiJBfubtuIqSo4j1?=
 =?us-ascii?Q?MwN+UtOLK5FLvjRthTbRZ6oS2ody0V3ZrFMjG3oppGYCybhPDdVSZ+Rg1UcS?=
 =?us-ascii?Q?GANrHurkfdLxtuv7q+6652D2SokejEyDa7YV0TiJF8ioeatNpqXvmQFMap3M?=
 =?us-ascii?Q?TA7B8rxVxDOzKvo6qJZxg30zmos53dhbaqAuqpCrtsG5wVI/lgKCZBbBkRqR?=
 =?us-ascii?Q?zAP4mMi+x9WlLpUKOKKGb+pBi2kJXXYJO0dHABb4YEodglR31rt8dE89ZhAT?=
 =?us-ascii?Q?o5+Ct0EamhQO3KV3BF9xiNJZP+CVqDYXmYbSVal3EHMWZ7S/mV/F+hLJZANf?=
 =?us-ascii?Q?J6437GKHYAMVOYyidpJVbuVbWusXawqyuvEJdH2BWum1ggVoP/zxn6+lfIdB?=
 =?us-ascii?Q?pqPExlR/FafZvWEQnYHEgZf9M+Q65f089LWd/DwGerNDinJPPMUjTKgbMrTi?=
 =?us-ascii?Q?a/3Y3YZcCG4c07kIIdxBALAA/BGhE1olP84nmTCoykQZVGwK8Xw3YUyTY4Oy?=
 =?us-ascii?Q?u4eAdhw7aZVhqqCKyvv7TAWsxLRp45s6aD4MwwhF/6z0Fir3RKsml1e1qiIK?=
 =?us-ascii?Q?3uz7rOugV3qlvV4uUILXkftVisL6qZSuQ//RMNUx50gk4AXA6ZpzqSjdYx/A?=
 =?us-ascii?Q?peWNU6B9NcnS7dFp/M88qghF/3cpZ8VdWq9xLaLH8PH897N+gV/amqv/7wPu?=
 =?us-ascii?Q?8rCDfthwRchEOhzdNd66I4dGcXuPls4B4r//n0bBZox0hPYt16wwE9W3IDVX?=
 =?us-ascii?Q?idPpDZZ4NSLZIKeBEMZgmWlTxBMm/WflsvgRDkiq0jiBnQsY8IGERQvyevI/?=
 =?us-ascii?Q?V+b+M3X/GWmz32vm6i29Wqyr1PVspbopF7dq8AzoWhrwWJOPgg//JAbJzBjx?=
 =?us-ascii?Q?ZI2fAzDdS82FUdBasA+/Clw/E8/AJRLZS3+KNCGeJrzHJMoqnUexVZ6bifGs?=
 =?us-ascii?Q?DMi44YZCfup8dJaAMrnQhjah9cM2axC4F2qdNe0UzPHm8bqUp4tfMaDuVmgq?=
 =?us-ascii?Q?vx3LX2dAcQFRoqKuyGbiqGoI9l1aJSTTQXFAMCjEbaJp3XyebFd9cFEs2cHC?=
 =?us-ascii?Q?lU5jdhLzQJhbrTMq7/EaLyPCAfbyUBZEVBYe1TWCgtfOafFuDmqhvIIttQA6?=
 =?us-ascii?Q?5FU52uj0sGXE8v+H/5zpqDVKO1zwbbFPUP3Wt9Wfa6vndknNpwrN9mNodzrU?=
 =?us-ascii?Q?HgykezmbISjKvH9Rrb/ZbUCx+U6u+VRm8aSuGirJPWooCt5RxL+VB922feXM?=
 =?us-ascii?Q?6a0R9u4IacwDWBct4++bLSk/ksHVyEWVV9XUMEqW+qZi8Qg2i7rzjPWFlqMB?=
 =?us-ascii?Q?w3T6CPUk5Is3+IYRl5lPDqcG9lNzsFs13WlQ5W98GDnujlFzQhnk1Oj45caV?=
 =?us-ascii?Q?HHEpy5kH3FGB8UkbO9g5t2uq+uBZRKYxqHc8EwYZbRtbxF46+sWIo0NZPj5l?=
 =?us-ascii?Q?cMRxsNOC93Cs/r81KHqgk98wfoUS5tY9bxHrirKwtdfBBsLcyZbycplbg/+P?=
 =?us-ascii?Q?A71VaftWtbRMUa/V5vUMX91t5ls6/fKw0H8IoHNYnbB66wP7H60i8wPCKFNO?=
 =?us-ascii?Q?ESvCslD5hrg43SCJ9+tk5/Uh8eYQZlvC1PJuphb6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vyU+Gel64mCNi/RBPL7bcjoSMiJqtjjAZMMFTHMZQFJwHZuY9CnSkH5OX61z5esM5u1fQCV9/FVuuZ1KHAG0CT9gB6ApsybDoyNRuUUqIzkzFYLRSuS68xFbQx8HR8D0Ftw/MqDNShUuNxAZxt2OT5+NoHgQA6/3ppN1RVHNxJ42XA6IA3Iz4qTrC37To4/hpDDiopLNo0pYzWWK3POxHhckGfBrApg+C8DLfMh39HQTihE5adL1ZWOlGz4cU8Cu5OdStTt/HNnyY0bLEI8Uu3MfcR1UjZH7xTlZjXHoGkH/vZa3izOxPT/Nvn1FkyNExqJLGnm1z0K32bKGJFqSsIv72Kx01vBM2N3rLXZRJpisBKdj3XxjmpzgFZ6sJX8xg5T6X1eh13kLVKlaNZZlzcJ0iPFJM5lJFKqflxqlqhqG0ROOYQYlgAd6cmrpq1DHFZZgLlAzwmnL5lAfvNZ13EbIEa7EpDMLG/4+04JcMDPXk55jt71YWzYmkoyvNY4s1Rm6gcZOedzbitTkoc7D+bTVDoeioJK2+V7AkfWQ7CGiuY0WEgOuPZfG2ju0SVluG2Dnp+PkpWnPin2wC6beipjW7t3FeeJ+0nHGbp6dJboMH5kmWPpcsUq6sayzytJPd1KSxua7O7YGmpDRDpw+gWKEzOhU/t4Uo8eJE3IKxcbaPFN4gjAGAHVJR3/XAUI2aqRQW+NbnJ3j8hnddQ/mLPWjT4a7RH4W+Qv9ghSO7b9X+eJqj2v9UYNH35XJ2XxSO640g24iQ/elM33W4gZFyYnC/dU5yneG5GrtY88lQHtA8mxLq1QYPuL0xv0fmOIaKLwWVRVAIesIK/GwJugteTiwJvNW1/se8eMGX8dLI2MN0NW/kSlnuNMb/BgfCVXJ3wqtVNxQRpSG+IldzvCoDg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef550f1-2e26-4dad-be0b-08dbc5c008cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:27:57.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAYMUMkbY4NzejFOdz6exAItTrO/mbA1x/S3wQVZAgRKMA2q0TIQpyzGIVUJ9Ut2M182b4qwxc7cXTb793ApWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050128
X-Proofpoint-ORIG-GUID: JFcBScfCmWhwudaFaD-PmcifzFILz5KQ
X-Proofpoint-GUID: JFcBScfCmWhwudaFaD-PmcifzFILz5KQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

* gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [231004 10:59]:
> 
> The patch below does not apply to the 6.5-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5c590804b6b0ff933ed4e5cee5d76de3a5048d9f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100439-obtuse-unchain-b580@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> 
> Possible dependencies:
> 
> 
>
...

This applies cleanly and builds without issue following the steps above.
Is there more details on the failure?

Thanks,
Liam
