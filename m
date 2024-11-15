Return-Path: <stable+bounces-93075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032E9CD5FE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 04:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42C3B211EB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 03:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A171747;
	Fri, 15 Nov 2024 03:49:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2251C68F
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642578; cv=fail; b=BFJLT42+Vu/8rMm59vt6gzXhSrrHzP+0JZzTe6HETBqM4xrHATUhkVERp2i6KtnkYdHYoxbB9yrCym8HQEcIZfrMV5Ewk8EhFHZbfEWivubLNW2ckYj/y/9FTC3gA8ESVluMjln2XDujvjwAxdKbMtTlgxIbEkV6SupP6JdA/PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642578; c=relaxed/simple;
	bh=W4aOwMICZqoMrSUYLpJLkkPz0YhaTJQZzjkQEvx5syM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VQuNNpwaaThQwQlh1TQI0JFcnqR7CUEsfoPn0MWg7/OQa2KQGp+QOHvVBXfpOx49Az5n9sr92E/06+ny8Ugvb/SDOmr778tEkp2gKCmJ2+4u2OtT3tzc5KYJP+q0ZsH/s5UqSQvbSdJVfCmO01ZbksH3FKTR/0bTze2olmw25uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF2XHPv005741;
	Fri, 15 Nov 2024 03:49:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwv4cpmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 03:49:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnpNv5oHQy2WWigCJtXfhfbn67yNSM3vkE6ICfoTd7+2RfjKw3hFINCWR6lQzos0QQP+fyGvohm5eWkTYih5NKYDmLU/rB234iqYOl/Dstl8rmwyU/Y6Exlf/zOBMCA/yhCAs/QuM5IOvkybxJZNSPDxNBCYUUN+VimvSSxCJAcSnqwo61rlkYB5Vzlk69ZN3gDENLqhxHo0SDQQMy7qy1iMNDFDaC4qbjhWAJipH9KbrIaVhvFceyL7WiAvlxWA0tY+CDCpu4dTwo3tMIj7P1eXGRTk7OAyexCPwFNNl0nszVwo3PXMGR3KZpcZtNfr04iXe73kbiao+Yte39/cVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoHuXqBWMWvDzWgMXE+nIAZzML5rqb8STO+g+SfcWV0=;
 b=c0EamEMS7w1KxfkatLofaapB6sqZ7ryubcCCWGriHsqY35jcnJu1grhrx7UGoeH7jeH1v9S37GDjQORJ49PJF1bcsDFV4Oa5fKtX2q8mqbaTzb+BHaX9LLOg5jhExKoIpe6Q45CgWS/FXGqw2+wdUkF01uvpooVrwux+oHA4YdJgXf+h/6Je3k47C73Igra3h3EQtDY6aKPpkipG8FR0DF4W3kIKfJF9f7PEedPm2wtUDpjj65QlAcnpB0A3GZjqzgr/ZNgQ1kcCY8xWLd9iYeokJyZ4gGJU6evMmCMsUENal9oFVR7mMDyxMu9A2bMuuhTgYIauH7N1OumicQ8kAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:49:22 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 03:49:21 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: Philip.Yang@amd.com, gregkh@linuxfoundation.org, felix.kuehling@amd.com,
        alexander.deucher@amd.com
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1] drm/amdkfd: amdkfd_free_gtt_mem clear the correct pointer
Date: Fri, 15 Nov 2024 11:49:25 +0800
Message-ID: <20241115034925.2835893-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0192.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::18) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA2PR11MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: fc31dc80-90ec-48df-e927-08dd05287d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzhQOXUrSmZsUWtXYVJ4OWhOM1lUZ1Q2ZGJJSks2bzdnMGE1RkI1S0s5OVZZ?=
 =?utf-8?B?ckNVUVVSQ1JOVXZBMVRCRXJoQTBTOVJORDl5TFNhaVB0Q280aGl6ZjNxVXpH?=
 =?utf-8?B?T1FDUDNEYkl4d3lJVk9TWlhWOFdnNmlhQzFUbVY3L0U3MStDUldrbEorSUlQ?=
 =?utf-8?B?ZE9HRjVhNDZzOERRM2h3WSsxd0ovNkxlSldJcXErdnBTb1R4N05QNmdCY2Jw?=
 =?utf-8?B?VGw3c2svOGtpYlBQWnlteE5RSVJ2M3BseVdBRHI3QkJTSm9RN09JRnVWTU1O?=
 =?utf-8?B?Q1h4RHZCWlRRTkxxNUhpMVQ5emxIRDBWY3pYcjYrRnNReFpzRUVsd2ZNNjUz?=
 =?utf-8?B?WkVodGlSVlA0Sk5yREpneDA5YTdacDBxRlJZeTVSTWtjZWp1d3RrUnNrV1RX?=
 =?utf-8?B?TXlVWGRIeDVDbFJ4bVJpVC9ENURPNjBlVVU2SnVlS0xZNnNjVVk0MnA5Szhw?=
 =?utf-8?B?WlBUSkhLRHdCUWhoK2JXakhtV296ajY0TEROVGh2RXhjNnVjK0phaVdoaGtV?=
 =?utf-8?B?YkRwM3R2OW1wanVEOUl3SWhJaFdML0lEUEc5bHFUNnZmN3NCcStWb0JXVzc1?=
 =?utf-8?B?KzRvSkZTYlZvVnkwNjFYc3lnZ1RoODFxMnVNWTBBWWhBT2xCejB5dTM5VE90?=
 =?utf-8?B?RVZZQ0tJTE53VEY2TEVOdmU2ZU02Zm1BdmJhaGpkaTdOSTNKS01BdlowNjU2?=
 =?utf-8?B?empxWHovcndEYzVkTitDc0phTkVSYUt3U0prR1JwRGZxdzFNQmRlbFNYUkNN?=
 =?utf-8?B?ejlleEkxTDVHa2JOV1FOZ3FtOHQ2YWxGenFSY29hZ2hONCsva0xHeWpOV082?=
 =?utf-8?B?Q25oeXlyRk11OXBCY1d4L2k1Q1k3QXJYOGtJamx3bEF6aGFpQnRyTnF3Wm5W?=
 =?utf-8?B?U2l3allxWmdSMlkwRUFaZGl1SEJlcTdIemdNNGZ2V1lLN21zeXRRYmF4Qk5z?=
 =?utf-8?B?a3c1MUUwT21uVHpBWjZydUE0VGI4dmIwZFFtdm1uWk1aWENvVHFuMExFdGVR?=
 =?utf-8?B?YmgwV0tJWE9hUWE2cVJjRjRhWUdUcTU0T1U0MVZXVlN2VVY2U0VhVWNWZGxN?=
 =?utf-8?B?NWtQY3hhTFVNUGNJVGJaS0hhditOZm9LWmJ4NFZ4TERoU0svemd1QlJJaVBU?=
 =?utf-8?B?MGgzSnFYWlVrRXRQalVncDRNdFJicVYzbjN4S3lJemlZRUxhb3ZDMTFod3hT?=
 =?utf-8?B?OTVWNFpQV2RySmlvTWZwZU9WSkNRMkNzNXhaRkxEaS9ldnMwSk5IdXZjVUlz?=
 =?utf-8?B?M1o1elRVUmcyK1Z5SlY3aUl6TmQ4RVpXd2hocEd4NEp4Zi9PaE9LNGNDeVJm?=
 =?utf-8?B?ZHlINFBwYTZ4cE5tZ1pUZ1JjQnRLQTlTcmp0bGhudTRPRVUydUdkc2g4NEpF?=
 =?utf-8?B?NUIyMkxMMzBMV3FJTTF2enpHYkwxMmhMb1NlRmNubFRaWTNRSDl4T2I0Y3Rv?=
 =?utf-8?B?THc5WDlQZk5TemFjbzhLa01wcEtUcENZTmxMdGl3WnFEQWE3WHllL0pIZFdQ?=
 =?utf-8?B?aDFBYVhKRkxtd3lIWEZlRGxOTHhvK2xqakY2Q29xdGZ4REs5U1E4SUNWZTk1?=
 =?utf-8?B?WFc2SjRocUQwVXJCbW14bFkxMTZ2dkNGdDk2cWRPc0ErWVVUbXBZVHRTd3VR?=
 =?utf-8?B?a3dieFl0bnVVRm9qTjlpd1RLcHRjemp2NHNnZ2I3bEhiYXg5OXlvQ0tRbXBD?=
 =?utf-8?B?dGRLZzVtdS9nY3JGKzF3WWdHNWIwaHRzeVptdGVpYXlLTUQzbU05Q01EcERV?=
 =?utf-8?B?dnNxUEpBdmV1bTNnN1V4ekJMSTVkdWNMR3FpM2lDNWxhOW9vZlMza0FuZ1Vu?=
 =?utf-8?Q?mpBnJq5+kjS5yuVyyVK7I+Zp951r/FIZgxbCg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkNLQWdXNWZtQmlGWDhpR2MrV2RZVmJZc21LZkV3NkF6UnNucVdJdVFhMk1N?=
 =?utf-8?B?RUhCWUlvTTRvOGJmSk83N2hYWDJrSnk1U1huTTQzVmFtVXo1emxaYmoweVh0?=
 =?utf-8?B?ZitsWFl2VGMyZHhRNmtjNHdNRnFOKzc2NHBmeHdJUmFSbzZBckRiSC9PdVRQ?=
 =?utf-8?B?Vm91SzV5L1loRjF1MTVLWnR5dFk2UlM4UzAxUGhCMmZCOGVaeEFqY3d5Rmpa?=
 =?utf-8?B?cnZOVC9CZmNzN3RSTU84a1dSUjBRQjNhNnc5QTdoamY1QWRDeisybnRKYW5u?=
 =?utf-8?B?VXJEOE91YTR2QXdkaWRRSWdjMmtwQ3FOMm9udm5jZGZ1TWE3WU50ZWJDdU8x?=
 =?utf-8?B?QkhNUktsbmdjQXlSc2toZjNQbmN0QWpHM3lYZVIvdG5VY3ZIMGNlVUY0d3dT?=
 =?utf-8?B?Uy91eXBoZTFvcTlFVDJnRDZMait0dTlMWk5FK1JocXArNVB6dHY1T2UxRUtM?=
 =?utf-8?B?a1YzbXVEUkpiSEt0bE1kWTFOU0xycEc3LzRSVHpkWDM2TzM2cXBudHphVFQw?=
 =?utf-8?B?Z0s3QTRna0hNeEhWZElaZzFTRUlwazMydk8xa1BXTVpxd3FDanNXdkJiUXN3?=
 =?utf-8?B?NjlYS1NGWEJ0VFlpY3k5QnN6Q3BGODI3cXI4N0dRUHJOVFRuRE9ISWhHTy9p?=
 =?utf-8?B?L1RqREpybUk1QXhRSVRjNWViNC85YmxiQ1pPWUFJVTlmZW9qLzdYQXZFZTAr?=
 =?utf-8?B?ZkNKSytXOHNBU0JHWkxHMkRITmV1YmwxS3VOTnY0ZFNybTJHRlE1d09GV2xX?=
 =?utf-8?B?cDlxdm5XYmpkczZxd2pnZWZ3d3poR3hWeFBERUlNU01GcWNqd3d4dFB4Rnhs?=
 =?utf-8?B?MmpzeHZ2MUNLR29tZVJLUVJJcFVHUlIzMSt2UGNOd3Q3dGZZUWJTNXRWdVQ3?=
 =?utf-8?B?aHM0Zjd3ekpvTHdFb3JIWWlqZEFEMFV3dC9IUUZZWEk0RjJIS0xmZlhtUi9h?=
 =?utf-8?B?b0hja1Y5MmtaK1pDUTBJTTJWYzdMYTBnVmUwWGxaRjN0UEJkQ2VOK21hVWpW?=
 =?utf-8?B?VDBLTHJtallnR1RJbHQ3d1pjRTBPT25hdEo1em1QK2JmVlVsT0lCdGpFUENz?=
 =?utf-8?B?VmVsQzkxNzlTeGo5NzNXSWNPalltN3IwajdVYXZGeDJWTnZIcFV3Tlprd3BP?=
 =?utf-8?B?Z3FlMHhsby9uME5hQVdQQTJkSk4rTEJFZkt3T3BkTCt6eU9jOFloRHo2QUZW?=
 =?utf-8?B?dmlNeGw1ZDBZblZCL0dXK0c2cGZ6aDNyWmtreXZBM09STGR3MmNYN1h1b0NZ?=
 =?utf-8?B?ZEFvL2tzTHl6cFFyekVKQ056bTJlakNIbEJVcUlhaVlWWHkvOGFsa1EzMzdr?=
 =?utf-8?B?cWxVZ0VMYkpFUE5WNW9Lcm5TUXhIanQwMThDdWJyVXhkYzhubTRBTEtiZFVT?=
 =?utf-8?B?enEvQllqRVhpTjA3bmYyVFZvREt4cDRObWpvcXRSQmc4bEhOYjhCNUdsd1Zp?=
 =?utf-8?B?ZjZ4bU5NRUE0L3BXTUY0WTBQcUVYSlFEaEFZeXZka3VBLzlIUEViZVg4aWtE?=
 =?utf-8?B?UlFWNEdWV0JlVngwOFY5Tmg0enBvU2xJdmxWcjhxVlZhTHYxL1pEZ3JCSG5L?=
 =?utf-8?B?UXpMYWppaVRnQTBSVTVYSUp3STM5YmJBNDZiUVVsMGErdHhtVkdramVjMXFn?=
 =?utf-8?B?ZTZrOTl0SnpOK1p3WkQ3QTB5VnZTdXFMaVNEUGV0QlI1YURlTVE2Z1RVVnRP?=
 =?utf-8?B?K0ZLdzRZMml4ZnJzb0dsVGVIZVRwNnUram9uc3BGZU5yb2pOSFVjUloxczNJ?=
 =?utf-8?B?WGQ1QmIwNDdmazBTbllTNm9DWGJGYlFlcEhnbmFxN3FxSHIxUXJmREVxMWxB?=
 =?utf-8?B?VmJIWEJjWFNyNW9xaDZFTmN5dktaT0tMU0laT3U2VFgyV05JR0JyaWpwVkov?=
 =?utf-8?B?SmpzUm5TazErSTZFWEtBRXF3N3RXcmVROVBmWEtNeERYMkNaYXZOYWxUMGVN?=
 =?utf-8?B?dzNNc3d4cnFNSDNaWXZ0c2FIZlNRN3k5cEhNVW5zLzUyeVMzbm9KRzc2OFdw?=
 =?utf-8?B?UkFFYUpQUDEyOEd6N2VOcTBvRm4xbE0vL1Qvck92Mm1EU0NYb1YxcTVkRFZG?=
 =?utf-8?B?N21zS0R4SW12UWh6YlFkcEJJSm5qbXozdnp5a1RoSnIvUithOU5xSXY3bU5S?=
 =?utf-8?B?MEdPSi85eXVZNkVBeTA2REJEcWo0M2VIenlrNmpLbmY2U3dDaEp1UUI3RklM?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc31dc80-90ec-48df-e927-08dd05287d3b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:49:21.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tbrRkrYMZpquSjBRcxu6n9P/FtfX62aEyjIgJ0ITnXZ+CAn047a+0xudTuiVWgORByAl5mwEEAI5ff4bTD0aipHzErl+4ARqES67F2P93k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-Proofpoint-GUID: cL4zLlhTZxF_q8YXTIGa8n_gSuslJnPk
