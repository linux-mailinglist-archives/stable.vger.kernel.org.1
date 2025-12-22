Return-Path: <stable+bounces-203179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD2BCD48BA
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 03:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 111BC3005E9B
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 02:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF7320CCB;
	Mon, 22 Dec 2025 02:09:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04813248F5C;
	Mon, 22 Dec 2025 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766369399; cv=fail; b=qZE5GtdvVHGosg93A/Fe/Feahxb2L8Tyrpw11KzRJ40lXBNbgv5eBVIOfYjNnlK9MdnbyzSt+F7TIkxCkcU8P0o/t6Q4r7/LNlCAcncIJ83lVvcksMIt+fbZynhmlQKJLGijNIn4uVw0FzG1UFmYwDaNDcgyHumblHA2R53YLdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766369399; c=relaxed/simple;
	bh=3C/+vBakEWo+kEGIzjgQYxwfzeJKK8Wai+un8awz60U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YULOBoc4WsVM1ISyud6WX2CoJIXkd7jEY47uNkYMsWsFyFKGH+YBK+SbeyjCSWUlabmPB1E8C13ddekzwksj1TeuQZtuPZ3R+QXlfo1/tCITs4w/ZSe6yRoq67q9hizaN6Hp0PK1raUz5144YWPT054LcGc+Q5cpr9g0iz4dzjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMkI4sQxFJ5jNHLOdYfco7dm3EXP4jBAIH0ZdWA02ol40cKlkxaArCncSDfLlhFQjXmtRijA3ZTOPqr3r9foP9ntxkCabBH4x6AsGMI7gAUFx0pgdMeING6YjbAcdx4Qk2JwS1yJCMo6VBOh4/J1Y+eJ2Mn8HvxfJvdbkJhLp+LknuyEfeUm6lr3srl3eAAf39yBIVj0UJ6BUZeJCrn30xRfJu+YfVxYAk+xQqfd5JouGYoOLzk7XUjgRL5SzHA7nftAIufAsqj1pAjpvg/ai369TX/NXQW3LzObJgC3PF4qS1gbUv9SrNQ8lQcqwpSatc5pa9N8/NDIiyKev84wQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcB5DxmKe9x5pTeERSvLiufAo+ObvitNOTw0oasP028=;
 b=eF23oPB02nzLLUZxUadhefHVZ5qqcxvEKMKEpGy10TOz0ZKyZrXtUiVn+YQbSq3i+yLdeg7M0H7MyionCrzTRJklB6w3zFQz3jSJBhmeR2RBNqyMwd9b7TNcEjsNO2i/z3x0bkyWAGwNo7MAcDgetWSQQl5ELBWhDayDJ+VfskYPB0u9V3YWUhxElr51RJA7xiYw+Jc/5kg3RuxIGD/XVRFqo37WF1HEZXKrkc8aITCUj0UVzZqgg3GUpJy7l8Ya37mNnEKhxWdxwqKsJKykfv/AFDa3gLSo2Fs8wBUbgNdo3oOoETLfw0XTRl6SrmwqdyX5GzKKJOsl25OmR4VBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1212.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 22 Dec
 2025 01:54:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Mon, 22 Dec 2025
 01:54:03 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
Subject: RE: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist" has
 been added to the 6.18-stable tree
Thread-Topic: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist"
 has been added to the 6.18-stable tree
Thread-Index: AQHccONOvAffeaL2GUGphLISAHqLn7Us5z1Q
Date: Mon, 22 Dec 2025 01:54:03 +0000
Message-ID:
 <ZQ2PR01MB1307AE907F8899DA89F1085CE6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251219123039.977903-1-sashal@kernel.org>
