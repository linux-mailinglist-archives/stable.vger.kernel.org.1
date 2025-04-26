Return-Path: <stable+bounces-136739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E5A9D6C3
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 02:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951679C2AF0
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 00:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01F1E5213;
	Sat, 26 Apr 2025 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R545VnwQ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F1RnnjZm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NhSs9ay7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570345A79B;
	Sat, 26 Apr 2025 00:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745628108; cv=fail; b=rcNBxRCjF4XCESD4Z4SBSjzNhqGIvbkFdSlcUUV1D2oWXGu51jFQ8irsWSrO4EfSCz/B3ORsE/t4Tp/WYNl4+1Dlqcy51L+wGF+7Ym0TEMm+uVOotK+XnsG4Dz5LNP+33VdM+etn4aNe5RYSKwSZcGnFMNLbLIXf0hYNI61fLng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745628108; c=relaxed/simple;
	bh=hpaCJ3l4vMs9TDrujMtYPi6mUdqj5ZrLPJLuXxLI5uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GPUuUg043Cy+E7Mmy9OS3GNbbl1Q36J6bDhDNYpyGeZ5dSXXY+hsPZx3CjeX5/deQUFccgr1j6DKK0GHwruecbLwIRvrcmtibK9rw8mwAoQLUjNg/TKt7akQp6LGsSeOMaYTJEKwS/oHensXns12AmZOZuNlQYV/XrMhXEL5zT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R545VnwQ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=F1RnnjZm; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NhSs9ay7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53Q063lP029250;
	Fri, 25 Apr 2025 17:41:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=hpaCJ3l4vMs9TDrujMtYPi6mUdqj5ZrLPJLuXxLI5uc=; b=
	R545VnwQzGTCmqjoRcV3h5b6WvNbDgr+5m8aO0N/a/WhriefjecK2VaAr1tAqX+R
	HXrbNtONDj/5ZWWCTkN6cnsq87iGlJrTuLK4vz3Zd7chLrX4dt7ymQ8wq/JXsWjs
	8ol+5MMcMVQg2xcvS4gXLgwYx5B2Jip7NsThrXVGEDmA/Uy/nCFg4F0fuW2hukUu
	cU7Hb1fT+APv+ZxuBX58RUSgobbR4OZ6345EFbgtrR4uywb6uO3D9r408SMmLjMK
	BCPI2FV8mIxdS6Y7tAmkWJC15Gf0fL2QEjbQ0N4J0Xoj3Foqg/Pumh7pMPR6r9Tz
	wTzQIuis5CXT8j+Xdg6j5w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 466jkeahgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1745628096; bh=hpaCJ3l4vMs9TDrujMtYPi6mUdqj5ZrLPJLuXxLI5uc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=F1RnnjZm2l68LTSXC+74j91YMqBbbvCOEbxpq9Cit9+//quU8U2xSTs4v+4HsrxH+
	 WyuZTVqR6ifhFhI3B+R+DEvfjV2wFOuh1DcpbuJWyfIn5VONKMpETN5hSZIsYOBVTY
	 4Z0M7LEWTl9Xq3OakVxg0O6F4kfuy7XA1UW3KXtG42F5nZhOq5aSHRPxjjgLT7GJ5k
	 q0XVxPj/Uzjf9cdmRSAktkNRTkc7hpiLLvLtsOP3UUNStsUQtJJ4pqT6r3mAuGOS4R
	 PvPUHlZQ5aEYqOuHqkGkBkB0rsceTlzkJwxKFJ9U4X9RhMKgj1u+Tx/HlNoF89sDzs
	 fEaqTSAomHWMw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3DEF74035B;
	Sat, 26 Apr 2025 00:41:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C7250A008A;
	Sat, 26 Apr 2025 00:41:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NhSs9ay7;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 29888405DA;
	Sat, 26 Apr 2025 00:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAaXQKQAQROmsiL4NVyuDuK9wX60oAPpPvsAHKOimiEYVWL8YhDLwVCjkMFuE83fUXPD2Z1C9e+KA3u2L7RbhQmnO/Alo/SPgQsWhryztLVbBbgVa7vzM7y0VXKAnL5J0cG22V0kSbjQyu5RXDibFj3AYy/dPL3GHvxV5Tiro15jt4AgrdXs1y5AiJjKuRd71jtNzLFp16EpkvY2enHo3EmC34Xp4zkNQXVL4EYjzrUkq36F6qPKZppdkM2D7THI0m+nsRk+lC6piJ+sWEXk5BWAhb7Xxy2F1u9KNyAi8wnNc95V9h/L9FxCVLMSrM2GYHxOgIWOD2daOYmmT7aZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpaCJ3l4vMs9TDrujMtYPi6mUdqj5ZrLPJLuXxLI5uc=;
 b=JJpUInfvM/w1vfIgOSA9yCjIZv7AKS1EFRNh5FykbgPRh7XuFfEAp9OklGWEbTpaYWaPeRAZ+z/YZgoLg2l1Zd01NkICyhfN/EnqPwAidP05C07tp6nIn4TaLHlScXRfPxrpZfJtfQqhXAJhM2cJW26gB8OxPongLiuQQ+jemvwgi4fMLKmB2SvfU9cdqSbCLmlalc0SUDRywiXqQ4CX8/8KkaQ2X5qt21Qxemu4KNKtXaqQv8UnOtwW1ICpdMi2Vb7WGvBAhKkixFtA/PZIVo4/IL3DfdMQNNQLFCaB/ZST6BkrM8cYVOKrcnAcxiNsLif/IPTOSCxbDUAsfF2b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpaCJ3l4vMs9TDrujMtYPi6mUdqj5ZrLPJLuXxLI5uc=;
 b=NhSs9ay7FY7do5QKS0BDx+71JPoZlYSwjs3WhLaBLzWhFgFxQrIgvGyjjlKe/Lf4w3YvrnDPTDIw55c8Vj58n4gywejZ+d8qM8ZEfTDpfZcRNeVforjEPuKsEhLrSUgCMY+ytpJWuKlEvrIVeBM7NO+sdGaQLFAHzKi29Ba29+c=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Sat, 26 Apr
 2025 00:41:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.8678.025; Sat, 26 Apr 2025
 00:41:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Kuen-Han Tsai <khtsai@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Topic: [PATCH v2] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Index: AQHbnGtrEDBrrqhzOEqY0dxgDti3n7O0aScAgADl5gA=
