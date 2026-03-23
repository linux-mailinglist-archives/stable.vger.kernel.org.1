Return-Path: <stable+bounces-230028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB4bNi/OwWnhWwQAu9opvQ
	(envelope-from <stable+bounces-230028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:35:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491422FF014
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD48F3038F35
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C851DF248;
	Mon, 23 Mar 2026 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="XP3acNVx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD4358369;
	Mon, 23 Mar 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308842; cv=fail; b=i2XXg97yzISJScQubqDgy3d4Idc3BfVnqsNe4gdxlx8SDQjvT0/cNBrAhcdmuT07q03rcteV8OcOOUDIngbnQFpI0mwK/3OhF/GymFrEeEo2sW7ejYuizmMKxrPk0BBWAY8MWhLVhKk2dn5yJ+6uuS5INg1gjWSbuAKEN/XCSrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308842; c=relaxed/simple;
	bh=dHWqtS+HjNl7Agc459uLUp0pD1T7tVxygq19bCNT2kY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYx0DTmiQgJotH2aLlSxZKheIpiLiD7erYe3aEejD+ixFNI9forBLnvteHHaDg6Z5WAfNoL9t7h2Egowt41yBSnBWhk96epExOoRML21DJCcgXboa/7mkgVxcHsJba5PatCGdic+tWS43F3YoPp5C/uWo9dKxLITrlimtqAet8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=XP3acNVx; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NKWQeo3517418;
	Mon, 23 Mar 2026 23:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Cy
	QJPr19obw+MgOTg7ug+edPvTj76IzXAE7xfJQqAjA=; b=XP3acNVxIKoUG9vt9Z
	kMkHhVvwjVq1PKVuE3HXn+3xlPyLyNqlFCfqx2Nq+jXuYfJia3EMIGNC0m2QvyC3
	nPQoF3TCg+2FIgYwh/Z2jtQZd0695JjE+SK2QKBw/LLhhVNnwV5dwd6M9Zs1U4q/
	0Yhgw1VBxswSNW4lpUXMopNFWHch6AhHJuHBu9NH8cDiOMKpJ5kI8Dckg+mdoeXs
	GiAWEJheb6+ntmcpaxdwygmk609IuLktL80cZSCA+GKPPqo2HsYSc/zhToN2R/1b
	SfO3BeCDDwU6rYTPut7vn5RSi+OYJLtxy2ExDIHfhCqG8NZPsZelay4u5RroYvU5
	mRAQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d3aaxk72e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 23:33:45 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 88ED48014D4;
	Mon, 23 Mar 2026 23:33:44 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:33:39 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 11:33:39 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 11:33:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyC1SR32KrQbdI3eapXjhAfSEY1cOQRB5NQtW43QWAcFnMpRmt44iBobeYxRCXG+8eS52065U9pzTIgm5QZEsdq0aM+7RTwo6XviCe5y7+4zKRf/nPL6buBbfqCx3KYnokRMtUgTslbblmKQg24U0xVBUo8lIznNRd4qgCfpthaHG8UcsABzW/M/AI+H+zV26bYUy81QsPxT6Rtuod1DFy0L/bEoxN2sscf7kQfSWGStwIGiAdhqqlZL15l1Ey8Mbh3WNsutvRqosFaCKKMRLR4qah7H6JiTqoc/sfOThZD/R5z4LPXhkio5CZNPgtumauShFs8iEWYdFR7kRj19kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyQJPr19obw+MgOTg7ug+edPvTj76IzXAE7xfJQqAjA=;
 b=QR+r4Ij1K/WdpsnVG8tVbDTcIx+z1LVGD14Kq8Q1XpzwrFchAdeecRtu7BWQopKYF6TeKzpSi/JBY+Rg1Tj0R91iBk+qXPj1p93d5Lw1M1AkZV+ZMBM7rSqjCf7w6szTD8D78hyOlyYCn8XCC0fU7jDy8bd5ysrxb6OOmYNWIDnb12gPfnpLZYVVY9oPhmkMz0of88UWUZgx/5R5PxlgSmxcYVKzYxuu4sWZbPL2rBugrM4U1ib8YYs+cEZp6mhQydLTj4URQ7XZ/DTzUuTZIFxPVjzaMZZw98KOLIFQ3iiGtuCsU1cZuJ2dZ1Kv6IoZSbjl2pm0328Ik8tzBmWDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CH3PR84MB3989.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 23:33:38 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 23:33:38 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "wenswang@yeah.net"
	<wenswang@yeah.net>,
        "chou.cosmo@gmail.com" <chou.cosmo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/5] hwmon: (pmbus) Use -ENODATA for unhandled registers in
 MPS drivers
