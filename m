Return-Path: <stable+bounces-93524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9B9CDE62
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980B31F233F7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126493BB22;
	Fri, 15 Nov 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cgfPw3WB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f/9uUNed"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570041BAEDC;
	Fri, 15 Nov 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674338; cv=fail; b=GLLTGJ+xwVXL9AfGfg8dbJTjYprIasEzzKh0ytX6WPbGGIPwPEikel1KnQGc1APEkYsU3C4WajXAQtdIZPblIYq/OkNrd5pNqB3AvvHr3owddPreoJW6inzS9l+ynMjjPo8NVSUwryEcy2pE3caP7ltbpi40PCprujBKRVzp92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674338; c=relaxed/simple;
	bh=fDrKJQ4yOkwcep4Jc1jXIE9umgFQJwHZaKJlPXqgDSM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bT+PiiWOE4uTIIAZWgQHoKcVD/8RtWqFK/kUnHvEORQWHaeOO9C34M6cADx5VFc7qGOnrixJBt/PQJimfj3AXRTKdXz5Dw+KGptkxoYOVPslOT+c/7SvKl45qbWNypKr47qMI6LYLQR86LZG6lMYl4Y2HJgdTdHjorT9qIcVSJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cgfPw3WB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f/9uUNed; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHLAG011157;
	Fri, 15 Nov 2024 12:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=rc3w/L010sIzcPzI
	OS8pzWtE88S6Aocnpx10HyVh/Qc=; b=cgfPw3WBYofArGgITulu9bOof8ZhW8pE
	4HYSxXJn/9Ktb9TMODds5GLNObpujWtNVY0PXw4QTJgPFvRCS1mydMCqn7qoZmkD
	HWosE8i8omHZyFj2ZRbsgPXfHomVDwbDQpyEQKptLifDqwURiAft1WUPOyyKTgZC
	tRIoyWgUpTOOUkWQ4KfZI3gnBJXy1Y+CgGkC9vzME88fc3XSYXqcnKCyCG/8vvxo
	XQ821BlyXrQhiHbul53rjACqVRfjSwmeqN9h4nrRGhiOmFmd+t1nvADHH/3m/iW4
	smr3jcbWo5EDu0KbxB4OlypmPCVIyRWsb37ZEXSP5YfNDoiGV/zt7w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3dbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBUaC6000381;
	Fri, 15 Nov 2024 12:38:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbje5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl4i5lS7Y3qprTJRaCupWguZ0XCyXMN5xrR0s7Ek3oNrt5uABs+z8watCiZwrhw9WFsujqupyW2/g3Cv1pXXv3wyBVxoqBxp0VsSSROxmdsmo1JTTCKhUjTF1MLoFrnsSzYE3p3RwYTL7uR4fJDQJiRt43hi7to+91Y9QH2vN0XYpMeROjxrxxxO9L83YsTCDStLyaXfjjFYajY3t5QcjTm6Vko6NUNU8S+D+psleTyL4/uIov0jJWsVRZUopEDHavXjyc44Eafxi5wGgaWTe27O8LuGfyPpM3TtwSpiubGRdDe932oZ4vbKP4orLeb/iyvuJ7SqAhNBsVRrpkO35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc3w/L010sIzcPzIOS8pzWtE88S6Aocnpx10HyVh/Qc=;
 b=Ynrpw1lJpIMfrbTyUK7+Lc5/E8Jl8XfPSFsBdxEkBz8gYR7seTz3we7uCLZcYK4dRPMWzk4O4iK9VwvRosti0XA1UGQAZspJFJZJ/Zqp5VkRHFFR5amzCs53aQdidw7CvBkj1q4/8b5RhdeU8ora2f+Jgw4MGon3L5QilFPdHrJPk1UuC+q4EBf3kiYylrRaPEeN46Gcz/M7lzVmg1Fd2aZQXtP9ZVqBFKhU5aHaJ9mYBLj0SpE1OmFa3vkPxy17jli8AqRFHwts5hqxZ8+VCD3arB6tZjbaYF0p2JTDJcaRmXpaaBe/ozhPJ8oJLtMH/x0qOed7ZbRCgctYGr+72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc3w/L010sIzcPzIOS8pzWtE88S6Aocnpx10HyVh/Qc=;
 b=f/9uUNedc8P2LBsQ3EYJW289t7WTX6nYUrxSVGDvAR0fU2rd+ceUNnsv9vCEhulR/+m1IYKw/EavkTDXFAsW7mSr0lY0dwAtippW6co878RDeNMcUlsGL3eA9V24jJSB//raqRyAty6MsjNQXYqTvqcLFOzD/8kSKNDAVSlgujM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:38:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:38:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15.y 0/4] fix error handling in mmap_region() and refactor (hotfixes)
