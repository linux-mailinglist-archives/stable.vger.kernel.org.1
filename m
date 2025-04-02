Return-Path: <stable+bounces-127393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C93A789CF
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684D67A3CEF
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9554234971;
	Wed,  2 Apr 2025 08:28:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A913D53B
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582511; cv=fail; b=GFt8jW5kqvkqhFHHVp+l9WWln9wt9xYVX8FtIhOK7eeXZqAtLLJbOj1nv/MAqEShpwt3ioxsrazDAvVnmiU4Qo69YApgEpiu7582Do+aGMxqq+n9zdbjntGr/QEMP3YpclkvsrTolMy2oITf+T7vS0MurFqWMtr+9CAYgIiyuLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582511; c=relaxed/simple;
	bh=R1up9mTCuB121G8dte3lRlRYMv9hP3u+AqCl1dV4Bu4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F0fFrmAYUZEMT2WgnT2gOA0Cc6OJR+lyAuKmhyxxfWMiZkQEIfExvHFTMEiD1kNSRoRQqpzmWZeCZv7Dfd0+MfwMyq9h/gveUwirkyOlwNead+Ry4wEAS3qRuBE+mmncqmdqkZhat5ixwvsn/yExmpr3uNUXsml2+5YAICnlpP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5325e2mV003875;
	Wed, 2 Apr 2025 08:28:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtfn0gjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 08:28:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v69YYOyMS/iBZFcfvXpPsq89S2p2PTZo/XJCtpePEeOhRR9jbuPxJKl/wHx6XAakT3kAWQ6+gODwzIuglWV20mTjbwomfOS1Ubi3qwSUR1AtmkI58/bT/yP+u1xggypfGFgzBLnn/J0ZglDV2N0gKIJipjlrK3dYQjq1+6JQl4C/NZalTZY5H1micONx227FZh8EjlwvdEiLcdDFnPaoFgo+dxMUv972IWwxLskORoNrU47DrwL+jFgdLa5GIrg7fhjjSRn03PTMs/4PkG+eC+lAii/Dabv72USgXFcdCjknYAxx0OTKFGnL0on3Sc51Gi417qnzTmX07GN0DW5k1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzCjBgv1HEBLwxGfDRD7FgSE7ZNICNL1EXofLzBQU6k=;
 b=wnvyh1IsKYn83ib0QX1pO4NA0rDYtr7lH5lJ83w82x/9Z+lKsHqpILlHNDS6/EGzlVyY3YgVZEvN2URCLrELETsgLy5SLipczxcWPOJaSomTVacQRUofJgns+EWn2AViAjD7Azd7m53w/ENR9OuQXdC+4EWZQEUliXJ63b9vHpOq2Ilw4FEjNa498fC2O3ueZ9tsT9mxJ1BCdWwJz6+Sdopfeqaeu1QuhAzYE066+pYoYU6jkOvwvLzAo2CKaQAsVWD/370a6t/xBB4hRtgEenHkEmfFT4Dhr9ctepgKMv1iT5Emf/8srFsI9jitnuOsGePsgGEV4oZNxGCV24kbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:20 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:20 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
