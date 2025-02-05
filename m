Return-Path: <stable+bounces-113970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF4A29BF7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628773A78C4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF455215063;
	Wed,  5 Feb 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kkdsEwTG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EOzTfPHd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66021505F;
	Wed,  5 Feb 2025 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791647; cv=fail; b=GMMTl0IpF/giF6b81hwIK8lbEBEbf0tqAqn6xaPvwoqnuowXNHmMtUzUS9GhyHmC2yvrbexwLLnsmdcVWN9YMzh1mPqyjg1ZC7cJsYYUWiQTyfz15CtJteVLq5eW2jsu+RnJ95F3g4+4QVJkivd2cE5FbMptpbzjt6eLNZCWFr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791647; c=relaxed/simple;
	bh=SX0htKDFzRNFIyf6mnSeG+1tAIXXkMQIT3SMYcKTqs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzg65OAmfpSanUen7ET0vV+C6Mq9GpfmiXJ906YKR/zsjREP7qqY05gxDEdkXEqL9HE2b9T/D3WNXWNHNl8Eb3jDilcTY2psrQ2ILuFQoCJ0zneESppPhKiki7pJCgmXVFBBTH54fQrmabFK5QrGDx5xsdykopwpNRzRoSreNG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kkdsEwTG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EOzTfPHd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfi4s016866;
	Wed, 5 Feb 2025 21:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MrvF/DQGQhB0PIhdCED0Q5iULP+/OJS20BW1fGT4gik=; b=
	kkdsEwTGn7sNTwXUFzyYBcrHE/nX8tMBGqB4IE/OX/Fd4dawOB70OjygKl+W+7xS
	PxXWQRGrpQW6FOOQkB/rurOY+/gexhauo2ENMX3V9zEeSBaDRRvJBer9FOczz3Xo
	z5qV2E5WIYrQAnoTWF1rSIFGht/oI0CN/bqyboqmuydYcgZfTk3BPl2wU19DcNk4
	Li4/Ixj8aUZ7tp+n9snw3vF9ZHdBX9EvdPKyzCUNRso3Se0qiiensoNrwmUdgTDw
	rlD6o3q6pthQNsulwzbCIvW658uMhAEtGhrA4LWXYcY+lPkwQMuCrFe5+1aTBxj2
	AURmDhe8KK6Ipbu+3PHDnw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxm21b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Jtrs4026923;
	Wed, 5 Feb 2025 21:40:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fp5a6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEPvhBslbUOPIgOg9bxIOPvelUBzC+53LDaocnUiRWV5thZ3F4DiD8O1VTMExLBe+kYJ1mSWepWp3aGgVus/wK/Rc+Bm0wpWWXokeZOT7qdhmJY23LJVMS3trB6vZbROjGFSj4vPawon4uyOpviNDLkAnzSDov2W8+OLX0LeBRLz4QOSExfT5CL9FMw/rmu9qoR9T6jNbyZiTmvodCA2M/xBW1TLQ2H6NP7VR/XlWr8yrZibtgv5A+8xhDT5OPFtlzjHbLoRvPqASO7UOcvIuZiwdDV8nvTXTinAaQC1QbPjY1okth+5Smkkw+YP5MX3XqRxbbUnR0S5KkltNDo83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrvF/DQGQhB0PIhdCED0Q5iULP+/OJS20BW1fGT4gik=;
 b=rx+1zBNZmx7f4nFHC2BuocMeQjZ7HzRAn9EzxLf7bcptMttMN3rkpIsbF7fH1KXkyh+E4cnZhtiYQ/gWbw3ClZvQGR9CzFxut1dPC4FaA3jzEGbgcAF546Adq2P752gCMRvbShVcOmnm/ft0mUA4KZ/kjPWyIfKXP7UyRVs+g2op/9ZRRJ/vpv3bDlPS1YuDXHO8BacgqmKgX5kPx+fakYSnlDHEjoaCyozvthY4h2i3PFU9QfS7EsdZ+tR9YDUJLvR07KW+aCpevhOgut8jRGQBA3jmddVxg3vGIR+z2YHOJDWRYnTt1Hd8so4qOBhve5wggEzY3pkqxBY7x66cyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrvF/DQGQhB0PIhdCED0Q5iULP+/OJS20BW1fGT4gik=;
 b=EOzTfPHdPyHgWgoMaHuM1hvftCV1+3fg4o3/U38rK/ku0vnvHGffPtXvgld69l5vBDNQIL2cZoL0CdyJPuRz4eqg6y2mvSsPySVVDLSApd0aU6oAk92OhFpVAhXXOFgx/wY/0N/OT9CNGGx0k3/kr/VEt+FcLhCIHppyWxvKhqM=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:36 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:36 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 04/24] xfs: fix a typo
