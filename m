Return-Path: <stable+bounces-141768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39305AABDE9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1009350197B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5C26657D;
	Tue,  6 May 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lMG7BHUh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lMG7BHUh"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3790264A96;
	Tue,  6 May 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521684; cv=fail; b=usEBcZJ9WlvkNAnSmfJe9SwV2+jyKvTmAx3mQa07RPZns/tTA1y78zTXB8fqRHXtFk0B2AEhPD4OxWm3caKtyGYQ2PPRrkIzlUXoUZ6x4FRE0q+XzC2Pu5XiIrH/s7nV0WEy27zBAoQaQ0DEEcOGdYOKjcLXUGuPcUBkFz7Z0oo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521684; c=relaxed/simple;
	bh=7oUbluevvv/YCiyqGEAqZvTVYWi+Rke5izaDcSZ/GMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+Xi0tF3kvfIsVOv1EnGGrjUR/3R+lQVt0N5mmSxJmFyG6pZS/RtM1+hwN9akdiVjfYC3h6mPKiT78L/Ajydg/xB9d2q4R4pbB0tgc+r7sGmH+Glh4R2yzie00Y/gFc0QsWf1TFFWtk3y6wsdxt2oKrQpiS8R4pBVOHzilnWnxw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lMG7BHUh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lMG7BHUh; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JfkgBvL1WhK5Lcu5Hg0+9JipN6a9VwCqRsfIFxoM4davJSnPKrvDhe6bUGnF7x6fzFyKHnQnWnXx1lQVWTUNM2WWzVz6WHWpeKrdZqHFfZv04RYasUXObQJbK3KI/OvlK1UapCSFCwpGve29mFn49WkRGaRs3Uo9EtH9KhVj7MOSVTdx3j6hWQHQC03J9X6bvFWH397PvAiLaBkF6nVYiVrA/+BXbc2LKOpkJnifC9x5b5ml6+RaUhc5ntsUoWrXYn3dg2lGhrkWVQIhEQXuI8+s6U4jjBPmc1PNGJSWRSLHCXy/ytlcMYSSmQc1B2pLsZZ0mzBFW4bkio7hTLUtlA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEhAzNb+VK2xh0zSzy8Fdomx9+wPRSDGd1Pa/KWtp/g=;
 b=QTllhMTgnDt2xPJLI9AX18nrEnubRzOjf0Rs1LeYr4HxRNmtJCUuvCkY+drfyJXY1mP2sWzcS4gm7Swo6kCdrcZIQLrGGXGirOsWcK7Q/a30PDHSUzoTH6Sxsza6v8kIb4AgcG5JsaNVtD8x3gVp4iqBOkkljU8Zduua22VMgRjWddJ8CA9Kqn5cP2KOxX60RzIu20Ob6ZvglDbUGXbo/+r/FqFJjFipZ1biat3H9aFmXlYySfFw7ZNJdVpu7QvnQCQLpI3Pz2oz9ywOB+FPScT+x5Pjtgg7Ewt2wT++GIUym1qTiRLDrEkQ7q8zqUYqyxkaebL4OysWYpmbtwpdlA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEhAzNb+VK2xh0zSzy8Fdomx9+wPRSDGd1Pa/KWtp/g=;
 b=lMG7BHUhLlKE0vbywBdcKlym0Yu7s5n9Lp/11XAfG//6Lly2xJoBSfY91B8xRYU12bv2bQ3AkcTkST0D0tsQAJWPFiDxlkFYXR769J+Nw1UDnMaPkd9G0bZjwfkobc+x3QdfA2/c/3Mb/1S2/uaZ4LhqWZM4z3Yll2tki6+CaUo=
