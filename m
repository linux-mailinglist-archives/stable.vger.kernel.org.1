Return-Path: <stable+bounces-244127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD+TLrDk+Wn2EwMAu9opvQ
	(envelope-from <stable+bounces-244127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2B4CDAC5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6B183031F72
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E34279FC;
	Tue,  5 May 2026 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="B+84YijY"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28D1FC7FB;
	Tue,  5 May 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984256; cv=fail; b=eLUj0HEpsT0YkzYzov4qxO6VD7nSZfPZuhr3hmyjJ83YbMs13iTfpZ5tKUJ6hMkS6Swmiwyd6vkfb71IQq6/zC6rDOS4Lma3YnvY2YmwDt8+i5ipHVzpTzte8Osn/8KOohJgbWWpCLBrKZ8LMuKIfnymnnq2esQza+enn+tAKy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984256; c=relaxed/simple;
	bh=57nKnR3k7awgAWg1U/Ism6WWx+4SReIMCYQDRQyp6ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sUJUmep11bXlfKOtBnlFQzw7YuAIBr6PqGz9K4I0jGyBs8XV2XL4pQPw812gWOvVYI50aHDRHJll06QsFZEiLDYMIbX9IGXnVuei57MkdKBuz28X7wVH4H48ffSpmYFkYkcj/SvO1h1Sv47dIJG8kyq76Alk+xMj6I5OND+bGyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=B+84YijY; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2+iSnMgiDrKeGgdZum/pX1m/MrNBD1WMeQAf0gCL5te6xeYImXX4cawbNSbZaE2itiGBTzpZSGyylp7620sYjO8nQWlgTZlAegg/VGF8oxYftn5TLh3k58wFtAEM2NvfUau8rNrpTmVxZMFdUkAv8MIf9tFFJsAiWO2oStGBkL0v1CY0XQ/L5LqSFU5QUmG6g1xh+g7XbXQF2Na3XIZnLgHGfEEI8F1DAjoCxqAF3oyPdb6R6T6+o1wUGamWkevyQOxvtFATMaVJxB5Cg0AywvqbLTB9ef8CjGGSWX+eMrIqilAmepGlAeFRPyf7XJjoOzKQ4vMf/OpqeMMD/Unsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57nKnR3k7awgAWg1U/Ism6WWx+4SReIMCYQDRQyp6ns=;
 b=ZGCu7XmEkmvH5zlFZSeJrFdqMXUe52dbBbSIOi+Mq8CixbRjCQQWNwyTb/Qrn4D4WjQBmpBwzNhfeKVqvyJxH+XvJvoRs9rOpwpMEaoW5nPgncuo8psg+EkAe31GZW5EnuYZkF8ejPbMGWdMAVkWFfXnrj21oJ+WyqYMnZE1R1vYzauyD3Jh/eOFI+N4rt/UQwXYddRAPtMNKeZWIoVq4v/w/nnq7EIdR8ZrbF8N1coTJiRD06H8nzzxJms9ZH3gVv+GVgvk3IuBJI7Rea2ay+g9nSkLcCyEOJYYowEL+BKYTL4C4/9/9OEMcSN3NzPwkiKBQmtZuwtemghjJuGnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57nKnR3k7awgAWg1U/Ism6WWx+4SReIMCYQDRQyp6ns=;
 b=B+84YijYv5rV3GPFaac9Hf4GfaxIpjOt0xA98iyL/w2oUCQQwzyFueGIsvmL0BFYdauwmwO9p7aN7dWV1K3wfsl/kbxaPERkirtbUsGvB6V6iTTbsL1TVEO3Zlc2+0Gl2n1sTrNDmPvmsC0g1+XBwYzVhbpySfT+Jvb/WjluYonZCfyqCrfYdiBAHocW6u6x8dVNCGGfVx60NPeJ0FThvohJig9bNofIaIg8nF9eDdu2ZigfPa8+MOOm4mVtcqBDWPKGtjkdAQ06M4S0NbIn5FYVcH+COaR7daSugECcowvTUGFwNEqpIfHhfdaWiPMrryoQKnOWMLNUq9lxj5EsWg==
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by GV1P189MB2219.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:30:48 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:30:48 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Chen Zhen
	<chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>, Malin Jonsson
	<malin.jonsson@est.tech>, =?utf-8?B?RGF2aWQgTnlzdHLDtm0=?=
	<david.nystrom@est.tech>, =?utf-8?B?Um9sYW5kIEtvdsOhY3M=?=
	<roland.kovacs@est.tech>, "ysk@kzalloc.com" <ysk@kzalloc.com>,
	"42.4.sejin@gmail.com" <42.4.sejin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Topic: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Index: AQHc1bj77gFL/C3sNkacAb6ql69PQbX90UuAgAGZQwA=
Date: Tue, 5 May 2026 12:30:48 +0000
Message-ID: <59f615b6-eea4-4186-8e63-d60a57ed7822@est.tech>
References: <20260426201205.465809-1-yunseong.kim@est.tech>
 <2026050435-glider-undrafted-71d7@gregkh>
In-Reply-To: <2026050435-glider-undrafted-71d7@gregkh>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P189MB1752:EE_|GV1P189MB2219:EE_
x-ms-office365-filtering-correlation-id: f0eb3dec-9156-4346-9744-08deaaa2232c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 AbpKwjKsMUcLVl3DFK+1sL/E3fBSx9I1uVrmXgrDDvSpLmJG3Cb66g0Ly4+n0wFVrJyqikSD0Tf5hxz/fMNQ3C+P6D5dmUmpSli9tlXz/lT9JzK6BgEtoeIARzwCdG+6rRBjA38VFFyWRQeaIsTf2rX8ovOULJ1/s+462ggm2l79lno6zlsJMpd04k3d6NesSVcUGuAv0qgqhc2GCLyO3c8uzJfLgEibDZ7vk0svcRWNT6HLmkGt+j3+77TrUE0b4wBs9sXsc7hW0J8ApKf0IRJTnPrChek+d85KX6bnE2EKnxjx+z0cdvIxtD+ysnKXymiBg+IimA6hUz4DvCcUeV+kzTkvo9wFuh7F4OEGXmHeTwo6TtasbZ7WZELrkbr43ZiTWurUkZ4Pu8ssxIh8vdWvRY8aR1Ry2uVCbwfXNkMFlYQ2/SlGTw5FbW3v/PQuutzhamwa3SAngHVL2uI75+jgEcMKqjV4ZbSwahOtJA1s7nqeXI0QA9WAuo5jEg6ADVWwpgBCEeECr6iaRFuYdPc2HRV5XOtT0wQNzKSI/A7OvNQeRe0Rpvw1l12tgXONd3/n3Bo97ixXpqcmX6alwKcQgpoPD2zCTDnFWFBAuurOWg0RLXUtqfIDw9mJlZ4VyXRaNMSXkCJyqGFhtUxS7mbq55mIjR7eYp/9mAxRXUDw2FKAkTjRt1HMoztfN7DeQq8J+dG0OHrX+TOZa2MaFOOGCtw1kjgwbwq2eSas0VqL3zf1CZlrxype0WsD+/5W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVlFbzRJaE91K1dmeW5UeCtlNEdHUUV3N3h5V1VtKzZ4S29sNzJmUFd2d3JJ?=
 =?utf-8?B?OGVQTVBmdUo3a284RjFxUlp3cENrQTNpQmp2Y1dxeDJva09lYVdXVmkrR0Zo?=
 =?utf-8?B?aGpsMnhjMkhTN1YrSDQyK1hhblVuMXp4Q3BKTkY3Z2lPb0lTMTIyWDJRVVlW?=
 =?utf-8?B?RWNCY2YzR1VzTXVHR2IwT3ROSWdNMGt2V0t3L1JGcjQvaXRFQVlaTFhDMG85?=
 =?utf-8?B?aThVZk9oOTBYU1pvS29UMU1iVHpoZFFLc2M3dnJXb3lTMnNPUDNvcDdnY0NJ?=
 =?utf-8?B?Qkd4NXZqUmEzWUdlOWo2WFRSVFlnTlRVSHJxb3pBT0pPMzdyNDNWQmltWFF1?=
 =?utf-8?B?cVc1TzN4d2RjVHdXT0liZkF5UDFaWlhHKzBnV0licWhTZ2U0eFk2WFYwU1JG?=
 =?utf-8?B?UGNqaFlBME5pdHlyTXI1OE5hcVh2QUQ2QlNBdUJYbHlNQVRyM2UvVnJmLzNa?=
 =?utf-8?B?S1NPelNBZldoTXY1V0pOY1VDMHBxbDJKeUtPUFI3L2JTa0p3TWc5bURXMGx3?=
 =?utf-8?B?cnZScmxPUzh1Mm00NnVyM252OEFKTHJZZWF2OHJoMkJrM3I3UWtHZmpuZ0Nm?=
 =?utf-8?B?OSthTGRndHlpTkJBUW5vSGwxS0RzR2N5cVYxVEkrR1Z4anBiNmNUTXBNNnJy?=
 =?utf-8?B?TG8xR3EwL0R5Ylh6Ulg3TzY0Nng3VGJOTVdIMU14Nk5OS3F3UUkyd2lFUjFX?=
 =?utf-8?B?RGFMZ3RNS2VqODlsVDFGMHRhYWU1WFEwRzBrMWt1QjFRYnNwcFZpN2d5bGJx?=
 =?utf-8?B?dlBYSkI4c3F2MVJ2VlJIait5aStMaytJd25ZZWR6MS8vYnBmQmNCZDVrb3Vo?=
 =?utf-8?B?WGg5QTFrQ1ZSVkJDZkxXc3FlNFQ0OHNZMEQ1Z2cyMXBTSjBVNTR0V0pBWE5H?=
 =?utf-8?B?WjFqTThKOUx5RjhFaEpQTDVvN0FpZTlPYm5DZk1XWWJYdGYzV2VybXhGV1h6?=
 =?utf-8?B?NjM2UysrWE1zNWdvSHk4U0JiK0xWL0VGbEZSd0FlRHFhSWxhZm1KUXFIbENo?=
 =?utf-8?B?ZW9ZNWp0T0dZVDVjK0R3Z1BmalBWQkFhQUY1ZGlhbEdNa0lacE9jSVBhOTBG?=
 =?utf-8?B?Qk5WTWZTNDRSazlYWEw4SUFJV2tTOUZYcVNMNFVCRVIyNTlQSm1KbGVLOXpq?=
 =?utf-8?B?eHhES1VkQjRHK1lKbURMNFNrQ01Zall5OXR2dFVrWVJTVDI5MVNHZVl1c1RD?=
 =?utf-8?B?L04xRjZ5ZkxMV2ZuM3VZUnVwOTRrRDRYUjZSMm92SGdGNDFNazljNHFTQTZZ?=
 =?utf-8?B?Y3RORFRSWUtXZXJwSnpKS0xoQ0tMRWk2MG5XN2hFWkZCcFNSZlBHWlA0MDYx?=
 =?utf-8?B?YmN3Q05NMmJGd3MwcnFJWGRpNDNNU0NGRmowV3FSQ0RXUlJVY3J6c3lBajVH?=
 =?utf-8?B?YWtiNXNlNGR1eWJleU02MkZOL3d0OU5Rd1RYRHdlMnBWV1RkT2IwTWYvVUo4?=
 =?utf-8?B?bzRWRGdKbDR5OFNlWi9NYXdXSHh6c2NCT3gvSUlZUVpqZVFWNElheFJhcXZI?=
 =?utf-8?B?aGhCRE1FODdDUzdQQjloWHZFZW95U1FTSHNUNnB5dFBUZjZWcDJYd0xJWk5Y?=
 =?utf-8?B?T1g5Q21YVTVnTUwrOHFWMDlpYjg4SHh4cVVKalJxcjYvWUxWYmoydm1Yc05j?=
 =?utf-8?B?RVo3WUo1YVBFKzFqdjZUSmU4VGkwZUxZRWRsZmdyaFhFazhyVjVmOW54T1ZC?=
 =?utf-8?B?NEcxRzdtQi8zb0k4S1pYR0FPamFGbklNbHl2VW1RaVhPU3pIdDEvNmlOSXlh?=
 =?utf-8?B?UG5NaDg2M3k3dHZoSkFlaTIvbTluRUpkSDNPWGJPQUFTNkhxNHgrTjYreXV4?=
 =?utf-8?B?UTVSYVhOWXZCamwwczh3SjhwNjk5cnJ1c3dobXpPWHZWZDMyaWUyNFdDRDN5?=
 =?utf-8?B?cUtWY1V6b1dOS1JwMXZ4ckJaaTdCclY1c0Z1MTZxM2E3RUtvYjdjUVVGR2NZ?=
 =?utf-8?B?K2FZOXVLc21LaFJoVjg4cnUycnRxZlJJRWhkV2tzb1hPM0ppc25mOGNsR3hS?=
 =?utf-8?B?SHI0dU5wZFEwa1oyQ0hua0JoemsyVTRhMmxIQy9vVHVCNUpqbWVya2hVM21C?=
 =?utf-8?B?NXBqZm50a1UyUEliemF6U2ZXZkpyL21HZjVQRHBQVDgyQVltb04xdXQycmRO?=
 =?utf-8?B?enRVL2dseGtIeFo4ckppYy9PWjBEb2RvNlY4RHhvaWFISU96K2ptY2hYUzNt?=
 =?utf-8?B?MUNvWDE3bTFmWW1ibEVJUnlEc2hLd3BFQ0piMitvWGlSZ3doZVZGQzd4cWJG?=
 =?utf-8?B?ZUJWcm4wdDFhYXpRcFg4SFY3YzU4ZTN6a245WnlJSmlNVytIK2VTS2tacmJK?=
 =?utf-8?Q?OEv1L19t7sRFL0tUEU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE44770118FF4846B6C1712AE17B8DEB@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb3dec-9156-4346-9744-08deaaa2232c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 12:30:48.4377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wTaCN2tO7tPGcylCNQoN2JMEnSm7ZJ5XSgyRXgNUHlfJ5PZ1ZL8Cc9cIM7BavWdg97HMMQcfzJ/rKLwJp8ryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2219
X-Rspamd-Queue-Id: B7C2B4CDAC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244127-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]

