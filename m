Return-Path: <stable+bounces-88026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DDB9AE249
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 12:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208621F24B80
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0E11B219E;
	Thu, 24 Oct 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DG5msJuW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="U7oic7du"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5171B218B;
	Thu, 24 Oct 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764979; cv=fail; b=jZKTmYE14WRFwhO+JxWFWk+mSTZFSDrshXlSxDFD2vp7dOODJtB7pUTtUABDH4ixOaUBv3fPGEJ/GZGy0jaCxRbLmF8NLeqLC407qpe/PdwwZUTHh/PRWCUXK3lyH4xpW5NOH0iAWGrwnXMF9tx8gUso1KfAjSc1rEN1lfKveqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764979; c=relaxed/simple;
	bh=n1sGWNatOtXU4wFRcoQyz8l4ZwCvZF/gSqyBAsZpDD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDu0zyf64fLARBsQDs+tTSHlVt88jky645uWehi5vzmNp3Q4VpDJGFdxO3/bLfgGlIBcn5oAsjHTcy5PK1cidq9O3XZereCUgrWJAcdFU19e1F++VJQHFmvre5TteeYHGebgwe2mxyr5kvb414X0/2a7Bo2e/NiySWF6rW1NX2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DG5msJuW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=U7oic7du; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fe33000091f011efbd192953cf12861f-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n1sGWNatOtXU4wFRcoQyz8l4ZwCvZF/gSqyBAsZpDD4=;
	b=DG5msJuWOMuZAaoVbGVlGYSP2cKEQYxOLgsg12TILr9YbZGocrk0+8WtRr3KliZ6GzYaBson64XHbwNmM613CA1dqRNwhXSgNnEvv/nwLdTeD2Ou7vq4SYOQbz0e0kZq/S7iN+XnXEIqf2EzruPqdfe7hvjx/C7alaOCvykxanI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:6e684d37-f11d-45cb-bb11-74aa6a9239f2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:66e1cccc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: fe33000091f011efbd192953cf12861f-20241024
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1392429847; Thu, 24 Oct 2024 18:16:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 18:16:09 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 18:16:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYk9zJCh/fTa2refioEhzdIM3Wt7Krpdelvh2iJNqSQfhfkrjxFv2vTRSh4IC9ipKJK7fJYdLQDT5FQU7hdgc5iHAKgYzqRpBvKK2TMDsVJdOmTigh+E417Zi3zjQh+r108IljU6ZRdaLJz7l6TH6VnBrUPnQJcXLLzrWTqPDaeOx8WcM8wvIQn+HOHj0X29tWExAJ6Qinl5uh6y971GZBz62lZxZeB3L0ACpaB95hK89eLtPe51lJWCL/v8V1ORrX2udD0z+SrOTHo5EdARfsgwqpOHPBG50V4YthbcKbVJoQ8RAN97+gP/jQBJPpjYuwabpL/ye6QKLxa4lvGuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1sGWNatOtXU4wFRcoQyz8l4ZwCvZF/gSqyBAsZpDD4=;
 b=WTsO1Wnu1aRV17ekC+L9EoTjnqBB9Ci63F0Q2uC/5hYLtMWjTgdqAegUHEVymjT+JARaxfZMsrb7ZKqM4Tqrrivv8haLrBivYQlUv/MhxMStSPlEUujn71VykJSlH8QS2glAezS1VQHe5yX/HT97o4AlDH24ZXZZcOxlSxwyNjKDTqbA0wGgdflKYLP5Sru1Tpeg1Vsnks9W/HkEZEPP6RwBtDMWnBsQ7mz8Ogo56PQjfUcl/YyCkOyDyylWPP3JTr4lnqjEVrsAzjaxV3FEgmXjSa8AhkoA5WbJrp2/V/oLg+oxeZHbel3jUW2JvvnyMsNSrW+pGzlwpSw6RsT7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1sGWNatOtXU4wFRcoQyz8l4ZwCvZF/gSqyBAsZpDD4=;
 b=U7oic7duuUoSEp8xVCdCVxf4MMuLTLNWN2ZECCKnvfJ2Pt/T8egp65MBAAXcsKUbSGfVQ/0q7q79tKT54S7DCBTHy4p4N+H4U87j+8h5AR3yBGmzF0hCsqce39JCvpkQB76huATcTR6UqgpsCngwPuYpthxUjN3C1JrfvDKbC+A=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB6822.apcprd03.prod.outlook.com (2603:1096:400:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 10:16:06 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 10:16:05 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saravanak@google.com" <saravanak@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?=
	<seiya.wang@mediatek.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Thread-Topic: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbJfiKpGmIlcb1JUuto1yu1g4WFbKVp3wAgAAIBQA=
Date: Thu, 24 Oct 2024 10:16:05 +0000
Message-ID: <88f78b11804b0f18e0dce0dca95544bf6cf6c7c6.camel@mediatek.com>
References: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
	 <2024102406-shore-refurbish-767a@gregkh>
In-Reply-To: <2024102406-shore-refurbish-767a@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB6822:EE_
x-ms-office365-filtering-correlation-id: b1e89245-1608-47c9-364d-08dcf414ded4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEp5T2wyV2R4WEpUUnVvUzRBdW5PdHFDTS9QanRVRkIrd2VYTVZqVlFST0hF?=
 =?utf-8?B?TDhPQlVHOXZaUFl4YlZGb040NU5vRVY4SGlhdldmRm5zNEpCNi9sN3U4R1ZK?=
 =?utf-8?B?R2JUMm5kTGp1T2o4UWNEQ01VODlFOXQ1VEswVTduWWlGTElGZXdoS1Y5YllJ?=
 =?utf-8?B?VGdPZldDR1V0bzc1VzRSWUV3NzB0WTFodFdsc3RETG8wMEZZRldRd0VYMU42?=
 =?utf-8?B?bzdIaVFOei9BSVhIZlEzUEEwRjBDV2NuMjlyZHJScksxNGFMUjhYTjhOL1RG?=
 =?utf-8?B?ZG1WTUQycno0VzBsWk5ESUFQV2FWVDNra2U3WkI4bHZ5SU5UTGRuaDhvb08r?=
 =?utf-8?B?WjhnOXVJWUFpdVlORlA3ekFscTVLeEFVK3ZYUjEvaGNvTk9FTUYvNWV4ZENB?=
 =?utf-8?B?dExCY0p0R3MwL0xJRWpIZzdTZklMVTlVM2E3QVU0SFZqVkQrejVOOXZnU0U4?=
 =?utf-8?B?WG93ckhsRi9ZOUhsK2ZQQSt5MTFjaUhVU1F0a0ttVmZvK3JjZys4ZkRPQ1Qy?=
 =?utf-8?B?dyt5akFoZ0JpOVAxN3Y3UklxdmJXL0FWaFhPZjRqOVBiTVZ5MWtSbURzUUNs?=
 =?utf-8?B?NTgweUQvbWN5OXVNWEIvWmhEYnNGWGkzbE1aZmtCaWNwTmNtZTh1MEVKL1Zh?=
 =?utf-8?B?T2xTdk0vaUVnVkJlWlpSMHo3eHAxTWJYWS9HYXZ6ZW1tenhvNVVUZHZsRjhj?=
 =?utf-8?B?VXhMaUJFZUYvbms0UVlTbWJUMGpBMWtyMlVpcnJtNmlyUFpXV2plaUNOd0Rq?=
 =?utf-8?B?QkRvN29GbWU1MDlIUTYwbDc2Tldqd0l5c0hoNzFsTUFwZnhHQWFVUS9hL1pN?=
 =?utf-8?B?enJPMUhlY01pNTRFUUFoTjNsYnVvUlN0bEJCbmRBb0pQK280MXBnTW1uZ2hL?=
 =?utf-8?B?WVgyQU5hMmVZTlVwdEFWcE1lcVVQdjhhWi8xM2JEYWlNVjJmTWNxYTZFRms5?=
 =?utf-8?B?NnFxQ2FsNE9zM1lBakFXZ0JpRy9YWmNxSnZMdWxFbUorWVNJbExCS2g4d3BV?=
 =?utf-8?B?dEhWZmdjYU9iM3o3VTJtejV6Y0ZJUU5hcURHeG5FbG0zOEFHTlFWQ1VoaDcz?=
 =?utf-8?B?Z0lXRnpaRk9NMzdKYTAya08rc0l0SEtWVmdoS1cxdkhkZWhkWXh1S09Rell6?=
 =?utf-8?B?aXptcUl1VjJBclRSVzZwUVAzbU5ZSFdWOFNFa0JQTU1IaDBNT2FYMTlFSkpv?=
 =?utf-8?B?N09DczFXZDdxYUhFSEpyVlI0YlA3TkRHSDhQZmxaeU5peVUwaFBWdENmeXdS?=
 =?utf-8?B?SmRzNnk2ZUtqRE1rdG9sSUY0N24vVlF2Tit2dmwwY090dXo2N3kvVHJWbE5y?=
 =?utf-8?B?eSt0WXBucThJUitKU0Q5V01TZ1Fwb2p5c0hTK1FIQ3lKdUN4Z0hlNXhMQlpB?=
 =?utf-8?B?R1ZFL2NJTyttZVR5OXlZejZjQ21DQkVMaEpPblhlVkw2UXRHUlUyVlFKVFVr?=
 =?utf-8?B?ZXVzaUNRRWhKUHlWaEhEODZKS0lqdU90MlV0emEwZkcxVmtJTmFaYk00SzZW?=
 =?utf-8?B?aWEySHJPRC9LUnhuWlFFaC93Z0tpclEwK0NhbUpZaFcvNnFUOXAzTFVKblBS?=
 =?utf-8?B?VEpYLyt4THBGaFF0azBvVnh4M1JEeTJ3MnN6M3FkVU5lbUs4ME95Y3F1LzFQ?=
 =?utf-8?B?cElCYi85enlFTGh1STBIM2VQWml3T2xlUGg0RWxMUlNQUWU1MWNla2ZsSzFp?=
 =?utf-8?B?REJpeEVqaHJsVE1EM3MyQkx0Q2UvY01GNlU1T3Jxa3p3OHRiekpsWVhSOHNI?=
 =?utf-8?B?MTdkYzJzcHJMR1EzV2FIdkpDWkwvdzhoa2J4d2NocmJ0VVlBakY0QXdUK3lu?=
 =?utf-8?B?OUJwVWhQNnZoZjMzVHlwU0l3RTFtblFxS1UrUnFnNmxsMW5hdTFSREl1SXNV?=
 =?utf-8?Q?a84/RoZsyafHk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZmUk5FbDF5OXh0b2dxb2Q0bHpaV3c2NVd3M1o0UlZteThGUWZOMEttL2Iy?=
 =?utf-8?B?OGZhOHhmY0hyYXlQVk9TZVpPeXNCS2RMMVhqUTJUYjBOVDVmMHJaMGtBci9v?=
 =?utf-8?B?Ynl0RVBUYUZBcEVCQkIyUkx2dUVLT1BNa2VEYVNCRHE0SHZCWTZPaTB3REZp?=
 =?utf-8?B?ajUxRStXRHdxSldibEE5ampUNjNLOHJYaG1RbVoyOC90T09tR1hjQ2VMdGVG?=
 =?utf-8?B?UCtCYjJkcWxmdXo0QlpPQU5BY25Zckwyc3VLRFJPdUpOWTB2Q1JyakNLVHM2?=
 =?utf-8?B?dUpxWDV2WC9sUzVjVHJLOVA5S1B2ZnZhR2YwaEwxSzZmbjJ3OXZ2aDVlTFJn?=
 =?utf-8?B?RE8zVEtkV0l4UXM5bllKb0hHQldWNVEyc0Qyc0JTOVZsYmdFckhmZzlaMHlI?=
 =?utf-8?B?K0hldnhhTHNHYjRXb3dSbXNtRTRITjhZNUtZaHY3T1JDekJWMWE3TFZ5N01i?=
 =?utf-8?B?ZjZJdGduaHBERTdXQnVXTm52S20wVDYzT25CenNtYVhSQTQ3V3lkWkJ5SFhL?=
 =?utf-8?B?T2tPenZyUzlvR2FxTEh4Y3Q0czdVWDd3WTBaeEl4MG5TUWU1RTluSUpUODNV?=
 =?utf-8?B?eXJGZm55WkxZSFo1bTY1Nkl0WnNLamV2bnRJc1ZDU3BnbDRNZXlmSkpycGY5?=
 =?utf-8?B?bnlnN0JicytxNWMvUEhGUEFzdXUzSExkMFpDc2p1SlU4aEpVN2N4ZHpCYVpl?=
 =?utf-8?B?UnIzT2VmSnhqVGthVGtkaXZ2NEdUM3JOVVY0Q2pzYWhvMUNSeXd6enFUODBS?=
 =?utf-8?B?YmtFbmtyN1VJZmxkeHVWSm9QR0taeWFGNWg3bE9nTHZpM3VMQmkwcU1oNFZ2?=
 =?utf-8?B?YnVTKzd3bk5IY1IybXVZaSttMzVrWGQwT1Z5ZDNPaEk2akhTeHhibURHWWtx?=
 =?utf-8?B?N1R0QWlBYmEzS24wU2hkdEJHZDRjRDhUMkRQL0psYVAvOFo3SkFBdjZPcEYx?=
 =?utf-8?B?NDViTWthNUxxSzFhLzdmdTYxTUhHU28vVDFkMVIwd2NqemUyVm0zOE1SMysr?=
 =?utf-8?B?a2hDWXFUTWZERU04bzJRa2xpUlJsV0xaWk00b282QTdNUEVpYWRZV0VCVUxE?=
 =?utf-8?B?RmsyZGl4REZFMkV0RnZvNG05OHVTc1BzT3kvUU9HcXBDeThLUUZKMHZTUHVL?=
 =?utf-8?B?eUxGK0pnYTFkQTcraVgxdHM2NG9hSVdkTFJqNXVrUHJzOVBqMmlXYW03L0Jt?=
 =?utf-8?B?a1RUWDgwYmVSYnpvbThRT2NUUkxjNVoxWUFRaHVZdHBkQzJWeFRSazJ2TWYv?=
 =?utf-8?B?RnlqZFdUYmE0OG15ekd3aUNiNzlsK1J2STRhL0ErMGtSZEFoM3kvL3JRLzNz?=
 =?utf-8?B?TTVCRHNvVWwxN05sdUYrUVRNdmhXSlI3SzdjalFFa3RxUnRFdzl2OExKYWgr?=
 =?utf-8?B?bEp2cUxhUUwvNGlNUXIvaWRYZVQxQUd1d0ZNTG1JRW03cTRLeDhXbTRDUWx5?=
 =?utf-8?B?cEZFSWlVdnFWWEVFbGM5WnRSRkkzcVp5WUhjTFU0QWJabVNOeVQzaDUvTE5p?=
 =?utf-8?B?MXBhbmJNYTV6RTVWQ2Y4Vy9aOWgwOWlVMjVUWHh3Smh4ZnNodHFjd2Rrcjh2?=
 =?utf-8?B?R1dqanJmMUlqSjVSd1hsNElQTW1TYThyUitTZUw5Vzk2N2l1MWNMQzVhQUFT?=
 =?utf-8?B?ekFLMzFaSDR0SzNtMVk2SDluNlpVK3JON3VZdmFua3Z3c29DUGF4QkR4NllI?=
 =?utf-8?B?bGlQS2VLMG8zZ0V2YW1DK0YwbmR5U2t5a2NtRG5IdGZMQ2xiU3hZdU9QSUVm?=
 =?utf-8?B?eUhUd2VFTmNZL2RkODFRZ2ZOUWNYYlhGaHVSeDRVZEhxem9PenFsQUk4UWNj?=
 =?utf-8?B?VHVRaW4xNmlXaVVQc1lnb0N1b0RPYUJyVHJMdll4clIxeUtmbmY3MzdZSWMv?=
 =?utf-8?B?N3Q0K1BNVnI0MTBlV2FGcmhCd2pXU0dsQ2ZxTlBiLzZ5SFg1dUhoRzg3QXR6?=
 =?utf-8?B?dlJpQ2FLdm5talhyL0Y2cUhWV2VCaXJPUnc3YkxqWmVXeDlVMmlzVVVjT2Z3?=
 =?utf-8?B?SmJxOE01cUhwNUJMdVhHVEdJNXh0K1ZzZytLa0trWDBSQVNPOU9KdDZtMXdi?=
 =?utf-8?B?N0JiSVVhZDJWMnN3djM4VjRJWjVaMk5ySTRFZWdIZ2N1cloveUFrSmVWN1BF?=
 =?utf-8?B?a1dxS2N0N1hqVWhNSmo3NkhlVGxuUDNNMHJLb0toUGlxVklOMyttZ3FHZlJ6?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BC34FB1C9856443B9AE37ED2B6ECB56@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e89245-1608-47c9-364d-08dcf414ded4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 10:16:05.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+sbAW2nXyWRYyFlLcxrKNEMbmVm4aD0KlqmTrlyRkm0+4q4lJKd8/ig1FEwMUbHcPQ7jGwAM9evApQ80vNkWj0U4EYoqeLHpd10JL6OrWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6822
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.147400-8.000000
X-TMASE-MatchedRID: hls5oAVArl+nykMun0J1wpmug812qIbzjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2dnC5uaS6tb9+Mk6ACsw4JkYvSDWdWaRhR0t
	Y+x+xl9zKqRF2qVKdqqm2F5bmDsa0s4so7we/Ix6JNmPl1U3LA0yNDX2PfTDJEd+K6O5Nt532/T
	ECug0ApTmD3HXcraDOxdcYjz7XHzXTHf8c/ToL3CmjEOrcO6AyTJDl9FKHbrlHZg0gWH5yUYO3H
	yUMPRbHDQsCrFHEt3Rl3tpAIdU89EL9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtAqYB
	E3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.147400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	690A11DA13EB619E7936A811FD9CEE8182D8BCE89408245EAFFAFDB2226685C02000:8

SGkgR3JlZywNCg0KVGhhbmtzIGZvciB5b3VyIGluZm9ybWF0aW9uLg0KDQpPbiBUaHUsIDIwMjQt
MTAtMjQgYXQgMTE6NDcgKzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBl
bWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRp
bA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24g
VGh1LCBPY3QgMjQsIDIwMjQgYXQgMDU6Mzc6MTNQTSArMDgwMCwgSmFzb24tSkguTGluIHZpYSBC
NCBSZWxheQ0KPiB3cm90ZToNCj4gPiBGcm9tOiAiSmFzb24tSkguTGluIiA8amFzb24tamgubGlu
QG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IGFjODhhMWY0MWY5
MzQ5OWRmNmY1MGZkMThlYTgzNWU2ZmY0ZjMyMDAuDQo+ID4gDQo+ID4gUmVhc29uIGZvciByZXZl
cnQ6DQo+ID4gMS4gVGhlIGNvbW1pdCBbMV0gZG9lcyBub3QgbGFuZCBvbiBsaW51eC01LjE1LCBz
byB0aGlzIHBhdGNoIGRvZXMNCj4gbm90DQo+ID4gZml4IGFueXRoaW5nLg0KPiA+IA0KPiA+IDIu
IFNpbmNlIHRoZSBmd19kZXZpY2UgaW1wcm92ZW1lbnRzIHNlcmllcyBbMl0gZG9lcyBub3QgbGFu
ZCBvbg0KPiA+IGxpbnV4LTUuMTUsIHVzaW5nIGRldmljZV9zZXRfZndub2RlKCkgY2F1c2VzIHRo
ZSBwYW5lbCB0byBmbGFzaA0KPiBkdXJpbmcNCj4gPiBib290dXAuDQo+ID4gDQo+ID4gSW5jb3Jy
ZWN0IGxpbmsgbWFuYWdlbWVudCBtYXkgbGVhZCB0byBpbmNvcnJlY3QgZGV2aWNlDQo+IGluaXRp
YWxpemF0aW9uLA0KPiA+IGFmZmVjdGluZyBmaXJtd2FyZSBub2RlIGxpbmtzIGFuZCBjb25zdW1l
ciByZWxhdGlvbnNoaXBzLg0KPiA+IFRoZSBmd25vZGUgc2V0dGluZyBvZiBwYW5lbCB0byB0aGUg
RFNJIGRldmljZSB3b3VsZCBjYXVzZSBhIERTSQ0KPiA+IGluaXRpYWxpemF0aW9uIGVycm9yIHdp
dGhvdXQgc2VyaWVzWzJdLCBzbyB0aGlzIHBhdGNoIHdhcyByZXZlcnRlZA0KPiB0bw0KPiA+IGF2
b2lkIHVzaW5nIHRoZSBpbmNvbXBsZXRlIGZ3X2RldmxpbmsgZnVuY3Rpb25hbGl0eS4NCj4gPiAN
Cj4gPiBbMV0gY29tbWl0IDNmYjE2ODY2YjUxZCAoImRyaXZlciBjb3JlOiBmd19kZXZsaW5rOiBN
YWtlIGN5Y2xlDQo+IGRldGVjdGlvbiBtb3JlIHJvYnVzdCIpDQo+ID4gWzJdIExpbms6IA0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzAyMDcwMTQyMDcuMTY3ODcxNS0xLXNhcmF2
YW5ha0Bnb29nbGUuY29tDQo+ID4gDQoNClBsZWFzZSBkb24ndCBtaW5kIG1lIG1ha2UgYSBjb25m
aXJtYXRpb24uDQpJIGp1c3QgbmVlZCB0byBhZGQgdGhpcyBsaW5lIGhlcmUgYW5kIHNlbmQgaXQg
YWdhaW4sIHJpZ2h0Pw0KDQpDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICM1LjE1LjE2OQ0K
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2RybV9taXBpX2RzaS5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2RybV9taXBpX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2RybV9taXBpX2RzaS5j
DQo+ID4gaW5kZXggMjQ2MDZiNjMyMDA5Li40NjhhM2E3Y2I2YTUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9taXBpX2RzaS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2RybV9taXBpX2RzaS5jDQo+ID4gQEAgLTIyMSw3ICsyMjEsNyBAQCBtaXBpX2RzaV9kZXZpY2Vf
cmVnaXN0ZXJfZnVsbChzdHJ1Y3QNCj4gbWlwaV9kc2lfaG9zdCAqaG9zdCwNCj4gPiAgcmV0dXJu
IGRzaTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtZGV2aWNlX3NldF9ub2RlKCZkc2ktPmRldiwgb2Zf
Zndub2RlX2hhbmRsZShpbmZvLT5ub2RlKSk7DQo+ID4gK2RzaS0+ZGV2Lm9mX25vZGUgPSBpbmZv
LT5ub2RlOw0KPiA+ICBkc2ktPmNoYW5uZWwgPSBpbmZvLT5jaGFubmVsOw0KPiA+ICBzdHJsY3B5
KGRzaS0+bmFtZSwgaW5mby0+dHlwZSwgc2l6ZW9mKGRzaS0+bmFtZSkpOw0KPiA+ICANCj4gPiAN
Cj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1pdDogNzRjZGQ2MmNiNDcwNjUxNWI0NTRjZTViYWNiNzNi
NTY2YzFkMWJjZg0KPiA+IGNoYW5nZS1pZDogMjAyNDEwMjQtZml4dXAtNS0xNS01ZmRkNjhkYWU3
MDcNCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gLS0gDQo+ID4gSmFzb24tSkguTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IA0KPiA+IA0KPiANCj4gPGZvcm1s
ZXR0ZXI+DQo+IA0KPiBUaGlzIGlzIG5vdCB0aGUgY29ycmVjdCB3YXkgdG8gc3VibWl0IHBhdGNo
ZXMgZm9yIGluY2x1c2lvbiBpbiB0aGUNCj4gc3RhYmxlIGtlcm5lbCB0cmVlLiAgUGxlYXNlIHJl
YWQ6DQo+ICAgICANCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJv
Y2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWwNCj4gZm9yIGhvdyB0byBkbyB0aGlzIHByb3Bl
cmx5Lg0KPiANCj4gPC9mb3JtbGV0dGVyPg0K

