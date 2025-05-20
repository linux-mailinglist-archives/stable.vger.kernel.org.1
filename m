Return-Path: <stable+bounces-145006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F3ABCF57
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD7A17199B
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4725CC42;
	Tue, 20 May 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Oumlm7HB";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="yc0SftEb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B682571A9;
	Tue, 20 May 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722558; cv=fail; b=P8h4Mg+/CZl7ETcBQNjAyZEb+poPmy///p03hZi98GePClj2qZ1Byl/kFHLcckN4MmAtJ+AVS+EzGMeueGxCsLbu13/NidBaovIUL4GUNpIUpvyC0igJiqbEuQoNuGRlQmXbkns8ct8e0AXqq+ZWS+IbHwpWy4S2Fuqakz1jEjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722558; c=relaxed/simple;
	bh=1TnNz20zNoY8oZLlCZYqVdkVn7NzITvmxSExC7EdDis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NtUYH4L8f0LaPE6ULbRiT147wLkBmPxIDUFOBPdNwNpeLHG8NorLWKM3io+Bd2rlB2oXeqSimVjugUlH0t094CIXarHmUUBpZwRG0luNXW62Q8aE2yB5iFqUZS6EtTTvYuLajtnAkHygVdXzDoEAazgEoibNFbhYHO8laB1CD20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Oumlm7HB; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=yc0SftEb; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K1u1er027287;
	Mon, 19 May 2025 23:28:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=BfAUYp7p/2MehSApbfPP4e1h91FT40XVBD1aG34K71c=; b=Oumlm7HBBjfb
	ytiQjJyHGKjPC5eZlLN9+auevqDeSxzccijyMy4O3aj6UIGSsa0AZhO54YtXRkXJ
	stEcPKzHP5FGBrW+XIC9AGI5rTjk79sjX93aMjDXyOKdfaGTrQiy46kwSBRshqUC
	S4/TIPOXqJ7fwRDk8OmZS6pmuqBURRIGSRRw5GT0/pnHLlmQWXvEmZHEvW8gCAne
	f9YNLDduCymh/5iDqilfYLNvPpQ9S4velIaq0vosFR7D8v5jzgrkQEFe8KPBh+PD
	Wr4f03bGmqPZdPel9Ol9QgJMIlFtcWpaQSwPQuulm6ybFOGOTxMO733+0VHIJwVU
	gdrpmaJDZQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 46pp1ystjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 23:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcS6cgVIOh2vI7wTyBE1kVd0+H4A/mTUToeQ8wxycXJYcOeht8OczzsWTKimTn15Esf3PTYdjyin2HZqojTkOaojSFC2aE08+DAJqxS2QJOiXdBa5iQOtHIyJchcPgLRIEdEJasm+M4HYCOdwcsbGO+G6cPHQDvc2wY39JjgNx+VtvTwCB+revE7ThYvzZt9iRSQPuZpHaAPwyPHkKVnTou2m6+D2Bbh6fByduWTybMHaSqHlnuGZ3rcyeREuNXef67DqpYzlWVZ8MScQRqVoHjU88ILZUWOvqnRsAWKOHnj97dLhRQyhw1MCziUIh6ed1ubFwl+0C2xI4miFK7tJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfAUYp7p/2MehSApbfPP4e1h91FT40XVBD1aG34K71c=;
 b=GD8XUljQ/fTP0WUdZl6sTrOQOxkapT11KesXBH/ajDO1CbdNXgxoOrmqlMjK27wghb+vHiQa+svJOxyTILvPPaXFJbPVOsiSWmNPJnjIl5iBnLwiCecYSwHHBMdlwlsZ+WypclI06d8GEUoBzFMgcgX/zXjtDquTzvq1DQBjElWS7OIJWSwfS6y9/2PrmGQtlIOt+s+Cn9n8UOPHBo5vBJaY7LHPeMh0wA9VDy+8+oJJWuXxxvlJldyo35vGMiAYrmqkROWZ4e7B7UnXDGnspGmIctBbjluFPh15XRHKL8vc/nKXVQgECog4KFJNw3YhWTjwN6Yl4ZBBPFN4Wfgolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfAUYp7p/2MehSApbfPP4e1h91FT40XVBD1aG34K71c=;
 b=yc0SftEbOG7uEKOv6eygqAkPlWQjOiNabWHrRJ2wP5D2igJ2EHU1+pGMa7Sy339Q2XCJDUnUQ4JQZRtkb0sOPulYv7DQNG0Z2Kj7n0/j70JocvX/cogbPmlPXcRv/e0RbDMg0a/NBc/HUphz+PyaowMGo54C4W+09Pj9TnVHBbg=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DS7PR07MB7751.namprd07.prod.outlook.com (2603:10b6:5:2c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 06:28:55 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Tue, 20 May 2025
 06:28:55 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: =?iso-8859-2?Q?Micha=B3_Pecio?= <michal.pecio@gmail.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
        "make_ruc2021@163.com" <make_ruc2021@163.com>,
        "peter.chen@nxp.com"
	<peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Eichler <peichler@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] usb: hub: lack of clearing xHC resources
