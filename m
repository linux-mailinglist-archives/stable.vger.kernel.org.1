Return-Path: <stable+bounces-76536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBD97A8A7
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 23:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740AA1C21CBD
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51A1411E0;
	Mon, 16 Sep 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mObJ4yde";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QXsEYWsf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L1jTl+Gi"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF6F9DA;
	Mon, 16 Sep 2024 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521356; cv=fail; b=LOPMPqwSiVMeGV8MSMf2BomShDNBOIHdn8DpCmURpK/LwcLH7kXLriPiS3ofQFcLxbfvwTVbROrAInWXSekf1yDpaI/TuY5j707nv63e3Y2QU2xA/nj2ESwbdKfPC5rMO0EayasYS1z2WkS/ZXq3WbnrFOn+ZuwiiSTRwy5NyJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521356; c=relaxed/simple;
	bh=MEA0hTtGtvzBNdstp0pFNDnOYzRFBLWLMi25nRvhT6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4N9SwebQxNxS4PXoilxMsGYe0Guqkw5LAMLGhBBMD3p0vc6t2iJmM8B675iuhyIPc963Ma/0d0/g/y+ea3g4T3CZOw4trorNESiLgg/bBsX2/wJYm4i4PMpKcvjxkczg66RUIkCbMNne9T2wWPPStKOXWWjR6tzpelW+6D6hDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mObJ4yde; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QXsEYWsf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L1jTl+Gi reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GKWdOD020678;
	Mon, 16 Sep 2024 14:10:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=MEA0hTtGtvzBNdstp0pFNDnOYzRFBLWLMi25nRvhT6k=; b=
	mObJ4ydeVtYceKxqaB/TbsWxwol5cDNQtF21iS0OJedcBExzCUNkFZel2ndU+uaR
	oikGvwJ6+cMuKuLoODR1ZvlsecZfczkc6vXftu9lEuiEflov58+3kl1mmqMJM0cq
	T4UOLkpc7baZOY7wQSUqoSuZTI0titIhGfCZlakdccJvWk+SJMJIwJah+YigdynZ
	KlOdr1ykXy0LjE3zQEWRTH/aN4Wb5ARTTtzkadess9Nfw0UJ7ym1WYMQCGm7YC+C
	CmX5EXjhx40ay38CY7//Mww8S4idkOTqEyM2Cb0l4GK6SpJtAsGpi4FGMesa2yQv
	BtBAPFc8tvXbf0nwdz86qw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41n9dv08k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726521026; bh=MEA0hTtGtvzBNdstp0pFNDnOYzRFBLWLMi25nRvhT6k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=QXsEYWsfWmaVxoVBmkhJksqCrghOjPtTLuGEy6wCFtnE0fnHzug8ANHJ3UH+8Zt6Y
	 bxVr8ITbiCStn+a5LUTYlDyxm49cJ2cllhmJ241RicHrHmRnnN2KaYu0qMYtEf9P4p
	 vylaIzN1SeV3q/1S0XaBukLok7SFV9f2RsUMzKY2iZmmFo0TkBaN+BTrcj1a6a6LQR
	 SBb5XCRWYxvOwPQBbLGQEaeefFqpd4cs6afaQZ8Iy9hrL28fvcpRAj0WCzCzDht2An
	 iHwnHU8QKcY58uUCS0RkEnVst6VHlEfaV/eolkn4161eW3SjCzQLygpIrbzr72REGH
	 38pTrmgh/yMJg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8458740521;
	Mon, 16 Sep 2024 21:10:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A9173A007B;
	Mon, 16 Sep 2024 21:10:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L1jTl+Gi;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6DEB4054D;
	Mon, 16 Sep 2024 21:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T09DflJlV0kPmbviTThp+s7RX5sXeQ5F5vop9KurPu8ErAlJvGJx60zIGmbC3bEuMoUkDoLNpPTZhCPf0JqickE0D1aM7aN7wgZvUlc1hhTED+jAf/wpynq2oJX0RsNxGrwvwJ2+Dx2AKwed1iMeF2dzoL5d+dS2gG4P2s3i4HCTNW5pWdml9WP7knDxuMJkf+m8GnQm2+A1uW5kaJMXroIIq4XUfzW62C/7ElTIFf3HycAXaFwxOXPat9GvZ6q7M/m66NuprdLGwfXLI88wJpw1G3gbxjrj88HTH89ilyh0eTXIao7cS6kJeHI/fqjnh5lrZoi6K2zIx8c79S64Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEA0hTtGtvzBNdstp0pFNDnOYzRFBLWLMi25nRvhT6k=;
 b=bewcNmDWaalG6trIqsKM7NB8bjC+2y8maTUBTGtGJNWPJr6wvr5vTYRHNQ8yhuD3M2qMn0LtkzcaX0wOLp5CwMPDiHYOGE5gdI75nusmS/CE1f2i4vOLra7od47nsW1+ulxFCXNEhvS1JJd81iPBA1MH9w7+1PE9myTkYUBoTKpwCqHKlMB3qG0R3wAh49880qqq3RuKDoDUa9r5c71F4VQqvrrHit6JE406NX+kZB3P6lqIolJff9wlz71FXQZDqX6HJxSZ2ITjvEdlt2E4VzNi4SNbZH5onYks6espSF8KfNb0LHLAwrMc1PpyOGR2WUsj1kM8p+H4kXFRFxLSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEA0hTtGtvzBNdstp0pFNDnOYzRFBLWLMi25nRvhT6k=;
 b=L1jTl+Gi7LiusJxQevx4fAhQR2zrgzhH95kc4TwaHuT12DXnreJD+5nJnzqyq5oMqsbcljkIK+moDxuiRrRHE4QIXA++6CR6q0RG1nZsG0DyjWvpC39pK2rDD5LA5Hw6w9bDmM2ipkGJ7P8SnvMISJ3IYHISjCkvLrDJxvTyXa8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 21:10:20 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 21:10:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "badhri@google.com" <badhri@google.com>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: re-enable runtime PM after failed resume
