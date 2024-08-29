Return-Path: <stable+bounces-71540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA9964C1C
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB569282A5D
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63271B5ED1;
	Thu, 29 Aug 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="O+8Ejk16"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2091.outbound.protection.outlook.com [40.107.20.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10E1AC8A9
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950404; cv=fail; b=FkJTuPWZD/Dc19OdU88bhqAG8UvGl+EPmbaK8P/b74JuqtLSs9CIxlodIU+AjDKD/W0qFK3DLiXRb/5TJ6cNRdaMAuNQmDqxIeKeSVK6t4jLvWWYScwuSLBwuZWly3LULgj+lVRleDoMXRdVVx2qXerF5GazeRPSOBMleLsdXdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950404; c=relaxed/simple;
	bh=5iatRxwrEZJPJSuwwnxS3RJZU7RToq9qpcommSrUQk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdmjUXIFFgHu8bkGrM8pNbeHWGOSt6dx0j8U6MexN2HjwIu48aFO3ULpEZJBYK5JAPX6QGPwSkkCtsLbRG44ByNu2q7G4hkO7c3uy3a+JTA88baWyPCMN5RIqZlrPqsQ/NM/j6j5ny9AH0A+RYIJqL1561i/m2qW8cbdpOvMRzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=O+8Ejk16; arc=fail smtp.client-ip=40.107.20.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSueTACAU2YYHYSccFrSgOngpDxB+WynUK7HktwRZ9f4mOUSV4xPE+uzzBS+93G+24UZB30HugAVNUoiSl3CouoFJSgBauD5pjwowwMIcFY3A5y8GqX9j/BiGbBrcRiSvGvUO4H1l8drcBJV7wGO3sl8nbggFMU3tJVXhCwO/L/Vp2Rw/u3Hp2UWJtoAyNLH+BFqFnMUSrEaEcSu5gZTGXL8AIKo1lXrxTjbviEc5skq8VSZv5VAQ4ap84rPAWCqRxp5nNCcfdA+hpUrdBgzRkcafOndHmesG+2e15e1fHXa0xma+GNXNuk76GqCh6fdZuX0yZg3ORKCbl/8zOBznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iatRxwrEZJPJSuwwnxS3RJZU7RToq9qpcommSrUQk0=;
 b=o7/vZlieTni4rCupfB8kTyB7FcoEnYja0MMSJk+HqTj1zLYERn0TmsPYSPFBKkNuWWdzYovUOuu8CjWNniVf22gFVPSjl5yKylWvQBU7ZdEbVbsZc5+Ez9YshEmkhNBGXK5FlXMbV/YKNKeXGnpe0mM4kAp7ol2siUIjG5s5fIFI+rgvwMROw2KNaXOF04ue4L0BrD/EYhicDW2ENX1+jqVWNxl3ifzddnpaO5NVpKaKqrBixuBd+Iv6GFrS7U7PS4nZOX6Fsb7blFVCjvlbFOPWj4RwnrFOtKAgFCr6hIJ9xD+R1W0scScmXw5fLaBZkFrFiRYHNENpf6QCrAlMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iatRxwrEZJPJSuwwnxS3RJZU7RToq9qpcommSrUQk0=;
 b=O+8Ejk16KVUDPaqLzUjoZrdePRLrj6KqIrmldx2KPjuTgNgeD+gwb76ZbW6I4ikV8M3C89QLl4PQMnCnaRyxeMdAy7y4lVzKzxOaZBdHKDVZlcQW3tclF++vhvYhVWyL1R+CkOpHspz0M8T+px5GCIM8DGfniHGhlmkUMqsbaOlSHkUDy5sp5COAzWNSAZeafci1KJokhUh7v7Y6RrwjaKA62WIsdfMOk4ETer5OQ1Fmi/cB8iiAta0tGtuBYdbx5bPAx+dVsvcJkB2yqP2SWtbWJePcl3GZVOki1/o2tT2omtm/qyTQBmnbYm7Ij5FaSuEfePmuGzOktDELmrxG8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB8P192MB0648.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 16:53:18 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 16:53:18 +0000
From: hsimeliere.opensource@witekio.com
To: greg@kroah.com
Cc: hsimeliere.opensource@witekio.com,
	jamorris@linux.microsoft.com,
	mszeredi@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.19 1/1] vfs: move cap_convert_nscap() call into vfs_setxattr()
