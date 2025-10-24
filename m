Return-Path: <stable+bounces-189249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614EC07D59
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 21:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAF3A4E47B0
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B2234C9AD;
	Fri, 24 Oct 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gSHex7UL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J223QYpo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CA34C98F
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332618; cv=fail; b=mP2+DGHMoRbrLblMTZtDAYmgmsjMgrPLSwEoyL3ftFm8xl/ZcAhiUfoqe/hGzc8Ac4u/47i4/LuNvd2dvWqxW0mGrX9j2EMOuFWURNdeR+wEEHky8R5JfgMJ/H6Stvg3rjaKlFYSZ1+Zy8JvH+3fkpf7esWobAdZu+3usWrx09k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332618; c=relaxed/simple;
	bh=XqD69GlXuM2WX8D08HqMA88pqhRBcteqIhmtA481Pmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7/iCBmZ4KFR7lQU1hrXfgtX5G9dK+SVfUt7Ip7JS4OSg4jskohC+cmNWmhrXrst+RHtQTqRKvqNU1jcxtWpiw8S5O7qGeDp/ZVGdlVheXM84rqr/vug587bK5Lfo/I65vD4wI3OWAZRd5hOsUiFb84NugJLvNc6MujwwKPLaFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gSHex7UL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J223QYpo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINGBn019539;
	Fri, 24 Oct 2025 19:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5wctSLnLJ3dUqKeeHDA8jIQYyBJLnGwHLzMAfH9KBK0=; b=
	gSHex7ULj+FdT9cfA3FJKHenZCgIhlF9fkso6FqN5emMeU19JxZx9OgtmDP22mhb
	454LcsIv9EQkIwt4WHq4Iec8+4cpwXfGcOHPspyQjwk7Lbu9puEkXP54oJXcbxgu
	wBSuOIXjqOSn8r1IhUp6oZ76aM/OJFU0LUW89s2+6fkmqDCSwCelY/0Kxd3uoZ3a
	9+PabSK4twPkKM9agSORGPiFPk6lnGlo7RCdaGOQU1W5LavkIgSKWCuyQ0835o4T
	LlsiLqHDy9KECWewaQ8OQQo7jGSSs6jZwuvvWNs+6G0f0mNOkaOKYuk+y7FE3k7B
	ylG9TT9Ryqn1hkWkD1yzEw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstynqgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 19:03:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OH9lGL007644;
	Fri, 24 Oct 2025 19:03:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bghp26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 19:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9O9ETsqCLNW/Wvg1PPUH7EN4WiJuc9mGyVXTjiYzqlS5ragOEKXfdXmTghxaaVDeWy1LVKbczUChfpoesoabzEfU6d6CsQiq5aPhLgps506ZFZDGGOKYlnD02pZ1ITN4ESg+68lhlVkl4jpyd/fnr5Zc9M7WaDwvclMDDpivRph5T4qfQyXgAo1n2+lHXJZKUBECu5LLmVio1hcGAEhWtMDKOfhZItd+Yif9R+vI8Li2o+XUbuE9PbxvaeDZR/541I6OWbQUkSP1lJ4GxX8pvm4AMG6AI1X1Cl50IIRyY13FVu9fn5m4XJIeQ8QJTxy1A5HXVMS6D2PQtP5pLwD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wctSLnLJ3dUqKeeHDA8jIQYyBJLnGwHLzMAfH9KBK0=;
 b=q1U87IvgTdSbGyLU4ZTc6cShR8ZVs2PDt9tzaJL2CQD3a83yry1ASb5ub7+5C3iCT89/SfXpIfhOEmdq9xgOcyGd7AwYkpJTPpMTKzXsdGg4MIkVBLi2DNNb738+cXeQ+mTA1WVYi/+nua45zstCxXME6PA6PzjDjxkz5pAG6M9sm6kT8wFGS4u+ucf0p0z36b+oaXM67f9x18wV0LUI5GvnD/uJModx36Qh8XR6pFKWYzznyNhADBPqThs74XcGCzhsi2soDFwYiK6pMVpRloTqlThoS5rWgQ8+jU7d1F4Gcjl86pA7BchLWh3JjjYFlOSh5gh0h3Tp/89hAd9XlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wctSLnLJ3dUqKeeHDA8jIQYyBJLnGwHLzMAfH9KBK0=;
 b=J223QYpohfS7CWNn9ypViMhWIp/i9llrMG10rljyNcBWcj9+kR3InNaGnIbflFXF9/WaqDMbbqyiXCwaoSo0JAzA4gHzuvWmD42mEYcdpJuIeNnUT+7R4F65Um8k65r8UbxyMESgXoG5fAPVcdmQ1mr9Lo8XEYtpMKNlxqF6FZE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:02:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:02:56 +0000
