Return-Path: <stable+bounces-235525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJMyEO1D2GnfaggAu9opvQ
	(envelope-from <stable+bounces-235525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:27:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C28563D0C8E
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50364301BC17
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC8280CC1;
	Fri, 10 Apr 2026 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZZ/sWW5h"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0B2777FD;
	Fri, 10 Apr 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780809; cv=fail; b=VCiRAnhIrLWgYPR3YaTTLvC1uE+MKFzhiXdXZJJZdDnADajwwZa7L4NU87H8JHQJM4mN/pkYhXIoKJDAEJIcQF/25MKba6W/MOeA1avErmSYhFMcFpx9MRTzKpd53qdC1pKtLc6heAQxLdsqY3LTN5dji3IG2Vl7I6jqmc04zbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780809; c=relaxed/simple;
	bh=5YYwYiChPZSIimWZbuPJJKYRkwSa8kjAgQlV3DR+OPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e28ced5tEDxfdeoALD/znphXujCqMfMGyVDJlR3shYfbGuZyvrEoB7knjpe7b2jB5521/oAKQIf5zLs+VYwNJHMZDtI47/rGMZKIyAeGH5VziqGoskKpI6bY2HHtcKf372C9SJB8O1NFcdn50mIoa7cw+9/qFoglosZ2Wc6/C0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZZ/sWW5h; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NDv4g2630153;
	Fri, 10 Apr 2026 00:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=3o
	0NigIIEtFz9aBsx1xuSWDWIFR6al2dEm5tTlsT1K8=; b=ZZ/sWW5hMT+Zy41YaV
	XPWMVskRHutlRvk/XkDdUR7xfUuz2Cpn7vT8RDkF98sYyE08oif4SQn7NqVCmw3h
	nzjghNCscC7LVF4kfRd+8XGYrweDxA/fbcd1psROPmV7ALw1EqW1DC90maPvGM+b
	c6+BdC3GcdX5FSQlHloSU0GrBjTgcQgKv3P8SyLtCFHnb4W6tgaeiiBUX7LHxM+J
	HzIWD0dbhusXaRAUWd41xrJ91ddG85WGWUyWc1XtW2/7hn9bbYmuAe5M6VR2i3DQ
	BSuGXvR0UjDyzuWwHLs7tqpTPg08FqgBS5su6RCVcHEbwBiL6qX+lIY3v/8U2OkK
	TT4A==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dempbh2x5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 00:26:34 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 02795D1D6;
	Fri, 10 Apr 2026 00:26:33 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 12:25:38 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 9 Apr 2026 12:25:38 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 00:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEA1OwmSrDGdv+yYsb8ttZl0GpqX622bRNONxUJG/tIcRbDIdWnUOy5f16gxOqtk+3pP6maqL5MC/dHHjrW3RwDtuaSLrmWQy1aEdCJxxps0ZiehQwSBd25bmK/tnlivde/2BnIRRoJ2cr7qbc6CFrVqWAyXgczO7dVkI8ksMIRzGaVhBaPfzgpOJF+eKpqJbUQNyBJ8M2b7IfxZoOYx/N4MToApbrBWzIZsxlLnk+1lfSVx+wB+ePpecM3/qGaJKshhEkkWvDgmyz4LYnfHvNTflu98Dhnr810pU6q1NWI8nwEfZmabeEWZWsUraXUaKNBc8AEgthae9A3+ujUhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o0NigIIEtFz9aBsx1xuSWDWIFR6al2dEm5tTlsT1K8=;
 b=B1f48RXgAEgozNYxIZnTKVdC1SOcWtme372ZsNFX340uNPgQKQuAk9nKnlSQI3jRcVNoc1NWgvTgek+kOx7jkLw+ejpX+iO+MhXnTGMIS46bQIPgS426MEaT+7v39LOufaieZ3haQf7i8SNbmihoBj+rebHt5hiUKYtOwrw1qsWD/+Sfx2nkWodsAQJYk0Ylcnx51mn/4zxtGLF/iELKaDhg8V6l9TJO3DIV2KuZSE0etyj+HvV6AfLWzWfg7NulX4qOEKrtGN2q1F1ljx6lcDkHr0JP1uND1Uc+J3EIgVH75Qq3TO5MUevgis4NBTUFjRo8c83Q4MAyF/prU9cU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1706.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 00:25:36 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 00:25:36 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@weissschuh.net" <linux@weissschuh.net>,
        "linux@roeck-us.net"
	<linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v4 1/2] hwmon: (powerz) Fix use-after-free on USB disconnect
