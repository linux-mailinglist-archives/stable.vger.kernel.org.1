Return-Path: <stable+bounces-230538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIeBOLS3xWnxAwUAu9opvQ
	(envelope-from <stable+bounces-230538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:48:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA6C33CC76
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8381D30BA597
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EEA346FA6;
	Thu, 26 Mar 2026 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="O2JJDIZr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672734B18E;
	Thu, 26 Mar 2026 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565161; cv=fail; b=JfYMRPqJ87mAkMdcrzEaImCmMVoqyEw9nMxPBTUkRShCxsaC32eIbZFDQtzG5521V0LXY7hTZrwtAlo99JcLqQDCoyIkMnnaywUrrkk+At0F8GUxNpHVHKAQYCO2RcQQ7/+rhRMISC2jft5a1HGCErj2El53qC+svDeLrl8c+bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565161; c=relaxed/simple;
	bh=PT8ahq/SB+IAmJVCPAXlJ3cmT7LHxUn1jhOUmIh+RTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEH1gRriO4t31DDixXgD09IkoTt6G8PM5jCc+BGlSZ86KCBY+HBSJ7m37WY/C0/rGzbi2GQg+j8AhEQgpgE6f7hKDUmaqm2yFnfOyAAhLxf4ckdrWmZuBFvCpcZS6zrhBFPZ615jWMlb4h1uLF+5+3b+mUd9UcB9zoDZ+Lq7L9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=O2JJDIZr; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QJTGRd1857877;
	Thu, 26 Mar 2026 22:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=DC
	6yfanw1yM8B/hIB5Xmo4Wg+2lvbkfIXwMqD9i/ni8=; b=O2JJDIZrds6XOSkhj3
	wOqTUrF82N9ZeD93CdegSaqfgTeDB24wKGYNVia48WETdBv0Fpuj77+St7MbYAmv
	K2GVy5Epxa72NeR2KOufyt8SuH0tnDT6legeOGVhcsHPX2PLgOqKkOgwe29ikGKd
	BbtJnbCKpiiQ3U4O+PyiaY7eYhigWekT39WiyflWPfmltO5Bs9eLMQdvJ6FXsbDi
	Q5mTi9ZS5xJk6Si0WSKWH3gXAkrj2K3xmX8F1Ss9Isyi5n7QIgiV2y/FiRpSP29Q
	kRQ+YwIiYsd9eHP9k4yfslFtOFP7UNpB5vTtwYfqrNePgfcyzreAUqJRf/cgicbJ
	qfPg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d56xewja9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 22:45:45 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 48371295F4;
	Thu, 26 Mar 2026 22:45:43 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Mar 2026 10:45:40 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 26 Mar 2026 10:45:40 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 10:45:36 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWHAKSQNKe7kfox1019O41uuQRf70nCywrxCGWsmgS8RKnJIAUYeFYSOFAQyM59iRPjiRtcLSrBVpE6AXS3ykvByleNXpdhxV+P2rqe6hf91zZdvv6V28ggRiOS0MkZyBlS6uOOuoQ1QtqczTMCw7tLWg4dDfFQ8LWxHZl0IjnhXwAIT3fooKTeSj9Kdro8/MZriMzWoHGJy/TgwHI+3PD8jkjv34Be68T1KfZ8Djf+iXjtmiSzR5nSmWtpGWJyaeGVoxqHNl7dyZCbokGu4X/v1SaaA8GpjHQ7SPV7VAn+/UcqCoD9uP/T16oooYL48/obNxcZW9lN6MhjlNqTumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC6yfanw1yM8B/hIB5Xmo4Wg+2lvbkfIXwMqD9i/ni8=;
 b=icdtz/lltI95H4Fz8aCoQw2c0rZoRi1/DJsdiKeibVjL1g8Tnk1Den/6V9kXz4aWraAmroobZ1VPzYMEBHuKjLn6pmdU5BAdEp6C5y2htH8xteuuqQfAcYh2vOw7n2+4RCgLHo28RHttQvP/1qpx8XGcOK0VesvvPthj3dRNYAyHUZt8gOv2pM9PwFpmwJ6hZ+fQKfNp2/W5kSEzZw6zB1Gc+eJqRxMzJzx/GYXH4b+jbyfRqUs7yVb+c46PMoCELSdKBE1VMMRlyHBWZ7fUNEzrBdpL0YQEY0yYvu5xR3k+xColdnzC4iJJck0FvAkQ6ymlaplAZfSfYRBIi6eLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV9PR84MB4031.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:2e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 22:45:34 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 22:45:34 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 3/3] hwmon: (occ) Fix potential NULL dereference in
 p9_sbe_occ_remove()