Date: Wed,  2 Apr 2025 16:26:50 +0800
Message-Id: <20250402082656.4177277-1-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-Office365-Filtering-Correlation-Id: a4c1631b-e1d3-41c1-1dfc-08dd71c05327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUE3UTdsMFdzdTVhUkdGMnppM0xkbU41cWMwSkVzZ1pIQVlxWmtScEJndlVo?=
 =?utf-8?B?VVc0Mzc5UFhyZDJWeFpBbmhObUdVV3Z1dEFJb01GVzFtcGY4N3dCLzA4MVhl?=
 =?utf-8?B?WGlTUHJVWkZNdG1rM1drRlNGRDVCblZXdENsYXRFZDhjZHkzRWI0YVM0T0FV?=
 =?utf-8?B?WU9YM3NDQzhleFNVMGNOUkhPUnF2OWF1Qkdka1ZOSG5HVEsrTGxmQXlENlAv?=
 =?utf-8?B?QVdvYW9Sa0tnamFXU3htKzdPQWZHcS9qalp0dW9ZYzF3K3AwK2lXRXMvZFNl?=
 =?utf-8?B?OWxJeGJUUTdxWEozejFBcU9wQWM5OS91bGU1SkxzMitqcDFDZE9NSkIyWFJt?=
 =?utf-8?B?VlJVVXRsRWM0Ukx0ZWthelliWGdCRmRmVEZFRDloMEptQ1ZLdGlwQnV2aUx2?=
 =?utf-8?B?amlhTDlRSDY2YWxDeFRoS1JGVGQ1WkRHSWpzbTJxaVZlRWExbnNpUUFBd3Nx?=
 =?utf-8?B?cmZEOUVrM05sa1V0dFFydFF2YmQ1aVpBTFJoRDlvcnR6RFh6Tm00WjVaakZz?=
 =?utf-8?B?VzZHc0xqbm5hY1pteWdwbGVzU25KWSthWm5xb3pJYVI4YzZ6cTdBNFdNQ2Vx?=
 =?utf-8?B?dDlteCtNSlUyWEovWWpZWmVMMjZzWjNjR0k0d0ovQUp4ZEJsOHU3V2x0OWlB?=
 =?utf-8?B?WHh6RUdacGIxVjFGZUl2ZFlvV3VPK1kybHBmQ05zcmdEc2pjdklqR3R3Unli?=
 =?utf-8?B?UVVJb1IraklFcDRPQ2FEZExWRXNtZE0yMTh2YkcwZTNaSlNoMmtRdm1ZSFlQ?=
 =?utf-8?B?c3cxMjNMem9VQTNPbzVkODJyM2NQU3k5ZGVnbDQrVmZDOVhjVkhhRUxidDhI?=
 =?utf-8?B?MFhXSTFaYXVWaWZrbVo2WlYwWVgvZlBycGs3MzFXMHhibGNiWmhvbHVGdGl5?=
 =?utf-8?B?US8rT045ZVlOcDJnb05EYmtNZlR2ZHZyWXFQZzlIMG9pQjFBK2xPVWdhdkdz?=
 =?utf-8?B?MncvMXNwd1R2SUZ1dVRUenp2Z0ZtY1JlTXcwR29KSVBLQkdldVg1SGc1Q0Vr?=
 =?utf-8?B?OUgxazF1djJFVmhDL2pMOVpGT2kyVkx6SDRublQ4NEh4QUZxd0srUHRRNUJ1?=
 =?utf-8?B?cWxTMWtVcmVSakRwVi90ZlVUVUIyNkl3aFU0MVZMN1c4U0V6cG53cjlRZnZy?=
 =?utf-8?B?WFRyVC8xOHdDbzZ0eG1KMVQvT3g4UzVjMzkwSzB0Ullab3VON0ZYam1MMVB4?=
 =?utf-8?B?eDh6bFhrN3VLbkRmYm5RNkdXR0lQY09CRDVNNVA2Q0phdUxEV1doMGZUaTZL?=
 =?utf-8?B?dEhhZkQ3UXRyQTFGdmh1dmVDaExJb1d2dm9BNHFxQ0hJVkl0dnFTZU9GeENw?=
 =?utf-8?B?a3QrN041RHZ6VDFvaGJlK1lqUFlDd2JaR2hyTjRDY0RlV3FiMFJMZXF6WVJ2?=
 =?utf-8?B?bkxwUjlMajgzcmh3QWowcXdpa2ZUeTA0ZCs1SXFHUFRReWlxWjhaWElFMEgv?=
 =?utf-8?B?Q2dXcnROQXBrdlZnSVhDK3hEUWpFdzdJZ3RjUVlJMjR0VXdZNjlxbnBtMGtV?=
 =?utf-8?B?WHRlRzlFdDJpL3lEc0RJb3V2Z2hBcFlnK3J3L0w3VlJERHNjSWthMjRTSVM4?=
 =?utf-8?B?T01tRVRBcmRnSTl4b1VsL25yTGJmbWVIR1NxTG80eFBJQm9iY291eDZlanRB?=
 =?utf-8?B?SlZBTlJxVXFBWnJKb3UzVTk5ZndXdDNJdm1wcDc0SnRFVUllaGM3bWwxY3ZP?=
 =?utf-8?B?bXBtcGl1ajFVL0dRSWthYjdjWnNxZGd3MEV4ZmdZdnNkQVlMMENkbVNZZnhs?=
 =?utf-8?B?L1FwbTFpa0JaTWkyNkNvNStnNkZSYW5JSGY4d0MwcTVtN0NzYW0zd1J4QVZ6?=
 =?utf-8?B?Q1l0V2kvZ0tWTEVZZ2c3YUhacG5XU0tSTmo1QzdQOFUvVDFjWHZpVjdSUFgw?=
 =?utf-8?B?eDJQUzltT2UzS3NnZnplU2RFcUliMVdhVTBWV3lZc1VwVHZRREtMZVZFZ2ZS?=
 =?utf-8?Q?EUcTtlIJbFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2lmSmUrdmZGZDA5d3ZKZkFZK2tSblNidkdtWmhkcnhPbFkvTUtKdEtyWEd0?=
 =?utf-8?B?Vkl0NnBOanc5cjduQXJyOHJrbndBekpMbkNOS0xWbnY1VHE5d3JaWkVFNmly?=
 =?utf-8?B?MFBwdFRpNklRUjNHVm1Ub2lSaFR4Z0RRS0JSZGRUekZPYnNhZ29KaW1WNy94?=
 =?utf-8?B?WnJXRzlOaUtjSU9NRlp5TmJIR3dZNWMwdW5ESEtQMTA2WnVUMlRIaVI2RU5B?=
 =?utf-8?B?T3YxRmMyQ1QxenpmVWFORzZLOHJkL0ZydUtNejNIVXZHUnJvTkZTYmNGbjVF?=
 =?utf-8?B?R1gwOWlLajBJY0xTblQzelFxLzEwdFVLSE8wT2ZIQ29nNHFnbDYxbUdTRTQ2?=
 =?utf-8?B?QmcwaVhtZG1aUC9iTUlHYXhlaG4vREpEMDJNVU5DUG8yZEVzalVmMjlZUkRX?=
 =?utf-8?B?TDl3MFErK0xZU0tYK0hJSUtxamNROTBONDVhZTRhbmdpR2NQYy9qcDhZbEpT?=
 =?utf-8?B?eFZhZTk1ekRITllNKzRpWnJtd2J1VHhUVVdHbS90Qkg1M2hNWHJRUmpWeXlp?=
 =?utf-8?B?S1Q2dlVrUnB3Sm1VakExUEMvdlZyUDB1bFl0YzAxYnNGUkxhc2Z4NFVubCti?=
 =?utf-8?B?OVp5TEtsYy9qWTdKVFc4a1NTd3dFeEQzb3dKS2pWS1hiU2p5NlI0ejdmMjZq?=
 =?utf-8?B?dnlubTJ0aHFib0VESVFXZVRyaC95ZG8rMDc1T0g3M2dnT012MEJraE5UL2h6?=
 =?utf-8?B?MEpwM2lBRm5GTDloV1hUQTc3WDhwT1VEbWVTNFVLdGtNVWVZcm9qRCt5QUQy?=
 =?utf-8?B?OFNxemlVd1BlWVJoWEFIbU43WitZZkFuQ3ROOFpkeEE3dGpMSUF1a1R6c1J5?=
 =?utf-8?B?MGFDVnZWUlFQQnJ1b1pTWHp3WnZjUFVCdXFaeTFLUlh5Q2dRaDdydTI5UUlG?=
 =?utf-8?B?cURzdzMxR3o5eHZkbUdzLy9hODg5ZVJnRUJTQkZ1ZjdmRllxZFN3WXozVzRZ?=
 =?utf-8?B?OVphNzlnbzlJVktlNmZ5ekhMR1JNOUpxWjdXVFQvd29NV3BSbXVpR3FnMHRp?=
 =?utf-8?B?aVE3T1hnTkNEbTVjNVFNTmtyM2V1RmtjMDNXdUZXNHRKZVNOQWFEUHVpSEJ3?=
 =?utf-8?B?enY3SGVDWEFmZlcxc2E4UVMyZjVMR0I5aHBXWU9ORkpkZllUdlNhR0E2NWNx?=
 =?utf-8?B?a0d4NEZvWFVrZWxZWWpJQVVJS29QWkh0RFREZ1ZHUno3ZnlMQW81dXpTVURW?=
 =?utf-8?B?UDVvY1lSZnZ4bDkwTHR5eWhpdkJ2Wit1OUVCTU5Rb3ZVTUgyT1I0amErN01w?=
 =?utf-8?B?TXRSM1VtMU9INW5mZk5QVFBoVFNObFByZHBlZnJPbkhJQ3lSNC9kL2gzQTl4?=
 =?utf-8?B?M1BUczlpSVVVV3czajZMMEJwTS9FU3QvRjlWZkpHWCtWY3Jjb3pCb3RobEh6?=
 =?utf-8?B?YUlLWEJZZllZWm1CS1lWTXhZWGM5MVp0TWgwMWJWc01PNWRVS1NWYzB1cHRh?=
 =?utf-8?B?MThnaTVoOVdRbnZVdVcwQ2J1QzZwQ2QzTU1sRmN0RXJ5cFZZaXF1MExraHZ6?=
 =?utf-8?B?RXRXQS9tV29aQkQwZ1FwaEdGU1RsK1BGUnNXeEdYVG11L01kZ1Q1TVU3ZDVo?=
 =?utf-8?B?b3ZVQ1VxYUN6MVZUSnN5QjBoOVgzZ1JRbDNaclBYd3VXYjdHRExzYjl5ZHVl?=
 =?utf-8?B?Rk51Zkw2bHFIZmhPcCtCZ3lzVzhLTmVyazBzbHlQUDI1RHZNZ2toWU9ERWxF?=
 =?utf-8?B?UjQxL2RxSXdFY3VkcG9wM2NGc3oyTWNEYklpRHpvT29EdURRTkYxUnlwb3FV?=
 =?utf-8?B?dncySysrMmw0bDBXVEJ4NDJxbjlmTTZuRTNmQjUvUjRQSnJtTXBhc3FGYXhR?=
 =?utf-8?B?V3NzenZpK255ek1NekNrWGhsTlVSZnJIRml0a2tJNjQ1b0ZwQ2E3ZjNoQnpR?=
 =?utf-8?B?VUlFOFZGaUFJQXI5TWFsQjdTTE8zNXFTTmpHb0pZT0tYU2d3YUtvSzc4M05B?=
 =?utf-8?B?ZGE5VURyczJXRGlFeXlGckYwazhyOWU3d1ZyRTZwN3VBa2h4MmZCbUJTVm84?=
 =?utf-8?B?OC83NDRQeVhPSHh5SzZtN2tpSTVPZjNBVzRibjM2MERtSi80WnVqK3hKcGxV?=
 =?utf-8?B?VFd5M3p0RlBzaTZuS3VaMHFOeS8yNUp1elNTMDNBMVJPVUdRY3hEMVVLUFk1?=
 =?utf-8?B?RFN4azRJbGlxSyswcmllamVDK3QvUml3YnUrUWtNVllNNUgrVmpBL2tsMmdM?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c1631b-e1d3-41c1-1dfc-08dd71c05327
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:20.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylremx4zE21HHaN640w6R3HY7Sf6Hkl96g2khHLlmDLhIkn+FscG54gc2FcAAQ2+VPmUTMSdi6aP8IsJ5Qqv1h2s7rn2cml0zjzdoRnNEeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Authority-Analysis: v=2.4 cv=eZo9f6EH c=1 sm=1 tr=0 ts=67ecf527 cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=i_J6EQ-GqsVZ9Kod7xEA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ky6Qc3aovGUlzx-u-IH8TG-8Fg-D5kfk
X-Proofpoint-ORIG-GUID: ky6Qc3aovGUlzx-u-IH8TG-8Fg-D5kfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=791 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

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
the relevant commits for the linux-6.6.y branch and attached them.
With these patches, tpdir2 works as:

root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
TAP version 13
1..5
ok 0 skipped, TPIDR2 not supported
ok 1 skipped, TPIDR2 not supported
ok 2 skipped, TPIDR2 not supported
ok 3 skipped, TPIDR2 not supported
ok 4 skipped, TPIDR2 not supported


This issue is resolved by the first patch. However, to ensure
functional completeness, all related patches were backported
according to the following link.

https://lore.kernel.org/all/20230929031716.it.155-kees@kernel.org/#t

Eric W. Biederman (1):
  binfmt_elf: Support segments with 0 filesz and misaligned starts

Kees Cook (5):
  binfmt_elf: elf_bss no longer used by load_elf_binary()
  binfmt_elf: Use elf_load() for interpreter
  binfmt_elf: Use elf_load() for library
  binfmt_elf: Only report padzero() errors when PROT_WRITE
  mm: Remove unused vm_brk()

 fs/binfmt_elf.c    | 215 ++++++++++++++++-----------------------------
 include/linux/mm.h |   3 +-
 mm/mmap.c          |   6 --
 mm/nommu.c         |   5 --
 4 files changed, 76 insertions(+), 153 deletions(-)

-- 
2.43.0


