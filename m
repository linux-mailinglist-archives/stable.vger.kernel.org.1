Return-Path: <stable+bounces-67724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8295261C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 01:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96331C21A68
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4414D290;
	Wed, 14 Aug 2024 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eRN7fARN";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XXC7WyjN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LqGSwkU2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDF13C820;
	Wed, 14 Aug 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723677132; cv=fail; b=l9tFi14Wco0Nfr+xTcEdafJKngJF12w1p+yyrlw772cxzpUp9ZCpElLKKRt9Y2eThyBwuhJSyq16EIdqUlRfN1VUmFCUaNA3/eV3w7FAme5vXOenpNyVadXEtB5xZCW6brDWIkGat+OT6nW6nxx6LyH1t3IuDiNCFJUmkLsd6ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723677132; c=relaxed/simple;
	bh=+wEuDPSuahJHfDFPP05VVM9zfk4PykTJINzcAGK78Bg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FbnJ2crjjzQxujSAmPG57C7jBAvl6sxFwv37X2uwtoLAUF+pOTxmjqrzgWosIbpMI8eTF3Y6u3hXPcDB6KQFu8IwaV/ZdU9D2Fprw7+6UxZdA/EBiPnAHNarUNnCFn4fYTFX//HZ5WMdaVzPVhy1UG4ybquBOX+3KCv/Gm4aB3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eRN7fARN; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XXC7WyjN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LqGSwkU2 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHsej5028296;
	Wed, 14 Aug 2024 16:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=+wEuDPSuahJHfDFPP05VVM9zfk4PykTJINzcAGK78Bg=; b=
	eRN7fARNWGZVg5SmhwIklBZytzPRG/MSAUe3yoA5QJkH34RWZUQbWcuM4teCtyZ+
	a6s6FnwzzEVXNX7U+7eu+ZcAnCMK7LqWhk73CGXY0pPkIcU5lXtcbkTCRsfI4/sd
	AzL+Inh7bAbOb9DAbJPk8yGS5/jD/A0toiJszIcScNbLpIL3PrBW/DTXWBYsjkY+
	8cq26/uKK00ChPHzEMXrndZM9ki1jZT43hW5wkfCrB2jzbBTCYIdPDVfnnb0z+YV
	w1q2D74hZ8ip6Z9HH9ywgNfQ5ua8QMsCRUcNz6H/6HDeQv2D3L2EU9uxP08x7ly3
	VyphV2L8LFliyaZH98bmEQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40x77k5y72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 16:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723677091; bh=+wEuDPSuahJHfDFPP05VVM9zfk4PykTJINzcAGK78Bg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XXC7WyjNf0NUcwh5Ftqg7XRBaB24QCw1IdxHlK5q/yb2NJgZkE3GdAv53Ng7O1Ow7
	 MQODsOoxJluW/xwvUgrcjoyhcXXOyZ1DLxsidvsVu8ChhBvyen0f/Pd1MAM0Caz3wG
	 9VtEkKPeuviONmgSejAWKBSu4EkN/CjuuCzKqBTZ5HqoLtiuFqm7mPAYJ/cEGND9g+
	 tmcY+o9K8SdtiVLDZauvWakLrrcG8GHDIqgTAmbVdSfxki6exznFqapQigVq7dByJi
	 xiLctS1iZQvEAC0mv61758Rsn4unejxksVZ8oFpUAmdf6k7Wjo147xxzKKmXCzCgKf
	 zUykDtzrhj7tw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B13AC4048F;
	Wed, 14 Aug 2024 23:11:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 36E6DA0095;
	Wed, 14 Aug 2024 23:11:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LqGSwkU2;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C7CB140130;
	Wed, 14 Aug 2024 23:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9TLT9xp9BCzVMDNEuIJR1EzWyK0agxZQqIylmljdksZv3TOaS4dlfE2+/IHYloBAfUZ2uM1g6M/yR5nC4bSsW/qwZ766j4ShCqHTtjbqknUxIm8dST89M2IjmZ7PNXLljJWdWrkK9Hc9sBrS/cWDQKPjzJ8qvCrhfU9t8kyq/RrOJ78Q2bl3XQ3uHEWgulnhLC1AcS1nkNLmykYxX0BsoJbA8FShpZkzvJrDNzyb+e9hucqEH106Zj230FSzhJadvwUg015qtm4LCY4Kpk+WbxS/m2l92/A8YxcJTBh6K/SiAJLBXYMZh0UldcMhoMFYBk5ePrQK43acDF+sg4nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wEuDPSuahJHfDFPP05VVM9zfk4PykTJINzcAGK78Bg=;
 b=U0NIomxcrCpq22Ttmr2SOK92/yPU6GPFIXbYX0Xri+OBNoRfKd23x/5wrTr/amuKrLDOOgmZgMGVNKMWVfuWTnP09bfeWiAhFCxHMc+GhHdnsVhEZNWKI27xpbyGXb4yBapzVgNKlkYCCCJdhSxEST3Elkt4EZwQDXjIB2pI75934F5PoAvW0Rq4+HiXImXaLCBvR1LJwiRiWBK0ylqbD0KxQqzfS50SWd6nn/O9bmPZ/QID2QJVBQkurEAr6/fkYCKCUYlpdWZNRDqPhL74TGOEhERD4U0EpDz5ViVsw8EqwP3s1NgFDS8j7T/k5f7rFqTbd2f4lL+eNQ28WjkZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wEuDPSuahJHfDFPP05VVM9zfk4PykTJINzcAGK78Bg=;
 b=LqGSwkU2S8SGynj2MwRJjTIah+Qlf7965j4dOme4mB0weh2I7x/ZhQsqobSf0pF+y+kDyOwmd90OI0qkJxJMJhQGabRkMGTANwST9voqnzY3lx7xlXv1UkeAIYmHwTMHxF9P4q5shfKhEAAkb5q5IdViwTSQtlvh+WolQiCJ6EY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 23:11:22 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 23:11:22 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Patrice Chotard <patrice.chotard@foss.st.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>, Peter Griffin <peter.griffin@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Lee Jones <lee@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: dwc3: st: fix probed platform device ref count
 on probe error path
