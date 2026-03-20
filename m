Return-Path: <stable+bounces-227610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGCQGF6uvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0492E0D50
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A303A3073F72
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9645531F992;
	Fri, 20 Mar 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="X8j9Gglr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26886329;
	Fri, 20 Mar 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038616; cv=fail; b=ab/3nWu92WoBxe510q0NET/LZzuKa01ewR/1cgMp15xXAVGDaZ0/1I5O17raJhCKKWbfXZfRcN3Z8lseHPJLE0SCDIxJqRa1FP9JY6DCiEKTTQznRqlQICVmUXJrnR4/IAaTTaaGaCoEVTbkB1xGBoeYGSVsmnKiSgt4VqpeLkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038616; c=relaxed/simple;
	bh=FjFO//s0CnDz/eZXgmNtYwKrQ+L8091cvIMJGWW03ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BxoUnmT5bpWGVfVX/Q7QelGIFNIcuKQAMouVfUvRkFy7bE/Qu8xjNpwL5a2IaJaOC6ls4CB6wwBUVuVwIVr7NH10P03MGhlaPwGxzf2j39q3nRCWIO2w7XwURYPedt9UJ/q8YxwaVY4DhBVlORmwYKdi02MHI/Hw5pTQpsdHYRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=X8j9Gglr; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K7o5mL866812;
	Fri, 20 Mar 2026 13:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cvrQ3C6Ak9j0LBQpR73cEHrSq3KjGHnbGlITKZAymtQ=; b=
	X8j9GglrMpXd0R9W8yt8x2HuLWmOukeRuhRJSQ5cwdeeU28HCxTwkHZIH5G1COGj
	LMNkUI2jZuYg6Np7JpyQwKrGI6E5nozUBT6Xildwhgx8DDJbKzITDJ+JMpsRWB91
	XAV5kmXgY67+H2kGyuvZGkoFX4BqreUr9TUw0SFStb2RtOG83whPW8mIZ3oePmnL
	jF2RQz0E+QSOVWRyIZrun7R3/5LU5ThVNRBvtywucwmaI/nKUG/HsJhHcEaerl8P
	KtZ/S6Tml7IpqMe46jLrzMXz/A+FphLY6+2r3AyUV2tTBBHxPdKZ4jUn2GgYILa1
	H8lFWowaU161L8SRgr7nbw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y18jnr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 13:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSpEq8AMzZkybwkSb78JAp/+vL1IreDwKUpNGFKX6C92JsiqqPcesl5SIHkpBxq6khOEnFaK7Yg6kgOPojijBmxR6TsMQ1gJLX2ua1YsjYxVNCD927BZj7wsStcGEFQ78Q+IQDEbczkowSC0kTtC0a5Tq6VoE7c6fYwH0+xf4qb/mW8M/EC00WA13QJB9tc1jTfc22yWM/fn8aCtci4nnWofvOzzaYrRvveh480yKJ/uHR04X9Qi4pSOb1pzmjzbmetiCpsXHZ4xV6+Ovag3632+OX9VC9sRBnAAWQXJ+BDoFnkb44z1Vm6O3z9/Okjb4jfEl08rPQ0I/Z9k/5+u2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvrQ3C6Ak9j0LBQpR73cEHrSq3KjGHnbGlITKZAymtQ=;
 b=SFJTmICpwQQbinViRR/P8USy90xvYO8bPyT+LpBIfM2ueaUzh+zhjyXz7y/A6ewzvmpn9P9NERG8/KZjaGW8M1qh3h5kXQ4fLy92z/9CfkHmzC2YuuEK6zPonazJBx+84UKE0Ll4arujcHq6q4slXFOrdhIlZr55STeekD6yEq8VmizXujKu7MvxJ6z5SNK/x6YM38lyV/iP52U1hhDizBoVecLRlvYtYb24XH31WdfaRWRfJ9+v3afp2v4kc4A7WGJrAp/1+jgwQUzm7PhFnyBQYW8dCVqSN0HZUYBlfLswOt69bCwJr88VDAVmUn7b868iOtmx+r+sTj/6q4TrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:35 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:35 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com
