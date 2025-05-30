Return-Path: <stable+bounces-148157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E6AC8CFA
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD631889C55
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988621CA1F;
	Fri, 30 May 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bs7isQEj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fYR6dppz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AE20B806;
	Fri, 30 May 2025 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604804; cv=fail; b=MunukNIg3wk51qEHKLDe9SMY3G3eMe4A3X/BSNFKEp1fbovPatWounwgwKgrsOggID4PpEe/2XMImyaorTkkVosn1M6IgMM4J8xHGuvgn51EVlcZX6k8bzZ0gCW1VBWHa55pHrOhi68HPrZB4DpZddHxa85Y8opdBoOlKC1E+oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604804; c=relaxed/simple;
	bh=j53Unq7Ae9bOikaJgQeGBQKH7qio6JJL9THHF2jpKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mfet0247osDN6qjhhTuO3Hp0gHtH2qe9pLaEXYtRbbWc4xGVzAoNHAYjKMKbhf1WfVwBzX6y44/AzqF2xPPzAFyh6ndCqjbtHAfqGg2kZDzsjRK9jFs1UhOY5Y6sMpblTlIJkh33xRPgycjTACbz3u+MS964cunfG3xx2zbZjbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bs7isQEj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fYR6dppz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAt0RK015490;
	Fri, 30 May 2025 11:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PZNygDUYU7PWNNTze09ROe2FcuVAShVy1Z5ygaW+A1o=; b=
	bs7isQEjCunxo3aRpd48xpFp7UxYpv6ffVLsuqPevH1zHEOCq8wwoxOJhynY1HtL
	J75GGmG84o/2/mY2jfniOjXTDLWS5m3jxFrQP6xH2X8cQ0v+OVKvjhhC9NIc/ezi
	cwpevoJtMa5lHVnHaCcTV90rIwnP4K8zFATl6k7hZ3iC7yXSuMxngXsZuUCYjBDa
	FmOWuauQjNIRp/RLHJsu4VUOkFpMopbOQq1Vw38FBL+u3FfIkmIglFFJLpzh+U3c
	gQMnlpY4qjE9D+O6nXbqVn5Jjo5ADYf9ERFf50a3vwyGJjUzlRsbP1oerLpf+mP2
	Fo217piWcUcyrOgCABMitg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u23v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 11:32:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAauaY019523;
	Fri, 30 May 2025 11:32:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd61v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 11:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdM4cjgatgixXEHLDy74TzxwupWW0VQcfufeViV0orrZFNo2KBInJDdxagTHUPr2Hj+wSN7KdTGhZorvR8DSTWqVkDkcwQI8QsblDMUdvw2V5EloE4UMM1VT9Zug0+UC+7UAz6yMwPb2XXwm6PnFMhzlcl71ZyuCDoiGfA06vLpGoJSon5f48+f3lwhv//FXJDt3sh1On50O8rp6a1u7ZJbphx22em/GN/GQRpA3y0l7+eIuaTYvUVcqJUnNTIkwGnMhJYB5rCev7dR2sAELdAQlxgna7GWfg5/91YAfOTi2qNoKSd8059zmOOaV1Bgs+Zo51IVOp4bhRAIF1IQAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZNygDUYU7PWNNTze09ROe2FcuVAShVy1Z5ygaW+A1o=;
 b=q/EEWfn7hIO6O4X5e9Kn17IYwgGcsAKLgMyna2D2r5BMV5miNI9chfsIKaEx2Q9nai6zhZIsTIgJ649B55lz5HWB15hU1Y6t4CLZfM+BTBRD8KAxQ15261s8Z94kjRh9RiejTm/ItRA6NRqBEdo7HI5TuHwLry49NDDqBzItC+yUiDmw4Fh+VSHBjQXRlR0GYohRYfMIqW0xrz12yHxlW2idyyWDpm0483eVRz/PisPVEIlobCe7KWLquDUtS80velBAS98i++pjBoKO2MWrsPgBXhDFI5zd4wkkRrzYCFhMguzFA6+ELUdWpxiw34XSPBgX4HF9Qcn8fehdnsonpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZNygDUYU7PWNNTze09ROe2FcuVAShVy1Z5ygaW+A1o=;
 b=fYR6dppzpAK90vB9FNVFhDVoL3N9lcFlsIQezBBoyrloALuZXBtlWtWHHNkkcvrxboCtKNQfdxe3Hv7tDJUNUzWQItk1KrnLosj2SAFHkX7H/f6w8UojutH9s3kWCGpcNcJ1u2mEqYG3mQB06RQbJ/c3EbPSzXuspimQOv5jG3A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7009.namprd10.prod.outlook.com (2603:10b6:510:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 30 May
 2025 11:32:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 11:32:53 +0000
Date: Fri, 30 May 2025 12:32:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan
 during vma merge
Message-ID: <9117d6d8-df01-4949-a695-29cafe7fe65f@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529155650.4017699-5-pulehui@huaweicloud.com>
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: ec43b60c-8139-463a-c2c1-08dd9f6db6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WERKcHcyL0llVWF3Wk5kaGtEeHlPY0RyNXByanBwblJMaXIrSEo5TmlrOTlo?=
 =?utf-8?B?QTRFRFp2MVEveFJQbkZLaWxoRDZtVWhpbHU2enVtc3RJK2NDaFdKN1ZjdzVh?=
 =?utf-8?B?YzExSzF4ZCtqc2RCQ1JLSHRZRFEyNndPRjJKK0JJcHZRZkxYbGIzWFF3bTVU?=
 =?utf-8?B?dzJIYjVuV0I5K2ZSVVBFYXdMbXFpM3hOVkdFa3pPeXBlUTJBeEZEbzFqS0ow?=
 =?utf-8?B?a3NwelQ2Zkx3dnlVaXRUODR6c1d4dGxpOU9FY2kyYWYwanJJQWd2MFJJT3Ft?=
 =?utf-8?B?OUdGNEVGeFN4UTZTeDZNYi9ubG9hNEVCMllZejFvdG16Mk9QSkJnZlVuYmN4?=
 =?utf-8?B?VzN6cU1zY2g3UVVzZmhlM1h6dUJ4c21mRmxKOHNiTGNTNldIdXF3STNMOXJn?=
 =?utf-8?B?NE11c2NwSFlpRHFZM2ZzVjk2SXNlNW83STNhclVQYU1YWGxWUmRwTUVBYzA0?=
 =?utf-8?B?Mmk3L1dRaFN2bXV2L25nMzgvUW43aFkxOCsxSlJOZlVscXpKS3hybmFySlh3?=
 =?utf-8?B?Y0V0ZnZIbmVZUE9qZC9pU1piZ2NYSnNDNzRyaGV0bzd1c3p1blp3am5pY2N6?=
 =?utf-8?B?MkxSWWFCK25oWFh3M2U0aFBOTGlkTHZ4dEVBZTFKWTFsOExsckFKL2t3eVJM?=
 =?utf-8?B?U3dVa2hNZnJIRnErUUVtQUEvRk4vZkF6TzVYNnJBc28zdHBRd1ltSE02L3F5?=
 =?utf-8?B?MDdreWQrTkZmWms5cWczWHYvYU5aZGM1ckFIMzRLSUdUazRsQzdtNDI3d0lR?=
 =?utf-8?B?RnhJN1F2Snh5UVFoRUxDUmpZTmxieDV2TmVkNVJLZWtyLzBvQTlnZ3c1eitW?=
 =?utf-8?B?SWhaOTd2SE10ZVI3d2FmemlKb0oyZWM1YlpwZTlNRzdSVE5pbVNsd1JGVmNv?=
 =?utf-8?B?SW1hVjFPMFJ2N2tEVzZlcVRkSlovQmxkcU5kNnF5bXNndTY2MkRGZUVjNk1h?=
 =?utf-8?B?eVRLUFNlVi81c0hSRGpqekFpZVY3TUw0amViTXBTc1o3eVhJSWQ2emQ4Z0kr?=
 =?utf-8?B?Qk1ZQzRUYmRacVp3d2JGRTBVQUs3RzRIdEsvK0FUTDY4QVpwdWJEOVV2bWZ0?=
 =?utf-8?B?b2RrNmhYUEhrQyttaFlvckNySk5NMFdCeWg1MkowNzlWelFKU2g5M2tzUlJ2?=
 =?utf-8?B?NktpWjN6cEI5bUJkVnNlMVFCUWtPSHBpbWtQT0tQeXM1NWFrbXN0WEFkWHdq?=
 =?utf-8?B?cU82S2E2aDYrZFZodDh6Sm9oYWdFays3NUhkQWNmUU5DeUViNmNmSDBYdDVm?=
 =?utf-8?B?V3QraWJIMnJ4THpYTkJadVc1YzdKMzNuL3ZVTnY3R3pwdExwM2d0QkxxWFFV?=
 =?utf-8?B?MnBVZ2VpWWNHeEpGVWc3Q1dLV1JFRmpwUGtUN0ViQkZaNHowY1V0V2ZjL2FS?=
 =?utf-8?B?WkVCR2lyTUY3a2UxczcreGZwRmovcHdqN01yWHphYmxqamJ5SEN1TFlRVmFL?=
 =?utf-8?B?Z09RcUxCT2N4NGZ0SXAxYmJWT2tOeVBaQXhMUEZDb21ITDdvM1VmWWMweGdD?=
 =?utf-8?B?OHd1eFBQcXppUFZYMGwrVjVjYTgyVEtiZTM3cGtSdmhsTnF1MWUycURsVEdO?=
 =?utf-8?B?MDZCMkJ5UXlkRElOOVBPRE1FdWpsZDdpVjhxenI3UVlxdkk0ald2UWtRNmZS?=
 =?utf-8?B?TVNMdElvZDhkUVNITnk3cHk1RkdpRmVYUm15emtjVlhGajFndFU3L3ZLZVZ3?=
 =?utf-8?B?cU1kTVlrUHRsckpQSmhWQlc2NDlVUnlSQ3NtYk02RGJPemNabEVpdFdmSGpQ?=
 =?utf-8?B?S1Boak1xamRqRWtwN0s0TW1WWEs2T1RhYW1Tdk5FcW5SYzRqNXNmQVg4WWtK?=
 =?utf-8?B?Ym4zMXRmZ3FqcmhiVGJGZUdOUUdqeDRRMkh3clpJMktiMzB5eVRmRGg3S3Y3?=
 =?utf-8?B?U1lkeVJvWjFtUEh2RUllbDhoV2RhYWlhT1ZmMyt1dHIwVk5tZ3luZ1AzYmEz?=
 =?utf-8?Q?V8Tm9L2uCYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdxemhkSCs4STREWFVOYU9iY2cxQ1ovUUttbU5qaUhGbUlMOERUWFQwcEZr?=
 =?utf-8?B?TFVoVnhhYTN1eHo0SDg1VVFwbDk4bkxVbngwc0xnUWV0VW9FNm9BRDE3UENx?=
 =?utf-8?B?aDVMV3ZtUkVRMjdaM0hSTFFQN3BidGlHcnVFOFBWM25BWXAxTFlMdDZBL00y?=
 =?utf-8?B?L0t2TUR2V1pQR1M0SjR1UWlVY1ZmbTVrdUFXRkhuWkVpZENkVHowTHZ6S2Y2?=
 =?utf-8?B?NEw1UTZsRktYb2haRkZqT25uRXBJZHJtVW1oTjd3ZFJ6WitwU3NXQjBlcWFj?=
 =?utf-8?B?YVF3MTdpdGM3R2syUTBVM2k0WkczSmhzZnhkV2NRdS95Q2h1UDgwa0k4YVNp?=
 =?utf-8?B?SFVsclBYY3B4TU1uSkl1R2p2VmE0V0VWOTB0VGhOMDZKVkZZQlpEVTFuaVV1?=
 =?utf-8?B?SDJ0SWUyZEFtTW1DWFg3eE1aZFltamxCNWRWTEdDaUQ4bFZOUXdUTkg5aTN0?=
 =?utf-8?B?QnVpRkI5d3d5eWMxY0h5VXhXME1tS0htaTZjWk5idXRCMTc1a2p0VTBSUjZi?=
 =?utf-8?B?a0Y2RDZ0ZjlQOFhqT2F2YnVDSTd3bFdNUEtQVVRrZWkzNkw5Q3Q4cnlpUVMy?=
 =?utf-8?B?ODZ4R0J3REVFTW5JaW1sOTRoNUcvL1BqVC83c01ERDltWnhWRGcySE1Fc243?=
 =?utf-8?B?Wnc5WjdoTEJHRW1jY1Z5S0Z5WVRoS2RXRE1OendWOEZZbkZFbHhUc0FEbzR2?=
 =?utf-8?B?bUJYQ3BrTnA3SGhLUG5WdjlXYThGY2lDMVdXckgwMkFjQXRNZERrRlZodWs4?=
 =?utf-8?B?UHRpSlNUTTVGUTJSQnJuTHNKZlNqWkV3aVFGc1VPSmUzenVsN2VFS29lVXpn?=
 =?utf-8?B?akx3aWNKenltM1Y5UlY3L3A3R1BJTEFLMWFCUzlIMm1BQm1ndUZvYkVhWWd3?=
 =?utf-8?B?a2FsQ21WU0l6cjdyZUEvcklLQ0ovWTZxdDdpdVV1NjE0UEtsZ2grdktGRzRh?=
 =?utf-8?B?K2k0amloQ2xVN01iNUdtQW92dThaNGN4WVVMcndWZ2V5QURXZVQrMlFuektD?=
 =?utf-8?B?NCswWk1ieWppcGZWZm82cmNJSHZkVFVlVVV5bkJKNVQxc09CV2htMEFqa1ZL?=
 =?utf-8?B?YlF5RTliT0FNL3Y1NmdrRGVRajMvM1R4UFJ2S3FlQWFablFXUStrOXVvNklk?=
 =?utf-8?B?b1JyZmkySnNhSHhMYk5FNTdUOE1ocFI2cTNNU25aUlZYY3lIY1UzWFB3VWVM?=
 =?utf-8?B?V3ROeFRMc2JGdlU2OGNXZFFxdWVNL2g5eCtpSGd0NlZUWXRucjVjR0tTbzlB?=
 =?utf-8?B?bFk0SnhLcytaL21ldGJEVUs4TG1iWmNNZnVscHcxTSt4eCtmandDdEpCTHF6?=
 =?utf-8?B?VWVwUXE2cGxJU2hFdVo3U2RuM3JXREljc0FBbnJybUdqb3lGWFhPUWRtOHRu?=
 =?utf-8?B?TWhCQ2Y1M1V6Mjc3RDV3aGVyUTFxSXgrZEVGQ3BWVE85ODZDNllKWUxvQk54?=
 =?utf-8?B?dk01eVIxRWduaFRacm1maWJFV09RRzRiTkU4R3FXY2R6aGhhV0tNMjhKM25X?=
 =?utf-8?B?cTk2STdKSytDSU52cGlqeHVPa3ZyU1NWTXdWaEc5WGxwSStKNG1UcXhkdlNG?=
 =?utf-8?B?bWJ3QVNsSkc5d2dISFlhRGlHQ0loRks1ZzVvUWdvUjV4VlBJOXlKazFZRWlC?=
 =?utf-8?B?djBqeHhZdVAzRVhvenpBVDluMW54N1RiNTFVVGQ5dEhybzQ1aGowVW1LMGRP?=
 =?utf-8?B?UzFsZi9uM2pyTFJ5UUg0clpsaHBMc0FGNkpsZGxsK3RnVG9JWlZyRjhrOHps?=
 =?utf-8?B?SDN6c0VZdkJBR1B3eWVkcEtkaXdqQUNrVEdkcGU1TmRObHowWDl5QW5zaHQy?=
 =?utf-8?B?c2N6Q1lxM25jNEdaSGkwWllFaHBKWi9wdlVzUFM4VTJ6ZVI5SllpcTRaeHNp?=
 =?utf-8?B?TkgxV3JKOVM0b2M0VUxTc29nek5jOURZOEJCUDhXZmxDVEh0dGVwaHlsUnN6?=
 =?utf-8?B?L1RFQmVkaXJMNzFoN24vNjd3SWJZR0d4aFFpQ2Q2bGxtWm85TnF0RWFjQUF5?=
 =?utf-8?B?YThRU0l3cU15ZUJyTVBac3YxZnErUTI3Zk5rUytDeUsycjVhMHpDa3E2SUM1?=
 =?utf-8?B?VThnTHgxUzVBSTl3ZTIyK3pTcjZxRVBMVnBLVDBDM01LeVlWZ3J1dXJsZ3Ax?=
 =?utf-8?B?S0NacWROOThYYVI0dzFjaFpEYkIrUTFHS0pkU0xCYXVMTG1qYkZIdE5KYkw5?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SxYKAC4xclgt59MR7Ox88sNwYzUcW5LtxrwBIISf2W7pviED/y8YYvS2p54Grub57a36nISf8j3L7nH0IkEnM8HbbcU/TmDfPvQ4ob8bsdVbQUUNL7LMUS+gyh6s8JSk5iQ7bPQNuxr39V6ku0LoxqW7p8yr2h1A2jz8mPrLNXncDpoGCc0jq5pjcsd8guYvXfzpna1NDAeyO2zzXehACJbeNiGlQzO6VXbf0NJ9bEQkCCPCb0s8wxnQbeF1f9leWNHxfGnPdoVqYUNyb+ikwZ5QnCaNRnwZn2gO9bzD5R2hKRC31GTpDBLb7veAWNgFmc8IV2QY7A1fROrfMtuBEfUDWMvtLG6JDBLrUXW5skc9rNIoT+rO02M+Hwa0vpdbWxCvKXdoCe366wiPGlv931OXRUnTr70dLfEWKVAJqnmOoLVgVsD8PxDgjzaK7Edpffv14dyhqEshXRjAW2Mpb5ROIF3qnYuGCUSWP81fU2TMiz+tyqAeJDfcjr4t/fnOcsQWIcZ7qFetOn2x8knWqlf2aZ0LL+KMfZNg4oUjjEMP6FROawwKGY90/+MUtP780DWAnZUFxEtWQuH9+I3dhpZDoG77FOVIZyFVAFabiNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec43b60c-8139-463a-c2c1-08dd9f6db6f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:32:53.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns9yilqL/NxzNJf/gF8+fOxo5WJA4ovrBLb+6eDEMEIyL/aMVETq3K6OdHrS04UeHJJl/M7Edaun0+VLAa8tJjjQ7n9Hr940vAmOIuf/aFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300099
X-Proofpoint-GUID: tyznVNF6NypDm07_YRSeG3-mSh0gtnxZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDA5OSBTYWx0ZWRfX8NGjqpOOW9yi 0JCs/AONZ7BNtaUQBGQtjroNvpjuloh95em9tP6zzK82CbZ1QYhavJkBYCscjfslFRwjp9SPK8H U1vVtt7H1bjeITvwz8Hc3rAkX2TXS9hpTGib0gxCAxT93A9lDa0LdiIp3MEnnbZL1mY/b3p7nBb
 I6+ao4Wfy/iXsJDrYTp62o+cASbsqRhYjk77iNhQQFNUJZoFnC1WduCn1yYCHZeGSXecw2b9glB FzjpFCkCcAJtB82zz/xq2fEBz+fb9IZI4ZFeX/YatKsVJWXHqZib4VkdFWU/cJNkB78ecU4QbDw kLGMHDxjd7wfgozjZebSOTuEnW9ROTe135zSA5jXP79fJN0ieYqV0KXOt9M8Qs3QjfquLQIIPnH
 3OfsvIhI7tcR2rBb9/LJOGdL1NOnf0Yr4RKIQ58P15h0YZqwPoTIjImVl/sKzjA1lNBN3IK5
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68399768 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=yNUr52bx8PGVZqFHBtcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: tyznVNF6NypDm07_YRSeG3-mSh0gtnxZ

On Thu, May 29, 2025 at 03:56:50PM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Add test about uprobe pte be orphan during vma merge.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/testing/selftests/mm/merge.c | 42 ++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> index c76646cdf6e6..8e1f38d23384 100644
> --- a/tools/testing/selftests/mm/merge.c
> +++ b/tools/testing/selftests/mm/merge.c
> @@ -2,11 +2,13 @@
>
>  #define _GNU_SOURCE
>  #include "../kselftest_harness.h"
> +#include <fcntl.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
> +#include <linux/perf_event.h>
>  #include "vm_util.h"

Need to include sys/syscall.h...

>
>  FIXTURE(merge)
> @@ -452,4 +454,44 @@ TEST_F(merge, forked_source_vma)
>  	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
>  }
>
> +TEST_F(merge, handle_uprobe_upon_merged_vma)
> +{
> +	const size_t attr_sz = sizeof(struct perf_event_attr);
> +	unsigned int page_size = self->page_size;
> +	const char *probe_file = "./foo";
> +	char *carveout = self->carveout;
> +	struct perf_event_attr attr;
> +	unsigned long type;
> +	void *ptr1, *ptr2;
> +	int fd;
> +
> +	fd = open(probe_file, O_RDWR|O_CREAT, 0600);
> +	ASSERT_GE(fd, 0);
> +
> +	ASSERT_EQ(ftruncate(fd, page_size), 0);
> +	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
> +
> +	memset(&attr, 0, attr_sz);
> +	attr.size = attr_sz;
> +	attr.type = type;
> +	attr.config1 = (__u64)(long)probe_file;
> +	attr.config2 = 0x0;
> +
> +	ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);

...Because this results in:

In file included from merge.c:4:
merge.c: In function ‘merge_handle_uprobe_upon_merged_vma’:
merge.c:480:27: error: ‘__NR_perf_event_open’ undeclared (first use in this function)
  480 |         ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);

Otherwise :>)

> +
> +	ptr1 = mmap(&carveout[page_size], 10 * page_size, PROT_EXEC,
> +		    MAP_PRIVATE | MAP_FIXED, fd, 0);
> +	ASSERT_NE(ptr1, MAP_FAILED);
> +
> +	ptr2 = mremap(ptr1, page_size, 2 * page_size,
> +		      MREMAP_MAYMOVE | MREMAP_FIXED, ptr1 + 5 * page_size);
> +	ASSERT_NE(ptr2, MAP_FAILED);
> +
> +	ASSERT_NE(mremap(ptr2, page_size, page_size,
> +			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
> +
> +	close(fd);
> +	remove(probe_file);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.34.1
>

