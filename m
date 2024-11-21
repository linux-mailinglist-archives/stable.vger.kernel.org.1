Return-Path: <stable+bounces-94495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5FF9D46FA
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213021F2240E
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41712DD88;
	Thu, 21 Nov 2024 04:52:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A1230986
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164771; cv=fail; b=WijLmnfMy0l7iSQBCrMeB4lw23b8xEwRxEcxo3oZD1THmAa5/QzylsrdtgZnCx11WU0hc8QjoHti/02uV6q7ZpI/Nun5vxVeUO5yt7kCI3JTefYwNeqbP3a7EcBQ79OnTgSh9iDXIaNr42nRo3nJTtwq1ue9AH7sot71j73jzNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164771; c=relaxed/simple;
	bh=FIrnAOz1LLS2r8WLsjwrbEFTdVgG0HHNMdJzpCCHHrA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oMqgU97SHLnLJgS+sl4YTxO3vX3eEYXPyLg7BcTN2t2/7MgZuC8cnQnrc/aPRE7M0isY9Nf2I4gtKMqbUwG35yPprEM5LGLmmRtcZ5hbY9d4UsiC22MJBcvs9htvT2R7sPcWbahDpZC3gWcQkZc8V3nzCZdMg5Ew2XxNzTRF6aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL2Ue2L000322;
	Thu, 21 Nov 2024 04:52:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0n7ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 04:52:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUd7QIiUZOMa5n5P/4ko3Ske30N+10gyO2fv0JVjr6Pe/YqJUueI/ZG60FXvAAgea26DwhPtKiKkXaYoer2lbykbfWuQ4/uyUtPQwJRivfkvPpdKGjAWR/6SqOOhU99b786eXfH6fI8YQOHypd6cD9XAtIkRbkBZxIlGeHa8ctK+JjrnxFLPU8Clu1msLKDA1qBG7PPbxwDprlev1pr8blMXD1h4MEezCJBySA/HjkRP/5GFM+OPN5FBhpHnx4e+Kw59KNQ6am4lFaGNSGcY+0cqYWGHhtaHLW/Kc2/Sjg4Q6KKcCBJIAOq70wffWN+tw0ddirAVXww+WoqpWT8I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJDCMYY4HV/TpCEFWCF2FBIu8mkvprbg5oU4bGxvF4g=;
 b=TSX246E1CQlAswOMqQwCKIucB19KJ4hIYFaf/xEh/RqZGazGmlwDbRgQe7OOyorX7fFlM2PCgI6lez1DR+anAYR+3gnSTaZJ8H+ptMFbnVvim2Qm8GeONiciZEkHo9GtqHDzn5OEoQtcx/xnpWyLALCM9HtpXAQSSU7GW79kHqA0h04k5EryTi1GWJcBB6LPIiWh5aDgz6421OvRd6M8b9kjoXNWgrGrA+JciicR5cyz47WbdvAwDvjxK71NlnJzCEoo+i43qQaUB3M4THmrwYGKeB72kdEOmd5Zc4k/jViF4lbQmTLOIIm3TTKJsgJNqZWgvSxljeBCVnEH3V69bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 04:52:42 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 04:52:41 +0000
