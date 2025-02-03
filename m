Return-Path: <stable+bounces-112060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05BDA267FD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7698B3A3B5F
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9220FAAB;
	Mon,  3 Feb 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jgDzHJ09";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cY4KmCc9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b8144dMj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA411433D9;
	Mon,  3 Feb 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738626405; cv=fail; b=VhYOD3ZmHopQtowrMgxEKXyzq/uDkfyvGNxCrsx52soLlOcmsVNn30mbyA1FSddy02gqA9+GEGhDbjwu0KzEBO+QzCzUsAaeMGUNgSQI29TIN/9D0BCmuI1oxmfUODTjZg44VFT0Pl4WTzhT+lFsGUCPCgBx3N1KSdlB/mYjzuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738626405; c=relaxed/simple;
	bh=gOmZ5mj2xMg1gfWNt791c65+2cFrJC1T+4X0fEmdGVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p0kutZokgUIA5csCYRKCI6Xiv8we+0RX1yya/9vx8tpbRFeCv+ySCQoLCYrc4Wg75mxlCqgQUZ2TWQrHYXuvz4c3/ZO8WHS7YxEzIcanAV6opAPZXoLfawXAqpxH2Gfw1r+ZXvhwzNRisGN3F9IO8g7FWZzl0QOPyq9rXWQcGO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jgDzHJ09; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cY4KmCc9; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b8144dMj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513N5W2n029813;
	Mon, 3 Feb 2025 15:46:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gOmZ5mj2xMg1gfWNt791c65+2cFrJC1T+4X0fEmdGVI=; b=
	jgDzHJ09LgQrKoaH5pHhsR1Z95MIiZAlofc7six7khATT5hXR9SZY6D5Tq22r90i
	nV5ivXIasFYEB+a7rpZF8eVuts8pwr8OdWWStlylPtSr0+50niYN9D+tLxy7GpCC
	wlkxUkPTceDRkOOQw7Z1O6/mkzcSt4wjImlBwDhIhtU/DJ/DLvOQh7RjRcWCv1pG
	mcdohtICx4H/0XqudzvzjkvVqyIFcNPQs9KQujaXQ/vap3gALsT0Zuz3oYiSwFu7
	iqwTo5ra6JZNBByBWY6A0pUHyS2o+/kaQeDehNe+lCr8tYJF2wLc2niSAfJP+nuY
	gjBZJn22tdKLwlwq9Lr99g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44k1aj9p82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1738626392; bh=gOmZ5mj2xMg1gfWNt791c65+2cFrJC1T+4X0fEmdGVI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cY4KmCc9xoB53Ggmt1FS3vy7ywT9b6BFxldtWsaFCpuSYzjeP2v0TFFN0VGPNT2c1
	 306febmVX2PBLtzayNIOj0Y/D+iScuOea2irA8zWJkdY/RhuiRA3bwTm+LQ/5kSiQX
	 cvHf8WdTY8z+R7eaQ0lVOy2ZTKmx8yPZUbigc4Nr4wdKbfNxshfXPGzqqIrv+OGwP0
	 Z8hPmrTwh5T/YeDYabc3YSFj47vKANNxoGP/AOKDqUiYkDPfxGSWgGgPwR4PooBRhi
	 zuHBqniP+HQqVdk/AATIF3s0QqXd5mXjJ58PC4oyLySxPJcPbMJK1vepgARmSppTs0
	 CBiUf23wXFUnQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8E91A40357;
	Mon,  3 Feb 2025 23:46:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DC02DA00B0;
	Mon,  3 Feb 2025 23:46:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=b8144dMj;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1040B4048E;
	Mon,  3 Feb 2025 23:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz4XbKR5QmYQyxXO4C/RVWsWqMikU3IG0KTktavuBrz5CGvV8j45S5SaQ/mKuoR5059EHY5iWLNUitzWP+kxQkuvb5OLB0Rgu/y6OcgccLxzl86pGCoY6Vo5xC5KTC+5sNB8TjgnwWronWLxd3Djx6Z9PIUV6MMg83QWuSrc9hxmvUkMjjHY3D2SSjz/Ld2pWmn4hhm6qFZQA7maou8WU/WS7gRc4miZUck9FdenmQn/0VtCGI5k80fpNefwsTnqhwhF1MmMYuDXHv5dYtVo20GAOh1MRZf7XgusAxRvbUIKJveOHIyRsAs7Um8sQpUJT0GH5k/xf46cUzInb0kMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOmZ5mj2xMg1gfWNt791c65+2cFrJC1T+4X0fEmdGVI=;
 b=HtpM0f3WjaIq9VFeC7lp1QIiAOlf8N4+yIL4V293ftzucYYgIMrr9SdZxsfCT4nQFY7Ic1rjsrCbhMknkjIqtjAOOI+8NUkNs0d1tQD4hC7BsAtcGh0AzoUkCOmhTLfcBrqtmE7IOK7CRPKYvYV28oG55r1GfqNU71seBFORY4/UXWXNkudeGPnDe5rVIvE29b//2K2HhHf3sfRLMfAKbMXMyNXgOMSSS4K1ULxo3seq4o9PuYMUcUmia1zuKnWOT6odAAZtuyXElv77ksUL5q1+MUerqS6BI/SElfcUkF0HZpam4SHrPdPn8vQLxQT8ecs4II6GijLBlTKl/h6SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOmZ5mj2xMg1gfWNt791c65+2cFrJC1T+4X0fEmdGVI=;
 b=b8144dMjnC7rF8kCzxVb+//OVT9YGMsNC5em01NRFLf0i+SzRrS79O7NsYNUhSG2r1sGRgvS5s3F1Q2AM2OPX2Di1hl1SJ95BlcFuNpzKEdvY9GQTVflEN47uuO8Vf3MnrEokmdBLXqH5bnk7HNiLVL6XSjfyU2lsFHsBBTd3VY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Mon, 3 Feb
 2025 23:46:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 23:46:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Fix timeout issue during controller
 enter/exit from halt state