Date: Wed,  5 Feb 2025 13:40:05 -0800
Message-Id: <20250205214025.72516-5-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b85ecf-d13c-4be7-8343-08dd462db9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1p4qw4xIMCPv3Fqz3g5Ga3TQ8q8ZTD3aVhetdm1qCsFdHZX+VjBqrkPXQ4G9?=
 =?us-ascii?Q?j8vhB8fl8qDKjYvGxLqjlXk+RZsid7wWwj/CHEwS0gnpzF1IIk8vlcmC6gSB?=
 =?us-ascii?Q?mYvac0m37tt+9CqJ6OZTU9YuATt+XpViqlm5llXrQKFFtpNqAEuUsW2R25Yj?=
 =?us-ascii?Q?6B+hpFZu6oFukTuUtejG9XnubUo8p8XUgSSdZtTMAX4DSdAVS6xiJQBu+eUe?=
 =?us-ascii?Q?w/6y4c4uD5EJyi9Kiork8CBt30BvcUQadC0jak5NgjTz69Beb9xk2w37fjaB?=
 =?us-ascii?Q?PMD4wCVNJW/WcW9+ukKdFZ+JpfbPEOOgHtJQbXK5O2MWMABg9URPiYaA0nj6?=
 =?us-ascii?Q?ezq7adGk7O3v7jUQihAGMEBmAdZ5K5eiwlhz2ZhFlQdL/3A+GueS7pLSYtTQ?=
 =?us-ascii?Q?BCazwjleY5LD94CCoU7wqyqEnoz8XEpMWKMcEx5DYoIHffAdnMNMzBp0GaV1?=
 =?us-ascii?Q?UcS8WaHeJZAD6JeubchGVWVwa3HqlyQvhrOUeGFbozOz5bXNdAdFUsQtSXfV?=
 =?us-ascii?Q?MBSyPqpvlRI4fOOxiGu6pf/a4BFtmkCFr+EA0lE2fbx//KVArCLuPxrW8kbZ?=
 =?us-ascii?Q?YCzvgcg98/gmMpZLOBwnZO6Ntc2+/QPMcw7IEuZw8CICxcqPqk9LRDt6GbFD?=
 =?us-ascii?Q?sSr42BHiTLQqVP0KAFrBMZ+SMdymdn2kKZlsLs08Jbj8+g4HIvAP6WlALpO0?=
 =?us-ascii?Q?IuVA67psVgefxYkcsX2Ujk9/lLhEI8YRGi5e/6irDrvvfSPZE7E7t5DLUa7Q?=
 =?us-ascii?Q?afiC19zYQq/btfrsMIjJHTuE1gBTSkNCtsoq54fQ06kqyVKGGH1Saf6C9uQ5?=
 =?us-ascii?Q?w/0OiEgPeGk7bFW/ZNJQt3DamXpXZhnalG2qTYcCKTHvieB23fP8DWgVsxrk?=
 =?us-ascii?Q?vvt2B5BIrEx5JrWkfYLwUGf9bwaldRXnRg0QIAkYmw2JhMVMDpwvjm2tZHW8?=
 =?us-ascii?Q?j7w+xS6X0tifrbfLwKrVU4KqnPov66kZbGfqdUQ1X6vn6cf/ZgmgKSTCHet8?=
 =?us-ascii?Q?LZZ9/Jl4wb67iSAVHHCYXISxqeziRBSWtq+17ts55Qex21LMOA2RL/GRJmgL?=
 =?us-ascii?Q?vmOW6tWS5Ca8iZtW2I+kPavF3z5J2nwT3jLyJSheYxAJVG7jvNBHSEcgoCpG?=
 =?us-ascii?Q?bmh7GPgfrOVdJtvh4cHJhJ6avkpL+pyqQE6A3poiqFdEE+lb+2h/ngQuL5Pk?=
 =?us-ascii?Q?RA1hZej/Id/4CDXvdtzT6Wo+QiDBENiVccActmG/IBq8/kE++TNeqUlAyAGy?=
 =?us-ascii?Q?6ai4I6H7zrnsalzEnG4jfxXZylp5v/lHx5CGs1yuQuqOyW4IvaiNJsby6uuD?=
 =?us-ascii?Q?8jVbyEAqsYRIExOMAiw4JK9d7WqOVDEKULHdOC4vGMHpp2GkfU5yysNsvQGg?=
 =?us-ascii?Q?+nBzghLXOfeuKHxbnxBa/9XYhJtj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?181g+HQhTrOzqZCtm+C8Jr0a33DEpqBfDDESQKJ9Tizg5noOSWX97Tci3U6w?=
 =?us-ascii?Q?zXKud/ehzXx+iURIZhSHbwI9YNoWkAtAoZ5lKC/EWr9sh3hdvN1G4bFxWlmD?=
 =?us-ascii?Q?Mn2yXl9a0bO6dYCjVXSK07N+60AGQByBk4ucnVM5nigus5Lsw/fh74Sbpf7F?=
 =?us-ascii?Q?LrQ1yfzl0GDXOmU6ExCWTeico5M0WnlEC5yDOB+tDqkdnW9uYDAVsI7GuJpP?=
 =?us-ascii?Q?T7dmwMbyFYDqtuAXURwag05DCPVmzOjd4bXHTFl7h3HP/+5bKbs49J238+K1?=
 =?us-ascii?Q?JwwgAeezUeW7kGzufip925KTn8/OavrYF5uGzkA2rqC391OkiIWISisSO2Cs?=
 =?us-ascii?Q?uTDfR6SM0fHNWSBTUWc98gwpVpIizKSVbl+h+7Dho7SQiSeuPyS6HIPDOYdb?=
 =?us-ascii?Q?Qu8qeUsNLxPYuGxwURnodbuqvHfOVWERP7nwOtmt6q04ORlkXvGWypcaoeP4?=
 =?us-ascii?Q?+84kt48uFAZNF+avflxebTN/h052NiV9/IPc/FBVG3leL5PcBiT1N/gJ7XZ/?=
 =?us-ascii?Q?ImeeX0AJTsMsEBkpkpwViM2q4RnMt9c7b0ZBkf+DU0IfFzBJCQaTbb7O/UR/?=
 =?us-ascii?Q?GGuBgt2c3q1uCUiekww6QwOYmdIRGcbFNnKMioc5LsNFSo+g2rnSSTjK0R7e?=
 =?us-ascii?Q?fpQ8o2m4ILnkm0DANbPrmMRkrfK0AKKFPWwhAR9PML0iPSW4fqtjvVLQa1Zh?=
 =?us-ascii?Q?aNfh69R70CT1hs5C7Auhcma+MB+F/ropvaZ/OSvxuUnF5kE1bFrgAHh7nN7t?=
 =?us-ascii?Q?OyScQT9gACSGi2LOQN031Udgv9WpbsMtqJSZWYBhHzkcOjxajMeM9LqDwAev?=
 =?us-ascii?Q?6KWAMYnFNdB6bGK9lkaWjqOScSGvXsFtCktW4+/HvrLHZYlCg0meQdvv6lU+?=
 =?us-ascii?Q?XL3tkjpfG6Nygroc00g/L5JJ3As0BwwhpAW8X10Muc/qEb3MsWfJowwH3+TI?=
 =?us-ascii?Q?Cbd0G2rcFzZ+vQzZF6f5EtRIpmQOqePPlbxoKx8tysOyWx0THJTMlTRBh6Bj?=
 =?us-ascii?Q?2JbhTpMhPHNsNodEBWLRpqnb0m3nd+mRKohlyhw7ziycXBde2cpB56aJzeJ/?=
 =?us-ascii?Q?V++miljcTc1oo37BFp1p6TOfHvGYd6NQ0ZUr1+K0WO7hNCDiErxwlndWbHAg?=
 =?us-ascii?Q?4SuaxeanSzfUZD3zVRCKmempxHepuKj5qzfvTOlNUHcl3dqH3Vpy4eIF9wjt?=
 =?us-ascii?Q?ToUC3hEgwvuPre0ZWP7iztp/5UFGLwRf2hE/dKHUrUabZDupGRQM0zTgOnp7?=
 =?us-ascii?Q?uUhtHY68ygaR0tO82zb33i2wHYDOelcvW3IiWEOTdYZGlXIIxcclNto43+vM?=
 =?us-ascii?Q?ya3607i8ZH6+CRL0oygewoNscYSO/Ep4svZeBE2vz/KMfbmNJ1wr9vBykRbM?=
 =?us-ascii?Q?U9iP7aafWoHxFStwtf9sZQO7foMugqC2xmczbinNv5jjs5+MQqUrifAKBgYI?=
 =?us-ascii?Q?73oIq2GnI0D3AHAP/9XoGVUyqkWK60j7jgE1DtlF/y45V/+PCC10Q7yLnNfh?=
 =?us-ascii?Q?y4ehitfwV3pl8iQKbAc9QFlhU5nG+huFbfa2ya1bIAvz4BXyiEugI96h9Fy8?=
 =?us-ascii?Q?EaE6+gNPmhyLyew4wKf42CMD1QI8RkdOZmaeUcT/Q5doabuUdCG67GnGjhtO?=
 =?us-ascii?Q?QDI0LK/cJusxpw+Y6t4VPYqH46IaoRpk6e/uodrfXTE5BR6h57Tv4Bl1UYQ0?=
 =?us-ascii?Q?wi8PLw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ROeyQ22fj9eq0FINlTUREjX+QlsY7kVfsYOksz/JvXSmSLlZgLBM1ZkvAlLBcGTNvIiLDQuMhWKTLMNLDuRC3bfEapJTQdZXKq4UC233k5ASKkx+tzWWpm4QgVFtqOk/YLyTF2mx521SZZzgIoYD7fHZAMonBlqWpLkoGSGiDYIX556iTxtr2kGybq5/9GwjYotiezxjyMEHqFdIyAu8yu/+9rS1f5q5vVneQf4or4cNbnLwEtfRuBNRvp2Ev6KMyI7A5A8P8SLMAzMHxGpROU4exA9LC55KH3NeP5jBEnHORib3/SJ6OEpf+m/VMp2i2xQ7c016uxhrPdwWUWlh1+WXBbU7XMwnZaOpyS49jJTPRY3jYYOpfHCxJQFh9gE8/5sCCBsNsin4ILvqYHs8/dGvoFgFL/vipfFJyrmY/aPmoSxYcb5K3KXiz0rIe2zzJckUQSEcM1Cgv6oV4Rt9uxeUluz9ljzjzDgWGYTL7PB7L6xLfNON+KW0A4cPMTsUvRpqCp8zpJEpsRpuoTJvRlWZiaPLaRsEYbN0l5kFzQXC0b5mMjO48TEQetLeZPoBEsGuchPVT3zSgPKO47zSEUyd2vWsi5aZc0cuj7RNGDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b85ecf-d13c-4be7-8343-08dd462db9a7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:35.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZFaEhckBBw+m/Ki0A2OY+y0SNnEC/j7yqAJ4jCmxNuX8MOOqQveJZVK8aHAwQxca6S0nIYkeQf78Ii3FlIeIjyXOHr+euPgX9AQJRSb8EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: g_BztusxFpUzpEspNwETRfz-vl93wwPb
X-Proofpoint-ORIG-GUID: g_BztusxFpUzpEspNwETRfz-vl93wwPb

From: Andrew Kreimer <algonell@gmail.com>

commit 77bfe1b11ea0c0c4b0ce19b742cd1aa82f60e45d upstream.

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index d11de0fa5c5f..9ef5d0b1cfdb 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1820,7 +1820,7 @@ xlog_find_item_ops(
  *	   from the transaction. However, we can't do that until after we've
  *	   replayed all the other items because they may be dependent on the
  *	   cancelled buffer and replaying the cancelled buffer can remove it
- *	   form the cancelled buffer table. Hence they have tobe done last.
+ *	   form the cancelled buffer table. Hence they have to be done last.
  *
  *	3. Inode allocation buffers must be replayed before inode items that
  *	   read the buffer and replay changes into it. For filesystems using the
-- 
2.39.3


