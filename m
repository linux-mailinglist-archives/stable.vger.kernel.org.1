Return-Path: <stable+bounces-206417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31616D06A59
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 01:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 258D6301A63F
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 00:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCC1E32A2;
	Fri,  9 Jan 2026 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RAv5ECw8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jCjvh0+s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TuWBNI67"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629E54763;
	Fri,  9 Jan 2026 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919925; cv=fail; b=OFS9FNmT/Pn3Uwdz8w0JReztDoFF75NFv8XLI6TwhfYLCXop6zw+HEHXcy+FydTaWCFeQii8i2V71s1VV+HyLYrkPUjsT/4c1wf8YyhqRFtKy9nzqyTy4Vy3ROz4zN7SBa0OU5WSQMruMmbcH/qvxysj9GB4TBEeWwsZyUAjI/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919925; c=relaxed/simple;
	bh=81Q4K771Rt9C0CvhLW5eV9/77VyrZeUaQqEn5Cexj5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XUw6sp156LY5LQUuk3d9FSTwlgOf/+lFfEljmVT7TszJjfcnYf2y4xq7yzDPe28jl/uJ2lvHvuClzb29KVFQKQHe+c+YmhzFLCIBTjVynDCJBtSCNthY1rKlmYTQFrw4nXmPUEyhVZHXwxrI1Cvz9q1ZqVIwX51aOw2pcYMDxa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RAv5ECw8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jCjvh0+s; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TuWBNI67 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608MheQa3547004;
	Thu, 8 Jan 2026 16:51:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=81Q4K771Rt9C0CvhLW5eV9/77VyrZeUaQqEn5Cexj5Q=; b=
	RAv5ECw8dGXNIFm4j2oRGYSPbXYOXd/MgUIeltWCUl1Q1WbEhwqhOqqddmNiD99Y
	JWWiWsM8AHVIYFkWjVhsWjDyzuVMF703xdSw+8O27FpG9SDuXYJen9tmAzDOtOLY
	ZcINVV68p9/vXgOPN+YmLG/i5l2GoNXl+cRn2w58biiScLn3sTNMA7XOiZHyrFOF
	FLIba59yW945Vlcq+DmwVmpgH/2pVVkLG+TaJgGA7CdBiwnpYBu5K65ZT9SIx06n
	mu3mq1JgcnRL2pRq8RdGXmkvKze5rueGQ/P7JC2D+gpet9zKyxVF1VDbMMo4W51D
	uX8Nan7k0gO42r91ihSbRA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4bjng2gsrt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 16:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1767919884; bh=81Q4K771Rt9C0CvhLW5eV9/77VyrZeUaQqEn5Cexj5Q=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jCjvh0+sQmjFe3iQU0SB17kEy2aZshBoSnufo33JBWE8GiQ1tvfzW7/Cit2qvlVpn
	 GVcXWy5j0qgbzP+z/iDBgUgxNTP26pA8/2kuN4dio4gJ+znAn0aCOq+ktxADXhekZn
	 v3txHrdmD5qQofIzElxJXrBWd3AmTibHosz8d1xBbg42Q3V+lF/nfX5TmblexIlg03
	 mAOZqAoS0MX/i7pSKmdMy9ONvsVQvyJgDWO8NMpJdAIn1YRkF/jYX5OeRCH0V/yA09
	 o9byBGZGWJa83Suz5ngunrBQe+39rZ8X9Aoy52hqvsB1gHDDZ0o8uKpIT4k+yElVLu
	 yCTteUR0h5yOg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A38C3402B2;
	Fri,  9 Jan 2026 00:51:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5B27DA005A;
	Fri,  9 Jan 2026 00:51:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TuWBNI67;
	dkim-atps=neutral
