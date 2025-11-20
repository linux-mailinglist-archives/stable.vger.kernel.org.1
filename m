Return-Path: <stable+bounces-195208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4716C717DE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 01:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36B5D4E2A48
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C414A3C;
	Thu, 20 Nov 2025 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvV3iF7X"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E2173
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597015; cv=fail; b=qKjDtcazECQIHNF+OX0BWjQIBQK2Ss0oDBnHkhGeyjH4FnD5jBer7Ik3/mE5XGRQPBsOrPKMBWBorc+KfZheWgxU5KUrcENVSUi6RmasduVkAsD4jgxBggIwCO2v+WmDJAXIEA0tm4jxsyi4OP/PNmWFDmGm0cGVRqjaRRxgdZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597015; c=relaxed/simple;
	bh=7TufU24aQulVjvlgNNb5PCeX/7nPz2q2xM4NTtFncXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJeFQvetOkrljeqoTupW0/i+8RBXhp0CZ9CnqYPhoqAq277DlZu7CB0v48HlRqEESjcyJGWu9MvIT7p4+sk0FIpD2HYPCMV5jMyz+qPUZU0N8dm1EUbHgaOAtfRRsvPsc+CUIZxa14Z2iiCFxoUf9s9f/Q+0krP82WczDkIVlew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvV3iF7X; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtSbu0i/N/9Z5Au3n3WKLmZJyG21TspoEXuTmpdn/B+hIHnfH2PAfX6JS4n/rh96ejnFRmOgURffcFJGaYfuqve2JeyVSrZyzGTpQzGSJ54lwRoO1P7h51Tq7ldVxfOBh3qJSPjWl/uU2u/tq/t+TFt8/iCUcf0280kTfsyNVL6AmF9evJqzRGF/JTiWskJd30mflXZ090KcpuaY/Qkjkon73G8RuVmg4GMuxApv9Kpx5O+8mC6ukBwyneaBvepUs6c36fxos9zzMzabcdpwyY3z2bSCbqJzEv/lWLVbrm73lVGz8WjXXCrFfleXVohG0Q6eUIyu+rJqV5kQ6KJbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxL6wgBQi95hsi9NwyQ5dm3ZStjH3ctN395ACBiAeAQ=;
 b=umjMPUKlxEk489dspDVHB/r0aR4YHP39d2rHo8biwBp/ZYtfnXsYXZYbL8dQ4eIllvZSgJc4iIPibHU6lA2nPclHHSosj/3KJ+pZgDqaXq6Pyo3d9g9+RpRToxVuVtNW29Sk2jLijpxeG+2f7fzcJPYPTbytjFJhOQkXNjvWczYZ9+CcowSA4XQT457r+6m0faJQygAPMGfv4+IiwbpSoJfa+pGE5j7O+9UYtgmrodr7EaH/UkoJqC6Y0oYEdKUJg8cKzLF7monupESd+FP4QRWHcpHRvGJEr4DGMJHcvLA9T5iy5IzwZellrcX1UyA3xZjVDwKB1zmBYgpHIaQrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxL6wgBQi95hsi9NwyQ5dm3ZStjH3ctN395ACBiAeAQ=;
 b=rvV3iF7XFmBk5bsqN7OMmytqdB5M7b1ugZAJAbFoaSoHG7kHjbe8+RjZ3bN+R2JZKvfTqz+AZ+/HV4ssoOXXrlNiNoSb3p5QmJci9eO/GGZze7w33RhByt1uAJ+gqOl8yllABKzZr4M8T77K2+EH6DLeX7/qXZ1eoqBA06n4znvs7JXIkyyvXWR5COlvWArDhflvJN9THdqrc50jnlwwqeUO+GrVJxxcFiHFZzuOuS4rgovuusvWSsf7AOwwNexB8mlSWLYINMiV41FkCKeBk4o/C4M3fpYlglTRqrhZqAvWU1B/nQMGBJSYm87UJ1HK7474Npw5eCgLfz+aRV9O0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 00:03:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 00:03:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix NULL pointer deference when
 splitting folio
