Return-Path: <stable+bounces-50116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B085902A12
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 22:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BA7B209FE
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB44D8BE;
	Mon, 10 Jun 2024 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F++nRYsb"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA271C20;
	Mon, 10 Jun 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052400; cv=fail; b=MqsA56LUY68ZoNTjF7hztPR5K3jSgv6xaz6CetPQzADOnOZwC+zBnmVa7mVLLSL2p9bviAQSOWemg1fdz5eDJZQkjMTCk6JJ2uSgOzno0Xn2XcYc5hLEjYp4N1t5a/J1NMwkk8ICwW1MYYqeaH1E/IWBE8q/UhyT4N9v5y1ZsOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052400; c=relaxed/simple;
	bh=+xfOy59njoxBv9g1k3teB3aqGtcXLiGDFGi7zR1Zie4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MjpbrQwTU4+jTKMOjeLa9XFQXaW6Yu7S+7R0LpNv8VeIhqd7+26YfrC+AkNzgrK3WhT/SC6IcTEO5kgEy9VGCVVwybL0phgcf/QK9kvqyHIswsmdXd3OqG27gMChL6RNg/meVpuESiqO7CfUX+oxkH7X5Y0VpjiWeK77qSE+dvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F++nRYsb; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ4qtvogsd+Nc/UjjK9/B/bhqYOVUUhaUBkvfRv9P+8tuCwQ4pbP3mJM5qaB9h6GcCMHp4IRYRcqElc51zuHu9B/TqsATIabY9SJm8/6RLTCAKxlW5yNFw5q6UsxFWy7vSD1OIySDa/aX7v0ivdfK2con5uuV8GCT6ky1Lz87SrjRGIrNfd/mHslHLqluyykp647GalEwkH0dIFuPdThWIUGUMh6mtWExrYJDeGBQ5MXqLFh+dCfhPatZ7MWOLBnsU5+F6HphE14+5xdf8pphu23f4WmST7UIBtkjTjBqQ1ODiCZr1ZJ1LMb6souQyYKbrbgJ/XKw3qUpGGSCJDH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEaaQR30MBc3/lbjvS7bmmqD9lXjH+WlE3Jfd6ItUdg=;
 b=KLCVAiPmijkNnKjU7kqj9x2V1m9FXxvdJNm4gQ9sYO6Gc++CyLhrBpq2m1ARuNVaVbvc67L6gpBxl4RXxucMVlWsNatNBp3BpvP5r+6y8fgpx81vjIdJjkgpef4FdbkayTwdIPbYNSVO+29jXx05xQr/WXp2qp5mfipOLdG1jKcX8vmQlnSr2E+aIczDXkIAqTBMJxmR0SX4q9dZQgQQIcrz66OYHTH49ucQMQhdQbXlRbnb8mBfYq1mjiV4RpGoYDm0SpgMnx7d6g05ecLGf0Svi9HvUyfZbBn2mUe+qy+LVKMXvWjsOWa4TrH4VvJXxGYYSUfq53WLAZI1b3sR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEaaQR30MBc3/lbjvS7bmmqD9lXjH+WlE3Jfd6ItUdg=;
 b=F++nRYsb63NzVivMtvskxmLefbYzj/ngPLihX6T5o0f8A09KCjdGR4tOEHB9MN9gPgAg7+AY+Ug+fESoQHAu2979FCDEIPFZKnnY3EAX2wMNlKQtayMiXzB//q5pK+hC/imxaUN3/xfsnWxL8Db5p+gajSG1J12v+OMJu5PZMoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:46:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:46:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/9] arm64: dts: imx8qm: add subsystem lvds and mipi
