Return-Path: <stable+bounces-89766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9219BC146
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 00:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD51B20FB6
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 23:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9E1E5725;
	Mon,  4 Nov 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NViUDXkq";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ULDHMulB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CdeQVBzq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7716087B;
	Mon,  4 Nov 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761744; cv=fail; b=RvdP7LHRsj0tgSF3ViICyszkSQn7c+TBPTYLk+8xeoxWewemP+ZKTJaTeINjC8CyS7+UNpNJCskNNXsIhzKM6cshN71mBZbGnFD5gxYP7PATJbMFVEekjaX0bdv2O5InHWz0cxuDXhkVEfXWFEqgNeAzGPdaxNUDMoI5O1ebBnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761744; c=relaxed/simple;
	bh=GT67Kb0v5bdkHLQlCeKI9bfQyXuO8NdY5MN2VeUQgUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQIgya6UMu97rnSfl3C02rHb/rOUQYwgyFyij2qTve2v/wv3k99yFs+oQJTmOIwnkteSkAQJZBzT5vO1371Fcds4BbF5YccyF3TtCpwQvSsx8jogt8Sxa/Nmyhbg+Vuzyn386WENtrl+5Eg7lxog8VrkkcmN9TwrOKqryWSzlRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NViUDXkq; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ULDHMulB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CdeQVBzq reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4HVTUi002539;
	Mon, 4 Nov 2024 15:08:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=GT67Kb0v5bdkHLQlCeKI9bfQyXuO8NdY5MN2VeUQgUs=; b=
	NViUDXkqQZ+og56Lt570to1cFz36LRnUaAvSp/PoZxWgJG8avTtQtgVHgt56cw8B
	hMfQzZwojy8Zm48I2uH7a1axcq++4VrqY9VpNPCQqcl2TAU1psEK0BLG7xFt3Uzd
	fr8KHclL1N9XIlaZXN5oymhPLbeweRkyUmJeWlrNza+9uE5sVvZ8bn/NqvFNYgUz
	kudFFocuRqFKc2Z6RLUQi6/lV0tny23lYRxLA0V7iOeUS9o+FpbAfNv7UvLv9bV0
	7Ke/DfB5ZaOMSFYkL16bgxMcHK+GIFQA74yFhZzoZgu6tT+roTaAsFJRw3D/dThH
	rbs0E8LVajVRuk1tllSgaA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42nk0uadrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 15:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1730761719; bh=GT67Kb0v5bdkHLQlCeKI9bfQyXuO8NdY5MN2VeUQgUs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ULDHMulBG0ix4GDxnwo+CH1sMZohyl7M5aswJB3Xf1cN/KAjP0GjaXQIxL85VEJil
	 FGqKRalxa+PCXaWHhgZ22XExepxa9b41Z62Trgb3ubUUAiSmZz2oT8rzP5UUU6km1w
	 qnQARt2y+39Ef3yHBqBsnawRkqIKT3X3twVC+KytbYagolNtO9geDIMaVEbMn7Tau3
	 Nhbt7B4q5j9ihmtbST+MGtUvVoFL6xozz8SlobOIch6zedHO1F1mNmLIEtf7+qeENp
	 tueCHz2CL6w76RH46UJPFj9plpbCkdunRlLX4hR2FNyHvXLlGOtyL9+Fs3ieHfuf8d
	 s55ciQ0q4T1dQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB5AF40107;
	Mon,  4 Nov 2024 23:08:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 13EC8A00A0;
	Mon,  4 Nov 2024 23:08:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CdeQVBzq;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A3047404D7;
	Mon,  4 Nov 2024 23:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngp6UomZ7ewxXqwIQoL3TUfFPHMDTuf63HY23lMsCoSwUShbDRERmUJXNVWUXMOXh/5Tx+sDor1BpY7M9Nnp8tpuaNSdz6VBZI2Uhl/nQOQ9JlRVJsaDdSWXjXAp2AkrxA7iWVFJSd59chZ8eqrg4DxiMxB8VemSwFi83QmTYzerwC+CtgNJHn2+npkMXqADoeAXDqElRN7bNAXk6nmcEYCEBbCRxCVOOitagbFiP51q9HjQIpeQ5pvgkQalO7ZUqtvGjrvRfvpT+3tBOM2JpsN5K1cFfi7jNX6a8pmpOCbH9+6CmmhHCrfhb3Z4TxlQ0oKCcbQQcC6dLp4sCnnElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT67Kb0v5bdkHLQlCeKI9bfQyXuO8NdY5MN2VeUQgUs=;
 b=i7GBBjyx4EYedaEcWmVKjIBLDu5Q6Gw7V1s5miEN/G0+GVR86RaSwqr+aTSRf3QpP2l8Yjk+lk5tK4SwBQJhGyUR2UX2ViMY21lO9wo6zkVaAsVtNmn4Z3TJam86c9AKZAccgMBdzpB73vkHh68kGoqxu5x+9r195KdGyjKwCisWxrgiP5jqOQ4oWvKjmethAHW3flHl77M8q1Rbx0OKFhi2S3XHaioj5MU2r5ED6owXGs5Uf6kb074Viut0wRqwY0vo2Er6+np/M9pbeCYK0crtBiqJK4mOqTUxVHHLiJKQd6b8t+jHxS2S4SpCvFcWYc61m9T/e0FbUVrQXckmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT67Kb0v5bdkHLQlCeKI9bfQyXuO8NdY5MN2VeUQgUs=;
 b=CdeQVBzq6aQ1CYyt6/oGNtWl/wos82I+uqejxgowknfvMep4Ezac6AxYbd4+ZpFwL9IaAR2xAwHcqiqh89bddxPEL3cWa/oX1cJMHvqGsX/sCi39XR9WKKMa7MZ5nYwhdNEJwWq2ffWcHFEoMgaFlT0SO1xBDUBMzps7z74wpnA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 23:08:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 23:08:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dhruva Gole <d-gole@ti.com>, "sashal@kernel.org" <sashal@kernel.org>,
        William McVicker <willmcvicker@google.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Vishal Mahaveer <vishalm@ti.com>,
        "msp@baylibre.com" <msp@baylibre.com>, "srk@ti.com" <srk@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: fix fault at system suspend if device was
 already runtime suspended
