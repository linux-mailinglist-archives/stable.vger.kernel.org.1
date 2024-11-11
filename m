Return-Path: <stable+bounces-92089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508A9C3CDE
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F066EB20F90
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F018A93E;
	Mon, 11 Nov 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FuRxsDu0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12923189BBF;
	Mon, 11 Nov 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323918; cv=fail; b=h0ObyHz894X53LTgadxbiAbQDBtNIjEH/TZC77YOGpDoVdz7DsfCSKSk2GKUZJgXOu2Z7Dps/0CCXnbIqttiZ5/Y5E3MdPYKZHMAdORwFWYEdvKaKATXy4OZmMsmJQ8Fp5IvMtTl6+PjFZN/oddRhQvS/cMGs/4bhNDrCX+xIGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323918; c=relaxed/simple;
	bh=Mo8gCqDgTCidg3OvulvBxaYF3HO/QmAteNU/fGBaWvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/0fBwDSZhbouVDAcmHcPrrv6mpHQMbSkvbYUstmmIqIzOkUCbUKlMvCVLa4Imgo/Rg8c76hPFEcGGDEAkpsMC4/GxbWN0SrqW976F5AEDrTuBsSulpF35wesKfdhYrsE4pMeQB5dn4b2GeV6rwolYDYevzkUsbGwbCkOEjiZsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FuRxsDu0; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTm0Pvy9SeWPpQuaQzqZHl4cFbJlVznNeV0/HTvQ6OZqGA9+c1+xfvvIyTqdn76W0Y9QSaJ/0yN4k5+BRkEQF8AJaCzpJQmE3AxxYdIzCKGPKPC3L9fhcPSTMcGR1pq4p5+JrjmFS7I5UFZ95tpabrzisnRg/uZ9vZkTPvH3D89qw96miOXj8p914CKEsqsRb6U50yb3RAi7eIXUiuSRiniGcMASxHb8SdwTEVrP5kv1T+LCna2rXxeFk+gY7k5YnBYwfXQCkCmJMkYUSHVL++qTPs6vadStaGF7nni8rACbUSfFGUcQGnhiCoI3WVkLBNWTOBuWUiDfht9Euv2iOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo8gCqDgTCidg3OvulvBxaYF3HO/QmAteNU/fGBaWvM=;
 b=FNJVlhGWgcDiPXwqEmaE80EAPhBGoEWgYneyVPgEG5Y3/+R2Ah7ugm6TORkjuE7F3wuwyK1lXbwSAbjAU4+/a28Fsn2Ebb3SEjBd7kkBXEvuA+MPu34oA0f7EfFIfYHNgQQssasp9s8jyV2H5D4osbvPzyIGbm4egRCnco6R6wJDJ5lmsqr6lM4VA7zzAgWmbzd9jDPncCUSfp1kINdcCL3mBNmzykH8OugqG1DY3Vngund5YQlmhFiIdyDR6CFttDfV6izblFLRutaxKMEMvVhJWKkU4GrYBPOqmGRil9RIfGTRXljM5sQvJkHx3DQ/5otOSr6LK1HM+3i8XDrJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo8gCqDgTCidg3OvulvBxaYF3HO/QmAteNU/fGBaWvM=;
 b=FuRxsDu0/muHB257NKwZG/7uOAMQGC8wjMQZPQstBQS/wgZ0A5FqJSArAopGWZOaziTYln9QoZqeJLOLRKWy/zGgO6ZinAmvEhQy1JJj0bXTUcJHfCBcVINj82uDgeH2vcKKNMHx7HENebnPa0NSBqKwG6JMYazTxuZ7NpXUdus=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 11:18:34 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:18:33 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>, "Gupta, Nipun" <Nipun.Gupta@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] cdx: Fix atomicity violation in cdx_bus_match() and
 cdx_probe()
Thread-Topic: [PATCH] cdx: Fix atomicity violation in cdx_bus_match() and
 cdx_probe()
