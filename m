Return-Path: <stable+bounces-132213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE99A856A0
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FABF1B84690
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818192980A4;
	Fri, 11 Apr 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kneron.us header.i=@kneron.us header.b="GvI9mNAz"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6E296167;
	Fri, 11 Apr 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360434; cv=fail; b=rYa2XZxqAMYY6uAWnzhtdnNYhiEjJF0Y1SX0nBOY781X/chfULulBDgpD5EWXgLYxqbpjtyg5VpI6nfXx30tSMPJIXPtl753e4I6Y6KU47z8zmcV7vPUCeW0eRBIpcDBW7Vu+GuA6lwCWfQ+fyRPcC3JLm2iCKCfYBBoEkBRFVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360434; c=relaxed/simple;
	bh=DRebbNBpF0UxSbsbvEzfvOrBhsrwCl3aptMV4VzFp1s=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=AaGJ21wAVqSVyunNhZy7lqhHaoYXbOJL3NUy6XfBtJhsPWhu9QbNSz/TgKutw+7nmComOFVVEQFjKgmsn67DGNi2e9Vbl/J9ihBUlDkp8HOZJ7YxeusWRtJcDVaqnTPEGXJanfyjwR1wMhogvYv5kHooTZRNtPlcDlmC9QVX5vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kneron.us; spf=pass smtp.mailfrom=kneron.us; dkim=pass (1024-bit key) header.d=kneron.us header.i=@kneron.us header.b=GvI9mNAz; arc=fail smtp.client-ip=40.107.244.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kneron.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kneron.us
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XISxRv9lE6D1v0hPocXKCsmPtRPP0UrqEWBqDEMVxmyX6EezouXckPviixFVcJKxEEDLMyw5m+vygdtFmKkKA4JIJ/D3TOn0bJbWhEZANiGZnJDqhFFyaP4ND6mYhwOZfRskoSIGy+zw/w1ooFoJjMEpz7xpIgfyr8z1APom/Y7fVjuAJZwbn2nWrlihGCnB16SaxPPZfMkr/aghDR06ENMMX5w7pxkwtdbdSzSrTZdqgcybY25jHGWBwunOna508iJtn7SCjiLMFVduCToohXn4wg5O61693mHHArtZAzrQW5Tz/PIjcz8AmTG5pV+zVDtSl4rj6H3HHpe8Tar5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUHRfWIMoMbD83dtpUDHNme/8QDOJanePcJNlxm5Qqo=;
 b=i4bU1qVIny5iDwTQxNF2p3LjnGGcJV+XYxIxQWbGt/GKSMbAieezx0dJRhypcqRHBWh+JiV7o1lUi/VAlSGhbxEa1DkiwfQHjBnHg0akkKoGpZORhsi9GxuGAFh5yuX/sCSYNzzcsKHY12C8mhocAUELpE+KAulDodQYfKyv6pzopUCimQ9OWKp11olOwd/OzU4hOJtrZpgik0LnLhtoTTiXAfqd+FLj/8AOqdg2fLg1Wgp61XfkcqFxEl8jA9bAfl6W9qoiVHq7t37L4qDq+SH9x5u7iDsaavpJrTnuUvtWlIHpFrpfpMdhe0blyAGcypVjNZMarABH1fS2GLU3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kneron.us; dmarc=pass action=none header.from=kneron.us;
 dkim=pass header.d=kneron.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kneron.us;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUHRfWIMoMbD83dtpUDHNme/8QDOJanePcJNlxm5Qqo=;
 b=GvI9mNAzUOVlXjSBALM0XEYLcDQsK9b3/WqQhQzgSyKsc+OAk908C1xNElCtoL8lQuIoEILWhI64UdRFu0FTA67mzUBNjDP9YHdQdC/d2RnRXJMeKxDZ0LXVx099QuUR/4zmoLX15AF93UvQON/q8Ssz9xEUdzzBg0bzAx93ZDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kneron.us;
