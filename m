Return-Path: <stable+bounces-93998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3B9D26FD
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DCAB2ACAE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEF1CCB37;
	Tue, 19 Nov 2024 13:25:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658041CCB2E
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022723; cv=fail; b=pn6Ij8xvEeLqc2fThc90690t8Y9ws93Lm05AkV+hjIVKuPRXai12LDxrNbC6K2Qyz9rKfDliuCZmoQPJbNnn1xx0QGTkelBvdedbf5mBmGAkqAz4uibYeRFK9pYSCat1X9qrminHawxwB/pZtIzrlrCrE+UbmsQGa8OwYoo9YEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022723; c=relaxed/simple;
	bh=/mztH6bcg0jnh8o11sAGRhryQifzBqoCypIBKhxXXIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nvuMzp3Y3eQ4CpZdwIDSsim0q6miJDcOX8U0WL64R9K+aDbwlJG4ND50jVhGMgZVCeZ3w4m6gSBVu4xCSi0ZquSluCSe06cLRFOC22OB8HdsVpx01PCexabiNvzHQhacepwHyQtWrYTVr5AcujPQgPIi45FU7XU+XPH2XO3Vwdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7o7ni006227;
	Tue, 19 Nov 2024 05:25:18 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq2qps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 05:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgcoj1cxLfNT+1PfwjNTWEU0rsDF2DZo7Mf9Z9Y8/lrqMxiyJ7JB3YlOcY9DbnLToaq3q59+GJSGEZWeLBQZZUtLahRmlyh2s3M0wCWG80WJdmtcgLDc+B6WFP5bOeps/3bzS3JxUVE1jmFVE5/U0aBkAE4SZpSGeAsRGlQAjpvFFmwjYGqQi24tAQ4+3SfdNMo3y9pYypGr3722SHIi4k86GOLMmWpUKNr1QJMEgKMSvL9LbxrSqfQXPYfs5x4p2T3R/dKAG4BHwNt4P8mZLLf++avvTqrm1mlx6CKTwlrRgzaJZLnJywPpaHIQxZhPSp3EHvpDKC+sPBidWzpwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWF1CttH+GyKYa0giaPl8i2dtKHNH1Vt4qHSFloTZbM=;
 b=upUEzdvqmzDetBZXCy8R2EbXg+3WlvBSI701NDXbM03RUlmbjavr/HfofB0eHP+NgdWYsfK7Aq4sZ9GJJ3eaKCNqHkCiQi5C3gt5YAmgS7p+KXt8n0buFoPgpB0Uh0WRLbDeB3KxefU3Xv+4WMuWGpb7Vv6J20bU0BNKQ7qICZt3lAYgeSpJCHv12E/pjq1KgLyqlR47Ng5CNFQccx0AQn6jMqMp7M90gGJ9Uai0rUTAWg/RRm0RRXCGyJTCPQJ8xOhPA9bseSSuNqBEm09JF/OhnmFD45QqsFGJ1ShVoWC16AAUfmfqN/5BlMw42X8o2BTtyhrHsISM1eXlzvFVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 13:25:15 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 13:25:15 +0000
Message-ID: <df247b1c-baa9-4163-8658-71ce56ec32e0@windriver.com>
Date: Tue, 19 Nov 2024 21:26:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] parisc: fix a possible DMA corruption
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20241119054933.2367013-1-bin.lan.cn@windriver.com>
 <2024111934-divinity-twiddle-4f33@gregkh>
