Return-Path: <stable+bounces-69764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B393F9590D5
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 01:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6762850C0
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A91C6880;
	Tue, 20 Aug 2024 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qkKqi6jz";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TOnMMOGy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GCASHc9h"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD718A6C9;
	Tue, 20 Aug 2024 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195032; cv=fail; b=VOxAgW8xRzWcQoCOFioKduP4rykwYNu+IPqh+ClfNs+jx6YKhMHXyuxn8zxfZ6Hz/xyzZKXNSq+kGCTn0NqhjuBVv6nCs0RXSQRUNwQ+S6lgHwu//9zQw7SpBpnTwKJOHQDJHnso3UUuwRxlPh+S/nm9kUACGx/R7BojgnvO988=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195032; c=relaxed/simple;
	bh=Xo+qHFIN1cVf5fcgedLD8J4iV8eCbzPPMMx5hZFRb4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPJjGeYA48V5nX9xrFmN/fBBHxERv8mc3YtSAdRMFZoRe4K3lNVU4CP3JFeBVdnJfCUet+EVnCY2sdunJwsEQJR7BXpOVjIpuvZLTS5uPSYZNuRIofLjaF50rbqAGU+MVBaV51kx4YJLm+mbZuLbG8GSLeVVsH7r8yQcXKu/RlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qkKqi6jz; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TOnMMOGy; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GCASHc9h reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMmOGX024936;
	Tue, 20 Aug 2024 16:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Xo+qHFIN1cVf5fcgedLD8J4iV8eCbzPPMMx5hZFRb4A=; b=
	qkKqi6jze/3H3/kbwIz4oJV2Xkbj9oplPWGgvBDkRWv0+LgQVFB9/kMwGicGv33J
	M6qMuQp3bOiPw33J2fC4BfziX3RlWZrMuiQTxKgFhqam0l6nAFWLf6O9AqHM0rL3
	G2dJOHXilPv06ctLmTe7zICmvqqC/vr893rSsK0BkdIx6ZfmrPb5aHEzXeEAzPNI
	4CplWG/H6tpf+OGEcQDTdDTrfBm1uN0e35bcUIm1of3DYUu3lZDBet6AyqGxmp5A
	ITP4BVFGtDLeH1QuV80HDpxWrAiAOU24OcvosBBOvm7pwz8rAil9+d8o9J8O9kbE
	ieIs3bojL1YRj8nvUjrMKA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 414g8knc74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724195023; bh=Xo+qHFIN1cVf5fcgedLD8J4iV8eCbzPPMMx5hZFRb4A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TOnMMOGyYjGoSYqg/duaSEYzAbd9tBjE813ixnGq64s+aB87ShJ+zns2mx1o9atnK
	 ZDakhtQEJLL9SXMOOc9K//QTmKTdqkAmdvb9ugQUXNDdLo3K5kJI0oq4q8XhSikiAW
	 SXo/V/izCxUcC7DG4WgZ+rQU/Dns8PDaePYe6Kmyq8a81FJ3W9PJ3JT2rH+LxM05z6
	 aMyX3IxNAS+2Lb9C+NByM/vE/wNCdYnMxwAAMGAazLbazVv4EZSxz/XVHEvVhLKc2+
	 bxftiD04n/xg6G72RIYPz0DHtNgjwVWBPr4udNsjm6wAmE9LPGOojvu7OXTvIA2gEA
	 tQ2QxcDG2TBkQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1382540235;
	Tue, 20 Aug 2024 23:03:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 85806A0095;
	Tue, 20 Aug 2024 23:03:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GCASHc9h;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2654D4035C;
	Tue, 20 Aug 2024 23:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSHz7yKaEWGYdGAgOb+Wbn5DD+NOv/stJIci9dD6yrA2ViYDPyqdc9sgFtxG7hJ8jZbXFs6dPVcrfgpNMW5X4sebiyY6XblgvTDnwhRMA3ebCEiu0KZLf0gG9VTvV68iYFNPaWNiXTy6ZN2/WAwPiz2PavL8njr2MmdXQVuVs600I3dkcbjgorhOmSTw4vSfCvWPb2rLfbuzlPl6V04iP6AfZ4gJztgMtBJRp+v8KOpX69vaRvRczrF/AQd/sipSvWaSJLvD1Xf4VRXEQaNUbGKFA/nFcgvymGb5VZnMa9qa80nsVwWhzcsXyjmK4Bt/sXLO4YB3OopcirDRUSYtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo+qHFIN1cVf5fcgedLD8J4iV8eCbzPPMMx5hZFRb4A=;
 b=Q81t9HC20O6u+1qSbX5t+nYI/GYYhvEttSlSYDQvvXvuogtpyBTOKJrs0s/N7iVlZ3mG2keXtEmwEzoWAs2OE/gaZ8iboE1tkVfeFRy6ZeSkNIVXwZDw/A8iwr5jAwTpH4BdCLioZ1Kc+djyaiHkTjky9jmnrksXX6TMCMTzMx50HBLs3WQuu3dNBqacaNmHcsFwbStpE0jUUSQw76Cd+FynauqrrFup3kUDC0VRK49n7SQdWWk/PQWPSYMt9Oao6Z1rvDKD2JEyCXaruJlkO7LZhWIYxWVjmXi5gbH02oG02bBO6tX6QclPLABp5iqN3Neq4N9N8euihMqB77hQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo+qHFIN1cVf5fcgedLD8J4iV8eCbzPPMMx5hZFRb4A=;
 b=GCASHc9h07Dfkpv/kEgEmF59unep1VpO88xzVKcRZoIVB1bZAAIciKD9RPVLFC/cna25RkuqMY6X26snSUk2Hp7hfjy1zblJtfMip5JGV0MOLRlED9KycoMFumfTELP3UmgEAQnazv3xRO7kxJwpivxQz2BytESW2HhhRSEJW5I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 23:03:38 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 23:03:37 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Selvarasu Ganesan <selvarasu.g@samsung.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Topic: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Thread-Index: AQHa6YuP+qYtFRYGC02uoJ+XT4o4f7IuYUoAgAJ1/AA=
