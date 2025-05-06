Return-Path: <stable+bounces-141791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C968AAC181
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC501BA57C7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0329277814;
	Tue,  6 May 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ixxOhahP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ixxOhahP"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C42459D8;
	Tue,  6 May 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527861; cv=fail; b=YENqstqYLrOm8m3PAUsW5Ki8L2pGlZhnwdNWw5IA4dZhh3rujGcXAX8jbAFjsHFeJhAWEbKEH6PlRTwZFeM3PV3gJrufnJFY1XSYqzy0nfjDBTVo+PYVIbczmWJmvfaLPrsnjuw/TRV3SRIps/qhFwp4Jpk59FXoMCcgOtDw2gs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527861; c=relaxed/simple;
	bh=PwDb9V1xxntD+tHmiD0NMwZqHamUkHkyvfpq0N4708Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PsydU3rFUPY7IFY/WOB26v6Xp1bEBodlpfouB8+7r2xDbluSCdIsrBH/Tzk2NHmCa6Er24ZttY+ptdiml+QWKr0j0/pDWC2GsAYul3ihLQDlA9u+FmPMEXCwZPO0kW6x59MJ4+CeQSxu1yfR53Op0+RS+mcsmMcQYFmXW6xpXBk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ixxOhahP; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ixxOhahP; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=D/wiBbxx6FkyoLjGthowrY+/zMnjcAP691BMVsHeGAp1WRj3fdMZUxi+25ERQ++XvECM0ZMUf8i3EUZrOqIi3cDL63pVNgAuv04x9oX/6hi3Rs2iI890wCXfBVC53RTG9JAoxwWGb4ruIsdVQAvKH94zEfQWJ16UaGDB77bimocbcIqnDCTiyU8x7ZURkNlajv/GKhhU5GZSHXJM2ml0GMslWR8V2TyxU2U97BOU8B3XCbEHAyMndy5B7LjQAc/+WLQ/XVmWcrwffdPpP913duI0FDfeR7stIwEe8v2h/ZTgyOUdA85fe2lwITY7cw/rfzXpQSeB78ybBN4z0ty6MQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ja1UiKQKl8AdLIM7FVmOcqH0Gm1731IjVSlu1kOcs=;
 b=ltwdVKqkWcKALg41GToMf4l/7upBM6r4GNUvI+H/rj3gV1H5eyqqs/bE8fJDeGO4XE60ElMgDx+4/jj9hvFWIpN+5lWKnrZFhq9pfkxkLJRPeBU/llw2PpzG7xHDXG8qWIqZ5vVcHLlcirEv7R9wNDDbDIVGoZd22RvXM9MIjLINjvMIFcaemBZw/rA6EHtpvAmjKC4iumJGdTpLec/lHLgKL/EOBQMDNA9ih0DbJKqQ4xCCue7PDrAJD0UV1HCg9w0Kg0J6+y2gmoETMXQ7vm7TqXX9+2/YCGI/z5rbFPzt314iFmEQWVmgQZwCG9lJUQcmM4AW8MhyVhvscTl5bg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ja1UiKQKl8AdLIM7FVmOcqH0Gm1731IjVSlu1kOcs=;
 b=ixxOhahPyOSTO1+6vXI0vGO+xq4+IfaiwNACFWtBTd3sB4bnsbhyCeWbGW3wvpvTG0QRWFgkTf5WhZYkOU8k5i0kLBo5Z4RitiwnLgWK4GNsD+IoWyif9n0BlBueEFK88EarQk0vVwnkbwhq/7OgeALJmfgAKccbgKnnlQcX8+Q=
