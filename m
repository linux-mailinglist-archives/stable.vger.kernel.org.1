Return-Path: <stable+bounces-141793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD77AAC1B5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C1E4E390A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BCC2690D1;
	Tue,  6 May 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BURF+9tA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BURF+9tA"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE320C028;
	Tue,  6 May 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746528514; cv=fail; b=FRxLZ4GAM1nLQlfRA07z+QJM+t6LEBOLcZMZQu+rJYmLrcEs+b7lDwxiZxpK0xo1sIKWk/TY0BIBEAd/IFkslAjbnD9iIW0/JnzFZgJBwPLjSizZs7M04aptUC6oL++b37TN5BE6cohEhA5gN0BbLaTy+V30vfjo55GgrhSyA7w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746528514; c=relaxed/simple;
	bh=Un0py1dMfduktRubX1P329j9TN3tEBLfm9XUrSUeZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tQFTvWA7AEcPzpU3yiQs7Q3tUWwiAjE/UfuQIuHbUvAvTRB80bGRAMNyTKw3v4PbuMJw4dR4CRNXMhuIM4CESb85Kavlb4AbSKsr44Zpb1Bb2lMY8eL8XlS/HQCJ//VHwbz/YVvLPG9F860m9vyf7UQjxg6pMEPF1X3o1UmJcRU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BURF+9tA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BURF+9tA; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dHZpxvyPtHEnI4GEfGfrQ2tbpZngNNjX9r/wO72t2HsqCFXhXThgrtZ1Bzkp2IfpiH6lPOENQlsYtZbMraupvEqi0rEZtr1nwXUK5Izm+J3yQSnALmY0kx6dcKrgwF1cd6PUiGij6bUmkgkkiFumBs03H+EAHSItD4AadhX2z/+hHKqQfibLgvtsagN4ONeacIix+Vukr2iPgDOnFkaE8n1eeGxNseRif5tLuMgaFvgt7ziRZQRdBe3mzpkj7rXA9+G430/5skEvtwWY7I/zZHcbayH0jp5tf3CWgAwYKwVZngmd572x2QbzoV7mx2D2caczyR79WWLshIhY61LVAA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcMZ+MFYw8BBT6JzhNAyoqGRrVaSSkLpD0xmizL+EEo=;
 b=leu151kY0l3CjxmPrikBBjBXKyuLpv91Wn2SpQW+Gb/Cr9ZfsN0Si3xDlChT1Z+Uf+0haVWnynrmTby78F757obsuvjmm0klAehjwNowDcqCnKYjzJw6T6l1AFr8u3GN7nDKv9+yVkGSk6lGySduQKtMHt5YdtmusfjKF+qFUJ6zWu+GaZqEm8YphW0ftpxvXeZmz2v/iD3+b/sKUIVJeEWQNEpDobiEgcTket1InuvRVcgyF/36Kzztt+wGjOZbA/KE3VFbz22tZ1yRuAMGZ7NphGgQdz9lWZunSTycvoBRWaRO4kOSo3rbBzJDjT6Z2CKQ9fYFv4REorQ3yJ3gCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcMZ+MFYw8BBT6JzhNAyoqGRrVaSSkLpD0xmizL+EEo=;
 b=BURF+9tAjAsFJM2KRctsgWE2yZMeFKlTeRPnxfmkCIxQ3ENP1JciE2tQC1bUosnl0RpP7InMQMUgQsTkRYxX3EfsHGTekcpGdBikSprBEVk7ZzXCQoWnBNs54nhBWYGY3cAAWzCrmTyA8605o0mqFdxowErRI/siKUVnQUzXJl8=
