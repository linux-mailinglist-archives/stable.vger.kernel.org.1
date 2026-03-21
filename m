Return-Path: <stable+bounces-227758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFoPGxt1vmmZQAMAu9opvQ
	(envelope-from <stable+bounces-227758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857B2E4CA5
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E0A3012260
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820431F9AD;
	Sat, 21 Mar 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kA5wu+ue"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3ED15E97;
	Sat, 21 Mar 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774089481; cv=fail; b=YxZWg6kr4ygR23NMICXAgbSqzzeyhx2jyieULr35Z6b71t2D3cYiu75Cy2Y0HxdnA8UdCzOcWL4w28XZXOSIFlDScSvMkFPMHZCD70dzyPEFwCXN4o4KURYIUDyqViPyn9wWHptGZMJOAPmKHSw5dGHBEGCS51C4d9nH/VEVvsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774089481; c=relaxed/simple;
	bh=2HxsrKbxKsAJ0afzONfIfZn9z/Gdkoay6Fku3uOVu3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAeIu1lbzBdKg3YBhm3suGvaIX+gnVpkQkAzdWjhh8mcM0gjkLU6mE460eBax7vz5uGNTIOA4P6qiN89QIx8+WzD8No2/TjfHyYpjkUZD+/Em5kkIo4Qr7JHB5JZe/wYD096ouritb4IQzHl5tGEug0ypvuXxVA1uQPWxG+g+Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=kA5wu+ue; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAH2Xx3561056;
	Sat, 21 Mar 2026 03:37:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=lhXx0BdkEptKl1QXEyGxXJycTPqFDQCrmeUY2KglEs0=; b=
	kA5wu+ueNeKzaKJQ7KYcl1C1HSOMgjWkxmR+ejUWO3JvUGHnTz3NbdYm4pruUXXs
	cgSWCLmgWZwnUfuqMqH9C1HQX+bMf8WATaGKUbLLlxN64RUYg5Lw/WpMsTUtPSI6
	WCY4w8cz5o8hLYtJU/hXFMylqcTj1bHlW0Hh8xqZsY79SlOK6BPPeaw6BsfYQYcR
	Dkh6wyYFo5aHRdlSbsB9dqUtTiN0EtzaIcGbGYLE/BwUpEUBagruCoseSmUOblzI
	5E8oQbMFP9N8+iK3pIBiqajS1poX1yCgfGA7wzxTl+mypmNl02rpP2Ne8w5oewdT
	WPDcEdHyS0NXrTKObXExkA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1pky83bw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0Cb7o4uDJwfV0+ibSYBRMum86zpEMVbR2fCkkXtdes6fGrJJijRu778dWVdHW5jxMwayq4mPtTz5QE9rSL9Szw/Uy1TXevWk5qgiNKa5R1zMW2gyrcv069fE7IeakHpL97qNYd9iaclGGp+AoZrG5vyx51egfyuA0AqhOwB2Lrc0TKGEzLU2LIminAPTKcgqV4JMYvVGW1io7p9nRbxCC1AG7Elcp+wmU9nLm5ys6nCXqyHHFaAkRX+AMPfMG5g/gpFzUxoWTS9E5WnwbTD/jLV54VMMEaWkcA1bOb8s5H/6WSvLJg3WFujquqT0bj0FQee+M/3ZIc9+mQ0vXbpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhXx0BdkEptKl1QXEyGxXJycTPqFDQCrmeUY2KglEs0=;
 b=d5apcOZT+Toe9F18mAc6wjyfmuLZ0xOzlxE65kPJuvad1sgGQOFDN8v3O3TnKF1XvRPnoPjkGvV8SVjbFO4DhgqQaf3PP1TRfgji9fkQ43RCXMLnVX80TiX5dsvsb8SdZLOtPARMJLPSLRZQkXMceUuLM2QWIwbvvSO/nlmvdkE9zk7O+7BN+QjiGFyhisknuPxLotAggzPKBchs3UgjbkirmeL+icTpMuVAnAbBLr6WplgNxXMBeyPp/SB161SrdRrDP1tTkbHsBGXZ2cN4mVVrzjtyKNvt3SPOA4dUdUu9hHvt8TN75MLHcSA66cIhZVN4iF0VFEUgy+xxGMxJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Sat, 21 Mar
 2026 10:37:51 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:37:51 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 5/6] cpuidle: menu: Update documentation after get_typical_interval() changes
