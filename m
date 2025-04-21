Return-Path: <stable+bounces-134890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E23A959BB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 01:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE6D7A8C28
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 23:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291F22AE49;
	Mon, 21 Apr 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hW+nppmd";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UzgmhvLP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T5jIS2l8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D51282F0;
	Mon, 21 Apr 2025 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745277645; cv=fail; b=JYV7xxZhFhzoh+Z5H7ytFI1AYlFPEjQIuynXri/ZhfcsbaSiw9oP6QSO1sxNvf6RxDH1tXilKhEgdubr8rd6Szu7WqmqPMMXWj6r7XLZcgfi0OsDV4kMf/DQ3alEHevTUW3XSeoNquHuruTRiDsYbII35hLIL/dRKPA1DhssH68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745277645; c=relaxed/simple;
	bh=pzEdtIoSPpIEFa3EeTVyQ4qUoUFiZ7pO9l4ePKw+1bU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V/EHwqwxlvidnqgmUEisnm+Fr4S0IVamZeLR7QqVad6uIoNu2wamm3ronhPQyNL0u6haJT9Pf0/RYH0a3dKyEHdUOMQ7dBbHPzfvokB1jW3kVqkLXgbxp0oXjrMy7cDesFwPrLge70Jad+Hi96IqbyXepuTHgkE8Lky1U+fLYgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hW+nppmd; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UzgmhvLP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=T5jIS2l8 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LHZKJu023791;
	Mon, 21 Apr 2025 16:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=pzEdtIoSPpIEFa3EeTVyQ4qUoUFiZ7pO9l4ePKw+1bU=; b=
	hW+nppmdB/faQ3Tctl9McnJyzaWbgwshRsER1nBWShYkZMe8hAYwxmjGNhQTbpSA
	Jr5GzDLhMdJPB/ikOS+Jp118ZJP/W/iWM5DmU2uicXyeuP+q244MFXtLn9T9QN8+
	TianSPYtOrvbecWxF22/pT9fxiVYfMG2s8OnmDfi0I9UhkQfmGEKHc9UrzNGhKii
	lIZHK16tpzDtfTaLWkAADUPyzCqIkoXaaHbM2vdcVAxFBl00FtU16QruvFzRx9jS
	stq+cMJUQe0nXMZQn/31z/FAD0J9XiDSx8j2JaKZcgbvBqqqkvfyen4IyukOvv58
	jLUHPcph9K95FwX/lMUutg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 464affg65h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1745277626; bh=pzEdtIoSPpIEFa3EeTVyQ4qUoUFiZ7pO9l4ePKw+1bU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UzgmhvLPje/t5IsuqDw4j7aPZ8AiqRgDVyxJlgNOTrAMB8EVJrDVXUubqcXYs/Fza
	 weN+ZjARpaJfRx9POJPF3k7HO+NiVpyqt9vzT4/VIS5zJqXPtN5Bh8Dl+3UzWdyE1U
	 uMUYDLtFMRqCoeuNCDVpK8zCX/j6M7PNhX6UiPdP/TNrw/pKkhmfydNm+zvfmoUX2v
	 6xSLotJMqnwjDfGMqoajazp4UGQ1wDHVMVA0Qmo2GZULvYP1IQs9+7a4fIePRTzp+s
	 DgaY0f2etx2E3ifL8m5godnhSRYVSQVtLFt2gJjbadzZz8z+/MdSrVhSP32M/TvDVi
	 LAh8Sdo7atRew==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3806C4013B;
	Mon, 21 Apr 2025 23:20:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 68F0FA0083;
	Mon, 21 Apr 2025 23:20:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=T5jIS2l8;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 885CE404AC;
	Mon, 21 Apr 2025 23:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8f00ns98CUfbO54kkJM3K+PkYCkUUok/bnQNRrohg1/19WKdHFk/fSlKPIWLF2EQH4tcEZwaoSfA3czeUsiZV3Y6mkI3ZFH2QZAZ+ALb8JEvAd0+2qtEgDkyovQEq/vu7xJpBHBvrmvO5HhYSG/4QeguqsRGgWgYfjcWuDMMFS3qjXgPjNYimN2tx+dhjRIuxYbQvnKU2w1bHwTXUkP65ESBtcmIPcDhpoVbbvZaw7v6d9lkjoKyMWxGkv88bcOdokQ7SDBSI0yD1BQ+ZOaHEbiPt+vZfg+3eHlIbcncq4iY3UtTwL/8lCylLQGCutvRle5guFMDeu4vSK7B7coKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzEdtIoSPpIEFa3EeTVyQ4qUoUFiZ7pO9l4ePKw+1bU=;
 b=ZaURCTF+dZvcF2oh0/e8WgIVzi682iKYPxjwdSQjdaYoWq0SnCXkzMu+8A4LJOzqnRM6feLwbaY3asSKqmqjkRuevcXK2KbweZ9DyRtJZrOkgM+TEFCxE4xtOI8bJbUuGHEJS70vuSqgnMoCmwpx6AC1XGmkfWTVvqWlAKD3j7E48+h7xoGckK6Wi/ZYLE7JQYUy0C+6/FHcU0E68YaqHlHE2YonIQlXHtgaQyi7HWlpj6gtiOTwEXfb7dqIzOvJpzqEl0y46BWzuSYuoDf4mQcdx7Go+HDXAxuHtkB4igE5EbYT+N77KXi6GutpuopbSKei1puSAaouaH0Ged0wNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzEdtIoSPpIEFa3EeTVyQ4qUoUFiZ7pO9l4ePKw+1bU=;
 b=T5jIS2l8bEV3BYX3biuH/KyNiMEi+MRdw7QMAZuD6uVpDGPtmwvPqvHLGftHFRJozNsL/zTHBtYZnKxAAgKMA586ZKS3JuDSEvTEjH6Ly4VMOEcTZewEOuHrKxju1/4uZxVVCxH2tI2/Pb+UfyEkVqogAkUupTzrgLNktIbWQD4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 23:20:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 23:20:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Topic: [PATCH v4] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Index: AQHbrrcVIJ3v9LAKC0KlURLuwZqSArOqNhAAgAPMt4CAAMehgA==