Date: Tue, 20 Aug 2024 23:03:37 +0000
Message-ID: <20240820230334.q3nmncoer7ujuon2@synopsys.com>
References:
 <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>
 <20240808120507.1464-1-selvarasu.g@samsung.com>
 <9de9be29-2f75-41a1-931b-f8cf0a9904ac@quicinc.com>
In-Reply-To: <9de9be29-2f75-41a1-931b-f8cf0a9904ac@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7554:EE_
x-ms-office365-filtering-correlation-id: b1a4cfe6-7d76-4c9d-da74-08dcc16c5342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWhDQUxKWUtkWDlqUk56dzVZZVBpcXlJWVNhQW90UkZFQkFhd1A1dUVWNGJj?=
 =?utf-8?B?Z1ZKNUh0WE1vcUFOWGZ0Szd3YVhSbExsOHJLZjMrajN2TmVMR01UeHc2cnE2?=
 =?utf-8?B?WEdlS3RvUzFLeEI0QlAyaFBhVGNIaUVaUVl3UGJUa1ZZMk9ncHhoMFJNR09o?=
 =?utf-8?B?amRJbkVMM3FVZktDRlFadDhsdTRidzlkOVFNNy9UbXJacDJack92WWJqTlJM?=
 =?utf-8?B?eGhqdjNTcnB5all4aG1jLzFMdjhCMlBUR0w5NUpmM3dDem53V2RvSHo5TVlx?=
 =?utf-8?B?NmFpRldqbGp5dVg1NGYrQW8xQmhzN3ZVVTYyS2tjU2cvZld2aGgxY1EyeGVk?=
 =?utf-8?B?bnFrUy8rT01mNDV3Q3o3NTRPYm40Rkhab2E5SE5YWnFrc0tZaFl0RjNpcUZu?=
 =?utf-8?B?UFoxK0pjU00rNnJIYm5maG1SckRNYjBLanRkS1djODZVdHJ3QkRyQlFaNGFY?=
 =?utf-8?B?OUVrS0YvMFhybDNEcmpiUXBJQ0ZyOGJRNHhFSDRMMWNYNHlCQVN5LzQyaUx4?=
 =?utf-8?B?di9Wc3kzbEJwazhST2J3S1o5RVk4S2RqU1BFQWJTdzE5TWNPKzJheHpHdWpL?=
 =?utf-8?B?aUNLZlEwRUVhU3dpN2xBejkyT0owQ2RNa2kyT01SODdlV004clNtMWcvQ3l6?=
 =?utf-8?B?VkdycTJtSUxCVm9VenVuOVFWczBzZ2VFQm8zeStySFhMRFFPN1JGZWErazhi?=
 =?utf-8?B?M3p2ODIxM1BRTW1DVTB4Y3BBUUxrNnM0djdVWGRJM2FyQmtJZ0RBVzNaNWxt?=
 =?utf-8?B?Wm14dnNqdnIyWlRsOXJkOEk1Skp3SVd4aGgrRU0wZGVnK2VqQjFuNmtnMUdE?=
 =?utf-8?B?bWs5TzRGZ2F3WUJOSlVtV1BtY2dwOHB5VVJDMnNvbVpGTFRiQWxaYjUrTDFq?=
 =?utf-8?B?OVQ1Y1IwaHJoM0VHWXB1UFR2M3QzWS84M1FtTzJOTitBS0xYdXBGeWFOZWYx?=
 =?utf-8?B?c3VhQS9UWGwyT0NrUDkyRmRMZFNMV3RsMWYxVmRpV2RGM2tBejkvWEFaZkpC?=
 =?utf-8?B?UjVPdlpnbS81WVVYT1lxQjdabHRoaisvTzJpQUtqTk5ZZmw1YWRtdFF2UFhk?=
 =?utf-8?B?QTU5WUtSTU5jM3V6ZEdaRTlWVk9oOXU3dEMrSEx5TFRIbzNubkFaNmxwTFRJ?=
 =?utf-8?B?SWNSUnJOZjdybDNkeGszREFyRm55VjZkb1FwZkFLUHZuK1VkV2JMdThsVnUv?=
 =?utf-8?B?ZGVjNTcxL1kyZzJmRktJZERFeXlGbE1OTEpVcHdIK1NxNE8zOXNIdkVaUGtW?=
 =?utf-8?B?b1djZGRqckxrVnVGeXRPSkp6WVk3cnB6U1NOcUZyT2tOVWlidnNOZUFFZ1pa?=
 =?utf-8?B?bUxsMTE0bUtMbDVvZTZDcFcrYm81emw0dnhCTUE1SjQzb1lkcGVTdkxYa0Fi?=
 =?utf-8?B?bWxPSE1wZStPVk5FUURXOUtuQmY2RjZodmMvbFFEQ3M1aFEyWG9DbmE1VXRs?=
 =?utf-8?B?dXQzQzdVUi90TWMvd2RtQmlGc1hrcUxiSzZoQ0tlWGRJc0FEaUMvaGxodXlo?=
 =?utf-8?B?azNrN0FzK0FnRFZzMk1hdkxXWVdNcEpyQlZ6b1lMd0FiUWJNK09vQ1poaDVT?=
 =?utf-8?B?Uy8yaHVlWmg0ak5FZHBqczU0MHI4bm5zc09PQmJxeUxibFpzUUJqa1N2eW9B?=
 =?utf-8?B?V05LWEpxVWFVQit5M21ITVJ3RmlhaElHSyt0NDZza0R0enZ1NGhMeWdPN3RE?=
 =?utf-8?B?SHQxdURjWklPTWplMk9FSVpETklFVFlWd0d2V2x0SHVQMXpucVNocHVKWGlZ?=
 =?utf-8?B?Q1ZrMm5NVzVNNm1rZ1c0WFNGNElldDd1ckNDakgyTFVwVmdxZXdqUy9ZbkRE?=
 =?utf-8?B?bWZEYTF4VHVmQ0Q4MHplQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akZIUGJzYmJtdFF2QzlEeGZ1Nzlsd0tZMEVIK0IzTkFpeU1nS1B6NGw1WTNQ?=
 =?utf-8?B?RnFuRlo1RDl3c2xWTTNpekIyTUlDRk11b1UxbGI1eXNPejR4SmZFa3M2SEs3?=
 =?utf-8?B?UWxCV1VPQmxXN1JxNFV1bTdBK1RCSFVsbmlBeldUejA4eWQxRlNCYjY1MHJZ?=
 =?utf-8?B?aFRZdkJYUHBaRC84NlFjWnJSTXBLcmoza2pVMHRsYUdnZHV2S1FsSkJyclRu?=
 =?utf-8?B?cTY0czFZYTVuZlNiY2FkMWs4eUZTT2JoVmx6b3lvVGg2d25CZVJRc3dlRDI3?=
 =?utf-8?B?RmdPN2pFUUxJZGZQVEtjZmdqMWs3WkhtVU1zNk5EbEQySmtKMHVPeENTRHlV?=
 =?utf-8?B?S2I1ZDZ6ZHVocHBaM1dtc2hNcXpsNVNmY3JsandZWEZ3UmNMYThFbGpuWFVu?=
 =?utf-8?B?WGhsbm9UUTcyMmhaYVNSRUhSM2lDUUNzTnBCQmxxbjJRcnhFMkErcDB4eHZB?=
 =?utf-8?B?YVJWZnl4dXF0YzFodTFNT2RvUC8weDBTNUJpczlOTHdIcVRLZU1KZVZXcXhr?=
 =?utf-8?B?c1pVcXVLMkN5VHNOZ1BFV21NY3M5RnhjNGtwZ09mWDJsTWhpQVlSN2Z6enRy?=
 =?utf-8?B?MnJVUXJ6RDFPL1h3UTBnWGZEQXhWWmtma3JnK294VUVnYzBUWC8zRGdXdUww?=
 =?utf-8?B?VldiTmo1RzFyM3VXYlArWDJBZjdtaEpadE42dXRXVHZodzhBWkhOejhZUmZq?=
 =?utf-8?B?LzZORU9KSmFxcmZ6bTF6U0xkTzZoYkpCN01GR2NPTU1GM0lqekxTRC81ZjY4?=
 =?utf-8?B?aDBUQWlMWjhUek81UGRMU3JrNG5GQ0diNXlXNE5CUWs5dHNKMEU5dTFDeUo5?=
 =?utf-8?B?aGlkZVN5cVdoQ3M4WDJyRStJMVRwNjlKUmtiWUtDMWZFalNhV0FQMXd4Ymg2?=
 =?utf-8?B?V29Qcng1YkU0eEdZanBKWTR0amkvTUpHZWJaU01LS3pWNERDcDRIcG05MkxQ?=
 =?utf-8?B?cHAxejcwSzJXWStqTURTN210QVVvVzhwT2VpMGUzcTh6KzhmQzd1VW81RUpy?=
 =?utf-8?B?WUtmQmZKaEtBVHltSWc0c0JJWGQwNmVpbUsxWVBrbDVvckdoK3JITC81QzNk?=
 =?utf-8?B?VW5UMXhDTW51SkVQdHZzQ0c3VnFsVzNteHVCcXcxS1BkdTY0Tnl3UkdNaWRI?=
 =?utf-8?B?My93Y09Vb3ByOW1JTEVhUzVPck9UMWN5QlArNHhtd2VMYWRVR3AwYVY5WFAz?=
 =?utf-8?B?K24yZjZFQ29qNGxkODlwWVM2YjVCMTc4T1BTYi8wZmRsMmJDVkI2VFBtV29x?=
 =?utf-8?B?Tjl6QVJHcGFJMmFLek12Vm5OWHdQUzhqVUVpUjBlWm5uVzBEbzNyTkpjVHRV?=
 =?utf-8?B?YWhqNEh1U2ZVQVdKdTNlSDlSVGJmR3kxSFN6bGZlZytZZ3hCa3ZBbWxSOFhx?=
 =?utf-8?B?ckI4cTdJNUc3b2ZaMXNRL1JYbFAwUW9lb0pQSmpDbzM1SEVIRDNVVW5oVldp?=
 =?utf-8?B?dncxQVF4TEdvTXFVM3cwaG5rL0dnREVmOFRqakhZL1NGcjdTMGgwSjhBMkJj?=
 =?utf-8?B?R1l4WGRrVDNRY0xHRXVHR2k1MTBaeis3dlBEZkJKWkRBLy8rRUNBSmVnSHVP?=
 =?utf-8?B?VWlOYjd2blgrTW5wZDdnZHpTdVRpc1hHNTQ4YkpzT2IwdG80ZWJFTDNEVUdO?=
 =?utf-8?B?WktXY0Q5M3J4aWFMUUNlWmR6TDdTUTBhb05UYStreFFLQndIUjFIQStydmtz?=
 =?utf-8?B?bFJ0RnQrUnJkTGptVWVDbXZOYnRJNHZEY2U2K05UbkgwWGZoNTl0aExlbnhj?=
 =?utf-8?B?NmtLdkdlaFhncDFyd2YyUDEwN0VvTWRCT0V2UDhqQVpiT1VaMC9FcElkOVN3?=
 =?utf-8?B?WlJrbExpMU9NNERxVWhOOW96M2hJMzVlaGQ2UndFbTdJOXVKSC8vMVhwaVZY?=
 =?utf-8?B?ZFc5MHBMRnFPcHc0eGk0ZWx2NGh4Yk5YR2VpVEd2OGJEb1ZIVysrbWo4OUhV?=
 =?utf-8?B?dXBYNEQ4UlVqdm9CZmFFMU0wd3VTbThucDhXb1lHNjB0aE5lYnVWSERvYnZC?=
 =?utf-8?B?WmxHOXNXMXJWRjdsYXhoUXhwVm1HRTBxMHRYWXRaL1ZVNmlLQkk4QUpUUytu?=
 =?utf-8?B?ZkplQWZ6d01ib05HY3ZTdmFIZy9zeDViTzJWREk3SWhVYy95bURCaDBTbURw?=
 =?utf-8?Q?4mQd8TiNp7gOvb9hnKDSf/G8i?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CFE6ECAFE382E4F994EFAC3446C66C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E+q6oz9wT1OsI/iAxlZUmOEzP5ICEhuz8GidTIoGwYBBNbvPSM4ATnG/BRuDNZm+JYSXubyW7AuhlUImQtdB8J6dKalUhYzTb5sdbdXJD4YcLtmqqIdQWr+Sr89H2Xe7ogAnQtb+MkgdVMpV9Ix1U0dWLhJ4SmKXYlnuWXccFaSkTYKolePkjUqttpezTK0IwCDvrCgIbmbe5RlL9UuU4+Q/Gj1Zgozk13bW0ls6nuq/m7qtZbp9S/etRy7cXRs1Jav7mXsGvE15VgaPzB+qC7upLpwgY49qAUnrK3+kzdS56vEJQ0h1uzD7P/rimgyzbvLmMM9kCuX24i2mQt0AmJM8h7+/nnTBkWVej88ZaIG8Auo95ZtyRI4wZbp0ZwSYsHfY/ILPYaBv/t6/QX2AP+HHJ9g8hKCGesNVK2VJTJV/xV5vZWRdaB1ewJWsmrBk1G+BhgGtg1Py6SRVqhp3OQDK6PqBXBRpys4/IAoJoiJdfJoqvpNaf6LCmWMIHYS0IEj4DlLgN9EjUb52ImRP9n2/GbCHBupDEjntyO01nlvthJ7GIOTda2t9+4OproTpY+jkgRZ94Is3E4pDGJR0cJSEaTjw9PldGY1XtQVVALdMFiahwf8WG/Z8NAb3UPyOyk1Vont+2d4GL+lPV/UdeA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a4cfe6-7d76-4c9d-da74-08dcc16c5342
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 23:03:37.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vK7LSMWao79gKmfth19ADfyCNrJaHozOXFQFy0P7ugXW1dqnhyNzDasTXGfWcFbmUv8oZyg/hn1sKiQ3juBS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
X-Authority-Analysis: v=2.4 cv=VcqlP0p9 c=1 sm=1 tr=0 ts=66c520cf cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=HG-Rk3uhxEItsTfAd3IA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-Proofpoint-GUID: l7YBY6KNF9-FjxTJU56KhiW4srlDZVP7
X-Proofpoint-ORIG-GUID: l7YBY6KNF9-FjxTJU56KhiW4srlDZVP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_17,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200169

T24gTW9uLCBBdWcgMTksIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IA0KPiANCj4g
T24gOC84LzIwMjQgNTozNSBQTSwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4gVGhpcyBj
b21taXQgYWRkcmVzc2VzIGFuIGlzc3VlIHdoZXJlIHRoZSBVU0IgY29yZSBjb3VsZCBhY2Nlc3Mg
YW4NCj4gPiBpbnZhbGlkIGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGR1cmluZyBydW50aW1lIHN1c3Bl
bmQsIHBvdGVudGlhbGx5IGNhdXNpbmcNCj4gPiBTTU1VIGZhdWx0cyBhbmQgb3RoZXIgbWVtb3J5
IGlzc3Vlcy4gVGhlIHByb2JsZW0gYXJpc2VzIGZyb20gdGhlDQo+ID4gZm9sbG93aW5nIHNlcXVl
bmNlLg0KPiA+ICAgICAgICAgIDEuIEluIGR3YzNfZ2FkZ2V0X3N1c3BlbmQsIHRoZXJlIGlzIGEg
Y2hhbmNlIG9mIGEgdGltZW91dCB3aGVuDQo+ID4gICAgICAgICAgbW92aW5nIHRoZSBVU0IgY29y
ZSB0byB0aGUgaGFsdCBzdGF0ZSBhZnRlciBjbGVhcmluZyB0aGUNCj4gPiAgICAgICAgICBydW4v
c3RvcCBiaXQgYnkgc29mdHdhcmUuDQo+ID4gICAgICAgICAgMi4gSW4gZHdjM19jb3JlX2V4aXQs
IHRoZSBldmVudCBidWZmZXIgaXMgY2xlYXJlZCByZWdhcmRsZXNzIG9mDQo+ID4gICAgICAgICAg
dGhlIFVTQiBjb3JlJ3Mgc3RhdHVzLCB3aGljaCBtYXkgbGVhZCB0byBhbiBTTU1VIGZhdWx0cyBh
bmQNCj4gPiAgICAgICAgICBvdGhlciBtZW1vcnkgaXNzdWVzLiBpZiB0aGUgVVNCIGNvcmUgdHJp
ZXMgdG8gYWNjZXNzIHRoZSBldmVudA0KPiA+ICAgICAgICAgIGJ1ZmZlciBhZGRyZXNzLg0KPiA+
IA0KPiA+IFRvIHByZXZlbnQgdGhpcyBpc3N1ZSwgdGhpcyBjb21taXQgZW5zdXJlcyB0aGF0IHRo
ZSBldmVudCBidWZmZXIgYWRkcmVzcw0KPiA+IGlzIG5vdCBjbGVhcmVkIGJ5IHNvZnR3YXJlICB3
aGVuIHRoZSBVU0IgY29yZSBpcyBhY3RpdmUgZHVyaW5nIHJ1bnRpbWUNCj4gPiBzdXNwZW5kIGJ5
IGNoZWNraW5nIGl0cyBzdGF0dXMgYmVmb3JlIGNsZWFyaW5nIHRoZSBidWZmZXIgYWRkcmVzcy4N
Cj4gPiANCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiA4OWQ3Zjk2
Mjk5NDYgKCJ1c2I6IGR3YzM6IGNvcmU6IFNraXAgc2V0dGluZyBldmVudCBidWZmZXJzIGZvciBo
b3N0IG9ubHkgY29udHJvbGxlcnMiKQ0KPiANCj4gSSBkb24ndCB0aGluayB0aGUgZml4ZXMgdGFn
IGlzIHJpZ2h0Lg0KPiANCj4gVGhpcyBmaXggaXMgaW5kZXBlbmRlbnQgb2Ygd2hldGhlciBjb250
cm9sbGVyIGlzIGhvc3Qgb25seSBjYXBhYmxlIG9yIG5vdC4NCj4gVGhpcyBpcyBmaXhpbmcgdGhl
IG9yaWdpbmFsIGNvbW1pdCB0aGF0IGludHJvZHVjZWQgdGhlIGNsZWFudXAgY2FsbC4NCj4gDQoN
CllvdSdyZSByZXZpZXdpbmcgb3V0ZGF0ZWQgcGF0Y2guIFRoaXMgd2FzIGJyb3VnaHQgdXAgdG8g
YXR0ZW50aW9uDQpwcmlvclsqXS4gVGhlIGxhdGVzdCBwYXRjaCBpcyB2Mywgd2hpY2ggZG9lcyBu
b3QgaGF2ZSB0aGlzIEZpeGVzIHRhZy4NCg0KWypdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXVzYi84NTI2ZTQ2Zi0zMGYyLTRmMjQtODg3NC02MjRiNjZhYTU0YjFAc2Ftc3VuZy5jb20v
VC8jbTcyNDQyMDliYzYxMGM1OTJmZjkxZmZjNzJjYjVhY2FkMmIyZmY5YWMNCg0KVGhhbmtzLA0K
VGhpbmg=

