Return-Path: <stable+bounces-217559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP5GCxA6mGmFDQMAu9opvQ
	(envelope-from <stable+bounces-217559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:40:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE1166E6C
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CB563015887
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6333DEF9;
	Fri, 20 Feb 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJX9athS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A4C2D5957;
	Fri, 20 Feb 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584013; cv=fail; b=PDznaNGxlYDr5X+hv53QifwT7g0egu/zb8Xy2uirDnG+U47yMOg7s5jmntuOVStAKt1uHerNUsOO98hjtg8ZcingLCRp6rJzPdlVoaVa5p2eYaTiUcb2Xw8OYmpObWm8loORqIo9haroF9K0KbrwbPcv6L4SF7TQvXz7SEMqXpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584013; c=relaxed/simple;
	bh=ga73ACVlm3k39OTEMJvyb7lkWP6AbVzhjkQbCvofDh4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CWXi6vBWCU2JV4PtGkpRVVgXLrWaEDGDTD1OsRhcPsA5tONl+zkUEew2tqYd0WsEwhihbvLPKQn7W92hcu6nWAjObySBa0ZjaF3v6FGvMXtQzFRFeTa/lLTN76xwbehR6MBwZArpT3Pr7A0JAXdVpDKFSQ2kzzGSwU0u6C3eegc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJX9athS; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771584011; x=1803120011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ga73ACVlm3k39OTEMJvyb7lkWP6AbVzhjkQbCvofDh4=;
  b=YJX9athSelK+byRFjwk+RZppjMCay2k3HDIltHytzpdRcmexYUMZYNfZ
   ZUnJieHsM5vodoIxsKO33SlXJdbHbvGs2Xom1JFVvG8UNoZNevANz0TVv
   XKJ9A1HT70InkF0X46OOD/Lgbyp4fMv/J/QbwP90s6V9hsYWue+0w78mz
   qMaD5Cc7T+sdc/JDJPRZOx7ViJOlBNbIumFxXeD9jFTd0+Eez8iKO1Tsd
   wYf/8LBH4jL3D/HCCKUm+BDSaLP9UxdBIADQk69dmtHOy1+q06tFySIip
   DwsRVJPXG0KNGUG3iyKNFqD3kURe4dmygrIfB+6cLjqrD/8Q52qd6hWm0
   w==;
X-CSE-ConnectionGUID: aoyGQy9FQne5tYbJnwwJWg==
X-CSE-MsgGUID: /KAjo4V+To6ZholJty5qlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="84036446"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="84036446"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:40:10 -0800
X-CSE-ConnectionGUID: IRRKMkRRSuqQYiPiukNR4w==
X-CSE-MsgGUID: 8eaLRKlUTrG2p8oIfJ1fpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213924628"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:40:10 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 02:40:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 02:40:09 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 02:40:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+Fgzj151yMS/7uIfG+Idj5VDpHfaLaslxzVqsShHTCllPUbPo377Pp2iz5In6lCez16cze2yQSAJJ4oWXm7V3D1v4FaV7W4bK4Ix2XoG6bRjh0VBh0iT2vnWJENJqC9/Pu1I14OCrC0GG5U5HN+VNNGULPH5mRNAjRBcrAaULGEhRm7jHuyfDi/jjozmntsiCf13MlFhzkH4YJZlUt/KWU/amcnwEsg44KJxQGDk49chxCNK0+Q+HUvDzEfI6z4D36zpNnd2XkyOWmMXtVXAsPrUybs6sLVuOEwPgCBgCPH5XXy52KeXFq6h0D2/Bp4CF8sxj7Qgok+L+opr72PyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35sg5Q0RBKU6yUl1w6+n5MIbkGAtJ6gXIzLjs4Uk43A=;
 b=Uy67qUL2bdvDzZDVma0tcr2+5s0O6yenC6YNxRjc+7XgIMiLVNsuoDZhaQt6gd0yVLSqiOfcbgppl8+S2bqM8maDEGK/URHMaJv24MtGUiWQQwHHDgLK2uXEszN4tls9cDiVBppOx3Qsy6xGThsGTF9JU8crLsvFfLuE9Qq03dxoKyimP8aamH0yp0BzUWe4nNMmHOhNQRrJW7+V3aMbvik5lX7TxZW7hEU4uMyqGeo2Z54q8d92LtK9M1c9Xjz7n1YbpquV/xS/Hzvbu1MRhW+Umvs17G5Rpvml+VCC4QuONqmlN42CYNf1V34fjA/rPoYQkqm6O6XrKYFH2wDeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 10:40:07 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 10:40:07 +0000
Message-ID: <2c359a37-937f-4289-ae54-5ec63f111902@intel.com>
Date: Fri, 20 Feb 2026 12:40:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mmc v2] mmc: core: Avoid bitfield RMW for claim/retune
 flags
