Return-Path: <stable+bounces-152722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08835ADB3FF
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC8D164860
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49F2BF012;
	Mon, 16 Jun 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5t0zlEE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dU+uDaT/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22901DED70
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084592; cv=fail; b=LE6CsaMGZ5Lk9ZBoGlw0F7sojUx31MMGmytMS6QVKCLQRS8k4edsupnK9dmtshcpFP3eHcRn8ZKQ/UT1okB3jphL4GpM28oBy2uf+M1UNFG1zrRFfMouCbbdQd5sinPnCqq2vhID1e0EsUpW4D9+GuJKWC6ttflZ7SIPRiLxmGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084592; c=relaxed/simple;
	bh=i8iOAYxxXUrSg6UufHgF+AMHcRPNv79yfy3nprNaNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYeNXK3wSCPiLagfiF0DFm3qRi+/evk+WCLvQkw8E0gu1T829DMFuBxw7aGsnKKqlrMbBZgcHX9UxOGTqnedO5Njfif+OZrPMDci5Q7NS2rseES12VoL1jflMXhn2EjaagAg4wVUhMBEWzOdQnMgFM8ktz2OmF7VvV3JXjPpZwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5t0zlEE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dU+uDaT/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7iQiH013141;
	Mon, 16 Jun 2025 14:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A4MjVXiY1bEgmhiQHX
	HbNXXSdJRMjVS5sValM9swX+8=; b=U5t0zlEE6Qfc/UbzPx42mf4SZ1QlWmQwQE
	WNyecZtyHnme17F5BIjKwYgrmpYeGkSLSxO2T440h+4bNbMk8GKPvxLqripZ7FVg
	qS41BuKqTubjMfEplPjyODwZ2FG3+QSKPMk6LJEXup0qa4UzL7q8wmgyhwuq3uGC
	SNRyrtxA1yQk9RjAnxOfhCZcXDt27KQarXF6g+J+Ka0fqQMM6VwwirVX3Ubj6114
	pSj3KeQmDw60LRt8EhGmEnGlcphDQO4PQw98SjMZE1jMORjkbc7hoIbxLfe10kxm
	82mNAwaYWagsFOhiMt3oxpMrLNJtbxjT0FRzf6OdIBfQnF17gZhw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r1twd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 14:36:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GEZUDa036378;
	Mon, 16 Jun 2025 14:36:17 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yheg5rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 14:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnx9i4qeOqwgkvpCfD7m+O3/ItmCaLQXumnsnUToo5LOMG6Xy/Zl+KP4F8PjW4UiQEyowz/PwbhYB2MRqRAzdCUEaDLuBXmBNbTrAlsHWRupQ+w7YYBaWETq7DmK/qsayyn2eJtbdqijwL2Q54K8ZN7OY70kHRtgF8ClaDN1Y+0tdqb39u75vz0xyAn0pBJF7r6Ccjw53UzsrAuWfdkou7b4LVvhoXu0evmonHmsPN6kKpR+A51deU6jbV/huSgzFbATBhwZMwP+finmhyLsOKZ0Z2LxTecf3cdbIk+LE0gZu4D+EkxN0lFEoYArGcKkqkO4BCAHItGEwIp/gKCjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4MjVXiY1bEgmhiQHXHbNXXSdJRMjVS5sValM9swX+8=;
 b=fmn39imQtg1qal+em6HdSelR5ebH63TLKW8lCr58CBQeNhiWRJfK8IemBuVC0/uo8/kj0J2CiYaR3yGe3nINr8ugzVn5O8Q74b22RCSo8PyENzAnax/WybF3bpmyU6ybbHtUSKaQsQec+n6lA61XkgJoc6fU/9hsqUL7Sq74bZr+MUj5VsHu7hwtDAM7hrea/xaVCVSlXRt/7ZfFbSbNB/kZvnMQw8y/0qskC0jnVbMuCDuWwHvVfdw9hDgZl30SyWLxPtve12ucinV3ZI6ZKFPAdQjXoIsa2hkdxHw/Foxi82n0j1TuWGEC8SR1gSTwDZVLpv++YpXdjTK1n0TY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4MjVXiY1bEgmhiQHXHbNXXSdJRMjVS5sValM9swX+8=;
 b=dU+uDaT/hpbfRqROUM0Lm3Cj9nk0ugIP50jnngbP8o7dvDulGISnbUBIIQ5cFJOxYwkUOBzlcZb/arQn2VVabr4LepJuqXLav6Sz+O27urRm7St1UdiA0laaRi5cv7GsZNzhHTveKN3WN2YVlYkC7Ef1cm6Q1SZQ6r4f0YpL1GU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6698.namprd10.prod.outlook.com (2603:10b6:208:442::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 14:36:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 14:36:14 +0000
Date: Mon, 16 Jun 2025 15:36:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jakub Acs <acsjakub@amazon.de>
Cc: stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Acs <acsjakub@amazon.com>, linux-mm@kvack.org
Subject: Re: [PATCH 6.1] Mm/uffd: fix vma operation where start addr cuts
 part of vma
Message-ID: <6b33e781-5eb0-4012-b2de-73ade23643f2@lucifer.local>
References: <20250604123830.61771-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604123830.61771-1-acsjakub@amazon.de>
X-ClientProxiedBy: LO4P123CA0624.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ecef8f-9459-485b-96c9-08ddace3258b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K6B0apL98cNwtrJpwEYmuESxFZFOdmfPrXbrMBa4bYkyqQ43c67+T1LidPV4?=
 =?us-ascii?Q?kU/Ve0nPGt8JApBXtYGAOeGbclygLkGesdNBMFQmu3e3/zH0y3AQXc4xLjBc?=
 =?us-ascii?Q?OubE4wh/R/PsC6XcWiY9QSpd4qAR4LPVsunLUw0QgBSS8pUYsKNyE8ccKFBV?=
 =?us-ascii?Q?IcjhknImg3eQrv3+/WAa9NH6116fTZt+IUEVsDkTSQIjTyfDKJUnZIje3nlQ?=
 =?us-ascii?Q?mmEsAIwjbp0Ouojiyxwfr0ADT5W0o5Fy5dLaapSGM4lp24S6DTmxSzG8Xwuc?=
 =?us-ascii?Q?tTTVDkgzlGPVWhqwzuw/k3DqnhgS/SqXVU8Iu0WUAfch4Bf6WMOq8WxNe702?=
 =?us-ascii?Q?cn3jJrz1qW3N4dRvQtxO4XYV4V4ZENM/znsor4SsTRXitnm/+LWKRnFq0Q3I?=
 =?us-ascii?Q?UMxUzydbytwesl0yisoOQEric61kfPfGCnYUxn3d7UZlJRGueZfPajy8GGHd?=
 =?us-ascii?Q?ms1GoZ/cHs519QLMLso0tLI6smVCbwcwrMcEGeMhBaMdU6yJK9Nyy7cJ/F2P?=
 =?us-ascii?Q?VTqjjl6msMOcUKpSEKAmViF7rshG2K7bjmMIh1Ughwscl8tZXE2yzwEofExb?=
 =?us-ascii?Q?J73QyTreqKoFYJE5mFbzdc7l8e8tGBsYnuS+NZj7nkOUBoMNCVAAoBQLE36s?=
 =?us-ascii?Q?q8AIBDmQq8JXM+Sx16qWXpxGqj3uqgapOFijuSt5nPLhkol8cfy3rf0dVym0?=
 =?us-ascii?Q?5bNtNMMXBhYp0XgF3NQqwW7pqbJlzOGnP1I0JwXCYCflR20V4s3LzS+A/Td8?=
 =?us-ascii?Q?WIX6yVTLqVPPSs40kiuQrxG+QbO5SWqY0hjdoGjFlCfKfOQuVim1oXD5kBai?=
 =?us-ascii?Q?YmxACKDXZEiwDe2YqEzCk/O33uUoaj3snJ28RX7s4PFBDayWowpQjhWLboX4?=
 =?us-ascii?Q?s7HdsGQC4tWaMCYhP570rPazhp5q37kMaU+tsyuHOK0nUBD15b9jBkw+BnJV?=
 =?us-ascii?Q?MVwAv+Uz4OIs1eUeSGxRbCgQICsrH2u3rhIzo0rYcXxjxi41VRGvfG1PSIvT?=
 =?us-ascii?Q?puP86ip4orEkTzky/ArIYmwJOhfnwLk8HHbPg59HDEEJl1RfhkLg53aaAQAz?=
 =?us-ascii?Q?T28ruFpqGxsdWoKLPitRs4V2SeIttXg4Okdfx7+wXPaZkYrZ8fhG9jmnQ3sW?=
 =?us-ascii?Q?eogiKH6kBe5wwGTRykEOOTxoWVbqmkCP7+uk49oDzGwXcPqsY8DIiZU5ddDH?=
 =?us-ascii?Q?XKH51srMzIc5UJCgKmwlq23jBaeWKFSfQpF4y4EQQyfPWnWuxlE4bQTCSCQe?=
 =?us-ascii?Q?QQ+6l7iJRF1rttNM7BqhXGQ9s+E/jzCG07ZrB8BF/JFTvpkgLRUU5fJbhvuS?=
 =?us-ascii?Q?n4ZkvGDYU3DmDiGhiRSUkMLgtPfJnAXdGKmtkm0sCywZfK0/do442+Vt6elX?=
 =?us-ascii?Q?yCmAtFn/PiSzUtgYqfTogI/C2427?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaI7aTUig+UOJ9rFYpgfO8+Eq92wPd930XkqNpgP5AaK7HBnOkRVvZq5GG1y?=
 =?us-ascii?Q?EEWFFDC/rirkHrmtgUCKjxZZm8VEe8ItmhpMNjXJZZl4Bo7l3F1fSieqDkKZ?=
 =?us-ascii?Q?7pB5OswBUqaLjYxFqijgBGBtVKOEkaN8vXligZJ4mtslAkv7ydwsq+b0h3W7?=
 =?us-ascii?Q?e3ZWJBYDfmSRCIkX0zD/KpBW3sAsQAgIBIwLTpXM2Wm6kSBas7nprm/CX444?=
 =?us-ascii?Q?UHPAtcyAOJ0YmS1F8gK0M0pw9RY+U99J/xmCh3Zb97EOed54Li2bScnmW5e8?=
 =?us-ascii?Q?iCEYF6sSW38dY0Y4yqMUYv0BXN1/GVipiN3FNO5wyh2lg1Gy6J1JNk4/FGnp?=
 =?us-ascii?Q?axdYhyXWigP1UhjA6qoyoCg7gkj7jyJwLnUcPKm5cuv7bd86QL4HXIGWU27H?=
 =?us-ascii?Q?jf+XVWOwKjRyzzw4LnnS7Pk4AKBSs/dTpVZXUAA4NxNp5oEdRHJbL50nqbvK?=
 =?us-ascii?Q?a71EiJCx0JTDyr4tJr93Wab8LnKSEEw3LvKcTmXbtSfCsLlLtLEhKs3vcS2v?=
 =?us-ascii?Q?u0WVOlYetaE/3vTMJpSRF7/JyyJZRrMmOqrblBT9/gEOpTV8PIm2mL0/RInG?=
 =?us-ascii?Q?Hp/R68GPA1JJcXlGEBHVVQQz0I3MhZlMjQ8oYcrktByCVa11Z116MN4F3MAG?=
 =?us-ascii?Q?hJSFLjinbt7k1XxObqlk3Vr1+ud+b7GcXdPdz5nGCRC9zdGTa1xVjk7YG1VS?=
 =?us-ascii?Q?aYenwscJb5f+BcLhDGI6oUyK1UdyZsaXeepupmWZlotDJOZSXaud4uHAnb8t?=
 =?us-ascii?Q?tbU9KxTAbCO5rNI0ZK1NbpWWkOkLkJnlZzbap8+0qphUFS12oW5MxZ0qgyx9?=
 =?us-ascii?Q?GuVUls8f/95QIDtTyzmpqGdcXLLNgiGGzVXYArbfVL3Ttdg2TbEnvsElq2dC?=
 =?us-ascii?Q?3oWTr81oNWff385skZXN4oVDqsk9GEWUustMd/yYXyTbmbsr7/E3ElxxDRFA?=
 =?us-ascii?Q?bzDCX2YzYRb7dt90qlxNt06fFj7BzH2LoDHbJgksmKYimYaBKaGzAUz1rRJX?=
 =?us-ascii?Q?QEdI90c0d6OzzRNQmJLD4RIxOSUb/knZnA3TGwEqMo4rKFe9twyD9e251Fyd?=
 =?us-ascii?Q?XXHjr8zciQ+FGc4l8yTIzsbdho7p01iWUAkV1aAp2vn5iZIYOS9CFCscAnnp?=
 =?us-ascii?Q?fxoNPik/PibVBpW3Bhmdn1+g1e+jeFTQeynTEF4k6trnvEVgNx5qtu8orwFO?=
 =?us-ascii?Q?mVDk79GOggsdZbKHjYz9UQEQ6tsX+Hf6dBX5Xva7c+3OIbc0/XaZt2fUj2Bi?=
 =?us-ascii?Q?e3bJXQju9TsBKBSUKRlSShImUAjCEtoRsevfHtc2OdZF533IfsFuHXVu7dh9?=
 =?us-ascii?Q?LzAJ6i4pbRr8zXl8AHn+wQGtMQxXutric3pwYyzvNYX0DY6sYPCX2k9dm8hE?=
 =?us-ascii?Q?ig5LGjK+ZYKz5hvtp4XK7RrM3SQxo6PD9x33KYK5yPxFuDd/EGzLFhfFbtea?=
 =?us-ascii?Q?nkONcku9BMMg+NaZwTtArgchQ+XzQxz4CiPALAyOV6vyAfbcuXji0LGIt9zK?=
 =?us-ascii?Q?H9wzxt7w3mYm6v+DsuZefu7TGnNWLHKXcKspnowdICiKuvMTWelQ/3bNo8LK?=
 =?us-ascii?Q?HSuzFRW4YOoHFghWji6Jk0CkMrwU0XODEN1w/YERGy0p3cy58rJ289+atSrh?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ckH/eD60eQMyAJOu66gmCk7V6aRmVFRO8cOM/OBnX7qC4G0Fg+mD4DCTr9UkMM7+iecwp5un6t6bEFrL1fVgEAujEf/TcvsYGLSF3At2X9qPG1Gvnt+8zZF/z3fASZbzizoxOWxwbaCfYCshH/btvIrL5RS6me5lz7nFv39l5Y5IjyXUMAGZVtTfmGW6J6AAkI2xHqeCVDI9HQOwXIWbk3KnEhYD6UOl6WIRvbBAaCWskOWz4RgE/1gHvh/EfVr9Dv4RJPGKnwc2rS48HSCuETqHX3KpU4eICe1n+1cviqpGC26p35Ey3QrOA3r0vV98vYilYHKWPzXIWBYdlEHILd4eFadOour/bcdjHiSyMTv3B2KJWOXEQxYaoFazizhidRcnfb3SXGl9Ajhqhg/wejvHD8QsdsAkqGW4TKrr7Y3K6GBFESXxPbRtgtO/ADJTdeBsDtrU/F3nB7lFh+jx6edI81DwoLEa2sSfj0ws+rCD5k4rGd2L4r1LoJT6VIOartOJrH2Gm3TsHDzM0eYBZuiksoIABQLdDmFUdM19WMehi42wpDvsSM3PffV0gl3SQvF/ifulWEUQA+2NQdnkEgazDlMOaFuF5Uo2Js8aAw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ecef8f-9459-485b-96c9-08ddace3258b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:36:14.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk7l2wn/3/MohWdJRhSlWB/N+epeIHEfu02i4my19QiPPsKDi3td058LKX5D5qPnDehIyHeGC1xHVcJdBoJ4qw7iQGticut8kpunFw8IzsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA5MiBTYWx0ZWRfX8hyaMbiCE80S Ma1FyZlTDkabU1Q6GYIFDNQaofFWXwo1CYWIRlzxp5uzhUOpVIbcRoJe3gHD4G2VirUyoPWbesP mQ71hmziHKcuCbIfCiEDu9sSYRlqTmQbOfgDB94AF6r7X19nDcnrYV3RovAOAItVuuPXVsLew85
 KxQ+5MzhRPB+dSvoPy1G4GYXPkawE8SUPlpoWqUwgbP3TqTrlwpOSv0L/7UQrS9svJP5Ps5gwjy sOTyUzV7GYV7KL0+6LhZ+aeBkjsFcWQAw7tctMSrVVuz+e9cKgOgQB0b4LsPTReqrraNwHlNRCo ddFU16ziG0NiWL2pxRHUJdB3yv0F57USovzfOdRWuhCSKFG7Ql9AXXyfcJ7wvjDu7GNKvWcrXpn
 YfJexxp1dVuMZXmspNxSOTbqaB/Iga7BRyA2h+xdtWqsG+c2NZXKaS31JhBRRrfdYwiVHo+l
X-Proofpoint-GUID: wmFRkChwExnqVdqFwzOU7xGYpDDLjT8_
X-Proofpoint-ORIG-GUID: wmFRkChwExnqVdqFwzOU7xGYpDDLjT8_
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=68502be1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Z4Rwk6OoAAAA:8 a=vggBfdFIAAAA:8
 a=37rDS-QxAAAA:8 a=WMWJyflKrnLjP3s272sA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22 a=k1Nq6YrhK2t884LQW06G:22 cc=ntf awl=host:14714

-cc my personal mail

Hi Jakub,

I realise this is from an old report so totally forgivable :P but please
use my work mail, everything that goes to my personal mail from the mailing
lists is >/dev/null :)

