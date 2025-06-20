Return-Path: <stable+bounces-155076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6533AE1890
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4D8189EDCE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35789285CB2;
	Fri, 20 Jun 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QZHYT8HQ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vPioRJG0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C725EFBD;
	Fri, 20 Jun 2025 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413863; cv=fail; b=NlOKCudm1FlqP8cgdf6PmYrWz567rctr5Rg0gFlKK6cT174AKaSxIE3MOTbHsRCysq2631+/77AjQr1i1bHFUiZKdi3XAGUlsgvMZvsGJPJhx2khGYaBobBLkvv3xHKS19SHdvifEgCKWNYmkKHQWo/auGOUPIoOHjsHPj9e0Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413863; c=relaxed/simple;
	bh=zeW0B+jNfh7LHsC6IEWS/5pFgB8/shpmPfnkxVY6jzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=thqqCBiXup/woX3SyKz6BUAv1JRx6MzbjOP0ElfckdsI85A3diR6NvkUWefoG18Qpg0f7NRo0Z0oWtVnrxthb/+0hn1YJBkHFBUoFTdH5T5qCp89qSXmb4VQOwgxuXbiV8/9wXZak+7nRfV5jgOhkdLXshZZsIIASpFFxjX5YGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=QZHYT8HQ; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=vPioRJG0; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K03Tdi024351;
	Fri, 20 Jun 2025 01:23:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=2jKYJXpSioXel6DUkEKhym5d6FRY+I6LymLJBOa4KAg=; b=QZHYT8HQfYRm
	7E0hd/P82CfqgSCqkrTlE/qBzZuUMeE6f6SiVy5Ur2e6W1PAo5IVW/HVYzANJ3fS
	b8zThRzZjIiwh5I6Y37i9GsGEardlrWjfCRpTgq0aZYBg2OAT+7mSXjLE+ZYNUAO
	B+Ufaz2ieTPI6jLcvQhAvt2sjkcZAVm2CDaYZ8J2Q2qArRTtaOiLOUXHNHplNVpy
	ClCjcDJyX5nt7JHoWX5Toje3U7l9DO2YoXUmSB4CqFAHdzPwwNoFjoxLIijIpaJW
	U/L0TNzRBogRiOWPznQjT/Y5fLl9wI6V6EYpuyi2P51s5DCGsonO3E8SBTZK9sNO
	yaPYbPJUDQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4794p03aq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 01:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyk249f7SB325q3FnMxv4Eedpci5yzsC2Xs8fsxDIDeEDfugu7km14jApEiuFCkrhH1gx885CBS5ZSFQJ7x/OwlczEZ8ixX1gDeunb1V7w0r6EaGDgqjQVzzH/QKj5t2mVMV0B1nKWxzRC3JMZBfcclhL1+RyVrFzc1cpyG4Aw42kignJfjqiADJkFAPIgjUaQ9guwktB5X07NHYsmM+7iuZFPsVFzRlj/DP72RbYBTjxpOPII6yB5SxQSA2Px98W9byN0PM0hTJBgm15WFOy3o5bEeTbFZd4W4wATt7UcAtEggGHSRuvlitfFT8GaikkIsqEaeI35DyOrDbS5qq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jKYJXpSioXel6DUkEKhym5d6FRY+I6LymLJBOa4KAg=;
 b=ivIErbCIJtCFgC8HTHGBz+1Civ+1fLzcRidGTiws0644l1e5GuQgBQtuxBM110HzkzJcSQV//R1qdvC5gk4/GdQp4O7s3B/H63A+d75NmfdZaYdoTzCe5j1edIuezRfIojXijp8aGfeqPzwaFKR7tzIwJPLX+hYErHycFKylXPPPiRiouW+wad4/lyq8FD5Y5ZjEfTz0BvUB8gkJk5CNp9jyBvsVtc/14AjUv787DESpnwq95n8E8KZJADascMoCMXgoyPrpjEVOWMOQCLjfWTVqBpegPekIuBmL+At9Yd/zReDlAqTzWyo0zj99KwKCe6D41OY23b7c5wvf45YJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jKYJXpSioXel6DUkEKhym5d6FRY+I6LymLJBOa4KAg=;
 b=vPioRJG0+DA5KTq6ZyaDXibWSxu9VejjU1nAQ7du4Wp4EDeqiwGOd1xlcRm2pHLfr8iq6IyaygYwGPqDDDSrGepgBZGjTm3FnbNYnU2kq0qzS1nQU9IoVKjFAb3cIjkgTv/mair7M3pJXEXaOFdwLGN+w5JjbjT2hrHcyP8XQvY=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BY5PR07MB7251.namprd07.prod.outlook.com (2603:10b6:a03:20f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:23:13 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%6]) with mapi id 15.20.8792.040; Fri, 20 Jun 2025
 08:23:13 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Topic: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Index: AQHb4byQPqa7j5J6MUG7SRmJB3iE/g==
