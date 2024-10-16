Return-Path: <stable+bounces-86500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64D9A0B1C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AC51C22784
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F162209687;
	Wed, 16 Oct 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="JS4jY5Rs"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A012E75;
	Wed, 16 Oct 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084429; cv=fail; b=snOpnW+47Gxrk/3eTzKDsoAz1YZLabfwYJrqszcYJP1+5+2RY/qTsBDI3p5lQWJ9SC3v8eQQmpt50YWb/U0ff/FRaT0BXA8xF9J4O6Q4INfu0uyhEhAUuD+oFB4AMY9v6PIB6c4TYEEg66faV6ZJzXo2w1GAMyseNwUiAkk8A1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084429; c=relaxed/simple;
	bh=U/R5xWFRqwGmcG7lO3NZ8YIwHCFhLu+AaYKw15YZ824=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCe+sT0RBpjt9111L6MpBWQaXioF5+Q3CIrIfkbj5QtIATmCbLgHIkBwPBebU0qLlsP2o/h+2Dj/CfKQZC5vkkr8VXU3ZTUJEOw+kmyp6SlwyuZL0CDO8hIZxUZpnVrSDhsWsKAi/ZL2gEvSgyYqE2AWA+xanI7Bf5ioSNquFgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=JS4jY5Rs; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7Gbb2mxipzc0nc1YR/OmGv8h4VZmD8Bd1cxE60hI8L/79pWOrzVGwN1CvMixmqngnrkFYOalqoYFLM/KctrTButUFWQgSzDjIvhdB7ZTBJBzU2P0OYauFpexgXgRbsSewv8AS+Ks627e9BpR9598cM/MsuirmpurzyNW7fv4khPq5og5x9Lz+Ui1TQxyD2PJZyabha9p+CLZbnALkUpyx+Cc65M6pMUiw83ZLzW++DcmtJw7l935kVcpLMZnpIzj+aGAJWWhK+ID5X7I4k62ofS4MZN9SrTAlxNCphH4fetn8zx7yuT7Tp7kpJKtYp5S0cvmFXwtijVoEp4HbRq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/R5xWFRqwGmcG7lO3NZ8YIwHCFhLu+AaYKw15YZ824=;
 b=I2a0Du8ayAaOldoTD0X7qWItIm+LUkZCDwIC7fRl7hVH4mG+RjOBK02QThU4xAOrei3eQyzep0BWtM//fbKdeKjtLm/qGEl6otYz4S5p1LDdYB4dOL34IUwvmulf65+bnwEt9gebyl0RAsdqnyXMiR9w2edczFoI5W5Z00l/fb7ztdv5C/+Y4zwOIqgnaRkpTDKi+OgjARZCGtDWz+R7H8XnAgkyjCtgDISfdd0Ehw9Y6imYU40izXus48T0RmS3pTGjWnvMLBjvI7lpoSEn5UEkrTImhpcPy09doLyggQaCM27vSuTQcdISFrA5AOxnDjo1xC3rO+6GbEe+LyCFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/R5xWFRqwGmcG7lO3NZ8YIwHCFhLu+AaYKw15YZ824=;
 b=JS4jY5RsDdF3mtx7EgBslZhl6guf+8qlIDGhVO4V0WXTahQAlmC4idM+uglX7igm6f1rV2cf/vJ7JSy9fv1d1U/73xJ3FKOQ3Dh9ohygAOfqo/Aa39YDIe8KWQvZI64uxafjlIEFmXsf9YfX4ckia9jgFz9E5Oc1MF0AN+NEes6divGd8ziFN2iH/3oPEtXKmgaxOlLGKVZXC9SkyIC80340hiCMTaoJA9o4o+5/gZaqYncpFTEUB4/LJ4+ON51dgPw/Ek3NH7SvxsvBMXM4bPY7yf20kDq7T+KbqVbvoHKLDY61zshFDT+m/NNV4jokPxlOJvBy8eaTN6m66hVWAQ==
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::14)
 by DB8P192MB0645.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:164::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 13:13:42 +0000
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9]) by AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 13:13:42 +0000
From: Joel GUITTET <jguittet.opensource@witekio.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Thorsten Leemhuis <regressions@leemhuis.info>, Jay Buddhabhatti
	<jay.buddhabhatti@amd.com>, Linux kernel regressions list
	<regressions@lists.linux.dev>, Sasha Levin <sashal@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: Bad commit backported on the v5.15.y branch ?