SGkgR3JlZywNCg0KT24gNS80LzI2IDE0OjA1LCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBTdW4sIEFw
ciAyNiwgMjAyNiBhdCAxMDoxMjowNVBNICswMjAwLCBZdW5zZW9uZyBLaW0gd3JvdGU6DQo+PiBG
cm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiAN
Cj4gSSBkaWQgTk9UIHdyaXRlIHRoaXMgY29tbWl0Lg0KPiANCj4+IFsgVXBzdHJlYW0gY29tbWl0
IGU5YWNkYTUgXQ0KPiANCj4gUGxlYXNlIHVzZSB0aGUgZnVsbCBjb21taXQgaWQuICBBbmQgZ2V0
IHRoZSBhdXRob3JzaGlwIHJpZ2h0IDopDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K
DQoNClRoYW5rIHlvdSBmb3IgdGhlIGNvZGUgcmV2aWV3LiBJ4oCZbGwgZml4IGl0IGFuZCBzZW5k
IGEgdjIuDQoNCkFkZGl0aW9uYWxseSwgbGFzdCB3ZWVrIEkgc3VibWl0dGVkIGEgZmV3IHBhdGNo
ZXMgdG8gdGhlIGNoZWNrcGF0Y2gucGwNCnNjcmlwdOKAlGN1cnJlbnRseSwgYWxsIGJhY2twb3J0
IHRhZ3MoZm9sbG93aW5nIHN0YWJsZSBrZXJuZWwgcnVsZXMNCk9wdGlvbiAzKSB1c2luZyA8c2hh
MSA0MCBsZW5ndGg+IHBhdHRlcm4gYXJlIHRyaWdnZXJpbmcgZmFsc2UgcG9zaXRpdmVzOg0KDQog
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA1MDUxMTIzMjAuMzYyNzE1LTIteXVu
c2Vvbmcua2ltQGVzdC50ZWNoLw0KDQpCZXN0IHJlZ2FyZHMsDQpZdW5zZW9uZw0K

