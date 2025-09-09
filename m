Return-Path: <stable+bounces-179032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62810B4A1A5
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D54E64C8
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 05:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8372FC036;
	Tue,  9 Sep 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m89XSAus";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ibxaucr/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662018A93F
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397353; cv=fail; b=hiAObB4YKc0b4+xZMv3iUNVIZuqRFetKYKnmLh0EnWAqFeyeWAsIvrOrq+V9a8ViRGT3XCHpJHFWmxAwqu1JtRRN+bLJvq8E+i5yeveN+5+L/Ev7RGJjEFjlaF9YGQ+szGKBx8s+nWkxpw8sKubo1H+6pVAC5QmuiiQmau7UrxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397353; c=relaxed/simple;
	bh=f7TvzLc0gf1gX6Fzl7jzX1UiSG0G3NueKrS9Z1QvYY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNlXbsMAxhMBeUpKSzfvaYMQLc73jJ8Pi3dEwR2ohVg1Vm9cVZ81wb9Zp7EwKPTP9wc+1PpOdVxNrAQt7JPvwmsoohmsBRVbzecwF/bwy5X3aSNUIt0ILLQOHCu0MhVKvuna4oaDVp3nFTK6Q3ItA2PLXpZF4f3hwHs11vYmfwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m89XSAus; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ibxaucr/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LDRfp028776;
	Tue, 9 Sep 2025 05:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hYCy7HgK3k8LoKt3kWSmrNromtTJtKIE13NZUc528/E=; b=
	m89XSAusvu0NWtNrpimVoYq1dMdpQB492/jZlBV/Ks02OjnfwYaZ8XNcyfWeouEL
	NjWX6Y7vvrkVv2srHLSs8TmuoxOzVPyMDv5V0jRkjEjFa5IhhH1t9r+9blTg9cCW
	/5szHHVFQ9qyOjO4T4z0Bz0mk2Z3L2k2sW8WzRYm5hw2+RSeGR9dAB1wCePGu1St
	1Y+HyniA0yCZB++rf+en7cUTAGpsM07bisJVYi5F5im8ZYGL/oy7wRTgG+sMhPKT
	TBmnGec1Pwh+gL/PoFvQI/6UG/GlSXMijEaAfSCQmmouU9s9bDPq/17F5CNVXyVe
	7q8vu4O8QwmIkDDlOxBZiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2s60r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 05:54:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589528xg013865;
	Tue, 9 Sep 2025 05:54:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9byrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 05:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=briv+yTKnXq54eM67BtcKJCxHu20JUaQyBgBFAkPKhMfgFQJQWcTFuo0Sq0dg7QKfsTeHqSrYn2FYzBx5SvaNCyT3CQb2jCcLaYhihALCIObvdBRXNjvgl5RSavI62Gew4is0xxgOLpEGd6PeXccOiN93XYxNuukApGEka51AyKkTSjYZ/KyPamZT5sI6ffGngDmYEuruFd/dxDqkWXToDOSWvCVfC8PPNXgih5zZwi1WImtPVe7gnWvABnRUSpaSHb4/nG4nRBZ9jF6+oLpf/RPbxOisiOgVCD5+2zIWVbQuyqTS3cdDLeSPQK1u8ooBfIgHdNp8Pyvi/iMaljMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYCy7HgK3k8LoKt3kWSmrNromtTJtKIE13NZUc528/E=;
 b=aAKPAdKurmLIGwSmjiHDNAnzo9xULuLsAiCNUE20QdOiugLqvEZysgLR0dBSmlMD//g+jhvHhgConNWGqWq3tKDCkCF7DgIfu4XbqwHbA9A9llMoUA/Ku350EUxMrWQ5XzeM5HFkjrs76A9wRiiEetepC42X+zDgeDlbrlHnGIkwNShlL5XKfr0urFDhhaCOMri7Tgg6EvXwNAAFwBgt8lEsGSFKi88Lkbm91zSrvacs6Zb0b9HVsjjXrGc1UImNW/e9BZHSar/myifyA0pKM0HIMHNZ+l2wOH0gU7tC8qokUt31xVIICKG6hDvQjmjs5S2g1LVWO+pl9jaAGr1VOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYCy7HgK3k8LoKt3kWSmrNromtTJtKIE13NZUc528/E=;
 b=ibxaucr/2Hb/DDl2UyrnKAOG1APfCfBWeInpnwYwt9lkijvL/pIQCbc49rxgxpjNTTg+LdJlg5qDrnr6bXjVlGCKTe7gBKGCFaRRc8Oye2akmo4gTINXxQIbTjWZZUXzwjiMsjx1+TufB1JWpodCmsAi9D72/K1+SlOtZ0vW7mg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB7997.namprd10.prod.outlook.com (2603:10b6:208:500::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 05:54:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 05:54:41 +0000
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
Subject: [PATCH V2 6.12.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 14:54:32 +0900
Message-ID: <20250909055432.7584-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090602-bullwhip-runner-63fe@gregkh>
References: <2025090602-bullwhip-runner-63fe@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d44ffbc-1dfa-42be-4d51-08ddef655e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/Y5zff8Uf1j99wXzQ1bWGoUCu3A+JnDau83RQGHQkM3T9sU+OAHVCsX4Uzt?=
 =?us-ascii?Q?0qAlCZN7M/Cku5X+uoOrnHYesaAPR+fnIxsnSKyEpjVqv0z3qWSQRgvUCARd?=
 =?us-ascii?Q?/AxADXleB1LXN32suBfuj2JJ9F8ozptZNGYqhjzqwfhlsNi/EGyrE1KJqFM0?=
 =?us-ascii?Q?saC9CcL061DKP4K6dmnb92TYUPYokSkf9vGh4x9O7P+woLAEC+ohU6awZHtR?=
 =?us-ascii?Q?Bk0/xxTap63OpKj6Qc5ZH3Q/N7TJxMqbEF7C4FjI9qst0jLLDQZfR5L4ihIb?=
 =?us-ascii?Q?5LUac/6K++XaowP+ms/5nGnNz9xCmKhZqWm/Bz2PUjmZyLtqyoM2Q16unMb7?=
 =?us-ascii?Q?sLkhXayhPW9Gc5cLFhxiCjyKg6wvDmPx/Em+BDMgyNmo/e7BXFPSigoE1DzW?=
 =?us-ascii?Q?cvMirqHwcCTscVc43hfZ5wh1c0046bGNMigNsRlW9CddOOYZTJjlnSK1bpPm?=
 =?us-ascii?Q?iiP+eemRKYEUFF3VLcZOXycrou/6beQmwOMRrG8ODpsECWXU+bfH3BM3Y2MP?=
 =?us-ascii?Q?ACyAFcFvjNqwX+DDJguu7fJ7+TrvXOtezAz4n9s7n8vUwxze32sUkTplAbZS?=
 =?us-ascii?Q?4upvtSXVboklSvM+WcFF+HCCwNfRZbr4j3eM7ADpfinpD5ysht+kkjo+3/Lj?=
 =?us-ascii?Q?vHiuc8fubB9VksWKGET8CochGPjkqDNn9QLwMNAtN2du+PfFHgF6vTCPHREV?=
 =?us-ascii?Q?jsydTJgVtPVvHDFWNyMolBWyVrCCvZ9Nh50wSJCdtjiHNSJfQnYICWsF0POm?=
 =?us-ascii?Q?IAoky+gTK2ToW3COOQC825rv2TAquB49KzvUv5LuRLm1QCQ76Wq2N6bTfVfm?=
 =?us-ascii?Q?I5hwCcfhggDLW33ewQ/5x1DoBMPXnJMiVhIbvsq/BdS33FwrFqO6jBXRoOce?=
 =?us-ascii?Q?HeFJ2dxGnJKd6X09Ko2S0/Sjx6Wngnot0x36GVdwr+v1cgtMn9fTRWTU/Ajx?=
 =?us-ascii?Q?q5OdviEqcnWhToKwbAENNxRoa2iPkd4idpU2801xXsvdxLTfsTpi5oyYMXeO?=
 =?us-ascii?Q?iLQhd/SK9hWC6C8RlOGt6OoYWrGlk0cBBAJaVv1WNW0x/nW/P18nbQVkbc6n?=
 =?us-ascii?Q?h801UGJdqG0eHcu88uos/8g+/dgF1A3D3t4Akf6l21bmZn1WoujBxjIjwkk6?=
 =?us-ascii?Q?Xyy5ctWCu8FF7JoUypBP1M+LWyjrod+1ICzaa93wOOCrSjCcgRBy5yrpv2ud?=
 =?us-ascii?Q?hmioro7AvRwLYmsvGKvIhNfCUR21Wa7uVyrH4O2ES+4ja2ZUr9MpEiSmHC5J?=
 =?us-ascii?Q?BNkiIX4pGS0BV6iRdx22ROD3jzE3PxV0siJjkUZ4L/GaA/TGWTYNMIgZ4Uij?=
 =?us-ascii?Q?Nwa6tLvDq5SS8AUfLt5sihf9XzG5auKCh0I1Uk6pNCrmA3XymV5Bo24KkLKS?=
 =?us-ascii?Q?sRGjpFX6fdVSqM4XXo/4//+QBhlV+d0dBBtyt2Bm0t+cLI0kM0yvu/uJA212?=
 =?us-ascii?Q?QAtcoLwP59YPKlLieC9RwUo86894ObSU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/lLAxXyLtCed0abY2WWXM7XUJYHgiRLCljA4rUyW0gyqSXgaEjUjUXLLOPK?=
 =?us-ascii?Q?HvMpTVE5ofjuE5MHyv+IfpWmvneWIXIywqWfouuT/WT1vl6fy7rtHvTBaczT?=
 =?us-ascii?Q?OIXKson38Z1DE9EoOwIt/Jq+CCIVEP+Vtpbcqy6D9IerBe9l45R/qoCIyrxa?=
 =?us-ascii?Q?zi4PCUwgmzAbAHJU8But/F39J0KBodrG6MqSB1tZ/n/oU7IesoxU4d7GpWKz?=
 =?us-ascii?Q?ixyz/4kdTTZor4Wk2kKYBZFKHbglSFiD23EZKngy5ucZUkuAVKA/A5R1yrGT?=
 =?us-ascii?Q?BqcGb9bn9yYzAp+B+WVP7ZrfvNVPrrcpAumMCmlR4ykbrIXSIHy6ekw2ifWj?=
 =?us-ascii?Q?Jq8EXO4gv+r8k1BqrTAnTpYYP0CmPAJcreav4Wfb25SUiEMtPwQ4tJUSkQ6e?=
 =?us-ascii?Q?5PXdmn911N704XXQZ2/4ja0jO935quZPbxhzW23dfjoUYWUxgC5MXJbld65E?=
 =?us-ascii?Q?7omtK9bdGcUIZQq4w0E3DEGMRnpNxWsNvMHPdWymkvsEkePY5xu3EdWomYrG?=
 =?us-ascii?Q?pfMiweM6I+kvi0Y8IqdouEegOHCoRGe1mrYjSO9Lk2jm/dxu1fkrV73OMswN?=
 =?us-ascii?Q?etE3fBLW/CQxGj+W4zLIW4YyKxxCr8C2KBwP2Fv9ERssY8F0xIg2V2gUuaYu?=
 =?us-ascii?Q?/JG8jYA7qXIkJ3m160BHtVwYHE1KyPfXbzXNNs4O1FLo5/8L1grROtFURzJK?=
 =?us-ascii?Q?8SJqaUf8iUV4+T9bcYUT2NGFndfD92ZLluJKRkKZRgGxhidF0BYXStyf1mF5?=
 =?us-ascii?Q?xviT96/NzsyltgG0KKfQQhEpGfzc+vVbSmnAS5u0MwjD15lxaj7qzdUgIKM0?=
 =?us-ascii?Q?3YixHEvndN8q82EeyKxim+/NaGKNGZ1lZeCOBUWAb9Mqm4JHAQ4At4oVVGQH?=
 =?us-ascii?Q?dtEtVyyEMkNEFJ/Xh6J1fRsgP1XihwmrvBXOMW4cNk3cEZ7EwM5PAVcPXQsI?=
 =?us-ascii?Q?K/nDYasR1WL9YRdW4upA4kmGl0akk+nFrIHnZnCePxsgMFJQIG0bo+LeVcJx?=
 =?us-ascii?Q?MERIQHY9FNsrgZ8eXhjQTdGAN53mJCycDj97NSoDnv5MgcvEIpAQD0EMM21M?=
 =?us-ascii?Q?AL5PwJoJ+J90htcImxrhL8I5yoY5UTASyGe5UYv8vOG2/htIxnr+FKV5bV1I?=
 =?us-ascii?Q?APVReh+3MgqoCMO7dhVJLskL4LSxV+J3+PSlxc1fvRIqHDsyWcRd5oABbStb?=
 =?us-ascii?Q?bRyB30pGDR381hup2WEYEDWDgBrlrNItnzmN1uQFAHQT4AalwuHKiV++RFov?=
 =?us-ascii?Q?6/ogWegtAmPHBeHj54Nc9zncwtBUJLZe4zgiX6HPwhj1G5rTsel5Bn9ZLvGq?=
 =?us-ascii?Q?ZLC6/m0osLq+gO7UK0ztI10xvFDWDxxtnuLnFT7vHT5YA/q8QHV4mDTf9mvl?=
 =?us-ascii?Q?qU6KFWMXqb4Vf8EPj+R6r6+SAg18+4nLCfbgul6u9c7JhMNeL+97gHIDZgFe?=
 =?us-ascii?Q?IuoKjSkJlL+B1H6LhIwDtct9qV/RDeMFfgCHYhNmLgyrMuCjx2lS92nnNIFk?=
 =?us-ascii?Q?ELdvE7hf5AX3PNXsgMoEXLUNrUGJEt72JV2RVyumstG7aivx7f2aZoKPZW7s?=
 =?us-ascii?Q?23rdYwecPF2ADRnXviFt7JSAGgdNEdVAYONfd4bL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JO/ALw0myKiE0EOJI9RFbcZtKIITjekFopLS2/Med6+YMFEOIj9MBel6OMcVuNT1gY5fhr6u5NsN8mg42RqaCe5q9RkNbh4/fep5auW8Tav6SBCflifRQmJLnckPGmFgYmyjtguABgAf22Tc+2jaLhnxSnB7fFVA8RjGTFmHcfT2GleJE3Hv5UD2MtOXqtV+9S9hrxMNmVLbmKQreg1RDFCu59MK6yl+Mndowt62d5zegKnjgkMhzryvzMjj7H0J/Zhf2RvAZ+o75wwTD04Da0fpf6GURWNyvsX7G1BeLb0MwU2vVI8w7mxKCQsVK+CyB9GVHAQ23F13xZzk8CRf46af+qimbq3+txWmzz54pQs2QOjZyG770a/S9YHExMQNtoClnxivhZyR2L/nknenGl4dJBrGj7HajKJynsy1zGJsZMKGH5c5q9O1trSAM9mmb/AY7SnnfGvmi81/XPnu6N/1WXsYpxAFJOKrvvdra4ud9dCWLXlfiw0sNYswWo4ZiYRwDB/2pVavLIkq9n8QiUMzGT2keeJne/V9kCtOBWZlEDJxp60JQLDqK1w5FSG7nLk5IQPklUs+WxOs4m7kbfarcCQ1WVndf1f80lhDt8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d44ffbc-1dfa-42be-4d51-08ddef655e7a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:54:41.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AFdeSiM1V10XY5GTTyx8CA+tTDWTD7CJL8i54Ciks9sH7jAbGVSYFfkR9zmG6bBCDSqlPQ8Wia0XkdANyDSXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090056
X-Proofpoint-GUID: 9xhgeVuqIccLRZUaNzSrbRAwkSxXIJqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX2s7xGv198OPE
 5fEWtFt1wuxK+a4F33hAr4UQMLugP8wi/5up/qwR7HOUxYGxQeaW0BJ0/Fj4gA0KLoVu1y16isl
 5h3KMt69M1Sah9tJnR+8gSPnW9rXcpy2/a3TBdDn+bkeGcN9kbT669RKdNIZMC6Q5Z6wUyIedYV
 FhjnaOlTC+mlTM/Ud2qdJqNcXTgLZIJJhzilKTG3sRrDVLgbCVfrla/sMyvol7AZ+Q8ZjuDuowL
 d4m+vcKdx8rX6wdfom2EncJ5SOJRNHIDqriNJzXE8T6sd9bflH/Fk/7j7N0On3ouFGAFeiGbWPX
 QSg95lkC7tvPT5p951Cn8x4svkBsGzqnCqgsom48KceUvANid/ouXHZxggbPTe7hTB362w+DSba
 mFWMOUF5
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68bfc126 b=1 cx=c_pps
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
X-Proofpoint-ORIG-GUID: 9xhgeVuqIccLRZUaNzSrbRAwkSxXIJqx

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
index 1ba6e32909f8..d2ae79f7c552 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1699,8 +1699,8 @@ static inline int pmd_protnone(pmd_t pmd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1833,10 +1833,11 @@ static inline bool arch_has_pfn_modify_check(void)
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
index ac607c306292..d1810e624cfc 100644
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
 
@@ -203,7 +203,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -224,7 +224,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -263,10 +263,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
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
@@ -285,7 +285,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index da21680ff294..fb0307723da6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3129,7 +3129,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3157,7 +3157,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!p4d)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -3165,7 +3165,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!pud)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c0388b2e959d..a76b648fc906 100644
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
@@ -230,7 +230,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -242,7 +242,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
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


