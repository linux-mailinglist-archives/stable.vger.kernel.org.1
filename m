Return-Path: <stable+bounces-58966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC292CC34
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FC0B21EB6
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542C77F49B;
	Wed, 10 Jul 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MAjxMHte"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021129.outbound.protection.outlook.com [40.93.194.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AC2CCB4;
	Wed, 10 Jul 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597711; cv=fail; b=tZzWOHqnudLLvYtpZLgmkoN01Fd/IJODN0jG48Y1UkB6za+5MQIQ5tfXZiUeyr+7XjbZGNdTrxnag3Mt0hyFJRmFv+scXRsBN/w5PyOrMtnH9I520HOzy22jkiaqQZ8qRztBiHL52YyKs/RNCUzSAQSSqyFDe4YNQkxXl+WXYus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597711; c=relaxed/simple;
	bh=k/3gDUeLOc92hL02uBDM6FgRROGImC0xCaJ+bxvJSBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SH9lI8ieCN6T/UiI6gL4C9pl9GAQyJRSh+VSqxkPpHaurmaDqWRNJCYkViTkObqgSP+34LT+piRSy5rLNl8mkw/9xwo1zBgpELpdet8kSgv9LhGsOsW72tgDCH38WBgU6g4x2BR0iBKWqxwGzijhRxAMjFTQAlrDxNJGRBq3t5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MAjxMHte; arc=fail smtp.client-ip=40.93.194.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0tM6BDr4ejQRc4ukvSd1ZTQ8fV30OtttpzyXxtSKX0SQbrBJ3bwyaOzRVC7ZCPMetSKOjcIO6b5ib5N/oeYnRsa+5Sqrm+oeVHN3wL1HectMC27Q1w5gkyeNDhC5/oyHlQIv3mvZ+TiL8Cjz5L8xOyZAwcK1Uoo83ROfcu3T0rmj+BTS1f5h7JIDgBZAZNuP1BBN5eCILC4etqaA47b0r1XLpqPGVBJqZ7/UU9dpnrAgA10RqW1x3axd+6yMrjI6v0C62z9cO5EfVMoXvKOzzEIvx1uzJd799BTZN1FHwV9F+5Q721QCdni0S0KtEtgAXTwioeyXTfPWKKM/0CUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6D0nQn3idexlpI7y1TLWpKDDrkXcJJ3mp/FY7pc2Z4=;
 b=DVseM9bRetPCFGaYRN657S+qWiGIoaM0QCRNdBLp9dsFxXlRgeRGt5zb+zcFMRTaZUWQx7Gb4a5o6m3qtdEy2OGCrczSzG7YeA/zNTTC7CKqLNsA07tvohZOeea5aKOba6B09H7M3cTYKn2aZo0HazVrGA/uf0NZyQ1Nfq1Ux0ETEUemTfLDT7XypNvgZ+zcZA6nw4sbFWXPH3pU5F/FmVKSnqg3V0mpop7eX7apk+CQBtQHM7j7TkI3GpjNNqqaD3HFmkClie8MBw9sGL5KfXMNY+xX/+4tp/3eRsVqUZG08jJaAV5X5k8LhJuxGaYqg8i0nnEOu4SbbJ7h/enRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6D0nQn3idexlpI7y1TLWpKDDrkXcJJ3mp/FY7pc2Z4=;
 b=MAjxMHteUAtkCzwXebloB/f3+D/exRr3QYuy3oNlIljrDkDhuVQtW1lH5juD2SdhIaHlFBzyPIt9IlpwcF5t47DKUIM+u8SujqURY17PtCze3cuEImiKoBUbP/NUSKj2MKjZdyUqTix2hF8mNvJ6zF5rjKA31gfwong4oDbnpHw=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by CH4PR21MB4218.namprd21.prod.outlook.com (2603:10b6:610:22d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.5; Wed, 10 Jul
 2024 07:48:14 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%6]) with mapi id 15.20.7784.001; Wed, 10 Jul 2024
 07:48:14 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:X86 TRUST
 DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, Michael
 Kelley <mikelley@microsoft.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Topic: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Index: AQHa0Wtpz0U6bwgC9Ee4DSiEch1K2bHtOg4AgAEDVACAAUnJMA==
Date: Wed, 10 Jul 2024 07:48:14 +0000
Message-ID:
 <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
