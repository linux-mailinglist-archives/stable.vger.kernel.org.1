Return-Path: <stable+bounces-241319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEeDLFRg72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035F4732E5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F7430610FB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E33B27C9;
	Mon, 27 Apr 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="j8/al9m3"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4B2F25F4;
	Mon, 27 Apr 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295145; cv=fail; b=f7Al5Pazpaj0kEKyaHTr0uiq3dpFORl9+vzI5X9Md2Jx/dFgcJYIY2ROIjhdon9zIY6tjOb7/IHCgRijnk36Lv13FS4A8IWr5ETofjFm14nx33Qx6MnH6zYkD2q+xfxl7NC65qAB3b33r4aMZijoD2xWceyn8onxdsHfzU95aIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295145; c=relaxed/simple;
	bh=tMjh59GBH0GPCbjj/Iqx7AsnEivtmDyRmx7nZmMy1Ko=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tXTB41F7pQLuxsAtoQEZQC3xOaJn6BYs2xgAzdtN0E27IeNehMvUNF73La3EDdamMIdi9BTviA5U8rgak25UaRsDYl/AIcW/4qHbOyBClGZXgdgWc9LxiLbLx/cajgeesqPiPlo/E1C0uLhyPLRKCTCUC+JFIMBaXMdAucxK56g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=j8/al9m3; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTI8LFVMgNLrqAjVTZ/KVwk2GTZYlwigYncs1UJCjjlfDxZmUuIGVZdHz36KXnCAmAuHwZOlVS9vZClgsvJtGNJqpfzoRZUcIH9Xz/1WI4vm8RrhcwclZisjpLhdPQ3mElwUvDOdBxQPrpNIv1HampQmEi8W9jdTpqQfX4rm0BT4lUu8jnzDcpmy97WC0VKL3/G7LRfNM/wsoX/+EGmQHJbsTV5x4qVzjub6rnem+Uzb4cPQLP+cBjQ2I8uaRApZX/tRgFHrCdRAY8tY3utgfDtviGc4q331CSPF3KO3FNdK2wj5vVnxjqnLkN4FdriFqGgjyN7eSUKnFzN1qrSpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQhAamIEGtFC3hQ3w//EcKH9XLVJChHlDI7GRTKDovA=;
 b=b66XW+fX0itWFfp0CdY3HG88mgkqQ49Fa4PJGVozBT+QaTLtkLcoDalg4SoIw7ngbZvvp0VCHkp1bwwycYsAFQ8Cd5QBaoYnraAj7ToqqurLfzC0W/qDV2kqhzjcfE0Py84vXmdnviKSe4TWyoh/JUqC3QyIsiD/msEQIjacFKKsB1pXrb1+TIl1oPmfUzMrTb8AVxJTm96iu4LxHTtmGdqZzJXwrHpUEHQWEpm3lj9NOAjVYztUWKdb++/912WF18GP2xWzYEnpdcZ0EAvL/GOWd0Mt8Tapzf+LLD/+iZug5b53K/I8O1oLFPUqP9A3eeYpkMI8VuoIb+apFFqZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQhAamIEGtFC3hQ3w//EcKH9XLVJChHlDI7GRTKDovA=;
 b=j8/al9m3YqSShAB/2WT7wu0MSneK+iczZncMUtqfweWiPWQC72xj4/fF2WzVG419VdO0cp2LytILJN6t+wIL3dqbZ2Q7IUv6FArAmX2HLEbjmJHx+rD0puKwTePcLFA7FmFde6q1sXfgUYMnc6NT2etSNjy7IZBCg0pXWXBViRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5698.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:05:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:05:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 14:05:38 +0100
