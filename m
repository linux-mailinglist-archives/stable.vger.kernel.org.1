Return-Path: <stable+bounces-158418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFB9AE68C8
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0631C19209F5
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49802D3A9E;
	Tue, 24 Jun 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PVOlBwNK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gXQ5njjj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C2989B4
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775111; cv=fail; b=jwqstlk6t/MyBkGWVk/2CaPABX/Y/zT702n80toG5lcusVzDKYxK9WwuX7c/fsxkoKrGZavWiav43M389OtrZXOVKUkWzqP7ELM2HgtlMeEF3Edn846mvy0FlZF/+gylzzZ8L6PKIlEn5JLojwCHFF5pRb2VlkVMAGaDoHT7oV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775111; c=relaxed/simple;
	bh=IW0rWt5WDZTL5RvUjd0uDfct/BPnf1B/Vpzs4NLZ8DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jyQlobQhuF1srfIIHEb5LZzENn9yT7Zafo6+s3bTBTpETi8DydxadewzlInLAHHVEfKTnkpIZw88pRHoUgVqhGJYo4oAhzUBCa6ss1bnPN7MGS9FEreBsmBQMxL3ZcMKlS50jdTSHksbPfIutjKXGjFBsLbZCiNlB2jwNXSPVbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PVOlBwNK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gXQ5njjj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCiRaY013416;
	Tue, 24 Jun 2025 14:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D57/ooR3zNbNYAOaX+0/tdNKMi4RVbb1vftZuVKUNqU=; b=
	PVOlBwNKn78qZgGUkIlMw322E4/K6Na9h6b9N1++N5p23UFRWY6M0WHP2taXFriW
	s/TInrxET7KGenqh9ERWK2/XATqH7xe8uH2X7djoV5ef+7dbhIqtgv5CXtJFt5tP
	S2oT7Pj+UFAeQsHvRoaxKBA+m3UnrFwk6923KgkEtRtPYU0QCggxzLzBY+QR3q9p
	w8Jtqu3ZCG2/QXzBJi3Ag0RPLV8XuoStOZodqtXIb9xHK84dnDEeApaSO/vjJVdR
	gdae7jdGzybAV4qyQX34WyQyC7jeorNkDRXu8AvMIz+jA3Eu7YE07xlAuY7TSTM/
	uywlXElRSbiGY6kzrP7/4g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumm6y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 14:24:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OEJAWV002342;
	Tue, 24 Jun 2025 14:24:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpd6y8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 14:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bcq/A5xiKq8J4PsBnMU2usOvAiOHTlfDWb5yXLzmqa0Ud+pO0n6o4QmFSqQBLWGdtvMVpNW7tO9sbeny1KBHzrzsUl3Z7kIOWzmUeUUDShucDOK/pzgltS6yxLz444b4RD/40mR4HMdWwyAs9dXHmt8AIgdsX73LGQLsh8WsphxGiy9S0BmAAScjp5x2/3VcCwKDz08Bhup3/H4slq6zQV050fVtXpB+6CSogqKQMEz5cPTlKX277A/Wy9udK9PNgs/ueMH0godi4N1SCcvfrNc2cSbnj3/n6gn0rb2j+FJBf2U3hJ+qGYkG1u/cJly26f/Jy7IKmdzyQI0BZwzrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D57/ooR3zNbNYAOaX+0/tdNKMi4RVbb1vftZuVKUNqU=;
 b=Nlk0Gx3JUXjyqJJwPAww+Qzr+mQ+n2Qj8Es1sqxmh6Og2etTKy7naaDP/yu29ZiguHpDZRrZlVoL4worcPpBW/QeT79D5XUvC7I6l1EC54lwjUBx17Ja+kX4k9VzpzLCPSkdJOL137ZXZimMq0XyNbdtNMMci2X2yimJgDROiRYKDf5GYTN3co0mOp4vol76FVQ1lJLOszJ7chs6Wa7stbzbxM+X7XcSvSJ8OBJ1mTVCzN+qkojcjt/74GHqWFfTZDhjE5/yLNJBwOWHTscnJmfwK0NS/0z2JrmDzJrnRljrOxH0SmpbUOMZEbSopK9KU6slExDrs/jVh8PfbylhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D57/ooR3zNbNYAOaX+0/tdNKMi4RVbb1vftZuVKUNqU=;
 b=gXQ5njjjur6xcjIaQUH/FWYNj1blzFsWLAHfFmOitDw9DOGsk4gHYwBW/ra0uSlnKWAunYTXREffhn2StBwrywdvi9SWEkEvb/BczYNBBWprpO9ybPk50l3WM4UEcJrn0+zsbP/upC7o12qSILiu64G2slEzLpUmjTZoQY4CUXQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5672.namprd10.prod.outlook.com (2603:10b6:a03:3ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 14:24:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 14:24:45 +0000
Date: Tue, 24 Jun 2025 23:24:33 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev,
        oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org,
        oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()y
Message-ID: <aFq1IcKFzZvc5Vp_@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <4f12c217.7a79.197a1070f55.Coremail.00107082@163.com>
 <aFprYu5H_ztouxw2@hyeyoo>
 <23eb5af1.9692.197a145e5c2.Coremail.00107082@163.com>
 <aFqFKLpkfbduVoAy@hyeyoo>
 <f7aa8d6.a294.197a1b22d4e.Coremail.00107082@163.com>
 <2476d504.a5b0.197a214b322.Coremail.00107082@163.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2476d504.a5b0.197a214b322.Coremail.00107082@163.com>
X-ClientProxiedBy: SE2P216CA0034.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f46ddb2-54e6-41f2-fe22-08ddb32ade27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1JqOE9MMGZJOWVKR3Q0VjZBdk1tTXBncXd5NENPcmRXZURkSVh4RE9ydXl0?=
 =?utf-8?B?QUFwKzZyRmVJdlZXNGplenlobDlqRFozR2g2TzJOM0lFV0hCa0JIYmpwWWRq?=
 =?utf-8?B?anlzMzdRZVRqS0Z6VGR2M1BGMFkyaGF2L1F6bS92eUxyVndaLzh5Rktlbmo0?=
 =?utf-8?B?a1VyNDhaem1HR1NCRmphQzBOV00yRXN3TUwvOE9Mc2hMbFZYcTZNb0Y1c1J2?=
 =?utf-8?B?dVVBL1QxMjF3SlV2VUgxV05XakN0SVhGMEZ1WGVSbUQvelhlcWFUZHVRTXRv?=
 =?utf-8?B?UVU1OGFiaFJ4TUVLeUhuTnhrNEJpck92eTVYa0lqQ2VsQk9RQmlJM013b2Zr?=
 =?utf-8?B?ZXpEQnpWYjd4VHl1TFdza29nV1ZoSGtPQkNWNWEyL1NNc1ZiVGcxSkhRQnZz?=
 =?utf-8?B?czNKcmdZTDArNUpsRUcySG5uSldXZnJaK2FKblRDS1VjUTVxSUZCZ0lGckNU?=
 =?utf-8?B?Q1VNejNGa3RDTTlsekM5QTV2cExNZkxqa0txczlkeHNSaUNLUFluOFBIVmNC?=
 =?utf-8?B?TWIvd3hmNHl5QWxqa0JEOUtFNHdKQTl4WThBWVlJdkJveEtSQW51NW9EdThD?=
 =?utf-8?B?dzVzSHMyTmZHeEtTV09xTjJqZkxIMWFhVENkalRxeFlTUllNTy92bnZkVmFi?=
 =?utf-8?B?MDlzQnpxbGNSQ0lSKzJLV0ovM3VaUy9GSmU0aHN6azcwVnFKQjJBWThUd3JU?=
 =?utf-8?B?alhxYTdUM0NnSmlRTUROMFdEOTRKQUVFYmg1ZE9ZNTM2c2NlN3l3NEo5b2Zn?=
 =?utf-8?B?VlJpM3JGWVRzQVEvZGFuYU5ZZFV0MjZFR3VLOU5JKzAxWGYxV3IvK1g4dCti?=
 =?utf-8?B?UjhDMUJlT1FsRFkveHhYRkZjUkdWZHpSVmNWY2x5VDhvRnV0NGc4RVJCbFFI?=
 =?utf-8?B?TlRJcUdlQnhJQ2YzZ3c2Q1BIbnBraTRaQzVlc2dRWXd0dGtHNWdrWHhnNlRk?=
 =?utf-8?B?RnV4NlJmVHRvbXlRQ0FlajM3UzR2N3ZOK0E4S2lPUllhRkN3WVU1UHB5L3VG?=
 =?utf-8?B?ZDR4bGErdG5HTkhNRlR1V3kwb3F4REY2QWRzejB2bEZMNGdKaHAwY0lPU0JC?=
 =?utf-8?B?angxN01kUCsyQzlkbE5kWWNCc2tMV1VyTncyTzB5ME5CY2RUcUJFY0Q4Vit2?=
 =?utf-8?B?dmJYYlZnSm5HOEh3REJ5ODZqVXAxbTRDY05ZVHJFZjByVzFidWtxS2ovMEhH?=
 =?utf-8?B?aDJjU01EVTJaVkxwMTdOTjlZcE9aTWhrY01POHQ4NFBGSkVlY2hPWWphbHRl?=
 =?utf-8?B?SzZnbWRjMTRWdndvdERqTkpzcHMvbmtwTnU4eDEyZ2x2WDRCcEtMdDZTNVZ3?=
 =?utf-8?B?NGhlUWJHb2xLWFFLNEZFbkprSTd3OGZ0Sk1nVVFiNGtiNnVhRWR1WWNLeTMv?=
 =?utf-8?B?aTVGT3VVODRtVTZpRnRCUFIvYXYvaTJUMmUrL29NdERyYTRVTTVYQmNxVUlB?=
 =?utf-8?B?aEs2ZmY0SmZoM1ZLRGU3VC9BdjF5Ti92SW5Pc3g1SDdWbEg4R3RRMGZodlMv?=
 =?utf-8?B?TGhTOThmdkRlanZlYzJqdlA1Y2dheFBGSXdRS0pCZW55V01HVUE5L3I3Y2hz?=
 =?utf-8?B?RnR6aThtQStrMUdtSThIL2hyQ1A2WHBtcjgyTFdqaWtCNi9oenNlcjQxbDB1?=
 =?utf-8?B?NWJjRkd6RjdHWVJwVmNjME5VUlRxbFd4TXUraXRGQmYvVE55b29Ka3liODBh?=
 =?utf-8?B?ejBzSWZyNWdtTFkrK1IrS2IyanN5MG0zS0E2WEVpc1E5eXBTWm5GRjB6YzNU?=
 =?utf-8?B?TEtsbEIrVmJKRHo5VlB0U2Q2OUs2dzU1S1p4Y1hoTmR0SzdHdXNGR2ZIWWds?=
 =?utf-8?B?OVZUbyt0a2k2ZXZReWtOOVFCOFlwa1NXUU0xSEJPM3JtcWdVcjd6bWZibWtM?=
 =?utf-8?B?ZlRVR2l3OHhXS1dlSzViRkRrc1Fob283eGsvczQvK0pkeEFrZlVpNmUwMlhk?=
 =?utf-8?Q?GCefvPPRfB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlWZVBvSWora0JaYk93TFBtR3REZzFac1RQSGdEUDAzemtTOEZiM002ZElr?=
 =?utf-8?B?VlZCR0pMbUVYSTgyZmJTVmRhQi9wK2FudGh2VDNMNkVJc3Q1MW5heGhIN0hm?=
 =?utf-8?B?YXBleHRpRWgyTFNoYzFaL0liT3J1aTFoellRbzM4bFd5T05CRVRkWlE4TnBh?=
 =?utf-8?B?OENRNDBWcWJhaWdPa1ZQbC9HV2JUckJ6dWQwWTFCMEhrQ1FScVVLZ2JkeUlT?=
 =?utf-8?B?a2ljTWtxaENCLzdGd1hnN240Ry96WFhubVNKdC9tM1BvdnpzdFp4d0ZuWmhr?=
 =?utf-8?B?OGV5UDlUZ0g5RzBZeklibHovbW1XbENvSHRqbFBLbm9EYk1ORU5qVGx5bkZM?=
 =?utf-8?B?dVJYK3psM0grNWtnSnRyTFBTK0tRc0hjOGN0MXFPc3d2ZitBdC9KYU1KSFJN?=
 =?utf-8?B?NFF4RVVpdlBhb0M1NkhmQ3dTVzNiRk9YNHE1NG8zVEpxUjljN3g1R2RCRmQx?=
 =?utf-8?B?OFdKcEQ0Y1U1SVIxUmVPS0ZLNEdNNjhmaElSMlBkbGczRk13cHdGWW8wb0dK?=
 =?utf-8?B?QVFmL09ub3FJYk41MmZnTHoydzVETCtYekNyUDhPWmRqS1lKNGlCcGNBSVZC?=
 =?utf-8?B?K1FBSWFTS3pvMjRrRUhBZ3VHZ1FLT0pLRzc4ZWYyNUxyYTdBRUNJb1FneG1p?=
 =?utf-8?B?c0hLdDJjN3FjeU9ua21WbGxXNGFhMlpJQTNQKzlrSmEvUWNubi9Cd2JFVlVU?=
 =?utf-8?B?S0gxVk5KemFHQjBDN0RhM0YvM0R6bFFZSWI5Ujc2RUpDVVAwTFU2cDY4M3ZS?=
 =?utf-8?B?UFlIM0V4S0Y2UTREYVlJdDlqZ3ZWRnBWbHU4c3Y1RThyQy93T0hXU1RuNFNU?=
 =?utf-8?B?d1VRZ2NJZTJNaHFtcEJ2NHFBcHNJQWZKUnJrWW1rQVFWdSs5YkVua2Q4VUxH?=
 =?utf-8?B?cFVxa3lSRkxNdFUreGIvUGVHQUthWTMrbzNQODZIWUptOHJFc1F4N0lzQXBV?=
 =?utf-8?B?QXNQSk8rYWlZazQzVDZzc2Y0dVN5dFJWaEJ0L2F6NFB2MHFZa05ob1p3SXFz?=
 =?utf-8?B?a3VRRzVxa0ZTTTcvb3drUGxwTzhscUFwaHQ1VXRMTTlDU1dlSGI0eG00Wncw?=
 =?utf-8?B?WUsxVjlUTG50cktwNFcyY2VNdmxCbTNZVjd0L3V0MGEzWWZBTVJ0cjZ2YnRF?=
 =?utf-8?B?bktVZUZ0elZsOXFoM0FUcUd2akRTM0UvVlFlOG05MzRROXgvNjNCbHpFbnBI?=
 =?utf-8?B?eDByemNOQWwvc0VLbW5Ia29EZk95M0VSMjQ5TXVwQnVld21oZGJJWjg0dm14?=
 =?utf-8?B?a1pmQThJdVVGYkxyaXhqeEpyT1lhQVlhRUxkQncwdUI4L21tZ2ltQVF5NEVl?=
 =?utf-8?B?MVhNeXdDWDJwOFY5YktHS2wyTlpwc0h0TDRpUDJ3Sk1PTm14bkJqaUVRc0tk?=
 =?utf-8?B?QmkrWS9MakVySXNxbmxsK21nYjB2ZmR0aW1UcXRJdVlLZVpIaExNU0xLYVNh?=
 =?utf-8?B?SUZDVnYzcnZIVGVJSnNqUFN0dW56YWVzcWlmOXlEaDFsM0NVU1BjeXM4V3Ev?=
 =?utf-8?B?bVliQkgzQnJ3M2dPZk9PYXVsZ01MSmpCb1Y5TStDWWlTN1FKV3ZVeUtINElu?=
 =?utf-8?B?R0dNMGRSWFdoL1RNZG9PTC9ySnJCZUxjRW1pU3c1Tis1STJWZmQxYzFoZEw5?=
 =?utf-8?B?dUJ1ei9KRW00Y1RuZU14L2Y4UzNKRnkyMWFETVhpWTdpOFoyL21PY01CVXBu?=
 =?utf-8?B?Q2VEaGpUeWRlQlk1dXlHODMwL2c2dUx1NzAxbmJqRkYvZ1M3NnBaNUpUTkpD?=
 =?utf-8?B?R2RDSm94TU9LZHF1THZUc3d1Z3BFZTRlNlhaSjB6b1h5QU9QbUY4blpwbFpF?=
 =?utf-8?B?SG4vL0NodFduUTJkdWtUeFFWUjhpdENWT3g2ckJzUEpCdkxaQUgrdHpwVGsy?=
 =?utf-8?B?R01QS2U1U1Jjajcvc29SUm9Rc2IvWDh5QlJPSnN6d2tUK0dqd2dRUm1teXRy?=
 =?utf-8?B?dXQ1UFo1Y0FkQ2tIcUdYd2hxL3JjWTU5M3JHVkVaQzBmeE9rYnVodVk4ZWZn?=
 =?utf-8?B?RmV5cUxkbnJTY1lwMWVYRGZtYUQycnNWZ1pTTnBsS1VRdmM1NEJlZTNHSHVr?=
 =?utf-8?B?S1Yzd1dGS1J2cHVzTnBCdDFzMmFyWDRINjZrcW91R0hJTWtnNXZrcHF0enNZ?=
 =?utf-8?Q?8YN2eFNxj3fkUFXgUGegTCOYX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/L6OBTtizUYC8DWM3XAsLsEfrmtOxtlf5cvL76FfmOds36TCr09f1Hp75DzSlyCfSi3UqIZU537Lx7kTobK0Ox/0j3Ouc42aGs8xCxbaAiw9xUEjmROFknYMSrC95+t/RitxYsm7OLIEBtlfz71IO2dQbQhOvcCuB7aFSYhvGkUkbhpD2af9cT0RtybrdegZsMvEfc8gAIv9q1TfbppHHHPFR1rxMiDFS/8H7cEPhcGsM9qTYaWqEccrl2Z9MeBqezO6yyiFB18F9EeWYm9Wm7sJqNYlNXjaqzV61Zw8zAOKRPE/UI1z7ByEbP+GMJmwsFymk9mSAGzeq5rEfD9fhACNDwITucVhAkU0cVWnyIxyivbdM44/Pw0Y83oMBV0udkDEAnShF8Z7Xn8qx9lgd8Y5dEvgQEy2MuqOIRIYaZsKitTOkWBBZ0rMks0jJr4XPc42VrwrxjbHlZ8A0EgeNKguSgfwaG+bWZYIEBfw4RL21rS93v4UQeg48XjIxQGB1CTch1pzDeKX+QH1i7GDlJkeNLqCOdf1sSp7Gp+ZcHPBgYGuSWMABE9rHbXO6XuLSJJIJphMpIwcEoYYCwwtCSlYpibweDYP1tdtPnr1VuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46ddb2-54e6-41f2-fe22-08ddb32ade27
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:24:45.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zKx52eKEKcLXl1uLm5KD4f3Z3yGq1Cu/0yOQK1s2vAM87uDTuduTeaM+Vf+nmyxkEcTshwbWx30CLwbjJPnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240121
X-Proofpoint-ORIG-GUID: kffZY1LUeQNzh3J1foy_5vtLhwnlX3tO
X-Proofpoint-GUID: kffZY1LUeQNzh3J1foy_5vtLhwnlX3tO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEyMCBTYWx0ZWRfX1T7HMMupiiac JjzkSPDH5+QdY01TZzf67X6v5VyWtjf1ZA14ZlaFebldn3oJrN43cma5MEzzdk7Zvl4qwWJ00cN x5YNhUqlYkq1qY7H4yC1CYCeFTHZzcIcFlAgrDET+5h41GXWVxdMuCm5gMyDIprQcAxTqGtoScl
 wMUgf3xiio47/u0avFpupWVUsO0N8Q6dnLPIuhHx2z91DWW8XyFaNrl63GrVz55Wlm7XemCYKGV N6XazLS5mG2YEfccut8tXazMTVQSxmcuU6h9LFQQxWHNOxJkixq0f/i9pxh8VnBa+6KF08a/NQk VQYnRWRxwxPHu9x4+5Ctd6tZqVuHDKLfV0jn4KNN2WPdZds0uFM9icSu6Jipd7DGsaz5XhsRuoP
 /2mshkTXgQxCyep8+8kRM2E7DKlStg8AgKvkRg05bgnjYWL6cL+IRQudCliTucjsxL6JD5dq
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685ab532 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8 a=iJcT_kAduE2njPpQWKwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Tue, Jun 24, 2025 at 09:15:55PM +0800, David Wang wrote:
> 
> At 2025-06-24 19:28:18, "David Wang" <00107082@163.com> wrote:
> >
> >At 2025-06-24 18:59:52, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >>On Tue, Jun 24, 2025 at 05:30:02PM +0800, David Wang wrote:
> >>> 
> >>> At 2025-06-24 17:09:54, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >>> >On Tue, Jun 24, 2025 at 04:21:23PM +0800, David Wang wrote:
> >>> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >>> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >>> >> >even when the alloc_tag_cttype is not allocated because:
> >>> >> >
> >>> >> >  1) alloc tagging is disabled because mem profiling is disabled
> >>> >> >     (!alloc_tag_cttype)
> >>> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> >>> >> >  3) alloc tagging is enabled, but failed initialization
> >>> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >>> >> >
> >>> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >>> >> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >>> >> >
> >>> >> >This leads to a crash on memory allocation failure by attempting to
> >>> >> >acquire a non-existent semaphore:
> >>> >> >
> >>> >> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >>> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >>> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> >>> >> >  Tainted: [D]=DIE
> >>> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >>> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >>> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >>> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >>> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> >>> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> >>> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> >>> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> >>> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> >>> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> >>> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> >>> >> >  Call Trace:
> >>> >> >   <TASK>
> >>> >> >   codetag_trylock_module_list+0xd/0x20
> >>> >> >   alloc_tag_top_users+0x369/0x4b0
> >>> >> >   __show_mem+0x1cd/0x6e0
> >>> >> >   warn_alloc+0x2b1/0x390
> >>> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >>> >> >   alloc_pages_mpol+0x135/0x3e0
> >>> >> >   alloc_slab_page+0x82/0xe0
> >>> >> >   new_slab+0x212/0x240
> >>> >> >   ___slab_alloc+0x82a/0xe00
> >>> >> >   </TASK>
> >>> >> >
> >>> >> >As David Wang points out, this issue became easier to trigger after commit
> >>> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> >>> >> >
> >>> >> >Before the commit, the issue occurred only when it failed to allocate
> >>> >> >and initialize alloc_tag_cttype or if a memory allocation fails before
> >>> >> >alloc_tag_init() is called. After the commit, it can be easily triggered
> >>> >> >when memory profiling is compiled but disabled at boot.
> >>> >> >
> >>> >> >To properly determine whether alloc_tag_init() has been called and
> >>> >> >its data structures initialized, verify that alloc_tag_cttype is a valid
> >>> >> >pointer before acquiring the semaphore. If the variable is NULL or an error
> >>> >> >value, it has not been properly initialized. In such a case, just skip
> >>> >> >and do not attempt to acquire the semaphore.
> >>> >> >
> >>> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >>> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XIWpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdBwKgJ9_Q$ 
> >>> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XIWpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdC-7OiUsg$ 
> >>> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> >>> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> >>> >> >Cc: stable@vger.kernel.org
> >>> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >>> >> >---
> >>> >> >
> >>> >> >@Suren: I did not add another pr_warn() because every error path in
> >>> >> >alloc_tag_init() already has pr_err().
> >>> >> >
> >>> >> >v2 -> v3:
> >>> >> >- Added another Closes: tag (David)
> >>> >> >- Moved the condition into a standalone if block for better readability
> >>> >> >  (Suren)
> >>> >> >- Typo fix (Suren)
> >>> >> >
> >>> >> > lib/alloc_tag.c | 3 +++
> >>> >> > 1 file changed, 3 insertions(+)
> >>> >> >
> >>> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >>> >> >index 41ccfb035b7b..e9b33848700a 100644
> >>> >> >--- a/lib/alloc_tag.c
> >>> >> >+++ b/lib/alloc_tag.c
> >>> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> >>> >> > 	struct codetag_bytes n;
> >>> >> > 	unsigned int i, nr = 0;
> >>> >> > 
> >>> >> >+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >>> >> 
> >>> >> Should a warning  added here? indicating  codetag module not ready yet and the memory failure happened during boot:
> >>> >>  if (mem_profiling_support) pr_warn("...
> >>> >
> >>> >I think you're saying we need to print a warning when alloc tagging
> >>> >can't provide "top users".
> >>> 
> >>> I just meant printing a warning when show_mem is needed before codetag module initialized, 
> >>> as reported in https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!J2waTUro8owaYlpAZJ6fnrHZvcGMbY6qAO5QvvIGZzUv-ryWjCjhO-maTOolfpPvPSr6CpqOgkRalCwJow$ 
> >>> where mem_profiling_support is 1, but alloc_tag_cttype is still NULL.
> >>> This can tell we do have a memory failure during boot before codetag_init, even with memory profiling activated.
> >>
> >>Ok. You didn't mean that.
> >>
> >>But still I think it's better to handle all cases and print distinct
> >>warnings, rather than handling only the specific case where memory profiling
> >>is enabled but not yet initialized.
> >>
> >>Users will want to know why allocation information is not available,
> >>and there can be multiple reasons including the one you mentioned.
> >>
> >>What do you think?
> >
> >I am not sure.... 
> >I think most cases you mentioned is just a pr_info,  those are expected behavior or designed that way.
> >But when  mem_profiling_support==1 && alloc_tag_cttype==NULL, this is an unexpected behavior, which is a pr_warn.
> 
> Put it in a clearer way, so far we have identified two "error" conditions:
> 1.  mem_profiling_support=1 but initialization for alloc_tag_cttype failed,  "alloc_tag_init() already has pr_err()", as you mentioned.

Yes, and this is helpful because it is not expected to fail.

> 2.  mem_profiling_support=1 , but codetag module have not been init yet.  I  suggested adding a pr_warn here.

But in this case, I'm not sure what's the point of the pr_warn() is.
"Memory allocations are not expected fail before alloc_tag_init()"?
That's a weird assumption to write as code. I'd rather handle it
silently without informing the user.

Yes, we've identified the error condition, but it’s not an error anymore
because this patch fixes it. If it's not an error, users don't need to
be aware of the case.

I don't understand what makes this case special that the user needs to
be specifically informed about it, while they aren't informed when
memory allocation info is unavailable for other reasons.
As a user, I only care why there is no memory allocation info available.

-- 
Cheers,
Harry / Hyeonggon