Date: Fri, 15 Nov 2024 12:38:12 +0000
Message-ID: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: d89d6eb8-182e-4ea5-267a-08dd05726ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UV8aM7sPdUWsSmYm9zAmou1iyFbChA4cNQbv5zlWpulAerdBIljnsO4CKLPg?=
 =?us-ascii?Q?Pgs54L8VWJj7fPiZCkYuCJnl/bEfRd9c7+8oqqmQSs1e6W3G45VYImpb2Pji?=
 =?us-ascii?Q?e6Ure3nuFrpd3nq//rSKzEXYjf6nLVVlW5wvKWF7vM0qRHc14OI8D/1ei43g?=
 =?us-ascii?Q?rsuA5KefdrtxLp1SGq9o/JFqGKUEChG4NIXx4sARcywvHRMB/mTPqinxxQuk?=
 =?us-ascii?Q?SwfLM6fxltFg025NCG0sA471sR5AxQGTmYZIUhcB+4WAkZPKJrbW4gBRpaZb?=
 =?us-ascii?Q?7PO4kHb5h65mAQhY6R+cN+ibHpXuPDFbPpx3nrvI3FsgE4aCGjVBeD8HExIa?=
 =?us-ascii?Q?/TwPxpGe9pc2dME28IqfywYjrc879Bf90RO1VY1p8WD6lIUPDC9l4MngGcOR?=
 =?us-ascii?Q?PG0uePcx4ENg5PkguV2n8Q8qk/lgyulepf4+HLbASzUA7mvmLyL4JlCOEgHT?=
 =?us-ascii?Q?xKf2zQ6MMIEbUa9BZTDrVE2Q5rv074R+brUlQE9ELUynGRqX3ycI0W9jT6Bx?=
 =?us-ascii?Q?Ms94zaLiBFSFGMuLV1msjgkrbMJHoiviZlhZ/AEEV4tUm7CJa0DoYtnhDdUR?=
 =?us-ascii?Q?KiLVIUtzStl1QxS3iXsGDBn4eBfspJU6gE6E/tOMeN65qvz6GBsxm9XVsiAP?=
 =?us-ascii?Q?+qEvB6+WHDOLRF/mRLizPKHKHUrEYeBJL9tvjLUrQlvivZ8BxPcQwwMhNhpS?=
 =?us-ascii?Q?jtoEiS0GALodpWnhaXPomy2mKcOgD5b9Lz8mRnhHuvh4/OrKj85mZpsP7nUd?=
 =?us-ascii?Q?z0Mwd5btZR29oQZuYMLTuasVCw9eP8fuQPBeIpX4iQVMPceCN/fkXvA9ASQH?=
 =?us-ascii?Q?qFfG2ccy8yByDTf1/7kJYSUACIz7FE86lLg15ZiMcIz2LTF3yixT3Ec2R5qA?=
 =?us-ascii?Q?/LTmgK61IbJD4IVeOSWVz04rOvFSs0r0dnN8mRchigqmxRS6xRJDfRXx9GuK?=
 =?us-ascii?Q?mba6s50M2IZe0TfVz1wqjE9NclGMc/pm7M6kqeIIoSq/nrPfz2BLCrAv4GGI?=
 =?us-ascii?Q?n9MLQUCCJmpjI+fASjUM8YMI5DKX1RhIaOszx+94w7dlPeUtDH1KjKC49z42?=
 =?us-ascii?Q?NV0l8+ZRsaj3Gjkbv/XGNIV7ugI9NLsJUtepMj6m4POjDkTcmJcfj4SBlBhM?=
 =?us-ascii?Q?c6/fbw+KeTWSnl+zUodSVCn3Pf92hpiCKnJOZ77W+XKdrxCthrg3hfGusYFX?=
 =?us-ascii?Q?rJ4z2jmOrQgm0zl8dqjgVYdXN8kvwtIHH3KfXWOh4xElg8e8ZtPhmxrDrms/?=
 =?us-ascii?Q?QocNwFsQe+8jm7fivtw5jyOvfQHLDyVe9kp3ksgK6ZpZezjyxDyqu6XRNti2?=
 =?us-ascii?Q?EUlo+fvEvA0JE+jg3UcUgQf4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G1zlPQo7aWSD9mj3Mn67JULiYFzyEwR4iaRqIt0sLz+Mb2exWJwyMJCXoJ4E?=
 =?us-ascii?Q?hVCEI3f8bCpKiYbmFz93zngG55p1tE6pCKPSflX65tLI6UJg6E7Pn10nyNkG?=
 =?us-ascii?Q?lolQcdSZD8WPulYtBZ9mUaDipHFvO4Z5IxG11VWGcajih+VAjvmrU6C3UEen?=
 =?us-ascii?Q?bmtZjoOZmjVbec7gfq03uVB8FRllGvcxomXMZM5ywKMYzgyLOMCpr779RzQn?=
 =?us-ascii?Q?/5HyFpsMhl7cPYpGyCdRKLmOdaZBnwRmeei/gl2BNnkF7WfILcuONhDOnsrk?=
 =?us-ascii?Q?Izaal3cVWnPMvItLthF3h2Sx1LZRSrzaio56fgWYRoyScK3+9VQP8H9WKI8k?=
 =?us-ascii?Q?GXDRymhlCPDVv29yvEaxkLRKXPyb4dioC4mVYWS9yPkbVRXRqrPuUY02Zws5?=
 =?us-ascii?Q?baYt2bF9EuhAjsLLYtpOra+HXUCJ8txpBrV+s5ZUCJX0C4K6SpM7RE6Zl2U/?=
 =?us-ascii?Q?4NDa4/wg7o+X56SuOyghvX+YZbWt3hUX9uR1b9fWdvN3c/q1WFkFZKbk9CQb?=
 =?us-ascii?Q?r9F/BasdH723sQNCOklIrAZljPqGv6oH0gb846FfDbqKUhZUqqN0MDeXAnER?=
 =?us-ascii?Q?et5ro6PF3RPgCKzKjO20y58KgJG14VIMmFQP3YlB68r1NuFil3EtM/+t91qe?=
 =?us-ascii?Q?k8LZLGN3gM15v8r0HG+/YyGlArIPz6i/zX0jAPSfMpjBib/lIgaM/yFmj2AS?=
 =?us-ascii?Q?Z4K58a4mUbH8u+qJLRraeNpARNV5Y7zYuEM1lC2ZeagWqI9GDh3KqxXUnVti?=
 =?us-ascii?Q?fbn3Cd6XtGm0HNc79DWTS42+3IZWq8PeJmRP2WPOCZz6AID6PSBcTGiqf0A4?=
 =?us-ascii?Q?blcEoXLaxSskf6M3DpgbYlEUtPxLdPpo6d6AerM/50nTX+myxFBU9YOWb4yG?=
 =?us-ascii?Q?J1B7ausbRVzEkYUxiBq1K1t5sE+4tHy+vSWaN9AKYsTmywYC5VsA07IaHfKy?=
 =?us-ascii?Q?/FyZyjlfzoPcJT343ZhCzMLPM6ci/XbeE4Bs88z5FAtnlZ+4zvmVRysxoDX1?=
 =?us-ascii?Q?4BYIphSFcKIiKk6fU6HNqJ+AE7xwZEH01Z6xGAschSRVRBIT6Jg/X37JU4ue?=
 =?us-ascii?Q?uThydG7QlpMY2IU7/rNppmGvOwJiSn+MpsOjJ3YZEy1qvi5PHcDzSkYpDC5z?=
 =?us-ascii?Q?xf0oCMpdWVcGsZ8gufCEP1BRatyuAlvT9FyvpeA2em8elOdU9I/wZ0qYYdHn?=
 =?us-ascii?Q?w45lza4LjYQCgPQp5bEgFgjg7Bdx8cA79USr7PNnia00Mp0U58v2eXWNGzv0?=
 =?us-ascii?Q?jp7uS+JjSCfZlPwk6j9xDOWbuhe1ypreuun9oNYX9pcWFZO+sq3uGk927VUh?=
 =?us-ascii?Q?jmaaIu8aegum2j8mlDBSSROfy+0mRmyOVEjxslDXkZlRr4NSKySFCuRRjBLT?=
 =?us-ascii?Q?cE7rOIR50GIJEeZvLshSS8A69InSJZYITwqla48D+PKilBBxxyU3bhUcSexq?=
 =?us-ascii?Q?B0rDP6SgU6uzK+irW53n4aX055Sgseyq6A5ZQkqbHMwBHviMgwjkfd+d4Khn?=
 =?us-ascii?Q?Hq23J7VONvj9bBZ0Ghqbg57A9dUn35QF5YuS7M1yZwSmpCejBZUT67Rcoj3A?=
 =?us-ascii?Q?55tHv/PLKYbC2+bafQmbTJ0qi2QFmZ4KKxRKqbGq0YM5jY10zTttn7Q2NssH?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5js2Fz3+ofd60HOrDZpv9NWHWWNYWXBlV598aB/mbyVlhmj+01UIQRSZ/bnrHAgDy1iwK2telZw5h++jQA8xEv0fLlyhcPVd0V6iqJPOGK4sWpLAaGWzJ53p7Jo/61gSHk6bYTPapO91UN/u4iwMBdtUvX+9D+/53S7wXZmSYuPfpHSU/d1+tQO8J0YiUGURwcyRh0M0AxjtMl5NAMRsfLg99ahoarInTzBv3I6hFH/XNDdarMb/LDp8rC34J+Q4KTmntNUXb/GWAPKD8VYTZhXC3e+9YsOjwQFJtJfULrh6kZtPJyEoFp74Rhp8QxP6R/xuioFmo3OtV9BXCn+PIYU5p21LFpW5XMvMcDGKtHO6zbDM2NRMd86dRAMm6WKpmJ/mD+JoKJfRlybGdItLYuVYKK4aSnQtDoIUKyde/coWVsha7y4K3v5d8J1Sz7SzKjQ8aJziFX3lQ0czvoEbtYHLDNmpdQOs+XP/Rup6Qc1idPSXLobh9aFe2nZEhQZMB/HEOXMZzVK7zqVZ5rDlvv2xcAU07RcIWDSSNCs7GIgMGYVLXB4AJOLS3gBo5jKWxLJ86cuOFm6yfeToAVYXef5ahYk+sBG6wQqxr04LnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d6eb8-182e-4ea5-267a-08dd05726ad8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:38:33.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5k/TunAlrayXXak/i/WAk7Fnr4FZ0j5aifg4yL4RLxi3bkg4DnLQGkDd4mCQSwABRRW8dJwS0yV4NiR1oeTB/Owy2rS6h/O8SQHA3XkL7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=621 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-GUID: KNGDJIGrubxGPCIZ7j7zTmWqFBVPSt9k
