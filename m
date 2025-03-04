Return-Path: <stable+bounces-120265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D3CA4E7DE
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F59F8C814C
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F4278157;
	Tue,  4 Mar 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CQivGvNt"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1982980A8;
	Tue,  4 Mar 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104409; cv=fail; b=LbNqYf8xR+ijcaZZqK5mAdh1I1dHzwmWU+NOkE/5jTFuQg/9yOMugUNlmytDzrwpdTx5QistfvfQ2i4/95MPoaPEF7mXfneJq/fW/1ceVR0MC79M3eJNfboBfsKrM032N8Lh9dxhrWc7WCZ/2zl4ar8iJOLmwxoaRou/7vPuSLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104409; c=relaxed/simple;
	bh=bDoScIKbNzqH7B4Cv3wsUY4ON/3OslGA8q81wW25eQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEhJj1FSeI8UGhZr9lQIc9Z8O/34L7oYhqVzqsWIYaGalLdTzeNfhO52XWFPcgUce5DDrAVEqlh4S59CqOcsA3hRPNrgxFpAiPU8+CFsEU24AaVkioS5tfJSImY/HhOXu1li8U5fuYpvZPh/ETIeBZdvyHo4Wwjpy4QuVZUcZoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CQivGvNt; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLG0EDpS93mlIzVHSpaFZJ5voquQ/bvKs8Ma1TVtHGq+TV/HoSry1F5q4uHSgywiS8LQn7Fpr0FvFSj31uFQlYlupMVFKeSCXGoQxclRWgIXR3Pdk5OfZNEWWybAJI21iUUc/hlTC7sHXfT2WyeWvGpNPP6RLjKkv9DZ3buIBlTUkvylXM4ATVC7EJ1164cTWlQPjExbbDIflT+0kWq+wMsN0sMtDo/4BdpKSfcHJkrpbkctogGJ7M8pF5CMu9TjmvCHMM4LyXVVA9a9D9ZW+FanBj3rhLpSq1bWmK+psRx1X0YCy+zuw1Qx/Cu/hBjGEi7v6hblAllikMPQiPNbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPrFxUbhueuROFLOJ2NgMrOK7Orah0jo/s6Llivwl5M=;
 b=oRvaheOf6mww0Nh4Yc8Fv/2AVUxa+PwOrQlkLnlqxK5qiBWByk+M94NefkwdgL5+g+IWMGZVtQk8B1CCoMkSm7uy9xwer+lz/GsGjjBix7gSrdFtvZLcN6iuclWsFfAIPq2Edy7THujYi/EnhOLANJ0SDgL5TBuJgN5IbrR7wNqj7HqzvcNjcEV/3iZ4ArVtpcI07qnB+zjWSbytWzvGCqw+P6jw0r0J/5aoxOMnpp65QGTiIBXOe5xKIQnJOZn9SOMDEPvwloiDqoMDvQ/QTwzgudaOGBUnkhZC7p12G3OaqNDK5VQieJyq88JSUOsAyka33/FGilatt9wfUYyu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPrFxUbhueuROFLOJ2NgMrOK7Orah0jo/s6Llivwl5M=;
 b=CQivGvNt/JyEJL9aMJtNrci/McxvrY/alDaFHiAsGf8TiWlcFRgE0jHoCOhPOOF+DyTTtL0hYhUYzj5oBAipesgVYOY4kg5Qp10JKeUfRI1ct3ERit34jjC+XnsRIKD/zxyose5S8aYhZxGOBOCR+lnE1fnzT4DisV99eUMLRH51VTlKPDdW7+44jVqJCC/fnVA7V8mKRCMpkiMtTZlc/+Ns63eIgpWStA/Ney75EB3TesgwgpnSV0ZC0Yt913rpL0qMtjnkFQ3WtUheTTmjdGGrSirxLpF0DzOkY42niKOufat2vYlv13muCfDGeA4mTH9s09mvs6qwWPlViUrkAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by GVXPR04MB10304.eurprd04.prod.outlook.com (2603:10a6:150:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:06:45 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:06:45 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata
Date: Tue,  4 Mar 2025 18:06:14 +0200
Message-ID: <20250304160619.181046-3-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0166.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::33) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|GVXPR04MB10304:EE_
X-MS-Office365-Filtering-Correlation-Id: e2024dff-fa72-4abe-cf55-08dd5b368fbc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M056MXBLM0tUZ054Q2g4bHJ2WUNGSzdIU1dYQnNsOUc2VDAxUkFBWGtIc1dF?=
 =?utf-8?B?ajJDSjZ5d20yd21GWkF4bkJqOVFweTdwK3RDekl2UHRscmNnVVYwblFyOHg4?=
 =?utf-8?B?c3J4Ym1KVjU0b0dEUVdWNnNKUHEwOWJhcnh0VVk2M1AyeVQrSEtOUFBNTUc3?=
 =?utf-8?B?T1lYRDdmQjY3WjJwUWNNNGROOFVnYzhkejhHZHZWT0VEaVJQNzBKbHh4eWQw?=
 =?utf-8?B?MndUTUx5bEdvZFF6cyszWW51d0NvOGIwTm9qNVdGblV3Y0tmUmpuU214c3Bx?=
 =?utf-8?B?eTYzYThjdFJsbVJaVE5KT0Q3bkV4VGtPRCs3MG1jZEk4WE9tNk1nQ0MyR0NQ?=
 =?utf-8?B?V09GWHhWU1oyWjNWV1NFVWtMUzEvQ3k5VmhHc3dvUjdHanJIU1FHMCthck9p?=
 =?utf-8?B?dVErbUoydXk4Mm15a056bGJEVG1idHJzenMyNU90RVZtaW96QU5zQVhmZmlE?=
 =?utf-8?B?VDVtcEdrZVk0d0hJRmdTc2lKcFFQOGdJVFpkTmZFb3FIT2JQV3FIV1VVbGV2?=
 =?utf-8?B?YXdIci9vd2RubXdtN092OEd5YU5aM1R4c2VJUEFjNVMzZW56dHN1Tmd2MTJX?=
 =?utf-8?B?Q3FDWjJVUkluclVuY1Ftb1BhWWN5OEc4TkVwOG5HZmZVUzRQUEEwb1RvNEhR?=
 =?utf-8?B?Zkh5Kzd3RGVCdlcxbUR1Z0JDMjZSWXQvUnQrTnhEdzJhNVNsa0JJOHpaaThV?=
 =?utf-8?B?WGk5MWdMVExUVGdUTUlNU2hSZUpSSVYzNCttUzdSOFFOUjZJRVBGTEhOTDZi?=
 =?utf-8?B?Zy9ucC9RekFBR3AwVUI2UEhXOVY4ZDJWN2M3cW5FM09yNjBmYnMrZkFhVEJm?=
 =?utf-8?B?ZW1OMlpBRXFMVHp0eGt6SzgvcjdvVm9BSUwxRDI2Mk1PRS90YjFqSFZTUTkw?=
 =?utf-8?B?ZjdYbjVFMFhDU0FDU2M1Qm9NK00xaFFvTzRqOG8zMFVsYzZmanNHbG04bkN2?=
 =?utf-8?B?bnU5dmRmZGJTcUxnMkQzbnVPNER2QTRQcGlkR2ZzVjA2ZWxQVXFhZ2pTLytS?=
 =?utf-8?B?OGtYSTNMa2wvREJZei9Pb1JyM2NWbE9sWEF0YWNEQlJyZHNiT1BZVVQ5eHFt?=
 =?utf-8?B?eHlEWGFpOU1ZajhjYnR4clFVOW81UXVJamxhTVlMUWpFSndOYm9mSUdvOE1M?=
 =?utf-8?B?YWJMdjNPQ3JWWEFvNHozSmVtdGJhQUJ1NE1qWGtvWG9EVEo5di9iTW1STG1h?=
 =?utf-8?B?Q3IzcnBObXd0TWNQbmw3dnR3MHVvNGF3cXFjN05xRGZuWE9ZWkh5a0tqK0VV?=
 =?utf-8?B?ZlgyakJndDVoYnJYRksrNlpyRG9FT0F6UGhrT2hHWGNjTStGSGtjbTV3dkJG?=
 =?utf-8?B?Z1dxYmVtZnIzdXZVNjBOVnVsdS9yTkFTcnY2ZHpWV1U0cE5QenFVSTZaVld0?=
 =?utf-8?B?ZjA1Nk0vWlRhV3QxUkc0TmQ3ZEJzdnMyRk83aWxHVG9rSlljSjV3MGJDdGdZ?=
 =?utf-8?B?OWROcnIrb21IMk8xbzFFL2ZYMDZXcE5LOTM2RGdSUVlwNHg0YnU3VC8yT0JF?=
 =?utf-8?B?YXFBaFFQWVpTMEFadVBFNFhjeU02YnhWeGxuckhDRVd3RDhob2trYnpwV2dI?=
 =?utf-8?B?L1lRWmlJV0NPZmxQeG13bkUzWVo5N2ozNVdtam9LOWxXcnFyZUE0NVBNT1Nt?=
 =?utf-8?B?RXExSnpGTzdLbmt3N3g1dUFDYTYyVnRWbGdhb1hHTncyaWNkWVJEQkJkZnJW?=
 =?utf-8?B?VHRYSVVBS3c0aHRhbmdrY3dTWXFnUzFZMUdBMm9MdFcrdUNuc202Zmp4amNM?=
 =?utf-8?B?NFBSYTRKTm52TzJHd2pyV3loRUVoMjZib0NFbnFPRkRQaUEvWm9mdUd1eTE5?=
 =?utf-8?B?ZUF5a2xIeHhSSnpGRU50NmZCQzgrWG5LUmxHVlUxMFgrdlRiVzkxSW5ZWXR4?=
 =?utf-8?Q?a2+PQvdXvV6yR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1MyYS93TU5uTUY1TDgxSVBJR0ZrUnhiMlQyYXRjL05EdFQ2TEw4TmgwZlB5?=
 =?utf-8?B?bDdERStzbnprMFQrVlhZelVJNEVwc3dNNkgrNjJKc0EvQ29PdnpPOGoxczJ0?=
 =?utf-8?B?RFYxNktlbWRZYnBDMGdGLzAyZHI1ZGNuUWx2VGxNV1BkbkcvcDNxc3FoR2JH?=
 =?utf-8?B?cFUzVk84cGQ1VU9iVCtiVlovemUzWCt0U3BJMFI5Z1l6ZS9MZ3hmQ21BUDVo?=
 =?utf-8?B?aW43eVljNXhQRXdTUjEzVUlzUnJEOE1IMy9qM3NSazdZQVBqdm9VdXp5bnB0?=
 =?utf-8?B?T2pnUXdlU1RCZTk2ZmpzdVBLeFBVSXhBYzVvNGxLUWY3YVFDTmcyR0N1NkJq?=
 =?utf-8?B?R041Y25jeTAra0c3RFZLNHV3U0R3Sngzb1Znd25JYzFRaGlZS3pQYzJOWkZo?=
 =?utf-8?B?LzZ1QTJOUDUyY2lKT01EdjFyclpYZmVYcFNUVkZyVEtBMFdiczRiQXRycHRO?=
 =?utf-8?B?d3F2RUFSeEV0THlNZEdqSDFYdUF2azhyQlZ0cFU5MjFjUTRDdkVvV1pTTURC?=
 =?utf-8?B?YzhndkJIb3Arb2sxWFZORWNHOGhKNUZpUFM1dTNoSnhtMktvdU1ycVk0OVc2?=
 =?utf-8?B?SDRscHNDWXpiUjQ5bERYTHZWRm1yYWZvaG5SUUdiOEVLaDRZeUdYUkxQa2Fp?=
 =?utf-8?B?dVhoMHdyL215TUdWVjZlTmNZbExnMUN4emFrVGVuZ0RLWVFmQld6TFBTVHdJ?=
 =?utf-8?B?YUwvOHZidklqQm85RStDeXRVdDdFbWVmdTZtL1VoWjhZRy9HTCt2ZUVLZVNM?=
 =?utf-8?B?ZXNuZ3cwYTZSbzdWNzNvQzVQaEo1WGcyQVZqc0IwSVIzZ2RnYzMyR2NuRXNl?=
 =?utf-8?B?YzhrQTBScnFXVHJBR0F0QytMZWdyd1lRV1d6ZUhRTVkzeS92Y0RLVGUzN3Nj?=
 =?utf-8?B?cTFac0l5VmdkK3J4cHgweGVkL1FIZ0xKVXBWRDlVbXFCaVVDUUdMYlBSdEdB?=
 =?utf-8?B?eUVCZ0hxZTFpL1UzT2E5dTU0OTBCTjhib3RVVm9PTXFjOHh4Z3padi9HLzVJ?=
 =?utf-8?B?MkI4MTVDZm5wdk5UeTNBTXJGa2EydnNtNFo5RFpUc0JLSElwWkhMZWFEc3li?=
 =?utf-8?B?b2J0UXFCcWpnbWI1M3htRUhvL2QydGFQaHl0eDVMYS9ia3l2VFYyWVl3L1dH?=
 =?utf-8?B?NC9pOFFSUkJnc2g5M25ZN1R6aExrenlDL0NrQ2JCM2M4blB4NnUrcUtjNjdI?=
 =?utf-8?B?aHdocTVMY3FaQUtqMU5wcm0rWHJIMDZjZEFJUXVVdytFRWFTTGc0UjRCU3Zq?=
 =?utf-8?B?dGNvN0dINWlGcUtYZDAzSXZ5bS81cnpRb3h1RThsL1BiakxQazdOek9KM0tR?=
 =?utf-8?B?eFM2L1Q3V1Z5Qll1c2NMa0kvbGM2ZDJ2U2pyVlJmdGZzazBZT2dSMkxDdmU3?=
 =?utf-8?B?a1ZJaFZmMXZSd1pDSGVKclpwejBKWG9OOUVJOTk2ZmM0UkhyWkdOQnpNNGY5?=
 =?utf-8?B?dDFFcGl0M1p3eTU1bHRobnp2ajcvdVhpVUltZE8zK2xNL2xHcXRTQnNrcnEw?=
 =?utf-8?B?TGd0SlkxNUJBdVN6djRFSEFaekY0T2dKd0I3NnlYWCthbjVYQnRWK1ZzRmdt?=
 =?utf-8?B?SFgrbmFuTldBWjE2VWZJU3lOdDlBY21ObHA5b3RsbWV2YnI0c0pKMzcwUUJ3?=
 =?utf-8?B?ZDR5eGJtZTZDcjhNN2tYMlFZVVA4ZlBSelRFZi9SVGdUQXlxV0dDdTRtUUZE?=
 =?utf-8?B?UVQwK0NtbzRJTHUrem9IRGNQeUVGSlJxeHdnaTR1YzlwamNrMFh5N3JPTzU5?=
 =?utf-8?B?Q2ppN0tLUmwwK2hFRFhVZ25WaVJ2c0xhN1lXeU5kZ3lzR2FGd01haVZkY21Z?=
 =?utf-8?B?eXlRSDdXRkE5VjlYdTNjQWswR3dYckNteldEaFZmbUNwOU5sRUJ5VWc2OXRK?=
 =?utf-8?B?MmhnRXNNV0JwWXVYaGN1YTJRcWFad2tlT0tMSGRhak1DaTMzWUVMK1hxNXBI?=
 =?utf-8?B?Z2wxVnZSTU53TEFML0xrT0N0MjBEZ2t2WFZyY08wdnU5dXRsZUgwblZpaFlD?=
 =?utf-8?B?b3lpd2phQzFkMTNVTGx0QnZwWkJYYkVXdnp5aFdvb3o1UE1ERXRrMUxycDZF?=
 =?utf-8?B?cVpPYkFTbElBd05vcmFydVQvREpCRnFhNVM5cnlqbXJtaEhMeVowZEhtbFg1?=
 =?utf-8?Q?vgXSsyg7jVX2YI7vmXCS5kT6w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2024dff-fa72-4abe-cf55-08dd5b368fbc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:06:45.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1ufGB/6dvm+koAqE2pIzX/srVIuPi4NZ1vTiR+v4vkSMNQJjY0Fgg4CwkThslfQcKo0RSxldf1Ndx64XEsyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10304

