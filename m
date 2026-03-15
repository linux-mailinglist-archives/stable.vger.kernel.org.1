Return-Path: <stable+bounces-225473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEjoKt7Gtmk3IgEAu9opvQ
	(envelope-from <stable+bounces-225473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:49:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153D291144
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2223013AAB
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323334DB66;
	Sun, 15 Mar 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cp20R81v"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED13002D8;
	Sun, 15 Mar 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773586138; cv=fail; b=VfZOsnHFWR11LjvzhMktN+nBTKmE3Aykab6S7EEnZXhz1TVY1DKZYyrqPjAXMzE/Vl7yoKCgFNQpptOrs+aCzUXQiYDrP+eSXE7uISp4Aum8Nl+4WgQMvgb5cG4dah/2YbPy3pVyHaL0ed9b0cjMndVtnVm+n36M5YCE3u3+1YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773586138; c=relaxed/simple;
	bh=/FZhWuFAGGWsghoU6KZarHsT+BCLY9LCSRpbNKrlOAg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=T+ygGjSxiSv9jYAYAtphVGD7rf4pX8Mc1rHLU6vF1KonRqUZS8/nud+6yGAU5m2q5VzTWtIjtg2frOTEc1zahkikSQqXJgGEYQWkA0SlgflKYmZ9DEgWGGjuwfOaIZ218BQLD/m+TNwIb4gDep/9UAi29c2FWoofwB34bdNUbNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cp20R81v; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1bX16kDPSn3AnFbdNwt1ZoVZAiiLnFV+5FgAl3d68GPIZcYMllYynOZ3QzITJdZPFfX0plgjyfp587i1+m3Iin1Nu1AJvAorLewRlr8r23er/UqHq5IIBWZD7KdOpODJH5oFj13vcdQAZBpyns4SNEqotfwtYCKeeMrfy7T6ZVSSSSDoRR00rxxbD800eqW2Gu4zthPeNESjSQMFPpjUoI49b6sApUugsrbl+42q0C3C3TnDhILMwT7viIYBc8U+Xp3qRQi4E1c72Rek9Oc+PygO7qHXXYz8S3wXozCGG6NpOy2KpgP/oFVl/bCZLmHUTolsPtDscgFxqLMnQ8Haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MooL9FvFtz2rRZBiMsjKCHmD1jZpmU9nRLp0M3qvuco=;
 b=v+7M0lCfC7IOD76BIj86Nux3ATGdiYBXZf7kLQrNahTyw2LAz0sPANUb62oxGO+d28ATY54WuUuqPxMOmQDLIY1WneeiFB1gA+ja52xgJPT5EAb0he14aP9IDRyaZ5y3RoX1SbBmO5WGcvIaGy17bKZnPU2zzaCKy06u0Q53aUq2+WKTqQSvuvn/L4okBU+MW4edAcUxtSiKwmfcnY7raHDXzq9016u6RjdlmhbMcA8vQD2xZWG5RGfdQUu4F/CoK59tPTNp+HEcOKtpSgH1XNCDGOrz4MC6hQoD/2BJhCZWpVTl64SeAbLI/8I5oQcTZEmRlcZ/1rUUjXRBGpuCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MooL9FvFtz2rRZBiMsjKCHmD1jZpmU9nRLp0M3qvuco=;
 b=cp20R81vR5s8P2q0L6lsf2pVZZuDraPo5+gx8yklo/2Xb5YTkp2wkSyS1eQISU6oBHcXi+ms14BRn5cOnPPTSlkHSQVKoBBXX9Jp18aBuBBIv2Q1B/oZCKObpOBXKGTlJbbPndwylwov6aYAY3GGcG1ACMRWbGXoZB/GB4f3Eic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2912.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:172::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Sun, 15 Mar
 2026 14:48:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9700.021; Sun, 15 Mar 2026
 14:48:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Mar 2026 14:48:52 +0000
Message-Id: <DH3FT8ZMGH0T.2NA5M5351UP2L@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Subject: Re: Patch "rust: dma: use pointer projection infra for
 `dma_{read,write}` macro" has been added to the 6.19-stable tree
From: "Gary Guo" <gary@garyguo.net>
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260315144041.25312-1-sashal@kernel.org>
In-Reply-To: <20260315144041.25312-1-sashal@kernel.org>
X-ClientProxiedBy: LO4P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9225bf60-0205-4425-70ea-08de82a1f9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	T4X3nGDrEBcLO/3O70qqT3ALmdjhFrohVVOUSavP8EiqTEqh3fr9tJiYeL0jkVxDU5qnuOfndF/r1trquHnBGpEDzcG0zciwxsQKedmU61sOvb2wVS6d/6jjYSigK0qcatmVrAPxC+ZGtM9XEQ9hF4pgm5KL6Rkuytid0h2k2MpQZQL0P4ctydcZ028wpmVJRkRwENyymQFoyd3yp5oSyQ9ToHc4tAO+mIblYEPlO+3MB87HuGKHlrC/YtTWNsXurIcflVPiBYPFXltRa2PVYrI5WdJstPrItqdwMnaYsrYRsXsNuwCZhsUhQ+9EJMoFbpdsO7ENORLTc9H2YJZfdRIYgW6VBxUbQNWcaJH+3rFFoL45HZgsQVXm17pLlpoVJ/eFsSLKZzCsVOfc/oeT6EACEW4/dlxb6bLipAF4QJ6jNE5OEPvAuD/7ipUJpGg91b33gv2zHo+afTd+o52tL7yLzGpebJd4TDmSmWlfKeXBCYe3CabuCSiyqU7Fhnmj2thVb5N8CCESTy/2VDN1y8jZkL2vtSZAJd0iK8h3r95CyGfkcrTNvS9eUPdONWntwRb3C74wFVA8Qm9qA0XGH0DJD/1iQlL79C8dE5PN67vUbUk7zjrjx0057JMTsM0NhOi7XjubNfr2BmT6vzvBVG61O1uWWtVBMFNvkA4Aq62sDWcjewFwhme/ncF0TVm6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V29GYzNmUm5lbi8rVERUYzUvdngxYmdDaXFyY3p5M2tvcm1GQ25nY2ZLa0Vl?=
 =?utf-8?B?RWxhaDh3VVYvY0tEWmZCM1hpNDZLMmhKMlljckpTcU1hbUd1SSsvNkl2Vitt?=
 =?utf-8?B?WjB5Qk9ub3FyeWRWL2FyY2NvdUhnMkliQUlRZkxTbVJEa2lTbGFpVlpWTXFw?=
 =?utf-8?B?ekZQa3ZLaS9ycWxOMmNRbFBnMUFSejF0NUNwWG50ZDZENms4aWJxSEw4NXlD?=
 =?utf-8?B?VDc1MUd5ODMvRzIzdi9FWmQxTkZ4STJmd0NBdzM0OW5QT2h0RW5tSklSM1Rx?=
 =?utf-8?B?ZVJVWGp5Mi9uaXpiZ0J6eEdJa3ljZnZsUDMxRmthczlCVE1maU9tbGR3S0pi?=
 =?utf-8?B?ZXdkUjg4SFNDVFZOZ2ZLeVMvSXN2RUhyREZhS0hmbE1WbkxXdmozbnBPc1l0?=
 =?utf-8?B?NzBSK3ZSRGJtM1N3dmFrZWkyTnM4RS8vRlNsandVSVFvZi9nSVVNZklWbG00?=
 =?utf-8?B?a2luUnphaEE3SWFKODIvVzRITmxmb3J5dmg5dGZsMFQwaXprcnlONFpoZGlr?=
 =?utf-8?B?bEs0eTRLaDFPeXoxMXVYajBaSnd2eENNQU5vQkdvNm81ZjZEN1FrK0ZPRGlk?=
 =?utf-8?B?MUoxNER6YnNHTXIxNUYyN3ZvTnh5MU5HZWJlSzBoOGRPNDQ0YkkxbTlZTnhC?=
 =?utf-8?B?RFZ1TVpxeDc3VmRJVFpsaExmcXVUMVc4OWN4RG93K1AxWExSY204K3Q5ZTFx?=
 =?utf-8?B?ajVER3dMTnBMeEt1NDFFL1lQR2RUeW4yZXN2VGx2T25rVXJVZGJyd2NYM3J0?=
 =?utf-8?B?dzFhT2dIVS9EbXpOZjJIVm94WGFhK3QvTWhHUVpvdm9FamhsY2drVTEvWlBy?=
 =?utf-8?B?R0ZGdGl3SW5SaXRpaDZjckF0Qmd2VWRjYlI0RUticXdSU0Y1ZmxLVVJjRGhN?=
 =?utf-8?B?d3NRcndGUXIwMmtRUEVFSlRZVkR4a2E2VEs3WU9MVXpNaVN4SnY2bVFiM05S?=
 =?utf-8?B?UkJEdEtseEJ3eXBnVkdDaWRNVUZnbE8yTHI2bmdQM2x1MVZydWwxVDlKVXJw?=
 =?utf-8?B?UTlnRG9DT1BWUzlIeFpPV2FQdERpOW0xdDdQTXV2K3AxMGloL0d4WW5Ya2l6?=
 =?utf-8?B?YTUvcnNoWWRkTlZoK3hlUUxXbk93TDc2dDhUek4zZE56Si9qeStCejBTWGlP?=
 =?utf-8?B?b3UyNkxEZXoyVVUxTmlJencvZHNlMDFCOEJpa1NxckN5bDRTL2loVHRudmdD?=
 =?utf-8?B?eVpXMU1YZDRtQS9tWE94Y1B6TGc2Q0lxMzRxVHd4elFCN2FvTlJudjJVUFhq?=
 =?utf-8?B?RG5DRC83bU5qcEpMWW8wUlJwUnNmUlBuRlR0OEtsTmpCRVVPK2gwSUw4NFZ1?=
 =?utf-8?B?OFJWakk1M21valFQTVRHTWswM2ppT241RDVHLytabGhzSkIzZ3doZStrcmd3?=
 =?utf-8?B?a25ub3JhTXFYZHZVN3VuaFZJTnRCbmN4WVVRQS9DZ0tZWituSng0Y3NrU1lV?=
 =?utf-8?B?RjcyOUREdHdXUmJvTHJYaE1PWG1obi9FYTUrQm8xQ3ZDTEl0Y0dSdmJ2MHB4?=
 =?utf-8?B?YVFCOGV6Q1ZZN3F4OThhbllKRWZKZkN3QnY0UktONm9qOUtqQ2FLdHdpdlU0?=
 =?utf-8?B?eW9MWVl2WUU3RFlMMmtJZGl1bm9kQUFud0F2NWlZQS81a1NqNEI3WVZiZGFr?=
 =?utf-8?B?WXFoRlBYZlBLK0FKWXJFQlhzTWtCVnJOcUgyTFk2blhzNDJWVWhaMUVTS1RV?=
 =?utf-8?B?clJKWWJZaFFKU3FWbUIremlCck9SUU5RVkl4TXdOTmsrV2ZmTlpWZ0VTRm0w?=
 =?utf-8?B?a0Z3UUIwMENua09KYlRpWlpHUHVOaXdmaVErenBobkY5UjlzUEFDQno5Z05Q?=
 =?utf-8?B?K1FYYkswL2pJbVZ0emljWnUxM21oajRNZVRQZkpQUlIxV0krNU5hOTVpcTBG?=
 =?utf-8?B?U1o2ZzVnUjhaQUl6dUQ3MllKY3JnS21odDlPazhjQTZ1ZmxKRDQyUzBoZkxD?=
 =?utf-8?B?dnlRNUNUYTMxY1FmZjdpaytINjhYcnZoczFVY01Cdml1NlJsaGxoZkcrdFMy?=
 =?utf-8?B?TGVqWGZQU1lHUURxL3kzQW1sa2RKc3E2L25Xalp4THNSQndHRFdxdloyVloz?=
 =?utf-8?B?a05MUXplYVpyb084dTVCSmFRSHdWRjdOWEY5KzNKWHI0cVBCcHdFK2NvRTlt?=
 =?utf-8?B?dG1XZ2w2WGhxZnUvNEYwNTRwcHB4YkZpRENYOW42bU1VbkdGVEg2aVBqdHBB?=
 =?utf-8?B?dFp6NWxDaTArbzFFQXlmZHdBTmt3d2FrOHZ5NGNVaElNZ3hIOFk2NTB4V2Ew?=
 =?utf-8?B?Qzd1QTBGMDY2RVArMmMzZXNuT2lrQVlCSXA0MHQ4ODZlNDNQUCtHUUN6T1M2?=
 =?utf-8?B?dkcyQkdpczFxbkttQUNBVndUc1k5Q1NwM1pXUVZ5aC9DeUtyVGNPUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9225bf60-0205-4425-70ea-08de82a1f9e1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 14:48:52.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWqSbaK44XlMKDW8MRvfZFoG/YEv1yV+97Hq4VoWOormu/Cm9GII3juyWUNMByxzWkb1+hoU2Njv4rxU7i4BQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2912
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225473-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,protonmail.com,umich.edu];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid]
X-Rspamd-Queue-Id: 0153D291144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun Mar 15, 2026 at 2:40 PM GMT, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     rust: dma: use pointer projection infra for `dma_{read,write}` macro
>
> to the 6.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rust-dma-use-pointer-projection-infra-for-dma_-read-.patch
> and it can be found in the queue-6.19 subdirectory.

