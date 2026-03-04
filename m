Return-Path: <stable+bounces-223032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHb8I8cVqGnUngAAu9opvQ
	(envelope-from <stable+bounces-223032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:21:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8493D1FEE12
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B98E30072A7
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EA392811;
	Wed,  4 Mar 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AFEilgch";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AFEilgch"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020134.outbound.protection.outlook.com [52.101.69.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4023EA80;
	Wed,  4 Mar 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.134
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623295; cv=fail; b=svzv3Xp0dTjY+yTmqdrW069imFhJF+YSss8/Qkg455UZQ/neoRCb+rq3t95dij9WCCVcX9HD/FuMfuYCu2MIeJJ4qoNtNylm9dNzN9CTVbyYGBrwRwYfSu3wHKibitsixGjWY0dJVsRu2KjH40S5BISSvkXU9NhjNC/r8g1qcks=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623295; c=relaxed/simple;
	bh=+1jCX59C1VmSDOsfbtxMECYHAp4RJ3kVlB/V3uwp5K0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GhplIsd2QWW0gshyyPS6/Wozyhtb3fSsVWyBmzrIFTHMnHQ545emcED66+GE3ceoiw0vMMOtkA+Etl7bZlt5zwIHZvObuGaB60U22KVekhXlCAc1zSNnBUt53i8joxEyW8pEyrM6BFJyZa+ZIpCRd1v/qjHjNxflfCH7lV/K44c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=AFEilgch; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=AFEilgch; arc=fail smtp.client-ip=52.101.69.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cLSTDduF/LOMlP1nalOtI3Ez4OH2qxTWE1QuVb48mNdU8+ujik9KHbR1I0jeW31z6K/d8BDP6ZdQsnrNBOnZasrNCQJjxRDbtO2osucxhR6Hh91zLgYUwY/i4pTOox+AJOcsFw9UUNffB32RfUH56mtVn0P0MQkOapvRBJv7p/K+IrmGdvwR0aE/tiBRI5M5jmixbVS/WoU0EVg9HxfRwX1y1yKC//sLQ2yuqGZ6doHexKon2+XED6rKLGuap54oSK35AKo/P2XFPldQYX2TwLmqjp7dEWcNUfvL2uAitDd+pvAHsPWgUAoG95zca23UzI3T5d0UHQJZgbcpIVMdkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcixeyrRhZNXjl+Lfp+jwp3mzPz4jkCI4oXT4/tyMqI=;
 b=lZnr7ZJ34MxONtyZ5cbySmOABWwmlDHlhOpbXZtkZCHqZql4gLF4Yw5x9hNLQcUARYJKJHavUlGOZDsoAJn1jncD57tHHktL1/rF1mRI0MPSbPUtbduD+dMA0gAUpD2VEuagPK2BcQLzu+f2m2Ypmf64GOVI34QY55UEC/FHj78rge7DQ7LchCxfzlBgE/fdPFrwdRA5n0K57I/fXPEmws1iX+hu5pnC09e8kfkYW507GiAB3p4dXQ24/uanJke87ppAcP2c4H54aYfmQH+MxaeYkoUvsiyrK81pToJH7IuTGUuhd5b749EvLsc/otVCLGPtT38DtCanvj/CO5pq5A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcixeyrRhZNXjl+Lfp+jwp3mzPz4jkCI4oXT4/tyMqI=;
 b=AFEilgchwPg2d6tByb4ulTPzj9t/N43Bz+6r524P0/eqyQRmuNs1vVgbrDrR+2SLNgJaWvcvE4sEab5HkwmLNlILQESv4DWIXIlqFbuiLQSE5JSheSJiVd/RkGUMDj1DwdaqLKBRsXTzUUf9EHO25hgDzqPJFIsaa3ZF65AoChM=
Received: from AM8P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30)
 by VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 11:21:29 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:21b:cafe::60) by AM8P251CA0025.outlook.office365.com
 (2603:10a6:20b:21b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 11:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 4 Mar 2026 11:21:29 +0000
Received: from emails-3172265-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-248.eu-west-1.compute.internal [10.20.6.248])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id CC30E80690;
	Wed,  4 Mar 2026 11:21:28 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Mar  4 11:21:23 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zmzfgw4f68Q5rRIk6/e/Ea2tntD4WJyf+P5Nm+LZp9dAXKceKzB3nEU1VCheZAKN4Z7MdH0kuZUoq61KTrkELM5FW/hkXp4/n0OLAag5eOz2SmMJxtkUpgpu5OsUOT7w5QjgXYlkj7xqRfVPQfVoh9/PWRhffXeHnmnLY9zzAALvXUW+2AhDX/WHuIAEPeWEhndITB9nyvaZtqFjJ3kSR1X888muOQteIgrjvaafHokbHapcjCYkQBEE9DL6R0VxjvAC/Dmz9YRSKLXpQ8J7moG0QAnyYY3UFy1jEb/utvbZe8ikG/5H54CqssW2Rht0D6pIdG9+2VO/T6WR8WDNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcixeyrRhZNXjl+Lfp+jwp3mzPz4jkCI4oXT4/tyMqI=;
 b=OFD4Q1zfQYkXYDUJEHdaGF6QiZE3NOANwDIME+eG6IDRpQAD4JjHv2U0IOv/7BGDCUGdQcdpzu7wXIH7g9rjHv+lE+EydOuELwTUq8duCokrb6MRRsoAwaj4/NH1cZPOPIs2c/fYK9gf58FYLaaZ4ecTDipNVcz40z/dJn8he9ZgAyEDUM7wmGRW233UxKzrwUTZBJAkiTZnS+Q1wFeGXx6tC6YLIba2AMGSZMCbKZK92n+VZvp5uuKdT0+XpgCwIAFLqCPJ824+BPv5rpWyJRYPtrqAq/vH3gLUk3JD2uQJY0dJSeEe/h52HgsC5fL5nxj0qhBg9lnz6WcE0GqVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcixeyrRhZNXjl+Lfp+jwp3mzPz4jkCI4oXT4/tyMqI=;
 b=AFEilgchwPg2d6tByb4ulTPzj9t/N43Bz+6r524P0/eqyQRmuNs1vVgbrDrR+2SLNgJaWvcvE4sEab5HkwmLNlILQESv4DWIXIlqFbuiLQSE5JSheSJiVd/RkGUMDj1DwdaqLKBRsXTzUUf9EHO25hgDzqPJFIsaa3ZF65AoChM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 11:21:18 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:21:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 04 Mar 2026 12:21:13 +0100
