Return-Path: <stable+bounces-49918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C58FF4E2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F0CB23D40
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F414DA14;
	Thu,  6 Jun 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="doPTXVA1"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E394652D;
	Thu,  6 Jun 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699642; cv=fail; b=RRTDuZI6bKpoCv0bJstsh98fDdFoDccAfTgZ9NnGi8zGo5KJbEZHQ8BawebjAmoX9kgQeG7r3gkgOuoxPOA347eehx7d02jwhoIMTIGDVjPwq8QEBJpieSewdKOWwi8B78fQPD4T7l+Js84iCXJPUf+syoAoLh8jEHm/8b+xjsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699642; c=relaxed/simple;
	bh=3VvEvAI7+MkFSCQT3+NlABP8Hpakf4WexKH83iHPpWw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mZthtm+he/gEDsD5+cdyDg4zJPIvDwy2g53jxNYFHsJlVC1344zeWHzJCG6X5/w6xsw0/Z6SFcSL5nfyjqUhNh8E6fhXYoTLDQxJPFIhEvdpWcQ6wd/UBZ2fkhW+7e54xgdyHfEWZXHZYKkJm/WU/kB9RGkVgBmFHyB94gIPJRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=doPTXVA1; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp7ek9HGNG4hTG5UiDVubO5muyMCDbiQPl5GX1DSgp7D+w/yunM2Mz0WJoVTM62uwmfBAh4o1XUwskOZw8rhverELKMRgqE0BlpwCPCwhztJcpGwDl3g+VsooMrQzqREfeK4fx3gS2EOKclGQ6jGDQsE69ygkVN80pRBAWQM9xUZQYPpHxRygTURGLmS6ST8dlUVyY2lq8YX6nHmAP9bwMST8vxeBtMB3PGQvXn0HJQu0k//aN3mFjluGmeFPz7uHXRFIDLaA+Djuv+27rGsgXYcRTif8ZC64KjzTO3Bx2hUjqK1dH4jtclG4txL4UyoXxA4b3wyu4SUkU1U5gmlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v58d4d3VM+rzzM4K0krVNZ6yKq0yL2fiUmYYYcs1CJA=;
 b=eJ/9vKDx4pmdDiGpuSAJ/oqSTss8EsLZLzL0NXP5yXSYDj6gJr5fTZu5LZntTQb4mTncL/Ee8kROP7srYD9CmVS7ivsoh/8OtxGSnNgqpvbRl+UOXK0OGCBx/qZmkNrvcSkPrtnbCQJEbJnePQTSKT38H+yobnj0CIWO8qcdFEihGYf9doOKOM8fxJRYS/rR3kLBlTUiKzKAeXiwJIxscsPOXxG1bJPC6lAqHhllKsXwCGJkHmOZbTZeDXHfRbrIQD34yiJlMvGzqc0+RZj23NKq3e+AUQE050iSqgFf0DanOiZfV/n/XWfXYiIXo6H8GhUdH1jp8/ahRoS8Ymbvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v58d4d3VM+rzzM4K0krVNZ6yKq0yL2fiUmYYYcs1CJA=;
 b=doPTXVA1DPjQYwfdB441CmejqYk4U9N6QkPV04NPX4Wy8nsy+Hb6eyt2Elt+5AZGOEzGDnDJCt+1d7T3BlsvGJ6LGGL3mipEP4F+9UZUclZ3CiCGldhZ4rDtQ7/5DNoZvsCRcwpQ9E6Bv2DgZkNvfnnqj4HqnJT1TLjuHao8FCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/7] arm64: dts: imx8qm: add subsystem lvds and mipi