Thread-Index: AQHbITYXuOq1d8IfhE6O/bT8aIp2cbKyE7pw
Date: Mon, 11 Nov 2024 11:18:33 +0000
Message-ID:
 <BL1PR12MB53333B4078E3C1C1AEC49AD99D582@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20241018081636.1379390-1-chenqiuji666@gmail.com>
In-Reply-To: <20241018081636.1379390-1-chenqiuji666@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=9b645f08-bd92-4df9-9200-1d80af56f3df;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2024-11-11T11:16:08Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|SN7PR12MB8104:EE_
x-ms-office365-filtering-correlation-id: b1a2fca7-28ef-4f93-e202-08dd02429460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iyOP0odKoUilcmzrv4dEhrCfYjatUnjDSoh3wCArLunCX/JByz9HC62P/EDu?=
 =?us-ascii?Q?bLayWD5SQ6lAQofKv3eX6kubjo6m7e2pkw8MZXrcv0xQnK3Wa3EwaH7sSTyN?=
 =?us-ascii?Q?p8v8P4I67h/wnLZzHp1wStdjRCuahNyrsFz+62DPW7i9z3rT0SmosIviAZ81?=
 =?us-ascii?Q?nqHTl/0RBstTd31plyZBMmmAsGoR92+tmStgjwEqAf9Y0JtuPsP9DcBPHf26?=
 =?us-ascii?Q?HhfZrykFs/Q+AWXUpKLWhnR8sjF98A6q1kMg6YfugUvwMQRe9JBCGLbhROl3?=
 =?us-ascii?Q?hll4v5KjNvpIK+dJ/8m/ocYfJYOsP622nl8NRgRqIS2CyTNXNzQYPp0hJf15?=
 =?us-ascii?Q?B2qyb9ofTkuxA6PkM/ddsrq9gXXJd6nr9xQeKctfTO7DLYV+tsgK61/Pws4x?=
 =?us-ascii?Q?k4TILehG6aGW4oQeEPkIIum5bg26cCAUgmJ7/0QjebKKBwiUtKM5pSdnFgGE?=
 =?us-ascii?Q?nQxsVZOtKCO6WJTWNxjGsm6IfifjO8yv2mHf/qglcnrOkpCP5zcnd0oxMmRL?=
 =?us-ascii?Q?DkD7pMZWZ1yNZaZyGr43grBt4sCthtgbBOkuCC83M/nLk7bDf+Hwx7qNprX1?=
 =?us-ascii?Q?uS0nX7zMs4Zq7zTgZA7uO+LDD6Cb8+6hkuJuHkq1d7nILvZ09xEr2qoiuHZB?=
 =?us-ascii?Q?4N6QVAmDx7XQ09zqg8Zm7WjQozPB9D2aFAv10xqt6Shlo5uWpUUjLZzRdwz+?=
 =?us-ascii?Q?IEojRPKPaHZ0YN+op/44rxu6G/QVRM8soo6JmNhiZ8o7EHLQ349GfOfrWSdF?=
 =?us-ascii?Q?96TVFfzBRE+19tWlxEMNeItXknyyDXI6MvBYq+PzR/pCtGTWni5nksCvPnYU?=
 =?us-ascii?Q?WTKEp2hvHgaatSj4GnZYKg9gBtSyMUY9bp2vf5FlxCQ88OhaCaPk3GzUpVyZ?=
 =?us-ascii?Q?tFkg8+XjJUAjvINdjQHN8zwqzAK7EYRg7f2Ui3w4nUCiPCS8+p97Uaswe7Lv?=
 =?us-ascii?Q?dGRbJqD9xtoZPk3DTgLCPjSmeKCvjuywwowq7VxlBqYmdg2CM4atQilf1rlF?=
 =?us-ascii?Q?8C+DTkUGc3cbhYYgJ5mSTTuR+rn/EbB/7ee4V/oBdPOYnihZelnXX+yguiel?=
 =?us-ascii?Q?K6XmQCliwRB3c74/hf60RxbeKcyHYl5+B+oVrifwPImlLc49r8FnY/ewZk+T?=
 =?us-ascii?Q?a7qSnM6XvtK7XNI0picsG6XYnXQtyd8GRKoiXxjiOU2BnI+2+hW5PFrac6R+?=
 =?us-ascii?Q?ZS5Dx9oTvJR7CLKgsktxpVdn4n/J6bFbe1OjXvhlpFjoM8dwiF9xWmHvkqHV?=
 =?us-ascii?Q?3M+xDLX2E8dkvP7i59eayjEeJi6OGY1SJ2lOCctkrg6kjBFMi7wVNuNHk+7v?=
 =?us-ascii?Q?XNEbo/O6gTSlZ+rajAcsvjJ2hRkEG08fvpPt/xRhsAZMw5y2J/++Edkiy8+F?=
 =?us-ascii?Q?prV2tJU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FjU8K4SPVv6i/78sBCVQK98H+Yv/vK31alfdpHfPm6v+62jmLrJIYXphWLny?=
 =?us-ascii?Q?qf2ref+jDJejOlE8xBodgeOmOcrySJ0ADrIldH+6qiRCBRBoIvLuKXlVQ8dQ?=
 =?us-ascii?Q?cXzRHjURmd6PBu8DqPWLhlqr8cAjCS/DLrD0XbhVI8scMO7L/U7TWE5cUZbm?=
 =?us-ascii?Q?wSEWedorUbUFDbM2Q7DayFCveZuE6wZFEVr2qhvTU6p1VnvqT+HSmYuiIpPE?=
 =?us-ascii?Q?UWWRa6jZy5JT8nojsLTyWyI4Dx9Zfx5EVjtX7hG8O7jW/U9BbTxtqIjyq6Hl?=
 =?us-ascii?Q?mc1QybZvYNxHdbaD7MR29SoLNCLeEPHOtd2t3BfWrFomQ1He4BwKdScC0v1o?=
 =?us-ascii?Q?qjof61fdtjJy5s1uiJihS+c29WcUvxim2XEQNvugpaMdkVictnNNse153TNb?=
 =?us-ascii?Q?56mBTnxfhMDwxp7IwslQcceFcFHcK5z0qst/TYOpYdlTZlVqG86C1AnLPoQd?=
 =?us-ascii?Q?9X6ghtIvosTdUmZBd+j1VXCTZ5qCGKM7jvLH4O4BQtDEx4F/vJ1gPHkjvcvL?=
 =?us-ascii?Q?lUZMBtzbnU1V5FZpQ7XOM+A4o8N64PhssyCclu/1HzGAzD7S6X5Fr/d/Gw4s?=
 =?us-ascii?Q?cgBTiH3i1LALQhi+Z06bxzKLEWzcdFRp4W7kxOnvicUHUC3rqK3q6Ff62vZs?=
 =?us-ascii?Q?+2QNYNiH8wUrliJYktIULxgN179oEZ/QA9IwC3IiPdFrKqDGhewpXkLKatg4?=
 =?us-ascii?Q?ITX0uustq4NqaM/uHI4jSKCcHbz4QoG/as5b937XW3Tvg+QZfuM7cg3jWFUo?=
 =?us-ascii?Q?iELJBe/3HUP8W8xHSDvJwnQkUdLeSVD/gomRq6B8ruuHzszb9D2m9gWejx5R?=
 =?us-ascii?Q?WRyNDg25GbPGMyE+XHDiJ1FGOl2ZKyaWGf7lyYjwAa7vs9CesWHZI8XCX63H?=
 =?us-ascii?Q?9gulaunQRKDbnbKoqyO7Wf5rS7oCkzRU9LXV6btrJcRwJ/mfeNR37XnoyGA6?=
 =?us-ascii?Q?OK5QjGeI5h9nUVjCdqvy3pAdkZ0s938vQgFp20q2PuB7y0Y5c9eCQexAg8iV?=
 =?us-ascii?Q?yeB90F2qMFRv2ADunETUov9ri6LvaZ6IpGVRdOj2e/ScD0AGJofAfIuEUI5C?=
 =?us-ascii?Q?M98Q43qAllbvBoO5LNAgqu06m5sgJjmkjbg1MX0gE9tUuRNeOTPXXHT16/QO?=
 =?us-ascii?Q?h1oMXUhI4nabEhbEtidXLZUcFrK6VHo0/LNk1upqZ2ihb2S3bL3RwWnFMSIQ?=
 =?us-ascii?Q?zXMNcXXbU6bDGAQ/X+UnWDQu1E1s3KeX70zrCmGnnN70/fbpRCKhPgImFomk?=
 =?us-ascii?Q?vqPofI/5vzH+l1kVCGNO3xkavtHnN/jkbSiAxUXuOWb/6b6Dae73a/JkLzq/?=
 =?us-ascii?Q?9ccC6KdjaFt6+BxoMFrv2OXxEv+L/6CKXpsb7B68Jy0GimV7Q2uzpdsn5wvt?=
 =?us-ascii?Q?lcMMhIq+9xFYUQTUDdyf7lMquOU8KVTp6dvUuyxiRopyRBuZDeWgTtVGfbfh?=
 =?us-ascii?Q?kiN6mAfR6+WlbhdHR7P3gVGd0Ny1JEsI/M3tYZuIqf02n4iFxKcH3PFyq0Jm?=
 =?us-ascii?Q?UrzcJZ5yMCRthf2yiUeTuD020EZHvh+Ztky87npw5P3VBY8DDQkFF6h6W0+6?=
 =?us-ascii?Q?QdbIhfIVvfOwGypVbpw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a2fca7-28ef-4f93-e202-08dd02429460
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 11:18:33.6761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmrSNnfc9EG//IMZ85zRHrwiBznPE+uvvcVNbxuTvxp10tWiBviHTsqlJELWoKoH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104