Date: Fri, 20 Jun 2025 08:23:12 +0000
Message-ID:
 <PH7PR07MB95382CCD50549DABAEFD6156DD7CA@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250620074306.2278838-1-pawell@cadence.com>
In-Reply-To: <20250620074306.2278838-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BY5PR07MB7251:EE_
x-ms-office365-filtering-correlation-id: 19fdbc55-edbc-4db2-b465-08ddafd3b2ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1Y+7FHgelNRpCT/HhCgOPlA8WE0I5kgXFIkfQQIZmoVj2KN4io752vOf/tz/?=
 =?us-ascii?Q?x6dvxfD+3X2mxVTyWc/P0LLR7v71aYro4jOSuIF3v4Kj74z9hpTPndMsps1/?=
 =?us-ascii?Q?4HpatwRcVO2z76Cpk1k00jXx8rCfqDPkkTriJippmdZKjdJgRpXvpjg9PaJf?=
 =?us-ascii?Q?QQ3M7lQldWV1mZPSrJuwE0TnVbwrVwRQ3mmJ5EaHNZyEW/efZFYcJtQizhJY?=
 =?us-ascii?Q?GCmoUW8yiEkizZMiJpx4J9YO7hr8tKVPEbPzr8oeEibUWkUpgS7IQO7xQFq8?=
 =?us-ascii?Q?uZ85BWnnKBTHuxXOvWX2tHRh4v7lzIpaIM91kHvFZ0TwIdWt89FCUBqEJFY3?=
 =?us-ascii?Q?LRszo57S4qyLvgCCxdr7i0yzPtiIsK2NjbeCz//SKykU14O7MQWUVFytMwn0?=
 =?us-ascii?Q?8ZJ0DenjY44V/EcrEgRe5NyShwcP18KcBZwR9TUH6HF5voyvwjSkA7SGg3zI?=
 =?us-ascii?Q?yw127ssPUyAPVADf8tJNWdvzRCCmXeZ0byeMFozIGtdp1FjQ10sisruW6JNn?=
 =?us-ascii?Q?F1ulpha+7pztJsEvaAM9eUvecWC70Aui7B/DJ+6HAPRg9AA0iAzaeRftBJz/?=
 =?us-ascii?Q?61ts9UIjlTGr3IVdFlE3vviLKRlBj4cYuWylmrACKXUx5TxyqkUOfguq8CBu?=
 =?us-ascii?Q?pQwVxb2kV+zqfFF8ou+hGn1YGNWuhHrcztiYOj6XoNK6ZW8e4PutVCRbqvUP?=
 =?us-ascii?Q?+cE5g5GYVhCkCi3RNXFoulFV1sCaTVmEssUYsfmMukBAxQN0js/7Eng8+25w?=
 =?us-ascii?Q?kWlFWHhKy8OBhwj3iw5pVEva2oOscNyiM2jLxPuM7+e4nhfUV2RF80C5hPBv?=
 =?us-ascii?Q?JmuncsHEYZ/2Jf54heneDH/P3ePH345N0NxlqzLYzfMX9iSgwo154tsNqw8b?=
 =?us-ascii?Q?+bPeaSTuD8cG/NsyFaTfExaQ2Zk8xyQcOsslU2GNNM/9l0ynNVGAKmK5Dgna?=
 =?us-ascii?Q?2rynDYhzfa7j15pkrCCfLUZUmwaPT0XwLuIpg9juTH/aRMCWYn8zu5RbwGsU?=
 =?us-ascii?Q?ka5zuLGAB6oRkM3u9Hqfk4uJShHB1djMrEnlH2b67FFaGoedtB+lbj1zeJtR?=
 =?us-ascii?Q?OO0Qkb4g3FMPbxfJuAbhT6mfey6gOwTqrNgQsxPAJu+XZP3SkVt60yFYgo6o?=
 =?us-ascii?Q?bI/PGXrtX0OAtqWk9spR613z07sy3GSPQnx/4711pKEs0ybfx2umS8XacnWI?=
 =?us-ascii?Q?4A9dwI0g3gqYlXW6w+Ad3EPAWHF+NSc2qbd1IUOHBEsSVCEp0fGjj6zXUTa/?=
 =?us-ascii?Q?kVGZkY3+0Gn2L5vunt/U3LDR+ZzpkSuTA3iFkciS/FL7qbQM4GI9yt/WoqSl?=
 =?us-ascii?Q?tL+SADH8OkE/O+u1jye5rh6VJy+MiWWkt4KzCoJLyQ/xgRKXIkCS2zicPRmk?=
 =?us-ascii?Q?zxscLN2rEAI6iTmtJP2YWrb8fyL2P4FA9tCrdyG0F8Ry452GAjjozI21BRiY?=
 =?us-ascii?Q?2p7P5pjLlMG9hUMFA7KWmQYiijnIsjyylRHRtXxTKOSIv7usVqHevhn7ZKdF?=
 =?us-ascii?Q?eWmsrjo4hmnIo0w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tuIm5PS9lPanUGY+/49FmjMfIvXDAHnUyrXMlMI8jD4HCAYPkkS3JbmwDZ5U?=
 =?us-ascii?Q?tAyoQd/YLjcoCjFte1gCEwGoPoKjsmwbm+1sRuFJerFTbAJqFRzv2WVHCsNz?=
 =?us-ascii?Q?BoHR1USvKN44aj10mluV6wTkYblS4jCTBND0oHjmsq/v5BZzvo2w6BjKEji5?=
 =?us-ascii?Q?3ASh2q4CEC5NUPP8YTupY83+iI+x0bgfi5PmafJreN97Si3Jy+qXPvqEwobj?=
 =?us-ascii?Q?+Cg3TZvER38B6eEHPM3Tpd+U1XxIWT6w5W7mO6O3HcAo2yF+qE8X5xOtOT44?=
 =?us-ascii?Q?bhUQXAcq6c1z3y7Rz5l/CzKfTdBaFd6RBKlCe/w1m5cq2PkpU3TXcgzpfDTC?=
 =?us-ascii?Q?75XEmPLC6XiGz2zUgTFdSbJ/5dBZq/jKBvuh7sfRj+eKHEnDpdXyxgE3PBrw?=
 =?us-ascii?Q?618BMulfUuQfJPAdCO8ljf84WWZIssUlI0yK1AJ+xzm9c9dJjckl6Dj6teE2?=
 =?us-ascii?Q?4BfQXUiKaMqvxYI3DJBS6Hef2zKYQEVYqfITPzC5e+nVVVDT0kilhQWzTpSs?=
 =?us-ascii?Q?uWoY3IlbnhMwtrATds3hCu/1SDwlg6CDioeLYClsUaqL3+vc3TlhNylPPMzO?=
 =?us-ascii?Q?FgpSwNUKlbRpT89WMIQIJeGUuxKXdLiUFkOQmRW+vASV0n3RX2s8PJ9VxfQY?=
 =?us-ascii?Q?rLNVC5gRJecsNYqPN4W0PXhsGOmObzoLAPzvqWMdYQfdoDcYA9gebcfOtSCe?=
 =?us-ascii?Q?p9MsGAZWjv6H9KQnm1W48xvoTRjakt+nqoKWknEEM1Th2lJl//t9MNYuKcG4?=
 =?us-ascii?Q?viV7zDOAV2APSU0E7xcjVdCUEAhr5q8wgM3SKWhdWiNDqNc0QG7PCvZN7RpE?=
 =?us-ascii?Q?qVlixD4kVEqRhHlooSkumFKTiN9uyig+y4XcX6Ti4r9Bs8Jo+dLahm+tmoS+?=
 =?us-ascii?Q?vybq0vEttl8GHhHMqk63jtJBTkSGXsUQ2dBxe5PxFsROkRPApa/9QeAf6gUR?=
 =?us-ascii?Q?AdOJFjDrPikI5dXWk3rv7cKoUhNFTKalgjf//lvXcljLiQ5eZMaDCRWvhZ+j?=
 =?us-ascii?Q?yMrABlAvU/Ws2R4mGOpbykPurXzfjS2Wyj9Dy+sSFdz0rFxWCEsgubRFYjr7?=
 =?us-ascii?Q?aCNBfn4yNlk+z5MbYX24T0uEvJObkGRN5fkDsfhmxj0VGEPgwOs8FlJ5ovdF?=
 =?us-ascii?Q?3aNSkTLyhtjsg4nXZzmHTRCuXmuaaQ36l7yBPflZhU3zRjVec2H7bVzgEOhF?=
 =?us-ascii?Q?S3v/L2XTvqhgca82Rem6Ih5S/xFQKafQebqmCpIjLHqwgFr2t4CgG2YYR54D?=
 =?us-ascii?Q?yAxUlMTxW5hO4vBGzNHtlOxw9bM+s9AxVzSoZ8b48v55Nx1csZvG7VQDM89T?=
 =?us-ascii?Q?3VSqhURK+A24PPhqWFzsGYoBy3UlN9m8kMjsMD1enNjlY+bn/VwgG+LqC8mR?=
 =?us-ascii?Q?YEeB4740AjMxHfi4JrCxhsTUEPoYIcBczFJY67O5/q0P3x9+TiEKYH19r2kt?=
 =?us-ascii?Q?3Iltk0jR3uERnwyea1eFlF4aaQYj8t/jjX4+p6JNL+tO2IODZjuurmz5Mldw?=
 =?us-ascii?Q?4PkLv+tABK7Gk9z3PsmxjVXdCUezBkUWmevq0Ewm9HraP14h0c6RhPqIFCn1?=
 =?us-ascii?Q?2+8JVnU4JtmlZHCTFsPiHOx4QKfJUtYqMD58l42Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fdbc55-edbc-4db2-b465-08ddafd3b2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 08:23:12.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWLw/YLPJ4HCiGIaCMS84MVJV0gYmXSXeExiiC2OyU1c4bd/v66uDW90+o2DeLuDcYye9NqcdK+ey1/nxL5FsJ2bMjzz74P+rFawG0Pj0m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7251
