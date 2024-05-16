Return-Path: <stable+bounces-45319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526868C7AD6
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB567B2290A
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210A14E2E1;
	Thu, 16 May 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhG/9UY9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73814D705
	for <stable@vger.kernel.org>; Thu, 16 May 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879362; cv=fail; b=N+x1N5RjOIglf9kVt/Ms+Ol6YoSNwm+TCajcKtl8LFbeGzFCmGmlYOe9LeCsDkSVjcX6CfxDgmrrvdzh1EoLEf4pXqp2SBCEX0PUqdUGkwMDAEgPiMIGaboqWcz2KbduTmgz2Vl2SAt3CLzlCCbyExOaRvfH4J4kujBqzHP2PLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879362; c=relaxed/simple;
	bh=y0HRQCydf4W7iHF7VDpgyCzivnu9cmX62vPQxQ4UiuU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atoMdxgf+Z5Z8hd/CnvmvfnSVcy1HeGw7kfkcTdfmrsE9dJFVpG5k53H4laObnNkzx8gJqUta4JlwE3Xb8MGoE7BjnO8wv6BXrfhGvfYTLd2ngnCKJ3iO1CoI6cmkvHUvZFgZBm6KH89y5Hvv+/zSsPZ9IVxIBzvT4ZJZmFF598=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhG/9UY9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715879361; x=1747415361;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0HRQCydf4W7iHF7VDpgyCzivnu9cmX62vPQxQ4UiuU=;
  b=RhG/9UY942xek5mWB6J8CWwbgk+GJPycJZ9m1hOuX3WDkoDHo3yV9FyH
   kcT6RedXxLEw0FH/UV9OKNmUgeFMpW9wKKM/5PSiMhCjci71q0weQKtJ9
   1j29Ai31N0xKL1kwwVlfCdUQsVoZorRxbsAiq1FoiH3UkrfPRqfgLL8bX
   Gi49ZqfOAGG0IFPFdWCs5gjOmkmmx3geSm2vylH9Dn0yOiAl7QANV/jLH
   PAIWRp/JkaUmL1xXYwEQ6u6idLGSZMJr0hKRlwq0F1a5fdCpTAhBe+r6h
   jHHiQ4w2UXO1kf0RNwNYJFiaXN10yF9QQOcAy+vT600Ux33HRSRnei0DP
   w==;
X-CSE-ConnectionGUID: 6eFTuyTCSW6FGHCyw2yEdQ==
X-CSE-MsgGUID: XK6jzVDdR7q5VfP+9RrWuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11953699"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11953699"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:09:20 -0700
X-CSE-ConnectionGUID: pHuIuNTvSRCO9HWTTBWiIQ==
X-CSE-MsgGUID: HTpk03hWRgKG1a5jbABBnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36235540"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 10:09:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:09:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 10:09:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 10:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4WwIj3c19Kih440AuL4Qsp9mg7lYxNPyJAtn+tnCDK79rc1dpAOcxRGkK6XNMxW20cQyC/nvSXr3itST7+hnI/CJHT4jlwvErPWX+7FePUSYK8KxBY0Szot8NhOx6D74k6CrAm0/eJHB0eB3TUHpiG00QpVv0EjV+UPy4nl1mK4NNXPldixxOJ6mqWs6awqfp0pGWFcd799xrN0JL1cqYHRx34z9auF+Mppy1IsSpjDglpw98rXwonXEJRe2D+hzsoTncOShNpP+pXCNcRJwS3b8ABqme6JdwaCo+4zm/trDTW7XL1MJYiVByfTpdLCSSh2CGbUj94FbIPj2e36Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3eodZn6U8v/eJlPtXgeTFDNvPPqW6MvZPjvm7HZPjA=;
 b=bOEv2SJXRb909FC0JBthIa1XAuA1sPdCHCdD2Tx1aAF0e1YG/j+DELdHcb2YQztwUgCiBM3xktjelLxNVzTTLAxiOHyo+TFnqLjHKazgvD3jXalMOfSa1HfaltNERPOhtIbjfwuumeQfcybqF4+qsIJaAdHkXTdvs8fzH7XBQ0LZ5KoUcutJkIc+Eq7UEsFvxfTZdaJcFkZ8QjYFPcyM/S1A3pDLjijwI1lZFsqyPLYkp2Px8eb6XHdoC3M5cFI5qkQ74735Qsu4DsCsolxkcTwTyF9Jq0ShsK0+g+bosWlP2CysZ9ZcFXWDcERoUrZSUjQYqfZ1lKBfJtenMr/ZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 17:08:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 17:08:56 +0000
