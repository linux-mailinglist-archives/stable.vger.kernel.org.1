Return-Path: <stable+bounces-109185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A832DA12F5C
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA4B1888118
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71B1DDA00;
	Wed, 15 Jan 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cVbmBlDl";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EVvwXWFs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NwSg87gh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C01DC99A;
	Wed, 15 Jan 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984857; cv=fail; b=Tg2yKybpkGF+UQvCKvrITWUSCwc9+y1LcbpVZS1EpOSlVe1CccpQIStuBntMVteBfos+iuFsUsOeYb7fZERDIrJAKZF0GAtoyKo48D/6xVly/m48ryY0sSW6kYxOE5Q5U+V8b/xSUGBIV/cH+FImMpbX/68eLT5R4HEnpDer+s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984857; c=relaxed/simple;
	bh=sQAvc3krBEd7QToUAt/vdYmyXzijp+hI88x55bB3FiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVC6vo/GDleGalUwCw99PBVRnqbs1iAwlvr7+rBzCbnXxaeKOspEDR+N+8HYOeNpmP/a9p/RlrweQzyzvjOVyFWlAC8DoQtm4LLW48yjkuLafeBAhoutHCksUFKtLCkGNByd91xDxpAwk7Pr9yioR82uOoBD+ejLS4lhngHFo6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cVbmBlDl; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EVvwXWFs; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NwSg87gh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FNYivC024193;
	Wed, 15 Jan 2025 15:47:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=sQAvc3krBEd7QToUAt/vdYmyXzijp+hI88x55bB3FiQ=; b=
	cVbmBlDlnv+pt6sbJftgWHEZDzr78/aaGWzDMvFegBKMnHmedR5M21y9bof7TT2p
	L0XyD8xsHocaM3VZF4Yzrn1nGBfRYTCRKMsJ8rZzEuQPQCs9o71MarYh6bAcvUFA
	jHClzH4ig2xaXjfogaSzaF/eUdy1FO0ichR4EVGINXYqa5iFblo0BTR6zVZg9yBj
	4Cl3wvEayWICs9TJShF+l/JttyhsHC3Ltl4bbejyEqJK7HjxzDqMlmPwyga3WB50
	ivM9Q5SOj+HSYqRmGeqqyTeXD2y6PGjl8zXaBrARUHyKThEw03GPufHn6QZp2bNE
	tcK8efBPxZagH21XgMlQrg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 446f88jkfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1736984831; bh=sQAvc3krBEd7QToUAt/vdYmyXzijp+hI88x55bB3FiQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EVvwXWFsndFlzEgF4N1ew9mbMJqBQLPIQWOhOQK5JuynSfbdWjtH67/vXUs+WAs+T
	 6wvyY5wEnSW5WsrcgmfL3DzF2imyaCWdMAYZB4wTe4kCo6jlf5xTIA1h9o7Nsq5GoW
	 cJwzrDMxHHKBcmDq7hWiMZ8XCc9YpEp6xG5A5OJ/iTBXcnaez8j+N4W7+4B19oCn28
	 6kMtXL+NGRUFQFgBapgR7fvsPwaWEsgRdcM2S/7OZ9IvjKeYAkhAuL83XcAXX8HpIX
	 XAt++0cMVCDPglz8VFxfPPdRySeA360KVh4QKwGe+hbEgr/B+Fh+oBlit5Qnsp/WPJ
	 BmvKmWhrnibpA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DE1D940144;
	Wed, 15 Jan 2025 23:47:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1AD43A0072;
	Wed, 15 Jan 2025 23:47:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NwSg87gh;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 19AC840519;
	Wed, 15 Jan 2025 23:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obf+Kg1/6xv/8bdE2BhyZiAoAwCRiWqHr3ARmfwz5yjFrfv/3BGyusALzn8lZJf+pD/cpqjlyktxLKtaDa4asAS8GdD5S0GWBGI0l2lDw9mKiCsOGRHoN/Xs2h2+nrFIJl+VLUk6EgPo1MPNlnuwMjY9XgNmkPCA9no+YUDlD7RSN0iKnsXMbW6xFwwIhpSpryjLQPw0AdLSRLUmY3rferVvg1cye7vT4uqK53PwzzgaWB4WtN2pGZeFgkX9bRDN4MEYC2EunE70uSyCzXC64rickB+2aztA22oBsDjnZxpGkEn61xHkKaKCEQK0SsF38uHotUdTJFHzbRu75oObsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQAvc3krBEd7QToUAt/vdYmyXzijp+hI88x55bB3FiQ=;
 b=xZ/RUitXceBhfKLM0kBA2Ysv3RQXvelzaCQEDwdr/l12tnW6dn+tRaxT08bMj5UJHfhGPMNdQFqL+t3UJm3tczxlY/dYxzb9LBhdjIlM8zHPDTLJN/odSZYvt8Nx9TKthXLz2Q7TGLg/j2zNeX9EB/xhiPWKLPtanSdIIBZ74HIQZLUgA2Z3PZOBZpjYWJHfNBKhrAdF/GxiAdn65ae2xevO5OfY8ypwbR/Hh2UyRUvY9OlKXULyaML7gAJGkMg2GUQl15KwgaumgNcMC2ef4RRRyKlBBRkjqYw+zQy39fn8Jnb+mYRMGl/CEjmnm8H9Y+a1iIW1JEs6ITGXsxGujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQAvc3krBEd7QToUAt/vdYmyXzijp+hI88x55bB3FiQ=;
 b=NwSg87ghWbe5vGojbv++tNl08+FcXyDAYAC5DAAqgJ4I8bhVEssYzBQq79zqm07O/Hr+2lxYNPWrOyxUSCdWBtZO6az2ixqLh2GYVP4ehSVi/m4bjJ97CdPVl3vVSCXFRzBlNDn4fb3cKolA2BE+taOI7da7CUqpqdSCn+HzbBg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Wed, 15 Jan
 2025 23:47:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 23:47:04 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kyle Tso <kyletso@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "raychi@google.com" <raychi@google.com>,
        "badhri@google.com" <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "royluo@google.com" <royluo@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Defer the probe until USB power
 supply ready
