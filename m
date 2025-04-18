Return-Path: <stable+bounces-134525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BDAA93153
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 06:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526271B6379C
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE56263C71;
	Fri, 18 Apr 2025 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sM61f3kb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="epe/GzLC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5C1DA21;
	Fri, 18 Apr 2025 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744952137; cv=fail; b=rtcZGK/ZzcfpI4lHtNnylE8GPG0sBBbK8OewHJsKMI5nOihj148f1vU8qwx1nxCt5JML/7DmsJcbUzkINiwT34ytW7/WBhOj/qts2SGoezit2Tn4v69T8/cWVkXdkVbNnM9rUHXCmOTSUPYlTPWYSZqZbmXoPCw/ZeWCV1dluvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744952137; c=relaxed/simple;
	bh=ZePiRFxRlJq2OLh30olckCkayJnPgRVX8UwlPasR7iI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I4tF0lzBnkMZrPY35+Uv4RWdcsOEcBpx3D+6WxMEAAUniWcESz8Nr+uulbVvm4mzliG/elV3EoQo/QxuQjvhKUKlhUHIxEvWJRF8l7F+8G83d+L8ADFmWRFf37wKxeXuyS6LXmTlvqMrrez6eJi+vYwhr04fHWTn17gGasplC6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=sM61f3kb; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=epe/GzLC; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I3BrUd026625;
	Thu, 17 Apr 2025 21:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=7aOLXhU5DkgiFQAgAJ1jdxYfBVniLQ2hUE+RShwvPg0=; b=sM61f3kb2/Z4
	EGcswrf9ujGXwvGZRuJ0Zfp6pQKiMhxHeJxgrB4BkJ+Nz4xcm5FtGSLrxrgPrEJp
	e36IVyfyAPrypeB+bprs1+iIToGnNTFQLw+2gseILrq3CwAGqRdWYXyjHrX6srPi
	g0DNU5vlOyAuGiUmha+KquTvEiXckImcs2OJ9sqFgmHKuI196Q2hT53h3ozQ1v5Y
	EsEn3hoqQcMd0HAJKWPQrTF7wsGfGYb/djIuME2RlsjiQj8jTmO07IHiCZDNBvRv
	d4N5PQcmq+jGbiV3UcsLHwu1NQWeq1nBZm8MX9ngM1bKhTxXWiUD31qbQIZTA17j
	VVKqqDbStg==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 463emc89mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 21:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTGywKu4/WiBdXsVOWrvJWuVA493wFZDcD7zzXFV7jtdnfAAt6qrPnbtUOWyFLxfp9hKv8Oz0PTwOcoZKZ2OS6a+MJeAcrFAC4rJYLkG6uWBF97240efqbHcTfJ5q6tEsdWRurHoltvpns1jq30IrpZKz77m3RgitWaRB5M3rGBjjo4OIlLPRTHLThi+CqdwsEWaR1ZXgPP6jlG+0JnJ8s7Ry8LgpcejXClvS/mkv9TiDU/Zh4WYbxrJ/TnAb+yBQPvyj+OF20Gb1whP1IbpQyIKSLiucpFLWYmggvq2WuiRsg0kno5H5sOurGR/FS/1wNCeucKkRqYNIgfSWbwNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aOLXhU5DkgiFQAgAJ1jdxYfBVniLQ2hUE+RShwvPg0=;
 b=oi7Tpc4h5uJ662nY3py+rrGFn5LP0Q2e/gxgcYZ+g53a6aQ3Rg5VQghldyGlygby+Jf3/2sjODBn4Jd5puLdpWKn/zD3Z8SQo6k8+t1qTTDFn/dnDQXEjNPxtmvJQ5pKAHJ1QpAgJmnGaEZG73xDnlcJLLeGRyozIJouw+1QjSC1zqZlllZDn83cVjt/XJx/G1yX6z6L3hEDRfxD5p7JgVgAqvp60o1l2NG3ZXM3GxPRm7N20hdDwrX9p42aaa5iORYZboQVGafy06MYUosY/wADpfovaw7ir4Sn3KMOLRgQM352FJPQ/k+1HePSRl9V7RhJOLmeRg3Wl3sXxr97lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aOLXhU5DkgiFQAgAJ1jdxYfBVniLQ2hUE+RShwvPg0=;
 b=epe/GzLC+OU6wmL//9NJvBOozwNVd45ZH9bU1Api4XLQn3QNL3mrcGE3Vs1WuQ/rK7TtPfefT8i3CjgEi0RPaBokfZKKno4F8VhRQvfDgiM0prals4tUFilcAMPvFwUspqbpgZoP3fK5CvV2sf+MHVOq4eqJG2J5rPmLAg7Wd9U=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DM6PR07MB8142.namprd07.prod.outlook.com (2603:10b6:5:20b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 04:55:17 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 04:55:17 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: Fix issue with resuming from L1
