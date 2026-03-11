Return-Path: <stable+bounces-224712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD28LEuUsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:11:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A75267113
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 036DE300E1B4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E343B9D9C;
	Wed, 11 Mar 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MyAO5RRY"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022094.outbound.protection.outlook.com [52.101.101.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DC332629;
	Wed, 11 Mar 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245485; cv=fail; b=X9yjnMjlSj74NnwpKQVEOz6/KMqNx49dukYxi55HBwYDHmRubxSSb8TU70RuloE9Bhfuv5gygmM6xUwMvNHCt7hWghX3rKRPDP94sWKBnWdr9BzNu6BExxxn2pEvJCvDKKJh5jogadQOQGYiLF4aOth8GamduigyHehKU2cw7tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245485; c=relaxed/simple;
	bh=pcEwg/zwm6blWfPqy0CtmtxsWaHlOfumjOnsbCBAwnk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RkJAjpK+yjt5mkywYz99s3K7vHGbVeeH1G96yPCmqDiri3ZwiyDjaVgrxnTRyCPV2tJCQbbAN/IVAVcyNJRlnfaehK04gbq7ncAdm2BqGGT8K5+XJjKmBS4Njn59jUPYoFUfnTdzwh+XdFxV/XG00f1TiFpIKxQP7rEvDkuUKT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MyAO5RRY; arc=fail smtp.client-ip=52.101.101.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDUcdSzEeS4EBUr9tgVrBtPAgwAypC3LQ4dRbc6d0QRhr4WWiC18V3/RmabF4MVmCRdvovWXdm4l0ANXVJT+YhI5sIVVY7yONO40VayBPwNvvv0zvHRVRbNFJx3o4UC6v4N3h4e7tjrSeVOh1ksCi7xSwl3ci/LerV3ly+eN1cxlRnHUSUCriJWCcPg0cy3c0/18bGVcwPesKkz1gkF9T8wdQQ3E/uVuu0RHgMDV92J2T6dhp+2UkXIkiGtzNfZT59g1lfw7229p2X5Du+6AIp9jIsSA3D7P+uxcPLVtLOkbfvQkfXMzt0LWe9I4cAG/Em2oMjlj7mecrv9jDyQ3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcEwg/zwm6blWfPqy0CtmtxsWaHlOfumjOnsbCBAwnk=;
 b=XJt/ymItALuMEJxg2FwZRKtUvQKDw2rk55+pQkbHochj333eVqbchAESkOAi8TW2dCCRCDt2NverehwkvsuOYnTO6vTmUDnn7sB9H+ChfNopi2EtSyN0w12twHjt/4HWRYuDMM4chWWXF18b5ic9dVV8v1PgtUmMmRIbzj51q5Xolj0Elep3RYcdxP5aYD30h3VpgD9bD/jaehx6/1evswM1U+clLroZcFU7/yOEyF63LTOWapUN0riQpM4h634vEDD3DuATpz/KaKEbJIVW4kz+XYHEBML8fa7KeoxVU/As4q1+WLqYZyRxB2YDTZYT/S2QkPqCOdDcGOHsD5a43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcEwg/zwm6blWfPqy0CtmtxsWaHlOfumjOnsbCBAwnk=;
 b=MyAO5RRY2wXMK104Luhk8/mQVTCJGxqONfZazms51xbmLYOddhs3LRZskEOMIqKR3r2ZS6l3HgthIguR1kB3Y3scFps/zE2DaoDW4x+YSJlbNv/gW8Jp6hU/qlePWu89jZHsdSi0z6NpLIyTHuOH9bifSXdD55k3D2NQ9Dxu9GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5955.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:11:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:11:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 16:11:17 +0000
Message-Id: <DH0326CEAZM5.QD4X3EEWCVKW@garyguo.net>
Cc: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Tim Chirananthavat"
 <theemathas@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260311105056.1425041-1-lossin@kernel.org>
 <DGZZ0XF0YYGN.1W5UIBXK16HL3@kernel.org>
 <CAH5fLgjdiXMf=xybyf+d+_MWYv6r0SSw+dCNKOLoMmxDdMh9Ag@mail.gmail.com>