Thread-Topic: [PATCH v4 1/2] hwmon: (powerz) Fix use-after-free on USB
 disconnect
Thread-Index: AQHcyICMZfCkxj/a5UCWw9JyxNW6zw==
Date: Fri, 10 Apr 2026 00:25:35 +0000
Message-ID: <20260410002521.422645-2-sanman.pradhan@hpe.com>
References: <20260410002521.422645-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260410002521.422645-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1706:EE_
x-ms-office365-filtering-correlation-id: 95d16335-3585-4759-b4a9-08de9697af60
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: uaC+hC6IJpDrKuhGQCEamegGUDnG+qfA8lU1JgaK5QrFJ3qR7fHG5CyGJRuxQUAtj12+fuiLuprEFyq9d+AHfPOaD/x7sE7FyBD78ehyKvHcgtGzp9eiC8Fd8VKCfcrPe8HtNzWImsIcCm1QH4AzChRRPiqa4fV13SPzWx5mH4CFhORebSf/yPfOxRfOI9BGQVMYOTMiOsxCpqfmU9S3IvYr+0Lm5NHsuMGDOFB4mikX4iwyqewfkFaP53PPc8kkLu5eI2pkfT3StiYpZZ+8gIKl+bXcmlAPWY+AnUMVv930PrWmZXd/B8Wj/QTyN710acKFKECQD1Lu5tz7+xljkkeQcdyqH0zVNnYWYX9nQIjQodnUpxwTZQbh/sxEIyhaxIzP9X9Y5Dlzuwa0LkTTMcNmYqD1xuJWGVsMsD/sk8gDAaDhXSh33VvhWU8PM4pU/ZJAi1ZrNLqd2WDmgLsK3iYGCt9Hd/fXfPRdMG8yUUcAcQzG0CFock3zYXujX6KmsSgUMzWOGMDlQdod1FJVAAEhLADG9lCeUXvalYOB/3kZUFtWaoDV1DlNb5dXb3XdDKmr6ZNBctEedUbf4Qw/k+8NAJEmCK/M0Csv+h6Ro5G4xVFBWcqrHQPk6U3OVnzbazuS/iEJgrV84A4Hka4EUgPBuUsDz00JSFjNCAF8tC0n3clcowlWANfbYD7Em7k2d5DZuTib9xKvmnWsMmFApWN3qz/iNPybUSaiBX42ZJnauFPef61vIbqYpmu8/Ta+c2lPRJ+pxO6eMzC1WRUW9dDEfrirSWHGV8oHPfnDxho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ppGGy/FTzKIOEh/gCL5JitT/RL1pWXWVIQFzKw614SRof3GTEOKAMUDWXN?=
 =?iso-8859-1?Q?3yNDnA6TiaMtdJDrhFSIabmzE49rWmrvuxJbVLiRoAAGBljYU1Oe7DQaPJ?=
 =?iso-8859-1?Q?vTNjXOaWIT4CuyQdmfXKq/NTqQcc9g+pWGJdnFqqp82cz/sSp6wST18KSL?=
 =?iso-8859-1?Q?CqHKK1Z2qbCxBmOQxCeqKnZX5EshyapH+d6mBRIEUd8TjunLkZNfOgXyh0?=
 =?iso-8859-1?Q?HZ3PdN0zV4b5VOKUOM/3ez+dYFcEeszgyy204BCbRaCicU5D6rawp5Y57A?=
 =?iso-8859-1?Q?Ume22CaB2B5X8Vao/kdNsTY7cS3jh6HCf5KcO0GXLpR6KfH7F68Qh3k8ZU?=
 =?iso-8859-1?Q?UYK0JjX9Iej7njhQaz7ROUAcrmn6Y/8j0NZgQLrNz66DTmMdrniDcV27yj?=
 =?iso-8859-1?Q?PClWhEEaK3jem17+Wypnnyo15oaEf5MejFujrCLMrL7RUsVrjJ4WRb8G0T?=
 =?iso-8859-1?Q?mMb1Zo938/WZuA3b/h0tP1JUuTrHTBwWQXhyPtWBadbW8BlGAG0l8IXyEr?=
 =?iso-8859-1?Q?HTJ9XIGTSseKyljFZ4HzZVBspZ5JN7KPc/DyLCxVwZfkeO9DLKC5+gFL6I?=
 =?iso-8859-1?Q?UpOclu30UZkIs+H/EjEn8bg0AYAD+SEf8YjRHVB5hZaOqt1EYlgGoztVhM?=
 =?iso-8859-1?Q?rN0IPfLQRxF9gFO0SE2FJrFn3+3ANNRQF+kJGDnqVeLcqO4M4EoTm6PMoS?=
 =?iso-8859-1?Q?7e8rz7R/osk1503QEplAMOvjQyI+zdc/7jOWtskLaBbUjZgHw1NxY0FwBO?=
 =?iso-8859-1?Q?t9OtPXLVeLC3jr8krfekdlDBgyHS89xC7rmY62PB2XWyt9INNqYQOWqpms?=
 =?iso-8859-1?Q?SDrPHmzJAAvhwcO4hVSZthdJPvlGn3rVOVohnRi8JwsS9XhP15a8qHWb33?=
 =?iso-8859-1?Q?9ZB+XA763EV/0pF8YsWzcvpP15ZznZnaQWBR4IUNCHY8XXm0mrY3w0ct6/?=
 =?iso-8859-1?Q?PlWqS5Y1dUVh070DFXHkLFmFefjTpdZSrnZ/LDQ82OJWtMXQhHieAec/Nu?=
 =?iso-8859-1?Q?efiEPaZ6dtAXexMEJ52UvL6c05XZj7krckoArfaY8iz1C3+GTjK+ZO5bbJ?=
 =?iso-8859-1?Q?8M3Ofe81xur2NFZ1RBGdsaGv95qY2Xzm1Jh/3ahuN6ptZJbzwIlcDbTniP?=
 =?iso-8859-1?Q?paCA15/sRESNMqyBO4OJRqWIsjipa5cGXhB8itL7/g7CtBUzeVg+7GaSgT?=
 =?iso-8859-1?Q?tCXhrYCKsUBEnKz8H1rvBvmUBeIo1jSG64INZ4VO0VaZvYbETsjOxYlCq1?=
 =?iso-8859-1?Q?xgUoDuC7tXSnWhbksZZFFaxsnO+6zO/7ZxVLMaX8jsmkN4Kf3hB4hPRGmH?=
 =?iso-8859-1?Q?0nbHULm4+hAw0ug1fMXpvBN/+C7O2EOr1n1j7ZYeuaMFOMQEWntjhNefXq?=
 =?iso-8859-1?Q?QQUfgVQZLPvdbFCjoJt6LYOUtf/2and2YhjklspFtqINAo+q73+7R1S35y?=
 =?iso-8859-1?Q?Pgp9EuNnRcfyxCyUc+OTrUHGdaYnQjw1lmS1kqCzBphcGUD5kvBJdfdb4Q?=
 =?iso-8859-1?Q?jxpCVZd1iDIWgOdl9+bOn+cToitTbxv3skYbIzezDWa95DkXhvjWZUVNJQ?=
 =?iso-8859-1?Q?FIs8yl3rHuzhTB7DGS+0MWHuvp44GWSNTAAlsB16lKcql1+fkBUmKsDYjA?=
 =?iso-8859-1?Q?jR7zjiuPNi2fV13CVgy6GXz4KF78SK+q3cBfoLZDupbeo66+R8flFst8PA?=
 =?iso-8859-1?Q?SUcJ8D3o0RyvNEpDHuJdHeMyd+HSpSqyTLLn7Hpe72iQ5uBZm8X+gWS4f8?=
 =?iso-8859-1?Q?vxSLGFajn7uy2MVG3uvCqOgKJ1p+vI7OJ05g2RipOqFLTd26stjPSsjSaN?=
 =?iso-8859-1?Q?skd1NVQNUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wUaOSlYpT4Nii3v70rbDTyq8Q+GWYK2VoDi2ga8vsxav0Qeza4eG7eiki/DCT9bui6RWrfwbZYshUW4AAworOPgaZ3RZp369rLrAQC6f8rbGOx67w4a6Nq7ldDtaDP0Y6BHMIlLG5KnUz3hzBoyEuNFi0ICcz9AbKUeVNCzHVifmh4jkDU/kic5TY3Gkn7IX4axEZIsR+y6UdErlVKwPh93YWyMLWcN6HvwehQZsGv4cTvaxekcHHpsX1kYYb4s9s1dOkebKnUi+XYYjBDXuwY/o7luMq9EiCgZgAXWj1iSMsWsbFBPIW0JhJYEHCIXSoUAPazt2BJFcGfnoAPd01g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d16335-3585-4759-b4a9-08de9697af60
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 00:25:35.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h10Wpv1L0e+H5ZYm+/JlcJ9InoEzWsC774YLZqzYgROpU3ven9fT0hNeert/2OPFsnU6ix9MSirBI4AvEQcv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1706
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: PRkpAPDHjWXg3TcxyniVFDmQpuHS4VeY
X-Proofpoint-ORIG-GUID: PRkpAPDHjWXg3TcxyniVFDmQpuHS4VeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAwMiBTYWx0ZWRfXxzAC9jZDAi/3
 6awTPV3+YKfsPAq9sH6exdosvnGz2WJvohXD2JK1a2O1rRxtOfHDPYRNOoGHPueF4dseumzljRG
 k0MbOtIHFv6cGooTZue8b9xNor1RVGnC7Jz1weBxNakn9tCG0qGapMGx65w0I7bdiMk0tQxmorM
 B5C4WhIILgv/8ZhjlNsVCkkT/ya63lkUr4DevIx2ksCvI51sFtSLOQuhVV5Q9qhx9y0jpuaxIWN
 hWYLaMRtZz4xN58BjvNWAVrokkyhKNvuWmaCLXx6S3KGd8xfIv9u5adHAFroFSxT6Ls0lcvnhhq
 B5Fb6Fbn2sGebfnJEIpJgEp6PuQC9BwLPKIhR3QJFr71RdQToeLwIKCUWaasWnIR7cn6A3MfSgp
 +QZgj0NiPbzMXsroJOTOSpxvMxXWRbeLy180JwtKMcW++qFu1dXMKQw0od+yyI6PbuA3BX07Gna
 7P9HkXoKQ3Wme1N7Auw==
