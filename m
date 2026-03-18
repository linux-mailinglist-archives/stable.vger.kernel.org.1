Return-Path: <stable+bounces-227090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEY8BI69ummqbQIAu9opvQ
	(envelope-from <stable+bounces-227090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F592BDADE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAFCB3004F3B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C125A3D9024;
	Wed, 18 Mar 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/NVqCnE"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B33B7B63
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845734; cv=fail; b=Or23uuSAl9OQ1PVP5KGv4M/rSMJFJqGI3Qtghv6lpVZ3eU41U6+e8NlIkgurthQ+5HyQqsp+0VWr7BiK2ymzAtsisQ+Ty04Qjr+Fa/dawvqOro4MIVM3Zu9LabNp9s23Byd+N4FNMg7dgAPsS+RawF3QjFv7jBCVBpJrFla0Xok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845734; c=relaxed/simple;
	bh=172ZAuLuXbcMaRWBFp9AvyDZI9lltuLvtKvtdq5U4tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHFPfqJ1tcU5H171+v5nAxlGL28bag4toKp8xgo822/Gk5MFGyNgMkGBh2LEYmrhQoYhPTdF5PxdUlVkk5WhQxxUM3Slmlts8ZR3icx9rlzakfTRUn36ncJJSRO92ykrPylpvULd+gK4aelbEBljBonFuwIJVYS+PTmiANhtTXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/NVqCnE; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL7whtAy6FCedpEy880ahvvoIvyb6Vq+GMKyUXHt56tbUkAnwsVjl0Bheks0lr6JprHXx6nYmX9u6YCjFrqek7j6G2YXceEnaQs0SV3bdyQsCD4reRKU7k4x7gozYIvDeS2nEPHLo+t9zlaAlrW3PIMEID63rHp695aGLF9qbo9cr6KqJ1rtVIVG6j5eqiDsOyGbU0yLpGW/qH+v7BiZpTRSRFWD4lZDsSzE6jkrBN5rD5mnuO/Vbhj8T/ga8EJ9v4BMiQ+BSwjBr12TUPETkyLrIfusGuBrzxuE6QjOTKqtGcC0/L+3Pbu9vIRtarKUzCM1Zj26aPSR/lIbG331vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mQOENlRsfdBO82okUdie4u3MXm6xAqkCMbLkmqRHoY=;
 b=LHogV2NBISQ2AYIEnvR7Cy0Bi0hP256SxMBCV5hO+Dr+oI3JI78RkujD/KhnhpIwXVyVfoWKWp+vEmf8A9k8okDTbSlqg+e0MTHM92ULC0Ud+VMsXSeiKPX4knIvkA+2EZPGcMC5wOKMrj039ATlK0AGxp8KDAabHPqVOBjfeIRKyvZzowuiVW3PV2rmXrYGGY+KF8w5TVNLxiYsUB08LplrKoCPHIrKw4vmN0OI+v/clLoMUu1X+WZoHEE68wBCmuNs+zPx1eRuZr/63mT6cDyQ6bW2fMv2WBZ83jzjb1Xp1iN6LLisM5FLVDRb1QlnjclLnI/WwY5STmIvskY3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mQOENlRsfdBO82okUdie4u3MXm6xAqkCMbLkmqRHoY=;
 b=L/NVqCnExqrVCnc3R+K9AuGacsYjF/fHQZdpN7NAUu5UVDcrWhEQmjz0LKZ3nv3vp1v/yA6NKwNKjaSdsjKIp5gt3HdviQnWrNnoRiOakdznaUVyxp89XVF/g1/2mUS86qcf4QO+49wo+P/RlmCae5dwDhZbpiOkzdN3mT4r6WiwD273dV6KR4GcB5vKLElxK9Fpc0t2fLJCkryZ3jrSQsoxg8BZ+y6SbzVc3kVRR68ox2zUUhREy2/rqyuqo01FMzJtJgWsbI73H8YzVnBOpDHWwCLFEbacJmTeSIhtX5b9zZZmt4s3meNLbdZSPLe9giPGHkGkTPcTW5gf0ERYmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 14:55:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 14:55:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Bas van Dijk <bas@dfinity.org>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/huge_memory: fix a folio_split() race condition with folio_try_get()
Date: Wed, 18 Mar 2026 10:55:25 -0400
Message-ID: <20260318145525.261086-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031741-handmade-lilly-566b@gregkh>
References: <2026031741-handmade-lilly-566b@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:4:ad::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: aa426100-6513-4072-f4f6-08de84fe6478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ula1aAcCU3yJrCoDeGjat+H4KbUtv+/1crLWH/58yuY5xJ4WC9GURUhkpd8KG5LLkypHjQESPbqGmJ1jCgVSfwZO1qQmII8EhJszk+ITFLxXE/3nKfV81PjnDC9Bj1QA/KAT1dH+vRz89/EhShiTIAURmzUuRl9RBSMjqmPHdxw6QCTSLm8qn+C9pMRpl2j2wh7GD6S+9v/GtlCgefF+nVIe5eH3fBUSpd1BgvrEE+hWDIhvmW31fJ7RVBV+qWn5SRAEFUyT/VjgM7K5aPUvGL7s4gfjLxddi01FEIG5DRXP8iAO48HPqI/hNDw+UeD4NV1tn00G3RX9O/FgxsPxifbjK3TXTnLU/hMZqg8fvFVTWqA8xczdGyymSQsgay45V4u/v9ZZtK9yU6oPB6Gc68tPt0RusGuQKtwfEy3MMn0OkPYwwCAEto1An5CKaDU6ce7tyraPIsvQ2xln5GCJQgvYo3mqiSU4V5fYBarX2kDyPg75WP5UtKxNyvBwqsjytohlRpU4AqU5P0lI9IeTD2b94pfF/XwfXKX5a/KXasn3881ALNbbbyyaxzg/68yuJQi5Ya83R37P8wzxQobizZOUOggyEF3hZNzh7JDd95lbDsp/cNpVHN2TO7VQzdeIVcuPY0gFLRTQhxRarV2VJ8eNzp29cBP4SGS6BwfLzPD3m9u88AkN/fnZofied3xFVSgt5FPFGzsIGCHkHiFdezxS2dG6Qf+xTeW4aDm0rKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3Qm6sojOd0A/acuDJxMe9uNwR7z64IvRX/7Sm13iObefN2D3Oc0DzXw6d1D?=
 =?us-ascii?Q?CG9iSsBVYMAtF7/Ul7R0ktWJ4NuaV97tSSC5KxPwnmHyUdEnQOItA92xh0mZ?=
 =?us-ascii?Q?5SrivKfuJNpFcdwFQIHBuNGWoVv6iF4A88mHNE3SASkAuVkGyajMPEXL9DGw?=
 =?us-ascii?Q?SvJEcBXsEH5et/2LnHffn7z7Xm5XNxpLgkNXLMDVYRE46iI5T31vXqJ0bqgP?=
 =?us-ascii?Q?YrqW0RtYnIEjQKBmfXxt1ChlxQENwOXPTVMt/kJCvQoRr8Pv6dE4T1nHDzNq?=
 =?us-ascii?Q?H6q/sA5D3iHZedTNY000JAIDmbJWpKIUOCNrzuCB+i68erHXb0zAIzkzdNLb?=
 =?us-ascii?Q?qI2TOPNXQyACp7SuE3gtVoIj2HOSdZGwSWDr9dpicNOV5sfkw1KxIgI2hgHf?=
 =?us-ascii?Q?6RlwSLDgUahJVh5ZilXQRYrTWzVzBhXdnd66z//gpFd8ni30cO1yIF2VkOiF?=
 =?us-ascii?Q?vaP/nbZvF7xaHLCH3YKMyX18fmTHXaElJpLA0aFYHbpW+GF6iYoYj+jq0qdC?=
 =?us-ascii?Q?VQoRdsxa4eYCuBQ7cpRRLnYWHkSLpHfQHCh94ykfTT8mWQ+D9Luw97CAtKN7?=
 =?us-ascii?Q?P0Ia7o2GzOhg5ZG2WRjKo5whQFc9r+RDlp4/6u02FHIzTMtXvGjJgCXvLTov?=
 =?us-ascii?Q?02Tikz/JrtjTkq9aj+QYsWP4CNlND9FOO4oDAHh4kqLEo6udxruUqr3kMOjG?=
 =?us-ascii?Q?T72MDCMEH/7eaAk/vD0e2Z8XDI9NBU0ZD/hSrOlUOFg25Xi8GAYh9+9DGiXP?=
 =?us-ascii?Q?EqhYLbRaiXYhRfoh3jj2tHIWIo5UjNeGgodAUu2fwJmti2s3FK2kjrSPneSV?=
 =?us-ascii?Q?1NOywpFp6g7wXEoDSBIkT2tOpZ4iZFfW4v4oCmaoRHtmkEl/OZZ0mLtjTI3Z?=
 =?us-ascii?Q?FJqpylJkR5fIfAnMWJstbKXQl5y+2JzIeGmtBoRwNvybr6RzZ29Y2nuCVhQ/?=
 =?us-ascii?Q?4fs/Nuyt7JM9wRbnn0wkkc9mzgNkAhSiLf9obYvlKG8FYDVlzDQIFQBLO3BY?=
 =?us-ascii?Q?Hi/BxDrxsqEmAhqcoA2lpD1V2dPf8Cw1PxET47IwjtoPMrK0nKVcYKAcDLGL?=
 =?us-ascii?Q?Cg4rdzyrdQsp4cSaAx1GeNG0ERKe3eeHhqiyqoMF9GeUz0FLU70THPIIUwU0?=
 =?us-ascii?Q?zhWJy/jjTYd1AD8dfYEui9OnY29InLV4Lf9F9UpGWft7Zk4z79C3eyEvadhK?=
 =?us-ascii?Q?ticocJkBJIKtqXLWsOjgsSVY+JN3cTCSoC0HIZpQ/BSxMHRmYBK4hyGSweqj?=
 =?us-ascii?Q?7W6hM7XCzfBpF7eiSgCtMWlK+REubZGf3a9fO2ZOKdxb8JQmpU+ls+dYheHc?=
 =?us-ascii?Q?NKtspaFX6u1GLO3qvFmnr4+mfLycvaIUWaaSGl6HiWcwNL4bqGx4CHKIU+XS?=
 =?us-ascii?Q?y6eRLiOgvGRZFRPnhR+dNJi9B59ZrHRCiCA029pi05LcHt4KgrqQsg7IW+P1?=
 =?us-ascii?Q?BqpxHJzua6LnUfT/cVVFTrhouzoM4/UHLAkXXyeJJAFS4C1Rqf/Ea2MTvixA?=
 =?us-ascii?Q?fMbLgBR4fomlz4TYcu1z5P8JSckd0YhPF7Z9a5MvHYiq9SQpKFnYR1vQvOih?=
 =?us-ascii?Q?f89RJplDSWLkWmMuZlSSRvf59XmKXSbl/j9yxQ6KUxEln1EWel4ySECdzW/Z?=
 =?us-ascii?Q?0P+ULdIhS9TPcANAX1hH9gkUI8xkvYdDDMjBO86n66/KAESbT70vxsHVvlCT?=
 =?us-ascii?Q?8jyC3KqL0NVXw8XNXdNX7LmZKHUuietvqbZi5rNMXgxhRfPrSavN1pT7BPNX?=
 =?us-ascii?Q?IPSFmQevObE5CcJG+SxqJ9kmRYnfLcv+dXQDOJypKTJHqN5+hF3P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa426100-6513-4072-f4f6-08de84fe6478
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:55:27.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycQfoUGsOAZMPGct8s+VRXOr+N3S+U6BDtxXrvuHzcFOz4DKoQeHRmdc8qDghW4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,dfinity.org,linux.dev,oracle.com,gmail.com,linux.alibaba.com,kernel.org,arm.com,google.com,infradead.org,redhat.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227090-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.914];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6F592BDADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During a pagecache folio split, the values in the related xarray should
not be changed from the original folio at xarray split time until all
after-split folios are well formed and stored in the xarray.  Current use
of xas_try_split() in __split_unmapped_folio() lets some after-split
folios show up at wrong indices in the xarray.  When these misplaced
after-split folios are unfrozen, before correct folios are stored via
__xa_store(), and grabbed by folio_try_get(), they are returned to
userspace at wrong file indices, causing data corruption.  More detailed
explanation is at the bottom.

