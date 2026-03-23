Return-Path: <stable+bounces-230031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDO+BZDOwWnhWwQAu9opvQ
	(envelope-from <stable+bounces-230031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:36:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF032FF056
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58F053065542
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8491C37188C;
	Mon, 23 Mar 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Tb2C/C2P"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB979358369;
	Mon, 23 Mar 2026 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308888; cv=fail; b=lzDvwv6uSyMtV695rqowm7whHAuw2F4CAYDxGf8DxRz4tzrSTHsPT07TlK/BN9kjXHBd4n8/DNBpUNJVPDJO7ANrH0nSKP5XikNIaxsGhIPdF0UhgfXJ5LYYA92sT1sA+n772oJP/jLqJV/kKwifu1KVIWE9ZJwrTI9LLjREKl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308888; c=relaxed/simple;
	bh=cz35freoPx9YrpUZE3ICY7gE54Nh8J8SlOijm6m/nac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LfJSvNGWc+vb71OzGkzjWcACgxEL6Y3EwQX3mvms+w3yKnXe727I8SiTw15fd6vBWL5IP4OezgLvv5AaGjbeFZ3cKdrXKdhD/pnusfHM5Dts6P0mBp4dMOUobeLvjWNFXPFUZovaaJBHOdCH21fNWB68Qwz+XKB9lRdU0g9ivwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Tb2C/C2P; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NKEWVw4098712;
	Mon, 23 Mar 2026 23:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=NZ
	YfKpLXGgATBHcNX9ItmP1Ai/ap+CKcX0zfe84080A=; b=Tb2C/C2Puc9XoNHyVj
	NEC2lXN7kK6myLNAoXlOEcCQmV/Ld3d692vQunQ8+bTDEAdkzjd3LvxPv9xwNOG7
	nLsHCYBRAUNiFxUIHrutERZnXYqw2/3duTgWCOIQFeeVyIFsbrEReC9Q6Oa3vjQT
	BLKqeHTXP/YLPaUneBmV+nPekO7GzSFQGmAxBegfQCsohuJEAV0lb0l9A8CdQIbs
	RikvoS2FlmGgSw+2pu6gW+UBBT4Wb8KX+F6vCaxDNzmjxpcAl7MlGhzNJbR8ZAxc
	/a+Yla0HHTNUGQVipiTecrwoTYFxl5ktvIbNOptmQF53Xik4LXhr2Cyo9KuDtw7w
	I23A==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4d37nr5cjp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 23:34:29 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5374480163D;
	Mon, 23 Mar 2026 23:34:29 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:34:24 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:34:23 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 11:34:23 -1200
Received: from DM5PR08CU004.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 23:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IytYP4HTteIxtRX1rypOObxJVAiVxGiEPuldI5c+fQFHRLkxITJQze0iBM9/PLHOoycnbGLUXi0Oy/U5jkhNEGa5E4N+MBY/Nnf/2hhxG/bjp2tR6WINOSc184uaSn+tQYtNrtRKYkoLOCh+xC86sVnwR8sUlcWvNV3KNACJI1z/pwa4tFlgHySDfEIC0ZC+MYvsRoitY7NeNg5q2m6Le/ouJABVc/elmCKeuSorS74K+m1Lf1w6mGPiDnTv3glmrTKY2b02PCdrzHiRahcrpw1H1W05KB3qhENydKICN1QxD1su3KfRUPO0klM9FxOJJgoYdR8KfIaLyDOKpA3uKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZYfKpLXGgATBHcNX9ItmP1Ai/ap+CKcX0zfe84080A=;
 b=A/7ktFILtONmQvRfUowtbx6CJqEr3IWNEe3Si2KbuzIUeOjNqC9yXzzsAbJE4gty8lBmqLovTyl/HWMOCJcduRWSF+v//wLnNGg4G4jumg9dLuw1MxkudQwsgcF3Otmng8b6wYoToVP5e4XKIkdw0ea1CJYqBFCEviRU28yayaESnlJhh+LwvLYPWjFDHr4NRV3fvB+d3xetYfYs6jvoz//taQAWmGlqPfcfjEsyRWWGCcjqAZhauiU+fyOGzYm1I3vhLsM+TgxQdMelAJRekXP/57DlWBNtGYpnqDtQQ6G3Sg0cM8tTadB+KAkyXYHLrNmmDApS3k0XLJBNkowNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by CH3PR84MB3989.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 23:34:22 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 23:34:22 +0000
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
Subject: [PATCH v2 5/5] hwmon: (pmbus/mp29502) Prevent division by zero from
 hardware register
Thread-Topic: [PATCH v2 5/5] hwmon: (pmbus/mp29502) Prevent division by zero
 from hardware register
Thread-Index: AQHcux2TN9q4CS89lEyY6+ECiMK3fA==
Date: Mon, 23 Mar 2026 23:34:22 +0000
Message-ID: <20260323233244.201294-6-sanman.pradhan@hpe.com>
References: <20260323233244.201294-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323233244.201294-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|CH3PR84MB3989:EE_
x-ms-office365-filtering-correlation-id: 3afed267-6f05-42b7-697b-08de8934b648
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: M59vdO+i7137TYtGzcWZu6trDydzHXMHzgg0D+uZOyvE5bCh2TWrwXLfmXb/m7mcmbtJ/STBbtutsLRCXdJXMf0Booj20eigURFsdUG/qX5QS6zWY7XP0SQjlw9xr4nl2WRrgrSEiUJuMSJXCpr9HH0DDKrOliXi4nhzKmOnMOuuG2WOKf9pbME1bbQox1eUz5wlQ0r2TJP94mReCoP0T7fZ8IpM4J6qzUDce95yFyUahiFgGGpDagn5MlqwwAiX+JPsDbIZp14FHoBwmyB51IAHIn06cEfCn5McPizE58tvvgPejsG67DVSRqo8fpruMPyo1gTs8tFdw82c5DUvq9tk1Q9nCA6EFNKLagVCDbJT8CKlD1PX2cKRH9yCF2EKGD1sgbq3opDDJMjMLjzNxUqPy4ZvpywyFrVUmsFP6jb+VBjlI/i2SMvpUyj7c6FCBd+GE3AYRxzZoAk2aVc5qdyREJWJumxN1A3AEu5zlqlwZzHHRYsch8bcyHxfLi15OLPtKNJwDaS91vm5ooDZ6xdUkcZYmeLj/8EGkGMKR0n7UOV2GBan012Ue20e1fEwpUpl9Uhl9PRmY/jqK5x1GT86CQQ0ULpQU3PxupD3PvbkE/+1VdxNn+j64WYSLw8BAjWpDHaQYWaFOkaVRZwS8DoQiHeGb/yLcbM6LcoXwGZSgOkxnshfbQ8pEqC1ycYCmDEcQtwDICNGnFlx557hSnaloMRrEFWPSAVdAXR5S/FiNax1nRL6SWaIPCRv+MBwwXxpPvfNnL5bRN0j2duqXifX6e+5MOSj3krfsgecBX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U2o65m52HU69pBG9CTOG7ETjTTJgjuDY3b0tOkR3elKAbwNKpCKS1cLtD1?=
 =?iso-8859-1?Q?SzRr8gxxB7ZJrslLs4WG+ObSQ2/3eWcD/BZUMp43pAFnXwiIRfV/XZhOPQ?=
 =?iso-8859-1?Q?qJ7suj1m4CYSzgtx8LQjPoRrFyZrPNFlEY/2Xgpv/Em/5M3MIasVzkNemy?=
 =?iso-8859-1?Q?90fp/SG1kUWtbMLxwXm/G+d9LiEiCvoRX8H4bdP59h4kXddkpVe6uNLHOW?=
 =?iso-8859-1?Q?aKqC+eJVIpoTWW+GM2jenRifxVy+8ZNlPtzIhA13RnItZyZN/XyHa28M2Q?=
 =?iso-8859-1?Q?RdLwXq8fyMw9v1RptMbVxbB+2VvxdCoqeTpV0VQOObMNZk2aRJcSz2gtZk?=
 =?iso-8859-1?Q?PuqvKVgBfIWU1MeyX+sD9cCWk+/8T8tCMjK9ysEyMDftteHl49HBatZIeW?=
 =?iso-8859-1?Q?xbT0ry8bHjhSRkMtyu2oyPx7OYs1rSyJUBr5jVUCgHVKgA3FxZ2EeFwULH?=
 =?iso-8859-1?Q?2mvtQRlgX9S3sUVgtGEcqY3PMwfKTWYNpO2WYzjKQ2YHjmCZEcJQAo3/YD?=
 =?iso-8859-1?Q?iu1FaEYj0iXA3CQaUmddEiwr7k3OFYJ67Jc06eHE0e9f83xVufjHasnkdA?=
 =?iso-8859-1?Q?XzFUNp6LRmk9lD8zI3OvZK8wxw+sBIxwwcSIn4Ua/lAWFmYX1yO8i7YYvj?=
 =?iso-8859-1?Q?gt0HVJgjaFsb2Nm4u4oLbPf2+V0wvswy/S1d5g0sxm4UhSGavbZxkOYRNk?=
 =?iso-8859-1?Q?mxnMwhgWlMnZZvXVlzjnUXFHAZ4PUIz2HFEOLi3E9pfyQdkrmWqCHCUT6b?=
 =?iso-8859-1?Q?Is01TrAHMFM4UPdfm6V+hzbBxkcIkLUWqdm8kkDqE9WFv5MircRxOSYM3b?=
 =?iso-8859-1?Q?vsxyQVQ9vrbgQ2VTR7gkvf9aJe1Pqoh5lxaPdnM41sL25FmudEJGMuNSTS?=
 =?iso-8859-1?Q?ztayP8LtxeiOqo02ch2UuH2ZPlBjoEfwPUaKsUISDpyerc39As+qSlE0dc?=
 =?iso-8859-1?Q?qmH0z+zVU5+z3Xz3/s9U0QTpxUHlH3DPbWQ3FOwRV19jNxnmyqOt79mX1Z?=
 =?iso-8859-1?Q?RVCg2F87hL1VCoSSTXiWvQWiSH2AjslfZd3kGJ9LsPtNn7gcG1eofhLY5x?=
 =?iso-8859-1?Q?bm33eflzKRA8yPB4zPVVd2DpZ+z2/o0FVwNb5wTt/zvTGYj8d+VOFuZZ9S?=
 =?iso-8859-1?Q?PbLWC4fqTTqgTnliLRhTIPe23Cve5DImYBS1Se+uau1CorCXETpqOFoqOU?=
 =?iso-8859-1?Q?JacQeI+iLxlsuooOYQ1X2j/gbuLeUfL+IJ5qVh9JcJZYS5sr7RYi8e8Rz1?=
 =?iso-8859-1?Q?ukyty9rJ28IKRfTJGjgxvQDmWAW7WR3yMEzud6ynAhBhz2put/XunR6oQh?=
 =?iso-8859-1?Q?3LIc/UcokWGIjpY3YOQPAOMD7jnTzBG8806L9OVmRvj9eNwOl63Te0Hbns?=
 =?iso-8859-1?Q?xaL43ruX9dXLkhprC5VVsoMlaF97NQP8wUhT8AgbPrFCs0xvSoCEKrRBm4?=
 =?iso-8859-1?Q?pY2wn+cUGYiZL0KVzn8nOjMG4U3heN6GFK1jIkW7SgHftL5fhjGf2hD4jL?=
 =?iso-8859-1?Q?BTrXf4lAmgcSo1jvZ/Y7KPbouxbpoNFssrC4UW4TC6GB3lA9U/rytTqwbs?=
 =?iso-8859-1?Q?lvGNW/jU4Vnf4uemhGgsEkZ6G7gZyqDPQY2AmiKNDGk+WGAked1rctptHH?=
 =?iso-8859-1?Q?gO+vOmlaOFfRW7F19lFXaOULu1nPAe+e9Os+tNhNw2spEfla/dYyie+fdq?=
 =?iso-8859-1?Q?c2+EFl47UA+AUd68u46/R6KlEqn9J4uIJe42TlbCKXTSbUeRJ39bFZ4llu?=
 =?iso-8859-1?Q?U3sCFzqKd/XaagBZxriuk5WcubivDNEbWmxZs9pm/+2u620xAadR2fe1WO?=
 =?iso-8859-1?Q?CJ0ymxy3Nw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vfHyXVZughmJXx1a5GkU6kTpdEUTGL7kK1FAqPEbQf8/nzR7G1Zksf06RoNrLLa3urW/YLGJ69N0tAkKKfRWGlzSaVmA3BLvoylEBJMZO7B9rCTsyqzuxnJRhw3nh9nm9iqTE/gtNGK3xGZhPlZwLQWlYmsLCvkejxZasCiN8OEvV7bbzIm+TUyD+GQp8xVST+5teRvUmccvue0aWvvgHgsD6S14Tq+xWLUbRbLPBhWJUtks9wun/6WY28YW3uHA2dF3IAxIG9lUl4JI/ysqPXmg87fkD6UwqtcLzpEzc+fH3PuKE0g5sVujG3nqPFqagKse02sGZJ/Dd5KZCtoC7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afed267-6f05-42b7-697b-08de8934b648
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 23:34:22.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+ycinU9WYtxSbRUGgvgAPHPbCtRpM/qYOpDH29ynzePe595F8yP5C9BcDLR41w8sCM1C4E0PwZ9ad6FpO8N9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3989
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=Z5rh3XRA c=1 sm=1 tr=0 ts=69c1ce05 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=oWjv0WD8qUs_733JoPwA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: 9DUOigVu_jJTYHrOrvKhdtWo8dcrt3oR
X-Proofpoint-ORIG-GUID: 9DUOigVu_jJTYHrOrvKhdtWo8dcrt3oR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3MyBTYWx0ZWRfXyxA7D4BOV1md
 CVaiV7L0DU1ImKwKoWnH4KbHnETuyo/7my0nfvNxjsHHp1vm7FXGeJXQWVxvZRo35HcWzP5OUHy
 w3LN9AAAZbJ64PRc2a0D59w7fWt2hSOZwVK+7ucvqO/g8NISmbZP+M2itzip78APC4CyMM9S/XD
 UkoKdT4PcXVJmskmXQE4eTmOTQWshAvpqMHQ3F3kkI1OiXLwK31SghJ5LYMe7jrJmHfx+LEHN3G
 c2Saq7CDiQzAPrcum0b4TpCam8SoxntUN/ZRTa6U6I25uQA4jB1UYng5WNBG+3d5n9H6IO+4f8u
 bX6e0tRwfw0eJ4PMbKc4KyQmN9yKh5dvCsbc5EcZGC36NWx2IQ1NVbk0UW28f3KI0ZWjYlUPqYD
 k1/OB/5SeTsTpAl1lMMcJwYQamoO37ngnHez1x+bX76GlZmZ8YXQNdGVXdHDfS5skFDQmtlMFaQ
 s76CguCfPmMqkb8mWtQ==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230173
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230031-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBF032FF056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
mp29502_identify_vout_divider() and mp29502_identify_ovp_divider() read=0A=
divider values from hardware registers (MFR_VOUT_PROT1 bits [11:0] and=0A=
MFR_SLOPE_CNT_SET bits [9:0]) into data->vout_bottom_div and=0A=
data->ovp_div respectively. These divisors are used in=0A=
DIV_ROUND_CLOSEST() calculations across multiple read and write paths:=0A=
vout_bottom_div feeds the PMBUS_READ_VOUT, PMBUS_READ_POUT, and=0A=
PMBUS_VOUT_UV_FAULT_LIMIT handlers in addition to the OV-limit helpers,=0A=
while ovp_div is used in mp29502_read_vout_ov_limit() and=0A=
mp29502_write_vout_ov_limit(). If the hardware returns zero for either=0A=
field, a division-by-zero exception occurs at runtime.=0A=
=0A=
Add zero-value guards that return -EINVAL when a divisor is zero,=0A=
indicating the hardware returned an invalid configuration. This causes=0A=
probe to fail gracefully rather than crashing with a divide exception.=0A=
=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
- No changes to this patch in this version.=0A=
---=0A=
 drivers/hwmon/pmbus/mp29502.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index aef9d957bdf1..bbcf018e5d05 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -134,6 +134,8 @@ mp29502_identify_vout_divider(struct i2c_client *client=
, struct pmbus_driver_inf=0A=
 		return ret;=0A=
 =0A=
 	data->vout_bottom_div =3D FIELD_GET(GENMASK(11, 0), ret);=0A=
+	if (!data->vout_bottom_div)=0A=
+		return -EINVAL;=0A=
 =0A=
 	ret =3D i2c_smbus_read_word_data(client, MFR_VOUT_PROT2);=0A=
 	if (ret < 0)=0A=
@@ -160,6 +162,8 @@ mp29502_identify_ovp_divider(struct i2c_client *client,=
 struct pmbus_driver_info=0A=
 		return ret;=0A=
 =0A=
 	data->ovp_div =3D FIELD_GET(GENMASK(9, 0), ret);=0A=
+	if (!data->ovp_div)=0A=
+		return -EINVAL;=0A=
 =0A=
 	return 0;=0A=
 }=0A=
-- =0A=
2.34.1=0A=
=0A=

