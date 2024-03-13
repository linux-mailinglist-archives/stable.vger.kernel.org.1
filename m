Return-Path: <stable+bounces-27599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1418487A965
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CD61C20D9E
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97B46430;
	Wed, 13 Mar 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cfdPJrSt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AuAF7gO/"
X-Original-To: stable@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955933F7;
	Wed, 13 Mar 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339854; cv=fail; b=pXULKpXnxZd9zO0ZCCdB1GdpK4gPvthgIlrplmYII+PfMtAcj72vWFs/C0B/Ngdojk5A+nFTgehhgc0j05EuMyMk761R3085o/1AOHlXmqH2NKQykbg9yoveXPRB63XsK4Jjpr9Vx5/1s5pFU6SMZQZKMZ9sYLyuqPjDsjfVgWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339854; c=relaxed/simple;
	bh=g58i1DaEnCsSRyuD2+c/ELvd9G1VLurRzfeadICpuMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oO1FK8b7SQLHlnEX5PiOK7rsdvf+PhtH28ORCQ4ejzX0d0Oo5Y+VCGtHekn9F5BAiOTzF4kswK0ssDEk+V95ViVctwILX5pJPr3Zw7XEJHCzTn+YVAIGnAtIWVg9Mzbtq09OfzSHhBU/a/26BY1sKjnmR94ERgp3gH4XvCGmZR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cfdPJrSt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AuAF7gO/; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710339852; x=1741875852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g58i1DaEnCsSRyuD2+c/ELvd9G1VLurRzfeadICpuMU=;
  b=cfdPJrStQEB281GOiWKJ7wH1koVFau41qa49WXFspIc/ouF8gwH7KY2E
   kv5eXHxCT8aqJUBiSLhAqc+XH1l+bHyPhFjkPgGiystqjEen397bzhpFt
   pCVDUVHQmF4TsLD0U4HUiOmqh1+FYEMTyiV3jfqUuq/MDJWIAbSue94nk
   3HR1iCF/oz6TIy+8Yu4Cqe604eZGRvoOvV+Gc2J/GSrJM/60CeikU+qxu
   KDMOR99zUGJ62EEWIxuBnqtMcI5L+/R6bUMpJVl/9IwlTmU3Eey68wiDa
   WV48fMlGMwhDPAHB3vVwH1BIxWyNU2kX2sJWfEf35AppEuRh+we/i+W0C
   Q==;
