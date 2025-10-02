Return-Path: <stable+bounces-183064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBEBB4243
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966FD1670E6
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043852877DC;
	Thu,  2 Oct 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oYPaMUMr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZFGt8AnB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211085464D
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759414122; cv=fail; b=RDa9+rCbwbokemnOn97bzlMkIO2pNshRxszwgeKcJR9gHitmBGFH8Zl1J8ql1yF0iWhl9e7SmA1yiJp7OCOTHabXyDmjz+k4euZy6ZERUWFP6kSdrblPNvGa2YQ185kgy8zrNzEsJ4JE5FE2qDDkAFaKaUgZc952S5EgtCEx+RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759414122; c=relaxed/simple;
	bh=xJNU5OA8iSRv6kzb2VThOGlrJlq5kVFanrc8k/2T7dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PbmiYmqXTcjtrVwirTmF2NHorcyYlFkPg1gNlimv4+Gk6XeS/nDpDb/YYG4DJ1Qn3xu4wFc4mmivLInh04H9ZjLfH7qI/eaQhnOQ2E38KrjwnO2pxAwAiY/SUJvYeZfKfyywsArrjaI/UeEafP8OoLWca2VBobvCU4eYRhkqdjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oYPaMUMr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZFGt8AnB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DNH51025438;
	Thu, 2 Oct 2025 14:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+zUyNvJ2ozGEQa5qDe
	nHOCFddDk4Dmwnawy1e6r5zjg=; b=oYPaMUMrZTLd5eFsyNIVxBU+9WsvKYOYyz
	3Q7RbNbjvGTsb653cJ8oSEe6CLkSEnuzaqsb0GaCcAP1eQjFXG3q6U7ihp+/JKem
	xRDlwS79HUImbNMxHOHjKAuwa5c6yPj00dX+VP4jpQP4ee02EVYKGKlqnNtjUh0d
	5KXKm5REpyRSkFlouim9mhaW3hLhY05S85hjhWzSEy9HrG9aLOgDYYbVJApTfWUP
	4iulDE1WVNJWdNBTwKKxiBZUMrtYGqoofSLZWRwL5UCWWh2//xdWQW2bk2eSqUvU
	xnloRpoK9L7Sczje0vRQCI0KRzDNcT0fgluyzheTqyNdJDhDCmjQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq3dft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 14:08:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 592E0rwB004137;
	Thu, 2 Oct 2025 14:08:06 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6cae9k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 14:08:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buU9X30IHtbW5zCXitF28icVHEt43lfkgD3fASC9HAEfDOfpFKm/q7m5gjhja5OXrUJZGphg2cbxGDyMLY2YQP4gugp995WtXOmWONsqw831u0dPP9M8AItfZDuj3vRjFRzbFmRIJNqrpqa4zXxZhcajz6YSm5WtTnRAbz+vOnt6xaVkTbUA4NXjWGoa7kpiG7IVG1FA8z4rUygfguSeiSJ+UHwAKovp4Ad3SlfJ9dy6Q4y24uLGfZQrJYFHF/k7cBnxKRX9GjCCGLFTmcjdiOuPby6xYsTROzp3FABXtytkWTPcrdegd2izb2e96nfpgLU7CgMt1uBo1EHH1X/ibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zUyNvJ2ozGEQa5qDenHOCFddDk4Dmwnawy1e6r5zjg=;
 b=r59kHyiBB/0Wdk8MoCqzUAodrFix8d4gVRbGfmYv0bsa44TT6xul4CZeW92fFbvV02ygK9puEIYTKb78s0gy05G/gHejjTOf0sxKw02Mf8bwu9vIRVfxWkyOZ6EuyvIby1BDDb9GCDan3UhlxgMubPj6lI8QXd58AS6nFi537DOrGFBXNj3vpl/7V697jy35gDNOUVtEP/viUE+kcQg+G29a3nr6VK2jsQVaf+0hjir741ZmL9kDUYiU+EbFCc8SkKcTYkPMF+uH5MO7SY6tfFzRnzqRHsOS1eaWYy2jC1QnBZVMSY/EoQ/tcDVzNTDgQc01E8X9apcgPM7EN53Pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zUyNvJ2ozGEQa5qDenHOCFddDk4Dmwnawy1e6r5zjg=;
 b=ZFGt8AnBQwZ/q1OlsKqN5V8ozRs5X0tMxKltlYZPDyFHLXhTMByn5y5sdC2H4WLxcSCrFkVLGopj9zppIlrZ56KueBKO6OkEsDfa0Ierl3WQC7UhCPP5wQXRD5a/nnDxXUERGmQ2E+UtTU6uqx/TUdhzq/EKmMKWvPSOZU3zCAw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 14:07:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 14:07:58 +0000
