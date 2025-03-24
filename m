Return-Path: <stable+bounces-125846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C993DA6D4E8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5AD188D1F2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99719885F;
	Mon, 24 Mar 2025 07:21:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22794433B3
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800874; cv=fail; b=R2dIQ+LxynZebv7jDacMl/auRTvkg8zGu+QzZ2yCeawFKoFj1OorjECSh+rhRhbbSnbt1IT3xGKfbLELMLRpqNKuzljVUlQuM5hjhuJBqxTcDOfXbtrsiyYwchZmstikZ44nQRELzQyEuvSbrShOw+zlSpOi9GroY4DbZn1QUQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800874; c=relaxed/simple;
	bh=5QA1d9MhdJ+q2x65TA24O1I4tARt8Dy4qdzwzpW0dJc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UvJWCsj70/woPi+2k380oV/G6AioB7l8JHPuhUH2k4GusnOID9n9k/6JsohN33Oxw4sM84UMqvkF0+PND6OCgABMqcE2iKfwQEcbKi0IRd4PF+mmVzLaNpvBme4U2ZxoyI3DesLqsu3hZwkNJs+9ACawqCcQDj+LsGknMVey8F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6Q73u015713;
	Mon, 24 Mar 2025 00:21:10 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqk9ffq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 00:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4FqApeppH1WbkjfsoUIJc5JsWRW/lxGWipOVh4u0ZiauXHlAKAhzMRGM8eBFT07PaQ/bQjcPltrgn9U7hvUUyZw8Ky9EUngM25JagaaWMqQr/qmTfa1KvW/H5HeeENoQp2RubJjYui83ujBbazIO3wrMuGZqkfHorGGx0/uCZAVtUTKO3mzO008enrLDwT+eVLA72YX/MbHK+bcXQkaSQcKO26NGc8gYhMurp4jPl1m6QuvzQ/9XCyNHVrMgtWp32CHvLzBa5jrpZLQGuxWwElSGcMcDSKoCIOEjkq4ZQWBtJTmO5ZfkCiVuQwfuMBlN2XKAlRY6Sbq3neh1yWzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFbzMOoEv0Ip6NKn1kCnxdn9ZvMb3MdhuWLic1z0huE=;
 b=O8aGrQXsuVKaTIqXfAFCR4WZ03ioD0IYL7UKbZ2xW1dcM+74ihywvNg80+RpsI3hPTfkbosbK3qa7yVqrnjRAuf9sJipgxFwRwU2KlMX3zEyFp+RFnj6l8vnvpTgSxkWpJeW5/5lk0rYpr4Ub6MlKhVir6BnSPMBeCgAI4qMC6J5cLUgt3+SnTNnXONrL4+aY+rqNfue3Z7zlDFUXa5OOvshaH2CKCZwgIk4gsxw9YnXFEggU/bAopdGoqa51R84B5vRiSnK+6BK42FxICfT5oUOJUjC1D/4AU34cP+cGXvcA4w39upbHb0AoZK7UnSuFT0kx3SB6IOFicjqirNJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:06 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:06 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 0/7] Backported patches to fix selftest tpdir2