Date: Thu, 29 Aug 2024 18:53:12 +0200
Message-ID: <20240829165312.20532-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024082914-relay-climatic-95c7@gregkh>
References: <2024082914-relay-climatic-95c7@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0154.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::22) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB8P192MB0648:EE_
X-MS-Office365-Filtering-Correlation-Id: cb44776c-733c-4399-88ca-08dcc84b150f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BnDooylr7McMgxi58XDLnwISgA8qMlYeheybtrmK27V9bv3l2p5prxnPB7+4?=
 =?us-ascii?Q?8ImDDgWsYxEqpmK2RX4YtCRcgUIvmg6xl4egmrESYinpOF31nbTyEV5jeUng?=
 =?us-ascii?Q?GZzWiz5DPUNnnDdVzKhf64oxB6IwoS4q2Lvr5/dSLA7i3QwIoZwoohGGqMs6?=
 =?us-ascii?Q?2xHvUzAgnurXv0jmZZgp63CRVQhu4/FJNiPm2cdvN+yBIndoDZ1N9/gO8+mp?=
 =?us-ascii?Q?I8dcjfCs/hu4pEtS1vskcOD0r0SlggjqPNK+eDHIaKm8KBGuDvmjC7veJyIw?=
 =?us-ascii?Q?9q2LFExV9RYqbWyMwv8aA1C0Tqzf7U4EBMQEJmlKuDJs3oTbMu/H2aTbxLD2?=
 =?us-ascii?Q?C5uyScwHw8rZzDFVkBctBEplWQ73fi/IacpbCF8oI0KrO3gp0dxvRiz9D0O0?=
 =?us-ascii?Q?gOwjHYngb4UaKZbqotZlh/2utpSc+0HgTX9NFCQpAPU+8qAWvKFk+0pws781?=
 =?us-ascii?Q?hSjyUWdhY1FKGKxAiyesHX+uNAxwfr5YwHIpr5his/uW+CSpV1oReSflZazg?=
 =?us-ascii?Q?tbLKIwuRHPZPUfgUBgfPHsRQELHFujtCMGyuNAV1DTA2IsYyF0UcfscqYZAM?=
 =?us-ascii?Q?CEkIgSuK7Ny2wy6+9TqaeF/1ZT49Nn9GuWgcRciOM/0dHD5oMoYDZ+Bt9DPd?=
 =?us-ascii?Q?/szYqUdkxhxpkUL3v5Vwuw/QlUIhIGdBQ4EBIvpcNX5vS3BKZ978kZYOed3C?=
 =?us-ascii?Q?pcVO+iRDQqirE2f9Jbt4xAj6paV5qjgxMsjNF10VrzlAosP+M+f0fH6OhDfj?=
 =?us-ascii?Q?9oCFVWX1p/L+Wh98vUEZDkqgS8Cun3k7zy9aUVJ1JRl4kZ+9wZbtFX6rQq3n?=
 =?us-ascii?Q?9f4t0tbvCI8wYjzOmRe59PoIL7HPP3f89DPvt4wH2rc+hJ5JPjQZKaqtuXoq?=
 =?us-ascii?Q?fxe6IqMTkU2ALxWlkVXg0DtdDNPOZ8J4tm++ErEWTdauYMSSA5SMTy7zn6VV?=
 =?us-ascii?Q?DbaDpUj+XmAT4nQfTUAs6u85oYR00pIgKPouhFhe2YQ/8U96YZzMq3q4qKuy?=
 =?us-ascii?Q?vdp6YsXSffKOM1QztfemSYqhycibEsSYd5Bqs9USdvFcfIAuzapwEp8HJWv3?=
 =?us-ascii?Q?1iYivhHcEUVLXN9ua6tgRevcBmj7YdWCZ/629E3zQCzAIoB4qqMLTO9/a74C?=
 =?us-ascii?Q?Trsv62I2OyZFeSvTXchYroka9BagsDdsxrjE1AwOtCnXSrxC4x4zFE+R/JbG?=
 =?us-ascii?Q?D+wQofgV/QCwbPSKQ/N3nV7aTJ9RmLbF+0UJmcA6cdQ5QfWm9AQXnguMvAwJ?=
 =?us-ascii?Q?pYaiGXX3wZnUKC/uYD8k2jDgbENYpABzVn//hy9ZyPVcYLofq4jYtUJGjsqY?=
 =?us-ascii?Q?H1a4ZglHeHEo+qE9CIMUOJSlzJjRZyOMDLWtoAToCvlvlJc3g8owxs+vuQtl?=
 =?us-ascii?Q?yeilm8DEV2nGgTYlHpyvNPBXlj2TlxTUD4Ri/dCG7NJiUKY/jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/10Aofnop5F2iC4oUOc1K4SfpUBHxZzw9uySF5u/l7AyKHlo1fpMvLUrM87?=
 =?us-ascii?Q?eghndAVC3jH/KqswfCxkQZbg98GxKINzZE1Y0DDfR0HFPJo3uwrTXUS/xDH/?=
 =?us-ascii?Q?eSmClj25C2RfbzgXBgUYaz2zNrfrsFLE01IOrvnHphT/9l74dUe+LezyuglP?=
 =?us-ascii?Q?BRxw3S+fHM1JPEMZGaoHn0FO6bHV3jIA0jQpl5brklpP3nQGUUE+iOsO3rTY?=
 =?us-ascii?Q?L9U+UoW88G1HrDGPqw9OIQrmpXJkyARrzPcIDeiSfKD59ja2+Ol+xzVNAw9i?=
 =?us-ascii?Q?rMR6GYTtDkGKpV30tDartkFxVpLe3AXxHfrmD2WDppfKTHRWD6odZukEbXMQ?=
 =?us-ascii?Q?4vqyqhVSDoneA4/fl2TzsY7p6JP5qWpNLjrJEvqfZXQPC5QSLPIrpaPGzttz?=
 =?us-ascii?Q?pWMiNY268ANm3t9+NMvU/R6EKNycRF6I+PKPSxodWQNtoURIjbL7ee/Qv5yN?=
 =?us-ascii?Q?7F+sPIyIxQowGisk8VHTdLngClkXOlu9A7QHoiFrMDfkVAPgkaA/EOLoRXYu?=
 =?us-ascii?Q?qeUA1GG94CNsJZzPS29cJDZ5G/toDdOMxbbNrVCLGPmpFyVifiWLS6vg+9TV?=
 =?us-ascii?Q?u9wlUvtIfeGpM/7ECWGuNBbP9mqTl12D7uhHrafvgmj8Bwt3dk5hKZDFb+7k?=
 =?us-ascii?Q?pR9uXCQMv5zeLDYUeA17gCPUd5SaRwWkBP9zVzo98I95/m4bBL3NJm668nM8?=
 =?us-ascii?Q?LA1A1OOz88nIgto7UPKF7zjKummJIHiIH4GUAc8QIFXmjZPcSlXF7zmnVh1C?=
 =?us-ascii?Q?fGrxRI3VkshxK84ZjBsWo938pUtZLdzdiEyPCboLCmzSRb4rX0ffV/Vn0zud?=
 =?us-ascii?Q?jM3OAbPmnpyCko5xJJwnTVQ+cm+PZE1WF5+WE1IuMSAzVbjpTfOKdJyjVKps?=
 =?us-ascii?Q?v1gW9153xkyk5NmaiLM7vYDvEpRZA+/YOk+nsby/ZCHYY7taVeTn66OlafDc?=
 =?us-ascii?Q?V1sp+Tpetu+zBW90PJyZdxf8hRsyFitGb+G/5U+fBibxX3oQ2nPwzQL+vmpl?=
 =?us-ascii?Q?5MqV9lQqs2EXvgFWUwbmQZrwNwqOPCyscEyS54pUnQNDKyuobhF/bfolMM/H?=
 =?us-ascii?Q?Rg+CD7bnIEz6oIGGJAg3cwznRXgymPASqsIwXSWsJiaUz1PaopSklhlRVmfr?=
 =?us-ascii?Q?7w7n1k3BniBv9KwU2W7uh5HtODsHm1axoIx/KX2yNRFS+QQKEREOnAF5C1jW?=
 =?us-ascii?Q?eGlywkO9T74qz9O9q1zX28UniMaq6OpGs+uiWAQbSGunxs3qJJid6aRr27vV?=
 =?us-ascii?Q?uuD5ge4v9n3dDhT8MjC7RhTHF2+HpqpfWypq8VJD9f/784v3cKOmdocbaJM1?=
 =?us-ascii?Q?w26kNp0ISdKhcyb8GTGKzNzw4sDaINbAvOetMu5eSGNz588k+fVqfbHIN/6X?=
 =?us-ascii?Q?MtV8dW7LYM0Gvul6fXlG429AyRM/aXRkWmtRprgCLibO/hLnrlNYSQ/IHPmD?=
 =?us-ascii?Q?4gzULYTonFsI3l0o9DqdaWSQ1bLgc15bjYEDOR6gPiGDdTaXgzAk7QR2mdi1?=
 =?us-ascii?Q?BwH8hsf6d4gkCSA+efZ4x4qoqJ6tT+ViEDCix0p9J0ka/nVOs/ZAYNFNPsrH?=
 =?us-ascii?Q?HmHbjWmo5l9pB/c97xd9lreihCYmB6A8BRGhCC9Vos0tGiHypMQf/KF2hCpK?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb44776c-733c-4399-88ca-08dcc84b150f
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:53:18.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yK2ZWw3lQ7/EKzPG8im0gAMRnzrBYpIQNWPppSmiqh9pLbwb36+DHtC9Am2NPD/flU7qWxbtlZ4GKkLISVHgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P192MB0648

Ok so if a bug is fixed in version 5.15, we have to send the correction patches for version 5.10, 5.4 and 4.19 for it to be taken into account for version 4.19?

I'm sorry for the scope error on this bug, I'll be more attentive on the next ones. In order to send only corrections related to this kernel tree

thanks,
Hugo SIMELIERE

