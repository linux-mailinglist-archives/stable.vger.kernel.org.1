Return-Path: <stable+bounces-89147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A009B3F9E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66141C21D1B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 01:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEF22338;
	Tue, 29 Oct 2024 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tSiY0E2E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M2hxO03D"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7428E7
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164685; cv=fail; b=H9qAnWXuaI+K1bawAjezWZjbobXL1qkf4Zhb92aflptooNKCPeGqySVo7II11jGyTcoBSuH0IHBhEk+/0sOOgL1aFZOrRrHG3QBrL5+yP4zNsOoX8Hx6QgHU2P120/I8Cuyb3z0I3G/8cmoS2H3nP3Byps6d4L1/jMADttcBn5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164685; c=relaxed/simple;
	bh=7wK6Xcd9uvwdre+bXADoIx9GRuCF0e/Zm3O7PsrqM58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sR8f+rqV9E43DmGOD1FTzLeX0buk2KY2nt/a2Lo+TULkiRA6jyS5yfUKe0taADx5qqlnG5P26nJ4S/HUT7o4fIyX8w3JwBwN+IqM0daRuaSRexqo2CwprP6OlzEBqwc4FVT5gASNI9F9/jkKt128wVR85328oxRyi3lRQN9pQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tSiY0E2E; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=M2hxO03D; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a1674902959311efbd192953cf12861f-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7wK6Xcd9uvwdre+bXADoIx9GRuCF0e/Zm3O7PsrqM58=;
	b=tSiY0E2Ezu6PKXovEbKndaxM1Tqp9nU2tpa/aLc1VLdsri2kAeOwRb2x+Vq0B7Uo+KvpBsRRj/wmHKG7TdbF2CKVcc1IBryposDO1YnPuavm/THaebM5pTlM2ClfnyhneznjhE+tfm9ub819xBqeqKEvsKQimQA+aguVqItOL9U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:066b56ec-01e1-4595-94b0-8ce06fe0044e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:3fb900cd-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a1674902959311efbd192953cf12861f-20241029
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 974597008; Tue, 29 Oct 2024 09:17:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 18:17:56 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 09:17:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRRcLMeFN/9bIpNCoQS9wNEjzhLV5/OlYoT4+RN5Dl/0E44BTFwJTWnyWTgj9VdkGPuO1mFpa/rsDc7Ljb4RgofLSx+sNWnm6lJHBFpXFLtUwcLWVkvyi2clFdVJzsEhezbsZIhWNYKenhul4mqZ703EHHQ/euhGV9B+wDq4pLPsyqScjGgWG4H/c0yS7Lb8YRpdrTxHlrMhYW58wXuLEjbKmxDBp591AIpFgThQ6pPf3A1ZzMUc4VmKI6dElNcjoMykd1TaSFccsiGTJy8ONchQsgSnrAGSsLa6+H6DSA5nf98KpXrahJEipjFVsR4+iFk5KbXIs+SbIqASEBYVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wK6Xcd9uvwdre+bXADoIx9GRuCF0e/Zm3O7PsrqM58=;
 b=OWkBqsjgZV9T0RM99NWcrb9kQcYVFW++YCV9fNDfMEC1cnoty9502c0z9kcbfkuUIgdHJeVNXjE0MGHlm3ZTl6CHANNRnAbl/E53XSYa9YL14d22TIPDmbB3tAXN0/NgnueJTsCSD/FgxSu4hzC58MVV4wGZvWjkbR/yLhDHf/FrYy1Y6/a/O/4mJXGSbehAdM0nBP5WK3v2RNdCiRcNdmgXpWs/8pClq0A/w7qTB4M1iN8SrjpDi5u7q+7r3A6taH8NplK9FMFabJTTYTOQMziH7GPOALIUnSwyFISxuPCt5O8aqzXwZH5ISGU4y91GTU45GH9waGw41Bq1dpp7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wK6Xcd9uvwdre+bXADoIx9GRuCF0e/Zm3O7PsrqM58=;
 b=M2hxO03DzY3ZQ21n+8Sj5nUCrU8DQMao14u+p08sPJgjCoZDA8nw1mgzl5ecuGlgvWQPBK1wIYUQ3/pITKuGGvH6ElFUs1M2uv9ZH/1c2N9Z4vUgrk7k/8/XhGTRIZ7SAPS/iEyqQFLouWhedYrmL5hQoVJiVnxosWSrG7js6oM=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7199.apcprd03.prod.outlook.com (2603:1096:820:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 01:17:53 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 01:17:53 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "saravanak@google.com" <saravanak@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?=
	<seiya.wang@mediatek.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Thread-Topic: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbJf/SXPr1B+Q5Zk+EOWAsF0zUX7KbqyAAgAAVz4+AATPSgA==
Date: Tue, 29 Oct 2024 01:17:53 +0000
Message-ID: <60298355ca17a2402bd5e6da95ccdc60cd49cbbf.camel@mediatek.com>
References: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>
	 <2024102847-enrage-cavalier-77e2@gregkh>
	 <0e2fa50d4eee77f310362248cb2f95457ba341ad.camel@mediatek.com>
	 <2024102801-canopy-cruelness-ee23@gregkh>
In-Reply-To: <2024102801-canopy-cruelness-ee23@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7199:EE_
x-ms-office365-filtering-correlation-id: e806918a-7930-46be-79e7-08dcf7b78394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlczcGpXRVhYbXRDSHJpcGFvNEV1NEp1U3dianB3Q2JlMEhMdDE4bjIvSDYx?=
 =?utf-8?B?RHZYbjFtemRORTlzRjRWMWxRRkdkZG1yWTIvWDhVM3UycTBYV1I5RmR0Skt6?=
 =?utf-8?B?d25ma3pqa1E0alFFb2c1bjl3elk1c2Q1RDl3bk51aUhRVW9nSk9aeEtjWXBF?=
 =?utf-8?B?OEtVUEV5RkdZbnJmaXI0OW9vcC93THIzWk1TUkROV0RnSEZreExvL082UmUr?=
 =?utf-8?B?amFwTDZqWkd6akVzcmIyakljVjBiU0YyWGk0TGJYV2NpUm5iOElyRjRNbmdZ?=
 =?utf-8?B?TE1mQnk2V1VQVWpDS013U21sOVRKSDNTaHVwK3FuUDU1SUE2bWFyWG1IdW9X?=
 =?utf-8?B?UkVOQk8yNTF6RllHTFc3Nk5aazdUcGlWWXFvSllMV01VVTYxRTB2YjVMR1VQ?=
 =?utf-8?B?UFpBQmQrcVA5NkxRcWRwckVnaENkRXFHVGVJY0VOZlcvcWZKVUVxdzZVVTIx?=
 =?utf-8?B?MmRURW8xeFRkdFBWWm1kTFNPQ1pBeW9BQkc4NFA3L2FuQ1Fab1JtR1F4dmhO?=
 =?utf-8?B?WlFNbHdZNnEvbzlrNVBoSWpBQzk4QVlSc3k5RGQzbnNSTW8wV0V1cXBjTkhT?=
 =?utf-8?B?a1UzU3JlTVlFU0t2T2lLbEdlYmhlL3NZUHNDSGhYTUhCMlVEb3VCRjBGNlpH?=
 =?utf-8?B?RGlVQ3VtRlhqT2ZLQ1pzVGdUbVNnUzZiNEJKT1BXbU9JVis4QjV1dCtXanpC?=
 =?utf-8?B?M2pYdWdVS2h3UVl4d0p6dHZIdWJSM25ZWjRCdVVSaTJzczdha09sVGFrd0s0?=
 =?utf-8?B?cFVPRjJQeGUyeVVaTkI0ZUNHcWZHT01DNWRmaWdrZWhYK3U1R0lrbGkvZGpl?=
 =?utf-8?B?Qi81eHJTNFNvcGVrWG9mcVBPOG1PMjRVT2FsUG1sM2xGSGtlWGFwQk5vUWdD?=
 =?utf-8?B?NHRDZDJpZEN4ZDhZd2lZZnZ4QXJqaVU4RmEza2tFaE9ySURjNDNLYjJjU1Rs?=
 =?utf-8?B?cXJqRUZHNktkQ1NWdDBuWE1PTjU2S0VBZkRQTkx2SlN2R3VZK1lUM1RGWHU2?=
 =?utf-8?B?ZG0rMEFreEt1RXBnZ1BlbGh5dTlGUFU0Y25GblRlZ0RaaTMzSU1ySHNYUGJz?=
 =?utf-8?B?MzY0YzlNU2hYb3NDZjVUa0tTSFJ2dGlwc3VMWWJqUHBCNGc3enBZOERyM2FR?=
 =?utf-8?B?Y2tJbm12aUpNYXZtWElrbjJrbHZhOEUvUU5qUnNKOTJ5OTdZY2pZcDIxb3dB?=
 =?utf-8?B?TU15TG9KQjAyRis3dnZvOHFWM2VQbGxGWW4vWFR5ZFJhZmt5UGd3YzhheHJw?=
 =?utf-8?B?aU40eFhWQ3hzcG9Vd2ozZW5YdlFZMlRSckh4dWlwRmhUeUJMS2NRYkJqZlVG?=
 =?utf-8?B?TThIQkszZzcvN05PNEw2Mmp2aEFwcWRlUUM2UUVsdkV0aXc0UW9GcTBZdllm?=
 =?utf-8?B?WkJTaHZLWlczVTFlUUt3K1hHOVZROFdkdks3b3AybmtLUTFaVVg2WUFCRGNT?=
 =?utf-8?B?M1hDOG5WYUFrenhnbWg0c3FuUVBSc1BCWVg5NHd0eEZ3N0NrUkxDVUVNNUJr?=
 =?utf-8?B?TFdZSVlKOVJOTTU1M3NBNTlvd0t2blJ5MkJXcEdXRE52QTlwWG8xbFprR3U4?=
 =?utf-8?B?bzFpOHJnV3hMbE5BSUFmMHBOeXJnK1lDMVY3VGdmOXlPcjlNYUJoSkNtY05G?=
 =?utf-8?B?SGlGTTVFN2paZGtyMWNxSm5ndmwwUVdLd1hMbUJtOGd5UFBIRjNtbTk4bHJw?=
 =?utf-8?B?TjBGcmdGVzBGMHZ1UkJxMlBTWjhqS1JMMmJzcDIzbk00L3M4UW9IVnVZckRG?=
 =?utf-8?Q?cG4HADerb8mF57+uCohDzXGJLYykZeyOQORGa2P?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkw3TERvRGpnL3FxOEVTQVRpQVI4V1VlZmJrZTZSczJGNUhieG9TVWRQYjZV?=
 =?utf-8?B?STRJZS91RDNWMDdkTXJYZHRWbGkxZER5SmR6MGxCZmErWUpONDE4TUZSMzNR?=
 =?utf-8?B?MWdlREFBYXlRTEVwbVdlamdSTkVPNnYwQmh5aVNtSFRDUktUMXc1OFZibHRS?=
 =?utf-8?B?aEI4NjhUMW50ZmVEeVdzbmhMTUtwL3p0UG02elgwTzZ3RXRIcEs3VWNBbTBH?=
 =?utf-8?B?WEZCcHdSeVpQbHFoUHFCTXg3NFRTUUE1RGRLN2ZQeW03dG1XRmh2NW9RakF4?=
 =?utf-8?B?MU5GUVhHdWJUNVdHdGZ4Y1BRdmpWaDM5bnFSUm5rRk5mYU1tcXJKMXExdzIw?=
 =?utf-8?B?VTRnQWdHZlVzc3VJYm9LR0hHMERCekxPRGNOelNTSFBlV0NWTGZad01ING0y?=
 =?utf-8?B?akM1Q1hDLzA3TjA5dlFVOWpYbVRldVNjVllGZlNTcmlTSVNKN2hYK1RpdkdZ?=
 =?utf-8?B?YStxWGdLdVd0RTN0cEZsWWV2bXRpWmo2MUhwZHVxb0lFOU9VTk5qSVUydmVG?=
 =?utf-8?B?SmFOWjRIWmk2b0E1b0tRUjhiK2ZyY2U5R1ZFcEdobkxueHZDS09UczBRZito?=
 =?utf-8?B?cXpTb25VejkrTFgyWXF4VnN1V1loM2twWFhzL2w0NDYwTGh6cDRpRzl3SXFI?=
 =?utf-8?B?NVZCYmFBaWh0azVBUnZPbzNjcnpEeXd4RzN0QkpXam5IWEZaTDVsYXd3akto?=
 =?utf-8?B?T1Q5aU5NcEM5bUdZV2VONGZiandwZjJWMU5jaE5PQUVOU2hmYW5qWFRyU2RG?=
 =?utf-8?B?VjlWdjJrNktydXZPNzNWSjhSL1FMbFlNdjg1WDBaampjOVV6NEZZQ1JiamN6?=
 =?utf-8?B?dnd1MFl4QkE3a2E3cEJMTUMxdXU2R0NBMkQ1cXpha0lxQk44VFljUkdYam5j?=
 =?utf-8?B?dFhDUkNhS21zdEdtdDJxWGttRnh6ZzBtcDd1eUwrNXROYmhFNnFGMEpWVW8r?=
 =?utf-8?B?cWJHSlJWbmZGQzgwQVlGNm5FZmFQUU9ndStrWHdYTGFhTitkUkNJWDZIbk1r?=
 =?utf-8?B?L0l0NWY1aTB5RGJJQnE1Mk9iRUxXOUg1Ris3Ui9sbG5sUGJnVWZReXJ2SXVK?=
 =?utf-8?B?UnlUMlJja3k1RVFTbUM4eWt2MjRGZkoxaVB6MkJvSEtRWFVTL1dzOGFvb1pM?=
 =?utf-8?B?bGNvaHN0MUZRWTEvRDVCMlVkL21ybnJMRHNWT0pmakcyQVVJMkRGaXc3VW91?=
 =?utf-8?B?UklkMmE5U0dTTGh5V1dJYytoN3puQUljMHY2Mmp2U2VEVHZMYnlPTWNPQ0VG?=
 =?utf-8?B?eFZUMW9peVhrT0FXQnlxcWRIdENJTEErK2pKOHhETHVjcWJWbmFEOUl4SDl6?=
 =?utf-8?B?c2lFdDJCU1M3ajBmU2UraEMrTURPUFNlcTIyRXpWdEhRVTJoa1B4TE9BM2pH?=
 =?utf-8?B?b3NuK0c4bmVFeHY0WDFhWUNPWGl5N3FaU3IzWjBxUzJlRldGdUp2Mm1OM29K?=
 =?utf-8?B?bllyRU9qdGdrWkNCYm1jcGpDVDJXR3IrLzY5RnU5aUE4c0k3UnBhNHVTbVA4?=
 =?utf-8?B?WndPTzJ3cXY2RVY5WkI2ZWgrUjVnZW80ZXNUWWxqcTc4dHFaTTFWR3BQTFll?=
 =?utf-8?B?WnFqVU1adUI4SVdCbk85Mk1WUW9NNG9HS28vWTRXVWhZZExJUGJ5b0tOV2U0?=
 =?utf-8?B?aEpiT3JudjIraVpKVEs2Wnk5NDhVUWVPNTZuQUtBcXJjSExrdjRqaUtKRGY2?=
 =?utf-8?B?V0RTTWNaUThGQ2s5MndyQlE5VHY4NkUzazJGdGlzSG5YSVZsZlBWQ2ZMSEVu?=
 =?utf-8?B?Wm5kVmExNFRZbVJzZzY5RDlBSmxaNEREVGZaYnNUeTN1ak1WdjFnclRUSnRK?=
 =?utf-8?B?cnREQVZiRGhJM0Z1a1dRa254ZmlIb1YvSFdOZFU2cm1GS0J3ektRT0FPS2I0?=
 =?utf-8?B?cjYzWERLNmtjd0JWTmk4QlpJLzFUOEJxeHIrSURiSzBPYVBPM29TcmcxYy9T?=
 =?utf-8?B?Q0lsaCszRTRnVVRVWk1Zd1JybG5nVVBTeW5SOHFPalY1N0ZaTzRUWWNORi9H?=
 =?utf-8?B?VWw5VnBXTGpMUXpPSVU5aXV4WGdYcGkvdUZTbUlVeEZ0UG5IbDBGYWsvMlhj?=
 =?utf-8?B?dGlZcDJmS04vTWQ2K2p6cVovVENDeEhndktxVHgvbmdCYTdBQ2k2OEhzQkhD?=
 =?utf-8?B?NUZrK3FBbmltUnpRNUt3ZU1qY0hkblduM0ZOQmFOZ01tNVFjOGRyMThIczZR?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A936501C5D0CD4187A3AD39ADA5F14D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e806918a-7930-46be-79e7-08dcf7b78394
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 01:17:53.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pNT6gxlsOpUHoNSlj8BlSyAMR+YgMO8HzZd1uR+e2TeuH8nkPxsuEItuYwV0rCjp1ZVR/J49pQwspE9BzJGWmYcYlBR+BEDnbVzJw3rbxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7199

DQpbc25pcF0NCg0KPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUuMTUuMTY5
DQo+ID4gPiANCj4gPiA+IFdoYXQgYWJvdXQgNS4xMC55IGFuZCA1LjQueSBhcyB3ZWxsPyAgQXJl
bid0IHRob3NlIGFsc28gYWZmZWN0ZWQ/DQo+ID4gDQo+ID4gT2gsIFllcy4NCj4gPiANCj4gPiBJ
J2xsIHNlbmQgdjMgZm9yIHRoZXNlIHZlcnNpb25zIGFzIHdlbGwuDQo+IA0KPiBUaGFuayB5b3Uu
DQo+IA0KPiA+IEJUVywgaG93IGNhbiBJIGtub3cgd2hhdCBvdGhlciBicmFuY2hlcyBzaG91bGQg
SSByZXZlcnQgdGhlIHBhdGNoDQo+ID4gYXMNCj4gPiB3ZWxsPyBKdXN0IGluIGNhc2UgSSBtaXNz
ZWQgaXQgaW4gYW5vdGhlciBicmFuY2guDQo+IA0KPiBZb3UgY2FuIGxvb2sgYXQgYWxsIHRoZSBi
cmFuY2hlcyB0byB2ZXJpZnkgaWYgaXQgaGFzIGJlZW4gYXBwbGllZCBvcg0KPiBub3QuICBUaGVy
ZSBhcmUgc29tZSB0b29scyB0aGF0IGRvIHRoaXMgZm9yIHlvdSwgSSB1c2UgdGhlIG9uZSBJDQo+
IGNyZWF0ZWQNCj4gdGhhdCBjYW4gYmUgZm91bmQgYXQ6DQo+ICAgICAgICAgDQo+IGh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdC5zci5odC8qZ3JlZ2toL2xpbnV4LXN0YWJs
ZV9jb21taXRfdHJlZV9fO2ZnISFDVFJOS0E5d01nMEFSYncha2gxaHVubkRsYzNuck8waGRBVFlR
YWpUSUdHaEd3Qk92RExOQlVWN1VxVkJqc0haaFc2QklsNUgyWHlKcDd5RDRUYjZyejVBaGU2c1NF
OFJfOFpDWlJkMUlLWk4kDQo+IA0KPiANCg0KR290IGl0LiBUaGFua3MgZm9yIHlvdXIgaGVscCEN
Cg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=

