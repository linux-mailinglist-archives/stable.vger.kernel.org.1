Return-Path: <stable+bounces-131751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1841CA80C53
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C09058EC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42F288D6;
	Tue,  8 Apr 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YEsloho/"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBB288B1;
	Tue,  8 Apr 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117982; cv=fail; b=n3sFTiDt6vZlUAEqOFD7wRewXcJrNznr8R6mf0sVS1mZz/dMMKvMSBgEgtSxeXAMfq/z81vavtg+4wcCFGsCZc0Nid+GUJXYdp43lfe0LEYBHfhvvO47bg8V1axI26m1paPPZDwzIBNcpqeUHgHjOllihZ5nlDrBuK9+TV/nogE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117982; c=relaxed/simple;
	bh=BoWwRiTyaxhHfSPJDUpB6ECaDvEXkyqWXmnv5hn9IzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNt12uMB/93JZswWd0eslOGG6nMyY67CHvMiPqMuvKIiQiUq8VGmfbU1rAsXu5d9kIFyHQhRPmJltKWD+DjH/2o9h8TKYjc2oEaOGmvQ/HgCh9jHig+fz58k11n0pXiYW6i8Pm3omoXFwFf6xtyuzdqurqtYB0/NFCQhm3KEhks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YEsloho/; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNbAI4Ndkn67EhxQfn3XKd6NLPOA/APEel+0yZ4TjFtzwg3W6yP4jAS2xe7nn+nkraqp//7N9LvQtT4yxMAWCNSAHR65/LRpjbIvtMK/g+w4dDVQOqE4wNSASQu4yXj3Lqwbi8Y8c+YUuhpMzHOzr368yrS923bwOLwGTAFJqZzfRTXxzttzme7FNwcdAs705wZcf5706hgQCYi4TCOjRpHcLwUgGqNNr/T2VkXAKXWRMI52iaawQ9PBg3NHVGbpqL5MeDC1yy/lVPatzWFWGms8pT9rrP5PAiXictUmO1RfF/9bqk3qR11XUZqynRCoL3EPe2+bjBdmZLF4S2utag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/1Hg3pPRlCxzs3N5RsHf7NPgIa6KsZjTglqC6L5m1g=;
 b=SftpyGQWhpOVNPvEacO55afKI5Qn7laji4VgiPGj2QfkmzYcSNsm0nw3F25gXursb1rv+wRVWuqaBaJG/t9d2a82HuQBNeQiQre8UDeYNH1KDdyi2xj4plD4pmv3eFVtOntF05XTL+taCQhQpI4AZGejZoz+/p15ywZOLsrJJbviziDzlGaWFUCh3E/faa3P7epDZJjD1AaHdDFiH6MkEljBCCjHy2qrF5Ia950aqT2lDPrS0IpEH0z7zmMZHWpPLKOUkpZbtWd1XMxijUdgDtCjNLM2Bm44ESF3DBSGQ1bL8fLCn7/Pn9p8lErxF+QsCPZpc25VoAHrS3p66fZepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/1Hg3pPRlCxzs3N5RsHf7NPgIa6KsZjTglqC6L5m1g=;
 b=YEsloho/6U0PYsMatidBIi1V+8Adiksc1NiXMAnqxSW2TsBkAcTkeUXQqMke4U02bQ96G+63uncu2S7Rzk1FeAN3beiMcgoXJyVikcYECXHXZrvrnop1SMM6mHNnJ2tbQL0s8nvS2vRTGlxG4IpmgO9nqruD/sIll9QpfZfL+xmeR1eKTde7y2G5VRJ/uBY8yYZ57xaVs8qD5YWVtcvwtnDOTFyqWpzDQtcnAWpYJenvHHvoQVfm+3bkksTRtFEV3bZigqc0Gmva13OT3IshkBsbkjyNz2CAH8Q8Nw2ZcbqHRCzbGeopLkYbeSRguJ9GTN0PEWJBOpnsvQwh7JU0ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 13:12:51 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:12:51 +0000
Date: Tue, 8 Apr 2025 15:12:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
	kernel-team@meta.com, stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] sched_ext: Use kvzalloc for large exit_dump allocation
Message-ID: <Z_Ugy6NDFBscP9Ef@gpd3>
References: <20250408-scx-v2-1-1979fc040903@debian.org>
 <Z_UI2AHtkIGS4bZR@gpd3>
 <Z/UTzPoI7+LElhEE@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/UTzPoI7+LElhEE@gmail.com>