Date: Thu, 2 Oct 2025 23:07:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [DISCUSSION] Fixing bad pmd due to a race condition between
 change_prot_numa() and THP migration in pre-6.5 kernels.
Message-ID: <aN6HMzXM4cL6Yf4A@hyeyoo>
References: <20250921232709.1608699-1-harry.yoo@oracle.com>
 <b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com>
 <aNKIVVPLlxdX2Slj@hyeyoo>
 <6e4f6a37-2449-4089-8b3d-234ba86878e2@redhat.com>
 <aNPb3qVCZTf2xMkN@hyeyoo>
 <9b05b974-7478-4c99-9c4f-6593e0fd4f93@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b05b974-7478-4c99-9c4f-6593e0fd4f93@redhat.com>
X-ClientProxiedBy: SL2P216CA0155.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d980c5-f57a-4de1-4862-08de01bd171e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nGPTOGaOSj85SZrenpFAfz4aaydJGAi3zPYMKtoCAynHjo0I50riZAHEvFiK?=
 =?us-ascii?Q?UFbRNBs7cRHac9XQiFrY2Lz2YhBzFhCOEbGWtLSvko/5ao0bZ5gQnugv212M?=
 =?us-ascii?Q?jBmjanh/8lS1MxAzJs3g6dfT5WPTPQxva5/IKuVmqupIQ0B7gLiz/XXpekX+?=
 =?us-ascii?Q?CBsQsbLQnUOyquuqx0fyeC01eiINvlxu/i7/GVaRoNVQpyz7qpkhbVYedGK4?=
 =?us-ascii?Q?JLkAE+hg32y4yxT4h00XV7Q/SoSnK71S2jF7xFipBWedYuEn2ClDo5kPWZb/?=
 =?us-ascii?Q?d3GOGjz5A5dO02RikX2evcRt5S2wMWLYaMTRlvZpCmND+Zw/dcxO0+gDA9Dr?=
 =?us-ascii?Q?5ZnOmuiT4ZMzVayLot4GUdRRHeq5fwD6zuR4N2gAnJ+Y1TD5aMiNw0dxXaaz?=
 =?us-ascii?Q?MXkKx6QWJG+ILpjsidnD8FNSfl60UFPFiELR3FO3IhXMDrPbv8xbeH0Z4KqT?=
 =?us-ascii?Q?FxIj3OaV5XbayuYh+8LlfAgQ5m/OdmyYEe6JTs66wVc7yhtYPQ+lISlph3eN?=
 =?us-ascii?Q?V65Z7AOkqcRZjG10wrjiEmeVP12M6um+Pb9/6j0v+0I2DWsuZg9rsbEAmnXd?=
 =?us-ascii?Q?KTc/1KQQQHhg+y7rghyYIgJIQHP9DQYEXJPkByOeoMslFKnPMXNUJZ7eBF3p?=
 =?us-ascii?Q?du/bAgsMRfKzId8kujQyxRXo0D0sif9sW0o8J+Jwdw/jwOEMBkv4fliW7sb+?=
 =?us-ascii?Q?9y9i4WDQ+5nMJJl0qPAROR0FkXBz11XP2b/e4Czaf4pk/8XHPj5yEbakf+Pf?=
 =?us-ascii?Q?QJQ8WU4TA2sYl/zVLS6+dWIoiMz6WN49sLxaxFf/LNoB9dfcehApr+eP6yW3?=
 =?us-ascii?Q?JfEsntdjFPctV8jAeMKEvsjxEDMzxXepb1MlMWEshMarfaxbTTTgNUxKNSrn?=
 =?us-ascii?Q?1h0iqvKZG79YmNJl1ez6zixcV9MDHHfnRG1BUqHFJAC3f84jHjw2F3VuNeX8?=
 =?us-ascii?Q?rkr9JtHLvUTuu1xnQ21O6dVVexRnphkf3T7zV19GD6gWOO+e8AQAmF744q0O?=
 =?us-ascii?Q?DxYHKKSha+v+W5GLcRrIe5mXfrsnL9S9X6FjymkwxRxO8YXVTGkRzV9bwxBL?=
 =?us-ascii?Q?PpinryiBl8Y4HXIA9/JWOOnVje1pqjTDCiiRi4U6KauTkNmJup52xxlQNJ9B?=
 =?us-ascii?Q?25T0EWdCs7tgfjHHWndVWbiLPPmT2Tt6pc8E9fQTD3np4HISE73KNZwxGU1+?=
 =?us-ascii?Q?lR1VrkFhZk5cwjFSK5HbggyL8G2v5+XJTKxkvvQN4ZL6TMtkaXnZCoFeLYtG?=
 =?us-ascii?Q?uVf0LQBgYBDZYzEtTaS9j5CgBXUr+D/li1H7wcLq1l3K2f1IL+hkpG64VaKG?=
 =?us-ascii?Q?MsBoScoVRxhqtqJ2QqSr6MGVkCcxHFFmNcdD/tpVqOHwFjx6yeOP4KX5oAAF?=
 =?us-ascii?Q?DySHUHS6w2q7XplJncraeVHWOHttvCDAFQn1tEr9W49lHe0KvMHiiWrrJoyV?=
 =?us-ascii?Q?KlNE7IdZfiuOqfFNN/onVppfitHtPSgO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CM/1dbVfepEXxXdjlgp1zfsoQN/fu/oKkzSGdTLZbBwYjNHo+28/0Gmk/PTy?=
 =?us-ascii?Q?IluMzEMjzAycHX91txlC7bdhyX6PoiFOYPfwQyb5OtTJ+womdjtpYbNnIBVc?=
 =?us-ascii?Q?0tS62q+MdUTeQ7dgEqMxw3sXwQzsHhVi2NkTVg5Ks431mOom1IpadmIPVgme?=
 =?us-ascii?Q?2AgMdzQuE7y3NC9Lv5KGtNbEoxlMrnylSpLjTQld6ZKSf3BVtePleAdR3txv?=
 =?us-ascii?Q?J5HH4s3y/xOYHHtLMZy4iAxBx9fTXDdf23AP5KIO8g41YxOGo0VkkZuheW24?=
 =?us-ascii?Q?549rGzI5U2AfcxcY7IgFDLJ9lB/FHPhEydYeffcv5u5c+7cELiEahCjrZjeq?=
 =?us-ascii?Q?dOMdG5mVvEIe0BqagnHFv/GSM0zMB8mrrFElgIWFAxd1d4HdI+ZzQfCkygll?=
 =?us-ascii?Q?frNStz0IIIlf9Ai3KzQ6zgJnVl8TB07qgQT/tcnX+aSmIG3bseAZaK37nWcO?=
 =?us-ascii?Q?GjMsMOOP5uOPki13SQjQb0lH8Ec7WQ+Ka4X7HoVZuRy8CAcIZ69V/DwD+93C?=
 =?us-ascii?Q?dcMH512STcJwWYIYZY0qkmaicViZcRHlTmTucNqG6wzKiNlPE1BsT7Dr1Cyh?=
 =?us-ascii?Q?fPcrnT/bBNu74Yg74KoKAO9asgyOj5lo9qOkSkAjsvcNbNftPuGq7mqZBYgQ?=
 =?us-ascii?Q?gPF8S2gjflE1+8MOvIx5G1wN8og+4gFNrGbtFE1XpVq/FPQMIlDSbgjpNds0?=
 =?us-ascii?Q?zaG8Ea9g56Kx0L8UsEli6yE1eLMaP9cYfjzfI9HTvqHD3a1XxB5KEpu1/yKq?=
 =?us-ascii?Q?d/ggQudanbtMh0vjoFVe/b88/ZjJSAU5YA0wJzh4JQ1jxauGhTctyq3KF9W3?=
 =?us-ascii?Q?Hu79mRv8SHSMbchaD0YOF8FfW5gN0/nkVQye3hQCsvN29HAIJxqjljQ6TzSh?=
 =?us-ascii?Q?jE8gJ1KfU5dscYBgyRCLnwJGzTPvDAyrjfikaJZeOvZsvDEDQTdq+9gOQ7g5?=
 =?us-ascii?Q?u5qE/pwiw5Gb/OhRKdCRNY8NdylL3bA6SSY8qg7tMjdiWLNdFCqH5+aqX3Ix?=
 =?us-ascii?Q?UtL4RLk2QWXSusizWZyOhrrYG3iH2gPog1WsiQSSVhrLzU2RS2kNBXV/xItS?=
 =?us-ascii?Q?18Kw49WTJhHcalvXfK+sIsEy3S+WGs3deKrdegy8T9g1o9ts5j1Fx+X8ZxKM?=
 =?us-ascii?Q?OlnmwRTqBZJwrkqXofdEfOfq7/nAh/56TGvRNXjYEkW/mV2p81cTdO7+ii6/?=
 =?us-ascii?Q?EfVi03QAGSDRE8YB06dERfbRUYQPJ7c/xyUFdb0GNkPtkvlyDNECGtLn3VGR?=
 =?us-ascii?Q?/kWQELm0gdxT6lhXnAm+Osq6YRwL56w+bJ95iIXgmlCeAecVfngj5wWlwhnE?=
 =?us-ascii?Q?eGwviSrJ1X3UrUf8dK9g3xgZMFMqKbbof5hNPclyZIoTkIjoN/dNbPfxtS71?=
 =?us-ascii?Q?xjJTTgk2LQNQP210oGUWhQhOtEZGepdHRyn1GT2NxOYnLP0dLdAMvBVG4KMv?=
 =?us-ascii?Q?oy9Zg9Q4N2UsnjiXrPkAy1CM8bq4lg67DNgmjHXkrPm+4k9VsVWYcF3Med95?=
 =?us-ascii?Q?lyKGeGe9cmBMg8EA5wW2dT6jVXwzgOUIbhS+Paoj61RnwLhbkg+GIq0HdTSp?=
 =?us-ascii?Q?h/hL38hkYw4L7DwRTMQbo/8IeNkx3SokqOfdUoYI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/7YFCdE/drSOq8yBVZ9Gg5KS30uWnBwS0+i3w4a64rbzrbvCpVEuFoXr33aVLKkE4fk0DtUvYYMmar/2yc+EsbmlCv/0xKseFPkVj8usyRj4JUnexbg/UaHJrhRVjYpPIIC2lJytQc1fuz+usnd5BssgLHIrNXlgyyX3ys3NSPhjlHrlMv9BCbNkZo5WM+ldrc3D0doYp3LObyEmObwenvjRTSL3puHGWIn8U7ZjhUJXrgob0/2PedOqJXpXzlBK7CouG4PJOSySkAv4AjxRfgKuXop+cfz2r7zdYovKMlfRpEVDLRNUBMDwi0alg8ymZz7llrcF4PCVm8HFJmrcVF7FoHSUxS58z7Ju27IHqnveIhw8wrKfRSxg7ZybKsiXRM+wzyWOQsACve3bGfqeVsVQ175fLzBIHpS7W8y/+KeaL35OyjNcSfLh3yP4xKQkC8bO3+eG7PxzJMuwC0NEtjaFsKve+4YrAo6PcV/QuTuVn30N/XqrG36SSKsDiDeUv4jO/fzLOPqyMgiDII5B3Mjd/d9dQnnEiZH1rJBtB9Lm6d2eLsoq/oQN5jKyxid302HDWSpO3+YpNgvspV1tXa7RdUJauWIxAOTI/cvLiIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d980c5-f57a-4de1-4862-08de01bd171e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 14:07:58.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM0u7+RENeym14XxFXNjTWFFjZqWJuNOccZeFS6puwTj8KC9HjO0gzuh40wz31wnNyRX/pOqyQTW4x/cWvM1Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfX05mD5zJEX26u
 fM6J+zk6RUNPvSNEIexwa/rFFIFtb3OW+vvVxYKd1vNyldmTnnpsod3aH931/++K9B9PpMitAOs
 4XpTeRUZEKx35kqLTr8kZfUQburaAmMWANwNA3eQAEawKL/NCdndUoW7tC8HooixRnwQL3saPF5
 X5Yud0fGE5+3wRqx2knnhngcyOSucrgzbpqiTHJhyhhW5py+3FhrLJPLzcBgIBLpvdMQGKKacLg
 R0ywau3qdwxTyKLys5ab0sERIJ2UfvRoti8f597j9KrjRowqTpmNZk1tNBSiTDzVU/oEk5Y5QPG
 wX0oVebF1NXzENdPuZvLH6qNrVXVW55IZ+kh2L9WXdukk1mQYm1qQXiExAyflyJqZA3DLD0hn7Q
 QtWAwFJngo+OTvv7J5DInjSsUA/faQ==
