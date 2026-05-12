Return-Path: <stable+bounces-245407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKK8FkbbAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:48:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB751C237
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D87C6307D72F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020F19DF4F;
	Tue, 12 May 2026 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zq8GpPrq"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AE3672AA;
	Tue, 12 May 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571673; cv=fail; b=O+4qsdK2HtFCE1lUar8EbiUlsvBo3UzqiM7+BEYxy32zgc/u4yyCcyOFrKuC9Rj3QMCjGwZi63s7DOrLBT3utmTVqYyE6hylLNlO4hMXXFWtIuQpA+qoLDPlb/eE31XIz4bii7K655p0IWq2HHALo5Eya53klLeKmnM2FW/4q/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571673; c=relaxed/simple;
	bh=CNk1/VYYXoaZgdP4XycOWkgbriMu5efa6Vh6YxI/agI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hjb0fBpqRy1Z2rKYbF9DRD+GaAhfRgWmLc81yd7JXt20I9C6BtVCr50/iPUO28rahLKrHd/OaGu4AoOvKRSs0Bn+fEyXTAxTIK9Ij9u0qVwAvCsSbXYOzet0NuPFJgJgOdgvI7swLVQyVPmmA+HVRrZNRCJ/RaXu0H2dLAjevCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zq8GpPrq; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUYNdUd/RVQ2PysfT1FApZJAin2DaPTXjSfmmpOWpfNUZtejP5kmvUyDSndqtV6SikCr1bg03/xxEUUrSOkdwApaKM63ZYQP/lijnXGE9zR5cWIcS1c4UWD7y2GKloiBaokE9Z2BJPIPKqO0er/xA9P0yVOeqnO5EtiPAGVNOoe3XmeH5GjV+wMcOIDM+kvUrdg0y9Lboi6ZOWyI1xJx66r5lme6hpoUmN3Dxtdq2gt/pZDGxZ+SLmk7H9ZWQj+JiOYttflJ0vDMW2f2g2b3yl3lC2CqsRYr+AJ/Nprl17qbPqO3wBRK4fVBaUSvuq2KcCAwf09vGstC6PQDbe4JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5reOlBrBteyVoVzr0lZ4JGq3fTTcu8Hy4b+X9bzv8qo=;
 b=rqgJSW7RyUhxJXQ8uy6PJ4GBbhUSEMLA1EvFHnqPmsRkiWf7um5UFsqn8GZiEajuJaZbbwBof4rYndjgh3D0tEq0sSN8nMUNsE991qXFkqxg+gwOCfDkQmr0kieTR28Ap+kxczdsPUuoCnB0Yz0kX61BzrP4zPcWyDR4enTnFplrJ1EQ0aig6t4UL0OBZ2Tm66ySSYMinIeRMD1zP0C++KOY1rJVKFvcYkHXHFUBBqVgINGY7+LJtfRt4sLRdHWe54WwsOUmLvrrxpuFiUDf77i1P40uDMTF67xYY1lIaMNkFXMwr7OY0MB7cSQ9/zKLnuDq/MiXnfN34EXAV2xadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5reOlBrBteyVoVzr0lZ4JGq3fTTcu8Hy4b+X9bzv8qo=;
 b=Zq8GpPrqnUOF8yidCu02FnIQV330BIeYgoJh7ZQDaoBEp9mvpEihPQUmITYS/x05DqCbHKwS+fnD9FoDSRbCHqNUUBNUmr5GLMddhPR/DugLaAf2RnlsJn8TMsmYAu8ioQbRU+avVbL9geXRtk1XKiyAflWdrzYYO83Y142qKPSa8NpZbFHHa7oxtwQLBZjPq6uc/CJ7/RWbWjST79gH8MAOJEBb/y1vpX7oiUgkjJdgOjS5zr2csJSAAQwuU1YkHR7ILbsHtb1wvJax+ckFD++NfJy0dr5UJAwfTu6yyvmxB2SiLSM1OpxMlNIy6i/7YTV7ZZ9orweSbnTwN4EjfA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by DU6PR04MB11159.eurprd04.prod.outlook.com
 (2603:10a6:10:5c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 07:41:02 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:41:02 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset
 for i.MX95
Thread-Topic: [PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset
 for i.MX95
Thread-Index: AQHc4c8Wv56A2tGrxUq9iXBTPnyLs7YKABvQ
Date: Tue, 12 May 2026 07:41:02 +0000
Message-ID:
 <GV2PR04MB120199F3EAA4142DF4533229B8C392@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260512052244.49414-1-hongxing.zhu@nxp.com>
 <20260512052244.49414-2-hongxing.zhu@nxp.com>
In-Reply-To: <20260512052244.49414-2-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|DU6PR04MB11159:EE_
x-ms-office365-filtering-correlation-id: 4423e6e3-d104-49c8-e57c-08deaff9d11e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|3023799003|22082099003|56012099003|11063799003|38070700021|921020|18002099003;
x-microsoft-antispam-message-info:
 07fEPT8AU7kONsxmLPTxq4B+yunpZ3CEjlOLdo08JdGW6RFcbS+/fk7Iz75aWTLsnEphSUs0KCbUPkSSnuegEdaTvciiXjSoD9gYREGs+tnyZ6oK721x2vqrFV8q9KRfK1aum7/gFwbCtlWd1zwwn788jm6TuOCsan4HmVotUKtm16HL0ZYyKPZ5SNcFCNNF1dD8efBr4YxY/fQWTMkRv8lBJoWDxY5p/Ov4Qzgbad6V9GKCEnAo+WnIu/+oBhqxgJHB1tW6cGBH74Y8Cslo4HfY8Rp7p0kiZzgjnN9KVwYzblokOH7JEYUXcuUaUl/qB/g8zNkpYiCc91buN+31bfF2PvanoefuUHRFciNTsRUz9I53ESlnw3NFBas3Lkgj9/Y9uN7IV4eROH2zgZJBTLbnhzeIB9pIp99wvZ4ICcjoSP8Sy0tMt/ASKl1SdRc4ChJbYJeetF9NVwSaSG+zEgLKAyffRYsjQJOwBx6ikrIhnonJUvZ8VjoG6AoHKtfDAHf/XcU0pl5L/KVPYy07VhrEdNPV+w+8SvyhwkCq8g/VeHNHIeFFE521oWKnUHJ5C5kKCMw+GITIfSMSxZq84wglipwRPXM5yuPuqakrHcoHbbJbBf+G5Y3YwpgrtX4qHds1vkt41kIt1tiTPnXoQKMwtqH8LioLgTA/6T9gFRt+PyZHDfZPy0sIUR8xooZdK7QR+u+9vpdz3D2/f1/gogvL1QdspIHR3aURx0aFNGKwz5wHx4byTA9oUDhMk986jL6twUl3ZQA3pXSvzJ6aGw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(3023799003)(22082099003)(56012099003)(11063799003)(38070700021)(921020)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tKeHCDmx3Hg69pbScA6xmYh59aN6poaazAnhLNxZeiJSm0QREyMttaZaOPo5?=
 =?us-ascii?Q?heZlHaMG2QaAkJ3ZqEmJMhRJ5BGI/uvmH8lDysLac1QeyDN8gTO7XaO9ow6T?=
 =?us-ascii?Q?0c3MeMggdwrM42KimxXcsY4q+DOToLRqS4yROO9pW5r16mKUTnP6lTo8g2Kz?=
 =?us-ascii?Q?TkqVs3NOl8xhRoQUzqaqK/aa9wsR1ImDfZlmEa6UJMyv2lOUpz0s6T3pzu41?=
 =?us-ascii?Q?0kkrJPWaLk3YHVV4WQMVMFvJETN73Rf/O+OkRpiEd9ClhJhPFjGMXh2tpJ3c?=
 =?us-ascii?Q?JSSei6g7rLW/s+Y+RDOkt1vdFDT0SvYLcMp1wv1Opw3MNxYJrcimiQxAD5UW?=
 =?us-ascii?Q?8/OWXuv6FxXB0OEkYgeGoG79lAW54we7KSf1p6DEOiXlBEwsD9BElDLtmT/R?=
 =?us-ascii?Q?GHl2g8mf7b7/AdLniFen+PQUNjheKnWSoBZz3V4ZmdcfyT9LAwdpQHizrIAd?=
 =?us-ascii?Q?Brrl9fiyW84sntC1pnoeixYIoCV4mzrY+13JhQMFInp5GjZLdEjRuzADv0Xu?=
 =?us-ascii?Q?QUjpCR42f5aMmmIbOMHMXkfvgxtZwflACfVQOyulKalJ1hKhE+L8QxJ68tw5?=
 =?us-ascii?Q?7QKvfenI8qN5CFwGlARrDUyjS/GOn5CPfuk1Ajbir4jFlL4NSMWLSiDE83LS?=
 =?us-ascii?Q?ueEFDEzyoQb9jwjH9L1xmKb38PlVnQyi2kGIe+xQZT/tVdrgkfUsvhOs+QzY?=
 =?us-ascii?Q?gBAZ9Eg7jKimGvXJKXuvoVKpIXgjOkfgp6kGHgl2rr3BFHWxj3KNUM7ZpSo/?=
 =?us-ascii?Q?s8nXk6ADPnQU/+C6ZIQEtoKd+qvv2SiayMfWMqf2tfwJ775TMQ5AnSqshzx8?=
 =?us-ascii?Q?S2mY9A9FC40dMunYTEkXsMrP3tlpvRny7qsCfrf7E/9/u5k3u+Ku/WcjD+bs?=
 =?us-ascii?Q?tnE/kKNQgvDF8Ih6ULKS3Cpec+u+XTbwKoxUGvyNMu40H4YyVEZPgig4Mr/L?=
 =?us-ascii?Q?RagvGpU1XJusHITSzEjSKiI2jW9bqt0vGKV8FBOxoVBoTPTXrN2WWDnlzdNN?=
 =?us-ascii?Q?FGBItdCf7aytV5Swl973Pm7YeeAfPmi3PtMemLg3rwtHMYihM8LxT9KiIEdk?=
 =?us-ascii?Q?RJVeprr5i91yMqgNce8RVCW3GeYn5Sxpl5AyH5iehPbEilQum5tN/2n14Uyu?=
 =?us-ascii?Q?V2nRNF0h5Ki8V4TOe1CEVJZdGVNDTK1/b+0mD78VHrb1iZgepyEsD5f+bJvL?=
 =?us-ascii?Q?NnIiYOzm8RPxzZjCIbOyQw0dpvRFZ0Xby6K+9z1s6wvYzcUw/gvIVfJ/+2SQ?=
 =?us-ascii?Q?QfNpm8aotGRbYR4zsY9v3IqKkROlERxQ40PwgnhBv0OMyDwy/NUDN3IuLuOi?=
 =?us-ascii?Q?WJLFxs+VmAKo2QLD0fMxzUAwZZDykUdGIjGR9BC4Iu/FQkWq0Z9Jq+5ZJkci?=
 =?us-ascii?Q?+5V0qTVgNEEpWuq4Al76uFkOILepczqskucwO6DGtaGbXX67mtE3ZKYO+twK?=
 =?us-ascii?Q?w5VzA4uxHOMmuMCkTEo7fSMnpbNFZRo7WB5C0h0AkFy+HZ7iUipb8BtCKFbC?=
 =?us-ascii?Q?kGtGFztI3gHvxg4SDVdcYsMXLvsPsrXY65dGWqPqeXuX/4ZcSrB/MFhYf+Aq?=
 =?us-ascii?Q?ONAa12Fo19pdao1dLxQO70VyY920TROemBA/HL4xhJ15GA2gqkACKNdLfWIY?=
 =?us-ascii?Q?hm5fnGyt0/JLUVI+kZIRodgcHq/YPFLTmPPg+rQMSGVc7qw9YlTx+kwIuDtn?=
 =?us-ascii?Q?y20wWla20WALBte6+wo4AKYZ+DOcXHpiN/wq7Ms4Yd5iQlRV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4423e6e3-d104-49c8-e57c-08deaff9d11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 07:41:02.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2l0N6JszseBju28nxk4weVaH60aPxXbQ2i1fxV/qxmmLpELOOCWoPskJeZwHBYWkR7ombgpjbzowAJFgmSw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11159
X-Rspamd-Queue-Id: ABFB751C237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245407-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Hongxing Zhu <hongxing.zhu@nxp.com>
> Sent: Tuesday, May 12, 2026 1:23 PM
> To: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kerne=
l.org;
> kwilczynski@kernel.org; mani@kernel.org; robh@kernel.org;
> bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org; Hongxing Zhu
> <hongxing.zhu@nxp.com>; stable@vger.kernel.org
> Subject: [PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY reset=
 for
> i.MX95
>=20
> According to the i.MX95 PCIe PHY Databook, the ref_use_pad signal in the
> Common Block Signals section selects the reference clock source connected=
 to
> the PHY pads. Per the specification, any change to this input must be fol=
lowed by
> a PHY reset assertion to take effect.
>=20
> Move the REF_USE_PAD configuration before the PHY reset toggle to comply =
with
> the required initialization sequence.
>=20
> Fixes: 47f54a902dcd ("PCI: imx6: Toggle the core reset for i.MX95 PCIe")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 1034ac5c5f5c1..c57f18d9e4ffa 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -137,6 +137,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
> +	int (*init_pre_reset)(struct imx_pcie *pcie);
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert); @@ -247,6 +248,2=
4
> @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pci=
e)
>  	return imx_pcie->controller_id =3D=3D 1 ? IOMUXC_GPR16 :
> IOMUXC_GPR14;  }
>=20
> +static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie) {
> +	bool ext =3D imx_pcie->enable_ext_refclk;
> +
> +	/*
> +	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
> +	 * used to select reference clock connected to a pair of pads.
> +	 *
> +	 * Any change in this input must be followed by phy_reset assertion.
> +	 */
> +
> +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_SS_RW_REG_0,
Sorry, the register name IMX95_PCIE_SS_RW_REG_0 is incorrect and should be
replaced with IMX95_PCIE_PHY_GEN_CTRL. I will update this in the next versi=
on.

> +			   IMX95_PCIE_REF_USE_PAD,
> +			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
> +
> +	return 0;
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)  {
>  	bool ext =3D imx_pcie->enable_ext_refclk; @@ -269,9 +288,6 @@ static
> int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
>=20
> -	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD,
> -			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
> IMX95_PCIE_SS_RW_REG_0,
>  			   IMX95_PCIE_REF_CLKEN,
>  			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
> @@ -1251,6 +1267,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp=
)
>  		pp->bridge->disable_device =3D imx_pcie_disable_device;
>  	}
>=20
> +	if (imx_pcie->drvdata->init_pre_reset)
> +		imx_pcie->drvdata->init_pre_reset(imx_pcie);
> +
>  	imx_pcie_assert_core_reset(imx_pcie);
>  	imx_pcie_assert_perst(imx_pcie, true);
>=20
> @@ -1961,6 +1980,7 @@ static const struct imx_pcie_drvdata drvdata[] =3D =
{
>  		.mode_mask[0] =3D IMX95_PCIE_DEVICE_TYPE,
>  		.core_reset =3D imx95_pcie_core_reset,
>  		.init_phy =3D imx95_pcie_init_phy,
> +		.init_pre_reset =3D imx95_pcie_init_pre_reset,
>  		.wait_pll_lock =3D imx95_pcie_wait_for_phy_pll_lock,
>  		.enable_ref_clk =3D imx95_pcie_enable_ref_clk,
>  		.clr_clkreq_override =3D imx95_pcie_clr_clkreq_override, @@ -
> 2016,6 +2036,7 @@ static const struct imx_pcie_drvdata drvdata[] =3D {
>  		.ltssm_mask =3D IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  =3D IMX95_PE0_GEN_CTRL_1,
>  		.mode_mask[0] =3D IMX95_PCIE_DEVICE_TYPE,
> +		.init_pre_reset =3D imx95_pcie_init_pre_reset,
>  		.init_phy =3D imx95_pcie_init_phy,
>  		.core_reset =3D imx95_pcie_core_reset,
>  		.wait_pll_lock =3D imx95_pcie_wait_for_phy_pll_lock,
>=20
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> --
> 2.37.1