Thread-Topic: [PATCH v2 1/5] hwmon: (pmbus) Use -ENODATA for unhandled
 registers in MPS drivers
Thread-Index: AQHcux157VDv6jEWdUanbqBDRn8c6g==
Date: Mon, 23 Mar 2026 23:33:37 +0000
Message-ID: <20260323233244.201294-2-sanman.pradhan@hpe.com>
References: <20260323233244.201294-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323233244.201294-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CH3PR84MB3989:EE_
x-ms-office365-filtering-correlation-id: f50be8ff-0aa1-457c-4389-08de89349bde
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Pli4jQCSxfPaFyXBJoJ17B4WbxiIdQ9Y9mJgOvGrepe1PtxmBW2Ksq7gle4R+4zLf4yp/Fx0h6K2ODnC8yeLEcL7TU5jG3qe4sBDXAMKx3ojttji/e3g/DzPwZSraqyJ3yh2vfiNv08e2p1ozGSxMde/LRBreSmwAK0Kjrs1AYpORxpOf4PFLmR7q60UwFcI7Bznwqh0yNrtnMbQqP/MyHBXwJKLTC0LP6cwkQyS7hdBbttdpuGcJS7CFaI6qEnf5dS/YMbXQqTfVAq+0NdmScZtNvL0PXQUZQ2XIraXTtKDGLsRLihzKS1/PJPWLu7bcPqbSwn75WMtcBRoff+mUZG7cEs5fY3D25HWmx+F9k4E9mzxoUaUTETwiaSHrNGILM9m1E2RcyB9OwSduTiNLtIJVK7pLaz41uwwLMMV3luj4za5eGvx6l0E/PHJjDGYtSw3fGoJbHdtji4xUSY19R+pLvn8IK61ICx/z+k1RMSNoFMGbuQFxDj6jltCSie52yEaJU6KNWRV+xVNu+tcAvN1NCKUPgwmY65d8tsA2ogNXR8/XtQ4ael/SEL/emCvRtZf+pVYlNPPqXw2FQFFZTvIAkL/V9JECPz6uFbRKagn5uFmXmYZOXV4qBUIIQeE+W84mnno0tqz9I8k3AP2FncHn1/6BCTs6D5lGw41DJP56u8FjO9kTainGCiNc7tShuhXLzJdATrtKzR2XiwzCu5AClUbY+kugD1m+iBMXulpJ9Y69JxcXguXGlOADiGs3LG8AeMD0nE7M2rdxsRt3xMttDEsn6Ds1PVczp9RYfc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rwzxu8rhvpbIlR0xTCASgmV9aPb2KAAImXpS2e9TjDUdVtrmIqQVfQeERv?=
 =?iso-8859-1?Q?466Skaq2coI5ptHsydw9US2g6AfrBlLP5Z45sjyh29Rfnb8chVKMnIuhJQ?=
 =?iso-8859-1?Q?HWjbv2Sx1+UN3aTEDh+cU2qxiO8MFQCJcCcVpFB781Ly+GTQMqfUzg3BK9?=
 =?iso-8859-1?Q?H+/62yq5btYeVCiKUlyoh56HDZp6C2N5SCgOGVdYCfH7aGrDoN39ttKYmB?=
 =?iso-8859-1?Q?X2eom6r4Y7W+qbbsUUxIkldO3y7MNpA3JRrVSAziP7J7UIVM3yTGJOOFhB?=
 =?iso-8859-1?Q?78jX5niYQKf6ei8DNNV9XkCAUcxNgXcqDZ0VWKYpVV88Ne8SGeWyH6Z86h?=
 =?iso-8859-1?Q?cV+tqZWlVP6qt9/wItvsSMWGf+UiB8U8aBK7/ii8sZCxMCSIz1lVGRI8YT?=
 =?iso-8859-1?Q?ZEbyK2z91yAW6UyWbjJyxeklYul7I7LrC/+6GdgsyPQRZdiJPuUKkbdWTK?=
 =?iso-8859-1?Q?xa/b+/TeN5c0caM0b1CCe1LOIjtn92yQa3UTkO2KDPb624lR5JE3ITcc+N?=
 =?iso-8859-1?Q?tItNrcPcN66rpw+80YOzCNvp0Ur3fRXfRCjFtMjc6wmFISgtn2SOaHBWeB?=
 =?iso-8859-1?Q?2Lyv8jPy8qdfTVW3JDPHy1ZAHvg1ZuAaL2Ki8Ol0on7BtCn5W9rCHgIN/b?=
 =?iso-8859-1?Q?JGkEd+qJXITrt5RNbve8hR4jv5o4U0pfNSPabFXY84748uN8HsGaCpUJlg?=
 =?iso-8859-1?Q?9NCcyJZy5ceIp9kmlhJ3DHsjy81DutHT0nKZxGQAOHTkg0RZ6Ewt7JNAdf?=
 =?iso-8859-1?Q?A1+MvY3/OP7TuN6bvOkdKSBvYFwxMF3qWGz9auivLqcTN5U2FqEYaaN+Js?=
 =?iso-8859-1?Q?1iqoJa/vswPUNDbsLGX2OyGxB0N72ts6fFyhjb/4CROlogEWg5uk+av1P8?=
 =?iso-8859-1?Q?y+JTlTHO7sQ3QQe650Ifcfp/cJ+f76wUdWabzu56O4jTynTNcf0vfAP8dM?=
 =?iso-8859-1?Q?PvW1oVbHIq4PYI9At1ZGfprxgvG7sWHJAVNwS2pLnhchCRpyfQ+WF9oGjn?=
 =?iso-8859-1?Q?LrrpL5d/30Nq9n4YwWDe2f6m4Qo9A8jM0c/qszI0/z6i8iI0fE/hBdqt0l?=
 =?iso-8859-1?Q?8mmy+A85H0SH/noX4qqFCiCGKZxzWTBiCzF2bUM3vOhdpmYVLKdIgSwNBK?=
 =?iso-8859-1?Q?Bxf6QMV8b6GIQhxehvuLghblt3onE+0ifs6rn3/mXb71q4twXnRYBNWx/F?=
 =?iso-8859-1?Q?ctTLjqFL3dOblZWYPNOwLINIwiDQ2tdJtOCnw8NTOahBp6BmGY//rB5Ap+?=
 =?iso-8859-1?Q?Dup9xw5bTGRCrCFkd723lWwbCsx10AA3Rg1/Yy0GHAiKyqMaD/wSdYAkaA?=
 =?iso-8859-1?Q?v6RcDNB8rkg4MxJ052bz9soEbgHz9CLC6NdVTpzkZ8rlQMOQgeInZiG10b?=
 =?iso-8859-1?Q?RNWuKkHklrloslo9xeYBED/TH7NTzAXMkuhlZ7C6m+tWm5aZ0bAv1E/X1q?=
 =?iso-8859-1?Q?yVzDQd0/m3Tv+1xCiNM72EITX4iBr66ik+WISjFzXmi2doP9bz1hiz7K17?=
 =?iso-8859-1?Q?wU6t+iNKEJdPPDLO814lNRDBs2w1UGs6+8u4Lk/2+jgUQk8pMndjtkwuDs?=
 =?iso-8859-1?Q?sbytnYL9tt0UZnGl/XL04JkMjirCQ2S/ki7uAMwSkC1v4N2CMo0uPb3r05?=
 =?iso-8859-1?Q?lW0J0xkMN3Z2N+VMDFY6DRbKmg2+pkN3Sf0VKMjagbC4STMkKRWGvpH6zx?=
 =?iso-8859-1?Q?xf3E4Z5MXktcRedgWvmk8GeqZKgy6KyZKm2/fyTDncsIR4DTLlxaXYsDiK?=
 =?iso-8859-1?Q?NF1EEongQKpN+NhwKBUehrB04nRzURUB+Fe6235I9EJrxR+nCMZfHWbZXw?=
 =?iso-8859-1?Q?wYYFixu+sQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ogeNtxAeWpR/xgD/n1pfibnwrN2vhxyQPOVTXpzgqJ9YCDShX6MLr7Voi76kEpkJ7xFIAdKfWyGNOPFX/XjmCaDj7Cb1hPsOJk55MkNgk0FK34aHlTB++MpWmXjAXQ/Ee3hnWncE41eteZ1PTsQycklvRwqILO3kFTFsvadsKfOUw6pS8WoLgTNbYYNnrZA96fHPLQc2tXVdo4SA0vJ4tQ2ZNJJfOyhJWpWOcbDdWPCdxf3e1td0fBKiEptHi1d3lxtu/NyPKEI5GZ6BLWv7RVwmwil2ThZ0LGTu1rlbrQrilWIHDWWZ8oQZy/vZnOpixN7SIjJB2q2fMgkunn148w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f50be8ff-0aa1-457c-4389-08de89349bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 23:33:37.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GA6ZyjNPjbD6Jr4hkpzpTPxrqr+KSARhdkfYBRhCKsFr6ZDzfSzpdd6RBWLXntuujhdbM+Eq7d9jHNIoBe0qiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3989
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: vR678OI3IC-Z4KiSfwzH18Nd8HodbQNi
X-Proofpoint-ORIG-GUID: vR678OI3IC-Z4KiSfwzH18Nd8HodbQNi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MyBTYWx0ZWRfX/x1/EOXUI805
 fJMDpGe2CxfaA0tWeStOgmVhHwFIyykkJael0yKTbbLEzt2R5/+zS1XF1Dz3hD93yUt+7n2UtiX
 GGpI4/ACZpZq7eMtv1A3w0UbRmgqG9Ay+UklQbORjgv1g/9jhdz+lohiv/LiBjpr0qALHdCdUfG
 AoHhQK+gWtBDCSJG+7c5UMuwhU0uFMz9pW7OY8BL6DL52jL8htBG40vTrHtuiWROEQhY9z4/C0m
 /M5JryWP8RG/ybaXuVq0w16ilDN/YeB38pPpC751mzgrLEJ3qXmCZ3zcWHDmOH9ufKbyPpq3qkc
 sPKteQBcmK/wEA30oGvf1fHx0Uc/ohQ9Ls74zDX6rAY8SenYnxoSgRjVD212WW9WfVJ73KkvQmH
 6qC1FzpoevMJ7texGRXR3ObKT3I/maajIAHGp2TEFjnGR1Fhqn73Qtix84J6U2U6c380t2WRUx9
 fCMVl/SH8F28fwr+NJA==