In-Reply-To: <CAH5fLgjdiXMf=xybyf+d+_MWYv6r0SSw+dCNKOLoMmxDdMh9Ag@mail.gmail.com>
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ab352c-e004-497f-ac11-08de7f88d3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u9lKQBltbJNErjenAjyWRL/WXEKTDgzbU6X9Bz6hPGif8kcszKs2fHgYJnMWwHEvh3rETJMtLYKxs9qNs4sb/aSM9SBrupG71vvHXcNuZFXDSbI8EWWpn+QrT4nqYPKUK/iuZAGFHl/AK0K7tTU4DLfYOpy858oKxZpjO2vkB+BGI4/SXMmimE84652Reg2c3Gp0RwS0rcX5tM+uGacSaYVlOWlR0zBw0MQPA7zUJgkenPz+kN8Ha71djv9YpKTxlhVILWUg0ZPWXhWp1tZYvIsliz/z/+r0jRIwRV79nNcL0eetZlHIk3OAq2jMg1u4nU86hx+aGe/rOwMp08VtV/i/fiyaCxXek/IcfE6Bz1MIVNfMiakcuRVLklWf0HcvQKsWpH6QqdYsy35Gfw8+697OZ4BYauXdLryC9frOKJhucKfyOfI8dwTLhITRICP2xOd8aAZ7MFxJtMdZnewXixM/wEyUu8SCNs3TzsTzB42xE0oyeJUT3IwAAet6wqr8St5x43KQy4Ol1xRZnPTP3uohYXO22AGvzVXyf9xC/BQQWvn45arUSC+gBrHyjWXftjBWgm5p3CPwcs5rT8E+JY6QkhsNIloxRmitIN4nH1o7LE/dTz/5NC5IsqxrNwICDzotvdGfDS6MinaBCsx91U2GALKnXAUsuf4HGxad8XAf3VWzKjXyzMzgf99ciIKTDGd2jnpB5l3RHeHl2d7gWU9JWfnGwNb4gd61YrF4WTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdwc0hHODVYRUxNWjRCVEwwb1p1YkxMSnM5TkJ2TVBuRmFQQVhPcytpNGtw?=
 =?utf-8?B?QURBNXdGWjF5c1hDY3ZxaFlPb0Fqd3BJVE0rZDA1eER2aW9lQ1JOK0psUmJP?=
 =?utf-8?B?bXJsRHhTZG52bDdrREtGVVRENmhFdXlUVWszUEk3dlQ2c09MNElzOWxabW43?=
 =?utf-8?B?dTBPR3BwZ25HSVJlRCtPZU9mWTJaNmFtajdKbmFLYnllYnJ4OGlBWEV2MHQz?=
 =?utf-8?B?UWFlSWY1K3pDTm03a2pUd2Q5MUhHcDRTU1ZqbkN1OUxFajNLdVhJYXNwcnl3?=
 =?utf-8?B?aVlzOUhkVTZiN20wa28vUTRPTkR3cUpsYjg5YnJOdVFEd0M2WllNbm81MzRj?=
 =?utf-8?B?STZTMGtmNnBTM1htaFNMYUF1V005RjBxbmpaRlpCOEdVcXU1YmZWeUJzQ3NZ?=
 =?utf-8?B?OXNibm9OUlBNNDJldDYwS05SLzNLTkMxdS80eXl3amVTcDFHZS9xUmc5R0xV?=
 =?utf-8?B?ek45aUxEakdQTnU3UmdQYkdhMG9vVzYwSndZR1hWbTd3RnkzdnlwWEhyd1FZ?=
 =?utf-8?B?RlU3VUIvWHBQcGJDOC9GOUxvaUo0QW4xZExjTFRGMkJRMitSWm52SlZlRU1F?=
 =?utf-8?B?S3JVZkpyQWdvaWNZbVFBNDRnT0xDYlhFcTIvOGVOc2d1OVVYWUxIOVJTdnNZ?=
 =?utf-8?B?a2lCRExUcTNBc205M2oraUZtcUNwSDAyMDZkbVgzYnRtYWRUS0RKaFBMNmM2?=
 =?utf-8?B?eGcrU3VTcmZuZFdpOXBERmd1MHVkTldWYmhzVE5GK3FtVGxORXFxNGNKVGRB?=
 =?utf-8?B?djdOQkxvZDhpQmtFL2xYalM0UHlRVkFOem4xb1k2TTlTMkkrYms5MnNhdjFw?=
 =?utf-8?B?TEJFdnI4ZWJXYnI0dU9GV0dwTVhUQ2RyUFk3dWl5NFIyZHk2T21TQUxxb2NI?=
 =?utf-8?B?aUtQQm5KL252cUNyZVU2MEZJckd6WE5PVlA5YTNteTZoMGxINmhJSzFsUThE?=
 =?utf-8?B?ak9VNW5FcjhuUTJGdFN4V25VMTU0TmRUclIzOUM4NWNDYThkUnlORW1xWTRZ?=
 =?utf-8?B?Ujl2TVd3MlVkT01pemU5eFY5NHFQbTNvSksxUEcrNjhuSTZDanBZNkpZTFRi?=
 =?utf-8?B?aHI5U3ROOVR5cm92Q0JuWU1kVWZVaHptemYyS014b29ESkVwTk1NbmpZTE1N?=
 =?utf-8?B?Yk9nUk9UWjc5RTE4MW9HbEtEMmEvRjBNdjdwS2t1cXpVK0dtU0s1b0xnTytQ?=
 =?utf-8?B?d052MEwyemRqT0E2RHVkQTd0dzc0SFB4SGxIYW1ZZ0dYSkVGQk9LMVFoYlBj?=
 =?utf-8?B?WXRhL1M5enFJV3pLdVRyaGxDMk1iMGZuQ1Q5OHZxUy9ZZURER2RqUXp5ak1M?=
 =?utf-8?B?ZVZjQ3I4Wkt5Z093b3hoQ09kLys2N3dwNWlSSDhic1VjRXQ2aTZwdDRuRmFE?=
 =?utf-8?B?V1RlVDZtNU9SSmI0d29DNFRwa3oxdFJiVW5GTDRjRnNDTlV5UksvWkRTZzM4?=
 =?utf-8?B?SjJqZm9GelZaY2JzMEw0VGMxT2U2TWpJUVlHUDlMZVZiSDZNNzhSYjVocjhw?=
 =?utf-8?B?WTd0OFNNaVZmMjBNeFdVcUorQ3F5dTczdG4vWStLS0p5eW16N0JCWGswYVZQ?=
 =?utf-8?B?MndPNVVKZzhUMnF2YjFSLzMvUFdRemk5WGNtK3ZFOWZicUlEQ3ZGYlp1bzQx?=
 =?utf-8?B?ZUFaVzZGaUw5REVVelpkSFVYNTdnY09XeFh3TVAvenRjQXp1VUJJcWRxTFUx?=
 =?utf-8?B?MnV4UVdwdnVnaU5Eb3lYRUU5elJhZGhMWkMrb3pHWFlEbVIwbk1LUHRIL0t1?=
 =?utf-8?B?VFpDYkplVkkzWWplNnlpRzhhYWxEZE9SbzRiUmNJQjR6akV0N1l1WXUvdU5l?=
 =?utf-8?B?d2V0NW1ZcjN5QXhOWld5TEtHZDZiTW5mSEc3V1pzaHQ4UE9CQXQ1YkRpYkh0?=
 =?utf-8?B?dVNieldkdmo4VExkZUV2cXExRW9za1VMZURTYnpUNkVBa3F1UENYQzZrQUFO?=
 =?utf-8?B?SDlQQ2lTUEVkMlpwV2ZnU1I0TlJmSDJLNm1vZXBtZ2R4ZzNlZ1Y4ZnI2SHNW?=
 =?utf-8?B?WU9lQ1gvRXI1OHZHWVZLLzFGWFNKWWM5dGNUa2FEbjNhUzJmeE1EM3BpTHVu?=
 =?utf-8?B?cEdlSGZhSDZlVmJHM0hpY2tSRUlXTDNXWnZkSm1XRlVEK0FnenJPcDhHbkJD?=
 =?utf-8?B?ZldBeWlha051NmlENGtmNjlEUlZwUkwxV2RHTndzS0ZQUGFJYnFvY1o3dVFQ?=
 =?utf-8?B?cWJjTWppWXNYeG5kMjE1dmg3eUo0MStsYXVvODI0UXJBRC92MlVQdXZpaWxE?=
 =?utf-8?B?cnd3aGg3ZTFiL3NmVG9ZL2VaNmFuVlNhVVlyN0FXZGxMSytGVFZPb1BHUDhG?=
 =?utf-8?B?TE1ZQmpJNUdsZUU1ZFJLOGJ2UEQwTjkrSG5HdE1aK29QRnZqK0ttUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ab352c-e004-497f-ac11-08de7f88d3b1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:11:17.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMPwZ4/PjrMDJf612AsbM7EPgjRFqAT9XU28Oys9/FJj5hDJCdeFMpMzNcIThVvybSIpsVDz6FLcsGROTYM4GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5955
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-224712-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,kloenk.dev,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Queue-Id: E0A75267113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Mar 11, 2026 at 4:04 PM GMT, Alice Ryhl wrote:
> On Wed, Mar 11, 2026 at 2:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Wed Mar 11, 2026 at 11:50 AM CET, Benno Lossin wrote:
>> > In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
>> > this solution no longer works [1]. The shadowed struct can be named
>> > through type inference. In addition, there is an RFC proposing to add
>> > the feature of path inference to Rust, which would similarly allow [2]
>>
>> NIT: I'm not sure if the sentence is supposed to end here, at least it m=
isses a
>> period.
>>
>> Besides that, is my understanding correct that the changes mentioned abo=
ve are
>> targeting a subsequent Rust edition?
>
> I don't think it's currently clear when/if the changes mentioned will
> land. But on the topic of editions, it's worth keeping in mind that
> macros don't know the edition they are expanding code into, so the
> macro can't have different logic per edition.

Macro expansion carries information on the def-site edition, so expanded co=
de
that originates from macro itself is parsed using the edition of the macro.

You can test this in action by defining a macro in Rust 2024 using if-let-c=
hain
(which is only available to Rust 2024) and use it from a Rust 2021 crate, a=
nd it
will still work.

That said, this specific example is related to syntax, where type inference=
 is
a more global thing so I am unsure how it will interact with cross-edition
macros.

Best,
Gary


>
> Alice


