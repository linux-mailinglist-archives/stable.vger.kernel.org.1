Return-Path: <stable+bounces-180683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E31B8ACA5
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C6A4E7697
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479ED32143F;
	Fri, 19 Sep 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cg3AyJep";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w9WPPbpa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA112DDA1
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303478; cv=fail; b=WzYYYf7b9LO7Bc0UeBsqL6SST5faLxWUs6ll3xLFGtcLmJcxkzMs+ebRUkJTC8RCoUpI0D4UOu9FsIeYEw7gUmNtPZwirlpZBArqg19nR420cPuRYiP5QsFBb7ptiq5WqsXqxMKJHKmAd9bHpX1BQhTKkbiLOe1dM2nXhb3hm14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303478; c=relaxed/simple;
	bh=83Wlzziu+s4Z0Btg4Z77bru081tp8igi0bNdEFDbDBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAV5ZD4uLMNQHPz4b5w8uFJeh2fAPaM+iB4402STLQ1ICGDnydDiIltOonSKZXBgW97vvM/a6jK7Kgd6stOfmjcLX7lbLW4xim39SotJA8rBe7NAj3TqMF9LYyIc2/J0TXAMN3H3+I/oZicjtOsNLenNtzYJdfzn9mQCjl3FzuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cg3AyJep; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w9WPPbpa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuebv010099;
	Fri, 19 Sep 2025 17:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fBgGMF7BOM7v83l5gXRtlj0el6Lh1sgma0rJlnDznmE=; b=
	cg3AyJeplaleR14hjQE1ZFe9XkzIvA11nOvmH0vviitj9rMdCMQe56moMmjshxaf
	LIRrx8dnty2f1U3/ijTgUymbL9U4OCCJm7OvgAgMLK92Xym+ksl0jCbmjQ7DtnKd
	hSpLBFJSbzqwqwFlAVmuFxTvQJlIBWrEYOgebNPwNWbTZhi5A0Jlkr+uvHKACDso
	f/WW7Hc3bJJgTdFlBeVhI13nPkcL1lSep70OTq1YqenuNuXLrPxgEjMiqFRzZpyR
	ZkRY9ezqckeRHqgVSGK1ywS7ezV5n+fpPNcb0H1HgmK5tXVbyxIixlHD8GanH3Qx
	cqBKCR8jsSLeaqyw9ee06A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb619q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:37:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JG2s3u036871;
	Fri, 19 Sep 2025 17:37:41 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gsuqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfyVR9p7S2YQFZGu+Ghk2pNCXO/JaAX7uyX6VcsRPetI9aKIls3D3Mu7rW9jJaEX8GF+NHYFQn0i8T2wpSMNWiwG8uxOD2O/2XFRNR2g8EBJQk83vCyKyZ8h8khRnl+INJEh7InvDBWDuXweEJ39ZAaw7g84B/qeLTFRgBR1uO/L7HPBigMu6VqEFSZYmopsLJWaJaga9uP9QI+zU+rDIGAR5vfxOTErA/APPM1Iinr8em3+yt79aqQLLxoZsWry/UqHqsududJ6Ouw8XCicERcUnl2HahsQQgDQyTMkzloIUnumAZVcCXMhpy7btCAVRbxJYYhERsVf7IE2pRvSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBgGMF7BOM7v83l5gXRtlj0el6Lh1sgma0rJlnDznmE=;
 b=yXuZe76dndVldO2uM3iW3pqaXft9TpEZBjZTjd4opOgPS3MkBF/ElZChKFEyih2efDXbMYVBAvib7vacFASpNXmirAjCtQSgrf9IX3xTPHSHmXClK+Dcx46E1N+zZGzprG9fgh4jKeelXccF9lsivHmqGdnWAnR7unVcLkJBRleG0Y6g3uZ0a6iVS+45/1RLohht/6z0qAFaFYfjczk81pJ+SM0U7wma9Vc8FTWg1gChOoXYV57aTUNpNUS7x4Ew323k6Op/c9XxUS2lFF4ZZYGxT5eqZPREUJAWel4/+C5ivULTvPmC/ge97CDkTAMPD21FoQ3Y/qIlOQDQezoL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBgGMF7BOM7v83l5gXRtlj0el6Lh1sgma0rJlnDznmE=;
 b=w9WPPbpaBoL3kioir/JeSGPsiIeNjV7hT4UgYkwiN1uYXz0lFvHR8A4YdK5bpY+OINwW8Xo8G+LdLg0Jt+Lslyo3Pbv6CFWGpTeQjlH5kbP+znL1g3potA1apSQ6YpeJQi+Mb7+PvYzrSJ1shLMKi0OGRt367nDb+YExPE71zHI=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by CY5PR10MB5916.namprd10.prod.outlook.com (2603:10b6:930:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 17:37:39 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 17:37:39 +0000
Message-ID: <83e2f3da-4329-4e72-b216-c766d6afb11d@oracle.com>
Date: Fri, 19 Sep 2025 23:07:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report 6.12.y] Probably a problematic stable backport
 commit: 7c62c442b6eb ("x86/vmscape: Enumerate VMSCAPE bug")