X-Authority-Analysis: v=2.4 cv=bqRBxUai c=1 sm=1 tr=0 ts=69c1cdd9 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=JAkN7oncqWJZiqCo4BEA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230173
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230028-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 491422FF014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
The read_word_data and write_word_data callbacks in mp2869, mp29502, and=0A=
mp2925 return -EINVAL for unhandled register addresses. In the PMBus core,=
=0A=
-ENODATA has a special meaning: it tells the core to fall through to the=0A=
standard PMBus register read/write path. Any other negative value (such=0A=
as -EINVAL) tells the core the register does not exist, causing valid=0A=
PMBus standard registers to be silently hidden.=0A=
=0A=
Replace -EINVAL with -ENODATA in the default case of all affected=0A=
read_word_data and write_word_data callbacks so that standard PMBus=0A=
registers not handled by the driver are properly served by the core.=0A=
=0A=
While at it, remove the explicit per-register -ENODATA cases in=0A=
mp2925_read_word_data() and the PMBUS_STATUS_WORD case in=0A=
mp29502_read_word_data() that are now redundant with the default.=0A=
=0A=
Returning -ENODATA lets the PMBus core handle standard PMBus registers=0A=
through its normal fallback path. In mp2925 and mp29502, the existing=0A=
explicit -ENODATA cases are folded into the default case, preserving the=0A=
intended fallback behavior while simplifying the callback logic.=0A=
=0A=
Fixes: a3a2923aaf7f ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series =
driver")=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Fixes: a79472e30be4 ("hwmon: Add MP2925 and MP2929 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
- Folded explicit per-register -ENODATA cases into the default case=0A=
  per feedback.=0A=
