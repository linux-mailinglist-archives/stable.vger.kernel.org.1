Return-Path: <stable+bounces-119724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C68A4675E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD07A1A36
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2C21CA1B;
	Wed, 26 Feb 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWBwzDDL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BD258CC0
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589460; cv=fail; b=IpIzzE9pW64jHH2aHLSVHg4MnGMaiIIIwoZTpjVCCS0zV5iR0bMUJ3kYgHlSiDmh0dSMqA+YWylXpxyFwg20LfQ+Slurg7zdbiyJp5UMnC6lUIwFhBtaxivX/cDPl6RtfGnYgzLQTq+Ke4cwNz85cXRu4WpxOnCJoMIuF8kBLic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589460; c=relaxed/simple;
	bh=ACahJJ4urr0fGAy5V59GFxkptyHUtuxTTVCo68m6gJQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nl6gUfgIO25d8uZPUrJ5Ed86bFrinuQZCn7gGVnwww0+s6NA0PHBgsimRHWUpRXb6XpRe2CA0duR6IDgFjfbcQeRVD+6kbX/kxdGLUBZa+NOD/0Xleka0iA1tHeBpfI3qedGqXeQuyhHpOT8589UyyNnV4UhEMzgHjNprvCfyw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWBwzDDL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740589459; x=1772125459;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ACahJJ4urr0fGAy5V59GFxkptyHUtuxTTVCo68m6gJQ=;
  b=EWBwzDDL09bnp5+iDdoCVSvqV1aukh4Siwc7dLvDVDwHeN0rX3GfGYbw
   PuWW6o+UqcdFiTtrym1gAO6uLZvK0LqX8eSCf3s19XhWAi+Yb7NGwDP67
   8zF/SetqyP0Z6SfYOnxLpQ29uxINvbKvS0mSWCA9hqZq5LvZZESTz0zIw
   IO49yqDShWMA8eARWTQB0h1UFwn9t+j638V4k5A1aVJNmMTKHtc9wROQq
   T3MDXtGANEfbyEkjv4O8ancUH4bZTGFCFnUADlcTKP5hurBeBqqVWKLhg
   LBu5fAnzcepm9VnNd+2tf3ZvAJ7F66ZWoydzO0xrGFnKR/c2MA1VSUt3h
   A==;