Thread-Topic: [PATCH v2] usb: dwc3: Fix timeout issue during controller
 enter/exit from halt state
Thread-Index: AQHbdMf9B1q4BhH3F0qraArwi6iN6LM2QhEA
Date: Mon, 3 Feb 2025 23:46:28 +0000
Message-ID: <20250203234616.k5nl32tdb26jhtgf@synopsys.com>
References:
 <CGME20250201163953epcas5p10cb7ed0c0090558d4f52c5bef63fb2dc@epcas5p1.samsung.com>
 <20250201163903.459-1-selvarasu.g@samsung.com>
In-Reply-To: <20250201163903.459-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV3PR12MB9142:EE_
x-ms-office365-filtering-correlation-id: fd346bf2-6905-40fe-9ad3-08dd44acfa92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?bU5oUzhYZ29Vb0Y3Wis5VjZhYTJJRVNycVYyVDRYL1oxUWRnRlIvbXE3L1hX?=
 =?utf-8?B?eDZBSkdDOTVKL1d3aUJTYTQyL3BreW5uU21idnQwd2IyQTArM3NNRk1pc0ll?=
 =?utf-8?B?ZEE4VzFIb0RnSG1MekR6QlE3N2FIY0REdHQrZUN4dTFERW1DblBIWldqZ1Mw?=
 =?utf-8?B?MUhTWVlpMzRGMSt4UmpGcGNMOUNZV3ZNd295a2MxN2lGZndiaC9xY01kdG1V?=
 =?utf-8?B?cGxVT1IyYVYxRlZ4QjNEeVVBVk9GWFFUL2R3OFNvZFlIQ2NyOEJhZmM3dEFo?=
 =?utf-8?B?ZHRPekhuTnRKaEJMbFR2eDJ1UVZjR09ITWhYZUVNb2c4ZjUrY0ZaQjlzWkV0?=
 =?utf-8?B?LzgrdW5abjlBZFM2WGdmVFQ0NW1jQ1pQVEFNdnc1clp4UWlTSzRVdHl2dEQy?=
 =?utf-8?B?Mi9PdDh3UnlVVUJUSnJoU2loOEMzekE2KzVRSEZ5aVlMdWk2cHRrb1pRQUNL?=
 =?utf-8?B?SGV5bGlXTS84YjFKNi9LMk02MDdOaTBMT0V2MkpGenVpWkFzT2ZHM0V2NnRp?=
 =?utf-8?B?VU1yZVQwTGJkL0QvTWxuTjRtSlp3SElLY1hBelRGd0hhbTdZbm5jSzRVMUxO?=
 =?utf-8?B?SGswcm8vQmNLNjFxWkxQVFdnRkJIM2JWbUIzWVM3dnZNTjlkeS9UL2JsMjZp?=
 =?utf-8?B?dzVFcFVHVkhjbnBzcU95cjNheTE1UU9PNjVNcktLRTB3K0k4alFNaGJ6NW90?=
 =?utf-8?B?ZStRS2JCTnQvM3hzVWtiZjN2TitCZnF5U2tPVXBDTkdQMVdkWEVnTHY5WVV5?=
 =?utf-8?B?OEo4RktpVG41VDBCQXJCSHRTaWtka2l5eFRSOWYzNlowYU9BeVpuZnJvL2xZ?=
 =?utf-8?B?UTV0eTZGdHczWkF4aEtkQi9lL2FOOXhBV2NtdERRMzZpSmlDbDJvZ3NNVktG?=
 =?utf-8?B?Wjc4WUxhcTF2SmJNTWtudFhLS3VWTHA0NGh5QUlyVmxGOElOWXJVaFBxRzZa?=
 =?utf-8?B?VWUwWFZydFdkelJBS0tRNHU5L2tJMnFHYVlwTlJrZEhudkpQc2k2bDdTbWVL?=
 =?utf-8?B?b2VzRjhvcXcvVGM0Wi9IUFZMR1IyV3k5VlREcEVTaDZsRHhiOFIzc2I4N3pR?=
 =?utf-8?B?cGVmWEtXZ01EQ09Ta05XNGdTWnJIT29pTHRVa0VPSEJhSEVGenFCZlAvOGEz?=
 =?utf-8?B?VWowZGxWTnNEYkRQQ01WY0MyRmM5dFFRU1pqanJ0bVVTTmlvS0RYUFZKd25V?=
 =?utf-8?B?K1dIWjN2OWdRbUlTcFlIc3BaVG1ydXR5Q2d3TjJINWtNOVRuV0RYWW1yQjJY?=
 =?utf-8?B?UlA1VWUrNkh2akgyamk4MFVjWE9TN05QTEtjZ1ZLRkdpSHdRcmJPQUYxOU1u?=
 =?utf-8?B?YWxYQlZ5MWJmUitLYWNHTHdpVnNmL0EvSVNyTXRkL0FaV0VJU1dtbGptb3Na?=
 =?utf-8?B?VWt6ME9idVBLczl1Vk1Rc01ZdllJb04xOXI5eHFNVm1SRzlTdDFsekYvV0VT?=
 =?utf-8?B?VWVCNytaZ1FkWEo3UnV6SnNobGYzUElZUndiMUdXWDZIRzh6K0NWZkptUFo3?=
 =?utf-8?B?WUxKdFkzckFqdTB0aThWRW5QY1FSKzAvelRTQzFnUCtJQjkwNGErTmFaTFkx?=
 =?utf-8?B?N1oyVVd1UjVrSGVzWTNRa0xxVldoRGlUcVhpaWFxTDlia0RrVTd6ZnVxRDVi?=
 =?utf-8?B?SkRhZWdaYlNLaS9EZTVPTG91dnNoYkp5bkhCZHJpMm9CRnhnYTZDdkg4SkJh?=
 =?utf-8?B?MFJDVTlSMzlpcWVvdlVwVnJha2UvL1lQdXB6MG45aTR5SlVoOUxpOS9MYm9s?=
 =?utf-8?B?RThGNGR5bklKalY5bDk1cHFXSzVVNmJGR0JBbzlTbW8vcDNLOVNGMllSREdO?=
 =?utf-8?B?V0ZzS1lXeTFjdm1CSWNQZVJtVS83Y21lc3JUd2ZubXNSNHdzeXcvajMydits?=
 =?utf-8?B?RHFtcnVmeEZQeVBnU0VidTZzNk5nSVhsejFqcGVWb0xKUVNSZDFxcmNaQXph?=
 =?utf-8?Q?/08tIwL5N0qNhpbinRPicmiGFUgrIjfI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWYyM2tCOG1YdDFoYmd0TFdkWXlMNGxtb2J1TEh3cEcvbDIvb3k1SjhZUDg2?=
 =?utf-8?B?enRsdStKbTRVcUExMnV1OE82dTJVRmlYZ3hvTFYwSSt6ZjM4U05qbDVnZys4?=
 =?utf-8?B?eXRXNzk1SWYvcWFzSndrdEhlem9wWmg3ZjN2VDE0bjhKQ0R6c2IyZUMvNFg2?=
 =?utf-8?B?UkRsdndhaWIyUzcxWkJaa3ZDZWYzQm1nRnZPM09ZcUFEQzdGYTNOangxS0Jr?=
 =?utf-8?B?VldrT1pZTmkyOFFJSzVtMVVIT3EwbFZzdU8xcmVvZFZ6Uy9ZK3F6KzFhUko0?=
 =?utf-8?B?eHU0R2JLWkVLSWRqbDNwQ3JTQ3RFZFc2ZEZaMGFrNWUveVFBTWdDOEI5Y0lk?=
 =?utf-8?B?NldzRVF6aUxKcTRMSlV1NGFUVzJqOGtrYzkrN2kxOHd3NTFQUUVTNW03SkVh?=
 =?utf-8?B?WUZOdTFMYlZUcTd4KzFheFNxMy90MjEyai9HTjVFTWdGMWd2Z09abDdhcDdr?=
 =?utf-8?B?UjYxYnc0UWsyYjJTVGd0cGhhaksxd0o4ODQwczkxTk5oT3EvMHNjVExiRW1D?=
 =?utf-8?B?UzZQMnA2S1dSL3F3dHJVT1p3TlRySGhYTUQ3MlB1a1hjd1VGMzBHZDNqOWc1?=
 =?utf-8?B?Q0pWZFJXSjM4a3pmVUxia1ZKRVF0dEVrOC94cEJjZDR6TEtSZTM3UW96ODVX?=
 =?utf-8?B?dFNJT1lhT2xjeGtnZkhuRkJFdHZGeXR6UjRVNVFVNVZOMGs1bk9BNWZ3OFlK?=
 =?utf-8?B?aDZDb1VTWjVQaXdIL01FQURWdmFRd2RVeUpBeStIRDhJSXBVaFB2WEliUDVs?=
 =?utf-8?B?cXJnSXY3SGc2ZWhUZndheEkxcFNwV1N6RVpjWXJpRytyTTNxZm4zQ3VibThT?=
 =?utf-8?B?R0xHTUR1RVFBV3d5NWQ1TEk3akZ4L0FkZUFyOVRneHViaWxIeFVQQ0k1M1Uw?=
 =?utf-8?B?anVTNTU2TlpMQnc0a2JWbFludU9maDZrNDJYQXBvck5wb0t3Rlpsa0JlZDJE?=
 =?utf-8?B?THZFNkJNb3pEOTAwRGM3UkNFT0tMUHlOZm5jdmloKzg5bXdTNXY3aFZDdU5W?=
 =?utf-8?B?YVlKc3kxUWtKSzJ0UzhXTDVrM29vRnJQSEl6cDFzT29RdzZuWS92dXFBblYx?=
 =?utf-8?B?enNDTVY5Z2xueG1vbi9PS2hzQ2QrZnRjQ2VXcms3OFg2SDM5dWVFQWJhVXFI?=
 =?utf-8?B?UG1EOWxRVy9RQjRldXpJQ3RkV0Y2aU9uejN2NXpNcE9JMVhlYmIwQVFLNUhT?=
 =?utf-8?B?UXBBMVQ0bEhXVUMxTTdVWmREOFI5c3IvYTBZMDFlU0w5T2ExM2xaQllyZUZa?=
 =?utf-8?B?M0w5MGh4Ulk1NW9McFNyWW0rSWZDMkFxOUJ2V1ZyWDMwWUVWWjltNTR1ME1w?=
 =?utf-8?B?eW12RFYxdUxHelRMbzdHSFkxb3d0Zzl1Z2pVbHRhZEE3MGRPVXlEeTBkdXla?=
 =?utf-8?B?V2Rkb1BpQklhNURDOHdHNWNpSmExUGhYd295bm55UXlzVGtJbmRtRWtoZ1hz?=
 =?utf-8?B?N3pqbEVjN2UwZE5jdDB3OXhJVDF0c0lXMnZOYkRnYUFzaWJ5dUpXRjlCTU8v?=
 =?utf-8?B?WHBTenY1enZTQUdJOWZLN04ydWgzWjF1RHNGUU5TZ0dHUDZFZit6dU16Z1RF?=
 =?utf-8?B?MDJtRW9rMUJENDRLcGd5MGg0aG1DMjVnckRsdDJhRHpJeGUyRndYZ2FzY2U1?=
 =?utf-8?B?V0dMNnZmYWVONjN2TlI2VERtQ3JUYnkrQngxWEVOZnMwK2JYdS83RGVjQitK?=
 =?utf-8?B?cFMzUlBzRVVjMzJlZUttOXRPQ0loc284azVkQy9UeFJlSWhGaVZ0Z0wweWZC?=
 =?utf-8?B?VFNwSlkxMlp1bm9WSTQySGZwTFlZZWJ4U1VhUi9tSzZCN2JLU2xlTy9WRnF5?=
 =?utf-8?B?ZDFXUDY1b0N2aEYzYVRqdlRpdHZCMFhnYlQ5Z2R3Rjk5ZmQ3TVQwdjFHOEJz?=
 =?utf-8?B?Z3pZOW5JeHQ0YnlpQjdEUjlGaEU0L3VRWGd0d0hBcUplY25QdmZqUTR6NmFh?=
 =?utf-8?B?UVpIb0FXa0dVN3d1eGZQM3ZKMWM0K25JOTA2L0VCNVFsQml0TzU2REFkWmt2?=
 =?utf-8?B?UWQyWEpmODAyejdMZkE3N0pMTlZvWDViVjNpd0p1eDhQckFrSnNBbG1pd1ZP?=
 =?utf-8?B?a3E2SHBUbjhCejNkRnJ2T3FkMkV4V0lIRVVMUWtnclBTUkx0dlpMaGVvdits?=
 =?utf-8?Q?usIl8aXBRutS+4t7JEITIq8Nz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52DBA7F0BF14554FB02CAAFEC0FB61F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lje/hfgTdRQC+DNHTFgHZ3gxCGHyhvfof0+BWqwGZKl+Hq3GMBs4AfqS5p4lMVazrllgbHI7xzDbtR51Fe48d42Dlz6sBjElPAMW+Pu4rdGnoEUr8DE8D+75jfJgAmhada52NZiDzmQcCaatRghkR7zD67jOtD/7JRuqOzf2H6UuUqX2rXjgY9yxjGzPKIVpCT1YUU2hPQjUJcR51GFLtrpvDAdFSfpjD1wFjT81/lHYgkaZaQlp7bTrgSm5Uszi35LKs9PHPQ9Iq7xPkAThlmk/iO4w9bpM2U08p1u9gjiSOGJsR/h6DbvSYrQTGmqMfUVk3GhPPwE97hzs35GsTiMUv1DLbzS124V2fhe+SVXPUDtfArWZxdBCwzhRD4E2+kAGza+51K2xfG2R0pby2iifb8/uSQhiYupQtn7upT3/rOU8sF4VDg5Xlrq/yPcDJUtPy13oDecN0u4aDDSBoj+Gl/kBqYn+ChThXPwpw2jd7H3Zs4iOiAivW2nWY4MGeRYzV3+4FQJfciXXt6BmZNayF5YCayzw9Fu9mt3ZrcQoCv2ZVKoBTCdHIyesi2HdWLBZBOgMKjuqEEA45jXAMQHtrf7JBm1xL3cK4GZO2443Y3eK2ShaxA7NnBnakHVsUiVSdbEdcs39U4U52sPaGA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd346bf2-6905-40fe-9ad3-08dd44acfa92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 23:46:28.5245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDMqqsk1lddiHzlDh9knv+DXWfo0KGK3F/GHYl1gMHeRqhqWvGnj1qRuXKMiiGhKy1fjAposgDjtRiVu7USexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
