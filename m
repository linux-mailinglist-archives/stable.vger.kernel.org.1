Return-Path: <stable+bounces-100840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFE9EE05E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E38283D4F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5920B1E3;
	Thu, 12 Dec 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3ujLDzX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410425949C;
	Thu, 12 Dec 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989234; cv=fail; b=aNHK9TgARsKwj6JxwtXX6/rhQrat6XLUtWY6xL9MMBTPD+PJP0Oq+msS7NBaKq+g8vN7GP3whGvfYYZ6wYQrFwfj7e/9COLiN8+GFVJCw9DbZKwg19EfoWjDFgREced7dvOEAUGEvRlavYPy0fv8HjVtDRv0uLCu25yH9EDLYFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989234; c=relaxed/simple;
	bh=fQO4XKdSp8aOf5VCrlPVnAXEeKZCM4ngcte3IMNgMTo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nth+TjN2pWpmVUe2SDj06gUwNXBdahzkTqQKWZSlRChOXVnRBDphQwkXUR9+yHBAkdQbNe1De45XBYwbzdWQ7PNAfQHQ75Lic770TQ0Q94g9xIt5ma+KxITGYJWPiikNwjWZzoLwz5viX7oizCnaek/6sqOQZ7S/fUNZ+FgE0o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3ujLDzX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733989232; x=1765525232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fQO4XKdSp8aOf5VCrlPVnAXEeKZCM4ngcte3IMNgMTo=;
  b=I3ujLDzXrkX/X0ciVG2yRyCz3QrCUPzzMmURj1BJlD/TKhy2VIW0CAFE
   /s1rQmBkmVAlGyPahvfO8QiZr60dJ4qtVGMWw5ZlRvwoIwNxEWDOmxIPs
   //qLFZ5ONbC4PiVPZ9N+b+DQpGok9hsT/rSVwH/gUq5IFmiKNmlHqVbSJ
   qL7ujpTI00ft3JY9YzK1TeaynbgB69pcHkHe1qZ/WOOE+Cft1NtEKNAZ8
   9pEh/UJqWXlcq2QNK6r9ycghYHnLyayo85vOk3EpGwkSEXliPia6qnw3t
   nzGBxp0tftjqyfq+a+h/zDwwaQVCc+rdAkd7Y6bNdhGVtitJ5fgddighn
   Q==;
X-CSE-ConnectionGUID: V9vY6BQJSR2wm0Bs8wXgqw==
X-CSE-MsgGUID: 0p1eBZnTTeabKq2QkDLmtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34302154"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34302154"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 23:40:32 -0800
X-CSE-ConnectionGUID: 7ZFRr7u+SVK7Ra/2RFdVIg==
X-CSE-MsgGUID: eIU7whdkT5a/tRXTgAz5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133530750"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 23:40:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 11 Dec 2024 23:40:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 11 Dec 2024 23:40:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 23:40:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+hbznFR1dkHiTk7Un0lWjxescxE0HEz49pG49dIMYAi4yId2j2PGIluvXdNfU5jER6uazjCz/B+3eG3/iF5DRPOstIgpJZzo1dEnkwqPIZBVC+ota8d8YmXOQAyh0HDZfrLOb2iqZbein/rh9EXPHRMrNQ+DDDnlBNSvkXKLq+Zf1KroE7uAY+7WnyWowpfViX4QxosHC/XgbgHDQch2LBdRslUexCb+K+q2J4e7N5a4/xDpnjTcpaxlg1Y5sE0O54EnBcwLhOVr9TdEnFnpRr/THgEegTbPGHFWMQEg9GtIEiWejvJRQhjlVOucx7EGXDHaDGTbJwrx9uiX2ADRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq0RM5JdSqLXss80EdlMhq32QixIiYyBKDlBJg7t+w4=;
 b=BgGPCyTjbIoY8coFr4GbsaTjDmxR7jYAyN3Fbn4UY3XwHquHLGpbMPU8d+PmRkKQ3IoJL4NHf7P4Vw21Gp1uhz0h3PxX0av8DWspgCAaH5HjGgYUP/LOEb5GJSt9gwTX/4PgY+WSk/km+s8uEGGy7w4XD+96mYZQ1KHeR8zv3xEcMtKt8alzTLLajDLQ+x/VZIe+d0kf3MTm+zUH1iUauR1yZQTwnwkQ/HLNu4D2KEhaC020/D4j4bo3WItciF1acYP4vRQbOp9mgDPE5vJX7pSfj9RaF2w+6YfwOcZSbwYyrQy7znpX80Sps4PJdC3HGplm9u9B1mQMUpoy1o0gTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 07:40:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 07:40:01 +0000