Date: Fri, 24 Oct 2025 20:02:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        "Uschakow, Stanislav" <suschako@amazon.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Message-ID: <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: db3695dd-1aab-4da1-b209-08de132ff142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDhpMXErK3hzWjZHM2JINzNUSnA0Mzd1UjBRazJEZVF2NU50dFVoenFZVGd6?=
 =?utf-8?B?WmtSTzF3eHA1ckREL1ptQk1yem1tRjF3akNwaEJLRk1OYmRrZmVFNlc3NTM0?=
 =?utf-8?B?dVNaUUdrNzdRRm5mcklzbXd6ZG9LWUVaRUptVDR4eVJQSzlpZEc4eGt0Slk0?=
 =?utf-8?B?YVVYUHlsRWMyMHR6UzloRjRqU0ZIMDlWSGs4NGpSSzI1SE9IK0NteDZaYnBw?=
 =?utf-8?B?WDNUUUdzVkNGQnpiN0x4QzBvZkFWTy9UY0gxMklPQXVQbXBZd2NkQnpSYVRj?=
 =?utf-8?B?WmpkYm83MzBNOWRScS81REwwaHVYVWx1eWl3b0ozTWQ2emFkMkt0YmFFUm4z?=
 =?utf-8?B?Rm9uTS9VZ1NkZ2dLNDRrSFRIdURidVpYaUNuNkZGYnNtdlF2clVDRmc1Tkp4?=
 =?utf-8?B?dGR3OUNiaW9UMy9rQkJxZ2JNUS9MTEdtOXFSeTlSa0hNcWp4bnY1UFNxVnJt?=
 =?utf-8?B?ZVIyUmRZV2hZbjhxREV5SGpEcWQ0bkZseFpkL0xYVXpxOXoxbGdrOFV4WStp?=
 =?utf-8?B?bHdHTkJ6a0JrS2RRNWVvcnV5UzN2TGRjSklkcmFIemhqSUduZG5YL3hiTDJr?=
 =?utf-8?B?WThtRGhWNW92VHBJaTFWK0pxRHdMbzdIcU8xZzZBbGNBMTc0WDA2MXNqYmFu?=
 =?utf-8?B?Z1I4enAzSHhjSGV4a2ErTy9DQlJwY01DNUlkTXJhRTBLUG1EZTdxT05sYTJB?=
 =?utf-8?B?RWJNcVBMVmVwdzNSNUlrRDgyWE51RmhxUEVaejJ3VGc2TUdQaDNXRTZUVWl1?=
 =?utf-8?B?RmhyUHN3N3V1NTJLL2VwaExyTklsY1ZGNkhwTXg1VFJBRGVTSk1aU014d0NS?=
 =?utf-8?B?U3ZiMnFqUDU2UzhiVzRFL0xBendjcE5UNXExWmRnVzByRkZ6Z25Zdm9iQ25W?=
 =?utf-8?B?NUtLbFJLMHk4ZTBIalFXUDBLWXpTc3JVODVUdUt3a0ROZHVWVjJVTnBrU1BS?=
 =?utf-8?B?Ty9kWllDbUJKN2lCdmVva21iRFcyeFJEN0ZDUVdsWndzTFk3WkZPUkREMXJX?=
 =?utf-8?B?bk5NeEFpODNPUGRCT0xCRlpNelEvZGdkRmMzT1NIUzMrb0lZbkxiQW10WVZN?=
 =?utf-8?B?dEovT1p3Njkyc0dhNW1ZNWRtZExRbHVyN010WEdzcjdOME9IY1ByQkVIOU1z?=
 =?utf-8?B?Mlh5aThjaWY0QUx5TmtKcysyL2diTU1nYnBLY3NSYWRtSytVdEJNcUhVNFJ1?=
 =?utf-8?B?NEF1WUNCM29QZHZLbWZPVUR3Zk1MTUtpU3g2VmhXRSszeDZJVjRhdE5NL2Z5?=
 =?utf-8?B?R0hiMVY2enBxdGx6M3cxNG4vcDFCMHM0NzlkdENYQW1sbjBKYzJ4cnlWZXBi?=
 =?utf-8?B?VzdQbW5acWhyR2k5Rlk4T0F1ZWUwbHNsd3ZCL1kyR0tUNkltdEZRTGhLckJT?=
 =?utf-8?B?clpqM1FqMUJia2l0M0o4UG1LalN6c1pZRkZCQVI4YStUZU9TR0lhODdtZ2pF?=
 =?utf-8?B?UTJjWXI2b2YzdWpRODFqSFpNVjJtbWF4T1ZvUWU5QTdmd1F6V0FGQjU2TW9l?=
 =?utf-8?B?WWc2OVZ6VzNsSmJCN1RaR3RaQ0FUdjYzbU5ETS9rRGVUbmR3VndvTHZjcC9Q?=
 =?utf-8?B?ekRkWUNuRHByUWg4ZjNZdVZjV1hRd0pGNXBJZlorSE5EWHB5cGRleUlUY0xP?=
 =?utf-8?B?cVh0Wnl1OXNLQ2RCamwzTVJLQVZLZkN3TFdHajUvckt3MDdLS0p4eHVrN1Fa?=
 =?utf-8?B?Tm9qMFdUenhEVjcyUktoTEVGVEMraFNSOEl4ZEJBZHBLUnJVZzNSVk1WMWhE?=
 =?utf-8?B?NVlTaGNGUXJYM2hseUZCaTYzZUVyeXhhbHB0VnhONHlHSVc1Q2dEbVBVc2E2?=
 =?utf-8?B?aHBVckQ1cmFlMXFMVGNqb1I5VGdTUHlpbTdwd09pdjVCemxrT2NhUXdTR1gy?=
 =?utf-8?B?Q2J6SW1oYUZxcm8wOGlCRUgrNXRxVmR5UVFnYldLNTNjRHRZQlJGbUdYV25P?=
 =?utf-8?Q?HDygv9t5/LrQROft5+0BZQrtFaPo04Fm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?algyV3pmdTdRY3gzSUdKd1F3eGJ3QjJpTzY0OFUxWDBiWHZGcDVrUEdEa1po?=
 =?utf-8?B?L05JM1NpMU5ja2VLV1RyZVd4WkJVL0lsLzZBenRmbzU1eEk4aVZ4NEdJa01W?=
 =?utf-8?B?ZUhDaldQYUREQTlpejRvNm5CMk1HUERZZmdzRnJTVXBic0xDYzZzcU1BNzhJ?=
 =?utf-8?B?cUY2MUphSmVCNisyNmNydmR4MTBaYzVvSGUzRnhaRjcyUFN0MkVOY01nTGNM?=
 =?utf-8?B?TjM4TkUyMHRYQmdtaFRnZy8yT29sZkVCSmlvUklJSXdOangvVS9Bb2FUajJI?=
 =?utf-8?B?NjdMaEVnTlNZTm1RMm1mdWZ5cVh6S285MzMxODRRbFMrVlMwYm5FTGdYZGo0?=
 =?utf-8?B?dlBFb0ttZ1puSUdJakc0THVKSzd3M0tUVWkzclplUUZ3QlJVM1RxSWp3WnQ0?=
 =?utf-8?B?TnVFaFAyVVhlMVF0ajFsZHRRVVVZSFY1elBhTlB3YzNuTHprTDVkL0J1U3hM?=
 =?utf-8?B?WmxxRTllamZhUVFWS0txTW1GNFZPeWtvcGZtTUpsbDhyR1FaL3R0VENBV2xI?=
 =?utf-8?B?MUh0NCtuUzBrWFZzVEp1dlZKRDl1ZFplZ1NGcVBGMVduZ1h1UFBmTWUxL3l4?=
 =?utf-8?B?a0EzbytGSzYxTnBWN1h2eEIrNURsOUh5NjBXTDN6TjRFYVRxVUxHZUhsSHdx?=
 =?utf-8?B?VWEvMFVlelM0UTFadmNUK1VVbHRtQVhqK0doM3RXWDNmeGcxV3BBaytOenQv?=
 =?utf-8?B?WndrSDBIN2N0OVl0b3BMSTF5TVRzRHhrU21WWktWWW1lMGNzTmc3RVhoT3VW?=
 =?utf-8?B?Q2I4ZWQzcmFORTBrQk5pVFlQWXZnZ2JxLzZYanh2cVo3UE5vZkgxR1NhTVZ2?=
 =?utf-8?B?NStaeVhjSnBXMHFnZ0FQRE9NWXlTWUk4Z1pxK3cxNW4yWHJrc2NYc0tYL0pv?=
 =?utf-8?B?YzlmN3c5WFRvY243RS9tZVZtTnQ4UHk4VTVDZDdmdkwxdmV2MUk4Ymg3eWJi?=
 =?utf-8?B?MlBiT1ByUUNjQjhjYWZianFUcWxTMTlDTEpYYmpTV2V0c3JLTll6bUdIZHVx?=
 =?utf-8?B?SVdXd3JYUkVwVkpxaVRQeXZNVlhFRm5CUXlTZTA5RmhWNE9MWlNoK1ViVWFM?=
 =?utf-8?B?dEx0eEdMWHFyNzQ4YmRCOFpyR3IvYWtSOHI3MzlQcGhWUDgwQkJQZUxRd012?=
 =?utf-8?B?UG5CNzRJRDJZN0FSemNUaUcyd3FXbE4yd0hGa25QMTYxM3FMTFd1MWRvMVBa?=
 =?utf-8?B?Zk80K0ZwS3RVNmxaa1hHb3V6NW91cEd3RzIwSXlaUTBGdnZJQmY3S01HazUy?=
 =?utf-8?B?cUJEQXVQZlZuRTJ5UmczUjFvUkorWjVsMyt2eW5kYlMrL05KRy9ITkRxWksz?=
 =?utf-8?B?Q1VnWUJETXYzenNuTFdLVEF5ajRrQiszTnB3VXJMQmFkbTFtWWZ0RFMxdENv?=
 =?utf-8?B?RkRLRm9jY1RjUHFQMExpM0QvelIwVXRDNm5SbklwUTExU3VIalRxbEZVN0s2?=
 =?utf-8?B?UE16R1lQd01iZEkvT2JuS0E4anZsZWsyVUdlZXR2Y05Nek9qdFNndmlraDds?=
 =?utf-8?B?SmpudC82MmdBaEZDR1pOOUMvSytNT213L0NxajVwd3E2TWlvRkZWaGp2NGY2?=
 =?utf-8?B?a1h0WU5ZSGJMNjRKN25WMS9Mdk03Q0UyZTcvTzZPRjEwQzdKb1cxekhHSUVt?=
 =?utf-8?B?TDdTZmdRei9sWUxTMlBpVmhjRmFIR3RZWXEyQUREYXZsSEtIZHZrUU5mcmVU?=
 =?utf-8?B?ekhuMUhYeVNRdnI1MGdmSjJ0MFdHMGJldzNsVlBkT214VExhVHAxQmNSQWU5?=
 =?utf-8?B?OURoQ3NRaTVoSkcvN2xNVk40MzlxdkV5YVJINVRYYTg4R0oybzY2M1c1WUxp?=
 =?utf-8?B?VEtwZE5oamc3Vks1azZBSUIxRjR1WXdwUzBSS1p4YWozcFN6cXk1SWdnVTZF?=
 =?utf-8?B?clVjWjI3YWxheElWcDhrS1pCR0xlOFgyVUx6M25GYWp3YXYreVFjeGVjeGJV?=
 =?utf-8?B?Y3ltZjdaVXUwb2Yxc3Y5QmR2NzlmbzEzUktVYmhrcTM0QXFRY2szdTgwVlZ6?=
 =?utf-8?B?MjRlUE1XYXZRVWJ1cHBNUDVxaG51bzA1blVtMlpKa1IzcDVLa0FEVkZ5SEVX?=
 =?utf-8?B?aHZUY0prNldLNHkxdDY5ekVJODZYZ0I1ZEgwbXNuelVXRndseWllcSs3SDJ1?=
 =?utf-8?B?Nm1nNGMycTRFOURkd1lUdzRsZUVxcWZyTElZekdGSitQODk3RE5oMnlCSzBz?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E1IAuCToF9eLvhOcXu3twk1LHt5glN+Y8ZTp0GimXIh0aMBcr3tZCcFbV5Cy/0auid3ow2Hjk9IPg+ipE02vFnTtJeQzAjavIqqeDu+s483JMYWzwvF3ynKbmlfkZGEoA5QOC8bh0RVVNm4pmcF/K0nUbmsVsP1icnDDwbOyUtKOlXHpkKePMFxVIJicgHu1h+UqP8sxbVFzxXn6Gmxb1aiK5ZaicdOIxVKeODjlHLu96K2veBbUiMWYflwBK0Gr+PGmt/YTt9gxakNKmZsENp+6j/klfgtue+ycw1PYl5nMA+sVgwk7V/2f1en6Id0eYUQ4QvGHzyevditd6aZ4d+xpoM4/XJJNpjvuFBTq3QP6NbS0emNoqb9sPLBDUI74EhjWLZqKNFokfOFxLoqo8DfH03Q/k7Z+74Lj+YZu0eYDsvXS+XQD0oMIr7P0pxy5Ep9T5lSQno2D2tDW7a3HcSAlYoo2Jl92QvHBiVLBogjL7fyiZEbOi67t5jJGxp29XFkdWr/oaaeVCD3feXDB+MqdiukyVDWL+feyTk7Q9HUVHM9YvHjkifoGXhJ4tobblNVIPwprghX6Iu1GSqohodSiDYK7rt7Xf//QwglnyIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3695dd-1aab-4da1-b209-08de132ff142
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 19:02:56.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG1mCDR+f5zFokeBWNMlS7SZiKkhFSvvPYFVoI66+JZE0nl8OCotWWoTsZsLQawSpbAU4w5OmMcXdKlUS/gU5OT3swLn/7KL3+pjzjN4iEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240173
X-Proofpoint-GUID: KioU3MgmiZO-hcFlcT7IEB2CVgOV46Kf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfX4eumv9uNkY1x
 jD+r2ilWjcd77TdvUB012RHm894TS4PZD8l9BmRq2eqXTFK8JOU9SNhp+jpGLMxJ74VYHHS7G8h
 pCEddiI0IK7XR5YAyu70NsINWgBAjk6gm8Lt121U68TbfFcJBDjPcdGFC2Iy+YGIso/NPENdV24
 NNBcedHtEcWfL4RsnRuf/WRiI1rTq9aRBhKhFuOrdQ0oAB1zjsyksF9MyysuPFnAxZ4fNPlb96F
 ZXEYjnhGPJUCLZvKnzr8MBFtVVZS+vVxkGcUXWuFLbEkDQ44WRCS/DYsIgjJGJ1enHdDVkYZlIS
 6PH/Xe38H+CDs6LAT3wtpROSZCndovNi5BcWZeiT/26L7wQfOKG0WaNj3pw3M1vZmMLTRkbJ0w/
 MEvNh3HfSvUfPaVLDe6FWqJWGLbteg==
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68fbcd76 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ul_lXOOEytXGyFneI5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: KioU3MgmiZO-hcFlcT7IEB2CVgOV46Kf

