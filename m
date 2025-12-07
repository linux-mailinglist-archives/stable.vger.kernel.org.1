Return-Path: <stable+bounces-200291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE389CAB6CC
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF79300B9AD
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC42ED148;
	Sun,  7 Dec 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eAM3wLMZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OwEDjvj9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4325DB12;
	Sun,  7 Dec 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765122173; cv=fail; b=i7UIYNEokEzNVVylv4nbPhGTbKYngERd90z7laoHue9MOZWteLDpY5t6LgwOeh686uUQ3Ze5A6diWWN5CJ1aQ/cxZxJHCessRTrbI19IDAfwiSlRm4CF8hWxv4tgJjaH4p2vP3ww2oT8TtuQvgjeqC8i5LjV6B4btipsJUY/1oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765122173; c=relaxed/simple;
	bh=dr8VhJiSdJPMmMj2QBhFp+Up3s1JgmX5k6Q0qULhxUk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O9uaW9eYtv/47FLSjD7itPbHqtcJ1JTOw7VkcLa8fKCCFpQaEy+5aYkrpLTA7x1wks5nn+fE2671epnLcdzbPYsgJb9rB7u0VfIrmMWK7sHD8V1/9QqUwK0QD2DyXokvijxBaBG+wtgm8Z2JaeSahv6UsKN/mLvnwe55FZb5SwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eAM3wLMZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OwEDjvj9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7FcKEp296847;
	Sun, 7 Dec 2025 15:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=liYRHWl9pdch2jXZ
	4eDwREstGpzDhvVmVYT7I49wltA=; b=eAM3wLMZUAXJC+OGsydUbxW1YqeYx9RN
	4MP0Dj6WuT3Ju3XhceQl9xU905qLjqogM16DVBAKJ4bribfNQTn8A/iYbCdY5HKG
	UNhYNIMB8DMYPXXRMGpwgRkA+ZGjLKDqjkzYathgjveb91xPg2ZsbSPdr3cb+otA
	pjQzHYLedTFsZgwn9FwJ9zyXuzo0yfeuJ8vqUerru2ToKh502HHPYqDjVvsxJWTy
	fUabMU92ISMHZREWEKvOv8HtwaD7uPiqHbUhIeWv4S1EJ8UBGk/dkdnRXTqcgQK9
	Era0kjO5AQF6wHZ2U5s+Kw9atItCtYRmxCzVIgX/6eEowHykQgmcug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4awc50808h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Dec 2025 15:41:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B7DieAo040650;
	Sun, 7 Dec 2025 15:41:58 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxaphfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Dec 2025 15:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQSCdnNWqA3snOfFZi3pwP3KhoIQNtc3/tAg7M7f79rDr0ly0nF+uPVbWivaUiR5ZP09U6U5OYgFCcfIFDpTOE1hu4I4IydPwM9ARltFM6k23dxzjJbdXxF/9RU0bKur39Sspzbg8+bCD122iz5gPAJnJEbv6wbl6RPQM94KQX//VV1DxYEl+OZ/trzUrGxeE3GqqLgBcSeiJ2ZRly1NHz5/UDw0ZyOHoJLkox+S8K6AHqmCUlcU4OnGhcZYmHn8s3MCx5AfVtAca+68Wpv9JoOeiAy3H+IkjbdY8cuuI66bx3G0HImfh+/6tp0dozSDIc0NKGaJ9S52gy+n+B5KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liYRHWl9pdch2jXZ4eDwREstGpzDhvVmVYT7I49wltA=;
 b=w0gNx+ws1zFaBefzNxt9Olkkj5KyOrYpghcXZ6RMhKhDNjDSZ7y8g0JNStZ5yBOJ1sppKgGcHrThBzARS2Jq4gzuQyRjvZ1jY6SAPslnXdS0+6SUQF6VzPVviB6seBoh+gjEkuWVPmdQ1VzAPWOu+ylcTAhERV8DLRQS+jQyynn+2XKwCPrf2ptBrTWiGJWiRsSqD5mcK1IDOC1DI6nYMk8Vn63w3+8kY1OidyYxHLwojq2dgzujz2Wt3trWKQOKcchvLEwyIYMQAkSvMPjJ26qjBDryO0NvDxBm77cvxOfvAM0fCkioCxE9NCujtD8PmizdFNN5PYZUTxzVzBMfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liYRHWl9pdch2jXZ4eDwREstGpzDhvVmVYT7I49wltA=;
 b=OwEDjvj95CCh90lAZdHgYc6sCwvuOw5pqOgRVJlbhGJSlOOs4LntbVDRP8aYkNF2SnL2JRUxI48V8ughyIP/ebsZhiEa1qp2oscprLF+XmVAj3yoQGDVy6xosyvKz5wqv3RcMhjpVujXlN1lYCB9Kmc31larM1/LsoOfBcwPrnA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6146.namprd10.prod.outlook.com (2603:10b6:208:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 15:41:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9388.011; Sun, 7 Dec 2025
 15:41:55 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: vbabka@suse.cz
Cc: surenb@google.com, Liam.Howlett@oracle.com, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
        urezki@gmail.com, sidhartha.kumar@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
        atomlin@atomlin.com, lucas.demarchi@intel.com,
        akpm@linux-foundation.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH V3] mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction
