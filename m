Return-Path: <stable+bounces-240509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB4cISAy6mkCwwIAu9opvQ
	(envelope-from <stable+bounces-240509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:52:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA5453E6C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18D093059CDF
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450E347BA5;
	Thu, 23 Apr 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EHnxZyiI"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A033120A;
	Thu, 23 Apr 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955924; cv=fail; b=S/YwpfHTQcQz/5pefhKTAWdM7LKEXJesreIKK4NY+Dy5HRF/RE49+ih5m1QWjve/FkUH4+RDcmnlV2KUw5EtvxY2aIl/52+ChOjWrDBmdcSaF5Vxl6YOkaH69ATva6QdsAV66HEpWTRUHzk3/eyaOgPVtJ62leGgiraHdSRELjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955924; c=relaxed/simple;
	bh=lE9MH9XNl72OP5jO9FeJl02P4hqFNG7a0bdbPPpA1F4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BwXrBgZLzhDLDyzCizstx2Ax5/KBNzRIgBU2ZDoi3gHSWGvHp4hkiT4kruXovlE67sVuRXIbDofAgDWsy+A8BWwZUn9UtZHRnY8ZtIQg1TEmuV09MCbeipfBhC7296kWLqvbIsl8m9Y34qMcnpF/tcgOk2zMLefrbdvbee0TOyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EHnxZyiI; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4l2O0xDUqQLv1Wkc1DiNRtEtQOkMe5vuaWHMHVQCLFI4mpKc7WXN7m6pDyCsexFvVUZZRCIRwjyjoK5nsWOBI/nLOB0sSncU+302dyTg/2RxgQ9JyogIZaj526f2TOUbVs7GblDr2oxiOXCpFO8JVvtc7urA0O7qxhNEUDSaxtzyD1Pft0V1v+GFtGR1+Wvqc8nbVs5+zsYNFtta+hVz9WzA3csmxKh7kFuK1nHQbO141zW22VC59otO1r69Md4uT+cXIKPBdRnzb5soea61gay3gLyuJ5ZIqP+FQSoVL5bbqp6q5LTyPQeqHMY+gBakdfrrjl8O1pl6Pdj9U5/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm9isAD9Im96GPGZucluZt1ESMQJTo+v9qKWpOptXyM=;
 b=I/gJG63LUeBPhuU7+NEqwrfJUrhWPqvGmsWD/sZdAThx+k1SpGddRWyuylYPoLMHJIu0mrvC51RjLmOLF3gER6oHWqNt8HhDSsdOthANfISrQQH+tx2eIl0yQKI1ZO/dDA/8m5PR2DWQaE+2f3PVzKIr6lu5OUpZkfh+W6tXzrL0UcHRYJesNze0sdnhRSJ17kylefBYtIAUA8a+w6aY3eKtB3j4pSW5MBU2dTtmEUHMpu3K3Wr8DnCMCM1reltdfPJ/Ie84RsSyjDpcL23cHK7wgtjyHcqmaJl4Ii94Hv70OGPPSRAXrgIBk1KzZYRdXV8Emjn8Z0Ew03gUCduWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm9isAD9Im96GPGZucluZt1ESMQJTo+v9qKWpOptXyM=;
 b=EHnxZyiIAbzMCZSAGygSN1BCWeVY0Xk1s14dGflLOgu91JLIfArF4b9P0td23me09r2Y1u0eKCtIH6ksA3p8IVeXyViEghFtsXIzOzE1GzhPabpo9MQUezYgLk8l9+zOz9FZeHu4Id/+3a6dpbPGc6NUYLrrVkvO1IIfbvSWfaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CW1P265MB8468.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 14:51:57 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 14:51:56 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 23 Apr 2026 15:51:49 +0100
Subject: [PATCH v2 1/2] rust: pin-init: internal: move alignment check to
 `make_field_check`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-pin-init-fix-v2-1-ee3081093a0e@garyguo.net>
References: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
In-Reply-To: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
To: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776955915; l=5473;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=lE9MH9XNl72OP5jO9FeJl02P4hqFNG7a0bdbPPpA1F4=;
 b=XTPI6kN4xAC1qpNNrmtwXBkwRj9PWtXZtl8JW67fiNZnIG/13Cc3gbE4ul4PRkvY+uw9hdn27
 AzlG1Mj/d70DJRJdKe6T/mQXlkEBA1qYwDpy+R0tW0wim1iWhOIX9FY
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CW1P265MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: b865dd44-7653-47d6-7626-08dea147dd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ObageKMcyHlr7HwoRL6LLRkOIv/5k6lolMHycIyo3oA7c0vOzkv9QBGbTgoBMhlPZQ03QGvPYetPA8gUkx52HjrQJXwbSnOFDPhkX3xYUQKuseFRPNjVKJfffJvJsDHIVcaGZDb6aFL9Goq58v85iCdTQKD2th6axj2+8B6+tto7dDuu6sjk+QOIYiXryDgrJKMrYS8Luh5Z8zY+bdOcXBaR33kjR5HlQ8G8gY1b0aAXuPwacFU8eAxLeHA468Q6xhUfK1XBpNBX2geHh2YkBhKGP9wsawKRwtKvrsdgeXyAMuWzYkziytqqS7U2Lxa4j3TNq9JkRzhOq64ecp2KyhopfNUJCtMI3mcCr9sWK/6+/9uLG9byfCMN1x2hza0yxZkggNHet1uxAZK9T6UsgcPaA9y3YqCMmz8Qj5IovdpD117qnSJVTGUMiyTD5CQRAVGQB9EjKkhBDCW18w0iStk7dqk6xtRCfj0CeHxtERSObMnk28o0NYpzoK8Cca4K8NydI+A15veLK+P16yKYDtjoETLJj4T/AFpL9CotbAA5UiNxLjTAX1XQcQKfw0EuquGV76vJP8dZR141+uMlZdPNHBqW3qywL+4+HaNexww987dhaibz0X1upV0f8U0muWmD147Dkr+HiEyd4Eyp8hYgCvqK7xPDdeP7Fd2Wamp82biPXY3eOmGAVkKMu9y3L9JA0OJ6JxoBgeD2QoZ8SxK8cALyvtbmSRO/5CBpE9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFZVlRiL0VHVzZtdXV2Z3VMQjBhdGdPVnlLNC9nNjU5L0FSaEpIcWlHNlF6?=
 =?utf-8?B?dHBYVWlhVXliK3Z1Z25CSnJMWmo5eVVuc3c3S2JIcjFMQWVueldzWGs0R3BB?=
 =?utf-8?B?OVRjN1NMRjRSZW1iOW9RMFR2dFRVc2I5STdQNGpCMm00dmJMRTBlRkQ5VEN0?=
 =?utf-8?B?cFVkcG44T2VzYWZNRk5rSU5CVjg5RHc2QldJNzAzKy9MOHZGMEVBNkFWbVUx?=
 =?utf-8?B?L1BzZXJ5RWZxZk0xeWlLeUxvaE5rczJ6T0FNQUZVZjdlb1A2bHRwMjFKSmMz?=
 =?utf-8?B?TGlVRkFKZlV1ODR5UFpnZUR5V1RLRHJPL05jT1duZVlRTFcwZjZqRjRhL3dH?=
 =?utf-8?B?NUVJa0c4RDh4VW9LTFFPNUhoZWJDQ1FMR3Q1YmEyTXozc0RKZWp1OFdRUmcx?=
 =?utf-8?B?OTdrcDNNMERaTG9PbUI4bmR5LzBHb1RxZkx3cm9adGliRXRtcVR3dVhaRkFO?=
 =?utf-8?B?VDBESDRQRHB6Y3dZY05jNGZVRmtHUkRFbFpBQ213Z2JHM3d0QlVHWnUrcEs4?=
 =?utf-8?B?K3VYSElqc0UvbUovU2hkb20rRDNDUlVlK1FOcTZJa2JOTS9JTDJBWmdKWlBI?=
 =?utf-8?B?UEwvVVA3eEt2YXhRMS9naDZMamlVdWtRYllGVG5Xc09vRVJaaDE3QTRNSnla?=
 =?utf-8?B?TGVtOGVNQWZaQ1BvZ0Fxbm81OUxCQmhia3hUOEJvZnFMdEN3QXlnbWZEZlR2?=
 =?utf-8?B?cWIwL1YrL0JEUFdwbk84aDZTVlVodGpRNXNzYk40Wm5JSzlGZFhqSzNFYmhY?=
 =?utf-8?B?SjBheHkwZG5NVWRzdFozRXFVT3p2OFYwbzlGWWRhRFQxeTI1UldxQlhUdzM2?=
 =?utf-8?B?bUV4M1J5YkloaUhWRzFreUtxc21VMlB4MC80dGd0TlV6NUp0Z1NrVjRtbTE4?=
 =?utf-8?B?SldxVUI3YkVqZVJ1VVdVRDEzUWVpUWVBTGRCcXZZTElqdnIySUpFNHZmNG9J?=
 =?utf-8?B?TVFseWwwTktxS0hNNzA2M2lGT0VYUVl1QzFQcW5PTnpRSmw2STNrNW55dGxj?=
 =?utf-8?B?NnR2MmZKRk1yekRaUXhWQnRZVG03aGN0UzdYbDlicFNSTWNOUmw2aUNFUTU5?=
 =?utf-8?B?dHNFZGJMOTdUQS9wVjNqdDJCdEJqRFgzYjFPYk56N3EycGsydDgyV3kyQ1Q3?=
 =?utf-8?B?eVF5eFM1TEN5SUFCY3FIMkJlRGNtVTFBUVpLSzJWU212OGtmRHRrQ3YzOVZC?=
 =?utf-8?B?OWt1dVI1WVZOd055T0FPRzBCbmx4bk9ROUJFc1ZLUkFaR1lLRmNmN3hnalVS?=
 =?utf-8?B?YlF0bWwrYnFRK0VIV2JCS1lPOWZ2aXFWM1JvMVFVb0VGS1lhVm1kbXJxcndl?=
 =?utf-8?B?MUFEN0VldjNDV3FoeUdPL1c1T0ZPVU1XNS96NVgvaStqTUhxeDJORFFNc2Ew?=
 =?utf-8?B?VXZyTDBDbDZSL2ZMTnV6M3JVMHpjQ05BdHlhTjlIc0tiQ2FrN2o0Qm1MMWVW?=
 =?utf-8?B?bXlZcmQyc01uT0tMa1ZTeTdCNXIzZE9xc3dmaldmTUgzWG1HcjNuK0RhRlIx?=
 =?utf-8?B?ODJkR1YvRzI2Y0pES2daempRakpha2FyaUJkb3c2LzFOVy85Uzc0TkNGTVFn?=
 =?utf-8?B?NjRXQm9LaVJ1SHBPK296Sis3YnhyTXdtRXROd0VuTTNlNWxnK3dRTFhUYmVF?=
 =?utf-8?B?WTQyUlZDMDVXcHd6ZE5aTFRLM0wycUhKUVVOMnNQRnBIejAwWmtvSG1Na05y?=
 =?utf-8?B?OXpabDg3c01ENXFDMndBOWRTek5KV2R5RzJud2FUclczczlrZ0FubjVIWmVE?=
 =?utf-8?B?Q2xpcGtNaG10ZEhOV2FzS1FwNWh0cnkrWVgyd004cGNBQVlBOWZwdVBVVCti?=
 =?utf-8?B?d1NmdU13dnY5VXRwclZnYnQvd1Q0WExUNER6N21JV1VlcFQ4Q01GVHdNVThn?=
 =?utf-8?B?bTU5dTdnTzh5ay9iK0pVRUtYRWZ1eXcxUEpjSHI5Z1ZNYnlBbElSMUU5Uitj?=
 =?utf-8?B?VEVndng2b1NxRk5tUkZnSVJrdWRUTWEvc3JaZ1cxSjBhOGprd3d2Zjc4UlVQ?=
 =?utf-8?B?R0hLNCtJOHdTdjg5ckkvMVpYL0MzV1E4Wk5JY21sMmVyQUs4QmNvZis5YVNU?=
 =?utf-8?B?Z0ttQ1E2UkRNbnZpZnRQL3R5UEZFV0M1M3YvWlk4TThNaCtBMmxRT2dnOU4x?=
 =?utf-8?B?Q2RyVzhuVmRoMmdBOXpqbWJucnJLdjNsdkFGUmNEdGZXbXNtSXc0UWJhV3F4?=
 =?utf-8?B?THVhY1lZdzc5MlUwaDc0MUxyVjJGQVJtdjhBeGIwUFVrekJ2Qm0yQTRyTDBs?=
 =?utf-8?B?S0pUYzBaWk5lWkc1OUpVQ2tFNSsxVCtnajAxMVRoUTRCRHIrYjFIZzltVjVF?=
 =?utf-8?B?RFEzMjdqamErWnV3R1Jsbnl5dy9MeHB3QjM1b3loQXE2WGNLRURsQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b865dd44-7653-47d6-7626-08dea147dd69
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:51:56.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKN5MHTBMZJ+mUOtKn8z33yZ+5QVZVtbG7PsdC1nZ7eJscfQ2w0/5L+DYL6qjSkUEihNmRTyi1weLyvldGKMGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8468
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-240509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07DA5453E6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of having the reference creation serving dual-purpose as both for
let bindings and alignment check, detangle them so that the alignment check
is done explicitly in `make_field_check`. This is more robust again
refactors that may change the way let bindings are created.

Cc: stable@vger.kernel.org
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/internal/src/init.rs | 78 ++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index daa3f1c6466e..0a6600e8156c 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -249,10 +249,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
                 let accessor = if pinned {
                     let project_ident = format_ident!("__project_{ident}");
                     quote! {
@@ -367,49 +363,49 @@ fn init_fields(
     }
 }
 
-/// Generate the check for ensuring that every field has been initialized.
+/// Generate the check for ensuring that every field has been initialized and aligned.
 fn make_field_check(
     fields: &Punctuated<InitializerField, Token![,]>,
     init_kind: InitKind,
     path: &Path,
 ) -> TokenStream {
-    let field_attrs = fields
+    let field_attrs: Vec<_> = fields
         .iter()
-        .filter_map(|f| f.kind.ident().map(|_| &f.attrs));
-    let field_name = fields.iter().filter_map(|f| f.kind.ident());
-    match init_kind {
-        InitKind::Normal => quote! {
-            // We use unreachable code to ensure that all fields have been mentioned exactly once,
-            // this struct initializer will still be type-checked and complain with a very natural
-            // error message if a field is forgotten/mentioned more than once.
-            #[allow(unreachable_code, clippy::diverging_sub_expression)]
-            // SAFETY: this code is never executed.
-            let _ = || unsafe {
-                ::core::ptr::write(slot, #path {
-                    #(
-                        #(#field_attrs)*
-                        #field_name: ::core::panic!(),
-                    )*
-                })
-            };
-        },
-        InitKind::Zeroing => quote! {
-            // We use unreachable code to ensure that all fields have been mentioned at most once.
-            // Since the user specified `..Zeroable::zeroed()` at the end, all missing fields will
-            // be zeroed. This struct initializer will still be type-checked and complain with a
-            // very natural error message if a field is mentioned more than once, or doesn't exist.
-            #[allow(unreachable_code, clippy::diverging_sub_expression, unused_assignments)]
-            // SAFETY: this code is never executed.
-            let _ = || unsafe {
-                ::core::ptr::write(slot, #path {
-                    #(
-                        #(#field_attrs)*
-                        #field_name: ::core::panic!(),
-                    )*
-                    ..::core::mem::zeroed()
-                })
-            };
-        },
+        .filter_map(|f| f.kind.ident().map(|_| &f.attrs))
+        .collect();
+    let field_name: Vec<_> = fields.iter().filter_map(|f| f.kind.ident()).collect();
+    let zeroing_trailer = match init_kind {
+        InitKind::Normal => None,
+        InitKind::Zeroing => Some(quote! {
+            ..::core::mem::zeroed()
+        }),
+    };
+    quote! {
+        #[allow(unreachable_code, clippy::diverging_sub_expression)]
+        // We use unreachable code to perform field checks. They're still checked by the compiler.
+        // SAFETY: this code is never executed.
+        let _ = || unsafe {
+            // Create references to ensure that the initialized field is properly aligned.
+            // Unaligned fields will cause the compiler to emit E0793. We do not support
+            // unaligned fields since `Init::__init` requires an aligned pointer; the call to
+            // `ptr::write` for value-initialization case has the same requirement.
+            #(
+                #(#field_attrs)*
+                let _ = &(*slot).#field_name;
+            )*
+
+            // If the zeroing trailer is not present, this checks that all fields have been
+            // mentioned exactly once. If the zeroing trailer is present, all missing fields will be
+            // zeroed, so this checks that all fields have been mentioned at most once. The use of
+            // struct initializer will still generate very natural error messages for any misuse.
+            ::core::ptr::write(slot, #path {
+                #(
+                    #(#field_attrs)*
+                    #field_name: ::core::panic!(),
+                )*
+                #zeroing_trailer
+            })
+        };
     }
 }
 

-- 
2.51.2


