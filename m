Return-Path: <stable+bounces-226977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNyNF5hWumm8UQIAu9opvQ
	(envelope-from <stable+bounces-226977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:39:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF412B713E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44D10301BA81
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95BC36B04E;
	Wed, 18 Mar 2026 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="j2vnfDiN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CE285CA4;
	Wed, 18 Mar 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819540; cv=fail; b=BXmkrHU35skOO+KP5CU5SxIGdRDFJBFLLlkA8OI7TPaXTgL2gL0NfGi4MZUuKu72qPZD1LbflGMSz1v80mxIW6K9k2oQ1efgJSbAhAk3wrqUEGgHKZnw/4aMWBS2sHaBC+BynDkjMxpGQDG4HMXAmEhZWd/XUknq+KoD+zFZBIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819540; c=relaxed/simple;
	bh=MrRuJLpkJCg4Al9sHyeJtVh7bmg7XoKmBzU2hR4NT3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rmdPVWKvU3Spm/t2AW+3keUm3RwsIIMJxgB0BBKKrQE/xFkXXVtD7lKNvpsOscZdDu2Jgtdv4A5i7PYwwagN2LcppB9XubNa/l/STrFr6tMDFq7BtjxgScbwhJiwnN2fVQk9dIbpH4IyVcmAJODBCn/O3BCDh2VJi3FbyeL4w8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=j2vnfDiN; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I601xh1848610;
	Wed, 18 Mar 2026 07:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=pF1ObXlmc16pBblOxddubX
	jfwKrrIk311UGHTRZVL5o=; b=j2vnfDiNmbjeNsP9t2IzXD9VhC4RzG8jbZiHcU
	HDmakTaT0do/2fCnNFqc6J3sXkhzPGyQz7lXcsNakCBe0QMWi/Zo9FjSvFhlYPaA
	lG/SNehDRlnapkrW5ah1Dh+bW/h96HqcX0LHpGZZwi7Od6KTVzgNTlp3SLcAmOkw
	og5n9+Afe/RhvyJDFOCSBGpA+xchgPg9ksY5+R1KLC3rglSvl2+FLyRFQ6GrsiPi
	TnzKyezSHyFgk7rK3ZBvsjpz8Sw9NmVyymi+Zd+oZ8WLFeP9Xj4Eqj3WeeJ/A96D
	JNaib+gVigYcInKRtkaN3Tc1AqtNlmeMgU3/Md0C1yjjIyUw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4cw06x1h7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 07:37:44 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62I7Y7Hx025811;
	Wed, 18 Mar 2026 00:37:43 -0700
Received: from email.msg.corp.akamai.com ([172.27.50.203])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4cw5n9edck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 00:37:43 -0700 (PDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb4.msg.corp.akamai.com (172.27.50.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 00:37:42 -0700
Received: from CH4PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 18 Mar 2026 02:37:42 -0500
Received: from CH2PR17MB3797.namprd17.prod.outlook.com (2603:10b6:610:80::18)
 by SA1PR17MB4658.namprd17.prod.outlook.com (2603:10b6:806:195::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Wed, 18 Mar
 2026 07:37:40 +0000
Received: from CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2]) by CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:37:40 +0000
From: "Boone, Max" <mboone@akamai.com>
To: Qi Zheng <qi.zheng@linux.dev>
CC: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett"
	<Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko
	<mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
Thread-Topic: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
Thread-Index: AQHcthbQ53vDINHPrkGROmzcGUn1MrWz0VuAgAAWngA=
Date: Wed, 18 Mar 2026 07:37:40 +0000
Message-ID: <AA2CFF2E-F3DC-4EE7-AE69-5FAF1CFE39E4@akamai.com>
References: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
 <268abf39-9cd6-412e-b3ec-32fb8fea1684@linux.dev>
In-Reply-To: <268abf39-9cd6-412e-b3ec-32fb8fea1684@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR17MB3797:EE_|SA1PR17MB4658:EE_
x-ms-office365-filtering-correlation-id: 3eea2cff-65e2-4eba-7311-08de84c13c31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|376014|7416014|1800799024|366016|38070700021|4053099003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: wkH2ofvzfKdtERRMvtWUmPrcbu2zPJw6UdUkNuYwFGC8VrRGblD4VpVdc1Ur07HHA0CcIxRCShgfLxQyjkoe4p3gl4fjb+eC0Y0Yk9PcWX5hAn/PY58ycmTaOSatmHD23fzAohy+SZd6bMDxYtmX6taQ54c5IV6jX0ZQd+gMEgqge7B+7WkhUgeLvUrjHj+TgtWZTPXk65Upt2ZJULzmcUmHOXZpfyp17wMfcI75PocnqE5qgBsaCuu5n9uEtWdfK5oFVJWqdQ4gd/EGxQ5ype+uSBejcXIdKyDih7El8HlkX75gdf5j1bEHl8rk7+CHBBz/qP7y4vJjRbA/afTPaNG1DdZReQapl0YNJ/Mx7Xdo6Ta/MWfGDWhc2bDu1UW2jNB7dFlftw8M/HbNsLOHZcd+7USuOJhyRwRmdAbka2v5tplT31YCF4NNcpzCtPq8ZZVKdGE2Mcu/hnkAwHiBILIhRxCnwepGSjm9LYCMpL/Z61SIsygtxTzwE8Muq4SNuctqZLO1wXzj8QEYT3tFYnWmojHrgRpl1DWT9lTxm+4GmTZOQ4sx5GVIHdd3sf7KwiDIi8MQpxQrcKdCz4WvRYh4AgtJH/Q3MpNL8eszp25MBtIoa4XQJnm0VJxwvoydgWzODJCqqZjiIk/sHne95YtTpeLq7tCfGo3lHZ56CdQ6iIB23pBnC6doR0HAEIUReJGyZ8XXzZz2OPRHu5nfbaT31gyQLeOtGoqKSQa33TfHGBbgeSX9haScdhTKFxmgeZ9M7jjSxQqzTCWTOl5DlTySgIx/NPa6GsQUw+aQ7KU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR17MB3797.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(376014)(7416014)(1800799024)(366016)(38070700021)(4053099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFZmQWk1ckhTSnlzMHVVOXhJb2tJSWVoNEZuN1ZlNDMzTHdHcUZPcG9lb0ha?=
 =?utf-8?B?bGdHSmRiUUIwZmdWY2M4Vyt0R3Rxek9oVDJlRUxjelVlNmhJWW9GOWFEVUlC?=
 =?utf-8?B?aStNbFVMRk1Mb1kzTzB0V20wSC9nOGdlbldxWndZeUtNYXZaMnNDRmRLc2Y1?=
 =?utf-8?B?MGtpMnhYTU1raVFOdUdVRVlSSTZjL2lob3ZYd01LdXVwSVpWZ2p2Nk02THMv?=
 =?utf-8?B?SGR6VWhVTDM1SmJjVTdMcXk3K1dKWC9IVVFrL2JucDJoK3R4RHM5elRXaU5p?=
 =?utf-8?B?c1FxVHVkS2lCdW9BdEtLSnJDKytRWHFSNytxTnZTSEJyYVg4SThIbFFpSG8x?=
 =?utf-8?B?Tzdvbld4aVc0WHJ2SW1mVXlQOGxsK1VwV1Bvd0dMc0thYk1wMTUvNlBNUEpn?=
 =?utf-8?B?Y3RGODBqS1VqZTd0aG5qd20vR2hUZVhUNDNjajJobG1LbDR6bjBTbEh3ZFdp?=
 =?utf-8?B?YmxhQTNKZGxNaWVNR2gxTUZrVnQ3VjF3alRYdTNpS1ozS01ZWTkrWmJFdFJO?=
 =?utf-8?B?dzdFRmI2NWFaNXJTbXgzblIreXZBWE1td29CMVpUL1FieWhHUHFUM2U3UFJH?=
 =?utf-8?B?QWNGNXl2d3NEUmtyclI4SWRKSnFBWmR5T0hqUmdjN2hzVlFndDFPY0VJejJl?=
 =?utf-8?B?d3hLc3pSQTdGWmszYks2YnJzbEZpTnh2eU0wcFlBMXFiV25QNUhvam10Kzdp?=
 =?utf-8?B?Q1NoRWRGa0pKcE1tNU5TbmRzNG9oZVBQZkZ2MFRXWWlaVGtvbVh1WkFjWDQ0?=
 =?utf-8?B?WklOVzlGTzJtcWdBSm9wc1pFaVdoSnZFRHgxM010Tk1PY1NobHZjZVBKVGQ3?=
 =?utf-8?B?WVVUQWg5Z0ozOWJYc1h5YUFOT0ZtWUVUTlpTSFdTU3ViZHBjeDdsMzQ5VmdX?=
 =?utf-8?B?NWl2dEg3YmhsbjVtOGJQR3pGRzRnNHAydzN6cEJvRUVEejBVdVhIcFVQUXpr?=
 =?utf-8?B?elVGK2ZVTnFXUHRPWUpMb2xVTDloeVJVV2lkRk4vdlRXL0M2Kzc3a0FqaEZV?=
 =?utf-8?B?bFhxSU9kVnkyY2treEZWRW5KeVRCeVBsQ3R2Vmc4b256R1o1aUJRY0g4T2Uy?=
 =?utf-8?B?UEZaZnBGamx0MDJrQkN5aXJ4MEtVZzBtYS9pWDVDZEJJL1VWL2VKSmdKNWhq?=
 =?utf-8?B?cXBrNFBlb0k5L2l4MU56S1liOGNrOTRrd0RtVEVNMkkyODhHNXY5czJRNDg0?=
 =?utf-8?B?cnhTaTUxaDJpaTBidXNETnJPMEdDRUNXRy9Vd1YybGtmRm1sOHc4Uk9aSXFr?=
 =?utf-8?B?cEpic0VZM0VpNncwa1E2blZJbnpaK2kxTmVoRW1Rcm1HZkd3c015WjB6OFZE?=
 =?utf-8?B?WWYxWG1vakx0L0d3T1FZYnNmaHlCMmFEZkI4VGtmeEVjWmtzb1ZkQ3dsQlNy?=
 =?utf-8?B?eGJMa25sTGx1L3AwcmRFaGU1djk2c0R5UmNaa2k4UEo0UWFodTMzUENaWGpk?=
 =?utf-8?B?U0dySDZvR05US09PUXJNam0yWFdDNDlMR1FyWjlYN0ZKZU13TzBzOWYxS2JH?=
 =?utf-8?B?clBERk1LTWRLaGwyREl4cXlBUU1TTEN2Z05FM3Z4TkRyRE9iRnRFL2hvdlZN?=
 =?utf-8?B?dEhkaXg1dTlxUHZ6RXJkWG9CMXlYL3A4dUVNQVFENXVnOEJTY1RDNm5ZU1NT?=
 =?utf-8?B?SlNkUVNITExCM3pDdHJObkF2TG1YcHlQZWZZME5DeHlEUzFmd2ROd3BaTy8v?=
 =?utf-8?B?ak9jd2l3WnRRaFRnVkd0RHVFbHhYbXVMcjErL2M1eDJyNHpWWjBGRGsxbFQ5?=
 =?utf-8?B?QmlLTGdwMG5NTFBHOE83azlGRmFBM2IraEtobWNFblJtY3BPczJOQ3RjUUNQ?=
 =?utf-8?B?SHV0ZmNCL2hyR0VIeTlENjcrMW4xeTV5dE9aRHhxbEFzM1NMTmdRUUhyK0J0?=
 =?utf-8?B?REwyT3pLbWgzcUsrbFlFSHJscUJUWnZWck96L3pCWkt5V2FadFkzNEZWSTB6?=
 =?utf-8?B?UEs2Y01RaWFWcjJzL0NuWkxTZGxMWTkzdERLVTl4K29FRHJ4cGxTQXJOY25q?=
 =?utf-8?B?MmYrckVlM2NjYWtVd28reFdSK1pYOUljMFVZQmVkZmdzZWdGdnRmWWp0M1Vp?=
 =?utf-8?B?dmcxbzlIUFNId2x6ZzBZV0t3enJ0NU1UTC9EMW9iZ1o0QUlUQ1lLOHY1Y1Y1?=
 =?utf-8?B?cXZNTWpxT2F3bEtKWEQ0cVN3Zllna1ZiNktXUWwyMFF3UlYxcDBiUWsxbi9m?=
 =?utf-8?B?eEdTT1F1bURzeCtvMTBvMmhjM1FQUFZpaThyT0djUE92UmlBU3dyYkYrb3ZS?=
 =?utf-8?B?OUc2blFlaGlKcFRaeUs5MVBNKzNkZU5Fd3RsK3VTYXhDNlRWQlNuWEE4b1VG?=
 =?utf-8?B?a25tcUpwczQrT2VreTNNdGwzK2N3RHc0Sm5OL0lZYkdsM0VnRW9zUT09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE9Aadv044q2ObIPX4KSXGOivyPv00eQeJd9RBKtOsIg1itKYR9g8fEmhvMUsNTlHVrqMPNHkXFc1jxUJdIGrS6+q8xuMRKFLMbjSb9Oufq0/rmZv3p7ZLbEC1816MGEfQvRAlDUVI3bQRvhcvSqsF96Dhkn65M6m+2LNU4dBFgKJWiAaa2gBWj4w903Y2K5A8fAdnlgLVCdPUGOP3lLXIOfWeGYs18mYd9t82cvIjxc3PHAXPLKf95kFJ5k2NqKvc26b2N8fwaofjx5Y0LtpGtuaIh0n+y0SGCyogfbswR7dr805TQrKUKACA1sfOaDLzB4H0f5mgXKxiWJcwUPSg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty38BFqfoVsuF3R33np7NTCa4qGVeS3C4OC01YudK2Y=;
 b=JCStfkybabgl4aV9EYMaei+w6BoFATkSJnzMMSRyWsaxTcE9+D5n/NpQdtHPkK/JZRvCIFXs+9IEpOg7H0o9YPS4FdCsU7ZbuUlCn8SARRfK8Ikf6hLC2M/1iy0lB1YZLNHIvr4Cn3gfg2jzjt1QtKo8UbTnUjGaX+Hgnjv8qC6V1NvItUPeyNwiVplxKrOIy3M4KeJ7+/FVSVuzQqhpkwqvAiP4NEnPbsf4MRJRSXarMY545/Pu7H62Tl8RD6ArlxtGgfeym+gDRD58gKoLe6s8ZgqJcmV17RU/zqfmUS1zP3ghwohv4wf2tLU6+Hhaow9Yl1Iffcf0IHVWeCrHeg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: UV0Kaz+t4GUODJgFpVED0VnZNB+Ipz4KlnsRAtXVS3rCblrAaJcC44O4wJafCeRdnTPAXeD+M1R2wVeFRI2i+mrRInIGrXe9jdfwicQ5YXZmdv5T7Zn8j80yc86wkid3BjkQ2CBfdB6ujy4pSjyKDrEI8QCF6HkcsasNVQwPXS1aVm99Dbo189DtkJmwvx/4e2FdZ7Z8Qe4jRIqUYXjoMazuDWGHzMwVszUMicqEEYRtWMnrtcUZIoyOTILgGrTuDGJXJ0UKV5oQghhS8fHH+CrD/d31sUZalAdFyHuH8by0ylKQ2gqTrWmp++B1hKZDN+pQ+hWF+akBK4QNSLtr/A==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH2PR17MB3797.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3eea2cff-65e2-4eba-7311-08de84c13c31
x-ms-exchange-crosstenant-originalarrivaltime: 18 Mar 2026 07:37:40.6544 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: DKcOGLwD/cQ1Qx68JMtxJvv7Fl+sG9C6KSeIIHb5b3Hwtslvi6U5O+B1KlmBJPcq7rVd69aYxNBOw0kxhs/6HA==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB4658
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_971B1C9E-F167-4404-9055-FCFF4078040F";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=972 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2603050001
 definitions=main-2603180063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2MyBTYWx0ZWRfX4bUd+z/88a+R
 D5xRohyU5liYXhoC344Sm7L/8Rzffq/Cxa3g2MDVQ/kwL6LZ5iR8hJix9BJRYGDkGFfpOLR8K+c
 abkB/nJ37izfp7ZD5PAvZHGO+MOrRBqFp4bG2hV3EneZZYnNuJXha4Ejcd6TETUIdkmbf6HT4lN
 J/GZ05N8g8gmagfX7j8d5tgYGKZDrgQot2ttzrYvB4elGQFKsgKEpLH5823IW+gokW/wXtniFhN
 BIxNXF1gG0sR1GYsOQxSIZJ0ugd6ikSvQYnIbRCgLczlE3ueY74SRJOIy1Pdv5mqvJPkO90T8UA
 fleuqlt6F0NSB8TVww0mBcVkLE+AKUO2Uu7jzSc5lrxnsNr5rz2b2k/XQaihvL7k16CZce+C/uf
 cy+erEeL1XE8RrxWAmU3W8R23lK7oYT84n++AeW6A7+5HdIbFNPwhOQEyinwU3H/yq+sZ/9WcR7
 LrefwgfXvlp1To/yspw==
X-Proofpoint-GUID: Gy9CbzEgHN4fGLUbRrjsyRpc4Z1WxYf0
X-Proofpoint-ORIG-GUID: Gy9CbzEgHN4fGLUbRrjsyRpc4Z1WxYf0
X-Authority-Analysis: v=2.4 cv=c4Gbhx9l c=1 sm=1 tr=0 ts=69ba5649 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=4xFXqd-_BHBjZVyr95gr:22
 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=uex21hYEhtRQNzC6pN4A:9 a=QEXdDO2ut3YA:10
 a=o-zvk0AIS6UfCIsagLUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180063
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226977-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[akamai.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mboone@akamai.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1BF412B713E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_971B1C9E-F167-4404-9055-FCFF4078040F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hey Qi,

[=E2=80=A6]

>=20
> Why not check pudval directly here? Like the following:
>=20
> if (pud_leaf(*pud) || !pud_present(*pud))
> goto again;
>=20

Good point, my initial idea [1] was also to put it there (although I
checked on pud_special instead and continued instead of retrying).
I wasn=E2=80=99t sure whether I could link to a thread in a patch =
message,
but there=E2=80=99s some discussion between David and me there.

Making sure that a passed-in PMD range can be walked by checking=20
if the parent PUD is present & not a leaf feels better suited as a guard
in the walk_pmd_range() function to me. After all, the failure =
originates
from inside that function, and potential other callers won=E2=80=99t =
need to=20
incorporate the check which has to be done for safety anyways.

It also makes the logic of walk_pud_range() more similar to=20
walk_pmd_range() - which also has the retry if it gets an ACTION_AGAIN
from the walk_pte_range() call.

Finally, doesn=E2=80=99t feel very natural to me to have:

if (walk->vma)
    split_huge_pud(walk->vma, pud, addr);
else if (pud_leaf(*pud) || !pud_present(*pud))
    continue; /* Nothing to do. */
if (pud_leaf(*pud) || !pud_present(*pud))
    goto again; /* Retry on concurrent refault as leaf */

[1] =
https://lore.kernel.org/all/20260309174949.2514565-1-mboone@akamai.com/=

--Apple-Mail=_971B1C9E-F167-4404-9055-FCFF4078040F
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCcow
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFITCCBMig
AwIBAgITFwALOJfLRtbGzZc1dwABAAs4lzAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyODA3NTYy
OVoXDTI3MDgyODA3NTYyOVowTjEZMBcGA1UECxMQTWFjQm9vayBQcm8tNDZZVDEPMA0GA1UEAxMG
bWJvb25lMSAwHgYJKoZIhvcNAQkBFhFtYm9vbmVAYWthbWFpLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOX+npfSrX/rwhOySq6aejQMUVslPFpNvXdEnmMlnEjR95gq0Ygp+wQc
Sde+JGBpGHsPMzHT1Nd3V1acm4cW1WB1aRqJOMfSLifg6SLkq2EM9WsftEiA1G4BT4UP0PFZY2Os
6TXvebAuVg6LwhB417rEJ2kuS/DKpiG8trAVDR6Uy9vbSMBp6iIewBc9r0CjW8l1zgRr+uQpXEUP
mF2BV0l3Qo5r0nhPqTWR9oAX4/oTqnhbEhQ3tOFYTjzO1K9DdzX8mVggVSZz/M0v0gtkZVvO4B1t
3Sh+1lla5eMY4hlVHW1/FKqMe4EMXmDH7goTEuXPpelJiNRdBh7ud7xNNFUCAwEAAaOCAsowggLG
MAsGA1UdDwQEAwIHgDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQw
HQYDVR0OBBYEFO0y/xWMpkyOUMuNKmuzNtjXpdtRMEQGA1UdEQQ9MDugJgYKKwYBBAGCNxQCA6AY
DBZtYm9vbmVAY29ycC5ha2FtYWkuY29tgRFtYm9vbmVAYWthbWFpLmNvbTAfBgNVHSMEGDAWgBS2
N+ieDVUAjPmykf1ahsljEXmtXDCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybIY8aHR0cDovL2FrYW1haWNybC5kZncwMS5j
b3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EoMSkuY3JsMIHIBggrBgEFBQcBAQSBuzCBuDA9
BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEp
LmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20v
QWthbWFpQ2xpZW50Q0EoMSkuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2Ft
YWkuY29tL29jc3AwOwYJKwYBBAGCNxUHBC4wLAYkKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIP
gUmFpcMQmtV/AgFkAgFTMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQw
DAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0D
BAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCgYIKoZIzj0EAwIDRwAwRAIgD5UL4MI1RXeg64RR
kifZAeItCnkZ4ecrqSEGpLcXV+ICIAdB9vZdM1WGxtag0rlqG0j0FBrCWixC0cdHNpFrqNx/MYIB
6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMT
DkFrYW1haUNsaWVudENBAhMXAAs4l8tG1sbNlzV3AAEACziXMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzE4MDczNzMwWjAvBgkq
hkiG9w0BCQQxIgQggRU2ccuUZPpQLWblikrjNiT3ZsGLWgFuBTfITu8APeMwDQYJKoZIhvcNAQEL
BQAEggEAY/s+oiSxmPCjUUllHZcpIrG5BB0ucRQsmtcckzHO/lAnrSnSsE2+R516o7aalDLHHitG
SxzA8CfsJbPLlpRVLaUdNX/6fzDKp3Sdpf8whd8wPwbU068fdXOyutPV4hIwv3R1qYgQeaUbdw0q
o0f9+X/QtQMUCkh02LDBJA4BG6BVDBKz9r6uyONGBZug1Jmt3oqtEDVbrHAJTzR7oKkE3A0EWf5o
V070fhcNpRm2vq6ys+GIXo5SyMrEM5H28WuIQCznXRMBRDezlyxPIgt2qAzP6o3wqLd0/52lXL0W
ywPcGxS/sX/9YPeUdCbqJxfydeftUsaIIC75oXgdEX4nYgAAAAAAAA==

--Apple-Mail=_971B1C9E-F167-4404-9055-FCFF4078040F--

