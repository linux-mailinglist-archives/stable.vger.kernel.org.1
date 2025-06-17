Return-Path: <stable+bounces-152756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C966ADC3D0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 09:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC43B82DE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260028ECCD;
	Tue, 17 Jun 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Gnk2raix";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Itm/U33Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B82143C61;
	Tue, 17 Jun 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147085; cv=fail; b=G2gnW0JWlysu5nc1i5F3ji21kimu1jQXHUEk41YYECSgu00xdviPRbLN5f5S7c8jWj5WeEjhwnXtrin9+MuLignYYmot0o+uxPZ5/pW6k6UBo6p1A402XLJiY9pO3kI9nL9d5kJevnWz5GouHjuBTk611+r/2oDrbv9L/jHemsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147085; c=relaxed/simple;
	bh=R0YuGup7oNGzSd39b6WcIr2pkcISejiOTbY0RoJfigY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJ0djN3+FZ1m4j7nIqSEnpobakElJB2QTYDClL2mfrI436XwTZKlxv93TZwkc3cYNW3mlUFRj9AotST3YoQ4ExUwiS0WoSyrRqwAC5JUn409dkx1/KCsxz1Ov5znTO45v/bPpFuBm9VRn8Gf3pPBDKq3jMT/CQAQPISuyuCNczo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Gnk2raix; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=Itm/U33Y; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6LYgG020916;
	Tue, 17 Jun 2025 00:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=jFmmUDW27CXpldBtFauuofXOSzY4NSUta310KaxpEC0=; b=Gnk2raix5wzJ
	W/Xi6Josv/FpuEH+QgzMs23aQRRmTd5OeyjqJ+bt7lW0vW9Hi6W1pMXl3IjoQHAg
	pgMTssyEIvzArTfUP0VSImTyiPwM2fOH2Fkk+XrYBmN8VD/bK/olaFoi0cqZ9iVo
	Ld5eADe9alHRTQnXfSP/teMd04SuHHh9876gWPFwU62YohRpsldiDCI/clcl0P/2
	txAFPP+XOMlLfZsh39rBTa+H6bbvlmBFladXxXDa1CfkGjpf6398RVftWH/2ZGqC
	KkwdcT730SgWDrO5kp6rFBaj6FtRP/FIt1S/u+9bchZTD4q/ykIZ+qApoFsJXncs
	vkpYL9wd9g==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4795mxjtwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 00:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnGQiXOcXjJkZpaXaEdZN5r40EaL/qBCL7zGN1Ry6seMS1H9CtqCkV+VAcrM/5PcJSXOeP69roAGxs7yXADIbjk0HqcG0/Pgj+Yek0arVZOuCRIcopZQyJRIE8aMYDPpCVhasRqtl9KjuoAr0X6YBAA56m/FsO2z8SnWaxEAbdqXkGO5ZDrxHUOoMd1Bvr0XYQWhnmJ5yK/Uv0eQPy1QqSI+yghF4Vs/z9vT84URgrVoBSoH1m5gAWiX+G9Ldk8GKFTtfHWLSC/Osn3snR/V48QBb1GGDmnFhTmRESOQiI36brJ7l+JWpPLRdBVojmUr/IBfBLGjry78oi+vAe8tqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFmmUDW27CXpldBtFauuofXOSzY4NSUta310KaxpEC0=;
 b=A/pVcNkBf4uN/rAOFh03kppsp+19c6cS0C9RcF2mJHsUQHQfYUexrnPAmEkkw4D3YpIZ4CLd6wi/LQOFkdpRQbAG91KYmu3Q41VwcHZ94OdTlg1gBarxA1S0MbYmq4DWbw9jET+jEmZYQbAAAO48yGC0PNQw93bN/yw66JjVp2mDSzIriOr+uMBH7g/2sqh/9fq+lXfCE+/JJpGVNIn3kILP5dCwA4Dw6lXbYW099OUMT/tY27gNnRgH6GfO3iaHTzl3I+sI3nrVmkBN4w6UAUpzLQOxID5TpCDADznbCk0Le/thBAGRF2AzG/oOnGucrrtwbuDBnAckV9E1o39NrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFmmUDW27CXpldBtFauuofXOSzY4NSUta310KaxpEC0=;
 b=Itm/U33Yn0Jqqq7aX3nN+W6nlwRX5yZ3Fl+UtIB4RTVhZXk+vK4EYLqTALVayOD9TIjo+h3/TtChh2G/UHKbntOXMwF6/3Rf0f4wMlCpBZgEYNx7E2IcyA1zC9DpbEj58KmF8sPJMD+LbQ1pu60I9C+NsYhMAuc99i+JWmRjDcM=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DS0PR07MB10330.namprd07.prod.outlook.com (2603:10b6:8:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 07:15:06 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8792.040; Tue, 17 Jun 2025
 07:15:06 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Index: AQHb31cLdpu3CalZOEyDMFRKSy2Xv7QG76hQ
Date: Tue, 17 Jun 2025 07:15:06 +0000
Message-ID:
 <PH7PR07MB95388A30AE3E50D42E0592CADD73A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250617071045.128040-1-pawell@cadence.com>
In-Reply-To: <20250617071045.128040-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DS0PR07MB10330:EE_
x-ms-office365-filtering-correlation-id: 4f73c955-add7-44b0-caad-08ddad6eb014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9l7IWV5PjyX+Gn3UssbFvAcK5dspHF/nehDL4OrIz7JU9PeDf/iPLwi8LGcJ?=
 =?us-ascii?Q?1fdxW9E8lQXsMx1xU15lpL1wpXyHXgrmLxDZycCym7KqNRuxYX4l8yceOd3D?=
 =?us-ascii?Q?zAhp8DDE/PNlT+HdF+x2ZcYwcI2B/kvUiIHFi+/HqSKX3geWAIWa+aTipgeH?=
 =?us-ascii?Q?w/jN9oO2wjC8VNWUCFVBbKUKfkb3bPflKFZwqrqEhgJz/8XtxTXC1DpoDS3F?=
 =?us-ascii?Q?kra26kMxYZuor9jRkhIHpG+IJ6/8Vdh4g7ykdvfvXHNKALTN+DUY1YZ/nswl?=
 =?us-ascii?Q?inJNfrfSkQYJ+41xyNu/DRni/IJmduSv9xci9+Kxj5Yl75IYq/autJ6P+s5w?=
 =?us-ascii?Q?SHVoEAulWvYNLqjWLp8flyTdOBF+/PO97Z/0eEt0Zl9P5tZInlcfmtIf3HT5?=
 =?us-ascii?Q?fzI0c4JQxX1EzQTdvQstC5hEorF7wuAUxRUeix3V0f/ucup6p1MY3e+vHOiq?=
 =?us-ascii?Q?sffgRQqdztyeUxZshb9sm+wzv0yCYJnuBF3ytyJyHdAzYEKGRLNyNrmygyyX?=
 =?us-ascii?Q?rIaC4h7HWT+H4ii4Yc7Gyjf4vxj1AgNJuX2y8sgWci/Okgllw+h0bqad9r99?=
 =?us-ascii?Q?abHbdKadOFYBhnV7TSH8L1xq5Sluc7nV0IxjIhzpH2IzYlLQ6NntX/c16l8C?=
 =?us-ascii?Q?e+PTKx90hGo2NwM0qxY/8BR1Ti6L2XGW6mKAQl7FpBL9716BWOIBSSUuig30?=
 =?us-ascii?Q?8v5pN6iICZxo01T38YW+X2lA5KGMbBz04DAp/9xUxW78qfci1sVA3MgH0e7+?=
 =?us-ascii?Q?/UCtCqyRx77d8h2rWfnCuQsFQFdox02L6MmuM2zBvncTygvUrhKRUaCppfEq?=
 =?us-ascii?Q?bUjDnqaAoXmpnGrGzDkdyEcOnRt8gn8EVCSjFP4QfCOlaQjbmCkrQUOTKWA7?=
 =?us-ascii?Q?C+n3qjmBCq6HgptcGrpQs7HnSqeRjoYS3uq3NcaU9BvG69UR9fCXGX6tP95V?=
 =?us-ascii?Q?iJN4lOGgd/afMUdPtzbxoEU1qJ1pgGJoRIegpY9EsdneaaEbkYNZ8lmC61YS?=
 =?us-ascii?Q?Hc4KhYNy5uVeVWyldhaXFZcaQGd1gYBUjyCjNvJV0vt7eZoBBeNJ3UlDpuEb?=
 =?us-ascii?Q?Xf7BepfEf7ezLm8pXMDFKIknjxMiBVVAXeRxcFGImZwjhlikq5BdSaTMS98v?=
 =?us-ascii?Q?nCfu1Y4kOJx+2UjYIR4wciqI7gVaV/XcNmtlknKqFNWdm5HAA6ldHsMejh8Z?=
 =?us-ascii?Q?QzKfra9x6HevXX++2oTHMncBzNKu6ffQhRsJeADggcFG2QVFw36utn8BGhe7?=
 =?us-ascii?Q?GlhTFmphscWPGiCHgpkB681v9CQclglwbrn1jHiPqa8CcHe7rdYPWlH5pX2c?=
 =?us-ascii?Q?/oqS5LjkZZiGOzCDSJHlwMbEMoBTj+vd0gL1nENgS4PQDhjMLPCAno04OI98?=
 =?us-ascii?Q?ehwpZkSJVG/O0zubTe3PHfqjAvc6/RZ272xIjxfnDrjUbEFDvCbztdoatmY2?=
 =?us-ascii?Q?Xqq5AFnhV/uW7dbu8UBptdcPjq/Y0darxQmas4TM/2h0RUP+xSxgfw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jUyWI4hfFBmMqqMUkE0pFwPe92bvmZLFGpkDx0tZucosDr2bFcQmI8kkDMF1?=
 =?us-ascii?Q?/59OyvVTlLrFHaL4i8zvDyquOfSePPmE4nqA4yr1Z3f9IHM8A1+kg21MnMwa?=
 =?us-ascii?Q?+GfjrLLFQszFlR45RpwSQarrVP1a8N1IZO3d8u8V/oyMuK0dPQirDHAKT6xL?=
 =?us-ascii?Q?Z/MyTnYAB5d4gj76HheDNAKuYghIVDXcjYe/kEZW1TuZL6KEd8BSLC5golkN?=
 =?us-ascii?Q?m4aa1JXhDBHUHP99fnlok5YA5a60fPRYHxwMxF6aQKs5CYbyqypmjM2Uz/6E?=
 =?us-ascii?Q?rPkR2ZJIXcW0d4cLB5MvFGyGxXX16lQgaAPYFjZ6nqCfdiUsJQghmsYL3SBH?=
 =?us-ascii?Q?tkgx5pcohoCP6MRcQp5bT0AZTxD5hPiwkdsfhROtQfpHz9P+hZ5/c+uxR8A7?=
 =?us-ascii?Q?BeAbHd2mbjz7vPgN6+awKzNwezTiCdk8nomDpzY6D2Ffeh3x4L8X8wrfTtIt?=
 =?us-ascii?Q?ct8SxuSPBiK/pAh4DIwhqfI1QjrBXKugSua+CHnwneXzhA/LXPEZR9ChNQuN?=
 =?us-ascii?Q?HzFePqnRhzSogHDGpN4De7QSi9NxmA4lUu1vxHWQxUGUf7jaHNS6Ig/s4nHJ?=
 =?us-ascii?Q?rwg5cUfEncgtoZKMqE+qmmyLun2+rQiN/SEgdrt6ZT6LIdA33V61z+kpox/1?=
 =?us-ascii?Q?jY9iDU48IeoQaXrlA6iB0bo7vdMvDnIY5zO3AOQkd5Ix/42Y3aQ4JOgHg5zh?=
 =?us-ascii?Q?gaGta7jK/wsGqJZKFhhap6xDhXeUjgVo3ykbfiEROWtdvAm1aen6fTqgksrb?=
 =?us-ascii?Q?658EskE3KkcAuNHzJKXJgZhg8Q1RiLlubgyjPPbGjlIXS4vtvpCL5XgTQvX6?=
 =?us-ascii?Q?r8deMhRJDtvXIGtqiFgLNFLJSP4z6HcOfYNcgQEEpJG2IqpGsQDmk8jlfRWK?=
 =?us-ascii?Q?7htgUbhX6lapAPtBtoWEi18lkK3uA055RcjN7yCUTPwgaIifoPEEneuTmvXT?=
 =?us-ascii?Q?P6kHei/oKVTIql6GUI0VLeWrQw1Fm4t69ZfXklmOzcY8Q94/hrJ0dwiakXNN?=
 =?us-ascii?Q?z3xdEM37eQuDyINSjP1LSkb0dNQtEIJSNBEHM/4ihWLdAki7LUgE/pcs8ZfS?=
 =?us-ascii?Q?Ju28E4WW/12Nv8wuKhDHaOPpG98A5XLJxRFu32fyjT57snoa9whjls+t0REy?=
 =?us-ascii?Q?34oqxdCarH2YEw9Uq0AQrqhaAENvoL0ZFlh0a0L/YnFgyhTRh/Aq2OSyekaX?=
 =?us-ascii?Q?UVaP9OofKuX0d3iQW5Kco7QWBi7cyoaAOIDSIPz4yVXTS1IaVhaUV/LDhSHB?=
 =?us-ascii?Q?JN2VuzUBBn/P4wxx21701xMaW0sswfEB1EZqndqd/q61Qztc3qwHk6u0jGzl?=
 =?us-ascii?Q?nR2H3KSydz++7Jv95rzRlOLdJ+FM+93dcq7TtL68e6OuAVc6r4DsY2feFUsC?=
 =?us-ascii?Q?fR6dd2qJcoW8Y2cS+8k4QDhQS5RJ6sCSXK7AnFUSLtLWx07SOIUOuUMnof4U?=
 =?us-ascii?Q?PTYPCTeTgUD4WO1+xJ/4d7m0XFYnPaPyBU94KJAu1BmfMXa2H0kOY98I5T0P?=
 =?us-ascii?Q?HlMBd7sRrKOFcJpy/WtybrlekM8oyR9nVi2yIdLiCpEFHREpQiIFBn6FUxdN?=
 =?us-ascii?Q?dnjhdsfGvAT9imBrDvadYsNNjFjXgGkU0lmCVYcW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f73c955-add7-44b0-caad-08ddad6eb014
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 07:15:06.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AYOGAnorfg/+nfJkRaf5+PRGnh08VF5HJV5Xh7OrggKnLnNf8NxANrtSbi5tUwbhmmsSVQMXea7u8paR+i3Ad7OTWNzmK9lhvSaTdzBGsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR07MB10330
X-Proofpoint-ORIG-GUID: fvPA_GV1itjNfAiLV011Yh7kMeZwP7Hf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1NyBTYWx0ZWRfX+wD8JbcsftoT fYwk/6EsNIu2xuP1FU1GbmowSgGgSaXfNppmpx29pl8zs3Zf43qLuIPNNuKRbys6hA/iKnK2NDn wGL5GsmsTqHuKJft/shvG4CXv2byHa+O9mVc0V9TIF7FhyRA9xBgHitdCPhyoLzGapQy2gJxAjw
 dCtxRzJjyA10J8k/Z6o5l6YWxq5AWzIxccFv0HczcE3bmErfGj3VAnvVJ+3BbnXR/AxP71qXKz9 4ZxGtAp9WtfjOixVFEFn0ziDBP9B6SlGTsNtK8zxqXfAIq/5B/Iy4919HOjRgYHK3Za3jJ5HP2K /WcBP8stmumr0gn96c/d6i4r7Ql51/2TYEyUe7gQOQSy/bNfPhXqW1OnG3ib6mYSUbHlY0CY9dE
 CsBJV5NOURqALVEozRQ8uK2za+71p/p2843a19PbdWUlG5vgp429sAdNXk93uC9kVkKN/ZRo
X-Authority-Analysis: v=2.4 cv=Ks5N2XWN c=1 sm=1 tr=0 ts=685115fe cx=c_pps a=AGqRr5+gp+4rguc5uJDcHA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=MGusajUyK0823r2cBs4A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: fvPA_GV1itjNfAiLV011Yh7kMeZwP7Hf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 mlxlogscore=500 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170057

The SSP2 controller has extra endpoint state preserve bit (ESP) which
setting causes that endpoint state will be preserved during
Halt Endpoint command. It is used only for EP0.
Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
failed.
Setting this bit doesn't have any impact for SSP controller.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
 drivers/usb/cdns3/cdnsp-ep0.c    | 17 ++++++++++++++---
 drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
 drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debu=
g.h
index cd138acdcce1..86860686d836 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char *str,=
 size_t size, u32 field0,
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 		ret =3D scnprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
 				cdnsp_trb_type_string(type),
 				ep_num, ep_id % 2 ? "out" : "in",
 				TRB_TO_EP_INDEX(field3), field1, field0,
 				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				field3 & TRB_ESP ? 'P' : 'p');
 		break;
 	case TRB_STOP_RING:
 		ret =3D scnprintf(str, size,
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index f317d3c84781..567ccfdecded 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *p=
dev,
 void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
+	struct cdnsp_ep *pep;
 	int ret =3D -EINVAL;
 	u16 len;
=20
@@ -428,9 +429,19 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 	}
=20
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED) {
-		trace_cdnsp_ep0_halted("Restore to normal state");
-		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	if (pep->ep_state & EP_HALTED) {
+		/*
+		 * Halt Endpoint Command for SSP2 for ep0 preserve current
+		 * endpoint state and driver has to synchronise the
+		 * software endpointp state with endpoint output context
+		 * state.
+		 */
+		if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_HALTED) {
+			cdnsp_halt_endpoint(pdev, pep, 0);
+		} else {
+			pep->ep_state &=3D ~EP_HALTED;
+			pep->ep_state |=3D EP_STOPPED;
+		}
 	}
=20
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 2afa3e558f85..c26abef6e1c9 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -987,6 +987,9 @@ enum cdnsp_setup_dev {
 #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
 #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
=20
+/* Halt Endpoint Command TRB field. */
+#define TRB_ESP				BIT(9)
+
 /* Link TRB specific fields. */
 #define TRB_TC				BIT(1)
=20
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index fd06cb85c4ea..d397d28efc6e 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *p=
dev, unsigned int ep_index)
 {
 	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
 			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
+			    EP_ID_FOR_TRB(ep_index) |
+			    (!ep_index ? TRB_ESP : 0));
 }
=20
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
--=20
2.43.0