Message-ID: <760e2a44-299a-4369-a416-ead01d109514@intel.com>
Date: Thu, 12 Dec 2024 15:45:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <chao.p.peng@intel.com>,
	<stable@vger.kernel.org>
References: <20241212072419.480967-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241212072419.480967-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd0bc82-0280-4ec4-a855-08dd1a802f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3VCVjJpV1Z6QTkzb0ZYRS9RRUxVWmpBcHJoYktMeTNSUDdZay9PRTZuN1R5?=
 =?utf-8?B?ZmRXUjFHTDdsYlNTeFZDekFwN1RPWVdvZkovWkVONTVXdGdCU0RXTDR4d0Rr?=
 =?utf-8?B?cjA0dGN1VDFXak5xcWhqWHpXU3k5SFkyMnlPQUxDRmdjeFI4VkFJbXdPUzQ2?=
 =?utf-8?B?NHJpaklzNHRCR2l6Y2xCZVNkV3JBck5NMyszMXlPOE90MVZIcUlwbFVwZ21O?=
 =?utf-8?B?c3pZZ3dxUUU5MlFPdGllUVFTd0xkRW5Vd0UwL0IvKzBadU00MXFERmpIaFhq?=
 =?utf-8?B?cFJmR1pOVFlhRnkzRGU3RHRobHJEeEpFRm1IT1BHcGRJZHpJZFh4eGxPa1FL?=
 =?utf-8?B?alNIVXdGWVVFQjRtZzltd0dzV3NXN1lUNUsyUXRGQVB1YUt1NmhUSmZxTFk2?=
 =?utf-8?B?OWJRWWZrQ1FRdHUvK0gxRnBrM3Yrd2dWbk1aRCsrMzBwbTdGNlQvazJGL2tO?=
 =?utf-8?B?dWlHMlpIQTIyZzE3OEU0OHRjcHpkU2tnb3ltejlLVHgweGU3TjdZbzZJWmlh?=
 =?utf-8?B?WTErUVNNdUZtVzRuM2NPYWJLR0tGUEt6NjArZy9xMy9xTUxqZ2J2amJpeTZi?=
 =?utf-8?B?YmpKSDJYK1NlT2pyVnc1RUZveFpVQ2RweTJWRFRjVm1BQS9XanQ5Wm1NTFRC?=
 =?utf-8?B?U29jSDNQZGp6TXY0OVVUWWsrQ3g1K2JBUG41T2xJcG0yMUU4Qkt1Mms5UEV1?=
 =?utf-8?B?aFY2VlNsK29lS0VpY0ZvYnNtSmhsUGtnWm5vY05wQkYyTDg1U0pFZUNkN1B5?=
 =?utf-8?B?RVVxemJxWDBnSUtkcmVFSnY4dVJjNGZwQ200VFBnQk54Y0ozRDNVQVN4Y3F4?=
 =?utf-8?B?RnNQS24xMExkYVZoYW1wS2lUUVVRWG5FL0FibktTZkU2T2ovWGJDcVNOak1j?=
 =?utf-8?B?S1ZSa1RVMVRVYmc5ZStFeFBFc0hCSStJYjJrMFlObWFFTFlMUnpQT3A5M3Qw?=
 =?utf-8?B?YVA2a01wNzByRFRHQ2pLUHdBeitpNko3UmZiU3BjTTY4czRCaTRjNTg3UTcr?=
 =?utf-8?B?QVYrdUdFekRBTmNuSnp0RC83aDJRZ2VFSjZ1bXF1YVBDNkFRTG5JbEJvVlJY?=
 =?utf-8?B?TTNYWUNtMjdYV2dyWkxoTjZka1k2VUNTSWJPMlhRSDJDZlVPVVhOSzFxamtR?=
 =?utf-8?B?WGVNUjVEcjFUbnpGMlBFRVg1b0s2N3JWYStOQTNEUDR4N0FrZWI3MTByRVR2?=
 =?utf-8?B?SVpSR1NTRFNrS0Zrdk9zTlF6akt6ZTRjWlBhaWJvU1FjQ0Y5NzdiMkVLZWdu?=
 =?utf-8?B?cEdEdmEwd1hYek44cGhrMXVFWHN5bkpYblNCbEc0c29JN2hibkJYSzkwM2Nn?=
 =?utf-8?B?aXdQc0J5UGtCenlacFRpQWtKSGtpVUxpWmcvaVNQeVRmU1BZZTVJQmxqYmpy?=
 =?utf-8?B?aGdGNkpTZHNkYitSRXpNN2JJRUVFekg5YjE5SmVjdmwybzJDa2owcDdyKzgx?=
 =?utf-8?B?YkJPZEROWTJqSlg5RTkyNlI1NGdDVEtIUFBWT3RNR3dIMW53KzF1bGQvNXh5?=
 =?utf-8?B?N0k5bzdCMEtQU2tURzJiZGx2RTRPQzhGTFVmQlUzd3VHaFFUVGY3cVgwc1h4?=
 =?utf-8?B?WG5CbDJEZnFDaXFjcFI3YmxhWm9KSVQvdXppdDhhWVoxVXIzbmw2b2xwSTFi?=
 =?utf-8?B?cXNtODdaUXpFcTY1MEh2akJnc20venpKZ1FPZklIWVZUYU50YWEySHBKSDdo?=
 =?utf-8?B?ejhhbERnZVBlM3lHNGRBdE4xRzMrdWFXcnFVQXJrVVhhbFY1aWZ1V2VPRWVs?=
 =?utf-8?B?S1lkandjR0ZCN2ljSXh3UlJzbnV1bjY0SnNOZVBRM2ZEQmEyQ3ZZRExiZzhh?=
 =?utf-8?Q?cogVdPSm7/1UzEijwpVG1Kj5lugTs3Lv32Yq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNGVjVDSWUwVWo2SllKRGpyVlkwQnZVTkxJeW1qVlg1Ykdtbk80dFBTa3li?=
 =?utf-8?B?bENVUGFLVllIM1NEcFdQQkw1ZmdGN2dKYm1EVHRWemhEdTRxRTJQcG4yUzcy?=
 =?utf-8?B?UUVySnNrTmwzMnFBbUtkTWIyaThWYjJPSDhJeitsNWRqd0c5cEY1cXp0OGVn?=
 =?utf-8?B?NTBmZFlXQisyYVdEUEFqQVN6TGtJTS8vTnFDSEpCRXczZFd2bDJyMy9FWVZR?=
 =?utf-8?B?ajNFSHBzanBQYkdkaWlUVVdOa3doeE1ZSXlzbFlQRThMMFhPcW9USmZDT3d2?=
 =?utf-8?B?eXVhbXh5VVVhR29GOFNSM2M4R0tKWENYeXM1aWl1cW9EUFJkUEQ0b05nd2Vw?=
 =?utf-8?B?dWlLYzd5MDJpdUdEdVhhMnk5K1VNUFZDVzY4N0NEWmZKT3JEanNQRFZiVXQy?=
 =?utf-8?B?dE1ka2RIN2NJLzVyNW9vMjNlb0c1TDVzeDhIMmJRK3NBRVpkTHB6QzZ1aHVB?=
 =?utf-8?B?VG1SUjRsazZwZEo3UWlzeDh0enc1eThkdVBLb2g5Q2hvTTFjUzcvRWtvOWU2?=
 =?utf-8?B?SzUzdjlZVTFTNzZxVkRGbHpLL1lLSkdjb1dYY01zc0RhNlRqdG9LVEhhamU5?=
 =?utf-8?B?aVFLaU5XdzRjM2FoNGllYmJZWFpnRm0rcGd3VVJqVWRqeXlGbUdiYXVZS2dH?=
 =?utf-8?B?OWlHQyt1eXN5NGRQMXVTblhxZThzT0ZLRFFBQUJTcjBpZmRZK0VzNHR3VmJP?=
 =?utf-8?B?N25TM0RLRlMydU9NdVhYM3RXQmlaQzF0cHZRSUZ3S1lRb1ZMQlIvSGU0SnFK?=
 =?utf-8?B?THp2TnpxRnpZUFJIakw1ellCdFBIalRpcXRkYlI0QndmTTA1RHZwbWxQZjVm?=
 =?utf-8?B?aFZjL3RmRlhaL29OU2xQZFRsTjE3OCtZV3NwQkNET2VkNnF2NUt6S201T1Yz?=
 =?utf-8?B?ekRlbjlUOG9wUGt5dEt0UmQ4bW9ha2crZ05kc3BKSGRoZVIzc3kyY0RxVjcz?=
 =?utf-8?B?a1JTNmdsRWNqaktMbDRPcUpaUndsU0FZQllXSFVBbWlOa3N1eE5OREEzTXYw?=
 =?utf-8?B?R25ud3hac3JrV0hNa1lWd3pRdldsNjZham5uaDlVaUJiQUtGeUVtMzNtZWJi?=
 =?utf-8?B?d0FTNm1SSEQ1TDNIWVQ5cVR0Mi9BS1I1YzZVeXhVU04vSEZXM0ZrMHkrWXBq?=
 =?utf-8?B?R2Z6TlNpLzBKQ01uSHlZU3NLakxBalFJL3ZPanpVR0R5WU9sRkl5TXZWMDR5?=
 =?utf-8?B?L3d0aTM3M09wMngyTHhCREIvNFBKRjRzR3RlNDNDVHlQSXBNU3JidzlLdVZW?=
 =?utf-8?B?RmE3QlVlc2crWmwvMGI1a2hmelpwVzZveWRRM093Ty9GMEV2YnRhWnVWVlFp?=
 =?utf-8?B?M3FKYUpENEZadnVqWTNHem5vZmpJOFpHQ0FBSlZOMU5jY3c3bWdDQmU5eTAy?=
 =?utf-8?B?TzlSN2hrQnh6c2VBQnUvZU40TS9pclkrQWxFZjhNbFBLTGhyMmxKTG5pNmZZ?=
 =?utf-8?B?MUhuMG52T3JRWmFwdVNGd2daR0t4ZWRRYTdiMUdtSkNVdlEwNjNRSENQVGJG?=
 =?utf-8?B?cFhPdklwTko3bmlhZ1ByMVZmSHA1ZzNBYzBpb2FiUEVsKzM3NHgvL2ZRbHVD?=
 =?utf-8?B?Wjl3Q3JQMTI0U2NWeklOdytRMnc5WWxndFdaSVNpUnMyTVpkMkhESXRJaVVS?=
 =?utf-8?B?ZmNtbi9lQzRRbEwxTWZnaUQrd2hRa3ZpOWZpSFRzRVlCS25FK240Mlp2ZUtR?=
 =?utf-8?B?b01ZbFhscDVWdkpoeHVkdjZsTU12bE80Z2VlZm1xSS9DMzRMcFpPSzZjNTZT?=
 =?utf-8?B?S0RhOVdrU1pHb0lTdjdIMkpGZ2JIVVNHUzhLSGhBRVdhQzQ4bzBFcWFCRWtO?=
 =?utf-8?B?T2RmbmxYMWdjaG9EUlAxQklYUm9iVHlrV1ZXaWc0ZHBRZG5rMVVKcHNvVGxp?=
 =?utf-8?B?RUl1b01VVnVtY0FDRlRnKytPZWxoYVpJNDgvN1VsVGRVeFlvWlNXVGllaHFV?=
 =?utf-8?B?cmphTnJLZm5Yb3pDVlZWV3QwRW5mcTUzN0x5a2hNR1hpQU15TmNHbEtNYTFL?=
 =?utf-8?B?em1LMXBOQ0VLMGhGZmc5R1dNNTU1M1dwRUYrRDA5dEMrSklGZ3A5bzRxRlFk?=
 =?utf-8?B?a1ZHTzRYNUJLbjdQSk5tWnBtZTdaZm52TUUzMHJGdXMxd251Q1RzZlo2NmY1?=
 =?utf-8?Q?itUsA8CIKxKdhTz4HSeKqB6AO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd0bc82-0280-4ec4-a855-08dd1a802f87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 07:40:01.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfJxzG3LbBwC5gNlRy2xccDLyn5fYZZ1hDP8XAMaPwdFI5C3O+EFLlg0BHCKBcPpHAwhqvr/j0h22q4pkwNWWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