X-CSE-ConnectionGUID: cw0mLtpPQVSfH2XXwNCJ6Q==
X-CSE-MsgGUID: 3q8OKwFST569HggUnommVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="44272425"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="44272425"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:04:00 -0800
X-CSE-ConnectionGUID: z4ysNapgTASyhGgO/8GKnw==
X-CSE-MsgGUID: gx9xAl9jRjyLfohl2Bsy0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116792187"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2025 09:03:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 09:03:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 09:03:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 09:03:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9QuCVFH05bTfgl6/uDxfiybgurccvOGUotGqFntykfLcdDwxeweN5up/Flvxacqn6TLHosOIrkWYzCzpgoMZLR6qVe8O/BAKjWfpmscWBYSIntyKB2eA+Kj2b25ZzjUablIaCXYOkNWhCyKZJDeTdGyJ5gR3SmboUXqgnUtJDRcSgDcqjJ5WjEpK7P4vorXOve0xuZApnYsL59qU4WC2r7LSjoxqMisfyoXDNBcTVNwxjNTNM9xxkt+MBagsvjhelSPAY0D3niwIYZECYYrwdjwJduZDlx35O/XGGW2rT2kojf0hrMy4A8b610RL/EUbws8PFeFwuyD9y8NeFOV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjxoXeeTWRHZr97HKQjump0WpabReY1S0od/KUVf2dY=;
 b=YUiFa355ftK1zovuPJGEDFeOafo71tXf1PCulYftuIFuUJBwMeusCBSxfvoHEXw9xiVqLms6VySzgUQIAOTsG3bhRQFftL46/djCmKgRNwK2kecQ/E68EUV8UmkUnuDKRCWTc9GmB4iCCKmzdL0tBwBpLfpzRppOfGUxxp/1Z2TcKy+GKUesWHeIROs4aAiIibQjcM/+qVyQjYp8j4USl3G858pu1qHTDEMKrmoPla1QdUhYJeoAntCp/zyfJbV5OtJ8zjhUavW1U3IWyU4M6LAS7qQ5j1tMPeUab/WpWvEIgjLwtDkQfag1t0El2cXBhmCfNkydHv5V7k81vinFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7664.namprd11.prod.outlook.com (2603:10b6:510:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:03:51 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:03:51 +0000
Date: Wed, 26 Feb 2025 11:03:47 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, =?utf-8?B?Sm9zw6k=?= Roberto de Souza
	<jose.souza@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/xe/vm: Fix a misplaced #endif
Message-ID: <oaqo2dknpg3vjir2zcjs3vx2utrqknt3uaydpwbavu2oamwn62@5qfunom5hqno>
References: <20250226153344.58175-1-thomas.hellstrom@linux.intel.com>
 <20250226153344.58175-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226153344.58175-3-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: df115778-194f-45ae-cfe6-08dd56878b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EzpCcVQBrDO0Lj0UWD8vnTe86QTFFpgBZVRk/YDI2TMzdtr5UOzJEZNIQV?=
 =?iso-8859-1?Q?/3CcYHAp9qs/6zTZW8NKpoj8uc6hjjoNTpxS8L0nVHS/nnOBc45X8Soh/6?=
 =?iso-8859-1?Q?A6p9XItMe5QrzLl2itrIXpGhWH+iJ9vwxKCPjTKQPOtDSfUUmYPysPzHuF?=
 =?iso-8859-1?Q?mub3owrJnWxBIdrDz4RyWUBksCJmYaK8Kyi/uYF+SFldyNLRJwehHBopnJ?=
 =?iso-8859-1?Q?oYIZN4k4cfRHeZqg4OWwuj7hDkfviHhn1DGMgdDzJL9/ePAzYjfC15H2Ft?=
 =?iso-8859-1?Q?XZs+TWrv5pICyViWx4Jv94GRMW7dbQuGR25l611rL952Jy5ZsaizsqAu2B?=
 =?iso-8859-1?Q?rlSAvgq8+h91b7H8prvWM2CVtEXuhphsqP77vPsar4WhrPp1qbS5phWO+I?=
 =?iso-8859-1?Q?RTBtSYaxF+mrIYuPOoSOoaMuFPCU7Pj6WGnXO+eOCaS0fAYtVdd5nRkhsU?=
 =?iso-8859-1?Q?B4CrAbyrXI5ugTJbKPDYG3E790yfa8SLvBWNbBpaw/KvZalKtfyIMOBlus?=
 =?iso-8859-1?Q?S9CTt+rHR0scBhfdmP3jzuB+Dc3sisEk8DuvF0gm3vyoHLs0VtN8wVkU36?=
 =?iso-8859-1?Q?9EfXg11rHd4APno9LbAQZyRaCITC8TBrFXORLi5BeCZDUqhDybFcu7R2Ju?=
 =?iso-8859-1?Q?QjqOdd4qH9uLO/aHZkDyLuwzwpieux7a0I5rpJO//WESDmJHOgg2gL/+eV?=
 =?iso-8859-1?Q?zzw0CkP+oouyZ/VPOkrmrQLGUqi6N6uWn3GQz1sO0kQE/Ay3iadBSj0kQr?=
 =?iso-8859-1?Q?JJ2tpRc+rWFwJzru372gUBA1Lahbs/SqMRiZ82qM6GVVqJ6f6iQJh8Q0Oy?=
 =?iso-8859-1?Q?k45cbqD3MV/amS1+JFd7SdKZao7xZQNCD7eANs+MOR0SxwBkKa0pyUlN/x?=
 =?iso-8859-1?Q?vybOiWp7VjNGdF6gTg2hMhJZ6uLvL+dAgXrppk3wEDIlxLn3KsryFxmMDx?=
 =?iso-8859-1?Q?bwGFdAD9zfXEiKD9w79kMsEuatvTJJp23zu001B2qBduktZttjfST73pgU?=
 =?iso-8859-1?Q?v3+HzAPSTLiIFaETr/u8blAX1OAuyr0KH7DDkGEOh5FwiC0knpGqf22gqD?=
 =?iso-8859-1?Q?Hhfa8gjC5syERLt44DHviNNfVczSgYvGdxQbAYRip64tFiHvEOAQC8SqwI?=
 =?iso-8859-1?Q?ZdwEvqNS4WJi5+9rgpSJmKCZwNQuWnQJiWlFuyOPdbnsj4LNq52Sx4hXgs?=
 =?iso-8859-1?Q?Jtiw5BcyMHtXGQy6lbIq+fN+M/leNtMIxeZd0lGG+6cc+cbMV/Rfoztne4?=
 =?iso-8859-1?Q?JfbPUx52QVBqP0wlySBpZS793cXt4mL35E8fXXbaAD6Uims501pRlnzijk?=
 =?iso-8859-1?Q?DPI2BV/9JUHrfwVj7z3DSYDZdCHIEdsEpCIb1VCZpBfgUgc/zPXD7mFvTi?=
 =?iso-8859-1?Q?Enpr/tl/qP1kxI9k5SBoLMjyhWTJ6YJqgKCvjosx3cYi+2bjmMlNCl8J9H?=
 =?iso-8859-1?Q?06ekrvZF4P2xc2of?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6g6atdfQ2d1DSg5NVRNig9qNza++fvUkUskTekOWw8kH0sAGe0uoQJlIvF?=
 =?iso-8859-1?Q?iw92y3sD2kx0GpqCr7gSbHtuIbg54Ngmu5FpG89p3ATsSYSWtsBQaFgidm?=
 =?iso-8859-1?Q?F+drosQAwJ1e2+ppj6Ad0xqtMr9GwqYujz7jrvcb0YTmc0wAplRYRW71YR?=
 =?iso-8859-1?Q?fR+/wjq3yZVb0XaglKVJEccsd+q1E7uAsc6MEQUObnceM9WM6tf4y20+IY?=
 =?iso-8859-1?Q?52+MwfL7IETiIO3+ogvUeskhofp5ejPuSoQ6SNcBXr7s8SQF5xmSAZiz5o?=
 =?iso-8859-1?Q?mVzKAD58+X/08efr1xTeHe6LkylDmro/ais7VN2+lhiM/lr1fqcBzxqaIw?=
 =?iso-8859-1?Q?xOFLs1SDUfcOXLQQj/KxwLGgk2FsDC+CuyAx1SFdhTnLfpTXc0MNERt/Lp?=
 =?iso-8859-1?Q?1dZMUHIlGQm4Q42vB/OpD0Njw0ysz/rQ9PjRooyPBJjigozC03it7KyP+0?=
 =?iso-8859-1?Q?y5U0PjvcUuobGlFjZ0NxKoFYpI/A1Zd1hblb+a7vKVLEyYqEfkYHfpIaH3?=
 =?iso-8859-1?Q?yIOOY9M3gLyM7h3J7OLEm0Qo3WqmXdov/fBuN48FlsqOt686CR7kpZVBiQ?=
 =?iso-8859-1?Q?eUNHN0ttstcjQBobum33ql0Unc+JpdOI0Ss898IjDJNZnor+CFScoHenZ1?=
 =?iso-8859-1?Q?JjzmDYL9JlcbLjFASnjjFnGGYuLydNkQU2oMqhGqqkGBiXRp0bnoxUmTCF?=
 =?iso-8859-1?Q?Nwd+kyN0LVzoq7MFkx9QM7KY0Ey8gNeIvU8Q2sY7Xxp3+v8ZMzEcqS7iSf?=
 =?iso-8859-1?Q?ZI3XUE1Qp1CYtvskyb9OV2RawZgbeRHl7FNmFLtX0a4ZT8OIzafTgXhMzs?=
 =?iso-8859-1?Q?CiTxdsq0rcTckn/uUncA+FjBL/tpgGXfTvCZTqm/xu/QpycqarGlvFZgYl?=
 =?iso-8859-1?Q?VMNDAGHY+YpIyPyIP6T0M/EW1GkHU7fQIHT1gQISnxArUUGPpQKA/C3E8O?=
 =?iso-8859-1?Q?87p2bZUWrRz9f3c7t4h/Lu1A7Q1trVr0sQYrg47BLOl3BrSXY1k6TClQVS?=
 =?iso-8859-1?Q?+3rS1ks7P92CVGAyTs9/2yJNvlV48us0YRXDVjREriwmqUJzJ5IjpSPaOI?=
 =?iso-8859-1?Q?EOafmvmGedbYlB3MXoXekS4VqvZhoxupu00Acr8FHywbyrq54rPF/qD0e8?=
 =?iso-8859-1?Q?TiY2lOzCLPOP4gj2jPcogEkLHvph+rrmTER8TkMZ8/+1jKAz7rDjCE9RM1?=
 =?iso-8859-1?Q?M3XdjteqJVoYdFK0jl51Gltj89cGulZFdhHnQtY58FVmm2Vbuq4t91q1Ll?=
 =?iso-8859-1?Q?CMSdXMyuNW8PYB0ghArL/mYMiAXiZGMo5odfLC/2cM9wAxuoFjZkTi451J?=
 =?iso-8859-1?Q?Hw+kWd4Vv5J8smTst8hlw8FASKLNAZLAxNGYh7q9JlgBDdgYlauS7c4/bc?=
 =?iso-8859-1?Q?FKuLVhq+gnIP5k9Fl52r0ZpHpzZ0YEVg2IImAgWXl8H69R0YmtJsIr37wo?=
 =?iso-8859-1?Q?mhsBrdPM6g1Wa7qLE0Ob5PIMXrCEPlPtz/KenYv0aSkublhZpsc8a/Zcws?=
 =?iso-8859-1?Q?bSKqdDRUwG8hFQoFzuLkK6FGdVQZXRPnmOVOf1u4jNY4Bx0q7+Izu7pKAr?=
 =?iso-8859-1?Q?qw6FDOPJgMl28rLuMCYpXp63yazrCsGlYzHbBflF1Mw4bgYWnMOUwaOoHo?=
 =?iso-8859-1?Q?+PvsD7I9HfbmJaGWqEkSa//pX0e9fb1wAkim/iwdipxUpNlS4VMD3Aww?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df115778-194f-45ae-cfe6-08dd56878b1a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:03:51.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reyr+u0BkuKFWzepcGtNSFX1Y4yNL4NLoFW27lVWfgZtsBi/kPUCpYFdGo5U5A9CNmfWBDL3zQt9eyP/btJp90pKQHuyGKmmUknyA2VlqDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7664
X-OriginatorOrg: intel.com

On Wed, Feb 26, 2025 at 04:33:42PM +0100, Thomas Hellström wrote:
>Fix a (harmless) misplaced #endif leading to declarations
>appearing multiple times.
>
>Fixes: 0eb2a18a8fad ("drm/xe: Implement VM snapshot support for BO's and userptr")
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: José Roberto de Souza <jose.souza@intel.com>
>Cc: <stable@vger.kernel.org> # v6.9+

not sure if it deserves to be propagated to stable since it's harmless.
As prep for patch 3, maybe just do v6.12+, but up to you


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


Lucas De Marchi


>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>---
> drivers/gpu/drm/xe/xe_vm.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
>index f66075f8a6fe..7c8e39049223 100644
>--- a/drivers/gpu/drm/xe/xe_vm.h
>+++ b/drivers/gpu/drm/xe/xe_vm.h
>@@ -282,9 +282,9 @@ static inline void vm_dbg(const struct drm_device *dev,
> 			  const char *format, ...)
> { /* noop */ }
> #endif
>-#endif
>
> struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
> void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
> void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
> void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
>+#endif
>-- 
>2.48.1
>

