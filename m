Return-Path: <stable+bounces-166750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B5CB1CFF5
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 02:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F193BC33D
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 00:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BEF15573A;
	Thu,  7 Aug 2025 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ONO2kf76";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ALCB/Xd7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a9DDIhYE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C02E36E6;
	Thu,  7 Aug 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528250; cv=fail; b=aqtjtdZTv4xqjc65wPyvJ6pP1N/a8go7NpbDwbLAmu3PhW57ndM9/LnYIGWy6VCh8EeFj4NyCM8kPAQuwXSRGTJE3eypG6mcxVoZuXZBhgr8E33jYVN0LwB+yiAxAPVxOiB07YaLEJOltQ3o9sJb0uuklm6mwt06bJlczQLQjUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528250; c=relaxed/simple;
	bh=j23ex4Y8CmQAi24rllMY98oIqM36ooVudVbpmE2rlWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GvJwPNl15awcSyuv9NqpAs2naCvDW/DqjXS0drUCLmtuXkG6/MkWuT3J0XvYFjdJvdzfipxq3q2u2pJSFSELzmfn34B8l8lvBVBBWZgLNBuKkN0JE9gKs+ENO64PsX4P0tUhk3Sbvt3MY+tUHA/ax7oeiaIEN6gIgxOuURbChm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=unknown smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ONO2kf76; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ALCB/Xd7; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=a9DDIhYE reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576LblDI001041;
	Wed, 6 Aug 2025 17:56:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=j23ex4Y8CmQAi24rllMY98oIqM36ooVudVbpmE2rlWU=; b=
	ONO2kf76MrkcVhldtQWQfsXxIaZKpkxf+6u+C7nqLDgk5OcFW9DSk41nrMXeXsxq
	e6Za1Nt/KBBS2McNmonue1lqq61CV2MaEbCih2RQhtRLYKKW43HU3//WYWL/9iyK
	oP55E61QHCL149LywbNSJlw5kogXmNst2pKrMw6mxOesHDt8soDH1pNAdt2Kvv5o
	zKPSBKjYRX7RK9yC7pLYvhd/SeASMtBGlLnBRFAR69LgKepKNSY0Ua2qArkPTMaS
	c/WWYX2/ydMsMYp7UNHS3r/Ui36Vm4Acd2sykPPici/tdtcsiBuQZ0GGvxwAyxkV
	+bxW3cN62d8mvPhS+L9jOw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bq0rg4ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 17:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754528205; bh=j23ex4Y8CmQAi24rllMY98oIqM36ooVudVbpmE2rlWU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ALCB/Xd7JrPwjoI6/StH7ZfOrXpQKaapX2ECVo1LUFUHYopJ0Z02lGz8BnssTU7iS
	 cPGYRwqivEn5Dt59gpyoXm0VTOUuvuMK2fCRC5efancnXZOO1RKGtN+ZYE0jvHNUG7
	 xY3wk9N7Yw7oiEcaDjeStlSAxaUFt6yHBoa1Dxn4wVBgVuKBCuZRlxcMGv4d77ZEbx
	 IZDMfhfRI1ku4aO3XUi0l7wVBfHPHlDVbCTFY0OOLrIutLGzeeNnJdN25a5H/uW/J+
	 F+xE1HGVEXOcE9k8zyYmyNHtfgBTQj4A2zteRpZrE2oQnUpUJIrq4OhA76IzVGa0VM
	 3QdjUDcYt7FNg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 308E6403A2;
	Thu,  7 Aug 2025 00:56:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A49D3A00F5;
	Thu,  7 Aug 2025 00:56:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=a9DDIhYE;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 87DB440348;
	Thu,  7 Aug 2025 00:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buA6Vnp1J/pcsEzawwPwzMZdK3e5tbCrIQNfj6atgojQy5tgrvyRGHM8OMd89DnAw42oRgUoZgEjPhNWXccFVESh4Iwxqkya5BigDgOS5K8sunaIgiKUV2oiSLwPTZPYp4EgHkLJPnfNDVN3kDgyE7EQXCBklDKZyBLcqQ5cy53yX11wI9vML1D7zXBzacVBZQEreX27MMkwkSiEC6EKH0hQlg9yGjJXI1y082d+ifnqEaAyV5nuBmCPQY2r0KBgkJoQpiFd4VyMYZDUrd9oPLlo4dJZFkxq/ZgCln9RRprdCHCmgPFbxu17sE1PLzUxYdJKmc6nhXlCnrYL5haUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j23ex4Y8CmQAi24rllMY98oIqM36ooVudVbpmE2rlWU=;
 b=LQT/XnM9+3vuVEUQ1R2DqaE7rxZx41PqDyK8NBKz6N7R1dHgXl/PQUjq2iNarrXYQ+8q/b3BDv77C0thzq6JTEd8mdfRvj9+gzfGgSq1WgAUIs/qb2pwBf1La2xfcWwPOQaK7uziACQY5eZiPKLk8sAM1V4PWeNHPlKpeGtCQlgTdu7lb5dFC+7rNmuJrvtJZmHJQ1PnF7CIpt78blYM51JcahI6WLaoK9nj4tL0yzyJJ2RNBtY7s+XE/xpwAltcUAx4JFrNMWk+mG0J9EkD1fuoznlFf30olTvZ0f7AC4dTOnn4IadqX+MuDfARWh4HsjoZ5xWxCKSBadkKthTLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j23ex4Y8CmQAi24rllMY98oIqM36ooVudVbpmE2rlWU=;
 b=a9DDIhYE4xHMXqK8pxe/zxaoMwxqirTA7dZ0ghHJRYcpo2Pjfp3x8S4xo+fWwJxgs8QO7Sdi8jAP4Add8UdVi+uJbCFiErVkUYj0wO+vI52wZM/bBiGiplky+75xPcDrqZF0/y8XmTQR8NAyY5HVM1Ynncd5bvf2LzK3xjVNIzw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 00:56:39 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:56:39 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "balbi@ti.com" <balbi@ti.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Topic: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Index: AQHcBUtvKX8K+bPbv02NXD2kHFXWYLRUuYQAgABVbgCAAVK5AA==
