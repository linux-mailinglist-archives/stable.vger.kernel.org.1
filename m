Return-Path: <stable+bounces-114468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D9A2E31F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 05:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A057A256A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE12335D3;
	Mon, 10 Feb 2025 04:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j+R89bKf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="puoG1BcP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D42EAF9;
	Mon, 10 Feb 2025 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162005; cv=fail; b=r1RYVQ20Usnr+WrNN0+X0/LA+7py/X+SCYtUsD2oyz72OQfUl/9N6UgMu4t/0K/VjV2Q5OQEb/3Sxhkv+uYNCGBGoeIV4Olcejt7G4N1f3z6pxgNlsY97yFzXdXfrKg7RphnHvw+7J5067XyoaLIfQDznNeW5g19tqCr1ucLCp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162005; c=relaxed/simple;
	bh=9I1Bcm1iHqzJCx7IRXsH11j5xjQc4GH5xVvg6zNcSMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AcB3sCAnUt1a1+xlXk15BYB/xkrYFrKG3Xou7ZHhC94YgrSpGLl9PPqHrIH1nfkvjdfdVUNj9Fd3lDU6Ph4iyrAc4qT1IkeqS8KB0HPmaukDX9Z8GlVu0DN1Nz3yrMEzA2W3kchSv8R7Z1uUW6qtUEMDh3j7KY/bAvSdTtHZIU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j+R89bKf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=puoG1BcP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NYasG024041;
	Mon, 10 Feb 2025 04:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G5zDTAoE/de4hgEkgd+wumC0CdY7rfINPK3UN3QxMwQ=; b=
	j+R89bKfyomkSYBWoA+2ZZSlFUKi9oOMWwPHL5/BQV55/txenq5+AD1Z5DUgXOnn
	sLCsPAdAfV5PqLrtu+XzkMmxHeXPT5Fc0/d1t1beL+LcyuKa7k8u2poRcIRxDRfv
	gKEP7U66FH6ObKgjEFoGWCrJ4xfudfKjqoTAJAfoUHn32Jlcgj1HZyVsywe3uAWs
	/8119RouyQbCNGp4mvyWGNPfYBK2q5mYn4qGr/Yys+auEC6XSuvmR3rs8NOoYnPL
	tPItgn25B07EE97fLNGiVg4gUa4JnJhCH1Q6F1OQIaYfaL7z9b12qnEXSPMWal0N
	gveCweuF35DbtfOe2o9mlA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s3t6n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 04:33:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51A2BFwJ012410;
	Mon, 10 Feb 2025 04:33:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq6w2qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 04:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSscajR3G+0V0DMsVpzCeukanEZJK1hBTk4FRlPab05UgJXHai9X2YUDdI+Ir7ojkAA73Y1il3N1ncS2iyc8frfZTp5fs/igmPiGMxvRZLeiuHArHx8pqXofYksx1ymTLdOkxZA2H3c+4p95RJuG7oauw4E5GZgFF2ZHwdont1X/W7FbVrTkQOwy9DLJQEIAgzY+ijNVM9bk5CwdS/h5CojVwkqL/LfrorzcDfw+xeJCxb48Ms+WyM/C21nTp91qtUg3q7Z8TpDoOSfPxzMlpf34U2U5oBNvGGRShHmwo4rl2eNol1TUh0rs8Hyg9ufzGLeLVXxTvcKvjKUfZd9Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5zDTAoE/de4hgEkgd+wumC0CdY7rfINPK3UN3QxMwQ=;
 b=hAjtTG2M4BkZTTLovUAZXqctH8bZVPIonUeBnoU5G0Pobx0B8OKbq9UIyOlxOGpsn7cyApxlXGGleVjdRYRvnWkVAPFmxml9+/LJSq1XCy3D3pceQIZ2nmhumQ61p6cRF0ApQqLZhBCXY5BfOoULnK2joC+UbRlbwQXvoqbCHCH0XwXZCALQXC6NcWVqWvG3KwW7nXKv+2qS3ev7pv8HY7T03RnYUur7vjnBcl+sfp1/QY0SMAmDmo1/YUAq45Q5GYfulRpiJQsdnyfQpV0f7Tyi7WZS/h8rsu/8HRVyF4eFTCqI4WOM9AfZtUSgACfTHuGxevmBV7I5IyX6z0YbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5zDTAoE/de4hgEkgd+wumC0CdY7rfINPK3UN3QxMwQ=;
 b=puoG1BcPv7z3WnMKzaMhg2n2HPFxQrl2qIKRxF/l7IIhEHtEX5+1uQh/MJxlx+Hy6l5zEngYTacWs5521QzGO/lNUvv4fTvw4MzXnacugFN/prU7ASRnWUEEDSJgchTZSB1ACPqnaDcwNaO+jM3N21yhlQEfKgcEdnko1muhotA=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 04:32:59 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8422.009; Mon, 10 Feb 2025
 04:32:59 +0000
