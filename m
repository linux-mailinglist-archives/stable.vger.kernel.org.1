Return-Path: <stable+bounces-227750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLOKDiJyvmmGPwMAu9opvQ
	(envelope-from <stable+bounces-227750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:25:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07D2E4B86
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 033B330172CF
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB8317161;
	Sat, 21 Mar 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="iZgumSKh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48032DF3F2;
	Sat, 21 Mar 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088731; cv=fail; b=CQ4zsATcRNoHSuRBQ4kyOv/uiNSQqrq0d43q5NMJQq0mFxbRxufecVGUBaRR3q6583fCqI2qeqNEgrFamSzqdQGsTvuQ0g/VWr9VjrfMLM5NEmg9xTN8nKTrB26+snCvSbF7wpEvGldDrH5xswqqMuqtIa53RCT6SBraW33NEGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088731; c=relaxed/simple;
	bh=eGJrFLV/bfrEnuvRyYS0LPspT6IEhXw7n6OpEnaS7ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zv4FUBiViRiqVESJt8xVqvReegeYSaHuiwI6s6u7KEXkFH61cAvVcIooHiXHta2HTpwlkDCvPirbVwzaK2GCCRlppRudxDkYu9kgBSBIPOew9XnDsES6CCVG5AJgyKXYXtVRI0K3COu5xswyVjsQhLNOB1ofrBVTGvakyX1Mvvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=iZgumSKh; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9tv9q3678047;
	Sat, 21 Mar 2026 03:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ODAZBL+UHaU7ZwKGZgCaljgyhBcOIJrzR87Fg8MUlmI=; b=
	iZgumSKhR5RlTBZFx5HPelsPBgSZ6CV06l7OaTggPMgH34Xz0Ks9uSTKPkKPQa/q
	iX0JTPOYEa2eBVcIZRM10kBQys5h7ztMQAhu/6xyC0Faik7TdSYT3ri+EupY/+VV
	yYfSZoxZgqjcgWWWtwSTjK9v1AVZbbd5HKZknqM+UW3XTa9BKhv/r14uFHphS2LR
	ej+sddNRy4Rm21yah7phZmme4smmohu5yxgTOBd/Ud2OHnOSv477oTsiMj6rrQhW
	P+yYbq0dWTTkJo7PRizCkj33BgvQ3hUTvYu3WfwTIBqYpqGYZSGAfnCqilYS/Ole
	FvzIHoujUx+LrVX26cecHw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggv7x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cES9K651gWmXJNttUA7cM1GlKq6z+f+U2dhwFYRN4exgeOYGJvUs8mG4CG0KcVWgzAGh8WNXVutLSqfoj/NXUADktky+wtbmzz6RboOLjIr3pr+gqNxo/bnur/ZI2MtXn2XRZvzT8CIti49rGV77dLZW52aTULfJMln9gwNK3Fvit1BBWSgdQ3WnLD7x+lEv4JC7Iqg8FJ0j6bq8FEGIfSypaCJ3i7SWdkJ7TYW0vml3FrXAAGvxtfiFld1xQd0cg+T/xh5+B038DySL9ZVh19mx8+SfXo1dSv2oBDasvVkcYtNQs/jRtDmfT9bBT0J42kMYbDmvRMKW94u/59BJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODAZBL+UHaU7ZwKGZgCaljgyhBcOIJrzR87Fg8MUlmI=;
 b=YEvG8aZ6VtGIVw3zGnsDkVyBNs0Uqz0sh0z+83FKeKaW1tG4S1Z74TuA/5rZLAzuVzDSX6R7V1l1y6/24c0I2gR1ex454tbs4R261d9AjQLz/WmftiSQDlhRHQ1aclkBEcw1W2/GgXy7LsvYqNR2+DglsQaPtBW6+JqaW7MRt2yKaXZm83obIe/H5XGhvJZK44bQ9V6lH0IoWIrHofx6y1J6KwkA/9mWdd5SGT3rb/mjGfzuOjXew/xqR7bWqctIeK3yrO9UxRi+c2hx5n++WWbGfpV7F5jMSor4b/+FOk+Y1FU+GFAf7H1ato2n4YL3baysxUpWLyk3tkCnnvy74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:25:09 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:25:09 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 4/7] timers/migration: Clean up the loop in tmigr_quick_check()
