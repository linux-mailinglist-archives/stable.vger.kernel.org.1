Return-Path: <stable+bounces-71345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F289B9617BA
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 21:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FC1C21F4A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4F1D2784;
	Tue, 27 Aug 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A4B8d6d+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tZgntffP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83281AD2;
	Tue, 27 Aug 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785723; cv=fail; b=jGf0yKNs71d1+5qmIH1pm03S+ntnZyomjbYjkBf4lWcO4op/p536A1jR4Hr+17Bn3586AyiOCudpb3yMs6NqfcgO32dd8YolYdxisaByB8dt2nm4x+eexqyvniKmC6TGX5kz3PQS2+Ut+3ZxD/nBHh8n3B2ILnIaKioX0CadNlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785723; c=relaxed/simple;
	bh=EBxFjA2CoxzficJpU3OP6zdAFRO3eftCfO/BswhdIN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/7ovXNxHq2zx2ZjKlDa8SEiniBc+nvMPXn/tOU5M5gZ3MAsRqItoRblb9AhYy+OaTDkSqNFXIq5NU2ea55X2aUJMpOhcdADT64LsfOhgy1Tod/IsyU3/DJNTh4ASlswF0tmKzcnennsyJiggFjin2LUBbsAMUWbCyW00WDpG3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A4B8d6d+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tZgntffP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RHMqtW027024;
	Tue, 27 Aug 2024 19:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=EBxFjA2CoxzficJpU3OP6zdAFRO3eftCfO/BswhdI
	N4=; b=A4B8d6d+fpzAkHFc6oZ2qMCYmDJH33voz2KA0kpT0VXq3NPt+CEOSLxnV
	+JrqZB3l5DVvk5RYwak70OvQs7bjqXZKI0iII54BXqU9/8hQF0Arfk/LWCfITWVI
	N98uAKos2YIwOjPHyK+qdI8Rq7leJqsIbC9E2O6rbr6BSXoccqYqndbx2sAk69Bu
	M/ZeNQZZYFwFiXRcCRvf3kNVXUyw7SGSX44bvnfJuDDI1D8nQRuSQwtlzHmuFERV
	om6jATBlGqCZfPvJw9w9+dWLTUx/NTwnoi5jCbPfydwq6dBVFF1c/7LrPeqsjQa3
	074PlyEK4PCNExfTaMbqXMnLD34kg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41782sxe68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 19:08:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47RHalfP010551;
	Tue, 27 Aug 2024 19:08:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894ncxe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 19:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JypiN9MJgVrrDlNMV2FU0nO1+N64/m8G+i0DVTyGceEbfAa22iUr77CCUKkExjajfkkmwLkR03GP0faYKiXhlW3fGGLOcZ3Mlc743enULOexqx5Qa240WoSlqrLZA5CzCMdMGJ2hdMIdQqVjrhYCYvDMk7ve7Sa4Et3QJYIHBv+qcsEFzTr1jQZSFUAWmv8lDF/2RAb46px8XSh7Vo/XCQeWVt6dQ+skIf/wBVjyuRazxghg1jGFZ5i6bjAj0xXcBDG+60U1UHICOmfhAGiAR9rLM65yFtIrd1XRgSAjBOaJ+AuOvaxnFCOKIFU+wlXhnkxl0N+zxS42E7TNF4gJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBxFjA2CoxzficJpU3OP6zdAFRO3eftCfO/BswhdIN4=;
 b=flrt9aitI4DqEzMN1vsg7rk7TX5B5cX7XpMfn7BquSeYfthSu8JykKk++IFN21RTA/Th7v37LU0jZk9aP+1gQjTlLh0zHJvpViAEGlf0u482LnEuzUfLS5toX7wje/Q18UBFPRS41gBWXPbxYLnS7Q2hKJFfLGGYWYOvJpG+51wGDE2zF0hUbRsWsIumsAVzTaArWYK0UN9OaBGnsc9jBPHnuce72cFwNPonp1imR3Oz04mA6M6gXKHvDshMXWKhPuC9DOssI5Mn68f+p+Zxn55UvvI+ZiaWFw6t7nmSDLfhjj2vsySsZC7F9ana8t1n+JRbVniFR6G34HfTTzrMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBxFjA2CoxzficJpU3OP6zdAFRO3eftCfO/BswhdIN4=;
 b=tZgntffPLVCt+c595Bixj/ORjEDYFOn5B+QkapfIJsJVKXWjTGOCGyK21Z5Ev2JsDndaeEVnZneMNLUfY843x4gTxuhLH3NP2ROK3KvS85oyPas+O3D+Z4U+AuQ4Qazs/yTCRE9xXQZDlVgkX5aH4XrmJt7ZtaS57vW11mKYPKw=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by DS0PR10MB7977.namprd10.prod.outlook.com (2603:10b6:8:1a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 27 Aug
 2024 19:08:15 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%6]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 19:08:15 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Pankaj Raghav <p.raghav@samsung.com>
