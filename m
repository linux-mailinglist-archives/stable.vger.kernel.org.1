Return-Path: <stable+bounces-59144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572592ECC6
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED70B20D2C
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0416CD1B;
	Thu, 11 Jul 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifJGS5VE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304CA42ABA;
	Thu, 11 Jul 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715530; cv=fail; b=dK4TpGVrzaxcQuVBMV8QstbxA5hV9TTIqR9NsK8VcXBQf37O+9B8vmsw2yRZkFoNYAuirEL9sRmZ7NJScB85DjVD6xmVP8plJI1sbO3kxYZ/gkSUO0FrhH4xEJUn2MDP7OorYxmYYWV8ooCMex6GLvhO7kWnoVLTlAbSt4QUXXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715530; c=relaxed/simple;
	bh=mz/KCdwkLA6hnDundYULrXmKQLV6OJ9tEiD7ZOMhUE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leEHPl9pzCwdRfLwhyQib8SAW7JvL6BAlyLE1XKQSIC23f2xuqMqS0uOvejXQQkglLNYAqqP1FijpwR31Kmy4Lm+UmcIzjOi5RHIf2YotIoaICSWSNVpZ1nH8X0IsRd/a7UWX9Nj7eAwkaL1eT6CXvKXreHFfVnqtv2TgrG57e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifJGS5VE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720715529; x=1752251529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mz/KCdwkLA6hnDundYULrXmKQLV6OJ9tEiD7ZOMhUE0=;
  b=ifJGS5VEWPSOxtXiJz4SvQ3+k24aVBo4xrPb2JxHsuVyYVoUrnO7C2ut
   nCFY2RVTRRPbiKdBx/7YHcS6icrue+C+L8fKaOch1JnLYSWCLgkwfYK2b
   hKBr8cUPkmg/3IxCG0P46NZ/hvmdpKF3pdD9tErvJT6eNJEqaSnilGG7k
   J0+SEYY56R7B4yWGIkKWLcAwVKd2cprfc35lwxXVGfrEGfpxHyDokcBCt
   CWryYc9rZ/HCiKnyoRVUgtsPh8nO0nSttxmvbMPWZXfSLEY44V+s9Gtce
   kmzgI5SKMYQ6VJmDy3CFbX59DCYBU7fiZZeByTrRzOwvX5qI3OnA2dH4Q
   w==;