The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
It
1. creates a memfd,
2. forks,
3. in the child process, maps the file with large folios (via shmem code
   path) and reads the mapped file continuously with 16 threads,
4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
   large folio.

Data corruption can be observed without the fix.  Basically, data from a
wrong page->index is returned.

Fix it by using the original folio in xas_try_split() calls, so that
folio_try_get() can get the right after-split folios after the original
folio is unfrozen.

Uniform split, split_huge_page*(), is not affected, since it uses
xas_split_alloc() and xas_split() only once and stores the original folio
in the xarray.  Change xas_split() used in uniform split branch to use the
original folio to avoid confusion.

Fixes below points to the commit introduces the code, but folio_split() is
used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
truncate operation").

More details:

For example, a folio f is split non-uniformly into f, f2, f3, f4 like
below:
+----------------+---------+----+----+
|       f        |    f2   | f3 | f4 |
+----------------+---------+----+----+
but the xarray would look like below after __split_unmapped_folio() is
done:
+----------------+---------+----+----+
|       f        |    f2   | f3 | f3 |
+----------------+---------+----+----+

After __split_unmapped_folio(), the code changes the xarray and unfreezes
after-split folios:

1. unfreezes f2, __xa_store(f2)
2. unfreezes f3, __xa_store(f3)
3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
4. unfreezes f.

Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
f3 is wrongly returned to user.