X-ClientProxiedBy: MRXP264CA0016.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::28) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b61a55-510f-46eb-d490-08dd769f10d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyXjigptWHsujQpp94eM+pLHR1JZWl2/2OFA1954TtQU+zinESsnJrNPckxO?=
 =?us-ascii?Q?DbCoAkvVHv7p4jso4zSExVlomL7TF1X/Cs/hujrnFD+KtGWoUrkHLe3dnzUb?=
 =?us-ascii?Q?8zRyrqM5e0+1CDMwutIwX3bbZHAiaXQBUjOAybu0QL7eWcbK5XpFQiEhISvD?=
 =?us-ascii?Q?9HA3OJNBsrs9V/u3GoC18YfVqC5LA21DS4rhqmiURWCqofhw+oH6FXERfx59?=
 =?us-ascii?Q?dI7sDzn0rjkv8W6Wp03Plv8K3dWbk/q8x6xVT5SIxdg+p8o8YzP/5Z6fUxyB?=
 =?us-ascii?Q?qGX13WOSsZP1AfEdr7L6BDWlbPtRqURMkrSdySFqP6gB9SanGQ8ecNNI+nP/?=
 =?us-ascii?Q?Y5bR56gITgaYVn/QigwGS2fxB/QlJZEXLuBvrHVdozeB2mBTPwc1axQ5UjGt?=
 =?us-ascii?Q?MEZYFVBhp1UR9VmvfxySyI53e/LKXNztR88Bvx6zqhRPXArpeEg3j9QpKuXc?=
 =?us-ascii?Q?zqJdNPYMexffCYfmdL9RjBR1KKXlMK4BTv7UJjlK0LFQ6DXK6Llm2+v5BauC?=
 =?us-ascii?Q?w/hnlzysmkLvs7pG64jikx6besYX0D3kU/FDDwdO+ttFL43q2ZubKq9z7PMY?=
 =?us-ascii?Q?EdsxYBW0tG7rT/0KC5sCaE5BdkGq2FWKFPpceSwNcTDRckZ1oW0fnpof9sSN?=
 =?us-ascii?Q?ln5pEhRe3SMqomdCsgYFaFn0cNLCECFDW/H9flr1Qdfzq/1+bLqf5zkQkPmR?=
 =?us-ascii?Q?C5cXQ0zuU5PID8Gi8a3vyfjlwMTWY6belGsMyxyY2Zf9FPYbMYtiO5zrXdE9?=
 =?us-ascii?Q?+R6QZVOwAsCjn5Rtzwggs2yCk0K6/dKWl5v419BqKwmzW6mu8Hekp7WpHFUu?=
 =?us-ascii?Q?kUxGgeXIDs5iPrEm2amGnxhkqIJt62Ne/S2gAWCcvT9nnUoAcQVQeznrVRIr?=
 =?us-ascii?Q?PJ6cJ8gzjefTZdcJpFnd1cdjuXmu0QrJ7gPGtytG+j7O7yqsa5k10gboHNmO?=
 =?us-ascii?Q?APJcEHtLM64/4au9ZA4pgJ+zdz9DOwlitG1fZdqdpMhf6KwSSC5AUx1yeuiK?=
 =?us-ascii?Q?3qfRrgyf0Nf91MBzOpGuqkfg+ntKvYUalXzHrHrIN3TM0fHWFEIJ6UQ986vU?=
 =?us-ascii?Q?XD0AL4klnVkYMLDsjuJ14GgfJDk3+nnx6/yvQEQqIQ9/1dPgKm3lG/ImZFlt?=
 =?us-ascii?Q?kqfVAgucHZX5gzjfuX6H4J1fmiShe3P6q1EU/jSwHD7d2MQqU1r9pn2yPQU4?=
 =?us-ascii?Q?uNksLVg8+xruEp+J3EzunwSarcnvwnEBjIqeSENC0wXxfCmcl15p2wHgvkIA?=
 =?us-ascii?Q?Q3aiKzl8mh/vYGKAaqHK20Mw8SvUAc5ZxPaPCjAXNhklnbj1B0mOFDJ9aDz3?=
 =?us-ascii?Q?3Vbqt0dtH9rsitHkLxg0wK68lnIqeNQJVkeZeB0QiG0dMNl6aDMU3HVRkCRp?=
 =?us-ascii?Q?6yDF4IuLbf2PXwLpJi2S3jwymSz3TlLD78HLyMFDJeTW70conOBD4L6A4yI0?=
 =?us-ascii?Q?ePK2CPsvWck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GG49o3z71UHuw+f2WYy0tQtHnmFNvTTBpkCr5+dnlHmihMZ6JjYj7wrpTkg?=
 =?us-ascii?Q?jMuGx8Xjrxk3vlMKuZ7UHVr6xp6pPKarznRzGsd9i/vD9o1EFUzdmQMpkHGB?=
 =?us-ascii?Q?e0V+JHXvcPLNDPBMRe/F4IlH8k1MjgBzmaJOLLOAozryI+m1PCrEQVcg8Zo/?=
 =?us-ascii?Q?SKJuztU3k4ReEsveo1GqCMSQtruPMFfZpqlv2a8wdZ595Zkgq/euqnEe9gLC?=
 =?us-ascii?Q?PXmwnWjE3eSFrEwPybuvokicJ5OElc162MbocF20DnHPADRKL74H+AH3DJCg?=
 =?us-ascii?Q?usRtOYs+UclwJUBH5dZChDP+8G8w8GvKKiZ5oPXIRwc+0r5rvV2+wdvyceWB?=
 =?us-ascii?Q?3/XRoLqv8Sf6PvmEyD5GDQt/xs3whap2OL6ksvdyLHj911Kb0kokx7K6hv8Y?=
 =?us-ascii?Q?RkF2zF/R0uzzY5PRLPV1tNEZxL3jvjcaJsbPK3qUxGw61uHQW9MmabTTD50r?=
 =?us-ascii?Q?odnOPl6qU6U5erqFAsU034WIZXGs0eKbrTs6L75jDx2wHAmRhjXWI2PKl0N2?=
 =?us-ascii?Q?entHR2WXmVIHJZYoagskpplWPVZIERj5Y2YYn/pUGrTBIGz0hn+imq0VpPxG?=
 =?us-ascii?Q?HXYILMwiFUhddPAXdCbTaxjMatMmlNJQCPfq08Uc2tKYGFP03kPMkgz4GGRO?=
 =?us-ascii?Q?vKNUVe/L9a5WlEg/tYr9iDpvXjHakeokZSEf6OTgAywOz4Za9336xo65NQnS?=
 =?us-ascii?Q?brui6iJR3AasT3tlvFwxdF6d0b8REmPsUv+EGVeM/E0H4o7C0BpBanQXtww+?=
 =?us-ascii?Q?ppMhzNzek0yhu0QtpXBJtpFL+SvUhdx4o9PwoQbsn/MF2HT/2r+dzgC711+2?=
 =?us-ascii?Q?kMWzF3dTCatetFuFoIP1Gk5j521Dj6BFqQ51b3p44p6BbY7qlWni/N2Pvw0C?=
 =?us-ascii?Q?NWMBQQ7+p/xfhRkDGuwmZhuGadDpqE6RHiacdb+/qq5y0DxNZO1g1aMM+JBB?=
 =?us-ascii?Q?17OkqMWOwX9HgrUj1GdfRL2EiabetdiwYuZT49kbpqqSWaKKnJEmtiBnAVLY?=
 =?us-ascii?Q?khDxNvFIRUsT6JCWG4HWAsfnYrAkU5hd/NZjgRv1wTkZNa+3i8WkxO5nTReC?=
 =?us-ascii?Q?qsU/jPvXCv4Bnx3BJEvpwgKzJC2LreFavWVdx7816vpX3fnlRDZE5M3igKzq?=
 =?us-ascii?Q?NIKlAol3hZ4sXC6a/y/MRUfXK7qxT2hoTLYx+TsWmJBvA7zupC+yO4yXcZtq?=
 =?us-ascii?Q?bey5UNOAzm5RWLFdHTSIdm9pbwabD8P0LubZj1fTZqtx//Jb3HKuV3d+wjeS?=
 =?us-ascii?Q?h9ngCSEcnoyhYBPOptLsxM5TjNkIsAVa3FWo4lFFORDw4TW8wYPGx8Ho7vrO?=
 =?us-ascii?Q?YX7lKtsb3TzxrPgT3hv7GNpZb2HBt4HfE/F0b9vCZN8QgQjyqslV82Ibl84q?=
 =?us-ascii?Q?ihfCpPZiX7IKbYZsIgQxoyqMk4uNFGeOtGZDOcb1GoWNavRmKB4O0zPg0PU3?=
 =?us-ascii?Q?hDTkTXs3Sj/MKOoGebwJMhZgLHFotzGkuAYcMj3zkw0DDGyVkUlW8YQnHB15?=
 =?us-ascii?Q?zuMuBXRcpIIVT5P0oeiLQzeN8MHEOczYWhr0qRMMLixzdg0XnDkUpFaP56jA?=
 =?us-ascii?Q?Kejn3aK9SZRsiYRh9EBvvmfyUWP8Nhm8i6GenjfH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b61a55-510f-46eb-d490-08dd769f10d0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:12:51.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1q2JnDPaS8I22BkgGKX9z60MS77LaEALVyyAQ+25eAWGDCVE7Dx/tfmBr0iStY5lmEZGyP0qO/L+sJRHuR7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

On Tue, Apr 08, 2025 at 05:17:16AM -0700, Breno Leitao wrote:
> Hello Andrea,
> 
> On Tue, Apr 08, 2025 at 01:30:32PM +0200, Andrea Righi wrote:
> > Hi Breno,
> > 
> > I already acked even the buggy version, so this one looks good. :)
> > 
> > On Tue, Apr 08, 2025 at 04:09:02AM -0700, Breno Leitao wrote:
> > > Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> > > can require large contiguous memory (up to order=9) depending on the
> > 
> > BTW, from where this order=9 is coming from? exit_dump_len is 32K by
> > default, but a BPF scheduler can arbitrarily set it to any value via
> > ops->exit_dump_len, so it could be even bigger than an order 9 allocation.
> 
> You are absolutely correct, this allocation could be of any size.
> 
> I've got this problem because I was monitoring the Meta fleet, and saw
> a bunch of allocation failures and decided to investigate. In this case
> specifically, the users were using order=9 (512 pages), but, again, this
> could be even bigger.

I see, makes sense. Maybe we can rephrase this part to not mention the
order=9 allocation and avoid potential confusion.

Thanks,
-Andrea

