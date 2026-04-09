Return-Path: <stable+bounces-235291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCKPHir81mkZKggAu9opvQ
	(envelope-from <stable+bounces-235291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 03:08:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1E93C52B8
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 03:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171A73016903
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9226A1AC;
	Thu,  9 Apr 2026 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="bgkjYbSu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1023AE62;
	Thu,  9 Apr 2026 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696923; cv=fail; b=sLE9QfQTJfBhRKS+L58GLLDIAceV32g95a14v5xK5kZOpgMDMmhnsh8xI031Cl5XderqoAKrHVKdK8VdPpyivhJPHXznpfi+z+wmF2Jl/QngoSuzQo2UcYVIHRltVMIy0jmVOUxb0EhihTWyWiwvFsG7yGuoD/kWE0KyeVakLGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696923; c=relaxed/simple;
	bh=EgTFuo/FXI/t//XGNoSg1G/H4mm4mAIdxJuKY0XG5pM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k2qXHJisnPLs8QUQFOmzzTVHSCV+9nSjhDs2gotS/Q1XjDGxjZyI9UEBJKMCmWTu48P1wUKW84Z9Z3C7piVQE5kGNLSkXlSfEDqoC9Sb1342mWzDNrJvFbfcVGXpFb/T9CetYeSmvFao9n7Dx6546p1ooIN/9xzCrlZ1T8lgkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=bgkjYbSu; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6390DCei2483491;
	Thu, 9 Apr 2026 01:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=pU
	eqVGmtRMt4v8/9WeL6w9RwQKexeLvBDi/fnao5D0A=; b=bgkjYbSu7URyPjL53g
	cEBEPw43+ohX/R1f+dDXS9RE1UW/qvPXqHWrf2ZLdHjQdYi9uGHEDEEMBpY8HGMN
	ymGSOqc8SaPLRqC/EW5Seuo0dvEe+gAQcMqlluQlMFkMcpmNRFkEnk1SUV1kNGee
	PtNgIzcn0pnfQTnxDwR2buGYXqDld0vuajAXSL5oZEaoI9l0ZoeCb+5TFMCi458c
	MsFIFwxWii3oYrtz+jC4jzI7wDL15JtGDXDXHyvlLT/Bnk1lHYhB4+Tje1BL9Ifq
	UnPaXRIELqU9FLqHaygHifs6l5VzyCfhZiOFS5vae3E6DjZdu7ai43JevKH4Ttdp
	AZiQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4de1chgjc0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 01:08:13 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9E6772BACD;
	Thu,  9 Apr 2026 01:08:12 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 13:07:39 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 8 Apr 2026 13:07:39 -1200
Received: from BL2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 01:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4XJL4XPzdzkbgqD3fTHDdM0j9GN82PMcGjBbYEYn7I00Qsqu3TXjb4tMJ4yQuxjrPEWcH9HhoZlG9ShCNBIlrwV6VZJzeUGixihpYZ2hY4i4UfT1J/Gzj21F+F6FwNMemIpK/WlrL3GTFZWqhxMOpNgmpJ9CgpvCq4FO4I/8w1lOXUP8r+nknZfQ5ZdgHJ1Omn8Aez9cY+PjdCbOUv9m+vA08tmoRHArN0SIUqxgezlbFVkOJz0aorDA8hLa/yZroXDaxZWB45gNMeQY+Nr2BlhNQ6b4XapuzaJOsemcIL1fYcZJUt+sWLkENxVd+7uLZDVObFQP1NahypXT5jefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUeqVGmtRMt4v8/9WeL6w9RwQKexeLvBDi/fnao5D0A=;
 b=CLrvsExq39DcQZ35Xk5Vx/D4dreK05STZ/RbcTO/9qnnajoESWh9FPwNnzdGX3Ej/gOfozECQfGjIHgW/PvUmJcDjq4m2hlQu08hPUTRemdvNd56dIA45D4JWJTlFI+/QjAbvTngV0aYMlbnI92o4bIGSpq1TvVzHBIG1MIDPu1RPz2otYn/49C6oNgHYN8E8ppWRievIFtJ5PlseyxLGzN0KrAEqAjZP3lQ8Dg0QWyIAAxrsGbQsrK04gTlhnq/4wiif2eQdM3ZsRRJJis3ORlFTPn+m2vF7VTnjPrrfHJGBoB0/3YFwSljTbk8oZrOmDmYSEMZhh+UhMvEsCAYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH7PR84MB3762.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:310::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 01:07:36 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 01:07:36 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in
 trace_start()
Thread-Topic: [PATCH 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in
 trace_start()
Thread-Index: AQHcx71AezBe9nz1CkqgGAvaDsFRSA==
Date: Thu, 9 Apr 2026 01:07:36 +0000
Message-ID: <20260409010704.383882-2-sanman.pradhan@hpe.com>
References: <20260409010704.383882-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260409010704.383882-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH7PR84MB3762:EE_
x-ms-office365-filtering-correlation-id: b51db973-468b-41cc-92c9-08de95d4636e
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: KDK4omtIv4kE/Xdi1ZbuJVRV/F5mbXrbcagGKqVYw/y3cKCRJGVTyjOZak6LNJVhZtfpdM7mYgHSIu7akC7qF0QXuTkkh9J+N/AfngxdrDQqrtl1sSw2H/GHBqO1Sk5oVoJ9J9dGOjAuTHF5ImsGv3fpBDMZDOtd0HQtilE4g6n4nNkY3erLUNU88DHBDsxQiN7/miMcwmfzGidcFUK6agd9ftOi/AWuWAoRk+B9jR1/MSozMUyb7fG6bfYX4Gak0C+k7ALtgJFySsVqP8zPKwBBZA0UMoGCrCV8yRLYL/vOgX28A0P2l+aaxrQnbN+JP59Ey6UtxJV0I+1I0kIZJW0dEzGO6QsZyhtuCtCPM735MyGSw6GLSNi8awgrqwx9rNYm9AwUsi6OuC8ZFVRJb1hK+43LugzHq1lrEWh5c1jtyFkB1GwJvuu+NSZvDL0BAN8bPbrpcxxYLuA7WxBOd1nDF6IRxBzykFBZIMq9ft0foESz5IVgRPYexRIBbSNoOI/44LxIw00s6OSvKjzMIvtFSldq9uxC3GKVllOHuMcu50H+t+egPpF8EmMOA79CkJhTwLRbGHS1IqmcEiCR92DNd/vWgCC/Jc6ieeLJgiB1wGZloz/Xl9BZ0r3QvOxfweSoFynzTVeHmPmKwzE2rGIl4ZhB1qWgRr94F9c/oZSHZrN0EhscvgJpCwm6jA+6BPlmuaml6EetGP5d9h4Frf5mG7XL7nJcuHvc+JwHy54U7kSfJUD2PhkKrVvjoS4yr5UvqZiBeQ66ane2XXyQpdgyN/mNSTo4Q8+M2Lp+TgQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3Z85bwuCQ2dnWmsZGim2sMltK0md3TrdGDyioE5NXcE/hpPpnINCEcze++?=
 =?iso-8859-1?Q?IBIlmqtNIE4wgq/XFjqCWokNFtrG66wMmIlaZtM0WYBbBn2O+VM1J5CW+S?=
 =?iso-8859-1?Q?rvUwwCq/7TCAjfoiYyu59VpBKcZI1y1CEJ3IsO8bS2F8IaUo8Tqif8uCwx?=
 =?iso-8859-1?Q?LUJ28HEgRC6mgy40oTBzQEz7c3ysAog0MC6KdC1msZIx7H95D/8fpVPllR?=
 =?iso-8859-1?Q?QRzqR4ReP0LhoxBXVn2aNeq2LREZoVOWv4Hd3/Xn2eR+AmQOPBH8X6aHBr?=
 =?iso-8859-1?Q?9OV2M7fAPCwC+r9ecVRlkhUVp9/5+1dO/Un3O1Tlpfi8CzPN1ps02CW2ht?=
 =?iso-8859-1?Q?KySHmf+P8NjQeAeHnZqT1SPIhBY4PoLagL3AMZ5i0j+S85JuS0w4lfEiU/?=
 =?iso-8859-1?Q?eMek/VamnVjwAOT2y5Vi/bw2z18Np8F1h18HYkq9grw+RN9PAOvL7TwZPv?=
 =?iso-8859-1?Q?CUSUcQbWVrIVzXOz5sDadrVonKjz/GJcuMQy05V7WzAHIyRHnEDEvWOsyr?=
 =?iso-8859-1?Q?sutyS60Is/Ag5dzXUhvLBtyavM7bz0XyDFkBdDpC3LGkuPYeNGH9r1AiML?=
 =?iso-8859-1?Q?iCRjf7lFRlFE9/OzllLv8nCtNmGR7jwCzEAVCkuO6c08CjG0vF/2L0jEkG?=
 =?iso-8859-1?Q?cn78m2A/TGsMm0inWry8xNMlDFqbuHJvAQ8wRZd6cpyLNk/z5iwS+DSoGr?=
 =?iso-8859-1?Q?IPfXQuypkaT8ZOLhIRZF52E6vapPJAffRaeI03rn6z1EYImEhXIJOWa8Jy?=
 =?iso-8859-1?Q?3Bv/GRxa0ynENTo9u8POOWhcFZ2iNYNw80+exkyby5FL0NxrvvVoiVWUX4?=
 =?iso-8859-1?Q?OnC+xNIEPWuy05Ft/yuOVN5jUzOwtpvxkVqZ/ecLB4gn7IOjiRYLN+t0Ys?=
 =?iso-8859-1?Q?PYeDEMM6AM2uRZdez+omph50nsYGqia1F7QnQ6snVKDF4L+feCga8xtTaC?=
 =?iso-8859-1?Q?tV19IAceXLkYpIDWxYQXZHiNZraoIE9cEM6ihB+ySa1tBNzWYAwWv6630E?=
 =?iso-8859-1?Q?fU14ZaY6ujejYev7bm65y0TfBUbpplifFwi4GQpcIrFUfCgYfnG5FmArcW?=
 =?iso-8859-1?Q?MuZ9jHjscLEwmdFWm0utaibpUlrVFYldrgNhqI2sJiCJbkBYMJxRjkA0YH?=
 =?iso-8859-1?Q?IaaPMUH3lo7B5ex3qpu6gUSl+FpBygMGNSDxyaM2401+B12tr5yxQxPqUj?=
 =?iso-8859-1?Q?a97KceP+yg0zbBuElixrobVGSlLCcJT8dsAwofd1zI45NWJEYa4E+K82Zs?=
 =?iso-8859-1?Q?QoVO99pARI/VHABAJbQB1trIL4Qyxsguc0sJfJVLOS092lvd6K3+DiKyzc?=
 =?iso-8859-1?Q?9oc6LYr3Ks6t204Je92eBqwwaSyVOK5atHwVSV9mc7XLW23m8FyrUFkONO?=
 =?iso-8859-1?Q?RDJFhFmmJ3vr3VgJshfffJQkFjQ8fNi7rA19K4sQk92spf+WxW+/y3uUGv?=
 =?iso-8859-1?Q?9jT0pnFy3zUBRZ9JlEaTMsBelyvxJLAqWnusGPZxKX75aaeRI8K5lV1hdk?=
 =?iso-8859-1?Q?jY1CbNd4KxF9/ttCND8ZtdYgDlv/Npt9T4gabYk6iOFRz5KEVkQBIZy/x+?=
 =?iso-8859-1?Q?dNjNqJzEqISExnA9kELzyJzAdavHUhW/+sMQ17JRI5Gjl0pEQQPZAN0gQq?=
 =?iso-8859-1?Q?qEzOPLvbXadHlgTb5qlbuxu4YzlEwnYluhEXRuSbefYLKOhFCZtM4SzdnT?=
 =?iso-8859-1?Q?oM0CE3yDFaCZuBh/o8fCU6hIpeSp+IGncmsghehN7ZVqXgnwop8WB9dCKI?=
 =?iso-8859-1?Q?aY3ibl9Jf12wa8YgAX/AqDt9zKjmIF0JMb2CvsTXH9W35CtkNMl5fSTSSE?=
 =?iso-8859-1?Q?rZceBIqxeA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DfZFuEImpJyTycThhH47Ah6yxBwqyBLYSvwJY4txnmBXT0CFuAALG8oVClcLfXAwtAZ4rvvZrzQe4o0uZQcDwdxMEdYC3Q1iCO20Vft3n/6Xx8qZOnxiuMBbLfYMb/gLpc3cayiwin+4KruaW/SCJ9i5v9aTh9bOrTcDCK3Y4f2d7BhFUWmaTG1bbCOdMBJG5DR/gVb7IXgCCxQaMV4T/pCuAWVAdvmVh5h/CDyJMuYcuZ80PjzdDatLoG3KJFeWuJer9WsZ9Nn/MfI5xn8703DlOEwXK0/6Xqf22CvQ3OenRYi6k3xSnGpto4aLwjZZg3OWPqdI3EeE17VqpLm0Sg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b51db973-468b-41cc-92c9-08de95d4636e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 01:07:36.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDwBZ0BM5tr42dQZgmWYVNAxAWBg9/quDuREIE3ZGhxAXWdywUhMZ6+r4WCbdzmGBhRY+C2xhqoo7/hE30ntlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3762
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=UflhjqSN c=1 sm=1 tr=0 ts=69d6fbfd cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=5-R6N93_VRwDrARBPysA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: WmMJQmwqUPNm2y-w9ZRXK-UesZ9vI75F
X-Proofpoint-ORIG-GUID: WmMJQmwqUPNm2y-w9ZRXK-UesZ9vI75F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAwOCBTYWx0ZWRfXwhiHq3uup2bL
 lYbuUiBjaRb7XcPwAUpk2Q+lU9orDe8I72bsmTiZ5ylfiHJsILdCvRnQhDhPMW156WKPVZYVsp8
 HiOQNe83msaWluojwtVZFVpdKHdPcMXPr6AXSMt7G2sUwaXoQu9idA31LIBFrLVTZ60dnpNv+lc
 c6SoCuNrsgIaH/YCZmVXaqNYG+TxxWsvdZiGH8bks9uq9ZmU1iE5qoWmD3lPdellgE0n8hKHi4v
 USa/hbXZiif0snwA8yjUggGNZScNFpuPQhkWLOnx4KuDtjRr8Qfn5x8BGV5B5ahAGoufNXrj/ao
 Y5EyMkWe+D/wmQZHpxjYVyT1OsdCPwaBdqJ3r8ERL2tpmB6JNhroDg0/qBphETUIQO7hLZ7pvIR
 6kK95RBK2wKfaO2zL6MYUk/OT4+ZmOXvmXXzL87JzsD9KvhZQs2O0cohrvQ1Ql0p7jJFKYctXJX
 V12iY5+hQlHnionMsEw==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090008
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235291-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0B1E93C52B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
hisi_ptt_wait_dma_reset_done() discards the return value of=0A=
readl_poll_timeout_atomic(). If the DMA engine does not complete its=0A=
reset within the timeout, hisi_ptt_trace_start() proceeds to start=0A=
tracing regardless.=0A=
=0A=
Return the poll result from hisi_ptt_wait_dma_reset_done() and=0A=
propagate it from hisi_ptt_trace_start(). Deassert the reset bit=0A=
before returning on timeout, preserving the existing reset cleanup=0A=
sequence. Move ctrl->started to the successful path so a failed start=0A=
does not leave the trace marked as active.=0A=
=0A=
Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for H=
iSilicon PCIe Tune and Trace device")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwtracing/ptt/hisi_ptt.c | 19 ++++++++++++-------=0A=
 1 file changed, 12 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_=
ptt.c=0A=
index 94c371c491357..73b93df8504c4 100644=0A=
--- a/drivers/hwtracing/ptt/hisi_ptt.c=0A=
+++ b/drivers/hwtracing/ptt/hisi_ptt.c=0A=
@@ -171,13 +171,13 @@ static bool hisi_ptt_wait_trace_hw_idle(struct hisi_p=
tt *hisi_ptt)=0A=
 					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);=0A=
 }=0A=
 =0A=
