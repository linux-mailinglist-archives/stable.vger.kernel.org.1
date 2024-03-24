Return-Path: <stable+bounces-28717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9C887E6C
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3512A281673
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C7D51D;
	Sun, 24 Mar 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lBFYD0uI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Kcl7EVrK"
X-Original-To: stable@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92413D517;
	Sun, 24 Mar 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306292; cv=fail; b=Z3n4dsJrflqO/9GHqa4UN7DyD2HL6WZbWEWN4DFg3Ju5Zy3/jUWbFeIya1fqHlcvMX3WfWLgiC9/XQGlT4af0BmEauijsQsC0qt5bPKZq7w8aE3UuUATRJNeB23kB1TuZN7UmyZ2kKUrgxQP09Tvnk26k0+c1ql/SH5kZAa9uBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306292; c=relaxed/simple;
	bh=WqE7sTX6npPS4O/4pbBv6v1czDep+serassb0F+FKf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2A/1EEmmjFNYoieEzUGMYT4ikanJJrWrWD9rrLenzpW5mDBdAA93WQz7QGPTccDhCrTP/kJp2ZKUJMz2/vQBXrMMFgq28URm2Sl/GeV415SNbPLmYZ6aeMgPG/e+AFAdlOTM0GQfBDNdWdRf8KuxLl4+KK7g5Yl8fDZ93eYuTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lBFYD0uI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Kcl7EVrK; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711306290; x=1742842290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqE7sTX6npPS4O/4pbBv6v1czDep+serassb0F+FKf8=;
  b=lBFYD0uIcNc2X/JliXOKm5/uEOcwUOqd3u8fJ3FyHGUmpTXqUEV4jg6Z
   W+jMnVqTp/xTeekJWatancmrd5+HdkaVHtkdTr6FQm5owoUwnq1C4Hd/Z
   +nK3fIkr3ML6VXVlbIDnX4ANPPUfKj7WNNn0npY/F3bUtBGuWmMtKTgsy
   61HAq1UE9WM9DVfXNB2W8t4SeKo8SJZxJ70YmAD8D9niLFLu8gmh8es8h
   VyiBiUbOd8sffP42EdPyvKUk/g7uLHEQRimr9M0yZp5N7vdqUzp5IypAI
   j74CbUIFmk7kYozxTRXKvazvDn6d694CNELfOdcehdfcfmrcNFyWdweHc
   w==;
