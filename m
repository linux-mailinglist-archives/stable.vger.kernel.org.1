Return-Path: <stable+bounces-158407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497EBAE6707
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249593A3E14
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A723BCE7;
	Tue, 24 Jun 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwmE3gzv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qmk3lHcL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9429ACC0
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773031; cv=fail; b=ZxxGObXDZATZDEBu+7nbKrr9dRjjOpqzHwz7Xc5PliXbbGDaqUrWYcMiDvliYnA6VuEPc36vD4NbgjGLvY4AfEhrmm+0ffUroba9ftFWHtocl23y7Ui0vxqGzFEDLLdQ5a1413+OWBO4Opg/x4QljGU22zisnIIPDBDZKrycNNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773031; c=relaxed/simple;
	bh=xGKt1zyo3dsvX68N+rsZ362ZFU/KeBBzqdr7dYPkLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdX7NaVWnZ3GaEjnmSggC/MZk7oOy6ajAY+Tnxu/0ELLOdOZ4wxTHAFCmJm8vpw/WFUIwSLj5RmONIEMFMCQT4V7aB+Xr08p5J4GOMOY1CkmPz5kdSq4KmTC34Pln4XDEHbpcg5BaDCbx/9Oa4CZ79s9KxfBtpFi1CXGrb4J2jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nwmE3gzv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qmk3lHcL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCic0t013768;
	Tue, 24 Jun 2025 13:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9TmJijqKy11lEo6JAS
	1OM8ur6zYwhx2k82jQ7W9R0X0=; b=nwmE3gzveaKNo4dBfdQ3eTy3egiIrXTMSj
	I5OyD/MkjcmtXZZJxFoDrOpDmSsWWCaA6/Y/s8yOgPAy204lPTSW8FOBX2+28Zkg
	qZkBl6VcbdALRjAacSxy4qK3x/XTFvveBdsvDj6KZAp9yrSmVzYBKPm0a7T8Dmoi
	LE+TXCDwsmqDXbQ9cGbqA/kw8OmJQ8C4j0Ig82U3LRLl+QQctqAIS8aICm3srer5
	blIMRaktvGIv46f/yzNEa8j0t7h0SiIfAEBav+b69K1SqMzoXUlTUbN+qx2cMrui
	iIjf0NOZtUJf2LjoDlfog6IBYW81CgJA9S7xGHEGY7PFVvo32WcQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumm4ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:50:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OClSxD031310;
	Tue, 24 Jun 2025 13:50:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpq5qwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+4lNOI7jrRHF1Z7G52msvyVZOc33CZf3kG+sZgpyiUc27r+nFfk4tTZDsFL/D8MVDW1yTDSnHcvcXlYpSh8d3S9Ch5ecg7cGhtd0DtxMQdrqCcrYvH1u6mhC3BKNut9DI6ekPuY45bG/hb3Tge5u7zFeQnYr0yS7U7Jc1VJCn1jWdwG3Nc/F6NBl1TYd3H0VNH+bnIRi3MSiJu5snh6bQFqKOWicnthEXC/UQ3RjR11Uzh++Py0jp+PTR1GJyxc3Sl87yDaS6e/ItB1f1MJOS79Gn/Yc1x37CyN2KFV30QAJOBuH0HHyHf/ktsoUUS192hlABWnRhZlHtjdzq7tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TmJijqKy11lEo6JAS1OM8ur6zYwhx2k82jQ7W9R0X0=;
 b=mckhXeCJk8E1sH2Gt4/OKJlS7hpmj+R7z2AIRDDkH1hy+UfpLa0jBk62nGJJauTegWzV9e9XBJni9qRaShXZAv43W0CSUtuBD4JqO1THmpi9PKx70QEUTrsauhU94tM11Mi2LZA/Sq0WWqYz6hOxPu6kzaZZuK9J2zSZ6rFxcc4Su7pihC6u2g/emKBi+dvAGAq+PO8rjovvaX9LYyFA+7AE1LJXoCMHXzG0LPYrOhxW/MRuo6rvlcbr0/L1+pyay9p/7JyoVxcBrZ3gNuWFaNWKAIR7lgYP56AUeLsZaQvZocS1vquv+fxqchKqcLcpsSLB2feSigcecfQFvwxYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TmJijqKy11lEo6JAS1OM8ur6zYwhx2k82jQ7W9R0X0=;
 b=Qmk3lHcLbFuLkNJ8BQ0jDu18/Cl9vbSHRBb0Vl820+i81/wI8w4eh/EZpenUPOSIlLUo+UIeFH/PqUB72l3hyKvpSUU0P291qRZ5NykWN9FUc90I9YzcBjpS7ZuLFqngpzRyfa/snfYKHB1a9mEqLnD7yZMbIJNm0FTKRLBXVio=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 24 Jun
 2025 13:50:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 13:50:07 +0000
