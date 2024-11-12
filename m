Return-Path: <stable+bounces-92847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7AE9C6583
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F18B35BDB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFD21A4D3;
	Tue, 12 Nov 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nf0MLTOt";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NdhOae50";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bysnHf4w"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E71FEFD9;
	Tue, 12 Nov 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449578; cv=fail; b=NwBY1KVaVW4kjUpHh0hL0EhVUz4gTwC4nOykBDmsQ66pf8Lr6Tsjy4JTRgkkk78aKiPmIX1Tf83jTxss6owibHEL9W5AsQ/TQcxTREqXUn6gvBkp7/Fjn3uad0TwmEMr8oiwaHWdntrVYZoKtFM7+kRaj7KRSzihIFY9kjY/VaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449578; c=relaxed/simple;
	bh=gsLdS7/fWSxL3qJo/imZZwFTVAUahdJhx29bPfSMcc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YlcnJjvFhqdj5TNs7aroWr3zNVcsGz8f1+ssfwxAt9NiVw5Z2IQ3zLv00y6aadGt6YcVdcuwC6ayPCZ9xDR6mJTXcBUm0yBh5oCG6+7+h0Y7y0D/BP9PaX6Me4YWqXtfxGLB4jM35K3+3msbPBovAk4iwRwaXu6bvTKYkTnXMUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nf0MLTOt; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NdhOae50; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bysnHf4w reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJsFk9028479;
	Tue, 12 Nov 2024 14:12:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=gsLdS7/fWSxL3qJo/imZZwFTVAUahdJhx29bPfSMcc8=; b=
	nf0MLTOtSRhkWISGSKdncB4LkD/TnwvI7l6yoqmiXfm+M6l1cWAFjU43EmMwR9uP
	bsJoBIk9zcoT1FREQhLWbNt7obicOj/oRabKmOklF0Xbz56+g9288Puv63/dFH+i
	bjy/O29NaZUfKZVSDtRSz4Qfe7M0aTE53z4cQU5VnHXUP/KhWHNXdhWfM7qbYqbP
	7VeJQzpkapHNrMMgFNPseM+gXBigGadEO3o27vgjpqPxTu+aTOkhnWk19ocFSdI8
	UYQb9OOITDY9s/rEJGbn2bclmop2bUcQx3usUuvDMeEZmJgiwq9y0qXxMMye4WuF
	td2DzQpknhWDKRRnlEEvbQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42tsguftdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 14:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731449566; bh=gsLdS7/fWSxL3qJo/imZZwFTVAUahdJhx29bPfSMcc8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NdhOae50Y7VTnvhA25hCgSz0cYGbn7lMh946EuAjOe4mY010jf9L1sPB8Mi/45WA8
	 oNpKg56JyxT5scO3RFh7Qpd9XDP03jzPZRJPVJRDrIBBBlZOilVoK0wGAvvF7aWCnJ
	 VMKs0ZiF8WLLYCl+gLu3Dc/CZaFtbgXkMCF1mL6uM+cIauoWq8B4llcMbY9gjktRyC
	 6p5ftbrfB0f5fM4eumcv877Cf3NsTL6Lh2Ba88DWDFdqdVIx6xIMYdyGDxkXDshazm
	 ciuWPLL8vVJkWa1klMllin3RMr1RnmeLgl4aVrSeQSxaD9xcNuAVBkhQHEAQRRR4pX
	 NkdUJKud6zcIw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F3C2D4024D;
	Tue, 12 Nov 2024 22:12:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ED348A007F;
	Tue, 12 Nov 2024 22:12:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=bysnHf4w;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CEE49401E9;
	Tue, 12 Nov 2024 22:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql0E9OQs6NtpheLspxEp0CN5vWAZy7NJaGrkK9yANPrvMS4H5Zr5DRVYAW1DXkDAwiCCMZM6ulH9LG09VCQh5GDGbYVB4zoS+VY1zfHCEzPh3eVR8qsLSQWrhM7zrHQd8PJWcwjGIGPRCPdaA+lm8TsD1hutGFDKvBgyIp5KFWkFxrzAu+UcIZIC5yMQu8SXg3K9Be+mqbO7JKO6Y+WTYgMCfTWj9boIHVR0AohnYTbpQSh2WeRjw4tevK8n3IDVo6ZHBDEUYDkMHRUbvxfucuWWmnB329axQefha7oayxsxZtGgrqlwJd+iT4tIjCRK3iw+2q8G2WaXQi6CNMHHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsLdS7/fWSxL3qJo/imZZwFTVAUahdJhx29bPfSMcc8=;
 b=ggZrUJ3kpSDq5XJ+YIrVo8gtdFt6kapp0BTx3aOKpindpnYJcmIZtVd77ygeD8CWWbonfvLtgL+ahjd3aTke/RX5gjKGSAF9npQXj7C+KMpv+JuTgVziGuw+8QRApxQfn+jv5WdobD5auAlfOt8iqIeJxGzKjrptsHqqnb+OqBTtXf9eyK3wvQlyBg4C4z8apkxL+BLhLShSPLia55HFYJ0DEkSgS0aE5sY+P3WcCuDzKA3Tkbw+zpi5EuQPjAD8PcBZL4B/yxe7JaLaJTNfDlKPLEl8rz9n2JOeS0ZzrM3IsNxQHAMdflH1kDCOwYEjx4/xD+917OnlaC41RtOKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsLdS7/fWSxL3qJo/imZZwFTVAUahdJhx29bPfSMcc8=;
 b=bysnHf4wMbUCyeSUXrYdtdevSkPlI9dtHlYicuYcOPB9qIjiAh7WqfG8EFo9UXb5ifeVgj88e7j396nZP2+Vsu+iJaTBxWlGkIbyUj1X3i9Kp6rbgc4e0Juw79GCBV1KiFskxYdPlhLhY+je9FAU0pg+CSDzDNcSqCUUQxte2HI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 22:12:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 22:12:39 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Add missing check for single port
 RAM in TxFIFO resizing logic
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Add missing check for single port
 RAM in TxFIFO resizing logic