Content-Language: en-US
From: Bin Lan <bin.lan.cn@windriver.com>
In-Reply-To: <2024111934-divinity-twiddle-4f33@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0307.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd25b72-79f0-41b9-d435-08dd089d9a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wmh0VlJvamFhM01YRVBNRnBlWDBFZklLMUJKUlVGSU9IdEJ6VkVyOUFSakNz?=
 =?utf-8?B?SEt4MVpBbkRsZnRWTVpabDVrR2ZKTmNJZGVxQ2dLVFJsVkUvWWZLWjNmK3Y3?=
 =?utf-8?B?ZUI5Vms3ZGJ0dXRyTHlaZmpIYm9pTFJ4ZzcyeUE0ZmlxVW00S1NtWHArbjFL?=
 =?utf-8?B?VThsdG1pK0t5Rk83TldsMFJBT3pDbmlHTWNBNDFMamVROTZFSU01aTErdm9J?=
 =?utf-8?B?YWhDd0ZTaHRYSzdHaUhuZjJpd0FmWDUvWk1YL0pkcnB3WlNnaWUwNmdENFUz?=
 =?utf-8?B?MVR0WmVQMEVYYW83YUxWeE5pVlNURDM3ZWtldFpjMFBhdVBuY1NwYWNIYW51?=
 =?utf-8?B?SnJucHlLOWZEbVQ4NmpoTms3Vm5SZEl3MjZhaFRFYjZKTjMyci9JaHV5THNH?=
 =?utf-8?B?dHRUMlkrT1I5RWZSSzJuU25nQlFFQ0pOWWNsQXBoeUZEUTR6QTgyZFBYSTZY?=
 =?utf-8?B?Wk5GVUtOMnQrcitkQXRSUExHQS80WVFIaTR5MDkvbFZ0N1Ezckwrdi85NHdy?=
 =?utf-8?B?SlFIV0VRdnJBVVprYmZuZDJqcXBzd2dGamVHTHRVaVNzVnBXd0FmdzVSTXB4?=
 =?utf-8?B?bldXWDVxYWxLUjMyckR3WStqY2ZLL2h0bXkvMlUySUZyY2VUdU4vL3g5Q3Nl?=
 =?utf-8?B?SkZONm1EeHBGWGU5Wm8rZmRyWmR1NkhpakZHblpzK3RZbkpyVHZLTk1uNHR4?=
 =?utf-8?B?b1NiVUN3eFRYOWtvQnNjR1FYaUwrdTVTOUM2WnRVRmxadWlWc2o4QWYwSFZG?=
 =?utf-8?B?V0ZOT2YzRVNnSHdTTnhqZXh4TUMzSFkxZkVTVDc2Y0NqcUJmYzVqUDB1WU5X?=
 =?utf-8?B?SWQzMGRBem1Namh0NEcyRndRaXFEaTR4eW1LOG9jK1c4NFNnZlVPQVdpckpS?=
 =?utf-8?B?N2hvMy80S1VjTFNNd3dnOCs5cUsvbmF2M1V3WEJEejZ6eW9iV0ZodWNQbDI5?=
 =?utf-8?B?VjVVQ0s1ZzA3NVpKYVpVVzI1LzI1ZWZ6bTJTRGVsL3AzNGpKZndlZXlpSmpC?=
 =?utf-8?B?bW12ZzRFOElEcFYwZ2xCZTNydzY4WjdNdGdmc1djejdpVW1NOElRaFZEZWR2?=
 =?utf-8?B?cWxEbnJUNDFOSlVMYnJtelBCUVFxNTdYaitkWnY2SVAxaWdua3RockhJeUI4?=
 =?utf-8?B?elJxenVsRWxQM1RjZlJxWEtIOHNVYnJtN0gxanZOQ1BXU2Z5cnBaeHNINUhY?=
 =?utf-8?B?RWtGSnBIYm54cTFOa253Uk9QRnFzcTdENUlKelF6Qmd0K3Nic0NjdmtmTkZU?=
 =?utf-8?B?bzNsei9nY2N1dWJVVDlJQzZaVjAyNXJzM2lJY1B5VjdDaCtYMGNoK1pUampE?=
 =?utf-8?B?SzN6c2FWTEFsWUVjU2dndlI0ZmhmZGJPTnNqaGNoSGpVdTZrYzZYQlArdUxl?=
 =?utf-8?B?L0dkVE4zODF4cmd0RndsZUNRUW5lT1gvSkpJeHJ6QVM4QmE3T05aRmMrMyta?=
 =?utf-8?B?MGhqRjFvWkRQQWVxOFlxOVl3WUxnb054UWcvN0RRMHE3eEFKSFFXR2FPN1hs?=
 =?utf-8?B?azg3Z3djaVh2TjNnVVJJSHhKa2s4bmtGN3pNanBqWHhiTmlNUVpVTEllMWdq?=
 =?utf-8?B?d3htaTdxbExxSHNMTnRValVUWlpNM2o3UnFKRm9VaXdlR0k0dzFOWXVNeitn?=
 =?utf-8?B?bHpzSnp4c3J0U3lXZXRWOXIvaWNST1dVaXlrWHBSNTFqRGdtWHRHNlpyYnJr?=
 =?utf-8?B?bTB4ZHViQkI4cVpQaVIzMkEyT3lVelNBd082Y3lVVzduU1NrckY4anZ1bzJV?=
 =?utf-8?Q?GOeB+pgwgT1xeBqLGchkFNJSAFijl4rugk2zNh9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3lrRzNuNWJVNy9maFJIejZ5c0JkK3VUUHY1ckRKT2Nza0pHWUthbkVBMnFK?=
 =?utf-8?B?ejBtZ2dFcFNxZ3FWUS83b005VWxhb3ZsN3R2S2UwQ2VrMDZpbUFVZWpUeGtj?=
 =?utf-8?B?emltcjFrMkJ3TGo1K002akRaaElCY0V2NER1QWhYUVdidFpqdkcrV0ExVnBx?=
 =?utf-8?B?SzFHeDF4SHEwbC9xREtzYzN2dFJtYUpWUHdzVGRuOE5qa0V4ZlBWK2JBWHNZ?=
 =?utf-8?B?cEpIa1dCWDdOQ1ZhckZSQWJHdklXUTBNYW50SG0wN3p1MG81ekVOM1hWSnVs?=
 =?utf-8?B?SEFYRE1EMkZaM08wRzVqdGRuaGRuTlByUWxGVzd5WVpweUhYTDJCTWNFekdP?=
 =?utf-8?B?NGY2cE1rNkZvOGNsUlZ0b2NvR21IcSsyQWsybmp5R2xZcnJuc25ITXRhVXY3?=
 =?utf-8?B?NjhvcXVrMU9nMHhUbjJGSlh2T3pnaFNOWGN6YmRYZHBBRXN6MDN4WFRJMkdY?=
 =?utf-8?B?d3JPME03U0tWVmYrVXdmczdqYTd2VTNHc25XY0hwOEdJa0FTSyt0WmxheVBI?=
 =?utf-8?B?Q0tJVlVMMGtDWVhmZThLQkRpbmJndFluUjdsOERvejFiWTFXUmoxb1JPSkJV?=
 =?utf-8?B?cys1TUZVd0EvdnZJL3ZNbFlMUEtBc3AwbUUzcG1JU3g2TUpFUmtVeUV3ZGlW?=
 =?utf-8?B?dkYyYWpPenBPMzFCRHZYa1Q5OWlCS3N1RHJXUjJ0cktIdzBBM0U5OGpIdXZj?=
 =?utf-8?B?Mmpob1JXQkV5VU92SGk3WUwrSEJZRGYycTFNdkFEZjVxZFptMUFlVFlWWHU5?=
 =?utf-8?B?OVFCVlJDOUk5OC90UnFDRWRMUjQ0UFd0RUx6M2F5M2svdTRKTXhwdGZhTnd1?=
 =?utf-8?B?eS9ndG40SWFVOG5TWC9nV2ZiK2xYUkEwaFlMZ1lPY0ZQY0EwWVNLWmVYa054?=
 =?utf-8?B?Rk0xaENFYW5BRi9FQ2x1cjk5bTZ2cVd6SUlKT1hGTG00T3RCNzhtbHdtSTJz?=
 =?utf-8?B?RXREYkJvc0pvSitqMGx6VHVueW4rSjVYS3oreUwyaFFUN0hORXNwNGs2Tm9r?=
 =?utf-8?B?V1ZoenNQOXhvcStNc05MY0RCV3lXMkRDaVBiNkJlZGJ3RWdKNU1oWldvNUJZ?=
 =?utf-8?B?OHpBWS8vVDhIcEJpTU5GNERKc3pXblNJUUt0Y0c2ZGZ6QmRVZEpGUlRiSFBI?=
 =?utf-8?B?L2ttOUZNMTBFdDZFa2xxZGtDRDBCU1RhREh4eUltQTFpRFlJOFlEQlhsa0hu?=
 =?utf-8?B?bTdNWTFibGRneUpodU9LM2lCM29nQ1pXbGNVaGtIemN3ekhyeHRPSnBwODhR?=
 =?utf-8?B?V3NhSzBpZEI4dFdmd1pic2w3RXEzQ2Zmc0pGTlg2ZE4vVlVNU2tnb21SRXI3?=
 =?utf-8?B?SHpNU0tpd2xmOEM1aUxtMUZZOGJhMkdlaERGSjM4bmxscjd6aFJDcTNubG14?=
 =?utf-8?B?VncrTzU4ajNSMHBUNXJUWk5vVlpzMVVMZUJzUytHbHJyNFlYcnJ6RTlZc2tZ?=
 =?utf-8?B?MWxmQ2RTSXgzMUdZd3Z0SEc0cXRMQ3RHSVNwTUhwRWpZbnZXbTdtQitBWmxz?=
 =?utf-8?B?NEZGaDJTTUNOaFh5TGp3ZndCSFV2bkNNM0ViQ0dKaFdzODcyNitMU3VTK29O?=
 =?utf-8?B?aWxEUExmQlZwVno4TjJ2UmdxazBzN2wvbmR4clVNR2FJSmc2ODFTcGdDUkxS?=
 =?utf-8?B?TDNHdGVMWVQvUzZnUnByZlNIcUc4WE9GMFNhdjN6eUFuK3FOcHBGNm0yOGVL?=
 =?utf-8?B?K3BOd0FjdTc4YzVyTU9nRUR0blZxcGV0U1AwcUlVMXpvTzVVU3o1Vy81dGI1?=
 =?utf-8?B?TzVuMU1yT2Fud0c5bGVDczdFNWNyM2g2NnNBZVpiU0hXUEpNc1NYbnBNZFo4?=
 =?utf-8?B?RmFjYy9BYkIrRW04bWdaSXVQc05IS3QrMldDSlcrWE9rUTZKb1QvVk13NWNQ?=
 =?utf-8?B?UlBZUVpaK1U2RnpsbjZyYmlVRlpNcnV0V3hoUGFKY1U2Z0RqMWFFVlk3ZHNq?=
 =?utf-8?B?TkRoQVI2a2NHbkQ5VitSMUIvbW1SUGt5bndiY3dMb2xKM0RGTFdhcTZways4?=
 =?utf-8?B?dUhmeFRSL0xOUjJVcURwczZ3aWFzUE11OG9IOU5XRGU2OFNseXk4MEkwQjFV?=
 =?utf-8?B?N0t5M2Q3ZkszazZSNlM3emNhL2pIZUNxQlUyMjl2WnFsL1REcUV2emo4RSti?=
 =?utf-8?B?ZFBQV0tYRUNNRjJCVWRjVmxiOHhsTmRkWUFpaFE2dDVwYU1jRFcxMElRcENB?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd25b72-79f0-41b9-d435-08dd089d9a56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:25:15.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp1O57mNWoY6bgYKVjkqDLc7mJ2CwcYjIGyFoIwEsvSkDeRHsvz6uV8a18tn3vTTMhYEclkAIMG6pPNmGgTqK73Ug5PaMOJqJm/TfqaTixE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
