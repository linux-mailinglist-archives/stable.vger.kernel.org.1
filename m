Return-Path: <stable+bounces-85069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21C399D702
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F2B283079
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F21CACFC;
	Mon, 14 Oct 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gVfT8B2k"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC1231C83
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932921; cv=fail; b=ebQvBM2eXMEos+jjl/PfTnl98KsJFDlbWRoSYzaustHCt+HbBbMbL/jSiJzqFI0OonGHXKnZ1gd4ss8oT/pFKxIqr3ohCBSMl5dM+6cRWhSHQ+McWOcZZLBX5Kv3T6Q6TOBpbvsQTynol8O5H/MpL/SsviwVLWetaxL6f4DKAYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932921; c=relaxed/simple;
	bh=J6gjklV2SW1R2M4wmCduMXhm0k9FcUQJtIaHCCGqHVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QI00bMuQWKJ9cBzTX3uE8l4xUeYp1SKIs87Kth9MraEUIxCE8FRr5hFPJ64sg4bUYeQivtmUWwhChpid2A7rhtUY4ceKViYzqeiqDYip0Y/SscZigRPWCDFUoZBWUFKnW0cRgQLQUnqLUp4Az4zAzNtn303kLphDwN5weekzUVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gVfT8B2k; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpStcaWm8XZTa2W822KNS2SGGrKv9VjuBeOXQShu+X2EQJ3XvNvNlznELRm1YPTxU3EGJgr6cLT/O7FwlXqhVl2EXoHLCfhMgubi11IaUcYj9bx9S2SnB8sJJ/NgDkx/7oeu19K3Gcy8L1URzTECwj8APG3bjW2jk4UVyL1aHaf/IdEGWqiuqjlseeaj2EqXp4USjO00WmuFRmXSoOT+CFq+ApGnfbpraAiRTgS6AHeJQvzw6VghfyFwmtO1wWnQMtPafF8WZYWrvsUdizruoK0gqElBCbzPhDx45axNQXRl0+04CV6jsb28qgdg7L42ZAqkNsLymFKntpaLJmiT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifdEI2oo+K1LTmm2kNYh99ZPG8Zb4rKls1CTMriF924=;
 b=WlxyZdw3fVKAU/6x1KB/FozKuPVUilWavtf22UWH75YNFjadBseN9RNoC0jS7HdTAsVazz49yRgxcPQngge4m1BwGAyoL5AJEursiM8v0T93XMQbFjHMq24O1zpFnY4ozvUuu8mPSss5e9rHoMWAH36oRWvIBShDQwvIN+5xoROKxr8ZrKQMJXN1zy3T0A3GQqcofckhXra6ogoFsg9Ck3BexnX5GarbyybrZndVO3PA8pvEu5JCRj4F+GNs+E8kXjt2kW1dUIhK4fZxPsUJASVtcbr0JyuC1wUNY5jK2W1pOIG04tEbcAqoVl/Pg2HzgzQuko16a/C3kIm65kP1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifdEI2oo+K1LTmm2kNYh99ZPG8Zb4rKls1CTMriF924=;
 b=gVfT8B2kH7lhH4YR3H6JOtT+0xO8LniCzm7m8xtiO5da+78G80vx2X0qlxSk+AvqyvvQlg9xwpq3lhDIB6/a/iLuFdsF+M+gTqMDaHjqYTu7tsa7uN+CEZpYoBc2g9yS1KTS1eYEg+j9mOFthphDEkliDguo8R+i+94ZvM7WW7Y=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 19:08:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:08:35 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
CC: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Rossi, Marc"
	<Marc.Rossi@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
Thread-Topic: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
Thread-Index: AQHaWHxNAS/3vh4Q3keWm72Mdrer5bKGvW+AgAFqW6A=
Date: Mon, 14 Oct 2024 19:08:34 +0000
Message-ID:
 <MN0PR12MB6101BA1509A6D9B6338EC8E9E2442@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20240205211233.2601-1-mario.limonciello@amd.com>
 <20241013213103.55357-1-stuart.a.hayhurst@gmail.com>
