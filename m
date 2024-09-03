Return-Path: <stable+bounces-72778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B629696ED
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A76EB20CF2
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9A201279;
	Tue,  3 Sep 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="fv0nz8nN";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zAELOvvv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9845003;
	Tue,  3 Sep 2024 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351836; cv=fail; b=QziTab5mbugNrVUHYVYQfuNLwH9Aq3ZrFz/I7obGuy7tW8WyXSELpzJByCPyQWd24DXP/hshyFJiFAL6MIMUHO5jy/iferfyZFHzm88pI2zl7bT1pmcunJ7Lpqg9gq5x/ZnddC6tuHY1td7j0LN27Elltdih/9af+miMz7Ylgr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351836; c=relaxed/simple;
	bh=WEodl5IJf95uxAmTVr+8dUaIkQRORtfAP0GfPEG+gDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQ8V2lDN40VTbvttFvKa3k+X9gAWAVz9eNRizxVlRc3l9KgCbH6REwgDM7RUpfHCEtMTXXqHqIaZQ2NOQuXBLvbkkzWzL5RmTcZwMLYpNpf4qwgKVRnwIqsT4Vv4qQDVm804vjqj4GJwW2K/ba99GhWCNcGT01YOHAMbu0eHZbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=fv0nz8nN; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=zAELOvvv; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482NS5v3004559;
	Tue, 3 Sep 2024 01:23:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=WEodl5IJf95uxAmTVr+8dUaIkQRORtfAP0GfPEG+gDw=; b=fv0nz8nN5Y5d
	1fNd+7zUxOuWTTmq1MH246EwU57cjQpMXPGS5H9gwR4tlWlwuseGRvf+FxW6rQxq
	rVxjNPnOusHQu7Y3cWXwo8CwYN6V8S/KNbW1sLPXxwNeSgC/GZ+ToSZZh+Ut99P5
	c32I/BZzry6uhlF2URYqoILSkoddbB8RZqQwSHhHxeM8uKc8hoxw/L5R8vmxtJeU
	97mnrrA0/zchfOs0Wv+nVbiVxRktR5tTBPbbZIkBrRNpp/pPGFrJDsslxPdldxP+
	STMb4VVsuqABtpX9V+Gq8yzWd7LIU/DrqYFySkZRxRNNM5yH55vMyYPQfckeb+0x
	1U1o7tWCNA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 41bxrv7me5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 01:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRoFhUMaUr5HVfN3+7mvizJ28e3h/pC4cvmzETOMg8NCW59nzoiCAEVdWUS0MF3OTPc7sPVdRVEEmedEAnY/BT2ATdtRPyghvwHZVA+IyYtD72EB5ri1F8n0KbMiKCdIlg+I5uRHWIie20QysLhOWES4G3W2MtkxEIh4zMfG2JVD8k5IeMLmRuRVTSJZWgI8iHxiXsAX7YYL4rq9SK5fpXi7ggnJ+kxfqriFoepaL1lpyJqaAcfYha7P+lKidH3feRv+V6cbUZz9oUZ9Hx7xo63O+lGf8aPqG7EaML0CU7TezDUQ99TT1Z5ArZQbD098/Zpnvfx4hKpa+7hxgLWZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEodl5IJf95uxAmTVr+8dUaIkQRORtfAP0GfPEG+gDw=;
 b=X2iZEmhPldInp7NrsE7S5n96OiOFZxxuragE1g1RBPCU0Qy6EddoNJBv0HQ/gnoRfb+iLMYuWtrsANAhrdt7KdgcY+OyHl0agbZPbr6jembEohUToyCBAxBp1oi9ZKLJVG6bzNxWosPC4lh/lb8Et1RwzFyqTxj68F07NFq+8SDqPS7khcuCjJEUOiVn3xrqJF93k4K0cXlm+vIMknoEt3ivVhxKjrskYBN49dELEQeGEIm+chPyx9n5RyFDdLXp/9qAIrh9EKspHMp1/T9R1KnV40sPuP28/g4MGOHzGQ/JgxI1FKI2kJpScPC3aGs0S5mmyXvbBppslWZ7ZaujPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEodl5IJf95uxAmTVr+8dUaIkQRORtfAP0GfPEG+gDw=;
 b=zAELOvvvCktst3Qrsti9zo8kohV9Val4wpRDBJsawYtsf8fcqahOaQodpNaWUJbd6zy/KEdfLPn6zNdS2Hd1hwFZghz7wOUmRjcd95hcQNQxjMJaaAWcBQiOlBBcLz443HxeyHp7SyzCVCQz4Nm60wC1wTlM3ePEqdQtQbzSo/Y=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ0PR07MB7517.namprd07.prod.outlook.com (2603:10b6:a03:28c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Tue, 3 Sep
 2024 08:23:39 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:23:38 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        =?utf-8?B?TWljaGHFgiBQZWNpbw==?= <michal.pecio@gmail.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Thread-Topic: [PATCH v2] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Thread-Index: AQHa/RNa/dUaC22w00+afkpTMVU5CLJFsSOw
Date: Tue, 3 Sep 2024 08:23:38 +0000
Message-ID:
 <PH7PR07MB95381C966C8994CE09696E67DD932@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240830174504.1282f7b4@foxbook>
 <45435906-0a30-4546-a7e3-20f1f7d50713@linux.intel.com>
In-Reply-To: <45435906-0a30-4546-a7e3-20f1f7d50713@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWQwMzI3ODU5LTY5Y2QtMTFlZi1hOGI0LTYwYTVlMjViOTZhM1xhbWUtdGVzdFxkMDMyNzg1YS02OWNkLTExZWYtYThiNC02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjIyNTgiIHQ9IjEzMzY5ODI1NDE2NDQxOTQ3OCIgaD0iYkdRZElIRXVXcm5uS1ltQmtZdWVQR21tT3lJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ0PR07MB7517:EE_
x-ms-office365-filtering-correlation-id: 2a14d132-4b52-40a0-7ab4-08dccbf1b66a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTQ1cGRCeEpLaWxFMjhKVHF5SUs1M28vcmtPZktucWFaNVYxalNGTHc2M2Vh?=
 =?utf-8?B?eGpQblNoVzVSUC9ocXVXWERIT1c1Wi95dFg2RklJUWlTNmNrUDd3K2xHdGUw?=
 =?utf-8?B?S0pZbGhLckRZVHlVMXVVTTlheFEwZXVtNG9mejYwcEpFMGZKbWQvT2JsSnZU?=
 =?utf-8?B?THNxQUkzQTZSa2RJZzk1b0VMeU5ybllkVi9qZDhIUU5MQjZoVWdSUXVxd05z?=
 =?utf-8?B?M0FqZHI4RXJyaDJkL2RpWi8rbWZBbEptVjUyeFQxblM0cmQ5K1pURjdnWThz?=
 =?utf-8?B?NlZGVDJsWFp3NVNRSzNJRGVHeDZ0MnB2amo3dEpjcEptamlvdUhJVG1DalA3?=
 =?utf-8?B?RE82SEI3K0F3RjR6OVIrQ3RpcVpRSkVGS2tGL3paNUdyTk5IdHl1UEdLQ3NU?=
 =?utf-8?B?TW0vSFpsZWY4eitSYURqNEk5czgzT1h0UFU2Z04zT3UyT2lmMmFUazRLNncv?=
 =?utf-8?B?cTR3eE12OHZBQkNCdkdtamYycTMyWU94T3diWmdFUFVNZnBJazhNQXpuTTE0?=
 =?utf-8?B?eFRLVTErUStVZHZubU52OTBZNm5wcnh2WTJuSk1Uem9pam92LzZPSitESnFW?=
 =?utf-8?B?OUtqcEQ5aWl2amtBSnJUZUliS3Q3WitHU0QyQmFhc1FKRjFaRjdMVnBvYmxs?=
 =?utf-8?B?a0xVb1BTZ3l0VDVxYWdNLytPcGtmMlZUTFdJOGNDWk5SV3EzUFdTbkhlaEVL?=
 =?utf-8?B?bjhVODJZRHNPeFZ1RnAyakp4NFlPdFpPS1k4REJ2NVVudlM4MHo5eU1KU3Rw?=
 =?utf-8?B?b0ExQXlMbzVtNldlNEI5ekhJYzFuUmpxMzB6aTVoWjRPYWRLNytWeGNOaGRX?=
 =?utf-8?B?VjMrTS9CeUVzcTYwRzRKSmlYeHRhSHp0ejJ3WXUvdDh1ZEdiVkpWWFdTU2M5?=
 =?utf-8?B?Q2gyVzQ4UkNLNVc5akYvSWtKb0hDTGx5RlNQODRJVldhRjJNZFk5eFo2R2ll?=
 =?utf-8?B?bTc0UkJmdGZyVWRsUGljSW9acGhLUHpoV25TaHpaakNHVDhMSmV0UmtialVv?=
 =?utf-8?B?N2VUMmR1a2JybHBPYWNlT0lxdWZvUlpzTDNqdlM2eldzUEVkc0ZUc0RWME1I?=
 =?utf-8?B?ek9mS1hnNGxibEY1K0x1TVgzNkRkR3pDQzJscHZiOVdHcXhzelFYNlp5K1g0?=
 =?utf-8?B?WXk3dlFqeUZSaW40aXo0d0Y5Q0VhUExMQWRDZE9IdDBiZEh5ZDRvV1dUQk1R?=
 =?utf-8?B?aE52M0pyYlBKaHBoZ0xWMmNFQkt3NlNKR1FQdTgzWTloVTIwUEc3bkNpWlZV?=
 =?utf-8?B?MXFMSnpMRFJ0ZjczTWJIWVFVR3lydDdCK0FvWk5HRTZQRnp3dGR3eHZhR0pU?=
 =?utf-8?B?elhZaFRlSTBIOUZHS21Wd29XcU9RamF5dzBGM0hNZzdadHhPbGJQRG05OXlV?=
 =?utf-8?B?OC9XTXBRS2NQQnpzWjdTSUJVZlZwaHljdVcvK05HdDRwWnQvbzB1WWVvWFE5?=
 =?utf-8?B?czhNR1pmMTlEUkNZeHZJeURYQ0c2Wjhqdy9GN3hZYzFZdDV6SGFlVFlaL2lR?=
 =?utf-8?B?bUh4U2Z4S3NWc0g3bXQ5WThjS2ZGclFVTU9sRVpBVTVrTE1CZ0R3RDlRZ2xK?=
 =?utf-8?B?U1BpUXZYVG5hOVE1YndhOEVDNGdBOFBPMm1rVnVvaEh4cnRabVU1aTRrL3hK?=
 =?utf-8?B?Y1pwNGlsa0dFcmlQR01lckt0OGNFTHI5TGlSelk0YmZKV0Vabm5vRVphcFFr?=
 =?utf-8?B?TWd0SFFZNWFTL2Y5dzlYeGtmb0g3RGFzMVhJbVVWNy9QT1lSRXlOME5RNWhM?=
 =?utf-8?B?a3UzV1NTTnlPOHVYSG8ydnFSQ3c5OUJ4RklnSllzMGhlU1NrclEwMDdJRVFO?=
 =?utf-8?B?blNHTUVQVmtiMHVqa2l2TTR5bURYWXI1MmU2UDMwQWY2RjFmK0dyUExDZXpq?=
 =?utf-8?B?bURhbDdac0xDV1hsTXJmS1ZHNkRWc3oyaGJlak9mNGdDZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0wvNXh4ZDVCVk5Hc09hQm5EMTJzKzk3MktCbkZXa2dYOTA0My8wcisxc0dN?=
 =?utf-8?B?a1ZtSVEvY0d4TUZDaDU1VmZDZlNYNTNLd2JFc09QZjc2ZUJhbUFZd1lkSzc3?=
 =?utf-8?B?ZU9WaFd1K2FTeUY1ZExLS1FhaVUxUFBaM3RQbnpZM1UyQjNkRitWdW4xK3FS?=
 =?utf-8?B?UWpaOFBBMmcvL1E3T3RVenJsdzMxOU1saDMwSFdBTnpaQkZBdGorUFM0QXkz?=
 =?utf-8?B?N1Bvc01lNzQzTVFvTVVGNGJYblU2bzRCWkJ3bG1WclFlMmtMTVVIVmhzcXBN?=
 =?utf-8?B?YzZNVWxsOEExM0E2WG42bCt2aUdzUzlzSFIwZkRhZWZWR0g2QldFTXpISndh?=
 =?utf-8?B?YWpYK2dDYzZtdmVEUE5mZURVd2kybitxR2diQ25zZlVIVEZaVm9hVC9NcUFB?=
 =?utf-8?B?d3pSd3VrcG56dUU1ZlpuTFhMVUdvL0pHbXFhTHpac05Fd3p1S0VCRFZ5WExu?=
 =?utf-8?B?ZHNyNWsxSHJCUUJJWjJSMjN4NC9UM3NIY0wxZ3dWY2xCbmhjVnluektyOTlt?=
 =?utf-8?B?MXRJWTZUQ1ptQ1U0c0pBUzNXdVduTUxWZ25CeG1lb0RUZ29tYlVpZHhLOUNU?=
 =?utf-8?B?alNYeHAxTkFKQzc4aFFGOXZxMWVJN3hLSFRTZkcrQmNwUkJVTUZDS3pxb29H?=
 =?utf-8?B?QTV6TUJKYSs0VnVvME4vM3o1WFVmVG8zeWVUaWs0V28remwvME9YWTF5TWlD?=
 =?utf-8?B?R1hEV01LZlhzWE1ZbUdmNW9QODJVU2R0V1NzbUVFYURkWUg0aC95ZG14SDJq?=
 =?utf-8?B?SDkwS0JzZjMvZm95S1gzbjBKV0hjRDhqL0dtSWMwS0RTSUdLc1luVHRzdG0z?=
 =?utf-8?B?OVcwSjBRdkNadVdtSTY1YjVCT1phV282VTFoclFuUG0vb0Nocm5LaDYzUDFi?=
 =?utf-8?B?UHNwTnlhd05tdUhiNG91dUVjcUg4MjNmVmtxLzdsUjQ1aVEybzhqTG9oaWJn?=
 =?utf-8?B?Z25OeVRHVUVwKzAyakhxYWxMVkg4K1Yrc3NMQ1VPbk0xbjIyRTBKamFETXZy?=
 =?utf-8?B?bWhhY3MrYlIyb1ZpK2k2TmltUFhoTkk2VUltYXprNVBUMm5JTUtDR3lrOURt?=
 =?utf-8?B?eVAvVTRtbGswVUpKNGlKMnRBYThHaGNBODdYdEVTcnpmY0NpNmI5R3NGeWFk?=
 =?utf-8?B?bE4ycEtOc1V5d1RrMlZMbE5ZeEJOc1JYd3FyWUdDMzF0c09XOEV4TExoTGhk?=
 =?utf-8?B?NkhwbmpxSGhwZ2NaZlk0S2xHNHVrSUV1QkFpdXFDVmFQZzhWRTFob3Z6eTZ0?=
 =?utf-8?B?YThvc2l0UHFTUHpXcEM1THBabGdneDN5bmdORk5VaVNrSlppNWJQVW05VWtY?=
 =?utf-8?B?V0ZFbm5wWUt3VzFrcjZZS2dWTEE5ZGlGZEJhWmZ3TGFoVm9ldlJ5UEF3U3FU?=
 =?utf-8?B?ckpkZFpPbytUS0VpRzlabklTWWVOY29ad25OSjZsMzBRVmkySHRUbWR6bTBy?=
 =?utf-8?B?SlJLQVNsTUc1T3AwaFk4MzFPLzRXMWVER1EwZldIQS9ZeHJaamo4RzdMRVhT?=
 =?utf-8?B?d2FEU3ZPM01XSklReVhwN3BjWEJ3S29DbjdmU1FJR3pUWGUyMGtCalhpWlFQ?=
 =?utf-8?B?dUNjWUhDMk9MemVIakZucXQyRTVyQWJSOFlZMFhjOGF5Mk9DU09KRkdMR2FQ?=
 =?utf-8?B?bXBhNEdlUTBTek5TdjI3UXhZcGdXUk54eHg1Q2lsTlRhdFBKTXZ2dmR4VnVr?=
 =?utf-8?B?UURLdTdXeHg3d0RGNXBXaDJMQ1FGZ3pERUJzeFV1ZHdoblN1ekp4MGFDVTdw?=
 =?utf-8?B?ZFNqYkNkNFRJcTB1ZitPZ2x6cjZNVDRZeFh5MTF6UTRtYVg4Y2hJSVp5Mmdx?=
 =?utf-8?B?OGJFNVd2aG0zVEM5NGlhbEJvbVZTamllSDJqcHAzTUp4YVlNSmQxUXlvem13?=
 =?utf-8?B?azNSdXBOZFErbDI1VVdRdWxza0Y5SjRjS3NCYkYxcnc2bWdvMno3VXgzN3JC?=
 =?utf-8?B?d3hSa1l2dUVOdDhERnNzb1ZYeGp1RGFSK3pwNjRteXFOR0ZHZktlOXlPM0Nx?=
 =?utf-8?B?TVBwNmZ6endsTW9aellkZElwOFdCK2QrdUtPSno2ZER4ZXNKT0R5U3hoa0xU?=
 =?utf-8?B?eHNGZXV3ZFovdVRONmhYV3ZEOEJTMUV6NEdIQnN0Ty81Qi95L2ZMbnFvbjI5?=
 =?utf-8?Q?aOwyTbcNzQwrYdgy0LHov8hDB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a14d132-4b52-40a0-7ab4-08dccbf1b66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 08:23:38.7472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBgVcpF0yBd7xpyWVfI2FvryqwipubW2DK7Y1V+srUw+aq9NEyhkcEO5hpptavZqBMLXI3aW4TZhCZ99BN3iNWxQEtx84dtJ2CQk5QI5EE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7517
X-Proofpoint-ORIG-GUID: qvkf0p8EiGx5zdK5_B3exLzK0yHZepwl
X-Proofpoint-GUID: qvkf0p8EiGx5zdK5_B3exLzK0yHZepwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=619 mlxscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409030066

SGksDQoNCj5PbiAzMC44LjIwMjQgMTguNDUsIE1pY2hhxYIgUGVjaW8gd3JvdGU6DQo+PiBIaSwN
Cj4+DQo+Pj4gRmllbGQgUnN2ZDAgaXMgcmVzZXJ2ZWQgZmllbGQsIHNvIHBhdGNoIHNob3VsZCBu
b3QgaGF2ZSBpbXBhY3QgZm9yDQo+Pj4gb3RoZXIgeEhDSSBjb250cm9sbGVycy4NCj4+IFdhaXQs
IGlzIHRoaXMgYSBjYXNlIG9mIExpbnV4IGZhaWxpbmcgdG8gemVyby1pbml0aWFsaXplIHNvbWV0
aGluZw0KPj4gdGhhdCBzaG91bGQgYmUgemVybyBpbml0aWFsaXplZCBiZWZvcmUgdXNlICh3aHkg
bm90IGV4cGxhaW4gaXQgYXMNCj4+IHN1Y2g/KSwgb3IgYXJlIHlvdSBzdWdnZXN0aW5nIG1vbmtl
eWluZyB3aXRoIGludGVybmFsIHhIQyBkYXRhIGF0IHJ1bg0KPj4gdGltZSwgaW4gYXJlYSB3aGlj
aCBpcyBrbm93biB0byBhY3R1YWxseSBiZSB1c2VkIGJ5IGF0IGxlYXN0IG9uZQ0KPmltcGxlbWVu
dGF0aW9uPw0KPj4NCj4NCj5QYXRjaCBpcyBtb25rZXlpbmcgd2l0aCBpbnRlcm5hbCB4SEMgUnN2
ZE8gZmllbGQuDQo+DQo+DQo+PiBUaGVyZSBpcyBubyBtZW50aW9uIG9mIFJzdmQwIGluIHRoZSB4
SENJIHNwZWMsIGRpZCB5b3UgbWVhbiBSc3ZkTz8NCj4+DQo+PiBSZXNlcnZlZCBhbmQgT3BhcXVl
LA0KPj4gRm9yIGV4Y2x1c2l2ZSB1c2UgYnkgdGhlIHhIQy4NCj4+IFNvZnR3YXJlIHNoYWxsICpu
b3QqIHdyaXRlIHRoaXMsIHVubGVzcyBhbGxvd2VkIGJ5IHRoZSB2ZW5kb3IuDQo+Pg0KPj4gQ2Fk
ZW5jZSBpc24ndCB0aGUgb25seSB4SEMgdmVuZG9yLi4uDQo+Pg0KPg0KPk1ha2VzIHNlbnNlLCAg
UGF3ZWwgTGFzemN6YWssIGNvdWxkIHlvdSBtYWtlIHRoaXMgcGF0Y2ggQ2FkZW5jZSBzcGVjaWZp
Yy4NCg0KSSB1bmRlcnN0YW5kIHlvdXIgY29uY2VybnMuIEkgd2lsbCBwcmVwYXJlIG5ldyBwYXRj
aC4gDQpGb3IgdGhpcyBwdXJwb3NlIEknbSBnb2luZyB0byBhZGQgc29tZSBleHRyYSBxdWlyayBk
ZWZpbml0aW9uLg0KDQpUaGFua3MNClBhd2VsDQoNCj4NCj5UaGFua3MNCj5NYXRoaWFzDQoNCg==