Date: Sat, 21 Mar 2026 12:37:20 +0200
Message-ID: <20260321103721.35114-6-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321103721.35114-1-ionut.nechita@windriver.com>
References: <20260321103721.35114-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: af5f4618-8905-4f12-153c-08de8735e6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/Dmb1lTYK9Djw0vBzHeZSiLmM7VKN7qxJnBEYF7Gv/lXMJtqoPTL+Oq4IJfajBp5Vg7nhVIYKALvEJRJWx+xRb9y0nk/9ktp0I/fnv0AZOImsONxAARsx6bltn2u6sZHIxO9uyOg3biuBK+JB2WwEO3BBDUaemGoNZRAfHlPQO2A1a8Xc5MQOGS2kqejWho5tQEtYx5UEPSK5agKUtTnGm8B2cYQVTNlSGViu6rBwxKpigyMCZ0GFPLIJbGPTCSy+eN4FTkn1gxH6qtDbMAjUaBnw8ROgbp+ZbPRy9xVE2MecHvHA1Ticlq8eGWK0HIaEfqCdHQ4etj5Nx1T+6vWD4gzGV+C4ZM3yHmLA3StkPiIgsakJfIF5DyUvd9jfXUQAsjvYgO0uwkevc2ghvtnoPZx+U+vrJSo1cyYE2jJSxyfHALpS5R2Hx+19XQIhHmSjvRP1F3HdAJBV1YNro+zs1FrfGywQubhd4fO5B84kokAczX86X3cgFwTK8NIYIsvtO8xh2eDOhvemC1L2StHAOPIbUaljj60oGtVFwpf6WpOD7IEs/2XvPF2XlEOdItEDwgxsN5TIsRaQPbZU7aMMlsxOxKOTLbX0bIzhqEYwwvTvA/hAHrxdE29bLcHdEGHCiGXfbTRScJnaEOpCqMwthtjhVrRw+WG5ORsKh/2pj+AxdnpAtkIlfP4weySy2Q2J0OuCNZe+qG6ZVN4KonCQo/5GmVIRGth3ZG12AmMQzKUeEtpL6SJd+y12VwfEqDL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OLa/sAzotVw2ZuajELFaS+haiYUFQx8MLRRbDOn8V6Z2QhcTVObWXa4xqsv?=
 =?us-ascii?Q?HNtDJPQXX5tzTWb8KXJo6sOZRuCPQ50U6k7EQlH5jS3a74/JfqapV8DWyvm9?=
 =?us-ascii?Q?d1GlHkz+ghu2vJ9KrZozhQrZmcj6MEfg4lD88fvmN872wctg1Ocz5OE8N8mj?=
 =?us-ascii?Q?OcTSA0Z3QfrnFQzZeObfkNz3v/ZDhVCBszekG1SVi8yZobZ1OnlbpIUsCTv9?=
 =?us-ascii?Q?A/WB+ZzGMVsKpPZwfRupHSLOj5mmZDWyRtGH9WcS/JaJqT730yc/dKDQGQZF?=
 =?us-ascii?Q?fWsxSXU5VUM9Y/kPb7DmpLMlUjhlM9a/gb5iECSbS8QXoUdJM3FldNxT/eXQ?=
 =?us-ascii?Q?Ib+crs52qcSnwlqKIBHbNO4D3hNyQSb5/P3tGDYqfgoAgWWLeYe3pv2c1t7d?=
 =?us-ascii?Q?B22ZCCK4k0XUNBejE2Xucly0lZD/DSO/HDktxYigG3XhdbR0khxmtX757vFu?=
 =?us-ascii?Q?IPNrmHm2jvKfrew5yFcqhWdWkfx/caM0+po0vF14s0jsa74ckWOvzkr7dHOf?=
 =?us-ascii?Q?8qPEIaCvdWTI4JgFaMb4XNcJrkhcgSzhpUrqtSDLYx6rQs8bgkLEYTKvhD/s?=
 =?us-ascii?Q?xpXCnCS9zz80/rGbR+X4//uEyhaNWhOFbskan7U6OkPArFOI/fwDG57Mlhih?=
 =?us-ascii?Q?vTXkrfxsWg0279UKUCi7m5+aQNg4DBirKmkU16DotcuhYJgg20wMjhXUUppU?=
 =?us-ascii?Q?dJ+ItGUGndvI8Sz2YwOvbMr2aYssK2MS4Z55DYC+piiBJ9fqgoWZoz1armcj?=
 =?us-ascii?Q?0M5wboXYjtWjiIHgkepCF0vLYTPO0WbIqgo4VuHiGm69SQSJBHe9JDaPghYB?=
 =?us-ascii?Q?jV+q70Lo1ZjDqnL0fTXc/B2te/LYK86mJvBNpyXeYpV5lNkhVM0g0p0dSuRa?=
 =?us-ascii?Q?G7YrZwXASLdspQkyVWpGD5J6GBD28MdNqYt1AEgTl153y4QpljepexjzfGEj?=
 =?us-ascii?Q?oRp0k+6yOopwtpleCnrTjvqjOcaftW3fAIGQjYakwuo3GyUf/TnN7mnlBHUm?=
 =?us-ascii?Q?ENpk4IanEJDR/MoEm4QkSYody92chzHcsyC5FnCERvq6epkalc0G+Wuuu6nI?=
 =?us-ascii?Q?axFKAZETft8xAS6/t7dURCS1ne1Lsjku14FAwTNjqH8vvIbYhqQPEC6vatKQ?=
 =?us-ascii?Q?SBY/tIjBLsTFuQdEBujN7CyFqG2Osv/68QHEKWzWXPgvzXbgpjS/sZwq5JKH?=
 =?us-ascii?Q?AahmR6+gBoYcsBRhwnf7gvCpPMm5uwhHHUXVc0IcBlzGuT8OzAo9uCvWxZX0?=
 =?us-ascii?Q?8alqWP99HYkcui+HJS+9QVjUfUaVUeLwjNPJVAe+EYAou3ztdM+YX/fn9i6a?=
 =?us-ascii?Q?zUnoNmtls4n11VCmcHygW/IWJLFLs5XpnaZB8At47eWzodhGHKNqsbms78Uq?=
 =?us-ascii?Q?zs7CRp8zvexJ0BOoQGY+Q6sYYho3E5culPyFNUAyLHctR8TWaHXEsjNzSEcm?=
 =?us-ascii?Q?BlNKWNPsPR5dwHYxvV810FaL1GBibRYpVqQb3s2dZS6F5KhsxdosUXblvoIa?=
 =?us-ascii?Q?27QeE5SQUHzgWe8ATRx5su3HDKFIFdtzAeVc1pkr/m4xO/jyX5MWLg9iTfJd?=
 =?us-ascii?Q?TXhtkVzmHx6YKYMoM5nd/lvr7no28UWncBH+oOk4qG2H0TJH/VmpCd31KpBK?=
 =?us-ascii?Q?j6ELFoazV/QdmbPnLrbSnTtWDoIhft7Fmmc8LYYw6KQdgBAYlPUpQW7F9ukd?=
 =?us-ascii?Q?YWCFasnrE3OYK1cikaiEyE19uHGfe7T/h0k8qYP7evV6QB5RdnDXfCGqBv8S?=
 =?us-ascii?Q?8dqcvZ+70KYXle1H9efUbJcXopiz+qk=3D?=
