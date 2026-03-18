Return-Path: <stable+bounces-227144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFYNIOf/ummreAIAu9opvQ
	(envelope-from <stable+bounces-227144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:41:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089462C216F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D22A43079667
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2E3F23BE;
	Wed, 18 Mar 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IF49Lnz/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCC3F23B4;
	Wed, 18 Mar 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862864; cv=fail; b=Y0uCOClYcBP/4yOAvHLn05V01Kx9R0sxISVg/qj3/s3yizR+4eUycOhr9AN0TftjPh9VFohnUzLaRmdB/rVT2LqEP4780Jz5Ago9HPe9/UW92Nc+yZ/mN7GaJu5bM22PY/T3+gyoIEiClwGfC9U2mJXWnHu5cFNjgLzsd3vFa8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862864; c=relaxed/simple;
	bh=GM6+uLc2HAtPYY8rgRSvJxCEn4kCDit8Qe9P8WIVbGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVWnuyxROp1Idi6MdDBBIs7cKFwHUUrG+z+ZX6+DbCBsefPqTvchs9ugrGggr3NMfeU0OywuuVfWBEZyMguxfqd33I5+593FNfX3f5tPi3QeoskCB2aXfLwqC9UiZe301Ad6VEznFrj2DpBQyRK+nAFBQRbyt9XjcDUi5keWQHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IF49Lnz/; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IFWR9E2399518;
	Wed, 18 Mar 2026 19:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=sK
	q/7tOeiKOvDD2ymX9TgR0Kp9VsFIGP7vavTdXroHU=; b=IF49Lnz/FfLMTsIY6N
	zhoIyNvqtbmnS1T1qb9U2kGPvRLqHutMOqxG8yttnNLLqrF0kom684/xrehGCYdf
	5nG4mbPjXRW/dc5pxPopYUuLazoVfvfSiXo/L4SgJMZhZ4SBqtV5bStdUtePxAmK
	QXzToUlAofZIFCzz+ZPSmwNQjsXPWnwLQ2xZPuQGf+1Rv//Ux40Q80hkhQN6/eHj
	vLRexUlTd6HCNG75tICBbwplaRWgVug/4dgxavN9lpPguXLGhjlEVi/VCV/1adOp
	WjLXnKacQ1XPPG32dcyQcuY9lSkI9zovlLZWi7Sggb+mii0T2AYQLUpUn3lZJxvx
	oqGQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cyufvntjx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 19:40:42 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 53F6E802BB4;
	Wed, 18 Mar 2026 19:40:42 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 07:40:28 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 07:40:21 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 18 Mar 2026 07:40:21 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 07:40:21 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj8C3/TUz3PVL+IDOGJVTwVZS1BA02vi91j3CysOrQRA8e22elgajfftUJ6bZUXn/2xrz1xfNi51Z1izAORSUCE3KCWHzxauudTmQts2Qewm8JnyxQ/ElQiz3vkMJcIkRuJVWC6dDXxLtooGQqFK3T2m9cu38xcbVKWgcvpPkfZKkAmUdZ6GiK0NQzkRDqlX1+Vd5ipEHNa5G0vHsHv8gEh9z8g8UFHjoHmjTBtwiQ+U9+02QUnAx38s0qaPX6aRwDT3OwtqNTLU8oxzXOmqMtrNxQJx61OHi20FDU/9BLQxTxKgkm0ZHk3Co3ZxGOEJmGf8PqsNAtKTzboA7lx5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKq/7tOeiKOvDD2ymX9TgR0Kp9VsFIGP7vavTdXroHU=;
 b=NjA5M0a1q7m5h+N2glUVFo4aTgJg20FbOzq9RWgYcub4l8CVR706puZ0ykIqpSFKOTW+dxL6Y2qveMASPoFwUP+X/Hz48rTgIsLnyCx+9VB1lAyBjjwpBu5ASz9IX7IukZvn/fFz7dbE4zsGFOztjb55BFDnQCuB3PypFZWHgJZOzOppSBZbnRRA5gWpxdNQbNlWqrn4BamFPpX2t9vgRt4opoTlMKRRNdkFdHEqbzyZhJu1rbb6aSZpAD8udJiUPcdbAqyVXtWjKBnAWHPL1xy1YnP9m4XEmTWX2jjnOAZQWL0WvxW/Azyh+eV7JUoNG7m6FzvFclC0RKcXG24e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DM3PR84MB3466.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 19:40:19 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 19:40:19 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] hwmon: (pmbus/isl68137) Fix unchecked return value and
 use sysfs_emit()
