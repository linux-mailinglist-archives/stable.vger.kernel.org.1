Return-Path: <stable+bounces-189959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65591C0D5FF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC8083442CE
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1312FFDE6;
	Mon, 27 Oct 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A49eSCi8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AAcG5okQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951572F7AD6;
	Mon, 27 Oct 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566573; cv=fail; b=dsdHkuRwXwB04OgoXoMtreJdDZHQWWHm//h+dJ9u4FLrDohRlVsRoT6UzbwF8yBlMCVanaLjqVY5H8WYvlBYRRBlLCc7L6ug3y4gf6x79CRZ/YJIsv+i13HOCJgU7AvzirR7fJiTynF5MytlOlMQkT9OonGH+A0UgLyOQKOp5ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566573; c=relaxed/simple;
	bh=UhWutsjTxxM6Nj+UXReKC/ybqUq+A8VKz+HbDQERPUg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NaqfPQOBm1X9TAgDtRLo0ZbdsdwOL0Wx4dGlFMBtGZsSRYA423bn5fFVHDn9CsfIkfScIFD/Vql89LXeM3tgUSRetLr1100NuPron8cGpPq1Ve9rt2zg/ctkfXVCrMXQWlbBcpw/kbPiJp/Ni+q2yuPsLbZIysFqz4BCZPJSSUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A49eSCi8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AAcG5okQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R9CW8B005061;
	Mon, 27 Oct 2025 12:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=y4pj9AHLwkFMEr9c
	9kBvOVzrpFujuuv7Gqfc/uc1z9E=; b=A49eSCi8V7Hf7JJMRnHBuS00dKNDQ2oQ
	NjA57uXRyUu9u86YLTidELr0YDJwYPO2xYFNAZ+i0zhzBC4hJzimc+LUUB5DaGEL
	t7Qbwuozq2C8rhHUwpejlFt5AV0eQOdDB6nomkeIr45qPs+vFmMIaYHqAEkYdi5S
	d6HS/+W3NX16T0Wf7rLRK6lx1slGBjpHJffmaTrniC31wQ+dSDQdKcdS7hy9+4R6
	RDvUqk8Z94JNF5c15DyG9AALd0++EUrOkJBNafJeGOF+FTu9fMTxzoN/PUK6+DuH
	ZLxPKG3sfCgEkX08cYd6JZxoG5fa/UXSkqgDgJ7sOzq1A9V3tk+ivg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357gpec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:00:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBrqWf013433;
	Mon, 27 Oct 2025 12:00:40 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n06q1gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNg1TCW9sB7hzn/2vut9GZIBo/CEsjSIaP0N7DjWYLcI6GF4FcB2s1amLlLJ30AWFqjB4iqL3bpqrpedHGOXyuuTPp3+G5Bzqfo1XVp5TzHrxC9pSa8gFH3Iec5Hs+N+MpoVgDvIY9+gsrVnaDbnLbDV3kXDlYvZCGNKGx0onulNyum5oMy7UGeDaBmnGj9TGLQUnTsCIgZd1VfvY1HMFgjA6O3xNQhXS7xpbGitYznUwbQ6cCxSPZz7oxTgKo3HxZ653W5qsjtQ9YDiGiiL3mm1k56CKW/cOMb62NgYK4PD7Em+UJgQfr+UYC0oICI66gN+9voUkUJADP1deGNcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4pj9AHLwkFMEr9c9kBvOVzrpFujuuv7Gqfc/uc1z9E=;
 b=dmDNwkpQL8SjgD782LjZ54Kq5Dx/VMaIwZhVp8iu+BmI1rDNr+/DK3+UXvtmIAbHYw4pFj0NOIi/L+1rQBWpIkiLLZBkKFG0D2dToo9b/xU3pHviFKz7vYH2KfBUdBSGJ6TdbuLS8RDyc29C+5w+AAeLhtnozunvxYHXRihAh//TK35qkgQZJEpSWeRRwH2HBxb7qmdhyZm6fhDqkPNTa+eu7c8YxikaVj4+bPUYIz+EjrfAK4zKJgqnKM2NZBY6CTUT4B0MziQ/gwTLef6/C7HSG9mhe0r2bk0tRlBSzdS3qaLk5nNYY+22ozme3YtHeQlygIjRxB4+dKki7vt9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4pj9AHLwkFMEr9c9kBvOVzrpFujuuv7Gqfc/uc1z9E=;
 b=AAcG5okQGX1tLO9RBa5QS30aD4yIFmUqDoxDNf21ZWoJGye6CvaURp+Eb+o+5mTPX0hOOgvLjQx7T4RkAoO8HQjvmwTjNNdzSMqjRbvW+AuzxNVWnJOA9EtvsyWzP47meLjl5pkSOaiGEf1Oy95qzlYfbsdWewHOhFweXSoTNZ0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:00:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:00:35 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>,
        Alexander Potapenko <glider@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Feng Tang <feng.79.tang@gmail.com>, Christoph Lameter <cl@gentwo.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, stable@vger.kernel.org
