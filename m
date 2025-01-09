Return-Path: <stable+bounces-108147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D2A07FB4
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 19:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8861188AD41
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2839199238;
	Thu,  9 Jan 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HtLI8eRr"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F018A6A6
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446884; cv=fail; b=l38PIxOx6umcjDwdxkr2xHZzH6aPhglHxAlYKZzRz9YmjgAOdEdjMaR+O2VB6CAyYWfFU4FU+Ij93H59J8j7KfvgybYAJKmQLFj+DxxtDMgCU5a3tUxiP+/oOKKpeY6W68gc3u+HQwBxSwaiaDG5n39ITWle8BWPS3trRFQi+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446884; c=relaxed/simple;
	bh=6uKVOnk8XfNfuEOXI/P8reNOcaUS0nIPekgzNDZ3VyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gBE+xLQkGxEk5wwqqq6LAVXgtbzh36vDmVn5hn3zzHXMlACNO8lXWY6+viWaHWJk+djqiGxMcHZZaW/b1aaRcEIXtxU3ovfuY5D40ACQQ0btQ+4pOieQavllIiTz4f0alY8E69JzZ739AoN6ew4xtfOqEFWzpWflqCgSqLM+wk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HtLI8eRr; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJQelgSydUGkdQupxWEGkDS9XjUGpNPOzfkemEC4Hvvy5x83XhtHgmKa5dLlu4FNX1d0sC+MLDHxECvS9k3H4oONH0Ej01WjpQYKTg4oQMhwHS+fMHLy/OFGnNegD8Km9AQWRwR/A7k/ikTfW6euQk/3w9Rg/nnM7NcTOhOO0L7S2c1hlN29EWfxF9HdIklYmsY7VnIyiDibxoG2ePvd0KmRsLHvkfk7T2ED0LqDr1gga3mbG+bbQCntBNZOkaveLIUas8FUnx8K4U7LUWHI/IHG77mNd5/RPwHITmk1bOPjbVqyur6E/THs312YCcPKTO+OEOBZvidhKfAg1+W21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPilJ9KGnA1I6DRvGPCM4MT4NjXO9na9hA/XZVSFY3M=;
 b=vahHPrVGcbs1ncURcsU1R6NzoDAFlOnRTpMNZeBzYUwvujw/F8xoU0q2sq+wfHQZrl/n82QEbdfayyz5PBawQmww1IjmCxHR89H9XuOkpDU5rg7k9tZQDjTogdzcmCEvdWO/mUQpIs5zwISd8a0BdhpOGAIJXuJI0CnEen2iPsesCEL+cFZeMSTk0gCSpbs26NNcie/EvgW7OjunUI6Uat/n6ImEEz+4r4iPJT3iurnb3FuE9vlpm0HNxXKXM4bTjKUr5Ksnj3KfXltvxYA+CvP6diN6CxyW3KrY4gT/bMiX8i0//PEmJThd7iSKSqPEo+z3WNDJRs/Z2g5OEKCn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPilJ9KGnA1I6DRvGPCM4MT4NjXO9na9hA/XZVSFY3M=;
 b=HtLI8eRrbZFfPIJgp/Cmphn4dvcLGlePPmluBpHg2vRImZYH3AEjIcNydEMiWwjaof5A0Q8/0synThDEgW3LzXrloRVsh5Aec1C3ZrDNsnKKXFIUD1+WXtE87uS+br3dw/1GDjh6ZP4qsGJ+HAWh/8anGkYz91eNOuQHUbJ6DJk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 18:21:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 18:21:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>
Subject: RE: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Thread-Topic: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Thread-Index: AQHbWDIsMu/5W8q5HEy2aJHGZrayP7L5t3uAgAoZuUCAAVleAIAJqTNQ
Date: Thu, 9 Jan 2025 18:21:19 +0000
Message-ID:
 <BL1PR12MB51449ADCFBF2314431F8BCFDF7132@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241227073700.3102801-1-alexander.deucher@amd.com>
 <2024122742-chili-unvarying-2e32@gregkh>
 <BL1PR12MB5144159BC2B99D673908BB88F7142@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2025010334-deniable-hurled-4f0c@gregkh>
