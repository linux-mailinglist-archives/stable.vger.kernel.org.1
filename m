Return-Path: <stable+bounces-179098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C609B4FFDD
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0721C27172
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37817350824;
	Tue,  9 Sep 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dB8qFwN4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0KKzIzL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651B3451B6
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429149; cv=fail; b=J3HR9jzkashIvrjpKODd1kpEqy9fk5Dq1eOhsPqwoJ9n3QNzAg4kireziMUf3YOM9CA+8QRPEUzndE8dbp9JHCt7RML0zyph0a+pSVElXOvimDrjVNu6botIVb/l1k2EFQ96uUUheKA3J5H3KwBCulUPJQ3vwPBhRUWA3jr5UU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429149; c=relaxed/simple;
	bh=qX+9gKBSetifS/FttHNBg8HAZT4NxFsnrOXY2sGtrS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=InzY1S3sHP3VCN8Vy1PZ6FYwZ+Uw5425iKBenY2x5ndX5qbsniwfE+IFJKhWntjaggOmSEPuz7hI/+8YN2EJKt5p4G2C7wsEFQ9hd28LBuqTMcP0SsQ3ge6sOc5mjt7+BIS7zOrHsbnYGS+tDM/BX1kENydaY+j9uuaH38w/JIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dB8qFwN4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0KKzIzL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPFfo003418;
	Tue, 9 Sep 2025 14:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SsGLiqfYawuYbHCZ133KB/G+t8HBlOYfrNXfmF1xHsA=; b=
	dB8qFwN43bttFzFfmO30y5zF2ksM7KRmsYwYJamPHzYb5g8DTUZNZSbv/tNPSd1W
	1j+Ic/Omgimq/xMSYBQbCOW0OXqFSqMxc8xgPndIac4O0M4A8+iG6KT/Nq2ACAGU
	ZPquWV3Lx9kIXwHYJpyxiOy4it8hXrHiak0o/55lE3AKqvk7KpXaLPrppuHp+OyZ
	uYvw1bf3ySjEb01EPtL1YetknsSF3734sHTVl6iw3/QbSx5WUnAtCLGlCB6rHTcY
	cEHQKkPVjkKr0lMMaWpP6RkWsAPR1Og8L20HGaH8EQ3Rai5cS6CtrHwKJ8kfmVH7
	j0DOQ6FKOlEHXsBzX+z/cg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49229624g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:44:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589DDQgA002957;
	Tue, 9 Sep 2025 14:44:45 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdg7stj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj2JNrtAjlr0J1O1QBPi16HJm+rF5ySlyoS+2M29IR9TnIrnjPq0hfrhPnVUZC/V+nScpIANlU3ziQ6TFqpGNKMDmyNRUxzhFKoHuCQAcEcZc8aB7Lw+bjRBHMkzhLq+MhRrfvCDNlsZcWvrxy7fcAgExAeI8uC427PFzL/FSuyDcBZRyYMT4NCUWRMre5ZyDxWSlN5AYwkI/ucwSK0+bP03Ct8zFh3AbP2dfx8fKBOSv/j5tlQsdLl/i4PtGlMY4xt8/dSD7mgdZOGgVBXSnZGJsRZr1bfG0/sm6C7IIJ8qfDyu2QIz3pClGdAbkmv2EDgcKRdBzhI0q1YUTpblqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsGLiqfYawuYbHCZ133KB/G+t8HBlOYfrNXfmF1xHsA=;
 b=axMiC7rjG89RiD3lL122eTfnk21/3R6T5t7wFLncnbSzT0AjT2Ul1v0Dm2MqWT0kX5OfgEb6eURAvR2qPa6C8xA3dOR2bAbNS+6NPdq/KKnyAvPwuKYnG04Rt1HB6y5tViLeRaxTWPrQR+wJQzSheM8KJE79LZQz6KrRCc0f82ZcG9FzCRQZg3EvvVVKJxgKGTKBwqnCrxbGjk6h5gLGf1h6cCV+euz535akvNNeQKcrLUxdzH+/2+qOYpC/oViI/I9y1YuxgqCuSE5HChC4BSgQ242WApgJcxodKcHU1fwbv0x+5GTJW/ckGzG4thsVx4gj1wqhm7Z23GJHoUXiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsGLiqfYawuYbHCZ133KB/G+t8HBlOYfrNXfmF1xHsA=;
 b=V0KKzIzL84ZfFmxicH0/K2yWjF1DmAOkzYecGM+lJk1zanDUKyn9VFpDzc2b+a0KpuXvIqF0mNx0udRkjPlpsfAbpsLU9xBFWV3AtUUxKapdrEZZt5yH8YVCA5nNuXRNvywxtzI9vbKZJP6lT+eoSKOO/C2iaHkweXtEw/d08aU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB7914.namprd10.prod.outlook.com (2603:10b6:408:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:44:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:44:38 +0000
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
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V3 6.1.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 23:44:29 +0900
Message-ID: <20250909144429.194217-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090606-overthrow-bagginess-c68f@gregkh>
References: <2025090606-overthrow-bagginess-c68f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ce48a3-de66-419f-ed69-08ddefaf66e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h9K5n7xFYSk+O4j2KhsUaDa65dv2Qsor6k0pNgFifuoP9HcKLFCbSTLemSdj?=
 =?us-ascii?Q?0oPqaDaNBKMUexUnX3mt0/rniPkIHLL1CVWplUrFO6PrZeA+QQCQgJqF4i+N?=
 =?us-ascii?Q?gLZG+cpnKPju7E10sOrblBMkBxDE1K/ljCIO0+UCQzrMibdekAbIdBOLLjRR?=
 =?us-ascii?Q?i3Plx3OJz5JfutI0ScghDgGjOsBQrX5Jgs7LIMwFdNcQAmY96rAsKZqsaTrt?=
 =?us-ascii?Q?hZVzeKIhe7O0Ax2J9GGsHxURcEVuoQGjDJbqjPffpOMx37NsVZCslZy8ZN5p?=
 =?us-ascii?Q?WXU6WAzbwH/9v5xM+lDxoW6qjbFmE5XvrOw0Cyv+TmLPH9g3JrWcFh1jbgw7?=
 =?us-ascii?Q?nICcleFiwLC8vSzCuIcO+fZevh7bY71c/JFEugkphqGmXDtZn0rq07LSrHpM?=
 =?us-ascii?Q?c+MF1/s6RVLjlNgc0KibYfhSCVCUcVSVaWPKVDX+RZCthe/i6vD97FfZw9in?=
 =?us-ascii?Q?NTzMhjmuki9HNDfADA/DN2aG2ggCp3QksKuD+Rt3iwNeiO/6lnppZ9U8vV7v?=
 =?us-ascii?Q?PlPjeU8U+PNjGN2s5OPN7LSYDc1MaWaDrtF262m6a9S+4SN9fVKtV+qgmIBO?=
 =?us-ascii?Q?MJJlCWXun4c7sDpprsXG+aNS6/Vj1yG2SrpQCZ66AQlA8VTCGiMo90ydEMLp?=
 =?us-ascii?Q?Mp9Rg+ffcu/G1zatgtNm/grYlMOoLXKq70GRq+7ynNqKvuHH1EeKXrIbGUfS?=
 =?us-ascii?Q?HaTvqOhcB7rdXx/QSxsPY31w64/4f13UmAjOhNYjhv5JbhevBR34McJV2k5j?=
 =?us-ascii?Q?AS4wspr+buB/E+EIJC8pRV9aUK6y6sw5uDQoI27U13CHEAEEQZr4/rcXrDxS?=
 =?us-ascii?Q?l7jeO/YrMie3lHAIpkytfYn7PIjWL2Kz3zvQ8LAoVtAN02LIReqtsNI+CZYb?=
 =?us-ascii?Q?rz4/y8uq95fLaIny7spZLsOMc9SruI5jeyvklwXUrTnHOVUx466CatS8HQfk?=
 =?us-ascii?Q?lXvZtaXk6IxyQwDLKMI2Wq1oguJKW82yeJJVgkgsb+JGWvT3qF9pjyH0POQ0?=
 =?us-ascii?Q?vUrgTR7X/llVB9ra09+tDGanGFRuzoaPxnDNeWuAXia4aZC8NgPTi6sYYrl/?=
 =?us-ascii?Q?6lCaT0FKU3o+73YbdgoP7AOpHaVwfipipXi+XmRqfTv18Z/r7gtIbereuLQC?=
 =?us-ascii?Q?Rz4F61m3pIFOL7P/7WVci9AEIHwMdFl+EdlycGR5wgMXEqi5E5pwRqsjBhYA?=
 =?us-ascii?Q?bn6aWCFKVwNmWZ8HZ8ebi7ylPLMyM1O9jwYunfFDs5p2VhgM11M8hwtru+vD?=
 =?us-ascii?Q?Yoo/JO9PZFD0Nk4p4vRlPbvfjYho/Lb/eu7/mlm4q0m0/aNHMRYdRVSJOxMf?=
 =?us-ascii?Q?GgTuyon2G0Az60IcY4nesBe/3B+2NV/alJjFkV08gGqT8iPZQb6tWYW8LfP5?=
 =?us-ascii?Q?PXkQ3FKtwdIuzSmv2SGZlaSZ2Oi4Svg/oQbh0AmYnM4STuHd4N3IaCCI1o1c?=
 =?us-ascii?Q?AaLHDSvq1zSSPaWnJT1wpM75FjyRqsG3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0op5qEoNq8n8ctKqQFJBpapAWUf2TH7CWNkjxOpEEiQAMhgjxqFR5IIB83X?=
 =?us-ascii?Q?Qb1kCg7j1PIVx9WItfI6EvNVsDi07Sm8ESLlSvRhm1BlsTQcIe7Y53/PYIUC?=
 =?us-ascii?Q?ptqZjPAS4APYfhSyHTG+X2hnTYbm72/tA6vNEvlkFTD03j87Q7QjmlYCUG6K?=
 =?us-ascii?Q?Ur9lrUW0dw3UBFbFG9JEEPiQE9Bgi1fpg67pKCnSpwsXyuF2mHEHMar2//u9?=
 =?us-ascii?Q?VeCSZpBq+WVmzkLiqW070CTrZQBCeH5uSQGj10tGmWqE1a9dUO/turSJPwc6?=
 =?us-ascii?Q?IZT6IbOeQRSjFDIMKKsR1HtgP0PV2BzQpNhs6Ti8UJv2eXk0U7+3Ed3IIM3X?=
 =?us-ascii?Q?Ux+slyw9xnC5vEy/I6aHgUnrCdtyx+eAXl+dAP4zFxQ01y5uVdLnUtmFaDr/?=
 =?us-ascii?Q?MY18uMWHJpM43aXnIBo+mXO9d6xQhmWbpdKQLmhri++EmXJqMWrfbBhN0fQX?=
 =?us-ascii?Q?5TjxtUf2wTEVzZKipErfDq6KRZbMAIzFJi12icV/UBfj4pIieLhLAh5eZQ9L?=
 =?us-ascii?Q?pA9oZ+em7NXg/G3wHurLatJiEZtC9dMZRVqkRF1astKRAGZa0bPMiUdN54mt?=
 =?us-ascii?Q?lCWdbmtwr+6PJnS44UJBHirT2UkYl17LmBpV9MqtGfpnwXEDsPT2ry8al+Z/?=
 =?us-ascii?Q?B+tksSniUIxh2N18EcOmCuecvgqnw6wsXZvrG8s6gYDD2aDaf2srx7Sp/Tpl?=
 =?us-ascii?Q?+VyJTmEwo135o8sWcvBZkJ6P3gWomjFjGqsYo81LE603Eq1cDHzo5w4aMJIX?=
 =?us-ascii?Q?X0WtuWhCfrk0BIJAiaysXHKmJsIKVlLvyeL4kZkFvaQzLYoIEtueDOn2yB5j?=
 =?us-ascii?Q?1jqvYGYCeqoJAy7DEv0vmHOohzjoUmKLpzmdt+TApITqS8VblEqxs4xva9R1?=
 =?us-ascii?Q?cMhxKCDT7e3Lq1Fz1zTFK9VJfInFUHAuymcq22dIsr+4Ac2rQ/9xmOUBquRc?=
 =?us-ascii?Q?9kiASmWl7YguYd+1o9J9hgZWe2P3vj6rAa14ulv3vz4zUJlNl5Za6ZtVGCf0?=
 =?us-ascii?Q?YSdjePdbQz/JJto1KA0u6dtwOzp8pNQXf7SjkbwYC9aInNDc4SppCrlhzE+J?=
 =?us-ascii?Q?NdkTvqdIpjTXCEZl/CFTAnBF4AXmY5Ugsm+uSdMDSS+YFFz4mr3+DnCH/yt0?=
 =?us-ascii?Q?DPyfaM05UQB3iCtmi7lrTeYiS0KTlAW/mr9D5fyDxcjMoqgo/dkdpHoJhZZ/?=
 =?us-ascii?Q?SXuD5+KC4iL2Jd3monD5Y1H8sm9hTgNqxE/EHR+owgzGzrbTOfkRdDKB3kOx?=
 =?us-ascii?Q?e/L/iKnZmvnqY4vd4w3EPqUcrs0KjuHZKbnG7E/uJR+T8q9MO9T61yoNCrJl?=
 =?us-ascii?Q?CmpTeJGgNI4FDbQfxn9g+EaTQMJP9nb931v9iwumNLBM8Ob1IDFcssCXKBer?=
 =?us-ascii?Q?oCL0zf7kFiU4xWb2AmZ7LRgNoLBZ9MExZ60wLkAw3wywzb6oxGEPEETWYiLm?=
 =?us-ascii?Q?GelRT+Ct9Ydna3mgNGOreNvzdujPNEmIh5djMzd58paNDJI3T0xgQMIGhjmZ?=
 =?us-ascii?Q?ykmM3SPzakolg4hMle8kS4DN6xx2NwtcGPqdCKjNfeayS+7Zy8xtRZ0OAzVo?=
 =?us-ascii?Q?YHqK0ROAydPZEazmavczCbgwRjHfWBZTbjZt8nPF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PoYJuHmSGsREoXzRfUFLbJmtKmFrEdLBWPeFj3z9Ka5vIfLMKQeYRu0uYORg6ROZbspn+qDUmWbOy6r6B+7KFzleLOXzyHqtjgrSoJTkJcGvDh8oHICeyzsYuuyYzxTos8vC8h+E9TAo/Urs4bC2DJG5DCSb2rPaWj+KSh9+o8SoV1k2kszv7QoPEOr0Z2SUFCPoSKRhMv7DHrBJDEeyIn5D/KTPLxeoZ6mUssvLxuiWXYp968k46yvcQV/YggPZAaYVgYwAZVa75MwynPp5O3DiHX+zgU/sb7zFuX41nwPDHgwleIdgN2jkij865qNwq7+HHwCQ61rpnut/R22Im7DOJv/dhT7Ev1K2Kv0G3wEBDzeES/fOOz348tFQEW9iPiwNJOjLvduouPCfPxQyHCC9tyuZ+EWZ6qu69QQGC4l64e2JZQSUdGDBWI7A8RW0IGMsqv1m7ewM4lvtZUm+t7y3Nuc9MEo1IdK4DcoGI9Ebwx4+PbOIJ6QZK8YcrrulHrk/VAjiVFX5PWT/dvkCILxPtF4skwjyAT5RO0TACBv2S7bpxioAzoKWhfV4zXAXqXrAEUQElcLjJ9N3CdtMeX0A74q5ul5/67gYlzYKdUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ce48a3-de66-419f-ed69-08ddefaf66e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:44:38.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qScT4x32/WQQwWBmUSCkRiFKusHkozufE3pOrnAomLah0SwhO2I83lD9ZNPxD3/iupQvcAIbdOASmA0wcqPKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090145
X-Proofpoint-GUID: -SYb059RcdOrxxd2DQ-gakoZKNczHFXa
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c03d5e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=d2j_XgrXCP8SUPSpM9YA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX5gVx/FC6pDkL
 7wGObwBVwgZvmX90ch7F1G5VTFPMnrqGf2SNJNMvuNkKYi1uEL44js4693YNy2Mkj3CqISYuq/v
 I228yaoLlNtFl9EHrI0sVJv10jV3P8Fg3XKxZWQvaSyhi8L1k6QP0HLsLmdfMxjnVBaysEbm8mZ
 VmZrzp9wYUIGjNaLYW2VTSgM6+Kvk7FxoTJparTatXTewvvXP+K7v8Z07CMY+HiXxLuvYFL7OGR
 Uo7gruw5MymetFwOMjHB5AFXtv4+7hs9GTRgbDgNFLidJntDn9DFyjywmHLWhLz0D1PtQ80UoiE
 PT3NTqvwdOhblPK0/pSDyZCkmRv4l5QvRf/JgGTiEL7EqpWk1tLW1tznKP4wFlW4jzKHh65RO1V
 Z91QIDlsoKYuISeeKSaAjOTdRjsblw==
X-Proofpoint-ORIG-GUID: -SYb059RcdOrxxd2DQ-gakoZKNczHFXa

commit f2d2f9598ebb0158a3fe17cda0106d7752e654a2 upstream.

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
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 13 +++++++------
 mm/kasan/init.c         | 12 ++++++------
 mm/percpu.c             |  6 +++---
 mm/sparse-vmemmap.c     |  6 +++---
 5 files changed, 48 insertions(+), 18 deletions(-)
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
index b8dd98edca99..82d78cba79d6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1474,8 +1474,8 @@ static inline int pmd_protnone(pmd_t pmd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1608,10 +1608,11 @@ static inline bool arch_has_pfn_modify_check(void)
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
diff --git a/mm/percpu.c b/mm/percpu.c
index 27697b2429c2..39e645dfd46c 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3172,7 +3172,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3202,7 +3202,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		new = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!new)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, new);
+		pgd_populate_kernel(addr, pgd, new);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -3212,7 +3212,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		new = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!new)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, new);
+		p4d_populate_kernel(addr, p4d, new);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 46ae542118c0..f89dbaa05eef 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
@@ -215,7 +215,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -227,7 +227,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
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