Date: Mon, 24 Mar 2025 15:19:35 +0800
Message-Id: <20250324071942.2553928-1-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c2b190-e7bb-4909-551c-08dd6aa47108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDlTOGZSZzZwUUtOMTlUM2lXOWlkVEJ2VHpVV2NCM1ptUmNISCtRVW83eTFj?=
 =?utf-8?B?ZVZsUE9aWTltTmpWMFNUT0UySWVJckt5SW81MHRheURxL2dZL1VjczBGS2x0?=
 =?utf-8?B?VFFKWWRhb05SbUE2SnJxUFhmTlNJanlLT00rR3hTMFFNR0JFM21zb3F1a1No?=
 =?utf-8?B?bHlpcXprbGtoSEg3Y3UrR0lyZ3c1QlVjdlJURTcwLzR2THhVazlGci9CS3N4?=
 =?utf-8?B?MTh0OXJlSnVVSmJyemFUTVYxMVBGaFRNR0V5UTRTRy8zNUE0Skh5c3RReVNr?=
 =?utf-8?B?ZnpKYlVjVmR4MXozcVJYcisraUZqS0p5Sm9rTnBTQ0xJckxoek5GUTdoMjhD?=
 =?utf-8?B?WjZKWFp3UGpkNEF4bHdSSFpIMmEyQSsxN09BTWJXZWlrM3QyMGxudmNhUWZH?=
 =?utf-8?B?b3U0eThLdGlMNURyMkVleWpHN2FXNXNGei9CaHJMMHFrYkg1QTJ6aXhQajFO?=
 =?utf-8?B?NjNWNC9yQ2haYnFheFJXWDg4T3g3NlNkQlptMHNGQUE1TW5KVEZ2SWVyZ0Iz?=
 =?utf-8?B?TSsrNHJnQXV2aVQxQmF1OXFMejIyb0l3WUxNTytmR2huRnhMSE5ZamRFYlpz?=
 =?utf-8?B?YkxuY0w1TTBBNysvR2doaFZwdmg3cXRUbFZqUDFHYzhpYnlJM0VITlZDQUxH?=
 =?utf-8?B?blJpUitGeExEV3pWbEEwdHRIZkt3MEtUb1llT2VPZ0lpcy9jR0VwOFoyczJN?=
 =?utf-8?B?Qm5MbklQRDgvcDFSSnZ4RERPWWw4YWZzZ3czMmRqTU5INm96VGRhemY2T0hM?=
 =?utf-8?B?Um5POFBWMlNRSFdaNjhZTlVUWWxudXRsT21YeTdyczVxdjdXQlFuM1dyQVY3?=
 =?utf-8?B?N2V0ZEk4cVZ6UHBZUjJyTXVkVkZ5Um85QldUU201NzVCa3lDQmNXOFpoUVhq?=
 =?utf-8?B?L3lVTDdrZm9LejdhcGRudjAybHVHampiMnZ5RzNrcy9OVzN0a0xXNVIzakps?=
 =?utf-8?B?QldVd3I3RG1xdkNzUHcra3ZVUzEvS1NjWWdTWWx5QlV2engvenFpK2UxWjly?=
 =?utf-8?B?VmJ3UGlVcjY4T1ZEQUpHbGxuZFgzd25wSWwwV2RsT3M3a0Q2Q3BpTWowM0R4?=
 =?utf-8?B?VUMzTFNpUXNQL280REJ1czMyUHo5T09LUldueEIxR0lmWDhNR3ovTk5wc1hZ?=
 =?utf-8?B?S3NZaXlCVlBzYW94RkIzUWJ1WmlRZEprU214RW5SeTFNYzhOVERlZDV6TkNa?=
 =?utf-8?B?VEtiRWtGVk90REFqYUdCY0JBam82SXdjWWJxckZYaDZsOW1NZmZrMTdJdzE3?=
 =?utf-8?B?bW5WdzdLQ0Mra1FiREQ5ZDBNQmEwTHhDdzJGUUFDRmpZUWpkaG5veGFGbjk3?=
 =?utf-8?B?cW16NktWckNWaEpFbWtNQ1p6TktkK1E1d0MyZFJidzdOeUV6K0c5TjRqM2lQ?=
 =?utf-8?B?SXUyaWFBSUlmK2pab1I2Y01SSXRya0EvSjVIYWtuMWJray9tQlhKbi9vWi96?=
 =?utf-8?B?ZWMxOUtsT1lxQkxxdDUrL2dTM3JnUVVEOEU0TFFIUjUzWUVIYWhQMDVxYTNL?=
 =?utf-8?B?eTg5RmRTRFNsSzNUcUdSa0duS2tiUDNZd3FKeXVuaDFjNnJrS3l2UkpyT0ZI?=
 =?utf-8?B?ejVhalJpSkVDTjVqbWpsdzRvWUZMSTJnNERxeUxxVXovTGJ0QnVBdEdVQjl0?=
 =?utf-8?B?dDlZeWxrMEpFTTV4OUNFbkxYcXVqY1hxYzI3ODJuK1lIYVNiekZYcDdzUXRS?=
 =?utf-8?B?ZEhtQysyYjVGbnoySmc5cmNjdU9ST29vL3c0dG8wL2E4TUdBazZYRE5yUVcx?=
 =?utf-8?B?YUVyN1FRRlcrTHhxUWJaeDdFRnVnemU5UmpkcTJ6Q3ZJYmVLUEVpanFMT3Fy?=
 =?utf-8?B?a1dKL05OdzU5bFl6OGYzcU9idHdWTWpBblM2ckhCMmc3OWJUNVl5N3JyenFv?=
 =?utf-8?B?WWIxSXlMQi9SbHFhRnREd3BUUVVLNSs3ZHloeGNHeGZaUmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckVYcTBTQWc0UTV1eTFkUmNPWlU1RnpEYUpkcWptSjFlUWZhb0Rta0R1V0Z1?=
 =?utf-8?B?b2ZOK0w0QzBQNUtjV2Y0QmhOQy9UK3Z6YTlLOS9hVzRKTEFFVWVmR2hzTXk2?=
 =?utf-8?B?RHArR3JROHJOeHozSllFaHlxakVrRlFXcXBDYkt2OXhISEQzZGFNWndwRGxO?=
 =?utf-8?B?bTZGc0o1cFJWSkdFcFZtaWxmV1FKSFl0V0FIQ1o0UVZwOEt6K0dMdjFQSXhq?=
 =?utf-8?B?V1FzdzJTL0Q1UFlVMHEyeG9NTkt0SE12Sk1BMnZacTQ5MmlxSmZlTVhHZytR?=
 =?utf-8?B?cG1YSDdNQk0wZWhIbTdNT0RTREljajVWOTloQ1l3ZG5vZW5ZeUhOVW9ldnFD?=
 =?utf-8?B?dm9OZWNBWjFnNXNtek9zcXRONDNNQW9ISi9ubFo4b2ZZVmlzWjFGSFFSdHZP?=
 =?utf-8?B?dXN4M2UrVFlUZ2I2VHc4RmJ5ZHlOeFdZa2hvRnVFampBWlNKbnUwN3RjWkxW?=
 =?utf-8?B?ak43cWJXdDMvdGQzRjJmVnhDRXVVK09uc3cySHF5ZkIyYlpCODAxY1hxbnVh?=
 =?utf-8?B?UHFXd1EyMHYvUFVvMVJmb1F3QUhSQmZabUx6UkpIeDJZa2RSZENjS2hSMHNK?=
 =?utf-8?B?Y1NPekwvTXl0VmlEeVIxdjRIZzhMWGRkb211cGdkQXVBSlVHUlBVMjVYTmxZ?=
 =?utf-8?B?eWthZmJHVmZJYUVoYkJhS0VGcGVzZGZLQ0d1eXVFS1JnYU4wUlZEWEhkeURQ?=
 =?utf-8?B?d0E0NlAyS3BScXNEdEw0bHNVYVZ0OW11SHdWOVNVMHQ4bXFuTmwwcmc3SnA5?=
 =?utf-8?B?N0RxSzdaRGRhNGo0VDJBN1J0aEdiMWpwcHIrbThrTmVINisxUm1pcVpxbU5D?=
 =?utf-8?B?YUxybjBiSXhERHlZRmg3OFByNlFPMEROWGo4dksxcFgyVXpnNzduR291M21x?=
 =?utf-8?B?SFIwNHBoa1NDUDRmOUY2R1JVQkV6WUNlMWZPK29jMkMrK2FuRFBjMCtmT2Zu?=
 =?utf-8?B?M28weU5jc1lFSmVsKytQYS9QMEd0TWZUcERHb2MwMy9JdG9vTjdCWmxTSFZC?=
 =?utf-8?B?T2pqU0NuZlE4aHZJd29veVVaREpxNWJWRFBubDZhVTVSRTZ2MU1oenNWR09X?=
 =?utf-8?B?TFhuNG4wVnREL3hHc3lKbU41K1JCYXBMTzIweEMrUjcrQUhsdUxCWEV2S3BY?=
 =?utf-8?B?SzBFWVNFQXdlZWxHNHFuRyt6NHVvV0dvaE9XUThXb0ZQNVk1RWVDNDNWM3Uz?=
 =?utf-8?B?YzRURmJ2NWY3TVhZVU1lUEJsNEhCZExaSEVsWW4yZTlCL1ZzYnNSSGsvRlo0?=
 =?utf-8?B?T09EdTFxNHB1TEpVN0s2Z1AyVlhLajJPMjRVNVMzTmJhZjNZUUZEWEt2eUta?=
 =?utf-8?B?WHl0Zlc0azJsNThPSHg3Qkoyclh3dTB6YkNDc2ZSUlIvbzA2WHF3aGhNVHB2?=
 =?utf-8?B?a2dWbUdVT25EdjVmN3RRSWU1dXdPUjE3Q2ZTTG16RnAraFRTTjNHVHY2eUVY?=
 =?utf-8?B?RnlpWFFITHZnLzdHUWlFYm9zRzV1clI1M3hrNitzTWtiMndTU09sNW81QVN3?=
 =?utf-8?B?M05VZkE1SnE2elNxM1dCMXZUZDlpNlJYanljWlVMUkh3VW1sbUdMeWZwcVdK?=
 =?utf-8?B?a1JMbEdEN3dZWXA3a2FtRGhHdDRuOEZWV0VoczQ0dDZIanhhWFl6N25ZZ09C?=
 =?utf-8?B?cXQxcFlkVUxVOWVkbGgwSnVrK1JqTkNZeWd4MENodmtORzl6ckk1Y2VUN09m?=
 =?utf-8?B?SUtiK1lCODN4UHI3Z2hZejUvaTVFMGlqUFJRSkVvRDdBSzdQaXVLam03Z3N0?=
 =?utf-8?B?WkUrcjZpZ25CWUdtMFJEVjBqSkxLemErVXMzVi9YWnExMVplWWQ3alNFMW9x?=
 =?utf-8?B?MHJvY3EwcEpJV1BBVmtxZE5CNjJzWTVHbmJLK3U3d1F2ZHdOc3JtS1AxTmxz?=
 =?utf-8?B?aSs3T2lWU3FTR2Z3TzZBdkluWngvWW5xQ0VuN1BQS2lRYldoaENEQUpJOVB5?=
 =?utf-8?B?bVJzY21BRnBsbzBTZ1gwNGxIOVgyWHJqZ0NqbVkzMDhsTVdKNGxPcTlORloy?=
 =?utf-8?B?MTN1R2YzbnBlUDZGblUxNmRmUmEyYkcvNFNzL3Z6c0RMUm51Q3VrNCszSnVw?=
 =?utf-8?B?TytnK3ArL2NtamxhTllJSXRGMU4wbW40RC9pYkRPMk1EQ3MvV3ZNUW8zR2FN?=
 =?utf-8?B?MDl4UE94TjRCT2VHQ0g3QTNVVlNNUys3SksvbWdCZlN0REVrSFNmOWI3Z25j?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c2b190-e7bb-4909-551c-08dd6aa47108
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:06.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKPn4bPutL3kbLDIYCNGXC5rWoslBnSWIFIW+eN898Oxs9935Qmd5iC+4BPPmILuMJRH8C3WpFXQc5ZibEvEcI5n7k97N2B/oP59O+MKw9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e107e6 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=tJ6AMal6JwgurfG4cqAA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8KoF0UqDJTSLxZ1sd0ja2FfBPIl18w9j
X-Proofpoint-ORIG-GUID: 8KoF0UqDJTSLxZ1sd0ja2FfBPIl18w9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=899 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Wenlin Kang <wenlin.kang@windriver.com>

