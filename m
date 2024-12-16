Return-Path: <stable+bounces-104355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19339F32E2
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09103188268C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86802063FE;
	Mon, 16 Dec 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9rpFlVC"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653B205507
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358409; cv=fail; b=PTiJ2CjuNociU4IcLgvL0BwPJ82m7QQysyGSKPm1j7tl4eDxU1Dnqh26OHqw5un2b0L7dIqx2gxbW4sghATNM0u+9MOEvwar0LWlN1TEtCUbYPle//0GnG4dw0KJDWAmza9UZukjjnQwImcBl58JOaDfs4qRxW4/idakyDat+sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358409; c=relaxed/simple;
	bh=1b+VO0kZtiMTgz70zzxMZw2OAt9ffyMy9mPZQvsFHpk=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maBJ6Wn0sVaeiBz/M+UTdDSrSd1V4w1Vay+NuwNjQiEab8p+46IAbXByZSGMCCO+jmn16ECw0DpXzsDew9K1rkmluINhslTRhuLEgrmZR82ozqW8ETKNEzddpjSJ0ZaP9YAncqPBV6AcaMrxK1U3L4sZ8grKjYvMcKk/vvHGtCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9rpFlVC; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqqNLl8Jzypia/jSFWaVOC0YLcli8UaMwSr4GjmtccSS/WFiK14EU0zcA4ECFTDJUa7MXqnSm3yCrQSqztcfntuzuXjkeMObJTWVfMP/Y61CXDQrYQsAt60EFUU1bZ5UdyTc9G8j7eI8bt55AqhuJWyIjjXkVGTc83XgcpjQ9R8/+ipvKz4lZP4WcJVZ9MqENPKWMeLea0Dzq7EMyVQpJzInU6JoLS7hnedujbbSKGcG8uuZdjmCRMQ7hOxybTG6ANZwfXFFEhhZvIgbxX8pNjmyEGIzJXWg/HDThyYrSCR6HKXE1e0UOCWmjS3rGnTREv3XYota4rZ0+/KuQnCPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ9K1wJ3D1TZtdj0FKWA632F6cae/djwDlpuCbkKR8k=;
 b=XZTs1hEx1n9gG6QFZ0MF+v5b5CANqPMKycvlaEzCis8xLy2YiGqZ0ZVBJ3gZTKOeZWDZ2dz2p4P7BHO356NP39XqGtJMHJ8+QSalC7GzWfbHE8I+P7byilTRUGyRHG6lJ8H3rs/ASdOaZfmBNkNUoTs2mIP0Eo56Szfl9NsL7Aohb6gr0s6aswVdVjPHh829oJ/z6OFOPOUWTpj2sU4vVAG2/vtsCq9TWNEhYrpE56utqtUzXSPndwn62CM+o/D9weAj2M98b754My5QGVqv43sJHv7Wy8k5zA1caJUo2zYQ4BnL+e1o34EN0NIpYi2rCXdFDr5Ij1uUy4IZRBq+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ9K1wJ3D1TZtdj0FKWA632F6cae/djwDlpuCbkKR8k=;
 b=y9rpFlVCj9UgGLJFaV7RDrDaOCdrwi8F85AqqIAJ73rdgIeSs8QF0pjEu+TX3dNmow4cqh/HDyqP5SC60WYim1JoQBaJNbOp1ZU5oNjuOHl6JX0d7oKB5fMYPai3D7yRCyCl1KG8+VI6i+yr3N63zAbHIO+msyvDho9/6cobIHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 14:13:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:13:25 +0000