Date: Sat, 26 Apr 2025 00:41:32 +0000
Message-ID: <20250426004128.icwn74kz57swbkid@synopsys.com>
References: <20250324031758.865242-1-khtsai@google.com>
 <2025042513-crunching-sandworm-75c5@gregkh>
In-Reply-To: <2025042513-crunching-sandworm-75c5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA5PPF8DEAB7A29:EE_
x-ms-office365-filtering-correlation-id: 1ef7aa13-d564-4ccb-8731-08dd845b1738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RG9wKzNZTHBvZCtBK3dVWFR0eG90ZXVLdUZmclJ4VTFJRG9lbEtwY2s3b2Mr?=
 =?utf-8?B?Wkw1VjFkSjdJRDRyRmM4MzhEZTBScjVhTGRjTlpUbFVrQkc5QU9MNTBsRnQv?=
 =?utf-8?B?YmdldkdRMjAxRFdCamIwNmo5TGVBaXhyVFgxM3dDN0lyZHRTZGc3dVEzMDdo?=
 =?utf-8?B?NXBzdFZOZTgwdGlaQ2l2T3Q0Rkp2UU0zOUJCYzBDVnorQzFnYzZEUHVnOC8r?=
 =?utf-8?B?MXpJQjh1RHNWUnJwUXB3NldHd2Y1ZmJjY1BlOTY1UzV3WXJJZklkd3lySkRK?=
 =?utf-8?B?WklFRGtWVGZjeFNhNmxLbFdsZ2xqaGNmT1hvMXlUakFncERHc1EvQytSWUda?=
 =?utf-8?B?RVE2VHZiVjBOcSsvT0xsK2tOTTdWSDE3bG93YVhxL0lmMEMwM0F1UURYajB4?=
 =?utf-8?B?dHhYUVlCMnFUcmIvNHV2K3hCWFNNdm9OTy9pMkRaRkVQV3ViTHBFcldBVFlR?=
 =?utf-8?B?eGkveGl5OUhWWnQ2QmRLM2hkVjNWazkwMnRkanY1TEtoSW4rVmQvMUx0dTVk?=
 =?utf-8?B?Nldvc3p6TWYwTW1hZEwxQkNKMW5CNnYwR1YrdnpvelpDdUw4aTM4Rzd5ME5j?=
 =?utf-8?B?MXpHeWQyNE5najlIUnBFRlJkTFJRQjdLbXdrcHhrSDY5RjRpakV0MXFyNUlJ?=
 =?utf-8?B?ZEFyOE0yY05McERQUkErYUY0V1hjdGEwRG05NkpEU0c5K0thYUd4OXBIakln?=
 =?utf-8?B?ZlhlOVEySDBQMUVLT21palJRTnN6dzhDdzUzdSszOExEeU5lSHkvWGRyZXQ3?=
 =?utf-8?B?c01iald1QzRiVVF2cjlyMmxUaFJSenVTN2tJWEJkRk5aaXFvdllRSTZiNTEv?=
 =?utf-8?B?ak5aeHFoZStPbGhZaGR1a0xSak5NdnpReEhRdS9mTURSR01zLzE5N2w0THZq?=
 =?utf-8?B?K21OVVFoSmlOVkJ4MkpWWHBoQVFEY2NXUE5RT09YZWVhdURuQWI4N2I3T3RN?=
 =?utf-8?B?RzZuWm5aaFd1czBxZ2w0SmZFYXlyRDZ3OWJtZWxHQ2pkc0lwRVErbjl4UkZl?=
 =?utf-8?B?T0t0VWZVMC85WkZmWW1LWGdVMVNEbnRzK0RDbHFyVjdqdUo5Ylp1c3NLVWRP?=
 =?utf-8?B?S0lkSlJreTkyRnZtNVNoRDU3bjdHS2ZSQ3NuSTN1OTNzaWhzbXEyNE9QaE1M?=
 =?utf-8?B?Y1F0L0Q0NFJSMkRnY09rU2ZzVVNHV29SR1l1em1KMlozQjdMd2tLclBMbmpD?=
 =?utf-8?B?N0k4MHVsaVRxdVFvN0tlMHg0NGdyUDZOcDBITWFVbCttVm4xNVJMQXBGL2tZ?=
 =?utf-8?B?NU5ZQStzeFA0QzR0MGs4cDd1TG05WFhRemJianJxOXhnODgwemE1VzlwNUIz?=
 =?utf-8?B?bzlkczRUNXZnV1pPMDV2TXgwZkEwMW5mYVVma0hqRFc2SWRuQ0JSbHhMWjgv?=
 =?utf-8?B?ZzhKVUtBN2Jxd2ZpMUFUd0x5bUl1WmxBQmxjRHl0aXF6UFdtcU5xbUJLdFc4?=
 =?utf-8?B?ZW5heWNJZ2lpSzY3R3JOendsdmFDVkVycmo2OE44OEkwZ0VMa1I0M2FqejVn?=
 =?utf-8?B?ZGNVWDBkY0xYQ3VIRWwrZW5IKzVBeW40UTRDTGp3WmtGenQyNHJQVHBkVEp2?=
 =?utf-8?B?UXlCME5YWXpzb2JDSi82YXBrak9IMTJTTXpxdjBHQTN6ek8vSW8vd3pLUFBm?=
 =?utf-8?B?aHZtZkpBTE1DWXRiemZOSTFPUUFISU40dXhlUWxKSTJ3ZXFvN2pCaFNWaWk2?=
 =?utf-8?B?aE5rOFFDRkZlampEbEltR3BIQkNOaGtFUWx0bmxDbWQ0ZE43cUZIcVFjTjJs?=
 =?utf-8?B?UnNHZmdJUUNGcS9QOHZ1cURqUFhFTm9BSXY2NmZ0Y0wvZW5HYUdCVjlFWWc3?=
 =?utf-8?B?VWdJSnJIQ1BLQVBjcTRKZHNWanBoTi9LM3R4b0p6SjZOWWlZZisxVGdZVjNT?=
 =?utf-8?B?RnJQcm5LVmt3TXR6NklyQW9ta0dOWm1VQ21kTmdXQWhUTlZ1akp1Y3RLNTNW?=
 =?utf-8?Q?uBTmjKQpYtg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1BuTlora1c0R1RZalhMMlZvWGdoVzM5aEZZc1ZpdmJWTnlWTi94NmZmLzFq?=
 =?utf-8?B?NjF2NXR3bjFsQy9WNktrbkpGZGo1cTcyV1M3U0JKeTgraFlxTWlUUTNLUXdv?=
 =?utf-8?B?d2diWXhiOWd0cmpGMjd1eWlPMFpmZnExanBZcmVFUjJhY3RIRDAyL00rZXd0?=
 =?utf-8?B?TUQrRnZJNkgwbk5LZEN3cTg5bDhLRnkvMFlrRXVpcWg4MGdrRUVqamNxaEp0?=
 =?utf-8?B?cXVqcXo4L0lXcVVyNlVoTHViSWVpeVVocnVBZE81cm9Rb0N0YWNSSy9ZMUZq?=
 =?utf-8?B?T3UyZDdETHRGeUJMeS9zY0RXMFpDMnJUb25HenVGU3d2SWF6aFpGM2JEeldm?=
 =?utf-8?B?K3I1RWFkTHRRQXpQeVpFM1JOa1dEMWtmeU0wckRMZ1FxY1JtUHNkU083bnBW?=
 =?utf-8?B?blo0WTlFWHlTUzF4TjlDQXVFUHF4cHFZUkZEcE9GcDBna043VHprRFEvY2tE?=
 =?utf-8?B?bHk0ek84TWlqZnhUQ1Yxblh6QzVsdnNDUDhCclNCenRZZi8vc21xYUMwWmda?=
 =?utf-8?B?bTl0Y3pQVWNPWXIrZGtVdjdkOFhybDM5RFFKNWVCR1ZWUzZ4eVQ4NkJ0bm9T?=
 =?utf-8?B?eVBhTytCTm4vUHJxeldoSWl2SGhZbm5WamgyR2hRcTVjaWFBR3dmU05qOVFk?=
 =?utf-8?B?ZlJLcXBoczZTQlIyelU5ZEdIYTRnNzU3ZnIvNWJTTHVaSnFacGFCdkI4eWx0?=
 =?utf-8?B?OGRGeFJVTlM1empHUC9YZGZtUTJ5OEF1eFlKYlV5STBaekVHbGp2N1dBTWV4?=
 =?utf-8?B?WmZ6Ri9YeW4wTzd2ZHl2RDVyYmdxeEVpTHVBcnA0cUNIRGlxV0tYcjBGdHB3?=
 =?utf-8?B?YjUwSzdZR3p6ZkVQVzhXZGZ2ZmJIR1FMakxZWGZaTWxsKzZOUEhUalB1cVU2?=
 =?utf-8?B?SVlzNWZ6ZzBDTUxJdytLMEJmek9BaXdQR1N2WlY5YXdUU2RhdlozQjJFelI3?=
 =?utf-8?B?eFd0NGYzVmNPMFV4Q3hrY2VpcGxLb0wxbW9mUDNOVlFwdldVb0RUbW5iQjls?=
 =?utf-8?B?SVc0WU5iMFhoTHBoYnhKS1Y5ekVHYlJxRzg1SmZ5L0RRMmM4Zk05em94amJ5?=
 =?utf-8?B?YkhNZ1JmUTJNSnp1MDFMMU1aSERSUXpYZlBldURWUFJ0aC91RkZoNm4rSy85?=
 =?utf-8?B?TFRTQVZCcEt3cGg5VkcxRGp3M3dCSGlQTmRqOTg1MWt6Ulp1OXlWQWVVK0V3?=
 =?utf-8?B?TXh5R0NXR2kvK1ZsbnZxd3NKWS9uanJpSEVpK09RZDk4OS9BSHBPQVRMYTJa?=
 =?utf-8?B?Zmk3cXV1bzdRd2VGb3JZMHFYS29ZNFEzNVhUYkNVdkxpL0p1U2o3UXAvTUpM?=
 =?utf-8?B?TDFHMHhNV1IyT2toR2tHbWlOMVRrS3NaRDFwWWRBZXZWYlpqNGFUWnR6NzZT?=
 =?utf-8?B?aUh1QUVvVUhjajVySmVOY0pBeU9hejBFOTg1MDJnMDVNeW1ad25DMnpOalZ5?=
 =?utf-8?B?eFFnQW92bCtBNmt5S29JczBMUGU1N2ZVMlJxWHlzb0hvZ1BNKytLdVBSKzhx?=
 =?utf-8?B?NnVqS1hxc0tna294UmlWQlpFakxLMWQ5Y1NtY01uS2ZFT1R3NUlpb3ZnSjdR?=
 =?utf-8?B?Q2J1aFdmQmlTaFJVeGtZY00zZEZxK0hDWWRtQ0lCVzN1SWc3M1BaVlgxaVA3?=
 =?utf-8?B?U3VZSGtNaisxenhqcUlZZSs1QTYvRFZyaFpGN3pncWhmaEZ4emdxeUpVUDlJ?=
 =?utf-8?B?bnZkKzY0NXRWWmZVQ2xGTnRWNkRHckJmSG5QTDIvdFhJSENMNnFsSHZaVVdG?=
 =?utf-8?B?NUpkY1g4allPdU1kOEZmaFU3MWRXdHBWTnJGZW1NQ3c3M0NFS0FVR3pOQVJP?=
 =?utf-8?B?bHBIZWloQW9VTlI4RSt5UEFacmJ5dTlLc0pGSGdES3BWRm42eDdNSklLR09k?=
 =?utf-8?B?VzBGOE42ekJ2UVF5dnBUTm95cloyL3ljUERPL285akwyc3JPWWVrY3dLSVBV?=
 =?utf-8?B?YjZmS09YY3ZTTUdzMnNmVzd3VmJyajA0d21KK0xVTXFsVkJRQXhQdE5pTkRI?=
 =?utf-8?B?UGlzS3lWRldzelM3NVhaNmxlbEhXbWs4WkRQMDI5S3VKMGRZVnZBYitRMnZx?=
 =?utf-8?B?VVlrM2dMN0J5eldDYmhaaWFSTDdONUhxL2tHUWxVWGJRR21LWHM2UHFodXpz?=
 =?utf-8?Q?EG/LcBD5XLQWbGSk3sdr0TvqA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794644514CCB6B4F9EA6A487FE6E7A16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EarUhGCCeW4I/eIEpxOkGsbJS7kWaqpjihZjcctd2bTG599tj+DxTlpgc8yvsMHfMCZN+NOpBiqlT9T4NKxuHPdfTzV3qC0lbZEPdhvzGOShdS/+JiUvs9uRE62uvhWeVjVI4eX++7UY/0vAfcvQ6/Gvks21btWvqe16MQ7aYckJyuNPx2ATf1HB0PokRAGY/tSQKn+1JQqf3emeRDbyN4oBw9cHYygyalm6YxERYcpI0ktiJ+FzHmDoh3wH1vZhJKuf2ybX39WlmaD2QzH6bKUd6IjG4r6W2IcVBC3T7J+wm1+RhMcISyB2HaF6BUdOZIMDcb/PaclKfsZGKJ6Z4sWJ/ou0iJJqJJK+dAeRXYRoycSc6xajjS+NyBuZzhkcNlIrahFf8sjLc4jPa6CzgwDjloj/7amaEPJ+V7iU/1whGbUz011pxDOJ0RoRSCq2O8m1GJXI7xj7fPlS/MZTgeb+jXWvmMJu/fYmNQ765Z2m9AnYz82PNxTQ3zwatel8lwMcLuNm+yppgW0HYP61ovzLPDfCRx8fqbRVXygfWnwjegYBxLDmG4UZ44chBPzhxYmvtTGbSnIe2uLOV8QAbWRI/e4o8ePAXBRBiX+IH8x38hRUGEI7D4ud4/BFALTYfbUNujCvca3hOw3pRUzOTQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef7aa13-d564-4ccb-8731-08dd845b1738
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2025 00:41:32.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4art41LfwxOCGpLT56oLAxIf8SmB4+CgSqu9mKvO+6FygKk2Qp/hUgGn4bje06VC8IJVSdityEsvtu1Uz52FPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
X-Proofpoint-ORIG-GUID: 2qWQSkUxN6qGXnbpe7QWHFxiBV9pGM5O
X-Proofpoint-GUID: 2qWQSkUxN6qGXnbpe7QWHFxiBV9pGM5O
X-Authority-Analysis: v=2.4 cv=QfBmvtbv c=1 sm=1 tr=0 ts=680c2bc1 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=gr3SJUrR8X4SEZB8HzkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI2MDAwMiBTYWx0ZWRfX6022T7Vnm1Fl AsTkS5u7pwJ8trwygLerIqqDo1eD700KkXChzZeOB2xP5d1bpQuyWKkWn/bJHsJpTeSFVVZsHNp UWFQ8zGPbsTopfGOIYHPohqXn/eOqOqRoJAKn+BMAF45IwqOVRAvux9/V1kjGf1wyak+sQNSf87
 xnXBj+X4Ej3Z4nSnJrkcYA1NEyAHniHYzErt1LHa4ZEJge9GsuEV9k65NHPhRhcla4rLsiXdEAo Vt+4aZ6lA5dheOIJZBEHRwQMgyVuUzOye0mrQfK/zTIaBtqNEGCJEr9c39fb5xK3ir3eXxdjwAv XIBVJ4fVzC3yxXkTSkSoRXcNGZdn9V2CVgIJjF8in+LrOaC8P3E2FMmMCNr1H7KdEc8vfHyFtZi
 3+n5KdF1Z3kcoPeajsWF5N36qmQw3AuvfxAZVzXmbi8rZD2DqdUI198wYv6MSzy3M2TBrs1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=476 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504260002