Date: Mon, 10 Jun 2024 16:46:17 -0400
Message-Id: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlmZ2YC/3XMyw7CIBCF4VdpZu0YmBS8rHwP04VQsLNoqVBJT
 cO7i927/E9yvg2Si+wSXJsNosucOEw16NCAHR7T0yH3tYEEtUILjTyu59eI/ZLwnQxerFI9Ge8
 UaainOTrP6w7eu9oDpyXEz+5n+Vv/UlmiQKXViaTRrSd1m9b5aMMIXSnlC04Q6TmqAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=3670;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+xfOy59njoxBv9g1k3teB3aqGtcXLiGDFGi7zR1Zie4=;
 b=bI+ol7+At/2dsh8cS28OtodfDJ99+9EfvgTitsGNe3THnx1ylYpwyBWcVHX8qAdVrfg9UnVH0
 zjHPXcPswLbA3NGoyuX7hyBX6iwHe3aeE7Gw/9Tg3thUrJ2MsXyW+AY
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc94f5b-f2f5-4f86-302b-08dc898e6b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVBLUG16TmRnbXFSTGVPK0RHMm5objRhRmJvOUpZZUdVd00xR0Z5M3BNQ3py?=
 =?utf-8?B?QXM0OHE0UUYrRDdZUXlOc0FpY0VxbXFCK0FvOWcxNTAxT1lWNzduM09qWVRa?=
 =?utf-8?B?TE5SN2FTYjB2L0NOYlRhckZoRXFTR0RkaHFGS01uSGlxZFhtWXdyOWhncXlj?=
 =?utf-8?B?QkxCdkY4RHl0SDVrSVdWRTVCQWRhb3dBWWNrbmNUQ0VxTTc5N0RsL3ZVU290?=
 =?utf-8?B?UTdQVG9aNEdUUFdZN29ERWlWYjJKZ1Z2ZFo4UW5uWEF0Z3FuRndXMlVmVis2?=
 =?utf-8?B?S3NsV1JkYXBPbThRMXlIVTBYZ2VlVjBkM1kya0QvcGRxZlUvek5CbFFjNXM4?=
 =?utf-8?B?MWhjM2JNVkpVZmVEcjJKbU1xY0xFNm9SMWludm5ZMUJsN0M4eTFOdVhYY01J?=
 =?utf-8?B?UDUzNjYwclM0bmE2YjZrc0NBSFFFTlp2aFAra3BxdmxWTm5yTEtIMWoxOTQr?=
 =?utf-8?B?c0Rxb1V4QVlLT0x1WWc5WGM2TW5LRjJnWStmWnEvWTI1ZllJU0RKdmk3Y1Q3?=
 =?utf-8?B?YURqYXE3R0RyM215K1RJSUcvc3cyRTlpbnU2TVN2Unp4VlYwUC9taXZOemhl?=
 =?utf-8?B?Nyt0OWsxYWU5ejhvcUNmREttVDdvU0FvOXlIZ2NWSjdKTmovMStCdnN2Uldh?=
 =?utf-8?B?bDhic2JqTVR4Qm05THgvTUtjN3VDNVFCYm00TzZSMlZ4OFp6Tmp3UnIzeXF2?=
 =?utf-8?B?TU40QnRHOUZ4NU1sdXp4dkZveExPVENGc3BwSXNGTE9SSGYxT213TWRpMkU3?=
 =?utf-8?B?L3FvRUN2N3NMeTNjaTJMQ2dBZ0RBbUxNNGp1WFVMUEFxdCsxYzBiN3hrcEl2?=
 =?utf-8?B?ZWhQaVlFaGVpVC90MXRSUTF2Y2xzT3RaM3VLUGg4VzFoMDVGVjBUa2pWS2t1?=
 =?utf-8?B?enVPYjNNL01Sd1M1QWx2N1NwU05XUCtNSDhCRUdaZVJBRngxaW85eHlYZGt4?=
 =?utf-8?B?MHh3R2pUdFFLcnU4aS9XdGVKM3lCaHdOOVBoT0pqU24rcW9lN0NUZFYwVm01?=
 =?utf-8?B?L2NCM2xBbzluRmZDenhGbURha1EzNFYwQzBhd1BZTkZsc0hmaFZMb1lVazh2?=
 =?utf-8?B?MlBEQjBCT2gyL0JoT3hqd3B0enk1NkxUQnpmMjlKZ2NwZkxISFNybXpOemNv?=
 =?utf-8?B?aGhPMmJLMjRvcUptN0MzV1NVOGVSK3h3MFhTVGozU25vN0xpWExmMmhFcFZL?=
 =?utf-8?B?bkdDb0EzNzRiVTVsdXpQekRkVnFLVmJNSnQ2K1Z6KzhLTXZET1IzbHpBeEdy?=
 =?utf-8?B?NVhYQU1mU3BydzhQWklEUTZ1VFI5Vm5QMTJQNGNmd1NXYlNGcmZTaWJNZWh4?=
 =?utf-8?B?RnVNbWRrc0xVbjdXU0dqdFZTL1RYRUlmVUQrTkh5Ukk1Q2Y1VnR2ejZ0d0gw?=
 =?utf-8?B?RERlcUh0RXVpM3BSdEhLaWpRNDJoTDEveTU3cFc0blJXbk9yRjQ0Q1RhL2Qr?=
 =?utf-8?B?cE15WXREcGNrUG95YndBV0lORXczKzhycDNaK1Z4eGFJU3dKUG1jTUZUbEF4?=
 =?utf-8?B?ait2QXBlMURna2pvZGk2Q3RBTEZzUkxnL1FvbFdwUFpQd1BKM3VVeWNBVlF4?=
 =?utf-8?B?K3RKYUQraTVCV21JbjlBOGJpRDlsTm9LTnpzRW9CU2o0bTN5OFdpZnp4NlNQ?=
 =?utf-8?B?ZHA1SkthdjJoNnJtWVIvaTNsczc0cUlPcU1Nd051ZWxjWFZkeXNJZ3NhdXc2?=
 =?utf-8?B?TW9icktMYkpGT05rd0dOdlFuU1h0Q2J3V050cGpkNE93OTlPVDhpSTkxUXZW?=
 =?utf-8?Q?6q4wsE2u60BNSCEIv+LcqDMR/t3B0ZOpXUNzKVE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3JWSTVUY1JOY3B3dlR2TU84WHhBZlpUVDl6dGF0STExY3RxSVJBTW5xdFlI?=
 =?utf-8?B?Q2tuT2xGNmk5ZWlMdHcxdnN4WDc5QUtYaGl4aWFWK1dVRjROYmlRSjJUR2dL?=
 =?utf-8?B?ZWcrdG1COGxHM2JwVjJrL2NBUnBXTmFuTUFML0VJVjJVanVKckRBUE85Y0h4?=
 =?utf-8?B?Vm8vV080K1duUFdyYUFPK1FsRW14elc4RHM5ZDQyTFY4Q0ozTmtNNWdoVkpU?=
 =?utf-8?B?YnB4NHUxcWhFMUoyRDE4Tmx5eFE4aEhUcEtmOFpGOUwxaHNqNU1LWk84SXla?=
 =?utf-8?B?cFh1anBmZ0l2d2JjbG54V29JRlNRRlJQc05DZzBnRXQ1bE1XY3UrejFkUFdM?=
 =?utf-8?B?QS9NbDhWcE1iM1l5WENRZHB2V084d3hGZ1ZWZ2JMbTZkRFFQSzQ4MU1TMWpp?=
 =?utf-8?B?RVNEV205OGpTa0loMlpZdUtEdW9YZUJkY3pid000V2tOR0lKK1BnanJNTytw?=
 =?utf-8?B?SFhoS2UyKzlYZkw4di91WUZUd2JlTmFFclI1Tkc1cFZpSnhLY1BEd1NQSDZj?=
 =?utf-8?B?MEVQY1FPcGZVbGw1UUkrUm9NbnFiUUF2NUtUR200emI4MGhqQjlhb251a0tx?=
 =?utf-8?B?U2tpUDZaSDljKy9nWE13cXNiYVZ6YTRzcGFXZFJxUUI3RVRkRHV5V1BQc0Rt?=
 =?utf-8?B?NmxOSE5SR2U2M1lWdVl4U20vN2RVS21vR293bUcydTJhbHRuUnlHQkhHU1dH?=
 =?utf-8?B?aHpOd3h6NUtlY1VCYXd5M2N1WHpidGpJYTdZa2E1MGZVZ3RwM3dSUXh4Zmls?=
 =?utf-8?B?SlVTODcvTVFIWlNjeUQ0cXZrSE9ZRWVsWjZ5RWpTYXRFM0RSK1RkdHl2d0JV?=
 =?utf-8?B?TkV0U09WT3ZMU2QzTlZLdGlxaksyNGIwMUMrem40bVh5d2hCdm9RQWdVRmZy?=
 =?utf-8?B?V2pDSFdBWDNOekFIc2dTaHVFYi90RmRLNUx2VzdYTGlCN1VsOE1TalFWalda?=
 =?utf-8?B?ZUdFVnc3UkZlalZ3SzByaElvM3FxNWVITGRsbHhUbkVUMGw4Vkk4NUV6dkxw?=
 =?utf-8?B?YWxMdi90RHlSZjI3Wk81dmUxSjNlbUsxdEEvcktWdHRLVUYxclJ3dUhtcGNq?=
 =?utf-8?B?aFJCL2hlY3E1VFZRYVVodzBNcHp2VUFnTzBYcWJsTkdqd1hoRW1nVnVpMnpu?=
 =?utf-8?B?QkxudEw0ZlV1OEh0NkZDQWE4azhIT0NidVdSc3NHU0lPcHFUTTJXTERqQjRm?=
 =?utf-8?B?b2kyakNDSFY3MEhCTE9SOFkwanpKcUhqVG55TjBaT2JXeXhSelNBSC93T0t6?=
 =?utf-8?B?NW5aM3J2SUVVbUZzamdwcEVnWHZOaFl4b0tQTHgvVVNBaFBLZFk4NlNWbjkv?=
 =?utf-8?B?NFVyVW9yMWNiSk5nUDVkS3VTTzJQaGY0WGlud3ExREdHMmljZ0I5OFRHRXVP?=
 =?utf-8?B?bDhRQ1ZXNWVJUjM0dVowMW9lMGttVWdMcnp4TkZRMFFYaDBXWkNUQzNFTUFJ?=
 =?utf-8?B?eDJ4MGFUQVJ0a2tFRVNpa29wY0s4T0ZPeC9hOGxTTlhVdEJUVytoMUdOUXFl?=
 =?utf-8?B?eGpjNjFwT2dpSzNyWlJqUkloNE90R0hiUTFabGUvakYyWjFnOVlRSEh0TzU1?=
 =?utf-8?B?VXl6SGo5STFsZzROd2dTWFVxcm9xMzBCaTA5SXViTjZpUGZ0ZWNadGoyK3Fn?=
 =?utf-8?B?U2VuTmRxYnJzMFdKbW8ySDJWWGZtRlFqbG11aHRPcThBS1p0cFRZK29NR3h0?=
 =?utf-8?B?UmtVem8zZHdOOGNlUS84cktvWDhUbGJrSHNEd2l4SExTb0FRRGNTbzMvNUx1?=
 =?utf-8?B?UkFoMWpaeFo0YjFpU25RYnRmZHpNY0d3QzEvNG5ldWFrbFlENkpHYjJPZnBS?=
 =?utf-8?B?R2xVTGRyeEV5dEZwVTV2TWFEc1lHWnI5TzVyNGZJQVpVWUxRSUs3b3Z1WDM5?=
 =?utf-8?B?QStUbExZQkJlUG9iVlg1QmlGYTFRZG9qT0wxOWhTMUFZV2VYdlpsQ0JYaU16?=
 =?utf-8?B?cjREVGhXdWprdHh5a1JNYXlVVWFBWCszUHRSK1UzT1ZYQmxRR3UzeS9wTGpZ?=
 =?utf-8?B?VXlkQXhHcDFJWUFZZDU5WWZyVHVuV1E3enpEYlVBamxrZDQ0TkZ2SWZDZGR4?=
 =?utf-8?B?RTZIaFlQWWlHcGhZM25zN25QWmg4QXNqM2FvVHpWSmtsTDd4YUxDQVFSaDBq?=
 =?utf-8?Q?eAyw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc94f5b-f2f5-4f86-302b-08dc898e6b05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:46:35.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDF1FmOypa8TZfiOPpQE7RDCyW4EvS3QZMljIERJTafJbGiSOcM1hNyIP4qfcZtYaJfR8R8/wRshn5Pd5T2u7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463

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
Changes in v2:
    Changes in v2:
    - split common lvds and mipi part to seperate dtsi file.
    - num-interpolated-steps = <100>
    - irq-steer add "fsl,imx8qm-irqsteer"
    - using mux-controller
    - move address-cells common dtsi
- Link to v1: https://lore.kernel.org/r/20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com

---
Frank Li (9):
      arm64: dts: imx8: add basic lvds and lvds2 subsystem
      arm64: dts: imx8qm: add lvds subsystem
      arm64: dts: imx8: add basic mipi subsystem
      arm64: dts: imx8qm: add mipi subsystem
      arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory region
      arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
      arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
      arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes

 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi  |  63 +++++
 arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi  | 114 +++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi  | 138 +++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi  | 138 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 280 +++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi |  77 ++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         |  27 +++
 7 files changed, 836 insertions(+), 1 deletion(-)
---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-imx8qm-dts-usb-9c55d2bfe526

Best regards,
---
Frank Li <Frank.Li@nxp.com>


