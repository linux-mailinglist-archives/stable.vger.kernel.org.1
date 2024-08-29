Return-Path: <stable+bounces-71518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC4964A63
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101CF1F225C0
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E6D19005B;
	Thu, 29 Aug 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="nrLs0TAf"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2103.outbound.protection.outlook.com [40.107.241.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF541A01CA
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946238; cv=fail; b=Y2UPLFiLkxiS9kYUYuWtJohLVthtXCfBst64vsJ1DtGxAIP6DELhc2w44T78gUdcSQm92YxjcK0OsVDInXPy3Q2ynBRgpQ7K7Ygohn4YhkJrwlbNV0elZJlYwTQdTNLcaU9eWrOMWXUWSdfQYge7GIspIqPFAKn+T5nFRX+A5Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946238; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p83vfMtotPDsKpa3jdLwvr49wJGkinGgs1avbmCbUwRRK+Vited8XD3bmYMx3ngzi116iIsUmy223zgaLwyrl3a5FqQj3mtZ1cQ6CzAxAx4Mof78Vsw6tLfKd555KLMTYRCkEiyxhdg48PcMKEwBoOzZCganTQ6fFdF5NvXioW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=nrLs0TAf; arc=fail smtp.client-ip=40.107.241.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoUyKH1NUNSnHSPa8jWhG6ndvwrbo3Sjs/4dmBBoOUPcTi+X4YBpuGnkWv3ewFvYCqoiCE7KDNl6gveTSxyLq9opiZYJhw46M6f1PpALs6uTMaHM9fncTDzAWh69G7WT9pZGWq3OM1ElHCjmPI3BnEc4dlllX61Kkng65uR7XjFiTiO9sWhbdwOvIJdSKV5J2UV6NYxoPL41k/5Rs0gzGQA/D1apg434CAOF2s5mKVHBONiLXQZb35pcJabgIehUT1ZsS7qGeiTb10oORAQkL5X2564DANUylsUQ4bcgZkl5kcQxz7ZM2lipMjcy5cMqrtwq4HKntDSbiadVlN0ZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=FrFMVjMj82J9bsbSXa90AZQJFkQ14O8TxqCE2NqAVCXxcPoALVl0ykHGZ+LbQo7dE9tQ4nT9gbsK3v4ZzGg/QTkmlA+iOhBmm4oXJ/BLEtfzfLXFTPZ4mWtnZeFBs9d2NMUSavjIqouAP8MpB/VXbxHLfkKPLCUUWV1OsOEELsqY/xNs6VmmGhC42vrn6pBin1/DYRggUCp1qNtrLnLlVEiT87mAixINN2r3r43aQfienOnQrvaJpU7jwWDjZG29UB0jfolK/gTF5JEPo/A4/gDuYdLa0k3cL3dcR60zi6vqZWC6gkJ7a+8+F12bSNErAx4Rq5lwWXRiKk4iTmtMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=nrLs0TAfJyaHdyplXfwcEno2UsmfEYOkox5PfK0NhEMH7l/DDARCryFdRygOz0ami40xAAXFCtOQSq/mNwcKwGdKUQC5NoERQp0CNZddypM6WkJKGcpKzUfOhlM/0SRjwp3rHggGXEZLg8nR9Trq5HJpbepQYfnP/EkhHnuP39ABeWIWLVdTTilOsa35Pr46vQzFx2P/N+ZbWOthJVn6x6w1irV5h/SWV7PvOOFhHSO3McLLKXtG4ZCC/pF6YHbsVhQsW8p2Hs4FSQpmlKnKcapy6b12kS/93HaTEgduvzI2rZAwfBuEu22xYcTfl2zCiXyyXgvOwjCspqIb9a4Sig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2070.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 15:43:53 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:43:52 +0000
From: hsimeliere.opensource@witekio.com
To: hsimeliere.opensource@witekio.com
Cc: mszeredi@redhat.com,
	stable@vger.kernel.org
Subject: This series of patches fixes this CVE: CVE-2020-16120 https://nvd.nist.gov/vuln/detail/CVE-2020-16120
Date: Thu, 29 Aug 2024 17:43:46 +0200
Message-ID: <20240829154347.16206-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829151732.14930-6-hsimeliere.opensource@witekio.com>
References: <20240829151732.14930-6-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P193CA0041.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::16) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f65a169-6fdf-44b3-b9e0-08dcc841624c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKEFOrtayJn4bRM0ENkKF5v4ZXVy/viN+bQTfP+VW+pjBNvBa2NtxpMo6Kp+?=
 =?us-ascii?Q?B0+drLR/Zo57aiN51YzxnpZ0aSgnFnKWSzhLi3CmayernTRhTo6xR3o/C68I?=
 =?us-ascii?Q?slU6Rt+udShrCB/Ra61RDyl5F61QwzrQERQf0TQX/MxdCniFaj6ti/nJIuTZ?=
 =?us-ascii?Q?9RyYCvzf7Y+GOq5Mm7mUPOCtnef/gRCSmol3W4RQhUDtYJbhYByqZ+pvgeik?=
 =?us-ascii?Q?HOvj/o35YgDjo4c0OQbmacrBG62mvQ39CwojfLrishjnhigDCLklmgRhsmb4?=
 =?us-ascii?Q?DSNuppHaA1+ivUHd/YF4/hXYBUFcvS7AsqXc890MSxb8yVeNFmCrkKXsMbeb?=
 =?us-ascii?Q?hmqqhs68SNNvtJFUEGzPSovqmeXgdRbOiiD71I8ORL0JpdQ8Myg7fk2dPVoI?=
 =?us-ascii?Q?4ME+aY+ZUH9nq4o7jA91YeHZhNfKp7bH2YpkqXfLWJ+1jbOmlHgrorZbtfzl?=
 =?us-ascii?Q?WcCc2laIj1iOeH9hbIEmb/lfe6xfMMUo/eXO0FWVIPFzaO/LW2iRJ4lVXLi5?=
 =?us-ascii?Q?d3+aZxzryMhj+lu8PzUrcOH/EpleUSsIQ4srI+Tu0hBT2KlphvdD9GK4Uf1U?=
 =?us-ascii?Q?Jz+7/uL9aEijAq1nYCQSo/MXe6njSY4Ay77U4YdKZSq2tZFn3n8ePwfqLJX1?=
 =?us-ascii?Q?VWm38fFZKZnW7v9Q1D1tf47xk7YekAWO3llKLA9KF5rNmuHdjT1epWQkpX//?=
 =?us-ascii?Q?ffzd2E4ARueXFZJfeWFy+GkQ0Rwcxk65FVz+3MQePMCv09oF9DEpKSJrADP1?=
 =?us-ascii?Q?j28eYGtH+u1R+14ag8gnTBnRVNurwOA66mv1AojCwaYgTPBSGPPJGnWhIoQG?=
 =?us-ascii?Q?VvnFjCE2ZvjBdVWOoW4y1/Z8DEq6XexE8dwY/8ELo5qon1ip1t+pNWYxJHyv?=
 =?us-ascii?Q?2s8FWc8+Cv85x9MmFlAdnCvoGx0ui4nIILHM7HuKQszBBC1st6kM39UC332e?=
 =?us-ascii?Q?OSgeRRLpUfMF0i2hpGAmP3koR7dgXVctkSQXwRNOQNuZOxzKOZ2UMe07vdOr?=
 =?us-ascii?Q?NL/ejt5CxW70zta4qU5ankXAPCPRn3nFPSWUCV5e4Jg6wRZ+A233NnisBx/e?=
 =?us-ascii?Q?FabkC7d4FfzL93kReA/Evi7GhaATXDrROIju7am9p2YVo9d8oMx9nKjOeDR6?=
 =?us-ascii?Q?1T4yRbnWd7iAna1oH/3E6oFHjDcpSAkquA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3A70i4wPCREBDY4w4VBqzpyLaBe1gKNaAwOCgMg6nVefAWmGTJ5q3Vk2qGl3?=
 =?us-ascii?Q?RKLvAH6IaYkRZG9IxJVilLfm6KIiOX8v/4qFdOboRNxq/DnxieG7XPc5xvNy?=
 =?us-ascii?Q?cDfXV0hw70ROF2xBH6cTaJVit4ntgkYBv/vHm3TVgSO1wHH60rapLa9o6/hQ?=
 =?us-ascii?Q?4ZMV0kX0q91WvJ6H6nsueFgoX1Wf6sOWflAI4+Xde6i0aaRxbOI9ukX1wE23?=
 =?us-ascii?Q?oWzXq1cC2c+gElmEnGXjFnoYd+v1nX4X1QfEGezs5Eb5RY/zUdGlvSyJUgi6?=
 =?us-ascii?Q?tm4KvmVSciSbAZ1y3+zN42HqPolR+St8pYBv4R/LmiM7MRtwKYcrDXQ0Z8TE?=
 =?us-ascii?Q?ZFwXofhdoB+7oJvyD0WontKq/1syCyblC8opXBWjrw+jSnUtVahcu0tHUR6Y?=
 =?us-ascii?Q?I/K35p7BRXDzdrG1DDgFOjbYvodirqRBtEa9lv88E3iPsgHbX2Py534h7o0j?=
 =?us-ascii?Q?GM1YRWB9tbX/skr6vEdb0+GCSV1dJ0l1PbW/DzSLTTg74kEof3bHdftzwr94?=
 =?us-ascii?Q?vFcFneRGYFM84WLNYZnC7y40GMCOcTQXwy5a9SqvqCOfyV9TNzlvlggGjTtK?=
 =?us-ascii?Q?DasfvplVHisqUxOpavOAvuyPBhTgRFFeTzlYXDRxygxGLa4o1NlBVgh0XheZ?=
 =?us-ascii?Q?efvzoSB9/dMdbbWdKIYe8MlUADVFoQp9hz67Ii7flShVJ1ERHTaUz+epmX3s?=
 =?us-ascii?Q?kjFFsGYmPWKjvPVl4BF0OQmxIr8zAaLlPvpbuNJBy7KxYY5X2iLNcSbx3BJz?=
 =?us-ascii?Q?9tzlMwM8nT3KrgZwDSd3lpBN8t14VxhZWbxMsyx6SKCYRzvGa+40+BX9lrAd?=
 =?us-ascii?Q?IBbwlSNQ6YSlYHW+Cy8lJ0SvWDoG4AtoxElYAM8n3Q8lD0VeKh/6ZerEtAP6?=
 =?us-ascii?Q?9f6l9Z6BzGL/3zfrLrxeS7D/DGS+w8bSc+rwZfqcBDnqjU5a2LFVyLhH9OmC?=
 =?us-ascii?Q?pPtKCmH7KIzR1wkTyhuNgg/F054Z9PnTIZBjbGLdJV4tyq1Nme+FDf5Bylow?=
 =?us-ascii?Q?7DGiew3lxUzvG+gIRsJ4LqQupXDnH44McWhja3ILpwZ5IpWzSLypEW8aRUpQ?=
 =?us-ascii?Q?7mN4x17kSvE9e2uDJ4y3NNHVGHrv5sfF4LgXjybP6dNzfYKC2fnnEGI6UoQ+?=
 =?us-ascii?Q?YmyH4160iDgG66YJzJIrOIH2cwMd/zySPgM8PbV2nUIGLBBZYI4dUu+Urblq?=
 =?us-ascii?Q?IJcrUprkhSWyZHhZZqIZ+7/ozyk5R8bGQDAHjz/WmerNgbAcAVdteG9rihcY?=
 =?us-ascii?Q?A0HgjDn1eg416iEdtyEc49le+2jqNV4DgR9ZieCU5rIwhJ+nFIfxtA/BVTmV?=
 =?us-ascii?Q?M67msL/c8LG7A/0a4EeyAI7FuRA+//lVqdA2ULJ/bfdz0ouxkylcsh+r3xTT?=
 =?us-ascii?Q?/tQx79Z1/QsN6rs6pgy7KtAivl3CpBtRfqKsmeCy2PGbkSIaUhOvQMlU9+9v?=
 =?us-ascii?Q?9QIFzTAmqEctyHjAK2q8XdtUHxwxKAIcbNOEJu0Eb116RnzrIzODkMepPDcO?=
 =?us-ascii?Q?igYF6nkRyfzT5ExOZpnWvSx0/XeqW2O/SSnBqcDAjcUNvHb2F+daFuNZRFcr?=
 =?us-ascii?Q?ZfowwRoJ4V4mycTHGCqpN9EmAMgE0wf9eWfLYy6jIaCwwkPMeIJxinoONiPB?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f65a169-6fdf-44b3-b9e0-08dcc841624c
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:43:52.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ri0cnMU717045IF/LJatJ2nwQAVkDvKTQ145wyneN0wlhhpqjBcJGPodmEnw12dOOkfQAMlsih9KEG2O0DemzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2070


