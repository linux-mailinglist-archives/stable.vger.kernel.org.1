Return-Path: <stable+bounces-223773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJHGDNDLr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:44:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED42468F1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C31C3018075
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3A3E8C65;
	Tue, 10 Mar 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XnAtr4rT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA5199D8;
	Tue, 10 Mar 2026 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128636; cv=fail; b=DW0PFwQeJkZePFOLnAk3j2m30eLrKCwZL6P58cQnn15x/TsFjPGImq2r4S1jpBzaUGk5vEWtFON8c1Cnl9dYaycDl8hZRCa8Lh2ngQJcMJdfVOBZDGhannuYyGEJYW7ioUzb8ABWUgTISkxzkCIsi+O53JQ7RthmbnUQsZ1g4p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128636; c=relaxed/simple;
	bh=LW87bAeZ44YYgsZepxRx9DolKEHJfNXWOyZ97u5zEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c1sxCw4cJruwUenaCeitBsCo2M/m9co415zpajiAR7rKmOuDywXiIjv2Z15hjdjSMvKDckJ7F9+A0fKxzw48C5Bn2T2HG0yxWf9Wlkaw1KznfODkssHYu8E1Rt5WzuRviMqfgqHQMVU+NvW2o2FOkF2oN9GEgN5njTWN36G4Zec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XnAtr4rT; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A5GSpY448864;
	Tue, 10 Mar 2026 00:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IGHX2nW1++dMgRZONduJ/hd+icFG3n/Bfl+cbtSXVOA=; b=
	XnAtr4rTnxHt/6vnTZmpTsarA5+BmGfv7QNZVdk8xcXV2m8q0KeEi3/ARWLUTIG2
	JsmbONziNuxB/yT/nbVCIqfOvQg3PdZ1L20Jmg/u8+L+w4ZNHDrVZn/z08Je8YHx
	n6pKZmbspkdpBsOOZYLiNP+HI947InDqUHnfXEqtsYWcpTNEUE/X/ilIwi06peoG
	VCcDPGSrdOB5vvOCugKoY33Vp3PghFDImxh33L4VXfEXyJpGifGygiQ5dpT/PBgt
	rY5tiNM0d3vmT0fydx+p7mKom3pPjla1t7aMSYx59i1HKe7ym19Zi4H31xK6nDdU
	94zsNHhZocrpc03zKrerPg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crmdm2m3e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 00:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL9ezFaKSqIQ2dhSdzZ4MFmUVrDQZV8sGdFPv6ESrSNvffETw24ZGgarlYLgw22yvruakgf2QpNR84NsSMX/nIkzAjKB5uD7j7zXQv5GVDUgyGdOTbJYjXLZ3izIhfWkN7nCZikwzGbtWftpSdUva+JQkwe3SnCIEVCSjSlhjfy0/JjYualOTSBsiC8MbKdDW952V/m8BotkATHCwqIlKMkIto4SPM87ujLzb9hp/iZVH8u+rjZtA8JcRWuJUVEcZOWWUkji7MRR4km0YhNvdtaqIpD8lQMrNGE0tIAaQKLvyZSGR2AQ0rpj1wlQpbJQac1DVheEj51scddY02zobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGHX2nW1++dMgRZONduJ/hd+icFG3n/Bfl+cbtSXVOA=;
 b=VvqGH6baUPIsy0Yemw+a/R9lg81uPp0rCBadk5aC6Y2CJTL1v/JM8Y1gkSGqeRnGt3VCAoLCV+EZP2BW9aMKQtxzGs3Mb/mfQTqR/Jc06BhuZzA60+GNv1Ypo/NpZ7poDHZsvXUv3D27/jefcGPZGAIkK0yybwVYvn9G3GtuhX4tkctCykRxYI6H8w7aX6YUbesbiRWr8tl2vH6/QAA7hYHTknvrWO4kAA4se6LlbvUUtvISsuoGqtvFgt/SEvDQUs226ED8QtMxykgvuRS/0dfueuoh0JQMh/zXRKZm4JXBJoAIQ6fHXDFwWpoD80dXTI6kWgg9zcPhocS2okdGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:43:27 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:43:27 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v9 1/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Tue, 10 Mar 2026 09:43:03 +0200
