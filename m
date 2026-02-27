Return-Path: <stable+bounces-219981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJoLNpm9oWmswAQAu9opvQ
	(envelope-from <stable+bounces-219981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:51:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF01BA504
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3716030474D4
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4D4418C4;
	Fri, 27 Feb 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fBZkEMgj"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022107.outbound.protection.outlook.com [52.101.101.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2A44105E;
	Fri, 27 Feb 2026 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207285; cv=fail; b=sHmTuUf+uOl6LNt6y1zhXqAaEpgEp6cBbnTfbvK16phRDVSIEWZpZDwKgAJSxlwh8fGsGY+N2SBWCllqlF1uEOcYEwaigNLYb+JNbTPHIwpVbs3qOSzAD6FXBpS38/PZ4EhK+W2a+qF3iZ3ggqYzjSkTHUlXy3AKqojyoVbBefg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207285; c=relaxed/simple;
	bh=BgijX0efD4WFR8aVR06LTSyBv9Ac80Q+P5mSoEOkklQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=U89lA3Ue0W6tocpZEmUgSlPAQgRf1afz1tO4WDC63f7qJSg9RBNV/7PKrgnYD8SuZkFtn8y8raZixVs2pUWtZ3Zp+abtIPG1k2Tz6+qbPULw9gdTxIQaecGG/0ZlqDS6WDG9ktOMfyUa8o05zoZ0Hlv8TiDFdPR7W53iQSUTj7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fBZkEMgj; arc=fail smtp.client-ip=52.101.101.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB0BHRU52Z2ozZuHSotoN0dORYaVXcer/tgsg6waY5AQ0OFeIe2vaaHXdaFi8OmiXlkdgo6GdW/9o4Z0EDZn8bKzXt9JOh5CBCf4GJF4VzdiAK6+sL1X2+hE77SArLAEPD1MH53/sFetzHLj96ZKJ3YKzu80srrN0ZXoBkC8nBG/zitZCXrKkZByfQCfmrUnsABwGzJAlTUEtnoxLQBU59ozaMo0sNjyBoMrhAwvUUV8FI3hivi8s2RpWATqXt4xii0S2QFpKh8c2MG2NyzFo84743pjlGrrC0yQv7z73Dd365iQ9ypANyFYXLBUU8Fakx6uiT9QvEK8QLtk/LJicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViyiP40OApX6TX31qUrHX0PZOkqey2eT1LN4Pz6bD3A=;
 b=YzKTHLgaOqpVsfJdOwtPghbZrghD25oQPDXd6S3QxBc9TRhM7sAvWv52iZJCtCUJiO727rA2ONrRC8ZMdHAX609GgdD0dLY7uVnS0JUzXw3kEAAlYJ0Enol4O4yGokL2NNgudHCwuPvembhl3jYwyMpPHIhpSHkrUhZRcbVU941xtJPA2CzV3Jz74rk6JPY4Czi3aym1Im0G/zGBH/NH34fVxAGgFEnJRberQLA6gEdtfrNeJJgZeb/GShzGTwDy6U97NKgwKVBT2m+SIY1hiPgnz7Eirhg+erwJeUdT0MD+Y/7omMmLAkWVYXjY1XJ7CzfJ3SOvSGuKFO0U9lPc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViyiP40OApX6TX31qUrHX0PZOkqey2eT1LN4Pz6bD3A=;
 b=fBZkEMgj97s3e3qfxJY+8NvJg0GEbK9Q4HybO85WbejkavqNjQ6Fer0pdaXTLAb0zW4cUSMVEIwI7FIs06+91G5GrN99XeUch7/i4V86OSli0WqaJePO2Kbo8fYmOPOQ5QuuOGn8VBx0KNHqUGOIru8ImE9wWFqaJA3ovgzF40c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7954.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 15:47:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 15:47:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 15:47:58 +0000
Message-Id: <DGPV1SDV37VY.YHX4HNVAAXPH@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Tejun Heo" <tj@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Lai Jiangshan" <jiangshanlai@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Philipp Stanner" <phasta@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, "Tamir Duberstein" <tamird@kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global
 wqs
X-Mailer: aerc 0.21.0
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com>
In-Reply-To: <20260227-create-workqueue-v3-1-87de133f7849@google.com>
X-ClientProxiedBy: LO2P265CA0393.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 10966c81-9b71-4115-9104-08de7617951b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	CCifrdzrt4nh2n/i/pkA8Gt4jNPScBtwinjjuJ2+ryFD6OoU7YPNHVGLfwcgue31rfsbHiEyTEhLVy39pSP49xfIONw+GqJYUCJW5f1C5tCFApOwC6f4Dbfk9RHyVKDzqL1Sa+S4omPqTlrTEQyxbZ8deVDmsP/1G/L25a3pdOW4vhXiVByTSB3q/obW0G31rs6lxOvwVSI0XV0UxCKyZ1VBy/bAeFaZeULOI+H9kWqPFjp3O68OX3Vuu78ODvSMi1EtTxgSNsU3sdrJ8HH3Y1Iz52/uqbL+XfjbSwbjd9x23fvoOi+5WxP1iywgls5bTKhWM+7Hw9H4FSrUW2hnixpq4ZpVLcmKtc2zNMvrRiv59UglU/m/KS2Azc1snXqcZ/n3yEYyUHiPkJ6X5FiRrJ1CB2xS/WbfxfR/BZc7tNkDvNOSH0tgwWPoJ/qXEQer7mwhdkoTqYUif5SVHi+ETyPfhJOGo8LJ8B2/Y57Pr44xoNN14tFpd32ad64ESMIhpiyiWYDCVOi7eVEHek02HwBm5MEyTRHREQKgC5MjFp0YtD/wTIuLZB8qYO+/qRsk12dQHcVj4U9TozaMwXJ5MhkcSUqO4Wbe3wsfhpybR/3U8F6pUteTSUrUNX+rmq81LMUUKC+g9FeOgTkB6Gw3AYb8nGsGZVfUiruWBjGQ5oCH8SkUBIdyyvgqtDvj8tykpkd65ViGBHCh3EMvYjfW/5CXgpsHN/u24pKfiTVGAt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjBrR3VkenBuNjMwdjE4RkVFdHYyNlZUNTV3cEE1VGcrdENqajVGbUFWSFli?=
 =?utf-8?B?WmFvSFQ2KzZBem44K1ptZHFjZXQyRkxpQzA4cXgxbkxnT0ZoL1oranlMblBW?=
 =?utf-8?B?SmRFOGkrcTJvK1dOb0N4eUJGQ05pY2pUTzFTSUdTc2ZrNzRaTTNRSCsyNTZE?=
 =?utf-8?B?d1U2UVYvSGxSbjFORkFNUHVKSCt0eEg3b2JnVWJJNHUxcW4xaGhyeUQ0UTlN?=
 =?utf-8?B?Uk9DY3drOU5nd291blNqQWQra0xmMGNndjRROGJPT3VFdk5kV2hZVnljNC9h?=
 =?utf-8?B?VDFHeFFUSHJ3S2h2MDhQYUhlQ01mb2hpNVNBYW5lSXhZSG5uQ3JRbVMvZzRn?=
 =?utf-8?B?dFc0Y2M4MENSaEYzLzBhcXFKcS80SE02dnhmRWtGZlN3c2JVZTc3bFZPVHVU?=
 =?utf-8?B?SElDMTZwc1FJdUl1KzlhOWl1ekorODA0eUZFSnpMb0dTM3czZkY2Y1QrOHBY?=
 =?utf-8?B?TlVvS1p5QXlJVUpVb3hNdVVnSGh3WkxGZWNEOHR2NTFFZlFnbUJVWm9GRGFV?=
 =?utf-8?B?U2xXK0FCTHE3OXpHaStmR09tWjY3cUNxNGhpYVdWaTUrcHdOUDFTdUkrLy9j?=
 =?utf-8?B?THp5UUp5cHFWY0dpdU8yTnBZZ0ltQXJBSllLOTFmcWxQWGJnYVVBVndveHdZ?=
 =?utf-8?B?aUxKbXdCK3FMRFpYRDJwWEhJcWlQTzZodVdYZTVYOUdVSXErOTRLcHJ3OXR0?=
 =?utf-8?B?QnNNbStmdGN6TDREOWVJMWZTNUQxUlZjVWc3SDRWQ1VkYXBWeXVlZnQyUHNu?=
 =?utf-8?B?WDY2c1JYb3ZBZDRnOGNoRWk1ZHVaZDJrVWhWU0FqejZOMEVjR3lzNWtPRU9G?=
 =?utf-8?B?RUpPV1RnaHkxNk5YdW9mM25STlVGZkE0ZEdxamp5RGt3ZlpIMlZBQkdoTURZ?=
 =?utf-8?B?YVhHbjFqVkpGNVAvVUxnYWNnNjNPN2wwa1A4SkVVTXRhd3IrUFZ4dHI3SGUx?=
 =?utf-8?B?QVhEd2Rtdm4vcGlDSXFJcGdNYlZBaW9aM0VuMmR5VzF0SDhNNHJMU0NsdDlw?=
 =?utf-8?B?c3J1MkFnZ3BORk5kM2JiNzRJc2d4Q0trMG5PcTlBT2d4dXI1Z0ozc2Q2cmFR?=
 =?utf-8?B?WVk1ZTJ0Zk9PL2psZ253M0ZJbFZHdzVwNVZDQVNRTUZ1RFFndVI5WHYvY1VJ?=
 =?utf-8?B?OEZ1eml3MUVSVVg3QkNNQ1dIUlZuYW8wUWhjcTJWbHdVZDhoL0w0NEhxbGdW?=
 =?utf-8?B?MXRWZzA3Z2RCL2psZVo3RWVNbGZIREo2QmZoUksyWTcyVUJqbGxLVFN3THhD?=
 =?utf-8?B?bVhwcEswNUowTjJ0ZGlFTHkrMkw2WC9SajJWc0djM2l6emlXdUw4Q2J1MklQ?=
 =?utf-8?B?YmZqaVVMRTIyZmRlalk5VUlGUnFYeksxVFVpdThOZjNSb3l1S0tYeGt0MlJQ?=
 =?utf-8?B?a1RWUytMSTZwNWFoUEx1eHFWbTYyUnNrMGZQWkZDL09INm1QckUrYTg2UXE2?=
 =?utf-8?B?M094YXdaY3NFOGZNZ0hQT2EzOWF0L3hRVWZGNUh5VXdHLytldHp1aHFOUmVy?=
 =?utf-8?B?ZUdSUTVvSEU3YkhoZEU2cUduclY5bC84cWx6YkVmdVRMLy9CZDFPaDROT2Zw?=
 =?utf-8?B?YUtTaDhNK1hacmxILzZuMXhtZVFPYXovSE1YVmFndlgzY3hVb0Z0VUlWdVFv?=
 =?utf-8?B?MU1vSHFCNUVkZE40bW1hcU1sZ2VpaUxmMlBmZWdVbDd0SXdLdnhEdUlUbzdj?=
 =?utf-8?B?KzlhdUhtTFlGNnFSR0N3Vk9FQkpXZlUzd1dHdjNiRGRmVFJVZFZsTERKOGtw?=
 =?utf-8?B?eU4vWnFSS25DRnVTNE9RMU5laGVrRUl5R0NDeUdlUndMWHh3STRkaS9mdEQ1?=
 =?utf-8?B?cUV3b05xVS9RdFRCN3EzTzc0QmlEMWc3VGc1bjNZeFZiUGdJYzVOQldlR3VV?=
 =?utf-8?B?VjkvSm1xVzQyUjJiN0E1NG9jR2hvcjZGeEFSaWdRWC9lS0hoOStzSDA5MDZQ?=
 =?utf-8?B?aTZTemdpZ1p3Z3o1VHAzRHdKTDZrcXQxbzFrRjF5UGQ0K0VkaHEwMTRrei8w?=
 =?utf-8?B?SjRsaE5aYmt5akFYQmZUWGdHb2tOV1hzWkI0RU1mczV0YWRwVWNxVEg3TUw3?=
 =?utf-8?B?Q0lxbUpTY0RwOGM5UjFZeHljaVJmaTgySjhxVmxMQVlta3c4WTcyZEREZDhq?=
 =?utf-8?B?cng4d3lwbUtjNUpiUjBOUFlDbnBKU0dZSXhUcmtLa0wyUGp4NkFJTE5uM2h5?=
 =?utf-8?B?Z2lXY1pDSGgyVWhWUUlweXZRdXR0Y1FmcWZDa1ZvQ01kMUNrQTBXckhQZTJm?=
 =?utf-8?B?cVlYbDA1TFlIWjZxSFJycFRocW5ldWxWbWNxc1ZqdThDdFh3RExBNFFQYy95?=
 =?utf-8?B?VC9oN2R2WXQxbTVocUZQOFY5bUZYSyt1VzZrTEdZcDlPaVd2YThOQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 10966c81-9b71-4115-9104-08de7617951b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:47:59.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA1WS5IypVc2ATEek/TXGJyM64KX52MPhozS1DnO1ntN2ALO7HpVGMmriGCA/TEXqMcXfxjpIfvm+ogrNGOmsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7954
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-219981-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,garyguo.net:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BFF01BA504
X-Rspamd-Action: no action

On Fri Feb 27, 2026 at 2:53 PM GMT, Alice Ryhl wrote:
> When a workqueue is shut down, delayed work that is pending but not
> scheduled does not get properly cleaned up, so it's not safe to use
> `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> restricted `enqueue_delayed` to static queues.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7c098cd5eaae ("workqueue: rust: add delayed work items")
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/workqueue.rs | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)