Received: from DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) by AS8PR08MB10027.eurprd08.prod.outlook.com
 (2603:10a6:20b:63b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:54:36 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::f2) by DUZPR01CA0061.outlook.office365.com
 (2603:10a6:10:3c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 08:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Tue, 6 May 2025 08:54:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPrTM/zzYXEi7x3wBf3Y9tt1VafiNciCSPI/whFB9kVFGmULGe4I3NuM4Mc94UFFmnQKQKONmaFRd+taeu1bw/LLdiUbTF7Xxi93eVBHX7XWjkIIK0Y4gNd3/KMfrzoPF7fPZfU9/yXHpEhKGGdjuVZcIMe3CUL/RxigrrjyYTR+GNb5KP/UnOavAEqPEU6Wzb8I88OckNrPo3LeIQrTX7ttX4nCfsranYizwDzff4uN/w50iOXf6hTBerLlRKJhEXAlPvAOUq8n1S/0BYA28O6nTULLnI3P803SM/IuiYHMl7RhDOC/L9/TH9r5E6Z6x1/lSK6IPIDC0++H3UTSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEhAzNb+VK2xh0zSzy8Fdomx9+wPRSDGd1Pa/KWtp/g=;
 b=e2MkcJh2V6PVcpvsfftI6ZoTP25GzsaRFYWPxlDsL8HTufa/xqle8zLm11aIRVuYrjzcS39W5/sp0QWsHlYcG42uTZPxch7VSiesNzfo8SVFEm1TRxNg9YoUL7UKBOg6QC4PW0s0VNsBVy+X9lOsrxbDykCI/bQzAleugoCsljQdDKBUoAY5Neqticg5iTn4IE2xVI3BvuyapywRz5PtGXOzczKIvl+MKwtSMJir+tYAKut5E5oAX8eKXbr6sJFvGPHHeCPt8/1zOsFPdNprTd92wIxzwamw38xYXL6S5oh8sUtVYS1HI98jaEeOHhLGP9gUk0Yfnl5Jwk7GMQQNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEhAzNb+VK2xh0zSzy8Fdomx9+wPRSDGd1Pa/KWtp/g=;
 b=lMG7BHUhLlKE0vbywBdcKlym0Yu7s5n9Lp/11XAfG//6Lly2xJoBSfY91B8xRYU12bv2bQ3AkcTkST0D0tsQAJWPFiDxlkFYXR769J+Nw1UDnMaPkd9G0bZjwfkobc+x3QdfA2/c/3Mb/1S2/uaZ4LhqWZM4z3Yll2tki6+CaUo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB8456.eurprd08.prod.outlook.com
 (2603:10a6:20b:55c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:54:00 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8699.024; Tue, 6 May 2025
 08:54:00 +0000
Date: Tue, 6 May 2025 09:53:57 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, broonie@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com, james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBnOJS6TZxlZiYQ/@e129823.arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
 <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
 <aBYkGJmfWDZHBEzp@arm.com>
 <aBZ7P3/dUfSjB0oV@e129823.arm.com>
 <aBkL-zUpbg7_gCEp@arm.com>
 <aBnDqvY5c6a3qQ4H@e129823.arm.com>
 <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfded61-cfe2-4416-9098-ef39ef3e2b62@arm.com>
X-ClientProxiedBy: LO4P123CA0627.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::15) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB8456:EE_|DU6PEPF0000B620:EE_|AS8PR08MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a2bb6d-2971-43ee-7d74-08dd8c7ba0f2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?qlEma0jMyGrl8QoFToUhFnE53JasxjDkidZVK1sf3ipNhWAGIidD+addNhmu?=
 =?us-ascii?Q?UZF0gUawZmhPCkcCFG+z3tdxaEEw4vtF5G2mtEiucaIXD7avNHyl7CPXgR9/?=
 =?us-ascii?Q?EvW0SLE1k+PC9L/cg1t6Z4Y1TyyixKugIlYarM2v5YeOeTJCc8VSJRw1OK/j?=
 =?us-ascii?Q?YLekZmJK5EDNnW2S1T4eFF5vl1xNlEo/qdyINn2AjSFs/C2w5GcwKeQA+Y82?=
 =?us-ascii?Q?0GZiylAf3ZCFkLbWuWH1jCtUYmz/kYz61E+pU3maBSjbM4toVtPRmTacy36P?=
 =?us-ascii?Q?2GE4OKeg5sfLAghn/ad7XSveOdOMrAXa6ntFUdyBAgciXclDz6P9aQ7FB7tK?=
 =?us-ascii?Q?P4pOJvlEcEp8Vas/+dBOd31fK2QVSZOVT+8VGwEYD1BsG68HJIkh/5Xl0KTg?=
 =?us-ascii?Q?WQidAWlczI8tgv/8hxHaTCVBX15c+XLDHxhzn6GzMzpv0hsDNJy/6OIfaqZC?=
 =?us-ascii?Q?Rbp+MyzKkx9WTSku2q5NLQ1Wa7ICUX1Oy+a+0GWvjGkohCc38Z9j+JCUmSzc?=
 =?us-ascii?Q?PhwuJFb0K34/lwvVW4O8avxnw8F5hCO0BvZfCjNz/LZVvCUIzx5/7sKtBnQo?=
 =?us-ascii?Q?GuqdE2Ye52G46BiNIhR3w0VDqaRsbuWsKfwV0Xjwa7g2Y+giCWzmEeUXHY/W?=
 =?us-ascii?Q?0NpTzUgLwVu5juNfFevA54op9h4vVm9c4jqY6lrvtHxxhqve9xmRuudcXhXM?=
 =?us-ascii?Q?DNXPN+ehBCunypLxWnxkinRMVC/oEudkJd50U23KJ3iN6v6sVidIfAFdlAbj?=
 =?us-ascii?Q?Un+aQzgqR3MPSEYA2JPnY9AqeyqJK0AJ524l0179TXlUNz7pYAf0Mpcpaqvp?=
 =?us-ascii?Q?+miR8qUREGTgG4A/3e9c6EXVp3Wk9vep8NOxuLIwKAmZeo8BmxKBskak7mH8?=
 =?us-ascii?Q?aURZk652sDrR7vY3lY3zu6Q17PWnjK7xr9RMDuLy8hBuQStzO/koZccatPgs?=
 =?us-ascii?Q?7MWilZg+P3GZZbkGk6KS38N3CjEU799mCmiuVMwwZ1eNagNGyZ6sMJSyCts2?=
 =?us-ascii?Q?+XNu2FilKV0fHbsZzvpUu3EaHj9yZuJ1ZFEH6oo3Kmfe5s4/FHbkGau2Jod7?=
 =?us-ascii?Q?sVzHeQBrAucPM/z9JFwQI50+xSI0mnZIiUFv5TqLNC6GIy7YeKJIp7FJB2rt?=
 =?us-ascii?Q?l866sOlEliT1IMYZPHy1A835xnSeeHk3uNbbQ4gPYXFjKOZ/8/uQQ3+q5CFK?=
 =?us-ascii?Q?tpjdHdtRUutaGaWfUfn53HIY5E95FEEMnAFEmC1OVYNUdJEMXM5A4v1Zp4JX?=
 =?us-ascii?Q?jax9D8MdWb+fJkUbnrP6EyGVxTUsotm5aWNJHKNvu8XAJ8S7EF6Yt8NlktR1?=
 =?us-ascii?Q?UiHm81W2D1Ycb8o06eoWPBuKyauSTZnhXJeYTBG164npjaGmrjz8wyfEssKz?=
 =?us-ascii?Q?fMdXhVs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8456
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	61f139ef-5196-412e-4ceb-08dd8c7b8b55
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|7416014|376014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?we6Gi+Dbq/qrs1EIOYZSSSc42rsWx/FrF72A5O9wS37Vz1iw2CDAY+bum9hr?=
 =?us-ascii?Q?nykO4BSGQ6nBW5Mjt+k+xZClxCcTNetr/Kt23XT4gwykexcqJlBFRVKBekVm?=
 =?us-ascii?Q?tn7R9zhPCK6XFpXE9rnBCFUFzizA0Cc4hyN5YymQPtEnqG8zOhFH5fDmExIs?=
 =?us-ascii?Q?SFTY3EmIjYkBpwN6SHBYOnTnEo6JBIpIHyAtzSa+1x0a3MbXAScBT9Xod3ea?=
 =?us-ascii?Q?Drl3irjRu4SgcVIiSwxd2yyQfZKLlipLLp9036WlH+fOIhlcYk7//KHXF5Iy?=
 =?us-ascii?Q?+AY3iQo4YHTYYosdP35HGa0o1MAHLe/hT0SbAxOcyxGJbhUFMM5tttnxL/Nu?=
 =?us-ascii?Q?YIR1GBmCrDf52BwVbLhcX8jJMVQH9HaB6TGtoHcsQHXwTvJEdyD05HsMCcng?=
 =?us-ascii?Q?eJsAB9VycWom5Vs/O2UvcG0BrZe6Ck4zQncUTEdHfqJmr6g4jTtCWFcxCGpD?=
 =?us-ascii?Q?LYIZRqhiBzauYjuNCD6eTxhxeS/NNfnso/D4Z1S4ZOybWbmsckR28d/Op4eX?=
 =?us-ascii?Q?hZvWNcMW217fQnJcTC4LWjXoqO7MRM4CMwUKVN7I18PVU1iovllnoJH5QjH9?=
 =?us-ascii?Q?ibDKwIbBbeFK+T1K5U3cl9S96hQuyaNWSAe4GiOGbpYsAGqO1klV2LwzTeEm?=
 =?us-ascii?Q?8zoc+b13CCC3DHpwr+1UXLPc0k3ED30H90HLIoBvNtA8xoAaHCOaQii3M2ar?=
 =?us-ascii?Q?MgtJxK6YntAugti1Kc3DFAAec+3WHHYvPCL8/xKYLMq0GtDswzdgvI+Wvjnz?=
 =?us-ascii?Q?ovaMKtQuE+a60mL+A3EQMmFO+xTb7bTYsStb84uql39Oa0Se34266xSfLIuT?=
 =?us-ascii?Q?CsK7miF2eXxJc99GbsWf4TxmCfkpxh2zHXUXtz3GiELG3QNUZZjkUK5P41Om?=
 =?us-ascii?Q?7ENIDGTZS94dnEiKOQX5o6uQkhiSF14pfyBw+7jIs17TDrHJ2dyEnKdEuLU0?=
 =?us-ascii?Q?KcbUfbVpdO00dlaPzCzuRLGnrSzNrTNZGmyP2Wr8+sDfCfoL7v6cgaSpNoiS?=
 =?us-ascii?Q?VPW8T/yzvw45I7HkeIwBju5s6wY53dYlbs8VigDWRCgH8LJ3LQATAuL96nZy?=
 =?us-ascii?Q?JYFey7nO6Id6xRlQfJE7elj2+Vo1jAjBguXy2WKBViqg9YbZHYHfvS4vJXDE?=
 =?us-ascii?Q?u3NWdHVrcv1Wve21Zknki4D7Y1ZW/nPHwlsjA0e18rPEf8pMFfJWGS8KL7yQ?=
 =?us-ascii?Q?1gwlMrOvr/zSOo+nZQ0+x6i5ISGHAQrhe3x2akMf+zzBp94/ak0MsTD06SNP?=
 =?us-ascii?Q?Q1qT7mO9+1JZ+m1h5eC4AabFcG5X8A1f9aTWp7Z3st2bB5UYwwSNEyOY56v3?=
 =?us-ascii?Q?ohT9MkfsetjO1zyh1cGwcz0epHLco5mm82fanleK8aUTxM0kenMpbXSs8fDz?=
 =?us-ascii?Q?ANsjum16EK+2MD6dZrhBq4+c3GLOlE51LT65bgh+iNX8k+zIIcACrJAQjRWE?=
 =?us-ascii?Q?oYlEHLlEZoHsmhsmvbdUGFL3XepE1QXNeztNEds1mlbb7spp9wtGIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(7416014)(376014)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:54:36.4482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a2bb6d-2971-43ee-7d74-08dd8c7ba0f2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10027

Hi Ryan,

> On 06/05/2025 09:09, Yeoreum Yun wrote:
> > Hi Catalin,
> >
> >> On Sat, May 03, 2025 at 09:23:27PM +0100, Yeoreum Yun wrote:
> >>> Hi Catalin,
> >>>
> >>>> On Sat, May 03, 2025 at 11:16:12AM +0100, Catalin Marinas wrote:
> >>>>> On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> >>>>>> create_init_idmap() could be called before .bss section initialization
> >>>>>> which is done in early_map_kernel().
> >>>>>> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> >>>>>>
> >>>>>> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> >>>>>> and this variable places in .bss section.
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Applied to arm64 (for-next/fixes), with some slight tweaking of the
> >>>>> comment, thanks!
> >>>>>
> >>>>> [1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
> >>>>>       https://git.kernel.org/arm64/c/12657bcd1835
> >>>>
> >>>> I'm going to drop this for now. The kernel compiled with a clang 19.1.5
> >>>> version I have around (Debian sid) fails to boot, gets stuck early on:
> >>>>
> >>>> $ clang --version
> >>>> Debian clang version 19.1.5 (1)
> >>>> Target: aarch64-unknown-linux-gnu
> >>>> Thread model: posix
> >>>> InstalledDir: /usr/lib/llvm-19/bin
> >>>>
> >>>> I didn't have time to investigate, disassemble etc. I'll have a look
> >>>> next week.
> >>>
> >>> Just for your information.
> >>> When I see the debian package, clang 19.1.5-1 doesn't supply anymore:
> >>>  - https://ftp.debian.org/debian/pool/main/l/llvm-toolchain-19/
> >>>
> >>> and the default version for sid is below:
> >>>
> >>> $ clang-19 --version
> >>> Debian clang version 19.1.7 (3)
> >>> Target: aarch64-unknown-linux-gnu
> >>> Thread model: posix
> >>> InstalledDir: /usr/lib/llvm-19/bin
> >>>
> >>> When I tested with above version with arm64-linux's for-next/fixes
> >>> including this patch. it works well.
> >>
> >> It doesn't seem to be toolchain related. It fails with gcc as well from
> >> Debian stable but you'd need some older CPU (even if emulated, e.g.
> >> qemu). It fails with Cortex-A72 (guest on Raspberry Pi 4) but not
> >> Neoverse-N2. Also changing the annotation from __ro_after_init to
> >> __read_mostly also works.
>
> I think this is likely because __ro_after_init is also "ro before init" - i.e.
> if you try to write to it in the PI code an exception is generated due to it
> being mapped RO. Looks like early_map_kernel() is writiing to it.
>
> I've noticed a similar problem in the past and it would be nice to fix it so
> that PI code maps __ro_after_init RW.
>

Personally, I don't believe this because the create_init_idmap()
maps the the .rodata section with PAGE_KERNEL pgprot
from __initdata_begin to _end.

and at the mark_readonly() the pgprot is changed to PAGE_KERNEL_RO
But, arm64_use_ng_mappings is accessed with write before mark_readonly()
only via smp_cpus_done().

JFYI here is map information:

// mark_readlonly() changes to ro perm below ranges:
ffff800081b30000 g       .rodata	0000000000000000 __start_rodata
ffff800082560000 g       .rodata.text	0000000000000000 __init_begin

// create_init_idmap() maps below range with PAGE_KERNEL.
ffff8000826d0000 g       .altinstructions	0000000000000000 __initdata_begin
ffff800082eb0000 g       .bss	0000000000000000 _end

ffff8000824596d0 g     O .rodata	0000000000000001 arm64_use_ng_mappings

Thanks.


> Thanks,
> Ryan
>
> >
> > Thanks to let me know. But still I've failed to reproduce this
> > on Cortex-a72 and any older cpu on qeum.
> > If you don't mind, would you share your Kconfig?
> >
> >> I haven't debugged it yet but I wonder whether something wants to write
> >> this variable after it was made read-only (well, I couldn't find any by
> >> grep'ing the code, so it needs some step-by-step debugging).
> >>
> > [...]
> >
> > Thanks!
> >
> > --
> > Sincerely,
> > Yeoreum Yun
>

--
Sincerely,
Yeoreum Yun