Thread-Topic: Bad commit backported on the v5.15.y branch ?
Thread-Index: AQHbG7m9FAVCOgG+30u3iPoW66AcarKF0eMAgANPEoCAABrNgIAAJoTn
Date: Wed, 16 Oct 2024 13:13:42 +0000
Message-ID:
 <AM9P192MB13167529B6C73DC8686C2F86D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
References:
 <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
 <06bab5c5-e9fd-4741-bab7-6b199cfac18a@leemhuis.info>
 <AM9P192MB131641B00A0EB08E81A24801D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
 <2024101626-savings-ensnare-1ac2@gregkh>
In-Reply-To: <2024101626-savings-ensnare-1ac2@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P192MB1316:EE_|DB8P192MB0645:EE_
x-ms-office365-filtering-correlation-id: 24f71170-9455-4c4b-cae7-08dcede45b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GM/lIejdQ/RWzEW/v5sK9WDhcBByl8F2x2NjzCCE17drucQL03ZL3zU24k?=
 =?iso-8859-1?Q?cCJlP1WhKtWjapCRLGu8CUNTAuMGm54BDYBHxDcJX91YEURQY4V+N+WP8Q?=
 =?iso-8859-1?Q?AC3FSZ+DqLQIzjb5lUAz/t6wgX+MVjmaV5yw59ry5FpjJTUIqHsulwbp7r?=
 =?iso-8859-1?Q?vNBX9GmSTaoBdH1ZaWkNpWQsiGA/1FwAuTj+4EnDSuEuZu3I4TdtUXFu0B?=
 =?iso-8859-1?Q?FmF+r8Ohkcch3IrxZhNhPSRVq8FcQOJQDVxY6e0TgFtYDHD8YqDQeTKjYE?=
 =?iso-8859-1?Q?o0QVgcpB4eRUrrGz+Tmdc6ewVigmG165XD4FbDofroVfIbOcUw1W1BLKmo?=
 =?iso-8859-1?Q?63y+jfLWJshq1lP5qN6UcI69iUmmVGM8+KcHphluM8nwKahNXXSwJgg+zk?=
 =?iso-8859-1?Q?DSPs6ImNGA0Q3ZWXdywMbgms3JP3MPtn2AaMV5rwhYNWDP2HDf1XsrTie3?=
 =?iso-8859-1?Q?8mql/h4Mbt4PMoUFRaCk89EJsGr7azPU5ep0cmdbK5D1uB3H3uOl7PcpXs?=
 =?iso-8859-1?Q?v1x6FOghDwyK+Xbt/we9Rxet9gt86sSeXlzSvlQ++k1n0I8Gfw/roDgS6u?=
 =?iso-8859-1?Q?YJxft9gou1turqxSd3qQmOiZmsGQmPK0XnAvpg+4xWVC5GgU/2S4ii69S+?=
 =?iso-8859-1?Q?bLHegrrrUCStRZ1H3VMDSyHh+gMStlTxqTjkeaWsiC0AlKmVJlb0DPIyDJ?=
 =?iso-8859-1?Q?uyEcjMrbCZWCvDFKWKaxmy8ji1yxGtuYqYr/fj4OnDAIXiL7OYAIPOoaJV?=
 =?iso-8859-1?Q?uy/8As+/cAvvFf7uTIC0ZQukca7DKVZi5tzpz6PXaJ2PNakQberwWh05em?=
 =?iso-8859-1?Q?9yLQM2hhirB/B/XXp0p++M0f4rJWnSqvufKV+rN755sXkJ/mYvwb/dhdF2?=
 =?iso-8859-1?Q?DoKGp0nRXK+tIsLjPEF2dQPRGHO9Urbv6hZtu/vKH6sWtTk0mAl9GDoDSp?=
 =?iso-8859-1?Q?uUHCzz+9nlwKmgK9rsBbxLKmB4ErmODk2m52Km+zV8+Wa6P/m+jTOuDu56?=
 =?iso-8859-1?Q?neYJ82tAl80HI9/q06poutftxakdBTjZfb49f3W1TGhx6YvQxGxoU+3yBm?=
 =?iso-8859-1?Q?O83eR9nCGW9InPoy8VTvycmvpGFgNoB3lkLhe3Yq+16aXp9wUb6+9fPd8B?=
 =?iso-8859-1?Q?8rEShRxiremYAFLlRZ5BXW9M3vvgxc8f+1q/d4Ju5CB+9GFNkOYZO25g6U?=
 =?iso-8859-1?Q?zslCYWPAJNLl+2+Q/CGHzOVN/EDw2WJfOTiVWoJmvICdyN641XUuWsH3G2?=
 =?iso-8859-1?Q?b0fDbwfuKbMEOC3kuayIeEPr6HreArrQIJI3ecy4bbvT6SoO00w2GkQir3?=
 =?iso-8859-1?Q?y+wJmMxuFHuG11qqDDXssOYqG0+FVtlH+WeZvywy/YCFkEDAD2+6PaAaS7?=
 =?iso-8859-1?Q?hZJlFAJ3/oqoAqvnrQUHDSiVDOaJP4eA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1316.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?woqMUq8sIN7k2N7PCI9phaIJG0OBLBqKAqtqJJj2sbCrEkjCoBxz8lN2KG?=
 =?iso-8859-1?Q?OQpxx5O/QmwtH/qsdv6MNqXAj7zTqU7dfIkMaJ3cwJadaxoCbbhpFtS8Ef?=
 =?iso-8859-1?Q?kyV7tzRDElwBXkiL6jwGU5W3pm8Rq1LqsgjwiYD7ZmpMZNoO73QCVITdbI?=
 =?iso-8859-1?Q?KhGVzEGfMuelLhuuUPqKEctW68/lvp0lj8wKmSRNebFiE3nXGX6XePe/kY?=
 =?iso-8859-1?Q?P4yX2ovav/micL1RuUtyZN2IP1cEsL3VQ/O+Myc3Xku1ANgTgXAGolZEKJ?=
 =?iso-8859-1?Q?5AkQ7sG5Mxb55YJvYytUcZs5v7QMtoUDesthaUHrMDAj3RgggeuZb02J8D?=
 =?iso-8859-1?Q?BP5gXR4ER4j1i2xJ8bc3wwfUia0HIoNTT+UJVpZx4oh3xUeApwNtpfxofN?=
 =?iso-8859-1?Q?StGp0++TR5c5rMxUeaLCCOUE1hDdsciRpDwGzykRNKzxdWMRcDREPSPaLp?=
 =?iso-8859-1?Q?crgdOfT09wUu2rDEsedb4B+VMdJO1OWaKtUHNBTz4Gr7mjwoGxOuE5hDNn?=
 =?iso-8859-1?Q?0XIE6p6ow79VjjyQFOmH9uEK5QYhmCn8DNAky7ELu8qZC4ELJDdXT5TnYr?=
 =?iso-8859-1?Q?dho/RTiyWc2gt6ogtwSJnH9WpvaNFYSbPBqKq24Q2mUO43iqDWdQPhoeF0?=
 =?iso-8859-1?Q?559MuQQmLPWxOB38cfnD7ZYnx9/9fcLO2k6dMQhsSYudxxJKn4/fXBryMJ?=
 =?iso-8859-1?Q?/fjQT9XawFvCX4Q2FWGCC4NDPfbF8exe6X+WTMAiYkZSaepZeZtTFRK4Oz?=
 =?iso-8859-1?Q?yZsCrDf4poFrFZ794j+TOx3hWv8JqLK6N7NB1jMQOYS3O0cmiT6Mo76EAS?=
 =?iso-8859-1?Q?cPi5EagF7y9WRiSkwhnNavMasp+Kauohj9436p6cJFbti4mdRjm3c5hx1N?=
 =?iso-8859-1?Q?4r+6qYJXSxPJQtfDuifdWDh7vbn6z9JMx0Mf208fxDeVHEG1xcuRZD4S3M?=
 =?iso-8859-1?Q?lvZthlrkmp20Pk0KgTo0BxdR4Vf2iImgvxA8NGyIwURm6seyVfnji4OAsi?=
 =?iso-8859-1?Q?uD6gAqrtiOre6kLwPjDtzk8Kt/IT8Pq96JE/qym4xyrhuwTMK+1NEu8gnv?=
 =?iso-8859-1?Q?jVQBcRWh4aOkfdkjC4iBcD2WOFUocQtkrh5DejO8HBiQj1IQ5Se/WzmVL3?=
 =?iso-8859-1?Q?rGCOF/5vFpuPiS27MUYgjwpbDRQVuoYlOVgtXJtWci2Np2ys4dcG04Tu7q?=
 =?iso-8859-1?Q?jZBIQOSkDXk+K6S19qkJmYp0OUvdHKQst5vAtlzeW333CZzciCo5zUIdT0?=
 =?iso-8859-1?Q?tNblEKnYLU0lvndNf82KT175Ic9FgAve1UR8pA0y4yEfMcVRqnejeS3VKP?=
 =?iso-8859-1?Q?1qC42GXq55zUkTEPc7wajudSjKrjHhW5sz8a9xbGBlHcn7JrlCgN12qVwr?=
 =?iso-8859-1?Q?XF+gZ0OnB6N+796RUrauDm2pgu5XIjS2ep+ZUtiLCc6tDk6F03U+9Im1hm?=
 =?iso-8859-1?Q?JKhjlNQOWDu+QnGKVL5Chi+jjP1nxIkEcPggKzUyPP0X78dPY2IPmlqK6j?=
 =?iso-8859-1?Q?/qoUI3SVWnYnUEahL7LpbwSvga8Gs9ZVHQHRF6ocS5rvI3dLgnmFJlLkiA?=
 =?iso-8859-1?Q?ccm02xoFEv6LxBdyt68mM0wzMzhy9etd+fIJOJNZZwSvEczznihG0EQVvu?=
 =?iso-8859-1?Q?oY7Pj/jin2NeClWwNXFH/dhXQQ/29a/6Qp7rN8h/UmVVd78F/l3zdLwK+m?=
 =?iso-8859-1?Q?L5fobm0CEFDfCcAN9hojNgcvN+2GeuIw345QhKxu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f71170-9455-4c4b-cae7-08dcede45b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 13:13:42.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIJFtzhtGvSvP5DIp5XmoMkvpvw4P5EN6TLmoxgZZd6Ej8XARMpfoy9gq9hsc7HE+2lLbomf7GLz+fAbEmxsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P192MB0645

> Because it has a "Fixes:" tag on it.=A0 Is that tag not correct?=0A=
=0A=
understood why it's backported. Probably yes. Or maybe another commit shoul=
d be introduced to not create a new issue.=0A=
=0A=
> What "original message"?=0A=
=0A=
My original message in this mailing list, see below commands that show the =
problem (last line is wrong):=0A=
=0A=
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies=
=0A=
299999 399999 599999 1199999=0A=
=0A=
echo 399999 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed=0A=
=0A=
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq=0A=
399999=0A=
=0A=
cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq=0A=
299999 =3D=3D=3D=3D> Should be 399999=