Thread-Topic: [PATCH 1/2] usb: dwc3: st: fix probed platform device ref count
 on probe error path
Thread-Index: AQHa7i3zPtSaqML6rkSHTY5rvTsb2LInYiyA
Date: Wed, 14 Aug 2024 23:11:22 +0000
Message-ID: <20240814231117.5ikgxensdubor7uz@synopsys.com>
References: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB7582:EE_
x-ms-office365-filtering-correlation-id: 164e79af-637c-4a18-c0d3-08dcbcb66992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OW9xdFpLWHNVakNQMG5td2E0Qjc5cWZpZE8waDRkWkFzVEFmRFJrSzlvNkR4?=
 =?utf-8?B?Q3NpeldhN2d4S2ZxY3VhT2tPamVvMDE3dTlwdG5tMHJQYTRlRnNyRVBuQ1Ix?=
 =?utf-8?B?YXdWdlltS2FFMFVSMlhLYVhDRHRpS0Q3Qm52cFo4TmpoRjZTN012Z1hvQkd0?=
 =?utf-8?B?aEg5aXFhcHVvZnM2RENsTzdMNjJDdERkcUJoUXpuR0RzbUk1Z1k2WXE4Vnh5?=
 =?utf-8?B?S0JBZHovNmwvbjJ3RzE2aVQxcUhab1dKQXVSTHdUZUZQVDA5di8xR2FVcUcz?=
 =?utf-8?B?R1hNNGgvbmxKekpnU3grZlZRdzlla0V6TWxORE5LUWxVSXFaUzJEVmFrbmh6?=
 =?utf-8?B?OWNZOFZ2Zkl5WXhudGRNWnJnaERZa3hZVTFOS0xlNm54SmlUUVhqaEFxQkU1?=
 =?utf-8?B?YnFSNEhjRUtkL2tCZTlkdnRBVjJHc3dqdDZZSFlySmV5VEN1SlRiSDZqbm9o?=
 =?utf-8?B?K2dHS29RUWF6RWg1blZ6VE9KUEVzZnFIaXIrMFBJVlUrTjZzbmxuNXl4Zlor?=
 =?utf-8?B?NFdEdjh4TW1aTXFOTHkwMUFMVmVZNk11cUZZNkRCSGxKdlFvNVNBeWZBam5C?=
 =?utf-8?B?YWNCOU15KzhKZ3hHYVNvVnZtUmNKOUlNWnp4K3BLM3JPSGpwc1M4bDB0Qkh6?=
 =?utf-8?B?cEl2bzJwOStUTFJDdFhIRHMweWNRWEhYazFDZ1ZjUStMYkNpWDg3WGFkTXJS?=
 =?utf-8?B?dHA5aXRESVFWSnB6cU1STkVaSFgySktNb056ZHpCY0k4Y1IyMU1jK2FUNytW?=
 =?utf-8?B?T2UxakZ5Zm54UndxR1hjNUEzNlA4RFhVY0hnT1Y3L2Z6b2U1RXJabGFVMzJF?=
 =?utf-8?B?UFltdnJxbmJDWHF2THdLSzdpWmVpWnNqSkQ5b2tYWEk0eTROOFcxZklWVnpP?=
 =?utf-8?B?Qkt6eEdkMDJ2WEpYQTg0Y0pXbW5XeUpLNEJXK0xETWZmd3hwcWZacXh5RW9t?=
 =?utf-8?B?MkpMZC9JR3duRWoza1VZOTVMWU5WTEZLMnpSRzVINkFTcERacFVlaWpwNGpj?=
 =?utf-8?B?WFZmVVdCTS9sVDdKM2M0ajY4OFdsb3lWZFVPK3dPUmk4QzA2Y2UyRHlGaXZo?=
 =?utf-8?B?d0tzZmNVV2ZlVnpWSmFqSVFrQzZ5Nm5zQ0J3czVmOU15Z1JZWlVuejRvUWpC?=
 =?utf-8?B?cStJOGdJK25qaCsweHh4RElpaGRXM0FWWS9LeTFZQ0Zrb0dueURaQzd5c1lL?=
 =?utf-8?B?eWNHWVZyZ2VyTXBhWTBoM2t0aEsxUWJPSXBnbHI3dnhycndzakhEV2FiNmNl?=
 =?utf-8?B?Mmsvem52R3E3bmd5SVd5bHFWYk82WndQVjFJK1VwS1hCVjQyNnA3Vzg4NDVo?=
 =?utf-8?B?cTI0L01vMXJEaCtQTFJHL0VqTVRLS2l5T2N6TmtOSFg2R0dUaVd1WlpZQ2Qx?=
 =?utf-8?B?V1ArT21kenNaaW1CWlF2cUFGeFdZTXMyRGkwWDIyN09pRzM0N0k5VGZKNnlt?=
 =?utf-8?B?V0FqaTRUTW5QREVDMUZsR0tjNFNoeXZWK0hPb2s2QWFCTVhXNmkxK0Jienpv?=
 =?utf-8?B?akxRSDBpaU1PUFJMUU1XbCtRSWhqUlZmTUNacVgxL0hrY3RSdmVaNGt5R2x3?=
 =?utf-8?B?UWZtTDlWaHFFWXhHWEJoU0JSR3dqZEtwMWtjb1RFU21WUmtXSGNoSEZWZzR0?=
 =?utf-8?B?NGlrS3VhV2pUU0p5S1pqWndNVWM3RXJnVDBYRW8ybDNFRGdldlFQUlE1UFBJ?=
 =?utf-8?B?RlpaWGFoV2pSQTBXK3F3M1ltWEk3YUJaOEJiS0Z4Y1p0ZjlDQnFqUzV2aWFp?=
 =?utf-8?B?R3FmZzFNL3BqZ05TU3NOM2pTdDVZcU83RTg2Y2t5T3lGYkFTU3BBOEFZa1Na?=
 =?utf-8?B?ekhQWTJJOHVkTC8wbHRadkxNc2MweTRwOXhpSHovMWV4d3ppT1BjYldabjJR?=
 =?utf-8?B?bmtiR3dkaWo2a2hBS0gvejRJbnBzcFRQNWdMb1F4VUdDVUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnBqZ1B6N2xBS3lFWVdBak9IcmlHNUhCRFRkazU2QkJGT2R3WHl5aHpEM0Mw?=
 =?utf-8?B?MGVEZ05BMWwwWWVyQlpSODlMZ0p6YkpIVk5Vem5yV1A0bTROV1hLWEVCMWdY?=
 =?utf-8?B?Y3VycDNML0xyRGVzaHFRSEx4a2Qrdk83SytvZlVRQURQL0ZSSE43Rkp4M0Nk?=
 =?utf-8?B?MTFYS2xYTWNzLzhaVXdkbkN6eCtMU2FLTUVFaVpkNkJsVzBadXBPNkNGeFZl?=
 =?utf-8?B?eUpmNWhRbjM3dVdTRWYvZi81MXZqb29EZW1zdlJKSlJyY1ZtaGE5ZDE2Qk95?=
 =?utf-8?B?WCtRQW9wbmZRcGNjOXRHS1lIWUIyU2ZCam9rTWV5eElSbVVYcFhBc2lCSVZk?=
 =?utf-8?B?THVsWitzTERwV3lqNUl3VE9aRXhLZ0R4b0VnY0J0N2ZpbGxHeW50OTgrdlk5?=
 =?utf-8?B?blhhMUtWN0JoY1pMdk1SZWdZZHNLYVA0dERxd1Vwa1h1WVJpUGJvakJ4NWtC?=
 =?utf-8?B?aXJzcWgyT000bGNFaTEzUEpqUlMvMnFDL0N6ZlR6dlozMVZzTzc5YzNEQUR5?=
 =?utf-8?B?Vm5kWC9lVHJyMG1PWmZoMFM3MWJrRTFWRmdZMDR2emdlNWEreXFIMTFTcGpR?=
 =?utf-8?B?b1BnN0M4Z2RlU0pRbEcrUUlsaUR2a3R1eTRBTlRQMHVJR0Vtb2Z3ZXk4eUdD?=
 =?utf-8?B?bStSUStqbnN2eFdHd1dXMWtNdTlKU0NiZ1VudzllTWdENGcyR2xuN2ZaTUxl?=
 =?utf-8?B?dUhuZWNwek5xL0s2SnJndjJjaklJVTNUM2g0blEySWE2aGNCdTNRN1N1OVFJ?=
 =?utf-8?B?SXY5RG15eWkvdUdNeGJqQVVzSXNNbUVUbVk3NzN1emplLzZXZzQ5MnpoQ2lW?=
 =?utf-8?B?QnZka2hKSi9mRjhESEl2VDFUNThWRXdtekxsbWpyeVo4ZWxuQUdWRlQ1dkE2?=
 =?utf-8?B?RFJEaVdlRm5OQ1I0S3hwNlB6UGJDMTEyNlZUTG4yRzRWVUIzZDZ0TDF1MzZP?=
 =?utf-8?B?Ty9sYk1UekdlUlNoRkdhd2hPdnBQSGR3d09FdUYvdnU0N2l2cnY1VVVHQnUw?=
 =?utf-8?B?WDVnMUlLMFNqR284c20wRXZycHJWY0ZNYzVnZTZZZDBRc1pOdUdnelF1ZEVp?=
 =?utf-8?B?KzNaa2xlSlFTbDhYU1dLQUlnbHl1MjF4YVppYlpjZ1B1cGNSTzlheG4wV2Ra?=
 =?utf-8?B?OThXSGdoUlYrN2Mwc0JzMzhjMUlPMVJjNjhVZlVKYVZiaWlNd3Vha0pNNzBp?=
 =?utf-8?B?dWQxVDJWRklKWmdPMjZXVklvdmVGOGJHUzdtaWU4ckxSaThsSEFxc0o4WDBS?=
 =?utf-8?B?bnZXZ1RXYkRLdVowOE5nL2JDMVRHdXJUdmVTZUJsMEZhcDlTSFlGZFVLUFpx?=
 =?utf-8?B?aHpUUDJ6QkJicjg4UkNsRDNtb0NudjR1YjlLUVVzVTdKUzI3MGtrc2lTZ1gy?=
 =?utf-8?B?d1MvQ1BLbWw3UFQvSFRkRXdhdmlqemd3TGMxYVR6WmJweHRQK0pxdXB2YkFj?=
 =?utf-8?B?SjdPckozVVNaRFdSV0s5WkFsbTdSVG1scW9PTGR6ODNCRFVTY2kvTWtnSnF6?=
 =?utf-8?B?R2NJbjBFcExhQjhBMVRpYTEvcnBBakpkUUw5Q3FuKzZBMDZYYWhBK1RPSHZW?=
 =?utf-8?B?RExQUmZJSE5maktyL0Qya2pRa05zSlBJd05yWmU3dHlUaGhuOStFSk9CdDBS?=
 =?utf-8?B?eGNoQThuc1hvSzZLK3lndDhzdkY1a1BVTm0zUFRmcHB5Y3VxbFgyMElmb2Fm?=
 =?utf-8?B?Q3lwbDhuWFRWMklwbU1SQ3M2UW5BcjJSemROM0ZGWTJzR0FKNnBDM3hlWnZU?=
 =?utf-8?B?bGtlK1pBemxkOStuQ3hva1BYRWc3VkcvNTV4c2ozTlpTa3J6ZmJaQ2loamJC?=
 =?utf-8?B?TEp4SS9TVEdHT2YzNjdobk1LWE1JK0FkRElVTnAxK2VlbVFxcFNLWU9OL3BR?=
 =?utf-8?B?dm9WOWF5ZFdHSmJkb25kckFPbS9HTGlPRVRyMndSM2tCWXhGZHFTdEk5czMr?=
 =?utf-8?B?VW8xSUx1U0xNWkFzMmk2WXFITlc3c2FCVUgweFlidVFjSVFTMURBWmhRbmJx?=
 =?utf-8?B?WVA0Y1k0a0Z3MnVYcEFVeURxSzUxclNFUFUyZ1c2ODBrNm54aHZMNDFmLzZJ?=
 =?utf-8?B?Q3FCZ25sZmw2TFlIUXNGdCt4RU1mZVlRRmtKZVo5cnlEcjNabXljYWVWNWFF?=
 =?utf-8?B?WEt4dXh0L1lsdkROVCtLV2ZPTDZzTS9YVXF2ZkNPZVFqRVZYc01iOFZjOGxE?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E93C23999D79BA47AA47875B7DD36D64@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2h6rzsXPIykCmeBGyFUSbHTZpgmtX5IeJ7cw/AzvN+tCAda4G4n8pOHwPAOk0ltfkFxJ0J2AhrP03Fi7ryN6gBb9NFmSkrHcGE5ATkMwxY383wAhm4z/QoL4oGqqiG/ACXXLcWQOLSRvK4l6/x16HrSj3cqn0+Y1oeXtNmFNCFkgt2Jv0FhZ8QKc0id41rW+a31IPAngsgeIxhXsdj8sl/XyWohVd0YiQpNKi+BTVmxo9M8T2Js1D9kTQpSXO9Fsd94frl2WdCmc67mhZSDYcnDkSIenMJ6QCcDxsqoxsLSPe6Duobk92RID3zRQTn0sQDMEXsLbM6cO8S7B+sz458fqBhFSBlxM5oaOf+tmupH6v+ekVHKu5mnOV/LO/sTN1CNWWPC0f/1zHh0lXXHvhU3a/07HTTr7p6AdDY64BeFyxKpk19IveSp6YJJW+LC3SBWD/xRByQlAs6MCF1e6P7Wt9kc6B9cwW2oVwS2c5dTaltIX2m/Z3Rng/LKoFG3IZlByMqX9tkl0u3AtyHq3GR0fmok2Fo6tKAzSirGLe0DWl7bgOr5ooXhGzEtpQ+bl50QNMBBfDNuSqA+srmBOLkTCjHJBaqZgXepqzQSAtOY8/1tA5lSJnrauDgSPJBO8heFYRgGhHeDakRxeFxyKtw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164e79af-637c-4a18-c0d3-08dcbcb66992
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 23:11:22.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnJofKRa265iy789XWVQoI/31NpXXoXw96q94XKcqeRch1qGF0B/IIKq8+pV6DY+mIb/cuOkNOznZLdTj9uckQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
X-Proofpoint-ORIG-GUID: K1b6ESZzWBDxsDXPIXt2xo7jTxCHrCIE
X-Proofpoint-GUID: K1b6ESZzWBDxsDXPIXt2xo7jTxCHrCIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_19,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140162

