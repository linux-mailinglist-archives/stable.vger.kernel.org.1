Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4F7DCE3F
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 14:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjJaNvZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbjJaNvY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 09:51:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB2DE
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 06:51:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VCn8WT008625;
        Tue, 31 Oct 2023 13:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=CaRaJgY+gxxPgi37ElImeiEHwOc1daYfWMOZH8pKHqc=;
 b=apfz+dm0bEMQCA2kvWsg1eDM1PpFXOT1uGJrc/JRwS2kLl5JLEVGtii7/ftcF8eyUqTu
 t2EFC3StjqQerAaRg3aC43Lcf2j8iZdTSron/FHtBg0/8t6Kj6t9KMBr4Nrzv8/xMii3
 D53PEmHoLF36AfxyjoCKdCqZAAvp7xJCW1ebM/wYUfufFBLlcjzxFrh0mF7ghv9r74Ef
 JViYif5nDge+SjGLelvNlKyO7ocVjhzTZlSy4H2GBvM/UqbqoXQW0e9pWuTcYE5RaHC1
 oQxiILR72pq1o96mcqvwd31zTNgrBatJ3io++YGtdEnD9bPHfmaLYULfoVWjciJOoeAu uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdn2av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 13:51:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VDA1tX038030;
        Tue, 31 Oct 2023 13:51:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrbx1d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 13:51:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InDNVQIW9hPJzNZKQ7ZnGHUkMVdHGue7R60n+ZfMjph/pJwsVg61VlqMrNPlAlalrkMnkMfvpARmW5OR59QcN+Y+jxEckwyo07X74nTKLCpj5b8affd51P79ySFsmJP0YZKPSz+MXgUyNXrXOkMnKA2BXiehvxGI2w9fsTjZt8RFadOESo263+L7EodE65mJ1YZwo0vRtqc5YctF5UWNWdJZ+fkFAn2WPlXDKgUyXz6CBUQeCseMhannZypg7jjINhKipqeyrIuJfiHovLQRzwIdUncmqCYhrHVROVsJnl1YI6oEm1cgoP6a3B4Y8z7FGcm0Nr6JnQbCIvuBpd9fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaRaJgY+gxxPgi37ElImeiEHwOc1daYfWMOZH8pKHqc=;
 b=JjdiO6xLrt1gP+5Wyj+oPkKYHi2kUJMX08FJ4LXa5DTxv67uac3a2ILDub5RHeksYEQl2k+BHwtWJbRDHCPGCLrhem2sId+HGU24/DHgsdIOmUmtt+1stYh1RwPd9BjwU5pozfNQGeWl1X8WqtxhNUhhC+m0NWZWdnOiV7M0caQobxK/zHg9vezP98vLsOZkCLoWiQQrcMxbzy+2K8ETKq/+YNbrl/AKtM5Q/8zr3FAohQOh9+OFRV8M2UXOY94Au1/Wf6ZAvDuX9fEJvsUij/76mRJL6gudFoqwVQno+gc9OEJgfOG+a6KXdu2zvvW0fRTXsjl4OdIbd26xIFMSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaRaJgY+gxxPgi37ElImeiEHwOc1daYfWMOZH8pKHqc=;
 b=G/iLewWqtaXjYAE9LgfrmW0YZj0+NO4GdTVtWJnS8By559sA/aIBo5zRtNeIqtqDpvSWVJJ8VIAdJ4de3bK71FfG5I8lZjnir3plj44xOiHRbvScgKGddp4y4jAg65ZOKejNts6E4IRY02D0QlmJIWMjVhDNI5flP5XDiaq5imA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5351.namprd10.prod.outlook.com (2603:10b6:408:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 13:51:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Tue, 31 Oct 2023
 13:51:13 +0000
Date:   Tue, 31 Oct 2023 09:51:11 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, lstoakes@gmail.com,
        stable@vger.kernel.org, yikebaer61@gmail.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: FAILED: patch "[PATCH] mm/mempolicy: fix
 set_mempolicy_home_node() previous VMA" failed to apply to 6.1-stable tree
Message-ID: <20231031135111.y3awm4b3jvbybpca@revolver>
References: <2023102704-surrogate-dole-2888@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102704-surrogate-dole-2888@gregkh>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0253.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: b600a300-f072-4817-e962-08dbda18726f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKANpq2ctcoB1okpq1u42140bhmEaMc66c7oqVPzZTeUH1W1hTTVdK1hTv28FsdLmw4XOF1EJZisVC4hjT6wSel9ZUNpro3M4QiwvA3PYxT39NhAnuqVGrxHU7pzUwRA5yKHeT71vxFYO4WGWOH0+KVjOx7jychZ/MsY0Knbhk2p4EAPIlEOdq6seyXy3CR/tUqD/U+9f2FfO0Dp3ia/Jy1SqR4tP/C0gU98BkVjmfuh5LH6hm/kRsE8IVTI9JL72CCXM2uqq+Q6xOp2wgEei1r+ljFCGW0brCEej+njUo+2E5oXrf4tJhBY5ftM+O+P2B9kWACTZSHVVrLvS94t79eBHH/qQTtlsy8A0BG+4GjIrqdi7swupCXOO1+0kyKDwWAUT7SzgiHOpUI3rDFmitQHz+lFq88UC56ciIst9DJb2T87h4q1DppX06q2Wup1qmghGlQZviYMt+mSlKxjlYA/KfpwcO3J6sT+GCOQgeZh57AhVOsv5/Yy8R2lXgMVpYqxdat2mIcRbUPgWVnWLVKEfn1qTCQpklr0CjRNz/gy46lxw7RiC7UgE0AymKTGTyh0uAKHXIsYcDU+HwxoWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(86362001)(33716001)(1076003)(2906002)(66476007)(83380400001)(26005)(6916009)(66556008)(66946007)(478600001)(53546011)(6506007)(41300700001)(6512007)(9686003)(38100700002)(8936002)(8676002)(4326008)(6486002)(5660300002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzTUfI/QGkmxG13aPntZ8dRvO+DhRGp4FVDMpgf9y1pscQ4tlKOaO5EGcFGI?=
 =?us-ascii?Q?f4OZFSWDjegs076m/rbsmpQPy/n+jaW/eol4BeyUdC3xh1PVy8a6L4YeUG/I?=
 =?us-ascii?Q?Mmffx/zuaN3a0bHRdFwUlmmoPwzG12JwaQFVv0VHPvOQLPzlYidOoaCSJgLt?=
 =?us-ascii?Q?EKjLevylEFA1jNgxO2ioweFS9XWE7VBuNyAMxvAhifiqA5betpIi6MXJcj3+?=
 =?us-ascii?Q?NMAw1W1HQjiAgmk1RUC4zgAwcxJ6s+/mg+WChUeaCyXs4jXzrCvzg535GsBS?=
 =?us-ascii?Q?YIeIyO1fHBdt2gxDT5yxdB7J+XX0qmhYAykUkGLwZk5G/56xhhc5sZcmuE2P?=
 =?us-ascii?Q?g3lWcY6FQICbtoZOdXLjYbnie9iaJNxGTahrINUVw6w42Dlw7dL05tDB3SvJ?=
 =?us-ascii?Q?KL8AQCWkeTv0qfP3rpBG4NKfiDS8C76CO78zlcKFmPcF5WtqLw3dZU2FzrsZ?=
 =?us-ascii?Q?dv+FPBdMgG1ZxIFpSvvAzSwcpPD72rdayYrHnSZyxm52NTDDuLa6Tr+25RFu?=
 =?us-ascii?Q?FWr1sBdZplS2zpg1d79nKy7vnEK57YVSt8Ddwg/7VDSOJt6dpvLqgkhpzloi?=
 =?us-ascii?Q?lP/OxUEzV2GPpVMolE8gMStFk0T91sNryBofZv0Zwv16rLhXYtcnnMBSEoJF?=
 =?us-ascii?Q?zT73nNsMEMGCTdS6XObAEmCv4/0pzsFbNr68NZiZuGkxbJQ2cgpKl9p33ifR?=
 =?us-ascii?Q?sldiwl7RRlgh9yxq0rkDFvq6PcSUgQhrK9dtRict/ZuwfVU7DDIvKNMRAMA/?=
 =?us-ascii?Q?uKmKqPAUyF55e0Cc1gFo8LH3crC+PVmg2+kcJZtxV3qDw7vfJkqX02GzggBV?=
 =?us-ascii?Q?ClBJc6Eilmm/h2I/cTNPJ9x2HOUWxflFhGgqeYEeIR1LgIyVhkjxRzge209n?=
 =?us-ascii?Q?c7QHd0qeSVmcPNXb/kuX01lR6XicRDTBDTYtMw7tLn0D4YjXSr6Tz21QI32q?=
 =?us-ascii?Q?TPvGzsKJPAlBnX5kkr1XfPrBdvlhYD++Nfm7iXfHvM0mM8+u+YtB/gdN/jrh?=
 =?us-ascii?Q?Bc4n4cUYH4yIkjMPuak8qvGmktvcg6XAF+Xb2SFD8xLMdfRXnIda25BxFeKY?=
 =?us-ascii?Q?HeFHh3drNNcYiryij2T31G4Q72dD9ESoye1o5dNF1Yx4UMwNN2Vmc9V5xxJs?=
 =?us-ascii?Q?n4A6ghAbb6wV2ARFy5hIJhC6BH3dMM4ckpnq8j1A8sveOE7ZYP92VV5AJQdS?=
 =?us-ascii?Q?vvcbxQ0g3Pnf/ajDe8NSwGuvQxjJiJ8WCFKbJFjPPAwaC/Qs+kST6pY8RpPq?=
 =?us-ascii?Q?Li624xGbueKw1uGZG9RTqo4NFWU9Pv9y2k6I4hSFGlQ2keiLfhr3VZk8E4AC?=
 =?us-ascii?Q?A+G4v0i72s2EKeovQWew8Tx0p7P7FIKz7WUjOmT8suT8KtKny63fmH6fVUSl?=
 =?us-ascii?Q?NqM5X9IkCw2TEW5MR1NB+eEFzusy2OqEzuY9LsRVpY21wwPYxy4GCTTSEvYk?=
 =?us-ascii?Q?UbPfPGy7GMlNy6I9xdtUdYcryQbMapKIjmHGEYyl25lGsEJhKjYnmPFIjwcg?=
 =?us-ascii?Q?od1jssFJNCpsqpnQaYACrd56IVDWrCvweh8cwgup0eD5KKT2ZJq54LxqfcZH?=
 =?us-ascii?Q?ymFkjkEmz9T2bQHs/SLXKJj+JxrOAmZTmq9DoQSY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PciwJhScCr50QcYG+odulvi1j/FMtQfgCsZT7XUy0CU4yEfax0cVTNjPkqMnbp4mI8sobXEWJJMsycB4a/dXwE/t+J7bNX8ZHtL11U+8fJNKNRxgwyZRPdL+kDVXnS19wEst1uhEdR3PpiyYhOeCQHVClQGD1SsFqrTuIjKrSOL9eVZa7Z0jwG0ncitIJBKA3O8kBxy3+phUqCv3KE73YdPUMavMa9Xlcy2CJHHShKf3RssVzc8scRxuzxAxEh5U6g6eqJeNav/RLHuOXL3GjJPSngTvjDPVFiVsd7rDsHEezukuSO2EHiwNi3cziAeDMQiyljP3kpspBtbf/yOZK/S0+cH+8TW7ogbWWEV2sXGVyreVwy3DUGE2Xq4KjAClvpWnem+IcKomzhqcY3DD6301gVxiDDZqQS9s5FeX9qDQ+76199FVytn5oz6R/nxa2mH6KrZ729VLK3bKGr0MH0UiCi6av4AmFChD2Gb3+dfaDarBJmvPVuKJ2XGQJQS16tUj7ASB/uns0By345D8Grz1I1LOCUw4SeCPrGJ727rPjHvNuOMW7WHfKq+jehvYEvFFvrxcyRo/TC/Z8dQTQm5BSW+kIngSlxrCkkTNuiv41uWBsMTDyzIsgjbayCP8HGLeaFGHMxNODXFRTZ3qExxnJOxqcxp4oEOPDsfWtFTzrJf4wgUBOUdqXwRXE5WZwNObMgmvQSGkH706SvmJa6o/vWGFLQ6bq6i4qn8kOl5DDGuPCHnisfUwRPjalWRahtTCaCjWVKpEE7uGOlanIhTlDvHJeYJQzLVpuElJl95mhJ5piNfCys2xY5pQPATpJmwnLdXDa89PZg5V07G1NrxVZrk/dhjZjEpClQmK3nTOWiO1xZovCfFauQvlGspV2IS/axfssoVMbZDNP0wEigfvpw1BipBdx48V+UoICTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b600a300-f072-4817-e962-08dbda18726f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 13:51:13.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzYcTnhWlRwALUAfL+I7k4gAd/0QAdOI2SvyLJO2F6d8/8gwYBsRX0ST6YPFQJ36oZitZ6QHnMScLGu4gu0Mvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310110
X-Proofpoint-GUID: Z9m5LQcRX10bVnQn4GZ8tT52q6VbJ6m4
X-Proofpoint-ORIG-GUID: Z9m5LQcRX10bVnQn4GZ8tT52q6VbJ6m4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Added Michal to the Cc as I'm referencing his patch below.

* gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [231027 08:14]:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 51f625377561e5b167da2db5aafb7ee268f691c5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102704-surrogate-dole-2888@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:

Can we add this patch to the dependency list?  It will allow my patch to
be applied cleanly, and looks like it is close to a valid backport
itself.

e976936cfc66 ("mm/mempolicy: do not duplicate policy if it is not
applicable for set_mempolicy_home_node")

If you don't agree, I can rework my patch to work without it.

Thanks,
Liam

...

> ------------------ original commit in Linus's tree ------------------
> 
> From 51f625377561e5b167da2db5aafb7ee268f691c5 Mon Sep 17 00:00:00 2001
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Date: Thu, 28 Sep 2023 13:24:32 -0400
> Subject: [PATCH] mm/mempolicy: fix set_mempolicy_home_node() previous VMA
>  pointer
> 
> The two users of mbind_range() are expecting that mbind_range() will
> update the pointer to the previous VMA, or return an error.  However,
> set_mempolicy_home_node() does not call mbind_range() if there is no VMA
> policy.  The fix is to update the pointer to the previous VMA prior to
> continuing iterating the VMAs when there is no policy.
> 
> Users may experience a WARN_ON() during VMA policy updates when updating
> a range of VMAs on the home node.
> 
> Link: https://lkml.kernel.org/r/20230928172432.2246534-1-Liam.Howlett@oracle.com
> Link: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
> Fixes: f4e9e0e69468 ("mm/mempolicy: fix use-after-free of VMA iterator")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com/
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f1b00d6ac7ee..29ebf1e7898c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1543,8 +1543,10 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
>  		 * the home node for vmas we already updated before.
>  		 */
>  		old = vma_policy(vma);
> -		if (!old)
> +		if (!old) {
> +			prev = vma;
>  			continue;
> +		}
>  		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
>  			err = -EOPNOTSUPP;
>  			break;
> 
