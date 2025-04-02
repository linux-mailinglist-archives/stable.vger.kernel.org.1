Return-Path: <stable+bounces-127394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C44A789D0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05E67A3350
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E74234989;
	Wed,  2 Apr 2025 08:28:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D213D53B
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582514; cv=fail; b=M33/NfbwpVmQUMPEH+X/9qLV0r0MliIhTZpCFAfs6FEPBpqSU/SY/4IOBHdOEP+yRfuq8kWmbrogYJadhlJQOVUo8AvJGTMgF5hUjRQFVyyv4LBCOIWINCyLICKIgZeeaXPyxGcgK1DaEyZzG4qsLhrbQZstiWE5f/GQj6t2CPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582514; c=relaxed/simple;
	bh=nn1TBTNuoYW4eVSYf3FsRyOo/s+CABwN8WMJzPN3m3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPMNv0CqHRcof5ZqprFeQ200kJb0qoz5vTm3sD43RJgH7wWT7NdiOGzkxP+FQQ3m6oU9DKDydiEXtu1fahTm6KviRBu+ShFRNdeG+9sKhSLhhgCAsMfekZxABgq6Ag3SJ8jSRsjfalUwe3YIxa3qL5gO1em/diGSxQyKSmAqnaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5325cMid012277;
	Wed, 2 Apr 2025 01:28:25 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtf2ggqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 01:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWSWoEU2ddM0qdSkrlE9kWO1iQC2CmPha8ly7E/aMtLXVuqfGIk/tgHZPDlVbPY4Zd0ll3JkdsbYphwKiNQ23toovPAtSEsvbV3fJYb/SCGbOyeh8260yg47wtX+lCCDGVfKh3JYmSeEyRH11pRJOvexVzsdquSbZY9fky8XuYC+uQKfyRkB0O6bB6Lzh8AEBMNB/qQZra/QsvGtPhJrTBtPVIGcKYzO5c9Y9iNnyvuBgtNtogVRQwAQdzzF0hv0Ng0HnbVe/TZXS3do3lY5GM7+J30yLi/5PF1MqSZrJi4q36HfRKxRJnYBoe0mI1G+ccIm6K+R+aabsq+Dk7KxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+N2l4bb2kzkPmady0WU6UL1X03GDyRfDvCF2wJbVZE=;
 b=ZSdAq0q4H7iTzKbnAOSybMTy4hSxiWdibEjIVuH4R9L9EhE/WN0EX2wpMIRldg+4XtK3tPXN+RQxLpMH3R2T4yFpC38zBV9vaBPGeOLKVwpnuFZfGybPnfCzKwScD7aamNOQ1XmHk09fUg7FKqcj9hUnBk8ADcHXGGSNILAy8iz3ma3v89x7Ba0UQEPnNCGd6pqNPJsHcYC9ztvjv1aOIgMZZgYvfHpwFPmMk/8MlRXuc4UGpVbOa55mM//IXZ2wrfO0aqdheoJQT2ux2dNcdlFdg8GYaH/oDnTTzCH1v45m+Uh7pJ06XLtFd+s6r95csGVG86RpwtRMrN9djgnlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:22 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:22 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 1/6] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date: Wed,  2 Apr 2025 16:26:51 +0800
