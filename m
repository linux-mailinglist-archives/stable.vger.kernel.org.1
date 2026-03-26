Return-Path: <stable+bounces-230537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MRPNIy3xWnxAwUAu9opvQ
	(envelope-from <stable+bounces-230537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2533CC41
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47BF4305804C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B689345CBD;
	Thu, 26 Mar 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="E1nLNoLi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA88349AEA;
	Thu, 26 Mar 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565151; cv=fail; b=Kb2dg/krO9ye2q/P2wZEqKhzx3ywmuxxdSCe6OhDyG93WpuCSpKiFTQ8a0TM9z+hrJh2/9AElF5mys7+g38p9pd+OErhsYGPoZRNjf79QovpUirBwNvW3sJ9F28/9UgCfsAUCIoD/IuI5W8KBwDYWqlFEORjlJks9/eAwr0woVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565151; c=relaxed/simple;
	bh=iNBIyUFxTRI80OyU2cdYR0fsu4TroVCwOJY7AGkRLvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9UAdQIV4+07KE5EWF9Ycvu/Jht5kVT6cFevgdADlNSblWsI+ZkZ/BCggbfTRWCnu1fhJOSIp62zSva2B+S3VLsHm64Wj7NL6zNXdAH+COdRyQ3+SjgsUwKh4mepI+lMwHQX2IPuhSLdXuAtUQFfRuveBFLh0YLumnBgtTx9drk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=E1nLNoLi; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QJTqmN3193365;
	Thu, 26 Mar 2026 22:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=5a
	W2pv5RSHVUwbTMkSaYloHZtqkwLSjNW+hLAiOvJUQ=; b=E1nLNoLiZXUhD7PpyH
	TP+TVY3PawBH12XGzBpEHtn8tNXGK76f8QJc/tvOJT6B1H0WiiS3rKhNI3H89rUf
	K75hfydSxwnMQQLcSijnbYWGyXDWBAAvv4aNHUqBTA1ASTjzaS+i1L7Qnah/uN+N
	VONiAZl+hIjkcBZBGN19otIVLYe7PI0sGbDCsEpdR8uEod1jZxRADf43XZ163u1D
	hySqdxubYEpEX6qHWbIOaJdJVC0dApKG/ZsNZbnO6gurfE9xQVhtfKB5QztTXRdv
	UVTg2meVVtHFQc8CYMnQnIZW3EPLciZSu47N2N+cIZ9xmAumwvx2lbWhULVGqx9z
	GUBg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d53jsg79c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 22:45:28 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7539BD145;
	Thu, 26 Mar 2026 22:45:28 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Mar 2026 10:45:25 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 26 Mar 2026 10:45:25 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 10:45:25 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOk2DWngckyJt3olFnagQXNk1VfijGlorOpbHOg59DP8oxn1pRTil1tm7uRZ4nVQJU4yVGrSa3c2yQ8iDVf3jqNslgtesNCknKmlks5wdfbqs53SjCfzL8i/OONQXNSVd9zvFiH+gurd803beAHR/bnJh1iLqVaR8D5RCzGyJ/gAcp5PjvuTH90G+c8rvCMwb3n0m9No77ZoHxEoL5fS3xxg/OzjzYtxHk2kT/9ZxVYHvTUvECUoSOEnG4/5JNCILrjskBgAjMHdVhGgAg5naBIASCtUMKnej+Sr77OtXQxoO28TlIMJQj2hiMthxjnN2xaLXNz1lLVT+2D4csEGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aW2pv5RSHVUwbTMkSaYloHZtqkwLSjNW+hLAiOvJUQ=;
 b=sUWNlg/N/E6pi/G+N91JK5slxgkzTIQYpD+9xa6fDLqByiuSS71tVdafOvxqtf7cMWfc9NpK9Xr8sWEYDlmF1YfjIG+00uX8sg8y3I+sXKGWcLad2zfJxEPtAZFVg4idnY+twieDiSZ2QXAynmQixnAnEqUAyR+gHQwKnYcHj2vfU1JZ7I0vG5xlMVYSGP9kR+PD4ajS+4MJpYNXL/U+YwtlnficHgMM5qTiv3v1fhRRG3Kov2AQ1q3cuMwuTClnQkfG+YK+Dt04DmdNqgfXvEPlJB2mBNBLOW7zVGSpQXzxQtXGsnxHmYoPETlMI5qEWgP7He/yQAlbWa/peCT0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV9PR84MB4031.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:2e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 22:45:24 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 22:45:24 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/3] hwmon: (occ) Fix division by zero in occ_show_power_1()
Thread-Topic: [PATCH 1/3] hwmon: (occ) Fix division by zero in
 occ_show_power_1()
