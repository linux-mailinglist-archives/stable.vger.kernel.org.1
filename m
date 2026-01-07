Return-Path: <stable+bounces-206084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9010CFBD38
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 04:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0BC93012BEA
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 03:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2419B5B1;
	Wed,  7 Jan 2026 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rioFkADs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WL6/8p/b"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11F4A33
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756134; cv=fail; b=X/9CyjMPPzplNMmQGh+SL0fcxvfi3C1QR74X5FYM32IVX9i23wKe5OZEugx2zklQPFi7hVp1YKwzMJ7CG62WsFdME3+BQQ7WIYt53objHVFRgFoCAzsiOtFb00ny2aL07e8HS/yHZIcmUwk1Ykeh6I6eo9ripH3bnS/I7VNQvmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756134; c=relaxed/simple;
	bh=8XDiJ1PD85u8WDN6B0Lt2A+oLJ4eoaOHb9oW0ZKONPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWawhvTAqDbxgqljcWULGC0GaWB5cL73Dy82GniqvD15Ro4RMA3vnc0OrOFOhthObNycifGj7FLFfO3pZdn83uAuiaD3oNIWmAZdN5Tc7B0Qu5Of4RwxwGXI89k4jFptYnGxzSw+KiGGihYDJD+QviPW02e5ejHASXSTYne4FwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rioFkADs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WL6/8p/b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6072tGuC764274;
	Wed, 7 Jan 2026 03:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9OoPjEKpg27Q2ER+OjoWaqAJzO+iEt9t8XvVbHjY8d0=; b=
	rioFkADsuBL0KIgWn8TvIC7rY3A7OTEW50H15IDPtm0FVx+8ogMpw8AVgHY6NU9M
	pX5lotMXRydPzkS6OUS8kf9R4XRTucN/gqFkxvBQvT2lS4MD0vnbQwnH4/rH4UNP
	pW36zsw2UQlkvO5stzfBJOxgeQ7ndH+n4fxSTncEL7Pm18CLHsg2MXFLb4L2oxk2
	A8LvSTZt2UVJI4DkRF6kWAqsK/XwkDddTwbQX9nSo3LidgGoX6XrslMjcrR7Y+VH
	NSNJ8Dz4H9hrfNw2FzoWHSY8t5WczeQW/gZfc8QFnvbYidGpeMRaPeNcXuB/Sugh
	2Xi8JvzORwFBX/bHg019HA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhf4cg0mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:21:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6072vTGh026331;
	Wed, 7 Jan 2026 03:21:34 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjkm3xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIq/5XDqcdxa+PaAS+fz3lEe8aBgjfQ4Z8ChhYYZbVWL+EFf0zNzj1ufB36cJw0wIIYbzArWwDUj3syBYZ6+IfuyGQUXHGz4WG7vjymHb7aBnAn6SrPT0lkvSU/ZAHqFeP/WD54Ljb3mcSfeyYx/gvoyxJc8e54AzIxztq2WAT3KsmO0RorEPxBdK49i7wMMbG0GmfG4A11KUDf1zDK0W6xnB6GH4EvVfUktabpaPzCEYnAwTJhZN1MyM5aaxqyD9j+Zz8bb86U2W766sMVUJya/Ekltpj0BDe4UdBHpm5pPMyFRYlZS4ms4NbHaWe8EeKL1s/JU4pALQY5j7GGqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OoPjEKpg27Q2ER+OjoWaqAJzO+iEt9t8XvVbHjY8d0=;
 b=nQ8OwyitcMaaTTrI9n2L55vBlBltu2I09vf7PWC3TJjz+2LEhnqB4disArc7RUCgQaSQnIZ8zfDe6zP7Cl7Bwc7kHlrpmmYUq0XwOAYU3LYtQH0qA536hOvmY+urE2I/dv8jgUYBugQjucSP/YKQRxWQFtPr4zPAM8kI217qwe2a+DyoDpFGvLzc3dxbWmEIb8dzrYcFMQMSwxcSEiI0V2zWE5oOsboG5qgm9fUIbfEsuvzlmhsqgWTJvqQ1/ApwJDA4aHJOpCtJuAl7rW2OhpomsZgbCKEST4NA+sAk9R/Jo/L+KSq+3Rh7GNJHEMFuqq9HDQ1/noYJw69yGdYpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OoPjEKpg27Q2ER+OjoWaqAJzO+iEt9t8XvVbHjY8d0=;
 b=WL6/8p/b+/QeB0nlbBTqg4VpyzdL97T4uDMsaJvCiyqfAOgqDZazFSv8ha+zjrb0mfK5Qf4FtgIK4k28bNGmR3ogZy3XPpyqDWhSiYBz+gAIi5hb0ZLxeyu+V4WWnaGvREUT+JYjbHoWnVvJaeg5Qc1lFHjolG4a407qlTEyeo0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 03:21:31 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:21:31 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Peter Xu <peterx@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 5.10.y 1/2] mm/mprotect: use long for page accountings and retval
