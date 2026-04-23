Return-Path: <stable+bounces-240508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AyLJuky6mkCwwIAu9opvQ
	(envelope-from <stable+bounces-240508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:55:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87195453F11
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF07030DD924
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2F3242BC;
	Thu, 23 Apr 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="r0ViGhuW"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88651329E5D;
	Thu, 23 Apr 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955922; cv=fail; b=IWM7lAoHXuoz/zhw/7gRXalZDPSS+aZhO0QkJMdu2FoFvpfyNHS3cYlntFPkE+daH7sy++94wBtTDvEu98c1Eiexcrm2p2RmlZ6AD/LTrJ9tYpT+2oCKk0ehfU70a87c00xeVstgZtzdHkCEUbJbNqzEkz+AJbBb1R/v9pam2xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955922; c=relaxed/simple;
	bh=3J6ZDw/IR9VYJTz224vGXbN4bzD+H+dHBqymPicUqes=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CKddsDH09LOoxbjPI95vLt7oeBZy0ghjDjf0mV0bEqotrwYbJWVWIhExc9OGO1lvK5I4c6JhBlwbsqH6ioIW8785YWQCzsfDuArr7w132XYxfT2OvoTSwqAY6QY4jvt2MJ2DSf83jjoKT+KS3GjRDXxlDPp+S5Brre3OyUS9KMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=r0ViGhuW; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJtYO4tXhWY6eL6HxfjJ1+XsIn2urqg9dDphP/dZHLzqiVKEjbiGaxFrycpu2CTsjKzTVpeCULBhiOray53pJn7g3orDMd9kU1sArqyDQY5JJvCf0SmCqDGWtMSHD76eoSAIlApATuzICrbRTLV1y6Uz9XXAmTQe7w31MFGkED/bzPtSm1VtIHdkpBggm5lW36kMCAnC3tWgslgvFwPp4mSeYMX3e+v2rhQCniqotfZhY34WHYMf7nUu4gb0iXLzTJLWEILtRWTjdOKDyjD4IawWGdlktIIJDolzaYfa+PB1PUgZ7FB0G3WwfUM5Mnu3rSoMdHHh/VUYZC+q75PZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cOdGU1BHobV8EWsZK8v/zKgE4ycFgqE+wYsy2I2HLY=;
 b=dvzQ+p3ZcN4ORo6UvIhQjzGj4G9y7M/q+7naVD/XYjqlHch7Yx8cmpJ6XMhnXVTKE+u0EjnrJLogbiycQz72UPaBVoO28qoy6uGKtJM1SXNBDUCczMq2Oo1ApUfYHokDhYhAJstoqsZgxJBt6PsYKUouWulKXm7ft5WHJLqlHIDtoza5wLOayz8Bl2dmOVIFdBrHDVxAelXkmdquhO+48c7wIfPYf9jpWAfuKQF31d4nnhb18q2HfkPFg4VINnS/67O7PHevu5TeU3th8i5bz8oao3MXVTnZOtzI0nosiLk8K7TxscfN28dYelkoHpPABqX5+/fcq3O8yCyokXJwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cOdGU1BHobV8EWsZK8v/zKgE4ycFgqE+wYsy2I2HLY=;
 b=r0ViGhuWSxXQvd1odIuIYTHGh0nQCMSUFz3bblvlZQa0Vke+Vm2RmoIVpN+cNdxo153ToPnE+Hk4HTTIGkExNulgMbP+URjO8BewdISZ9AdIUga6cberm9B96COJP7c2DZkNbmggJ9Oqof3rQAP7OLMRfCwsa1WfPfhBGf92u58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CW1P265MB8468.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 14:51:56 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 14:51:56 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 0/2] rust: pin-init: fix incorrect accessor reference
 lifetime
Date: Thu, 23 Apr 2026 15:51:48 +0100
Message-Id: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQy6mkC/yXMyw5AMBCF4VeRWZtERlOXVxELaspYlLSIRLy7Y
 vmd5PwXBPbCAerkAs+HBFlcBKUJmKlzI6MM0UAZ6UxRjqs4FCcbWjnRWKUrM2hblATxsnqO85d
 r2t9h72c229uA+34Ao2CvJnAAAAA=
