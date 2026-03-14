Return-Path: <stable+bounces-225418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L+NOY1PtWm8zAAAu9opvQ
	(envelope-from <stable+bounces-225418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F9428D02B
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72666305C8CF
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93D317173;
	Sat, 14 Mar 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kC7t9nJX";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kC7t9nJX"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023132.outbound.protection.outlook.com [52.101.83.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3372DC321;
	Sat, 14 Mar 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489940; cv=fail; b=j3ObvPj1mev0D5W+Hh4zJEkhi2TtxKfXLPdGdW88lFKmcMTgndjb0TeMlBEcsPQS73Y7+Q9niypb+9wU5s5W3y4PNQ4nHM/V1xRaHsBT3doMcFhkOwWO0IWdyLw6wcleCNt0IhJmXOv6Qkf02PatN/9aui6a23cHuI1O12GJHrk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489940; c=relaxed/simple;
	bh=dRoWXTwMeY/Igu2JTmZjG+j1aWB3FtKlFWcU7SuRIGs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=RFOMYZPtCr6KGtOMDooIt3Yq70QEHEMCrvplupsSVFtobPJopvTjs/OQ2Fvit5xW494EnEpdTABc7QFwEssorNuVtJdbccc+A0+13BV6pzGEFhkbN9prDJmRD1FGHmxibDLxmAHBw4tcM9aYHG7M4bQzhBES1AhSutSl9Z9hH6A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kC7t9nJX; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kC7t9nJX; arc=fail smtp.client-ip=52.101.83.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QtogQB9j3VO5+oBKzTBWGxekM5YvwWmrgwifgIc/N0PZXCIVaez8sCrKqDHiCD7Pv10rMFcaRsEyKXc44YwOcWIW2hpchSc0a2Yt+xDXw1w+JTp7fXryvH6KHUVGloISdUIH6m9Fl2q+BEFweyShqQbk0GqkXTDWdVmqE1EjNJIaBPb6c6WgohQ6Dlyhf0QQKdFySjbne4j+W1WkV8j1jwBjdsqwXiajKquaVGLTYrbsb+dhKOvwLOcsmzZuyEmXfY2GfQ6vrZRO2OvS9wivQaKioMhMafmFkzBI4WUC0C0asMAS1pn1fRM0ATfB7+RLLt8yvqek87td79h/iGoY3g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHP5yODbQcm9rf9gZe9G1Y0FO1migGjxF5Jtzqt5o50=;
 b=apJ4NZS4HKKjoJxvsAd7ibjpvpigWwTbwdHK6C+Rm8WU0WvuvjbBKDb+g47VHL2xsKoDX8mLy/poDMPohaICCbgb8TUI/mUl5W0SjEHrW6csZCTjpfqPV1QRrLY83DW2nQPxDsGTWf/9JzcdSmT7vaujWELZWBninvAsMmF2VbPkEZN6gAuEH7ed4JVzQMiIcIo1ZG+93c+luR/6QftZopE4W/B4X39mITF+ehfif6H48nt/0lj+/L93XzYn4kwcSUseYU7yqVTWCn//yPiNOTtZG14JuJKJ93ZO3rpLYJYv1rqeydbIxTCM5VNcfmmNOrYYvjlQ/sh6b7+/MlnBHA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHP5yODbQcm9rf9gZe9G1Y0FO1migGjxF5Jtzqt5o50=;
 b=kC7t9nJX7hoMRkEJ5CQKNXU26di+GXLhxTuw3E/Uw6zgppn16xsBRY75dlGDAqd8If5DLmYVGzj3TYYPoYmM79yrcp4/RPmak9RC+xwmKWunxtOwWu6K2hbmvaiATB+LJ+b4P1h6WH9IzEWYjaiqEtydXorB1gUtKMWBTrSCOVY=
Received: from DU2PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:10:3b::15)
 by DBBPR04MB7803.eurprd04.prod.outlook.com (2603:10a6:10:1e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sat, 14 Mar
 2026 12:05:18 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::c7) by DU2PR04CA0010.outlook.office365.com
 (2603:10a6:10:3b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.18 via Frontend Transport; Sat,
 14 Mar 2026 12:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Sat, 14 Mar 2026 12:05:35 +0000
Received: from emails-4228018-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-180.eu-west-1.compute.internal [10.20.5.180])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B495F802A8;
	Sat, 14 Mar 2026 12:05:35 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sat Mar 14 12:05:28 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9P3AKHoC9S0WIykzUQZg7bbnKOQXvPjsnZ+T8bOrhmoWwGU2z+i0m95tdqgCJMEr7ZqUbNpqtPgI2J9wT1VCAgkW/r56PfHgBXB+CMqYs7zvGvxZ7ykgwdyWm3KXd5zUfw1+MTocZvUehXrqOb9ZTLqE+llAXfoNmkxZAMy9OTmG13dcseyRSHU0OarMgj3cDVYyioGKCQEZXR3UbUSaBp5jxPtnFij+QRcSqHjN6Fs0TVr1skUM+0WppEi4n35798qXhT2tTvNc2RoLQtJWr88s0pqR85rLCAjgKIZUylqbaxf7P0Arv9NOaoPawI+/0ZO2s/FJEPJw9UKphFJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHP5yODbQcm9rf9gZe9G1Y0FO1migGjxF5Jtzqt5o50=;
 b=him7O11r5aq4DHs7iHABs9BnPnncSCRyxjAgUE0Lun+E7lA70fALIaqTJMVSESOk8lkn/MtUAZ/kJTsw3ibcQNKZ6TSflwq5ZyuYDkMvHG5ZHntav2JGfN6ATwltKsm04k1+fVi9Gsr6kkDEWq3LMODmMcYrcr9eKlC4c4FfpC5XSOFcrnqXcJNCZu+HstPpzBBbywm4FkcdM+Y1GEIxGnQI6LfrAKXOm28CqG8FatSrkYCaPtuicb2CmKG28j7tS5asTf3XI6TeuUD5JRopjSgIDkEPmiH0Jy3XC2JxQ3h9sC34iNEtFg/OJzgcAwUiy4qUF+l/CmLRWW7nljOl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHP5yODbQcm9rf9gZe9G1Y0FO1migGjxF5Jtzqt5o50=;
 b=kC7t9nJX7hoMRkEJ5CQKNXU26di+GXLhxTuw3E/Uw6zgppn16xsBRY75dlGDAqd8If5DLmYVGzj3TYYPoYmM79yrcp4/RPmak9RC+xwmKWunxtOwWu6K2hbmvaiATB+LJ+b4P1h6WH9IzEWYjaiqEtydXorB1gUtKMWBTrSCOVY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 12:05:00 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9700.015; Sat, 14 Mar 2026
 12:05:00 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v5 00/10] arm64: dts: lx2160a: fix pinmux issues, update
 SolidRun boards