I only noticed this because I was checking for something else ;)

The patch looks fine to me btw!

Cheers, Lorenzo

On Wed, Jun 04, 2025 at 12:38:30PM +0000, Jakub Acs wrote:
> commit 270aa010620697fb27b8f892cc4e194bc2b7d134 upstream.
>
> Patch series "mm/uffd: Fix vma merge/split", v2.
>
> This series contains two patches that fix vma merge/split for userfaultfd
> on two separate issues.
>
> Patch 1 fixes a regression since 6.1+ due to something we overlooked when
> converting to maple tree apis.  The plan is we use patch 1 to replace the
> commit "2f628010799e (mm: userfaultfd: avoid passing an invalid range to
> vma_merge())" in mm-hostfixes-unstable tree if possible, so as to bring
> uffd vma operations back aligned with the rest code again.
>
> Patch 2 fixes a long standing issue that vma can be left unmerged even if
> we can for either uffd register or unregister.
>
> Many thanks to Lorenzo on either noticing this issue from the assert
> movement patch, looking at this problem, and also provided a reproducer on
> the unmerged vma issue [1].
>
> [1] https://gist.github.com/lorenzo-stoakes/a11a10f5f479e7a977fc456331266e0e
>
> This patch (of 2):
>
> It seems vma merging with uffd paths is broken with either
> register/unregister, where right now we can feed wrong parameters to
> vma_merge() and it's found by recent patch which moved asserts upwards in
> vma_merge() by Lorenzo Stoakes:
>
> https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
>
> It's possible that "start" is contained within vma but not clamped to its
> start.  We need to convert this into either "cannot merge" case or "can
> merge" case 4 which permits subdivision of prev by assigning vma to prev.
> As we loop, each subsequent VMA will be clamped to the start.
>
> This patch will eliminate the report and make sure vma_merge() calls will
> become legal again.
>
> One thing to mention is that the "Fixes: 29417d292bd0" below is there only
> to help explain where the warning can start to trigger, the real commit to
> fix should be 69dbe6daf104.  Commit 29417d292bd0 helps us to identify the
> issue, but unfortunately we may want to keep it in Fixes too just to ease
> kernel backporters for easier tracking.
>
> Link: https://lkml.kernel.org/r/20230517190916.3429499-1-peterx@redhat.com
> Link: https://lkml.kernel.org/r/20230517190916.3429499-2-peterx@redhat.com
> Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Closes: https://lore.kernel.org/all/ZFunF7DmMdK05MoF@FVFF77S0Q05N.cambridge.arm.com/
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jakub Acs <acsjakub@amazon.com>
> [acsjakub: contextual change - keep call to mas_next()]
> Cc: linux-mm@kvack.org
>
> ---
> This backport fixes a security issue - dangling pointer to a VMA in maple
> tree. Omitting details in this message to be brief, but happy to provide
> if requested.
>
> Since the envelope mentions series fixes 2 separate issues I hope the patch
> is acceptable on its own?
>
>
>  fs/userfaultfd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 82101a2cf933..fcf96f52b2e9 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1426,6 +1426,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	if (prev != vma)
>  		mas_next(&mas, ULONG_MAX);
>
> +	if (vma->vm_start < start)
> +		prev = vma;
> +
>  	ret = 0;
>  	do {
>  		cond_resched();
> @@ -1603,6 +1606,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	if (prev != vma)
>  		mas_next(&mas, ULONG_MAX);
>
> +	if (vma->vm_start < start)
> +		prev = vma;
> +
>  	ret = 0;
>  	do {
>  		cond_resched();
> --
> 2.47.1
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>

