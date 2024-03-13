Return-Path: <stable+bounces-27595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD287A941
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A81C2288A
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3B4502C;
	Wed, 13 Mar 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KvcugLLl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bfoJtD0B"
X-Original-To: stable@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9046426;
	Wed, 13 Mar 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339105; cv=fail; b=Z8UHsURfARc9LyB2utkUhLoR6+B4gAUJ/Jeet36+WaB9WpUxy6tw2VfND1dKVaPtbQxYWLIF5/P5ZxNIphfuzhn+6aC0RSfPhJ835JuuKsOmD1CucY80yvP2IDqVOM8115d+MfKZX9WOSMzNVO7HygcaHT0x9iQjW0kN2UgxLUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339105; c=relaxed/simple;
	bh=SmbG5fpfgC6mpqtITettf0Shw9ux6+js17XRyk02D2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u6gxooH6V/x+h91LHECDWbbDnwnOu5I14B506u2xelBIY/mcb+er53oZJBx8OyovzTooGeHR/kyk0UsnPZcskTS56xOoEaEGhj7DYSqoKH2eDF2WHqKi5W8qSw6jmKYnWngaiZjxkiSqcF4mWoROoEVb26X01dA/O3qtWSiitvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KvcugLLl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bfoJtD0B; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710339103; x=1741875103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SmbG5fpfgC6mpqtITettf0Shw9ux6+js17XRyk02D2s=;
  b=KvcugLLlMokJcQaX3xfG0VPB5KvWA+y55ZHHdg0RMe9jeiCtJXrOv1GY
   PkmJ2xsIc7wGxUZWT9dgT5+KgPjYrwnrD2M2BM0RPycQoYIqJHMl3+y9p
   IqNc6qBJuo+jTUD2cdb/VRFO2uT2B1INOj51PBvMDRWZjf0evZBvbYfOZ
   LNaQrdCjRRpmRTCNnC5nPSwcbb10kMTWDNmKFD0QR+GgHN+Xr/eV+RBFn
   i9OfRNyAG679erD4TGp7R/ElsthJGAsBxjkpg9FDRNhGcOfxA2xgGITJG
   8UWhQI95I3yCC9suKbD1YgEIR7XT5onRkK2DTvdkGGeSFjvPsoV65WvOy
   A==;
X-CSE-ConnectionGUID: 8Oatg5/kSlyW8HoFGeOIQA==
X-CSE-MsgGUID: csFiwHcnTWuQnQ+2a75FPg==
X-IronPort-AV: E=Sophos;i="6.07,122,1708358400"; 
   d="scan'208";a="11012730"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2024 22:11:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys25azktr9OPWEMI83HxfuS/jrr0FwdCIoGpr9IGL47SHDLhtR8Qe3iswzcMZRbkiaXFG4IUerMLQZvZF4a3jpGn77gQxr+F8hWPt+RpugjHCOzRFS6aQNxp35lmK+R7s+QIvSTLbQBDBphnli8Yz1rkG0OtLoQTGv+vIrnDrvtgntVzVWWj2z+dB65AYTDg2ub/i7Di9z+WAVc823N+omHXqZrh5WW7h646B/GP78dMBcxW7u0duHzHUyUp4Lxf+SourlLIfLjSL1Emld7Hm6NuoN0GfkHSKRimDQ8O3zjjoHfFjbBLPOjFHW958KP6lro5RNL9oEjB6r1sD2i+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x392kTKiab1qRfB58PZSJiuUf1uwfFIuRupBK9A2gi0=;
 b=fJA81aWWvA5Os7jS6nfoVsfZk+LcvsaxZJCJkJuKbzcUjtDIcnK67TRb5Gu/7wG3hZzlJcwyaur1/qsuXqwFosTRr6srnhicE0ls8JFaS6H9nSj4hZeO+bY3cXMErcJcV5Ise89vliv+iMsgebYzGN5u+GPCBKZKG3btoqIiiWD2BepyX7BJFMecFOi4hpzZHbk+0AJZaqPUxvPTUVVblxxYZcYBiyV2YScjon1eEL2OaTSjoQbt6ec81Yc1SrJHRF5B4/C7Oj6PuoAumZ7PpCw2QfX7pXLhY1rsEAmrMvhbSN1V3+k1KHHACBqJtucScDghNi7R5holel6GpboyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x392kTKiab1qRfB58PZSJiuUf1uwfFIuRupBK9A2gi0=;
 b=bfoJtD0BpCRbO6aJCSp9VycK4TQmVq206tX8FIyAJXoOh5iFgKgc0LLbUoxwmlg6joRulljccYz5hwF9jiJXYXi1Uqv6yVydKHFFOA0+noPvrbcMbS7ryJLd//yJwEmz+ioXpxP8bkIioQOHRDK3k1HGshhE5LxazBm4QEw0EZo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7897.namprd04.prod.outlook.com (2603:10b6:510:d5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Wed, 13 Mar 2024 14:11:35 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 14:11:35 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "mikko.rapeli@linaro.org" <mikko.rapeli@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