Date: Tue, 24 Jun 2025 22:50:02 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev,
        oliver.sang@intel.com, cachen@purestorage.com, linux-mm@kvack.org,
        oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in
 alloc_tag_top_users()
Message-ID: <aFqtCoz1t359Kjp1@hyeyoo>
References: <20250624072513.84219-1-harry.yoo@oracle.com>
 <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
X-ClientProxiedBy: SE2P216CA0207.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 295f16a1-c6c7-415d-062e-08ddb3260793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RCEJztCxKqPLS5Ydc4R9Md2tdFFMyZbAnkbOx3be3JmA1AeXDEnJ671P+dvN?=
 =?us-ascii?Q?pVLrErxHp5hYSTOKtb6znMv1GlvsCUatU9QNyj2M9DchQtbkXwcfdV6HYI1i?=
 =?us-ascii?Q?YxbS4AujuQOnX3EMadv6bjP/zqXx0kIYTtUQxFenHe0WGSQ0369AR1hXzehg?=
 =?us-ascii?Q?eFtUFnsSIgI5unobmRKuoac7r4b4U2pu/PbeTM2jdv7sQxBqp7NOwKnIKfPa?=
 =?us-ascii?Q?pRebb36/4LqQAKwqR453QZpWaqg19iT0UAvhZT3TLoRGYHakJeMXZ4Jkv+pf?=
 =?us-ascii?Q?sNpTZdoJUuslHvnQEjH+mz72RywoewfxNEBIKjBWvDmy+z+6XbU45qu8fi73?=
 =?us-ascii?Q?BIh08Zqeg/ENSCr0jGKYF3NiE14ad8yhbTBj02QxPfP+8J+IHteIZj9qDo7K?=
 =?us-ascii?Q?2McY9/8OLnB+Xah1AMQCqKnQv8Vu5Hc4IX4xMEpKI5ZpLGCjYlsJIz0cSHOp?=
 =?us-ascii?Q?CDr22y0/ZH5d7p6Dz9NZY1kjdpFSWqgnBfniYUPyI626kqU0iLMj1oeSJrmx?=
 =?us-ascii?Q?mWYrsieXAgBsN5Q9Zednskg2pzV1gQoxuoRjAy3X48jTmO7pWpbXS1OSUny5?=
 =?us-ascii?Q?vzRVb3y7VpndLnNVqc0rp9uCCFN6M0GXCifSUTiMONZu0JUJR5qM+62sGe7/?=
 =?us-ascii?Q?OCGrk8G8MmkEI2JOnXrTpq9Izr33uJ7wsHSs4uuwEqcIuA182IlVmqkIZI41?=
 =?us-ascii?Q?KWLTIPYeyxUCLq7wlmVaG8xZ2MYl8mPsOof9aSDhpDJQdBRRBk7sD2uu1hVF?=
 =?us-ascii?Q?slPr6Pghk8yb/Dp4gZK9bb1Ouvg58dh/ofZS1a9WQREKxn59dP+lIE6NfyQS?=
 =?us-ascii?Q?fIMYThaI8fDKBwFN3LfoOOM6tuUHzITTL1FK/kXUMn5Yj/tCsy8VeGnzpw8e?=
 =?us-ascii?Q?lGEBPTGgxpTr9+/bpCs+wdL0jbzRLn0apy5k5l8ldgWfflzCq7jylqQlphtn?=
 =?us-ascii?Q?ZXX/u9C+umNqRdUdjyXyFzw9BeJ/M//yuQ/BM37Pg2QsCZr194lKVD0C7SFD?=
 =?us-ascii?Q?Q+7AdWheuyJXVvwjeQaKOAuMx/dzvROvdg0aDhiiK/tcWb1R2ZWe7KYSVdp1?=
 =?us-ascii?Q?mV2trvcwRBVRWm4XLk3sajLH+C8qEv3oi9+Bp2f/A/fC+SsF91UvqzpZfi2q?=
 =?us-ascii?Q?jbqKN9aD3AYKWYyFsU19qBPrJpPmzUtOeVGS95fWCAKa7EkcNIOWyx/HAmea?=
 =?us-ascii?Q?DGVDBfchaZc2J26fvzyLFMvA71AumuG0p5PqtoNimO9e3yj4yKq9zZc9Oe70?=
 =?us-ascii?Q?oZEsZ8TQLgG9h2FaDKlu7L/vj/E2mnXDeSJlvmXxhM6nHpfwHS6H/MOr1oOF?=
 =?us-ascii?Q?+ebSWbpeGeKPnYY6O2SpjqmnPsKoO3qU3YWdgjy6RJ3yYPVl4rPydPQ2NycO?=
 =?us-ascii?Q?gPvlmWGrfyhQfu9a8MjkqPTBsj2JYsTFrBockvXdvFQgIKEykIhP3FrfhzxQ?=
 =?us-ascii?Q?LMQ4PS+NNz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yq2dPLNGglGFw9wH8sJbPcFPnGO2cnY6JntgngK6AaLiZ3OFuYs5EdYO8tD1?=
 =?us-ascii?Q?UEhWSygpyEnE3TzT5NoRgflcXJQ/jsn8R3HsvUwNtPb9XPH6T4UXwHfn9+DV?=
 =?us-ascii?Q?JT8ImFuF/EQ4Eew3kfnd0lTAF+S5bf9YSZA3QWQWVPYmCebemxi/fqUo0XT7?=
 =?us-ascii?Q?vG/b5qWf9A0WhDNtCAkgwb60/w2x1yOoJIEkK3M+jyN9I/Cj4WiObmyhHEk/?=
 =?us-ascii?Q?FpxMBKr2gFk8l6+6wi4D3RPROSUjpUSsVG8wTzZoiLOdztW2yuZ/gHWXXodv?=
 =?us-ascii?Q?al2JOOdiNGR9CgG3K+LeULw+hHBiLS3L9IiQbSI3of+y4IO1Rk4mOJT/OHfk?=
 =?us-ascii?Q?OQWxkcXtUj9AadH5eqbVuCH0s9jOf156Xxj04gYOf8Au9L4A7g0PJFz1V5S7?=
 =?us-ascii?Q?x47aZ89QsIUYeNRR63zS1r4OIo6LHsOVxxmnKXgN4P7gNeeoHYgigGHdCLmK?=
 =?us-ascii?Q?/pgmnIlDTtFboc5glgyazG2ITLxyBBv3w1tBjFZzrjH9HGjmX1eYjtQBravK?=
 =?us-ascii?Q?A3pNGHUCJBWm4mN2yO4NuFpQpm5+8bhmwbcTSby06Pnxlfx0QTOkhFvjEPX8?=
 =?us-ascii?Q?+yRxfmg8uuzw3mjHc0Li4jVArqdZ2r3fnIi9Yld21i1NSU2wicPZBGJdBxGN?=
 =?us-ascii?Q?cAyb45EP3RHxRQDhdvybUj92lFXP6Xhvq9tTUGId8tfF5y0ZfGLMo868I6A9?=
 =?us-ascii?Q?k55h1pzkNvgZBhGFD687/Ffm8j0lOAES4eAHtQFsJvf5CxszZD+jjxRaB0CH?=
 =?us-ascii?Q?2XEx4757slBPhSKDVMe+OFA1uAl0TiBke0YBJH+sUtx5rpP/smmIQUdk1GcG?=
 =?us-ascii?Q?ME5pD9OAKOMcwmW0rU+dk9tqi3NwA+AwEMWNmqVDN8200hlyIJjNiCXxjm6r?=
 =?us-ascii?Q?oehevnKSRCQBkZDHAgmMo+mS6S2Gwk3IcpircQU3C02uE7+mFtwHhA3kLM76?=
 =?us-ascii?Q?FODyj1LNBZMXPXDyxaH2pplTYBB430AHUUu7bwbrHN+0/5/k8RwmYQoPdVoR?=
 =?us-ascii?Q?vUCmzcVPiDVTqu71IbyGqncpw0EaqKeoz6fOP1Q89LP9yUR6c2FFGAcHJaAA?=
 =?us-ascii?Q?/i79ZDSeb6+aDm6R63ka5+7p8YtKfEj8Gg899bKmouNO8HOl6fVfAFs4tzRD?=
 =?us-ascii?Q?J2+fpRKoJdLFmjLniBJ2n2mW9QCJSJr/0r1r185ckKUQCOmulNYglPNY2V65?=
 =?us-ascii?Q?fSTYD4LaetpagBJlofDLgQUtFFNq/A2K+4hSERmg6A4Rbud8NZXmcpgD1Rar?=
 =?us-ascii?Q?PnhjG8aEUvAgGXF1JP0ZHn6RUh/2KqFnXj7n5EoVqFAxBQAA1UMgKsCIz1sv?=
 =?us-ascii?Q?O9fGb6EfNjpKmOgN3iUDjBhNBOTtAKT3eB3WPBoerPvKazSINMQlS/oggzm9?=
 =?us-ascii?Q?vibQzhQmBlBhSETiww/8YpFB3+XpaHC2X+oweyyBCrJJ1MRe3RCOtrOCzibE?=
 =?us-ascii?Q?9UughmfBPC6R11xngg/CrGWI1c3xMSAqcLmA9ggKLVazhoOuH051gps5EWjJ?=
 =?us-ascii?Q?vzQSFLywtgwlZLLQy0LJj51jehYyGyrCcfDkBfBXUC3zIElY/B+VkbyY6+Oi?=
 =?us-ascii?Q?GnySOZbv/3bnikQFEvCMAjDHfVTPtdslvua2d3cn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DldYTX1pQpYuDoQ2UO4JLJ8Q6XfM5Kn0tsEjAQRWus8JHJt2V0z3kjt+bnlxwNCWvdcCjVUTVNZ1/MXc1I2azlTBvsedbZFYiiRG1sNkW21SFVr5EMXLYRJE7dG3O5YnUX1TBip4XLnm3yyasJM86E554uBizsVHvoP/ORlZvjAtHAZbqSYdQQ7qGJgwgB6LOJt5dm+U/R48xccPeSOOvqzHeSXGKchZlnnUHBjEunzpYeFbsKDUQHFpYIM4jXTNJ9AHfhVyNpxemOuprwCVeoUar3m5sNcM3W23V5qbekr2k38rgstqtP1vmmadxE5+z9Ecstr/7bp5T1pjRFI6kq/FCVzB9pHhWBCxBfFPxaSZtx9QXtRNa/DyIegXaJzaRiMn0WK6H8g5+0wErr+tatDqfDf6BOQQNgT/DEGBeYzylp2hCnr8UMFxunzly/teVHJtmCiZw2c9fknlRKGjqbBqgdVZb8adsw7yDoeAlGvTg0tkd9qwpD/x3TNnNDSNlHqJhTvqQnU1b4am2/huY/IDOK+ind1iTFVXX/D7JqVR6ll9ofuDB1X+416oHW6cQ8Gr/947ZK2yVFbsxjOAzTqs+aYjWi3B/WCYM3QcNwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295f16a1-c6c7-415d-062e-08ddb3260793
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:50:07.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ot0jn9geqKwFLqWlL7ZS1oVN7oabVYZ932pKWEZz+VIqtZ/unI+uWv9PPkJKJ3yQpZ0T7squTMKkB8c8XwGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240116
X-Proofpoint-ORIG-GUID: 1zZvFwj6AV4_e5hmC8LJ2Ri3xjeTfw3A
X-Proofpoint-GUID: 1zZvFwj6AV4_e5hmC8LJ2Ri3xjeTfw3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExNiBTYWx0ZWRfX4KEegIFt7lx3 R35WKjY4E/lXftbwzzxMqTJOcLKNR4+AAx7I1X6XM6/7MmftyzgzDqqJi9xjC3ZwOIXO58sI92C qtUgyB9g2i7GotS38QbhLBCPyPmOLGP9a9ufVcYB/MmY8fJ+uBdneExD6EfGFXEaBu2Lxz3bHMQ
 sF3VPikaN7k5hD3ij8tu81yO8/jxlK/V7zRdxoUe6W+/tm9jPVxmGwOlUmWxzrSrIMK/03Uk51l BoqgEQTm8NTUjPqH1+MyqEH4bsj4tIeC41W5eR2dAPIb6bw/NptvQW9EbKpuxTT/tie1U4U2Esp Me0yLGK+r9n01/L1/oQ1ccK5KXk7XmlQSitOdI+a728MtAqcMCG6bXYJH2qt6ZVwRF3hXts6ImW
 PFB4CVzr5U8FS4aNRQTM4ZXTFJ702mY7lYKu+RlbYf6bLPsmT7UK9jN0NvEM2Y8cKFDgeHXm
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685aad15 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=NBNyqFcs7NNlSiqk12sA:9 a=CjuIK1q_8ugA:10