Hi Sasha,

commit 08da98f18f4f ("rust: ptr: add `KnownSize` trait to support DST size =
info
extraction") and commit f41941aab3ac ("rust: ptr: add projection
infrastructure") are dependencies of this fix.

It doesn't look like these commits are currently being picked. They're need=
ed
for building.

They're part of the same series: https://lore.kernel.org/rust-for-linux/202=
60302164239.284084-1-gary@kernel.org/

Best,
Gary

>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 26dd613c37a79884da7fd824263d4c93123688c3
> Author: Gary Guo <gary@garyguo.net>
> Date:   Mon Mar 2 16:42:36 2026 +0000
>
>     rust: dma: use pointer projection infra for `dma_{read,write}` macro
>    =20
>     [ Upstream commit 4da879a0d3fd170a70994b73baa554c6913918b5 ]
>    =20
>     Current `dma_read!`, `dma_write!` macros also use a custom
>     `addr_of!()`-based implementation for projecting pointers, which has
>     soundness issue as it relies on absence of `Deref` implementation on =
types.
>     It also has a soundness issue where it does not protect against unali=
gned
>     fields (when `#[repr(packed)]` is used) so it can generate misaligned
>     accesses.
>    =20
>     This commit migrates them to use the general pointer projection
>     infrastructure, which handles these cases correctly.
>    =20
>     As part of migration, the macro is updated to have an improved surfac=
e
>     syntax. The current macro have
>    =20
>         dma_read!(a.b.c[d].e.f)
>    =20
>     to mean `a.b.c` is a DMA coherent allocation and it should project in=
to it
>     with `[d].e.f` and do a read, which is confusing as it makes the inde=
xing
>     operator integral to the macro (so it will break if you have an array=
 of
>     `CoherentAllocation`, for example).
>    =20
>     This also is problematic as we would like to generalize
>     `CoherentAllocation` from just slices to arbitrary types.
>    =20
>     Make the macro expects `dma_read!(path.to.dma, .path.inside.dma)` as =
the
>     canonical syntax. The index operator is no longer special and is just=
 one
>     type of projection (in additional to field projection). Similarly, ma=
ke
>     `dma_write!(path.to.dma, .path.inside.dma, value)` become the canonic=
al
>     syntax for writing.
>    =20
>     Another issue of the current macro is that it is always fallible. Thi=
s
>     makes sense with existing design of `CoherentAllocation`, but once we
>     support fixed size arrays with `CoherentAllocation`, it is desirable =
to
>     have the ability to perform infallible indexing as well, e.g. doing a=
 `[0]`
>     index of `[Foo; 2]` is okay and can be checked at build-time, so forc=
ing
>     falliblity is non-ideal. To capture this, the macro is changed to use
>     `[idx]` as infallible projection and `[idx]?` as fallible index proje=
ction
>     (those syntax are part of the general projection infra). A benefit of=
 this
>     is that while individual indexing operation may fail, the overall
>     read/write operation is not fallible.
>    =20
>     Fixes: ad2907b4e308 ("rust: add dma coherent allocator abstraction")
>     Reviewed-by: Benno Lossin <lossin@kernel.org>
>     Signed-off-by: Gary Guo <gary@garyguo.net>
>     Link: https://patch.msgid.link/20260302164239.284084-4-gary@kernel.or=
g
>     [ Capitalize safety comments; slightly improve wording in doc-comment=
s.
>       - Danilo ]
>     Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 174feaca0a6b9..25cd48514c777 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -143,14 +143,14 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>=
) -> impl PinInit<Self, Error
>                      // _kgspInitLibosLoggingStructures (allocates memory=
 for buffers)
