Return-Path: <stable+bounces-163428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E30B0AF0A
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3677B466E
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B02238D5A;
	Sat, 19 Jul 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dts8dxam";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="dts8dxam"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021122.outbound.protection.outlook.com [52.101.65.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA723816D;
	Sat, 19 Jul 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.122
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916491; cv=fail; b=c41HpghPYDtqlMGFaj2oPjwh4q2D8zDcZ9+BiaSNO5tmHjQVAQtR4M16qnjvCqIMxIjt/tC1kFmDxYq5Ox4FdKtmAAaQXtuubSwhDXAjuLRahJvf8du0vEtHeLHLd9UypK+BO/vb0Vub1N5n8/V4m8MbHn12OtNW7Wmk15ueFak=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916491; c=relaxed/simple;
	bh=TPiARo2Vph7iJ2Yqhz2hJFYctWwYPEomliy3ht4/vFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dtun3OltpSM4AG1I3X1p5Jc7onL6TZv/Je9GCpW3MyOVccuZzx+dK6v6Czk4/JoA6yEBJU1j/NxQuFeBOgiWvuaU4BmzeY9s3DxKqQ1qL7egvPI7LuMgqi6drJLQPMzYTGiNHOVjtRUES+0ZvcqcN6tzqyNRX5I1M0ueXwDsnIg=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dts8dxam; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=dts8dxam; arc=fail smtp.client-ip=52.101.65.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NkKuMvwVsmeT0q0zS06uKxfC7WKq5Cdm8qi+tjZJbkHBJ/UtZA+dlj3FFw8LXJ1m/LP1HZOxzErL22eF3hdq+9i2NeqwiSEKaSQi7q/EXOUs88HFNHVlvePkUpULZu1Tu7IJmKAuujHw5rLVEMMmq1S7oSCcIYvR8jFL4MLwB0dyN3SdWQbNygKlUr9xYk7d8q9FBOOKA/PurzpEyxPuGep7GkMu8zbkKicYm+kSWb4d58rmz44FUP0Gt1csfXjxIm4R17PQ2lC+7F2beOYYoDVqCbYl07UFL9wOOSLMuV0zgOrmhJBa8bBLojcP/EjvffAvYFSWk2fwcH2xGGvqHw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPiARo2Vph7iJ2Yqhz2hJFYctWwYPEomliy3ht4/vFI=;
 b=FNyd/ryjeGYcJZ4SeUsLLAWM/EruLiaYrMUlD8Y9aUOferLF64mMW5SKJwj1HeAjAVRGey3Yb+XQDo5RXn3NJlpZ5kneqqxWHu8+goo+uHFDvWltCnM7Q1Pv6txhn1L+DUWSUJhe+l18hVsNlgCI6h1vjtoO9yGR5l9tnTKJTznaITHB6tn0QGBkLd14sWtZXjciu9CLybghgZg8wBgFHdMZ7xIKPFcNzoq+s53Ty8aChWAubLZVlf22YfN8IFY4mJVToMka3REkFDOrMe1nISLKBoYx56PDWyB0sreLd1/285WGdgnHsoCYZd23WaR6SSKZaQiFTLZy/SEciFk83Q==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPiARo2Vph7iJ2Yqhz2hJFYctWwYPEomliy3ht4/vFI=;
 b=dts8dxamqLeG2zsbFz76Jt0c8BIsgaDFBgtaFfW/u/VSGVdKztY5fJ1bV9xlFYyEMJGpVmX0ai2GGRVYj97Qj8daIaJTcAChmZYsgUBagLw7LyVbDsYYZMsb4TrTgdLKd3MogzRBFCmvE8tZY+x36SyNZ4qNe8sf4d0fyQ4nPKk=