Thread-Topic: [PATCH] usb: dwc3: fix fault at system suspend if device was
 already runtime suspended
Thread-Index: AQHbLsHmRfzg5CHZvkWg6ADFzzg0D7Knv1oA
Date: Mon, 4 Nov 2024 23:08:33 +0000
Message-ID: <20241104230818.wr6lu67ye5kwko5q@synopsys.com>
References: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>
In-Reply-To: <20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7570:EE_
x-ms-office365-filtering-correlation-id: 246d7f63-7799-4b2c-cea6-08dcfd259ab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWdWdFNZcUM0dkdpdVRFV0ZVbE9DaUNUYmVDcUMyNTFpYjhOZm1YR1k5UFpj?=
 =?utf-8?B?VUlQd1lDLzdEd2J5czRCVVhyeS9yVHV5UXl1bFdiMWJ5bjB4ZzRvMlNCNlFy?=
 =?utf-8?B?aGNQQm5QWW9jZkU2V2FmaW5WTzJuNDlINU5wUTFCaHlwQnFmbTQvMThFakIy?=
 =?utf-8?B?VWhmU050ckVHKzRoc3NvWU14SWM0VVAzN2ZLNXZSaUF6U28yOHBLbmFJb3hH?=
 =?utf-8?B?L1FnUUdSby8zazl6NHVjY0ZhQzYxck1pNlBEMUpMZ2F2aUZZNEVTdkVCRHpC?=
 =?utf-8?B?NVNFc3JocW16azJRUEFVRXFNRmZZM0NpcWlJR0d4VkZHNnduSHdEUGdYd2xZ?=
 =?utf-8?B?RmllaTdHUFpNSGVvMXZIWVluRS8zSFN5aEZ3K1B4VzF5OTNESHZ5YXpBSnh1?=
 =?utf-8?B?TG9PVGdSQlJweFFyM2lVclZqdU9rNzZac3VRa0hkRVc1YWVVZEE3Qkw0TGxR?=
 =?utf-8?B?S0lGRlYrR1UveTRYaUk0Z1lDb1A1azdqSi9CME9pQXlhcWRnUjd5Sk1zbUNu?=
 =?utf-8?B?SjBNZDJGdFl4SHZmWmRoNEgvK3RvUVhDVFRrYVNaS2sxcDR6NHMzZERDeHd5?=
 =?utf-8?B?UzlHUUZ3QTRHbDVLWE53Ylh1VmFxTU9oWmRBQWNnU0xadXpxenYzR2VlSktW?=
 =?utf-8?B?c256Sk0yeURyN2dYUUFIaUljd0JFaVlaM0RvUi9sdGYzZVBIb2s2SksweFBv?=
 =?utf-8?B?dEtCU0xNL1FYME1vcGV5b1kwMS9VdGNqM1NVWmpFdG1iK1pqbm1NMzdkbFhs?=
 =?utf-8?B?Q1phb2xVdkxTTHJmem5IdnZNRkhHdXVyY2ZLbEtiV3NCRk10d0hQWEhsRUln?=
 =?utf-8?B?b0cxQy9XZnBiMzZCekhBUXRkU2dodUs3V201bFJPbVE4RUM3bGRURGx1dEt1?=
 =?utf-8?B?L2JPZklsSjBPTFZSTXZmRno5Z2JDeEpoRTBRNlg2L1F2Z3dqR3dzQWVXRWpq?=
 =?utf-8?B?RGczU1ZzaDZ1Y1B3VzNQOHVlZmczMEJ2c2tUakIwVlZMa0lEaEdjUld1Umls?=
 =?utf-8?B?Q0dxUkdrYnpQcHd1WmdEY3Z1TU0xOTRleHNGTytHN056bzdwdVFUQ0VWbzZX?=
 =?utf-8?B?cDJ2eTdWd3Mrc0dFY3FTNGtZOU13blpBS2pROHZCdzBJYUFTMmlpdFZRalFv?=
 =?utf-8?B?OE1wTDRMNUxTam80NE9POU1GdUtrYkZqV2UvUnlKREpST1Z6MTdMV3lvcFIz?=
 =?utf-8?B?TlJjNlZoTmFxVk9RaFdDRHUxc3k4dHI5bWx4SE9YYk96UmJnQ1k1cndnVmc4?=
 =?utf-8?B?THVLdDdXbWZObDN1djd2a2g3UWsxK1FsOURzUGc0U2lhUGJLbzZCa2wxR2JF?=
 =?utf-8?B?dDZBRStWSytEaDVtYlc2dkRxeW1WVWpHTlVIMWlwU04veTdkbFE1RVJ5N2hP?=
 =?utf-8?B?VGxKM25ZamRxYnRtL3pPT3d5enBJRGlUaU5DNDBDeWJ6SVhhbWV0MHJnUkdI?=
 =?utf-8?B?SjQzN0hLREptQ1ZuMGpJUWRVVVZ1RmlFa0d3a3Q4cVZLOVJVYWxwRW9nZzVR?=
 =?utf-8?B?MlZFVTYySzJxVllYMkNzY1hyeEJ1WjlVUEFCZm9KM01SMlZtd0Z1ZlFocGRP?=
 =?utf-8?B?U3IvY09lb1Z2cU9JdTV6cFlOUUhPb0xqQWpYU1pyWlF6Sm91NUgvTkY1NTda?=
 =?utf-8?B?cS9WaGFuYTZCTU9xRWc2U1NITjhMazFaVkxlOG43OEhaYUpDaU5IVW1ITlAz?=
 =?utf-8?B?WUY5aFVHQ0xoZWc0WGdqSnpyajZtMEVNNHFhdzdyd0NkL1dtZHZWcmVNTzhD?=
 =?utf-8?B?ZjJXM1VEM1MreE1ybGQ2OWJIRnJrRFI5MlZzUnNuZE8xV3J0UGljcjd6cGRp?=
 =?utf-8?B?VjBITVpyZGRiT2E1c0tUaDhsVVhyc0tOOTU5UlpLQTh3YjVXZGE2M0VxbzBZ?=
 =?utf-8?Q?5BGmG4P+yAgnZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDNYL25HVmwxblpuRlcwdUxYWGxxOHU4b25aamF4WCtkNHluM1U0emZEZjdB?=
 =?utf-8?B?bE1MeDkvbjZ2Ym94VzRPMHVhbVJuV1hBUVZCZFd5azFiV29mZDdYVGVicTNy?=
 =?utf-8?B?UktNT1h6QmVJWUpaNjRTc3ZGRVJlZnZ1OWJsTGlFZGpxRkNuVnFJTGNMMjFj?=
 =?utf-8?B?T3BIU080eHFYV3ZKUHg1YkJsdmVLaXlkdnQxdDNRWjZNZEpkRWJqWWtVMC9j?=
 =?utf-8?B?ejRsOUZmL1liVzUxNDlhL0JOU3dnckZsYXl4SUhTRTEyQjZFU1k4RXNSZU5R?=
 =?utf-8?B?TkJRa3hubjZVc0ZxbDlVeWdPOU1EalpuT0wwcjZkZ0FjajlqcTE0cXpQdU9J?=
 =?utf-8?B?YmJqV3VtaWZ1QlV3L0k4MnVmRVdlZS9uTkRtMFovQTMwNmZEclhhN3lRcjRF?=
 =?utf-8?B?dnFMWFR0WFFobnRYcDFPdnU4U1pmbnFMcDRIenE1cEtsZTRZMnlVOVVBVmZW?=
 =?utf-8?B?dWZPRktvTDREeUZlNGI3OVljYzVMQjNBemZRNnRUazdtZFhxSDRFZ3g5Zm1n?=
 =?utf-8?B?d3QyWXRXMFAwYVg3SUVpZG8zM2lBenlsKytrczFjOE9oaWdqOGF6ZWNIUGI4?=
 =?utf-8?B?b0F0bXVTSTBDWTVJZVZKUGFGMGhJL2hSOGRleFN2ck01b3Z3Q3YzM3ljQ2Q4?=
 =?utf-8?B?WWFFeW9pTFhDOFZhSFBPN0ZHazRKdUIrRSsyQmxYaW9LdG5DTHBEU2NqQnZR?=
 =?utf-8?B?NTBuUEFLYUdRZHU4MVFWUG9SRm9pekZSNFdBQ2owSUxoRm44VDR5ZjdFcm5J?=
 =?utf-8?B?RXZrUlFnSHFNNnJpdEFTQ29xeFk2UVVWMlhVQ041VHFSQU8zOXJCWnRrYmFF?=
 =?utf-8?B?YjVDZWpVM1VyR245c1dmc1dWUUdNYWltZStBNC93UElTclZONGVjOTR4UzFG?=
 =?utf-8?B?SGl0MFhDb1MxVjF2M2U3VFM5ZkNoUkFnMDZIVytQZHdkd0tOQnFOaVpWTkd5?=
 =?utf-8?B?M0ZubTc1QVZKWW44OGtkY2NDdjN4V2ZXVERBcWRodkZLZUZCcG5PN2VwVFpi?=
 =?utf-8?B?bGE2TlAvSHg4YmMwdEdhZEozblpCbjFpdHVCZnJBNXBLL25QVFRYTjU5Kzdi?=
 =?utf-8?B?eWRpZTVBR1N2NUV1endGckJwS0hRdzJDOTE1N0xiNzNvZTVrb2xFekhIYndh?=
 =?utf-8?B?ZXlVQ0FkdGNBYnJWSXE0N2R6bkJObnk3Y3IzY2hoZ0k1aXJ4d3RXRG44VFRL?=
 =?utf-8?B?YWNlVnJLcW91dHF4WnMvOHRYSWpiNi9oWmdaL2E2NWxKeXlkWXJweHpPK1RG?=
 =?utf-8?B?VHh6YTNIWDd5bzJKb1k4aDRpQXp1T2Jva1RWNG9VcUhib3VtaFFyNXV6VDFv?=
 =?utf-8?B?Wnc0NGMxNHJyaXpOZGFSdWtWblllSVNOckcwZUlCNnZTTjEvaU5aY1ZEMUdQ?=
 =?utf-8?B?S2hndGkwVXY4WjNNVzlUMG5aNmRuR3I5eEpQblkzdDlIajhmNmdNZ1d2cDc3?=
 =?utf-8?B?ZUV1dG5WRUZnQUUvaG9GaEp1a0R6OUtwUlhDWVVwby9POEJUVklUUkEzWmpP?=
 =?utf-8?B?QUZsbFMzcDhPWXVRYmU5UzdIUkp1N3FydmZKTHVveGJQRVFoZ0lUWElweVgw?=
 =?utf-8?B?WWIraXo2eHhHcWhQS0Z4RVdHTmgvOXRjb0JvSDkxNjJrQWxlcUpzMFhqVlNr?=
 =?utf-8?B?SkpnSVZ5R2w5QkdHZzFBWlpVUk0rOEVkcEJvY1pOOE51TWtQeDZwOGNjZDEx?=
 =?utf-8?B?NHZiajNIVzhQYk1PSGxUcjFVUlVZQTltOGxhZTg1QlphZ0N0RjJMeVQySVdq?=
 =?utf-8?B?TlZNSGtWb0I2aE5aY2FzZnZUWGlXTk9xZFhreGFsNWtxU21nYkh2Y0ZybzRi?=
 =?utf-8?B?M0ZON2xVa3E4SEFoeWdydm5iRnVRT2hIbEM1NWt5bHpzaXYyaWMrdkF2U05D?=
 =?utf-8?B?NWwyeERnRjA0VGdhd3AwVjFPZjdkdTJNaEQrY0ZEbzRRSjZlK2pZVFZHUjlH?=
 =?utf-8?B?dzF6U0pZeTc5OGpLdzlqb0YrTFFuOElkaGRiS3pncnNBcUdDckdYVGxOSzIy?=
 =?utf-8?B?TGV4R3pRbk1QWjFqL2U0QlBMN2tBWnBGN0tPZXp4MmJSdmkwanEyNnkrblEw?=
 =?utf-8?B?MFlBMVNFbmlFOWU2WUJmcWxEVC9Lc2sySDA5OVVJNndaR3J2c3c1VEp2YTNZ?=
 =?utf-8?Q?Dn9ZfPj553vkgnSiUv3PajL4m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <052356E1982F1F4FADCE0460E5B3DD4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0sEyvNhXgYCUwWL8tSc0VAWUQnP0BKR9Bs4WRXEoCvqFsTK9fWvoCsW/btL7naQ/65o3GpL+8CgzHkDPWMhrgwR6kFZG9H/ebMlVu1zL2hMb/611ulb4ya17vfukVGzatAP5zfjItwVxCgIfrlP0LAiimJlKaKybyx3E0iTfODOa0Bo3qRJn9MTxabI8GBUpuTFH5+9RQnJwfMGeOMZ0l89B6W+eqXhd16OZ3HdJVncSw5+Ttajlt6dWHX2m2/f5BOkDj92gn5xWldRme5uYzBeaj7YyYa5Ple9wXs1q8lBqm6xbPMPjXhInhYel1SJPWoQSdadnOJTNi6GX0UeawQx4Rvu0XxxeXlEYz+MWtLRzO3kndhju9e9sXYRsSochPuTiGs3V7QswCOt8EjB7YjKx4gZSmoRPBSi+p+cU0GGBeNBuU24HKyplpvpOiyw2I4blXr+V9PMwOrgWctbBmKD3G31ISDBNWXn7l/LhxiWsZM2x9y0EHG9rc/IX3ZU/TW8CR8e5ysYLEJnxzsr+TDrKPggPU5jApBn/bn/Vst6ATsAxA0PCRtSTmHeMr7DhwV3EU6bObVBIxVS/N+mCfKQ4mKfTDzUWWecLuJ5AoV15TmoSQ6Ag4Hl9DrpHDEjnQn/JgGXFczBMsbi3A/heEg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246d7f63-7799-4b2c-cea6-08dcfd259ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 23:08:33.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tjvyi6ljfPMx+dnEnb0kfdB9bGVJjPoEWSV6u9R52xV/CCMm3+fWsusdLRPIRer0NrcbbltXge5Z8YoIb/vbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
