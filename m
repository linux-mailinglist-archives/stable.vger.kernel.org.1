Return-Path: <stable+bounces-126826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5E6A72A3B
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 07:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76288188F0CA
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3C195980;
	Thu, 27 Mar 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lddqGg/k"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DA8462;
	Thu, 27 Mar 2025 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057545; cv=fail; b=ZgLrHJ2jImFpFhuCzDcTTR29OQaNqDo1cPNdl0nvlAItsy8yCmAF685y7gweqmpOrWU4C3wkrpIjTbjk8OZD7tMiqLjMfSSOV4Ut4rUrdTF9v13YummpfSvZa9gVF1F8Q5ZRPkupkiaJPjqTAqJF8LlCTw8SxRkF1o9qRi0mza8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057545; c=relaxed/simple;
	bh=lUJxZd+D0vvkg1Dgx7Q+bMoRYd30vl1L7zFjshHr+8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=asKiRTsFZ7IKyS/Y5jTgHDzNIlVhel8LyZU32vEjc7Co7o3eCHDFtBjQ/bjjpkkHYZM3E/7jI+bgtLb58ID3F/ng6r0J2x6B997pZdx6glP/njwPMdWm+2v2ikpLAmZfR2Ks7LksG3KAHHdXVli+tQOkDAMBnmNMbJYb4MvYC2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lddqGg/k; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygyg9qjZaCNlH/MGWlKKtlQ1WT27CbbOotoPYyzfvfI7tj17bVBjhhO319rF9MhbQGu9sQx9ObfKTPQ0+DKAx2Y9ZRM9H6xVLBePUTQ5NQLbHQFX8c1EguKcpcbooKPEfR7Z2PDVMC0xAqGiqbmGJRbwlDHsufaonzIHw55NZbYXG72DW9ZaPlW1Bj41KF2ktQ5MNhAyJSGYFiitgG56bLl2X318BA7NMbWLJHlRK91PN68rwG/kXHCoGAzMcTmoQYXImoI/yFNEMdTfXQHxCx5iPO5vuiGZn81c+rVSaQkNzuLMUEF+5BnbxTDtRMt+7YVGI+KI9Sm8xRRVUCyaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgy0p9Sfu5+euvOTCc6qey0qewIfv3CINmMJ/2/9wDs=;
 b=faMCwiCf25rpoQj0iN10Y7b6gPvrKIH4vzYZ5WC+554lzSmusjkC63mV3jo3CdZefUqyJTSWd/tOkhgq/pI9ZAaD4A9nBnJvTkH0CfI47aWfc7Usq8q0Zk6sigARR+BSZzLUc1BCieZo7mZLpd8wCjnzLnF6Nsa5NlFuMLIndnKTGgO9pU3hGyv1WbAb5BsUQYMyui038n8CHO29PW7C2mFB5JWjXM/gazgQ3MD+1MTJTAgcnfizJrnWbse2CNaG49uBkhsojsqeC9BVDazlhjpQ4p9PEUzbW3E38LvqwDa9swxi5V5+ydHqHt4w38DBcbxLXYjtmN3GdMR30CP0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgy0p9Sfu5+euvOTCc6qey0qewIfv3CINmMJ/2/9wDs=;
 b=lddqGg/kLjWVwKIZO52gbFpKnLQK4h0LLxnpXhmjnqwCNOqT9/G53kuzrx5Yonh3f6mg7vWH/nlDlmf5/+mNHbxrPZ5YHTCQxl9fuFT11P+fgxGVZ8TKCj0eFdVji6sicDH3RegLyA4HAam4S7LbkkZ+qNCGKe2XythxWP+TN3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 06:39:01 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 06:39:01 +0000