> From: Qiu-ji Chen <chenqiuji666@gmail.com>
>=20
> An atomicity violation occurs during consecutive reads of the variable cd=
x_dev-
> >driver_override. Imagine a scenario: while evaluating the statement if (=
cdx_dev-
> >driver_override && strcmp(cdx_dev->driver_override,
> drv->name)), the value of cdx_dev->driver_override changes, leading to
> drv->an
> inconsistency where the value of cdx_dev->driver_override is the old valu=
e when
> passing the non-null check, but the new value when evaluated by strcmp().=
 This
> causes an inconsistency.
>=20
> The second error occurs during the validation of cdx_dev->driver_override=
.
> The logic of this error is similar to the first one, as the entire proces=
s is not protected
> by a lock, leading to an inconsistency in the values of cdx_dev->driver_o=
verride
> before and after the reads.
>=20
> The third error occurs in driver_override_show() when executing the state=
ment
> return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);.
> Since the string changes byte by byte, it is possible for a partially mod=
ified cdx_dev-
> >driver_override value to be used in this statement, leading to an incorr=
ect return
> value from the program.
>=20
> To fix these issues, for the first and second problems, since we need to =
protect the
> entire process of reading the variable cdx_dev->driver_override with a lo=
ck, we
> introduced a variable ret and an out block. For each branch in this secti=
on, we
> replaced the return statements with assignments to the variable ret, and =
then used a
> goto statement to directly execute the out block, making the code overall=
 more
> concise.
>=20
> For the third problem, we adopted a similar approach to the one used in t=
he
> modalias_show() function, protecting the process of reading cdx_dev-
> >driver_override with a lock, ensuring that the program runs correctly.
>=20
> This possible bug is found by an experimental static analysis tool develo=
ped by our
> team. This tool analyzes the locking APIs to extract function pairs that =
can be
> concurrently executed, and then analyzes the instructions in the paired f=
unctions to
> identify possible concurrency bugs including data races and atomicity vio=
lations.
>=20
> Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
> Fixes: 48a6c7bced2a ("cdx: add device attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Acked-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