Date: Thu, 06 Jun 2024 14:46:54 -0400
Message-Id: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4EYmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3czcCovCXN2UkmLd0uIkXctkU9MUo6S0VFMjMyWgpoKi1LTMCrC
 B0bG1tQAD14nCYAAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=3032;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3VvEvAI7+MkFSCQT3+NlABP8Hpakf4WexKH83iHPpWw=;
 b=YukJV2sG54+c0+F4jiBDwrpVDpwL+jvIouDLfmA711uefkGQxDiMwFwGsg1VYYPggHJt72eny
 rc01240ReMhBuTsr0A7EIiXzWj6NVcyTq5VknXweLGdfdTtIV1laTmu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e11de12-3727-4fef-ebc9-08dc865915b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEVUWU90NytkYVJKaTVJcjhXMlZqb1ZxalJMYUhVckZzcUI2OUEyOGRlcUFu?=
 =?utf-8?B?Nzc3NzRpL0tOU3lBUDB0WVJ3NHNrdWxkTmpFcWxtWW5URWUxbFJnWkppQmxQ?=
 =?utf-8?B?enBwZzkzM3lBZ0liVGd3dlZzZjdFN2pZaUt1RkRZbmVWS25lVWFabGt5RzVG?=
 =?utf-8?B?dUJBZi9ONy9yN0xzaUppb051NXNrU0FhbmVPbnpvRnVDNFRQQWlHMHhPSjVL?=
 =?utf-8?B?aGRDNTNreWk2YzR4eHVpUXlTZWl6VXp1R0tpZ0FyaFdsLzdCNG5UTVF1bFVE?=
 =?utf-8?B?ekprdWtOdml5dFljbStYcWtaalAvQVBCZmpzVkYyWXRBUDkxOTBZeTVIajhT?=
 =?utf-8?B?dUlYbkprQWFYWWdrVHJvK2l0KzVTdkV3aWUzTjFuek1Hc3NIZ1R2bTNSTUJP?=
 =?utf-8?B?SGpQNVR6MXhBcEdsWFY3cFUrS3ZJaEVhR2ZSdXdDQnExeS9uSnBVdUpqdjlB?=
 =?utf-8?B?MzBTVHd2VFl4dFRYblJnMXQxbDhUdDYvRnhGdFdFdEdPdWM4ZXdZeVdRaGZi?=
 =?utf-8?B?Z2VvUi9Ud3pmK0RDdlNudFZhdTM2dzYrN2RDT1RSVG9ibTY3bVRqZU1tQ28r?=
 =?utf-8?B?NlNJR0p2OSs2dVJKWHh0YURuRzg4a0dDUzRJYUVhOWJEbEQ3Q25kMitTSGxR?=
 =?utf-8?B?K0IwKy9laTBvWHlkVnBxTEd2SDNMQi85K3dPNjgycFJCMSszejN4NTNMSFYv?=
 =?utf-8?B?LzNUU0JmYkpLc1QzalZUV2JLWFFFRFF6Tko0YXZXVmZyczZ6T0MxL05oVHdI?=
 =?utf-8?B?Y3VCWVFrZUhoTHM3Q1dXLzFoZlVSTnV6Z2M4WlZLSzg1d1VLNlFiTUEyYkhK?=
 =?utf-8?B?RFNUendBZGV5bUZ4TFh6ak9RNVNPU0NsL04yK1l5Wk5tWWN1c1lvTHRMWC9i?=
 =?utf-8?B?U1FDd3lOdDFTdVl3WFJhMXcrV2NxTFhZbk1TSUczVnNFQjE2R1lLVlJneXdP?=
 =?utf-8?B?bGhvSE5FRTgxMFFOR2lXalFIbXc4UG11U2ZZWm9EVDREengvbDU3QWkrclBa?=
 =?utf-8?B?YkZ1TWlOVmhWTDZLbVBNVlFwSXczTWdScGZqU2NkRFJBa1NUL2pzbG04YTlt?=
 =?utf-8?B?U21rMXFvN1FBQWZSSkRybndHQmRsSXdkNjZKV2hxUnB1bFppS0tMY0tJaVVs?=
 =?utf-8?B?T08xWU1Oek5rVDNQbGlVYTdMOFZQR3Rra1ZYUjBqdm8rOW9WTSt4dFExYVZs?=
 =?utf-8?B?aFd1UThrZmQ1ekF1cUQ1RkJIV091WFo4NFl3aXJJaVV3OTBHQnZVM0wwZHNI?=
 =?utf-8?B?UUJ2bFVNNDE3Tzd4cVdtK0kvOXBQRFJpUEUrbEYrNzVJUWJxdTVMa2E3dEVp?=
 =?utf-8?B?bUlRbXZBYjA3eVJOWjJVcGlnODI4VVc0cW9NWmVnUHNQbFZHUDBQKyt6V3Q2?=
 =?utf-8?B?ejFodHZ0MHNUemFWN2o1bWxQdWxFbFQrVUY3VXhuRHlEZFlNUUswd0VPU2tV?=
 =?utf-8?B?Qjg1N1lhQlJYM2s2M1hWemtQT2l4am1lV3kwOHptZ24wcHFmWVpUT0VvblRy?=
 =?utf-8?B?R0Rsc0gzK0RWdU9BUmlna0VxNUFnRis3SzJrbFhDSGxQSW1nWWNXWHFQZXI3?=
 =?utf-8?B?NVhlcDllR2U4aEcvS213WU5IUHdBOE9aK2RIdm5waTM5bGowOUpUR3ArWk9S?=
 =?utf-8?B?QjFSRDQ0cGRlZVAyOFc4TGJmNEZsaGc3VUVPeTJ2VGh4TElad2pDS2kxalQ4?=
 =?utf-8?B?TFZVS1hxUFVjdExqY1ZycVg1WFRVNVJsNy81RDgvQUUzeDNqVlZmTzFuY2NS?=
 =?utf-8?Q?kR4HCGiITYeXmBJqDQespaxlRC6NSYX2tKIp4K4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpFaFZwU21kMTFIWUo3aHIrUS9vb1hDa1NMWVBkRWluUlBPQ21haG5CclZ6?=
 =?utf-8?B?cHBTYWFocE9XVHhwcnhYV2N2SUdEa3REMGdna2R1TUZoc282MnA2VTFYSVM1?=
 =?utf-8?B?elA1Qjd4ZzRlcTBiWXVZbnYvTytpSEsyK3dxUzlxSnFKK2k5MGxvR25INGRG?=
 =?utf-8?B?eDF5bFJ2RFZRN1NxNHlMY2l0NlVuaVlNdlJsVUZDSlhvOW0vZDEvMjBvZVBC?=
 =?utf-8?B?VGZFbFRpbW1wQmdPYzFxVmlHbmVjU0dqc2tGNDFybHhJSVJLMnMzQUFBVjR5?=
 =?utf-8?B?QkdsTVlnMDEydzZ6T2NXMFliUEpRMjRDbmdSZTVTT0s4N3ZlQWZQUUdOb0NQ?=
 =?utf-8?B?VjVncWZnTTgvV0Y1aGVHZ1pnNjdUUEpzdGdIVjlWT2hUdEY2dFIxbFkyQVlr?=
 =?utf-8?B?NXV6aGw3NmQ4MDlCeTlLZkdlY1lPTERyYlpJejJNTFFHTHU3UmxaYk1QTEgr?=
 =?utf-8?B?Q3FBN25VOGc3VFRuakVNdlp3Y2twVUp3NDJIYStqR0IvSDBmM0Z1Tk0wNDZQ?=
 =?utf-8?B?SFN4akt4LzlhaEF0SFZ6bkg4aVNQZldkbWYvU3NTOElYTks5NGk5QTlBSW5J?=
 =?utf-8?B?YVRaRlhWd1AvZ1ZXYjN3SmlvN1BUM1pIZm8xbkJFRHRlRmRRdDVjRWo3Qk1j?=
 =?utf-8?B?WENCZXpuekdUMWNMZURVM3JBcGF3M21GdkZIYWxDVWx2NFpVQnpqbnNHNlFS?=
 =?utf-8?B?ekYzR1JIZmd2ZlUvc1dJUytQWUl6cTdxdUtlQ1Z4cEU5N0hIcUtqaHY5RXps?=
 =?utf-8?B?eGRtc2N2bm03L1ZkRDhFTjNZMUhSMXgyZlZmenJuOGVBb01iQlF0K2hGQzVW?=
 =?utf-8?B?dXB6YXMyQ3V4RG01eUVTVS92WkxIR29PeWFRamlJZzgwYnBJZXRsY0czb2Jy?=
 =?utf-8?B?dnhMWXFyc1U3Szc1K2ZjUTg4NHY1c3YxNnNhYmFiU2pkZThMVDZaQnNpdHk0?=
 =?utf-8?B?Y0tWQkRDSWZIQzJPc0wyQjNvTjNGRFpldjhoQ1JHRFM0SXlnb1dmbXBpNUpy?=
 =?utf-8?B?eTZjVXZMQnpJVkkrZWROSlpVVnNGeGJ3RW13TDVCSlFVQWhRWGIra1JWajNo?=
 =?utf-8?B?clF4TTNQODRid0Q5MkhlazlsN0xMRVQ5T1FWc1g2aUJMbENlQUpiN2NPWHpW?=
 =?utf-8?B?d3BjQk53VlB4aGxpbGhUeEdqNTlBb0FnYzRuUlNFa3E2UWpJcVFaRXBYUHZx?=
 =?utf-8?B?S04xMTV4UWhwT3BOY3lrRkRZQ2dROHkybVg2WFpFTktCY2ozWVV3SjkxZ0xW?=
 =?utf-8?B?Q2s2V3I3QnY0VzQzODZzdHlqa0ovcmN6NFpEcTg2SHAyYUFRRW1ncW9uUkww?=
 =?utf-8?B?U0h6TjdVaUZnM2NMYnJXZm5KQWZ6a0NxeC9FSmp6ejA3MS9RQmVZMWNJRG1a?=
 =?utf-8?B?UGNhM2Zla0ZqZU5HNWJqRkU2MXNyZm5YdHcyUXE3QlRLMlgwd1YrY0J3MXg3?=
 =?utf-8?B?ZEY5SFAybDM3b1VhWjYvRmNGbUhLK3hOZ0YzNjV3dThLYXJxYzBOdEllSzZy?=
 =?utf-8?B?clhtZUEyai9IZ3J2NG9WVlZOQ1Z5dmt2NUphdEtPQTVMN1VBVEVhZTNZSFdK?=
 =?utf-8?B?TkVaN0M2dFJyaUlsQXAxOHhEVGJvU3RReTIvd2t3UXJWeGFKYzAxVHFEbytU?=
 =?utf-8?B?dVNVZlg5MzlsZEo3SnpnVnlQUlQwWXN2OHV6alkvSjM2cHBwWFJXOCtWKzFM?=
 =?utf-8?B?eDJicnI4WlhUWmM3NlFJVnNYbWFtS1pkc0lZU1VOWFhCL0lSOUxZSlV2SXBu?=
 =?utf-8?B?ZkxoK0ZySTJZVFNlWUt3bjg5MG5vMm9NNHpISUo3MmFMTXBpOXpCNXZVNmJP?=
 =?utf-8?B?bm9SSW9xUHJucThONXRqanVsUEs3d3ZCMC9YK21ua3o4enI5NU1XdDN0WjVh?=
 =?utf-8?B?K2JKbUlhdEMyZ2NEOXN5bVk2VGRTNHZoMVJFeVYvSkMxQkZXaEhUMFdjaE9k?=
 =?utf-8?B?MEJ3UnRnaVR6NXBwbVVCek5SRDZmbDE3UmkvdWxyM3hJWVFMSy9MbXpLdzNn?=
 =?utf-8?B?ZnI5RDcxMWtNb0tlWnF4U2tOemhlR2E5ZCs5RGlPRjhyajhtM3BCdTBJYjBj?=
 =?utf-8?B?dWFtcWlWZnkrZUZKNlFPTHR4dGJIT0QvZWI1RzJIem5yQlFpUlFFTUZPcmQv?=
 =?utf-8?Q?t9mv2upCe+DGHB8VRbK0hon7g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e11de12-3727-4fef-ebc9-08dc865915b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:15.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA3RemG05rUvtXw/Z85DgV2W6YSeheDYLPaFjUmjgUNntfkcAu7Kggzrkyhb/EWAcy1bOol4icnG6kKKpZanwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Add subsystem lvds and mipi. Add pwm and i2c in lvds and mipi.