Message-ID: <9657c561-a147-4143-9e64-42fdd68f9dcd@oracle.com>
Date: Mon, 10 Feb 2025 10:02:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: queue-5.10: Panic on shutdown at platform_shutdown+0x9
To: Chuck Lever <chuck.lever@oracle.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
 <2025020722-joyfully-viewless-4b03@gregkh>
 <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6797627c-4f42-440f-9457-08dd498bff98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEFuM0hQcksyU3NqWFhGRGtqODFWb2hvYzA3NTBaRFZtSEVEQjJJS0FGNDA5?=
 =?utf-8?B?cTgxK20vZURFNEJLbjBzOXl0MUtzZUpVL1RsTFZNTll6NzA5UCtOcUFqSDh1?=
 =?utf-8?B?MnpYVUR6dEhJSkg4bU00U1dRTElPM2pCQjZiYU0rMURQcWtlNjRsKzdZSWtF?=
 =?utf-8?B?NjBISmxEYVpzdjhwQmo4ak8xdDJVVDNHMEdZSFV6b2RYWHd4RlNJRUFUVHpx?=
 =?utf-8?B?bTY5cnhQMkpUSzB3TEhJMTlVdXRsZFFpbm5kWkRoZ3RGcUExcjR6R0hsTWx3?=
 =?utf-8?B?U1B4Qm14WXFvOHFLV1lLNVNvTjlqb2RtL2FLY1FuY0x0Q3Rqak1mRy9ZK2o0?=
 =?utf-8?B?RC9zd1RZbEdvVlZoRCs1Z0duRlpGS1RicVVXeHZTclVHTnpCcnJCU0hSTTBN?=
 =?utf-8?B?MlpxcmJsRithZWRhTVVjVlpmOVJNcFp0cVBqL3NKa2lEbCtKRWxtdnZ1MG40?=
 =?utf-8?B?TUdLb0FnampUVjdOUHZOb3E1RUJFQVZjeW5iZllQNmZUVGVRZXc1V3NJVHh6?=
 =?utf-8?B?VlVFMlBySXlKQ1UvU1BSYktmRnZ2dlRVYmloZ1BubUExQkdPQnVVTTNhN1hB?=
 =?utf-8?B?N1ROaEdsdVNsZXhvK0E1STlRcFFPTzZuZUhhS1BvSkdOUG5RZUhVc2h0dytY?=
 =?utf-8?B?TDliMkREblBWenAyY3JkTFA1Vmo1QUhxcEhweVAvUUVhc1lqUlJ2RWNqMUNB?=
 =?utf-8?B?VG82WjdGRVNRSXNQektUbUNwR3ViNnB0QkhhMHNKWnlaMzlhYS9iMGxQdmRS?=
 =?utf-8?B?ektNbTdXWDU2QU1XRXJmTmtVOERIOGM2S2dwMlFWaFgwekMyQklTKzJrc3Jt?=
 =?utf-8?B?MlBBUFBTeTNuZkdOSHhEcGlCMk0wS3BzRWFNSFJ0YndSbXV6U2ZGUGZZVmhy?=
 =?utf-8?B?V1g4SFFCTEs4WDI3ejQyK1Zhb2tQUGhsVjgxKytEbzByVkE2QjA3WFFPdUNa?=
 =?utf-8?B?dTQrK2hXTzBsNHd3RkZKcHVkeGsvMFNOaHVHc3NwdS9IaDhjV29TK3RTWVJ3?=
 =?utf-8?B?S2tHcXg4M3JwUXF1K3Rlc1Z1aE9QSUVaMVRJSG14cWcxSEhFT1dESTIwOWFt?=
 =?utf-8?B?K3dvcFhCbkFVZ2U5S2VQQWl4ZjhVK1hUenJjVU1uWlRLUkZrRUxyYm1DalJx?=
 =?utf-8?B?SzltMkYyd2xkUWJNeWNnL0M0ZnV0VlV6UEd0c0NaNFhLUllUbk5Ocnd3UjNP?=
 =?utf-8?B?a3BxaFdrOTE3U0IwOXFTUlZxRHVUaFNPYVpEME96L3V5SE5aWUVISkdUUDFl?=
 =?utf-8?B?SUtvZHhRYlNFUnIxRjVMK0pPZ0Y5QVVUZmFkcldtWHlNSFkyR2hOMCtNN2hw?=
 =?utf-8?B?WlZNem8rOThhMk85WW92T1lmM0FTWkU1SlBLV0c5cXY0MkZEVHJrRTFuNmdX?=
 =?utf-8?B?dWN6MTVzWFVSL0RiOGlpSnBQWjFvNTJmS0FhMXdwZ0huby80emluRFhxK3l2?=
 =?utf-8?B?MjRsNnIwWXdtZHNicStyYm9DME9vRkdPUm1GTjRWb1A4a1FNazFGNk5ZSzZq?=
 =?utf-8?B?WVdBbUdDbUViNTg5enM0ZUNJcVVsVnFjME80emhUbWlnTlhNM0J6dHI2OHVw?=
 =?utf-8?B?RnBQVG9yQUNkVCs2WXROU3F6SmJ2N2lxUTZpUTNHQjZDUXBxekpzcnQrcVVF?=
 =?utf-8?B?WHVPS01NQXJtaFdNaWdQWTZNcGdrelJoeTV1QWlKMGQvb1lHR3ZuRWNlaWh2?=
 =?utf-8?B?WEIyOUh0elBIWmRLcjVsTDhDczNMZ1FHMlhWSkt2RWdKdEV6cG5EcE10OFhl?=
 =?utf-8?B?cFBSL3g3d1JyNFlwS21iY2Q1dDVFOG9sbk8yRWQyMFo4MEZCdXd3KzRlTmJX?=
 =?utf-8?B?T29ZUkpiSDhkSVJJVW8zanh5cXduNEhHT1ExSWY1RXAzckQ0cUYzTE5YQVJz?=
 =?utf-8?B?QngrdUZ6bWtZL0RWVGZoQ0pGRVdNZ2ZKQUxJTkdKUEwwOXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnlOdE5OKy9lWG1wYWdkTUVhUWNFYVlUSlk1YzZ2ZGhmMjJybFhUN3hKcEVi?=
 =?utf-8?B?Q2djNldqSkRvUGQ5UmVOVU5SZXdPdGdiTW0vRjlzaUZmeWl3L0VzSUdib0ZN?=
 =?utf-8?B?ZnhCam9qbGF6UDlIbFZZbnZUQThZa1pMK2c1N0IreXFwNUFZOTJRbVlYNVJV?=
 =?utf-8?B?TnRQTGtEYjZzQmRCR3EvNmlDMGNWWlc1dzd1eG44bk9yTmcwRG9pWTYweTEw?=
 =?utf-8?B?czBQc2tOYXFzb21INy9NNGZueEd4SmRyaDQvS0JwbGJQQklmaWZHMlhNQXZB?=
 =?utf-8?B?V0xybi9NVnRHbzAvcWp5RDNDRktRQXhUSDhsQVdrTFhpTFByaHl2UUFtZ05C?=
 =?utf-8?B?dzhrdzBoeTM1YVRGYzRTei9QaGQyeHFoL2xlYW5iVURMQ253cG1ZckplZlZD?=
 =?utf-8?B?OUdsOHhiZzg5SVRFMGR5bldhTjcrMjN5YjN1MzVwaTVWRFNkN1lMcXJjRHFD?=
 =?utf-8?B?UnVYc3RpU0ZSRXVCZk9Ea2FFNHNDSzE1Z1EwY0IxcXcrUjI4cXYvdnpYbWpj?=
 =?utf-8?B?MVhSTEdTRDk1OXRxYWRHbUZ3RisyajJhNDBqNmJsQ1gxRmx5NXBFcVVzWWE3?=
 =?utf-8?B?TUM3bGFHU0xGREk2VTJ4TlN6a1JZc0gvek1wSHZDRnlwMzk5MzlqVFdoMkw4?=
 =?utf-8?B?OTBoaUtIWWw5eEZQd0l2dmZ6L2FaRkFCMjNqVElpNENDUTdTaGFGK2VHdGlm?=
 =?utf-8?B?OUhCelVUSWFicEN4cG9oVFJFOUNHZVpzUHd2dDFJWTYyeFk3UTFJZXJjdG1q?=
 =?utf-8?B?SWlYM1ZIVndmNnNGZmRSR2hPZUJPL1VYRW1IcWl3VDJXb0RmM0J6R0FlcW5K?=
 =?utf-8?B?a0U3cncweUszekEzM0wzODRHdzJDYlJWRzEwMTUyUWRyeTc2UHp5Q1h4Z0xJ?=
 =?utf-8?B?ckZuSDdiSXlPbEx5UXZqbVRwakMwWWxUQ0o3bW9LYVVETnNyajdaYXVURzhs?=
 =?utf-8?B?RWQxSEdlZjZvRy9ta1NiV0JlbjJHMHI4ZTBoUUNJZEF6M05WSXR1ajFmZkZO?=
 =?utf-8?B?QWFGS0JRNDN6K3ZkKy80VmJjMDVNKzIxWkJkeHAyQTQrOVVDV2xXcW1yRXlX?=
 =?utf-8?B?TFBNZ29PVXcwb1RVemRBN2wyZ1k4ejdRaGJ2dHdCNjBNVzVLR3NpZmdRTFpD?=
 =?utf-8?B?MzVNUDV5UzBVOHNyMllCTDRyUFVOT3k4YXQwbDRuM0Nma3ZBRGd2Vm1hU0lO?=
 =?utf-8?B?YXljNCtVUGxZbWZjRFU0dWtydk1ZdVZaQnI4d2h3UDBmOE02M0F0NzdHeUdr?=
 =?utf-8?B?MzRaWVVnanp1ZmxTS0JzVzl4THVSeXNoK3RqSXFhbkZMSktMQUhiRDVURzYx?=
 =?utf-8?B?T1I5MzNKUldxUHNNWDZaTHUxTjhJbUdIUzRMK3dVdnkyMWZWdDlkZmI1SmFZ?=
 =?utf-8?B?TVlrcG5HOVlOd012TURyV0pUdkVQRzRrYkttKzh1NWNQTmQ3VTYzcG9IQnpG?=
 =?utf-8?B?UTF2MkMvL0RFS2tjbU96NDlKY3pqL1pHOVNDa2dXcUFzdVZGc2ZGdHBjUXVM?=
 =?utf-8?B?SnV6Ym44WDJ0cTM5MkZqRSsxS1dCbUlLQ0R6blFrMGFLTHVnTk5tc1liMG81?=
 =?utf-8?B?NDBVeDVYZjN6a09sUE52bkVZY0c3YTBHcGRpWDMxMWVzQzcraHFXZ21FdFZl?=
 =?utf-8?B?UWtyMjYxVkxpQXYzUnUwd0xHaFNLNlRVZkZqM0ZpdFlyQ2k4NUlwbURBVTFY?=
 =?utf-8?B?VWJEODlieWQvWUJWSzZDOUwwYVJVUkdvaU5TZGRLUTZmUkdkM25uNVVhanlk?=
 =?utf-8?B?VW8vR2lENHc4aFlFdk9OMXZPTWkyS0hQbnkvSnlyYUpEV0I3ekppd29meGM0?=
 =?utf-8?B?R1FTaDlVRVZBRTBqUnA2NS9mTVFLVWhaUi9wRHAxanJGYjN2d1YrK2NYR2x4?=
 =?utf-8?B?MTd4N1QrakdJYUhtYlFqYjh5dkdWT29hbjJxelluWVBpbFd6R3ozY09yTkdK?=
 =?utf-8?B?TDRGU2U2bHJLNndNSC9tUHR4ZEpKK1RVbW9xMGNqTW1lTVc4Mm9NQ05ibWJy?=
 =?utf-8?B?OHVua2d4dG9QOEhRSTFNZ0RpZnhjdkdwR3NQRG51MkpNWHM1MTJlQ0ZzUmJU?=
 =?utf-8?B?RUdhaFUyNERnZ2NGRnJ6QjMwY1c2eFZFOFI5ZmtMTTRsQVBIaU1NamlFSlVm?=
 =?utf-8?B?dVRpT2h6T0lLaGM5OGZBcnBhVi9MSkpFeHdrdkJMeUREZEN4K0w5OGZSTzM3?=
 =?utf-8?Q?ZTwZgkcKHZEVZHsKAkrSTF8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r3a4LVZC859E+M8Vw4zYvebzc2D2+YoY3ySNAQ+QE0BpUH0PNnr27vAdAmEBc7gN/83EPhZipjXYwbOxOWK5F1OWK3Nf3b7LYKTHEP/Z3MY1ONGQwFyLR+B+2DkGu4D1lgCKEnCR1c7HsaPclbLp0oEHCqpXuVCUv3fenSYHAzxwFrxYK1D2y1IloHXaS3yCA0MePe+PSD/+KgNqCOybHI/UWK9URb6RKUTPaxA2eSN5IcjLFiGkzFLPA4zXBc1WvyOoxTVB19IURU+/xPaVD/t3xJMTO+wjCUB8o7ALs3WeiBOVT+U3fO6V4J1RyKp3Mo7NKWkYQixXhRnHKHGmc1uUxYXleHH+xq0fiIx3LntgoMn3/EM11frIcTvjWX7RxHTKU4HXYTPdsHEg1L59rvRfUuQctqGPtyXBw09UBd7zLrLCl9p2nt5ASXd8OpwU4D78vzjXZVzUfxGLTVQiGg3I1o51xFviHXA3EAJtqOzFmdh9a0F+fvh1fggAbkNNb8cxl70jJRQ5yogbLQjCo69+r061dPccyQBsy50VAUFEJUFTvv5SXmM7kbGP9ZrYe8zzkOpcEadwA4Y7l7j73U5zkvw4WjzIgCgJ89xB7+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6797627c-4f42-440f-9457-08dd498bff98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 04:32:59.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ljFgf8yFjVG7CG/91qTF/Ng2UOvGA4peT/K0TvSh+WPRD9ROKvUrU0HgYx3RSKWamqDyFHc/7QfyM3X0SEjR5uJt34f6QpyyS+NJ4IUH0qs0Ii9BWp/9ypjwyuirE3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_02,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100035