On Fri, Oct 24, 2025 at 08:22:15PM +0200, Jann Horn wrote:
> On Fri, Oct 24, 2025 at 2:25 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Mon, Oct 20, 2025 at 05:33:22PM +0200, Jann Horn wrote:
> > > On Mon, Oct 20, 2025 at 5:01 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > On Thu, Oct 16, 2025 at 08:44:57PM +0200, Jann Horn wrote:
> > > > > 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> > > > > leaving two VMAs VMA1 and VMA2.
> > > > > 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> > > > > example an anonymous private VMA.
> > > >
> > > > Hmm, can it though?
> > > >
> > > > P1 mmap write lock will be held, and VMA lock will be held too for VMA1,
> > > >
> > > > In vms_complete_munmap_vmas(), vms_clear_ptes() will stall on tlb_finish_mmu()
> > > > for IPI-synced architectures, and in that case the unmap won't finish and the
> > > > mmap write lock won't be released so nobody an map a new VMA yet can they?
> > >
> > > Yeah, I think it can't happen on configurations that always use IPI
> > > for TLB synchronization. My patch also doesn't change anything on
> > > those architectures - tlb_remove_table_sync_one() is a no-op on
> > > architectures without CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> >
> > Hmm but in that case wouldn't:
> >
> > tlb_finish_mmu()
> > -> tlb_flush_mmu()
> > -> tlb_flush_mmu_free()
> > -> tlb_table_flush()
>
> And then from there we call tlb_remove_table_free(), which does a
> call_rcu() to tlb_remove_table_rcu(), which will asynchronously run
> later and do __tlb_remove_table_free(), which does
> __tlb_remove_table()?