Date: Wed,  7 Jan 2026 12:21:20 +0900
Message-ID: <20260107032121.587629-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107032121.587629-1-harry.yoo@oracle.com>
References: <20260107032121.587629-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0162.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c06572a-7e19-4b58-2e8e-08de4d9bda2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5YXc1q9vFrxPYRoL6aMRZY815MKmW45QGFY4uNwbfsjvHdfjkcnsTdPi9IO?=
 =?us-ascii?Q?03Y2kj6xaq/Qv7ARbC4wQh23nDLGoBl7UpYK/MEAYm04qGax3ByA9hdxoRE8?=
 =?us-ascii?Q?xGsrJbG8IsDw96mVUVmyrDIInmH9Tbo4yocrDHl0MUgk8H0RhH3dHLO9WGm1?=
 =?us-ascii?Q?sah25Oe3111JSvEQ/rVOB7vOzyHJBM1mfW5uXJzY/Qq+9T5ycuvFe22GMdsZ?=
 =?us-ascii?Q?nG3nUBGQHQsISNnCP7RiT5K/S/l8puwJ+nWw4CKBZ1uDy1Qp+IBoyet1vG6P?=
 =?us-ascii?Q?z1kY07DHMG/2kftCRV7QL6L5Du61P+y7p69JWxsSUxNY17xbP+TKjViUtP0J?=
 =?us-ascii?Q?cUm9BHAB46jLoInGyQkAH7XcQMkryNdtXgF2Lzn8lv5D7YvRgEnM/9JuOXl1?=
 =?us-ascii?Q?KBoPqG9IPX1O7S5baIfR0mNPCx0H5EjwmHqtI170KH4jKOaCO18grqaOSwie?=
 =?us-ascii?Q?arywhs0845D5506SR8Wk8p0J7X+OyvqEBRDLmR/7qzTfNPPpHTj8vvkwNmlU?=
 =?us-ascii?Q?U3i4vz0dhI2ugyPebTIM6W91iJ9a+aEMgnaPFJqgR0K+YK5ag25YDUD9uR5R?=
 =?us-ascii?Q?dRU9/HEfRn8A7B5gJhthY/Q+pOlxDDZxznG1NljTcUJ142+u5kV5wpmp6Ym0?=
 =?us-ascii?Q?pbRigKtvoHtNau9h9Sq8bB4/oNCuyuownCQtLXhzz/tS53QTmEddCZeRCcdv?=
 =?us-ascii?Q?bPv4awiFikDKtY4RLYmvTCOPBo+Vow/dGOTj9M+bIR7txvK9cgqa9Gk69k0l?=
 =?us-ascii?Q?YPhRlUP8q66s2q+n17VcYdr6obRJJYMrtJgz+UetJfgEk6XsjJZQZ+WUbrWX?=
 =?us-ascii?Q?pbOlorFrwYJBB8MbB6pkJ0pAfcKVxB0id8xkdDpsZyP4OADifSjC0+FB8uw/?=
 =?us-ascii?Q?Id2+jLy9jR0n4Xym4JhxLUh3mYBcLJJaecWgdtD7nLWxfpagq3N+P97utXHV?=
 =?us-ascii?Q?Rssn1IVwFVkVRt6hCe5jLXIoCv/5m2UxWZAvJdTzygnCaxe0HtQE7SpDeVuc?=
 =?us-ascii?Q?2tgVfIZrenRfMntpBCHJ5seYgZ0NLxCUIzg8zoN1FoX/+JXtUrx2ThGlon0d?=
 =?us-ascii?Q?49dZ42Knf8HmlEGBm6l6qThxcSDyFYE+CXDGqHdAxqdjVTWvr7TIyDDN+kAo?=
 =?us-ascii?Q?YSl2ogdL3MdOKpzOTnCs9XJ613r/H8x2GOp07/2M1AB0KS/LWkc5A299pQ5L?=
 =?us-ascii?Q?RTB3xLlYSWwtdBib8jbVUqnXp38y3I/n8q9QoMxoXUH4JJ74V5/ol1mg1h0w?=
 =?us-ascii?Q?LGwOxbOfE6Q9tDSgzi9tqfwh1S2//sTvJ3sUSbUVVcMhxegAbA0TNhkZUmYj?=
 =?us-ascii?Q?CfH64Chw86lUa6bBHtjQztKrO2w4vFryzAmrY+xLt71v9Jh4YcaCaRyJk4JV?=
 =?us-ascii?Q?7ZCBfW6K7fcgdJIeDdeX2Z541h5Y27pDX/srAbxZwJcRIWrUOSoJRT03Frr7?=
 =?us-ascii?Q?21Xv83f3fpC+O0MgdrbmRcpKojHiCImu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGPeLmEBUCNgZhHJj9rBJAUkXs3ceOZ3ZWHTAxqL8hbcxez2O22IifQtTQnw?=
 =?us-ascii?Q?Ux/3WYh6uS2/cPUmjH0ss91uYzWx8b4szXlD2hxgtAQjt2kf9rz+msd9Emz6?=
 =?us-ascii?Q?fz+6EZ6Q+PgUA84lwi2KFIEGnXyBhVwte8Pv6nvE4QoeEx8jN0LDBXHmm4Od?=
 =?us-ascii?Q?C2tk9Tf45lPsJTXVxWxjKd7Aiw9ws+wuaYZX/Vr5sVYK4opMErglMFMRmZEl?=
 =?us-ascii?Q?++oUpHtFzp/mPZqa+x7rPefSklGJQ/6YwyuUTC6G/x0EpjREd3o6XuZxHTEn?=
 =?us-ascii?Q?i1w512uZH37hZvxf76bvb6Iqw9QnaXezIOLli4x1+SvhFag+WHghcavsX4kI?=
 =?us-ascii?Q?RoNmkwy21hwNh9Gm1S+rmw5jDqm5+xf+xYyx7/qqtnWdrAoqKGQD9GTsBorn?=
 =?us-ascii?Q?LmSaMZhbo84eCRPHsRk3taURT+RWquF4ZPROfEE33LU3jcc/FCCxIwYMYcBj?=
 =?us-ascii?Q?ZkTkyAwDh31L0m+ZAKY7Y8QW3Fl/QfrfRbXQkdM/A18B67G5J6IiDBTz7muO?=
 =?us-ascii?Q?f515zDldUioTru98PFdCloi/xhNx94kXIE53Zda9eLMzODz2iRWxS/3sMjmX?=
 =?us-ascii?Q?00cpfebFbylmyvbaqsSeLrSBWuVYmF2bSiwtqfIRMo5pBNQBEofp59StGzvh?=
 =?us-ascii?Q?dHijUmo84/ER/uugaE9u9LR+/zAmh0l8RC7opwJpjU8a6lgUVxXybi2LQv2y?=
 =?us-ascii?Q?TfUEgzBy4p184Bn+Nfn/olVsmw16OSWZbrmJTC477anaWbgq8jlz0I+wiVOX?=
 =?us-ascii?Q?nswBRHZYciQH6ZCZ6i/xSVTSznMH4jVVRRChjx2ehkR0A+z3cK7dGnRxrakF?=
 =?us-ascii?Q?in2TPhV2hP9nlTzO0SFpQhMNZEYR9Y3pdZ8HFKCsOShanCGClPhe+Ejz3Y8o?=
 =?us-ascii?Q?e2Tgny1Et/LLSL+jkz92wsVzJ+EdGSRlovnjolgOPx0YT5oeOUucUabt61BK?=
 =?us-ascii?Q?w4XHtaGi/ETMILklMAHDni/M1tY4ni+MzTXhz7RDr3awwCGIY3Q1pusyX+B6?=
 =?us-ascii?Q?zEOAHf9cEmvNXmL2i9W9XvDYYo1pZW6iV5w75Jl6HwjVWAKVltI3GtuO71SV?=
 =?us-ascii?Q?t4E17buEh9S1id/54wZxNTJeKEncP9ycJ+soh0Uv9frzJECi6UGcGB6zrAcZ?=
 =?us-ascii?Q?b6e/9zzTu59dJdA7m6PTFyak8ZjhKK7MMeRTlgIWkUMX6TAjx7WJHfuplJIz?=
 =?us-ascii?Q?pD2xbSTpxT7zYBRONOduSFDBs+WGIptqpilYW2AbM37c7XCeS26bzAL6GFWK?=
 =?us-ascii?Q?tKO8L+rgQN1/R535vSPbHiyYqWoSzQOtObGYBA/SIfBpOr03KFRE+LVW6Olq?=
 =?us-ascii?Q?2OlQ5sRYD4pLn3rBAM30NzU5yexx9qXUAYqSRjDo71jYRALLAJwfuHQq1m7H?=
 =?us-ascii?Q?ihC2oeDvbt8RJwLqMlTP5BM9rc3iSqTSFcbC9Hl1VPoqv7GH7kF15qORG3UK?=
 =?us-ascii?Q?+zg9sX4aSb7+ij/l1hzoXp0QdD48uL97m9NNTl5WpgKAdmnz1oaP3zwaUK8O?=
 =?us-ascii?Q?OCRWZ7r/cGxAy2krJt4j0E9HeeZ5xIQjyUPb4CqjjOCzJvxKCWW6LHNUqLmq?=
 =?us-ascii?Q?0O53g+MMHz6hTHx2qQ0zfTUsVD+AzlYYmYlUJgdizNnFaMfLY8GfB/rGs3Rl?=
 =?us-ascii?Q?a8CAENRXnl18yxk/DzHR4fYkmX/GkGP1huiQYY9wmXSvxikF5OUnH7T+MtPm?=
 =?us-ascii?Q?93obX5oqMj0h+/dj2Wt6uRhExBwtSC+PQRwMAu1bw57/9Yb8gm49O1drly/M?=
 =?us-ascii?Q?glqmpikvUQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	leJjTkDCfAdjSR13UfbO0uW11wMZzwCpq3vUb0tJgTdcsFQweo3U3UWjSTQv5vZby8pdOjLVQYzMosRteORpO7cRgEUhWvesDzigpI5aIMAREa+cOZ6sr/mEa1PgV41m51KPzPt4GbpU0yYTfj3T2HeMKfsA4LEojAy1+qYLWowIc2z27/tbEG9AuGtrjSSYNxdrbnNPlA4nj7OX/P2HKL8omFLCyK7R4uSyXRtYg2On9/C8SWRVNeSh/JDeuo9LSWyXkt4SCxG5YILxWx72zIfY4+4kLraO4pchoxjNtzgEzNo15HWOldLfvqjvakZaQRZtUlB0Ku/MPVeMWIde9daCamEtRPLXrqfIe95HAIM5LNT7xumuFsomCsxdtsptuj1eeQ1r4mcjTOnoVMqdnyEjAmJy1IY9RvyGOrhLHkI+NXDv8YiE6zsIJPD2K9B2PaJt7dQ9DcsxhJVkDHNAC0Qdc3mH1DA6rUECA1EXqZTgKgjLl0uH5lWFSg1E/tbUoeGeRgtlAVkcHAT+uc5CwP2smUYrD48RcCg+j3tBvs7ekpPrChcXPjKSEHo09yAwNXs0pipQMlXp6v7t4JQpP3/MzBQrqFjR2rf6jeC8YkA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c06572a-7e19-4b58-2e8e-08de4d9bda2a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 03:21:30.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waZ3/HqclhNgBQtLZeJQ42Ws52k6FUPb9t/gGcQ6Qa9M9Dwf7ZYS6eX6V9ZIxkxYZ8gh99mMcHL4rCP7N3Hqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070025
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNSBTYWx0ZWRfX/sZMb24yVTU5
 tfx5zvIQxuVvNH5efWa0ZcIJ9vPoGQ2u5LOkSe3UotmboUk+VNKzQL3uZkXQJJsEGhuXcnitU8k
 +k7M1Cqv2IuB3jQ/iWHwLVufFoqovqtLX/HzsT0KUiA8G4P2Emvg9dhQq3RV8ZHC89V5I3OgAMp
 YuoBTZNbQJsVN6QYzSjv4zC2jrtDjhFGxKp/wyO5ZiMYTywU9Y2HoNm9OogdkPwJn5TeZV1IfRU
 1Qnw8Ifu0SQwz6/2ldKvuy11X5vTJ+HIBLLTXC1D+khwIlW1/euzRY25BniGiRd2dItPdgrWzV5
 PAinMGwQ4w3cEw2xYUO3faVRsRhf0zuzC8eCal/LDBnRLThwW6FYB4fEyBePLpBziNBqJ3/WzhT
 9RSmD+k8Nxnd/dSypDp2YAhYgjWht2Wk4Tg904PmTKX7jBvd4zwVpgh6KYTtbWMl+3gyYrajfgd
 U/VfpCwKkY7z4XOvZ4dE35hxTZew1XNjXazRsX8Q=