X-Exchange-RoutingPolicyChecked:
	vJ80Q4DsOhtdus68EFkJi2Py6fqrcYBdqhT/M7c0URwwZdOziDzATVaWgqoBNzUDszjAsVUi/8rnulcxL2Alj8dXFwqCmEMm80VOD3AVa+HBwqLkmz3HCKerXZtNWVP5aPGlDhjBIuOl2f4dGeVktyeW5nszZ/4uDf02i9Am10lI7MJzgt9gPzGHsEqHfVS7D83oFJudoE2MVsq729jvvHNdUvXrMIDNzG1taz5C47fnyBcfsF2g21F6vaYUWI2njOsqXIJGwTlJwU+frFfwSnZZCfIBKJn2Qw9US+Lb4rYAdRMu5fwfI6Ujn0HJ9hf4e2XN9tdueMLdSyDy9KmqcQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5f4618-8905-4f12-153c-08de8735e6d1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:37:51.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stLta86NtWRVndwDPyYNizhOOnPokah3RU6Z9j2S5QPuDv2f5JrBN63AavCwz6pSQbOxqBDpe1J8XjGajYu/DOT5jtisxWbI8wQ31ccXjco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NiBTYWx0ZWRfX1892NyAWCEp5
 KgfLNGfZ33V43k52Gp0PrnWbTALeOKBJ7enfISyQ876SXA5G0WNz6500tNkCJtkSP47CUgDu/oJ
 bY26EU8Ye+D1F2ROwlsfIksxMzF1yj7weRfVY8ipf7moOgTLkf2meLSKsJN70nkOxcjxUDMTuuQ
 xX5Ux8xCeZ3jWxCrwjOMP9w8OU7tzOCRv8Rs6qvt5wAUJKbxVREjvfTdw+AiaaIJOBwbBBmOP2u
 S6kcJ7trrALS2I97mENe68EyWTnx3vnhTKMaNW26/XeUCu3246cpEKp8NEyLJqKeyo44w6TBoHW
 0uCgn3pAvetqtmpDBg+KW2XQm92jgalONyYsk/yRgDMRCKwJ08W7e+HgtR3c/HIuUCvHlZPVQAb
 ribtWbe3bJ//Xkfz8Kq53gwFEhy1aVnF/fpmCzkyvp2Kc3pcJHQ+4YZOmuN8db3nVpSfBGNbx/9
 i1I7lm3qlVu+1Ulk/VQ==