X-Authority-Analysis: v=2.4 cv=EsbiaycA c=1 sm=1 tr=0 ts=69d843ba cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=3haJ9R1Aw3gUfsUHDaCR:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=P0205ARm6hN7LfHzYq4A:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100002
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
	TAGGED_FROM(0.00)[bounces-235525-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email];
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
X-Rspamd-Queue-Id: C28563D0C8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
After powerz_disconnect() frees the URB and releases the mutex, a=0A=
subsequent powerz_read() call can acquire the mutex and call=0A=
powerz_read_data(), which dereferences the freed URB pointer.=0A=
=0A=
Fix by:=0A=
 - Setting priv->urb to NULL in powerz_disconnect() so that=0A=
   powerz_read_data() can detect the disconnected state.=0A=
 - Adding a !priv->urb check at the start of powerz_read_data()=0A=
   to return -ENODEV on a disconnected device.=0A=
 - Moving usb_set_intfdata() before hwmon registration so the=0A=
   disconnect handler can always find the priv pointer.=0A=
=0A=
Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v4:=0A=
 - Split from combined patch into standalone disconnect fix=0A=
 - Reword commit message per review feedback=0A=
 - Drop usb_set_intfdata(intf, NULL) in probe error path=0A=
   and disconnect (unnecessary)=0A=