X-Authority-Analysis: v=2.4 cv=IarVWnqa c=1 sm=1 tr=0 ts=672953f8 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=_UMFKcEa9a6fA2YPh0UA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: dn9z4UUFbISifJarNM8QZKEinuWD8Ox7
X-Proofpoint-ORIG-GUID: dn9z4UUFbISifJarNM8QZKEinuWD8Ox7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=841 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411040185

SGkgUm9nZXIsDQoNCk9uIE1vbiwgTm92IDA0LCAyMDI0LCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBJZiB0aGUgZGV2aWNlIHdhcyBhbHJlYWR5IHJ1bnRpbWUgc3VzcGVuZGVkIHRoZW4gZHVyaW5n
IHN5c3RlbSBzdXNwZW5kDQo+IHdlIGNhbm5vdCBhY2Nlc3MgdGhlIGRldmljZSByZWdpc3RlcnMg
ZWxzZSBpdCB3aWxsIGNyYXNoLg0KPiANCj4gQWxzbyB3ZSBjYW5ub3QgYWNjZXNzIGFueSByZWdp
c3RlcnMgYWZ0ZXIgZHdjM19jb3JlX2V4aXQoKSBvbiBzb21lDQo+IHBsYXRmb3JtcyBzbyBtb3Zl
IHRoZSBkd2MzX2VuYWJsZV9zdXNwaHkoKSBjYWxsIHRvIHRoZSB0b3AuDQo+IA0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyAjIHY1LjE1Kw0KPiBSZXBvcnRlZC1ieTogV2lsbGlhbSBNY1Zp
Y2tlciA8d2lsbG1jdmlja2VyQGdvb2dsZS5jb20+DQo+IENsb3NlczogaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9aeVZmY1V1UHE1NlIybTFZ
QGdvb2dsZS5jb21fXzshIUE0RjJSOUdfcGchYTJ5U245NDJ2OC1GWnFBZ3J1NmVsZm4wQXV4bmwx
SnlCdmVLOXoyaUFlTFpwRXBWYWpmbDNwYmZsNUsyaFZsR3g1WXFmUmF6YmhxRjhaSjJ0M2ZfJCAN
Cj4gRml4ZXM6IDcwNWUzY2UzN2JjYyAoInVzYjogZHdjMzogY29yZTogRml4IHN5c3RlbSBzdXNw
ZW5kIG9uIFRJIEFNNjIgcGxhdGZvcm1zIikNCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJv
cyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
fCAyNSArKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCA0MjdlNTY2
MGY4N2MuLjk4MTE0YzI4MjdjMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTIzNDIsMTAgKzIzNDIs
MTggQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBt
X21lc3NhZ2VfdCBtc2cpDQo+ICAJdTMyIHJlZzsNCj4gIAlpbnQgaTsNCj4gIA0KPiAtCWR3Yy0+
c3VzcGh5X3N0YXRlID0gKGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDAp
KSAmDQo+IC0JCQkgICAgRFdDM19HVVNCMlBIWUNGR19TVVNQSFkpIHx8DQo+IC0JCQkgICAgKGR3
YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTCgwKSkgJg0KPiAtCQkJICAgIERX
QzNfR1VTQjNQSVBFQ1RMX1NVU1BIWSk7DQo+ICsJaWYgKCFwbV9ydW50aW1lX3N1c3BlbmRlZChk
d2MtPmRldikgJiYgIVBNU0dfSVNfQVVUTyhtc2cpKSB7DQo+ICsJCWR3Yy0+c3VzcGh5X3N0YXRl
ID0gKGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKSAmDQo+ICsJCQkJ
ICAgIERXQzNfR1VTQjJQSFlDRkdfU1VTUEhZKSB8fA0KPiArCQkJCSAgICAoZHdjM19yZWFkbChk
d2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKDApKSAmDQo+ICsJCQkJICAgIERXQzNfR1VTQjNQ
SVBFQ1RMX1NVU1BIWSk7DQo+ICsJCS8qDQo+ICsJCSAqIFRJIEFNNjIgcGxhdGZvcm0gcmVxdWly
ZXMgU1VTUEhZIHRvIGJlDQo+ICsJCSAqIGVuYWJsZWQgZm9yIHN5c3RlbSBzdXNwZW5kIHRvIHdv
cmsuDQo+ICsJCSAqLw0KPiArCQlpZiAoIWR3Yy0+c3VzcGh5X3N0YXRlKQ0KPiArCQkJZHdjM19l
bmFibGVfc3VzcGh5KGR3YywgdHJ1ZSk7DQo+ICsJfQ0KPiAgDQo+ICAJc3dpdGNoIChkd2MtPmN1
cnJlbnRfZHJfcm9sZSkgew0KPiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+IEBA
IC0yMzk4LDE1ICsyNDA2LDYgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVj
dCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICAJCWJyZWFrOw0KPiAgCX0NCj4gIA0K
PiAtCWlmICghUE1TR19JU19BVVRPKG1zZykpIHsNCj4gLQkJLyoNCj4gLQkJICogVEkgQU02MiBw
bGF0Zm9ybSByZXF1aXJlcyBTVVNQSFkgdG8gYmUNCj4gLQkJICogZW5hYmxlZCBmb3Igc3lzdGVt
IHN1c3BlbmQgdG8gd29yay4NCj4gLQkJICovDQo+IC0JCWlmICghZHdjLT5zdXNwaHlfc3RhdGUp
DQo+IC0JCQlkd2MzX2VuYWJsZV9zdXNwaHkoZHdjLCB0cnVlKTsNCj4gLQl9DQo+IC0NCj4gIAly
ZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA0MmY3NjUyZDNl
YjUyN2QwMzY2NWIwOWVkYWM0N2Y4NWZiNjAwOTI0DQo+IGNoYW5nZS1pZDogMjAyNDExMDItYW02
Mi1scG0tdXNiLWZpeC0zNDdkZDg2MTM1YzENCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gDQo+
IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiANCg0KVGhhbmtzIGZvciB0aGUg
Y2F0Y2ggYW5kIHF1aWNrIHR1cm5hcm91bmQhDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRo
aW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

