Return-Path: <stable+bounces-172322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B733DB310A1
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F8A188E34C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722392E762C;
	Fri, 22 Aug 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ore2TusR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ore2TusR"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B722296BD0
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848391; cv=fail; b=q+KKN/kPWBz2yMkYpuW93WUByLafgtVuFLPmbwdJIEGKnwuyVqMw4i6+hJhcQXlDyXqA+Cz7+jkWsG02RbNl1DQHSJLe0yJrvjheL0ajZnDjJWtRyAx4eGGFmQgtZ2BYAvRFHzzg1Tn41qm4VkK8NuEWmZjxCSxK5HGF21v+L8I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848391; c=relaxed/simple;
	bh=UO3pe1EYuuv3e0x4NbJha6PbsBwRHN49pruK0343Tgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSfRnIVoqWRuMnRpHsYfqOS8Jla2DPheOFgRwxSGKYotSQe0HXgy8nYXriaJtpo/+eZCG1gG6wsWJ0rxvDXFlX8D7mpyNz7TBdnbCQPs14CfzfPhWfu4zc9WQq3Cw12+DC0Nq8fA5f9REVZHNlPfz5gMt3uBw4l3UWC6bVlF95U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ore2TusR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ore2TusR; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UcbFncC5jKna8iwEp7PcEK9l8T0ErwAuMDhe3YQseA4kSAKqPYVcP3l91zH01NyyHUM44HmWw/RDtUgeofwXuMZzsywfQ0gdur7mwM1r80bluvZk/TMZ6eLw+GB/XHpTK8aALCrJKabPoqvI1tntZEwjsWGHdes+BQjvoEAw/yw9/2gsgpp2xMQW3DLBTyjibWP77A24yLkCokg/4o18i3KLEZy8onLLlzWht5PYSUabIcWK5T0Lp+j0REz+SnJBjUD7MBpJ3FyDgSbZQMsJKAGetujhkqM4OKP70Bxvv510Us7BRFmj4XBCStQgTXCOI/5D6+U98QlotHMryrnsXA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO3pe1EYuuv3e0x4NbJha6PbsBwRHN49pruK0343Tgs=;
 b=cZw48j/UHQWxPPODYWkBCJCycMkBMmej14U5skWrP2dZ2DnBQPpMQ4fZgOuh1xJ5Dlbn9NAk1QqCiq7eBD1rgzDkKrJKIY4NRzOfGBwlL7NS+2tr5z27VoANoge5qCAe6nuZ8xTuOl5vET9TM9AfcZEQu5+BQQDkAhnl6QsMcWW4q/FTJ2peyKUYiLC061y3eE87gtirO16zdjWnBbzdMTXDNhkjXI14s92fTKBwZnuAQIfAluWW8Y0spll8LOnQz9S+9h0WC5gzOM9pSs6ROaMp/NUuguOayTbkwMniH7WroBYNCxmFzZcBN6X4kxp22WWyOSBam9Z+r71hM9ngkw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO3pe1EYuuv3e0x4NbJha6PbsBwRHN49pruK0343Tgs=;
 b=Ore2TusRZYrPrJTxxsqB0UPOpB5CS3/IvzgvRPe5mEN654nIZTvBzmPRNRX+ROcrPFVVXWuoBRaF0AQ8q5yT81xmMJJFHFkQiO/wazDOCSuxqEY4v/G+DffhfVnJS79vYsq2xHAdkkscrRNuOPQBoeiJlYmixGm4n4UvMv1wSAE=