Date: Wed, 19 Nov 2025 19:03:26 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <F60955F7-CD03-4989-B570-061281DECCD2@nvidia.com>
In-Reply-To: <20251119235302.24773-1-richard.weiyang@gmail.com>
References: <20251119235302.24773-1-richard.weiyang@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:208:32f::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d857c9-f987-4f2f-08a4-08de27c83d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TSvpBa1mXNBICbCkDnmiyD40xWbxPq9Cl7+iNwigxzf0EsRISkS+Hpj8sbmT?=
 =?us-ascii?Q?x9ZpxxZbpbBgd8q3JbaodixM6aOpMwYoLL+eyjxNjGo5e+VK9k86QOq3kSwx?=
 =?us-ascii?Q?IKPRYtQx1YbG0D9MymTBp4RVEJyFfCgaBtrUNLCGUYIkZV2WIK/vtc1Qj9r4?=
 =?us-ascii?Q?txdUjf4XmMQ1zG1tRbugocKF1Vnv6+mhWqJ5Ku5UyhsF0mwsjTsYjcTVx8+b?=
 =?us-ascii?Q?soQtaHqHtJkBGGAkncGotvd5cptSFSWMPI17kQKdKPIUCds7Hjl2Ge84aWWR?=
 =?us-ascii?Q?CgAwwDR+3/6TPUokTVcHM0IGmlSqe2Bf+KyKu6ELSIIrMqDSYHBW+02FhE9p?=
 =?us-ascii?Q?MjSgCNQmh3vFG/CfuLV74DJRTJx+voL1uCFqjj42gZgSEys2fZJByNddMKt4?=
 =?us-ascii?Q?rjP/LNrxgRUnTxwLmiAF4bgPO+yz8NmTy7fzru1cr8ymTUUV6dMT6LXu+uoO?=
 =?us-ascii?Q?qYAkXoQeI2IIM8XrHxGRW6Qliwcl1VjkjwfbNZIf7F2oS4GLXd8dFr6RTRWo?=
 =?us-ascii?Q?Z3Onngb/7CfvzSJzv43aUKDR3nymumgbYaUpaV1AQO/MR1T4CPFvMXnkKddp?=
 =?us-ascii?Q?JG9oltCXZffRUecxwP31HhVor6yZmyrw5Gwp0tAhPK0Q1hNgcvmy1prmsmuk?=
 =?us-ascii?Q?PiilWOLkNcsWqOfNiyaBjQN+jqvX+FKvg7R6IESilbpoErvcYMaYfopwYsvV?=
 =?us-ascii?Q?Lnai4ua2MMnQ5z+tPl3xHfBVIPhnp+Ersw5aNkHvaC4/O1xw7QKXoA9peG2o?=
 =?us-ascii?Q?UbjNvFisPOpUJTsVg+MuKicW/BhzzeDE/IExFYMR+MUwBrO+5wNyDXaxzRio?=
 =?us-ascii?Q?AbRrjqdGPY/CLgvRnrFOvLsRLex/N/p2CvYoX1M29WJB/fVNkSL7rx8cL03y?=
 =?us-ascii?Q?1cBmPzWItWAPxWcHl5QVDUGhmWL4utKXAOqfzXKlOGD9+YcA0UFnj44rCP6f?=
 =?us-ascii?Q?JxSt+tIuUxrBhwqdqye0+d3t6v3f621H0Zn2lA/4fjzZcMBFMlikLeK1DLuD?=
 =?us-ascii?Q?r1dXsWVRNkOVzC/pKK8DPfvWZmwnrcj1/ysyYdLtH7nxd9VoHUY3zPAh7c50?=
 =?us-ascii?Q?Q4BTajZWXj1ly3pLqnwo0+fqVDU62Zj9FdOHSJo9d7aMmeNemFjhG30TVVEe?=
 =?us-ascii?Q?6/oxQK8OPRkhpLPegOt7IQQQAkZ5EKciOH+p8ACwNMbABwuTSBGl+NUON4eT?=
 =?us-ascii?Q?zKPyIPruCy48WcCPnAQ58yduw/IEZ/zYhmV3O339FZS3PHatOfR3XWasmVRO?=
 =?us-ascii?Q?reycE3kJnP9yS3eJJsbZQzRvLJMDRWIK5lJQfd3LHJt7RvfDeYp47Qn+SF3K?=
 =?us-ascii?Q?RSARLJNZUzFHW8V/UvbJxyjGXihZN62UysKgHV0Ww4M/QFgS1OypVpT+N+H5?=
 =?us-ascii?Q?S29yzHp075uv331lI+AGRiMME4AgveiXyVnyHbOvWmLMMy6SKl2dneW6SYM2?=
 =?us-ascii?Q?uEN4ARgb0/XsMyjKRSxw5g0lNgKPSO/j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5gRQjjtbLUQYeN+kcB4HMPJMJhsB87SRgSF9DG5YKkKxeb/XJuR7KND/sII?=
 =?us-ascii?Q?7Kiw9nlaUa+FFyNmTQac90qn6hbWjvuON0UQbhSVE3OqYS7XtKbniBNUS6AW?=
 =?us-ascii?Q?sXt6xPjQXh95stNuFKHtdQ5YFKuKJP7MUhIJJTLBSm7OqiDTMpAjKz0fYH9Y?=
 =?us-ascii?Q?8njDoBV/8iSYIoFAoStP1g/oyAd2UFVunmh1fGjGZshxv2h5GgKApWYkQX48?=
 =?us-ascii?Q?LorZE50RllCJiFZyA9CRc/xXwxyfytK+3kQZsuQflMrz1u0k63Jl9DyqqTHQ?=
 =?us-ascii?Q?ubprRn0FezB09WSQeVCdAd8wMwZ+wS4vsiR0gOPsbCeX3v2OrI/WTbVdk3aM?=
 =?us-ascii?Q?zzPjrt+8dJqHaMGkv3mhFoKD/I722LttPpbzMzXcz4SV0pqBYVY6fdBkLY+/?=
 =?us-ascii?Q?0mEsJRuGl6giuQh2HFld4KcIutsX5Pw796mIWsx6+TCjMZx7nSSYUqs2ntK1?=
 =?us-ascii?Q?W6IqFzCTOvoi/bKEr0VOEJm8WspIB1berJxNF7dz6gXFNZyJhyorneTLCsXY?=
 =?us-ascii?Q?/EseZK9mWABLu0+cQrrYKQVlGQUYCzYcTG+ZceP0fOSy0qexVIV+o5j3xkxl?=
 =?us-ascii?Q?FsjgS0zLfnlrPktlhJLTzRrhQjkMqcAzSYiQr/hhU5DZLtA99KGWCHL+yfOj?=
 =?us-ascii?Q?WvC5sSd8fUO0JbYChNoYQ81oYmiIEWVlz+npo4mqPnIc/V7cpwZ8+wzuJT0X?=
 =?us-ascii?Q?pl2IYMx3RxsVVPzghEYNRCTGkDIWKNn0E8BxPdOxZZZ0WSRuItb90BNPqc9T?=
 =?us-ascii?Q?51LzVDRZITfwVvViZkhsorTcKwK8SBK/fkZuLoh5kJogMN2fOAC+f+3jOT1t?=
 =?us-ascii?Q?BzP8aZsHsgk+ZOsJSyFTlpeD/INrhTOGv7fP5PSWXDL8cqxN6An2SNfczDuB?=
 =?us-ascii?Q?2tzOX+/H+EOhcfsUD61JD5PqoBk9wa00sTEDyPPorhwaQjH/GCXKtx9X5AXZ?=
 =?us-ascii?Q?C3zq+IZPo08l+D2VPkwvbfe/omd8rVVxeRuZwhqH9ypoBJMa/yYN6SuBAKeF?=
 =?us-ascii?Q?gdgifDdrpVTRkQQy9F4tzhsioNovzcKVfO/GD6M4yGLDQ7BFc0NxXdd3KbpR?=
 =?us-ascii?Q?t53FDjOIutd64d8qUQjGjj3g19FHra/i9Jcl2RKXr3oK8e50i9HPLD+tZEea?=
 =?us-ascii?Q?Iek2pserPwY4pBEP8uMrPLS2LPyLGdBdwKOeTxHEZL/iJJ///YYamvqwMtRH?=
 =?us-ascii?Q?GdON4XvIBSfepS15vVKHudAn2Jpy82GHa1Cz5SIDrhgxhx9pj6RveTekY7HC?=
 =?us-ascii?Q?tD/bvCp9wqhnO7TLnzekXlxeWt0tRDdUiqKJtTk5vMUfu1pyi1Hig9LuYpmH?=
 =?us-ascii?Q?DzCwZuSm6dEi7CHCkVLSL2YMMUbJUFPnQ83rbOIfGyiRHEUykLVIuembMzfs?=
 =?us-ascii?Q?de2j88UWI+82zl3Y3LsgMw0HodlRNqb36GdiOj0XCqCjAS+rGKxvarew4IdI?=
 =?us-ascii?Q?Xm9oLvZnfjhD7dnSxc8cSAZgw+x/b06SK1Hzr2ErZVaAmnxP1NzpheNa6uH7?=
 =?us-ascii?Q?LBI9fD2a9/I4Q+xGWZCafmykfgjCCPypD9NdTgln62UWX4dejWCrF7g+4Vfw?=
 =?us-ascii?Q?OydzvsXnzaDD3zhFnD94OMh1SuzieiKhnYgzXLiR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d857c9-f987-4f2f-08a4-08de27c83d16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 00:03:30.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cq9HzQ5KYEZhqTqTd4Kl2LOvYUOgfL+k+Tt4zHIP+bv3lYFKPE1C406g6FGRLZEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828

On 19 Nov 2025, at 18:53, Wei Yang wrote:

> Commit c010d47f107f ("mm: thp: split huge page to any lower order
> pages") introduced an early check on the folio's order via
> mapping->flags before proceeding with the split work.
>
> This check introduced a bug: for shmem folios in the swap cache and
> truncated folios, the mapping pointer can be NULL. Accessing
> mapping->flags in this state leads directly to a NULL pointer
> dereference.
>
> This commit fixes the issue by moving the check for mapping != NULL
> before any attempt to access mapping->flags.
>
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Cc: <stable@vger.kernel.org>
>
> ---
> This patch is based on current mm-new, latest commit:
>
>     febb34c02328 dt-bindings: riscv: Add Svrsw60t59b extension description
>
> v2:
>   * just move folio->mapping ahead
> ---
>  mm/huge_memory.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>

Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