Date: Sat, 21 Mar 2026 12:24:37 +0200
Message-ID: <20260321102440.27782-5-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321102440.27782-1-ionut.nechita@windriver.com>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c455c61-1147-4403-f132-08de873420b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Hu9P+jPPABsZ7N77q37RADUu5hsNn3Enwek40/nxWdmTHXePw8kZHXsMLFq6KwRawRUTeC2DEC0bvMlM05x0g36Eu8CHcIlDSn2OqRleA4g9tzb+iey8Qwt08+t5nGBkZ7Obgobt+qgAPwLIGt/1PLe4OsKDoxU8ca+LSQHqUHoV9+C8g2/QxmL0amj48rNU9RqBfwJa939YVHVSppmIkmMCJoHII5DJX+07PVEoQTYQUjLn8g87Xb9GxNh5arzH/ISom1ydbF2o3tlyJMfgMzTiUVOxwL04Te38wjSA4BCXR4FtRtaGu5dC9s1zZ4ZaDg48gZX8z3nAKxKEZpoKMskVZ84MmKzuHJUa0gwK31V2pmxFTS3KSm3V/mbCDX1Y5d8ACM5eFljqfblKQZbzedAEzcqXtwF8NhkSuaB+dlpGYSBW15DO+qeO5ivXL1LiEtBHVKApDU9MHunA+jLax5kpHI9BxPIwcYHmZs8ViUSRYbakad/VkHIyqAEdvRSWWsKjA0OGiA1IKFwDnUUpJNdKBRYQC3Bs2S0sp9DYG787hvP5580+T+xnHR8PkhfdvGCypiXYj4KS8J5xk4Id8mwrNV5Beoyj+G42gG7hh1e32D323qedPCU+64JdxYBSGLXECxlbI+EhzZ854AZKKVxc3dc5cBRNoBG33La/QZCu4le41GDVS7H6kD0Ujwv9sIrMK0CJjnSJY45QhXsi9wC+cRX773RKBxAUaWTD+cRzWS8URFDZe87AUAm4sAoD9SR9+Ppw4SiQ/yR7yn+qATJlu9U0Dr3LDbj41DrKGGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Am7IebJSprbsJBhTfZyjWwKMv0hVkNjD5P8FjeN3HmQAeh7dz7HUNny7aVC?=
 =?us-ascii?Q?aEAJVfitxxSaDb1+y3k8GtvH+NKlGTbmFa5qMhF6czqUAcmX/okxqSm2zTPY?=
 =?us-ascii?Q?kL+Q8kb3An2DXiK3sJYIMaxORDK+ADMschr588Usy/aAh+GksmLHzUSw9A72?=
 =?us-ascii?Q?8FhF2YOGVWv5FHgHLpHxOma8yZ3kxh9IKY9zo5tYDW9WrrJWTpWqIF6VXt8N?=
 =?us-ascii?Q?TH+GfCLybBFyFGwte3DMaNT0qvMqYrU4vZnAws4svpV+AuEm04H/kewSkcQ4?=
 =?us-ascii?Q?2KX1QE4G+phPZ4XSg9reILSf4Z1t/7CFAS38Jb9DkhTP63x0pc+5DIVldLyf?=
 =?us-ascii?Q?UIvvoM25Mo+vjjsX4eAByppfK+mjWa+SsAA96U+gnbacCY8lPsPAcbJhyIXI?=
 =?us-ascii?Q?GnCejNI0i+7+QUJmD0LHPOjtu2shY1zRatb7jqtw29eg82rsrdDCY0oY0q0J?=
 =?us-ascii?Q?AE5Zl/jR3+tluDxe0cO04RXd6zdCi9wRXgoMvobHZfhZNn4Kflp9PEV45gbn?=
 =?us-ascii?Q?o1Y09GkxiUujbOvYv6OVU242HqytQ53OYM9OzH9DNTk3DmoKO2eqqReMaEuM?=
 =?us-ascii?Q?9Cr4xzNSfHXPwQXi4IGfKZuUbLeZ6ygeAw2PzSHMwkOU5tIt93eRdmZueJ63?=
 =?us-ascii?Q?08PUQ02XZEhh5vffrwuXK0bOMv6KTDNcrVxSPLpg9auncP6W7ZUs27bbNzpr?=
 =?us-ascii?Q?r4E5QyGxan71chZ2lasm1Kkvigax0l/IHIjlkth/pI6mic8Sq+2/R814KV/z?=
 =?us-ascii?Q?VauEXwIUBcpCiCdub9R0MUjzou5VDDmrOA4OS4tJEHP2kHGYaI3XF7zdsVyz?=
 =?us-ascii?Q?jvecm+B4zmFmWyz88klxvgX8G51QdSELcbPVomgj+46V5WJxw4nhw0W+qwCs?=
 =?us-ascii?Q?Pdd8S7CZM4QqimzUVgFWpkeHV17EDHfr+FYNafrS4gRzYyQCnmFAbXKeotsk?=
 =?us-ascii?Q?jl4HXj0FyPd0wC+LO8DU2qrQqg10pIg9027p7UxE+4dJPqQSD6lP+SFjY7VM?=
 =?us-ascii?Q?oggXBLSiCu9bniGU4pYinU0P6fauJvgqwDB2y739JDVvmImet0O9F3ad+8Ue?=
 =?us-ascii?Q?HFnGLH873kYaNbbyGVx8ujBFdRl/03seYGq579+pHESXTTvpJuzQWI0QMAYZ?=
 =?us-ascii?Q?71+njWvK5Ip9h/K1x3EvRMxKHrr2f6EXy6SYdHOvuD3mx8pc8+2Eg3RTjvQ8?=
 =?us-ascii?Q?516ZZhgUoqzL6jADh3xIXdLgM5NFVDZRGhjGJzmsKFRWjRgLIvp9jjIoZKND?=
 =?us-ascii?Q?xDumOYbnX0mBoSKlPIAHoR5yvdLpl3uDoUPWDu37wNCArRosvbZpU/ey3Qy/?=
 =?us-ascii?Q?aKkBY60JcUW98A/mSimRIrWEtC9G6kpHVU6717gFQzUBJaw8YLQpjinYFZks?=
 =?us-ascii?Q?+Q/UmI2fGgo1iX4r/vnHK3K17VWe89KH+MhmoNtxWD2WDUo2FM3qtpcEdxA3?=
 =?us-ascii?Q?iDphabwBmgq0TlzUUv3G+kkYt3VBSD7v5NBcJ91Y4e9uCw7zplsY+8jKAR9G?=
 =?us-ascii?Q?Nk9oCOnPDpCaYmmtau7r3Yumk02lOE+AX3cLll5S1vWWgFZqu+CrwlwG7gJa?=
 =?us-ascii?Q?mF+hn3+ANHKX9NykvmDjzd5AsCBzAUubAhfM/EOfTBuTQ2VcxFMzbJ3hVwrr?=
 =?us-ascii?Q?RWvmmhhAAwW4Vjpgh2Mnp3zSpF4NxRtZRG6ePHj1LmSC3T7BsuXVu7tXjjUI?=
 =?us-ascii?Q?nW1jgthL5Ij5/NOTkwLrlRPK0qbK5GVZeql9X0EmInmkoVsvSVmCXkXZSpBq?=
 =?us-ascii?Q?afka0Ifh23lP8ovcksaDTF+EO+cYERk=3D?=