Thread-Topic: [PATCH v2] usb: cdnsp: Fix issue with resuming from L1
Thread-Index: AQHbsBuIK1jjBwhS80mzr9tKYW8NQLOo2HtA
Date: Fri, 18 Apr 2025 04:55:16 +0000
Message-ID:
 <PH7PR07MB953846C57973E4DB134CAA71DDBF2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250418043628.1480437-1-pawell@cadence.com>
In-Reply-To: <20250418043628.1480437-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DM6PR07MB8142:EE_
x-ms-office365-filtering-correlation-id: 83322917-3ac5-4ae6-e5cb-08dd7e35368a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LtR3uezbuoQbR3g1wTOY0cfyzkNCJW+tMT12d96COllmHBsq6ZSZdoohhIwI?=
 =?us-ascii?Q?dWd1WJ+D8n5CBalwR6crsPMuJdI6ICN9d6VjoynSfck0+s3Xt/g0bEjw5nnQ?=
 =?us-ascii?Q?2ncLHEmOFHUid5SbmAT46qcuvcIPT6kCw88VTXt/0H0+2Isw8apg3FoHPBIU?=
 =?us-ascii?Q?KoI2yxYMDjXfBQPPKSo0Lqwk/AAMf2zL7A5LZSsRZDbzrRk20LK5/B5kMpdS?=
 =?us-ascii?Q?9DjCb5UIdSUkUkdcqzdsw/N3OSgxr3b4aZotZmtyy8pXSwu1s3LPTTVn+L1e?=
 =?us-ascii?Q?dQtAtsrs0n9jPx4xe3+BQehn8vMFmWnB1sC5RriFa5uUyTo6Q52GpwkGwsZ8?=
 =?us-ascii?Q?WIHZWmw9fBJ7eln0s3pvnUlgiRa2oShJ0wAN+D+4MoGNOV6PTpKTYuSo31lA?=
 =?us-ascii?Q?6dVM9Nvypl8a4TkzKdmkYKgGfJxpYxJ4CTCa257Hodpuk944tWcI4cWGNkKl?=
 =?us-ascii?Q?tuK81ulOICbGmc0Heer4vvillkClX6R+mPirnVDs67fvVK85kfjiEDEaAGJY?=
 =?us-ascii?Q?ZJS9xnOwYUQKSaE1CiUfsTY+2hUx1ZhGCeR2NGIrvrVabUJI4MdM4sIwAt8r?=
 =?us-ascii?Q?oAEgT06IkSSwF+pujyENJh08bz74kmt9z6gHuLISdbGzGX5PIuBJ6+Eq+vQv?=
 =?us-ascii?Q?cywOr+99ahb8f5TULvG6bLx2kXYRa/gm+mWycN2iRVu6el28lMV7ChznWCoX?=
 =?us-ascii?Q?kadOEcLffMKOuaoa1SesC638fbSIRj2sEJmg+5xcaDuO+ojyfb0MhyZqBrFM?=
 =?us-ascii?Q?CNN6YBw79bw5+reOqukn13PrlUG99LQIKewAf/BPC6kdMj0rGoJKQkQPYFl7?=
 =?us-ascii?Q?uMvp6AguC49a8sIWeKbr1aL5RQIAZZQ1STVVqZR1ZbsuNRJh+4DMkaa5CYpS?=
 =?us-ascii?Q?4KGCobmOaVnRTDEqxbqcuyE7x8k0FKsCY9Dv55+h5gr4mroYysS9G6CwzHqO?=
 =?us-ascii?Q?sdV7cnuMKw9AXWO4Lq2lUJECdSzkBjiaDOaGi5uprXqhkMGPvEjCBl+xGerh?=
 =?us-ascii?Q?tAFr4QqJSiko1IOxWTiHZ441DJ7zkVilt4ba7pL2YeWwfzuqIQpPsjLe9DXg?=
 =?us-ascii?Q?68xDBP/qeWpu48HHqw41Pa4lV6JKy1tNasHpAe2Of3aUIoYvJOfLEVDvplx2?=
 =?us-ascii?Q?sv/R2z9vAZn7noQWx2YA670jvqFocPrpyqNV9uwrQFuytUjqN+EocOiwdO12?=
 =?us-ascii?Q?R1GO5GG0Dh5xe+CDi1qivmNoZH7pNhwse1TC/cCnep6Jfnd4tdJEjWAV/Yyw?=
 =?us-ascii?Q?8qREI9yBoM286PBmWXj+SnLZysp4XLfGRZMwY41mOtB07sIVRPZNusAdD8Fr?=
 =?us-ascii?Q?Sb9p8tt/Q4KYKwsBxoZkO+pydaWwYm4tZsclsjObNYT43gthJIMQ/PSpWpMK?=
 =?us-ascii?Q?BA9bo/0kP/2GPKdlEWhSwhGSCeJ+cB3NMep4Q8mt5J2d4BAINnCRiApBoOX/?=
 =?us-ascii?Q?7Q6xiS8Ov1soyKPXnMK4HUB3sHJyrGFMxTI4jTlAh7n4noXzqxEK8pG1MhSq?=
 =?us-ascii?Q?y42zxRh+ujrdla4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mf58Fa/hw4f9UXGMVC0khdJcEsxAjRrVZtWiCyHMxJtZQbchKmW9Gu8ov+PS?=
 =?us-ascii?Q?jJK/5j/jA8gozN/eobiqUGanlJdx0VBrj3cgJ5oF3gOj0G28KXa0FAJrT0rg?=
 =?us-ascii?Q?Ks9l2yXT+o5Vk7HHZ3/FI7lA5l8cWS1A8i1vlqOGFx1F6ZclDk9MCMCSG3hZ?=
 =?us-ascii?Q?DCPZk4gwhO+Qpdg0cp55rJF5pBui9ywzmFrkJfIsvZ3ChWVzifrO0ztXY0LJ?=
 =?us-ascii?Q?GSkQO4qkD/mFlkWO1DlLPcRq7cwKrqFki++8dJX7CmQIIAPutSpWjiSWZhZT?=
 =?us-ascii?Q?xv3VVHcxmZ3Yer5199UAcGzDLemkNSJHRHuU3EfaL8HFhuyw2MPcGgx/U93W?=
 =?us-ascii?Q?229FiBppssCpWN2wnVLsLZqihxPpPqhNfW3eZlYZNrGOKb5EHBXKWorM4Iyq?=
 =?us-ascii?Q?csg06HVQQP+FRM9d9tfzdhfzgc/lEb73XcjMb4HldLCPWUElPexisaJDsuKP?=
 =?us-ascii?Q?b+zbLw3fZ2X6qCyn/XCcha3CVMDFNUtCzv2r8zJNzhFDitM/V5xSZ/PvJhe3?=
 =?us-ascii?Q?5Eh7jAIENL7o3VOS6oGsjZ3nZhW2nCiFKmOi4XAcjXtjSa/Atyo7kuMswput?=
 =?us-ascii?Q?pt/Ps1JZXSaMDv8talMwbUB2mOPoKpUPeeMq77VSxDseND7TdHyWAXbHP9sQ?=
 =?us-ascii?Q?/hCpZQxFCRFEJMyfOyGjiZWldXfmip/gnRlUpac3+ioT9CYfEHWnEfNqeldQ?=
 =?us-ascii?Q?8NGSwQ1duXgwiPPzAoQc8pVBIb30bwoBsS8kgNPjANX+ITMNQZENnjCD9ays?=
 =?us-ascii?Q?Gam666QxBfpTMi+vr+8ePkBDcV5TLC/qB3pMkpO2LTMRkj7TLm5hdsTDZSd7?=
 =?us-ascii?Q?Jv6z61Wx8X8KscDtfaDgkgnXbmSYmEm3eCi1Gg+mbtWsndDPTmY1Ri41YKSY?=
 =?us-ascii?Q?7HL6BppuwkMfIS3f47SCHUcSJL0msA6JTtZSsKYGw+gWj3oP518rYNfJYOCp?=
 =?us-ascii?Q?F/RQHA8SoBAYXkkenMld7I66gdclezUwpzx28CmDJxoiKs3vRkGeKfEwlRqs?=
 =?us-ascii?Q?+37WaRV2CBBpiE4SGUblH95YGMa6p9e5DH/FeN6FQT6oeYPNE/5VqzHO8AGu?=
 =?us-ascii?Q?KEtyu4k9QhGQn3eLl1LZ6VAurjNZNWKnG2t1Ewc6GBhzrYGoC3oKHtNxKcFh?=
 =?us-ascii?Q?5de/hoJDw3cYWSMaCSTlcHM+5xNMd3SGjOR3yQOMf/naIGt1dOZfciBeTQGW?=
 =?us-ascii?Q?hpg4TeqZmDUVbsYt5RFXJ+I1ctqDwV1NNqNHrv9UrELTBVu2V4tggMDBJJ/n?=
 =?us-ascii?Q?/MfpgE14/y/M938aBFHw3i70taQLX+yr9Ptwx48/NJkByd0tXLWszmms39fl?=
 =?us-ascii?Q?UJ7eYVIsypAEidr4bH8oq2sJzD5Z5XLLFKDd9oprtHw50vc30NTf/74raM86?=
 =?us-ascii?Q?U6RWfIEXUL12k2Z6QDFHSXX6kvdFxjLL/B7VEw7cZkFQVP6O2WzT2BOONaUW?=
 =?us-ascii?Q?Ds0uckOM9tQ6XhP3Jg64vO8fqdICGjQhSFK50G0KiMhmCOfu/5L4W3MnUCto?=
 =?us-ascii?Q?d0AcmNctBZ1sr08e6BTCgZPZTzgjxpZ64n/9VhTIVr9UMsSEA0ZWAhb2Yiys?=
 =?us-ascii?Q?jPQYfSCQZTPS0phVhgNuSdToNX85dJKmX8jzm9O6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83322917-3ac5-4ae6-e5cb-08dd7e35368a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 04:55:16.9304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sbr+vENh/niit4lIAknKp1Jldli81nX3UiUSeb5gTIfI7pSOhoziPoxJ7978oEfJrurfmQLL7h0oc9IS11JhaT+YJDBiEWhLo3Zit5qrDDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8142
