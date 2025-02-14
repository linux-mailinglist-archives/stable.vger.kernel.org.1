Return-Path: <stable+bounces-116434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFCA3641B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3779B188EE40
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B2267AF4;
	Fri, 14 Feb 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="wwJb7XEH";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="CmYeq6ZG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E110266EE4;
	Fri, 14 Feb 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552970; cv=fail; b=t4030bDDhcheG9c7IRUuMa5SzIR03bQO9ON5JX5V2fI35yPkMtjJJMSnrreAJvPjxmrlf+6cNzlLaLQKGhsu6k2XWhbnccMWq9Jnlkd6FFpqFjiM4A9Ab4Gk7IkFJP3V9EqTHkCB0dpBXI+2H9uZwC4m36Lp9b/LfCZ/cP5h4Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552970; c=relaxed/simple;
	bh=Ik78QDwxycuEvGSleQR1e1HLv+ay93XQu1WWdpNDRDU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qLXojVF5hc2ZzOpqdUeuSXx/QK/BEhG7btugNKFANXuq3jCWiEHOEfpUmNjiAcJKDlMiS/4KsrJ26dN+s7WuVEjROmFxrYw0GYGvfOOvuUj9X06lJDMH5aFg3Jy2kYBHkMgJ3EFz4h8Kqk94eNZpnOr9UAZDWZSX6bbMjnFjQk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=wwJb7XEH; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=CmYeq6ZG; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EDwCbv018673;
	Fri, 14 Feb 2025 09:09:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=3C6w6BkzgD7mN
	OSkLm2IFn+cCJnwyTEFEpcUSaEFmh4=; b=wwJb7XEH53panTmERpzL64RcNwjMU
	qdPpfT47dvc7s42B8KE9eMsSqiL8AkAWz1Oa+IrmPGRc9zUes4TL1VLJcbxSJf0B
	jWPrCMkKYPC6giqcT0UXhT6p67SESfF1Ma4JDUHvVng+WJ6VltbGaF53VOUzrG+y
	caNZ1m61qYhq8n4OoBRLz0iZ8H4HC2QDXM8+0UMtY/5FzmsHsGV0s0Xt7TG4w5Af
	dQHFDYG1cTYJsQN7ZA9PZ7EQXnmGenXxJi4UrAsnYbmVfEGlhQL8qC0OrIVZs3UD
	larM4egw+PQYME3Jm6tYkEw77HAvBaQuhSnPVtTcaMZeTmT0Q23WFI+LQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44p80wff3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 09:09:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDOjxuuftNY7gqcRwqjlIIAeHq2cooPVwUJFNiKa0dloY9ozgDQpUkpPdM3i/IP9KS2+ZclDBHocFRUspCl68Q1l59FFL57sjzuk8At8TE6EbfeKdp+Vwccw8ShaC18hyMgwbwttXco1Icecu7colJIFyNuEHjmK0XV4Yq8EINp/AKdImGDbY1f/ANYhzibG4ABKWeXBqGtgkoiJ5ZdZjh3LG7ncXspFIbEXAqydmq9F0f8R0j0KIfuK8Gw9TA0pbisjLFbmSh4CO3BA9NNgEaVS9eY66PMIWQmYudWG9+PlTifdZ98fwoFRxQldwTVdyBrnURDPcA+W+qDVhIdQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C6w6BkzgD7mNOSkLm2IFn+cCJnwyTEFEpcUSaEFmh4=;
 b=RMTy6RlKBvUyefpPe3m0qE+5Yp0aVFn7cup/9lRTJH33Vw+qUWH+x9+imdgFkvgsBK2hsyE88WgOOo7SyiUQ1z71hA1viKtby4IMPynw9CY02gjAZE09f40mblj8qakypbJVm7DCNR7ANdqjex4AhTVvAVY4IJa8f3VQ+3HXwcsK6BDu6QlC1GAPvvKIoEAml2tE6C0vw0xVZEZyDS3GRhlWlSUI/Sjvw4m2FlDzECuXD+ZDkLtzWrpsN+tascIeSlMXQMa+AhH/hIZCbTadCcDZQFD3qizJjPCYkLaoOSf6FLk6/T7zqWSS5uYXeYozX1N6j6VGCurhC5vgaNKjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C6w6BkzgD7mNOSkLm2IFn+cCJnwyTEFEpcUSaEFmh4=;
 b=CmYeq6ZG6MqtHXVXczJylqz1gySPtlxWycOj2/HjCb6AbUynN1oReriiCrwGOpgrgq16P6yXtBYra294JLvkfRWOWmaI2oBwKBtCGIsAiboOKrp7yEHTZlIrxSNpGxLp0uy4iItEY2M4ofjEgfrS3aRPZMStzuYr4wNNdX+U5oMnOIUqjJutLzsswa8XN34yO6oZxNcoWgPJHlcMgWR1SksQKpfYO157J2Rm1uAg5mBSMnaabH9CsFdCsnBQspv5xKiMvwL6fpPq6JNJB93QrOov94uyZwVAUgXs/HtNfIjbKPTX+WW2G9vSivnMdXUuaCbnSU6oOh1n7ljXp+jtiQ==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SJ0PR02MB7343.namprd02.prod.outlook.com (2603:10b6:a03:29c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 17:08:59 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 17:08:59 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Harshit Agarwal <harshit@nutanix.com>,
        Jon Kohler <jon@nutanix.com>,
        Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru <rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>
Subject: [PATCH v2] sched/rt: Fix race in push_rt_task
Date: Fri, 14 Feb 2025 17:08:44 +0000
Message-Id: <20250214170844.201692-1-harshit@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SJ0PR02MB8861.namprd02.prod.outlook.com
 (2603:10b6:a03:3f4::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8861:EE_|SJ0PR02MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9c16d4-6459-482c-dded-08dd4d1a45fa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czVBZHhabDJ5a0w1b1RPL2JDMXBTUTFSQkY1VzZLTzFxZ1lwd2N2T2grZ0Qy?=
 =?utf-8?B?M0tSMTNDTU1sTWw0TnNnc0pDazU0eVVnNzhPR2F0SS9rSXA0MmcvcnI4cUpo?=
 =?utf-8?B?SU1jVnlHZytwTUNFRGZ5RE1wdDBVcU5ZbHl5OW5iK1dpRUIrOHpJMnFMZWV2?=
 =?utf-8?B?ZmpKa0t1a25ZbS9sWGJMdUhIbER4WHh0bnRJMGtIYmlyL3g2VkgwdVQ0RCtj?=
 =?utf-8?B?UHU4ZXh5OFV3Rk1VL1dDV01DQjMrTzNQOG43a2VYT0F5UllTajZUQ0EyUTEv?=
 =?utf-8?B?dXJNV1U1YUE1blk4bjJVTWpLVU52cmxGS0lVN3ZjRHFCL0habkhrU2JWOFdx?=
 =?utf-8?B?UXZVM3M2OHB6UTl5YzVXVmYxL1RPM01Bd0l6ZE10NlFhQmxMK3ZGQmd3aTlO?=
 =?utf-8?B?NFZ0UDNFeE1jQmNHNnhPSUxqK1dMcURPS2NKN2ZuaGRSckRoaXc0WTB3Z0tT?=
 =?utf-8?B?aCtRS1EvLy8yUXFHWWNmdHlwaDNVRHlWYW9OY04vNitVcTk5cE5oQlh5N3J6?=
 =?utf-8?B?MTB5MmpPWjNxRUV5bWhaakVKYWlXZkZMYjV2bEVjNG9nb3pTSFZwczFhV1pa?=
 =?utf-8?B?ZmJTa0Q3M0ZES2tSSGh5QjVpckhJWkdoSVNJRGYxRGEzWGZjSFlUcW5RVkYz?=
 =?utf-8?B?TmZiS2hkcW9PTEd4dG0wck1vdFVPWDF2citIUUNCTUJjREp2VHZoSTJjMXFF?=
 =?utf-8?B?NXRDaHdJWUpYZDJhcnNJaDZ3aCtKN1MzZ1JHM2FnMzI3ZEtDdFBJc2xMdHBp?=
 =?utf-8?B?N1ZmOG11eGNOZkc5ekJSTHlSd29JL2RUeTJVU3FvU1o3T1RmblppeFBCTnl2?=
 =?utf-8?B?U0htZk94bUlRZnBoM2R6YmxjbGI1SE9UanMyL3NxQ3JCMzZRdlkzMnFCTHc0?=
 =?utf-8?B?WWMzSVVxd3FoSC9hUjVxcHg0QXllcnRZdWVCSEcvRDdzUTIzZGgwODd3UDA2?=
 =?utf-8?B?dzJ4dWlrd3F4ZXkzdVUwNURKd3RCanBFWm1SMGVjdmphQ3BVbkZZVGFMdWRG?=
 =?utf-8?B?SGg0a2JXdzcwS3FnWEl3Q2srTkQxSkJxQXFSOFBkdXkxcmdvZFFmdklHdUdp?=
 =?utf-8?B?amE0OXFRNWtNNXlnN29lMk1CdGRDTU9Kbkt0RUs4c28vSVorSDBHRnB6ZXEy?=
 =?utf-8?B?UWRQU1BCayt5RUJDRDRBekZoMmxnakM1UnBudHlpZ0txZ1ZjMFhxZTJodGwv?=
 =?utf-8?B?V0FoSVJaZ2NZaGNSK0k2TE1PL3BqN1QvQ1dzVmFrVVhVdWtOMWpOZkpvMkZE?=
 =?utf-8?B?Mm9VZTNPV2JCUVN2ZkRpNklOWisrVFhVK2pkNFhNVHZWMitnZ3pOY0M2ZzJz?=
 =?utf-8?B?SWEwbVFNd3B6SjVIWEQ3eVBUU2FlT24zTVcxSDF6bTRtOE8yS2tDa3kvcWhK?=
 =?utf-8?B?Rnhwb29qUUJhVkk4VkI2TG9XR0VtaDl4M1NrNURyV1doKzFnMHFJT3ppb0sv?=
 =?utf-8?B?TjkvT0NXQSt5UUZmMnFFTCtsdkxMNXN4dFdTVGIvdlpBN2ZqV0h5OTJsRWIy?=
 =?utf-8?B?NnB3ODdKT1NNRXZJNWF5bVlIVEV1c1N0QjRmaEcvUXlyTEp3WFpnZHZPV3B1?=
 =?utf-8?B?UjR4bHFaVUxwcGRLSm1hNksxaS96Z0U2UXpSVWNwcEJMeThtQkRZYnpmMmI5?=
 =?utf-8?B?eWFvWFUxUDZvdm1RYjl3eEdsMDJIOXphOSt6RC8xV3liN3lFWWwyRlJuRlJN?=
 =?utf-8?B?WXNTTldWTmJXSDZERTFNQXNsSWpIT0xka3lvQ1k2QWQxY25Cb0RINFUxYitJ?=
 =?utf-8?B?RDFhZVgxYmpyR1BLaG5FQklHUm9xVTJ5NUdiUlVIclVCT2QyZmJaRFFUQkdv?=
 =?utf-8?B?V2FINmwrTGVvaDRDeGNRS3JQczRkU2pJWGIxNVE1V2xwTnp5VGtybW9MTFc3?=
 =?utf-8?B?ZWVrZzhuY2h3ZzVUTERoOVhnckhDSmluQmlUVmM5aU94UjAzTlhvenhiSU1i?=
 =?utf-8?B?Qk9VNHM3RG9adTNNaTlTbWk1aHdxTlp1dzlybEQ0SXFGc0tYSGNYZ2puSGx1?=
 =?utf-8?B?STFnSHhxVUVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0w0OW1CTitkZ3JYQUd0a1krU1E2bG1LMVkwdmtzemtUcWp3UEhVNDdBSEtG?=
 =?utf-8?B?a0w2UG5XblZ4cHdvOExtZER0M2VRSm1YRzY3blYvOWRFMEFIRUhZQ1plT1Ri?=
 =?utf-8?B?TVV0RXpvVmNxV0R1STdZVkVCRnlidmYrWTE3eUVVYUk0bGJOSks3Y3RGWmZq?=
 =?utf-8?B?bmpXcEZ3Yi9qU0tQWkdFcnVUVnhpVUhRVDRMc0xRSVhqaVU1ZzBzemFLWTRL?=
 =?utf-8?B?MURJejV5SVNpWW96aExlY0QxMS9YM2svS20xR3NScDBHSHpWS21CODNYOXFh?=
 =?utf-8?B?THlMb3pEZ3Y5djRyM2htT2FFRlpXcldYQ3ZLVWhhcldjSzlkcE1HUDlKcmRU?=
 =?utf-8?B?NnlBeU9JcjBUMllXWC9jUVpZL054aGUwSDNzSW1oK1p3NlhvUmx2OE5QM3lR?=
 =?utf-8?B?UjRTa2dscElMQlBzWjdwUE5PT1ZVdi84KzZyUHhwNGxzb2tpMkN3YW56ajBD?=
 =?utf-8?B?QUoxcjBmVUlkcWg5bU94VzUwNEx4NXBZVVcrZWV4WXJycmdSTWNGOGluOVZu?=
 =?utf-8?B?QUFuVmJlaXA5NEVJK3k3OE8vbHF0NU5adUVxTVE2czhCTys4TThlQzRvZWRt?=
 =?utf-8?B?VjRjaW9ldjl6eHQwZDlrdFpuZUVKS3o4L3llb3hOTXdKaVg3elRtaU1xa3Fl?=
 =?utf-8?B?bnk1Q3MzVmxVVkpyM2lGZXFiTkhIRk0yRFdzaGZqK0M3dG5DWUpla2lzUGNp?=
 =?utf-8?B?bm94a2hoYzVEVHhEK3hqcnRBTkdOMUk5MURLc2dqU1FJU1ZCZVB2Situc3lZ?=
 =?utf-8?B?MHdRa3ZBaGVIQ0dsdGplajNQVE5FcUd3alJsNkRhRFpWdVI0RS9rRHUraDBK?=
 =?utf-8?B?bmNrZzE2RUFuVHNYSkVLTUxUVzhVVmF1UTA4NVAzNFl0aEFGQklrL1JkQnB5?=
 =?utf-8?B?UWRNK00yUzd1eTNRczlWbVpNWFVWSnRONjM1cTMvWDJwaXBPNkk2UHQ0dEZD?=
 =?utf-8?B?Nys5OFBSaXZSS0dVcU1ZeFBsNllzZ3ZlQi83ZGh1VVgvbzZTTTVjbDNGL0h1?=
 =?utf-8?B?ZkgwbVpMb1JRVys0akVmc2ROUU1ZTWtGdE1KYzFIdWpqTHpVUE1HcDVhUmlG?=
 =?utf-8?B?cVIvUE1ZWFo1NlI0V3RkZVhaMGxaTG1adXhPWHFieE9VSFhLSmNkbGlNOTlT?=
 =?utf-8?B?QzJBaXIzYzMrTTNIT01DWGVPQ01LSDQrb3h1MFhQaS9ZNElzb1o2N0JjU3ZX?=
 =?utf-8?B?SStWbE9OODZqNVJPQVdTSEpuWnEwRlBsYXB3OE9LZXFESDh2MDBVL0VPZk5j?=
 =?utf-8?B?ZzZTd0FhRGZabDh4dktOTkxvTi9ISjU1Y2ttbE9ERGs3cm9hUVpsSVpvbVB5?=
 =?utf-8?B?SE5va2dGQkdCYlFVKzNScysyQXd1L1YxbnJDbGNmK0xUMTBLeEVuUVluZStR?=
 =?utf-8?B?VFZ5VjVJVE02ODZUK0QvZW1uZnFCSzVzQURXdXlEOWQ3T0k4V1FMdVY3UkRa?=
 =?utf-8?B?RnlyNURNTDVlMEJDdFhGSExQbm5Qdm02MERZcGkrWEZscDA0NHhqV1Rmc3Q4?=
 =?utf-8?B?RWNNVy9KSCtkSVdnbFdHUWVvQzJKdml2bFhnQUZCbDVUWXhXelBza25BY1pS?=
 =?utf-8?B?czBhazczdXBaMVJPMjlFVml1NFE4NmEvcG1lbXMrZU52OWpLcTliMGM2cVlO?=
 =?utf-8?B?SGtvSWFNZkJxdVJFVHFCRkYrUVJoeWdjZDJZeGkvZDlVV3BjRkpLRFhOM082?=
 =?utf-8?B?Vjh4MElSMUdCd0FobkpleDJwd0kveFV6MHNmcjBjTS96UU1JakRreHczUGEr?=
 =?utf-8?B?K1NpMTBEYUxEUGNBcjdhczE2R2VEdWE5eEZtWWE2cUV3NHd1RTZKdEZSZnFl?=
 =?utf-8?B?YVpVNE1IVExUQ2FrcVp1WURJb29lSXRSeVROeFE4cW1ORkw4Um5KbUw1b1BZ?=
 =?utf-8?B?Ti9DbXFnYWdDWnNBQ1g3UXNiYjM2ai9VRkRHcVF2Nmt0QXZDSmJKdHhNQjEw?=
 =?utf-8?B?dDc4N0RsTE03MUxWU0xwUnhyUkhLRFZkN25tVXNuSEx2ZjBtY282WSt4THBt?=
 =?utf-8?B?TG5US1ZraVhvalZVRVMxQUU3bjIrbDU0QUdtU0pEQW8vS25zUEtDSjk5cHZq?=
 =?utf-8?B?SW9kMlQ4VnJUQ2huMVdtbzZwK0NRaW5OUzdFRGFoazFxSitGaUV6cFUwVHdH?=
 =?utf-8?B?dGpSOHhQMnhpbnBFZVdFb0Z2eWd2b1BCVjhjWFprRkxzZkF5SkF5SmNpeFdG?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9c16d4-6459-482c-dded-08dd4d1a45fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 17:08:59.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSrzDoiFVFGkNFybPrYiBZzWByX0TDRjH3sC9zeQLXNa8IkJeRRDlliBIGfROtatuRrsU58+WqgXqhvRqM4E3kE5yC50eFDUz58V3VFrWfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7343
X-Proofpoint-ORIG-GUID: IkV5szAXv-8ovRKiQA7rRV8TCnfWdHvg
X-Authority-Analysis: v=2.4 cv=T452T+KQ c=1 sm=1 tr=0 ts=67af78af cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=tRswbNlCWb7GgJ6GzHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: IkV5szAXv-8ovRKiQA7rRV8TCnfWdHvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

Overview
========
When a CPU chooses to call push_rt_task and picks a task to push to
another CPU's runqueue then it will call find_lock_lowest_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.

Crashes
=======
This bug resulted in quite a few flavors of crashes triggering kernel
panics with various crash signatures such as assert failures, page
faults, null pointer dereferences, and queue corruption errors all
coming from scheduler itself.

Some of the crashes:
-> kernel BUG at kernel/sched/rt.c:1616! BUG_ON(idx >= MAX_RT_PRIO)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? pick_next_task_rt+0x6e/0x1d0
   ? do_error_trap+0x64/0xa0
   ? pick_next_task_rt+0x6e/0x1d0
   ? exc_invalid_op+0x4c/0x60
   ? pick_next_task_rt+0x6e/0x1d0
   ? asm_exc_invalid_op+0x12/0x20
   ? pick_next_task_rt+0x6e/0x1d0
   __schedule+0x5cb/0x790
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: kernel NULL pointer dereference, address: 00000000000000c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? __warn+0x8a/0xe0
   ? exc_page_fault+0x3d6/0x520
   ? asm_exc_page_fault+0x1e/0x30
   ? pick_next_task_rt+0xb5/0x1d0
   ? pick_next_task_rt+0x8c/0x1d0
   __schedule+0x583/0x7e0
   ? update_ts_time_stats+0x55/0x70
   schedule_idle+0x1e/0x40
   do_idle+0x15e/0x200
   cpu_startup_entry+0x19/0x20
   start_secondary+0x117/0x160
   secondary_startup_64_no_verify+0xb0/0xbb

-> BUG: unable to handle page fault for address: ffff9464daea5900
   kernel BUG at kernel/sched/rt.c:1861! BUG_ON(rq->cpu != task_cpu(p))

-> kernel BUG at kernel/sched/rt.c:1055! BUG_ON(!rq->nr_running)
   Call Trace:
   ? __die_body+0x1a/0x60
   ? die+0x2a/0x50
   ? do_trap+0x85/0x100
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? do_error_trap+0x64/0xa0
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? exc_invalid_op+0x4c/0x60
   ? dequeue_top_rt_rq+0xa2/0xb0
   ? asm_exc_invalid_op+0x12/0x20
   ? dequeue_top_rt_rq+0xa2/0xb0
   dequeue_rt_entity+0x1f/0x70
   dequeue_task_rt+0x2d/0x70
   __schedule+0x1a8/0x7e0
   ? blk_finish_plug+0x25/0x40
   schedule+0x3c/0xb0
   futex_wait_queue_me+0xb6/0x120
   futex_wait+0xd9/0x240
   do_futex+0x344/0xa90
   ? get_mm_exe_file+0x30/0x60
   ? audit_exe_compare+0x58/0x70
   ? audit_filter_rules.constprop.26+0x65e/0x1220
   __x64_sys_futex+0x148/0x1f0
   do_syscall_64+0x30/0x80
   entry_SYSCALL_64_after_hwframe+0x62/0xc7

-> BUG: unable to handle page fault for address: ffff8cf3608bc2c0
   Call Trace:
   ? __die_body+0x1a/0x60
   ? no_context+0x183/0x350
   ? spurious_kernel_fault+0x171/0x1c0
   ? exc_page_fault+0x3b6/0x520
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? asm_exc_page_fault+0x1e/0x30
   ? _cond_resched+0x15/0x30
   ? futex_wait_queue_me+0xc8/0x120
   ? futex_wait+0xd9/0x240
   ? try_to_wake_up+0x1b8/0x490
   ? futex_wake+0x78/0x160
   ? do_futex+0xcd/0xa90
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? plist_del+0x6a/0xd0
   ? plist_check_list+0x15/0x40
   ? plist_check_list+0x2e/0x40
   ? dequeue_pushable_task+0x20/0x70
   ? __schedule+0x382/0x7e0
   ? asm_sysvec_reschedule_ipi+0xa/0x20
   ? schedule+0x3c/0xb0
   ? exit_to_user_mode_prepare+0x9e/0x150
   ? irqentry_exit_to_user_mode+0x5/0x30
   ? asm_sysvec_reschedule_ipi+0x12/0x20

Above are some of the common examples of the crashes that were observed
due to this issue.

Details
=======
Let's look at the following scenario to understand this race.

1) CPU A enters push_rt_task
  a) CPU A has chosen next_task = task p.
  b) CPU A calls find_lock_lowest_rq(Task p, CPU Z’s rq).
  c) CPU A identifies CPU X as a destination CPU (X < Z).
  d) CPU A enters double_lock_balance(CPU Z’s rq, CPU X’s rq).
  e) Since X is lower than Z, CPU A unlocks CPU Z’s rq. Someone else has
     locked CPU X’s rq, and thus, CPU A must wait.

