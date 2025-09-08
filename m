Return-Path: <stable+bounces-178857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ADDB48657
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383A5189764F
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA42E6CC3;
	Mon,  8 Sep 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjFkwpO2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ofaPRl5C"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF31D63EF
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318746; cv=fail; b=iUryWIHcB5XmQhDrNnYP3BEMIoctQgajOjgyQ5r5mOsPYY2dmc3LG3c6lycxazZbbnElxSIggTOiXs+nOZZ6i5+/iJUqRz9v9QsJpiMQdf1dynzsbWgpKUOtRobt2DA4RCFXM7+u6rpRyVI/V/UqCbualMLM475pxQRkjQXKBAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318746; c=relaxed/simple;
	bh=/bRoVjXSKlKDvFRHxv8+SYhOcpm8EUqckhnEMXX4dj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJODcdLgNqqGldBInCcXb21pQggBo2fQ91YfE6gThKzUkUBq23c5gD0Md5QcgATEu80i2ocPgRi9mDUFVKQeJdtjgcIWqXfDOPyyZZq2p21Ymvbbg0+uXh9hAzz9EB4IUGYbEK1NWdP4lkcUF1ttzVauym3AeYQZLVOVERZ+/X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LjFkwpO2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ofaPRl5C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5887Obdx022252;
	Mon, 8 Sep 2025 08:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aI2TOdi1L6J3qBFu9Gnjb+5ye6VS9f3idwTBXAjEcgI=; b=
	LjFkwpO2NFAXj0gkbseGK7dKfFuuYoVjBJCNurxhp/1dTkP153tWdhntmzYxeM3W
	p292T0NMpMczMbpW7pXowUASntl+u8QCg3gvAFkQbBvI1kZkPM7V3o+xCwel3b+G
	qhaGcIoikR2HpRxYM5BepYw35EWl1zomTZjWamGjLkCK9p7B3dEF2tZhZtWqduJ+
	qAN/DSaH6M8RT57rxz6Cy363zCd6TpxEcPR52L3YSKt8gGd8VgJh8BdBk4d7SNqG
	ZKxHn6NMIDtjY2LbnOsVsbxx2lBHuMKbZ6qomuvBW/H3HeZeXschMk/Q0p3nPSlr
	+XhyY02ctiifm9nHNY+uGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491tqr0242-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 08:04:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5887VVkg013563;
	Mon, 8 Sep 2025 08:04:38 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd83cpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 08:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg9zKj6a/byYrvqb5INEiMZIDJLZXx4r+oe/LTHG+fKZo8Z+9oeson5TXd8F5Oi4WOzOpRMYjLK/IvBOOJ49TL5zsYbzJuuwDV4QyrOaHujocEapoF7KDdzoQUPOFlO5uIVXKu+k3D5s3KdiKiRdetKu2poezc6WpTIzt+fNtWHZAIn8/so1EtEVtWR0eXTtD5OCVURylj9ZrUsPSmXoQ9UwDD2R7Db19VB7lgqS6gBsJrC2eUDQGVxDd8EHE2nSv7FKvEk3D7wCl5w9XQ2B3hmO38bPAx1cn6Ix89XFCI+8LPx3CJAFDTajEbKO8RGUIBYqtnprTaJR7NTqbq5XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI2TOdi1L6J3qBFu9Gnjb+5ye6VS9f3idwTBXAjEcgI=;
 b=SlK4SzrubNMXP93ECW6RuJdtB2KVIOCYV1+AZyEX45tOfY+XZFNGLMudMzi7It9cPGP+g0IdK25yWZR7PCfXZdgtQj/nGrvCFjcqxVjFS2Z/1UfMcbSLcg/BE+6y18D+CqawcuMgPtqc1HF//FMqdi4P7n8OWF6aHYCCG6h5eTlsUBLpY8gDrgoxt9uUBESGNHbXnb6ZE1lBBl5pEh2Ho603cKSSCdxEvJt3pFoOxFEdAGTikR8XGwW80+GsnB4C6xYBGdvsiTFEfpOpWTp8SL7dHoYvJykm7juy+7csffJ1xtVNMeaOIaVXbCzGMA7aevra0kRkOuutJJtdEjYHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI2TOdi1L6J3qBFu9Gnjb+5ye6VS9f3idwTBXAjEcgI=;
 b=ofaPRl5Ck3D52sZCC55+17gRRsaLLmyIl0Yy1Ye6vBVWEhiIk93hRhawFD9rlATTGECMAl9AWEfD2FZYQDiC37S0re1hRPcSfLwGmjAsMYlNOw4BipbGAKkfH7cf++yhmi+Gedz3KFAn9AIyjdgQ0oPJqWmUI9WMQPsPgskcbc0=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 08:04:34 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:04:34 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Harry Yoo <harry.yoo@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kiryl Shutsemau <kas@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        bibo mao <maobibo@loongson.cn>, Borislav Betkov <bp@alien8.de>,
        Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
        Dev Jain <dev.jain@arm.com>, Dmitriy Vyukov <dvyukov@google.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jane Chu <jane.chu@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>, John Hubbard <jhubbard@nvidia.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleinxer <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon,  8 Sep 2025 17:04:25 +0900