Yeah my bad!

>
> > -> tlb_remove_table()
>
> I don't see any way we end up in tlb_remove_table() from here.
> tlb_remove_table() is a much higher-level function, we end up there
> from something like pte_free_tlb(). I think you mixed up
> tlb_remove_table_free and tlb_remove_table.

Yeah sorry my mistake you're right!

>
> > -> __tlb_remove_table_one()
>
> Heh, I think you made the same mistake as Linus made years ago when he
> was looking at tlb_remove_table(). In that function, the call to
> tlb_remove_table_one() leading to __tlb_remove_table_one() **is a
> slowpath only taken when memory allocation fails** - it's a fallback
> from the normal path that queues up batch items in (*batch)->tables[]
> (and occasionally calls tlb_table_flush() when it runs out of space in
> there).
>

At least in good company ;)

> > -> tlb_remove_table_sync_one()
> >
> > prevent the unmapping on non-IPI architectures, thereby mitigating the
> > issue?
>
> > Also doesn't CONFIG_MMU_GATHER_RCU_TABLE_FREE imply that RCU is being used
> > for page table teardown whose grace period would be disallowed until
> > gup_fast() finishes and therefore that also mitigate?
>
> I'm not sure I understand your point. CONFIG_MMU_GATHER_RCU_TABLE_FREE
> implies that "Semi RCU" is used to protect page table *freeing*, but
> page table freeing is irrelevant to this bug, and there is no RCU
> delay involved in dropping a reference on a shared hugetlb page table.

