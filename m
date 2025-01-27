Return-Path: <stable+bounces-110868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913DA1D705
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1470C1881ABF
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D341FF7D5;
	Mon, 27 Jan 2025 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Z+n0rdco"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023092.outbound.protection.outlook.com [40.107.159.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3D1FDA84;
	Mon, 27 Jan 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985237; cv=fail; b=cKKv4We6TLuMzMAa/SW7wkWn/BtzeKHDVP2SaqC6M9zuD8AEWMIOPEAODt5gwVHGVnaJKZtOPUN9kTAlBdbtHWF1fRfef/tSCmEflU6x9+Idwc9eK415iU684c0GH2UwIxW3X9utK7glDBWQX/pOAr55BYen8DX/DN2afVp7GbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985237; c=relaxed/simple;
	bh=CXxPVJ3WYAIKfgklz1ElfTmV/r6XlmKbQw2rUj/dxnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGH1/2j4hw5RIGBGhF0uWNZ+MeN7rs+v25ucsJ66Hioa8L1dUxDSwRpe2uRTBqeAiBcO9IzzBTdoiZR0aPhyXraJ+85LMCwwtX1BfuygC4NLN60yMyy8o+MSHs4Ify6KathsWxDKnv7/oVKULaXcpLc0nSszy/vOOyVnfOrgqN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Z+n0rdco; arc=fail smtp.client-ip=40.107.159.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaTvKjBVXt7xXBfauk/TykiZiHPAJ8iT+O9vwtdOzXRnEZH679hYwB0QngmJdJkUstQzQb4krj/xyqliIWdz3SnljHc6L1wKh1kQw3lL0X3UBYCqSGTcgzHKlD7mAHpygNFk4otIJB7Z2ZgOtBzPyyDNIsx5xQw+j6BMzUTlvXIgKTpeHESgDiuZ/qeXSyf+MyLanEwUPF3rPs32WRvVJvVj5Y6eekBICtwpoHYrhxAGW+gK7cKGdAf+nl0jXX+E4DFxAK712JkktnnO1wRhV4IFIRWeWJ8mNA5I87MYSbLNK7TJIAwGzV1U54eNrlpujr5967bbd/q7Ksv9VUpK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXxPVJ3WYAIKfgklz1ElfTmV/r6XlmKbQw2rUj/dxnI=;
 b=YQG1WFqOHmUS4K2Df9mugI4huRNjjfPHTkd32FN4nK9rta6EOv0xQg14XxMqitIGVNEFgwn57OCiMrUQuWe2yETFyQ7OIXPF8JuxL7OxHm/8KTdlJOcc4RBHjeNQnXbFBpPNCeL+DHXpP7sbuGE58kv7Wjh4zB1NqFZvpReqblH2vrdhpvLfFOorY/xvRXYw0+YnIatOx9DZxdpOinmvSoqnEk1rgThFRjsdPQ+6328hvmSabROkB3E9E0SPfUQ7rQpqZqzLVdjP9GToNk/2bBR4KlyXAoULsgbZgfgW180JMYINEzpscQMFOko7LK/B3XSchjTKGXdk8Cvq8vdURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXxPVJ3WYAIKfgklz1ElfTmV/r6XlmKbQw2rUj/dxnI=;
 b=Z+n0rdco6p1BJsdDbEiQC2inqWzA1Fuz7IH/BUFmLO/VaVUGYrmjDzaFaH4qqtolEgl+g+kmhwhsvh67UGOe/EQcWw8h1NN/WS0PbUfJw8b0qZKn6rAqY2slSrfVz8Yoaem7DCqD88BR2YYYvy5nKjU+EiAWgXrntbmIK74y+EI=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS1PR04MB9432.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 13:40:31 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:40:31 +0000
From: Josua Mayer <josua@solid-run.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rabeeh Khoury
	<rabeeh@solid-run.com>, Jon Nettleton <jon@solid-run.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Topic: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Index: AQHbcMBZtETYhqv2qEqDXmydV8m4ZrMqoI4A
