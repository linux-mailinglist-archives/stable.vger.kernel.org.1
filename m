Return-Path: <stable+bounces-225419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH7yCaBQtWm8zAAAu9opvQ
	(envelope-from <stable+bounces-225419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:12:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E528D0C3
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AA893016734
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1B2FF657;
	Sat, 14 Mar 2026 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qVdeaWFT";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qVdeaWFT"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021102.outbound.protection.outlook.com [52.101.65.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380A2D94BE;
	Sat, 14 Mar 2026 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.102
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490331; cv=fail; b=RjyO987GkYYaHWWTP+2XF0CivOQL8DuwimUSjVvd0XYq8SaqqIwMMxgwodBZgeqpUhSq+m0IuGTCgdd6euUOhQ9F7GBnUfgyJt8HBs1HOtpju6OexXwuIw5yLL1aDpjz87nzrJf01kV9W6Pk+mHWC6Uios3iA6kZdk+2+56IJ6U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490331; c=relaxed/simple;
	bh=ejQkC8yNKm5d+mBVlZsukyaySX2T31YEmO7YY/ZrFsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/NH2PD+ySTXG/O8SsJg+EFfKTpsRTnzX59fQuTEJrLjhC2BuPO3rvZkJkHm3yVEU5LRa1dOBktCxRbVlxyTv8vVLUENYMr/MTMoVp0dKTVLmlTU7bmAvQL4RiOL0vO1iS2ql+CJTac3zm5On0s3RJA6HAlA03S11JzMzTdI5kc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qVdeaWFT; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qVdeaWFT; arc=fail smtp.client-ip=52.101.65.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ea9l0QThMOVL3DZLkFFrF90QoyNg+MQxH4/adID9Fs+hm+WF7DPnaUntXtUwRwjgaiMo++CyfopsLQt8FNxPkqeWz+NHs1p5RlFSQ0RQqiLU4k3P1L5IoSnFU9HxDQoNJQ9Uqyxgoqno+dkah0TltcIVsnl59xRT9Sm1a44v1m/5C4YxG8obl/KNOAC3F+RE4gdPB0lbpvLzwQ4HIPNGq0Q0LBE2fo6/gdgjcmSGXyJy26spno1DqR0WhBhCNRrK6so/eg+2M8vTNQ2I3J899rP/Rk947faEnt8LnAqx0kU3vdC2H1VW89UxUyqki+9GMdPLQGLK7pymPeiT7+M8lQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejQkC8yNKm5d+mBVlZsukyaySX2T31YEmO7YY/ZrFsM=;
 b=wsYsNanBZzzIYNaIEkW3EKyKUXS/LdU3Estn7jlXrIgOkH/96I8bP/DhUPv3IsIJYAcGLotMBV3scZJBYDuDh418t4LgeOAkD7yiVxa9hTU5mffXGWe2M/b3DPLaecP37Tb3yl5xAMTlfDQBOmYDCQzr5aGWOhyQLXWc3htkVvb652iGejyP0ksOOFT6vuMYAfuKq3L4WrISw0S0kczRf5/IO9kUEwjwUW7xivxJkCCfrXB6cJ9gdnj3OMDGIRQQjJLou+ao3dfr7GDoj/iIixPegOiW9nT2BnKfIHHp8dAUqssDARnZyfem9ecT0zEcoaIUWN21RoZ3g9faYv/b4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejQkC8yNKm5d+mBVlZsukyaySX2T31YEmO7YY/ZrFsM=;
 b=qVdeaWFTc+VVazSKUX4q467XT3lNDUJIsLdVGjObXEboCt7L5MsiNtdP5UV9kL+KGA73TJGDXX2wxup/ksuiaL3dgOqTbjUTyUBtzXwS3E2ZCi0EvcxnMVRy8R3rBvm+fguSDgOSiyOAipZXgtoD0c/f++RWIv2xfueggMdU4t4=
Received: from AM9P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::31)
 by MI3PR04MB12540.eurprd04.prod.outlook.com (2603:10a6:290:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 12:12:03 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:21f:cafe::49) by AM9P195CA0026.outlook.office365.com
 (2603:10a6:20b:21f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Sat,
 14 Mar 2026 12:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Sat, 14 Mar 2026 12:12:06 +0000
Received: from emails-2311019-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-180.eu-west-1.compute.internal [10.20.5.180])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 8A97D7FF38;
	Sat, 14 Mar 2026 12:12:06 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sat Mar 14 12:11:59 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCQLY2TUXWWdyYWm2WxNmkpIrmgeRPBawZmJyJnJB+pg+9D1jTSRKm3UnAJWhwZ0DKrp9xJdSUajiBHAIH4tjUlxbn0HzJuY9iaZquufO+0+o8JUxeUqNhMpqLv2RFm4uLrwyxV63HBk+TM+wnYU+eY+pB/eeau6ncsE5WMA3GYgVp9uTjqB3zAdFAc6yBgwEGBNS2iMLPcTi0DaxDlwl9MscqCeBuf1a9ikJu9ZFGC4LoPH8RtyczUYAZYrDKRWe2TwwAmX1M5k0KSgxoJDLVQsJ6U69dD+Xz6Xp7IbmfczHzmnA6kyrQIwSg6EO4MmeqIkCtkTR0XlXiW61h6yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejQkC8yNKm5d+mBVlZsukyaySX2T31YEmO7YY/ZrFsM=;
 b=JEaiB1ZQcidJ/DbPzmGQ3hStNtn9WvqDmC9FkKqnFShR8rdlTyqqhZ+FwpRzdzEKwn0UF6lCREgYyNhRmVqjGMuIQlbJWn0cSM0qOuKiTx62MvNEW40qttSereL5J/Ehvv9fUgPfy0yxujQavk3BlqBmo8c3v+0icUC67WHHt/KyHrSu720+sUygAcNLGMwXSRpTfEKmAJ2Tcq8anOZBmppr4FYAlGGvXLrFcSeurYdJhesIaKcXi+sqDYjnFJ+mzo0IETfwfKCIS1gYW1q4SmlRWc+QrXRQj/98SCTUbuIBG8L3gEmc8RtVQPA4f9356NnPhlBtDHzS3PmnonhC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejQkC8yNKm5d+mBVlZsukyaySX2T31YEmO7YY/ZrFsM=;
 b=qVdeaWFTc+VVazSKUX4q467XT3lNDUJIsLdVGjObXEboCt7L5MsiNtdP5UV9kL+KGA73TJGDXX2wxup/ksuiaL3dgOqTbjUTyUBtzXwS3E2ZCi0EvcxnMVRy8R3rBvm+fguSDgOSiyOAipZXgtoD0c/f++RWIv2xfueggMdU4t4=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sat, 14 Mar
 2026 12:11:53 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9700.015; Sat, 14 Mar 2026
 12:11:39 +0000
From: Josua Mayer <josua@solid-run.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Carlos Song <carlos.song@nxp.com>
CC: Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v5 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Thread-Topic: [PATCH v5 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Thread-Index: AQHcs6rIDBlwHd7yJkmv6JZ4qwPVobWt8CyA
Date: Sat, 14 Mar 2026 12:11:38 +0000
Message-ID: <dc3fa216-fdad-42a8-a418-41106402ee19@solid-run.com>
References: <20260314-lx2160-sd-cd-v5-0-83de721585e3@solid-run.com>
 <20260314-lx2160-sd-cd-v5-1-83de721585e3@solid-run.com>
In-Reply-To: <20260314-lx2160-sd-cd-v5-1-83de721585e3@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DU0PR04MB9298:EE_|AMS0EPF000001B6:EE_|MI3PR04MB12540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e521ec0-bd5e-486b-d14c-08de81c2e92b
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 VKmRGdFaHzSh26KlT6gtkEl9Mxg977Ip8nhYM3Z7s2ElN/S5wFPPAmx7F1g/UaTeINqFtbcAUL+eIeYKFMb5Ieqv/yK3elpRGHh6aWXhQJexrJgEVUMpyrJZF2YD2ZL0jgTTh3lU2sYyzrbb8rBCtWwm72qaTzrf9Z8xOxqjjelDsmh94s5Hvs1Rs1ppA3XO/p0vC9BtJi/4ndxaiedNqWg+A7GVS78kG0CLk0EwY91enZmB8Rh5ib8PFSUJRUvsJHgbJtLGxwiXv3vNQGBQSjfKmz3Gi3vLALdlmVM6F4HMMDwv5ltuVWzd+EjsE5ijXi8+vKx9EWOHHjhC3e8qZOQWeMDtmoqKtpDm1ML4mzloHhh/fBnDltI8cg5wI1pZNDNv8uElLNqCik8RhhUbtgRRwb94Q2VEq4dXIcEXFAj5b8AQypGy53fs+dSXRXVR3vBTfEz4nxeTvArn7L/kDTU7ipQjyxKMzTZKboPxlO3aVuXhR0JHu3JzUWNCqSNwABBd03CgUisfWjETc8N1tRvmuy1EvBMwDirAnuWpbL5W5ZsiSH9X0T9mXXfK3X6ppdGHsA25rYazRAmzoupenVgCELE0Jzphxy0TFvbM0/NuNnxO/hPezqj9VClHz5nhrW66sadlEPUN58myIYFUxV8qvsY8Dxth58nobfYlanrNmoh/sBzLCFluvJZ+JY7hPDDGtjJvB9ktVRCoksy8yXo+KIngQqRySTS5YtfWWxWwbh0HQ+uLbp4y71oOnXWiw7vtWMhQsylfZCOYCSMfDXDzLCjrYLafzHCRbKxdZb4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E507D9C68F4BD49A1131BFF0A102E2A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 N028gt2JTIZNw1VC/bsD2h6EHaj3M5bHZ3mG0cKEanpINIEyH4ES8i6f/0pudehLlZH/fV3bo9L+MxzKY6MQs5yywAVADUdzYUcgTwdxnw1vfjUcB4p3mGngXXal5m0qW/r4gY4IG+ZP5ichcLJt8P41orBBjXyfgJGvcUUz4G1bzU2t5SuMUQrcgxMvTz5/sjcSpSDG/hGNbMNNfqeY/urMwVQxNVEsxL1OtVzlKnO0cS+w5lYb38OxmkQRhAAHdEKWHwSQ4L+z3OE5hnQMsY+FoWOKqNS683ZB2hKp+q17sc+E7/wZ9j3Jh5bh+HnIwNjqj42UMbXDnKYAmA2dUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ed49c6533529439f81168abe2418dbcb:solidrun,office365_emails,sent,inline:5fe62c288d9ebe6d23bc11618dd9b0a3
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	83763f06-d59a-4ed4-9ddb-08de81c2d892
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|82310400026|36860700016|7416014|376014|14060799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4f16rca/mBBfNRRF1VFShS3V5LOJKmUUAGz2adqxlIHACYWZtOxBetbkpDvofiHuHn1NKBkKTaB/ik883BAU5RCE3VG+bvanK/XNFMHxetY3gB6C8lB5kE1db39iNrbM8EebWLDv3+fPvQmKu9D387YefWDzKQdzv+NSr/0B6rXv8MMEq0pPtZkgI1fMCRb28viTsOgzAc5P9NodI+3t+sGP4nxaubEO+GcYXvYaWkTjMUPQ8pFcKWVxr9GjyoI1c+OZHWTjkcuS+KsD50OWLdfgGBhNlZgD5A1m1CerleJbyU0TG5ISwmXxIMtnbZEjEs06H1WDl6HHJHv0UTEQ8wfdrTSdSjAYcXN0LgmFVH8yj3PpTv+Bkx+njFtu0oq3JDUISWCRJlHiACMfKkI6cLiXOCIEaQ7LxamklaMkwYLI1TrdqcCN1/YflnmLAMqsfIOp7hkxYoyzQyvYV0rrbfcQt8cWTRDzKZM1KGL85lXzirgGxFbmD0E2X0AQouxJ5naYgAIoSH9PSGoR02W7Xq8OcjLxbkQqqrECLJO/Upnt9PDMYpe8L+Y4jNoJqCdIQxPHPyEjGW/G2Z6h58cj1GYjRyyKwlzVpOFHOLQbAFTkoMfybrqpLieKApdbGvL/7YK8Wj25UUtYayxrB7pnBpdU8rxsgnjnvRbzThWoCCtnpjO8zr3UQJGcno0kkE6h89xsozyBOmlVPXoQ4vrY9HxVw5oX1nkCyTjTmL7O7GI0IhPGuBU6c80WL19QgO0v2bmw61mAl8CAgNpEx/jzfQ==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(82310400026)(36860700016)(7416014)(376014)(14060799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xNXuMB7nRen0aZ6uLaC8m7VCi80FCud5DFyUbyCUEFzODTVsomZoIdv04VyUGLu8U2YtrBpcBGIMwdALAxkari8JjhmlGBGu1Kck97ylU6+X68EpoD+nOSZ5MKXyrOh9HJZEh5m5Rt1g5pW8w11DWKuNbScEFbccnHy9UIlRbWJv43aBV57Y4Q0CObUaJvAunL44OjUXbmI2Xm/A0Ya3Hl9GxkrGmfKViCEISsjgrkoTEXS54khzxB84C7Y6jat890qeG2LZhnFDqWMOahViU1TVyI21a+kBwTewCNaSh1xof/foqkCqdHudTn0VCugxE/IeYPp1OmfHpObZRlhxDfKDo2KpzQJF7T0xmazHBHNz7lkaoWGOU2QphBplVNa26eVkVZUdQ9zBGqH0AGKMTvlHvy6BNhRFZ+HMAv9wWGIuX8pSuCyp+nnLTAkNjQMn
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 12:12:06.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e521ec0-bd5e-486b-d14c-08de81c2e92b
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12540
X-Spamd-Result: default: False [1.54 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225419-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.51:email,0.0.0.0:email,0.0.0.15:email,6f:email,solidrn.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solid-run.com:email,solid-run.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0D2E528D0C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQpBbSAxNC4wMy4yNiB1bSAxMzowNSBzY2hyaWViIEpvc3VhIE1heWVyOg0KPiBDb21taXQgOGEx
MzY1YzdiYmMxICgiYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHBpbm11eCBhbmQgaTJjIGdwaW8g
dG8NCj4gc3VwcG9ydCBidXMgcmVjb3ZlcnkiKSBpbnRyb2R1Y2VkIHBpbm11eCBub2RlcyBmb3Ig
bHgyMTYwIGkyYw0KPiBpbnRlcmZhY2VzLCBhbGxvd2luZyBydW50aW1lIGNoYW5nZSBiZXR3ZWVu
IGkyYyBhbmQgZ3BpbyBmdW5jdGlvbnMNCj4gaW1wbGVtZW50aW5nIGJ1cyByZWNvdmVyeS4NCj4N
Cj4gSG93ZXZlciwgdGhlIGR5bmFtaWMgY29uZmlndXJhdGlvbiBhcmVhIChvdmVyd3JpdGUgTVVY
KSB1c2VkIGJ5IHRoZQ0KPiBwaW5jdHJsLXNpbmdsZSBkcml2ZXIgaW5pdGlhbGx5IHJlYWRzIGFz
IHplcm8gYW5kIGRvZXMgbm90IHJlZmxlY3QgdGhlDQo+IGFjdHVhbCBoYXJkd2FyZSBzdGF0ZSBz
ZXQgYnkgdGhlIFJlc2V0IENvbmZpZ3VyYXRpb24gV29yZCAoUkNXKSBhdA0KPiBwb3dlci1vbi4N
Cj4NCj4gQmVjYXVzZSBtdWx0aXBsZSBncm91cHMgb2YgcGlucyBhcmUgY29uZmlndXJlZCBmcm9t
IGEgc2luZ2xlIDMyLWJpdA0KPiByZWdpc3RlciwgdGhlIGZpcnN0IHdyaXRlIGZyb20gdGhlIHBp
bmN0cmwgZHJpdmVyIHVuaW50ZW50aW9uYWxseSBjbGVhcnMNCj4gYWxsIG90aGVyIGJpdHMgdG8g
emVyby4NCj4NCj4gRm9yIGV4YW1wbGUsIG9uIHRoZSBMWDIxNjJBIENsZWFyZm9nLCBSQ1dTUjEy
IGlzIGluaXRpYWxpemVkIHRvDQo+IDB4MDgwMDAwMDYuIFdoZW4gYW55IGkyYyBwaW5tdXggaXMg
YXBwbGllZCwgaXQgY2xlYXJzIGFsbCBvdGhlciBmaWVsZHMuDQo+IFRoaXMgaW5hZHZlcnRlbnRs
eSBkaXNhYmxlcyBTRCBjYXJkLWRldGVjdCAoSUlDMl9QTVVYKSBhbmQgc29tZSBHUElPcw0KPiAo
U0RIQzFfRElSX1BNVVgpOg0KPg0KPiBMWDIxNjItQ0YgUkNXU1IxMjogMGIwMDAwMTAwMDAwMDAw
MDAwIDAwMDAwMDAwMDAwMDAxMTANCj4gSUlDMl9QTVVYICAgICAgICAgICAgICB8fHwgICB8fHwg
ICB8fCB8ICAgfHx8ICAgfHx8WFhYIDogSTJDL0dQSU8vQ0QtV1ANCj4gU0RIQzFfRElSX1BNVVgg
ICAgICAgICBYWFggICB8fHwgICB8fCB8ICAgfHx8ICAgfHx8ICAgIDogU0RIQy9HUElPL1NQSQ0K
Pg0KPiBSZXZlcnRpbmcgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbiB3YXMgY29uc2lkZXJlZCBidXQg
YnVzIHJlY292ZXJ5IGlzIGFuDQo+IGltcG9ydGFudCBmZWF0dXJlLg0KPg0KPiBJbnN0ZWFkIGFk
ZCBwaW5tdXggbm9kZXMgZm9yIHRob3NlIHBpbnMgdGhhdCB3ZXJlIHVuaW50ZW50aW9uYWxseQ0K
PiByZWNvbmZpZ3VyZWQgb24gU29saWRSdW4gTFgyMTYwQSBDbGVhcmZvZy1DWCBhbmQgTFgyMTYy
QSBDbGVhcmZvZw0KPiBib2FyZHMuDQo+DQo+IEZpeGVzOiA4YTEzNjVjN2JiYzEgKCJhcm02NDog
ZHRzOiBseDIxNjBhOiBhZGQgcGlubXV4IGFuZCBpMmMgZ3BpbyB0byBzdXBwb3J0IGJ1cyByZWNv
dmVyeSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEpv
c3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiAtLS0NCj4gIC4uLi9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpIHwgIDcgKysrKysrKw0KPiAgLi4u
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4LmR0c2kgICAgfCAgMiArKw0K
PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
eDIxNjJhLWNsZWFyZm9nLmR0cyAgICB8ICAyICsrDQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjJhLXNyLXNvbS5kdHNpICAgICB8ICA3ICsrKysrKysNCj4gIDUgZmlsZXMgY2hh
bmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpDQo+IGluZGV4IGVlYzJjZDZjNmQzMmEu
LjdmNmUzOWUyN2NlNWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjBhLWNleDcuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHgyMTYwYS1jZXg3LmR0c2kNCj4gQEAgLTE2Miw2ICsxNjIsOCBAQCBydGNA
NTEgew0KPiAgfTsNCj4gIA0KPiAgJmZzcGkgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+ICsJcGluY3RybC0wID0gPCZmc3BpX2RhdGE3NF9waW5zPiwgPCZmc3BpX2RhdGEzMF9w
aW5zPiwgPCZmc3BpX2Rxc19zY2tfY3MxMF9waW5zPjsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+
ICANCj4gIAlmbGFzaEAwIHsNCj4gQEAgLTE3Nyw2ICsxNzksMTEgQEAgZmxhc2hAMCB7DQo+ICAJ
fTsNCj4gIH07DQo+ICANCj4gKyZwaW5tdXhfaTJjcnYgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZncGlvMF8xNF8xMl9waW5zPjsNCj4gK307DQo+
ICsNCj4gICZ1c2IwIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4
LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1jbGVhcmZv
Zy1pdHguZHRzaQ0KPiBpbmRleCBhZjYyNThiMmZlODI2Li41ODBlZTliMzAyNmUzIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1jbGVhcmZv
Zy1pdHguZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgy
MTYwYS1jbGVhcmZvZy1pdHguZHRzaQ0KPiBAQCAtODksNiArODksOCBAQCAmZW1kaW8yIHsNCj4g
IH07DQo+ICANCj4gICZlc2RoYzAgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
ICsJcGluY3RybC0wID0gPCZlc2RoYzBfY2Rfd3BfcGlucz4sIDwmZXNkaGMwX2NtZF9kYXRhMzBf
Y2xrX3ZzZWxfcGlucz47DQo+ICAJc2QtdWhzLXNkcjEwNDsNCj4gIAlzZC11aHMtc2RyNTA7DQo+
ICAJc2QtdWhzLXNkcjI1Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1seDIxNjBhLmR0c2kNCj4gaW5kZXggODUzYjAxNDUyODEzYS4uYWY3NGU3N2VmYWJjNSAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRz
aQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNp
DQo+IEBAIC0xNzIxLDYgKzE3MjEsMTAgQEAgaTJjMV9zY2xfZ3BpbzogaTJjMS1zY2wtZ3Bpby1w
aW5zIHsNCj4gIAkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAweDEgMHg3PjsNCj4gIAkJ
CX07DQo+ICANCj4gKwkJCWVzZGhjMF9jZF93cF9waW5zOiBpaWMyLXNkaGMtcGlucyB7DQo+ICsJ
CQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgMHg2IDB4Nz47DQo+ICsJCQl9Ow0KPiArDQo+
ICAJCQlpMmMyX3NjbDogaTJjMi1zY2wtcGlucyB7DQo+ICAJCQkJcGluY3RybC1zaW5nbGUsYml0
cyA9IDwweDAgMCAoMHg3IDw8IDMpPjsNCj4gIAkJCX07DQo+IEBAIC0xNzUzLDYgKzE3NTcsMjYg
QEAgaTJjNV9zY2xfZ3BpbzogaTJjNS1zY2wtZ3Bpby1waW5zIHsNCj4gIAkJCQlwaW5jdHJsLXNp
bmdsZSxiaXRzID0gPDB4MCAoMHgxIDw8IDEyKSAoMHg3IDw8IDEyKT47DQo+ICAJCQl9Ow0KPiAg
DQo+ICsJCQlmc3BpX2RhdGE3NF9waW5zOiB4c3BpMS1kYXRhNzQtcGlucyB7DQo+ICsJCQkJcGlu
Y3RybC1zaW5nbGUsYml0cyA9IDwweDAgMHgwICgweDcgPDwgMTUpPjsNCj4gKwkJCX07DQo+ICsN
Cj4gKwkJCWZzcGlfZGF0YTMwX3BpbnM6IHhzcGkxLWRhdGEzMC1waW5zIHsNCj4gKwkJCQlwaW5j
dHJsLXNpbmdsZSxiaXRzID0gPDB4MCAweDAgKDB4NyA8PCAxOCk+Ow0KPiArCQkJfTsNCj4gKw0K
PiArCQkJZnNwaV9kcXNfc2NrX2NzMTBfcGluczogeHNwaTEtYmFzZS1waW5zIHsNCj4gKwkJCQlw
aW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAweDAgKDB4NyA8PCAyMSk+Ow0KPiArCQkJfTsNCj4g
Kw0KPiArCQkJZXNkaGMwX2NtZF9kYXRhMzBfY2xrX3ZzZWxfcGluczogc2RoYzEtYmFzZS1zZGhj
LXZzZWwtcGlucyB7DQo+ICsJCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgMHgwICgweDcg
PDwgMjQpPjsNCj4gKwkJCX07DQpTaW5jZSB4c3BpMSBhbmQgc2RoYzEtYmFzZSBwaW5zIGJpdHMg
YXJlIHNldCB6ZXJvIGhlcmUsIEkgd29uZGVyIGlmIHRoaXMgcGF0Y2ggZm9yIHN0YWJsZQ0Kc2hv
dWxkIGxpbWl0IHRvIGp1c3QgdGhlIG5vbi16ZXJvIGVzZGhjMF9jZF93cF9waW5zIGFuZCBncGlv
MF8xNF8xMl9waW5zLg0KDQpCdXQgdGhlbiBJIG5lZWQgYW5vdGhlciBzZXBhcmF0ZSBwYXRjaCBs
aW5raW5nIHRoZW0gdG8gdGhlIGJvYXJkIGR0cy4NCg0KUGVyc29uYWxseSBJIHByZWZlciB0byBl
eHBsaWNpdGx5IHNldCBhbGwgYml0cywgaW5jbHVkaW5nIHplcm8sIGFsc28gZm9yIHN0YWJsZS4N
Cg0KPiArDQo+ICsJCQlncGlvMF8xNF8xMl9waW5zOiBzZGhjMS1kaXItZ3Bpby1waW5zIHsNCj4g
KwkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAoMHgxIDw8IDI3KSAoMHg3IDw8IDI3KT47
DQo+ICsJCQl9Ow0KPiArDQo+ICAJCQlpMmM2X3NjbDogaTJjNi1zY2wtcGlucyB7DQo+ICAJCQkJ
cGluY3RybC1zaW5nbGUsYml0cyA9IDwweDQgMHgyIDB4Nz47DQo+ICAJCQl9Ow0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xlYXJmb2cu
ZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xlYXJmb2cu
ZHRzDQo+IGluZGV4IGVhZmVmODcxOGEwZmUuLjg5MjAzMjZhMDY3MzUgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjJhLWNsZWFyZm9nLmR0cw0K
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1jbGVhcmZv
Zy5kdHMNCj4gQEAgLTIyMyw2ICsyMjMsOCBAQCBldGhlcm5ldF9waHk4OiBldGhlcm5ldC1waHlA
MTUgew0KPiAgfTsNCj4gIA0KPiAgJmVzZGhjMCB7DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8JmVzZGhjMF9jZF93cF9waW5zPiwgPCZlc2RoYzBfY21k
X2RhdGEzMF9jbGtfdnNlbF9waW5zPjsNCj4gIAlzZC11aHMtc2RyMTA0Ow0KPiAgCXNkLXVocy1z
ZHI1MDsNCj4gIAlzZC11aHMtc2RyMjU7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1zci1zb20uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1seDIxNjJhLXNyLXNvbS5kdHNpDQo+IGluZGV4IGU5MTQyOTFlNjNh
MWEuLmUxMzQ0OTQyZWFhZWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjJhLXNyLXNvbS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1seDIxNjJhLXNyLXNvbS5kdHNpDQo+IEBAIC0zMCw2ICszMCw4IEBA
ICZlc2RoYzEgew0KPiAgfTsNCj4gIA0KPiAgJmZzcGkgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZmc3BpX2RhdGE3NF9waW5zPiwgPCZmc3BpX2Rh
dGEzMF9waW5zPiwgPCZmc3BpX2Rxc19zY2tfY3MxMF9waW5zPjsNCj4gIAlzdGF0dXMgPSAib2th
eSI7DQo+ICANCj4gIAlmbGFzaEAwIHsNCj4gQEAgLTgwLDMgKzgyLDggQEAgcnRjQDZmIHsNCj4g
IAkJcmVnID0gPDB4NmY+Ow0KPiAgCX07DQo+ICB9Ow0KPiArDQo+ICsmcGlubXV4X2kyY3J2IHsN
Cj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtMCA9IDwmZ3BpbzBf
MTRfMTJfcGlucz47DQo+ICt9Ow0KPg==

