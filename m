Return-Path: <stable+bounces-100870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0479D9EE2D6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDA31889AC0
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355220E6F6;
	Thu, 12 Dec 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZ0gtLwr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953920E6FA;
	Thu, 12 Dec 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995460; cv=fail; b=OurCqN04DtiGqebmJoOzSQL1woUxJ7BR+wHbK4Ljm4/KLdzH17TDwxNQMJiMggZo4wxXBA+9t75Ff7sxBfh3PxI4DwVJzUZtzFAR1YO4EXXxc7gnJQhoZd53+JG8sTN7NoWmN3BCMQ803A7LP1laaFOaRhrg2zSRlmZxGEK/iYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995460; c=relaxed/simple;
	bh=wjTRi+hmGk8J+ypl3csGYs7y1roYuIL5VsU8GRQUOsY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdlUcnfKbKdzIhCqMO8P7iacdTov3bO7XsEkxpSK7gsc9qTYRAP+oraDaVSl09PXCY1n78mvzC4LTe59kIQnHK4ydMWV4GhiR7epcte88gV+aoPffnYDvnSZ6lM6eMKfIC/lBVSPx6QBdAFmiJcDHeGhJX559pNW0O37mq0+rbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZ0gtLwr; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733995458; x=1765531458;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wjTRi+hmGk8J+ypl3csGYs7y1roYuIL5VsU8GRQUOsY=;
  b=JZ0gtLwrvhae/pxjBQ9DiyiBF+QpL1Rw3wlIMJQK2VkB4pHwmts/43Qu
   44OZHin0IA2WylZnFcPfS3/3Masg9EAcgmvF5apimtHrsBraVNGyHYHdy
   KBbhU5HyZ+8UV62C8KGPfZRCuLSPI+S4OAcEE8pBU4ziESi3VQyXynApE
   YQ/ZQrDeyLljcodaBDCyL0Xny/zjYrkVEGqtpIgvMjibOQuJTjWZ/xdEW
   0ejU4LBx2tTDxP1InyJqWNfDpVyNGN/QtOcRW9Mgdk1CSzQBdZ/BUlAlE
   fvankgPYP/wkbaI0s2h7iZvcglOB7+0SAXQwxDc8w4RShcnYEH8WaVd7X
   w==;
X-CSE-ConnectionGUID: kojQVZCGQs+foG/9YKuaig==
X-CSE-MsgGUID: ZfY+H5B/Q/KvlEk8z8X7ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34448910"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34448910"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:24:17 -0800
X-CSE-ConnectionGUID: Kks8KF5yQl6RmTrpVBbhdA==
X-CSE-MsgGUID: QwbvvbozTvKa3DvHLPGvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127168704"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 01:24:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 01:24:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 01:24:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 01:24:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUzy2Qi09xRAS2VqXNlMEaHi0QYgCrjah1r1Wgg+t01LZ5FBYRA98aii0mViXUEp8In6dR0ADJNWa4/5w8qDvZl7btVS2mYiByaRVoECK/eLktqWyrTrgsweN48Td1gdZjXN0fk7cBkEmmpLZUfBKP19T88L0tVTJqGs4/aOWxXF8SATJwlpcyitR6SHZaqQO/fXN2Stqwx6oF+7nF8OIEjijGz5U6bRJU/3MYfFb2qfXwHK2P1FNKXP3CE3L9DSf/OjbHi2UqXQrmtDCc+Cvznahrv4xhpZkOLD8GPO1JgHadHMyNWL6sFAgS7ESbRbUUKyMgDn7wHGF9Nlz6VxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J82z41QpsF2nPAljZ2FKkDEGmB+CMoPM/53rMfen5ns=;
 b=UzjeTE5tl8CRmnriHGEtqV//iaf2NEUgFEG1vWNFJuOJc3YJygyUg+46OeTr+comp3DJZCMt6tyWXQCdJU8cAD42gSnzGMXXYDSY66A9CLOjpOs0CQQkTRPqxZyP6BgY9diz7ZlxfWRp6NU5BtL4KIgDXMq7UJDAE8bOAFcFovyG9t3p05f4gDkfdKOAsoiWUdkSW9xU6knlVS/6HTs1ZY+Lo/wso565hM+L2r2VXOuGoX7cob1mhCO45+lSscvIVxuVOZPE1MBGaYv9JbKRed5oSBb3b/3uC9ElGQDmKhw+3bDdc1mHRINp25BWSVsEfw66Sstzjt3XmSk8f/UD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 09:23:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 09:23:52 +0000
