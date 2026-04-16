Return-Path: <stable+bounces-238245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA9DCrxj4GmFfwAAu9opvQ
	(envelope-from <stable+bounces-238245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:21:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5140A29A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F0F630091DF
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BAB2DECBA;
	Thu, 16 Apr 2026 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xkqy4QqW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E06224F3;
	Thu, 16 Apr 2026 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776313269; cv=fail; b=QsfS9c+czex2cLQ/IJszDWkGZCuNq3Wl2VnZ7XppIp0ok1n3DVNUuYrjQWI1dj0HuHrd6eGFYQtnXkZqVijN/mn0LWO9aaLxU71CiTXkaCsLysV/GVw7byMvx0MVoYkBT2IEvFdAdnhwQ/mQWXhzyShESXx+522J75RVgAgXZgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776313269; c=relaxed/simple;
	bh=ryynU5lGkjJkhoyjBTDWy1shM/dsYbX/XpqqvIzlQI4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=icBFkbiF0ddHp90yrTeTJddqGs3/AThYtKgKOWcgGwALYeO2FUSABW4NUoXqJ1ifHHN/rbmEhU5Ygvz1mGk62PALdvcYTMEjys9qXx4eEDyHN3qdNDxEFSbR8TBf8OQOpsCDgUTUau/9C66LWf+kBVow6LogWY9aL9rUyk9zZx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xkqy4QqW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776313268; x=1807849268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ryynU5lGkjJkhoyjBTDWy1shM/dsYbX/XpqqvIzlQI4=;
  b=Xkqy4QqWHohyvQK7cfIDVQFwUlvWyYK8fLxfXlnTj17MCBlllbQ3LJig
   LSTj28Vyh3nahs7LRNsJRLrVAE0cjJz+CM2HU59nVJAxroolcV1W3dns7
   /Wu3z6MfPiJmE0VtVCVtUYfEIzQiPplajCP0NysTNkrI59+XvqwPM4E2e
   dQOk1vSgXcZlZHJ7wauf94DGTXBbrbmK5z5MjOx9Ppc1WV5sdUXlYHi2M
   1JvmUMfIbf4eIqLyIU+DlAuuywuHrw49DY7Frtr2hY6pdG6I1RV4fRDbN
   wi4eXuasVnaFGB9oE3Xvex314C3Brs4hkRNUOtVAhUhpBiwQaCeRRW5Zp
   Q==;
X-CSE-ConnectionGUID: +NzcAJa0RvK6Jy57fd1Rsw==
X-CSE-MsgGUID: lapHcpPJRMC4Kx82jTWviw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77179460"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77179460"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 21:21:07 -0700
X-CSE-ConnectionGUID: c4Po3WZ9Rt6x5OiZwITjYw==
X-CSE-MsgGUID: Rkoxz/NgS2a6pd40UMGHyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="235564586"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 21:21:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 21:21:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 21:21:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 21:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNGk1xOIbWwBDwnFKurnl/Wt+Fetl7TRqu2k7L3S/nnQN6JJRntdzP+fiO5ZxlfzQURHHpOwkIe+OgPB5SHqQFYt8+lcIlQ7TJxrKSQLrKvOIdGdAsmxb503ozGZR3+mkV8+a+bHhvyTEEn3k0xXrzBV2lHKVxzcMcvDLZPh/nTGfnzXKgy+D/Ey3QJBqZWHTA5Cew4CA7/J2bi+3/wylMrWEvimsJCN+mNFBAglqNSgOuR7k1/wwoU04yKbZTLqfZn8ibak/Uff0oDT+VtmTuetcb7/ScmyLBSr3MgntexQr3vz7KOt++sY9Y3ElkkRankd4O4qHVpl7x2rd5lrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpbHjGekf5oLOPX7cHNpsseUJb78I8tQKgLTrKaFlLM=;
 b=mEzIPWuDuQxynt/DJt6/PdG0G00p08QwPfDt2oo/b4VjY0/iR4XkloqwQ93gnfDOfbzecTiPf7JKSS4GjaXtZsLMKUw5ZRcaVg2K9gRiOC5Qmx3abaC5Xg2YxPHs1T9/tELU5IU0cwvHzB1tLW0Hrp9NRG2WjAMsJvAwo7geeOCbOsmnHzZ8RUg/wZQSV1Zicu6eyBG9mYp4fPJB4Rigf0/1CegAOazDaRqKDeRbrELeWCe0joDBx5QPpfkEF1zJRnNOVuZDGOT0cixL9L3qhCgWC63UieEQnd6GWUwqdTNEnZQ8f8mdU6xSuuVdvpJZTPI9rInB8fzQiXkGWSOUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 04:20:56 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 04:20:56 +0000
Message-ID: <6cc3c5b2-fb71-42a4-8d5b-57cd85de2f02@intel.com>
Date: Thu, 16 Apr 2026 06:20:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/13] i40e: fix napi_enable/disable skipping ringless
 q_vectors