On 2024/12/12 15:24, Zhenzhong Duan wrote:
> When setup mapping on an paging domain before the domain is attached to any
> device, a NULL pointer dereference triggers as below:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000200
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   RIP: 0010:cache_tag_flush_range_np+0x114/0x1f0
>   ...
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x70
>    ? page_fault_oops+0x80/0x150
>    ? do_user_addr_fault+0x5f/0x670
>    ? pfn_to_dma_pte+0xca/0x280
>    ? exc_page_fault+0x78/0x170
>    ? asm_exc_page_fault+0x22/0x30
>    ? cache_tag_flush_range_np+0x114/0x1f0
>    intel_iommu_iotlb_sync_map+0x16/0x20
>    iommu_map+0x59/0xd0
>    batch_to_domain+0x154/0x1e0
>    iopt_area_fill_domains+0x106/0x300
>    iopt_map_pages+0x1bc/0x290
>    iopt_map_user_pages+0xe8/0x1e0
>    ? xas_load+0x9/0xb0
>    iommufd_ioas_map+0xc9/0x1c0
>    iommufd_fops_ioctl+0xff/0x1b0
>    __x64_sys_ioctl+0x87/0xc0
>    do_syscall_64+0x50/0x110
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> qi_batch structure is allocated when domain is attached to a device for the
> first time, when a mapping is setup before that, qi_batch is referenced to
> do batched flush and trigger above issue.
> 
> Fix it by checking qi_batch pointer and bypass batched flushing if no
> device is attached.
> 
> Cc: stable@vger.kernel.org
> Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
> index e5b89f728ad3..bb9dae9a7fba 100644
> --- a/drivers/iommu/intel/cache.c
> +++ b/drivers/iommu/intel/cache.c
> @@ -264,7 +264,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
>   
>   static void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch *batch)
>   {
> -	if (!iommu || !batch->index)
> +	if (!iommu || !batch || !batch->index)

this is the same issue in the below link. :) And we should fix it by
allocating the qi_batch for parent domains. The nested parent domains is
not going to be attached to device at all. It acts more as a background
domain, so this fix will miss the future cache flushes. It would have
bigger problems. :)

https://lore.kernel.org/linux-iommu/20241210130322.17175-1-yi.l.liu@intel.com/

>   		return;
>   
>   	qi_submit_sync(iommu, batch->descs, batch->index, 0);

-- 
Regards,
Yi Liu