Received: from PH0PR14MB4360.namprd14.prod.outlook.com (2603:10b6:510:26::18)
 by PH0PR14MB4264.namprd14.prod.outlook.com (2603:10b6:510:49::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 11 Apr
 2025 08:33:49 +0000
Received: from PH0PR14MB4360.namprd14.prod.outlook.com
 ([fe80::f91d:52ba:8284:3e02]) by PH0PR14MB4360.namprd14.prod.outlook.com
 ([fe80::f91d:52ba:8284:3e02%6]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 08:33:49 +0000
From: Chance Yang <chance.yang@kneron.us>
Date: Fri, 11 Apr 2025 16:33:26 +0800
Subject: [PATCH v3] usb: common: usb-conn-gpio: use a unique name for usb
 connector device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-work-next-v3-1-7cd9aa80190c@kneron.us>
X-B4-Tracking: v=1; b=H4sIANXT+GcC/3WMyw6CMBBFf4XM2hqmtDxc+R/GBaWDNCQtabFiC
 P9uYeVCl+fmnrNCIG8owCVbwVM0wTiboDhl0A2tfRAzOjHwnMtcILKX8yOztMxM11hVdaXLoue
 Q/pOn3ixH63ZPPJgwO/8+0hH39VclIkPWFJ1QjSQqO7yOlryz52eAvRL5X5MnU+SKVM11L9vm2
 9y27QO5X/8c3AAAAA==
X-Change-ID: 20250411-work-next-d817787d63f2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 morgan.chang@kneron.us, stable@vger.kernel.org, 
 Chance Yang <chance.yang@kneron.us>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3228; i=chance.yang@kneron.us;
 h=from:subject:message-id; bh=DRebbNBpF0UxSbsbvEzfvOrBhsrwCl3aptMV4VzFp1s=;
 b=owGbwMvMwCVmsuR+7eedxj8YT6slMaT/uPyy2jfIePa8xx5RhepB6mtj5p/oXrBewXCNYlrrT
 753i48od5SyMIhxMciKKbJ8zlba793SPO/WlZ79MHNYmUCGMHBxCsBEtvxm+B8S+K9l96rwCWef
 /TnWZ/N7vf9hdrcHfBKxdw48jfNK3bGb4X9EdFj9iiJRZnGHzK+98vMeGvSfnJARZh+mdffEved
 Br3kB
X-Developer-Key: i=chance.yang@kneron.us; a=openpgp;
 fpr=F36B22BF4B84839EDAD48CBF34A4DF7DF3B933F8
X-ClientProxiedBy: TPYP295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::11) To PH0PR14MB4360.namprd14.prod.outlook.com
 (2603:10b6:510:26::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR14MB4360:EE_|PH0PR14MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: c223021a-f4eb-44c6-f139-08dd78d39502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|80162021|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajRPNXEzQ2pYdG5QQmU2azlCUjZKOVFSM3oxQjlXdEkvc0gyMkR0c2lxczE0?=
 =?utf-8?B?OXorZXhWZnF6RmkyejdTWEd1d2RrSDdsY0EvZDFXMUJUVElvQkgyK1dqUmN2?=
 =?utf-8?B?d25RRnNERTFFZ1V4cXJQNndsaktoTjhmeGZydllhaEEzNnVJdlp1WGhWUkhN?=
 =?utf-8?B?ckZqMWRXZkkzRG0vZURhUm1seE5HeXFSdWtaa0JUSzlqeDU1L1FrUDBYeFAz?=
 =?utf-8?B?T2svbDZpZ1EvM0ttem9yTUhKYndGZkw5OHh3RHFwejNlN2NHVTJFWU1keVdS?=
 =?utf-8?B?dmw5VnNyaUpYTFd3UEpyL0RQbkhkaStwSHZ6YTAwR1BZc3I0U2thZTV3a3k2?=
 =?utf-8?B?SFBLVmRDR1ZSOVFCMlRhc3BLN01IV2FuNkI0eDhvdnBUVk1QZU5WTEN5NjBy?=
 =?utf-8?B?Mm9HajlIU3RHS2RtbjV0NWtaWEtLbXBnODVmVythelo0eFFUcHZxbkR6OEZv?=
 =?utf-8?B?c2J0UXhhdGwwOTl1ZERyZDFvUGN2aW82U3FNd3loWUt4cFZyNHZZM0FHN3Vq?=
 =?utf-8?B?OSttNVJzVFpCMnlqK0NFOVBUbkJlSHplUjJvczJINWxEa1ZOZEhxZy9ZbExN?=
 =?utf-8?B?ekl6WVRiR0VEay85aUpHcVFYK1FCSmZZaG5HWEhoY3FJV2dQZDkzRHYxck1O?=
 =?utf-8?B?WEN6OXVIWmE0TVBJZ2NpTHdUd1JWZ1M0S3p2enR6V1VBQUpZTUhQY2xIOG83?=
 =?utf-8?B?eWxrV2RqTFg4UWVDWmYzNVIxbmY5QVRVRG5oYXNHdmRLS2FscDk3T2Q1bWNF?=
 =?utf-8?B?VWVybVlMM2F2OGV2VVh2Qlk1cm5wTGd1dmlPb3ZWSTdDY3lZWWp6Y0JYWHBn?=
 =?utf-8?B?Sld0bWhWS1JySVJKZDJVZDUvcnprMkdYYWF5TC80MzNjL3lBRDk4aTlGMVFY?=
 =?utf-8?B?QTF4QTU4MFVDTE84aXNMaGU4WjFYWGNieVhJM1RhT2dqSnJ4a1FzMUR0ckdk?=
 =?utf-8?B?SE0yNGN0MHY3NWhsenN3WnQ1RnZub2s0bEdUeUd5c2QzY3U4eEI1STN4MDdl?=
 =?utf-8?B?eXgvbXM4YWJJdWtETlo1Mis4ZHpXQTZubzk0ZWFEc3hwVnRTVWVkUXkybXJM?=
 =?utf-8?B?aDJYeER3RmN2ei9wc1RhQ256R1ZjS2tFSStrcUZxT29rVnpOSGtqV2JLbTBk?=
 =?utf-8?B?S2tsSEdidlI4MUx0RVhIT0xUQjZMY1FXQlB0bWdtY0x4cHEwRmNaaDNtc3ZV?=
 =?utf-8?B?RVBGazE4N1FVQ3dSVkYvZW9oeHl3c2lyS0JRUkV1QTJjZHlHYnBIU1hGYUlw?=
 =?utf-8?B?em9xLzlzbklHTFNnR05OVHZEbXFmNjFOZERaaElicE1SajRyc2YvL0xRbDlS?=
 =?utf-8?B?SmlyMkZYR2I4c01vYVVNT0s2M21wdTE2eUIyMW5HbjRDTEYyWXh2SU1kemFk?=
 =?utf-8?B?WEFDS0p2ZTJUMTgxbjhhT21lWmludSthQ2NpRTZyK0xBUVU5dE8zU3hnck1k?=
 =?utf-8?B?NmphNkVjVFBaN0Z1c2NnREJTanhjNFEzRnFUSWQ0ellmWkg0akNBVitjUTdP?=
 =?utf-8?B?VXhQait0bmQvVklBVmdvZkdpQVpQdTc0ck5rLzl5czlvb1NLWVNHb3h4Nko0?=
 =?utf-8?B?U2IxR3lwNm5EMWlORUxCd3FtQW1vOXkxM2FDWXo2MkJaZ2R2eEU0dERaR1o5?=
 =?utf-8?B?aWpEMkZNenBSWi9kR25iKzhWcTlEUXZkbHhsdzdMWUk0VzBoNDlTSG04MTlJ?=
 =?utf-8?B?SnZqbWdoU0JSQWl3TWc2Wi9DOTJHcVROdWsrVFlYd3NLbDN4M0RiNXdnZjls?=
 =?utf-8?B?WUVZaXJVb045cTBxcWw2bFo5aXZzcXBEN1NKWVNsUVhSS1EyUktmQW8zMmdk?=
 =?utf-8?B?elA2WVVEU09DTENLOEh0VkphK2xIMzQ5RXE2N1lSNldGT2ZndE5UMEpzaFVI?=
 =?utf-8?B?VUlXYk9HdVFSTUdRbGtYQ24xbzZDcjRVbksrMG5zVHczK212c2VJUTRKTEpX?=
 =?utf-8?B?aXZyWWkxdk9rekh2MnFiOGs1dWRyVjNjRFhNZTY5cWJPNUZTL0svbzJNMXZW?=
 =?utf-8?B?YXRRR1c2a2MvQ2pnWEw4bk5wNnhKZjVuMnFZZ0picGhtTzB5UWNrU3lNSkVo?=
 =?utf-8?Q?79McTw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB4360.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(80162021)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N012NldiN25jRFFjaG55UW0waHJzcVJqSy90bXB0Rk1rcXdPVk9JOGlVN21W?=
 =?utf-8?B?ZytJYVhhbVhadDAzZEdXM2RSRjR5c2JnL1JFdDRWUWtrd0QzSytkUWE4Wm5H?=
 =?utf-8?B?OE5icVVKZEpCaEtmdFNDWTNCdWZqSFFReVdJREs4V1NXRXpydkUzdm5ESDM4?=
 =?utf-8?B?eXFXcEE2K1NrUmtlb1BTZHFaQjZ1TWxjSGlHSnlHeDM4bnZBMEw3bjBxWWQr?=
 =?utf-8?B?dko4V0doSGhqeDNoWDlpZXcwNDM0Z0ZNTDAxTDVyUmZVNFNpd2JxRW9VSCtZ?=
 =?utf-8?B?TnF0MmtJNHpicExGZTQ0ZzU5ZGszWittcWQ1dzdKemw5V3NUbXZmdEdIL0FF?=
 =?utf-8?B?elRlSGordUpLVUFrNVFORldFWlhZYnRsYUEwK01vK1I4blZ1bktpblBWNVVG?=
 =?utf-8?B?eEU5ZGVFTkVuRTh4bEJwRVgwNkgzTDJSTHQ0UW1LeHJwVWhUdHhGK1RCaml4?=
 =?utf-8?B?Qlo5N2F0YXBUUW1WN2RtNTk3M0VZSWtXcnRMY3lzTjB1cTQ2NXNZZkcwVFlt?=
 =?utf-8?B?aWhjMEJLUXpFcjNUME12aEZUMXQyUkk0UDZTNkdHeEw5ZVdUL0t2VmtFTmEy?=
 =?utf-8?B?OE95QndYcjBvd2dOR3A1TjVRMXJ5ejlPYU5IV0ttZ2Z4bEgzNFU5c1hsVjhL?=
 =?utf-8?B?ZnFZQ1RGcVZ6NnBzUHB3cWJPdXF5dDF3RW9uMTVEeis1UGF0OU1FU0FqSFM2?=
 =?utf-8?B?dlljYmZqeGZHYndYbHBOeXFwSFFoalpvWFRPWkFadWNYVmlEbEhzL2hTK2tJ?=
 =?utf-8?B?clBVOWV6WTJpY3N1TTVEalJ5WU5XVmd3MzhLL0Y4bUFoMkkwVmpnWDQ5NXE4?=
 =?utf-8?B?SGVYZXYwM0NSckNjclBjbEdGbWhVaStpMWJyM0pabjkrUnFaMVlMT3c3SXhj?=
 =?utf-8?B?OW55dmFpNEVQWHR5cHZBSERnY2QxN093MnNsWGZ3bDMzR1pLZzE4Mml5SGVz?=
 =?utf-8?B?MG1oQk45bDZHcTZZUzFoWXRGNnhFVXN3ekQxSXdsa1VUNmRJc0RuTTZHVjBp?=
 =?utf-8?B?eGZjS2lCMngvUThaU3J3KytRMjZuQWQ0YVd4azczenN3dlFNVkhZZmVMMmNv?=
 =?utf-8?B?dHhOUUtIeGhaVllaSEt3MFpraWwzTWovK285Qml3emQwZFd0d3ZRZGtpaTlV?=
 =?utf-8?B?N3A4Q1FaMFR2NXBCTHV0OU9pTFVRTHZPclN2ZmJsdVV5UFlmRjlrY2c5SzRB?=
 =?utf-8?B?UXFTUTFMK1BkWmh5SUlobmU0T3BiUWIwRXVEdG1hMENHd0RGbmlKWFhQbE1U?=
 =?utf-8?B?ZEIxa3FBZ3VZMEFFQjBKZ3hFeVR5Z0o5aVV0eEFmdy8raTRnVUxtaG9ZT0M3?=
 =?utf-8?B?bnlORkluVk9ZTmZuU2tRMUN6YWdHa212RHpNSzhBYm56SkhQcFhLMzR4R0dk?=
 =?utf-8?B?RStPYm1JeHlyeVFQK25pVlo4VmVYSTRqaWxSMzg3K2lHdG1YTkd5dERRcTN5?=
 =?utf-8?B?aldUcXdydnBYQnlOc1F1eWRPRzRGRzFnaXk3OTdsT09vWm5HNk5CUnRsSnhn?=
 =?utf-8?B?aWNqSXJ2U2M2eWtFQkhqS0FFSUlmbXB0R2RWak1EQmVwdUNXTzRRSjFHRGdl?=
 =?utf-8?B?VDJiWnRwdXp5TzFZTlpNRmpGTHhtZFpyemNtVnYxMWVaOXR3ZzVFWllBYWxn?=
 =?utf-8?B?SXd1bmlJUnpOWGwwejErZTExM3VDVVdQSysvWS9qVERpdUcwTzlFb3RCZkQ3?=
 =?utf-8?B?MlJMRDZhMk9pVGNIK2RKaUZYL2FYSmx0emRjUkVFeWJFUUFBSm8vWWJMdUZ5?=
 =?utf-8?B?aEFYZVlXSkN5U3FFZDIvcWo3WWxveG1DY2JselBiMTRPT3I2MTNBU2RmYnhu?=
 =?utf-8?B?K0ExWGFXdjhaWXFicm9zTlVPQmFxTHp0Q1NiTmNTUG5QWW44Q2pwcWdiN2dH?=
 =?utf-8?B?dWYzK3pmMzdwa0xvT2JIbEtTeExMS1ZFOVdkOXB5Tk56cDZqS3RKTFlyeFc2?=
 =?utf-8?B?ZDdtU1B4bVVCKzlJTU01bjcyOUk2RDF1b2pLMTlPMkFJNEYrUTErdmIveGds?=
 =?utf-8?B?ZjFkeEVobll2Zy9QQytGVDk5RnpmUm4vUitjUWhtMGI2eGJSL0dSRjBHdjAv?=
 =?utf-8?B?em9JT2JnaEpoSlUyUTNWRGJKSWZjWHNQQWVVODIyOHBva092REJ1cjlHbnl0?=
 =?utf-8?Q?w8HEJeSnGVGw2sp/rsUbCZ11u?=
X-OriginatorOrg: kneron.us
X-MS-Exchange-CrossTenant-Network-Message-Id: c223021a-f4eb-44c6-f139-08dd78d39502
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB4360.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:33:49.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f92b0f4b-650a-4d8a-bae3-0e64697d65f2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg47pSrYinSE5pMsoHESGIigreHWABTRm6T30ar/yudACKKcN1t5Q++Ew7Mh2iz9+t/Yq1jiTOwQfQOWzza7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR14MB4264

The current implementation of the usb-conn-gpio driver uses a fixed
"usb-charger" name for all USB connector devices. This causes conflicts
in the power supply subsystem when multiple USB connectors are present,
as duplicate names are not allowed.

Use IDA to manage unique IDs for naming usb connectors (e.g.,
usb-charger-0, usb-charger-1).

Fixes: 880287910b189 ("usb: common: usb-conn-gpio: fix NULL pointer dereference of charger")
Cc: stable@vger.kernel.org
Signed-off-by: Chance Yang <chance.yang@kneron.us>
---
Changes in v3:
- Added Cc stable
- Link to v2: https://lore.kernel.org/r/20250411-work-next-v2-1-40beb82df5a9@kneron.us

Changes in v2:
- Replaced atomic_t with IDA for unique ID management
- Link to v1: https://lore.kernel.org/r/20250411-work-next-v1-1-93c4b95ee6c1@kneron.us
---
 drivers/usb/common/usb-conn-gpio.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 1e36be2a28fd5ca5e1495b7923e4d3e25d7cedef..421c3af38e06975259f4a1792aa3b3708a192d59 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -21,6 +21,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/string_choices.h>
 #include <linux/usb/role.h>
+#include <linux/idr.h>
+
+static DEFINE_IDA(usb_conn_ida);
 
 #define USB_GPIO_DEB_MS		20	/* ms */
 #define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us */
@@ -30,6 +33,7 @@
 
 struct usb_conn_info {
 	struct device *dev;
+	int conn_id; /* store the IDA-allocated ID */
 	struct usb_role_switch *role_sw;
 	enum usb_role last_role;
 	struct regulator *vbus;
@@ -161,7 +165,17 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 		.fwnode = dev_fwnode(dev),
 	};
 
-	desc->name = "usb-charger";
+	info->conn_id = ida_alloc(&usb_conn_ida, GFP_KERNEL);
+	if (info->conn_id < 0)
+		return info->conn_id;
+
+	desc->name = devm_kasprintf(dev, GFP_KERNEL, "usb-charger-%d",
+				    info->conn_id);
+	if (!desc->name) {
+		ida_free(&usb_conn_ida, info->conn_id);
+		return -ENOMEM;
+	}
+
 	desc->properties = usb_charger_properties;
 	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
 	desc->get_property = usb_charger_get_property;
@@ -169,8 +183,10 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 	cfg.drv_data = info;
 
 	info->charger = devm_power_supply_register(dev, desc, &cfg);
-	if (IS_ERR(info->charger))
-		dev_err(dev, "Unable to register charger\n");
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Unable to register charger %d\n", info->conn_id);
+		ida_free(&usb_conn_ida, info->conn_id);
+	}
 
 	return PTR_ERR_OR_ZERO(info->charger);
 }
@@ -278,6 +294,9 @@ static void usb_conn_remove(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&info->dw_det);
 
+	if (info->charger)
+		ida_free(&usb_conn_ida, info->conn_id);
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250411-work-next-d817787d63f2

Best regards,
-- 
Chance Yang <chance.yang@kneron.us>