Date: Sat, 14 Mar 2026 13:05:10 +0100
Message-Id: <20260314-lx2160-sd-cd-v5-0-83de721585e3@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZOtWkC/23P0UrEMBAF0F9Z8uzIZCaJrU/+h/iQZhI3sLZLo
 mFl6b+bLQiy9vEO3MOdq6qx5FjV8+GqSmy55mXuwT4cVDj6+T1Clp4VITlkNHC6kHYIVSAI8Mh
 6HJBl8KJ65VxiypeNe33r+Zjr51K+N73p21UlpmAtWWDtCIzvyjBggHFMwThh71he6nLKAuVrf
 gzLh7pJjbZ2n2HxSd/NaAQa+rzgZBrN5HAP4F9g54/GgCAxGkvsEGPaA8wfQPMdYDrg/RQSMaY
 p/QPWdf0B8fO+CWwBAAA=
X-Change-ID: 20260304-lx2160-sd-cd-39319803d8ad
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM7PR04MB6805:EE_|DB1PEPF000509E3:EE_|DBBPR04MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d022e38-56b9-4539-886a-08de81c20020
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 hNxysh3LK9830upuMMRHnY98Njvk1TChhXrmMA0CKF1SXlNVedyRk6Z2Wb5SfgvEy/WWKb9EcgF4w3w6ZNUYLYOJKAcmAwr4po+tx5zBkcIs2I0gr5KBQsLJCBF2ieK6/DNhpUPLK755ITEnGbejhmJMrTsyQsl9mYcrkoypPL6GcO3i/h2gEKm2Ro/r7cCEsgHYnS95TTGQa0expNWtCI4yQ1oB1As/2YeqIaSGoL/KpWISVrVWRA2NjqegapB3aVWAyjV0UbOOoytQURo25xHNNM61iCzJOCec5jA9TvU85m4xQO6le5b6fv6FeATRWCrmQIsIr6f965tKv0pVaxdx++o50kryW3fDjBycuXvLQxx8wSegaHh4doPChIu8fhKoajeKbRd61/+c358SfZiUnby148BrTYruQPAz6DaWnPXdNIUnBFWAU2sfkpie4sgQa+lfw262+EPDKiu1l0S8fbTFcX22D7CM2Zb/eMN3CvVItroecwAFEuHHpPSoIYmUscUScdPeDnAZtDjXNUZmv4m7ELuY9+/jrNnFcz8ZPo2qJGUFAmOB5xDSN+ZyAcIeTNBKCP7QiOPcAjS2ETxM5r8b4iv2PbKw99ZO3X0+N4RxNw+ckoVBZ6j3wsrBOuOxczmo+jhJAOwrTfEunVfRswKc69XrMZZsyPkdetn4CdGhNhbi78leQinGRvSebGK0PtSM30g5IWcgZtWyEUsHRpURoGCbKJEpZNWfTmCusbRl0S35l/7dYBevoq4t1QLV0aBMbq43qIfwH57lrkewx18XFXe0Sc3H9eSlyg4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 s/XhZ8Wn8jJguFZuqFLXBJAj3NZ6BHrPZlxE3LrCyzGN/3BQQtQ6AbjoLTP2IPbG/cV6usVUErFOLO2fv8RZ473z+BUSPUSaw0vdb0YDk20Iq5VIQUSBr7WYOI6TnbiNXhytj0ON7faT/h5IeEeIhlG4OwkybUFKyHl1q/arUr3qHC5hZlnk4R89NiI7GWuQO3CE8q01jeOdOT0ll3QsoQ1fC5LodJ9pq3kQ8akCWYuEvvsp1C2idJ/zhCE3PPWor8do2xD5Ar3YmG88sGq5LqzFhADAREElLSI/wUPDOtN4I51r3vhjVBcTlL1FVtPnK2EbfnBzbwT4vO+V/IcBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 60bf9bf86e59454da5aea18592de02e8:solidrun,office365_emails,sent,inline:b584d2d6c8d2dfe2d0d28b1b1905f14d
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b2ef92be-d174-4eb6-c62d-08de81c1ead1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|35042699022|7416014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PU531TGjGE+hFWhgkZO6wAXLkPuP2Yy3dWfPacuqbD6sNIxwOoibzLwWknFfREZI67+VaIz04deYLfa9aTB1WTDRaeH52hGWLli2D9lHRRgHtO8Fo04mfAusZN9pLnGqTe9UkQcUbPmdZy37osNxWmJ+4+6PT+3VOARTcg5OzkLggY9qV2CyjsQYWW3/fjGnR575OZSFSrNrEeRUG6wFAi5JsZvrt5uYIikUJSnpKmbNbVvG9qG3qaFdXRBGYmR8Onnbh/cC9Lprx4s7EkXpaQAMCHpweR+JhORr1s1TwdsFclcdVZX98+NG1fDx5/Agd+szPkRWEZjXfPao3NxcJ3gqWxUrDq6V82NwPTQ5WwVbpMjrzZ9sy4oA0ujQTeaPJ+TRtmjv8BVtXtthjbmjDonoRE9oW894SPVfh6RlfFx3oyDfzDTiEvju9zXaNTWq9Jip15sq5x3r/Vvt9DUISCRqjRqx6WvpEJcNNxLX8Uj69BjAI6v19ej1W3MwFVN09avZtq08526lEqvJFIKNZis7FC4KNIvK7JrVduF2SahhjcilPnaJcdxLWdIfuF3+D33f4p0FWWQRoCBbrfKT+FzfdehcgMBfvFWwj01tuCJB3qkHYZ7s7hitgvJmWHBsr3Vg7UPzf+wqCRFS/NDdwLA/fQCDBKHDHRbw9AHcSQ/Exg7rBNeUjgRSXgqTxQPCJ4uj5/H5oSPBtnKl9eBg1qi/4xH1xz3WDfdRjoHoU/RC0nVYp7JWQ51qsWatSjVBAxabSjxHERrk8DjwxNWv7g==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(35042699022)(7416014)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QpP2u09ow0vF6AfZtQJC7fqsMLdmzvt8guMEdLrk0iMnTW3mRIbPxMZJ6cfkmMm4Jh4CPYAqA1Xp6RVPmSZyvlxKOb1LjdNwRKRB9wAKf4Kp1pCB97/sMp4e4XEBmiaTxaULVWW7CS1sEskhwUkKz3b/UJ7x+hUpwl3bV0dg17CVJZ/FfZxH+NuhGw2fPMBGZBDrW6gS50kzRiOaG1KlIUMzWq/MMPjv2itv2ZvGBYiIljRrpgy9kynQW+xU3XD94zRb/wCuyEwxdzboA1ol0VS7CYl96OnCz2uv1eji1jjupkFvSoweszYbJsToI198RNZVs+cgeSwOHJSrQhb26KCXdNjoxAv+2fV5RbprJ7RMGNy2z6UDdrMyPnPJSmByM2hBh5bwKyUDF06meCpQao/azm1oLF129a7fC+lVPKaG62J85Et06BzkXOUCrvQL
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 12:05:35.8522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d022e38-56b9-4539-886a-08de81c20020
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7803
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225418-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 56F9428D02B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a bug with microsd card-detect & gpios pinmux on SolidRun
LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog.