Thread-Index: AQHcvXI711sLNoizDUSMYXYPLCskvw==
Date: Thu, 26 Mar 2026 22:45:23 +0000
Message-ID: <20260326224510.294619-2-sanman.pradhan@hpe.com>
References: <20260326224510.294619-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260326224510.294619-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV9PR84MB4031:EE_
x-ms-office365-filtering-correlation-id: afac95e1-d3f2-4b53-7501-08de8b895e2f
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: i20bPHnpUGcmFwWi0jpLDcUXyHb+2hJbZpkLINZ2uVmt3Z8PBJpCE9fjv8eJ03ttCUjpeye8BFowe6SH4u+24GgM+eRLiyC666F+G4d1MBcJ0qdkDkOl1IIODp2WJypWtO9Gn2/ZT6T/8jP7DRjqGqyxCupWPO+HgKhFTEtXtX5LFwqXNrgqI3nlqX142pGmDIhXWlIMBQgqp82XqTY2hCc27605Bcw2UIjvmmc/XjTJOinIi5YjhWEvNnYCx6RFbNCSdtB+ZmEa1giitnXmdd6nO2tn6sJNFon7SeeVDnXta8Z/6v5+5sNVWGL7ZFhOGThn9LZhZR7rqnECeMaDJGaGM/c2OggYHzzHN8m/1B3oBhr+7lB96ls85xBD9bi6c5tW7rgafJle/CPAd0Oj9V4ox+KwFWfJ7ZtAbT/gOa4WfI8UYjoqwy1NXjzeYlNewyhbcsEClX6lZoU3XhA5qkh/kX1NQSQFSWYkA1cRMyx0oWmTqpJxOxfI57Mcl/JlRZgKHBvAklzDrDz4jpZaQI4EBDAbH+N2sw9K42UkLcvWnbmP0aHVkbGAqdaEcVkJI7s+Xicvyc5gjCYFn+RQgnvigmLrtEanZLg0dZur9eCtL7LYCaU8OCltAzX67al5NY9UjFPy4AkJCOX7jCl2iM7bf+O3BdCFgPU/QJPzaOYcNryx3JKaFydmRV09y5jXbCjMAV0NymyZADrspx8CSUbvldHOkDAiMFA5VYuscOfyvmrhUInPBr/MJzoorFqFQWSo/3WoF8X2aHxe5HKxmdtrvkpSIGLuvryo83mFuXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CMDl4IFNywtVIs+stJ+NJd8V16l2z28bM1A7uPs5Lt/+yjV/x/FbY6j8le?=
 =?iso-8859-1?Q?A0sVtk2dhHF+pRooBkCTMC7u9gAa6M5zl4Ns423gIau4H28IGwTGv1/rWe?=
 =?iso-8859-1?Q?hKc6u8zd/19BCHPXED9YXXP9us9jEHPFkjf1ooiKgw+mIcp8vuuPHS3Jt1?=
 =?iso-8859-1?Q?fQKjbzRF1nWwmntxIj2MoMp8x/U9042fxi47IE7gzpsfe2hx3N3zNF5dgs?=
 =?iso-8859-1?Q?frODvL4zepOMwTalzZzUmQcy5JaopWSu5BRhi+vU24bKSfeagfHUZdswq9?=
 =?iso-8859-1?Q?S1uzUHrYAx/QMVetTIfzaEz1lPVPO7AS8ibMMRyPpjQCoEE8+nIrecbEVw?=
 =?iso-8859-1?Q?RHT0RQRiDUoOcVyHYhFySZDhG2PmryAQK3t8sdAg4bzV5aEX0QE9dvWUHP?=
 =?iso-8859-1?Q?St753+ecVDbYQcBejS5ePPTmAlY3p3pi/Xk2QU1WYnolGcLZHNhAJr0SmM?=
 =?iso-8859-1?Q?me7lA5Pk/CLw3tEKnB7ZVbHzjZxIWUyDfZDEecU0DUO6A1jyRSaanVdadN?=
 =?iso-8859-1?Q?mlhCNYJN0S2Ya5u0k1RKAoBIyfA3tcssqn30qNVi5jjs6amPT5T0Dkc9s3?=
 =?iso-8859-1?Q?AZ0pwE1RqjWLFeZUEgbjoYeDe5sgylLlhPKGHkbu5+Dza6SzmItjn/bZEu?=
 =?iso-8859-1?Q?yQCMkO+AnT7VWAT3jJvUHlqnywtfxXNZ3A95oFAw4Olo5nwXubcxGQdW5r?=
 =?iso-8859-1?Q?qBcrXP4Rd29viSOf6YHjHzK5XPlrroAY5qH2ZeLhZwDo6GKWO12G5neTsz?=
 =?iso-8859-1?Q?SWydDA93uqFZj6tvbKwV5e27zu60w1qnw9yDMuYDu6lz+AyAu0TV2lOQv7?=
 =?iso-8859-1?Q?reX6q9Q1sqQa1VBjFik0y6BQg9/atQtY1NplBVMRefCZLbevmdpKeLwwDf?=
 =?iso-8859-1?Q?b6S5Dmiy3XN/yNhviVC0b88m3bUDDQ5d9rbtXuOYcY5vRnYUX0oeX5NkSx?=
 =?iso-8859-1?Q?RmeOj48U/pP0zxAx7YPSP6toVoZ1lCR+naLUbBOXekBsWrgM6Yvk8SSkf/?=
 =?iso-8859-1?Q?VyC12aoHdThe+IlB4MuH2iji4z1ZiLGN1ReTIKRYRm1pSmXxfjldCpEQWW?=
 =?iso-8859-1?Q?4ywiYFrNj8D2sMQFWT5SrovxUCwRfmEGDvbx/WEdJvhzUh7+kpQQFPH2Si?=
 =?iso-8859-1?Q?Q3mvIAMFJjNdQx1inu09/VnWy4j3bAdPuujZ0N+WFBTyCFBIH7KwOEpUKH?=
 =?iso-8859-1?Q?Ht/seWZo27cosfWXW0gGNIdIZbeM/mMjud4dyGeQf6JJ6mKX47TSVSAtNY?=
 =?iso-8859-1?Q?G7YeWQC3Nquycpy1TuHTBX3uIHJfTNsmrjEpRCdTkndqnlwJ3z3Bh2Ny/K?=
 =?iso-8859-1?Q?92OzzOzGptvEK21MLRz7F1qli5GEApTOAUambVuxTY/VIDPVyq3Bbl0fz6?=
 =?iso-8859-1?Q?mHI/iBaEVi6P2hNW7iKGI+HHHPo9CjZs6KNpnCKd+8B1iGdY9JMcjt9rau?=
 =?iso-8859-1?Q?dxWzHHwoGZfp4UDGf01Rvu4TVRdSz7jg9fChvsW7eBme4IjYPAa0PEcI3A?=
 =?iso-8859-1?Q?k+oFwoF0Pt7sxhpl1CRL0iXaj6G4StKFcFeGYILeWZpt8l3kJoek+yBVAC?=
 =?iso-8859-1?Q?Wcqg124MfCFLVs5rWIPl9ofwLrcaMrgvAx5fPMffZuxaKiKuONY4MSD41v?=
 =?iso-8859-1?Q?0pfKT2WNvlZrmZGUlFqXSWhkR6+pYIa+1p9Xz+8JX8yknP5lQeN4fljJVm?=
 =?iso-8859-1?Q?3+gWy37M5UlLsBmBj4UO4cpiT7rl7Ye8468u4Zo7NV3Yx1prQB2oj11hyo?=
 =?iso-8859-1?Q?ZN7+K75it5cH56GfT1L9ySvmKmaXJLqfqbut+CrH+3y9G/QMeI6c+Gf8j9?=
 =?iso-8859-1?Q?EJZtYgQjOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EEx+0p0C9mbsp6vOaq9aUOlFNCtWGIz3BVArU/v04h+mTTpCaQlwJwT/1gjY6ZOnpzAzbnqKMnUIMaBisgIP+noHWGyy0nNLg8KJz/zdOYfUp4pVx+aSYxwFZCPaI+eLDoXbFxpA46mZQRJF7TFF9oKByMjZmTW2+cZwVBxLLGu6/3698230QdAGz/oOc8p9vb9Gb5QWjT5satrvH0/LbTjayNk1/y/h/Rx/rD8pzWkcxVONXs3lhXthbp4F9LHhwkB0Cq+ltoNvk9Jt23vTVZjrF4IaOPkCOsxh9ql4NArBV217ngOMfyFBG6ew313N9mCx8Xnw6kCJPqq8iPY2AA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: afac95e1-d3f2-4b53-7501-08de8b895e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 22:45:23.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtMsk5WQazAJpD6tMQyAlQDCeG3e0wYICcNIbVPXwT7mmiCH6Bj3sud+u3KwGx+efgKmDDclZoQffWRKrcugxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR84MB4031
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=AtvjHe9P c=1 sm=1 tr=0 ts=69c5b708 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ay80y3fxfMS_JZZz1qJy:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=jSU3llf1bsbjHENDPsQA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2MiBTYWx0ZWRfX78bifvAuuQtk
 kk8UpPMPE9s7yYtrQIAIcYypxbz7Nk173ZKymv1cfHJBprD+6HSGOyK8NWlk4u7SDdN2SlHhfN5
 kDp7dzON0cLM2X+4+UPmaT1DY0MjBv+8yF3J66XnxkJ610TsEe342HmE+EYZrpRHChaCLZHnju/
 JMpVzSFD5Uw831/vCTUjqMLPxYgx3dKRjEeNO/szA187ijMflFxMG7CXvbeeakR0/UpiG/On3Md
 4C+kObHPDlifk7lrr9yE1yIk/dUxJM203VC8/vNWYEhvUf3VNLMKysDP/TKrsAdhSIBtSM5+vwh
 3MA932+XY5LB9jzJn+avFVFy+/hbVQhGBQxWrGoT/uFm1I/G/vEnwy9Es3T7/6r2MMThDgyrWSr
 t1qeW+fTzoB+DLqvXR36poBjjg9oxUequJZ9RcT78Ej1d6lVPBGzDDEAyl1OSv1FyLeCTBer6dD
 azS+Cxu3/WRQ30aVL1g==
