Return-Path: <stable+bounces-235436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBseEjjP12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:09:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7AC3CD6BC
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044C630AAE9D
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F343DEAEC;
	Thu,  9 Apr 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kFrBFtJH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68C364E8B;
	Thu,  9 Apr 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749908; cv=fail; b=aCQIHfOwRYuhSNGTJ1k3dux37jR7tNGrPSmkXM0RpZt4uq6zi4tWz8r7Z63xotSjjZSrN9/9h6gIkbP5M4ML5jiXaEbohxCV3AzC4HPM8IOh7BALpJ9/2Gxtgz17dylMalNXzDy553r249KvEnMM3q8tZiPJA2CK/jjNC/Fw6EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749908; c=relaxed/simple;
	bh=kIs3OoKNd30EUicE9XdhY4XNtS2TC2eX1Wxr+G3GuIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZRbeXpYhZfcDLKbWB/nxHt6YZvrXkr8MqYkq/gN+T4YxzKLubqenNvn3s4jeXtdH2KKpW4yHj5mVBqOVaLdprANQyAyn6ANJ0eQqRvRX+RaTKIQYmgQB0rPOw5pbZ5jZiDJqDLkCcAT6f47m+efMlXg8txuA5G6R1G/1tKJjd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kFrBFtJH; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639FXoGr1988471;
	Thu, 9 Apr 2026 15:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pps0720; bh=kIs3OoKNd30EUicE9XdhY4XNtS2TC2eX1Wxr+G3GuIc=; b=kFrB
	FtJHVSI6RRfcO1iRmL2Cicnj2KM21G5XaYlrqigwrgh7gswYO9nWKOdh2SzAzOfN
	x5Jkox4zkEQFO57dSKzLC6AVqf6LuulHWiWWbCPMolfpkg2S2iowLCdC936ut/5d
	4ZapuuyOkSLe7j1Bp5Y0KdNYhl//501DNouPuvTVhgmhVmEhJQiz1csyO/iaWVi/
	3ZEYLl2rxKXmDYLjlyDc6biUkFFm90UCy9voVW+chqvZ2XQa8s4X0EZiK6cKKRZn
	cWCFCI3Kq7Ge4MUDUolcr7pJKLo77ib/uWfsTTrBpsuZ3Wi1BVpIQZA7wvL3r77N
	uQHc/la0IrkZktcorA==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4decx8sy0a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 15:51:20 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7032F2BAEC;
	Thu,  9 Apr 2026 15:51:18 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 03:50:59 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 03:50:58 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 9 Apr 2026 03:50:58 -1200