- Reworded the fallback rationale to describe the intended PMBus core=0A=
  behavior more precisely.=0A=
---=0A=
 drivers/hwmon/pmbus/mp2869.c  |  4 ++--=0A=
 drivers/hwmon/pmbus/mp2925.c  | 21 ++-------------------=0A=
 drivers/hwmon/pmbus/mp29502.c |  7 ++-----=0A=
 3 files changed, 6 insertions(+), 26 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp2869.c b/drivers/hwmon/pmbus/mp2869.c=0A=
index cc69a1e91dfe..4f8543801298 100644=0A=
--- a/drivers/hwmon/pmbus/mp2869.c=0A=
+++ b/drivers/hwmon/pmbus/mp2869.c=0A=
@@ -391,7 +391,7 @@ static int mp2869_read_word_data(struct i2c_client *cli=
ent, int page, int phase,=0A=
 		ret =3D (ret & GENMASK(7, 0)) * MP2869_POUT_OP_GAIN;=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -536,7 +536,7 @@ static int mp2869_write_word_data(struct i2c_client *cl=
ient, int page, int reg,=0A=
 								     MP2869_POUT_OP_GAIN)));=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
diff --git a/drivers/hwmon/pmbus/mp2925.c b/drivers/hwmon/pmbus/mp2925.c=0A=
index ad094842cf2d..570e343fdf24 100644=0A=
--- a/drivers/hwmon/pmbus/mp2925.c=0A=
+++ b/drivers/hwmon/pmbus/mp2925.c=0A=
@@ -114,25 +114,8 @@ static int mp2925_read_word_data(struct i2c_client *cl=
ient, int page, int phase,=0A=
 		ret =3D DIV_ROUND_CLOSEST((ret & GENMASK(11, 0)) * MP2925_VOUT_OVUV_UINT=
,=0A=
 					MP2925_VOUT_OVUV_DIV);=0A=
 		break;=0A=
-	case PMBUS_STATUS_WORD:=0A=
-	case PMBUS_READ_VIN:=0A=
-	case PMBUS_READ_IOUT:=0A=
-	case PMBUS_READ_POUT:=0A=
-	case PMBUS_READ_PIN:=0A=
-	case PMBUS_READ_IIN:=0A=
-	case PMBUS_READ_TEMPERATURE_1:=0A=
-	case PMBUS_VIN_OV_FAULT_LIMIT:=0A=
-	case PMBUS_VIN_OV_WARN_LIMIT:=0A=
-	case PMBUS_VIN_UV_WARN_LIMIT:=0A=
-	case PMBUS_VIN_UV_FAULT_LIMIT:=0A=
-	case PMBUS_IOUT_OC_FAULT_LIMIT:=0A=
-	case PMBUS_IOUT_OC_WARN_LIMIT:=0A=
-	case PMBUS_OT_FAULT_LIMIT:=0A=
-	case PMBUS_OT_WARN_LIMIT:=0A=
-		ret =3D -ENODATA;=0A=
-		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -203,7 +186,7 @@ static int mp2925_write_word_data(struct i2c_client *cl=
ient, int page, int reg,=0A=
 										 ret)));=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index 7241373f1557..aad4c57a0a2c 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -293,9 +293,6 @@ static int mp29502_read_word_data(struct i2c_client *cl=
ient, int page,=0A=
 	int ret;=0A=
 =0A=
 	switch (reg) {=0A=
-	case PMBUS_STATUS_WORD:=0A=
-		ret =3D -ENODATA;=0A=
-		break;=0A=
 	case PMBUS_READ_VIN:=0A=
 		/*=0A=
 		 * The MP29502 PMBUS_READ_VIN[10:0] is the vin value, the vin scale is=
=0A=
@@ -456,7 +453,7 @@ static int mp29502_read_word_data(struct i2c_client *cl=
ient, int page,=0A=
 		ret =3D (ret & GENMASK(7, 0)) - MP29502_TEMP_LIMIT_OFFSET;=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -555,7 +552,7 @@ static int mp29502_write_word_data(struct i2c_client *c=
lient, int page, int reg,=0A=
 						   word + MP29502_TEMP_LIMIT_OFFSET));=0A=
 		break;=0A=
 	default:=0A=
-		ret =3D -EINVAL;=0A=
+		ret =3D -ENODATA;=0A=
 		break;=0A=
 	}=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