Thread-Topic: [PATCH v2] usb: dwc3: re-enable runtime PM after failed resume
Thread-Index: AQHbBjO+Tp56tg+/ZEm40WfR6Q2VaLJa7UqA
Date: Mon, 16 Sep 2024 21:10:19 +0000
Message-ID: <20240916211025.33zdmwz2dkpw6vl6@synopsys.com>
References: <20240913232145.3507723-1-royluo@google.com>
In-Reply-To: <20240913232145.3507723-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB6971:EE_
x-ms-office365-filtering-correlation-id: 89211709-bf2e-47ac-6763-08dcd693f87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFh6TnZVNjVmTUZKRE4wMnljR0VvMEV3WElzVE1wWUdRTHF0VE5OajZpS0N6?=
 =?utf-8?B?VUlNMmEwMkFJQ3pmNTdtU2FnOGhFTklQWDNZS2xkLzhTMGNUMys5d2gzd1FX?=
 =?utf-8?B?NHNLVzg4Z3VjWFBtTzBmVXlLL0VPei82MjNQdUd6NlhjZjNMYzRxYVpVdk5r?=
 =?utf-8?B?Q2FzK3dQVGxTcUpxQ0t3c090RWtORjdrMkZIOTZiYlk3c25YYkNuamlDTUV1?=
 =?utf-8?B?c2ZnNHJEeXNRcGFqTjhnOHdnbFdtcDlpUWx3dHB3all2WGhFaEEvZ3p2VG5R?=
 =?utf-8?B?dmozVzhGQ216Nm1ISjA4cTAxNS9VWHRtOVdlMnlTZExBRVJMMDhzc2lwdTlr?=
 =?utf-8?B?M09KUHNaWDkxNTM3VkNjckpTV3BYS2NQaGVlRlBubTRDcWcvdWVpL0FrdHU3?=
 =?utf-8?B?UmUxYjJ5VUsxdUFGU3k3ZjdZZFpIV1BucDlxbWE3WVp4OVRjaldacHRSc0VK?=
 =?utf-8?B?b2pOR3hxQUMzR3JZMEhNK3piSWhscFh0d0tEZm9NNDZhU2dHdDBDWElUNVE3?=
 =?utf-8?B?NFdzMnRqbHdyK3ZOd1ArTTkzVXc3ZWI4Ym9FUWNsb3pwZ2p0Vy9FVWhsaFhD?=
 =?utf-8?B?SkNXdjZTcCtycjFlaWNJekVZTFpqc3VLc1FCYmZ4Qi9aS29GeXloTytNYU9z?=
 =?utf-8?B?VUlTbWp5MFVockpTeDl0amo4emx3Zk1rNUNCSUo2QjhCV2ljenZjZDFQbUdv?=
 =?utf-8?B?VzNRQVU2M051ai9MUEswYnpFT0NvVHJNSFhmQlI0Yjl4NWJ2Szd0YUZIU0Rr?=
 =?utf-8?B?T0huRTV4blp3MnExWWNMbVpWYkY1YTZZMWJxbFliZkdBc1hSdERpK0ZjaVFQ?=
 =?utf-8?B?TW9rQjlabzV4bmx0MjZhV2VEa2ZoVjIvdHNTVzlrRUZyYmxPajFQamd2NmMx?=
 =?utf-8?B?N2pQZ1pDV1BwMFJKR0VDV0Y0VGFZQ1lVb2VWc25PS2ZLTnNzelJwUm5SQW03?=
 =?utf-8?B?Wk9YK09BTGRybzM2cnpGM2h2T2NuM0o4VnN4bXZpQ3BuWmJqQ3kzMERiWDRs?=
 =?utf-8?B?QzBqcGNVTHFCa0p4RFRGVjU3QTBvUFNrZHoyOWNWcUVVTm9BRjNWU3BkWGtU?=
 =?utf-8?B?U3RCK1Fxakg0a2QyYUZPKzZ1VXVoYzluMjhzczlOYXF2b1ZYeHJjZjh2anRa?=
 =?utf-8?B?bXJJU0JGaW8xQWh5WXZPQnY2VExkR0Z5aHZGYTcvRS8rall3Rkc2UFM5aDVK?=
 =?utf-8?B?MmZ6WmtzM0lWMUV2dDd3OE05M3ZrOFFHSXIzVEhacWVYbzVzQWRoL0pJM0lz?=
 =?utf-8?B?S0dvL2lBYXpXalFHNGJ1U29OL0EycFhVZGtxVTMxeGpuN2czUDJva1JmU0I5?=
 =?utf-8?B?Vy8rQ1ZSOUVzcm81QWZTVkNCTWE2VE01U1dmVVdCRktRbW5ieExSZWRqSFU2?=
 =?utf-8?B?eUZtMDhkUFcwaFZOSjRMZXNxSGIrbHJOekV6ZHVrMm5IUWJ5SmlCRGdQSDNz?=
 =?utf-8?B?QXI1ZDMrZitPWDVhbU4zVi84dmN0NnQ3M09uTmJ3VElvS0Rvb1VsUFFpTFpN?=
 =?utf-8?B?NGdnVDlDZ0tMS0xsVmEyQk9DNlN0R3NyakR1T0FzVG1UU1pqVW9XakE1UG5Q?=
 =?utf-8?B?Tno2SFJVOXlaSFViSE9OWWJmOGF6Q0FFM0trL2ZNZWFDbnNOS1BVemdRcm15?=
 =?utf-8?B?OXE5eWFkdWxlN3Rxdm9vU0RjK2FNYlRteEdsdmhyTW1wM2pJdlJXQzhoeDlV?=
 =?utf-8?B?M0l3UGNOWHNid0NpdUMxZ2Mxck5rYUxvSFVwUHRpYUxSanczSE9PbW5ZVnpy?=
 =?utf-8?B?R2tOY3R3Z3AwWEI1R3MzcXNpQlBheXRpOHl0VjZuRFVBTEYyMjBsbmJSU2N5?=
 =?utf-8?B?cjN1WCtHZm5zRjlGWHhnN1BtK2VKWDRuUjA3aUNkWmg3bjhDbnVwanlDQmZJ?=
 =?utf-8?B?T21sT1JXc0dUY1ZiRUxuMldlc3NlRGV2QWVoWWRlZ2dOQmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0M0RnUvTDdGNUJKUi93RG9YV2xIZU9meTBCNmpobm9OWFJuVFRLNFJnS0pF?=
 =?utf-8?B?RjNTK0dvSysxTFNPZEEyd3p1ek84M3VYdVNPSlZVR0NhSjExeGdFMHpxNEpv?=
 =?utf-8?B?SDRoeEJMK3owWlE0bEZlS2x5Nmt1OWU3NkY0eUNjYTdNaHNMdmhpWXkwRFov?=
 =?utf-8?B?OWp6T0cyZXMvZngydU4yUHJ4NXJQMHo5dkdxMzhZclhyaEkza1BuZTArTWJJ?=
 =?utf-8?B?Tmk5dFBuQ2pLVXRYZnhvN1B2dUJXME04aUF0YkcyVTN0K2pkNUFjSW1wclZ6?=
 =?utf-8?B?TmV5L2VSREJ3MitLa0VDeEpHVWFZYlV5STZZRVB0Q3dnYzhVQ0NXcHd1T01o?=
 =?utf-8?B?bnJrWVh2emd4eVV2TkdlVTh6czd6ampFdmRsTnd6UDJDVU1DT25adnFJUGZR?=
 =?utf-8?B?dXNEdzdVWVBLT0MwaXRJbDh0RWgyZXR1MTMzK0hLVnR6d0J4eFJFVVU3b3FD?=
 =?utf-8?B?N1RVRnBKWEVqVDhQWDYwaW9yL1YyYUxxTnA5UktvOFJEWkt4NEp5OHp0bnY3?=
 =?utf-8?B?Sk5FTmRGSnZFMFdNcnJ6cnFEaVc5QmFydkVQY2h6NURXM3V6QzRLMjhSRkNY?=
 =?utf-8?B?UW9leFJNdmw2RzFISy9YVldnU3NBeWxMTFlKWkhhVThiMzNFZEU4VUc2YnNJ?=
 =?utf-8?B?YnVXcXh0ZVNEWkh4YlRoem9xaEp0MHp5WnFxaWJTV3pJUHBrMDh0ZW9NeVNa?=
 =?utf-8?B?MDRzMndNMmVtWXRGa25tYkdTc3p0VTFma0plTjlpdFRpYXlJY0tWRGJPUUEw?=
 =?utf-8?B?b3kybFMxRTl0M1Q4NlVjN2doRzhiakZxSU5YYjJmaWdmUHJWYWkxMFRSQUhu?=
 =?utf-8?B?V1FkL1k3U3VQcjZYVUdtMkZQZ0pvRisveVJaVkUwcnlCZDFCWUlnWWx1bkVY?=
 =?utf-8?B?by9Md3J4NFRFbUdIUGJVR3g1UHpsTEVsMjBjZGxUa2VpMTlNUHZWdk5pMS82?=
 =?utf-8?B?eExnK0EwSjVJSHZRYjlxbHN0WjE4NlJiMFRPaU5EbHMxaGZTSVJJZ29OdlFI?=
 =?utf-8?B?UEtKWFNYTG4yRDlMZG1XS2U1WWpoZ2NHS21OU1JLL1RUSDlBN0lGWHhpbFY0?=
 =?utf-8?B?ekMzTU84R2xtMHpkekxkNUdsVk5IZVpRNXhySjJaOGlFY3dXU0ZPUGpSTUxI?=
 =?utf-8?B?MlVZTHJDMmNtV3pjYkQraWVRTEtUVUJNZzhFaVZHSlE5ZnE0QW5xMU0yRERY?=
 =?utf-8?B?dzJrekhFTGxrUXV5WTVLaUYyWm13L29qbkRMdnZRTWdBVjkybVk0d2JSNWdT?=
 =?utf-8?B?UUFGRm5rc2UyakE0Ykx1bkpPZ2pXZFFHRXhBNVlrSGFUWnJ5Y1J1ZXRTVnNU?=
 =?utf-8?B?bWJieFNmSnFvbE5CYW9WRit4eTRiZDVQRFlkWjcwQUhVck5ubUZPdWxhMVIz?=
 =?utf-8?B?QmNuYityeGc2K3hxaDA0eDMxdERhcVBGNzQrNkd2WmFnV1ovSU90K2VPMXlM?=
 =?utf-8?B?VG9rNVkxTGUxSXJGaWlaSUU5NExCTWJpbFBRL0gyaklrUnFDV1JZb0ZraUh2?=
 =?utf-8?B?R1hwVnQyVVVCM2JUOWtvSFpWOHA2MExZeEp2OUdzMEdiZkg3SUJyY0Qrc096?=
 =?utf-8?B?OFgvT3JGY09xM1BwdmJLUEZxNlZvUHJJNC9lMTRTdTFhY0NMcVlZWE1aTng4?=
 =?utf-8?B?cXloMlJHck1EUjljMVU4MU1qZUMyZ09DeTNFRzkxK3dnc2hLaytMZzBTTlph?=
 =?utf-8?B?d1g2eU41VENLSFZOUkw0MnQ5OU44U2xyT1VJeXdJNzVVOFIwQmI5SUhkd001?=
 =?utf-8?B?U1YxZFR3RERxakpTZ3RPK2dZZXIzRFJYcm1KMUtLVFlEeEU5aWpNYmRPc2I1?=
 =?utf-8?B?UFRaRmRmSFlSVys0bHMvUGZVK0F1WE1ldEpMaEF0YXpaYkFLR3d4Y3FWeFBJ?=
 =?utf-8?B?NDdSQ3hEV0RjVG9TU0p5dFpRTXo2UXRUbEdXUzdpSHg2ekFsb3B0VVh2b1NE?=
 =?utf-8?B?Y2QwcGMxTlQ2THNyOEFLTjhXTkJaNEZTRC9XeDJVTUEvMjVTbVM1SXRIRi9T?=
 =?utf-8?B?UXFQTzMvTGh6QVBSZnluM3NPalBjTEVKdGtra2tqSzdXbjhsc1JMalhSWUlN?=
 =?utf-8?B?MGhsbnpCWEl1TUplV2pYMkFwSE9pS3RYY2o2blRLcTM3VEo0eHN5SkMyejhM?=
 =?utf-8?Q?lpDNW0I1ldUoHnZoyT0mrsruj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0309E018601D642A04F91FF4A520F5C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XQNSirbnGHh7gi6/GCgvnKhEI1a8hfz83mQBi7Q90lC2RqxibTErwaTusYjSQZL/SXErH6DVMKWAi+pc4+fDjuxjoUp8+MVU6SlgcZPpX4HhIv6vbsdto5qgtyImxxu5qJaBi//ky5agC8YxcOBbmcKT5+Z6fLfxOQ4Qq3XBirOBdIuJ+0iSpGdgk2kvs0BRZKQMPfxNpUlVCZjhjM9u9fYfKOE3jrH/PVJo0lvixy0Tnfw4ymH95GQ6mWl1dFVECGWQARkJwV1v67tU/JHMhet4hoHw1dd96R0XXppIlQtw7cJzncp1C8Fc2IURufs5IaJtJMCwlix0SlllBztFgicLLLfO94Qe4CgRVBMK2Q/qtQ+sBaXUJAkFljAte8LkoG5fKBZpBUH1YmkBXb5v7mY2gnvOROghgMA49muv3TC5Xru4NwM6A6o4V3gp0p+b8wxfxRMcmX5b23A9GGUJlP8CSRnIs3AG9t0MCHxSBwIlesCVqAC1hLzP0lTgIrDoqNSmeAOBmbUbYlp3SxIdMIvRssKg9PeaRdCRJQKhr2UlaG8vx2lGOFJVsCfDJROB0vpe+jbRGztCvXlsIubz8LWxNUUhgpXv2jCEzOl7YQ1NVSlASw41IWx7QzOGrvL6s1Ux0FtQb2cAp/g2EWgVFw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89211709-bf2e-47ac-6763-08dcd693f87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 21:10:19.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAfBM/mKSynBvNoHCG1bGXsrrBz/JNd7zvEFK5Ghou/6j05CAovrsAvqBwsOupyhhuSj2G5LBfpdzjC7RAWYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