Received: from DU6P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::27)
 by AS8PR08MB6149.eurprd08.prod.outlook.com (2603:10a6:20b:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 10:48:26 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::66) by DU6P191CA0020.outlook.office365.com
 (2603:10a6:10:540::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 10:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 6 May 2025 10:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRCmaTx84G0RKuU/tdsIfBMgQGhmJZMfw3q/j4swxWOHhbHsUpNS+1hrEvS8udm9GuPmfMvoH033llSnMMuvMRO9gDTYfTsPrhLYNYZt1uV9WOGzbGtsGhTHOPHTashNkubUEraVa8gUwpw/Sh/U54I0Qp/1ZbDgFXU28ar+nFzniuzJmKplLvuR464a/ZH8rJhBCcPgXNwE4vTbdcdtr7CF5ZpxfwIXVDK1vuORrNF0T7FwSMFbCtBMNVizaAIDpoRhZXxz3+vOo3ZGvLAK1jw4r4qMwAXj/mVYvjJVsC9wj9ZjuCXMzXJFpvLO0W0Wk7WPIro7yzBQkqWEztpTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcMZ+MFYw8BBT6JzhNAyoqGRrVaSSkLpD0xmizL+EEo=;
 b=ht0fawmYc+LDTlBfCGiyVHxgJf0p7QFtjaX5TtTtr60WeKmOQylYcHuh/ev88gQLKIiqAAC3ZNiBDXptlJaoZu8WTgS0Q1Wle3H8OMhOitB5SaiVUequcKw6aPDIO0fanE2987xd3CGy0L1uwlwZC36DgCS7mJA1TwKLfsHFrIezdKv8HUm/NclctRvfh44US/A4bMuBz09K7xe2PGjsURj8dOFmlpEJKnyYK1T0fDBkgajvaz14XD+VOA1Me/XTy/INPe+XgNGsUzkJM3mg102byaYpumV5bF1R58cJSGTkiZfVyPYFVFQUqdt6S8P+VarPnKcicErWs+IlLKdntA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcMZ+MFYw8BBT6JzhNAyoqGRrVaSSkLpD0xmizL+EEo=;
 b=BURF+9tAjAsFJM2KRctsgWE2yZMeFKlTeRPnxfmkCIxQ3ENP1JciE2tQC1bUosnl0RpP7InMQMUgQsTkRYxX3EfsHGTekcpGdBikSprBEVk7ZzXCQoWnBNs54nhBWYGY3cAAWzCrmTyA8605o0mqFdxowErRI/siKUVnQUzXJl8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB8003.eurprd08.prod.outlook.com
 (2603:10a6:150:af::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 10:47:47 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 10:47:47 +0000
Date: Tue, 6 May 2025 11:47:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBno0C2RPQ2x8DG1@e129823.arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
 <CAMj1kXFAYDeCgtPspQubkY688tcqwCMzCD+jEXb6Ea=9mBcdcQ@mail.gmail.com>
 <aa4241ce-02ea-4931-b60c-5ad0deba202d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa4241ce-02ea-4931-b60c-5ad0deba202d@arm.com>
X-ClientProxiedBy: LO4P123CA0586.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB8003:EE_|DU2PEPF00028D0A:EE_|AS8PR08MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: a0eecdb4-87e9-40a3-609f-08dd8c8b87d6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?kiomxfLtr4jBsWmrhECtCOWpn3jqht1bDN+FN5Gey83CbCr/C48ROO4e0pGt?=
 =?us-ascii?Q?6kE1594ITpA/IUZoWOBhGztaoxqqa98f+9RlYG5PPNu91V1csRmTu2BlghM8?=
 =?us-ascii?Q?ydSZx+n9J8vuQ1Araj5tFBq3llENfhuo5jhqpGDIZl8nJm60+tpU95S8hRaQ?=
 =?us-ascii?Q?p0byiakE0al5YkWuNULuDQHCfjyt5w2tVAu6tA9XCM1KN/uACvhCWTI0ZZEY?=
 =?us-ascii?Q?g36JKVH8T2UUl61xY4HD1VoTeEBTD89S9CdZcGoa98PsKRIWQK+g/nKV7rpy?=
 =?us-ascii?Q?8RkJxUFhXygdUfS52unOVpXXbv+kgxEBIBnUxjqtmJTGa7zbUtcP1G0P9oDV?=
 =?us-ascii?Q?v8ZdqVPCz7eiaRQxtt8/kGf2lOWBk029ZrXrwg0a3FYhCtztEQjhfpozxyjC?=
 =?us-ascii?Q?45PRxPIMv6wzQtsCaPWxdvh+dd0x7PIW6lKHJbcVJgEUsQHjjq+67qupc3FD?=
 =?us-ascii?Q?dP0oqOHdXdA8ETkqLR9jvRGiMZ8MW+ipeCuD7zZcqkg5ursQPFxhiw+h5yMP?=
 =?us-ascii?Q?FBq+rojwuLQF/zr5R/4FcM/cG+CI4zzxIQIorP6C0DdfJnVCKN+3Zd4CO4Yd?=
 =?us-ascii?Q?yw55JSuC92PMD8R9U3LtEb3qkNnuNaff3OAymSU5WaZvg6FYIV2K0zN3xgYL?=
 =?us-ascii?Q?1yWFRCDo2WGgTNPUQyvtYPKWKfZbBqDeUfflS/bbG9uhW8SweJv6Qi0cZy9V?=
 =?us-ascii?Q?20oo1ZB2jmpBSmbRwkHPYkfXc226ffVzrxbfhgGOuLEjEkeruArAN3Vnd1zM?=
 =?us-ascii?Q?c1P35THcS34wzke0yaz/bBMaHz+eQvKjEoxfiigFsTuZbsmF/FynoCJ3vjAM?=
 =?us-ascii?Q?qvO4nPRES6ZQ0/m8sJQRHoKSXZ88dn8OIO5Pe6hFdq3Uv66HFQBlGw2qcwr6?=
 =?us-ascii?Q?H+gA9/KN18NrXABNiujQUCwCu27drSJtF7ygjg50wjOtSmTFH+/5m3w5oweE?=
 =?us-ascii?Q?mWGe31AnhnWk3nQkgv6ta8klH7DT+dXHXWdQ5hFwfYmoCEaVkElpBptkS0E2?=
 =?us-ascii?Q?2lIhx2VZmS3VmvnMf/8OWVG3YhCxRKDUZAo9tpVCS/yfVrtzonVXC0FPkUOV?=
 =?us-ascii?Q?2A0qASeSqxuVDAO7otbtCwzDgIr3qXxNwTP5W2nishG6bVG7h566K47Oywo3?=
 =?us-ascii?Q?bPs/N+vSJsjp1jodjoGdeNk00oFk+UGwfndDhdKAEQ1Clt1swwMym1Pr3zIS?=
 =?us-ascii?Q?jfPdt33mPkgJehWesDmCgBpiT4fSVpADk1ByfsjP17PoKZwhP9OHLlWm1eBP?=
 =?us-ascii?Q?VtiJ/w/ZFBzr5I2mIP5B7+M58dDbhc9vdNy5bfNAUdhSEjA1M51rnEvkbrVY?=
 =?us-ascii?Q?mxP/JkyCbnbrO2wZt9qnO/yd6ZDjDRDupDYNPHTCNHJvWtgTnQxttPHX8nNN?=
 =?us-ascii?Q?qwy62PU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8003
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ab247b62-566a-447b-9edf-08dd8c8b7054
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|376014|82310400026|35042699022|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkfILiHsXp1px/Nj2Lwsm9nw88LUigVgNWeaQtv0zubbPYuzyWTjtoX5iCLP?=
 =?us-ascii?Q?H9Rz3rnvPIAGsSiZxJKemkvt91oYhQRFTkzFS3hLBYsub1Rv/BisSPjxLS8p?=
 =?us-ascii?Q?Oz3r3MmLF4DmUKE6VXrcd/mas0nYQHUsU3Kz/a58dCZFWS9+lDiVg3mADH4y?=
 =?us-ascii?Q?Npdrsgijbe3Kck2mALxv3tLEgSobfZ+LxRzphaiYbJ+vAANjGjmkXyAPXKP8?=
 =?us-ascii?Q?lov9MxTY1B1O6MIDZnBNSBTRlgrCWCXpNRywRAc0YYGIbZxFxIxhBGsuNaJO?=
 =?us-ascii?Q?L1qmiD+nKUb3W3FTrLZd4Xa/+GM8t1+AKb440Fl3OWhwUgIxH+PesDHfsWmC?=
 =?us-ascii?Q?InaHnpiA+z19n+VaDjsDJFNhddEchuAgFWlJ6OScyf/A4eeeBMzwXveXAmp+?=
 =?us-ascii?Q?VuQqhj5F/q24M8QYeuMqNBXNvm7/uJ81hc6ENWv5if4zy/LXGvA5jzbYbdC4?=
 =?us-ascii?Q?5Z7HBasn8OaXZAo2vNVVMMXrkltyc6mWqPDcbD+YCfHTnq/rEZ7L+t4ZmlVc?=
 =?us-ascii?Q?e7X5bSOpVPzliOkEyw8tHEnTJrYeZtdmXU2Mb1YspouFXDYgA2C3YwhYUat8?=
 =?us-ascii?Q?4o1S+TUhfV4/qp5my5RtcSYbc2+diwCz2ILkUgVsRcMhdxAQVbiEVU+w+2ai?=
 =?us-ascii?Q?up4zlWrH31L+4+VJhTSKyVzRn/le5l2QE0JFF9Wv4cCpav5GRpGKwkuRzRbW?=
 =?us-ascii?Q?VKnhOlUQF+bjV63vmxWxkckx5fICBI2UFfTbgrKJOeQRWlPLgFuur1Z8lIsm?=
 =?us-ascii?Q?wnKFUblXT+VE7d6ISPkdOUtxi+Fd0M/TwVBSILrexOq8Yl97YZlVdt2+XCiE?=
 =?us-ascii?Q?rmJrDXjSsj/LEo0RpuH5zdgRCgwXlosPuiWTrzu/lx0Rv6wf/WNJKnExEikr?=
 =?us-ascii?Q?cVLr/cdC8urk7Hg0t4ooIOH9oFo+3MXKizKPsfj81OWw+SvZXfBMuyTsKs9h?=
 =?us-ascii?Q?uNeZOXmZwuKLZI739R6Y/Ry8z572+Q6HlA1ki8H8AYDDJxEXRlUlEbMogIQG?=
 =?us-ascii?Q?3DYPShk4wj+muTWuBczdb5ANAe2vPG5N0oKtwjooYDIJ6SRmjASLnevCZUrn?=
 =?us-ascii?Q?44Efw5flUaCJQR2CT5BhFB7VmVMuDsP0FmYlWTRqHNDLanU8+QJBNGalVaUE?=
 =?us-ascii?Q?6WPugAja0mkd++7L5V/UzKjmvwLE0cVuXg/nRyLGJvfDtIuan5A4h+3QwyCE?=
 =?us-ascii?Q?MOoUoEYtM5aVndQR9kb4S5EOg7XeOqEbUWVOiyexJZLLycajQC8jnHth8VtY?=
 =?us-ascii?Q?8zHQBupmz/ZxUg2BxWL3V0KnQrkwhFtCkKyJZwE1N651V++4uVMeepXkYDf8?=
 =?us-ascii?Q?O+MDAIw3zs/Zzo1A/uVCMePCVHf1FJKkpnKcvuwrDTYP95OyFENvBdkDOZRF?=
 =?us-ascii?Q?2uhrvYa8c+q3T2VuDrQJzfsP3K1GRY/Dw0LxpVTjaWNMLIeQtVxxHEnhSenE?=
 =?us-ascii?Q?ObP1jx13HFpxmA//LNo7AkzQIJYa3gJmUrTrezweH+EMNENYeBfq3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(82310400026)(35042699022)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:48:26.2810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0eecdb4-87e9-40a3-609f-08dd8c8b87d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6149

> On 06/05/2025 10:41, Ard Biesheuvel wrote:
> > On Tue, 6 May 2025 at 10:16, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 06/05/2025 09:09, Yeoreum Yun wrote:
> >>> Hi Catalin,
> >>>
> >>>> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> >>>>> Hi Catalin,
> >>>>>
> >>>>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> >>>>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> >>>>>>>> create_init_idmap() could be called before .bss section initialization
> >>>>>>>> which is done in early_map_kernel().
> >>>>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> >>>>>>>>
> >>>>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> >>>>>>>> and this variable places in .bss section.
> >>>>>>>>
> >>>>>>>> [...]
> >>>>>>>
> >>>>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> >>>>>>> comment, thanks!
> >>>>>>>
> >>>>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >>>>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> >>>>>>
> >>>>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> >>>>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> >>>>>>
> >>>>>> $ clang --version
> >>>>>> Debian clang version 19.1.5 (1)
> >>>>>> Target: aarch64-unknown-linux-gnu
> >>>>>> Thread model: posix
> >>>>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>>>
> >>>>>> I didn't have time to investigate, disassemble etc. I'll have a look
> >>>>>> next week.
> >>>>>
> >>>>> Just for your information.
> >>>>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> >>>>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> >>>>>
> >>>>> and the default version for sid is below:
> >>>>>
> >>>>> $ clang-19 --version
> >>>>> Debian clang version 19.1.7 (3)
> >>>>> Target: aarch64-unknown-linux-gnu
> >>>>> Thread model: posix
> >>>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>>
> >>>>> When I tested with above version with arm64-linux's for-next/fixes
> >>>>> including this patch. it works well.
> >>>>
> >>>> It doesn't seem to be toolchain related. It fails with gcc as well from
> >>>> Debian stable but you'd need some older CPU (even if emulated, e.g.
> >>>> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> >>>> Neoverse-N2. Also changing the annotation from __ro_after_init to
> >>>> __read_mostly also works.
> >>
> >> I think this is likely because __ro_after_init is also "ro before init" - i.e.
> >> if you try to write to it in the PI code an exception is generated due to it
> >> being mapped RO. Looks like early_map_kernel() is writiing to it.
> >>
> >
> > Indeed.
> >
> >> I've noticed a similar problem in the past and it would be nice to fix it so
> >> that PI code maps __ro_after_init RW.
> >>
> >
> > The issue is that the store occurs via the ID map, which only consists
> > of one R-X and one RW- section. I'm not convinced that it's worth the
> > hassle to relax this.
> >
> > If moving the variable to .data works, then let's just do that.
>
> Yeah, fair enough.

Thanks.
I've success to reproduce. and after check, Sending with this fix.

--
Sincerely,
Yeoreum Yun

