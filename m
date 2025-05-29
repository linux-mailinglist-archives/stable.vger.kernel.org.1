Return-Path: <stable+bounces-148048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB823AC75A7
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 04:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3559E460F
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E2242D6B;
	Thu, 29 May 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OZG3EgqT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Kw+gP6l/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ciz29B7C"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99702242925;
	Thu, 29 May 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484653; cv=fail; b=UV6gTzM09vLSPzQ6oowooyXW7wczOoHDQ5MygLgUhE+3fUHNqyybo7Sl6Vg1DbhV+E0lZG/3ituOamaZpxNO0wqbWDry4Tf6vi2zoixexusbH8IWIfudPcl5aKpaGdjxNhj80QIb82Rm8Mjir1+RRvOgpjqZhXwk0OmWORJESeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484653; c=relaxed/simple;
	bh=FLJxq+rkr0Z3cggiTZnZUs5kSb5JlJupsZwmIiHbd3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKNQtVKiWoUeUB8ofwLWRVb2iqp5pS0jjxdyMmWyuQ3w3cpHtp5+qfWW6e2HbWCUNS0YiE356D31yV44h8I5XdB1r709W8LsY07FGpwZm2gYeIpctxUWNRTsoxwmNssNC31HQtCfGVOilOPGvmrLfyRULTF9loNfpx19xNJsaDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OZG3EgqT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Kw+gP6l/; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ciz29B7C reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SMAIoR013003;
	Wed, 28 May 2025 18:17:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=FLJxq+rkr0Z3cggiTZnZUs5kSb5JlJupsZwmIiHbd3M=; b=
	OZG3EgqTUCgZVnSIlulS9OgTcCOWLHd32GV8q3Zq9Rv7tFf/wmNKJuEGJaUSXtbT
	qBJeLI0AOAfb0cHx8H4YP3UaezWgBXsx2gRriLcHVa2iaiDPxYT6Fdf5GrQjry17
	v8kNqWQAx6pjBATeglv8s10szPc5tf9a/d96IgB3hhscVi08/3b4lHmk/3/rhzht
	CSHfayL6mnpoIWksdsE4Z4++UNUedFQi7QCZfRck5BtGc0a2p6ZpIZvAdemy5/bz
	PJ3xV7hzLnR3xIrplQ7aolDBXVFn2sjMFe56h5xb6YKm8MKX7d+jvvQYzWYwFni4
	G2hMhtXUPvDCZ/U+sZhZ3g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 46udc74b4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 18:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1748481476; bh=FLJxq+rkr0Z3cggiTZnZUs5kSb5JlJupsZwmIiHbd3M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Kw+gP6l/eIwkqTmABaD+OWoN5UAaiw0athvshOmS2fyn6ZXPmdaF9P5fgVp8OFe4g
	 6oCTjLqOY2u4pGTkuSOGmNEcS3XWnmpPqiQgq/JdG0ArHIQ07U2E+Y0J6ovMS+YzLA
	 IjYVDhjohBuT20nkeo3stf5GwVxXutsP70a3kIeCUqNM2JS6HmRoBMNT1YOoT0d6e7
	 DLV3/OrG4iTYMryLP4Q1eWn7TvUuwO033mMst1CVbOnaNQrXsUjaf7tzbthYzY3Uat
	 m+uEvd1bm/KH68bckh23SAT03OStcPcTZKnBOZYvz6kVJIMyy9qq4CYxikrG2IE7Jo
	 Ehm4aV3uxt3bw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 69B2140148;
	Thu, 29 May 2025 01:17:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id CD21BA006D;
	Thu, 29 May 2025 01:17:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ciz29B7C;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B7BDB405A6;
	Thu, 29 May 2025 01:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGFDLEyF7oHxQ9CqZAF7uNR882IBMnPais/mJ3VGn7Ve5cWv0mvBiA91uhqxYMR8NDRSO0uXrY9V/jp6Tw54vWUoQZQEo5TUCiZrJCysA4WPlQRDKgTurYJ+lLTUSuUA5x3LmiD4sAbnNPeQ3bZuqIuikD5nZteu2WpAozcfxPMJ8n4b2UPgOQPTjfey1O/ztL/v787ttEzLrEr+TW8HSj4bgx42XoJ+z4a2b1mkUF3amFElmYgC7NlBhwsIdv8Ik48hFsqsBB3RBsnRfb0q+yX1aaeegDn9DCUAUJXKbzjECaOGNIEPXSdqCODA7pUkRe6bdbKP0E+9Leyw8KY2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLJxq+rkr0Z3cggiTZnZUs5kSb5JlJupsZwmIiHbd3M=;
 b=rNVFIkHEd1kLZSrtRfkXDU0zV9QvSnVhQTEozjCa68TxFiYcSIFbpJ6JFoT3RK1lDaTIfQmh1WVev1KJeARwDo6jxfy3wiwjkyMuZZ0d9KmWW2qyo1PjylJ/1hhGJyeCutXWNILQbOCW9dEwuY+xoDrilF8W0KxJe278SetPdKFWZ+jA4c1LdMlJTl0xFsy/yzU9gClSR9uG+x5AhOsmUS9W7l6V5PniaqDyhgWwLTXc832vQiiuKmMYkWfwVeOfR/8Nr+l6oc93F2x1l38ZcX+0JwZGL2ORHPmqOy9Y+WCIL61tBHGTlr44X+mdThGPMXgNRibyBndWYUA3EG/CQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLJxq+rkr0Z3cggiTZnZUs5kSb5JlJupsZwmIiHbd3M=;
 b=ciz29B7CEcwD6OCmkIyvawFRS81pTRB7G7+7RPnkCkZyZxcMyE+KGY5WtFuyb+ID4w8+t9OKcbDYBun/F8ISygq4+uAA7SF0zX1ssOk0CtWO3V6bqRQOxHypKJ+18ZuVyCe7slUEK0VPGJFv2xWresjmQUZ6Emxaaj7ZCV+j9mQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 01:17:51 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 01:17:51 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Roy Luo <royluo@google.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.pecio@gmail.com" <michal.pecio@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Thread-Topic: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Thread-Index: AQHby00IO9kpIg0s3ESarCv0vYf2UbPg2AyAgAO0D4CABExBgA==