X-Authority-Analysis: v=2.4 cv=Ke6AshYD c=1 sm=1 tr=0 ts=6736c4c5 cx=c_pps a=F+2k2gSOfOtDHduSTNWrfg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10
 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=u3u2Y-a7RVnL0Ifhj-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: cL4zLlhTZxF_q8YXTIGa8n_gSuslJnPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411150029

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit c86ad39140bbcb9dc75a10046c2221f657e8083b ]

Pass pointer reference to amdgpu_bo_unref to clear the correct pointer,
otherwise amdgpu_bo_unref clear the local variable, the original pointer
not set to NULL, this could cause use-after-free bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu:  Bp to fix CVE: CVE-2024-49991 resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5d9a34601a1a..c31e5f9d63da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -344,15 +344,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj)
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
-	struct amdgpu_bo *bo = (struct amdgpu_bo *) mem_obj;
+	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&(bo));
+	amdgpu_bo_reserve(*bo, true);
+	amdgpu_bo_kunmap(*bo);
+	amdgpu_bo_unpin(*bo);
+	amdgpu_bo_unreserve(*bo);
+	amdgpu_bo_unref(bo);
 }
 
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4b694886715c..c7672a1d1560 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -210,7 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj);
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e3cd66c4d95d..f83574107eb8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -408,7 +408,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 
 err_create_queue:
 	if (wptr_bo)
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
 err_wptr_map_gart:
 err_alloc_doorbells:
 err_bind_process:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 27820f0a282d..e2c055abfea9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -673,7 +673,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 alloc_gtt_mem_failure:
 	if (kfd->gws)
 		amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
@@ -693,7 +693,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 		if (kfd->gws)
 			amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1b7b29426480..3ab0a796af06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2392,7 +2392,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, mqd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 623ccd227b7d..c733d6888c30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -204,7 +204,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5bca6abd55ae..9582c9449fff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1052,7 +1052,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->dev->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
-						   pdd->proc_ctx_bo);
+						   &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 99aa8a8399d6..1918a3c06ac8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -441,9 +441,9 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 
 		if (dev->shared_resources.enable_mes) {
 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
-						   pqn->q->gang_ctx_bo);
+						   &pqn->q->gang_ctx_bo);
 			if (pqn->q->wptr_bo)
-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+				amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
 
 		}
 		uninit_queue(pqn->q);
-- 
2.43.0


