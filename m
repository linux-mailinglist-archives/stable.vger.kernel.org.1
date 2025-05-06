Return-Path: <stable+bounces-141840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADBAAC933
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0B31C235F8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBF28151D;
	Tue,  6 May 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bc+AQuc9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEcBOWcs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4F4B1E52;
	Tue,  6 May 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544489; cv=fail; b=i6FkkQ6mprS7aEIjlriIqWaLFQWJbOS36ld9FD4IiTS7Rp7Hb0SXtsSU8aC6ew95SbSACohXpU0kmmusABV7Luk7xJkXYiowOnwEAQ0wtvWWDKH6cBr6yuWEf6KxMJFmk3S0Ql3gFoPtTB+rit4jQDXWXP0Zb9mnCjsPu4+JZBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544489; c=relaxed/simple;
	bh=oXM3LLnftsVSyTt7GorKskbIh3pUwPW5X8owjF3XOAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZjHTx2uNpWtzn3uFd16a6ofS2gWuSM3a9wfwkQKx7zgTu8zEUtldl3/8vcF0iPLol9wI8fjma0eZn0QE+CFTa7qwU5mrepyASbz29FCXsphgjN8GjV2oMm4WjdQuIy/2MdjcwzF1DT58OOJlLHrMNl4LqMwJfOLYoMGTzWx7Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bc+AQuc9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEcBOWcs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546F7FTv016069;
	Tue, 6 May 2025 15:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oXM3LLnftsVSyTt7Go
	rKskbIh3pUwPW5X8owjF3XOAA=; b=bc+AQuc9ZBcdDI1yd24N6HhjcERc4jU+xe
	nKynNC/i0qjzCwaFBjnbAkHUdNQhuInFg4rCsKnX8ew/UBjKDPJW4X2N/tzrh3Q5
	Zyexd8BgrV4KQ3cvZxpxqNwOjJ2KmjIL7J7hBs1bxY/KSBJvY4Z/MuqsG16rJWBj
	jdXEpcFcAXc1JzLTWKkHb4br5Ln02QsR/1U8SoblEJCtZ/9FjiXApfBABaFCcwQc
	FgbLPNJje0VCzEsYHoTF7FN1s5dWVuUVkH6OapctOYHOYcGeCOcJFNyibTLvawSA
	AkaotpAbOxnOwwxGOvIu0nl6cHraSY4qBi/xLjNLdpOHew2N1D7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fmskg0m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 15:14:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546EFXhE025071;
	Tue, 6 May 2025 15:14:31 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kfde75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 15:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyYzdZ7BoVSIuQ9nf9SXSa7ErgGpqw+fDp94DWMgmOUMW56LnM8fa/LloXGUmhU22uydfCK42XPkwvEAqD3bstzn/MjBI4JIyWmmnS5r4QUtp0SYAiEGgdSgekf5LVYbo5GWxIRHF6ksb2qfCWx8Y5oFshWQ+sceS9BuL0boO1s5MfK/BCY1yVPdxxkJDmaBuzWgB1QDK7D9D/qTRFtjcnOFYwMqK1xY8lEeqHpgLShLCH5DA4hoZNEyGqW6BiErVrZcP7F1RNQ+Dsbi7Rp6hGAKC7334ji4/t6KKMYSvXi7lKhwm9IbCpusUxr6O2246j+69RN/TDUcXcXJCWGMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXM3LLnftsVSyTt7GorKskbIh3pUwPW5X8owjF3XOAA=;
 b=EOyxRxshbUHFSKOcoLr3qSggRYwDMXzBZAzQx91OvIRz3LZ1e8LzSsYrxvfx8tI/M2e2FRVffoRyulqmiO9xsaO+UXfR4ElRpPYgSiobVMFPqGOpVz0lYw0SfSl9f/dg4hDvxlA7kytkJwl93BFC0bsN/3ZFZEnQMXQEMe3uDFeHoiXIBP/1xvDngJ4Vw99i2DPg9vT13eZqlc9gK65QZTlJqgxAvD/t8wXtOklzHMf0edGJzZskq8hUt2nun+UPcFoT6flkIZxGOyyVO2hy4gJg/bEgiLkr+LHf/oD1rxLH2D1GRubPSAsHY3uvqwgXDHMXUqLlfPzEX/pC5hAX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXM3LLnftsVSyTt7GorKskbIh3pUwPW5X8owjF3XOAA=;
 b=KEcBOWcsGUIxIa5yojQnhyr7za+EX129fzyph8ObxZpPcycgBWNDXfq87OjnfeLnaQm+zq2tfHdsJp80rcIkJNKdonsWbfvSZdRRpiINJk1m1+HsOx7zRIPP0pLYryXqe6ZPp0Lm6rVdNiCuPredn0HvHG1NWKUlGsaZJQ3SchQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8014.namprd10.prod.outlook.com (2603:10b6:806:445::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 15:14:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 15:14:24 +0000
Date: Tue, 6 May 2025 16:14:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        yang@os.amperecomputing.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/2] Map MAP_STACK to VM_NOHUGEPAGE only if THP is
 enabled
