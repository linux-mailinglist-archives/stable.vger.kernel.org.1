Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BF77EDC4
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 01:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347145AbjHPXXB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347144AbjHPXWb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 19:22:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30B10C7
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 16:22:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GLEKKd020474;
        Wed, 16 Aug 2023 23:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Nh+NOYlHTkEyR8msLS35ecgubuQUK3YIPUuzu5aMq+s=;
 b=jLnoK8GX06Fs4iqhRWlOzCcpHGWiSv5UN/HhbOEKUgZyN72dckb4hU7qdsmH8ATpvTQR
 CrKK7JGL2SqxXSpx8fdFgbthhFPPlP/QqXFjEfLDQvuwYuqrtsSghSspZwqQpJWKGNBe
 Pf2faYQGRuwXAi6wbsu1EIV2oAiFKpYeeNLMIOBeti0HfdoieMK8XOkMZUI39wKK5JyZ
 NhjDIRWhiAtAQFAKxrmwW3+qDV+ndRNcxFQ7XWxVZpQSnmAsgFAwz5YTNnJ6G6FLsHDs
 WeddOhTrGCDJmCiPWdejehTLfxPeukvVYJsetCEfFupvLkC9mxHPDS8eCHQBR4NyhMdH Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w609u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 23:21:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GN0EAM003676;
        Wed, 16 Aug 2023 23:21:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexykwbje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 23:21:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp6D/nJS0A1xZVbFxvr9w4swnNVbJ+1HAmV/evl3dYqstbF0s1DoSnOaWPP/ir8r43lj9ez+U0LPNr6HFk7ws+CXQIetX0ECQyIVHXVNm9jBrTwlu2jy1B0fYLjDKHwkBNr7O7oV/P3qJUKpYm9q39Urblz5c2RKcYZywfHqhv34hBCVx6UBZthlOxM+oxjxXYrkwRI0e4bG3+d3iflque8qLXSuDIFPtxn6cmlZ1JUYaTgPkO9MPZkcb2lozs2X2/qjf8SNkQRKqr+GTgVwnbpO+mkqzC3HG13/vBheMr9tZzDQLKg7VslUgJVC3X6w9jPFlFKCIa5GExsCW7awww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh+NOYlHTkEyR8msLS35ecgubuQUK3YIPUuzu5aMq+s=;
 b=cGnipy2xvtdELT1QQ7X9F36UcOHmXwmdxylq4bQ9J2/AzHJH7kwdjk/4xnaHJPaASwswwgusKM4P3G2Cjb+TbNQJyWZ7ynwmDsmKKS1j9Zkk3gp0HevG6EGIfWhuZNR2IVlw4CYlqxwYvnptkPbS98ssb8FLVNXlDhM9xwhUC4DGGTe+5bh6RlWJEEmR0DpWE+7IAomH1oCgBeT8hobmVJgdnMJKqdEsbtwBbnnNhmyFFhZDU1JI9RuoRhcTLFnSZM6nmNUWZCKS4tWfjgy/LdAVbLZwKClrO4pVc0fzcHWs8oJ/5bXwja+3NNF5WkfmS+RIdWQj1zwICUkOAruXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh+NOYlHTkEyR8msLS35ecgubuQUK3YIPUuzu5aMq+s=;
 b=vR7COwtEMkM3coLuN32xIQrdIYQIXRNfJLPl28RMdR6kwxrKOc7w+MlqL/ZsYXTzFIgA509PUjzjv4sv/kf5OsfjoameXb1OLiWsDIS+0Fb6RMlpy6P0t6LN/LQLKj+YYAfHpvyCyDxcxGDxUaMKLbuoguHG3y331vgMfIOE9sk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6074.namprd10.prod.outlook.com (2603:10b6:208:3ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 23:21:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 23:21:50 +0000
Date:   Wed, 16 Aug 2023 16:21:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, axelrasmussen@google.com,
        jiaqiyan@google.com, jthoughton@google.com, linmiaohe@huawei.com,
        mhocko@suse.com, naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] hugetlb: do not clear hugetlb dtor until
 allocating vmemmap" failed to apply to 5.15-stable tree