X-Change-ID: 20260423-pin-init-fix-cf469cd6f782
To: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776955915; l=1502;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3J6ZDw/IR9VYJTz224vGXbN4bzD+H+dHBqymPicUqes=;
 b=3TXyquxtqe9ECOioiI125Wmm3gTE+ufmlypn6NIaQlj9xxxFD2bO7b0e81gkMUgHJ3l1VUq0u
 i+8U04DNt8/AjVW7hT+DyzchMIxgWkx6QBM5fA3RRyg4wpBABy8ZWvv
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
X-MS-Office365-Filtering-Correlation-Id: 2d04cc31-5111-4964-b658-08dea147dd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HPYXtDZslehIbyFN6VFh6lrcX90U8ppzfYtx1ZahdIlikCbVmPopVKYBpelducLvGo7eQzztit5W+RR2fz9eGxHopEYTrvIf3vHYXIw6gU+oKbYlNpv0oNoIqRfeCI3cCPgVonT4qTg/qBq/RyJB6sFP9Z499jWCjO3AGeoLIxR/o0ZBhkvbUi06du/ol7vzR0Gy1cL2mTDr8AyFgEyT8lx8P7yBNFdiJYm5sox+EOn86RPz7ty2y1Fkvq9OdS+4oquwScqmPV4HHVz2Ysb91qu4KkMHSboCThD3+qRg2olhZnoYFqhCTALI0cjWMimmnfMNrJpUTW1mxxaxZ/G3DVRpzeXG5ZJlQ1njlN5Q/mE8wQ0MFeC9md9mZdF2JarGllPB50RJ35AzxFIssOdsYFmEXhtUKiMjGc/9TzUd/JeJeFxwPubuh4kN7G7MQAJxBIpSb0k8x7JE/bByXcZe0XFulrEsTzUSCikz7v0p8On6we4lALMDqxMWhID/k+nl1ULgpSyeVBPXmj/sf8/KysGehnY3kLfUF+RjSL9qEs2Z8XG2u9Lgr55jcpyzpY4gJvs6m3+7h8OQ0+0ndEm6fEK83KRM5d1gMzGZXhFFfU0EHlSt2dYxLd4SKeUy5WDuvnPT3eVwuwk9Y+LHTbpbLCiYaU0XCEuYzhfCUtg5MQMGmsPDKbr82YV4PZXzER4oUtuEwDsj9dMQ1BovIV4FRzQVfVDhBW7TrVnxopy1tR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHRENitwZFhFRDIxMEltcUUzOVdKMEJsSWdTeU4zWDRSL1pNaWIyaW92bVUy?=
 =?utf-8?B?MUpyaXRpU0dCeVhkZk15NXl0RDZQS2ZlZWNtUHBENlVKRlRCbXFZSHdUOFA2?=
 =?utf-8?B?aEVuazRCRFBORHlQZS9uODU2cGF0akFVRjQ2Umh5TzBzRVIvOWoyL0tQTVBi?=
 =?utf-8?B?Nk94emVhanp4SGNsSzFlc1VKWHA1YlNHaThmWSt6QzZmelZnclJSTXIyNW9D?=
 =?utf-8?B?MTNINGx6eE1uWnRETCtVeTEzQzFRdjlEVXgyeTN0N3VCLy96RjB6MHR1VDM4?=
 =?utf-8?B?ZG80TTBaM3YwU0tZRjRTY2pLTnc5VXhSdEdsTDQ5ZE9MOEVXcyt4dVFJajFk?=
 =?utf-8?B?WUxHQ1RycE9aQnpMcExSQWNUYVYydm5BVElIclp3V1h6TWZnR3RLYXg5akZL?=
 =?utf-8?B?K1JOaWlRZE04R05raW1qTzc5N3pMcEZOZW9DU3VWSWFSVmJMbXliNGJrWm1R?=
 =?utf-8?B?Q1plRnArZCt6RWZMbVNvTnZIbUxuTDR3MTZDSCtsZHJuc0F5S2IxYTNkNzZG?=
 =?utf-8?B?SVdzWFQ4VS91dlZRZ3dZYTRPeXU3MUd3c0lFTHJCS3NLNHF1Z25xUGxKOUZs?=
 =?utf-8?B?ZTVOMkpwWFZTekxQZWlDYWhLd0pkeFRkYnErMGZKb2c4K3J4ZU0yWStrUUhV?=
 =?utf-8?B?RFdCVHNiMHV1dVYvYnVOY2Z6d2QzRDhqcWI1OURPYXd0MlJMRkcrdTZkWEgx?=
 =?utf-8?B?cjNRd0VMdndNN0JYaDNIUUwzK01yQ0M2V0F6YkFFTThnWi9XZGk0aDdvaGc1?=
 =?utf-8?B?N3ljekU1UEJXNDF3TG9JNXBHMnJzL2gyeW90RjliZ3FXYjY1MWdQMG80SDlM?=
 =?utf-8?B?b0NLVHJveDJLd2pSQkJxNEpvNXQzSXZSbytlTjhmTU52dEZ6OWt2aXBuQmNa?=
 =?utf-8?B?blJ5UzV4clNuaUQ0bE4rbEs4NWJCMlcxOEUySjJaYXEyN0d2NnhYK3RSenpH?=
 =?utf-8?B?QmFZcFBaTVJTRk53UDVuUHFwUEIxQVFmejBZdUhJYmlNeERSLy9ESVhYMFJj?=
 =?utf-8?B?NGtoNkwxMUc5T0F3Zlpsam9VUy9iY2habnZ1Zmg1SzQwSEZNNUh1bmp0UVdt?=
 =?utf-8?B?SFNvWG1OZlp2WWlZNllMbzRDWVJOWGxjck50ei9wSDdxS3VmOGUzd01hcTRC?=
 =?utf-8?B?cGh5WjZwV0RBWFhnYXNBV0lKbTFKdFRxWDNRS2tmNlA0dEtmWDFGUGFaV1o1?=
 =?utf-8?B?L3JoQWZEY1Nac3pCVzdBeTVQTlBlbGw0a3FwRXZNZzdpbTlOTUxyUUtkV010?=
 =?utf-8?B?OForUkJWUVErZkxoRmw0VlgyRmgzRHlaOXhmTWh6V0ZkQmVJRE15aWdmVVoy?=
 =?utf-8?B?VGYrOUNOTkVWQ1h0VlFyY2hEMUFhaFhBRHpHTkU2YmNDMWJIeGVrNzhFTmp4?=
 =?utf-8?B?bkFUZWZFbFdyYlRLVVNtUXkyb2E4LzRGWGFuRDI1dUZ2T0x2bExMVzVHaXlJ?=
 =?utf-8?B?VXhIWGFuNlpOT1JUaENNTjYvUko3WDhjTGtmWCt5TmZDK21HdktRVDJ1SlNI?=
 =?utf-8?B?YmxzSzhyTDVhTnhEdGQ2aUY1NVF6WGRPUFRPMUVzUTNRQ2l2TUZZMTdiWmxJ?=
 =?utf-8?B?dFltZVFZbDIvQVAyeDdtcFk3ZUprNnEzM25JSDF5UEZGTm5DdjBnbTJaTXZC?=
 =?utf-8?B?VjR1bGFtcmZKYTV1ZFRRdEpOd1BJclNDc0xUZEptdzNaaDVKRytxL2xPNFZC?=
 =?utf-8?B?VXlDcDhDekhOQk5WZ0V0Qi9HbUpMR2wrS2V5Wmd4UGFzUzVkb2s4dFRuUWhY?=
 =?utf-8?B?Qjh1dVRLcEdGV3g5aGNucjJqV2oyUTBrcnVMUHFuRFFXWE9xVktIS1hUNGl2?=
 =?utf-8?B?bGg5aFA4ZlRxRTI3aEhKV2hNUWhlYkxVbm55OUdXTUJJSXV3amo1U244c2Nx?=
 =?utf-8?B?RDhzSnh1ZHdnS1A3TUs4Ym9lVyszcFRvRVVkbTFnd1diRTFvL2JteGhXYlFk?=
 =?utf-8?B?amt4ZTYvVGFIL1hJT1lCVURSZzkxQ2RrdkpGNGdkUFYxU3dGSVErQ3dRWEZT?=
 =?utf-8?B?aElUN2IzTzhVUExvM050S3YxdUw4Tkl5RUxVVmhzTDRkQ0VuUUtaT3FMODRK?=
 =?utf-8?B?OXUyWXg2Z2ZJMFloMW5UcnlIbG9pS05rZ3NIeTA5c0ROVjZjbjlmdzZOTzBv?=
 =?utf-8?B?L0VPZDU4TzRiVjZOb3cyNU1xdDdvd2VSakZyY1drVHd4WFhUVFp1MDVRMWlj?=
 =?utf-8?B?TDRxYzlUcThqWSt3VjhHa1dtN3hvdG5EZ2pXSm9icW9sZmIzckpBWjlPcndF?=
 =?utf-8?B?Q293b3JGWUMxUDAxQ1dPM3l5cm9XV3ZSY3gxcnBtMi9lVklvRnVlNzBwajhL?=
 =?utf-8?B?RjE2ZjZKcWRWMlFlVWprNWl6WGpTN0NFWC9yWFRuKytuOTV0aFkrQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d04cc31-5111-4964-b658-08dea147dd26
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:51:55.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJS9ah7m/aSkPjuvuTxTuhaO7CBCPHauZlBGSZaSzeGqulFoX0Kjm48faFE1LLCrd3V7VComN5WhuVdtmftvYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8468
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-240508-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Queue-Id: 87195453F11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a field has been initialized, `init!`/`pin_init!` create a reference
or pinned reference to the field so it can be accessed later during the
initialization of other fields. However, the reference it created is
incorrectly `&'static` rather than just the scope of the initializer.

This means that you can do

    init!(Foo {
        a: 1,
        _: {
            let b: &'static u32 = a;
        }
    })

which is unsound.

This series fix the issue. Details can be found in the second patch.

Changes since v1:
- Moved the field alignment check as the current dual-purpose reference taking
  for guard and for unaligned fields cause trouble when refactoring.
- Use a method instead of `DerefMut` operator as we don't need the `Deref`.
- Reworked `DropGuard` to use a reference to capture the safety invariants
  (Sashiko)
- Generally improved the safety comments.
- Link to v1: https://lore.kernel.org/rust-for-linux/20260420172302.1843752-1-gary@kernel.org

---
Gary Guo (2):
      rust: pin-init: internal: move alignment check to `make_field_check`
      rust: pin-init: fix incorrect accessor reference lifetime

 rust/pin-init/internal/src/init.rs | 182 +++++++++++++++++--------------------
 rust/pin-init/src/__internal.rs    |  31 ++++---
 2 files changed, 99 insertions(+), 114 deletions(-)
---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260423-pin-init-fix-cf469cd6f782

Best regards,
--  
Gary Guo <gary@garyguo.net>