Date: Thu, 29 May 2025 01:17:50 +0000
Message-ID: <20250529011745.xkssevnj2u44dxqm@synopsys.com>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com>
 <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
In-Reply-To: <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB7125:EE_
x-ms-office365-filtering-correlation-id: f9fab9ee-808a-4ee7-73da-08dd9e4ea174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkFpRWw5TmN1cllZU2xnZ1VISjhWVkpSZnVKMlVmczlkSlRxNmovajd2cXg1?=
 =?utf-8?B?UWJ0SytyNHJSRTJrQkZoMUtQTEJzUEZLUzdmM1dFQ1N5L0U1NlBTcWVMck1w?=
 =?utf-8?B?QnZaWUowcVk0anJ6NFVMZU95SHNGMEtVM0d2NmFTdDlaNldQeng5dmU3ejZ0?=
 =?utf-8?B?WGNRTGYzYkxabEFZUUUxT3RZOXR6Z20wUHBiQXVaWUxrNnFNTzlhWnBHRkZO?=
 =?utf-8?B?Wm8vZmFFcnJMOC9NWERLMzgrZFAxK3FiYmkrTVdVTHExZGlZM2Q5dEVKTEtq?=
 =?utf-8?B?bnUwNzk3aVVpaGp1S1QxTjE0MXdURXNvekxaM05ha0hNb2QrM0lUMUwzaFUz?=
 =?utf-8?B?UXBTalJsQmxMNFdzaHZWclQxR1Q0bXlQRHhVMGxNbkhFTHRCZmJmeHhWQTZa?=
 =?utf-8?B?K1IrYzltN2J0eXlKMnVCOE1ZZW5vRFlpdTlEQ3FNczZrc0piNStZVUpwcHQy?=
 =?utf-8?B?KzA1QlZrYkJRdW43QUVDSjB1NjNTRmlrcXNvbnRiNklpSStQeUlHd2UyZm8r?=
 =?utf-8?B?aWVENUoyZ3lOb1N6Z3p3dGpzY3gycWVwTlB6M09vTEtJYTErQWRoZGduQ2lp?=
 =?utf-8?B?Q0NpZmg4R0QrajNQcndFaDdjV1lBeUZYUFQrbVFMRk1yd25TVGk5aFNicncv?=
 =?utf-8?B?RVU5ZWhBU1I4VENNVWRNUXNBbkxjeFgrMWt3OTdUeFNDNWJTWHlkbSsyZG1k?=
 =?utf-8?B?Uk5EdkR6elpTUmdUUFg0eXVtM0hmWGxRTHlTVURvL3RMYWFYYlV2QXd5QkJo?=
 =?utf-8?B?SEp2U1Jmakk1OXRldncvNm9QNWtNV1R4YW5QTFJ3WFFUek82elQxK1VCbHVC?=
 =?utf-8?B?dEo1UEU1TmpCYXB6Wk4yYmlIMlFLL2VYMkZQRnNvK2h6MVdPTlZvN0IyTDhM?=
 =?utf-8?B?R3FySlV3MzV4OE1JNG45RlZWaUxENDUwUHltZzA3aWFacHFISk8xYXhBREpp?=
 =?utf-8?B?Zm1uYzl1NVJJQTdNbGhySkRQOVE5dWlSK095RHdxVlVwRGFCWklXb3JsZHF0?=
 =?utf-8?B?SHQ4Z09keXVOTjZ0RVJUb1Q3WVNSQTZWTEFCbmZLOTBiZmZISWtmcVN5Qld6?=
 =?utf-8?B?T2srbURXU3UzaTAxOXNySnJkdDd0WGozVXd3N2hkRERZVUxzT1hzdGIrb01k?=
 =?utf-8?B?RmR4cEVkcUE4UjVYSm9lM3A2M3drQkF2NWtMRUhxVks2NGVzSlhEQ2J0VnJT?=
 =?utf-8?B?SEozVXIxUUhoS3l3VFlWZHMyVVZ6bEtISzFwYURiWVZqMUp1L0lXbUZwMm9x?=
 =?utf-8?B?dUZSNnpsK1ZVNXNaS3N4WlFMWjNPckNjdXU1dHRTaXVFZ0s1Yk1wMDZKOG1l?=
 =?utf-8?B?dzZKcnFnc3JyaWRNTWZYTk1qMlF5T1MwQ3lscGRHMW43WW9wRXhHcVZPVTNG?=
 =?utf-8?B?TlVCbEpxWFBJWStRMkM4UmJwSnU0NlpuNW8wR0xzYkVHZFJGdFluaGlJMWxG?=
 =?utf-8?B?MzA1cXZKN2tnK0I0a2NzWEVCOUlQNkNwdHdldjZzYVpZNHhaVmprZ3NlQVJR?=
 =?utf-8?B?cHByQnlXZU1rZnlrZU0rM1QxKzBObzU2Ymg2WHZJbFMrUlJxMXJMSVhIQ0h3?=
 =?utf-8?B?N3NmOEVEMFBwMEwrWnFiZjZwOSt1elIrang1K2dhUUNtNFRrbS9TcWtzMHln?=
 =?utf-8?B?Tm4vdTdING5TUXJvZ0k4bGIxV3YvdEdpMU5JaVRBNWxJdmo1RFZUbTBoNXRB?=
 =?utf-8?B?SHNvVWk3eHNsbmwzckdGVi8zc3p5TytSN2VDaG11anQxRHJReThOYS9aRlFM?=
 =?utf-8?B?VFVZS1QxT3c5YzZJaEFPYzlpUkF4c2FRcDV6MXl1T1NHVWt1K2d2STFTZUlq?=
 =?utf-8?B?T3MrZUFNRCtzTkxNclVPRU1sOXJ4a2t1N0FRVzZ4YzRuSzZ4bGQ3anBCUDBN?=
 =?utf-8?B?UDZQUTg2bWdZN09jTHYzY0FJUURkZmVoYzJ2TGtXcUJURDF0TSs1dHVueDF0?=
 =?utf-8?B?NTJyY2djRHVkSlhBNzhrSkQ3RXV3NUJrcVJ0VFJIcis1RmIwRkJneTY2VlZu?=
 =?utf-8?Q?R+Q9dc1x5fA5kaxTIbreNXAEcrMb2Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2tsTjg2UWkxcC9wN1dBc3l4cjJQTEhEQ1UvVUtIOHZNcmova0hXUnhBaUdJ?=
 =?utf-8?B?VTJXeExScXROOWpDYkJqMVBUQ3pxWVpFRVFXOWViYzl1ZUZHOWdjTTVDNHQz?=
 =?utf-8?B?Z09vS09sT1U3NmNGdmVsNzIrT0dQeS9Nb3dueUlOSW9XZS9KZGRzdStGNjVj?=
 =?utf-8?B?aGF6aGJLdGhYMWp2Nmc3VU10VFk0c3drQ1dqU0h3STM4M0drSmw0UnVkcE9r?=
 =?utf-8?B?N09ERzRmRlZ1OUdzODAvcUE3N3lKYWJrcDZmbWRob1ZvTWlSZXlZTytYRGdV?=
 =?utf-8?B?UDRGRUFHNHVhaGVzeU5kN3pCVTFtMjh3OE9GWEtYdU9DMjlDV2RPQlB2cVQv?=
 =?utf-8?B?UTVmNkJXdHpDQnUySFdDOVJDTGZqNkdGdE85WEorOGdzZ1N3V0Yxb3JGb0Ew?=
 =?utf-8?B?OTFld0licGw3SWFqZjN5djY1cDJmOUloS2Q3VXpxclBYN3VhejlqRlJ2dlAr?=
 =?utf-8?B?WkU2ZGwvZnJRWHhwK3pXK2JlYmdhUVZQcGVsZy9jTWxLWSs0NTJNRW5JZk40?=
 =?utf-8?B?aTlrVVJmMkFhWnJSaklFRTkxYitXSVJlcWZVNjNGWjhmNEV3Y3NwYjFjbldv?=
 =?utf-8?B?L3F5NmxLc0dDSzBjR2JwVlZtU2l3eDhiTS9RSUtFZVU5ajVCbGt2QmtYcjZN?=
 =?utf-8?B?Z0IyK2lqZjdXci92ckpIR3lia29GaHlISWxvN0J0bUJqQ3FEMkx4Mlc1cjNJ?=
 =?utf-8?B?SjBhMWdMdmpUeW8ycjlFY0ZFYTFNdXdPclFwemFRVTlOSHAwd00rVlZRM2Q0?=
 =?utf-8?B?QUlHSkxGYk9mRlQrOVI5TEZaRzZkSDJZbEZrUm9OUXhHSzROWnFPbEpHR3BC?=
 =?utf-8?B?VXNuUlAwMTlCajdGekZxTjBUN2E4SUNLQ1NGaUsrYmtMaHVqU255ZjNpVy9r?=
 =?utf-8?B?MjBCTXBZQXM4V0JWb1k4eVpodUR0UllyN04rWFFabzZKYjdtR3ZpRDFWZzRJ?=
 =?utf-8?B?K0p5NkFkKzdDQm9lNEhwRDlpRWVPRU1zWS9seWE5d2NqWkJiSmROcWt0Q2xX?=
 =?utf-8?B?QjltTWdPSC85TTFhMC84MmloalFMcXJOVzU5MXoxcFpGQTlSSmN3OXJ6YzBO?=
 =?utf-8?B?RGpwWEtrSVJwVldJS3AvM2RtTWNQdVpwbEwzMFp1bXhOTGw2TVhtSU4xNkdr?=
 =?utf-8?B?cDlhWVhzSUpRMlpyMFdYdjBhZ2lpTUxMVStzWjNhdkhXRTE2amZGdnRqOUxR?=
 =?utf-8?B?K3gybzlLa01nUWJTV2lJdGIxMmRRS3ZOSThYMVBFL2tINW41VmNlZW4rWjN6?=
 =?utf-8?B?MkgzUFZVUmlCQXZmbVFNWFFCOVUwTnh1WE42TkFyN09sU0k2amw0b05WYlNS?=
 =?utf-8?B?OVdLR1pYd1MwcStKUjQwQXkwczZIMDZ4R25kWkZxSWEwTWlVYVh1bktMckk5?=
 =?utf-8?B?QUJzUEx5dU5xQmlUbWxuQ3U3aGQ2R0N1ckh4ME02YlZoaUxIMHpaam9QK3Z4?=
 =?utf-8?B?VUdtL1B5UXMvWG5pMjh0NGd5QlFlVlpqS21HanRRd1hsa0lMZVdqM2NidHJu?=
 =?utf-8?B?RFhwNytEU1M2ZUVMc01vcXhoZzh2SGpZaXd4NlZUOGw5M2R3WmpSOWs3ZWRn?=
 =?utf-8?B?R3BhV0RFSzgzSjFxeDQ5SHlaSnpuN3FWNlk3WW44VWJCRVEyVm1VSEE0Q2FL?=
 =?utf-8?B?VkR4N0ZLdG5DWitBSStVbDR3a1dQdk1nRXlHK0w2QnIvM2V1YUxHaFFrMzFF?=
 =?utf-8?B?ejNnVXFNRGlkbW9kRmdzQlAyV2w4QWVyeEo1ekg5QUpQbjZwMFhIZVV5ZnZO?=
 =?utf-8?B?aDg4RUZqbUJTT2QvSzRPVXdZSUhKOVVuMHhFekMvaStQc3BOYXh6MDUyWm5q?=
 =?utf-8?B?RU50WXNMNVNXTEp3YTVHUkM3aXlESzdCV3RhOTNEcURNODdjVVpOQkl2d2RX?=
 =?utf-8?B?a2lnWE8rWHhnWk9tOEsxSEkyL2JsVmZSRHg5RWpTY1RSN1dxdzVKVWY5dVIx?=
 =?utf-8?B?YUVaYStXdldVNHVJaUJwYVRveWdjb2E3b3JBVCsxRXN4RjZFREZMa00xdWFh?=
 =?utf-8?B?VUhXOTVkVWgyeG5kUWVlVjJvL2VaQWs3aU5nSmVaOTZJbFh0WUdsR2E3ZHJ4?=
 =?utf-8?B?bTU4OXBUK1NpYkpCQ1FZT3FKc3ZLSy9iSzBFUkRaODRzUXZXNzQrTmp1dmll?=
 =?utf-8?Q?fnFF8rDCXO69YSuf9cQqm5T5X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFED558F1888BF41AC85607131DFCA81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FpyCjBF50shkSfcRbwmhd4F+hAYhYYv/IP8+ruiQl21hEF1mwQ2KDPfArkhZs7b1LSAHGIeLKGq3VIvQBStWcufRbFhbiGFxrBh8GNf9lmqFmf8oGMSzgpb7rUKnVHkW5R55aTTfWuvBOziHlkZarQL2JlYIfCWde6+PFMkINx0tzlB2NLm1JZ3ZkG4ter3ujUO7Kamboblapic2zzn+mFX1xDy+g7qgHgAiV4inDz9Se9q8GYmxY/iuqpsfU1qE47tZ/3RMtNDZetNv/EeaF802u2cbFBo+zRHLFLCbVvJg1bjpVCIIfPanOf79SgSt3bqbbi2GGd3yT03IRf5ygc5/I7OS6w9jooacOEfcLCSp+yLUL9S9l9jPzQMokufrAU8zFW01O1tlFvpjjDnwcDNCNUdhcL+doPVmBQr+Cc80S917SiyUtUwfI7tIvvvdY3JMnn5KftUo02RiAXba5WjJolTZV1cOv+7YuzirS09WZ+ClwmqMEp4b5FqYdszAVKUdEI/1yQi9OrqM6PcTVtdxFPL8hUp/aDlG+bop2a5ijxG8gHvcIjV/7K0uD38sgSDOUJemOgaXz0nQ3gJ49SOcddxKMRCpQcDZdJlfzxGp0Pvu2hJHkBC6QfbaS0B3eblf0aQc5i1nXGJnxMRXIw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fab9ee-808a-4ee7-73da-08dd9e4ea174
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 01:17:50.9774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nik3nNMcNvxm+ZxvPgZjdZiYNn4PPl3bqsQzt68sL7aFfdp8/rS9/S6FyQ9h+ySyz+DC+/d9lJ0SCTWOsxGu/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-Proofpoint-ORIG-GUID: lSDZaZJrX7WXey8JXq4ZhbLqQmvAN1R_
X-Proofpoint-GUID: lSDZaZJrX7WXey8JXq4ZhbLqQmvAN1R_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDAxMSBTYWx0ZWRfX9ieWzWKYIsSe
 Hjr7y8icbR1onvQjYcuGFlYFEJveQvuGVl5LnI0xcHpGAG4wSFLG3k9Y96jnz0kJVRO9IMlfmpG
 fjflYsPk7RYHt1wDo8WYbC049VFqRojJJ43npBY6lZ+GfFABPoPvYUedVykE328QhxHYozFcUC/
 5oFN7DkFxV3/kAHjGciTedwurEKOUaXSFcJ37kvHsOziJyAly2VdQCn1aPBPDB3yBoDCVIios+o
 syWkd1OwXt3CaHWLa7batom9hOzRCxPxPtOXaS/TjdWxPAeLR4DmD07OtyC98GS7vNXZxUW0xbT
 VyixofOkppH3H3XV+QgENh9KmwjnTkGCyneHblHcpjr3SyaAWyG+1RYDgx3npvimiUDOHyZRTx3
 SeBjhsxbADLYnt/fwhRqvtJ6hhclqzyMJeWXclbSG3JZM07oD255aXoxUg1695cSnPDJDSir
