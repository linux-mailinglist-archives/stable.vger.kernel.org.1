Return-Path: <stable+bounces-88100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D79AEBBD
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BAE2855FE
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B21F8183;
	Thu, 24 Oct 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkqJJ9ag"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB51EF08D;
	Thu, 24 Oct 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786768; cv=fail; b=AgQuMX1OOMAdRFmaIyHLUNljow2wwYAIC543PKyK28RbD9M3vLqQPX3EZWCwq7GLHymZnSyWtZwNb0l8Ji1Oc+LAWJn/7v/f+p9xx8ZimBIVxnaE0/6GDmGWVZfiA7J260joGp3aufRNh95sKR3gOu4IkKWsDmI7RAZVmjpuh5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786768; c=relaxed/simple;
	bh=6PiIAablMTPWbJWmJDTlnmqs9S9ClIiBKjE5IvpyLzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yw9cW682yvipkxjcx5fGlUsHyz0ZrMYr6Xa+OwcLUpmM5GJEtO/0+4aCFDPRLh54y+OYhdB1HxWaMMNS60KrEYzsd/nYMucwyWS1RtP5TOj7MJ3TlnLsuFlmL3jic9tvNxGBztfAZ+FTnrSdsuBdv2Oms8VqCS/fQ4Mu43/9fP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkqJJ9ag; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729786766; x=1761322766;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6PiIAablMTPWbJWmJDTlnmqs9S9ClIiBKjE5IvpyLzY=;
  b=DkqJJ9agYDmZSsbKR+gA8zeKZb7Tg0tVVBCbBvWBOz2lpwPslyRKCw5X
   V3yYeTqk1/eMWcb2D/0CBXTFUZSTHwZDQwUNdNluwAnsLm/CQRxUAr7bC
   NgCXoxNZ+SpF5tm3ftDuz/bo4PRfYkc7OTFN71xFjrCvD7m537yA0Ub0t
   tYU9tCj5yJCz4vUML6Btd8eHdZd9KLbD17ZkBkbcvhbjgPuMD88W+jzOQ
   8xDauKbBoJEcbyX72vUs40tAER9I2vTtCGcvbEISbnvTiee2DiqFTyMQJ
   T7k3XuFNxy7eCc/1QkYKKeK4bcM2BhrJXG3LVp7ga8r/8sTNWdsX75TzF
   A==;
X-CSE-ConnectionGUID: 7grkmZIqRjOjBF60MPsGgg==
X-CSE-MsgGUID: WRtC5YGiSJWaJP6Imqan6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40542164"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40542164"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:19:25 -0700
X-CSE-ConnectionGUID: XsHbWipgRj+Pa4DpOLkl+Q==
X-CSE-MsgGUID: 0fiQbvZISHCJ5LBcScUNnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80289798"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 09:19:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 09:19:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 09:19:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re86K7ufYFWAgSu86xJYkyYLTLEgysOPUyJyMnj/Gff9gBwgodjUcpPuqGQPBj+++wgmviTia0+N1ocmogtstpd6MO6HqG+A2hZ2/P4aFpVGAWI5iebSefP36k9iZiwjFKWTkpsUZ9+Z84Y8vxWREzRFdztqR/DSXv1FgLDVsLfM2qnnkG2YARR0xNzDpBBb5UlwMYcWlmYTGnsVe4N73aIrh+Kqqu8x6j3dji5b1IITWKCWDqQ8F+GH5WK7RS9RifhLyheR1XNFgdaVuk8R4JkMFVVs0EorRQThD62Bbcx8QVk6b/4l+VMSymEgYJaiLWy530Yux3SyDGpxRBez3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjXex3BgFqKVElYNK+aLCg94YsuNC2AAgxxJ0YCDTr8=;
 b=gRSIFgnJNTZJZ/3f2rS+9pJAWt0lFH3sam5x2WkdRLPzDDrnrNJuwN7Txtxh8ppHTp74whfn1/RdLsKr0xIoy7I8OqBnOJWaZmChLHqT4Tikg70I/paRdZdTsjrJaVVylroRWZ02GSOHxqn9oKMpCUbHFzIjQTOfvoZhfntoe6QkYMdZ4kK1N/CBkAXBk6n3bPk8GkSt8dZQ5++fokB9xbuMf7qkc0On1xoC9JVHKdiZBVNPenBzrfRfW+84qeKKaKrka26o1NpMVp7Cn0LXYcPVkRFcm1UAFvXoYm+d5Sb20oAVXS2ZhQRZpnupvPsdBDlynX1/idNn88R2WTTpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 16:19:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:19:19 +0000