Thread-Topic: [PATCH v2] usb: dwc3: core: Defer the probe until USB power
 supply ready
Thread-Index: AQHbZwhgiSI0E+YkA0W0UfEMpMicPbMYgXqA
Date: Wed, 15 Jan 2025 23:47:04 +0000
Message-ID: <20250115234701.bbkxoo226jjlachm@synopsys.com>
References: <20250115044548.2701138-1-kyletso@google.com>
In-Reply-To: <20250115044548.2701138-1-kyletso@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB6988:EE_
x-ms-office365-filtering-correlation-id: 55a802fd-291b-473b-12a3-08dd35beea58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlVONUlBOWJpMi95Vnh3d0NBTC9DMW5rbkdUQVp5a0h5S1Q5OG1KL2hIVkxK?=
 =?utf-8?B?djMxNDZGb1p0YzlaRUN0R2daRGEvT1RBMCtMMHdKY05kT3ZYVDgzeVVyc2VB?=
 =?utf-8?B?aUVpUUtJYUQya2NLWks3Y2NjVmVRcXU1eCt3a3QzMU9QUFY0enExdHRxeHQ2?=
 =?utf-8?B?Q1UyS2JIcC9tZFVmRjBoN0JONnk2WXozbVpMTzkyR01YMy82dmNGTUNXZFpC?=
 =?utf-8?B?amJPVVIzeDdGV3dQbyswOE9ST0tnd0xOZmQ4bDE5SmRDaW43bjFSQ3FFaTdt?=
 =?utf-8?B?aWtQcXJRUHB3aFAycGRXcE44dExQb1FraDAvSVcyVGhMU29wb2tRWVRIVlVj?=
 =?utf-8?B?S2llTXU4OHlEeHVxQUdxWXBXR2E5Z1hxZjFxUytSM1poTGJNdjBEY0Z5Nnkx?=
 =?utf-8?B?dmI5eUtQZml2aUd2SEY1QWI1VlZqMFlaRmZ3cWF3b2lPOTRSVTlubnlKV3lr?=
 =?utf-8?B?U0svOUQ5WEc1ajdQc0M0UW1reXdDUGI4Y3VBK2wrenpaNXpuWUdZNE96RmFF?=
 =?utf-8?B?RENiODhkelNFYkE1WHY0a2VqQ2JScjZzQ1liNXRKamtSY1VmYWZ2cXhBS21J?=
 =?utf-8?B?cmxsdWpYUmk1K2ZPeDNIcS9Xdkg0cFRLTXJ5aVRYcDVvQnJuekZsaloxdXli?=
 =?utf-8?B?Mk1EQ0ZhaDJkbHY0elY2UEZOLzhvdk1xKzI5SjdLYjlPUy9qWC9hd0VCQ09p?=
 =?utf-8?B?STNBaEg3MXEyM3Y4MGU4d0N2R3ZVOVEzVkpjRm5mZkFTdmRtaEticndRTDAy?=
 =?utf-8?B?TnZlVXZYS0gyTEVwNzZ0VHd2U1ZWNFY1Y1pmaDJodmtyakUycVpLS0hQeUVw?=
 =?utf-8?B?YVlTWHZqeVRBV2FNY2ZiQittcEl6QWVsMTNFQXlxWS9ka3Vtclh5VmRrNVFQ?=
 =?utf-8?B?VnRuV1pkK2F5SjdmNXJ2aFdFVVVNUnI1VXBDdThwZUpFVUd5cEYrdTFNN3Y3?=
 =?utf-8?B?b1Z6bGVoanl4OWZoK3ZuQk40bkJ6VksyWUVQTTltcnBsb2Q5dmgwc0QyQWdZ?=
 =?utf-8?B?Nlc5RXZmNzhRd0YrT2tDdmY3UmJIMVlZWUx2ZEhUKzJrM2dTRy9VYXp6OWVF?=
 =?utf-8?B?UFZMMm1RNE5ub1UrVWRpbnZiSkthQXpDQ0wxckFxWEFzNUhtK1c0ckFQMEF0?=
 =?utf-8?B?VTI2UVdYQ2l5LzZSMHplVnd1MGhzMDhlZTBSLzd3dTZsM3pJUlcrd09LU0lj?=
 =?utf-8?B?U3VHNGZXa0htdVVqd3QwZGN6bzZJTXYrbVFXOHBqY1JxeFhPdDF4WENXWHRw?=
 =?utf-8?B?R09qZTVxSmhUN0ZwVEhMa1MvdTZLRE9tRDY4STZEQVEvSkRCSTBTZ2lFMXlL?=
 =?utf-8?B?OGduekpiZGI1UVVULy9WQzhvbFBBRFN6cjAycEpyNlp6UWJJVDh3RjdOU0dt?=
 =?utf-8?B?YUFRUG1aWVFZdUl3US92NUJSMnF1bDNjN0xuK0R5VnR0YmF4UmtZRmVBU2lK?=
 =?utf-8?B?eVBlQ2xIREtzdjhDZDhMYnloNFlkczNodjJ3QWREaFU3bDhxejBpMEQ3cCtE?=
 =?utf-8?B?S3lQbmpzUUYzR252eXBsQ2JlcStFWm1UdHd5TkFocGtTL3lPSGZuM25TRWNw?=
 =?utf-8?B?RUZzUm1JaXVTT3dWZVBxcU9yaU5iSTJOOTNYVDdWa202SW50M1EvQVNpNktk?=
 =?utf-8?B?MWFNSGw4NVJnUFkvQXJmelNDcHU2MnpUOCtSc1RzeXdmTlB6WDBvK0FsbUxj?=
 =?utf-8?B?ampLZ1Z3c0pMT2U3M3psYkNoYWx4ZjhxbGsvbVg4YXprTEhWc2gxNkZEVlBD?=
 =?utf-8?B?eGJqdkljU0t3cFdEQ3hKczMyU2hOVml1V1ZxdWNPUHF6dytQcDhJd05FVDZJ?=
 =?utf-8?B?UDVvYmN1UHFtcFRMR2RXL1dSSUtzUk9UUjJ2cFpXUTR2ZTlaM2hwYWx3MnJq?=
 =?utf-8?B?dFd1clc5TGZGQjluZUw3NWFEcCt6ZU03ajRlbGt5VWsrZnJ2NjFYMXZiNzZ2?=
 =?utf-8?Q?X0KN+6MXTzoaLHIwyRotvCF27tAd3uFV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djhaUjRKVHV1cXFKUHQ3M1NnQjZyRDRiRk9yRzVTZ1IxZTl3aVRSclpiVGNn?=
 =?utf-8?B?bGZlZXBTdm9zay8xVHp1WVNOKzE3L0swbDhlRklmVGlCeWx3Zi9CYkdENW5U?=
 =?utf-8?B?SnBOdWVrQStVWU4xbXpUSkEzOUIrQ3BKb3V1WkVjaEdwSmpNYWxKaUpyZ1NS?=
 =?utf-8?B?aEhDOFA4MWVaWUFmcUxYVHdiTGFvSDFYVDFaUS9vUWtwbkN5YVFFWGNSTVVZ?=
 =?utf-8?B?bjhCeVRVRHNmVzdpakV6S3lpbTl6UFJWQkxUWHlNTUVFZklZeXliWlBsRkdp?=
 =?utf-8?B?Y2FWL2VOam43ZE5TdFFlcm1xTkNsdDFiWGZGdnp0RWdVVEUyNVpQU3p3SlVr?=
 =?utf-8?B?M0x2M2Q2MzE5V0hIaFA4Um9SM2RaUnA5d3J1V2RVbVo4YWhnUGFoWDlvNFRh?=
 =?utf-8?B?N2hMYjJ4YStuR1FPMXhVeGN1R2VwcEs4T3FhNGpieTBtYmh3VEJYL29uYlZ0?=
 =?utf-8?B?SnQrZVhJRGVkSUUwY0FkeHhFZVJUWE0rSEFMR1BwNWVyQnIwNjAzYVdPdnFl?=
 =?utf-8?B?Y3FtUmZmU0xFVEpydVhsZ3AwWXNVMlNmdE41azV6N1h2OFJZNE56dHIrRm1r?=
 =?utf-8?B?UTBBTHBCeFcyZmZxcjdXMmhTVytMUVJ3RFMxR3ZGdFFjcmEzMkF6dXI5ZHIv?=
 =?utf-8?B?VXdEQ1pXdklkWU9yMk9iT0swNWg3d2ZrNGNUbmVzblYyU2pxT1ZaZHI2ZVNL?=
 =?utf-8?B?YkJzcjNNMjhSd1hCQWdSeGMwb0U1ZlNrRzlGYm5Hc2FIYlB6K1lVaEVXNXNI?=
 =?utf-8?B?cGNsU2I2QmRwM3FRWVA4dFdZV1ByZEFlWjR6SkczNm12UDJvZitocnhuZktP?=
 =?utf-8?B?ekY2QlBEVE9FZVZicWRoTjc0WUNQL1QvZTRxRlQ1VlRBemd4R0hHNjMyMDBy?=
 =?utf-8?B?NVN0STBpbWtxemJUYjFXbGpOR05GSVQwdWhHVzBZM0pEbCs0dkFOSjI4TU9P?=
 =?utf-8?B?YWhKcktBME5OK25TSll4KzdUSDhjQTFZeE1IV1RhVWFreDMvcDRPeWFtd3Mx?=
 =?utf-8?B?NUREM1JzWDdEN1ZWZFdTTmtvWjRvYzQxSkxFcjRxdnhHMFYvSktBSnIzenpy?=
 =?utf-8?B?ZVp4ODN0WEx3R2dIMzlwK3NPUmo5K2kwNGQwZHpJL0xLa00vNSs2eWVLTVRu?=
 =?utf-8?B?WU1WcGw1QjBMZWtHSU9ZUEpMcmNNaG9qY0NBalJQczVpMFlJWTJMS1dNcWlP?=
 =?utf-8?B?b3NTRUZpTUdIckhtbmd4TE9wUkkyai92SW5mQ2NXRTllNkhESGJ1Q2xsdGtB?=
 =?utf-8?B?UXh3RTlLRWJVWm9mTkp1RzZZcGlmTlY2NXRGakVWbWlvRXNVOUwxTXdqVlp2?=
 =?utf-8?B?S2hUeVg4ZUUydmRRVE4zbjJiQ1JMT0RxNUpVQW9zNG11c05GRUlMQmdScWRx?=
 =?utf-8?B?elJyOC8vV3A5R3ladDArUlVDK2MyTVNmbEZ3eEk4N3V6M01zVlFBWWd5SHJW?=
 =?utf-8?B?OFJjTkNXK0owSzdST0VLd2R2K1lGRjdlRlV6TCtMaGlpK1ZvSWRRSlo5VVBl?=
 =?utf-8?B?a01MRUlubmlBakhNZTdWTWdkdS9HMlg3TnAxbWxYWFBUOXhXeDBjeU9HczA2?=
 =?utf-8?B?WTd2ZURUY3MycE8wSmV2STF1RmxleGlhWll3cVMxV2VDNjJDbzQxY1M3bEVG?=
 =?utf-8?B?bkwxUXpib3FUVG5qWWxoWnB4di9TdGxoZ3Iwd1B2OFlLQzVYS0Y4TmtLeU9l?=
 =?utf-8?B?bVpZaitjVmRPNUtqRG1mUkNLUWt0Q0tLNUUzb0QrbzFrTm4rWXM3WHJVb3gr?=
 =?utf-8?B?cTFRS3NwU0NxSFBEcXJUUHJUQndsSUcyZVhudCtIQ1hXUDFvZlpZZ3RxUW9M?=
 =?utf-8?B?ODVXWVFXNWJXdVA4c2UxcHNwNVFGc1gzMllMV2RDZHlkMXJhZWpYSGJLeHVz?=
 =?utf-8?B?QlVVcE1MbWpOQURaMzlRYjZJNXlTOGdTT29ISENpRFJCM2U4Y1FEbmt6czZp?=
 =?utf-8?B?L0xqL29uaC9hYmdwVTczSmRXM2NyVUltby82N0NxZWNwYmU3YnBGeWdacmt3?=
 =?utf-8?B?Vm1tNXF6NEV4ajZTLzdzQ1p6czA1TG5ZZFROcm5zVXp1VHFXTlZES09Cd1l1?=
 =?utf-8?B?Q0Ywcmx2UnRqYlNta3lRdWxLaXd4T0FpcVpFcGFUNHZmdGZCaVFTc3BWWDdS?=
 =?utf-8?Q?5LUG1d8i69kXGt90m614NAfMu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2EFAE70D05B6E4E8EFF47679E89083E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FNJg2XB+FZbhroOfQ11ZoMO1xJFCKE1ObavMzgT+OVmIS4wh2GjwqAmBThUE8ihxOz8p0VEGn/LSAn0OD2DRDS0AzQ32fYDS/Wdmrg5R/Vng5NzeTzzUUVXnRJPZluoPtebGlZBCRuuFow6hYsfllsDcRKHDIMJ4UX6gQCAv3mlQbru5jMKzcw7Kj5UO5EaswqwYT6+QoMMvtbQtLagozqwD1EAfXFSf5bOqMeb/NBKm1d6zUSnUBQZ/aXTdk7wGPjpoGF83EzqRQcnsok3f8mXx5YM7o+n3OmJwBWGL6b+m2fgYtE11NNzJhkPEEeF1cxQr9Uu/x4lU6g+fA41cOriiAXVStD/wugdgrQ5sPkYZO4uZ7DXCRErh1Ih2XkgoDJ0WjJqtmT8gjGnehVok+OEC6h+zSJS5pb2aC1juAnWPPX/oB5NJNpGH8PbeW9Yqge8ULcYql4NRxXeZRxJ+WUd8DzRm9vZQUKO8xaMQzUMjr26gacud6dn/MwQW1GqUmn6vMw4WMcRF2xaM8sh8wyTfpRWRlOZFISWc5lld16o7/zdorCMCiQNbWXi73wl5ZtTTZOsko2Eai7rCK2GmNIfggy/ap/uZ7BSXFEdzHVSNeEre5a4YbyGqxHlm0LPPoaE8ULxWkaS5RPq5uqmPmQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a802fd-291b-473b-12a3-08dd35beea58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 23:47:04.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zqh22SEXiAZoRtndOi948khDxl3J4skJ2PDcSCRKgDrBraOZvJay0eYf4UP+Ty/97AHIY1+PgLZ2Za3QPYOhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