TJA1120B/TJA1121B can achieve a stable operation of SGMII after
a startup event by putting the SGMII PCS into power down mode and
restart afterwards.

It is necessary to put the SGMII PCS into power down mode and back up.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 709d6c9f7cba..e9fc54517449 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -114,6 +114,9 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SGMII_BASIC_CONTROL	0xB000
+#define SGMII_LPM			BIT(11)
+
 #define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
 #define EXTENDED_CNT_EN			BIT(15)
 #define VEND1_MONITOR_STATUS		0xAC80
@@ -1598,11 +1601,11 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
-/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 & 3.2 */
 static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 {
+	bool macsec_ability, sgmii_ability;
 	int silicon_version, sample_type;
-	bool macsec_ability;
 	int phy_abilities;
 	int ret = 0;
 
@@ -1619,6 +1622,7 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
 				     VEND1_PORT_ABILITIES);
 	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	sgmii_ability = !!(phy_abilities & SGMII_ABILITY);
 	if ((!macsec_ability && silicon_version == 2) ||
 	    (macsec_ability && silicon_version == 1)) {
 		/* TJA1120/TJA1121 PHY configuration errata workaround.
@@ -1639,6 +1643,18 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+
+		if (sgmii_ability) {
+			/* TJA1120B/TJA1121B SGMII PCS restart errata workaround.
+			 * Put SGMII PCS into power down mode and back up.
+			 */
+			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 VEND1_SGMII_BASIC_CONTROL,
+					 SGMII_LPM);
+			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					   VEND1_SGMII_BASIC_CONTROL,
+					   SGMII_LPM);
+		}
 	}
 }
 
-- 
2.48.1


