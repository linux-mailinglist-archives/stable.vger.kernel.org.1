Return-Path: <stable+bounces-89088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67089B3432
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA171C21DCC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57C013D539;
	Mon, 28 Oct 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVxy0PF8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h23KwQf9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68061DE2CC
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127665; cv=fail; b=Tqwa9p5i7yuMfrNPCmNV4J9Jg4xodl4ZsUK0jZ3EXm6GDs/cMj1l+SgEwVHUKN01paHX8HpGmHyrskiuOaCvcNw/7D18M+Lt1CJ6TG4rfI9V+3SAMNWY05vPGJLDjBknvQY8OF5i32hfCddpIubc4zWmVKZAI+VrCW9wVvb38iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127665; c=relaxed/simple;
	bh=+AVvqu7V9k5cMj+wrt+Fj+/9gi4UbESLe6YEzyVttlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tATjPbJn+Pmh7EgIhjj7d56F8TghgCq1O5YMpqKr5ShOojzdRdBHxItK1FcPVvblLcuH/QhLSFIqXUgtKYNjLQU61b3z9Nkho4e8U5iTQB9vJFXGoNuWWEeJp/+/fae7sOn/7Fw8mG3l27kVhPqzE34D4ijfOu1OHWzMVkNWBGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mVxy0PF8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h23KwQf9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SEtd9Z029653;
	Mon, 28 Oct 2024 15:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=m/ki6ytM4Sfb2Rm6hc
	PftKnZk21QCMm7+O7h1sSAE9U=; b=mVxy0PF8/cqM7DNE1cpE06mTp1kSI2g+88
	uCX5WZfcRgzUoWJVWjCsRLoiJAnopDcVmHdXiwR5FbNKojPAXIqCNi1iiM6YaqF8
	Ih1thDAnPBD4wvmEWKD79LpqbTYvq6PRrswYWhD/Nnrii0QpeZmPLdPoHcxML/9i
	nuXq2L3/DMs9pORJ+LZPgss2cmOyiR8IK/lorTfyGKQeLCxYYImiMzwcQ2LP/Pa4
	mjLxrqpQpQdcpwfgQ9x81XiGv8Szyyz/q6FPub8E4ioKZM3FwaLLoJCYrW6X5m8r
	HMmW1NjqYd9ox9JMKlbLtkoBeKPETmOIF3cPgOJihCHemQkNVTeg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1u31f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:00:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SDbYBw034856;
	Mon, 28 Oct 2024 15:00:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd60vxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 15:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydTpq+2cIdANfBd8NUP+z4tlI1OVfajxV0vXX5n2jmiJhK3DNNbJsrXLuL8BzRExirHKlaNZw6Z4ehCx+u3oaQJ/dgWsbdL9zaaopmBnFm6FabElvZ3e7gkJiSB2H7l7j4a7G6HZ+LDmrdZalqcjom5hOF02bKNJ2t9qbMoY/FuNgLTwZD50Jghuizzm1mAEfABVr9T6cRdSsA6hJF9gKhVCkMCZariM6QATdGMckmApcebTp0NqgDjWlFpRUevKjA5k/0kbnVe3P9xfejT911dYWQ9/RWPsU18yLqitg2mPPdS7TVlYLTIW5aITQEsLEeAW42U35Ce4qH63FzTGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/ki6ytM4Sfb2Rm6hcPftKnZk21QCMm7+O7h1sSAE9U=;
 b=DT45qNuu1ahDAE9FoLhJ/wB1y5FrW6HTJrhbwNm/X8j9LLZIkZfCuWQKqkRoaazQDlN9VKjOv+jylwnkjJeWYwrQLCxpj7ags8ymvvFKKlL2uZSj1NC0HmBJEaleTfS5O6+LrU8tXW4zAT5h6N0Ntd+c4IdbnEDUr046dBq4DVg4QV0tqGbxolKdrTR9KknX8eWzoZ1FxrAIa1+t2QFBbljdMtkcl1rvymwTP+kSSGWP2MKBkjGPBCUkuJRSgrt2IIPMlNtmpGM1DEOQbQA+o9mw6zl1+uspy5HuiOAoVJzjzj4MJbQvWV70ph2BVFlIM/3klJ/MWD9LqR4k4CJjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/ki6ytM4Sfb2Rm6hcPftKnZk21QCMm7+O7h1sSAE9U=;
 b=h23KwQf96GkD2pGDuY3U3MWGBKPpyOsUAIJXQUE8RoPxHCnguz3yjcCxRGSsA6HuJsyPhPKo2S634IoviiSKY4/1QBYi0ZcNAQQkjsg4RKxrI5N3MsJ+Od9lEgoNKtgf0wb6vbktmAMV83MYEe7wH0NK2O0Ztr/q97xG9UUqrXA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 15:00:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:00:45 +0000