Message-Id: <20250402082656.4177277-2-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 706f96ce-ddcf-4a11-0043-08dd71c054be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDNpVEdFUndvUWNXV1FiQTFldDVqRXU0TGFNVjdFMXdUdmY4UGQ5b0pZbmFl?=
 =?utf-8?B?Zzg1YS9hNU5zeXgyRGJZQm9neWo2NEFnTUVCNjVldWt1anlnSmsrVjh0ZVF4?=
 =?utf-8?B?ZjJuWkswaEJRdzUzbGcvc2Npa1YxU0lJa2tmUnhkNmphRmUxcXRqS3JuL3N6?=
 =?utf-8?B?ODdEdGhpalRlcHBpc1RTNkI4ejdTUVErTC9tRTdRTTd2OGdVbk1Jb3h6dE5v?=
 =?utf-8?B?bmgvMURwbWg5RVk1ekU0RFhPMmI5d2RkWjZlT3BVOGlBbzk0U09QTnpUY0xa?=
 =?utf-8?B?eHRvVnkxcTBGSkEvQ2FvdVF0VHdxUnZHQ0tTRENNMklTSFVRVmZiZ3ZFdE5x?=
 =?utf-8?B?cU1YQlNIV2dtWXc5UGJDenh3Y3VSdHR2YmU4YjhkN0IyeFVreUxOeDB4RzlD?=
 =?utf-8?B?Yy9Cby9tL1lLcWtTbDdyYUVwY3UxZTVoMmIxSlArUVJXRE9lUUtWbkNYUEZw?=
 =?utf-8?B?Q3JubzJoOWZDQnhzd0czdG9adGtDRjl4Wkl3NlRManVlMGRZcVQ4UnpKTXZ3?=
 =?utf-8?B?VlZEYlpZemgraytIS2Q0alo4d3ZyNzNFd3c2WXBJRjR4M25rRnpvZFM5RW0x?=
 =?utf-8?B?TlU5VTIzQjNTMlFhN1M4dXUyQm4zQk9qUEN3SGNxZVYrRU40Qlh0UlFtZlp4?=
 =?utf-8?B?bEZjV2FZR0o4a0dRSmxEOXh0WHB6a3hkTlVnMTZOOHNmMG9zK3hIaVRmTjNC?=
 =?utf-8?B?UmtFeVNxejhmNTNSWElwMzRtRUw4QlhmME1MTnB5Sm45ZVFvUk1DQWFQOXlJ?=
 =?utf-8?B?NG05VnZIT3JvTEMxSW9aejdNaVRPMXJ2cTFCaXdSN2NPU1pDME42cTI2dXls?=
 =?utf-8?B?MEdrMHpOYTdPQUZ6Ym8zNlczMldTb1hoV0JJaWRnS29DZC9MdWN3MGg1YXNx?=
 =?utf-8?B?UVgwVnZHOWo1eVRJYXlnY3NGSXQ2d0ovekoxVXdaNElCZlc3dDBNL3Jwdndp?=
 =?utf-8?B?QWs0dHpXcjNRSExBRmdhS0ZPMDVrRWtiZ21kQU1yMTFzcktlVStlMzh3YWpt?=
 =?utf-8?B?dWZ1STZkTUlwa2JHQjM0REI1dCtjZGwwc1E5ZVEwNGJNbml3ajFTME1ZY2hQ?=
 =?utf-8?B?SlR2TndGeGY0b1RPQkpIZ1Bja1Nub3hXckVhay9INThORnpId0N0UWVLZ2xv?=
 =?utf-8?B?UTVIUDBiUFNrWFI4cWVPS0RFVEdPM3E1bTVnODc3MURPbDg1M3I5YjVjemt5?=
 =?utf-8?B?dW5BQUM3U0l4SDZOR2h4Q1ZXZFVQOHFTZ3gxbE9hRVl3WGJBY3pob1crV3FW?=
 =?utf-8?B?bEdkNVhHL3lMK3BnNWNUWjd1ODIyYU5ieFg0YU9VL3RMQmdQZS92eTZrZDAy?=
 =?utf-8?B?OFNGRit3Uis4YllqWGRIZ2xWUlRROCtyekRta3phdnR0OER0MXpVeDhqditR?=
 =?utf-8?B?Y3ZSQnd0VVF6WlZjRDhTRmQ2QUtnWncwd3AxWVRwODFBVWpNSit4Uno4aWhz?=
 =?utf-8?B?QW1xaUxhTVlHVDBINTlGMjFZdGdDRnBBTmRaN0pJbnhmOUdpTDZHODVOcVFF?=
 =?utf-8?B?NWRpWnhjeDFLZlN5TU01QzFqdkdDKzZ1NFZLcmFiYTl2Snd5dElyQkZmaHV0?=
 =?utf-8?B?RDU3cDREcFVZUEMzNnFzdHRqVnVWS0lWZ1c5aXU5TVN0OGRIekZ1aTB2QThm?=
 =?utf-8?B?NWRBenhnaGRPVGxkUHlQQTNCeWhzRXlvenFhV3o4aW13SnJ5Y3NUM2w0Tkpk?=
 =?utf-8?B?Sm5XUERadlBIUlBqMWhhUWFiKzJDNEU1ZVBqZURsNm42OUFnRXhLcWk2R0NX?=
 =?utf-8?B?dUNwZXlsSHBWNnlNRGJRQzE3VWFWMklkSHhDNXJXSkZsYlNKSWFLMmJLMWZh?=
 =?utf-8?B?MVZTcGE3RUdacDBGbVROTWo4b1lBNFR5MFMwUDFoZkVHZVFqOHlJNGxRbEU2?=
 =?utf-8?B?S3VFamhqazgvM0JtaFpEckpwQXoxcGtocG0rdDErazVtczJ5cDV2KytSVm1N?=
 =?utf-8?B?RndlL01HWm9xTGQrS0grbHhqM25ILzV6T04yTGtGdC9rRFQvR0FrR09xZWZu?=
 =?utf-8?Q?uG3kcXoH/U8TgyiV+EluHtF1D0qKTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFVDODdoQmVxSkVvUXNFbXdUSGhZMWh3RmR4REZPeitMQXBvV1IvNi94Y3Zj?=
 =?utf-8?B?ZzBQTG8yVUN4blJMMzRTdzZvZWN3S2llTEVWVUJKYnJ3SXJpT0ErdU5GQllF?=
 =?utf-8?B?YzdMbHhZZ3NkY1EwS3lMeW1XU1ByRGMwVnlSZHkwSTBVM09pc0ZrS0J5YUMx?=
 =?utf-8?B?N3F3eGdQSVlFbGdDQlB3TWtFckRPdHNpSWNlUE15RUNiN0VwRk83QlR3QlNj?=
 =?utf-8?B?WDVTQ1RJQlBTckxMSlE2Y25XSlRhTnd5bjIvRDhLVEJxeVhoUDVROVd5UTA0?=
 =?utf-8?B?OFo1Z2ZaN2hXV1gzYlZCdUJxZHBiUlB1OTJSeU1zMk5JT1BMS0JTNDJEbURa?=
 =?utf-8?B?RmdYbHBJN3FHYVd4S1JUU0hlOGFqQkg1T2ZXdzZjdTR0ZGhjZkd1T0thdUNm?=
 =?utf-8?B?R2lOSFBHZG9JQ21NT0NjWDdqVXZ5dWpSSzZoMExqbUpWSlFZZERMQ2xnMmM0?=
 =?utf-8?B?MTIzQUprYmpGQllvajJEZVFtVFEyTlpPSHRQdk03aThzM2syYko1dVB1RDNw?=
 =?utf-8?B?RmRDekk5WDRHWnpZdDArV0J4MUFiRUgrQWpNL3EvUzZORXNtNTh4ZkZZQ0d3?=
 =?utf-8?B?MnV3b0QwZmIyRTJvZFJsSXFBTzVTM1FEQllmc2FMeXBGOTRTMlJId2tpNVFr?=
 =?utf-8?B?VDUzZm8xSStyWkhxNlk5VDdwamJ0U3U4eXFDajVlVXZsbXpYeWFXcDduK3gw?=
 =?utf-8?B?RFVpbFlya1VQbjV3eVNVbkk5cUFkWmdWeVFSeHpKWU5JdnhaYkxkaTVjd3ZM?=
 =?utf-8?B?bFdlNFU1VUtwempYNVZsalU0MHBWdW01bnJJc3dwZy9qcEw0M0RERmxJWlRP?=
 =?utf-8?B?ZkVhcEtrREZjQTRNajc1cWVaZTVBNlFsV3Bkdjl4aVpQWmx1OVE3cUxHWVd0?=
 =?utf-8?B?WVVRQ0FSTUlhTjVKVVNlREtFU2xaRkc1V1JCc1hHWlFjSEFVbDBiVXBHaUJZ?=
 =?utf-8?B?c3FGQ3JrVDF5M1NVdWNTVFI2UlVSSncwODF1N0ZuS1hjWWs3R3l0aE1QcE1q?=
 =?utf-8?B?bHN1bVlEa3Z1cmNNRTdXUjhZWmNadFZSck1ERTMvMDZYTFlCQXU3c2lrb0lX?=
 =?utf-8?B?R09QK3lwYkVuS2lZVFFYT1dYWkIvQ2J6UXQ4UFVqYldhSnRXczBkenQ1UkFl?=
 =?utf-8?B?Yjd2OCtpa291K2JjOWJtWW9DdnhLc1N4WEdWRUZoOENMVTlCeVJoSHB3TGVr?=
 =?utf-8?B?M0FPNEdjOFB0M3VYdmRiRWpacFdQOTRia21uMzArZm9rQWhSNW1Ldks5Sjdu?=
 =?utf-8?B?Q0lNdW1ORXpMV1BXQWpaZ21tSlg2YUFlSlRpdjZMYTQyblhPbWY1N0JUYkZP?=
 =?utf-8?B?MDJpNzBtQ2ptUnQ1NlBDR2pIOHdhTGhtd0MxY2RScGdtWHRoMHVZOWRmajNu?=
 =?utf-8?B?QkUxUXg2ODlBanFkWERjRitIcHI3L2hVY1dyRG9qT3N1M3pZUS9GU3FEUW5Q?=
 =?utf-8?B?d2s0eVk0dzFHTDFQNEJYWWRYNEJhako2U1JyRDJObHg0UlJNU3B1VXVyMW8v?=
 =?utf-8?B?ak0wZlV0NnBMVEhGdHlmd3ZjWkJoaGYyNTVDWTZEYWhkM1VGUXI4TVJ3THRY?=
 =?utf-8?B?c1BPUmQzWDVPQ1RYdUNmM3V5YUQ1a2dBNlArQklHV1dMbUJZSncwYnpXRlRw?=
 =?utf-8?B?aUd2VS9pUS9MNnRsTm5zNkNjRms4WUZGaHR6YVBUNlRnM2VKNnp5ZjNiUytl?=
 =?utf-8?B?a1l2WlVRT3R4c2VydUVIS0IrekJCeGFMUDlLSkxCVzJWdXA2UHJRNUFhM0ZM?=
 =?utf-8?B?RklzU2JOZExTdTJGeXZaRXBjNThVQndhRTM4bHpKQjNrY0FOYXlnYUVLbTRU?=
 =?utf-8?B?ays4aStsMzhTL3o1ZSttK0ZCR0ZNYzI3Rk5MZStHL1dmSklvcFBYeHVyaDBI?=
 =?utf-8?B?aks5ckhCaWVKNWNjK2tWZHVSWHFMdUV0S0g2Ly84WXRoOXROS21ydFAxSFQr?=
 =?utf-8?B?TU92U1dZT3dmU3piaUdlWmprZ0Z6MEdGcHQ1dVYrTGttOVQ4WHJOU2FqUVpR?=
 =?utf-8?B?dWdNUVBqdmY5TDNrUU1oWGJaSEpZVWZETi9vZDdEL1lwaFdaNGhWYk5ETkFE?=
 =?utf-8?B?TTV3Tnh5V0NrazdVMUUxaTQ5ckt5TVBPYXZZRVh1aUJjSFg5eWRlcVVyZThN?=
 =?utf-8?B?dW11dXUyNnV2SzhFT2hqRVB6VXdOdzZucDQ5eHlRMDVNbk1STDZCbDAxRkQ1?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706f96ce-ddcf-4a11-0043-08dd71c054be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:22.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E6vjYXuzM3AC+ZoaT062z1OOcbYl4Z+rpMspbKwnjyoYAzwAnBq+VUc0K+r8QxGTGBf+OZN3RkIuT92Ey7HxkamRxOcjBN2cr0i6YHJ1lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: JLCRvQeFv0vYmR8reNvPsk1oaU6gUnO6