T24gRnJpLCBBcHIgMjUsIDIwMjUsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIE1vbiwgTWFyIDI0LCAy
MDI1IGF0IDExOjE3OjU1QU0gKzA4MDAsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+ID4gV2hlbiBk
d2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoKSBmYWlscywgZHdjM19zdXNwZW5kX2NvbW1vbigp
IGtlZXBzDQo+ID4gZ29pbmcgd2l0aCB0aGUgc3VzcGVuZCwgcmVzdWx0aW5nIGluIGEgcGVyaW9k
IHdoZXJlIHRoZSBwb3dlciBkb21haW4gaXMNCj4gPiBvZmYsIGJ1dCB0aGUgZ2FkZ2V0IGRyaXZl
ciByZW1haW5zIGNvbm5lY3RlZC4gIFdpdGhpbiB0aGlzIHRpbWUgZnJhbWUsDQo+ID4gaW52b2tp
bmcgdmJ1c19ldmVudF93b3JrKCkgd2lsbCBjYXVzZSBhbiBlcnJvciBhcyBpdCBhdHRlbXB0cyB0
byBhY2Nlc3MNCj4gPiBEV0MzIHJlZ2lzdGVycyBmb3IgZW5kcG9pbnQgZGlzYWJsaW5nIGFmdGVy
IHRoZSBwb3dlciBkb21haW4gaGFzIGJlZW4NCj4gPiBjb21wbGV0ZWx5IHNodXQgZG93bi4NCj4g
PiANCj4gPiBBYm9ydCB0aGUgc3VzcGVuZCBzZXF1ZW5jZSB3aGVuIGR3YzNfZ2FkZ2V0X3N1c3Bl
bmQoKSBjYW5ub3QgaGFsdCB0aGUNCj4gPiBjb250cm9sbGVyIGFuZCBwcm9jZWVkcyB3aXRoIGEg
c29mdCBjb25uZWN0Lg0KPiA+IA0KPiA+IEZpeGVzOiBjODU0MDg3MGFmNGMgKCJ1c2I6IGR3YzM6
IGdhZGdldDogSW1wcm92ZSBkd2MzX2dhZGdldF9zdXNwZW5kKCkNCj4gPiBhbmQgZHdjM19nYWRn
ZXRfcmVzdW1lKCkiKQ0KPiANCj4gUGxlYXNlIGRvIG5vdCBsaW5lLXdyYXAgdGhpcyB0eXBlIG9m
IHRoaW5nLg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0KRGlkIHlvdSBjaGVjayB0
aGUgbGF0ZXN0IGNoYW5nZSBpbiB2NDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVz
Yi8yMDI1MDQyMjIyMTg1NC55bDd5cHpjNGtreGJ4dzJhQHN5bm9wc3lzLmNvbS9ULyNtM2NlYjZk
ZmI3YjhhOTY4MWM0NTZkNDEwYjlmY2MxY2MyODY5YTQ0Nw0KDQpJIEFja2VkIHRoYXQuDQoNCkJS
LA0KVGhpbmg=