In-Reply-To: <20251219123039.977903-1-sashal@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1212:EE_
x-ms-office365-filtering-correlation-id: 606717ee-fb0b-4615-5879-08de40fcfbd9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|38070700021;
x-microsoft-antispam-message-info:
 RsqfOUZUWx9MbhqbnnL8Zb9SUDA5RD0Bdx3fTWUJyFy/LibMkhdzW0hGaPgWLprQlWJFjlJQSV66H6MLB2bWp0wYCSiID9k3TSxFcTX6D8xIQiTBe7OrBWqGuhpkXYmeuvo5EySJnUWAtmO7XpBd0yyp7rKwnIVx3BbWfOkfftJ8+tKOE2eUbZ1JpOzwS8Oh796UOcocdf+RpBKzsn67KlwVXnt6doWkBMTKeuqBScCl/wMwI4N8KRytB2CHl1xCuaAJ2OX4O0npVt7CQYbtauZtlQDiBr0ofv46Wcg96RGj3DPcJYPHh+OdVQnDGTleGvVXH/TT/lO/guw/kJHM/kdVqiF1UOqkD5/qM3DyECn3Poc4IUYd+hFsUP76gFlgNGW5/QP0NW/i5FwIer5ZLmmkOxe/oNtKSoPhORQSUQLI3CW1h+l9VQ5sfGVyR5zPix0yrtmvTjhnLgRG0cmoEh84HsbRxFAwSrlo5Jnu5pVbWezZ1/fQT9hN0IzlSZ2wXDxo9ShFV3HXyLzXIZLCueZw6X/wrv+uEu9QaOh39tJCUnA+mbYH9bUJ8GWhcdW5Am6TmmoGy/9r9xI/oGkqVQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g4cg01CmXV0PxMg5Y44XvsXKM8s1MC4JiRABLuGq6xF4Q70VymGtzzj2eLBt?=
 =?us-ascii?Q?Y0kdtafVaHLueBE9RWEYfmIB95QK9d2TM6mjLCsbmAcn95Se4Aghxb/hJJwk?=
 =?us-ascii?Q?gLKV5svN6zNRuAA9hpTY8iasramjYsrEQXCMreroTxLG5+LSxEX9wJ0Xnih/?=
 =?us-ascii?Q?LqUaOpa9G7p2Q/0FB+x7Gsnz64vjccyniYslsZxZMnp9Lec3R0N/PY/m8B5+?=
 =?us-ascii?Q?GoN3pFQydIzAIHoWAZL23fCF2ECWEx7Sr0DNL/O106kRHZt1UMymLi9X663p?=
 =?us-ascii?Q?I2L2hblee38Mz8MM0vQ+5k9DSGNXb48RZx9EDzKLLW10tooDyUz7u4x0oLMj?=
 =?us-ascii?Q?PhNEmw7Ka1M9psFnpXIBZXgZYWRv+NGK7XjbIXOLn+3K8XG/b7ZJ+iX9oR/j?=
 =?us-ascii?Q?0SOXMXp4GOy5ff2hfWpjPaXe+lsTH/rizFwK0PYBti2Or4PegcJe1jIDnFdZ?=
 =?us-ascii?Q?KCOGDFY6EX2ySEBhTwEMTx2PSvQshbaL520OAdh3LEEBEv1FZGYrw0BpEEFG?=
 =?us-ascii?Q?pStSrCUGpO9NaLBSXI0XkjG75KTNaTPaD3tly6C/HcaSCY1mbNbU2jiTaPVX?=
 =?us-ascii?Q?Z4Z6rhIDP630kIAdEWciTvbk4S8CZtZqvlvJGcBY6GHqtfARmm/uchzKc3+t?=
 =?us-ascii?Q?lGky7G72rIiKON/GOGAAxS3xcxIS1eBBH4J3VObcGJLlybPNDAEYOnCnN3Su?=
 =?us-ascii?Q?kMA6BZZMn034YQa0ybgXk0dOwHQx9yO8bO+U9bUEt08Hhm2Q/yGRDLH5QhxN?=
 =?us-ascii?Q?kr08HTp/WlpPxwUjkcrqejzRwrANnma3LCxVgMBsykoNDzjuz6bAai2T15uo?=
 =?us-ascii?Q?zKNimgCEaIDxAnTOYSJ8gTQuiPd9k+vsga+lYie2hbfamIEGrdOyuKLfn7vj?=
 =?us-ascii?Q?813sy5e7AZDhxyQ0R1aD7Syv0CFw4wpUcnOJEblzfr2j2YBr8uGALLgj9dCh?=
 =?us-ascii?Q?DnHc7gxxysDdJUXD8OAq5U8shmcADLB7MdwAdpW1ZlwiI2FcqmLmtblLh068?=
 =?us-ascii?Q?SanZrdfDkedo8I4RXNYCXSQXn8om55ZT7AiOFup30Yps+k1gfXl6jbeXKomY?=
 =?us-ascii?Q?JUGFaTkIJ0VVxYoSJXkqzPl5f0B4NdXSZLIlNHvL1S4T4Fnebvv1gkS4iYhi?=
 =?us-ascii?Q?kdLUQv4bTBlN2tm4wY1t/FpG6rn2CL69YngSG3KgiWcmgSQMaMAlBrNDDZDz?=
 =?us-ascii?Q?bTe0S0hDIyN1qO76BybcORghIqmh9tyukOtqB1ix1hWmM/hRQvJjtRaJxWsF?=
 =?us-ascii?Q?eUqPxPTM3ZpTOd/C39goFSzC1Gt2GWjKwcV8FrNH7Y+IoY/e5z/ftp1/IXH4?=
 =?us-ascii?Q?DdkCbIyFU63oXzPXky076KKxBiP7FBTSi6KPso0x6FQCWi56EvnosiKkc6QQ?=
 =?us-ascii?Q?Sk4L1pfvR6hs/pTEnZ8cu9WRrOirXOtWPQK30ephu8NxyZowGWKs4z0/6+sZ?=
 =?us-ascii?Q?xfOipkGY00RkrMA1b+qOMI8Expj0W4k21W3MXm1dSkV/AbM1KO6Yeqm250Yi?=
 =?us-ascii?Q?aGCo2yrMx3nOnX3NgAWNcBMTs++gcdtsIo+t3R0YOoa10tr0Oy9ooYbKriYE?=
 =?us-ascii?Q?4pw2uduWx24UI16QkcY71PkexynSptqI/OAwOyit?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 606717ee-fb0b-4615-5879-08de40fcfbd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 01:54:03.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuHlbNwLZthyNq0ed8ZUck0eySSJgaeBJs45eRS8v+doMed8l7/ciVZbPX1GJh6QQFNFoPEDGPF1eP1sFKloF+iJLRGQfJ7FNIP3ZRBTJ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1212

