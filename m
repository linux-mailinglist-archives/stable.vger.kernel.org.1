Return-Path: <stable+bounces-227411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEJUIKCrvGmk1wIAu9opvQ
	(envelope-from <stable+bounces-227411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:06:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FEC2D4FE4
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CEC3022F93
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1242D5C74;
	Fri, 20 Mar 2026 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPpt/HSA"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA42EC090;
	Fri, 20 Mar 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972274; cv=fail; b=Nx/yDLc1l5WtmJa+D8XW6qSoqRtuwsf8xhDSUQ90iiD9zFaP6NQOqnaJy+7LEqhsvuWC9JHoLOyX/r/xgq1Fex4XZMcsSo4B3LiAax4vj6RTdJ6G6Z+d1wRFituO5k6awvIj5CfkcT0Mr+lGpV+JJR8ww430Rv5B3NeYV9cfe4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972274; c=relaxed/simple;
	bh=3M4lbtCV/zptjjiUD80aUnZqWeLCISm2Skx3ooiD6rY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajUIJnZQ+2SNyB0TL+y8yg1zKgBS/uD2hmOrjixPZHOoZErgCmyZ/FY+S4z8p6ngiQfduSnUtlRr3kKFQO8jLfA7nX8cFau/7KLjE1FfjM0Nox3BxZDQAdRkkmJeUwJvtNG9eiMqns5/aCoNJVLEfkoUDayp2PezOexGXDbFFIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XPpt/HSA; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr41vd2G3l5rR8IhdDH6J6wFxaZb/shHMXPxzijWVRA7Qev2a8WLIJOYDyUvoLnUX9qoAN7I5SNE9Z7qSsQNEH85rmZBBUBn/sz7sL124HW5KPeFqw8CFLgYB0jqpGCBdbcxLIbq7iBY8crKE2Tb6XSrT/WVq8LV8oi0pe8M/7aJTcbroiAsCmGRb+d/fEdaLEE5Jz3CJCe78Vbma3bDf2Jg9D5DmRZC9OyZoYspUeEA/JO5bOcQiZ8l2ZwHKh7ePW4iXc3LC+5pngyEvNS4VX2vmA2obOG0f9J+6Kt/H5yQM5nwEkRVT6sPvTtLtI1jEwKF+A/4/+lgnNsJId++KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M4lbtCV/zptjjiUD80aUnZqWeLCISm2Skx3ooiD6rY=;
 b=N8/eVSgrslGoulBOWbRkUo8P9yjDx7IMVDaVkVbOfbIZH6ccowp03v8/0BX1PLK9ZP1L25xCxlA2tMtHX+Q6aeSZUPNn8WWpNf+ACusE3HJyzfeBF7xE3X+I1In/zP03LIwHj3wgSR0J4/AQK2Q9uFdoocZevj0lANdx4s+Bicug1Pxmhw8z/FbS51HcQWJW7DR67nwQFdTht/YT8S5YCbR2RBsfsCnFi1MqUmwVIPYV3W73MMeVpg/vzZa0KD9tjOh1EYD0g2fM8tecMlIc4/baxZxALvjNQbxl4IjKBnvEfb77R80yH+sbzmRSaqcgsYtFLbejFvLZttdahgH7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M4lbtCV/zptjjiUD80aUnZqWeLCISm2Skx3ooiD6rY=;
 b=XPpt/HSAoTCsWjUaNLgyST4sXURH3Z1G78iebaKccCl2vX7Vuc8tw5lSE8mXNacHL/zKWmGW9dO7XhQFS35Tl9wXKliSgRPLAtJymi/R3VzJ2IAYLvegAlCYf3htFo2MMm8I8Uwy+GVp+6RbmiZhHYM14oJ/7lKX0ujziW91rGojAh+DS1b5fMuLOWVdP0iPdQvdRS+UxNkUlev2i3Mx+zPj3C77yTI+k2u4rioZmaRr6+0KB3UObBMQyzKuW6Apx8bB10e1DFrKFc1iX39AqXiOnBknj70+qTkShrw3xLsWUcMPi4JDhB/TJ6YfQko3JOyLd0C1p1jIMB+bKU+Vxg==
Received: from PAWPR04MB9960.eurprd04.prod.outlook.com (2603:10a6:102:38b::5)
 by DU4PR04MB12111.eurprd04.prod.outlook.com (2603:10a6:10:63e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 02:04:22 +0000
Received: from PAWPR04MB9960.eurprd04.prod.outlook.com
 ([fe80::566f:3659:511:76cf]) by PAWPR04MB9960.eurprd04.prod.outlook.com
 ([fe80::566f:3659:511:76cf%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 02:04:22 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: Frank Li <frank.li@nxp.com>, Stefan Eichenberger <eichest@gmail.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "stefan.eichenberger@toradex.com"
	<stefan.eichenberger@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated
 after last read
Thread-Topic: [EXT] Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated
 after last read
Thread-Index: AQHcqyXwBHUr+bUJrUuXl+mBxXWLd7WdqYeAgBjrEACAAC+/kA==
Date: Fri, 20 Mar 2026 02:04:22 +0000
Message-ID:
 <PAWPR04MB9960D02AE0E9D0FFF53D2E82E84CA@PAWPR04MB9960.eurprd04.prod.outlook.com>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
 <aZXq4gn4xhInQQlq@eichest-laptop> <aaamYByn9dZEIBWb@eichest-laptop>
 <aacECsJ6O8QjHsUa@lizhi-Precision-Tower-5810>
 <PAWPR04MB9960F0118ACC092BCAAB0142E87CA@PAWPR04MB9960.eurprd04.prod.outlook.com>
 <abyBxAvJcMshvB7G@zenone.zhora.eu>
In-Reply-To: <abyBxAvJcMshvB7G@zenone.zhora.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9960:EE_|DU4PR04MB12111:EE_
x-ms-office365-filtering-correlation-id: a02860f4-7e0a-4c52-9b47-08de8625010a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Yc7Orjqu1Bt/29sOMaKqfRYVNByJWKJxpWUrD15VWA+AOWf+3FxiT+cwmglzRho5tbnyNZBZQOJAzCibCX0Qz2ypZdcHFo1ndwNFDFl7yhjv0aRQnO1drz6nwbldagBgHGjMERIgESHaHs+Clx4uxhPMIqeu8dz9BBkOZLRUW7gw05Cl8kKLKJz2dYIJ3tQCwdj5PHNQClmYssEQE4pp93nTIqKAifO54gcg+F132/zbK454FayNaELfwGBHJTxySh0xpKhdcaforK4aBuBb36Pc6zTUzt5+HQ/dPP+bXsUwPpyqfq8heyPlwTwlq7ahRWf2JWEIjadG6GGD1sEsRtjnuzoXYj2sKOyLvxb4B43oYHxWEK8wrYuVwOLTmAVmMkK2KN9lJ7p17hHXbslq1qRpGuK6UL6rpZ7+zt5OvdMdVPx2vRBRZ7Yg8OVQF2BL4Si/VqIhtOKzj1/X9JFg2yEwSsuFICu+b9anU1GPFQt9I7uJzOGTMmXhBwZXv9+lcHljeXE+y1TEMQc1J66qZ31s6x8LL3MbfZ6QoSoRhfjHj6HiKzgudQaXdI/dGj1CRCm4XByFjUTpu91rV5yYaI9ZsLvv+WFPORcwazIXSh/iPg4PahfqXjHp2NVcBsNXxZkBmeIWj43J+7AeebNJ9fYAztKRqRemAEYHCk6jRiuwqXpql/fp55IInlqnihRS+0oaFxJe73pZm+DgWHNfZ0NiLgrR9c4g/53Q1MkklMY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ydNrWAAAzoSeKKBwmJyCIQPIgdc1efMMpCbxfRXEwuQI3AcFEYsRTJxZvlA?=
 =?us-ascii?Q?LVb3kWCSf5E7GzsFmaKV93qfTilZvGqyDP6sYdVGyLB4QymMuuxsKcN/J3gG?=
 =?us-ascii?Q?HROzC5Rd1jZzhkQYviTVdxbHg/cALAxyw+qC6Y0//5ua1KZdC6mDiygamwkN?=
 =?us-ascii?Q?r7eoZYeHnUhc5nFNPiQzWY13vRghsba4No79f9DQMB9ofUO2ieImuYT+SN/s?=
 =?us-ascii?Q?+AvCNiK5qT6m+iaG2lwzl/ozQJ9v88RWipItWo1wx57s0cQ2I6BPQ34nOXQh?=
 =?us-ascii?Q?ituFLbkUvWcnQ05Bw943OWJUqe7Q4ukicxMJpBeqpXn1g6x+c7YAuqUQ5/wP?=
 =?us-ascii?Q?v/MOi1zcHSC1AYb1lAyYSlKZaxd5I0OZRC0RNx9OPhdyX8oX7Kv+8iiD//mP?=
 =?us-ascii?Q?Yc9WZOaKL89v/ROlcrOaGQKStKn6A4XQP+LrmyNMgavKnyJjyF+iVjuyRZrJ?=
 =?us-ascii?Q?bKFVhNOzggaqNXF4Bbsng58Zf8GKDsM9Xog2V8TpWuX+GIm1GfVCIxfTosuK?=
 =?us-ascii?Q?rA18XcDNNQZjAuf7eh7tct0X8kVSzpybRBkARENgsIvVUmlr+lk9i4oa2GjE?=
 =?us-ascii?Q?HhKqlc8Yb53NCBTUzqtSAdvXFusLpYbpgyOg7KBWn40ENUxG26ltK/2Wm/pK?=
 =?us-ascii?Q?q0PxHdPnXL5CHB4h46L+6uPXw6YpG8NLsWxWIcm3UYmqp54jCoejKgEROaN+?=
 =?us-ascii?Q?+G9Mt5K7eDJuRfr950PpU2BaSIOVdg/lZwxAv16m4We5FwV4GWCnqchSZOnl?=
 =?us-ascii?Q?uQ9Pdxg3Hc7eGQz72KfVGjv0ObmUU+Ufa6EcsmhUDY/ORq/QY/iPvq6BLRUU?=
 =?us-ascii?Q?5js/s1KhLoqtbwI8OvTFaspgMSsPpsonbkIPOIP5I1U9jK9fgWjY1RdwTefL?=
 =?us-ascii?Q?Puk9pHcSbvKh3zg627lOUoeVP93WjXftEEE7vnaKkOnyO23xBpFXKSBTqIG3?=
 =?us-ascii?Q?bLxIibLabJYU48c7YZDNxb4DJNypbjB64bgGSUhCOSWmCR2V8fdMvphjg/gk?=
 =?us-ascii?Q?PEivtT23IgFrDNCX+3GuP1xHzeV0TS+aSg1Bxa0isXbeICyuKf8nOOKHNnGI?=
 =?us-ascii?Q?PfqHABGWJITu7XlFUlGRSTc0OPjvlZc4RDm93RWFtOtS5Br7AOb+Det7X82O?=
 =?us-ascii?Q?9GW690kwdvQeIRGD6EtfuJjX3b1pjp9o0tEnlXQPhE7vHQrtrOPswseXfzcI?=
 =?us-ascii?Q?6GEyJ2Qjhwn1EIZI8RmxRP2R/egNAK2T7WaBRDc8662cvheyLAHDZ8naDG3F?=
 =?us-ascii?Q?wWhwgKMLqA5wziATYYyYFpd4acBYoYCnQDxpnTy5wQy5sl1ZKH9KKo0kJvcQ?=
 =?us-ascii?Q?p/beK8ZSsYlvzITIpGFaHzFAugFvJAgYj8IEhawQlUJ9xgNvkWL5vZVjEfCN?=
 =?us-ascii?Q?PIFduE43RyTQ2JaZf6lvu+ODE+F14jZ9LZFBLrVTzaln2VMzGqXP19YFd5HP?=
 =?us-ascii?Q?az8OrbpTPppheFBnUfvRXJIjsbyhDO2Xbco/sP3nAvJg+oCjjNIJ23JR+0tb?=
 =?us-ascii?Q?3NzCzxk9I0DtgL3BehpE6Xwn2ycnXWi5XhvC0vMwcuF5nr952qBNEMVj1lb3?=
 =?us-ascii?Q?sYERvFB0TcSDiHyt7qeXFNSM1jae0C2ooERbSuZsGyojoPG2OWwtAhNChMJT?=
 =?us-ascii?Q?/gJdAt2wOhMLvN2xlYmqPAdtIoffNen7M8FO4y/57Bwq9BXHQourZlu/cwcW?=
 =?us-ascii?Q?zFSOqCqlnKEv3nUqpRsgfz26jrbiqe+nM6I+84S+dP4JjVm9?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02860f4-7e0a-4c52-9b47-08de8625010a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 02:04:22.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZNGN4OM1806n5JR0Lfy5qTGlyxWVL3w7MvwpOhGrgsMb94fjYZ/ZG5L/iRMPBJDukl9zkDI7LyMSJDNnPxgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12111
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-227411-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: D9FEC2D4FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Andi Shyti <andi.shyti@kernel.org>
> Sent: Friday, March 20, 2026 7:10 AM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: Frank Li <frank.li@nxp.com>; Stefan Eichenberger <eichest@gmail.com>;
> o.rempel@pengutronix.de; kernel@pengutronix.de; s.hauer@pengutronix.de;
> festevam@gmail.com; stefan.eichenberger@toradex.com; Francesco Dolcini
> <francesco.dolcini@toradex.com>; linux-i2c@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [EXT] Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated =
after
> last read
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi Carlos,
>=20
> > > > > > > When reading from the I2DR register, right after releasing
> > > > > > > the bus by clearing MSTA and MTX, the I2C controller might
> > > > > > > still generate an additional clock cycle which can cause
> > > > > > > devices to misbehave. Ensure to
> > > > > >
> > > > > > Do you means SCL have additional toggle? You capture waveform?
> > > > > >
> > > > >
> > > > > Yes exactly. We were able to capture the waveform when the issue
> > > > > happens. It doesn't always happen though, it depends on how much
> > > > > time passes between clearing MSTA and MTX and reading from I2DR.
> > > > >
> > > > > If you want to see the waveform, I uploaded it to our server:
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > >
> 2Fshare.toradex.com%2Fdwnhcrl6b9toib6&data=3D05%7C02%7Ccarlos.song
> > > > > %40nxp.com%7C9567b791c35345a75eba08de860c9954%7C686ea1d
> 3bc2b4c6f
> > > > >
> a92cd99c5c301635%7C0%7C0%7C639095585800985569%7CUnknown%7CT
> WFpbG
> > > > >
> Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi
> > > > >
> IsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DAK6DGztAek
> > > > > 8Dq0M8G98PO%2F68UhcwfJPxsLSJQZ4jumE%3D&reserved=3D0
> > > > > You can see the additional clock at the right end, after "0x17 + =
NAK".
> > > >
> > > > Have you had a chance to look at the waveform? Do you have any
> > > > concerns about the proposed solution?
> > >
> > > I am fine. Add carlos, who did many work about I2C.
> > >
> > > Frank
> >
> > Hi,
> >
> > Just review this series, looks this series patch make this fix for the =
limitation[1]
> safer:
> > "It must generate STOP before read I2DR to prevent controller from
> generating another clock cycle".
> >
> > Previous patch[2] has done this to avoid the limitation. However accord=
ing to
> the waveform, I2C controller still generated an additional clock cycle
> sometime.
> >
> > The key of patch is ensure to read the last bytes after the bus is not =
busy
> anymore to avoid this another clock cycle.So these patches are fine to me=
 also.
> >
> > [1] 054b62d9f25c ("i2c: imx: fix the i2c bus hang issue when do repeat
> > restart") [2] 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma
> > mode")
>=20
> Sorry, I'm not understanding your point here. Are you suggesting to chang=
e the
> Fixes tag to [1]?
>=20

Hi, Andi

No, don't need to do anything, . I agreed with this patch totally, it is re=
asonable.

> Thanks,
> Andi


