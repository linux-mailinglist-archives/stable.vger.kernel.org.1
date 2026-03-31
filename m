Return-Path: <stable+bounces-231365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPKPFEmSy2nMJAYAu9opvQ
	(envelope-from <stable+bounces-231365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:22:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43041366F67
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28F6D3076609
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD903EF642;
	Tue, 31 Mar 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D9LjarfA"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3F3E5581
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948355; cv=fail; b=lv+OlK3v0Cb6Dmm4PU5N5bG5U+To3EtFmkmE2FXfNoZC1urvsyLjcBv5mFvG6hJ3PdCp8fKxnETZyEaS5jabkNMrSc1bxG2yLo2toD70IomRWaqxy0XoCSDrgEjFzxURukUa7GoEPGpAHD19ue603LjEOJ2G2YidpYuNs4KsaMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948355; c=relaxed/simple;
	bh=tuy9J6r3ci/jMbON2EjoIKKHoAjcIMI8HQbiG1ETo/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NtbULuZLNWvn/gZ8yAlNBoEeebjNFqDNYAh9NynlLDKywwD6aEYc8131i7OkO/hNmQ46+5h2mn1NoNyl/ULViXbGRJobxDZcyv3x2hJX9g7rs5+oRiveUIOSy2nrKAtHg+FR0Sztw8dXCKITvNDpxzio/5zW0qoHObEQGeHU8nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D9LjarfA; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m45M9dy2qWcnzaCrvYwZ6sOvWsDNrWfOTK2noQNPgUAlSauoZu5Vxl4N9UlVMeJ2jjkHfOFWcb6MKHfluciFO8HJl41FCMd/2kXK5A95D3ykb+N9949UE6Gga+igeEmQc8MRbIBLdCXYLP0WtDUr4XSZ+XDEfRImvl7STUBcJ41Eq5q9BJ165ak4m1/nGyNwicZjLbsdcJbrVDN3FV6xlNWIdyq28ZLARPG+jmEzuLvuygIOttF56vJyHktIx29d1aY+FVwButNz5aY4hq336THTpI1M2Wn6ehYMnSrjDA2v+JoMwC0kVmIhKXRUHpNpZPiqmma2wX0H4nsZJPhDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYCQQ+yZEYPBQkQ27MRCz+zy54Q2H9EMSuYCF8BIJLs=;
 b=pEk6oy8XY5a/xrF60NIabr9w5cvFXsrkXva/pA6abluNhvW94u/FN6ZnHSFAe+wc34ixd8XUSHnmZSbQn7N4mDjITfYepdRIewUSSiIXt+fgv+qZCkU9j7U6nmhLOOdj5WBIhHwmSdubebMpQRi6NDDkxrEvBOZG4khc2VRsbRZR0w1WzlTxTkwjXPW6KWm63+0ysQPZhUxsI29FSf/oD1yPJ7EhAc7rI/nXD38qvYSR5FZWC4aNcZIxmQmbNcdz+yL2iuBsVZ99s5WAUiG+Y2N+zYixVfXh2YcTyalTaAlVF0/9wXwiWubBnZAiSHES20ab2six0dNNMId8xIh3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYCQQ+yZEYPBQkQ27MRCz+zy54Q2H9EMSuYCF8BIJLs=;
 b=D9LjarfAB+0rAJPWSo62sBu/C8rWnEVy8cs516j311wF5hW9I2FIF+oV5aCv33lOomP0znLyFZeRUwrX07fDR7P35hSLpFo/QQAdwC8cLK1j2I3KxBFKToAeaU1qWRnBr1J2WuKfAMZe3qHIfVGF2xZoRamU3ZmfgBTvlI8+f6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:12:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:12:26 +0000
Message-ID: <a15a2bde-6df0-4977-88bc-8b92aa0ef66e@amd.com>
Date: Tue, 31 Mar 2026 11:12:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0353.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d7ab25-073a-46fd-5911-08de8f05a0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X5BhRZZmAJn0ejWzyYhbi79CfTlHDoEbV43dPQINUq/PiUpX000M7SCwrTYpgnL5xwAArzS0mLlkOobZ/23BMQZNM2YBkidYbPgEs3dieG6mhlzRnF1eCGuR99Az5BPZrE3/cvqSxHH1NFf0B7TmhszpRYYG8YYC3m/F4MUHAgCk8SSZBFCsm2KdzPscGgWMm1UYUhqRw/812HwbYVlBHiSJ5n6qpSQXqngVc88+HVrxN2k0oao1a2fhVp1kD10zpUsUGFC49LSZY09fquhTNcV6NIyCUIVyg5oqefLt8UBf2HTJkpUFU6RGTCOxaV1jTm67FxrInCvIPAjiPC/R9788MFD3iY4eZUKTnq60Wi0kT1IiO5WVtx348+Iwpj0pub14Rp74tUV7EMu2Y2BUElmFd8eOMT4Ek69NoV6w8ZrA44ZDYsf6MXzkWq9GbnEyaSIELzbcASerT+p0ozECpe0N1L+IopTIFgutY1IS1Xso+K3JxuF55irAyKJ95mS3k5IdatXUa7UgFAs+Ij2kBqvNBUtExLDmZe23lCgQn5qL5ptj3J4F3Q3598gelmtnI+/F2TWZ8kTnawQWVyJFkm8Ca3sv7sTU26r/BJfZdlyPzHeFbuy+3bgckNg8Lt/FVKWGoztzbP9Zhbc0DwsLWDCuvpkS5AkkooOWFmyEZKjXqt8aZO95CXIHSDUyGRg9lLcYVqF1wvIhC2kHKEWBqQK92NJu+ccqSORJHlNJ+k3YV3us8isMPxk1asaxhZ2m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWhlRGE5WmVHSDg2RVJBa1J6a29aZnNISjFrTkViUENiVWczV0UyMzZmYUhn?=
 =?utf-8?B?dURvdXY4alpxY1UxVUVIdk45MHpoNlpNSE5LbmRwczBIWjdkRXcxMmxOYjMz?=
 =?utf-8?B?K1B6cVNLTERPYkZlTVRBTXlybGxJQW5kRGVGTERLUHJhSk9pNXk2TXJTVnZm?=
 =?utf-8?B?OEZHSEJTdjhKSVFldHZzVHNrbmZwczd4V0ZYWHM2RGtaQUwxS0VYRmIzRWxi?=
 =?utf-8?B?bHArTG10cnB4bVlaTGpSanUwM2t5R0xvQVR0ZjEzUUNBcmF4cHpmQnRNMDU5?=
 =?utf-8?B?WW1xb3crUzhvbWVkMzhiZ0VweExiM21PeUN3UDVXTENnLzZwUnBWQnNXRHh4?=
 =?utf-8?B?YVcvcTJVYmZKbXhsZGw4eFhrWVpLdmpDUkxsTFRJeGJ3eERFWjRmNFFGdFVk?=
 =?utf-8?B?cUtDamVtUW1DMWZFb0k2OFk1SzJmS1ZHM1BpRjlkYzFKVVlOQlhCWG1XNDFz?=
 =?utf-8?B?aGRZSHJJdmFTanF6VktWOFhTd2k0SC9sdjNmK01YcDRDUCtpb3FCRlBQRUhO?=
 =?utf-8?B?Z2E2THJBQ3dLUm9LYi8vQngxa0NRL0hSaVVuTmh5eEtwQm1PMHYzZWFaekdJ?=
 =?utf-8?B?TUxycXFHME5ycTVnektVV0IrOXNwSkI1L3dsbUxJbUZJVlQyTlV2RHJlbTY0?=
 =?utf-8?B?WW5NU0drNERsVktINnBWbDdLOTRKUlhGazIrT0NLK2ZHaUlxV3NtcGVyYnpj?=
 =?utf-8?B?YksyQ0tMMFRFUDExTU9CRVBHQnkxSTFPYXJUeEd6WTQ5UlF4UVBlMXFmRW5M?=
 =?utf-8?B?dFdBTGIxWUlIRWxhMFpkeElZWmUxdGl2bzBkb0xtVVpHZHM5QWJyb1JsbVRS?=
 =?utf-8?B?bkgrakRQemR1ams4d1lzYTdFb2pEUHV0elQ3eUd1SUZjR2lCaVdsR25kYy9J?=
 =?utf-8?B?KzhVUGhGdmViM1JTNk1kRU0ySDRVcUVDUXVQbkxNdkZtRW4yRWQycjluTGlF?=
 =?utf-8?B?YTJoRGwzUFJ4NTVzQjVKUVlxUUFjdktjRkhYSGhwYmcwSG9KWWZ3UzBrVzda?=
 =?utf-8?B?TVkrUGlScHd5dlFxaXVvUTNpRmNPWUdYYm52Vnl0Vjg0VU5WMHpicHc0N3lM?=
 =?utf-8?B?bDJRbjhQc0x0QVVwVzV6L01yaEEveFJkeFp4ZDgvbkVYemxVcjNpNFRvbmNl?=
 =?utf-8?B?WloxUDhNWWZWcFpKdWZBMVpwT0hNN2tZSVJISW40bWU2dUYrZnBpOUlZaTRV?=
 =?utf-8?B?R3dmUlVySjdEWWZlMjNmZTQ4RVJpM1FjV3gyOTlkQnNtVkR4ZEl6aGdKWExj?=
 =?utf-8?B?bFpjQVI1TGxnaXIyZ1RiUklTTEJyc1VKR29rVVNLVUdOTEZIVUZJdmVEVmps?=
 =?utf-8?B?eEhpa2d3YzBieVU5ZUlpMXZEcEY1eXd6elB6WVJKODlKUGhQTk9FcENXdFFQ?=
 =?utf-8?B?YXQ5Y3l2Q1JUUTArZ3h2S3FmYnlmMUNNdFp6c3VTalBPK1pQbElBTzR1REUv?=
 =?utf-8?B?MVcyNnJkNTVLdkR5RytMWlRVbGh6a0N2M0x3S0lwaVBEZW91WXlRTitxb0ZE?=
 =?utf-8?B?WWEwR1FTVWZFVnJLbTFMbkNoWmp6NGc2by9kSnlud3JEbGhzQys5NVhGZmNH?=
 =?utf-8?B?SWowVFJZWXkvUmRpdlVrRTRaUTVEMnZRdWExeE5BMmFzWlB5My9HNkYxUm9l?=
 =?utf-8?B?bU5DQnY2MHMyOE9CbjFaL2xRbXQvUTVxTlc4ZC9SczdWTzViaWJHVldHdldn?=
 =?utf-8?B?Z095MTdqVXJPVWxNaW5uZE9mWnI2MC81RnZoWXczbG11eWZrYlp2a1M2SUxv?=
 =?utf-8?B?azJ1akdaUENRd0FrQVdsck5uQ2RzQVVUSThFVE1vMlZvTFZ1TFpoREgvNXMw?=
 =?utf-8?B?aXpMV0VYTmxWWVl3YlYzR1VrMGxic3NSZWsyR3NUc3YzOXFZd0MxRXliQXIz?=
 =?utf-8?B?RWJZQ2pEUTF1TjFXK0ZLQTZFTGJKMWh3MzRXalZPZTZXU2Exb3lxOVYzQi9o?=
 =?utf-8?B?eExJQ0x6OVJiZEtZQXFVbjZhbzN2WWhPbElZTzBXazBNRERCczl6T28wMHpN?=
 =?utf-8?B?S0tXUnpiY1NMN3NFMlA0LyttZmQvTjlZeERjbzd0eU15ZCtlWmplZm1DUkVF?=
 =?utf-8?B?dXdIbnRiRk95eXV4aWNUWFkrWVptTkFuZkE1QnhaOXRwTFFYRy83QURmL0Ez?=
 =?utf-8?B?V2hYNXN0KzJjYVcwQjNGS042QUNKc3QwRXpNRFVoME5XV1JJam0vSDFCSzFJ?=
 =?utf-8?B?YTNVUUNtM3djRGp4QW9qY295WVRQTkdLSGRPYWxFcjc2YkY0V1BkdlNPNkVD?=
 =?utf-8?B?ckIyclNRUHpReTZheTFTdTRXNDM2MjZOL2tpUFpPbTNQdE1LVmMyRVpFSWRL?=
 =?utf-8?Q?cUnFj4V9beIsqSkrQ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d7ab25-073a-46fd-5911-08de8f05a0ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:12:26.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aobld693IwdtuWZynzhHLvnDzzObX9hQII6qfPz5ATb7NKYQxfWpOQq3+OEy17sa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-231365-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43041366F67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 21:11, Mikhail Gavrilov wrote:
> Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> converted the global PASID allocator from IDA to IDR with a spinlock
> for cyclic allocation, but introduced two locking bugs:
> 
> 1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
>    which can sleep.
> 
> 2) amdgpu_pasid_free() can be called from hardirq context via the
>    fence signal path (amdgpu_pasid_free_cb), but the lock is taken
>    with plain spin_lock() in process context, creating a potential
>    deadlock:
> 
>      CPU0
>      ----
>      spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>      <Interrupt>
>        spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> 
>    The hardirq call chain is:
> 
>      sdma_v6_0_process_trap_irq
>       -> amdgpu_fence_process
>        -> dma_fence_signal
>         -> drm_sched_job_done
>          -> dma_fence_signal
>           -> amdgpu_pasid_free_cb
>            -> amdgpu_pasid_free
> 
>    This was observed on an RX 7900 XTX when exiting a Vulkan game
>    running under Proton/Wine, which triggers the fence callback path
>    during VM teardown.
> 
> Replace the IDR + spinlock with XArray.  xa_alloc_cyclic() handles
> GFP_KERNEL pre-allocation and IRQ-safe locking internally, so it is
> used directly in amdgpu_pasid_alloc().  For amdgpu_pasid_free(), which
> can be called from hardirq context, use explicit xa_lock_irqsave()
> with __xa_erase() since xa_erase() only uses plain xa_lock() which
> is not IRQ-safe.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

> Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org

Please completely drop that. The patch was never released to any stable kernel.


> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
>     since xa_erase() only uses plain xa_lock() which is not safe from
>     hardirq context. Keep xa_alloc_cyclic() for amdgpu_pasid_alloc()
>     as it handles locking internally. (Lijo Lazar)
> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>     xa_lock_irqsave, as suggested by Lijo Lazar.
>     https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
> v3: Replace IDR with XArray instead of fixing the spinlock, as
>     suggested by Lijo Lazar.
>     https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>     lock inconsistency (spin_lock -> spin_lock_irqsave).
>     https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>     using idr_preload/GFP_NOWAIT.
>     https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 47 ++++++++++++-------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..3fbf631e67c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>   */
>  #include "amdgpu_ids.h"
>  
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>  #include <linux/dma-fence-array.h>
>  
>  
> @@ -35,13 +35,13 @@
>   * PASIDs are global address space identifiers that can be shared
>   * between the GPU, an IOMMU and the driver. VMs on different devices
>   * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using an XArray cyclic
> + * allocator (similar to kernel PID allocation) which naturally delays
> + * reuse. VMs are looked up from the PASID per amdgpu_device.
>   */
>  
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);


That needs to be DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1).

Zero is not a valid PASID and the IDs are freed from interrupt context.

> +static u32 amdgpu_pasid_xa_next;
>  
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
> @@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
>   * amdgpu_pasid_alloc - Allocate a PASID
>   * @bits: Maximum width of the PASID in bits, must be at least 1
>   *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> + * Uses XArray cyclic allocator for sequential allocation with wrap-around.
>   *
>   * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
>   */
>  int amdgpu_pasid_alloc(unsigned int bits)
>  {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>  
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>  
> -	if (pasid >= 0)
> +	if (r >= 0) {
>  		trace_amdgpu_pasid_allocated(pasid);
> +		return pasid;
> +	}
>  
> -	return pasid;
> +	return r;
>  }
>  
>  /**
> @@ -84,11 +85,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
>   */
>  void amdgpu_pasid_free(u32 pasid)
>  {
> +	unsigned long flags;
> +
>  	trace_amdgpu_pasid_freed(pasid);
>  
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);

That is incorrect mixing of irqsave and not irqsave locking.

Regards,
Christian.

>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -625,13 +628,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> - *
> - * Cleanup the IDR allocator.
> + * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
>   */
>  void amdgpu_pasid_mgr_cleanup(void)
>  {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>  }