To: Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <stable@vger.kernel.org>, Sunitha Mekala
	<sunithax.d.mekala@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
 <20260414-iwl-net-submission-2026-04-14-v1-10-852f38e7da39@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-10-852f38e7da39@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:10:232::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW3PR11MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: d78fd426-9c69-404f-94a6-08de9b6f8e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UTuO3w/e+kD9nTKDwYM+sw0DSmZnLEixuNPyhIKPckMddzPA1xpmzL1LFxyib9mEVVTFUt2VWDAwimzKyPmAoRmiln3Q1sS1zhNfowGdLTTmjYOewqGzOHsFeGwT9fXeH/XIM9WkDltSEAx+S2I6ipppwOqGJte25XC1FfKyWgrZerHF4jGUmgpEqYXpRw8NgVhsMgypXjLgvc/dgjUML10CRGQ9RARamo9IP4GlKMjIyijb1ooGW/h6DU2LtFopLVNZzB3JtZMZx2sTgKA+3SLt9JyjCizLvyDnX+E/sy7AkhNTPyJZtKXDgmCu9YUyYspOaWZ9xyss7V1mVFyWxjbskMhL7NJA9yyGK0pVCrBcvdpqeTzv7kS+h8qQ1fXxl5YjTTLe9HNZSyTUwEoJhSx83weRsXMJLYZf2+8vZgUfLtBWjJpsYCk3iq4qlGl9ndU7wmy6ubINPm4z81/qAFjCbaWEAW3FsNK64qPYzKmjYQrt3DkQBbYyRcOtCUkvhkLYBUwEY7MPjmc8sQdLHtMhi0BUwFmwwJ3Oy/nPj1sM1+CEeut8/cjMMPFe9Fl5twmQQwgHdBwCGXWEAhia+btK3QuI/rxCkMfbB94gxbZYuCijlAvDmyaTUtlPzMTwB/chLni38Yo10f9Uk6u84MDkSPousIhqaZ1ewYDJ9MqVWLt87bCTfZUoM5Zk6dH7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UklybEorK1VTbFZreHBMdFRWb1VWNGRuVW5DUE52YjdCYzJ6T2d6eUZaU3d1?=
 =?utf-8?B?VDlZQ0xrV0Exc1VTVVJMMnRpKzVNRHA5eTB1bFcwUitqN2hyK2JnVXNNVHNm?=
 =?utf-8?B?UXFLVnRQYlltWlpLYmdKTXlGY2NiRk9KVy9PMkNHVjlCUit0MmFTaE5oN0Zr?=
 =?utf-8?B?OEJJUWRLK3pPVnhRKzNxZU8xcXBPU050SzZVeGUrQzlZWWZtVExmWE5nMHZy?=
 =?utf-8?B?dDlpNzdEcnE5aE44OU5wSThTRVRLdUV6Y2VWa0FOT3R3R0UvaVE5amtsTHdn?=
 =?utf-8?B?dFlwMjhPMGhzM1ZwQ1FqNVNIdEZqUWMzL3lXamxYU2lNMVgzSGFXR3YyWFNI?=
 =?utf-8?B?Ujd3WE5pTnpuMXhsQjh0ajVZemZyQy9lcWJWRmltbi9XbUdxTXpwWnBqSm5O?=
 =?utf-8?B?TkxhaXJNQ0ZjUHVtYUtsVlBIbzhMbHZiNzh5UHlRZTMrdWNOTVBLRG1RWUdS?=
 =?utf-8?B?ek1tUDgvQitmVS83a2FLY2Vmd3JpYVB2YWVhOEV2U3BuWVkzWjF5MGdNZ0Zv?=
 =?utf-8?B?Rms5N1krT1lyRG9yRmNKcEZHaTVVYW9NbjJjcU5QK3NvWHpsRU56Q1hnVXY4?=
 =?utf-8?B?WkxEZjR3OEdzWW9uQWdrY1NvRWZiaERBVEVFQ3pTMjZjZm5KUlhXdy9WT1Iz?=
 =?utf-8?B?amhTMGhTZ0VCMG9JbTZPUFVNNnMvMUN0b1N4SjV6UHlZMHFuUUlnT3Nqbjdx?=
 =?utf-8?B?UlZDU0tWVmVNTldEUytkZ3ZGaGYzc1d0SVZtQURSazZMdk9oUlZ2UjI2R29s?=
 =?utf-8?B?aVM2RmpsRjVJR1loSjFIcnhEa01pNVY2ZHgraGIrNG9CQ001b1p1b3dESUtW?=
 =?utf-8?B?MStaWnVLZ0J0SXB6Z3lUTGx6UjdtNHo2ZlowbTE0RW9HVjU3U3RLZ3FlSmJl?=
 =?utf-8?B?YWpqaG9UMEVUQ0YyT2ord09yR2EvZzZaUGFkaFllbUlmZ1BnWS81UVYrUklF?=
 =?utf-8?B?SHJ3T2FBeVNFM3dscjc3L2tXUzdyTnBlNmxlZFhTWUFZeFRNTnFhOEROZjlF?=
 =?utf-8?B?TStsdnRXdUVkSUhiMlJ2VWRVdFhiV2JndDB2NXliWHpnUW81bVlEY1VpUzFp?=
 =?utf-8?B?eWJ4Q0NDRVpON3ppVXZoMEgwT1FRc0pCUnpOSGkrOHkyRkVNcHdWdHc3Mmd0?=
 =?utf-8?B?SlgxVml3MjRyWTJoQVV0NTdRM2YxSytSVDNRT0U4UkQ3bXVTcFZvL0JnWGxr?=
 =?utf-8?B?bXN4b1BwaC8zRHNYTHkzUHdXTm9XWndJQmlyL3lORG5jR1g2WU85UHBsM2Ny?=
 =?utf-8?B?MVZPVUl0djJ0MHJuT0xaQy81MmVlVnAyL1pTMlpKejNSK2JlSEE5TWFXWkd5?=
 =?utf-8?B?MVdWWjlnSzZNMFdkQk5saG5JUE0vcDlQTERUOU1wMWZyTHVleUJ1YzZqY1FB?=
 =?utf-8?B?Wnc5MlZUcmkxeWdXWmVob2tBakc2dXpUQWhXMlpBa0M5b3dMQmRRdk13QVg0?=
 =?utf-8?B?RmcrdGlHUWN0dU1BNWhMS2tYanRacDQxdVJmUVEwZEN1VjR6ZlNLcDZZUzhj?=
 =?utf-8?B?MnlLMDMyN1dBMklPSEo3cVlSRVNFSFVhbERtNDlmRmZLbGhvQUgzMlRvYlN3?=
 =?utf-8?B?MW80Wkp4aDEyNlZxck1xa010VHVmeWtHVTRZb3hsZ2FMY3M2ellkdVEwYzF4?=
 =?utf-8?B?RlhHVERIWDlIK3ZZWFF2LzlYRVhqc2lQZG1zVHNTN2FpTDhYMFBYRythR2J6?=
 =?utf-8?B?QlYxNVl0SW8vSWVGdnp5dDNMeklBOHRpRy9Fb0tZV0szYm8vR1lweWJVaFg3?=
 =?utf-8?B?OUIreXk0YUxhaDBHQ0JEUDBiMUdwZ1NNV1dtWG4rdkxmMVUyb1VKUStIYWVy?=
 =?utf-8?B?ckFsUU00azlBT0V6cTdmei9qbndZZzJiMlR0S05KalZ0aWdZZ1pIbDJ0N21x?=
 =?utf-8?B?WFhENUNqNTV4dUw2UWdmbWppWXN3a05SaUd4R1dpM1h6YW9HSDViOGNsRUha?=
 =?utf-8?B?Tzh4VkNGZ0FXY3c2NlB0bEN3M3dtMm4rdjZYdC96MlYvL0kyYWUxMnpEQXNY?=
 =?utf-8?B?aDhBV0R5ZmtHTmNOSmhGNVJoeUpTWjJrajV5MjgzN3c4YXUvZkNpZ2lxNXU2?=
 =?utf-8?B?QXJsWlB3aURWTExFR3FzRHFCSUFPRFdjNHVmcThnSUgrTGl6azZQMDFlV3pH?=
 =?utf-8?B?NkhsdjQzcG9Ea1gzdXhrVjUxdnlhblp0SUhTdTVuZnI3RUV5ZDR2WE9vY1Ey?=
 =?utf-8?B?T01xaW9jVmtCTWtEUEk0WDlNL2x5bjNwcktwQ0pwa1Y5QVJ3SndvNVpiU2JH?=
 =?utf-8?B?Y1VMQlpNTzBmY2krVXQ1S2JKc084djQ2NmhYMnJ4S1B0YVNmK0xYM09DMmRn?=
 =?utf-8?B?UWd3QjUzdG1IQnYvbTlzWlVlUXU3Z1k3SDZRa2pKMWY3d3BhbnlqOVVTcDdo?=
 =?utf-8?Q?ZhhJKMcg4uHf6waM=3D?=