X-Authority-Analysis: v=2.4 cv=A92WP7WG c=1 sm=1 tr=0 ts=678848ff cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=w17741Uzo5v3yYVCP1wA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: hBkKm4dShjwRV3wTmChvUheSQLx1YAUh
X-Proofpoint-ORIG-GUID: hBkKm4dShjwRV3wTmChvUheSQLx1YAUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_10,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150171

T24gV2VkLCBKYW4gMTUsIDIwMjUsIEt5bGUgVHNvIHdyb3RlOg0KPiBDdXJyZW50bHksIERXQzMg
ZHJpdmVyIGF0dGVtcHRzIHRvIGFjcXVpcmUgdGhlIFVTQiBwb3dlciBzdXBwbHkgb25seQ0KPiBv
bmNlIGR1cmluZyB0aGUgcHJvYmUuIElmIHRoZSBVU0IgcG93ZXIgc3VwcGx5IGlzIG5vdCByZWFk
eSBhdCB0aGF0DQo+IHRpbWUsIHRoZSBkcml2ZXIgc2ltcGx5IGlnbm9yZXMgdGhlIGZhaWx1cmUg
YW5kIGNvbnRpbnVlcyB0aGUgcHJvYmUsDQo+IGxlYWRpbmcgdG8gcGVybWFuZW50IG5vbi1mdW5j
dGlvbmluZyBvZiB0aGUgZ2FkZ2V0IHZidXNfZHJhdyBjYWxsYmFjay4NCj4gDQo+IEFkZHJlc3Mg
dGhpcyBwcm9ibGVtIGJ5IGRlbGF5aW5nIHRoZSBkd2MzIGRyaXZlciBpbml0aWFsaXphdGlvbiB1
bnRpbA0KPiB0aGUgVVNCIHBvd2VyIHN1cHBseSBpcyByZWdpc3RlcmVkLg0KPiANCj4gRml4ZXM6
IDZmMDc2NGI1YWRlYSAoInVzYjogZHdjMzogYWRkIGEgcG93ZXIgc3VwcGx5IGZvciBjdXJyZW50
IGNvbnRyb2wiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBLeWxlIFRzbyA8a3lsZXRzb0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gdjEgLT4gdjI6DQo+IC0g
Z2V0IHRoZSBwb3dlciBzdXBwbHkgaW4gYSBkZWRpY2F0ZWQgZnVuY3Rpb24NCj4gDQo+IC0tLQ0K
PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggNzU3OGM1MTMzNTY4Li5kZmExYjVmZTQ4ZGMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+IEBAIC0xNjg0LDggKzE2ODQsNiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9w
cm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJdTgJCQl0eF90aHJfbnVtX3BrdF9wcmQg
PSAwOw0KPiAgCXU4CQkJdHhfbWF4X2J1cnN0X3ByZCA9IDA7DQo+ICAJdTgJCQl0eF9maWZvX3Jl
c2l6ZV9tYXhfbnVtOw0KPiAtCWNvbnN0IGNoYXIJCSp1c2JfcHN5X25hbWU7DQo+IC0JaW50CQkJ
cmV0Ow0KPiAgDQo+ICAJLyogZGVmYXVsdCB0byBoaWdoZXN0IHBvc3NpYmxlIHRocmVzaG9sZCAq
Lw0KPiAgCWxwbV9ueWV0X3RocmVzaG9sZCA9IDB4ZjsNCj4gQEAgLTE3MjAsMTMgKzE3MTgsNiBA
QCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAN
Cj4gIAlkd2MtPnN5c193YWtldXAgPSBkZXZpY2VfbWF5X3dha2V1cChkd2MtPnN5c2Rldik7DQo+
ICANCj4gLQlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9zdHJpbmcoZGV2LCAidXNiLXBzeS1u
YW1lIiwgJnVzYl9wc3lfbmFtZSk7DQo+IC0JaWYgKHJldCA+PSAwKSB7DQo+IC0JCWR3Yy0+dXNi
X3BzeSA9IHBvd2VyX3N1cHBseV9nZXRfYnlfbmFtZSh1c2JfcHN5X25hbWUpOw0KPiAtCQlpZiAo
IWR3Yy0+dXNiX3BzeSkNCj4gLQkJCWRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IHVzYiBwb3dl
ciBzdXBwbHlcbiIpOw0KPiAtCX0NCj4gLQ0KPiAgCWR3Yy0+aGFzX2xwbV9lcnJhdHVtID0gZGV2
aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJInNucHMsaGFzLWxwbS1lcnJhdHVt
Iik7DQo+ICAJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTgoZGV2LCAic25wcyxscG0tbnlldC10aHJl
c2hvbGQiLA0KPiBAQCAtMjEyOSw2ICsyMTIwLDIzIEBAIHN0YXRpYyBpbnQgZHdjM19nZXRfbnVt
X3BvcnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0
YXRpYyBzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpkd2MzX2dldF91c2JfcG93ZXJfc3VwcGx5KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJc3RydWN0IHBvd2VyX3N1cHBseSAqdXNiX3BzeTsNCj4g
Kwljb25zdCBjaGFyICp1c2JfcHN5X25hbWU7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9
IGRldmljZV9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkd2MtPmRldiwgInVzYi1wc3ktbmFtZSIsICZ1
c2JfcHN5X25hbWUpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0K
PiArCXVzYl9wc3kgPSBwb3dlcl9zdXBwbHlfZ2V0X2J5X25hbWUodXNiX3BzeV9uYW1lKTsNCj4g
KwlpZiAoIXVzYl9wc3kpDQo+ICsJCXJldHVybiBFUlJfUFRSKC1FUFJPQkVfREVGRVIpOw0KPiAr
DQo+ICsJcmV0dXJuIHVzYl9wc3k7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBkZXZpY2UJ
CSpkZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAtMjE4NSw2ICsyMTkzLDEwIEBAIHN0YXRpYyBpbnQg
ZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJZHdjM19n
ZXRfc29mdHdhcmVfcHJvcGVydGllcyhkd2MpOw0KPiAgDQo+ICsJZHdjLT51c2JfcHN5ID0gZHdj
M19nZXRfdXNiX3Bvd2VyX3N1cHBseShkd2MpOw0KPiArCWlmIChJU19FUlIoZHdjLT51c2JfcHN5
KSkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+dXNiX3BzeSks
ICJjb3VsZG4ndCBnZXQgdXNiIHBvd2VyIHN1cHBseVxuIik7DQo+ICsNCj4gIAlkd2MtPnJlc2V0
ID0gZGV2bV9yZXNldF9jb250cm9sX2FycmF5X2dldF9vcHRpb25hbF9zaGFyZWQoZGV2KTsNCj4g
IAlpZiAoSVNfRVJSKGR3Yy0+cmVzZXQpKSB7DQo+ICAJCXJldCA9IFBUUl9FUlIoZHdjLT5yZXNl
dCk7DQo+IC0tIA0KPiAyLjQ4LjAucmMyLjI3OS5nMWRlNDBlZGFkZS1nb29nDQo+IA0KDQpBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3Ms
DQpUaGluaA==

