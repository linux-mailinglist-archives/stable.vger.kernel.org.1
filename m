Return-Path: <stable+bounces-62806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A3C94130A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0817B235C2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C2319E83C;
	Tue, 30 Jul 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UcE5c1My"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1D18FC6E;
	Tue, 30 Jul 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345781; cv=fail; b=lrcnSb202zp4aIVwpCES/MWkwPu88QyTdDU3uGUGh6J4/8QWpdDkF8XMndL4C0PICVAfZVtbpl1BthulqzxrtRT/pMMYyK0CSG3+ufrv7MTFjtKvSqgyu/TOH2HqHMb4G3um0jVaC+ZGnvTIg3FEhn9nzC9h866ObDOwWX2QSzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345781; c=relaxed/simple;
	bh=jisBW2tgIpWO32oFOwIm+6kxDeiOVJ13kJiV5Tbn69E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rm7Dtxeq0QfN0KvYw8QkkOlOct/D3NCysBAev8GzAZI+jkzTwioXDl6eve1cH4Ew/jiTdz4+NbOOqfpLpIWYM2u4AVlbANhLP2QfCDmuPE3QiKBiZn/wvXtvXjcTPj4QRJtO/rXbzIN0HCHBgbD+c6EZpzN08XViyYyfSa9BXf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UcE5c1My; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFlDMoH6UWkTk3NI6rP5e4xmgC8HFdkb3K8JOJH/p5knv/te4q9vRydak4jz0xqWw6kfNS0UOjEPOvOppzWxyZWa2sH9p3F1EaEQVD/YtXHDJ9ienZb8BE1xYcTx13tVDbEfJFglb7XjNHEqIqt9fsBUzmdttVE2uUaVYnt2M7Qz0yLxyFRnPSYsUSX35zgiyLJPO26sGsVPMWo+bZl+1j3aXblzp42JeyOFerJERoPTJq1oipxbTvnGkS3geVVX3J8pWw7kaEXmYK+YiTHQbPZVJYVi80+8+d4Ac9np0VKgo+CijC0yYlJy/pfntjlVLfyDX7naaAhZYpKtSi6ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDh3lG84ItpOQXEdQgf28wmYwaZp+fdOr/z/AUZmVOw=;
 b=dQdnjPlTXo9I8AtovZW8CUUJP95aHMn4Yi1djNybbV0jN/GP1GjYDo+UNv3jhStLR2Qs6lr4fEwDcS5SyX9aTchSfM9ElGfMVrf2jW5ngcmFhuX7NMSsPuz3JKYzTcJGp2YwkwuroM4bRZU04JFh1WZf3wvtAK/FpmJwE3jU3KmGhEEHv/VAoVrxssImdRb8BtZrTJIqu1fjEJ+sLUdnQ0Pczz3vVbEGaM/3/TDAkgRy5faFuHRMDItN11YRACxqruYExT+bo5cs3l64IWcfmHEnFcWdzyTxeRm7Zl8ATDmjyDmn4NNazTlwezLKA0Ti+kimUa7dBXsxX6fz7vMw8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDh3lG84ItpOQXEdQgf28wmYwaZp+fdOr/z/AUZmVOw=;
 b=UcE5c1MyQBcC80c92/DslVe9SOb1yiYCSuUa0EqkbZb1bteaeMkqQRwclFJRrrG0dglTuUkAjJPw8fw7LLiw1+3L8jwvuMBj5A+aHGOQyzSc/pl520xQdbgo6SNRWXuzp3U6HonTB2BCfCStCxh3hTmOo6mJQMOMQVkujsulRmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:22:56 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:22:56 +0000