-static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)=0A=
+static int hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)=0A=
 {=0A=
 	u32 val;=0A=
 =0A=
-	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,=0A=
-				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,=0A=
-				  HISI_PTT_RESET_TIMEOUT_US);=0A=
+	return readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS=
,=0A=
+					 val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,=0A=
+					 HISI_PTT_RESET_TIMEOUT_US);=0A=
 }=0A=
 =0A=
 static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)=0A=
@@ -194,6 +194,7 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_p=
tt)=0A=
 {=0A=
 	struct hisi_ptt_trace_ctrl *ctrl =3D &hisi_ptt->trace_ctrl;=0A=
 	u32 val;=0A=
+	int ret;=0A=
 	int i;=0A=
 =0A=
 	/* Check device idle before start trace */=0A=
@@ -202,19 +203,21 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi=
_ptt)=0A=
 		return -EBUSY;=0A=
 	}=0A=
 =0A=
-	ctrl->started =3D true;=0A=
-=0A=
 	/* Reset the DMA before start tracing */=0A=
 	val =3D readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 	val |=3D HISI_PTT_TRACE_CTRL_RST;=0A=
 	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 =0A=
-	hisi_ptt_wait_dma_reset_done(hisi_ptt);=0A=
+	ret =3D hisi_ptt_wait_dma_reset_done(hisi_ptt);=0A=
 =0A=
+	/* De-assert reset regardless of whether the wait timed out */=0A=
 	val =3D readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 	val &=3D ~HISI_PTT_TRACE_CTRL_RST;=0A=
 	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
 =0A=
+	if (ret)=0A=
+		return ret;=0A=
+=0A=
 	/* Reset the index of current buffer */=0A=
 	hisi_ptt->trace_ctrl.buf_index =3D 0;=0A=
 =0A=
@@ -234,6 +237,8 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_p=
tt)=0A=
 	if (!hisi_ptt->trace_ctrl.is_port)=0A=
 		val |=3D HISI_PTT_TRACE_CTRL_FILTER_MODE;=0A=
 =0A=
+	ctrl->started =3D true;=0A=
+=0A=
 	/* Start the Trace */=0A=
 	val |=3D HISI_PTT_TRACE_CTRL_EN;=0A=
 	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);=0A=
-- =0A=
2.34.1=0A=
=0A=

