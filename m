Return-Path: <stable+bounces-194446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE8C4C071
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 08:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0505034AF95
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6854E347FED;
	Tue, 11 Nov 2025 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eLSESddy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WW8skCY6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7D313E15
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845146; cv=fail; b=LsaN9QDl/0d6kyRQCdPhtoQTKq81p9A4axsA5OWDehTzmN7Vqaaai58w6Fsn/nQEJSFGMXBW1jcqr0am+J3G9+ETouixiqJE9obku/rR7irE8lmmFcu3yi61Jry48IILzJBNxrGIiLlMyXPm4fkybbdGMJgGBiH43emiUhNvq9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845146; c=relaxed/simple;
	bh=drOz9SJmC3xmR79cPE8KCjBAC6UImchDJNB3Yg4fKcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7fudd1xf1L3m+lCe7vfxVPfy/v8JJnWm2MeTwNVV09fV57zgdPrNYdYKXyVCcB3MP9ExkqdynQ09H3aKaVW8dYxqX+yyo1txwJrvLc/Qv9eoaTssre+q9k6o2HfrQVU3Du7p0WcIymndJQnWK5zyJp1/XTqOZ8LngVQsqqdfHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eLSESddy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WW8skCY6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5uBhf021696;
	Tue, 11 Nov 2025 07:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rAYFO+8O1bAZnDjmO3c3zoN/KSkO55tuXlTLljGAnm0=; b=
	eLSESddyvDm90v8+lVH/RBXUwHh32tA7WRcql47ptos24Gh9LeY/HKojPixtuymV
	EeF5ePr95kpVl3WpeU7TESv+kmf3YCP2e4R6xnTXlAKSH7zFEV7zIPQlaU3RSRX1
	Wn6CfMmjcfqJtWeDNK+oSmQ3G68WSNBOxyVzNs42kOXHIoV2h6PfBoHXbLPg0M+t
	S0efnLbCf/jGVUCBc1+Sn+88rqd8GfNe6kc+SL2EBoM12XHGBYB0XDGp7YztU3gl
	TMNqP6SsvefH6++2uLX8DOLHbvn9zN2mo13nT2vDyJzN27UNda1KgJIiGlw161cD
	ws5dmtQhyLiW5aiDmzzMwA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abxhqg6uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:11:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6ICmF009925;
	Tue, 11 Nov 2025 07:11:39 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vajx2x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 07:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soL3G7W9sE/ZMSGFDpcE/d/xAGRat8pdsAapPiPAVh3Zdnco5ZgDwgCXGueyMJBjlduHDUFbkHJpqsn/ABEw5ALd9hbes7gNkI3vHPGuzf5e2BE+JsnslygFBUAMCfzu3ZFvYz8PbQxU+oxrtR12OVv6Fy5z9fjJxo9pFml71Kjd1R+UyR2qZBdAGkujRXRqBC5jRc8L6YAJHEJwg7Sqb33i934GXdqtRoZ//4uGStv463+GvvCgOEJTSQOMffiCOwO5XGnSC4jQSS4OZW7uOKHYNtdzuEiF0CpoKgWDtAEbXimc0O1JfZasaupGzsf2IsXYfB8pZNISpRj7/IjI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAYFO+8O1bAZnDjmO3c3zoN/KSkO55tuXlTLljGAnm0=;
 b=nFi18uIMy4t9sL0UHF+GJwBt64cHQyuX/h/IlIGqK8P6POhj1xXheSvgXS4Z/PMQRjJhgw43XPyjLSPihC27G6QvzM6sFpimdjYoHSn9OnilV/6jHiwsBVyclcVr9zpDWLKOc/8NUirsUyal/HHQG2SpchkhzVDW+nZQAr8MzWPX3fhYYb16P/4fhMttlFNK34jNheUmt7FOO1zBgP6/vTmh7DFpqg/S8h6XNKd63vQ5M7wgEpkHY38UbEGHQX45wHmbAOT/PTSEp/+XQExW505Os7+8pbJz7ssBw6JNBgi+wpFiCzJmvOyNEisbJJ9WoEkVQte0jQEGOG/fMjz1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAYFO+8O1bAZnDjmO3c3zoN/KSkO55tuXlTLljGAnm0=;
 b=WW8skCY6vohhKXdw2l0ZgnVtcmVW0i+36c0QCZ1D3l4cIyEvF8iSuT4skFt6R01sQA6hnCv+eAWZId3BYOxL98JUvgoqXEha8OYPHJb6rcLRP1E4YRDEDA+6kOkQuUVGEpSVWIXFhdQMiHcujvmBSM0Pj8ZliI3rNzuZ/zTZagc=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SA1PR10MB5685.namprd10.prod.outlook.com (2603:10b6:806:23d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 07:11:34 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 07:11:34 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@redhat.com, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 6.1.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Tue, 11 Nov 2025 16:11:00 +0900
Message-ID: <20251111071101.680906-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111071101.680906-1-harry.yoo@oracle.com>
References: <20251111071101.680906-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:100:55::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SA1PR10MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f60b0ab-f157-43ee-15b4-08de20f180fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9DcDooJMGatpCrLl37mLgUpHwl9vN0Df6tEMoYDGeATQ7Tl5KQDOO/qPu2K4?=
 =?us-ascii?Q?N+9REgzYYEaq6CK4NZrThO8TiW7h5s8Y3TeSRGEg9gCEQ7q5/r0kP+jQ8JC1?=
 =?us-ascii?Q?zRz356Wk+wB4DGDvSnUnPWAfpdw7Awg2T4gLbgdoC29GvGsYSgyiBShvOxNk?=
 =?us-ascii?Q?vffM8Xn+Si30ZV6qBR9i2pFykxu/LBGaGE991+Y2JSLSjqB4rPBqMzEu0PPO?=
 =?us-ascii?Q?axLnYdLz7u9dsFxFqrhP8HZT8+qiH5cAAf5XnxB+bkKMwKVeUKfshowvKoNm?=
 =?us-ascii?Q?bhLvoRH+vfbBRsUzAWCiZC5r4nINZc2qHkGCpvHCQ7TUndJrXlmMXVRk99hX?=
 =?us-ascii?Q?iT8coeN8hhcL4KeUQJVa8QJFcHLCnmFo/uqDWQAkHDfhA0DlwnKM38QWeeWq?=
 =?us-ascii?Q?/qKgv/B4dOVUBfV9bBvHrQmqdysLN4It2oEUjlJRBQOu8oIfrHkPZ8H5SXlT?=
 =?us-ascii?Q?4Z+UClsPJInt0vLo7dJ4xSWh+kEqrxUafs6wlA+a146iEGvTjEkivI55sVz4?=
 =?us-ascii?Q?tQYm1TYzZeMr7e5bDhpOW/UJrb8xYoVoddl7cuQQQJqw8IxZKmYreXOsp6eZ?=
 =?us-ascii?Q?qVGHgxD846lXnAFlvvOitkO3Ahf3RPsNZWTU4JlK3WYYCe8kLj+nEcVRdAkY?=
 =?us-ascii?Q?cb8izuEk50dt6rlBtK/6kPvoShGI8xGJS0xAen5MgKjjhXQeofgJrsmsL68d?=
 =?us-ascii?Q?6xK66bMeMi6bxKLKU/RFEKOMdSFkpUUWZgyqrnoeXE4/uHzwzffUdKJR56dW?=
 =?us-ascii?Q?T37zWwTrdrMqnM94gW5/z05WxYhMY7aq2E/xd98zFoo3O9uBwEJaaBOCHV/K?=
 =?us-ascii?Q?HPitWkfRDAX+E/yo2gupvDxqunHWMFzhZKRQ2nPSRXpQ3Xl+CO6YGbPSIak0?=
 =?us-ascii?Q?85iSTUc4AfqHKvc/EFRjd3qrAyKB/ZgpiNp0s6fjH44EGNw/tCglacukTeOB?=
 =?us-ascii?Q?31y9UW9nEOSn5VA9nllYgDZI6qbXbeztC6RvMdcWpXgGt2AZNcO+fs7uyDg4?=
 =?us-ascii?Q?Tq1z0RG/raM9xDE0Cod5u8iEZgq+hRDa4+u5Ly2RNvA7oUKgVQ+P6E3BOre6?=
 =?us-ascii?Q?WNBYcZ4eHtZCyFYdtRROvvmYwvEHyf5UgWPaVnMmX/i431+hUsW3oUGuGTHG?=
 =?us-ascii?Q?SLFntqCSc5NWLRAyC0e/hzR7Cyshy4gZip9+rDfWJypH7H63Vr1xbsV8iAoU?=
 =?us-ascii?Q?2OyanpGtMvgcIlMfPTgy/nIJTABq2DMymDSYbpncKO2mTL7PQ+Ly6XQcRK1/?=
 =?us-ascii?Q?Ic/Zhop/WGDqwwjVrEJdy8g3kQ3j7D6Dyyv6933LgMmYt0aWa4bWuHgVRNso?=
 =?us-ascii?Q?cD2xd5uekfacwsx9JKGlJXq41EeBoH+gtUgUOn/g95oA5mgjmTG3ScryYZH2?=
 =?us-ascii?Q?EUEQ2d0f7hIgu/A+1f7QMXPZvhlpktuRQ51XuIX7aFI+xWj9q7/RNkwUrpVn?=
 =?us-ascii?Q?BgqkqYxOdJYGPDARhqb6VbFRlNbaHTzZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ec2if1UXIOu0aDkM1fqQaJuL0VbqWBykpI82OgWfVzWzJTr+uY+WyNH0cY2w?=
 =?us-ascii?Q?TC//UWoqxfBDZ19yq2yVFZ4rl2Z9ceXfR0etoh4mm+VzZxxPnjO3pTY7JkBJ?=
 =?us-ascii?Q?C7fJlVJFgdw4iJiEUZBCzDtu6PmsoTe92b6I9cTjsQ2CFnYpMKVuql5eZmqj?=
 =?us-ascii?Q?sGxJZlhB0LkzQZgQAgJebJ7kM7EMZnZyjN7e/wyUqOPR6Dj74mPZPSzpZ2gO?=
 =?us-ascii?Q?K+2ZHZYHC2Yho5NjoetmGJxiGV9fhvYahuGdY+hZZsicqqplhZTnFtLlzOE1?=
 =?us-ascii?Q?ROtcGX6BOPupEGNy7xv27T24vNYr0zwczPikLj/Wmzsq/AaTfrGtU/uJfxAt?=
 =?us-ascii?Q?YHOfDJSCnfG2lT5IeEQ6CMEsaWoIxdGq//xoxEih+oOF80Q6BCC1zpcp1wbs?=
 =?us-ascii?Q?BoGDy1V22abAjClOV50ndsmcGM5jmDUZjot52/K4kTVZ9xZ4U59ZbE3z0q5z?=
 =?us-ascii?Q?ISfhnl+99Ri6Fmg9NFf0ZFlUEtypI5S8EzJQ33qjiqBIxCMKTVhoSvqGE8iQ?=
 =?us-ascii?Q?f398yAuNvgPfkvT54I4O9/P1vSG1O2R6bL5qlyVnagbmCHyyVDvtWkcGqolT?=
 =?us-ascii?Q?enM5BqwnSFdMgpY64BpWxN16K0/NXChOLzCf0TYcfwNcxo82MI0AiILFS9v1?=
 =?us-ascii?Q?/qj2dWGKfyGvpy5GxED+zGtpwjYnhv9GmKdNT0ajulic4DDyztN+77lw8wmN?=
 =?us-ascii?Q?q7Tz4cVRsUyPLPqoZNo8R2MX8WR2+3TC+2NxJxGP5SEl0J/knh9v7/qVToo7?=
 =?us-ascii?Q?wD+K2VDSA9H1kFZI0NJS/k1TFqBnriMr00H6p5GvSpDFH1m9aVFAnTd2rg9J?=
 =?us-ascii?Q?JrbcSo/17qlRCfeyiZ59Wb+Tdt8iVbzAoWjNpbITD+8iKEvkeyTcxHM1Wi94?=
 =?us-ascii?Q?B9jvFQZW/KoYjkRrJq4SNon3+pUJd1XP08zFd6k58nJdObY3cWHwPTGMUwt+?=
 =?us-ascii?Q?G1ekrk3OfnPYormpxyRwYSyUUFYrWglilMUILWTUFUJQb3V9dt9PL4ZYya02?=
 =?us-ascii?Q?CYz4HQtY1uBU8lIAnG7qJotux0fd+c0dDcSmYwaDhJOEmxso9TyyjffmtAHg?=
 =?us-ascii?Q?85byFUtobfDuGEKkHCsJ2R/QVxbGWm+RNMipTni3+ZX/j6QA1TGNiyN7x6Z3?=
 =?us-ascii?Q?sSFj6x2iVHmXibuaDpZKj+yYc6JjnGeLYcR75Z4O+/UQQvTgtqaYXcknVqdB?=
 =?us-ascii?Q?JQJcBtb8hnKOVArgja/U/7h28XAg0R5A6NRNNveZ/GpyA4fKItwrJOsl/iJg?=
 =?us-ascii?Q?QLZBgn6oD/gz2OjkR2h3IQjeYfkh99o+KpFeitIubTyb7nz0kLvWD9laGW0N?=
 =?us-ascii?Q?5yJJ437l3MCOIGC1hYPQY1v6nOQwSbsvjRUXRfwvuWuirj4SKoahXp5Z/Gn4?=
 =?us-ascii?Q?CI1jh+SG0gZFVsUfw0omIxmoP8qRRc5mZudxLHhvtTXvbO5OHci/SSdewZS0?=
 =?us-ascii?Q?UwIqw8j4ndI+zlylHVDaFi7R7l6YwdHJX++8wv0K5h37jq3DedhWcmL02zok?=
 =?us-ascii?Q?G6d9DDmH0H/IhGxHCbUt1Mj6annIKSelFuDcgxbnPWNvBULupXh7UrlSwfQT?=
 =?us-ascii?Q?tkO14ZMiyZCiU4ZUx2QCak5BSO1DkDqORgaWaq7m70yqDs/0I49kg01HvIRV?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tYBKhzvszjhjD6G+E9oI0xhWrlnMdMPPacoWGe9MSxltM0uplWuPr5hl8jd38y3P1n63c4eWBlYyvQ56UmrSYCEgOa+td/FPMBmb3F7DZUoVHkkU7Q7GJ6oRXvBQZDBZy7Q8+9pbOu0DnjqB3ChJq7qQidAsB6Vc8iLKE6Pt4ZiRIlVBktwrU0cDJKaJ21dKKdDphBgJ+daVbwRjW9RiB4U2leEsE32o0GCr6FcN9LkuMxj0EA6kx4Fj5gTKcHr2cfkTRR//RBi9UFrbZtdhZJR+oJp9efKllM/dMPaBjYSqnGS+w3kR/9jvdW9JogcY8P39zlOllAlTG7d0r8nhF6taHTwlrg2WgIc1UxdrX3jaKrifCEbLgpY38e0I4tCJDgXjXE03w6qoGcqvGTjdj0udAyiqgSctXP8mIC++PJoKdCHpJ9TBCO/Ownz6baeUzNIqZrHkYgUxDn7wovigw2BoGV7xbDUelvxxDHVhSJNH0+EKY8BKxOEj6EP/D0PDC8TRV06SLlk93VKrB1Xnzc6s0wISYunrug+U5LpWxt9qfCRj7jT7bP/3pzqZLgrR/OTbNxmhnfGK72UnrY6etnXRukGn+/eh+SF/G75IusY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f60b0ab-f157-43ee-15b4-08de20f180fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:11:34.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2SdcyTvkFAHWXAjNLbJBKlnKm1XattgrCc1jJ5rJg5MknvGDjv6M6TM4s1WPzvZwLirkUx73yl9jozYa+/HHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110054
X-Authority-Analysis: v=2.4 cv=VPPQXtPX c=1 sm=1 tr=0 ts=6912e1ac b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=bsZYzbwDObJwb2A-_GYA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12100
X-Proofpoint-ORIG-GUID: 9HVwDezgKiiqh3phyc40ttNnPzZ9HOla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAzNSBTYWx0ZWRfX83LCxobLurf1
 pYAiwD5yXv81HHlZd7JAr9PF83O3q07mViHp1qpCL8PuLiGESHTqz/M6hpfL8y1QydmQjz2L5AI
 drCRrL/A9oUDfDUqkxK9Dx+A9f46g37fm5UhnutvyuD9VjrpX3WQh7ehaVOT2uU7EJtzE6tO+O9
 UuPOEf6CRDLUgMWYwlerhWdKq+yUH7+Gykhe6WohjeT/vGmk5azmc7e053jgaBxWVSTLwcvxNJF
 XX178xzYnR5deLY9bGVvPm3wblsY5RgkwhOUOm641xh6cyU2d9mxd5vP4mEusz6MNpoDErrfc7V
 +uWpFj6nG2w7Xh9ZmE5YLxAyLqnrmdRVf8I970dVpno/SSd5oDPrybaeNZPGhFV4kkSULeR8puO
 cYLoLjyrfT4KKAkImg0zKf4LwfwB+c31f09VMU4m3pQpVZTyFG0=
X-Proofpoint-GUID: 9HVwDezgKiiqh3phyc40ttNnPzZ9HOla

From: Peter Xu <peterx@redhat.com>

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 26 +++++++++++++-------------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 26f2947c399d0..1ddc2b1f96d58 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -233,7 +233,7 @@ void hugetlb_vma_lock_release(struct kref *kref);
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
 
@@ -447,7 +447,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot,
 			unsigned long cp_flags)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 44381ffaf34b8..f679f9007c823 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2148,7 +2148,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct mmu_gather *tlb,
+extern long change_protection(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 77c1ac7a05910..e7bac08071dea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6668,7 +6668,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	return i ? i : err;
 }
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
@@ -6677,7 +6677,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0, psize = huge_page_size(h);
+	long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 399d8cb488138..97106305ce21e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -628,7 +628,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
 	struct mmu_gather tlb;
-	int nr_updated;
+	long nr_updated;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2ae..8216f4018ee75 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -72,13 +72,13 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 	return true;
 }
 
-static unsigned long change_pte_range(struct mmu_gather *tlb,
+static long change_pte_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -346,13 +346,13 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 		}							\
 	} while (0)
 
-static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
+static inline long change_pmd_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -360,7 +360,7 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -430,13 +430,13 @@ static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct mmu_gather *tlb,
+static inline long change_pud_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -451,13 +451,13 @@ static inline unsigned long change_pud_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
+static inline long change_p4d_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -472,14 +472,14 @@ static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct mmu_gather *tlb,
+static long change_protection_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -498,12 +498,12 @@ static unsigned long change_protection_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-unsigned long change_protection(struct mmu_gather *tlb,
+long change_protection(struct mmu_gather *tlb,
 		       struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
-	unsigned long pages;
+	long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
-- 
2.43.0


