Return-Path: <stable+bounces-155180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C856AE2317
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C61E189A379
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B222C325;
	Fri, 20 Jun 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpyeAg+q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CYwLph1h"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530F2253EB
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449246; cv=fail; b=enBxe+o/inhxPax8lxyqzaZCSwR3UBPAcgQgFnmM3LRGKxaQKX0xBHDPSbJNNvko2lYkLGOVRNuukLm2jwwGNZjYddw67Y6Rmj3it0Bwom2ZBpM8ULZlxj+RRFp61W68UgpgOcg1ubLugrxYbkJ2b/HtwZl6FdyfXB+H9IC9qZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449246; c=relaxed/simple;
	bh=vxsmxshfyNQxwpqjh/NPKyvncMUp2sqrV/y2CEmWJz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgt6wrHEbfvuayoGQ/db5b8tlcc7WNDXo2O/edJHOStDg2z6ok/suvZJVCI5iBZPNRSU95vXo8lJh/pNOZ3ANfR4D6bWhPdNQ+cf9Qjbcq43dBClkobrirpRC7wEfbJztM4VWmtP+lyh5mHtbSBiTltdkZn6c1xKc8dgyLAqDBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kpyeAg+q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CYwLph1h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBtOp019389;
	Fri, 20 Jun 2025 19:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NPYyJ9+hZv69AzcrbHAgFE6hRVBzyTBXFGE2c0Umw8c=; b=
	kpyeAg+qZv08cWethxarfjLeFv+EPETdQeuGxvUqiowa3bu0ZYad3NcGMMMSSctd
	QuOEp+ZZaUBfp2Al5mr1TGye0gPvzpqus9FU4sjGnppS2TgzL5X1FpLUTGLA0q+Q
	vKs9bvpdudsn4nQfdIZ16LB6b+bW4hBg3zWZqy/Zk5u4EIZ84ZBq0G5ZD59OKgiT
	E2iDQYFOivDmd0YLe1uJQGonl3TawP+YahBGrVmSM3xM7PWE+Ggdwu9dURTYW4Jh
	WtV6Sq8jqZv04/M54xQjVFY2bz2oQuWbAi10OvJTWROaLxGQceRfLyPOTlbYf3hX
	J/kSDTDf0L+r/47nR5n9eA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8rbb0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 19:53:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KJUWrr018504;
	Fri, 20 Jun 2025 19:53:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhd9qmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 19:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Z8E970tUF5ilrPqArveXcr+BV1Qul+GdMC72hHBaWtFL5SJcVIHguuAXAMFu0gEHDp6IsGiaI9uedGJzkUjV91a6z2Y1nQbEEK+dqAUQbHaRZNPpJ5OArTJrwD5v6I89LcQ9smDgZjEAqH+0gaIEYRc8p3Wgw+1J1Y2B/sS8WtMYtsVapR07bihANOZvS5NGckLVSvBIci6JOKR1JxxHToLdm+6BLXWCdUrTxiGZfwvxA+RT5gqQpqqN+W8AAveStdIYWbsOBPlF0dkhwEZOOaeGeTc9QSMf18k2m3isAmfbywemGKWFqalcamnuKlc2axKfKWv+4xeb29vUQ3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPYyJ9+hZv69AzcrbHAgFE6hRVBzyTBXFGE2c0Umw8c=;
 b=dzuaOhYVyc4oEh1jo0fumATBmQiG6KpiHMmOYOGvSqKDcFAy1vOETXzJi0RRnCbXE0sD8mP+Dr6PNjVOHem1NthtjfaykiwakhDMM1eymzOsjoDpu06fYVSSY70Nk8SSJdO2plAv5wfEY93p1j7ImdaaEDFp2qiAywTXKVmNiaTLl0uAvqO7Gk1ooNQaKfnQC3hKwbzfbDrDhaw8TO08WhXuh0K+oOQq6UKVDMuwN4WN4OseKyIbE2JTtypmT5XuRjOM1Lwjb/nBbBMhixA/rTp9KY0YdQn5DlJzhudHOlM9EczMIFZZqekTTVUfogXf8Dt6ZRIMWzwnYyi1yqU9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPYyJ9+hZv69AzcrbHAgFE6hRVBzyTBXFGE2c0Umw8c=;
 b=CYwLph1hLoFRAfo/oWkhIL4ekIjFl80sp+M02sR3dbd4YLnLhtTQ1dCdvc6BI46xlMdOvAl1zSUh/xD8Fdbm11POIjO568fm3Q6hd691RNqGXstOXAw6Y2oK61PUwaBySzNhx/G0z6f3AeW6ZYkEXmRr6f6HSl/RDu43yhWQ/Og=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 19:53:20 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 19:53:20 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev
