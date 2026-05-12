Return-Path: <stable+bounces-246681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP+0OI6dA2rr8AEAu9opvQ
	(envelope-from <stable+bounces-246681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:37:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F67452A649
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF040302EEAC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A572BE7D1;
	Tue, 12 May 2026 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rFjN02ts"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021119.outbound.protection.outlook.com [52.101.100.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D5282F2A
	for <stable@vger.kernel.org>; Tue, 12 May 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621740; cv=fail; b=tWER+HAlHOg6Ttrp+fULn9OSvdJ6hupqU5vY8rqn4z0RlUC9WFskYrTL2Zl1FZJ9Q8s17tUNLXignnk8da5EFZBzT8EfawtL2xmVUlz+EGFIlsWTV3P84zAdajfJE+e63LbYDNvaHpfGvz2VJZjvqibNbgFjGbNBChUdhbdZprg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621740; c=relaxed/simple;
	bh=w59xgbt4WKGnGX2L2zJCs42V7491zmSX9qOnQYcefvc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=jEHzRAWX/+DiO4rECgjiyuxB/vQQH5a80WH0UxWr9qo9OGYnybPkRcixUAl3vuFXKJCJHEVHG2InXMzIYZFvOiBu0aIrXLgIjoCrfhzgR7c5oXmgXoU+jXYKnvXAZYidzlWIU1pcOpNW+uqKP7uZPyKiqqIjdANPP3U+/JLcDfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rFjN02ts; arc=fail smtp.client-ip=52.101.100.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux8KfbGnmd1bEXrhdj//GnxCJUtjVZA5Yw9eD8P8kIilWdliHh4ivOm27ClQXoKkpfHuzOTnFAPvmfl8KEZkRNv+8GUO7B8+Vih9qOzdDXC8/U1+GzG0L9kvaLjEiru6dLso8QunhBHuznh+8aAW9P3p3xebL1O92IYpi96q8Hgda3sFAwZ04RWeyRfOoiGG+8b8yptpXQc8GzPoSs1EYkF5yLYISwR2+bh+QxWPBtFMYnMXyVZW/fOPe0GpxbkPhpal9Cg0h5oXfexmJp2gasJhOWN+iVB/G+gMHqEkVJLVw7j4HQ2sebIQXCK0SoS7Q9iIi6qeH9es00jkgV50qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4BoTezCxWagaI4jSDYPmtcqbQw8TgGcE+Zb0Iv8mxI=;
 b=QTV5r5r40HnPHLdEEwJ4oukpnaO/UVLaKUau6W6lIovqa+b1lkoXSEV13X34ONtYq962RXm2KhDAjDE8eCv9DeqE6frkSimkykXfi7/+52+1vRTncuXSRHyX3ryB0NtW1dXH2H6CtUsnPxmxQPCGM1Wl2Mjg9C+PIPmSEQakg0Ep4oBiUejfV07OtBgxIzF91EQnEDjLXQwyVctY4EyACUcOtAVdBdJ8FHcp4Yk367EvyDhWD6ugjNjQrfbpPAa2J0UbnmhlEW39IY7jIDzNXYiXdb5HFWM5QqttTKYR5+/AfMcFA+UXzSAKYbkvfL51SsCLddhrshSECWMcmGRTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4BoTezCxWagaI4jSDYPmtcqbQw8TgGcE+Zb0Iv8mxI=;
 b=rFjN02tsc0Z//HO5dFCvt+VYXZEpF1acKxYnp3nI7M3ufvYC3gMFL1Hc4/MYIwimVQRRBLWYpt3jB8zfuG9nHZz6MnF2EK5yXXT3d0WRDQCly94mZ72dWapZrfkUJBu2XUB1XQRxy1NPtqIGXE+19LBBl2QdyRCJZMbTt+JHiZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB1938.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:62::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 21:35:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 21:35:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 22:35:33 +0100
Message-Id: <DIH0S88MYNRZ.2J6YW6S3CONAX@garyguo.net>
Subject: Re: [PATCH 6.12 204/206] rust: pin-init: fix incorrect accessor
 reference lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, <gary@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <patches@lists.linux.dev>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260512173937.196814135@linuxfoundation.org>
 <20260512211325.316158-1-ojeda@kernel.org>
In-Reply-To: <20260512211325.316158-1-ojeda@kernel.org>
X-ClientProxiedBy: LO4P123CA0158.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB1938:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc045cd-699c-4ee6-489e-08deb06e65ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jV++5MFYKLpTP+YA6edFCdqZASsEXcuHhvQwBBIQwjDxzvGnciWwcqSTtmvGuU6frjML4+v/EuRtJIvegq3FJFN1Ck+iMLq32798/UNdOrVcso4cwYGjIY9PitlcWs8mSgMJ7HlY+823aphWIvvmV6JTVyK6MwAlqplZkGz8+CNwIujc5oA4tzSevufpl+NuJcsRM8yp5VTblQDdeF2JMNT2M72J8FCa2nFUfLLy89EHtB/t0XdgaqJRjuKe6eRXyVzEH3dUeRtRJJ7nhSKShJpO052WKJoHWJgIbqSso8EBETrO/FakPtHoCfzk817IgMn/uUGj+uz6+/97YcmOq+GoNcIx4iMeb8uIMg719vCNLtDi5fQ/LVl3XaOg4ubwSw7aE76auRFA2baOHAtP4RNDwoFH38o6jjFM8H0arXrFmbDonBngP/WLsynw4cZrUFzf8P/KzoKdJyvuJ3+q3g9TV+MfcUQFODmWZZZIjUiFke2mmZ7R5KdBm1VN7wfTjhf1Tb3Iu8WYkzdBEVpNrWskG/6icQz0PCXOoKt9RpLT5E07poK4Rg0uIarB5G4mFQdyBoUxQTmC0FDww5C+xpyWwiCxa+rdYPGOBipoV2VSLoJj5RB1ua6M0dYTjS06hU/2nJTZ862480cGdrJBcyxCC4WcrLr2k62/OXQc4ZfCGulNJXdcoo1Y+1cDa9dW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlIxNytPQUJIbXk5cUdjRmxOQThWVXVHQmc1a25jeStjQUxUUE52Q2lvM1Ex?=
 =?utf-8?B?R2RCcUt0REpzb2lsZ0c0RVVzZ1NYVGU2T251b1U2YXp0MSsrT05EVS9tTzdP?=
 =?utf-8?B?T00rYkpuNW9YcG1aQ2ZYYnZKNWRaM2RoVTMvMjgwSXFmMXdqTmpoYVZkb3Ax?=
 =?utf-8?B?VDMxMnBuMXVQVC91eHBubUh0ZkhKYUFqYWM3T1FaejRQTjlQVmZhcys5a2o4?=
 =?utf-8?B?dkdhYmhJU3luWlZ0ZTlURmVtb1gyelZqbEc3bHlROHBWdjIwcDE3ZXBiNFAx?=
 =?utf-8?B?K3EwS1IyRitaTzJXRmV5N2xaQ2lqeDd6blI1UTRIbHhUT2NYMTAwWUFadldS?=
 =?utf-8?B?NEVMSlhjV3RwSHZKRzRlRWwzK3dMRHpTdXE0MmE1T3IvWEhZTWxEZkFVSno4?=
 =?utf-8?B?RFQvSFpWdm5UNWtHbkZUZUtpZGxLdGM1Z1dTNjlkeVZQS0k0QW0rVHVlanNP?=
 =?utf-8?B?NzJhTUtqYzhEZG1NcVA4d210L1JFcHJHeG10dGNBUE9xTEpsRVF2RWZWUkM1?=
 =?utf-8?B?S245WjlVNEdSMjVsQTBBOXN5YitjQk1EU0cxZTBlWDhSV2hwam9Gbnh0allq?=
 =?utf-8?B?QjVLMFIxaktyVjkwZ1hBWEFQN3d5OSt2eGxTRElVMXR6TlFLd3BabEN3Z0tJ?=
 =?utf-8?B?NjkzNGkvdGRmUjJ4WndjcURvcG9WVUNJdWY4ZGhjbnI1WUdLdTlBUmpUdHo5?=
 =?utf-8?B?VGNFTnkrdUxvbnVkWnpGN0duWVBoVjZ6TnpFdUtEVjZ3bjFWajczWE5IMVo2?=
 =?utf-8?B?WElMUU1FY0kxanUvWDF0Z2RTaHZXZEk2aFYyc2xqUTYzcGVtN2RxSURIUXUw?=
 =?utf-8?B?NjlNTVBtY3RNZ3Z5c1lINmkwaTkxRTZ1N0czeVB2R1BEMlNMQ1NGcjBMYkhF?=
 =?utf-8?B?T1YzRFFJMnRlbVlINDFnNW9naUN4M2tkNXE5ZVdoWjlZZ0dtdkJBRmNoME9Q?=
 =?utf-8?B?NWdJdjFuaytES0pYUXZCQlVTZ01XeXl6Q1RGWktUT3pITktVb2FobEpyYjVU?=
 =?utf-8?B?WnQ2T3ZtNTRNQ1dxenNreCtiMmJ4dVlIOCtYbi9Wbk96OXIyTHJvaFN1eXpl?=
 =?utf-8?B?cnVmWmNHaGNHYjRoeXlWWVR0OU1vZGNoSmpxdzdvRElaVHo3VFNWK0RRMld0?=
 =?utf-8?B?WXNpNTN0SGtXR3dkWkQvL3p2NmJtMGppQjVYRFVnYkRaSXZ4ZW5JZFkvK1pM?=
 =?utf-8?B?WGJud0pnZ1pKano0N0NidmdDOHJDWlM1UEVqYVE1SjVDWHdoeTkvNU1VbGZo?=
 =?utf-8?B?VE9mSEZhQUpIaUN5dm9SZ0RBYTBSTFU5Rm5FeTFFU0tzNE00c1NGRmxGSUVQ?=
 =?utf-8?B?TGVyeWZ1RHlKcnVTb0g4Mnl6blpVSUpsNnozZkQ5cmdNUk5kSWdIbGgzTHpG?=
 =?utf-8?B?V3BvSVZ3T2tnTURTNmFPRzRLRmgxWFlVSmJCYUIvODI0Mm82aktoRXBZb1A2?=
 =?utf-8?B?RHBpME5POXUwcG9ERjh6bHNyVkNycjZXbEFGR2d2VjV4eWFReWFydEdPS0lk?=
 =?utf-8?B?TnhZUkJ3MjMzcjRuTG54OGk2NlcvZ2dHdnZyNG1xSTdMYlA1eGhoUmNZWUZs?=
 =?utf-8?B?MUpoemxVWGhlRjErT1lwOVpPbXB1RWhVdm42OXh2RmtaVXQ2d3lYRFY1bWZN?=
 =?utf-8?B?UVdiUWFHT3JEcGUzc1lMTTJXYnh2NnRVd24yTjlyRnVTdWJQS3RXRW5DYisv?=
 =?utf-8?B?a1BIai9MSk1iRjlkYmVrWDZOVlZYU1R5L0swR2dLdUhBZExlQmdxOEpCM1VM?=
 =?utf-8?B?N284d0huS0FIK3J0MmxoS2Jqd0x0djFCWkhjK1ZPNUlTQmEvN3A0elRsSElN?=
 =?utf-8?B?blZZME5aVXE3U0V2V0RwQktYd1JkamtrK05ka054TVZ3ajFKbnpFdVZ1aE9t?=
 =?utf-8?B?VnZUdlhZVkFibE9QTmFqZ3VHa05vWXVYZjFNNE52cFUrc2RUcGR2TFBjcjA1?=
 =?utf-8?B?ZXlDV2JFZ1JSZjJSWTdRY2NyR00zSkRVbWVLZjBnZGJCamtTUksvWlVuZW9U?=
 =?utf-8?B?T2x4cFY5VFlIbDNNNElQd3ZzMXRtU3lnRXFYSFlKdS94Sk8ydVJtV3YxUjBw?=
 =?utf-8?B?eXF2VGFpVnQ0K0E5UXFSc01xdiszOVBNVE9VK2kvdkQ3Nm9FMzdZUmVwNkdM?=
 =?utf-8?B?ekZ3NmRSQ1JiL1dQdTk3emlMZGNUNHpuNy84N2lzREUrNDMzZjdjckFVald4?=
 =?utf-8?B?UlA3Z1RQMEhpZDQ5SnBDclkybVpwbDd6NS9Ca1p2UUJCVDhLRkRGMVBiQTBr?=
 =?utf-8?B?OEkwNkx4bjVDOGVja1FVV2hHNy8vOFBtTC9CZ3U4ZXpiYVMvbC9kck8wd3Nv?=
 =?utf-8?B?TytONEZVRlhvRk9rM0liTDZLMW14VDU5MnRCYkxpMmFCdEx2elRMdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc045cd-699c-4ee6-489e-08deb06e65ef
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 21:35:33.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8X0H0b3St6mhOXt3Q/hWkWNi3+Q7iyRB74HH7S6IuZXGVrcl4mWyiIpGYI2TyKCEi3uKXQOWOerduyiaRmM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1938
X-Rspamd-Queue-Id: 4F67452A649
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246681-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Action: no action

On Tue May 12, 2026 at 10:13 PM BST, Miguel Ojeda wrote:
> On Tue, 12 May 2026 19:40:56 +0200 Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
>>
>> 6.12-stable review patch.  If anyone has any objections, please let me k=
now.
>>
>> ------------------
>>
>> From: Gary Guo <gary@garyguo.net>
>>
>> commit 68bf102226cf2199dc609b67c1e847cad4de4b57 upstream
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
>> This is caused by `&mut (*$slot).$ident`, which actually allows arbitrar=
y
>> lifetime, so this is effectively `'static`.
>>
>> Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime=
.
>> This results in exactly what we want for these accessors. The safety and
>> invariant comments of `DropGuard` have been reworked; instead of reasoni=
ng
>> about what caller can do with the guard, express it in a way that the
>> ownership is transferred to the guard and `forget` takes it back, so the
>> unsafe operations within the `DropGuard` can be more easily justified.
>>
>> Assisted-by: Claude:claude-3-opus
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I am seeing a few Clippy warnings:
>
>     warning: value assigned to `inner` is never read
>         --> rust/kernel/init/macros.rs:1234:18
>          |
>     1234 |           unsafe { $data.$field(::core::ptr::addr_of_mut!((*$s=
lot).$field), init)? };
>          |  __________________^
>     ...    |
>     1260 | |             let $field =3D unsafe { $data.[< __project_ $fie=
ld >]([< __ $field _guard >].let_binding()) };
>          | |_____________________________________________________________=
________________________________________^
>          |
>         ::: rust/kernel/block/mq/tag_set.rs:62:9
>          |
>       62 | /         try_pin_init!(TagSet {
>       63 | |             inner <- PinInit::<_, error::Error>::pin_chain(O=
paque::new(tag_set?), |tag_set| {
>       64 | |                 // SAFETY: we do not move out of `tag_set`.
>       65 | |                 let tag_set =3D unsafe { Pin::get_unchecked_=
mut(tag_set) };
>     ...    |
>       69 | |             _p: PhantomData,
>       70 | |         })
>          | |__________- in this macro invocation
>          |
>          =3D help: maybe it is overwritten before being read?
>          =3D note: `#[warn(unused_assignments)]` (part of `#[warn(unused)=
]`) on by default
>          =3D note: this warning originates in the macro `$crate::__init_i=
nternal` which comes from the expansion of the macro `try_pin_init` (in Nig=
htly builds, run with -Z macro-backtrace for more info)

I didn't hit this during local testing. Just figured out that this warning =
is
appearing on Rust 1.82 but not Rust 1.85, as I have updated my environment =
when
the MSRV is bumped. So it looks like this is a false positive that was alre=
ady
fixed, but we still need to workaround this for stable kernels.

(It is also puzzling because there weren't any extra assignments to the
variable).

>
> It seems the backport dropped the `allow`s for `unused_assignments`:
>
>> -        #[allow(unused_variables, unused_assignments)]

The dropped allows are for `let _ =3D ` which shouldn't need them.

The newly added `let $field` did only have `#[allow(unused_variables)]`.
Changing them to `unused_assignments` fixd them.

The diff is below which is quite trivial. Greg, is this something that you
could fix up or do you want to re-send a new version?

Best,
Gary

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 661258ba532e..bd9a7fd64d86 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1255,7 +1255,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
=20
             // NOTE: The reference is derived from the guard so that it on=
ly lives as long as
             // the guard does and cannot escape the scope.
-            #[allow(unused_variables)]
+            #[allow(unused_variables, unused_assignments)]
             // SAFETY: the project function does the correct field project=
ion.
             let $field =3D unsafe { $data.[< __project_ $field >]([< __ $f=
ield _guard >].let_binding()) };
=20
@@ -1302,7 +1302,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
             };
=20
-            #[allow(unused_variables)]
+            #[allow(unused_variables, unused_assignments)]
             let $field =3D [< __ $field _guard >].let_binding();
=20
             $crate::__init_internal!(init_slot():
@@ -1349,7 +1349,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr=
_of_mut!((*$slot).$field))
             };
=20
-            #[allow(unused_variables)]
+            #[allow(unused_variables, unused_assignments)]
             let $field =3D [< __ $field _guard >].let_binding();
=20
             $crate::__init_internal!(init_slot():
@@ -1397,7 +1397,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut=
 T) {}
=20
             // NOTE: The reference is derived from the guard so that it on=
ly lives as long as
             // the guard does and cannot escape the scope.
-            #[allow(unused_variables)]
+            #[allow(unused_variables, unused_assignments)]
             // SAFETY: the project function does the correct field project=
ion.
             let $field =3D unsafe { $data.[< __project_ $field >]([< __ $f=
ield _guard >].let_binding()) };

