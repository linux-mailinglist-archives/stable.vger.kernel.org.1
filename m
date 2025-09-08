Return-Path: <stable+bounces-178828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727FB4821E
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F203AFA26
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159C1A0BFD;
	Mon,  8 Sep 2025 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sf5Id/5R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sr49fbZs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA592110
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295180; cv=fail; b=fAPzqPp1gCCZjEkhL0oH0RB1ODSGDHGm7jv4KOWb0OYIRldRwP7gMUvfppIdzjS0uV4JmQrCJDVmB70dyJ5pglyYs2y3rzIW3N47d6tTLHk9dbYmsIyYxXUUZ2lJGFKq77yc2PRqn7vbhWafjhqG3YqEYozN7kuNON+iLUVXSxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295180; c=relaxed/simple;
	bh=DOZf+cHRrWpv99ZNSpudagNTihlR27cICEfaaaeanqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIo3ED/qtBWDP/csT24LWfVGsX59GmEKQOl9tmTDwpD7k7ds09/srZpKZvzIdQ9jT50XUrWTm4I46h5zyTQLfI0C3+erjupKOPjPYoQ4NDSWi2KCBvWgMMiidB5cIkKj3cg7lGP4zt9unc35+JVcDYJdqBTCXHa56eomt+i9cT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sf5Id/5R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sr49fbZs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5881UawG029166;
	Mon, 8 Sep 2025 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2ikCuCjQeiahZMwel/3am+cdWarW5y9zwmR9vUHo3Wg=; b=
	Sf5Id/5R0zBTUHO8/d2xWxcNSKUmouUZ9vT634yD22lBhYE1fFLC5HHWG40HwM/4
	iiRkUFP+hAg1C2KeTH3p3PYIFrn3tqzx1e+FjFaXDliK1/GuQMSckHZPJyJSiRfV
	msaL26FGcjtU4Aj1DS84e1Z1iP+OI17KQf3VR/17VGOFbZVUeA/Y5D1jCb2/JDtu
	1hEtAoIZAYd4Vudk67FL2g5am9ecpBJ5WLkwXWZYezxeSx+0eDW4mZPsyq8noUuW
	FmHPAJCPQOqhVTfgu//DISEHyhNinuLTbMc4OXCqKuUcpBpSLNgjLFC/GiSzyGc4
	qL1/wK0RRCrQ4YqrUC0QQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491nhb007n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 01:31:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5880IiX8026061;
	Mon, 8 Sep 2025 01:31:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd7hk54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 01:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5k1+V0McsuywYzQqCK8XI6i7ALYaK5E2Fh/e4/6YsRDnJmVO1UsrUQOmcKZqFVtYA229f3Xh53FzlO037ipcghyz6BP32kddKoMbxCDHh+ryCHl85mak/NSSsuBZrWZi9ivK3UcekncfOaXw7I2K4FCSBLxgoSvBpuImcmj42ViPiDleOrCAaZM8QwJe9O00sm47PgIg3MKnDpGVHZRlEL1KRMzopbKi/q2WrKe0q1fjPgi07nFpUoT0iFFHuNqKb/IScAW2mWk/CqEc/rsCWkPn/wAWoZYk6oCqWRzluTjwGSTOSOfGY/Es0q9Nc3NAqX3X4w1X30o6zi7wsCb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ikCuCjQeiahZMwel/3am+cdWarW5y9zwmR9vUHo3Wg=;
 b=Pf1wQJs6/XWHXqbDC2MscwMogKV21Rg5C6AAypC8fXlo44kvQTbdS5TVgXz7g5xFkgVYG/yznL4SwEgnDoH4ufKIix7Au+EBAXfGpXkvn+81AuFtX7hzRC5vkIxM7v44IHdwtxk9MuJtCVvxavqCBGqI0ZY0BCzV2Wg4wjQHueegAAP76mtlA9H36P9EVujS7fE42rrra3Tbza+aErimLopDsek0IY6MhlsLugf4kS08GYGefPsnDwbnNCCP8WJ4oQ+/tzAt19/D7je7pjT64jOgl45zGAxfbKsbLbPG7gYwZcqsAsbhlL4nuSX4ji3NscLs4j9WHhu1RRSrvyEK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ikCuCjQeiahZMwel/3am+cdWarW5y9zwmR9vUHo3Wg=;
 b=sr49fbZsFaYjZgmKbNPVJWuXh7FAZAndgXv3lUakEuHuyhTdkhaX8IZpmYoiSJp+tefLbGsCN1c7ORr/DSWJ46xLw2hHVKv+UDZ8LkF0tpxbiCDhmsI5kT6+N4UFjLdqa6MiJUHBuKJgqdVDT/C4yAZ0FJMLq9L134nU1bzgZ1k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7574.namprd10.prod.outlook.com (2603:10b6:610:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 01:31:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 01:31:21 +0000
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
Subject: [PATCH 6.6.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon,  8 Sep 2025 10:31:11 +0900
Message-ID: <20250908013111.5593-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090604-obnoxious-bronco-1690@gregkh>
References: <2025090604-obnoxious-bronco-1690@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0195.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::16) To IA1PR10MB7333.namprd10.prod.outlook.com
 (2603:10b6:208:3fa::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0a7087-4e8f-40b8-5b2d-08ddee7769ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7NFM/slPfd/3eyYk+ijbGXKAvugd30xXchvKH1f/2DtTOuc2PdM+78dfD5v?=
 =?us-ascii?Q?3J0cejQpPi4hEET1DzXMyTXUew5QIkvjN8rceNSWxMGP0R/PiLW/YZzRMaJD?=
 =?us-ascii?Q?oBC64nM6dqefJU7+znJ8w3TzTTcja4D8YvDy1P97GXIpanWXo7wtmZMv+JfX?=
 =?us-ascii?Q?4/I3M1BfrhaKuxAYFFdRge4GH2EDFuhJTCv4vkxjT7auREGOitb+9XRbR7nP?=
 =?us-ascii?Q?5MPY7FsmfgzTPcs0WmwbqKYRdL9vgojDwGqKTUH1DplKnh19IKhROPkSMQGA?=
 =?us-ascii?Q?5HtrQV6YIJsXdq8DNgP3NDn1uzggZLXbW3A/6lb3fczZE2QsRdtlUkg+cW/F?=
 =?us-ascii?Q?U+VNvrs2Cy97DLPWjw3fjoMMijYJtuA0UyUNfI42PD895SuYGZLIG53/j1+F?=
 =?us-ascii?Q?AfcSd6QLvZCINmsm0mgpP3Y52Yo6w+8Sf0hmhriBQjf2yOwAy5GBNyISO0RM?=
 =?us-ascii?Q?m0je48sx7OGmvXlSg1WesOmHjaT+pVmgZusqMwzp0RPZMk2zonEQ2dRJnKmD?=
 =?us-ascii?Q?RRPZDZ/KD+FaQzlA4h0RGBNWd/MksC4dAtgjJ8Hh87TyVL067VvoXr763zPj?=
 =?us-ascii?Q?TZ/Mn2ZwbEscUh0uRkERkSsNRwsBT/8txSilLAVFZmG8MFg6UJ6q/5a7e+I5?=
 =?us-ascii?Q?NLs5Aldz8yXygftIvLk01Y08h0bbyShdyB3SWRcvC2beS7s/7XXRMPtwWGSX?=
 =?us-ascii?Q?zrdlPNP1doi4vhCD2u0oMqCyKJzcmlS8pzAVd5X1oabvMx4AgH+LEUezdJBv?=
 =?us-ascii?Q?0oHIlgnC+8u39gtTKvFCZCEZFpD+oa64SdUnGGgqsyN4Jd7UiFuJrzJNN/v3?=
 =?us-ascii?Q?C4W9JFSl3R4lWOqKT0KJAkJ7wsRMWI0hkpuQoeYt5GTjB0Cqlx1BkAytq5dI?=
 =?us-ascii?Q?QO9q1yRYRW8o+0vzWL5B5vJiwZyyhMIULnr0Z4YZ/mWv4pIY06vXuJ1TMNDQ?=
 =?us-ascii?Q?uqZtYjpOfgezmvdM3C4dH1iUP9KZgQNEoibGJ2BjFFxUf/jpcFtTWwVmfg6z?=
 =?us-ascii?Q?vFGABIkYU4KG4We2c7PJdulI1Rcsn9gP4BBVerIHmBadcJR8ahvz8qsYoubl?=
 =?us-ascii?Q?OqDNKgEb9ImwTY90UP3TRmfG25Hcim+hUkRkyDPY6v+a/W9gZfjF3gmlEL4e?=
 =?us-ascii?Q?1DVPZJKQK/kySVM9U682HTE7XjBaYzAljAhDuv8yURveIZhAeQUhsXXDdIEy?=
 =?us-ascii?Q?5TcUDk1rQnklEmxo58HwBIIwKaiytL1vEZU20N2NdafsVaYjjQ3Y8uCR9rlv?=
 =?us-ascii?Q?von3Vu08ifpmPQKIA8d2s+voE+jEggJEmcrEVmPgmAeVoBYERripUNtQFZgy?=
 =?us-ascii?Q?dDNU0YaNwIac2FzSUf/cykGr4IOFak7viuHxn6UtblPn/229xA2rRzJnf2+8?=
 =?us-ascii?Q?8o5IEwHXoWUJ/f4+SkA6cUn+RyYOJA6IUy2GZ9yNsNUXuF92iUWnRe1orUrZ?=
 =?us-ascii?Q?JECA7BDC5wc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Fc8ogt8Es85p2LIDGEBxUdw1d7q172zsBQAU4xt5zEWzakFNcfj3xKKt4Ws?=
 =?us-ascii?Q?sVWVretx95YAruyx6UY0yoGnfJNFmvDt0z3XOeFNArjz+DQ/mEgpDR1gd+rB?=
 =?us-ascii?Q?9cbj2kfcZ4qAvinXdycD8btBqUGwXGV7lZMMvNHC+cZQT1HMtbRwywuSNQOr?=
 =?us-ascii?Q?JdOeEstc+DDzxqPoMhxqB4IIXc4jwo+hbvdMIIFXvE/aa566bnTckMBmzymU?=
 =?us-ascii?Q?yqNJg5HG7Lol0mUOTzyzrlY6AUcg+uSmW9xtmearUlkJ1XEW/N/irBW4q7XX?=
 =?us-ascii?Q?eXFFM3AyGzWK6axdR5eszO93HB1QMLam/uJ/lk47wkkB4hy3wQR9gqgXPU1e?=
 =?us-ascii?Q?Gy/fZHwjz/QyhSOtTWjgQp6I4ybzaJYXTHIdMuTKrjPjjVsuO/crQVw5l0F8?=
 =?us-ascii?Q?gD+4FQJmwGo111JFZGHFoHwsdLRexJJizh9RtKEHYqmYSf+6/e8iJVYEnVDt?=
 =?us-ascii?Q?fjmYD6JZLMGG9vbQfjzMY0LoSqpzoROJu1plotUdH4//mMys00F3kLS+3ebr?=
 =?us-ascii?Q?tyJJUwGurKAfYuycXAYd/KoYM7znfFCi6VWhCKVuPcinPR0uJ9uJ8LyPnJyj?=
 =?us-ascii?Q?2uWFRSM7OtgaUyiwF5Wjdew+FCWJsGO3u9tZx01X+e5vLJ13xYX44KH1wm56?=
 =?us-ascii?Q?QbGys12kccL4SvxI+0Sbi8h/Ym6tOvUIxDwwNU1b4a4OY+PeDrao4uwynQ1x?=
 =?us-ascii?Q?ukvgoKkwj9agufvDMdfZc97Dq2kJ0nHgvna89Fb/YOOXpE0JmFRpazPMsuPe?=
 =?us-ascii?Q?M5bnaiC9RTFd7QWgsbZmK5ak+lI6r3W9J6AL1E0tzL3mCC1qjKlS6kz03+C+?=
 =?us-ascii?Q?V5CP6GOcdzr4QQx7nEsmM8iRBkcllGdsd8293cnp2vlKBPJMhMMvoSYZLJsm?=
 =?us-ascii?Q?DuJt9/EfzhApyet6TNZCK1pzbzzdS36f7+fBOeIaesEtSKzL+qxOgK65j2tm?=
 =?us-ascii?Q?CD7VPpjRA59qzjPHKg+JtR1ER5fnz3PfJAbSocXWehUcKSX74inh3jcp1HhJ?=
 =?us-ascii?Q?1aKinQFlDViDUDMFFvAMkBhZgfa2udgwxHdjo7kgQqqb6XFucJ430ZFDbcce?=
 =?us-ascii?Q?klTpudh1LfvbKd0fmpRdvrYKPGWa25sDgEH7DDKG10QgQo90tNMQDeOAoND2?=
 =?us-ascii?Q?efd38c9ZpucFFNKWu0ldadgIUzTZfMMGwjNhN5bb+YiARiDPhrtJ71CIHzWr?=
 =?us-ascii?Q?RaMkCNnoaCyWLTvOUmMOoUEEYOsykexj+TxKGbtvg0FQKB9v3YojQ17zYfjY?=
 =?us-ascii?Q?qoaB9GU8Z0XnOVZubrBL790Tw5ixcr7FJaordPWWo4cEujK7PnetjTbQ+uEh?=
 =?us-ascii?Q?Ge63tzwMyAaLP5VD6flrOehmDiCS/gvFmvIk61CVD/jte5uq98dL2u9Z2/0g?=
 =?us-ascii?Q?i4nAXtfkiWjK0j5lHhEEKYzsC57DNjYZBY1om7Alyp5JCmxfqXkY38WZ01Be?=
 =?us-ascii?Q?EjjLFiHhfi34Qz6AgcQKGkvePbUvaHZLiQ6MEUJZIPjVyTuMABWx4DjM4A/r?=
 =?us-ascii?Q?mikl9Y6LFJO9NbC9OMYlz0l/nImX9hXcZoMC1SCKoVWWO/fppzV7C6g0NUUq?=
 =?us-ascii?Q?ug78Faa1xAKqYNXhxKnYx+ykGbZc0AZdGoqf2NC1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hFMC1ZT62eV3gPEe64vq7Ss8sosOQk+5h3XaswW4QCJeU4DM2b3kS07vgE1pEIKaBXtJ1pGF/FHzw+u0WnpRlvj6Md0mdH33pQrnQh23gJc8sl8wojtPxQgaut+/IIlebT0e9bQ9H6d7XOT8GrGghIo8UAMTuQoYwSYSShiRcK11DUBYGkMXmkZ6aQ2jWTHLyQJ9hwL6gAED4LM1tPuPzCpZ4NjcuyXiF2G0NnS2jQSre12SWFIp8B7Mds8jgcAbbFAG1YZySPNbbZBFnDv0nF4JJiMTkf1LF/w4EXq7+2KleHPVxhTHG5UMRaLW7yUkBE/KLSTbBk+/gKYtSqAu4Jnlh+GQnUdD4t2cc1Lxeg1VOFEHDdeN9FUgdY8diYXsoz11B/HOe6ysGYTclvNiOV041VfdXpi+vBA9D96DE3OHhKA9TPjjubtr8D++T06BT2N2cC7EMXr0W4LlqguYf7G2XJSsx++U84jEi1dCOLex/PZRSTbR90c4C5zJhgJ13PeNA1hPJSlHXU+ufGecV14IGQj6W6lHfAe+b2q9Qz/Wb7HQ6Fvwz9XazImWEP/fx3+oeeYCxa4ML+kP0Kd7dFTCdHsuQvkMVonA78keoBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0a7087-4e8f-40b8-5b2d-08ddee7769ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7333.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 01:31:21.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv0iwHtSXw7T184yTK1AbXq3RSaNemmq7vdmfITxW1/Cl1tHC4qDmyYnFwhiX6fEZoaQQCjMg9AQHoWwCH17rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080012
X-Proofpoint-ORIG-GUID: jP3VuC6au2h6RF5pFQIDxaFRXjRrCmuA
X-Authority-Analysis: v=2.4 cv=fPo53Yae c=1 sm=1 tr=0 ts=68be31f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=Mq-BUGaGdN0al8lYWrQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13602
X-Proofpoint-GUID: jP3VuC6au2h6RF5pFQIDxaFRXjRrCmuA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAxMiBTYWx0ZWRfX+VxvcAWYctGV
 DyvzD08fuuu4xOwl/VGqcIBkFbYqZQliILT64dW2Zk/GsOKUfScctbcM9iP8Fk5mlhUideWndWf
 ActAzcZHfNJdtmI2COlggl/6oC2Vj+hkfuly2vKQcPm9OJppLD7kJeawdnnAX10nz0VyzdT0pk7
 NkB5b+XP2UD4s4Dqd2Mkf9ht7tnwiJZ5YMhAczhJjvf0/3+8Bp7rbNglKiWKC+yJdrt5WWlleTX
 oysJKu08F+SF76ncVaLjnJWK88k7H9h7Myl9FyEGoC1sZSAxVxSmc+XdBOerxZlLyYVwzGmjg5v
 JBVHS6TCg1jn9i0Usi8tbB0Orq0R1GW1pgCD1rVT/mc335okwfn53vSYCkb3dvpW+n9aJ0U4y2G
 x4x1ducCEgRvxMC5fLGJthVv5j8RQg==

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 29 +++++++++++++++++++++++++++++
 include/linux/pgtable.h | 26 ++++++++++++++++++++++----
 mm/kasan/init.c         | 12 ++++++------
 mm/percpu.c             |  6 +++---
 mm/sparse-vmemmap.c     |  6 +++---
 5 files changed, 63 insertions(+), 16 deletions(-)
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
index e42388b6998b..14ee28f7532f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1111,6 +1111,23 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
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
@@ -1601,10 +1618,11 @@ static inline bool arch_has_pfn_modify_check(void)
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


