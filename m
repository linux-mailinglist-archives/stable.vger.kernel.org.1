Return-Path: <stable+bounces-179095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93CB4FF62
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE134E06CA
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C0343D9E;
	Tue,  9 Sep 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="quOTeYl7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C0SlXSI7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D92FF679
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428117; cv=fail; b=tgZicuVb5EGUrkpHwxzF/VXkP3bTDR8uJlbXyXFtBJQ4+Emtib0eJlqMnsyRLp2lr3WlRPk6IOrednpc5VK+hFYcKhJEWu5XM9COFnSNqBoS1+qhaDZHZxvSZPvI804kr/dF7Q7F9aaBVWv2nsXIYsl4Ng6JpMbXY6IAqpKUQiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428117; c=relaxed/simple;
	bh=CtMq/r5OuMBj0VUPi9ftQAGC7e+EYiezOo9DBEisYus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iMonXT7/ysB1LG0BKowRQBOVB+7IdHxXxg4eBgAIGTrtY6D4gcLEReIGH71WMyE8MjIoiJwk57Djhg3r92Gokt1Mz6XSv+gBG3RknBlfA8LZHUBUSppO2ivkt0n8Z6qwjd4qEOzQstvIduRgIbygK7uQ7bY4ocOMftZcAkLBNgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=quOTeYl7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C0SlXSI7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CQ3eW024356;
	Tue, 9 Sep 2025 14:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M0m8BDo2bCr0ni1BfW+7YHfj/4IG0lOP4X3jIacJN7M=; b=
	quOTeYl72zUUsUCZtFhpULZkYVakGhqPI8lbrX0XAJdyzz/OJMLjqLFHd850knIl
	RGV0nev6CkaE9fT1IuLYRuKQhL+J9eNQep1Q6BkiHGplS5Fkj1oY0m9VUKqDQq6e
	QP6hMbHTgAFf8qLE0beLSJmg5dhGj0jqdCh8xEbQ068vNB9Elzg9JzRuLvQ8FZn6
	Ir5TnEXtqRnzTgQD6sz0zNuxQtl4Tq+LsYjS4P9ND0R6VpBfIPPOepUu5Xe+PY0R
	zTtyFDKDJGISbjxunSOaRnDuV/e1LCViRfPRsko2gxm1NzShaBi9S0RuiP1a4/EH
	sgccPfFmhwcrUnfGhL1eVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgt1bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:27:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589DjAgb013398;
	Tue, 9 Sep 2025 14:27:38 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9wk62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0Rr8SEe1fjh8yuzH/k9W0wboAGXUv+J8vZc1YAUNdiM7b5LRZdPODOfCCUuegbHkihXGwy5Z9CrqRzQ+0dv788ovK8By1BMuTWbytilJqxZiXFaxPZrBDyeIJ8uwuQmSrOf9JZ6xVb4MlOKa+oBhxl+BwaeT7Oeuf9QyZNz1GKOxl0G+hnu3T+jfU5w43hJYPaub6xP0S3Hv+SH8oca+TyQZLIkEPUE/ZVG2bZAfe3Ip2hpnW3ehoIC4ttbuJq5tAzChxXZZwTL7akBx7YaJyPhvwyDOFsDpK1VRypeVMsdlhOs12nApnMDKjmn2cizBpcNG4qJFHjHuJCIQVizuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0m8BDo2bCr0ni1BfW+7YHfj/4IG0lOP4X3jIacJN7M=;
 b=wrspVoG8oiIoVpClbIMBASYmY81GoQdw2zfQISvpKbreCIq/Vyya7PA91r1xghBPSm22yaZyOixGKy0pMKRIKONBECnOO29gShMysUksSBTmufr9HrqlgV7FsW6QzWEeUpcqhoXqQIqTGwpRqXsf7jjuDizIQLxtmU0UZcmAtfIxYj1RZQZbb8MAfjsoNBnPb6ncvT6XLGFiJ+MaMUGOrRhh49V+z0y3HqbT7WJ5Gvmuj57TJCqUrgcaVqKjSb5vgDgcLBq4LnpGOVH78/TSAk8lxd7oX+r2tSJA79uSj9hjYuInepXexYXjw1tb/8AjXWVe6WUGDlmDAVct27S/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0m8BDo2bCr0ni1BfW+7YHfj/4IG0lOP4X3jIacJN7M=;
 b=C0SlXSI7O1izPgLOSYpWFO1v+HMXIwLcSfAn7DdaYCc5UwruY8XxobMRZRy1kgESxxBQcBk64ZGg6/nDoGpqFm0idUjJb+PevQTfSY+kiyWZ3Jt796JCDXemnpqkNdUwyfqfUBtRbfAy9hngAXKtbxj1y4RaK0cBOrGZxT6kOY8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB7980.namprd10.prod.outlook.com (2603:10b6:8:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:27:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:27:32 +0000
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
Subject: [PATCH V3 6.6.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 23:27:22 +0900
Message-ID: <20250909142722.101790-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090604-obnoxious-bronco-1690@gregkh>
References: <2025090604-obnoxious-bronco-1690@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0138.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3588f96e-ccc8-4024-f83b-08ddefad0358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ph5g/D/nYrpCq75Kcpk61gJo75W0gaYe9QhedKSh8MumwQ9IoVVcHM3T5XOs?=
 =?us-ascii?Q?wZ0AJqiA+Xsqpqgpasm9jxOAP1Bl6RGr420oLcv63LIFQAndZDbjHJgwWoVO?=
 =?us-ascii?Q?FIx+yIl7YaN3IvXpapTkx0Y8WNfCwT8VxNZALkgfkUPWocznwVGFynw00vsS?=
 =?us-ascii?Q?gkNK83Ernfkyn1mul5vE0lh61TOvKEu8hVUeUlEdW0qyDHUO/rv3Ve8uUVx4?=
 =?us-ascii?Q?stJPvRU26kZMwmkiQ+2iPJVW50r0RpUuoflx6EV1oiJkdkOG9muOUxFYedcF?=
 =?us-ascii?Q?PjKIcwjy8mS8ycbq0Imnsuwdj2Jp4eKsiCD92GNzaQ7vgacSRJytHvwmKSVe?=
 =?us-ascii?Q?+R6vbdnYKasXEvfQE/3/gmfLrqgulIXx+/u6Z6yqU/w5L2loX+3kjZG8dy0Q?=
 =?us-ascii?Q?YrFH8bsCOnLpyHlqRoYkr7rgOPpovy9opf7zIZTOdz6sW6IxAt5stIGxzBxu?=
 =?us-ascii?Q?APcn6ADniVpwae3aSWkff9fNPwgXBSSGah4609G/SWK2ci254fE5IJuOwJAg?=
 =?us-ascii?Q?vxjiN4tvC9ydX8vZL8joSCMKypI20gFWWNnhnW8sq7teZKgPtZ78XSMkT59Y?=
 =?us-ascii?Q?solS+eP86Tf8h/Yc77HznOhNvqNGhrKMXLV4p54rIkULnbEBiCYy6boFlQvs?=
 =?us-ascii?Q?C+rapjmyWyXK41N6hstp3xzGbVWryYa+HPPCspSpBeJTYfp3fz2yISPrXGyb?=
 =?us-ascii?Q?FfxBBcvW6zg6YndkUtoqDMdCqJYY528SgPNV/XznMwUBijSmh53KszWgahxY?=
 =?us-ascii?Q?/rXpY2zTM12mK4H63lALCoVKYxk8EPfITn99CGKLzjZ8yJ7lzrJLsF+uDtjY?=
 =?us-ascii?Q?LawJOUi5h3mU3C+SZ+b9l/XsPuAg0Urppt8bcO46EcnSuWjrYkzqWz3KEHSE?=
 =?us-ascii?Q?BfdHQ6m6I5ZdK07UQ8VFv0IjJglFl8JM09u7for7Odn1fGTw92bu2KRVE1Ju?=
 =?us-ascii?Q?r2c9kcRFhXDsGTn3mDxtoiPHSZwCP928ErXgIPgC5N1asCeOZUxrcD6zQxyx?=
 =?us-ascii?Q?wofZ/fRto5vzSgC8KYQcNPS+iQrER40pi08cqGltBv/KFvxfV+umKQin+BCR?=
 =?us-ascii?Q?2kMXoTJ2WvBgOst/Kw26GcvYX5cHbf24YfBlK+UiKnfjEkeIw3CrnidcxTHG?=
 =?us-ascii?Q?hcvXOF1nJrjQ/oNKsDQ3iyX6DwNB0y+3Ueo7ysfHtydKkVSAQGcPJO1XpzPV?=
 =?us-ascii?Q?Z7BziW/K/XEz2YEHBAauirOQCl9G7ySGPM3vhnviYdSUqKdS3I4rOMrYZgcR?=
 =?us-ascii?Q?ndlPDmGlhMMA7ng9MuVIeinCJIM4U2PLBSBIXL3zhTaKYP7/WpiHl5aKlbj7?=
 =?us-ascii?Q?Om7Qjku3ZQq0UNKEZNHfR/tw9gblQcloP2u6MnJ+4+nXGjIAEXYWWT9tuNVq?=
 =?us-ascii?Q?ORXFBBI110O3ULvgtuvUa4MXp2uiQF7bYEL5/nIRQ9cOJR9MSeiXBCd987sw?=
 =?us-ascii?Q?im7zWyFYa1DnGvAo49LKIRi1+c5H7oPk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?107VmYkBvuPQcJAHuvXLDFdq1+nxy73ewQfbYHBV9n228eXKrh0gSvJcIKws?=
 =?us-ascii?Q?kYNmNBjikk2iCWtppUrQgG4And6N/4ujaeI92D1DRjtALskC5zkCdVN+wpHW?=
 =?us-ascii?Q?qgekoiKjeNXAZTL4b0ZiD+eIThXieESWcKk9GOTdAlU4AwTcHTRWEz/CjCtX?=
 =?us-ascii?Q?PZVknZuckaY+n0ASpmGDi8pZMpdBtU+58S7olE7LSm8fSFSWAl4llH3A7ZFu?=
 =?us-ascii?Q?lUf5DKIZzeEuZLTMR6+HWFt4YNcLD/0kBPSq+fLhQM7c8Src88wieBtM2j2c?=
 =?us-ascii?Q?A3q0MNw/PDb6Ivq4N8/XWhTfgxxtYx2CiXr1OIeT4HwcJDb/6NHUSFMssRD1?=
 =?us-ascii?Q?GKaKcn2q9lcvXEWZmezKr2JE/6wjzBfn2NH/lN7ETswOB+xdyDIYRxv0iACO?=
 =?us-ascii?Q?Ia5wSs+X0fLESjTDzb5s8eI1J8dUf7zDD4I147bi5t7MhImy+ZyfBkFCEh85?=
 =?us-ascii?Q?viiuQu6bfRZGy3V2O9+cKt5nfcG5oQtGwdUB/5nD57FZK7jqe/B7HyLZhgqA?=
 =?us-ascii?Q?PG2wno920+8RbrMMYxtzHaMHw6DkE0oWXPKdPZzn3UYgAktQgGumpuFKhMBp?=
 =?us-ascii?Q?wir/RfzcY8k2J7ZWNeL806RN24KCs7voBjfG7iYkniboaPdWesjGQGQEHAmJ?=
 =?us-ascii?Q?9pSdq6yd9XsGejk7RjxABxEkll2YVtsWLCCuvlqVi1pFSsJsFGgpUYXef1i/?=
 =?us-ascii?Q?S1sbXLa+kQXXh9Se2zwZxzysiTsYLPe2NT2K+e0X1gvC65hJKvFZaVl65UNf?=
 =?us-ascii?Q?HSZlgmN6SEwDVmoP5emBKKXcwoquL0bOor+oNc8Sy2qfIO71A/HWQa7TvHPh?=
 =?us-ascii?Q?6znoPpSZMBZejYt46o0/UlGHT84cRMK3HxsW7juOL2MwJFU4gqx9NSFCXLJz?=
 =?us-ascii?Q?Pfl9o+CYr68Krhj0JpC4R79dFRd+UYsokh6SptUlK2ituns8Y2+0HweyJCVa?=
 =?us-ascii?Q?GnyrLPmfLyI02mrOR2LUmA9+1i0zgmkcmbRY9jPvqe8rxsOdp2lt8CmGIVi4?=
 =?us-ascii?Q?3XrZGDTUy4NYTUH6hmDkg+/dooqOWdc2m9WkKAlpMnjgkGetoVosde2q/Bab?=
 =?us-ascii?Q?Y+WTW7SBXVa8EodsSuNzIRBiPQoeuhgpb6dIQ4vmOgClISba4MK9fNDKzdAi?=
 =?us-ascii?Q?Y0SER+neAitd7qgeRqYA5t4v+2EiwdvbgvPATVhm9IAAF71E93GkCYhVgyEf?=
 =?us-ascii?Q?d6BRo6PH5bjl+rtzV2DhfxGkHujF66dshetJiKkJKdnNJmpSg6Mh+xVvftkq?=
 =?us-ascii?Q?shz+vTMltlp2JmGrCl7czo6SMP5B0CzitENowL6W3Dgous9UpJY+pBcNJFi0?=
 =?us-ascii?Q?N7Unsl5cu8RpSF/HRZK8kaEuWacTQQjow1KBn3GfoDvSMe6BMin4rGsIa7Ol?=
 =?us-ascii?Q?/28cKR7Z9v/qEQ3YRPkXSO6Ny12PJuuodYQC/87rBnFNBPoKeWTgumUD2rIv?=
 =?us-ascii?Q?MCqJYaGes2a7VMxtmU1PIUBE5AdiNd63UyikEQSufDmt6HNtwH7igva8ovaQ?=
 =?us-ascii?Q?94iiCCHWVub/LdQxAvJFlR3OzaQJrieBjnC9oHKgWtF221OciIRpUoNs2m4/?=
 =?us-ascii?Q?pacHFvf11UvXdfeCkDgVCHtnHGRoqI4obGxttV05?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yGWz/heLMRSQhqsziMSL3eiDJJq8PS1fsOQ3jllUQL73LxNMElSep2l0WDOLHUJ0N22KUvxbHRQHdBgksPEGgdkH5rDbpjXpZ8ndfzd+D22WJt2cWkpZ6EG3raXsf0RDCRqJ8l0E/lzVHYdpymHYU1u9Ho7GtrM1jcvlvWqoALe4cLIV3vE0hNY0iq0V8L25VBWjisScQXXgeetJlm0F2lmx7NVgYljlgRR3gu2GWsrPkJtEUqgtxpQqir6xs5O8hZ6oFDbbs12Z5gGsDZNxJuYcB19tbkNYP9aNuaOehEnF3BKLN1FsAXD8lZNXqESGiSRMxQ6ObmietYNkFa9Ddsn14bvNbEfIJcWUPZQKjqZzRLXRtgviqQGKBmczKTTJ4H85hQhWFuMjLXPdwhDKWFJJXPubMAXe3Vta9S2On4e1cDKJVbNsug4Gi2kKXL6lS8J2Xvi16Ca+6YmwaPthKB4ps8Yx3rJL94sbT+J8HZzIkTK2sGn7Vg5XP5WnBT8X5BighTefi+DTrMi4lOOEq4B93fUTQ7AMv7mb9bZtaRaiM/8Y4EuiIUxBl+zCEWlVRcJqM1CsdAZQp3vVs9BUjy4MyaJRZdnFsZGutCoI6eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3588f96e-ccc8-4024-f83b-08ddefad0358
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:27:32.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fTaGSnBSQ/OeF0SHobFJSvnGRFGyPHQqwdOA/8lSsSZOv4aomm87rlK/a3ypu+2qwgUlJW1hrLwTqJMYl3fDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090142
X-Proofpoint-ORIG-GUID: 07HgdhWvhjR1vgt5FuJiXmEfelMSHWTx
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c0395b b=1 cx=c_pps
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
X-Proofpoint-GUID: 07HgdhWvhjR1vgt5FuJiXmEfelMSHWTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX3NG2j/7H4Kt0
 FiWqBe6cq2wUHvE+yi5JLx6wR9cuZU6McTtOOYcwNlcOJ/CFMO/lFBOtmJw9jBeECICFZ7ZHVTe
 YZkHeglEoLMyKY3Y/pbolmS2lrgYr8JR1WFumhN3ssTzn55CyhB77DFlNtqd7qbA2MbPnT//pK4
 AZ78AyQDpsvQUfj538mXeLK1tLyIvbmouzjZSMT6Auyg3QJG9Z36t1zuSWURpjawtQGtlWo8XX2
 F05WOx7YPc/n/MxPKF+Kv/p426XIxv1omh7Hqq42pUPpQqEuDR6pX4kr4gYeyNnfstGG14JU+CZ
 yX5WR2BHXOYrRfcQFYIux0ZNvwWeXVpjjQilVNrcK+He+OLgQ/2IGDScn4jN5d8QyT5AK+iMOgO
 Tp+78B0Q

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
index e42388b6998b..78a518129e8f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1467,8 +1467,8 @@ static inline int pmd_protnone(pmd_t pmd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1601,10 +1601,11 @@ static inline bool arch_has_pfn_modify_check(void)
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
index 89895f38f722..afecc04b486a 100644
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
 
@@ -197,7 +197,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -218,7 +218,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -257,10 +257,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
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
@@ -279,7 +279,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index d287cebd58ca..38d5121c2b65 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3157,7 +3157,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3185,7 +3185,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		p4d = memblock_alloc(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
 		if (!p4d)
 			goto err_alloc;
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -3193,7 +3193,7 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 		pud = memblock_alloc(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
 		if (!pud)
 			goto err_alloc;
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..589d6a262b6d 100644
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
@@ -225,7 +225,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -237,7 +237,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
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


