Return-Path: <stable+bounces-238168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IHJM7LF32kmYwAAu9opvQ
	(envelope-from <stable+bounces-238168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:06:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF547406A0C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC672311D8F2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605373E2760;
	Wed, 15 Apr 2026 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mQKETfE1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8505221275;
	Wed, 15 Apr 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272371; cv=fail; b=cC4ARWzsMhCNhjOgI0pYCmyhRb0+iK+3FGRPooxSsj6L9Xngyqr+OYDOUakSOsaJNMPVTvdCUwVDm2ZHduSHxvddDIhkW7uR/rJtGXItv+TOFW4WTksNm37lAuQcQvE7tW3zkhcnU0HIlAi1UHQtABP5YPcwPHqt72v2LS+dhy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272371; c=relaxed/simple;
	bh=rE37cAPUp5PTZR4ytJ+iyPIcwJe77hUXi/Aq+xcetqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YDwXsojpq5+T2/qh9sIkmsBDUXEH8FVCOMyatKoJaKBUxhKzQx1O0vKssMtA3G7SmjP6bWMEALnzrLSfqdNmUyONHC4giso1vdT2iIY9Be8aoVuA6gvHw3gs7JmB45bevEvazNOceiEHfrv3yd10EgBavYwLNF8TRHITi5zJlDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mQKETfE1; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FGx11A2623191;
	Wed, 15 Apr 2026 16:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=xl
	vpyYjJ0JvMj3NPNx8GkCaICbF+O417Mk9tKRj1DbU=; b=mQKETfE1cvXpCdcQCI
	gc/T6PFsQHshox/FYq/tsmPmcK+CO2zjRlJ6a3GU+F9VMcFMGRS5xA7g80R4kEs1
	u+swV1g4PXAcUFHPs4c1N32bdMa0vvacZltvPoHGkhXF0nxDvm0Q23aJhwfeoavf
	KYyPous4Tthdr8OelhwHMEd6Wuynj/yNDLugEttf6uZ/H+U+nQPgMhzTUdTAuMlA
	Y8eINEByOaBXCUfpMdJtNJfHWuuP9Yg+/7YIZCQbopTZOONlt1NqSkTgq5VGTPTB
	QcX98qoLliEUg/BnAqe97nGT56b0pHkFT5FdViOciUNHMsXpe/CTvykIsSnZzf4o
	L/6A==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4djep20064-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 16:59:25 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C1746801709;
	Wed, 15 Apr 2026 16:59:24 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:11 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 04:59:10 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 15 Apr 2026 04:59:10 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 04:59:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2S6JRUaop2dIHaEpyI9OKXVYnwRclIfQSHCigQj9ChbflgcFrdKeZ0MyP3IEzzhp0TpaYvs4HsCIS5PCXH973rFoftxWVyAipksYO/VHxWwSEW8meiBvzEHEyWlWfNUXHtmJ5bpMBk3czc2pCzHN8RKau2pzVbRY08WN5RxdAa1jU8AIZFqLqfzSvbq5S8r+OWtCID1269ogQysYQmqeAgTsAAuxRQ1CwriU5J8E2OsGEy0gZlZAIMWSfO0iL+yrqijxpyzdeUpNGLQsaa/Fzr5YtZsWYOxykgWFTBJYkD3SYNScQGeDxWsSH6kHcQJqbop47g5YnlWRRulSQb4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlvpyYjJ0JvMj3NPNx8GkCaICbF+O417Mk9tKRj1DbU=;
 b=q+m2JJQeq3euO1Acov99uzHL1d3gD0oUQq5kWHRma0lQ6QW1JC4pRAvj92+AjZmq6E6vMXxY7k/ICHipxu0fiJzhOFxKTqirQlw9LRoAD7/tZ8WCkIM0gYLZ/cBFSyhJn5LpzOZ5pDQzyfSbaDHEY8JMSp5diCxI5GQSfcOYYufmHcNz8Vyh8FRJv/d7lQiGfrE555iWmfVxat5/cuv/Z/bKRbiE2AABYqmThjVLuF+xW8YrIowoZV51GJTgIVBzaPV3tQ/N+GyQ42OtqbfPKUoivzo3WN/oUSd8FJSb4GiG/qOpO57/Yx/UEjpSaWS5GkD2sQBfUFQSNVnTqbElcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CYXPR84MB3514.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 16:59:05 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 16:59:04 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@axentia.se>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/4] i2c: muxes: pca954x: free parent IRQ before dismantling
 IRQ domain
Thread-Topic: [PATCH 2/4] i2c: muxes: pca954x: free parent IRQ before
 dismantling IRQ domain
