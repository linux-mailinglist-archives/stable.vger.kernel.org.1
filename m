Return-Path: <stable+bounces-164941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7EDB13B9C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0F4189C2B3
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E5266B41;
	Mon, 28 Jul 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P7QDuz9Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vklKbe65"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F001E379B;
	Mon, 28 Jul 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709943; cv=fail; b=CFvwNg4SgzhkgxYmpdZt4v5CWpa33jK2FNYIsumkoBa1WjqxyuDxBzLuNp92zKehkyNm8olAozOJX0FaTqek5yy+JV0LhdPStuZOlACNA95hsUI//NaPmrPV7mK1jvSTlcDnFfgBfAJwobIhfp0c2RTOfxYufklyhCY9uK14HVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709943; c=relaxed/simple;
	bh=tIY1WlyFUTOqSAcjnnKjm+pfj4GjtT+SUCVuZHI8hR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q7dL1ZBbSFSswkiqGxuf501HO6m2EC4FDkpLSz5WQRCY8acBO3KFglvRizubabz/CGi6QKkzhr+fGhfHQXDQJ9dxs1bOH/gFzDHZi7z9k5+d95zbLhdEWTjeKYMYFHsQtEzZpBku9BPk+o07aQjQZ1+MvpB3vBtJj1iMht4pYew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P7QDuz9Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vklKbe65; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDCETt008889;
	Mon, 28 Jul 2025 13:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hR3jstcD8bTmCOVyYDlRGqpUdkAoP0zCS+BTrpdG8ts=; b=
	P7QDuz9QtSqO2Evr3opi+IDoCwKlKq4zqKUXhg1hbOaChWoN8l8YKAqobr3/2v4p
	Jd34yBCsqvglsXDToxjq8n7cPXzW6MRq/hCvDYk72fr6mWJy7EqsMyYxLTz9tuBe
	+UqCL7Xhg56uXqzffYDlM7M0JnFvtlee5GnIRlgu/BcfxZZ5CqPWinm2S3NcOvLX
	6khxF/pB33rDBlZHJ1wwnqX+WZi6ohVu2EKrqj+88UokiQsageNyza6+a9n/BwKf
	D9wOArgZ7LdwDv3W2la5pkeQ1bmwO2Cr4kDKv5kB3prokhEFRbm7AzTmZlUWUP/l
	gJWa1/tnzz0MJWFxkImUbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wku15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:38:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDLiJx003110;
	Mon, 28 Jul 2025 13:38:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8k8ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 13:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ap7V5BZstR5PqT9bxJ7P/Zw1bgbCZ1qmtUrehqFyV+ik56oa3Bfq+EiOQPQr/gSjPXA9s+WXFcsQgzEyv/DnxRgwEI8b3L+dVgRNWYUEa9I7lBKxRIfMuDILphIvNgIPq9k2OWqpVTOkqzh4tgCdIplocgUAqEzN8z3D5n1212HiT9cLFNZcE+DC3ZlRN5ksAGPh8nOwC7cBPJvnRkOzTVpDY1Y3zgxcbcj8nkIt6adDs554a+AtTd6MM03PUavuTFwa8I9tmWqMYTomE2tJ6RW0OIKv+AqIaArY1XcvIqHMPBFKJ0q9mVxZ75EIYti6tiv0CZRnLiRaAAJIZQD9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR3jstcD8bTmCOVyYDlRGqpUdkAoP0zCS+BTrpdG8ts=;
 b=bIY228Vvj7kDW4m1Xck/Tg1V0yfQ38uw+8lrG7Sq87Bqs9THBu4Zlqj0ameC33duT83jwExXXUkvw0VrUX+fYxLo6ptnymkLq2i56a6oCxUV2uCVnFroR9rtFjcc/+knKVOKBnH5juhHkfLVMu9L0XQBGx/QQEmHx5g2iALfyO6zZWHQPzEmyk1jtQ9GWmms67VyzdMDj7eY5OIbyJo6dGaT+74CCSrK83ZgZL2WOaOIKIry/hQodC+IG9lpFD4cZlWKsc54gRkoBVEeLcrKUnGnjNOsGpZh4M0IfPMMV1Zt847Km+sA8J96D1kV1gCBepkAY0rkcXGbko7eYd9JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR3jstcD8bTmCOVyYDlRGqpUdkAoP0zCS+BTrpdG8ts=;
 b=vklKbe65Si7E7HNx6LMzrly5agA8Et++jsoXx/RgpO6YMwyqxH44JuBnKU7oCaGTjnFHCm4O5US1sYQw1TVQorg3Hypu1qSeOSLfpLkFYmQEzxsFqqCTkvFBmkvp2xHfo7VKlYs1dGqynxUel4lr1kz3g1zuGpvZvnY3TwbRFc0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:38:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:38:37 +0000