Thread-Topic: [PATCH v2 1/2] hwmon: (pmbus/isl68137) Fix unchecked return
 value and use sysfs_emit()
Thread-Index: AQHctw8NshMJBHYlL0ezk6OekiphwA==
Date: Wed, 18 Mar 2026 19:40:19 +0000
Message-ID: <20260318193952.47908-2-sanman.pradhan@hpe.com>
References: <20260318193952.47908-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260318193952.47908-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DM3PR84MB3466:EE_
x-ms-office365-filtering-correlation-id: 963052fc-95fb-4a58-0c5b-08de85263033
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 3DzE5YklkXESjfDBTnm1n1kPPXwu1djtrt5hQERjR9HgXMDF7E+/lxRenGYk3g1MvmaXsm2sgkMtmg7C2hQnngKIwap643vFxfjZtpZvLpT+1hMXkD6uQGdvESAuOSNweHsCDDhsdjYNtzowkMb5qZ3HCMKffqsD/WiSFLSG25mh6naiNf5yLTofy+xHrkec8eaplIOQjP4NwEee5tpVMJ413lLaSdjOpt57WRrivuZcSeXRV5N1ckiSzMBU1TakgN8CI0tRn0OkHaKG5WJ/TfutN7CSKmGDZlvFJrGs2Xu4mCukbqCsoE+/2tVQlXEBL23balmUZP0eBTUtwT76yGQewa1tUNDrvmOm7KnzTV3QxF8Tsfs1m54DL+fRfkWzcDKCCgMC6u8me1XrxQnjkiuyz5M+jQ0yPXsLI4FAyYPPnjJbICU5XtVMggnFLm0IPgOcsAgt2IqqoJHw37rcG3FaOHnsmiE1EQPeYZ9/bBBESNGJ6Ofw3rORlOaU403fGy9ZCcW9jDLcswHtGai30CaYx/pO2oEXajiGPKPckG1guxIgm/j0R7vQeKr6ukNOoRuvtE7JzkobsiI7RHRQp/v1GrxKg9jtweGc4ap2HqLtGj7zh/cDWM4wONjl+n0gAP/pfaoMeyFJnOh5/uHw3SVGcrBmMHprO97S3P4KgOHQuVI0iuP6cnG5MQQoZYHcXqaakckSjcJa5bDZHYiMkqwEVxP5696FBLBgzT0aHsaPnd5i2iKsnNh7N8o0dShgvjf3MQbGXuBS5bHl+DnhjfunLSoQy+LV9lL20j7ZJRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xziplsFmCCPRNSYgePHDkbMc7Do40vHGNIr/FbLDu7rgd/nv/RLxIDlEFM?=
 =?iso-8859-1?Q?ssRXf0gzxqxvc/jNcXfW4BuSs/f4PHe8/9GTnp9Sf2rYp7+pUNUi7v3lbY?=
 =?iso-8859-1?Q?qrp8wOzNrNQFKs0Agi//+xwmULCFs8R98fniKvChMCjMat7mJ48ZP5OGQn?=
 =?iso-8859-1?Q?5J3qdPpmaZAbogz5UQEvT4AY32IIyPHq0NP2sSSKYNLeYUwCXRvYixxesC?=
 =?iso-8859-1?Q?qFmSO2EL/p6N3lQRr85kRyacNxaRbBaGTYGa0lsouRs/mnExVdJmgxmTjr?=
 =?iso-8859-1?Q?Km82wX5y8SBSMrbOQKlaqC2dHOty7BGWUYPYIs/udIRXE32bTY8E2JAm6Q?=
 =?iso-8859-1?Q?T1H1DPZ9sKEPTQHpSj4dRrez79UOtAKOyqHl8zM+Eysm2WqqtQprRdgPvU?=
 =?iso-8859-1?Q?oZirSEXcgnvYsOqMJ9iC7xddUj6kPdKvnwGCodSp0DrMVT9R0iGEHvkxf4?=
 =?iso-8859-1?Q?NeMnXshI2o4kVpccy2TqzefFpVZZWteRL2qfOaxJU765tMgsoW5Wf/6ynH?=
 =?iso-8859-1?Q?28jjF7Z8Mw8UeoVNA1VfU4yVsvtoqv/3/zxVTAQ4JLho2s6Dm1A01AW5MI?=
 =?iso-8859-1?Q?jmjFt3t2jdKQYlIUdcbaAIYgsW3VJEwQQwJWom3vcNfC6Bn2VvlyBGQJQk?=
 =?iso-8859-1?Q?MKa2KSUtyVRh+Hmzy/qgLvSHemjCfFrId+2djHOggQ37o6jzCh+6OfWrdF?=
 =?iso-8859-1?Q?exM3x33/ok4eJPlzm2On/Or6mtTtiqkCe1eiA5Da6uWRLkOGfNsYXTGTN5?=
 =?iso-8859-1?Q?yjwhOmzT5YFWdP9dDtxHElCfyZaVqQIJwJ4P/S6YHTmkbySmXPTyzw38vA?=
 =?iso-8859-1?Q?8UDgS8uaftev20nWnLQp77PBmdtQyu4xGlj09sEUx6TdWmH4mRO39LWF6V?=
 =?iso-8859-1?Q?8Cx7anXC+OphyMjbWO2Ps9WcfFrLoGwJW5dyN/j8LsU0p5exnd6XtjiW71?=
 =?iso-8859-1?Q?TkINy/QQZx05DVaWRm3ixyMu0aJKXu69ebGfLHDDGy1+783GMtq1d31Dq1?=
 =?iso-8859-1?Q?lRQNUpzoEyjcWfM2AezZPmUywXwUSA14KtmAXN9hNlqqGjnWOapyXjX6eD?=
 =?iso-8859-1?Q?Cdtv/HhCvUX/IjzjspOi8HZsinlBuFcb5c362A0UcuEUo2BKmB3pSpuky4?=
 =?iso-8859-1?Q?Tijn/0c3X8ogM8K9AtLPAuQUeHGSxyeCYq+GnRwKuaDenG9YKbRBw04bW2?=
 =?iso-8859-1?Q?szbwsuNgP5mVhAjlqO1bieV0C63XxXV2e+dV9FyJNWgmawjG74jnmO9Ho0?=
 =?iso-8859-1?Q?D5DwHbRpkwmezXsNOlbTjyHbjZJcYOWq4QW39Y0gmpvPMr1T9yC6yMsBCP?=
 =?iso-8859-1?Q?T49P75klMt9dcBZ/0UR3VgA/PkYdSi3dG0SjhFlxH4U7+VGS/647zGUPDB?=
 =?iso-8859-1?Q?i5E4xozBicBw/BKT3UA8hdtNn102ZCs+11HMf4zqIYrZ1AVH8Fi8irB6Lq?=
 =?iso-8859-1?Q?rh2TO8lBKvYt/I4C01Zr6mJbAbxN+mChinoiCUo4uZLZhNIa+PYTqj1uGy?=
 =?iso-8859-1?Q?mmwk6v/ripDJERFO42FLlG6VCt8R12ydZzw4D+chRfytZClTnnIgu3L/VF?=
 =?iso-8859-1?Q?g1g9FiNMZC9vqJKGuARw/uKYPZixntTyecHypXj4q6jf48DgU8U4Oz8PCC?=
 =?iso-8859-1?Q?fAFjXWpn8JNhFwmo0xqZItz4Pm3EnNInqhQx9M4uTlA3cwrErLfJ0HzRV9?=
 =?iso-8859-1?Q?cEHjsthBt4Zcan89qPS2oIXoEmcmvoKUnVjFmmCCouldk9DeMuV1My8Hei?=
 =?iso-8859-1?Q?Mw337G1kTNPI4aRLi+hvtHidWEZ7UmOeFrtAWfyJ9ibHjaav/bDhKgSFS+?=
 =?iso-8859-1?Q?10jF0BXW0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: huKkxfiM5uLYLOVb4C1WJ957EAgwJQiFtuYjNqlCgncNq9uLtZqqfzwM667D2/81i+jsorTT4/fOMGNC089P7mWCxSH05rcUaEX50VL5IArRW8SneCwLpw1UQHudiclEoF7iRPx5XvzRiSNmCkNmhSPyEV5qf2xGUDr+e8u5M6l4xA+gE9KFBG9nk3qlfV284/4IsLmKMWSIdS4zLOl6QTkVjV0OPu+UeRyBh74CghGLK6O3yl+aXGiCGxQ3lDmqp1n/PQX+1IG3KzZZQKvgEKJCG5kzW+HdB4CtOgfHvOU4T94pIeSgnS9j3oxILnjwe7btYuVFtL5Tnhu/gI4VQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 963052fc-95fb-4a58-0c5b-08de85263033
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 19:40:19.6688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRHSan6NpCK778uwdGqHBl9SeX8/6owmP3DNyXyJ8s4gr+NGL3v7xB5uDhvHVCWeZF4lD5VQdwcouJlg2ujBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3466
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=DNiCIiNb c=1 sm=1 tr=0 ts=69baffba cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=xJ2UmOqLvB04nY2elPgA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: NR84hhnsol_bh_ReBrX0ZZj5RC1UMqJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE2OSBTYWx0ZWRfX2FoRX+EVgzIF
 lRI9XJQbIAuwP6GuBCFeICBnB92Vy8OhbFR8WWxKR2uYWSkQPPlHT7KDdLyW6xPP3ERVZ/INJnu
 jfA4MKzTB+xHTxMJvZtEmSH/oKLw0wGGbAncJN1fDrhx723tBnbv5Rp7/8RFbio4t8qPm8mG0Rk
 Z1Nn6a0IeAcnTGqZEHIfeM1oB8bx3nJvIhqZM+RJlHSMFDkUu549QOSsF+4henOMDSgJqxBqNc4
 vVF9m5z4nKQZ84TTXhsu4SWcVnRMMW//p2aJdu/ghV3gGxlq4narTzLPk9vvsEwZ9O/sJUP6C1R
 JN/5jz/GQAGM6k2gV55Sl/+qIQ8B1ARDc9fA/wHMS3GMy9Je/q/1q8f61SP27gP0mFYqs7+8cuu
 DxENcd2BoXYqLmHXrjt8JmyfYhgMfT0joTgceoEcjaxgHsbAiaU8VlVON051V28q0mefwHuep5L
 GD/opHrMtGAYyryu3/A==
