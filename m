Return-Path: <stable+bounces-202906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CECC9ACF
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 23:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339FE3030FDC
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 22:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0630FF27;
	Wed, 17 Dec 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqocpGAh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A2279792
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009617; cv=fail; b=P69RIApZpMkApNFEoSwMYJ/B1UJJzkIQ4IwT4SWKL4b9uL43qTUHdLHUa7gRbzJVKcv/s6qV5l45Lt7D5SXPA9HSo+0AcnHEIZmMq87kNPkdvXsdJG09PwGiCkcWS6dCruE2mNA6TCgCYNNwZVKY2Oy1G2Z9SmzzQ9j3oC9gXZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009617; c=relaxed/simple;
	bh=zqm4THTvV5Pr0NWFYpcYxISFnH9H9rOkD6slrhpDB9Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LknEQhMf09SuVoKSkuS8PONn6iW8iGcK0yY8NR6i/un4RPcJrbSJakRT03MJISgodqKFzNR594GAK4NmsWiCbripswOLeKAfn/cO8VTvIj6Alh+R4DF+ZoVemdZM9HwrTvwW8pTrLLbkqqLKkFoggISxXQfY/FthMzMdCZcnFAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqocpGAh; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766009616; x=1797545616;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zqm4THTvV5Pr0NWFYpcYxISFnH9H9rOkD6slrhpDB9Y=;
  b=lqocpGAhuGkhJAIYImdvJhuGz2tj0DBOB0anK4D/u2SmZH/9zqUyMQny
   R3kj5ewExGCe27xPuAqmf2eOzW6LQYdUe58pXbwLs3pCUTolnBXty1HLU
   iTZrGBUFHg0anp+a9y8lGUDtN448v/SziiiCmFlb/uGup+Rm8vVgEJ+6B
   D7U2SrxAia83w3SxuCn+odija8c4bvlgya7GaOPAjzSncNdXATPGIGlAi
   +DjWgs0l2zaLNlS00ZDixAY+ItHmr4LtsPyieIOwzgo0PqCuCsilG6WnU
   Jo0flyYutrfLPU/qXWDqs/CwnQnQ73GmDH9O4IF8omROWcs++Hu9NzaPe
   w==;