X-Proofpoint-GUID: QVdOJWrrbecxhtylYx0rR70ldaqIhvrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MSBTYWx0ZWRfX1xkMF1aQsuTT PAjjIGn4f0L0s65kLLaPnTnVO9KA8Z4LzOaLaX3N40xtZcXCKkti2Wc/STVgAuo4SuVSi2h8d7/ GgmlWbDycIU0+o0+9WuO7IFyMpEoPUEHFhRV3486FPWRhlMqdmREKa4QULiYep3jy/GhGMnhlsd
 JfB9SQhRo6htKpzjLBELpH3gegDMu/kr3jtZogrSJUc/U6BAKJ8cy4EhBCXgwKallAO26Wvg1MZ HSKTWOd7PLbFwQ33BLh01mKiehMO5VrATnED/m8J887kUuyHJbac9Op5/3JVRTjGg3s25t015Kj Y3OgR2l3lhEwTI8lrefU8JDjAikCe/LxGl5Q++Q0vYa4/YkpyvBx1/snWMr/OLyBwynm3p6S1ul
 nExbdMw0ow1FEdgfBAZDKuX0hURNnzc/veW01ziO59Ty6+8T5tyTGezBsri1vR+7pHe0R3qV
X-Authority-Analysis: v=2.4 cv=cczSrmDM c=1 sm=1 tr=0 ts=68551a74 cx=c_pps a=iNMpamO4ZYO2Dvx13ve0hg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=MGusajUyK0823r2cBs4A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: QVdOJWrrbecxhtylYx0rR70ldaqIhvrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=761 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200061

