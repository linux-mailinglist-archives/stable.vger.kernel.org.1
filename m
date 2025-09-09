Return-Path: <stable+bounces-179092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3FB4FF1C
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053953B1D1F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96701340D84;
	Tue,  9 Sep 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hrEwyn3z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q+jp4dwd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000A2EDD52
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427393; cv=fail; b=uuNsNLbwpGC3OLJvnKQtjoGY3iyufFu3qV3DO8mzWBNNgElCWMOZp/zpozuW3E4UdpUR0LmgrnF+SmTRIr8fiALkji8Ax0kdC+obsiZeKy5yzjEt6zOUPYvuZ/B6MeMNpm9ShEQNoRhmU+lk4ZsA9UnnECKBY7Lz+10sB6G7E2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427393; c=relaxed/simple;
	bh=OD37rf7eb9+59aP5b0b+A9gKrtbfW9BlgqcirkxdNYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLKuFuXH0DTtQmyNhYyvm4SEJ/z5Lib4OKgSlqb8WnVJx69eSZeuPsqU13j1cFkKEi0k4OPgQhZZQsqQFn7vW4qLFjWduFCwFZ+uSNs47f62GvWqliFm3TqF4MvS/LUAw3UibPVWyMtNBRRAi+5V4yfS8Lmdk5I2rsvL/O64Zns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hrEwyn3z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q+jp4dwd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPEPr019213;
	Tue, 9 Sep 2025 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I7bsJk9ed7Co7O9/ufThJCpehGnAtoRl0y0/6/hqO48=; b=
	hrEwyn3zHwAvaaPr4nXWr9rBb4cOd8+23PYBo19Nz+6czLCMNv8Zd8cRSjTiBywF
	aVCl1SZISWFBWwqcgACS9xp7tYkRKeNX02dK/NUNs3oLuSk+MBjAG15DOgJtrnlC
	afSADIXQaOA8I+qqbOzJ4XnkYchrHfPzNagLXBZ4aap6sZPQLsrjRTiN5nKI0W/7
	LLWv54O7rGADYdRIGEhssU0UlZ6BmDPv/bvZuQQVf/MVkuV8hMTcrPYVig0rwBa9
	d9kURjCO0Gu8PEwONnnhHTTU2IF4iTXauZJZIZ5Ps6+zoACv06r5/e62F7voJg5X
	l3Itql/GpNkMeXHADSajYQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x91xxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:15:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589E8N4j032845;
	Tue, 9 Sep 2025 14:15:29 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdanvqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:15:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjvYaw3LFpl3dr9+Yuuis8W4y1v0bYENAYX/fYMg+ngqMhFOp/cFRxKV5mn0xJ7IkBAyMlEUVvHoyrD7hTn/1Y+l2DjrvnqufgY++Kp3h6MnmeI6ciGp2rU5zW9W/gtZiBMI3iXLnJrJFyPtDHKDCyjSeWYPoRYRJfkn2fnAg5Oq5z5kGlVGeGWfdT6j4gaZI8YqCsAoztMyOaQcWbEoGbVXc+8awVv4I2fFruXQasdkZF9Gh4d+qKUF7AaXzVO6hdrCFquQe7zGLZyGTfdHMUE83YNYfBDT7t/CgV62a93uiY3ORPnAeNObvxWePP6BA0pqkc6eWVYiE6VXfk2PDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7bsJk9ed7Co7O9/ufThJCpehGnAtoRl0y0/6/hqO48=;
 b=ei7OBWLDmnOZgqDiIFYRMGjg4/EW8ti4lt21z0zAkc+pOtSPSjvWQblv4hb29XuI7djYZm1xnWZ/5LWtvK6N0ap7ecD5JFG5B1+6ZQSuM5rz3yl1dmumDAI7VhCG6/QU5wOQv+lQjy1BIYp3xRrZT0LBlgQa2/MLaYe8YMitJdCkMsZWF5UrfW4QBFjcnGYq+XVGj9glkdN+5jJXRusAvqTYYBRXyJZ2wGT3gvrpZR0vr2L1HyS2vx/KiLgZcGqlQJjHZ/0iZ11ggbMontDQTVKqYsTZj33ZqVeaH/xY81uIrINvHGhGru8k5qrGBGQFwrtOvVFqycGJkIUUkzQFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7bsJk9ed7Co7O9/ufThJCpehGnAtoRl0y0/6/hqO48=;
 b=Q+jp4dwd9yewDDqnTrHassywXHC5Igl8ZQO7TN+4f/61snpuEMsF9jAPcHCrcESGwYGFvAoa2PmqaKhgf48s79pagWBBjWliYCMW03iydOi8tHsPTgU09cGE98uBkXxnBFzNwVZzXM7OkLNyriGQM64TY/B0rRes+eXrq2WaNzs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF9AA7322D8.namprd10.prod.outlook.com (2603:10b6:f:fc00::c39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:15:23 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:15:23 +0000
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
Subject: [PATCH V3 6.12.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 23:15:06 +0900
Message-ID: <20250909141506.57528-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090602-bullwhip-runner-63fe@gregkh>
References: <2025090602-bullwhip-runner-63fe@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0149.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF9AA7322D8:EE_
X-MS-Office365-Filtering-Correlation-Id: e448b43f-8e09-4876-a803-08ddefab5115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7whpvuF5JRArUNeOv8Z5z+9PY1VUmHvFFK4vfH1Mqlpuosxn0lnyMsSJLpL?=
 =?us-ascii?Q?jAzjXHswVttlx4EVdANSkaCNg0m35CEMZbN+vnzl/5neeEPVl190WXqTEtOG?=
 =?us-ascii?Q?QcVfuSDuk7nG1Y3EfBy/Odiyft18Ul4ivwK2lX67neKK/utgsRCAFt5LHkAD?=
 =?us-ascii?Q?S++rA5SRjk9zDndTaPAgEcvp9ubHQjfyO4UJOjnC/Z2Y630Y0AOCBMAkkqYL?=
 =?us-ascii?Q?IVTdbS5YH1r4PPfDGzOE9o5gTSENAAGnQMSu9uj5QlEikEBNay+DcDQrgKll?=
 =?us-ascii?Q?klRbpBzpMWdiZwCgezwD96y7GsHGftlwgHSzME0pxNjqhvWXWueigOblPxbY?=
 =?us-ascii?Q?YpYpkiOSgLVqP+jATDC9QIuszgIHU5QttchSmjM+CmlvZsxFvQ2nbcrOK/hM?=
 =?us-ascii?Q?tV88r2LsxUsjdOXWuYK1wJez9uSj4kRIwU2y4U9TwTL3h0dzH8yuqB7mtEv6?=
 =?us-ascii?Q?v901Uf923zR15NVv0nQ3RTbfaaKZ4Jv0t1uwLsSS1IN7BOwtWZENv2ZwdNqs?=
 =?us-ascii?Q?A0uyKARrBSPuSwZTLNjry/U6P/A/DnKmG++G8xbQzaVn8uF5TBpQ6XSY695+?=
 =?us-ascii?Q?5EMm70dc6Avw64jmsAiIvtQ7lGh42vN2E3jU2ku7dXy5iial9SCmA5M1vGtn?=
 =?us-ascii?Q?YcP9dJADwbuwpfezm26FdkJPgzZpiIFKTqQhbQKv3LCyHDVxn/eRMZnjAyRv?=
 =?us-ascii?Q?pC9ppdujNSx85ow7h0iJf6a7J8YXbTjtL43oNvmPVZtG5SVIvNwgDNS6JRMf?=
 =?us-ascii?Q?nGLuV6xr0odHJ5d6WlGBSjWsuFdqJ5amiuFTj3PrjV1DLDKvZy/se0gqWKpO?=
 =?us-ascii?Q?4QC4KSUzvGEBbErqMIwiTko7Rm8uw/6/RmB9oZ7PtG2/wD+3NW5sQ+xOStMM?=
 =?us-ascii?Q?JNRFY7aAtrzz5LWY7OEIq6Cc+5HpU9Zlm4xxGoKAXw4F7VD+slb0eOosDGrf?=
 =?us-ascii?Q?XaOAZCe+srQCLRWrO3EtB6OVQTp1xtIQwG57Cipv/JMaUyn6W/w/1NKqRnLw?=
 =?us-ascii?Q?ZGqgbHxZD/Xg6q+naBYQlS1zLyA9HpOFSY1XxaEE/10gjoBBaC2HbKZWs5aK?=
 =?us-ascii?Q?OgEofkhBObAH8uimQApHMbUlsoKie79F+k8v/mTmnvAaneGIhhNmsgRJ12xN?=
 =?us-ascii?Q?Qix+XIIUx/LthxWldMqu5TViXFXvqqxVceQt06N0f9N8TLHe4DLvRmxnXO+M?=
 =?us-ascii?Q?xnu4FVrvNZJ2teqeQipdI4xNzuSfIV2I5HreSznKlSwHq+BspSCZCGjya9D/?=
 =?us-ascii?Q?G9zkXgC17F+Bs2T+7Xu0+owTB6a2HtV1/iHrsu/UgCULhtQibQHSw4ItIOOx?=
 =?us-ascii?Q?DenlVrwMJR1LFAxY54HXLbo6Zi8WbZt094fdYQJQoPesWEa76FbkkizBWRV+?=
 =?us-ascii?Q?KScmMi+3oaTLskhN6aLJaxNqU6tZff6/1FdnpOS+rYnZXkZP6Nw+QIL3kfA6?=
 =?us-ascii?Q?Onv8djLF3Ti8cHN4XPfRnHmBZm006F/+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhTKypxQODv0EI9gzqMnCqKtqETRB4XNbW4vcxeUl8XVasJgbpPH8cE3LyL7?=
 =?us-ascii?Q?nrxCrVjJzrQoqcfZuoDLnsWwCTb0Vn5aWJ17DVl+hqa006HHJpH2u0bs0vbN?=
 =?us-ascii?Q?1s8NY4yyOhpO23+YlVXQEU+upiiQJBBK/VG59h/eKVQb94r1OA0BGBeg7+Ai?=
 =?us-ascii?Q?ZOPH5SDoJUcKLo07pbpOfCfxZR/yG15csf9mGiOdeKWYXwsIjPShkFJ/abkU?=
 =?us-ascii?Q?qC1qaF3nc6AC8p1+S0t3hpQMBo5w/Oe8zjO8C90XL1oDx8MOPPspY1M+V2UH?=
 =?us-ascii?Q?I6JNImD1OOI8Uhmk3TmXcjStPVezLVhhOjcdKv0pVV0UG5FFF5ojumEwze6q?=
 =?us-ascii?Q?PqaOeMZ2+Hpnqw+ZIrSPF3VUlpjahOUQJB3Cd72akr2TI+ck0qHlM/rqvJIB?=
 =?us-ascii?Q?CMXJLniFS7v2xByvw3m8a1gjxpJZagXwI2s5ITGgJa7hCI7qUEn198SwpDOc?=
 =?us-ascii?Q?ruQ/xdW/S35Ss8+XifUN5/VrPtay+0p4TNuxpHT7aEYDyllKW1lqn3ebVJwK?=
 =?us-ascii?Q?UEGVmyOoCEY7XcGG+EJZsZTOaQkpSd9Sys9lxgGfHC1i3yHbLewgg0TAI4IU?=
 =?us-ascii?Q?7+ovfuSNcWlNMw9OmU1LZDmtSEuss4BOROqm6uySlE2N/TrElQSQ4s7drsOt?=
 =?us-ascii?Q?VXNFVOlZFczu55YqSW3Y3bMOgEpaBvXYnQt1f5PPPtX8AGIWzBEBonmYAlja?=
 =?us-ascii?Q?2UUJyo7Jni6aZV2jz0NUijBNWeYvc8FeDqKM4kdrn+tJ7xZu7DkgKfZDUrPL?=
 =?us-ascii?Q?lI/GLngZdxzIdW1T9rqShUXNFx7MZiUOhi3lG3pjU5dpHX5LOoITlz6xKIb+?=
 =?us-ascii?Q?Z77FUdm2A/JkH1z3iLQz6X6g0VGsPuJku2s1V1fjWPlH74Tsg0vHmdsKb8nQ?=
 =?us-ascii?Q?l+i/MoIkKAdDgyjmeC3DTaNATrGw1OeZu2nfLO/JA1wf9XqshipNjJgkv6le?=
 =?us-ascii?Q?8n/aJZ1tc60rTvq8f666LqTgmOBlKupsmcw6mFPpxWfNKd8rXOPrI1flRTPn?=
 =?us-ascii?Q?W2Zcyo34THDUyrRljFNfa+Usoz2mMK5/XwDT6NMbm7IVi0caoXcYEMnVm0Xx?=
 =?us-ascii?Q?wdk3Mvifb2pBCXD79tA7qhYcW0IbzKJnbPXRD2gpdO5eiOavLc4j+XSmY3j+?=
 =?us-ascii?Q?M5Rx4DcfqwDBrYtxBukbIFPS5JJcHyF2sSbTuC5/LNaW7WxjxKQkQuqmNC/u?=
 =?us-ascii?Q?xwyfm8W8q0MoYB/mT/ZoZWzyIYpenlV8DElWQZamDl/K+0Zh+XG8+uJFtX8u?=
 =?us-ascii?Q?Fz8E/kEwzeV8CVhXvuR5KQ3pGtxycJ2+AMDUwOMl9XaLafOC9MRzPDFNjbdr?=
 =?us-ascii?Q?MiHUUBq23x2oQKdTUpWTh14lmR+VMK36GY00JiYn/P4mBmrnWjgt6BtidkGW?=
 =?us-ascii?Q?JAwwfh5dgSocvKrqz32mqyE7CrLTvcrtE3cl6jTQihS3/XLz2umJevBLW9qE?=
 =?us-ascii?Q?0JW1RXDTJe64EpC0ERYmArSF0fYMAfrN+zSyx/FyUhl9fhe0SolrBk20Wvnq?=
 =?us-ascii?Q?0kSsb1r17Q/DTXTbXjYcaOR9JmGQomEIad1E9BgnQiOd4qxmXWpdiZpYdaMg?=
 =?us-ascii?Q?QmqJDgDfwQMHAgCmw6fsxgy57hX3nRVwU25MGogM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	36vi7yR+q87iHrmNPLKW3hKJrkrULYsZg9fEzc+9HGT5wfS7pBoI51X/SepWdnAf0CdS47Y4YKD67YykKy6buwuL0G9qJaAgt2DEdahs5ve0CO4hdCTIXNkGDgriEN5DRIGbrI5sKOdfr2rfJeIO6fm6d110Kuk2ZZZUHaj3/7zRatdkc8OIEndzQMzxrAFz81gJMIqVuUHvgwquvG3nWGk8lNdRY8zv9FO2gaTK31cq9pendP5tzci0+/IUXHqp/MWbgy2VcRAKNWgv2P3KgG0FztXBC2dXmUdRxhy94ryHboB7+ItZLxZQITNnQhrTi9xGHjbUQFSjcrWqhLUJJK6F13umo+M2IJcdsHEqWY7cPDeNYD+0RlsEswB5a2JYYzn6xc5uU4GSWSJSx0UsgykGWqOvc4q/57feFUzkP/tVQLC90a0SltfQewLp7nee6GohsEeON8SjndCQ9O+UkuKRAWLR1cARq1LCANEEIWom+wgNOpo6jfqTDcJHRwwQDm+HyDsed6qb5bnj1bf5dBnzwWv8cf1Cq/JTe80zNkz/5mtoXwWJOtfopdnApylRF+6E9mi6TTUtVPqHBtXnZj5kpNJ88reTmX11hCl0670=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e448b43f-8e09-4876-a803-08ddefab5115
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:15:23.7529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFg3lK8WdU22zf1E3DjmpvIgicJ8tajBTnFsv2G0SmCvRSPz8omYsSGT0whR+9C0X/nmjAB3ApA3xH/EnfOAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9AA7322D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXx5H7cUpAodBW
 1OI0qQH6tvgFLio4MBwtT4dwqv3+fT8G/GYacBLVQIw4QAtTibiupB2mkpt7e4dhHr8nY9IImPG
 KJB1mFC2ObKm5jKixy7AJ3kop8YXMVLwZAOKztmtBgCoN4bDF63ri+ZjH2puQw+pVjjf5JcuPcY
 mvurWssSgRz8tF7l4Jwr8k+h9mK8S6eLDceerMb56S3ethsRUlkd4NYU/5ONyM9U8OobenrPtXX
 VVxkgW3Gp/gv75edY/xA8OQtVYfVb2+2s21FSRhAxmJ3B6uMk3+XAhPu6NJXSKgiDlLTBNJnb7k
 8WzzIpdqfacc5By0uXvKk4ROJ4Ryh6cIfdsrojVxariYP2MubdR8A38AANmTBaFOC+GuSkeOuHr
 Shu+t1CK
X-Proofpoint-GUID: N6h8LzoMQpK33Q_Gt53Q2EUaXaG4FKos
X-Proofpoint-ORIG-GUID: N6h8LzoMQpK33Q_Gt53Q2EUaXaG4FKos
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c03681 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
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