Message-Id: <DI3YJMZXOAE2.1F2MWADRYBAKO@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] rust: init: fix
 `clippy::undocumented_unsafe_blocks` warnings
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, <stable@vger.kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260426232113.279040-1-ojeda@kernel.org>
In-Reply-To: <20260426232113.279040-1-ojeda@kernel.org>
X-ClientProxiedBy: LO2P265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: f39c77ca-0b51-4eb6-79e7-08dea45daddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gsc9dYpr4L3XRqgONkFgCp210rUuVgEHr1tAJ/exRnAEWGdyuWuN5o8689v5w1RMEAggqG51wQyJdzeLZzzbqnyFNlhpKy2oFY0Ys1opHc9TXBk/ru8xW8DNTs1n4OtGsIzCeMdB3JI/z/o6J9s5jGhybTMtrX/Mz8uYKtM2UFqApGfOP7Fvamh6bRzFGhZtnPoUJkb58xGUAaFXOrmYbgKGZaqFnb4v0E/r/fuecXlT/8vrQsqbs1UP/ZEjS9vv1m24QOyX+RqN7d97mEimQf/pNpcQNEA/4NAGlKqVLIlpYc+Tg3egT3huDZ+J8cfr+rW1QBHr+6kKlnX2uARk//YYpUcxzqG8rEFvZ2kzTP+2N7GuMoF1r8OFgGOksifSux9ijCwg+eY/QLdaBjR6OjxoYPYS4BtJ0O+XUPry4usRkvGkdx7ytDTzZaXvcfsd1CgXELQm3EWYuU6Y7a6AEaKYKvXj2+NM8H9PQd1pU0Bm4xasZ7d2OKUnRPMBaVXEHR3oAIAOyytXaLnNrNCYnojI7rMccrRVw/a/N1NFHfJFsHKo6i+huHWT0b4QAtQlFrb9LVkzvJKASCRsKrcPGyZnCvUi4ZPouNPau9ZNEEnrUnhRzy5jo66hEFlSRhTJ0Osk2YKsWKW0OuuVWucoL9Vx9KhVAMCvXKvuic3QbtLI73VEYoy/ChnJwgBo3/vauiH0OtsXXWxKI36zumyikk44WHNNWCtF//UiNqObR04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2l2WUluUTNhb0pNNXZ6Tkxpd0RPTVh4cHVTRlphTnVHL0ZuYzNNUDRlN1JI?=
 =?utf-8?B?SEJma0k1ZzVCOGdrMEZkQWZzSlJDV2wydVlHOS9UUElrd0xVYXpaYTV1S0F4?=
 =?utf-8?B?UHArbjJpcVd0ekwrbGM0QVM5OFlzaDBrT2g5K05UaHovTS9iNEVFd29GVnR2?=
 =?utf-8?B?dlArd1U4ZHJtZG1uUlVQb1BVaHY0VVZIWkIvUWx2OGxaRThDY0lkYStSak83?=
 =?utf-8?B?bVJkWkpHQjlUT3FCcll3Mmc3ajc0bmpCbjZjOE1kSUxyR2N1ZmJPNnBMaUNj?=
 =?utf-8?B?Z0hmcFplZkEvQnFmZURhS1pqU0twaHdVL1U5K01QM05RYzQreTlBenVEQzd5?=
 =?utf-8?B?aGZiNFBST2hlRVVmZFVPZ1BlTTRnQ1JDR3pvM3E2dktTSTllZFVJQTRueWFi?=
 =?utf-8?B?VmFvT2N5VHFzZmFGaUxRRzYxcDhIWElIWXdSNmtWeWhNcVdYWURaVTR1dDgr?=
 =?utf-8?B?ZHg2SWNNTHp2UHE2Qm9XMGQ4WHhJZWpldWhxaUwxRmttU1hpdDdnNTlsemdO?=
 =?utf-8?B?SzJXaWpzeTdiSWhOS1p1UjFqNHV5dDhVZmZTU2xVbkUvYmlpRU1kTXZNbVZn?=
 =?utf-8?B?UElpMmRsOHFKU0puUW9mU0lwSFJIby9tUDRpVGhqZGtZOFhLMmpLRzFDMDQ0?=
 =?utf-8?B?SGtkd1NUbktVdE5ONHc4azYyZGd5T0NYRHAzVHB1WnE3NzJDVm51NTcyZktj?=
 =?utf-8?B?c3d1YnFtTlhIQ2R4dEFYbGd0UlNmRnI0S255dGRHV05Va2RZUEF5SC9DQmVE?=
 =?utf-8?B?M05ydlUxSUYxRnJrZE9FVWFqRjR4SzdVeUdmYUs3b29NOWszUnJuNjE1ZVZk?=
 =?utf-8?B?WTRwaVlBU1AwMVhrQVkxQ1JXc0k5a1J2Q01ZcW1oQzdyYTRTV2FveHBubDhH?=
 =?utf-8?B?eUxDQ1JlN2t1blJxQTZvZ2g0R1piam9kTDZGcjRLWmNEWVJnSmcxYWo3dXBs?=
 =?utf-8?B?VXEzc2hBU1dOU00ySFlyYjNNdEt6WjRaTE84Qklkd01wdStwcnlseE5iS0Ry?=
 =?utf-8?B?ZHVhTlZZSmpma21aM0ovTjBkblJkSk1TYlFBZTVCY3d3cmVBUG0zaHhLVE11?=
 =?utf-8?B?czBVZEx0U3NFTFc1dWtNdmw1dDBQTDF6dkYzM2pqQWNpOG12cWlzZkFVQkhO?=
 =?utf-8?B?K3pIdkRsMGw1NndkVnNuN2NqS3JYSU9jYWFWYUIvRzZONmxWMSswUVlsZHBJ?=
 =?utf-8?B?S0paLzN2TTNqa084R0xUNkIzNXArUHgrekhlS2hvQUZPdEtoUlBCVktzdTVa?=
 =?utf-8?B?enh0ZTVDajhrU1dhb3lYdWh3MEtLME9QK1R5eG50R255QjJKYjJZNkF6UWtK?=
 =?utf-8?B?K1ErZ2JHVkEvUDJKZ1A4Lzloc0p3UDUzeDFWK2ExcHBSRWoxc0ZIeUh0NzZ5?=
 =?utf-8?B?V0MzWUZBNTNGZ2krMHdoOFFzU0lGWFFyQ3hjSXB2anRaUG9yZjZFN1l3YVIr?=
 =?utf-8?B?S1VOUDkwZVMra0JTZGUvZU5pNFJ5V09PaHRsN3pMRCsycGd2TUhUWjBHSlMr?=
 =?utf-8?B?Mys3WDJEYkEyY3U1ZnFHMDQ0ZXJwYkxmdGVKOWhVTTZVUE1wbGtkRGdJRmV2?=
 =?utf-8?B?TXdsSERDZlpkSXVJZjJBSTNDT3BFUVRDT0k3ZEpRQUphb240SERpMEllVFB0?=
 =?utf-8?B?dUhxSVphdFd3ZlFDUVdOd0xaTW1ZdE5heUxsZlN2Z0hsYTYvUDVVNEc1VnBa?=
 =?utf-8?B?OTJtOStZMmJLOFhmdU43R1dLdGh3VXlWbElUay9wNHpMdjJqeFd0Y2JoRVBM?=
 =?utf-8?B?MkxoTUdxU0pZVmpOYkFhWitQNGtBVzEzVUE4S1pnOFV1TXowOU9tUGRlakI3?=
 =?utf-8?B?aXhXM0V5MkxvSjQxRTJacDdXdXo0YmRGVkZiakhOai93dzBtOVZEVXhsZThn?=
 =?utf-8?B?a1NxVFlXZEZxOEQxRXBUclFaZDRIZ1Z3MGFhNFlSTlVldmJQaEZ3SDYxbkg2?=
 =?utf-8?B?YUlUamozTllJVnRzMG5tYkw0UHJFZ1lZYTN3TnhOZzZKcFZEam5KOVpaYldJ?=
 =?utf-8?B?TGh1MENobEE1SWEwL1BUcUJ5dURDd2MzOHdCdUUvODZJZTIyclF5ZklEZDRY?=
 =?utf-8?B?RlBvM3N0VGI3NDA0VkhzRTkxcFllYzNlK1lGbjVPd1FITlMyalZ4TEFrV0d3?=
 =?utf-8?B?dDlhM3VNMGNQdnhacXZUWEhpdDRwbStUWkM0VlFlSkw3YmhNMFV5UTdNOXV5?=
 =?utf-8?B?SW9HRXJjcTRoYTk0L1cvTzhaazh4Rml0eWZhTFdLNXpzRytta25XYUpVdkZy?=
 =?utf-8?B?VEpkUUJGcTJsbVJNRXo3dVk0dHgwRHUyeWRMNWFHM3NZRGNQTmJDV2R4WFZo?=
 =?utf-8?B?aHpPMS9aV2R6bU80a3k0Wi9YV2xQNXlYRlQ1Rm42U2RpSzE2RG5uZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f39c77ca-0b51-4eb6-79e7-08dea45daddd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:05:38.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKXG5xxnTOv7ZWiQF7KxrGZB/88H9dDdnWZz9jrmxGnCSpeQHvog0aGA5Rdjy2KcJZTu8OGlD5+dwBPalx47xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5698