Message-ID: <c97bdf1b-2f18-4168-8d75-052f6bff4c53@intel.com>
Date: Thu, 12 Dec 2024 17:28:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
 cache_tag_flush_range_np()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20241212072419.480967-1-zhenzhong.duan@intel.com>
 <760e2a44-299a-4369-a416-ead01d109514@intel.com>
 <SJ0PR11MB6744E3960431FEB30C36DE7A923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744E3960431FEB30C36DE7A923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW5PR11MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 1139abba-8b5e-4b05-3ecf-08dd1a8eb147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anV4QzdmYk1TSkZmWDhscnVKaGR3eVdGbnBLYTJjVGtDWmFUSjNEbFljWkJ2?=
 =?utf-8?B?K2NXSkN0andOUUZFZXpMZy8wdnRuRThobzh4TnpYUUh2eEM0K3hLRHAxZDd5?=
 =?utf-8?B?ZDZKMTZaeEFzMGl5anM0ay9IUWM5Sjg4ZkU0UmVReWpIOENaMDNFTHVHS01t?=
 =?utf-8?B?RHk3LzAvWFZncCtjM0FudUYwZVhFM2xSdHc5dzkveUJkVWpHMmZXU0YxL3VE?=
 =?utf-8?B?YVFucXhva2JYd2tGbVdlRitmTG1XZnh0QkEzVVFHa0NsY1RQd0t5aGFJbGRJ?=
 =?utf-8?B?MW5NWnlobXEwZWdOZzZjN3NkeHdaV3Zna0N5Q25xUWNlVUtCSTh0SDZ2UGhB?=
 =?utf-8?B?Z01BL1phUEFwWjc2V0xqdURMR3g3N3NmbnNRYm1wZE54elhqNmpaWmZXRGNJ?=
 =?utf-8?B?RXE1cVB0c24wM2xvQVFYQjBsUVUrVUxYOXQ5ckhYUkh2b01sWjI5c1JETHpM?=
 =?utf-8?B?SHJ3VndDbzFtcW9nY3FRZ3FVODdVQ1NiN01mZmdvMWpPaE5zY0Q3a0xINkNl?=
 =?utf-8?B?MmFBYXIwNVhia295U09hTVVWTXNyRXlHWkplc1pWdkl4anlac0s0b2ticEVU?=
 =?utf-8?B?Nzl5NXFzTjZBNENwcUdFZkNad2tIdmloKzBVb3Q2QmdtTndXZ3AwV0U5ZmdS?=
 =?utf-8?B?U1h5eEVORzdUc0hvdElxZktYZzA4VWZnVDlDZTRlQzJnTWRtSXNBQXNLZXNW?=
 =?utf-8?B?aGRoS09EcnhycFBZZXZMbmpRUjIwQVcwS1YwZ3cxWXBUY2JOTGxwcFhIZjhN?=
 =?utf-8?B?VzI3Q25ib3dsa0VHVVlNN2x1ZlFvK1NoMHRLK2xrTlR5ZW5qNndJSWxKeUF4?=
 =?utf-8?B?d2lyeEFYUno0ZGdiMTJRRnBHdldzTmdUbmVsSUl1RllHOEQ1WGdoUkt0MUhn?=
 =?utf-8?B?TXVJeC9ybC9IQXJKeUlGM2lLUUpLY0t1bHp4dlBPUmFsV0ZwRzlUNmxNRlgx?=
 =?utf-8?B?MUFrM1hEUU9tSmVHTkFqR05EZzJWRTY2SU1TYXFoYnFUb1FLSkhkQlNEMFZn?=
 =?utf-8?B?dUpodndYTGVoWlljZFREOEJjd2l2UUtmMXNab1laNURKT05PK2o3bklybzMv?=
 =?utf-8?B?NzZkcHZKaEpobFJWZEN1UUY5aWNyVytaVTNKRFVScHBLZTJrbGtMaVlrUWlm?=
 =?utf-8?B?cWZaRlQ2b2xxS3Y1dUY5b3hiUklnR0h6NmFVQytQZEM0dTUySlM2NzNEcnN0?=
 =?utf-8?B?cExUODVDd1hHV09ncnhINE1HUUhleUVORG5EYjVtRWloS3FIRkR1L0ZzS2h1?=
 =?utf-8?B?LzJnUDh3MDdoN0w4dWFsc2lPczRWeXQ2U0paQnJrbFNhZ2Z4SE84N0JMU0th?=
 =?utf-8?B?R3I4U0hmcTV5bmRDdU5pRUhNUTYyZDlacVluUVJSNUhURG1CdmQreU1Md0lG?=
 =?utf-8?B?ejl2REFDZGVXOEdFR2dtZVVWWHU1RFZGcmRoRThRWldSK29iMXNNQ0hjdHRa?=
 =?utf-8?B?Tnpad25WK0YrY3V4YkhXQ0laWjBmTGd1enpONEJBTk45QkErQmdjNkM2NUtF?=
 =?utf-8?B?NS9YTm8vNGVMaXA3dzlEbllMai9SV1IxaUtZMjlMeW1oNUkxMFk1UVdpWkUr?=
 =?utf-8?B?QUNHNElmVUFPWkdCaTBQRDlsWWZtb0NTZXhFTDB1WjNrNjlrdjlRUDVUOEl1?=
 =?utf-8?B?ajVKaDlqNXZWTVFLYkp6NHNXeFJjZXdVZktMLy9HVWwyak9tdzhCRzF4YWkw?=
 =?utf-8?B?YVRMMUxBOEl2dkp3Q2o1YUY3ZWVBOHlKM0lxUWtYY3phVUpMdzFsNUxHTzhy?=
 =?utf-8?B?UDdLZCs3N3VMRDJzRG5FOEhWUzRIRzRGNVh6bjZwUGVQU25mSkh2SWx6cXZ0?=
 =?utf-8?Q?sjcERyemmLQEYm4soY7mITibRwNUGrk6uzWLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JQcTcrMC9NNEZ1ZWgyZjRlYmlvRXhhdkw0VG0rQnRUSFA5TDVzRmxLL00w?=
 =?utf-8?B?ZVJWQVJia1ZvckdEaFAxT2lCSEttaXI5UE5kR1lKRmNHcHVFVDlaa3g5aktW?=
 =?utf-8?B?TTVvY211Y2prSlhzTGhzbUZYRExJZVQyRFBreDN3dzFDMHZXYUJKWFBSelZq?=
 =?utf-8?B?UXJ6SUxJbytYUEJlZXRWTVVITEp3Qjl3YzIyMWpycjErTzRMUi80Zk9nTStv?=
 =?utf-8?B?aS9ybTkzVFZ3SWJ2Z3dFaEdjU2h5VnM2RTRveE9pMjhQYnRHVWxTeXFTQlBV?=
 =?utf-8?B?Q2d5bEplY3JVNUU3clROR3hGM3A1UlhOeENqYVRBTGpIc1FMQk5QcDNwMzhx?=
 =?utf-8?B?L094VEtuT2ZvQWlpVGZtNW5SUlFUYTFYZDU3Yi9GSEQ5ZmV2aHR4RVBKNGxz?=
 =?utf-8?B?NEJWMWlRblVLdmhPbjFvaG9QbEhHZzlxcXVlMDlOYmpWeXMzbUpRZDBuVkN2?=
 =?utf-8?B?RVhqNEkyZnpQVGpIOXNTaXRLVEN2UklrdTM2ckRJLzZUZmVoU0R2NVFsTHRw?=
 =?utf-8?B?ZFRLU1dNZC9oUWE1czlJa0ozSGc2ajFpOERZMllaOFVTTlhVZlBuU3A0U3Ry?=
 =?utf-8?B?STJRcU1WSUt6b2svaDJFa3JaTjNnZmNSSGNNa1NuREZoZk0reE9xSk8rUG0v?=
 =?utf-8?B?Z1BiTFdaYWI0MklnVWVPZFV6QVJwRXlzL2djUWxrWHVOQ1k1ZWpqb0pIVVhE?=
 =?utf-8?B?MnhINDlQYndxUXV3cEJ0b3RORzdEYzRoRkNhb0lpS2J3S0xzTXFUaUlsTEZZ?=
 =?utf-8?B?RytXSi9WcUs5dmJKMW9maWZRcFhadmpCblNnSUNhdmtrbXFjVWpOeVNTazhj?=
 =?utf-8?B?a2RaalhlTUY3Wi93aVBlekZ3Y1EzQW5PRzZTQ2gvZ1ZLNUZqc0haNVdnaXBX?=
 =?utf-8?B?K05zVTBIbnFTbGN3OEpHMnNQZHpKMW9HN0F1ZVYycElQN1A2Z252V05UUjFl?=
 =?utf-8?B?ZFlCbHp5RmQ4ZUZnTGRlZk1QSWNhdWZQbTU2amxBVlpEb1I1Y3VRd25iNThp?=
 =?utf-8?B?ak5YdFkzV2tOczBMNnFQRWpsa0dBSXozQ2JPbERWT3BTakV0MHhpeGJZdnNw?=
 =?utf-8?B?NUdDYjA3M0N1aGpwWVMyVURtTlk4YzBjZjlnaFhhNDdOWVJLd3c1ay9Fd0hm?=
 =?utf-8?B?bkN6NERLZ2xnU21CWjNJWGRCQ0NzRHBZT0E0U3NzUGdrdWxndXFsSlJYQkpT?=
 =?utf-8?B?UUdlWHBFdC9oWnBsQjczYkhpeVI3ZWFoeW5vSkJ4dFg1b0NkUFFWTmFheHJB?=
 =?utf-8?B?RWUzRHVraTB1Z2NleFQ0NHgxOEM4N0syNWhPR0M3RERNb2hveGFLUXRJK3VL?=
 =?utf-8?B?TjMwbHdnOUxRU2hiK21BSjU3Q1l0YW5ONFZZdDVhTjdtSFFCbU9yazREZ2l3?=
 =?utf-8?B?Q2lRUWZXdlRZRiszZGJkUWduUXJNTFh0a2dvVE1PM3diZ05rNzRPbk10L2J5?=
 =?utf-8?B?NDkxeCsxTnp6eVY0TTRYUE5yUFRWcFU3MDFSa3ZJa3h2YklNbnNveGQ3Y1A2?=
 =?utf-8?B?QzhwWEp3QUttR0lNemRBUmw1VlJhcG1DcXFHeFlaZngwYllsSnp4aDhCcys5?=
 =?utf-8?B?Z01LdFBYWGlEeVJTREtTVWtZK1Y2V3JuN3MrbFZ2UU1XN1U3M3dBaWhXcGpI?=
 =?utf-8?B?aVM3MDJWL0RBS2xXS3MrL2pkU3k4L1FGLysyYXVpNHpmYXRxekl6MFpHYVpW?=
 =?utf-8?B?c0NPMzdabHhNWng2N3BMMW5mMUh0NEZ3VWVIRVRMNXRTZGZPYjZrUWZVTjdz?=
 =?utf-8?B?bi8yWlJYbWpHdVJpWXdtcXdRZWxmU1hPSFk4TEJrZDJXZDB0VHNiZktEMTYw?=
 =?utf-8?B?RzRrNC9oZGxtUSswd3RJVHBkOXRyWEZsTndoeG9tSGw0ZVd0RXB6YjhjR0E2?=
 =?utf-8?B?V3pudXFhcDZKUG44cEp1cW95QTRxU3lTYzZ2Q1Z5Z21IWC90UUhOUFBsYi9F?=
 =?utf-8?B?UWVCc2dQYnhyS2FWbm1pVnA5cGNGM21GajNqVE53T0c3cFYxeTdGRHhibm5x?=
 =?utf-8?B?b1VrcWVtbGQ2ZUpLdjVNNVYzNWNJUFJTSnBkS2diU1pjcXRaQ21IcFR2MUlR?=
 =?utf-8?B?TEJRR0N1a3F1aUZ4U0lmaThHY0lUNTBiSFdmbDRVdTAxME1CZkhuUUJkU1ZJ?=
 =?utf-8?Q?209mDESgW/2++eQQ+ZSDNgPrk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139abba-8b5e-4b05-3ecf-08dd1a8eb147
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:23:52.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcceTlL+ykLFuIvm5EGe+Rv8uZGFTuir96i8xr4X/sD01gO7b50anLrNR/8se/ArZEvR3TGLQvNAJDZU+vRfMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907
X-OriginatorOrg: intel.com