Thread-Index: AQHczPkq4kMPupvw/kWhhrTUsIVZoQ==
Date: Wed, 15 Apr 2026 16:59:04 +0000
Message-ID: <20260415165846.43926-3-sanman.pradhan@hpe.com>
References: <20260415165846.43926-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260415165846.43926-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CYXPR84MB3514:EE_
x-ms-office365-filtering-correlation-id: 98e6e178-a8bc-44b1-8ae1-08de9b104cbd
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: vFrSwBxUMQRzCi26guElPzBHYOq6yAOzSCNM+RhA1TE4baEynFfhGU0v+Ml+C5mZtRSKStxlukNPb7gkFZc9NGRg3bCAX4RUe7Y4o+452YWuqT4jH7fAxvgdOQ9rjii9GsTYkoxu51KkcPyYqefB4FZ6x833S/oX5O9MLyVeO8VcUtO+OPdfXFzQW1915Thax5Q9GadEz3x3eWI6gC31egZERml+Lgxm28wXKC/fcqSHhrWP0gGKzowQjDyUTsAPu+mAoC4/PKL/Lqg7g7Z5S3YsQyUWQ192vX6ZG8CEmRuG3gr6FLwk+ns7r3QYoPGLpSRRBScvVOOH+jwqL+pH9zWnV3GKQcJQokEEhvRsufyqVykbXQCrLJQ9ruWgGdyl69YrAgx8Ga3JY8w6kM5m/dTmCRWoJf61xRPZm+B3aUyu4Ry+yOLMsrL5k1/eYRcQ9wtNiKTzTw1m3Jc/V6pl3iZOE8YPgdPLzvlCl7e83fffls8Sd6SiB7LgBgK0v3h3CrR0VdR/vyo4pQMfH1MOlXxbM+G8nBGXt8JC2aOBcxl645P5p8FVOzN/qXURdAh/SZMyzPToL2YlrHyoxn5JzkDrU73H0BIBxAG2Rb/5OC0/eOnUz3SfjE8aiLwjoWKcSFYueGUIeGh66DyIyvLRNP9saizMPpOZKpKNl370m+vcm7lrj4AUYF3CEoRwULJ0dAW0g9t0OErbbKZ+E6ri1jwte2FpqA7oTMLngl9iYPiJVIY2dOWQv7G2At8hRPUt3RhL6sAe7xSQCf8tZ8Z+Yi4fuY9JNplyk72XCjvcjLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?21ckVKYz8b9Rsv6o/NnqaD9a+zvoaVhCu/3wIED87NuatC9s+6ETct5KMX?=
 =?iso-8859-1?Q?+EXVIs74uZbP54MFpJHjuA71dmtru/78mGUMK/OGL7rC4j+TrGCcXA/hIa?=
 =?iso-8859-1?Q?2ZySbpsDrLdajJ5NTw4RyFQdjLRYDT+173hRm5sIHrDKx2g9P8eb2940Dz?=
 =?iso-8859-1?Q?0Nfs+Y8vyfclWBAGAtFsnWaap80QurrXRG+bWs403yius8S8L0W1tiG34U?=
 =?iso-8859-1?Q?bhbyLDzpDaSeYSkkCnuhkg5cc0UB+/cl8sSD7mXa/NyV/XGSR6yHmswMi4?=
 =?iso-8859-1?Q?i5uOptRDQXwOziB5uVZHG5RbmHI17lr3nuesEajTU+LQOfGv6iCenR3/iU?=
 =?iso-8859-1?Q?4kqVvzvGuWMtNWJuTUZg31BtyrpWQHW//pFu8CP8mqwTH70LyKb63Dqyou?=
 =?iso-8859-1?Q?FqQfBpUpgfxtNvaVytmRgJmM5ZuqNnUJe3jURyp/qfsG2IBVBO+8DTXpjA?=
 =?iso-8859-1?Q?w/kARjGoYPrYZ1FmSpxWCRy89rQFGzXiVyBhtQBsJNKRqV5ablW1pwy71Q?=
 =?iso-8859-1?Q?bfCGU2CcECw0sBD7rhn16FqbToIeDZJ4e56Fk2Vvwjc18Fqt2WIoVkcytT?=
 =?iso-8859-1?Q?q/mVT7VDzhgiKeXkZFhcRR0eD68A0OkRyC8WHgoPuO/R6x7lp8XhRPMto+?=
 =?iso-8859-1?Q?WwWVdgL5iHYR9p7SK8y0X6Rj+Ve/Oi62FCHW2kX+VqkLegBnmiPYFzeLDe?=
 =?iso-8859-1?Q?il7XSIjFIBGMpBgjqNRkKej2x79nWeRAHFmzi5TISnmiGiO171cucmUoZ2?=
 =?iso-8859-1?Q?/GzXR4WCFsSB1ZKdwL5H4+xEdlvqtNbyxPx6/T/Z2grFe+cTkNJpGXOxcJ?=
 =?iso-8859-1?Q?cIWEXIUk3m+LlyYdOZXhtWZIRWA86VROgaTmvOnJnsWxtz6rYFzfUkLNLP?=
 =?iso-8859-1?Q?oc+pFJ+GN9TNc84n4ef3KjYR9LfnuraY9srkvzKWGLbwzYZfsvm5cU0+a4?=
 =?iso-8859-1?Q?iENIsIymUfnlUTO1j30B/JAZx4/YPS1C+W5nC8Q8Z9IH4zVbUtNycB6bSu?=
 =?iso-8859-1?Q?pz+wqfWQUG9spafqCf58e23DBVyJOoS+Nizadsq4jfebDfQ4PnRrqKHcjn?=
 =?iso-8859-1?Q?ywuUb42ULMDJj4kZNQu3b/HYeP76YaF0upjNRrZUujBDcg47r/PVlueDrK?=
 =?iso-8859-1?Q?UZLMxVyuYwH8i1RDNHh2A32bPO4gL3d7HZfNuueFkvgY0YUrXsmPWruJvu?=
 =?iso-8859-1?Q?0bXQMFRhW+lviBO8Td+D/RXc61CNgDfsGiIbyAv6i/IDyO4VZbHolzTaHX?=
 =?iso-8859-1?Q?NRzp/PMbKL7+rf+Bz/2tCyqc5AVurHBJpuu7pHcIygkgj3w7p2Q4kV2jsB?=
 =?iso-8859-1?Q?K6i8LAGlyphhGcGZ59jWHlSgGv6DrJly8tpemjhk9FA+nai5KsOAnf93u1?=
 =?iso-8859-1?Q?Sl/4WN/V8dXDg2D3dAKL0o8l7RMpmQFSeU+eE0Juse1EBZu7cS/D88pqHa?=
 =?iso-8859-1?Q?eAcNH4KBWaz5vWTOOy/Y5+5LhAe3eMowVQ77bXFhYR8Cx50EKXPpleqZbv?=
 =?iso-8859-1?Q?zsiA8nGWoo2vtTGXYBxJV/FkIEP7EFs86soYOXEc7u4IayWehhr8t7GpRm?=
 =?iso-8859-1?Q?y2IMkcead8IW0KDjiagxf1inQgD8+E9NQec/x44tPvAmLL9/U079rad7oC?=
 =?iso-8859-1?Q?4sm3qNr8EPODUVg8H4VL4eZskI7RQC+urjqUexneyBDxzExwHjcgd79kEc?=
 =?iso-8859-1?Q?ALCFJ6m9bZGmAgyr80Mamf4CQHmXYwYG+8Ltei2hZMhT/+06Xc1SFpj8T+?=
 =?iso-8859-1?Q?19J74wUTWFSujJnLtQROLooT0YPsMQoDscKiYRdv6vGZ0UDEuPe2lthI0o?=
 =?iso-8859-1?Q?H9R2vH9fZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jAdwCi6L9B5zYfwdVTQgVfltRLOmHAe5EZ9RlGP3CGOluK4ESdFQm0kssaivVjGg+UYjIWrJ0OweD/t+hcJWynRyE0rRYCBvlgyMrHRXSumo+j4F6Os7TrA6Fd/YyGsiQ1ShBUMdLFTpA+mJASAddrno6fEh1QFIhaSGfSClmUiP/Kx31VW+s+iCjFZ/o2JBVXJyLB5TWfln5+MdxRkl9+lkyG+0ROPUeTTVGM/FYE8EMOGJBhVP638Vr2aNF7JUWzlUcJHqVJPId27Vf5tq5oCWSN2GTZKcL3ejhrHF21W5ulm6MM3EIudvn4V7zj+rXcCkRZUtWmPngdipXVnT7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e6e178-a8bc-44b1-8ae1-08de9b104cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 16:59:04.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NNxewAAUG3krDoCt1Bn6U/aOvrDbum0Fu3z3eqdW5dlKNYmqnicXx/Agdo48evKP78RlEZmvqanwK68mvUJiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3514
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1OCBTYWx0ZWRfXygPqKwyzhy3B
 yH8+f+aHWKMkpGhmscbEo4zC2SAmQRGCR5n8hJBk+yqb+tyfNEraTCJ9njZdVu6618A5tGFANtL
 8A9zIKix9ebvOjKLgvv/2yD3LppHEiLbjIkJCjMLYpkp66US2zBZ5GbpMG54f3PKFD/MRrQRQEU
 gRFiIxMISu/E5rsx76E0xpdijMmDxP385sqH3oDnCfvdI1QWz12KQ6UiBHubQOWCJbgd5B2UdY7
 ga34LlNZmFKR4oDfp+E5QR8rxGaTOyhDYh/qY2TebQ1c2PQyBVTKARKWiljyEcksoGSFAPgiOmX
 GroVrsZqN5iabPkPqk+ab6/lBih3s0fuM32850skOal9AhDcCkjrbAyYsrz5LEJsgEDvV3v1Acw
 tp0D18/IyZvtSk/2UBsBIBUB2IEHYmPLWkrLd/oi3SGUZGmUc43AQeYxLv5ut5lk/XCThk63HxA
 qarxGYJ/Dz1WfJ4567w==