To: Penghe Geng <pgeng@nvidia.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260115214648.168365-1-pgeng@nvidia.com>
 <20260219202954.937508-1-pgeng@nvidia.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260219202954.937508-1-pgeng@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::36) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a659cc-52d4-453b-dfe8-08de706c69f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2pXOGZ4bFlWbFRyZ1k2WHpUTDhLaXlLTlJsbkYxd0REQ3oxZCthcVZVQjl4?=
 =?utf-8?B?akl1bjI2VnRRSUVDMEhBR2oyYy9pWWRnS0docTg2NmVaVC9oUW8zc3BWYmRQ?=
 =?utf-8?B?dWJWaE1IMlBKTFpZVWUxOTg4VS9rS0lNcWVyd2g2MjBtNDQ5VjJkUlQ3Z0J5?=
 =?utf-8?B?VDdXTkFWYkdrRFpzVTNtUGFNRGNPT0Z0SjQ1VXA3VUlnMzNDY3lSOFRSbzcx?=
 =?utf-8?B?eEloQlZOUnQra3pUZjN2Mk5aZ3dIZWxYbWlneEtDY2JwV3BPSW9HQ3N6WW4x?=
 =?utf-8?B?dDlGNm5PeHBZY1RWQVI5RW9aZ0hqZ1VQUTRuZGF4aUZOeHEzb1YwcFlMWGxn?=
 =?utf-8?B?NUJISjYxQ1VuQi81WmRzcDRqbk02ZDdiWWVDS0VaUFc3aFBVR1JOSk81NjJq?=
 =?utf-8?B?M29YR2pQS3QxbVlOVWo4RCtucExPYWR4aVpSWG91ekh1b2JNenVtb0pUTFBP?=
 =?utf-8?B?eUpQSkNudEg4MzdOQ0cvcG9mN09UajVTbHYzcTdmbjNmK0hUbGpmTWR5TW11?=
 =?utf-8?B?SkFhQS96SmozaTZlcTAvak5sc1JWa3YzSjhwWVRTOWdRVVlQTnR1cmF4dkZu?=
 =?utf-8?B?VWR6YnZtSmZtaXd0MDhFalBJZmhCTVAyZ0RxS3J6dGRaTlVPU05jc3U0NjJI?=
 =?utf-8?B?U0JZdVdCZjhHMmRsMCs4OGhkbERmWGdEMjZpZXBRR01TaEdHVmJ2SkdybXRn?=
 =?utf-8?B?NVZhZjhJbmplMHFkb3RaUDErL3RJZ0JGeWRVVDlnOWFub2c5ZmFQTmI3VlFK?=
 =?utf-8?B?WmdyOE81aHZuWlI3MTVWeU8yczF0UW5QSG5pMHRlb0dkNllSS0ZYb1M5aHBI?=
 =?utf-8?B?dVkyaWZkYjdQZVV1aGF4a09PUmhEWGxITkxLUUhTNUJCaHFMY2kxR3poc0p0?=
 =?utf-8?B?OE5wMHNpUERkV1NZUHJuVXVCZ2ZYQzQvTS90YVpBaXR4YnJjY29OMTl2dU1M?=
 =?utf-8?B?dGgwcytZYXd5MXpNSVJrYzNkY1pOWFB3MlUrSjM1NWdxazZtUW96eHB2UjJT?=
 =?utf-8?B?NlR2SHZZOHNwU0pOSU9zU1VNMEV2WVhMa0JKakhuY2dWWmp3RGNVVmNNR3J0?=
 =?utf-8?B?RHgvTDE3REVBaHlTck1iSWNsay8vTUtZUXdhVDJCL1ZidDRIdUk1TVhqKzd1?=
 =?utf-8?B?TWdOL21lRCswT05ucm1EelVQb3hzMDQ0c2Q0L3pWb2w0TGsvQXFoYk16RTJ2?=
 =?utf-8?B?V2lOSExBQzZUUzUrZWduTGp1ODNPekl3L2JaemNJVUlBYi9zbkhqK0NwamNa?=
 =?utf-8?B?Mkh4SkZLbHpXVWJ1c3VwdHdFVjVINmJCZ3IreXZ6TDhIc0hqODNJWlhEYlk4?=
 =?utf-8?B?RjRPcVo0RzlVd0dudzFvZUJFNmVXejIwTmcxSkYyZm9iVzRPMEc2NzJEdCts?=
 =?utf-8?B?V3owQ3BudXZNNlU1ZnB1eWtMNWRNdzVEOGo0UjBxOHNlclFTOCtXZ0NMMkIy?=
 =?utf-8?B?K09nUEhXNDYreGJQaUFPUjc5STE3eC9BQzRuR20yeWYwMzBJcGJtN3AyVGsx?=
 =?utf-8?B?TXBTQlpHUXFqMFY5aUp6Q0tjWjZLZUpNOXJ4Nkt5Z3J1b00vRStCbiszYy9v?=
 =?utf-8?B?Uy95MkIyaEsxNXBxaTlJMzY5OFJTUW4yYWRVWU9yc1hLeHZMUFVQNjFJNWVF?=
 =?utf-8?B?dVNVaW53dE5OenBsZFlBVmZKZnJYUDJEVGx4bVJQV2dRVFE0RHJlVlFuai8x?=
 =?utf-8?B?WDRSenYwbzJmQmo4cHR3NFl4aHAxMTZVcG96b09Yb2pRWGJKTkVmWjFIaEtj?=
 =?utf-8?B?WXQxSGJ1ZTdmNlBpTzBLNThEeTE5NHIySmYxdXlVa3BXYURmbnd1MFZtZElo?=
 =?utf-8?B?Z0lyOWVFcXdTYTZwQXRYN0RZUHloWE9rRkNEbHgzZmxURmg3MWVjTlFlQ3RK?=
 =?utf-8?B?RU5GWCttcXZhQitxYWpoV2NLNDNiY25JTm81UlFlQTRkUzVGNkdLNnJBeUZj?=
 =?utf-8?B?NHlDSkp3djBuRlFCbW5PeHpJTHN3OXZmeDFxSEhuK0RpdTVmRS81MmRMZUZ0?=
 =?utf-8?B?UWxuS0oxYm90V3V1d0l2bFB5QS9ZenJGb0VUN1p4OGNodVpwSmozTnNIclhx?=
 =?utf-8?B?c0tXdE5yRmVhOTVmbitUMEVUMC9HalMra1BXRjFOalN0TzFwS3g1RUtEUExW?=
 =?utf-8?Q?rXu0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNCdmNsb3VwQWhaN04yajFUaDlhSkh4UVJTVWxZYXJpZktPZVpXYTJXK1dG?=
 =?utf-8?B?MWFFQ3N3MHRvdUhFaXNYM08rUHp6ckMrNkhFc3pnOGlQRVgrV1hjMXBkQ01k?=
 =?utf-8?B?N244dHlJcUFzcG4xTzJFNWgxc0RSd01QdDVheDdHM1c5b1JmeCtSLzVLQTQr?=
 =?utf-8?B?cExwcWVtcWk5c1g5S2pJQkR0OW9XN2JFUmxXZkxGenRoamVkOVV6SVMzUytx?=
 =?utf-8?B?UkN3TGM3SmRTMC9zZ215cCtRUndtbGQ1blF0WmVvYzJWcFF0SXkzUkJNQUg4?=
 =?utf-8?B?WGxXOENteVZ3ckc5ZnJZTWZlS1psS2dyandHZUo4eHh5K1R2clIvQ1NyWmdz?=
 =?utf-8?B?ZGloL1ZiV0QwNk1TOUp2bHRMdXBWTS91Wk9SY1dqeEdzajNuZk5jdzlTREpB?=
 =?utf-8?B?V2FiTU4wLy9JcExwVFVXZ1pmcFQzYUpKdlpnYUkyV3NRRmI4UDR1QjB1RVJu?=
 =?utf-8?B?UFNQN1FKZDZCNHJiaE1DWVoybVJKdS84MVNLL1lNTm9uZTVWdG5zK0p2ZFJz?=
 =?utf-8?B?dkd4VjMxYzBZeUJFYXpHTmRPV3BYVlV0WGZGZWF1QlJzU3BVSHZRQWRFdlhk?=
 =?utf-8?B?L01udUo5Mi9WdFVuL3Q4Yk9IYUpGMU14ZnVmdDJQN0F2Ri95WjFtckNPRThm?=
 =?utf-8?B?UWtPUUtZTjh3dnpOMEdXVWdoRmppWWJXVVZQRmg0clA3eVZlOUlzNDdISWhi?=
 =?utf-8?B?RGh0a2FwaUR1WjN4d2JMSFhhTUV6OXg3d0lMOVIrRmRwcmV2dWZOM0FSQmdT?=
 =?utf-8?B?Q2RKUVRjeDBhQlpldkVSV09SazB1bWIyQ3JyS0lSVG94VG1oVThFRW8zVTVn?=
 =?utf-8?B?VFpuT01pUzdzUzNDbnlpTWQ5SFFQWVJTV0pJU0pTZU5WeXdIN1ZjRC94eE5B?=
 =?utf-8?B?bzZocVB0MFpkUGt2bkdSTkJHWkpseDR6ZE1Hc1VoTlVteS9rVXVublQwWUFC?=
 =?utf-8?B?N3VJKzdjWk0yczRUS25PY1hZbnJ0U01PcTlsTjlJTXZuMzZ1SHM2dHFWU0Jo?=
 =?utf-8?B?Z0lvOThYZjRIam1meFBaMHkwejdCdDhPQnJacjFUQ1EyM0hYdHREWk1idG5O?=
 =?utf-8?B?Q2crU1VFekYxVmZ1ZGcvWkovZDNic2kvOWhIWkUvWFlORytJYW85eVJiODlp?=
 =?utf-8?B?OVMvOGI1VFBiamM5L0FVSHZmUmVwT1hNMEY3SWZjU0NuemkyazhNVkQ4Mk93?=
 =?utf-8?B?bFhMa0VlUnRUbjB0U3FFQkJJL3c2MEJPQjdtY2lZVkZMdDNRRit2OFNvekp0?=
 =?utf-8?B?YkhvT0NuVHhPeU5uOGtMbjM4RVpGMHRsOGw4VXVrY0RscjJMODdoSFZVTHNN?=
 =?utf-8?B?RmtmeCsrTXBpeTRiV2sxZS96UVRTcEdrQ3JVVzk0bTZqa2NNamhSOVowcVV3?=
 =?utf-8?B?UVVXNnYxN1pXY1FBZk5KOHA1bWNxaEFCMTEzR1ZkMWhMRXN3ZTNiMlcrNXpC?=
 =?utf-8?B?MTZvbS9oUzIxSFhjek1nWisrM3JIdmNiaFhWampIV1dxRDhQS08yc1doZGJJ?=
 =?utf-8?B?Zm1lMHd2MkFBYi9hSXFTWjkvY0lYSVV0cmVmRHFCWHQ1V3ROaHFhdkZvQlRv?=
 =?utf-8?B?ZUR4UEY4cVpiYjI3bjArYzNuTFpqRURsQ2JVc2tYdnBmNWtaM1o5UGFOMGxv?=
 =?utf-8?B?VGlaaXBNL0h6YUY2TzZ3QnlGTGM5OURITEgwN2VoRk82ZXh4TFNFcDJWMGdQ?=
 =?utf-8?B?cXFZbkFqN0kweFYvMlQ1SjljenVkbk8wSzhUd214ekN2eDNVdEZzOUZLT3pZ?=
 =?utf-8?B?Mm52cWZ3Zkk3WU16bi9qRVd4ckdjU2FuRGpoeGEwY0MzL0plZE4wZ1hmWXdB?=
 =?utf-8?B?WTdqOFhIcmJsdGJGSS9KWERxNTRuM2pFV0tNY3oxeDV3ZWQ4cS9VWVltZXRL?=
 =?utf-8?B?Nmw5Mm1qbVhpUEt2bWVoT3FMY21aNlc1Q2JSMjJnT2ZabTd1U0xBWUJsNDdl?=
 =?utf-8?B?RXdtRGxqMGNYV0Zxb09GemRnMURRWkhmY2ZpWW9Ick9uUjkwYkdhRU95QUs5?=
 =?utf-8?B?VkNHNnB0T1FzRVV3ZW1qUjdqdTNhYmlhNmRueVg5ajhhdVU4SW1aeVA3SDlB?=
 =?utf-8?B?K3NtMU1TaFhKc2NBVHZyZEkzYXBZdTRNaXkrS05OUGVHTzJNdWNGMEFKSnJW?=
 =?utf-8?B?bE43VG5uU1ZhSkpGU2FnRWRXZ3lnQk05cDhQSVhLZXRwRkc4Z3dPcTZOVDA1?=
 =?utf-8?B?SUNzWXVOM1E5MjhBUkJ1TmtRbHh3aEFFUHgzQTFBMUR5UWRkT2tnSWt2ekRn?=
 =?utf-8?B?QlZCR1Y5TlhDWkx2b3kxWVVYMjBDV1luMWpDd3Z2WkNnVXdmVHlNS1NPUDNZ?=
 =?utf-8?B?QWxDTVZTMCtyUFpadEFDOFpBUTltVlF2czlsYVZLckpmclVXUVM3dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a659cc-52d4-453b-dfe8-08de706c69f7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 10:40:07.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDXAemE5DgRR90c8fLolo1khV6LMzvkBhCPBlpeRf1acMAOKtJ8ztd4G7SuWYTkTGM9ihfQ1KkIWUQbsYGVVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217559-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 98CE1166E6C
