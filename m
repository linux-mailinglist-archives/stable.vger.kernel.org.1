Return-Path: <stable+bounces-106661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF829FFD6D
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FE3162C60
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DFA1684AC;
	Thu,  2 Jan 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X9bAC6fs"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2426AC3
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841326; cv=fail; b=bWLXtgnonpRyDBUeZvemh/i/41ii/+SDr0YLpasj0wdonf6XzZI4qwl0DjguW2ZAk90ejfDpg+Hp4tRs81AnZgDv9ZcmdhIwTpK8g/42a30oMKGGvuCosmvuynP3rwMhXRcT5qMOKowesaG2idWTM0egMtJSog1YGC7yWX95rV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841326; c=relaxed/simple;
	bh=4suKuuLEeRQmeVZq1gWmJ+aIJ+kLLdj/Ltg2w2T/A/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R0SUxRHoTbZWy38kvbqiVpfmWXuDo/J3W6H7Yee4cYo7jHqBopf36uF2aklxVoY7IWIFbXDXnWOxs7l8GuIVzk8EFQYX6Sb2dV/FZlt3DdTZnu5FDpGkhmbfoaHGL0S1xEsn15n8yhEbE0wTIviL5U9T8ltVnO4BOaek7+SIw4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X9bAC6fs; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVZZbLZszfxr9nywYHveh/3pkh8EdkAi+wh8ncU5y3oRQ6jbnoufgL1iljftKozdDf+JV9hbt+D6jdatUsuok/mgPXQRIniK1s7kTlAWR8z+2PptpQK1g7l6M/7ayRZRRfKsxx8LlBeAatFWzW7KGzVGgGs74PiokVBeEQKnA0/jg8kmTNGlGdVf+ctqR/eKQTrq42e5ir6PA8xaWaDCDZ0haDITXid50ccxyq0wuUEFSkonme9j6AuNnr/A6VSN7A33CZbfveRQR1vQC970e731GdOaz3ZiRsswrkCLIy/ic6MWxuliFcUbdabjfktbocA0+1+Q4MR8u6NdLjc8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fCnMPWaoQeJB0SDntMA0EZf8tOKU2o3NQG0EGtw7BU=;
 b=rVPSiAnpCqctLhbQiKzPnmVIkPEt/L8DEO2el8Rc+I+mNj0D6ORnkJ3xPb9FVGuIHNbxD3PdiL2WpatwmXHLUFuNT6me9NTklpezTxeVZe6BqpyA/nBnyNSBlg+kANsEph5NKRZDRLrGGpUUrfidhPZo8jvd7XZFBwukOLEHf8k/c5r/D5s2LWB1npeHtygVt5QCFWrQwDDBjR1sYVfymXslYKmJ6L8mapM3hZM7YZXsdR1MIwWfRqQQoTbh5CLtTitpEva8o6EUYSPECo3CfWKtDe4hhcKmFImLLo1vDW/fSQuNHkN89U075cez/mKgfA5AE9iZ4ei5rzoNK9T0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fCnMPWaoQeJB0SDntMA0EZf8tOKU2o3NQG0EGtw7BU=;
 b=X9bAC6fsnaa/lPNHD2Hl5R5zy5JYwJT0aKI63Wl8zgKosao4eSmnRByhKNIC5kN/4uABD2L3+OqHRmulpMUIuGVqsKUXIQkYLmKifX2TmUj78lzQGEaEJiyZzo6l387mahgxUpHF/29fm63Mcvbo0ut/1FtP3+b7K1/ZxUC3cjA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Thu, 2 Jan
 2025 18:08:38 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 18:08:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>
Subject: RE: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Thread-Topic: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Thread-Index: AQHbWDIsMu/5W8q5HEy2aJHGZrayP7L5t3uAgAoZuUA=
Date: Thu, 2 Jan 2025 18:08:38 +0000
Message-ID:
 <BL1PR12MB5144159BC2B99D673908BB88F7142@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241227073700.3102801-1-alexander.deucher@amd.com>
 <2024122742-chili-unvarying-2e32@gregkh>