X-Proofpoint-GUID: 0vjwzT8MSfR3sXNHE1bCDFOIiUdTRHsx
X-Proofpoint-ORIG-GUID: 0vjwzT8MSfR3sXNHE1bCDFOIiUdTRHsx
X-Authority-Analysis: v=2.4 cv=ULvt2ify c=1 sm=1 tr=0 ts=69dfc3ed cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=JZ2yvfJWe_Hq7QC4bgAA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150158
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238168-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,juniper.net:email]
X-Rspamd-Queue-Id: AF547406A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The parent IRQ is registered via devm_request_threaded_irq() in=0A=
probe, so it is not released until after .remove() returns via devm=0A=
cleanup.  However, pca954x_cleanup() tears down the IRQ domain and=0A=
disposes the mappings during .remove().=0A=
=0A=
The threaded IRQ handler reads the mux over SMBus and dispatches=0A=
nested child IRQs via handle_nested_irq(irq_find_mapping(data->irq, i)).=0A=
If the handler fires while child adapters are being removed or after=0A=
the domain has been torn down, it operates on stale state.=0A=
=0A=
Call devm_free_irq() explicitly before removing child adapters and=0A=
tearing down the IRQ domain so the handler is fully quiesced first.=0A=
=0A=
pca954x_cleanup() is also used as the probe error-unwind path.  The=0A=
IRQ domain is created by pca954x_irq_setup() before the parent IRQ is=0A=
requested, so on mid-probe failures data->irq is non-NULL while no=0A=
managed IRQ resource exists yet.  Track whether the parent IRQ was=0A=
successfully requested and only call devm_free_irq() when that is the=0A=
case.=0A=
=0A=
Fixes: f2114795f721 ("i2c: mux: pca954x: Add interrupt controller support")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/i2c/muxes/i2c-mux-pca954x.c | 8 ++++++++=0A=
 1 file changed, 8 insertions(+)=0A=