Message-ID: <9e8e781a-da18-4f9f-9d55-ec2f46951286@intel.com>
Date: Thu, 16 May 2024 10:08:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Fix Intel's ice driver in stable
To: Greg KH <gregkh@linuxfoundation.org>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>
CC: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>
References: <b0d2b0b3-bbd5-4091-abf8-dfb6c5a57cf4@intel.com>
 <PH0PR11MB4886A5132BDFF44F0BB12577E6ED2@PH0PR11MB4886.namprd11.prod.outlook.com>
 <2024051655-manned-aviation-fa48@gregkh>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2024051655-manned-aviation-fa48@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: c8416d0b-57c5-46cb-61fb-08dc75cadec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0JEUWNWWlVya21oYnhTelA3Z0M0R1F4WGQ0U281M3BkZnRIUm9mWVJUaHoz?=
 =?utf-8?B?alY5NUw4K1JtbHpKVDJUc2Y2K0swdUtTT1AxVVJaemROYUhtTjF3WUJYWWhO?=
 =?utf-8?B?WWVCamdYMHo4QUg2N1prKzBEcnZsRDBsWG9UZ2dwMlduNm9Fd1ZXeElkblI3?=
 =?utf-8?B?ejMzMk5uU05BalZ5OUJrU1JCNitJRTFucmFmNlFKSHBvMjYzNEt3OUkvMng1?=
 =?utf-8?B?a2FyM3VFR3MvRzJyenhEZlV0cVB6VEI0Y3hDYkZZUHpmbjRub2xnaFFqbUZE?=
 =?utf-8?B?UFpsOGxHVzJLSTJUeGhtbkhSVWlQZ1lvbkRnZGpkbmJrcGdxQ2NyNkRLL2s1?=
 =?utf-8?B?SUxxMERXay9xR2owcml6M3VkVUN5b1NTMmcrK1ZOWXRvaTlqM3RMUDdESENa?=
 =?utf-8?B?SHk5TklQRWhhQVJtOW05aWZuVndHeWZGczVudWFBSytPdlg4UVlxMi9FT29E?=
 =?utf-8?B?akpFNkN2RFFScXVUU2tzWkJmQ0xsRU1RaFc1ZTlOalIzRG5JYTlLL053VWc4?=
 =?utf-8?B?SkNyWEhJMEZYVnBsSUpkdVJhMk84QWFneGRQR3dmd3dKY1dzRlJSYloybENm?=
 =?utf-8?B?WDVHc2M2eVV1Nm1iTXB1eEhxd3dJUm5DellibHBzNlg3SU80b0tTZGVXY1Iw?=
 =?utf-8?B?cEZRUUkwYXJ5emtVTkduN1dCcFFtaGlUb1Y0TFMxbndPcHlpZys2NlBuSmFV?=
 =?utf-8?B?Q3VBWnRLY3c1VkVlbFptRVlVbmo1YUs3dVlYWks0STc3eHRTSjhNQmtLeHVl?=
 =?utf-8?B?Ynp2MUdYaDM3d0RzbEU5aXRQemxlc29xVnRDVFY4VEZBZXkzQWFrTFVjQXNX?=
 =?utf-8?B?Lzl4R3ZOU3JNS3BCaWhzZ1h0bHUraW41eWo3c2hGZjM2RmZDdnpxTHVEUlFU?=
 =?utf-8?B?K3Z4RFE3YTM1MkQzMjBPTVdCWmRVU3lteThwWm9mRXNRZlNFK2ZObS95UTBN?=
 =?utf-8?B?OFRKOEpOYThKNGtmdWNlYThPMHdYd1FSczJ4NDhtWTI3S1JDeWdaRWJ2aEth?=
 =?utf-8?B?M2xNbmM0OUp6TzUvcnlJSm43VmVoVlEzbG1ibmd2VkJDMlRSeWdFTndyVDVL?=
 =?utf-8?B?QklNQWVrQTFSSkdyaVRqUFcxNEpvREN1WElPNkk2K25Jd2lvTjh2THpRNmlt?=
 =?utf-8?B?UmFDZnhDdW9aaytkVTk2eGQ0QWs2WWxoclhMM01zbzhvYmVwKzhRUmZnU1Vu?=
 =?utf-8?B?bTdnY2krVHBzcC9IVlRmZE1QS2k4enErTXRUSzB1dnc2OUpXenF5eXFoS2d0?=
 =?utf-8?B?S0JqZGRKZjVnZkZENzJna2hTWHZMdUZYNnFlYk1BeGpZQmF2L2hmaURyM0FB?=
 =?utf-8?B?cmZVQWs5VEJhdjFXZDFhL3RDNmxRd0I5b1RuTTZxV2cxazR6NUNlMDZWbHpG?=
 =?utf-8?B?RW9zTWpNaTdiTnVSRDNkbmVKOXdNV2ZDc09rYVFDOEdlRnpSYVRJQnlIRTBT?=
 =?utf-8?B?S2dJUmJRdHNQRjNLR2xrZkxKUzlQc0c3b2lhQ2xmd3N4Q1hEcjlYT2IxemRk?=
 =?utf-8?B?Y3BsRjhYVE80UTlhVjJNaDJwMEovQTBFQzZnb0poNUk2RUhsUjNWUHhOU2Np?=
 =?utf-8?B?bU53KzBoU2dLU1pIV0ZJZUw1V003dlZTc0N6TGd3Z29BeFVaSlFJUmRmL2Iy?=
 =?utf-8?Q?WdLXDupf7ADSU631Z/2qKu4qCoEpOuIbyaXf/2KOK+qw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1g3cmdzSUMwZzZlamtaM1NLckQ5VHhYUnE0ZmM0dDIxNkhLamdxUlJmbnEy?=
 =?utf-8?B?SFl0N3dZa0JDc3RCNDFXYWdMZjk1R0grWDNCYmZIZWZUTzA2eXlQSDZOVUJG?=
 =?utf-8?B?SjI5RE5HaDZTdFFLaUhFWDZ3V1NJd05vcTF6YnpKOW14TVhIRGtuOHhnVXgy?=
 =?utf-8?B?b0ZHaHNkZjJlVEFwdmV6ZStNcFNaUWw5UjNmWnc2bEZycDhmM2tISGI5K0Ex?=
 =?utf-8?B?cklINFBQN2VCK1pEOVp5QU9vdnVJL2R2TFhuRlE2S2FiTGZBbzA3SnJpL2pF?=
 =?utf-8?B?dU9hS0VIL3ljY3hOM29YTTdmU2pQWnVyNytBbjUyRkpBcGhQVnR4Q29CQ2JY?=
 =?utf-8?B?UXhDb3NrcTZlMTRxZlJnRTFTOFRDZWI2TlhhMGorZmFtcThOTklHN0JReE1E?=
 =?utf-8?B?TWwvOEFkejlYMENBeVhyU29yaFIzcnNGdlU4TUd4djlyTnRVY0djZExKaVBx?=
 =?utf-8?B?ejU4dFRNZGE0NklrcHVZZTM1b2VyOHowTkIvcHZTR3Z3bHdUMHRqUFBvbnBR?=
 =?utf-8?B?UkxOcmc0RVUwWm9TYmk5VUhqcTlNWXUvRFp3YU1uQjBKQnl4VHRHaUNxSkxJ?=
 =?utf-8?B?NXgwMVRXd0YveEw1WVVhV0dSc2xvU1pSTlJlK0FSdzU2VEkyY2lMR2FqR04r?=
 =?utf-8?B?WFBBZEY5K0Q3YlgvTWVjMXIwekpYRmdFSVpMVFpsRE1zODNpWlJZQnl1Zkdt?=
 =?utf-8?B?RzBSM09JSDZqWVF0WUlja3BZTW1DRndOMlB0ay9rd0lwci9OOU1ZZzZvRXp2?=
 =?utf-8?B?QW42b2JqYkFMVjBjK0YvY0FiS1dYQnJqSVZDaW02WGJVYnV4dnVaeDBBVzJ3?=
 =?utf-8?B?NWUxaFlYVmxreXNzMEVqaVRaZjhNNDZ5Zmt6R1A1Uy9MQnJTQldGbk9GdlVk?=
 =?utf-8?B?YS9YS2hUdkk0cmcwNE1xWVVxM09UekEvTWQxSWV0ejRZYU9vL1J1OHl5TmZn?=
 =?utf-8?B?NUVKYm9zUGlaTG9Ea0QwR1FrSm9VQ0dvSlpRb2h6dE8yQnV5dHpkY0QxTEwy?=
 =?utf-8?B?eE04d0lNM2wyRExoUjgzQVZVVWwxVTJFTGVJSHhQU3NPTlR1czlhbkRRWDBF?=
 =?utf-8?B?RzhZbm5LMjgxdG5teG02d3F2MXBmTUwrQVNXY2FRVWdpcDRZVUx4cjBOZmc0?=
 =?utf-8?B?R0JjZUMwSUdoVSszOVFRVExKdU9UN1J3MUJBNjduZC91OSs1Mnl3NytqSjVj?=
 =?utf-8?B?QWtrQUFkNVFsTWhCUU9vdWJhZ3BKNWxydzRxamd5ZGlscUZKeTZlanBLOXJa?=
 =?utf-8?B?akFzenB3dG11cVNUaTg2SDZjMGlsUCthRGt4c29wZE85NFJCUXZ3NmFyQUEv?=
 =?utf-8?B?VkZNaG14YVpCdHhLM1pEUmhNTHFhMmVSUG5EbXQ5YUNRREtWR2xCUlNrSjhk?=
 =?utf-8?B?TGhQYmJxSmZacEFzT3YwblkzZm1oa0ZhSWVrWWxOMjBwdDJMMTQ2ZVBaVjR2?=
 =?utf-8?B?TVNJVmRFdVdhLzVncS81dFJUbmFVZk5pMGdxVnp0ZDZUOEdXS3NHUjd2bGd2?=
 =?utf-8?B?RTZuNWVBLzhMTFZtU3ZwVEZVMWVuSVN0ZnRXTGdhUDd5ZjdvRWJBVkgwV1Ax?=
 =?utf-8?B?Rnp3eHB4ZWpqRExlc2JObmd1cjJoSmtZRE9CaGFGNTJreU9aZ3hwdWlXRnNQ?=
 =?utf-8?B?MXVjN2EvTVUzang2MzY0ZXJNcXZ4bHovbE5JNThMdURjd3RjUW9KcTFxZU52?=
 =?utf-8?B?OVE4UmY0ZXgxS2lOcU1ZcGFFOFZnN2tPdFBkU1NWcGplTnByZlA0OTc4ZlRw?=
 =?utf-8?B?cXNhNk1NTmJzSjYxODFpSzhETDQ0QmlLWVNPNmViWk16ZFBoMmRxK25zVGdW?=
 =?utf-8?B?M0VlMFhieFRaNzZQWUQ1WEJySjhkRi9xZG11RHZQeWViVWNPSlRWaDVqQ3BV?=
 =?utf-8?B?UEZPWGIvcG9wOTcvZy9qZGtsY08yTlFMNGlBaXhPSlkvdUFKd3NQaUFvNVlu?=
 =?utf-8?B?ZDhJMHJXOTBkMGI1TUE1OXV3R3piTmZ2UjRmT1dEQTBjRWduZzVtRVdPZUJX?=
 =?utf-8?B?dkFEQWl0TXlwekwrcS9hV2w1R2dtVnExTjJBZWxueWZXR21MK0JVQW5JMlFW?=
 =?utf-8?B?ZU5BN2dWTHNodGIwRmJhOUo3SHp1WnNuOGkyazF5MEtJYWxHcklVbk9jUkl2?=
 =?utf-8?B?Z0M1dnkxb1daUFVxWVh5K1VZcFFTaXJpeDBmTFlNZEJpQ0doQndGbXN2NE8y?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8416d0b-57c5-46cb-61fb-08dc75cadec0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 17:08:56.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfLR5ekI4ZZ1pZUYOZF6PlZ0xR6Q9bg9wuN2tsshYUJ2Ut+6AGaMKE4d651Z7KqGP+CFAiZXwq2Q5keeYysy+n4DXMGshZcuWhRDcfP7ExY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com



On 5/15/2024 10:46 PM, Greg KH wrote:
> On Thu, May 16, 2024 at 05:12:40AM +0000, Samudrala, Sridhar wrote:
>> We need to fix this ASAP. Flipkart reported this issue with 6.1.x stable kernel.
>> Not sure why this commit was backported to LTS kernel as it is not a bug fix, but introduced as part of enabling live migration.
> 
> Back in March you were notified this was going to be picked up for the
> stable tree as part of the AUTOSEL work:
> 	https://lore.kernel.org/r/20240329122652.3082296-63-sashal@kernel.org
> 
> Any reason this wasn't noticed then?
> 
> thanks,
> 
> greg k-h

I saw this patch go by but didn't notice that the other two weren't
selected. The patches were sent as a series and tested as a series. The
dependency on the other changes was likely not noticed.