X-Proofpoint-GUID: Op2ZuIIKX8xpqbnh6AbtAO1PsZU1B6bM
X-Proofpoint-ORIG-GUID: Op2ZuIIKX8xpqbnh6AbtAO1PsZU1B6bM

Hello,

On 09/02/25 21:27, Chuck Lever wrote:
> On 2/7/25 10:10 AM, Greg KH wrote:
>> On Thu, Feb 06, 2025 at 01:31:42PM -0500, Chuck Lever wrote:
>>> Hi -
>>>
>>> For the past 3-4 days, NFSD CI runs on queue-5.10.y have been failing. I
>>> looked into it today, and the test guest fails to reboot because it
>>> panics during a reboot shutdown:
>>>
>>> [  146.793087] BUG: unable to handle page fault for address:
>>> ffffffffffffffe8
>>> [  146.793918] #PF: supervisor read access in kernel mode
>>> [  146.794544] #PF: error_code(0x0000) - not-present page
>>> [  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
>>> [  146.795865] Oops: 0000 [#1] SMP NOPTI
>>> [  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
>>> 5.10.234-g99349f441fe1 #1
>>> [  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>> 1.16.3-2.fc40 04/01/2014
>>> [  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
>>> [  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
>>> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
>>> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
>>> [  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
>>> [  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
>>> 0000000000000000
>>> [  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
>>> ff4f0637469df410
>>> [  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
>>> ffffffffb2c5c698
>>> [  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
>>> ff4f0637469df410
>>> [  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
>>> 0000000000000000
>>> [  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
>>> knlGS:0000000000000000
>>> [  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
>>> 0000000000771ee0
>>> [  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>> 0000000000000400
>>> [  146.810109] PKRU: 55555554
>>> [  146.810460] Call Trace:
>>> [  146.810791]  ? __die_body.cold+0x1a/0x1f
>>> [  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
>>> [  146.811854]  ? exc_page_fault+0xc5/0x150
>>> [  146.812342]  ? asm_exc_page_fault+0x1e/0x30
>>> [  146.812862]  ? platform_shutdown+0x9/0x20
>>> [  146.813362]  device_shutdown+0x158/0x1c0
>>> [  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
>>> [  146.814370]  ? vfs_writev+0x9b/0x110
>>> [  146.814824]  ? do_writev+0x57/0xf0
>>> [  146.815254]  do_syscall_64+0x30/0x40
>>> [  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>>
>>> Let me know how to further assist.
>>
>> Bisect?
> 
> First bad commit:
> 
> commit a06b4817f3d20721ae729d8b353457ff9fe6ff9c
> Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> AuthorDate: Thu Nov 19 13:46:11 2020 +0100
> Commit:     Sasha Levin <sashal@kernel.org>
> CommitDate: Tue Feb 4 13:04:31 2025 -0500
> 
>      driver core: platform: use bus_type functions
> 
>      [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]
> 
>      This works towards the goal mentioned in 2006 in commit 594c8281f905
>      ("[PATCH] Add bus_type probe, remove, shutdown methods.").
> 
>      The functions are moved to where the other bus_type functions are
>      defined and renamed to match the already established naming scheme.
> 
>      Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>      Link:
> https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Stable-dep-of: bf5821909eb9 ("mtd: hyperbus: hbmc-am654: fix an OF
> node reference leak")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 

While one option is to drop this, maybe we apply this below fix as well 
instead of dropping the above as it is pulled in as stable-dep-of for 
some other commit?

commit 46e85af0cc53f35584e00bb5db7db6893d0e16e5
Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun Dec 13 02:55:33 2020 +0300

     driver core: platform: don't oops in platform_shutdown() on unbound 
devices

     On shutdown the driver core calls the bus' shutdown callback also for
     unbound devices. A driver's shutdown callback however is only 
called for
     devices bound to this driver. Commit 9c30921fe799 ("driver core:
     platform: use bus_type functions") changed the platform bus from driver
     callbacks to bus callbacks, so the shutdown function must be 
prepared to
     be called without a driver. Add the corresponding check in the shutdown
     function.

     Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
     Tested-by: Guenter Roeck <linux@roeck-us.net>
     Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
     Link: 
https://lore.kernel.org/r/20201212235533.247537-1-dmitry.baryshkov@linaro.org
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This commit talks about fixing an oops in platform_shutdown()

Thanks,
Harshit