It's this step:

5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
example an anonymous private VMA.

But see below, I have had the 'aha' moment... this is really horrible.

Sigh hugetlb...

> "Semi RCU" is not used to protect against page table *reuse* at a
> different address by THP. Also, as explained in the big comment block
> in m/mmu_gather.c, "Semi RCU" doesn't mean RCU is definitely used -
> when memory allocations fail, the __tlb_remove_table_one() fallback
> path, when used on !PT_RECLAIM, will fall back to an IPI broadcast
> followed by directly freeing the page table. RCU is just used as the
> more polite way to do something equivalent to an IPI broadcast (RCU
> will wait for other cores to go through regions where they _could_
> receive an IPI as part of RCU-sched).

I guess for IPI we're ok as _any_ of the TLB flushing will cause a
shootdown + thus delay on GUP-fast.

Are there any scenarios where the shootdown wouldn't happen even for the
IPI case?

>
> But also: At which point would you expect any page table to actually
> be freed, triggering any of this logic? When unmapping VMA1 in step 5,
> I think there might not be any page tables that exist and are fully
> covered by VMA1 (or its adjacent free space, if there is any) so that
> they are eligible to be freed.

Hmmm yeah, ok now I see - the PMD would remain in place throughout, we
don't actually need to free anything, that's the crux of this isn't
it... yikes.