X-Exchange-RoutingPolicyChecked: gJzcEBq8MtClreQKL6/kqd0N3wGfp64DSjfz9squWl8elHN4nAjxAaLyExdvgJe+MkxdDXQXo4PJRrCxVU2jdac14VxudIRIau358PCTGQFzLbj81OMrIsnKRdDr/sNKYjKNMqO8RNmCg0VqB/R4fNTIB6EY3QiVtyGKcnn+j2yo1BYB1HwxFNHr5FuWC3VjPUY7A42aPssacKjuQIi/TjY9kAS2w/um8rkvZdx9sO65U4CjqwUHUF9yfp4fQorIzuvTlDJmFT8JCanoDHlIJEISbAIGUEAsFlr04MWnyMbI+6a2XSuwQqrw/okuQ4McSW11yhvfrs2VLnNjxWVUHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d78fd426-9c69-404f-94a6-08de9b6f8e04
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:20:56.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5omN/Iok2YBzGb4ID9yzkmTMb+P43fk0GjPFhQ548nwYqOYjzfoT1vBf8GV1NxRW0gwyL62qQUg4ZPpOn6YVmVt+LuhzZAj7zPUM8DpbHE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-238245-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CC5140A29A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 07:48, Jacob Keller wrote:
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> After ethtool -L reduces the queue count, i40e_napi_disable_all() sets
> NAPI_STATE_SCHED on all q_vectors, then i40e_vsi_map_rings_to_vectors()
> clears ring pointers on the excess ones.  i40e_napi_enable_all() skips
> those with:
> 
> 	if (q_vector->rx.ring || q_vector->tx.ring)
> 		napi_enable(&q_vector->napi);
> 
> leaving them on dev->napi_list with NAPI_STATE_SCHED permanently set.
> 
> Writing to /sys/class/net/<iface>/threaded calls napi_stop_kthread()
> on every entry in dev->napi_list.  The function loops on msleep(20)
> waiting for NAPI_STATE_SCHED to clear -- which never happens for the
> stale q_vectors.  The task hangs in D state forever; a concurrent write
> deadlocks on dev->lock held by the first.
> 
> Commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no
> rings") added the guard to prevent a divide-by-zero in i40e_napi_poll()
> when epoll busy-poll iterated all device NAPIs (4.x era). Since
> 7adc3d57fe2b ("net: Introduce preferred busy-polling"), from v5.11,
> napi_busy_loop() polls by napi_id keyed to the socket, so ringless
> q_vectors are never selected.  i40e_msix_clean_rings() also independently
> avoids scheduling NAPI for them.  The guard is safe to remove.
> 
> Add an early return in i40e_napi_poll() for num_ringpairs == 0 so the
> function is self-defending against a NULL tx.ring dereference at the
> WB_ON_ITR check, should the NAPI ever fire through an unexpected path.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/

Maciej developed a better fix for the problem, and he explicitly asked
to not include this patch. Please drop it from this series.

Maciej's fix:
https://lore.kernel.org/intel-wired-lan/20260414121405.631092-1-maciej.fijalkowski@intel.com/T/#u

ask for reject:
https://lore.kernel.org/intel-wired-lan/PH0PR11MB75223C8A00C3183C5082A096A0252@PH0PR11MB7522.namprd11.prod.outlook.com/T/#mbac55f7219d7855a2e5d1527904b2da43ad080cb

> Fixes: 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no rings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++++++++------------
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++++++
>   2 files changed, 26 insertions(+), 12 deletions(-)
> 


