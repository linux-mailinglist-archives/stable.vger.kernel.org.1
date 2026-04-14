Return-Path: <stable+bounces-237925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FCsOOBr3mm5EAAAu9opvQ
	(envelope-from <stable+bounces-237925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:31:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5C3FC990
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F208E3011D49
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E63E8C72;
	Tue, 14 Apr 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="V+n6mhTx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2B38654B;
	Tue, 14 Apr 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184193; cv=fail; b=jOLlWuG1sa7ReUS28WsFi7iDHL1Y2qkPf1Bf762/ro2w02yiIkODMaLsvH1ZslChbSuVfZLj1t2fB1H6pSukCduDT//bEtzDCEdvdG6iXFt7tjNkhUlKw+yKt+khw0f/R/gi7wjHsCSO5Gbzziqjwa2wADjJkyuKvNg1+asvF8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184193; c=relaxed/simple;
	bh=1qo2YgElhrYP+vE+wH4CGN+e+uK1RfvXhOCcMLy5LG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxkY+KfXCGpSe/VltFF0if5iNENO21ssGwiZUQ9xLnBCdpsJAM9gsN0ubU2eW9O8Nsof32EOvxlDd9ojs9p7iL8rdY2rQ339TZj1qUpS2HFNMh6kzYjhFn7CykvhohMkIiZA1nXmHfMD7/u3/AAIyyHyACXD3qBVUH6srTdWk8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=V+n6mhTx; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBJ4Fx1525365;
	Tue, 14 Apr 2026 16:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=1q
	o2YgElhrYP+vE+wH4CGN+e+uK1RfvXhOCcMLy5LG8=; b=V+n6mhTxOY4Rqd7FdS
	DD4+djJpoiB3QIhijpRHw2C3hmJFYCaHxJgkMVUYP82aWZSkU9h7LOzFyAojhZGn
	95wD6eBCdoIJ6enshks9BRo8JFAK7y1HQwHLwBmhzHuQ33SjmXUrdrBp9xvyMg+q
	RHaqxccQsHYW1q9HaqKZ6rtuXzJToVyy8ug347M85SqhdsxRXHK7ldGIP0KuY6kW
	VGQbgAkZ+iA7l6F+hfOVnsyfOS3XD1+p83EDBXDUb/uB9pefOr4GuUZDk1XTYKgt
	LClNGgAdAh/Lj3WoSJFJaFVkXqWhP4pzc48UJTFXYGPtJrTd9UNgrkdWaZidBCH1
	tcUw==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dhmknbqxa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 16:24:29 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 682B680171E;
	Tue, 14 Apr 2026 16:24:28 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 04:24:24 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 04:24:23 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 14 Apr 2026 04:24:23 -1200
Received: from DM2PR04CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 16:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyc4rEG7HyxKm+dOkFo80OB0inP3ysT9J5QMfKuJ4FX6/9iV8bjqeFWOYcykXCxpOAmyL/fgfGo3R9Qaq33TOn489Dc+ug0u/YOD26xrLER5jRuZLNjvzTEX6ym29pwhJpoZgyuXcKLIhaNZ00rCyaMw6yixQSSMa6fRhvJUZeg+x1pzI2PTQ5VkzQ79GBzbiI/YvGDWbL+WqsVc40rHUl+dV6xnM07INTeTxlp4/I+uhzGMe3gnqmFHysRq45JpuNxvctgUIPXlBAqVCVE7Xn9b41wo1vPP+mexPosrauglAR1vS3bY18Z2rtKaUvOcrD8tECj/zNPTZv5tQq4QRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qo2YgElhrYP+vE+wH4CGN+e+uK1RfvXhOCcMLy5LG8=;
 b=kg0m5Jk/jgLlfK+OvKrYg0gmEvLh8sxXKViDU0yCNVttVLOcPhAU+VuWhqj61xAJ3Vms4P+lJRJGfQShbWrfraFpYOxXdnkMCXsJG+p/f47oNLAUtw2rn8HI3+FCyuBI+M7RWinsOtl4S4tt7GCNUKWhVPcgaOzMSsel104/1ASqDmw+odA2/IwIz1SHIfNMiEWFPRJ8gaIehlxT5jJybd3KOHVRH/T7OdnazwKIvEvUG78Qb4vf9rX/e8IqblfSJaiaYw77gHbt0zIDGPhRL+py8v5rpnoSPhXMtLOsn0aP3KGddYzMyc9Zb7mQosyPXKSVD2y3d0E49GMLodh6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH7PR84MB3840.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:312::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:24:22 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 16:24:21 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "yangyccccc@gmail.com" <yangyccccc@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
        "shenyang39@huawei.com" <shenyang39@huawei.com>,
        "prime.zeng@hisilicon.com"
	<prime.zeng@hisilicon.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Sanman Pradhan <psanman@juniper.net>
Subject: Re: [PATCH 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in
 trace_start()
Thread-Topic: [PATCH 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in
 trace_start()
Thread-Index: AQHcx71AezBe9nz1CkqgGAvaDsFRSLXdMoWAgAGUN4A=
Date: Tue, 14 Apr 2026 16:24:21 +0000
Message-ID: <20260414162403.9481-1-sanman.pradhan@hpe.com>
References: <20260409010704.383882-1-sanman.pradhan@hpe.com>
 <20260409010704.383882-2-sanman.pradhan@hpe.com>
 <86770cef-bf30-45f6-8d33-e7b74b3bb834@gmail.com>
In-Reply-To: <86770cef-bf30-45f6-8d33-e7b74b3bb834@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH7PR84MB3840:EE_
x-ms-office365-filtering-correlation-id: 37ae6c38-404d-4bb9-c933-08de9a424920
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wQhX1kq53qc07xOVuX2bTevt1tiNYzmH873VQoV2vC/BDXcsOLGcmL2OcuiRZdvi4ja5RUHZM/+/y6mhMb0JwP7b0BHpAhArj0P2UqtCjpWBmzKxmFD3Tu3beeReCL19nUXEGkLLxwqIPxEUm4i6Uel9Mm5/aH3TtKvwhRtLotxT2E1t8bSlbCCdgI/CKA9PbGhpkLsaeasX3OZgJJMoq7ly57KkIEfFf5M8ibRiwQfH8RH7egEdIAkCuNNl4N34gV/MPUxJfbGCe+HsOo4GnUVF93EzNGTk8/C81uL5lxZNmRbfAklWBVkpq5gOGRiT0WR1qLzSlfjM8NoFmd8CYNbJ/RvpsXKfHx1YLLfHoQKBEcS/SNqXMBSxgJv8R9piwaURSxGphOHCFIgwgD5uCY6VZQ39mPZ00HwB5a+QJjgeKShKGZbSOyLyyTY8r/g6xvrYVw4ZYK46r4ge8iKpVp5Ws57jsw8+dO1LOMte0Ea+Nn+gHDs/GVpnl6LWu7LDHhiDdHRMQWnkqiMVugVoOVUV3emaoLBOzvalssqQX4tme5Z3bYjBQZVsWf/AXGRTpVjyLwDgvBJDQ1Y/aL4v0gziCFlBszz7sk2E+GaS9bH6jehuq1W3gtfjkX6aV2kNE4MgogKFHtXIrkk6FU4mplFhQKs+50HcWe5Q3o0lPJhAmZwrMQYBys50JDotFSBIMPXGO9EAUhbEOziaUC7IZj72im0O2VmLL5DdOQUyEYcCwidr5XQicgmscTrfZgCqvnFFY9Ulb+gO42Y6JrEjPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EcfqlShny1VCCPcARUTfxqG9gWLKkqS24jD4FBxGoMBfNwrcPeruyRSAv1?=
 =?iso-8859-1?Q?0q2PsVw47RIDjnohM8QYMwEiSPHuoBu12ByT1boJH0j8A85xBo9rYvg63z?=
 =?iso-8859-1?Q?7FpuEUePnwnAxMAgZp7ZqoXtgjkTIhEDyptv5nzKVyCQMPa0o9yXC9mISM?=
 =?iso-8859-1?Q?jHMamBqH57hhK0hfI/J4CmTj07N3weUg8kYMbWrayg5VBCz7vGO092vnvo?=
 =?iso-8859-1?Q?HMm1eUrsn73q+urChTFb1VbUcQTCfFhwM7+S8xXSOBoh76FDjKtzRL9eDm?=
 =?iso-8859-1?Q?90Xtqmk/ktJHG7wxg58JMWMuIJskVi8/DYAnBC/LdjNUK4pSpQzZhdkdk9?=
 =?iso-8859-1?Q?zxejI3HYX5GIswCUy82B0Gr2dlE6btyp2d6N8YndkprFBzsPhyJudgSO4M?=
 =?iso-8859-1?Q?iTl6bNO45qNyIn5028XAp9VuR4ZxVhhSc7XqPsQxbqfqU935OMjJAFwIsv?=
 =?iso-8859-1?Q?9rXwD7yCXKt7l5m9MA4nmGKGf7s1bw31bCYIRVwLLorwLSVjNxUyKNGurN?=
 =?iso-8859-1?Q?/jmV8EWHvla1UrlmencsD4jYr6dPalxhfF13fnu+sHvOtoBJ4gRnLKHWv9?=
 =?iso-8859-1?Q?42cEng2LdcseVDf9ZPfN+g9/G3GKZnNJ0Xt+PcBTBLdMf+5AMgEz7lqvp4?=
 =?iso-8859-1?Q?vit8oeS+AfMDiX4iBvSghebsWEj4PAdvhnpa4WahrQgxLBdGmeI+VH3lTE?=
 =?iso-8859-1?Q?4hFiVj8LzuZWZ/m/eYA8Qbma1+RiqsksvbQLpbiRqZS4BSWRKuTHuFpcf0?=
 =?iso-8859-1?Q?YIxiBxwaPnVlVqhMA0hCcAZc0DE5Mhbzv3RwPEgImKcoBfx+YBzs0YOB5h?=
 =?iso-8859-1?Q?oDo6EdS6HZhsZtciP11BsonXny0x9eSw0o7gejtVpEUfnV/m2sFi7MO3FH?=
 =?iso-8859-1?Q?fMN/OHjPiXWNcW4VCq7X7TFzXNb+N/bYw1heLLiOmsxE0JdZHAWrzHqqqi?=
 =?iso-8859-1?Q?cA78lm0Dv3teNi/0yZoKkPIGvpV7hhwpnV8QwwZrQqXE94CD/WixCEUYfB?=
 =?iso-8859-1?Q?mxwshbD4KYiDMbCiwsYaBEAFCJW8S5oW81WYxqCtvKnFGQds7UTMlLgfyo?=
 =?iso-8859-1?Q?OTVydoBDcEGg11HGR0M9/9DyhvBuqifNuEYijUxqKwbYssjiATUb+dUKa2?=
 =?iso-8859-1?Q?tT3HePyEsTyc0CR5xVPZmKvULLD1eAuYkGzIPkW7eT/1NRGqIPtZHnwSek?=
 =?iso-8859-1?Q?wTR+KJQg7mbjJE3nA7ihvaS1LAhpd68AQueYT9mwoBoYMVoyrKy03CPhqu?=
 =?iso-8859-1?Q?89SeSUFwdJkLh+JG02e9QdTAx8M5SaTp4Y4U1hCyxoo0FWs0sgRd7DqA0z?=
 =?iso-8859-1?Q?o/hiyP11a5BJ+OUm7iD+KRmW4NvtU0XcO0VF/mDE2aOViUPJmJsojnLpmu?=
 =?iso-8859-1?Q?BnxgxVSupXFcnM7+p4cF8j3lpYQjE15I5ZXXCFMDKXGO2u/Lyl6d1HLbpo?=
 =?iso-8859-1?Q?R/g41rtB+rrjwlI1voN/kYaIXEYusESY7FdXWkeHzV9FkURilsVseDTQhp?=
 =?iso-8859-1?Q?06ssmFwr65ZZKfhdoJJUlYkjXIC5sCF/4AU+e+xmJZ1ychRTy0LYHJBiyE?=
 =?iso-8859-1?Q?y9MzySZC+RapXmT4UzMGBa9dJXQnrToNuth7rPJFDB1NVGB8OtZzBRd60R?=
 =?iso-8859-1?Q?TuDROBZG1sIu39j2ZhZHJWoQDzaM1CtW1aTE63OTEQoFifsQKqKQ1bCXLL?=
 =?iso-8859-1?Q?Vn3Ff9fnBHu0/toj2nAY1uHFbZENiEKUmWGGeVBkqURzG/GHROTKa43ggj?=
 =?iso-8859-1?Q?O/1iiTOHR50PDUISh377kKbULdZVDafnueNIQuwRv8vHkJqY2yygioyx7l?=
 =?iso-8859-1?Q?ZuNSDGsMQg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GgwVkyKtsScdbWgEBjaTIz+/iwL8vjl9lN3aQYdYkSixF4c6ciaTP73W4x8btukBjy2/d8wkOPU+kGzTrBt0OAn6FwP3bBOfNF3l9TClFIK5xxPLEh1vd+MjfI8229G6OKbGN+kOwPtguUlJZip6HBUhDzh6KUe1kPYkVcypgd+kKb7UrjNH4jMt5ZsAba4SEyfDaSCfd5t0q4C0tkvy5XaNjEeJYhxnyTV/6gPtxOHAR3eqyAZsRHlZFuK8XsTHKz1Zqg/Z2TVETFqF0Ag3DdhHfIgTiqYPRZDbl3nliBeywoWfsDFZI18h7v5S8PRRUx7nDDEMZszl3urCTvh94Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae6c38-404d-4bb9-c933-08de9a424920
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 16:24:21.8342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntgtjMZf0Hl1HxrG7DtNfmaAsyuJ9qSqH9oSNAct5IQrvLmCIfPdtLtS3hS6KRyjMMo/GeNMlljneInC3NS+6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3840
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: mjO1ae6twJ88okKCW0c9kYBUchF_Kmje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE1MyBTYWx0ZWRfX8GCIUTaPPlVb
 pZVRKy94jBjC2W9VrbdkLgaCX+PpTbFuEdBzv96st7LZJ67CZbrsyewAPaT2z526s1juuGe6gYm
 1VB9D3njPDo9MJSUzfT0+9hQeHcjSm3g3AiMTufCq+TbKCCJ4G7MZOrwnF514OMiqrd0kqgwvNX
 8L28ARAQwbSA86bkhvRLVjAT/gS4rdbheGFTa71cMca2M8WF33s00UR4gtpXMDd2UTy2A91dMK5
 adp/VOCETgHpCc11XRXoyWqo1PZz93mu8gCB3GrPRvJWBmmVafbFsxV5XNbPQLxmnrwq3dU2TFc
 6CZhvBLvZOPwmyy7nM5U4Y//1ZONMo70coBDA0/F4LY/CR4GRrTTIxn3NvkRMEZodrTt5GLLwKl
 FXiuhe7NoljXCUZj4R1gm3h3gPNZm+Lk4R9eT6myjGNNEOO2NidrFO+VdMLDWmfcaI78mYh7M/W
 1rR9qNWI7ZpDk/qfmfA==
X-Proofpoint-GUID: mjO1ae6twJ88okKCW0c9kYBUchF_Kmje
X-Authority-Analysis: v=2.4 cv=DaYnbPtW c=1 sm=1 tr=0 ts=69de6a3d cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6_mrDcixewTG61oOsKN3:22
 a=OUXY8nFuAAAA:8 a=g9zw8__qrK4wgB90jhcA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140153
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237925-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email]
X-Rspamd-Queue-Id: EFC5C3FC990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
On 2026/4/14, Yicong Yang wrote:=0A=
> the other status wait functions in this driver return a boolean, it's bet=
ter to keep consistence.=0A=
=0A=
Good point. Will switch hisi_ptt_wait_dma_reset_done() to return bool,=0A=
matching hisi_ptt_wait_trace_hw_idle() and hisi_ptt_wait_tuning_finish().=
=0A=
=0A=
> could add some error log here for better debug. otherwise looks good to m=
e.=0A=
=0A=
Will add a pci_err() on the timeout path.=0A=
=0A=
> the timeout wasn't checked since the hardware reset will be finished in t=
he limited time normally,=0A=
> which is less than the HISI_PTT_RESET_TIMEOUT_US. It'll be better to add =
this check in case=0A=
> there's something wrong with the device.=0A=
=0A=
Agreed. v2 will address both comments.=0A=
=0A=
Thank you, for the review.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Sanman Pradhan=0A=