Date: Mon, 28 Jul 2025 22:38:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: liqiong <liqiong@nfschina.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aId9V2PrEHCLnpUn@harry>
References: <aIcJdhoSTQlsdR5r@harry>
 <ab080493-10cd-4f3b-8dd3-c67b4955a737@nfschina.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab080493-10cd-4f3b-8dd3-c67b4955a737@nfschina.com>
X-ClientProxiedBy: SEWP216CA0003.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: c06056ad-dba3-4d9f-801f-08ddcddc0e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnVJUTEvTEo1QkNhYnN5dG9pT2FDS0xFazk5V2llUDh3empZYVJ6NkVBZkZi?=
 =?utf-8?B?RWM1ZndUUXlTdG5iWUg3SnNTRUZQOUJ1Zld0WGIvb2R4WEpmY3NFSFRTSVRF?=
 =?utf-8?B?Uk43Q3lPblc2N1FpVHFtOHRRY2xLZ0xhT2VIVnR4OUZ2Y3NWSEFqMS83MUdU?=
 =?utf-8?B?NkwyZmZDR0RtNTNha0JHTFBJcDhMVDNjQ0pFOWdBR1RwQURGMFhVMTVyQWFp?=
 =?utf-8?B?UGt0MlJzTHBWUWs3Z0RWcEIxUkZqSkZWNmVUUDE2MjhOZUg3YzhJNVBFWTkw?=
 =?utf-8?B?L2cvSGM2bjZGUjQyNk1ya09mOW93UE9EQnBVUXFONk5PL2l6V3N5YWlnU0dL?=
 =?utf-8?B?Rmp1TGlaRksrNkppS2IyNS9sN0orTjB1TFNzL1lwUm1RS29mWDBPd0NuLzVv?=
 =?utf-8?B?TW13WWY4Nlo2UEM2M3Y4YmNWc3ZDQVJJREhZdVB6MVFTbjE4em5oVVBuQzMv?=
 =?utf-8?B?bnVsZ3lwdllxVytqdGpBbUZXMHh0bkVSak0rV1JMTFhIZzZmdkdNZFJKWFRm?=
 =?utf-8?B?QXR4ekpLb3VpUGphU2pBTUU4WEg1L0pwbldBUDJHaTJmeDFoRjN5QXhzZ2VL?=
 =?utf-8?B?dXFzLzF6azFzNHpjaWwvS0ZLVldwVnRJNGxJUXpCWHcxZVVuK1pkYkV0VGZ1?=
 =?utf-8?B?b2k4UVhYQXpRSHNKUkg3ZldjR1dUazErdFhRSE1tNktUWEdNTm1lOHBLcUpG?=
 =?utf-8?B?Z3dxTGFYbHh5YUp0eWZCd1RSTlVpMW9XNXZKZG16aFdjSlkrdGZuWGlnRjlP?=
 =?utf-8?B?a3NFbkM4VmtTK012VlBaaG9tV0lSQWR3ZXpNRlJMVGxWVW9pMHhuY1A4ZFlj?=
 =?utf-8?B?L09GcDc0TXJZYTgxekJ4V3pSeW4ra2F4NzNSYk9SZnBIenM1Q3lZcFRuWkR1?=
 =?utf-8?B?d21GRnNNOTNDLytxeDMxYkR6WS90QmRWYkNFVzY4R0x0ME5LTkd2TXovL2p0?=
 =?utf-8?B?SmxqZ3luaUVRSytTMWE0cUpDeWIrcVYrRTZUWisybllvSUlRR0ZveVMxdUlm?=
 =?utf-8?B?YjdRcHlzWU43VC8vaXpMR2lmSGJRa1kxSW1mNlNoeEY1T3M5UURwYVptbjhs?=
 =?utf-8?B?cENGSGNlTUd6T244M3ZBWXJmUXdEVU8wWEFkcUZiSDdrYXVJdk8yanhCMFNl?=
 =?utf-8?B?d0tacitreGYwa2srTXNidUszM1EycjJxbUhCL2NZZFZiV0R0WXJ1UzVUdzIx?=
 =?utf-8?B?aVYzOWwzN3ZKRjRJOW5GN0NTelRGL2xtalo0eFdpbnV3RWJTTFp4Sml2SUZ1?=
 =?utf-8?B?NEswVkZ0elBwb2duZk90UjFZdEh5Vm9BZ2N5bGhSYzBCQ0ZjVmpHYjFqZUNw?=
 =?utf-8?B?ME5ZdHFLR3BmMDFNbEZKTnhIZXg4VmhidmphNzc3cmxxUHpNSjlUVWd6Mnc5?=
 =?utf-8?B?WjZNV01KTjZMcGdYb3FwU1VPVnlVSmZSQXE4NnhWaWtNZEtVWjdUTTBYTmtM?=
 =?utf-8?B?ai9HdTFKb0ZJdjRhcnRyRk9YVlJnd3JzK0JaU1h0WHZuRk9SdU10cUtkTFcw?=
 =?utf-8?B?Z1c5YlBuSDFkVlJBaTVNZGp4amNkc21BUW4wSlRVQlJ1aEl5TmNpSHdmclNF?=
 =?utf-8?B?ZER3VEhNa0luQkxCZW5wWHJkbWZ3WUVZQUVnUnZsTzB0T1cxbE4vZGVjT0NK?=
 =?utf-8?B?OXg4SUlzU1dBWjVFNlBiUDFRREtleEY2Unp6VnRVNFFpdEU4eTF3VUZ4VERz?=
 =?utf-8?B?eG5FQ1dhSlJNYTFGVEVWejBCdmtVK2F0RTZOL3FnSDNya3M0VVZvNytYQjJa?=
 =?utf-8?B?WXhtU2VlV3ZXbHROcEhXdWlZZkExaXkrWnJzZ3RqRFlEZHk4bTA2SmQybitJ?=
 =?utf-8?B?WGwvVmpCWTVtdDBxRDYxS1hHTEM0bEJGekFsSFI4NEpsL0JxbmdnUmNJYWJj?=
 =?utf-8?B?VXRUcURJU1BZVGcxZ21IYTE2SlNQMWVlOXJDSkxtQ0NkSUtHV0lXak53SHJY?=
 =?utf-8?Q?dAMYVoFMYJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnAzKy83cTBMWHJKSkRJcGh4a1JWUU4xSzEyc1NaaE5RdUtpY1VhSzFzdWRi?=
 =?utf-8?B?NTNna2RlWGgxQXJkSVJUQjVhMlh3N2pDYTh1QkJxWjV5bFhnaVRvZWZ4emlh?=
 =?utf-8?B?RnlndzM5MExUdDFvZDFBS3pXT0M1YmNLdUIvQ1VFay9JRndSSW9IT01FVk1O?=
 =?utf-8?B?cWN3Q1ZxS0tWK0g2V1g1dVUzVGZZSDdqOVlkVzg1WEVIYy9VZHhnaVZJNUdi?=
 =?utf-8?B?cmRWbHArR2tKN1FvRyt6cGl2dEQ5cldOdFIyRVk1UUZNaUgvRkpOOGg4aEJR?=
 =?utf-8?B?NWdJcHU5dDJFSFNhckdoK2Q0OEpnV2RFOWN4MXJDbVNNcUc5WmN1cFZ1OFJS?=
 =?utf-8?B?OXZ0L1V3WUZoYkpHUVpNMjVIYW1zQWtkSzdoVjdHMFU4QkVWcTFkeXlCVElU?=
 =?utf-8?B?R2pqT0R5SnpRRDJLcTBvd0pPeTRxOGZISkQzbTZrMmhGQ213UkVFejJQVkJi?=
 =?utf-8?B?YW5LN25tVVRJRGwwYm12cGVHcmk1WEVvdzZUWVVFNTF2ZEVzSUlkb2ZpS3Fy?=
 =?utf-8?B?R2R2MGY5QUZ3djdLMEpoV2tEL1pRY2l6LzUxZmc3dnF4RTdCWitKQWdsdUVu?=
 =?utf-8?B?eVNuQ1FCem10VHRVZWllVXBqUUFLN09aTHJ1WkhRamNpZkVWVGt2TkphSTJB?=
 =?utf-8?B?YmRzRkFKaUdoTnFiTEdSbS9pbEVTWk1SNDZzSGhSSUI5QVVtYzZOZ0JkeWJW?=
 =?utf-8?B?eXB6RjNNM0tVR0pkQk8vNWYrUjZHV2lQaVlVMGtFNkdKcWRRMFBJbkwrakRu?=
 =?utf-8?B?VW5BcS9HeHF5NkhJNElMK1ExQUVRdmZxR0pJaElNZGdDR1FYSVV1RncrWWdw?=
 =?utf-8?B?dnQ5dnVVeXZxQ1Z4ZlNXUGJTeGpMZ3ZwcitlQWJHYS9BbFJ2WmNxamh0c3JN?=
 =?utf-8?B?K2NkSDd1Q004QkQ2ay9kR1FoSUNxd2hHOThGY3Y4V2VDdXNzMkNTbkYwS3oy?=
 =?utf-8?B?dzF5Y2NiZEdnaTV3endDN1R1WkVXaENpdWs5Wm5YVHBPNnZNZGxUUERTWWMz?=
 =?utf-8?B?L2JnMzdiL0Y2VTI4U0FGVlMvUFp4NGx6UTRDZWJ5dXpSa1hBNTh0VlZVUldn?=
 =?utf-8?B?cVNMcFpHdWRDcXNyQ2pmYndhVHA2Y0N2MTNWY2FGUlZRZkhmWlJrUnpYMWs1?=
 =?utf-8?B?aHJScmhIMFBKUXpISEs2Y3BRWUhWOWFjalQrVlpYbkFEM0lIdm9ETlJtZmFh?=
 =?utf-8?B?UjdrL2VKeG4vUkFJMmNxd1lNUlpPKzd5QWwxNDF1aC92REZQbW9MZEQzSlVp?=
 =?utf-8?B?UHV4NlJzaDBEc014SndrSE5ock5LNzE0ejM1U1hqTHcwMmR4aHBYZVEzcERu?=
 =?utf-8?B?LzFyRjlNdEdrZHVuVUpjUnV4NGRndW1jSUl4QUp0SEg1RFAwMjBDd28yV1pM?=
 =?utf-8?B?UElzVldnYjl3R3R5RTJ5amJPUTRDbDFzMUxqRWd4NW9pR1RzM1cxeDVKbGMx?=
 =?utf-8?B?WU9ZeEQ3cGU3bno4NEhoR3pTcXVHMk1reUV6bTR1ZDlHd3RPYWR3RzY5Q1FE?=
 =?utf-8?B?SlB4MDFYWW92YnVRMkxMT0lDdXNaU1FBVGxKZEw5K3RnR2lsR0VBblFVeHFQ?=
 =?utf-8?B?SnJ3bWtocXBJK1NDR1hUSytLM25EOEc5RWZWYnpibTNaMjd3SnBRcXZwRFM4?=
 =?utf-8?B?MktjbjBxcWdRbFR2YkZvUXY1anlobTlnNUFwUmpkRXpVMTFMU0M1ZEZES0x4?=
 =?utf-8?B?d2p6WFdOQzh2MmJlNWVIUHBsUlpweC9PVWFqNmZBbHVqaWJPZGhJVUxOZElj?=
 =?utf-8?B?aWQyVDNCUnFTZzVHd245SkxUVTc4RlZTWFoxWC8yQ2RtOW5GNW5EK1RuTUFw?=
 =?utf-8?B?eHZUOS9WNDJGZHhrSmYzUnM3R01TanBFM0R6Z05EUENCMU9nRm1qaXlPRy81?=
 =?utf-8?B?QkNvdFl4Rm53cEhkNGFGUUJXUm5vaXIxZzhYWDY1a2xlNHU0TlhWWHJkUjBT?=
 =?utf-8?B?QllpSDdkN1FHSlY3d2wvMG9sL0s4cURFMk5hREgrMlZXazh3MUkwLzJSOWhH?=
 =?utf-8?B?bDAzR016MmttcDFjeVFvUmFnekdGZWZxRWxUNzUzK2p4dDZMWkNaUHlDVGFN?=
 =?utf-8?B?S2JHZ3kyOUl1bXFCZTJlQmI5US90ZXhZWVVEK2NQZmZHSFFBWU1WSFRlbjRX?=
 =?utf-8?Q?0FOW0fa4KHMltkM8IeGu/Qo1s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EVH1aa95bmxisuUQ3h9/qM5x958LO+yxCnd9cavjxh6Isl0nTlHM+tOMjO/ddrUa6bYxMrOJt6J0HdLTHMUu3hzEFklSj4uD+Q1Yju8x6FmMe7ViB7kKQCda4WeqnYnDa3Suh1WgwS8Y0fhBRCnWrq60xMRRx3Y+HLD8MGu+X1QTwFYyVsTOa8gzfB48fhtgJoPq9JelOzY2JpoB0Fzqm5QBAB4NOsSoJOtwRqrmqhPKeXVVCNsgR4IVD6bMmXLzdefalC1qzWazHOnhMDNAzrclQwJJzynWeW2+d+zytFGTM54ZMMLn+6ngUyPGWSFWCrfqZFLuhc7d5kW7hih1/maQNco8Te2RHcT1nVipnRZnI8bLbjQXQVJYFFS6lccKoB3iaSFlipdH4QByK241L5rzrwhN6Y0OJijNdA2HoztURUuSkFApxuuYrNa4EPlxH8Cn7GHgqUCiBdF/cQQXWGBGuPlXbM5w9fjDRc3JdrcznOMuQtcjPrxX+SiMAaqPaVpgGBMzfHplKkfz+AUj/emvKuPp1i52Y2fIh68BiAyIPXs+lbd60q+nzEqiNc8MEPTPhRdBfutlAiI0gSbiX+hWmaOt9ZqJ7xd31gfqZzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06056ad-dba3-4d9f-801f-08ddcddc0e22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:38:37.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EX67IQR3Ze/ZXMbjeZ/TO60/6O7f+ubk/OqY6dIkkUF2s1Jj5BUgWG/6VoSXmqbpBy0HT0TdMEpDNwGWIbxbaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280100