X-Proofpoint-ORIG-GUID: lhBJdxkw43xQ7VSZfRPmk8F61pcPn8bQ
X-Proofpoint-GUID: lhBJdxkw43xQ7VSZfRPmk8F61pcPn8bQ
X-Authority-Analysis: v=2.4 cv=RcuQC0tv c=1 sm=1 tr=0 ts=6801db37 cx=c_pps a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=2DMYq8tlLlXW_nkEH3sA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180034

In very rare cases after resuming controller from L1 to L0 it reads
registers before the clock UTMI have been enabled and as the result
driver reads incorrect value.
Most of registers are in APB domain clock but some of them (e.g. PORTSC)
are in UTMI domain clock.
After entering to L1 state the UTMI clock can be disabled.
When controller transition from L1 to L0 the port status change event is
reported and in interrupt runtime function driver reads PORTSC.
During this read operation controller synchronize UTMI and APB domain
but UTMI clock is still disabled and in result it reads 0xFFFFFFFF value.
To fix this issue driver increases APB timeout value.

The issue is platform specific and if the default value of APB timeout
is not sufficient then this time should be set Individually for each
platform.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2:
- changed patch description
- made patch as platform specific

 drivers/usb/cdns3/cdnsp-gadget.c | 29 +++++++++++++++++++++++++++++
 drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
 drivers/usb/cdns3/cdnsp-pci.c    | 12 ++++++++++--
 drivers/usb/cdns3/core.h         |  3 +++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index 87f310841735..7f5534db2086 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -139,6 +139,26 @@ static void cdnsp_clear_port_change_bit(struct cdnsp_d=
evice *pdev,
 	       (portsc & PORT_CHANGE_BITS), port_regs);
 }