Message-ID: <20250908080425.7051-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090608-wages-saloon-a401@gregkh>
References: <2025090608-wages-saloon-a401@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0077.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: dc975544-c7a4-4ac3-c649-08ddeeae567b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HRI1N36rx38TPkKYNRHxWchiNgE7uB6k07oV2q6r5Eim2bxBP+C+t1qgsE24?=
 =?us-ascii?Q?Ol69MetOYE907I8pDXthGwCxuLINC8GZ55NLNkd6pm3H0TAOP7wlEw0IaCg3?=
 =?us-ascii?Q?RWl26/PqXJEzUS/NrSHclDZ7eYuq9OO63UrjmwI2njTxAx+h29+6OS1E6iv0?=
 =?us-ascii?Q?RVmgJYVW4cTZlTBOxYoP+1BVG4Tw6/1UB8jUqQOZPG4eQDegK2pqszgol1kF?=
 =?us-ascii?Q?R2LCF9pu/+XJUOFY9icgkRN05xxYGoZ9Tzl2lfnk2iylzgDqHpoqhcWY10DT?=
 =?us-ascii?Q?LrSIkjbgnMxFXPdhRyYuBtD4zOvZCy164i6igSENrg9zpQmz8yZScYejqFf0?=
 =?us-ascii?Q?dvxp14oReSKRYwvXbj4hxDthYh7zPVDue5e68/7pSNouKuDpL7LtH448ceO9?=
 =?us-ascii?Q?EAQW9MgQJtl3L+R0BIaXQBlfZaukM7beZPUkinRH32mBOM3Syz+YeswgMGgu?=
 =?us-ascii?Q?0X/Do/qrPcn0X7SgH1lch84iMQw86HJOqovJYLwrWhz/I8ZT5dw8PGLnV9T7?=
 =?us-ascii?Q?GknoVCMf1y3Hc28cx5MOSePyGUN0bLtEMvFYYhcVCu2hCCtbeVGq2mjETrah?=
 =?us-ascii?Q?TQA9i8lPtgEQK3of8FD3QfE4ffIGle4Z+AVplTmhzfJN7zR0xGRWnG/1F7j2?=
 =?us-ascii?Q?s60GrejQMvqNyusAqQsxdDLaNusFyGRPlisn1GAlDISXbRF4HGdoRgMA9WnZ?=
 =?us-ascii?Q?fWooAVXTtc7EKpnXk0jVPsu2l5AzfH+oR9REVttsqAJDR872B9V4t/LPSwg2?=
 =?us-ascii?Q?uZpo6F+q/HrmF1q72Hs3nNMAUjCW7cAfKah8DNwf5623U6L1vgUiH+kVuGQa?=
 =?us-ascii?Q?am7uwkcKfoEyGRnYQbKQejC3F9+Hlr5JdA1QBb52uJF+YUqeVpLbm3uQ+S/2?=
 =?us-ascii?Q?Mhoi5nxYofGy2nNE31f7RcpEU88YNT7xYnhW9TER00e2KFT2GDNvbTfaGu3j?=
 =?us-ascii?Q?3HLpETw0CgIXh8nkELUhp2yXZ8xPgN9D2YWHfeVcNwS0I2R5sNB1UCQi5Ma0?=
 =?us-ascii?Q?38/mVjKrbQu2yBkc0r2dIv2UYGRpnoxk/gCykmOsK7hKT83Qo8iH8BFi7c2j?=
 =?us-ascii?Q?XBOpE0KF9y9rejkzthz0QhuQm4miD/xuGnqSf3mN/JlJFL0IAoF9tqnMQT8i?=
 =?us-ascii?Q?+mC6Xgppu1UOpHO2ZtpXpI/Q80RMJyzVepwfcZfs6BtvMmd/7IAYqeD3a90H?=
 =?us-ascii?Q?/YotvEJQzEg9u+csv4cGb1OpUi8p12412NiywY5v17rNm7FSm6Lmbd/enNwp?=
 =?us-ascii?Q?YDvb4EtMhIApqM7th6TBV7p2EMlVEKSsB4h03rqAub2FoIgOWWAfYdI/l5h/?=
 =?us-ascii?Q?C/bAk80UFADdQiiCVcSTpkCB1hIe4iVYXxdu0fps8uCtwMm9HQ6zI4KhMx9H?=
 =?us-ascii?Q?Zv21S70fC8TNkywoAtfxOQEKbgSq5Wrc9pdyX5+owy36THWxzepu/XxfqmWB?=
 =?us-ascii?Q?Sg8UOo/XPPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xrx4698VDcG+gKIVqMUrbkGneoIQSHwyrRDQRP/7zu3g/2zabxr0E5/0d6AZ?=
 =?us-ascii?Q?4FSLJ0J7N+Mk/zzITY6pi+s6ZLrMJd2/LaKRl9ukiW4+fqqSg8mfWNkQH7sT?=
 =?us-ascii?Q?/2qXUvlL3WbcW43qVQJr9z454zw3HBa0kcxYpBoVSTMqprpGXHoytODQo602?=
 =?us-ascii?Q?tZNKzZ2cMyuJMEdDLkgN6PwqtbLPkLc0E98FFc2RU6Pt+S7NqoV6OgYId3sn?=
 =?us-ascii?Q?CSMaeBMZb0jygCZmvmLdwgV+IIrjjUvuXwRoG3wZxdURfe3RrQHIoelUIh8t?=
 =?us-ascii?Q?jWIk5xPgK3QCVafn77YZPSpixCUqCRBLgk+TWJFgby41wvf3blyMeIiRR0JB?=
 =?us-ascii?Q?062NLhWLvSca/+OGrfgbOk2WEBdsuwsZVghrHMPwF44t6TeIHFlWEYfWk81h?=
 =?us-ascii?Q?Ll1myY64hx3YDoEVcv4t3dRZtELVaY+lGmkzfmfCAEdM4nZ4k1LrrsmoZJmd?=
 =?us-ascii?Q?FJPUxyHhYUQ5RcL10qhXHdpo6X/4EftB2LYX9crhbZ616a6T0mf0KALJexyC?=
 =?us-ascii?Q?TAW+FkPL3nOc50q20c+15p1P+Iv4guCscAO8HZA+/YVLpShSmuZCWah3voqt?=
 =?us-ascii?Q?ZgljhzAmbMXQlwpVU+csvofDzhDFyf31S85vjIrfvXNdqSSsGroHHd8yVLBj?=
 =?us-ascii?Q?R3GH4vhswN+cIDb8bnBE47X3NUkNSF7+sdM1p2WbSWvgjHA2U4v0P8ojS062?=
 =?us-ascii?Q?ZckWRPT6NusFX+a6Jg/RRTkLcD2ILxFbmzzh4lDt7xy4iVFWAUTGCrAenC7r?=
 =?us-ascii?Q?dhBQcOPet762snlhicSTHTzq5qZ9Cxg6lhyG5iD60JICX2lzEg8nA7tCt0Lz?=
 =?us-ascii?Q?bitBG+F3sWOjYuB6YEyBYNw4BD7qPTuRnphRvhasa3DO0IIeEHnoqcEXmKvq?=
 =?us-ascii?Q?L/V+Etz4qJszgJdpXrboVoU9SHDImrneqledUrayM9UHNwjZYCTHDiRapDFW?=
 =?us-ascii?Q?zfASw3fslnKwHIByAjvS/6Tx9MDY7yV4DeI+1EUcJk/WvE01QskcgUAi/NA8?=
 =?us-ascii?Q?pRFFoGJtA1sUFfeCA95C+VgWFL9wWeFH+wrPuEjxafrqR3seidnrfRMz2F9Q?=
 =?us-ascii?Q?hyqqxVuthyjaqejfXsW5I6uysfJtHW38riRJZG/LyDufIXf1xpHfnZgXVR3E?=
 =?us-ascii?Q?issa+lv8R2ka2HYN6+roCYwYqwZSt69lFblHE41tb2rmp5tl9+DpqQc7jDEf?=
 =?us-ascii?Q?fyyNJ9p/gms513BKNOjPJCsyPugaRudeC9cpZCrW5X5XKxfulHvcGwWIAGan?=
 =?us-ascii?Q?sPxzQjd1IkHA7DKNDFKsq8iSG7lW7Gvp57S0wIPQtpGfcS1HfsDy5QPG3bY8?=
 =?us-ascii?Q?pMTU3u257lrIAv83ckBMQaiLvZuNaH5f+YgONl6rI2fiuZYmGaN+PYCsRvzl?=
 =?us-ascii?Q?cff2fNHfmfy4o4EWVF2H/xWQdks2FpQFis+5oXW+tYFvkzJ4twd5GXugjiMf?=
 =?us-ascii?Q?s94TLQUvOYL6cFy63/kwf71J13WCN0oazP2TRnyVTQ+LNVtfrTl0whNoDAl2?=
 =?us-ascii?Q?v7bXgLeLk+yqsqTHdX+9Rf1USk9xZk25EEFhJv+s9HJTLIcKQB/yvF279YGk?=
 =?us-ascii?Q?1AFPveiSMTs9qyRhZCWzAjzl9WDAS1bawM/f8NUj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5hLpD4xbcNBNQ74KFP7bfZc5Rg4V8VNivZ9z/2IJdVlGrsVs/Ja+SXcuRRrM2sHQn94eGKj+ICFNva31UGYXqrtn9fRBqq5GTxs6bPWIupaG50d6Tz0eH7bYgdPc286yz0oWFiCeiIy+1iuC0AVI3RIcf4W5i1Up4jfJkxOJqzb0jjbWEEzSvSBhkPXAn+iqpRpnseQ8f5Qh1MVR/10ZJonGZyArAZVPV0Mp1Gjvz//nrgoor52SuM8xBB+x6K1bbQ45MbO6ZUXqjVJ0Rwp/livpm+lgXmQt2C5/zzazgZlN43zH8PxUrE/HxBAGR5hcKK8e+/5f4R0iIUYLZ37PJviR8lD6oHhNqSLUbQXSKFzdecd/Gw5Z0QcHB12rCtd+S/CgcvWpTlMEkIqs2XxDdFAYBDzReTCivbBRKZz0yGNrhwJPlE4ASqYTXGSQ77aFPlzethH1/nxD616sTi5orwn7oYw6gH3LD609WR1YrlWzS/m3Dm3SxX0hV73psrjs835Nsugr96AjThbRZnNMXfbA5r4EC5levhxeQ+ILcfPglU2TGwMa/gYWYVzHBylYdifoy8qq4N5ofYEycUsU3LntcgLSlEzPFyFCQfMhu+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc975544-c7a4-4ac3-c649-08ddeeae567b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:04:33.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQbcnFC6BV4Q56PPihkhU4y3VrWkmg8YsROFznbHGCKaU0U/83h/Vrpkcr8Z0FBTl+KS/oRAbxbLQL59eX7dGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080081