In-Reply-To: <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3268431-e318-44b3-93fa-31ea7c931370;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-10T06:47:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|CH4PR21MB4218:EE_
x-ms-office365-filtering-correlation-id: 9d36d2bf-74af-47ff-8507-08dca0b4a76c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N4Fl2I0CrO2pCpnsqNvGSyrfrFfAZpsnQoEGJudcE032IJRK5aOWZXwz5YAr?=
 =?us-ascii?Q?zYLPBbC7Sr7vS66jhsmT5DZvDL2Q1jvW5caWu3qMHzAIxGS266//TiO9nfJL?=
 =?us-ascii?Q?trdVsD3wRdW4OfOXfIyLSsY3t6vDyeTFTgF3aNc1XYtfYX6K6T3eeKR+RaTr?=
 =?us-ascii?Q?JvfW2ka/KChSQDuEwdU5l7bfhTLauQiBTU0glLk+zmIJghWl+qsEneeTOiRL?=
 =?us-ascii?Q?KOu1JXDiMI005cjD5naNtodxtGVukMBQy3o4qsX2ZFo/XkTh1w85Dy6FR04C?=
 =?us-ascii?Q?wzahfHmTztL+1jWNzWqL4QufjORxt8ZvWzQov/4pd7L2JCVZscB9VUYV2BIb?=
 =?us-ascii?Q?fXEds5iTwf5C1bnywaEiCddJJWQ6t8FXsCLTuemHhEctzJrxMpSKG4uFaLqZ?=
 =?us-ascii?Q?9oj4r5G7324wMeFGdvzVrtQ5xheShoKxRWRsbI5an2ROywP26/yk37kb04pU?=
 =?us-ascii?Q?VXdQFYNCDzaRgQ/RmP4SYyy3dV25Ngu4UiWpIH2mL4X+HlVlWzz/qV0dDKjb?=
 =?us-ascii?Q?kwXpSzsgNTy7AXL3crbaUdNno8C6jq3bdJFalRIRfR6E8AaPFca0R2rl0rbF?=
 =?us-ascii?Q?Rpi+kRGUd9+0oywinP8USxDK0FCsC4uf0Zlq6hJlDfqWYKD3m/WXYacpLRMU?=
 =?us-ascii?Q?u3hIcAe0ZMKasjEgvPSJtq1S6V8Rv/kcrl9gFVJgDY6Vnbyk61CNvEkoZw97?=
 =?us-ascii?Q?5sq5ya/CtApW+xESUNi9ZMgZenycK/i4i8kRKN1Dica+cMp9ySQfKgvrqJsZ?=
 =?us-ascii?Q?1Rl6HbKZRRr0WBQRm/PDfqNKWCHL2Nigm8ycBXwKmpZSrz8BTE9cHJxybCO9?=
 =?us-ascii?Q?XjAa8oZDxtY15PQu05A6zCnTfQPR27AXWLJawt/oc5qNOWz/rqCmLBzE3cU1?=
 =?us-ascii?Q?JHVwYsQXmFGPDNFRYGw6cYarb4nqrj1Fat7j/aDTlJ+WYRlq4nrVTuiOZReI?=
 =?us-ascii?Q?S/35Zp+Nt+N9EAkyoUulydf8ky3S3Hcm2BX4IM2FHa5qsy32WttlSdrvoZoW?=
 =?us-ascii?Q?6KT7ktdY2IFz5MIv4BiAxHrH6Twl3ExxcPefyBvMEHnRm0eJlDk/0aOKb8Xk?=
 =?us-ascii?Q?46Qqmwc5wBwMVryObCkWUKQQAGK3DPyohiBIT8mGcVIrjqnPtBtgBPMDXncr?=
 =?us-ascii?Q?TNSLfOxj8yRnybrpXUF6kHYOkXX39hN2jF85TKE4mtz5+jBAsllPeqKOWJmv?=
 =?us-ascii?Q?UnFHoIaC/SrWuHrDPr7SkeqQuq4gIYgWScYQZmSLZMDQ+fiBXxTqX52NFmKr?=
 =?us-ascii?Q?8FBiSPCFthgGutTQ9FsmRG2Pta71S1hvoP33dyf4KLrByq+MqgAC6r9zM3+4?=
 =?us-ascii?Q?81K5iqeileRE5vvywErKKWpXvQeL68wZOs9bAmBvvz5vI6aHPaklelJSno28?=
 =?us-ascii?Q?cgsV4AQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AFPoQusRJUS0FmgnpTALA6YeqBvHINYgdVp5k7E0CFyKWj9BLrIAe/rJr83Z?=
 =?us-ascii?Q?i1NeVz8fPj6dASb0NYyk6fe6aYxR9mX4iXJM9Cr8HwI6ZfLWia8wqvJiGABO?=
 =?us-ascii?Q?mXfkbaujZ88wG6Ide/EXpho/hUB3Z/nHv0LlN0CuJqgKdu0uI5Fh1+UGDkUJ?=
 =?us-ascii?Q?LvRlLD8ns9aYgreT2QD1Q3tSkWDnbM6bZKznVQLpsmh61qjDyo0fhntMRYBg?=
 =?us-ascii?Q?VlO2H8P2nfok8BMJauIySnUm+f7XQ3PQi81GxDjt8FlUpSmukaXwJeqXd3kf?=
 =?us-ascii?Q?Edvz7XZfgn9qaTt3rOinHZGoujS4XXbTv2buhD5euqNwKyyxOwWCXWnpzlkd?=
 =?us-ascii?Q?DQ35hFMUI9aucXk2OhG8+GWOWJSDk6R+F94KwduiInVn7WWWysPhEiYlA92L?=
 =?us-ascii?Q?710u3VFu5ConL1CpATe+OmufavZX4YLO+dqcPSXcJVC3nr3ZvWPvejNccZlr?=
 =?us-ascii?Q?qwmSI+hnmgobT+pHNpjHUc9LfQPEabWdCDZmCtbre/zYeU0xpYiB75sw4PJD?=
 =?us-ascii?Q?vYuajB7DyGkfCDjO94lObax1xLe5n/x+hBqMtih3bHy9MDVt3xbK62uC2r9R?=
 =?us-ascii?Q?VAJm20cjoV9eL6CBsVEAkpFgw2Y5AIq4dQcps6n6s4RtpNLwLUy2743QNlWD?=
 =?us-ascii?Q?YPq8gz6sWdfnRHkWiiXjTpVuUzzhhoQRSzFxCOcpOcEqIX9OEWG7JT9Yxikb?=
 =?us-ascii?Q?xRA2sloZQoEdeODgt0YFZhrDGbQIzA7NdNKjCH12WxnuYcqZ/pU/OybQu1g3?=
 =?us-ascii?Q?p4i0hdV4RgiXxsYE7unf+CUlVXh1RPSvlvdTS1vCq7G/EWwfXWebrcF+DbMM?=
 =?us-ascii?Q?WqPod2AgO4oD8A4QY3e5+ejec0CP9+x71UDqVfPpXn0+98BhqkL0ERh0yiBI?=
 =?us-ascii?Q?6joRQRG/B/FiQQLMTH+MfAPnwmyrJWRbjXSvabneFhSMqJjZ+m0lYdITTgQe?=
 =?us-ascii?Q?NkLWsu3ZJJuB6iHfUUXVLaD2ZTz33k/saXH8629T2N9/9rx5cdx+cQ6ENvaO?=
 =?us-ascii?Q?7BJn2bo83KxKdNHmOH4tk4it0R057j0FiRFFIk3Z7YCzyawkmIqmmSYggGIS?=
 =?us-ascii?Q?mGhcgjy3OSE0fJ8KYIxwl1aS6Rcz3L0mLfHbruAtHTCk1jz6abou1zCbcEgF?=
 =?us-ascii?Q?307iEk8dCSW204AJV8xlgKCY1jjZhFXlp+2n0HVjEIUy2v93x4FNsnrucZ3G?=
 =?us-ascii?Q?QhvBRkkg2+ccPoHOBthlWYC5Hc6Lh1WKFX96mxmu6N1Khd2M/iAn+cxiQ/Gq?=
 =?us-ascii?Q?BiMiDf/h0Yh1vwbQrlHHq3NRGRAj57X1/fE0hJWjJYjCyx93fdR3TeToQ2GR?=
 =?us-ascii?Q?/EJvcmCgeXmRT72eBxI8ag4cY2UQiTl/PAZzLs0k6zVMIBJuCvZ5UrcR3erC?=
 =?us-ascii?Q?A03S9unjeGbwJ5SXUY+tQwctbc82PSxzL++mtWGVEK/5Ci81jRie8EeWJ7Jk?=
 =?us-ascii?Q?4thyzqRm+RMrCvqOZOaoU/bAIedKoY0MPNOlZyDWjYlBvFqM1OU2qMG5FCb9?=
 =?us-ascii?Q?3JviZuj6Kp3fEjEvedCB1XWK4cCf4emEiUHSUbWhp/IeFJ5IaqMay4Tb0T85?=
 =?us-ascii?Q?LHoYCeLtO3hBTwtbNzAOB0oV/hsibTt+otgO6fyM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d36d2bf-74af-47ff-8507-08dca0b4a76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 07:48:14.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc5HMDMrIxJKDqork6iIdBG7GZIHjO5kRw2EqA9CNApWIK9TIkJLhuR8OgwrWLoPAp9QGMkGTep4oLnrR9WgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4218

> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, July 9, 2024 4:07 AM
> To: Dexuan Cui <decui@microsoft.com>
> > [...]
> > v6.6 is a longterm kernel, which is used by some distros, so I hope
> > this patch can be in v6.6.y and newer, so it won't be carried out of tr=
ee.
>=20
> So this is a corner-case thing. I guess CC:stable is ok, we have packport=
ed
> similar "fixes" in the past.

Thanks for sharing your thoughts! Then I'll use these in next version (v12)=
:
Fixes: 68f2f2bc163d ("Drivers: hv: vmbus: Support fully enlightened TDX gue=
sts")
Cc: stable@vger.kernel.org # 6.6+
=20
> > I think the patch (without Kirill's kexec fix)  has been well tested, e=
.g.,
> > it has been in Ubuntu's linux-azure kernel for about 2 years. Kirill's
> > kexec fix works in my testing and it looks safe to me.
>=20
> You seem to think that a patch which has been tested in some out-of-tree
> kernel,
>=20
> - gets modified
> - gets applied to the upstream kernel
> - it *breaks* a use case,
>=20
> and then it can still be considered tested.
>=20
> Are you seriously claiming that?!

I should have made it clear that I think Kirill helped fix and test this as=
 well.
Besides Kirill's testing and my testing, I totally agree that more testing =
is
needed. I appreciate it very much if someone can help identify more
potential issues in the patch. I didn't mean to rush the patch.
=20
> > I hope this can be in 6.11-rc1 if you see no high risks.
> > It's also fine to me if you decide to queue the patch after 6.11-rc1.
>=20
> Yes, it will be after -rc1 because what you consider "tested" and what I =
do
> consider "tested" can just as well be from two different planets.

It's ok to me it will be after -rc1. I just thought the patch would get mor=
e
testing if it could be on some branch (e.g., x86/tdx ?) in the tip.git tree=
, e.g.,
if the patch is on some tip.git branch, I suppose the linux-next tree would
merge the patch so the patch will get more testing automatically.=20

> Since you'd go the length to quote the mail messages which gave you the
> tags  but you will not read what I point you to, lemme read it for you:
>=20
> "Both Tested-by and Reviewed-by tags, once received on mailing list from
> tester or reviewer, should be added by author to the applicable patches
> when sending next versions.  However if the patch has changed
> substantially in following version, these tags might not be applicable
> anymore and thus  should be removed.  Usually removal of someone's
> Tested-by or Reviewed-by  tags should  be mentioned in the patch
> changelog (after the '---' separator)."

I guess we have different options on whether "the patch has changed
substantially". My impression is that it hasn't. Please refer to the
changelogs of v9, v10 and v11:
https://lwn.net/ml/linux-kernel/20230621191317.4129-3-decui@microsoft.com/
https://lwn.net/ml/linux-kernel/20230811214826.9609-3-decui%40microsoft.com=
/
https://lwn.net/ml/linux-kernel/20240521021238.1803-1-decui@microsoft.com/
(v11 is basically a repost of v10)
I started to add people's tags since v4 and my impression is that since the=
n
it's rebasing and minor changes. Anyway, I'll go through the history thorou=
ghly
and document the changes in detail. I'll remove all the people's tags and
mention the removal in the changelog in next version (i.e., v12), and reque=
st
the people to review/ack again, and ask for Kirill's explicit permission fo=
r adding
the Co-developed-by and Signed-off-by.

> From Documentation/process/submitting-patches.rst
>=20
> Again, if you want to keep sending patches to the kernel, I'd strongly ur=
ge
> you to read that document!
Ok. I promise I'll read the document again, word by word.
=20
> > This is not really a newly submitted patch :-)
>=20
> If you still think that and you want to keep your tags, all I can give yo=
u is
> a big fat NAK until you read and understand how the process works.
>=20
> Your decision.
>=20
> --
> Regards/Gruss,
>     Boris.

Stay tuned, please.  I'll try my best to make a good v12, which will have a
long changelog after the '---'.

Thanks,
Dexuan