=20
+static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
+{
+	struct cdns *cdns =3D dev_get_drvdata(pdev->dev);
+	__le32 __iomem *reg;
+	void __iomem *base;
+	u32 offset =3D 0;
+	u32 val;
+
+	if (!cdns->override_apb_timeout)
+		return;
+
+	base =3D &pdev->cap_regs->hc_capbase;
+	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
+	reg =3D base + offset + REG_CHICKEN_BITS_3_OFFSET;
+
+	val  =3D le32_to_cpu(readl(reg));
+	val =3D CHICKEN_APB_TIMEOUT_SET(val, cdns->override_apb_timeout);
+	writel(cpu_to_le32(val), reg);
+}
+
 static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
 {
 	__le32 __iomem *reg;
@@ -1798,6 +1818,15 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev=
)
 	pdev->hci_version =3D HC_VERSION(pdev->hcc_params);
 	pdev->hcc_params =3D readl(&pdev->cap_regs->hcc_params);
=20
+	/*
+	 * Override the APB timeout value to give the controller more time for
+	 * enabling UTMI clock and synchronizing APB and UTMI clock domains.
+	 * This fix is platform specific and is required to fixes issue with
+	 * reading incorrect value from PORTSC register after resuming
+	 * from L1 state.
+	 */
+	cdnsp_set_apb_timeout_value(pdev);
+
 	cdnsp_get_rev_cap(pdev);