On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> 
> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >even when the alloc_tag_cttype is not allocated because:
> >
> >  1) alloc tagging is disabled because mem profiling is disabled
> >     (!alloc_tag_cttype)
> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
> >  3) alloc tagging is enabled, but failed initialization
> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >
> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >
> >This leads to a crash on memory allocation failure by attempting to
> >acquire a non-existent semaphore:
> >
> >  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
> >  Tainted: [D]=DIE
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
> >  Call Trace:
> >   <TASK>
> >   codetag_trylock_module_list+0xd/0x20
> >   alloc_tag_top_users+0x369/0x4b0
> >   __show_mem+0x1cd/0x6e0
> >   warn_alloc+0x2b1/0x390
> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >   alloc_pages_mpol+0x135/0x3e0
> >   alloc_slab_page+0x82/0xe0
> >   new_slab+0x212/0x240
> >   ___slab_alloc+0x82a/0xe00
> >   </TASK>
> >
> >As David Wang points out, this issue became easier to trigger after commit
> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").
> >
> >Before the commit, the issue occurred only when it failed to allocate
> >and initialize alloc_tag_cttype or if a memory allocation fails before
> >alloc_tag_init() is called. After the commit, it can be easily triggered
> >when memory profiling is compiled but disabled at boot.
> >
> >To properly determine whether alloc_tag_init() has been called and
> >its data structures initialized, verify that alloc_tag_cttype is a valid
> >pointer before acquiring the semaphore. If the variable is NULL or an error
> >value, it has not been properly initialized. In such a case, just skip
> >and do not attempt to acquire the semaphore.
> >
> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$ 
> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$ 
> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
> >Cc: stable@vger.kernel.org
> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >---
> >
> >@Suren: I did not add another pr_warn() because every error path in
> >alloc_tag_init() already has pr_err().
> >
> >v2 -> v3:
> >- Added another Closes: tag (David)
> >- Moved the condition into a standalone if block for better readability
> >  (Suren)
> >- Typo fix (Suren)
> >
> > lib/alloc_tag.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >index 41ccfb035b7b..e9b33848700a 100644
> >--- a/lib/alloc_tag.c
> >+++ b/lib/alloc_tag.c
> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
> > 	struct codetag_bytes n;
> > 	unsigned int i, nr = 0;
> > 
> >+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >+		return 0;
> 
> What about mem_profiling_support set to 0 after alloc_tag_init, in this case:
> alloc_tag_cttype != NULL && mem_profiling_support==0
> 
> I kind of think alloc_tag_top_users should return 0 in this case....and  both mem_profiling_support and alloc_tag_cttype should be checked....

After commit 780138b12381, alloc_tag_cttype is not allocated if
!mem_profiling_support. (And that's  why this bug showed up)

> >+
> > 	if (can_sleep)
> > 		codetag_lock_module_list(alloc_tag_cttype, true);
> > 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
> >-- 
> >2.43.0

-- 
Cheers,
Harry / Hyeonggon

