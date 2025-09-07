Return-Path: <stable+bounces-178034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C029AB47A6A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6A7AB849
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4A2221294;
	Sun,  7 Sep 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="lfkBUz3Z"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2623A98D
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239858; cv=fail; b=JX6eF4iYRUZFqUs+03MT5QWusdoaBe3JsNpXGWnXHUYuQbfD+MCuAFbONa3Tyf+KuDnexyLQlu7B9OTANG5GfIRPp7u+C/SR/m46x4/hxPe9PZvWD5c0Yz3a33ii1cJHS7uHzJ0yu7H6PNDFljQ6kvtQF4EVTzIawgUnTd0uj2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239858; c=relaxed/simple;
	bh=Vmr7I3hnUkz3/KT8PKnJJmcZEnRncmNcCKUyjkYQZyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yxyh7KxGg5zLRO0Jk6GNsCIYFrnwzIQPq8GfyeHARtEX1UctrajqpemTQzbNDyFI58kGz0fTwgiQrjOXaTUM3a6LLBb6Yw7sAY4DJUUUDFoYPvP7H8+O3/cAxCUoUnhyZzIdovvrNgG24Xw0mYHvUHtcZOOWGnBeGYCe2uihkYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=lfkBUz3Z; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757239857; x=1788775857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vmr7I3hnUkz3/KT8PKnJJmcZEnRncmNcCKUyjkYQZyg=;
  b=lfkBUz3ZvovhvEgqhvaI5/EVNYDzWdocB4QZFQWpdbnYcgLyvDj5xAns
   Qo5g/8GBKLkZWBP9gCBCX5gBCx8+a0eBQM9es3nCxLPQZnb83v7cmO3Sm
   bRjjqHqfLYY9s8DpV+pjBrn7rypS8TGLQEN2Jav2qbmt/FXqHc2zyxn+u
   ZCMaC+UW6bP9jmGPpjxGbTuY6OFITAv+lEs8UoMw0DAPW8mYJ7vLkyrI4
   Us5TiyL2uo7tw0VonAStffMLxBz3EjLUc6KLdi+mm8YmjfBJ5JlQnt4Oj
   mMHbRX8QBRmfCLCulblHHH9imgOVa62a8q3kmcyGZGgeKAtkiv3+ea3+K
   g==;
X-CSE-ConnectionGUID: GofH5qNQR+KD9w9lDmA6Fg==
X-CSE-MsgGUID: ZvLXiR04T5SfY1pyJoab4Q==
Received: from mail-co1nam11on2097.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.97])
  by ob1.hc6817-7.iphmx.com with ESMTP; 07 Sep 2025 03:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZwEHe8VxNFMkOK7LFyqRZAf51dS6sgDtuQ1fQIc2ctzDgsmnWg2kQWuvNy+9vHNRT50i5DwmJ93umVPrx9bwAQDamr7nmyMhSHMzN7k1OVJgHI4JXGkaGzAnlRgBnE266vs1hCq6ZpmYY4R2WXEzcmF2TI5wZsH51eyMQ+YniWFF7BwFiVnSeJIta2PP0BdzgI/fI9dAboeWalbGhUSXL/9MgaBYslI7IjHEvck4toYshbkbCrA8DJu7HDUnPXO3Iq2cqileNEm0RkEW9XSpEvmzySMbFDxV5PzITZu/+9JKxL0AIX6PR2OhTp2Z+K479XmVKH2o1ZDtAEeMFllHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vmr7I3hnUkz3/KT8PKnJJmcZEnRncmNcCKUyjkYQZyg=;
 b=wHMCOO3Yqg8/j7QDnU4tuFhGPGwUQ5nxcOlpYdRyuvoD8332GFgJyKHNTR4wKppf6dxAmqY8pG/QWFonZOe36WratQBI9Nlqpgzf/HZrOGc/RInTKyLwheqwyv9JtWCVVJ83IjljaPA3RbibkZchYU4oVAtd4YM50hS7S9QUJ8qb3D1+YPuHCX70BxqlwRE1ut56Yj7/e8y9nYVGKzHA+ol+7ac3QsBUIUOiDjPcgRb5WY77VtQH2nlFx4shWN7uFd9Yc7CiiNzZJuUuoNSLl+cdRuPZlcKvPnU7O6OpCo1wJgoqL49pwSrmb5QZmXScc0jBF4Cie5uhaw8GSuwPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CYYPR16MB5505.namprd16.prod.outlook.com (2603:10b6:930:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 10:10:45 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 10:10:45 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Emanuele Ghidoli
	<ghidoliemanuele@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>, Jonathan Bell <jonathan@raspberrypi.com>,
	Keita Aihara <keita.aihara@sony.com>, Dragan Simic <dsimic@manjaro.org>, Avri
 Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v1 0/1] mmc: core: apply SD quirks earlier during probe on
 5.15 stable kernel