In-Reply-To: <20241013213103.55357-1-stuart.a.hayhurst@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f60842d2-0815-459b-aa52-b29da8f1f122;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-14T19:07:58Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB6351:EE_
x-ms-office365-filtering-correlation-id: 32f90e3e-c40d-4ff3-293f-08dcec839a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OKjT7djmrpNAmQNF2pA5HsAqDskDEQCokNdTTJdqy22FCPlHcfk7jHu4m5ZH?=
 =?us-ascii?Q?2BE1FI+za5aMkEYE90Jc6BUV53DriMLNURMTa1VNJHoyhMUtMxwvqb7uDpkt?=
 =?us-ascii?Q?F375CP8UKyBmzoa0WiyGx2Nr9TS/c0k8XzdrnwdTP3WLQR+CsNu6MCdIfmVh?=
 =?us-ascii?Q?gmVaXLr7opVVZilznkfHtnu47Fjd/B2laaDgTHEbxdgLn3/625VECmiGT52T?=
 =?us-ascii?Q?lY/4RKgB8t6+BjJQS174ztFWdNvlTAA4zvgmXvGlZJEYguAaCqY4/DXOYDgn?=
 =?us-ascii?Q?O6HLU7Wv04jGMT5K3JWJ8XkpNa35poan+rCVmTsG9oIrWKyPDffSLV24RRN2?=
 =?us-ascii?Q?QJanlrNO4GX2idSRDLGIemktRCWEFAbOyN1Ry8vbCb9YzFLFHwQmaS0aGfXF?=
 =?us-ascii?Q?LuLG6wsiBJX9YGtR7UKUJABYsUlTzLgJ9N2AxSp8FVTBkVsaUhifVWnd+fz8?=
 =?us-ascii?Q?ktEGkyWokcpr3Pmi+KfoO8MKJtWrzhoh/lquFUOOtqp9hvJi+4eetC1US44p?=
 =?us-ascii?Q?kkFYQrEEt4NFgrzHMtI85CPcG+BmZnvO3e+922cBApPj9beIjBgXjUMPshco?=
 =?us-ascii?Q?uieO7sxVh0RIhpz//4AeRGFZieVbSpeStrpygKoKroh9wK0Wv3Fr+5yZjkK/?=
 =?us-ascii?Q?w8iywGumckmC1z0hbCF8vLYZrn4spgcUIZhpsw85A2H/xaHvi16AHIgP0qMq?=
 =?us-ascii?Q?ghMJ9MfJRIyQWITlk2Rsk8Zb30p2INsf/hE9CL1PnIYe/4vf+KLpKxyxkdjE?=
 =?us-ascii?Q?ZmS0cLjurjLsmIR8/5zWTAMZjnKNJlt1jBzDm/wXhzMx/Xw9rmCeCTtj2OHb?=
 =?us-ascii?Q?aDC525PdWR//f56k/ChQtQ6Njwc5J9bFy/3Xg4JCqDczF8dTXm0RlG8FxfLZ?=
 =?us-ascii?Q?iSmSeRLAysa1bi4b1E+P0fjJJ8NeqtvspdUTlLJcggE5vgzrJ7yS0TQxcbpz?=
 =?us-ascii?Q?hu+Ws9zXqQXubErxcDrfwLXW6/LUp2c4SlCmHzdfDjVcX6EkK9EzGnf0U6OC?=
 =?us-ascii?Q?da3LN5OSfc/MVinnVrwNqf9wC+s+SBUmmJPka2/3uFfmDcXTs2JDVvdvsq9P?=
 =?us-ascii?Q?Xcl30WMNlntFpL4+lEoaZGJdz9bRv0GK/FqXhi1/abbjdBpDXHBnSHksPl/8?=
 =?us-ascii?Q?4YenEfgfAacYCY582ywxhSZmZ0Brpyz9cirPaTZh1gJpOMCHgSZPBrP+xBOD?=
 =?us-ascii?Q?pC0IO+BvVhCRWxNxCm0Rj3eXfUp89SMxsLYiqSlI+jWkFtjEpsooAo88PjiB?=
 =?us-ascii?Q?UARB2hjYb57ftNOcNHAFs51OTaqLV4fKPCvHwsP7ZcObP5sgVoDyeCd2tLCT?=
 =?us-ascii?Q?n/t10XQGrxInmia3oX7YK7Z6WcAo3a1H3SWhjIUjYiXiyA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Keh56MhJwtyRtkiNrUgj3DTVQMNIw5rG0SIZ5WULZwrEcYdU3tsFX6a37zd7?=
 =?us-ascii?Q?X/sJm/mCH+TNHYatAoNlrtGhJH1LO8M2f2lzRAlYsZlmijvFl0qG0IULlbbz?=
 =?us-ascii?Q?ZHQnrfVhaWhmW4sOPwDSWw+7ribtms0UVYHD3XkOzamprM/3ELADZiM1e2nv?=
 =?us-ascii?Q?+XkPoycZM6oTlPnh48uxQviWreQdnSgeq+4JsbmKvXpyj5M1J1X5Jt3Mi1t2?=
 =?us-ascii?Q?od7J6Fc4gCkylLFZvxTQb89xkblMwrNfuZnAklcgLLgYyWn3o6gi/mlxt54n?=
 =?us-ascii?Q?hTcDZElP8Ny+ZQeZMAXWlforLkAx6lSZihgoJz20UoXOoyhYwMg72g7KI21C?=
 =?us-ascii?Q?UgUiVwiJGcFyANq8ZQNYV5a0ZzRqO+nKgff4x06PqHa+YXF9Tf0ReFInf00y?=
 =?us-ascii?Q?uwPUN9Vb9wqf/yjBNpmivp+QPiF4I8cizr6A3ZX9syzHUkYcrCHu+U6Zt+TW?=
 =?us-ascii?Q?3M7J0TtB5Cpw7q7ATSYoOsP2ZX6ECpatcEHMW6xs3+eR14CQiC7lLnOIsi9+?=
 =?us-ascii?Q?+CC2CwGhwUpn1GfLrp5r+KpKfZNg6JiijZKYejM6sCQH71BAkA/SI6JqI075?=
 =?us-ascii?Q?pMeRXdDoMJ74keS5CF1F3RLECeIMMKhhHH7HpIKYqy+6OQQMv0ODE17x7t6n?=
 =?us-ascii?Q?cm7T3C46SGh6SiMpOHuBrE2uKGjZJ/d3TqwZV83iRCtvMzmuILTTQmEreofp?=
 =?us-ascii?Q?G7YJIPc67jUMq8gnTF/u1U5SVy3gKrGw67iGWmIpWQi3yJryiTK09XEIK5Pw?=
 =?us-ascii?Q?htEO3iaA0hbf/n/JrnV133PvaiEG5jDIjuZk2p0FIK6NVk5Hf9b6pHakQ9gU?=
 =?us-ascii?Q?tA3vFRnqbpCzxtYKir+mwn5VQqM29s3Dg8/Plh3ezXsYeQf2peAkx0rCFgFL?=
 =?us-ascii?Q?2yFO1i8ss/ntK5DhZAdh3nxomUeESt4im+4e3/nweiXaH7ojcoqNxS70i5SF?=
 =?us-ascii?Q?nxsH0HxvXLOIUqmTGjSwC3C6FwHoP5BeGXiL3I2YY6j1++yQ6XO+VDz1uR/M?=
 =?us-ascii?Q?y06ACR3jrF99UuoQHr8Tg+v/0SdRg7xggSKpFzoyDdvO00d4i6te9uAM70yk?=
 =?us-ascii?Q?+fH5dNZtsnsEFnrU1aywAkplP1nxbjkRmStFn8WtPkV569T194TPW5Z0foOe?=
 =?us-ascii?Q?TZcWvOVaniyVRiNnWokOu0ROHeeKGFHP79ffviZdOeSP1UOjPC/QaI/iNQmT?=
 =?us-ascii?Q?jhRHDugLOwujTE7KXh9njHUtwJRF4F8sFTg2OoNHMEaOF9HySTwgrJeZ2MFx?=
 =?us-ascii?Q?B4X1EVaTJIWfuF1Za/pZZDA+hVxaJtLzjNLCQ6WkM8lA9rHOiWmM1yoOAI56?=
 =?us-ascii?Q?QyBH/0A8NAFJ2JeqcURCiB7FUv+EKcUsrBDSbk6KqQ6QdtM6xEzMSqU/0eIY?=
 =?us-ascii?Q?LcvP/5gfmuG5nWPsG2ecoose990erNof0uyMYrTr7fPIeqTpJR9dytKa/T4F?=
 =?us-ascii?Q?oEu0kCu0V+yMnTc8Z8oyM/C8OYeeaW6LJprVsXt1dbkixlTCeU2cAl61Bpon?=
 =?us-ascii?Q?gkJmR96pIWfumLsGbrCESKlEZ0gCWmIKxG4aElXzwGQ/uGk+6xzJQsRG7ZwH?=
 =?us-ascii?Q?+s/AiZ9Qlf3edtR9A2o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f90e3e-c40d-4ff3-293f-08dcec839a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 19:08:34.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hXDkJSJ1MRv60sWtJviFiANFADDjIU9/y7zA8LuNlkzKR5rtEelGJ6ijZwVTKVKOovNwbl2edb8lZhSLpVyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Stuart,

Is this on a mainline 6.11.y or 6.12-rc3 kernel?  Can you please open up a =
new issue with all the details?  You can ping it back here.

Thanks,

> -----Original Message-----
> From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Sent: Sunday, October 13, 2024 16:31
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Rossi, Marc
> <Marc.Rossi@amd.com>; amd-gfx@lists.freedesktop.org; stable@vger.kernel.o=
rg
> Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON
> too
>
> Hi, can this be considered again please? Still facing issues with the 660=
M in
> my Lenovo Yoga 7 14ARB7. This fixes the weird behaviour I have with black
> screens, back-traces and flickering.