After the fix, the xarray looks like below after __split_unmapped_folio():
+----------------+---------+----+----+
|       f        |    f    | f  | f  |
+----------------+---------+----+----+
so that the race window no longer exists.

[ziy@nvidia.com: move comment, per David]
  Link: https://lkml.kernel.org/r/5C9FA053-A4C6-4615-BE05-74E47A6462B3@nvidia.com
Link: https://lkml.kernel.org/r/20260302203159.3208341-1-ziy@nvidia.com
Fixes: 00527733d0dc ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Bas van Dijk <bas@dfinity.org>
Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 577a1f495fd78d8fb61b67ac3d3b595b01f6fcb0)
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 35ec12c4d7766..95313612f4e1d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3437,6 +3437,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 {
 	int order = folio_order(folio);
 	int start_order = uniform_split ? new_order : order - 1;
+	struct folio *old_folio = folio;
 	bool stop_split = false;
 	struct folio *next;
 	int split_order;
@@ -3467,12 +3468,16 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			 * uniform split has xas_split_alloc() called before
 			 * irq is disabled to allocate enough memory, whereas
 			 * non-uniform split can handle ENOMEM.
+			 * Use the to-be-split folio, so that a parallel
+			 * folio_try_get() waits on it until xarray is updated
+			 * with after-split folios and the original one is
+			 * unfrozen.
 			 */
 			if (uniform_split)
-				xas_split(xas, folio, old_order);
+				xas_split(xas, old_folio, old_order);
 			else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				xas_try_split(xas, old_folio, old_order);
 				if (xas_error(xas)) {
 					ret = xas_error(xas);
 					stop_split = true;
-- 
2.51.0