2) At CPU Z
  a) Previous task has completed execution and thus, CPU Z enters
     schedule, locks its own rq after CPU A releases it.
  b) CPU Z dequeues previous task and begins executing task p.
  c) CPU Z unlocks its rq.
  d) Task p yields the CPU (ex. by doing IO or waiting to acquire a
     lock) which triggers the schedule function on CPU Z.
  e) CPU Z enters schedule again, locks its own rq, and dequeues task p.
  f) As part of dequeue, it sets p.on_rq = 0 and unlocks its rq.

3) At CPU B
  a) CPU B enters try_to_wake_up with input task p.
  b) Since CPU Z dequeued task p, p.on_rq = 0, and CPU B updates
     B.state = WAKING.
  c) CPU B via select_task_rq determines CPU Y as the target CPU.

4) The race
  a) CPU A acquires CPU X’s lock and relocks CPU Z.
  b) CPU A reads task p.cpu = Z and incorrectly concludes task p is
     still on CPU Z.
  c) CPU A failed to notice task p had been dequeued from CPU Z while
     CPU A was waiting for locks in double_lock_balance. If CPU A knew
     that task p had been dequeued, it would return NULL forcing
     push_rt_task to give up the task p's migration.
  d) CPU B updates task p.cpu = Y and calls ttwu_queue.
  e) CPU B locks Ys rq. CPU B enqueues task p onto Y and sets task
     p.on_rq = 1.
  f) CPU B unlocks CPU Y, triggering memory synchronization.
  g) CPU A reads task p.on_rq = 1, cementing its assumption that task p
     has not migrated.
  h) CPU A decides to migrate p to CPU X.

