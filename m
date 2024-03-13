Return-Path: <stable+bounces-27596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4A87A944
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F1D1F216E5
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2621F44393;
	Wed, 13 Mar 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ff9QloeW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tbJu80IM"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAE35894;
	Wed, 13 Mar 2024 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339182; cv=fail; b=Po91ELIhtq2AJsaQucHyBB2rflMtCKs+l0FeI3VckMfFysNAf0B/VuPFMD42UJiVDRYkCRFQiuqymAUSwG9qM7hZpPL3jA9wJdBvcdX7qtBG7MMV3Yugwan27qnONb/F/HUEnPa9js7kAEdBSwYy5yByfSRRghJo/1A2PGT4ywU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339182; c=relaxed/simple;
	bh=vbo8IGA7rTvEtgb4gEyEkU2hLJjD5WVL5HxgfIk0OrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVf4urAC7JPB+sCOzYyGncjfR8FM83rAVjtXwzuuaCd8IJJF5GjGCrvUVkdKjEQkMgg1NcD6OgE9mj4qw9BsUAIjQNLzIOHJNoFCI8HjkCiuVqUkhTeGdxywNAZ5D7JgF19i3hAnbJTSb5g8fMRj5AiSd2pXjzNEycR2kDa5F1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ff9QloeW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tbJu80IM; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710339180; x=1741875180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vbo8IGA7rTvEtgb4gEyEkU2hLJjD5WVL5HxgfIk0OrU=;
  b=Ff9QloeWKn+sESiggzVf8Az7A1j8s/Zkc5+OIxmp5xOLktgLKa789a9L
   f1JwQrTsCtXPkJ34MvKvlVoMtHd4huB3Nz4MgMVlfk25PqEsk3lwaBeik
   q2AbK0F8z4YQsJkeNKzYSE4fFhuCbCPHIYMqIKRvZ3lQo7BqmzDD2R2wA
   Yo8ixpQkiIuD60o13e57/nug+mlrvy/5A4eNGQdJXNZodSpRqEQwWAvn2
   AWL+QWG/Zu3ppj7S70XeJpUwSzDiUR/TcvtOpBBTShU+ck4w7DVFcnE/f
   9vAjrj4jYP4aFK+hfiWZAfRqwvhwuzPgO9mHtb9ZQwmp6VtCVRrWx9JHs
   Q==;
