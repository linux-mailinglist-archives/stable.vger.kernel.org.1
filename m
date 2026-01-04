Return-Path: <stable+bounces-204581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B53CF1AFB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 04:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8092930021D6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 03:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FD31D74B;
	Mon,  5 Jan 2026 03:02:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2093.outbound.protection.partner.outlook.cn [139.219.146.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FF31196A;
	Mon,  5 Jan 2026 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767582124; cv=fail; b=VQ/GXZA9CSuyNpSkbk+4Nl2p6gqZDqDqxWg7xXW37d5H0aBJmLI1aXSUZWvoMy3yBdUSc/ywqd2UzMqRgE2WbNgXFmQgNJqEQ5JpM7lIT9zqpVP/BnknTVhkmvm5Jot4FhAY6TYT7uHlZxNiWNne2oeDirVG6Bop2rtEfm5m4D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767582124; c=relaxed/simple;
	bh=OA7VFK2yn1Gj2P/LV4gqW2TeW0SAYCFy6YOABh7SG64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UvIH2uBurkdA7k9W7Kw00T0T8jU029SZO0feI1+U8XIu0mi++qqI4XfPEq1Q6TxVcvVWa6P/hc3nizvODyg3bfL7FB+tdMzsZTA6HVhM9ndz3Liwp7CLbJKkmxpfXz8jIW5+aE2Py5+3GFcji2yEwge8B/2TH2XmH/CkQLGartk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn (10.2.1.104) by
 NT0PR01MB1247.CHNPR01.prod.partner.outlook.cn (10.2.9.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Sun, 4 Jan 2026 17:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8UIM1dPfZAhipWZmtqF/gkG03IxIQq7jNRVNVjGq+iOxLelg5FRUY7UAKr+ayPh1pOKVIKYqbeiZgQBA/oplAa+O0qvyCvctOvvFUXz7rdSnfHPo6OAmJ0LrSiWYJEBOag+wNQryS2N4sNBPtJeWzSGB8Hg7koKPf4sBgX322st1rvG42uFv9KR08ivmVnNWBWHo2IYz2lvw96Zyaig+cisRD+IoJYWBf7OQhnodfNaosPGHndm4FL3tga4zkHZtHvg1NsXHRNdPd8HGAZJuktbI5VzfSpr2C/0O0ins+JImzViBah4rbXovCJlmpkw00VEaud6fMeKLnFP6rtLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zjjWknBnwtbZBaOAljBZO1ek+lyp71QkGXBx9mLrTU=;
 b=naeVGB/YMho2H32yDXq/hi07/CLyGHh8419+Mt5hJwD/Yb5bbyE1Yk7uREE8fSH2hwF4FWJ41/MumKTiJRqrEI9zEncNpGz3lMX38JGlafwoed7vAWelgofNZVSUvVdV/GeYdFORr2uUbxPg94Ui/Gkx+SDK7tvUhvnZJb4e0MOEmwEHG3TQM2h0Hdm8ulsbsWnYFloltTjlJuQdheNr3gzPnXGl4IVnZfhDHIavtWLh8CdSLVTKZCVpCwsOcs06aZWSLwVK4lP3tP16skfK+39jpDsAFIUsb2K/k2rTSrUMwO96+bJe/52PN81LemKfdmG7hmKyUp4OeJPakizXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Sun, 4 Jan
 2026 06:25:57 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Sun, 4 Jan 2026
 06:25:57 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Greg KH <greg@kroah.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist" has
 been added to the 6.18-stable tree
Thread-Topic: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist"
 has been added to the 6.18-stable tree
Thread-Index: AQHccONOvAffeaL2GUGphLISAHqLn7Us5z1QgAvoxQCACNFU0A==
Date: Sun, 4 Jan 2026 06:25:56 +0000
Message-ID:
 <ZQ2PR01MB13070AEE145A353E886D7741E6B92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251219123039.977903-1-sashal@kernel.org>
 <ZQ2PR01MB1307AE907F8899DA89F1085CE6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <2025122908-skinning-mortuary-89c7@gregkh>
In-Reply-To: <2025122908-skinning-mortuary-89c7@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_|NT0PR01MB1247:EE_
x-ms-office365-filtering-correlation-id: b0f29614-e0d4-4185-ba86-08de4b5a1ed1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700021;
x-microsoft-antispam-message-info:
 jC70UmX6ljU7Ei7qMcgXr/vxN/h2gT2IuzOlQNgXlb+fiW9Sa/5ITRwDxvbGOp9GAmRFm2LgQf/n1bGOTS5PhKH9OxHngWxNjqc9WxgkvyTJ9c62lN9a163LYVUHXulD5FxBVC3AQAtzRn4VArZBOGTAEq+1AbnYKwCWZLH5q9iRH6up9OfvdCFbpGhHknu+DW12ujzRzOED1xtnl44HGJ1Qf4q4N1qQfSeHj0TJMMcOC73MK3vTvPhNOGfy/uhq/5j3RbxPXzbF/pYJ+oYqAme4Z8fODD/Z2//eMgdpSScjEf7vERdP0t74ihzP7EJKklD8BrDohlrkjBRNAGr2mLWKCoqwcxO6rHH1j3x6WtHkeTbA/3/6pE9DzF9HzctBMigc42DY6gYQG6QzquRMKeFE4lP7df8MC/J7E5K6peslyZGYDBCu/N8tczBwOfRcpwLoEYToeRITR5SAdWKlKqezWkv7PHG4dZwysV1n82N5PGpHvbdyoUk4VXxDoiqxV5x1pbEdTSPZ42bmJKZOSaSwA8qTzLpZVtyAIDxu/2v+2dcDwm7h1dXyKHwCBno5ORvwuYPZIvD2EvUvLXTpG9F82aeD1ptM6MVqnjK6bu0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?89d8+0YaQsOsli6pfyf42y5EQgHaSTAWl7rH08tlgW88KLap7Mzv/P9YGTET?=
 =?us-ascii?Q?00LUUuE6vjxRokSj/n8D+UTIweor7DIf6iASu/8KoDU9AIgKGV0OMurx/ACi?=
 =?us-ascii?Q?9SMZ5+wpEKv4WeMRPkP667dALWYv8Lruip6LhpWhO4AbwfSiqTK5dEcCV5mr?=
 =?us-ascii?Q?ZSFOWals11ECMf+xnHIyU1qI+MZ7QDZDqf7pUhucrGMIk7QhsYU94CH4uY3y?=
 =?us-ascii?Q?p7h2uTQEvRezi0Mb6jxH8h4ov/DDCVjb2QfNIQEklKCQaVmdfw+KIiNa++lv?=
 =?us-ascii?Q?3c6wLKDj/ySmDObm5Kp1dIOMEwy81ODYwO90W99Ob+yptbXO2WDUB+/T9DXm?=
 =?us-ascii?Q?ZPnofCTzP5f/qrszFYjKFzLRWjGYn/Ok6bfoZ6tDYczNqFjZt50K62+v1FBd?=
 =?us-ascii?Q?WU/NrcU2Rbm0Tmu/zXu1/3EKV6QHmAyvNoxge4itheBPw0f4AL4Cqk4nFSGt?=
 =?us-ascii?Q?s4Jadl55aAvbmuMKjdlEMwsgvfXRg8UM8ffWTs5gOKgWOLPG900pMU7IWdSF?=
 =?us-ascii?Q?F7MjemK53chS2V9X+BOHPk2uZVT/R+xymg7ULZ6iPGUNlYcDmM1j6isd5bHz?=
 =?us-ascii?Q?B8ppyoUpgxkm74FpLVqs3ANzp3iTLqoLFf3swOAOG3Y0eV+hxZyZ2eRce35R?=
 =?us-ascii?Q?//dQz9uuFAfIyQyBc2Cm6XMSUWiOp7JRsDmGxI0pWdEGQSuR6USBlk9PMiLf?=
 =?us-ascii?Q?w1IspucMsrYYdOs/djpjCOH9qfLuERrwOvmlWWLh3tRPeFuDG17zZS2nfYeC?=
 =?us-ascii?Q?ZhQRqZp2R7oLipaJVCmpN72OsCROdAMLoU/tfuVYCYrVb5gWZ23pyM1U0Nmb?=
 =?us-ascii?Q?KtxOQi/s4qgRgPJzByX4MmAuuKnLn43k2t1ysPiac151EuyjZd+HDETJMBeJ?=
 =?us-ascii?Q?1E69Ztgt1HCIkCBFyiJC4x6v7X2kdfGe+6Q94QnfdF24A/DbyiEeDeAZp74j?=
 =?us-ascii?Q?9RL++6aCNULZt3DPlJ4V4iTa4I0DYj+H73rQCIW3X4me12WSqKr2JeOGFRnf?=
 =?us-ascii?Q?NXRciHax8j+ywBfy6XeMiJOwcSpMPqtOpmYxCx6D0bKZQOPCrWJc0aF9MHIZ?=
 =?us-ascii?Q?BEvKqNpEEQro4eiodn3dz+q+BWIhmpV9imQoDhu/5QwfSzJeNxPNiPGqur80?=
 =?us-ascii?Q?O4jOq4zPyOGl0juDj6tYdhvnn0sbWHca9quwDjqkopCqZeBNs+ONXNT9q5Kn?=
 =?us-ascii?Q?8cqCYYdB7Qnw+ulMT2+Bi9EeuMUV4vpsKyqMeqsV2VrPNyU/LlxLteLZfaHS?=
 =?us-ascii?Q?zVh1d0fzfpk+EWfGOEpBM8RlStgA4hDQux7fMePmijA+plOA8mXoSopMJ7xm?=
 =?us-ascii?Q?rN/MWn139qgiAWgzy1Ma9cfZIJew7z4Ftla/eWhzvbjoNCtRJ3J+dmVyfjWc?=
 =?us-ascii?Q?uE5jebRTbQQLEadzAjprsut9W6XQlR/m3vdH9mTI8Cn4m3+gHgli1u5ozwSE?=
 =?us-ascii?Q?yng+sd9zEmu6qbCsRrbe/opw1YgFUA/M5d4njF5tEumkTnBe8Dpw7Q6FFSfz?=
 =?us-ascii?Q?/TgxV7PGgWwlaOjcWyEhtZozafcSaU5RKOLz4mFL/zAb6uWghTUQL1HE72Ui?=
 =?us-ascii?Q?b3piegoZM6XwRIApeZtJ3VJ++82NMKNzsL5G+FSR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f29614-e0d4-4185-ba86-08de4b5a1ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2026 06:25:56.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk0rtRC44s/f55vxpOPxjfDtLzks79uIMx6fMsygtfmO3Nh3M5oe3OPWAUVPC/2Tide3iZEFyI9nSt4kVLludhR7lrKb999glNls/jN9cmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-OriginatorOrg: starfivetech.com

> On 29.12.25 23:36, Greg KH wrote:
> On Mon, Dec 22, 2025 at 01:54:03AM +0000, Hal Feng wrote:
> > > On 19.12.25 20:31, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
> > >
> > > to the 6.18-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> > > queue.git;a=3Dsummary
> > >
> > > The filename of the patch is:
> > >      cpufreq-dt-platdev-add-jh7110s-soc-to-the-allowlist.patch
> > > and it can be found in the queue-6.18 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable
> > > tree, please let <stable@vger.kernel.org> know about it.
> >
> > As series [1] is accepted, this patch will be not needed and will be re=
verted in
> the mainline.
> >
> > [1]
> > https://lore.kernel.org/all/20251212211934.135602-1-e@freeshell.de/
> >
> > So we should not add it to the stable tree. Thanks.
>=20
> Why can't we take the commit that also landed in mainline for this too?
> What is that git id?

Those commits are applied to the riscv-dt-for-next branch [1], but not land=
ed in the mainline yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=
=3Driscv-dt-for-next

The commit IDs in riscv-dt-for-next branch are
d2091990c5c1
7c9a5fd6bb19
4297ddbf1d14

Best regards,
Hal