Date: Mon, 27 Jan 2025 13:40:31 +0000
Message-ID: <24defb9f-fecf-477b-89a3-780d887cae5d@solid-run.com>
References: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
In-Reply-To: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS1PR04MB9432:EE_
x-ms-office365-filtering-correlation-id: a62fad5a-8f0e-4a76-61e1-08dd3ed82b1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3NRTnBrQnRjV1dGbEJBdWdHWlRPakxZbkVmYnU4c1A5ZElab3BDMUh2TG5B?=
 =?utf-8?B?K0ZLWHhBQlFXazJLVlk2dkNLVzRQQUZpMzl3QUxLWEFoaWRLeUMwdlhNY1Rh?=
 =?utf-8?B?Vzk0Z0R3U2NNOHlvTm81c1MxRy9FSnFrMkpobVV1UHJtc3V5cUVsa1hqcE4z?=
 =?utf-8?B?d2VTamtGd2xpSlkzSzh3N3pDU255N1QvODFmN3pHOWlLZlpVYyt4M0NZTXhm?=
 =?utf-8?B?K29zUkk5cEM3c3o2UHpGZ3Z2NDZpcFExZWFJNGtCUWhsblVURGREL3JLSmtU?=
 =?utf-8?B?Q2hUdW5wWmpnblBkcWxVc2d5YXJGVW84UnRuVWFPQXgxdm5La3d2TkRaMkpq?=
 =?utf-8?B?NXpuY2tDaDB6RStuaE5MaHk0V21KUFZrUjZZUmtqdEFzR2JMR3VYbll2ZW5J?=
 =?utf-8?B?dEREUE5iMXVHOHpvNlRZV0ZPRktQVXRjWmprVmh5NHdwVnVqSzVhNDdQRGd3?=
 =?utf-8?B?MzV4TUFQSm85MnFmOXExMTUzNVVXOFUvSHdEd2NTaEFTMWsvSjhrc2NzZHhs?=
 =?utf-8?B?QzBWdEF1bEYreTI0VDVpNGZlcnRseFJXQklsK0Fnb05TMHJrcHdXTmNNOGVs?=
 =?utf-8?B?UXVzV3B1M1lETkdGRFMxOEsvL1FxM2pRYjJ6WktNRkt2Tkhic3pFd2pyVzJl?=
 =?utf-8?B?T05VMnUxNk9zRUpFZ2JRVlVaRTZHdHdiTTJBMWM0d2hGQ1ZFWmMra002OWc1?=
 =?utf-8?B?OUVHYXZEYlZVZHg3UjVYSEdHUGcyWk9XNCs5ejhiVFEzWjJkQVk5MndwK2pM?=
 =?utf-8?B?VUk4Skx5ZW9zT2ZUTGtTQnhKYSt1eTZmNVNPYllFUmR5RVJSVnlsMlNNRm9F?=
 =?utf-8?B?eDVVaGZwR0dvVElJb3VxSjBhQzk2VE1qelVKL0VaN2Q2OXlRNVNDVmREMWFz?=
 =?utf-8?B?Q2kwYkNBemovUHBpM09OUHIrMVcvQS9mUThpQXR5QUhkcVhGcWFVcDZIZ2pk?=
 =?utf-8?B?RnBabFJBbEljQTJzK0xUTTlMdVExRldGSEgwSHhpZE12cWNpSUtPb2ZUU0U4?=
 =?utf-8?B?Q3VDUkswYjA4S3lNeWxwMklnQjZsaVpUN3dUdTBKeTIyRUZUSDhQL0pxUVFj?=
 =?utf-8?B?UnJQakJOOFJHdXljV3pBVDJZOG5QM0hORGlUNkRSZ0RGR2ZUaGxqZFh4VWt6?=
 =?utf-8?B?cVpXVmZtOXBvVGJIR2ZnSndINmZyeUN3V0hyUkgweFphbDJ4Ynk2ZEpFQmJk?=
 =?utf-8?B?SDUvUnVmUlN1L1BVQUh4TWlMcm9yVHZyMjBSNFlFOVMwbXhMNVdoZ254bGtw?=
 =?utf-8?B?aDF2bi9LWkp3QVNoeFBlc3Q1Y2NlcXQ3VEVOQ0ZoVTBCQTFid0NKczI2NTdG?=
 =?utf-8?B?ZUZkSnNRdUFKSXdxUWxycTRvaTQyN0ZxNjJSSEVUSkQ1bHZHTjlGNU0raFJN?=
 =?utf-8?B?REVVbE1vbUxrMnRWTUVwMUtrL0ZQUVNIZGoxclZjTlFUL1JJb29kayt5M2hu?=
 =?utf-8?B?VmxQQlVVckNFV2UxK2V4cjc2UHgzdDk4QjJlSmdXQmpFS095NHduWm8vRm8z?=
 =?utf-8?B?MzRGaEhPbzhmRmowVC9wU051ZlkvbDVhNXgvdXJ2bU1qUWJLNGtQQjF2Ynl4?=
 =?utf-8?B?ck5xKzdIR2FIbXRmNGNCcUZrR2F2aTgrcXBnU0lLS2NqTFdvZDdtaXoyK2FL?=
 =?utf-8?B?SzBDbmVsUjc5djBucldsV29SUzZsMUtxZVl5MWFkQzBvZ3FCLzJWNnVVWVNO?=
 =?utf-8?B?ZlJ0aUhBMGI1MG9xNGpZb3BEUWM3azVkMlFaQkdRRGtFck1GOHUzMVZDR256?=
 =?utf-8?B?ZG9CekMxcG1KWXU5WkJDQisyeHlrMjhhc3lYbWR2UnNVNmtLTUNsU3EyREtN?=
 =?utf-8?B?K3g4Vmt6UjR3bXJUUURlN3VlVTZHQVdLdlgyZHNycWcwaW1RaVVidWRnK3Ba?=
 =?utf-8?B?TEFWSk4yRUc3KzY4WEd4SmkxYUxVWGljWE1xRlFIMUdpUjVUOHlBMW9SdllK?=
 =?utf-8?Q?vDX3MHgejirqQSUQXb5iPoKIs40/snSz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1lSWWEwRmZXY2hmL0lCTmR4R3lZVDNHay9YSDFvOFB4UElrcWFVaWF3VEY0?=
 =?utf-8?B?azZ5RGpDMURrd0REMWRUY1gvdUhoVGlNaUIvaDh6QUl3VTg4QWtEVkxLY3F6?=
 =?utf-8?B?VTZMMEZQc0pRbDZrazRkWVBTZE1Sb3VBZUl4cTRhVVFnRlVaNFpEdytXMVNt?=
 =?utf-8?B?ZHdpdkxvTWhvZ0VlcEhGR0FiUmRoMVR2ZDN5U0lFam0ySUd4Vzlsc216alZo?=
 =?utf-8?B?ZUh0WXltanA0bEFHazZYV1F6aStPdXF4cXBWZlVoOEhOOG4rdFo0dmc4MTNQ?=
 =?utf-8?B?TlQ3MEFMd0JhN2hNQVRLUncvS244U2FEY09VUVJTdzQySEJyUjNidUE1L1ZT?=
 =?utf-8?B?d1o2MmR0elFiUElNSmN5ZVNtSkRPUjlNZlhZeFF1RTU5bXRvT2VNREp1eHZM?=
 =?utf-8?B?c0FhbXUzWjg5d1JyencrdDhtTkszMmNGaDYybS9WeG9obWlNUDVjTFBnVFhE?=
 =?utf-8?B?U3JMSEV3VWVVNkViK3VzL3BFdlNRdldSODV4T2prTE8rS2RWdE5UTmJZNytu?=
 =?utf-8?B?MmgwUnNWaFFsTXF3ZCtNUThZSGl1NlUxOVZTMTBLdjZGZTFOdGZWc2JpdWgw?=
 =?utf-8?B?cnNuSFlROXNXZitmUVhHM2tXb1FEcXNneUJ2K21pSy9mQlZCTXNKUUpoVW54?=
 =?utf-8?B?V0R5RCtSSFB6WWFYcEd0ME1lOGQwU2FiQ2VHN2pQR1hqZ2NaNjJ2bGY3K1Bx?=
 =?utf-8?B?SFdXYzZDQVNiRmVuVjFUc1A0ODEwbkZUcXlHeWErK2RsYmYyQlJuam1DQzVD?=
 =?utf-8?B?b0dMeDBRM2lGbHZHNldGSUpDVndnQ04yQnRPbSszYzYxaEpKemdpR3hLN2tk?=
 =?utf-8?B?MmxoY0k3UThTK0VXb2QyNDRhNU00WW5tZGhNcEtDTFBlczlBYVBYdlQwbG4z?=
 =?utf-8?B?d1hXVkR5ZmEzMWczL1dFOVI2WHZITnpyM002RDBGTnpnWFRZWXYwZGNnV05C?=
 =?utf-8?B?YmJJaithOTdqOGVVREZhUDBuWU9POE94Y2x2Z0UrYmxUZjhsRUFSR1BYRXBr?=
 =?utf-8?B?UUNXWEJWVUwyaTBQdzd1ZjBGSTJrc2NqU0huK0VWeEo5RDNwRjNraGxwcDRp?=
 =?utf-8?B?S05Wd1BQd1R1enNId1ZOSUp6OVErZWxPclY5MEpxbjB0Tmgvd2lRakZLUXAw?=
 =?utf-8?B?Sm9NMWFYbW5QVDBpdzM3T0lYbXJuZUxlRTZXbkxLS20veUJnejhGVUFDUngr?=
 =?utf-8?B?eThtc0VhN1JUMjBGQmhlRi81Ymw2ZnBsUHBCajhUM1VSNnptRHlqajlJalhI?=
 =?utf-8?B?dnpDZForTll4UkxXVlhXMFh4eFN4Vzc4RGtGRURjQ0VqTlBWR0wwN05zMHdF?=
 =?utf-8?B?WmJrcjdCN2tMcGpIdmlLL255eTRmTENaaEhlM0U4S3RmMXFnRUNvZlJ3U2NM?=
 =?utf-8?B?djJvdzFidGJQWEoxTUNYcFJ2QmFCbW1XU0cwT3FyazNMR1hjOUNrOE4yL3JP?=
 =?utf-8?B?aklMUFduUWZEbU9mNjJNUXBjYnFkNUs3YnZ5RnRxbnJ5WGcxYTd0ei9IUnZX?=
 =?utf-8?B?TndDSWgvNEJYb2ZjaldjamRCbndHK2pXdG5aalNORTJTUUs0RnJxOG4zdzVR?=
 =?utf-8?B?UHVQWHhCZmNrVzMvVkFhN0ttWElXZlI5cEk0KzA4MmhyVXJnODdQRytyTjRI?=
 =?utf-8?B?bExJR1dsTUlmRzFjYVNDVm1vRHNCd3hIbGF5RmJ3Tkk1Nk92a005NU5zelZt?=
 =?utf-8?B?NEEveTJjN3FOOGNQNFlRMkhod0hCd211Zllvb3lVYlQvS2pOOG4xN3NiRUNr?=
 =?utf-8?B?YXpiTWFIeGt3cWZXY3l4OXFDRUcrcko4QWlJM0tJNDVTMlBGYnlIYkFhZTVJ?=
 =?utf-8?B?OGFjYkEzZzhOYlEyWHBXUDFlbkZiT0pVTHl6VzgyTlZRVFJ2YlVVWWNxM3l1?=
 =?utf-8?B?S0pvMTdlRTlSTVE0dXBNUzdFS2tvbnVoN1dKTVdpWldaRnFjWGVhSDJaeWJt?=
 =?utf-8?B?M292M0pSeVF3TW9FRExhVDdKSk1GUXlkK3U3RXRna2M4Tm9iblJFVjY0VXg0?=
 =?utf-8?B?RU8yRnZ4Y2RibnZxb3RoUXFORjhJZWg4UTY2eEViRmRDZnp6OEsxT2ZxV01K?=
 =?utf-8?B?TjJoNWV2akxpZnNLRGhzcFdGMGI2UDZTR2cvRDFPeWxnTis4MjN6RVZsdmVY?=
 =?utf-8?Q?019o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A4A909811ECC645A8494F0CEDA15F0C@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a62fad5a-8f0e-4a76-61e1-08dd3ed82b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 13:40:31.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7f3jo89bLECca0vW/67mDIKumkazAetedaFrQSbwd53geKCWHSrMvMKA3eX2t+MaU3tFQru7jCfEd/Bm+OxLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9432