X-Proofpoint-GUID: lciuGYXhRIgW1F4hofnNJNY0OVRDGljR
X-Authority-Analysis: v=2.4 cv=C+C7yhP+ c=1 sm=1 tr=0 ts=66e89ec3 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=xnuPOJFwmkTH8O7fk_UA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: lciuGYXhRIgW1F4hofnNJNY0OVRDGljR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=714 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160144

T24gRnJpLCBTZXAgMTMsIDIwMjQsIFJveSBMdW8gd3JvdGU6DQo+IFdoZW4gZHdjM19yZXN1bWVf
Y29tbW9uKCkgcmV0dXJucyBhbiBlcnJvciwgcnVudGltZSBwbSBpcyBsZWZ0IGluDQo+IHN1c3Bl
bmRlZCBhbmQgZGlzYWJsZWQgc3RhdGUgaW4gZHdjM19yZXN1bWUoKS4gU2luY2UgdGhlIGRldmlj
ZQ0KPiBpcyBzdXNwZW5kZWQsIGl0cyBwYXJlbnQgZGV2aWNlcyAobGlrZSB0aGUgcG93ZXIgZG9t
YWluIG9yIGdsdWUNCj4gZHJpdmVyKSBjb3VsZCBhbHNvIGJlIHN1c3BlbmRlZCBhbmQgbWF5IGhh
dmUgcmVsZWFzZWQgcmVzb3VyY2VzDQo+IHRoYXQgZHdjIHJlcXVpcmVzLiBDb25zZXF1ZW50bHks
IGNhbGxpbmcgZHdjM19zdXNwZW5kX2NvbW1vbigpIGluDQo+IHRoaXMgc2l0dWF0aW9uIGNvdWxk
IHJlc3VsdCBpbiBhdHRlbXB0cyB0byBhY2Nlc3MgdW5jbG9ja2VkIG9yDQo+IHVucG93ZXJlZCBy
ZWdpc3RlcnMuDQo+IFRvIHByZXZlbnQgdGhlc2UgcHJvYmxlbXMsIHJ1bnRpbWUgUE0gc2hvdWxk
IGFsd2F5cyBiZSByZS1lbmFibGVkLA0KPiBldmVuIGFmdGVyIGZhaWxlZCByZXN1bWUgYXR0ZW1w
dHMuIFRoaXMgZW5zdXJlcyB0aGF0DQo+IGR3YzNfc3VzcGVuZF9jb21tb24oKSBpcyBza2lwcGVk
IGluIHN1Y2ggY2FzZXMuDQo+IA0KPiBGaXhlczogNjhjMjZmZTU4MTgyICgidXNiOiBkd2MzOiBz
ZXQgcG0gcnVudGltZSBhY3RpdmUgYmVmb3JlIHJlc3VtZSBjb21tb24iKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBSb3kgTHVvIDxyb3lsdW9AZ29vZ2xl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDggKysrLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBpbmRleCBjY2MzODk1ZGJkN2YuLjRiZDczYjVmZTQxYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gQEAgLTI1MzcsNyArMjUzNyw3IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gIHN0YXRpYyBpbnQgZHdjM19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzCSpkd2MgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
LQlpbnQJCXJldDsNCj4gKwlpbnQJCXJldCA9IDA7DQo+ICANCj4gIAlwaW5jdHJsX3BtX3NlbGVj
dF9kZWZhdWx0X3N0YXRlKGRldik7DQo+ICANCj4gQEAgLTI1NDUsMTQgKzI1NDUsMTIgQEAgc3Rh
dGljIGludCBkd2MzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJcG1fcnVudGltZV9z
ZXRfYWN0aXZlKGRldik7DQo+ICANCj4gIAlyZXQgPSBkd2MzX3Jlc3VtZV9jb21tb24oZHdjLCBQ
TVNHX1JFU1VNRSk7DQo+IC0JaWYgKHJldCkgew0KPiArCWlmIChyZXQpDQo+ICAJCXBtX3J1bnRp
bWVfc2V0X3N1c3BlbmRlZChkZXYpOw0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtCX0NCj4gIA0KPiAg
CXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ICANCj4gLQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4g
cmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2NvbXBsZXRlKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gDQo+IGJhc2UtY29tbWl0OiBhZDYxODczNjg4M2I4OTcwZjY2YWY3OTllMzQw
MDc0NzVmZTMzYTY4DQo+IC0tIA0KPiAyLjQ2LjAuNjYyLmc5MmQwODgxYmIwLWdvb2cNCj4gDQoN
CkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRo
YW5rcywNClRoaW5o