X-Proofpoint-ORIG-GUID: eyWMIhh7ObgKYzb0lKge6KbIGoYNQdTD
X-Authority-Analysis: v=2.4 cv=SeENduRu c=1 sm=1 tr=0 ts=67a15559 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=UpHNIz-El1H3aM16LqwA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: eyWMIhh7ObgKYzb0lKge6KbIGoYNQdTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=836 spamscore=0 priorityscore=1501 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030174

T24gU2F0LCBGZWIgMDEsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGVyZSBp
cyBhIGZyZXF1ZW50IHRpbWVvdXQgZHVyaW5nIGNvbnRyb2xsZXIgZW50ZXIvZXhpdCBmcm9tIGhh
bHQgc3RhdGUNCj4gYWZ0ZXIgdG9nZ2xpbmcgdGhlIHJ1bl9zdG9wIGJpdCBieSBTVy4gVGhpcyB0
aW1lb3V0IG9jY3VycyB3aGVuDQo+IHBlcmZvcm1pbmcgZnJlcXVlbnQgcm9sZSBzd2l0Y2hlcyBi
ZXR3ZWVuIGhvc3QgYW5kIGRldmljZSwgY2F1c2luZw0KPiBkZXZpY2UgZW51bWVyYXRpb24gaXNz
dWVzIGR1ZSB0byB0aGUgdGltZW91dC7CoFRoaXMgaXNzdWUgd2FzIG5vdCBwcmVzZW50DQo+IHdo
ZW4gVVNCMiBzdXNwZW5kIFBIWSB3YXMgZGlzYWJsZWQgYnkgcGFzc2luZyB0aGUgU05QUyBxdWly
a3MNCj4gKHNucHMsZGlzX3UyX3N1c3BoeV9xdWlyayBhbmQgc25wcyxkaXNfZW5ibHNscG1fcXVp
cmspIGZyb20gdGhlIERUUy4NCj4gSG93ZXZlciwgdGhlcmUgaXMgYSByZXF1aXJlbWVudCB0byBl
bmFibGUgVVNCMiBzdXNwZW5kIFBIWSBieSBzZXR0aW5nIG9mDQo+IEdVU0IyUEhZQ0ZHLkVOQkxT
TFBNIGFuZCBHVVNCMlBIWUNGRy5TVVNQSFkgYml0cyB3aGVuIGNvbnRyb2xsZXIgc3RhcnRzDQo+
IGluIGdhZGdldCBvciBob3N0IG1vZGUgcmVzdWx0cyBpbiB0aGUgdGltZW91dCBpc3N1ZS4NCj4g
DQo+IFRoaXMgY29tbWl0IGFkZHJlc3NlcyB0aGlzIHRpbWVvdXQgaXNzdWUgYnkgZW5zdXJpbmcg
dGhhdCB0aGUgYml0cw0KPiBHVVNCMlBIWUNGRy5FTkJMU0xQTSBhbmQgR1VTQjJQSFlDRkcuU1VT
UEhZIGFyZSBjbGVhcmVkIGJlZm9yZSBzdGFydGluZw0KPiB0aGUgZHdjM19nYWRnZXRfcnVuX3N0
b3Agc2VxdWVuY2UgYW5kIHJlc3RvcmluZyB0aGVtIGFmdGVyIHRoZQ0KPiBkd2MzX2dhZGdldF9y
dW5fc3RvcCBzZXF1ZW5jZSBpcyBjb21wbGV0ZWQuDQo+IA0KPiBGaXhlczogNzIyNDZkYTQwZjM3
ICgidXNiOiBJbnRyb2R1Y2UgRGVzaWduV2FyZSBVU0IzIERSRCBEcml2ZXIiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8
c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4g
IC0gQWRkZWQgc29tZSBjb21tZW50cyBiZWZvcmUgdGhlIGNoYW5nZXMuDQo+ICAtIEFuZCByZW1v
dmVkICJ1bmxpa2VseSIgaW4gdGhlIGNvbmRpdGlvbiBjaGVjay4NCj4gIC0gTGluayB0byB2MTog
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXVzYi8yMDI1MDEzMTExMDgzMi40MzgtMS1zZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbS9fXzshIUE0
RjJSOUdfcGchYUlZOWM1NmoxampiU3ZJSVc0emF1ZGtkQUdvenZ0TXUtUHdqaHJNeTBfdjBGeEdC
YVloTVhTOGZUclZUekVPZXZyOFFpdGVrWHZ1T1BLUGZEeGlIR2E5M2hqSSQgDQo+IC0tLQ0KPiAg
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gaW5kZXggZDI3YWY2NWViMDhhLi5kZGQ2YjJjZTU3MTAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiBAQCAtMjYyOSwxMCArMjYyOSwzOCBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1
bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsIGludCBpc19vbikNCj4gIHsNCj4gIAl1MzIJCQlyZWc7
DQo+ICAJdTMyCQkJdGltZW91dCA9IDIwMDA7DQo+ICsJdTMyCQkJc2F2ZWRfY29uZmlnID0gMDsN
Cj4gIA0KPiAgCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ICAJCXJldHVy
biAwOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBXaGVuIG9wZXJhdGluZyBpbiBVU0IgMi4wIHNwZWVk
cyAoSFMvRlMpLCBlbnN1cmUgdGhhdA0KPiArCSAqIEdVU0IyUEhZQ0ZHLkVOQkxTTFBNIGFuZCBH
VVNCMlBIWUNGRy5TVVNQSFkgYXJlIGNsZWFyZWQgYmVmb3JlIHN0YXJ0aW5nDQo+ICsJICogb3Ig
c3RvcHBpbmcgdGhlIGNvbnRyb2xsZXIuIFRoaXMgcmVzb2x2ZXMgdGltZW91dCBpc3N1ZXMgdGhh
dCBvY2N1cg0KPiArCSAqIGR1cmluZyBmcmVxdWVudCByb2xlIHN3aXRjaGVzIGJldHdlZW4gaG9z
dCBhbmQgZGV2aWNlIG1vZGVzLg0KPiArCSAqDQo+ICsJICogU2F2ZSBhbmQgY2xlYXIgdGhlc2Ug
c2V0dGluZ3MsIHRoZW4gcmVzdG9yZSB0aGVtIGFmdGVyIGNvbXBsZXRpbmcgdGhlDQo+ICsJICog
Y29udHJvbGxlciBzdGFydCBvciBzdG9wIHNlcXVlbmNlLg0KPiArCSAqDQo+ICsJICogVGhpcyBz
b2x1dGlvbiB3YXMgZGlzY292ZXJlZCB0aHJvdWdoIGV4cGVyaW1lbnRhdGlvbiBhcyBpdCBpcyBu
b3QNCj4gKwkgKiBtZW50aW9uZWQgaW4gdGhlIGR3YzMgcHJvZ3JhbW1pbmcgZ3VpZGUuIEl0IGhh
cyBiZWVuIHRlc3RlZCBvbiBhbg0KPiArCSAqIEV4eW5vcyBwbGF0Zm9ybXMuDQo+ICsJICovDQo+
ICsJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpOw0KPiAr
CWlmIChyZWcgJiBEV0MzX0dVU0IyUEhZQ0ZHX1NVU1BIWSkgew0KPiArCQlzYXZlZF9jb25maWcg
fD0gRFdDM19HVVNCMlBIWUNGR19TVVNQSFk7DQo+ICsJCXJlZyAmPSB+RFdDM19HVVNCMlBIWUNG
R19TVVNQSFk7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHJlZyAmIERXQzNfR1VTQjJQSFlDRkdfRU5C
TFNMUE0pIHsNCj4gKwkJc2F2ZWRfY29uZmlnIHw9IERXQzNfR1VTQjJQSFlDRkdfRU5CTFNMUE07
DQo+ICsJCXJlZyAmPSB+RFdDM19HVVNCMlBIWUNGR19FTkJMU0xQTTsNCj4gKwl9DQo+ICsNCj4g
KwlpZiAoc2F2ZWRfY29uZmlnKQ0KPiArCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VT
QjJQSFlDRkcoMCksIHJlZyk7DQo+ICsNCj4gIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywg
RFdDM19EQ1RMKTsNCj4gIAlpZiAoaXNfb24pIHsNCj4gIAkJaWYgKERXQzNfVkVSX0lTX1dJVEhJ
TihEV0MzLCBBTlksIDE4N0EpKSB7DQo+IEBAIC0yNjYwLDYgKzI2ODgsMTIgQEAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9ydW5fc3RvcChzdHJ1Y3QgZHdjMyAqZHdjLCBpbnQgaXNfb24pDQo+ICAJ
CXJlZyAmPSBEV0MzX0RTVFNfREVWQ1RSTEhMVDsNCj4gIAl9IHdoaWxlICgtLXRpbWVvdXQgJiYg
ISghaXNfb24gXiAhcmVnKSk7DQo+ICANCj4gKwlpZiAoc2F2ZWRfY29uZmlnKSB7DQo+ICsJCXJl
ZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKTsNCj4gKwkJcmVn
IHw9IHNhdmVkX2NvbmZpZzsNCj4gKwkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0Iy
UEhZQ0ZHKDApLCByZWcpOw0KPiArCX0NCj4gKw0KPiAgCWlmICghdGltZW91dCkNCj4gIAkJcmV0
dXJuIC1FVElNRURPVVQ7DQo+ICANCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg0KQWNrZWQtYnk6IFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