Subject: [PATCH V2] mm/slab: ensure all metadata in slab object are word-aligned
Date: Mon, 27 Oct 2025 21:00:28 +0900
Message-ID: <20251027120028.228375-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0133.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW5PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: d8801c7e-7e44-41db-718e-08de15506fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X0P2lt4dMmSucrlh41INcrwppknLkn4lfebrcKYGduTjnz+ivQkuwhBPSsXr?=
 =?us-ascii?Q?gpaVp2CS+YjjhN1BH4lFqdSgPtPC584fN7KKipSLvQeAtA7dgv6dnWXXEnmX?=
 =?us-ascii?Q?OfNzfqAEmAeNQxspvZZgwtMwqzgG3sBmKWzq7ml6u+USbMBij7I2zbiUd1t7?=
 =?us-ascii?Q?UUEew0nWwY1BUo+uCeVq4oS6SzaLTspBi/vMFQCCc+7Zwel660NdGRqNzeF2?=
 =?us-ascii?Q?F9iGl5VdDgzxK8K/uXSz1dsE9vAA3/+qTAeZOdbgBZdv53GjMKm9cd9107KZ?=
 =?us-ascii?Q?2xVj+3mRBHGYi4vJjmRZiZcNqu76lrxaQdj4nw0ldKdknysrwvyY/4rMDJqJ?=
 =?us-ascii?Q?zWYcN8xpk1ZP3Ei3sHFV09RNYdT5ZxovwVLIewlv9dX3ppJ1599fKkyMmq8E?=
 =?us-ascii?Q?dpSdHTx7dbccVuH8XZtc0u9pD3nxaSJnHtPYHPoDH7cf2BRZm1cWZdclGPSw?=
 =?us-ascii?Q?IusNoCFOokxknLVpuDytvdQk9IJFfOTghxagKzcYwzcxgO1l99Z+EdMZHyCj?=
 =?us-ascii?Q?H7q7vRHOR9rN6yCdQvReCZsqJoUB/RCdqFH9vBn3U7EyioIUO+Ymfo2dWF0l?=
 =?us-ascii?Q?43Z7XDcDVCR/SSaUXS+8oBV5LkjDgCj83Cb0FO0ZzoTa27ay0FPGGbFbiOds?=
 =?us-ascii?Q?6OZ604XhBF3X6JISB4+5p92NdtOW66g+blfXC1WlpGt5xjzB4GAO6hiwi7gs?=
 =?us-ascii?Q?uQ6aX1d7Fz9UovfqXQsGzLSD2FSc+4dEfrrCIjvXHsUCiZhr9cC4gD2AFe20?=
 =?us-ascii?Q?b1bvxtg8J8axqAcN70kNcEIql3LnI7P07jW61nLMWYy3j4MqFA4yfoj7CbHu?=
 =?us-ascii?Q?heGRrFPoYQyNYUYqliufXQP9tnIF2x6Gd6H3j+jUK+xONj34vd70G3Eao9D9?=
 =?us-ascii?Q?Jle1d2b+TrleUByTQcsStvnPfdIB05B5euG9yxTWAMnndCYpiATm06D1bheP?=
 =?us-ascii?Q?mDyulkFJxSt6LXxPkfuCjsCGkSePY/2Vo/sBuu+5f3xkcRlNIEjSLUYbsK6I?=
 =?us-ascii?Q?c3mwVSFGXHTYADjSqknsciWQt5Njt86RaPGcMfTr8zVIyP5i6FhYq1iEINZq?=
 =?us-ascii?Q?AdfsaqAKoKlF1aCRWTypcodPHW0VooQXPx+mf8xuqDbhCO6HWIQ5nbvOU4Yk?=
 =?us-ascii?Q?BWVP8B2o94oxFnb70caiJOWiAYWlW1ShqJu5YV+vtX5I+kYsW3WEUEOA4aJq?=
 =?us-ascii?Q?AiFfDtf0mSzBEcqGZ7/bM4J6NtV03yLUxKdOXQy1qHuaIkRb89K9ZTdSTP6J?=
 =?us-ascii?Q?Pwq+FuwtjdY/Aw7WT5Ki2agyqeT3YBkEgC2ZAgkcpjQqUTi3nT3vbjLeQcNs?=
 =?us-ascii?Q?1V7t9w8FoLZMZsFgbhOxxTXqMoqsKj7EfBhDNVmzQMZLxk/RMxzSp27ouyQZ?=
 =?us-ascii?Q?q6gRXx99yj7hRfFNk3KvlYJSlElY3T7IbXt69iC6VlyIsDUsixJq/wckWvQ/?=
 =?us-ascii?Q?rfGRuz8gRBIsqE53R7BaiIWtUU0tXzw2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uFD64CGq1Ohjy3awKpe/F0NV8gE3/F9EdM5/10gQUHZLPMw+qToTtO+QEO35?=
 =?us-ascii?Q?J/SXTrq46ZrTE3kSLC/9mgpKHAZviY7MwfPhbwMs4amNlCRAa984jDpc3fXb?=
 =?us-ascii?Q?r7hQGkJslnHYIlakB31M+YSyqH0+odEzKzH0P+88U03x239G0qbTS1SjtGjg?=
 =?us-ascii?Q?AVt5PAuzC9BePL3Go4W5GImdHhd67tN3KxxLk2mZ7H4a4E1LUCmCSxikdAw+?=
 =?us-ascii?Q?10f6wFdzzVasC24dZbwvYq0PjMtbUUXCe/f3bBuX1GZ6tUmWcwu+Douw41zK?=
 =?us-ascii?Q?k8bwR8Iv2v80L4QR4PVfg/mtxRqx4FJUstq5RLOs41RweGYwGrXudpbaDj4t?=
 =?us-ascii?Q?xgO5AvjKIeSk3q8UYowXo8x39rxOmNKl9Y7bl+d/9u8VwyRF7Tx7bCMIRwLl?=
 =?us-ascii?Q?rsBvZYMJ0hQHkvc3POO8zCKohy4b/l29RLzYvQuJh+KdyG91BzdgMmundTWH?=
 =?us-ascii?Q?jHXZ9o3LH7wJnBPYiwoY7/rbGWuBuRyVxVjduotI0q9cO7nlpg0W9nJq07Iq?=
 =?us-ascii?Q?0Qqd2xkjO2cSGe+OzKkh9gCVi0jRT2zoUttJfMhPGkn6APSi2wmOcJTlcUkx?=
 =?us-ascii?Q?psYVoJuZsgu1gxH5f6tRdLZQZ1nqOlW9m2z7eW15deZl91A3NCJ9Oc3fL+q/?=
 =?us-ascii?Q?Gkl1OhfmxgY5MaqtlTVCWdxBCWy1QJlVJm7HTnsq/RgVnM163ZMryD+a/WPE?=
 =?us-ascii?Q?SbbCHfp6d31JtRG6/YQq9D8ygSOSjYFrP0ICeBAVLmPyCfgUylz/ghGk3mf5?=
 =?us-ascii?Q?MjGeM/VgBst9atOIlwMqwA5i0TmJWl8+0fo8iJaAgEvA0mvlzGqjtB2jz44+?=
 =?us-ascii?Q?CgC6SHIRt6+Vf8iFy1G6C309r8h8Uvz1BhEGZv9HsoHm242I4jfhie6i9Y3A?=
 =?us-ascii?Q?HZi9KCuc++IwQJ0JWi7S+6s0cOGDUnu5LtUOPGtAu1QvPD7pflIIlX6NcCBC?=
 =?us-ascii?Q?3mnHGLHqHk7ygLQ5t0DZ78X87HA7MfOk7EE65UMQnGS5Ovg4LdO3q6zNzGM3?=
 =?us-ascii?Q?JfM0nE7bXMGf+hpY4xmL2XlR6pX2Cqo9XTRQVUkU7QuT+E8swAbexVxmczRC?=
 =?us-ascii?Q?29IIIa2NIfEt1trOvxKWIZjsZLNr18kiR9is5AefYwJj2Kmb57XEuAzA+OPF?=
 =?us-ascii?Q?psjb1Cs+b6SnYQHgstv79Zq2oMPFkolf4v+6/zEe8Ri/XyRMEGj6sIqAuEvV?=
 =?us-ascii?Q?5ejE9kPE2ONYH0VeJiUbP9DIYqiVT1uHNrEhlJ3owz5HQv1S5l7cICPxoQPl?=
 =?us-ascii?Q?JYKvo08ARuJ2iNFh6IBXa8XH7w5RP1WKunmG/HU722gFzmlwZ5KP1RTcpWSK?=
 =?us-ascii?Q?9buL25JpnS9aVIrCPGRp/R6pLUlHqrXRW6ojXIEhaGYBl15edcLG43zc0688?=
 =?us-ascii?Q?N7Cl7bZ1ycIJDql2cos1Tsu4uQBUOsLq8HRax/aN+Kt9HE+7f+32pwMzJHUG?=
 =?us-ascii?Q?bAc2fAe0YubAZJ+dlBTMKkrluGXvPyqtVAKgABR68TDnTQCRUgKVWAVID2Fh?=
 =?us-ascii?Q?BbVLPXcfBAFHDD2oE+4wVcTlBXsCD5eBuFScQ3ZhcVjvryHhiQbdzJWLBHpA?=
 =?us-ascii?Q?22kg4jFchHH/UXKA3iCUG752W84H7XB96JtUV4t9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qkn+SrykPh09H1q2XT6ghyvfT3HIDKDqs+Y8GkXJoolOCv9kn+hGYWzUVPOZZNR4qLOh/Cj0UtSL4Da/eccApfixiUkGUwnQHIkOVqKmX041kbFlvsyWuMLhE6jIt/z/bcsusNjiC3uZnGFnqBDnZ3EBhcmvLndmRhuMe3IQIRMgk1jBt5Zv4l9Vg6DroM3dIVaGsl25RhYS9rVGOiWsxckjgZup+nAnRws79kxn8j6xlEqWaspspaE1VuvEOjX2nPeMRzXsq+tQ5cJ5YxvUC0Knu9HtFd8D2d2DOul6lrbb/b323O5Wq9oC1fcCHOTzI6JdrDuagXb6nEOYEY/GeuELP2d7PpYpTUiKt1EuemfW6gjM5yrDN1HX8W8cbAyZQIYPO5FTEFzsYXR1OZwZLpFLDvIS0+NV/byVVW6iJ7D/Gw3LFBbtWH1EcPGgiFcI8v3IO9Xv1KxcXLOknATwKQ2h/ZIk2XFhNuzR/yAH0Q4QL6geCiOpqD+dbqAys/BRVECT/t9T2iJzHqeOQCYSUcwJhOEJ3Rx8b13S8VW5QlHQxkTHiXm1km8+9ROf5Nv5y5nuni6eLMuaD8dFbG3JoWmndvpoyDKuQYlmtwQptz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8801c7e-7e44-41db-718e-08de15506fd1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:00:35.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpfJLC3GRbrWJSi5go2UhD2N1xZNm6/2SAHITxfoVpAfl5g8TLSXEp2PuR8Gt0jCTVXeqvGhxF8B66uuEr3JIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270111
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=68ff5ee9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=60bAUpEqyJ0hnt3RZ0MA:9 cc=ntf awl=host:13624
X-Proofpoint-GUID: YOXAiuxnodo4cZmxgGIDBMe7HzYiy_Os
X-Proofpoint-ORIG-GUID: YOXAiuxnodo4cZmxgGIDBMe7HzYiy_Os
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfX2gaPL8uCKjWD
 +t//X9Cdr4KWUwQxozYWEKg663nZLaS48Y4XQB31XMo8cerJP04eJJs8UAZOEQEg1IOdCLXsvTG
 xaZeVx2FKHSLj78p7jRGSyWPGUTY+zXZC4QKjV3bkUaCKvrnlHCinmQfyfMhiXcKIJE/P1rkzeb
 jfyXldKR3bj8V/06PiBPFIGc7kGzsPd+nk5qZNX5ATZDWIfXM0ep+Kj07V3pEGS8HcMyQLJ9L56
 4WVqp6QsBEEKyfqe4cT5nhDfaD/zkCR2xCxNRjiBoTicT26nEFTW1ww6RFgIYMu4+XQAWh8BUjr
 jIJWzy8ZzvJ89RXF8OgFRF8HuUVDIYf8Y7t/80EDzKrzlA0Vz2/VW+bqyPYkzQ51gEorBqWnsKA
 LCIjIZHWs+oftyswW8YGY7l14gwjgA5VDuYetJtpq13eaeVlJUs=