The SSP2 controller has extra endpoint state preserve bit (ESP) which
setting causes that endpoint state will be preserved during
Halt Endpoint command. It is used only for EP0.
Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
failed.
Setting this bit doesn't have any impact for SSP controller.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v3:
- removed else {}

v2:
- removed some typos
- added pep variable initialization
- updated TRB_ESP description

 drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
 drivers/usb/cdns3/cdnsp-ep0.c    | 18 +++++++++++++++---
 drivers/usb/cdns3/cdnsp-gadget.h |  6 ++++++
 drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debu=
g.h
index cd138acdcce1..86860686d836 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char *str,=
 size_t size, u32 field0,
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 		ret =3D scnprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
 				cdnsp_trb_type_string(type),
 				ep_num, ep_id % 2 ? "out" : "in",
 				TRB_TO_EP_INDEX(field3), field1, field0,
 				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				field3 & TRB_ESP ? 'P' : 'p');
 		break;
 	case TRB_STOP_RING:
 		ret =3D scnprintf(str, size,
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index f317d3c84781..5cd9b898ce97 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *p=
dev,
 void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
+	struct cdnsp_ep *pep;
 	int ret =3D -EINVAL;
 	u16 len;
=20
@@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 		goto out;
 	}
=20
+	pep =3D &pdev->eps[0];
+
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED) {
-		trace_cdnsp_ep0_halted("Restore to normal state");
-		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	if (pep->ep_state & EP_HALTED) {
+		if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_HALTED)
+			cdnsp_halt_endpoint(pdev, pep, 0);
+
+		/*
+		 * Halt Endpoint Command for SSP2 for ep0 preserve current
+		 * endpoint state and driver has to synchronize the
+		 * software endpoint state with endpoint output context
+		 * state.
+		 */
+		pep->ep_state &=3D ~EP_HALTED;
+		pep->ep_state |=3D EP_STOPPED;
 	}
=20
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 2afa3e558f85..a91cca509db0 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
 #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
 #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
=20
+/*
+ * Halt Endpoint Command TRB field.
+ * The ESP bit only exists in the SSP2 controller.
+ */
+#define TRB_ESP				BIT(9)
+
 /* Link TRB specific fields. */
 #define TRB_TC				BIT(1)
=20
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index fd06cb85c4ea..d397d28efc6e 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *p=
dev, unsigned int ep_index)
 {
 	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
 			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
+			    EP_ID_FOR_TRB(ep_index) |
+			    (!ep_index ? TRB_ESP : 0));
 }
=20
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
--=20
2.43.0