X-CSE-ConnectionGUID: cJWTz9LwT1eTntlTI8n4mg==
X-CSE-MsgGUID: RU+A0n0MQyeQAF2leWv2FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="71817610"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="71817610"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 14:13:35 -0800
X-CSE-ConnectionGUID: tde6AVRZSPqPVmbWCcYkVA==
X-CSE-MsgGUID: BHwuSPRNSN62ZK9K65zrrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="203313171"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 14:13:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 14:13:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 14:13:34 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 14:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcD6Fn3tHPJ8wAWvMjc2lDllFf6BquUz7XyiCD+DS3V7Xpx4NIq9TIbnjme1SFv4pEo4oFevvXGgdBTyBSYFTfyiU34VsTQ99TTZkY2rpH1ycw2zkJ2EDGEWwRWly5pVEYTKVHOx72DYxENMB1N0Ykl0W5EYTQb9OdIG8DtDmejtf+WmKK9Th3LlI4/oYWfKj/J/SsLTGNiUp5HjunVRx61VbDkTMSzLH8rMdRNvVlxGEa66jhnA/2M3s4ZRc7FeTkH7eRyZnzKXAWtfscAXXTp8Tlt4xfQsz8C242AOC92FwoiCsSJf+Hbnl1s4dJ60vDShH8ty+x0JZK7sx5qxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5MFQarVrHwBR32vixETfaAAPaFzaZaBzNLKjJehlOA=;
 b=f2Q3G5V7h77kOzDSp4gMxXdmIbYU4tW5CvrCWN8wYdAuzi8mGPAh5zbMoDCCzafSWilRFAETRDzm+w0xy8XOsHmEDElGAn/KR2p1Pi/jIoVcdO8H8NASA0DI8kLSg0RomWDqx/aaSv39BgCcuM5lR8EAAHsp+hJmmx22Ix2SutHAk2gRkPlvk2oLlLaXO9D1yj13dGpasD4E9waWp9R97oBErOzYeU8smMI2vkv8w6EBkQDHaPXfJUUaeeVFnbRld0sQPkfkDuB7+4tEzzuzPSw09sExZPJNxIFN0G7UAFrfumyJfncwhkm6heC9oU4glytzaGgR0qdLvezOQzXWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CY8PR11MB7170.namprd11.prod.outlook.com (2603:10b6:930:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 22:13:31 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:13:31 +0000
Date: Wed, 17 Dec 2025 14:13:29 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Drop preempt-fences when destroying imported
 dma-bufs.
Message-ID: <aUMrCWcaHZSiwJh8@lstrano-desk.jf.intel.com>
References: <20251217093441.5073-1-thomas.hellstrom@linux.intel.com>
 <aUMQE1wZd4k7j2Kw@lstrano-desk.jf.intel.com>
 <eaf85643f5296ea93c68201d748d64e8463887ed.camel@linux.intel.com>
 <aUMe31rH8u9ws2UD@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUMe31rH8u9ws2UD@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::23) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CY8PR11MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c93f643-4077-4b1f-f592-08de3db9832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzV4WllNbXUwVFRNakxvVXZGVkZZK3RpNlViWlBwVWtDN2VkYnNXTFVObnhI?=
 =?utf-8?B?QUEyd2VVbGFiOXBUbXJYMGZiUTkweE9ORTlIYWpsSC9mUTRuZHlSR01ITFdr?=
 =?utf-8?B?L2p0cE9uVktqMkRJeFFpUXpoTURVV3Nwc0Z0TFpUdG5ZZFZ2bGJqVHdUcGRy?=
 =?utf-8?B?SGhqR3J3SXpuNHYwMzZSUloyMDhZMFBQWkp1VSszQXZTYUROWjBKbDZ1L0hr?=
 =?utf-8?B?NDl5UUNVKzRHU2ttNnMwOWhPMkZHZnZTMUpEQWxCWWtqVng1NEl4KzVBUUJn?=
 =?utf-8?B?OWwwMGd2YVFjN3ZiMGUxaS9JTU4zUnNPTWlzVWpBRWg5TkVJQ2V0UVpqZjJV?=
 =?utf-8?B?eFBLQk53VFBUc3IyQmZMK3VZejl3SmcvTUN0OHVFaFNsS0pWaWVFQkRqYUg4?=
 =?utf-8?B?ejcyM29yYjBaRDM1YzJFZjRiMkEwNkpRV3FhRy9PZzFhcmhFNUdJVFdNckdJ?=
 =?utf-8?B?eTBoRGVIOEdrOXJGN01PUnJrb0tBRUw0dm51a3psZDhlb3RIWHkwcjY0cVdh?=
 =?utf-8?B?c3IxRzFVcmtwQ01MVFhMQk5vbjUwTS9jOXRmY0l4bDNLZEplRU9ia1pvM0h0?=
 =?utf-8?B?M096dWU2YnpYSHBYeGVyUUNhUGpuWTFsYnNzeUpWOHVrczNCQ2M5Qm14Qnpj?=
 =?utf-8?B?SElxWXc5SlRHWEl3aHVXNlVMZm1xRjE1ZHU2ZzByZi9oTnB3L2hNeGcvQVFw?=
 =?utf-8?B?dHNNOWZBM3BESDQvMkNvUG9tSnBvUXFXcFNZRWhzdTV0aHB1bTArcXdLTnhL?=
 =?utf-8?B?M28wSU9jMzNkUnB4MjNLL01wclYyL2s1bENNYzRqTlU1T0Jaa2tweGlualN2?=
 =?utf-8?B?RERZZ2FzelBXS1hpSUNnOTZNRHZ3ZUNuSlRpYUs4ZmllcjdpN0dBb2x1SE9R?=
 =?utf-8?B?LzdnT21lQ2dBZU1Udy9BMjllVXZFSDdZWnYzbTRHb05sbk56MlBRMWZTaWU0?=
 =?utf-8?B?VmpqUCtacTVpQWtqZC9hVjEyVS83QTZhU015ZlpVYm1ZdVlkYThXby9nMDNs?=
 =?utf-8?B?c0pVSytpNHQyNVF6cTlPcjlDcE1oMlY5V1NTai9vMUFRK0dxY1dGUGtBYkRU?=
 =?utf-8?B?VXNZYzFsekFSUGdaZ2cyd2diOERpVjVTcHdvK1hnV2xJdEZxWU4zNCtiOEty?=
 =?utf-8?B?WEx1QXdwVi8zUm4vWkhpNEl5WnRaWVkxdWRla0RqaXZUK29lZWZ0SDEyTDl3?=
 =?utf-8?B?WFE3cTIvSHJVVUF0T2JPK1pNVUxUTXJpcjhPL3h4UnF6QUh5N2VHMnpwOUY1?=
 =?utf-8?B?WTVxaWN4djhhb2Z4bldzV0Z1NjdjTnIwZGFyRHBqQ2lndlVKZTlzK3NVYXhT?=
 =?utf-8?B?TFlvRXBjck5mcHRnaUhHakZZemt5eXltQXVlR2h5ekpvRUlrMnVVenNDOVNp?=
 =?utf-8?B?bHhEenFkWDdmVlVoRkpQNjlSZGNxYU85eG5iSFExc1UzMTVxaWlOYW4zUmJi?=
 =?utf-8?B?YTJzOGJaYngwczlyQXBkN3hOVmYrTU1Mc1Y3bWx4NU9tWTM3TzFZQVFCYlZE?=
 =?utf-8?B?Z0xaNGd1ZGxHNTVpZzEzUUdmbVNFc1B1RFVLREFkTXY3ZFF6ZkM2QkppUmRq?=
 =?utf-8?B?R2RPVWV1VC9ldW5oVmpCdlhBMlUwejAvRk9CcVRlN0lOYWZHZjh0NTU4amJP?=
 =?utf-8?B?Y1duMnRWd21OZksvdGh0SDdwMkNsYzRmNWlrK1VaUmlEdUhwSjE4U2h5VWw4?=
 =?utf-8?B?M29CTkZ2dVptak5aNWZmb214dFRYK0ZOMTZpSlN2YWdYZDVoNDdINTcvVXgz?=
 =?utf-8?B?alRRckhrWHhaL1FqY1FjenFWbHZYZTBaZmY5TmNBNHlSREVNSFYwdzNHQjl2?=
 =?utf-8?B?T09ld1hqYmRQZTlnZTJaK3ZvSXRpMDdiN0V3VU5jTjVmYXNkTVlHTmV3ZXdx?=
 =?utf-8?B?bzM4cmR5eGpMdVVJbGRxcEdjWGxkMXM0WXBSc0Z4bnJENUlpU1N1em4xQ0JD?=
 =?utf-8?Q?yrAHdQ4Z5NvkQl101iNgwnv8bpYO/zTo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJwTUZnTzc0ZEtxeWFJcFh3SGgrWmtQcFdMMEp4VGUra1JxMTlWMlhsdzBs?=
 =?utf-8?B?bGxmZll4SStxcnBtbnJkSllZRkU0YncxdzJBcXJ1ckxuSmpsS3lhTEJybU5K?=
 =?utf-8?B?dTJpeGkwWXRmYmJTK1psQVc5ZXpIZE8yeGZPay9haE14ZXNYek9BRmFLU2pC?=
 =?utf-8?B?c1pnbG1KNml3RC9QRW9LelpMOU9jMTE4bk0vUThKTDFMczFWd1V3S1hST1FK?=
 =?utf-8?B?TDJyQ29uQjIvWWx0ckJFMGdnQlplbzB0cm9DNkRiclBkMFlEZXpKc2FhSDdp?=
 =?utf-8?B?TWtXTGhUSGZuNW9NY1VtMVZrOUlhWDNJRVBvQ2tvU0FQbG0vVFl6TlFYVlNn?=
 =?utf-8?B?NGNFZzhzcnd2a1FNSm1HYmdiVnBpdzgzSmxScTYvKzl3SGRnR2RlemhPSjhk?=
 =?utf-8?B?NzBPYUdRRVl3QUN2eXM1Y1RYMUxrakFkcHhBYndYSjAyNVI1YkpGc1FkK3lC?=
 =?utf-8?B?RERMUVhiSTVjWlNSWGdDWU9KWTJIQ3hlWHg0ekRBSGFFeVVVTE5OcXM0YUpa?=
 =?utf-8?B?a2xQVkVHeFVYdjFXL1BmUVluc3ZFaWlROWlDVDBKMkg1WHR1N1JuZnYydlRR?=
 =?utf-8?B?MVRRQkE1a2tmK01WbWxOKzBTT012blg5U1FtOFJ5bjBBUlhqSjZwaWRTbFJZ?=
 =?utf-8?B?ZTFHei9waGtERFlFVW5tWCtSb1FGQjdNbXB6bmhOcEFsSktPSkJqa3FZRGI0?=
 =?utf-8?B?Y0pJNWF1ZXpFeTZYelVpRy9rWGdwNmVySXA5WEpnbUREQm0wL25KK3NSeFNG?=
 =?utf-8?B?dms0SGNiam9qR2lWYXdCckhHc0FQZE5oSWdrRHV3TkVQOTY1RWRuODVINkRo?=
 =?utf-8?B?RDByOWVKd2VIQnBhbmFNa3RSR0NLUnJUVE0yQjZ0WjUvNTJhbWZ6S1MvTVFs?=
 =?utf-8?B?VW80bDYzaGhGVEJoWXUrdlp3c1E5YkZTWEtxSUk4N1FTdkt6eHFnc2JtcGtE?=
 =?utf-8?B?Q0JNTjZ2eVFtQnkxK2NsUStJZkcvN2JhK292ck1odTh0ZVpIZ25VYXo5QmRj?=
 =?utf-8?B?UGJqU3hSdmdxVEM1akNSL1hGclR3K3lXanFBZlExdmRUZ1lSRVJHOUZzVWlw?=
 =?utf-8?B?U0F0WVN0Q0YxekRzS2NuMzAySmxhR1FRdTNCWWhOdGRrTXJlVHcwcElManZW?=
 =?utf-8?B?Mkk0amZqQU5oNUhjTnNtYk41R00zbStvVFAyT080RGhtd1RyeHlXOE9mN25l?=
 =?utf-8?B?N2U1a2VpY1kxRUNiS3Z4cHU1WllkVW55a3JrM3A3cmYyck5heldQajBSc01z?=
 =?utf-8?B?bnlDYUwyMlRxY0Y5ZWErMTlXUnRQUXFjNTBtdEtlTkJjRjBOaEY5NkxwV2li?=
 =?utf-8?B?TktqWFMxQW03aEl6VkorUktEclU4RzJLbis4SytXL09YNVEwZzJKTWdIbno5?=
 =?utf-8?B?dnIrVFZJWVJBRHhYcUs5RHoxMmZxa1NHVE1sNDM4K21ja1d1K0xHVWc5U3pH?=
 =?utf-8?B?R1MzcGRDZzFVYTg1UXhsWjRVRERrRHFjdjFDaUl1LzU5VTRzZTlNc3NEd3pz?=
 =?utf-8?B?MWN4ZXNhSStFTEt3RUV5UnVGdWxDYUQ5Mm9GSFEwYkNuNEpwYVdGdWlFRGJ0?=
 =?utf-8?B?TDA0eXJlQ2pxMGNIenBnUVFFUnVRYURzM0gxZGtNbXI2bzJjb3RVeFFVS3Js?=
 =?utf-8?B?QzNaRXBCLy9OK0ZCaUpaRWNVWXpIenptNnptV3VzVUxKZFN3b2cyUVhRRXlQ?=
 =?utf-8?B?cGU5RDlFWE5SWk1rS3I1eUVQWTFFc2d2RzlhU0lsY2t0WHZ6bFE1ejBCY1R5?=
 =?utf-8?B?a2VYQkxQdFlVa08xOUEzK2JlWVp3WUpzN1ZnbnMxNk1HNHlDOGJTTEQ4ZTlh?=
 =?utf-8?B?N3JlNkErUXRBeHgwdHRvWHFpVGl5UHZOMVllOVVMa2s5Rm9ldGY4aEpRWXU5?=
 =?utf-8?B?WlM3WnYvaE90ZXhuczJFU3RRRGdvV25ROUJTaEhzSk04aTZUOXhpSXAyM3hH?=
 =?utf-8?B?MWFvUUdNNGRMU2NMU0Q0NnlhWWk4MHNMNGt6L2pxRFMvWkp2UEpwTFlsdGti?=
 =?utf-8?B?SkZtbHZRcEZhQmE3ajAyRTZtZGsyczNUU3pNeGpzRXczVm1sMmozbVY4WHB5?=
 =?utf-8?B?blE3UmwzUk4zYy9GK0RkcG44UGE5eTNkVTRveUp2NzRNS2kzL0NVeVpJZ2dn?=
 =?utf-8?B?M25KWW43blJwODhQUWpJRnFjYlB6VmRuQ0FCVngxekNVQTE4dXVxdmhoQVNh?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c93f643-4077-4b1f-f592-08de3db9832b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:13:31.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTML+TCaSziOGv4qWY49zpxPY1lTu7HlN86wcxk0meUaDGRfXY/f2DKhhtgJDHDu9/Zrajnl2eHfTn/iZS7N9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7170
