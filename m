Return-Path: <stable+bounces-148134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C290BAC8712
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 05:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8479F4A3A43
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5C1C6FE8;
	Fri, 30 May 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n8uHsOHG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n8uHsOHG"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3C54652;
	Fri, 30 May 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577365; cv=fail; b=rLTJVlrcjHjXVYDldVduio+AA3KNW8N8s5biOWYupP4FiHquXtGBjkoOuxc3tLT6mP09YIhPdJtmj+Rjj/b2ITYcB1T3GxC73Dys9JuSt5ZsDVOtdqalfavs7D9bwM00lsZv1lCFBfE/J3O2bt2GJMCrW6jexjH8d4L09MNwxac=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577365; c=relaxed/simple;
	bh=EW3lcaupv7XRQvJsB+gQnxeTT8LER1VbhPQu5gQ2j7o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTVy6Wg64q+G3TBHhLDayUPWx6ZuOuFuk18yVA78sR7BK6iSpMCCLU1Fl9DJEsZLu3y9gpa0lv/rHX+5wCaEzeKEaEO0q9HWBhRH5SKNF+z0OOEESgKRPAHDejwPBnnNzuRNYjFHiUv7ETriZFuK8zhDEp8LOHV/XssFfQoCcZ4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n8uHsOHG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n8uHsOHG; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=avK19DBEcJCc2jqXWn0K1ZHbU6VvHXnOKdw0R0VEgMylvtTvNuzhXQxHDrT/Cx//9S8TjjRIDwULutc2Zifme8AKAKxmGYJtwYqSVbWk+mHllYUQSfogTeaJ4Im3USEWq2cheOufMvy9KYRO4vnniOAd9xfHQatjD2qjT10ZUQHOg1AjbIlgda6HdDf8y7BRywXbj3gSRQujoRNnGto2Vd12tEqsrkoGNEwPY9k4vDUY5CEhDwSnRFFSUgEI0MGNDRN11yg679W6PBcUMD7x1dBEzcyPrFa0cGHqCsUgQzegGMSSAOirzGkTmo1DxOw9VNiEZApJjYrQ7jyQ85Cevg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyGCl0FqrmJmMx9huex3LJ5SMO1OHQVquebcG4Yr+tY=;
 b=obhQKOQfnuUEScovRnCn2RA0K/jk4baXCN1dSuW0KxOWw84Mgm3/poIbulxjJcTv+hJSYGpIbSKJLD1NYG5AcvYqerE3SoQl9M+DmZYYS1+VT6gAc88SQeLUsHkTibyueKaJ44DPPerH1u50qVZNezZYeC0Ssuwr9D+KbpRR2MI8No3fxuHWXVop4RnLfUn6ouKrGmKScaYXS6aYNqttBB/a/IjJ1WqmhUdYreP+RVrUL1OH3dn4WVZEreJ/6qeKQOTXHALfsLhnhTlC8BI2xHw4JhaTeD45Jow4zb6uJqPgcQp9sPakspR8irntftyjykn7rDqp/YxQZIRA+xALiQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyGCl0FqrmJmMx9huex3LJ5SMO1OHQVquebcG4Yr+tY=;
 b=n8uHsOHG4Rf3aZEpr4OWjAhG8RRk59w4SJGi2RKQ2ZyPHzIKqrndecevgvw1VyknLo0zn+wbuG8uatgC9Kllr50htPCiv3Tovjbm3eRDMfueODIc8cTD/anbKykGUAnbe3BSZMN9SL/TT+OEd/j4c0vdLVCYhRms4CIfy+XRy+I=
