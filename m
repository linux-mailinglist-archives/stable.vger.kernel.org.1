Return-Path: <stable+bounces-50117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62690902A24
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 22:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B491F21920
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 20:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6BC4D8BB;
	Mon, 10 Jun 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l3/0H58g"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78A1514DE;
	Mon, 10 Jun 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052427; cv=fail; b=eQcv6K0kQ6H/WwbBEEREj+BNdjSdoyPSv37Tj51L8E+nNx6kzbpS72VL1lt4PSvXVSblFqDKGLtpfT5HjyLBixkD3DpE496Ly0dRwRR1DLGUl3lgkeDrIyFxUU+Uvi8Rw1yecQEv+NVS2XYeq3BmYdEwLXrgrYj7wDHzFie5SXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052427; c=relaxed/simple;
	bh=x/N9UKbuC1PtJqldK9l4xcfA2yq5Uz//yB04e42/deM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DycOsiQcwq+xSrC2Srwvys7PNxQw71zGZKBgFy8dA+VZFvYwLtd24pNrzlq6FXW9NRxX116HWRCgfH09coaJ5QMmvsaRSsr/A/y9RH8M4R9LkAasvpIyp3z5N9cxgCGmX8rmOFaZtGk96ZoStedHjAh69BBTNdCxv0TgIPoILgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l3/0H58g; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYu5oqNlsi7ZGAeNnB01riAAyMnYzaxjyc242xLDC+D6mzS5+93gyuG7ZkXX0AW8p7xT6ZxuxmodVOLPiqBUFdnjrgDY2qa/DmWN11P+COFcVgCkj68ZQEyMUlrrUTFeTX9DlAnsg4oxeyUkOzhUdBdJ/fnZJUrWik5B7BpNoMvoT3+lwOMcEIcmlBYpo3YveNkyWrpMlW6UET1iuYULquno/N2kLGT8V8s7f3ePYFrVLj8yj7XFmNofM/9g+B2rBoEQGnj4T/KBhAdV+wk+f0QUwOAAzSalVMDRIhf8+4WWJYn0H2qrdakcU41ellzvvRj7Oem+ockotTf0H1vSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+3he17Q1UKFPYHjVKWKfzmbNcSbTss13TaJlIsutKg=;
 b=VwdNkEwVBOWOseNLvchCDFzIInVIeBTJXAZdDUGvuRk2l5ZjSritzWEwItTxj9Q5CGLLdYOK/sc43xJKaxOcr3YBb8DiL8bZPmYPiFfoljyQ81R46ewWJ8I5qqQBGEttkFA5dX/8QN2h2/aBuNMs3/+oyGf4dRiEJVSyvA2Txt4CvVNxSokOgCIrD3VkhQsQQQ9ES0/Pd7tComi/E9MaBRnXwZFMi8mtaFrUyo0MbO3NvoIb1BoC7927d14QhEremk6s8CASPNR33fANx69qqdJoTTzweXdKWgJMl6xRhnbm8jK7ioE3gx1BG+tBRL5Z90VE04zG43s52aE/H6f4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+3he17Q1UKFPYHjVKWKfzmbNcSbTss13TaJlIsutKg=;
 b=l3/0H58gHgGc9572tk+gAo+PbvsBPOKuuOmmeAFvhM0/qxmokV6MlPn3zCTPeqpkoAThlB1cmsA9UMz/RUqORJrrTaqGqWQd6qAi7qV/Xvg0vgVHQcHvvgOdPb1361nEsyw/Pqmrm5+p4HuM/a5RoQV5Hy5i6mzmCMaCOcSRCqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:47:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:47:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:25 -0400