Date: Mon, 28 Oct 2024 11:00:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com,
        linux-mm@kvack.org, Jann Horn <jannh@google.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on failure
Message-ID: <z54jwszrhsjewssvswsmucnbjgzyzygvzlmnkiniwxct6akcfw@nwc2kwht2ofq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, linux-mm@kvack.org, Jann Horn <jannh@google.com>, 
	stable@vger.kernel.org
References: <20241027123321.19511-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027123321.19511-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0299.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc0007c-7ee2-4189-6f98-08dcf7614ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPlca3dnB6ftr8ri3UuOUDYfNF8gmdz5wN82xDeWVoLrKfr9/duRlOidmuB4?=
 =?us-ascii?Q?hvaT0Fi6gJEylx8HLz+R1WlfBUc4bXsKqUnpPWXSaTYKZX6lhV6L5jaf40bS?=
 =?us-ascii?Q?XXl8CJfCM80Y3FK4DEyGwOQJHOxwQ64wWWojDfmx6ixpxWol/zcKYNPL5G4T?=
 =?us-ascii?Q?BHIDlKk3mGsxA2FUnRy7soA4cHpj6Xles/RU1jgl7CyREv4NTLbhXePT0uTH?=
 =?us-ascii?Q?D5jFPTZyJWhmS44qNzA9MMEwiuBndOfh1NGUHfc/q5aRBg/+ju76T8S8Hy6/?=
 =?us-ascii?Q?E7mwGQnU/ji5X33IrQvN7yG+7tbfsgsKPJRcM+kEvTf5qB5vLCCA60jWo8s5?=
 =?us-ascii?Q?hjD8sK4A8wSLpBu5q14bKs8YCoWt8uuQ9dgTq+iB14wVSoSOPzadp8UX9WyT?=
 =?us-ascii?Q?Xz9yGNAfRsVriLev9eqpuvZ4Ggf+VRj0oRBk+rEl8//qbEykmbpYylbM4IWz?=
 =?us-ascii?Q?glqFIPwNXh4iRL0s4Z2kAJFOq211ugH62XEq+wqdSeuzDApFpJOQxFbgRJHY?=
 =?us-ascii?Q?lVKyv54+p8BAfuzwU8zFRIp07ZFD300SDk+dff5amDilN0qgsqtWIor/ykGU?=
 =?us-ascii?Q?rG7lOJcIJZESgkx6S5JcSIWhhtXdwxl7hkza5FNFJoCqHxyjVkwUg75QFHKA?=
 =?us-ascii?Q?qWQECLnQHklnZ6P/4X6aOh4qIha8czOg8F9ZzXxk+vCHcEMcikK/P45jYNXW?=
 =?us-ascii?Q?0M5OKSANPn1zp+DKPN46TlwYddnRpBNe5Bm1of/6ue6RZ2vSgdP/rQkPsyir?=
 =?us-ascii?Q?MSFwvLiueW1vth7JUzOcRa2xY+1fCbamBQ1ZCWPHAmQheUQwKMjOimpbdaPv?=
 =?us-ascii?Q?QTMCTy1+G9no/4/PpfkBWwVDSqxXvZLY4Eexn0V6U7Y82pPW4LZxskjSfFkN?=
 =?us-ascii?Q?VMSBwjkQCgjtcVNiRdrJWig8VlgUYCyjdoMHodTmG/MNrbdvAWxjIqQO5kyF?=
 =?us-ascii?Q?cVToeTyeF2MMvXxFpy/MFypIyudSrgbf836fp7eXlixrOzun/vbxQaU7yHZm?=
 =?us-ascii?Q?EVjR+JOZWUhNJ8OMPOeGLCeVhIOSKhCwdB7LRyAuHBADitx9aguumZ/edazc?=
 =?us-ascii?Q?fgvwqplW5YZfc7om0w8qNtMv/7WFOT7LR0zLOlPyBHfok9BkVnlcdwLrPbSW?=
 =?us-ascii?Q?Rkb6TTj24z/+X2fDLBuzBqo7q7aHELbF2fmbgVf1A/krP3ybxz28Hl6ET4ax?=
 =?us-ascii?Q?F/qfUGTnmFqNSFM1ZN0SPGVM1ZMl1L0jLUXOiPdxkbuuC2Y4JRuQU+QAXrzX?=
 =?us-ascii?Q?/frkLDqg7TC/FDwONFqnm3llCE+zpzLKA0s6MA0aFPrCWrsXF4E0z8UqYWQd?=
 =?us-ascii?Q?ntM+12jCp9SV4xSzVlFyUVI8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/wj6s3D+JPQlofQppvoKnvhOAvCQAE04qaMvFl0Og6vteY0B8TrTWYjSjRe?=
 =?us-ascii?Q?/25cZHj4ck+29yaaH1igQGQLPk6Pg7mbRa98GgEsSiPv75zQLUo2THPFAKB3?=
 =?us-ascii?Q?Pt4Pg80n1n5qXwK3yov4XrWtYZOmRW5HTgdbYn5Yw5Q++99t+eA50gqVZWZ6?=
 =?us-ascii?Q?2Np4DPtgIg2zhAmTohtbTZTfEJMpNxQMVrtM90bKdAfPc29CDD1iFrpj6P2X?=
 =?us-ascii?Q?z/bqa2SGkVpAC180zDyGpYvoSSAGy+DRrRWwPzeLjWPj2JHrEcRXIDxHdErN?=
 =?us-ascii?Q?6i9R1qMhNvHzTIT2KFMlZWrVsHMJLmyz53s25IdAY4popy/+iQ8GHoVLo43q?=
 =?us-ascii?Q?LAD9XxL0hLflXevD0Cr74neXXi8iDhBAnNzm4bvh3ADILw0Bk/m14jLdOmda?=
 =?us-ascii?Q?wUIp7zEHiSQfNWIJ6Ujl6aFxRxh+Sx8quNEOVfo/olTSJZjZDl7xzoKHEvuR?=
 =?us-ascii?Q?tfizzWfWJc7uQyobCJu5YcjlN/ti0FmDL1S4BP8FikAskMqLBXLnr3vtzqhH?=
 =?us-ascii?Q?ozsDi0pkN2G/dxhL48c+CsTDacWXXBJYiVVdlygMVautIj5GFuVdu23vJMNX?=
 =?us-ascii?Q?cBrHeUpQL46APVs5ruEyKZcFQT2Bm0svnjrmFXdrbAP+6fWb9opX2t7C1X71?=
 =?us-ascii?Q?kxooCUVcKB4J+lUusLIqU9Y7s5XUDIKc9a8tCTiazwx3rPSQhHC4fivarpP6?=
 =?us-ascii?Q?VR66WlwSWAhzSrT5jBa7ICvQCRKiQbnSteSHhAjgm2cAce7//w6PD+bEEYDu?=
 =?us-ascii?Q?hbLHdC9ukiZGDORm4au7N1cshIvK9F/BqkgCKbhjGqEheTG66REcACfeg9vM?=
 =?us-ascii?Q?D3H0RDijMmyeBfMWQn0SgH1b3QJBiY7n0S7SHD1QcPSoar8VbS+9ukBQJd1o?=
 =?us-ascii?Q?Y/kWbrcRxHaYoOxLQ50P7VSFZOzMxDKN7q2l2leARkMJWEJ9v4rGX+0HLXfY?=
 =?us-ascii?Q?W4HciysZtL4LN0GjbeF/M8RMY/cOYlwG+swVIJGB7X2aMjDq4Gkc4yAhj5bJ?=
 =?us-ascii?Q?SuKElVwYvgIN4xUMAHwDQ1pH61FeB60gejQ3SrjhJOY3TaFcV8lnh+7VgADI?=
 =?us-ascii?Q?r1qGJ7OJM22XUls+rezIdtGQk5sApKkJ5DQ/6rcoMvLodY8KIKcu+p74OLtl?=
 =?us-ascii?Q?DFxh2ETweoi6CScN8W2PCEriGNWegT6ZQyRK9aDDOvQmmZZdaguJ3MO+xb67?=
 =?us-ascii?Q?/RUvZONMfvtQ5ZULZNFS6ip2yb7o5wefSkAKBgbiLJN6TSgLJpbo1bnwmJ9R?=
 =?us-ascii?Q?cgmg88bn/Mts2FkNqpSfwJG44kUymBEDjchRFy8X+66lMVPPmtI9PoMs89lB?=
 =?us-ascii?Q?xaZ4ShujvqUcu4taeSgVc42wiUc5SUXfLS4xPV+WQ2BQCtAhn4X/n39A0oQv?=
 =?us-ascii?Q?3k8ua6p0OJZQGutgL3ijdFwULkXe1APqB6CwDtLWwLpw9D8M19/7g5FKL3NP?=
 =?us-ascii?Q?nTEtFO0kvBWYiemMn64DOj8+XQ3sVbyUNZbf3fPJjaDxVL0tcJiMmhr1LFMV?=
 =?us-ascii?Q?/jco2O4qZvQBsHl8tGraifLfyonvL5e6GxT20rH9kOZpFL6zqpMBD4sHaLNR?=
 =?us-ascii?Q?cPDRRWHB8/yCTvBdp3gVFQ3OWNHau8DG2jQeQO5c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yc3fhh6WH0D6LwPkTrTBENeQagMC9qe3wX5SqBmtiYgurEvo1jt52FIePXCrZPT5rUCnibC9Te5Ij4bztjYL2sCxVCassWJNfU0BnqBKT2pgHXcuH73HrsOQLQIGnsHiXXd8I4gFUlNJWwO+drR0V2MgyACHKbSkm66w9raHfBCinD/4/TzIwC2cFvK40xlufFNl8+nBvI1CgxC6jJypXBANbXAll4kLobPK4I4vN0mV27aXDaHmK1nSF+UeHAW2xTCNUgLUal299WKDszzSXchpIcVdiL7kr5kHtj3ofg6mflhZZKwvrDYuCjBDByfTDEqYUjAT8ItnY3xG+w2zcWugg66ywe2JDZNU04E/NulnMe5tPM9SWq64fSyKcpQLZdU0MKKLt+83ptvoCBvKYd08M7pwt54LCdyJ1aP8enO9COdRjR8675W/yi1IJFnA+27Bq0had9M0cvbLGARKH9eUavl2myibZdwhNW+xFFMyiW42hmZD3J1+hD379zp9yFyYs+pmuMyYLpPiGI/9HhCB3KUk1oj3Vhf/KQNrs7d4eEFC/M+JvlSZZC90fDvymqzlNQDKfkban0msRDfle5qHXmIFAxkkAWGPXGjMd44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc0007c-7ee2-4189-6f98-08dcf7614ca1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:00:45.0814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EPWn0UrXJK1MBoSTAQqYGMdqm92M/YH8GcvHaNRlJyls8V4XvzIPzdBuvHZc4m/Pc+3y9MCcNKVRaj0UyP5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280119