Subject: [PATCH 6.12.y 6/6] cpuidle: menu: Optimize bucket assignment when next_timer_ns equals KTIME_MAX
Date: Fri, 20 Mar 2026 22:29:08 +0200
Message-ID: <20260320202908.24377-7-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320202908.24377-1-ionut.nechita@windriver.com>
References: <20260320202908.24377-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: d27d197c-388b-47c1-f491-08de86bf6662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V2xnJrLlyaaybXPbRfdjzqWxtE+JeYHGSD3TNKrbNwolZlWTnrd+vB9OPk7P+b79+R3P8vF2VoSqH9yigKlVb3MMeDkhtsX4xvoqcqPVKZOW9F4OpZe3Id/ksitsH/PxjG+BJN7xS37bpxC7mJL71fvC14IoudFyxbKK/hE0q9VFPbwKlU5whEB42LKP3+efL12ER8CaOp+TWqMNTIuabs2OpY22UhQtlfd27D19sLrabvmQZ02PUIB5sZfh1yNT0QYCKSlA10po9JyWZsk/eWpsaWQpKyqzWQWT0HokK93B1tYcJeWH0ceIED7w8eW41Dyk4QTSGULK5FZ04reiafaG/zXkUSjN/yC8HELT9dGwQ6J3PjSGlOjAOyB+cp4buYFt4Hr6ld39jIcZfH4+vchA07LLzHbRHOJsjuHOVxqhKnGY/7mWav2lLcGnfwBmT6w6bQ/V19u88pUg4eejF06ohwjnooFQK1NclTTyZrC05SG+yp17nRCe2nBi02JMkXsjzL20eiKGqtWNqPK7qPtE5db2x9NbLZWgkgIYUg8UDGXibJJTUymxmzHAIgY35njnDqkO5NJmN6FZ9pvbKuNCgWX6rhoSnKCdXCB9NnD1KymAiO1ej/umq5AVwkTm6CO/XUJEDkaevrqBmePE+KCtxOtlqDInLqaa1pYfzMRYOE0lhJigPQhZcdf4DOBJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p37iHOcqnzn9XXsj728LIIPYO7MbSgxxJMEHbStl1GtcQKitmWmvu13dycyB?=
 =?us-ascii?Q?1dxx/0gZ65flA8mKR0JKNwNqDFiGLwzKH33oa47neLj1SO317mRTn3k7HU8F?=
 =?us-ascii?Q?x+dzPQtXAbNXZUgAYjVPbY1QfnAy8LyVCWRGCl+I1/2TXgnXM8a4tC4ayB9N?=
 =?us-ascii?Q?2sAWfJPioZZRIbtPgkSqXLf9rhxC0yc5LyMw+RH22qPN7PCEHf+CNq7NCzK1?=
 =?us-ascii?Q?J9lzUYTfaEsDqwZW/zt4h8VmN869zznXJq2ZcSkt4kBCGh7+LRAHDJBjf3mw?=
 =?us-ascii?Q?IkUgqJT80hJ3rRVuOSPhBk7niJ2E9UMgEvum6i1CgG+9MY4x8tBQYh51axw7?=
 =?us-ascii?Q?npXPLAWtvqPKkiNGhLjRidmR8OWKYCis+MQ9wrFj8nr3mfWod1hC0g+6SXCM?=
 =?us-ascii?Q?HZk2RnfmhfFw8cWvLYx56cJnmGJ9lA8rqnWYyxyH5W9iLROex+ijESZbH/al?=
 =?us-ascii?Q?zdyEtoJE49Ch8WbpvwejBmWbMXNwpNj9fZfhDrQsCMayyr5O/7ibd9BOIvun?=
 =?us-ascii?Q?gTd1AGF8p2dlB488aHqf6l/hOMPvo1y+a/iEZkS7ph8N68sTUlNL/Iau+5un?=
 =?us-ascii?Q?ltuKEgwB2gxiWCRo7IEbdDqNX9eh5Yn6uE+GiiWTVJzWFpYljeLJPCLcR7w9?=
 =?us-ascii?Q?TERJMdbLOgh7geap///bDHm7KLMFWhy/+a2Yg3E7e7o9IKdlK/lvBef4N9+P?=
 =?us-ascii?Q?8vAyDggQKRzyfzX+2ECyKAHA5vloLk7cu/NzSqQqMaq88iIpRkav3xxWSfAT?=
 =?us-ascii?Q?bPZjPejp/UZerXhkEvuBFfvlHnQR5WL0XOx6rdc/+YvD6kre5S6zEi0da7/w?=
 =?us-ascii?Q?N6frMjmnlAYSfr4VqpSbvIjp0mxBfi4qNrQf6BKiFgrGWJ6H3mCneM9O+FL7?=
 =?us-ascii?Q?LMCjcBV21HpxrjhRHbvKqcWOqqvXfwdA2aMDWbOcn0YgXDib3X5FiePUX3Q7?=
 =?us-ascii?Q?9wCVSxDbWtpPctkfuFLbRul67Woc3YB0x8kFRjs45ieIAf0XNklWdduZOquI?=
 =?us-ascii?Q?eBq2OJqSCK9vRvhICn8g1kGGvkZB0ET/gvPvlsp36VEatkS5G+A4ZLE4mQl6?=
 =?us-ascii?Q?gMduwrpLNwxrjYvR/ZMIr5dZtcORSAeUbJD04SDW/5KmsSh+6iQ8YjEJA9vA?=
 =?us-ascii?Q?LFpi/UdFt8Nj6DLdJxQ4qXlNrynbUbEM3Z/khtzDCoEGWmP5GU2KzRJIpNFU?=
 =?us-ascii?Q?90fAF1MSAJy01n1QTmt7D7leXOhDR2KTdVHgzCBBSqkWCGuVxnyPXSbFe7jz?=
 =?us-ascii?Q?bVVZZO4lbJGhnXJc6FWnKgyrLRO2PqNjaBhgMuSRFVPyLqmzDHmZniK60SIq?=
 =?us-ascii?Q?WZ+xvVYOwGe0lJ6yDDrAa0kbMjLqtxh2j7HGbWOyE3GCZbQXRnvF8oNmMboo?=
 =?us-ascii?Q?lnGMyae+TLu9e+pVg9WNHSB4kknXMkvQvLoQIxi6s1d20SFXDw6O/y4d/8fr?=
 =?us-ascii?Q?/peZnmcrZD4PClPqcozWRqqqmD57UttpN7IRJRLFMDzOAjeEUdwD6fu7aCLf?=
 =?us-ascii?Q?kYiNIP83IZkXqllWBXT5dhJQOjpKiSveE2SfvaZUa7OY9GrMP0/yvLXPczHJ?=
 =?us-ascii?Q?35arkydEMFn9eLQh/RDdxqJGutX10JyITa58jzF8GWmA4Ua+bchbzouBeJX6?=
 =?us-ascii?Q?Msi4C6WFsXfYkF2ek0EI41T/sA9xO/ZDC1OtuSC8gsnhZSV/tZp0bLzmn976?=
 =?us-ascii?Q?0LUffnsyEumygLrQ8CpRU/fAI+G9m8p2GObAtdoT8MAjmlvFggvTOEaPh+Ss?=
 =?us-ascii?Q?bQTToGBsgbFLpI0Ykkbiq37a5d448uhLsdHc/2sT3O0XFoB4gVeKStA5JZCX?=
