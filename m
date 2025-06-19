Return-Path: <stable+bounces-154722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F7ADFB4D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 04:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465CF3B836E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 02:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED4225401;
	Thu, 19 Jun 2025 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahyYLQTy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A922FE05;
	Thu, 19 Jun 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300708; cv=fail; b=QdIXxdaooj3HIV3y+Wu4weaTgMiB2b8iUjuCPAG8bNurJS5K3OpJ7gGW+vD33mEoQCtWaEvUUyWnBLMfI+c931byWMciS9Dvr7HnnoTSVrtdO1WjfY9hMCu4go7w2biAY/6lLHpWro2AErTtbZqYETfvJWsOV0CLnuy5dpJgluk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300708; c=relaxed/simple;
	bh=y9hDEOh2Txjb5mCiqtrFevjiLx0UFytgJIPoPufTPW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KtsOWn2NIrLa94gZvFX1ICqb5TORpdWhapNhlfyanRgCkgFfRlUeDB/C/OzEURJUPV32MC9AbM4xrcAQSKB+/d4+zMlDUTdQMpkLnhb1jg78OfQleGzUYmI3cx8KV1zz4kPe+Bl7TfJEhii8PSTn3Xs6N0qH9f5jrUukS8YmAZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahyYLQTy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750300707; x=1781836707;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y9hDEOh2Txjb5mCiqtrFevjiLx0UFytgJIPoPufTPW8=;
  b=ahyYLQTy18gK6IdieEwuFp/Qo+ng2zzh2R869weda/qE2dcUmCKbTyzK
   yEaVvkWnXbzjTYRbX+bbHBn4aawcigxQJL71RDWpn8s04BBLfUXq2HIGK
   i2bTgT257XzfE62uZ5Bw17O8kcz12pg02P3lp++58dmK3FMQBfLZ+9e5A
   9yaNlaUqsVVqNd9U4NxW9GoHZHImoY8DdRNLVyKgvbFH3sVU2csvQtxxd
   NUy6cMsmm2avJBagHsyL0cW8aNuJIA60g8k88yvtM6CcIlBrxFK21oqXm
   2AvaRbAzrY5Jq4kupdC0He4lOeJfiRdAtEDAEHOMZnXEPepDHFBCuL+n8
   w==;
X-CSE-ConnectionGUID: FbHYY48pTb6iRZJaW9VLVg==
X-CSE-MsgGUID: EFyMdkV2SVOHKSVOEzn11w==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52408607"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52408607"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 19:38:26 -0700
X-CSE-ConnectionGUID: Mqbusg9hQrmM/tYCYaNovw==
X-CSE-MsgGUID: epPvMpi8T/qY50c3f9YOxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="155923354"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 19:38:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 19:38:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 19:38:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 19:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gl2aAqo912d0WPUGFHPhSudTMen3FoMzcQyjAkf2oXe7aMZ+q1p1VBLB/fqBUkplvpFGymKbr8p2PMtcuRUf//WpB/TyGXuU+7r9MsVj5enbkMRx8JAGRox3y4VRFS31Mz5zcRV+DXv6bHPawL0/X90U83oelV5TEapJYMPm5595ewlDmQDbdv0Sa6gPsW8DIrFacTiFyxRy+fLVaE9uyQYZBWDX4eS4S7l27wHk3gM1NejmcWzUqE0+nwqagwzf6WRXTBEhCTqoGTYAo73SojFhEUMvIiHVPCVAvee1VYsMLUESYLli65digJIj+8SWRGJk13fFjaWtCZs8IChw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd2AGsywvkukAiKfiKeCfmH1dbLdv8JyLz4Ai+NB7yw=;
 b=rHG+kbPK+/Y+J9MkWoIAAGLBbQS+VRcwDVICGkRO00mjtCpATIyreBzbMKXigpXlYB69kq5Xjx1sRnM/a6K5jmEuWt0ANQol4dmZB2T2cNCaWzr9qZaUG+sE+khVAGBSLoaFmmW/afJeglauMp+8l9iU2HfLREnHqUvtGzZTpEkIKzlzbUWnb9mXrYOdZeateKE6fcHov2DMRatxxLyCikN2gXUkIh3pNtVe253iQf8hix0Q899U44tKdRLCZ7OtwhKUMywI8M29QPgHLd0hFdsgit+xx8BUWuzy0drzNcgtHHJn6m6NK03VA3M8eOxlVbszIBxu0dFTyH/Lg0VblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 02:38:08 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%5]) with mapi id 15.20.8835.025; Thu, 19 Jun 2025
 02:38:08 +0000