X-Authority-Analysis: v=2.4 cv=YcG95xRf c=1 sm=1 tr=0 ts=68be8e17 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=d2j_XgrXCP8SUPSpM9YA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: mzFsTLb3LfVIhaW1MeBkAiv-KrfRzvhc
X-Proofpoint-ORIG-GUID: mzFsTLb3LfVIhaW1MeBkAiv-KrfRzvhc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA3NCBTYWx0ZWRfX4uTR39MHne6P
 vIAOw6DOThBwOYV5rh42JH0ywvsFb845xtlYvnX3owhnA2y9dYEYLpEdFKK7zNGc4l+2eKF6zo/
 L5IHynY4pUTa1gBXeZ/kvhuZh/t/3utCDuxWuebWY70m7nf0EzopnpwLFeWvxnHHNgmTa6uE8Iu
 HQy2RlDCzgpj5VhAJEEbEW/tRHbD85WC4WIlwseHC76EkQRFDLuDbjX+w2WdsfCf/HWPcO5ZBrP
 Olvx26/15GuynJa82H95z3JyNqG3fUxjZWrODTiTDPhnTlHTImPg87yY4td8iOjSQ5Ui9Cce8Dy
 kKKP9s6OOD+H2uOPPO3+6uKP1/6JYVRcktB0Fdu8d/VCGmQf7m6anTsAxiD7vmotqV50h8cOzWP
 28O868UV

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.  These
helpers ensure proper synchronization of page tables when updating the
kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.  For
example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for direct
mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.  These are introduced in a new
header file, include/linux/pgalloc.h, so they can be called from common
code.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by
arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced.  Currently, these helpers are no-ops since no
architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