v1-v3:=0A=
 - Part of combined patch "Fix use-after-free and signal=0A=
   handling on USB disconnect"=0A=
=0A=
 drivers/hwmon/powerz.c | 8 ++++++--=0A=
 1 file changed, 6 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c=0A=
index 4e663d5b4e33..a75b941bd6e2 100644=0A=
--- a/drivers/hwmon/powerz.c=0A=
+++ b/drivers/hwmon/powerz.c=0A=
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_device *udev, st=
ruct powerz_priv *priv)=0A=
 {=0A=
 	int ret;=0A=
 =0A=
+	if (!priv->urb)=0A=
+		return -ENODEV;=0A=
+=0A=
 	priv->status =3D -ETIMEDOUT;=0A=
 	reinit_completion(&priv->completion);=0A=
 =0A=
@@ -224,6 +227,8 @@ static int powerz_probe(struct usb_interface *intf,=0A=
 	mutex_init(&priv->mutex);=0A=
 	init_completion(&priv->completion);=0A=
 =0A=
+	usb_set_intfdata(intf, priv);=0A=
+=0A=
 	hwmon_dev =3D=0A=
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,=0A=
 						 &powerz_chip_info, NULL);=0A=
@@ -232,8 +237,6 @@ static int powerz_probe(struct usb_interface *intf,=0A=
 		return PTR_ERR(hwmon_dev);=0A=
 	}=0A=
 =0A=
-	usb_set_intfdata(intf, priv);=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -244,6 +247,7 @@ static void powerz_disconnect(struct usb_interface *int=
f)=0A=
 	mutex_lock(&priv->mutex);=0A=
 	usb_kill_urb(priv->urb);=0A=
 	usb_free_urb(priv->urb);=0A=
+	priv->urb =3D NULL;=0A=
 	mutex_unlock(&priv->mutex);=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

