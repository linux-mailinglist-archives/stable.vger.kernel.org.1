Return-Path: <stable+bounces-196904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81063C85337
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65C524E6E9B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD64221F24;
	Tue, 25 Nov 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YyY8cIXr"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8221D00A;
	Tue, 25 Nov 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077872; cv=fail; b=i93cyvbdPfpg0yZzwESf8vWdWZ+V2yBUupjZszm0fuah/iqcT0+WsvEVKE21VH5vfLZUeUKeGhgBtE5ZXLb4ZKJBbBvsOXmWUwDt5LS9grrmw96uYr1WmsxMYidZowxgDOfrHlQqSu5CQ6B97j1jwuN/LJBKuCiqkZz6G6D4aUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077872; c=relaxed/simple;
	bh=IUCPC7DG25PCKGOGPat1xUKGyEesgR9upv5C35VG1NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nScRRd5zgaHuzhziEjTc1svFnzx//drW+Mzin8CRVZ+IF5Jge0DJeel9MYI4EWEDd5BXqLROfAPWg0NYRggFbx5ZuSe3kQdUOx+GuY58L/lvYId6FESFY+LAzE3bAmQnuK9/PjPicUQpLW40Yy3OLe/YjNSvKYgkQSjCaaYSKgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YyY8cIXr; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APDQSk11798989;
	Tue, 25 Nov 2025 14:37:29 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4amt24kwkh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 14:37:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAl498JbkgKPYAEQbfuw0PJrDyg9ViXSla1139uNWZwrR8Q4kA7Z9b1wRbCB3GnW5qMFybA6tOzM+J1VfGb2mvxZMPK6NRBsxFud7bhAAOPdTY0WAn/UsQvQg/t2QTx6WdEVqkA8DZ5h5cDXt1DkcW29BaYKxxVGJ6h7XpWql07exczy7eAjweA/MtNjZyKIxMHS6i4dTcby/McOcnFeWheeHo1F3Jjey6gNlzAXR4V9EZL//LdzYFIZsCbJnbBj5gq4HPyXW2bqb0ntmnVjiIjIKqfyxwMRxzZ66hp5cfwvq/D8T24zb+TLS0OFjCmgihvdtNgR2ImDzgjBhG7wHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeC2vTuXghp1zIkIDv3nE3AYRzMrsV/jFVpA1P7oekg=;
 b=w5TvjxUKV5c/9rLCfhUNtfuF9K2eNhQugeHQNpp+IJR2dMkcdnJtmc4QB+D7S2Om6GWnB3NpLTZKtcotojcQFzSXXA6nVX7dWwZhGA5xzs8TsiqM/eLLRnNN53yL42TBYoKB/NbNWpMu9OBiQP5w/PuJ61vpifxzUNaagxQuyQ8LH4oYpUldOqm/0uMZDvTlLQaxCqwHAA9mmtzJZWLr+2cEm0GhL0kYv8KFOkR40HhMsQBwTSynYtRSgPWjDJrsL4NDa6mwLuO371uylXKIDy3ngPF4W6cUlb/eM/yfoEKh0PGVH8aK7Xt07KATU80icvCeVMf722rbLmRuTK/3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeC2vTuXghp1zIkIDv3nE3AYRzMrsV/jFVpA1P7oekg=;
 b=YyY8cIXrWDkgq6W1GVLcEPamreXac40/FBLSDVAjyEyFSyER4ifVoB9LKOux4HnJ+UGy4GxYFvF8qqNZz89prtH+2MazGZDmx4WF/qFrW8mwohYFt9jcFqdA7nB4iDFMHJab3nbqfVjqxT2bjKcRSspLVVXMffvrwxxSzwjy2KDsHkx1xp4yOOZ7NgaSaviuQIf+CbFk60vTAxWqDGKFtJwVFxFq3vaZCXePisNDcXG+EMe2Z6MF6aPqqr//EUInkTMKzC2YHeuA6pvTcYgez6wKpdQTDW4HwU76GM2BeHGsNdHddVGF6rS2Rlq6PhvbjeybAHKSWf3tXrriZA1SEA==