X-Proofpoint-ORIG-GUID: NR84hhnsol_bh_ReBrX0ZZj5RC1UMqJB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180169
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227144-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 089462C216F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
isl68137_avs_enable_show_page() uses the return value of=0A=
pmbus_read_byte_data() without checking for errors. If the I2C transaction=
=0A=
fails, a negative error code is passed through bitwise operations,=0A=
producing incorrect output.=0A=
=0A=
Add an error check to propagate the return value if it is negative.=0A=
Additionally, modernize the callback by replacing sprintf()=0A=
with sysfs_emit().=0A=
=0A=
Fixes: 038a9c3d1e424 ("hwmon: (pmbus/isl68137) Add driver for Intersil ISL6=
8137 PWM Controller")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
  - Kept explicit bitmask comparison instead of using !! operator=0A=
---=0A=
 drivers/hwmon/pmbus/isl68137.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.=
c=0A=
index 97b61836f53a4..e7dac26b5be61 100644=0A=
--- a/drivers/hwmon/pmbus/isl68137.c=0A=
+++ b/drivers/hwmon/pmbus/isl68137.c=0A=
@@ -98,8 +98,11 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_=
client *client,=0A=
 {=0A=
 	int val =3D pmbus_read_byte_data(client, page, PMBUS_OPERATION);=0A=
 =0A=
-	return sprintf(buf, "%d\n",=0A=
-		       (val & ISL68137_VOUT_AVS) =3D=3D ISL68137_VOUT_AVS ? 1 : 0);=0A=
+	if (val < 0)=0A=
+		return val;=0A=
+=0A=
+	return sysfs_emit(buf, "%d\n",=0A=
+			   (val & ISL68137_VOUT_AVS) =3D=3D ISL68137_VOUT_AVS);=0A=
 }=0A=
 =0A=
 static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,=
=0A=
-- =0A=
2.34.1=

