Return-Path: <stable+bounces-176726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CBCB3C19A
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 19:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5570C1C8032F
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A641221D9E;
	Fri, 29 Aug 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T44B9IST"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA48334707
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487737; cv=fail; b=PULZ9F7B0h6FX5+u52Px5037Gy0KhZhTFKwLPWvgzUL1miy3R+bpn8DeVU8MB7CJUiLTDfrYlPI8sAV2ABqSFvzEBzZXGfVhItzeTuhdQd99sAHuGSTFUpn8/34GswueUaz8ARxIALs6Zsp33wyj1RFNWB6TnOtnesUoImURpQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487737; c=relaxed/simple;
	bh=Mhndi1bC+VKMKOL8P+xJbUKfatteXXO15xxOG8oYZfs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oneTgvVd4+Yji18a5EZJfjEoA6MOzMa023JTIZZNCZj9G5A37jqLxzgqSIbvYDmTaiLlSZfIts5Gbs2fkzSuxRggSMlj7PyGQ7DduKPyG9D+b0kJS3yH/9in5yRJL8G4XzCZNMnbnsw+w7j87KvLwzJMPZFU0SdIUX5kBd5Rrc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T44B9IST; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756487735; x=1788023735;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Mhndi1bC+VKMKOL8P+xJbUKfatteXXO15xxOG8oYZfs=;
  b=T44B9ISTVooAFMgx6OzyICTsCrFOQRPMMoPAi3PMR1yDpIxotJCeMLcC
   g/Gv0zqKeZ83PHdQL2mCTJ2lWu3iYzVoO0BGnDy7Wx+mkYDEJt7deUdf9
   MgC69WGXN56fDTAda4jWwvkBntLLemOQdA5hi94NR6q2mZCCPEebJJYe5
   zD5bMVdK0Pzvo7LFPdPZuw1UpvkG5DRozCvUJUO37j1/1fL5h0XdSqit5
   3UQLIZGvdsVJot4+56OOJvPoN16Lbt3QImaKEzG3o7oTMP1jFGmMQk+oI
   aauhSYQK1V2X3O0AigSau/aH8tQGHXwane8XJ62PLQtzq4mowpzSZLJd7
   Q==;