X-Proofpoint-GUID: lJ0qkNOazwa6a52_EaDUPpPSy_DXlB9w
X-Proofpoint-ORIG-GUID: lJ0qkNOazwa6a52_EaDUPpPSy_DXlB9w

* Wei Yang <richard.weiyang@gmail.com> [241027 08:34]:
> After commit 94d7d9233951 ("mm: abstract the vma_merge()/split_vma()
> pattern for mprotect() et al."), if vma_modify_flags() return error, the
> vma is set to an error code. This will lead to an invalid prev be
> returned.
> 
> Generally this shouldn't matter as the caller should treat an error as
> indicating state is now invalidated, however unfortunately
> apply_mlockall_flags() does not check for errors and assumes that
> mlock_fixup() correctly maintains prev even if an error were to occur.
> 
> This patch fixes that assumption.
> 
> [lorenzo: provide a better fix and rephrase the log]
> 
> Fixes: 94d7d9233951 ("mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.")
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>
> 
> ---
> v2: 
>    rearrange the fix and change log per Lorenzo's suggestion
>    add fix tag and cc stable
> 
> ---
>  mm/mlock.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index e3e3dc2b2956..cde076fa7d5e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -725,14 +725,17 @@ static int apply_mlockall_flags(int flags)
>  	}
>  
>  	for_each_vma(vmi, vma) {
> +		int error;
>  		vm_flags_t newflags;
>  
>  		newflags = vma->vm_flags & ~VM_LOCKED_MASK;
>  		newflags |= to_add;
>  
> -		/* Ignore errors */
> -		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
> -			    newflags);
> +		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
> +				    newflags);
> +		/* Ignore errors, but prev needs fixing up. */
> +		if (error)
> +			prev = vma;

I don't think we need a local variable for the error since it's not used
for anything besides ensuring there was a non-zero return here, but it
probably doesn't make a difference.  I'd have to check the assembly to
be sure.

Either way,

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

>  		cond_resched();
>  	}
>  out:
> -- 
> 2.34.1
> 