X-Proofpoint-ORIG-GUID: D5fS-p7D_V9eqjO9wXORcCidFWwNS1js
X-Authority-Analysis: v=2.4 cv=Scr6t/Ru c=1 sm=1 tr=0 ts=69be7500 cx=c_pps
 a=fUX3CcU6CI0WA5Nw0mDYKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
 a=2lyBwhcKvf4p2rtmxjYA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=XN2wCei03jY4uMu7D0Wg:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: D5fS-p7D_V9eqjO9wXORcCidFWwNS1js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210086
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227758-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0857B2E4CA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 5c350410999653dff8d2975d794088e4c166e8b5 upstream.

The documentation of the menu cpuidle governor needs to be updated
to match the code behavior after some changes made recently.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/4998484.31r3eYUQgx@rjwysocki.net
[ rjw: More specific subject, two typos fixed in the changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst | 56 +++++++++++++++---------
 drivers/cpuidle/governors/menu.c         | 29 +++++-------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 19754beb5a4e6..9fcc35498fb0e 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -295,30 +295,44 @@ values and, when predicting the idle duration next time, it computes the average
 and variance of them.  If the variance is small (smaller than 400 square
 milliseconds) or it is small relative to the average (the average is greater
 that 6 times the standard deviation), the average is regarded as the "typical
-interval" value.  Otherwise, the longest of the saved observed idle duration
+interval" value.  Otherwise, either the longest or the shortest (depending on
+which one is farther from the average) of the saved observed idle duration
 values is discarded and the computation is repeated for the remaining ones.
+
 Again, if the variance of them is small (in the above sense), the average is
 taken as the "typical interval" value and so on, until either the "typical