X-CSE-ConnectionGUID: ql7BABWWRxWSJNzhEjo2SQ==
X-CSE-MsgGUID: h64R+31vSxynbeTS8/HHPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29524803"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="29524803"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:32:09 -0700
X-CSE-ConnectionGUID: NnuWaM3zTSi6OOVeucaIEA==
X-CSE-MsgGUID: I4pzAGfzQvKgjXGPbCBsWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48596362"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 09:32:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 09:32:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 09:32:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 09:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdfITsKV274ZbAd4vx0GAUVMvkNwER7aEkx0EO2YoaiRJAJZwpChqCmpSspjIP0GYmdvqtgz6jUb6r1EIeFpQMlQcpn+FcoG91b1Gu/1QrHKe71t2XKAH/aXC/HOMpTRbQT+0h/s6T5/clI9gtuXJgrGS0fIrqFyJ9bUi6sl1AfeF1Rv6/ml2BDD/PAzyWHRLp0MlSKUKPE8a4gIm++Boz5NnjpIr6poOpuVbbFJ1NvHjNAU1i1lqa1OGp/gjZXinUjthKb3R1V2lCeSuUQ9cMQaYIb10FheylBJjMYPrdCF9mBgl0fcG7gYS2g+jOVIXgSgzdWEmLxLD29LLiUUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feMTzHLyMfKq6GHMoAKqlRk5i7OqUhl7qy6omP+PmQ4=;
 b=GFDc/AdD1LF+Po2Q6A0bVjW7Z+cNL6pA1+PybEhrmiMaq6bM5ZwQCSdvflXMb1KdExrt8p1H8ZaHoSMHtfLFrDUj9e6BeHovFQ91ux9bw1fpktUnXQkL8vs4X9FS4/+XYmMSZf3C+nXGCFM1DtuInkUDrIwI50tcVUbAX6ruSQzUHOqWEs08w2P22XkryS9j0V65KSxqfVl5X+TDneCkBaxUz7zbyLB561xf5ykwIR25RGlvFmfodP0MicfsgxdYZUVbr44IjhCcjwoCbFgqY7XiQQzjeclu/p8p+q02v6rIt+xvLFcc0OTRVV3stsnYeAcFjql8HzZupAbF6RRZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5149.namprd11.prod.outlook.com (2603:10b6:a03:2d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 16:32:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 16:32:04 +0000
Message-ID: <f62b1946-3b5e-475f-8f28-8d44dee28bd8@intel.com>
Date: Thu, 11 Jul 2024 09:32:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ks8851: Fix potential TX stall after interface
 reopen
To: Ronald Wahl <rwahl@gmx.de>
CC: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240709195845.9089-1-rwahl@gmx.de>
 <8e4c281e-06d8-47bf-9347-d82107f00165@intel.com>
 <2a04f707-3b97-4ca8-a10b-15c3aab5fc29@gmx.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2a04f707-3b97-4ca8-a10b-15c3aab5fc29@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b35d01-7304-4856-9dcd-08dca1c6ff63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUlzOWx0aXB2dTIzRGxlVjFlUElGaXY2dDlDakl1V0V4MXNHTnQ2MCs2TjVr?=
 =?utf-8?B?c0hOT0JZN3pCcDFuVEVsRFR4bWJ1VzcrUWdEWmRVZ3hXKzIwdE5jYnNsamJ6?=
 =?utf-8?B?Y3JXTTljZTVTOHo2V2tza2dOcEp5dCtwbVZCUS9nSi9ydTF5V3dFUHp2TVJ2?=
 =?utf-8?B?U2dyUmo1Z2dzeEdEZ0xtSFdnZXV1UjhFSmc1aGE5V3UwdXRtZkdKb3pVWkxx?=
 =?utf-8?B?cEhCbkZFWlFPa1FaVE5Ebzd2ZzFFRGZ2d0JERE5wK0hvVlpDb0paa3hwT3NQ?=
 =?utf-8?B?dVgwN3c1QXNDZmZTWGxHVWZKMkFJNkF0dGZtRE1NMEhtZmcxamp5Y3czVjhK?=
 =?utf-8?B?U1VhUHJPZXgvbEhQRGdveDNHNGZZZ3ljb3JXamxtNmV2UE5DRlg1RC85Z0dP?=
 =?utf-8?B?emtWLzg3VnY2cGw5dnBWY2tNT2FoOEMwZmZRZFBnYkFmaW1qc1UxUkhCQ0I5?=
 =?utf-8?B?aUNVQURaL0pzdU85aHdhSklCampsaU1aZ2RMQ0VDeG9XY0pEOWVEVkltS3gx?=
 =?utf-8?B?Nzl1VjlDbGVNNEcrVDg3dGpWQzY1azlrSXUrajRMZkdDL0FjdHlxSDRpZ0sy?=
 =?utf-8?B?VDhnanBPY2ZDM3NDZllZeFFvRmRtSHBFS2hoN2c5VlB3RXA1STE3dk9HSkRi?=
 =?utf-8?B?akplS3R1VFdWVUxQdGU0cE01dXI1UHZFSzhydU9lc2ZubmE2RTNiQnJLVmQx?=
 =?utf-8?B?KzFHT1Z4ckVmeDZCVXd6czY0bTFGcWpUWEhZbmRMVGdRVlIwS0xVNkJtZnlw?=
 =?utf-8?B?cWVYdTlwNWtyb1VpanRCaVNaSkJJOHpaMm94NkxKY2p0aTRCK3JWSXZWVnAw?=
 =?utf-8?B?dzdQNURHUEdQbXdiOGpxVUNkQkR3Q1J0cVVjc29NQlQwTURzWEdjcGg3VDBz?=
 =?utf-8?B?UEREWDR1dG5wbFVsR0xSeS9FMHc2ejhsUjlqMEd6cjI3bEU1RTRWTWN4TEI2?=
 =?utf-8?B?bEhDc28wbmJrM1NNYVpWMkVsN3VUL290OVgzT2w5eE5mWXdNMjlNRFFmS1cx?=
 =?utf-8?B?RHdWYUo4R2o1VHBITGRPVzFPNHRiZ3cxZTJOM1BVck12cVVyWEptbjduekhV?=
 =?utf-8?B?cGlEbm9EMGt3L3BFSTFodk5XL0Y5YkhsYjFOV29SRjFLc2pWVHNHemt5ZzAv?=
 =?utf-8?B?VG0zeGxOL1ByNDAxbGh6M3pMSVcyTWx5c204SnRDZ1pseWp5R01Ya0Z2MjA1?=
 =?utf-8?B?NHF6NUI4VjlrR0RiREd0WmE2VWw1V21qNVVEU2NWUDR1UVdkb1FlV09NMmc4?=
 =?utf-8?B?RWYxK1RLWEFWbzNzb2Y2Tlc4ZXM2YzlNWTNJMEdSVUIxTE14OVo0MUh3emgx?=
 =?utf-8?B?eDVpNDM3YmJVVXloZ2RhTHY5cGtxMlhnREIrNjRUREsvYmkxZ1YwT0VpSXNr?=
 =?utf-8?B?OHc4bm04dU5QWEx6ZC93R21yZmwvOFN3Zjd4SVFORFJBUzJsMFRFVWxjN0sr?=
 =?utf-8?B?bDh6bVJsczB4MktRaytiR29YOE9wY1VvT0N4MVF4bEFTSjltZnJJOThnbWU0?=
 =?utf-8?B?SVo2MlhyMHFXUFBLMytubFEycEhJVFNYRWZrVUlQYkd5UFk1VytjZUdQSEt5?=
 =?utf-8?B?U0EwK3UxN1ZFdngxNVhad3ZlTkFNdVRtQThObVYrRFZkR09GUk94ZHVmM3lG?=
 =?utf-8?B?cEN5dVRLTmQ4N1RHam56bnJmdnM1YjlRWVVic3VkcFU5YWpPQ3hUQ255YnJT?=
 =?utf-8?B?anlndXQwbUlqMlh0aUNVZSs2R044bEt2eHBhc2kxdlFqY2pNQ0hOYlJHbktB?=
 =?utf-8?B?ekVJdGZCUG1FRXh2TE1WSDZvTHZMWW1KTURqdWpzUURYcW9VaCtyTHdIYU56?=
 =?utf-8?B?ZkZGYzh2S29YaEhwZHRMZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdTaXBVMUl4M04wYVYwSEtXS0U1YWhCM2hUby9tYlcxV0VtSkdVTmNUdmVY?=
 =?utf-8?B?YldSc3NmeVdnb3ZkYTZTc1Jyc3d2bGdKR2ZBa0l3bGFjMUszcGdjK0NsVHZS?=
 =?utf-8?B?LzFlREozMFlBNFRJK0lKMk5seXZxbDdBSFRJeWhzYWdnMk5ndnZQeXd4RndY?=
 =?utf-8?B?cmU2blNCZ0U4QnVQczRZa2xmTlhXMlpBTGI4elE0TVNxSm5SSFYzTWpNbzcz?=
 =?utf-8?B?QzJyRGpZcWEzRUV5bThDKzRiai81Q210RlQ1aGdKa2xHV3U5VlBCbzJRTHA4?=
 =?utf-8?B?K2Z5cjAvbWZWUlBPdDY5ZGdBZExtQktmMSt0NC8vb1lueVcvWjJuZjNZditJ?=
 =?utf-8?B?VHJEYXcyYVpPc1V4eng0SzlWQzhjeGMvSmNwd1NjTVFBaUtmWW1zWmxJakd2?=
 =?utf-8?B?V05nZHI1RW9TbXpSS0MyUkNrRlZ4RDY2ZVN2Qml4RkJGa3lCWDdPR21VbCtV?=
 =?utf-8?B?U2FJRWptM3ZydlpjVFFDYmx2Sk5jTktGalErcFZYbHg5SlVwZXJVVnVMR0R6?=
 =?utf-8?B?K0VLWEk4ZzlOdHZHSmpvOUJhN04vakxVSVp6aUhla0pLZVJ3bzd5MGhVTGVr?=
 =?utf-8?B?V1o0NjNUNGY0TzhaMWNqNjBwbk1hUTVuZjI2OXU3SG05cFlDaUlVNzNqM2I1?=
 =?utf-8?B?UHVLdXRrWW1XYklzK3IwNU1oVXN1L1F0ZWNLVTU3WnhMU1lvOU1pUjZRVjVo?=
 =?utf-8?B?UlJ2eU9mUXNKdWVPZWVkZXNDckFEY0dKWWdRZ2w3VTB1NHE0TXFBYlFmNC8w?=
 =?utf-8?B?MEpCMm0yNWZwenVSU1VxaHRwRllPOTN2eXhwUzE0djN2QTNtTlpBSzhiZFhk?=
 =?utf-8?B?RnBiNU12SG1WdWF6VzRsMFV0dmFqbWd4Um83eUJVZSs3OG9wNUxwd0sreGZw?=
 =?utf-8?B?K1JrYW5uZU0wT081WTJxL1JZOWwvVWdud2hDak5QTlFKRTROTzRtV1lCMllq?=
 =?utf-8?B?eG1icUFLOXgrc0ZHR3UzNmFSS0Vwa08xcHhsbnlYNDhJdXRtcEp3YmFlS1FW?=
 =?utf-8?B?QXlCdVMyQ0VOa1FyWVY2ZDFJSWpDeEwxaGdhdWIwbHl3aFc2R1NzMHVMelpJ?=
 =?utf-8?B?NVRrZTlYSE80Q0VPaWhOT3RVSy9LU25ZOUhNSERidWV4SXVTaXN3TEJWRW5Q?=
 =?utf-8?B?ZFhraFAyazk4ejI5SXpNZ1J0dnBBWmxzWWxoYm5QUTgvQTBoayt3OWdJOVQv?=
 =?utf-8?B?cGYvYUM2MEJkWExRQm5BNGc2Q3hQVEpqVWR4c0dmczdyY1dHNTRRUmtrd3FK?=
 =?utf-8?B?NUN0OTZ5emJrTWhFM0JDeEFadWJ2VENZZ1RJRGhrN1JPZEF0a0Z4STRnTHlV?=
 =?utf-8?B?dHZzWmpJTnhIWDdvcmJhY2hYclphTTZaZS81bTd5cHU1ZVppR1lHOGR3TG1K?=
 =?utf-8?B?aTc4K2VOTkh2LzFWd21iNllvcWpSaHZRdUpWSjhrODNRdHArNTZEOWRvR3NQ?=
 =?utf-8?B?OSttQkh5VDdpaGpNdVBiRVBMaTF5VXpnclNNNmM1ODlaUkVKSElCaEIvVkJt?=
 =?utf-8?B?RXdvVHdJNFRFdEdUMlcyRGJKME91d3FxM21LT2ovTTNQRFROanAybnZzUm1j?=
 =?utf-8?B?MTdsNXNMdkpabFBVZEtFdXczWGYya3lSLytTbE1sM0IvbnQ3ZE9SUXVHTTFS?=
 =?utf-8?B?ZW4yOVU2THNDcE5iLzI4TkFUWncxZW9PS0grUDF5M2piTHIrSXNhMGNTQ2JQ?=
 =?utf-8?B?WnJoV01WTnBoVnk4SjFQOXlYOUw4WlBNSHZnbmV5Q2hrM09rbE9VUVFyRjlh?=
 =?utf-8?B?NlkwdXFiR3owcjR6YUVlOHg0VlN2djZ6Q3dUM01ucDMxeHpxTTJraHpGeFA5?=
 =?utf-8?B?N3dIVkwzcmdEWE5ac2FSeStncHUvSU9qaUhFRDBEams1S1dBaGhNaFhHUE43?=
 =?utf-8?B?aEVOWGpYYjlqWkpMYkhRaE5DdzVpdzZ1aitjM082OVpGNHcrWlZGUnc3T09U?=
 =?utf-8?B?NmpXRFVNdXM5TENyZzgzWFg5bFowM01YamxDOEhNaks2VHQvcGluSGk4clJp?=
 =?utf-8?B?K1VFdFA4TTJpOGVJT1hyczVsVEdIbVZBS3hJZm5UUUZqcWV2T1hQUC9SN2ZV?=
 =?utf-8?B?M3dabmxqZmJBcCtod2JxbmhsTkZIRStJMWZoVmo3UERJNXphUVFlL2JJMGJo?=
 =?utf-8?B?c1FWb1E0S0tRaUZJWEpVWTRucklEM1FLbDlZMThJNTgzLzcvbUNZdTNRcm5Y?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b35d01-7304-4856-9dcd-08dca1c6ff63
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:32:04.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zTNLAdlHQE3HQiQL7jdHjq8ZNpxkOFv6P7xzl+MSYQKFiKv1EtDPwjuUFutyE/EDrdrwpfAS9dKTev6vu77bnSdX85nLa1c+w2VKMjJP4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5149
X-OriginatorOrg: intel.com



On 7/10/2024 5:20 PM, Ronald Wahl wrote:
> On 11.07.24 01:48, Jacob Keller wrote:
>>
>>
>> On 7/9/2024 12:58 PM, Ronald Wahl wrote:
>>> From: Ronald Wahl <ronald.wahl@raritan.com>
>>>
>>> The amount of TX space in the hardware buffer is tracked in the tx_space
>>> variable. The initial value is currently only set during driver probing.
>>>
>>> After closing the interface and reopening it the tx_space variable has
>>> the last value it had before close. If it is smaller than the size of
>>> the first send packet after reopeing the interface the queue will be
>>> stopped. The queue is woken up after receiving a TX interrupt but this
>>> will never happen since we did not send anything.
>>>
>>> This commit moves the initialization of the tx_space variable to the
>>> ks8851_net_open function right before starting the TX queue. Also query
>>> the value from the hardware instead of using a hard coded value.
>>>
>>> Only the SPI chip variant is affected by this issue because only this
>>> driver variant actually depends on the tx_space variable in the xmit
>>> function.
>>
>> I'm curious if this dependency could be removed?
> 
> I don't think so.
> 
> The driver must ensure not to write too much data to the hardware so we
> need a precise accounting of how much we can write. In the original
> driver code for the SPI variant this was broken and repaired in
> 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun").
> Unfortunately we required some rounds of bug fixing to get it finally
> working without any issues. Hopefully this was the last change in that
> regard. :-)
> 
> If you ask why only the SPI version is affected then the answer is that
> for the parallel interface chip there is no internal driver queuing,
> i.e. it writes a single packet per xmit call. Not sure if this can also
> overrun the hardware buffer if the receiver throttles via flow control.
> Since I do not own this chip variant I cannot test this. In the end that
> could even mean that we would need the accounting for the parallel chip
> code as well.
> 
> - ron
> 

That explains why only the one variation has this value.

Thanks!

