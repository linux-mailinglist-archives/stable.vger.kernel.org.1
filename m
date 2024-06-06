Return-Path: <stable+bounces-49919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0028FF4EF
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 20:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8349F1F28F99
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A80197A65;
	Thu,  6 Jun 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VnMNfRyE"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055961FC5;
	Thu,  6 Jun 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699659; cv=fail; b=MIbg6ElXjwy/qHWdZvXRXFU8mzORlpse1LF8a14TNVtkgrKff2c3kK89vJCbWCyfS9CjIdVoi4gHNjpbb6LYvv32NWpNet6JQOrMzZBxJa8sRBhh6XpxyrBc8ST6geeCNWrIZh3PM183887vAk/tWk3j+HYQSxWc8UspptunVmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699659; c=relaxed/simple;
	bh=UrodID7kXwDWxEQwJ7vYrGaE/FWvVYaJpzEZUqGH7JE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rj1ovFa49WHNKt9RSQulZsYozVJVF2tjsWjxCCX/3psCSHt399VYS5tO3pRNiwRE1f8KED607c9vkqYt316aMTbbY61To1/Lo70+VgYTSyTvLIqT3uhnY/N8saWrAZo8inngISSQQR6qPI4yItaIOWAMDiHnsFM9WFd46E/zQRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VnMNfRyE; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va4oCgIwiLxt3RtZf8L/LxCvRImRo0C9xifIfK6xNbMg/GuihaZJftvXqwGR1/tGoImcyXLsUhhEPDPK8wSOUUQp93gFs4qDDYT4DwQTOlOA+Oen4NmWPLxklwTKYJuu+ErU2HefotZy9o94c5dg+R/mcAUMo5Mhirwic5UfUx37E1i2QgmJpBZRCK5HwK60O0bC6DdS6ueht/DrQ06wsieSbB8Yd+gmzehyI++2wqwHEFC+zJuvhsOdVmen4BUj1Mli+IpfZmGJQ40nM65Qx8BLjpjjP2TioMhke29melp+Q9cAdfpJMhrRRb1lMUS6xJ7E30hjKE0Cj5Xd+Ja9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSIiudocyswGQSnzeHPkKRyxL6teeEFFDknuyDw1PTY=;
 b=W8MIHshwxfsPMKwPzQDUfEVaKryUwCJfXYGrGnPJV8skHkD+9wwum/jrZVlAe40CbSZYv9b+WQgBdC097p7DBTUM5qfzgYFe1Utp/dC7wJXlH7UAr11+FSa6BlXtFtv8p02g/HJn1TAPNrpjaVu8W09silGAa2In9vjIWftWscFC5h9Oky1ktg5svRJ7T/bEqHQiQFVwdkIdgrwi6wNRvLe7BtpD5Dd9/QCNDlIIjnRGMqImaKsq+IS1YwdUUw9ZO9aWRJA4Oszr6UTnImhxslw/MfkGbbDksZgISUKU/5N2W7St/lCZ+5oyCXhhJ1aSZVuTXR4Qkw/gvtDYIfTwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSIiudocyswGQSnzeHPkKRyxL6teeEFFDknuyDw1PTY=;
 b=VnMNfRyE0cnVfng1d2OTzs8hk0nMlJskhETAzsAXZRaswIxWWSb9Byccdnj15GsDkw3412zqYMjqyFocd6QVZA9RAQRT4Gs+2zrebeOiKKkFR6xKtdCny65zJ5kn3hGqslt5KAXhHjg5fVNR4AF1/6Sb//YTnDUBX2VBUGSN3YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:47:00 -0400