Date: Thu, 19 Jun 2025 10:37:58 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@kernel.org>, "Chang S. Bae"
	<chang.seok.bae@intel.com>, Eric Biggers <ebiggers@google.com>, Rik van Riel
	<riel@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: Delay instruction pointer fixup until after
 after warning
Message-ID: <aFN4BuzSCXlcqFQz@intel.com>
References: <20250618193313.17F0EF2E@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618193313.17F0EF2E@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: KU3P306CA0009.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:15::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: b3341b78-a68c-4b8d-102f-08ddaeda5356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V988PLpnfZPz2tXf7g1x7EvswXwrDta7da5cO8qAiw6SKOQoeB/qhD0NNADY?=
 =?us-ascii?Q?1mRbNSL7q/JMb6evFYNT0509WCLEoqVcOe3syTa7sadQKeAu/dok4iB1G/ar?=
 =?us-ascii?Q?JjHkZ3kmT3nBlA66ZVAj4dv6mdR7JYhsZ+h5ugkDXQJIVcguL/wGLy0O+Clo?=
 =?us-ascii?Q?KPfs/Ozxx9Hnc7LUz946a7JZA8nJFKmRIBoj9hkhU8A9xV9PsJPfuPHB9hOS?=
 =?us-ascii?Q?Pnxx/nzVqnTBeSGywmepSFi4meOjMmQBKshC60gNBY5TMuS3ONMCoNNL56Rb?=
 =?us-ascii?Q?1NitNGyOgLpbZCppJnEzL+6dSkKInB2Ioy2rORD2rXDpX/Esea+cIQ/9iNRv?=
 =?us-ascii?Q?4Sl/yzcnZtLeCPZrzZ2jhiQmBFEFIQ0zhD1hlMOv1es4NnI+BQ16ocUQQdFi?=
 =?us-ascii?Q?1VgjYUrVvdBkVHKLKPBvDRux2w7FAJCkTudVK3fEvJ4NClD3wgwPmQfl4tqf?=
 =?us-ascii?Q?+8WWt1u/xbHA+bOemHvgRvv7paHpCnLBbvjbwAFcOHJwEYxZx/A+Y/Ij3KQ7?=
 =?us-ascii?Q?+sdwa6COTnR/AlgzXsiU4CAwTM/5+2DyPDiCqpEkRJgaTL/aZrgBflN6uVQj?=
 =?us-ascii?Q?MUFg7YXiGz1Q40j1AGMqty/o1w1M7HbrV2ovtTVF72mf9QAJ9m+kvgp53bOt?=
 =?us-ascii?Q?uPDhNpl/YcRg1jxkNmSx6jhxqAd0U7kpJ0hzovY76je46q2VqDSEAUN/kQGs?=
 =?us-ascii?Q?pZzIi/STnLQBJvC6cil0/eEDTfY8zyxysHUVEBneRmcjTMtyy6nf9zuGmRol?=
 =?us-ascii?Q?USgC/qxwejyhxbPQrREUKhzJkrnwso8+SivnAFLasf1LX3tkUpzgC7hFEH/r?=
 =?us-ascii?Q?TnGE5pAhhI0viFp50926Otg0btXC4hqfKcSfm9m7KbiQqqIF8HHlZfng3GJ9?=
 =?us-ascii?Q?c1EbF3us8AV9S8j9EABH7MWervNROv8wOGR1QRqD9Sgbf6TRfXE8kO0wvU+g?=
 =?us-ascii?Q?bp2T6480ywxUWDbdCM3P/kbVQhCiTo/xrZW4blMtRz9tVHfPFfg4j4xtrfAf?=
 =?us-ascii?Q?tQPywzPCTJgQZQ/7lfgMvhwIPHcYGzf3MoyZ07NGh6adrCtrkjSA1210FwXA?=
 =?us-ascii?Q?/9fHKwgIBpg5akzKYsSj+xza028ZJTLncNfq/gOZs6A8EimDcKt3Aq/aXyvp?=
 =?us-ascii?Q?3jasevOmr61SuN4vuKoH9hU3pvTgcu6qp2HI0mjJzTIoVoI5wv+w/z+SifOb?=
 =?us-ascii?Q?yH9EVEEzHKqxj7F885YfngNj28aS/VJdkyXIN+jMUVnxJkUyRhttkil53+a0?=
 =?us-ascii?Q?MIFb0mQ2F6YpSIUd7aL209Hct0uBOygSPUtNaH7k5apmPKsJPCf22fL6pKad?=
 =?us-ascii?Q?VT4oND8jBcMd5QVSWUQhkr5VBD8ZSdoDxNmZU4G0Dx56pK2eRqgNkzLIF36w?=
 =?us-ascii?Q?rFyE+uF1rZmHLTAkw33ReuzYZDH3OkRElIRyS61G7HqfMsqdWRJ4bpU6Lcdz?=
 =?us-ascii?Q?LRGx3NPciVE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YOiwKVkva7QnSf48BOnra3o3P9P2qbWLs5vupobiE8vx9bU5JJts2/1C8Kx?=
 =?us-ascii?Q?cWf38xUrPcQn3VrgdyBphXhhhncx26PfbJPhqE+cZYwFDEySnOQQhDYkiAMn?=
 =?us-ascii?Q?nac4VNXnW6QNU8Rk/P7AUDGrQLqqdKMRYpSNMA1cLYmYY1EUxPcjYdOMcmKF?=
 =?us-ascii?Q?1LGOpkbApFChvbG0wQZCgfVey9St+5ipFSe+VGM0qJT/DVQMBXR79mCialI+?=
 =?us-ascii?Q?nxEJXu/2XGGJUEw5jzY67PLF9JblyR8w9EtJYOpR6lCiuQqYqVgSk1r++ERJ?=
 =?us-ascii?Q?11vgudaMObzgDigu5p8EZT1khPGyyHIcuz3PsXRRq+CxqZKtLLt7IkLjbpRE?=
 =?us-ascii?Q?UpfRtpm7LDlnbrn6EkSipECSSEWpNm47imv/cKMvZEn6zHB/WjPy0cm7oGdg?=
 =?us-ascii?Q?1S3emKewt+X713/4JVlq60mmwMgfcULz9o83xD90g+b4mk+O14h6t+Q/dyv8?=
 =?us-ascii?Q?bILUeZjZJxmAa8Q2Vl87SfiWg1AIYoRxQ+J/splPT9q1beSHMSuzH2W3p6mn?=
 =?us-ascii?Q?AT1cPIj+pARLOCmBtoGMFwcieHLqFj/FVBdR0QXPExp1SIzlts4NttZq7ssM?=
 =?us-ascii?Q?PWWCA40zq/5nHIBy4KBYWkC6c5kv/Fot9Rs6LmJ1uTUWmGfv253hgkWxUoDu?=
 =?us-ascii?Q?mDArljgiLOpPGasRz5/Fz3f3/LM6IGFDuRVDNLrE611FHo7CJCro4LLx8uSh?=
 =?us-ascii?Q?UhAOJhzoSrpgTf48kO9TxbzBWIkT3gcthD5vQAGR3tS5NUzFXdBRF/0bnxkj?=
 =?us-ascii?Q?Op+j7aRq2KjK1hV31QKz3JCoVrKv1xzcIGgpFhQOlcpAiY8JMLkaNztpvstu?=
 =?us-ascii?Q?m3D2wcGMoUoLhZaeMwopOeBZMctlyF/ZayIMpJN4gmDLseEF2x8C9t8DIYW3?=
 =?us-ascii?Q?gSQ+gd8DcTTnF6qHdEmuGhfC4gfICUYi6ddNt0fqLwWQH9jmBd0FSKzIeDcV?=
 =?us-ascii?Q?muOdAiur12Gck99faDWTtWNTxzCLgHmNr2MVju7Z3oxsOUuQFzCXCxtZeMCx?=
 =?us-ascii?Q?nVN6MEoupMLtOnOafiyqPPvRS6qwnW0Ql/0O5QV1hKA3gsnMkHv6zWAVmKq+?=
 =?us-ascii?Q?AXJhJEWmSsyLPzHS0Z9G4sKTxVb0xQeVe3xOjtjqGV3iRvRxYj3oOpqmtdy5?=
 =?us-ascii?Q?47Isg2zOaHUNILrLiYIMHUaw0JMZmU4fZL0TO6W9JpdXuUihazzbsQLZYAIM?=
 =?us-ascii?Q?6OGWZs9Vfii4P5yzQSswndxfmufOQXk5DoMGhHY+QraO9gAOCbR1a92rgs+w?=
 =?us-ascii?Q?GPcSJvR2TLKv1loFAL8ZTwyvMqiKDJvHav21e/Pp8SveYNy7B9PBlcMp88zW?=
 =?us-ascii?Q?LpM+DikKn7QWY8tx5njw1VKCfnybmlkqfh476HfLBnhq43urRL5/WE285yH8?=
 =?us-ascii?Q?QVFE4vIi9rOsdDWa/+PwaSWAbV8nHfqOkyCs27ghsTkx1c21JKf4lzr0eDLO?=
 =?us-ascii?Q?IKnuM0uMolwCsYX52RiBbgR8eis8QbHiy3khtZS9I7RVvmWfKjfvl8TSUXY6?=
 =?us-ascii?Q?TwzgZ+lM8or4vMmpJoWvmC9+LU3VnxGkKBJfRTsWB6QaLFOlgyKdozvFVozA?=
 =?us-ascii?Q?nRHLKPddGH1wrNbANzLEqvhGRCC74XvFpj/bQba3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3341b78-a68c-4b8d-102f-08ddaeda5356
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 02:38:08.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa3iHwvtaozjuaSBJgYUqfYqD1O/xbjAOBKjkBTt84wXuuuoYlqZrr7EcaJMcPnQr0E7kiLmMJdgM85mTRXYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com