When the SLAB_STORE_USER debug flag is used, any metadata placed after
the original kmalloc request size (orig_size) is not properly aligned
on 64-bit architectures because its type is unsigned int. When both KASAN
and SLAB_STORE_USER are enabled, kasan_alloc_meta is misaligned.

Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
are assumed to require 64-bit accesses to be 64-bit aligned.
See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
"ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.

Because not all architectures support unaligned memory accesses,
ensure that all metadata (track, orig_size, kasan_{alloc,free}_meta)
in a slab object are word-aligned. struct track, kasan_{alloc,free}_meta
are aligned by adding __aligned(__alignof__(unsigned long)).

For orig_size, use ALIGN(sizeof(unsigned int), sizeof(unsigned long)) to
make clear that its size remains unsigned int but it must be aligned to
a word boundary. On 64-bit architectures, this reserves 8 bytes for
orig_size, which is acceptable since kmalloc's original request size
tracking is intended for debugging rather than production use.

Cc: stable@vger.kernel.org
Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

v1 -> v2:
- Added Andrey's Acked-by.
- Added references to HAVE_64BIT_ALIGNED_ACCESS and the commit that
  resurrected it.
- Used __alignof__() instead of sizeof(), as suggested by Pedro (off-list).
  Note: either __alignof__ or sizeof() produces the exactly same mm/slub.o
  files, so there's no functional difference.