=20
 	/* Make sure the Device Controller is halted. */
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 84887dfea763..87ac0cd113e7 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -520,6 +520,9 @@ struct cdnsp_rev_cap {
 #define REG_CHICKEN_BITS_2_OFFSET	0x48
 #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
=20
+#define REG_CHICKEN_BITS_3_OFFSET       0x4C
+#define CHICKEN_APB_TIMEOUT_SET(p, val) (((p) & ~GENMASK(21, 0)) | (val))
+
 /* XBUF Extended Capability ID. */
 #define XBUF_CAP_ID			0xCB
 #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index a51144504ff3..8c361b8394e9 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -28,6 +28,8 @@
 #define PCI_DRIVER_NAME		"cdns-pci-usbssp"
 #define PLAT_DRIVER_NAME	"cdns-usbssp"
=20
+#define CHICKEN_APB_TIMEOUT_VALUE       0x1C20
+
 static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 {
 	/*
@@ -139,6 +141,14 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 		cdnsp->otg_irq =3D pdev->irq;
 	}
=20
+	/*
+	 * Cadence PCI based platform require some longer timeout for APB
+	 * to fixes domain clock synchronization issue after resuming
+	 * controller from L1 state.
+	 */
+	cdnsp->override_apb_timeout =3D CHICKEN_APB_TIMEOUT_VALUE;
+	pci_set_drvdata(pdev, cdnsp);
+
 	if (pci_is_enabled(func)) {
 		cdnsp->dev =3D dev;
 		cdnsp->gadget_init =3D cdnsp_gadget_init;
@@ -148,8 +158,6 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 			goto free_cdnsp;
 	}
=20
-	pci_set_drvdata(pdev, cdnsp);
-
 	device_wakeup_enable(&pdev->dev);
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 921cccf1ca9d..801be9e61340 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -79,6 +79,8 @@ struct cdns3_platform_data {
  * @pdata: platform data from glue layer
  * @lock: spinlock structure
  * @xhci_plat_data: xhci private data structure pointer
+ * @override_apb_timeout: hold value of APB timeout. For value 0 the defau=
lt
+ *                        value in CHICKEN_BITS_3 will be preserved.
  * @gadget_init: pointer to gadget initialization function
  */
 struct cdns {
@@ -117,6 +119,7 @@ struct cdns {
 	struct cdns3_platform_data	*pdata;
 	spinlock_t			lock;
 	struct xhci_plat_priv		*xhci_plat_data;
+	u32                             override_apb_timeout;
=20
 	int (*gadget_init)(struct cdns *cdns);
 };
--=20
2.43.0


