Return-Path: <stable+bounces-235419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJQNJay112lURwgAu9opvQ
	(envelope-from <stable+bounces-235419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:20:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91233CBE69
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F69F30157CD
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6F83DA5B8;
	Thu,  9 Apr 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AK4aEx41";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AK4aEx41"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694C32692C;
	Thu,  9 Apr 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744407; cv=fail; b=bFBBbzEgwK5Gp6FCBs7JyIImFw+DYuZb8IXAXxaPN2GGcLOhy4qFwPCYs0q8TIG+uZpDN+mGWWyrPWEAtO7xLHnm1SXLS+I024ObjgxXu+M7jYvJ9+Y3pVshcsUe+djdkiYddDVphaUx/CSi03c6t5/NPwdDuY4fbJmb1v6dYXU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744407; c=relaxed/simple;
	bh=AQfOatzNbO7bQzhLjJ6GTyN7JlSrjWTwZhGh3jfW2VM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQRSAoTmbQ3YiD2+/xUBM+WoCfbRzoueuADU3powKuRdfvli05EPgXou7LSQdwivYIlG8xxmSvTKmoThbnb9PYBezBCUi9dlGnoJZog1jTpw5W459violQgQyqNYCkklpsoVues1CYBa+SkXSQEYbp/t2gcl8nFQW0iDK2Yab+M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AK4aEx41; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AK4aEx41; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nVBif5oLZWANvUI6gRLmY6CFW6nQEzXZ73784UfJZyWvnPFiGXceC62GcVlGnaEO6w3xkaL6iJW049eSGAEXzU4sw0nqLtU9MKp/B1gMzsBkWSvgWOQKLRcnOLrd6tjojTKNZhLQ7Nzg0/AmmkO6WHP2/++j8lDmU98xcbdJJAA5t23AvX4Z7qVwFd0W41ECY75Muf2Kc/gyLXWyHkwqXJ+n6TpiwAMgqa+PYqlw29ABFbD6Dlc4Ff6WRbbfRGl3Wg9D0d602PhlnOhRqGoX1gHI3RzQvzBNvb21kgK0w7YL2LDPlVwCBPJoPXKEmaO482hZsDZaOPtEwZ2VHRKnZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVQznnJBSQd9emeSh73g5r0NuXwJPS2z8RDTs1vG41I=;
 b=BvJ8OXjEfjMiiRnMY1YU649Pf5RaSOosrwcYSpWVobjaLues6x43RG8wOnDregkb12TIX+iRO27lGyxUsqJ44UUSwaVmFY5UUNM6Ci13MWqAdn24bwsUHP/pPeAAzPgNeE7Y/ioDhzaYpgIzOqZgEUtxHSx8JqQxVscPXbgsnetKoxSKQK0A48z5PZfMDOXoAQshHgfXePDxZ+9QFTcfDy5gPbAEN3qNp7+WQBeHDg0ulpOqvkDUiDfosLCHVbH41W9ZI9xQantItQmpIRE03OTlLQc3Vvzn0ibSQK1FO2ppFEpyHJVXzR0xjzgQz/vJtPIuKh3waT3QMDce9a3zKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQznnJBSQd9emeSh73g5r0NuXwJPS2z8RDTs1vG41I=;
 b=AK4aEx41e8NsCcn+b3JXnjtIQBDCU9Pm2t4wHLc1ZAM2MjNXUQMOunwxsh7MW02Cci4Ls83OqkwiCo5vOpchF29ye6C7TXL/d/6J0KrWLbMFGI80CMC5XYrt5BklMF/5fzPh1sIL32khBUblt8NjAdwPSZ4HAiWwzZTJ0tTeKDA=
Received: from PA7P264CA0249.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::16)
 by DU0PR08MB8931.eurprd08.prod.outlook.com (2603:10a6:10:466::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 14:19:52 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:371:cafe::e5) by PA7P264CA0249.outlook.office365.com
 (2603:10a6:102:371::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 14:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9818.0
 via Frontend Transport; Thu, 9 Apr 2026 14:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZH0EdxCWtpsO37vaM0A+KxywgkC9bxyh6qT3n6FBbWPkgD/zLsXe6Wy6VB3wPe1XGq7GT89+0q2X+3hPKKrCaVuzTWi2yc+3jbVcr/AxFc3BZwdXWxmh7kGm+D9whloFrWp7pDRXlodjuSYNOSRzMtkCnXupPtP+4pI9hju8t6Zgs6NV39GsW+IetPyu3xRORJIhmbYSAc9/dl5owULW2VBPOBEg0pXqglRaNkOv8lTX0gBxzuu+RCtLfWsZkDRIoa2pDY7gkSXe7RkOyvpIzOPxRt1+VbnPRkdlPaJZnPmrXXk/o9LV+S9KIr+chC1mkeTeOnb6TDeA7QZTwtLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVQznnJBSQd9emeSh73g5r0NuXwJPS2z8RDTs1vG41I=;
 b=ksRsiXMr8bJ/6cnQlepjqZ6Z28RjaM1EtYeQ5/9NYXwxzC6AOSOpVq3s+DVWt0dEoObuK76jo/dYXxHMps/KKdK/Ol2aDcfhzGfxirgT9yWKIF0QasO/FOqv4jde+LFdpgZv1JDCeU9HGDeXrOC8tT/MB3PIw3buLf45u/d+rfsTwqnaX68KXNqthCnxRBZciRmjrXTXUWCZ8TcFC9kFvHZd/0Wtld1C31dNVP7StGmYlHyMTKBBlZwTf6wOSEaj08pMxaSeTRZcGwzuczAr981wtW+Udx7mgM5/QiTiVvXyl+Ga0UKaTyy0bAfKP0/EA3mjGV8fanZokWdqdKBIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQznnJBSQd9emeSh73g5r0NuXwJPS2z8RDTs1vG41I=;
 b=AK4aEx41e8NsCcn+b3JXnjtIQBDCU9Pm2t4wHLc1ZAM2MjNXUQMOunwxsh7MW02Cci4Ls83OqkwiCo5vOpchF29ye6C7TXL/d/6J0KrWLbMFGI80CMC5XYrt5BklMF/5fzPh1sIL32khBUblt8NjAdwPSZ4HAiWwzZTJ0tTeKDA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11769.eurprd08.prod.outlook.com (2603:10a6:10:644::21)
 by AS8PR08MB7911.eurprd08.prod.outlook.com (2603:10a6:20b:509::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 14:18:49 +0000
Received: from DU4PR08MB11769.eurprd08.prod.outlook.com
 ([fe80::d424:cd62:81a8:490f]) by DU4PR08MB11769.eurprd08.prod.outlook.com
 ([fe80::d424:cd62:81a8:490f%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 14:18:44 +0000
Message-ID: <0cea9e3d-3081-4f34-b10d-6ae9c66f5216@arm.com>
Date: Thu, 9 Apr 2026 15:18:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>, Jinjiang Tu <tujinjiang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com> <ac7VD4Z85nS30GCp@arm.com>
 <1db93bd3-cb47-445b-b8ca-6de6f04b41cc@arm.com> <adU9KxLC7yKgmyJy@arm.com>
 <d1ecba64-898f-433b-93d4-7a33b9c3f378@arm.com>
Content-Language: en-US
In-Reply-To: <d1ecba64-898f-433b-93d4-7a33b9c3f378@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::15) To DU4PR08MB11769.eurprd08.prod.outlook.com
 (2603:10a6:10:644::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU4PR08MB11769:EE_|AS8PR08MB7911:EE_|AM4PEPF00025F9C:EE_|DU0PR08MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bf18c8-1103-4a0e-877c-08de964310ec
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 bJXMCjSfj58pdjslkjH8yT1t+PX3tW5BrwcsFTkmJrHcQvO/iKMx4Dtyhfkg80LFZGSpMHLvWqUYq5t6p1YiLC1+Y61PiTn6fuANufzWrXsm46oV3TjIY1sc2RL4guk3Atw0TNoDvHKe/dhgNpHN40Gy1KNA9/vXWlf/t5pHr3ARwndx80bsSOXInnKKE/C9l/nobsXlEef/9bw0saD5uiOegmlyvtJwjqxbYnhsaa4v7LibZtpJl0SOFGlbOYXEvq9mFBqb0gmpMhfHVZpI5UrKkWuYNo0bvQBbdfDvKRwJDcQXjkKA1V91AAlYgIcr7LU1wTF6sIqmsQ8+5VHKzHCgmeNnqCtxdFVkHoqOHVTvqSpei+S6MSpb656MGL1d5So/oPxyTJmEiBE9csQC3cGfrm8tv2u/kbAirME8eTmhtJT/DDa9Vp+J4DRj/fy5H0ybSVMDJdF7jgDRSZMuuySDMHtS1yQw5kKKOc8yZP4c+Sopa5RzhL9+rnZFq9PwWX2tPGQPQfNwBVlOFpwSCY9rsqgQCI/q7hVsmCqzTSgkswljR1E0Ci6PCIb+Fj0cksxPdGuEa6oSXMFrEuf5YBV1OrzyZvM2HYcZZSXXrTQs6YLZvIyomMYvGap4WCDqOI3EMtjfAgbh5jOc0i3iWxXfELjWEKjb5R80LUu7+xADAQb8woQA6bSKLKTAXyar
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR08MB11769.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 QUA5Dsvz35SBu+9Gm0pk57AJOXOc76RpcN9waAmKG+O99RyWX2MOhA0vfIZbm6szRH4vWLwU9C+nTgWUDhsbkQ67KTH6ASdelMOZPNkp/U4HYIqIppqeUBL8PiKI4Exqa/5348J/HH7Lp+nPnyNEG9sxHxG50LAl9qRM83VKJ+jyXRPmeKorJ1Csx043uDhQmxY0F/phqdwrMpolG/ywRFszg9ousPpzbzyd399KsokeWRz6g9+ho5ZsbwCqS7YyRS9YRj68+3gtbnBc7Tq01lM6l4zVCUIeIgh76rWTMYx5VDdVaaI2Qf44C8S2pGoycrP4Rl7r5hLI9r9MUNYdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7911
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b67fea42-dd68-442c-146c-08de9642e858
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|376014|82310400026|35042699022|1800799024|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PMHo/NK1NhmG9JMnOEpXc6q/rZOMArNLZJmDRT3c3w3O0iC9PDP1mmm9sx5KDNamjEP+30iol11JO3I4JEKKPSMHjXw45Tj6lU5meSLILRP8HcTBbIJ8hxeNSb4LYjFBuFJ4dwg+zBct3FyN4EAwN3OY+OWPmN/kRTsVtAHDA+Hnra6whxGMo6nVFJmGYsY4LZDLiKBvGvjxJPLXf37fjD7bghCPQY7WYhLOJYwEkx50vjIgDu4HQAUnZzDuWVWSdKsNvgvt0xWFvfcC3e63EAcoT9f6vGh8lcyEZxkXVA1GhTJoasL/Vq+XoHw/CBvCWSyQThc2WGY4UYunn0M7NFem/Pq/h9rE/iKipoyfe8/WojsIIDI+dbPe/W4aBL0Z4Uwhh4qA99T+LBe/VU4csXmEA0cUoWbp9Rjw37AbDP/rpGALjyoKkce3Z6+MfbEiSOHaB9m9zgJb0hrLza/qz4qPhilubyRBoll04tGYWiCncICPyjpl/9uMkyr2dpRgPRB/5OUreWG+Gci1rHTDoXML/GRUahcD9R+ENT11zgfy3ZejZno4Ai4j8qerb4wmsBFFf5kgOCCWvMt/r56+LltCXY4C3F2wC5K61OxQoJDhP7f/up0LgThFTpZGZatX4n4FIH5rmR7pCmbl688O5SzIRE4BqJiKgeHtheVLnag8HtnQKU2AOEPKk3ALLD29f4upaSday9ELe1IT916ORA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(376014)(82310400026)(35042699022)(1800799024)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TsX6sguoKsKO0snC7KYmDshdw1XZP1Hstj6dSB99qFUeMGMnFi9VG7y+EMTwSptIvo4n/TzR8dqaflA7tOJan6hq4M6A5zkH0gz8lKfzOQH/VRsvESFnvbGbpTCwzz4uppGi/eLgjry8ywcpeRQ5AYuhUtVE1lGn5/VIF1lredJIOs3++q1FaoLVV2++CJoDV+CYxpO2cY2L/LcJ+B2FcC8Ml0mwPMfBfZvTVLx2BPYO/Z2fhNNExdg4gxlnPF+0HfsSF6NMeh90QDS3jWzcEFwzm3yXRVx7H3/ljVKUnxKxX9BvUzlW+jwuyftEsADO8UQJDSadGC22Gj1ctMM7uVegTbuuHLDUV+jKsJKLlvUpgQ/j+BvGgoTijFO8bgURe671iuU522EyPuSYvnlwzgNtcohJ8OUvxB13IEgQMHsYQXbVCmWr1or8nnPql7Cz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:19:52.3098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bf18c8-1103-4a0e-877c-08de964310ec
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8931
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235419-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suzuki.poulose@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E91233CBE69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 10:38, Suzuki K Poulose wrote:
> On 07/04/2026 18:21, Catalin Marinas wrote:
>> On Tue, Apr 07, 2026 at 10:57:35AM +0100, Suzuki K Poulose wrote:
>>> On 02/04/2026 21:43, Catalin Marinas wrote:
>>>> On Mon, Mar 30, 2026 at 05:17:02PM +0100, Ryan Roberts wrote:
>>>>>    int split_kernel_leaf_mapping(unsigned long start, unsigned long 
>>>>> end)
>>>>>    {
>>>>>        int ret;
>>>>> -    /*
>>>>> -     * !BBML2_NOABORT systems should not be trying to change 
>>>>> permissions on
>>>>> -     * anything that is not pte-mapped in the first place. Just 
>>>>> return early
>>>>> -     * and let the permission change code raise a warning if not 
>>>>> already
>>>>> -     * pte-mapped.
>>>>> -     */
>>>>> -    if (!system_supports_bbml2_noabort())
>>>>> -        return 0;
>>>>> -
>>>>>        /*
>>>>>         * If the region is within a pte-mapped area, there is no 
>>>>> need to try to
>>>>>         * split. Additionally, CONFIG_DEBUG_PAGEALLOC and 
>>>>> CONFIG_KFENCE may
>>>>>         * change permissions from atomic context so for those cases 
>>>>> (which are
>>>>>         * always pte-mapped), we must not go any further because 
>>>>> taking the
>>>>> -     * mutex below may sleep.
>>>>> +     * mutex below may sleep. Do not call force_pte_mapping() here 
>>>>> because
>>>>> +     * it could return a confusing result if called from a 
>>>>> secondary cpu
>>>>> +     * prior to finalizing caps. Instead, 
>>>>> linear_map_requires_bbml2 gives us
>>>>> +     * what we need.
>>>>>         */
>>>>> -    if (force_pte_mapping() || is_kfence_address((void *)start))
>>>>> +    if (!linear_map_requires_bbml2 || is_kfence_address((void 
>>>>> *)start))
>>>>>            return 0;
>>>>> +    if (!system_supports_bbml2_noabort()) {
>>>>> +        /*
>>>>> +         * !BBML2_NOABORT systems should not be trying to change
>>>>> +         * permissions on anything that is not pte-mapped in the 
>>>>> first
>>>>> +         * place. Just return early and let the permission change 
>>>>> code
>>>>> +         * raise a warning if not already pte-mapped.
>>>>> +         */
>>>>> +        if (system_capabilities_finalized())
>>>>> +            return 0;
>>>>> +
>>>>> +        /*
>>>>> +         * Boot-time: split_kernel_leaf_mapping_locked() allocates 
>>>>> from
>>>>> +         * page allocator. Can't split until it's available.
>>>>> +         */
>>>>> +        if (WARN_ON(!page_alloc_available))
>>>>> +            return -EBUSY;
>>>>> +
>>>>> +        /*
>>>>> +         * Boot-time: Started secondary cpus but don't know if they
>>>>> +         * support BBML2_NOABORT yet. Can't allow splitting in this
>>>>> +         * window in case they don't.
>>>>> +         */
>>>>> +        if (WARN_ON(num_online_cpus() > 1))
>>>>> +            return -EBUSY;
>>>>> +    }
>>>>
>>>> I think sashiko is over cautions here
>>>> (https://sashiko.dev/#/patchset/20260330161705.3349825-1- 
>>>> ryan.roberts@arm.com)
>>>> but it has a somewhat valid point from the perspective of
>>>> num_online_cpus() semantics. We have have num_online_cpus() == 1 while
>>>> having a secondary CPU just booted and with its MMU enabled. I don't
>>>> think we can have any asynchronous tasks running at that point to
>>>> trigger a spit though. Even async_init() is called after smp_init().
>>>>
>>>> An option may be to attempt cpus_read_trylock() as this lock is 
>>>> taken by
>>>> _cpu_up(). If it fails, return -EBUSY, otherwise check 
>>>> num_online_cpus()
>>>> and unlock (and return -EBUSY if secondaries already started).
>>>>
>>>> Another thing I couldn't get my head around - IIUC is_realm_world()
>>>> won't return true for map_mem() yet (if in a realm).
>>>
>>> That is correct. map_mem() comes from paginig_init(), which gets called
>>> before arm64_rsi_init(). Realm check was delayed until psci_xx_init().
>>> We had a version which parsed the DT for PSCI conduit early enough
>>> to be able to make the SMC calls to detect the Realm. But there
>>> were concerns around it.
>>
>> Ah, yes, I remember.
>>
>> Does it mean that commit 42be24a4178f ("arm64: Enable memory encrypt for
>> Realms") was broken without rodata=full w.r.t. the linear map? Commit
> 
> Apparently, it looks like we missed this when we demoted the RSI
> detection later.
> 
>> a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
>> introduced force_pte_mapping() but it just copied the logic in the
>> existing can_set_direct_map(). Looking at the linear_map_requires_bbml2
>> assignment, we get (!is_realm_world() && is_realm_world()) and it
>> cancels out, no effect on it but we don't get pte mappings either (even
>> if we don't have BBML2).
> 
> Yep, that's right.
>>
>> I think we need at least some safety checks:
>>
>> 1. BBML2_NOABORT support on the boot CPU - continue with the existing
>>     logic (as per Ryan's series)
>>
>> 2. !system_supports_bbml2_noabort() - split in
>>     linear_map_maybe_split_to_ptes(). This does not currently happen
>>     because linear_map_requires_bbml2 may be false in the absence of
>>     rodata=full. Not sure how to fix this without some variable telling
>>     us how the linear map was mapped. The requires_bbml2 flag doesn't
>>
>> 3. Panic in arm64_rsi_init() if !BBML2_NOABORT on the boot CPU _and_ we
>>     have block mappings already. People can avoid it with rodata=full
> 
> It looks like this will be a common case :-(

Having another look, by default, arm64 boots with rodata=full, and users
have to explicitly lower the bar by setting rodata=off or noalias. So
this has been keeping us running ;-).

With rodata=off, I get the following for a Realm boot:

[    0.000000] ------------[ cut here ]------------ 

[    0.000000] WARNING: arch/arm64/mm/pageattr.c:61 at 
pageattr_pmd_entry+0x78/0xe0, CPU#0: swapper/0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.0.0-rc1+ 
#1889 PREEMPT
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    0.000000] pc : pageattr_pmd_entry+0x78/0xe0
[    0.000000] lr : walk_pgd_range+0x43c/0x970
[    0.000000] sp : ffff800082343b70
[    0.000000] x29: ffff800082343b70 x28: fff0000019600000 x27: 
fff0000019580000
[    0.000000] x26: ffff800082343c98 x25: fff000001d57ffff x24: 
fff000001fffe000
[    0.000000] x23: ffff8000810ae698 x22: fff000001fffd650 x21: 
fff0000019780000
[    0.000000] x20: fff000001d580000 x19: 0000000000000000 x18: 
0000000000000030
[    0.000000] x17: 0000000000004000 x16: 000000009fffc000 x15: 
0000000000000020
[    0.000000] x14: 0000000000003be4 x13: 0000000000000020 x12: 
0000000000000000
[    0.000000] x11: 0000000000000016 x10: 0000000000000015 x9 : 
0000000000000013
[    0.000000] x8 : 0000000000000015 x7 : 0000000080000000 x6 : 
0000000000000000
[    0.000000] x5 : 0078000099400405 x4 : fff000001fffd650 x3 : 
ffff800082343c98
[    0.000000] x2 : 0000000000080000 x1 : fff0000019580000 x0 : 
0000000000000001
[    0.000000] Call trace:
[    0.000000]  pageattr_pmd_entry+0x78/0xe0 (P)
[    0.000000]  walk_kernel_page_table_range_lockless+0x60/0xa0 

[    0.000000]  update_range_prot+0x80/0x128
[    0.000000]  __set_memory_enc_dec.part.0+0x88/0x258
[    0.000000]  realm_set_memory_decrypted+0x54/0x98
[    0.000000]  set_memory_decrypted+0x38/0x58
[    0.000000]  swiotlb_update_mem_attributes+0x44/0x58
[    0.000000]  mem_init+0x24/0x38
[    0.000000]  mm_core_init+0x94/0x140
[    0.000000]  start_kernel+0x544/0xa18
[    0.000000]  __primary_switched+0x88/0x98
[    0.000000] ---[ end trace 0000000000000000 ]---


Suzuki

> 
>>
>> 4. If (3) is a common case, a better alternative is to rewrite the
>>     linear map sometime after arm64_rsi_init() but before we call
>>     split_kernel_leaf_mapping().
> 
> We will explore this route.
> 
> The other option is to move the RSI detection (and the PSCI probe)
> earlier to be able to make better decisions early on. I will play with
> that a bit too.
> 
> Suzuki
> 
> 
>>
> 


