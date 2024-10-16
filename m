Return-Path: <stable+bounces-86452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F709A0559
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B6B285D94
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF4205E03;
	Wed, 16 Oct 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="2OZc0u/E"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2131.outbound.protection.outlook.com [40.107.249.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C7205125;
	Wed, 16 Oct 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070598; cv=fail; b=q6kUl2zLZX0IPodJlbQvO7w7PSIwJ23Bd9p6uhuwRxt8taSkB0aocifalLmWLNHYCfhQcnji7kIOsZfFiXhdqh1B+arluA7O6fnsnka/f7zUjt6Bwtm/vOQibr/EFFIsLSiXcIsdQGI8L6vvTcNJK8nLaNkWYFeTOeiUa9/cY2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070598; c=relaxed/simple;
	bh=JyA342h020d/UdMJzSpEdP/4UefVmPdisOYL27P3DRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTS9u5HBdplDCuogrhsyyZg9n2I72J4JkZ4c95tAbtfSPU/j5j7KzKBdV69Lrvf5kxypYI/V/DHKe/g/C07f0i0pzsCW0dVBcqGGG7PQ000QEM2uK0VZAevjtKNP62358mAUf9qxLf6oixC58ynx4d3WK5cnKTHrVQYrAtWug/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=2OZc0u/E; arc=fail smtp.client-ip=40.107.249.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDOeU0UoE/fQCLm5dMWrwgP9xHalUqeHYgtOKB6Q2wKxG1riNvB+UNjqFcnZ0+nDOF0kRLT4ejlg/MyvhIxGos+Qm1AWz+6TbhFFSaS82zZaESne19ePK04afHuO0HuvBMYCo+1RBWOwsMSBj3K9r9U3UGJBxJmXnYno/fpE1ObGo3XDupQ/IVg3GB7TPO2wCYPFlT0FHFq+9ZSFYz/p7LIoM6Nuu/CcVTG7iMwkm6cMpk4wujwN2cx9OCDMwMjYaL37amA7GvQYnZqtUNjhWtwAQWJTUMhOw0XFIZWzXtV/dd1IAW6+jiEV3B3soiiLmZKNZ1u0tFZn7UAXtfS3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyA342h020d/UdMJzSpEdP/4UefVmPdisOYL27P3DRs=;
 b=GAUGi/eG/qlGiXevANfXfVfPmh+N4owAhUoQZWqzTBP4+zwCMAgBjv3d4vkZs/95pKiit6slA+ZXoagDGekf00Y6ps6lzuKqVhvewkXYlb+0+bl8Qsk9+Ji1bNQDT538c6wLOdznKPDHsdhEOaOpDY/xKNVRVw6uei4fXu17LVZfVBiCuYml5Ab01cCx0L0o0mE1uc2Be7/Gk2P1fNgUXpSC2HsQ1cZS8chAHTT9tYIcgODRNQNG7YgaSPH5rLE/CLGR/Ko2WRGsb0YS0FEX6RcIiV1O1kzPIYrIxku/elmV1peNG7laZGWGcokh5Ymn/5hVNsmrbeCjkAxPjSnkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyA342h020d/UdMJzSpEdP/4UefVmPdisOYL27P3DRs=;
 b=2OZc0u/EKZRLttOSzXDAGSy2BaFl6vb6u7fuj4Gn++OwndP1IcAFLw8gVHma5bczF+imjqQMBry5+Jx6ltCYEbLDKuZQ4wJnIBzbadZF3Y9xuDWEYrxTeErCHeZqiZZBXvEkRUU+3Uy/loF6obrA73YVTT0reHEl+T2lg/+bK4Hp5O5HUOQUwMA8f0jKunFhfHgYZHSoDhJR8/D+uLsho0FsG00htXMxxSZ/2a/r5JEXF2g6atUXzwoP2znwVu1OoUsmADDYhhAZVZ8VzNxdnTpdoKnScsyb0VZtfbpr68+eIRbeS9Z8416g5GZ2LYINXJZquCYxmkKBtf5KkHPwtQ==
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::14)
 by AS2P192MB2248.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 09:23:10 +0000