Subject: [PATCH 6/7] arm64: dts: imx8qm-mek: fix gpio number for
 reg_usdhc2_vmmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-6-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=865;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UrodID7kXwDWxEQwJ7vYrGaE/FWvVYaJpzEZUqGH7JE=;
 b=XkeM1LO7Kkc4gQEU2R+IgbfQesDyphp/SSQzB52zKh5lLxI0oObEAg4gKgbV17BopC8ct73N6
 Ss2j4zPPgOxC54aG17VPhmj/iQMa48hQIjF8Wn4yM/SUglZ7e6Ck/wQ
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
X-MS-Office365-Filtering-Correlation-Id: 893620fb-c626-4ee0-a0c3-08dc865921b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUJrNWxFWnM1OTlOZ2hoRnlHK2RESkZKTHRXYWVmWVlhNlR5Z0ZOMVRabCtq?=
 =?utf-8?B?aVFxVkpTN2ptWHpjQm8vdGtQbjNTVWptWU5iV3YwSjl2TmNTZ0ExR2xuVlV5?=
 =?utf-8?B?Q0p5TitKWkIvWGpWUkpZK1NiSk02VUpKTnNsQUl2dzRsS25aSWs2TVluOGpT?=
 =?utf-8?B?THBWZnl5RGpWYW1LYWY4anZic0RYc0R1eUl4RTFzSDl0b0hXNjVJZXh6b3JO?=
 =?utf-8?B?eWZzMnQxR1FXdEExTEFWSnpOVWxxcU9EQWlUZXRvZFhMNzRrbkJ4OVgvVHdU?=
 =?utf-8?B?RzJBNWIzUVprQzR0TGhpOFF2bkpHV21VWUlSazlKSVhibkp4bTdsMlJ4bjVi?=
 =?utf-8?B?SnU5WlRNR3A5cWhLR2h6amNkY29LcmhYU1lHeHp3ek9wZ2Rpa1VCc1pTWHdP?=
 =?utf-8?B?WUpKT3ZWMHhsZUh6RmhUNFdPM2J4L2c0WktTcnk3Z201clZSdTUxaWZSaG9B?=
 =?utf-8?B?aU1aSU1FcVRMOEZmdWxCYVhRMmpDU2ZzY29zRlhSUGVBVndXN3dTZXZlUHRj?=
 =?utf-8?B?aGNrd25WQTNUUlpkSVRUckJTQ3hrakQzejlOd3A0YXIxVEJRSnFhQmk2OG1p?=
 =?utf-8?B?bzRWVHo2L0pjT3M3UXBabDdwaTI3aFlGNHBzeER1emhPaWo3NTRVMDRaemdY?=
 =?utf-8?B?bVpjWE5odDhtdkNSb21Nb1dnRXdVc2ZjSGsyNkF1UFpUaTNhNTNuL0pYaVM4?=
 =?utf-8?B?QStVdnRJaG5xTUlLVWZZMitmZTMrUVVTUXFKQmZ6aUhSbW55bFRRWGxZWVhO?=
 =?utf-8?B?UWpMblFWQnJ3enFobEloQWppOWcwMCtRcDNMNlZVTUZEdmRFWUM3bzJEYUda?=
 =?utf-8?B?blVDcW9ET080cVcwWSszaGJFL3czRzVvRHRSbjRFdDRjUjNrRWpnVERwbDAx?=
 =?utf-8?B?Vjl6ak1CRHVqb0RLNTdtVXVzRWZrZDVrSmxHbE55VVlDakpuTkRZc0dyQjNj?=
 =?utf-8?B?Wjc5VlErU04vWGxJcDFhUkorQm54OGcxQ3E5VWFRd0ovSVpYeXBtcm8vMTlj?=
 =?utf-8?B?d09RK0lpZm9vMVhYR1FtVElxZTh2QXJZMVJnNEZ6VytwTVNwWGt3OFpBQThV?=
 =?utf-8?B?VDAybTFiczljWWZSMGxoenVVUUNUeG5XbHNnVE5uckdYZ1lpaXVEbVEvR2NR?=
 =?utf-8?B?Z0N0OU9leDdKLzlkVGtDa3RFZEQxK05SMnMrcXUvVHVhNTNsOU13V0ZZbCtw?=
 =?utf-8?B?MUhPQVJYL1RSV2tSaEN3QVkyb0diSjFzUmI3VlowSHdnVDlUQ1VTWHM1a0ow?=
 =?utf-8?B?czJGZmpESnBLWUt2M1NmRWIxak9VNnA4cVNOY0lDbUdodmhId09sMzhlbENK?=
 =?utf-8?B?cnlKNjArNWdoS1krUlhNYUhOa2JwYzJwV0d0N1dDT3IySmpGNytpa0lxdmJH?=
 =?utf-8?B?czJwc2V4UHQ4NkVWRWltdWZTelh4Sjg4aVROcWFNRE1jZXRDcmt0VmRYdWZj?=
 =?utf-8?B?ZUJVd3ZDeTZPL3VIU3BRemZFUGdkSG9yV0daR0xiclZYM2YvblNHeWZ1cVl2?=
 =?utf-8?B?YW14M25zYTlOT2pPaUxiNmZNeWxUdDdoMkRSak14Z2VJdzlDQjFPa3pzY1BF?=
 =?utf-8?B?U1YxbUI3WlBycHQwaUp3T3U1UFZ1ZFh0aW9jY05rcUhLM1pqclBocTNnZWFX?=
 =?utf-8?B?RlYwZ1ZUSk1LR0tBbk1aOFVJR1J1SFFnUEVSYUhiemhydWwyRUQ2b0Nsd1dS?=
 =?utf-8?B?UnY0RWh4M3V3d3QraGdJOVQ1SWk0Y2NVRzlKbVFiM1UybDZwcG9MejlPVkpE?=
 =?utf-8?B?MHlNTHRrZXEzWFZjWnhvcGlDbU1DQjE4ZHJCeTlSaCsyQVh6RkMvZG9icWtU?=
 =?utf-8?Q?NM4XRKetTjR15bMdDu2gNKxQT7k4yc84b0ZKA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlnOHEvK2IrUXZkUklNd2F3bTI4eTJvTVl1MVdCZG1xcXRrNWd3WEJxTHJ4?=
 =?utf-8?B?Z2V5LzNGOHQ5d0lhSksydjR3d0s5blZUQnpMRm95bFBSTGFWcExJV2RzcWF1?=
 =?utf-8?B?UzVRUU1wTGh2OVBtV2h2YWgzVXJWMXFJUnBZampWRDFrdVlUbUU5aXdnVE1a?=
 =?utf-8?B?WldVSFNoSGdpV0h1WWd6R04zbDVKbld1OE9uVmpaMnp4TjJweE12L1Juc1pa?=
 =?utf-8?B?RWNYTnJGU2V2NFlDWFJZRTd0aHhnM0ZyQjFFcTliLzR6VCswYUp4US8vaW9M?=
 =?utf-8?B?YXFXQXg1T05WaGMrekNLZkJkSUFOUlFQRTZRYjRLUFFBd0pmc2ZBem9kcDJ5?=
 =?utf-8?B?U3BkeGZvbGdlTkZnR3h5SXFjKzA2V1RHNjU0S1ZUMUUva0RoUXpKd3BCcVNX?=
 =?utf-8?B?VE9kWWJRK0NmcDVKRkFuU3JNeDRTdXFEMFlJdXFXekwwZzJ6SzRGMlpDSjVw?=
 =?utf-8?B?QlRNOWc1UE9DZUVsNkdPZDdERUcvdVNHVS9vb3lpNEZaOWFPVzV1MFNhTm5K?=
 =?utf-8?B?cXhsemVkRlhJeHJNWG1lL2tiUERyY3VSd2o3RFYrT2txNE5ZUWFuNjZ5NUUw?=
 =?utf-8?B?TXBMWDV3dHNZTEJ4eWhQSG00MlV0YXBEcCtuVnFVcjF3RU5KM0hQWnFaOEFu?=
 =?utf-8?B?WDU5aWZ0dWVDTEFQUjJzRUJJbmlIVlE0WGRGNHFLSXp6dEFtOXF1NVVtenBj?=
 =?utf-8?B?NnVVK1VvQkhjeXZFRGlxUExzS3YrSFRxb2dXaEhIMTB4TFlpc1dTRFF1VG1n?=
 =?utf-8?B?V3NlYjlycjNUODRGOGk5a21qbUlUTWxqTjlHUUhhL25zTS9yUXRjUlEwTGVX?=
 =?utf-8?B?Zjl3UlBaTzYzM3htRzUzcWxaaHdqTUJZYkVxV2xaYkdXWVFRL2hyemE3ejRq?=
 =?utf-8?B?YUwyU29hTWlkYmpkYjNwYlNqZnBNWG5jdENCSkZnQ3hLQ1BCRHVIekZTUlNz?=
 =?utf-8?B?U1JxS29naFlmcEdKVlpYaWIzRzZKNURlL2V6YXQxbjRJSWhYRStWWW4xdW9u?=
 =?utf-8?B?YTRsZEpReHExeTBWNCtUaDRsakdwZzFXT0pOQjI1eXlLVXRINEx5aGRSVy8y?=
 =?utf-8?B?Y2RQcXhDZCtVVFNjRmdkQ2RRM3RialBpR3VxcEZGL2RKVUxMdWxzWmlkbHdW?=
 =?utf-8?B?b3pJZVlvQkY3RHBTSkxNK05hTEJIcUFJU0NsR0x1a0VvdjdmL3pOWWNJME84?=
 =?utf-8?B?amxVdGZPZm8zSGJEd2VkUSt6c3d6WDdEZ3JhZkpIUG9RWnBDaWJlR1M1eTFS?=
 =?utf-8?B?YTAzK3d3TDN0a0V3SlUvN2hEZUJmYkkrTWIzOU5KbjBhWHhOdEdWSzVDK1Jp?=
 =?utf-8?B?cnFpY0Juem9uUkZSejliL08wK1JYTDV6S2lKZ0p3bzhIdzdEV1QyMk1RTldN?=
 =?utf-8?B?Zkc0Z3Nlc2l3Umt2SERBa01HMVpPQkJvZHJXZU11OXp2ZVNoRmh2OGdsZ0pK?=
 =?utf-8?B?Q2lzU1R2QThQZmE3QVBTckYwSnJaOW1oN2VrMU93aGIwNi9xeUdDMUhtKzZK?=
 =?utf-8?B?K1lxN1NCRVhJNjVIMElNK2ZDMCswMzdYdnhwS2FGaS85eDZzU0s0ayt2OUIz?=
 =?utf-8?B?TVVSak9ZSlhqMy90QUFTNTk5Y3RYeWM1SkdKNjY3aFM4YXhkWUdxYnMyZWwr?=
 =?utf-8?B?MWh5RTljWHhIeXJ2V1ZrUlk1Mm5NNThKM3VTb3J1NGFrMlRwbFQyeGl6QWNJ?=
 =?utf-8?B?V0FpOEZQZFNKUjJVL0NZUWJJUDFsU1FHRG5BUHNFMHZWbWc3NFFha0NXWStZ?=
 =?utf-8?B?aVZ3OWtoVzd1UjZjdm01UkJ5ZFFWcGlDbXdwdHBEd2J3SW9oUWRxeWtlQng0?=
 =?utf-8?B?WVRkT25HSDdIcEFScGFpVmNTUEtSMjJhUVBkOVRVMnlEd2hwMW1XeWdmazlE?=
 =?utf-8?B?U1F4c1k1Skpmd1BGK2lsaTNkRGtUbW5laHlYc3RnM3BBVFlPR0lDcStBSUI5?=
 =?utf-8?B?amhFYWM1ekpUMUNEU3gvYk1rM1lnS0xpN3dPTWFieWUzc0JYV0JtZ3N5Ui9j?=
 =?utf-8?B?VjR0RkFMVktyNVBUZmY0VEhZQVJaSTc2R3FHZURubWhxUkJxNGxHMmlwcm1L?=
 =?utf-8?B?M1RGamJlUlQ5MDNCNEhWYTdRUGdpd3RQU3U3d0U1dVV3SWRVQWZFZzVMT1Vi?=
 =?utf-8?Q?91lgZ3k8UKVRreCUqZve9bZQq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893620fb-c626-4ee0-a0c3-08dc865921b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:35.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMD4rlS8TZl0Q/mCZ6PXVfJVKPThH1Tdx9CupFuh6qQzBGGm3lb3rEr+ZqnQrMkxAts3ORlisNZCk9piGF/qUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

The gpio in "reg_usdhc2_vmmc" should be 7 instead of 19.

Cc: stable@vger.kernel.org
Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index cdcd5993cc69f..dedcc1b1bf12f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -134,7 +134,7 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		regulator-name = "SD1_SPWR";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
-		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		gpio = <&lsio_gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 

-- 
2.34.1


