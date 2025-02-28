Return-Path: <stable+bounces-119875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387DA48D18
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 01:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA31692DB
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364F17E0;
	Fri, 28 Feb 2025 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqH3dlMb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xspWTb+d"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE53AD21
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701747; cv=fail; b=k1sl6ME9cCqNe7e4sSIJSpNS3EQp3qWi2BXHehXu9SLlfbhXBtVugaeJB38qDsbZQufRfwO9RPqO0fpbunQj6DQuDburCjJEATI+g1YgvbVwf/XQQqsWw2kAJQILU/vUfLrztkiwiZ+drngJ3BmhJcGZ1n1x53kTMqFhL0W0/c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701747; c=relaxed/simple;
	bh=BP04W9SLdvfvrgK0DDY0eeyoSJmQk/yGbJS2IxhIOoY=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=XhlJqOifGb3tnfB5TyuQ3mgFjUcaCFAFZU6xsOrfQ8GwnXak1oqt1cTpekHPXJT2sotnTiGF7VswfKTecPLVSOUfAwsX3cs7gYrIQ4mJCimphuS/6ntZbvYvbXtGdpXjeEsyr8HcaQM/hqXoOSxuqtjxAbk5IdTUTpz1A0in8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IqH3dlMb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xspWTb+d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMSlB7022100;
	Fri, 28 Feb 2025 00:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZfjD3t/OQJzviuHrMeOHRECMNCHGHNe2SpAYlWmIvrc=; b=
	IqH3dlMbhAvXaDBaPKiRiniTYiFiXfl9iT6Z/ST70Uwvz2GUNJ9jZylqpJcy81Rl
	hZYUmyAiBFUxDT8aBEALFwxVoEVOT5feXFTm1rQ/WJ3RzYVvFMs0wBmuUPPv/C7/
	r5LZ4R5Opqdcs4Z5b1Z5e8GS2YxMDOqLK+PW0OdZzLdGGJPmCX+8SoQeLKc2zKXN
	QCF52g6Z8IXbGZAD2nTdz8aMNbh7KoxE+QF6dBhDgkjXXNCuVOJgh8GyBp8pgghy
	odstZwO6sT16bv8aNy7WnUs45M2e5cMr3zSbAFuBfxFa07HfAPvZrosmt5Fq+sw5
	//Qx7x3r2ovFRL/yWwaukA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4n3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 00:15:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMNcNE010205;
	Fri, 28 Feb 2025 00:15:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cmd0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 00:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRO88jzS5S951/hrwbskCfsx3pwQRj9zUMcKAoNwrqPQX+ubRTocaqzfOGIxD1G3nBH920saqkpZQIobGlDHlm2fHXsVq/JNFoMzzeBtaL3zpmVBNSQm2DPY0UCtgnDGKtyyg4L2L06YlSHYV2k4okRQsLEkMSEUoM+xiEngPc8haJbDmomGPl9SE/h0QgZEITEE4irp6h/ZppsdDN5yUYp+s2JpQVQIYHwfmw6G+ItQV7geqgKH/LyCayKrSrJ9RdbESUvepe/WOchjxzZVLd64WJNZV/Z76/9uc00y1bPCa5lRw899Nkiz8XFMQcQL8ki+sIXbSWxxnr6Iqo9cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfjD3t/OQJzviuHrMeOHRECMNCHGHNe2SpAYlWmIvrc=;
 b=gqEipwiFZLoSkkHJOV8qVcFcrzLqR7Ll3HOZ4kJWEu8bYTv8L4irJHNAGZzM97cBvjAa/NPn9z8BG6hAKCofaab8RRTfRqyUT2bmML76lmYmUhM4XBQsJlZKDmWG7C6tPXcGnnlD97TVpOcKGDUiOiuRAKRIdIPaG8aufYUHG7j6aS5tXYlvotlEWC/g5tBBZMLJxv2OOO4NmEcUT/AQ6WbgbBc0SpVZSOKNXc5nxy6hb3cyuHx6In+GG6xghDE3dBKnQrBRNFE6xexQBoqghhMoENvymDAbODABO58KzQBbkuE6tnIVFPEe9pPiyaeRRaTsL2Ng4z6rRTaIr2Y4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfjD3t/OQJzviuHrMeOHRECMNCHGHNe2SpAYlWmIvrc=;
 b=xspWTb+dqwk4QLun/BeKLnLs5kNSyHr/R5JYVIHHHGuGp7EWpw8J0RzmmTh7gFwau0Aq3+bwLWRiGxrWofYivcH3iHs9EU4UlRW49UYJICAMeyfpLMbHx7/5HUwjqg5qUjw5MU4E9eVRklW/sVvPeluuYDWvcnVn4NVwlF1ogvg=