CC: Christoph Hellwig <hch@lst.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM173X
Thread-Topic: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung
 PM173X
Thread-Index: AQHZV45nokIbA+QLzEKTFICk+DnoIq8FQkIAgCUuMICAFJbJAIL/soyA
Date: Tue, 27 Aug 2024 19:08:15 +0000
Message-ID: <53369ABE-DB4F-44B0-831C-E4CB232A949A@oracle.com>
References: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
 <20230321132604.GA14120@lst.de> <20230414051259.GA11464@lst.de>
 <CGME20230427074641eucas1p185bb564521b6c01366293d20970fdfe2@eucas1p1.samsung.com>
 <20230427073752.3e3spo2vgfxdfcv2@localhost>
In-Reply-To: <20230427073752.3e3spo2vgfxdfcv2@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|DS0PR10MB7977:EE_
x-ms-office365-filtering-correlation-id: 9d3b17c0-b29f-4aae-2742-08dcc6cb9ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmVtZngvOWlDTHhId2t4OUgrZDBNSXNrdWc2YzUyTW1IWE42WkQ3VXJRcnZL?=
 =?utf-8?B?b3ZkaFhCc0ZUalFFVG8zOERqQ01MNE5mMnc1bXhEazNValhCSzJXaFRycDZP?=
 =?utf-8?B?V1l0cUpmbTFDakN1NFBzWkM5eVNka25kaHpXUGx1K2xGWXhhUkJxeWV2cWdW?=
 =?utf-8?B?WlEzek05ZVA3UlBGYnBSVzgwZkJNM0FkSjhUUFBlVUZEOThFK1gySVR3N1ZQ?=
 =?utf-8?B?eVNUakZEQzVla2NQd3dTb09zZDdlZGxWcVNabHlqMFdUTVYxWkhMdUVzbVRJ?=
 =?utf-8?B?eVNJRFRmL3k0WEN2UnVobFNMc0xJUWh3SGY4RkQvYUpKdHNiZm81L3BMVHJq?=
 =?utf-8?B?MnAyVU1nUjlvRkN5T0xxVCtiQXJOSnk2eU5nQWQra1gxZkRuRUorZHlIbHo0?=
 =?utf-8?B?MGtlQVNPZ1NXeDJzaG5OWTJxL3BHbDNoT28yUk9RNENZWkJmekRYa0RVVWls?=
 =?utf-8?B?ZVd6bUtLZGVmbnJreXRkMTJ4RC84ZWUwcHcrdHJ0dHNOQS9EYmZwMVcxdGRJ?=
 =?utf-8?B?bEd2WENRejJpYXo1RzR2ZGtYbno0WnJta2hTbTNuSWlRamdnWDk1ZGN4MUtC?=
 =?utf-8?B?NEtkU3NEelk5bXJROWdEMERXQ0E1K2xodTJpdzdRMWgxbk9kYi83N2hia2dz?=
 =?utf-8?B?QzdZcEdTOUJtK1cvZFFLYWFFbnR3SENXa2dodnMwcTZEbk1wVEVsRk9DWEw2?=
 =?utf-8?B?Si82K0FpY3pQdnNRa3pMaVNxeGcvcmcwekt2UnRzdDF4UytWQk5lNGsvTTRV?=
 =?utf-8?B?SkUxNC9QODBlS3NKa2tSZ1MvdVZJMEZ1ZTl1V2VCVE5WaWhuRkkrQ1NtTkdN?=
 =?utf-8?B?NHNORVV1TjlublpISEFUdWpraUIyRnp0YUVLYVNTeVZsM09aNFoxRWkzUzBN?=
 =?utf-8?B?SnJWUFQvd1NlaVUyOHNWb0IxWUdRTkcycEVQMFBhZ3hWbk1uKzhvVHRPZzFT?=
 =?utf-8?B?d3IwVUk3eGsrRVJQbWYyMHZnSDYvdEszTDZ3UjhwM3JPaEZweVJ5UkZhY01s?=
 =?utf-8?B?VVVBUWFTM1E5U1J1RHUvMGRML1V5ZlRhOFBZSStwdGJXeWxYTmlwOU1zcW5K?=
 =?utf-8?B?ak1valljNXB2RXl0RlU1L3d1REJqbmQ3NnpTWEVYbkNzWmtKWW9FOUtDNXdG?=
 =?utf-8?B?TEZXRWRLUlc3RUxlZGJDRGYrc2VMOStMcVl4RFVqYWpJSkhYNlE1OURuNTBj?=
 =?utf-8?B?akEya2hRcytQelJ1Tm94QU02dWhIaTRkRWgrZCtUYjJpck05RHdEZXZXZ2wr?=
 =?utf-8?B?cUYyeDkwb0xNN0oweFFWVWEwRHVKalZTSWdEa2E5cjVqYi9XTzVSdWU5ZnJx?=
 =?utf-8?B?U3VPV2xHdW5wdFZWWGtLTEc0MkgzcXVkMkFJTkI1SWx2Ry9DWkR2aDl2Wjgr?=
 =?utf-8?B?d1VqWjdaek0yWGNrSUN3eTFZSXpMNkxMRUp4YTRLcVl2c0M3OGRWQ2NQeGVj?=
 =?utf-8?B?bG1OTGNGUWp0RGNiR2d6QXJmTnFpWnVHN2xGZno1aUdtZlp6UUhmaTFZQlk3?=
 =?utf-8?B?cnJiRjB1RUJqVnRLSit3RVl0ZkdPRmR1eUtaQkxycGZLQW1CYU13ZU1CUHpa?=
 =?utf-8?B?bXFaUmxrbWVDQnpsNWRxcVQyYnBkamxzMGMxVGVvTWRtWFlzK1RVQW9qT3Zn?=
 =?utf-8?B?cm5WSUdoQTMvczFrOUJ4VFYwVjUyZ2d6RFhiMCtnRUJ4amd6VldwNVFXVjFU?=
 =?utf-8?B?a2VTUkt0OU5iL3MrWlNKRVBYUmgvbWFvNGh2SitRTlk5SnpSMVN3VjdjU3RP?=
 =?utf-8?B?ODMzK3VYck52U2xOUE1lTWVtaHlpb1k4MnIxam1PWkFmNjdwR0ovUThPMXpY?=
 =?utf-8?B?UnVyWitLYzVrWnJFdW9DZkR6Tk5lcWx2dk51SlM2ZkUrSThRSFJ5QVVBYS90?=
 =?utf-8?B?d2NCaERzbmZlMm9zdUhwbTcwMDhzclRtVG5ldnY1dnloNEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUtiVTZaeHVlSThFOWY4eTVhS3dqTTdPa3owWG1ZUy90YlJSZUc4NGJvZTh3?=
 =?utf-8?B?bWFzK0N4YkJtSkxhOHViOHZKajhzTFVKTXZBTjc2SzZaeFNJdjRuQnk4Nnd0?=
 =?utf-8?B?aGYrb1I3QWJXUVZYK0VOd2s4UFRXVm1WdHVSZ01PYWRzSmdWcnByQW5Qb3pY?=
 =?utf-8?B?aDhVaHVpWCs5ODR5MGhZSVNVNmsyRGNnSTlJVWNvZ0pMWE9FNnVqTlpaWitn?=
 =?utf-8?B?U1ZTcHYvOUE3aG9jMmlUN3daenlXeUlESGNOejBxekhCd0Q0WEc3QVFFbmtm?=
 =?utf-8?B?UFVzQ3M1ZytEc2lDbzR0eEpnbGEzZUJ1TmZKRUdxdGdpQnczcm9hQTc4L2lM?=
 =?utf-8?B?OXlvaTVwOURlT3pYRlJreFhpb0xzRzZUY3NLUlRKZ1dXMC84RjhzZTZhZnZZ?=
 =?utf-8?B?eWNSQnhmV0JqQWhFdittTk1OUDZMdnNQdDRYQis0MWllMko0OEgwbzJUSWJJ?=
 =?utf-8?B?ZEFNYnR4WExHT1BTNnA3c2V1SnVQLzhrYWQ4QUkreUNETXU5SFk3bU5PdEYr?=
 =?utf-8?B?V1JUdW80QUo2NWp2NEZ0Z2NvZnJqaFl5OUNiRTltWUl6RTlGcE9lZFNMVkhR?=
 =?utf-8?B?U0xrWVdJVzRST0M1RGRmUnQ2enpzQUhWaGF6RkhvSzg5V3BsWEhlVjVJMVhx?=
 =?utf-8?B?eHIxL09sUWNZVDlka29jUk1RRW5vK0RiWmpEcmQreCtLejBhVUxhbHd6dlpi?=
 =?utf-8?B?b3puVmZRYkVEUElxQmYxenM1UjNwWWpyT2w5MzlEMVBhUU5NSU4zK29WMnRi?=
 =?utf-8?B?RTIydDQwc1ZPTE5rbjVwM2w4Q2VJd0dOK1FJUjErM0xTTVR6dklnSFZHenVm?=
 =?utf-8?B?Rm5jaTQ5RW8xTm0wbmhzOUhISmpaQmVGUjR2cWdjWG5idVZzbkl3WE1ROVZW?=
 =?utf-8?B?ZCtnczJGVzJMaWQ0VFF5Z3JQamFqZ05TYTRSRmFIclB5UGdKSVJubnBkcTZH?=
 =?utf-8?B?YlcyL09WemorREViOVNaNGF4azM3S3Q2UVBFRHR1Y0ZzeEkrV1BRZmhETHEr?=
 =?utf-8?B?MmF5TFJWRnNDQTRySjBQdkxwS0s3VGI5VTRRQzQrOElmeHhZTW9hRG8xWjMx?=
 =?utf-8?B?M2hBRUQxdmJwVGJPV0tFc2hSSE1ES1VDUTNIbDVtU1YxSU1hWnFBLzV4RGZE?=
 =?utf-8?B?NEU0cTV5Rk9HbHBFVC9rQVZVU1NKb1AyM3RSRE5ESnBiZ1VIUGFSTEdmUXJT?=
 =?utf-8?B?Wk9jTlNaM1RlazVvaFI1TWFWT2RFTHdSaVFwL1V1YlBPZHNzRThvRTdFQTRi?=
 =?utf-8?B?L2FyRzJvRU9LdnFyZjJ2Mm5wOHFpZHF2WFgvRi9lWFFPZWxqa1Nibm1oY1NS?=
 =?utf-8?B?UnJGaWZoOFlwd0lhMVN6Rm13OUJqVElnbUk1b0RWTy9kbEl6SmRRQXJwcGM1?=
 =?utf-8?B?eU1va3FDcVpzU3p0MEhUNEthdWxNZEVRK1BDTDY2bnpaaHB0RlVySWRtMkZP?=
 =?utf-8?B?V21TczFxTi92elpLWUZacFVMNGhPR0VtdUt4azZpc1RCYmkxZVhWTVIvMVhT?=
 =?utf-8?B?WEMvL05CdGZROW52Z0JTcTlaZnoxMVQvL29WZUpKVmlTZGtpaVZES3cxakxO?=
 =?utf-8?B?UENXUVhyeWk1RzV4ODhMdjZpSzgrVUJJSkt3UGwxTU4rNzNsZ0ViUnpMalpV?=
 =?utf-8?B?V1Z1RXR6d2t2QVJCN0FHVmo4S3lOVytocUhFUm5tS1RYTzhSN3RYYjFnRDZY?=
 =?utf-8?B?di9pZmtuOFdMZklKejUyeWdDekhleGJaUUk1M2ZQYkczZlJWdUNnRXBINXZ5?=
 =?utf-8?B?bkp4US9MaTgrSmZWQldib0JRdGxCUjd2NUpBbVp0OGtyMmtIWU5rUHErb2F4?=
 =?utf-8?B?K2s2UGFtR0lMVWpWdmphVktlbzl6cmd5MG1xQ1Y2SElMcnRxN3BXajIxVHJN?=
 =?utf-8?B?Wkk0cW93T3krd3Y3UENMczV1YUorRTc1cmkrem9OQnIrOHg5a2hvZ2VGRXcr?=
 =?utf-8?B?OTAybEk4b0g4bFRkSjhINHg5NXRmS0pVZ001cHBwWEVUVUJDWXR3NHZtT2Fy?=
 =?utf-8?B?SkFlZzVsV21Pb0dPVUdEZHd0ZDVkNGh5UWVsa0hwNHFzVWM1WERPaEdvZTNx?=
 =?utf-8?B?TllWdUQrbGZDU1NBWVlCdDZ6SFVYbHBOODQ2U2RzNlRHeGVnTEtGNFdvNVlM?=
 =?utf-8?B?WjBEaXh2dFMvNkwwQXNRcTdac0JFSGpQd2pOblRCMnNJTTBmTWFvS2VlUGZU?=
 =?utf-8?Q?buMWfMAY/Vu+foH5cLiSop4Q5wltKXRQqbQWWmSewykO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56556109DBBF1E4E823B5E5A262ABA35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oVsqr4Mxd3aGFKN8savFgVFWyh9rKy0fQCJ3ekmUPPI67th7FOf0VyUZ/vh0QcM5UvhcpbUtHSptS9HCatpnd9j/IhfFLoKJPdUma7m92E3jW6Hkjf75WijTJRH9XWGKmeGxwRHBOd8AxHmickYAMCgbBvHpk86XMGyHjyXPF4DK728MhawMeG4JydVQda97ICs+d7luET2rMAcmX1fe4UctqVo+I+KFfKEPUasZzw4grTFAmKoQrTU5ZcI8R0s/6ImPgghj0U/V9rgWH0khj00i9nCfqu3yyevO/6XbrBpdeeEENglKwwILjMa4sT4vFE2WY2M181D+3UYly4L1XcG/TtYyXQYV9IS/8dqkiW6sJJEKNl5tFPImwFpUuC7C0agEsCksTdvOrwu8GFAvULip2toZG5pX6wN9Jy2Q7j4hvzARwHdr1+NYcUfbzwMPmLvdUcTK5QmoB0CWIwIsGh+Sy2TBAeCxW9zXiFRHtOTlWFMl9GRB5Oolll0F/8+D5q3xRLuQAAdbvtVEujWmXTvd1K+irRJVS0xO70TwPfuQwR0BnT2kOoLC91ElQpcn5KSCliIKg/E7wptWiZYVs3bywXq9wO185M5HhhdxHDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3b17c0-b29f-4aae-2742-08dcc6cb9ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 19:08:15.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbUHJBA4GeW1Zf1qbsPDS3l4Cry3hWLoHLpRAsyqeYraDOfGC8HyN0/q4f+2RLPSmkDiOinJxRxm3LWv1ZBF+m4IQQllq1J12GZImqds54w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270143
