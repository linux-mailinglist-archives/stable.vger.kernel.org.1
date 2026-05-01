Return-Path: <stable+bounces-242222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJjECTHz82mY9AEAu9opvQ
	(envelope-from <stable+bounces-242222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:26:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582624A9348
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B1E301DE26
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A61F2BAD;
	Fri,  1 May 2026 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iax5lwHK"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021085.outbound.protection.outlook.com [52.101.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33240DFC5;
	Fri,  1 May 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777595178; cv=fail; b=ZRJ1Y6UhbyZylz7LeI3AyV0PF4UGiHAA7XVZzRqGrHN8zlfX+IF34MQReXB0yAkdGyiAtwTInB8t/vCIiXyJWFFY9N89pg12bu2ncuS6W6gdk0eFZ5oCE4LPVu1ogSMuIOtFiLAhcFgFI2QCm4L4KtIDxFuFKZblNPVaA30fSjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777595178; c=relaxed/simple;
	bh=hFo6jNwjCloGO4lb7nEVOBlpuaZgzeFcZWu5ktr4AIk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FViRFHNHX1Ua1DjaZbcynxKwO8EvYoVIsbir9quZvKQY6uMBB9qwAr6M6AqBM0AsflkqKKK4vqu2DIYx2VPkR7zsQ76SXN9VNAm/8/GJwdiAKq2dhvu+QcK1/JBIZvO/cDN4J7/kJGneo3MZkgYZ1/UQss8iu+n+Ptb6W9lekzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iax5lwHK; arc=fail smtp.client-ip=52.101.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOCywzzBhm0mLRlNiPb27TvDoBtnOw0Zju+uwFKwCxIUCjd4PVSyWS3q5q0O6V4p8AEMPcc18+lf46BfSnc7QY8vRwXZUb+Ny6A+Ox4JmeT+t4DrVpTYu4uFHaThCpTanB1HykSJaJHjoqPhvVct3TMeAy3kZyxwJzd0WmbQVH8yoMHhVTyXWSRchXgEDuWjM8/bzoOQ44WqsONfneMvwar5XjKjt0tECjmxM4rAlGHGRVLsYFRbXBk80n/QHsLf6jpQBxTi4GhoPZ9Th7hAUBQFnBWwkSwHlChTDqin+bGAS8IFLm6aXeVeh482NPPpdW2Bv9FPiGZyQ8yRjhf3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akFRmVtULAP+R7ZiDL5avPf/ZIsyJuMnh1QK6BbOIYY=;
 b=nuENKhNHE0691btPOHJoE/Hq9GeM6d7AtG1/N4P6krkGybAgcj2SR1aB3aZf7EFvsO2nH/TKbwkH6mX1D4IYj1ClzdLqimliTWO0AIosZUQi+SbNdy0ASIB99QmHb5N7JHqWq5rzEnlzmKFVf4qx8iTGPztBnGbkPfHx4AVCa05QqHOwjreF5F2JOLV7Xp3mYwyhscvE8QZzpFdw+J+WfDw37EYVJGlxf+u59XDu94j74P0fOZvIGAEDz7AfDVSIxsg0WAsCUBx8b6bHQOBks9Oe9+v6WRkz/9nnHb8it0gfOeBGTU6s2+/klBjWII8fkP+czuwxdbIXITjN1lSGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akFRmVtULAP+R7ZiDL5avPf/ZIsyJuMnh1QK6BbOIYY=;
 b=iax5lwHKPQmqYzEHF+uj4Q9StkOHJTZtYdfRsT0fJbBVrZY6t/MGic4K/jNI4thRgCOgTQH+HBal5oGnXZWC1QJfAh7TCx40GWQgYXbU0LwA3yXxvxBMcNrnAIXmt1gX1QN1n/IEdMAqsrKorafWcExiLHlYmhq/+Oc73yq1fNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6138.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 00:26:12 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.020; Fri, 1 May 2026
 00:26:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 01:26:11 +0100
Message-Id: <DI6WWCFCV9X1.3RUBYO7H8KBW5@garyguo.net>
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] rust: pin-init: fix incorrect accessor reference
 lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
 <CANiq72kyqd93wd4cNxRZmWyO7HnGKo31i57ouh5gV5n9jEdu+g@mail.gmail.com>