Thread-Topic: [PATCH 3/3] hwmon: (occ) Fix potential NULL dereference in
 p9_sbe_occ_remove()
Thread-Index: AQHcvXJCUheF3INeNkqNUx/HVtyy6A==
Date: Thu, 26 Mar 2026 22:45:34 +0000
Message-ID: <20260326224510.294619-4-sanman.pradhan@hpe.com>
References: <20260326224510.294619-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260326224510.294619-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV9PR84MB4031:EE_
x-ms-office365-filtering-correlation-id: 48102b33-b5bd-4b1a-58a6-08de8b89649b
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: VEvGkDCutRg+eas8ttHmtYJKwUKh9tRixzRhWsU/rh9dxNYM2D6nnMprorwYRF8Z22JW5LtNj2wibpSq502XOdL4Yd2MsGrGaLL52cOm4/xgNiNaXN4O54PlKO/cg59DuLa2YCUD5Am8ESU0wgtpZDsQZFyC8kbYCzpzo/iNX0qGuFtrZZh7QIb4NC3ibjNmQaM02sM8OLbwqxaKwBBKfHBs5AT3qBHFKH7pVbcwiV68QwXYCi6lVZEF29ywQINg67mDYGpaByO3TBdNfTI/Wo3CFf2Ldqvj44sGCpan8jm3NrB9hTDJHg25znaOM2/4z/z38ysFRpKlvx30fTHh61/hpwXwEwMymvdxhyz2L0OweYMgGDV9ImyTIwlgTe/e+f0FX0AsR3WtdUE+nE9dwIBlCfPOp0aNSLGM+bi3Scq9AnoRjnAbm8q5NIJeJrzccugQ+0u41i9PO8DCllWwBZGM+ZFF/P1g7fjbh3ANOLrSgvkUxqrSm6S0NaMMwuBl6HQ7nmKxrN6xVpTH8UJA1O1saWo5D4ugJNbz62M9s+PQm/hK6WzEkl0lIJgWv8mhHm3XjZ+DEEx5A5n5SknjRxGgws9whePOTIuhiH3RQdi1oEiT8Otw5zXZMzJOnSJ4OTbiqo9wtZnXon+NNtMvL1iVFacOjGN3MXaqNLltJG3gu4DeBOHJRi00z6rnP79K4+w3nalaOCeGrQDstX5WphT1t4RB/6FxUUE770p6iVg4AZxRaGzS46gyFeZDQIjEnXPETwu9h3UAjw9Ph2Ahm8bVlGk8+NuRrsNhAVJwCE8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MbZQFsaOWgZCZUmd1vItVQXk9ruca/aMQJ8Q8rxzGa61fQB0yyHpg5SmZ4?=
 =?iso-8859-1?Q?+4MamTyaCKU0lKpXRXjyROTcqEMoimyNx/6oW2zBhIzujxc8GvbkLUXQ5y?=
 =?iso-8859-1?Q?bIEy4xCP1GU+uZ+hRtJDLr8K8XxWWQl8h260GGoSgC9jTHMh7tVOFMmiCG?=
 =?iso-8859-1?Q?lQ71kJ/WtOCXKNL/SU4FZy1njaPln18E6O6fNTB+4fT1rtwKU6Pl0TowPX?=
 =?iso-8859-1?Q?fUlIeuIhZMtZh3u+UcHPuUGDMH6kt1S2cnndeZtRhSF/xwo3lnOyiEedGP?=
 =?iso-8859-1?Q?oMu/4Z0C0vQgesZeFQdCF16Rue7YdoX9ww4m2CuPDQdsA0drV9ccMDsz9l?=
 =?iso-8859-1?Q?1FdZ48iBBylzVYpF2c0SCsP92oAupJ0MkLUWhvHSr459unoLky4rviOVUN?=
 =?iso-8859-1?Q?/IwFN5ZKyOfbHRWCE3nWK5s1wb0ka1mrvvaljg4u+7biH7Bn/dCwtwqQ/+?=
 =?iso-8859-1?Q?vfJTPlKVtAGRo2Yo73A809AkOloYUwd9VI3c+I5FAE3KHc1Lxs52alAamJ?=
 =?iso-8859-1?Q?xnMw4TzQzK5/8WNGakkQypKUGVsFk9/rz4eVrFk5+m703IQ4TapyqMa3Qf?=
 =?iso-8859-1?Q?Mju7M4G0lcLPM8YBOcWQL1q1HIN8u6AWAwyZCeH+J4OTGgTHllLmUiA3H0?=
 =?iso-8859-1?Q?7KX0Jm7UvzgCEuBjCyNRoPkBAfdCvjDpDIS0zqsLpH/dPthHYW+aUcf4YJ?=
 =?iso-8859-1?Q?urLsXMDZNqdfZBA7cx5KqWckG8VMlaoJdlZdmcS9zYYQYVqU/CxR2C62EL?=
 =?iso-8859-1?Q?UDKhZLl50uQGInf1t/J4N3S0/2So/kfwKlFevGvlEDRzMtFNNbJbcSf06L?=
 =?iso-8859-1?Q?YJbjC1QedMgTqhaDXsEZvizado3TRRv0clVM1Mymsa1dbUqqStuM43FasI?=
 =?iso-8859-1?Q?tl/qAAfT2fjY7a42rlkao3ItWBXgKQK0BFx8IVb9KHxDqOcoBzDDjgTIkW?=
 =?iso-8859-1?Q?5t6uECF0Zn5bHumPSzd6pfMAPbZFvB8AEqXz7aLvsGkEjnO8rI0HMllUVF?=
 =?iso-8859-1?Q?999aBCAdhqbsqdYwXmikW+xXaFE8JmoZ3OuzFFYJvf36+PA3gw5sw3RHzU?=
 =?iso-8859-1?Q?BvdL7W/c2/bo6vZpfz/3jhRaWZol019xaIS+Hr9wOdULzZtNqsF3Rkz2RX?=
 =?iso-8859-1?Q?G6HwScGvuoLparkyisML4PFWazOQzFJxYwoQ6zW35v2u33iv2NWVoWUti1?=
 =?iso-8859-1?Q?F6FpTrf/U94HnloYWBMxEAvolmBHVpm14N8XCVBGhvjQiA51+mwWOmzP4P?=
 =?iso-8859-1?Q?VyLuMNybJEYEXClXiKJiDa3pE1Ow19RrtdpsCixLyMdb3as5wIRXPfiEaY?=
 =?iso-8859-1?Q?yYnpfO8lQ5OcdmSy2n6EOgddFK4rOZ6dNJXBisgedEL5X1V8Rjf6vVOBdu?=
 =?iso-8859-1?Q?eAeXXZJSICVtmKltxxNv53LbOR5Tsdbjjs6h/qbnCueNxf2rFOhN+3vY/r?=
 =?iso-8859-1?Q?jR6FkZml+bM5ogvTWQOTfqHJmiWblX4/Jb4PFv9E4vvQGIZUVqPNv05RFS?=
 =?iso-8859-1?Q?nZHkQz0u6Mw6ahmRwaxfAihskbwm4OcWB7rBc+9GsLVpZhwL8rQ3Cy5Nyj?=
 =?iso-8859-1?Q?ipBz0OoiJZTRnkkBMFUkuviQan4ncQ4kDLTIDzSedMl8Lp2E2XNoyS8yTj?=
 =?iso-8859-1?Q?aN9KAhb9x/vfZ21NmiVl8ykP4erRRDRLs0iMLXeiqJRADc8YdXCH12UXpI?=
 =?iso-8859-1?Q?bpWenj6LaWq9nma705MbUSqJWyB5QKw5QR02+YlMSaFQkhern99oQ22eyV?=
 =?iso-8859-1?Q?Jrf7lwAf9MN5nKuggfrdenBqhgnEttDPWDnMugus5dqCiRO1vUuaacHiX8?=
 =?iso-8859-1?Q?3c+J9i/dyQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iZBjjSlNT3iz5VIRIiVLpnLnk2WGwezCTVlzLPdYQwPbQ4AZfY63kivSZAoEjLZMNKoX2HX9ktmVzfLdPqi/1pWRhWHuiKyQpnzTZsRkPKbDdp5J//cGH3hZKTiy1EZE1VLOPf+yBNby07Jy+FHdjuEHWU/RtpLvoUIpC53uM0SciK53Eiea6/TW6ZSkgAvY1vk2UNdVe+KyWC2Q3N7zJuJfMXm0yrWtjkpG+u0mqvtmcriPE0iwg8VX3WrJ8KgRGCGao8eWBQyenmIKXWq/MRO+3DsqaoR9FzjSfMDR0mwurYjTvhXhhcT+1jySduE8xGd4phVRcUlhZ/75eHwrQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 48102b33-b5bd-4b1a-58a6-08de8b89649b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 22:45:34.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBv8e+Mp1h1q9U1EQoVSpfv0i0+tdAPWE9AaU8CIkv8MNlcL6x/5B799i2Ew4hUZrExb4YfXy1EZiBSuGIZBLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR84MB4031
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 59TZIqVbys-MNoBu4-4lYHcostclAOWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2MiBTYWx0ZWRfXxqB6y+Ax0O8N
 iwPuIciSncvZU0uhLlVuyNJ6gF2CxJp2CQLJfmt1iCKRCzWSwFfN6srL2m4rseMHgK65P1uYmo3
 nmzlN0Koew8mBlvHWhMt6mUqHfMRegAJIxrob0UZ1vZJwg4lxznlMP+xoLnrJwOd4gqzn6WfA+0
 +pqmsmZu/Hd3quVq0tiwNRW+b7+r9dvvUv6+4vimRqpYW1y+QfZebkd9bc2z4OCgcdZkM8/pMZl
 fuvrumFszYusIyDUHIiTDkNuj/FKwZCHMqHpJOKg7/T03TQuSMoQf3pZxYke7gufAlWfqXx1jFO
 wRahuUI0Lz8/+2kq4Y2JsnIMSorUgGLYLmAnceet99wKlAp1SC05njB/aIqcfuSTBZ1072FH9QT
 c4yNasu+rxRssfEO2GfPKGoVeQu89aJ5Oyb2K7o26+U1zwJ/bkrqQjFOqcQKj/qegQ/O/YV55BC
 eOHRsuKYirTeIs9mRCw==
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=69c5b719 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=HiS63NuMhllX1Uf8dMYA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 59TZIqVbys-MNoBu4-4lYHcostclAOWb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260162
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230538-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5BA6C33CC76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
In p9_sbe_occ_remove(), ctx->sbe is set to NULL before=0A=
occ_shutdown() is called. Since occ_shutdown() calls=0A=
hwmon_device_unregister(), there is a window between clearing=0A=
ctx->sbe and the hwmon device being unregistered where a=0A=
concurrent sysfs read could trigger p9_sbe_occ_send_cmd(),=0A=
which calls fsi_occ_submit() with a NULL sbe pointer, causing=0A=
a NULL pointer dereference.=0A=
=0A=
Fix this by calling occ_shutdown() first to unregister the hwmon=0A=
device. hwmon_device_unregister() drains pending sysfs readers=0A=
via kernfs_drain(), so after it returns no more callbacks can=0A=
access ctx->sbe.=0A=
=0A=
Fixes: 5b5513b88002 ("hwmon: Add On-Chip Controller (OCC) hwmon driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/occ/p9_sbe.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c=0A=
index 1e3749dfa598..0f5f87836dbd 100644=0A=
--- a/drivers/hwmon/occ/p9_sbe.c=0A=
+++ b/drivers/hwmon/occ/p9_sbe.c=0A=
@@ -174,8 +174,8 @@ static void p9_sbe_occ_remove(struct platform_device *p=
dev)=0A=
 =0A=
 	device_remove_bin_file(occ->bus_dev, &bin_attr_ffdc);=0A=
 =0A=
-	ctx->sbe =3D NULL;=0A=
 	occ_shutdown(occ);=0A=
+	ctx->sbe =3D NULL;=0A=
 =0A=
 	kvfree(ctx->ffdc);=0A=
 }=0A=
-- =0A=
2.34.1=0A=
=0A=