Date: Mon, 21 Apr 2025 23:20:16 +0000
Message-ID: <20250421232007.u2tmih4djakhttxq@synopsys.com>
References: <20250416100515.2131853-1-khtsai@google.com>
 <20250419012408.x3zxum5db7iconil@synopsys.com>
 <CAKzKK0qCag3STZUqaX5Povu0Mzh5Ntfew5RW64dTtHVcVPELYQ@mail.gmail.com>
In-Reply-To:
 <CAKzKK0qCag3STZUqaX5Povu0Mzh5Ntfew5RW64dTtHVcVPELYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB7875:EE_
x-ms-office365-filtering-correlation-id: ccd3cc6f-46fc-4de0-b7cb-08dd812b134e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzlscnBYb1cySFp2dS9wMVhleGxsd2N1TkJyeXNCL3dlRXU5QlQxQWVRa1hh?=
 =?utf-8?B?a2xNcEQwYjhwTTB0YUlaZThRMXM1b3hwWVJRZlV2S2poU1dhamhnWERkeVZT?=
 =?utf-8?B?ckNPQjNnc3ZueWdDWWMzaFltQm1GQzlVd0d4anJ6MDRxWHhqZkZGdnM5SFhD?=
 =?utf-8?B?SWg1aEJsYnJYQjJlcTdYS1BRcXQxQnR4T2pFbWhuZFFrOGpXN1lqeVJwUUVB?=
 =?utf-8?B?TnNoRWh2a2lhZ0EvMFA1MUVMNWdrc3pPQ254WHp5MUhybTk5bXpiM1FsTHRC?=
 =?utf-8?B?K01ObUE4aEgyZGZjNE9iYmZMVExWTUJmeHVPMUFITUJ6ajJ3WTI5Ymc3SG5a?=
 =?utf-8?B?TVRXQU1LeHFaZC9leHNpTlBkcGtsTm1VUGVEV0k0Mi9tWGFQeEN1U3ZBenA2?=
 =?utf-8?B?TnVtZXZsQ0FNa1d4N1BSbEdLUVhZQ0tBRzNsTm1QWW1VSjZMUUVqYVVKV0dD?=
 =?utf-8?B?QXJkUEZpd255MkRtSmd1UkYwL0dJVEN6NzVkMlEzek5WQ0RMVlZLSEhDOUZV?=
 =?utf-8?B?RHlhQThocXUwS2lvZ3VHM0NDNGF1MytOQ1dKRWR6TFlOdURvdURLNU1VSWVt?=
 =?utf-8?B?N2VxSytZd3NCdkVXSjcvelVTbXFiVjF5bVE5Y3UvUmw3ZFduVUVOanhSaFdu?=
 =?utf-8?B?OEJFZjlVcWYwczVjdk5VWHBpR0NQNzZ1eWZvSkpxbW9PQy9YQXNZSlAySmJr?=
 =?utf-8?B?ZDlKYlVCQ0lJZm04MG9FRWdhbjZyNGRoMjFCelYvZVpLUHcvZ0tIL1NuUDNK?=
 =?utf-8?B?U0psQktOL2h2ZDFsN25uendXbTZSSmt5Tjd5dGVyU0ZMa1Y3bjg5NUhrNU1Y?=
 =?utf-8?B?Ym5FT2F3cndZaS95cVNrWXZsT0wvcVhwTE5FbnJSQ3krYXhsMDFoQWV4cjdF?=
 =?utf-8?B?K0drZ1hUTXBzd0Y4TkpXSDRlbkZPOHdQckpPYTQzVURwZFRFM3djak1tYjRj?=
 =?utf-8?B?R0grMUxGNGFSSEVSM1AxWS82RHFYWFhmOXV5SHA3ZUtpWTNpaWplT011dlAy?=
 =?utf-8?B?Y2UyVk1RbnBJWkJiclo3cU9kT1RodTROS3hQWWI3OGhCSW1nNnpLd1hoSDNO?=
 =?utf-8?B?Ly9teVFxRFh4aVhZRzIvOHNMNXJDLzJOL3ZFRVBuMGpEaTBubERoTVNPNG1R?=
 =?utf-8?B?RjhVUWt5UTVuU3IvbWM5RlhRMXdqQjcwOGpuRFlGMURwYkd5ZWNpZ0EvNmVG?=
 =?utf-8?B?MlRSRmF1N3NxVWtNclFTN1M4OWp4dStUdmh4dnQrR3Vaby9pTWdiSnAreHpr?=
 =?utf-8?B?eVpranNGNCtrYjY5VHh0a05OSEpvSFdYcWZSV0NMdEdxNkZmT2wyYW9VeGdF?=
 =?utf-8?B?SVQvQnBXeFhvUVh6c090L004Y0hheU5yN0NsSm41ZnN5aUQraC93KzU5dTVh?=
 =?utf-8?B?bjhteFdWblBsUjR6VWdhUlp2cWU1V29zTDhHWDAxY2ppbi9DbWtTSHJ2cmxu?=
 =?utf-8?B?eVBBMms3NVBRckVnVjN4YkErNWYrOXVhR3NkOUtPZkhxMS82RUtDYjJUYVg2?=
 =?utf-8?B?c2g1RTkyM2hNOTVPNzhVU3FBS0N6TGt4cGJ6aUx2Z3JUQTNUblZ1WEhXT3k5?=
 =?utf-8?B?TGV1L1JzMWtsbk9jSXVXYVRTa01VTnpxRENHWndwZUZyL3BNdE52cVZ1Zlgw?=
 =?utf-8?B?RW5YbmQ4QVhFTnJhbFlXb1ZONHNaVnM5ei9QeFdOL1ZQSmx2Q1VjQmZpN0p4?=
 =?utf-8?B?K0FWQmlqREFnclQ2UzNmeC91S3BCU0l1dGxZdGptRktUaEcrTkZLU0Y3dzNF?=
 =?utf-8?B?SjdpU2tER092MEdtRDdiaDhvYU4vQWhtZ3V3QmtrUWtJcjhDSUEvTHFMWDNk?=
 =?utf-8?B?bllIQ094WGRTME0rdnY5bFlaMzJacGw0VTVuSTViMEdPWWJZdnlVWnpKWklu?=
 =?utf-8?B?eFA5MHdqUEVTd1Jwa2ErRkFDbExkMWk0cHYwMDlDT21CVEQwcFNFdEFhWlI3?=
 =?utf-8?B?TFZEVEJUZVZSS3IrdmV2blMySStPRllaeDJIUGtac0ZML3dxcC9xTDBSSnRK?=
 =?utf-8?Q?JeZRq5yvRpFXu4G+xQKz3AluHmEGkw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVVXZlNnd1F6VkRFSFI3aWlJUnViR2Y0OCtGVHdNRkpuZ3lacWJHb3ZxV1Zt?=
 =?utf-8?B?WWxsUHlObVppREVibStRblR6TzZ3c0ZISVBpa0pTSEh6YjhDSXZOdWJxTmNC?=
 =?utf-8?B?VEtrdlltLzM5QUhXQ0hlN2E1K3NjZlMrTVlZSERLb2J0YkpzS0orbmNoa2ho?=
 =?utf-8?B?Ykc0SHpuOTdIcjBEUGc2RER3dEswRExXWHN1SUxKSnhCcU1qZkM2QnBOWkNY?=
 =?utf-8?B?UkVwNE9hU3lIbTlOaEx5TnEySzVLcUZiZk8xaGc4TVNTUjN1c3U5T2hKVjFu?=
 =?utf-8?B?Uk9pcDlvVXA0WFAyZEk4bSsyWlAzaTBMZG4rZzM0Ly9KRXJVOHdFSzhJVUhM?=
 =?utf-8?B?dFFmbmIraGc5Uzk2ejdYVE0wWlFXblgzOWthVldYN0hmVnRkV2syTm9JWFRT?=
 =?utf-8?B?NXpSTVM5dThlSEs4RFAxWnRkK2VrVU81UDh2NWI3RXdXSGpHZDcrVi9seTM0?=
 =?utf-8?B?QmhJam1Ta3ExSm5wOEdQc1BPanpZa3VONk14QlVBY3NFNmFuSmkvcm1mVEVa?=
 =?utf-8?B?Nm9PRVdQWS9rcUV0ZW50cVhwYUsyYk1VWEhTcThJV0IwT0NrRkh5THpTUEhM?=
 =?utf-8?B?Wlp0ZUxCNWs5SFJaZWRwRGZKK1BSWk9LVnMxamloY0U1TWVnbmNVbGIzdzY2?=
 =?utf-8?B?dkVXc3FHWXFvU2VPaGg1VGM3blMrdTRObEJaTDVXWC9MOU04d0JhQ3hzODlX?=
 =?utf-8?B?ZFpOLzFHSk1FcnAvajdLbzVSaVVyaGp3bUZFbk9TMk1JU3BQbzlvTU42Zjdo?=
 =?utf-8?B?eW9mYTNmNnlnS2VUYUdKNjhGVjBETm9VRjhkU2pJMXRpNDAwRFJUVXlVS05B?=
 =?utf-8?B?anJzbUhqSnlRMFljdVJVRmNXV240NTQ4SjV0YWxLUnpUOXYzcGQ1dkV3cU53?=
 =?utf-8?B?YWNqeTAzeDdzald3YVhLK3hPOFpxVlVQOXJWRHdQVi8rNVY4K1FRYnFjdWoy?=
 =?utf-8?B?N0F6aXZLUkY1ZjUrTWUvenM0c2J3dlg3eWNPWXBTWk9NeVVOQ3BiOTQ0MU1K?=
 =?utf-8?B?UUMvcnpDaE1aeDFsN3JkZTdsNkhlWWt3a0p6b1duNTN5S21HL1B5a3doa3Rn?=
 =?utf-8?B?Z0RrOVRCTUREUkVKeHZVWkp1bTh0SlFtY2hPMEZ2dnRKdm5sOTB4RE9scjc1?=
 =?utf-8?B?ZVZDUTVQanJQN0s0QnZxRnNlYWh4bG1wSXpnNjBCa3hoSEx3MTJTb0QraFJ6?=
 =?utf-8?B?NGdpSkVSSTdLTjI1S3h3djNWaExudEV3OHBoSmtmbkV6cXBZS0UzaE9Gc21X?=
 =?utf-8?B?MDk3OTN4VmVDdi8zSy9IM0ZzekV3MXlsUXphaVBSOExmWmNXUzVLTGc1a0VC?=
 =?utf-8?B?RjN6OHU3cFA4SytGWTR0dC82cXFGMFU5RDA4S1VYZkNNa2dOdnQzbWM5dEw0?=
 =?utf-8?B?RFFLaS9BcXlzNlRYNE5rK2F0OFpoU25SalRDU2ViSGtYdUJ3MVFvTmNpVU02?=
 =?utf-8?B?UmFPMUpyNVRxTGdJQTg5NXUyeWo3bmM2ek5jQnErb25TdURPd1RuYWNwVk1J?=
 =?utf-8?B?NFB0WmlPSHlDRFh1VzIrN0U5bWlNRjlhM0YzOCs3eHR4Uml4cFk5SzlUdXZY?=
 =?utf-8?B?NW1ITkI1eHFlSllPWXZ4RHduL1duN0xQenRHeStySi9aaExUbXVUZG9YWlV6?=
 =?utf-8?B?TFk5Y1lTNEdoZDBLL0tvVzRaQkRPMVd5MVpvMmx6dnR2dDd0YWNzaC9ETlVW?=
 =?utf-8?B?NG8rZFp1Z04wMGpzWllmSkhvL2RKKzlQQkJHRENwcW9Qc2NrTXYzL1VlYngy?=
 =?utf-8?B?RGhrdmF4OGgwT3Z4alJQNkk1a2FnOW5MdHlkTU9mMTBPUlozeG5CZlpyOFM1?=
 =?utf-8?B?Ky9YQ0V2TkxuS1ltcWFVT2d5N2ROVHNyY3hUa1JidnE0T2dpd2thZDY4ZWhS?=
 =?utf-8?B?OFcyL2tGZ3d4M2FQVmpkbENpZ2pDdnFVRlNxMTBiYkFwYWhiMTVwWk14QUE0?=
 =?utf-8?B?dTMvK1lGN2ZsdVE1blRHWUw3VWZpNDNhSjBEQ0M3TVpCVGYrUXdjcFN3Z2Vp?=
 =?utf-8?B?eElnbkdQdlVQRWZIYmE2NDFGWG0zb3F0aDBCMnNQcVBJU3ZkdGZVbjVlcTMr?=
 =?utf-8?B?YzFQR1YvSDdBUXZGd2RYREx4L1ZzMitSOWlrb3Vua3VyUUFIYjYzVnNjd1U0?=
 =?utf-8?Q?jUT0/rPtyOfk1CaxevgpLqGPZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2979AA0337B0354D918B189BF41C3EDC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Plexnlal8nQrYlsNWkCHkJtDLRhoWpJtEKu+DjjO+x/PZIotKt1YCN89/Xsnf+Ud8XmSv+BWm3nPdqoUtuWAH3vq0s2RXIiMVlWAvYx0Qw8YCK9wfGtJqBuE65da5cUWmXs3sDCTxl/oYeM3M2AMe2IlnxnRsYNNL5lxjTGnXrjgGPUVMDYmVFJ2ixmGvugO7PDuPSfEBWcuP87Vpe9j8L4r4tttmp9L67b9BWYLtBPJ7AWAuugOLkZ95oklEN2wdj8D/xTi1wMlpXfxT53lz5W7HGqHw4KUw0P2/SxLJ/jR0ltXGjQTNY7sPemc6HADrJ1rVDDH7F/eLIEeZGtZS7iZhhwkWF55IT7PUmcra00dfYCyU4U0J18hu56biN508bswxurtLf3qDkm4gDTmGBrOM0vnbSElG1FXcy7KVzHHg1qgNnxBz1nAtFrAONYzpaBMDyyV2ect4UcUd8mWNoDPz9cgD4GEKS7b2asmOiPcG9ZvNMjBAGgelBocqld06cp2QNZZd7JdJ9NK0AgWUUEeflpaihsltrnxljX0DQ6HWeJC71yFW/4Mx2bIrHfmQ15W8nUODG2a3P2FkosYbd8XB9rTNVJh+Y38OtXUiWjwzhbeZIESNM4OPq2IdtfXAHdMPlZcs1RIS/QLn/P+g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd3cc6f-46fc-4de0-b7cb-08dd812b134e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 23:20:16.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaT+18qpEq6eIeMUdXav1KCF9EnBhHBZYyOEo0VLY1ntGrLrZ9Vzf66RyDjaTr9aijCoZQG268lNMfJJKpfpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