Message-ID: <15796d83-2dd0-7c45-af92-4ee476043b74@amd.com>
Date: Tue, 30 Jul 2024 08:22:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Fix __reserved field in sev_config
To: Pavan Kumar Paluri <papaluri@amd.com>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 stable@vger.kernel.org
References: <20240729180808.366587-1-papaluri@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240729180808.366587-1-papaluri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0104.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::14) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a351e5-5a06-41d7-2f11-08dcb09ab981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmdqZ1VjS2NLcWVSeHV4aGtPYUNOdW1FTWZlbkF0NUdJKzZsV1VpTUdiTGk1?=
 =?utf-8?B?WHN0eC9ZQk93YU9Qd25BSmVYSWpJUDZRcE4wSWwramdrKzU5cTRuNkxyUWkv?=
 =?utf-8?B?eXUwajdNbmJ4b013bkR1OGNnWDMvRWdsYXphYlZsS2tIK2RRazJPWTFyQmVl?=
 =?utf-8?B?WENybDgyWmh1cHV1TFROdmFqOS9WZ3FsWjI1c1IrYm8xMk55L2ZJV0plNUVo?=
 =?utf-8?B?b0RCM1ViUzZ5alhSNFdwT3QxOS9EN3V0NlpjenA5bmpncFN0c09MbStCaURB?=
 =?utf-8?B?c25ZVWozU29yT0R1TnBLdzBnYURLU0NNYk13OGVKdi9OTnVLMXRjZE5pUEM5?=
 =?utf-8?B?ampNNllEbzRkTlI0SXB5TmVFY0E0R2tHYmlESVllYnFmSDJGUkF2dmFqcmF5?=
 =?utf-8?B?NXllbXM0WFdYMEpmby9qSUU4Qm05RFVxcEVRWUlackhmaWNaTWJBVHVFUVRM?=
 =?utf-8?B?S2ZXSTJIbzFFeW9sQ0p4YUxCTnhiaXFWQ29tMWQyUkhkTzRVTVJKc0IzQXlt?=
 =?utf-8?B?YllkQUJhYjF2Z0NkZ1NFZUkxb2J2WEZTQzBURDhTOXNYMis3Q2svM01mQmxa?=
 =?utf-8?B?UlJCNHNwdXVHMUI1OFhKV3c5SDBpaEMwZkhLd2hvcE96bm92Q2YwbGF2a1RT?=
 =?utf-8?B?ZjBvWmcrL25xem5ISERrSVlEWVNOMERBa0hVSHR2UFJWTVBmeHF0MjVUT1lm?=
 =?utf-8?B?K2poRHZhNWZWa2w1eG9QZ1NQbVFhUGNxa1hLN2l6bmZDL3BXOVJocnJ6eGQw?=
 =?utf-8?B?bUcxVXZJektXaE12MzBobE5yZ2VnWHBqdzdEZFFWaERYd29CY2dzR1dpKzN4?=
 =?utf-8?B?a1BadDFrSTFhb3NMRW5ieVdhejB1d3FZMjFrekxkNzJ6ckpxQnRKb0pOTHN6?=
 =?utf-8?B?aU94L2F0LzlMT3BSTEFOTEdBVDlJUW5IQTBMZXdoaEZURkdIeElhVmVnV2Nk?=
 =?utf-8?B?RG1tSGQwMG80cGJwczcwR3NSSFFZTnUwU1VHNzVLUzBJQVc3U2l4SldLRlJ6?=
 =?utf-8?B?YTJYdmxSaCtBei9nZ0d2RVFWSFNFeGt1eUtYZkF0aEdkQ0YwY2lQZFFZWjh5?=
 =?utf-8?B?ZzhXZGVqUVh6YVhmWll0ZkRjMHBVWkZCUzVFS1c5RTYyVGJLVTZNY2p3dFd1?=
 =?utf-8?B?cHAxMlU3ZFovbUhHOHovckJ4dXoyWnMvb1laTDgvM0dXWnk3TmpjcGswN0Za?=
 =?utf-8?B?Qm9rK0U2VXFqQ1ZlcXg0ZEkyVjJLU3dFVTBMK0lOMUYrQ0lKMVhSd2U0OUtB?=
 =?utf-8?B?OVpPS0t5aVg4RzNCRzBTZzdGVVp3YTdpcDJGZ3ZibUIybFFodTJsa0RiblRF?=
 =?utf-8?B?SGVFNkY1R2ljSGZWTWlaTkMzMzYwSHZ5QUsvc2Nxa3k2Yk8yazVwN0R5dlMw?=
 =?utf-8?B?b1pZdTc0SnBVR0RPT1lsaGZwcHR4amNkYW5HSzhFSXJYQjhVUmt3cEszWGEz?=
 =?utf-8?B?VDJRUHdEdFpKYnJnR3BIaitUOFMxN2NZYWwyZmw3ZlpWVDZyV25pcnZoRnFi?=
 =?utf-8?B?YWt3NlNFa0VXTDljUmxkbUVNNjhlKzdsOVI1UmU3USthUlFnZjFyOFlLc3I1?=
 =?utf-8?B?R2c3R2EwR0JKZnk0Z0xkcHAwcWh0dW92b2RSTXFsb0pkRGlFc0RNMUpwNHF2?=
 =?utf-8?B?a2E4cGJzblY0TGVjeGtQV1F2dEFTOXRUVHY2djJuMU9PQjZob0JkZG5hTE1Y?=
 =?utf-8?B?bkhCZVBKUkNJaXI3Ry9ROHhGdnlXYUhBTGhFaGNsdnJhOS9Cc01tbmNjU0xo?=
 =?utf-8?B?R0dCbktSNzVieE9uSldPRFFGYjJweW9KUTRSQWwveGQvV2QrUjhWcDQ4RWZz?=
 =?utf-8?B?STlRWStHZXNXZ0lqRWxqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHpSRU9TZFFsaGFLKysyZDZlOUMvamZUVXBoSjQrZXB3d0lkZUsxTkU4cUNr?=
 =?utf-8?B?ekZCelRZcEozNE1nclFtQXluOXFvUGZkMkQrNWtHQStvQ1lqYXUzelI3Qjg3?=
 =?utf-8?B?Q05NWXkrVmh3ZGJZd1o1am1YdWpRaWJqbDhsYm5ubjYwbU96UmpmcTBWTHo0?=
 =?utf-8?B?d2V2K2ZiVEM5YTdINGY2YmU2VWZiaDBNMTRjdzR6RkFlWmFwNzZ4OElvMnAz?=
 =?utf-8?B?d2RvZ1UybVp1SlB6c2N3NDVBVkVWSzhHazRiYU5pMVlQTTdmKzh1a0ZhZmFP?=
 =?utf-8?B?Uk5KeDJvc29QWDZYWDAyc2dRRlV6N1I3U3Fiayt0NHdsSENib0pNWTYyc09O?=
 =?utf-8?B?aEZMbUNqNWVCYU1vVk56bDRZdjZhMlVEemI5UTJqYzh0ejRGbzhraFpOTjVJ?=
 =?utf-8?B?a05YQjdCUGpjUGF5RDFhR1hlSmlrNXEydWRYTXdmU3MwUmFMUzZsS3k5S0Mv?=
 =?utf-8?B?bHlvdkgwdVM2LzB2SGJCMVowa3FlYkFjMHg2TDZlTURzRFpDcG5Nd2lRV1RW?=
 =?utf-8?B?eFNNNXVmUUFidDZzU1p2S0J2anFoZUtxNndUZlVRMFlacTlGalVhQXNUdUFY?=
 =?utf-8?B?QlZjWVNndkdDRWZBWVBKWlZlRlM5cjMvVGFFaFV5OFBWeFJuWWpTUUtNNjF1?=
 =?utf-8?B?aVNHcHpQbmFvNEZnTGpUK3VtQlkxbWw5NXZNZFBFbmtCUzJQU2lydTNudEFu?=
 =?utf-8?B?WXZ1MHkxMms5enZUczc0NllibWFWeFhabjYzbjhjZ1puRGpVdHdnRGlPSzZ0?=
 =?utf-8?B?RDl2bnp2NmZFemtJUWlGVTd5bFVMeVBJK1ZsRXFuVmpkZmNuam9LeEtiZ2hG?=
 =?utf-8?B?Z2pHTWEzUnZpbkp5MWo5bTBRTmpJQVByYW1wcENKNlI5NG9nY2pzcjNmLzZX?=
 =?utf-8?B?RDRjNlpZTjRiVVpsYnl0Z1l1bi8wNmFTQmtwVllVbnFobWpXb3pNekR5Q0xy?=
 =?utf-8?B?NCs2K0IxNkJ2cGNFcEhLRGg2SG1jbDV5dStkdXVieThnVld5ODdJN0lmQVF6?=
 =?utf-8?B?aGxlKzB6Z3pMdFRwT1hBckcrU0t0QnJZQVNrOTNkNkJSbFZWelNNWFRxTlJm?=
 =?utf-8?B?Tm1iN0NWRy9Lb0NtS0ZxeEdTYXFCR0tCeW03TGFLaVdwVEptNjVvKy9MK3Nm?=
 =?utf-8?B?R1drUnlEUFhLMVpiSE1ZOHI1V20rYXdJRWdGRWFyMEw0cEdpNzdhTEhsVjE0?=
 =?utf-8?B?RUVQY1A4NXRpMmJWb01IckFUQW5MQkxwR0pPVUZnZTZXOUFmZTZHK3V5Z1Rz?=
 =?utf-8?B?NzFSVVB4VlhOcDQ1S05xbnZOVkMvVVVqU1dLUUJTemhIdzZGbzM4VzJsZG5N?=
 =?utf-8?B?aGd0SWg0N0QrTlhnSjdmbjZERnd5M2hjMjlGcUw4amE1L3JmVERxUVJidUF3?=
 =?utf-8?B?ejVVSm9EL0pDM2JYazBxalduelVQcHA0d0VjUm1WN1l1Y1d5SG53R3ozUWhK?=
 =?utf-8?B?Mkx2NkdkSVhsd2tvUCt4dVBzYWpqL3BOblhtbkFNRFBFYXlYZE55UVVLNEx2?=
 =?utf-8?B?c09UaVBKL2pETk5iZEhMMTV1anQ3Qk1RQWxONnBOdVN2cytLVFVEQXJaRUI4?=
 =?utf-8?B?M1JUbDZ2TGNWbHF2REpNczh1VG5kSzFLNnhxZGxSUWxobEtSZDF6SU1YbzFU?=
 =?utf-8?B?TlpHZHhXZlBZWVBIdWdqYVc5eW1CaGdzeVYrRjYzdnJESldPc2w3eXlaOXNw?=
 =?utf-8?B?RU8yamZ6TTdpbDhuT0hhYWVZU1ZsY01qU01tZXZqb2RGRVJtb2p2RDF1aFFO?=
 =?utf-8?B?bGU4TEM4Ritoc0Q1UEl1QnpBNWNlcUpFQmZUcXVMWXJMcXUvdjlJREhYTHBW?=
 =?utf-8?B?b2U0VkZXcDBLMFNtMitSNzdvS2hsaUlacTd2ME9HSUVYbThheDVUeEcyKys0?=
 =?utf-8?B?ZEVuTWRkdGJRRXZ2N01TT1dBaUdZZDludkVLZnBBTHJocnVjRGxRbXJhb2to?=
 =?utf-8?B?RFRwV0lIbzlaRkhVaWNkaFphT0xMdjhrdm9tUmU1RWNWbU16ZmlaZzlRQU5h?=
 =?utf-8?B?Z0E4Z3pUSkNKTmkwN3N2aklna1cybVJYZ21mM2tXSUZ0SWJ5V3JqRG9CRkZN?=
 =?utf-8?B?cVMrL2s5dnRWNWVXSE5uVmxEdVc0N0cxYVVzMGV4U0oySUpabnVjYUFwMUVn?=
 =?utf-8?Q?4jSJY4+SipDB1mWpB+lDhaaqs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a351e5-5a06-41d7-2f11-08dcb09ab981
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:22:56.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOKraK+qPyjPYi1R5OreUpqyEkXqImpBpinsM/msQOW/XvLnr3ZcJqA4ZmVBqsuKXErDUnkWfwCOS2o0v6gY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

On 7/29/24 13:08, Pavan Kumar Paluri wrote:
> sev_config currently has debug, ghcbs_initialized, and use_cas fields.
> However, __reserved count has not been updated. Fix this.
> 
> Fixes: 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

You'd think the compiler would spit out some kind of warning when this
happens, but I guess it just happily adds another u64 to the struct.

Thanks,
Tom

> ---
>  arch/x86/coco/sev/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 082d61d85dfc..de1df0cb45da 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -163,7 +163,7 @@ struct sev_config {
>  	       */
>  	      use_cas		: 1,
>  
> -	      __reserved	: 62;
> +	      __reserved	: 61;
>  };
>  
>  static struct sev_config sev_cfg __read_mostly;