Received: from CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22)
 by DS0PR10MB7051.namprd10.prod.outlook.com (2603:10b6:8:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 00:15:38 +0000
Received: from CY8PR10MB6707.namprd10.prod.outlook.com
 ([fe80::ccf3:1df:e15d:7465]) by CY8PR10MB6707.namprd10.prod.outlook.com
 ([fe80::ccf3:1df:e15d:7465%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:15:38 +0000
Message-ID: <a2ba70ad-2901-4ccb-8fa2-15ba22149b30@oracle.com>
Date: Thu, 27 Feb 2025 16:15:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 5.10.y 5.4.y] ima: Fix use-after-free on
 a dentry's dname.name
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250207153807-cbaef3f86e33ff05@stable.kernel.org>
Content-Language: en-US
From: samasth.norway.ananda@oracle.com
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20250207153807-cbaef3f86e33ff05@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:408:fd::28) To CY8PR10MB6707.namprd10.prod.outlook.com
 (2603:10b6:930:93::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6707:EE_|DS0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: e98754c8-ead0-4cf9-9965-08dd578d0750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVlPU3dCUm9yYlNGbDJLYllrc21EejlSL3VlQTBsOTU0MzNNOGpvRG1qMmw5?=
 =?utf-8?B?dHdkYWVCenFrOU5vWTg0NzRhSFFzRGZXNWhEQVZWdlJhRHF1WWRXa1g0L0pn?=
 =?utf-8?B?b3g1R1A3dlYwWEFMaFNnZFlQQ2t1QkU2eElGRnZuRjRxeEwvQkoyOEx2YVlp?=
 =?utf-8?B?cU1CQ1pXbmdQYW1ncEI4V3Z6bWNSTElqTG14Z040c2tEOS9KTklJb1dWd2hF?=
 =?utf-8?B?dWI0ZjMzeVRWSUFtVVVuZUd1VW8vWWZ6YllRNlo3WDlmODFCa0poejNyUHhj?=
 =?utf-8?B?QlFRLzVoWUN3NGVTcWFlakN1YUZsQ2ZFMXBwSjE0YTdtMTBseU1BZDlBTnFU?=
 =?utf-8?B?M0cxeGpGSnZNejVHTWl3WUl5eWs3dFBNbGd3NmZWKzc4ak11Uy8vSzVnajZs?=
 =?utf-8?B?OVR0U2lUblZEc080Uy95ZEZhNnZ3U283OTVoWVM0bFBPL2RteFZqSHVUZFNH?=
 =?utf-8?B?MlIyV082YlRTc2pDczdUejEzRVVveVk4SjF6RFcrTEl5UXpUWk84ZzBsdUtF?=
 =?utf-8?B?SkJLK1VBZzJiNUphN0l4VEp2TGJROUNYS1VuSzRoNXZxSkc2VEE3NEdHT2xS?=
 =?utf-8?B?S3J3RWdDaGVnNHFXdklLcmRJR0ZhK2NuT0N3NldNQXF6MXEzWTdndXN0S2s3?=
 =?utf-8?B?Zkx0Y1BFMFN4OVA3WFJSdEt3eHpkaFRzT1NWakx3TWF6LzMvNW4zYm9KbWsy?=
 =?utf-8?B?c1hBeUVqQ0ZXQjd2MFBMYU8zSk1xN09VN3lUbE5EZGlOV1JCd3M5N3lsZWth?=
 =?utf-8?B?SVhSVjFPaG9LN2hPaTZxcmliT09jRGg2SzlOVFFhYU04WEFINzYveHRyeDZs?=
 =?utf-8?B?TG4yUlpCaTRNOGQ0RWRnSjFSR3dxU0NVRXFsSXM4NWhISGdXOG4xVTU3c2JT?=
 =?utf-8?B?TVVJOUZ5RDRjQXdhVjBaV0lNTndQSWxqYnc0U0ZLWDlOdVBiTHFSL1ZrTzY4?=
 =?utf-8?B?bkZHSlVoRy9FelVQRjVsMG5sbmprai94VytyRS8xb3F1azE4ZDM3NklCVHBv?=
 =?utf-8?B?c3haRk1GaDBEZUJLVUZIdEhIaWdTS2sxUlBMTmJYMm1RVUFuclRZWmdvenF3?=
 =?utf-8?B?VDJkRm9jdGRmL1dUc0RBMnBjQkZwNmdWb0Fad3dYYW1PVWYrQlN6YmcwZVVl?=
 =?utf-8?B?dVlnRG4wQUpROWVDNVpseXVseEdpcGppVUtnRHR2Y2o3TTFVWUZRczlybmNz?=
 =?utf-8?B?WjhPQnAzR2VId2I5bVVhdWNLaStiRHJWcUpmUTY5djI2dXJFS0FDTGQ3Lzcz?=
 =?utf-8?B?Qi9DN3IzMXR4SVViazBlVGlTMnk2d29XVWZzWFZlaDFXZ0FHNldTaHlvMW4w?=
 =?utf-8?B?RDlKZTRORTh4UkFnUW85WXVkaEZBREVhbTlaZVduSVo3U1ZueVd0NnJpSWlv?=
 =?utf-8?B?clBTTG1mUTduKzE3b0w2UXprdjk4a3ZidzFSMzFaWlB4TmpmVVhrVmd6S3Bu?=
 =?utf-8?B?eTZFbThqQWIvQjByNVV3ZkFiVHU1R3hSMjZUM3BxOWg2dEJ6YXZOcFE0TkVy?=
 =?utf-8?B?dVNwSkxXYzh6RGhHT1F2QXFFSnBSR0dSUjRoTlFkQ0JVU3ZEQkZLejJzcHVo?=
 =?utf-8?B?SXlERkxaRzN3QWJ1clZ1RHM5bERpQ0JxUkUxcjIrRUMxYVErbStGaE1xeHhO?=
 =?utf-8?B?eUdZelhXdlNtbHpnYm1WdTJaMUh2WjdjajBmeEZyM1FSb2p4UlFwUER5bWhu?=
 =?utf-8?B?bE82TUlEaWh3LzBYUEZwQllVS3JXZ2grWUd3amtzUTViMzlpUXRORy9hRmRL?=
 =?utf-8?B?aGNuZkw0V2dqV21icU9RdmtSUkF5a01mQmQ3Z1JreXdrZXFZYzErQ2p1K25N?=
 =?utf-8?B?d3Y3VGV6dEl3MTNTUDBuMU9iamdOMWUwaExYV29NZzZ3Y0ZFVnpNWE1CNTlP?=
 =?utf-8?Q?pIHjmcT+Y4vZJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6707.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1JPSlJMaWN3SWRZaFdRT3prTnM3Qkt0TmNVZUdoNkVHakVIbU8xZnBMbjkw?=
 =?utf-8?B?NWRWZFE1QmdCaVdnOGNqeHhqL3ZwQjcxOWN4NnRtMXFCVXI0OGlzNnU0enY5?=
 =?utf-8?B?UERnTkEyL3Y1U1dPTXBzdGZrNWI3WkgxUzIxbU8yZWVWQlcwdEFPQzdlbHg5?=
 =?utf-8?B?VGdUSzBZNVFrTld6aEs5QzRaZzRObUx4NzdHZHpVYUVsR090cndOUGRZWWpV?=
 =?utf-8?B?VmpKZmtxSE1MNEg2MjNvZmZHcDVDcjV4Lzg2Qlc5d3J6aUNwOE9wSk91THpV?=
 =?utf-8?B?cmVGTTlGYlI1aTdlVGpUMit6QnJwMk8ySTQyUWM2eWpiZWFjWkRRWDgwdVJX?=
 =?utf-8?B?d29IbjR6cXV6eStSb2NsWll1Q05QWVd6SmJIZTZaaGxlM1lSTW0waGtLTU1h?=
 =?utf-8?B?TjFKbUNxdkV0MVhIZWhDSklvQWx5TE4ydXIwaWdRa0tQdFhMMlRCY0l3ZnBj?=
 =?utf-8?B?ZWpCWnBDUzVFUmtyVmEyYjBtZDZFZ0YveDgxOHFTbUU3NVJSUExxcGhtL3hX?=
 =?utf-8?B?QjMwRElTZXBuL0xJZG9tSS8wNjd3YjJrZnp0QnorZ3RldkszYlVlQmtVdjlh?=
 =?utf-8?B?OG9WUkxSRGhHZC9HajhpRU8zRjYzMUtKSE5KMk1HdnJXZG5MU1IxNVNHV29C?=
 =?utf-8?B?ZUJkTW9CZlRqMmo1M3IvQjJWdk5hUzNQWU01TWpnMU1NS1o1eS9ZV3VyclAy?=
 =?utf-8?B?NFNicHpsc3BzY0kvS1ZuTXhRZGY4K1IvV3ZLcmVCMjZIRlZORkJzY2gxNWI2?=
 =?utf-8?B?TjUzUjI2eFhIRzhxcHFLU1M2T1VRZURucUpsUUp5NkRwTldwaHFlaS9PTmZZ?=
 =?utf-8?B?ZVpzVlZvWE1CcFdEcmJPcW04L0tPNTFvWnF0RWlMT20rL2p0bStObUVQV0w3?=
 =?utf-8?B?Q3BhZ2IrQXF2cHNtZXF2cGRDd2NYWjRuZE5ORnQwakVFOUJhZGdIRWkvUU45?=
 =?utf-8?B?RGd3RHUydWlycjdKZG9wOHNBdTJyR3ZuZlg3a0ZRdE5aOE9JV1ZoWU9aSUJv?=
 =?utf-8?B?NGxpSG82bXJNdE9tRFNUZCsycGlHZzBMdHVBRG1Bem1MWXdwL0hBRmkrcGZR?=
 =?utf-8?B?VGVDZWxQS3ZVaEJHalA0S21Jdng1ejZQSHZqdzRvNThJVFBEVUhTTDF5a2Vm?=
 =?utf-8?B?dXpuekIvT3FOZ0djMXpqeEpRalpzK3djaXBOWFp1L05DVWJVTzVzcmRYSG5q?=
 =?utf-8?B?VkNBY2RFenM5alhmYlRXVVJmWGRubWE0b3MyRDgvZ244R0RmVWNhTkMyc2dI?=
 =?utf-8?B?alcwRUJsY3NLelZ6UWJKMTBRWkwyWnhsZ3pyYkkxQnRYd0tsRnNyak1yQ3BZ?=
 =?utf-8?B?OTNRN0hTU1FCN09PamFTWmxjb1gyTDJLcW15VC9FV09wR1JETHgrQjAvWVli?=
 =?utf-8?B?M3EyQkVqZ2tFY1hpcE1RZ1crZ05HOUNKY3R5WHJpajY2QTlkY2Evb1dDVXd6?=
 =?utf-8?B?UlVFYWdWZ3dyK0VhaWk4Y2tGMUdLNEFIQlc4T3R0VnhvQVY1WTZNVXAzVXZD?=
 =?utf-8?B?cEJuSllCRUpJK0tlUER2amR0QXcxRFNoTFhYYm5SMUowQ0hNcTBObjBodkFM?=
 =?utf-8?B?QmpaREJqR3JzeGNCZUVvWDB1YlBJVjg5Q0QvL2VheE5XN09mZG1WNXV2ZWRq?=
 =?utf-8?B?bnF1dzJuTTEzWEw4MGUrc0dENkVrZjg4OElWUTlRaEhKRHRGNjlOODVKemk0?=
 =?utf-8?B?NlZiV0tGZEZFc2RMdG5maWFmVGNlUVJGZHJyczdyZDlldlJGclp0Y1RBU2NO?=
 =?utf-8?B?ZWRLZG9lQ1VZdkdyeFhueEg1cS91a05JNkVBL09rd1BuSHhBb1FWQmhpWWlF?=
 =?utf-8?B?ZFRoaWxPemF4blNFZm9sUThWUnducTg0K3AyMkdXMUZTSWtmQ2dYc0lzdE9u?=
 =?utf-8?B?V2lwc3pNRUhic3F1bklRM0wrM29xQTBYZDdtNE1tUmlUbUZTREUwL2xnL3ls?=
 =?utf-8?B?RWxCbUhVTnBReXcxMkF6cE5qa1Awb0tnVkw3ekh4bXE5NHlJOGE0NXVNamRC?=
 =?utf-8?B?bEp6ZHR3Mmp5VTVJTzlFbzBXa1lNTTlTb2ZpdEFwVnRHUitzNkw2Q2pRelVP?=
 =?utf-8?B?S21wMWJOdFR4NlZoV1g2STFEcmR3NVlMZ2FTV1NLSERpekJaaXkvZytGSDF1?=
 =?utf-8?B?MnMxaWx6UkZld3JCOXhVejYrN29nWTY2T1BwVzcxYmtMaW01NHQyMTNTQ0FU?=
 =?utf-8?Q?fcQzGkFGScdV33km6gyxOkE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jWyEFVI/eSVWMZUUlGxajPA6I7GniNm/hRysZp4VI5itpbML4hsJabODmwkfH7bVsHE0K4SsiTSV+86CPXoUGDn4GOx/yGJ5VNqR4qnZS6/6msAhKoGHx016XkVwf2uK0pKXWpYetxSG5JmHhNaMMWykujIfhTHig8CmTpIgfeMynn2a8i64H3cUT361wMJ5It2rZc2PBc8KPmxs4f/aA6TG/5ek+HS/cvHlbfZ8vYjY1J/AzSUb7CMeYpGgF19/XAnlxwWaGu+tD0oaMJn7qGcWh+trBiXhe3iavPtw2TJwPXwnrSt7ode/bp6SjvMS8vRLxAJCYfxV8aDyzMXzXIz0b/PxpFkO1Ze5LIxZeCaP9ACguo4C7/Zd9hu5x5BvZxGKssECKV7MQuJx6IJwnEbzBPdH2RmGSzyAWTNcngCEcerUHMEE8IufxS9XjMixZyCdDKS1TkNLHUZtWVVuPcV3SZKudOmEUbn0+v5/JxH4SIvYEKphfDq+O7crQWbUGcVDm8A7ecoCvzAmDpGGtXoas7sSNEgYnsC6/z4ap7pudm8u/tSxe/BOeDDWm5FY5tm76iY8+U+S8hxQobHZ//XUDJecwlGBydRw5JIeFjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98754c8-ead0-4cf9-9965-08dd578d0750
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6707.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:15:38.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P8XyAqn7k9PJTBtoe6iYD7JFd9MNql0qBXleu06mK9tBPlS4ECef9944H37lq/ngsytogdlf4vBecMEn51e/a6D4dZLfeg2sEMp+sV+nkotWmOllOmDv+SPy+M/75YW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280000
X-Proofpoint-ORIG-GUID: wT_todT-9-NdtlGk5gEtG_wvHiPmPtdJ
X-Proofpoint-GUID: wT_todT-9-NdtlGk5gEtG_wvHiPmPtdJ



On 2/7/25 2:50 PM, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> The upstream commit SHA1 provided is correct: be84f32bb2c981ca670922e047cdde1488b233de
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Samasth Norway Ananda<samasth.norway.ananda@oracle.com>
> Commit author: Stefan Berger<stefanb@linux.ibm.com>
> 
> 
> Status in newer kernel trees:
> 6.13.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (different SHA1: dd431c3ac1fc)
> 6.1.y | Present (different SHA1: 7fb374981e31)
> 5.15.y | Present (different SHA1: 0b31e28fbd77)
> 5.10.y | Not found
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  be84f32bb2c98 ! 1:  9c2a49b3571f9 ima: Fix use-after-free on a dentry's dname.name
>      @@ Metadata
>        ## Commit message ##
>           ima: Fix use-after-free on a dentry's dname.name
>       
>      +    [ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]
>      +
>           ->d_name.name can change on rename and the earlier value can be freed;
>           there are conditions sufficient to stabilize it (->d_lock on dentry,
>           ->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
>      @@ Commit message
>           Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>           Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>           Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>      +    [Samasth: bp to fix CVE-2024-39494; Minor conflict resolved due to code
>      +    context change]
>      +    Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>       
>        ## security/integrity/ima/ima_api.c ##
>      -@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>      +@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct integrity_iint_cache *iint,
>        	const char *audit_cause = "failed";
>        	struct inode *inode = file_inode(file);
>        	struct inode *real_inode = d_real_inode(file_dentry(file));
>       -	const char *filename = file->f_path.dentry->d_name.name;
>      - 	struct ima_max_digest_data hash;
>       +	struct name_snapshot filename;
>      - 	struct kstat stat;
>        	int result = 0;
>        	int length;
>      -@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>      + 	void *tmpbuf;
>      +@@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct integrity_iint_cache *iint,
>        		if (file->f_flags & O_DIRECT)
>        			audit_cause = "failed(directio)";
>        
>      @@ security/integrity/ima/ima_api.c: int ima_collect_measurement(struct ima_iint_ca
>        	}
>        	return result;
>        }
>      -@@ security/integrity/ima/ima_api.c: void ima_audit_measurement(struct ima_iint_cache *iint,
>      +@@ security/integrity/ima/ima_api.c: void ima_audit_measurement(struct integrity_iint_cache *iint,
>         */
>        const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
>        {
>      @@ security/integrity/ima/ima_api.c: const char *ima_d_path(const struct path *path
>        	}
>        
>        	if (!pathname) {
>      --		strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
>      +-		strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
>       +		take_dentry_name_snapshot(&filename, path->dentry);
>       +		strscpy(namebuf, filename.name.name, NAME_MAX);
>       +		release_dentry_name_snapshot(&filename);
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.10.y       |  Success    |  Success   |
> | stable/linux-5.4.y        |  Success    |  Failed    |
> 
> Build Errors:
> Build error for stable/linux-5.4.y:
>      arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x1e1: stack state mismatch: cfa1=7+56 cfa2=7+40
>      arch/x86/kvm/vmx/vmenter.o: warning: objtool: __vmx_vcpu_run()+0x12a: return with modified stack frame
>      In file included from ./include/linux/list.h:9,
>                       from ./include/linux/kobject.h:19,
>                       from ./include/linux/of.h:17,
>                       from ./include/linux/clk-provider.h:9,
>                       from drivers/clk/qcom/clk-rpmh.c:6:
>      drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
>      ./include/linux/kernel.h:843:43: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>        843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>            |                                           ^~
>      ./include/linux/kernel.h:857:18: note: in expansion of macro '__typecheck'
>        857 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>            |                  ^~~~~~~~~~~
>      ./include/linux/kernel.h:867:31: note: in expansion of macro '__safe_cmp'
>        867 |         __builtin_choose_expr(__safe_cmp(x, y), \
>            |                               ^~~~~~~~~~
>      ./include/linux/kernel.h:876:25: note: in expansion of macro '__careful_cmp'
>        876 | #define min(x, y)       __careful_cmp(x, y, <)
>            |                         ^~~~~~~~~~~~~
>      drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
>        273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
>            |                     ^~~
>      In file included from ./include/linux/vmalloc.h:11,
>                       from ./include/asm-generic/io.h:887,
>                       from ./arch/x86/include/asm/io.h:380,
>                       from ./arch/x86/include/asm/realmode.h:15,
>                       from ./arch/x86/include/asm/acpi.h:16,
>                       from ./arch/x86/include/asm/fixmap.h:29,
>                       from ./arch/x86/include/asm/apic.h:11,
>                       from ./arch/x86/include/asm/smp.h:13,
>                       from ./arch/x86/include/asm/mmzone_64.h:11,
>                       from ./arch/x86/include/asm/mmzone.h:5,
>                       from ./include/linux/mmzone.h:987,
>                       from ./include/linux/gfp.h:6,
>                       from ./include/linux/xarray.h:14,
>                       from ./include/linux/radix-tree.h:18,
>                       from ./include/linux/fs.h:15,
>                       from fs/udf/udfdecl.h:10,
>                       from fs/udf/inode.c:32:
>      fs/udf/inode.c: In function 'udf_current_aext':
>      ./include/linux/overflow.h:60:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>         60 |         (void) (&__a == &__b);                  \
>            |                      ^~
>      fs/udf/inode.c:2202:21: note: in expansion of macro 'check_add_overflow'
>       2202 |                 if (check_add_overflow(sizeof(struct allocExtDesc),
>            |                     ^~~~~~~~~~~~~~~~~~
>      ./include/linux/overflow.h:61:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>         61 |         (void) (&__a == __d);                   \
>            |                      ^~
>      fs/udf/inode.c:2202:21: note: in expansion of macro 'check_add_overflow'
>       2202 |                 if (check_add_overflow(sizeof(struct allocExtDesc),
>            |                     ^~~~~~~~~~~~~~~~~~
>      In file included from ./include/linux/vmalloc.h:11,
>                       from ./include/asm-generic/io.h:887,
>                       from ./arch/x86/include/asm/io.h:380,
>                       from ./arch/x86/include/asm/realmode.h:15,
>                       from ./arch/x86/include/asm/acpi.h:16,
>                       from ./arch/x86/include/asm/fixmap.h:29,
>                       from ./arch/x86/include/asm/apic.h:11,
>                       from ./arch/x86/include/asm/smp.h:13,
>                       from ./arch/x86/include/asm/mmzone_64.h:11,
>                       from ./arch/x86/include/asm/mmzone.h:5,
>                       from ./include/linux/mmzone.h:987,
>                       from ./include/linux/gfp.h:6,
>                       from ./include/linux/xarray.h:14,
>                       from ./include/linux/radix-tree.h:18,
>                       from ./include/linux/fs.h:15,
>                       from fs/udf/udfdecl.h:10,
>                       from fs/udf/super.c:41:
>      fs/udf/super.c: In function 'udf_fill_partdesc_info':
>      ./include/linux/overflow.h:60:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>         60 |         (void) (&__a == &__b);                  \
>            |                      ^~
>      fs/udf/super.c:1162:21: note: in expansion of macro 'check_add_overflow'
>       1162 |                 if (check_add_overflow(map->s_partition_len,
>            |                     ^~~~~~~~~~~~~~~~~~
>      fs/xfs/libxfs/xfs_inode_fork.c: In function 'xfs_ifork_verify_attr':
>      fs/xfs/libxfs/xfs_inode_fork.c:735:13: warning: the comparison will always evaluate as 'true' for the address of 'i_df' will never be NULL [-Waddress]
>        735 |         if (!XFS_IFORK_PTR(ip, XFS_ATTR_FORK))
>            |             ^
>      In file included from fs/xfs/libxfs/xfs_inode_fork.c:14:
>      ./fs/xfs/xfs_inode.h:38:33: note: 'i_df' declared here
>         38 |         struct xfs_ifork        i_df;           /* data fork */
>            |                                 ^~~~
>      drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_mode_valid':
>      drivers/gpu/drm/i915/display/intel_dp.c:639:33: warning: 'drm_dp_dsc_sink_max_slice_count' reading 16 bytes from a region of size 0 [-Wstringop-overread]
>        639 |                                 drm_dp_dsc_sink_max_slice_count(intel_dp->dsc_dpcd,
>            |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        640 |                                                                 true);
>            |                                                                 ~~~~~
>      drivers/gpu/drm/i915/display/intel_dp.c:639:33: note: referencing argument 1 of type 'const u8[16]' {aka 'const unsigned char[16]'}
>      In file included from drivers/gpu/drm/i915/display/intel_dp.c:39:
>      ./include/drm/drm_dp_helper.h:1174:4: note: in a call to function 'drm_dp_dsc_sink_max_slice_count'
>       1174 | u8 drm_dp_dsc_sink_max_slice_count(const u8 dsc_dpcd[DP_DSC_RECEIVER_CAP_SIZE],
>            |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      drivers/net/dsa/microchip/ksz9477.c: In function 'ksz9477_reset_switch':
>      drivers/net/dsa/microchip/ksz9477.c:198:12: warning: unused variable 'data8' [-Wunused-variable]
>        198 |         u8 data8;
>            |            ^~~~~
>      In file included from ./include/linux/bitops.h:5,
>                       from ./include/linux/kernel.h:12,
>                       from ./include/linux/list.h:9,
>                       from ./include/linux/module.h:9,
>                       from drivers/net/ethernet/qlogic/qed/qed_debug.c:6:
>      drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dump_addr_range':
>      ./include/linux/bits.h:8:33: warning: overflow in conversion from 'long unsigned int' to 'u8' {aka 'unsigned char'} changes value from '(long unsigned int)((int)vf_id << 8 | 128)' to '128' [-Woverflow]
>          8 | #define BIT(nr)                 (UL(1) << (nr))
>            |                                 ^
>      drivers/net/ethernet/qlogic/qed/qed_debug.c:2572:31: note: in expansion of macro 'BIT'
>       2572 |                         fid = BIT(PXP_PRETEND_CONCRETE_FID_VFVALID_SHIFT) |
>            |                               ^~~
>      drivers/gpu/drm/nouveau/dispnv50/wndw.c:628:1: warning: conflicting types for 'nv50_wndw_new_' due to enum/integer mismatch; have 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, u32,  enum nv50_disp_interlock_type,  u32,  struct nv50_wndw **)' {aka 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const unsigned int *, unsigned int,  enum nv50_disp_interlock_type,  unsigned int,  struct nv50_wndw **)'} [-Wenum-int-mismatch]
>        628 | nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_device *dev,
>            | ^~~~~~~~~~~~~~
>      In file included from drivers/gpu/drm/nouveau/dispnv50/wndw.c:22:
>      drivers/gpu/drm/nouveau/dispnv50/wndw.h:39:5: note: previous declaration of 'nv50_wndw_new_' with type 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const u32 *, enum nv50_disp_interlock_type,  u32,  u32,  struct nv50_wndw **)' {aka 'int(const struct nv50_wndw_func *, struct drm_device *, enum drm_plane_type,  const char *, int,  const unsigned int *, enum nv50_disp_interlock_type,  unsigned int,  unsigned int,  struct nv50_wndw **)'}
>         39 | int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_device *,
>            |     ^~~~~~~~~~~~~~
>      Segmentation fault
>      make: *** [Makefile:1116: vmlinux] Error 139
>      make: Target '_all' not remade because of errors.

Hi Sasha,

I believe the segmentation fault above is not due to my patch. I tried 
building the same patch over 5.4.y locally and the build succeeds. I 
wonder if this is due to build system or tool chain used?

Thanks,
Samasth.



