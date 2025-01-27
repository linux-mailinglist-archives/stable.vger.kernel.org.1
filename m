Return-Path: <stable+bounces-110902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53140A1DD2A
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3478164D98
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782B14B942;
	Mon, 27 Jan 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="A2/vmt5x"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020139.outbound.protection.outlook.com [52.101.69.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999253BE;
	Mon, 27 Jan 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008542; cv=fail; b=J5kIXHPfk7BzUlHYPoa1/V7X7+gmJEhfmeKRi56lbh6QQ42qlxqu0COThhpCTBFUHCZOY7EGqHjhZLDWKN/Nlw2WLa3XWMFLPy+izdeEPKgpy34mY/6X1onAhtIuzaVmktZMYchLyrpVz+lPUvveA1sDo/G0NUdg3T9mXZWY4E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008542; c=relaxed/simple;
	bh=3BU0XYqnTofd6p8kS5EGCgJch2wu8xAn6t0ot4wNMCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YnG3AWZwS5Um2zj1P2j70YVGFt4l2B+d2EMMIfb/qLyYntc5JWr3kOpbVaGqRr58i1cOLzLiuztEDPEj5IzcaMSsv2LEXPvM8Gxi/vyGHeLlmbp9oqKlT3AhaqSCtyrNgYeby00U6I+ubupKzOBEk3roADmNAmbef2UliaMpBLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=A2/vmt5x; arc=fail smtp.client-ip=52.101.69.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIhVbqZ4sQkzBY9/jfeTo/tSldiTYzQB0DSJTrxHVY640yaMfmM1z1gB2elV87bvxZq8WDDykGBgX/SS1kaq6I3kmaRubz2E4QDAa7eiHU2BJsYDm3d1yYG3HNbWZkEOyG7sAqr1U0B1PZyLozOSBXKnKZq3mpDBjEmUN0msOdxlTLTpqMhT4Cbn5e2/Y4WiV/6Q2DDo/EsRFqC5ByMGdeytFwPn4ESMYKlSoaLI1cAVP7rYKyylMkh5a2U2N5TjBpCa9iHoFj4hmJlar7y4b6u/OsyQ7oF/0GqnuZCDjUoAy/2hB1mHyyasK1A5LWdVCBiaj4D1RAPiIHZgjru8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BU0XYqnTofd6p8kS5EGCgJch2wu8xAn6t0ot4wNMCo=;
 b=S4zSBmw2aJCLQoR0+DrJFFy5eH3Sr5m1ABD99uZEH6TypyWAHsFIGPnlpUpDIm5riUTThCkoCoKClA86Si0cKMADOYF8Cdh8JzySY3liv0k56GhmT3Wxo6sxL1Q3mmd1iGP7CCPM2UIUIyFoJR1cJ4wu74LaiEiNsYh+pN/7rZbc7JZvmYFmeE4j8NiONHT8jGHlKdNMPRxsrWt71M/+f3AufB4d0Xf9lpmDR1yT0VES0P4p+5X8qadz485Al9SM9jz6H1tzzXBqBp9aFVpPuhLEBxDa9+SiXyqa7kU2YX34nBbccoK1pWTHwjw7TtdoNm1z33tRrbICFOKv3hLmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BU0XYqnTofd6p8kS5EGCgJch2wu8xAn6t0ot4wNMCo=;
 b=A2/vmt5x/kFGJT1wLGzG7mQ59Q27aWhHR4pLglNtIHWaOBcYSx9RmdedpQj+nMRKdDzHhZFNypvomHP7pIHAXNNjIjsOY5FFDfZNLpcydeXfxLwP7shMqBWLpcwTYgEJARnHif3n77AEUce3ZlrfhHX0YMDdJw+v8T8UczoUghk=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI2PR04MB11027.eurprd04.prod.outlook.com (2603:10a6:800:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 20:08:55 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:08:55 +0000
From: Josua Mayer <josua@solid-run.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Judith Mendez <jm@ti.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rabeeh Khoury
	<rabeeh@solid-run.com>, Jon Nettleton <jon@solid-run.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Topic: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Index: AQHbcMBZtETYhqv2qEqDXmydV8m4ZrMqpt0AgABmNgA=
Date: Mon, 27 Jan 2025 20:08:55 +0000
Message-ID: <4baab328-f78d-43d0-b67a-d31865a8dbb3@solid-run.com>
References: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
 <c96e691c-09e5-425f-804f-054c57b4ec2f@intel.com>
In-Reply-To: <c96e691c-09e5-425f-804f-054c57b4ec2f@intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VI2PR04MB11027:EE_
x-ms-office365-filtering-correlation-id: f80234ff-50a3-4ea1-c2ca-08dd3f0e6d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q25Zb0ZHcmQ0Vzc3WjA2UlJtYXF3U1NGdG1jajF2MmtiUThFaXIydmdDK2Y0?=
 =?utf-8?B?R0YzVkNxTklZWUVVaE1jR0k3eU9PTVJ5ODZaTkh5eHlaZWg1T1VDTHF5cm5C?=
 =?utf-8?B?V3V2Ykd6aTVQYjhxMGt2Y1BHTVAvR2JkNVJNTEVENmZlN0prdzc4LzBXQkZM?=
 =?utf-8?B?WWNNVlBDbjhuTTNlSXhrRERESEgxNHJCbHB5dEZzMmMvbGpaOVIvOGkwVGlm?=
 =?utf-8?B?RVZ4ZnRlRW9NNDNrQnE1c1FFL0hYL2kvWVhQN2c2dWhMOXFmYnE2cGJ3TnBw?=
 =?utf-8?B?VFQ3UUVOTVhKUWxNbkIvU0ZMYlFyWHpsQis0QUVlV1NYVmxYRlY1L3huNDA5?=
 =?utf-8?B?T2RaQUhkZWZIMGt1L1JDZ3VqYnl1ZjlxaDhTdVhBTDlINnNnTnBQcTk1VTNh?=
 =?utf-8?B?Z21UYStUNXppdmZ5U0ZDU1ZrS2gyMGZmTGRDR2w0NlFOS3FVVExiNW8wR3hp?=
 =?utf-8?B?S2hCMno1c0toMHpsQ08yZFdsKzIzdXpvaUtsdjFyWTRrM3VvWitteVZxVG9z?=
 =?utf-8?B?Sk5DZEg0bHJJNDZ0NlRJOHo1Qi9tZGdhZEY1OUx2VmJNdE9XT2FzMkNuM2V4?=
 =?utf-8?B?RGdGN3lZU2pkeU8yaW1aOXBUUnJMVWNPQmF3dHYzaE1WM1ZkcndZT2JpQkd6?=
 =?utf-8?B?QVhjeVF2OEMyem0vZXUxNlZYd0FqUjl6TVg0akJBa3FUMGxqdEI4bFJrYU52?=
 =?utf-8?B?VWhscTgvcnBNRTB3QUVScm9ibjBDVStvMTkvN1VVQkZkaGkxVDY2V3pvTnha?=
 =?utf-8?B?M1hjUThmTXl2N0NHaUJFVWhUOWgyKzZoL2NDWXJrYnhqTjZ2WHgva1NGSTdq?=
 =?utf-8?B?N0NtSjZXTUl3Q1RCOGFXRitxZFZxL0RsYmFVZ0ZXQ0Z6SEJsSGUzYSsyeFFB?=
 =?utf-8?B?cDhYWFJ4cFlYdWxoUDllc2hxYWltdWZpc3JBbzhEdmJuYUZCVGlsQ0JhL3FI?=
 =?utf-8?B?NVQ4M09kV0dYY1VQc1pZSEtFZHVCazVaQ3lNWkFvUFFlc2I3WWNvN1NxY0pv?=
 =?utf-8?B?MGd5RDFLSlk3eGdYWkY0enJDVWhYMjlEWGs3VzFBYmpBMjE5V0Jtc2JqK1VK?=
 =?utf-8?B?d1VMNmZFN0czUkZYM08vUElNVzh6ZUhvcTRnWE9mR1lsaFA4TnNnNW9sekZh?=
 =?utf-8?B?eHJob0JqMjVkbFlXQVhOZ295L1RRRHIrK2JkZ3MyQTJYYlZrN2RmNXAyT29I?=
 =?utf-8?B?TEFKWUNlSjVTcnM2SkFXcm5YRlorL2ltSHEybmdzSEd1K3kzQlB0NC96Qnpv?=
 =?utf-8?B?d2NiMVBIRGhmRjNFdmE1UENiN2xXV2pLZUNVNmZRNUVuSXVHcEZkRE1QOTlK?=
 =?utf-8?B?Y1lhT1lOMHk5ZEdQRDlUcmhoU1JwOVNxc2tzMEx4aUlzVjFZUVNkNHdDS1c2?=
 =?utf-8?B?c2ZBSDI0ZkxLS29DbWw3K0hCSGdaVFpuVXFQRm14YzRnQlZ5T2F6bGo5MnNs?=
 =?utf-8?B?dWFsTUswWDB5RjNtdVFId2ZQNzZDMlNYWk1CMTN1QnRlV3JxUEJoa3I4NEJS?=
 =?utf-8?B?NEpranJaYWx5TzRqazlTTFZJcytoZit1TlUrRVE2TkxVR21aMEpEMHkxdW8x?=
 =?utf-8?B?Zm1Vcy9aTTBlb2w5S3U3V0FSR1EzdGFvbEdJWGc0VDBxZU94TXBzSFJYYlJw?=
 =?utf-8?B?QmdNMGNjUkVKSnJiZ1BYcXRORWZMeFg1WW52RnNQNlBRM3ZKNVpkRVdTTVBH?=
 =?utf-8?B?bitBYVVqeDJvQi9wUjU2RDNHczdndjFMNkhIa0poVXFZRU1ZaEVnYmNJeUtJ?=
 =?utf-8?B?UUxCY2pzTE5tN2ZsbnhzaUxzTVVFSWllUGdpMDRvMTFnWU13K1p1QmRKOEpa?=
 =?utf-8?B?K1hHMzU3bFhBSEdkdUlHRjNjS2JmRk1BdXBneittMXdDSmJldm12WjM1enFE?=
 =?utf-8?B?b0xrL0NwM2g1Sys5VlNiN1hSWC9VZFVJeU1LN2R6aElYei81T2JXOVpoU2ds?=
 =?utf-8?Q?5a0b5Poo6DZnu7Xyp4WFvGC6XuOPL7NZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amhOck9vMXNDbFZTYWhiL0tVUnNZazhoaFN0VlZqYnA0UEVFdkhhS2N6MWFY?=
 =?utf-8?B?VVdpb2pFSGZIRVBnS3daaUFhL2hKWC9Rb3U2TStSWERZelNQWFVPbVFHbUNP?=
 =?utf-8?B?V1pvZHZNWEYwNlVSWFFvSlNzY2tmMEtQYjZmVmpGNjdnSFNlMkJZSzZYQVNV?=
 =?utf-8?B?bXNLeEUzOUNjS0hCWlh2UUEzalJSR3VkTzIwS0xKSGcyUUcxdnJzRDlnc2FE?=
 =?utf-8?B?NjU0Zy9uK0hlTlFNdDBZMElkTmJLUWFybmRNUWNYdXNiQnNwdUhKa29JL3cr?=
 =?utf-8?B?c3RhNDZEdlpSSC9OVE8zSDExS0Rlc2dQM1NxZlhLYTQwYU1ROTc2cUNob3F4?=
 =?utf-8?B?WElZL0daM05SVzZtY2l6MThjWXRqTFoydXNPOGI3Zk11VWtUSUFxS2VrMkVQ?=
 =?utf-8?B?aEQ2OXQ0ZU9NL3JhMUpqS0tqcWMxd3dDNzMzS2xVZTdjNkNab1VxaE1aUGIx?=
 =?utf-8?B?eVhEMThIS3pITndVK3ZZQmd1R1dGbFM3SUttZ1VhTjVvTTlRVGZabklaQ1Yr?=
 =?utf-8?B?blNFWTlVMncwTEpud05PMmorR3NBR2RqclUxZ0ROY1ZVZVVEdXlZVXBJRktN?=
 =?utf-8?B?M1k3Qm1CbWIrZXNNdGpBcHVGamQwN3lna2tNb1VsLzc1NWt3aVBRbG51Smo4?=
 =?utf-8?B?b1phS3ZOWDcwTjdrSTdHUzQvQXVxQUMwVWlXUlU5a21iSFAzQ2VBLzkvUE1R?=
 =?utf-8?B?MGxOdlJITUtHb1JQV21xYjNhbmNhdzNHc1Y3Mjl2NTRnd3Y0U0dOWG1yOXFm?=
 =?utf-8?B?VHhFUVoyU2VRMENPb0pKZkZCR09DbXk2TzZqYVRjaFk0a2NIWUNlMmdDTUxN?=
 =?utf-8?B?NFk2Smc1dlVpL01oR1p2T3F1ck04K1EwbE5mcmN6SHpFMnFZQUFqVnhJK2ls?=
 =?utf-8?B?OUkyWXVqdDFma1BJLzI0UHN0c3FMRDN3YUh4V2k5cDd0aGc5T3hqWktoc1NE?=
 =?utf-8?B?U0wrUEcxbHhYS0h5RUdMbHZzUmNYUnczd2pFYktlekdQa0J3V0g1dTRqNnV1?=
 =?utf-8?B?VGtIVGdJZlFpSUMxWmxjeVU0eFNrL2R6R0lselpFWEZma1dZYzhGeE4wOGNv?=
 =?utf-8?B?NTdlUEtqNTNvZzgzVHdtN0dKWmZMMlFhdXBBeVh4Y2xadzBvbktMdWxwTDhh?=
 =?utf-8?B?TEQvejRHMWlZZGJDWkRKZUhxZXJrZy92Z3BITGx4TU1lOXd3V1RhY2g2LzlT?=
 =?utf-8?B?bXpXWWlldFd2NWNWZ092QVdNOWV4U25Xb1p2TW5zclZZejlmdDdPWWprWXN1?=
 =?utf-8?B?MDdzekR3Qldub1JkQ3o5R2srYitncnN5a1hic3ZXY2dqOHRUVE5JMXRGcEJ1?=
 =?utf-8?B?MEdPVWF5TUd0cTJyaGNqZzlCWWFsV0xIclQ1TWtoNGxzd09XaHIwMEJrTmpB?=
 =?utf-8?B?VVFXYUFqOFVZZmwvZ0ZvdHlPREhFaDhKTDM3a0NKU1NYakMwTTRqNXJTQU1W?=
 =?utf-8?B?eldpVFZxZFhLTzI4ekhneFpoZy9TZmhMcHBQOUVweTJsN3NDaGR5QndteFlz?=
 =?utf-8?B?VVNvNzBIYjJTWGZwWEw5ZDFZYVNxMmM0RTNOQ2RPd2grMEI2dCt5eUNFMUxI?=
 =?utf-8?B?T2ZpZGovbWtINmdlYVBVa1Q3Sk5XWU5EaDE5U01KendQOFJWVkY0UG8velpw?=
 =?utf-8?B?TnM1dTMxdVJKQW9SQlBuakFkSGZEMHZ6RXhxeGg2N0J0TXNucHBsU2NqODN4?=
 =?utf-8?B?cmJqKzZXK2dZV0hReDd6TUNTamNneUYralR6dDVrMmR1RS9hVDcwNEk2RWFX?=
 =?utf-8?B?VUZNdkxIL2IyTy9ZVjRvTHBQd1BJR3RTcmF4NTgxb1BxSzc2U0VKZTVYZUF6?=
 =?utf-8?B?aFJBMWh1NG9IdnZMTm84cWJMWUMyNFVqdm1vRFZMN2VmSzJQU2RsY2RieGxo?=
 =?utf-8?B?dXRhS1FPdDVvcmlCWkZ2cm1UTG9HcFB0UzY1WTNxdWk1b0pkZWlReDg1aUgx?=
 =?utf-8?B?QnM1K2x4UkxjMVpMbjE4UWNFRWxYTDdKcXMyTlQ4endxbjJucFdBZGFrMmZG?=
 =?utf-8?B?K1pSVGhoZkdNTVdaVnZUYWtzNWhCSkpEUitkSWEzN1ZPMHFhblBVOWdmQzVO?=
 =?utf-8?B?TzYrOHJCaXdzM3ExYllYbEZDR0VtQUM4S2pFUDh1dlMyS2JFTThRYUc1d3lu?=
 =?utf-8?Q?FYrsCt/iIw180zs7kP+G1iW50?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5859091290755E4780C6E633CF327318@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80234ff-50a3-4ea1-c2ca-08dd3f0e6d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 20:08:55.4642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgm+cBy5H0Myr58foXqd+jMMNUQLuXXfEh5dFhRXm6c5kJfWbvuGZx7uc+Tz1DDBDRoesDJ2GDaogPaMhFKPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11027

QW0gMjcuMDEuMjUgdW0gMTU6MDMgc2NocmllYiBBZHJpYW4gSHVudGVyOg0KPiBPbiAyNy8wMS8y
NSAxNTozNSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBUaGlzIHJldmVydHMgY29tbWl0IDk0MWE3
YWJkNDY2NjkxMmI4NGFiMjA5Mzk2ZmRiNTRiMGRhZTY4NWQuDQo+Pg0KPj4gVGhpcyBjb21taXQg
dXNlcyBwcmVzZW5jZSBvZiBkZXZpY2UtdHJlZSBwcm9wZXJ0aWVzIHZtbWMtc3VwcGx5IGFuZA0K
Pj4gdnFtbWMtc3VwcGx5IGZvciBkZWNpZGluZyB3aGV0aGVyIHRvIGVuYWJsZSBhIHF1aXJrIGFm
ZmVjdGluZyB0aW1pbmcgb2YNCj4+IGNsb2NrIGFuZCBkYXRhLg0KPj4gVGhlIGludGVudGlvbiB3
YXMgdG8gYWRkcmVzcyBpc3N1ZXMgb2JzZXJ2ZWQgd2l0aCBlTU1DIGFuZCBTRCBvbiBBTTYyDQo+
PiBwbGF0Zm9ybXMuDQo+Pg0KPj4gVGhpcyBuZXcgcXVpcmsgaXMgaG93ZXZlciBhbHNvIGVuYWJs
ZWQgZm9yIEFNNjQgYnJlYWtpbmcgbWljcm9TRCBhY2Nlc3MNCj4+IG9uIHRoZSBTb2xpZFJ1biBI
aW1taW5nQm9hcmQtVCB3aGljaCBpcyBzdXBwb3J0ZWQgaW4tdHJlZSBzaW5jZSB2Ni4xMSwNCj4+
IGNhdXNpbmcgYSByZWdyZXNzaW9uLiBEdXJpbmcgYm9vdCBtaWNyb1NEIGluaXRpYWxpemF0aW9u
IG5vdyBmYWlscyB3aXRoDQo+PiB0aGUgZXJyb3IgYmVsb3c6DQo+Pg0KPj4gWyAgICAyLjAwODUy
MF0gbW1jMTogU0RIQ0kgY29udHJvbGxlciBvbiBmYTAwMDAwLm1tYyBbZmEwMDAwMC5tbWNdIHVz
aW5nIEFETUEgNjQtYml0DQo+PiBbICAgIDIuMTE1MzQ4XSBtbWMxOiBlcnJvciAtMTEwIHdoaWxz
dCBpbml0aWFsaXNpbmcgU0QgY2FyZA0KPj4NCj4+IFRoZSBoZXVyaXN0aWNzIGZvciBlbmFibGlu
ZyB0aGUgcXVpcmsgYXJlIGNsZWFybHkgbm90IGNvcnJlY3QgYXMgdGhleQ0KPj4gYnJlYWsgYXQg
bGVhc3Qgb25lIGJ1dCBwb3RlbnRpYWxseSBtYW55IGV4aXN0aW5nIGJvYXJkcy4NCj4+DQo+PiBS
ZXZlcnQgdGhlIGNoYW5nZSBhbmQgcmVzdG9yZSBvcmlnaW5hbCBiZWhhdmlvdXIgdW50aWwgYSBt
b3JlDQo+PiBhcHByb3ByaWF0ZSBtZXRob2Qgb2Ygc2VsZWN0aW5nIHRoZSBxdWlyayBpcyBkZXJp
dmVkLg0KPj4NCj4+IEZpeGVzOiA8OTQxYTdhYmQ0NjY2PiAoIm10ZDogc3BpLW5vcjogY29yZTog
cmVwbGFjZSBkdW1teSBidXN3aWR0aCBmcm9tIGFkZHIgdG8gZGF0YSIpDQo+IEFuZ2xlIGJyYWNr
ZXRzIDwgPiBzaG91bGQgbm90IGJlIHByZXNlbnQsIA0KQWRyaWFuLCBHcmVnLCB0aGFuayB5b3Ug
Zm9yIHBvaW50aW5nIHRoaXMgb3V0LCBJIHdpbGwgcmVzb2x2ZSBpdCB3aXRoIHYyLg0KPiBhbmQg
dGhlIGNvbW1pdA0KPiBkZXNjcmlwdGlvbiBpcyBpbmNvcnJlY3QuDQoNCk5vdyBJIHNlZSB3aHkg
Y2hlY2twYXRjaCBoYWQgY29tcGxhaW5lZCBiZWZvcmUgYWRkaW5nIDw+LA0KVGhhbmsgeW91IQ0K
DQo+DQo+PiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tYy9hNzBmYzlm
Yy0xODZmLTQxNjUtYTY1Mi0zZGU1MDczMzc2M2FAc29saWQtcnVuLmNvbS8NCj4+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnICMgNi4xMw0KPiBXaXRoIGEgRml4ZXMgdGFnLCBiZXR0ZXIgdG8g
bGVhdmUgb3V0ICIjIDYuMTMiDQpPa2F5Lg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5
ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IEluIHRoZSBhYnNlbmNlIG9mIGFuIGFsdGVybmF0
aXZlLCB3ZSBoYXZlIHRvIHJldmVydCwgc286DQpJIGRvIG5vdCB1bmRlcnN0YW5kIHRoZSBxdWly
ayBzdWZmaWNpZW50bHkgdG8gc3VnZ2VzdCBhbiBhbHRlcm5hdGl2ZSA6KC4NCj4NCj4gQWNrZWQt
Ynk6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPg0KPj4gLS0tDQo+
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaV9hbTY1NC5jIHwgMzAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMwIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpX2FtNjU0LmMgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpX2FtNjU0LmMNCj4+IGluZGV4IGI3M2Y2NzNkYjkyYmJjMDQyMzkyOTk1ZTcx
NTgxNWUxNWFjZTYwMDUuLmY3NWMzMTgxNWFiMDBkMTdiNTc1NzA2MzUyMWY1NmJhNTY0M2JhYmUg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpX2FtNjU0LmMNCj4+ICsrKyBi
L2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfYW02NTQuYw0KPj4gQEAgLTE1NSw3ICsxNTUsNiBAQCBz
dHJ1Y3Qgc2RoY2lfYW02NTRfZGF0YSB7DQo+PiAgCXUzMiB0dW5pbmdfbG9vcDsNCj4+ICANCj4+
ICAjZGVmaW5lIFNESENJX0FNNjU0X1FVSVJLX0ZPUkNFX0NEVEVTVCBCSVQoMCkNCj4+IC0jZGVm
aW5lIFNESENJX0FNNjU0X1FVSVJLX1NVUFBSRVNTX1YxUDhfRU5BIEJJVCgxKQ0KPj4gIH07DQo+
PiAgDQo+PiAgc3RydWN0IHdpbmRvdyB7DQo+PiBAQCAtMzU3LDI5ICszNTYsNiBAQCBzdGF0aWMg
dm9pZCBzZGhjaV9qNzIxZV80Yml0X3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwN
Cj4+ICAJc2RoY2lfc2V0X2Nsb2NrKGhvc3QsIGNsb2NrKTsNCj4+ICB9DQo+PiAgDQo+PiAtc3Rh
dGljIGludCBzZGhjaV9hbTY1NF9zdGFydF9zaWduYWxfdm9sdGFnZV9zd2l0Y2goc3RydWN0IG1t
Y19ob3N0ICptbWMsIHN0cnVjdCBtbWNfaW9zICppb3MpDQo+PiAtew0KPj4gLQlzdHJ1Y3Qgc2Ro
Y2lfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+PiAtCXN0cnVjdCBzZGhjaV9wbHRmbV9o
b3N0ICpwbHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsNCj4+IC0Jc3RydWN0IHNkaGNpX2Ft
NjU0X2RhdGEgKnNkaGNpX2FtNjU0ID0gc2RoY2lfcGx0Zm1fcHJpdihwbHRmbV9ob3N0KTsNCj4+
IC0JaW50IHJldDsNCj4+IC0NCj4+IC0JaWYgKChzZGhjaV9hbTY1NC0+cXVpcmtzICYgU0RIQ0lf
QU02NTRfUVVJUktfU1VQUFJFU1NfVjFQOF9FTkEpICYmDQo+PiAtCSAgICBpb3MtPnNpZ25hbF92
b2x0YWdlID09IE1NQ19TSUdOQUxfVk9MVEFHRV8xODApIHsNCj4+IC0JCWlmICghSVNfRVJSKG1t
Yy0+c3VwcGx5LnZxbW1jKSkgew0KPj4gLQkJCXJldCA9IG1tY19yZWd1bGF0b3Jfc2V0X3ZxbW1j
KG1tYywgaW9zKTsNCj4+IC0JCQlpZiAocmV0IDwgMCkgew0KPj4gLQkJCQlwcl9lcnIoIiVzOiBT
d2l0Y2hpbmcgdG8gMS44ViBzaWduYWxsaW5nIHZvbHRhZ2UgZmFpbGVkLFxuIiwNCj4+IC0JCQkJ
ICAgICAgIG1tY19ob3N0bmFtZShtbWMpKTsNCj4+IC0JCQkJcmV0dXJuIC1FSU87DQo+PiAtCQkJ
fQ0KPj4gLQkJfQ0KPj4gLQkJcmV0dXJuIDA7DQo+PiAtCX0NCj4+IC0NCj4+IC0JcmV0dXJuIHNk
aGNpX3N0YXJ0X3NpZ25hbF92b2x0YWdlX3N3aXRjaChtbWMsIGlvcyk7DQo+PiAtfQ0KPj4gLQ0K
Pj4gIHN0YXRpYyB1OCBzZGhjaV9hbTY1NF93cml0ZV9wb3dlcl9vbihzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCwgdTggdmFsLCBpbnQgcmVnKQ0KPj4gIHsNCj4+ICAJd3JpdGViKHZhbCwgaG9zdC0+
aW9hZGRyICsgcmVnKTsNCj4+IEBAIC04NjgsMTEgKzg0NCw2IEBAIHN0YXRpYyBpbnQgc2RoY2lf
YW02NTRfZ2V0X29mX3Byb3BlcnR5KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAg
CWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwgInRpLGZhaWxzLXdpdGhvdXQtdGVz
dC1jZCIpKQ0KPj4gIAkJc2RoY2lfYW02NTQtPnF1aXJrcyB8PSBTREhDSV9BTTY1NF9RVUlSS19G
T1JDRV9DRFRFU1Q7DQo+PiAgDQo+PiAtCS8qIFN1cHByZXNzIHYxcDggZW5hIGZvciBlTU1DIGFu
ZCBTRCB3aXRoIHZxbW1jIHN1cHBseSAqLw0KPj4gLQlpZiAoISFvZl9wYXJzZV9waGFuZGxlKGRl
di0+b2Zfbm9kZSwgInZtbWMtc3VwcGx5IiwgMCkgPT0NCj4+IC0JICAgICEhb2ZfcGFyc2VfcGhh
bmRsZShkZXYtPm9mX25vZGUsICJ2cW1tYy1zdXBwbHkiLCAwKSkNCj4+IC0JCXNkaGNpX2FtNjU0
LT5xdWlya3MgfD0gU0RIQ0lfQU02NTRfUVVJUktfU1VQUFJFU1NfVjFQOF9FTkE7DQo+PiAtDQo+
PiAgCXNkaGNpX2dldF9vZl9wcm9wZXJ0eShwZGV2KTsNCj4+ICANCj4+ICAJcmV0dXJuIDA7DQo+
PiBAQCAtOTY5LDcgKzk0MCw2IEBAIHN0YXRpYyBpbnQgc2RoY2lfYW02NTRfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAJCWdvdG8gZXJyX3BsdGZtX2ZyZWU7DQo+PiAg
CX0NCj4+ICANCj4+IC0JaG9zdC0+bW1jX2hvc3Rfb3BzLnN0YXJ0X3NpZ25hbF92b2x0YWdlX3N3
aXRjaCA9IHNkaGNpX2FtNjU0X3N0YXJ0X3NpZ25hbF92b2x0YWdlX3N3aXRjaDsNCj4+ICAJaG9z
dC0+bW1jX2hvc3Rfb3BzLmV4ZWN1dGVfdHVuaW5nID0gc2RoY2lfYW02NTRfZXhlY3V0ZV90dW5p
bmc7DQo+PiAgDQo+PiAgCXBtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKGRldik7DQo+Pg0KPj4gLS0t
DQo+PiBiYXNlLWNvbW1pdDogZmZkMjk0ZDM0NmQxODViNzBlMjhiMWEyOGFiZTM2N2JiZmU1M2Mw
NA0KPj4gY2hhbmdlLWlkOiAyMDI1MDEyNy1hbTY1NC1tbWMtcmVncmVzc2lvbi1lZDI4OWY4OTY3
YzINCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo=