-interval" is determined or too many data points are disregarded, in which case
-the "typical interval" is assumed to equal "infinity" (the maximum unsigned
-integer value).  The "typical interval" computed this way is compared with the
-sleep length multiplied by the correction factor and the minimum of the two is
-taken as the predicted idle duration.
-
-Then, the governor computes an extra latency limit to help "interactive"
-workloads.  It uses the observation that if the exit latency of the selected
-idle state is comparable with the predicted idle duration, the total time spent
-in that state probably will be very short and the amount of energy to save by
-entering it will be relatively small, so likely it is better to avoid the
-overhead related to entering that state and exiting it.  Thus selecting a
-shallower state is likely to be a better option then.   The first approximation
-of the extra latency limit is the predicted idle duration itself which
-additionally is divided by a value depending on the number of tasks that
-previously ran on the given CPU and now they are waiting for I/O operations to
-complete.  The result of that division is compared with the latency limit coming
-from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
-framework and the minimum of the two is taken as the limit for the idle states'
-exit latency.
+interval" is determined or too many data points are disregarded.  In the latter
+case, if the size of the set of data points still under consideration is
+sufficiently large, the next idle duration is not likely to be above the largest
+idle duration value still in that set, so that value is taken as the predicted
+next idle duration.  Finally, if the set of data points still under
+consideration is too small, no prediction is made.
+
+If the preliminary prediction of the next idle duration computed this way is
+long enough, the governor obtains the time until the closest timer event with
+the assumption that the scheduler tick will be stopped.  That time, referred to
+as the *sleep length* in what follows, is the upper bound on the time before the
+next CPU wakeup.  It is used to determine the sleep length range, which in turn
+is needed to get the sleep length correction factor.
+
+The ``menu`` governor maintains an array containing several correction factor
+values that correspond to different sleep length ranges organized so that each
+range represented in the array is approximately 10 times wider than the previous
+one.
+
+The correction factor for the given sleep length range (determined before
+selecting the idle state for the CPU) is updated after the CPU has been woken
+up and the closer the sleep length is to the observed idle duration, the closer
+to 1 the correction factor becomes (it must fall between 0 and 1 inclusive).
+The sleep length is multiplied by the correction factor for the range that it
+falls into to obtain an approximation of the predicted idle duration that is
+compared to the "typical interval" determined previously and the minimum of
+the two is taken as the final idle duration prediction.
+
+If the "typical interval" value is small, which means that the CPU is likely
+to be woken up soon enough, the sleep length computation is skipped as it may
+be costly and the idle duration is simply predicted to equal the "typical
+interval" value.
 
 Now, the governor is ready to walk the list of idle states and choose one of
 them.  For this purpose, it compares the target residency of each state with
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 8ab5123c81040..a18477ecce433 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -41,7 +41,7 @@
  * the  C state is required to actually break even on this cost. CPUIDLE
  * provides us this duration in the "target_residency" field. So all that we
  * need is a good prediction of how long we'll be idle. Like the traditional
- * menu governor, we start with the actual known "next timer event" time.
+ * menu governor, we take the actual known "next timer event" time.
  *
  * Since there are other source of wakeups (interrupts for example) than
  * the next timer event, this estimation is rather optimistic. To get a
@@ -50,30 +50,21 @@
  * duration always was 50% of the next timer tick, the correction factor will
  * be 0.5.
  *
- * menu uses a running average for this correction factor, however it uses a
- * set of factors, not just a single factor. This stems from the realization
- * that the ratio is dependent on the order of magnitude of the expected
- * duration; if we expect 500 milliseconds of idle time the likelihood of
- * getting an interrupt very early is much higher than if we expect 50 micro
- * seconds of idle time. A second independent factor that has big impact on
- * the actual factor is if there is (disk) IO outstanding or not.
- * (as a special twist, we consider every sleep longer than 50 milliseconds
- * as perfect; there are no power gains for sleeping longer than this)
- *
- * For these two reasons we keep an array of 12 independent factors, that gets
- * indexed based on the magnitude of the expected duration as well as the
- * "is IO outstanding" property.
+ * menu uses a running average for this correction factor, but it uses a set of
+ * factors, not just a single factor. This stems from the realization that the
+ * ratio is dependent on the order of magnitude of the expected duration; if we
+ * expect 500 milliseconds of idle time the likelihood of getting an interrupt
+ * very early is much higher than if we expect 50 micro seconds of idle time.
+ * For this reason, menu keeps an array of 6 independent factors, that gets
+ * indexed based on the magnitude of the expected duration.
  *
  * Repeatable-interval-detector
  * ----------------------------
  * There are some cases where "next timer" is a completely unusable predictor:
  * Those cases where the interval is fixed, for example due to hardware
- * interrupt mitigation, but also due to fixed transfer rate devices such as
- * mice.
+ * interrupt mitigation, but also due to fixed transfer rate devices like mice.
  * For this, we use a different predictor: We track the duration of the last 8
- * intervals and if the stand deviation of these 8 intervals is below a
- * threshold value, we use the average of these intervals as prediction.
- *
+ * intervals and use them to estimate the duration of the next one.
  */
 
 struct menu_device {
-- 
2.53.0