>                      // kgspSetupLibosInitArgs_IMPL (creates pLibosInitAr=
gs[] array)
>                      dma_write!(
> -                        libos[0] =3D LibosMemoryRegionInitArgument::new(=
"LOGINIT", &loginit.0)
> -                    )?;
> +                        libos, [0]?, LibosMemoryRegionInitArgument::new(=
"LOGINIT", &loginit.0)
> +                    );
>                      dma_write!(
> -                        libos[1] =3D LibosMemoryRegionInitArgument::new(=
"LOGINTR", &logintr.0)
> -                    )?;
> -                    dma_write!(libos[2] =3D LibosMemoryRegionInitArgumen=
t::new("LOGRM", &logrm.0))?;
> -                    dma_write!(rmargs[0].inner =3D fw::GspArgumentsCache=
d::new(cmdq))?;
> -                    dma_write!(libos[3] =3D LibosMemoryRegionInitArgumen=
t::new("RMARGS", rmargs))?;
> +                        libos, [1]?, LibosMemoryRegionInitArgument::new(=
"LOGINTR", &logintr.0)
> +                    );
> +                    dma_write!(libos, [2]?, LibosMemoryRegionInitArgumen=
t::new("LOGRM", &logrm.0));
> +                    dma_write!(rmargs, [0]?.inner, fw::GspArgumentsCache=
d::new(cmdq));
> +                    dma_write!(libos, [3]?, LibosMemoryRegionInitArgumen=
t::new("RMARGS", rmargs));
>                  },
>              }))
>          })
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 54937606b5b0a..38b4682ff01be 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -160,7 +160,7 @@ pub(crate) fn boot(
> =20
>          let wpr_meta =3D
>              CoherentAllocation::<GspFwWprMeta>::alloc_coherent(dev, 1, G=
FP_KERNEL | __GFP_ZERO)?;
> -        dma_write!(wpr_meta[0] =3D GspFwWprMeta::new(&gsp_fw, &fb_layout=
))?;
> +        dma_write!(wpr_meta, [0]?, GspFwWprMeta::new(&gsp_fw, &fb_layout=
));
> =20
>          self.cmdq
>              .send_command(bar, commands::SetSystemInfo::new(pdev))?;
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 3991ccc0c10f1..1cdd1ccfe5702 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -201,9 +201,13 @@ fn new(dev: &device::Device<device::Bound>) -> Resul=
t<Self> {
> =20
>          let gsp_mem =3D
>              CoherentAllocation::<GspMem>::alloc_coherent(dev, 1, GFP_KER=
NEL | __GFP_ZERO)?;
> -        dma_write!(gsp_mem[0].ptes =3D PteArray::new(gsp_mem.dma_handle(=
))?)?;
> -        dma_write!(gsp_mem[0].cpuq.tx =3D MsgqTxHeader::new(MSGQ_SIZE, R=
X_HDR_OFF, MSGQ_NUM_PAGES))?;
> -        dma_write!(gsp_mem[0].cpuq.rx =3D MsgqRxHeader::new())?;
> +        dma_write!(gsp_mem, [0]?.ptes, PteArray::new(gsp_mem.dma_handle(=
))?);
> +        dma_write!(
> +            gsp_mem,
> +            [0]?.cpuq.tx,
> +            MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
> +        );
> +        dma_write!(gsp_mem, [0]?.cpuq.rx, MsgqRxHeader::new());
> =20
>          Ok(Self(gsp_mem))
>      }
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index acc65b1e0f245..37e125bb423ad 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -444,6 +444,19 @@ pub fn size(&self) -> usize {
>          self.count * core::mem::size_of::<T>()
>      }
> =20
> +    /// Returns the raw pointer to the allocated region in the CPU's vir=
tual address space.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const [T] {
> +        core::ptr::slice_from_raw_parts(self.cpu_addr.as_ptr(), self.cou=
nt)
> +    }
> +
> +    /// Returns the raw pointer to the allocated region in the CPU's vir=
tual address space as
> +    /// a mutable pointer.
> +    #[inline]
> +    pub fn as_mut_ptr(&self) -> *mut [T] {
> +        core::ptr::slice_from_raw_parts_mut(self.cpu_addr.as_ptr(), self=
.count)
> +    }
> +
>      /// Returns the base address to the allocated region in the CPU's vi=
rtual address space.
>      pub fn start_ptr(&self) -> *const T {
>          self.cpu_addr.as_ptr()
> @@ -564,23 +577,6 @@ pub unsafe fn write(&mut self, src: &[T], offset: us=
ize) -> Result {
>          Ok(())
>      }
> =20
> -    /// Returns a pointer to an element from the region with bounds chec=
king. `offset` is in
> -    /// units of `T`, not the number of bytes.
> -    ///
> -    /// Public but hidden since it should only be used from [`dma_read`]=
 and [`dma_write`] macros.
> -    #[doc(hidden)]
> -    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
> -        if offset >=3D self.count {
> -            return Err(EINVAL);
> -        }
> -        // SAFETY:
> -        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> -        // and we've just checked that the range and index is within bou=
nds.
> -        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> -        // that `self.count` won't overflow early in the constructor.
> -        Ok(unsafe { self.cpu_addr.as_ptr().add(offset) })
> -    }
> -
>      /// Reads the value of `field` and ensures that its type is [`FromBy=
tes`].
>      ///
>      /// # Safety
> @@ -653,6 +649,9 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for C=
oherentAllocation<T> {}
> =20
>  /// Reads a field of an item from an allocated region of structs.
>  ///
> +/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma`=
 is an expression evaluating
> +/// to a [`CoherentAllocation`] and `proj` is a [projection specificatio=
n](kernel::ptr::project!).
> +///
>  /// # Examples
>  ///
>  /// ```
> @@ -667,36 +666,29 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for=
 CoherentAllocation<T> {}