To: Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        pawan.kumar.gupta@linux.intel.com, dave.hansen@linux.intel.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sasha Levin <sashal@kernel.org>
References: <915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com>
 <20250919172024.GEaM2Q2Go9RKnb0VYD@fat_crate.local>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250919172024.GEaM2Q2Go9RKnb0VYD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|CY5PR10MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: a659e4fa-c389-404f-db84-08ddf7a33a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZxTmcrVUwySXFHNkRweVk4UG5Jdk1Zb3M2RG45b3VKS0lObVlhNDcrcXda?=
 =?utf-8?B?YUtZRFUxNEJQVzBIYXpQc2RGOGxNZ2FHd01VUzNLclkxUVdWUDFubG5TZHhn?=
 =?utf-8?B?VEZkQTFFK3lxUDQ5RG5XSW9nSXdndUI4bVFZTGt5TkJmVFVYWStkZXBvRmln?=
 =?utf-8?B?ZmNReldMQjB4RGxrZWZwVVFYS3VlQnI4b2R2dkQ1b291OUk3Wi9teFhQZkt1?=
 =?utf-8?B?ZkdnY1JvVDJiYWwxWXQ5b1prZ1N2Z2RVYVp1SFAvd1FwT2tGRkRSaGdrS2ZM?=
 =?utf-8?B?MGpBZnovZW8vWUJ0LzgzWmUrajNGWWU0cFBodzJVNUE1WjdyMUxkU0h2Zmww?=
 =?utf-8?B?Q1RmSjNoSUo3U3BKc1FJTG0vS2d5WHhFcjZsaUlDNnNmQzQxeEVmRG96R0Rr?=
 =?utf-8?B?S1drT3ZlTDBya3RDL2pxdXY1QlpLbzVxOHZJZDgyNGd0M3JoMmNsYmdGRHlM?=
 =?utf-8?B?U0crT0x4S3BsWCtIbXJ4aDIvMVRWcU0zdk4zbmFKZjBSZ2ZZeGJNbWxIaVoz?=
 =?utf-8?B?UFZsaFBGQTFiS1h5T0VFTXNiUGtiY1NjemNEUXJCZU16T0l0VHZZaWdxdXQv?=
 =?utf-8?B?VWh4L0NMVzVBYXM5UXBnd0o2UDhLTkNqbnFkOExidDA1cFEvVkRrRGVlMlNJ?=
 =?utf-8?B?OTRJOXhFSytFVGkxNitpRHJXSDkwVE53MXhsOEluY2d6SVRLeDlieHk3bVNS?=
 =?utf-8?B?QkNQY24yR3pxTGJJd1ExY0YxckQ1YXh6ZVBrcGhIcnJMWG9RRHJGZHl0NkVv?=
 =?utf-8?B?ZlpXclVWMXFNcWszSTJOakNHbG16MlB3Ulh0QUE4STcyV3NWY0lYTUV3bk9a?=
 =?utf-8?B?TlcycEowam54aFBtL3BGZkRtMkRhL010TGhqUWdtT09KWnNIdWV4RFdXWG1O?=
 =?utf-8?B?N3dRM3IvMUFLT09wSk5BVTZxMUVVZjVYei9Gck9sb0JUQks5YUxPb3ozYjBy?=
 =?utf-8?B?S3dScXptb2JrN1BTUFdPK3FwcmhkUWJRNUM3MGIwcTZPTU5ZM1ZqQTFSQnJD?=
 =?utf-8?B?Uk9XNHRhVU1SeEV5LzJkMVlkYXhOd3plWW1tSXRNenZLbUZrSzI4TXozdjds?=
 =?utf-8?B?anpaQUZ0Szk4Q0N4RDJrSFdtOGZrT1FFZVpoeUljdXgxMUVXeDFMMWlTektm?=
 =?utf-8?B?MDZ4RHUzYU5TVk5SSnY2cy9KSDdZNGxraXNmSEN0eGdyOGREYVdoN3I1azZo?=
 =?utf-8?B?K3hHL1V1MndaTi9JSFEvVFJyUy8xeXI2VDI3Z3ovYTVDbE1wNGFMQXcxeWtL?=
 =?utf-8?B?SjZSMUtMeVBPTjNlMFlqay9Na2EvTmhLcmVFa1lDck0zZmx2dytCWjdYTlZu?=
 =?utf-8?B?alMwZ1BPcXE4L05aYWRmSm9OSDg3WmkvdmFhMEEyVHhoeVRzZlF1YkdsNmFY?=
 =?utf-8?B?RndDWFpXaEpCamRRN3EvWThLb1FTM3BvY3drNFF5TmJkMWdmU0VqdVZWL1lN?=
 =?utf-8?B?OTd1Y09PUnRSdFhzUTc1OVlkU01KaXdPend5alE4MTJ3TS9ZaFZZZzFmNm5q?=
 =?utf-8?B?R1NwWlNMNDNnWTl1dWMwc1Z1dit6SGxiNGllNXhBWXVsMk9HdUtrbXpPZVk5?=
 =?utf-8?B?MWh6bG9QREpTUEY2RThnUksybnBBQVdCemE2S2dNWTh3N0w4NUV1U0ZmdXZw?=
 =?utf-8?B?UytYMjR2L2FnTU90dVJCTU5qaFZjcGw1VHNiMmNBRjBtNXp6a1VnZ043cTlQ?=
 =?utf-8?B?TDJxY3pnZjZXQlR5d0Q4TnRwYS8xcTdoT1lmdVF4dCtMdHVSdDY1K0VtZVlk?=
 =?utf-8?B?SkdSR3J0TEg2bHRhdi96S0xMR3M5UmJWc01rUHUxYUMzeXBjOHBBUGc5dDls?=
 =?utf-8?Q?u34C9ASmR8yJbW4k+X2dnZ0ykOyRcsNYReFLs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2o2VmZvNWo4Y0cvNnJweTFXTmorN0wvdzNOSlFYSjU2Vm9oTldiTHc5dnhC?=
 =?utf-8?B?U0htYXhRYThxUml5dVl3aWgwT0tZS3pZOCtZVFAzbzA3a2dSSUY5VEdBcUZ3?=
 =?utf-8?B?dE1jend1bGkyNFdaZXZwdmdLZEg2cDdVcnFsOXBEbkhZWUozTTBnWVY1eHBv?=
 =?utf-8?B?RHRTUlZhdjM1UmZvYUtSMTBhS0ZXOGl1T1E1QXJVemJtd3FOU3dLckozYjZ5?=
 =?utf-8?B?aTZJWEtVTVR6Ty9TMkt6K0NmNHZyR1pjTFRzb1B4dHRlRzZCUGZ6L0NobkZ2?=
 =?utf-8?B?WGNDWjdITDNUeFphZnVKbGxiSTNvd2txcDh1SnE1MzBkQm9NN0xWekVoWHFh?=
 =?utf-8?B?YktoNEhtVkxsdUY3WE1ZckJkRmU1OGM0RlhXOTE0SHJrc3ZBL0x4aE56VmY2?=
 =?utf-8?B?dWZoM1A2OFY2eUdGTml2NmUxT2IwcFo0eXYxNFZmb3VBUTA2eUExWlVpQS9l?=
 =?utf-8?B?UHZrVVlsN1RPdHFwNlFDSE1oOXBOdlI3L1dvUWs4dG94c2pOazRXOTFpTzRp?=
 =?utf-8?B?RHd6TCtFUjQrOTl2UTZCY29xbTZaQ2htSDhjTHl0VUduMHBtYnlwUzF4QWsr?=
 =?utf-8?B?dmVtZVFSOUZGNEIwU3UwUjlXUWJ3WE9GdDZNNjhOeFFEUENqbnFuTmZBamhU?=
 =?utf-8?B?MGY5djNXekZCQ3pNazc0am1mYVVPekpidEJiVDkrTUFLZGJMYWE3ek9xOFk2?=
 =?utf-8?B?cUZlTTYzOVkzcnc5TkhhVVQrWmwvWlhUUU0rSWJOWWFuSm93ZXRQenF3MTln?=
 =?utf-8?B?bEllekdZVHhqbXV2K2dxZXNSYytDUUVRYkhmWThvQVd0NEMzcmp6M1hyVVpp?=
 =?utf-8?B?MGtvT2lIbnZjWXRWOVFmNGJCa0ZkNHM2elhaM3BtWmRBKy91TGw2alRjcU42?=
 =?utf-8?B?Q0tlQm14ckNLV045NCsweDB5aUkvZjNWU3NOaXJOaXN3OHdQNktVaEhmN3E1?=
 =?utf-8?B?YXJsM1Rsa3UyRjRuZTJsWVBvS1k1Rks5MHN0bUN4OGYvS1V2S04ycXpEOXZQ?=
 =?utf-8?B?aDY1Z2FHZGFyQ21VVlNGUWEzQXg1S0J1RFBrVmhaaEgvempnS05JcHZqYndE?=
 =?utf-8?B?SmlqVmptZUoxSk5RN25jOEhNckR1MVBES2p2VU4yUFNoMFJuSjY5bnhqZkxl?=
 =?utf-8?B?V1BaRWFrR3ltRkpzUk9GZ2hOVGpWQWN2LzlteHltQUUyakpwTWFua3IrenVz?=
 =?utf-8?B?NHQwd2FzZllnWU5lM3RxUzAvTElRKy95QnlxSG4vMGJOZmx6SmRxZzFWVGF3?=
 =?utf-8?B?MVRqNzZKcE95U05sSGRVeW1zTDV2UC9hbjV0M3JLZDRPaEFsSXpudGNTQjkx?=
 =?utf-8?B?Nm1lT0RROG1USEZXdzZvK2FkSGdhaFoxS1JnOUNabFBvSVVnRWpua2tqR000?=
 =?utf-8?B?UTl3R0dUcFFWOXg5VUV2Z29hazlQOXpxTExTUitFREdCWEVTU1l5MUhVbU1u?=
 =?utf-8?B?cEVtRzk0N3FUVE1hOW9RNE5XcXBzNEhCdzhZZDlKQlB0dCtuQnJyVEdob0Rt?=
 =?utf-8?B?dnc5eUFaWk9KZTBDMVhwbG9IQkNycHVKV1EyNXV1WWFHWUIwSHRXTElsNDRI?=
 =?utf-8?B?U3BRWUpkWmswTDE3cWVmSXlXTHo0SDlUa1B3S3ZEYk13dTc2ZTVFYWFoNmZM?=
 =?utf-8?B?U0JIamM3by9kbG9LMFUyYytweEdxazRTRDVOQUJXR29memUraVpvcUU3ZWc0?=
 =?utf-8?B?cURWWHZ6Z3NQU1d0NU51UUxoSVg2WXROMmdBc2VYU1hoanVKTm9jWTBrc2FL?=
 =?utf-8?B?NXQ1Sm5aSDZHNEZaZVpXc2tPK01UU2dWdkN2V1BwYi9IMHlFSVVNLzRydVhQ?=
 =?utf-8?B?QkpKTkZDWTVPYVRnNmJVbENGb2V5T1BaeVRDRDM5a1FlTVZ1NjljT0lBbytn?=
 =?utf-8?B?MklSRmZScU8xNDBVWCt4bzR3ZDFqZ2xMTExxdzRBRjJiT3hISDFyUHM0aEh0?=
 =?utf-8?B?amthc3k4Q2p1YU1Ia013L3dzeFp3bkhnRk9ZT3g5M1ZENkk3N0RobGxyYVNS?=
 =?utf-8?B?R3BpYjdIcktmcmVWelBBSGxYNDhVRVBjdUxtaVY0ZW10bU5LVXZjN1M4R1FL?=
 =?utf-8?B?ME5GbWVNOUVLKzhlZnNSS1NqSW9lQk01UUxzRWpQRG5ybUxRNkhSTWZEOHp5?=
 =?utf-8?B?UENOR29mQk42OXpZcjZjd1hYUVh4S2w5YkFBVUtaRFNERXZkMXlQbXhxQ1da?=
 =?utf-8?Q?sKxIlGHnYOtMMRohTsLNw8g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4p+lw2+o3a1y/sVOZ5E6nPEkHIFCr9MbNPFVIh7J0mrjrQ0KO8WIBi3FcmHWhBrZtG5uXFtTtyjKvqwlne/bM5AyjVyCq9uPCFuvNMIxb3H3PG8x31PdYLwziTs+eS4x9xitNbiGCDkEIrqgwLRf9xBueHKMAu+fw8bj8FHFW5epUVk5E44KwDpvJiBPXQt+WeJd/UOCdJ8ljtqzYjKFdVPLM3UpyC0xPlY3EQjTuMISA28yys1oZnR7Gz9tIxSOBg4Jb4LtxLLDl7Piz12HOzRWSjKOK0b4T8O4cnV/riV/DhiF2sofL5JfsEjmTz2izKpg8tgjSVYjeXQ/Ivb+hOozxdMHccw6w87E0BDe7K+idJyDa9f/0LiH5vBgFEtANbgZcnPsPXwLhMv2cE3p5nU0dg/m5jzIHqFXcI24kxSAPga+pSsmK53TLG6Lz4FgU/cJMhiy51TDDd3N7L04zY3bYeat8SxFbZE2sXIkWlxN79i+lhLuLkfo94pkNquJGYaanrwKhzdYVS+HxKo2XXFYrYf5QZnonvxL6iANE4YoL+x3mnBOjWlp5EISiz1wAm6z8vHeHwUbfZAF5KChy83pgZYUOWbKpGX44Ssqsoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a659e4fa-c389-404f-db84-08ddf7a33a67
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 17:37:39.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGt3IR3aQcPLsOfFSC9JQ8YjmjCwc2AxRnbMyRXEB/qTFuWW31GQrrtMwgAi3iSBlpaTIXPy148OBjJmnXWuSrFeTU7nH8PIH12qdiqndAYMK5YHmScnsKIZ6sNvERI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyBKL70RxNGT4
 VPIVdXwJ0GmtCHPnq/dUMIrisc6Pb20yG4T9P0RYPwMyiDF3f6JgRnO6Vd/ZDYpASiUh8axZ1Kj
 iKVXuQZyQmVbdtoK1rkZq22y75GMb+adqM5PYHc5Vi4sk5slUx1X0mPS0MsRyq/oG6ZpmcRgpGX
 K53zg5E0BF6EUOumK0c2qM4ro5NNYFFnz19/81F63odiqlnk9fOd39U/7BkBuPXLn2tt5HxoirY
 lsIoqyJeleiBSQ7oza6wqqcqjkPc4kvzbCjKjiHsGH27sTYLaWC2pTrZ0EMi5JvZDr4M6UAKwaa
 gSKahoxYfi6LslclCi+Iv3qwmQsdR/jamJxQmVo+tVb1uJJj2JOYENwKbRXId6kh5Sgnp4XlBkJ
 hllrEKNJaSfv2TyKwZTnoslW3athZw==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd94e7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=YSYilPy2o_cHgRVWeGYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: 0-QA14ZB60RcWxlqIH8J5L6FKz2I5o34
X-Proofpoint-ORIG-GUID: 0-QA14ZB60RcWxlqIH8J5L6FKz2I5o34

Hi Greg and Borislav,

On 19/09/25 22:50, Borislav Petkov wrote:
> On Fri, Sep 19, 2025 at 10:42:33PM +0530, Harshit Mogalapalli wrote:
>> Notice the part where VULNBL_AMD(0x1a, SRSO | VMSCAPE) is added, 6.12.y
>> doesn't have commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO
>> support") so I think we shouldn't be adding VULNBL_AMD(0x1a, SRSO | VMSCAPE)
>> directly.
> Whoops.
> 
>> I can send my backports to stable if this looks good. Thoughts ?
> Sounds about right.
> 

Thanks for checking.

Backports sent now: 
https://lore.kernel.org/all/20250919173300.2508056-1-harshit.m.mogalapalli@oracle.com/


> I wonder what else is missing in 6.12 for Turin though...

Thanks,
Harshit

