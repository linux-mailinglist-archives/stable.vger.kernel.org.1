Return-Path: <stable+bounces-93535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 743529CDE7B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87CDB26817
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D901BD00C;
	Fri, 15 Nov 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cVVyG5v0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TumDi+h1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6271BCA0A;
	Fri, 15 Nov 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674553; cv=fail; b=dR4WeBoJYw6GCQnCCf5PDMfqaml7qB/Kc/phssaYta/CbKKuKkVIPlagdNIqI4wtnc1bvvnd/Cj87PkuKofnLfh4kOYdx+ZJlENO7NN5URg3E9XTg8fg/K/+aXwtUuFVvhxegrEtZXagxkQJRWYTAzgglsLLkL+/Tgqgg10zaqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674553; c=relaxed/simple;
	bh=oRkang9dK7aFEYbjyqK93kVrmfU9W5dKd4grjVRuW3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UjGulkbv5Nr/AumqaaRxCrp6+R6pmSjpFhELFQFaxuoUzP7LJiOysjngiX39Kvu5T7FKoymDzSZ3j9L5C1cnYlKw3MOWcO+B1ctsXbhGoq/q3RG+zCbadZSegV/qL+L65lzd6XdR6JduuSlwoEHdZZCBICOGnLfjjTRAwbS/voI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cVVyG5v0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TumDi+h1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHHMs000667;
	Fri, 15 Nov 2024 12:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/TY0TOZyddbmZHX6YK8ZiEM3V6psrC36jd9wYlgChpU=; b=
	cVVyG5v0gJ2EY7YwZ8dW/C8G3C2B4pDPBl4Ex7KiNZF/0fptAAtS90yX+mViy1ve
	4HpYk/tC7BirNYFvtRj+1H1cxWwy2yqs1NJ0V4iXuGkuQl7+kkOmIFMZR4SnnRPg
	VyqE3HcvNg9SF+TzChuar7PTqEmQcrpXRupgFS0rWvFMHpaVOqtgKESkaWrykTaa
	T4sdxcRjglRWDkQxhVnpzurM1ArvY1c8up3e7ZbmZGN2LjbfP1z7/+AKJYk4DWO5
	+WBwpo9JNhAF2PxGHAAhr1dVNCXjf5ofvj/pQsBVvy6pMbczdipndu40vh0CQSqp
	YUP/lbFJCAsOHtqQvl/1gw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkddp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCMWdZ035940;
	Fri, 15 Nov 2024 12:42:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c5604-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU9dnhzkLRD6B9BnF++wNik/dfdD942l/nES/eMjUNSPp/4OEAiD92yLvfkAcyylzEAX6Qvvsooz4Ep7vesuAIWOKw6hRq+cmOxaVvMWjb//ztcgowFVaKreNdCSG6mXo+FKAGihnMcJ+BBnmntyjWOax1Uf8RITIdR5Urlcb3sdD3vYkJkm530jGHtPJN00lzXpNe5I389NheKGD0XWniVJQ2FyY/CeFUTfn3FOISX2aDhCBD/2ea4FIl+QoVqIbcz6MxFpVF9eg47xYfXM2C9FiOjpLmhRIwpZ9uGV7ciSdfG+DBzpJVmUf3OGUesaqUVbTVVy9D7jAYTqi/DwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TY0TOZyddbmZHX6YK8ZiEM3V6psrC36jd9wYlgChpU=;
 b=wHQJqnuU8P2OFHSF6ucbO9jH12EUKEzFlQyQqur73cL36yHkvCUXNRi8MAfYh7nRiSZH2dD5tfSKQ+rwCg+R2f+uLwyi6j/e55qPeRdojD8ad2psQoYjkoYNJQktrXGIdTYmI5wYNkl1kGLN4m/A75bzrbTsoXCdXLHPjo5ISG7iGiVXj2AQsEwIn1syeti0zdeX4jej/aBNpVU9QOAjkBVOaanTUR/jOWYc9ChBJBC5sMojDnuTLmOcWAj9riaGDcKE//CTXJAMONpogz//RwPlNl/sjZnpMmvg7lj3UQPWWKys8j75analewwLeLYJTsOXj6PHC7J7zaRCsRda3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TY0TOZyddbmZHX6YK8ZiEM3V6psrC36jd9wYlgChpU=;
 b=TumDi+h1C+woNv+vL9/JQI0UN0feHiQbeGJ6uqVClfrO/pgEtsWvCUpp5ydOqptluo6NTRl92E/Ggtw0YHmdI6FN+tpnrtO4qQGNAXDSgSVlc0leAQJXfrhFkKfOBtkqnQ5jpxbEo8Id4XVTl+lkTumDbEaKFPtxeNt7ECKlLb4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:42:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:42:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6.y 1/5] mm: avoid unsafe VMA hook invocation when error arises on mmap hook
