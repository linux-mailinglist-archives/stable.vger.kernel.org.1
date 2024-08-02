Return-Path: <stable+bounces-65274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689A4945652
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 04:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223C3286471
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6B1C2A3;
	Fri,  2 Aug 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lDA++QHF"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910C1A702;
	Fri,  2 Aug 2024 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565851; cv=fail; b=PBDgVdc/ViX3ibSErym7PNAWkSVitqX303v9LZS/wQ+AqMTNyt4q+070ZkIACLlTcCMeV9DQ3WoHMK5esiJNpZq6ux4XfwZrttM1SqbMo6k8osvjKns+g8EEKDrzZEMXdcMS/yRnUVF958r1T/HS0AdHb5EqaBMXeP+3BqBiUqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565851; c=relaxed/simple;
	bh=2XyQAwB5y/2fQzo4zHIYVJuW52VSmuaGXA/YSiQVDAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPNSMCL+ojs6I4VoZl7/UNyXFLcyU5My3bjZgL5Nogvi9T2oyJFC0w3+ydf7/a2dbg8Ysyvw4+q4beegaEsaGwjnn0iy8tiZDkNVh3kdPnmdvmI6V1I4hge4oLzIR11extWExnIGOiseROlv1pq/KUMR9HV+5VAKxqUPOndY6dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lDA++QHF; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXdWHb7py+wTwqG6gMU7p5JsIWoGM+JM3LDl8ZD36gxVmbkohdSEGWt9AMJ7Z8G3OI1Kum2XOESqToSwLWpsbHQmXptuxTVSJjWTtj/yQVyHq6W6wR6voqrYpx6PLfOpbZJCAI0Z8Z31kp85dgGHJdOBvl0SoL60b/Ldb2NwxE9sAk5I/cUtcurzAi3BuyuTVwl6Iu2uK+P5up7u+ipbZLcWiwgGOMrKYWnEmudK40QaEbPGAXSAApXZTFOv5EapW4uEXIMWIDzzI5N1YVXuzbZwRH1IB1BjxDxoTm6e1XuvJL3CbmudO77iRGuqlJ9yw4bNVL9b0yi1U7Yd4uSp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XyQAwB5y/2fQzo4zHIYVJuW52VSmuaGXA/YSiQVDAc=;
 b=jtESwnywL0RcqzH9ImAauyk4HRpJR2dizq1Dv1VrJ79kSJmgB3tbT2MJJJlCjvszfkOSelDgAtXCcA2osJ763FHZuMpdCEQN/rcUv78XbwJpZpPNMYXP9rI4eUcBthN2nZDMO3TXIU6ALEZE6lxf2h7pxB7hQ3xDb9N1bEu5xytxIeFS8paCxZl8+nSt+Fwx2tfQ013iw5BXeTZm8UF8TMCRKFfDI93sLjQSaZ6yKgypeQrZY19TV4S0yXxHU2o1gQKJhDTypH7Hi7+qXoeDQAIO1pzGX53P8xusmuT/g6DnSN6uOELkhoVygELN6zn5CyLRWA/J8TNNbBT21uEHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XyQAwB5y/2fQzo4zHIYVJuW52VSmuaGXA/YSiQVDAc=;
 b=lDA++QHFmHL/UgLZDvQy3HBRcZ2de8CXe05xwtEAeCSDv+HsynnDivVVk1hLxzhxzKbbiHeNkLSZXB1lC19tW8ygwdPw23J5wipXJXL2VIElsV0Q1hQYcLFnuc3tHqqLWNMyVUjWUXPDD1dtQ3eH40wpfJzvkJdZFBJpjdTtbRidzMyfTb0YVBYHcys7lvcoC4JajnCIVSS0d0+iaMUjXbPxmQlj2Cl7elrwtvv7BFtKOourYdrRVzvtHCZk5WWxeCG4Q4tNCNzmDky5JluKmy1HL5SR/JPEpIqIx9hqQV+1J3BCoxP1tD41SuypIsCB1R0iFjApcqB0BTlWZBGTVA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8964.eurprd04.prod.outlook.com (2603:10a6:20b:42f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 2 Aug
 2024 02:30:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 02:30:46 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "tj@kernel.org" <tj@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Thread-Topic: [PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM
 AHCI SATA
Thread-Index: AQHa2aEYMAHnp4ur4EKNGMJk8l3hQbIEgLWAgA7NqZA=
Date: Fri, 2 Aug 2024 02:30:45 +0000
Message-ID:
 <AS8PR04MB867612E75A6C08983F7031528CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
 <1721367736-30156-5-git-send-email-hongxing.zhu@nxp.com>
 <Zp/Uh/mavwo+755Q@x1-carbon.lan>
In-Reply-To: <Zp/Uh/mavwo+755Q@x1-carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8964:EE_
x-ms-office365-filtering-correlation-id: 55084088-eba5-4e4c-1db2-08dcb29b1d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?bEk0b0VXSy96SGxWWVZmUWp4WnY3cHpyUjFxVURqVkdRRlFhejNMNXlnc1N3?=
 =?gb2312?B?VjRwYjFUcTJqQVBqbVBndlREMXc3OGZrdjdMTVdOdDBjQzRWL1RiWURhcG5T?=
 =?gb2312?B?KzBFYTRFaUo2ZW9hWWs5bFhNTm12SzBZNEdjc3NXT3NWcWpDaDR5US80K1VM?=
 =?gb2312?B?VFB3bC9ETzBHUzB2R1dJdVIwQ0ZETDBVdjk0bFArV0hiYjdEbFN2bWRqa1Rr?=
 =?gb2312?B?TVdqamlZS2NaK2pkblFpS1pRT0JNNXZnSUNCTzQ1QUlCRmJ6RjhBQ1dRQTla?=
 =?gb2312?B?QldLRmpHY21ZdUp3c2sxVGFuaE1vYi9sTzk1dGJzOUhRRE5jMXhXeGZrMUtL?=
 =?gb2312?B?MUovRVNPL25jK2RNVDNZUjNBT21CcHdrNmx1VGpKZVA2TEltN2RXdTFUSXdj?=
 =?gb2312?B?MXpIdUJ4RlgwRThXaEpPd3JCTkZQNnFYZTVLTzNhTTNzS2pncFFmUEhzNzlF?=
 =?gb2312?B?WDJGandiM3FWVklmUlAyZ0ZXZlFxLzdEWUNBMXp1T0w1ZE9IUFcyTzdudS8r?=
 =?gb2312?B?Z09ldVM1UGxHcWZyOERzOUtKdGgwMmcreGdmVlpVallNSklBdkhjTmkwQjU4?=
 =?gb2312?B?Tllha05kbnhsQzNpNm1hQ1JDNHdUZE9SSDJGdlRLTzBvOStnTitsaUsvbkVJ?=
 =?gb2312?B?SDZ5SHI4UnM5bmtDcXpSK1JhaTNJV2dubnFORmdCSjYrVzM2ZVFCZXZFNFpx?=
 =?gb2312?B?dW5sbVNMWmJCbTFDZ0VsVGU0bUlJYndrOEwrdW0rVUdsTmhwd3U4alJObWw2?=
 =?gb2312?B?L083clN1cko3OE9BMlYvQUVvbi9Ub3JGaXliWnZnVllrbEFLcmp1SzU2WHg2?=
 =?gb2312?B?Ym93UFBCMVR3V3h5Y0tNNitSdEFnYzZLZXcyYmFPYWRleGJONm5pNjl0QnE1?=
 =?gb2312?B?aWhnTk5RMlYxZlc0SXk1c3RJTU95d0ZMKzBTMDllVXhId0o2WVExbmttaXN1?=
 =?gb2312?B?ZDAxSGlaM05rWE9PcUUyMVk0TlV5ZUFGTkhPQU04NjY0TGhLWjQ4aE5sTDZ0?=
 =?gb2312?B?bFZIMVhJYXJkcXZud29pN3BvU0NwVjRFRVhZV2lSdy9mMHhvM0p3YkZTM0Nt?=
 =?gb2312?B?WWhVaDhoejlPRFpzdDdnSjJ6Nk9pc0hIaHVNN1FyblJhSjZBcnpmaUNTVGhh?=
 =?gb2312?B?bzVzYStBZk56L2FsTU80aHhEQzF3WThHQmwyREZ4THVMOHNtUTF6dHQvQ3Fr?=
 =?gb2312?B?VWlYRGQ0OTN4SDQ1dHBEWitha3U2SXhnQk4xcTg5Y2paL3NXUGUwME1zcGlC?=
 =?gb2312?B?QnlkeW42V0NXUGhwK3B0eUdONVJrYTdRKy8yenVyMmpoemdHLzBSV01sVU5l?=
 =?gb2312?B?OFhBVXVETHoxS2tkSm9lVlJiWDdVNndxa2I0RFptNkl0MGpsTGZDNko0UFBL?=
 =?gb2312?B?TGwyVEJXUEJLVzQ5MFRPdzAzN0FpM2UrT24xai84UWtIOHVVdy9DK1pqN3VI?=
 =?gb2312?B?dFRpS0JGOVgveWZxUUwrQWJmN2t6YW1MUmpOdThia3NEMmRxMEt5OGdKdzV4?=
 =?gb2312?B?Z0dzaW5YYlVZZmw2bXB1YVlZVnZ2eHhlTUZsZ1lMTzk0TzdSV1Bsb0Q0aEt0?=
 =?gb2312?B?U1VsNUZOMTJhd2FUWjdKc3krc21hNFRxQkUvcDJJNE9qdnREeVVoY1ZjY2ky?=
 =?gb2312?B?dldsRlNFVzZUYW13OGRRVWdLM1h2STA1RUxKTFI4SUxodVJIZFVJVDhnUHYz?=
 =?gb2312?B?RzJnVVplL0IyWHNwcWJVZnNQQk5DajFjRUMxclUvNW1SemluYUt3TjVsWkRD?=
 =?gb2312?B?MDE5R0FTV3BjZmg5enh5MnJlY2NMd04xYnBQOGNEZU4rbzdKUkYvTmxTTGdF?=
 =?gb2312?Q?67OIGa8avsy6DvkJiR08IfHf2gwKZLurrzYqw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?V3RQcjRtZUp0UzFIQmVoT3JHdkhubEJoUlJuU01hRWNJM0hvVWt0NzZ6Zkg0?=
 =?gb2312?B?RENjOVBCUXQ3TndjclV4WmR2RHR2YnQ1K3l3alJkd0pSYzllcGpXaThuemNm?=
 =?gb2312?B?aWVKSm83WlN5aVB6OVAxMTRVRWZzSis2d1FYOFUvSHJXVmdLSExJaGlmU1Fx?=
 =?gb2312?B?U0VENVJPQ2RPT1kzRXdNZEhXSHRJUnFERUNYRTZMTHNsRUFybzg0WUU2WmJ6?=
 =?gb2312?B?d0I4enoreWZlVVpNbkVGWFhiUUZsSTArRVRKOEVrNi9LYlVObXRQU1IwL3gx?=
 =?gb2312?B?QkdwdnZFaDVoQm5vZDJOV3RTZWdld1pqTVc5a1hHMVNVdTRiVnMzbE1JbmJZ?=
 =?gb2312?B?TjU0elFweW9PcTlmT0pwejc1MjQ1RkN5azdSeFFpY2JxTUxxdTZkSlVlQXcr?=
 =?gb2312?B?MXNibFhrU1lrbTJ1MkhBVEpGSHlzcVJrZk03d3NjNEU5bDdUUzZmWVIrSThH?=
 =?gb2312?B?bU0wTkhCVkpCYW8xTTVDRUM4NjN3T0svaHpTd1k1c3ZDc0xsdU9TNWg5SWZx?=
 =?gb2312?B?U2hwRWZlcFJPbktocUJjdnh1MkF2M1lnbDR1Wm9oVGt3cHpUc3ZBMHNkbmND?=
 =?gb2312?B?ZUY5N0VFUmc4NWppNDhkcCs0cUpEYS9QMk91ZUhNc2FOU0JZSXRPS2VPUVV5?=
 =?gb2312?B?SGN2dlZqMUJvRzAyQi9VVWFEMGZRKzJMYXBqWkt2aGtNQmtRV1BGNGN3Rzlv?=
 =?gb2312?B?dU0yWEFxVTA5L1VJZHF3NitkaThYVEMvU0xpTituaTMvMk5GWUlac2tVY0Q3?=
 =?gb2312?B?RDhOR2dpNzBpVDFoRnJhRVhoRHpJdm5KK0dVOUxFTDlzSldLaG56elBlYlJ2?=
 =?gb2312?B?ZlRsK1RoVWo3SmVtSUMwTXBNMVVnaXlqTXVXZkxPbVZ0Wk9RcmIxMDdkaHpH?=
 =?gb2312?B?c3ordkgrT3VvYndweDA5eEpudFRYRWg5QUZVMnRvenV2R1dBOW5HQXFyZGtH?=
 =?gb2312?B?RXJ5YUtBTVNMMDZabWhMWVc2S0prWmw4SG93T2FxRGEyTzN5cjBoT2U5WFp1?=
 =?gb2312?B?VFMyNDVEb0N2MS9rU01sc0RNL0lwVExlY0lJWVNWRnVQSmpnT3FlRG94a1F0?=
 =?gb2312?B?YWZDNFhEb0lIbVhBU1pZNWhEbythcFJMdk9GMm54Zkd2bHBMSXczVFNBeUZy?=
 =?gb2312?B?RXZXd1lONEhTeWN4RXZvZXEvMCt2aGgyK2hESFZWamJxejNLMHJ0TVE1OGJC?=
 =?gb2312?B?NUNGelVTa2huRGlKU28yT2dhQkZlZ1A2YmpCZ1hPR3RVUi9vR0wzQU5vWFk5?=
 =?gb2312?B?Q1B2ZjhOeFpzTFh0Z2NmVm1lY2RvVnNnZW5ZUzVMNmoxQTZFY3EvdzJHbUtI?=
 =?gb2312?B?ME5zdkRQdzh1WUJ5YXRkRW1mOFlhaHVrZW0xbUNiOHVhcjZPOE03UERBSTR4?=
 =?gb2312?B?dDQ5dnhHUm04Y0wrVkxlbGZ1aURxTk1JQWx0WUlhYlJqdzUxT1FrN2UybFdZ?=
 =?gb2312?B?MklNY05kNDhMbFhQZ0pMMlRoQlBvK3BMUjVzU3lRVWZGbGxERVJMdHFySUkz?=
 =?gb2312?B?Uk1jME9IKzljN2lJMzVLZi9GOUg0Unh6QnFNTXBCUGF4bjlNOEdUMnkrKy9F?=
 =?gb2312?B?MDB6TkhJdlpZZHlmY0k2U2d4UklSR1FrMFlZVWZHcHIrUTBVZU94YzNkcEZW?=
 =?gb2312?B?T0dzS0lVOU81TGFPa1gveSsxbC8zcnZFb2ZmOUdXOVA4SjI2eTY4aVVtdDJV?=
 =?gb2312?B?YjJYRnN4UzlXUW14ZzFQNk1waFNxV0lkanNkRjFPV3RXNUpaQ1hVN0ljRE1a?=
 =?gb2312?B?emF4WWZTb0Jobm16MmlUaU9sVVdNbjJxQlZ4WW4vVmROMC9Pa2NGQkpVWU5v?=
 =?gb2312?B?QnorcWFBOFlJK1YrM1lOdVdqaU1mZzBpMkxIbDZZdUNCR1Y1ZUh3K3ZBU3lH?=
 =?gb2312?B?d1lqVDVJdUIzSlpTLzF2WUNwdXIrNzBhUStweUhvOG9qU0ZMeDhqV29rbkhz?=
 =?gb2312?B?V3lKTWswWFZCcUJ1TjEyMGlCM1NpQ1ZEQ3JndzJpaDM2aWd6NDBqSC9Vc1hn?=
 =?gb2312?B?WFFweC9vZlg2dFVuRzJsMVFkVDl2TFVneUE1bGZCeUFpMHBhM1d0QVVzSHls?=
 =?gb2312?B?U1gvb2thTjJXQVozb1J0ZjZoNVhkaXFPTGxLU0FkK25wUWloL25rWW0zRy9i?=
 =?gb2312?Q?wV2r1jQPQOiOhEYxqQMqbTQco?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55084088-eba5-4e4c-1db2-08dcb29b1d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 02:30:45.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wqHA9EXx4WvBf9jhw/zhNDHMkkMWABtxK0XcPs4rHXzbvh0vB4EQwOJyhqum0AvYLmqagNcKPt1xTcky1vqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8964

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtsYXMgQ2Fzc2VsIDxjYXNz
ZWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqN9TCMjTI1SAwOjA0DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogdGpAa2VybmVsLm9yZzsgZGxlbW9h
bEBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29u
b3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1pZGVAdmdlci5rZXJuZWwub3JnOyBz
dGFibGVAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzZdIGF0YTogYWhjaV9pbXg6IEFkZCAzMmJpdHMg
RE1BIGxpbWl0IGZvciBpLk1YOFFNDQo+IEFIQ0kgU0FUQQ0KPg0KPiBPbiBGcmksIEp1bCAxOSwg
MjAyNCBhdCAwMTo0MjoxNFBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBTaW5jZSBp
Lk1YOFFNIEFIQ0kgU0FUQSBvbmx5IGhhcyAzMmJpdHMgRE1BIGNhcGFiaWxpdHkuDQo+ID4gQWRk
IDMyYml0cyBETUEgbGltaXQgaGVyZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hdGEvYWhj
aV9pbXguYyB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9haGNpX2lteC5jIGIvZHJpdmVycy9hdGEv
YWhjaV9pbXguYyBpbmRleA0KPiA+IDRkZDk4MzY4Zjg1NjIuLmU5NGMwZmRlYTIyNjAgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9hdGEvYWhjaV9pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvYXRh
L2FoY2lfaW14LmMNCj4gPiBAQCAtODI3LDYgKzgyNyw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
c2NzaV9ob3N0X3RlbXBsYXRlDQo+ID4gYWhjaV9wbGF0Zm9ybV9zaHQgPSB7DQo+ID4NCj4gPiAg
c3RhdGljIGludCBpbXg4X3NhdGFfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgaW14
X2FoY2lfcHJpdg0KPiA+ICppbXhwcml2KSAgew0KPiA+ICsgICBpZiAoIShkZXYtPmJ1c19kbWFf
bGltaXQpKQ0KPiA+ICsgICAgICAgICAgIGRldi0+YnVzX2RtYV9saW1pdCA9IERNQV9CSVRfTUFT
SygzMik7DQo+ID4gKw0KPiA+ICAgICBpbXhwcml2LT5zYXRhX3BoeSA9IGRldm1fcGh5X2dldChk
ZXYsICJzYXRhLXBoeSIpOw0KPiA+ICAgICBpZiAoSVNfRVJSKGlteHByaXYtPnNhdGFfcGh5KSkN
Cj4gPiAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoaW14cHJp
di0+c2F0YV9waHkpLA0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCj4NCj4gV2h5IGlzIHRoaXMg
bmVlZGVkPw0KPg0KPiBhaGNpX2lteC5jIGNhbGxzIGFoY2lfcGxhdGZvcm1faW5pdF9ob3N0KCks
IHdoaWNoIGNhbGxzDQo+IGRtYV9jb2VyY2VfbWFza19hbmRfY29oZXJlbnQoKToNCj4gaHR0cHM6
Ly9naXRodWIuY28vDQo+IG0lMkZ0b3J2YWxkcyUyRmxpbnV4JTJGYmxvYiUyRnY2LjEwJTJGZHJp
dmVycyUyRmF0YSUyRmxpYmFoY2lfcGxhdGZvcg0KPiBtLmMlMjNMNzUwLUw3NTYmZGF0YT0wNSU3
QzAyJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzlkNjRlYWINCj4gZTNjNWY0YWY5ZDE1ODA4
ZGNhYjMxMjY1MSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMA0KPiAlN0Mw
JTdDNjM4NTczNDc0NzgyNDkzNjA3JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUMN
Cj4gNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
M0QlN0MwJTdDJTcNCj4gQyU3QyZzZGF0YT00Z0h4c3p6eW04aE9nVklvNiUyQk0ySkhNeUJhNUk1
VTY1ajA4ZkgzUDM0QlklM0QmcmUNCj4gc2VydmVkPTANCj4NCj4gU2hvdWxkIHRoaXMgY29kZSBw
ZXJoYXBzIGxvb2sgbW9yZSBsaWtlOg0KPiBodHRwczovL2dpdGh1Yi5jby8NCj4gbSUyRnRvcnZh
bGRzJTJGbGludXglMkZibG9iJTJGdjYuMTAlMkZkcml2ZXJzJTJGYXRhJTJGYWhjaS5jJTIzTDEw
NA0KPiA4LUwxMDU0JmRhdGE9MDUlN0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M5ZDY0
ZWFiZTNjNWY0YWY5DQo+IGQxNTgwOGRjYWIzMTI2NTElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDDQo+IDYzODU3MzQ3NDc4MjUwNjkwMyU3Q1Vua25vd24lN0NU
V0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TQ0KPiBEQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
STZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3QyZzZA0KPiBhdGE9dnBuMVF5WDhw
N0laaEJpNW4yaU9pOGV6RlJQVGJHazFmcWxLNVpzUGhZayUzRCZyZXNlcnZlZD0wDQo+DQo+IHdo
ZXJlIHdlIHNldCBpdCB0byA2NCBvciAzMiBiaXQgZXhwbGljaXRseS4NCj4NCj4gRG9lcyB0aGlz
IHNvbHZlIHlvdXIgcHJvYmxlbToNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2lf
cGxhdGZvcm0uYyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiBpbmRleCA1ODE3
MDRlNjFmMjguLmZjODZlMmM4YzQyYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvbGliYWhj
aV9wbGF0Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiBA
QCAtNzQ3LDEyICs3NDcsMTEgQEAgaW50IGFoY2lfcGxhdGZvcm1faW5pdF9ob3N0KHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGFwLT5v
cHMgPSAmYXRhX2R1bW15X3BvcnRfb3BzOw0KPiAgICAgICAgIH0NCj4NCj4gLSAgICAgICBpZiAo
aHByaXYtPmNhcCAmIEhPU1RfQ0FQXzY0KSB7DQo+IC0gICAgICAgICAgICAgICByYyA9IGRtYV9j
b2VyY2VfbWFza19hbmRfY29oZXJlbnQoZGV2LA0KPiBETUFfQklUX01BU0soNjQpKTsNCj4gLSAg
ICAgICAgICAgICAgIGlmIChyYykgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJy
KGRldiwgIkZhaWxlZCB0byBlbmFibGUgNjQtYml0IERNQS5cbiIpOw0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gcmM7DQo+IC0gICAgICAgICAgICAgICB9DQo+ICsgICAgICAgcmMg
PSBkbWFfY29lcmNlX21hc2tfYW5kX2NvaGVyZW50KGRldiwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgRE1BX0JJVF9NQVNLKChocHJpdi0+Y2FwICYgSE9TVF9DQVBfNjQpID8gNjQgOg0KPiAz
MikpOw0KPiArICAgICAgIGlmIChyYykgew0KPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYs
ICJETUEgZW5hYmxlIGZhaWxlZFxuIik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmM7DQo+
ICAgICAgICAgfQ0KPg0KPiAgICAgICAgIHJjID0gYWhjaV9yZXNldF9jb250cm9sbGVyKGhvc3Qp
Ow0KPg0KSGkgTmlrbGFzOg0KSSdtIHNvIHNvcnJ5IHRvIHJlcGx5IGxhdGUuDQpBYm91dCB0aGUg
MzJiaXQgRE1BIGxpbWl0YXRpb24gb2YgaS5NWDhRTSBBSENJIFNBVEEuDQpJdCdzIHNlZW1zIHRo
YXQgb25lICJkbWEtcmFuZ2VzIiBwcm9wZXJ0eSBpbiB0aGUgRFQgY2FuIGxldCBpLk1YOFFNIFNB
VEENCiB3b3JrcyBmaW5lIGluIG15IHBhc3QgZGF5cyB0ZXN0cyB3aXRob3V0IHRoaXMgY29tbWl0
Lg0KSG93IGFib3V0IGRyb3AgdGhlc2UgZHJpdmVyIGNoYW5nZXMsIGFuZCBhZGQgImRtYS1yYW5n
ZXMiIGZvciBpLk1YOFFNIFNBVEE/DQpUaGFua3MgYSBsb3QgZm9yIHlvdXIga2luZGx5IGhlbHAu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPg0KPg0KPiBLaW5kIHJlZ2FyZHMsDQo+
IE5pa2xhcw0K

