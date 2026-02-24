Return-Path: <stable+bounces-217944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGsYOxsEnmlaTAQAu9opvQ
	(envelope-from <stable+bounces-217944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:03:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE418C426
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D57043050D5A
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4A3346AB;
	Tue, 24 Feb 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LIuhPlKx"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A82DB7BF;
	Tue, 24 Feb 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963410; cv=fail; b=ZoI442TGEmTO0Pvb7SvV+PgDQ1KvtMSdl+dwYQnVexquNPiQpPK0AmZYXTOgbPJDntndX4K09e5xNG6O9Wbf+qXVPqb4OOZijLrJXW0WV9+/NJfpB9U6/J3NVT4wFT4J3ogJTDzSsYanHDHOryzTMAOzEG6MC0DFtluqJlfUjIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963410; c=relaxed/simple;
	bh=EstqVgcoj+U3Qqi/UzuDEQ9ULfVOhfmLcT/m9D5DF9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RuTyBZNBKsolcYkQYlQvuJuoo7vOWpLBmqUoiVYgbPxmUCs7JzxccoSs2VGhZtuV+JrHvnB8eilgXbhimIkrnfkB2YESRV2w+1/qQ/c2C+oSL2CjKjvyof8oaeeVNeahI9qR+dnHQvc1+TNhc7bIZFMbqpp1mM1urU9HmXpTcOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LIuhPlKx; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFOgfuFYOhdndykDfefqjzC/CNiEIMzF9F5r4mGzzx9eNT2Q5wDm58DuOk7Opl29QpB8K1fTcObwM+Xg4hMIKeY23A5EQZKq36Ni3Ls/Wm9lKrXxykPtDUfu/nABQ6ptQh5W1JDjLOzN8a4G4PHqK7aOvkFoW4AXdCoOXNI/IJGsGgddDBi41cuYpxFY03Pknbo8QYxmwopCTscRmZ2RNAthM1DcIughSyba0sr3HQI3hHnpHcI7EVOaehWNU5DgdwMj6ECk520FSvcfc7di0yTHEUg2ZneVzKIX46fdwt9zomVq550ygVqBIrUaF6+orkzKtyP6C8HBCBkphtxA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76QJ1KCKzBZiiZYQbuarwk1eHYqDtzbS0LsMG+ylHZ8=;
 b=EZPXBIJ54xHxCBwG7hEbKbRORdj00x6Zy59jvjNQGvNDWvJ3eEiRtDGMd5eYUuLxTvw7SoF2Db9WRb9vZJPEsTk9RHX3h1jHpny/ipY7/7njZOJWYBUzGCjGcPasHDCR2LdiK9p6aJrgG7Ps0+y2lz+67+eLEk13gkOIWK5LXc76N8/wLxd9PFAsWFjpjHVMncvhEJiN+FDktd7CJlOXkR1Mfgn87E6GLb8N45jNPBnpLW2ov+qgr+83eg5lidEDqQYIaDamRuvXNJekWEENGMAwt6q9I2n/pyauV/3x5mYAuhY++oLKIUiSxUrkSRolq5DeMhs0WahMKct1QEijPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76QJ1KCKzBZiiZYQbuarwk1eHYqDtzbS0LsMG+ylHZ8=;
 b=LIuhPlKxY+eOdQ5pH6aze5YDkL1xcpxMXA/EypXataLExPa5jDH8rLzDFuutU5sZrKYU3XOR82PlGkYJjyP7xb6/o151C1VdP9Nq/5tqRGPCuM/BO4wRiNJZE0IWUf8dE/k+/7xZFkVCEAZfRPdcpm+ZRGI4uwE9V7xwPyxJTHg1oWGX9XgP4DBEO4exGuNvJnXKc0GDi6GjE2pRIf4k8dn+hhMdRlv0t379U17Qf+c+us8DAGlgAlklS3Qe5KgXjMJojETomwdxDtHXCqizQewIrd2xd+apS8Yb2JA70/jTdLjFOzZDqNVXZpwm5dtRwYbK9Ou998pWBzxIrQV3kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 20:03:27 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 20:03:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx95-toradex-smarc: fix PMIC_SD2_VSEL label position
Date: Tue, 24 Feb 2026 15:03:09 -0500
Message-ID: <177196338262.3249972.2074583461103332539.b4-ty@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
References: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5f50bc-3977-49d1-50d4-08de73dfc5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUdQWFZsVmY3MUprSDgzcVNpdW9Ha3dsTWxkci9NWjNRMUZzbXZmRE9ZMWR5?=
 =?utf-8?B?N1BRRmtETkRQZCsrZVVzL0kvTGJsdzFCOVdYVlU3azlvQmdYbmFCaHdubGEw?=
 =?utf-8?B?T0dRb3hKeGs5dDBaN2tabGtzNnMwQjdvOHgvSkpwRGtCaENaZTkrVjdtYUVY?=
 =?utf-8?B?emxQMVI2SmhuL1ZHVHdRZUJjZ3BtSFN6dnlkaElDb3VJckFvUTEzVkp0cDEr?=
 =?utf-8?B?R1JCOURyY3dtUVlPQjlkWWNiS1l3L2VwNTZGQ2hhZGZjbjNmbEN2WFRqUXBq?=
 =?utf-8?B?WmN4dnlwdXJSVTE0ZjVtR2VMOEM2R05aeFprUUxmK0lSdlRIQ0gvM3NMMCsr?=
 =?utf-8?B?YW1YREc2WkZOM05hSGkxZHV1eW5aTVJHWlNqbzNGaXZYTFAyMG8wWW1Xb2Nk?=
 =?utf-8?B?czVaRVlkV004VlVwOE5SeUlyYm5BRjBHKzBxNVdxZllZVzBVRG1iOWpKZ3kv?=
 =?utf-8?B?enRsaklDR0o5SFlncFpjekVnT0ROYjFjSGh2UUc3a2NyVU91cXllUlpIdW8y?=
 =?utf-8?B?Qi9LQVNRYWlMU1Z6ZTArSHd2cnNrcTRCdWx4MGpmZXJLN29LMmR1S3BCelJp?=
 =?utf-8?B?cTFWOUsxNGxYOVBHUHBRc0NPL3EwYURvNVB0SFdzN1JKSTN5L3VDWmdveXor?=
 =?utf-8?B?SEU4OC9yTEROYnFnRkxYUUorOFIwakJ2ZE9NaVhadThlL2lYUnZJNnZESGY3?=
 =?utf-8?B?Tkg2U0NyWk56YXhZdE9NRVpvT01Bekw4Y3h6WTlWYWxiaWtiNWVTLzZQVlRN?=
 =?utf-8?B?M3l6ZTlSTk1oZkhxM3dRRUc1clBRYTBXcnhsZ0taeDNzVjhYVVRWbTFST0dq?=
 =?utf-8?B?VGFHdDJnSklRZlNMcG0xZ2JMUzZxckkxV3poNVJxQnZaSml3V3RRWEZNeG1M?=
 =?utf-8?B?SHpNaGoyQ3pXRktPRXJsdzl6Tm54RSszU1NLV25IZ0o1MW1CLzc3VTV3SWJR?=
 =?utf-8?B?MVJVVndJU0ZoYlBXSDI3dW5PTEtJYU91L2hWRHNaT00rd2xueWd2alQ1UzlT?=
 =?utf-8?B?MUY1MlJlVHppeTRjclQybjlIcW5iZjNZSVVBeCt6N1hPbWliMTIrODc0Rjcz?=
 =?utf-8?B?c3RzQ1Bhc2RCK3FkWFpmMzU4RVZHR0JsMzlvb1A5dUhhR2k4WW9RVUNtZmNI?=
 =?utf-8?B?V25YcDg1YUFWeW9TOGxmYXo0eFQwYkNFWFdaUkJZOFV5ZFpDWjdVZ1BNTmdZ?=
 =?utf-8?B?b3oyVndWa2Z1NkZQaEhWSEZ6bmJFVDVkRDhBZ3VDckVuSmJ5K3d1bHY2Tm53?=
 =?utf-8?B?LzgrZXpuSHA0NkJRMVhrVkxZRytBbVh4aThyUFQyZ3RFVU5yd3g1akR6bXFY?=
 =?utf-8?B?a01zN0pvT0FaN0NuR3JPTWVQUnBjem5TRElJcGtTZExINi91c2RMV3k1YXpP?=
 =?utf-8?B?QlJ5ckJxU1p5VzdzL0FhUVZKU3ZWTFdCNWNoanlNZXlYSWRqSGJFanBDdUZ1?=
 =?utf-8?B?Z3Fac290cjNHTHNDMktrUHdhdExYekgrYUtjTEZEK3FzbFE4ZWZSU2NLSjNP?=
 =?utf-8?B?N1dTNGJWaDYyaGZXd0l4R3gyaGZFZGFIOEw2WEV0cXVYRWwzRUMrbmw0c1VR?=
 =?utf-8?B?bTkvTlBlZjlSb3A4RDBqL1VnUWJ1bjlLT3FWQkxMZVF6dlowNHhnYUpRNHlk?=
 =?utf-8?B?Si94TDV5RlBlYXdNVTBiY3g2L2N3YTR5c0xQYWdVQzR2dWhWa0NRU0tBb3Ba?=
 =?utf-8?B?TzFodDdQa1NVbWVjdmNmSEtUdFhlR1B5QnF5SEVPQ1YvckNidGtJUVM2aitM?=
 =?utf-8?B?ekhwWlp6c3hOTEhyejRhRlFXZjhub3lOYkFPdk01d3E5aG5Qc1FKYmdoa0J6?=
 =?utf-8?B?dE9wOFdOaFAvanZlbUF2WC81UFpsQ3p0WkJNSG01RTE4b1pTQjcrSDRWMTZy?=
 =?utf-8?B?MENkN2R6TUhreDZ3eWJDbDJwSnNRMzIyUENWT3FWazlRSGNiSWpCM1NjQXFT?=
 =?utf-8?B?bXJwRzhyenZOTzVjK2xYL1B4czYvc0d0eGEwUldoU2pzamdBVGN3TFNkT2Rr?=
 =?utf-8?B?RVdyU0ZXME94VG0wZXZVTThjbkVmck5rMndyUVBBcWpvRGtzYWpydU9wM1BL?=
 =?utf-8?B?L0FUcWxCQ29rQThvcmlEMHEyZTcxU3kwNXZMcHdCL1pULytjRVBjU3h1RXFV?=
 =?utf-8?B?R044UzVhc3BnNXozeDdyRzNvNExZYnV2SUJHMzZ6T2hsOWR1VzZNZERpUDZ5?=
 =?utf-8?Q?4qGNgrpDILXUU1VdLkC/kaE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzdVeTROODR6UmliUFE3ais1QWhTUWpreHltMyswRnVtQmRLT2RENXJsTGQz?=
 =?utf-8?B?dHpmcTdGaWNrOGtzenA1clJSWStzam15TUJOaXk0dWtQYTNaSndQb3UySzR2?=
 =?utf-8?B?dzhxYUZXMGNKanoxTnp2SXFEaVVCSTBHTzdNLzhJZGFsZWZUNEIwc1dLMkJP?=
 =?utf-8?B?VjNSWGhaRkxlUDNkaUNwRXhONk5NL0NQYzFuaFlwWHk5WHVFWG00a2ZrMkVP?=
 =?utf-8?B?VEJxOEdzd0tHYkVDS3hrNXREMG5BdE9vU0N4VkdxZWo1V1p1bHdLOWpPVDVy?=
 =?utf-8?B?UmlnNlVYRGd4ZC96eEVCbXB3Qmp5RXJmbXdFUkJCSnFva3ZPOU1oK2xONmV4?=
 =?utf-8?B?WVREMjJKWldIVW42bmh1Z0JiMGVVUm9EanpOTnVOUUNWMVQ3V3daSU5tZ0w3?=
 =?utf-8?B?TWZoM0Y2NThrcFpUSVhFNmV5TFdobkI4Z2I1Yk1HR0R6R2ZGNEZFeHg4dTlX?=
 =?utf-8?B?dktob3Vsc1JQclBxNkJpZmR1RlhLdmlXalNuR2VyVWMvajZkcWNBb1N1TTBX?=
 =?utf-8?B?REc2OWFYaStMS1UybmxIN3lHaVFZdWJ5dDZPUG5leW51bGhpeDBSZHZyMWpX?=
 =?utf-8?B?Tlpia0hTdW1sWXBHdDQ4OUxmd2hldVYxb2JHMzFkZGorVTd1SEo0SkVkT1Bw?=
 =?utf-8?B?eldmbWQ3eGxaZkZ3MUl0YTVtcVoyTUl2WHJrV3Q5QmVWT3puMy9mUXVGeEp6?=
 =?utf-8?B?OXZOQ3JWYVkyTHRPYU9JZVdGLzBBRjNhSWpxaEYrT1UyQ2d0MVhEd0VPVDZw?=
 =?utf-8?B?VmEzd2NCa0xiWXRiV2MzeU40M3VVSHFrZCtJQTl6Q2Zla3B0SmE2VUx2aG9r?=
 =?utf-8?B?aUNDUnIxd3pJeGNjckV2WVR3SkZnY2ZrdW5EQmd6emluWnZSaGZSbnNWR29n?=
 =?utf-8?B?VTBSOTdzQ0EwaUJDZDRDUmJJVUN1RmN2SklGSUh0Vlp0V2RqVG1mSlVjSk1v?=
 =?utf-8?B?SG82SzAvbDVOeUdkaTBYbG1oVEY1VmZobWdzMHlma3RxSEtiZ1B2RFpKOGpt?=
 =?utf-8?B?K0dzbEFKUVpmWnY1MUdBQm5ReXk1cmVWWCtEVThpclMydFVqL2NkaktHbkdB?=
 =?utf-8?B?aGdxMXlMc3VBejNNRFFobnVxaFowZzUrWGM1RTlkR2c4SnRJYW5HV3FlSWtt?=
 =?utf-8?B?ekh0YmVUZ1hTUEVnTXJ3a0RJek5FbXQ4c1NDT0xjaXp6OVFpUFNMUFREWGgy?=
 =?utf-8?B?anhtQmFLVHppbnhPdnM0cDZoRExVbURGR21lS2ljYWVQWE1qTU9PdGZsd0JG?=
 =?utf-8?B?aTdFak1jUEVmQ0wxZGplSU5UU3FGYU1ieGxPbXdQM3JiV2RJdlZIMEdIcWd6?=
 =?utf-8?B?aThSK0tMbGQrVDVHdWV0RWJLSy9EUkRCZlk5OFBHQXVHOHZNeXhkNXFqdFRP?=
 =?utf-8?B?dzFLZ1hCSjBkYlJGRUdrdHV0T25TWWd2b3AxeEV1N1hCcndlZW8rMTVNZ0tn?=
 =?utf-8?B?c0Q0VEs4VktSM1NZbW5OWGtDTXozYkhpOTBhMkV1OHppd0tCUzFZYWlSVnRh?=
 =?utf-8?B?aWFpc3dNaTlnTUxrcitWM1BOeDFtYWUxOTFPdjFROEFpQk1JTDg2T0gxL0JF?=
 =?utf-8?B?K1phSGx6WEJ4L0RyS2YvVzFXajhzdC9xaW5BeDJZN0VocDVlcEZ3UWZvVmEy?=
 =?utf-8?B?UVVSWVZlMjBaZjhaZHZWNXRPT0htN0tmYkxTYkhDekJKUEFNK0YwbWR4S2Iv?=
 =?utf-8?B?TEVIUkdwVEt2dmdGSjZodXJEVW5iZjFkMmp3dmhERnNzeXpHSEF1eVNGb2tQ?=
 =?utf-8?B?QnAzejJPTUhkWEN6RnJIUUEvRDVldEFsLzhSbk9jVXlDbjBGNzRvRGpCb2Mz?=
 =?utf-8?B?NDUrQnA2WXBvNHJHWC9RcVEwTS9CRWs2NkJGY20xcG9HTEdNRjI2aEYwYkc0?=
 =?utf-8?B?dE41dEZETEw2YXNzVnViNkVTckRKVDMxRHhWYnFtQk1mVkpOYlV5Nis0S2Rk?=
 =?utf-8?B?U1RwdkFaVjFEVVhZOFhMUEwrUU55YVFoUzc5d3ZTTFI5UytHVjZxM09Na1VU?=
 =?utf-8?B?WDY3RGd0RzdpZUFidkJHNm9oc1Eza0NCeEQ4N0VadVpmbkowTm9iTVdVOHN6?=
 =?utf-8?B?OFJ0T1crZjJrNXo4WkVEQlp6KzVRT3h3cWwzcDJ1c0lvSmJYeWlJeWxKbHhQ?=
 =?utf-8?B?WXd6eml6ZFpJOGlhbzJJSzdYMTZDV3VlWXRLOTZYdlIwc1p3emVSbERNeVdT?=
 =?utf-8?B?SGJyN2x4RWVReGtxTlF2ckd1cWhidjlxVFJTLzh2NVFuamMxUTZoQzVTQUpZ?=
 =?utf-8?B?N05FVDBDemZIcmI2UXJ1MG82UiswQkRWS2tDaFk1U0pmNEpob3BJMWhRWUtD?=
 =?utf-8?Q?QrCe9ZUw15ar0Esu1B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5f50bc-3977-49d1-50d4-08de73dfc5ac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 20:03:26.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DixnLyrou/C5Xqy6qb+/WrdtcxP0nhlsZCFCz27aFDfpb5YbC3Kvc0vmE/E5pRR3JIwLSTDMIDldojQLj7h3LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217944-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 50BE418C426
X-Rspamd-Action: no action


On Thu, 29 Jan 2026 11:47:35 +0100, Emanuele Ghidoli wrote:
> Fix the PMIC_SD2_VSEL gpio-line-name position. It should be on line 19
> of gpio3, not line 20.
> 
> 

Applied, thanks!

[1/1] arm64: dts: freescale: imx95-toradex-smarc: fix PMIC_SD2_VSEL label position
      (no commit info)

Best regards,
--
Frank Li <Frank.Li@nxp.com>