X-CSE-ConnectionGUID: am4wLQZnTO6AYN1wevZfvA==
X-CSE-MsgGUID: FLoQSkoSRVCwKxb8oKpHag==
X-IronPort-AV: E=Sophos;i="6.07,122,1708358400"; 
   d="scan'208";a="12114799"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2024 22:24:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKsXbB/o3lAdFLv5GakyWfTXpEgko92kcawyOXg4jiKuK8z7p0wuMMiqfa2x3w+jdV83igQ7KBh1WHjegczmutAc7La6Nus/JWrGlC4lpwDF4pc0VusvAZ/UH4/7l/ioxYN5v7B9Ei/By+YJp2m6l6/ht1b2vkl1zicDsJKd/QUgD8kyQ/uEoOimwZib9i9KVQmBqqTB1ZyfdQs1HX/pL15uQWbKYYne9YzfQTQH2lmu6MZBg4V1lZrXhI2eVuc4XTtcSuGJFhcdLlVz06ZiWaFrI5p6uRehZu6xTPbvzRafCiUzceaL3+VH8mfD6+RvduL5VXBVUouGVwdIoRgpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZqnd/t420rFpRizj4J7+SDeZyzDPusx4IQ5x69Y/Mo=;
 b=Y5cj/PznD0cygAoBBjdlWhro6nqDRqpK+PqtBoIi66HqNDBfXnxYkqw+FtZVmusVxLTUmlV53MK/yzy5i93JLzNr/FUyI2aoFF91BL+qrQPZOQxWreVUtqO2rwjDqjX+akDUiKyuMG8ZLUMBsGRAPwnbTjGVZkYc9/r99VxVlffuHB/ADhrIt2xlPhMgZd1x9GepSGi7ZeHl3pWKvmVhiyvqKAb6CMeZUOZOj5saFIixx4wdND8fzeVOAY9ydo00uBcc+Hp1eKd79lLulIbXCDBF8MKmg9JTD3ljX/XftZ+0Z2WE2GCBOe0zcRB8CJu6QYKdov8ybOFyj2FQXj/7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZqnd/t420rFpRizj4J7+SDeZyzDPusx4IQ5x69Y/Mo=;
 b=AuAF7gO/9PLv5E/LXotTSAIfRrZc0BkScokrl+Ngivu4CGR5Rp9GNcbKSSKbxly7rsbhAWQOFSjj6UCdL8X3W5sva/lX5K5fP7vUVGwmhKIXwDKtxmU9Yrw/nEzxCZpuiBPNKiDzD+uCYipq/HMngKTVcrzTl0tFhEY9TpSojpc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6519.namprd04.prod.outlook.com (2603:10b6:a03:1d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Wed, 13 Mar 2024 14:24:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 14:24:01 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Thread-Topic: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Thread-Index: AQHadU5ngmlO5sEF+0u0J/Wduu7Z57E1tj+AgAABwYCAAAB+UA==
Date: Wed, 13 Mar 2024 14:24:01 +0000
Message-ID:
 <DM6PR04MB65755242995E18733F7F9088FC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <20240313133744.2405325-2-mikko.rapeli@linaro.org>
 <DM6PR04MB65753CE63956185656CB7580FC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZfG1r9jmxBKPkmcd@nuoska>
In-Reply-To: <ZfG1r9jmxBKPkmcd@nuoska>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6519:EE_
x-ms-office365-filtering-correlation-id: 110f997c-28b7-4039-a016-08dc43693aeb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NgFSdoc/vhxP+swGimieZpLhnvbnwffuvFAX4qtOUch9kHNcwXShCINKJX0A5UplZ5srwjO5BOYwhKN9q4tkfe4mT4Cmp4inrLM9s6TIF9vwIIxZByXru+2D1KsYrH7p1C/RK1bUnLKPJRLWJfNKZoc/mdvNwOVPvXxe0115MKKKx6cd6/RwsxmD1XK08lq8KMRXaqJIrWpycOiRbgcfo/dQ7dA190C5VYryMKAbTHf5Hk01Dh9NRu3uww6/YFlP5icl2VcvFlseTygbRBEZCSiCa45WLbBlrrMNclS28JA0GIr/Mq6SL8Cups8PZGuq+/UUCBCokNZ44gg2dkrv1FWSVOJGqAzRUb8bjFG7I//R3xdyzxWollTmVDNViPfojZrrqqQBNyyBYSQTQmuhPC/wR2Pp8qm7SE2o6EQljvJAYxx8LuXyUWjoCoRylTWiPd67yHgtlxoTW+8Z5ZK28x685DbqbO+cCl6X09FH4hPu+cL/z9QtwI9F4K6+frPmcZm3iSMDtawO/GGpEDaPdQ5ZUTW99g5KRXLNd2B0zf41uWw3J4qaCON2TWL2+6kM43z8aQ6J8cua+Uh5TuXlS1QBtzslsQw/Ycn3ddhbzkfL3P1aulS0SI08BDuroQaqYRiRekHbi7rAR3qzvQu0McxUMOWhfrTcyOOegB1y9zM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wJy5zXrGZsM6MLt3X79Qwh167hGj2A7f7EHF4D+gw46avdFsk9YASUu3Spa9?=
 =?us-ascii?Q?aBqbJyffu+xrhSHSfEfXtcIyaQetdmuhkfLRKwEuYYCTujNi+bFFSKwMOzuU?=
 =?us-ascii?Q?UFeXYaooEcmx5FRveLFf724dYBsSr+etjABl4xhBuxz973BStY8N6Vs/zM3U?=
 =?us-ascii?Q?Li41MDYGLwLMlDfou6JNCPYhiwxs/DP54igV9rTO1/+NE10jmVfJqZ492o5Y?=
 =?us-ascii?Q?nr46i/JjAoohuzXdYD6ybt6Fl5T7OfCs6EmMZDeiQi1GQycYd4M5FUElFFko?=
 =?us-ascii?Q?ZBckywqYodplp3bbsiLh3D0FcvNfZrohIM25/f+LBJirLE1iIV44eMFu4Kcd?=
 =?us-ascii?Q?ebt1+M6yOVGrjyhs6mPG6jYhm/rzwuOZDjXAwWg3mRrrLQ+lv8rfEnR0OgQH?=
 =?us-ascii?Q?Oc6axiKRFDQsmI+BPyIMVQQAz6Im3nmTygnYbauwfu1pwQtd5FssHWlCflqZ?=
 =?us-ascii?Q?Ac+X7pFJF4bduGT/UcRiF1YT2SKug3KcRNacfLw2aY1WpquFipmqjr3WBjZC?=
 =?us-ascii?Q?vSB5vEtbgrUIlDD+RjnY4ubq87oZeKNaMN1b7GLmESK4ypctfjWy/hmILNwo?=
 =?us-ascii?Q?olbHJy5OCFKCiKoK8p1pt3ELyLTk+ArnpVjY7aWEnQK4CncEqyHi66BQNiOC?=
 =?us-ascii?Q?JIKfiNVY+I36Osuykw/LxArK3iWZouIguluBq+LaDg48tdiyYMASsGJFiFMq?=
 =?us-ascii?Q?dc6Z4pfiC/2SGcin8c+zIyXaGWCj9g5p1on9j9mKvsTvQP0rCcsYVbznWc0a?=
 =?us-ascii?Q?QL0EbERAqqOwD7nWq2by2VqZasmu7WCfrsHtAFGkv+hqpv8wBd3xaFjyrl36?=
 =?us-ascii?Q?VKiAQiqa5oley0giiA4hInYqhEybcKQgpFPg7GYl02bLdZifBeR/RabZbRNW?=
 =?us-ascii?Q?96gDj2teJJOshv1ZXwRYhpyVzO4H923hnT8j9c15TfBq7aLwk5YGpGnlzD2G?=
 =?us-ascii?Q?XBnyO5rUiK8BVJutch+95eNyN9k/ER2Q0xj5+4ZSbJ8Qgy3wJLv9DXFKFLxW?=
 =?us-ascii?Q?tHDrbVmewjtxgQRPY6KnMvT3iFOT6hbIEhMHK90k9YOXcQesy3I4nMlYZv3S?=
 =?us-ascii?Q?glvjdZpogX7OXEo4iM5tahCL5kjAYBkqWgQ2xFQ7oXJw29RIlgYYqAiyXRD1?=
 =?us-ascii?Q?Ri1BpKYJEnwM946Zx34cpvw7xPh2PzjNgN1N8aZLFiwWb4xmtXRyDV9+Rfjp?=
 =?us-ascii?Q?GTNMHs6rU841ROzE4QzeR43Ui47nUVklryUYwXA1HvtOpvjqiXdKOoR1lIx+?=
 =?us-ascii?Q?8PLut82Mp2smkMcjtgw3D1Yw8JF1dxyMeNgbn1Ec0H1hZUym+6X2oR7FeEaL?=
 =?us-ascii?Q?ZD3r5IbaV4WMMaUddPGhPX8Yt1hUE/lQwrefV6AR2G/GE6qXQKD6Zqy977Lw?=
 =?us-ascii?Q?Wo7OVR44yjYzzAhWSqzquNDBCtCIZI8Mpq+HD+84TMQxML1+RujqJGZabH78?=
 =?us-ascii?Q?wxmrHKH5MDtUfKu735qMvKrjWqv2iRMejehSxPUahHUvRTqtgxVVwdnswwu+?=
 =?us-ascii?Q?lZx/rnVO1mIx3JCg9/qFRRXPX6gvB7KUSwfFNRh1HRPIGXgKe3lG6eqYCHpN?=
 =?us-ascii?Q?kb52xhisQXNJmcdonl768JW6HRJx+oTK9213O0Bo?=
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
	SquR4qslGMuTEJ6OoEY6ykDns4U/9uLq8Q/mItd0biPCVLbSEHdDXxt5F7ZYwfooMGsvrHgb9pUIKiN68qoCw53/aAnp/j+dvOWw2/T6WW3eh4YMtfeyKuvUxabogRWIIN1C3iN2A9mlNH4k9MxGciLsoCXvknHjFbTVd8TFoHNOdk3sdNQ0HfhuIoR3M9gXzcvEeQXB3oTiBrMg3KEnfNYN259wE552jNEi+0aMX4EDcP6wvVpudKlN8dcSWGldYfd31fX5+mhPe8oQXQBi3+PciqutLyzTc/QSESngHM3Zx5yJ0xxV2QTJvskEV07+UPFC3vqhyhoP3JrX+G/UrplAy/1NuuIlqY00+hckBcb3XgdPEffhWxFwFNlRgUE4puGySAI5j5B7J3NcMJ9At5bJ38I0/DyNIEGq4p8wHyWxrXaVZPR907mMxNeJkLtZoBPUgveSHTlVFJJntLUlwr9kJZOSUPR1YPlWEH/1chl3qPxF51Xsfwb0PjGnMK7LzfZ0eSg5uTrMOT/TufYk0DGsD8R4bkWywMRJTWMP3kouXUNtoe3J5ifz0wrhrN+S206eeOQ3RD4sYYafRrZIVuPS5ECaqRK4XPgR9q9NHfaKuhBNQp8rf7tgKVmqm3vF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110f997c-28b7-4039-a016-08dc43693aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:24:01.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqavPyolZV/H8KJJkvoHww6uIwvag5WSf0UK8qARyVjCJHiAzUyqcL+Qho32yXh2nh3fJ0L3ssr/zS5+5JgHQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6519

>=20
> On Wed, Mar 13, 2024 at 02:12:52PM +0000, Avri Altman wrote:
> > > -----Original Message-----
> > > From: mikko.rapeli@linaro.org <mikko.rapeli@linaro.org>
> > > Sent: Wednesday, March 13, 2024 3:38 PM
> > > To: linux-mmc@vger.kernel.org
> > > Cc: Mikko Rapeli <mikko.rapeli@linaro.org>; Avri Altman
> > > <Avri.Altman@wdc.com>; Ulf Hansson <ulf.hansson@linaro.org>; Adrian
> > > Hunter <adrian.hunter@intel.com>; stable@vger.kernel.org
> > > Subject: [PATCH 2/2] mmc core block.c: avoid negative index with
> > > array access
> > >
> > > CAUTION: This email originated from outside of Western Digital. Do
> > > not click on links or open attachments unless you recognize the
> > > sender and know that the content is safe.
> > >
> > >
> > > From: Mikko Rapeli <mikko.rapeli@linaro.org>
> > >
> > > Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns
> > > prev_idata =3D idatas[i - 1] but doesn't check that int iterator i is
> > > greater than zero. Add the check.
> > I don't think this is even possible given 1/2.
>=20
> With RPMB ioctl:
>=20
>         case MMC_DRV_OP_IOCTL_RPMB:
>                 idata =3D mq_rq->drv_op_data;
>                 for (i =3D 0, ret =3D 0; i < mq_rq->ioc_count; i++) {
>                         ret =3D __mmc_blk_ioctl_cmd(card, md, idata, i);
>                         if (ret)
>                                 break;
>                 }
>=20
> First call is with i =3D 0?
I meant bogus MMC_BLK_IOC_SBC should not happened any more.
Anyway, that's fine - let's keep it also.

>=20
> Cheers,
>=20
> -Mikko
>=20
> > Thanks,
> > Avri
> >
> > >
> > > Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> > >
> > > Link: https://lore.kernel.org/all/20231129092535.3278-1-
> > > avri.altman@wdc.com/
> > >
> > > Cc: Avri Altman <avri.altman@wdc.com>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: linux-mmc@vger.kernel.org
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>


> > > ---
> > >  drivers/mmc/core/block.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > index 0df627de9cee..7f275b4ca9fa 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -488,7 +488,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> > > *card, struct mmc_blk_data *md,
> > >         if (idata->flags & MMC_BLK_IOC_DROP)
> > >                 return 0;
> > >
> > > -       if (idata->flags & MMC_BLK_IOC_SBC)
> > > +       if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
> > >                 prev_idata =3D idatas[i - 1];
> > >
> > >         /*
> > > --
> > > 2.34.1
> >