Received: from DB7PR03CA0085.eurprd03.prod.outlook.com (2603:10a6:10:72::26)
 by DU5PR08MB10774.eurprd08.prod.outlook.com (2603:10a6:10:529::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 03:55:57 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::a5) by DB7PR03CA0085.outlook.office365.com
 (2603:10a6:10:72::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Fri,
 30 May 2025 03:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Fri, 30 May 2025 03:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znh4peaOoHvVe65C06095KhGbZZL9oTJxlGy+R9tOZoncfe76AtgOjOs1zgXb29iEdnLKJJjSBp8dL7FEd9nv1vBRzsHnhxMIdWVc0LJXLVGGxkJ8ufgYab2m8FDK+W10jCTxMvolIoNFnFAJ2TnGjl1nDElr/LZfTwgsZ48y6chMHfuuSFqLrYeWaMJvgIyb3BzGc/yg7gjb8BnEKS36znyHKuDTDChGjXcs6p8Bv4VGaaUD4WPcCa6+/wYJW/xMa59QEeHQIys0kwpHhvqcmAUSwhCrnwusmOPpyCTHNB1pKrxT89pogl8cuC7sOyYXgcKgujpr1RQiCOKQXD+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyGCl0FqrmJmMx9huex3LJ5SMO1OHQVquebcG4Yr+tY=;
 b=kS+OEA7/KTz8GK3/gpc240F4MgJNnTliDbYAwCNx3hcrODE5gLt7YPtGQLC52ht1GqiTNiDQgqewTXGsM5Wpn7C7pZ3M87VqVOfu8TXe6UoEQT6DjgOe6ecT0ujKNxeIWt6jTr3ejk8AAyi6fpXH8D6CAocB3xdi1pvzABlZfP0vZT0Z+cmb18BBq0BSm5GiHu/t+p1h4/bw6qdkXJDXjTMX7HLS82IoPYlfsV5g+yEt2ZKWCiw3DxVCk7yBKJBROnOvU+0Yql4sOyA5FKYiT1KrUuzjjAtbKTVDIOElbChMTH44I9lHOUKlSVfB5vo4H8MwR/Ppke4WrQTpnJ5QEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyGCl0FqrmJmMx9huex3LJ5SMO1OHQVquebcG4Yr+tY=;
 b=n8uHsOHG4Rf3aZEpr4OWjAhG8RRk59w4SJGi2RKQ2ZyPHzIKqrndecevgvw1VyknLo0zn+wbuG8uatgC9Kllr50htPCiv3Tovjbm3eRDMfueODIc8cTD/anbKykGUAnbe3BSZMN9SL/TT+OEd/j4c0vdLVCYhRms4CIfy+XRy+I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU2PR08MB10158.eurprd08.prod.outlook.com (2603:10a6:10:46d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Fri, 30 May
 2025 03:55:11 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 03:55:11 +0000
Message-ID: <914071fe-c133-4c9d-bb2d-9b9fca8a1798@arm.com>
Date: Fri, 30 May 2025 09:25:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: Restrict pagetable teardown to avoid false
 warning
To: catalin.marinas@arm.com, will@kernel.org
Cc: david@redhat.com, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 mark.rutland@arm.com, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20250527082633.61073-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250527082633.61073-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU2PR08MB10158:EE_|DU2PEPF00028D0F:EE_|DU5PR08MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fabb8fb-3e3b-4fc0-4143-08dd9f2de1eb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TERHS2ZaNk5PZ1hHV1hUSzNJeld5YXRsdGRnOGcrbFAxa2VKdXZsU28wN0p1?=
 =?utf-8?B?aGlsbVFGZ1dCZDZFSjk2SW9ZTkIzMk5rUEVxSE5BbDdPMERyYkxvdTVGdmZ1?=
 =?utf-8?B?cVp2MDU0YnQvSE9ybmw0OTAvY1NuVXFFbGluWUlJekd1Z3dFOEpjMHQ5S0Js?=
 =?utf-8?B?VHd2SEMwaFpaSHNUNWhROFk2RWZxaitiU20zYm90K1ZqRFROd0VGSTFJUlQ2?=
 =?utf-8?B?bTZ4TUtSck9HV05TeWxsL29aMVpDeDBXWFYzMzBPQUhlTzBkemVCQitDc1Vj?=
 =?utf-8?B?eTVqUXlVdWJyRlBHTEpadHBXMStxbWQxVitwK3dWTU9RNTc2OXhzR2xvUzFB?=
 =?utf-8?B?VWYzUEkvVHVkcHF1bHRqanlCczVwcDZQeHlSYzVwUUdmTUQrZW1vcHRRdjFH?=
 =?utf-8?B?TmFCYkYzSFp1UGszQ0Q1a3lFdXcrZFMrQ1NVTlowWVY4UEdNZEVQZnRLaktR?=
 =?utf-8?B?R3VWUWlabUVRSVhKdmZreVlVY2xWekhFT2dpcStLaG90Ykx4S3dkRkhhb2ZJ?=
 =?utf-8?B?MWY0NGZCd3ZXTW9XUEI4b2xwNmtmNmsxSllXcHh2clhhL3VvSkg1UUdHUEhh?=
 =?utf-8?B?NncvM1FZdlNxYU1WTUdTVjF5OG5XWk44KzJoZmFvQUVSamVVcHZZUmZabmlY?=
 =?utf-8?B?M1Z4R2dlT3lJRW96YXIwKys1bEZRdXlaZHNZMHhEU0xFcVhiK3poTWVpM2NJ?=
 =?utf-8?B?Y2xxZmJGNGhRaU90N1cwc0Z0SjM3ck8vbWRaaHJwSVVFUE1qWms1YkhCRml6?=
 =?utf-8?B?MVdobnRua2NnU0h1T1JHeWxMNzdRZmpwenVtMjJLcFNJY1cvNHhyR3JpZU4x?=
 =?utf-8?B?NUFaQ29Ta2tjOWRqb1JUKy9xbCtBR0xoM2d0K0UrVUQ4V3BRRE44QTFNZkVv?=
 =?utf-8?B?RTNlaExMV25vOUVYdGRYeEU4Y1pZWUtUNjF0VHZCRDFMMVZXSlRZUUlka1c4?=
 =?utf-8?B?RDFIV1JuRFIwcVM1WlpVUEFNVU1wNHVOaUlFMjdzaW1nVmFkanlLbnpSOFFL?=
 =?utf-8?B?Y1R1cEFoYW5YRy9OL0tYY0JPSWRTckY4UjJ5ZlRJRkxvUTVDZHRNSjg3am1u?=
 =?utf-8?B?SlpNbmFWdkV0alBTZzllMm80YzRUS1MyM1lxSDViR2o3Nkh1ekVpU0ExdnhF?=
 =?utf-8?B?by9vYmM5TTJDUFhUUXpsYzdtMVJLbFExamJUSnFMQkl0ZHJjajA4ckNaaHNN?=
 =?utf-8?B?UUtDWk5EaG94aWFBRytCTE0yNlJ1SkluQzdDNUdZTGJiSUdwTkNZaC9KNXpy?=
 =?utf-8?B?cytWaWtBR0QxWWtRaWs3UmJsNU5lTWVCUEZMOWo0dHphbFB1ajJxc1VOMmJX?=
 =?utf-8?B?aXlSbHVveEg3OVRXdENkRVZiNlB5aHpwN1pqWTlCUmhyZVRCS3ZuTFNEeDl6?=
 =?utf-8?B?TVdtbW96M1JxV3NvMC9TRncwTXN2c2F2ekdqOThHejZ5dUlnOWtJTG02a2tu?=
 =?utf-8?B?Q3Vkc0M5TThvU0l3K0h1WEppSWRpU3FqUW5HaW9IUWNTS3NPUW5EN29SU3Vh?=
 =?utf-8?B?Tk1EL0loKzNpUUtpdk5NTEJNWVpPMGp0c095bGZDM0NpelVET3BWb052OXpw?=
 =?utf-8?B?MlJyUUU5VjdQd21SSTRrWTJlMkZBbFdIY2hFaHJ5TUdHWDVXOXhpL3VlODBQ?=
 =?utf-8?B?Y2RrNmhTMzNMNjF2dktodGZickNHbm01TDZuMzhjRHZSQ3J5T1I3K3FjaXVt?=
 =?utf-8?B?RjRnSUR0OVdxMkhNbnFpeFFsc25Oc0dhdVRQL3U5T3MxYVZmdm9uUndjbG5h?=
 =?utf-8?B?aHdUQUFpYUZXR0xkaTV1UHBNeDREbk9HSjFndHo1Zy82Z0FEcXF0bHVIcitK?=
 =?utf-8?B?aXpPT1FWTTVHR1FlZWhvb3NBMEpuREZ4S0wvbGdDMURXK2ZqVEtpdUE0OHlt?=
 =?utf-8?B?bCtjaUVqaU8zWDRDcDBXbk8rU29VVGtEbVZobTJxYm9qWkdPangzaUdYbHJC?=
 =?utf-8?Q?1kO6oPxkK7s=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10158
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	20891ca5-cad2-464e-6b84-08dd9f2dc666
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|376014|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTN2SWt0R0ZRL2c2UVdwcXVDVUpjaG9SaU5GQW42RU9KM2lJTEtYN3VqTi9y?=
 =?utf-8?B?eFZ4Rm54MjhJS3lsN2FWQWhhUCs1S3h4MTBzc2VNRUdoN1lWMUUrVjBnUnor?=
 =?utf-8?B?MVNrcTEzbDRRbjJwMjZ1UUdlSkhpVExxNzlHc0RaZzNVRXI5bFVUTjNQZnBT?=
 =?utf-8?B?UnZWa2k5alhoRWQrbEZGR2hTRjEyOTVvNDRoVEhFNjM1VGl4ck84MG1wdUF2?=
 =?utf-8?B?NEx0R0I5RFExTUtFcDdLeEFtdEEvckpoYlZ6K1hyOXdRMFViSDhqMFBueEFv?=
 =?utf-8?B?cEc0VmJWNUtxYjh5MDdFd0F0ZXAzcVBWVjU3bm9zVkZrblRRbTFtd01YNWRs?=
 =?utf-8?B?QXVMOThJSHV5cGZKSldJNXNKYjVHYVk2dytNZSttUENZUWw5YmwxMkJOZHBR?=
 =?utf-8?B?OW8vZ2s5bzUzWGd4UHhYU3U1dkx4d2lPczl0a2Y0ZTM4eGxZQm4xWVJhcWti?=
 =?utf-8?B?VTkyQ2plTnZLdW1EelpYMDNDL3NXZ1pFbGlNM1lqMTA3ZVk0VW8rd09wcUhT?=
 =?utf-8?B?ejVQa2c0WjZMQkFsVXpHN0dEUGEvbTlzOWNtam5oQVlsV0xQOUw1ckkwOXZ0?=
 =?utf-8?B?eGQxbitJaEl3Z2tWeW9DWXFLeUVCTk9JRDBibER5Q3NDNWdrVUhZbS9JMS92?=
 =?utf-8?B?WkpZc3hsb2NuWWFqQ0gxRkM1SXA4U2FpclJLZDYxUDNYMittNnJHcjBlQjNZ?=
 =?utf-8?B?dTVOcnE2UnFIeE00azRESVl4cjdxczVRRGNzM2xVeHNXY0JNQTMyQlBPR2xS?=
 =?utf-8?B?NVpkZXVxSWdONFBxdllwL2ZmRUdyV0NITVFQalprZEtGbGZYMXY4VUpmZUJW?=
 =?utf-8?B?Z3lpbnRPVVJVQ05rQTNMNUcxeHpqQnMxVHZYTFIrWGdEbmRZZm5UUFhjVHFk?=
 =?utf-8?B?YytZb0lMZGRHaUxtRzBJVU95U3h0ckdiN1MvREUwZWF2T1Q5KzlUR3gzd201?=
 =?utf-8?B?SFZsMXdMdjRSK1lncklxeDB1aGo5bWJpcThjZE9zL1JQNzhCUURBZTNBQ1NP?=
 =?utf-8?B?K2MvTTNhaTMxcncvVFJEU080QnhjSW16N1d4NkQxcVJZbjdGcWsyL3kzOXhs?=
 =?utf-8?B?MlZjRUhERXU0bHp2cVo0ajV2bEhZTHV4R1ZZZ0NSOG1jTG83MWZDQnU4Sm5U?=
 =?utf-8?B?NHZaWTdtYjlHR2pLU3BzbjNpMCtJdXVUZlpHWnE1US8ya1M3a2NLSXpSdDIz?=
 =?utf-8?B?Ny92bUNUeDJCU1dUekp4a1lsSmR1UlpzcmVybTVhREZMQzRoQk83T0p6SEVk?=
 =?utf-8?B?eXpneHRJVkFSRHNLYktDcVV3N05nak9pMnZQaTRLbm4wR0YyT0ZIWnVEaU94?=
 =?utf-8?B?ZXlBUjVqSUpCc2FxdkNOZzZiK0RsSVAyZlJqS3BVV1NFZWF2SDJrYUFQVTZr?=
 =?utf-8?B?V2dOR2NTdkxxSlNKREdENkxsZjNyMlBYMW1TSnFpcysra2c4azN0cjlSYWNu?=
 =?utf-8?B?ZGkrNE12V1hVU1B0a2pTTmpKVXN0QmVxdDNFT3VTQ3RWbDhKUHp0N2kwZlYy?=
 =?utf-8?B?K2M5YlBkTTZOVjVPMFFoMVFpcGNUWjhsQXRmemZDOVBSRG9TZ2NOaHNJZDZm?=
 =?utf-8?B?ejVFaVVJSmVobHNOaTJSMGJ2L0NKWHNhN3NHRTBTY3g2WjdyK3RVWlhTMVhk?=
 =?utf-8?B?bFErVUZWTy9BTlNmMG9uRCtZVXJsRnl3alRuWkN1M29TL3pHWDZXNndyYStp?=
 =?utf-8?B?SjdaK2hiQlAwclpwU3FVQkd0RjdyV1JNd0k4ZXNTK3NiQWoxZnFIbktFZzV2?=
 =?utf-8?B?cnlmTjlTbFRyUzRSM2E3dzVTMnM5ZTVxb2Y1UWFESGNyUnRVWFpZdUkzREpX?=
 =?utf-8?B?Y2hnTjhTSkdlTUlPeHNjb3NHemlLWEdqUUdCNHZDRVpNdGY5VUxtYmNWcWlK?=
 =?utf-8?B?VWs0UmhGS3BLckRDNUZ0YjVRdlB2Sy9scjIxYzJwZVNqWFpnbis0TVBNcVpj?=
 =?utf-8?B?NUl5a2tqQS8veGNHNFdOMGVBaTBkSUNyN3lucmUyNDBwQmMrTFJNbXd6aHRw?=
 =?utf-8?B?VFVCcno0cmF3VEQ5eFo5eWxkZEg2VHZhd3dXRld5bEcraVluQmFPbEJEemhM?=
 =?utf-8?Q?JRWL1j?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(376014)(14060799003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 03:55:56.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fabb8fb-3e3b-4fc0-4143-08dd9f2de1eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10774


On 27/05/25 1:56 pm, Dev Jain wrote:
> Commit 9c006972c3fe removes the pxd_present() checks because the caller
> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
> a pmd_present() check in pud_free_pmd_page().
>
> This problem was found by code inspection.
>
> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())

I missed double quotes around the fixes commit message. Can Will or Catalin fix that,
or shall I resend.

> Cc: <stable@vger.kernel.org>
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> This patch is based on 6.15-rc6.
>
> v2->v3:
>   - Use pmdp_get()
>
> v1->v2:
>   - Enforce check in caller
>
>   arch/arm64/mm/mmu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ea6695d53fb9..5a9bf291c649 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>   	next = addr;
>   	end = addr + PUD_SIZE;
>   	do {
> -		pmd_free_pte_page(pmdp, next);
> +		if (pmd_present(pmdp_get(pmdp)))
> +			pmd_free_pte_page(pmdp, next);
>   	} while (pmdp++, next += PMD_SIZE, next != end);
>   
>   	pud_clear(pudp);