In-Reply-To: <2024122742-chili-unvarying-2e32@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=73f6d724-a8d3-46db-a1a7-1b067b56392a;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-02T18:04:47Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB6879:EE_
x-ms-office365-filtering-correlation-id: 9d70e051-0f14-4728-d19b-08dd2b587b68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GJgbeKRVSYMZ7NSlvkpBzR4AIJ7vs6oeSbz/acdsONU8RAhQERwOHxtANajg?=
 =?us-ascii?Q?FAnYKF4Al//i0+xbxaQDmxJg3/SJNULLEkjp0GKRiDCuXHv/NtzAUhyhN7S9?=
 =?us-ascii?Q?o/ksrxieIZ1XAx+TBcMNsc9nW97SI5HhDOzm4I42+/S6dQ/+ub2ZI1pWSBfA?=
 =?us-ascii?Q?wx4yuef/ReJIFPWI+O3klGP1MeDCvmnzGa72Fv4c7lNtabzBJ1r6EVwh+yWo?=
 =?us-ascii?Q?XsOefyVG37TH+1KEbuKhJdLyQFPikb1QHE9kg5M7Is3MVgB0Q3HIF0AqieTU?=
 =?us-ascii?Q?C67MiHbEQRa71UUqyb7Ot88kiW5hZMY1Rqlw4G/hABYFWfCZ7fF3VEmBFwwF?=
 =?us-ascii?Q?RVxp+KyJJj+Fz07rvYs6PYADMmZ5VAZ/B1hqb/5FUv4e7huBDLkPlfMDdHDx?=
 =?us-ascii?Q?abgjzckTiOq/gM7vx+3K8lUyzlIuIfJxGQkfwjAt6+MjFKfaVpHUldD6bxtj?=
 =?us-ascii?Q?zZd4W91LlhZaCbPDGqtT5WMKJezv7YQRvudN+NoxASm0Q/gN2XYCLOzia34I?=
 =?us-ascii?Q?xBgehooCYCZrmoEdvIR9hwm5E+2s32+zOtsEMLBIA33lPEP3G6wPGzevBbyZ?=
 =?us-ascii?Q?lU+6k9gSyX3M+XiTq90LH87qb4MpCI+lOQ+7uEzzT5P2gcw4lnoNNCVur+4M?=
 =?us-ascii?Q?VxcVSGxtYjCQJy5FB8X2C+so+tNpx9Nx/LjpbWpk+aaDOSYJwe0IIbrMdNkk?=
 =?us-ascii?Q?zNeqXakvDYWx93j+1bCt9TAjh5TE+aXwc2uLkV/kmZ9pK4f5iKvsCkgQgAu+?=
 =?us-ascii?Q?peIJdGkdZhTiG6uzrO2vDPrmCmpJsmuvsjtQNX6JVWedpzRBPTEqOYJISBcX?=
 =?us-ascii?Q?+fdePveCCBgQItQ/30vWQtIKr0d36O9YkzHJX/HExlWC3W476+1a6RfeYJNx?=
 =?us-ascii?Q?TnoFDj5jI/SsKmE8VX/K/lbi3nhl9pSdZIjhH0BmGRQxlWQsEsye+r7hSDpw?=
 =?us-ascii?Q?DRpR/wWHFnEPlFx9yWSRLGMC/77zE2he2io1+/c8yM3XLhiXgBM5rxch0lVS?=
 =?us-ascii?Q?79uNCvpyjL1guT9Eo4RyasV7LFkkAEHibe/bNN+aFaFh0jG8EOowtHvvWWy/?=
 =?us-ascii?Q?oQwycplOYDdhTbC9oQuBVuuV08JvD8IUCcjud5MU9oYZCvg/WybW9KqE+NeK?=
 =?us-ascii?Q?lgAUDosAr8xSkvOpo8AmrbeDJjfVh8jnFZCY8lAzRdwji7DlS/Z+vibp7cPx?=
 =?us-ascii?Q?KkAq7sii4eA6yq0yrlwjdNf8kJVzCa2RwErE56I8VcoBK6qNUhA/HHRN6RME?=
 =?us-ascii?Q?lD6z5hPG97JNktX20RRvi+MmeOrDQ6aMksDV4dF8eCNz+fJjRtzNlrqivsKs?=
 =?us-ascii?Q?vYb+nVIW7narGI8eWoC+ZeQ55wvXoB2otGDWJERCy2U7euxCoHbymFdWQo71?=
 =?us-ascii?Q?dF7ZgAyAJugcTGSICHQQx+cqquhM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EmcqNeqkaDlsjfDzhTqZi0zYd+XHsAdgJf+gv7/xCooBXfa+UEh7q6iZljsW?=
 =?us-ascii?Q?tuU7QyoQwdTCkC/Mv7IGjP7701KLr9BYhCdi9AAbHaNUwH61xje0LYoKeibW?=
 =?us-ascii?Q?FnPx0QYYJ5bepXD3hXrViKXNW6v67888yozJ8sQHBBU77QvD7Yx6IEkK95vE?=
 =?us-ascii?Q?QG5crSWq8ZTkYZYqF++1OOh01nDUAw4F6bFUpCocZdDS3dxDHseyv6GUJJ4v?=
 =?us-ascii?Q?VKSpZrmxcwRFoL6RaR2GeuxdCJywpArpDvpWtAspoOuBV1a1ver24iYmKtRg?=
 =?us-ascii?Q?j2y6o6hR6TZkWrUwvNeS+oGy1dRkABtmHR5XiA3aNYG0uZgm+TgSz+GvKpl1?=
 =?us-ascii?Q?6B8AI34esVOXyr5R03aqTTBNMrr2LfEvZBAhV9m/8fs3nbZZagx1HwbR05vt?=
 =?us-ascii?Q?QuEOIJu/TvXfa1ev2yfTZHZNUIqFXYzrNJ/z7kMDvROPDT0yUnZ2W2g6Bx2n?=
 =?us-ascii?Q?VtxJGvOz+unc9WCYObWpdq/bNaZnwR5+Vv/MQ8kbx2Xg8+OOr1/mrX/SBSTv?=
 =?us-ascii?Q?/LrpeUkjTiIPAxqNxKswhYSRkll0DGCesL/jBMU0pkeEPVUi498p6jlnAoDQ?=
 =?us-ascii?Q?cUh9F50GvMtWRs93DNJ5GyY6I2AT5JZP9CrA5P27cbSmZ232rQfOnAsO0x0b?=
 =?us-ascii?Q?K3nhOinVtScvDNNC2mkXUAm2Oqm/edjhtRN677rNIRLD65uKrwuR42sKaKg4?=
 =?us-ascii?Q?dFia+7a9/hz9184QynkDPrqLX/Lp+TAD1fMcBk1H8vxJCebxYUzgHbDGBNtG?=
 =?us-ascii?Q?V3PQ5whiN2z4zdmjzXNjyBfbrwPnRZ3RX8l/8Lu3T8mMttkVA9zLjH0+oUlP?=
 =?us-ascii?Q?DBmSwx+YwJ3OrGXyTlIXVGFT4R1bKVRCWtNt/Uj1uzx4zhi6WDza8Vcb2vH3?=
 =?us-ascii?Q?dBS7yjyNlDz38EfcOv49w/sQ30LOGUYMPO4dcAHGRd+w+Q3VUc4ZCIW4Hbcx?=
 =?us-ascii?Q?r4ndc3kSaVXdlWNfvIAFoFVJxa/fMIYsOMaXaTKQ4TWDji4b6ZHu0ehwqOY+?=
 =?us-ascii?Q?LyMKh70lMf7yc6WPo1eW3TxtY7eZMSuorUcPmZw75EX1y07eWFxH/cOiSi8M?=
 =?us-ascii?Q?1xYUgWH7JGFdqR+GIkUj6NKoZqJHjr9crWOIm9GjVbbN1sYsnb9xJguwwbQJ?=
 =?us-ascii?Q?Mtv89hUXb27sjomz5ABZL3qgh/6mDIMjX7+weMiiz+JhFXdc9BauXfHxaa/X?=
 =?us-ascii?Q?TdE/sv8PZi4cNlcJSf8P9LQgyLJrFavy2JZW1Av39z5vFyXvKnzswxtOElM6?=
 =?us-ascii?Q?f6TC12wByGOAEJA+54IGZERo/tcH71yVsyPtdHDNXFwvvLS1wIYmdiR440wz?=
 =?us-ascii?Q?Pj8IlDhDedM3xl6MWiBaYsWiNKnONEB28dWV2dS9/26V611rx+W2ndA28QHE?=
 =?us-ascii?Q?sNgQljJdSOygd0Z35NgKYWSxlk9vjhln79SiDcheWHCBzm9MTyRMdt7gGGY9?=
 =?us-ascii?Q?3pxLqA/4SoEMFDwmM8qEYNLjcD9ohzClwKqyrmjRxdQcOxHL0pxfVKkADUMD?=
 =?us-ascii?Q?jtt9Fa0E1+xcWCTm86uZ1fSTYEUSfcEHQbPMtq/PuO35e1AK9zV7uZqINVxp?=
 =?us-ascii?Q?CVGt20381AvYbzlnC+I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d70e051-0f14-4728-d19b-08dd2b587b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 18:08:38.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1iv1zTw0bcom0Nm1ocql0oNsNpOa2cGTepojBNRjmfwXmLVXq9prjpkhC4Si9CaJkwpwjlHvzbBsp+FzyV68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

[Public]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, December 27, 2024 2:50 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org
> Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
>
> On Fri, Dec 27, 2024 at 02:37:00AM -0500, Alex Deucher wrote:
> > Commit 73dae652dcac ("drm/amdgpu: rework resume handling for display
> > (v2)") missed a small code change when it was backported resulting in
> > an automatic backlight control breakage.  Fix the backport.
> >
> > Note that this patch is not in Linus' tree as it is not required
> > there; the bug was introduced in the backport.
> >
> > Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for display
> > (v2)")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org # 6.11.x
>
> So the 6.12.y backport is ok?  What exact trees is this fix for?

Everything older than 6.13 needs this fix.  The code changed between 6.12 a=
nd 6.13 which required a backport of the patch for 6.12 and older kernels. =
 All kernels older than 6.13 need this fix.  The original backported patch =
targeted 6.11 and newer stable kernels.  6.11 is EOL so probably just 6.12 =
unless someone pulled the patch back to some older kernel as well.

Thanks,

Alex