"Initially, we have a hugetlb shared page table covering 1G of
address space which maps hugetlb 2M pages, which is used by two
hugetlb VMAs in different processes (processes P1 and P2)."

"Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
leaving two VMAs VMA1 and VMA2."

So the 1 GB would have to be aligned and (xxx = PUD entry, y = VMA1
entries, z = VMA2 entries)


      PUD
    |-----|
    \     \
    /     /
    \     \      PMD
    /     /    |-----|
    | xxx |--->| y1  |
    /     /    | y2  |
    \     \    | ... |
    /     /    |y255 |
    \     \    |y256 |
    |-----|    | z1  |
	       | z2  |
               | ... |
	       |z255 |
	       |z256 |
	       |-----|

So the hugetlb page sharing stuff defeats all assumptions and
checks... sigh.

>
> > Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?
>
> Because nothing else on that path is guaranteed to send any IPIs
> before the page table becomes reusable in another process.

I feel that David's suggestion of just disallowing the use of shared page
tables like this (I mean really does it actually come up that much?) is the
right one then.

I wonder whether we shouldn't just free the PMD after it becomes unshared?
It's kind of crazy to think we'll allow a reuse like this, it's asking for
trouble.

Moving on to another point:

One point here I'd like to raise - this seems like a 'just so'
scenario. I'm not saying we shouldn't fix it, but we're paying a _very
heavy_ penalty here for a scenario that really does require some unusual
things to happen in GUP fast and an _extremely_ tight and specific window
in which to do it.

Plus isn't it going to be difficult to mediate exactly when an unshare will
happen?

Since you can't pre-empt and IRQs are disabled, to even get the scenario to
happen is surely very very difficult, you really have to have some form of
(para?)virtualisation preemption or a NMI which would have to be very long
lasting (the operations you mention in P2 are hardly small ones) which
seems very very unlikely for an attacker to be able to achieve.

So my question is - would it be reasonable to consider this at the very
least a vanishingly small, 'paranoid' fixup? I think it's telling you
couldn't come up with a repro, and you are usually very good at that :)

Another question, perhaps silly one, is - what is the attack scenario here?
I'm not so familiar with hugetlb page table sharing, but is it in any way
feasible that you'd access another process's mappings? If not, the attack
scenario is that you end up accidentally accessing some other part of the
process's memory (which doesn't seem so bad right?).

Thanks, sorry for all the questions but really want to make sure I
understand what's going on here (and can later extract some of this into
documentation also potentially! :)

Cheers, Lorenzo