Received: from AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9]) by AM9P192MB1316.EURP192.PROD.OUTLOOK.COM
 ([fe80::c4c5:c573:3d3e:6fd9%2]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 09:23:10 +0000
From: Joel GUITTET <jguittet.opensource@witekio.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Jay Buddhabhatti
	<jay.buddhabhatti@amd.com>
CC: Greg KH <gregkh@linuxfoundation.org>, Linux kernel regressions list
	<regressions@lists.linux.dev>, Sasha Levin <sashal@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: Bad commit backported on the v5.15.y branch ?
Thread-Topic: Bad commit backported on the v5.15.y branch ?
Thread-Index: AQHbG7m9FAVCOgG+30u3iPoW66AcarKF0eMAgANPEoA=
Date: Wed, 16 Oct 2024 09:23:10 +0000
Message-ID:
 <AM9P192MB131641B00A0EB08E81A24801D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
References:
 <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
 <06bab5c5-e9fd-4741-bab7-6b199cfac18a@leemhuis.info>
In-Reply-To: <06bab5c5-e9fd-4741-bab7-6b199cfac18a@leemhuis.info>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P192MB1316:EE_|AS2P192MB2248:EE_
x-ms-office365-filtering-correlation-id: a0e7850a-49ee-46df-f09e-08dcedc4270c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gBu9dOzfiSccoAxbElYNdv5So5r5R0jqLDBgYysl5ccpsW3LYZe9bh/i+f?=
 =?iso-8859-1?Q?1WGGH4rjrlTpJlwOjN9RM8IOkXeS03HonbrEbS2yLuiaqVPJkQEiHkutsu?=
 =?iso-8859-1?Q?vnmAaXOUT67JaHCOj+o02DBM1TapLAxAGt1xrrV7rHVTvU3NmA2AhmcpYS?=
 =?iso-8859-1?Q?uPtCeIl1x1PB/1Qo/V+qH4QgiM9LO+fQE7fEC3KtNbjRURsj2pF/GZ27SD?=
 =?iso-8859-1?Q?5b5GvEaTPjhc/Q6hmrbPLflDRwsFzr7rlixiTVMogjJ3yhrOqzeaK1I/Gy?=
 =?iso-8859-1?Q?mtvbV/MYY7zh9UFd5xiBgvYCrFYuzePMzE2pM4iTt01jIdONoSghC2es6I?=
 =?iso-8859-1?Q?oY9du4ptMNzQUX9BEzWokBkVbXzamuQXJrguCAVq/myw/bzav2dubEbLbZ?=
 =?iso-8859-1?Q?ZoyDol+AeX9bPnjIWyBAZkCfzFJg/8FMS3cKpttj/T5DqIevCSZVkRN8P6?=
 =?iso-8859-1?Q?udRti8Uv9OFvwpBm3lpKBcdRk1AVW5C+zf/itGJPwGrOMMDwt/LZcYV+nY?=
 =?iso-8859-1?Q?paEd/A1JQrJU10KblAzt4730/Ic+hKtuES20T9l6Zb0/RO79MokzLW0mR+?=
 =?iso-8859-1?Q?Rjwl/Wj1Fv0HQDDR7gbqh+dnil79Fo6HXtCuBV0LtMLV4TBhnKtcvOCBGB?=
 =?iso-8859-1?Q?JvMP8fZwrSkMGre5Koty5XB2Y9pHNk+llNkBmnwhoRFHW4rjuskP7O+lWc?=
 =?iso-8859-1?Q?1KiNpLc20RewBJVT/w3oUa/30xRxLyqs2sYTNNwccJrxXh5u3VHlI9iPfp?=
 =?iso-8859-1?Q?FrPCuFZbm6rx2YVKSNy/KBnkaKlLtTCFou+xcToYpBY52tSiWy2exHwCxm?=
 =?iso-8859-1?Q?6kVEYpbbY21c4Z6w5zB9R/aAyh1RVGRN5Bml5Vcx6qOieYDHvQirrcjWej?=
 =?iso-8859-1?Q?M/W0lvjODlLg8lxayfja/ynvkqy7/EW3mC7X/y17QM57xizTpnkq3UmeRj?=
 =?iso-8859-1?Q?HzMBIAy6U8cvhJvU8z/rQ2vm2kSvZkLdtfWOtKyhSXFibWtkxdYw7qO0Iu?=
 =?iso-8859-1?Q?E5tFd9LO+0Rhkza7tsA5Tfrn8rfhN4qjL9bMCvg4MhLSD4iZ9WkXWZfRIU?=
 =?iso-8859-1?Q?KESxqM0bjpVSGDMieW3Jq/GUShtdpxz9JvV66YFJBh34AGebZcgcg8A9gJ?=
 =?iso-8859-1?Q?qdvAlfnhCjY/4odWtTsPP8sqdDo08aWk9Pwtmdjr1mSfdZCkF/BGKM+wwB?=
 =?iso-8859-1?Q?x1IE+thIFzLAheLWPXoH6N6tTsRZCh4iYVuZ5Ol8BmanLLWRRz1ISrMqrC?=
 =?iso-8859-1?Q?svCRmWNJQ/iIei3ybWqkhPJgwmfMzmTcZV4qdDbyoPokb4UHuSlHcyCyrw?=
 =?iso-8859-1?Q?llCZ6LuAJ9EHBu4qrG1kzesnY0xtWjulvFVvFkbu1tOae6iml75vsytrZZ?=
 =?iso-8859-1?Q?2c2q/AS1fDw1QXVt8wAGj2SXc/QMUYoA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1316.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3SCPHFA1Tra0mGtsHPf5pBDGXcsgiF1NNtv6RIlMDH5q31g+Ze7AF1cWQe?=
 =?iso-8859-1?Q?O9B9rA1eH6T6cFzzpi/ynh+QOy2l3B1OXJOWEFWpYlBKjLQRtEmy0zba2D?=
 =?iso-8859-1?Q?VH0OiMpl7AEZb8tJQY3ohy/HHEijwh8rCU00NeT5SwveJ31RwULUWqvz5j?=
 =?iso-8859-1?Q?BribHR9QcvJHVopznNee5r9ly8Y0C/noH9sRW94KwulU+YrPijhnIS5J7t?=
 =?iso-8859-1?Q?BlknSub8urs8LoEtLr0ipju5QMpNrVhyLj8bxEub2HYyf30RquubFLSLSg?=
 =?iso-8859-1?Q?OoGwrqWJGmFyPZCEicE2KwjiyYKk3YDhZiyoZkYTh0/h1GOsB11tY9kc7i?=
 =?iso-8859-1?Q?eRget6eIVIQt5FmtOKwZLQRtyLmxQFb28qsGgN+ksPTO31p7Izc8qzIQhi?=
 =?iso-8859-1?Q?WLug84WotMhHTU2ZTCsyat1cP5tTKt5z61ZRdcGK2/WS8Jzq9eiWYS1BJa?=
 =?iso-8859-1?Q?u3UE9gG3qWini7i522tqOB8Rl2tsteixfXMmEvdsWcpzdtma4eB49cF295?=
 =?iso-8859-1?Q?utJN8PG+Al+hsHBHOJcrIvHrFy4eJw4UvWgnSoEHmAWMVec0P701PLf47N?=
 =?iso-8859-1?Q?5/g75xA5/Q8oMPw2anIjlQq+yHd4tPbs9LEoCqfK0b7l8pT4IV3EIO/PZN?=
 =?iso-8859-1?Q?Ek0lNobwbV/EEARqLGVCU71r1ShvwOxBV4BMFVELNF2biUy3Y9DyLmnlYb?=
 =?iso-8859-1?Q?cmpG9z0Hs3EqcpYzJbcGWGyi1Lp0AGT0OVIY2T2dFfWdS47N4qXl18kw7j?=
 =?iso-8859-1?Q?pc91JENKVJsZ9W8jvafdh75nodmfG2uVlC6HsPSxQIAW6PbhBsZ0F9Bgsb?=
 =?iso-8859-1?Q?yTWtDeSf9MY+gWRV6mArxl0Wthm7vl0UTLM+XKJpro7HAUJw7iH5h4CoqV?=
 =?iso-8859-1?Q?k3SV8ocRIrNpQ76gUp75m1o1T5MBygZqsoxGb5PnqmYqnifgyB+qr2M+oh?=
 =?iso-8859-1?Q?tqd9YIhkw7cayJUUlSZ/pE8LWgyeBNjYFGnRdktEDQIpZPGpUH0rHnr8+s?=
 =?iso-8859-1?Q?Eezhcyynw59aDVpy9oXaJtCAf///6L9LzslwHD+Jy/xss6RBPWHvP75fC2?=
 =?iso-8859-1?Q?LP/W7TH9NP7/5Zor7arVUuVcz4y9dFXIsEl1DZ8GeDhOzHTPSNjpNpi1Iz?=
 =?iso-8859-1?Q?rKY0PdZLe4+DQ/EeKRL2Xpd1vtP5NFrA9dIuJOXIpGdJPAwsciJ4MCTdOE?=
 =?iso-8859-1?Q?VnVr0i4dGDhvPjPdBx0LIsqcA9dCV5q5fnWdGXipI474ktZjM4ZtxlonR+?=
 =?iso-8859-1?Q?MN+cwGM3sr3n0JZfYiIfyWtVCdoWEigltovke+UcVfFD648xuzDd25t4rP?=
 =?iso-8859-1?Q?fcakeRzdHoMvbwUqn+mChP9hrwo6zYBGb/lMMXt3fqP8oRqSPc3f9Ma2C6?=
 =?iso-8859-1?Q?qs1Vx2DCqiIIdBHbHilZmxUH6tVouuIUZxc472+/WXY14UEL82G0N//TdB?=
 =?iso-8859-1?Q?7rJOAXZL/OPWO+Avnj0hIq0TNjWUdmW9B4uSeeTNYDlgq2GG1R+cmeiS5f?=
 =?iso-8859-1?Q?8DTw48vGG76jA0ww+e/Dt3ITCoS9uO4m7pvb3SJjCNjG9r5Z50CtI2mpCo?=
 =?iso-8859-1?Q?xq9fOfdV6PKzNx04KkhAyemAfb/TWzUGx6oqAsi9chpmolw/w4qy7rMGmt?=
 =?iso-8859-1?Q?hc+xH0SFU6Y/VG6dgwbpac9tvwmIDFzBZCGteWQCQMxhvNUhQnWhc67Oql?=
 =?iso-8859-1?Q?7XP4RiKBZ9DP5xJUyXQk3tmmTs5NETSQFQKqEQel?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e7850a-49ee-46df-f09e-08dcedc4270c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 09:23:10.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWeRKBvTR/GSxXKQh0Esf4mvaS6dTl1KMusMfZn3IjhJkr2eXTHuHcyYjlyIucWXJBWIQWiWGiTTIeSiFknM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2248

Thanks for the reply Thorsten.=0A=
=0A=
So is anybody able to indicate why this commit 1fe15be1fb6135 has been back=
ported to 5.15.y?=0A=
Actually this creates a bug on v5.15 (see commands executed in my original =
message).=0A=
I don't know for 6.8 or 6.12 release, I'm not able to update my target with=
 such gap.=0A=
=0A=
Regards=0A=
Joel=0A=
=0A=
________________________________________=0A=
De :=A0Thorsten Leemhuis <regressions@leemhuis.info>=0A=
Envoy=E9 :=A0lundi 14 octobre 2024 08h45=0A=
=C0 :=A0Jay Buddhabhatti <jay.buddhabhatti@amd.com>=0A=
Cc=A0:=A0Greg KH <gregkh@linuxfoundation.org>; Linux kernel regressions lis=
t <regressions@lists.linux.dev>; Sasha Levin <sashal@kernel.org>; Stephen B=
oyd <sboyd@kernel.org>; Joel GUITTET <jguittet.opensource@witekio.com>; lin=
ux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; stable@vger.kerne=
l.org <stable@vger.kernel.org>=0A=
Objet :=A0Re: Bad commit backported on the v5.15.y branch ?=0A=
=A0=0A=
[Vous ne recevez pas souvent de courriers de regressions@leemhuis.info. D=
=E9couvrez pourquoi ceci est important =E0 https://aka.ms/LearnAboutSenderI=
dentification=A0]=0A=
=0A=
On 11.10.24 10:48, Joel GUITTET wrote:=0A=
>=0A=
> I faced some issue related to scaling frequency on ZynqMP device=0A=
> using v5.15.167 kernel. As an exemple setting the scaling frequency=0A=
> below show it's not properly set:=0A=
>=0A=
> cat /sys/devices/system/cpu/cpufreq/policy0/=0A=
> scaling_available_frequencies 299999 399999 599999 1199999=0A=
>=0A=
> echo 399999 > /sys/devices/system/cpu/cpufreq/policy0/=0A=
> scaling_setspeed=0A=
>=0A=
> cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq 399999=0A=
>=0A=
> cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq 299999=0A=
> =3D=3D=3D=3D> Should be 399999=0A=
>=0A=
> After analysis of this issue with the help of Xilinx, it appears=0A=
> that a commit was backported on the 5.15.y branch, but probably it=0A=
> should not, or not as is. The commit is=0A=
> 9117fc44fd3a9538261e530ba5a022dfc9519620 modifying drivers/clk/=0A=
> zynqmp/divider.c.=0A=
=0A=
FWIW, that is 1fe15be1fb6135 ("drivers: clk: zynqmp: update divider=0A=
round rate logic") [v6.8-rc1].=0A=
=0A=
> Is anybody reading this message able to answer why it was=0A=
> backported ?=0A=
=0A=
Looks like because it fixes a bug. I CCed the original author and those=0A=
that handled the patch, maybe they can help us out and tell us what's=0A=
the best strategy forward here.=0A=
=0A=
> The information I have until now is that it is intended=0A=
> recent kernel version. Dependencies for this modification is=0A=
> currently under clarification with Xilinx (maybe another commit to=0A=
> backport).=0A=
>=0A=
> By the way, reverting this commit fix the issue shown above.=0A=
Does 6.12-rc work fine for you? Because if not, we should fix the=0A=
problem there.=0A=
=0A=
Ciao, Thorsten=