Received: from PH0PR07CU006.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 03:50:58 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Osk7AJRg/7viTE0a1JpT/HdAR+Hr1ZfjApchQCXDJiQeDD+Gqan8g/FuyVlDg54TlvU/5MW7abY4iDbEG0m/WjYOG24rOHcJsYIO3Z/HezASiaK6fRvlHyTCl/gnB8j5FDh1EnNPmU8l9DISy+R8fbBDlVXH5G3b5swb5FNc8TJPj4toEBMBTbBCbIVK+mO523RD8HDfY8TOlQNGE+7d131nczgbACiMwLVtF4Gcua2QmB/v8IeBJo5iVSPsXFC5OfWDcmaqW2R/cfUa+B0vRn0jXhRhya5fiYel38lQkA8slVmQr0NyKRAU+9olfZJ470HUuGLG/aUta/i2MmVaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIs3OoKNd30EUicE9XdhY4XNtS2TC2eX1Wxr+G3GuIc=;
 b=YvBksn//RUniym1AL3agXX5I9o6ycwF+cEuECevMCpziL4DJS93cpqGSsH8SyEoptI+k3k/hbdpp4RPogPObpCNVF0skiDFn3JgcLGVDr4szN2a1YU8fsSA5H9ccDsXhEOMZmmMi07FoBaUND+2Z25EteR0SV7GZ0+NMbOGV6D+GRQRkt4oUbmPHLhC3WDUDwltF5DcFVfFGVEnIxGDR+I27jxlpd4Lj/vr2ju031AARtlgUM8EZI5kqdZ6TB+Ga63NM+NbP2pCcV0sUmt0sMuqbDbXnp+EDSl+Tzts1zHUEFV+ABHarnppEKIvGPMOMcKjuLLz5GVmwaDCXOGiSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CH3PR84MB3945.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 15:50:54 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 15:50:54 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux@weissschuh.net" <linux@weissschuh.net>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "cosmo.chou@quantatw.com"
	<cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: Re: [PATCH v3 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Thread-Topic: [PATCH v3 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Thread-Index: AQHcx3UnU57j69vQ5Ue3LSgtWHKfl7XVjWUAgAFU8YA=
Date: Thu, 9 Apr 2026 15:50:54 +0000
Message-ID: <20260409155045.402293-1-sanman.pradhan@hpe.com>
References: <20260408163029.353777-1-sanman.pradhan@hpe.com>
 <20260408163029.353777-4-sanman.pradhan@hpe.com>
 <fa22e0b7-f962-409d-8738-e06df1fb4b92@t-8ch.de>
In-Reply-To: <fa22e0b7-f962-409d-8738-e06df1fb4b92@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CH3PR84MB3945:EE_
x-ms-office365-filtering-correlation-id: 9e4eb1cf-d573-4bd9-47a4-08de964fc8ab
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: fi3ODH/Gyy61xqAlTHWbdaIHrsvuQNczIixhznNEc9J8QzC1eUoWYrc0uK8Mq1ppNUmZYizSeO9Gw+beviXpUO/fGzwVTw4oGiXRXNjPa6GkA++dSEE3Br+SUVp8FS1fGhYh30i25vg/C2Y7qXkdSqNYsRiB/XVGZq/44GRtE1ZT4LQTgypByrd/oedwANjT77NpCZB3ShdjoU/NA/FvXVfpJNQ17EzVAAlYwmfv7i6Ykm6TIl3GZrWfEG/bagMNZ5Bz329TMBjWAUigpRfR1tbTkDHKJGfVopK/lEMRbwcwJLt/WoZiRTwPpJU5VGPqxBTUycRX28gDu9nvx4LnAAR/W2PdXOuvLxj6Qkz1mUe8uqcybzSSf/quNHN6RwyzHAi5rtta9kd/PTKLDoaDMJcuNjCJQLNZ+JvXMqNWd5f8Uqy4KdM19mJe0Ubh1CddB8mXZAvfOZZml/gjcCNKesfEgYJ1l1wpnN7Nw+HHltjSGHuI3F1E+ueIxEY3fAOKkqF0RlYVMdkiL3Vixj/dXPb0wv3YU+zpTf0Tk6ueQDT+tLHAdXd7QYhNqtl7q23nzLJ/kVfcJuwBxUgwqS56vzL3WiQHKDVtvC5q8R79y7WOLPXofY8DDV577anxyZnL1M8qOi/xJoCAdSf2YqvvJDZqwsVsuWXE5Q+J6yKpihlqQkwv2eNHKTNCw+nzFtanOekNQN74SmjPmyRiY0dhNxTayyAdPI92XQC2DHzPVz+iTx+D2oj48JQq3NABChHMHuT9QDOIi2eYBASEbF11u/GOQsGf7Q75SJp+B4zmn08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1NkYTlpQ0o2c2tEWDRpNzg4WEpBL0RQSDBaR1o4NjZGRktqWlhhTkt5NkpN?=
 =?utf-8?B?S2pnSTFKV1Nvb1BqSHBET1RwSXFiOTlCT0dOVUJxb3FZMnRSc09uV3RHL01Z?=
 =?utf-8?B?bVFvb0Z6MVZUY2pRaTBmOGp6elo1LzYrd0NpN3lOZ3hXMUtjaHUyMGF1NDdC?=
 =?utf-8?B?am5ySEhlYndLRWFFZVFoRmhXZ0FFcmpWU216TVExS3FWUVdGd2wvMU1uZUJY?=
 =?utf-8?B?Vy9BZHE2M3oyVXZwcnhmOXVtRHVlblhVZjNUMXhlQ2I1aXdCL1h4eFhRMVFa?=
 =?utf-8?B?M2tscWd5L1VOeDg2VVB2MHUzNlpSMCtSNGVyb0JKQ2NjMDhtQ0I0OVlodjVI?=
 =?utf-8?B?YXE4aUUwcG5vWEpwY3crZEJoblZTOW16NXRkeElWUVhQWGkvRGRNc2JiQ2x0?=
 =?utf-8?B?NHg1Szh6V3RqTnJwc0RGcXJvMHhzbDdITm1rMEZ5bVdwOGZYVm85V08wc3BC?=
 =?utf-8?B?aTVjTkhOMGhvMS9NRjgxZDBKYi9Jb0gwT0plNEpobWNGNERvOGJURnVnVVQ0?=
 =?utf-8?B?N0srODFTWXlxWTlDellUMkhHeldiQUhXcUlWR3NaZ2Q2UDNocUZLanJCNS94?=
 =?utf-8?B?d3luTE1xTHRwcUpFaENoVHFUSkZ1bHg2SUtKYzFmbW54UlJRK2plajlicjA5?=
 =?utf-8?B?cW9zOHBzaS8weTdKakx4b1RneTE4aHFOS2V1WnFRaXhvc013bUZpc1hudmN5?=
 =?utf-8?B?a2hUb1pEaVlVYWUwbU9lQzJQaGNWKytid0FYbnFFL014WEk1TVROTDlrZDlV?=
 =?utf-8?B?T01PbEE3S3AxNjcxQ3UvdjZSM3JncEFlY3d1Nml0R0h6MHQxR3BvMFRtazBi?=
 =?utf-8?B?b2kzK0lGTXoyR3F1b25pS1pvK0ttL0J4b2tyK05XV2w5SnAwY3h6d1B5dHRs?=
 =?utf-8?B?N1UxdFZ3TDBPdTVFaVg3MnVtaEhmTFZRV0poUjQwand3bmRSVFk4aU5yOVEx?=
 =?utf-8?B?RktHQnBjdXo3ajZxM0ZTWmtHaDNOd1lROHRKRVp6dmtpK2NBaTdWbE82OTV5?=
 =?utf-8?B?NEdvN21KQ056anJqb1NMc1AwZk1adkJsWjQwNVRlVUlaWGV2Z3h4WEVKU1V1?=
 =?utf-8?B?OFpTc1hKSm1sbW1vN0g2VHpPM2R3K1ZOSjhoZ3pDL28xT2ovWTZ4RVg1aXM1?=
 =?utf-8?B?MlIrK1VEZTgvR2dMTkx3ZG5oQVJVYnRsNFJLVmlpaXdsaVRIRlM1YUx1MENW?=
 =?utf-8?B?WnZ3UlZtcEhocE11UXN6MFJoV09vSWZkN1FKbnlKVEhadVJQUVFud2lOVEc1?=
 =?utf-8?B?WWl0UlFRTlRGMmlPL2xPOG1BZTg4S1pRZ1RVQnRoTUtZL09ZOFYvWUZCQmdE?=
 =?utf-8?B?ckNRMUcveUs0Q3lOVHNlSVFFanZqUVpDOHNBR2ZFeHJMMEt2SjJHUUszaUNP?=
 =?utf-8?B?NlhHaXB6ek1LZnc0MEhNMzB4R1VURGhYSElsQ2VLZyttLzlTNG85OElQdms2?=
 =?utf-8?B?N1R4ODhJdzBhUmdubHZFd2dyT1FPc3UybERSeXdjOGwrbDVUYUlrS0I3NVNX?=
 =?utf-8?B?OVA0Y0RWVU9DZTJ2MG4wWHFzN1RPaW9wUlM4U29vbGZNcWFjdEJEbEpmbmhX?=
 =?utf-8?B?SUxkaHdlb3lSdjRlNUhSdzErQ25FZVBLcU1IeTI5emxUS2lvNWUrajlTenFy?=
 =?utf-8?B?RTlvaWp1NlREN3pBR1FvUU5vNmFYZ2JLZGRsanpvYUg1NzJwZnFJWFlCZklM?=
 =?utf-8?B?Ny9wMDlZUGJpSzRzQXRsYVd1aE1NLytadXlaazdENllacE01TGVPdXM3aDRZ?=
 =?utf-8?B?TmdNR2dyUkIyZXczTlZXU0Z0UC9USWk2Ry9sazk0czdWaFRMOUZCdEg4TDVL?=
 =?utf-8?B?Qk51R0Z5TWx2dG1kcVp0ZjZ2ekFOY0QwYm00dUxlVkN0ZExvblg3dzU4NElE?=
 =?utf-8?B?NTFQT2U3MlYrRExHa0x0NG1RRWR4a0dYZlEyS2dlc3BUdWpCUUFWOXQvdENa?=
 =?utf-8?B?SC9rdW1sekNPUklobTN3Z3kxRjRQZEJKWDlyK1dzTjVpenRxL05lYzQ3bVVR?=
 =?utf-8?B?LzFTdWEvWndpVVFueXZqQjFWMGNkaVVUeDQrVUs3Q1BacVhXQnVEYnhUcStQ?=
 =?utf-8?B?dGMxVC8vSG9EQnU1NElNL0V2SEFEZGtOcmJiSlFNZHNpT3ZJOXY2eHZpRFFq?=
 =?utf-8?B?Y0JhVGlreDM3TlBXNGRkeWpjeVFFVDhvTSs4ZXhKeGdZaVBQTGxtUDMyOUo3?=
 =?utf-8?B?bHdDc0lqbWtsYUp2ZkNndHRCZnZuRGlYREgrbjhEcytvbHYxRWZCeS9IcDli?=
 =?utf-8?B?b01Bby9Ra0xXdDRia3V0Znk5T1h5Nkd0TUpWRlEzZHZKb3h6WmhHM1Q5U2kw?=
 =?utf-8?B?RlFxaFhoZ3pyajA3OXZiMlU2UnJWN2NUaTNWUHVURmhIQjBqS3pZZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3970AF4E2F47C4DB6CF4713F3E317C1@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PiLmQGaTQp9nVwEEcFY8h87//+fQsM/r6ojqk79YYyyczR4b5VDu4lPR4coxmW5HJbga07/I2q4Ale/G+WnNsh1TSQ+Juh1QQiPpn0Epx68l+N51feR7sGrvVsU93i4etIwTxBMXVPppsxVjyu6bO6Q7R0W4MNdbizOWFcd5KzPSJMeX2tcuQpAKWUrEil/06TyTjbskb1VsucUSYhXCPbJFcP1s/IRLsUve5hZXRaReKw2SLJpJtfK4Z4rSGC39gimCxWDZXbdyJP8Tn7J6Qq2ko+FZ2nJli5JFDTrhhy2ZQwB773w2DglqxK4SWEEV34tvVcoPW9JvZUQ+pWOOlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4eb1cf-d573-4bd9-47a4-08de964fc8ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 15:50:54.6366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BBFRQobrb1gAA466idw+dyP639aW+sSL8zh0TdRSOsblJlnUHN1CEeCzmYrn5MX8qdq5djg7R788Z0rbnNjpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3945
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 3eJIiwGThmMK4dwVMoCSNAy7P94KSX3d
X-Authority-Analysis: v=2.4 cv=IfW3n2qa c=1 sm=1 tr=0 ts=69d7caf8 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=2Gdskay3Ssmk8LiQjv4A:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 3eJIiwGThmMK4dwVMoCSNAy7P94KSX3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0NSBTYWx0ZWRfXwrTVVS44BJhG
 KvKvkaKZ/pZ7H1GRVrHO9YG2hCSSUcPX9cF4Dv/JV96JHGy8NvjDgD486Oh9W2yZgPoQeHS8vTr
 ByTHcoVV+ST8sah3gJ6aOANJ+ap28GsPG0qIlD3eZLQP73vITLYdvo0f1yZAubO0mHblV0f+c7x
 ppZvB1/h9xHetO8CwGncCDVP3WjmhzNh+LAC3sftmsKBJcyU0v0VeeIQHYvsSUUFV8KPpAFOdJL
 zcPeaK/wLZWHrWLjfniAHAMu4hUrvF7in/ooKZcND5uFq6licOksTM71SSXdstBx1TIYbdxv8lf
 jM4TmwPToVxUfK6g71w8jNODoQqwfiLApbbDpXSIMTYfmqEuKqYbRpk8pVJYLRq5EoPe+2IkpI4
 tMEqY4cQquTqUILuy/7AtN8TktejnOsOkGOJ/Eg3/NexD8hExL6KQ0LStSYZpuCCW+FJ8jRieRq
 vNs301NncDP2vzegIaA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090145
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,roeck-us.net,quantatw.com,carsten-spiess.de,gmail.com,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235436-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid]
X-Rspamd-Queue-Id: CF7AC3CD6BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpPbiAyMDI2LTA0LTA4
IDE5OjMwKzAwMDAsIFRob21hcyBXZWnDn3NjaHVoIHdyb3RlOgo+ID4gRml4IHNldmVyYWwgaXNz
dWVzIGluIHRoZSBwb3dlcnogZHJpdmVyIHJlbGF0ZWQgdG8gVVNCIGRpc2Nvbm5lY3QKPiA+IHJh
Y2VzIGFuZCBzaWduYWwgaGFuZGxpbmc6Cj4gCj4gUGxlYXNlIHNwbGl0IHRoaXMgaW50byB0d28g
cGF0Y2hlcy4KPiBJdCBoYXMgbm8gZG93bnNpZGUgYW5kIG1ha2VzIGV2ZXJ5dGhpbmcgZWxzZSBl
YXNpZXIuCgpBZ3JlZWQsIHdpbGwgc3BsaXQgaW50byB0d28gcGF0Y2hlcyBmb3IgdjQuCgo+IEFs
c28gZ2l2ZW4gdGhhdCB0aGUgc2VyaWVzIGZpeGVzIGNvbXBsZXRlbHkgZGlmZmVyZW50IHRoaW5n
cyBpbgo+IGRpZmZlcmVudCBkcml2ZXJzLCB0aGV5IGNvdWxkIGJlIHN1Ym1pdHRlZCB3aXRob3V0
IGEgc2VyaWVzLgo+IFRoaXMgd2lsbCByZWR1Y2UgdGhlIHNwYW0gdG8gbWFpbnRhaW5lcnMgb2Yg
dW5yZWxhdGVkIGRyaXZlcnMuCj4gTXVsdGlwbGUgcGF0Y2hlcyB0byBhIHNpbmdsZSBkcml2ZXIg
Y2FuIHN0YXkgaW4gYSBzZXJpZXMuCgpNYWtlcyBzZW5zZS4gRm9yIHY0IEkgd2lsbCBzdWJtaXQg
dGhlIHBvd2VyeiBwYXRjaGVzIGFzIGEgc3RhbmRhbG9uZQoyLXBhdGNoIG1pbmktc2VyaWVzIGFu
ZCBzZW5kIHBhdGNoZXMgdG8gb3RoZXIgZHJpdmVycyBzZXBhcmF0ZWx5LgoKPiA+IDEuIFVzZS1h
ZnRlci1mcmVlOiBXaGVuIGh3bW9uIHN5c2ZzIGF0dHJpYnV0ZXMgYXJlIHJlYWQgY29uY3VycmVu
dGx5Cj4gPiAgICB3aXRoIFVTQiBkaXNjb25uZWN0LCBwb3dlcnpfcmVhZCgpIG9idGFpbnMgYSBw
b2ludGVyIHRvIHRoZQo+ID4gICAgcHJpdmF0ZSBkYXRhIHZpYSB1c2JfZ2V0X2ludGZkYXRhKCks
IHRoZW4gcG93ZXJ6X2Rpc2Nvbm5lY3QoKSBydW5zCj4gPiAgICBhbmQgZnJlZXMgdGhlIFVSQiB3
aGlsZSBwb3dlcnpfcmVhZF9kYXRhKCkgbWF5IHN0aWxsIHJlZmVyZW5jZSBpdC4KPiAKPiBwb3dl
cnpfcmVhZF9kYXRhKCkgaXMgZXhlY3V0ZWQgd2l0aCB0aGUgbXV0ZXggaGVsZC4gcG93ZXJ6X2Rp
c2Nvbm5lY3QoKQo+IHdpbGwgYWxzbyB0YWtlIHRoYXQgbXV0ZXgsIHNvIEkgZG9uJ3Qgc2VlIHRo
YXQgcmFjZS4KCllvdSBhcmUgcmlnaHQsIHRoZSBtdXRleCBzZXJpYWxpemVzIGNvbmN1cnJlbnQg
YWNjZXNzLCBzbyB0aGF0CmRlc2NyaXB0aW9uIHdhcyBtaXNsZWFkaW5nLgoKVGhlIGFjdHVhbCBp
c3N1ZSBpcyB0aGF0IGFmdGVyIHBvd2Vyel9kaXNjb25uZWN0KCkgZnJlZXMgdGhlIFVSQiBhbmQK
cmVsZWFzZXMgdGhlIG11dGV4LCBhIHN1YnNlcXVlbnQgcG93ZXJ6X3JlYWQoKSBjYW4gYWNxdWly
ZSB0aGUgbXV0ZXgKYW5kIGNhbGwgcG93ZXJ6X3JlYWRfZGF0YSgpLCB3aGljaCB3b3VsZCB0aGVu
IGRlcmVmZXJlbmNlIHRoZSBmcmVlZApVUkIgcG9pbnRlci4gTW92aW5nIHVzYl9zZXRfaW50ZmRh
dGEoKSBiZWZvcmUgcmVnaXN0cmF0aW9uIGFuZCBhZGRpbmcKcHJpdi0+dXJiID0gTlVMTCB3aXRo
IHRoZSBjb3JyZXNwb25kaW5nIE5VTEwgY2hlY2sgaXMgc3VmZmljaWVudCB0bwpwcmV2ZW50IHRo
YXQuIEkgd2lsbCByZXdvcmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZ2x5LgoKPiBJIGRv
IHNlZSB0aGUgdmFsdWUgb2YgdGhlIHVyYiA9IE5VTEwgYXNzaWdubWVudCBhbmQgdGhlIGFzc29j
aWF0ZWQKPiBjaGVjay4KCkFjay4KCj4gVGhpcyBhbHNvIGxvb2tzIGxpa2UgaXQgY291bGQgYmUg
c3BsaXQgaW50byBtb3JlIHBhdGNoZXMuCgpJIHBsYW4gdG8ga2VlcCB0aGUgdXNiX3NldF9pbnRm
ZGF0YSgpIG1vdmUgdG9nZXRoZXIgd2l0aCB0aGUKcHJpdi0+dXJiID0gTlVMTCBhc3NpZ25tZW50
IGFuZCBOVUxMIGNoZWNrLCBzaW5jZSB0b2dldGhlciB0aGV5IGZvcm0KdGhlIGRpc2Nvbm5lY3Qt
c2lkZSBmaXguCgo+ID4gMi4gU2lnbmFsIGhhbmRsaW5nOiB3YWl0X2Zvcl9jb21wbGV0aW9uX2lu
dGVycnVwdGlibGVfdGltZW91dCgpCj4gPiAgICByZXR1cm5zIC1FUkVTVEFSVFNZUyBvbiBzaWdu
YWwsIDAgb24gdGltZW91dCwgb3IgcG9zaXRpdmUgb24KPiA+ICAgIGNvbXBsZXRpb24uIFRoZSBv
cmlnaW5hbCBjb2RlIHRlc3RzICFyZXQsIHdoaWNoIG9ubHkgY2F0Y2hlcwo+ID4gICAgdGltZW91
dC4gT24gc2lnbmFsIGRlbGl2ZXJ5ICgtRVJFU1RBUlRTWVMpLCAhcmV0IGlzIGZhbHNlIHNvIHRo
ZQo+ID4gICAgZnVuY3Rpb24gc2tpcHMgdXNiX2tpbGxfdXJiKCkgYW5kIGZhbGxzIHRocm91Z2gs
IGFjY2Vzc2luZwo+ID4gICAgcG90ZW50aWFsbHkgc3RhbGUgVVJCIGRhdGEuIENhcHR1cmUgdGhl
IHJldHVybiB2YWx1ZSBhbmQgaGFuZGxlCj4gPiAgICBib3RoIHRoZSBzaWduYWwgKG5lZ2F0aXZl
KSBhbmQgdGltZW91dCAoemVybykgY2FzZXMgZXhwbGljaXRseS4KPiAKPiBXaGF0IGltcGFjdCBk
b2VzIHRoZSBzaWduYWwgZGVsaXZlcnkgaGF2ZSBvbiBVUkIgdmFsaWRpdHk/CgpNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgb24gc2lnbmFsIHRoZSBVUkIgbWF5IHN0aWxsIGJlIGluIGZsaWdodDog
aXQKd2FzIHN1Ym1pdHRlZCBzdWNjZXNzZnVsbHksIGJ1dCB0aGUgd2FpdCB3YXMgaW50ZXJydXB0
ZWQgYmVmb3JlCmNvbXBsZXRpb24gd2FzIHNpZ25hbGVkLgoKSW4gdGhlIG9yaWdpbmFsIGNvZGUs
IGEgbmVnYXRpdmUgcmV0dXJuIGRvZXMgbm90IGVudGVyIHRoZSB0aW1lb3V0CnBhdGgsIHNvIHVz
Yl9raWxsX3VyYigpIGlzIHNraXBwZWQgYW5kIHRoZSBjb2RlIGZhbGxzIHRocm91Z2ggdG8gcmVh
ZAphY3R1YWxfbGVuZ3RoIGFuZCB0cmFuc2Zlcl9idWZmZXIuIEl0IGNhbiBhbHNvIHJldHVybiB3
aXRoIHRoZSBVUkIKc3RpbGwgcGVuZGluZy4gQSBzdWJzZXF1ZW50IHBvd2Vyel9yZWFkKCkgdGhl
biByZWluaXRpYWxpemVzIHRoZQpjb21wbGV0aW9uIGFuZCByZXVzZXMgdHJhbnNmZXJfYnVmZmVy
IHdoaWxlIHRoZSBwcmV2aW91cyBVUkIgbWF5IHN0aWxsCnJlZmVyZW5jZSBpdC4KClRoZSBVUkIg
bWF5IGFsc28gY29tcGxldGUgbGF0ZXIgYW5kIHNpZ25hbCB0aGUgY29tcGxldGlvbiwgd2hpY2gg
Y2FuCmludGVyZmVyZSB3aXRoIGEgc3Vic2VxdWVudCByZWFkIHRoYXQgcmVpbml0aWFsaXplcyB0
aGUgc2FtZQpjb21wbGV0aW9uIHN0cnVjdHVyZS4KCkNhbGxpbmcgdXNiX2tpbGxfdXJiKCkgaW4g
dGhlIHNpZ25hbCBjYXNlIGVuc3VyZXMgdGhlIGluLWZsaWdodCBVUkIgaXMKY2FuY2VsbGVkIGFu
ZCBpdHMgY29tcGxldGlvbiBoYW5kbGVyIGhhcyBmaW5pc2hlZCBiZWZvcmUgcmV0dXJuaW5nLgoK
PiA+ICsgICByZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGVfdGltZW91dCgm
cHJpdi0+Y29tcGxldGlvbiwKPiA+ICsJCQkJCQkJbXNlY3NfdG9famlmZmllcyg1KSk7Cj4gCj4g
U2hvdWxkIHVzZSBhIGxvbmcgdHlwZS4KClJpZ2h0LCB3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVy
cnVwdGlibGVfdGltZW91dCgpIHJldHVybnMgbG9uZy4KV2lsbCBmaXguCgo+ID4gKwlpZiAocmV0
IDw9IDApIHsKPiA+ICAJCXVzYl9raWxsX3VyYihwcml2LT51cmIpOwo+ID4gLQkJcmV0dXJuIC1F
SU87Cj4gPiArCQlyZXR1cm4gcmV0ID8gcmV0IDogLUVJTzsKPiA+ICAJfQo+IAo+IElmIHRoZXNl
IGNhc2VzIGFyZSB0byBiZSBoYW5kbGVkIGRpZmZlcmVudGx5IEkgIHdvdWxkIGp1c3Qgc3BsaXQg
dGhpcwo+IGNoZWNrIGludG8gdHdvIHBhcnRzLgoKQWdyZWVkLCBjbGVhcmVyIHRoYXQgd2F5LiBX
aWxsIGFkb3B0OgoKCWlmIChyZXQgPCAwKSB7CgkJdXNiX2tpbGxfdXJiKHByaXYtPnVyYik7CgkJ
cmV0dXJuIHJldDsKCX0KCglpZiAocmV0ID09IDApIHsKCQl1c2Jfa2lsbF91cmIocHJpdi0+dXJi
KTsKCQlyZXR1cm4gLUVJTzsKCX0KCj4gPiArCXVzYl9zZXRfaW50ZmRhdGEoaW50ZiwgcHJpdik7
Cj4gCj4gQWNrLgoKPiA+ICAJaWYgKElTX0VSUihod21vbl9kZXYpKSB7Cj4gPiArCQl1c2Jfc2V0
X2ludGZkYXRhKGludGYsIE5VTEwpOwo+IAo+IElzIHRoaXMgcmVhbGx5IG5lY2Vzc2FyeT8gSWYg
dGhlIHByb2JpbmcgZmFpbHMgSSB3b3VsZCBleHBlY3QgdGhlCj4gdW5kZXJseWluZyBzdWJzeXN0
ZW0gdG8gY2xlYW4gdGhpcyB1cCBhbnl3YXlzLgoKWW91IGFyZSByaWdodCwgZGlzY29ubmVjdCBp
cyBub3QgY2FsbGVkIG9uIHByb2JlIGZhaWx1cmUuIFdpbGwgZHJvcC4KCj4gPiArCXVzYl9zZXRf
aW50ZmRhdGEoaW50ZiwgTlVMTCk7Cj4gCj4gV2h5IGlzIHRoaXMgbmVjZXNzYXJ5PyBUaGUgaW50
ZmRhdGEgaXMgYWxsb2NhdGVkIHRvIHRoZSBwYXJlbnQgZGV2aWNlLAo+IHNvIGl0IHNob3VsZCBu
b3QgYmVjb21lIHVuYXZhaWxhYmxlLgoKQWdyZWVkLiBUaGUgcHJpdi0+dXJiID0gTlVMTCBjaGVj
ayB1bmRlciB0aGUgbXV0ZXggaXMgc3VmZmljaWVudCBmb3IKdGhlIHBvc3QtZGlzY29ubmVjdCBj
YXNlLCBzbyBJIHdpbGwgZHJvcCB0aGlzIGFzIHdlbGwuCgpUaGFua3MgVGhvbWFzIGZvciB0aGUg
dGhvcm91Z2ggcmV2aWV3LgoKVGhhbmsgeW91LgoKUmVnYXJkcywKU2FubWFuIFByYWRoYW4K