Date: Mon,  8 Dec 2025 00:41:47 +0900
Message-ID: <20251207154148.117723-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0124.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 514e02f4-2b66-44a9-9617-08de35a72647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?20nMfrqzJPNnOO4w2t2c+Z0kog9aauMROlGk7xgHxP/YB3aJNJ00UBQjKaVx?=
 =?us-ascii?Q?Cq8RW3UYh/RxWFC1DZhXkcmOUFT7DPbeW1chNE3Jz9WNKnNt7JiTgsw3PCMz?=
 =?us-ascii?Q?rpHiABnOBtRaN0S4prsDEI0LIA6cthFDbdWwmGIGwxn20MFwn5UzR+JL3qk2?=
 =?us-ascii?Q?B5EJH+LSkDmnGmz4UJJoQ4JIX4XO5hxGIZnzVKD7g8I0zgqb/KJV0aljkDwm?=
 =?us-ascii?Q?Ztu+39NzM8KwGlnAZdEyRvHTlBOGs1AKcjKWoT4doVEIG2hBiOYsL+VRKNUG?=
 =?us-ascii?Q?wfuszHPdZfKrimUIOaZ23+/ORTIbsOVbAo6SzrghPNvwVJ+qXF+eBQcHFMiC?=
 =?us-ascii?Q?3M+S1udh9BiHuAlCSEoZLA8uAs9jw322wpFL3aa1MoWcYcueEEL8Uw9lyWh9?=
 =?us-ascii?Q?YB84hXqjOHq+TvxaRUa6UChMKrdTZRJQwnaFWMrgBniheE7DmJwuTcLLQvM2?=
 =?us-ascii?Q?lwrGMemTqw68dWzwkAOufh748tdrwHCwNYSrey3g4KpcY/8m8m83VDbJyCof?=
 =?us-ascii?Q?whSd13wgJPHaidw3ffXcr7RxdaD9BCuHPx7iqlXfaunV0GQlXoMAzhRxNioS?=
 =?us-ascii?Q?o1xZMRPpgyf1IURTiSOMI2Fed6CwmJudZqmXvO/XY8iLXrBCPkH3zZ4FNgrT?=
 =?us-ascii?Q?8PyKLaUW15YbqTS/NACQinwPXvFui8hGpeLtr0pj5Oo+uttuwhN7JlXijOgh?=
 =?us-ascii?Q?tfBpzw+FaKruYg0ZiLZ8skLdk2peeMoVLTRtqIV45tmxhTrEtQ52AA5RLo4s?=
 =?us-ascii?Q?2UP4AQV/1981WeUG1DJApWLE30M96Q0Dv7Sy6yA2DrFETtk6c0buCZ8nOfDH?=
 =?us-ascii?Q?LszMHes87LDjXLFlNjc/0kcak/f/SJcQN3WikoiCO/Ez1diBg84nPawwHHOk?=
 =?us-ascii?Q?dRLksB3IeY10JVkt/KSZiazdPrPh+H1fX+5ahrwESyfcXGZ9CzHbDOoDazkr?=
 =?us-ascii?Q?ZBe4g9xqpdza3x5I4FEho4S0Lyz+BM2E3vVPWvPDVtbocke/YyC4lHIkvbXM?=
 =?us-ascii?Q?h0nmpzc75fLZWBn9D95dgKP6efpnpUSUAIMPLPhr6PzixBgrlSO5yBKhsEKq?=
 =?us-ascii?Q?3rWMSB2ZID6h2oic7u0YyDgCer0GXweih+sm2VWYimBWg2fyU8Mc9B/a3mgR?=
 =?us-ascii?Q?dtcX8xtezui1+cX/q1C83QZN7saHoK51Q4rQ2dRsaHgxSytxaSlswMzDOmaf?=
 =?us-ascii?Q?yBlfCktwc2ZztHNFEMogxjnFWro4J7ekVLpRBtaGXnWYBXiuxcWF1clVw5sc?=
 =?us-ascii?Q?7OELXatj0G30h5UB7mTvLFrQsY9p9+rXv/URudKbmBYUN0g3m1g8XT5vrkxN?=
 =?us-ascii?Q?yXygHHWcYAqE0bOG0avrzj9PbjxZRYkQBNy4jqgJ2xYFJrsWqFaqXVoLRK/I?=
 =?us-ascii?Q?86MlU7S4QqjoAyFq0OswMAxs5rIUoXTdOXlHh5nIEqW12SOaFEFA+TvDdS7i?=
 =?us-ascii?Q?guK0HTN6cUrp1KNTZv1hAnWVdqdsEjEO19tdOWLOMD18R3/PMCw2vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BuXJyiIrlk+zwEy318JLOXtkMmPPXaXlULfTgrRpHt5lxkSP0UGw5SoisERK?=
 =?us-ascii?Q?gRS1I4Rgx4dWemqa68aP3WXdAhZeTX2y5JJyJ7f+PRD8l74Yz9/7OWA19q29?=
 =?us-ascii?Q?JpnN1amGZZW4TAi0PH0yADeph+DiuVIW5NRK0iLP2sNv0PeEJqBuZX8vZauy?=
 =?us-ascii?Q?sekXX52OJCLFnan/mFoxrsxU3OWfCHnnW7EZr7GJlcz7YT2NH2JMX2NWJpyA?=
 =?us-ascii?Q?1ezjWOxfEdh8PjRL6v2kBh5O0DLno7hzWjZJnWI5/FWA+ZekKvrd+OUNrumO?=
 =?us-ascii?Q?HTh/mpSqaiurGwoCfQ29ifpS5b4q9hSF8wa9mGA/Dh6OHuDqmj35Lan4ea0P?=
 =?us-ascii?Q?qafUeaLa5zFYqgKa/z0M48Cs8KtbZCtWBE+bCjx/aJYMW9l/KscZykPbaOMw?=
 =?us-ascii?Q?DLF1a7TZu7JaP896Y9rVh6Xkui9qGohGV9UAf62I2Z3NBD7jlX5Jf0USSEq8?=
 =?us-ascii?Q?ddV/G6qbB2Yj7b+ssKkX3CmkddCn5oazI89Ts3U/+NCe2GZa+4E3QrQri4hv?=
 =?us-ascii?Q?FXQnRIIFNN3s9owW3jwOwqPXu5/Q5Bv3pvngJnJsnxz7nUi5vevbAf/GqTOc?=
 =?us-ascii?Q?st4NakUDniezgUOMHStjOsVFR1LLrkhHb2+JUnycw23RFYHQ1nF2gnzPmpS5?=
 =?us-ascii?Q?n5kT84fEuFa2ZysBnX33TkT8E9EdNRRuoE/88nRp0AGZjUl7tRF0CC9uGoiH?=
 =?us-ascii?Q?+homI0R7pRnnt4BhNN0fOL3XpBIqC6vQwlWTqf6qgjGKYH4pK+jRu/F+upux?=
 =?us-ascii?Q?bL1P2z0UT9FC6ZJ8WmshPvFFL7nFUvCm6oQbe/SQnRq+QNj8uwedq/+q6tLl?=
 =?us-ascii?Q?gLWKtzrkLfdEP4aY5I3UwBh1hvyn+27SEQeqPomPq8IRKjTLclk9A5TnGbpR?=
 =?us-ascii?Q?75CEQ0MG05pGo7cYDnxvQ1E/PVDaFnzjrGYhi5BDmI6ji4GRYa8qOcY7JvUC?=
 =?us-ascii?Q?feX7cyUfQbWRWFVoOwAFWyb9ZCsfF+uDdZs+bwoeAXtwkzC1PVW9PUTrUROv?=
 =?us-ascii?Q?C+tHaMZ/7KRKDsLoddBdOP5VGGi+UrLVubArhRIqmRQ4gg1Y/IRmO1nldk8w?=
 =?us-ascii?Q?cucBf2CbA/G06AgIvuUOAfbuAhfJNYJbVx5T6Z6CzZgo/DyRJiD+OUMgzsV+?=
 =?us-ascii?Q?GPrxnhISMJkjVvcnsC4U4iVtxzQLXaF7UlV+NAZ2LkLDnVRVyHltl2eOO+yq?=
 =?us-ascii?Q?b7iwpnhvzDFviFVtQVEJfT3qBbyojjilulIkTcYKRf5bRRUoHekdXbeHyVfg?=
 =?us-ascii?Q?7jlYJzNeSVFLYQm4Mswv0nuNQVufn8e2/i3U880Xb5i1smjNvmPYks/jw2b/?=
 =?us-ascii?Q?+qzzUGy8t36MPVvek2XuZ76Xvm/+3gypdxFjHN+qUJQUpZEp4JiE41Xq8OhN?=
 =?us-ascii?Q?wtwYV7ddLIHtCFp4+MtgKMdVcwHLU+wJelguqXXwZ3j7AEixk0Rpjy0brTpf?=
 =?us-ascii?Q?UCIVOOXQLGIWmJIvGVUGVsPIYhZaaCb0NCLvtNpH4exe8baqjMpSDnttR9kL?=
 =?us-ascii?Q?3YtAxtNX7ANFp1LgOhf7d3PCa0lRZlqGS4nhLv6tAYccqUxg8HaJX4Pw12Vw?=
 =?us-ascii?Q?DJmDtowM/q0j0aEBB6+KZTjMgvotI0UtBVfzAXwk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFrPZ5YGoUZyjtxapdjdXpx/+RjhdUXxoo48Lu/V9cKGBJJUrtc0ySG+9MATuvpuWv9P7bAfmdJYN4Op9bNzQbT6rzbfhByNP+3C33MKmapIQf5cFcM5eJISkFEDpF7zGkth+f1/fKgqxPfxvCJ6CagFSYfJ4Uu1I8Bwfh6nozdkJkI1alWORk+HtBhCBau/uTHTWByPVT/5PUN9kNubv44bWKCZ8XLEOdzSE1DkhVogHzKLFZYvhPCMLnsuBlEUxUm/s7SHVHWDwXT6wk9A9WoWf15YVOFEVcJR7G3qTZSndEPEFF96E8sL/WSy469nnh3lVje/uYKVAi2q+BkscKctkwo0Tdvknb+A+ep6ZAIY7Ty52g2lGYoLUZ25lvz4AQuvXQL1Oyvl+i7TatZ3hSE4CgCco6zXhVVFYVmhrJnU9n9xiJ19biU8Mhx5ROF5u1JPaGRD7+FE4thPOx2qvfLvztFO8bh92ohuFLcboWavfEqxNEKVwxF9t9RN/9IaUK3XMcj5rvgFhNFfUFS94LENYfhMQPoxmUDHYhnrLJwqxddGsIURI4FcBbEi1Q2QR11X3rvuQluA/qdBiZa7lx/F06OioY4GWdCpr7dcCYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514e02f4-2b66-44a9-9617-08de35a72647
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 15:41:55.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVnkJ9UzQPCaTekhjAkwlHzeRD20feuPNW0a6PCGBeA1nM5yPdvG8Q4Jkvr2QhstMWP98ECVVy/yQ9pejmK1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512070136
X-Proofpoint-GUID: dXHtGo4MFhzRC8bb_kxShdLQi2dRJ5m8
X-Authority-Analysis: v=2.4 cv=CoKys34D c=1 sm=1 tr=0 ts=6935a047 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=pGLkceISAAAA:8 a=hD80L64hAAAA:8 a=yPCof4ZbAAAA:8 a=yO4LRhKTJlilM3sNaQcA:9
 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDEzNyBTYWx0ZWRfX4rYOX9kZk96z
 x2cIN34J4ejyTjqyyOSRu82tt2tiXwAhMHQ71gL2b6Zq1HaF3sPslsDxwvRxQ53WVkgKt87YxMR
 2Hr3TrZq0PSdx8bjolA22Tx+FRU9tf2NcRYWB5HHuhqprDRpqr4aAGsDs9uEcoWEF9PidouEBl2
 FnGznj6Tpp6SIGgrbrr/fY6DUanrpbSCo9Ggj+cQXcEtMcvpYRNHodA5KCdl178bOV4rrX9+U5p
 e9SlM4Uxb33QYvDwHZRytkCh/hu+0t/TYKnd+EX/UOJF7Q/e9y6k3HTWB7oc1QF8qiolgQFhK6/
 5PsZJ5vYAf44k7nrlX5BvzcVLkwiGcc2iQeiICKArlJq5DpRprIgXTZ2iDL4vJ9VB+0dQhcu6ke
 xzlpRajAbdXbH0CUiSmBjbANgDO5TIv/w8RH4r30RXOOA1fJgJs=