Received: from DU2P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::20)
 by DBBPR04MB7547.eurprd04.prod.outlook.com (2603:10a6:10:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Sat, 19 Jul
 2025 09:14:45 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::71) by DU2P251CA0022.outlook.office365.com
 (2603:10a6:10:230::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 09:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Sat, 19 Jul 2025 09:14:45 +0000
Received: from emails-5201702-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-142.eu-west-1.compute.internal [10.20.6.142])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 145C17FEDC;
	Sat, 19 Jul 2025 09:14:45 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1752916485; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=TPiARo2Vph7iJ2Yqhz2hJFYctWwYPEomliy3ht4/vFI=;
 b=fR3Z+rWz5+2rCv93kv365uZk8a26yNROv66A84toehySHzhpX1YsF73pGySm3DhGfiiOL
 oueorp+VgeWLNi2+vWomfLHSPSQf4+69Gza5J+BtkhL6XBKKYvi5aAwofadRJuAJUIkxSo1
 f//PMiKwU++4XVAAz+cedsgkxD4UQyQ=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1752916485;
 b=bl0+j3RA6/1FsbMXsigiIU5UP9pWupVJdyJAA4NriaDfjB2/NNSpbgLWomHQsdGnyzAjQ
 z+l2f+sTRFNlBhId8KS6iLoTJ5h8PJXV/P4mnpW7tR6u10wYWnigIb1bHjHepVbSP/JYP/B
 xB4jHdS8Al9U2ABf7Jbi54PP0IqB9Ig=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDds7mzzgBHzcQMY/pivYdbWd6mLLwUqBhDDadZ63v7O6ZB5HclZOpG4m7x6RL99vb59HReCbpYCggrGSAzGJcu2EU4ypf5zVXx2D+8e6ScKAWvu3KRSVodDEGZJbSbEr+WciBeUIIDL6B1YVruf8sDKjeH7CTnNk1Rpysl/gfjnTLU+84jQHltHo94o5uJDnXZFbI55lCaj9OCG1P8Ikh2gArus412PWB/P8n+rE4uANORwpC1H10ApsgeeXvUzOefoUFrOUynpurL+4FoyIhmJwBUhw3UkBulBFCTEvFnDVX4uy60Eph2FU7bYkDNfX2aVbsDbVT4ef381p85ePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPiARo2Vph7iJ2Yqhz2hJFYctWwYPEomliy3ht4/vFI=;
 b=d8vInOnG6yt2vKnCZfR3Rj8l0ZVne74jW1FPa2cwsx2HTM1Ns2XiQeqzVy0s/3+RPpmXTMIK+zSnCFOOjSouktWhj6KZRm8zhlJP/WSm76EI7MwIBEQvhidxHlB3ed99YIr80UOYUiVYTxlpDmyYv1OnmcralhefD0XzO6z1fEVxPcow70bHn7+pRmZoLAwVESF6nf/5ewKV4LsJtcd2kJ4fXpPnYNAlAyBVCtM6pAUmEkw6DjMY27+9Ibmij27B/oWcqGs8XFp4tBm43BdsjDnnnprYpS4sBByoMlxDs5yKBWOgPBJ27nyCcUNevsBXJmLml9FWo11ZiK9285TF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPiARo2Vph7iJ2Yqhz2hJFYctWwYPEomliy3ht4/vFI=;
 b=dts8dxamqLeG2zsbFz76Jt0c8BIsgaDFBgtaFfW/u/VSGVdKztY5fJ1bV9xlFYyEMJGpVmX0ai2GGRVYj97Qj8daIaJTcAChmZYsgUBagLw7LyVbDsYYZMsb4TrTgdLKd3MogzRBFCmvE8tZY+x36SyNZ4qNe8sf4d0fyQ4nPKk=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM0PR04MB6850.eurprd04.prod.outlook.com (2603:10a6:208:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Sat, 19 Jul
 2025 09:14:34 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.8943.028; Sat, 19 Jul 2025
 09:14:34 +0000
From: Josua Mayer <josua@solid-run.com>
To: Frank Li <Frank.li@nxp.com>
CC: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carlos
 Song <carlos.song@nxp.com>, Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury
	<rabeeh@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "arm64: dts: lx2160a: add pinmux and i2c gpio
 to support bus recovery"
Thread-Topic: [PATCH v2] Revert "arm64: dts: lx2160a: add pinmux and i2c gpio
 to support bus recovery"
Thread-Index: AQHb9JMaZj87L0MKoka7H2mzuoDVlLQxr6eAgAeCR4A=
Date: Sat, 19 Jul 2025 09:14:34 +0000
Message-ID: <14bda26b-932e-4a95-89a1-d308d27fb55f@solid-run.com>
References: <20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com>
 <aHUVc5SV3yzhDBf6@lizhi-Precision-Tower-5810>
In-Reply-To: <aHUVc5SV3yzhDBf6@lizhi-Precision-Tower-5810>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AM0PR04MB6850:EE_|DB1PEPF000509EE:EE_|DBBPR04MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 82177650-0616-40d8-f47b-08ddc6a4b3f7
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?djdVeStGWkNyQjFtL250S0g0eVNuU2dxdjBaYUhPbnlNcFZxbHlYSmZoM1RH?=
 =?utf-8?B?REwwNjk4SkdrdHk5U3Y2bGFWa1M1a3RrSVQ0a3ZvTEhiZWt5OVpudTAvZ1Bw?=
 =?utf-8?B?cW5DK1VBQXhJU0NDd1QrUGdLakNGTThvOExkRFNFQUxKcHMxUk1XSDEyenJr?=
 =?utf-8?B?amRIWXhqaUdlMS9OTDM4Qng1TmxwN3FiRGF4Z3JIRWs0ZWRBbGRGYk4zM3Fu?=
 =?utf-8?B?ek1nd3JBWnEyMDdrdlI2a1czU2E3MFp0dUQ3ZHJvUUFSM1YxZEY2eTIzaWhi?=
 =?utf-8?B?eWhUZVQyMmI4eW1uVUJ1SFIrbUlHdXgxMFFtNHF0Z1I5dis0Y1VRdTVnNFcv?=
 =?utf-8?B?MTI1MTZuTVFNVFAwZ3dVc0UzcjlhaDcwWTFvbWhZN2wzbUJYQ2RpWGVPek41?=
 =?utf-8?B?b3h0emYyYUhwaVhua0p3bHN4R0E2SWp6RkwweGZ3UmdEc25CeW9SWVJ5QzRu?=
 =?utf-8?B?b3JRV0ZDMkluSG9tWTJtRVkzRVA1K1JraFd1RTYrUmVzRnpNUFJ1SXVGcUJ2?=
 =?utf-8?B?KzRpL0NGWW1mb1gxTVRkTnhBNDg1Y0E4UldlbVVuSlRSeG1jRGtxbkJtTHVB?=
 =?utf-8?B?VmN1TXlneHZmNzNzcDJ5RG1pT1YyL1pNa0FBVkVYdmplWWtoZ095aHZlMXp2?=
 =?utf-8?B?V0pCeVlWMlJZNDNkTkZvOXI2a2t4RnhTK3R2ckxSdWxsd3ByZ3htWE1qdmln?=
 =?utf-8?B?M1dvTW1yVFNrMDVTMGNQNWQ2YzdEZzNSSVF1UTkweW5oWmFZM2lQUzF2R2JM?=
 =?utf-8?B?SjBUNjZPYjRzQ3BveEhkVUR6dDV1UlhSQWFwS20xRWhPR3p5enB0NXVveUho?=
 =?utf-8?B?clp1ckV1WDROcng2RW1mNVN6OHY0TmtDdFN0bDdtQ1RqeTMrNzNERTlkeEtk?=
 =?utf-8?B?S0lnZG4rUWxBMDNEVkJMc2RFY0RXZXJGcndXdWhyYlB6ZkpOVXNmYUpGZUlw?=
 =?utf-8?B?VXYyN0Y3VE5mdHBRcDQwWlg2VGc1clB1MXdLVDZQQVI4VXdZcCtXZmRHcXlq?=
 =?utf-8?B?dE1UWUMrQXoxWkpiWW1kSytIVDhDTUw0YU81T01pRjFCaEZFMXBxQUtQWVdV?=
 =?utf-8?B?K3cxK2pONGoxL2Rqa2hJbUp1QjVESEJNQlB1R1FXNXlmcG51cytzeVFGcktQ?=
 =?utf-8?B?RXRJTEdtSk5ZWkhVYjlOWkYxSWQ2KzRKUTNLWmw5cU5MWjljUXNWTEwxV0RW?=
 =?utf-8?B?ZWtuVTRuNDg2RlhjYTBILzFUUlp1Z0FueXhpNkpycld6U0o2bm1WdDRpeGhy?=
 =?utf-8?B?NXl3YkVybHc4NEpESzdoM0cvUDBPa2t6UlRveDRDUEFMblFGTC9NTkNWMkU0?=
 =?utf-8?B?ZWlzdDBLSHZKL05WR0cvcFpzWXJBbHBpN0ZPWTdlMlVmSmNkeE9MaFJGc2FE?=
 =?utf-8?B?RkNqYnM5Ym1KdjRWTjlsQlBQaS82VjRaOXVnOFNLc0thOGRQV0wwaVNFRlY2?=
 =?utf-8?B?ZC9HZURvc3ZKc00rcC9YeGJUSHZLd2duekFWQWpZWGEwM1lBVlI5QlUwNjEw?=
 =?utf-8?B?eGUyRFJuZktNSFRhb3AyOGs1b3BCckdxcXpHM1AvK3ZnUWFSUUhWTXJMRTJJ?=
 =?utf-8?B?YjhZMkQrZmlRTUtxTnY0SlEvQXNaaUdQdHhPZDJPOE55cmVLQVB5dlJteDc4?=
 =?utf-8?B?bnE0ZFdmeWp4REEvTzVrRXZHZDBWcUh6bEMycWYwVkpnd1Y2OUJPQzlLMTN0?=
 =?utf-8?B?ZHRwNW83MXdvdW5jSzBTSXRnV250YWtHODVFMitSZ0U2MVQxWnpja1RPQk9Z?=
 =?utf-8?B?VHhHM1ViMFh3SFBDbzA3RUFGOThvQWttY0dyd1JVWHVsTXhvc0dnMTNYd2xs?=
 =?utf-8?B?K2R4TmZtcWpuZFFrVTJXV1ZFc08weUtHTGpaMFpYNGZUTCtRVloyaXlKTStz?=
 =?utf-8?B?QkVydVo1TWV2a1pVMGtUbmxXcUd5K1BSbUlEL0kwbm1iZW9mN2djNDc1d3BT?=
 =?utf-8?B?S1hSc2dqemlnOXFudXB1c3JpY3pLQ3hiaGg5Y2VNQlhSdXV6UlRuM2dSNEVV?=
 =?utf-8?B?QWdaUGdmN1lRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA9A6EB183BC314489CC3D7895BEDE93@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6850
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: bfd85061b78941c0a9ba6632c36656c1:solidrun,office365_emails,sent,inline:4f06c975cb88c0f0e943428de9b595b6
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9d6befd0-8322-4357-6d63-08ddc6a4ad64
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|7416014|14060799003|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVqMW1SRnJRVURLeXFtS051ZFVZOE1zTG1VeURyOXB5YzgrdEI4YU4wdHBW?=
 =?utf-8?B?SnJ0UThCNWl6SDF4RXQreWJmTFBtV3hrQ2lZZTR5U1JycDN4ZnRTSkQwT1Jz?=
 =?utf-8?B?ZkRORll5cUZPbHNsSUxsMEx6VzJrdDFpMEFGRFZ6c1AxS3BYeEtYaGVYNjM3?=
 =?utf-8?B?bURpSFJEbXRhdDFqeE94NnRWUHNZNkZiMUFSSjNSSjU1R0FtbWwyZDRYbnZC?=
 =?utf-8?B?cWhXeDhYWWJ6U2tOa0FyN0JoTGM2OVRQLy9HVkZIcmFwejZRWWp1LytsY0hE?=
 =?utf-8?B?QWY4MTV1L3JUMmYrVmpRVGtPMDY1cDAwVFVQQ25xejlBMlZvZk9PTVBReldE?=
 =?utf-8?B?LzNSZ0Z1aGp5RUgzYWh6cHpvRjlHRDBLZUNONlJZdHVkMGl4RDVhemh3OFZV?=
 =?utf-8?B?K0RzaDhnaFhSalVZblZyUWRIQVp6QmgwWC92L0tzT1ZNME5QZ3VMZDNjaXRN?=
 =?utf-8?B?UmtnMlRrdzlmRWtLazZZVmVuMnFTeG92TzhEZlZJV25oUHpwTHBZeC8zTnZK?=
 =?utf-8?B?Q0VUQUpiU3pENWFKS3lqaFJENWQ2UmdHelJhNytnN1lSY1pWeCtQKy9JYnhw?=
 =?utf-8?B?Uk9rdTRwVG5ja2lsRmRWbGRmZDBtYmt1ZjhrMmM2SWpDU2tGS0RQak9xc3o5?=
 =?utf-8?B?aUlWeVpYc0ZET3VBWllGR3FubGtMbGJpYnhqS2pkVVVQdUZEYS9GdFJSZ052?=
 =?utf-8?B?MHdIZXdCN0VxUDBkN1diRG9OMHRRSHc4Y0FUeXViN1VoTU1vd2ExRUowMWhq?=
 =?utf-8?B?RVBYd3B4ekJESW5yTjdVcWgrczZ0RkNIK3ZpWFVSa0RnS0Ywb05HeTd0Y3E3?=
 =?utf-8?B?eGNueUJrK1NXK2Z4a3FFWElNZ2h0U0xhYWVReFdrREF0RmV1a3VrY3pZak9H?=
 =?utf-8?B?NVpjMmUxLzhXRlQwbmdQRmVnTEwySE5SMGFlRXlMdnFMSE9nU0YrY3c5NUpG?=
 =?utf-8?B?M1VRaXBQdGd6cThyc3NiUVR0MFNlNHNwai9Ea05yN3BYU2hhS2NGK3VTdGk5?=
 =?utf-8?B?aGxYeWt3bUEyN3A3ZEs4VkNrRGhPVVpJSHo0K3RzSUkrQlU1bzZxVU1xRzB1?=
 =?utf-8?B?ZHdKMnBjOHZMczBUd0c3bjc0aXBRSmgxL1BrcXFRK05JbHo4VzNTUEFuWjNE?=
 =?utf-8?B?VVF1d05zdlRXeFRaUFRFQStrZzJLKy9tTGJxNUlLRWxTZWpxRUJ0Mnlha1kr?=
 =?utf-8?B?Vlpnei9ZUzQ2MnBLdW96akJzMjBXdTRVZzBMTUNyNVcrYm5pM3dtbUYyNVN4?=
 =?utf-8?B?Y1BZZk1MbGNDdW5qUWtMZWNoR1YveEhjekUxMGdnMGdVaStHNUZSWGdJYlU1?=
 =?utf-8?B?Y0FMUjFjcmlYK0NDQ3VBYW81MWtRSXhqcVp0SVlRK21wWmcyZTNkSG1qMGtv?=
 =?utf-8?B?VmZRR3ZQTmtaREVMK3NKUGtFbTRObitib3NoT0IraFBlZzhDczhOSTY0d21M?=
 =?utf-8?B?ZzVQMW5rRE81ZmpUVlJBR1dBRkU3ZXQ4eWtQL005L0lITDIzbFR5ZkRaNnpo?=
 =?utf-8?B?ck1ZL1YrdTFXVTAzTXVLWlo0S2VRZ2JOZ3NZaTMrR0czNFRNRUlYNHJRZGJY?=
 =?utf-8?B?Q2E4bncwOFNna3dMU3ZHTHp6OW9rNmxURFJ4OERkbFlITXdKRGFXME5QYWRG?=
 =?utf-8?B?VDdXam9ndUJMOUxqTUUrdk50cWRBT2FUVFVqdWNNUmd2REo1L21Pb0dNMHdJ?=
 =?utf-8?B?bFRURjh6MVJlOE9BSGNrbWFNeXdsVDNPN1UrQUhuTlpnTkZrU01sUHlSWTUy?=
 =?utf-8?B?L1QreUd0UnJqMTdGbUsrbDBtL2M2Y3V6dWZ3L2lydGFhMCtwVVkxVmF6eXpK?=
 =?utf-8?B?UGppYnI0YUo0Q1BHVWgwQVU2Ri9kNEdJY0lpbWxQYVN1UjZDUnl1dnNkVU9P?=
 =?utf-8?B?a2dWbmpnMWdtZ3J4eEE3NmFzYWhvbGQvalk0cUpIYjloQXRQeFFmalhsWm9v?=
 =?utf-8?B?K1JzWWpaSUFieGVWNDBJZGdlRDFWaVZXYjRnK1o3cSt6SlBmbDdLTnJlY05i?=
 =?utf-8?B?SUd6Ym9IK2JNNjNmc25DWFlCRzRPZ2JlY2NUZ2RjTWduWGxiWTU1TU1PVmtT?=
 =?utf-8?Q?cJfpys?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(7416014)(14060799003)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 09:14:45.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82177650-0616-40d8-f47b-08ddc6a4b3f7
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7547

SGkgRnJhbmssDQoNCkFtIDE0LjA3LjI1IHVtIDE2OjM0IHNjaHJpZWIgRnJhbmsgTGk6DQoNCj4g
T24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMTA6NDQ6MTNBTSArMDMwMCwgSm9zdWEgTWF5ZXIgd3Jv
dGU6DQo+PiBUaGlzIHJldmVydHMgY29tbWl0IDhhMTM2NWM3YmJjMTIyYmQ4NDMwOTZmMDAwOGQy
NTllN2E4YWZjNjEuDQo+Pg0KPj4gVGhlIGNvbW1pdCBpbiBxdWVzdGlvbnMgbW9zdCBub3RhYmx5
IGJyZWFrcyBTRC1DYXJkIG9uIFNvbGlkUnVuDQo+PiBMWDIxNjJBIENsZWFyZm9nIGJ5IGNvcnJ1
cHRpbmcgdGhlIHBpbm11eCBpbiBkeW5hbWljIGNvbmZpZ3VyYXRpb24gYXJlYQ0KPj4gZm9yIG5v
bi1pMmMgcGlucyB3aXRob3V0IHBpbm11eCBub2RlLg0KPj4gSXQgaXMgZnVydGhlciBleHBlY3Rl
ZCB0aGF0IGl0IGJyZWFrcyBTRCBDYXJkLURldGVjdCwgYXMgd2VsbCBhcyBDQU4sDQo+PiBEU1BJ
IGFuZCBHUElPcyBvbiBhbnkgYm9hcmQgYmFzZWQgb24gTFgyMTYwIFNvQy4NCj4gVGhhbmsgeW91
IGZvciB5b3VyIHBhdGNoLiBJIHJlbWVtYmVyIHdlIG1ldCBzaW1pbGFyIGlzc3VlIGJlZm9yZS4g
TGV0J3MNCj4gd2FpdCBmb3IgY2FybG9zIGlzIGJhY2sgYWJvdXQgaW4gbmV4dCB3ZWVrLg0KPg0K
PiBJIHJlbWVtYmVyIHVib290IHNob3VsZCBjb3B5IFJDV1NSIHRvIDB4NzAwMTAwMTJjLg0KS25v
d2luZyB3aGVuIGFuZCB3aGVyZSB0aGlzIHdhcyBpbXBsZW1lbnRlZCB3b3VsZCBiZSBoZWxwZnVs
LA0KaG93ZXZlciBuZWVkIHRvIGtlZXAgaW4gbWluZCBleGlzdGluZyBzeXN0ZW1zIHJ1bm5pbmcg
c3RhYmxlIGJvb3Rsb2FkZXIuDQo+IEkyQyByZWNvdmVyIGFsc28gaXMNCj4gaW1wb3J0YW50IGZl
YXR1cmUuDQpBZ3JlZWQuDQoNClRoZXJlIGlzIGFuIGFkZGl0aW9uYWwgcHJvYmxlbSB3aXRoIHRo
ZSBwYXRjaCBpbiBxdWVzdGlvbjoNClRoZSBwaW5tdXggYWZmZWN0cyBib3RoIFNDTCtTREEgdG9n
ZXRoZXIsIGNoYW5naW5nIGJldHdlZW4gSTJDIGFuZCBHUElPLA0KYnV0IGluIHRoZSBpMmMgY29u
dHJvbGxlciBub2RlcyBvbmx5IHNjbC1ncGlvcyB3YXMgc3BlY2lmaWVkLg0KSGVuY2UgZm9yIHNk
YSB0aGUgcmVjb3ZlcnkgcmVsaWVzIG9uIHVuZGVmaW5lZCBzdGF0ZSBvZiBncGlvIGNvbnRyb2xs
ZXIgcmVnaXN0ZXJzLg0KDQo+PiBCYWNrZ3JvdW5kOg0KPj4NCj4+IFRoZSBMWDIxNjAgU29DIGlz
IGNvbmZpZ3VyZWQgYXQgcG93ZXItb24gZnJvbSBSQ1cgKFJlc2V0DQo+PiBDb25maWd1cmF0aW9u
IFdvcmQpIHR5cGljYWxseSBsb2NhdGVkIGluIHRoZSBmaXJzdCA0ayBvZiBib290IG1lZGlhLg0K
Pj4gVGhpcyBibG9iIGNvbmZpZ3VyZXMgdmFyaW91cyBjbG9jayByYXRlcyBhbmQgcGluIGZ1bmN0
aW9ucy4NCj4+IFRoZSBwaW5tdXggZm9yIGkyYyBzcGVjaWZpY2FsbHkgaXMgcGFydCBvZiBjb25m
aWd1cmF0aW9uIHdvcmRzIFJDV1NSMTIsDQo+PiBSQ1dTUjEzIGFuZCBSQ1dTUjE0IHNpemUgMzIg
Yml0IGVhY2guDQo+PiBUaGVzZSB2YWx1ZXMgYXJlIGFjY2Vzc2libGUgYXQgcmVhZC1vbmx5IGFk
ZHJlc3NlcyAweDAxZTAwMTJjIGZvbGxvd2luZy4NCj4+DQo+PiBGb3IgcnVudGltZSAocmUtKWNv
bmZpZ3VyYXRpb24gdGhlIFNvQyBoYXMgYSBkeW5hbWljIGNvbmZpZ3VyYXRpb24gYXJlYQ0KPj4g
d2hlcmUgYWx0ZXJuYXRpdmUgc2V0dGluZ3MgY2FuIGJlIGFwcGxpZWQuIFRoZSBjb3VudGVycGFy
dHMgb2YNCj4+IFJDV1NSWzEyLTE0XSBjYW4gYmUgb3ZlcnJpZGRlbiBhdCAweDcwMDEwMDEyYyBm
b2xsb3dpbmcuDQo+Pg0KPj4gVGhlIGNvbW1pdCBpbiBxdWVzdGlvbiB1c2VkIHRoaXMgYXJlYSB0
byBzd2l0Y2ggaTJjIHBpbnMgYmV0d2VlbiBpMmMgYW5kDQo+PiBncGlvIGZ1bmN0aW9uIGF0IHJ1
bnRpbWUgdXNpbmcgdGhlIHBpbmN0cmwtc2luZ2xlIGRyaXZlciAtIHdoaWNoIHJlYWRzIGENCj4+
IDMyLWJpdCB2YWx1ZSwgbWFrZXMgcGFydGljdWxhciBjaGFuZ2VzIGJ5IGJpdG1hc2sgYW5kIHdy
aXRlcyBiYWNrIHRoZQ0KPj4gbmV3IHZhbHVlLg0KPj4NCj4+IFNvbGlkUnVuIGhhdmUgb2JzZXJ2
ZWQgdGhhdCBpZiB0aGUgZHluYW1pYyBjb25maWd1cmF0aW9uIGlzIHJlYWQgZmlyc3QNCj4+IChi
ZWZvcmUgYSB3cml0ZSksIGl0IHJlYWRzIGFzIHplcm8gcmVnYXJkbGVzcyB0aGUgaW5pdGlhbCB2
YWx1ZXMgc2V0IGJ5DQo+PiBSQ1cuIEFmdGVyIHRoZSBmaXJzdCB3cml0ZSBjb25zZWN1dGl2ZSBy
ZWFkcyByZWZsZWN0IHRoZSB3cml0dGVuIHZhbHVlLg0KPj4NCj4+IEJlY2F1c2UgbXVsdGlwbGUg
cGlucyBhcmUgY29uZmlndXJlZCBmcm9tIGEgc2luZ2xlIDMyLWJpdCB2YWx1ZSwgdGhpcw0KPj4g
Y2F1c2VzIHVuaW50ZW50aW9uYWwgY2hhbmdlIG9mIGFsbCBiaXRzIChleGNlcHQgdGhvc2UgZm9y
IGkyYykgYmVpbmcgc2V0DQo+PiB0byB6ZXJvIHdoZW4gdGhlIHBpbmN0cmwgZHJpdmVyIGFwcGxp
ZXMgdGhlIGZpcnN0IGNvbmZpZ3VyYXRpb24uDQo+Pg0KPj4gU2VlIGJlbG93IGEgc2hvcnQgbGlz
dCBvZiB3aGljaCBmdW5jdGlvbnMgUkNXU1IxMiBhbG9uZSBjb250cm9sczoNCj4+DQo+PiBMWDIx
NjItQ0YgUkNXU1IxMjogMGIwMDAwMTAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAxMTANCj4+IElJ
QzJfUE1VWCAgICAgICAgICAgICAgfHx8ICAgfHx8ICAgfHwgfCAgIHx8fCAgIHx8fFhYWCA6IEky
Qy9HUElPL0NELVdQDQo+PiBJSUMzX1BNVVggICAgICAgICAgICAgIHx8fCAgIHx8fCAgIHx8IHwg
ICB8fHwgICBYWFggICAgOiBJMkMvR1BJTy9DQU4vRVZUDQo+PiBJSUM0X1BNVVggICAgICAgICAg
ICAgIHx8fCAgIHx8fCAgIHx8IHwgICB8fHxYWFh8fHwgICAgOiBJMkMvR1BJTy9DQU4vRVZUDQo+
PiBJSUM1X1BNVVggICAgICAgICAgICAgIHx8fCAgIHx8fCAgIHx8IHwgICBYWFggICB8fHwgICAg
OiBJMkMvR1BJTy9TREhDLUNMSw0KPj4gSUlDNl9QTVVYICAgICAgICAgICAgICB8fHwgICB8fHwg
ICB8fCB8WFhYfHx8ICAgfHx8ICAgIDogSTJDL0dQSU8vU0RIQy1DTEsNCj4+IFhTUEkxX0FfREFU
QTc0X1BNVVggICAgfHx8ICAgfHx8ICAgWFggWCAgIHx8fCAgIHx8fCAgICA6IFhTUEkvR1BJTw0K
Pj4gWFNQSTFfQV9EQVRBMzBfUE1VWCAgICB8fHwgICB8fHxYWFh8fCB8ICAgfHx8ICAgfHx8ICAg
IDogWFNQSS9HUElPDQo+PiBYU1BJMV9BX0JBU0VfUE1VWCAgICAgIHx8fCAgIFhYWCAgIHx8IHwg
ICB8fHwgICB8fHwgICAgOiBYU1BJL0dQSU8NCj4+IFNESEMxX0JBU0VfUE1VWCAgICAgICAgfHx8
WFhYfHx8ICAgfHwgfCAgIHx8fCAgIHx8fCAgICA6IFNESEMvR1BJTy9TUEkNCj4+IFNESEMxX0RJ
Ul9QTVVYICAgICAgICAgWFhYICAgfHx8ICAgfHwgfCAgIHx8fCAgIHx8fCAgICA6IFNESEMvR1BJ
Ty9TUEkNCj4+IFJFU0VSVkVEICAgICAgICAgICAgIFhYfHx8ICAgfHx8ICAgfHwgfCAgIHx8fCAg
IHx8fCAgICA6DQo+Pg0KPj4gT24gTFgyMTYyQSBDbGVhcmZvZyB0aGUgaW5pdGlhbCAoYW50IGlu
dGVuZGVkKSB2YWx1ZSBpcyAweDA4MDAwMDA2IC0NCj4+IGVuYWJsaW5nIGNhcmQtZGV0ZWN0IG9u
IElJQzJfUE1VWCBhbmQgc29tZSBMRURzIG9uIFNESEMxX0RJUl9QTVVYLg0KPj4gRXZlcnl0aGlu
ZyBlbHNlIGlzIGludGVudGlvbmFsIHplcm8gKGVuYWJsaW5nIEkyQyAmIFhTUEkpLg0KPj4NCj4+
IEJ5IHJlYWRpbmcgemVybyBmcm9tIGR5bmFtaWMgY29uZmlndXJhdGlvbiBhcmVhLCB0aGUgY29t
bWl0IGluIHF1ZXN0aW9uDQo+PiBjaGFuZ2VzIElJQzJfUE1VWCB0byB2YWx1ZSAwIChJMkMgZnVu
Y3Rpb24pLCBhbmQgU0RIQzFfRElSX1BNVVggdG8gMA0KPj4gKFNESEMgZGF0YSBkaXJlY3Rpb24g
ZnVuY3Rpb24pIC0gYnJlYWtpbmcgY2FyZC1kZXRlY3QgYW5kIGxlZCBncGlvcy4NCj4+DQo+PiBU
aGlzIGlzc3VlIHNob3VsZCBhZmZlY3QgYW55IGJvYXJkIGJhc2VkIG9uIExYMjE2MCBTb0MgdGhh
dCBpcyB1c2luZyB0aGUNCj4+IHNhbWUgb3IgZWFybGllciB2ZXJzaW9ucyBvZiBOWFAgYm9vdGxv
YWRlciBhcyBTb2xpZFJ1biBoYXZlIHRlc3RlZCwgaW4NCj4+IHBhcnRpY3VsYXI6IExTREstMjEu
MDggYW5kIExTLTUuMTUuNzEtMi4yLjAuDQo+Pg0KPj4gV2hldGhlciBOWFAgYWRkZWQgc29tZSBl
eHRyYSBpbml0aWFsaXNhdGlvbiBpbiB0aGUgYm9vdGxvYWRlciBvbiBsYXRlcg0KPj4gcmVsZWFz
ZXMgd2FzIG5vdCBpbnZlc3RpZ2F0ZWQuIEhvd2V2ZXIgYm9vdGxvYWRlciB1cGdyYWRlIHNob3Vs
ZCBub3QgYmUNCj4+IG5lY2Vzc2FyeSB0byBydW4gYSBuZXdlciBMaW51eCBrZXJuZWwuDQo+Pg0K
Pj4gVG8gd29yayBhcm91bmQgdGhpcyBpc3N1ZSBpdCBpcyBwb3NzaWJsZSB0byBleHBsaWNpdGx5
IGRlZmluZSBBTEwgcGlucw0KPj4gY29udHJvbGxlZCBieSBhbnkgMzItYml0IHZhbHVlIHNvIHRo
YXQgZ3JhZHVhbGx5IGFmdGVyIHByb2Nlc3NpbmcgYWxsDQo+PiBwaW5jdHJsIG5vZGVzIHRoZSBj
b3JyZWN0IHZhbHVlIGlzIHJlYWNoZWQgb24gYWxsIGJpdHMuDQo+Pg0KPj4gVGhpcyBpcyBhIGxh
cmdlIHRhc2sgdGhhdCBzaG91bGQgYmUgZG9uZSBjYXJlZnVsbHkgb24gYSBwZXItYm9hcmQgYmFz
aXMNCj4+IGFuZCBub3QgZ2xvYmFsbHkgdGhyb3VnaCB0aGUgU29DIGR0c2kuDQo+PiBUaGVyZWZv
cmUgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbiBpcyByZXZlcnRlZC4NCj4+DQo+PiBGaXhlczogOGEx
MzY1YzdiYmMxICgiYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHBpbm11eCBhbmQgaTJjIGdwaW8g
dG8gc3VwcG9ydCBidXMgcmVjb3ZlcnkiKQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4g
LS0tDQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gLSBjaGFuZ2VkIHRvIHJldmVydCBwcm9ibGVtYXRp
YyBjb21taXQsIHdvcmthcm91bmQgaXMgbGFyZ2UgZWZmb3J0DQo+PiAtIExpbmsgdG8gdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvZjMyYzU1MjUtMzE2Mi00YWNkLTg4MGMtOTlmYzQ2ZDNh
NjNkQHNvbGlkLXJ1bi5jb20NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjBhLmR0c2kgfCAxMDYgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMDYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+PiBpbmRleCBjOTU0MTQwM2Jj
ZDguLmViMWI0ZTYwN2UyYiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+IEBAIC03NDksMTAgKzc0OSw2IEBAIGkyYzA6IGky
Y0AyMDAwMDAwIHsNCj4+ICAJCQljbG9jay1uYW1lcyA9ICJpcGciOw0KPj4gIAkJCWNsb2NrcyA9
IDwmY2xvY2tnZW4gUU9SSVFfQ0xLX1BMQVRGT1JNX1BMTA0KPj4gIAkJCQkJICAgIFFPUklRX0NM
S19QTExfRElWKDE2KT47DQo+PiAtCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgImdwaW8i
Ow0KPj4gLQkJCXBpbmN0cmwtMCA9IDwmaTJjMF9zY2w+Ow0KPj4gLQkJCXBpbmN0cmwtMSA9IDwm
aTJjMF9zY2xfZ3Bpbz47DQo+PiAtCQkJc2NsLWdwaW9zID0gPCZncGlvMCAzIChHUElPX0FDVElW
RV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47DQo+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4+ICAJCX07DQo+Pg0KPj4gQEAgLTc2NSwxMCArNzYxLDYgQEAgaTJjMTogaTJjQDIwMTAwMDAg
ew0KPj4gIAkJCWNsb2NrLW5hbWVzID0gImlwZyI7DQo+PiAgCQkJY2xvY2tzID0gPCZjbG9ja2dl
biBRT1JJUV9DTEtfUExBVEZPUk1fUExMDQo+PiAgCQkJCQkgICAgUU9SSVFfQ0xLX1BMTF9ESVYo
MTYpPjsNCj4+IC0JCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+PiAtCQkJ
cGluY3RybC0wID0gPCZpMmMxX3NjbD47DQo+PiAtCQkJcGluY3RybC0xID0gPCZpMmMxX3NjbF9n
cGlvPjsNCj4+IC0JCQlzY2wtZ3Bpb3MgPSA8JmdwaW8wIDMxIChHUElPX0FDVElWRV9ISUdIIHwg
R1BJT19PUEVOX0RSQUlOKT47DQo+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICAJCX07
DQo+Pg0KPj4gQEAgLTc4MSwxMCArNzczLDYgQEAgaTJjMjogaTJjQDIwMjAwMDAgew0KPj4gIAkJ
CWNsb2NrLW5hbWVzID0gImlwZyI7DQo+PiAgCQkJY2xvY2tzID0gPCZjbG9ja2dlbiBRT1JJUV9D
TEtfUExBVEZPUk1fUExMDQo+PiAgCQkJCQkgICAgUU9SSVFfQ0xLX1BMTF9ESVYoMTYpPjsNCj4+
IC0JCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+PiAtCQkJcGluY3RybC0w
ID0gPCZpMmMyX3NjbD47DQo+PiAtCQkJcGluY3RybC0xID0gPCZpMmMyX3NjbF9ncGlvPjsNCj4+
IC0JCQlzY2wtZ3Bpb3MgPSA8JmdwaW8wIDI5IChHUElPX0FDVElWRV9ISUdIIHwgR1BJT19PUEVO
X0RSQUlOKT47DQo+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICAJCX07DQo+Pg0KPj4g
QEAgLTc5NywxMCArNzg1LDYgQEAgaTJjMzogaTJjQDIwMzAwMDAgew0KPj4gIAkJCWNsb2NrLW5h
bWVzID0gImlwZyI7DQo+PiAgCQkJY2xvY2tzID0gPCZjbG9ja2dlbiBRT1JJUV9DTEtfUExBVEZP
Uk1fUExMDQo+PiAgCQkJCQkgICAgUU9SSVFfQ0xLX1BMTF9ESVYoMTYpPjsNCj4+IC0JCQlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+PiAtCQkJcGluY3RybC0wID0gPCZpMmMz
X3NjbD47DQo+PiAtCQkJcGluY3RybC0xID0gPCZpMmMzX3NjbF9ncGlvPjsNCj4+IC0JCQlzY2wt
Z3Bpb3MgPSA8JmdwaW8wIDI3IChHUElPX0FDVElWRV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47
DQo+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICAJCX07DQo+Pg0KPj4gQEAgLTgxMywx
MCArNzk3LDYgQEAgaTJjNDogaTJjQDIwNDAwMDAgew0KPj4gIAkJCWNsb2NrLW5hbWVzID0gImlw
ZyI7DQo+PiAgCQkJY2xvY2tzID0gPCZjbG9ja2dlbiBRT1JJUV9DTEtfUExBVEZPUk1fUExMDQo+
PiAgCQkJCQkgICAgUU9SSVFfQ0xLX1BMTF9ESVYoMTYpPjsNCj4+IC0JCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+PiAtCQkJcGluY3RybC0wID0gPCZpMmM0X3NjbD47DQo+
PiAtCQkJcGluY3RybC0xID0gPCZpMmM0X3NjbF9ncGlvPjsNCj4+IC0JCQlzY2wtZ3Bpb3MgPSA8
JmdwaW8wIDI1IChHUElPX0FDVElWRV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47DQo+PiAgCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICAJCX07DQo+Pg0KPj4gQEAgLTgyOSwxMCArODA5LDYg
QEAgaTJjNTogaTJjQDIwNTAwMDAgew0KPj4gIAkJCWNsb2NrLW5hbWVzID0gImlwZyI7DQo+PiAg
CQkJY2xvY2tzID0gPCZjbG9ja2dlbiBRT1JJUV9DTEtfUExBVEZPUk1fUExMDQo+PiAgCQkJCQkg
ICAgUU9SSVFfQ0xLX1BMTF9ESVYoMTYpPjsNCj4+IC0JCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiLCAiZ3BpbyI7DQo+PiAtCQkJcGluY3RybC0wID0gPCZpMmM1X3NjbD47DQo+PiAtCQkJcGlu
Y3RybC0xID0gPCZpMmM1X3NjbF9ncGlvPjsNCj4+IC0JCQlzY2wtZ3Bpb3MgPSA8JmdwaW8wIDIz
IChHUElPX0FDVElWRV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47DQo+PiAgCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4+ICAJCX07DQo+Pg0KPj4gQEAgLTg0NSwxMCArODIxLDYgQEAgaTJjNjog
aTJjQDIwNjAwMDAgew0KPj4gIAkJCWNsb2NrLW5hbWVzID0gImlwZyI7DQo+PiAgCQkJY2xvY2tz
ID0gPCZjbG9ja2dlbiBRT1JJUV9DTEtfUExBVEZPUk1fUExMDQo+PiAgCQkJCQkgICAgUU9SSVFf
Q0xLX1BMTF9ESVYoMTYpPjsNCj4+IC0JCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZ3Bp
byI7DQo+PiAtCQkJcGluY3RybC0wID0gPCZpMmM2X3NjbD47DQo+PiAtCQkJcGluY3RybC0xID0g
PCZpMmM2X3NjbF9ncGlvPjsNCj4+IC0JCQlzY2wtZ3Bpb3MgPSA8JmdwaW8xIDE2IChHUElPX0FD
VElWRV9ISUdIIHwgR1BJT19PUEVOX0RSQUlOKT47DQo+PiAgCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4+ICAJCX07DQo+Pg0KPj4gQEAgLTg2MSwxMCArODMzLDYgQEAgaTJjNzogaTJjQDIwNzAw
MDAgew0KPj4gIAkJCWNsb2NrLW5hbWVzID0gImlwZyI7DQo+PiAgCQkJY2xvY2tzID0gPCZjbG9j
a2dlbiBRT1JJUV9DTEtfUExBVEZPUk1fUExMDQo+PiAgCQkJCQkgICAgUU9SSVFfQ0xLX1BMTF9E
SVYoMTYpPjsNCj4+IC0JCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+PiAt
CQkJcGluY3RybC0wID0gPCZpMmM3X3NjbD47DQo+PiAtCQkJcGluY3RybC0xID0gPCZpMmM3X3Nj
bF9ncGlvPjsNCj4+IC0JCQlzY2wtZ3Bpb3MgPSA8JmdwaW8xIDE4IChHUElPX0FDVElWRV9ISUdI
IHwgR1BJT19PUEVOX0RSQUlOKT47DQo+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICAJ
CX07DQo+Pg0KPj4gQEAgLTE3MDAsODAgKzE2NjgsNiBAQCBwY3MxODogZXRoZXJuZXQtcGh5QDAg
ew0KPj4gIAkJCX07DQo+PiAgCQl9Ow0KPj4NCj4+IC0JCXBpbm11eF9pMmNydjogcGlubXV4QDcw
MDEwMDEyYyB7DQo+PiAtCQkJY29tcGF0aWJsZSA9ICJwaW5jdHJsLXNpbmdsZSI7DQo+PiAtCQkJ
cmVnID0gPDB4MDAwMDAwMDcgMHgwMDEwMDEyYyAweDAgMHhjPjsNCj4+IC0JCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4+IC0JCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4+IC0JCQlwaW5jdHJsLXNp
bmdsZSxiaXQtcGVyLW11eDsNCj4+IC0JCQlwaW5jdHJsLXNpbmdsZSxyZWdpc3Rlci13aWR0aCA9
IDwzMj47DQo+PiAtCQkJcGluY3RybC1zaW5nbGUsZnVuY3Rpb24tbWFzayA9IDwweDc+Ow0KPj4g
LQ0KPj4gLQkJCWkyYzFfc2NsOiBpMmMxLXNjbC1waW5zIHsNCj4+IC0JCQkJcGluY3RybC1zaW5n
bGUsYml0cyA9IDwweDAgMCAweDc+Ow0KPj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJaTJjMV9zY2xf
Z3BpbzogaTJjMS1zY2wtZ3Bpby1waW5zIHsNCj4+IC0JCQkJcGluY3RybC1zaW5nbGUsYml0cyA9
IDwweDAgMHgxIDB4Nz47DQo+PiAtCQkJfTsNCj4+IC0NCj4+IC0JCQlpMmMyX3NjbDogaTJjMi1z
Y2wtcGlucyB7DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwIDAgKDB4NyA8PCAz
KT47DQo+PiAtCQkJfTsNCj4+IC0NCj4+IC0JCQlpMmMyX3NjbF9ncGlvOiBpMmMyLXNjbC1ncGlv
LXBpbnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAoMHgxIDw8IDMpICgw
eDcgPDwgMyk+Ow0KPj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJaTJjM19zY2w6IGkyYzMtc2NsLXBp
bnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAwICgweDcgPDwgNik+Ow0K
Pj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJaTJjM19zY2xfZ3BpbzogaTJjMy1zY2wtZ3Bpby1waW5z
IHsNCj4+IC0JCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgKDB4MSA8PCA2KSAoMHg3IDw8
IDYpPjsNCj4+IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzRfc2NsOiBpMmM0LXNjbC1waW5zIHsN
Cj4+IC0JCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgMCAoMHg3IDw8IDkpPjsNCj4+IC0J
CQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzRfc2NsX2dwaW86IGkyYzQtc2NsLWdwaW8tcGlucyB7DQo+
PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwICgweDEgPDwgOSkgKDB4NyA8PCA5KT47
DQo+PiAtCQkJfTsNCj4+IC0NCj4+IC0JCQlpMmM1X3NjbDogaTJjNS1zY2wtcGlucyB7DQo+PiAt
CQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHgwIDAgKDB4NyA8PCAxMik+Ow0KPj4gLQkJCX07
DQo+PiAtDQo+PiAtCQkJaTJjNV9zY2xfZ3BpbzogaTJjNS1zY2wtZ3Bpby1waW5zIHsNCj4+IC0J
CQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgKDB4MSA8PCAxMikgKDB4NyA8PCAxMik+Ow0K
Pj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJaTJjNl9zY2w6IGkyYzYtc2NsLXBpbnMgew0KPj4gLQkJ
CQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4NCAweDIgMHg3PjsNCj4+IC0JCQl9Ow0KPj4gLQ0K
Pj4gLQkJCWkyYzZfc2NsX2dwaW86IGkyYzYtc2NsLWdwaW8tcGlucyB7DQo+PiAtCQkJCXBpbmN0
cmwtc2luZ2xlLGJpdHMgPSA8MHg0IDB4MSAweDc+Ow0KPj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJ
aTJjN19zY2w6IGkyYzctc2NsLXBpbnMgew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0g
PDB4NCAweDIgMHg3PjsNCj4+IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzdfc2NsX2dwaW86IGky
Yzctc2NsLWdwaW8tcGlucyB7DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHg0IDB4
MSAweDc+Ow0KPj4gLQkJCX07DQo+PiAtDQo+PiAtCQkJaTJjMF9zY2w6IGkyYzAtc2NsLXBpbnMg
ew0KPj4gLQkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4OCAwICgweDcgPDwgMTApPjsNCj4+
IC0JCQl9Ow0KPj4gLQ0KPj4gLQkJCWkyYzBfc2NsX2dwaW86IGkyYzAtc2NsLWdwaW8tcGlucyB7
DQo+PiAtCQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHg4ICgweDEgPDwgMTApICgweDcgPDwg
MTApPjsNCj4+IC0JCQl9Ow0KPj4gLQkJfTsNCj4+IC0NCj4+ICAJCWZzbF9tYzogZnNsLW1jQDgw
YzAwMDAwMCB7DQo+PiAgCQkJY29tcGF0aWJsZSA9ICJmc2wscW9yaXEtbWMiOw0KPj4gIAkJCXJl
ZyA9IDwweDAwMDAwMDA4IDB4MGMwMDAwMDAgMCAweDQwPiwNCj4+DQo+PiAtLS0NCj4+IGJhc2Ut
Y29tbWl0OiAxOTI3MmIzN2FhNGY4M2NhNTJiZGY5YzE2ZDVkODFiZGQxMzU0NDk0DQo+PiBjaGFu
Z2UtaWQ6IDIwMjUwNzEwLWx4MjE2MC1zZC1jZC0wMGJmMzhhZTE2OWUNCj4+DQo+PiBCZXN0IHJl
Z2FyZHMsDQo+PiAtLQ0KPj4gSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pg0K