> On 19.12.25 20:31, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
>=20
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> queue.git;a=3Dsummary
>=20
> The filename of the patch is:
>      cpufreq-dt-platdev-add-jh7110s-soc-to-the-allowlist.patch
> and it can be found in the queue-6.18 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree, =
please let
> <stable@vger.kernel.org> know about it.

As series [1] is accepted, this patch will be not needed and will be revert=
ed in the mainline.

[1] https://lore.kernel.org/all/20251212211934.135602-1-e@freeshell.de/

So we should not add it to the stable tree. Thanks.

Best regards,
Hal

>=20
>=20
>=20
> commit f922a9b37397e7db449e3fa61c33c542ad783f87
> Author: Hal Feng <hal.feng@starfivetech.com>
> Date:   Thu Oct 16 16:00:48 2025 +0800
>=20
>     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
>=20
>     [ Upstream commit 6e7970cab51d01b8f7c56f120486c571c22e1b80 ]
>=20
>     Add the compatible strings for supporting the generic
>     cpufreq driver on the StarFive JH7110S SoC.
>=20
>     Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>     Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-
> dt-platdev.c
> index cd1816a12bb99..dc11b62399ad5 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -87,6 +87,7 @@ static const struct of_device_id allowlist[] __initcons=
t =3D {
>  	{ .compatible =3D "st-ericsson,u9540", },
>=20
>  	{ .compatible =3D "starfive,jh7110", },
> +	{ .compatible =3D "starfive,jh7110s", },
>=20
>  	{ .compatible =3D "ti,omap2", },
>  	{ .compatible =3D "ti,omap4", },