Cc: oliver.sang@intel.com, 00107082@163.com, cachen@purestorage.com,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev,
        Harry Yoo <harry.yoo@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
Date: Sat, 21 Jun 2025 04:53:05 +0900
Message-ID: <20250620195305.1115151-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202506181351.bba867dd-lkp@intel.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0133.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 069fb075-466d-4e6c-87f1-08ddb0341b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OHGzgBUEVzJozjuM73q+8V7jluS9+b0wSwaOfs6m5CkIT9dBmQHN1TFlO7uP?=
 =?us-ascii?Q?zouafuqVOhHEPCv7gejMVdtrABDw2rYGF+y1ZvyTKYYPEf94O70+y9vRhqpd?=
 =?us-ascii?Q?fUgUzuPLHERGCrLs5XQB50HgOB6edvlW2l+BN+hbejR+SXZVzO0m9ATUddlY?=
 =?us-ascii?Q?R7rpROL1LvVRcXjpdgRGlVxaffXKgHJ81GzOZqxkO4yArWzrJ8tm9oPdj2IO?=
 =?us-ascii?Q?GuZLFHuWNHx8ZzKCn/WMlpi/7JskCNYwdWkjq3TctqRz9oJCTQLTU9prpsFE?=
 =?us-ascii?Q?YvjekHmVntqnWi3bR/a+gYG8eifsnyQ0EzQpIfBH7V3AbtG0E8UEqErJIJtG?=
 =?us-ascii?Q?t7exSYaEma1V/gVbLJpAN/to9lWnMNRD3WFsKq9AgTyFEBsctzpvwv+GCfFY?=
 =?us-ascii?Q?XD8HzYWbOAGHCKAVmB4ing6s7X3lDMF0t96Odwdwh94iaTktxaNHGyqGRxiq?=
 =?us-ascii?Q?2Kji7YCgdTBBla+mrIuZES0P4IiULmVGJOe0b61inCHyVG8++mml9fAmm+jL?=
 =?us-ascii?Q?ENVz+RzuaeTEqTbfLUWXH7yQ1MWkrCgjeDRplqimEc0fDg0cOsmMdEYadFZd?=
 =?us-ascii?Q?GdZfjLqUIRbc8LgkLWwRYw+pX1CXX186bTsrqx+i98+092WoZfahbH6BOojl?=
 =?us-ascii?Q?DvysxCSe4YxlzYRI1Lt/qu2NYkvaS5X9eiuJdOw0jK8sUph/Ts0K1L+zxjHe?=
 =?us-ascii?Q?0bMFxllQdRxypEKeq9bBwo/XVtVpT47PrgqlWwkWuIW3gC24f+XYAKx/ioyW?=
 =?us-ascii?Q?FScE2LKc9qfm7x9TbotZHJftSYqF+X4hq5FCt4+XufBmlCZR/LDN6AX0vxvm?=
 =?us-ascii?Q?lu2dMNQGONAz/hNn5xovpxXJnMa8TsUCk+QWjsyqTu1Kc9YJkdHIFIq5aVrW?=
 =?us-ascii?Q?ezTp6o7BewjtnwrVzdND5knKvRYdiq4MfFZmSqzgVV0o64jpstv/bbwn67lv?=
 =?us-ascii?Q?kZRDaUxTn5VCRd3i+Beh5yp8wCjzRaj9JZ0PYtfEz6Ahgponvy43ZfU1RNgT?=
 =?us-ascii?Q?nscCbyMiuWzRckpA96hCIZDiwpy8cHhSCHJ5ptbOEOB6JxkbPSTA6ezf+gkh?=
 =?us-ascii?Q?Hr+JS89A+sY8wggwcTKsfn6AgQWkuN6d45zUEuDkISCJyBqI3YCaW8Q7GUhS?=
 =?us-ascii?Q?0PICh02t2j6jYVFQhDEZ3HTZ5g6wYtxn1wFGCh5g+DFTk5N6NF9P8NVgHjhJ?=
 =?us-ascii?Q?kLWKqA4thqdSmWI1ovB/r9GVMrJVeBGPtaEScHn95I2aztlM6KBZ5nhNj4+m?=
 =?us-ascii?Q?IC/B1I+3ByZ0lvgN00yBDwncqj0TS7l+/oxFQVc0nu6F2NMizvkU0JoNYap/?=
 =?us-ascii?Q?Vwjhb7qfpZPB1ZGJWsAl8GR2hjS9g1Lkii0eCjPqACpBGl5xPqkMSAHtBd5k?=
 =?us-ascii?Q?/jTDLS4TEYfiCqUiD5Wli1vgnInVm5xSViWkymzyMmJZg52vEqnVZ3qMfwwR?=
 =?us-ascii?Q?sAKDNlELVXzjRBFdSR+IFuM8hpmd3xEi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hx0NAtR/wIswT53K4H0Zezu8wJPJKuVrJYnJdHpT9bPQ9JtQ7a7WCfLN0nT+?=
 =?us-ascii?Q?/ni65LFigQ6+n0MIIGZMTwBxsnJcK+X+6BtQl3Mq5pRsxuZ+Xecj6/8R9nUT?=
 =?us-ascii?Q?OqutSajHSv7GITwrE70FVISdASj8edCPgYWPHIlZZ6xJJbzxxWoGudOs8cg+?=
 =?us-ascii?Q?vr/Q7HWCEiSy62CjBvcRg6Ud+yniho7NFQ5HlTQ3dg92M0WTsM4Z9z5moOWn?=
 =?us-ascii?Q?ZrfAFySutj7vgI3ytCImIN9IQ4LcZstnw868p+yNi1zbDMf9DoVJkqhuuifG?=
 =?us-ascii?Q?pIbKq/+2x2e5B4Rkyt2ZK6yrrXuuvJ67LlbwtOhUUTg1WeeSt9p5S2VnqW8K?=
 =?us-ascii?Q?LXXJNQKPCQN0+RmdPbknbBSoD9t9cStMNj93Euey9/ZsFJS5FafiwLdBk3lK?=
 =?us-ascii?Q?XN3ISuoX+0I4WxtQVAe986lRPLDBa33OmZqh3BgunNvhZmEVaZapokq9zPCZ?=
 =?us-ascii?Q?hx8RLzD+K+MQIDdaAF99mk4K/SyJweO8WYn6kEJFBNdydFYAaKAH2UpDbSjr?=
 =?us-ascii?Q?W5hsC/JijsDLRdjyYC9MHloiC/hemeRVd3Pd5q5/8rOMUx9o1Me1D8gfnnsj?=
 =?us-ascii?Q?sbfqEUqzGFtLr/hXdhWFwNQHdeW8eD7AahCmwMCKSY3434tYTm6VPZbw09K9?=
 =?us-ascii?Q?3FIszpxh5/VDHWFVLR7iiVnEXABU5kXa2Y73SKS4JyKvUVWoOuwwKTA1WIPw?=
 =?us-ascii?Q?cKFi7X5YP0/jqidtZhAT/6Xwky0ceEyGoH/ufRZi4SXhDo3M/PJntxYwzcHT?=
 =?us-ascii?Q?vgN/Gucz7Y9e7o26IHZ7KuKMblCCWcARZ74rlNHGIeadVyV1FG+DCnBGfE1b?=
 =?us-ascii?Q?uxL2xAKQsL4Idl7sG7xNoc2duj4C3FcBsIU4fKmXYMZE4XHAF/ZGALeW27TY?=
 =?us-ascii?Q?f0T32U65qaO8MNniJaL4warF3GkHahmxdL6KKx1BYUicr7Ga1NNkPnhLqRfL?=
 =?us-ascii?Q?nbBFpfnpb+1wDXqk6X65bTtCFLdPoUcbDHAjrtTKINBp9uRMrum5j2ca4BiA?=
 =?us-ascii?Q?vhYS8VMlqKPRU9QxvICYaaFJhXLsRdMWaiWIPtpzhYwLdfBf8BhaEFTicqBe?=
 =?us-ascii?Q?QHDDFpyJumhEaN1SlmPe0u5tGFquULgwHQ3SUjg0eehT6n1BPxtmXQfid7eB?=
 =?us-ascii?Q?9fQTIc2H8h8jIyNuzDH0wAxRXILCoxRcl9+l0YJ43dOMaY8beo8nhJTIzy1s?=
 =?us-ascii?Q?BWQFNINjmQ0dSkDsWEyLVH1bFTkdYWwKpPboF29YMePMHMXrZX3v1unRb0Ju?=
 =?us-ascii?Q?Dc71N/xbd6zCfHGFivMZ7WTDwLcbgo9FjZPgnmYMRGVv44i8IarqflX9yAcp?=
 =?us-ascii?Q?VMauxeodV9S/BJEPwKaokKvRFaouULVWtrkpsRldP7DyEQNHkvvwfw9610mT?=
 =?us-ascii?Q?LMycy3giG85z1dgIJhVMgisYpcczn7nGDwEbn+GD4a/LA6aeHbpznDVaX4lb?=
 =?us-ascii?Q?MBz+5bKe8OcBCU0a+kv0BvzOPHAh55sLA1aVt/8GAu6NUVOXgLfho2FXLNvL?=
 =?us-ascii?Q?qllcP7CB7vGDAi0+HTolpbH+kWUmfUyCiCMlXJwniWc7zJCwHQpnjNdHNEzK?=
 =?us-ascii?Q?sc/63Zfe6eTXddy3U4ZxbzalmhtLlQFT3tCghKWY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V4QwY557z4QOGGmE1V/3w8jnp9bZUDQU9dROpp5LkW69HDooUUAb05XWFIAOpLZAHRUTUo+5GvpEZP9Wq69h270FjMY5oT7HgMyJNnr2GTuo8uVM6Ky0mQ9GkqGmCgX2fBgt+CldmYvpO4o0wpAoHiqOqUnSYEtcB19yFyBG8T/B039PC8svwJfckw2YqfaUulF8cMG4y+mlD2NV7maI10uOnUyChTml2vVlQBX5Ww8HJVgqoeIS4oqK49exHYQ0ZlrbdSbMRAXuZJ6rH44FpquAvKsdQnEdn5r3KhRe9LdbqBl0oburYhEtDjKt4CWMM1GJa7fnuZvXH0r9r6eaGjVuyjIFrtPGiXZx71w9ABza1GQ9nqbhKN5R5FXxSKI3Vpp1RXiPpyS+YqUXj4O/WaKSmgetDL3oo0ZMsOvc//2tG2iUGtRSblLRQPeCUHsmz8uUvvJhZiY4HsQpWAjJwqyF8pc8kesmQ7sNgzwTkBGu7qbmyQ+VJVLX+mN5+IueaJcLlW3g9uwbuTAMZBHpS3IgbBziNbKwjkdphEDvzHWegsL005g/F+WwOHDY7AzpotZZvGxUmHceT9CbJqBzMr/2uYRaZuXM7MMOSDz69HA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069fb075-466d-4e6c-87f1-08ddb0341b93
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 19:53:20.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJREIpuryMD+iotZdFgermTFdNPDLaxzk1YEDcwu52+biBbeVrXQCfUgpgOoABozNWw//NOd1H8dBrIWHgs86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEzNyBTYWx0ZWRfX6AiaT73Bht+i prAs91AXTjxivBMbkyEcqiJHvb5Y8O9Tku7ohCE4CL+8ClA8v7cGya6N3GQNmoMSPZWXKstfRh5 01f7LxjIdAiv4TfBa4VnwECZxJoHZq8jrCszX+gHcGaBs7jsJPj1bCmJ36K8PvPnCOPjc2wGK3c
 r/wpAeKtmAh/FyTgI1KJIE7qGU+jh+wWlNgGhA2Gt+IrH74A4ha9DcpRaASsBZRrqt9H1kWYwf6 K9niFuzqyKFsARvDjauKhH3s320tM+bRpyzCxyN9i+D5JscqUhqr6w5k1TbUbuz7ChfrOcfjSu8 bOL4RVcwa23Eqk5cSclcrdfM3yx2we4IKu4Tv8lk9UhsC1mLGVEB6i4AcUF90iuBlJbZjyjBuhL
 ePGv21h5ZjMDsr1c9iPiQsNumLfGg/e5xHe2uE3YTdUWun6nckaxEIAYdjr8ZL1S2aj8qN2O