Thread-Topic: [PATCH v3] usb: hub: lack of clearing xHC resources
Thread-Index: AQHbibVtMdBQbgcSHUi7NaX2HmZ3QLPVfimAgAXvhVA=
Date: Tue, 20 May 2025 06:28:54 +0000
Message-ID:
 <PH7PR07MB9538F4ED153A621B6BD26D5CDD9FA@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250228074307.728010-1-pawell@cadence.com>
	<PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250516115627.5e79831f@foxbook>
In-Reply-To: <20250516115627.5e79831f@foxbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DS7PR07MB7751:EE_
x-ms-office365-filtering-correlation-id: ca63667e-37fb-4efd-fc21-08dd97679868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?5D0hFdoSb2NdjX9h/euuZCt5NYJ5A0My7X2pSg/hDu3RoX8IqtBumWhGSd?=
 =?iso-8859-2?Q?RKtDxwgqKxF+P53sNumecDuEDFSJRSDdKCskc/VS+o7h8Amow62wBo1yLn?=
 =?iso-8859-2?Q?csvxKAdA/r3SUavW35/nGyp67Fji8BirOAus/S6nP1ICVx1uHHdWX8hunm?=
 =?iso-8859-2?Q?z6YTGRGaFgDOMWoiZ5IhmOjVCVT6E+gpUyIKJlO37N97ZebNNulq5WXjEX?=
 =?iso-8859-2?Q?0oB95o4DzXhSf/y27cPqnh8pZMA8ljA0ZMxmJRoDI7akkywNkqIFTavgT4?=
 =?iso-8859-2?Q?fgqiDVBDZiyMoLwnBUo49uTtQn1wWZb22WDwLY9QxecDUtVFPdZDywy/Rh?=
 =?iso-8859-2?Q?xG7geMe1f0DFAxdGDPGt1bsPqEdpc5n2qubstTjpwi5IL1HWHkS9b+TlLb?=
 =?iso-8859-2?Q?7tNu7mtpOUko1FgwbM34qVCBrrkhCRAxknmZLTXESpBlwZns+LCL5/hVBo?=
 =?iso-8859-2?Q?C2JYDVjL/hkF/8xkIDIfh2AXAiPM2zBnFTF47SyPGjrsSyNBhGZicsZVTX?=
 =?iso-8859-2?Q?byNYUAXkv84Jgud2TJarx3SwV6kAVyrLqioGQGi90QPPRNUSlfzYvY8uRy?=
 =?iso-8859-2?Q?6hXRvtwZ3nsmvC+2+apidT7lufL9kuPnjrGCA7QOMXajImJhvb4YRLSba8?=
 =?iso-8859-2?Q?O0Jp1sYJ8cEz+FEl8O04okcf9sdtI3/eAsgDdfcvQIyqaMmtQgVMA+wq6b?=
 =?iso-8859-2?Q?muXkPR88fdI7XYccyFgnPBTRq0fvD8/G0oeyLPHXGYdjtF0Hgss86WniMt?=
 =?iso-8859-2?Q?2Y2+TvK2MM1pORankkmnSzXQRNDSSkCAlFrWFtso9eTsNOrMOXRO952Su1?=
 =?iso-8859-2?Q?+Hzoq4FygkCyT18KzTidIaxfTnZUjBxvKFLyK7rorK6uLpgchDs1/pLrv6?=
 =?iso-8859-2?Q?1EORU1Fc+3R4vN5WLoOIXlKs4HyXGnkB5uZ0fd7nNyfEOggtaCSUE0lvGN?=
 =?iso-8859-2?Q?nEx9sEfVcl340P1RuxLDLJ0NR4DbEExJ8AKS20XMDAlqpamwvQgPtIZoPU?=
 =?iso-8859-2?Q?AN81J/SrMUBhQncu3POJiePoxXiB7+sLxStjyUkOPx/k3S6Sms2cpN/Taw?=
 =?iso-8859-2?Q?lcbRgNRVryPaSaiBQmetZa+W/F2aUiialWPbMxDdgH1DdbP22cUoXUXsh1?=
 =?iso-8859-2?Q?2anKI43ZnzZDA+Gwt5jqi2VqXRGvst9YUNoVu2Jl+JWhQGir1R+SGsnaCv?=
 =?iso-8859-2?Q?sS2ymayhsrDZ8a9VM23W9E5zDLLfeZtRSat1wKIFNsmFX5FpNlDc4wJFH4?=
 =?iso-8859-2?Q?PO4mCjL/wIK7a6YuNB2EecKCYNOC2NxyYc+/wgNwEOyTybaQi1bAvZc3iu?=
 =?iso-8859-2?Q?Ktol4MoKlARqD+OJLpp25raV87YbZk00BUEJoXT/Z6gnE5ffRfA2kDNpWX?=
 =?iso-8859-2?Q?Wd9xSD6pfWq9Xd9GX5Vav/18sEJ71kjCmmZLPaiNW6AUtkXLpScofWV54p?=
 =?iso-8859-2?Q?86W6pkpyJzksCZZh5mfSYjjuu23Fttdn4k9a5PHxHscpyvwnFjhfooIyXk?=
 =?iso-8859-2?Q?A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?hrPeUP4A8t59XPJUtHSQzmjEMiNBjhowQm+mO3bPwJab6/7X6RBCKjXBMD?=
 =?iso-8859-2?Q?H6wtmzbrAo/GaFq/ht7o1f6JDzk83BTXBg6ykPzRRghv03H5nhh+Rueij6?=
 =?iso-8859-2?Q?8sRZvV1hCvmcLPNW8tnA2VYSLO1p0XLw/1W9OYXsqhplACqKerOw2k2rst?=
 =?iso-8859-2?Q?yR/FPqHZYyPXsiMIe84VS0bRq42Tg7HVwj1aEJkDt0WMIFA9KAT9moCzrZ?=
 =?iso-8859-2?Q?y30LwkH7TMHoI5L5iJsJ2fpGEc6sIZ85yXRsTPO3wFWVsTjqHEnbszYp8o?=
 =?iso-8859-2?Q?T/1SH7pRNY6Pmt3K/BPbJP7pIVZfwaTsrz5r4XIKj99syk0SQlCNKwH4i9?=
 =?iso-8859-2?Q?jzPLG843ALKF/Bd7XzUvzwT2H2xxob5AOxfPKniDc0WNi3UlTr4dyeMEVF?=
 =?iso-8859-2?Q?ZEge+mYD8y/xJpSj76V2I9pxFRjpQwK/jdvLyBwUoDc8G7ONebLO0HtYkl?=
 =?iso-8859-2?Q?patXXzIC2OHWT0srJKniFLUiDgEmsqcFKb4G86XKfXvk/pRRH2HxlGRZ7f?=
 =?iso-8859-2?Q?cYQ7oHnqFbif/KixbU2x/Oly7UmfoioyFpe3zC/tl/DqlXL+cfkgS6IrzE?=
 =?iso-8859-2?Q?b1/QwU689rqOVTDqEqQYGfydN/3ANqpT1eKMzd1QksQd6gk7GXSUvHjp2V?=
 =?iso-8859-2?Q?lLdOlz4SEJ6F8qcGx9LFOUg+i0aMo0qUtMumgMihTP+SPRk8fU/8EqM/Eo?=
 =?iso-8859-2?Q?vFA0MWJZ/NVLpmGDeObgFWJ6GNA36bdCp4eXKXEASMwQBUUzhEYe3ATgUL?=
 =?iso-8859-2?Q?bmbucNIhrxcRaUBNXY0Y8G25xiiSUd2zu9pkRa9bzmJnrdnlpd+LIHCOqi?=
 =?iso-8859-2?Q?mKcJzy6Nk9l9uGNTH4cb5YdCdPsN8Wm/4nEZ0C9iJ4fRQV5UxxrzKLIvD0?=
 =?iso-8859-2?Q?0O5YH0Z6E1/eGKcL0uCWVFI/VZJIKlPVFmg9kHOrxxwcO1tQwaLESEW9eI?=
 =?iso-8859-2?Q?xpPfaywvphfTXFLVGyH/51MsmU6jJJAiGVFmab6vUHvZCT0vTlDhn+5/Yz?=
 =?iso-8859-2?Q?HcYPLuli48ed766hNUFiqFiew3XgPQEkREqmg9M70FvVdf8f4HL0Y8Mubr?=
 =?iso-8859-2?Q?8gBXSOgY97seGi6Y6MJZYd+Mb2fzheH6Te5+zMwHeweK8Deze3oLbaEcBi?=
 =?iso-8859-2?Q?B3+LnbC29QdwYXE87kxIom6J+u1U7NT0PCjT/zZTu6ud+0FbxpC1YPABxt?=
 =?iso-8859-2?Q?B5VsG6wrcvWoMIRwnZjr1UdYj6+WKmIU7SRfvc1+UAewfogNolhaHKsFD+?=
 =?iso-8859-2?Q?12yRMm/46veZssiJGgb9cq+zVdeCDOOzvqY9wXX28IRe0l73nWPSgedGIA?=
 =?iso-8859-2?Q?w3TcCpom7IqtSxIy67K2HiBGMNhybBBbzwUlSOh8Sj+H/Afr0RA5XGCZMu?=
 =?iso-8859-2?Q?JhNo/8HgPuV48y/Y3NMbLMLgX2yZTCEBTl2yDHcMlNb/ADed5kGEVREG+e?=
 =?iso-8859-2?Q?XOgkikzbHhmMyhWpXpi+kvp8ZSzog2kk5yossjYMsLXeG/oI+kHVnKWfdO?=
 =?iso-8859-2?Q?GxWFHCqlXqFOfKzGsIJcklzPJ6flzgIx+pXUkEV/iRHvfz7nwUn3OCBv1q?=
 =?iso-8859-2?Q?uj7BcCSV3OztOSwdI3ADLPME3Ya83RthstqOgSgVXyEMoz1O52Vz9vS+Zv?=
 =?iso-8859-2?Q?dnuWJYwQtvkNzC/THTQSKmdelGI37Rwjrt?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca63667e-37fb-4efd-fc21-08dd97679868
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 06:28:55.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wz23OcjwkGo1GvHKZdJxBvL6EomoM341LQ5Fobdfjg71jXi3EtqchM2UFeMTHDjRap6o1nAoQWEyQpIXlL8FLSSiJZ01lDgN4tzLDFu5l4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7751
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA1MSBTYWx0ZWRfX7nOfBC0WqbYt zDcEoOKJjELUj1NfV3lZlw/9M8oszUHvtBFMmRZyjmzdbjYvypXh8ltliZ8rxf8FWyJ37+xPTbG cUZb9qFGpRg5jLQqisY6kbfO5HVwO81wegu0DqRhdBEHQSkO+e2OEoF+E5V6zBZOuhqjxpc5G1K
 0v28eGzMgLxX8k9t1yMEC8qRxDP3oye00RmGjGaIsT4nRCSFMzNDzTiksW2thRJU1pk0Y4CFDwi dn9esRGzJQPOGg6jDxRb/4gV5fqMry+7PZ1JXblMvXwXdAmSxqi3VxJiYsZ59/QBKc/iwb/FD1s C7bw2LCtSJvWO9CXn+g7ecO94U1tfsyx3WcHkRX667o62JvOZf1I7OIYqLeElzLFzYtTMnDXjaA
 xhIrdzTKpg5LWTWwqm3DdYpqTlh+0ihfZjDrxoQK9m1UbZ4zTViAan18G/6aegQ7uiqib3Z6
