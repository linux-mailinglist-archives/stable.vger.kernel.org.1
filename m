Return-Path: <stable+bounces-238336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC49MGgT4WnoogAAu9opvQ
	(envelope-from <stable+bounces-238336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:50:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0741207D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A69E8301ECEC
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC22BDC32;
	Thu, 16 Apr 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mEruZxD8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mEruZxD8"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB7A13AA2D;
	Thu, 16 Apr 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358242; cv=fail; b=SlWqmcn4XHeYf1WoMrOuix7Kjp8AQSqRO7Kp+TjRFetM33T5EFu1mz/qL2gMs3AZKLR2bqeU68kxvs2v+rRWBKob373muuBAMr8UELLHgbX4uPlawK+bCqVbl2ZcX9pJoM//Ob6N0YpCIU6it4EfkgNyO6cFMt0z3t+mLwHiNBM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358242; c=relaxed/simple;
	bh=j2sLIhMPN1vsOCXyBE4UDxgQeOmIgFJQUOuNsPuLS3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcY/zMKV1jutceqD389c6gtLh3WrAaNhVTklmyZVLZcOkAXEW6jew04BMqyDZEoRdEMN0bO2D8a5JrDPsg8zAd5mrt9RHjdHfCr5kBrHN4cUWxM9r8t5JUSofWKbEMiSTTT7M0LVbaN+pcD4lqw5Akk4yMfZY0dAX/woYB0WKIU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mEruZxD8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mEruZxD8; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ox5dq1W88yhLTE1FLj5+lKaGOvHiRDvbJBC3G2PBfqvcgTmP9ggdCJU97IDNv7oo2w9dooRHr/6t9j0LRQiIHMYnRnmK1061px4ziLJqoFgmo1VwmM5AnCKXq58DBw0cB/UdyEfV/o3/ubeljzgnF+ay4fthKY1fitdQxxQiq2fPbvxq3UXKc3SaUdmHGa+iZ9QYDuYIbKuRssiGCqBVLh1N2RRCGX9zUUVE1Y2P5FGwJHy03y/bIzVMlRkC7v8cP9MuBIdeh1pNJptVmDFlfsvXkVUhoOL7x7FXcnuZyeYt6GDG7aQqOQL6/UwJMyxb0tNSbEwFO1sxdjovu3V9qQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHc+lSM+avvTfjnF92yUxie4jq3JL7nq0ITM4D+8vKs=;
 b=tF8lZ1zURsyFj5vLcKJuhwsAn/apmV/8m6+3NaaJB5gHUGpfgX34iVbjL5p+webK9R5LbWw16kWG6G4igaxkBaDGizh8X3NV+brcqJZsOxKWfZDYMSRmKfB+0/Q8laxprGwmXZW4/jiL8ZfA3FLo1OhbhnSm3esTl+aBc2FVNRf+EwMgNjM7rPbhuCm13GKQOuMzu4Dp8tMEo/lg4cE/0F73C6f7/2+eiu9EzSkJeTVUZuteBh4YoUY5v+WULk0ZpPB88BuLgjit2BoavihEZtPElb4/e+tj9c/WyCxWmzb+OnjNJNfcTeIh4f6iXVDOISmti7qHmzm1zYvpDjdi7Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHc+lSM+avvTfjnF92yUxie4jq3JL7nq0ITM4D+8vKs=;
 b=mEruZxD8R3N03f6Aykt+AI+xrMSREw+aM/kA3yioYm6KDSJEtQFrD0lLGwLL+GYTJ2ravg+ta+5sg7phj9RyX649LYRQFkI2ysJ54QVv2KJKSRWKM1dqZLQMYJL9h1jGkXbeIgG0O8vQD+DaQa1V2ZKLei55SxC5c6YMuQMIfXE=
Received: from DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) by VI0PR08MB11353.eurprd08.prod.outlook.com
 (2603:10a6:800:2fd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 16:50:33 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::bb) by DUZPR01CA0081.outlook.office365.com
 (2603:10a6:10:46a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 16:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 16 Apr 2026 16:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLq+cIc+pJ8gwjkiWD+JY7G5COvOnIb1hJ7kulzILXVLMF23XLcHgNXqzelhOrBNHf02BhQPOW1RXU5/y2QHiX3sm5nabh4ywCaUs1K/CJRdaQ1x82ql5UFddoI+fgN7fc2da0kpn+T5Lo2zcO2kCtFo03mA/nwsVjp7aBPrUTcSCCi7K5il/HlgdbMb8dw6zAONuLeUGfV2BqMQWo9MnRTjMRWQKC3arP4mRmiEkOH8YtgBHVf9mbaPvvec+NCf7nxaGi1U822rQRkIE75UNK/GTe+kxHt4m/P+XD601fREbuHiDRpR6IGIgHIYfqLxy5z8grGuLWbJSXan1RlAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHc+lSM+avvTfjnF92yUxie4jq3JL7nq0ITM4D+8vKs=;
 b=JqmhsmMtVZtEy/W3M4ju9cm/CbtmOFb09kpsJWWLjB6+R6zrlX/gvHJ6Za47UER/udhQAHj9ptZIK4gHOeIw+kA1ciGTdQziKpGvZFjaRhXfAEuhVDyS1Rhey/t/hGZjs20BlMeiBch4nGnP4PQEpTN8I8mX0xObTgSptHiiaOZLA12c0COLg+aUB3v01PlqFm+iw1sJ/y0ktMdF9xQ36P0PJKP3fCCcbM8KUU6IORP/OjpT/MfCs7kMXfYcjhIPTJKzvelrpDv9SRigiWrFwWSOtdc1Lqjj97bTIXb6Sn+zKgqUI66r/Ly5nRfZnNipPITAzZ48z97CzibL46NKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHc+lSM+avvTfjnF92yUxie4jq3JL7nq0ITM4D+8vKs=;
 b=mEruZxD8R3N03f6Aykt+AI+xrMSREw+aM/kA3yioYm6KDSJEtQFrD0lLGwLL+GYTJ2ravg+ta+5sg7phj9RyX649LYRQFkI2ysJ54QVv2KJKSRWKM1dqZLQMYJL9h1jGkXbeIgG0O8vQD+DaQa1V2ZKLei55SxC5c6YMuQMIfXE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB8451.eurprd08.prod.outlook.com (2603:10a6:150:83::17)
 by DB5PR08MB9969.eurprd08.prod.outlook.com (2603:10a6:10:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 16:49:29 +0000
Received: from GV1PR08MB8451.eurprd08.prod.outlook.com
 ([fe80::bfc2:bb63:61bc:7be6]) by GV1PR08MB8451.eurprd08.prod.outlook.com
 ([fe80::bfc2:bb63:61bc:7be6%5]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 16:49:29 +0000
Message-ID: <3eaf217f-8e1e-4d64-983a-6b888886f157@arm.com>
Date: Thu, 16 Apr 2026 17:49:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
 miko.lenczewski@arm.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jamien@nvidia.com
References: <cover.1776286352.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <cover.1776286352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To GV1PR08MB8451.eurprd08.prod.outlook.com
 (2603:10a6:150:83::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB8451:EE_|DB5PR08MB9969:EE_|DB1PEPF000509E9:EE_|VI0PR08MB11353:EE_
X-MS-Office365-Filtering-Correlation-Id: 483cadce-0b4b-4cea-1fd4-08de9bd84668
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info-Original:
 7opSwe+yBT9dIU+5nTYAwZNRTiGckQv9mt9uJnTTBLUOztwG9qX4g7unGR9LShImiOEsZGAuaG9yjK5Qrc679rmJn8QwcbEDhgC+r6vXLI4GdIvJ2vDS7G2/OSiCI6ridasClBDyG0XKUV4G3H+cD8FhIa2F7e3i9ZfRpfaLzV79lyK592EkWmYPkgVNA8Mckz+lQ8JGX+9vceoE5xSpq0PDdz/KyionMJ6AdcKUfoNBdeH8NBmsuZmZH6modxrggMYp7m3UdcFtKx6/PGo6069ZU9AwVfvqds13tN35PfJYbygodCXCMuEMICVbkPIGb4cMBw7m7NR07MpyPBAuUCXzOoUvLsiZyh4z9btKW7k7Z82+a8nwL4NY4IfLmpGdO7RG7RWQD/lxZR+dvbcHKhGv+m/AxQ4dLL4J8VsutCpn2PcK1WB4fz/3wkcvX6oPXH9l8g7tAMs+O+/3uiVnjI+LB9Drv25DJ554AnZdWjGrtXfxuFe+Js1NW+8VNUP47aiE6bmavlqXxs5z7kSRuwUYqcerwoITylHOx9f5+41NxSF9cFqx/4ttzMKljcd3xhDvkJReopCUnayxxXYToKKL4qGmNDOd4B6MawZUqHj/Udp508R3WNG/w7aoqK/jSKvMOsh2AQ8X8LCn7FSvwkVhLk+7B7wMPUKAg7+hNYK6V+mxhgwUlJRQjO86lb4upikNqPAcNN1ufljDV62SY9xsHKlBIx6CZf8l2X5kRN/G99fickWN8PyDOwj0inud
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8451.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(18096099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 mYvT/yM8SZ7Eb41nAhkURus8cXfG76vTJ8jnfvLHsG0bxpE6jYRSF0+H/CtnBeOPPnOIAZT1scref8fcmCAA2l9OhQ6lAZ9M5qlHRz6mpElERywJNQ/ZT7GurzO6M4S+e3uX0tufsRPEIHar/z5VBeSQX19YCcruTP5dtF0MTwl3R4qiADBXI7LHy+rqSmbPY38PMGM3Z9be02ydRfwx4odDB91KphoHZH8+YlEqWBrHX3STGB4uvqtLPWMGmEWlZfeZzQhvlrPivSM71qS4dHLYt3bFCyX4KQeu3EdB7xtuTKtQl5jSaEadGftq9k4kDq3QHVBTj9j4P79EjWGnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB9969
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6b1c40ca-cd73-4a29-3eca-08de9bd8201e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|7416014|35042699022|376014|36860700016|13003099007|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	26I0Ra/pxuqRiP0kb6UEGC5Kvv9q/paDqpHU4YB6SS3r8zgQzHcX8NCfBqtHVWOz7TxD9wFJBStqHbGNIDkNW5p6vmTxEoD8etJnHVHkQeks/Xb8o2iXf/yBYa3WnOkQ47whW3IOp5c5hGBBCbUMu/oSCOkfF2V3ZNnNGgjUYxL2Ck+eiO9B5aLVFzKl82el0LDx1mC/fZtkEunFIkk5R/L84TMaIm9pZ9/57llrA9XZTRWt4nwSUJDIaGhF8ygfS7Odhgu3zJ0Tw40uIbkvN2nzioIsj/t4Ut2yDcWlKjGjQaYmMGxQ3bVtg9XkCZ/qfK+wu/sWlla+sx70O5RwYgZIvK/c56nrmUyiCvuKVsH1GrNJaPuJs/d8rK375F2t6UC08nUoMzrAHgPIqYjmiRqT6aWLOsmelUjRy+89gjbwB83lxMHx3gV3sM5pL9xOKcVlG/dOy7dohTUvz2dQNM8Uak+Szh2KIizFJTu4+iE5YLk9E7u86FkYEgRlGcreKKz/IiiXkCVaLBha+qyFSEOMZ7jMyGLD55yMgkDDo3gS3xe+rQCRpV3eyS8qC9tAFkdFgsYk3aLpfWvngg0pRX8k+GmD97Axds2+cN/55PEUN04Lo3XnDHYIse3ZNEG79TD4yLERVWBZ9/2gdyYZVL1mJ/QXSWWO5YXAL7HocHWCOEDJ5zjBWV7/klAXZ02qmcPcgYU44vWHW0TkA+hub0v4aydA4/AGyXlsHHYMk2vV/Rhp8LK8yeEyixF+L1j3GrW0AMQVuGnDlJRrmt2QfNdvMecfR0VOInyKaksVyc8=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(7416014)(35042699022)(376014)(36860700016)(13003099007)(56012099003)(18096099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xTAr1uD75z2giqyyY0/toAPi50gOy6WRUwecv/0GCod44SuGoE7anqu1E8Q/MLRHKXdmTcf9i2RvlRbKLA80MqHNfUdAtbP1vMoZk8qZOM7/UJaPL8Q8QFzccXu9BZfu7Ghy965HygakoQVEoqOU4TJVFoDQin3vf9t/TcxQOjsGsUVkM3J7w4Nc62ZVpcnyaqqEl3t2evbuSYZZkqmU4VHWutoyHHMq2QbDM3UvUjDMjjGhcTAzsEaIj4RYv1P7CaVrKSCWtS7bS6lSl5wePktTSpqB0wLdu+8EXWJlm+X6I5q6QUJqDKeb6ymcHENAgb0CfDExfMhPf+YE7nOl+EjOwi04onY2gfimPOcTaxZ+2uvXRbGAljcIS/vD7VSWUjHsz+o0eS8lsiFmHlvHJYPhrqTPuD/8lO74E/zMNW5Ue4y1iX95jmqBgzby6fEh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 16:50:32.8671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483cadce-0b4b-4cea-1fd4-08de9bd84668
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11353
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238336-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C2B0741207D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15/04/2026 10:17 pm, Nicolin Chen wrote:
> When transitioning to a kdump kernel, the primary kernel might have crashed
> while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> and setting the Global Bypass Attribute (GBPA) to ABORT.
> 
> In a kdump scenario, this aggressive reset is highly destructive:
> a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
>     PCIe AER or SErrors that may panic the kdump kernel
> b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
>     the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

But wasn't that rather the point? Th kdump kernel doesn't know the scope 
of how much could have gone wrong (including potentially the SMMU 
configuration itself), so it just blocks everything, resets and 
reenables the devices it cares about, and ignores whatever else might be 
on fire.

If AER can panic a kdump kernel, that seems like a failing of the kdump 
kernel itself more than anything else (especially given the likelihood 
that additional AER events could follow from whatever initial 
crash/failure triggered kdump to begin with). And frankly if some device 
getting a translation fault could directly SError the whole system, then 
I'd say that system is pretty doomed in general, kdump or not.

Thanks,
Robin.

> To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> flight DMA using the crashed kernel's page tables until the endpoint device
> drivers probe and quiesce their respective hardware.
> 
> However, the ARM SMMUv3 architecture specification states that updating the
> SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> 
> This leaves a kdump kernel no choice but to adopt the stream table from the
> crashed kernel.
> 
> In this series:
>   - Introduce an ARM_SMMU_OPT_KDUMP
>   - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
>   - Map the crashed kernel's stream tables into the kdump kernel [*]
>   - Defer any default domain attachment to retain STEs until device drivers
>     explicitly request it.
> 
> [*] This is implemented via memremap, which only works on a coherent SMMU.
> 
> Note that the entire series requires Jason's work that was merged in v6.12:
> 85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
> I have a backported version that is verified with a v6.8 kernel. I can send
> if we see a strong need after this version is accepted.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v2
> 
> Changelog
> v2
>   * Add warning in non-coherent SMMU cases
>   * Keep eventq/priq disabled v.s. enabling-and-disabling-later
>   * Check KDUMP option in the beginning of arm_smmu_device_reset()
>   * Validate STRTAB format matches HW capability instead of forcing flags
> v1:
>   https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/
> 
> Nicolin Chen (5):
>    iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab() for kdump
>    iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
>    iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
>    iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
>    iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP in
>      arm_smmu_device_hw_probe()
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 225 ++++++++++++++++++--
>   2 files changed, 207 insertions(+), 19 deletions(-)
> 


