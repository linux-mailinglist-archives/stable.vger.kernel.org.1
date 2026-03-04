Return-Path: <stable+bounces-223033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJH8FsgVqGnUngAAu9opvQ
	(envelope-from <stable+bounces-223033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:21:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CFA1FEE21
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D347300D770
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D43ACA74;
	Wed,  4 Mar 2026 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NZcqUBcN";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="NZcqUBcN"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022092.outbound.protection.outlook.com [52.101.66.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2DC39D6FB;
	Wed,  4 Mar 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.92
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623298; cv=fail; b=d0qXrBAY+BeNyRnev5S+v2Ny9cUrmRK1Bxkt9VCJL56DqRzgDzjRU6QHSOjxjrq/yHVFg5N69SRYiuTk3MGhlU58ZCevg/oRgAuxYpoaL4kQevPcAthpTzhB5/aC+kpM70b5+RUd6CFLDQzv5dE6YecuSh8BYLXDyPvaGYxrJuc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623298; c=relaxed/simple;
	bh=ZUUaG2KeZvrciSuuFmbQhC+AUaJVvel1gxdP2aDrIUw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=opXygMXpRyCGhPIqGqP4H4MKSgU6e5JfVMYK38ix38dscs+x9+8kcfk4xDla9YsYtDIMEO5kMub9nIq9zMYgCtBSCS2fLeWHyrvfLD5CPAXaH3N9bfHuhn9z1OW47sKYaV0MqkdIQhg+3HR2zOxApG/Lg+pmCdtnZL3LfhyazDA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NZcqUBcN; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=NZcqUBcN; arc=fail smtp.client-ip=52.101.66.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TLtq0caqaQ3DYqiA875oF0pHcKx3qY9RbrRoo3u6u4GrHA5N3gTacEEd2IOy/4L7FDTLOdgK8j+TDQ7OJi/EcXLedLOEc1zW34wnvMmTIA8a9dEaVKtb3pllDfcfcyZIHrSpC6GRIrj899cx+RSP948DA2BgHkG89tJHycasRPrtPuUe17pYv/kyG/UfRV/jXs70o6g2Pwa1m78waXWaJah7oRDN0xO5faTi+Gy5OR2KjiydEtfknhaPRiw98rmcz7my1lhYk1FDOtNhet9ulRfUbFkrrnIqDEyqgU3i74x42W2Ws2NR6GbZ9OyuLdjMoiRb3PI5gK9y651jxkbAww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbuAqYpTwGUXvOeZ6+HDxPxZ52fmO9A41/gy1+RbTe8=;
 b=Gjkf1nVDQjL7LjBPmFVNwSwXtKvqRdvbyhEXyz4gh1PvM/SPH2bTSFRdi52tsW+fDPl0udbiWX/1eTEQ09kgzCYqZdDubIO/siHObSIKe4k/P890wsdChC1FNNb/QOhS7cHtPPz2ourrZKy5LYykN5uK0YjaGNZzXpDb4m3TbStMUUvCTFpdDMxKhHvwXeBnpLVFfqLaqhy49u7MOVXJkniFy/yBzOOJI6UKozhw6uAe3d3B3pUGoilSRUKCV8lRaJScWgoTJDS0n2W3L/Lji8emiCf0pMnPtj5NElNTi13pNU7ok+Pa0ai09tvQt1ov8jtve0CQrO820/VphOmvNA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbuAqYpTwGUXvOeZ6+HDxPxZ52fmO9A41/gy1+RbTe8=;
 b=NZcqUBcNbozHNX1R1au+cXZfchdH8VGPgKwg3p3mBqn+VNRUo3UfFrEFU/xv7SR1X5kalYKwEuJ2tw4HieBbnAxuEzvL3UJUybnmZU65/+Urrve27/6lmy9n30DO3XE7uYowEkqUl3CQwHz4aA/wp4ZsBTEIyhHUGTcz7uz4c8Y=
Received: from AS4P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::10)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 4 Mar
 2026 11:21:33 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::cf) by AS4P195CA0014.outlook.office365.com
 (2603:10a6:20b:5e2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 11:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 4 Mar 2026 11:21:33 +0000
Received: from emails-2187859-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-166.eu-west-1.compute.internal [10.20.5.166])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 0F7A8806A3;
	Wed,  4 Mar 2026 11:21:33 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Mar  4 11:21:24 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xtur4UfOt1TUqmwQgopp6SP8xCKQ9wWXfGXMvXBoueHiTwCCfMGPeRXknIWrgoI4c8JNwa/RQ65dzWFnn6TbGw8DlLrwP1Fqwr5sF3adrVal67ZLVZy6X0OqMcFSJgNBETb5sK227YFfJr8Q9/HZF+GL7t7Ria3qLc0ndPjQf0X6CamGMX9nN3iv42px4DlMBsRw2AbmdCyy36ILhYE9jnvw8NII+v5ZHtTV9AjZypjuNslsn9fioVTmEY8MRoSufc3MGr8qZhsvnNit9w7kepDuTyH72omVIxbrP1ZSV1Q48D167pkzBYYPp8E+i0hPGdOYgD+uwlCM2jPSS2yFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbuAqYpTwGUXvOeZ6+HDxPxZ52fmO9A41/gy1+RbTe8=;
 b=TJ2v0OlfYaH9UdFx5wG0kTvIvy3ZUDr/D+eBuQF7Ae09iJ6/FULKIiyOuN/3t/6tYukGfFkOmcf14Wxcx9wgOJlm45BUG3zj3b4Kctw/GPgSsqNvmCHnn8cHFGEgrmUOpFikwVdBenUK6lJ6/t9eq3wOnoXrih9OKazINx7Nj109sOZJ4ErMfuEg+Cf5rKlGzph4gwK348qQAfe41WySl+H1P5dPlBkDBMBdII2/ghv9kvo2lpMvJSkspqxICGT3BOd7Zdog1EBQxfqsSdkAo9/wvU0bCK0OO/nfA0AwUzww8cwWurXyKxYD3fno8PooxhhetRDaSiN/Z3U8Sn/8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbuAqYpTwGUXvOeZ6+HDxPxZ52fmO9A41/gy1+RbTe8=;
 b=NZcqUBcNbozHNX1R1au+cXZfchdH8VGPgKwg3p3mBqn+VNRUo3UfFrEFU/xv7SR1X5kalYKwEuJ2tw4HieBbnAxuEzvL3UJUybnmZU65/+Urrve27/6lmy9n30DO3XE7uYowEkqUl3CQwHz4aA/wp4ZsBTEIyhHUGTcz7uz4c8Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 11:21:17 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:21:17 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/5] arm64: dts: lx2160a: fix pinmux issues, update
 solidrun boards