Subject: [PATCH v3 1/5] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd
 & gpio pinmux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-lx2160-sd-cd-v3-1-dee4523600ef@solid-run.com>
References: <20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com>
In-Reply-To: <20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|VI2PR04MB10979:EE_|AM1PEPF000252DC:EE_|VI1PR04MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf0e027-d26f-488e-feae-08de79e02e6f
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 dSSe3976269zmg9RAE9R5QkaxxRlZE4Km6Py1gQCYtOmdzmiEM+Eu96yuodSV3MRB4HQcFO5mdbp43XY/efQZMjF8ALMOOmAHj36fbnelmV6G3mwvmPgaZJrXTZ5kpWeOe1Txru6huTwuwnE/0PIPbZOBENqcJlLUd+KZgcPybJwPy8jmkJQ5Kc3TGBR3sWJPwv32CBNxugtolBpS+JE0EFqQRq2nSHu0NodcPbKe6OF4L+OoN/og1CNbKldQxvWGDpCryIolPgI0YjB0HTqiCs4LvGM0FKJACXp91uJLdiPpi02sipOEDYka4Tiojqzh9odQJRzPagHtv5/Uo7x8LXJoMzE6TPZvU8Za/uah2zUZSg+TokqQsQizy2JIri2kN5k0eVuNN3gaMdIXQnQ4DO90cU+/03TneI6alnjgkO8Rn8JKXv6dXoMpZpdyTv59Ixc7v3tHtvUQGbrMyuS9/Q1FG8Csrxe2k/uZhUpqYNETV3UtNkBXQi+NUVMNel4vvgcZKNxgAPdvlKucuq5moEV1veUGCNgkeWMj1DneEUHrR18Mn3j9GQi+v5LFo+j8LtWNfmXVcrDT8A0AtDqS7hmPVES8U70/C8SRChnx1ghC5s7/Bi3VVaTqqCg25Z9hpjIXGvKR7rtuknLg6VVNzBN7V7bx+E3Jsh9+5BWoA+ycMuHzVq4Xa6Hl+b2NKKxsF6dlGr6h8MFExWzcWKCD/SRUOcnX9XUN6gBJcrnY+J/RmKQ8znQkFx2MRPGeM5AcoAI6bac1f2OQmOHwIbBWr9tsZs98tRs8RFVzI9/rSU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a0615c6c357542498e81dd7b84e4796f:solidrun,office365_emails,sent,inline:5f0b7cc6de19ce8620387e38676eea81
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	30b029d6-3ce9-49d1-3e4f-08de79e027c1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|7416014|376014|36860700016|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	f7QxzXxruGM3ubemrPZuDPNMD7jx3vqJqFKHl9WLQRP0yD2CEZGmHJ/VPhONwy73n3Cw+I81h/nHwa46A8ng9xJ29dqRFnGaBONygG7AaUbfRdrhLYyIL0ACp1Yc3au4z/FihFrjyR+tPs5zTTi6zFtN5NgJdeZbAC+dsKi3R1FdrTMySm54FRdUuqL0ZUEb2h3A3CT4XJp3wW0Xpyr7Anj0ekY025S18W2mHJY1+VxdqhcE9FSvGLmQyxtXgE/3QQd2ymTQcmFFZKT01y8t3cWSzTS+JV2PFvrK2i45cxf3B1h7zJSLxghfdfrCwEgiVGRzhX00AOBSS89SIwaxxG8A9NcVKkoTgP67Cl15q1eSS8psmQ5MWmzDWuyR9hc2SueJlRuqH8QEx+vWJ+nPwvCp4kQowjtAUY2L6VF/IR1r4js5ZsslPf+7i0XRwTu4V8dYnq2HtCvn59nRCeHzX9kTZrZaJp8+E2Ha6MNmOtQRRsM63jWqo7Ns3d5e7wSeHZR/w35VK5IHfjkVHJAGoLd/o3zXQFm8d3h5SaNxf6qApqzcep6LWIcjP+Ppln6D0PWtRJzzhERsyh+cS9W91gVAszLl0JReotCYwxx7myq2LQtlzwgx62DthXqhzkMHigFPYJiP/odJ+ela3RIUrLSiwpygmiMrYPgpk24Pk84kIyiJSpOhC2bhO+cVtJJf1XiwIeSW4w0ADSn/fm2xvO7tiKIYgcpSziAdX2wwsHM6SfubDNuszD6pheEpN+2qoGrWPkY5T7Qcn/gdEczj0g==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(7416014)(376014)(36860700016)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F3dwSpIPmamB/6HsDna8k2lMDX9OP5Ee+UkLzMsA+J4+vULwloOvXgsRuKLJhGAhAKLdJxJe4C+RL0StyqZjbrpkL8FzhmJxuANUosd8fj/ND4g0VmAFN4p8Jo6yQCV5U80MkH+vEaN5aB1ANQFguayhvUhhWit70FNlJpsGw1CLs0HujJ8txg/zoea+ACPZVi+R/+XO/gOIWvwtlLYeWS74wgQd+P8C6kg+93HhlF5W4ObJOAiLiAXodcMNAr2kmo0vMr1m6sqqCBzAo4A87wRPbL1cL9V00MH8M2GW9ZdWc3M3XI0qSMnMxk/yxWIcb9vgMwTJqpzcnsdXqGr0+pL6Q2gqkv4axLYaN/eQeryu2X+wfhgDxdCZcNGoyiPgTrO9BWd8uedKT52R1sV+lqxgfd7Ld7R20uBmUQ6u6/JD/WiTcczun7VrDTOX3I44
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 11:21:29.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf0e027-d26f-488e-feae-08de79e02e6f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7071
X-Rspamd-Queue-Id: 8493D1FEE12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223032-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,0.0.0.51:email,solidrn.onmicrosoft.com:dkim,6f:email,0.0.0.15:email,solid-run.com:mid,solid-run.com:email,0.0.0.0:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to
support bus recovery") introduced pinmux nodes for lx2160 i2c
interfaces, allowing runtime change between i2c and gpio functions
implementing bus recovery.