X-MS-Exchange-AntiSpam-MessageData-1: 8IkrBvI8Er+CtYRjvuPb4FDnNP+xuHNdr4g=
X-Exchange-RoutingPolicyChecked:
	kpZS/B5n3xvTw2ceDryNvYzwhy7ECpu//BGqVdlW7bYa7iheHJsQUD58WzOdnzBFlA9ELGs87IgApSIPbQXTOK5z2vKR086oUjoGZ/kn+KjDrn9c5lr28uW6dfK6JK51ebToN9+u/nLrEnpTTQwXcLNOxseTNfHDTevLFVrishAXLpJlA441Dq/yYjU+X/xKPOvUq1J7UbCa2L1ueW87CarhJNtflebldSAmaGVQ7NpiNgt8MQO2FjtpoBe9Xjc5TfuT6wY4RGMSjhy5d1d8pgU5g0ElER9xS1Jbc+7Vpkm4DX5T6Bvvhif/Km5eDLAZfo5B09dQEwAiYD3CWLP5OA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27d197c-388b-47c1-f491-08de86bf6662
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:35.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igLSn7zclx643VQyhtW5ruT1eCaYG3tePAIPQuA/qUVu9e2qu/Z5VUzVwHzVRjQYwG80tK6mYjGUIM6oR4wPF5mJuXJXF6ksPw14mjZ+PlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69bdae31 cx=c_pps
 a=tYtg4CXWOAG754Cl0Lh34g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=bC-a23v3AAAA:8
 a=COk6AnOGAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=Ui8lzZ2IxrqF2Su2ZNwA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfX7IhTQsbP5ceY
 tn91Vg9O0lbuiEEL3KxJre4XfSQGoSjLvS8CZ/vY7JoPPdUgACV6C5IQA1d1oxvfaxxOV3gG5v/
 UTezUGLKHqMkLEw/S9kCwBk5cH0bGMBzeCjQdGGqNvad+Eylpe5Md6pemq7g2bRLNflv+eM0HiG
 qOrs09fgCqz1odINZMDOwEnSgQdnvAkjDMgwfz4yzQvHCfAiYx3RPwMkld0v+0slUKzmlenpaE1
 ZZ9n6WrMBdP778P4IIjOjI3TvmmLnnLU7FeKRwc53b/+QtyHTmGlP7qu7EoS3N2PZc24tY3TQTk
 Aw+3oyuPmKcflG/84hti/p/HpfOPIKQ4G/xyEFqiBeXnXF332MLrGWZUm5Hr89NtSCQiDKdi3SX
 o0iAMZy4vn3P4Jce8ltkO1H4K0xXQM4xC57Jd2ZQshT/lMGCsQeicG7AH4ZpQX3VNCLAoKiilq5
 oNcd0JkQB5q0+ms/ljA==
X-Proofpoint-GUID: LoOk4kkD6gEDPakxEp7rkuwpNQGY9780
X-Proofpoint-ORIG-GUID: LoOk4kkD6gEDPakxEp7rkuwpNQGY9780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-227610-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE0492E0D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

Directly assign the last bucket value instead of calling which_bucket()
when next_timer_ns equals KTIME_MAX, the largest possible value that
always falls into the last bucket.

This avoids unnecessary calculations and enhances performance.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Link: https://patch.msgid.link/20250405135308.1854342-1-quic_zhonhan@quicinc.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index a18477ecce433..ca863ba03d454 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -278,7 +278,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX);
+		data->bucket = BUCKETS - 1;
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
-- 
2.53.0