X-Rspamd-Queue-Id: 1035F4732E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241319-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon Apr 27, 2026 at 12:21 AM BST, Miguel Ojeda wrote:
> The stable backport in commit acc105db0826 ("rust: pin-init:
> add references to previously initialized fields") introduced some
> `clippy::undocumented_unsafe_blocks` warnings [1], e.g.
>=20
>     error: unsafe block missing a safety comment
>         --> rust/kernel/init/macros.rs:1015:25
>=20
> As well as:
>=20
>     --> rust/kernel/init/macros.rs:1243:45
>     --> rust/kernel/init/macros.rs:1286:22
>     --> rust/kernel/init/macros.rs:1374:45
>=20
> After discussing it with Benno and Gary, we decided to clean the build
> log by doing a minimal targeted stable commit.
>=20
> Thus, depending on the case:
>=20
>   - Reorder the attributes so that the existing `// SAFETY:` comments
>     may be seen by Clippy.
>=20
>   - Add a placeholder `// SAFETY: TODO.` comment.
>=20
> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Fixes: acc105db0826 ("rust: pin-init: add references to previously initia=
lized fields")
> Link: https://lore.kernel.org/stable/20260421111111.57059-1-ojeda@kernel.=
org/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
> Greg/Sasha: please let Benno & Gary Acked-by the patch before picking it
> up -- thanks!
>=20
>  rust/kernel/init/macros.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)