X-Proofpoint-ORIG-GUID: kXPusXRqBpJXqMg1QxxJ8qw4Hufaydeo
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=68877d63 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=X7s2YH8SCSdjBrP_NiYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMCBTYWx0ZWRfX8qz4GEJIjH+m
 mDfRmofkZoDqF+X0mhwRRpOOpS7An8QBnPfEAygG5/foWnw8fiLKTl0B+DyKAXEtdlNdVkZZpXD
 O6rTU+2ap3Sb4ymlbCOG3KromJWqcm6p6YzbfrGV2Mp0b4oE0Fdlad2ejvIlP9+YeHnc1ixgXel
 7PT5+PpqgN7UAQZNNr3fVCWSzCSzY8W1KlAXFhOxDZmeTViVWWJ4zOjWc2Gh/yQyI+AidZ4KCGJ
 pjZobJ07aoqIcqCnP33QmXYh/7bTulHbC9Oakhd5w/yM6vbrCGW9c1hftjsk+zyqa1QmaXFrVfh
 MvUwBRzaJEtysfIpIx1E3dNtALoj24TVbqTT5i1aAEu6d/r2xqZnBQutZZw1AruleORUkd49xdx
 XDa56JfYDDueb+TDISTisHaig+1LyCXIOtoZgsb22/Mpk/5YY6+ezshjCLxmiH40KzKDzjqu
