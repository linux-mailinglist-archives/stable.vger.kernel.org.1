Return-Path: <stable+bounces-89146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D629B3F98
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532B7282AE6
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDE18027;
	Tue, 29 Oct 2024 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pqARgVoC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SxaZYurM"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E728E7
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164578; cv=fail; b=nws43N2ncQKZQz8lncgX7QE+ojS5QSqdTYfYTC6LQ46/Snwkpa9+z9XWqoZxjdTLAK8d0giLQfiYmRBRd78aFq/pNx9MNpTLwaiRvM8VqTv6jN1SiSBvL6HKuQae6MHkn+PGnv7EwvXgKVPUbpPDCCMr5AUmUfnioRigp6AtSvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164578; c=relaxed/simple;
	bh=DaSmcCXgic0tfxzjBxY9MnbrN6nW7k6svv95zftihbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ROtpxqJHwORk6LTjaRoHpAYSnHBPDLaCuuy5noRUo597MbAQrGaHWAgk+NYU+hzp8VfoGI1adVZLSG6yoaUFcDowCJfKZJ1a2JgUpmPj6wnxAJ8nTgeirnni92xaslv04qQ9GHpsUDALzo5b3TIdQdg/G4sSDh99Q87SsBzI1Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pqARgVoC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SxaZYurM; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 61d34ef8959311efb88477ffae1fc7a5-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DaSmcCXgic0tfxzjBxY9MnbrN6nW7k6svv95zftihbc=;
	b=pqARgVoCkBLFkgUWOqLT22JVIA3dg6vinQKFy/7abScMhfNSoy6wP6gB/dHxLeAJLghkEBYVhDznwLOgTewLjxw1/alkDGWsAie1gkMs/vcmj8SywXltVhJxmKbqwO62JiV8vKrYq4yvUzKRmoEghBpV++/nI6a4T2CONbpr9XM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:8f0e8c2d-a931-4b02-8d08-f7c704d6e713,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:0a1ff941-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 61d34ef8959311efb88477ffae1fc7a5-20241029
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1358414243; Tue, 29 Oct 2024 09:16:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 18:16:09 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 09:16:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUKwpubguEf+Bhdxc2AFvBgle64UyOlAflCnXa4VO8fYvhWkNzW66WvT/ZJ8QdQtWMtAOBDW2qJlIUeNEtiGG9swB/TPQuShdNrQ0ON9TH5nvKU0K+/42GbR07Nhtc1eCUfAM/y4STQH2V8IkiOzR4Wr4CMYDWs4hRY1Qv/hj5nA8sx2mTYVMHOHpAgQjdjsXIoG0Bc9XKTLyai2CkWITC7204Re08RU7xXXSPcCSwLLnrc1uUIN8kRDkRobqK0+BjTaKX9njbXNPTpZgBzehkLtr/J2vwHSxkvHeWWRKXNO6m4o4vukiVgRECy67mtuNEJa3eeCuDhFbosfsAwSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaSmcCXgic0tfxzjBxY9MnbrN6nW7k6svv95zftihbc=;
 b=FqiTv6AICocr927CTTezXlW8RANga3HdIgiu0SoWuBjZjfEzsQAh9PRP/Qpal5YrdFj1m7X0RK1rEhAC/A0SNN2A2QSELKEuRftYIuffPivMieNWVscB9tfXU6i1WCjhgKe5yxyZ1jpnkTAPJRlpK1pfWWbJHDqtDJpY6peLbNVI88qOcZAjq007O/+TAuBGpOcvRIAARNF7hcw4PouOJpdW32/VsRCDVx3TrSS2Y/H3W3jprK5QQdI1fGIzTBOUv6OIfBjE9lXIo0S9i7VJENQdhh63XH1JC4QqVenVGsh+zCsf0CQXBKR84xm1Ac7kZOz5mOq3d5Z+WKoUwlQuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaSmcCXgic0tfxzjBxY9MnbrN6nW7k6svv95zftihbc=;
 b=SxaZYurM4Fv7PKwNmI6zcvwaEInRVVCcfIbR4CAz6S1PJlO0NaBztgekOYwpetzSbnvBYyaCm32NNP8QdM9YbZgnp2zzfGd8RVTuINfpdF9xJX25m6Cs/t8tjfewXYwDOKmUke0Zc0XrJ3edjqWasyHc+iOU+twNlhsLMuD9nKw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7199.apcprd03.prod.outlook.com (2603:1096:820:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 01:16:05 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 01:16:05 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "saravanak@google.com" <saravanak@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= <seiya.wang@mediatek.com>
Subject: Re: [PATCH v3] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Topic: [PATCH v3] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbKQNXNn4udMCPekqwnYZNL5U9lrKcjQkAgABhLwA=
Date: Tue, 29 Oct 2024 01:16:05 +0000
Message-ID: <7bdbff5043e942cc419367083411660320fde16b.camel@mediatek.com>
References: <20241028-fixup-5-15-v3-1-078531a8d70a@mediatek.com>
	 <CAGETcx-kaXLPdZgDghT41=2uxN=Ck=kaAj5wkF_yqpjyz=6_2w@mail.gmail.com>
In-Reply-To: <CAGETcx-kaXLPdZgDghT41=2uxN=Ck=kaAj5wkF_yqpjyz=6_2w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7199:EE_
x-ms-office365-filtering-correlation-id: d5d6ade5-c2ce-49ad-15d0-08dcf7b742d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OW1vaE12cHpaeFVXQUpOcmVaREgzTFNYbmpkeitzRW5KamJ0L1RCeEh1OHJP?=
 =?utf-8?B?alRuWGRqYnFUM096c0ZkU3R1VDB5VTY0TWJRL2tpb29oQUFhY2daaEs3VUhS?=
 =?utf-8?B?aVk0eTlmd2xMeEVHcndaek4rMCtkODlYN3BsdXZtMmswakFaUS9ORVN2bHUx?=
 =?utf-8?B?YlFRL1NHSFpxV0hjTG1QN054YVVmL05FcCtCajhOZ0JzNEZvejZVbjlMU1lq?=
 =?utf-8?B?M0ZTbkM0azZZUzh0a05KOHltZFNlc0pUQjM1WGVSS0dhTld2eS9NWEx6M3VX?=
 =?utf-8?B?TjdpYzZ0RU0veEU5Qlo5SmhRZnl4SFp1MC9CZG9mU1h0bzBIN2RZWjAyc1RH?=
 =?utf-8?B?NGpMWHJZWlNWbmk1MXhtZ2pNOUJOMWVhWG5LOVhyM1RzVC9OaGU3R1lYYlNs?=
 =?utf-8?B?eFBsc08zcGpGSmRneFJrL3IxRU55NDdlTVg3QTBXN0xoK1NGNHIyYWhVWjBU?=
 =?utf-8?B?NUtTNk5OK2xscnhZemhwM3dCdEEyaWhIK0tNTG1GdysySC9sNnpJb01vTng5?=
 =?utf-8?B?UTZrYWl1dlVsZzBubm5UeCtVQnM1VEtBNGNIWnRsY2E3QjBHSjdjU3dJVENW?=
 =?utf-8?B?Tm5vUFNRU2V3T0t1Y0tvL2orMkVsZmJzUjF6a0pJYjBUSyswcU93MGxFZTBr?=
 =?utf-8?B?cXdWeFIyblAvSmo2NFhVUTgzRndzTmJZY3NpU2JzSTAwUGRLeUl4MjZDSHlX?=
 =?utf-8?B?SEVhSUlxL1RLc1hUaGRvVFJWYVNZQ3Q2aCtEdHRDVFN4QlR0cGkwRzVVS1Aw?=
 =?utf-8?B?eHB6S3ZSek9iL0J3UjlwT1JHMjBGUFVBV1FJTjVJK2tyWnFRR2xwYW9PS1gr?=
 =?utf-8?B?NXI4R1BVVWdENytxQmNhT09INGZ2eC82Y1VBclJTVmVLQUhEMEdwVUdobFhD?=
 =?utf-8?B?b1BDZ1BIUmJkemN4T2ZUOGlJalhIMU1xRFdZaTh0N2JZMlV1QmxtSlNMeWh2?=
 =?utf-8?B?ZVZKTis5RTF3anI3MTVGdEl6QnJ1Z01McXZvN054WHRUcVR4clQrWGVQd0VS?=
 =?utf-8?B?UUJhTkZINXlteU95d2lkUUdMRjl3Y1ZGVVdMbmlaNjRRaTFhSnNVNDc5QlZW?=
 =?utf-8?B?U1M5QW5hVEFIREUrbVZxSXo4S0tXaHl0cFFtQ1BBYzNtUlVnYlUzeGZnaHFI?=
 =?utf-8?B?dEszWUNCY3FUZHRxYk5lZ3EwaTJHV2QwaG91Ni9Ta2MzK0lISTNuRGJoR00x?=
 =?utf-8?B?V01zdGZtcHJ1UW45RTE3bVdXUys3VU1WMStraGlRQnFOSmd5d2hHQkczU0VJ?=
 =?utf-8?B?WnlCWnhUNGxPeTgzenhicUVMbEx4VFFEUW9jV0lHTGVjaW92RG1IRjBJNzJQ?=
 =?utf-8?B?N2NEekhCME5RaXJQWm9GUFRtZU5ScnZmMERoREVFdDE2WXhOeE9LL3NMVUNH?=
 =?utf-8?B?OUtSSmt6bDJvRUxRWTRhZ3k2Z3I5YXJpOXFsZEdwblRGN1AzUmdHd1BUNmZT?=
 =?utf-8?B?dUFldDhWWnpLSTl5WHcwaWVJQUNlVUNxekF5K0lUZ2paTHpPNElGWUE0bTF6?=
 =?utf-8?B?WlMra2tCb0sxT04vOFFsYldVbzVoU3NmeEZJWVNEeVIvVE5jRENrZUZCU2hN?=
 =?utf-8?B?NVdscDJtSWRzdFpPNWRueUlzSmtncnpLZjlYLzdrQURiYmcrdlQ1allIOXlO?=
 =?utf-8?B?L3JNaHpqMmZZelVmRlIzR3VTSlNyelBvK2NoeFdNY0VXZVhaM0ljbnB0R3lC?=
 =?utf-8?B?UFo2dVdhNHcyTE0yNVFmazJXRzUwZHQxRk9FeWMwSHM2THZNdkV4dkVMcmFk?=
 =?utf-8?B?dTY3Sk9kZ2VUMCs1Uk84MmtXZ3VIa3d6aUNXRklHVFJRL3ZFcnZlbnd1Skxl?=
 =?utf-8?Q?qQA3orW+hf7/N6MCk+JbmaCfLfvNyaVVMVjUw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVg0dmtRR2VpY2drVFcrUGtNV1pTOVRKTU82M01jNTQ1ekdNdENZR3d4OUV0?=
 =?utf-8?B?a2pBMmhGTEM3dTZQa0Q2TUFnQVVRblU1cTZ3Y2ltTEdlL3JEN1d5cHdNT0Zm?=
 =?utf-8?B?Mk5LQTFyRkpVZUJubXQ2S2hLN3BWNzVVNUlLdFArNWxhcjlsalM5Yi9CZHdt?=
 =?utf-8?B?U2pRTkxIVEV2bmViZ1lwZjZXUnVianNyaTgrMU1RYVZCTklLWDNHUVFSSlFZ?=
 =?utf-8?B?Sm5oSVJSc05xZ3pvUEh3akVzQkFuVDZ3VzV5a0VoVTV5dUxRTUFQNkdHUmcr?=
 =?utf-8?B?T3hPRXo1Sjl0dU9ieDJVZXNZQmhweEtmNmh6VEp4R01FNDM3VzJLNkVhYnhw?=
 =?utf-8?B?VzdoM0ZSMHkyTVdPQXRubEtCOCtvVFpiZUVUdE4rSE5mcW8yQ0pSUW1CTUFo?=
 =?utf-8?B?SmM0bnNXaE5iWm1wSlY3SlF0OE5yU2h0RHZUUVhwTVhDdTdTU1dEVlpENWd1?=
 =?utf-8?B?NUpvNlhuRitQbmNnMG1lMEhkaGwrZmtOZzhkR1Q3YlNuUW9aTXh4YVljWVpR?=
 =?utf-8?B?Z1ZMTlJBaFVFTXVSREZDS3JjeEZScnpSc2RRc0JIaGlyajVWa0Q2L1hmdTNq?=
 =?utf-8?B?L1dLQ0JqR3l4UWNiZXVtWmpZNWVTOWhmVTdJWnJUblpnUUYzTnF5Y3NGQjc1?=
 =?utf-8?B?dW12c3VMbXVQOHpxZldSMVZ5QTlvQ2NSWmh6U3N0VWR1Z1lkNitHT1ZQeHlY?=
 =?utf-8?B?bWg1L2pwNkRVaTltQzFvYnNYd2hFbEVVZjZCdHZUbkh0dmM5Zlg0cGxVc0oz?=
 =?utf-8?B?aVpsc0JUbGU3S2lXNW9xZlBoeFdIZk9peW1tWE1kOE1EZmN5Snc0OEhCZ0VM?=
 =?utf-8?B?dTJJUVVSYUF1OEo1ZGhhZ3JFQlRiaGhtYTVBOEZMaTZXR1k2c29CeGRSOHFG?=
 =?utf-8?B?aWRqM1VhWWxYWU9aQ1daNmdRajRZeGFRdU5nQmEzTlo2SHVxVFJtaTdORm1u?=
 =?utf-8?B?QzQwV2ZWU1c4M245dXJuWjQzU0ZGMG9mRFNvWitEdU9vcUhnNmQyYWpiOUxr?=
 =?utf-8?B?ME5acDZLZHEyOHpFTnVQcmtIWHJzeUpGNllUU0VGUlFiNk9iWlJqVDBmYWNV?=
 =?utf-8?B?ekdLL3FZS09NN3dvTmFjMFN1RUhPbHg3RWhTMFFuTlF0YnlVcERaclZRN1Vm?=
 =?utf-8?B?SGRaa0dQaEd1ejUweExldnVYZmpKSUNYUE1wSTE1VS83eG1CNHpGM1VBbUM4?=
 =?utf-8?B?UXAyWUk0T0h3VFU2QW4zUDV4bWdNYVp4UFQ5N0I4VXR5d284Qkc5K2ZQZTVY?=
 =?utf-8?B?ZUozSnZTN2dIMnd0QkpnaUJUbGFVa2JwbWI1ZndKYTZUdnU4REZ5NzVuMmtV?=
 =?utf-8?B?d2pXWmJYV0VmdmxIQ0NNR0h5N1BvS0ZJUDlSaVJ0ZkMzRThOQ0N5TXRMeW4y?=
 =?utf-8?B?TlQwS29PL25ydm1DcW0zTjF1bFlxN2owRmlDdFZ3MVZsRGRKSVVWamZ3cFQr?=
 =?utf-8?B?Z2c5SnNKd3pJRE1TdEhtTHJTZkh4VEtTL2NGcVdXbzJmV3NmczJMdDVYaXhp?=
 =?utf-8?B?ODRCOVZFWUhERG5RenZLcHNTTlpoL012TjltUWM5b2pzZnZoZEZXZEEwaWdm?=
 =?utf-8?B?SGllcFBSQzlnVUFGbDV4QzloRm5ORlNRR2o3ZDVBaENzTnJUa1ZnWWpCbnow?=
 =?utf-8?B?aUpVeDIwbnNwM3oyZnFyb3hzekZITldrTjZHcTRuajdMSWdVRi91dmlkMUtT?=
 =?utf-8?B?eFRBNTN0eld5NUNNUFozdWF2TlpHQnl6TGVtV1I1YVFWQXJ5c2g0ZDZZTVll?=
 =?utf-8?B?SUJvaUxtb3JUVURMSXdxNnhNUVRlZjhHWGpKS3UrK2N5MDRSU3Z3d2pFeE5Y?=
 =?utf-8?B?T3o3YmluZlplR0tlRkQ3a3ZkdlgrL2FQR0ZaU3gwUnQveThQY3FLVmpxNm83?=
 =?utf-8?B?bjRZSUU4WTdGbldZYVRWaFJHcEN5ZUd2eCtFQ0ZSWGE4S2M1NGVFUndmS0VU?=
 =?utf-8?B?MndjYXFYSUU5WThWNktIbWNJanpWNm5kcnJ0SWJvUEZIV0ZOeldZaU5UeEFG?=
 =?utf-8?B?bFhsbzNJczcrMjRlbVBJRS9jeFRWR3RsMkgzYkNkcEZuSTZEcUEzNlFtVVdM?=
 =?utf-8?B?bXltTDY2WFZTM2xINmIxY1IxMCtVWk1aaGlrRWxzZTVhL2xZclJNS0MxeENY?=
 =?utf-8?B?MDlUL0Q3R3FtZnhKZlFIWUJvc0FiUUxDZCszSkJCeGJHRDNPM2YwZFJSbEZ0?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F53DAE265181C49B14BFA0F4D49FCB2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d6ade5-c2ce-49ad-15d0-08dcf7b742d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 01:16:05.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scycCOao9EwX3/e0rTVaQkW8SsFAhEYYhTfGp2imexLJ7YseO5Cro84Ka3wAa93+zu9RU/XvZ+1RRNcqyn/vvL8rzDXSpCW57/Fanw8coB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7199

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDEyOjI4IC0wNzAwLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gT24gU3VuLCBPY3QgMjcsIDIwMjQgYXQgMTE6MzPigK9QTSBKYXNv
bi1KSC5MaW4gdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK2phc29uLWpoLmxpbi5tZWRpYXRlay5j
b21Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogIkphc29uLUpILkxpbiIgPGph
c29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gVGhpcyByZXZlcnRzIGNvbW1pdCBh
Yzg4YTFmNDFmOTM0OTlkZjZmNTBmZDE4ZWE4MzVlNmZmNGYzMjAwLg0KPiA+IA0KPiA+IFJlYXNv
biBmb3IgcmV2ZXJ0Og0KPiA+IDEuIFRoZSBjb21taXQgWzFdIGRvZXMgbm90IGxhbmQgb24gbGlu
dXgtNS4xNSwgc28gdGhpcyBwYXRjaCBkb2VzDQo+ID4gbm90DQo+ID4gZml4IGFueXRoaW5nLg0K
PiA+IA0KPiA+IDIuIFNpbmNlIHRoZSBmd19kZXZpY2UgaW1wcm92ZW1lbnRzIHNlcmllcyBbMl0g
ZG9lcyBub3QgbGFuZCBvbg0KPiANCj4gZndfZGV2bGluay4gTm90IGZ3X2RldmljZS4NCj4gDQoN
Ck9LLCBJJ2xsIGZpeCB0aGlzIGluIHY0Lg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4g
LVNhcmF2YW5hDQo+IA0KPiA+IGxpbnV4LTUuMTUsIHVzaW5nIGRldmljZV9zZXRfZndub2RlKCkg
Y2F1c2VzIHRoZSBwYW5lbCB0byBmbGFzaA0KPiA+IGR1cmluZw0KPiA+IGJvb3R1cC4NCj4gPiAN
Cj4gPiBJbmNvcnJlY3QgbGluayBtYW5hZ2VtZW50IG1heSBsZWFkIHRvIGluY29ycmVjdCBkZXZp
Y2UNCj4gPiBpbml0aWFsaXphdGlvbiwNCj4gPiBhZmZlY3RpbmcgZmlybXdhcmUgbm9kZSBsaW5r
cyBhbmQgY29uc3VtZXIgcmVsYXRpb25zaGlwcy4NCj4gPiBUaGUgZndub2RlIHNldHRpbmcgb2Yg
cGFuZWwgdG8gdGhlIERTSSBkZXZpY2Ugd291bGQgY2F1c2UgYSBEU0kNCj4gPiBpbml0aWFsaXph
dGlvbiBlcnJvciB3aXRob3V0IHNlcmllc1syXSwgc28gdGhpcyBwYXRjaCB3YXMgcmV2ZXJ0ZWQN
Cj4gPiB0bw0KPiA+IGF2b2lkIHVzaW5nIHRoZSBpbmNvbXBsZXRlIGZ3X2RldmxpbmsgZnVuY3Rp
b25hbGl0eS4NCj4gPiANCj4gPiBbMV0gY29tbWl0IDNmYjE2ODY2YjUxZCAoImRyaXZlciBjb3Jl
OiBmd19kZXZsaW5rOiBNYWtlIGN5Y2xlDQo+ID4gZGV0ZWN0aW9uIG1vcmUgcm9idXN0IikNCj4g
PiBbMl0gTGluazogDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMjA3MDE0
MjA3LjE2Nzg3MTUtMS1zYXJhdmFuYWtAZ29vZ2xlLmNvbQ0KPiA+IA0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnICMgNS4xNS4xNjkNCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyAjIDUuMTAuMjI4DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA1LjQuMjg0DQo+
ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vZHJtX21pcGlfZHNpLmMgfCAyICstDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX21pcGlfZHNpLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fbWlwaV9kc2kuYw0KPiA+IGluZGV4IDI0NjA2YjYzMjAwOS4uNDY4
YTNhN2NiNmE1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fbWlwaV9kc2ku
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fbWlwaV9kc2kuYw0KPiA+IEBAIC0yMjEs
NyArMjIxLDcgQEAgbWlwaV9kc2lfZGV2aWNlX3JlZ2lzdGVyX2Z1bGwoc3RydWN0DQo+ID4gbWlw
aV9kc2lfaG9zdCAqaG9zdCwNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGRzaTsNCj4gPiAg
ICAgICAgIH0NCj4gPiANCj4gPiAtICAgICAgIGRldmljZV9zZXRfbm9kZSgmZHNpLT5kZXYsIG9m
X2Z3bm9kZV9oYW5kbGUoaW5mby0+bm9kZSkpOw0KPiA+ICsgICAgICAgZHNpLT5kZXYub2Zfbm9k
ZSA9IGluZm8tPm5vZGU7DQo+ID4gICAgICAgICBkc2ktPmNoYW5uZWwgPSBpbmZvLT5jaGFubmVs
Ow0KPiA+ICAgICAgICAgc3RybGNweShkc2ktPm5hbWUsIGluZm8tPnR5cGUsIHNpemVvZihkc2kt
Pm5hbWUpKTsNCj4gPiANCj4gPiANCj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1pdDogNzRjZGQ2MmNi
NDcwNjUxNWI0NTRjZTViYWNiNzNiNTY2YzFkMWJjZg0KPiA+IGNoYW5nZS1pZDogMjAyNDEwMjQt
Zml4dXAtNS0xNS01ZmRkNjhkYWU3MDcNCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gLS0N
Cj4gPiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4g
DQo=