X-Proofpoint-GUID: GdVle3uoZ7RrGmXPp407086K05GrkE0H
X-Proofpoint-ORIG-GUID: GdVle3uoZ7RrGmXPp407086K05GrkE0H
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=673c91be cx=c_pps a=tyvwN2z/Y66O58r8mq/nTQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=QO-XjMr578l3KxCz2JoA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_05,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=956 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190098


On 11/19/2024 9:15 PM, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Nov 19, 2024 at 01:49:33PM +0800, Bin Lan wrote:
>> From: Mikulas Patocka <mpatocka@redhat.com>
>>
>> ARCH_DMA_MINALIGN was defined as 16 - this is too small - it may be
>> possible that two unrelated 16-byte allocations share a cache line. If
>> one of these allocations is written using DMA and the other is written
>> using cached write, the value that was written with DMA may be
>> corrupted.
>>
>> This commit changes ARCH_DMA_MINALIGN to be 128 on PA20 and 32 on PA1.1 -
>> that's the largest possible cache line size.
>>
>> As different parisc microarchitectures have different cache line size, we
>> define arch_slab_minalign(), cache_line_size() and
>> dma_get_cache_alignment() so that the kernel may tune slab cache
>> parameters dynamically, based on the detected cache line size.
>>
>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
>> ---
>>   arch/parisc/Kconfig             |  1 +
>>   arch/parisc/include/asm/cache.h | 11 ++++++++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
> You seem to have forgotten to add the git id :(

Thank you. I will send v2 patch for review.

Bin Lan