Message-ID: <0d681c5a-a138-4f8a-865e-a192458ae893@amd.com>
Date: Mon, 16 Dec 2024 08:13:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.1.120, 6.6.66 and 6.12.5 crashes on Vega with a
 Null pointer deference
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
References: <719b5eb1-a5a9-4dbe-b3b1-399fb299bafb@manjaro.org>
Content-Language: en-US
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <719b5eb1-a5a9-4dbe-b3b1-399fb299bafb@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc4837a-86d9-4cdb-22a0-08dd1ddbce33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWd3UWJBWnB2UXBnRU1lVHVsaWkrMmsxSjFBTDZ2NVA1Qm8xMkpYTElYQmJz?=
 =?utf-8?B?UVZxdHFidW04Ry90ZGtBeGJoT1ErYUZtck9pZkNxRkJtb3JtNmlZekgxZ2Vh?=
 =?utf-8?B?c0lHQ3FsV0tNaWNab1U1d0ViNnp1UlZPbDdZRHFMTjVYeDdTUXhYY1Irb3dz?=
 =?utf-8?B?aFVubEhOQXZGRlk5dTBudFJ1L25vbGRJTmpBUEhkY00vL2xCSHo4WUc2Q0pS?=
 =?utf-8?B?czhBbDZCMHRkYWh5dUtSU1FkYmFob0VrdkQrTXloZ0lNNjEvVUNaTkdkUUh0?=
 =?utf-8?B?SFVWZUZjZW9ZbVV5bmpsWDlUNnQ5c3BGbHhSWkhGME1YTmxsUFdKVHJOai9M?=
 =?utf-8?B?dEpBcDlQZnBsOUY4eml0SmFudW9pcEhBdTBncnB3RzZ0dlIvQ05Wa3dXeUIy?=
 =?utf-8?B?WFhGL1dIc1NnWVZ6M1dPSEp0Qkh3a3FwRGJPUEQ1WllFckNZanAzaE91akFt?=
 =?utf-8?B?MjJrSDBTRnZXc0VQallZSmg3SWZ3Z01vZFYrMlVjNEJBN0hWL3pCdHo0Wnhx?=
 =?utf-8?B?YUxXeHlXNmdUaXdzUWpXWEhTSzRjcXJYKzczS01oWjJwWW8xRE9INGIyalRQ?=
 =?utf-8?B?c3RnZUU5OUpMSXptVEYrK2ROTkF2R0FIQTVlZEpERkpPUVZyVG9WRDZhT3Fy?=
 =?utf-8?B?d2tYclkwR25BVHg1d3FUUXpGTDBsNlJJbVZRbERxK2VreVJVTTVsRnZabWxr?=
 =?utf-8?B?ZmtyQ2JFWmZXS1I2YkwrLzFXYm1heGlQVHJMandOTUVjSEcyZmVTeXdkVGpF?=
 =?utf-8?B?ZTBVWVRHUjdoUVdxSmt2UUZtRlRvaSs1SVBzRVowZnZPOCtvRWoyTTJYSVUy?=
 =?utf-8?B?YVprYkU1ZHBZVHVQNjJFYzNlekxNY2NnMjk0aExDWnBSdVJ5QmhxOUw2c0ps?=
 =?utf-8?B?QjhBTFNhMk8vbmdFUDNrWFc0anQwWnVKS05XMmtNUFExakJranFtYVgvVm9T?=
 =?utf-8?B?N2g3U0c3M3lRVkVlbkxpSlBLUEZBaXVkRFBJUk9EMU5nRU50UHVuYUJGRHNE?=
 =?utf-8?B?bjhucFMzbkswbHcrbFZiTHIyQnlTT2tDLzl2UEEzdW5FbDdQL2ZPNlBpdkEv?=
 =?utf-8?B?U3pzWlVwWlh1L3hVVWZZSVpOc3ptUnlpWkN2cVFnV090VGVSclhOdW0vSVNU?=
 =?utf-8?B?Z2EveTdCSW5sZlFxWWxSUjBaYy9VOVhKOEszR05sQnlOSkZXTUM1bk1zd1Bn?=
 =?utf-8?B?ZnJ0OC9TRXRiOUNnRUJuOXFJMFhuVGRBVFRxMWVwTXFlUWthS05Rc01GR2tv?=
 =?utf-8?B?ZXZkcWdJTWJsWjdlak9GaEZNeDFSTXRBME9LYW1iWXlwT3VhcUpydXRHVjFT?=
 =?utf-8?B?UEF0Uzc3YlpvMmQyV1h1VVpueXNUbGNIM2trVFNEUER3QldwZDFZOVc3cUFH?=
 =?utf-8?B?YVlTbFFFVzZzT0xyd3hlZEtqN1IvekRPallIeC8wK3BnZzhXVGtNMGNFNjVu?=
 =?utf-8?B?eGR3bGxRaytqSzVYb3N5WFlqQmdoQkpqQkFFeXVGdXZNUzFKeVpPZXFubVlp?=
 =?utf-8?B?N21EamtWOFM5bWpOL3ZyWUhyWGRqcUlVbHgvRlVteDRyZkNtSmVzL0dxT3hH?=
 =?utf-8?B?NEo0YWdsUVFHYXlTQTVyaHdDd0VtaldVRzlHK3RjdE5qT0p4ZWNKajBmUWpO?=
 =?utf-8?B?dTZpWDU3b1RHT3MzR3pockFKTXZWQUVqUnRZMDBCV0NxYzlkbFBSVjlXQ1h0?=
 =?utf-8?B?Rmp1WGlNTU5YTFkzLzFUSXVUMHRvOUJVZDhtTmMzTWMwRWl4MDZ5YXRWL2RK?=
 =?utf-8?Q?WFWJErcy7Ia/6gr8Eytkv4FsFuasHZBaQCWIK/4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9wVWx3QVlvZTFvN0ZWeGNnTjZ5U0ROODJHZ21lU3Exc0ZyMytmUE11RGRY?=
 =?utf-8?B?d1BabHAxQ3dHU2tITzg0Nndtd3dhVm1ObDdtblFybmMvalpUM3hCUnhnU0pG?=
 =?utf-8?B?N21hemZDOWVKUUQ1N08zcFNSanBLZ2x0cHA2aGVyQzlSYmZINDlrZmQ5cWNp?=
 =?utf-8?B?MUE1aTl3aUdmb1I0Qm5QUklRT0phOVh0a2x6RTRSb01KNVRqZHdNN3pkYllt?=
 =?utf-8?B?UmpjMDk1Wit5Z3dLRlVNekxkSEhpTEZ3QU93RFF1ZUlmMU5jcHFXVlBVcm5W?=
 =?utf-8?B?dVFwaTNBOHZ6N0lFMUMxUThvZ3lwTldmMnJOTFNyRE5xV3FKeGU1Q0NZYWpC?=
 =?utf-8?B?ME8rRnlCem5ldFUrY0ZQZTNYVW9BMWNleUs1dWpHeTZHN21jSWc3anZ5MHZy?=
 =?utf-8?B?d0hUME1xL1ZzUTR6SUZnU3c4ZGNMUjlpVlIzdTIzR0pTbUNmc1diZHB4UUpz?=
 =?utf-8?B?MUpIUjlPcEc5NGJidHFucmpySzNaWFZwNGthR2dZNUNXNzJSUFZnZGYzdU5y?=
 =?utf-8?B?NFNiWitzVDFGWURoRDE3YjFrVUFYNXlMamkrV1RTVkZGelpWVnhzWnFzaWcx?=
 =?utf-8?B?OEY2bDg0enB0NEhrUjRmU0hmSDJ0R1BET1JURno3ZDlNWVo1YWRRWnBKNkpK?=
 =?utf-8?B?NmhGMWlPcU5hU2xZTGdkUlhOV0J1OXBwWWVpbzZGazlWVE45V01KY1Uxenhi?=
 =?utf-8?B?UWliMHRXdzdSK08rWjNYUnhrbGo1ZTFSQmlmQ0h4SW9lWjYxa0FzalB3UUR3?=
 =?utf-8?B?cVMwSTZ0TXQrMlRPZUY0RnhiY0hycmNsZTJRL3AzU3VoNGs2aGpHekcyTWww?=
 =?utf-8?B?LytQMW4waTZGRU92ejVhNWQ0SDE1eFd5T1M2OFMwc3hGSWd5SXo0ei9jb0lq?=
 =?utf-8?B?Q2R0cDdJa0x4b2o4ZEplU3ZyTUtMZEF4ZldZYVIyWVppMXlHTTN2STNxTXR3?=
 =?utf-8?B?eVR3aUgrYnYwSnQzWGh5bTY0ME9ySnU0aThFVlo3UEU5cGlpTGpSQ2o5Mnlk?=
 =?utf-8?B?VURZV0VmcHdHaXQ5ODRFNnJpaXc1NmI0UEorKzJWMmdIamFFeVVTbXF1ZXZm?=
 =?utf-8?B?Rm5sS09Jd091N2NCK2Y1OHBSbER2eU95VXJNS09GRnRkaGNKQlFOdWZ1elg4?=
 =?utf-8?B?cFIzNkhZZE1uUG9aRXRFVUp5d1BZSW1BZ1V6RHlQcm5ZK3BZWXFuMGVHQXQ4?=
 =?utf-8?B?RFEzN1RIMUdxSVBDL1Bpd1FwUHpORnhuRDN0clVXOWpyVXVVOE9RcEh5b2o1?=
 =?utf-8?B?dlBpS2Jua1ZhRXJGNFJId3draGM3d204cm1oMVdLOVBhMlE2U2doOC9taEJx?=
 =?utf-8?B?U2kwSU9oWktwa1BDckRRMVRVSW1ZaEMxTEZVY1dCRUFQa1RTMWsyc0lENXJL?=
 =?utf-8?B?OHpqKzFlWlFVS0RZR29sSUE2eXV0eFM4UFlrd01WNUpqSXI3bHNJdVlDOERk?=
 =?utf-8?B?WU1NbkRmUWFHclBhZFhUTWdBdlZqcDNKUm1LRzNNclVwRDNzRFJweG9qOXpi?=
 =?utf-8?B?QXpnYTBBUFJnOXZLVURYaVYzSzd1bU95WnJKN0xvdHN1S2dRQjU1QXVzNitJ?=
 =?utf-8?B?MFFmN3JFWi8zcFlRVnhaQ1VtL0FoNk85T0JZNDZWQlFaM3drSXVXNHVpSGU2?=
 =?utf-8?B?UFlqYUg4VGUrbzc3UGs5cDBFSmdrVDFjUnBMeEgxeFRJMlAwN0pBUk51VzRK?=
 =?utf-8?B?M1hIbndzTnFaMXJPZ1FhY3ZReTlXeXlQcmFTems4TjFWWGlFeHdENkFldUdR?=
 =?utf-8?B?TnU1V25BeG0yZmo2aFBHYnJGOXI3YllnNkVHSGlxd3NXb1B0SE1TeFZ4TmJt?=
 =?utf-8?B?dW1LaWNRbHd6T1pBYVV4bEkrUjR4dkNxSitjUWVhRWw5T1I3d3V0U212c0dw?=
 =?utf-8?B?STlQMzdDVWVVcVlwWTMxQ3k5YVdwc2xoYWRrNzR3RW9Tb25GOHpqOUl0bGc3?=
 =?utf-8?B?cXJVOFh1d2tlR2wwZGlxZEtTcGRXYzRzelNabElmOEpIeDFKWXFNNmhSQmNL?=
 =?utf-8?B?bDNUUzFKbkVSL2IyQ2NhTVU2alpxN1AyRVJ6ZFZmdUlMaFEvZERYeXR0bWds?=
 =?utf-8?B?dWMyMzVnZm1hMHNvYWFRekt2cWU5aUI5d2taYVpTcm85RUVIRTBlaFVnK1Bl?=
 =?utf-8?Q?P8/VIeWNwdejsV0+1zosBWty7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc4837a-86d9-4cdb-22a0-08dd1ddbce33
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:13:25.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOQcIuIZygGMkMIdx6WdB+agGHdn0wVDm4iY8HFiBM9Qsh+Ixf0AXBXDVivrKBlDv6q44gak1row1Sc23YY4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

On 12/15/2024 10:37, Philip Müller wrote:
> Hi Greg,
> 
> Due to backporting 2320c9e of to 6.1.120, 6.6.66 and 6.12.5 kernel 
> series we have the following bug report: https://gitlab.freedesktop.org/ 
> drm/amd/-/issues/3831
> 
> The commit 47f402a3e08113e0f5d8e1e6fcc197667a16022f should be backported 
> to 6.1, 6.6 and 6.12 stable branches.
> 

Add regressions list to keep track of this.

Add Sasha for awareness.  It looks like this is a case that autosel 
picked the commit, but the "fix" hasn't been picked for it.

Either the original commit should revert or the fix should pick up too.