Date: Thu, 7 Aug 2025 00:56:39 +0000
Message-ID: <20250807005638.thhsgjn73aaov2af@synopsys.com>
References:
 <CGME20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e@epcas5p3.samsung.com>
 <20250804142258.1577-1-selvarasu.g@samsung.com>
 <20250805233832.5jgtryppvw2xbthq@synopsys.com>
 <99fa41ed-dee0-499f-8827-67e1e1c70e60@samsung.com>
In-Reply-To: <99fa41ed-dee0-499f-8827-67e1e1c70e60@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB7007:EE_
x-ms-office365-filtering-correlation-id: 288291c8-ca0d-4cf9-a925-08ddd54d4474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1Ztak5QRVhuRnhKL1ArRVlZU09MbHJDWHFPemtQUTlxN21ZR2FmRmU1aEJw?=
 =?utf-8?B?WVh5WG1jR0V0MldzaVdxVi9HekdGanBkcHJzeU5zUXlQYnRwUHpDTUx5S1FE?=
 =?utf-8?B?SDFuMndHQXhLNmlIVHNmSERHU2N5eCtoZzBMMnFmVnZxbXVPQUc0a0NLUkZ2?=
 =?utf-8?B?S3V0d2Rsa2FqRzc2ZFlWOUZkdy8zdEhoMW43Y2c1ZTRpTzFWTUp5QjErSnVX?=
 =?utf-8?B?dDFSS0FlWWc5ZnZjekt5aXBRSkhVTzlCQjdBV00ydTl4Sm14enpqZkpaSHhQ?=
 =?utf-8?B?VHVCSXVVUFpYOWdTaDlxOVNPNGNsZnFXc0VxaDJGNHNISUNhTW9XUmxHa1lm?=
 =?utf-8?B?dlVYOXJkbDc2WmNwWHB5STVGSjk2bU9CV3J0NzNlZlRBTkJGWSsvK2cvQU9I?=
 =?utf-8?B?RHFpNjFYNThGWU16OHM2eHg2aWg4b01wZlBSajdKUkdVWDgxUjE1TERHZmtk?=
 =?utf-8?B?K2YrNE80OGI0dWxlcnhmVEliN2pOSjJ3dUsrVHJtSmx2M0hBdXM1Z2g4dko2?=
 =?utf-8?B?RFJzVFlmRlJBb0x1cjZVSGhEQzgrNjk3dWVySEtadVNmak13eDJEU2xHZUND?=
 =?utf-8?B?Z25wWHdQbzFmNVJuMGxOUnJJV1kway9DZDliMzVTeDNwOG44eVlES2hVQTY2?=
 =?utf-8?B?MFNKbEFrSFBLK21PU0dyMjFpQkgvWGJ4RC80Z0dkbWI3eFcxOFYrZTFoRHV5?=
 =?utf-8?B?aDJnQ282eUxiTnE4enRvcWN1ZUk4RHhTUVplOFp4WkJxaWlxYXVGbWUrRlpT?=
 =?utf-8?B?cDJmU0V3S25ESVlFVFhTNmVVSnU0ZWJtRldCNlFPN1E5VTR2MmMyL0E0Qlpa?=
 =?utf-8?B?L3lKTWo0VlE5bU1lMnAyaldMVUw3bENKVkNkVU5iTCtyQTRDZ0ltNk1tbnhR?=
 =?utf-8?B?ZE80dnhOZVdXREpDamtiQWI1ZnAwS3B6Q1dTL2k3LzIwVnFNRitrNzZJTS9l?=
 =?utf-8?B?a3VVcC9pM01lM1I2SXBJaEZ2bkZ0RWFyNVBkNkIwYm1ySGhtVWdRbHY3d1pa?=
 =?utf-8?B?U2tvL2NnREdnc0FBNFdsZWRlQkdQejNnalkvdnNQUTRlODJxWGZpMGlvZU5I?=
 =?utf-8?B?T2t2ckdPTzNJM1gvMjJ5K1hGTExrOEI0VnNmRFAyMm9RUEJIeEgxS0FRcncy?=
 =?utf-8?B?ZTF1Y3FibGl4MFdwQU14VmFPRkliR0FCSjVwUVJsUlMxNjNLVk9VVFp5SHRI?=
 =?utf-8?B?anZWYzJNUjZPemJsWnBpdWxKQ0xmVW0vcnVRQUp0ZlpLTlpjb1NrTnN3aTQ0?=
 =?utf-8?B?b0lmckpJMUxjYTJiTW5WZGNKZ1o1U3lYaVJLUGtmcmZBWmlBWTVZMHllNjBU?=
 =?utf-8?B?T1hPWWN2VVBINXU5ZWhTN1drTWI4SFpXSzJhSnM1TTQrWnhwUGhkelZLQklo?=
 =?utf-8?B?OEtaYm5kcjhickFWb3pucHBwcjVWaURaWWtsZ1FadVovMXFBOVFNaXVwNzNP?=
 =?utf-8?B?NG9PTSsvUGhmNkN6YU40c1cxVk90d1RDRnhudE9wbEczOFhuOTdReUljbzhH?=
 =?utf-8?B?UVVGRE5hOWpRSzh5cUxxNnE0cExuVzYvZDFNSXg4S1hQNWI4UGliWTdKcXhy?=
 =?utf-8?B?MGRyeWJ2aXNnMHUvZitnTXUzREp6TXVnTkZFcXJqbDhVWklFMWhydXAyNGlM?=
 =?utf-8?B?RG1lR3gyUm8xTmt2YmFOSzB1ZExhZktpYi9LaWQ1bGtOZE8zVktoNjhLSnNa?=
 =?utf-8?B?YWJWY0Ewb1RuVC9Wc3FvaGliUnlDckhmMFUvYkdJVktDWGcvL09xTkhrUzA3?=
 =?utf-8?B?OHNSRmlKZ21YcDA1ZStxYzBTU21GMDl2RGF2Yy9rNDA1Tm44M00xZkZWVGhG?=
 =?utf-8?B?Z1poZ2p1YzNXU0Z2M0daYTAzT2N3RXlpU3BVZVFBODI0WnRVeWpxQlF5Tmxh?=
 =?utf-8?B?azQ0ckEzcXFUbFdXL3c3dW1WYnp5Y2pYV2tPQ3lreU9zbTY2WjJ4ZSs1ZHJS?=
 =?utf-8?B?ZDh0aUF3UVVLNnRidHlCRUkreThta3I4U1pQQ1dFbmJFS3NubHl4bmZGK1I0?=
 =?utf-8?B?NndMeGkwbFdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1pCTmh1ZkloL3AvS1g2R3piSVdnSzBGWjRIQndqbVJWOTBaalUyUDEvaDhw?=
 =?utf-8?B?QVc2S1BobjVuUjYzV0xSbmxGUUo2cVNzWkFhWnh4aUxWSFU1V0dPcWwvNG1P?=
 =?utf-8?B?RlJxaUFITXJJeGxYK2tvWm94WDIxS0hpNjZZdFNvZUx5OC82Z2NvY2svdWxO?=
 =?utf-8?B?M0g0L0hnNGVrY1BWZGJBejQ0S0M5WXhMaDlPU3B3MTVtcVhNVUpHUmt6Q3FE?=
 =?utf-8?B?OWhJUEYycEZabEpVQ1NkMkdNd0NVZy9FclpIVzhxTDFxL2pVeFVxM0lycnhW?=
 =?utf-8?B?NXJ6NVNSN0Q1cDBJdXpVVEJLNVhoNTNnOVluQzlla2N2TGViN1czUDdGWkJn?=
 =?utf-8?B?YlhlTjhtSWJmQ202MHpsajVNUW5QWS9McTRvUkZNdGI5cHd3U1pWY3ZxaG4r?=
 =?utf-8?B?RitKZEhQZ2NmeXRJZXk2RC82VXhuQWdwTThkdXkvRVpQV3g2YlpCZzc4NFBY?=
 =?utf-8?B?MEJIZThva0dHRDcvYkdERmVScG56RHNaaVhUV09idU15d0Z0WDRyQlVGVEJW?=
 =?utf-8?B?cUswUEU1Rll5YVB0QkZaaXdWNHFUUFdhTE1uelp6dXl2ZXc3MitIakJaYzNq?=
 =?utf-8?B?aE0yVjgvRXdHcTBtM3NFQ0tYMFBQR2JtZDFUUmplT3FDNW45K054MkorbWpy?=
 =?utf-8?B?c2RqclpQSTdGalNsU2FnZExnVG45RTFBeUExNkFEU3Joc0U2TC8xTnQ2UHdr?=
 =?utf-8?B?b2RMTzFacTM0RFNEOFN4ekJJK3ZBUlRXVkkvMG5ha3hCd0x2dER3WVJTMThB?=
 =?utf-8?B?dmIzM3ViYmxHSUNialVETTlLMVFieE1NQ2NkVjMvS0ZmbGZTdlhSS05PSytq?=
 =?utf-8?B?RTVrNlBGRVJZNzBtVU53RUhWc25JTHhsOFlhN1l1TENqN2Y2UEdwVU9PMy8z?=
 =?utf-8?B?VEJtZ0M1dXkxd2F6MWpxUXNwaVBhVHRvMy9zR2k4L0lvTkRxSGZ3SmNUcmNN?=
 =?utf-8?B?cEp0TGRnRE9IZjhoTExrYWNqZG05alY2M3JWUjRpOUU1L0djNUJHQ1BzeC84?=
 =?utf-8?B?VFd3MDk2dkFmRk01cmhaaU5PMmIxYXVFR2Q3SWg5VEp1NU1GU2lrd1ErWU9C?=
 =?utf-8?B?TThrRkdOR2tVdGVHWDhQOTBnQXpmamtCM3pDejlsZXVBMUp1aWgrL1lsVjBp?=
 =?utf-8?B?aVR1UDVCTUxlSEhRend3OUZnczlKWmIyT3hXaEFKZTN3bzc4c1JXVGdBSk5p?=
 =?utf-8?B?cURoQlc0a3lnUzQvblRhYW43ZlFKdDRieXA2ZU8wVnB4bnlnSDJPNXRLSTFt?=
 =?utf-8?B?Y1JFRHJja0xjbFFRYk9HTGdtYXkzME9ZRG9BRG01TU91cjhkYkZGeERTSUQ5?=
 =?utf-8?B?SHFsdmRDM3N2Um5DNDQwNExJWWtBeXhZL2poWkhnb1phdDlUU1NZb001WEtj?=
 =?utf-8?B?aHNBbmUxVXdkdUFuL0JKTjEwMjkzcVA4WGpJckp5Y2xiRm5ObEtuWnhpZjFh?=
 =?utf-8?B?U1hmZUM3S05OSmhLWGphRUF1Q21RSFl5eFRpc3g5cDlwL0kyazQzcWJQaWUx?=
 =?utf-8?B?cXZGWFVmWHB2RzBUWUNPcUlCYmtCU25BeHZ4aGhvQkVSdHBvUUFlZWtKK0lP?=
 =?utf-8?B?cFNPNDVRbWV1emR4RFFBUG9NRGhVN2I3bm1lWU9mZmJhSzBYVGFKUlJ2Z1dE?=
 =?utf-8?B?Y2t0ZUJlaDRNMll3SDFORExJK0ZLTnlYWFdWNmN4QTVlYjlwZHVna2I2OTRq?=
 =?utf-8?B?cks5OHJPc3R1cmx6ZkFwL25iMEZ1ZUo5WDVhaDgvRTBoN2I4c1pFS0U2ZDJ3?=
 =?utf-8?B?dVdhSlBHeTJUcitPOHAwb3FnYzlsTDR1cVJNNks4V0hJUzh5cjVuQmM0S0JT?=
 =?utf-8?B?UUcvYkpBbWg0V2lIZnh6cHdCWGp6UFo0QmFxZXNqNllZeHRxYkZ0MTk5Tmdy?=
 =?utf-8?B?ZXdGeXFvRVZOdHJvWTN3a1hhM2QrTU1xVHAvdUxvbXlWVENORjU2MmJadS9s?=
 =?utf-8?B?ZmVXcngvbFkzNHNlT0lxcW14bUFBVGg0SEkyRVd0VW16SnZBZmVWUWh0S1RH?=
 =?utf-8?B?R0RUeEoyRDhGYjVHMGxreCtMOERtNUxHOXN0MGx1NHpOZm9QYUY5b0grWlgx?=
 =?utf-8?B?MFRMTDZXLzcyTlhBQ21TZ2hFRG5BMUJ2UHg4Ym45SW1nalpKS1FvYm9qcWxF?=
 =?utf-8?Q?m+aGJsLmgUaRk31hz7P3q6+He?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134F3C6DC4C7C3458A37ABFE7FA2F9A0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	89DaRBOA44Rr/8XaC88m7uVtsqEwR1q5Ktelx3gpUqk8tvldlUPN/b0s8xmhkZRPBdf20gx+zpCH6054pcBDxmhQFGPQQfjorryKVPrUS4TLf072iU6eOpJmgkx8LBemANovOh15rbNaLxbrOTZUBjXtJDy2o6F231+WdijIUuNfv6uu3UQm1YB1MYdYW0fXEOh/utqx8CkPJYKwV0DGdvFO6WRt9NdGeMMP7G6YO9TOCnfjW68xkU0VXS6FMV8Tg9T1LPdqgzT8RHIL0MqLigyAQ3LS6EU3S1bhc5pk1i0j/HF1JUM8bC6GH9gYXICTPj4ujXJ2wAX5Y1auj3VaEgd6BxTR70bsPUpoBs3iCt5x8A9ZmFTcm2d+Rhi03SZYo33hDNkcoKDYtaym/gT+iAzg97K5J+yfqn/Sh3hiYmR/nGa1c7FMiMO/c+X469g8oqS53KUANCQMY61OApdyKV+jQCTdTdvU6V9HDWloKMDdDOr2KtU+y7y2Sy77ob4azCx3cUz6jr2+nP/+qVDQY0z7A9LDioR4LtJWA6bi7rJVQ3yE7wS0+8/f/jwvi1bia/8YditOPFPTYID1G+mNHnr+Vy/cWaNWcBaSpYwbAOkkkCP+7i3P+OF5nVxlMrV5u7h5Fqy+pRZwfpSRCj5tJw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288291c8-ca0d-4cf9-a925-08ddd54d4474
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 00:56:39.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ABdnEexLswljloV/sfV6AyHWjJNvpbmfx3jHwOtz/Xmh79XfILx5Y/vaQkUohZ96wo5/HpfFLqqF1baoh4A6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
X-Proofpoint-GUID: IbH2uXghwWLKFbALswsDpaiuP0Ka4b5-
X-Proofpoint-ORIG-GUID: IbH2uXghwWLKFbALswsDpaiuP0Ka4b5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX5NM/hgl5lkEZ
 WqMLG0YX7bFd8eADS6mheDCTC/B23+9gUu/JPcxdn0pQpKPNrBaM8YhyFcAU5b5DAPqchzB0Zqx
 rBv6xfxSa0sJkTwvUGd/cvcJIHb7e2Mrb5rdbz+0SHGJeCNuWwRSyzfdFwguFWQEdlAyBMoANlj
 HHvUBTPNe5oCGaqKFZdSQ8MJa1nIforG6eBIF9+IwdFxkvZPWDJskIEwivhVvqQ+UWysYdiXQ7C
 X3FtcLG6pQAi9h3TZa3RJ2XaKx2JdhdX3UV58e2b6KtUlqrDV9dvAwGRxUuv4emusce7h8G+ITC
 jnJhcPknTCfr/ImYRc4By7ykOuslHF0u9kN+m3VJZ5IRPOBrQPkzkh28ioOJoNNcvTanXb5R4BI
 YOWET53x