This has caused unintended side-effects on SolidRun boards where the
first application of a pinmux node cleared all bits in a 32-bit word
cleared, corrupting the configuration previously set by bootloader.

The LX2160 SoC is configured at power-on from RCW (Reset
Configuration Word) typically located in the first 4k of boot media.
This blob configures various clock rates and pin functions.
The pinmux for i2c specifically is part of configuration words RCWSR12,
RCWSR13 and RCWSR14 size 32 bit each.
These values are accessible at read-only addresses 0x01e0012c following.

For runtime (re-)configuration the SoC has a dynamic configuration area
where alternative settings can be applied. The counterparts of
RCWSR[12-14] can be overridden at 0x70010012c following.

The commit in question used this area to switch i2c pins between i2c and
gpio function at runtime using the pinctrl-single driver - which reads a
32-bit value, makes particular changes by bitmask and writes back the
new value.

SolidRun have observed that if the dynamic configuration is read first
(before a write), it reads as zero regardless the initial values set by
RCW. After the first write consecutive reads reflect the written value.

Because multiple pins are configured from a single 32-bit value, this
causes unintentional change of all bits (except those for i2c) being set
to zero when the pinctrl driver applies the first configuration.

See below a short list of which functions RCWSR12 alone controls:

LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
IIC3_PMUX              |||   |||   || |   |||   XXX    : I2C/GPIO/CAN/EVT
IIC4_PMUX              |||   |||   || |   |||XXX|||    : I2C/GPIO/CAN/EVT
IIC5_PMUX              |||   |||   || |   XXX   |||    : I2C/GPIO/SDHC-CLK
IIC6_PMUX              |||   |||   || |XXX|||   |||    : I2C/GPIO/SDHC-CLK
XSPI1_A_DATA74_PMUX    |||   |||   XX X   |||   |||    : XSPI/GPIO
XSPI1_A_DATA30_PMUX    |||   |||XXX|| |   |||   |||    : XSPI/GPIO
XSPI1_A_BASE_PMUX      |||   XXX   || |   |||   |||    : XSPI/GPIO
SDHC1_BASE_PMUX        |||XXX|||   || |   |||   |||    : SDHC/GPIO/SPI
SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI
RESERVED             XX|||   |||   || |   |||   |||    :

