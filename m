Return-Path: <stable+bounces-110101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67C1A18B28
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 05:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19ACD16A316
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 04:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280DA175D50;
	Wed, 22 Jan 2025 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="AwWsiVcS"
X-Original-To: stable@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010066.outbound.protection.outlook.com [52.101.229.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FF1586CF;
	Wed, 22 Jan 2025 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737521983; cv=fail; b=Moa318fbShDWzrLYUvjul0QDBQQIZHKDMBfhrWggPAp3wjr0fVSFeoQV4ylyZkCc7BUf5I0lQGcjW6teuzluvuVnSGHB7SWHrKJogRZWcyox3NqsoPYIbIch4PUu/XrPpZTIJVwa/RalWWBAj4q//Xd/jOtiyuUDY2RpxqE4Tb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737521983; c=relaxed/simple;
	bh=g7dcAt10hEVVDiii51JyP+R8fwpUwjyLSzj/H3MiyS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1QGP4e9avbWYtc24tiCAEYwFpuu0bkhIFbSAIf08Lgsv94rN4ujVZF8+0gdC4oKqU9Dvm3uqXpPh6Axz4oV4Ddu32SqI1BDmbdz1guktl4aZZ7qENLpClWESCMGHtB4JkAhAwOm+qMX2uS7O2HlVopRTT/2M3UO6gw/amzMYo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=AwWsiVcS; arc=fail smtp.client-ip=52.101.229.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbhdH3gDdK15+mw+OWwrvjCG2c0UUFZEBo97BCb3Ng/Foi9K7TXl44v15IByZJOzxDTZB1MnWTg522xuSlAwm/Lcxlar0NUOmqOMDSFT8NaiAX14G4+MS6OQp4jCLgMSY046kK+CKRrPcTz3hygCCaGSB4WgwogKQHy1Afy8UUOYQEXY2JkNyMs/O9nfqFd15KNl53rrAE3Nq7uNmYNqf7d5Z42BdIYbQySgclU/jxYrMUyLl7hog5SgCfdDG0royDPsVVhZxIZW2mtSfrlUrB0eAK1kfYMiNPmu7unOtzI5j/5/06beszpMEiEWaTI2VyUKyVFZM2PJtAtWcFZ4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgSgrdMDWXn2e9wlT+/2rKXnFhBWE/FEPQvkDUkRiQE=;
 b=fnwFxmD8vL8955j8049VioGGjqcWD3fBMced6aORx/aBCeeaNUKF4OmSPzspt7SFiztMMjOZ0lHhj+/BBgA6M5d6Izzk3Sp9xc3E+Cil8a83eKhq1V99PIk8gFAsa9CvM367O2yl9e92fiqNS1Z6hfmWXpMFpoYWGyaI0nd0bvGsoAEufg2oywD8h5S0UBI5Wk0yIZ5FFwzyu8U9CPsU1nUpabzzDtFkFKbmFhvIrv3cieWxdgJ9VToHz2tuuGytpimumC2bmf2i/BAdkb1lpqFC9tDUPaLd71+APS/Jfx3+eG6i+iHPhWfKfWoyStFG+KffqQf6xvVgAzmsEWutCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgSgrdMDWXn2e9wlT+/2rKXnFhBWE/FEPQvkDUkRiQE=;
 b=AwWsiVcSY9ghwRehCnj8tJZjGIePanycphwumx7xowZvyZju0whJ3SipPOpOngRxiA46Z/vAB3Te9CFmWot+NDOa93Kj2Z6n3CSELk7/Z+KtU1sC851kV8qyb37n0x/+TYsugjhfFmYvTXhAchBr8D30cDYRGoLWs23oHyyOljE=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB9974.jpnprd01.prod.outlook.com (2603:1096:400:1ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 04:59:37 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 04:59:37 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: "guoren@kernel.org" <guoren@kernel.org>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "conor@kernel.org" <conor@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Guo Ren
	<guoren@linux.alibaba.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix compiler warning
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix compiler warning
Thread-Index: AQHbbHhsAYO7nWDxh06sryMNzzP9Y7MiOqhA
Date: Wed, 22 Jan 2025 04:59:37 +0000
Message-ID:
 <TYCPR01MB11040EA25C858F700C3AC9694D8E12@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20250122025013.37155-1-guoren@kernel.org>
In-Reply-To: <20250122025013.37155-1-guoren@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB9974:EE_
x-ms-office365-filtering-correlation-id: 654ffd90-55a3-433d-48d6-08dd3aa19258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8MU/N8+zpkAO4zogCbXPA3ctnS1zoS0cU04KJxfLRYqDvoKA/EvjKSU/Vf4d?=
 =?us-ascii?Q?CQDOQ/Oq666E2Sf1vvsnP7quFWERAKMlzIIzdyaxI7BQnLM2hB2jFVRg4WCQ?=
 =?us-ascii?Q?ByOO8wWI3PXfqoCBjqFXPF7dGuHUVqUSBBfNy9fRr5OylS3TOL/bstE0DUdP?=
 =?us-ascii?Q?m5pzQiFw/0poY6bZUHPq39m253D9O6eYpu6i9hvOSkHH1J4tCeaFPflDnOmI?=
 =?us-ascii?Q?ydQeUwiHIjRkdLxKGZib51JDDX8/451tgCpspE9EpEGnwZrkYTdKTQBezll9?=
 =?us-ascii?Q?KWZw5hIIw1C2/ryPQw2O1qRvX5wV3awsNGFQrunwEr72iyNfmu3Rl5vnfkX8?=
 =?us-ascii?Q?WC1h9d7bnb+tGnShDUekl3EQSlQRE9Et/tTv36ja1Lh/dHSsVfCFWavI3fhU?=
 =?us-ascii?Q?ygOZwBwfYOFlZPO+lyFguTAnD3K8++EzZ+orLx2W3NoCTj1C7vGniSdmUNqg?=
 =?us-ascii?Q?9ZE66ZIdTWAKdL8dpcGaUHHL5/a7xKDSAagvw16cE5XtB7I44avFYvGGlESW?=
 =?us-ascii?Q?lJ1/lBPdhBysbiytdsvfuRuXGJTOPXRbzbLZdv3d+y5h/KO4R/E4DbZzKgxT?=
 =?us-ascii?Q?IyOPLe+vacEUfW4GXYf89GnKnRUixc/Fine8qxGo/3Ydwtqz0RwC6elogBYY?=
 =?us-ascii?Q?PfNMPXwKgTfjkTAg9iwGV+lmd2wtbgpRLt8EKzW1xp7sMIGCiQEpwJTr/Xpe?=
 =?us-ascii?Q?7ZHAk5KPjPjvaLJeRD0n61HjxAaSIVh3TM8+PQYXqhLOB0TbtQ63gUcPYSKP?=
 =?us-ascii?Q?iFXzmpDGgnonfhDtLRHmVQpGVhB84ede6skJlioiJx91FuS0UBjhZSuwveZT?=
 =?us-ascii?Q?vCVLmX8XCTSdhSA6xJhSAArUj2FBEbEJOD1BjODwHQoGF2e3vLIZ3CCgRF2h?=
 =?us-ascii?Q?4lYxEEknCcwIno4WPdmh5rYT6jGvMmTZtizYhEKuk/H5BDWXflURGTq/NG/T?=
 =?us-ascii?Q?Jf9/y4cxIdDPB1W1ndJaGu/1pXcziDbtg9roz0siRmnxiiuKf1wfupVzYfM6?=
 =?us-ascii?Q?yru8V2jSwe1jEaLyNGffCLah+c++oleFNJQMlSlJcLAasSThazaOqgZyK20p?=
 =?us-ascii?Q?8qvcBGsHsC6CDHf4IhaL7fVFqExTvLqloH/+LZhrVOYsul9eoaQnSkPw3xAc?=
 =?us-ascii?Q?jg9WljD3cwdfQx8nek+zeRl5ycniRqjdkD7ePK2eQ7Ui+W4St4BdzKTMBxr5?=
 =?us-ascii?Q?UYuk2nrUMexzgAK7IcEVdjRNFr6oIsUYgzp6gTe0VTzIZbVs4MQu3gDyP0SK?=
 =?us-ascii?Q?fk97Il+XFE4E85oEIIHt6GJf/TtfWrvhm2cdXRP9r3NILucFvCgHbHPzBGQI?=
 =?us-ascii?Q?+u6PBS7EDWrtTvohVmQRw9Ip3DryMCsBhMglR8A9EpWVPB6pOUje5gM+PGdb?=
 =?us-ascii?Q?Mr5yUD1x4Yg5lCF3mONcrrwOHXpMZGGh9e2dBCXi/R040kgvXLynWPOhaKFw?=
 =?us-ascii?Q?29VrRye+IkGx2/lw2n8IpRzXcbVrVDyV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tPI7/jsEvq56RtEZ426cXSWyzdktCgK7UdXgO68aLTcb+0LK7oL7CbRpyRe5?=
 =?us-ascii?Q?mMeDOBegsTZhgBQBzJGNY68SINeGsLViSaTfGn53XTqNtC2BbuBVVlHg+nZh?=
 =?us-ascii?Q?0uxTUzYGgNnb8213E2ylt23d1RH1MGb7WsxN0XQbHvGKYQiu3fbxT1huPmHJ?=
 =?us-ascii?Q?JjuXZOkAchCdQcOoEmBhnYlGuEMt7SYTSIoosdk+0bbQVkrR2MIN8zAkz2cU?=
 =?us-ascii?Q?2oNeq/KFRXJ4AbmM4ErOlI1lEcOshLozMZmJVa8vuF4Jn7kzQR5PX3DIRDcV?=
 =?us-ascii?Q?sF9TzBPf083ani17mcLw58k93TjSIHS3mFEZK/VFS2/ON8TJbeIZZudXoPHY?=
 =?us-ascii?Q?7Izy58hQcfT1j1USPWGHB+fs2RVKrf+c2xpf9u4H5OP8ogZ37Bptr78H1H6I?=
 =?us-ascii?Q?pWGhKB0pgWK5K2kpfVNJECyKvaDtQPNyayQsfSUnQSvzZxSZdXHoqVLywgGr?=
 =?us-ascii?Q?p0EnjfhuFod5dEOtrzJAG53JzXqkQAu+WZLJrX4HCR7Jhc4qyKNwpEGqlaVX?=
 =?us-ascii?Q?U5EmgFvqTac91AUBYtKYvX8EC8Rf6/KFsQSeA2WcFhZIXWsdz7Ms5j62rGoU?=
 =?us-ascii?Q?YiEpv4I09pW2mXTD0e1HJjE7Pg5JexSvgFUHYgSRrgrLa53J4mK5x6lfTf+Z?=
 =?us-ascii?Q?yqrV+XwQkpg10UkZSbXuci0ihZg8Kdott7J9QCOyLEFBFi4X8YU1B606T8cT?=
 =?us-ascii?Q?KKg3QypEgJqrQBDK4OQVIb60ssS7owMXXqMikwMgjzGQiNZvgA55emc+URpW?=
 =?us-ascii?Q?mAzLVB8oh+ZkmZricjgcKXO3DPi02edBAaDVxm90HdJw/2KCdBvjMHX+Bj0y?=
 =?us-ascii?Q?Vy2jFNHj5hsA+f2j7nrTW3pzwFawLyd1hoeoXpBgybcY0khXXExO8X7M2an+?=
 =?us-ascii?Q?fQCDgzReN4eBFlQvet2+T9c6i46OolXItG6/+Hr4gsc3rW7952Hq+VyZ4iww?=
 =?us-ascii?Q?imBYNqLqbzydl7oS5QmVIC1z75E7z+aiuLbUrcOJNoKLCD4h4yzEpEfMk+d4?=
 =?us-ascii?Q?JVgk3w4OajAGcmfPayYBBMEOuA8Rp3Ik0ahTHQBN2GI+esbk26qV536et81b?=
 =?us-ascii?Q?xgkd/heb3EW9ZRgCm/REOVG4OUYR85ufmBhuU52j1qy37Vta/f8YvdcftxbB?=
 =?us-ascii?Q?1Dx0Wm+260pWAKMjm4em914iCYCD/MfYIsgoZYiZImzDwFul0m32JxVtnV64?=
 =?us-ascii?Q?/BPmLC3LSy/7KwUWj+wVMblJAR8DBJPm9O2Aas5EMS4FxtrTi0xX/d8+gfTX?=
 =?us-ascii?Q?Fp2A/e/x4d9jKD530xbMgeYI9C450l6FoVtZqJcjblzgz6By44cDdtNH0VQo?=
 =?us-ascii?Q?n3RgovzquI2hW7k2tPCqwySZXJY/w0Klkefh0GTgdodoKqASO66mnD/2LKqa?=
 =?us-ascii?Q?2uD1RBw9maUO20ZTZY6tJ81G2TBN8b3L6mledxb2QUvQe92ZIQgdb/XkMVdT?=
 =?us-ascii?Q?QHwWSYQQ7Jc0eBOvjsQyOMCaguFnAIp76DpwqD26Nunm95Jhde7rWW3/7Xyg?=
 =?us-ascii?Q?SKj+VjuSkh6/z2+8+VMHI8qPPAzU6wsvifvGspDx07zY/Gw6j63J2FlNkHK6?=
 =?us-ascii?Q?I1xDgXHBFqaWWvMu38fl0yG82BCW8LGqsomSaS4/XLzW/wsmQAGA7z4K5wdM?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654ffd90-55a3-433d-48d6-08dd3aa19258
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 04:59:37.5722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5prBATSkVBKLveXF7u+0gwsE3qucgx4ZsqewcxOe65Pdf4fauezXUU5WEFBpnT6wWpNgLEONNkNnXf5d1AFpUa3eyonmE9WQCVAGX61z6rPNaVq/xJ9fQuhwA1O1xlj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9974

Hello,

Thank you for the patch!

> From: guoren@kernel.org, Sent: Wednesday, January 22, 2025 11:50 AM
>=20
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe':
> drivers/usb/gadget/udc/renesas_usb3.c:2638:73: warning: '%d'
> directive output may be truncated writing between 1 and 11 bytes into a
> region of size 6 [-Wformat-truncation=3D]
> 2638 |   snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~     ^~   ^

Just a record. Since the maximum number of ep is up to 16, such an overflow
will not occur actually. Anyway, fixing this compiler warning is good.

> Fixes: 8292493c22c8 ("riscv: Kconfig.socs: Add ARCH_RENESAS kconfig optio=
n")

Please use the following Fixes tag:

Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas US=
B3.0 peripheral controller")

Best regards,
Yoshihiro Shimoda

> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
<snip URL>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/u=
dc/renesas_usb3.c
> index fce5c41d9f29..89b304cf6d03 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -310,7 +310,7 @@ struct renesas_usb3_request {
>  	struct list_head	queue;
>  };
>=20
> -#define USB3_EP_NAME_SIZE	8
> +#define USB3_EP_NAME_SIZE	16
>  struct renesas_usb3_ep {
>  	struct usb_ep ep;
>  	struct renesas_usb3 *usb3;
> --
> 2.40.1
>=20