Message-ID: <20230816232147.GA4230@monkey>
References: <2023081206-asleep-slain-4704@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081206-asleep-slain-4704@gregkh>
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf2a885-1e53-4e48-8117-08db9eaf91d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gUw8kACI9BizrF0I1KTR9+KEEPFxcW5oLUOUqz02mUQaJ19qUmi2pl5znxm/C7UMMQj/lGKWiep8hxxTEEuSuV6A8nZ3ndB6JBqTMhsrRg9ADy7A5f8P5oNGBu6dpPZjTj6QQr0ZI/h87yaDLOssiSxwpADgQY6g0ByxFkoxdgKFdqATpju6oO3Fqb47Up4PbpcTTEwyffp/viycJsqtGyNVEQPh+nz3xnTjCAbRUmimmdi2XzceWmn0UoR4PK1ZYm4Vm40DlILBWSD6W3n15zp/wdt1od3JORh6puRtIyRtCnQ0uheI2aC2731hr7R+uo6K5aw0hyf737iKgUXkCoRMuvycy37MhP3hwWMKnX5128A1EthMECmiUbZ2R9wV1tKvQcZlDmyqZoT++Sq7s4SNq0wULJKhP+RTJ1BLTYO1z9DVMQIKZRKg7hx9ciFJPeRihe9SisygyLZKbJpFNGUHEXKCxPbrZw7GCtBvKJtSLF7FWCKlc0QmRqg4sGjaSgLbZK3DKzUpBqmBRRLYXcepLOFWYHDOdKST0I07Jtjxz5dMPUhiVUP7bCsEHz4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(5660300002)(41300700001)(44832011)(38100700002)(8676002)(4326008)(8936002)(33716001)(2906002)(4744005)(26005)(478600001)(7416002)(86362001)(53546011)(9686003)(6512007)(33656002)(6506007)(6666004)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?awd3kdqIpB5+wP+nxMj3CGc2h1koJFD82z8bmsZgf5wq4Ehug3ZFQCWOXqdh?=
 =?us-ascii?Q?u0upGhupH1KwBIogHOaYkUIUGkPYDou66+jxZCttaZc2eOSI9QUWQ9OFkvtH?=
 =?us-ascii?Q?w9nHDI4vNmJ+m914gC9aT13YuQkz9+hGVEFjXqBr7JqX5rbtYH9LrATBlvG2?=
 =?us-ascii?Q?zO4sJbak8ue6RQO18jEMG8iaW7jauzUhS+DsinrN1ndPEZaCb3Qxye9r9fRS?=
 =?us-ascii?Q?j8nnsEoBsXa5M6aged4bWW+2Ye2m70kibTXhGKiA7EUA1Bc8n+MeedGeF9C8?=
 =?us-ascii?Q?lM6K0x+GoyMS/IRO67NdlBlyBEdG0sfq3v5z2Q3ikKJUPtP3BW/NJI39JynA?=
 =?us-ascii?Q?IcupquxdAeZQhVjOC3mGLNjhcuK6dSi9h4PSa+obeuSlFPvRXWndJs6alnFk?=
 =?us-ascii?Q?C1pM95za1+adn+fjXM5L8kW9qQQCL5JGVN1tmxkWoqWQ/AbfLqZIF20JCECF?=
 =?us-ascii?Q?ArJxb900GHfR7ZC29Qm8v1Kzo8wDifBdKr31SVyxJ6cZgjaXm3KZThu23krz?=
 =?us-ascii?Q?ztYTD2tRGQng+F0+iTSJ4fDhwmNtIP26QtavNT6/tzzbiqLVjYmDkmG4E7z3?=
 =?us-ascii?Q?+aAG/X5aYJu8AE3gw8ITlaABDV3dmjw/OOdxP4w1GqiIMvLvo6NT+hXqWHXp?=
 =?us-ascii?Q?bBp8PTn6UhPsAO5NyXC+rw6Qp4bw05T9KsmGKOMKK0/Sd+X3B5+xWjFAG6o8?=
 =?us-ascii?Q?0LFEUzFLd7BIZUPW3BlJwLXbiSMHIEWrGO9SCyvsXvKLjGTTyOB3phwzOFfk?=
 =?us-ascii?Q?lw3kEyyodug3ehpENDOGq0VVo8JVVDZzmRJxYqwjKVG9FLzpmhD6ofoI3CyI?=
 =?us-ascii?Q?5pNTSwbCnYo8FJPEpwxKBpwsPQs0lYEJUFULqWlF2egxARJ0ku76JlRAxz75?=
 =?us-ascii?Q?S9oPYR5AhKYcJQx9P0fjLO6Uwk3eM1X1AP0C0J+R86Rf8exrsftFHsxCvhRd?=
 =?us-ascii?Q?m4Es0N6FR0g9Qw4c9pns0ppt+RJ84P9cPSqO51ZkeMnpJx+ce8Oomi5Cam4h?=
 =?us-ascii?Q?Cyt2zr1vurma1HsST84BFws1MlQCZuazA8YKSc9QTtevv9Vwgyc6ul1oJw0v?=
 =?us-ascii?Q?aRpAgx88z8DNnEqdcDSabOKsw+G3HRkln84ZmdvVDCRLKGLFAZjEb71v52HS?=
 =?us-ascii?Q?ocJ6WUN5MBhcm5/pUl2xiJrefs3O7Qutnbu2ekytJYEG6lunGWdY8XCFBF7F?=
 =?us-ascii?Q?jWx/BuKxH0/dS4sSRx0C/4/6PogJj3IoMPq/dQZNyMd45Xil7dgxB7EdgjnB?=
 =?us-ascii?Q?jI0Uc9jeTiaES63H4MroWQ90PG0E5Q9aooNdRyAxd/ggS/Hz4eSBQrFMPhD4?=
 =?us-ascii?Q?atc3y4d/D2QwVmiLaXLbnELvYx5moHqXrjd8OW4a0ITfsbtJ4eNaYmOi2VHK?=
 =?us-ascii?Q?RBo6q5+qDsS6AV70Yio0LYu+bj3gl3QN+y8lfRcR18UXeIHpreIYSDkiGJG0?=
 =?us-ascii?Q?h+qMcbuuk2MomR85uJG5Kp2JFdUMA5U3rTH0mFb7pPf05IyfZbvq4V0gLCXX?=
 =?us-ascii?Q?ZYEExzV0MYNAgM2j1SDVruuHdiLC6fM4UVd0tzCn+QokJmkU8g55ZQWPK8ZP?=
 =?us-ascii?Q?jYhEeOxAYpvJhh29yKv4Zi+ptp2/7LrmomsXuGUFLjK0XwG1dqhN7jPhIte5?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YRYtjGOCeGQOXf3mmlJpyhFBtDYxD951rgLjgRUsQsBqxJWCr53znt5zGAIC?=
 =?us-ascii?Q?jw6H2SqMaUdVLUObTvRoPCf6HIl3zbPJ2lkTlP03tyXL7j7DZk2VdWlGoucQ?=
 =?us-ascii?Q?BkIiO9O4+svx9xOJdXXTo8F5MwksQEAIsuGK/sbTMDaUTPAh3s2J0MgGbzPc?=
 =?us-ascii?Q?qFLuUU06xfH3uvrmWK7YE9XLUln+bEUE2pXFCBF/cdGFB3nfiP7HA5OjN3zZ?=
 =?us-ascii?Q?+qZQ7lyrvowLFKOUqm08i1AwF8R6/NQbHpHHC9cJstHQHuLbkcI+3Op+U2Db?=
 =?us-ascii?Q?3NvEQnEYlfpq6TiHE+Imb6BGD9tcVghyvcU5C4i/4/vTA6Ism5pzTbMZKfCA?=
 =?us-ascii?Q?YrPkrxptMSC+WpRh/19J++b4gJ3fwCczB/L+N6szeSfgYIdy2jUIHT+j2ujM?=
 =?us-ascii?Q?+aMXr58NOEYxqAvh/tepXf1K5fPwm/XG7qsYhcK3iBseXQ9hNVaIAvUk4wXR?=
 =?us-ascii?Q?00xNQjrxW0/UtCsCfd/zywnSFZMZJjh9TrfEJvUPrtTILROe4i75kIUNLg6a?=
 =?us-ascii?Q?fBaixnp+JeS27i9Sd1JjMR09QXRbSrwiD5451jFKEX2kRxElC8G+1+SatvG0?=
 =?us-ascii?Q?OSoNbW+U7fgtJBP3sGMWX2rX25Lf83TMxL5Fk0o2600Hb/wKsOObnB5SWULv?=
 =?us-ascii?Q?4sZTBx9DdtHaq3ZIjHzzbCjE/uWUdL7ixG077wmCJj1OqaHq3ry/sedniWyp?=
 =?us-ascii?Q?RiKyiwN03zV8M2HqCbtyzeiNcJlbaooQyrEuNr77M7jdvO3sjP5eSHcQ/Lxg?=
 =?us-ascii?Q?0vrhDQ7gzD2h2XNOcDFGYj4Ox0bb7kEAcl18Z0T3NgaGctF6FrG/mHmhtodi?=
 =?us-ascii?Q?jEtvsfPOQ7sk/ah2Ea034ykEuIlevjxW95nuANk9bSF7+zTAS749P+YLDbiu?=
 =?us-ascii?Q?DFZcCuYbvGGZq/SDG1ArB+ut0xa1nP4mHhewg9l1lehjV5YZ3ljZ4rRBM2eC?=
 =?us-ascii?Q?UWJIOY2Sd3oQ5jk2PER3N/jIN2OMrw7u7fA74ngwuS1WT/c/soka5T1Wt38E?=
 =?us-ascii?Q?fRL/8heFPH4sW28Xy2vmRbWNmg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf2a885-1e53-4e48-8117-08db9eaf91d9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:21:50.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+cZG/O7/DrkzxY/5bYcASiM0cL36oi5pwC32R4PkFyw/VRO0eDQItWozv7QmJDCS6QhQs9JZzou5oW2Bt6tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=815 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160207
X-Proofpoint-ORIG-GUID: 58aH-j8xDpg5huSsF7tFVNdmAxfnpIJj
X-Proofpoint-GUID: 58aH-j8xDpg5huSsF7tFVNdmAxfnpIJj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 08/12/23 08:10, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Not really necessary in 5.15-stable.  Why?

Reproducing the issue addressed by this patch depends on commit 161df60e9e89
which introduced support for tracking errors in subpages of a hugetlb page.
This commit is not present in 5.15-stable.
-- 
Mike Kravetz