X-Proofpoint-GUID: kXPusXRqBpJXqMg1QxxJ8qw4Hufaydeo

On Mon, Jul 28, 2025 at 05:08:57PM +0800, liqiong wrote:
> 
> 
> 在 2025/7/28 13:24, Harry Yoo 写道:
> > On Mon, Jul 28, 2025 at 04:29:22AM +0100, Matthew Wilcox wrote:
> >> On Mon, Jul 28, 2025 at 10:06:42AM +0800, liqiong wrote:
> >>>>> In this case it's an object pointer, not a freelist pointer.
> >>>>> Or am I misunderstanding something?
> >>>> Actually, in alloc_debug_processing() the pointer came from slab->freelist,
> >>>> so I think saying either "invalid freelist pointer" or
> >>>> "invalid object pointer" make sense...
> >>> free_consistency_checks()  has 
> >>>  'slab_err(s, slab, "Invalid object pointer 0x%p", object);'
> >>> Maybe  it is better, alloc_consisency_checks() has the same  message.
> >> No.  Think about it.
> > Haha, since I suggested that change, I feel like I have to rethink it
> > and respond... Maybe I'm wrong again, but I love to be proven wrong :)
> >
> > On second thought,
> >
> > Unlike free_consistency_checks() where an arbitrary address can be
> > passed, alloc_consistency_check() is not passed arbitrary addresses
> > but only addresses from the freelist. So if a pointer is invalid
> > there, it means the freelist pointer is invalid. And in all other
> > parts of slub.c, such cases are described as "Free(list) pointer",
> > or "Freechain" being invalid or corrupted.
> >
> > So to stay consistent "Invalid freelist pointer" would be the right choice :)
> > Sorry for the confusion.
> >
> > Anyway, Li, to make progress on this I think it make sense to start by making
> > object_err() resiliant against invalid pointers (as suggested by Matthew)?
> > If you go down that path, this patch might no longer be required to fix
> > the bug anyway...
> >
> > And the change would be quite small. Most part of print_trailer() is printing
> > metadata and raw content of the object, which is risky when the pointer is
> > invalid. In that case we'd only want to print the address of the invalid
> > pointer and the information about slab (print_slab_info()) and nothing more.
> >
> 
> Got it, I will a v3 patch, changing the message, and keep it simple,
> dropping the comments of object_err(), just fix the issue.

Well, I was saying let's start from making object_err() against wild
pointers [1] per Matthew's suggestion.

And with that this patch won't be necessary to fix the issue and will be
more robust against similar mistakes like this?

[1] https://lore.kernel.org/linux-mm/aIPZXSnkDF5r-PR5@casper.infradead.org

-- 
Cheers,
Harry / Hyeonggon

