Return-Path: <stable+bounces-241461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEycFiwZ8GmNOQEAu9opvQ
	(envelope-from <stable+bounces-241461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:19:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E347CAEE
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A827302EEA9
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AAC3909B3;
	Tue, 28 Apr 2026 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X1nUwtrf"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967038F247;
	Tue, 28 Apr 2026 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342758; cv=fail; b=StAdRVHAV58eCbM4xcBktni4GlSRZ03h8WC1tfGuyykVIAc9qhOVkLThQ639s8fvJoCWOUVYBjPt6wPAaF6lBDH74fD8/2SWnFQpoGVh+0EAfT4g+Rk2ghg6MRp1utdNH5uYQSml2OWIXUv4n0F/tTBBjhPSNsM/Q74H7np0DZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342758; c=relaxed/simple;
	bh=owtqNC2duQ81PR6kHTmAGSb2FacfM7G0LttOKhefaSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFy9ffheGwVIKwgjZSKcwanNIwUzGrYe9+xbL/8KsJVeuVPtiiwxmf6yDZ+exvMr9gXHgO4o+uSpYkVHBNnQtlyZmygWVqrrBY7DDjOr3gjJfyBrTRnLOG7QS/3hNZGCE+mW9uIbl14lJH7MCdrzJZo4U2917E6DOKV1sanyE9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X1nUwtrf; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciV2Rs9X2TauthFaB0pfw0NmBy1gHw2UdbHQfoYDC4lPwID+LBXCEYmUw6ZWviTc8ANeT+ZB6ixhUjeYPz/Cmjfu6bnV3z4B+YcMxl+ZroJBNSclsBzv8XPxwUSvvxrtNItkMRObcF6DReQRATYaRe5ed+k6sR8GdEt0Z/nmUTAtX5bBTR3vj5XGf6AbslEaQoaPungbxOMPGJfRMxrTei55qkUR6EUC4c1swg+axvRPwRQrc/EsuCeh2aCNqpch2F/cXvhLCxer7qVeienkZ4th9V0KzaOFOO1QgJCrVfWWlsdnUjPbivba6+abxGYgWltIUTThq5zRQjYO9MkRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATzFWOLmnOJ/n9e8MwDo7IheDF2x+KCB0Kkoa7P/Xy8=;
 b=piBqNnIA+V6d5LnsQu6UeXajs4Hgg0nyhv8kAGweCpL4eboihhKa1MJc3auOnaWuKrgh3EsOgpdNT/2ZAZ+VCAq+6o6Qb0DmLv/WWXkOugcm06XAeXAAYkOui8kkbuE9UMCM8FHToG0pt2msTWpDavA1CSJxPFjeJsInrsUSKkpBzr1/f0XPL99EbYmMaFuaA9skm4OXUa4JuTVeF5g8SBCWtRXbhXRi9BQaSdLfnUeJUJ6WpQgnU+mBWrAle53NBPzondHhLwsYLqD1bsKT7AfNDFGo1YqMR6BlcJfXw6tFly/PmntYIrROwGYX9feDpnxZ/NIB6IWSNCv+RBE4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATzFWOLmnOJ/n9e8MwDo7IheDF2x+KCB0Kkoa7P/Xy8=;
 b=X1nUwtrfJlq30Hh9S6wgiq5LTGalJPlvh9WMjcbpzK5risVncKri8mMWvGm/qpVVU7c3nD/Q/h/wSkhmpuXLELn3w+aFdqzYoiYIvc+kS+YNtT95bo6nuxFBDvQtYNAnw9VN9yStaanZSlagv+AVL1tw2pFva/iU/D0uEjrr0oYXhB+qBTjS3j+5/WPuX4pqS66QaAjy8xP752aZ5DyRPtCOnA/vrKaQTj6WP4VpsdGqV/uuwA8Dm/OqA7dQM/56D4lzUb7BpRttAP2ZwAMWeXzhHBa83OIIYnl++CJKbdp1DAZhGjMDTBvkhHI4gxt9joIahUbe4a7C5Jug0K3Eyg==
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com (2603:10a6:208:c2::19)
 by DB9PR04MB8495.eurprd04.prod.outlook.com (2603:10a6:10:2c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 02:19:13 +0000
Received: from AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5]) by AM0PR04MB5220.eurprd04.prod.outlook.com
 ([fe80::cbbc:93fd:f7b0:76e5%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 02:19:13 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Soeren Moch <smoch@web.de>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Bjorn Helgaas
	<bhelgaas@google.com>, Frank Li <frank.li@nxp.com>, Fabio Estevam
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Thread-Topic: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Thread-Index: AQHc1j02pL1yKLxXyk+WT7EvKyovarXzvQ/Q
Date: Tue, 28 Apr 2026 02:19:13 +0000
Message-ID:
 <AM0PR04MB5220EBE4BF61ECBFAF162A4D8C372@AM0PR04MB5220.eurprd04.prod.outlook.com>
References: <20260427115804.134231-1-smoch@web.de>
In-Reply-To: <20260427115804.134231-1-smoch@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5220:EE_|DB9PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: 9862cb08-a3d4-4f0c-4a79-08dea4cc8a50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ZW1yL1V4NnCJxKlPXP8/AKXTcvzwk008EsAapVEiU7inaJfbtOHUUNr5jiXJxFOHd8GlKrKxuXSLaX1LM86JnztADs+mpA/Yp+9ahMH5foY7zAGxXpEnjR2y/MGRoeXyc1AMNcpQgbbBFczc6p24kexakliUepTBzUCv9N9fuznp8UghQNEVLedg/+lPydV+4C4M6R4vIBYZbhiwYe7PhQwAhwgs4bZbXZrI2s+QRM9JP0HGhW7W9DVHbmzTQUg8d2+tSRM/QXTq0FjlZXlAbQNlWv7FXryo23/Gz0gthqad9jT9b2Xw6nbwTmty/+A0Nx///bElTvV5isMQB5zmQmzJuLqVsC1UPFcKoHR8dOAu2vc8ss7PjNHcPme+R5NQYH6BenUoREMtrZuwHkNZLrHs3lIAL4R3e9iGUP47mEICPC9KyJgvz56jqz3dBJ5YlnwEFnYxN48q5CebcyXZfc1LOlL7QSWcGDPHBCz35UmyM+99cIbtN28hagJGJn/q/aokOR3LuWIHOtOSbPy+fyfSZoPjvkiZ/BgXYXCudrSWPCnr3XDveb4NRE9k35h+yqCeZUKtppmGbo0j1TZt+itk9EhSBskKsutYcchgTKalblpDF0nrEfLxZsHoHAOBZQqzkWrM7CAg5QtLTFni9hbUpK9R/3gvywnOJt5Zo+BgCX6Pha6BcL/0SpOrde5KsBZ0o7C/r5G8NqELX/oPc3UEw2fnulgljW4LiNGV1vQO+KxOxVXWw4MF22ubQ0lMkPgRz4gU5yPLTE9t1KiVQhAhHKl4qzai75aNt6x0xUM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5220.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cboNcjyg4YHPhdQNg0EcUeGmCaGC7oJlh9pMFI9JKIp9HdF9a6hcRSs3eq/i?=
 =?us-ascii?Q?zr2XWNqy//iX1MvG/XQYxOxfewWGDK4idNCC91bjo3j0ebxP6AG1Nzf42UAw?=
 =?us-ascii?Q?02+xM9y5eL7EczbxJUDCdwOll66hcgMMGnoXwCXMwd3oRsTRtUgbKlfR0mJL?=
 =?us-ascii?Q?5Pg2bYwqeRWLJomJT8ZTYOflTWIle90JRVZPRkRuzYjk4FopAaIRH2IQwCE6?=
 =?us-ascii?Q?ODhx+l9igEvCv/3rUSuNzQnlbZzMGXJJhVzg/bRiMH+V1bKr4LjKmwFRpLQT?=
 =?us-ascii?Q?rXr87IEhR0BuDPDarAuX0ieGsXvpgDdIOzgqfrceBWstprc1zXGP9ePoo8R0?=
 =?us-ascii?Q?lmRMHvvr4j241jLneciRYeHlC8js6nBKJ37oHbzIKJEHFGWZ03CS2Cei76wu?=
 =?us-ascii?Q?P9PGeGRH9FCgQoP7TRMjR9EaOx5zfbb/QFn28NLkBInKVZNFD7W1XrgPJNzm?=
 =?us-ascii?Q?9skw3f5qqiaguOhgG/C5D4LIt4UC1gCVRBXWItzbX01nJTORuyzTkLry5rt+?=
 =?us-ascii?Q?d/SQYtSy8q4/CP7SAe+O6AlVoHmEwLufpmgeGwDIjV50WwIMXKdQp5PiGHmx?=
 =?us-ascii?Q?I6JUGZByBUjm7kIqVbHk3ey0fkgUy4VcguWxh07T9ENRyEQSsVWHWsSXsXLU?=
 =?us-ascii?Q?ttG7rra7npfdGQq9cEhTh6D5M/5EEzNtvx2riLZiQ+Z5YxfJksSOFjQuykTX?=
 =?us-ascii?Q?TzUCfh6/IlJ8uiNZF5A0H89a8I+T0h9tHp629Hv2Kq63TNVk/CY53v7s5d//?=
 =?us-ascii?Q?YTX3n4/Ymcfkm/awH5IHMwfQt4AFIzN+/xpVl6HTZeV21ijZfZUf7X6JMWvF?=
 =?us-ascii?Q?rJkXt3MRv2MnwwS4Wl1mVKa3w0G5vMVopElZ7tXwOxxUirnbaYeutXR7TBTi?=
 =?us-ascii?Q?eOcOG/Db8h6N1PqlJVskhxDkovOCqzyPZ5tTRiCYrs0JFNSu8COcao7YDB58?=
 =?us-ascii?Q?IROkQnTkAb6YNZHGeLQSBYSo1IDayAOK+LDy7QJnkoQLQMKkbm5haWw6VdAv?=
 =?us-ascii?Q?PNjnVPj/CIYZvAx41jgSw8dw1pKh6kSZWIwmegXyzj2CNWaH7pWlz2+W55hl?=
 =?us-ascii?Q?j2Rj7Z2OKiFdT3J+NF4CtcDURBgZPm8faQNy1pwn5RFiVa9bgwx5o4W6gGhY?=
 =?us-ascii?Q?vKPN4YoprgnHrASFowCTQUh0rUVjYR+m8zabwREUfCH8xx29neD61JXYhowC?=
 =?us-ascii?Q?r2BGgikOXUEK+0WGyP6MAZsKKp2Ke0uMzhS52lb54wzfTdXDFv/ii1zKmq1x?=
 =?us-ascii?Q?csngXue5u9kRbWWSDSj3ly4H4zXcHTcX2n8FL+uAeAUMTwnB2ybEjp0inHlk?=
 =?us-ascii?Q?RAKTkh28ihLIP6QL2OVv0Q1l2x/L4lCFW1Im+taecU4lWnKHgGeDsIuROKzE?=
 =?us-ascii?Q?QW0ZJmToFbuZAs3QvS8m9Z6F8cK+aBgkZ84vY0CbqFoMQiUktDaquMrn8mXj?=
 =?us-ascii?Q?V2VLp2STPvUTfenCLEF/QQNehxyN8XbsG1RPHw7zwoh5dWZW0hwhFBCC25nX?=
 =?us-ascii?Q?ozTcuWV9smlKx4IShca+EftkVgo02r/yPpHihiNN9v0KLTiuMNpachY7wc5H?=
 =?us-ascii?Q?/bVDgOI+HLtc74mRrw57/eV59K6aiact6q0dVA7FWWF8gMsiHki2QjNCT44V?=
 =?us-ascii?Q?zHkWxtHctEU5OKWaf7n8kIp7jWPhWeANL/qGa1YWFE3g2eRUbsYf3hUtDxDk?=
 =?us-ascii?Q?4IbarYfAdcCaOvaEe36od4YwzfcjLnBynSdJxIwvPyc3oY+c?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5220.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9862cb08-a3d4-4f0c-4a79-08dea4cc8a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 02:19:13.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYcHkHceBSAZmH1zuw7MdQleYZ7w0co8w7SVRXf6PMm4z1aBoRDrMEcupqoGVY580COMxD/ej+YrbJ4VqrqrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8495
X-Rspamd-Queue-Id: 036E347CAEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,pengutronix.de,google.com,nxp.com,gmail.com,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-241461-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,AM0PR04MB5220.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> -----Original Message-----
> From: Soeren Moch <smoch@web.de>
> Sent: Monday, April 27, 2026 7:58 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Soeren Moch <smoch@web.de>; stable@vger.kernel.org; Manivannan
> Sadhasivam <mani@kernel.org>; Lucas Stach <l.stach@pengutronix.de>; Bjorn
> Helgaas <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>; Fabio Estevam
> <festevam@gmail.com>; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kernel=
.org
> Subject: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
>=20
> [You don't often get email from smoch@web.de. Learn why this is important=
 at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received =
by
> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>=20
> Even though the Root Port MSIs won't be received by the iMSI-RX controlle=
r due
> to design, this chipset has some weird hardware bug that prevents the end=
point
> MSIs from reaching when the Root Port MSI capability is disabled.
>=20
> Hence, always keep the Root Port MSI capability for this chipset.
>=20
> Note that by keeping Root Port MSI capability, Root Port MSIs such as AER=
, PME
> and others won't be received by default. So users need to use workarounds=
 such
> as passing 'pcie_pme=3Dnomsi' cmdline param.
>=20
> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-=
RX to
> work around hardware bug")
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: Soeren Moch <smoch@web.de>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
> ---
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
>=20
> Tested on a tbs2910 board [1]
> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 6d6a1688e7eb..3d461bdef967 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D =
{
>                 .flags =3D IMX_PCIE_FLAG_IMX_PHY |
>                          IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>                          IMX_PCIE_FLAG_BROKEN_SUSPEND |
> -                        IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
> +                        IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
> +                        IMX_PCIE_FLAG_KEEP_MSI_CAP,
>                 .dbi_length =3D 0x200,
>                 .gpr =3D "fsl,imx6q-iomuxc-gpr",
>                 .ltssm_off =3D IOMUXC_GPR12,
> --
> 2.43.0