In-Reply-To: <2025010334-deniable-hurled-4f0c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c143aae9-e524-4e3d-855f-682680d8f445;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-09T18:12:45Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB6414:EE_
x-ms-office365-filtering-correlation-id: 3b611a5a-a980-4c08-abbe-08dd30da6a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NSEKIWJCMCju+Zh8GZqrv7hQdtGeYL/f27InPHwy/HvvFUDEw9tadVK+T0OZ?=
 =?us-ascii?Q?tLLtM4sa9SpB2m6255KHsRtUw/wz/hJNSAapmPejDa0ktnGx7ADswT7+tnb3?=
 =?us-ascii?Q?Y2xB90l2QtU6ZDmXhkusTMYGqkMg9mnGJLAl5vn1OWHNrGX6KstkkI80ReQl?=
 =?us-ascii?Q?5mAVzcn0HTxEUtx2tOpYNX/ZWIRGyclMSnV3ItfbY4zkzaP4OOiW07446vQz?=
 =?us-ascii?Q?IbpmPR4bYGiZz2wIVtTSx7ob1kIIhQ+vPvzXIHWllMqSA+WL840ZMEtyntCU?=
 =?us-ascii?Q?zZxfV3hRntKIP6FBAVkr4KieWZrABOd+BWMuFR0uGWILejF9ItLVIj3beyFc?=
 =?us-ascii?Q?g+SdvZsZBwdUuZKlxofUPrbBqBIi9EQKpqf6gBKjz2IzulajvmOR3r9UTR6N?=
 =?us-ascii?Q?InWyYNt0xL5k6+M7/QhXt++DDsit1/FV/HMZf6de5x9fbmJTMa1cFb89aDzc?=
 =?us-ascii?Q?gp+tQqpxNHNNVO4G7wALjK+XEJ4nBRtKehjpCpQZfFEsTHGjJbD0vF8pgkkP?=
 =?us-ascii?Q?IzBFgdHwlAuUVejGxku4idkma21DuyOqopjbXSLZeBfGUlaX8AyznKQ87VYt?=
 =?us-ascii?Q?cJOWbPncEBd0E6AUx9jyHS+nuivxSF770MvdGjCtQ6V6M+6VqMTtNMGpFoac?=
 =?us-ascii?Q?UFhetd7ZfCOPvVWlpGCnRemOIlaUmy2hzzOi/JF0NutRmUb6SHF4zoXPlNQQ?=
 =?us-ascii?Q?/6wyE/3KZsUgAcD0hNjCjNDV1Cl8yD5cg8XoBG37gvqcUfyVP+BAqphZjzU+?=
 =?us-ascii?Q?biKsHCceZ/1iKKEa0oigQug2Ab6Hbjd/e0MDEdVwT0zT5E9mJ/gr5eYM0VpD?=
 =?us-ascii?Q?wm1pEU4VdjfZhEIPzzJEfIkkYU4HsHlQ8002vIU33GSSQgliliHIyhqR0D4m?=
 =?us-ascii?Q?0Ca+PK7KDRtyWjwHA+ngFJX0AE+44xWflOzyBlW8/9kdpkPtAHdClHwPjXUb?=
 =?us-ascii?Q?CqxzJgA6yshr2XXYHb8DIXERVj3/esk8IDk4prlsKyEuO8ArohMrIkvAbguD?=
 =?us-ascii?Q?pj9EXmebwEahOqCg7XhERE6FMXSS8rxYBaLahUvKcf16soQmhssCXXiTzRRO?=
 =?us-ascii?Q?sE41AAXEo3jTsfFe4nmfuBRKgIbaaBKBI4BDVA+bVChP8mwVdhBwDPJMNCb2?=
 =?us-ascii?Q?dT+Np2ibBQnNKUyu2yFOQ5caRlizlAaWBTwnXkRGw5VrHTZ8LvjIF1JItpPU?=
 =?us-ascii?Q?Hxqtl1tPkwLzd8WleljS1jk1CEP79ddL3EbzFbKR7FHtA4N1hVs+4F1bmYKJ?=
 =?us-ascii?Q?c4vVYcMSMeUUg1jfysFg/FmFcF8tXEcVFaRYC7ha9FabbFgDEd7YNaAZhcf+?=
 =?us-ascii?Q?q0gXMsnyFodru8/iE+cUA5XliUCm5zKfg4Q17bUaGRG7vZFFK2ubypxCyD74?=
 =?us-ascii?Q?EcT7utc3PSlZ6zFAI1VNLH7INGnN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7fXlfGPWOqb0MUnTuScmwaRK4iTm2pY1UUGIk9Cen2naG9UGcnQPQF5+dUa5?=
 =?us-ascii?Q?qd5RIg7AstB1Z+JvPxk34aZ4VtYWH0Ax878ZKaRL9HOsZJ8wqoLkDqNwiv36?=
 =?us-ascii?Q?xcsRx9w4HTsxZfAinQSKdijwMYxNG2nbSEIYHTz+GFUb8dHmErDFt4zPAMnV?=
 =?us-ascii?Q?WJUVIMLYQrQu0L4UekdnhXLU08Rj+3Agz+JgQ6V8fJRdilHVGTkN0JNzLSyW?=
 =?us-ascii?Q?3KuTwjbaijrT9un05LPYZzM/VJgHRUSe26fPLbadU3R3kmMP2hmkEsg7mShU?=
 =?us-ascii?Q?37R8PUnu21dEMzT/KQlOyXoeD+ltDO3tTd7DPsdm1JHdwtOUJqBiKpraFWQv?=
 =?us-ascii?Q?5U3jqNVlldyyhC8FzQZ9NARnPaf4OJDK8kKWFtYECeh8Gg15oinv5CQdwiN5?=
 =?us-ascii?Q?xrd8aRduxYntgph0+n5N22Mo53J6sAEyXm+lxGLR1Dgbd/WlXnJXjzS+WbL9?=
 =?us-ascii?Q?esLkgYkUmOmMhd5FgZYs1bgDDaokyAK9e0Oysa3gu1QBkVKRQiU9Ltzl8BvD?=
 =?us-ascii?Q?4tzyXJRpoWymggI54cq4LzlmehedSoU/V7PMDfOre4N+OJaIivtRaZ9ZlYBe?=
 =?us-ascii?Q?1uvQTTYZlxVcF9G3O3OfiJWmwnBifGAwFyZubuJPamJ/qFVJ1BzTkvYdldIu?=
 =?us-ascii?Q?HFpte0N5/KdBJ0ZQS4YK4BLXyb8p6b16bbtJURo3CeK9TaMox3V+oynp9FLH?=
 =?us-ascii?Q?+8BcdrVnxOk3jQq9co5i9vUi0JuwOP8vzx3FvtvrGUA39XRA28qPORqTfdr2?=
 =?us-ascii?Q?JqlDR6/4BqraKaW6GPifZvBlCyBD0fzYXErEj56ifaCsY1sTDkZb070IXiWP?=
 =?us-ascii?Q?+GfFiDrOSCnPc5sI3zaewkVwhRKPTtc+yzqx41VZ4wWapTPzheAWtkM/CK0C?=
 =?us-ascii?Q?LjG4RCm5z9/PS6AmwxYNCd2UzVKVrGj0xc3tSRouqqo939XWuZWIlWMJwqT+?=
 =?us-ascii?Q?YwtAdgElW7WVhLIl98InPaE99LhZf+NK/a4A5o8WKeeEawbyjYY+Eb8qjp5P?=
 =?us-ascii?Q?XqARiTfBX5hG8zubJJwbVdYZl4ifBZjZigDLdESUL1dmIGQLcKWgAuapDJQg?=
 =?us-ascii?Q?oghSk3o+ax7u2oUHn5KtNz8gawPJQBUnaURg18Tlaw/5IC+Go0UonUF0/Gcc?=
 =?us-ascii?Q?5I3Cin8jeyzjdxIihKhmT66vHAd4uBQosqaT63GG8G4kQ1arScRou7ET5QLc?=
 =?us-ascii?Q?MTLJecWgcUV66WQuJL++Gv2CouTxMeQRlEJKeTM5n11r/g2KlTZDUFLJ/JdC?=
 =?us-ascii?Q?xYE83jUarIwDj34lyDCiJwSxQrC1gg3kSBBS1gi9bJD+mugXyZWZ5iRlYefx?=
 =?us-ascii?Q?myuZGcA4SJvGW+NhPOnQTX9deKAevpYAcTl5bcXyXlzpoWjC5BUE+VLm+tjj?=
 =?us-ascii?Q?s+FAfHgPVL9L7jAX4CoJDXh6RJSY/eh1PeG5KW03tf4LeR0KkleJA4JcTqa8?=
 =?us-ascii?Q?PPaJvvmc/G8PwEdEIlc8qrk76dua8ow4kN+vbnRXPVa2Ur6OQj77vNhbOVuL?=
 =?us-ascii?Q?4PGu/g0g3qOi0IVjgzM/gKnCZCvLYLlRIc8KH6cUWRf6jmSR3ePtbiWo9AQT?=
 =?us-ascii?Q?2cn7H3pQu7Prcv7NpWw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b611a5a-a980-4c08-abbe-08dd30da6a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 18:21:19.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RStAeLmInmyMEpE0Yx5G6Fs3PfbjIWJRrI2JsnRQ0p4bvSt20CC1G99ClpCGLnKXD+Co62tqRDY1A4JYKbfIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, January 3, 2025 9:41 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org
> Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
>
> On Thu, Jan 02, 2025 at 06:08:38PM +0000, Deucher, Alexander wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, December 27, 2024 2:50 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Cc: stable@vger.kernel.org; sashal@kernel.org
> > > Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
> > >
> > > On Fri, Dec 27, 2024 at 02:37:00AM -0500, Alex Deucher wrote:
> > > > Commit 73dae652dcac ("drm/amdgpu: rework resume handling for
> > > > display
> > > > (v2)") missed a small code change when it was backported resulting
> > > > in an automatic backlight control breakage.  Fix the backport.
> > > >
> > > > Note that this patch is not in Linus' tree as it is not required
> > > > there; the bug was introduced in the backport.
> > > >
> > > > Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for
> > > > display
> > > > (v2)")
> > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: stable@vger.kernel.org # 6.11.x
> > >
> > > So the 6.12.y backport is ok?  What exact trees is this fix for?
> >
> > Everything older than 6.13 needs this fix.  The code changed between 6.=
12 and
> 6.13 which required a backport of the patch for 6.12 and older kernels.  =
All kernels
> older than 6.13 need this fix.  The original backported patch targeted 6.=
11 and newer
> stable kernels.  6.11 is EOL so probably just 6.12 unless someone pulled =
the patch
> back to some older kernel as well.
>
> The commit has been backported to the following kernels:
>       5.15.174 6.1.120 6.6.66 6.12.5
> so can you also send proper fixes for 5.15.y, 6.1.y and 6.6.y as well?

Ok.  The patch is only needed for 6.11 and newer which is why I specified 6=
.11 on the original and the fixup.  Kernels older than 6.11 didn't support =
DCN 4.0.1 so it's not applicable.  Can we revert the original patch (73dae6=
52dcac ("drm/amdgpu: rework resume handling for display")) from 5.15, 6.1, =
and 6.6?


Thanks,

Alex

>
> thanks,
>
> greg k-h