Message-ID: <ea6863c1-b018-42c4-8e99-34bbe5f7699e@windriver.com>
Date: Thu, 21 Nov 2024 12:52:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: lpi2c: Avoid calling clk_get_rate during transfer
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20241120222607-5c2e675390173b75@stable.kernel.org>
Content-Language: en-US
From: Bin Lan <Bin.Lan.CN@windriver.com>
In-Reply-To: <20241120222607-5c2e675390173b75@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3623242d-8c70-4866-f1cd-08dd09e85458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHF6dW80TFlxamNFbzBtVVZ1ckpPWUxZdGNtSTB6QTBHaUVCYytxRlhWOFpx?=
 =?utf-8?B?bUh2ck5Dbk9lYkJFaHVqSm9ERkJ4UXVVZXhQYnZHQUhpbXQycFNYWThYZTcy?=
 =?utf-8?B?WXd6eDdtNXBOMTJGT0d4T1pJd2hLSm4ydDgrZDIwRStKNERMMjJlOTQ1azZ4?=
 =?utf-8?B?eURCbjNQRFFJTEJzbzhzcEpWWTZMUVdZMFVOUFVFSUVscmc2d1dWMU1nWmE3?=
 =?utf-8?B?NzVOQ1kyUkd6bjRiNUJ6VEw2QndZSzZkOHo5dE8yZUZtZTY5M1Z2OXFHeEdr?=
 =?utf-8?B?S2FQUWM0N1lpamRheWI2ZEsyaWZjWThwMVBpeE0weE5nZ0ZsNW5RUFJEUVVz?=
 =?utf-8?B?NjJGcjJzV1F2cERRS3dXZFlxRldPcTR4QVVEV040cXFFVU9tMFdXamhBa1FD?=
 =?utf-8?B?V08wTWw3cFhrV015TzFQTHZ1S1hNU2xFMGg4cEx1bGplcjgvQkZFOTFPQVA5?=
 =?utf-8?B?dUxoZVp1MWdXUHBDN0hpRzFqUlhSYVoyWmlvd1BVaU5LMGdjUC9IWXZxQ1ZY?=
 =?utf-8?B?NEF6SzhlOWNlNEg1c0ZwbCtENmZiUUdiSk5CNFBIb1YybzUzMFhqSnlNVUZJ?=
 =?utf-8?B?c1IrQkc0eWxtUml0Z2hFL0RjNjFYa3FQVWRjd3ArR0Rpajc1UVc5YXRtc3Rw?=
 =?utf-8?B?cnpmRDh5SWtmbUU4OXJiVHRnRHZGcE9kL3hJOTFPbDZYaEJXTis5aUhXOUcz?=
 =?utf-8?B?YldlMmk3T28yZ0c5NnI5VmFDWmFUK3J1YzQ3RkNyM25HdE5tWFBOemtiQm9F?=
 =?utf-8?B?bUFWWGdxVFY2bVpoMHFOMEk5TktwYlFVRGsyS0hSdHl5QTU3ZVRIcUdyYksx?=
 =?utf-8?B?R2ZkMFM4U3ozMDFFd2VRenlaUW1DalA2VGQ2YSswMUJqUitnWUdrdTJuWGN0?=
 =?utf-8?B?aXVrTllnQXBqTVVhODZzTDc1aDFmY3RMYlNRdGNUVHVua0VpaXl6M0c2OWN0?=
 =?utf-8?B?N04ya1NBS1F5TW9HdXczSS9xK25PNUNTUHFvbnRxYXJnQXBzWWprNGIwbUdp?=
 =?utf-8?B?Uk5rKzM1TlcrK3l6amZGbDVmSnE4cnZWd3plT0RXblJDKzJJODArUzdUa3RR?=
 =?utf-8?B?aklLOVdEVlA4TnhBZ2FhQXhienhoeklzL3hTUVA1RUhUdHpSZnJyY0ZWNGI2?=
 =?utf-8?B?Mkk1MmMxN2NuWitsWHZNQlBkUkpicmpURW5SbWwyTGxWQ0lnaXlVRHk2M1pV?=
 =?utf-8?B?L0RGdlBzcjhRaFVNNzljdms1U1IxZGpsOVBQcUVQZDhZRVdYbWFkS2JTU081?=
 =?utf-8?B?T2dXbk5oZmZ5cW5mRjd6Mm9zUURHWWxReHc3aktqSU1NM0VMQ3hhY0lwSUgr?=
 =?utf-8?B?S3VaOERVT1lpQ1B2bFBiT3lac3Bld2dVU2VtUFMwVGtoSjhmTFFvbXNLUlk1?=
 =?utf-8?B?RGxMaHZqdUFzRW85aTgweGMydWdwTlB6Z2VPUm5NdFo2QVFjUjV6S0l6SW1v?=
 =?utf-8?B?UU0rWk1sSUxQeUtRb3BKblFTTzQ0dm9VeVFNbmJPaTZHRFRnYWQ0UXJqbXNn?=
 =?utf-8?B?dElHVlMxVXpiSnpibHNTbFR5YjVDbFdDRXVGNC93M0VRdGNQZHU5UDQwN2JB?=
 =?utf-8?B?VVlXR1ByUGVxbGdqVjY3Sm1mUGpGaFQyZytxZzVJZ21UNGQwMlg1TFFJVGIy?=
 =?utf-8?B?V1NtOWtkRGVHdjJ5Ym9jelZsQzV4bUpDcUNMamtGSkxRUmc3NlROVTFZWFhJ?=
 =?utf-8?B?dmoxdFRVdk9Qbk1mV0NqYmZhYU94OVJNcWNqSDlydnRvVldjc2t6d2lxVlVX?=
 =?utf-8?Q?yMaHB45gn/7CFN3uleVE5a4pdGAErwUGGFJSB09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0g4TWhZWHk2bGg1S1JUZG41L0QzVnBzSkhDZjBMT0YvbHE3UWg5ZkVyVXFT?=
 =?utf-8?B?citVOGZBTFJid25GRmNLMW1WdkkyblgyN0lPN0UzR3FnUldscnFpQWpRSXNu?=
 =?utf-8?B?aTh2dHA3bWtWNk9XeWlYejlmcGVmNWk1RnFBQ3UwZVQxOXlOOFFqY29rZDQ5?=
 =?utf-8?B?c1VNUHcrUlFBUkJVc1QxbXBNeDNOODAwNFZPWUtIZThNQ2dOS3BaempYRmZ3?=
 =?utf-8?B?WEM5eHlqSXlsZElteEk2MXprb0VxSWxOdUJkbzh2L0lBNHp0N000SWs4eCs2?=
 =?utf-8?B?cDVmWTR2ckNNRkNwU0h4OXJSbllnZTVZY1RKb3BpM1pNb0kweHo5dlhQSWp5?=
 =?utf-8?B?cjhXbksyaGNVSWZJczJvaVdxMGtRMDRvVm02L2h4QnlncWNwV1poZWNFSFBm?=
 =?utf-8?B?UENMalhxSmQvUXUzTTZoTkVBWGN3cjBNTFdwSzdXdGtucXBQUEZ0Rll5T0Nj?=
 =?utf-8?B?ekw5Sjh1N3NOclMycUtTbFhmN3N6NTB5MU5ZaVVGdFNQNlRvdTdEclY4Y1Y0?=
 =?utf-8?B?SkwrazI3TkovRCtETWEwaEZhOG9mN3VZRjFGODR5MFVRNUtPN0draG5oRTRZ?=
 =?utf-8?B?KzNic3BTMTJzV1MxdEZ4NFRmdlM2cHhSTnQ4bzFsOHRCbzZpazAzVENXS0Zv?=
 =?utf-8?B?dGxKNlBSN1hISzlqa0NOYktPNVFPNDZQNWdWMmtUMjFIYWZ5Mm5mRFR1MGlo?=
 =?utf-8?B?WlJDYThhRFBBTFJYL0ZTVnNoODBpQklkOEVEOEV5aWhhMmFIekNYNFNLdEJh?=
 =?utf-8?B?RXd2Sm15elB6RmhwQ2ZQSmVpWTBLOXZYQjg5WTBYMUVYY3I1V1lTemZ5UDRK?=
 =?utf-8?B?SXE5UTMzaldZMXZUa01jR1Z0UFVGbjhzOE5OdzMwMWNHcXJySUVzeTkrc0I3?=
 =?utf-8?B?UG9Rc3lXOWYrWGp5MWx6S2JvYjVBYlpwV25QVEtwam5YV3laVzJMZmNiTzNx?=
 =?utf-8?B?ZVV5NUFHYWZ0M3pLQ29tNEhaTVd4bnhqdlZjbnFrWUpmVkFjSm5lRzFEZFdu?=
 =?utf-8?B?Y1BhSUhBV2VHRzJzN2V3Z3VFY0xMVjR5VkRva3ZkekttZE1rUnR4b0ZCUStu?=
 =?utf-8?B?SjJaSjM2eUdDS1piWjI2cGh1Nm95UXB3bi9CZksyUnVlSkdkWXFuNGlOa0Vz?=
 =?utf-8?B?aGp4Wk16T0lmZVlmRVFLN0ZTWk1zNHAxSEIzVks0RFl5TDRpcDJNMGdVL1l2?=
 =?utf-8?B?Nm9SWjNKMk5Oa2JDbXNZVmN5Y0xOL2ZGQVBXQVlNeE5QMTNweEJqQWowTDJK?=
 =?utf-8?B?b0tocEdxRzVaQ3Q1eXhYeDN2QWZnYmlYUTV5WndOQjhZQW5WNzJBZlVIaW5E?=
 =?utf-8?B?WHdXZEdmbERTRUM3S25MREtkaW9aeWdndUVraGxtcURSS3A0V3E4elRIRHhV?=
 =?utf-8?B?U21Hc2xHRy9RWTlQdEg1eWF5VUxIM0sxM0hQWElYNEtPd0pHTGROcHJ1Z2Qz?=
 =?utf-8?B?V0lCRmlvbGtMUEErN2tLVU5sOUZadG9EV0pjTldHVmlDM0psbUpNYlFuZDls?=
 =?utf-8?B?dWppYnBDRzY3WlpacDl2RTQwMjlIOXFDQzlBVktnRytwemtIOS9uRWFGWktq?=
 =?utf-8?B?bE5CN3B5NElnY2NyUnlvTERtdUh1QmNkOXdjRjBycWU5OTVqaHpQNkdDay9h?=
 =?utf-8?B?OGN1S2h4L0tvVDFrQkJBRlYxdHhYMG5YVWFKcnY1RTc4cFBmeTk0NFdXNVU2?=
 =?utf-8?B?MTVuaG4wUUgxdjc5UGVRZU1WTGNZTCtweHE5ZGdINXd3U0F2SzllV3hOU1VS?=
 =?utf-8?B?dTJmZ0IrRGF3NkJtK0pDMG0rcTUyeDY1Z3prVVFPQTdCeG1LdjFCZmJVenVm?=
 =?utf-8?B?aERyWVhQWXRuUC95QzBEU0tDM0hrOVVTb3crZEtTeFg0OW4ybXZvUXRhOEcw?=
 =?utf-8?B?RFdDRHh3N05XZFRmUGhSTkRoQjFMekNRNmhPNytPc1g2VFpUc043eVI3U0kx?=
 =?utf-8?B?RFVCT3lYM3p0b0xQUVc0T1NRZWVpT2htTEI3Q214WUVvQ010LzJIaFE1eHdE?=
 =?utf-8?B?ODUwcG9GUFFIRVZJdWtTRFNYNXRjRUpCbzRlVjV6NEVJemxPZ0h5REpObktr?=
 =?utf-8?B?Z2lXRmpmK0poWHRnQ2UyVFJiZW5oK3Q4NUs4Z0h1alBCL1I5NFhNYWN3MXY2?=
 =?utf-8?B?Nnl2OXp1c0V1RC81TjJ1MzZmNmI3aFRianFxRG1aK2hZUCtyYThLSmI0d0xo?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3623242d-8c70-4866-f1cd-08dd09e85458
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 04:52:41.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALMPVSwG1FrVLOuuyO5utQste3szR9HHAbFvlpBkZB6F+hE9TOwUcFD9QVb9CDivEYKWsY9lwMss0Bw5Hbb2GLdsWppvR61tjfOkqs4+was=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-Proofpoint-ORIG-GUID: wC2oiqZ9UAVjoWfpeXYI5GOT2R6s7dD7
X-Proofpoint-GUID: wC2oiqZ9UAVjoWfpeXYI5GOT2R6s7dD7
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673ebc9c cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=8f9FM25-AAAA:8 a=VwQbUJbxAAAA:8 a=5hl1w1buO1Pjl-_q1ZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_03,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411210036