Thread-Topic: [PATCH v1 0/1] mmc: core: apply SD quirks earlier during probe
 on 5.15 stable kernel
Thread-Index: AQHcHlZWa8U3rh7ATE+Zrr8dVIH7SbSHYbmAgAAfdwA=
Date: Sun, 7 Sep 2025 10:10:45 +0000
Message-ID:
 <PH7PR16MB6196BFF6E0579F18B89BEEF1E50DA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
 <2025090729-canned-unbent-1f91@gregkh>
In-Reply-To: <2025090729-canned-unbent-1f91@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CYYPR16MB5505:EE_
x-ms-office365-filtering-correlation-id: ddd88d28-c234-439e-dbc0-08ddedf6cf4d
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nL65zusIh1ilu8OBJ5mDH8dywL6NGkuxATYc1nBzT1fO7T2P0y4Hj3AauN8f?=
 =?us-ascii?Q?ruzfCghwM4izrta9BYj3raDDCvfe09ZEzlqEq4CVgFNK/36p3hzcI0cnErkR?=
 =?us-ascii?Q?+ii2x5FM+vkOxaxaCNE575z0g0ZKMv2mPuqsz3Nfj9/3lBoUftsWT4YDm15Z?=
 =?us-ascii?Q?Ag82T7LC/poLfGeWMeVnHIPuLWiFlyNLTfsv9rKQcsueBWAts3Sln8/qC2Na?=
 =?us-ascii?Q?axqJcZWafq3eY1vNLdbgsrb+NqheQdTlHwu+8icdLY4s3yOD71ouDwOUHWWJ?=
 =?us-ascii?Q?AjaRIB9bRskJ3ebXD9vHsIAqax5uVRe1G/UQ7U5DlnnYtUPTZ9Qos7kgQKJq?=
 =?us-ascii?Q?k29PP9f4SMjdrDiO97k8Y2qWKdrDztK588rSI9Jvb+guJFrgNZR3CG8zKF0Q?=
 =?us-ascii?Q?G87eYhPumAGyOGvpeeJ6ZxiCy+ZuQNb+AazNjspsgkfghvaNKuno+4pwLiRS?=
 =?us-ascii?Q?s22DMK7rROTL75nmaGOOHL30ecTvJbD2s+LZ8c6sL7Wg9DrGSQKRqFfdCpST?=
 =?us-ascii?Q?p0xuBMNob1kYYqrk9WZsB0BbUo2BgreGT+/o4wQW9neYqGaXd+SYqLew5uK/?=
 =?us-ascii?Q?UNu9E7WKcWz9A3DJqxOotrlcyUuzjAcxPStdW/5UV/2g2U8tgbc+2rmKMVkE?=
 =?us-ascii?Q?KzaO5YT95YxKImvMZpdJzicG33Z6bYEsf1qmFMd0CXxgLxBtI6Prga7WjtGJ?=
 =?us-ascii?Q?00Rfw4jxteoogF/qvQ/Lm1kpNhXJm+uy+uRm+PBZcbzqvQCc6HTaV4TQ/z/G?=
 =?us-ascii?Q?5E4aZxtzAFhDdWrWmo2ljcSK865RUoGB0TBynrAp4lKM73HfeDElDUohfLLL?=
 =?us-ascii?Q?jUI9H9X4g8oyjeHZamph3dWh3nhvMv9hHEOjExZAso9Fi/R4jrMNTvs4eQgv?=
 =?us-ascii?Q?RLhpfl1Pvf4ZRyA7+gtCCKYC7jjn4BP0JNSlwVTe7pO66yxkS4w8DSEFEUgi?=
 =?us-ascii?Q?3LF7OMjv0Nc6ugt7M76kUicdjTxQPO6XrH9EBU4qcuBS5KW9DfPvRA+Yq3fi?=
 =?us-ascii?Q?l9TkcjoZO7IeQuC+0WTaiCyBT3ASim0KZ/G47SORaX6r9c9mTYwkJOAWHKD3?=
 =?us-ascii?Q?asqgHhzgDAqyfs6G2dDDDm2XSJrxadZ6uM8EqwRXICQbxGi1Pw3mgLPzxKGy?=
 =?us-ascii?Q?mwmkGY8GKXSyuTOTab6ZRxnHYWVfUc8dZvrtvl/pjjiY4246fLlfowXfnjzW?=
 =?us-ascii?Q?wr3Kq66wJ8YzhcesCMJplSBPTSvqyzCPOdVW4BHbpai41xExhuHR20/wQRAB?=
 =?us-ascii?Q?zGGCArEZXA+gsPN9XwUTMH0Rsz28WcZKMSagv5WtIlXEVMvEtFvEZQDEUuiL?=
 =?us-ascii?Q?KmeYiLGwaHNjJmWp3wv2I398AHnsmk26r+cnK/henLDXlw+ZJBXuy7v8QDcK?=
 =?us-ascii?Q?qhTJmDPDkfWWQZGKd56RWrNM+pljoMPndakZbBEKJizc03HkekyCIdd1Vg40?=
 =?us-ascii?Q?K7o1x/2ffkXYpD9Bni0vwJMf/XV7xrTN60ZNQdJISfC4YIgk4dg2gw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OYRZqT1EhmleawkaunaXN9FxIZGC5ylnggug846pyp7cD1T7sHTnQ6B5AscL?=
 =?us-ascii?Q?2bNIA/Bx9sGq6zAhFFjHvyL95o3gP0/sd+lxjGkAaJeFhVxAlo982VWIzV72?=
 =?us-ascii?Q?L/r/Guxe5QT9PaGHhecVwyr0WuHm7pOgebCe4I0ApG1o3WX/mRuB1a2rWWKI?=
 =?us-ascii?Q?CFa0sUZ6Gco6ag6k0vr//+NSgubGFmSHMpR/jn6TSCGtj1pMVkKKUfjZ/msq?=
 =?us-ascii?Q?T3BSCEtv/0hJjhgmrD2Upn/Ob9thLLGrp4Nfv4acO/8AG8QQCnyVxy+6rb5S?=
 =?us-ascii?Q?bWrgMhrc4KMuxmIGPX2pPLOUvd+bv8lsxH+emoUu9TQbGL16jv2pHkaQxFH8?=
 =?us-ascii?Q?hSQvXuosaEupQSkiq4eAR8dkBNJjM/YGynaYZnmLE01ny9NK8TuBE+3MhPiJ?=
 =?us-ascii?Q?1Vbbibj7BW9y3TLxgh0pAkAMYsjQm0jbiw6CmtUboTRmuKul1yMaD90FZR8H?=
 =?us-ascii?Q?eM2w9i7ouuqFpcRPzU82uSKF3KmcasrByT5rPRnR2hm29TtXOn2tB9GhIS0v?=
 =?us-ascii?Q?4BBTadrtdnMEz2reS7appSy0e7JFNe+PeJnf2NFuxAROytsL8VcBlMStLFC5?=
 =?us-ascii?Q?TtH+jKVegQNsdpfLYr7W8WfmZg3MM7dJEqf20MPMvO4PlmFXd4Jkpo+pFCKj?=
 =?us-ascii?Q?tEw6nH3lRNeNQso5O2FoMcKDwOmWzDhhPCzPct1NlU3LP7x0JolgcIxLFT5G?=
 =?us-ascii?Q?NXkWWD3RZYy3JA8KVlNnOAsutAng5y1BiXB9/7uchU1nnx1XBdgNM6DhHnDJ?=
 =?us-ascii?Q?S8o8UomjMMpoQyn05QmpHAZx6lo9GYWJCQijGnvQ7tIRr5/uVPC4ISPlrh/z?=
 =?us-ascii?Q?EI1IzRHfwqpyZbXSkwKd6XskrP/OaCzLxXeJNuKJHcdpr+msimyUbtk4ZA94?=
 =?us-ascii?Q?XqtHpqvnP9Ihc5v+k+GSzJxm7j4h5ldyXcz0KF3XKOeOTuUKiRk/DBnFoQLI?=
 =?us-ascii?Q?m34zG05rZr74LpaOu21ljeuI24+cEkcJKHlHQVikaEY/PgMuzht7SYlAnGG4?=
 =?us-ascii?Q?RD95GsptSTxx013tN85CJqt3DVU+aXNQ6tHof+M0UXtI0DewqBhgn0S03i6Z?=
 =?us-ascii?Q?2r/3OQexOQopZse0LZpckkC0abqkOH4/w+NXG7Iu6aVTppbH4STwr4n5BdhK?=
 =?us-ascii?Q?gEsvaYEUEN6I79o73EzrKLW64MDqM9l+K2T8iy0dTGZFDlz8pUzBQ27apYmI?=
 =?us-ascii?Q?rkr6C5tX8q3ITD5lhITUAa12SeMrVtdR4sCzCjwBZ9VEFFL5POyqeXWtLWBQ?=
 =?us-ascii?Q?x7PldHmvM0YQ8vtUwEo/aP+e+m6b7SAGkBP8ismovrVEVQqmR2VyR1f931wc?=
 =?us-ascii?Q?vBkhIdFl5qk28vwjqky4MgP54jikrRisJM1k64q6+AYO+t3dymyQ/BDhWsK1?=
 =?us-ascii?Q?DQg3/+uiTN5toDeqHhpUD2LwAeHNq8Y52Hg6Xna0ZVgBen7H9AWZY7VamBc1?=
 =?us-ascii?Q?Fo5ErbfhOJ0XS2hPU5GhlW2vk9zxnzpSS1/JsyHn4drGO3ixa3SCTUD//IVM?=
 =?us-ascii?Q?lcLbP0RcOxV2lMI+kprfcADSKHbICOuf1PSVCL3W6t5uIRM1jucDpsCvDyTV?=
 =?us-ascii?Q?GDIjWX03nBAwhwotU0VlROPxzTlh5hPQna1znv4K?=
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
	6u2yBZM8DP6TkGNQ6d/k1LarRmfc2gqf2bxx5qLwtoFMBVccTGulmviFppkq88qaIGURhogJjG4UJAxHJldIAJC557QPH5WCTgAAaMDsQF4OnKSc+BTNgCYLZ6/M4ERtvVWDdG4ynaHQImxWp+s5WaDN+lg5u3JygY+Y5hrK6pKW9u9rJ8sOD8F6siSuaza67E441DwzHjE9H1HqiBtnyFotGBJ3w90pEMwP0GhZ8btqVajx9Dn5bVZt6jUM/bvKlpQuVRngTlufZWUAtvxwy9BaUXd0Zf7VW+pKEHqQhmO9vBxLCehsxCWnjaHGsFHJKtDFuuob4s6dyvGAKyrjI/G9HUTJTIRzjcD2zZQ3P9Zy2x9DNR2UnluUC9Otx3F6x/YeVrdrrw5wEMYb4nxZL/w5O4r3Rrrn74sMc2stUnqoktkQeFasAER1DinQyU+hUxK3JtdVHSaHoz6pZ0ejG7Ae6+hc4BeXto2iWDqABytoYu4qMknK1qxViWG5ckB4+RBlXa0NDcOCmI5gyL22oB5ET23GjEwTCxp35ivR3N8aFJ4TOAMXEW/SwhrlKBFTYaml8jE53mrsp0m26LcJsrPOcpgPvtyQvqlKBQ8rv8clmj3pXK/0kvgbHvhFV0ObtdFBNWlvEHmiIP5+HjHG2Q==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd88d28-c234-439e-dbc0-08ddedf6cf4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2025 10:10:45.1848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHddc27c4+MPmyluAJCXYmLfkQ/zW3cisXssRd3Rjj6UMrgZndGlOjDRF9m0dY/mZpgByAsNb8E+cw/IHX+FhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR16MB5505

>=20
> On Fri, Sep 05, 2025 at 01:14:28PM +0200, Emanuele Ghidoli wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >
> > Hello,
> >
> > I noticed that commit 1728e17762b9 ("mmc: core: sd: Apply
> > BROKEN_SD_DISCARD quirk earlier") introduces a regression because
> > since it depends on the backport of commit 5c4f3e1f0a2a ("mmc: core:
> apply SD quirks earlier during probe").
> > Without this patch the quirk is not applied at all.
>=20
> That commit id is not a valid one in any tree I can find :(
Strangely enough, looks like that commit already exist in stable:
469e5e471398 mmc: core: apply SD quirks earlier during probe

So what exactly is the issue?

Thanks,
Avri

>=20
> confused,
>=20
> greg k-h