In theory, PUD and PMD level helpers can be added later if needed by other
architectures.  For now, 32-bit architectures (x86-32 and arm) only handle
PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect them unless
we introduce a PMD level helper.

[harry.yoo@oracle.com: fix KASAN build error due to p*d_populate_kernel()]

Link: https://lkml.kernel.org/r/20250822020727.202749-1-harry.yoo@oracle.com
Link: https://lkml.kernel.org/r/20250818020206.4517-3-harry.yoo@oracle.com
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bibo mao <maobibo@loongson.cn>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Christoph Lameter (Ampere) <cl@gentwo.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org
[ mm/percpu.c is untouched because there is no generic pcpu_populate_pte()
  implementation in v5.15 ]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 26 ++++++++++++++++++++++----
 mm/kasan/init.c         | 12 ++++++------
 mm/sparse-vmemmap.c     |  6 +++---
 4 files changed, 60 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..9174fa59bbc5
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b1bb9b8f9860..ebae05c1645c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -904,6 +904,23 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 /*
@@ -1522,10 +1539,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..2c17bc77382f 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -188,7 +188,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -207,7 +207,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				p4d_populate(&init_mm, p4d,
+				p4d_populate_kernel(addr, p4d,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
@@ -247,10 +247,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -269,7 +269,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index bdce883f9286..fa4070540111 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -29,9 +29,9 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/bootmem_info.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 /**
@@ -553,7 +553,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -565,7 +565,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


