Return-Path: <stable+bounces-212721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id llifLbW7emm/+AEAu9opvQ
	(envelope-from <stable+bounces-212721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:45:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208BAADE8
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ECB0300E154
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F72AD35;
	Thu, 29 Jan 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KD+5wKKl"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D46126C03;
	Thu, 29 Jan 2026 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651119; cv=fail; b=EIBus3ScKejvriWWksYQ4NaGhZfuhmDoYr7LrSIEzIlPKyGLyayaoEtMuXeg/K/CgimoYUtdZ74cLCiXvD0YlYLBdLR3E4Vgv44HTh3d8fowbSBz7+BzCrSAnfbXwr3PP1K5Ku37vDGknLfwb8D58EptmnsBVHuwuV2WKsw4goA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651119; c=relaxed/simple;
	bh=AfddR71qLycNeBeqiIaWcc2R057bxAmu7AEy8xJ4T2I=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ckNcCCEgH6yD06/Y/c44mEzGZURRRHJgimfikIg/wXz2IkVaKO/ISRdCzyKg3TQmMFfzt4GkiXaHh9Mv5dcLbKgEosdcda+TMyIFB8W+ilhwqOUUsw6kxa4KuMf5u7w0yh/FBASjo40L0LtwL1lhf4rF0xwbrmP6RrzIrdtjFGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KD+5wKKl; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeLU8JMFE33zR4BNb+SK1elllNJTsHSKlLV74LJtmkdeTJ15PIPsydex4gtCpz8AifIjcTy8+arMqaibqN/qssqOdhMQqzyJwrJ/fCNwcNAxh9NtXBYZrADwTWaH+C8/F2McS1VTFQBBhDfu4S01qG/zHrzqPs3yomqz0EPdHtEr3rpkXU+Q8OQmRq9xDBrr/rnBxCVJCsjeVjoOyiTDIgpk5ERI7kJ9x2JOOmp0G00AAA3vDhUdGPpZH9399AIsEfmK6J65mlb+5n141pKCal9EKx6EpWUmok3Ug0l2U247CN6MGgdISD0yrqD6fhmB4T0L7P2fzOET0o9GKP1pHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIDNSyLWirMr0WDceTZRf7kmZZKUgwL/YBBkS9vY0Pg=;
 b=GqYi4uRxUZqTH19uvCxcb3FvtFwkwTnGSXEhx0S9IV8BwffB+3ppGYYTMOhCfSrqP4kWmgKj0kMWc+rXLs+naMq1+mkHxVYv+YCve7d5YaT4odqBSoStqQG3aD+N13oAeeku97zcjKkoPN/8orF/vMORDI/+gxnsK+cVx7TF5FpGSatFqZnJ4M7B8SKoxfR3ip0ABK29XBufR7RpLMoqOhQg5gBSCvKFwqampXl+2WTBYXoi2yWghsIIv2CY3N5w99hd/EdwiRc8t2nP0gNYLaVDWoT1yjtEE+qq28AkgGOh1oGI7i9e2f5nFqe8fVyf6Pqq3jOoCmzKLx1ZDKyz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIDNSyLWirMr0WDceTZRf7kmZZKUgwL/YBBkS9vY0Pg=;
 b=KD+5wKKlSsG8CC+CrgbP5R6AMTH4cKnXY4qdJFYnU1gVbgzvGsej5mLyXN9bI6wUsT85oXueL0XtGHS1CiUlEGL0on9uVfJjtWWyHE0jGX2NRKx4gYzbHBb/ghjqZ04C9DTxkGHsmW/BmaceiN+3JGK1d/Sy+Y3BY6ApOy3cBXSkT5bd8Sx7LDsRoMm0EuI8eT4xVanZzJUmUMBcKQxyi3K+mSu8bA//t2bd88d5f+Vb1z08c3C/DtkQOCiYtDMM5ND75kVce4jiu3+HKh7gznlv3vb7AXxuk94kP++w0FjLgtWTRaBfS8JF3u+hFQ5jR4KLjoMygLGgDAQxLx/KzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 01:45:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 01:45:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 09:44:48 +0800
Subject: [PATCH v3] remoteproc: imx: Fix invalid loaded resource table
 detection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
X-B4-Tracking: v=1; b=H4sIAI+7emkC/3WMQQ7CIBAAv9Jwdg0sCNiT/zAeGlwsh5YGDKlp+
 ndpLxoTjzPJzMIypUCZtc3CEpWQQxwryEPDXN+ND4Jwr8yQo+YCEcIwQ5pSdODDDIRce0ualDG
 sNlOiqvff9Va5D/kZ02vfF7HZf6ciQIDUzmkl9blT/DLO09HFgW2fgt+t+W2xtgat9c4bJe3p0
 67r+gYXD6ex5AAAAA==
X-Change-ID: 20260122-imx-rproc-fix-e206f8e6e477
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>
Cc: linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: de11905a-e04d-4957-8393-08de5ed80b5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGdtUWNoc0RoZUMvN0ZBN1ovN3gvb0FpVHpGZm1jS2dyZytnaUZldzBTS1Vq?=
 =?utf-8?B?bG9KL0tCUCtnSVErc1VSWk5xUFpta2xHc2Y2aHVyOXU3MDIrNWNMZjVGZDlL?=
 =?utf-8?B?OU5KYVNIdXdHcnlzeTJZYjdVend5U1doaFZ4ZUJqUnJrbGdRVEc5SkdSNWJJ?=
 =?utf-8?B?NGVzVUtBZm1sRlRVNzd6bVRHVzZ1dS9TdGhNZmM2WEE3OGhoRkVFVlNqNkhn?=
 =?utf-8?B?ZXpkQVc1TnlDNGJaeFRRVjFyY2tFT3hkNTFlcnNsZVNhU015eEdrYkRtakp5?=
 =?utf-8?B?anlBY0ZrMVJNaXl2c1U5SzlyWlR0SzNKMmxodXhmdGt6K3RoMTBHRFFTc2Ix?=
 =?utf-8?B?MnpIZGdrZjkyOU40UDV4TWNWMy9yeGVrZ2FRUjFLUmJMRDlOMmNCand1ZXQz?=
 =?utf-8?B?QVVaYTRqTlU3WThrUDJON2pJSGlSWGo5c0RrQ2VlUG04T0hkU2JVNnAwZ1gr?=
 =?utf-8?B?WnNZZXZ3OVBCS3BacWlKWVlZNXVpSzVrT0hIR3Q3RnI3SVluV3NtYXg1c2tH?=
 =?utf-8?B?MnVBeDlnYU1mcFd5dCtWNll2QnZzd1NaNkt6Tjk4c1R5azIzd1NnSnhXaXFR?=
 =?utf-8?B?M0I4ZDh4TEZUdkxWczVub3NSWjFyeWlYc3d5Mm81M0NpclhuS2JwVEVkbllM?=
 =?utf-8?B?bjZiU1JRMHQ4WXBrVml1MkhDT01yeE5VWHFyWm92U2tESkU5S3FmdVhFRFY0?=
 =?utf-8?B?YTRMcmg2NFRFMFdhTVNteFRBSEtYbUFyYkhRSmR3SHI2YWRoZ05URDVDblVI?=
 =?utf-8?B?YXFPeEl1Q3pZSkVaaDAvRFdvL2crRmxZaWk1SzB4QzEzd2lBWU83dXlNWmxs?=
 =?utf-8?B?SXhuUGFJYVRkMjNueVJoMjBhUVR3dmhZdjBUb0d3UGpueFJacEl0UnFWaVdV?=
 =?utf-8?B?MXV1ZDBCUERsa3JFL0E4ODIwQzc2VzhrQjVWYWo2bjVHbytud0hVN1A0UXYw?=
 =?utf-8?B?bkdiaVNha0ZLbWlIbGNObDA0UVUweXNxUzVPMVY4SDdLbXNzOFRLL1o0cDEv?=
 =?utf-8?B?V2duUWxnZGI5MmdVb3ZlMmF0TWZOUmI4MFF1N3h0Z0E3MGFBQmlINGFRbmdO?=
 =?utf-8?B?cVBObmF4dmdKWFpQN2VvV0FnV2FSRUY0TmlEOUYxUDJrajMvMmFvenlZRzJ2?=
 =?utf-8?B?SUgvZ2tPMUUwb294WUV6OWJxekxhYWtHaHhzcjB1YXk2dndTdG5wYzdRS09a?=
 =?utf-8?B?aVJsK1Q0NXFmK21iZ1VjRWZRZ0RrV3NCaG0yT3lDUmFHOVEyNExnTEs3dUUv?=
 =?utf-8?B?bWJmVnZxQmY3VXo2VS9idWpNY3RmL0xJcGkwMm5IWTIrdDFBN2tsMHVZcm5G?=
 =?utf-8?B?TGNhSVFuaVV3MmkyOEFnVmZxZmJiNm80b0lUN0dtYm8xMkhxb1c4TW05ZUpX?=
 =?utf-8?B?L3c2Y1VMMzV6UU1NWFVmU1NFaDkwQnoxOUFWV2l0Uk5XcGdBcUJ2U24zaWpm?=
 =?utf-8?B?U2N6RVdsNk5VejJ5OTFUTWwyOE5tZUhnMFFtT1YwRHAzMGQ4YXZxTEgySFNI?=
 =?utf-8?B?ay91MlRsODRkMGRSRElLcG4rUXJJOWF3ZUhHUnhCR3RQTHVvSW5XSTBZdzJt?=
 =?utf-8?B?cHdPbFBsdVo4cnFDSmR1SHJMaDlGK1VBZklDa1ZaZUhOeU9YV3h2RXo3MVhq?=
 =?utf-8?B?UllUMloyZGFOZmZOQ3lPWnFnMkVkS2t6QWJCK2JtekhuOTI2aEdpWHY4dE9R?=
 =?utf-8?B?bGZ1MStOeGI4M0FhN0FSaW9pdnNaNFVaaTlGMU1nZS9jNnJyNTFCNytSR2xN?=
 =?utf-8?B?SytocVFZQmtjZ0NwS0JCNjZKZ1c4V1RpSUxJWTlmWDhCUTV2RmNObElwdSto?=
 =?utf-8?B?emZJNlIrVWp3ZFAyZCtmdHNwdlJzVTNOZ3hVMUhuYkRWajZhUExJa0JxVVVx?=
 =?utf-8?B?bUZ3cnRUUnZNb0JIc1ovZ1VhMHVFS0czZXVhaVM1aDIvMGlPb0krM0ZHQnZy?=
 =?utf-8?B?a0xmRnNENHc2YmVkV1FobVN0REs0ai9QdnM4VVlmeEpCN1Y4ZU0rbHdjMUtk?=
 =?utf-8?B?c0phSzJpc0lPbzh1MUFRME9RQ0J1WmdET1BNeVlDVXlpWWVhWFAzTS92TURV?=
 =?utf-8?B?dWpKYXliRDNZb3JGYkI3d2l4QWhacmJqdlcrNElTMlpsdHZLd2k4TWxJNXE1?=
 =?utf-8?Q?n5RN9MYo4p0hPpQhMlHBhnP8N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVkUE9SS0g5cFV6US9VeGMzWFd1dGV6d25NMHF3dFBSQ0tuc0xpUHIrZFhB?=
 =?utf-8?B?clFWY1hoY0lWR2tYY05HTGIwcVJYTm56bFlETWxGc1cvdjhSb0FYTmFPVmxU?=
 =?utf-8?B?YnM2alpWUktzNExtZW5lTmJJM3dpNUUrM1BQKzlUcVR3R2o0STFMN0xZRXJQ?=
 =?utf-8?B?SWZyRU0wR1hVT0FUR1ovMW5teHVKVHlYb09pY0NzSkFNWVZKbDhpVWpIR2E0?=
 =?utf-8?B?WmtUZzB4QzcvZi9iZW9pSzFsTEVhZEtVc3lLcFdqTEMvTVNQUHRaZmp3WlNi?=
 =?utf-8?B?ZmFmN0IwcTNJeFk1NmgrbWVlcExKUmJ0eUcyeU55Y285VmZHNndxL004Y0I5?=
 =?utf-8?B?MnBFWFJia0ozSi9tT0ZMa2h6QzNQaFNLVkN1TGJoWm8wbFhCU1E4ejVwTmV6?=
 =?utf-8?B?Z2VzSkVBVlA3dVRUb3dkZUcwTVdVbHRrR1RpMit5cmZuTEczSjdMcTdsS2FR?=
 =?utf-8?B?ZlkybkJpTzBsTVFvKzdyTXdGSTRGVitCc2NTVUIwQTBSSHd2R3RFYUMrNk5X?=
 =?utf-8?B?dnFkRlovUnFaSUVYVHdsbTI3TUxtQld4UTdiQ2NSVEpnSkhJRkpJOFFnNDM1?=
 =?utf-8?B?RlFvc1BuK1M1SGdjYUZQSnViQnBIUm1mb0JUeUFmaWd2UWtWL2gzRlNHM1N2?=
 =?utf-8?B?VVVhanViSWwrNG1DcittY3VVdWlaM1dpQ0JuU2FVYWorRmdWQTVWT0RlNGd1?=
 =?utf-8?B?bk0zYmNkU09JbllVVHgxSGhHVExxR2swNWttYWk4em1hdzFpblJDcHJFUlly?=
 =?utf-8?B?Z3NIaXhBZ1d1ZlpJeTAvS2FyOEpDMWJtS2tEcm5WUExtL3BFTUp2eW1TR0Mv?=
 =?utf-8?B?UXlMSWZrMFpNTzR4UmJzUUVTYytnellpbE45QnkxWWtBdlRlQUtXbGk1aUs2?=
 =?utf-8?B?Y3JNb2U2MnY3RWhOT3l5ZzYyUXdraGpzUmhuZVkvd0wzY29JTkhYWlJ6Q1VI?=
 =?utf-8?B?RGQ1K1RkbUdDajNXSndvTUJ3dm9Fa1p1aDhkQ0JPM281cGlqeUZMUG1zN241?=
 =?utf-8?B?eDdRdkhQMDNlNW83eHptMzJSbXVRSC9ZSU41WGdyRncwUjJNWWg2QmRIY0Zw?=
 =?utf-8?B?V09uNUdCSDh3T3VzT1l3b2FNcmZ0cFR5ajZIRTUwcDBpRVNWTnRTSXgzR3R0?=
 =?utf-8?B?NEdSWE4yeG5uUlVYUmYvTmxHc2doSEUzMjRUbnhJc01MRFNGWnRiRW9HaUhW?=
 =?utf-8?B?c1JRNlBLMUZOTFpFM0xXSWlYdkI0UEp5NFcwZEFBVi9BNWFnOUNqWjNDOUZY?=
 =?utf-8?B?VjhEUDVvbll2NHFsTDVhUG5iMFllcXFLMFhpTDhpMThzSXNLdGNQNHZJUXl5?=
 =?utf-8?B?S3kvZ0JiekhzcWNlU0E3a3RIRllmcFRPSG91djBXVk5IZHRibzJxRENpSHJX?=
 =?utf-8?B?SEI0Q3dpci9UY3pwTE5tcE0vOGtFdDdZeGdUTjJHN2lvMjBid1l3SFV5eTlL?=
 =?utf-8?B?WXB1K2hDRnBTMVA0YktqUXVoSG5keHpFQVIyMnBRZnZlc204L3FZZGZkQS9P?=
 =?utf-8?B?ODMwNVRZY2syRi9Oci9aUktOSVVTWEFRUzc2cHVFcSs2YzMramUvOVVneVJK?=
 =?utf-8?B?cStQU3pqak9WVmNJT3AvMUx5TDhCTXozRENWOTZiYWVSRjU5dW9rKzBiZ1J6?=
 =?utf-8?B?UTZqcDJVREVWRnVlcUc4QVk1cFp2TDNRMVMyNmk4TzJFSUlsL0daNzJzWXNh?=
 =?utf-8?B?OUZwbzVJd1dLUG1UVVZoQWUyTFV3UGlzU1N6SzBxWE1vbFUxdHZIZWJTa0N3?=
 =?utf-8?B?eXdEdGhXbEV2d09hRG10R3NXbDQxcC96eEdQclNiUG5VMW0weXJocmlUVTh2?=
 =?utf-8?B?Z0dKUThWQ25iWGw3c0JNV0ZJNElYaGY2Sm53RkZDZ2ZpZFk3UmdSaGdvMFo0?=
 =?utf-8?B?N3UrV2tOSHZ2VkU4UVZPS3A3TDQ5VVl4T3hXRTBUNXVTMlhiN2RyR1FVdUJz?=
 =?utf-8?B?dDNuMkdWbkdIeE9jZXhZRlppWXlXMFVmU2lPSit1L21UWTNQcHVTakx4alhh?=
 =?utf-8?B?dm42Q1RnUEkvZG5GdmRObFpaZmwyaHNHbnptc25NbUdQQXhta1JwUXQzWjU0?=
 =?utf-8?B?QmtNZERFY0R2VnFmUFJ1Z2ZWMEdPTUs2d3dORzZESHNORDR3MzJMMTRzcldl?=
 =?utf-8?B?MWlLZy85MU1laU9kMmgrWHdOUnAvWVVHUkFUSWIyaVcvL1NZdzFidG05NGxF?=
 =?utf-8?B?QkJ6dEE4djBGaUUwTExSNjdZQk0zd1ZjRUFXMEhoaGxJVUFCVkppTVRrY3h6?=
 =?utf-8?B?RlFqdUJ3eThiNlNXTjg0Tllmbk9HSDQ2N1VLUWFHdU9Ra3g5c095NVM4OGxQ?=
 =?utf-8?B?Z1hCdkc3enQyaDVUZXE0S0Rqc1ZPUlVtTnZQSERQS2hqV3hiUnJXUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de11905a-e04d-4957-8393-08de5ed80b5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 01:45:13.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzB50XBqDTlMZXoL5jKNPhkX8UW5G/0HEY0wiccm833McNdk/Mz4ej/uIGuI9iLvPuSADBUpnIaI/WfallvTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,pengutronix.de,gmail.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212721-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: 2208BAADE8
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
resource table even when the current firmware does not provide one.

When the device tree contains a "rsc-table" entry, priv->rsc_table is
non-NULL and denotes where a resource table would be located if one is
present in memory. However, when the current firmware has no resource
table, rproc->table_ptr is NULL. The function still returns
priv->rsc_table, and the remoteproc core interprets this as a valid loaded
resource table.

Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
there is no resource table for the current firmware (i.e. when
rproc->table_ptr is NULL). This aligns the function's semantics with the
remoteproc core: a loaded resource table is only reported when a valid
table_ptr exists.

With this change, starting firmware without a resource table no longer
triggers a crash.

Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Update patch subject and commit message using this one [1]
  [1] https://lore.kernel.org/all/CANLsYkyrz+A1iEabGZ6rFybFo4=mM+TPVDRSckFB2YUS_7aKow@mail.gmail.com/
- Link to v2: https://lore.kernel.org/r/20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com

Changes in v2:
- Per Mathieu, Check rproc->table_ptr, update commit log
- Include R-b from Frank
- Link to v1: https://lore.kernel.org/r/20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com
---
 drivers/remoteproc/imx_rproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 375de79168a1c8d11b87ac1bd63774a3feac106d..f5f916d6790519360f446f063e09d018c5654953 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
 {
 	struct imx_rproc *priv = rproc->priv;
 
+	/* No resource table in the firmware */
+	if (!rproc->table_ptr)
+		return NULL;
+
 	if (priv->rsc_table)
 		return (struct resource_table *)priv->rsc_table;
 

---
base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
change-id: 20260122-imx-rproc-fix-e206f8e6e477

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