Received: from AM0PR01CA0150.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::19) by VI0PR08MB10632.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 07:39:39 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::f3) by AM0PR01CA0150.outlook.office365.com
 (2603:10a6:208:aa::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 07:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Fri, 22 Aug 2025 07:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJYlmgTaUbRr/Qz8wKVgvfWMDAvF1XL5YEhh2K0uiB++iZE20kkpD/hurrg8SMLGSRTkTxzW46UDox2D2Oi9XXWEsrwJz3o0i5OnGak/nmoHY8VOobT64tGFD2dPh+IL/LUP+KSWicFCFn+GARKdZddggSY3Kn0rMdKJ/gAldYybySNTzlby55mS2yOLoCiXg9u8rWuJb7mx86bWOacpYZMecR6O3iAr6IrfPZh/vkmofFZ9FdVIE8315KxOsGf18lD4SE0I+7tzkajlxIi5kQgo0S3D+f7nh/KZSr4Tyy2fwzMeqYeJ39FdMpPNtQoObwkqHnk5qVzNkz9MQSicfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO3pe1EYuuv3e0x4NbJha6PbsBwRHN49pruK0343Tgs=;
 b=fUP0fFkBPny5An7sEQPjkeooLg2ckPG+4lh9+M9oTpHSHBgEXH70/U63d8tlLmWqZ1H+ZQ80Hi5Eqf68AI/2vjQCZ3wtoaIuNnLqvbPHAio434MromnOr7w8FJCYLGDB0VECFw9WhH416DiRxJhaMGsnRw0KwOiO9Fcb4FHifzaO1biwuiRzfJSreJALYmPmIe9egTKlI8oecavc2y2wxqrV5DbZ8BK7XGFM/31wK0mdFBU/I6BURw/DEvzOZ94yRubKZ46DCxORRbuNvtcI9GpFBGLdiZOPl58Kx0jEDDy6yFUUYasCXLJ5LJJkJ5AnOuQPfMxV2vGwvI4DPllUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO3pe1EYuuv3e0x4NbJha6PbsBwRHN49pruK0343Tgs=;
 b=Ore2TusRZYrPrJTxxsqB0UPOpB5CS3/IvzgvRPe5mEN654nIZTvBzmPRNRX+ROcrPFVVXWuoBRaF0AQ8q5yT81xmMJJFHFkQiO/wazDOCSuxqEY4v/G+DffhfVnJS79vYsq2xHAdkkscrRNuOPQBoeiJlYmixGm4n4UvMv1wSAE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS2PR08MB9450.eurprd08.prod.outlook.com (2603:10a6:20b:5ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 07:39:05 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:39:05 +0000
Message-ID: <55735a20-1048-4c04-bcd4-45eff0079f61@arm.com>
Date: Fri, 22 Aug 2025 13:08:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 stable@vger.kernel.org
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250822063318.11644-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA5PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS2PR08MB9450:EE_|AMS0EPF000001B7:EE_|VI0PR08MB10632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad62e83-3894-4808-681b-08dde14f0c7f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WG8zeVpuazk1aHJlc3BKZVZlcFhwd0VRdzhFOGc5cDJpL3NOQ080QXhWVTBm?=
 =?utf-8?B?N2RkcUJWUU0xNkVpcmg0YnhRVE5nWG8xMkM1ZnpodkpJejhmZ09IWGFzN1NH?=
 =?utf-8?B?b3lRdzdJazNkemk3ZU1wQWRiTmEvWjJvOUtFVmRad1UzSXRMbVMyU3hiZnFu?=
 =?utf-8?B?aFp1VFV0dzBPNDFUcitwOUpINFBIekY4ZXM0UTBGa21RT1c2TUZiWkZ4UnJX?=
 =?utf-8?B?b1dySFl4Y2FTbUdNYTRjdXpMMis3VmNwZE9xTTNPNERBb2NVT0ROaDVBTzlR?=
 =?utf-8?B?U2x3TWZja1R1QlYxYVVLNUpUaEpDdytiMGN2Z21QcHJZbzErZ1pXcDZwckd0?=
 =?utf-8?B?MXhoL29Nc1UrTWVRNGliaVhpRFZXUG5XQmNvQXl3WHFCY2U2T0tjM2ZZWmxN?=
 =?utf-8?B?Qzc4cHVJWHZEMHFvdzhLSHNsWDZ0TUJDb1lVS29WSjJ2R0czRW1uQTlESVdE?=
 =?utf-8?B?YTBSRzBVb1dyZWtYWXh3SDlRaFpSU2E1b2tGNU9SOGtScEk4ejdyaXlUN1Ir?=
 =?utf-8?B?QU5Lb0xOR21JVnovUmE1bEEwczQ3Tm9Ua3F5NFppOWkvSEJyQXo0ekIvRWtE?=
 =?utf-8?B?QWF2dHhpU3hxeEw5MlRzU1pwbS9HTjU5TktSemt4U2hwdk9yWmc5MUxPdG1u?=
 =?utf-8?B?bWZrQ3hBN1krOGh5TDY3SzJPUFE0cXllRkRRbDV6Wkw2RTBlZ2JNd0pEZ0FW?=
 =?utf-8?B?U3NyN2tVLzI5MzJjcUt6aCtVYmtESGV1VW1FcVYyNUV5eWNmM2NncVpHSjVl?=
 =?utf-8?B?ZThGa2JCV0xqUDRjdjJZSGx2MDBqdVd5SEI0M0xYOWNVUm9vRDNqVFFkbU4z?=
 =?utf-8?B?bDFUdmxSMUtUR3BXME5EYzFJdXJITFhHZ3FJU3ZUSC9rcFFnSVFjNnhhR0lJ?=
 =?utf-8?B?d1E4MEtYbUlDWm0rU1VRTXpGRGplNkh6MGJFTFkydE0vMjRlSHlpSlBYNXZE?=
 =?utf-8?B?dm5nZzhIbnhXeTRMVHl4RVdBaURvNTgyeEJsNW9oZkpPUjhsYmlybFdUOUw0?=
 =?utf-8?B?MDVQMXJtcVZVaWtzVjUwUytTcUpVR2tlNngxZFlUa3Q2c3ozcmo4Nnp2R3Vj?=
 =?utf-8?B?czl3NmZxY2J3cHZwMDY5Y3JRbXBVNEJKYnMwSXcyYTFzbHJrN2dsenVlZmc0?=
 =?utf-8?B?Q0dRYlBRbU9hTHFlbW12V2lieDNRRTNXVlVmakszYlhSV2xxWmVad1E5UCt4?=
 =?utf-8?B?bXE2eXcrU1o3K3B6czAzYWh1aGRYV0xHS05wN2tPS0haTmFESnBDS1U4UC9l?=
 =?utf-8?B?ZDlONGZ1RVNMM0RKemFPbVY1QzJIU1dkdmUzcGVxS2hkendSZVk2Qm83Mmhl?=
 =?utf-8?B?YmxRZk9CSFNKUzZFckVlOTVGVzgrWEliaGxoWEE1Z2hDeVY3OTVBQzIwOUVZ?=
 =?utf-8?B?SlNZVktwMlRmR0VsUTFLUmxvKzlnNnhtNHBIYVJPelhRL2VrZGRjVG1hQjRY?=
 =?utf-8?B?ZlBOUDZxekNDU0FHNjA5Y0ZCOC9CSURiUjZzWjllckw1R2U3Q0tSaHlTQkRZ?=
 =?utf-8?B?ZUJLV1VKdmNpenMzNmtjYjJFZ1dTdFdub3ZSTlZ6M3ZYczNTQUs2ZE42c2hC?=
 =?utf-8?B?Mm80dlZuZWRXcUdBcHlxb2poRG1ZZXNncTgzandIbUZPUmFNWHpORE9hcUJK?=
 =?utf-8?B?RDlhR3NHYmRHeWVpeVJhdWp1UWRWV1o5Wm4ySkVzQ1JlVys2Y2llU3FtT1dC?=
 =?utf-8?B?bk8xa01Ddml3ayswdTEzeGVuMjRpTXRxcWFjbWZTQUJ6Nk9WbW5IbHE0ZzNt?=
 =?utf-8?B?VlJyMWRWVFJyaWhPZmtWZkdQQ01VbzRHRTBDS3F6N29YbUJORU1SRHI2N2lL?=
 =?utf-8?B?UmlWaU1NMHZPa1c3SlNaL1JMR01QMVFybmtoVFlueGZrb1lnMXdsM3ZqbGZt?=
 =?utf-8?B?blJ0ejJIaW1CbTIvTUd3ckFYM09oNStDVmY5ZVVpSm1ucytFS2VZSkFENFlT?=
 =?utf-8?Q?TwQ0K2SYojY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9450
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	313e5e4f-7978-494f-2e8b-08dde14ef841
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|35042699022|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDdQVTczYVFmeDZuMklnZWwzWTNZc3p5cURxNWNxVXJqb29UdldYd1N2OFM4?=
 =?utf-8?B?TzJhMGtyeXBhY3VvY1ExWU9qN2IrS25STXQ3YThUd0UvK1pmMG1EQWIxT1lT?=
 =?utf-8?B?TDVycldjM0VjVlRFMnlQRmhqaHBtNXVDVVpGNzdOMlY2YU9qdVpzcHd4TUpV?=
 =?utf-8?B?Zkc0LzU4SXhzaGM1NVllb0RRWUxKckhJOXE1V1dDZUVSK1FON3kyZlBoMnhM?=
 =?utf-8?B?a2QzWmxGQ255VXR6ZUd2TVZBTEhvK08rTEs0UUNUb0poLzVDREpxRTNQS3JT?=
 =?utf-8?B?dWdmakdvQWwrOWpLMDZhMzRCZWxJaFRWVlpRUUdJZ1V3QWp6dFhYeXB6TDcy?=
 =?utf-8?B?V1J3bFRuaVk0azZSQUgxcXFXcnRPSDhpSnhPdVNBSFJpM1BCVmJuMG1PMkkv?=
 =?utf-8?B?RXNaZXpwU2x1V2VTaTFqbE1mSDZEYmI5d253QjBOdnk2REJJem0wWE1zNGZa?=
 =?utf-8?B?QkRUN0g3a3B1Zzg5aDBpSitwbjRJQkJYWkJPenhUOVZQK09qN1RUL2crUDJk?=
 =?utf-8?B?YVpRTFk4dEhRM3FTdENMNk9wT0hDUWtBYUlCRTU2L0IrWGJqalN6dHVKdTdq?=
 =?utf-8?B?ZnlRK0M1K1hHMkhTREpwOS9xZjF3NUVmNjdkblZ2RFJwUWUzbk56RFMwVHhv?=
 =?utf-8?B?RS9ML3Z1dmsvRTJHMXR5V1kyQldIVU1ZeDgzbXRwby80NkF0UHpFYW12Y3RE?=
 =?utf-8?B?TFZ5d2VtYUEwK25TVG50ZkRuczVzK0ZJVS9Ram1vdFVSSlN3N0V1T0RNVTZW?=
 =?utf-8?B?TlV2aWNaK0toYkZvS2RFRnBuZ241OUNRdjgyd2g5RmRvb2Z2bEsvTWhaZE1q?=
 =?utf-8?B?YW9wRnBWZnhnWWx5SkJBMlZ5eVlWemlsdmdtR0xqN3diblFkYS8xcjV0K2U3?=
 =?utf-8?B?M09DSzBFOEJkOXhTSXRiZ3ZQcVRuUDJEMVFFT1lkSzRobk1vckZVbFIyU0NY?=
 =?utf-8?B?a2h0VDZ0YURCZUVFVUdYSWh2cm1MdHcvaHpFRlpXOGJIN0R5Z2VOMnE3QXhY?=
 =?utf-8?B?cUFjZ1U4anRJS21Za1VhSmV4M3dTRjFoY2NIU2puQmgyOTVEMytER01RRXlV?=
 =?utf-8?B?WVRvMkdMMWhpWWFrMk5rOC9LTERVM3NRY29TemdLOFVWY2hUQ2NhQVZVdG5C?=
 =?utf-8?B?K2dJeVZkcDhCeWM4Syt3M0p3T3cwVm5ka0dBNlg4TFlpVUZpcDZRekRrUUlm?=
 =?utf-8?B?cGNENmNNT0pUT2M4NzhMQ1hkK3hNei9NZDA2L0lhTkNQaGlVSXA1RGVhNWNK?=
 =?utf-8?B?T0Z1MU54Y3hUVlEwVGZkdEViVVgrYjdUUFpiNXEvUGxZOGZyQlVZSWpxaWdr?=
 =?utf-8?B?YmVyaEJ6ZFQwK3YzY2wvT1NZTVloSDR5YlR5QjlJNEk4NXYwd2pnNmxxWWt6?=
 =?utf-8?B?b3hTZ0ZXTGhKMHgwZCtTTFFEOVhzNGhucTJUMzNTTzJaV1FIaGF5Y0hFOW1F?=
 =?utf-8?B?cUE1YVhvckhtU0FLNGdTc2VSU3V5WVAvTzhZMzhjUi9CNEpiS1M0Y2xNYldR?=
 =?utf-8?B?U2hkTFJTYTdWZUJSbUNsMU5mNE81dXNDOTdCSXV5bDdubTJqREt2UExONy8v?=
 =?utf-8?B?V3kzTUtwVVpBVi91VnhBY0F2NDZXYlRRWTZTVzd3OEpuR2JQRk9VZTBNSTFD?=
 =?utf-8?B?Y0QzRk44dEVHZzVjQWw3RDNmT2R4dEhpMUFHZmlEblBOQ0dtSGZCZDJ3cllC?=
 =?utf-8?B?emcyWEovUW1iWWQ5RVBxU2VJM3FsdjRuVEhtVGpXMFZYNWM2aE5Qa2U1clRo?=
 =?utf-8?B?TG5UbTkxcWRuTU1IQk94ekxyYXV1cUZWN3VTbjF5ZFU0aWVSYlhjZ1dUQTFo?=
 =?utf-8?B?N2l0UXVnRjRwTXp0Z21GU1B6SGhTaGJkaG93WVFNVE5ybFRZQzloTENmaVlv?=
 =?utf-8?B?ZmdMVlFsbFMrMmVFbXQ1Uk42RmRjT0RHRzJZYkJVL2UzR2NuTHhDMEh3eHV4?=
 =?utf-8?B?TWdmUG9jSm5qekFvZjhEOGxmUDYzZVVqVDJlMDVPN0xha2FkQzNwQlRpWEgy?=
 =?utf-8?B?eFdYMTljQkdqby9EMTZEZkNoVFN6SDhJUWQxQVRENmVnOHVsc0lUc2V1T3FQ?=
 =?utf-8?Q?qRT4yB?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(35042699022)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:39:38.3975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad62e83-3894-4808-681b-08dde14f0c7f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10632


On 22/08/25 12:03 pm, Wei Yang wrote:
> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
> mmu_notifier_test_young(), but we should pass the address need to test.
> In xxx_scan_pmd(), the actual iteration address is "_address" not
> "address". We seem to misuse the variable on the very beginning.
>
> Change it to the right one.
>
> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> CC: <stable@vger.kernel.org>
>
> ---

I hope you must have rebased since your previous patch got pulled, and
the difference of time between these two events is less than 1.5 hours :)

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