Q2M6IEp1ZGl0aCBNZW5kZXogPGptQHRpLmNvbT4NCg0KQW0gMjcuMDEuMjUgdW0gMTQ6MzUgc2No
cmllYiBKb3N1YSBNYXllcjoNCj4gVGhpcyByZXZlcnRzIGNvbW1pdCA5NDFhN2FiZDQ2NjY5MTJi
ODRhYjIwOTM5NmZkYjU0YjBkYWU2ODVkLg0KPg0KPiBUaGlzIGNvbW1pdCB1c2VzIHByZXNlbmNl
IG9mIGRldmljZS10cmVlIHByb3BlcnRpZXMgdm1tYy1zdXBwbHkgYW5kDQo+IHZxbW1jLXN1cHBs
eSBmb3IgZGVjaWRpbmcgd2hldGhlciB0byBlbmFibGUgYSBxdWlyayBhZmZlY3RpbmcgdGltaW5n
IG9mDQo+IGNsb2NrIGFuZCBkYXRhLg0KPiBUaGUgaW50ZW50aW9uIHdhcyB0byBhZGRyZXNzIGlz
c3VlcyBvYnNlcnZlZCB3aXRoIGVNTUMgYW5kIFNEIG9uIEFNNjINCj4gcGxhdGZvcm1zLg0KPg0K
PiBUaGlzIG5ldyBxdWlyayBpcyBob3dldmVyIGFsc28gZW5hYmxlZCBmb3IgQU02NCBicmVha2lu
ZyBtaWNyb1NEIGFjY2Vzcw0KPiBvbiB0aGUgU29saWRSdW4gSGltbWluZ0JvYXJkLVQgd2hpY2gg
aXMgc3VwcG9ydGVkIGluLXRyZWUgc2luY2UgdjYuMTEsDQo+IGNhdXNpbmcgYSByZWdyZXNzaW9u
LiBEdXJpbmcgYm9vdCBtaWNyb1NEIGluaXRpYWxpemF0aW9uIG5vdyBmYWlscyB3aXRoDQo+IHRo
ZSBlcnJvciBiZWxvdzoNCj4NCj4gWyAgICAyLjAwODUyMF0gbW1jMTogU0RIQ0kgY29udHJvbGxl
ciBvbiBmYTAwMDAwLm1tYyBbZmEwMDAwMC5tbWNdIHVzaW5nIEFETUEgNjQtYml0DQo+IFsgICAg
Mi4xMTUzNDhdIG1tYzE6IGVycm9yIC0xMTAgd2hpbHN0IGluaXRpYWxpc2luZyBTRCBjYXJkDQo+
DQo+IFRoZSBoZXVyaXN0aWNzIGZvciBlbmFibGluZyB0aGUgcXVpcmsgYXJlIGNsZWFybHkgbm90
IGNvcnJlY3QgYXMgdGhleQ0KPiBicmVhayBhdCBsZWFzdCBvbmUgYnV0IHBvdGVudGlhbGx5IG1h
bnkgZXhpc3RpbmcgYm9hcmRzLg0KPg0KPiBSZXZlcnQgdGhlIGNoYW5nZSBhbmQgcmVzdG9yZSBv
cmlnaW5hbCBiZWhhdmlvdXIgdW50aWwgYSBtb3JlDQo+IGFwcHJvcHJpYXRlIG1ldGhvZCBvZiBz
ZWxlY3RpbmcgdGhlIHF1aXJrIGlzIGRlcml2ZWQuDQo+DQo+IEZpeGVzOiA8OTQxYTdhYmQ0NjY2
PiAoIm10ZDogc3BpLW5vcjogY29yZTogcmVwbGFjZSBkdW1teSBidXN3aWR0aCBmcm9tIGFkZHIg
dG8gZGF0YSIpDQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW1jL2E3
MGZjOWZjLTE4NmYtNDE2NS1hNjUyLTNkZTUwNzMzNzYzYUBzb2xpZC1ydW4uY29tLw0KPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMTMNCj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5
ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhj
aV9hbTY1NC5jIHwgMzAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpX2FtNjU0LmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpX2FtNjU0LmMNCj4gaW5k
ZXggYjczZjY3M2RiOTJiYmMwNDIzOTI5OTVlNzE1ODE1ZTE1YWNlNjAwNS4uZjc1YzMxODE1YWIw
MGQxN2I1NzU3MDYzNTIxZjU2YmE1NjQzYmFiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaV9hbTY1NC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfYW02NTQu
Yw0KPiBAQCAtMTU1LDcgKzE1NSw2IEBAIHN0cnVjdCBzZGhjaV9hbTY1NF9kYXRhIHsNCj4gIAl1
MzIgdHVuaW5nX2xvb3A7DQo+ICANCj4gICNkZWZpbmUgU0RIQ0lfQU02NTRfUVVJUktfRk9SQ0Vf
Q0RURVNUIEJJVCgwKQ0KPiAtI2RlZmluZSBTREhDSV9BTTY1NF9RVUlSS19TVVBQUkVTU19WMVA4
X0VOQSBCSVQoMSkNCj4gIH07DQo+ICANCj4gIHN0cnVjdCB3aW5kb3cgew0KPiBAQCAtMzU3LDI5
ICszNTYsNiBAQCBzdGF0aWMgdm9pZCBzZGhjaV9qNzIxZV80Yml0X3NldF9jbG9jayhzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCwNCj4gIAlzZGhjaV9zZXRfY2xvY2soaG9zdCwgY2xvY2spOw0KPiAg
fQ0KPiAgDQo+IC1zdGF0aWMgaW50IHNkaGNpX2FtNjU0X3N0YXJ0X3NpZ25hbF92b2x0YWdlX3N3
aXRjaChzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykNCj4gLXsNCj4g
LQlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+IC0Jc3RydWN0IHNk
aGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9wcml2KGhvc3QpOw0KPiAtCXN0cnVj
dCBzZGhjaV9hbTY1NF9kYXRhICpzZGhjaV9hbTY1NCA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1f
aG9zdCk7DQo+IC0JaW50IHJldDsNCj4gLQ0KPiAtCWlmICgoc2RoY2lfYW02NTQtPnF1aXJrcyAm
IFNESENJX0FNNjU0X1FVSVJLX1NVUFBSRVNTX1YxUDhfRU5BKSAmJg0KPiAtCSAgICBpb3MtPnNp
Z25hbF92b2x0YWdlID09IE1NQ19TSUdOQUxfVk9MVEFHRV8xODApIHsNCj4gLQkJaWYgKCFJU19F
UlIobW1jLT5zdXBwbHkudnFtbWMpKSB7DQo+IC0JCQlyZXQgPSBtbWNfcmVndWxhdG9yX3NldF92
cW1tYyhtbWMsIGlvcyk7DQo+IC0JCQlpZiAocmV0IDwgMCkgew0KPiAtCQkJCXByX2VycigiJXM6
IFN3aXRjaGluZyB0byAxLjhWIHNpZ25hbGxpbmcgdm9sdGFnZSBmYWlsZWQsXG4iLA0KPiAtCQkJ
CSAgICAgICBtbWNfaG9zdG5hbWUobW1jKSk7DQo+IC0JCQkJcmV0dXJuIC1FSU87DQo+IC0JCQl9
DQo+IC0JCX0NCj4gLQkJcmV0dXJuIDA7DQo+IC0JfQ0KPiAtDQo+IC0JcmV0dXJuIHNkaGNpX3N0
YXJ0X3NpZ25hbF92b2x0YWdlX3N3aXRjaChtbWMsIGlvcyk7DQo+IC19DQo+IC0NCj4gIHN0YXRp
YyB1OCBzZGhjaV9hbTY1NF93cml0ZV9wb3dlcl9vbihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwg
dTggdmFsLCBpbnQgcmVnKQ0KPiAgew0KPiAgCXdyaXRlYih2YWwsIGhvc3QtPmlvYWRkciArIHJl
Zyk7DQo+IEBAIC04NjgsMTEgKzg0NCw2IEBAIHN0YXRpYyBpbnQgc2RoY2lfYW02NTRfZ2V0X29m
X3Byb3BlcnR5KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ICAJaWYgKGRldmljZV9w
cm9wZXJ0eV9yZWFkX2Jvb2woZGV2LCAidGksZmFpbHMtd2l0aG91dC10ZXN0LWNkIikpDQo+ICAJ
CXNkaGNpX2FtNjU0LT5xdWlya3MgfD0gU0RIQ0lfQU02NTRfUVVJUktfRk9SQ0VfQ0RURVNUOw0K
PiAgDQo+IC0JLyogU3VwcHJlc3MgdjFwOCBlbmEgZm9yIGVNTUMgYW5kIFNEIHdpdGggdnFtbWMg
c3VwcGx5ICovDQo+IC0JaWYgKCEhb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJ2bW1j
LXN1cHBseSIsIDApID09DQo+IC0JICAgICEhb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUs
ICJ2cW1tYy1zdXBwbHkiLCAwKSkNCj4gLQkJc2RoY2lfYW02NTQtPnF1aXJrcyB8PSBTREhDSV9B
TTY1NF9RVUlSS19TVVBQUkVTU19WMVA4X0VOQTsNCj4gLQ0KPiAgCXNkaGNpX2dldF9vZl9wcm9w
ZXJ0eShwZGV2KTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiBAQCAtOTY5LDcgKzk0MCw2IEBAIHN0
YXRpYyBpbnQgc2RoY2lfYW02NTRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gIAkJZ290byBlcnJfcGx0Zm1fZnJlZTsNCj4gIAl9DQo+ICANCj4gLQlob3N0LT5tbWNfaG9z
dF9vcHMuc3RhcnRfc2lnbmFsX3ZvbHRhZ2Vfc3dpdGNoID0gc2RoY2lfYW02NTRfc3RhcnRfc2ln
bmFsX3ZvbHRhZ2Vfc3dpdGNoOw0KPiAgCWhvc3QtPm1tY19ob3N0X29wcy5leGVjdXRlX3R1bmlu
ZyA9IHNkaGNpX2FtNjU0X2V4ZWN1dGVfdHVuaW5nOw0KPiAgDQo+ICAJcG1fcnVudGltZV9nZXRf
bm9yZXN1bWUoZGV2KTsNCj4NCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBmZmQyOTRkMzQ2ZDE4NWI3
MGUyOGIxYTI4YWJlMzY3YmJmZTUzYzA0DQo+IGNoYW5nZS1pZDogMjAyNTAxMjctYW02NTQtbW1j
LXJlZ3Jlc3Npb24tZWQyODlmODk2N2MyDQo+DQo+IEJlc3QgcmVnYXJkcywNCg==

