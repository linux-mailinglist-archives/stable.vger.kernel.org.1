Return-Path: <stable+bounces-217501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHsZOM9yl2kdywIAu9opvQ
	(envelope-from <stable+bounces-217501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:30:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F13162537
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB4A63010B70
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853CA318EFB;
	Thu, 19 Feb 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ITQ4ilOe"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196B318EC6;
	Thu, 19 Feb 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533005; cv=fail; b=sqQnBWfURP7B7NP/KPRGFMARnU0nO1Nmodm4abLlLCrrYItUnYAwptaYPO/xrh57Ed2UvZvedCizlhbKALAV7wZCxU8zZeHoZ59ouu/2LUHevXg2MX36nME2fpUWW8YzFCAPBnZAOIs58CdiRa/mPy1ZxzoxdP/EHH0XJn28J3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533005; c=relaxed/simple;
	bh=vm2XWJwD3BiUhH1eJu1/0McR/0IDL/C4khLxZXz3H3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YsFvhWkU8+pvkVgEb85vOrNrDg5fKT+fJblhTjFnl/hTT+lPpxdMhBaLUmdOy4tkzM4t7ixvag4hGd/mnqenoOEdtABKAAbyq5EUeMrKRJ3zT5eVzsx6vp6rpnLqAKxyziaAVKzPb53R4mDWwJ3HgDwkJixWVav4d+ZYWKRyCvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ITQ4ilOe; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHdXGh/cbRu6NZQ7t3RgmMQztGhzPgBOr4ruRyJXN021lPz5y5GRgX4HkzbsvYX3KX98AG+vCeHI7M1Ln2r2eDdOSAOUBLk2/9ySv+9Qk4NBeztua9DYCq06kAVv6pY8NyLf2Y39M21lqhWX4WYO7VzExwiKLHc9YyEI/7bkEMm6o8A/bwahlmVRDu6XkEPZs+VqUZZOEZK1cdfTn77B/bAIRRx3BQAzg1DyFv2oi4ys1ls4Wh+HbAuo4s6tQmsByYj/dkRSy6r8UX9SirlO/KFXF9NbelUFbJ2K/gjOeeRtI8fHNQngatUhpo3XKLlkKsJ99C0EjuZAwB7rjF7O5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBxzM6QoskUMzzAywqqZZGzd7qAyH4En44omQbZ9Lwg=;
 b=d81x0Km6lVs/xjV3Q8uEBd7MxcLLmPjd6xBD2gYr9tpNoogt7olKPJC1/c/p3haZ8+ANGXH5F7DgLpqtA+aswmL7yd0Py2m/7kTe67vtbdzDmg9DV5iFk6q4gjoiXvmcaHygAhobS90lVD3XnwxDJKs2LNcTjDlyBiTKhAtiCQ5oGv+FRQFkDBn2m5mv2plqYvPe52WBRfVygoHA9FX2qkoaVwiplmgvZ9RFF6nOBAe+6HbaDxSkclFlfr14bUE8IX4RuJ33ozKDif5ctMTE7Wg+KAEfYJQ55+IIbtLop5X1CqDeg0U1CGsjLdtXgLVeq9sfhOXJ4hFgihTo80ENRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBxzM6QoskUMzzAywqqZZGzd7qAyH4En44omQbZ9Lwg=;
 b=ITQ4ilOe1UY1R2XjJjdqBDEjJqAoqHCRHVRYtTbZfUJ0bLny1QVw9e8Nl9RqSfEMil2TjnBlfJswsLBYRydCMcm6kcYTviFoX/3rgSr5QlchDTTWlxP497aiR6GngZVfsGO/QD9veV9AqyPxkpQZiMOz96Gmk3sSXPr9PKg0ak8m3mgT+HAk6nw4S78ooQJNC4x5GDM8hNgyTu8lT3MG1QH63RNXmTQ358c5Q4iCkMliQ3hP8bjoIdzwVZh5O7XHh/2Sv5f3lFSMf6WStKMFVsvBvDQtH++XlGJLZGKVnUOx2lyy054M58G0s2iEDaUGsbma9bxSGdrl8E6blKYGsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Thu, 19 Feb 2026 20:29:58 +0000
Received: from CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f]) by CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 20:29:57 +0000
From: Penghe Geng <pgeng@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Penghe Geng <pgeng@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH mmc v2] mmc: core: Avoid bitfield RMW for claim/retune flags
Date: Thu, 19 Feb 2026 15:29:54 -0500
Message-ID: <20260219202954.937508-1-pgeng@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115214648.168365-1-pgeng@nvidia.com>
References: <20260115214648.168365-1-pgeng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To CY3PR12MB9630.namprd12.prod.outlook.com
 (2603:10b6:930:101::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9630:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: b00d22a7-2d30-4f69-cdc5-08de6ff5a59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpW9pPEAIR3lgb+tCEr8guG0ci0ADYQZTLQBPbyYApXrDrOQdpBXPHtVF4+k?=
 =?us-ascii?Q?CpWo9PRw6ZE/Ror5RbhrdXsVQx3Y7gTRDV0iTxJKIE9/jhidSVjyJ3sh6RgK?=
 =?us-ascii?Q?e1ahXI9pOfz+u/UqRiyp1NcGeV7/64SpmPKpBzX77qLWDm/aO9ok6R4DAzqL?=
 =?us-ascii?Q?r+WHLgSF7ySQ5IQmYTHMLNKuLe6KTcpDCOF8R6kgkdHlGZsMzdk7YYQCB9s5?=
 =?us-ascii?Q?uPIEAuvGnmQcOgrXJbBUgwqZwk4WX/aynWrxCQEWzP/sRk3aS84KX09pNtrR?=
 =?us-ascii?Q?H5vuOGDI+fsXn4Uu5XhNGj4IJjXdI0X5MUyUtoDV3QKJSS52Ivv5qijMDAQM?=
 =?us-ascii?Q?3weW/NXU3aSyv8SbBe6ibUx14kmRg2RTlep4XFWcnCUX8GQYPvr4063DT43F?=
 =?us-ascii?Q?VovIL5mY1kk7Rg62CuJG+82aX8WFWc7tX75iafglYnvSUQBUuYQ5n8l3GMOG?=
 =?us-ascii?Q?0RV/XY4I9vrNPQhB0Z5ysPQ12yrfJFqEbTXFkAq3DiJM8WLk8GILcFxf8fz0?=
 =?us-ascii?Q?wmxhm8tB4AxYP7B+Y5+xrXXrPqmQeAI/qK5Y4bu/1ehNTRzlXRHhY3br57+d?=
 =?us-ascii?Q?+RuOD6gVjwNeuKVZy2t2hgLJN7+dUdLTV9j6gqv/Koj747HgGtozoTIybPOS?=
 =?us-ascii?Q?D/zZL0rKrUWsPYxBaiEBdVrDr9RXhOqieEM/LJOARKtTooVY1kZAOrvAvSDQ?=
 =?us-ascii?Q?fwx/UxlWal+WwZWNBw2ePcq5zTEW/uTRDIZFoO+dZvfGiKZosMl3nR4y32ph?=
 =?us-ascii?Q?YGgQxZYk+TqrkFb0YWWbuR3BsFHaiiaqsE4yEOiYJMBlZZ1QM7TFfEzWsVtT?=
 =?us-ascii?Q?dQx6eaqJYwXilGDYBfy2F78QQQFRU8/TNGe2u8/91eSWkMfTtAnGmhv6BJqt?=
 =?us-ascii?Q?8ApSc6JQsJY0LfRYdS3a7GD/IP/7o7SZJyPHF85pSZFKJej5Jhad149K+agn?=
 =?us-ascii?Q?KnKuhyERtKlxPNmd9DGp5wvkNDSAmCUBUptD7K2h/uFMhSR4Ue7+UVjIJmlD?=
 =?us-ascii?Q?yUgEPC1MlqZfrr782LZZ1+Oa0/ag5YbToYoYYfxuZtt94bEQHMa6d9UxUFpO?=
 =?us-ascii?Q?phbCefqzzSxK8psBkKpCHI7eyVo+fqexa4zlFxPLAXYOFKzt+atX7LATVFKc?=
 =?us-ascii?Q?6c+kltV+hzuA9Pych3r072n5G/pZJcZmIHDxKgxgMz4X+XwhVSrNKeHjS2B6?=
 =?us-ascii?Q?jsQvboqoTHrI9dMvPjbpqI0QrGaj+GNU0hE2D/HL81EpDLIZ9wNljCnKRfRC?=
 =?us-ascii?Q?kkZnRh4kP/3CdfE8YYpEYb+49sLNSvnJdX0Pv04Upo6Rn0V7OhOVnFFkA1Z/?=
 =?us-ascii?Q?pwk2tqV+Jd9PSuWZE31IvcNT4ymcBVMArV7kLpWW6yD6pWZ27MbFrcouaayE?=
 =?us-ascii?Q?WSfePqQ92JqPWc5sc6ivdCTDNVntJn2lXpkUcz6g1Hm08sPGPqelcxCLMn5a?=
 =?us-ascii?Q?9QMIdehm1KytAS+bmOoNNmpqwUQr0lY8i+iFFedSgYORa/nvLIQLklZXAGfZ?=
 =?us-ascii?Q?dv+xcwHmzkQookActKTVJ9pORkKpdsj3MzNGnT4CHrU8SMJ9gAMN3c0hm5Dn?=
 =?us-ascii?Q?43LQa4Cj2gHAfY5kJLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9630.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0iPzcjIwSO18117Fp05IwUpJJJp7pST9yskENrnplvHRI/ck1L68HkRPWM1?=
 =?us-ascii?Q?BzPsOYzTonKP3PvdNfLIbjkUq5ZZoT7srgws3kh4+xN/laTWUg8U8XB3oM/x?=
 =?us-ascii?Q?GHz3ftmxntBToEDcajDDkM3N2Tvx1m8XaT1HdGhFaZtckNbBk0IlkQpCZYEn?=
 =?us-ascii?Q?n2nA9DSPKp+AediM7ivE57S1KvRlKRPgFpSfhEh78/hZJUJNVCphTohSx5N8?=
 =?us-ascii?Q?Zlv8PVNhbCdchvWMshJpIWVlIjQJawU+LViIEoMk+TjWjmk3HucNNZ9O1MQQ?=
 =?us-ascii?Q?Eu6NHkv12pC70fKEAObHrxKkWmF1talPjkXAjy97N5XPsmm3P25RQjobDuW3?=
 =?us-ascii?Q?886Z96MrHRRbvV9nLo3xCHw+VCWuT49b6vPsjSYhKHC2UKkfl5mOjWetrtUw?=
 =?us-ascii?Q?zl8ddZzffWv0hPnfb0NLXn/ZopnXGK5BIkU11ky/QoYkaxtYOFzS4zRQm9L/?=
 =?us-ascii?Q?BGbjBGmxYBitXYuk4ettmu8RYzVdkYEVsUDnkcsNmaFzJOSNf0l24y6+KbFj?=
 =?us-ascii?Q?dY9IAn+DNgOeK73scKNFD8nnkr0dEf5ap7mWovWOB+cd3Z3Zo5t30DQg7mn+?=
 =?us-ascii?Q?1UBVexjWLTnaoNg6r6N6Rn15iGMkHNilEPYfn6JLstOWTlr3RZOGbO+JrWtc?=
 =?us-ascii?Q?xKOs6Xg0KSyAuWRCTM772zR2DgCLY90Q5Aw2V86f3/85H7H5piTOq4sTOQh6?=
 =?us-ascii?Q?e4Yx0nXwT5nPMuzNy5HSADfgX4rp+SeRFM3W+e09bsiHCOgK6S78nPf0SbvF?=
 =?us-ascii?Q?aKtIVe4WGsBKblat7XCb8TlajmBE8ZqxKLdfl0vOZoKKhJq6245LHrCe7xMq?=
 =?us-ascii?Q?sH86lhVxoOSllXf8bRGdt1fp8FdG1bFZH1KYTC36W/vSe0MFpeufdN1kS1D5?=
 =?us-ascii?Q?IS6PdZUSW7JCpJ59VF3eccYiFGN5XoKq9S5IhC/DO2XTXEqgJtsk2O2hY/SR?=
 =?us-ascii?Q?VPoyYQwTgmeJFjBVYbYJruzvJZX17zJy22SzL81JSAQxLQ/wPJVzYxUoMMIi?=
 =?us-ascii?Q?3JVebcVTyJvICZLwzjDMgAHFFNzKeptzrHV5Tcl+BN4wqfq1Kzwgzo+cfnsX?=
 =?us-ascii?Q?VKrMtLxZF0jZ7xD0MvM8D6HS/bho2qmQXOqt9OsvUAZUwBIY45+YVxPzQ1rS?=
 =?us-ascii?Q?rT6zdt87Kqcfabu1TqPkcU5FvJoxh90fsndYKQHmzD+TV8ndVojLZkp3Lkc1?=
 =?us-ascii?Q?y/e7WRelVBPJIfxrO3Qw6tMdjA+/YM1HY51ujCFhvgY1rUJfz6Sc5r1Mm20D?=
 =?us-ascii?Q?xveoW89mNSdZw4zzWhnpH7VCN+zF9D4iDWSWLMyLcRf900LsGGcNQsiq+JT4?=
 =?us-ascii?Q?YSBwzAoBpuQ0hsfe/YwKbeyd87lIte1BxVTZvKsvIg6oKs1j5JYbVrAUorfe?=
 =?us-ascii?Q?Ai/ikdaO2x8Hy/W++irOXL1usabyUPNYErnYMpsVJlj8Zj3R04mgE0Dy1N2W?=
 =?us-ascii?Q?yrKeM5zZrqOpUpFubIqm835v/4Pl8lk19VfaZcDuRtqJ0qtlon41UvBEgsj1?=
 =?us-ascii?Q?e7C6X+2Wl8jX3d8pB6NN9qsn+YJf2XI+KynDV5U+rHjQ/NaSRLOyjn9kb0Ir?=
 =?us-ascii?Q?qd7lYOM8EE7zkP3NlMNWzjW2Anc7kS+QLlhvVMO3O62V+WyBB+ueq+KnpSKo?=
 =?us-ascii?Q?aJUAePK6ZF/9AL0lXuurDu2NjPT7XEdp59FG2rcbwXygWis00jsMtHsOpkDM?=
 =?us-ascii?Q?4VMcd0gTpVczNawIzcxiY/muHgm+Q96ocjkxt7HNXVXHgo2VVRMw7woCMLlC?=
 =?us-ascii?Q?OU+il2IFkQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00d22a7-2d30-4f69-cdc5-08de6ff5a59f
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9630.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 20:29:57.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpVDbvTHXW+aNMQCBeW6viKNYUdtvQjmmFN+IAwhreletg4ft0VsjOU3SXiG3OlFxV76paudNDlZYemVSEkLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217501-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pgeng@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 80F13162537
X-Rspamd-Action: no action

Move claimed and retune control flags out of the bitfield word to
avoid unrelated RMW side effects in asynchronous contexts.

The host->claimed bit shared a word with retune flags. Writes to claimed
in __mmc_claim_host() or retune_now in mmc_mq_queue_rq() can overwrite
other bits when concurrent updates happen in other contexts, triggering
spurious WARN_ON(!host->claimed). Convert claimed, can_retune,
retune_now and retune_paused to bool to remove shared-word coupling.

Fixes: 6c0cedd1ef952 ("mmc: core: Introduce host claiming by context")
Fixes: 1e8e55b67030c ("mmc: block: Add CQE support")
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Penghe Geng <pgeng@nvidia.com>
---
 include/linux/mmc/host.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index e0e2c265e5d1..ba84f02c2a10 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -486,14 +486,12 @@ struct mmc_host {
 
 	struct mmc_ios		ios;		/* current io bus settings */
 
+	bool			claimed;	/* host exclusively claimed */
+
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-	unsigned int		claimed:1;	/* host exclusively claimed */
 	unsigned int		doing_init_tune:1; /* initial tuning in progress */
-	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
-	unsigned int		retune_now:1;	/* do re-tuning at next req */
-	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
@@ -508,6 +506,9 @@ struct mmc_host {
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
 
+	bool			can_retune;	/* re-tuning can be used */
+	bool			retune_now;	/* do re-tuning at next req */
+	bool			retune_paused;	/* re-tuning is temporarily disabled */
 	int			need_retune;	/* re-tuning is needed */
 	int			hold_retune;	/* hold off re-tuning */
 	unsigned int		retune_period;	/* re-tuning period in secs */
-- 
2.43.0