X-Authority-Analysis: v=2.4 cv=H+nbw/Yi c=1 sm=1 tr=0 ts=6893f9ce cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=LMojhsUYs72GCQyYwD8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050127

T24gV2VkLCBBdWcgMDYsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OC82LzIwMjUgNTowOCBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIE1vbiwgQXVnIDA0
LCAyMDI1LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gRnJvbTogQWthc2ggTSA8YWth
c2gubTVAc2Ftc3VuZy5jb20+DQo+ID4+DQo+ID4+IFRoaXMgY29tbWl0IGFkZHJlc3NlcyBhIHJh
cmVseSBvYnNlcnZlZCBlbmRwb2ludCBjb21tYW5kIHRpbWVvdXQNCj4gPj4gd2hpY2ggY2F1c2Vz
IGtlcm5lbCBwYW5pYyBkdWUgdG8gd2FybiB3aGVuICdwYW5pY19vbl93YXJuJyBpcyBlbmFibGVk
DQo+ID4+IGFuZCB1bm5lY2Vzc2FyeSBjYWxsIHRyYWNlIHByaW50cyB3aGVuICdwYW5pY19vbl93
YXJuJyBpcyBkaXNhYmxlZC4NCj4gPj4gSXQgaXMgc2VlbiBkdXJpbmcgZmFzdCBzb2Z0d2FyZS1j
b250cm9sbGVkIGNvbm5lY3QvZGlzY29ubmVjdCB0ZXN0Y2FzZXMuDQo+ID4+IFRoZSBmb2xsb3dp
bmcgaXMgb25lIHN1Y2ggZW5kcG9pbnQgY29tbWFuZCB0aW1lb3V0IHRoYXQgd2Ugb2JzZXJ2ZWQ6
DQo+ID4+DQo+ID4+IDEuIENvbm5lY3QNCj4gPj4gICAgID09PT09PT0NCj4gPj4gLT5kd2MzX3Ro
cmVhZF9pbnRlcnJ1cHQNCj4gPj4gICAtPmR3YzNfZXAwX2ludGVycnVwdA0KPiA+PiAgICAtPmNv
bmZpZ2ZzX2NvbXBvc2l0ZV9zZXR1cA0KPiA+PiAgICAgLT5jb21wb3NpdGVfc2V0dXANCj4gPj4g
ICAgICAtPnVzYl9lcF9xdWV1ZQ0KPiA+PiAgICAgICAtPmR3YzNfZ2FkZ2V0X2VwMF9xdWV1ZQ0K
PiA+PiAgICAgICAgLT5fX2R3YzNfZ2FkZ2V0X2VwMF9xdWV1ZQ0KPiA+PiAgICAgICAgIC0+X19k
d2MzX2VwMF9kb19jb250cm9sX2RhdGENCj4gPj4gICAgICAgICAgLT5kd2MzX3NlbmRfZ2FkZ2V0
X2VwX2NtZA0KPiA+Pg0KPiA+PiAyLiBEaXNjb25uZWN0DQo+ID4+ICAgICA9PT09PT09PT09DQo+
ID4+IC0+ZHdjM190aHJlYWRfaW50ZXJydXB0DQo+ID4+ICAgLT5kd2MzX2dhZGdldF9kaXNjb25u
ZWN0X2ludGVycnVwdA0KPiA+PiAgICAtPmR3YzNfZXAwX3Jlc2V0X3N0YXRlDQo+ID4+ICAgICAt
PmR3YzNfZXAwX2VuZF9jb250cm9sX2RhdGENCj4gPj4gICAgICAtPmR3YzNfc2VuZF9nYWRnZXRf
ZXBfY21kDQo+ID4+DQo+ID4+IEluIHRoZSBpc3N1ZSBzY2VuYXJpbywgaW4gRXh5bm9zIHBsYXRm
b3Jtcywgd2Ugb2JzZXJ2ZWQgdGhhdCBjb250cm9sDQo+ID4+IHRyYW5zZmVycyBmb3IgdGhlIHBy
ZXZpb3VzIGNvbm5lY3QgaGF2ZSBub3QgeWV0IGJlZW4gY29tcGxldGVkIGFuZCBlbmQNCj4gPj4g
dHJhbnNmZXIgY29tbWFuZCBzZW50IGFzIGEgcGFydCBvZiB0aGUgZGlzY29ubmVjdCBzZXF1ZW5j
ZSBhbmQNCj4gPj4gcHJvY2Vzc2luZyBvZiBVU0JfRU5EUE9JTlRfSEFMVCBmZWF0dXJlIHJlcXVl
c3QgZnJvbSB0aGUgaG9zdCB0aW1lb3V0Lg0KPiA+PiBUaGlzIG1heWJlIGFuIGV4cGVjdGVkIHNj
ZW5hcmlvIHNpbmNlIHRoZSBjb250cm9sbGVyIGlzIHByb2Nlc3NpbmcgRVANCj4gPj4gY29tbWFu
ZHMgc2VudCBhcyBhIHBhcnQgb2YgdGhlIHByZXZpb3VzIGNvbm5lY3QuIEl0IG1heWJlIGJldHRl
ciB0bw0KPiA+PiByZW1vdmUgV0FSTl9PTiBpbiBhbGwgcGxhY2VzIHdoZXJlIGRldmljZSBlbmRw
b2ludCBjb21tYW5kcyBhcmUgc2VudCB0bw0KPiA+PiBhdm9pZCB1bm5lY2Vzc2FyeSBrZXJuZWwg
cGFuaWMgZHVlIHRvIHdhcm4uDQo+ID4+DQo+ID4+IEZpeGVzOiBlMTkyY2M3YjUyMzkgKCJ1c2I6
IGR3YzM6IGdhZGdldDogbW92ZSBjbWRfZW5kdHJhbnNmZXIgdG8gZXh0cmEgZnVuY3Rpb24iKQ0K
PiA+PiBGaXhlczogNzIyNDZkYTQwZjM3ICgidXNiOiBJbnRyb2R1Y2UgRGVzaWduV2FyZSBVU0Iz
IERSRCBEcml2ZXIiKQ0KPiA+PiBGaXhlczogYzdmY2RlYjI2MjdjICgidXNiOiBkd2MzOiBlcDA6
IHNpbXBsaWZ5IEVQMCBzdGF0ZSBtYWNoaW5lIikNCj4gPj4gRml4ZXM6IGYwZjJiMmEyZGI4NSAo
InVzYjogZHdjMzogZXAwOiBwdXNoIGVwMHN0YXRlIGludG8geGZlcm5vdHJlYWR5IHByb2Nlc3Np
bmciKQ0KPiA+PiBGaXhlczogMmUzZGIwNjQ4NTVhICgidXNiOiBkd2MzOiBlcDA6IGRyb3AgWGZl
ck5vdFJlYWR5KERBVEEpIHN1cHBvcnQiKQ0KPiA+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIGZpeCBwYXRjaC4gWW91J3JlIGp1c3QgcmVw
bGFjaW5nIFdBUk4qIHdpdGgNCj4gPiBkZXZfd2Fybiogd2l0aG91dCBkb2luZyBhbnkgcmVjb3Zl
cnkuIExldCdzIHJlbW92ZSB0aGUgRml4ZXMgYW5kIHRhYmxlDQo+ID4gdGFnLiBBbHNvLCBjYW4g
d2UgcmVwbGFjZSBkZXZfd2Fybiogd2l0aCBkZXZfZXJyKiBiZWNhdXNlIHRoZXNlIGFyZQ0KPiA+
IGNyaXRpY2FsIGVycm9ycyB0aGF0IG1heSBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gYSBiYWQgc3Rh
dGUuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCj4gDQo+IA0KPiBIaSBUaGluaCwNCj4g
DQo+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQo+IFllYWggd2UgYWdyZWUuIFRo
aXMgaXMgbm90IGEgZml4IHBhdGNoLiBTdXJlIHdlIHdpbGwgdXBkYXRlIG5ldyBwYXRjaHNldCAN
Cj4gd2l0aCByZXBsYWNlIGRldl93YXJuKiB3aXRoIGRldl9lcnIqLg0KPiANCj4gQXMgZm9yIGRy
b3BwaW5nIHRoZSBzdGFibGUgdGFnLMKgIEl0IHdvdWxkIGJlIGJldHRlciB0aGVzZSBjaGFuZ2Vz
IHRvIGJlIA0KPiBhcHBsaWVkIGFjcm9zcyBhbGwgc3RhYmxlIGtlcm5lbHMsIHNvIHNoYWxsIHdl
IGtlZXAgc3RhYmxlIHRhZyBpbiBwbGFjZT8NCj4gDQoNClRoYXQncyBmaW5lIHdpdGggbWUuDQoN
CkJSLA0KVGhpbmg=