Thread-Index: AQHbNL5CIT7j/Y5vjkaFNM7gxv1xq7K0NngA
Date: Tue, 12 Nov 2024 22:12:39 +0000
Message-ID: <20241112221236.eimtagr6p35vlo46@synopsys.com>
References:
 <CGME20241112044918epcas5p448b475256fc5232bcb34b67f564088b9@epcas5p4.samsung.com>
 <20241112044807.623-1-selvarasu.g@samsung.com>
In-Reply-To: <20241112044807.623-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB8603:EE_
x-ms-office365-filtering-correlation-id: 028b16a2-1185-4477-5c82-08dd03671eed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkVVNUs0UjU1NWhGZGF3Y2IvcVBXMjY2R1pHQVgzQ2I1QWdNc0RjTTdabkVm?=
 =?utf-8?B?WUhvVE0rVUliNUd1Sk5oTDFsQ0dJMFdjak0rZnU4OFFZb0NuR3hrNkRIM0k5?=
 =?utf-8?B?U3lwNVJKOExMeEVJQTdFQW9WaUJkQ3gzQXJKOFZ4MFF6RjZQY0hOdlE0UjFj?=
 =?utf-8?B?QXdsWXJ1TElqblZabUF3TldETDdaMEQ1K1FzZVUwSmJrVlZ6dmNOWU9iTUd6?=
 =?utf-8?B?cTlNcTRDMVJLaG5IRGRPSkNaU0xZR28yV3pUQXpMZTdsTjdHNUlhSlY1VGg5?=
 =?utf-8?B?WlVLZG9GUGhqMTNTNDMvaXJDMkR5TnplazBpMjlmYzFVeXo5YnJRckJEQTNK?=
 =?utf-8?B?K2llM2lxL09KL0Qxdmd5eUxRTWt4NWlBMG5GNVNwM0hFMjBqME1qcy93Mkh6?=
 =?utf-8?B?eUZQeHRIeVY2dTEwQ0pILzBiaCswWVhxNUtTbWNQMm1uWklleHlJTXpFaytF?=
 =?utf-8?B?UUdleHRRNHBqWE1qWmR1Rm1xMFRYNmxFMDBnd1FPc0dKckU1cnRTZDVibUFz?=
 =?utf-8?B?dkVoaXpvZmxJRS9iZ0JYNEhscXVVZTNvYVFzK2ZjemZQRkFVc2QvdDhMN0pY?=
 =?utf-8?B?TDlKRDlJR3VaS2hWZzFLemo1aTkwcEl2OW41M2ptQW5ua3hLNUJ0THlQZDRX?=
 =?utf-8?B?OWhwTVlUUUs2U201c1A0TnloWHhESEtmNWJZcXE0TDc2OTdwZlRXRS8wdEdB?=
 =?utf-8?B?N0xJSCt0aE1IaWlBN2NzZGMxNy9hUG0rRXJzbVhPSDJPR0U4Vk5rM3BnVEFn?=
 =?utf-8?B?M2ZuZWlwWjlWVHFseE0xYmowbUVMYUVRTzR3UUNxSnlUeEc5WEpKNHFHT3VQ?=
 =?utf-8?B?L3k2V3gyamo0b3FBeUd5dkRpamI4OFlBTzlvV0ZQb3RTUXVubksxR2FXRzNK?=
 =?utf-8?B?QllydGt1bGZSemN4YUcrVWdnbFBjZjdQUmkrNmV0Y09zS2JsUmh3ejhoZmUz?=
 =?utf-8?B?SHNvZFZabnc1aUJnZDA0Q1ZCRlN4b0VkUTVoY1hxVy96b0czY0hRLzNKMDVi?=
 =?utf-8?B?eFFMOUptUnJqaFZ0dzlQbVR6d2M0ZHo1RGgzNUVpakhHZFRkcm1zeWl3VlZk?=
 =?utf-8?B?a3YrbDhJcU0yZXNNYmt6dytWS3BPc2t4dVNCZ2dwUGthbWNsOG1EMlpGWG5i?=
 =?utf-8?B?MWRDOUUzNWlHQk0xUVFrSGY2bFhMN0k4QVBGUGtTdXgwRldtOVJGOVpXVHlS?=
 =?utf-8?B?U1FDT1V3Z3lOS2NVRDRTelNiNzIyYXNic0l5elBzY2tkZEdoaDh6U0g5b1JS?=
 =?utf-8?B?TTR0VlRrdVFyRWJFcnZTK1RITnp3aXA4QmM4TjNDZEtzNGh0WmlXTS9BNERC?=
 =?utf-8?B?b05tQzEyakxpbjI0NkdNSCtzc3h5M2haQUNsTTIwVE9CQzI3R3IzUUw1Ky9L?=
 =?utf-8?B?YXpMYWtOME1TcDlvdHZpVjk2MC9oTHh1SUpaSFJ5VE4ybDU2UUh3VWFlak4w?=
 =?utf-8?B?dGpSVVNJL0Rkd3dOejBVWGZVUTIvRGFKa0ZoWXN5ZFQ5VzMzVHRwMzYwYmVS?=
 =?utf-8?B?TjRwWitVUHdOS1AyL2tNQzdsV1pYaGRUV0xPZjE5NEVtMGU4c21pVTQyZ1FZ?=
 =?utf-8?B?bEx2WUY4SjBRS1VFTDZIVlU3cm04TlNERHh1UmtLQmgrS3UzUHgyaTB1MVFx?=
 =?utf-8?B?ZnF2MEJ6ODNoNWE4V3BieHNYY05YbVdYOGhzM1NTbzhuN1VEelg3cEdDSTVY?=
 =?utf-8?B?YzJ6ZERHUDVIRWNCdlBWVmNsZU1pUXNUOXdzUXNTMjR1ZTlGQUYwMVh5WVBJ?=
 =?utf-8?B?cU5CcXpaV1B0ZkxHQllGRngxenhtRWJYVkUxTklSa2tRWnVoNzRLMjF3N2RY?=
 =?utf-8?Q?Fs9TFglLfFBfotOtfTUQcyPqx/hDMV/pYpu4o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWdDcU9BMUpFbG1scFg2ZXFnSXMyc0ZiZHhubGtXTUdIRytVTndjWWdRdDhW?=
 =?utf-8?B?QXdmWU5JZ09KTWY4eW1yQkh2L1ZjVDlMU2h2Y2NXMmx0ZzBUdUVZdkpObVhZ?=
 =?utf-8?B?SlVSeDlsVy9kOWJxWHdSK1hGRVNzZHE2RTBjRVJPV3p5K20zMkhjb3JESTdH?=
 =?utf-8?B?WnFjaUNVTE1NUUdtTWY2T09BaUwrcjc4bVZRQjBmY1d2UkJ3MUczZk1RTVRn?=
 =?utf-8?B?QW9yaWVQZUpLVDAzc3ZQSVdiZkFsOWh3RGU5STgvMkNrUHkySmZwcC9Uc3Vi?=
 =?utf-8?B?WjNEVVZoWHRzdkVlb3I5OEhYcmpXbmpMdlp6Z3MzZGdaL0YrQWFCQWdsbkdL?=
 =?utf-8?B?czNrNWYwUy9Ld3dtSjErMm5xL0NReDR5dFY3WnUxWlBMeEJJN3Qrd1ZjTnpG?=
 =?utf-8?B?RWFWZy9RL0E4VGdNWFFDTW9tUXlTVGpmRklWU2QyQmpyMWlGaWh0MlNHVFU5?=
 =?utf-8?B?eXNpU2RRQm80d00zckgrMGU5T3R2QW1FL0NBdkJXeis2NU50a055M1VjMFJI?=
 =?utf-8?B?UzhkL25kWFZWY25yam5ITjBPUFgrWlZrbmtHdmIrbUNNaEIyYkxRK3ZocU1h?=
 =?utf-8?B?akd4dDV6U1JyMEZjRXlHeFZXVG1EU3Z2Yk84aEZNd2VVaERWSXowYS9tQy9w?=
 =?utf-8?B?eUVPbDdwL1BlbmVVeWY0cXZPVi9ST3NOckdGMUNnNlFXS2ZlWERSWEpkZUg3?=
 =?utf-8?B?S1gydXZTT1lnK0srYjFRMmdCOUxaUGVtSEFNbGVkQlNJeWdmeTFsQzYyRDJ0?=
 =?utf-8?B?d215a0pZUGU4RjQyc2l1L2FEYWh0R0F6RS9UVmhjVjlKeU45RlpnM0V0MHR0?=
 =?utf-8?B?VzAwRmhvekFpaHVnY0tsdjlsenRvYzdpR0U3QW9oNjFlaWF1cHo4U0R1a2xo?=
 =?utf-8?B?RU84Qk4wN3RLY3FLVWc0emFHcjNJeTRFQ1J0RWFPK3pObmx6RSswdUI4cU5p?=
 =?utf-8?B?VzVYTVozbjNQaHVHRHA4YkNWbG0xSkRjVXJIOVUzR29uNlZvdGYyeFRRZ0ZX?=
 =?utf-8?B?UlpvWkxhZGVpY3c2SFVOOHFGbnZHTFBwQXo2Y1UzeUdVQzJJRGhRWC92QkQr?=
 =?utf-8?B?cnlqemZoeHB6WkxnMzZmaUN2SlJDdzlwL0h4V2NwL1l1eE92SEU0QkNYQVI5?=
 =?utf-8?B?bUw4OUJsVG1nWWdCN0trMGl5N3IvUGNwUXNJMEROcUl3cWlLRmpPcEhaVEI4?=
 =?utf-8?B?THlRUHZnanBvdldnOUhiM0ZLeXc0WnVCMVJidjh4cElmcVJuRVZTMk8xelBF?=
 =?utf-8?B?YUpPYm5vME1hVHlWczZNUm5lTEd6ZHVpNGFNYWtHY2ZZUmVmcU8xeHZybFpy?=
 =?utf-8?B?KzRUQXZ3MllEYUQrYjdVMlFIVGppdS9tb0p0TU5KVFRZSUcxNEFScVlDNzFk?=
 =?utf-8?B?SkV2Vjh1bnJIWCs5MXlYaUdhdUpUbzI3R3Z3ay9LWmZrSHpoellqTWExOVlD?=
 =?utf-8?B?bFpQYStpU2hjSjJVUUk3NnZqOG9HUFdETUdtLzhuNVRVNzB1clVDeFJHcHFP?=
 =?utf-8?B?TE9jS2hLYmpWVm1PNE1jUVlPT2FLMFdGOTlEWmlrL1pNY0h0dVE1YkQ4UGFC?=
 =?utf-8?B?SXdhd3Nna0JHaFgyeXVuVXNGelFTUmQ2d3F0NG9XWnpUSHpnY1hmU3Q4UDk0?=
 =?utf-8?B?dWpHZkZqNFlWRDBmNDhZMHdxZlJQSG5NUGUzZi9tcDJvNXczY1B4NFNtbEp2?=
 =?utf-8?B?ODQ2K3JpMHg4MUpuM2VJblpIeTJBcnkyOHpVU0E1Y3lndjVydGYvQ2VtWmtn?=
 =?utf-8?B?encyTTd3Ky9XaThSYWJHZ3B0cUpjV2xrZXg5U2hHODFuVndOckNPN09IQnhC?=
 =?utf-8?B?SXNCM0M4TWs0V0dhN0QxUVh3bGp4cThMalVIRGh5ZVV0UUNWVjd3aytDdXNx?=
 =?utf-8?B?TEJ0RDBKYXhCMzc4WUJLY2tSc3kyeFdOK3hFS1JZbWdaWEEvZ2tGNm1ZclJy?=
 =?utf-8?B?Y1FqNnQzTlU1YnFVK05xelFKZVdzVVM0MUFqbG1qbit5YWwrUDV6dndheWFH?=
 =?utf-8?B?U0xuU3R5SzlScWNIUFBwOXpSa0tZdWNjV3VQM3BsME41UnJKaWxMbXZmdGE2?=
 =?utf-8?B?bVZndGVaVVRBS01qVGZZK3VNUGNPazhYeWNST2hHN1pZV0pmQVBrUzlLSnZI?=
 =?utf-8?Q?y/s0wUItO+rVyRG46qVUBfKnz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16CC1976F9F5164ABEC160BA2EF53535@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bBTcwMBaKy4JrtwbLXo1fDWIpRwufj6UWlvgkb82AXfdkodd0TRhVFSl0Yca8LIH8bRYr6QDSJ6d4QIBY9/jbILGeE+aVWPJWtRVdhOr8VdplDuJjG7NQsDUoY4ceUQNFnbExofXH4WO1Lt5KWykNVWK3W6bjErGg7BYFbkgNq7ls5gytjaqouZR4AYYr/0UMnrmPBMaSgIiv6Qm0rha1dX9lD0qE5oTca6FkSCs/TGM0N2hC4jx7Al4f2BmM7JZBDPWUPSbvQBuGfT0rSXZaytpap7XFumPHB3BI5xT75e+ZCYewZ+g0K5V6HG6LHvi4Amb5KJ2/Et3ZqTyWvy79NYgDJwA8y4TIxZv6MSE2kQT07yIsyQWpDJ88vQd17XA7zQwZza8OJ3fx1X9iTo1faJ0POH7aHsrI/O8XzF2gUGDbiSOZPp5yzCo9XFCfEoqA9TvJDoToHoiOMlcyZ4T5L8wnbFMREjxyZgHq848OXklJOl4WXsf+QbDuxNw8MiPBZ2VJyvxw1cCt1vEST+GDccPIb40hoCoId/g7xV374+aNi6FmE0zPU/caJtQqA1rwK/CrcQefB298Z/tqzpekkvNsY9TxGm6nrzk1l/GI6phVTDHZsoS7KnIm1AVg0kmWy5dRwrK1mkJd/NmwJ4Sew==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028b16a2-1185-4477-5c82-08dd03671eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 22:12:39.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQ8xbOMde18ptjLjTA1FpFKOvrmBpacqbdgXx+PaHpH16Y9KlmrNHaIE2M6Py74h7iqZQO/1h2+79ANzGCCwOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