X-OriginatorOrg: intel.com

On Wed, Dec 17, 2025 at 01:21:35PM -0800, Matthew Brost wrote:
> On Wed, Dec 17, 2025 at 09:51:38PM +0100, Thomas Hellström wrote:
> > On Wed, 2025-12-17 at 12:18 -0800, Matthew Brost wrote:
> > > On Wed, Dec 17, 2025 at 10:34:41AM +0100, Thomas Hellström wrote:
> > > > When imported dma-bufs are destroyed, TTM is not fully
> > > > individualizing the dma-resv, but it *is* copying the fences that
> > > > need to be waited for before declaring idle. So in the case where
> > > > the bo->resv != bo->_resv we can still drop the preempt-fences, but
> > > > make sure we do that on bo->_resv which contains the fence-pointer
> > > > copy.
> > > > 
> > > > In the case where the copying fails, bo->_resv will typically not
> > > > contain any fences pointers at all, so there will be nothing to
> > > > drop. In that case, TTM would have ensured all fences that would
> > > > have been copied are signaled, including any remaining preempt
> > > > fences.
> > > > 
> > > 
> > > Is this enough, though? There seems to be some incongruence in TTM
> > > regarding resv vs. _resv handling, which still looks problematic.
> > > 
> > > For example:
> > > 
> > > - ttm_bo_flush_all_fences operates on '_resv', which seems correct.
> > 
> > Yes, correct.
> > 
> > > 
> > > - ttm_bo_delayed_delete waits on 'resv', which doesn’t seem right or
> > > at 
> > >   least I’m reasoning that preempt fences will get triggered there
> > > too.
> > 
> > No it waits for _resv, but then locks resv (the shared lock) to be able
> > to correctly release the attachments. So this appears correct to me.
> > 
> 
> It does. Sorry I looking at 6.14 Ubuntu backport branch. It is wrong
> there, but drm-tip looks correct.
>  
> > > 
> > > - the test in ttm_bo_release for dma-resv being idle uses 'resv',
> > > which
> > >   also doesn't look right.
> > 
> > 		if (!dma_resv_test_signaled(&bo->base._resv,
> > 					    DMA_RESV_USAGE_BOOKKEEP)
> > ||
> > 		    (want_init_on_free() && (bo->ttm != NULL)) ||
> > 		    bo->type == ttm_bo_type_sg ||
> > 		    !dma_resv_trylock(bo->base.resv)) {
> > 
> > Again, waiting for _resv but trylocking resv, which is the correct
> > approach for sg bo's afaict.
> 
> Again same above, 6.14 Ubuntu backport branch has this wrong.
> 
> So again agree drm-tip looks correct.
> 
> > 
> > > 
> > > I suppose I can test this out since I have a solid test case and
> > > report
> > > back.
> > 
> 
> Look like I'll need to pull in some TTM fixes in the 6.14 backport
> branch to test this too. Sorry for the noise.
> 
> Matt
> 
> > Please do.

This looks to have resolved the issue. Thanks!

With that:
Tested-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> > Thanks,
> > Thomas
> > 
> > 
> > > 
> > > Matt
> > > 
> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > > > GPUs")
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.8+
> > > > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > ---
> > > >  drivers/gpu/drm/xe/xe_bo.c | 15 ++++-----------
> > > >  1 file changed, 4 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > > > b/drivers/gpu/drm/xe/xe_bo.c
> > > > index 6280e6a013ff..8b6474cd3eaf 100644
> > > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > > @@ -1526,7 +1526,7 @@ static bool
> > > > xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
> > > >  	 * always succeed here, as long as we hold the lru lock.
> > > >  	 */
> > > >  	spin_lock(&ttm_bo->bdev->lru_lock);
> > > > -	locked = dma_resv_trylock(ttm_bo->base.resv);
> > > > +	locked = dma_resv_trylock(&ttm_bo->base._resv);
> > > >  	spin_unlock(&ttm_bo->bdev->lru_lock);
> > > >  	xe_assert(xe, locked);
> > > >  
> > > > @@ -1546,13 +1546,6 @@ static void xe_ttm_bo_release_notify(struct
> > > > ttm_buffer_object *ttm_bo)
> > > >  	bo = ttm_to_xe_bo(ttm_bo);
> > > >  	xe_assert(xe_bo_device(bo), !(bo->created &&
> > > > kref_read(&ttm_bo->base.refcount)));
> > > >  
> > > > -	/*
> > > > -	 * Corner case where TTM fails to allocate memory and this
> > > > BOs resv
> > > > -	 * still points the VMs resv
> > > > -	 */
> > > > -	if (ttm_bo->base.resv != &ttm_bo->base._resv)
> > > > -		return;
> > > > -
> > > >  	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
> > > >  		return;
> > > >  
> > > > @@ -1562,14 +1555,14 @@ static void xe_ttm_bo_release_notify(struct
> > > > ttm_buffer_object *ttm_bo)
> > > >  	 * TODO: Don't do this for external bos once we scrub them
> > > > after
> > > >  	 * unbind.
> > > >  	 */
> > > > -	dma_resv_for_each_fence(&cursor, ttm_bo->base.resv,
> > > > +	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
> > > >  				DMA_RESV_USAGE_BOOKKEEP, fence) {
> > > >  		if (xe_fence_is_xe_preempt(fence) &&
> > > >  		    !dma_fence_is_signaled(fence)) {
> > > >  			if (!replacement)
> > > >  				replacement =
> > > > dma_fence_get_stub();
> > > >  
> > > > -			dma_resv_replace_fences(ttm_bo->base.resv,
> > > > +			dma_resv_replace_fences(&ttm_bo-
> > > > >base._resv,
> > > >  						fence->context,
> > > >  						replacement,
> > > >  						DMA_RESV_USAGE_BOO
> > > > KKEEP);
> > > > @@ -1577,7 +1570,7 @@ static void xe_ttm_bo_release_notify(struct
> > > > ttm_buffer_object *ttm_bo)
> > > >  	}
> > > >  	dma_fence_put(replacement);
> > > >  
> > > > -	dma_resv_unlock(ttm_bo->base.resv);
> > > > +	dma_resv_unlock(&ttm_bo->base._resv);
> > > >  }
> > > >  
> > > >  static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object
> > > > *ttm_bo)
> > > > -- 
> > > > 2.51.1
> > > > 
> > 