X-Proofpoint-GUID: JLCRvQeFv0vYmR8reNvPsk1oaU6gUnO6
X-Authority-Analysis: v=2.4 cv=fM453Yae c=1 sm=1 tr=0 ts=67ecf528 cx=c_pps a=wMNeujlvNozESTkKEiiyVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=VTue-mJiAAAA:8 a=tUPbLDLaAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=dlI4R5ZWAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=4KIj8LpjGsIVfBBbYGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22 a=QrvNcK7Wzxl7WF_4suK2:22 a=BpimnaHY1jUKGyF_4-AF:22 a=_Et68LT86lDbNqPJMOLW:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 585a018627b4d7ed37387211f667916840b5c5ea upstream

Implement a helper elf_load() that wraps elf_map() and performs all
of the necessary work to ensure that when "memsz > filesz" the bytes
described by "memsz > filesz" are zeroed.

An outstanding issue is if the first segment has filesz 0, and has a
randomized location. But that is the same as today.

In this change I replaced an open coded padzero() that did not clear
all of the way to the end of the page, with padzero() that does.

I also stopped checking the return of padzero() as there is at least
one known case where testing for failure is the wrong thing to do.
It looks like binfmt_elf_fdpic may have the proper set of tests
for when error handling can be safely completed.

I found a couple of commits in the old history
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
that look very interesting in understanding this code.

commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")

Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
>  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
>  Author: Pavel Machek <pavel@ucw.cz>
>  Date:   Wed Feb 9 22:40:30 2005 -0800
>
>     [PATCH] binfmt_elf: clearing bss may fail
>
>     So we discover that Borland's Kylix application builder emits weird elf
>     files which describe a non-writeable bss segment.
>
>     So remove the clear_user() check at the place where we zero out the bss.  I
>     don't _think_ there are any security implications here (plus we've never
>     checked that clear_user() return value, so whoops if it is a problem).
>
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

It seems pretty clear that binfmt_elf_fdpic with skipping clear_user() for
non-writable segments and otherwise calling clear_user(), aka padzero(),
and checking it's return code is the right thing to do.

I just skipped the error checking as that avoids breaking things.

And notably, it looks like Borland's Kylix died in 2005 so it might be
safe to just consider read-only segments with memsz > filesz an error.

Reported-by: Sebastian Ott <sebott@redhat.com>
Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Closes: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/87sf71f123.fsf@email.froward.int.ebiederm.org
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-1-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 63 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fb2c8d14327a..d59bca23c4bd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -110,25 +110,6 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-static int set_brk(unsigned long start, unsigned long end, int prot)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end > start) {
-		/*
-		 * Map the last of the bss segment.
-		 * If the header is requesting these pages to be
-		 * executable, honour that (ppc32 needs this).
-		 */
-		int error = vm_brk_flags(start, end - start,
-				prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			return error;
-	}
-	current->mm->start_brk = current->mm->brk = end;
-	return 0;
-}
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -406,6 +387,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+static unsigned long elf_load(struct file *filep, unsigned long addr,
+		const struct elf_phdr *eppnt, int prot, int type,
+		unsigned long total_size)
+{
+	unsigned long zero_start, zero_end;
+	unsigned long map_addr;
+
+	if (eppnt->p_filesz) {
+		map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
+		if (BAD_ADDR(map_addr))
+			return map_addr;
+		if (eppnt->p_memsz > eppnt->p_filesz) {
+			zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_filesz;
+			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_memsz;
+
+			/* Zero the end of the last mapped page */
+			padzero(zero_start);
+		}
+	} else {
+		map_addr = zero_start = ELF_PAGESTART(addr);
+		zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+			eppnt->p_memsz;
+	}
+	if (eppnt->p_memsz > eppnt->p_filesz) {
+		/*
+		 * Map the last of the segment.
+		 * If the header is requesting these pages to be
+		 * executable, honour that (ppc32 needs this).
+		 */
+		int error;
+
+		zero_start = ELF_PAGEALIGN(zero_start);
+		zero_end = ELF_PAGEALIGN(zero_end);
+
+		error = vm_brk_flags(zero_start, zero_end - zero_start,
+				     prot & PROT_EXEC ? VM_EXEC : 0);
+		if (error)
+			map_addr = error;
+	}
+	return map_addr;
+}
+
+
 static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
 	elf_addr_t min_addr = -1;
@@ -829,7 +855,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1041,33 +1066,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk(elf_bss + load_bias,
-					 elf_brk + load_bias,
-					 bss_prot);
-			if (retval)
-				goto out_free_dentry;
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *)elf_bss +
-							load_bias, nbyte)) {
-					/*
-					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections. So
-					 * we don't check the return value
-					 */
-				}
-			}
-		}
-
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
@@ -1163,7 +1161,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
+		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR_VALUE(error) ?
@@ -1218,10 +1216,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (end_data < k)
 			end_data = k;
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
+		if (k > elf_brk)
 			elf_brk = k;
-		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
@@ -1233,18 +1229,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk, bss_prot);
-	if (retval)
-		goto out_free_dentry;
-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
-	}
+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
 
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
-- 
2.43.0