The selftest tpdir2 terminated with a 'Segmentation fault' during loading. 

root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
Segmentation fault

The cause of this is the __arch_clear_user() failure.

load_elf_binary() [fs/binfmt_elf.c]
  -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
    -> padzero()
      -> clear_user() [arch/arm64/include/asm/uaccess.h]
        -> __arch_clear_user() [arch/arm64/lib/clear_user.S]

For more details, please see:
https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/


This issue has been fixed in the mainline. Here I have backported
the relevant commits for the linux-6.1.y branch and attached them.
With these patches, tpdir2 works as:

root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
TAP version 13
1..5
ok 0 skipped, TPIDR2 not supported
ok 1 skipped, TPIDR2 not supported
ok 2 skipped, TPIDR2 not supported
ok 3 skipped, TPIDR2 not supported
ok 4 skipped, TPIDR2 not supported


The first patch is just for alignment to apply the follow patches.
This issue is resolved by the second patch. However, to ensure
functional completeness, all related patches were backported
according to the following link.

https://lore.kernel.org/all/20230929031716.it.155-kees@kernel.org/#t

Bo Liu (1):
  binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()

Eric W. Biederman (1):
  binfmt_elf: Support segments with 0 filesz and misaligned starts

Kees Cook (5):
  binfmt_elf: elf_bss no longer used by load_elf_binary()
  binfmt_elf: Use elf_load() for interpreter
  binfmt_elf: Use elf_load() for library
  binfmt_elf: Only report padzero() errors when PROT_WRITE
  mm: Remove unused vm_brk()

 fs/binfmt_elf.c    | 221 ++++++++++++++++-----------------------------
 include/linux/mm.h |   3 +-
 mm/mmap.c          |   6 --
 mm/nommu.c         |   5 -
 4 files changed, 79 insertions(+), 156 deletions(-)

-- 
2.39.2