Hi All,

Please ignore this email for I forget to add the kernel version.

B.R.

Bin Lan

On 11/21/24 11:26, Sasha Levin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> The upstream commit SHA1 provided is correct: 4268254a39484fc11ba991ae148bacbe75d9cc0a
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Bin Lan <bin.lan.cn@windriver.com>
> Commit author: Alexander Stein <alexander.stein@ew.tq-group.com>
>
>
> Status in newer kernel trees:
> 6.12.y | Present (exact SHA1)
>
> Note: The patch differs from the upstream commit:
> ---
> --- -   2024-11-20 22:19:46.512390713 -0500
> +++ /tmp/tmp.iHtz9hU7o1 2024-11-20 22:19:46.508471414 -0500
> @@ -1,3 +1,5 @@
> +[ Upstream commit 4268254a39484fc11ba991ae148bacbe75d9cc0a ]
> +
>   Instead of repeatedly calling clk_get_rate for each transfer, lock
>   the clock rate and cache the value.
>   A deadlock has been observed while adding tlv320aic32x4 audio codec to
> @@ -9,12 +11,14 @@
>   Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>   Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>   Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> +[ Resolve minor conflicts to fix CVE-2024-40965 ]
> +Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
>   ---
> - drivers/i2c/busses/i2c-imx-lpi2c.c | 19 ++++++++++++++++---
> - 1 file changed, 16 insertions(+), 3 deletions(-)
> + drivers/i2c/busses/i2c-imx-lpi2c.c | 10 +++++++---
> + 1 file changed, 7 insertions(+), 3 deletions(-)
>
>   diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
> -index 6d72e4e126dde..36e8f6196a87b 100644
> +index 678b30e90492..5d4f04a3c6d3 100644
>   --- a/drivers/i2c/busses/i2c-imx-lpi2c.c
>   +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
>   @@ -99,6 +99,7 @@ struct lpi2c_imx_struct {
> @@ -25,7 +29,7 @@
>          unsigned int            msglen;
>          unsigned int            delivered;
>          unsigned int            block_data;
> -@@ -212,9 +213,7 @@ static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
> +@@ -207,9 +208,7 @@ static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
>
>          lpi2c_imx_set_mode(lpi2c_imx);
>
> @@ -36,19 +40,10 @@
>
>          if (lpi2c_imx->mode == HS || lpi2c_imx->mode == ULTRA_FAST)
>                  filt = 0;
> -@@ -611,6 +610,20 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
> +@@ -590,6 +589,11 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
>          if (ret)
>                  return ret;
>
> -+      /*
> -+       * Lock the parent clock rate to avoid getting parent clock upon
> -+       * each transfer
> -+       */
> -+      ret = devm_clk_rate_exclusive_get(&pdev->dev, lpi2c_imx->clks[0].clk);
> -+      if (ret)
> -+              return dev_err_probe(&pdev->dev, ret,
> -+                                   "can't lock I2C peripheral clock rate\n");
> -+
>   +      lpi2c_imx->rate_per = clk_get_rate(lpi2c_imx->clks[0].clk);
>   +      if (!lpi2c_imx->rate_per)
>   +              return dev_err_probe(&pdev->dev, -EINVAL,
> @@ -57,3 +52,6 @@
>          pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
>          pm_runtime_use_autosuspend(&pdev->dev);
>          pm_runtime_get_noresume(&pdev->dev);
> +--
> +2.43.0
> +
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.12.y       |  Failed     |  N/A       |
> | stable/linux-6.11.y       |  Failed     |  N/A       |
> | stable/linux-6.6.y        |  Success    |  Success   |
> | stable/linux-6.1.y        |  Failed     |  N/A       |
> | stable/linux-5.15.y       |  Failed     |  N/A       |
> | stable/linux-5.10.y       |  Failed     |  N/A       |
> | stable/linux-5.4.y        |  Failed     |  N/A       |
> | stable/linux-4.19.y       |  Failed     |  N/A       |
>