Subject: [PATCH v2 8/9] arm64: dts: imx8qm-mek: fix gpio number for
 reg_usdhc2_vmmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-8-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, stable@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=907;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x/N9UKbuC1PtJqldK9l4xcfA2yq5Uz//yB04e42/deM=;
 b=2LeR1aEcpf33nz6zin/qdyb5DKwH9YhxOH1h28q59vWzEM8+oYKd9veGXCnt3C1BKyXRseMpT
 GEoML4p/gDlAjVKx35zLb99jb10yBAv3093ruLWwZwU0UyWt3z0meuE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 019cdf1e-16e9-4160-b599-08dc898e7b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0Y5SXBPQXlkZUJDK3hWQlhiVXBxWFl5MlJ6VmhyTUcvczBjT2lLdHlzWFFB?=
 =?utf-8?B?U2t5ZHdhSTYxbGlrODhmQnhield1QVpTNlNBNWFxYzc2NXJnMEpQajlXVnpV?=
 =?utf-8?B?K0FiM1Vza2puNGdwQkJUMDhsVGhITzNZMzVSMHh2bHlCM0hzYjdGWkFJSnAx?=
 =?utf-8?B?ZTBjSFAvOW9hRFlTTVorTXpkbzNHcDlENk4waTdKVDJCMm5WQ0hKQlY3WUk3?=
 =?utf-8?B?cHBDQWRheThsd2hCMStibUpUU1BzTDZYdGZLZTVXOTI5RHN1UTFadXpIQ3ZX?=
 =?utf-8?B?eUFBZUVlQmE0RVJvR0NtUW5LQmVKRjA2dWpSZUxocG4rcXhBdVo0V0ZQMmx3?=
 =?utf-8?B?SkxhMHRZVWxyNklLbFV2QU5xR204alFmK2FZVTZMOURmUFFjVFBmUTQ5WldQ?=
 =?utf-8?B?UVluNnNaSHdVWEozYk5mckZvQ2lGdHJsZ3NBZWhHT2NXZDVydUQ1VjF3T0h0?=
 =?utf-8?B?YmVISVhDdHIxNHluOExNTEo2RkdFRHhqVG50b1o3Y1JXVFZkSkxKa1lad1hN?=
 =?utf-8?B?dk1ibmFJK1I3V3FTL3VhZTVscnZyOVozWGg2N1MyQUh6eXc3dEdBK1Fsd2Rk?=
 =?utf-8?B?MW1FbndxRVpSc08zSGpTVWtSUWl1a2tOd1loVm5BWGhGQVNlWmxNYld6OUFV?=
 =?utf-8?B?NG9PQThCL3UzdHVtTlptcThFR2s2dldnZnkwUWVYR3loSjhFamFlK0tCSGpu?=
 =?utf-8?B?YkgyKzBsNExRV1JodVYwQmxGQldNT0xMZTJuT2psQzVuMG1SOXAzVXpjcE9q?=
 =?utf-8?B?ZWZabXFNYW9LREVJb2hkcVoxR3BUdFl4em9wZFRKMkpyeGovalk5MVRFdWpJ?=
 =?utf-8?B?OC80bWpOWkl6NU50S2lkY1VCaWFIc2tzV3B6aG9oQ2RVb3lGdUQwUGFKVG9r?=
 =?utf-8?B?bUQzOEQyQi8wL3l0UjhNMU9QSGFkNkE4RVhveXNjR0ZoeTUzY2gxcm5XMFFv?=
 =?utf-8?B?MEFKQWVhZE5WUWQ4N29HVmVwQkh3UWRLMUo0YmpuVUpqS2JUaTZwdmVuS20z?=
 =?utf-8?B?OFBYWUdBWEhKM1BHSXBVUGJYTXZzRDN5c3M0NS9IajIvZFRZWnZobW1OM1po?=
 =?utf-8?B?eEljRkVtSkZZd0hxLzB6bVprS2ZIVXVOTnMxWmJaYkV6dzJ6TEdNYzFZZm8x?=
 =?utf-8?B?ampiQ211cElBNkNUekd3dEhaV2ZtTnFvZVVqUi9nMFdvUDE4ektndjU1MnFi?=
 =?utf-8?B?eFY2dXpGd2JSV0ticDVlclpLOFg0Mm1PWXgzZ3ZWTC92dDlsaHpwUDAxUVBy?=
 =?utf-8?B?SHJiN2dYNW0wdTFwaStsNU9XU056KzVpekJEMzc0N0RNZUljcmx4NUhoMGd0?=
 =?utf-8?B?bzBoTXNYM1hKMXV0L0VXRmhadlVSRUE3aXYvOTdOaUhwYUw5VGk0ZXNtM293?=
 =?utf-8?B?L0pHelVVdmhZY3VFRmJEOEVZVkgxUGg3QVB3NkFrRjhSeUFZbThkeHB4L2tT?=
 =?utf-8?B?RmJZbjhMc2dvNjl0U0RndjA0azFYNEgvNndiSXFYWDIzRDZ6ek9uRlB3Qkp5?=
 =?utf-8?B?cEs3c1p6MUtUWWNrMmxOWlFjM2U4N0Nld2tlVkM5U1k2bW1nSGQvWStWa0h5?=
 =?utf-8?B?elJJdC9pMURaQUd6MFRwY3J4bVdBdUVEcDRvVXc5TDFHbmRYazR4bWx2NW9F?=
 =?utf-8?B?c2R2UGRMdFpUT21aMkN4MlJXUjU0amJxNHgwUi94cXJWZHZsQjR2UFZlWXR5?=
 =?utf-8?B?Nm9qT3FhVWVtYU5nTlFMUFRTZmZjcjd0TVFFK0ZGeDV5ZGYzUFFMbzRPaXN5?=
 =?utf-8?B?NWZSeDYxNktHeVNia0QwemZuaDhFc0htUFBCWmg3VkxwSi9yZjcvRGNobmZ3?=
 =?utf-8?Q?JBUNCZoECvbR8D5fu5xtpDi/2nDOCoB6z38qo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEdDemh1UlhVQTRlcThtaUZqUVZGbzRhYXV2ekVvWkVEVzA1ay9MNHhpYktq?=
 =?utf-8?B?ZWQ5RkVONXI4QTN0K0wxSjIrVGgzcy9TSHliMnJBa0ZmMEhaN3I5VnZvMWww?=
 =?utf-8?B?S1EyaVJZZlBVdUxXbVViL1BzRXNyR0tYQ1czdThmNFlyajY3U25SdFJxUHEv?=
 =?utf-8?B?ODU3TDRFT1M1YVQ0ZmhLUVFBV010eFFvMEpXQ0gxcVJwVUVwbHEvSkxocElv?=
 =?utf-8?B?elRLOTMzYzRyUUpLVC9wUDlkYnhROXdTS3BKNHlITlowU1JZcEpjWllBeGV3?=
 =?utf-8?B?aTFJMnRJc1NuVEdUU1FNRzRmdWdZVzYxTU1hUXRCdGUxMWFiZTFhSlp3YmFT?=
 =?utf-8?B?cWF2WEkxN2d3aWFMVEpyN1pEaVNwSmdRaEVYYUptNk5XOUd1cEV4dFZoM01F?=
 =?utf-8?B?L0tSQU55Y3p5UUg5L3JiSTdoRE8xRE1xQXFhUVl5WDhCWHNMeDducHg5cEl4?=
 =?utf-8?B?MTlLNTRncVBnZmlueWlORTNGM0tROUVnd3R6NmtKaWo4Y1AyaEpxNDVqNFM5?=
 =?utf-8?B?WkNCWThoaVNadUhZUnMreiswT2gxZzl0czNkM0JtVGRpUnNKeGE0eXY5UWNn?=
 =?utf-8?B?Y2hPVDBZRSthWlFJcEw4czJJMnJTUjk3MXV0VWdPeVBLVmhXaWFKOGNGOWw4?=
 =?utf-8?B?Ung1RVlyQ2RQYVhncEZ3SjUwOXNEN0pLMmRHRWxyU3FjYnArMlc3NkxlUTRn?=
 =?utf-8?B?NjVLTDV5TmdtNlM1b0JKRmVOT004MGRSY0dQWUl3WFJMRHpkY1NySU9lQkFU?=
 =?utf-8?B?MHJaanhEYVNOQmV5aW9EZFUvU09xdHR1OFVHaGRudlEzc3dNaTV0c0RXQWlD?=
 =?utf-8?B?dlpweTk4V08rLzdOUTl4YUhRQ09jRFk0U3A5UWE2cVYvQjU3a3hUcW5QY0hB?=
 =?utf-8?B?S0YrUEM5SU9IbEU0SHFJdTZRdWtEVGhrQnVqd0tMZXJ4L0RUYVdrTXk1NHJ1?=
 =?utf-8?B?dGNkZ0ZqVjc5ZnU4RkFoMnZUT1lYdVBTakEwTXJMbGE3cGVvK2hqVElvb1hn?=
 =?utf-8?B?bWFWTkhzcWtUd1BsN3k2eUVnN09tNlI2dncrNUQ5cTlBR0pkZlJZME1KWDY0?=
 =?utf-8?B?T2NOKzlLQlB3MmdjWXJTRDZRUTVueUpCQ2FGcU1BRHJzcFIwZXZFN3h6a29C?=
 =?utf-8?B?Z0VDVGxLcTRzditqUWFIQi9QbnZZVkhCRStqVmVYQXNvVDNpWUw2NVpKWDd4?=
 =?utf-8?B?YTdmNlNQZDJsSzA5dnBXay9oMjdJU09PZHBaRjlKQTBMRzJpT0YvYjRTRENo?=
 =?utf-8?B?Z0RJNXAwQkRvby9RU0pXTWVVc3g2aWg1dU1pWkpPbW1LNjZ4Z1UzMnRnSDUy?=
 =?utf-8?B?TnpwVTAzdkRKY2ZldEdmTUxucE9DR3Z3YlFocVZFTG51eWIxYk95aG9LR3Yw?=
 =?utf-8?B?bXo0MjZ4U0UwSVVaTktTNmJqSE1MVlZXY3hoM3VNOW1Bang1RkY5NXYwOVpl?=
 =?utf-8?B?aEEzNzVUYWp5SEZDNVRjMmJBZ1NHTVlhd2ZyRmIxQXc1QmhrSHQrNGpZZTRz?=
 =?utf-8?B?TmF0czNXRlpJZTdjU1FIZDlhSVFzMEhuSm5mdllVaTNTY2pZc3lkelVpL0Zs?=
 =?utf-8?B?NUVDWDRXZXEzem51ZUNsZXBDTHZKWmpkK0FPY3grUUdFQkN3ZlI4WjhSREdW?=
 =?utf-8?B?aXRLMkVWUmdYY2RSdFVOUi9zYW5remJyelcrY2Z4dCtSSVRPMVhyOTRzU1dT?=
 =?utf-8?B?K3RxY21Qcm5tZGUrTXkzdWlvTXRnVGlrbGZrMHB1aGNKeEJCZjJJMGVuNTVv?=
 =?utf-8?B?RHpYOFFIQUNpNE9kMDFYTlhjVVNkRXhtV25aWmhERk5KaWM1c1JBSjBlZ2hY?=
 =?utf-8?B?bmFvRHNJMHk4eVlucHN5WUlqU2NjbHp6MC9Hckk4dUVuSVJlNnk3NFJHVEJs?=
 =?utf-8?B?RTZIRFZ6SkhoZkpFVnJ3ZW9Ic0srZzZEWVpmam5ld3ljTE5qbTNlNERQRFJZ?=
 =?utf-8?B?YjYwZlplVDZhbm1TNGdFMi91ckJNTnZoUGRwSkEySFJPY1ZtcjZNQnZacWtv?=
 =?utf-8?B?RWpETEJLUFpkQkR2N2FGd2JrQzFBbHVaaHVIZ2pNZ1BGUHc2c3lxK2tveVRP?=
 =?utf-8?B?ajA2eUY4Y3A2T1VIcHdDZnVqajFtdG1mOGtvK3ZGTTlDbVFxU1VnMUdFajFh?=
 =?utf-8?Q?NRF0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019cdf1e-16e9-4160-b599-08dc898e7b3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:47:02.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6TawCaa6RBwEh0tVyLzRciRkBC7e9T+Vlhfx5UFdsZ8Uxnv+CY/HuJJOWv4GftlwvYGRSkVgxL/1K2HKpDNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

The gpio in "reg_usdhc2_vmmc" should be 7 instead of 19.

Cc: stable@vger.kernel.org
Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index e3a653be7dacc..8ab75cc5b9aff 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -114,7 +114,7 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		regulator-name = "SD1_SPWR";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
-		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		gpio = <&lsio_gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 

-- 
2.34.1


