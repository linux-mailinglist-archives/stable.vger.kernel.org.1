Return-Path: <stable+bounces-227983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MUiE1c8wWksRwQAu9opvQ
	(envelope-from <stable+bounces-227983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:12:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0ED2F2966
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86D0C300DCC7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5778C1E2614;
	Mon, 23 Mar 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mdKJuJXF"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67838C2CB
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271551; cv=fail; b=gdwNfq/rR+awpfoe4nz8ueKVE0k4ZYORxdW4xA98Xe/iIAfmdibuja+BjbGtsI/wFUFlJ9o8aFtaXPeh3S7CTZuLaUp3dpPw0cd3DZR3GxJZYBUfDvoNQBWKxZegTv7W0Qw9/3uCn7Sra71Lrj2c/CHWCOQ9F9zNyHjYfGyLqik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271551; c=relaxed/simple;
	bh=jSK4L6SgZg11Wc8G4W01/exX800uueY/E3Ve/WbY7Y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OAU0yWcx8wHZ+llfy1rJXUeX6kncRSXvTYqXsAaxizfCJ0DZs9OZwH+0odlH1p4WFuIwbigv2aGKDzo2HHPbqvViJNr2tFH+ERm6XaOQZXALFUM9xRARc9QnGHPlA62tZ2/yRk7/EFw7aThqGl+7XVV0NIPodAVksTwienusMd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mdKJuJXF; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOUp+yxX4RpuQiEzru7h1n0VnXXFfFOWtNfwd8a1KiXKVzlwti6Oq0fT/+ukbODWQot3wMQg+xU+lPu870riuUjf0Z7LDjYzkkgk9orT1ftx9xUCofcGD6H2N2qZfcdtnJreF3xiL8x4ygTLhjQKTPU9MRmuMedc/CSjuUPzbUI8tFS4NdISUrvpE74VBHxceayi6KG4Pks7uTk2aEfU0ZWUqzyxi10Qjzl5C0TQePogSGuXS1NnvASmGZ/o5PmgqI9S+6hKd6BBgOoEPcwfd3u4KoJrxvRZUzCoFQUIpiORswS69VJzR+exrns0ou3o/leG7VW2CfhmUbwagtXMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OVyfzuwG5sHr//kA2fICA1PAQ32vWq9LddnFIZEfoY=;
 b=KSszklvF9aD+sH4XM0Uhhnwd5j7SuRpuOUq9Dq9lEPz0iFTeTv0zz4UXv7F8pANwC9oPv+d0IIMH8OP9MsGsTcXKY5FtqRw04zT8zxVRM+DP136VGZifRDZqLOF56zE23eDp75TON+1/hbML/AcY5hG4+NXL0YnjoXJL1zPD3S7/dS+J693nMoZ6EO1JL3RyqRAnSPnt2NYAiBgMN06uSkdmhrXL9srJTeGLzJCmJHOuDCspPgJKMkxZIMprDqAUwvcbCiLKDmyG+TPf3BI7ev4RyI9z4AWgs3emhWwI75O2it2SSUJpcJWOEUA9nDQLdXGSPobW6wihc1i39RcQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OVyfzuwG5sHr//kA2fICA1PAQ32vWq9LddnFIZEfoY=;
 b=mdKJuJXF7bj80jT0kwrV57NGuNjRDIulmi/+2J5GB73cXErQTPjBqB83eJD9568iBKaxuATDZExBATiBr1a9edLhwXT3LNwjHg3Hd0ZjlEcEdqxr3q3EM40XSGmuf21+10bcbsJGFtiNBGFOLsBno5Z/BLv+YKCTsnRWPWyaP64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 13:12:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:12:26 +0000
Message-ID: <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
Date: Mon, 23 Mar 2026 14:12:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
 <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbc8def-ed32-4684-934a-08de88ddd3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TSwm1DSUYHvOM61fBGhjb2rPog9Elbx3yaFkH2+MTsW5URrmpkbnufeI9rHA6NTCXYE/5nNhokSr+nGesRBg3AYksne1MzcG8wdvSDJEsgEpSKiLIFT1knbIRHPMpqoGbPdrOVbCjofhMRSSTaLzewb92n+MCXE7N5cNOa0c/6EL2m6FfaBseV2xDZCJkhapx3VTHY3ZmQnvWP0L49MXtPDeWcwMRYjV9PoMW8S/m5HsBGjE0WwPzbHFcjI13o1qxrO+wYrvB+/qJLaOTL1XArxHVgkITTN08TW68as5GP/+nYA1nB/xqbAFS5LCqkLIwUfYjIbfn5ErWJ5d3dpRanUO5vK+FiN8F86cgHPPKUvBLfgiXv9l3i6ckdPB2fNYSbOuS0bp/h98dMlN1CpIgLPlxOPgfEpe1jCjeMwhhnth/aVzuKkVmJBIN92ruyjAnXyq4GXLGnohZIqj9XP9QqPNtdGNP1xdEtXjVKVCu68rg6PPxp4aMf1XpVCdB3VEsqkGeM5Uf/0go8+4PznhS4v//G4vdtSLk6AElaHvZpK7gZ2aXJsVQ4synpzPxtLbBPZnCwS9uu8YwW1mVaGU6J5aEWxSAhBS2cwa5pjVW5CsRBz4Neqoe6BrrKOepY4fHDGuXs9O3tX3BWAm5CWk0vCyrUOvVfr78YuLb7b7Ra+5NWPP5dLXwyvpfUl0Fg6tO1/pIU4eHioJK9FhTOFOliO72aPWdIBavbK1owCcML0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVdlRXQyNDZtZDVHOFMyNXdlbitMRW5rc0dsbHVobEFzdk0rb0lMZ0VQenNh?=
 =?utf-8?B?ZkgvekZuY3V3L3ZwRzBlVXhYNVZHQWNZVlZnYlBITExRQVFOR1lHRHNCNWpE?=
 =?utf-8?B?cFEwTWVpVDdYd21TMFR5Q0xIWE54TG1NVEFhT1dyVXJBcUdUOUEyYUJITkhp?=
 =?utf-8?B?YnRKNnZtc3M4cllIN1YvdWpKMXNpRjRxVUhGOWNvUzZlQzFkdGcxSlJxK3Fx?=
 =?utf-8?B?Ni93amZiR0c1QTR4V1MzQzA0QW1JS0NuUGMwNjF2OVc0ZHZaeU9xaklKYU9X?=
 =?utf-8?B?akxUZ0RpR045cmdlOEd3TWxHYVY3dEErNFEwK1dBV25mcmZNZm5wTkNzMlFK?=
 =?utf-8?B?UTh6TDBreXl2YTY5R00rbGdLZTNCL2FqUXdJbmlYcmpTM3l1ZzdEUmxSbXBy?=
 =?utf-8?B?bVBMOTZGMXBKSWNGMGZudVRXVzkwTlIxYmtLcmpLbXUrQUxzN1ExQnI4ejNS?=
 =?utf-8?B?aDcxeGFURXdlRVFvV3RPb2RxRVlZcUZIMVF6bnQ3SHBHbEc4b1BZWUJpYlp2?=
 =?utf-8?B?M213Y1QzeWhrT2tIZkd1dHlaVEZqUVdaSFZsc3ZkcnVLeElIclliZWlpRHBh?=
 =?utf-8?B?K2lGaFM3ZDJMaEJYWVBtdUlvRmRyemRxU3pkYU5qSlNDRG1HaEQvWldsNUxu?=
 =?utf-8?B?MnUyb1pPTE5HbzF5T0V4RlBmd2xEZ2QySzVTUU1PU3Q2dlplWHR2eDR1RVho?=
 =?utf-8?B?R2lhbGZodUErTGhmZGRJaVlmWHM0azJ2Qytkb09tbmcvRytjS0ltNE9hNzBt?=
 =?utf-8?B?dWdVTlEzVXFOdENwbmZDNThMKzM0bTY3QnQwMUlJOEY4dVV0USt0WFJvVzlm?=
 =?utf-8?B?MkxGMEd2NFdhbzNmcUFvdUJ5WUw3Q0l2QWhHakU2WVk1ZVlISDVFZjhweGVj?=
 =?utf-8?B?R0pnL1F6ZFoyVUFUYmFuRVZHdy9KZXZjbmViaUtDZ2NTcXJQME1KVHRCMXoy?=
 =?utf-8?B?dHF4SUNSMlUyRVVYa0ltQ0NkVjRXMDl2b3JnN25oOG0wR1Q2UXMvVVE3bEpS?=
 =?utf-8?B?T3dZTWMxaSt2N293VG9HYm5ia3ZRZ2s0djRLZ2QvRndSVEUwYTBBR2xNaGoz?=
 =?utf-8?B?TUlxYmVxZnozWHc5YzdOc2lzM2JYMjc1cjVGT3AvNnFRVmlXd3FhZU5lbUxj?=
 =?utf-8?B?aTNid0hVRmQ0MmdiU0lkeS9WeGczMk0rb3hIbTVaNFVKYTVTNng0QjhQa1lF?=
 =?utf-8?B?cXVEaUtldUZEM2hHRFB3aFZ6S0xiT25rQjU0YWlKZjZEV0pMbDFzWkZYWkJu?=
 =?utf-8?B?QmpOVmhLMnptVllVTmpPb05RTGJaaGFGYWM5R3RMRlVtTWJTOW12OHFyaytN?=
 =?utf-8?B?akx6KzJ3M2pHbGk4SXhtVFB3bVc5WGFDZ3k3ZkhudTAwN09DdGQ1RTFRRTJT?=
 =?utf-8?B?TjFKWk9KenhLbEVVNzJHa2pwaXkwNUxCem1uSDRXMklwMGRUZ3Q4MU15YXh4?=
 =?utf-8?B?OWduMXQ2WUs1Y0RpRFZPekQ4SWo2UE5vbkhpbTdMNG93ZXZ3SGtYc1VPaGFV?=
 =?utf-8?B?OTFxMlJlL1NOcURaZFBIVy9rNTcwSWRCSGNJUEJIVU8rNkhGUGlOSXRLY2RX?=
 =?utf-8?B?WWk5emNObWNaVTVRMzk2Z2RoWFY1UzNXOFJpY05QZWFVeUJJc2tUZU1ORUU0?=
 =?utf-8?B?MGN0NFpobTIzbHhsem1rNjlxeFplem42V0Jtb1o4UGFoamFYNm50NUdhNndl?=
 =?utf-8?B?ekRtQTZJd0ZsK3lDdVNuUXdoOXJGdklaMWZWWGJWR05FaTVWZ3lBVFpRTE9u?=
 =?utf-8?B?bWNDQTliQjQrL1VIUktLVWRoYTEweUkxTC9jR2EwYVFDU1ZlRlhoNm1mSDkr?=
 =?utf-8?B?WWFla3h4b2VrUVdudjNmdzVGT090bW1DNm4rODdlTk5VTUFMZjJ0dUIxeXQ5?=
 =?utf-8?B?aTFHUnNUUVhKNzYzcnV5MXU0RU9zUW40Rng4cmJvYWM3K3p0WmcyRXdXODR5?=
 =?utf-8?B?QjhQelc2TXVVall3WitLNHRBTUNUU1R2TUIxZHFNUUZFbXFsbXZtZUhTOFhx?=
 =?utf-8?B?aFBKY3J6R28wUC9uUUsrZWVvdjU1ZlVrc2JsVGFRTzZFNUEzeUhHTy9JdmU1?=
 =?utf-8?B?NGxyYmhkWlNMYi9Xem8wZi9DTUVXODA5c3dncXgrUGowbWI1aUFJc1JvUFpm?=
 =?utf-8?B?RFpOWm9sSXlmYXhPOWJCa1lQaFVGOUs2YWZmOW45VGVqYlo2dmlBWWM0YXdu?=
 =?utf-8?B?b1drOFFpMUsvK2lnTHQya3NueU1JZ3lYdm1PZGsxeHNiVUFJdVBKSzk1TlFB?=
 =?utf-8?B?SzNlRE1uemxHbTBjWE10a1JKVFBTdlE4MXkvRFdrNlYwN1UxZzZCTTdSSzRV?=
 =?utf-8?Q?6WYGT3CRcsUsSM1JDz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbc8def-ed32-4684-934a-08de88ddd3f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:12:26.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7lCP8TSqOXdbBrpJh8e2jxuFRsgc3AUwVZq1tb2YxNLIoLbM49iYuqTpAcBEtSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.ibm.com,lists.freedesktop.org,amd.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-227983-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB0ED2F2966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 12:50, Donet Tom wrote:
> 
> On 3/23/26 3:41 PM, Christian König wrote:
> 
> Hi Christian
> 
>> On 3/23/26 05:28, Donet Tom wrote:
>>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>>> 4K pages, both values match (8KB), so allocation and reserved space
>>> are consistent.
>>>
>>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>>> while the reserved trap area remains 8KB. This mismatch causes the
>>> kernel to crash when running rocminfo or rccl unit tests.
>>>
>>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>>> Faulting instruction address: 0xc0000000002c8a64
>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>>> Tainted: [E]=UNSIGNED_MODULE
>>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>>> XER: 00000036
>>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>>> IRQMASK: 1
>>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>>> c00000013d814540
>>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>>> 0000000000000000
>>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>>> 0000000084002268
>>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>>> 0000000000020000
>>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>>> 0000000000000000
>>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>>> c00000013d814500
>>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>>> c0000001e0957878
>>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>>> c0000001e0957888
>>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>>> Call Trace:
>>> 0xc0000001e0957890 (unreliable)
>>> __mutex_lock.constprop.0+0x58/0xd00
>>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>>> kfd_ioctl+0x514/0x670 [amdgpu]
>>> sys_ioctl+0x134/0x180
>>> system_call_exception+0x114/0x300
>>> system_call_vectored_common+0x15c/0x2ec
>>>
>>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>>> ensuring that the reserved trap area matches the allocation size
>>> across all page sizes.
>>>
>>> cc: stable@vger.kernel.org
>>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 139642eacdd0..a5eae49f9471 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>>>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>  						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
>> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>>
>> That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.
>>
>> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>>
> 
> Thanks Christian for reviewing this patch.
> 
> It is defined in kfd_priv.h.
> 
> /*
>  * Size of the per-process TBA+TMA buffer: 2 pages
>  *
>  * The first chunk is the TBA used for the CWSR ISA code. The second
>  * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>  */
> #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
> 
> 
> 
> Could you please suggest the correct way to fix this issue?

I'm only looking from the POV of the VM code on this, but my educated guess is that KFD_CWSR_TBA_TMA_SIZE should be 8k independent of the CPU page size.

Background is that this is written by the shader trap handler and that byte code doesn't care what CPU architecture you have.

But I think only the engineers working on that trap handler can really answer this. @Felix / @Philip?

Regards,
Christian.

> 
> -Donet
> 
>> Regards,
>> Christian.
>>
>>>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>  						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>  #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)