X-Authority-Analysis: v=2.4 cv=LtCSymdc c=1 sm=1 tr=0 ts=6837b5c5 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=6_s5kQ1NYOYmdDusEu0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_12,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000 definitions=main-2505290011

T24gTW9uLCBNYXkgMjYsIDIwMjUsIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+IE9uIDI0LjUuMjAy
NSAyLjA2LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gSGkgTWF0aGlhcywgUm95LA0KPiA+IA0K
PiA+IE9uIFRodSwgTWF5IDIyLCAyMDI1LCBSb3kgTHVvIHdyb3RlOg0KPiA+ID4geGhjaV9yZXNl
dCgpIGN1cnJlbnRseSByZXR1cm5zIC1FTk9ERVYgaWYgWEhDSV9TVEFURV9SRU1PVklORyBpcw0K
PiA+ID4gc2V0LCB3aXRob3V0IGNvbXBsZXRpbmcgdGhlIHhoY2kgaGFuZHNoYWtlLCB1bmxlc3Mg
dGhlIHJlc2V0IGNvbXBsZXRlcw0KPiA+ID4gZXhjZXB0aW9uYWxseSBxdWlja2x5LiBUaGlzIGJl
aGF2aW9yIGNhdXNlcyBhIHJlZ3Jlc3Npb24gb24gU3lub3BzeXMNCj4gPiA+IERXQzMgVVNCIGNv
bnRyb2xsZXJzIHdpdGggZHVhbC1yb2xlIGNhcGFiaWxpdGllcy4NCj4gPiA+IA0KPiA+ID4gU3Bl
Y2lmaWNhbGx5LCB3aGVuIGEgRFdDMyBjb250cm9sbGVyIGV4aXRzIGhvc3QgbW9kZSBhbmQgcmVt
b3ZlcyB4aGNpDQo+ID4gPiB3aGlsZSBhIHJlc2V0IGlzIHN0aWxsIGluIHByb2dyZXNzLCBhbmQg
dGhlbiBhdHRlbXB0cyB0byBjb25maWd1cmUgaXRzDQo+ID4gPiBoYXJkd2FyZSBmb3IgZGV2aWNl
IG1vZGUsIHRoZSBvbmdvaW5nLCBpbmNvbXBsZXRlIHJlc2V0IGxlYWRzIHRvDQo+ID4gPiBjcml0
aWNhbCByZWdpc3RlciBhY2Nlc3MgaXNzdWVzLiBBbGwgcmVnaXN0ZXIgcmVhZHMgcmV0dXJuIHpl
cm8sIG5vdA0KPiA+ID4ganVzdCB3aXRoaW4gdGhlIHhIQ0kgcmVnaXN0ZXIgc3BhY2UgKHdoaWNo
IG1pZ2h0IGJlIGV4cGVjdGVkIGR1cmluZyBhDQo+ID4gPiByZXNldCksIGJ1dCBhY3Jvc3MgdGhl
IGVudGlyZSBEV0MzIElQIGJsb2NrLg0KPiA+ID4gDQo+ID4gPiBUaGlzIHBhdGNoIGFkZHJlc3Nl
cyB0aGUgaXNzdWUgYnkgcHJldmVudGluZyB4aGNpX3Jlc2V0KCkgZnJvbSBiZWluZw0KPiA+ID4g
Y2FsbGVkIGluIHhoY2lfcmVzdW1lKCkgYW5kIGJhaWxpbmcgb3V0IGVhcmx5IGluIHRoZSByZWlu
aXQgZmxvdyB3aGVuDQo+ID4gPiBYSENJX1NUQVRFX1JFTU9WSU5HIGlzIHNldC4NCj4gPiA+IA0K
PiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IEZpeGVzOiA2Y2NiODNkNmM0
OTcgKCJ1c2I6IHhoY2k6IEltcGxlbWVudCB4aGNpX2hhbmRzaGFrZV9jaGVja19zdGF0ZSgpIGhl
bHBlciIpDQo+ID4gPiBTdWdnZXN0ZWQtYnk6IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMubnltYW5A
aW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm95IEx1byA8cm95bHVvQGdvb2dsZS5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy91c2IvaG9zdC94aGNpLmMgfCA1ICsrKyst
DQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jIGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLmMNCj4gPiA+IGluZGV4IDkwZWI0OTEyNjdiNS4uMjQ0YjEyZWFm
ZDk1IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS5jDQo+ID4gPiBAQCAtMTA4NCw3ICsxMDg0LDEwIEBA
IGludCB4aGNpX3Jlc3VtZShzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksIGJvb2wgcG93ZXJfbG9zdCwg
Ym9vbCBpc19hdXRvX3Jlc3VtZSkNCj4gPiA+ICAgCQl4aGNpX2RiZyh4aGNpLCAiU3RvcCBIQ0Rc
biIpOw0KPiA+ID4gICAJCXhoY2lfaGFsdCh4aGNpKTsNCj4gPiA+ICAgCQl4aGNpX3plcm9fNjRi
X3JlZ3MoeGhjaSk7DQo+ID4gPiAtCQlyZXR2YWwgPSB4aGNpX3Jlc2V0KHhoY2ksIFhIQ0lfUkVT
RVRfTE9OR19VU0VDKTsNCj4gPiA+ICsJCWlmICh4aGNpLT54aGNfc3RhdGUgJiBYSENJX1NUQVRF
X1JFTU9WSU5HKQ0KPiA+ID4gKwkJCXJldHZhbCA9IC1FTk9ERVY7DQo+ID4gPiArCQllbHNlDQo+
ID4gPiArCQkJcmV0dmFsID0geGhjaV9yZXNldCh4aGNpLCBYSENJX1JFU0VUX0xPTkdfVVNFQyk7
DQo+ID4gDQo+ID4gSG93IGNhbiB0aGlzIHByZXZlbnQgdGhlIHhoY19zdGF0ZSBmcm9tIGNoYW5n
aW5nIHdoaWxlIGluIHJlc2V0PyBUaGVyZSdzDQo+ID4gbm8gbG9ja2luZyBpbiB4aGNpLXBsYXQu
DQo+IA0KPiBQYXRjaCAyLzIsIHdoaWNoIGlzIHRoZSByZXZlcnQgb2YgNmNjYjgzZDZjNDk3IHBy
ZXZlbnRzIHhoY2lfcmVzZXQoKSBmcm9tDQo+IGFib3J0aW5nIGR1ZSB0byB4aGNfc3RhdGUgZmxh
Z3MgY2hhbmdlLg0KPiANCj4gVGhpcyBwYXRjaCBtYWtlcyBzdXJlIHhIQyBpcyBub3QgcmVzZXQg
dHdpY2UgaWYgeGhjaSBpcyByZXN1bWluZyBkdWUgdG8NCj4gcmVtb3ZlIGJlaW5nIGNhbGxlZC4g
KFhIQ0lfU1RBVEVfUkVNT1ZJTkcgaXMgc2V0KS4NCg0KV291bGRuJ3QgaXQgc3RpbGwgYmUgcG9z
c2libGUgZm9yIHhoY2kgdG8gYmUgcmVtb3ZlZCBpbiB0aGUgbWlkZGxlIG9mDQpyZXNldCBvbiBy
ZXN1bWU/IFRoZSB3YXRjaGRvZyBtYXkgc3RpbGwgdGltZW91dCBhZnRlcndhcmQgaWYgdGhlcmUn
cyBhbg0KaXNzdWUgd2l0aCByZXNldCByaWdodD8NCg0KPiBUaGUgUWNvbSBwbGF0Zm9ybSBoYXMg
d2F0Y2hkb2cgaXNzdWVzIHdpdGggdGhlIDEwIHNlY29uZCBYSENJX1JFU0VUX0xPTkdfVVNFQw0K
PiB0aW1lb3V0IHJlc2V0IGR1cmluZyByZXN1bWUgYXQgcmVtb3ZlLg0KDQo+IA0KPiA+IA0KPiA+
IEkgd291bGQgc3VnZ2VzdCB0byBzaW1wbHkgcmV2ZXJ0IHRoZSBjb21taXQgNmNjYjgzZDZjNDk3
IHRoYXQgY2F1c2VzDQo+ID4gcmVncmVzc2lvbiBmaXJzdC4gV2UgY2FuIGludmVzdGlnYXRlIGFu
ZCBsb29rIGludG8gYSBzb2x1dGlvbiB0byB0aGUNCj4gPiBzcGVjaWZpYyBRY29tIGlzc3VlIGFm
dGVyd2FyZC4NCj4gDQo+IFdoeSBpbnRlbnRpb25hbGx5IGJyaW5nIGJhY2sgdGhlIFFjb20gd2F0
Y2hkb2cgaXNzdWUgYnkgb25seSByZXZlcnRpbmcNCj4gNmNjYjgzZDZjNDk3ID8uIENhbid0IHdl
IHNvbHZlIGJvdGggaW4gb25lIGdvPw0KDQpJIGZlZWwgdGhhdCB0aGUgZml4IGlzIGRvZXNuJ3Qg
Y292ZXIgYWxsIHRoZSBzY2VuYXJpb3MsIHRoYXQncyB3aHkgSQ0Kc3VnZ2VzdCB0aGUgcmV2ZXJ0
IGZvciBub3cgYW5kIHdhaXQgdW50aWwgdGhlIGZpeCBpcyBwcm9wZXJseSB0ZXN0ZWQNCmJlZm9y
ZSBhcHBseWluZyBpdCB0byBzdGFibGU/IA0KDQo+IA0KPiA+IA0KPiA+IE5vdGUgdGhhdCB0aGlz
IGNvbW1pdCBtYXkgaW1wYWN0IHJvbGUtc3dpdGNoaW5nIGZsb3cgZm9yIGFsbCBEUkQgZHdjMw0K
PiA+IChhbmQgcGVyaGFwcyBvdGhlcnMpLCB3aGljaCBtYXkgYWxzbyBpbXBhY3Qgb3RoZXIgUWNv
bSBEUkQgcGxhdGZvcm1zLg0KPiANCj4gQ291bGQgeW91IGV4cGFuZCBvbiB0aGlzLCBJJ20gbm90
IHN1cmUgSSBmb2xsb3cuDQo+IA0KPiB4SEMgd2lsbCBiZSByZXNldCBsYXRlciBpbiByZW1vdmUg
cGF0aDoNCj4gDQo+IHhoY2lfcGxhdF9yZW1vdmUoKQ0KPiAgIHVzYl9yZW1vdmVfaGNkKCkNCj4g
ICAgIGhjZC0+ZHJpdmVyLT5zdG9wKGhjZCkgLT4geGhjaV9zdG9wKCkNCj4gICAgICAgeGhjaV9y
ZXNldCh4aGNpLCBYSENJX1JFU0VUX1NIT1JUX1VTRUMpOw0KPiANCg0KSSdtIHJlZmVycmluZyB0
byB0aGUgb2ZmZW5kaW5nIGNvbW1pdCA2Y2NiODNkNmM0OTcsIHRoYXQgaXQgc2hvdWxkIGJlDQpw
cmlvcml0aXplZCBhbmQgcHVzaGVkIG91dCBmaXJzdC4NCg0KQlIsDQpUaGluaA==