X-Proofpoint-ORIG-GUID: dXHtGo4MFhzRC8bb_kxShdLQi2dRJ5m8

Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
caches when a cache is destroyed. This is unnecessary; only the RCU
sheaves belonging to the cache being destroyed need to be flushed.

As suggested by Vlastimil Babka, introduce a weaker form of
kvfree_rcu_barrier() that operates on a specific slab cache.

Factor out flush_rcu_sheaves_on_cache() from flush_all_rcu_sheaves() and
call it from flush_all_rcu_sheaves() and kvfree_rcu_barrier_on_cache().

Call kvfree_rcu_barrier_on_cache() instead of kvfree_rcu_barrier() on
cache destruction.

The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
5900X machine (1 socket), by loading slub_kunit module.

Before:
  Total calls: 19
  Average latency (us): 18127
  Total time (us): 344414

After:
  Total calls: 19
  Average latency (us): 10066
  Total time (us): 191264

Two performance regression have been reported:
  - stress module loader test's runtime increases by 50-60% (Daniel)
  - internal graphics test's runtime on Tegra23 increases by 35% (Jon)

They are fixed by this change.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
Reported-and-tested-by: Daniel Gomez <da.gomez@samsung.com>
Closes: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

v2 -> v3:
- Addressed Suren's comment [1], thanks!