>  /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
>  ///
>  /// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Resu=
lt {
> -/// let whole =3D kernel::dma_read!(alloc[2]);
> -/// let field =3D kernel::dma_read!(alloc[1].field);
> +/// let whole =3D kernel::dma_read!(alloc, [2]?);
> +/// let field =3D kernel::dma_read!(alloc, [1]?.field);
>  /// # Ok::<(), Error>(()) }
>  /// ```
>  #[macro_export]
>  macro_rules! dma_read {
> -    ($dma:expr, $idx: expr, $($field:tt)*) =3D> {{
> -        (|| -> ::core::result::Result<_, $crate::error::Error> {
> -            let item =3D $crate::dma::CoherentAllocation::item_from_inde=
x(&$dma, $idx)?;
> -            // SAFETY: `item_from_index` ensures that `item` is always a=
 valid pointer and can be
> -            // dereferenced. The compiler also further validates the exp=
ression on whether `field`
> -            // is a member of `item` when expanded by the macro.
> -            unsafe {
> -                let ptr_field =3D ::core::ptr::addr_of!((*item) $($field=
)*);
> -                ::core::result::Result::Ok(
> -                    $crate::dma::CoherentAllocation::field_read(&$dma, p=
tr_field)
> -                )
> -            }
> -        })()
> +    ($dma:expr, $($proj:tt)*) =3D> {{
> +        let dma =3D &$dma;
> +        let ptr =3D $crate::ptr::project!(
> +            $crate::dma::CoherentAllocation::as_ptr(dma), $($proj)*
> +        );
> +        // SAFETY: The pointer created by the projection is within the D=
MA region.
> +        unsafe { $crate::dma::CoherentAllocation::field_read(dma, ptr) }
>      }};
> -    ($dma:ident [ $idx:expr ] $($field:tt)* ) =3D> {
> -        $crate::dma_read!($dma, $idx, $($field)*)
> -    };
> -    ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) =3D> {
> -        $crate::dma_read!($($dma).*, $idx, $($field)*)
> -    };
>  }
> =20
>  /// Writes to a field of an item from an allocated region of structs.
>  ///
> +/// The syntax is of the form `kernel::dma_write!(dma, proj, val)` where=
 `dma` is an expression
> +/// evaluating to a [`CoherentAllocation`], `proj` is a
> +/// [projection specification](kernel::ptr::project!), and `val` is the =
value to be written to the
> +/// projected location.
> +///
>  /// # Examples
>  ///
>  /// ```
> @@ -711,37 +703,31 @@ macro_rules! dma_read {
>  /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
>  ///
>  /// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Resu=
lt {
> -/// kernel::dma_write!(alloc[2].member =3D 0xf);
> -/// kernel::dma_write!(alloc[1] =3D MyStruct { member: 0xf });
> +/// kernel::dma_write!(alloc, [2]?.member, 0xf);
> +/// kernel::dma_write!(alloc, [1]?, MyStruct { member: 0xf });
>  /// # Ok::<(), Error>(()) }
>  /// ```
>  #[macro_export]
>  macro_rules! dma_write {
> -    ($dma:ident [ $idx:expr ] $($field:tt)*) =3D> {{
> -        $crate::dma_write!($dma, $idx, $($field)*)
> -    }};
> -    ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) =3D> {{
> -        $crate::dma_write!($($dma).*, $idx, $($field)*)
> +    (@parse [$dma:expr] [$($proj:tt)*] [, $val:expr]) =3D> {{
> +        let dma =3D &$dma;
> +        let ptr =3D $crate::ptr::project!(
> +            mut $crate::dma::CoherentAllocation::as_mut_ptr(dma), $($pro=
j)*
> +        );
> +        let val =3D $val;
> +        // SAFETY: The pointer created by the projection is within the D=
MA region.
> +        unsafe { $crate::dma::CoherentAllocation::field_write(dma, ptr, =
val) }
>      }};
> -    ($dma:expr, $idx: expr, =3D $val:expr) =3D> {
> -        (|| -> ::core::result::Result<_, $crate::error::Error> {
> -            let item =3D $crate::dma::CoherentAllocation::item_from_inde=
x(&$dma, $idx)?;
> -            // SAFETY: `item_from_index` ensures that `item` is always a=
 valid item.
> -            unsafe { $crate::dma::CoherentAllocation::field_write(&$dma,=
 item, $val) }
> -            ::core::result::Result::Ok(())
> -        })()
> +    (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D> {
> +        $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*]=
)
> +    };
> +    (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) =
=3D> {
> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest)=
*])
> +    };
> +    (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr] $($rest:tt)*]) =3D=
> {
> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$index]] [$($rest)*=
])
>      };
> -    ($dma:expr, $idx: expr, $(.$field:ident)* =3D $val:expr) =3D> {
> -        (|| -> ::core::result::Result<_, $crate::error::Error> {
> -            let item =3D $crate::dma::CoherentAllocation::item_from_inde=
x(&$dma, $idx)?;
> -            // SAFETY: `item_from_index` ensures that `item` is always a=
 valid pointer and can be
> -            // dereferenced. The compiler also further validates the exp=
ression on whether `field`
> -            // is a member of `item` when expanded by the macro.
> -            unsafe {
> -                let ptr_field =3D ::core::ptr::addr_of_mut!((*item) $(.$=
field)*);
> -                $crate::dma::CoherentAllocation::field_write(&$dma, ptr_=
field, $val)
> -            }
> -            ::core::result::Result::Ok(())
> -        })()
> +    ($dma:expr, $($rest:tt)*) =3D> {
> +        $crate::dma_write!(@parse [$dma] [] [$($rest)*])
>      };
>  }
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index f53bce2a73e3b..bcba1a6e6aaf4 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -68,7 +68,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo=
) -> impl PinInit<Self, E
>                  CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_V=
ALUES.len(), GFP_KERNEL)?;
> =20
>              for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -                kernel::dma_write!(ca[i] =3D MyStruct::new(value.0, valu=
e.1))?;
> +                kernel::dma_write!(ca, [i]?, MyStruct::new(value.0, valu=
e.1));
>              }
> =20
>              let size =3D 4 * page::PAGE_SIZE;
> @@ -85,6 +85,20 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInf=
o) -> impl PinInit<Self, E
>      }
>  }
> =20
> +impl DmaSampleDriver {
> +    fn check_dma(&self) -> Result {
> +        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +            let val0 =3D kernel::dma_read!(self.ca, [i]?.h);
> +            let val1 =3D kernel::dma_read!(self.ca, [i]?.b);
> +
> +            assert_eq!(val0, value.0);
> +            assert_eq!(val1, value.1);
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
>  #[pinned_drop]
>  impl PinnedDrop for DmaSampleDriver {
>      fn drop(self: Pin<&mut Self>) {
> @@ -92,19 +106,7 @@ fn drop(self: Pin<&mut Self>) {
> =20
>          dev_info!(dev, "Unload DMA test driver.\n");
> =20
> -        for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -            let val0 =3D kernel::dma_read!(self.ca[i].h);
> -            let val1 =3D kernel::dma_read!(self.ca[i].b);
> -            assert!(val0.is_ok());
> -            assert!(val1.is_ok());
> -
> -            if let Ok(val0) =3D val0 {
> -                assert_eq!(val0, value.0);
> -            }
> -            if let Ok(val1) =3D val1 {
> -                assert_eq!(val1, value.1);
> -            }
> -        }
> +        assert!(self.check_dma().is_ok());
> =20
>          for (i, entry) in self.sgt.iter().enumerate() {
>              dev_info!(dev, "Entry[{}]: DMA address: {:#x}", i, entry.dma=
_address());