On LX2162A Clearfog the initial (and intended) value is 0x08000006 -
enabling card-detect on IIC2_PMUX and control GPIOs on SDHC1_DIR_PMUX.
Everything else is intentional zero (enabling I2C & XSPI).

By reading zero from dynamic configuration area, the commit in question
changes IIC2_PMUX to value 0 (I2C function), and SDHC1_DIR_PMUX to 0
(SDHC data direction function) - breaking card-detect and led gpios.

This issue should affect any board based on LX2160 SoC that is using the
same or earlier versions of NXP bootloader as SolidRun have tested, in
particular: LSDK-21.08 and LS-5.15.71-2.2.0.

Whether NXP added some extra initialisation in the bootloader on later
releases was not investigated. However bootloader upgrade should not be
necessary to run a newer Linux kernel.

To work around this issue it is possible to explicitly define ALL pins
controlled by any 32-bit value so that gradually after processing all
pinctrl nodes the correct value is reached on all bits.

This is a large task that should be done carefully on a per-board basis
and not globally through the SoC dtsi.
Therefore reverting the commit in question altogether was considered,
but received pushback in review with the argument that bus recovery was
important.

Instead add pinmux nodes for all fields or rcwsr12 as used by affected
SolidRun LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog boards.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  7 +++++++
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |  2 ++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 24 ++++++++++++++++++++++
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  2 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  7 +++++++
 5 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index eec2cd6c6d32a..7f6e39e27ce5c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -162,6 +162,8 @@ rtc@51 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -177,6 +179,11 @@ flash@0 {
 	};
 };
 
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
index af6258b2fe826..580ee9b3026e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
@@ -89,6 +89,8 @@ &emdio2 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 853b01452813a..be0ccab5a626b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1721,6 +1721,10 @@ i2c1_scl_gpio: i2c1-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 0x1 0x7>;
 			};
 
+			esdhc0_cd_wp_pins: iic2-sdhc-pins {
+				pinctrl-single,bits = <0x0 0x6 0x7>;
+			};
+
 			i2c2_scl: i2c2-scl-pins {
 				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
 			};
@@ -1753,6 +1757,26 @@ i2c5_scl_gpio: i2c5-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
 			};
 
+			fspi_data74_pins: xspi1-data74-pins {
+				pinctrl-single,bits = <0x0 0 (0x7 << 15)>;
+			};
+
+			fspi_data30_pins: xspi1-data30-pins {
+				pinctrl-single,bits = <0x0 0 (0x7 << 18)>;
+			};
+
+			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
+			};
+
+			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
+			};
+
+			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
+			};
+
 			i2c6_scl: i2c6-scl-pins {
 				pinctrl-single,bits = <0x4 0x2 0x7>;
 			};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
index eafef8718a0fe..8920326a06735 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -223,6 +223,8 @@ ethernet_phy8: ethernet-phy@15 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
index e914291e63a1a..e1344942eaaee 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -30,6 +30,8 @@ &esdhc1 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -80,3 +82,8 @@ rtc@6f {
 		reg = <0x6f>;
 	};
 };
+
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};

-- 
2.51.0