X-CSE-ConnectionGUID: afHE6trBSNuNMdmxUGcZrw==
X-CSE-MsgGUID: d9zW2Gh2R2uKSehujbkAyg==
X-IronPort-AV: E=Sophos;i="6.07,122,1708358400"; 
   d="scan'208";a="11496707"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2024 22:12:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUBLkOd2q/S5/c26C/jaTVlbpGgl30uH9xeT3LdZQHTKPfUdEL8mP+7Trgu28p/Dl0G+P7ujOUdP+miH9/vwBbb+6PeQXvADSPuCjTAu0oa7bHl583icerGQ4oaOhe0CJqR1nGvqSl0DbtghNwISqUU52XfnOJQr/n5bb6tjLXgTtT/U3RbcE/QBQIvlZ6rE5TfAbEzb0e9kZBP2W20VMxPcFmjKr/zXDHrxHI/EdXqJrUI7WAat4ynKLwG/FL2a1zPdfGBz0TZZV+6uX+GW02aOQvfSU2KyFkz3HQjMlG7Wx0bCFsIzDWKeGsISYydkun5O2bB8A5rUc5IDmTS5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv/B8lJ3vm8C7+K/96HKgbLWPUXPGuntMEImuWv18mg=;
 b=Ie+ANsCYtWBf7CqcXRihlZQSxZSNod6rkB6QrQvpaAxZHUGdD08kzCxFQRnECsknYRhWlulPhaWEqXtak8ZZzRllSB1LrhtX6T6nTpjC/x45dJeTO86JW292OYBxGqPmnOBWgT87iP6yaJR8QCFtZm+LAufOLk9CE3G/xgsPtp6NCAlpKjprC3kBo1n05/CsXFKvw8ASDUqID7WXuD1uby/k7BPOkh5fH1lf1EfLmvJaX1ow2+jT7xop7ExySHtIwsNuD5UfIV8rBuJRp2VYRnK4Eppii1CVoK0sFelelfKjlE4wrhXD/xB/d5g1xwl9ylE0ZiR1QsbiFBp7DFnPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv/B8lJ3vm8C7+K/96HKgbLWPUXPGuntMEImuWv18mg=;
 b=tbJu80IM6i369DGI6xblyxwJoDAMU9+2om7JhUvMgUxToDZAE1RQjZ97/k+BCzVRHi4F6bGNJc5Bco0xKRAIjLNEti0Of+fyWifA9/0GJLS03omSvsGMJuvfothLbcExt87wQ4FkxL+CXGJulIvecYuhi0RfqLG71V2KzaCgr+w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO1PR04MB8268.namprd04.prod.outlook.com (2603:10b6:303:153::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 14:12:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 14:12:52 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "mikko.rapeli@linaro.org" <mikko.rapeli@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Thread-Topic: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Thread-Index: AQHadU5ngmlO5sEF+0u0J/Wduu7Z57E1tj+A
Date: Wed, 13 Mar 2024 14:12:52 +0000
Message-ID:
 <DM6PR04MB65753CE63956185656CB7580FC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <20240313133744.2405325-2-mikko.rapeli@linaro.org>
In-Reply-To: <20240313133744.2405325-2-mikko.rapeli@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO1PR04MB8268:EE_
x-ms-office365-filtering-correlation-id: 19e701cb-ea97-4edc-9db9-08dc4367abcb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OKh04OLezN6nvLJzXgXLB7DcDT36CNW/CBFDxNsExN/if2vM2ceS0QIkkUZ2fVAD3YGsoTo/n0Wp8T4brqn7BK8ofVaiC9Z4hM9Td5Kxep/zTIy/6QPOA0DWgQCOJ6YztUfEtkq4iINyUhNoUnH4WzxpCQiK0XmF9St9In6ll2RfNQNBa4gO9Nv2pD6OwOreknyV5+XK+Cg1FdgwMqQiX4XqOppRRn4TqLQWU6NuGBYCMoFOimpB1fvxtpF5B01k3olTJCSprew1BoRu4k/grz9YfEKiJaWV57EVCMHQT0kiFDYpJySPIe3ntfX9jw9fimp0SLdxzYEA5rk9SySvLXErsMyTBp9jUseP8j23lwWgNRVj850susMrxoZSr8r5Ylksn1TyA9Ut8+z3G3LYNBfT1kLJpf1x4noumioK8PhpDHB86g1wEJOuMLgjhJ//6brXDKDd3N0cNG+uOYVZ68FtNqLU2xBmP82gvVhR1Kwng9x0PL5v3kNm5ABaxM5mw4aEo/6xgix3SizWFtLvw0hFlO2Atj2bHO6TTn4CyLPtJdHQZvZbsCGLw8vbe5pg/bgrPIJSD81eCucqvpTVzFBQ2C6uzAFKUszw0gIUr5UfQZIY2233qWS/FcxvlKpwnM1w6N+MvfE88HY5/qEmbA5OcRlWJefyLNL6gqaev88=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JEz2eqpIm+bizMapjF7qYNxBQgv57NYZAv4duegR+3AyQdf4F1ZTD/sM9nPm?=
 =?us-ascii?Q?fuZFiMflIQOG0k0n6LhK0mplZIEde18+WSyWgCxEW313mPc/MXn5H4RYxkr8?=
 =?us-ascii?Q?oNOAa1U2dwB/JTlyB5LXQrLmErG5zN3+rz9D8lqKj5S/QwyGMjyXAn1dBfYi?=
 =?us-ascii?Q?W6JYnqHIO4kppceq+hy40NsL1Yv0ckCHZTKkdwCexFpNGwnIlw+ze/9sNUgy?=
 =?us-ascii?Q?sGNkD9YeBiM1wH88eE6WxPcn1ZoXfEekKVDrrY0oXKZZJzOKmMTzPTZaYA8I?=
 =?us-ascii?Q?IfLnjUitD5gNISh0swE0jccr5JwPVztgRS3GQZPomKV8L2Z7X9qPUR1Bx1C9?=
 =?us-ascii?Q?8+VLfzvsFFmI+LQwNd/3gEUnC8Pxp3U1ahwjLD6Kcava7TdK+3DX2DQQk2ie?=
 =?us-ascii?Q?xGhuM/2JakiG914Y4i1xGvEkp8QBHepPrekrdtdXGFz1q/zdxU8GsDFjVbKG?=
 =?us-ascii?Q?nC4bOMuh+mP3KJUQUx3Q1PUHfqlvUIMuku6wT/qwBItCLALLKrVjXstjF4Ei?=
 =?us-ascii?Q?1yF0UX74z9YRDu3f+5xuH8WPbk+uA2vIQT2Qz4nKjUdyS3hHmCbY9baf0CiN?=
 =?us-ascii?Q?dEC3IxUtrZjPYZBnJlbsakrw8bAMrwuUxx5GjetxmcVLyRF01M0cXX8fzJc6?=
 =?us-ascii?Q?iLEylZlbi7tH4rd0LCMhZbmOYJBfcxO0dV6J7OuK+lvBBK1StcnIycDNTnsB?=
 =?us-ascii?Q?KFeapFTch1kn2t5qiMc10dPGb6s+3HfCMFeMDNpA870DRh50uqDOV4N7Ugpl?=
 =?us-ascii?Q?66GIwqQmWIKi4wGCBl2NCRfuSpOZ+b1OQkre0rl9PvKgFbSf0RVd/oX5yAF7?=
 =?us-ascii?Q?bjR2jW0T1fH/5Ue7nuBoqg7Z/n23E4LdIjNvvmZ+XNWOOgeH3uvgV79CC04/?=
 =?us-ascii?Q?pWvY+ueOeXCXsfgJ4m3JJrEWxbnRo7P0QM601vUxyYqAbEWdEKenakWx9Cv/?=
 =?us-ascii?Q?YHd//0WCa2K2dRu1nUj5pt+4crBY4eJUCPNGgInz7B+dcvVZnoC6jS2JCCkM?=
 =?us-ascii?Q?9fxMZHmBQWK1ghYpu9BfF5JgGp4nHsGcH0hlVjvPMnLC4Pzyt7/CBBHA23c2?=
 =?us-ascii?Q?a+Cgu5MCm3G+yrWoev1W3Tzsfm0NGi1wdii/1t2tawgQHqkiOZ8MiwIb2myA?=
 =?us-ascii?Q?vES+PuQspu/qHzNmYtHfC2N2rSHzlhwRxW2co3D7TDS7dfu9azvO9fXismvm?=
 =?us-ascii?Q?5Cet9Mt98NtI0wPUoHziKNF+/L/VlnuNCKsYeHkiJFhnacydo6jj4l4Sbtfd?=
 =?us-ascii?Q?JH1aUnUq11BTFLC6yAXzLUUuRzdwxzuDYBjRFYDG87FVfXZ1CVAz15HjcRGV?=
 =?us-ascii?Q?UfHpM542mQYNOEyYSbxFq/YQEZP/eaP1MwySkCGYg6Xy76mL6fzcRilVYC5E?=
 =?us-ascii?Q?KyLmQ4zaRrqjBihZLAoXSUO59f3EyG13JTFPkesjiuq/AaAQ6BZuQskLxozK?=
 =?us-ascii?Q?74Vf0pOOkuy260Hi417hiaHQ81W8MKb+33SmQ1pGrKe/m97d67KDq8JM3LQC?=
 =?us-ascii?Q?3Vybf0erVK40Aw12WzjfBoJO0xG2Wn5sL2cxo2xbevtPnNyfg6Obx3wMTg+L?=
 =?us-ascii?Q?Lc2i278LXphqz4S9oyoeJfdmnTQtame/eAzpUbHT?=
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
	yqaB8u4qVrwfyEKX/c9wPBTKi3nTLnthJhh1B25fxy5yRMZANuqmlHVjiPchVT+rBeR09F8K0PWPgiCI3Cdw6G1cxeQh8hMTZJ6eOYVHuGU8/dCYkWXGN+jWi3z4rW6UzOcf33ml9bo2MOpIQOmDXwydA67MSwRoUjCMI42NyAMBL8mikBLIne7HD4F0gaMnPuOYkzlyIbriZnj0KyKyKTrzLLf3CbPalAgOoKc8KTs2UGiQINL/hoxqmx3wFMvXDLg9C3Ky1hKW/wa27rdi3jtpsh/2qfDUez+So6eRrQWfCAcsAOmo6wCjPbAXtOzN2v3QjOhpLS8tccfuKtVbFtkBWgAcacDCp1owHt8lrL+S/+j+aCWgoJWchn4dqFIKRber4evV0cl4grqicqUO+pERuF4MV5ffFfX57a7nqkn2TKWt3FsZJOdq0GlbSsiSHojkvs8ZlfxQTraiYz3CqbfvCa8c98cnJw7DcQ8aslcDho6gI2P6rHJeBd/UFid/Yioo5iIeQ68TzeRflSd9l01GYH3rPuLLC9/Mv1PWaso88sORcdqGmhu+evxHYwemKjcrrudAWwS2vICJDsqLhuWiH04jhJMsicEZeGDwcUAbMcpgdjztVRLg5gKLafpo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e701cb-ea97-4edc-9db9-08dc4367abcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:12:52.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAVUpOh6FU/lS/UEp+rjbOC2y0iCtqCYHmNaFFThfNzsnERhmhFp8zojPgE2h7+sLddj7rG2eCgHrCgtVrpdUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8268



> -----Original Message-----
> From: mikko.rapeli@linaro.org <mikko.rapeli@linaro.org>
> Sent: Wednesday, March 13, 2024 3:38 PM
> To: linux-mmc@vger.kernel.org
> Cc: Mikko Rapeli <mikko.rapeli@linaro.org>; Avri Altman
> <Avri.Altman@wdc.com>; Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunte=
r
> <adrian.hunter@intel.com>; stable@vger.kernel.org
> Subject: [PATCH 2/2] mmc core block.c: avoid negative index with array ac=
cess
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t the
> content is safe.
>=20
>=20
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
>=20
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns prev_idata =3D
> idatas[i - 1] but doesn't check that int iterator i is greater than zero.=
 Add the
> check.
I don't think this is even possible given 1/2.

Thanks,
Avri

>=20
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
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
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 0df627de9cee..7f275b4ca9fa 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -488,7 +488,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         if (idata->flags & MMC_BLK_IOC_DROP)
>                 return 0;
>=20
> -       if (idata->flags & MMC_BLK_IOC_SBC)
> +       if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
>                 prev_idata =3D idatas[i - 1];
>=20
>         /*
> --
> 2.34.1