X-Proofpoint-ORIG-GUID: qGoTRDnDm5-xyiClrEJLTDSv7X6d0gd8
X-Proofpoint-GUID: qGoTRDnDm5-xyiClrEJLTDSv7X6d0gd8
X-Authority-Analysis: v=2.4 cv=HbBGTTE8 c=1 sm=1 tr=0 ts=6733d2df cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=es7jtOQpjM_ZVYCrN4wA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120177

T24gVHVlLCBOb3YgMTIsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGUgZXhp
c3RpbmcgaW1wbGVtZW50YXRpb24gb2YgdGhlIFR4RklGTyByZXNpemluZyBsb2dpYyBvbmx5IHN1
cHBvcnRzDQo+IHNjZW5hcmlvcyB3aGVyZSBtb3JlIHRoYW4gb25lIHBvcnQgUkFNIGlzIHVzZWQu
IEhvd2V2ZXIsIHRoZXJlIGlzIGEgbmVlZA0KPiB0byByZXNpemUgdGhlIFR4RklGTyBpbiBVU0Iy
LjAtb25seSBtb2RlIHdoZXJlIG9ubHkgYSBzaW5nbGUgcG9ydCBSQU0gaXMNCj4gYXZhaWxhYmxl
LiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIHRoZSBuZWNlc3NhcnkgY2hhbmdlcyB0byBzdXBwb3J0
DQo+IFR4RklGTyByZXNpemluZyBpbiBzdWNoIHNjZW5hcmlvcyBieSBhZGRpbmcgYSBtaXNzaW5n
IGNoZWNrIGZvciBzaW5nbGUNCj4gcG9ydCBSQU0uDQo+IA0KPiBUaGlzIGZpeCBhZGRyZXNzZXMg
Y2VydGFpbiBwbGF0Zm9ybSBjb25maWd1cmF0aW9ucyB3aGVyZSB0aGUgZXhpc3RpbmcNCj4gVHhG
SUZPIHJlc2l6aW5nIGxvZ2ljIGRvZXMgbm90IHdvcmsgcHJvcGVybHkgZHVlIHRvIHRoZSBhYnNl
bmNlIG9mDQo+IHN1cHBvcnQgZm9yIHNpbmdsZSBwb3J0IFJBTS4gQnkgYWRkaW5nIHRoaXMgbWlz
c2luZyBjaGVjaywgd2UgZW5zdXJlDQo+IHRoYXQgdGhlIFR4RklGTyByZXNpemluZyBsb2dpYyB3
b3JrcyBjb3JyZWN0bHkgaW4gYWxsIHNjZW5hcmlvcywNCj4gaW5jbHVkaW5nIHRob3NlIHdpdGgg
YSBzaW5nbGUgcG9ydCBSQU0uDQo+IA0KPiBGaXhlczogOWY2MDdhMzA5ZmJlICgidXNiOiBkd2Mz
OiBSZXNpemUgVFggRklGT3MgdG8gbWVldCBFUCBidXJzdGluZyByZXF1aXJlbWVudHMiKQ0KPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMTIueDogZmFkMTZjODI6IHVzYjogZHdjMzog
Z2FkZ2V0OiBSZWZpbmUgdGhlIGxvZ2ljIGZvciByZXNpemluZyBUeCBGSUZPcw0KPiBTaWduZWQt
b2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IC0t
LQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gIC0gVXBkYXRlZCB0aGUgJHN1YmplY3QgYW5kIGNv
bW1pdCBtZXNzYWdlLg0KPiAgLSBBZGRlZCBGaXhlcyB0YWcsIGFuZCBhZGRyZXNzZWQgc29tZSBt
aW5vciBjb21tZW50cyBmcm9tIHJldmlld2VyIC4NCj4gIC0gTGluayB0byB2MjogaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI0
MTExMTE0MjA0OS42MDQtMS1zZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbS9fXzshIUE0RjJSOUdfcGch
YzFiODRUYWFMTVplVkpKV3R2Sm9mSXNHcGJtTmRxLVlRcU0yWkk5UmE4V2tLenUxYWRJNHlweWxk
Z3hYMzNDcHZGMUFPb2NDOWJUTkFGVXJWQTQzWGdqS043WSQgDQo+IA0KPiBDaGFuZ2VzIGluIHYy
Og0KPiDCoC0gUmVtb3ZlZCB0aGUgY29kZSBjaGFuZ2UgdGhhdCBsaW1pdHMgdGhlIG51bWJlciBv
ZiBGSUZPcyBmb3IgYnVsayBFUCwNCj4gICAgYXMgcGxhbiB0byBhZGRyZXNzIHRoaXMgaXNzdWUg
aW4gYSBzZXBhcmF0ZSBwYXRjaC4NCj4gIC0gUmVuYW1lZCB0aGUgdmFyaWFibGUgc3ByYW1fdHlw
ZSB0byBpc19zaW5nbGVfcG9ydF9yYW0gZm9yIGJldHRlcg0KPiAgICB1bmRlcnN0YW5kaW5nLg0K
PiAgLSBMaW5rIHRvIHYxOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDI0MTEwNzEwNDA0MC41MDItMS1zZWx2YXJhc3UuZ0BzYW1zdW5n
LmNvbS9fXzshIUE0RjJSOUdfcGchYzFiODRUYWFMTVplVkpKV3R2Sm9mSXNHcGJtTmRxLVlRcU0y
Wkk5UmE4V2tLenUxYWRJNHlweWxkZ3hYMzNDcHZGMUFPb2NDOWJUTkFGVXJWQTQzczNOZ1FxYyQg
DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICB8ICA0ICsrKw0KPiAgZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggZWFhNTVjMGNmNjJmLi44MzA2YjM5ZTVjNjQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5oDQo+IEBAIC05MTUsNiArOTE1LDcgQEAgc3RydWN0IGR3YzNfaHdwYXJhbXMg
ew0KPiAgI2RlZmluZSBEV0MzX01PREUobikJCSgobikgJiAweDcpDQo+ICANCj4gIC8qIEhXUEFS
QU1TMSAqLw0KPiArI2RlZmluZSBEV0MzX1NQUkFNX1RZUEUobikJKCgobikgPj4gMjMpICYgMSkN
Cj4gICNkZWZpbmUgRFdDM19OVU1fSU5UKG4pCQkoKChuKSAmICgweDNmIDw8IDE1KSkgPj4gMTUp
DQo+ICANCj4gIC8qIEhXUEFSQU1TMyAqLw0KPiBAQCAtOTI1LDYgKzkyNiw5IEBAIHN0cnVjdCBk
d2MzX2h3cGFyYW1zIHsNCj4gICNkZWZpbmUgRFdDM19OVU1fSU5fRVBTKHApCSgoKHApLT5od3Bh
cmFtczMgJgkJXA0KPiAgCQkJKERXQzNfTlVNX0lOX0VQU19NQVNLKSkgPj4gMTgpDQo+ICANCj4g
Ky8qIEhXUEFSQU1TNiAqLw0KPiArI2RlZmluZSBEV0MzX1JBTTBfREVQVEgobikJKCgobikgJiAo
MHhmZmZmMDAwMCkpID4+IDE2KQ0KPiArDQo+ICAvKiBIV1BBUkFNUzcgKi8NCj4gICNkZWZpbmUg
RFdDM19SQU0xX0RFUFRIKG4pCSgobikgJiAweGZmZmYpDQo+ICANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGlu
ZGV4IDJmZWQyYWEwMTQwNy4uNjEwMWU1NDY3YjA4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAg
LTY4Nyw2ICs2ODcsNDQgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9jYWxjX3R4X2ZpZm9fc2l6
ZShzdHJ1Y3QgZHdjMyAqZHdjLCBpbnQgbXVsdCkNCj4gIAlyZXR1cm4gZmlmb19zaXplOw0KPiAg
fQ0KPiAgDQo+ICsvKioNCj4gKyAqIGR3YzNfZ2FkZ2V0X2NhbGNfcmFtX2RlcHRoIC0gY2FsY3Vs
YXRlcyB0aGUgcmFtIGRlcHRoIGZvciB0eGZpZm8NCj4gKyAqIEBkd2M6IHBvaW50ZXIgdG8gdGhl
IERXQzMgY29udGV4dA0KPiArICovDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2NhbGNfcmFt
X2RlcHRoKHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJaW50IHJhbV9kZXB0aDsNCj4gKwlp
bnQgZmlmb18wX3N0YXJ0Ow0KPiArCWJvb2wgaXNfc2luZ2xlX3BvcnRfcmFtOw0KPiArDQo+ICsJ
LyogQ2hlY2sgc3VwcG9ydGluZyBSQU0gdHlwZSBieSBIVyAqLw0KPiArCWlzX3NpbmdsZV9wb3J0
X3JhbSA9IERXQzNfU1BSQU1fVFlQRShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMSk7DQo+ICsNCj4g
KwkvKg0KPiArCSAqIElmIGEgc2luZ2xlIHBvcnQgUkFNIGlzIHV0aWxpemVkLCB0aGVuIGFsbG9j
YXRlIFR4RklGT3MgZnJvbQ0KPiArCSAqIFJBTTAuIG90aGVyd2lzZSwgYWxsb2NhdGUgdGhlbSBm
cm9tIFJBTTEuDQo+ICsJICovDQo+ICsJcmFtX2RlcHRoID0gaXNfc2luZ2xlX3BvcnRfcmFtID8g
RFdDM19SQU0wX0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM2KSA6DQo+ICsJCQlEV0MzX1JB
TTFfREVQVEgoZHdjLT5od3BhcmFtcy5od3BhcmFtczcpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBJ
biBhIHNpbmdsZSBwb3J0IFJBTSBjb25maWd1cmF0aW9uLCB0aGUgYXZhaWxhYmxlIFJBTSBpcyBz
aGFyZWQNCj4gKwkgKiBiZXR3ZWVuIHRoZSBSWCBhbmQgVFggRklGT3MuIFRoaXMgbWVhbnMgdGhh
dCB0aGUgdHhmaWZvIGNhbiBiZWdpbg0KPiArCSAqIGF0IGEgbm9uLXplcm8gYWRkcmVzcy4NCj4g
KwkgKi8NCj4gKwlpZiAoaXNfc2luZ2xlX3BvcnRfcmFtKSB7DQo+ICsJCXUzMiByZWc7DQo+ICsN
Cj4gKwkJLyogQ2hlY2sgaWYgVFhGSUZPcyBzdGFydCBhdCBub24temVybyBhZGRyICovDQo+ICsJ
CXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dUWEZJRk9TSVooMCkpOw0KPiArCQlm
aWZvXzBfc3RhcnQgPSBEV0MzX0dUWEZJRk9TSVpfVFhGU1RBRERSKHJlZyk7DQo+ICsNCj4gKwkJ
cmFtX2RlcHRoIC09IChmaWZvXzBfc3RhcnQgPj4gMTYpOw0KPiArCX0NCj4gKw0KPiArCXJldHVy
biByYW1fZGVwdGg7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogZHdjM19nYWRnZXRfY2xlYXJf
dHhfZmlmb3MgLSBDbGVhcnMgdHhmaWZvIGFsbG9jYXRpb24NCj4gICAqIEBkd2M6IHBvaW50ZXIg
dG8gdGhlIERXQzMgY29udGV4dA0KPiBAQCAtNzUzLDcgKzc5MSw3IEBAIHN0YXRpYyBpbnQgZHdj
M19nYWRnZXRfcmVzaXplX3R4X2ZpZm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICB7DQo+ICAJ
c3RydWN0IGR3YzMgKmR3YyA9IGRlcC0+ZHdjOw0KPiAgCWludCBmaWZvXzBfc3RhcnQ7DQo+IC0J
aW50IHJhbTFfZGVwdGg7DQo+ICsJaW50IHJhbV9kZXB0aDsNCj4gIAlpbnQgZmlmb19zaXplOw0K
PiAgCWludCBtaW5fZGVwdGg7DQo+ICAJaW50IG51bV9pbl9lcDsNCj4gQEAgLTc3Myw3ICs4MTEs
NyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19l
cCAqZGVwKQ0KPiAgCWlmIChkZXAtPmZsYWdzICYgRFdDM19FUF9UWEZJRk9fUkVTSVpFRCkNCj4g
IAkJcmV0dXJuIDA7DQo+ICANCj4gLQlyYW0xX2RlcHRoID0gRFdDM19SQU0xX0RFUFRIKGR3Yy0+
aHdwYXJhbXMuaHdwYXJhbXM3KTsNCj4gKwlyYW1fZGVwdGggPSBkd2MzX2dhZGdldF9jYWxjX3Jh
bV9kZXB0aChkd2MpOw0KPiAgDQo+ICAJc3dpdGNoIChkd2MtPmdhZGdldC0+c3BlZWQpIHsNCj4g
IAljYXNlIFVTQl9TUEVFRF9TVVBFUl9QTFVTOg0KPiBAQCAtODA5LDcgKzg0Nyw3IEBAIHN0YXRp
YyBpbnQgZHdjM19nYWRnZXRfcmVzaXplX3R4X2ZpZm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+
ICANCj4gIAkvKiBSZXNlcnZlIGF0IGxlYXN0IG9uZSBGSUZPIGZvciB0aGUgbnVtYmVyIG9mIElO
IEVQcyAqLw0KPiAgCW1pbl9kZXB0aCA9IG51bV9pbl9lcCAqIChmaWZvICsgMSk7DQo+IC0JcmVt
YWluaW5nID0gcmFtMV9kZXB0aCAtIG1pbl9kZXB0aCAtIGR3Yy0+bGFzdF9maWZvX2RlcHRoOw0K
PiArCXJlbWFpbmluZyA9IHJhbV9kZXB0aCAtIG1pbl9kZXB0aCAtIGR3Yy0+bGFzdF9maWZvX2Rl
cHRoOw0KPiAgCXJlbWFpbmluZyA9IG1heF90KGludCwgMCwgcmVtYWluaW5nKTsNCj4gIAkvKg0K
PiAgCSAqIFdlJ3ZlIGFscmVhZHkgcmVzZXJ2ZWQgMSBGSUZPIHBlciBFUCwgc28gY2hlY2sgd2hh
dCB3ZSBjYW4gZml0IGluDQo+IEBAIC04MzUsOSArODczLDkgQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIAkJZHdjLT5sYXN0
X2ZpZm9fZGVwdGggKz0gRFdDMzFfR1RYRklGT1NJWl9UWEZERVAoZmlmb19zaXplKTsNCj4gIA0K
PiAgCS8qIENoZWNrIGZpZm8gc2l6ZSBhbGxvY2F0aW9uIGRvZXNuJ3QgZXhjZWVkIGF2YWlsYWJs
ZSBSQU0gc2l6ZS4gKi8NCj4gLQlpZiAoZHdjLT5sYXN0X2ZpZm9fZGVwdGggPj0gcmFtMV9kZXB0
aCkgew0KPiArCWlmIChkd2MtPmxhc3RfZmlmb19kZXB0aCA+PSByYW1fZGVwdGgpIHsNCj4gIAkJ
ZGV2X2Vycihkd2MtPmRldiwgIkZpZm9zaXplKCVkKSA+IFJBTSBzaXplKCVkKSAlcyBkZXB0aDol
ZFxuIiwNCj4gLQkJCWR3Yy0+bGFzdF9maWZvX2RlcHRoLCByYW0xX2RlcHRoLA0KPiArCQkJZHdj
LT5sYXN0X2ZpZm9fZGVwdGgsIHJhbV9kZXB0aCwNCj4gIAkJCWRlcC0+ZW5kcG9pbnQubmFtZSwg
Zmlmb19zaXplKTsNCj4gIAkJaWYgKERXQzNfSVBfSVMoRFdDMykpDQo+ICAJCQlmaWZvX3NpemUg
PSBEV0MzX0dUWEZJRk9TSVpfVFhGREVQKGZpZm9fc2l6ZSk7DQo+IEBAIC0zMDkwLDcgKzMxMjgs
NyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2NoZWNrX2NvbmZpZyhzdHJ1Y3QgdXNiX2dhZGdl
dCAqZykNCj4gIAlzdHJ1Y3QgZHdjMyAqZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gIAlzdHJ1
Y3QgdXNiX2VwICplcDsNCj4gIAlpbnQgZmlmb19zaXplID0gMDsNCj4gLQlpbnQgcmFtMV9kZXB0
aDsNCj4gKwlpbnQgcmFtX2RlcHRoOw0KPiAgCWludCBlcF9udW0gPSAwOw0KPiAgDQo+ICAJaWYg
KCFkd2MtPmRvX2ZpZm9fcmVzaXplKQ0KPiBAQCAtMzExMyw4ICszMTUxLDggQEAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9jaGVja19jb25maWcoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICAJZmlm
b19zaXplICs9IGR3Yy0+bWF4X2NmZ19lcHM7DQo+ICANCj4gIAkvKiBDaGVjayBpZiB3ZSBjYW4g
Zml0IGEgc2luZ2xlIGZpZm8gcGVyIGVuZHBvaW50ICovDQo+IC0JcmFtMV9kZXB0aCA9IERXQzNf
UkFNMV9ERVBUSChkd2MtPmh3cGFyYW1zLmh3cGFyYW1zNyk7DQo+IC0JaWYgKGZpZm9fc2l6ZSA+
IHJhbTFfZGVwdGgpDQo+ICsJcmFtX2RlcHRoID0gZHdjM19nYWRnZXRfY2FsY19yYW1fZGVwdGgo
ZHdjKTsNCj4gKwlpZiAoZmlmb19zaXplID4gcmFtX2RlcHRoKQ0KPiAgCQlyZXR1cm4gLUVOT01F
TTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAtLSANCj4gMi4xNy4xDQo+IA0KDQpBY2tlZC1ieTog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGlu
aA==