X-CSE-ConnectionGUID: bqyLmlZcRmuY3xwyfjRhVQ==
X-CSE-MsgGUID: XQgC4JAHQrizGCRmaXriuQ==
X-IronPort-AV: E=Sophos;i="6.07,151,1708358400"; 
   d="scan'208";a="12593424"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2024 02:51:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkrngDY2WYrpN2FTM+2FF/UIqpqj3hn/pDADlgW3x7dV0n8grUbJ/H6wYnDpbEVuF/s2ckfdcjCj2AcCUAWROow5m95QfM94Psv0yKja51HpMqsn33WWV8TIG2HyMDtOdEVpEwfYdMi/kFoUuH+Ci+o04+ZlAoITYju+9rsDhNLGfY1my9Ss3tzhf6c9Ppmh/jU7Dk/hE88acYHw2L/moMm5BbR/jhTson6UbBG+DU0g88DKRLPKp51Z2x7MoNtqmM/f2TAibwDrmf8fJy3DzZtxeMRBHgemD533fqrLeDObK6bKoZezkizkn3BTLVpfoOFinnclt3ItIMVocG77ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqj4qDwpSAwJIycIYf40S9hwFRgeGl7Kp8K4UOyEgXM=;
 b=AkRdlMoJYtksZFOGc4G7vTe3KOxcf2GmhQpHCq1JnNMhIsM04hbj48b4CNfJiylfGj2F8ergxXAfFQ5XGelDSjWuzxfIPEEM9thAj4rTqlMAUcft+tkT1imxKX0kDLcObxjVlMR+RPb1fVu3CqtMiuOIgKRt6dsCcd4wFRgSVHfQcF7aavaGjt+0n+LHKhzN/tFz0FlWD3Xl02J9nUFwW4O9/t5QXM69ZRuqlVzvexjNnp1GqrMjMPUlu2rEyrnuuLRyrkjwdQcj3sDJCF5yQqvFBhqcOgOsua+aeJp/gP2+63y6OM0wBJRV18HMNxRBX1SbGSfGlPTXLPUySH72kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqj4qDwpSAwJIycIYf40S9hwFRgeGl7Kp8K4UOyEgXM=;
 b=Kcl7EVrK7p+cMS0K+okwrdaBPeYct40HkOq1egSaWRWAJzkCt1sKRLUpXefcAKCVF8DaWOWnr6KU0tgCewXZ/A+H7aExxNP/4rFk/q9YGxYhY1uMclfcu/A5BiOVZz6v7mkYsym39xndJgQo4K1tj6S43zB08U4OM4KqA2f0sRY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB8010.namprd04.prod.outlook.com (2603:10b6:208:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 18:51:19 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 18:51:19 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Francesco Dolcini <francesco@dolcini.it>, "mikko.rapeli@linaro.org"
	<mikko.rapeli@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Thread-Topic: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Thread-Index: AQHadU5ngmlO5sEF+0u0J/Wduu7Z57FHIwqAgAAqdSA=
Date: Sun, 24 Mar 2024 18:51:19 +0000
Message-ID:
 <DM6PR04MB657584F970178D5F392E3B02FC372@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <20240313133744.2405325-2-mikko.rapeli@linaro.org>
 <20240324161755.GA52910@francesco-nb>
In-Reply-To: <20240324161755.GA52910@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL3PR04MB8010:EE_
x-ms-office365-filtering-correlation-id: 25f76023-b142-42b9-db9f-08dc4c3364b9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iVtTBgxUIiTaDnTSxl1O+NOV9HMZAwslCENgMtcXt1vQ8aKx21cB0Pv4p6qej7SNbA5NJLI/tiaTnwj1pQFax/r+kGBE2FglC6pbRMqQxVJTsL9ZzGzl4tN8nK0Ay181VWQjcBjO4FjdjLYjDVsT/EnPExnNGygo77OF9Ld1GpbIs/ZHuAbhVm1sKVxgf8zyaKNl/75239T+8OyAk+KOXX0EzwR/4Gx7aRr3JMbyzPG6Au7t0dM2K1OO25d32tOr/QpiqmC47UiHa3aAeEARuwmHi+HErCuNG/cwLpTDDZ/GTn1Gnn6EpH5yjHgniKQOP8Dcd7Z5fiQsgQwck8t/m13IH9vCT5yBY+/RhPgkbNy8mMOwSHztvnt3eareEpJIxYsgM+O/UUEEe/ZiZTn81RPoMNm4Et5MZDl95Sb3zt+xw5vMRxAcLlnrSJ77DmUc+WVDFFCdSskQpS3sgpZ8m/cY3v/6ZX3GI980dqel/awNY1IVc6WCR4MbdcgUT5weQ/uX6nvVjZeK56fnmY62TuTSLOvw6HaGE9JsleiTrPbezz1t33xic7CUtGjoIZUyKzn+FnRqSMDReSsJkjoh4duWV4LvR9QV7X6zT9VG32+ZBIeX0XSy83F30WtSNMZrLJT0Vjq3VIXuCSIFkTjt4vWyMGmvVF5ZEGqueYEGMcM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pd3USTOUfuhcyqb/uoW/yVS4RQ/CZCqWOXiwDQBTb8k7ndoKs7oIlgOn42Tt?=
 =?us-ascii?Q?9dnzaFvPdXPePA2om81NiqJzPRNsYm6whFOOBhKOjc/xVwhQIQ+EunLKnM0w?=
 =?us-ascii?Q?/KNl6DiJtIgaxhW3c4DfrINFWg2wxrg+t/ah0v+poOgbXmJ0sobuNulJu5+Q?=
 =?us-ascii?Q?8IjNbZ9czjy3QKRingrKms8pJMWdHZfRtQ8vUK1QKsPaBSToKYLguyhc7nuk?=
 =?us-ascii?Q?E/TNpb8hFFnBTpZ3hnb/7h33nDL0LsBLUsCgmBOulwd/R/HtpJcKkcQSQa7P?=
 =?us-ascii?Q?JgiqVwMJ3Z0bd+JbKtJT+69Q/A5/G8Zji908hzQA/5pNojal6W1p0GBptsF5?=
 =?us-ascii?Q?DekvuqQggzFOVWTBk7V/2qPFA1UPPvPfCLcEFwmyIpOvXWzjHtd8yhjlfXLS?=
 =?us-ascii?Q?b4JqVdMfxqrSZFdZhYiY2/Gvu4Hf6AdmOyT4Fcq3/7i1CtENvKtc3O6ggZX0?=
 =?us-ascii?Q?VL4poKFTHNiHBnoG7zg94JBpz9Mkv7QlF62eDwOiD29jFEWitRQOdh9cZ6r3?=
 =?us-ascii?Q?REHQ9pSaNnUymmfkixpOaPBLd06UJoV5uqkXQwobVSjhJb+nTGmIzSF7rPjm?=
 =?us-ascii?Q?BZnoeoQPSwWrUq1hlmP6ghayeHSxE16fwb7/kFPmvIP6+a1PP6IMImxkdK/+?=
 =?us-ascii?Q?YUBOZ0g2M3Pvfvq5FXNgUMtRYSWZFoFa+UzP8sxlijG5KXbFLm0ONlZF1KHL?=
 =?us-ascii?Q?poM9qAsz/LqmqNI/2Jrwva468Dex3ELm/ik4LtNrbS2AlT5MDGk5XfR8vjDU?=
 =?us-ascii?Q?njKB2JRS4iMAcdIvESIm/Tqsl17F5EMbGZnXAtCIzq2jbKJvQ8FviTRI3+RS?=
 =?us-ascii?Q?p9q+7UNsgEoZgd1WMNnWWaFbNKWdnpIUKoI01Wj5lK+kCBiEHrYbmiNLuRI6?=
 =?us-ascii?Q?/m6dqqTzxXY94AuY0K6CE+WsWJ7IRAnVMGwGIq3lu2GghZQ5xIwcOnP/s0ty?=
 =?us-ascii?Q?HTnBeOIH15VVdtRaN9Aa+5WPfsw7CAEFeDs3o8mYaoQCrVg1xRVD1QaQDoOE?=
 =?us-ascii?Q?H0d2mjQbliSRHbKAdo8Po8ZhKNOssE5uomB2/HO63nzDzhHrPlSEMcPBD1kR?=
 =?us-ascii?Q?N3lWgvqpTnSyrqtdZ9xb29rL9ITfjtF3ASqT63g8Tp+k59KNHz/uUwlhUYIz?=
 =?us-ascii?Q?gCLs6uEiZtYo7mkRcQpd+pCMN8XDnT88qI+8n4qFnYzZQRiTMHFtqMvFL5/r?=
 =?us-ascii?Q?gGJ58shbpEiXswBxVMKqI55ZGAMZEfezbqWgN/XWoy7U6mcwATot5b/3pIsp?=
 =?us-ascii?Q?cxoh7EjtiwfaSw+ztmF8MmJxWhkpuhcb6jxsnDai5RmjOFGzLDcrXC6odfVU?=
 =?us-ascii?Q?ximeWanofJGE/Pm9JpBEIQNmKzIMIXpGmvxV0xfdGFy1FouBFAIMmujSfe9B?=
 =?us-ascii?Q?M7rGjclJp8mKmtWYX1RXlue4LQG9ZDkuqLsU9RxdF5oO6UsiKIpqFssB+uf/?=
 =?us-ascii?Q?4jsXXeOTVVP7YX1P4PvI8Ky2FsUlD66AuB/myrUa5CbfFWxU+HAm8aLSCGlr?=
 =?us-ascii?Q?/GnORLhPTYoQzpSlKt0a14OBcmFbGRoXO8BhUsMHVNbqnY6apVTkmJ+0Ur5T?=
 =?us-ascii?Q?7pBveEM9O5HH8sX+g6kock2zlsb7FS8nrYi3vkC9?=
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
	wHmRzvwa5ANAW9HGNQzgwiTYfJSMBb29p5wprl98fe8a85R1b0OXmLJT3TdiY1awh71y0ej4+DKTiwnEQq/E5JVEEu5igZgKW60AaQm3nJWoiHKXGazdvvrFz0Oo+M7V3tbJ411hxEXaXkpya3/o10BhWqlrnh+2AdjaL5wyV++O+s81Za4nDUiEh+37iSag+j7T3isYbD9ge8/rAlUCMEFg/ssogM3r61SvhNj0OYhVS3dmWUuUIOAtZUHQ7NDqM+vexkTtRwNMNVP7h9iYVhFlsDxwIKBSk1eNqRK6HnBj2bMUDz7C/ZoZOOcO9NU8OxB6eVfZytAOBchTy5Q+2Kcp96h0o7qju3+FAfh2h6DzVk9ohAXm7GiGWNTVH5ApRg0OPLRhrDRcwH/mS4uQYb0X1r625+GRoQiogCnhA2sW3gbK+3LYczAlPy3/m1kilZKbz6bkHkJjjZQ/dVrqi6wgtRXCND0V/LH49u4Q3e0B99rAiTVikAJxZDcClmVUnt8q4Ma45GlVxhXUjD4q2lPey1fIl/XhlzTxAvIPM4ZgEsG6qa4oauT5NlRMWQLQtQK64+77fyxN9Hu5u3cSWvuqYMl99HUR2DhyXk50i2Kfmo0BS+uAY6Xn37IS6zcR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f76023-b142-42b9-db9f-08dc4c3364b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2024 18:51:19.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIFvddA9Lfu8S3NwNkTKcWb6guxMCRdVo5T4M5LjBqa+m81JIeWKuVFPmhsdjyhkuY7BQm0pf/jsrKCyCun6MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8010

>=20
> Hello Mikko and Avri,
>=20
> On Wed, Mar 13, 2024 at 03:37:44PM +0200, mikko.rapeli@linaro.org wrote:
> > From: Mikko Rapeli <mikko.rapeli@linaro.org>
> >
> > Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns prev_idata
> > =3D idatas[i - 1] but doesn't check that int iterator i is greater than
> > zero. Add the check.
> >
> > Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> >
> > Link:
> > https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
> >
> > Cc: Avri Altman <avri.altman@wdc.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
>=20
> I just had the following Oops
>=20
> [   31.377291] Unable to handle kernel paging request at virtual address
> 0000fffffc386a14
> [   31.385348] Mem abort info:
> [   31.388136]   ESR =3D 0x0000000096000006
> [   31.392338]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   31.397681]   SET =3D 0, FnV =3D 0
> [   31.400730]   EA =3D 0, S1PTW =3D 0
> [   31.405397]   FSC =3D 0x06: level 2 translation fault
> [   31.410355] Data abort info:
> [   31.413245]   ISV =3D 0, ISS =3D 0x00000006
> [   31.417086]   CM =3D 0, WnR =3D 0
> [   31.420049] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000084f8900=
0
> [   31.426552] [0000fffffc386a14] pgd=3D0800000084af2003,
> p4d=3D0800000084af2003, pud=3D0800000083ec0003, pmd=3D0000000000000000
> [   31.437393] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> [   31.443657] Modules linked in: crct10dif_ce ti_k3_r5_remoteproc
> virtio_rpmsg_bus rpmsg_ns rtc_ti_k3 ti_k3_m4_remoteproc ti_k3_common
> tidss drm_dma_helper mcrc sa2ul lontium_lt8912b tc358768 display_connecto=
r
> drm_kms_helper ina2xx syscopyarea sysfillrect sysimgblt fb_sys_fops
> spi_omap2_mcspi pwm_tiehrpwm drm lm75 drm_panel_orientation_quirks
> optee_rng rng_core
> [   31.475530] CPU: 0 PID: 8 Comm: kworker/0:0H Not tainted
> 6.1.80+git.ba628d222cde #1
> [   31.483179] Hardware name: Toradex Verdin AM62 on Verdin Development
> Board (DT)
> [   31.490480] Workqueue: kblockd blk_mq_run_work_fn
> [   31.495216] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--
> )
> [   31.502172] pc : __mmc_blk_ioctl_cmd+0x12c/0x590
> [   31.506795] lr : __mmc_blk_ioctl_cmd+0x2cc/0x590
> [   31.511408] sp : ffff8000092a39e0
> [   31.514717] x29: ffff8000092a3b50 x28: ffff8000092a3d28 x27:
> 0000000000000000
> [   31.521853] x26: ffff80000a5a3cf0 x25: ffff000018bbb400 x24:
> 0000fffffc386a08
> [   31.528989] x23: ffff000018a8b808 x22: 0000000000000000 x21:
> 00000000ffffffff
> [   31.536124] x20: ffff000018a8b800 x19: ffff0000048c6680 x18:
> 0000000000000000
> [   31.543260] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000146d78b52ba4
> [   31.550394] x14: 0000000000000206 x13: 0000000000000001 x12:
> 0000000000000000
> [   31.557529] x11: 0000000000000000 x10: 00000000000009b0 x9 :
> 0000000000000651
> [   31.564664] x8 : ffff8000092a3ad8 x7 : 0000000000000000 x6 :
> 0000000000000000
> [   31.571800] x5 : 0000000000000200 x4 : 0000000000000000 x3 :
> 00000000000003e8
> [   31.578935] x2 : 0000000000000000 x1 : 000000000000001d x0 :
> 0000000000000017
> [   31.586071] Call trace:
> [   31.588513]  __mmc_blk_ioctl_cmd+0x12c/0x590
> [   31.592782]  mmc_blk_mq_issue_rq+0x50c/0x920
> [   31.597049]  mmc_mq_queue_rq+0x118/0x2ac
> [   31.600970]  blk_mq_dispatch_rq_list+0x1a8/0x8b0
> [   31.605588]  __blk_mq_sched_dispatch_requests+0xb8/0x164
> [   31.610898]  blk_mq_sched_dispatch_requests+0x3c/0x80
> [   31.615946]  __blk_mq_run_hw_queue+0x68/0xa0
> [   31.620215]  blk_mq_run_work_fn+0x20/0x30
> [   31.624223]  process_one_work+0x1d0/0x320
> [   31.628238]  worker_thread+0x14c/0x444
> [   31.631989]  kthread+0x10c/0x110
> [   31.635219]  ret_from_fork+0x10/0x20
> [   31.638801] Code: 12010000 2a010000 b90137e0 b4000078 (b9400f00)
> [   31.644888] ---[ end trace 0000000000000000 ]---
>=20
> From a quick look I assume that this is the exact same issue you are fixi=
ng here,
> correct?
Probably.  Did you applied the patch and the issue persists?

Thanks,
Avri

>=20
> Francesco