X-Proofpoint-ORIG-GUID: W9dVVcKkZHRiXVwRW7pcDwuNEXlYi_2q
X-Authority-Analysis: v=2.4 cv=QdNmvtbv c=1 sm=1 tr=0 ts=6806d2bb cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=hxlU48FJAPkviv9J1P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W9dVVcKkZHRiXVwRW7pcDwuNEXlYi_2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_11,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504210183

T24gTW9uLCBBcHIgMjEsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IE9uIFNhdCwgQXBy
IDE5LCAyMDI1IGF0IDk6MjTigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBBcHIgMTYsIDIwMjUsIEt1ZW4tSGFuIFRz
YWkgd3JvdGU6DQoNCjxzbmlwPg0KDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+IGluZGV4IDg5YTRk
YzhlYmY5NC4uNjMwZmQ1ZjBjZTk3IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4g
QEAgLTQ3NzYsMjYgKzQ3NzYsMjIgQEAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3
YzMgKmR3YykNCj4gPiA+ICAgICAgIGludCByZXQ7DQo+ID4gPg0KPiA+ID4gICAgICAgcmV0ID0g
ZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+ID4gPiAtICAgICBpZiAocmV0KQ0K
PiA+ID4gLSAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiA+IC0NCj4gPiA+IC0gICAgIHNwaW5f
bG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gPiA+IC0gICAgIGlmIChkd2MtPmdh
ZGdldF9kcml2ZXIpDQo+ID4gPiAtICAgICAgICAgICAgIGR3YzNfZGlzY29ubmVjdF9nYWRnZXQo
ZHdjKTsNCj4gPiA+IC0gICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxh
Z3MpOw0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgcmV0dXJuIDA7DQo+ID4gPiAtDQo+ID4gPiAtZXJy
Og0KPiA+ID4gICAgICAgLyoNCj4gPiA+ICAgICAgICAqIEF0dGVtcHQgdG8gcmVzZXQgdGhlIGNv
bnRyb2xsZXIncyBzdGF0ZS4gTGlrZWx5IG5vDQo+ID4gPiAgICAgICAgKiBjb21tdW5pY2F0aW9u
IGNhbiBiZSBlc3RhYmxpc2hlZCB1bnRpbCB0aGUgaG9zdA0KPiA+ID4gICAgICAgICogcGVyZm9y
bXMgYSBwb3J0IHJlc2V0Lg0KPiA+ID4gICAgICAgICovDQo+ID4gPiAtICAgICBpZiAoZHdjLT5z
b2Z0Y29ubmVjdCkNCj4gPiA+ICsgICAgIGlmIChyZXQgJiYgZHdjLT5zb2Z0Y29ubmVjdCkgew0K
PiA+ID4gICAgICAgICAgICAgICBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsNCj4gPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIC1FQUdBSU47DQo+ID4NCj4gPiBUaGlzIG1heSBtYWtlIHNl
bnNlIHRvIGhhdmUgLUVBR0FJTiBmb3IgcnVudGltZSBzdXNwZW5kLiBJIHN1cHBvc2VkIHRoaXMN
Cj4gPiBzaG91bGQgYmUgZmluZSBmb3Igc3lzdGVtIHN1c3BlbmQgc2luY2UgaXQgZG9lc24ndCBk
byBhbnl0aGluZyBzcGVjaWFsDQo+ID4gZm9yIHRoaXMgZXJyb3IgY29kZS4NCj4gPg0KPiA+IFdo
ZW4geW91IHRlc3RlZCBydW50aW1lIHN1c3BlbmQsIGRpZCB5b3Ugb2JzZXJ2ZSB0aGF0IHRoZSBk
ZXZpY2UNCj4gPiBzdWNjZXNzZnVsbHkgZ29pbmcgaW50byBzdXNwZW5kIG9uIHJldHJ5Pw0KPiAN
Cj4gSGkgVGhpbmgsDQo+IA0KPiBZZXMsIHRoZSBkd2MzIGRldmljZSBjYW4gYmUgc3VzcGVuZGVk
IHVzaW5nIGVpdGhlcg0KPiBwbV9ydW50aW1lX3N1c3BlbmQoKSBvciBkd2MzX2dhZGdldF9wdWxs
dXAoKSwgdGhlIGxhdHRlciBvZiB3aGljaA0KPiB1bHRpbWF0ZWx5IGludm9rZXMgcG1fcnVudGlt
ZV9wdXQoKS4NCj4gDQo+IE9uZSBxdWVzdGlvbjogRG8geW91IGtub3cgaG93IHRvIG5hdHVyYWxs
eSBjYXVzZSBhIHJ1biBzdG9wIGZhaWx1cmU/DQo+IEJhc2VkIG9uIHRoZSBzcGVjLCB0aGUgY29u
dHJvbGxlciBjYW5ub3QgaGFsdCB1bnRpbCB0aGUgZXZlbnQgYnVmZmVyDQo+IGJlY29tZXMgZW1w
dHkuIElmIHRoZSBkcml2ZXIgZG9lc24ndCBhY2tub3dsZWRnZSB0aGUgZXZlbnRzLCB0aGlzDQo+
IHNob3VsZCBsZWFkIHRvIHRoZSBydW4gc3RvcCBmYWlsdXJlLiBIb3dldmVyLCBzaW5jZSBJIGNh
bm5vdCBuYXR1cmFsbHkNCj4gcmVwcm9kdWNlIHRoaXMgcHJvYmxlbSwgSSBhbSBzaW11bGF0aW5n
IHRoaXMgc2NlbmFyaW8gYnkgbW9kaWZ5aW5nDQo+IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKCkgdG8g
cmV0dXJuIGEgdGltZW91dCBlcnJvciBkaXJlY3RseS4NCj4gDQoNCkknbSBub3QgY2xlYXIgd2hh
dCB5b3UgbWVhbnQgYnkgIm5hdHVyYWxseSIgaGVyZS4gVGhlIGRyaXZlciBpcw0KaW1wbGVtZW50
ZWQgaW4gc3VjaCBhIHdheSB0aGF0IHRoaXMgc2hvdWxkIG5vdCBoYXBwZW4uIElmIGl0IGRvZXMs
IHdlDQpuZWVkIHRvIHRha2UgbG9vayB0byBzZWUgd2hhdCB3ZSBtaXNzZWQuDQoNCkhvd2V2ZXIs
IHRvIGZvcmNlIHRoZSBkcml2ZXIgdG8gaGl0IHRoZSBjb250cm9sbGVyIGhhbHQgdGltZW91dCwg
anVzdA0Kd2FpdC9nZW5lcmF0ZSBzb21lIGV2ZW50cyBhbmQgZG9uJ3QgY2xlYXIgdGhlIEdFVk5U
Q09VTlQgb2YgZXZlbnQgYnl0ZXMNCmJlZm9yZSBjbGVhcmluZyB0aGUgcnVuX3N0b3AgYml0Lg0K
DQpCUiwNClRoaW5o

