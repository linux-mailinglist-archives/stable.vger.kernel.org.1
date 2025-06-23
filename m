Return-Path: <stable+bounces-155340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673BBAE3D67
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D519188A8CE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49DD23A9BE;
	Mon, 23 Jun 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QniGqlfS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zQcubP+0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E622F77F;
	Mon, 23 Jun 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676063; cv=fail; b=uaYVHDXoVikICbAwcbJTKJU9zbHxdIbrnCeZKobATLySpo8mo550fAZJl7Mx1T6nMWI+A76OEUBy6DOLUw7PrOda5KEMe/YHZDaRLSFO9DaM3/rMs4KvBQPobFq0g2j6pOPO2hlKxK4C7CwbjaSFiWu8lhnuM1gR9gQj/AtO9mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676063; c=relaxed/simple;
	bh=Njh6Cl5CjQ/mRyli+dgQqltcTUsPTxx+00Dpy9ABSMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dobz2wNOE4JcQKyVAX/AaKZJeqbJZZ57Fp5nqOoPruVQzEwOk385hLq0XLZbvaVc3avgDxjaAIMnsYDnTqieI8mxgdxXRrpLL3FoTCNm2z4UNuIMpQyBXsupnMVwRr5ABDi7cBcFYiM2lN05j8xSzmY5FywPMHbQgZbGVmURSkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=QniGqlfS; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=zQcubP+0; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N98RWl023516;
	Mon, 23 Jun 2025 03:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=GnNvWcjs5g4QNlmXTcBS7s+6VgcoGZIc4FSRWRGVACU=; b=QniGqlfSHpju
	tbfG2ul0rqPkQI5R10xMMNu+YKTgBzj4DXn2HsSO3Z++vng1OB8KOxHIG7KnnnnI
	kTX9GwJQImzMadhxR1pmw58Q4GuEJrVWdn7Gdr9HFy8BXMdgD835A3ty7KyAr5sr
	QxPKj+RhR9KBRNuonuKR8/g0c0FC74VMbumyAdwyVH4CVIksImaA8nPmhN+0RkvE
	6V+9x/t4a9Z7280A5ZViz2PCkSEhbJQbLxR6dy8wluAchUlRXsMb2VHCritHJ9kI
	Br1Hz6AYsLO8d/RPllWnYp/T/lPOx44Sda8foYJcV2jBcpCFkr7g2lLTJXdS9iH4
	xx3hd2d+jA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 47ds9ycmp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 03:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUcv1BvFkmVEOb0OpU/b8EPA3bdhmqy9OaviFICA0hca2BQ7MB6SNWTsNzcT28TcQQdV1uAtH1+rSlNVDIDrorv502/ZI6YaMhxmYh86t5t1ZFxHlL4skzC6ak+anDnz/edljujiZ3TegaldSP5Dl7UX+kJNKrtk91sdKCIIdwal2q4C4w3azYr5cu4HOcwk1YXGfHMnbtlNmicEUyZpwrR96t6OJSy8G9hkNZzKrJvlGtt3tptw9rNSWVVCenEX/A8JGUV6FqDvJSVn4IP/lH6Y8GMqHKG8n0aKH9hXShFNT4yIhRsiGM31XCmzinDUBTiZMPFhyrYNRYT7696sTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnNvWcjs5g4QNlmXTcBS7s+6VgcoGZIc4FSRWRGVACU=;
 b=Iqo6mC4a79s1vGd5FSsFMnn/IIxuJDml9fpmmHbfzry2Sr9QPkctNGE59WHhGQ/iO8gt5yXcRvEEXEto4Nf4PjRxzQ83JcdDFD9CL3TGyBiDtBX+8GfF2iJa/sweV4wFiTCkVLJjnQ+mHQZZ6gGBOlURdnR6+jVKwWFoclHJ2GQxa/lIgtVs3WCnWiIEIOogONZwbRZIeDQPL4HIz24kvGF8NW/JN7akmNKwtJEElnknzE0p+dN9qpSuPz3qax7Ho6OzQkYTKl5uXR87X11F1ubRwyGmiy0fEYtbIOeyMWUai1TFv/2/iGR+GGfi1KBGrYcEeBvG2bBRKhOG5/iXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnNvWcjs5g4QNlmXTcBS7s+6VgcoGZIc4FSRWRGVACU=;
 b=zQcubP+0iDevg0VhAEcuicgBhKTc5iIb1aJBQ6URFVewBIt+Eo3csWbWYu/iT1SLTZ71jV2GEVDka09MiDd53FBm9+8usqXATB2IurP7hE1/eRwqtOjtrA1fWzu4RuMPGPgFv1SaGWSvOBHVB2x24k+V5bwYzIcI2WLvSoxE6tU=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DM6PR07MB8110.namprd07.prod.outlook.com (2603:10b6:5:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Mon, 23 Jun
 2025 10:54:12 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:54:12 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Topic: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Index: AQHb4byQPqa7j5J6MUG7SRmJB3iE/rQMxaWAgAN5JwCAAC2EgIAAKVzw
Date: Mon, 23 Jun 2025 10:54:12 +0000
Message-ID:
 <PH7PR07MB95380B5B6840F80667A72C9EDD79A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250620074306.2278838-1-pawell@cadence.com>
 <PH7PR07MB95382CCD50549DABAEFD6156DD7CA@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250621003643.GA41153@nchen-desktop>
 <PH7PR07MB953862997AC245FB4ADEE60FDD79A@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250623082201.GA53043@nchen-desktop>
In-Reply-To: <20250623082201.GA53043@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DM6PR07MB8110:EE_
x-ms-office365-filtering-correlation-id: 1f9de987-5fab-45ef-301a-08ddb24449ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XtP+MV0gKk4kNPoZtwmq9UyH5EynuwvsjghYu6ERpyMNeZ0DecdzBICnYxyb?=
 =?us-ascii?Q?WWvJqdc9sxA7SU/1zoBjSjGEuwbcvPAj8aGBTmODslMoDQdTbnTjImTIOgch?=
 =?us-ascii?Q?eTkAdtVhBpB7P4PuP9iAlB3k22SNCHrQplFSmUKX5SXV2/QsZWR6EnwrRRjz?=
 =?us-ascii?Q?/5HohWUlSaTTiqoJuTHpoGCU2yLZBVbdNlunVxq1DLmC4k9ikwSs+e8DUADk?=
 =?us-ascii?Q?2S+X5uCOt2V1u/2ISyV1ODdpJcu0hhzNa3V1WZ0+JRMDFHgBGqN4gef/EdBx?=
 =?us-ascii?Q?s+k60ruLnujz5w/jjpD+pj3moMrcY6NMkCw/qAG26ZPO1ow9n8SPIqslnBxn?=
 =?us-ascii?Q?i6Elp+yVAWHx+adn/U1e2DsoSHyFAxzG/osEofLgIOuV1eeoGJkbWROQSGiw?=
 =?us-ascii?Q?BNsw18snR1QukXIRVrNz4DiLp0poZmblKkplYB0i3Q9NTDT99ryPcPxid1p1?=
 =?us-ascii?Q?ggvtL1MYXvf+G/po8rNlC3bz3UbeJeuueGTN56+aYs4MhEJ7VysvTD2nukM/?=
 =?us-ascii?Q?CoYUVFbQH1XQ/OVEua+IEvz1mGh+uQ8RzvMselF17coejcccdt3dI7pgcK9E?=
 =?us-ascii?Q?Tq3CLt/cCVBvr/wvC1cJWzE0IipEy8T22PkImXnsyZB+avgcD6lYhyGmUr0P?=
 =?us-ascii?Q?AFxbjs/sLSN9Din5CAHjMclmWv/dY/84hCF89mzJgZ5t/wUIinPTseFNjRGX?=
 =?us-ascii?Q?rCrnBsVxG44SLJcu5/EgQYsg9Qb898hsegQ6J370EwyQl4Ya8vIaxHO65eI9?=
 =?us-ascii?Q?vDqqF5PtmkUhUzpUHEbsUaoTcr0I9i9c4inU3pRQ/aQ7gYsmo4DK+yurm2Zi?=
 =?us-ascii?Q?hG2F/zrpybUo6sG2A6U4v4UcHjnVFaYiigk6/QF5sWgQ2o0ZpkxRkkvqfYaU?=
 =?us-ascii?Q?5IcxyBSy5pUE+3mI5863J7l5DWhNrGV/FmvkAMazjUT+ehRoLo1Rwob0A1p2?=
 =?us-ascii?Q?Uq3aO+B5zDAxVJ7OKulyti+ndclEKgt5ZF/lIIgy+znwU3Jx/Q98wU1smo4O?=
 =?us-ascii?Q?xXOJgP6VZAeZ0Lo/X57t4FpaxQb040AteUMcQr6cL5SVsIRvpa3Rhh/j6NZr?=
 =?us-ascii?Q?WNVmNjvixJTfUG1SejOWdQuIwOsUikgIeixKaeTbY+i5X5N3Jnr+YhDzdxwi?=
 =?us-ascii?Q?CBU2VY9bIifpaj1Ht0/LP2EpqA3OcvnWyzFAdwKzp6sIj53y3srdy5cw4V9y?=
 =?us-ascii?Q?c/QqdEE1/oeD1TPtr9MiC6ojTiPI3YKTcPO4vRvAe6Y3SPIhe2+jZsF41O5e?=
 =?us-ascii?Q?XZ4jksucqdNL3qB8JYkXCUnLNs516IwkMJoJ2c7VX2i9OBjrbU8Pc1IfuHmp?=
 =?us-ascii?Q?k1IF5P0LEWBvvmChRzGCqT81HR3k99208BaL8/EQPY0veKrUruQd+YQtUYjM?=
 =?us-ascii?Q?sLSTMfrBEjJTxvLdxu+vESkVC9zZmWbOJLwSFP1aQxFGSUznI1o/+nc6Dai/?=
 =?us-ascii?Q?1QSRByf8dHUHPjXZxTKScVgSXuft0d8yIUAmLvuAaMuZ5Om4Ng+KDZ3aGYyH?=
 =?us-ascii?Q?3l8mjhcYAKLs1Yg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vOYckWmaYqv7uWmLPHhFJHSf7fzP/dq74WKxy/gu7iQkgCyfB9erI+nzwTTk?=
 =?us-ascii?Q?Ia23RcVFRDW/kZkNYHb/lP0ESzARtmTqLeoy7EoigvrpAAnMscztMm5OQfuG?=
 =?us-ascii?Q?J8w0U0dKhaIfRxavIOiPbblvwU0SeuvRYgUnETHZgCwl9Pf+YtmHpyRFt/hK?=
 =?us-ascii?Q?8j2u6EHTtAi0scVLe0wJgea04wXy7nP2GqmaTSn8KB3kzAoW4krdcVdmbYYz?=
 =?us-ascii?Q?65dIKlaaXckdW+hKCEJ2BDnI+dyzzLmo/Hmkc0IRjNrIX9tGnSNvZrUYUSJa?=
 =?us-ascii?Q?qDM21BXmSHbGXY+LbW9qEqAriujsatJEBe8jxqZ8ulsJIWyE8YXTJg6h2/tF?=
 =?us-ascii?Q?FNFulUx8nBhvgqSPtKa/vesr4JvZCOKL7MHmPeioIAScGoF3d4HQiWfD150k?=
 =?us-ascii?Q?1B8vQCMPHzCNf5RRtTEgZQlE5wmkL1bvWMOeAEfDvR8VJ0Noe0FUKMXukTnq?=
 =?us-ascii?Q?/48S+AwkJaEGpCXRjwRO6k+tTXK7SKnHkDOJA2bj2dkFXytfAFkya3aUH8fM?=
 =?us-ascii?Q?Y5QoLtKHJBDAqZ1YlS7fIUaSw2vxWcaSwpcyVQLR4fxuC+03H8XtC2t2ijf1?=
 =?us-ascii?Q?eL1elyl7YD6XgmUgBW9DdaenSQh3KYBbhMZJqgijlB3ZA/fyZ6NJvj3Ime2u?=
 =?us-ascii?Q?tXG2/K378nfjvgGFyGH1ANztpgJwGv3HEER2Os116V91We43D+o2M6/FGcXp?=
 =?us-ascii?Q?r2WE/RYz8muIAozOTX2IkSwleHo28AUEk5DTUPjM5e/nvT3xkLBygR4g5RLo?=
 =?us-ascii?Q?Qchsa+OxNN9f7arTPbl3D5tYvqGDwdFmydj64pgNFogys+plXLP8O3fkHFyb?=
 =?us-ascii?Q?ARtuOdNNZ4TrAc+WxTJoIuLGRHYf4yNUi7Ur1u/avUCrxXjJFmG2/jsFLjZL?=
 =?us-ascii?Q?T0fEJ7lWXhywKKVWo1LtU45E1u0tENscLMsZUJsXu4mx7FqT9vzhJS2uDWOu?=
 =?us-ascii?Q?EYPEGCeMmdZP9IyQIK7GIvkjX31whlkybd4J2hkPzozoeE5dvsavhIY5BW/C?=
 =?us-ascii?Q?fLSZwr96+R0q2XTf5LRDN/26JTG9wtnXY0SHuObiIrfXfqMfKdoClDSTRc9p?=
 =?us-ascii?Q?D3ybZ1tLiGaAVbpv4gKqqL5uzJ2NTKotbJPbeZFFBQdz+T/yKqL3tk7qtPrI?=
 =?us-ascii?Q?HxJN/sXBb77ofau/TneQkCIAdHgJIEdbYZYHWE/IDJs1FWpttRTqnsyspH9z?=
 =?us-ascii?Q?OJOM5rDfjZleGM5EUPzxyltrtkii1EdlVu2Zjiu76BEdARpZwsMYIssVpkRr?=
 =?us-ascii?Q?w4FHeo8p2AdbbRit3mt+XWUoxB8waJ3VHZDZlyFHHDmzoWh7cxl94sZv/AVy?=
 =?us-ascii?Q?GhTiKasln1hajkUqdjVia6lNfr171a6sSZzOenbZJe9waCC1QbomSgOyOnzo?=
 =?us-ascii?Q?+sHf03USkSsaYSGqmpPZrUq2Y09XIn83jLUUjP8cTHetzxQeWmmTG4Igrz0X?=
 =?us-ascii?Q?PJ4ovHkCQrK8U4ZM9Qh8FZgdiC9LEufoAcFe6IqfJksY7K/awN+IxiBO5pU3?=
 =?us-ascii?Q?V+mVzibwzwjO636YcZMYPyq8He35XIXOyP7uoajwJ2npBRditSsayzW3Emca?=
 =?us-ascii?Q?1epc7DJQxom4ub5HEvl4NcQ7QOKkOJoJe30TVvSk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9de987-5fab-45ef-301a-08ddb24449ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 10:54:12.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEm34nKnuZI6OQYT6I/qsMiF6Wze5obJTCMieM1vdrXw+f6A6ZBOEyxIm6sfu7Qo9Z2LrjLj86h5c18sDSzhRiJkmDv+AbwRNaoUlIe2jzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB8110
X-Authority-Analysis: v=2.4 cv=fPA53Yae c=1 sm=1 tr=0 ts=68593257 cx=c_pps a=YHWiV09CJk0981YzTF1Uqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=AYA3gK0pO6yth9NTz40A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: Ca4ZFCn1xZwap3axcc9Rd09EIzPvs5Em
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2NCBTYWx0ZWRfX0su0l1LgIC+I h85ox4ZMCXxvsoy4vB8UWOlgpxj+qT1ezCRlfL/TlyP+KJ9BbpAPu2LNFNXf2QmDXCR1iqBEtOF PnKjitlAuIIFYTVbMkLZNCVFGf1DDFLn69+zBAqWvXBWkSMduzCBSSuv/DPfk0fa8txsv6AwZRN
 wS6ChLA25tPZnxvcCz3jcIimREAxvs5lPMQCNWUIk4KriNRSamcaxEFu6XxIxndhmuhbGzqY0Pu qLGsUsNV5wBbSRZMzHb1UXFlynHMhLsFG5KFS2ylKn7KLuI2ksL525dK/QbIYGi1iFvUNhStiFj FVh8JS+pWdboxZn0Puhb8e3H5OR7YZIG/jop9qvmSOm7QnI3pG9K9ajD9ISnUNT12w7QB4c7x8S
 tPzpmdNivrG/smMBws8yKVqFSaw8r/pWb9SdEgnA/VhZGhPsy0ECsaIFxkjEq8jqfZB8XIKf
X-Proofpoint-GUID: Ca4ZFCn1xZwap3axcc9Rd09EIzPvs5Em
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=771 malwarescore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230064

>
>
>On 25-06-23 05:51:08, Pawel Laszczak wrote:
>> >On 25-06-20 08:23:12, Pawel Laszczak wrote:
>> >> The SSP2 controller has extra endpoint state preserve bit (ESP)
>> >> which setting causes that endpoint state will be preserved during
>> >> Halt Endpoint command. It is used only for EP0.
>> >> Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
>> >> failed.
>> >> Setting this bit doesn't have any impact for SSP controller.
>> >>
>> >> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> >> USBSSP DRD Driver")
>> >> cc: stable@vger.kernel.org
>> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> >> ---
>> >> Changelog:
>> >> v3:
>> >> - removed else {}
>> >>
>> >> v2:
>> >> - removed some typos
>> >> - added pep variable initialization
>> >> - updated TRB_ESP description
>> >>
>> >>  drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
>> >>  drivers/usb/cdns3/cdnsp-ep0.c    | 18 +++++++++++++++---
>> >>  drivers/usb/cdns3/cdnsp-gadget.h |  6 ++++++
>> >>  drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
>> >>  4 files changed, 26 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-debug.h
>> >> b/drivers/usb/cdns3/cdnsp-debug.h index cd138acdcce1..86860686d836
>> >> 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-debug.h
>> >> +++ b/drivers/usb/cdns3/cdnsp-debug.h
>> >> @@ -327,12 +327,13 @@ static inline const char
>> >> *cdnsp_decode_trb(char
>> >*str, size_t size, u32 field0,
>> >>  	case TRB_RESET_EP:
>> >>  	case TRB_HALT_ENDPOINT:
>> >>  		ret =3D scnprintf(str, size,
>> >> -				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags
>> >%c",
>> >> +				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags
>> >%c %c",
>> >>  				cdnsp_trb_type_string(type),
>> >>  				ep_num, ep_id % 2 ? "out" : "in",
>> >>  				TRB_TO_EP_INDEX(field3), field1, field0,
>> >>  				TRB_TO_SLOT_ID(field3),
>> >> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> >> +				field3 & TRB_CYCLE ? 'C' : 'c',
>> >> +				field3 & TRB_ESP ? 'P' : 'p');
>> >>  		break;
>> >>  	case TRB_STOP_RING:
>> >>  		ret =3D scnprintf(str, size,
>> >> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c
>> >> b/drivers/usb/cdns3/cdnsp-ep0.c index f317d3c84781..5cd9b898ce97
>> >> 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-ep0.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
>> >> @@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct
>> >> cdnsp_device *pdev,  void cdnsp_setup_analyze(struct cdnsp_device
>> >> *pdev)  {
>> >>  	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
>> >> +	struct cdnsp_ep *pep;
>> >>  	int ret =3D -EINVAL;
>> >>  	u16 len;
>> >>
>> >> @@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device
>> >*pdev)
>> >>  		goto out;
>> >>  	}
>> >>
>> >> +	pep =3D &pdev->eps[0];
>> >> +
>> >>  	/* Restore the ep0 to Stopped/Running state. */
>> >> -	if (pdev->eps[0].ep_state & EP_HALTED) {
>> >> -		trace_cdnsp_ep0_halted("Restore to normal state");
>> >> -		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
>> >> +	if (pep->ep_state & EP_HALTED) {
>> >> +		if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_HALTED)
>> >> +			cdnsp_halt_endpoint(pdev, pep, 0);
>
>You mean above is only called for SSP? And below two lines needs to be exe=
cuted
>no matter cdnsp_halt_endpoint(pdev, pep, 0) is called?

The answer is "yes" for both your questions.

>
>pep->ep_state &=3D ~EP_HALTED;
>pep->ep_state |=3D EP_STOPPED;
>
>If it is the case, I am okay with this patch.
>
>Peter
>
>> >> +
>> >> +		/*
>> >> +		 * Halt Endpoint Command for SSP2 for ep0 preserve current
>> >> +		 * endpoint state and driver has to synchronize the
>> >> +		 * software endpoint state with endpoint output context
>> >> +		 * state.
>> >> +		 */
>> >> +		pep->ep_state &=3D ~EP_HALTED;
>> >> +		pep->ep_state |=3D EP_STOPPED;
>> >
>> >You do not reset endpoint by calling clear_halt, could we change
>> >ep_state directly?
>>
>> It's only "software" endpoint state and this code is related only with e=
p0.
>> For SSP2 the state in pep->out_ctx - "hardware" endpoint state in this
>> place will be in EP_STATE_STOPPED but "software" pep->ep_state will be
>> EP_HALTED.
>> Driver only synchronizes pep->ep_state with this included in pep->out_ct=
x.
>>
>> For SSP the state in pep->out_ctx - "hardware" endpoint state in this
>> please will be in EP_STATE_HALTED, and "software" pep->ep_state will
>> be EP_HALTED. For SSP driver will call cdnsp_halt_endpoint in which it
>> changes the "hardware" and  "software" endpoint state to
>> EP_STOPPED/EP_STATE_STOPPED.
>>
>> So for SSP the extra code:
>> 		pep->ep_state &=3D ~EP_HALTED;
>> 		pep->ep_state |=3D EP_STOPPED;
>> will not change anything
>>
>> Pawel
>>
>> >
>> >Peter
>> >>  	}
>> >>
>> >>  	/*
>> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
>> >> b/drivers/usb/cdns3/cdnsp-gadget.h
>> >> index 2afa3e558f85..a91cca509db0 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> >> @@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
>> >>  #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31,
>> >16))
>> >>  #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
>> >>
>> >> +/*
>> >> + * Halt Endpoint Command TRB field.
>> >> + * The ESP bit only exists in the SSP2 controller.
>> >> + */
>> >> +#define TRB_ESP				BIT(9)
>> >> +
>> >>  /* Link TRB specific fields. */
>> >>  #define TRB_TC				BIT(1)
>> >>
>> >> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>> >> b/drivers/usb/cdns3/cdnsp-ring.c index fd06cb85c4ea..d397d28efc6e
>> >> 100644
>> >> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> >> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> >> @@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct
>> >> cdnsp_device *pdev, unsigned int ep_index)  {
>> >>  	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT)
>> >|
>> >>  			    SLOT_ID_FOR_TRB(pdev->slot_id) |
>> >> -			    EP_ID_FOR_TRB(ep_index));
>> >> +			    EP_ID_FOR_TRB(ep_index) |
>> >> +			    (!ep_index ? TRB_ESP : 0));
>> >>  }
>> >>
>> >>  void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int
>> >> intf_num)
>> >> --
>> >> 2.43.0
>> >>
>> >
>> >--
>> >
>> >Best regards,
>> >Peter
>
>--
>
>Best regards,
>Peter