Received: from CWLP265CA0292.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::16)
 by GV1PR10MB8028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 13:37:23 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:401:5d:cafe::c6) by CWLP265CA0292.outlook.office365.com
 (2603:10a6:401:5d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 13:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 13:37:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 14:37:52 +0100
Received: from [10.252.13.178] (10.252.13.178) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 14:37:21 +0100
Message-ID: <b61d34b3-4b85-4db0-a47b-915eca0a9f4a@foss.st.com>
Date: Tue, 25 Nov 2025 14:37:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ASoC: stm32: sai: fix OF node leak on probe
To: Johan Hovold <johan@kernel.org>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Olivier Moysan
	<olivier.moysan@st.com>, <stable@vger.kernel.org>
References: <20251124104908.15754-1-johan@kernel.org>
 <20251124104908.15754-4-johan@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20251124104908.15754-4-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|GV1PR10MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b341711-81e0-4604-baca-08de2c27c395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmF2bUswQmV5K1VyV2pIbXNzc0RLNjVIbmxtOU0xdmdWQlRWcDNiWXkvbFRi?=
 =?utf-8?B?STlnRnVmbzl4amk1SnhYUDdtMzBtRUNUS2RSSGYzYURxb0FaWkp3cVI4Y3Ix?=
 =?utf-8?B?SnJ4b0dPdVJCUU9Hb3dtOGp4d2lpc0JTUzhxd1V0aEpRNU5vbUlSbktMeVZY?=
 =?utf-8?B?MFQvMVJNdTN0eWhOTk1QSFNUcVArN096U00vNFVUSGk4bDlLQUNFcXlwbjR0?=
 =?utf-8?B?ZjFMMmN4TTVGMWU0OTgwcVp2ZWMzTVJ5RTlpTW9zRlMxcUVjK0xUYWxudVQ2?=
 =?utf-8?B?djN4UEU0WnN6RnlTdTVwNk9zK2swQndsTituUjFFQWdPRHQ1eHRJdWdBTitv?=
 =?utf-8?B?Sk1NTjR3ZC9zWGk2M21ibUJRTjQwM2hEd3RZZVlLbVAxUXVoaWpVUGZvanVJ?=
 =?utf-8?B?UytBN0VtOFVYRUM2eWkrMjRiNjM1RlZ0dWo0djQ0T2dsZzBxaTV0cDVrbGIy?=
 =?utf-8?B?MC9Qd2Q1NzBQNWtyUndleVUrTklYVDJ6UjBwaGRESmRWWEJRcmVmNFA1Y1V1?=
 =?utf-8?B?elkvbUJvMzZEU3c3aDI5V291OVNZOWxTbUlkR29VL3IwcGNtVk1Nd3diN2R5?=
 =?utf-8?B?b1VzODg3ci8xSTdMaXU1TVErVDB6TUVBelJWUFNaaUxkMUxQcVZYOXlTb2JC?=
 =?utf-8?B?OFZXQW1WWm51UUgxbWxWRWpUeE42cEdSMnk5c2VDbU5aTy9ERWQ3YTZIZVpG?=
 =?utf-8?B?TUEycmRzSW9ERmc1YjFSRHZQS3V0YmhJSFZ1QmRYRWJaVXM2ZUs1SURaSys4?=
 =?utf-8?B?UU9BSnY4a2FmdEo2ZVhMYVczdHJSM1BSeUZFbytPSVNUU3E4Q1BpVElSU01K?=
 =?utf-8?B?a3NMZndMZUg0a2MyR29OZGxiUTJqb0pFWDc0UUpra3BVUlhhdzNGUkwvMm5K?=
 =?utf-8?B?QThrOVhrUjVQdktoYUJMWGwzQy9FOVhuQ1RwVUhWYkpVWVQ1V0dPTTY0Qmhq?=
 =?utf-8?B?WmQ1TU5VU2ZGV1o4MmJvenMxdlFQSFUxTFRqcGxaWHlSeUt3ellkMnl0VjJw?=
 =?utf-8?B?VzU1THVudnd6b1cvT3ZXOFVQMzcrOEZBUGd4ZGYvbTBwa0xKMXVkTVRHU1VS?=
 =?utf-8?B?VTBpakc2ZThWU0p3RDNvbFY0S3ZoQkF5Wmltckp0V2VhazArT1dHcGhMeTVH?=
 =?utf-8?B?dnlWaE85WWtRNjdLY1QwK0dpYU1wNXFjU0huTGk1WUR1RDZ4Si9wclRyci9E?=
 =?utf-8?B?d3FlN1lvclBwYkhXYS9kUmhxdSt4REswTGFabTBCd2M2Q1kvK3RENnFEY2VR?=
 =?utf-8?B?d2RtZ2htcnMxWUVoNG9SU0dDMWRhUTlyOWRmcjdwT3hKS1VPeVhBZlJXdDEz?=
 =?utf-8?B?ODV0bDhVeC9HZDc1RlFNMnNPNjlHNlRjeUphUjR4eEZLT2N2azNpbUxhTFZu?=
 =?utf-8?B?WXJFQXRwenhWUndxNGdyRXhmbklPWEpEeFZvYk1JUUYzSW42WlBkZVNXVTAw?=
 =?utf-8?B?UXBQUCtwSXJUU2NUZTd4V2hqeUhrdTNHNUVDV2JPcWNMUjQraG1vRTdiWDll?=
 =?utf-8?B?Y1h3Q3gyZEpvWjNLL0pEbjM0Wlg4ekpaWm9ycWhpRFA1QWtGQ3A5b2tVYjV3?=
 =?utf-8?B?eGZNdE9NTlRlWUwvVmU0SmpaZEpvOUh3c25keUFpR1NjWDkrZFZsK2tuL2g3?=
 =?utf-8?B?YXpJUE9Vc0F5VUxvblhmcmF2NHArbE42anNTSHFKand1WVIydm1acGE2YW1u?=
 =?utf-8?B?c1pJREJaQ2NiQXFTMWp5Wkx1SVF5VWlxeWVWOFBpWjhmMk10TjF2UjFwdUlV?=
 =?utf-8?B?S216SWF4eXFrb2dtN1RyQ1hNdXErSjFzVnVqczhmM3djZHJLS3U1ODZJS3FV?=
 =?utf-8?B?bVB5d2Zodk9JNkppWjZOdFNYMDRvZVlUVHpVc1lJNXN5andrR3JLaHYxbmdh?=
 =?utf-8?B?dG4vaVhaRUVpdFZaeHZCcFJxam91U0NKYllNR1NZQVFLQThwYUJUeTMzR0lP?=
 =?utf-8?B?Vjdqa2l0S1k4NjRzcms1V3M0KytUcGM0SGhuUUljQ21MdDlaZEJtS093Nlhp?=
 =?utf-8?B?NTluMEFDUzdIeE01MG5YTE9IcTVmSlhndW0rMlBKTXhqYVczNERjd1NZMisv?=
 =?utf-8?B?MVQ4TllUMGhyVVgrNWNBU0JkV09NaVBkenZBQ2pPa21LSmwwTnpLZGcwT0VO?=
 =?utf-8?Q?bL8s=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:37:22.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b341711-81e0-4604-baca-08de2c27c395
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDExMyBTYWx0ZWRfX+QjVmWyVRpe4
 BE5OH8mNn9AD8KSuOpsR5S9/h/3hVKruvQlgJbe+OcR0taoXgUoT1UVQDK1TXM+E/lZlezJDW0i
 4HXqGHS8iw6AP6EDjmrhFFWNbbrfVlIZIOYjWXxC7LxHFjc9pNIXO5vHY31AGwALh6WGEDBphZ0
 ZimCAEYbPRdTB2VUgMsNd0rin+kzKjtZctOg34g/QkKdoPKsIejxu+PLDA6m8yYg6ElBCYir6ne
 ET3D+EoiaR/gtML+UsX5dt1SMxMx0bbWrUKL+Ep5bby2TMVbFhJVl3CGh7Ad4xOlRL1wdRNco3W
 WEL8yjBST33w/w7lQPOu7qigiIDoONGwCaBmH3ViFJCm3ZFmZopfQZisvTWw3wwTHK7suVOp/1x
 B9Hli7Bze0YTJ02djNuIpKm8lSUy9g==
X-Proofpoint-ORIG-GUID: cZMGHKcLkkBQ3VRu4RX_F-nBwUAPAq6W
X-Authority-Analysis: v=2.4 cv=Sef6t/Ru c=1 sm=1 tr=0 ts=6925b119 cx=c_pps
 a=le7R1DPsL10lBYSFBlTEnw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=YK2f4aGzhgIA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
 a=No6pG6yjVYbeKTh9bIQA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: cZMGHKcLkkBQ3VRu4RX_F-nBwUAPAq6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250113



On 11/24/25 11:49, Johan Hovold wrote:
> The reference taken to the sync provider OF node when probing the
> platform device is currently only dropped if the set_sync() callback
> fails during DAI probe.
> 
> Make sure to drop the reference on platform probe failures (e.g. probe
> deferral) and on driver unbind.
> 
> This also avoids a potential use-after-free in case the DAI is ever
> reprobed without first rebinding the platform driver.
> 
> Fixes: 5914d285f6b7 ("ASoC: stm32: sai: Add synchronization support")
> Fixes: d4180b4c02e7 ("ASoC: stm32: sai: fix set_sync service")
> Cc: Olivier Moysan <olivier.moysan@st.com>

Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>

Olivier

> Cc: stable@vger.kernel.org      # 4.16: d4180b4c02e7
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   sound/soc/stm/stm32_sai.c     | 12 +++---------
>   sound/soc/stm/stm32_sai_sub.c | 23 ++++++++++++++++-------
>   2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
> index 7065aeb0e524..00cf24ceca2d 100644
> --- a/sound/soc/stm/stm32_sai.c
> +++ b/sound/soc/stm/stm32_sai.c
> @@ -138,7 +138,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>   	if (!pdev) {
>   		dev_err(&sai_client->pdev->dev,
>   			"Device not found for node %pOFn\n", np_provider);
> -		of_node_put(np_provider);
>   		return -ENODEV;
>   	}
>   
> @@ -147,21 +146,16 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>   	if (!sai_provider) {
>   		dev_err(&sai_client->pdev->dev,
>   			"SAI sync provider data not found\n");
> -		ret = -EINVAL;
> -		goto error;
> +		return -EINVAL;
>   	}
>   
>   	/* Configure sync client */
>   	ret = stm32_sai_sync_conf_client(sai_client, synci);
>   	if (ret < 0)
> -		goto error;
> +		return ret;
>   
>   	/* Configure sync provider */
> -	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
> -
> -error:
> -	of_node_put(np_provider);
> -	return ret;
> +	return stm32_sai_sync_conf_provider(sai_provider, synco);
>   }
>   
>   static int stm32_sai_get_parent_clk(struct stm32_sai_data *sai)
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 7a005b4ad304..5ae4d2577f28 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -1586,7 +1586,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   				dev_err(&pdev->dev,
>   					"External synchro not supported\n");
>   				of_node_put(args.np);
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto err_put_sync_provider;
>   			}
>   			sai->sync = SAI_SYNC_EXTERNAL;
>   
> @@ -1595,7 +1596,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   			    (sai->synci > (SAI_GCR_SYNCIN_MAX + 1))) {
>   				dev_err(&pdev->dev, "Wrong SAI index\n");
>   				of_node_put(args.np);
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto err_put_sync_provider;
>   			}
>   
>   			if (of_property_match_string(args.np, "compatible",
> @@ -1609,7 +1611,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   			if (!sai->synco) {
>   				dev_err(&pdev->dev, "Unknown SAI sub-block\n");
>   				of_node_put(args.np);
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto err_put_sync_provider;
>   			}
>   		}
>   
> @@ -1619,13 +1622,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   
>   	of_node_put(args.np);
>   	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
> -	if (IS_ERR(sai->sai_ck))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
> -				     "Missing kernel clock sai_ck\n");
> +	if (IS_ERR(sai->sai_ck)) {
> +		ret = dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
> +				    "Missing kernel clock sai_ck\n");
> +		goto err_put_sync_provider;
> +	}
>   
>   	ret = clk_prepare(sai->pdata->pclk);
>   	if (ret < 0)
> -		return ret;
> +		goto err_put_sync_provider;
>   
>   	if (STM_SAI_IS_F4(sai->pdata))
>   		return 0;
> @@ -1647,6 +1652,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   
>   err_unprepare_pclk:
>   	clk_unprepare(sai->pdata->pclk);
> +err_put_sync_provider:
> +	of_node_put(sai->np_sync_provider);
>   
>   	return ret;
>   }
> @@ -1720,6 +1727,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
>   
>   err_unprepare_pclk:
>   	clk_unprepare(sai->pdata->pclk);
> +	of_node_put(sai->np_sync_provider);
>   
>   	return ret;
>   }
> @@ -1732,6 +1740,7 @@ static void stm32_sai_sub_remove(struct platform_device *pdev)
>   	snd_dmaengine_pcm_unregister(&pdev->dev);
>   	snd_soc_unregister_component(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
> +	of_node_put(sai->np_sync_provider);
>   }
>   
>   static int stm32_sai_sub_suspend(struct device *dev)