X-Proofpoint-ORIG-GUID: UL04DiCeAViQA3NUTuEy2LnPdXsV98j5
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68de8746 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=JrQwMgGBVk07PLcQmSYA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UL04DiCeAViQA3NUTuEy2LnPdXsV98j5

On Wed, Sep 24, 2025 at 05:52:14PM +0200, David Hildenbrand wrote:
> On 24.09.25 13:54, Harry Yoo wrote:
> > On Tue, Sep 23, 2025 at 04:09:06PM +0200, David Hildenbrand wrote:
> > > On 23.09.25 13:46, Harry Yoo wrote:
> > > > On Tue, Sep 23, 2025 at 11:00:57AM +0200, David Hildenbrand wrote:
> > > > > On 22.09.25 01:27, Harry Yoo wrote:
> > In case is_swap_pmd() or pmd_trans_huge() returned true, but another
> > kernel thread splits THP after we checked it, __split_huge_pmd() or
> > change_huge_pmd() will just return without actually splitting or changing
> > pmd entry, if it turns out that evaluating
> > (is_swap_pmd() || pmd_trans_huge() || pmd_devmap()) as true
> > was false positive due to race condition, because they both double check
> > after acquiring pmd lock:
> > 
> > 1) __split_huge_pmd() checks if it's either pmd_trans_huge(), pmd_devmap()
> > or is_pmd_migration_entry() under pmd lock.
> > 
> > 2) change_huge_pmd() checks if it's either is_swap_pmd(),
> > pmd_trans_huge(), or pmd_devmap() under pmd lock.
> > 
> > And if either function simply returns because it was not a THP,
> > pmd migration entry, or pmd devmap, khugepaged cannot colleapse
> > huge page because we're holding mmap_lock in read mode.
> > 
> > And then we call change_pte_range() and that's safe.
> > 
> > > After that, I'm not sure ... maybe we'll just retry
> > 
> > Or as you mentioned, if we are misled into thinking it is not a THP,
> > PMD devmap, or swap PMD due to race condition, we'd end up going into
> > change_pte_range().
> > 
> > > or we'll accidentally try treating it as a PTE table.
> > 
> > But then pmd_trans_unstable() check should prevent us from treating
> > it as PTE table (and we're still holding mmap_lock here).
> > In such case we don't retry but skip it instead.
> > 
> > > Looks like
> > > pmd_trans_unstable()->pud_none_or_trans_huge_or_dev_or_clear_bad() would
> > 
> > I think you mean
> > pmd_trans_unstable()->pmd_none_or_trans_huge_or_clear_bad()?
> 
> Yes!
> 
> > 
> > > return "0"
> > > in case we hit migration entry? :/
> > 
> > pmd_none_or_trans_huge_or_clear_bad() open-coded is_swap_pmd(), as it
> > eventually checks !pmd_none() && !pmd_present() case.
 

Apologies for the late reply.

> Ah, right, I missed the pmd_present() while skimming over this extremely
> horrible function.
> 
> So pmd_trans_unstable()->pmd_none_or_trans_huge_or_clear_bad() would return
> "1" and make us retry.

We don't retry in pre-6.5 kernels because retrying is a new behavior
after commit 670ddd8cdcbd1.

> > > > It'd be more robust to do something like:
> > > 
> > > That's also what I had in mind. But all this lockless stuff makes me a bit
> > > nervous :)
> > 
> > Yeah the code is not very straightforward... :/
> > 
> > But technically the diff that I pasted here should be enough to fix
> > this... or do you have any alternative approach in mind?
> 
> Hopefully, I'm not convinced this code is not buggy, but at least regarding
> concurrent migration it should be fine with that.

I've been thinking about this...

Actually, it'll make more sense to open-code what pte_map_offset_lock()
does in the mainline:

1. do not remove the "bad pte" checks, because pte_offset_map() in pre-6.5
   kernels doesn't do the check for us unlike the mainline.
2. check is_swap_pmd(), pmd_trans_huge(), pmd_devmap() without ptl, but
   atomically.
3. after acquiring ptl in change_pte_range(), check if pmd has changed
   since step 1 and 2. if yes, retry (like mainline). if no, we're all good.

What do you think?

-- 
Cheers,
Harry / Hyeonggon