nit: s/after after/after/ in the subject line

On Wed, Jun 18, 2025 at 12:33:13PM -0700, Dave Hansen wrote:
>
>From: Dave Hansen <dave.hansen@linux.intel.com>
>
>Right now, if XRSTOR fails a console message like this is be printed:
>
>	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.
>
>However, the text location (...+0x9a in this case) is the instruction
>*AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
>also points one instruction late.
>
>The reason is that the "fixup" moves RIP up to pass the bad XRSTOR
>and keep on running after returning from the #GP handler. But it
>does this fixup before warning.
>
>The resulting warning output is nonsensical because it looks like
>e non-FPU-related instruction is #GP'ing.
>
>Do not fix up RIP until after printing the warning.
>
>Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
>Cc: stable@vger.kernel.org
>Cc: Eric Biggers <ebiggers@google.com>
>Cc: Rik van Riel <riel@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: Chang S. Bae <chang.seok.bae@intel.com>
>---
>
> b/arch/x86/mm/extable.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff -puN arch/x86/mm/extable.c~fixup-fpu-gp-ip-later arch/x86/mm/extable.c
>--- a/arch/x86/mm/extable.c~fixup-fpu-gp-ip-later	2025-06-18 12:21:30.231719499 -0700
>+++ b/arch/x86/mm/extable.c	2025-06-18 12:25:53.979954060 -0700
>@@ -122,11 +122,11 @@ static bool ex_handler_sgx(const struct
> static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
> 				 struct pt_regs *regs)
> {
>-	regs->ip = ex_fixup_addr(fixup);
>-
> 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
> 		  (void *)instruction_pointer(regs));
> 
>+	regs->ip = ex_fixup_addr(fixup);
>+

instead of delaying the RIP fixup,

> 	fpu_reset_from_exception_fixup();
> 	return true;

can we do

	return ex_handler_default(fixup, regs);

here? Similar to what other handlers ex_handler_{fault, sgx, uaccess, ...} are
doing.

> }
>_

