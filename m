Return-Path: <stable+bounces-208205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64790D1616A
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 01:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A3BC3016EDF
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 00:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC823D7DE;
	Tue, 13 Jan 2026 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FFl5xFph";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LCK/85oX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mhlKVAid"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3920241690;
	Tue, 13 Jan 2026 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265579; cv=fail; b=n4P3FS4CgyFjPN3ro3FBhsu0fskKuMdyEU2ywzVUgtEDFAH6NZABzRQeIHmk9jL3tplDmydxh7aorq76Wb6HbHmlA0k7yoYUJ8sw9JmxGOO44m1DCHcs4y4VeCpQlK9jrlLjhn9RCcAldN/spKF1etjd5Bl2vUepkfMNRu2qouw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265579; c=relaxed/simple;
	bh=QPJAOX4MfyW9ZICrhXYSyubr5riyys4kwrvtmo/3C6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ReC4MqIBiy4DO4vtmOU1SdLlb2ksDnlNQ5zsBiToVRXmeA6vBhHwHcZBZmaZfpnmvGWsJSqdq9gKqT2YjN7ditGq2PLzQd6RLVH9bXg9Voj+zYCnLkkIbUUi5olzw8/XVnlB5KmbNBVu0f9OpuPsyrI7ww6mv1/eMTdQZViMDFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FFl5xFph; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LCK/85oX; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mhlKVAid reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CKGVHN3836888;
	Mon, 12 Jan 2026 16:52:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=QPJAOX4MfyW9ZICrhXYSyubr5riyys4kwrvtmo/3C6g=; b=
	FFl5xFphyUeZIMeCd8LsJENDv0y+5JMKs9dOPGodjGUXwgRub42CbhijEH0cuKvM
	KH/jrxgLhMfTL1Khs/GmsdkQQ2mYdW8fPKQNReyxRb5Ys8156apFA2TD6vFffIdw
	R6AnHJoHu/aWytfxD7/tROlUagfqKP1ZfLYvLhW0gvmzEhastkOMuL4AOZzq5uGo
	pnrHIcHl7aH8SalYvnNDbLB6I/KSIVDUqmXhEio2+qr3cO4r9bt+TUcXPWMyWHXp
	GUYo+PkA6ITDZxqyKDFaN3881g+pTsfgYJ1VoLvM5NpzP6ZBr0WrVflBaoYVm6DZ
	yKHRAd0LK/voQWiVVS+7LQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4bkpnq8sv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1768265548; bh=QPJAOX4MfyW9ZICrhXYSyubr5riyys4kwrvtmo/3C6g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LCK/85oX/3+YEyWz3IfvXSpGYbGH5NAnIJ7eHwK3WxHReRbLc5/R0JV4i5qYvecAe
	 glufViiYrO1lopbxFP5ZIlYPGD2BhqWJ/wxerDRmuTqBeQufi1eZiebEL4m4BWLK/Z
	 OTOEMjoKo2ho7Yz30wXvqkCh9pvAcMSyaGm4biZvlLivLD+/g4LKNMggJ1I+mLwgYW
	 sJNzdHifdry3WlpiiMWmg6ve5y6x0P/eCGYDiFFtnK9pQS+cmOISnjP8Bst6sCupu0
	 DiDbMJO3ihn7/xH8mZhbR/6jaIeFgyW8zvchsPy/wZQHKXhRUP8ipGwBcU22X0E+22
	 iU75F7qKvWiWw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F53840124;
	Tue, 13 Jan 2026 00:52:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1897AA0073;
	Tue, 13 Jan 2026 00:52:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mhlKVAid;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00102.outbound.protection.outlook.com [40.93.6.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B83032201AB;
	Tue, 13 Jan 2026 00:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS3OxH3EZ/aNssJXh5u893wHYJsiBOvIulnJ344hHU0/jHY/2Q8c6yjaARkfB6rmYfHsRrBN06uKjPctJDegWN1WRuLjKaCKLroWwwlHqOTBVhn6bwpWScOWTcPDrhhEbkHbHrDVptX8Gf0N6utJkGL3yyY8FPuZxYwMdadgSqDI/2vQP3LZISQZGYdaC9ZrUMo0ohB/icxTKT0+uGwKp3F2LolNH6A2TgY2VAfJTntikhwUAehxGX6918skLjM4gMSS4yjOFoqRHG34zdNj3uYQiXJnIcAAWHUoOLDRO0yeCF95C65vPCD5an+Vti6gnzVozf3FRkPs/qF1HVssyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPJAOX4MfyW9ZICrhXYSyubr5riyys4kwrvtmo/3C6g=;
 b=W3rwc6j37+5GwTXdlGBLkQonSsx9Duk9RefAmce2wV8iSc9I/DKi9vR7ksLqTvPBhLvJGd9ssEFqOiBw7FjQWGE/fKPsyy/aQQ9z7Okg8NNsqSBN1Ou88L6ZQze0OOrKvcWP1nZ+CI9HV/3KhlAjmWH9QmYArG5jsYkX66OvKrwdsMteap53s0gC8K0dQDk67QWX9s/4ddITIhv66MWaCLcl9wKwgdR+uM/wY4Fb/SD/KLt+EbRL9oto0UAxU4PBktFPMuq8uJNSZQXCyZ8cE3koqLxZvxxaRdLE5xwtJuB7eJpJqC5MSNJmKXK0C2W+LBoRVS8pAjIWMiEm5xmzRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPJAOX4MfyW9ZICrhXYSyubr5riyys4kwrvtmo/3C6g=;
 b=mhlKVAidcBmVX1iDHCOH+VLby/yXJbjvG03yiaJycZo7sG2Raf2IqIIUbXgDEBmpfl7gcvlt/dlHOS7evCXnYmvCuRZYXpGRjPwIU4mO8Wq4j3Vs1KBeaamlRgr20OFatp9rpienJ4cmEQ7AxX3GMwt493AlD59Y0z+qfqTvmOs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Tue, 13 Jan
 2026 00:52:23 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 00:52:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Janne Grunau <j@jannau.net>
CC: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: apple: Ignore USB role switches to the active
 role
Thread-Topic: [PATCH] usb: dwc3: apple: Ignore USB role switches to the active
 role
Thread-Index: AQHcgVCxbW4cO8qyLk2+4LnTwDCxtrVPSx2A
Date: Tue, 13 Jan 2026 00:52:23 +0000
Message-ID: <20260113005221.kwl756dt3bpfelnb@synopsys.com>
References: <20260109-apple-dwc3-role-switch-v1-1-11623b0f6222@jannau.net>
In-Reply-To: <20260109-apple-dwc3-role-switch-v1-1-11623b0f6222@jannau.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6637:EE_
x-ms-office365-filtering-correlation-id: add0d215-bc75-46d6-bd0d-08de523e03b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yjk1ak50bldhS2M3alBFTEZQbFBlYnBlZkJ5dW1YQVo5UldCOThOd0pmYms5?=
 =?utf-8?B?dSswNXk1SVMycnczZzhCWFZOS0oyYU1GaGpZbFVReWhaVmw0MDI4NUFEVXRy?=
 =?utf-8?B?K1ZRRE1BZlRLUllRcTh2MFZmWElTS3BYV0U1MXpBMHVhUldTSnJKQTVNQzNv?=
 =?utf-8?B?QzNQZDEvTUd0YlhTUnl1WTlMOXMyeDV4Y3pQK2owY09tOXdQbGozRm9nQmxI?=
 =?utf-8?B?OXpSQXk1VjN4M1RBVGNmMmw4WkoxanE4TEFhWUVRRThpZlRIVlJMZGY3T1Zp?=
 =?utf-8?B?aHZHZmNkL3JUQmdlcWJyZ1hJa1ZvWXNJU0k1dEhZZVpGak9uZWlaampVSGRY?=
 =?utf-8?B?OWkyQXVPbFpVODVPeUtBUXpBZWgrcWRob0d0TFd1eWhzcEorK09yeWRxMlFa?=
 =?utf-8?B?Z1hsWWVSck1OcXl4TjFaUklPWEtlMXJkVHMxQ1BoRlhzMkNYSW5WaDNnRFd3?=
 =?utf-8?B?ci9HNUpuVHREVVBDZ3VyMUNkRklaRXhYWUQrUWltbU12WDk4cVBqMk9CUFBw?=
 =?utf-8?B?ZGhMbjVYZ3BiVlZUM0xVRk1YU2VoVlhWQmhmZkJvYTFrbTAyaW9UYXIzUEdL?=
 =?utf-8?B?a0FHWTd4V1c2WVh2L1VZTElWSlNCSXgyUmRCMmZFMFFHUUZHaGduaVoxNVBi?=
 =?utf-8?B?ZXlmVnBRaDB5cnhSN2JHbVM5dXplZFZDSU02NmhYUHhOSm1KcHZQeEpGTyti?=
 =?utf-8?B?WnNNRzRhVFp0eVBlcUxZQS9iNWxXcU1XNExYM255Q3RUUlJnVDJScXhzaHdV?=
 =?utf-8?B?TmdSbzJQUTBhbXNrS2JObHhlVkYzOS9nS1E4d04rTisxSjVONUpWcEo3UWVp?=
 =?utf-8?B?eklzRXFBMWJwYWRJYjlSL3RHSzNNZk54cS9lQ1Z1UDZ6bzV2YnB0MWxqbXlG?=
 =?utf-8?B?L2VqUElybXZQWHB6TEpVV1pQYWRtVUM3dnp3ZGlOMTRhTHZJMlJ4ckJ1b1o1?=
 =?utf-8?B?czRyeUlHUzYrQnVWbm1la3JXNEZueEp5eVl2SkNxVnZlRk8wUXJ5d0M5Mlk1?=
 =?utf-8?B?WkdrUHNPYUZnSHFxS0g1amlOeEluTVJJa1hxWTM5TVdtUDdhc3lWMjVseVFm?=
 =?utf-8?B?Y3FtNUhLbGRkUkd3Y3V1UVRVOHdueWhiZXN6RitHQm91aEEzTFczeXo1WDFm?=
 =?utf-8?B?VDhJL1RObVVwdXFveUF1OGE3SEc1OW1IcGc2UnU4a2t3UnVST0MyRUpZOS9B?=
 =?utf-8?B?bGJUNUZZWEFpSXN4cUlXSTRaUGdIa1lLbU1hNWdTSGltQjNuNUVzVEcxd0dp?=
 =?utf-8?B?WGYrS0VPaHdFbWY0aUJ2ejFKeGhuNHM0U3RsN0cwcW5wc3l2QytlQnhodWY4?=
 =?utf-8?B?TlpOVERaYnVXSkswdGYwYlNzdzBscWYxcXYwLzFIOWtjcjZjeXR4TFk5TlVH?=
 =?utf-8?B?T21ZazQwcVV0UFJCQzFPWVV0bUsrNWxGdG5WU3FkcUlDRE1ZY3RvZnpZZlRq?=
 =?utf-8?B?SVdsMmRQWFo5SCtyeDdWRlBkQlIrQ3JINUNxUHlud2lLaTY0bTEzY1JOVVpu?=
 =?utf-8?B?MTdGNEZYYUFxNUJJTnBoV3IyOTRxVDd1bnlZbWxFd2o2WVF4ekNuaFNSZkNy?=
 =?utf-8?B?aHR1Zi9UZnYzL3pmbGdoeWdPQW42M3RldGdaZC9ONXE0SFllRDV3TEhGR2dy?=
 =?utf-8?B?M0RKdGUvVDIrQVh4SUJieUIwT3NVZStFWnFJMkFsdGNXYUhOZjAySGwvVjJn?=
 =?utf-8?B?ejNnUnBxRjMyT0FYV3dncXUvTm1VM1VmcUN0OW9IeHhpaTZkcDlGTll1TFgv?=
 =?utf-8?B?Q2l3cDAwMUZna0JLaWFObitBcXBKT0Ftdm1lMFMxNU5IODBlSE5EdWJPalA0?=
 =?utf-8?B?UVNqV3cvcE9rcFhmUGkwOHhteS9yY0hBWWJXU3lTN3dzSEhXdDZsenUyRUl1?=
 =?utf-8?B?QzJ4Y3VmYU9FVWFrQURLMDRpVnpmeXUyOEVKV0xSdlJOUStmYXZzMHYyZlpO?=
 =?utf-8?B?ZFFBaDhSeGpzK01yTThFanp3Rnl3REtPREhxK21jTEU2ZkpDcG03Y2pvWC9N?=
 =?utf-8?B?TmhRaUtoWDNmdEJZMkhYMGxSbk1pRncxQ3hvK1JGKzlWTytpZUhTVzUvTHAz?=
 =?utf-8?Q?4B/GKd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDdPUnFLQTBJaDBkdmwxczR5cUd6bkEyb0lXV2svcGpWUlVNSkZ6VXNGYkh0?=
 =?utf-8?B?MHF2UTBSVVpScHZRTXB1TkhFRWlqblFIcWp5dytXYTZEaEQrczd5b3F2dEJp?=
 =?utf-8?B?M2orMDdJQnhkNmtWSVlRVHNTb1pKZDk1bElrZzhtaVAzYjdycHFEd3hVQ0FH?=
 =?utf-8?B?RWJmbm9BS0FMQ2dOMENYSFZvaFRURW1SaVVnT2lEVkhqRGJYTnIwK2xzeHhF?=
 =?utf-8?B?eVZSazI0YlNabWg0d0Z2NEthZmRmRUlOUDFlcTRSTEcvUHFkQ05CMUpvRENm?=
 =?utf-8?B?c0RRWkw3ODNRR0pqYUtpdG5DSS9qaDdsWW5OT3ZPb2dPQnhpWDVSZVpMZ3Fo?=
 =?utf-8?B?MFU2R0FrNWNWOGpOTmkxbUxmREFER1pZS1Q4R3BOUy9DcFE1L1JVUkMweElW?=
 =?utf-8?B?TExPMlZqTC9HeEtvMkswMlBXdkxPcG1PVXNpODFvUnE0cmJLUGJZYmtoVGdR?=
 =?utf-8?B?NWl2Umh1VVd0eitKdlphZzRZSUhpK3N4Vldla3RzWVVDVDhITThjakU5M2F3?=
 =?utf-8?B?UGR4anlXN21yYkwyUnhoclZIYXJWcjFTTjhhVFRZYlZyY1EybXlkdFJNZGwr?=
 =?utf-8?B?U3FjcE5VeU1KV0ZnYklVSS9DSmVMYk9udjhEaFlMSUZFdHR5citHa1JYU283?=
 =?utf-8?B?UjQ0WUI1dlFVdlMrRHR1NDRCWCtERm4yS01JTG9yT3d3eVhQZmI0c0JtL2ZB?=
 =?utf-8?B?Q0JXSm5xdWsxeUlLREwwOGJwVFBibUVGbXhDWTJlejdCZmxZYmJKWE5ISjZz?=
 =?utf-8?B?UFo1NzhoL2tpNVNjK1dXSDQzczd5aVNOcmRIZlp5TEdMdTQvV2dPK1BaUkl0?=
 =?utf-8?B?RW9aWjgybUFVcFVLTGgvTGdBajBMRGdyQmpyT09VSG9CQ2llZ1l0b2FzWFo0?=
 =?utf-8?B?RlI2VE45SWhoZXZTVUdlT3pWU1ZXMEZBZFhGSVBPemszVzU2TGxha0FtMlhD?=
 =?utf-8?B?cEZpUGtabUxWVlJONzI4VlVqQ1ZZaENGWThuR0dySTJuOTNxQ3JwRDJncklL?=
 =?utf-8?B?N0tlaEFOWkRqREVnN1IrTFcyMEtpdWd3RjhJczBpR1FUTnVIbjdDRzU5Qlkz?=
 =?utf-8?B?THh3bVZCTDNOVFV1c0g1R1NZTTlMWkFoZzRQYlBlNkJuWThJbytNcGM0VXZr?=
 =?utf-8?B?Nk1iL2R6WEh4SDF0V0NFVzNKWHBCMWJyVWp3dFlPSnNGYlUvdWF6MWowbGtQ?=
 =?utf-8?B?U0phVGFKc2hEeS9CdlR6clo3ZjgzNXRlemhRVGJVTWhNNmdnOUhyQnptaUFk?=
 =?utf-8?B?UHRnVTVuaFZEUHBlbEl3RWJ6RFF5eDVyMVUrUU10TjBKdnlMdmQ3Ym15bjFv?=
 =?utf-8?B?enRkVVBjTkVNUmhQdjIyVDRMZU9OVktFcVNONHlWU3ZBYnJVTFAwOWQ2b1N0?=
 =?utf-8?B?Qlg2N2RVOE9kbllCTzVqMWFFSGlYYkhEWDBBN3d2QUxiRllSeEMzRnBHMmNx?=
 =?utf-8?B?UTdna3IvZ1ZBN2RSeEx2OEdWSFlSVFFhWk9FRHdodVNOK2w3QjU2MlBRc1Zq?=
 =?utf-8?B?dTBVempOZks0NEI5clQzb2VyMUhaZXlvL3ZCNmxTRzJDOS9pWDJFN1lOalA1?=
 =?utf-8?B?NmlYT3hCTEdzNmthcCtLelRrUWxxWC9SYnVOTmJIY0pkdzB1ZXA1UUZCOFZV?=
 =?utf-8?B?RnR5d1NSTVczT1c4VSt3UTZEbUpKVkMwTTFvRmNibnlLQnUxd3BKSGFGMDUx?=
 =?utf-8?B?cC9zcFpwZjFnRmlyczh3dER5SWJjdHIyMm1SS2dqWGVLSjlqSThYZUt1Y093?=
 =?utf-8?B?OWV1QUFPV0FUTk5GeldEVUdweGF5ek9Ua1czcVNvbnlKT2lhTEJVV1RmcWxK?=
 =?utf-8?B?aWk4QUgwWm4zVmd5T1FoR3pLSTdoMkRkL3lsSzNDQnRSRTY2K3J1RG9ieml2?=
 =?utf-8?B?bWFMaXZrU3V2L085MUdXMGZEbkJYWkFFell2ZzdTMUd4Y0hvUFBuU2FZQ0Mz?=
 =?utf-8?B?Z1UxMjlsSDhrVWFLUFNWVUxVRVM0WG1PVmFzVmo5VEZxc3VLcXZlcVppaWJl?=
 =?utf-8?B?Y0oxUXgzSHFLWmE2R0hrdHBxNFU4REw5VGQ0ZkI5bWxNZlZiUXNvTzlEOEFQ?=
 =?utf-8?B?U0xpUkx2aWt1SXVhQ1RtcjlkdjF3Y01vSUNESmVBelJ4Y3p0V3hxV05WN0hk?=
 =?utf-8?B?dnZ6Skg5cEJqVXhLMjhWRFJud2l6RjNETEhiTXNrajlsY2cySlJnMHhpa082?=
 =?utf-8?B?emlzMG5vMWZFS2swUlppeGtzYWVPaElJYXkyN3h5dDZSNURZN1ZYUXVTNzlz?=
 =?utf-8?B?M3pxbDROL2ZscWRBVFdNSXZ6ZSswSWl4eUtFRXVvb2hjckZPYTMweFFFL3Rp?=
 =?utf-8?B?ek1Sa1Y1RUpDaUdPb0tJS3dhTnV1bnlMSlkzeUdaTTJtS0E2K1IxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6949640C45CAA14884229782B657F48A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UgP/xd4euIh1klicPyMl3vbFrQwXs/9TehtRNWJySEQSLrVU8SQORsMnrcAwd02L4dQWb0j2C587GwPbdUJKznja2jjr3RyQPpgOMmyD29CcrRllaAfK5pKhKk7nGdHv3hVgr2Sg3xa91zcFv3VxfOjqRjjiRzOngZbLwKiLK52YBQ0wp/wZTISWqWCoEMiSY6Vwy+b1blV9W7impNGqA1c2Gzh98om2oe6Sl4Fi6tdW8IcZpT0eya5X/yOqVwdCvh1P1wG0lECjdgL3O85U2fHMsVHT6hMdErIzBLuuSk60mpZg6EOdbwGMCTCu3yNHweFJfioymSgjczqgsSfCUXx+iJcWX55AnCfxJmOHpyC4iCe7AW1gNDQB9UbzDEStrYJryMV4ZIbZtfU6Ti1E0yOyGSo7P/KzJONK37BiVRVFiZ3RkYCjWJ2aWfpfbKDAluWv7AIxHRVvDNTEqLSdr6ff2k6XuM/jhcDQygsczGnYiq3R5f7CFBo6ktGy405TVVlEix1N5JPWsZTtS4ovHjHc1xuFi3g0jcEWYkMK/W6k8dxMY0+qgPrVHYYnF7KPMpw/33PuODwluLjR34gzAQkAPcGKlhCH2l4fQWUmXT6WHN6aMJYXis82Zpt4Ibb8ihDSbbtukgHX1AUreIp83Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add0d215-bc75-46d6-bd0d-08de523e03b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 00:52:23.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Xi/QBXF1SNaEMUGDXCTshPv6bIbXLpOYl814W3yU7o9hdjD2MU9AyTpHKtFNu2DT+YY6WXIuSCTx/kGUOwNww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Authority-Analysis: v=2.4 cv=NpzcssdJ c=1 sm=1 tr=0 ts=6965974c cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dOLNmq4gAAAA:8 a=jIQo8A4GAAAA:8
 a=9SEzmUO9_Uq-NgxCKa0A:9 a=QEXdDO2ut3YA:10 a=_m6CO-mWuQdSFutSHjXj:22
X-Proofpoint-GUID: EaKZil8zvrddLxtE412DdZLyR-FwyaJO
X-Proofpoint-ORIG-GUID: EaKZil8zvrddLxtE412DdZLyR-FwyaJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAwNSBTYWx0ZWRfX+H1p/i8bOfQB
 mhnj6Olvazp2JDqjfETPaOrNcpGr+PpPWjmOFt4JskPC+8haPOHhJmZYVbyG2eMyBrEtRzFvA6w
 iubURVSqEIAjFbcxrAJFMwyicO3cszbYVT+BKtm7xqp8fFWV/U/Xxigog9sdk50YYHcUSpV47Mi
 JKsnO086ygm5Buin+oPgvb+1V1gpikPL9+O2sUzo7ZRcz+wml2X9iKC6Cugt53Qjod5NQeyWvJa
 mcDAUI0W/HdtIH9vGXltittv9YquoRee7xYg5AHLTbBgE83JJ+YHptzmC4EVqYfOm7Ft3R4oQtM
 xHtCPU6BPHi48u/OmCHxpl+G2TkXb2PV3oDB8QtBOvKKaJZVprR+8fE1bOzMLVJqIO/2aX8zoER
 NZ8O4s1gJa9VoNPG2A6b0ioeKIVQzwF1F08pZjQdrWOnoHR1UfNf6Dr4j7LFwiohbYm7SkfDq94
 ul6n3oTnciY9oN0/hMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130005

T24gRnJpLCBKYW4gMDksIDIwMjYsIEphbm5lIEdydW5hdSB3cm90ZToNCj4gSWdub3JlIFVTQiBy
b2xlIHN3aXRjaGVzIGlmIGR3YzMtYXBwbGUgaXMgYWxyZWFkeSBpbiB0aGUgZGVzaXJlZCBzdGF0
ZS4NCj4gVGhlIFVTQi1DIHBvcnQgY29udHJvbGxlciBvbiBNMiBhbmQgTTEvTTIgUHJvL01heC9V
bHRyYSBkZXZpY2VzIGlzc3Vlcw0KPiBhZGRpdGlvbmFsIGludGVycnVwdHMgd2hpY2ggcmVzdWx0
IGluIFVTQiByb2xlIHN3aXRjaGVzIHRvIHRoZSBhbHJlYWR5DQo+IGFjdGl2ZSByb2xlLg0KPiBJ
Z25vcmUgdGhlc2UgVVNCIHJvbGUgc3dpdGNoZXMgdG8gZW5zdXJlIHRoZSBVU0ItQyBwb3J0IGNv
bnRyb2xsZXIgYW5kDQo+IGR3YzMtYXBwbGUgYXJlIGFsd2F5cyBpbiBhIGNvbnNpc3RlbnQgc3Rh
dGUuIFRoaXMgbWF0Y2hlcyB0aGUgYmVoYXZpb3VyDQo+IGluIF9fZHdjM19zZXRfbW9kZSgpIGlu
IGNvcmUuYy4NCj4gRml4ZXMgZGV0ZWN0aW5nIFVTQiAyLjAgYW5kIDMueCBkZXZpY2VzIG9uIHRo
ZSBhZmZlY3RlZCBzeXN0ZW1zLiBUaGUNCj4gcmVzZXQgY2F1c2VkIGJ5IHRoZSBhZGRpdGlvbmFs
IHJvbGUgc3dpdGNoIGFwcGVhcnMgdG8gbGVhdmUgdGhlIFVTQg0KPiBkZXZpY2VzIGluIGEgc3Rh
dGUgd2hpY2ggcHJldmVudHMgZGV0ZWN0aW9uIHdoZW4gdGhlIHBoeSBhbmQgZHdjMyBpcw0KPiBi
cm91Z2h0IGJhY2sgdXAgYWdhaW4uDQo+IA0KPiBGaXhlczogMGVjOTQ2ZDMyZWY3ICgidXNiOiBk
d2MzOiBBZGQgQXBwbGUgU2lsaWNvbiBEV0MzIGdsdWUgbGF5ZXIgZHJpdmVyIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSmFubmUgR3J1bmF1IDxqQGph
bm5hdS5uZXQ+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWFwcGxlLmMgfCAxNiAr
KysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hcHBsZS5jIGIvZHJpdmVycy91
c2IvZHdjMy9kd2MzLWFwcGxlLmMNCj4gaW5kZXggY2M0N2NhZDIzMmUzOTdhYzQ0OThiMDkxNjVk
ZmRiNWJkMjE1ZGVkNy4uMzVlYWRkMWZhMDgwNDk4MjliYTQwNjUxYTk2ZWIxMjJlZDU1NDYwZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFwcGxlLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9kd2MzLWFwcGxlLmMNCj4gQEAgLTMzOSw2ICszMzksMjIgQEAgc3RhdGlj
IGludCBkd2MzX3VzYl9yb2xlX3N3aXRjaF9zZXQoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3cs
IGVudW0gdXNiX3JvbGUgcm8NCj4gIA0KPiAgCWd1YXJkKG11dGV4KSgmYXBwbGVkd2MtPmxvY2sp
Ow0KPiAgDQo+ICsJLyoNCj4gKwkgKiBTa2lwIHJvbGUgc3dpdGNoZXMgaWYgYXBwbGVkd2MgaXMg
YWxyZWFkeSBpbiB0aGUgZGVzaXJlZCBzdGF0ZS4gVGhlDQo+ICsJICogVVNCLUMgcG9ydCBjb250
cm9sbGVyIG9uIE0yIGFuZCBNMS9NMiBQcm8vTWF4L1VsdHJhIGRldmljZXMgaXNzdWVzDQo+ICsJ
ICogYWRkaXRpb25hbCBpbnRlcnJ1cHRzIHdoaWNoIHJlc3VsdHMgaW4gdXNiX3JvbGVfc3dpdGNo
X3NldF9yb2xlKCkNCj4gKwkgKiBjYWxscyB3aXRoIHRoZSBjdXJyZW50IHJvbGUuDQo+ICsJICog
SWdub3JlIHRob3NlIGNhbGxzIGhlcmUgdG8gZW5zdXJlIHRoZSBVU0ItQyBwb3J0IGNvbnRyb2xs
ZXIgYW5kDQo+ICsJICogYXBwbGVkd2MgYXJlIGluIGEgY29uc2lzdGVudCBzdGF0ZS4NCj4gKwkg
KiBUaGlzIG1hdGNoZXMgdGhlIGJlaGF2aW91ciBpbiBfX2R3YzNfc2V0X21vZGUoKS4NCj4gKwkg
KiBEbyBubyBoYW5kbGUgVVNCX1JPTEVfTk9ORSBmb3IgRFdDM19BUFBMRV9OT19DQUJMRSBhbmQN
Cj4gKwkgKiBEV0MzX0FQUExFX1BST0JFX1BFTkRJTkcgc2luY2UgdGhhdCBpcyBuby1vcCBhbnl3
YXkuDQo+ICsJICovDQo+ICsJaWYgKGFwcGxlZHdjLT5zdGF0ZSA9PSBEV0MzX0FQUExFX0hPU1Qg
JiYgcm9sZSA9PSBVU0JfUk9MRV9IT1NUKQ0KPiArCQlyZXR1cm4gMDsNCj4gKwlpZiAoYXBwbGVk
d2MtPnN0YXRlID09IERXQzNfQVBQTEVfREVWSUNFICYmIHJvbGUgPT0gVVNCX1JPTEVfREVWSUNF
KQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiAgCS8qDQo+ICAJICogV2UgbmVlZCB0byB0ZWFyIGFs
bCBvZiBkd2MzIGRvd24gYW5kIHJlLWluaXRpYWxpemUgaXQgZXZlcnkgdGltZSBhIGNhYmxlIGlz
DQo+ICAJICogY29ubmVjdGVkIG9yIGRpc2Nvbm5lY3RlZCBvciB3aGVuIHRoZSBtb2RlIGNoYW5n
ZXMuIFNlZSB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgZW51bQ0KPiANCj4gLS0tDQo+IGJhc2UtY29t
bWl0OiA4ZjBiNGNjZTQ0ODFmYjIyNjUzNjk3Y2NlZDhkMGQwNDAyN2NiMWU4DQo+IGNoYW5nZS1p
ZDogMjAyNjAxMDktYXBwbGUtZHdjMy1yb2xlLXN3aXRjaC0xYjY4NGY3Mzg2MGMNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gLS0gDQo+IEphbm5lIEdydW5hdSA8akBqYW5uYXUubmV0Pg0KPiANCg0K
QWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhh
bmtzLA0KVGhpbmg=

