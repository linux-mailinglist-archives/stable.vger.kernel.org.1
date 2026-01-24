Return-Path: <stable+bounces-211453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDO7GiOjdGnz8AAAu9opvQ
	(envelope-from <stable+bounces-211453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:46:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809457D497
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EE0C3009B0A
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD8136672;
	Sat, 24 Jan 2026 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pvnCq5mn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DFKis0d6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954C18B0F
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251616; cv=fail; b=tYhZi/ML1TMTKqfaJufypYzRoNDINfBmvw4GtCaDVWM93HaZWm4CAfjkHBWZAPRUm6j9ZPuQqsXtvuDqODrpIYn1t5IgqG3vChy9fSEtJJ+LUw1mWdVUhKuBUOAxFg7GeAAhVirsT54nzfDKeEWfyu5z6aWZAe26t8qlvDQzhb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251616; c=relaxed/simple;
	bh=OegC+QoGZGLX7qlGiRlFlXjcTsZVo+lqIKPntREHIi0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lW9y5bsxvcTYbnMZGm88p+xOzlavAHfi/w4lTdWR2ywytD3wOLXqBGPaX6t7bUa7iXd/MktSBuF+jlPywn8lP2icA/cotaf2YwWCVYfAa8StzKt3NpqYJEeYHxpC9gFBCS2Sk2OQiKLSqAT+TAwCCr09+0/r6Va0MCjHMGmKs1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pvnCq5mn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DFKis0d6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60O9o2Cu473785;
	Sat, 24 Jan 2026 10:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=IIGQHz4cvvxYnF+Z
	5oey4yYRPdOy5yTHM0ed+T8HzCg=; b=pvnCq5mnxVDprHscwcx4/0kWRtKQE4f4
	dzhAhw9DlKGKDfpkiY1HSVgm5+mxh/htwSEulTDm3ayUusDOgqMmrDkRIEidoRYW
	t25P12bC+nqA1pSdGjvzOhs+Y85l8oHj5INjSdF7A1EZc2euv5GaF/6+5FsqatjC
	Cjt90ZGWBEyrNsFG9RTqLZ9KkTozMFvLkmQ3WybvU7sDW9gJZVBIZL/HBqiTwVJR
	3UzNNZ9JTtCpaa37+a9PIKZ4gMuMeezAwXND1rSNpucciar93ABN5e/aSOtFHna8
	NjdstCko+JPqK6VfU50Lpzuo7qop78rINhskR9PDhJ3we7iHZL2ODQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny06pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 10:46:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60O8IvnU009991;
	Sat, 24 Jan 2026 10:46:28 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh6bk0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 10:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF7aYo3u+NZyow7jm2rkrWl5adFR33G/QIQ8DHzEcRQUeDniipc6vXTR0hcrvzzpzC4F0YblK1P5PvoG/9aBTKcl5Y+fkjEdE8oJ2dqL1xXpUbiy3tT8YL6JWtyLZVPlmFyc0PI9Gg1ouVuXvVIu4nFtEYAr6vXnBeZkv0ziNHaNCqxvuTdRUQaZjCDMkYn6V7pG2vT+w10ClYCoMTvTTExjVf2QBGpkdzsdznwoIAr1cxJmNTQZ+meIiZTY8Vg83aTlU9T2/OenCqPl0I4fl5yLnoMc8p9pf7t+nIch0uKrZpNzAMRauIW05EcWWahG6kzOiNS4aY9Q1Onqk9tc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIGQHz4cvvxYnF+Z5oey4yYRPdOy5yTHM0ed+T8HzCg=;
 b=pHUSq9jfiCXVgHMK/xgI1KZFyeyH5v2ng732fDXgDLLbla8vT57yuD2mspaPZ73PmBlv6eV2EbIqrQ8KpUNC8mPcGSnJYzOkImZugaMf4Hd/8/FZtfrKvtYLEZ2kqY+1+3lbVh8/xNeWJYfcEem6LxJfvWuYW8DjdlczJpcgYXmp0Lmwv3MQfdHW42L9pHkmynrp8seG4WRReXeeLd7oaJgQKMoGZKh8lHkvPuze4KrUfaxu0NnBA4JP+96YScRaYjqUkkrREOm1Bcvqrc0hfFRdc2u0ztAoEWnvB9qOhzvzHDdKBI19FMhjjgQLa8V+g9wEYIyIjSQ3bO0lE/NoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIGQHz4cvvxYnF+Z5oey4yYRPdOy5yTHM0ed+T8HzCg=;
 b=DFKis0d6iaEaxrzmQ78z3QBLTy88fskyhMxhjnJsXHTt46iKK0ff6gx3u6SJ4h3+cad9aJXZduNPbbcoVFxNevushMisF2jM2oy2TLqJRlCiiteJ4bWldjp7LIMC8fFX3GvFxZtowF0y13sm09AdaAxT24lYr4uRtesdV/WNYYY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7331.namprd10.prod.outlook.com (2603:10b6:610:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 10:46:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 10:46:20 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: linux-mm@kvack.org, cl@gentwo.org, rientjes@google.com, surenb@google.com,
        harry.yoo@oracle.com, hao.li@linux.dev,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own slab
Date: Sat, 24 Jan 2026 19:46:14 +0900
Message-ID: <20260124104614.9739-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0183.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbb762e-1bcd-4ca9-a01c-08de5b35cf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToUhb5PO5nFVCZqxCoSAg7ZDQecF3R5N96I6Q258FongKp92vX13IFSi48TW?=
 =?us-ascii?Q?K0y5UMtXssASkH7se+ZQ1XemqLwFQzEmtvRuv0P63umUPws8QNeJ2DbKcqPX?=
 =?us-ascii?Q?nOPPaVrXOTJtpRApGDoz20RLOtL8IKad8PaQmpEDSohK9a+KGks3R6mwZR9T?=
 =?us-ascii?Q?pLS2QUi0eku6oPbybwgpwFhOQM1a5469ocUItI07b145q4nhXLj288GeVyHb?=
 =?us-ascii?Q?DP+YNi7IjDW4dm6ZYy4RiNKr5eXeoa48dtnmKAQbt+i/Do2s/I3W/7MgAoBN?=
 =?us-ascii?Q?OFg78S3CPm5m07Z4IwxcdsjYzLBnU9/hU2T139KzN70D0k+sL1svQg1VBBqv?=
 =?us-ascii?Q?3Tsv4nhT29QEtm4eZ9Q7YHCeMoTqzBmw7SPTnSX/ql0muG8pmdwVX+GR6kb5?=
 =?us-ascii?Q?DWxz+CsetbSVK3wsjycLClvJG7RUDJGH7jNXK9pGXqUR9stZehZ7sXayH+E5?=
 =?us-ascii?Q?xDMsDtNTSFybvbuggFYahxkSDljrR/jc1+Ll+K4hzijuUJRIvp8DhYpgPer7?=
 =?us-ascii?Q?klGQkcA27kq7t+HjeRIbE+lBi07crDd7rdbMU72D3RiwkgzmJBCf9Dr4QUlf?=
 =?us-ascii?Q?GVZ/0YNOI/QJlQOnMpzAyWo3FzrzdL4wYVQwyW5UflaA5wl9kXkQ952ZfQx7?=
 =?us-ascii?Q?0IjFU22rprcleBDSzTcHXEIH8sXbEbafwg0K1yIoTryR+aWQR1t3pKgUEaMB?=
 =?us-ascii?Q?H4KpERvuhRrKP6Y0/0IQJCbyJiFHxqwRLCGxhsj+9U36LwKDIklfNY2PNci+?=
 =?us-ascii?Q?XA3JGhdeL1O50L1ODre3dOelb846ZFLXpq2eeReNKTlLRkxMAQc8w25OlSRV?=
 =?us-ascii?Q?1GI653+gXTdpIcfq0llN+rFs+oKKx53uu/+avJHQgLpa2cAeCknJw9qf0rZj?=
 =?us-ascii?Q?4JqPNIyJ25T20y0A/G++PhR8SeKZ81xwtT5S+wgd9QAKeWstHDQkiFIWrGHs?=
 =?us-ascii?Q?8ijcE9QKUCUwrQnNw7tChSv1TDYZslN14OLRQdi2t9U0V3YwvTSD0Mlb1Ih4?=
 =?us-ascii?Q?VBV9OahWtEl/cTe6mXlNy5UE6z+FjZxnCfHTKPXKik2fTSC5v9QVF7A8WMkW?=
 =?us-ascii?Q?ZFSN1HtgCx2LY0NxGovOTGLQRptqC3gZN/oKwxP1sk0xb6/2FcFcnr1q8yr7?=
 =?us-ascii?Q?A1/OMi+QaeXhiSrWmlQPoRQDMNNUv8EJNqC0/XjqkTiKgjXWFiSQ3ytshRzG?=
 =?us-ascii?Q?D6s/07uarIhMbW/WQCgQ3l5lcbwlqqwI+O3UYsNJMQbyZr6q8WGJRNxZqZM0?=
 =?us-ascii?Q?DgaVtz+lKkBfN7Na8x8qsJdOj4HFQxAV8QeV53DMkApMoD6SzdeLuMf4TVqC?=
 =?us-ascii?Q?02INpc7d8nuvZ7ghdh1A4gFsdRdJgZmqcB3kY1+SdtK411bJBH4ieCFAaBnm?=
 =?us-ascii?Q?0xWzLQcsp5bz8ileyggOLOTNwaYwjmDUNh5DiRrewroa9iZypyAyob9aYz4C?=
 =?us-ascii?Q?2hEyV4w9JVIS/mzHg8gOHUzmLPGccQ2g3+cGijlS2x7xFt0FHuIE/f5Yr0FO?=
 =?us-ascii?Q?eOL5u0jBVZBY+XVa7FNEg8l9f03PVHw+pSlY2BPlbFFreR1AeewLReyDMSdx?=
 =?us-ascii?Q?2UJbjwNaldTQUZnAqBB/5fvav7Uq4QVxjdmfn473?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WQE8abW1ruSVCn6KlHaXtE4XS1PDLkrjKdPYSwjqAqjXIec+UdusdO+19lGp?=
 =?us-ascii?Q?jiTIB1CeqOOZDjTUHM/CHyjDhgsJv9EO0h6MrJ6l1I+pAbYZHy2aH+pNroqB?=
 =?us-ascii?Q?tkGq/imQufYsUGemTGVoMquVipodR+kcT10Jkani/bd5r+Ew5zDUVgSMNWVO?=
 =?us-ascii?Q?GpNTN+EkZRiSIYGPvJar3Le9iRqIpoHaXIDfUJ3kiGJuKVtz3H/0Dbh5uqz/?=
 =?us-ascii?Q?Yw0/138SDkcJnXiR8nEhXUPbRbzHBwPvTkWJTorUVRsApeXZSCeAipBdAuj8?=
 =?us-ascii?Q?wgK4PB+HRibpXxTEaaCwTpZ6EUAAcnvBwyze+OW/F2TKGxQ9Id7gtT6dX1oE?=
 =?us-ascii?Q?0JCc0gZ6kRQWbLBxggR5WdIpzr15Tn8qgdFRCH+APyxKbW2F4JhFI+oW33ko?=
 =?us-ascii?Q?hLdDMRiXhhXs/mK0KAAybjiV7SS8i+IyhMURlfTTv1bQHYPaErJo+BbCNPeV?=
 =?us-ascii?Q?XcBCWDRSQzwt3aQq6fSwvsxseNekJjfXI1jlXL3oMBEH+qyDTZXXaoJXIuaM?=
 =?us-ascii?Q?bSf+QNFICmWKFilQx1nM1JLaiQSiYgxki9c6vivnp36UdBufj/DFr5o1a3QE?=
 =?us-ascii?Q?q1U894Ic429qZUh7axdiehDJlwR/ZkXn5+jZth3I5YCTo3+psuM3h6X4/byv?=
 =?us-ascii?Q?gPqWeMF6QHuMl8IgA4Wo2dhE8j8FLNsHC8109Nxt1CHcdzLiJmg+JCAA+FkH?=
 =?us-ascii?Q?X26cr/vgd9DwJMHAyXwZEFo9WHUsmMdM9iJLj+yFIDA0QlDa9x8A5nHkvklQ?=
 =?us-ascii?Q?8QWeE0yToUD1wauWdSNnf/St96lnRV5th4ElccqQQoVw4rhsBVQwelLte7zQ?=
 =?us-ascii?Q?XCswYMoBbM8e/q6RXgtzyvwDbseKwd+Pshr6DLBPHdtB5yNnyEVeQLgv90Xa?=
 =?us-ascii?Q?zSgTZuG/5baHR8IjupaRN2wG72Q3Ug9O9LAlCWEzB9GBNnGddp/KP1ZS8q8z?=
 =?us-ascii?Q?rukAdsPY0jnpYcOiGIKtdY/xuxrvmp8d4q/poyLLHItxFkK7/rPzOoe70rGp?=
 =?us-ascii?Q?5xsu9Au93cREzd/wJAFF8JE/gzMF6XLSbaULxwQcdGHjEbJW8iw6Sxbp68DG?=
 =?us-ascii?Q?qbrjQWoW7wkbBv4PXYcyBAi8y95n9rIPA2Rh2jP6jpD+O2vmFyxAWGvmZbiP?=
 =?us-ascii?Q?COdH7dngq3kTYiHCEqi+4YE4yTPFa/8jeuiRq66PQrh8/nZSNI3u6QHbQ9ls?=
 =?us-ascii?Q?HRcqI5jOEjOGE6iaoYQJHTBxH4k1qMXx/6h3ErxunafQayCHmAdkP9VpWaRS?=
 =?us-ascii?Q?hfadQ7Exso2nAOX1CyaGOKJKrPjt+CQh1L5DhOcWOHSlkwmTQP3uiZaaKceL?=
 =?us-ascii?Q?xezA5Ad2XsSvhdVaDLwd82Qmnx5ErfJQdGwB6ICq3LxTLF/lALDFMdzJLxY6?=
 =?us-ascii?Q?bk5UE3h61uYMeHM/fHKIl+EnemP+SRFRxJBmeEzibjhZxnSKZ10in2Tw7bup?=
 =?us-ascii?Q?Frzor9E94nUCR/0vMZ22Tzm7EjB7l1eIVRvtaVWxMPNiOSzRGqjXnmYN0dJm?=
 =?us-ascii?Q?a9GyV7PQ+PoQS7oy/KpTfG297fMxIChpfC83B9FsIwb/n05q7Ua11c06FohJ?=
 =?us-ascii?Q?bRemMuTHhLUyFUjbTKTp3ST5nBsz4CObhlBkstHnNc6iFiJ8ic4wxn0nwxv5?=
 =?us-ascii?Q?cy3Pnwp9Zz5GMKio+9Mmzla+pmVzb9xZ/id/plZpvT+6tdgzaNqr8wEmBlVT?=
 =?us-ascii?Q?k8/OTu3s/DPWOD0Z8SxWq+Thzkg5Bol5QR8PGw4dWYq8ekagvGp84iMcQ/k7?=
 =?us-ascii?Q?pumf3uIlgQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2+xBElwTKvEbWKjjEset7z09ni9BiJzg4iIWWbWP6yUZL5fqlJzpxCJ5jui+ZgTxO5cHrbpFQmC7Zfa7UyeFSFGkEmTOy2e+gpnydI4Q9xDcgzUhLN8dAo34anpjq0+zNW9ARK4oqLCJHJGlI5H51GlVVFaVTjYqCav9bVEu4CXVOG84/R3agjY9+9AKcBgvB0hrSovsRHdOEnorY3AvudVUXvMIGY3YoX2d2w6RuBQK/T6F0FrgsoBVZbX2X4W8rAD7xNPtMVcp1BMa4aaB90Y0coSxDOk71iEI6VuqKDPxVgizPS3EBoLFX+P85KAxAcHKN/UoqecK0q4FBT+XOLKY+NjeKcBwoOusvBPVRy3U6urXCr56+eyNI9AJeVJPTXT4idKVvWU3s4XjdFL6mv5pQCW5MAmzWuOBYTHNHqCK18ph2Fsc6wbATU25FLaka1pZkXkhRbP7a0NhzPJZmhuwZec4Rfmfr8UK3K2llwVK3tlgMqSxRfuX225duoHYwylGUMoauMfNE2ObsKpVtrU0UGc+ozMP3Di0gOztbAJ4dLHhsP/Ova5eh5kus0MiPmwf2rxh/C/BCy3Qd2a1bCIgFEAmrvel06+xs23O2uM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbb762e-1bcd-4ca9-a01c-08de5b35cf6e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 10:46:20.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXE/1pPUoMdESQnkzFtQ82BMhL9gGBuA4H9NWpfGgKRv3lxtmjKsBaspeqMfv1jfw0qAVgkeiUTPIOieD2+E5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601240085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA4NSBTYWx0ZWRfXymts1lY2PRPg
 8gcQUmFRFruty2KM+chQ6UAbyNEHdXvnOf4nH8JjzUAkSrETZklvu1+q05XMHe6r8VcoMrM028p
 q6qpMgqPJ61zovv1qw+5EGTBKitxuO2J/YgxsZeBrPvta8S9s0r23Q/4CKn53UTrueIcW+nZtoJ
 m7PG6KuNw5mbQmRc5qcfLOZWOlJI0QtBR5TWrpeA4FK8cNHdS9zNPa8EbJ9wvmG07krUlGdsPxs
 SmYYM9zeQvaCJ7LqioXmU/iG81DrmvX/cb/vluaUEpqK9Sh5kg4zgGs8AtZvzoJQ3ezOntghntQ
 kLKjpGJyMEpVxTXsFNVjJ42z+317smrjetn2YeESoX7Q8GhcOoRXN4iWaklq9HZSpt+IbQzerRm
 kQIzS1VyDKOIS1UeGNIYGNgfpMu9tsKaRdhKs1MPXWHUUesLARO1Vo59BHOs1CaEFbpAukXs/Vn
 xrWCQrg/6933rHH2yyg==
X-Proofpoint-GUID: Ktn7bgcgGfmLboufAU-17Ll7qQNt4Ipl
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6974a305 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=r9yMGVhzXb-e3HBZQ6UA:9
X-Proofpoint-ORIG-GUID: Ktn7bgcgGfmLboufAU-17Ll7qQNt4Ipl
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211453-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 809457D497
X-Rspamd-Action: no action

When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
can be allocated from the same slab we're allocating the array for.
This led to obj_exts_in_slab() incorrectly returning true [1],
although the array is not allocated from wasted space of the slab.

Vlastimil Babka observed that this problem should be fixed even when
ignoring its incompatibility with obj_exts_in_slab(), because it creates
slabs that are never freed as there is always at least one allocated
object.

To avoid this, use the next kmalloc size or large kmalloc when
kmalloc_slab() returns the same cache we're allocating the array for.

In case of random kmalloc caches, there are multiple kmalloc caches for
the same size and the cache is selected based on the caller address.
Because it is fragile to ensure the same caller address is passed to
kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), fall back
to (s->object_size + 1) when the sizes are equal.

Note that this doesn't happen when memory allocation profiling is
disabled, as when the allocation of the array is triggered by memory
cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com [1]
Cc: stable@vger.kernel.org
Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3ff1c475b0f1..43ddb96c4081 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2104,6 +2104,52 @@ static inline void init_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
+/*
+ * Calculate the allocation size for slabobj_ext array.
+ *
+ * When memory allocation profiling is enabled, the obj_exts array
+ * could be allocated from the same slab cache it's being allocated for.
+ * This would prevent the slab from ever being freed because it would
+ * always contain at least one allocated object (its own obj_exts array).
+ *
+ * To avoid this, increase the allocation size when we detect the array
+ * would come from the same cache, forcing it to use a different cache.
+ */
+static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
+					 struct slab *slab, gfp_t gfp)
+{
+	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
+	struct kmem_cache *obj_exts_cache;
+
+	/*
+	 * slabobj_ext array for KMALLOC_CGROUP allocations
+	 * are served from KMALLOC_NORMAL caches.
+	 */
+	if (!mem_alloc_profiling_enabled())
+		return sz;
+
+	if (sz > KMALLOC_MAX_CACHE_SIZE)
+		return sz;
+
+	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
+	if (s == obj_exts_cache)
+		return obj_exts_cache->object_size + 1;
+
+	/*
+	 * Random kmalloc caches have multiple caches per size, and the cache
+	 * is selected by the caller address. Since caller address may differ
+	 * between kmalloc_slab() and actual allocation, bump size when both
+	 * are normal kmalloc caches of same size.
+	 */
+	if (IS_ENABLED(CONFIG_RANDOM_KMALLOC_CACHES) &&
+			is_kmalloc_normal(s) &&
+			is_kmalloc_normal(obj_exts_cache) &&
+			(s->object_size == obj_exts_cache->object_size))
+		return obj_exts_cache->object_size + 1;
+
+	return sz;
+}
+
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		        gfp_t gfp, bool new_slab)
 {
@@ -2112,26 +2158,26 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	unsigned long new_exts;
 	unsigned long old_exts;
 	struct slabobj_ext *vec;
+	size_t sz;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
 
+	sz = obj_exts_alloc_size(s, slab, gfp);
+
 	/*
 	 * Note that allow_spin may be false during early boot and its
 	 * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only supporting
 	 * architectures with cmpxchg16b, early obj_exts will be missing for
 	 * very early allocations on those.
 	 */
-	if (unlikely(!allow_spin)) {
-		size_t sz = objects * sizeof(struct slabobj_ext);
-
+	if (unlikely(!allow_spin))
 		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
 				     slab_nid(slab));
-	} else {
-		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
-				   slab_nid(slab));
-	}
+	else
+		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
+
 	if (!vec) {
 		/*
 		 * Try to mark vectors which failed to allocate.
@@ -2145,6 +2191,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		return -ENOMEM;
 	}
 
+	VM_WARN_ON_ONCE(virt_to_slab(vec)->slab_cache == s);
+
 	new_exts = (unsigned long)vec;
 	if (unlikely(!allow_spin))
 		new_exts |= OBJEXTS_NOSPIN_ALLOC;
-- 
2.43.0