Message-ID: <bb78e164-f24f-49d2-b560-24d097cb2827@amd.com>
Date: Thu, 27 Mar 2025 12:08:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 mathias.nyman@linux.intel.com, stable@vger.kernel.org
References: <20250326074736.1a852cbc@foxbook>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250326074736.1a852cbc@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::21) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c19e867-8baa-41a3-5315-08dd6cfa0f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnozVHhKelh6Tzg2WSsvZlhGRDlobHRidVVzdXF0Q0NMU2RRQnNZRjIzUUFa?=
 =?utf-8?B?OVVMOE1VUGd4RXlFMytmK0dSaW55blNWQ3FPNWg0TWFRcmZIREZ5YjBKSlNJ?=
 =?utf-8?B?NkFUU2V0RlRwc2JMUkFEN05ZK3d5VnlGeUpVcGpLb3NPY2NyQUIva2lyeTJu?=
 =?utf-8?B?Zjd4ek1RVmt3UHFOcFRWSWtkaFMrK3FjbUdIVGpIaUZLL1JzYzFXT04rdnRn?=
 =?utf-8?B?aTVZaTBDUHFqMFZldjhSY3djN1M5S1ZwQ3AvVWJ6ZFcyTkJDZkF4dmwycXpn?=
 =?utf-8?B?T1NjSGZJN21UZFY3cFpEUitJSnpyakVHWXZBb0s3eGNHNEZNQmpVY00rUkpo?=
 =?utf-8?B?WEh6VUJoWEtwUzhVRDhsd2VEbjNaRVFsSjJGdTc5RE5ydHdNZWNaaEhYeXc2?=
 =?utf-8?B?ZWEwU1M4V0RsTjMxUDF6T0xLazNvWHpzNlJubEZSdjNWdTk2TjdiT2hjM3RO?=
 =?utf-8?B?ZE40NG16aCtVSzhXUmdHU1Y2WjkvR3J3TWZOYjJJWXZWbytOSnp4dXpSNWlD?=
 =?utf-8?B?NVUzcFE3dzUrd3BQZ3BhOStmbGoxbHQ5aHp5OEUySHR5dXgyZGcvQjNQaTJF?=
 =?utf-8?B?ZDUyTVdVQy9yN0MxRVg1a3AyZG1lbmZodHBHZGl0RWFSM1U1ejMzOHo5bGZ5?=
 =?utf-8?B?M2VNZnI5cXFSUDJLTmwyL0tXaS9UWk5JNmtIVFN4SGdleGxueFd5NFFlUDBn?=
 =?utf-8?B?b0pnQ2hTVVBkSFBkYVRxNU42aXQzSEY0SGZPTjQ1aFZxY08veXBrSUFKVlBM?=
 =?utf-8?B?WVI3TEl3YmMzblN5c1VZSHFOTFkyem51MS9hVE9qSXBHRG14a2ZWRTFWMWdx?=
 =?utf-8?B?K2Q4d1VqUEN4NS92NUFKTCs0eFp5Y1VXM3VCd2krYWRCWkJpd2N5TnU3Yy9P?=
 =?utf-8?B?NTZhbEc4NEwyKzdJeTRQdHErSWRJYW51YmZDc21DNytJMXM2elBnTHIvanhN?=
 =?utf-8?B?M3dkUG5NTUYyT1pQblk3YmFFWnJOMFBsanFZSURlRjlQREpnZlBHUTFWNGhC?=
 =?utf-8?B?NFVJMEpxdzhDUDNKcXpUWGxXd00wRXdYVmJidFdHMENhTU5BYjVmZEdmRDMv?=
 =?utf-8?B?T1JwMk9OeFM0MjFQT0FJNm5XV1h3WVdPWEhhRThodFhKenVpRk1IT2ticGZn?=
 =?utf-8?B?Y1A1T25EcWsxSTd6OVFqWGs5WGlUODdNV3lpL1BiMmQrV3BIVHVZcC9xTFBy?=
 =?utf-8?B?VXVIS3JIR0FwUk4yV1UwSlNqZGlITWprM0dlRVhuWWQ0WUVJZWdJeEhuRDl5?=
 =?utf-8?B?TWR0TGc1U29wNlZ2UW1uTGIrc2VHNVJjamxndEFZVUNSYkxJVDEzSXFPVjk0?=
 =?utf-8?B?QjZ3R25wL3dvejhaV1lDck5FOTRFV04wblMwRm9tN3h4TE5mZVpjcU0raWsw?=
 =?utf-8?B?dUZNUi9taCsrM2FGVlpVV3BiQ2FLSW5icFJodkN6UGwza1NSTkt6MW4rbFRY?=
 =?utf-8?B?NUVPL0ZPMVNiRS82bTNuenFlNExhaUpTaDRwZlF1TUVXTVEwL1o1bS9FZlhp?=
 =?utf-8?B?S0k3SWFvK3Q4Zmt1bzh0MVVsUmRTTjNsak83Znl0Yyt1ekd1NHNCS2VvWlZF?=
 =?utf-8?B?R0pCU2kzNndqdi9ERDFzNHJraFU3ZzhacUh0bEYzK25tVkovU1JvWnNyMkJP?=
 =?utf-8?B?OWpqTkt0Qmd3aDArNTZTaVVPVGFxV3JydUVOaURjSURDMkNIN2kzYkhPKzNz?=
 =?utf-8?B?UlQvVkdpWGZjUis1NHo4WWFYQ0UzN1AvMG5MYVczSUxpYXBDRXRndCt4TkNK?=
 =?utf-8?B?a0d3YzdEczcvdG5RU2YveVlseWQwMk5UTktpbGxITElnSmJYeS8xcjRVbExx?=
 =?utf-8?B?c3lIeS9XSFRqOG1Kd21maThwV0pqV243Q2diM0RkalF3ci9RaEx5dkdiOEM1?=
 =?utf-8?Q?7idAy8w/K897H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEdOUExGNHFsdzNoS3gwbWhodGhka3pIaEN0VWZnWmhha2FMUFdRZjFUeVlN?=
 =?utf-8?B?aTViaXRyWnZCZGZsbitVQkp4THVCcTZkSGNYUUlnR25uVmV0T0NwU0lzd3JC?=
 =?utf-8?B?bnFNbDlkWkI2Y3BDVUJiRnVVdkk3SXlqQVZ0WEVBWWFGbUFmRUl4SGhGN0s0?=
 =?utf-8?B?WERENmNxK2UxWDhWT1l5TElZczBKcEkvUEZKQUZOTDlYM1k5ZENLM3FQTFNn?=
 =?utf-8?B?M3pBb001UXVmTFdPOGtOUUU2UnBUbXBMRnJ0NTF0VVBTOTZmam5FOVJHQjJJ?=
 =?utf-8?B?cGcxeEhXVmFQOFdkeUVwQk1Well2b0ZxY1R0QXBXVzZNNW5xSXlqdU0xcGpJ?=
 =?utf-8?B?ZVJOQ3lMeTRZczU5WVRhOFgwb1JZZGNVQWV4QUgyMDBKY0dtZ25SSnBjK0pD?=
 =?utf-8?B?WUxGQnBJdGxadzJQYVRLTFhRT29oMkxxRUEycXZXWnYxUVMweWhoR2RLRThz?=
 =?utf-8?B?TEVNdlVPck0rZjI4SXhSRXhRZStxZXJaa0huT1A5NzdHWW4wTHVSZHgwdTY4?=
 =?utf-8?B?eXlHblJ4emVIUDdZa05hLytmTXFLNTdDalJ3b2hUT1l5Rm5pNGUrNHhXTC9V?=
 =?utf-8?B?VklLNlZsTllieWVaTzhCQk1KYWduaFVJVy9wY1pUM25KTXlvcDFTc0RUT2Qx?=
 =?utf-8?B?VWZIYUF5UHNxVDh5ZFJKdG13a0l1MC9PWlZhL003MXJrWXRnMWZNRk10ci9H?=
 =?utf-8?B?T3pISEV1SzNNb21uM0tHaDI5c3p0M2UwTHlyOFhjSVpjdlArVGlJLzAyVVFS?=
 =?utf-8?B?Z3kwbmd4clhhS3U0TFlVVEt4NEt0MC8wbHRsNFVQdmtJaXVza1JWa2dzZFlq?=
 =?utf-8?B?Ym1YR2ZBUWlsTWFjaTB1Sm54RFEzcEl2OUd3czZKSk11OW9lSUdBSzRWQ2dF?=
 =?utf-8?B?ZzVocU92cHdvY0hiZHRXOGdxOHNNRCt6cTJ1Qi9xUFF4TXYwMzJEVXJpQ1N3?=
 =?utf-8?B?Qjl5dVl3YXlvN3NnSWxCUm4vS0h6Z2l3VTRXd0pSS3VDMWVsbDRNNUlBdm0x?=
 =?utf-8?B?Uy9KRWl6K0p2WmU5OHVUY1FUMlR3YzZTV2w2MW9iY1Z1TE5WNmhGWEh0cW1O?=
 =?utf-8?B?ZlVjSGpoR2w1QzBrT05rRTNpc0hjVVIzWVl2Y1c1RmVoM1o4UlJiRzVhZUNK?=
 =?utf-8?B?eHk4dzY2cWFFMTJXbEF2dFdwU3pVcDhyTE1mSHBvOEhQWDlrOGdNSlQ5dWI1?=
 =?utf-8?B?dlNmUm1nSjRHaWc1NXhickpGaW9FL1J6d0htcGNWWTNFRkdndmFiS2lhRDdE?=
 =?utf-8?B?WHdIUXRLY0czSi9DTzZmQzVCaUM3MzF0RHNqbEp0SXdVQWJEVVRsUmtZaWxQ?=
 =?utf-8?B?WVJta3h0ZERySGYzZUFMVE9XR3lkZW1xUzliSjlHWURTSlc5QjJSa0xNQzRL?=
 =?utf-8?B?ZTMyOURzUGNHNmZWVjBwNWNuTjZXTjNxa1ZDSWpTRDIzNlJLQVRTbFpIekht?=
 =?utf-8?B?THA0ZGg5WHlNRmZJbEIrQlRZc29tN25VbjlSa2QwaWhQdkdLN3FjaFd3K2RL?=
 =?utf-8?B?KzZoOEh5ZGlQU1I2aCtaUDBHVVdoSFI4dXA1VllrSkc0M1ZQZWRVeG1wWlJk?=
 =?utf-8?B?TzVwYUZVUUVOTXVzT3hIeWJUdW5Bejh3SlF6dzFSWE4wSUtLMC9iR3dpVVBp?=
 =?utf-8?B?MERPVnZjYlZnMUxzclp1VFdBUUt5RWdOR0JWbDl6eHVQZ2crWHpsRktMcGtB?=
 =?utf-8?B?R05XWXRPVlF2QWxYa3Y4YWdaR0hMY2dpY3V1UmRaODFxSnNmYzYrUjh5Z0dR?=
 =?utf-8?B?S0prYjRVazhZWkFqR25sZ3NKUnhXclNIeXF0bUtDTURPZnJMOS9oWXRTbVpP?=
 =?utf-8?B?Wk8yVytncHI4STc1SU0yZWtOUXZzWlVucWNXMm11VS9CZWNPUktreDZ2SHdt?=
 =?utf-8?B?R2FMaURhdUhhc2l1b0FOdXI2ZmR6bkZNMlREVXRUdG9ValZXL1YvL3lZL2w3?=
 =?utf-8?B?dDY1dE9rTmFKRktlMkRwVjNpcm5nY1lQcHRNMmE4WHR4TGlwbENRcklzYlFV?=
 =?utf-8?B?MGkxazhSQXB4a0ZPS284dTRSSjFzQ2Fvdi9KbnYzdU1HZnZUeVFnNHBXKy90?=
 =?utf-8?B?L2JUT3VmMjdiZmxYWGdGZGVaRkFXcUlFMXR0NS91alBrVG5EZ2g4L3N6Rkl3?=
 =?utf-8?Q?UeUAhKMj9U9OoeWmYxjbSyET8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c19e867-8baa-41a3-5315-08dd6cfa0f0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 06:39:01.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TORC8Ux+fmquXEJ7qzcOINrnNi4nScgWJCQPAtpkGVmMnsrCZ13InePt+2Ns8dMeppCUXk9qoZ7X3ScXRKnzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131