X-Proofpoint-GUID: 59PZtdl3w098jxDvl9g6MfEYN9E6B0Z6
X-Proofpoint-ORIG-GUID: 59PZtdl3w098jxDvl9g6MfEYN9E6B0Z6

SGkgUGFua2FqL1NhbXN1bmcgdGVhbSwNCg0KU29ycnkgZm9yIHB1bGxpbmcgdXAgYW4gb2xkIHRo
cmVhZC4gSGFzIHRoaXMgYmVlbiBmaXhlZCBpbiB0aGUgZmlybXdhcmU/IElmIG5vdCwgd2UgY291
bGQgZml4IHRoaXMgaXNzdWUgd2l0aCBxdWlyayBmb3Igbm93IHVudGlsIGl04oCZcyByZXNvbHZl
ZCBvbiB0aGUgZmlybXdhcmUgc2lkZS4NCg0KVGhhbmtzLA0KU2FlZWQNCg0KDQo+IE9uIEFwciAy
NywgMjAyMywgYXQgMTI6MzfigK9BTSwgUGFua2FqIFJhZ2hhdiA8cC5yYWdoYXZAc2Ftc3VuZy5j
b20+IHdyb3RlOg0KPiANCj4gSGkgQ2hyaXN0b3BoLA0KPiBPbiBGcmksIEFwciAxNCwgMjAyMyBh
dCAwNzoxMjo1OUFNICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+IE9uIFR1ZSwg
TWFyIDIxLCAyMDIzIGF0IDAyOjI2OjA0UE0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Og0KPj4+IENhbiB5b3Ugc2VuZCBhIHBhdGNoIHdpdGggYSBuZXcgcXVpcmsgdGhhdCBqdXN0IGRp
c2FibGVzIHRoZSBFVUk2NCwNCj4+PiBidXQga2VlcHMgdGhlIE5HVUlEPw0KPj4gDQo+PiBEaWQg
dGhpcyBnbyBhbnl3aGVyZT8NCj4gV2UgaGFkIGEgZGlzY3Vzc2lvbiBhYm91dCB0aGlzIGludGVy
bmFsbHkgd2l0aCBvdXIgZmlybXdhcmUgdGVhbSwgYW5kIGl0DQo+IGxvb2tzIGxpa2UgdGhlc2Ug
ZmlybXdhcmUgd2VyZSBnaXZlbiB0byBzcGVjaWZpYyBjdXN0b21lcnMgYmFzZWQgb24NCj4gbXV0
dWFsIGFncmVlbWVudC4gVGhleSBhcmUgYWxyZWFkeSBpbiBkaXNjdXNzaW9uIHdpdGggb3VyIGZp
cm13YXJlIHRlYW0NCj4gcmVnYXJkaW5nIHRoaXMuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMg
c2hvdWxkIGdvIGludG8gYXMgYSBnZW5lcmljIHF1aXJrIGluIExpbnV4IGZvciB0aGVzZQ0KPiBt
b2RlbHMuDQoNCg==