X-Proofpoint-GUID: yV1ry_cZ4FOg6Zn9A2-mJFA538B7tHxC
X-Proofpoint-ORIG-GUID: yV1ry_cZ4FOg6Zn9A2-mJFA538B7tHxC
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=6855bc4a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=jVbCQwm9tnh1vyDj87wA:9

alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
even when the alloc_tag_cttype is not allocated because:

  1) alloc tagging is disabled because mem profiling is disabled
     (!alloc_tag_cttype)
  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
  3) alloc tagging is enabled, but failed initialization
     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))

In all cases, alloc_tag_cttype is not allocated, and therefore
alloc_tag_top_users() should not attempt to acquire the semaphore.

This leads to a crash on memory allocation failure by attempting to
acquire a non-existent semaphore:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
  Tainted: [D]=DIE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  RIP: 0010:down_read_trylock+0xaa/0x3b0
  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   codetag_trylock_module_list+0xd/0x20
   alloc_tag_top_users+0x369/0x4b0
   __show_mem+0x1cd/0x6e0
   warn_alloc+0x2b1/0x390
   __alloc_frozen_pages_noprof+0x12b9/0x21a0
   alloc_pages_mpol+0x135/0x3e0
   alloc_slab_page+0x82/0xe0
   new_slab+0x212/0x240
   ___slab_alloc+0x82a/0xe00
   </TASK>