Message-ID: <8dd9c9c9-af4e-44e5-8288-f420b570bb13@lucifer.local>
References: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
 <5ebcdd05-1c82-428c-a013-b7757998ed47@lucifer.local>
 <cc3365f0-7f52-4fa5-bad7-8c761150bbb6@kuka.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3365f0-7f52-4fa5-bad7-8c761150bbb6@kuka.com>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0d3494-012a-4894-ab23-08dd8cb0af79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKYXRsB1k80q0z8NXb9RlxzxK3l+wMG8jQIW6WcEmKphH722MRe3oKVpc7C3?=
 =?us-ascii?Q?iXfBt8dg+KXt900UTeVbLCDuFJ23rWGlEezSd3dgscW90U0LBd189GUeS8iK?=
 =?us-ascii?Q?O7wGSj22pD01AKK/K2PjiIAxZXUsk1BCAuR4MVzUGCeVAoxIHgEIaZ5EPOsV?=
 =?us-ascii?Q?BpDjiGtP4K9Vx+qli9VrhMh4BnOOM9j0gC7HO2c1XHiZORswDv/kTLpssu4e?=
 =?us-ascii?Q?Qm0FufvNHXRi5lKgO1GgL0AS27KXzUwznDD/sEwueByRx2y4Z1QZThGveB6f?=
 =?us-ascii?Q?gbkN3V48VY/PtRiktrFoYAhqagowGu3BYcb8RCDtHUIcBKUAojO+0FiOXOYh?=
 =?us-ascii?Q?IVfzIFRnsDMmAd4E7kBnqPyka8VovEIUaIN7NIusx/R3F1vS+qpFvWdP7rF/?=
 =?us-ascii?Q?VwGkFwtEOfI1IVuWlP12ncFOSDmxXf+54EgPO9f+hT75OtaOrfHYLRd/I6AK?=
 =?us-ascii?Q?bo88XdzohmVqFOeDGNkW4hQit4PBhK0Z5BZozjfTWgoHCp+wsdteTOgPmT+F?=
 =?us-ascii?Q?b3OED6317dsJHL1vOSUZNixTULj+dtCtF9iSbAYyV+9Th0RC+e9mES0HgokD?=
 =?us-ascii?Q?rpV3Y6e91qTVVnym8kxPJUYguM2Xp20nYZ/qfTtkfl8VobtZ90IaQPDL+G3R?=
 =?us-ascii?Q?jxZiSVANpM3tqqKCQnHuhBkrktY9ySAFFalF8g+SzhsGV8QLyO5rQHe48LhN?=
 =?us-ascii?Q?9PsHECysRRgaFENKeX9gWm3veWBgS9F6n3NNspffnnEZlZEFy4F9pzzlEgd5?=
 =?us-ascii?Q?r0W7dg7967cu8eb4SgzVK/ItfmRbgAPfqwcwIly0+hrdphvg4FxO9ei/fzPf?=
 =?us-ascii?Q?cCg/SZPAJ6dpycIuo9MUh6BX/9cl1i46EtlSk7zwbv8sofzAVp2+8TMxzdVj?=
 =?us-ascii?Q?iW4MTqyjrbWUpDO7PFQ+og52KR9WBi9lZCATBixhjdb/i6DMZ6uklC22U7JG?=
 =?us-ascii?Q?44YJlfbBosci93h6Xi2ua1wV4aco5iPqmKH35eQmFKowfTgDe4Pq+RcM1VUQ?=
 =?us-ascii?Q?H1edmB+uJjLpbYYU+df5TQk8kHxQf1kbQCi8RCbvaD76j7o0RtSDg8hgwOT6?=
 =?us-ascii?Q?FHFzfy+CvncFfqeqMPKxoU73GSoJJzNFf1b3o0P1NV/u0KC481YPYBAouGQ9?=
 =?us-ascii?Q?nCl2YgOXxEIO7bPB62Q3MH5/yvkl9E9DNZ59GmPKm0Pd31WpvyDXsoA5WyRQ?=
 =?us-ascii?Q?TIKir0FLS8hwoWiv0ff0LyjlIQGMqE23NDMRzd6E1xj8Yhy+L6etifw55mxq?=
 =?us-ascii?Q?bv4tkkzQcsld3bE78hCAPwNVW4awu0CTBZDv58f94RuABXAv3RpukoqZY/qt?=
 =?us-ascii?Q?TROILdvm9m20EbGRp+TlAZ02AMACApB9bKsY1h5DPXLVkDGlNVhnqvYrZ/fs?=
 =?us-ascii?Q?cz9l7K4STCeOmMHGSinhaWNVYvt0sRTZWL63YmJ0LsCBxpE4Pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbyio5vl7FJOqfNOdU3/U9NAcH/Gf2BR7O0eb5lbfEZqf8/5/QMsMlMbg63n?=
 =?us-ascii?Q?MFj2wywHQ2ibafiF2VYKM1pAORXUZJXL+uqgKMXtO0hNV51zdCCabLaKlOb5?=
 =?us-ascii?Q?vRnVZ4+I8Mur3JrbDD0ciEKj0S4sCGAogGloXCA4bmF74kJJuUrGUPnq40Lg?=
 =?us-ascii?Q?k/SM59DtAl9mAlwwZmDYtNC5k1BoI3mjn7psEPDdwBX5B2hJDARH9vFwsBrD?=
 =?us-ascii?Q?2PKSqlh3piUZUbKGKikh8cLRbGIehGh+og2ac2ungvor2T8Xlqfz079LlUfS?=
 =?us-ascii?Q?XJ7RgoogVjw45A/KrRgWoHDWylOYZD7Lck6CiMriviJ1Ni0r9XwwbcTE3z/V?=
 =?us-ascii?Q?1Ai4AoXJUngQH6DBYndLxVvE4y1NXjdgIaGGo7EDAVucSq0GPFX1T5PhxRWe?=
 =?us-ascii?Q?t1p9qMdR+HetFZVOWQ6t2w2mHuU03giFe/n0kENeuNb2uD7SN8mgX9ayL5R9?=
 =?us-ascii?Q?uq4oSZae07XR6JPrgSpmr+m3zrEfZHIEER1oCUf6pUCRmzRyl630Y2GeUbwr?=
 =?us-ascii?Q?t53ki6UwZOuEWlFYbZWA5om6Jw8zXJEXKTfrf73v9AvK747WlH9borzffFIT?=
 =?us-ascii?Q?kkBJwBxfQD5qaLfKUYQ5ckE0Q143ydXPMOkfzC+YbZVZm5/lBXwTSpAbzcsX?=
 =?us-ascii?Q?K57Uq1i83c8lSEZBdRSid/AgSfLkVwPr+SAQHH3AmpK2Q5TKgHd6IH5YTPby?=
 =?us-ascii?Q?MLxydANOYCOVw7sOhFzrjXBbIDmn7L4gdVmElDhKI2kKbtUbzOtc4uc7J0l6?=
 =?us-ascii?Q?M7j/AEzkmN3FcOoRYap4FhFCjlFX/UPw2D7a0DTowtotg6gkDzrghVBsOIeK?=
 =?us-ascii?Q?2NlfvpqhD88j7aihHwFonVmARPRKasogcWmmmbm1SLGOkPyEY2Se2ImgfUOP?=
 =?us-ascii?Q?jMdL/3RjFdO50yTD3I71kBdpIUi1Jl9TI65Ie0L3ar0EdZrk/HkPatCfd0Wd?=
 =?us-ascii?Q?V9tEmFKNdvwcHnMIEq4LahR/mByyNk5qnbGz4zLaIfPpt2e0iZQCjQNWSIA8?=
 =?us-ascii?Q?iyurVfhrwtZCl1ofWQTuRE9lPaYmOMMRd/kca9JeOrz5npQkB6f5Fo3Y3s0J?=
 =?us-ascii?Q?DgdfUt5uXYBYejya5SIuNmQyFSCZAM4nv6Z+eNElzFMdSDDTeudk9JZuRsLy?=
 =?us-ascii?Q?4K/AR2AQNgX8I0nl47dt4mntAp9oPftT2NKwxBNvAvk6ZhTN7t+avN7YHqW4?=
 =?us-ascii?Q?y1bfR/onEzvReYf6k9SyI+TfHNhgZdsm8BZUn6mE3qzjt9IelftodJdjhl/S?=
 =?us-ascii?Q?P2+GGDH7G1KnjpLtiXvM4vn5dJJiIou2knZD9sEx6E6Sy0Ebcb9DVj4v7uWx?=
 =?us-ascii?Q?Ud9CoyDf2+JrK1kfJ79p4C3JeBolvQH2swGKb8WvqR94m02UfovUpRUvLUAD?=
 =?us-ascii?Q?XbMWI3yTMuNE6D8WN1jnMSJCcb3MVGo6uVwc+m4Qrt8cZaudJ4vtWzQubr63?=
 =?us-ascii?Q?bE4gBctj4s0oHluG+nO6HliabYrRMoLm/RRdxEYTPESzGwubZNgeNWBD1xoR?=
 =?us-ascii?Q?KtYJoUt+BgBQuvHaBT2PlVYjUzbXFCwTGPM+FcTYPcf5QIXJll8V5JKSjBOA?=
 =?us-ascii?Q?L3VIZNzCLzeEwbMDeGl6YsgYD1v4sfW0YIOAhy1CZ1ntDGou1uKo2y4xATnR?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4soU+THbBSf/jvVL4oEcvev++hoO7eu/6x1B9m59dp22B2roaHfjzagAhbO0BkFhJ2ky9taVhwBprgw19OlSfdHa9i8luqSWTiRyWJLsoWIjCMtqGhvwNnOJgDKiE9LdeyeJWbUAa7Wz4EpDgf1VpUvkUTEYJlal7qxvnmg8gJUqxvCd4d/PamEq6HIGh5cZ1XWxibhT0ollt28srxLi4DVia5ucl6kmBPiDuiO/+A/JsP1f87z5mmdS64qA3swF9RFhZiZH08wqlv0iSMXowUMNNT9TecI60wr/uWDoPXwQg+/jtZv8Bh57BDMUYBQ2Pq0RiWUN/nBba0b35IaO9DasbPh0hJ5MjTEFdSpTlAsnng7nB2z0CdmrPxgVUzLOJM8Janmq/LmmHXnFF2Kb0kV/vWmyurq/F+JuBSOFgbhk+MlB0rVcxv83dzcicZ/viP6MgDySS/yIJeJYnzptKU8u0o6eq0WQ77ZM9bHZ7B3GrcGE7mpSxJTtXdcnEvIoK7MHB1KL9HGUIiWOETxsdNCcc7rWmJua8RWoCvfaNNz1qODViG1alXeBT/3Zllkej7/uKfbF1J32wA/GaDloMSj+8atsV9SGLPP/TLNSTrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0d3494-012a-4894-ab23-08dd8cb0af79
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:14:24.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 460HcYz38Naprcs9o8Fq+dypstXEy7zF0gHc9ZwZ9uhAP3uqXFEvfAawXSObttYjpqOh9isEYy9B9ks71J/8mJJyaXP5J5Z81GWzW5WOYjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_07,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=919 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060147
X-Proofpoint-ORIG-GUID: 3wDy9ecLudUdshRN3sZnRwDe5ai14YqG
X-Proofpoint-GUID: 3wDy9ecLudUdshRN3sZnRwDe5ai14YqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE0NyBTYWx0ZWRfXxlu5pUyDGBlj uVYRzIofg+HdfQen33lhvktt1zJupKLxqiU8R6zWmK3WaVK82idbq/1tGVUTjeeI55z/g65ghEE vYHSXWaQz7dwk9+3iOAfSqNFpcaV3u5ZfJyvVvSreNC+8baUT83Rf3cr1PE5oWuS9RedeE0nL/Q
 QIY7lqDCvFuND2PGRM/op8G7UbC18+GSo7HMpIlvIL0vOZHo14BVVxVoOrWl34cwdJd1W67rWy1 Rxr5IReLbqG9SCBrP0iAegCmk30rKDn8vL1R7jiNrDdCtzZPUpFTdGDlZ+8UhU3lqoR3oo4XxTy rcMG6+vFq3wICuLmLnfC6oCTABGzSxXpZVCFneBfJ6XhUXHeXp9RD5A+kANPU5saASSa9/Se2OH
 u/HQSmDBSQTbbuk9eD5vvRqKrYcE9PgXbfPxN3nDzhRoOJrGYa8Jn0dSBz0X5dG55b+RXLgE
X-Authority-Analysis: v=2.4 cv=GNEIEvNK c=1 sm=1 tr=0 ts=681a2759 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=K2hK1QvoUbR5pwt-uccA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13129

On Tue, May 06, 2025 at 05:12:37PM +0200, Ignacio Moreno Gonzalez wrote:
> On 5/6/2025 4:28 PM, Lorenzo Stoakes wrote:
> > This bit probably belongs after the rest without ellipses :P but it's not
> > important.
>
> I was not sure about modifying the subject for v2. Let me know if I should change it ;)

Ahhh I see that's why you did that haha. I think for something this small it's
fine.

>
> > The series looks good to me, thanks!
>
> Thank you too for reviewing it!

No problem! Thanks for the series! :)

