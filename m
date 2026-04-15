Return-Path: <stable+bounces-238003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W11mHh7u3mnTMgAAu9opvQ
	(envelope-from <stable+bounces-238003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:47:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD33FF8B6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 393E2303A248
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F42367CF;
	Wed, 15 Apr 2026 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ck4njtu2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ar1Bh/7T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fZJJMfW/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E103FFD;
	Wed, 15 Apr 2026 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776217623; cv=fail; b=ejc3HPRixWs28O6hYV2qBR7GQIFl3fr4qIWxfHfVURSCeHOI+nlv58E+jNNuXY0IeocixdngPpP+lqnH19J9VcGaLXdgewyRND1ISBmSDNMUZwySvX7oK3cP98tUUg4UZQUmz+fk8NvtXkLY3OJtoeOrMSbofRcL80WBxBnvDC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776217623; c=relaxed/simple;
	bh=mJ32NRYpk+h0bhFKpjR4rFAQS0F99/7aqCNOwSrtP14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRPkfYh2dZdSg39DkoSu4BhyNnjJB32EIRtgJstvMXjrkS1Gg0Bqvg7Y+cTNoq9lQuxTwQmRXNxSj6nvwHG0G6uUmYXafjE8kAXrO9wEf0X0LqOJ353k84MF+o+7T4YzzKNzf3a7TGQcRhzLcSF0j3TIdIJkY8P7kNAOLKQIqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ck4njtu2; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ar1Bh/7T; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fZJJMfW/ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ELZCJe1569560;
	Tue, 14 Apr 2026 18:46:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=mJ32NRYpk+h0bhFKpjR4rFAQS0F99/7aqCNOwSrtP14=; b=
	ck4njtu2H2+wN7r9USEg/x1dt3MKOvb1xwwyKYub4FlAg8Bk4lzFZKLERR/TaooI
	pSPIm7w7Y5h7/HLDhwUsLlFtaUloblj5cs1dTyvCZVfZqsNVF3mn6sbWgZRvvJuY
	dB7VQ3GLmpbqrqsQPOC84MsW4rqtjvb48CxOZYlTjuNhUKXgRfZbcc8IpjX9jExW
	V5Mtfksnc5zfDMEV5UrMgyx3rWQmDYR+tbbY8AYnwQI4KzxIaXDKqswXkrT67hO2
	83m96DLaXVBgt7vmkEq7lqRnuTACQu98GaOsJtvXcBNF7mTnNVPmJSNzZoJaVGyB
	rUfhU7sT0kQY4f0IpOGfwQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4dhrgg2ypt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 18:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1776217610; bh=mJ32NRYpk+h0bhFKpjR4rFAQS0F99/7aqCNOwSrtP14=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ar1Bh/7TwxsfhXYCEXAPZZtYzbQBPoRmPFo5x6u7EM9hQz9O4EJveceEew8RSwXc4
	 afhmemOpA/xbKkCsvsnj7NEr0R///bIayOuPhzzVwjwp/HK9pw7w7hoqdIuEBJfyaJ
	 JgaB/zyFz2S5m7DVA6G1del9wnmqSrYy6rdryZHgHva1U68Pmh12Z/AQxY2T7HsaFY
	 B7SpL4KFNHegsXwt2rLq3NVTHuON0UNb9T2twYQrV3jjh2mvZ1TRvlTzY11LjJDjVo
	 Q6G7YdcFX+uyR/1a8csDgaazz8pmdrBFhK4NWnWc5eCEbsPHo/4DiX2AftD153PUjX
	 tD9ft45r44fHQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5F9C3401EF;
	Wed, 15 Apr 2026 01:46:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D50AEA0086;
	Wed, 15 Apr 2026 01:46:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fZJJMfW/;
	dkim-atps=neutral
Received: from DM5PR08CU004.outbound.protection.outlook.com (mail-dm5pr08cu00403.outbound.protection.outlook.com [40.93.13.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 660F240147;
	Wed, 15 Apr 2026 01:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnJ1GIG6YUp+o8vXbWg/PMjWlhjpGpNZ52ge+Vmj7lqiEXh6BaZpBIEhY0+cH2YkWskuq4X1MOLS+yKnweiimb10g4L9BfjLIL2Yr4ovIUAecFWxTkeKqdx5+0iiNeckAUYXL9En/fdfYFWMCJi4flYiUTYg5nDWUJCTMGHhE1C7WepE5tqQMwiahbiCvJLwBAQVJp4ZGgI+SxQQ2ndlxh+ZicPR5txFFaIHWNfjox9RPYl7gpi6V13HyfmZT4J4FalnRmauzwuGgZFIjy6jiGE7JqMbsY7Xv69huz7Swy9d78SvQyKxqccHaY9n8iJ3C60Yt2d5sfciXJdi0kjxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ32NRYpk+h0bhFKpjR4rFAQS0F99/7aqCNOwSrtP14=;
 b=jzAjqIgZ5sP86Hpn6jKnYHmJbwzY4xn3UGnKz4jWljOxHesIOvlV4esGsVlZflR/1sMN8nCh5Uvn62j+4csSf1Jn/cGwZakIKVc2fsGSct+xU8o/iJ1uZSwOaITMI9M7f0oAgqMaygI3wUGEmCqx0jyv0CXvoKRWIQBvydT64xwBrIwl+GhN/FOwnSj1L3bwD9iDKQA3OvccdKr+eFgbu/a5tr36q0Pv1rJgu2FIpmtEnjJ5VfCWWDAxJJy55q3UivrboCxEN1nykI2gl02GawdaSFWFJ7aftIFiSbBfIFq4FniBIEzkb2e+ZWPrLVR/lifBwXuoQDy8oNb6kLCefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ32NRYpk+h0bhFKpjR4rFAQS0F99/7aqCNOwSrtP14=;
 b=fZJJMfW/69DDHjLL2zYMyCFYzVVeFWV6hE0crNZwZKLuhd/4Qgm+pRKRC51y/4X0hnSC3JoK4vB8gCDQlg0bQJAgkX1xnGDR+N11iJI0YNP0IiqrT7eHmv6OAWNruO0BoKYtnGKwhOynwRK2fdnnrnjZorXrDo+P8yOgKV4zEV4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 01:46:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 01:46:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paulz@synopsys.com" <paulz@synopsys.com>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pritam Manohar Sutar <pritam.sutar@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Fix GUID register programming order
Thread-Topic: [PATCH] usb: dwc3: Fix GUID register programming order
Thread-Index: AQHcyLgQyzkLRpw34UCOsx3EE2u92bXdxCUAgAC4VACAAOVnAA==
Date: Wed, 15 Apr 2026 01:46:44 +0000
Message-ID: <20260415014620.mjmlt6w3ttlzosr3@synopsys.com>
References:
 <CGME20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec@epcas5p4.samsung.com>
 <20260410064735.515-1-selvarasu.g@samsung.com>
 <20260414010532.sxciijnzak3ldw35@synopsys.com>
 <d2be3f54-5375-4f1b-ab4b-e2ff81c43630@samsung.com>
In-Reply-To: <d2be3f54-5375-4f1b-ab4b-e2ff81c43630@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6128:EE_
x-ms-office365-filtering-correlation-id: 8fa3013d-2b35-4e25-e32b-08de9a90d95f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 AYXBOk5KWZ1DReQ+pbqYuxCDrbdHf9p48JG8cjD8JJqTBZVClYKG2UD7YPadkyTl8TA6d3pAEPEmfL9pAxmYFHUbxZ4muUbI7vZW/4lTRNOoYPPna8XR2sxMPFBE5Wjc8aRTJSaLZHarfQHnG5R2mBM1InwmzXPFJ2CGWPSN04kQBcBmHcywmgvtECgIXG5wizkCWj8ejc4NAhlu1WwDlFExg90u8zSmET5FMXJIKZ8Ss8wd4wVD2rMRI1BofFD8Vv34EfrQo8J/aOLKXck/6WUKkMRWDfikpIubhJq7NNG6hyT2qLD/giHMKp6EDrvF9O6jb6rGMfQmynHXVTxkAU5ZduW7ptR72j5IREV/CKX+RU0rPIhM0P98qR/LSteiO86oTGclaPOUZzM3S42nexvt5zAVJTZjB04N0F5A2o4+P9zBPIVi6c+YMxL04eITQg4XWu42IcbHXsNRX0aN639UMx1d1/dAIFBNWSdJCD4aNyrh/uaC8WzeWon7vV1gm40GKYsM0t5SnrEtvT6oRSFFCSYzWB2AL3FQjfxQtVJdTnGmLMUgePffIzLmyBWQBanDZwC5OlZJ6R/gzv3ipvlgAFBdjn1Ca1JTyZ2NXoLMr92lBenRakRKDuiBE+gmiZjGLa5F3unrwZHxcm/T+rv75MWP69uZRgwqbXmz8ApamuJCCkKpkdZ96jZ2yIbuYK8DU1ZPhVzWcTKoACAoMPadOOzdk7VoMNZE7n/dtf/lBb2IVxN7SEqsmkD/DS7/tnrVqbODPWdm+xdI4cFY0e2+l88Ubz0vt/VIFPsKujA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjRFblBNblhNc1lwalBTb0NaN01ZQWdndUlIbFdYeHZVUklpa2hIRU5BSDdL?=
 =?utf-8?B?YzNUNkIvRFBFUlVYd3ZNV1pYNWhia2RzY1pvMzNqSmVaMjE0US9idG04N1Zm?=
 =?utf-8?B?ck81elV0KysvMzVON0dDdEk4SGpremsrY1pUTUkwNm1Fc2k3dWt3MUJsd0pK?=
 =?utf-8?B?RWJKN2FybUY1dGh0YzlMRjJXZHVsSlpTRjZsc0V5NTZNaEhzMWpIUGIvZExv?=
 =?utf-8?B?VVZIYmptb0taeWgvVFdlNVRtb1NUbkl4N2srTWhJRUxGQlJROHgwS1d6ckRw?=
 =?utf-8?B?UFA4NlBPeVplTzZNeGlHTHhoMFhtVzNpTFFVWGpTZjFoeGZHYnlGVlFkbklJ?=
 =?utf-8?B?N1JzTnNnZHJNdjNmdWFMa2pybno2UEYydlVZZW1mUlN5SDVsTEEzVUwxM05j?=
 =?utf-8?B?Wi9BaXc3bkNpRU0yZ1pLZ2RpdU5iMWxRTll3TkRrSnVYWWo4L1c0WWVqbFdG?=
 =?utf-8?B?NDdEWHVJVzNsZXBhbjBXNWp6OUNxZm0vY3pWMlhzcVB3OG5SbG8rMjhkWkVj?=
 =?utf-8?B?eEprTWJPRlJaM3RGdjZRbklxVFZJQWdXZkVybmR2NUs4V09GMnBWWU5lL285?=
 =?utf-8?B?SFNRdmlmbFJoQ0tVNWFxZ1FqNUN2OEJnY3N3OGpoWGNwMU9RaEhERUJTbFRq?=
 =?utf-8?B?L29zZEpBTlNXb0ozRUh3S2pvZnJja1NudmJ3RXJ0Y2tqVTk3NGwyYmVXTE43?=
 =?utf-8?B?c1RvZ3hPTG1GcG0wL29jM1FRWXllcTM2eE5PVnhkTXo4cDBXQ1JSKzNlL2RH?=
 =?utf-8?B?SHV4M3FBR3hZRUs3emp5WStRM3JMNUVHQW44bVJTUnZEWDhJTHJNeS9Pc2Zx?=
 =?utf-8?B?L3hOQ1pzeXJWdzY4Mzk1RHl5RWhNOU5ER1Q5aHBuTHBxbWxrdEQzS1JDNmFW?=
 =?utf-8?B?eDFhbThPVTY4SHVldjRpTXV0Nm4remFYSzdBb3BPYVpjSEwvZEZnZW1YZWZO?=
 =?utf-8?B?T05tbXF0c0RoT2RwbFU1V2Fmdlh1dEQrdE1pYThPQyt2cGpMVVZQUWRxeldz?=
 =?utf-8?B?QklJQWxURExrNmQ5Q2ZPOS9MT1JMZUREb3ZFdW12eXVxYzByN21qZXNWS2Fo?=
 =?utf-8?B?Nk1HR0NWMk9SSmZGOHJ0em1kNGZQQi9ONTFVVGppV1lzZEdiODFLNmczZy93?=
 =?utf-8?B?dlNPU1BnUlppbnJxRlFya2Y5RVE0S2VaZTAvc09QTllWeVJYV0JHRlZlVEoz?=
 =?utf-8?B?TEY4Rk1rTTlFbFlqR3h0cHZxMnR1S3paaTJBZUdINWkrRjk5b0hUWWlxNzNR?=
 =?utf-8?B?c1Q5MW1pOWJGV0dzNXMwdWVKRmpoRkU4RUtDcVQ2MXRTckMvQ3hXTEg2SzUv?=
 =?utf-8?B?dEw4WUdKOXd6bERCejdpUVVPY3BNZzF6eHdnb3dNY0M5bTRGblljMDk3RXFB?=
 =?utf-8?B?RFRHOTN0aDU5ZERjWDVxODBtYzBiT0FpNHhpbVovRTZmTVkrTXNIbUY3c0Jz?=
 =?utf-8?B?Qmd1cC9makg3SWhuQWVWa2RsRzdtcEtoU0lITTV1NDczdkNQU1dZck5yeEM2?=
 =?utf-8?B?RjF6VzN5Z0dxOGNVczJZd3RIUGFIYkxROG1MNFZWK3FidE1oaFZ0QXRPczFC?=
 =?utf-8?B?UkFyWGpvVkxGTDFvQWFuMW1odUxWL1dKcy9jZExCQmRRNi8xcjdVUmp2Y0dB?=
 =?utf-8?B?enVzcGtJcGNOYWg1ODJPUEkvUEN6MFlrSWZHMWVzWG1nMC9neTFxa1owS2RR?=
 =?utf-8?B?U1JtNlc4UWVMUnFwK2IxQWhUSXZQcFc0TGU4ZTlSQ2RxYXhYVlFOQW9VTDcy?=
 =?utf-8?B?aUhQVzI3OVczWnJvZjVLTlFEbGE1c0RhOHZhYTZBY3dRb0lmeEg2Nm5LZEJE?=
 =?utf-8?B?OE5nNGdWaU85Ym51eWk5RWZkbk5ON25UczRyOGt1akRYTlpRajhnejlNMEJs?=
 =?utf-8?B?VzAxa21Vczdib2FuV1ZmOVhNb3haWVFERkUwaWdlTFg1bGk0dmZQUzJ3dWdT?=
 =?utf-8?B?QUQyYnNmOHVMZXVDdGRTTE9IZ2JYUi9LUjRnSzgvVlZaU1ZXeThiZjFFOGJG?=
 =?utf-8?B?TnZjNHhhVWVPZXpvNVBlcEhHQXdVNGppNWgvZWYyV0dORXpCWEUwTW42Q091?=
 =?utf-8?B?SmdxRElMbHUzYVZ4UkdBTll1bXppNzNyL3RvcUNtamNWcDZNeVFZRXBJb05v?=
 =?utf-8?B?czhOckFDbUhwaDB5RFZFN2p0bEh1SWozL2lJWU9TVW53T1BmK1FSSlBLRC8y?=
 =?utf-8?B?YjdTeXNqVFM5emxxaVJkK1lQNFVxY2FqOFcrL2g4OWNXT1doSXZLRWV6Mk5Z?=
 =?utf-8?B?M01BYktLSEs3K2R5VW1CODhYdVRja2VxVXEzT1NKTHJ4a2MrTFFRWDUvWE1z?=
 =?utf-8?B?QnNuYnlmaHJLbzRiT0hpTGlWd2d5djYwVUM2Tlo2S2F0bk9CWHlGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF36F8E185FD9C48860BFE832BEB95A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	E4DSbBP0Kdbo9+3/k7FqgU+iy8Hv5nUbHkMdjAKJo+f3+/XgsOQnkaRbvSrK1zBbyBHNCP3K6j0i8jIxLx0YOlscQLZjoXxUgQC2ReBcKCEshilY6NsOYLDFHIiq/H1rLL2WXPAp1QHp/Ew4rQb6V7E4qD8IsbF3YtDWAEwK5sGvjaqOKjJvFOl+YgWaTVv7bPXTUA2poo4CDQlCN1+1phItWn4EamB2OHKRjsGEGzzSDFO5gEfid01fTXZ/jEXKlbQV5JlRIwxE17P0P2RezxBcVCBPSk/nyoRRTU/fZ9Xjdo/OmGAAsfe7g3wLZFYESPEbpSwYNdzcq076dG0mvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6t2RMW6WetyNYXi1xqHaOwgBlfAy+xlEL+gow+nUmrX944BEZ7EiBuWhERro1jjknReUZTcCl3VGOll6o0+dXfMgA1muW2+AB4Hx+iHmzRVST4VKTevJ615z5SyuXhD6pwXDttJwxab9iSi6HHteqq1MuTTsUQzt8+9hGMR+/xoRGRHruJbM8KliHwO7Imfd/DrSmHyXHtnbWAFvg99B68WBBVS+k5GBlgoxs6B2Mo5Cfik9yThgsPbhr12HXwWdMQase2ZUNaEroTFEdhct68+C/9e7ihcNi6hDYRTgBvDcFEO9xJFj+UpBXHTtrdimrrcYfvzfQsrUPSvJjFB5Ywo9xWncJix8kEpzNUd+9Fu5cTj5MvpgNKNDeEY5TAReFwJ+2Xdj3WZx6IAYKlJMY4d4G9upJBsop+MEfETw5lBlwpUVXg8LRudf7hU6YVyvApEOhlFxtTSMplG4XXsjX8ygKRD2Y8SPUxXwGHI4A2YjHLYEXbMW5PQXYn9zdgLNr2jurd0KxB7iosnaYZaRNY16TSLibOsEwiK06FL3RRHuQTeitoK3cm3J21OR3Ywx9zUq3idvKWr/4N/9k1SE1RIeCnTt7DA9gcKxGbSjS/L4wsE/fJ6ZaScuy056t8DjWh1YwA56/1QDIERLDvdQuQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa3013d-2b35-4e25-e32b-08de9a90d95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 01:46:44.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cl06DPdYOVrX5CZNFDhSrrX6YLMUItXFU3QMNkgmxNtCsjSvIC4cSMvb0saaebk6Wlvr0RVBDMIMQNxH5eIIYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAxNSBTYWx0ZWRfX9I0p8Wg7ppMK
 hzEU9SFneQsA6LOP1Su5Iut0M5Ixk2Yfdrsvl1RwFx+DypnW113ygqpsHGBukPj89W0h+5TxB6H
 lMuH7bmJd5dGBMmpXPvOv8PZNHymJ5tBtg70Ym2fqpFY3k2nNmdGQzdXwNiUD97aAg3sHD/S5cl
 vhAgeU0jxBP4uw9CrwORfWSIJ9XX9pMMxuEkAKD5WWTzDFUNmaePzR2C8H4HCKFASOc4ihN7JUn
 thsvl/0y5scBSPAiuVZSTMDRqW+AoP+2w8DK7JVQfJPlcwtGWF5Mhm/FNcdh28f7QmRxOFULP99
 PAhxLYFLqf04lU5+49ipXKpsplt+EGOoFmMM4DyDwkmSWuKe1+aHeuCaQKxEnd6A5WYJNcJ5BBc
 Bb4UpwPCF1zm36hjz6077dujctoLy4mHdz7mFkLd3BIlDRKLbZcblnqI2IISTPxYpgIZ2mWBetZ
 lw+pVit34vGCXMtAL2Q==
X-Authority-Analysis: v=2.4 cv=IL0yzAvG c=1 sm=1 tr=0 ts=69deee0b cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=Wo6YDfOMAEstGd-0DxeT:22
 a=TeCNwIoEEVl4AaVS9v8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XeXYLO1zmgbNK6B62J2SzAZxoEi7txAL
X-Proofpoint-ORIG-GUID: XeXYLO1zmgbNK6B62J2SzAZxoEi7txAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604070000 definitions=main-2604150015
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238003-lists,stable=lfdr.de];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_MIXED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BDCD33FF8B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCBBcHIgMTQsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
NC8xNC8yMDI2IDY6MzUgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBGcmksIEFwciAx
MCwgMjAyNiwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+IFRoZSBMaW51eCBWZXJzaW9u
IENvZGUgaXMgY3VycmVudGx5IHdyaXR0ZW4gdG8gdGhlIEdVSUQgcmVnaXN0ZXIgYmVmb3JlDQo+
ID4+IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KCkgaXMgZXhlY3V0ZWQuIFNpbmNlIHRoZSBjb3JlIHNv
ZnQgcmVzZXQgY2xlYXJzIHRoZQ0KPiA+PiBHVUlEIHJlZ2lzdGVyIGJhY2sgdG8gaXRzIGRlZmF1
bHQgdmFsdWUsIHRoZSB2ZXJzaW9uIGluZm9ybWF0aW9uIGlzDQo+ID4+IHN1YnNlcXVlbnRseSBs
b3N0Lg0KPiA+IFRoaXMgaXMgbm90IHJpZ2h0LiBTb2Z0IHJlc2V0IHNob3VsZCBub3QgY2xlYXIg
dGhlIEdVSUQgcmVnaXN0ZXIuDQo+ID4gU29tZXRoaW5nIGVsc2UgbXVzdCBoYXZlIGNsZWFyZWQg
aXQuIERpZCB5b3UgYXNzZXJ0IFZjYyByZXNldCAoaGFyZA0KPiA+IHJlc2V0KSBkdXJpbmcgcGh5
IHJlc2V0L2luaXRpYWxpemF0aW9uPw0KPiA+DQo+ID4gQlIsDQo+ID4gVGhpbmgNCj4gDQo+IEhp
IFRoaW5oLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbi4gWWVzLCB5b3Ug
YXJlIGNvcnJlY3QsIHRoaXMgaXNzdWUgaXMgbm90IA0KPiByZWxhdGVkIHRvIGEgZHdjMyBjb3Jl
IHNvZnQgcmVzZXQuIEluc3RlYWQsIHRoZSBHVUlEIHZhbHVlIHJldmVydHMgdG8gDQo+IGl0cyBk
ZWZhdWx0IHN0YXRlIHdoZW4gdGhlIFBIWSBsaW5rX3N3X3Jlc2V0IGNvbXBsZXRlcyBkdXJpbmcg
UEhZIGluaXQgDQo+IHNlcXVlbmNlLg0KPiANCj4gV2UgYXJlIHVzaW5nIHRoZSBTeW5vcHN5cyBl
VVNCIFBIWSwgdGhpcyByZXNldCBpcyB0cmlnZ2VyZWQgZnJvbSBvdXIgDQo+IGRvd25zdHJlYW0g
ZHJpdmVyIGR1cmluZyB0aGUgUEhZIGluaXQgc2VxdWVuY2UgKGludm9rZWQgdGhyb3VnaCANCj4g
fGR3YzNfY29yZV9pbml0fCkuDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3QgdGhlIGJl
c3Qgd2F5IHRvIHJldHJpZXZlIHRoZSBjb3JyZWN0IGxpbnV4IA0KPiB2ZXJzaW9uIGluZm9ybWF0
aW9uIGZyb20gdGhlIEdVSUQ/DQo+IEFkZGl0aW9uYWxseSwgd291bGQgaXQgYmUgZmVhc2libGUg
dG8gdXBkYXRlIHRoZSBHVUlEIHJlZ2lzdGVyIGFmdGVyIHRoZSANCj4gUEhZIGluaXQgc2VxdWVu
Y2UgKHRyaWdnZXJlZCBieSB8ZHdjM19jb3JlX2luaXR8KSBjb21wbGV0ZXM/DQo+IA0KDQpZZXMu
IEp1c3QgZml4IHVwIHRoZSBjaGFuZ2Vsb2cgdG8gcHJvcGVybHkgZGVzY3JpYmUgdGhlIHByb2Js
ZW0gYW5kDQpzb2x1dGlvbi4NCg0KQlIsDQpUaGluaA0K