As David Wang points out, this issue became easier to trigger after commit
780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").

Before the commit, the issue occurred only when it failed to allocate
and initialize alloc_tag_cttype or if a memory allocation fails before
alloc_tag_init() is called. After the commit, it can be easily triggered
when memory profiling is compiled but disabled at boot.

To properly determine whether alloc_tag_init() has been called and
its data structures initialized, verify that alloc_tag_cttype is a valid
pointer before acquiring the semaphore. If the variable is NULL or an error
value, it has not been properly initialized. In such a case, just skip
and do not attempt acquire the semaphore.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com
Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

v1 -> v2:

- v1 fixed the bug only when MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=n.
  
  v2 now fixes the bug even when MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y.
  I didn't expect alloc_tag_cttype to be NULL when
  mem_profiling_support is true, but as David points out (Thanks David!)
  if a memory allocation fails before alloc_tag_init(), it can be NULL.

  So instead of indirectly checking mem_profiling_support, just directly
  check if alloc_tag_cttype is allocated.

- Closes: https://lore.kernel.org/oe-lkp/202505071555.e757f1e0-lkp@intel.com
  tag was removed because it was not a crash and not relevant to this
  patch.

- Added Cc: stable because, if an allocation fails before
  alloc_tag_init(), it can be triggered even prior-780138b12381.
  I verified that the bug can be triggered in v6.12 and fixed by this
  patch.

  It should be quite difficult to trigger in practice, though.
  Maybe I'm a bit paranoid?

 lib/alloc_tag.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 66a4628185f7..d8ec4c03b7d2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -124,7 +124,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	struct codetag_bytes n;
 	unsigned int i, nr = 0;
 
-	if (can_sleep)
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return 0;
+	else if (can_sleep)
 		codetag_lock_module_list(alloc_tag_cttype, true);
 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
 		return 0;
-- 
2.43.0