Received: from PH0PR07CU006.outbound.protection.outlook.com (mail-ph0pr07cu00604.outbound.protection.outlook.com [40.93.23.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4F1694033F;
	Fri,  9 Jan 2026 00:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOZQizY+y3OooglVh9/zLbul/bSd8G4XERHtfiR6Y66T9r3szgpuPnDAZvJ4TN6cUGAnVheOFNrRg8V3j3eTexhOfGoQ7l2PNUDfAIzFcE0bB1O4UlpzDT4EkqastVqV5avkEnggFCrlcNQk+Z91TMF0ordNXWjCiGTTAv1tsjfCaOsOoKwljRdBVcAlFDCGmOLQx4rnVaVd1F2wOs4XfwJ1qf275zFJKaQd7nPI5JnC7WF4eEopxHBu5+cYtzGORsR1MxM3A1AQCYD3loe9JML9iqQkt4pcHQcsIEtizPULfu2Wdcp/LXhn6XMRfMofQHJAQ1Y+f5ZHW+VJWpE1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81Q4K771Rt9C0CvhLW5eV9/77VyrZeUaQqEn5Cexj5Q=;
 b=HSuPGQlub0xkSFA3Z3VVrxGydtqvda7AkTKKKwiBnAOORtj2Dyy+HagdSvNnxgXwhx5VtkTuS4OLMiEtpnEdbsEa5gn4oC2IeFhbbP93iyzoWC8IhfvrEX7h06NfQsihS3mPI7xiHHOTXHxpEeYaMPM7qnCmSPLdO053Ytoc2Tn4wK4P/Jq30ycgQvogNlEMD/2hwLFYABbE3SZuICXW+qgwmVVP6xe9iIk1XALXPhB1QmuQqCePsGgfB1RnM1kacztPuR0FPxNd1Z/jLDu3ceUvD+v2y8Y5YPy3wnKb3XKvqqabMWwOR0/bJ9ivst2nkPJckixPk8xW0PPUL1e27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Q4K771Rt9C0CvhLW5eV9/77VyrZeUaQqEn5Cexj5Q=;
 b=TuWBNI67KdMyb5Qj7A6n3BFscZc4zcFzr3yNnUArgJUFqfV6e/skOVHKhLhx9819+V43jqOJbDOWBk6Ry89pbbJrIQ882lPdyzBHKZZRvxaRK7GCiutXpEkDu1VTSh10dqTyO+hhXuesJCSfuHbrg+/IYDeNbI/ph7gL7ksiVk8=
Received: from MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 00:51:12 +0000
Received: from MN0PR12MB5979.namprd12.prod.outlook.com
 ([fe80::39d3:f259:acf5:7f7a]) by MN0PR12MB5979.namprd12.prod.outlook.com
 ([fe80::39d3:f259:acf5:7f7a%4]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 00:51:12 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Sven Peter <sven@kernel.org>
CC: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Calligeros <jcalligeros99@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: apple: Set USB2 PHY mode before dwc3 init
Thread-Topic: [PATCH] usb: dwc3: apple: Set USB2 PHY mode before dwc3 init
Thread-Index: AQHcgNQcymcFEqW58Uy9RZ6irpmH6LVJAm8A
Date: Fri, 9 Jan 2026 00:51:12 +0000
Message-ID: <20260109005110.oe7phmecseyomie5@synopsys.com>
References: <20260108-dwc3-apple-usb2phy-fix-v1-1-5dd7bc642040@kernel.org>
In-Reply-To: <20260108-dwc3-apple-usb2phy-fix-v1-1-5dd7bc642040@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5979:EE_|BN7PPF521FFE181:EE_
x-ms-office365-filtering-correlation-id: 36479d76-f8b7-45e9-4cc1-08de4f192f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?czBIUFVPSHZISSt1eHhlVmsvVENKSjRQUDd5YS80ZVExTGhnOHBHVk1ydlMv?=
 =?utf-8?B?UlNnKzIyc0FxeWdYSWRXMzNrK0JORU9ZOU5HQ1NoVnhtdFJOSG1IREhDMDlp?=
 =?utf-8?B?RkdPZkhydHJxaDhuQ2ZvMk5lSi9IS0VwTldoN2diMndxUEw3UHkyYXh2anpr?=
 =?utf-8?B?aVVHUWdmQ3dLUmtaVFpJRWVMeFRUZTIrekE3TlFLMmdrL04zaE9vSUNybnpN?=
 =?utf-8?B?am9nd0lrUi9NbVU3TWJpWXNDcCtRNUV3cllRYlRDaEJSRjVreDdOZmNSTTlq?=
 =?utf-8?B?RGk1cFF3L2FjSDVKRC96RDI4T1MvREcyT3AxLzl4OUhDaUdKbmMzcktRQzR4?=
 =?utf-8?B?V0kxSUIrYW1NeElXb0hzUWEwejhOd29sSkU0NFV6V01la3p3MFVpVlhqems5?=
 =?utf-8?B?ZERoQXQ4eUlzcWNoc0dFbGJSalJCcFVxU3dqVW1vQjNWVGkyZWhNYjZBMERa?=
 =?utf-8?B?MEZUNlU4SUh5L3BxS3h5UjY0ekNKUkpGUHBXTjZOVFlMZkYwTUltS2tiRUFq?=
 =?utf-8?B?TXJDck1XbXFFU2tVaS9JSjdSV2ZwdjdvcTJDSzZadUJhSE1XQk1nSUhSWjVx?=
 =?utf-8?B?NWhuakFabHk4TXdxcGM5TkhoNmxHTSt0aDNYODRSK1hLV0N3TDlVV2R1Sm5v?=
 =?utf-8?B?TnkvRVE2WlJDTElXMGFwbzB5cXpRV2VnbzlwVzJsUUdPbGJCNGFTd2owdHJq?=
 =?utf-8?B?d2pOcm52azFzbzhFU28vcU5aYVp4NDRCMXlFOVFJNG9xYnkzSXNQaWtYN2JE?=
 =?utf-8?B?SFhOVVQ0ZU04aWhvMDFjaW1FcjhKdVRVMUVwRWY0bGEyd2JJQkZYSU4zWVlO?=
 =?utf-8?B?eVE3dXJYZnFPelNOU2RBbU9FQXpGalF2YUFmZVFRN1dLQ2taWnNocmF5TERG?=
 =?utf-8?B?dzlxMWlXZE4zekJXRjFVQVZXMWdIdFZsU0JLZjhMZzlWbmtoaVYwOGxPWVB0?=
 =?utf-8?B?bVZYU3NkbG14WUNSNkFxUmYzOGRWbmxWMWl6UGJUZGtXMUhwS29NekZzZlhQ?=
 =?utf-8?B?RXltcVdEdiswNHRIOGRjMlArUFljMVZreUtZNW56dlJxVGVVWHc0ZU5JWG5H?=
 =?utf-8?B?KzVEbGZlazR3ZG1HbnVLNWFvNlVoSVpHeHRwZ0U1akU3YXltUmtSNm55MG1z?=
 =?utf-8?B?MjZYS0hsdkFkN1VIc3NrbHBKUEN1cCsvSkdIR1cvWTZoMHR0clppVHJjQzJy?=
 =?utf-8?B?VUc2bUVmeUM5ajZ3T3V1R01TbTFlTjNLNWkwb0pwVzlja2diQUxLNEFYQ0Y2?=
 =?utf-8?B?dW5YS01yaGVKV3ByZmFNYWlyalgvR0t1OGo1YTdPZVlCcXNCTHZnRlBEZ2hP?=
 =?utf-8?B?R01VbVZVLzNqOHZiVThNK2xGYjVIT2lubDl5dWozaytRUDVFSXJOYWUrTmhv?=
 =?utf-8?B?RTVxYUNSaGVCS3MzZXc1Qkh1TUNSMWwrWlEyaThsaUJBaWNnUzhOQlpaa2tl?=
 =?utf-8?B?WS9vL0piMTJiUnNKN0RHSVhwVlhVWkZxL1htTVRZMGVlR1oxWkFVTWNFbkR3?=
 =?utf-8?B?U0wvTmp0RUNoQ1VYUFp6clZCcWx4L1k3RVZ5UzBBQk5oZkV5dFBqSmZYT0ZX?=
 =?utf-8?B?U1p3MHk2aC8vUjJZMTFWSU9PZ05aZksrYlFZYXdNcGJYWkpPcStxZ3hiRkFr?=
 =?utf-8?B?elpYRlQ5ajJ5QW5ZRXUrTG5JRGRoRGZvV20yV2dORHhsYVRLYm5ta1ptSEVx?=
 =?utf-8?B?d1ZuM21xaXJQM05qUldUVWc2RXozbVVVTVlKMmxtaUdUbHE3ZHBPTlpkbWZG?=
 =?utf-8?B?bk1kbjlSQU5ETHN2NHovc0crdXUrY28zelZCMGRGTS95eEM2enZtWWhOTVZU?=
 =?utf-8?B?N01oS0xNY2ZVQ0Zka2xXcDE4WWhZL2krMSs0c0Q1aVJPeS9LTVV6OGtNVDEz?=
 =?utf-8?B?VHgxcUltTzhoMzIzby9MRGVDR2hGTncxR1VsV0hwL3hwMHNQTVYyU1F6V1BB?=
 =?utf-8?B?d044R3ByYXozQm9RZ2xMSk5qbFpPanNoeGxEWDRaYzN3RWt5bmlaUWVORVg2?=
 =?utf-8?B?YXJNcjdCajZXNmhiaTZhcXpYckFvMlNyVFYyOERPSkh3RTlEazR2YWNKNVRq?=
 =?utf-8?Q?eMfY66?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmJjRWFUTSs2MjJhaklSRUVyaU1EV25uUGhucFhwU2ErdWFsYmd3dVgwcVpZ?=
 =?utf-8?B?RGdrMTJEOU1IeFlJU2JrczJLSU5CQ1ZXRGhJNk1JcC9JellRZGp5NFhOazZt?=
 =?utf-8?B?Z1hTdDJjT3h6T0RKR3Y3RG03VjN2MDdCZS82OGF6Y3FtNVhFbHp3VEZNcGRN?=
 =?utf-8?B?aGlkRnV4Q1Zsd2tLa1NGbmJBSjVaV3ZIL0pKbnBTaXE0Tzl2K0NwU1ltWUx2?=
 =?utf-8?B?M3p1WkRnbFd0WSttSGJaem40T3BUdjdEZEswU2EwSkM0UmlWRlV3NmtNbEV5?=
 =?utf-8?B?T2RZTG9ScENyMjVDak4wd1M1L0xncVVQQkExQmZLQlF5VThDZzNMdUdxN0dG?=
 =?utf-8?B?ekhyM0krb0xSVEgxeFBXZzYzMkxsWk9rMVBwZ1FSMnh0TXAxZmp2dDNoMWVt?=
 =?utf-8?B?cHpCd2hBdDJyTVlybzFVamY0bXgvUytOMTVwTDFVRkVTNkJlTkNLZDNXakNI?=
 =?utf-8?B?N0RaRWVEMGNlci81SHcxa3VqRUc0ODludnFmSFpYQ0Z0TE0xQjkrRE4wUzZU?=
 =?utf-8?B?WUpoeW1HVUdzcDFDSWdVTHFhNk9Rb0lNdzBiV2pRbk8veTE4elIzODJUTnl2?=
 =?utf-8?B?UkRXem8zVDJpNTJWN3NhZlZsYys3TTh1b3JQMzlBTjZtdUZqaktReWF3b3NE?=
 =?utf-8?B?M3JUM2ZEcjlzSTF5NGJaZUpQQ1YvZGo3cGRFb282Ly9MZEJFYzU4a0FuMkVu?=
 =?utf-8?B?REZFdEh4ckxFWUVkZ1Rvb1dLalJYMVp5NUVhWjA2WEJOdXRWUlFENXN2VmRt?=
 =?utf-8?B?aFdlSVJ5UFpDYTRVNjIwRXZhQkt1M3cwUnFvZHc4ZUVKMzVuMGZvd1NPT0xk?=
 =?utf-8?B?QjN2VHJod1A5MjJFcUxJQTFZNmQvRG9hUmxXY0l3TFQ5a1h3UE9MUUl6WXlh?=
 =?utf-8?B?KzltaVZkV1ZTSnRIUHQ2S3dlM1BWbmlvaTdnTFNkY1NQcEhicGU0L3dLbUNU?=
 =?utf-8?B?NklUSDFrQ0Q2SDVyMUVoV0h0K0tWT1VUSHF1V0lBMUxzL0xGTWVYV09ZYWtz?=
 =?utf-8?B?bGI0OE5KcE1PcUlIUUJ0NlBkMHpFWndQTXVIeC85QjduZlA4ZlJZYm93ZkxW?=
 =?utf-8?B?eDVnckJ2ZktUWFAycUZraGdVWDhkRVF2MVp3Y1dsQmk4Y1Q0NEd2Wm1Lc2Fl?=
 =?utf-8?B?dThOdHBPazgrQTRZdmhCR3VsQk15bExHQzB2dmpHOEorWlNYeGdQQXJ1VGl2?=
 =?utf-8?B?RkE0UEZORGdRVm4xbW9yWkVmcHVuTHRNcGtqSkhqOTFDTXpnS20wYUs1bklI?=
 =?utf-8?B?d2ZlR20xS2w5azFRa2lDdEhJL2tTZ0VuSS9Ka09Sc2dWbDZRbytiWlZQVDNN?=
 =?utf-8?B?Y2lZZXlVRFdNNFFRcjVQSUpUendRNkp2d25qaDFQRC9FRDN2WGl5dmo5OW96?=
 =?utf-8?B?TEdsampreWIvUGI3WFhhNEpkbSs5anhJNFkzM2FXZThiZUVwN2w1cm9qV1ZE?=
 =?utf-8?B?ZHVwcVk4STBsdDZVNXhIc1pVdHNWaFRWVnJZU2t0a0pvcTM0cVBnOXBIalla?=
 =?utf-8?B?aGlXejYvTjU5NENMNThWQW5Nei9MNHdTVE5kSjZFL2Z2WHBlNEMwaHBWSkdB?=
 =?utf-8?B?QndrOVBleWxmNjl6UUtYYm43UlFHRXVJNEdrdGpSYW43S1FNWlBoc3pubS9i?=
 =?utf-8?B?cnpkbVhFTWNPME5FRjhNWVFhNTNwbDhob1BXeW1aNnEvQ0N0RUNDQ1VVNEZz?=
 =?utf-8?B?SEJvMDVCVDFTSC9LRVFwYjB3VkVLMEM4QjdoZWlySGNlb0hoQXcxYURGdzlZ?=
 =?utf-8?B?dFN5QVU2QXRGSHY2cXdad1lLODN6ZGhPN3pXOG5EZzg1M2p1dTFRYzRFZm1s?=
 =?utf-8?B?NnhPRDV2RTI1ZlJXVGJERGFGSVpmU2dtd3M3T1Q1aWU3UXY3Vjd2SmdWT3Uv?=
 =?utf-8?B?UHhwbDh3RG8xSnNMUVlyK1pOUDV4djlGenIwenpKRUVCV0tsRmdrY2ZNYmk1?=
 =?utf-8?B?UVg4aTVrKzlyaW1qSm82eVBTN21uanNJYUZjdGE5MU5ENjBQU3NpOExsWmF3?=
 =?utf-8?B?VVZrYzdDekZMeTFpODhLOVpqbDgwNTdONnY0bHNhLzc5clBlQm02bnJHQzBl?=
 =?utf-8?B?eEQ2bnhyRVhMejh3SEEyM29sbVFTQWRXZERsUWlpNEMxM0RnVTVuSUJvRGZD?=
 =?utf-8?B?NWg4V2htalBjU3dZZkI4L0VjcWVZL21ESWQrN0pPZ1NGTDE2ai9abTBjMDZM?=
 =?utf-8?B?V3RDbGdpL3drTjlCYUdLVmFBSitYbmVTNU9TcS9WamR2dENQeHVsWWZEeDlP?=
 =?utf-8?B?NVJlR2hWUit3QTN2YUlSVFI0MkxSZnpDaUVjYmc3Zy9MWW1NRGJwVjVHR0I3?=
 =?utf-8?B?R1BKYUdGT2hQZC9GYkZaYzRhV1g4WFBjKytjYlExdGtwS2I5dXNyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97DDF5B6E9B798459C09187CC1DBFA02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zFC5LaoMOgTUIaCb8Duiz1lZ1NYuGglTsJcu0HmwXjbtxvHatVR2t70NteULMW0ooNd9iSWEN4FT8kBby4eSaxESmeLdDtHeXGDfZttx6nk8Uwm1t+u1jNgyIZzUhVBjXEAcMG7tciQUWk9fO9NyqIIuU4hHmgkMNwL13buyiKeH8jrj2k/hKln/HM9/HN2EGnoBoZd4ljan4AqRmEWGYKUytrru2My8oiKkBr4kd14gwq/AZNp6dr4S0T+wg8RhzkdH7sF+TYZpzaa4KVS+D59T5gkrlUZL0Lp8njQ/rzviiR2hK3oof6g0JNW3yinaYE6KRRRYpG8+BojDVbzEp1yAYsRBqnFE65sNXlzHo2YE+VEPYv6blfRVvB2lxINRjwM4jm5dclS/8m1y1EjA70t0LNL4QjffSYEpGg6G8mB1CMY4i5tX6F5xr1LdBXvOBhjT5NUdAxhSQYrWqiCzkMDBtywNpAB4sqNQIMDpOTe7bYaECJ8pf+BKfozSHPTi/5VGNrxLeM0x23MrLrWmpCzLlbEZqSSiPpdjNt68sXXWEL96Z6+SUGVJXdBt5BLloYPeozN1zposGrC1kB+uOMwQtGqDkKEOxYU6lyUpKRleukk0P5E7zSLQoZLJeOh512CvpAFrBDh+wT/AFkmwfg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36479d76-f8b7-45e9-4cc1-08de4f192f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 00:51:12.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HPam9ucxPW1pzan+lJ+jPpKLo0seek8UsGaD0zx/CWqMl3lhN+Wel/9Qu89rw6S5gf3cRFWCcsxdJTwW3ZB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
X-Authority-Analysis: v=2.4 cv=Sbv6t/Ru c=1 sm=1 tr=0 ts=6960510c cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=dOLNmq4gAAAA:8 a=VwQbUJbxAAAA:8
 a=jIQo8A4GAAAA:8 a=-0LS2iNmoUzFbOtbpAcA:9 a=QEXdDO2ut3YA:10
 a=_m6CO-mWuQdSFutSHjXj:22
X-Proofpoint-GUID: DihirDCpBvd38JnlfVluq0ADcNrRSKy-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAwNSBTYWx0ZWRfXylOi1VtTYAgz
 ftg3HvKy2TqCU6MvTezf1EV9FRKDzPOaPj7BcFSlM2MYobDYVfI+ut0ona00iDTXcrcRs8mgfIm
 tMT4Xi5kE9AqGbr2u4xiaEGDcOcT3yl4Mm2UHVe9TQDuhsgAq81VYWLpmBUf4/ldlA9SkJfRMUr
 PY+JhJKYneIQ66NDsEXR4XVSWuU7AZyAMKm1rEG6AOAEbCOJbF78xAhMAFyvxKRCllkPlncClEu
 bgiKpeTK+C8A0Q5u5XrUOMin9wKAvQ+Pb6L/Ictxu5ktGxNiSsy46SXyseja/7ypElhI1ELsfGT
 G+9mJjEQn1pUIZgTvNL6Unr0xURodqbuGJqdM432kWEkWGWh2frMUj83otgIU1YkAdzYLD6zaIL
 eTW8S6PAnatYTb9gZN7IM2nwcyiQf4alfmDuDKhvXASEWxmLc2V33jiEXKIiBdRYlY8HkdJ5NA2
 GxzRp4JWNANeszj4uaQ==
X-Proofpoint-ORIG-GUID: DihirDCpBvd38JnlfVluq0ADcNrRSKy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2512120000 definitions=main-2601090005

T24gVGh1LCBKYW4gMDgsIDIwMjYsIFN2ZW4gUGV0ZXIgd3JvdGU6DQo+IE5vdyB0aGF0IHRoZSB1
cHN0cmVhbSBjb2RlIGhhcyBiZWVuIGdldHRpbmcgYnJvYWRlciB0ZXN0IGNvdmVyYWdlIGJ5IG91
cg0KPiB1c2VycyB3ZSBvY2Nhc2lvbmFsbHkgc2VlIGlzc3VlcyB3aXRoIFVTQjIgZGV2aWNlcyBw
bHVnZ2VkIGluIGR1cmluZyBib290Lg0KPiBCZWZvcmUgTGludXggaXMgcnVubmluZywgdGhlIFVT
QjIgUEhZIGhhcyB1c3VhbGx5IGJlZW4gcnVubmluZyBpbiBkZXZpY2UNCj4gbW9kZSBhbmQgaXQg
dHVybnMgb3V0IHRoYXQgc29tZXRpbWVzIGhvc3QtPmRldmljZSBvciBkZXZpY2UtPmhvc3QNCj4g
dHJhbnNpdGlvbnMgZG9uJ3Qgd29yay4NCj4gVGhlIHJvb3QgY2F1c2U6IElmIHRoZSByb2xlIGlu
c2lkZSB0aGUgVVNCMiBQSFkgaXMgcmUtY29uZmlndXJlZCB3aGVuIGl0DQo+IGhhcyBhbHJlYWR5
IGJlZW4gcG93ZXJlZCBvbiBvciB3aGVuIGR3YzIgaGFzIGFscmVhZHkgZW5hYmxlZCB0aGUgVUxQ
SQ0KPiBpbnRlcmZhY2UgdGhlIG5ldyBjb25maWd1cmF0aW9uIHNvbWV0aW1lcyBkb2Vzbid0IHRh
a2UgYWZmZWN0IHVudGlsIGR3YzMNCj4gaXMgcmVzZXQgYWdhaW4uIEZpeCB0aGlzIHJhcmUgaXNz
dWUgYnkgY29uZmlndXJpbmcgdGhlIHJvbGUgbXVjaCBlYXJsaWVyLg0KPiBOb3RlIHRoYXQgdGhl
IFVTQjMgUEhZIGRvZXMgbm90IHN1ZmZlciBmcm9tIHRoaXMgaXNzdWUgYW5kIGFjdHVhbGx5DQo+
IHJlcXVpcmVzIGR3YzMgdG8gYmUgdXAgYmVmb3JlIHRoZSBjb3JyZWN0IHJvbGUgY2FuIGJlIGNv
bmZpZ3VyZWQgdGhlcmUuDQo+IA0KPiBSZXBvcnRlZC1ieTogSmFtZXMgQ2FsbGlnZXJvcyA8amNh
bGxpZ2Vyb3M5OUBnbWFpbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBKYW5uZSBHcnVuYXUgPGpAamFu
bmF1Lm5ldD4NCj4gRml4ZXM6IDBlYzk0NmQzMmVmNyAoInVzYjogZHdjMzogQWRkIEFwcGxlIFNp
bGljb24gRFdDMyBnbHVlIGxheWVyIGRyaXZlciIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0ZXIgPHN2ZW5Aa2VybmVsLm9yZz4NCj4gLS0t
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtYXBwbGUuYyB8IDQ4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtYXBwbGUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hcHBsZS5jDQo+IGluZGV4
IGNjNDdjYWQyMzJlMzk3YWM0NDk4YjA5MTY1ZGZkYjViZDIxNWRlZDcuLmMyYWU4ZWIyMWQ1MTRl
NWU0OTNkMjkyN2JjMTI5MDhjMzA4ZGZlMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZHdjMy1hcHBsZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hcHBsZS5jDQo+
IEBAIC0yMTgsMjUgKzIxOCwzMSBAQCBzdGF0aWMgaW50IGR3YzNfYXBwbGVfY29yZV9pbml0KHN0
cnVjdCBkd2MzX2FwcGxlICphcHBsZWR3YykNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+
IC1zdGF0aWMgdm9pZCBkd2MzX2FwcGxlX3BoeV9zZXRfbW9kZShzdHJ1Y3QgZHdjM19hcHBsZSAq
YXBwbGVkd2MsIGVudW0gcGh5X21vZGUgbW9kZSkNCj4gLXsNCj4gLQlsb2NrZGVwX2Fzc2VydF9o
ZWxkKCZhcHBsZWR3Yy0+bG9jayk7DQo+IC0NCj4gLQkvKg0KPiAtCSAqIFRoaXMgcGxhdGZvcm0g
cmVxdWlyZXMgU1VTUEhZIHRvIGJlIGVuYWJsZWQgaGVyZSBhbHJlYWR5IGluIG9yZGVyIHRvIHBy
b3Blcmx5IGNvbmZpZ3VyZQ0KPiAtCSAqIHRoZSBQSFkgYW5kIHN3aXRjaCBkd2MzJ3MgUElQRSBp
bnRlcmZhY2UgdG8gVVNCMyBQSFkuDQo+IC0JICovDQo+IC0JZHdjM19lbmFibGVfc3VzcGh5KCZh
cHBsZWR3Yy0+ZHdjLCB0cnVlKTsNCj4gLQlwaHlfc2V0X21vZGUoYXBwbGVkd2MtPmR3Yy51c2Iy
X2dlbmVyaWNfcGh5WzBdLCBtb2RlKTsNCj4gLQlwaHlfc2V0X21vZGUoYXBwbGVkd2MtPmR3Yy51
c2IzX2dlbmVyaWNfcGh5WzBdLCBtb2RlKTsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludCBkd2Mz
X2FwcGxlX2luaXQoc3RydWN0IGR3YzNfYXBwbGUgKmFwcGxlZHdjLCBlbnVtIGR3YzNfYXBwbGVf
c3RhdGUgc3RhdGUpDQo+ICB7DQo+ICAJaW50IHJldCwgcmV0X3Jlc2V0Ow0KPiAgDQo+ICAJbG9j
a2RlcF9hc3NlcnRfaGVsZCgmYXBwbGVkd2MtPmxvY2spOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBU
aGUgVVNCMiBQSFkgb24gdGhpcyBwbGF0Zm9ybSBtdXN0IGJlIGNvbmZpZ3VyZWQgZm9yIGhvc3Qg
b3IgZGV2aWNlIG1vZGUgd2hpbGUgaXQgaXMNCj4gKwkgKiBzdGlsbCBwb3dlcmVkIG9mZiBhbmQg
YmVmb3JlIGR3YzMgdHJpZXMgdG8gYWNjZXNzIGl0LiBPdGhlcndpc2UsIHRoZSBuZXcgY29uZmln
dXJhdGlvbg0KPiArCSAqIHdpbGwgc29tZXRpbWVzIG9ubHkgdGFrZSBhZmZlY3QgYWZ0ZXIgdGhl
ICpuZXh0KiB0aW1lIGR3YzMgaXMgYnJvdWdodCB1cCB3aGljaCBjYXVzZXMNCj4gKwkgKiB0aGUg
Y29ubmVjdGVkIGRldmljZSB0byBqdXN0IG5vdCB3b3JrLg0KPiArCSAqIFRoZSBVU0IzIFBIWSBt
dXN0IGJlIGNvbmZpZ3VyZWQgbGF0ZXIgYWZ0ZXIgZHdjMyBoYXMgYWxyZWFkeSBiZWVuIGluaXRp
YWxpemVkLg0KPiArCSAqLw0KPiArCXN3aXRjaCAoc3RhdGUpIHsNCj4gKwljYXNlIERXQzNfQVBQ
TEVfSE9TVDoNCj4gKwkJcGh5X3NldF9tb2RlKGFwcGxlZHdjLT5kd2MudXNiMl9nZW5lcmljX3Bo
eVswXSwgUEhZX01PREVfVVNCX0hPU1QpOw0KPiArCQlicmVhazsNCj4gKwljYXNlIERXQzNfQVBQ
TEVfREVWSUNFOg0KPiArCQlwaHlfc2V0X21vZGUoYXBwbGVkd2MtPmR3Yy51c2IyX2dlbmVyaWNf
cGh5WzBdLCBQSFlfTU9ERV9VU0JfREVWSUNFKTsNCj4gKwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoN
Cj4gKwkJLyogVW5yZWFjaGFibGUgdW5sZXNzIHRoZXJlJ3MgYSBidWcgaW4gdGhpcyBkcml2ZXIg
Ki8NCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICAJcmV0ID0gcmVzZXRfY29u
dHJvbF9kZWFzc2VydChhcHBsZWR3Yy0+cmVzZXQpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2
X2VycihhcHBsZWR3Yy0+ZGV2LCAiRmFpbGVkIHRvIGRlYXNzZXJ0IHJlc2V0LCBlcnI9JWRcbiIs
IHJldCk7DQo+IEBAIC0yNTcsNyArMjYzLDEzIEBAIHN0YXRpYyBpbnQgZHdjM19hcHBsZV9pbml0
KHN0cnVjdCBkd2MzX2FwcGxlICphcHBsZWR3YywgZW51bSBkd2MzX2FwcGxlX3N0YXRlIHN0DQo+
ICAJY2FzZSBEV0MzX0FQUExFX0hPU1Q6DQo+ICAJCWFwcGxlZHdjLT5kd2MuZHJfbW9kZSA9IFVT
Ql9EUl9NT0RFX0hPU1Q7DQo+ICAJCWR3YzNfYXBwbGVfc2V0X3B0cmNhcChhcHBsZWR3YywgRFdD
M19HQ1RMX1BSVENBUF9IT1NUKTsNCj4gLQkJZHdjM19hcHBsZV9waHlfc2V0X21vZGUoYXBwbGVk
d2MsIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gKwkJLyoNCj4gKwkJICogVGhpcyBwbGF0Zm9ybSBy
ZXF1aXJlcyBTVVNQSFkgdG8gYmUgZW5hYmxlZCBoZXJlIGFscmVhZHkgaW4gb3JkZXIgdG8gcHJv
cGVybHkNCj4gKwkJICogY29uZmlndXJlIHRoZSBQSFkgYW5kIHN3aXRjaCBkd2MzJ3MgUElQRSBp
bnRlcmZhY2UgdG8gVVNCMyBQSFkuIFRoZSBVU0IyIFBIWQ0KPiArCQkgKiBoYXMgYWxyZWFkeSBi
ZWVuIGNvbmZpZ3VyZWQgdG8gdGhlIGNvcnJlY3QgbW9kZSBlYXJsaWVyLg0KPiArCQkgKi8NCj4g
KwkJZHdjM19lbmFibGVfc3VzcGh5KCZhcHBsZWR3Yy0+ZHdjLCB0cnVlKTsNCj4gKwkJcGh5X3Nl
dF9tb2RlKGFwcGxlZHdjLT5kd2MudXNiM19nZW5lcmljX3BoeVswXSwgUEhZX01PREVfVVNCX0hP
U1QpOw0KPiAgCQlyZXQgPSBkd2MzX2hvc3RfaW5pdCgmYXBwbGVkd2MtPmR3Yyk7DQo+ICAJCWlm
IChyZXQpIHsNCj4gIAkJCWRldl9lcnIoYXBwbGVkd2MtPmRldiwgIkZhaWxlZCB0byBpbml0aWFs
aXplIGhvc3QsIHJldD0lZFxuIiwgcmV0KTsNCj4gQEAgLTI2OCw3ICsyODAsMTMgQEAgc3RhdGlj
IGludCBkd2MzX2FwcGxlX2luaXQoc3RydWN0IGR3YzNfYXBwbGUgKmFwcGxlZHdjLCBlbnVtIGR3
YzNfYXBwbGVfc3RhdGUgc3QNCj4gIAljYXNlIERXQzNfQVBQTEVfREVWSUNFOg0KPiAgCQlhcHBs
ZWR3Yy0+ZHdjLmRyX21vZGUgPSBVU0JfRFJfTU9ERV9QRVJJUEhFUkFMOw0KPiAgCQlkd2MzX2Fw
cGxlX3NldF9wdHJjYXAoYXBwbGVkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gLQkJ
ZHdjM19hcHBsZV9waHlfc2V0X21vZGUoYXBwbGVkd2MsIFBIWV9NT0RFX1VTQl9ERVZJQ0UpOw0K
PiArCQkvKg0KPiArCQkgKiBUaGlzIHBsYXRmb3JtIHJlcXVpcmVzIFNVU1BIWSB0byBiZSBlbmFi
bGVkIGhlcmUgYWxyZWFkeSBpbiBvcmRlciB0byBwcm9wZXJseQ0KPiArCQkgKiBjb25maWd1cmUg
dGhlIFBIWSBhbmQgc3dpdGNoIGR3YzMncyBQSVBFIGludGVyZmFjZSB0byBVU0IzIFBIWS4gVGhl
IFVTQjIgUEhZDQo+ICsJCSAqIGhhcyBhbHJlYWR5IGJlZW4gY29uZmlndXJlZCB0byB0aGUgY29y
cmVjdCBtb2RlIGVhcmxpZXIuDQo+ICsJCSAqLw0KPiArCQlkd2MzX2VuYWJsZV9zdXNwaHkoJmFw
cGxlZHdjLT5kd2MsIHRydWUpOw0KPiArCQlwaHlfc2V0X21vZGUoYXBwbGVkd2MtPmR3Yy51c2Iz
X2dlbmVyaWNfcGh5WzBdLCBQSFlfTU9ERV9VU0JfREVWSUNFKTsNCj4gIAkJcmV0ID0gZHdjM19n
YWRnZXRfaW5pdCgmYXBwbGVkd2MtPmR3Yyk7DQo+ICAJCWlmIChyZXQpIHsNCj4gIAkJCWRldl9l
cnIoYXBwbGVkd2MtPmRldiwgIkZhaWxlZCB0byBpbml0aWFsaXplIGdhZGdldCwgcmV0PSVkXG4i
LCByZXQpOw0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA4ZjBiNGNjZTQ0ODFmYjIyNjUzNjk3
Y2NlZDhkMGQwNDAyN2NiMWU4DQo+IGNoYW5nZS1pZDogMjAyNjAxMDgtZHdjMy1hcHBsZS11c2Iy
cGh5LWZpeC1jZjFkMjYwMThkZDANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gDQo+IFN2ZW4g
UGV0ZXIgPHN2ZW5Aa2VybmVsLm9yZz4NCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRo
aW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