This leads to A dequeuing p from Y's queue and various crashes down the
line.

Solution
========
The solution here is fairly simple. After obtaining the lock (at 4a),
the check is enhanced to make sure that the task is still at the head of
the pushable tasks list. If not, then it is anyway not suitable for
being pushed out.

Testing
=======
The fix is tested on a cluster of 3 nodes, where the panics due to this
are hit every couple of days. A fix similar to this was deployed on such
cluster and was stable for more than 30 days.

Co-developed-by: Jon Kohler <jon@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Tested-by: Will Ton <william.ton@nutanix.com>
---
Changes in v2:
- As per Steve's suggestion, removed some checks that are done after
  obtaining the lock that are no longer needed with the addition of new
  check.
- Moved up is_migration_disabled check.
- Link to v1:
  https://lore.kernel.org/lkml/20250211054646.23987-1-harshit@nutanix.com/
---
 kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..4762dd3f50c5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1885,6 +1885,27 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->rt.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	BUG_ON(rq->cpu != task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_donor(rq, p));
+	BUG_ON(p->nr_cpus_allowed <= 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!rt_task(p));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1915,18 +1936,16 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
-			 * migrated already or had its affinity changed.
-			 * Also make sure that it wasn't scheduled on its rq.
+			 * migrated already or had its affinity changed,
+			 * therefore check if the task is still at the
+			 * head of the pushable tasks list.
 			 * It is possible the task was scheduled, set
 			 * "migrate_disabled" and then got preempted, so we must
 			 * check the task migration disable flag here too.
 			 */
-			if (unlikely(task_rq(task) != rq ||
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !rt_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     task != pick_next_pushable_task(rq))) {
 
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1946,27 +1965,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 	return lowest_rq;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p = plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(task_current_donor(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
-- 
2.22.3