Date: Fri, 15 Nov 2024 12:41:54 +0000
Message-ID: <33d70849ec62ba738ca2f8db58fe24076d5282bf.1731672733.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
References: <cover.1731672733.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: b28debd0-1fbc-490f-792c-08dd0572e936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XFXe3JsgzZgD4+thwQzsEC2wYrz1v7LQCok38oisZGZ3KQyn640IX76Ddyha?=
 =?us-ascii?Q?2iLZc6i2Ievjz2sxD5VftvvIeH9sgU12FR+jcGqIv0/NolFca4nGOAJ4vmGs?=
 =?us-ascii?Q?P5R2ua5A5CklgfVmgXm/tc6K9Zv1B6QVNFglgyYZXwN0ovI0K4DwBGbSgBIe?=
 =?us-ascii?Q?IDNDz4yxfgxLB+bNaHeiHn1wyleHsANo5wCwxOesh0FLHhp1glzXqfDI0WR3?=
 =?us-ascii?Q?q/H26DKvJs5FySqCw3FyQABJRMgDbghHaeV+Ui4pTgfD17YXBq6XdnSTm5T1?=
 =?us-ascii?Q?9U6A9J7KLm0fIok2E/ItI8KdEhdMrtTjnGCgHsBFjPrwDWPAwOqitu6KLJRZ?=
 =?us-ascii?Q?8W73kNVsfNRxsh5I1f/x8g27OyotAJSqckzmZ1muCvs5R+afSPcZMzN5piiG?=
 =?us-ascii?Q?LRdKEO+dm/goun6af5tPjtVLCLK1R45BWyp/LS7sqtA7B9UYOxD/J1cPD8gU?=
 =?us-ascii?Q?DQw7PrIm2mHn2XfrbjoZgLzLLde2THfgkSqAyxat5j7cR+QXwYWSUlMTwDzE?=
 =?us-ascii?Q?y7V9uxn8JqftqY8ROw4rnm+Y4xd2Qw4iuwXc3A8RJvZXUJT67682NdAhznU7?=
 =?us-ascii?Q?X5LLxkUeegBIDzUhAwrLFLP8uzdqwImveMwAtr0IAgch6ES3WwIW6/jlttvo?=
 =?us-ascii?Q?Q5Pe3mzJuX3eFog5Kh8BsHcIX+oUmMo7CHEjrFOJmCdVZJel4hIXU4dzqRqc?=
 =?us-ascii?Q?+mrJ5Uvz0zOhE/q/sBeLWv5Q/FRLF6lP15nZxXynW1dcymAK5AcyT52SqlUK?=
 =?us-ascii?Q?9UMr+1Wbet+JHUcf0EtjJJxGdvRBzd2f/AHaWzXCDCQzJ00rcLppp1Zf/1G6?=
 =?us-ascii?Q?VvcIdotPGE4M5KC8u/5GB74tTw9VJjbJZK08JsjDJIaXPboP0pat3Q1Xc/ld?=
 =?us-ascii?Q?xYJczbzuuxl3qJTdsGbjIOJMs5hlIy58qHqFqDuS9ek9xLIPgvjcuPKO9cZN?=
 =?us-ascii?Q?rrYWYIJ5OEUAACXQpxfxdrrwnd2pjV32dKFU2Z2GdtiJlHYH1mIz2aU+vIwD?=
 =?us-ascii?Q?1BMX26IFe3gIcOa139wTJTA/gd5BfBs1cWuBesuOzK1HQb0Iv/pXBhUBbAHW?=
 =?us-ascii?Q?vWf9dhaV2sSJqqjMOv+A9bCD5GWITYoKgssKCmoRpVCLiX7Fcm/uIWkl+p6s?=
 =?us-ascii?Q?jknLJCpTWVb17Vznpq6MpwQ+cY5jSYzUN7pp900imkvp2qdtaIBJ+9mYA/7f?=
 =?us-ascii?Q?3UbWbYJfCaml21qLPBP0uZ7pBEtZ4uAtn8UJpw6I3SxW15HVd9udd+uxM/S9?=
 =?us-ascii?Q?+SfPfk98ah1Qsw+o73VaqtUHGFk2+ajZT7N/xm7tfAa2yzdpbhEy8rcvqEHW?=
 =?us-ascii?Q?A1a/WOMCAd90eSk+nKwh9rGd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80QkjYeOOxA760FRSMeRgU/Dqi7pwF+uMjHoWJj0u9gpL8cwC15MKTV1VOFg?=
 =?us-ascii?Q?P3OImneZ2+8GktotP3R9hn8yU7DywpguTBBsHMl9fJk8I1UDb9z+YuCZnNZx?=
 =?us-ascii?Q?slTByRIwjOKRZtbDB2ZckXw1a/Tvhw0oKGx7KhkzZreAu6vRjdjvuQuZQGyN?=
 =?us-ascii?Q?hwfobWTJnQai2sN9Z8IaG/DQVmq789LXopY6g76kHrfcv/IePCth56oqlzsW?=
 =?us-ascii?Q?sHHh7sfbOTM2mqVkKWgHquGxT8ZRf6HiDxoe7RE+5yiXXuw1oNBlX8c984+J?=
 =?us-ascii?Q?J1BHtMe4nwdMz413dkTCpvB9BbWeHXeEdBZf9CoIB08Qf3c7qM2sgzvYACf1?=
 =?us-ascii?Q?uObC+dmvHoN1iLj41qRN47nwSxFYY54CC0q0hDLmaerak8NPHm7j5hnLXEac?=
 =?us-ascii?Q?keD21ejPgh7EV/MoN2v3qhR+RVheO8iY8jF+EtAGBYTt1GPx7okJgiPtx1bD?=
 =?us-ascii?Q?hjJD9Clb/MmUcZCsmZ4j2GrteAEELGg7dgWg8uUa8AOrz6614p1hJVfxpqsl?=
 =?us-ascii?Q?unvoea+RV3H+5rNhQkolU4t7IiP/xdDPr7ZjXK+SoFXNADpMH0+iXXvNmdLT?=
 =?us-ascii?Q?AXXmjqZH2LY4QYDJEDC5YqioGrUQi1MbY7LYqmriDpL+3zGAwiHrN6Uqua/M?=
 =?us-ascii?Q?/YND7vFMbYlB1fEMUV+4D/2kPUoyFFH/rjN0bCR5+V817/qMdgEGBuaNEIvk?=
 =?us-ascii?Q?4Tss2sptQN/tsHA2lzEFmBIhS+9DRA+OdDU9ism1LBp5WglB/gBehbae7Oxr?=
 =?us-ascii?Q?yySvEZew0mmyMR0u+mbVP/sJ3u5YZtCi0ck665C5lNhbKFFZfH5NVq2sOlQc?=
 =?us-ascii?Q?ue1U91y0CgyrNv2C+bVl1nIx8bZPzmKtjkDTBT1LTrZltUErSSsnTqgcsuQX?=
 =?us-ascii?Q?eLSPHwQSjlxDVtoMmTK291Nq/zbrMgj7VmCcr41SQbWV6NO3+TKZChx4CsBz?=
 =?us-ascii?Q?8y1LgDAtvngD5MS9o5D99C0uzv+853W3C1DZigJAZ/cB2FsV/9iVpRbkWNY5?=
 =?us-ascii?Q?rzwzUUs0kb8zYhOM1rMqox6W+PZ7YlwMj/+sds8bVblsYMECIlyMEt8pvNHX?=
 =?us-ascii?Q?6smIt2aKKwye3bf5XsPdZQf5Pt0LU1um4EJ6VTw2k4NID0Z5zc8io3NTq4Fg?=
 =?us-ascii?Q?9G/N+MsqH2Q0zzJF2+ERxXvy9rO3hFDOA5WyW+qTr1ibX4Vgj5OTfpSixH1n?=
 =?us-ascii?Q?g1T9rNPUdhAU38dcW3loZcfcJqx/rlFLn8jWuerwDKo1rKe7ceWcDXQ7z0Qv?=
 =?us-ascii?Q?gwWWc6k/erN26NVNbU0bAR8IzZ1Jvy8sQz2gRdnDMc9KF2ikuuu4I0mNt67B?=
 =?us-ascii?Q?43UDcuF9knvhv1+btqsm4ua53SrLh+n4ocnleX/LcnRFRwHXh3qtatt/IpyD?=
 =?us-ascii?Q?HlfDuoleVaLajUY5FBRnfIUD109NpVsYSOMpqH9TKMbbg/QRhh0KHebTkpMh?=
 =?us-ascii?Q?lskIEaFeX4pSzqUpXDRNmuxYfrEcyXMrayDzRNn7jJ/t+zca8Cbd/HtCLiTw?=
 =?us-ascii?Q?99TdWwWLfmUtURUqUE9XEpjzUwW3ggf7fsOO/++ZCYnfAbZ1u1cJmGF0Eikf?=
 =?us-ascii?Q?rMv5tFAI44fFKuMWndd88WtYUwALZ86vCvqcE0C25qxx3eZSztH2VGqXcMdY?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cLtvnuqUb3MnFHXmWFwtftKyn/LavRmj6+h6883pIC+qCqxmOibmNV4QBvRPkOqENqk65kntgwh8FY7pPx2uWUr9SQAIeO3HkSXDWflOAqYNp2L8vxqGTevyaYDulj4DC0ykPYbQpsEegKwiO2Cywxbn71hbLH1DgdOt/R+S7yuPHIncxoY25bT8i4h4TbB14jQG+jj2eJF/iVXCcU+DrhCXjqMIRfKOzevrLf0nVyaqzgLsLPCPDTEVx/XQ/lvDgnrdrj7PnPu+NhYI0LYiECJL0R0mxqdwU+fIAqD6QGA+CCc14Uag3WBoz+lLbLny9sKQ2F4hgExAYltihS6tQrxIAR9T+kp4f47+B5YJFYAbOymm/0Qx8tA2hpOW5ppU4raCXQ5FYKHt5SBD7nlH106VfH0/HE7ILG1kb7C6PGZCyqHJ8CdG8V0oZkIYvxSPotX3dPPU4DnFjrUALvO3J6TtavoHAAnswMTyL4xGnOnVCr9OmkM3qj2FPdgRzpB+ob9fVQZip5TkB8R6xg4qZnfnbRGVImauNhHTRKDLRvWfjBGU753F0Y47R3GbUe/c+22YN3iV4GeR4QO7ygedBRKlWap1I7262zsyz4REekQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28debd0-1fbc-490f-792c-08dd0572e936
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:42:05.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdHPzNCMvp5/xseSJGdYYjDRwD1QpIFPBRv29GoOPFDbXeWxVVwW/v0k2EV21JrSkV6xkgW2zKSpCbQv3if+dQegrXhQcOTDQmLLOTlu6fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-GUID: wb0EMk5x6GuXQj52zmaE5p0uDruBuhAi
X-Proofpoint-ORIG-GUID: wb0EMk5x6GuXQj52zmaE5p0uDruBuhAi

[ Upstream commit 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf ]

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.

This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
    function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
                            -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h | 27 +++++++++++++++++++++++++++
 mm/mmap.c     |  4 ++--
 mm/nommu.c    |  4 ++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ef8d787a510c..d52d6b57dafb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,33 @@ static inline void *folio_raw_mapping(struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &vma_dummy_vm_ops;
+
+	return err;
+}
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/mmap.c b/mm/mmap.c
index 6530e9cac458..8a055bae6bdb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2779,7 +2779,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		}
 
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -2793,7 +2793,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_config(&vmi, addr, end);
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0e12..e976c62264c9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -896,7 +896,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -929,7 +929,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * happy.
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		/* shouldn't return success if we're not sharing */
 		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
 			ret = -ENOSYS;
-- 
2.47.0


