Return-Path: <stable+bounces-100690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE699ED4D6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CE6283ECF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DD91C4604;
	Wed, 11 Dec 2024 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvxvaZdj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NMzLw1uV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809751C4612
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942725; cv=fail; b=YaZjQwSFLSzL3bub4Sp09k1XuidgdF8FXNa8BGm1XmxVnHxMNRUfMJLTR1bvd4vp+B9tJNmG7WxzOG312OFCrxDGEYLfKcrRz+KpJKkKCzjBxPImX72SbXibMPxW8wepse5f5Sg+XyW7DOojVXM5MsX6/ewtW9qWPbgIxP5YoRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942725; c=relaxed/simple;
	bh=/S9YmcsoYXI34BucgthFk9JgkonFkaNOjAFdDKQRC7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufVQfvztSLeRt5msmdPMNK7vkFuiqDqqPsCAtF92a79qYFBb7Puf96qlLpHpKBvK4L38azCyIvdQkHbomE6e8TYNNDCqsUQjRfhakzOE0HzYfzgCMQbHGXjig/+BToojQwHZz1PqQWTgxaEvpLfc2QVuzwkl7x51DvrBYjFrhCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NvxvaZdj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NMzLw1uV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBEMpb6007223;
	Wed, 11 Dec 2024 18:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/S9YmcsoYXI34BucgthFk9JgkonFkaNOjAFdDKQRC7M=; b=
	NvxvaZdjyYdvdmlsGfhaKZ6lm8hNEmwfzS3hQ3Dw+fKT/94uZz39Asg9H6fBzNvQ
	z76fHH9Uy46t5mm0jiC8OtWgeFtQe+HYg/p0p60sA1tFs/t/pDxYNrkKF5h8voDV
	ZNNoVX4nVDd8d28Vzfeo8tZbHxRUFne+NLn3mZeBO1XvZSOI1CG1m/66XEZjTmmT
	Z6VRuKHcOrLWUACn1NzRnfYBQsR5nJ2wZbueuxAxbsZs983ffHX9IcEAEh+Eaw8g
	9DmsLL9KycyuSDLY00xcBAEbniyFIXwujhnq0/SsjILG+xZRi6rW4SNHNF8OGjnX
	aTiz0VRpVBmhP9390/jf6g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr67fx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 18:45:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBIEaS2019284;
	Wed, 11 Dec 2024 18:45:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctab6ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 18:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAM3MuTcGLoLG/Us+Onm7dYSkeC9yvX1ppecKLuduy/GT6utoYwRf4dRt+bv2jj1a48PN6ISA0rwVzBcYxNZ7wwSBdCkmPXQaX3VJV3LNX/w3LKBnO3GE9gl/WQutInJ+zPYUTGRf2789nnsxMHWdUPtxeEG+BjMbV0X+VaCOqDG+JqyvmtM2z2nsG6Z/uyKLSJ5++3T/YpNa0d8UE88NJfIPjp08++19XQ/i7FYUDHvdCoikjo8agzaPGzti2MYfRvOWEaRU+el+wLy8jIIoPvRac/3TicZgkii2c4Daebyjhyf+MeO2rOmKcqkWbBPgkyg7Ey8W7RqG0vXypouow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S9YmcsoYXI34BucgthFk9JgkonFkaNOjAFdDKQRC7M=;
 b=IcaR6zD/HuKKKI+kEEGCpABWzZORNn3TvKNCIBulHf//L8VrFwBBzVa6mbYf1hCJ3KtLALHy74pawMN5nxT1pGhXC2Tlw6+mE9GPuJDoid49nmupHkTW84Lr5IQNOOvnJutZbACAiLd8DoZKJTfAX2SagBI7/BpOPP+FpzLX1RXOTNpCcfFbrx21mRtcf3AtXZFvV5O0NdRt4pfNOPgLZEgnIKCO8wj+i1u1V6Ajgmin8/636TMzkXmeVEbv8oJgHZ5wVj6Eh/iHrxx+faEi4Yay5Z5WWBqBwOJHnPGZJv5Cf9V+bZ2Ynb/7HvhZAy2396WcNLYwm+d25NlpQAHOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S9YmcsoYXI34BucgthFk9JgkonFkaNOjAFdDKQRC7M=;
 b=NMzLw1uVkQTWa2YbOWAmwq+6a1wamUn+LHyK9k6cSb/RFxfQgzuvRB4sxshFO8L5anP8k/vVhfaBOsNF9+hdFaJSYj72mkdzJGtzEfPX8Hk6P948+UOchh3AO637Doie7feBcrv1HcsO/qMnYHNOd5dvdrywOHZ+7thsmkES1v4=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by PH0PR10MB5610.namprd10.prod.outlook.com (2603:10b6:510:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 18:45:01 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 18:45:00 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Christoph Hellwig <hch@lst.de>,
        "nj.shetty@samsung.com"
	<nj.shetty@samsung.com>,
        "kch@nvidia.com" <kch@nvidia.com>, Keith Busch
	<kbusch@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: performance regression fix in nvme backport to 6.12.y
Thread-Topic: performance regression fix in nvme backport to 6.12.y
Thread-Index: AQHbS1LnAOmUxgKOREGY127O6PmJ8LLgoEAAgADCnYA=
Date: Wed, 11 Dec 2024 18:45:00 +0000
Message-ID: <C07DD131-C6B2-4FBF-BE4F-13C492CF217E@oracle.com>
References: <1DB6C887-2C97-40C8-8C8D-0F38CE68AC0F@oracle.com>
 <2024121101-flashcard-whenever-fc08@gregkh>
In-Reply-To: <2024121101-flashcard-whenever-fc08@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|PH0PR10MB5610:EE_
x-ms-office365-filtering-correlation-id: c1d77e6a-6cb5-45a5-7357-08dd1a13eb2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGtpeFEwS3FFUCtvemFiWnhrbFBMYlBrRWExeDQ0d1hqay9lWVZaaTBIVDFN?=
 =?utf-8?B?SjN6N3Q4aEg0Ykd3UEFheGVHaFlzQ0dmcDhnWW8zNVBDTGV3L090R0dyOWlY?=
 =?utf-8?B?RFRHUHh2bHZCUmk4QTF3aFJSTUN1L3A3ZE9SMjdLTWdzZmtzdklUbDJVZzdz?=
 =?utf-8?B?WXg1SzhTNDJoYjZvRkhTOTB4aUgxRG15dlNIek9WalBLcTRBQUM3dGNVaERG?=
 =?utf-8?B?cGZna1grZlNPcXVDUklUU2xCWEJaekRNV3ZUOE9jcnNNQ255QkRpTXpSQ1BE?=
 =?utf-8?B?YVNOaTNZenBVZERubm5UUWg1eDRxb2pyaW0vb1hGMWxuMFpBZXVDOTlBMERK?=
 =?utf-8?B?VklLUUJFMHVKZE1ZYjVkdHRjaEJJdEhwanNKSThOMWo4VldEMDE0M3liR3BL?=
 =?utf-8?B?eFY4Z294QVQwZnVyUW9mNTBHYkxJWTQybmZBRlNHQndjeFpzc1kra2N6U29F?=
 =?utf-8?B?Smg2ZEJSVEhSZ3hscHlEVkNpMWJNeERYM05DWVphdVY3TlQ3UFlJKzljTGF6?=
 =?utf-8?B?UkhIVHIvZytXYTZacnk1RkFia09qYWNLOWFxME14bEdORk9mcUVRZVhuUUgv?=
 =?utf-8?B?RmhwWVVoUEVESE4zZjBJdkIyK2VCdldBYkVBZEJiaVEyTU9vNXFBaXJUUDkz?=
 =?utf-8?B?dnNQOWhpdk1laG1uMTAzMUg5SXZtYnJQZmlPcGI2TUFxbE4wU1pjTUNZMkkw?=
 =?utf-8?B?elhDM0RsN1FNeXZjeUtiSXJJQzJnemhOMTM0elhQWkVEa2ZVQXA0YTdjM3o2?=
 =?utf-8?B?U0FOZVRPbUJSN0hDRWg3elMrV2Eyc29NazY1S0dVYXh6dTFRM3JUTjgrT1JP?=
 =?utf-8?B?NG4yUVRtTm1JanJNMDkxQ05IUDI5dlFIb3VxRWIwL1hQU2JrWnZRNUs2QXBh?=
 =?utf-8?B?Vys4ZElQTWZYUXFGQUxFRkRQc3NqS0JVbUNkSmlTZnFFSDhwN0t1clAvSUhJ?=
 =?utf-8?B?UGdyVXlnOTRFN28rMHMzS3Vlek4ranhaY3laNkk5dzNYL0hGZEUvOTVGOHVv?=
 =?utf-8?B?T24xM2RSSEhJNlptajcyTEVvYUlkWXVMTytadmFCbk9TRGZma202U0FQWndv?=
 =?utf-8?B?RXV3ckk1V3l0N1JOMXVqdDJyVS9WTVZFUm9hdmVqQ0dIbUdHUmJjYXNaRjlp?=
 =?utf-8?B?TTlseGd5Q2h4emxvaEpHNnZUS0oxUXRHNUZiYVJMbWJ1Y2pxSmRmN0wrNUpm?=
 =?utf-8?B?eExCSGJjTnhnYTZUc00wdHlHamN2VEpmMkI0NFovd3NuT0xVNXNmUUVwVTR0?=
 =?utf-8?B?NWsyVmFucjEyMlk4eVprSmFhb2I2N0hqZ0dITkF3bTRZdDErYXJldU4vTCt6?=
 =?utf-8?B?eTdCYlI4cXRQSjhVdUR5UHlLbG55WkNIWldvY0N3a3VhSjVxaGs2REtTbmJ3?=
 =?utf-8?B?eEtnK1JsVlQ1bm5UUDR5ODVOTzNHcFZ6cFM1UTlXVXVJL0ovd0NtVzJMSTJG?=
 =?utf-8?B?enFhd0h6K1hhWXVEYjVscm9LVlR4ak5xUnRoSitxb0hFRVlVRE5aRkx6MnVw?=
 =?utf-8?B?Zm5ua3VRTzM2dHdPRjMwdHBYaXZ0dWxpOXRZdjdNdTFEVFdER1dHdS9weEpo?=
 =?utf-8?B?U1ZKd3libUN1TWpCMFp2NS9RTDdQOWgvZmZsREJzL2FhZlI1QXhOeUt1cTZy?=
 =?utf-8?B?aVNGL3d2UFVOL2R2N0ZnNUdZSlB4N3lFSi8wZVRwY3dPNExuVC82VUUyRjNn?=
 =?utf-8?B?NElxM0gwZXVDc214WFNuWUR4SU9jdWl0ZFFtdjRNQ0tuKzRqUEZVMG8wMkFK?=
 =?utf-8?B?OVgvVmgyNHRQejNlckdWYURPQXpsamQwaHJodTgrT3dGS0lhRkxuelFBSFp3?=
 =?utf-8?B?dEFyYlZOcVhTcGpoUmZTMS9pRjF3K21QbVJubE9iTTBtL1hjMlVnVHk4SVdN?=
 =?utf-8?B?c0hiWmc0cUtzK2dBcER1aDEyTDFiMjRDd1FGb1RYTCtLeVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2x6aURXRy9oOTlxV3pnMHp0Sm43MVZ3S3pTK2YrMjhCWm5PRXBTb2ttOWtm?=
 =?utf-8?B?SmJWQk1QSHZkdmluVENDeXNMTkhnMVR2NDFSZ1E0RC9sdVc0UGVxMFFvMTJP?=
 =?utf-8?B?S0dHYVpxQ2g0WTJIWW5JTGU3VVZDNGpicGF4Q2wzVXhkUm4vc1V6VXlnWFJ5?=
 =?utf-8?B?RzhPUHp4NzYrM1UwUVJha1VjUVhleWtXTzZ4MEE5NE1oV3piaEdqUm9nQlFM?=
 =?utf-8?B?OURTWTcwdmF3bjI5M2RXUyswdnhzRUJZRjVwS1N4aEZhN0dHZVlRN2lDWVpN?=
 =?utf-8?B?UVFtVGRqdG9PVnQ1TSs3U0paVXdMc1ZsaWlMV1BRdlRLS1NaVTZTbFlwQ1pH?=
 =?utf-8?B?NnNsNW5IU2JwbVRuWFlGVkJTc294Y0Q3NncwUWJvaHZ0TVZxck1lVGg0SjVm?=
 =?utf-8?B?ejN6RVc2ZzFYWUxLa1JvQXBPKys3SmpPdHBrUjNyRWRONU1zbkRBSm9JY3Iz?=
 =?utf-8?B?OEJ1Q2drYVhvOG5Qb0Z3ZVVBZFlPR2hpRk1kZlhGMFNHMkpxYkVvd010T0ky?=
 =?utf-8?B?cUVOeDVBemNVampKczBKSDR0bGYxSFYxdzN2M1l5L09JK1RsL2d4WXZVUFZx?=
 =?utf-8?B?Z29ERmdCS3Y0RXB5UmRCRTBrWU0yMG9kWGhXV1FQWjNZc0I5a0E4R08vVGo4?=
 =?utf-8?B?Sy90bXNtd0hqL3BPa0xSdEJWK25ZcjJBcUpkUnpNK3U1RlkrblU3Z0FyYm1l?=
 =?utf-8?B?dUNqWExRQm13Smoza3RoZTZhcW02elk2NmR4Szc5T2c2cXZHaHV5Y0M0Y0lv?=
 =?utf-8?B?MXdlaVQ5SnBjM1NMQW10R01mUnBraVZwVEJuTjdvSnJjUEhlZC96clVxUmw5?=
 =?utf-8?B?M2hDVms1bXdqRDRVaTdmMXpyUzNsR1lEQ0kvT2tCVHcvSU1xcy9aU0JVNEZ4?=
 =?utf-8?B?cWdOOUJMMlY0R3d4M3JVUWFtSmliN0NoQWl6a1loWHBlWk1ZWVZ0NER1MVlQ?=
 =?utf-8?B?NjhBdHdMS0tEOXQwbWFhUHV3QWZkM3NBRWF5Vk9scHBUVzFvVnpxUGhIK2ZB?=
 =?utf-8?B?L3BrcWxHM3B0U1ZCcXlIL2Y4c1cxa3Y5NmpTb0pwb1U1bU1halBFWDAxcVh0?=
 =?utf-8?B?S3N6bW5WVXhrT2FnYXBSWjVkUWt6SFhmRWtzcEdJMTZEVEJMamFPbVYvQmdm?=
 =?utf-8?B?YTBkY1BzUWxOR0hHOVRPejhwbHgyRmhnOVVkZzJvZVRBeWo3TTZGZUlRQnBP?=
 =?utf-8?B?cEdHeEgxbkNEYzJsY1pxQTZWRUwvekFjYWJLMWZlNDg5ZGRBR0tuNE9rOGdC?=
 =?utf-8?B?dlRHY1lCaWR6NlVlVnZ0aWo1SlR0bkRRdVRvMTZTU0FuZjlZYm5HLzdzTDVi?=
 =?utf-8?B?Z0duL1lrbzBIMVgycFM1WVR5N0drT2E5bG5Cc0FlaGVYTDF5dTJBMFA5cmg5?=
 =?utf-8?B?dkpVUDJYNzlwUCtKRTRCQmFEWjJNUzdoeUhweHpFdkZBZ0tidDhzM1BOa0xj?=
 =?utf-8?B?dXBlTForZFk1QVUvOE1sc0VWN1Zka0VjSFhURzNHcEVyMzVHaXhxd1ZFNFZl?=
 =?utf-8?B?MDdGanVDc3h3Q2lROUhabmNQbGozNEhFY2I1clZPTHQ2UVVjQ1VkYllpQVhJ?=
 =?utf-8?B?eXVta0RNQmxRanQyKy9JN2Q3RFVQWHJPUk5xU2hUVmc5RFMrNERMRTBVTWlU?=
 =?utf-8?B?WVBqbmp4S3ZvK1NGWmM4cVdJTmVuQnZvckZiM0czcWV1SkRvNjJ3amZlR01J?=
 =?utf-8?B?UFU5cFNER25pWVJ5ZmJ1WXVab0NTM20wVUIvQTFxN2VFRldVZDlHM3pCdEdt?=
 =?utf-8?B?d2ZuNEZvcnd2ZHh6c1RGaUZoVEhHTzE2clVPcDZWc2tBbHpaRUVmTE1iUHpl?=
 =?utf-8?B?RWxROHl0a3BNTzc3aHo2Y1lKVy9oUU9jdU9lQUhJU0NmTjE5REljU0JSL0JY?=
 =?utf-8?B?WHBmTFJtbUpLOUdaaE5wUnRmbDMvaElCenZkU0RCWXlwVGEvalBTS2gxK0RU?=
 =?utf-8?B?bjV1dklVeVdjUzVDM0JvbEJ4dVdRZnpYTG43Ly9WVmkzaGViLzUyclA5VnVx?=
 =?utf-8?B?Rk8rekk5R3JmYXZLTWVFYlRoSDVjaUpBVWt4UGpKWm03VG42SVJwOHJXbDBH?=
 =?utf-8?B?UmpSMCsvZXo5WTRqL0NzTVNFejZ2VXg4WUg1ZWFTOExIZEFJemtQVmE2Q1Fq?=
 =?utf-8?B?WmxkOFV5T2Z1K1IzblEyQzhRQzFLUWdBc2hENGVYa2szek1nN0tKT1NNc0VF?=
 =?utf-8?Q?RFU6ay1Oz69BbHIotvf/6nz2+r5Ra4/ATmbsPFfJ8+Nb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <272FDA70BD9192458C39C630414AD837@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FD3e2KqZtLxLFZcgjXIpVqHl4raLqRyoOn1Xln7W3uTr2xPFl6WKc7AQcYmMiyQgQ97WI0W0UBjJOXJ/F2PdTiB33OkDSLkHzZMV/pg0jWHswSAKaIgp1b+2JjqqDaPLzeYlVWrwszqK/AunU1Nq3OD4cSe+XV6xI3KVganMFpSb7DygiB7kadtyLk8nbTr29W8jsqn0PKm2jdiHrMB+4eRsfwIehYZNNnu4fBB5Yq0kSZJw6SF923d9BvRlH6fZ7h3yHpa5SGxJmK1ylpH51Mw8bUsKmC6rTj4cacvCqknBWKi7iKCcFb8+9gMYDCbCN7sNPE/9QVGIex9Xc65MI7ix+g/YKm6wBJfESUE7Jr0zjQecoBqf0rGOUDqEORjPJMRl6MW/2U2TSBwfGMxdeSeLeMSTn5HaP5J6WAX2JYpIUpmMye78cCjRBropP4Fc5wU4Sj8IM4LybikB67tBl5/tN75M2Pnbu4a6gmAOivnggeLZFEwm7KwFcD5iv2FafFMsP7y+LawKD8983udcFVbwL0/SkwpIDn0LWcuxDF1FpbfBv3PTs5pYlsW3JvSH+BtddF4/52oWIq0NE//E+Rmmk/pNDv2+5gc7WA+MOJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d77e6a-6cb5-45a5-7357-08dd1a13eb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 18:45:00.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wG7uMQgV6DH7J+ZeKgcYHclybkvtvR9rRHyOeeSixmIl+z2VnNMalHB7bJxZ07T37b/wfzxGKKDuRlO3RaoDE2TZXpUVqQA2IYCd/c2NTAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_11,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=891 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412110134
X-Proofpoint-GUID: 1HP4IMkahYOna-kXHvoRAAn0kQEVP1aQ
X-Proofpoint-ORIG-GUID: 1HP4IMkahYOna-kXHvoRAAn0kQEVP1aQ

Q2PigJllZCB0aGUgcGVvcGxlIGluIHRoZSBjb21taXQgaGVyZS4NCg0KPiBPbiBEZWMgMTAsIDIw
MjQsIGF0IDExOjA44oCvUE0sIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3
cm90ZToNCj4gDQo+IE9uIFR1ZSwgRGVjIDEwLCAyMDI0IGF0IDEwOjI4OjU3UE0gKzAwMDAsIFNh
ZWVkIE1pcnphbW9oYW1tYWRpIHdyb3RlOg0KPj4gSGksDQo+PiANCj4+IENvdWxkIHlvdSBwbGVh
c2UgYXBwbHkgdGhlIGZvbGxvd2luZyBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGZpeCB0aGF0IGlz
IG5vdyBpbiBtYWlubGluZSB0byA2LjEyLnkgc3RhYmxlIGJyYW5jaD8NCj4+IA0KPj4gQ29tbWl0
IERhdGE6DQo+PiAgY29tbWl0LWlkICAgICAgICA6IDU4YTBjODc1Y2UwMjg2NzhjOTU5NGM3YmRm
M2ZlMzM0NjIzOTI4MDgNCj4+ICBzdW1tYXJ5ICAgICAgICAgIDogbnZtZTogZG9uJ3QgYXBwbHkg
TlZNRV9RVUlSS19ERUFMTE9DQVRFX1pFUk9FUyB3aGVuIERTTSBpcyBub3Qgc3VwcG9ydGVkDQo+
PiAgYXV0aG9yICAgICAgICAgICA6IGhjaEBoZXJhLmtlcm5lbC5vcmcNCj4+ICBhdXRob3IgZGF0
ZSAgICAgIDogMjAyNC0xMS0yNyAwNjo0MjoxOA0KPj4gIGNvbW1pdHRlciAgICAgICAgOiBrYnVz
Y2hAa2VybmVsLm9yZw0KPj4gIGNvbW1pdHRlciBkYXRlICAgOiAyMDI0LTEyLTAyIDE4OjAzOjE5
DQo+PiAgc3RhYmxlIHBhdGNoLWlkICA6IDc5NzU3MTBhZWVmZDEyODgzNmI0OThmMGFjNGRlZGJl
NmI0MDY4ZDgNCj4+IA0KPj4gSW4gQnJhbmNoZXM6DQo+PiAga2VybmVsX2RvdF9vcmcvdG9ydmFs
ZHNfbGludXguZ2l0ICBtYXN0ZXIgICAgICAgICAgICAgICAgIC0gNThhMGM4NzVjZTAyDQo+PiAg
a2VybmVsX2RvdF9vcmcvbGludXgtc3RhYmxlLmdpdCAgICBtYXN0ZXIgICAgICAgICAgICAgICAg
IC0gNThhMGM4NzVjZTAyDQo+IA0KPiBBbnkgcmVhc29uIHdoeSB5b3UgZGlkbid0IGFsc28gY2M6
IGFsbCBvZiB0aGUgcGVvcGxlIGludm9sdmVkIGluIHRoaXMNCj4gY29tbWl0Pw0KDQoNCg==