X-Authority-Analysis: v=2.4 cv=NMPYOk6g c=1 sm=1 tr=0 ts=695dd13f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yhwE2cpgGALx-dzfzvsA:9 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12110
X-Proofpoint-ORIG-GUID: Gvwek4fuY9Bc2cIejtioQHecO9l_EZ9N
X-Proofpoint-GUID: Gvwek4fuY9Bc2cIejtioQHecO9l_EZ9N

From: Peter Xu <peterx@redhat.com>

commit a79390f5d6a78647fd70856bd42b22d994de0ba2 upstream.

Switch to use type "long" for page accountings and retval across the whole
procedure of change_protection().

The change should have shrinked the possible maximum page number to be
half comparing to previous (ULONG_MAX / 2), but it shouldn't overflow on
any system either because the maximum possible pages touched by change
protection should be ULONG_MAX / PAGE_SIZE.

Two reasons to switch from "unsigned long" to "long":

  1. It suites better on count_vm_numa_events(), whose 2nd parameter takes
     a long type.

  2. It paves way for returning negative (error) values in the future.

Currently the only caller that consumes this retval is change_prot_numa(),
where the unsigned long was converted to an int.  Since at it, touching up
the numa code to also take a long, so it'll avoid any possible overflow
too during the int-size convertion.