=0A=
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mu=
x-pca954x.c=0A=
index f0b8879ae5fa..c20a161e6a5b 100644=0A=
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c=0A=
@@ -116,6 +116,7 @@ struct pca954x {=0A=
 	struct irq_domain *irq;=0A=
 	unsigned int irq_mask;=0A=
 	raw_spinlock_t lock;=0A=
+	bool irq_requested;=0A=
 	struct regulator *supply;=0A=
 =0A=
 	struct gpio_desc *reset_gpio;=0A=
@@ -464,8 +465,14 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc=
)=0A=
 static void pca954x_cleanup(struct i2c_mux_core *muxc)=0A=
 {=0A=
 	struct pca954x *data =3D i2c_mux_priv(muxc);=0A=
+	struct i2c_client *client =3D data->client;=0A=
 	int c, irq;=0A=
 =0A=
+	if (data->irq && data->irq_requested) {=0A=
+		devm_free_irq(&client->dev, client->irq, data);=0A=
+		data->irq_requested =3D false;=0A=
+	}=0A=
+=0A=
 	i2c_mux_del_adapters(muxc);=0A=
 =0A=
 	if (data->irq) {=0A=
@@ -656,6 +663,7 @@ static int pca954x_probe(struct i2c_client *client)=0A=
 						"pca954x", data);=0A=
 		if (ret)=0A=
 			goto fail_cleanup;=0A=
+		data->irq_requested =3D true;=0A=
 	}=0A=
 =0A=
 	/*=0A=
-- =0A=
2.34.1=0A=
=0A=