X-Exchange-RoutingPolicyChecked:
	b+ko0Q3vD7ez6T2q3s2vGtEPlmZDAphxHy66GwHBGkuCwMjGUeXTVcLVZf54JAfmku23kPGHkBTSn+GD0tkl00WNschMPiNrR1BbgF8FdkLe3Y6Jx28BVHCj8eNq+Q6NlfJYDZAMS1nQ0M8whOAgC6vuJGIvmuYDmXvyH2BMaulUywKEIxY+At5RIS8zIaGsou2gXczo1NeXIa8/YOrdBKcIJsi593MIKCx94DEtk+oEqgQiR33nxT7kc+ktzs1JSTkDSKDBySO4b9S3NzxtTGIXUeOLLk6rnrLq8oNWaqmU/pqWqMeqNXT1cbeMfjsCRjjY4xZ43Fr+3RW5/IRv7A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c455c61-1147-4403-f132-08de873420b6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:25:09.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28kASGEvLoyeHKL2HrUHpAD0IBAHvsIZj/o4KiefK4HFiqpyKtH4kScRVvCWdb7fV2qaesPv4O4Bzx47g4829UgsHJZXopGZwt3+hcmYmso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-ORIG-GUID: 1uQ4Lb-2jcXojx6EmlC3gN_19Do_B6Ad