imx8qm-mek:
- add remove-proc
- fixed gpio number error for vmmc
- add usb3 and typec
- add pwm and i2c in lvds and mipi

DTB_CHECK warning fixed by seperate patches.
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#

** binding fix patch:  https://lore.kernel.org/imx/20240606161509.3201080-1-Frank.Li@nxp.com/T/#u

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: interrupt-controller@56240000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#

** binding fix patch: https://lore.kernel.org/imx/20240528071141.92003-1-alexander.stein@ew.tq-group.com/T/#me3425d580ba9a086866c3053ef854810ac7a0ef6

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pwm@56244000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/imx-pwm.yaml#

** binding fix patch: https://lore.kernel.org/imx/dc9accba-78af-45ec-a516-b89f2d4f4b03@kernel.org/T/#t 

	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-0: power-domains: [[15, 278], [15, 297]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-1: power-domains: [[15, 298], [15, 317]] is too short

** binding fix patch: https://lore.kernel.org/imx/20240606150030.3067015-1-Frank.Li@nxp.com/T/#u

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (7):
      arm64: dts: imx8qm: add lvds subsystem
      arm64: dts: imx8qm: add mipi subsystem
      arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory region
      arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
      arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
      arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes

 arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 308 +++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 231 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi | 286 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         |   2 +
 4 files changed, 826 insertions(+), 1 deletion(-)
---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-imx8qm-dts-usb-9c55d2bfe526

Best regards,
---
Frank Li <Frank.Li@nxp.com>