[1] https://lore.kernel.org/linux-mm/CAJuCfpE+g65Dm8-r=psDJQf_O1rfBG62DOzx4mE1mb+ottUKmQ@mail.gmail.com 

 include/linux/slab.h |  7 ++++++
 mm/slab.h            |  1 +
 mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
 mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
 4 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cf443f064a66..2482992248dc 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1150,10 +1150,17 @@ static inline void kvfree_rcu_barrier(void)
 	rcu_barrier();
 }
 
+static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
+{
+	rcu_barrier();
+}
+
 static inline void kfree_rcu_scheduler_running(void) { }
 #else
 void kvfree_rcu_barrier(void);
 
+void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
+
 void kfree_rcu_scheduler_running(void);
 #endif
 
diff --git a/mm/slab.h b/mm/slab.h
index f730e012553c..e767aa7e91b0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -422,6 +422,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
 void flush_all_rcu_sheaves(void);
+void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 84dfff4f7b1f..dd8a49d6f9cc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -492,7 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		return;
 
 	/* in-flight kfree_rcu()'s may include objects from our cache */
-	kvfree_rcu_barrier();
+	kvfree_rcu_barrier_on_cache(s);
 
 	if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
 	    (s->flags & SLAB_TYPESAFE_BY_RCU)) {
@@ -2038,25 +2038,13 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-/**
- * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
- *
- * Note that a single argument of kvfree_rcu() call has a slow path that
- * triggers synchronize_rcu() following by freeing a pointer. It is done
- * before the return from the function. Therefore for any single-argument
- * call that will result in a kfree() to a cache that is to be destroyed
- * during module exit, it is developer's responsibility to ensure that all
- * such calls have returned before the call to kmem_cache_destroy().
- */
-void kvfree_rcu_barrier(void)
+static inline void __kvfree_rcu_barrier(void)
 {
 	struct kfree_rcu_cpu_work *krwp;
 	struct kfree_rcu_cpu *krcp;
 	bool queued;
 	int i, cpu;
 
-	flush_all_rcu_sheaves();
-
 	/*
 	 * Firstly we detach objects and queue them over an RCU-batch
 	 * for all CPUs. Finally queued works are flushed for each CPU.
@@ -2118,8 +2106,43 @@ void kvfree_rcu_barrier(void)
 		}
 	}
 }
+
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	flush_all_rcu_sheaves();
+	__kvfree_rcu_barrier();
+}
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
+/**
+ * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
+ *                               specific slab cache.
+ * @s: slab cache to wait for
+ *
+ * See the description of kvfree_rcu_barrier() for details.
+ */
+void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
+{
+	if (s->cpu_sheaves)
+		flush_rcu_sheaves_on_cache(s);
+	/*
+	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
+	 * on a specific slab cache.
+	 */
+	__kvfree_rcu_barrier();
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -2215,4 +2238,3 @@ void __init kvfree_rcu_init(void)
 }
 
 #endif /* CONFIG_KVFREE_RCU_BATCHED */
-
diff --git a/mm/slub.c b/mm/slub.c
index 785e25a14999..7cec2220712b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4118,42 +4118,47 @@ static void flush_rcu_sheaf(struct work_struct *w)
 
 
 /* needed for kvfree_rcu_barrier() */
-void flush_all_rcu_sheaves(void)
+void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
-	struct kmem_cache *s;
 	unsigned int cpu;
 
-	cpus_read_lock();
-	mutex_lock(&slab_mutex);
+	mutex_lock(&flush_lock);
 
-	list_for_each_entry(s, &slab_caches, list) {
-		if (!s->cpu_sheaves)
-			continue;
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
 
-		mutex_lock(&flush_lock);
+		/*
+		 * we don't check if rcu_free sheaf exists - racing
+		 * __kfree_rcu_sheaf() might have just removed it.
+		 * by executing flush_rcu_sheaf() on the cpu we make
+		 * sure the __kfree_rcu_sheaf() finished its call_rcu()
+		 */
 
-		for_each_online_cpu(cpu) {
-			sfw = &per_cpu(slub_flush, cpu);
+		INIT_WORK(&sfw->work, flush_rcu_sheaf);
+		sfw->s = s;
+		queue_work_on(cpu, flushwq, &sfw->work);
+	}
 
-			/*
-			 * we don't check if rcu_free sheaf exists - racing
-			 * __kfree_rcu_sheaf() might have just removed it.
-			 * by executing flush_rcu_sheaf() on the cpu we make
-			 * sure the __kfree_rcu_sheaf() finished its call_rcu()
-			 */
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		flush_work(&sfw->work);
+	}
 
-			INIT_WORK(&sfw->work, flush_rcu_sheaf);
-			sfw->s = s;
-			queue_work_on(cpu, flushwq, &sfw->work);
-		}
+	mutex_unlock(&flush_lock);
+}
 
-		for_each_online_cpu(cpu) {
-			sfw = &per_cpu(slub_flush, cpu);
-			flush_work(&sfw->work);
-		}
+void flush_all_rcu_sheaves(void)
+{
+	struct kmem_cache *s;
+
+	cpus_read_lock();
+	mutex_lock(&slab_mutex);
 
-		mutex_unlock(&flush_lock);
+	list_for_each_entry(s, &slab_caches, list) {
+		if (!s->cpu_sheaves)
+			continue;
+		flush_rcu_sheaves_on_cache(s);
 	}
 
 	mutex_unlock(&slab_mutex);
-- 
2.43.0


