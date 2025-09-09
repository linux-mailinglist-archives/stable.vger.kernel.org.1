Return-Path: <stable+bounces-179037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B709B4A1D0
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 08:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414D04E6CB1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD32FD7CE;
	Tue,  9 Sep 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q7wZkyz7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fdad9Wt7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1862D8791
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398344; cv=fail; b=GdpuKDq1fwZvuZ07Je4HcVrPx4rZM8tIi1k0S3wpYm/DZTXOnbaNxIgVfLFImaKt3u5fg1sxrOcpRz8c0JP0cQGilryYFLex0gzUdtRLuImPaAl3G8w9EZDN9CXg4tcdOXZSjTY+zrZmdHL9KIYe8hWitx9DNM1MYQP5X0ipR60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398344; c=relaxed/simple;
	bh=ty43aitOmi53877Y5ShXiTR9uX+GAW1Mjaw8XojjkCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UalxW86+y84A1f7tmWzBeW/dI2Bf11+gYAB7DgSUXZCbhMqOZmFmI1vFE+qdfbRantvHFdyX1djCcQ7QznCKxEEhBMESMCmvReQC4TX6OH+4WCL8d+Yx0CAJ9G4AGSo4Wahfw7C216+hPo5Jqkxrc/ihCVNssR8VbAhKTdxxvFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q7wZkyz7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fdad9Wt7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LBhTW025903;
	Tue, 9 Sep 2025 06:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ksoKBsxSEqlW3kJYu1DqVyt3VcqgQURb+clvcMrtyKE=; b=
	q7wZkyz7QLmlZttnRfYqTcJ9KMZ9Cg3fCLxIzDLcKkX9fuy5G3Gqjx78bYaSR/Y4
	2Rj3FmxXNSNM6DuIiwaNcXD2+uLrtMtQFwwEkoH+wZ2TGs/+DWUcHMUCjyLzLmw+
	Fse/lj3NUVKmoA7e1KtkYilH6aVAoULgwhgD3jTFSoIvJmpWjxRgVCSfmPJmeGuM
	DwNPelMAdV2G/Q5tTy/fPMb/+Y+oET+3eghplYah5NobPRyEyQFHV4ky0Qbxoke+
	wq3GqyfC5a1eXNB5OW947+rFjXEP5p2UICdvzyEV9f0yfsSiG/zHncoZJHB5Hcg1
	Rs51+y5YkuANe97Cyn4sOw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2s75x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 06:11:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58951Xf5026540;
	Tue, 9 Sep 2025 06:11:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd95rxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 06:11:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSIYacoj95F8+YtfC3ShwA8lib4g1kqds6vE3j15LVuEdhxdLe65zM7sqeWId7LSsM0TUC75t1puSBxp6z4lRwefyxL1GuZ3NDqAuGiCTtXjc8u5/rCA/9vQhbiBOkmeSUYZyQv9h0Rqp+H6zr/Eh8kJx5pDmexUq9qzs/USdJkg6aCW05QELt1Ak/13L7tGayb+WKffGMxTVKOGrZNCYdnH4V32M547LbTci/het0ak60EeTcKFvWq3lOqYPfvqdqHL8a8DRP4Pjbtv7kNixVK7Q/IFni+Gc5QXV8wzBXVKCCF/ElQEXGr4yEY+WsXhVI6WpoaqFlsh+2qpDBfgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksoKBsxSEqlW3kJYu1DqVyt3VcqgQURb+clvcMrtyKE=;
 b=lJb1fd2GdDJMVHJvgKJN1DmGBCUdhxPO8K8SUZMGCALtT9PKONL11vWKp3HBlOBAGaH+8T46DmonOJ+cv5A/JqEcoa8Ub5Je3wrwtWfqyHEzgAjr/CdIu4+tJR1GRqyDiBmBOYRssjpREf2ytMfLERpwfa0AUW82jLvJHorIr6ckMgD3xiXEaaAMlt0uWcNvn0mke7lxr82FPkoi/TkC4IxOD6arbPFeZt9eo2zPIAObE2ZIkSXERKpDGj3YtD4l/nHW21aQyUCF/gubkeZEj9j4ACHT6BKV/FNhsQqwy1Q2vWT0a6k1HRo7V1CjinO2pU87d8mnO7YLR1gf67D7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksoKBsxSEqlW3kJYu1DqVyt3VcqgQURb+clvcMrtyKE=;
 b=fdad9Wt7OgLwt5w2d2HMx7F4/W8Z7TXvkzU2QGNYLizJe2OXYFG1w3DrZIh3rTE4ct3HDw9ImsZVk8YuGrhLuaVQTwbRktWRm+IZWbE4he5pT9UrBQY2xqyvO+Dxth/va0gcQ6Z8ZnImz5OvJCRDSFEWm1cmoWPQate2jQ4n4Ag=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB5073.namprd10.prod.outlook.com (2603:10b6:208:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:11:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:11:19 +0000
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
Subject: [PATCH V2 6.6.y] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Tue,  9 Sep 2025 15:11:09 +0900
Message-ID: <20250909061109.5288-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025090604-obnoxious-bronco-1690@gregkh>
References: <2025090604-obnoxious-bronco-1690@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0088.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: f066ecdc-df31-4173-455e-08ddef67b122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u1aTb9zW39oHyUSDaW1qIUfJLkju8IRHe9jFoWoEbqtt7irXsKZ0bmqXEVFN?=
 =?us-ascii?Q?brnWH0JFTO0H3+xHyHcCetuzKQtVMuKIeAo5NqasdCUK6e+wp6LQt8OUyCYI?=
 =?us-ascii?Q?3ekh0oEscuVj+sCVbd3rfmff7RoLAzgaIip92ZjQ/Liih/6rwd9/iZr1Cgde?=
 =?us-ascii?Q?Bufe1/KUNRnROOa2mjQQuD6DSG0vrdpGn+I3qGL8mTnXh1oPEiI1YxiCXvhZ?=
 =?us-ascii?Q?TGB/yglUw9op3sBrzHjAPNMVpvfxo4vu+xQiuXcpwyJ3249FzERh56zmk8SB?=
 =?us-ascii?Q?kcGERYLZffojjdilrRL7hF2S84C5gc0NjYl+58YPRFDFKL5lUCVADh/0Rlch?=
 =?us-ascii?Q?Yj4Z/Vq1dFY6v2+GrkKld4DEkY1u9743qSCdU121ZHjHGGsNTv4m/BINGlhL?=
 =?us-ascii?Q?pkWnQfFkuuKzXsjf3icF3mO26pwGgM7vJ9NsW7Dz0rwhZGuib2EwfCHedlHp?=
 =?us-ascii?Q?VfSiJAroj9t61RaxZ4hZd+r5OpR1CkcWHaLSNP7x/RrHffW+gFSue7xKNTbY?=
 =?us-ascii?Q?5hLHNVDhhxlHlLqBv29Km0W8k+spPrmkhsZjgkiwuMfehF7eGo3CDXCc/dsK?=
 =?us-ascii?Q?APhXaisQ7Xvtrw+RD4ghxiR7zXY7zTgO+tvlaSthl+bxtBuH6vHK1AjCOjBJ?=
 =?us-ascii?Q?mi2o/zZdViTpBvxGIq/TgndYwMlKMXFmS+pKHUxDGD29g9RemQXrZd9wZFmj?=
 =?us-ascii?Q?EfCcaUUgU56DKTd35y73kmQPijuMbL1F02CAzvicSUNaUCteYBH7HRCobnU8?=
 =?us-ascii?Q?sLfvycUfZoXieLoWWvsBzkPscquUlqQciBrusI5pbX9qrKNszvXL/EhbLJHc?=
 =?us-ascii?Q?5BidyQSKG8+p5mIloNRKeLyl/1EuzVSJ57BxGYHNDh1h4GcawmDL/qqalYyN?=
 =?us-ascii?Q?VzDkUkcs1eRaRymlDrUemV2COB+PcXpZ1gUVa9Cxq9BrGj4z3MI84pQ66dz5?=
 =?us-ascii?Q?gkXn6T87t62Xqep4OmN+IdzjIQbIeSEb2787d/IY7Jf6HCZsMkFxr5CYftPd?=
 =?us-ascii?Q?kOHTSoMSBY2v+Oh8xZGWzcGPgfsgws2qAxvShhh5RYyvdIDndCF+RZUKjZ9E?=
 =?us-ascii?Q?gpu0E7YjOcovEwjjktpaVcFR9xSjwuIm1l1/4I9nGq0iuOnjPLHtl9jw9SXE?=
 =?us-ascii?Q?X1peDVv2DI/lfBdWWsh5pXkcYD3FGV+NZ9TljNVJOCu9HSr6xS1kIa/el2Zt?=
 =?us-ascii?Q?D1ocbmyhkUoNFDG40niGV++31ifweEtsSNKBP4y5Eyg+mAKcGWXuX6cSxoCQ?=
 =?us-ascii?Q?KpiFRM7T64hgKgnl5IIGZKtB8w2CZCI/7G0hMULPZchIludaIVO1vl8VzZ5Y?=
 =?us-ascii?Q?xYEJ4xHk1zFbinQFIdf+O8uFSdZGBabRRZ3seysteUCgE+nYFWLXSeXNcjtB?=
 =?us-ascii?Q?ULeFK8fAcVxCk18UPDbezOT5y5K+40ucg62e4LVkfph5Xzg2Lkrc12PXUoFt?=
 =?us-ascii?Q?YAmPkcXvSjl6YtwGQSNvt6YRR0eLBUgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLHTDzEL0HfOiKsIlQeOWb5JjEb7TF9R7GTu/i+FF8mDPmL8V0TxvPb9L4BN?=
 =?us-ascii?Q?DtXKdyG+kKVXvyVuIU7JasjoQAU2AGbwN6gIaSmKSayAbsOODlmerOIebzpr?=
 =?us-ascii?Q?rwntDXb2+V9O8vlWRKNC7tSP/FRJcnmrNzBTHo67m9Gu5Ov+cLoocwMt113H?=
 =?us-ascii?Q?3pH0nuAhbWQ75o2BQdgxgRRk5GLTGJwgcf+5jFRBflHS7vyPp4n8/pu+1anL?=
 =?us-ascii?Q?kR44WQo50VCGrzES/RQvxmYKCcfZQuYAdCgq1mschnX2HMG9L/q7OUYeMMtu?=
 =?us-ascii?Q?9Qa0dgueLm2ZjExA3eVLUGbU6TYoDla3+UY6G1IKujGchL8UqlNGxy+W7ct8?=
 =?us-ascii?Q?IN1alhwgj/C1vQLbLA/U4syLX59ihNENDv/ujQufKgdEY2Hb6oQLuNXJF7aD?=
 =?us-ascii?Q?tTiE3/cbD1gRRRdLauzh8vu+1Xuxkaa+8Wb4SkT8yfnVZzQcTQjbPn3PQuc/?=
 =?us-ascii?Q?884UKtcBm8YPo/l/3rJM8lrV7vMM1KpVo9MD7zKwCclrNLxRBDjwNTeacO47?=
 =?us-ascii?Q?hw5gHXhLAXTVSXee+/J/jLXFPfvI4nqv+hFEuQPwN3kraeaCcdMk7Bw+Iy3S?=
 =?us-ascii?Q?xUgSg7tXb86Fk7d/Fq3rjZYLO8rS7+HUxIxnp5FBos3mjd8YoHWFQynLmRPf?=
 =?us-ascii?Q?g/rHyzeblmRM3xL2/AyKwGCb9sjLxfyNVoQOwLBhWjL8r3epa+PtMOtkipTZ?=
 =?us-ascii?Q?HntUrkKYoFsTTarDgALzc4j7PCnURGNnL8VP3K9mz1nQD9mrlRlhBBnEjevY?=
 =?us-ascii?Q?xaFYH002MxC6KWTX1BI8786jcmjKurEDdqRqXTl6zHcTnCHLDFIg8B7BVpXg?=
 =?us-ascii?Q?FK9IdDI0y6hb3c+Emujbu93xkdp3VrqDLsgMNMUhrB8Wqg9oN6MLI/hcuFhs?=
 =?us-ascii?Q?RydRAWNWS/scEt9bFkSU81Pfd+LxRhkjtajVHRAwyfHj1D2P41LonoboWRd5?=
 =?us-ascii?Q?ns+qQyYLizLQz+9Opg4L7RupkBH3il31vij6/CUIwE/h6Aji4+GRVnhoh/qv?=
 =?us-ascii?Q?8VMxE2QDAgX7i9H7eRbJGrDkR2QCS3gsQ2KqKwJOHr8NeB4EXhXGBPN8vZQr?=
 =?us-ascii?Q?YlyJwfsbja81/M1lB1ahrf+lt8hU075V/E4bg/Z59SWMjg732l1baf9ErdT5?=
 =?us-ascii?Q?eEWo2NnneqS4hTfsTD7h7l+0IEEwh0QwKgXWCbXHV10DYVooHc2khIhdHyxC?=
 =?us-ascii?Q?TcjCB4a/IdPyr2ERxZZ5t60Txkrw30DYGT12nv5W/7PhSxOAb8JftZmaOFDW?=
 =?us-ascii?Q?11GP8WTLwFU/dv1Id06mfC+XxHkWN3dSAC5e9JDSF5Fo5OHL9tidHFltH21d?=
 =?us-ascii?Q?55D7AYFVn4Y4q561OE9v/Kj2suB2rV7nkR3amfa6vgvBvWcfEjYqZKi5qYFj?=
 =?us-ascii?Q?gUq3uApVYBLtjUUleUlSQ5oecO6HWAuf4PmUw1HHDR8imr6BVdJMShc0YwFc?=
 =?us-ascii?Q?8sR3ujf2qlFS+YyrA3SzpR52jVh58jmLlo/VdkBvOfXjrAVJqeNP3GDbHDuV?=
 =?us-ascii?Q?Fv9yV0Mq0BuGUAnPf38tIxpkqga+ScDYK4chwH68LYl46HGTWNRaonSj9mXK?=
 =?us-ascii?Q?aG8OYO9VHCbbvgd45NtzAZWYEhI+ncZnmnxkjVqr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Hh+2pZeTJfWqj+2c/XXEvEv7IlJrdkfZOu/FC/7Z074J0ihKtXikTznWWU8oWrg3h3Uyj8orogStE68WmCNl7LYRrOArJw1sp/AvnoklebCOY6cO21FZ7KARZC1X+Qk9IZs1RHvs64k6tDuFl2umO1SkSfXxjXlVyUjcqZNDeQkeo86lCQhlsTWtLqMmA/nrBgxade8VWtASg9Mnd5w6/Fs2qKa3c3kSt7wZd2aZZPrIsS5PjRoJAPO/dSrKJNSoi0KF7ZK9ABnrk6qrcGqDm9SQ8BoG71VHJb+/XG5OtLwlokAqlGntViNU38JW6jE5UXFWws+/SPXrsyTto94gdhRL2wjJ5WTntvxaXOygzsNepW69QI2fHmdWj/EhloV+Uxqixoxlav62f6+40z+DYNqwSUd+lMrjfINIMhFe3qlYpZbJ5DgDISDUzvM51knkcPoG1xgNThNG/6LON+C8IfchrvTWqQs0UkHHP8jC9L3hChyfcz+wK+LHePPb2+s1OWNNLe2eoAd3jmm7PaOB4zCMUsqTY22i6ZPbYYuRhwsHLUZxKUMSr7mk/ulcdpHBJwYQTHEwPPEMsAbN6cl1QQhMv+8LwvONQxtGADA/74=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f066ecdc-df31-4173-455e-08ddef67b122
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:11:19.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s9zfhXQv/3YnO9veTprF+7VNlvOXPSABGRLca0ecxXkx/N/+dvrRoyOE/Wf6KioScuBq+KFNRnq9SKZhnHIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090059
X-Proofpoint-GUID: zZjYbVA7pA8N7GIz0tXcBjeIHdj2D0rm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfXzjfZlp/zWDPU
 /khk338vgeW1u30g+nqO3eiNycWlqrli7Y4t9OHrgfQf24HQfrBbW9R7W01IlpqQMtPshrYydex
 RNtxCLC7M3kuaC7ceBP7RDL7fEnKWinANJKA/ooxQwO2oHJgzuQgM3kA5WJMAzrg/hX6YWqsQ4E
 6455+JBnQEE73OaANDg196H9aRzdzsGc99IFS8HNu6s4XGyDpPxX6AE0MMNeBSsDQKXDYtJVYTz
 gtYEhPkgMPd7XYEtR5XbCdjz6l8xiGf0ewMeK4g58gpgA7k2JvEy5R03dOLMWYhcq08Iii0bX62
 xCFsAezYhL3XfxswjG8sVL1UTG7tDGNeH/kgk9UO1kOs6mjXmAkTv1e+//tTC+KRjUnH+Jc852K
 VV8X0XD9oINiXg84ZXrmJxfIZFZeeQ==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68bfc50c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=tA7aZXjiAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=968KyxNXAAAA:8 a=Z4Rwk6OoAAAA:8
 a=d2j_XgrXCP8SUPSpM9YA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: zZjYbVA7pA8N7GIz0tXcBjeIHdj2D0rm

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