Date: Wed, 04 Mar 2026 12:21:12 +0100
Message-Id: <20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgVqGkC/12OwQ6DIBAFf8Vw7jbAKoWe+h9ND8hiJbHSQGtsj
 P9e9OhxXvIms7DsU/CZXauFJT+FHOJYAE8Vc70dnx4CFWaSS8WR1zDMUigOmcARoEFhNEfSlli
 5vJPvwrzr7o/CfcifmH67fRLbyjqUrmlkAyiUhNoWi9bcgTGdqxWhVUi3HIdAkL7j2cUX20yT3
 N8lo+EXcciYJAgoeU5Ra+pW8aNgXdc/pRYAMuoAAAA=
X-Change-ID: 20260304-lx2160-sd-cd-39319803d8ad
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
	PAXPR04MB8749:EE_|VI2PR04MB10979:EE_|AMS0EPF000001A4:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: f34a8247-8e69-4a41-d991-08de79e030ec
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 VikBYdh2fwvdFexo8g1M0CqQLMms4ongCJaOeuI6c1VwKxXJpp+XR/rmhnhPSUQ4907K0OPrrW3uohLXpGCNiYPsq767QLx/VeYDeCccBrDS5JxCMrHab7zyn0iISc/pafPbQtvKj9frHcp4jzXKsMW2sEvtb0wZd/jTUIdX9MLBmNK58vzq9e0zXKUxTjZOWC7xGJ68gNskT81wKcrGyH0Z4SDouHQDTWQhT4sX3OECnMeFmpGhxOmOcf2imCgdEEGnm5R2amiArtdA7B1+ShcOGfwuVTLCZeHn3i/Fe12TeSH+bWI+iku/K9eqIArcLcSy91pZ2cB3ONKWPcv7Yehv3eJyHz4IMrJt9I775s63PM3lQq0qRbJz/QvLBAPN6/iFNH5uCQn2ojkAab0CY/TemGPg7CTl2t96oL/HSacrE69lkAXrMnuH+ERIr/+cB+JX+51YeL6YbT+KFEY2DNjWP0CRljdxRotB4ztGbZ/XrzvG0bV7qkT7rcZSc5L/Y4eAH//czYrw7JQcgncaY2/0wa9A1B61+zH8G8IMqPEQevUgtniq1eJphMprcYyt1OdZT5/q2B8AlVpinvj8PQRZ55NEQFonk/rpRz3hrNnI6Xw2p/DFGZqFGQX+AAs7fsLBLFiBRzEZL3Rq6DomInbusmdlcCdlLMr6MUQlSqBwsiaeDW/DBbA5dsAitniXNAS5+25VtXcTgVsP8YlMXu9FIMwp9co1B6WON+k8mXvtnrBnwbyMQhl2YMrPDjidjh7WymERwVR3XNfg7pY1ecbVI9poFVWfWNS7YkOkKbQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 5b9eff4662c642e0ab6a844882d5974d:solidrun,office365_emails,sent,inline:5f0b7cc6de19ce8620387e38676eea81
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	413c0f1e-2404-4427-aabb-08de79e02748
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|35042699022|376014|7416014|36860700016;
X-Microsoft-Antispam-Message-Info:
	iedelNdjO9EH/PbT/w3BoL2nxprtQv0ddImhfdHab8AW6aYYwnAawVs/4AA3cMGhHfQluQnSDppWq93hyyXgvMSaL70+Iuqg+Shv4AmpvZg/CdEMVXleZWGCHgmcE1k+5V8sYfw05e0BWeuytuAWyu/BURt07YAcHY+AfQUt8EaGx4LiipMKdUXCAieRZ/4L7iKdfdo9mRDNsOE3fDZQA3U2GmUi9lkC59TCheyIH+CUE4/ykT7Li9r4t/Gbwe84GdvnW5JZB0g/cTlsEvX/WMVFVOash3d0MjD7b1qTN1LwodA8K7pIJFW9IxHFbHKLOcJmX6bsi+G8RLb1dpigPYsF5jdR18a7A2R5QtF3w4hUXzt7VYYSmGNzibONiCYTI2wZngBBBSU63Sa2p27Hr51Gu37b74kbGOIlTE3RNNF8k0TwimpmMlnOShYnYKknfZztrhkKIzkEM1Cg6kd4tFwVC+9/DU+N1NHFmqh1D9kb0Ne2EnjZAS1Pl4/t/lrJUnU+XgD39hklRpFn/0GVTDPQ5ewrozFReQdaLqdOViwWQzVBv/0l8mPtumrjUT7fLKwlxTvPBLkMhDUaEVq1/WY2juzxRu7H0Th3jIep/sFycX/CLx2TK9FKpEavObQa/YjAsPAB++zXsJblWUV1UrBzC3soaTW5r79y9dGufNFM4WHSU1/I8VXesHhfNPL44t9vHsjfPO7oS+MUXT90R3aYzP88HJg2iXBXz4nkVTfs5Aa3PyPMm3oNB/6hWcOex+fKuhqZ6WBkh+RwQN7eGA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(35042699022)(376014)(7416014)(36860700016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kUn5qB/GeZnBRp+ugjf0lhLvrWV8XN/84Bh5sb7JtGZjmGB6qkYrQXdiUjqGNY196F2aCNBEOHb9JFASKQ0ZtHl0bbDTNq5nDEkIVba7GqfAJXimj1C6IlfT6NScqbQC3SDwwBswzldYO/FHbMxPRO9FKDhAYTBnZuK/gqeheLywviFbccl8JP4YPNh2cBou8ImEI1gvB2PxPoWZhwU624z2cW3AddbDBBU5mvBJKjIazk69XXkPufMjGzG11H/byY5iriXAP+9Ug5xnhwnDaG9FT953i0hjohy1JfH6hDq1TnqiKWWNLz5nC+JQI8K2MnmYMLUl9Lz7lwevlTRYfg3+hsc38vgfTOYRCFOfHBZ0Il4NsU4ZQ7KaydvpiAQugWHcGrQwzgr34opBqNCoXD5QOYM0JKmWjyOQjk3u6mu+qo2Kz4IqnRXbYjuIoWzz
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 11:21:33.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34a8247-8e69-4a41-d991-08de79e030ec
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092
X-Rspamd-Queue-Id: 44CFA1FEE21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223033-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Fix a bug with microsd card-detect & gpios pinmux on SolidRun
LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog.

Then make small additions to solidrun board dts.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v3:
- added separate patch providing all pinmux nodes for RCWSR12 register
- abandoned revert strategy, implement minimal fix for solidrun boards
  only.
- Link to v2: https://lore.kernel.org/r/20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com

Changes in v2:
- changed to revert problematic commit, workaround is large effort
- Link to v1: https://lore.kernel.org/r/f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com

---
Josua Mayer (5):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux
      arm64: dts: lx2160a: complete pinmux for rcwsr12 configuration word
      arm64: dts: fsl-lx2160a-cex7: add rtc alias
      arm64: dts: fsl-lx2162a-sr-som: add crypto & rtc aliases, model
      arm64: dts: lx2162a-clearfog: set sfp connector leds function and source

 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  10 +-
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |   2 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 175 ++++++++++++++++-----
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  10 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  19 ++-
 5 files changed, 176 insertions(+), 40 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260304-lx2160-sd-cd-39319803d8ad

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