Thanks!

 mm/kasan/kasan.h |  4 ++--
 mm/slub.c        | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e64..b86b6e9f456a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -265,7 +265,7 @@ struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
 	/* Free track is stored in kasan_free_meta. */
 	depot_stack_handle_t aux_stack[2];
-};
+} __aligned(__alignof__(unsigned long));
 
 struct qlist_node {
 	struct qlist_node *next;
@@ -289,7 +289,7 @@ struct qlist_node {
 struct kasan_free_meta {
 	struct qlist_node quarantine_link;
 	struct kasan_track free_track;
-};
+} __aligned(__alignof__(unsigned long));
 
 #endif /* CONFIG_KASAN_GENERIC */
 
diff --git a/mm/slub.c b/mm/slub.c
index a585d0ac45d4..462a39d57b3a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -344,7 +344,7 @@ struct track {
 	int cpu;		/* Was running on cpu */
 	int pid;		/* Pid context */
 	unsigned long when;	/* When did the operation occur */
-};
+} __aligned(__alignof__(unsigned long));
 
 enum track_item { TRACK_ALLOC, TRACK_FREE };
 
@@ -1196,7 +1196,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned int);
+		off += ALIGN(sizeof(unsigned int), __alignof__(unsigned long));
 
 	off += kasan_metadata_size(s, false);
 
@@ -1392,7 +1392,8 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned int);
+			off += ALIGN(sizeof(unsigned int),
+				     __alignof__(unsigned long));
 	}
 
 	off += kasan_metadata_size(s, false);
@@ -7820,9 +7821,14 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 */
 		size += 2 * sizeof(struct track);
 
-		/* Save the original kmalloc request size */
+		/*
+		 * Save the original kmalloc request size.
+		 * Although the request size is an unsigned int,
+		 * make sure that is aligned to word boundary.
+		 */
 		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned int);
+			size += ALIGN(sizeof(unsigned int),
+				      __alignof__(unsigned long));
 	}
 #endif
 
-- 
2.43.0