X-Proofpoint-GUID: 1uQ4Lb-2jcXojx6EmlC3gN_19Do_B6Ad
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be7207 cx=c_pps
 a=Ie6vhHcvS3zZlrI9i1bNAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=l--xBdwv-kE57s5NKCUA:9
 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX432ehPRzE7CJ
 WY15TnGDNoi4CsT2dn9JfvOBQmkeMXqfQJ/cqufU1Ysoy36JW3UjHqbGaB08THlXf7IUn6Emj8/
 4nQiVm2cHvBQc6Ks9LT8UXjwUvSRYfwHi/x8hf4KU4lki/6bBB70/V4865Z45/u9RHFBU75+7Yl
 +HB+TzfQ7SYXcq4oHrd40zFs1YddCXz5rRRrepWeC3Y5pWcp6b2atu2B0XRcGOAi4v4xw3CLVgP
 5F8fBnnGRXRwr7SbJZ4DFo5s9zCmm4CqeL1qODYl8WEa2RTyG05V+PZcY0ZYtZ5Rk/t1iwusE6H
 Nm2BzUykuUZiiUg3oS+63vQuHR/p3d8eMRo0S7m17V3G7M/uuEs2KMEU4M5XSmU0lM5clWz2K4L
 38xD3JbrVPiER0H0C8Qmm4ZmX4y+5deEKvOLiL4qZ4Yv5uvvqIBy17V9Ir7VokqUpD7GuosYm4+
 +5ctzAGOj77GlCxl8Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210084
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227750-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:email,suse.com:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF07D2E4B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Petr Tesarik <ptesarik@suse.com>

commit ff56a3e2a8613e8524f40ef2efa2c0169659e99e upstream.

Make the logic easier to follow:

  - Remove the final return statement, which is never reached, and move the
    actual walk-terminating return statement out of the do-while loop.

  - Remove the else-clause to reduce indentation. If a non-lonely group is
    encountered during the walk, the loop is immediately terminated with a
    return statement anyway; no need for an else.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250606124818.455560-1-ptesarik@suse.com
---
 kernel/time/timer_migration.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2f6330831f084..c0c54dc5314c3 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1405,23 +1405,20 @@ u64 tmigr_quick_check(u64 nextevt)
 		return KTIME_MAX;
 
 	do {
-		if (!tmigr_check_lonely(group)) {
+		if (!tmigr_check_lonely(group))
 			return KTIME_MAX;
-		} else {
-			/*
-			 * Since current CPU is active, events may not be sorted
-			 * from bottom to the top because the CPU's event is ignored
-			 * up to the top and its sibling's events not propagated upwards.
-			 * Thus keep track of the lowest observed expiry.
-			 */
-			nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
-			if (!group->parent)
-				return nextevt;
-		}
+
+		/*
+		 * Since current CPU is active, events may not be sorted
+		 * from bottom to the top because the CPU's event is ignored
+		 * up to the top and its sibling's events not propagated upwards.
+		 * Thus keep track of the lowest observed expiry.
+		 */
+		nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
 		group = group->parent;
 	} while (group);
 
-	return KTIME_MAX;
+	return nextevt;
 }
 
 /*
-- 
2.53.0