X-Proofpoint-ORIG-GUID: xKqKcFu5SGWA3Zx83e_gq1rgFs9Ky6NZ
X-Authority-Analysis: v=2.4 cv=OMcn3TaB c=1 sm=1 tr=0 ts=682c2129 cx=c_pps a=nskeBUqQUen4dZUz4TdP1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=vCSHyV674Z8sEcIe9OAA:9 a=jiObf9B0YAUA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: xKqKcFu5SGWA3Zx83e_gq1rgFs9Ky6NZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0
 mlxlogscore=794 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200051

>
>
>On Fri, 28 Feb 2025 07:50:25 +0000, Pawel Laszczak wrote:
>> The xHC resources allocated for USB devices are not released in
>> correct order after resuming in case when while suspend device was
>> reconnected.
>>
>> This issue has been detected during the fallowing scenario:
>> - connect hub HS to root port
>> - connect LS/FS device to hub port
>> - wait for enumeration to finish
>> - force host to suspend
>> - reconnect hub attached to root port
>> - wake host
>>
>> For this scenario during enumeration of USB LS/FS device the Cadence
>> xHC reports completion error code for xHC commands because the xHC
>> resources used for devices has not been properly released.
>> XHCI specification doesn't mention that device can be reset in any
>> order so, we should not treat this issue as Cadence xHC controller
>> bug. Similar as during disconnecting in this case the device resources
>> should be cleared starting form the last usb device in tree toward the
>> root hub. To fix this issue usbcore driver should call
>> hcd->driver->reset_device for all USB devices connected to hub which
>> was reconnected while suspending.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: <stable@vger.kernel.org>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>
>Taking discussion about this patch out of bugzilla
>https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=3D=
220
>069*c42__;Iw!!EHscmS1ygiU1lA!FD7UdYLwKPptb8LI646boayHRFMR7zLGkto3
>rhb0whLx1-CVUGaYVVgrG5Y6EyLj-QcTuuUHSpaZcVPaTTRM$
>
>As Mathias pointed out, this whole idea is an explicit spec violation, bec=
ause it
>puts multiple Device Slots into the Default state.
>
>(Which has nothing to do with actually resetting the devices, by the way. =
USB
>core will still do it from the root towards the leaves. It only means the =
xHC
>believes that they are reset when they are not.)
>
>
>A reset-resume of a whole tree looks like a tricky case, because on one ha=
nd a
>hub must resume (here: be reset) before its children in order to reset the=
m,
>but this apparently causes problems when some xHCs consider the hub "in
>use" by the children (or its TT in use by their endpoints, I suspect that'=
s the
>case here and the reason why this patch helps).
>
>I have done some experimentation with reset-resuming from autosuspend,
>either by causing Transaction Errors while resuming (full speed only) or
>simulating usb_get_std_status() error in finish_port_resume().
>
>Either way, I noticed that the whole device tree ends up logically
>disconnected and reconnected during reset-resume, so perhaps it would be
>acceptable to disable all xHC Device Slots (leaf to root) before resetting
>everything and re-enable Slots (root to leaf) one by one?

Are you able recreate  this issue with different xHC controllers or only wi=
th
one specific xHCI?
I try to recreate this issue but without result.=20

Regards,
Pawel

>
>
>By the way, it's highly unclear if bug 220069 is caused by this spec viola=
tion (I
>think it's not), but this is still very sloppy code.


>
>Regards,
>Michal

