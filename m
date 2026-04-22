Return-Path: <stable+bounces-240376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWPC/UK6WkKTgIAu9opvQ
	(envelope-from <stable+bounces-240376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:52:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAB449739
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D45C3020A84
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50C39449C;
	Wed, 22 Apr 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MMD55uCl"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F82874FA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880369; cv=fail; b=hKwrt1f/j53GeS5gbXCpljGc9jwyDV/DrX65yX5sO223PO8tImgU0Gm84LVAbV6GzfC3Lxq26iuVXvLNhUSPaMbFb3OZyx0lOU2xTaIWPTDxhabaCIDYCG4almMFJeHD8aXtsBHw1EEP5vMvw+uB8jm3zJbXX/sUEMFY72QUfBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880369; c=relaxed/simple;
	bh=Ve+urMSfNyHBXpDkLyv8aCHkYg8skJXrksUbajE9sq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BaZC0xenKWmFUa7je7FeBU0a7qlgfYUX+otKRTc+vudVown8+1RNGzdGQxxMxMrLqeRbRHWV18bUlgCLSiOl4jYgvvExxHGGMklXJRXts/78/63WIsOEsqEe4Y8DtL8zzlbz96Lc6K0WZicVMQYM9GvpwufYkIGFWM9th8xlA/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MMD55uCl; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1e5sCsAo5BI0eAUoBcdLoeKYWDHFurlBB9gvCeuGiqZr23pUQBiuwROAF8ezl8xVRrY+3ahrYC1lzWCFBMkrduFnTDH4xUrF+kMZUJZqF99fTKGvKeN+5Zx4KPgTw/u0ouJJhLa1ZtiWgk/DUaMYiuEZkSMrSajAkzdqW2hjDp3uzHxudZDK/Xpull8a0z3et7RdqCL83J86lfEcaFGzM4LLXobAQIJNj48s1hmr2Lir2LJoURu8oeYck9ydHp/edxdDtg//ez8lJlB2fvtF4URRM3Q4StohHdScRB0f1EZfBCloRjQ7jRI93zLrIRzm3iTo4JmGylYH5BpGbd7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZGfTpjo+zzjF7Oo0vdDzN0iDJYwTBj+/CxjBGC7CTw=;
 b=PYMxdcnluHETYYPGyc+jyGsuooTFJKhphozlg5lYwLymVLWvcUZZo/hZ/ITfBvwLehx5p9vU0hM1t7oFW0lp0WWlBXuO1ykSJyjAyuOT5JYIRjAM5cLf7CGpQHChlwROglPnmAhyGJ5A0DgHcUp2yj7l+xCJvkIxXMcSMQGAuwMNYBSIbDJBmTIZSmJlYGvKTJRuU0etseppFwxRFW4MjbBM+4Xlqn/iRkji4pIIYtiVUlZkummX5wxIdF8X1X6O83QUXnLZIUhB12Ojd9dwN2DUCIDel8bcq+1CNgCkhehsNuFzNPmTUKt+1GDkxdE9A63oKEYK6RzTzmOcpxDFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZGfTpjo+zzjF7Oo0vdDzN0iDJYwTBj+/CxjBGC7CTw=;
 b=MMD55uCltUlHvEDRKN76M2uGE5zzrPyZLtmAS/9si5eczMC/HmcXErbKJ308Lostnbi8gbpNilb0a7G5W4vacRVqq/hEmVhlyDApZ3qAxQsCuD/V7J04yyQ/OZZAlVF2nway5XWQEA/u92/d8ErqXhUko0NJNc6wt7x/4tpsD2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 17:52:45 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 17:52:45 +0000
Message-ID: <030dffeb-34de-40d4-8f0a-111ab356e842@amd.com>
Date: Wed, 22 Apr 2026 12:52:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
Content-Language: en-US
To: Michele Palazzi <sysdadmin@m1k.cloud>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com,
 Aurabindo.Pillai@amd.com, wiagn233@outlook.com, stable@vger.kernel.org
References: <20260422162956.620362-1-sunpeng.li@amd.com>
 <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
 <5b0ea1b1-40be-4941-b4cc-521a9fca8c09@amd.com>
 <78ef350e-b425-489d-8fd8-23df8a652e1a@amd.com>
 <cc5aad8a-e69c-42ab-a36f-15770b1038a1@m1k.cloud>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cc5aad8a-e69c-42ab-a36f-15770b1038a1@m1k.cloud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::12) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f893d55-56ec-4f85-7a98-08dea097f54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	phCfqGVFqp/bxqgt43F+p94ceGyWA5dOaMK6srPDl1qN6/xQtWOybwKQK7rbxzk8Naf9Jr8WL31gMPk94C9/bZMdYMxTuzq6K0adtX4Nx0vtfsWmZI81y/dLiYi8/XpZN+x0z67uRGgMWI1EKu14kYyUkxlPJAwvo3VS+cP4oRQfnq3iHiYLgrqBn7Zn3r/Y/GBt0kNZepU/xEXd7AXdJonZ4CH1fu5+tF8E2PwzR3eAK5+YJdUdcIH8ZDY3le8Ouc429DxCw6WHOo4mgtHCQ+ZpEkl7LVCeiCjmeuHuYbj511faOFIdMRZUCAKbcC85I5N+ObT+HyCepn79w0eCw0CknZOZOmlzkAm/uFbo/r3TbX5ovEtaVQQfEG7zq9t6R/joPkSnNQtW/nw8h7yGfVTL71kIMM8gljWMcrJ40vp+EwKD56qyKkhnsObR7NMzsWMl3Ll/QAcjeTTDN10oI6HYO/XxGc4VqK8B+9jBRTgzIY7Bg+iSobkb2NvjyzRcsEI1/OEgmurko2GPCtO79VUrfQV0j8P7vW5YTS0/NLBg1e3bbA8vmSFiH9ADITdFqqmFw1SqQeIrZFa8x9NzhzjQw7Uzv3iJGvGf3DPdvfDEsjguEdyhx3qr2YBA7g84jX1+A9wYKMl+WPJB6RRVpz8uGc73pC4jMDr4Ctm46LTQH/TTBLhA+UGH8mhU8s/gZorovOHo+goB43PNyi3WrnFjafwauRcxgaH8OBZVMqhqBPWdpXYlAnepo4FB4bQj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRtaU0ranU0L0NZSFRMTUNIS2dKK1FYaXNVeTJqbTFxeEIrY0FJaXRrRzg1?=
 =?utf-8?B?SytNSzlnYkRnMkU4Yi81ZGlYcVlrTjl2Sk0zTkxvbENXRHpFRnB4R3lSZ1cx?=
 =?utf-8?B?REdMZWZ3anQyNFBXVlJYRXN5Qkdxd2ZaVmVqSldZd1NFUE5vcEpqUUZHN0tP?=
 =?utf-8?B?b2kzcklHTDh6OXdoaGJneUdqRFJKaEgxTm9RbmJXaW53Rjk5YzRwSmdvZWFG?=
 =?utf-8?B?MnE4RzNMT1d2RFozd25oN3p0djFrMmw0YWU3aVNLY2pTMDgvSXZFNFhwMzEz?=
 =?utf-8?B?cHIyNGNLR0drRzVldjczZG1waWRWdVdnOG41MFJCZGsxUHlOMWRWMStVdFBh?=
 =?utf-8?B?N3phNlQvNTJIZkF4WXplN1NSVitvTis4b1p4YWNTempXUGRJdVVjZTFTVmxa?=
 =?utf-8?B?bFA3ekpxYzd0Z3dBd01TcXZXRXNjTnpBUE9ZT1JHcC9IVjR4OHZoaGlWdGMz?=
 =?utf-8?B?NTF1b0VXOXhLd2Y5cDhkMEwxMDRhRWQ0QkRHMFk2WnJRbnl6dDZpeG80cXl1?=
 =?utf-8?B?Ui9vSmh3ZHRjRUpSekJjVVZyeXpsUzFuWFRZZlVTU2xwclN6V2dEekxhK1dn?=
 =?utf-8?B?TWRJT2k1VVRDaDBpZHpkNVZxMGlmZlpaQ1pmai9ldW45VlUvdHZsTitrY3Y4?=
 =?utf-8?B?bXJaWXdXNE41M01qNll1WlUrbXRFMWhKQ3FBQkdEQ1RiTWNjV1BTTy9xQ1RF?=
 =?utf-8?B?UjlOeWxBMGIrNGRkUjd2cHY4b3NFc01mdWdnSVRqNXo5WVpVNjNCTzIvaHVx?=
 =?utf-8?B?d0RscEdDcDRoWXk2dWZDWXduSFRValh0QnhwVHFJRFc0bmJPTU90SVVjc3Fm?=
 =?utf-8?B?bjNTMURRTGFIWVpOL1dCM3R0dTJNbnJYaERMTkQxMFlPTXk2TS9CZDYvdS93?=
 =?utf-8?B?QkdQNzVoVklMekw1UGZtdFNROUI2ZTU0WTRobnFpOWVUQkIyMEpUbWZhaG9q?=
 =?utf-8?B?RDVvR0dkM1R2UmdBbFFyVlpKY2dSalhFREZ0bERPanJma3dkK1MwMkJaYWZ0?=
 =?utf-8?B?MFFCdklGVWROT1lqT0JaSjc1aVJhV0Z0dkY0K0pvZ0dLTUw5UFVKbmdHT1gv?=
 =?utf-8?B?SUlic0xoa2RpeUJQVlRjcVBLREFKNmVJQXdhaTJkR3lMaXcyNWJldk9jWE85?=
 =?utf-8?B?MDd5Z3FWMk8wQUgxbHh4RDVwTWlQZG1ZbEJtaUNsTDJjbWt1Z0UvQ0VhVHl5?=
 =?utf-8?B?SXI4RjQvdXBQQmpLQnhVSEluT0NlbTR1N2E0OEhodnFRWHRiYnJNTjdSUFNF?=
 =?utf-8?B?NDhvelhhWjlzQU1xbkxwRVVwQWt1c2xtNXdCZk1JMW9nRmw0MWFxS0grKzVj?=
 =?utf-8?B?d0FnSUdZQTkvbGk5amZqWGkxS2dqUjBzT1JuQVpSaVFqb3BrMCtubXd2SDhy?=
 =?utf-8?B?NTQ5U29ReHQyQjB4UnZQakpBVVJVcU5qNGRMbG9MM1dUeitSVEg1UWUrL2Vv?=
 =?utf-8?B?MUY3cEI4Z1VxVTZFQmxjS2dGUHF0RjZNYnh1S3ZUUUgxOEhkTHJxbTZlSXQw?=
 =?utf-8?B?OHByOEtReUJWSDRMMFVveEtRc3lWN0d3VU0zZkFQSmEvRHcyVHcrWnhkNVVt?=
 =?utf-8?B?ZWVDbFExWHVscVkrZVNWc28rY05HNWQwRWJoelpudGNSdkNESGVlWmZKZVlr?=
 =?utf-8?B?NTM0S3g5ZllINHNaOHBVc0RVZThTZE9Pa0o4dmZTM0Q4YzV0T2FhaHZEZU9P?=
 =?utf-8?B?b29qVERVbFFwaWtKaC96WXhUUTVpQStDMGRkM0dzNjZhYXJ0ZUttUkxwWTR3?=
 =?utf-8?B?U3FtcG9wTUFKaEIzaGNIRGV0SWtNZ3BWdGdHaWV5RjJSSVp3cjhYbHdIa0t5?=
 =?utf-8?B?VEFrLzlDTkpCMUZ5SFkraUZzblZFMzRCSTRNaXlPbnd3UFNvWEdGR0pCRDZJ?=
 =?utf-8?B?TG9IYmxPbFAzT1dZc2ROZGJWeGdxd1dLU3BuRFJGVDg5cGU2cGYzN3c2VXM3?=
 =?utf-8?B?SEhaR3FQS2s2bVk3Mk5vdHNEKy90L2ViR1FrUFQ4eGZBL2FFcFh6UFBRdXNX?=
 =?utf-8?B?U21VVDN3aEw2M3UvQ25aVmc0U1dGaHFSc0JsRlVLRWRqODVHSDFvZlFMK3ZS?=
 =?utf-8?B?Y0F4clN3MEJTaEFqSlA2blhwRG1qZXN1QldlUWJ3bVRzSTlpRWxOblZkS0JM?=
 =?utf-8?B?cG9YcWpKL0twQVdrTWJVc3EwN1h6Q3JQNDd0SDdRYUYrS1BVQUdDZzkrclNa?=
 =?utf-8?B?TmRQYk5iWXNYVUo0d2w4TGh2c1lDZ2ZhaFVBc0E5Sjh5ZU0zYyszUXR1RkpB?=
 =?utf-8?B?dVMwNEtocU5VZmg1TGFoemFzZ3Jtak5kekh4dWJrSVB2VmpKUHRkRWJkQVAr?=
 =?utf-8?B?cmw4YktncDgwb2ZSNFhpMk9Ld00vclZxQzF2d29GaHVTMlZjZ1F2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f893d55-56ec-4f85-7a98-08dea097f54f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:52:45.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvFRGSX3zxI+1Jn1Lyah6RHF/mA/Xcl3NYcJ0GGVAeG6SU3FBeWkzXVbXRyrs77Cq1LVwHzH25N16M1BKstzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,outlook.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240376-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[m1k.cloud,amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,m1k.cloud:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82AAB449739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/26 12:50, Michele Palazzi wrote:
> On 4/22/26 19:42, Mario Limonciello wrote:
>>
>> In Michele's proposal (https://lore.kernel.org/amd- 
>> gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/) there was a mention 
>> that it was tested on DCN 3.5 too, which made me think that the exact 
>> same issue was on both.
>>
>> Michele - can you readily reproduce the page flip timeout on DCN 3.5?
>>
>> If so; could you modify Leo's patch to drop the IS_APU designation and 
>> see if it happens to be the same solution?
>>
>>>
>>>>
>>>>> +                       /*
>>>>> +                        * DGPUs NV3x and newer that support idle 
>>>>> optimizations
>>>>> +                        * experience intermittent flip-done 
>>>>> timeouts on cursor
>>>>> +                        * updates. Restore 5s offdelay behavior 
>>>>> for now.
>>>>> +                        *
>>>>> +                        * Discussion on the issue:
>>>>> +                        * https://lore.kernel.org/amd- 
>>>>> gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>>>> +                        */
>>>>> +                       config.offdelay_ms = 5000;
>>>>> +                       config.disable_immediate = false;
>>>>> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>>>> +                            IP_VERSION(3, 5, 0)) {
>>>>>                          /*
>>>>>                           * Older HW and DGPU have issues with 
>>>>> instant off;
>>>>>                           * use a 2 frame offdelay.
>>>>> -- 
>>>>> 2.53.0
>>>>>
>>>
>>
> 
> Hi Mario, i had tested my proposed patch on multiple APUs in order to 
> exclude regressions or side effects, but personally i only ever 
> encountered this particular issue on dGPUs, specifically a 7900 GRE 
> first and a 9070XT later.
> 

Got it - thanks for clarifying and reaffirming Leo's assertion was 
correct on root cause.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