X-Proofpoint-ORIG-GUID: KNGDJIGrubxGPCIZ7j7zTmWqFBVPSt9k

Critical fixes for mmap_region(), backported to 5.15.y.

Some notes on differences from upstream:

* We do NOT take commit 0fb4a7ad270b ("mm: refactor
  map_deny_write_exec()"), as this refactors code only introduced in 6.2.

* We make reference in "mm: refactor arch_calc_vm_flag_bits() and arm64 MTE
  handling" to parisc, but the referenced functionality does not exist in
  this kernel.

* In this kernel is_shared_maywrite() does not exist and the code uses
  VM_SHARED to determine whether mapping_map_writable() /
  mapping_unmap_writable() should be invoked. This backport therefore
  follows suit.

* The vma_dummy_vm_ops static global doesn't exist in this kernel, so we
  use a local static variable in mmap_file() and vma_close().

* Each version of these series is confronted by a slightly different
  mmap_region(), so we must adapt the change for each stable version. The
  approach remains the same throughout, however, and we correctly avoid
  closing the VMA part way through any __mmap_region() operation.

Lorenzo Stoakes (4):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h | 10 ++--
 include/linux/mman.h          |  7 +--
 mm/internal.h                 | 19 ++++++++
 mm/mmap.c                     | 86 +++++++++++++++++++++--------------
 mm/nommu.c                    |  9 ++--
 mm/shmem.c                    |  3 --
 mm/util.c                     | 33 ++++++++++++++
 7 files changed, 119 insertions(+), 48 deletions(-)

--
2.47.0

