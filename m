Return-Path: <stable+bounces-237939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMY+M8153mkHEwAAu9opvQ
	(envelope-from <stable+bounces-237939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:30:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FC73FD180
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6019130071D7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7593D890F;
	Tue, 14 Apr 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="cxU4gzxw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBB24A078;
	Tue, 14 Apr 2026 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187849; cv=fail; b=W9bnDrGarXCd7METedkh3GO6AZaaYp9pcsiztL5WrUXzfsB2sRKOVIK7z3llqzLQwEYnGlKBK46QpfQfWeZTBszJy4NPlZ4mrHkXgp5iNqwI8MJw+0JXqR+vBqbsbms425NjFMUq93HP3sOEaA7/oZH+J0TEN1e7HhU6fRO3WdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187849; c=relaxed/simple;
	bh=ujtHzdcdqm9acKCItUVw0sQ0EuNWtGvNNwN6UZ8QvzU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PC21usdgjxpwmZ6R0ERnFim7p9oCERGEux51RPpsImC6E1YeTMkC4T0ssOyMkVLNsdDPlF7+hRy9oRA1EEcJPY1UXDX7s9Tz5eYVDiXR1q2cgot2s9I3FK27K6UMl0715eK9vwLr8dB4V6WJyyaIwtFcGdqpQV3zAXMwl8sTI2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=cxU4gzxw; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGkiLs3938438;
	Tue, 14 Apr 2026 17:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps0720; bh=/1Uhy1v1ER3XpiILbd6emBPS
	5BIWlfZOwdIzWuY8B1Y=; b=cxU4gzxw+eT21SNtcpSACBhACxD5UJwG/kniLAI7
	cMBHTq5j0wI1Kvv/MudpK5JjTUG3DdDjtcNC41k49jkmsggFcrLMcHd8hAYWveWz
	+Yuua5qx7fRP7yMpVWgEXesEBmuzYGfEooyXaZq6Eay1+4UMfOkK80dY5XEg/Fl+
	4yO1Kn4oIrxm6zIH+OSeqpeWhDXr9Z/yeYVo3UixFZsaW0zQ71geT9D8OKsK0Xh0
	IJKREcXgcH0uoCS5DUOX+X2KzVi5lNUJkH9gw3ecSIEBRhI0hkbX/jm5+tTSv+gV
	l3p+P5yKk5BVAug8N8LPGclIIXcciP8dyhxYWLAGcz6gKw==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dhmkhcgur-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 17:25:29 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 81A16801726;
	Tue, 14 Apr 2026 17:25:27 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 05:25:05 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 05:25:05 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 14 Apr 2026 05:25:05 -1200
Received: from CO1PR08CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 05:25:04 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs6ZHWXw+PChOXxSd5tg2yoxuSd5WHm0sUR6Ef4A4Mn67BIo4yZZzrIwYhrtj9GK5qbrGuMv93lpyjrl7qUinVisu89D32kEdtmzG6Gfe4GjCThv9oQsDK+zlZVp20gxYfwDDbB9Cd7h9+3nymqCI9ONc2Caiqrwv+Zw4ZnxXua8t3egvf2ieW2fOuRf29yzfrIVyIr9ntfOL8Hh14mm4AC0zpp4HYgFQv+h23BqWmKrcoPNppeMiUA1snWSGfgWo0Ld0ToazhWlNfckD9bsbtY/o9w8oG3SfIfcA7EyEK2Z7w16GQD8xG9dTpLXOdknXiMxLT1DEjNOhgtBgEw5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Uhy1v1ER3XpiILbd6emBPS5BIWlfZOwdIzWuY8B1Y=;
 b=VoRsgSDl4scIfbhvB0ernwooAHfW/tXyZSqPQud5cDneykPUmUMgeioU1oq1BoJe9kKT7MTRBld6SZ3iuLqp9unGNNI18R5/nQt8d2JVlbJL9BzKur3F4OQr+JNmHj9tZfQfWezmf03WTWEKvT1RwE0Z+bhI3OsTKvE+W3bZtnoGXhMgb+Ek1LchcJgnK1uVDyNhP9knpITwJBJZQTIzYUxRcS8SxkoUhypqhCqyHMAqpKW+jd9RlKZQHv+7tOnFTXY4sSqjX9u7mKW+SMeo0D/ygVDzjuTrMOOczFPo/lwHItJkQPcRpQUoLANtulrcImSN+UlWvtjUhxqe2msmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by IA1PR84MB3034.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 17:25:03 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:25:03 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "yangyccccc@gmail.com"
	<yangyccccc@gmail.com>,
        Sanman Pradhan <psanman@juniper.net>
Subject: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling and
 clean up trace start
Thread-Topic: [PATCH v2 0/2] hwtracing: hisi_ptt: Fix reset timeout handling
 and clean up trace start
Thread-Index: AQHczDOgks1vpm4d6UyxxMlo4nc9Ow==
Date: Tue, 14 Apr 2026 17:25:03 +0000
Message-ID: <20260414172451.14331-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|IA1PR84MB3034:EE_
x-ms-office365-filtering-correlation-id: 7af699d7-7ebe-4de0-eb0e-08de9a4ac373
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ZzOVtnnJqPkxTTMiVBc0F80Oqs1rqa1HN7HAbx0FHj5ti+C37juWTR0UI5lLWnBb1tPH8YVirGUa+HSvH+wTSGRf40HzbkYE7sAhQyek/qUm8i4EdzCLh0mRDbUR+FeeEcXGuczNImc6SA1MJLdFgiVn812MKanOJKxJijD+jgaTgaKWlVyH1EhYbXKBxAOdl6Btxu+1x6B5CtowhLlZ8HxxOuOAGlGNPVfxo00nB5DEfXa2CxbdLZteoH3strERtCCJLvPcBc1wxxDT+3vTNSid+jr/YdCtjoqOutp84OkMDhUmB662H+6CFTDkwio+EntXueIgxMemXFj4JzvwzFVIad1DzDtMHayk0AWsfAEXWkZQXxdJoKdXotfj6jJ5LPYYIoc0UNZqgIr/oYFFr17Byr6Ob1xRsTfYPjplfS1aZ6sY4wF4o7p3P43kLkR9h2oQ4rX1wgBWbf6IFmdXBYWLHpdkjXg6ZzTFOW42kXK6Ar+5HkwKmHWBWAf9ZLZU3AgZrGwiEjOw3UfeMTPnJWyIVbXHvA4jd/VP0XFJOoU5f0sK3fWQ4LqavFTVLLQ0OJMOQKdFMrmwbYG0YFXMBpXqZzRGHfHyGBChg5K+5ZbmphGb4MDN/hHYrQnJM5ofxWf79azfPxAvhttm5NuRfpnpsJAASuPxZPya24ZsbQ/43yBqVsOERt0Q/GJQSM4SNsGiGv+clJT1aYP4Fxn7V/rumze0rMee6Z/+OM/+M+TyCNYr07au7yuc5vfrVA+vFxHPcWO7lXJINw2ABxOuz/LUt0ROIVdIY36YT+8U0+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D3teO+iUm1WbLQpEfVPaJxg2mds92yckW092h4Hp89MHLD2o2eRC1tnQC7?=
 =?iso-8859-1?Q?nXX3MyjyXO7UJREnZnNS6WZgN0XzXJSw6MBDGvg9P3YSDA+DQHlgKaFaAd?=
 =?iso-8859-1?Q?NrILfAEyT61cHtTrobIdnD+1rjKjR4r7J706xVh0u1EZ15TmiLTAG0/hck?=
 =?iso-8859-1?Q?h2pN3F06Nu/d5DbnoFQHjoy1u7pfXekemLDeCvmflJIvPTy0HNg+F2rbzB?=
 =?iso-8859-1?Q?BR3dF9hqAmyaDMjcQUOeovl9pSvqGadSkRJSjN+PSrw0/L/AS2V/mVyhsR?=
 =?iso-8859-1?Q?ua7d0wfJPiOQx8Y4Lfnr0+7CsyWcF6hx4QrTHAdTQk2Vtd/KXjO3zoPUrj?=
 =?iso-8859-1?Q?qXmiizWXiU9m1UofzwjfQ101d0WaDSHZpuE8LH1S+RbQ1uOtEzOO0EzgXp?=
 =?iso-8859-1?Q?LutoMBQFVwvA7gBMaYZkuPJfuKZK5jsASZKLLn4dcVbQqVQNudQgQvvjwB?=
 =?iso-8859-1?Q?d9m0eDRCpABWVGmymU8CYvTy155oo6+HrMtUTemlRlUAknn1kcnyNLH5RK?=
 =?iso-8859-1?Q?o7mGrEEClj2n1rPr7aZKJwCQQotv5LRu6lWZUO0yS+bDs4Wp3TSBoPo5eP?=
 =?iso-8859-1?Q?iiJaHBYTGyoJ1mJneSlba7/6WpCM+pf1LXvTCklfYVWNESoLvW4HExkjeK?=
 =?iso-8859-1?Q?PENtEvnH5h63qg5Mf8RFdeni1+upOYE73RYt8oCWBqgSoLz/dKH9IkJOfn?=
 =?iso-8859-1?Q?y94i0lGStxtYdzy4bia10ORgjQtvZQ5qKQ7yQdOsVDcwyuJ1ieMETiGNb3?=
 =?iso-8859-1?Q?AXyQv2BlrUTDkxABpBxF36spMSrS5sQ1pY3aRNOmE31/rmwxOQpm0YH1PE?=
 =?iso-8859-1?Q?VLgtOGRmQUtlViXtEdAz1i6hPpqxW0om6AodX4q4bgkQfxa9H+w95iTnS3?=
 =?iso-8859-1?Q?Rwyxz/FvSStZm6IBt4uQkxD3ve1+btvavloIiw3RRvl/P9Pv2aZOfxdKuo?=
 =?iso-8859-1?Q?Elu++FbHHAiAGxyfyBv5i03nCMeGtKT2cffOu64kUHaGfUzSs6HmiwFiQr?=
 =?iso-8859-1?Q?pO0LVdPs7hBE75oMwALZ/yG64rsKQNxSVfEqgvdrKnCFz+P2FzFAHZ6yA/?=
 =?iso-8859-1?Q?RU2nUZPtmbh5lwBo8N5DPKi3A8vkDM0SWZbAqHUEgztH5ilsJ5Erpp3xiq?=
 =?iso-8859-1?Q?3FU1yTDC2zr5BSihv8seTRmdDQET0Mbbnn6ei9yTdDM+tnco4Fkt/YggNf?=
 =?iso-8859-1?Q?jgBd8vfizEtRnjE7knABJwDqXM+lfY1CWPwtmeFXUxciuosT4FYbnz0zMp?=
 =?iso-8859-1?Q?0lOgumGuJv4fOty8FwOGrKC01lsdwpUUUueMxaZlJ6LhErGoquczfggiQ0?=
 =?iso-8859-1?Q?Z+62e9PVOLZNgr0sQvp/hgRsKncjeTVTI3jyOKPmUHrK5mHXaaJxaX08dj?=
 =?iso-8859-1?Q?7zvwKAHucXpHzrWTpfgdiUXMGsarOIBcYAJC6XgcCez1P2VQeWBJdEdfMA?=
 =?iso-8859-1?Q?8yVTveMVXjnGRAwiFPrZUxDIbUM6V0MP7Fd+5fn73oTRXcrOQfZYnxwgQx?=
 =?iso-8859-1?Q?LQenzFTKzrSzfL6dm8sNAzqfoHCFMJ4k1liQ/e6zLiWQfhy2ryU+ujSalr?=
 =?iso-8859-1?Q?NS+W9trFb1uTrzZjIKyFusqrxep+ZmI7x6ulhHY7rPFZx0tYwYYia63l5I?=
 =?iso-8859-1?Q?WBvU4hWaT+EiFuF6kGXeTEVrBxniJNlj/NyEfjhk0HPcB3bDpWtsyLmgrx?=
 =?iso-8859-1?Q?sZZDHzW+KEU8xNK9Xv8PINjC4d3Nx8ilVOn9TyaSkXQn11Fe7fZnGK0Q6Z?=
 =?iso-8859-1?Q?sPjEUqv1pKVC45t4Cf+5luuvqKZV7wSH7ksz6ylbc8tthRlRgm9GYlW8bQ?=
 =?iso-8859-1?Q?98/6vWFAQg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bw02xwreJ/oeoEALnydGg7m/p1c7iv6YhXr8L+waCKUzXeNGrS/gY40DXXEmRjk71TST7gIBALefNPmbqfDmBphOY943ry8H4MBRIsK/GPDSllYnYdfF/LbKtm+9z7HfDfXNehajJSGKs/p3CncJbutu8fNXxbueJmJ4Vsu34zHyHIBo407RbwPaNpxUAMXax2DuZXRQx991A6faYKDr7yTCT7Sv9ivuCHo/LbL4EJO04FclVtuUoY5y4atth4irL4kEGr1RxbVNwNTtN5mV66YPVZkORyPbddvCwqnSR8OtpB1urNyfgoBWUOuh+RJeb8aLdB40YN521rnOVGkGRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af699d7-7ebe-4de0-eb0e-08de9a4ac373
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:25:03.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bWg/jDTXyF/Nrv1kU8tjXRAtVhuTPXJkpIAMQvlnYXkFTE0CMQr3+YCC1bVMMlC/38uadF7Ef/eAo7FV5FuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR84MB3034
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: rukwcsFmlWKLwRI3NXnpPpuvHwNZdhS3
X-Proofpoint-GUID: rukwcsFmlWKLwRI3NXnpPpuvHwNZdhS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2MiBTYWx0ZWRfX9BUN+qtxS6N2
 tok44rDxXdKpgFSWgQ1Ckon8nvuYci9vAje9Kq+/aOtghuTb8sVdtZDu4gNI3uPG+eRni7ECPWH
 MM7vUK653bwllcAk8rmmAJHV5Nd+bWKzakXSnxNkEpvNUoxIoJtwY89bx95/G86R5YhbDenSAYs
 rQXWfG6Coxy7S+OQBBM32p9U4fomBDiRwqsrOZlZ2pCP4SG0UQhAGOSwAsDvVq4tHf6mF8Jin/b
 AQ2mCZryVk4use8n5dEMAxBNeoeW7RfwIv1G3ayqDEPJ9qig0DSatutO/Aq2LbQ7wLfUAXSXitc
 uNnzb136ay7pk4yamXMC5o0G97CP6C0XphCvNnt+3AIc0XTJAjgPrOPkYXUVLhaXk4aM3dvCc5E
 G/xPP5Tn5qNX91bn9feiLviXfZDeQ71AJarZQAhmMo6Dk1+sg3Vxx7Z1FITvnnyLgIozJErQw2P
 MSy5ZsFbGmjsXo3ev8w==
X-Authority-Analysis: v=2.4 cv=XdS5Co55 c=1 sm=1 tr=0 ts=69de7889 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=OUXY8nFuAAAA:8 a=K7DQtwKrGVh0dLUPfFEA:9 a=wPNLvfGTeEIA:10 a=O8hF6Hzn-FEA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140162
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,gmail.com,juniper.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237939-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27FC73FD180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Patch 1: Propagate the DMA reset timeout error from=0A=
  hisi_ptt_wait_dma_reset_done() instead of discarding it. De-assert=0A=
  the reset bit and log an error on timeout. Move ctrl->started to the=0A=
  successful path so a failed start does not leave the trace marked as=0A=
  active.=0A=
=0A=
Patch 2: Remove the unnecessary 16 MiB memset of trace buffers in=0A=
  hisi_ptt_trace_start(). The driver only copies data that hardware has=0A=
  written, so the zeroing is not needed.=0A=
=0A=
Changes since v1:=0A=
  - Patch 1: Return bool from hisi_ptt_wait_dma_reset_done() for=0A=
    consistency with the other wait helpers=0A=
  - Patch 1: Add pci_err() on timeout=0A=
  - Patch 1: De-assert RST before returning on timeout=0A=
  - Patch 1: Move ctrl->started to the successful path=0A=
  - Dropped "Use the passed buffer index in hisi_ptt_update_aux()" patch=0A=
  - Patch 2 is unchanged=0A=
=0A=
Sanman Pradhan (2):=0A=
  hwtracing: hisi_ptt: Propagate DMA reset timeout in trace_start()=0A=
  hwtracing: hisi_ptt: Remove unnecessary trace buffer zeroing in=0A=
    trace_start()=0A=
=0A=
 drivers/hwtracing/ptt/hisi_ptt.c | 25 +++++++++++++------------=0A=
 1 file changed, 13 insertions(+), 12 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