In-Reply-To: <CANiq72kyqd93wd4cNxRZmWyO7HnGKo31i57ouh5gV5n9jEdu+g@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: ec18f4dc-4056-4064-4afc-08dea7183fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eEubWuwhXA7WsHWFvFJsd5pAW9ZHtOOw6RssV6jnr2LTldBWbJgn/oc2pgD1sEuE01EPO+rmduUQFlWQ9oseWeOAfgKU2GH0zZ+bzAAVGcJWUM53WLNSq7fhPRGwfdHABtZmoWWuwrhrLeu1cX4bNIpm9GZ6XdLrL0XupLzyzU5V58EFKOkG1XBx8wWF31HDwzgrY2BhoZgFkusaAJ5wg7kcIlX+D+oUG7Mgr/fBEKyHS5MrEmPuWeihSEpsnEnSg6zJA+3cJ5JMQgqPs2CeSvs2Ioh160iDuISj2pDCbM+nOJu+WEfZI2rLe1pClBLg8RTkerDamMaElWzNFdwG5XfdUWUCOuXDbxqjJ85/zd+a1NmyeR3ISOaMEmGuApMDY6O6BqYKwdUtz52Go4OOLTUiBvueashJsOSITZSnXzI0N7wkujPn1KuOLoO80839ABcH2QaCxzt8WlbJAd6y9oskx1Vj+Ejl3BbhnpmNcHTMaAS6e9WiGT8qodtQglvTMplkDD4rYWou30o80A11IWxV3r5KEArmlE5ZDUxD6YBMDRhZm0PylSyhesVevliw9gZofO713sFzp6melhwWC44zKQUGWKc1a255IokN6cUU5UbbyAIOgrU0sc0oANLAclDoMUvtxEj795tU+NbW9aqsi4Ncm5MDXeh82yzRfQY5AR+R+I5OXa9MP2N1h3dA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2xQdTZQUjk0cnZtM3JianlGQlBNU0QxRVk3L3FxOTdxNFd2YjVqcnFpa2lm?=
 =?utf-8?B?L2pnMEQvV2hCaGZkbUhaM0NualNPanlRMWptQUF4VktDS001b1FBV1R5bGwr?=
 =?utf-8?B?VDJibmI4alE5QjV0WHQ3ejZEQlBhdW9Pa2NVYUNBcmxFUU1GNGNXenBHU1Ur?=
 =?utf-8?B?T01qQUorVDl3bERWNi9KOWgyY3d4cjVNYXIvNVBiMUJrVytTalFQR0ZQTjlJ?=
 =?utf-8?B?NlJrRU1ScXFFbFllK2xMajkzVDQ2eTk4aER6MnFIM1l6S3RqSERxUHhpa2xY?=
 =?utf-8?B?NW9Dd0FBbG1Bc1QzY2owZnd5ZHkreW1YUEIyc3k3YTNsRnY0cXdGdGp3SnNi?=
 =?utf-8?B?L1NMU0V3RnJvZno5UW1IR3lQYkZvazB1T3dQMjMvcEthSytyclFQWGlSNk8v?=
 =?utf-8?B?MDBQa3pyWmduaEc1dGNqcWVGRFBKRHlkZ1FQOHV6Rk12OTh0dzBRVU8wbEZJ?=
 =?utf-8?B?Tk1FMWx1V3VmNXFRUmlZVE9WS2xyQ29zVnZoK3lOTXI3cFI5MUwySzFEVGNG?=
 =?utf-8?B?ODJvRVV0czlpK3dlVm9aNzdMczR5SzNjb0lNQ2JNc1YvWDVOU3VYNzZybmg5?=
 =?utf-8?B?THpTTVdoVUdlQy9aVVUxMENxTEVSMFh5Yk42d25Iem84UUFMamlxUkVnSk1E?=
 =?utf-8?B?VWkremFRVUp1aUcwZEx5SHZLMEkzYjlZR2s5R1liNVZsYk9SZnJiOEZXS1Ix?=
 =?utf-8?B?UU9JSlJlR2xCQU5JYkRMZGVha2JkNXZqdXpaeFl6d2pDcTFNOVEyQmZ1aGw3?=
 =?utf-8?B?VU9nS0lXd3J6MFlJR2ZSMHNHdzhjWm5kYzhDOXZNOEYvRjczS2ZpYWl5RVJ2?=
 =?utf-8?B?ZGl5NGdQcGhkTVBCbUV5WlJmd2dLbEtERFhuQ1hsNW56L2VHUG9GSGUycUNv?=
 =?utf-8?B?QThZMkhnMDhGRGUzMmZiN05weitwYlZlWFhDRmthVU5VaXNBK2ZOdG9MWC9h?=
 =?utf-8?B?bTR0UGtsVU9TUFM0NEtYanRYbDV1NkUrTDNwNHl5K2gzZG5UWUdOMzdkK0Ny?=
 =?utf-8?B?bE5vNjFzWTJhbVQxNSs2SVZRODRXVXNaYWNQOGg5TDRGeWdVL1luOEwzSWN0?=
 =?utf-8?B?VkRsd00yVmdTUVdjdnhjeUhhVlJ4ckVqNkJVU3UvdUhLRGdBK0ZvWVptSTVr?=
 =?utf-8?B?MVhmbkNGNStVTDRxaEk1SnBJdUc0WEtOQTc2YkN0SzlYY000Ty9OdlIvQytI?=
 =?utf-8?B?NVpPL01obWJnTGNrSXNyaUI2UUNOcnlHTDFTY2RENzF6RWRxSEFpNzlDaXZ0?=
 =?utf-8?B?dERwYTgzVHFzTm1pTkUyb0h6TXBkVGNPR2VmbUJtZmZWTXpRcGJEWU1ISU5F?=
 =?utf-8?B?akovOWZsZ1JydEFWMXEzcUo3SGdkbzBRaHBTTHJWUTQzTWFZZ1FSY3pFcGFk?=
 =?utf-8?B?ZTZBK1E5VDBXQUs3WVA3N3QwbGR1ZFJzdU5KVmJad0cvcjQ0NCtMVnBkejJa?=
 =?utf-8?B?NnBuL2xCZGU5enFjTEQyZVdmOXAydEJwR1N1ZWlRMjg2cGhTQjZETUdmbWRU?=
 =?utf-8?B?UEVYSUR1OFhrMkIvUE1WaE15MGlNUk41NVA1MCtZdnk5U3AvckdwUW1KWkFq?=
 =?utf-8?B?NjVaN1FzRDM1L01rS3VLVWNXZTI1MjQybVlIZ01pY3ZDcnVxN1JQSm5veGRD?=
 =?utf-8?B?T09ZR2xoYm9BdzNyWW1WbU0zSytCS3Fpd2lmT09HdXhnRVk1OXI4UTdQYkQ5?=
 =?utf-8?B?MlE0VkUvNW5aRVh4RnR4aUg2ektZNHBTSGJMSE9iQlBMRk9PdXNLTW1pcUpM?=
 =?utf-8?B?SEgyY2thclI3UG9Pc29IR3hwNVRLRGdJVmhnckEwczMxRWRrdUdVaWRqUG5r?=
 =?utf-8?B?eUJ0WWNpMDBkSVlTQ3ZnenFSb2w0Nm1JSUQvc3I0ZVBKUWErM2NLZE9WV200?=
 =?utf-8?B?V2NtMUhQTHY1cFRCN2ZiaTVVeXpuT1NKc0V0WnpwLzdtZG9vMVcvQ2lZZkhl?=
 =?utf-8?B?WElLN0ZwZFB6MkhCcmJ6UFNIa1V6Tm9HcURIa203MzNNMnB1M012SGk1MXVw?=
 =?utf-8?B?K3E4L3lMaEl3NGE5WE1DWmdPWlVQOGNEbC9NYXBxcmVFSTU1Q2hoSXFLTzJJ?=
 =?utf-8?B?UGxNMit5aC94OXdmYU8zenJ5M0hxa0ZzUlhzaXp4S3NMNk8yR0RTcnQ1RXd1?=
 =?utf-8?B?cVMxUzFFSWJBMnFBQmNmRENlZEFIQm42M01pMWVpbjFXeGphb21xM0x4QmVa?=
 =?utf-8?B?TGNvamRZYW9NRDZQbWVkOHQxWi9ja1hMclhFbXBucHpFVEx4VFdKUnZjTWNX?=
 =?utf-8?B?eVJLbUhyMUFCS0kraW5aYUJ1UU1CTFNBc3g4UzQwMC9JOTR2T0FiNWtudkxw?=
 =?utf-8?B?NzE5SGp0QmRJN0c4RnNXeVJjOHl2am1nY3ZRdjkvVUtzUEEyTlUxUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ec18f4dc-4056-4064-4afc-08dea7183fab
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:26:12.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hi5bqeCVU6Oru7e5yUukCa8u2D0lmelAElEdwFCDFF+ZPbSxCSq+9HQQOvb5zvP+MzMdkvwMJTLW6T8ykU71Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6138
X-Rspamd-Queue-Id: 582624A9348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242222-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,garyguo.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid]

On Thu Apr 30, 2026 at 9:44 PM BST, Miguel Ojeda wrote:
> On Mon, Apr 27, 2026 at 5:43=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> When a field has been initialized, `init!`/`pin_init!` create a referenc=
e
>> or pinned reference to the field so it can be accessed later during the
>> initialization of other fields. However, the reference it created is
>> incorrectly `&'static` rather than just the scope of the initializer.
>>
>> This means that you can do
>>
>>     init!(Foo {
>>         a: 1,
>>         _: {
>>             let b: &'static u32 =3D a;
>>         }
>>     })
>>
>> which is unsound.
>>
>> This series fix the issue. Details can be found in the second patch.
>
> Applied to `rust-fixes` (originally, half a day ago) -- thanks!
>
> There are a couple typos in the contents of #2, but I didn't change
> them since I imagine you may want to do that upstream (relinguished,
> transfer -> transfers). I only fixed a couple nits in the commit
> messages since I assume that has no impact on your processes:
>
>     [ Reworded for missing word. - Miguel ]
>
>     [ Reworded for typo. - Miguel ]

For this specific one it would be okay even if you fixed up the typos, as I
haven't merged the PR yet (I hold up merging just in case you modify the
commit).

Best,
Gary