T24gV2VkLCBBdWcgMTQsIDIwMjQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFRoZSBw
cm9iZSBmdW5jdGlvbiBuZXZlciBwZXJmb3JtcyBhbnkgcGFsdGZvcm0gZGV2aWNlIGFsbG9jYXRp
b24sIHRodXMNCj4gZXJyb3IgcGF0aCAidW5kb19wbGF0Zm9ybV9kZXZfYWxsb2MiIGlzIGVudGly
ZWx5IGJvZ3VzLiAgSXQgZHJvcHMgdGhlDQo+IHJlZmVyZW5jZSBjb3VudCBmcm9tIHRoZSBwbGF0
Zm9ybSBkZXZpY2UgYmVpbmcgcHJvYmVkLiAgSWYgZXJyb3IgcGF0aCBpcw0KPiB0cmlnZ2VyZWQs
IHRoaXMgd2lsbCBsZWFkIHRvIHVuYmFsYW5jZWQgZGV2aWNlIHJlZmVyZW5jZSBjb3VudHMgYW5k
DQo+IHByZW1hdHVyZSByZWxlYXNlIG9mIGRldmljZSByZXNvdXJjZXMsIHRodXMgcG9zc2libGUg
dXNlLWFmdGVyLWZyZWUgd2hlbg0KPiByZWxlYXNpbmcgcmVtYWluaW5nIGRldm0tbWFuYWdlZCBy
ZXNvdXJjZXMuDQo+IA0KPiBGaXhlczogZjgzZmNhMDcwN2M2ICgidXNiOiBkd2MzOiBhZGQgU1Qg
ZHdjMyBnbHVlIGxheWVyIHRvIG1hbmFnZSBkd2MzIEhDIikNCj4gQ2M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0
b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXN0LmMgfCAxMSArKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMtc3QuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jDQo+IGluZGV4IDIxMTM2MGVlZTk1
YS4uYTljYjA0MDQzZjA4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtc3Qu
Yw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtc3QuYw0KPiBAQCAtMjE5LDEwICsyMTks
OCBAQCBzdGF0aWMgaW50IHN0X2R3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gIAlkd2MzX2RhdGEtPnJlZ21hcCA9IHJlZ21hcDsNCj4gIA0KPiAgCXJlcyA9IHBsYXRm
b3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJzeXNjZmctcmVn
Iik7DQo+IC0JaWYgKCFyZXMpIHsNCj4gLQkJcmV0ID0gLUVOWElPOw0KPiAtCQlnb3RvIHVuZG9f
cGxhdGZvcm1fZGV2X2FsbG9jOw0KPiAtCX0NCj4gKwlpZiAoIXJlcykNCj4gKwkJcmV0dXJuIC1F
TlhJTzsNCj4gIA0KPiAgCWR3YzNfZGF0YS0+c3lzY2ZnX3JlZ19vZmYgPSByZXMtPnN0YXJ0Ow0K
PiAgDQo+IEBAIC0yMzMsOCArMjMxLDcgQEAgc3RhdGljIGludCBzdF9kd2MzX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhj
bHVzaXZlKGRldiwgInBvd2VyZG93biIpOw0KPiAgCWlmIChJU19FUlIoZHdjM19kYXRhLT5yc3Rj
X3B3cmRuKSkgew0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3VsZCBub3QgZ2V0IHBvd2Vy
IGNvbnRyb2xsZXJcbiIpOw0KPiAtCQlyZXQgPSBQVFJfRVJSKGR3YzNfZGF0YS0+cnN0Y19wd3Jk
bik7DQo+IC0JCWdvdG8gdW5kb19wbGF0Zm9ybV9kZXZfYWxsb2M7DQo+ICsJCXJldHVybiBQVFJf
RVJSKGR3YzNfZGF0YS0+cnN0Y19wd3Jkbik7DQo+ICAJfQ0KPiAgDQo+ICAJLyogTWFuYWdlIFBv
d2VyRG93biAqLw0KPiBAQCAtMzAwLDggKzI5Nyw2IEBAIHN0YXRpYyBpbnQgc3RfZHdjM19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0
KGR3YzNfZGF0YS0+cnN0Y19yc3QpOw0KPiAgdW5kb19wb3dlcmRvd246DQo+ICAJcmVzZXRfY29u
dHJvbF9hc3NlcnQoZHdjM19kYXRhLT5yc3RjX3B3cmRuKTsNCj4gLXVuZG9fcGxhdGZvcm1fZGV2
X2FsbG9jOg0KPiAtCXBsYXRmb3JtX2RldmljZV9wdXQocGRldik7DQo+ICAJcmV0dXJuIHJldDsN
Cj4gIH0NCj4gIA0KPiAtLSANCj4gMi40My4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