On 3/26/2025 12:17 PM, Michał Pecio wrote:
>>>> The root cause of the MSE is attributed to the ISOC OUT endpoint
>>>> being omitted from scheduling. This can happen either when an IN
>>>> endpoint with a 64ms service interval is pre-scheduled prior to
>>>> the ISOC OUT endpoint or when the interval of the ISOC OUT
>>>> endpoint is shorter than that of the IN endpoint.
> 
> To me this reads like the condition is
> 
> (IN ESIT >= 64ms && IN pre-scheduled before OUT) ||
> (OUT ESIT < IN ESIT)
> 
> but I suspect it really is
> 
> (IN ESIT >= 64ms) &&
> (IN pre-scheduled before OUT || OUT ESIT < IN ESIT)
> 
> because otherwise this workaround wouldn't really help:
> ISOC OUT ESIT < INT IN ESIT is almost always true in practice.
> 
> 
> Moving "either" later maybe makes it more clear:
> 
> This can happen when an IN endpoint with a 64ms service interval either
> is pre-scheduled prior to the ISOC OUT endpoint or the interval of the
> ISOC OUT endpoint is shorter than that of the IN endpoint.
>

Hi Michal,
Sure, I'll take care of this in commit message when re spinning.

>>> This code limits interval to 32ms for Interrupt endpoints (any
>>> speed), should it be isoc instead?
>>
>> The affected transfer is ISOC. However, due to INT EP service
>> interval of 64ms causing the ISO EP to be skipped, the WA is to
>> reduce the INT EP service to be less than 64ms (32ms).
> 
> What if there is an ISOC IN endpoint with 64ms ESIT? I haven't yet seen
> such a slow isoc endpoint, but I think they are allowed by the spec.
> Your changelog suggests any periodic IN endpoint can trigger this bug.
>

If such an endpoint is implemented, it could theoretically contribute to 
scheduling conflicts similar to those caused by INT endpoints in this 
context. However, our observations and testing on affected platforms 
primarily involved periodic IN endpoints with service intervals greater 
than 32ms interfering with ISOC OUT endpoints.


>>> Are Full-/Low-speed devices really also affected?
>>>
>> No, Full-/Low-speed devices are not affected.
> 
> The interesting question here is whether LS/FS devices with long
> interval IN endpoints can disrupt a HS OUT endpoint or not, because
> the patch solves the problem from the IN endpoint's side.
>
I'm not completely sure about this corner case if HS OUT endpoints can 
inadvertently get affected when co-existing with long-interval LS/FS IN 
endpoints. Our IP vendor confirmed that LS/FS devices are not affected.

> (I assume that SS probably has no effect on HS schedule.)
> 
> Regards,
> Michal