Date: Thu, 24 Oct 2024 09:19:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, Gregory Price <gourry@gourry.net>,
	<stable@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <671a7384ec43f_10e5929493@dwillia2-xfh.jf.intel.com.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
 <20241024104237.000067f9@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024104237.000067f9@Huawei.com>
X-ClientProxiedBy: MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2005600f-eeda-43eb-f196-08dcf4479cea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGZXQTRZelc0NDlZMElpMmhiNWtHSGMzMjZHUy8zc29WUmtYVUQwOS9LelQ2?=
 =?utf-8?B?MWhGQmZoVC9YUTErMXNDSGVXR3hhLytRNXJWcWErTnJsU3plNmsyWGM3aUtH?=
 =?utf-8?B?R2JaUzBCUlAzY2NwN3FhZGhtKzEwU2RoVy96bVRSUlllRFJqNWp6LzNHNWxD?=
 =?utf-8?B?SFVVMEN6U2UydVlZdGdFWkJ5YUg4YW5zbXNRYk1nL3JRSk02cmVGVkJFek9n?=
 =?utf-8?B?MThUd1FhRS82VThsZTFseHdoZHE4bzVGWHo4b0VodUhFakgyNmIyNjZuYmNw?=
 =?utf-8?B?bitpVGY5eTZFcG1SOEdnQW1lbUVmbUdUWlZrRjg5dnM2MzQvWE9EMzl5L1R2?=
 =?utf-8?B?UFdEblFuM2t4L3BVTXFYelFQVmdjZFFaSnFjWXA4UFB0TFpleFp3NXJUUTNX?=
 =?utf-8?B?K3FZOXhrbVB2QkJ5WTRKOGg0d3FmSEdjYTRrYUZIeGRLbVp2S2g1K0s4MVQv?=
 =?utf-8?B?aUpoY3NuSnpFbkhDN2N2bktPdVpsYkJENU44UjdVNVZhdTZzaTJzdEhyOUFP?=
 =?utf-8?B?akVwbUl6bVZwVlJ5MjhnbjEzQUVocGhQZEthMDJCMXdJOVNGQnFxSFozZUVr?=
 =?utf-8?B?Vm1TT2Q2ak1FallnTDI3aUl4YmJTNDdVKytVY1hHVGFTQTh1NmpUckNFZFBs?=
 =?utf-8?B?U2srTFZ0dUNSS1FuR0R2eG5GNjVBd1g2RFNQdzZpbzBnNldTallWbG9wck5W?=
 =?utf-8?B?MHJ2ZmdEWmNhelRJbGU3U2Q4SXZIYWNYVFJNVWJCL1lFRHpSYXZDb3h0ZFJU?=
 =?utf-8?B?Mm5HWkE2T25CUHRZaXVFeGVBWm1tcXJNZHBVWHFYNk5lUlVKcGVjcFZUODFL?=
 =?utf-8?B?Z1BkUTBRYjhWNGt2VUFaV2o2dmxuY0pIcUp4OWVOZ0Q4eGR4blVpWGQ3THJV?=
 =?utf-8?B?WTlMOEtwRUQvR1VYcDRwbTlTQ3QyNDhCRjJUclhPK1htTG9vVzFpUUZlTEFl?=
 =?utf-8?B?a0QxeDJxZVBzWFhDSEdvVStkaDhuTm5ZSlVuZ0RWRnRoVWtBT3NqdkZ4bnNS?=
 =?utf-8?B?b3czWUhqUW1GWEo4c0JuZjZyUGRDL2o1TDhYNnpaTnYzdzhOK2RTNDNJcU1j?=
 =?utf-8?B?aHBPSG51Nmx0RWNoYTFDM0RTQ3JpczVsWVM0SUhqWTVSRnIxY2tLUlhTY0RX?=
 =?utf-8?B?RWg3TDhNeGlLTU5qeGkvb0FzQTdxNC9iUjVnd1FqM3MzZkd3Y3U4UDlIcEtC?=
 =?utf-8?B?NDZBa2NBWnl5YWFWTmtmV3hsUkZBZHRYNnRvelpzOS9EQW9FOFFVWnJwMkwr?=
 =?utf-8?B?dDZyeVA0TENadjFHOERkYnZ5U2JVcHBBMWVpUzkwQWZ2SVRIMHM5bFBHQmlu?=
 =?utf-8?B?Ym81SVFBYmYvMTY4MU5LbG42cEJkUzVQMFBRWURiT2NodlU1d1lZMGxVUE9P?=
 =?utf-8?B?Q2FJSXJ5eWQ3VGFIZGZ0Vmp1eStrdjJLbzdCQnVOemtzUUczSmpMcnREa1hh?=
 =?utf-8?B?cTZMa0UycVBGYnJRblFqOWJVaWduTTIvaGNWWU1sa21IZWw5L3d6M3RvdSs1?=
 =?utf-8?B?VTRRblAwaVRiUklUUzFpVlhEVWI4ZWpBK2hGN01Cb29BV1JMaUttbEh2MFhF?=
 =?utf-8?B?L1JOc20yK3pQYU1aYU5EYVZiMTJXTnNpS1ZGOTJDdUR6eXNiUVRQdzJpWldy?=
 =?utf-8?B?NUxnb2VDWkpQUnVDZUI0Vk5GVXFLTS9wektDOVFzTnlaM205bjgzT1BkVU9R?=
 =?utf-8?B?UmNoTWp2SU1jUkVPZU95TUJkYWdHK1ZoZFFhV3dFQWhWSUJXWW5Ha0RzT3B4?=
 =?utf-8?Q?z8GqQsQWT4ZMCP5cI/jxuL2XCoybD6r1eeXj0ya?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpQS29KMmtWTTRaRlFpYU5pS1hZcFRKZkxCVmtOUVMyOCtCblZxd1lUOGJR?=
 =?utf-8?B?YWxFM2tMbXlsd3E5TFdTdDZpWUIrTTJqMjJYSmpsNktwWEM2VXdFREJ2c212?=
 =?utf-8?B?RGVpbWEwc2FWRGowMERDWkxxRVVCY0xCbWc0RFpRaVVLQk1JdG5sMFVFMjRH?=
 =?utf-8?B?SjcwdHVEVDdBN09zSm9KY3FleXByaFhpWDRXYVNTMVVIMk1JQlJtUGFuWTRz?=
 =?utf-8?B?bUUwMnJHckxEcndpdFBFaEQ4bFZ3c2Z0WmJjSURaQzhYL3d1YnNHL1FjTGo3?=
 =?utf-8?B?M3VteFgvRGlMbnh5cStuYTkxK1JRKzBRMFVFYkFSV1prYjBUY3hEb2EyTytj?=
 =?utf-8?B?Y2hxTU5kOWV2WFNjamljS1E0Ui8xLzg3NGtzVng3OC9zQWlKb2NQTFY0Q3Bs?=
 =?utf-8?B?K3NwNDZycERMWk9zS0IxN0dOUmpydmE0OENsK2JmQms2M0JCTjdQTE9vNm9m?=
 =?utf-8?B?VC9ReGttQXcvcUx2Tit3YXJWd3VTbjdicHdjbEs2VFIrdnBMaWp0eDc0Mkk5?=
 =?utf-8?B?NDh3Z1RvM2NpOTE1L0Y3WS9YaHBMeit4bEJyR2JGYjdWRlo2QmNVb2VIL0hE?=
 =?utf-8?B?cThqWDNUdy9WdFF5TzJOWmt6TmRLcnoxaGhoemFNa3JzZ0VFcVJMb0xJNTZw?=
 =?utf-8?B?WW04UFhaRGNQa3F0VmZVMGtoSXNvY2tGcTg3YTJCdFVPZkMvNUxXQU5wa2tj?=
 =?utf-8?B?Mk5PdmVyRFN0dXREeWc0cWIvc1lDVjBZUzZGRlhqWm5TeG14dU5tTVZRNjZx?=
 =?utf-8?B?dys1TWwyZkt1Qm9YOG9MdENYd2VEalRlb0JwZ0ordThXTnFDU0I3ZzBjVFg5?=
 =?utf-8?B?enEvZ2t6WjVFUXNKaVdYNEk5WWs4ekdqaUpHWkd6RjFDY2VGcGh3RU15K3d5?=
 =?utf-8?B?Qk5vaEJkTmVHdTJvSEZ4QU5pWVNTdVM4K1l0Z0FvN3NtOWZ4VUQ2UHRSR2hW?=
 =?utf-8?B?SllSQ05Bb1Yyby82VGRaMWY5SDA2V3BlSnVBWUtJM1l5RTYxRm5CUktIV2tS?=
 =?utf-8?B?Q2gyQWlEcjFOTkhBWVp2enZ6aHpjSHYyazZ3K3JyS1lwbnVNWlFUNjdzM3M2?=
 =?utf-8?B?Q1dkbDZEbUN3MFVwL25DZ3o3NFV3d3Z2ZEZLVnlEaS82a081RGNKanJTRXZi?=
 =?utf-8?B?RkVIbWZOSHl2OFBFT3Evd2JlVXNpbi9tRXVvS3k2a3VwQjdrc09vTXp5R2tJ?=
 =?utf-8?B?eFp4Mnl6a3VvZHJFaVdteHRxdnJaRWsyaWdhSFgzTjBuYXVSNEhUaU1WQTlv?=
 =?utf-8?B?UUFIVDc2Lzkzb2FHSWEycFZ4ZEtqd1pGa3ZHb0JadHdFb3RPSkFDMXhrUmxt?=
 =?utf-8?B?eWxFWEdXanZpRTk3cGpuMWZITVFGM2IvZDZIak1TaUFnQlhVbVZ4aTByMGxu?=
 =?utf-8?B?TGFxNHpuN1dla2xTRXg3dHZlWmxCTDdYMm5rV0Z1aFZjaXFTWHY0QlFaUExJ?=
 =?utf-8?B?eGxjZjJkeHdTVEEyaHU2cVY3UXNkU2t0ZUwydmMzNkxIZ1N1eVhXcFhSa2l4?=
 =?utf-8?B?bjRxNm02Vy9uSW1FczA1ZDdIWkU0eG5MdlZTNUV5dW92Z3o2ZUlxeG9RaGM4?=
 =?utf-8?B?MithS1Y1ZXZaeDVVaHIwcGVFN2RQb3QwWElmWnVtWURYdTVscTdVM3k2alBT?=
 =?utf-8?B?VkNXYkZYekU1clFMOXk2bS9WRjVPbk9RYytPZkhoakFXLytMMlpvMW9HckNi?=
 =?utf-8?B?bVlWYWNpaVRFWlhhRGptL09tdGhvNUNCSXh5ZW9ZRC85VDRWVStrRWR2V2ll?=
 =?utf-8?B?RmFXQ1pySFQvTnJmOFYvRCs2ZFBFaWNBYkxuakFCOE9GUDVzQ1FVUE1IQ09q?=
 =?utf-8?B?SjhHWitMNnVJYmZFRzVXYmc1R3lkYjV0MmpZcEFpN1g4dkEzOGo1UmVzNmFI?=
 =?utf-8?B?VU0yQzhRdFo5WlFrQlh3Kzk0YlRsM1N5ZEM1UDg4ZWFrakRaelNPM2UzUXg2?=
 =?utf-8?B?VC8vM0U1blZvSUdhSHRuWFlQZFI4WTFYR1lJOFBXWFNCeURvZlo3U2FvU3BV?=
 =?utf-8?B?SXNrcUxGL2h6MFVqVTlHTjBJbVNOWVZwOC9LVzRGbUVQbmxjS0VMRzl5dWNP?=
 =?utf-8?B?UnJtU1dYbjFsZnZhUFZOVGhsUEtHRFBYWnltelo1MTZPUmsxVXg5T1NVSXRq?=
 =?utf-8?B?NTBDd2dGa0VZY1VRUTdkK3RKZisxNVZQWkswdzFDVlpyblRkUW1lY0NJdHlT?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2005600f-eeda-43eb-f196-08dcf4479cea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:19:19.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFK/4gHZugsQxm2qYZK6tkISdXOLwJ1QIhxpYQOVPP09X+stS7U+08esZDdQ8gQYBMwNcO51fdy743UJQoSEHDGJW8fP5sVl/WAX64BU5i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7346
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 22 Oct 2024 18:43:24 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > When the CXL subsystem is built-in the module init order is determined
> > by Makefile order. That order violates expectations. The expectation is
> > that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> > the race cxl_mem will find the enabled CXL root ports it needs and if
> > cxl_acpi loses the race it will retrigger cxl_mem to attach via
> > cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> > enabled immediately upon cxl_acpi_probe() return. That in turn can only
> > happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
> > before the cxl_acpi object in the Makefile.
> > 
> > Fix up the order to prevent initialization failures, and make sure that
> > cxl_port is built-in if cxl_acpi is also built-in.
> > 
> > As for what contributed to this not being found earlier, the CXL
> > regression environment, cxl_test, builds all CXL functionality as a
> > module to allow to symbol mocking and other dynamic reload tests.  As a
> > result there is no regression coverage for the built-in case.
> > 
> > Reported-by: Gregory Price <gourry@gourry.net>
> > Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> > Tested-by: Gregory Price <gourry@gourry.net>
> > Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> 
> I don't like this due to likely long term fragility, but any other

Please be specific about the fragility and how is this different than
any other Makefile order fragility, like the many cases in
drivers/Makefile/, or patches fixing up initcall order?

Now, an argument can be made that there are too many CXL sub-objects and
more can be merged into a monolithic cxl_core object. The flipside of
that is reduced testability, at least via symbol mocking techniques.
Just look at the recent case where the fact that
drivers/cxl/core/region.c is built into cxl_core.o rather than its own
cxl_region.o object results in an in-line code change to support
cxl_test [1]. There are tradeoffs.

> solution is probably more painful.  Long term we should really get
> a regression test for these ordering issues in place in one of
> the CIs.

The final patch in this series does improve cxl_test's ability to catch
regressions in module init order, and that ordering change did uncover a
bug. The system works! 😅

Going further the test mode that is needed, in addition to QEMU
emulation and cxl_test interface mocking, is kunit or similar [2]
infrastructure for some function-scope unit tests.

[1]: http://lore.kernel.org/20241022030054.258942-1-lizhijian@fujitsu.com
[2]: http://lore.kernel.org/170795677066.3697776.12587812713093908173.stgit@ubuntu

