Return-Path: <stable+bounces-60630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F193819D
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3127B1F21710
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461E13C68A;
	Sat, 20 Jul 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="eUwq9d0v"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023077.outbound.protection.outlook.com [52.101.67.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07C12F581;
	Sat, 20 Jul 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485176; cv=fail; b=uw8zzyXZcfG0iVmzHKEXw796JRCY2+gL6EaOmCDyOOZ/TQ6EoFL8ixZfW+yJiFYXtt7dhvL3cZbqIO2RJpJx/jeDlmlKFZBV94bt5vtBCbNBADBZnKF+YVoO33xoClpZPEsvIm6r94EDVeE3ue/Se5RlzgcDDKIgFNWXKCqK78Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485176; c=relaxed/simple;
	bh=AiLecG0n2adRACZm1ofxnUyZIB7unKC2cDg3UoTpocA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z+C7HKAJFJJU/IZ0GsVdi3WiP/sF3bTxpptgdcE/bl0I2Y9tuwwBUTTEdgkbg76OMtkwQBQesL+C6RbMH9sFx0GHsO9Zp4uWxoG0b4bu1qJvlJiK6q1z5R6WV1zJd/692D5zE8bInAU2UK0qXGs4Pch5/8SHc1MYBfgRUl0AaEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=eUwq9d0v; arc=fail smtp.client-ip=52.101.67.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2c+5iLE/2kiYkik0OUX/c2SvsZ7IcxG/dxcjjcKhf1BcZHeRRqorrt5M9jicXCxtGCPgKW9Tq1H0ql9Rk7zXZBdneX3qXq1tupfzMcBozUQkt+Ucs+kJKnbCHkwGxNpdEcFuAmjG+KvMAs0y08Dgit2TKAijYH+HChkAHxCNa/dMtglNC8EK9n/FWLYVRrlukC+Y7wXRGImHjWbKTNOhFuJUsMgsZaj+iviZr0uxF+FdJcn5FyRkXKNBe/aUoeq9FcxM4jKMmMU/+OpnvWmTz2K8pQw+V6UgiUXxX+ws9rOaGHtVVOyb28T+RRfP2/djOeFK1d+nZw/YK9/xiYAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6a6IAQC9jgQBIwNAynro/8oUziJrqhx6Id91r5G4uA=;
 b=LtC8RIvBJ0opsEpIbhvqrNEfuFRbkxgwDPkZVMlrwedeqO1XjeV3W5it8SN2+pqYIcQlREkqsPHjMqBaDZb8gQ8Rzo5xUwkOHa7ygTQRC2RELolMt/GLDZ9RO2Xc9cl9ebuCsXM5naEqJmLvVXsU52gPtQNwvqvWT+u91leRTp/CRyj7FqQq/Vx8X1cOUKh1dzZgIkgNyxL+NEWSG+eApY7PC0O4Q5omTQFTI0kriolOSOLX8C56QC6S+p/SULFD8G+oWJL2cPkAegXrmOY3LnqLwATTzTmKWpGaqXYosGwePJ29ARFFHx4vRa+UvlZ595scoDqH5iaRRrPWYZteBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6a6IAQC9jgQBIwNAynro/8oUziJrqhx6Id91r5G4uA=;
 b=eUwq9d0vGEEJRPm1cYLGEJXOgAvcjKSJRYdRgrgHqMW/YvaitWv2rskCBFVMnBGS9YirS8zaWE2ycIXduJU11wr7U9boBL++bwH3tciJ0lYdUeLk0y2dJSFYQBXccsdHjLQdkEklonYMjWezyZKW5DFiMeYJSsRyTnxB39QEYzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10299.eurprd04.prod.outlook.com (2603:10a6:800:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 14:19:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 14:19:28 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Jul 2024 16:19:18 +0200
Subject: [PATCH RFC v3 1/6] arm: dts: marvell: armada-388-clearfog: enable
 third usb on m.2/mpcie
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-a38x-utmi-phy-v3-1-4c16f9abdbdc@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
In-Reply-To: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: 599849a0-3229-458e-57a4-08dca8c6f6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXlPb0VmWDJpbUVpRDk5TEZqQUR1czl3bU9PNWxMZDBIbWU4eFladVFrVzNY?=
 =?utf-8?B?dUJCTnlKTGF5Sm5lOWFKVS90b1FHeTdJL2pUSDY1WFV3b0pNV0FBZkY1NGE5?=
 =?utf-8?B?TFJsUUVHSnpyR2IveTRWMW9lc1JIMDQ2b2hyQ1M4dzZQN2xaSUhVeVR6aU4v?=
 =?utf-8?B?WVJYbnVCdXptMWVNSVp1WXFUbVRoYjJtSFhEcWRuSWNEVFZFWFNPMU15L2oz?=
 =?utf-8?B?K1VVY09aK2V3NzhZMmhZbnB1Ym1NRlJ5dm1tOTlIRDduMDBsd2g3eXNURzVJ?=
 =?utf-8?B?dHFsSkl0WEkvd09DdWVKL2szenhuS3ZLdmdnbG0wTExHclBvOEZLS2RBYVVW?=
 =?utf-8?B?VEhHQ09yWDdlVE5aSlVoZTlEVFRWOWlzQkdEUEw4RXlGMDROelhSTW1HVW5B?=
 =?utf-8?B?SUJlZ3Y0Tlh3RnBORjN6TTZNci8yUUY4UFh6VjF1QVJKTDE4ejd3bXBBMWRl?=
 =?utf-8?B?eUZLL2tRdHp0OGJkNGxkOS9jMm1MT0wwRkc1dGF0MEZnYnlVT1F5OEZWNEQr?=
 =?utf-8?B?NXM5b05QMFIxVzc5WjluM0czMUpJenhvRUU0Y09yMDl1aFg0WXllb0lJaG0y?=
 =?utf-8?B?U2cwUGdwRHl3YlJ1QUFSTHF5OTYwcC9rU3Q2dVEvZVBrTEh4Nk5XVHNmNzhL?=
 =?utf-8?B?TmV1MDBsaGN6dlFTS3FvbGlLRVg1bUt0VVY5ZHJGQ1YvQzExUW5qSmt5d0Y0?=
 =?utf-8?B?TW55cFlKaGxaSFdTeG9EamxrYVUvZ0RLb2svL284dW1POTAxZGZLd0FxVGYw?=
 =?utf-8?B?bWZ4b3hZakVnUmhDOWYzTGxXTWQ1MHNRandOWHFnTzY2K0V2TlkvajZXNk92?=
 =?utf-8?B?TFhEMmhoWDNpRytZQXlNeTg3V2p3WkRkMktaY3RiOGFzQW1MaEVoN2kyR3M3?=
 =?utf-8?B?c05BV3VLemRWazJYWU9lOG95OXNFM1pOOTdjVzFBYjVSM0ZHOVEvcUIwTU45?=
 =?utf-8?B?QnBLTVpEQ0RBQmUxeVA5MHJIRXNDV3puMkdKNkZBbmc1U2R3SDBhL25SS2R1?=
 =?utf-8?B?d0pjNDRoSTB0OEhUdGQ3OU0zTitURU55OHBqTFNSNHlkR0NsSUNVYkJuSUQ3?=
 =?utf-8?B?L2JYWmQwUGhBdzRIY2I3bUtkL0ZTaG8rWDRGWTZuMmYxN3BLcmlHeHB0UVhp?=
 =?utf-8?B?OWpYTGtPSW93RWNQSU1scnlsZEhFclBCenZ0SS8vdmlsbDYxOHRNRHFQQ1Vm?=
 =?utf-8?B?bEpmMnlwSWlOVFhBMHZRYVRKcVdnaTJhdG01b2JYdDFqSDUyS0g2QzRnKzFP?=
 =?utf-8?B?clZNdlBFTFoxcmJZSXFnVzF6c3hlUk5aZ0NHYjB2R0xzYkJpZlBvWTc1bmIz?=
 =?utf-8?B?Z29NNVl0YWNKU0w1YSsxV1hMTmRBeXpERmZESWduZ3cwbllsTVo3SFliUmE0?=
 =?utf-8?B?TmtkODNaV2tJVjUrQTlsV3ExV095VXhJWkZGTWFpNWRITzR3aXNXRnpDNTlm?=
 =?utf-8?B?UUN4bVMrSHNweWxocnRYVXZMSmlmTWJxNWZraDdOVnpMaGhQMGtFbGlBa2Na?=
 =?utf-8?B?WXpuZmUvYW5ORHVJOGdZUlUySUJzbzZla2tlb2twSW1kK1VOTHptdExXRk9O?=
 =?utf-8?B?VENoVU41eHNTWnN0SG5DaWQ5NTErT2x3UGVCQ1FneHlSNi9SamYwdXRjc0M0?=
 =?utf-8?B?ajR6K1V6UDlBWW1yL3BmUGlteXlqaGxqVXRvWW02Y0xVMW5NUVJjTlJzVVhw?=
 =?utf-8?B?TVpQVVFaZ1hHbEJQM1hzYlhFRVhWNm02eGRrMGg3V1VGdEl0WGdJMDNEYnFE?=
 =?utf-8?B?NEVxVWdMOE5LK2Y5aFdHTFZCK2ozUnU5SU1aMmtuSVRGckNqV2hZQ3JZVUNZ?=
 =?utf-8?B?b2FhRU9ZdXZOTm9iRUxhcXhtbEM3ekZzcUhPTmdNLzlJbDVqa1RjNTk0SzZu?=
 =?utf-8?B?bDhVRHgrT2JDTGtWT2p4UVlVa3MwaCtBTmM5ZTZiRDkxaVhPT25rYmRDMkQx?=
 =?utf-8?Q?sIE0W3deosc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z29Vcko4MEc5cmxCOFRVOEQwQ3RVZXBBWWtzQjRBNC9MRWpWWGI3TDkzRjlR?=
 =?utf-8?B?NW5BKzZ6WGtHYVNxbml6UXQvekVKT0l5RG1SMzlCWE51ek41bTE5UlUvNjEw?=
 =?utf-8?B?cUdiOU9NNG1PeEdmRi92cW03Ly80WWJnN2gyekt5NUFGaWJGYm1kdWh2U1Np?=
 =?utf-8?B?dXFXZkJaYmxLZjl2dnMvMVlhZ3NHVGtyVGlRZjFYVkRWd0tGYXJ4SjROYjZ2?=
 =?utf-8?B?aDhwUFpGYXB5S3NITy8zd0l4UGNLZFkrSkw0K1UyMTRCRHp2eGg4Ull5SzFu?=
 =?utf-8?B?ZDBmNnMvN0dpbG5DVGhtRDVidUJXSi9OTDdGeVZvZnZ6TDdyMzFNNXU5YXRk?=
 =?utf-8?B?ZkJpNmFBRkJqVXYwZjJ6SEdPeTlRRnpJbE1ESHJiWlFGYzgzdzBBTG40eTMy?=
 =?utf-8?B?YnpWaEJKQXhOU2xZQ2lpZEZXQVNKQ3lRSTJuU0Z4a01VQ1AwRStrSG16K3Qr?=
 =?utf-8?B?MzEraWtSS0htaTMvUFZFVUVPRnJkQ1N6eGpubkRRdy9WWU5HSU02c3BlT2dw?=
 =?utf-8?B?OXFSMmdOY2FqeU1JRlhaRjRiRjIyanJtWldxZDl6eGZVckM5OXcrMTNjdGRt?=
 =?utf-8?B?S2FrVExvLytkNTFrRk5Kb1BIUmsyMklPSWc1dmRTV2ovemdtaVRuOFBHVVY5?=
 =?utf-8?B?ajd3dVlMcm9KYUcvQml2RXZscGZwZXgvTFR5T21LY014cllza29vbjFPNHpE?=
 =?utf-8?B?UVhtT0UvQnFDYjhjWllsNVQ3VHlvOE13bUp4bU1OYWNFYmN2azEyeGxrOEtl?=
 =?utf-8?B?WEVaVnlNNUJkby9RSnptUG5WK0JteWFjY2xPOUxlcks3TW9qYy9TcmNpQ1BJ?=
 =?utf-8?B?Y2RZblJMeTF0dVdvN21CRFRGblV1S1ZLMGFYeGVtblAzSERKMEh6Qk4zN2Yv?=
 =?utf-8?B?ZTNZMWU1RHVjRFR0L2lDT0NDdVJwNzJ4Z0FBd1pkYiswMExrRlBCK2RqcnhU?=
 =?utf-8?B?dDl0dHBKc0JLcDVTVEptV0UxTnN5N3M5VVJLYUxWS2NDSEk4T2NoYkJZSlA2?=
 =?utf-8?B?OEJrWityUGpYeFNZSnFYdjNQaUtoN2VWUWduNUxseEovOURqb1lkRGVpaVpC?=
 =?utf-8?B?YXIvUGlkbUVGR0I2L1pQMmFtMHFETWE5QXpKd2pkaE1QeXlmTktPYjBjb1o5?=
 =?utf-8?B?L3lPUkVJYTFIN2l5eTB6aitmZ093ZHJsUG1YaWlMT05jV2dvOWhvTGhTWFVp?=
 =?utf-8?B?YzA4UFhFQzJtZWQwbnVxUkhCMFVtbTNzZnJTZmpMMm9PWFRqOWlDa0lwT2Q4?=
 =?utf-8?B?UGQxUFMya3ZYVUcrbEJZdWZ6cFRPSmdXQ3BUWE1NZlR0NW1DR1VJQjhMOEhy?=
 =?utf-8?B?OHp5ZXA4QklERGRjRlNOalRkTURmTzRMajNaTkVrdFlvWVN5cTJMLzZXSDI4?=
 =?utf-8?B?WWJLY3lwc1FXL1NsbnVqN2ZBbGQ1K2Y0eTNTL2U5Z0paN3hmYTAwbnN6R0tT?=
 =?utf-8?B?V0MxSUVNWERBcENZd2pUR0xqNklMaEhONEQzbnk4L0lMY1lsNEJ3akw3Zklp?=
 =?utf-8?B?ODRKd2FLUVhvWjdhOHVWVjNTOTN2cHdnVGFNcmZyS1FQUGVDa3FDM2NJYW5I?=
 =?utf-8?B?TEwyNjJYaXRrNzJCZHVRM3lEQjM5cUVlejJiSXlSY1hPZlNGY0ZyQk5iWHFU?=
 =?utf-8?B?WTdpMldOeWQ1UlpBZkRROXFLUjlUSmRaNjVIMk45aEVJZWpuaGV1Y1ZhK0d1?=
 =?utf-8?B?UXB2c0NHWWtzS3ZNQTVsdmI2YW9FOGs1VWtKWGx0Y1F3RlNoTjRmTkpuVTMy?=
 =?utf-8?B?QWg1V24xV2E3Rm8wYTB0bzhKakV2OFlKNHp5T2xYQThpcCtucjFNN3Exd2o4?=
 =?utf-8?B?OC9iQnd5aitYMXRkNE5PN2VCVXQzK1pLZHl2SUo2VUlOM2ZCNmcyMXkvUE1p?=
 =?utf-8?B?cENUSE5nSDBmQm9QemhvOWZYdkwwQmhQdUNrVzBaVnh1cVg3R0E5SSt0bnZK?=
 =?utf-8?B?OFRtc004MTdCMUxXVDk3VzVyWGZ5bzVtby9Udzd3cHRXYXI3b2wvcU1pYUpx?=
 =?utf-8?B?RnZ6T2Z2Z3BCZzhGcm5pTnpEWCtBSlU5THJrUWVqS0VVdjF1OEhiOXpvUDhT?=
 =?utf-8?B?c3d3UHliUnd3SEFwdGNjS0pNaU5oaHpEZkYrdElXdVpXNXovWkhnT2Q3c1or?=
 =?utf-8?Q?AN6ZfY2A/qtBdfwNkuwgCRaZC?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599849a0-3229-458e-57a4-08dca8c6f6d6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 14:19:27.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veW1QwUIuXFJF4lyuq6WbkqpaDZx/NvXLx+Ixal3M32Wi2tqpDjFzQ2HwmFr/Veo1QCYlm9mk0mQ5rGVL5g/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10299

Armada 388 Clearfog Pro has a USB-2.0 capable minipcie connector "CON2".
Clearfog Base has an M.2 connector combining USB-2.0 and USB-3.0 plus
various pins controlled by the host:

- FULL_CARD_POWER_OFF#: When low, M.2 LTE modules are switched off.
  Many modules include pull-down, thus it must be driven high actively.
- RESET#: Puts modules into reset when low. Modules are expected to
  include pull-up.
- GNSS_DISABLE#
- W_DISABLE#

Enable the usb controller node for the first combined usb-2.0/3.0
controller, for both clearfog base and pro.

To Clearfog base add gpio hogs for power-off and reset to ensure
modules are operational by default.

Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../boot/dts/marvell/armada-388-clearfog-base.dts   | 21 +++++++++++++++++++++
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts   |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
index f7daa3bc707e..03153186c7bb 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
@@ -33,6 +33,22 @@ &eth1 {
 	phy = <&phy1>;
 };
 
+&expander0 {
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
+
 &gpio0 {
 	phy1_reset {
 		gpio-hog;
@@ -66,3 +82,8 @@ rear_button_pins: rear-button-pins {
 		marvell,function = "gpio";
 	};
 };
+
+/* SRDS #4 - USB-2.0/3.0 Host, M.2 */
+&usb3_0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 09bf2e6d4ed0..d6d7cc885f4d 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -182,3 +182,8 @@ &spi1 {
 	 */
 	pinctrl-0 = <&spi1_pins &clearfog_spi1_cs_pins &mikro_spi_pins>;
 };
+
+/* USB-2.0 Host, CON2 - nearest CPU */
+&usb3_0 {
+	status = "okay";
+};

-- 
2.43.0