Received: from DU2PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:10:234::32)
 by DU0PR08MB8347.eurprd08.prod.outlook.com (2603:10a6:10:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 10:37:34 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::a5) by DU2PR04CA0057.outlook.office365.com
 (2603:10a6:10:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 10:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 6 May 2025 10:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RO8DtL0SC7ilbyqrfumaa+96kFwXtWevEbhyadL4YCW7eIW+853zfN7OExBX8LsUocTQqVYK882yw+tCsgOc5rDtqBCRZZPzb7HRl0EpKYTPwLMT9009wHDjLhGNmsDQoY3YrtoB+4hPi4T5qla5b34IuH2A2byLvHUaX7DPdR7KJXKp8jdFg5a0zfJIdTi0REHRbWdFGpKbdZisPhKDefLg++iiCLD7i5IIWKiZkEDlbSeZWhgpp6YO7eUDlcj4CL76xvKasINTg7CoikcwmTXypLMxOV4SpXlOwvIcmJ2xiNL5hHy9llJmMyCMlGzex3YrLKZb4egXxR1a8F3Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ja1UiKQKl8AdLIM7FVmOcqH0Gm1731IjVSlu1kOcs=;
 b=exoGH/RXGGswQHmuUmq3HbxYmOVg0P+Uywa1pras9laoEkSNc+W3AsiY6wjk2ShNAbi5zFd/1tgSkm07rQfGMl6lwANxQXpquhCxzXzSeHGmKDPRlZhr3xFwgpMZ6OI0BBVRDSePD5nACKpgVb0HM8FQpnoJJBP/iGA26zGMFGyJla0UjyU/SLdbM6fb9olAkDVf16LwOHLenFEwdD2ZFsUwesu29OMilX5/T2LUiVRoJJ22OVne5/3g4rmPN3vCXT0k3bP5XLHHZhbfoKDeJKdQ65/Tg85m8oXrB/nXv87n6nZfOZAucDYSjECS7RFymIhyMu4/lb+4LkcVYV/g4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ja1UiKQKl8AdLIM7FVmOcqH0Gm1731IjVSlu1kOcs=;
 b=ixxOhahPyOSTO1+6vXI0vGO+xq4+IfaiwNACFWtBTd3sB4bnsbhyCeWbGW3wvpvTG0QRWFgkTf5WhZYkOU8k5i0kLBo5Z4RitiwnLgWK4GNsD+IoWyif9n0BlBueEFK88EarQk0vVwnkbwhq/7OgeALJmfgAKccbgKnnlQcX8+Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB10252.eurprd08.prod.outlook.com
 (2603:10a6:20b:648::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 10:37:01 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 10:37:00 +0000
Date: Tue, 6 May 2025 11:36:57 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, will@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnmSTsuZKoxxtm8@e129823.arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
 <aBnhwZKInFEiPkhz@arm.com>
 <3cfcd0c5-79a2-45de-8497-fb95ef834dc1@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cfcd0c5-79a2-45de-8497-fb95ef834dc1@arm.com>
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB10252:EE_|DB1PEPF0003922E:EE_|DU0PR08MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 281d1e93-4afa-4d70-c108-08dd8c8a0326
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jgz/ai0ceI6JgL1NXZpf53X1gIboM4IKzI2XZVzT534qD+EA6KeP4gczaCIh?=
 =?us-ascii?Q?mMcp30FF1Y+1fa9k4ZtoOmnSxNYQkHOij1SLFAKy7AAq14vx4PbucHCxi0dI?=
 =?us-ascii?Q?Z67XMfcYEBXeAEoEDrsK/V5PqSHzyMEcVfqa2Dtn/6lQ14VcM6jU/Z9QN5gE?=
 =?us-ascii?Q?VdZ9yEhl8wIrEnwNkP4Cp9fvVjmaccVnlvW7Q+OcHaCqkZ3h3tRoga7Xl9ti?=
 =?us-ascii?Q?PCyTDLZHQ3B6X/LBriCjpI/QrxHGwXGQ01L5jr61ew0TTKzMqy1+UfUnT+S3?=
 =?us-ascii?Q?bUcQDZV/YF0izBJuDhYacB/lSY9s2CydeUcf75kiC5FsQfeTj3nlxAYHQut4?=
 =?us-ascii?Q?v7EXR3/ZIc/wgdcszU3i+wxtl91JM7w0m6DtGayd55CH3JFhX1cKyHtTH7gc?=
 =?us-ascii?Q?k7OQzelC7PcsrheFQ48oPYHkEoF/ghRxxN3utRZ6SJpq/Hx6W12wJBCjsWFN?=
 =?us-ascii?Q?2jNgly8KTDMy8FdifH3d8nKEN616agI1I7ghCeQ/i7qUZE4xSa19PDIPuAQ/?=
 =?us-ascii?Q?NNQAxfG713+v/ya1hRAodWzm/xbobAvlCoKQUBMUc8IKGIWYmeRpS03PypKq?=
 =?us-ascii?Q?VnQJoth8tgdXBjnRkSl7vjenTwZSUGotDGEk8OBM7EShrn0PBzrm4dnOeARS?=
 =?us-ascii?Q?wpGPMkXLsAs2C/XYiE6BULkvWrtaQwe+VZTKimiIfvVu8XIg3nZ/JaPejiND?=
 =?us-ascii?Q?pWJv26g0W005uqpD42hNE5gjO03xsSbLiDEBuaWLsxQIZQpkB4Q/Q4iKQb3E?=
 =?us-ascii?Q?0DWyBwJAlPRcQNCrk4cDQ/eG318FI6jMl69bpplYj4cgNoiHYSkjvC163aJO?=
 =?us-ascii?Q?gasNkFgdW3yx85wP32Tgqc4JC8SvCzukdhMfTSIaeXwtPW0LXPL7ngDULCC2?=
 =?us-ascii?Q?NoEhSNdxO0d5GBBT7zeV+LadWWAPMHwWvirDZJPUTjB9PyG+idAEiAwhbsdT?=
 =?us-ascii?Q?NDqF7EMmS/ueQ56paFbcZrM/Zxp8rOfKK/G9ax/nMfV1lvHBwFYvrjdH3r0V?=
 =?us-ascii?Q?zjjRvA1hVD3TjihUVEF32bT2ztsf/pq6FWH05A2FqdlMokVBBMrnqQnDXIyo?=
 =?us-ascii?Q?GHA5MBUw9ZijJoVJ3bgs5xN6GFrxdLELK1dfb9xFO6LoIGXKF2IjNn4dECpY?=
 =?us-ascii?Q?IZ9o/jHTaX2mb/wTvT57TjEEUOSWnELcXAMgu1QQ/tD+9RxYexXwKdp7xzUQ?=
 =?us-ascii?Q?tzV+salJM046cg/y+RgjQY2Qa9J8UEADx3sS0DBoPdYoUr3/c0yPTPuM48x2?=
 =?us-ascii?Q?mZn2677fGN9sAEuzDgdG7xV78Lx6iteNIajyUzGwWzwgPFU0LfRDF6PMIh9V?=
 =?us-ascii?Q?k46R1HI6m0RFx7KW9BQ39c2OJQXzamFW6K3nYIa0gqL8d03Bq5qpId0vfhYT?=
 =?us-ascii?Q?3ezSTFw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10252
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a870e7dd-a1fa-4419-9ec8-08dd8c89ef0b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|14060799003|376014|1800799024|35042699022|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Di4g4psIaRc6LctYuALalAvWWm9xPepPE0MUeyzGDuI5khIYwLFaVPnD6Jks?=
 =?us-ascii?Q?sMWFtGmtWOdnRlO1ESKfAR8I/ZHEvHemgktxxmSQySp17Men2ycubsDJOwGu?=
 =?us-ascii?Q?I/I8ShrbEBjMu2fGi1QNpbFDiHPeRsbwGH5jZvKT9JsKrwHu3yF7pdAmYiE6?=
 =?us-ascii?Q?vnvix8Im8be0YBynCswFCHsOnZLX+vTImp6FUzQgaI6sUC3R1eG0g9M/zcxr?=
 =?us-ascii?Q?amMgJOrxuW/rlMIVGuFxC0Gq/y1bnYgPXyZO3AZv7y7ba3nDEHbtACiKRpyS?=
 =?us-ascii?Q?ZOFa3tMLnTh4op/8JEZWqiOPtsOZA8+0NFbaD2wCQRv6YT2VLefl4j9e0/jj?=
 =?us-ascii?Q?D6CfQSMhO9rTfZoYlbwrKIekmzCdbZRu8u1t+cquh5iW8TSg7CWqozgiBFMa?=
 =?us-ascii?Q?nxMiREwQNkAsX5LrNTfFgpOTdaJCrxHxbZH7APvRv0/rj9iPl0NuvrsQwXPh?=
 =?us-ascii?Q?4px6JvdaksMZPuoAyOK3AAxa7wzMgm7URyyjDzX2TgFyYXDunjQGAYsv47D0?=
 =?us-ascii?Q?/rMNIcHTms69vAk/XCMkFrec4BU4AZBLF5dVNueFqUFkDHrlmvdsbPpTLcla?=
 =?us-ascii?Q?YHuu+JytYEb89CO9OhsdqGs9XkjGzOAgdappR20cXJMeF/IRZLAU5p3gsVhn?=
 =?us-ascii?Q?UFLRXUQwoqNe9bxlqcv9U9phQ7OL0/bac3Tq/wtyjthJ49XyyJIccaqFNW4g?=
 =?us-ascii?Q?GgTx3GwMSdloO70MvrV8GzHsD8zGdyLgBebq78bUQJlACFvnxSxorN4f6+WP?=
 =?us-ascii?Q?ZgBVEglwtZTr/MVp7eSGjvhwLntSHrri/tXZ9ol4afmoEBqJ4+dAhmmRdmF+?=
 =?us-ascii?Q?65Ky8/PWyKPhPSIUZ6njO36XfTV2Cj6EfJG8xddO5gbtP7sej4MiMPzLeTQG?=
 =?us-ascii?Q?evYbAmnwXTw6e+/kO3h1/lw9Q+vLt8Zlk6JRZgfGJ1SqdxvsBc3ojGVIcC9m?=
 =?us-ascii?Q?Fm6Gvs014meNmDLLJfBrtvzFagcaeBlSjhOJOcEO7VeUPsax65VIBsU0P5nY?=
 =?us-ascii?Q?0c7MEoUCfKpwlkNU7Vbaonmk+I4VRDa/l8th/4D11G/DCxZ81THuG6xULh0Z?=
 =?us-ascii?Q?l85w10bHv68FUn0wmeL9IzUJ1Wyc/xvYQqyblSddtKsrY66fHWaXPWZzCCbr?=
 =?us-ascii?Q?quDov87KvThGmv219858DBbpKoY1Ie5aUgOHPwqlsbH4NACGw5SpbNw8/pY5?=
 =?us-ascii?Q?XSHEumheiMIcXAyRufQyQPw/f1fPkSvgbaTi9Svt9ZubjWBTLlCEFzs3g4bf?=
 =?us-ascii?Q?Smx7jFPrOgxxLwtzh0NfogNtPaaGKQCCiUNT+x8k+FHqdXZbsuit6onPmSv8?=
 =?us-ascii?Q?xkCCUJ4jj6Yy9K813xTNRPdtygkiHBHOwwz+rFbSCA2SEG6CWpTJPNdGcJrc?=
 =?us-ascii?Q?zrXsz1cxvyYn2VL/nbjij9AvrBKVQwSchRBdcvfCewoL5NjhE0/NVukaHBNl?=
 =?us-ascii?Q?QlJlCSoVh+Lo+c14O7zZKnlUrkAekmIwCsygRBkwLGzEtsmHU8E4wA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(14060799003)(376014)(1800799024)(35042699022)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:37:34.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281d1e93-4afa-4d70-c108-08dd8c8a0326
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8347

Hi Ryan,

> On 06/05/2025 11:17, Catalin Marinas wrote:
> > On Tue, May 06, 2025 at 11:41:05AM +0200, Ard Biesheuvel wrote:
> >> On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>> On 06/05/2025 09:09, Yeoreum Yun wrote:
> >>>>> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> >>>>>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> >>>>>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> >>>>>>>>> create_init_idmap() could be called before .bss section initialization
> >>>>>>>>> which is done in early_map_kernel().
> >>>>>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> >>>>>>>>>
> >>>>>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> >>>>>>>>> and this variable places in .bss section.
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>
> >>>>>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> >>>>>>>> comment, thanks!
> >>>>>>>>
> >>>>>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >>>>>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> >>>>>>>
> >>>>>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> >>>>>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> >>>>>>>
> >>>>>>> $ clang --version
> >>>>>>> Debian clang version 19.1.5 (1)
> >>>>>>> Target: aarch64-unknown-linux-gnu
> >>>>>>> Thread model: posix
> >>>>>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>>>>
> >>>>>>> I didn't have time to investigate, disassemble etc. I'll have a look
> >>>>>>> next week.
> >>>>>>
> >>>>>> Just for your information.
> >>>>>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> >>>>>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> >>>>>>
> >>>>>> and the default version for sid is below:
> >>>>>>
> >>>>>> $ clang-19 --version
> >>>>>> Debian clang version 19.1.7 (3)
> >>>>>> Target: aarch64-unknown-linux-gnu
> >>>>>> Thread model: posix
> >>>>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>>>
> >>>>>> When I tested with above version with arm64-linux's for-next/fixes
> >>>>>> including this patch. it works well.
> >>>>>
> >>>>> It doesn't seem to be toolchain related. It fails with gcc as well from
> >>>>> Debian stable but you'd need some older CPU (even if emulated, e.g.
> >>>>> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> >>>>> Neoverse-N2. Also changing the annotation from __ro_after_init to
> >>>>> __read_mostly also works.
> >>>
> >>> I think this is likely because __ro_after_init is also "ro before init" - i.e.
> >>> if you try to write to it in the PI code an exception is generated due to it
> >>> being mapped RO. Looks like early_map_kernel() is writiing to it.
> >>
> >> Indeed.
> >>
> >>> I've noticed a similar problem in the past and it would be nice to fix it so
> >>> that PI code maps __ro_after_init RW.
> >>
> >> The issue is that the store occurs via the ID map, which only consists
> >> of one R-X and one RW- section. I'm not convinced that it's worth the
> >> hassle to relax this.
> >>
> >> If moving the variable to .data works, then let's just do that.
> >
> > Good to know there's no other more serious issue. I'll move this
> > variable to __read_mostly.
> >
> > It seems to fail in early_map_kernel() if RANDOMIZE_BASE is enabled.
>
> Ahh that explains why Yeoreum Yun can't see the issue:
>
> 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> 		u64 kaslr_seed = kaslr_early_init(fdt, chosen);
>
> 		if (kaslr_seed && kaslr_requires_kpti())
> 			arm64_use_ng_mappings = true;
>
> 		kaslr_offset |= kaslr_seed & ~(MIN_KIMG_ALIGN - 1);
> 	}

Thanks to clarify me to know.
I've misread the address of arm64_use_ng_mapping :( so my brain works wrong.

Thanks again!

--
Sincerely,
Yeoreum Yun