X-Rspamd-Action: no action

On 19/02/2026 22:29, Penghe Geng wrote:
> Move claimed and retune control flags out of the bitfield word to
> avoid unrelated RMW side effects in asynchronous contexts.
> 
> The host->claimed bit shared a word with retune flags. Writes to claimed
> in __mmc_claim_host() or retune_now in mmc_mq_queue_rq() can overwrite
> other bits when concurrent updates happen in other contexts, triggering
> spurious WARN_ON(!host->claimed). Convert claimed, can_retune,
> retune_now and retune_paused to bool to remove shared-word coupling.
> 
> Fixes: 6c0cedd1ef952 ("mmc: core: Introduce host claiming by context")
> Fixes: 1e8e55b67030c ("mmc: block: Add CQE support")
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  include/linux/mmc/host.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..ba84f02c2a10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -486,14 +486,12 @@ struct mmc_host {
>  
>  	struct mmc_ios		ios;		/* current io bus settings */
>  
> +	bool			claimed;	/* host exclusively claimed */
> +
>  	/* group bitfields together to minimize padding */
>  	unsigned int		use_spi_crc:1;
> -	unsigned int		claimed:1;	/* host exclusively claimed */
>  	unsigned int		doing_init_tune:1; /* initial tuning in progress */
> -	unsigned int		can_retune:1;	/* re-tuning can be used */
>  	unsigned int		doing_retune:1;	/* re-tuning in progress */
> -	unsigned int		retune_now:1;	/* do re-tuning at next req */
> -	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
>  	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
>  	unsigned int		can_dma_map_merge:1; /* merging can be used */
>  	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
> @@ -508,6 +506,9 @@ struct mmc_host {
>  	int			rescan_disable;	/* disable card detection */
>  	int			rescan_entered;	/* used with nonremovable devices */
>  
> +	bool			can_retune;	/* re-tuning can be used */
> +	bool			retune_now;	/* do re-tuning at next req */
> +	bool			retune_paused;	/* re-tuning is temporarily disabled */
>  	int			need_retune;	/* re-tuning is needed */
>  	int			hold_retune;	/* hold off re-tuning */
>  	unsigned int		retune_period;	/* re-tuning period in secs */