X-CSE-ConnectionGUID: M7vNSHZ1TAaAzlLCHSLGoQ==
X-CSE-MsgGUID: oAMqGm4MRCiJwo/JA6/IWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81372200"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81372200"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:15:34 -0700
X-CSE-ConnectionGUID: w3e0j01WQMiG07ySuFsBzQ==
X-CSE-MsgGUID: TRBq4U9ESRiUKtOyL2iZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="171230395"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 10:15:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 10:15:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 10:15:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.85)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 10:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvlFoC8Qhypu/Xd1Ef8Kh6+Avmg/kkiQkx5aClkL9FSPCPoi9XNus0f1rWDwEinPZaHTZ2twr2rxKYM5ohP7MeNKm7AEFfY6Qat2ZUnZg/ehMO3pHT3DvEKBkndeR0iLcohBGAobDzw7VNyn3NnI73cxCxmQJWlXX6Jcd45EgZEIDXHJOUnOmWycBxSmlsm9JFgVBE/5+wXRBDyfRFNg0sRptk01Fe+EFWLi2yarthmiU2ynTU+GHgOLQ+1JSg8+d7VaA4acdfDIGuWCOztXMdDHsJ60as6Uz0YlkR9PBgtQe3j1ecCDdG54wOjC4t2X+sqhTPE3xpbdIF/7vFH7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Djb821aMzxEEIpL35BmdnOFY8oUO2qfKEaQ2lYx9N/Q=;
 b=d799z1gPPbOtNX49hijX8zeZc7iOtkVUSyF7NakT3Mcj0qlNZ2E2mac69+nW4WcOJX9Ka+1sur6desxawO2+8X9xWTFQvHLJwd27d/nvcDqFVk1bbGtjWT9pYrgGjDumY/v6PJTKNM8GG5vYy24JkQVdZr7zfEFoAqpyb6nbm58DOqPw1imrYed1ZDXnyuG96jv/EN4XTZxCdx4NyMOVyWO1shRFAMKmd1KLM394GfrwWWyMCS2t2odevLoYtOTpHRySz2Z81Zecpuf6nqdlaxVEAQupoenshxmpzfmjl2Hir39k60DbdOx4CTE2YkQdtb/M1WzRqgx2iN7/WM5BFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by IA3PR11MB9304.namprd11.prod.outlook.com (2603:10b6:208:57d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 17:15:27 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 17:15:26 +0000
Date: Fri, 29 Aug 2025 13:15:23 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/3] drm/xe: Allow the pm notifier to continue on failure
Message-ID: <aLHgK7edrKFfGIqw@intel.com>
References: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
 <20250829113350.40959-3-thomas.hellstrom@linux.intel.com>
 <45929eb2-bd6d-46d3-86a1-fe4f233d3c70@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45929eb2-bd6d-46d3-86a1-fe4f233d3c70@intel.com>
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|IA3PR11MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a227b2-48a0-4dcf-e710-08dde71fa5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lLbmsxTk0p6qD8SfNx5ronzHemWWA3AOIeImxnpN8P+64b3UrIO2j0GB1w?=
 =?iso-8859-1?Q?utT8X0NW6ABa76lnNksmXDuLV+JEAvHSmhRGrUBea3c65CNQRApc/LY8uG?=
 =?iso-8859-1?Q?ghe08wlrw8xd7LL57itv8W/eKdskK03U5WcII541Q3IPWD2s6nvA878FIw?=
 =?iso-8859-1?Q?Bah6JFqu2+Ug3iAwi56MR26wfYk+4bDHGi/PPeFthGoYCNQEwiyw+8IV9+?=
 =?iso-8859-1?Q?VmYjipJ93B1XnrTJw1XFePZKO2KrTAC8BjV3vTc2POjnS0qYVd6f4EWwjx?=
 =?iso-8859-1?Q?NOBjFAmVS+30NUp/hdRGeVCf6VD+PgvHWryr7ggOCP8vc310RBEDTMwSrk?=
 =?iso-8859-1?Q?wKVBuvTYg1vruvG2ikavYAjqEdR8SKr4cMCQI6yKmoYSqbCH2JZ8+r1XJM?=
 =?iso-8859-1?Q?pzKdFuC0dGi7A/oS+DElhpC8C9xovJH3tNdQL5SpekkVAvQmjCRUih6fdq?=
 =?iso-8859-1?Q?CkBqh9ptzjfxGUTkZjnDllsFj0Bhqq0fryvtzyudwV22UXYgfN5ta/do3Y?=
 =?iso-8859-1?Q?/9un+tKe1DFr5nmojaxb5ZRPEHRbVTO9bN9BICIbMlMRWK1GjMCj7UT+/G?=
 =?iso-8859-1?Q?/c1ZHntstguFTts4qlVakK4whd0zstIOpjG9b1SRTAWOJtt+cbshJwwJqm?=
 =?iso-8859-1?Q?+lkuc7TaTTzFF70C3MoLSE3ITSOX/KrIB8s0YrhvT9CNpIj1k7+uZLKRSF?=
 =?iso-8859-1?Q?k7gqSmLKhnLTqsbdDwZNpPZSg00NDk3Ypy/wInev+V+ZEF281c6Y4OeBdP?=
 =?iso-8859-1?Q?VWRo3+TWkHepw7HzlSqX8QjJG0duWmG8dPgocCg+WGYw0vEjen4zAZR9wb?=
 =?iso-8859-1?Q?jC8DWBMY4IyIUyXTbCryaGwCWXEEKs9CWlfI4KxzZe5jTQ5xvGsy8QObtd?=
 =?iso-8859-1?Q?knkwG0yV8mUD7daQJir4eVRl1x9ftIchEuaqS2kQTbzVvaX2dvS3pmWZSk?=
 =?iso-8859-1?Q?F/DKBG+Sg8ZXlZ5GtvC8FVMhmHpIb0GoMUHwhdjaV4uBaQDevJtAhTA0pX?=
 =?iso-8859-1?Q?F883QplFu07TyDCeZ0ZlMRuhTx/6ECTBnlhftUQ/4PRUw59hEDhoKmzzW4?=
 =?iso-8859-1?Q?KDWInBMR+q/jJoyMg/sygfZlW6QHdv0EVBOFlD8VeStGZdtslX86ZH4nAW?=
 =?iso-8859-1?Q?0sp4CKi7eADPXppddDR/+o0MyhsqsTv/fdlWCM80uYqP3x6pxmkekOCXrc?=
 =?iso-8859-1?Q?KzSZ6cH9Yq7cvj+D2p0pWypptU1hroaL4W88xOHSFFO5+SqhJa8/TNW0e+?=
 =?iso-8859-1?Q?aTOiRvuWdFiFnsuSxLxlIqreUpys9BPCNvGw3arMJ46xOavlmrOKQ3JBve?=
 =?iso-8859-1?Q?ieuyRlonsQ4CmDKYE0XRnL5Yh7ficgdGtIWuiXeLfaVQNnvgC6eEVKNW9s?=
 =?iso-8859-1?Q?VFu/maaj6+LnT1eQB6/AIBeZi/ucRp52YNrS1A6VQ8QeJKVDFjv3QriKFC?=
 =?iso-8859-1?Q?Xc7h2Ct3Eff+vZaLdB8kWej7Ilsxt8MNn7gPr0ZJ5dJDUY/Xe+imnu9Zck?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?s0x2Msc4owoZemCDzwlJK1ZZIzPghohNh1CuvfmFwP4csa2w9e7VFLYA4a?=
 =?iso-8859-1?Q?Nb/b6LE97kHQYulHeqsaCLQBfL/0FO8nUEjzK8hzV6MrSNQfQiEzuyDPEb?=
 =?iso-8859-1?Q?RY5owzQRR1Qe+Z2OLWIPX4kwrRA8E6Xd405oF+u/7K4AbWDRuER7Av4/l5?=
 =?iso-8859-1?Q?eTaAq/BWXAk9Lu6MnNyB4XPwyQ3WKeb9PJzSL8fdPmwXU21OdPM4Ow4AlS?=
 =?iso-8859-1?Q?StFf201T8mJKtEdcY6XL/5/gh1UG8URELXsAOWfba+JSarNTt41I8vnPni?=
 =?iso-8859-1?Q?Fre0pCfV9vWDeXyNoFvRClz1TMATzZLl89HAC+CqDxxbr54YwmEeGv2/v5?=
 =?iso-8859-1?Q?hL0oPqOvHGM0GV24ZrTYgmXSu3ERVfIuvIQaAwN7rIRBLwb3DptYTc5Zbx?=
 =?iso-8859-1?Q?jvqCbkelu5QQGE2dFHS7N2O7Xdgh7hCBdPWBfHCEh3e4BAAlJSTYPmrAUm?=
 =?iso-8859-1?Q?57mzO+ZCwieAUq2woicp4YoExod6ZMPLDDUQ1P5t1nYtxb6kc6ZdVzso7Q?=
 =?iso-8859-1?Q?F46me1z1/SLjXZwunYj1kiO2h+ZMPhixq9iCJeLaoD9W47FMV8F9UdBl6I?=
 =?iso-8859-1?Q?gU3ranxn+kiQomXLYUYFVFTAQ2HPl4gvsaKg5uGcsLd5NS+32bfi6a1JCp?=
 =?iso-8859-1?Q?JWXL8j1kIsOzQdPKVf094qRhBSWBUe8UnUkgB/LZx/FRpoSFF0zA//tXpP?=
 =?iso-8859-1?Q?FD7q08OyoiD87/1uLro7t+766oMjgssLIN/ColfiSO9rwtfyuziP2soBEX?=
 =?iso-8859-1?Q?paJjqpXJV8RSvgL2Yje5s7bJUGILAyzEWjzQi5Tur627qnT8asCqGt4UGC?=
 =?iso-8859-1?Q?+aTaYSg3sX14AyYBESFuJHPh3+ZZeAsL7YHIfp+DG0BlhHa6AkXIiDaDN0?=
 =?iso-8859-1?Q?qyZtE0o1g4l7HvO5xBi7UTquqv7sfo9ySn095kmxA2Ue5QKKWs586eaDLg?=
 =?iso-8859-1?Q?tbc2eiySrcfvNzHXj/jQ7iFHKf4du8Mownc0LPy+IuwqEi7zh8qTn0q0nV?=
 =?iso-8859-1?Q?QNdW5UBYMod3E8+Cp4a4XEYEsg8OT+gpbavMH3qyvFv5UaXjudLsPOznra?=
 =?iso-8859-1?Q?4EZuThFIJW6oABjYpigo54rwY2yvEdql6s1F+eMCFrVd6IMXe1MzsiDNQi?=
 =?iso-8859-1?Q?mRkp1gyDMJLZiHtJ9J4Ye9+Ika1A7l2lnU+/SWruDOMDb7iSjPbn6JimCV?=
 =?iso-8859-1?Q?NhDs0I9rWa5o200OKVWH+6J7BjACEPOuMjTkx1mp8NpLvZ2bs1ZNFx2XoV?=
 =?iso-8859-1?Q?H4dZEXrLn2llHnUetrDu1jsUQvWW0ysbmi+J06K8J4FZjdtsPMLTB3r36J?=
 =?iso-8859-1?Q?kfgif7CfNkly5gUmY5BELQhdceYY29ogIril1gcqhu0GXLmQP2YhpwRjaX?=
 =?iso-8859-1?Q?Jkx3WnR4g1qVQctTUaxVTJXdGpeYDZFpjd8IIBHE+QhOpPK42LGTBKX9JN?=
 =?iso-8859-1?Q?ThV2Uc7IQgIUqYUqf9oPRfx0hLZYnxdVguQbv755ruavFEZgLSh1b8Rrx3?=
 =?iso-8859-1?Q?y0BnGaHgivk/EZaRPEfmlecAYh/rre6uDeWTWgvvjANbDMQwCX4ipM/kCs?=
 =?iso-8859-1?Q?c3/vNYXMf3teN3RzJ0eaDiaObsZ5XiUjLVxwuVRlt5VvVzYD2YzVRm5Ttu?=
 =?iso-8859-1?Q?IPghdTTEiG1E1pW3alqAVzjH5ogZS5jPPdWL64BSIgbny6gNF4zeD6+A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a227b2-48a0-4dcf-e710-08dde71fa5b6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:15:26.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hMdMWKbMA346uSY8Bd0csyy8RpDH31Seeas4e/YU67VBOpXmTKK+ODTuiyNjnaZBWgzHJW3JWMhxzNd7nsp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9304
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 04:50:01PM +0100, Matthew Auld wrote:
> On 29/08/2025 12:33, Thomas Hellström wrote:
> > Its actions are opportunistic anyway and will be completed
> > on device suspend.
> > 
> > Also restrict the scope of the pm runtime reference to
> > the notifier callback itself to make it easier to
> > follow.
> > 
> > Marking as a fix to simplify backporting of the fix
> > that follows in the series.
> > 
> > Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.16+
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_pm.c | 14 ++++----------
> >   1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > index a2e85030b7f4..b57b46ad9f7c 100644
> > --- a/drivers/gpu/drm/xe/xe_pm.c
> > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > @@ -308,28 +308,22 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
> >   	case PM_SUSPEND_PREPARE:
> >   		xe_pm_runtime_get(xe);
> >   		err = xe_bo_evict_all_user(xe);
> > -		if (err) {
> > +		if (err)
> >   			drm_dbg(&xe->drm, "Notifier evict user failed (%d)\n", err);
> > -			xe_pm_runtime_put(xe);
> > -			break;
> > -		}
> >   		err = xe_bo_notifier_prepare_all_pinned(xe);
> > -		if (err) {
> > +		if (err)
> >   			drm_dbg(&xe->drm, "Notifier prepare pin failed (%d)\n", err);
> > -			xe_pm_runtime_put(xe);
> > -		}
> > +		xe_pm_runtime_put(xe);
> 
> IIRC I was worried that this ends up triggering runtime suspend at some
> later point and then something wakes it up again before the actual forced
> suspend triggers, which looks like it would undo all the
> prepare_all_pinned() work, so I opted for keeping it held over the entire
> sequence. Is that not a concern here?

I was seeing this more like a umbrella to shut-up our inner callers warnings
since runtime pm references will be taken prior to pm state transitions
by base/power.

However on a quick look I couldn't connect the core code that takes the
runtime pm directly with this notify now. So, perhaps let's indeed play
safe and keep our own references here?!...

> 
> >   		break;
> >   	case PM_POST_HIBERNATION:
> >   	case PM_POST_SUSPEND:
> > +		xe_pm_runtime_get(xe);
> >   		xe_bo_notifier_unprepare_all_pinned(xe);
> >   		xe_pm_runtime_put(xe);
> >   		break;
> >   	}
> > -	if (err)
> > -		return NOTIFY_BAD;
> > -
> >   	return NOTIFY_DONE;
> >   }
> 