On 2024/12/12 16:19, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 12, 2024 3:45 PM
>> Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
>> cache_tag_flush_range_np()
>>
>> On 2024/12/12 15:24, Zhenzhong Duan wrote:
>>> When setup mapping on an paging domain before the domain is attached to
>> any
>>> device, a NULL pointer dereference triggers as below:
>>>
>>>    BUG: kernel NULL pointer dereference, address: 0000000000000200
>>>    #PF: supervisor read access in kernel mode
>>>    #PF: error_code(0x0000) - not-present page
>>>    RIP: 0010:cache_tag_flush_range_np+0x114/0x1f0
>>>    ...
>>>    Call Trace:
>>>     <TASK>
>>>     ? __die+0x20/0x70
>>>     ? page_fault_oops+0x80/0x150
>>>     ? do_user_addr_fault+0x5f/0x670
>>>     ? pfn_to_dma_pte+0xca/0x280
>>>     ? exc_page_fault+0x78/0x170
>>>     ? asm_exc_page_fault+0x22/0x30
>>>     ? cache_tag_flush_range_np+0x114/0x1f0
>>>     intel_iommu_iotlb_sync_map+0x16/0x20
>>>     iommu_map+0x59/0xd0
>>>     batch_to_domain+0x154/0x1e0
>>>     iopt_area_fill_domains+0x106/0x300
>>>     iopt_map_pages+0x1bc/0x290
>>>     iopt_map_user_pages+0xe8/0x1e0
>>>     ? xas_load+0x9/0xb0
>>>     iommufd_ioas_map+0xc9/0x1c0
>>>     iommufd_fops_ioctl+0xff/0x1b0
>>>     __x64_sys_ioctl+0x87/0xc0
>>>     do_syscall_64+0x50/0x110
>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> qi_batch structure is allocated when domain is attached to a device for the
>>> first time, when a mapping is setup before that, qi_batch is referenced to
>>> do batched flush and trigger above issue.
>>>
>>> Fix it by checking qi_batch pointer and bypass batched flushing if no
>>> device is attached.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    drivers/iommu/intel/cache.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
>>> index e5b89f728ad3..bb9dae9a7fba 100644
>>> --- a/drivers/iommu/intel/cache.c
>>> +++ b/drivers/iommu/intel/cache.c
>>> @@ -264,7 +264,7 @@ static unsigned long
>> calculate_psi_aligned_address(unsigned long start,
>>>
>>>    static void qi_batch_flush_descs(struct intel_iommu *iommu, struct qi_batch
>> *batch)
>>>    {
>>> -	if (!iommu || !batch->index)
>>> +	if (!iommu || !batch || !batch->index)
>>
>> this is the same issue in the below link. :) And we should fix it by
>> allocating the qi_batch for parent domains. The nested parent domains is
>> not going to be attached to device at all. It acts more as a background
>> domain, so this fix will miss the future cache flushes. It would have
>> bigger problems. :)
>>
>> https://lore.kernel.org/linux-iommu/20241210130322.17175-1-
>> yi.l.liu@intel.com/
> 
> Ah, just see this😊
> This patch tries to fix an issue that mapping setup on a paging domain before
> it's attached to a device, your patch fixed an issue that nested parent
> domain's qi_batch is not allocated even if nested domain is attached to
> a device. I think they are different issues?

Oops. I see. I think your case is allocating a hwpt based on an IOAS that
already has mappings. When the hwpt is added to it, all the mappings of
this IOAS would be pushing to the hwpt. But the hwpt has not been attached
yet, so hit this issue. I remember there is a immediate_attach bool to let
iommufd_hwpt_paging_alloc() do an attach before calling
iopt_table_add_domain() which pushes the IOAS mappings to domain.

One possible fix is to set the immediate_attach to be true. But I doubt if
it will be agreed since it was introduced due to some gap on ARM side. If
that gap has been resolved, this behavior would go away as well.

So back to this issue, with this change, the flush would be skipped. It
looks ok to me to skip cache flush for map path. And we should not expect
any unmap on this domain since there is no device attached (parent domain
is an exception), hence nothing to be flushed even there is unmap in the
domain's IOAS. So it appears to be a acceptable fix. @Baolu, your opinion?

-- 
Regards,
Yi Liu