Then make small additions to SolidRun board descriptions.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v5:
- simplified lengthy commit descriptions on patches 1 and 7.
  (Reported-by: Frank Li <Frank.li@nxp.com>)
- fixed i2c6 sda-gpios reference.
- Link to v4: https://lore.kernel.org/r/20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com

Changes in v4:
- separated each logical change into its own commit, improving
  readability for reviewers.
- Link to v3: https://lore.kernel.org/r/20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com

Changes in v3:
- added separate patch providing all pinmux nodes for RCWSR12 register
- abandoned revert strategy, implement minimal fix for solidrun boards
  only.
- Link to v2: https://lore.kernel.org/r/20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com

Changes in v2:
- changed to revert problematic commit, workaround is large effort
- Link to v1: https://lore.kernel.org/r/f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com

---
Josua Mayer (10):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux
      arm64: dts: lx2160a: change i2c0 (iic1) pinmux mask to one bit
      arm64: dts: lx2160a: remove duplicate pinmux nodes
      arm64: dts: lx2160a: rename pinmux nodes for readability
      arm64: dts: lx2160a: add sda gpio references for i2c bus recovery
      arm64: dts: lx2160a: change zeros to hexadecimal in pinmux nodes
      arm64: dts: lx2160a: complete pinmux for rcwsr12 configuration word
      arm64: dts: lx2160a-cex7: add rtc alias
      arm64: dts: lx2162a-sr-som: add crypto & rtc aliases, model
      arm64: dts: lx2162a-clearfog: set sfp connector leds function and source

 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  10 +-
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |   2 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 183 ++++++++++++++++-----
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  10 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  19 ++-
 5 files changed, 180 insertions(+), 44 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260304-lx2160-sd-cd-39319803d8ad

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


