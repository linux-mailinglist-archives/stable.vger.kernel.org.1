Return-Path: <stable+bounces-200097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D1CA5D15
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71FA300EE52
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792C1D130E;
	Fri,  5 Dec 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ti6ypF8+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HRIJjoQ+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GhyfqNEV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C9126C02;
	Fri,  5 Dec 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897603; cv=fail; b=Xim4kJffLsX3KhU2xffaOZ7Ib1Vm7I+EIUFoOmfHi2+Zt0JTw/J1OXhCzoDdZJqwJ//BhbZHlg1ezi4h57B1A2lYZhE+0ZyLnjAAzQGKzh8Q+XF77y3xk7B+VDUnBN7sDqbB7vYgSptCUb99pZS/tPqXvM5eX8zY+zo/UpQMgJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897603; c=relaxed/simple;
	bh=2etfyHqji5GgYk3CQBq5oQ/HUFG06mYBlUIwMl3pErk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gekmBYjjJtUgwt+O+SNWFuhG6wbhrf9NPhjoZv1KyemI3OaOCljfnFbT0tjb7kSYyW0mRMetT2312WyopC6nNQbAAt2mOq/Ar8p7zb8H8A0EqJ2JP6n6aDqqzwZrrDkrwW5TKnueZgD4kspAFYSsRg+wbdsKl1BeqEaM0myOFJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ti6ypF8+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HRIJjoQ+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GhyfqNEV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4JfbqT3490768;
	Thu, 4 Dec 2025 17:19:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=2etfyHqji5GgYk3CQBq5oQ/HUFG06mYBlUIwMl3pErk=; b=
	ti6ypF8+jXElDNnifRaKvyG6KqvlatPyU90X28eQsMfVdYh/EF/603S3T4mcN7jC
	2DCepha7f+dmPsDqEPel1OPaYKemUOsjcSi65UWHrfcSbcq0166aGN6PP13jUg9R
	R6OM8z1ReYLkmAuXyBWDBXNAH7T20K/Y/X6o3f1uXPhIJ5LDkzq9zvIRcy5B7GJC
	5yCrY3wtVIXgndhalO3zAdnO2tschFCv6W8dRF22nnWcRvCWpvwxvvo2I5KozvGl
	/v8gy+u52J73OZDhE4fJfjHuwNhvRhgXsrWEyVqZ16kdH66au8PcQDWCSkmf8KXZ
	rTUhWHCnCA66zR+o4pDQSA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4aucr9an0e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 17:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1764897591; bh=2etfyHqji5GgYk3CQBq5oQ/HUFG06mYBlUIwMl3pErk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=HRIJjoQ+kSdotI8FsTIUqEBclkMoVQ3VetpmhA15MX1W4ljZk+KYY/1USCtk5KAdj
	 yYi5vhklyPCwoqGh3/0gBHyrKgHR0xB9L4VPnwPElIDZTl3UTNnBRdoI35VryYA6+H
	 Gx+5qtTmJiX35Ff74qgNhPzXUJIxRxzt4Yroj73o+2YMgUX3yU5VBPCB8HIDGMYqKH
	 Qnxu0uFPvBqFYcJZV8xXg+QYdtUpEKLfvCsiw81MOJyOzy6f1FGDuLlVDXqQ2R1ClU
	 VYJF8zfB0WDp6IE1IAwUDHOgD+jXr3g0Wu4es2gbQXGGQ8t/8YIIkuYM1fbt5Fddzj
	 zjUxgB9YcBK6Q==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 125CA40352;
	Fri,  5 Dec 2025 01:19:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CBEF8A00BB;
	Fri,  5 Dec 2025 01:19:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GhyfqNEV;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00100.outbound.protection.outlook.com [40.93.1.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0BE8E40AB7;
	Fri,  5 Dec 2025 01:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBxehy/XcNXAynaYZJub5fFTL5dHyNXlO/ReR/rlik9vfkd8RhPVlXv/QYAPANf9LGhBgCtk3ZVGA07YN9Os4zJoMRJbbvI4j/9axRWs88d4keVWnMG3IkaEqLAxxvjLS6vusi0D8jX+B1qErfmLDN+sDP66aU5Vtv540f4odcqPvRB6YykFZpUewWtHKhZGx2Cv6UX0fn5KaSb4WeXFTaO3gU/KzxJAipkyQP4USz0OoEuDv67RP3LofiQ0Es7TO5MFBwRcQfrvFI5GVC7m/QvfT89hIPTqDrHUHFONyZVqeqsqfimtPn+pWoNjkS6v1h0+2NscrxJE1pGmmtWYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2etfyHqji5GgYk3CQBq5oQ/HUFG06mYBlUIwMl3pErk=;
 b=q3c8ypoY+m7ZCMpNstY5TNLjqQx+QFEs/w40RHQ7JtNyStQvZ1np+Uo6N/+7MQf224/Ds0ZEem1Qt6PLMbRNpcGx4V1lAMZ/WL6Mv0Y//5IxarHVJavL+z4JBYq+keRYgSeopshcBbGJo6+o8QLuGmEW5Mz6L1t4rq9DWNceR4VwLtdD12oFeWr6MqBypJtyfPICc4B1bYqNoQGgzFC3B68/EgY+XVjqdDc02pUTl4wSpPdYWmo1nkltsLw6g3rI0jzDojISjr8Fu2C1IIlM+evrfDlAX2IrlrpcagxYHj3OQP+88zdAkgosuzFmkqC6UZhernhcnBpNa1H4i/LIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2etfyHqji5GgYk3CQBq5oQ/HUFG06mYBlUIwMl3pErk=;
 b=GhyfqNEVegb/fyjsu7X9ULWHsykQ6c9W87DaBuxlap4DALfQzchrGKylyG/m/x4x2yxRNha/yJj7d0iqzJFoYz6oaG3PaIXJEkZC1etiBDVVH2Id90KKa8ZgQ5jvXJ94HB1BZtF3Eil7kr3TacGREpU8ANCdiKzpwm2arxRiDoM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 01:19:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 01:19:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com"
	<jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com"
	<akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index:
 AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYCAABgXAIABfkgAgAAM6ACAEwJnAIABVnmAgAC/OICAAL5tgIAAC3WAgAAAVAA=
Date: Fri, 5 Dec 2025 01:19:41 +0000
Message-ID: <20251205011934.zppcs2wmd4tqnshg@synopsys.com>
References: <20251120020729.k6etudqwotodnnwp@synopsys.com>
 <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
 <20251121022156.vbnheb6r2ytov7bt@synopsys.com>
 <f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
 <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
 <CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
 <20251204015125.qgio53oimdes5kjr@synopsys.com>
 <9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
 <20251205003723.rum7bexy2tazcdwb@synopsys.com>
 <20251205011823.6ujxcjimlyetpjvj@synopsys.com>
In-Reply-To: <20251205011823.6ujxcjimlyetpjvj@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB9128:EE_
x-ms-office365-filtering-correlation-id: 3268a348-2d27-48d9-1e32-08de339c5de8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0RUZ2pMYkNjdTFBU1V2OFNldDY2cVlPNitQaTNyL0pVclJQV2JVNlJnb0xI?=
 =?utf-8?B?VlJXT0pya2ZMclJJclk1TUVMbTNvL1ZTbVVGTnprbUFtbHQ4a3BhY2lqOXVw?=
 =?utf-8?B?M2M5emkyVzIxNXo1OG9mb0Z3NEVyQWtWS2JIRTRHcnI1UjVrOXZRdTVvdStY?=
 =?utf-8?B?SFk2MTB0TndoM3Z0ZUw1ZlMxcktWUE1obFU2NmdYdTBYRkFVWktaV3hRM0Ft?=
 =?utf-8?B?SFFuSE9LSDRldjZPMWxOVnJma0xZTk1aT2toN3FSQVR0VGhPMi9JdkVJQTRE?=
 =?utf-8?B?cEhVSXRleXQwL0o4d29oWHY2dkMrQnB4SjhPLzc5alMrbEZ1S1dFOWk2QlFi?=
 =?utf-8?B?Qy9wL2hlN0VHTitGMHNURG9waGdRZkYvVnZpMnFlK1ZEL1BkVENzNVVheFFj?=
 =?utf-8?B?U25TTHJVS0dhNnlYVzFiZ0xZaGlIMk1tOFloTWZRc1pIazQ5Q3N0RVYvOWtx?=
 =?utf-8?B?ZjJHYi9RanpNeTdaeElQMExXMUJJWmhlYnZFWENEaENiQ2tGRGhtT1B0SVJC?=
 =?utf-8?B?UHQxWjlqVXcyNlNmL3ZjZThZempxZzdhQlVNYjljVnpIcVpEb3J4RW5Uclhh?=
 =?utf-8?B?QmlMQ2FXSzVwNGJTNEhwNjR4NkNVTG5wUWlLUUNmMWZ3bkgySmJTcEh4WU9L?=
 =?utf-8?B?NnpmQ0RFcUI0TTRMMHpVQnJQSVBVZzJsQlh1WXh6ZTVCdzF2bmpOTDRLS21F?=
 =?utf-8?B?SlZRck80dkVpN3B6YzlOMHZ3eWlmcnovR0FxK2RWdTNRNDA1K3hzVTMyQ2NL?=
 =?utf-8?B?UE8ySWs2L3RXRXhsT25Zb1o4ZDUwWUlyd0pSdWNhTmx6MlJKU1o2ekZKd2VQ?=
 =?utf-8?B?RHR5dUFVcGxiNG5COStvWHhTRFZKMjloaDBYKzJEMG9lS1VKSlo3Mm12cWs2?=
 =?utf-8?B?bUdnUmxtdE1XS0xFM2JNYmEvSENHSGk3c1pWZHc0c3BVMzQ1dUovcjhSc3c2?=
 =?utf-8?B?VUF1U05MWTZBOHd2bzhOUE5QUUtVRld6a2Z4WUhxaFc5c21nRHlVSWVOdVJw?=
 =?utf-8?B?VU1UZVczYVhpUEZzeDRheGVIQ1VXTnpuYm9WL0VGQU90Tzk2MjlGTmN3WFZL?=
 =?utf-8?B?V3hNNzhIMk95ZkNNaEVhUGxlWk9uR2RIcnRyY0J0QzhnOVRISmxLVGFDcElP?=
 =?utf-8?B?OXFKK3o3Yjkxa0JZcVBsSTlPMWJEMjBkVjdRbGJXa1I5SktxR3dHa0h0NWpu?=
 =?utf-8?B?R2pTZitNR1k4a2RyK0dLOXF6MjJ0bSt1VVkvakRsazA5V2tYbmh1NC9BL21a?=
 =?utf-8?B?QXNoUWlvSFNjL2JETWtCNytiZ2VVdzNSWjYzSE5RL21nSVozREE4Z0pXd2dJ?=
 =?utf-8?B?S2hkTjBSQkp6MEY2UGFIZStjOVFTdXJzS2NRbEdhbTU3RmZwY2V0anMyd2w5?=
 =?utf-8?B?cGU5aFEwNE5QRUZSZE12L25TOWRiM3V0aUJQcmdzaHVpWkNXSnluQVNmcUZ5?=
 =?utf-8?B?OEx1ejhZR0lUM2svWHorVlQ5Q0NkZWozbzNKQVdXbW1WeVByOHd0TnZnY3la?=
 =?utf-8?B?dERDQjA3MFNEaU5mTnJjOXpIbXZadjBYUmJJUXRaRHJjSnoxNTdIL3V2L1Zu?=
 =?utf-8?B?QXRTM1NsaXZOZ3BxR2JaTHQ4TjdEeEtSTUh1SGVRQ0hSbnp3TEhudStPaFp1?=
 =?utf-8?B?aGVtYkx0cU5VdENPaXNaeHh5TlNYb2NUQjdNbWtuVTR0ODd6OE5IVTBaQ25V?=
 =?utf-8?B?QVMzVHpRd3g0WHFkZk1zblpiYlJ1bllGZFhBbEd6RHhsbjlGSXhJTEFjdmli?=
 =?utf-8?B?NDVKMUNOakorcXVJNGxZYm9Cc2RhZjRuZXV1VzlhUld1UmhTR3J0K3pFOFVu?=
 =?utf-8?B?cU1tNkR3MEpDNFluQU9kcGdET2liVHRFOU5oNXVzNVhMR21Uak51Nm1RNjlT?=
 =?utf-8?B?WDk5b3hFY0VjdXFLT3RnT0p6SGJFVzhoSTFNVDV1L3dKbThIQy9IY1J3S05V?=
 =?utf-8?B?amUzTms3K2VQTi9jOXRUMkdiTkljeEkyQWxtN3ZLbk0wRzhaZTNxR3l3L2Rw?=
 =?utf-8?B?NTZZTmJHUHVJQ0ZrN2tKekdKc1JGbVIzbnNOVndITGx6cndOeEtKdmtDVnFL?=
 =?utf-8?Q?VoxhGV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2pHSFl6Zk9tMGpnMmtqQkxCQ0FqQWpnS0txQ1J6dlJVTVNvdTVTeEFYbzJ4?=
 =?utf-8?B?SXcrZlYzVlkrdUhMTktRZWRXNFlkL1dFWWlxRndVOFl6aXZKS2FZY3Y1aEgy?=
 =?utf-8?B?b0ZrN29oVEt2aWpNaVd4eEtlTm5zTzFFOUV4UHRBclZSWjFKWlZMajJEVUVn?=
 =?utf-8?B?ekVrSVhkNW1GNFFqdnRKSExIZTNtRHNjelJBZkdkUldQR21XbU5ZNmdGTTVt?=
 =?utf-8?B?NE9zSElyM1hxMC9seXBTZGtiVWZxdjNRa2diNG1KNUk5Zk1WVkJNMDZIcDRG?=
 =?utf-8?B?VEFnZVZXbWJXTUhhVElmcUVDQ281N0czbkJndkU0dm9meVl5OWpsNWg3cTNP?=
 =?utf-8?B?L3JVVS91Tzk5a29ZVm9mZ3dycE5nK0EzT3ZoMk8wUGpLMkhmU3NaL3J3SkNH?=
 =?utf-8?B?aUFKNDhadWFRMjVST3UyOXg5NjZRTXByQjlET2YwSytrMjEwTVZGdFduUXBn?=
 =?utf-8?B?NmNYeEM1UlpjYWRrMnFDbmlpc0lrRUV6bk83azI1NlVuS1JyVFZlSFExV01J?=
 =?utf-8?B?azFQVGJrK01HTkhXRXJJNCtZZXRWTGZ5OWk0Nm5xV2RpMnFjU2JZcTZ0RVd2?=
 =?utf-8?B?REZWT0tzcnZXRG45M0U3bEZhT2EwTzQ0UzF3K3k1ckc2QldRM0pHR2I1d3By?=
 =?utf-8?B?NHYwKzJHTmtKNSt5bFJxRGF6OXdpWEZjVFdpcDBLaWgwdnFPU3ljR2pvLzJv?=
 =?utf-8?B?UFJuWnF6aHJkOG8xM0RUaDhoSUNEL3E2MTJ4QlZvdGw2V29lWll4MG5LbE1C?=
 =?utf-8?B?NUlDejgycE96MDY2Mlgwem9manVaMHVhNUsyeHpPVkk4VVk5aVBIdmxLSlBn?=
 =?utf-8?B?V0s3OERRbTd0RURoVUNTSTRMWjJDc1JiRC93MmtkN0JhYVpRK3Y2WU41M3Ix?=
 =?utf-8?B?dFVaeGdwSWhCRkFXbWRVWXVRdzdVOGVCcXpUOUVHY2J2eHl6VHN1K28ybHk0?=
 =?utf-8?B?SmQrTE1JWENTMEMrWGw5eEVQYjJDSXBmMTJqMVkvNGtQQjlCRitSVVFaNkcr?=
 =?utf-8?B?SHJkb0FrMk9kd3ZuME9jN2ExczJtR2FoUlVldTVHZlN5NmRDUzVXcXAwaDk4?=
 =?utf-8?B?bzh6TzZVb3dDT2xoalpDdlNYYU1kZTdlOTc1aVcwSDFnNWNoLzh5RjVPbW1B?=
 =?utf-8?B?bVFoT0NIZTlHU1RiZk14ZjRLZmRMWENZalRzQTY1SmNvYmx0SGN4NE9VZTgx?=
 =?utf-8?B?RmpkMFdGdDB2ZEphQUEvVVpxeDdzVDhOOW1OYkhMK0NtVjZTbG1CNjhaZThr?=
 =?utf-8?B?ekdVbUc0aEJITHBvL2lvNUhkOEZxeWhrZnpoUHZGMkorS2srcHhsbFhlbi93?=
 =?utf-8?B?UnNaWE9lcERvbkw4bTA4VndPVjlpenlmOGF5VEVubXFZaWtvWE03d1dmK2tp?=
 =?utf-8?B?b0NuTzAxazYvMW5hU3k2eEpadFhvTklLN1hJQ25PT25FOXozcUd4Z1ZvRXMv?=
 =?utf-8?B?djFQcEdqclJwaUxEbW43WXFsRlhyMGJGRUorRlhRV1dZamVjc3JBNGtGbkhC?=
 =?utf-8?B?WUN2Wk1vZW5FYWExTlMzVUl6S3p3K2FjV1ZEZUMvVElIZWZXdnNXU3pEbjkv?=
 =?utf-8?B?MHczbjFxTEFpd01uN0RlOEhsWGNjWXF3QXZlNjVjUE9oZ1VTVkFscS9MR2pI?=
 =?utf-8?B?OEV4RHgrZUlGZmtlbTg0Sjl1dGhIT2QrTG5ldDczOFpnOCt0dUdBTlplcG00?=
 =?utf-8?B?VmxPSFhuTTB6VHRRREJsOVNBSEMvWWF3MlRESFgrMFJvb3dNdzJ0cnNjc2FQ?=
 =?utf-8?B?WHVNS05GTkFPZ280dkxXbWdhWEZiS0xIYXFzTXNUdlJnYXJKVjNRMS9JVHpi?=
 =?utf-8?B?NEt1QWwrTmFmMFljZmhSOG9oUkl3bFdKOHFPUnZacjF2VWZrOVAxRmo0NHNP?=
 =?utf-8?B?ZHhub0UvM0hGMkZVUkNGSzI1eDFCdmlqK1M1b1A2QXphQ1h4MGQ1R1lhbEht?=
 =?utf-8?B?RFVONG9RWVh0cVJUSjRvOEwxcDhmYjdxNHVrZkpCWlljaGtCUkhCQnREeHN4?=
 =?utf-8?B?SkUwV0lzN3dRcVFLT3ZlL0FWd0NuNzFjSkZsTlhKMWFsQS9tTWtKOXNPY1Bh?=
 =?utf-8?B?Y2htUjNRUFZFdmFEazByTGdzWUtFUEtTVE1XTkhDVHZ0Z3RsZExHRzNEQXgx?=
 =?utf-8?Q?HmeFcarP3y299Y4eYovkA4lgi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B74DEDE0DDB6FC49BB0090DB6239E55B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DJvxOIdrAX4jySFvArahgHm81rlAbOnJ6bX+FsboiT+BYSyWHwhjvdmSI+x/sJZwX1TH7YHYcT5iNMDxK0qYxIwCgA0VjOPlSsFdoqIx6OnJkOeW24FIKsLWCKV7Uh4H+bXPh9I6M/l/UiZ1rGT/9rU9GgmMRcQRYrDUJd4WX0Ulc3IhaoQCGQN7JELAI3EEVooS6DSG6mX0fhX3+VcYtYQpjRr6PzjJlFYGk4th3rjxSRY390el786Xu6tUlaxNDkzpjf9YHqv68KincO0T1Y5hZwlWWbes5wEnjdaIygoNfLRqS+L1CF91rgIvd7JsWdA1nQD8OHiRC8RxdpeqGbIJm+jq121D65klllU1BG1et35+FK7NBRPzI+FZBlVNOt6djSIWYv+0g/K7+8HQU8BtdZJW8YTiM5eAjglg1dDt8J1EIdfXlFGlvLmgxU6xligbW5GA1YVdAg48mfUZQdUTcYNf/+hBs4NeIUhxvUqrCBJA6ODN1mvL4OM/N6T0QiB3BJSdPqPvKQVbSaQ1dWthCMR6ikA3XwBh6jATqAZtiFwu70m9n2rwQFJA4UCaJKxi6ASDKwAgi0FbI+Anw8MOsOACAFk4IJCMjYsvyDgBLAAoLmshlvT1i2eA67R4hMmDflF7XuwgFTpAVadE5w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3268a348-2d27-48d9-1e32-08de339c5de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 01:19:41.6103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvW3MacGDkEjC47Nc5a6utrqhfg7eRtZoQLq6nzIQSfLxFwkaXrKAxTUh2vsiYEKCmBA4t+hTf5IdfNJBksm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
X-Authority-Analysis: v=2.4 cv=EeHFgfmC c=1 sm=1 tr=0 ts=69323337 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IVZ_Ey6ZhaSl52n-jb0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4bETPT3W9zQDIlWy5NExl-PhGcc_kqD7
X-Proofpoint-ORIG-GUID: 4bETPT3W9zQDIlWy5NExl-PhGcc_kqD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAwOSBTYWx0ZWRfXyJqUGyx2rVlE
 VgQ7hJZB3kySOZLZVKQvDesgDgGNAzstp3dTORms2zZKDQcQefrbQuPiMWYmGcgSD/q8MVSuXRY
 vgMnakgSwFCiVETaUTedvSe6is5fuy/JSjs+/7PKaUrtiEt+Ho+wBSQkCFSnxiNnIhcYnECzfds
 Xk7lR/gcZ5N/s25RjMuvMMswP7gdc8sU23foVV8Fq1K3B3HT+aiLv1eWfyz6oiyR0fH+2QZKmpK
 7PWlgvX3AFf+G+KoRwGwCZaZ+qZm3sZNZwEmfeK4dMZkLeuL2i7SrmueCFmd5C8n0jKwRflT1TD
 MXkx21AHAkTdJJJJQzguwiis7WIVexz/YkLtxl14xd9ukZbl+lDymGpTu9r9lxKcFMMu/QykCGe
 pMWpzxFUFULm7XfKDLEVnmHH1MJEhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512050009

T24gVGh1LCBEZWMgMDQsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gDQo+IEFjdHVhbGx5
LCBuby4gTGV0J3MganVzdCByZXZlcnQgdGhpczoNCj4gDQo+IGIwZDVkMmE3MTY0MSAoInVzYjog
Z2FkZ2V0OiB1ZGM6IGNvcmU6IFJldmlzZSBjb21tZW50cyBmb3IgVVNCIGVwIGVuYWJsZS9kaXNh
YmxlIikNCj4gDQo+IFJld29yZCB0aGUgaW1wbGVtZW50YXRpb24gaW4gZHdjMyBhbmQgYXVkaXQg
d2hlcmUgdXNiX2VwX2Rpc2FibGUoKSBpcyB1c2VkLg0KDQpSZXdvcmsqDQoNClRoaW5o