Link: https://lkml.kernel.org/r/20230104225207.1066932-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: James Houghton <jthoughton@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/hugetlb.h |  4 ++--
 include/linux/mm.h      |  2 +-
 mm/hugetlb.c            |  4 ++--
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 34 +++++++++++++++++-----------------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1c03935aa3d13..f4d20096959b2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -184,7 +184,7 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot);
 
 bool is_hugetlb_entry_migration(pte_t pte);
@@ -342,7 +342,7 @@ static inline void move_hugetlb_state(struct page *oldpage,
 {
 }
 
-static inline unsigned long hugetlb_change_protection(
+static inline long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned long end, pgprot_t newprot)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4787d39bbad4a..064349c1e8525 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1876,7 +1876,7 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8efe35ea0baa7..ef181edabefe5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5051,7 +5051,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
-unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
+long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -5059,7 +5059,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6c98585f20dfe..59ccda77d2fca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -653,7 +653,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
-	int nr_updated;
+	long nr_updated;
 
 	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7ea0aee0c08d9..28e1a8fd9319f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,13 +35,13 @@
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+static long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
-	unsigned long pages = 0;
+	long pages = 0;
 	int target_node = NUMA_NO_NODE;
 	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
@@ -209,13 +209,13 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
+static inline long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
 		pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
 
@@ -223,7 +223,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		unsigned long this_pages;
+		long this_pages;
 
 		next = pmd_addr_end(addr, end);
 
@@ -281,13 +281,13 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
-		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline long change_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	pud = pud_offset(p4d, addr);
 	do {
@@ -301,13 +301,13 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
-		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline long change_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
+		unsigned long addr, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	p4d = p4d_offset(pgd, addr);
 	do {
@@ -321,7 +321,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static unsigned long change_protection_range(struct vm_area_struct *vma,
+static long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
 {
@@ -329,7 +329,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long start = addr;
-	unsigned long pages = 0;
+	long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
@@ -351,11 +351,11 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
-	unsigned long pages;
+	long pages;
 
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
-- 
2.43.0