Thread-Topic: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
Thread-Index: AQHadU5ZDeamh5oDu0yXqvo23CmYcLE1teSw
Date: Wed, 13 Mar 2024 14:11:35 +0000
Message-ID:
 <DM6PR04MB657536CE8D6FF0B603880F4DFC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
In-Reply-To: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7897:EE_
x-ms-office365-filtering-correlation-id: 4a6bff26-7bbf-46b0-ab4e-08dc43677e2d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XK9rJHnlYErv5EJeSwOC2L5xUn9JV7A/OSg3EkqTjBn5qCPQ0TssbMSEZQafj+FQofnMxqH8UMA8VoA1NxztVGKzz7EmgJDKz6wfQzo8NDAlj7uNfmswgtZaYoMSXCoYCH4HsiD9MQkMMoMx/YlWFAVEJy8vokvA8m7n0U9wHRVF6KC0TlSJyYQwPXiUkplkA+EqNmdhu6FEpdiaJZn0h8wimFGZe+Mf51hpXozJnEABtKIoSZNxPGlezhHuDFVm2OXOWIY2zixu+bgSCVQceGOyeH8ApRZsn7KhUv5pyKUF6p5jn1YrWx2PfytCRbxkJLBlOfPoLdyL1hoGseVnDFV/VMPhJyZv979q32OV7XPN2qVMp5AlfyhHqQ9+kS+ZFQJHhp7jVSj1V6cyoTLicKKACN6CTfdmqC/1PItDX8eyT1B9y49QYLG/AcaaE0NamTDYtMWNFhrqc3k9UdWKfHvbq7gIHCIDUtOIWykrJPesO5SRg8sgHghYBtNZL5nr6sZZWK3lfGCl/H6HP33JEe75hq9VewhpN/khJMg3Z86SAwwzYGB9Z14sxpZXtj4AZzVugXUpwCrCBPghodRCdFPZ43VZqks2vU/to9LBJJC+KE2fJF6840k/AAxIRqM4A4DgKwCrTzMbcwPxr53nn0+MKLOpUiwfjkNCV0jR+ew=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X6NcsE01B0SMdL9tnZZbtugwrPlkyFEYuXVK3xihdAnyJTTo7s5AlCXul5tC?=
 =?us-ascii?Q?HI7cv/qtljpPp9gRIl2b/Ldm+R5EVefQPKgFvanjEz99YXrwvPl6sfRkb4iL?=
 =?us-ascii?Q?89IQeR9oDhRcDu9VZfY2wF9NrBSTaIQFeSRcm0Cbs+mCaq8Ao7dYhbAAt1bl?=
 =?us-ascii?Q?m7+3rZ1YjjDgDMkSmbRlUPHQs09STphZJtjU5wkR8otcG4/Y8k45ScSoiiDi?=
 =?us-ascii?Q?bfQjXEwVopLbzaoMuGjodrgLkmCNq8xK5ZdkQuidwLLWD4BroFGb8mjhJuR8?=
 =?us-ascii?Q?coqyv1+2l3QAZlK8EvYkHFkqdlQOCW+s2TPv7QMoFQLIRpQwmDoMR1BwN5b4?=
 =?us-ascii?Q?oMY6aMkAYVnjBnSuq2MnIAyLpxVaw9EDzxVRICRcgm9YwaymAwZurSZ9FwNK?=
 =?us-ascii?Q?ZTU8MQ4+qC6K5Ns6tsR/hntMDTyEF4/9dUVsQEd8K8IVaVc3BcpSFvMPCUwd?=
 =?us-ascii?Q?+UGLZsrtCI56Ypqk1nI5cSBrEw5VimSQ6kkW1JeF4ASeW5muQ5m8yMaMfdIh?=
 =?us-ascii?Q?R9XnMd7Nlje6LR4wQeCwmnLL3HigNkt4YnXVaBgffwF515gjmus3/F+UAK8V?=
 =?us-ascii?Q?e+9ho/3p8NqR/jN7Dg0Xc9wupw20kSRu7bUx+fRfGsfJsLZqJNFkACY/At00?=
 =?us-ascii?Q?uHfYNO2Z8PVaJjn70BMs+nTxmp8J0wVT2NwHRXXaypGmufvLyHY9/qh1ZgKN?=
 =?us-ascii?Q?9nZ+dXBem4/9aRLyWtIaarr7OkCwJlBs86O0IRSraSrKGyBC/bC3sqhJxQF1?=
 =?us-ascii?Q?WdJTUSjSAl4V6l6poyEu7qnqJVzA+qjQZiAaxvTaZ9JfXF09BhtkL9YTgFjP?=
 =?us-ascii?Q?DZeX1pSUoIbReQHq+J1I5NrBzoCouh/TA/ShFUSDPLmZIvxhxs8EMAuraDzC?=
 =?us-ascii?Q?aE6htxalKaPyG+wto5eWnRvC8PEWFNO8/3hMI6s535YsMGbgQLmQEJ23hIfH?=
 =?us-ascii?Q?HSr1t0hACvxncN3S3CQucwc4Vwpa23Uj6uO0haiP36PeBRm1TOLTW6LCFqnG?=
 =?us-ascii?Q?0gCqI8ICSHWHizV28ipyjcDbFF7AK9WtKEfywFbhHIIMZqKbL31orjfiR8cN?=
 =?us-ascii?Q?APRIHVaVxUowgjjwSsAEZSNWZ1rnk5kKgKd1B7Yf3bZgGSnHmOJHwVJehB76?=
 =?us-ascii?Q?nzdaVD7gQZ52dJhW6blV0RV7JhOBj0c3YJgXXvJQbpniIcaF/U1sKFpbH6Rm?=
 =?us-ascii?Q?kgHRABN074ATLOvPju14VhOcQSdKpPx8WkzedLPgIUd7DQj+Gx2RASrUeYmK?=
 =?us-ascii?Q?d6cEVIaITaV6wBhSdvbPBAhkHvp/jzmrCoHwzHLfXnmhbJ/mNPD74M8R+Zlv?=
 =?us-ascii?Q?yExMPc58uIbxHA1A2BR5qAW5/KuNiwjHiAHsEPuyL+RJRYjsSqlfnO8qu4vZ?=
 =?us-ascii?Q?X9Zxlk74t3kM3VcdUwisfjoMY7lCylXmPMSRLAaW+PLbCpBDxI8/e08K1ghQ?=
 =?us-ascii?Q?ltwaBkqaqvX2A2rOanuUeOoAoFjWYFLkatNfvLD+FbjgdbEF+FC59A0Mxq92?=
 =?us-ascii?Q?A6eC3jCK6kKXbJ7Ju5Zcp16fmLuJoE05RGeQS6R4zkvHVK1dGgSRo5ZEq9dv?=
 =?us-ascii?Q?4YgH2YgTWioMlCKlPn+WjKd+az5qFmm2+rv74mAX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Crnb9FJdtuI+8aiehvHkpECwPjijRJb6y835WhzzGgzrHnoe1NZx0mJrNE/2/H560xBmN8moh5yuJg1bfVeWkl+wxmEcddm/sSGo/bPe8q2S/tVrDw7Vuh1Cd1PJ50+ucJ/4sGEX4iIbPd+M8gx9pVWXybrx464bHsjBfmpyFk3Lfp8xyvjCNhaV+TvftHVr0ijoIGK8ev2AC8J0XuZahot4rPe4wYe3Cht086lvGE99XWie/+wg9SPLblVlL25XbhDxjYFnfNBSfTCMQV3kQpaoIuLyDYSuU7oyjyprq/xqtvX8yRkwmQ5OchCXVj6U+lqNPt+D6dlweEe4QG9LNWWylWWWICcZL5ce5fVGdWB1WD/jQw3tB3IUi2E41LzvcF+A6XtRHRAlYLnqtADbHT6pidyisHtErS7w2TcHfKDyC+O8bBY7TSdtQbs+gI8o0Z/dTgFuraKhV0w0CKIEKag7s9ZfuTZ68EQOcoldUekyh9UJ2o3xT2CzJx6rst9Akn46TWBRzCWdNpCJ0S0j2pFMvPT6bNEep4PqrsnW0ZTHsvjNVhu/1uUD4fOtrMZWmKRsThqGeuXg4bMKEtT8g3SFqGT1l3J3s161ZJkwx8DrQFfz9xoTcyEK1Z33iQow
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6bff26-7bbf-46b0-ab4e-08dc43677e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:11:35.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1FYdDc4reK/Ymx9KrXlN7xDV4n3hvAYtmL4LzMPDfQ5xQ4Ch/DrNiTKlGlncDxMJAuWSGXGEGDMn5jgpc7Q4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7897

> From: Mikko Rapeli <mikko.rapeli@linaro.org>
>=20
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" adds flags uint to str=
uct
> mmc_blk_ioc_data but it does not get initialized for RPMB ioctls which no=
w fail.
>=20
> Fix this by always initializing the struct and flags to zero.
>=20
> Fixes access to RPMB storage.
>=20
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218587
>=20
> Link: https://lore.kernel.org/all/20231129092535.3278-1-
> avri.altman@wdc.com/
>=20
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 32d49100dff5..0df627de9cee 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(
>         struct mmc_blk_ioc_data *idata;
>         int err;
>=20
> -       idata =3D kmalloc(sizeof(*idata), GFP_KERNEL);
> +       idata =3D kzalloc(sizeof(*idata), GFP_KERNEL);
>         if (!idata) {
>                 err =3D -ENOMEM;
>                 goto out;
> --
> 2.34.1