X-Proofpoint-GUID: esTZyG4kRG--LbQQP-tR-c5Ju9co07XH
X-Proofpoint-ORIG-GUID: esTZyG4kRG--LbQQP-tR-c5Ju9co07XH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260162
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230537-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A6E2533CC41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
In occ_show_power_1() case 1, the accumulator is divided by=0A=
update_tag without checking for zero. If no samples have been=0A=
collected yet (e.g. during early boot when the sensor block is=0A=
included but hasn't been updated), update_tag is zero, causing=0A=
a kernel divide-by-zero crash.=0A=
=0A=
The 2019 fix in commit 211186cae14d ("hwmon: (occ) Fix division by=0A=
zero issue") only addressed occ_get_powr_avg() used by=0A=
occ_show_power_2() and occ_show_power_a0(). This separate code=0A=
path in occ_show_power_1() was missed.=0A=
=0A=
Fix this by reusing the existing occ_get_powr_avg() helper, which=0A=
already handles the zero-sample case and uses mul_u64_u32_div()=0A=
to multiply before dividing for better precision. Move the helper=0A=
above occ_show_power_1() so it is visible at the call site.=0A=
=0A=
Fixes: c10e753d43eb ("hwmon (occ): Add sensor types and versions")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/occ/common.c | 18 +++++++++---------=0A=
 1 file changed, 9 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c=0A=
index 89928d38831b..f02f815dc960 100644=0A=
--- a/drivers/hwmon/occ/common.c=0A=
+++ b/drivers/hwmon/occ/common.c=0A=
@@ -420,6 +420,12 @@ static ssize_t occ_show_freq_2(struct device *dev,=0A=
 	return sysfs_emit(buf, "%u\n", val);=0A=
 }=0A=
 =0A=
+static u64 occ_get_powr_avg(u64 accum, u32 samples)=0A=
+{=0A=
+	return (samples =3D=3D 0) ? 0 :=0A=
+		mul_u64_u32_div(accum, 1000000UL, samples);=0A=
+}=0A=
+=0A=
 static ssize_t occ_show_power_1(struct device *dev,=0A=
 				struct device_attribute *attr, char *buf)=0A=
 {=0A=
@@ -441,9 +447,9 @@ static ssize_t occ_show_power_1(struct device *dev,=0A=
 		val =3D get_unaligned_be16(&power->sensor_id);=0A=
 		break;=0A=
 	case 1:=0A=
-		val =3D get_unaligned_be32(&power->accumulator) /=0A=
-			get_unaligned_be32(&power->update_tag);=0A=
-		val *=3D 1000000ULL;=0A=
+		val =3D occ_get_powr_avg(=0A=
+			get_unaligned_be32(&power->accumulator),=0A=
+			get_unaligned_be32(&power->update_tag));=0A=
 		break;=0A=
 	case 2:=0A=
 		val =3D (u64)get_unaligned_be32(&power->update_tag) *=0A=
@@ -459,12 +465,6 @@ static ssize_t occ_show_power_1(struct device *dev,=0A=
 	return sysfs_emit(buf, "%llu\n", val);=0A=
 }=0A=
 =0A=
-static u64 occ_get_powr_avg(u64 accum, u32 samples)=0A=
-{=0A=
-	return (samples =3D=3D 0) ? 0 :=0A=
-		mul_u64_u32_div(accum, 1000000UL, samples);=0A=
-}=0A=
-=0A=
 static ssize_t occ_show_power_2(struct device *dev,=0A=
 				struct device_attribute *attr, char *buf)=0A=
 {=0A=
-- =0A=
2.34.1=0A=
=0A=