Message-ID: <20260310074303.17480-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310074303.17480-1-ionut.nechita@windriver.com>
References: <20260310074303.17480-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: c1767146-ec96-4c15-c265-08de7e78b748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	B0Bgr34bc2eFnhjnXO64Lh2f2SBndrjud5ChndBi/W4r7zp9piONC1KVcD8rX/aVINYmVzqb15/12DVj5Snq6YSCIYPDJOR+Eyw+Y6Kdm75Hm2DLrdwtz6L0iDnISieyYZ2RMkb0a3aQui41LCzj8b4V8dK5zJt01MBlY3kWDtsEsug+20CMDp8mKWNOsa7Uq4OMzmsiaJFC7AoI+MekPRCv+8YvfIgZNcomhf4lhaYVZHOAq4guOEyvmsfFq9InCwVy+PkQZqfYalIyLtjADHTq8WMPjIPReW9wQunmG4FB2UZkMJC1krL8FMw8oEOjnjRIT3yO43Eyz5R6cqTXab1wehf4m1og6axjIIpQstRYMsm8bWc7dQ07VJ/HT9fGgO+i6q8mNnp9LQc6FGR9g0KKpXZsE6Oi+tlEZdI/nbThaMbwYVyW/qE0DaHk0z4OdcbTPPqXdWEiXDW9yNojs/faqYh1GyY6r9KO1t+B9wn99MxSfhXc+MxgpIST/PqbHVRJwWMaeL3tjxNIZdOYE9NNyEJxY1vkHO/qKH7oEXtKIUYQYBQ7NVDQdmo0rW10KvCcMkNbzSK2BlzOdqntEZtv98sYDraJy5t4MGz6HVpxZoSVjoCD8SSS1WqQZk2mZWr33LoVbexkX+zTPAavLj+wlOwKB9VoZTdmzmlBb/nMFdL/lvIWxpUrm005UMGhiOUUmSXz7zqDV54VwQTevsKZnCdjECIFQkMyZ1pQxG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(52116014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMsKTIrByrV2J4o3ODxu+N+P7uYn5PZcblnHtvJ10Dv1Glm1Xww4+eZZBXAT?=
 =?us-ascii?Q?FPUOR50XisxOqFTpUGoXr8EQLq+yAt1FDDIYCcVIiEO3rqWB2vngP83vJnQY?=
 =?us-ascii?Q?fp3bZHjgtwZfCof1MXLnxCvhuxYtrzNFJeI+88zyIJyBaSjRCK8i09D3kcOt?=
 =?us-ascii?Q?cxc8FsvLWqsf9MVP+NHUG6ynJaT/8sf8M28rhZ1N85PjOt+rkGv+24Nutz1k?=
 =?us-ascii?Q?Xv2jwVd/62Fgn6BvRJD0CfauDybxJJThpUHLN9l04HhL4GlU3zU6bEO4M9q2?=
 =?us-ascii?Q?iUC5ukdUWNCtDLMD7diIewx1rupw05//JVzVOQm+LLm5D39+dU9WaA5xVEsI?=
 =?us-ascii?Q?PzWr0/NRPEhKCiD8mZBRqdFqEUqdJL0FG6aTeehYGetB5Tr9AajOL1l/XuTw?=
 =?us-ascii?Q?CxytLA/XHInS/nax+dJopyDd2opPUmccvZhuGlBdzvkSchn9CLdCUAGncYr3?=
 =?us-ascii?Q?0tAntCiN6Q5TRN/CgSuoDaZfC7UYUSUNRViemv4gOlLF/1coVewp9QvELQEF?=
 =?us-ascii?Q?daEU1n3OkxcCSaVIGnUBjWvAKTECPoOo5nnxr0p1cl39EMpQhSfLzAeTf5bS?=
 =?us-ascii?Q?dYrOqviu1nLbBUZqQ7WES0VUM0o2pj4hl6eD+SuP28cS/GsDW5CBdP8zp8nQ?=
 =?us-ascii?Q?tR/A8YkrVNIZtO6OZP2Ylw7ES7bS7Wb/vaFDtZx20gLC1aYqs/DcKAUlcGRs?=
 =?us-ascii?Q?EjrsihrctdAkg1ukvrhdpoXAj/+gbWDMxAhBtiHdRi4yWLMpMyWl8Bl7J4ns?=
 =?us-ascii?Q?eOtn9R7hXvavNLS1khtGWDOV775VVQNA57uPsYfZfg7+2CuLkPrUM5q/2bro?=
 =?us-ascii?Q?AtUsRTMe2K7wpVeef3PGyjw/cRYBSBLn7L27zo/R4RkbwUoiz3QGu35+XuAU?=
 =?us-ascii?Q?ZZLlXK1z+TQcqazWMiFt6lzsvKMbnhbOKYw0LiX/e8BZdLyDm690kkEoAxX5?=
 =?us-ascii?Q?Nc7KnVj+EMNeHi3yYBFpwdW8drVF0cxNNt3owKWa/XRPsuIzgdkcrbV4sDyi?=
 =?us-ascii?Q?N666j7FIbZ/TONvF0QXI4H+laFDuw/qi3JuZzycQfUfJ/b4pT8xXLbv9BUdH?=
 =?us-ascii?Q?fK1zDFCH+EfSITXRiASpBARA+M/NAtLZa15omxlpA8iLKih+XpY1426b/oGs?=
 =?us-ascii?Q?Gw5Cv+/gW3qTXEewB8b2jIEKxG4YcuF428gORsihakbYCvYZlI+QFSbqkzkr?=
 =?us-ascii?Q?gvLRJK3t2aVKfsjSACC9RmaxlzM5jWg+EVWAX1SXqxGfth2i5yiNlk95kAE6?=
 =?us-ascii?Q?/yEQyA0/oPjBVxpmAt3UfiLAk+UYGKAFmvOyhJHKzBNeP2fVxS902xmDumPL?=
 =?us-ascii?Q?XrBhEHca3CEYzIZWR9aVIcCMIwE3I5029xdqkJ753RVxjI5EsPIzEFy0iE4C?=
 =?us-ascii?Q?TJl6Rfy+8GqgL0a9ZcauCX6RIN8+FHK/shShpf2T9ooozW0+tYStj5NrmhU+?=
 =?us-ascii?Q?rzUSrBqcvA4TSDsI4b+rh+LSCjtteePom4wrfCF2Uz/32NmTXpQpkais4vEm?=
 =?us-ascii?Q?Jku62JXhrtjfBC2SXaCtlFsf2oc1cpDL4CmlSQEF/3Hzg/87/BQXmK8Snf5I?=
 =?us-ascii?Q?WfUzwLO5dbA8qwPhIWUiiaDLfWGvoVbh7CoiTkUjMROk+mA+i3S1r0M17LKh?=
 =?us-ascii?Q?xbxxyB25GGMlFP3ZvIiIg/Tu3B5LRU+wxplMGVKJwX2e+3Kt2lDBfTm7lSK+?=
 =?us-ascii?Q?/o7G5p/rSM5XgNHuu3yrIXp6WPwkFJRrkLhQVev6gU3S2BFfNipfS3ncJW+Y?=
 =?us-ascii?Q?h2ao1YXg2ZVZa8lSuqjMDHkE4FltMnp1IK6GL4KvWJLOodB9jzXEpoxzLxxi?=
X-MS-Exchange-AntiSpam-MessageData-1: wkzzZMk1TuCW9T3UTOOMLI25aeZLv7ZDXbM=
X-Exchange-RoutingPolicyChecked:
	JZdn+jJxBG59vweeWVGJBPs7V3HpcqI8QkzJQK5iMoAX3GQ5o5OMIGAopvaMId65+skfaYIuZMW18EBNQHhvwWyYzEhNEhM3KIgpAv8LIxCCI16QnnaW5l2FLYHxjXbS78fDbuYnOYrba0Yomo/Nn0n8GcVXVCj9dbCr9ADCTKWXw78eyJpEazdahNISz/LA1zd+maPh+YFuIiVScw1pJH4h9UvtN/z+RbxCLD5+aazm9VYrbNwc+GfW9S7w6Ifoch/uGCNGvPq4kFXp+BGH8YAJjrO0A8m4EnnGLSS3cO5r8wMdhEgFuhxLGpT8t17iER8oEUzOgCyV/eBf9LXEQg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1767146-ec96-4c15-c265-08de7e78b748
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:43:27.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB02D3H+P1Fo0KeNomJL9MMgkEC1Gaeqgd1WJW+Fa8yD3QO09G+fcQpSzP1LeqkYMH45ipyseGGigzp6KPdMsTXiUBGCILDq0UthrP1ymu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-Proofpoint-ORIG-GUID: N1gIdvPdIJyZEC1wcxk8ky8cKsO6XADV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NCBTYWx0ZWRfX2yXhkJ64cYfo
 vrmQQyLlUimv2i1jChgNOQTZM7tjbmkT8a+zsk+PYE4F904nfzL9qajc9vQGoQLWc7WRUyFn+xt
 roGKia/xBrVwhgPmWIIJzn570iJdGJb9HKwJCtikiyLGRO4E81emnAfDQ4GimpGbEmcAfqWlSfM
 yYXNn24PwfF2FxGEOaazcSvAn1bmrW8gDE1Noxf916qwBTh+y9dXi5KtxEotcW7E8BJfnQb9r3j
 J3RLeDUPcFkPtoL3+MxJ2QxwG/48MpiW7qRt6RJ/9DQfNSwZqPurtkFt1+7BuJ1q3Y2GPNNPXdn
 D+7nGqFXPTbwB/hcIveJq16+/6bLnrUTqu2Jq8bCzIOgCkD/OLipPHOWE4LNXOlI49vJPsogVC/
 RrNQ0yKxmoYwH34/BvaxmNWCZGyyyk7BizU3TBJObGobgOTYyZ8V1CmzEbQg/UJNkjJL0MnrMv8
 09e1CMu2QYvNrr3R/GA==
X-Proofpoint-GUID: N1gIdvPdIJyZEC1wcxk8ky8cKsO6XADV
X-Authority-Analysis: v=2.4 cv=QppTHFyd c=1 sm=1 tr=0 ts=69afcba1 cx=c_pps
 a=jolozQ03zpjfpn/maDJ7eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=CjxXgO3LAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=hh5_vNSPTWDFZ6TSUYYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100064
X-Rspamd-Queue-Id: 42ED42468F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223773-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Make pci_lock_rescan_remove() itself reentrant using mutex_get_owner()
and a reentrant depth counter, as suggested by Lukas Wunner and
Benjamin Block, since these recursive locking scenarios exist elsewhere
in the PCI subsystem:
 - If the lock is already held by the current task (checked via
   mutex_get_owner()): increments the reentrant counter and returns
   without re-acquiring, avoiding deadlock.
 - If the lock is held by another task: blocks until the lock is
   released, providing complete serialization.
 - If the lock is not held: acquires the mutex normally.

pci_unlock_rescan_remove() decrements the reentrant counter if it is
non-zero, otherwise releases the mutex.

This approach keeps the API unchanged: callers simply pair lock/unlock
calls without needing to track any return value or use separate
reentrant variants.

Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
removal against concurrent hotplug events.

Remove the rescan/remove locking from sriov_numvfs_store() that was
introduced by commit a5338e365c45 ("PCI/IOV: Fix race between SR-IOV
enable/disable and hotplug"), since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs() where it is actually needed,
reducing the lock scope.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..7ed902539051e 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,9 +495,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
-		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
-		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -509,9 +507,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
-	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
-	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 
@@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -766,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd794..ce4d351b5aa21 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,16 +3509,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static size_t pci_rescan_remove_reentrant_count;
 
 void pci_lock_rescan_remove(void)
 {
-	mutex_lock(&pci_rescan_remove_lock);
+	if (mutex_get_owner(&pci_rescan_remove_lock) == (unsigned long)current)
+		pci_rescan_remove_reentrant_count++;
+	else
+		mutex_lock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	mutex_unlock(&pci_rescan_remove_lock);
+	if (pci_rescan_remove_reentrant_count > 0)
+		pci_rescan_remove_reentrant_count--;
+	else
+		mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
-- 
2.53.0


