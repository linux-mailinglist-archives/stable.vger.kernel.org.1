Return-Path: <stable+bounces-100884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108219EE487
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A24D283A21
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4313211471;
	Thu, 12 Dec 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSNSzzwY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB111F2381;
	Thu, 12 Dec 2024 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000932; cv=fail; b=Gfs2bSZN2O+HOCAdxfwy4/3L3UWx26WBwjE8PAKkp81HqWmyTnB/IGBvIGchz5j3GAsIpQgzWPGJ7px/OHUIrjdyuseSxxIZExNlGX35XJwCHs/yDwXj8PHreA7wTeEOCayJDuBSv5l0xy+ft9987LfvmW53kLRL+I02FGwXbIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000932; c=relaxed/simple;
	bh=5ZNRBnPzcA2cfQ6y+GB3KbZAYcf0DI0SFuDthNeVwV4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTYXsCbZgPLTICJ6AQMSLR/jhfH5PoFaR0Mrtll5fJQVA6zzJ908Zfk19nCyM1otYh9piUULO+rILXLDIFUORNmARFpIeA+Xspbm/2t6nEfDm1jXSvaKIeqQLUwOhd61OOcqreMNoApWvV6PBW01nfgMgTM6VGOEvfatwekguvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSNSzzwY; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734000931; x=1765536931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ZNRBnPzcA2cfQ6y+GB3KbZAYcf0DI0SFuDthNeVwV4=;
  b=hSNSzzwY2Kz08Q2IEUqD8WqKzvsRfRsxkxLoRnHMNNCJz+9r/8JA+yzc
   IZl1lzPclYXAmsAGTehnMBaKp6Ye/iYgp3lO1xJyNq7hCj36B79HiiNPH
   a4I1YUcgE/+gafYFInKXbr9LGWdOpZs61cPB/F7Dz2E/u4X+DktkyIYDo
   Jnr3G6UamQrrZ2yzW9UrRAQjRwT99TW+1P2RIl/NvyAgtVV/xdt3bx8GO
   lICspIDiazfELhktq6XHPx+Be5jMUBYQ42l5SSvgOG+5QsXOEL3xqtSX2
   P/hAfZMfbq8CkYYy1jov4JGjqbTNgD8pkthQkvPXeFwEex9BzDoWRD1UO
   w==;
X-CSE-ConnectionGUID: ryEAq/BCRSyZo3CAaAqASg==
X-CSE-MsgGUID: MzVW6pxGSHSEBt/GcP79eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34540703"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34540703"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 02:55:30 -0800
X-CSE-ConnectionGUID: 0EKvPZ1+Sf6XCtHTMmJSDw==
X-CSE-MsgGUID: O69p0RSLThi1UbvUwgFWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96736512"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 02:55:30 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 02:55:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 02:55:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 02:55:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4LS4rN8qiyZrYqd4yHyBj2qShGbQh6+aiuVTM3XLhtC58PjwOh499Mgk9yjEH1+oNtzBr2O9Zq/PkMW64oGxSo7JBwt1HGLBucqzKr0hTFxytNXGRsriiHmP3N/h7vrfHPCFsirq39Fduvs1KDckiSUbnF66YheqDYVbhkUOoiaHzXgyknZbSh10PnHuawOEvgR4i9Fxhz9SA+TrV2PUb+YsZh8WwSSv51j3FhbbrjUZ7zxwnkE9EP8OEU6JJL8dwg8FxxuB8Dik8dusf96aiSEnYgDjfHR4AQpGrfIv7egDLv1BKG0ECpDiwaMwaBYSV/RNXjBjs+RXesw5NC9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFI8uFVd6rFPDTRDtQRxZhOh98FtsM1RZA76F7HXD8c=;
 b=pvQOROBmLdfWCShIQehpVKpoUU4DQft6SvLcf2TZxpqX6/M/WkHYNtInFSV4+0uBhxkCiPlzjseLs+LsNvqfTGUHTfwT10Zq8J8/9QMTCW1PzpKdi20zmdWzF+7nYsEmkgZ/F9wODuqdB2xYy8s5YPLZok3/FpaYhFGJFES/3PG9/RsjM+OKw5Ayqt0DAsjfsZX47hujVLxbMlVQzBmlx6TFDJgP379Jr/GSlPJBdqGKpO0Ri6lzoFE+032Y9Q6cAuPzxwV6bs+b8+9N/iO2TeMXVTjwjPdCZxo0AGcyIFhPG7HsnXilyp0nUwfbFDCSyJL8LZo2Dwi+zYrnnx1oGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 10:55:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 10:55:24 +0000
Message-ID: <9a52713b-3a33-4e64-ad8d-8394e9504d75@intel.com>
Date: Thu, 12 Dec 2024 19:00:23 +0800
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
 <c97bdf1b-2f18-4168-8d75-052f6bff4c53@intel.com>
 <SJ0PR11MB6744EF3EB81780C1EA07FB1F923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744EF3EB81780C1EA07FB1F923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac64e2d-95ed-43e2-bbea-08dd1a9b7b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2Q5N3VXc0tjK1U4R0ZiNkNBYXJjZ0FYQ2FRU0tYR0pHSGpLYTZ0RHZsdEJk?=
 =?utf-8?B?SHJWMGZ0TXVzR3FmaC9EYlEyVzBFeUR5d3NUZzlibnZoeGYwMTVaTVBTRjZO?=
 =?utf-8?B?M1hSWGZYL3ZCSHUrNWhBY1hOU2RJd0h3YnF2WUJPU3ROR3BGMzlITTZwTnpQ?=
 =?utf-8?B?MERVM1liTVdlbmdmeXkwekZpb2orYlYzRG1SWmR4OFVaSnJYY3RrRmVwWHVB?=
 =?utf-8?B?cjhKcVRQWXJ4QkNsZVkrVm9jaE5YbVJ5cUVnVmJaOWlKRjRCVTBHQk4rbVdr?=
 =?utf-8?B?ZWpITk8wU1hDcm9KeWxOR2VEaEQzYm5tcitaTTRDZE9oZTZ6ai9PdmZZK0Rw?=
 =?utf-8?B?SFIwREoxMWgyYnBaKzFMeEx5WnVLS3Z0Ui9MRk51Lzk2b0dUcFFObTA0SE1H?=
 =?utf-8?B?UTNOanZPbTVJNzZwTnVoaFpOZEJwbml3Z1M1c0htUFVCbHdQSTRlVE1MMEdC?=
 =?utf-8?B?QVVTeVBYUk8rMG5nMkM3aEp0SlFKa0p4T3RBWU10RDBoeU92UnZYNURQTVg4?=
 =?utf-8?B?SWVMOW5Xb21JaXB1eDZzUU03UVpMWHUvMmszTm14emxkYmZnUmp0cC9aWEJP?=
 =?utf-8?B?YVowWDNUV1drMENGaEVMYnA1emdLbEwzVnA5bmFtY1pvS2dHMi93VUJiM2hP?=
 =?utf-8?B?K05nWW1SNUNVT1lGRXdqY0pBdmpIV0FNYnlVWHhoRWQ5NGpsckZDODc4NUFa?=
 =?utf-8?B?Tk5yaWgwSFN4OC9WYVJOZlhJZE1LS2VHYTlKNTB4SEJpTTlla0pCbXo0MWNO?=
 =?utf-8?B?NG5TSHR4U2QyR2VzZWF0RWIwRnE1TVNBS3I5MHJEZkdTSHpYblFrQjd2a0RO?=
 =?utf-8?B?QTV2ZjVpUnFlVXdHbUN6RmtRdUdCS2x1R0dROFNwc2grTXR6c00vWnlmWFc4?=
 =?utf-8?B?S2ZCbTl3THFhWDM1dWVSVVdwbW95bDdmdjBVcnFaNzBiY290em1Icjl3TWVo?=
 =?utf-8?B?WG9Cbmcrd25KYTUyTzdXSWRLQ3pjUHd2eHVvYjBzdE9uRzkwTVV3dVg1aSsy?=
 =?utf-8?B?Q0RmREtEL1NBbzdaZkZqSnZQQ3k0eFZDR3pZbDBxMTRQazh6YVE4bCtuNTlr?=
 =?utf-8?B?WGhtSTZrd1E0TFI5ZC9QaDVxeUhxUWszRGl5Uzg5T1hEYmRFTTg4ZitxakQ0?=
 =?utf-8?B?dzhOMWlNR2J4MmJZT0RkUnVXSlhDSHlvQ0dHdjN6WmRlYWNTSGhhblFjaGZ0?=
 =?utf-8?B?dlFwcHVGWVZTSE1DWWh4d1Bmd01kckJuUFE2YmpCL1l4T3dzZys0MnhHcUlW?=
 =?utf-8?B?RldCUFhoQ0ZxSkZjOXFOczJPMlltUGp3Q2ozZnYrQ0dIcWZxTUFoSFk0aFRH?=
 =?utf-8?B?eE40WFlBbUpob1Jib3FHQ29nWS95cGtjcXFRV3ZzNWlvS1JmbGpGVFFMU3dZ?=
 =?utf-8?B?NzhWRmU1ZHBLU29WUW5nYXlJTkVmSllFdW4zMWxjTVNLVEZZRnNVTk5OOUlY?=
 =?utf-8?B?TnFzOStEb0QwbC9QaStpUW9uSlJZSS8xTGdEcngyK1VhNE1xS0l6REVGY2ZF?=
 =?utf-8?B?Q2FOaG8rS2xJZVNWcWtZeXNWYTlZVzRlZ1JBL2RXTVhmY2NoYUYxZGtOWUI5?=
 =?utf-8?B?UVJQd0NVblk4RkNNczkyejZwZ3NlVml1VHpFQW1LN3pCNVdyNDM1U3BHYjBo?=
 =?utf-8?B?dTFZMW5qeDNCV1hJc3RCYlVBZkNqb3dnTkwybmxtc3pGbHNxZU1jcHRKb2FT?=
 =?utf-8?B?bUVrQ0llZmZQQmNMSFA5YzJDK2ZEdTY5N1lOLzdCa1lPNGdRRm90Q0x6MG1w?=
 =?utf-8?B?TjVPUDY4NUNRS2laSFJLOFU3aUhzcm9TajhDYkRPVHMwUThWVmZ3d1NXSTJP?=
 =?utf-8?Q?uPqSQO+bkBpp5ZDmyW+hQG+emOm7xtG/15L5k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWowQU1MMHBpczBBTTVReExiWENyYzU0ZDlsQ1dDN2VCcllVS3hnL0syRlRS?=
 =?utf-8?B?RWxLN3RXQllUMm1udkJ6bSt4Y0V4U00vWnJJcVJGeGpQNkQxY1h4N00ydmNU?=
 =?utf-8?B?K1lnbGhKYXd3NXRFVmw2WUFqV3psNWFpcXF4d09abkoxZkZWNGJYeFJhZlJN?=
 =?utf-8?B?dGJSZTY1Z0hBb1E1TVlNRWRSTDZuV0JHbit3ZDJRL3ppMm0rMEJHWi9HZTZr?=
 =?utf-8?B?UUJ0MVg0ZWNxQ2psVDAzclo4cXoxVDR1bjlDRjU1Njl4YUlhcDdLb1ZmZk4y?=
 =?utf-8?B?RHhvWmUwYnBreCtFSHVRWkZXV3FFVEVBSUI2Mzl1bVh0SGlIMndPK3RwdmpZ?=
 =?utf-8?B?dmJHa0dLb3QzTW1TUWdvcWFVY0grSnUzcmNWYTdkNG55dGlXaUpGRjh3SWNB?=
 =?utf-8?B?cUpXTW9USkhWa3JiZDNNZlNOTXRsOUR6L1dtQmxScHNlbE9aNXhoRWM5TjNp?=
 =?utf-8?B?VWJLNmpJaXI1UjhNVmdoT1FlS3EwK2UvTGdZeGp4WWtKV1hCSHFuL3RTbzJN?=
 =?utf-8?B?eGpwdzlOaEVhUkhUbnRpZE9qSjdHSElaa2hIS2lSd1djTFhMRlpWUXZkKzU4?=
 =?utf-8?B?d2czeWtGejlMS05HSDMwUWtGc3ZhaUthNlQ3YS95aDdUdk93OFhJaTJ3YjN6?=
 =?utf-8?B?ejlQQVYzY1VFaFlZWlRnak1iOVdyQ1BoT3c0TGNPSVpmMFZiKzhPdSsybE4y?=
 =?utf-8?B?aUlXQjc3MS9BSWlpQmEyRHg1cExwZzNsN3kvSkVyK3h3MVR3dndNNGxxbWcv?=
 =?utf-8?B?WHk4M05GSlhvb2EzWGcxZzFuVm56eE52TzFURVcrZ0huRGkyajh0YWlTZFZH?=
 =?utf-8?B?TzZHNnIzMlM4OGNyOWVEVnZBQ1BRUFJFbHlkNU84dkIxNkFuMTg4M3JxR2ty?=
 =?utf-8?B?ZzNGVVlCU2ZHMUVFS0FULzVxUEdtYlhZY0w5eXRVYkl0blo3d0hXNlU0RENh?=
 =?utf-8?B?YUVSTlJ4dndESU5MeTJlSWE0akNsWEdNMGlTd0grOHNyd3VEV1pJaUFGNVBw?=
 =?utf-8?B?eTE5cVRqSksxK1lYUEVvanlxZjE5bnAraHNseGNWQ0JVOVd0Sk13dTdvditk?=
 =?utf-8?B?cXJOSmpMa3RjV0J2alJTUldzZHBDVVI0a2tIaEJ0MEpacmNvVkJBNkgxdC9t?=
 =?utf-8?B?Qko2Z3dtcUhTYmNpbW1UdTVudXNtYU1vS1MyemNQblNQck42YUVaRU44VTZr?=
 =?utf-8?B?blRJV3VTeXRZaFYzeVd1eDBMZWQ2OHl3V1hRalh4OGF2MXRLSHgzMGJoajhH?=
 =?utf-8?B?MHk0RXRUYkI5NEVGQjYxZ0xQYmYwSGpmRlIyb0MxdnBkNk92cHNmdUZhWDkr?=
 =?utf-8?B?QWkwOGtNcFZVUTJxOHFpMEtRYVJnNGZhVXJMY3k1UFgzUTQ3WTN6Z0Q1OE5M?=
 =?utf-8?B?VXVvSnc1ckYwVDJ0c0didTJEZnBONUlDTjJVblRGTGJ5NGJ0YTRDNVVZbXN6?=
 =?utf-8?B?Z0w4QnJtMEliTGFQdXdJR1J4bzI0VXd0SGQ2RXFDQVVxUElSY2xVKy9vOWp1?=
 =?utf-8?B?Q0FvYjRaSjlBWktkY2hwSlhyYTVqZHl1M21jSmlrMEJ6WkIzbW8zQjlNblo2?=
 =?utf-8?B?R21kOVBOSWlleitrYXYwZnRUdW5nZWpLQmRQenlTcXJVQ3dvVzFDbFErWW5I?=
 =?utf-8?B?ZXZjT2tRLy90NVBoN2tmVVRmRkNLMUxTL0hiREdvWjlqZnM3UzY0WEQxU3ZS?=
 =?utf-8?B?M0JNd3ZlU2pCbEphcDhBTkY0ZjNya3dSd0pId1BzKzg4bi9XY0xPZUFMLzla?=
 =?utf-8?B?c2Z2SUJjTjJ1bFZqMmY5ZmVUaHZpL3NwVVlieDFvVktaZlgvTEE1TUwrMVQx?=
 =?utf-8?B?bERKMzF4SG9kTThMNVVTdXl4a0xrSEJDZWpEMXhicTZjZHYwZXE0MzAvSHpI?=
 =?utf-8?B?SVFEbDFsZWJLbFRpaHFGU3dDQWtuVkVDU25pUVVpNVgxSFNVZXpPRDRncU41?=
 =?utf-8?B?YTRYQnljaUd0NUxEcklTQnlmMWp0c3lBcE5UcG9MbStCdVRMS3ZaVmNzN1N6?=
 =?utf-8?B?REV0NkZpNThXTStiTCtjZ0IxTGlCYVJlUTNvMGo5TC9IUnV2bHRzcXA3VERF?=
 =?utf-8?B?UlRWQXhuamRwK0l3d3ZUYXllUUxhWlF0ekthMjcreXZMNS94bjRUbEZlOG41?=
 =?utf-8?Q?ZtB+iu50cypfyg/BhVSInJL4e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac64e2d-95ed-43e2-bbea-08dd1a9b7b1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 10:55:24.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y+OLFQYH4H9ypEM+LBHPRaTNOIP6LD6ER4nqbTOX4Fi3ejXk34PC0y1SqqjJ4MgkVQgGe0zo+55F9tR12uIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com



On 2024/12/12 18:01, Duan, Zhenzhong wrote:
> Hi Yi,
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 12, 2024 5:29 PM
>> Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
>> cache_tag_flush_range_np()
>>
>> On 2024/12/12 16:19, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Thursday, December 12, 2024 3:45 PM
>>>> Subject: Re: [PATCH] iommu/vt-d: Fix kernel NULL pointer dereference in
>>>> cache_tag_flush_range_np()
>>>>
>>>> On 2024/12/12 15:24, Zhenzhong Duan wrote:
>>>>> When setup mapping on an paging domain before the domain is attached to
>>>> any
>>>>> device, a NULL pointer dereference triggers as below:
>>>>>
>>>>>     BUG: kernel NULL pointer dereference, address: 0000000000000200
>>>>>     #PF: supervisor read access in kernel mode
>>>>>     #PF: error_code(0x0000) - not-present page
>>>>>     RIP: 0010:cache_tag_flush_range_np+0x114/0x1f0
>>>>>     ...
>>>>>     Call Trace:
>>>>>      <TASK>
>>>>>      ? __die+0x20/0x70
>>>>>      ? page_fault_oops+0x80/0x150
>>>>>      ? do_user_addr_fault+0x5f/0x670
>>>>>      ? pfn_to_dma_pte+0xca/0x280
>>>>>      ? exc_page_fault+0x78/0x170
>>>>>      ? asm_exc_page_fault+0x22/0x30
>>>>>      ? cache_tag_flush_range_np+0x114/0x1f0
>>>>>      intel_iommu_iotlb_sync_map+0x16/0x20
>>>>>      iommu_map+0x59/0xd0
>>>>>      batch_to_domain+0x154/0x1e0
>>>>>      iopt_area_fill_domains+0x106/0x300
>>>>>      iopt_map_pages+0x1bc/0x290
>>>>>      iopt_map_user_pages+0xe8/0x1e0
>>>>>      ? xas_load+0x9/0xb0
>>>>>      iommufd_ioas_map+0xc9/0x1c0
>>>>>      iommufd_fops_ioctl+0xff/0x1b0
>>>>>      __x64_sys_ioctl+0x87/0xc0
>>>>>      do_syscall_64+0x50/0x110
>>>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>
>>>>> qi_batch structure is allocated when domain is attached to a device for the
>>>>> first time, when a mapping is setup before that, qi_batch is referenced to
>>>>> do batched flush and trigger above issue.
>>>>>
>>>>> Fix it by checking qi_batch pointer and bypass batched flushing if no
>>>>> device is attached.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>     drivers/iommu/intel/cache.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
>>>>> index e5b89f728ad3..bb9dae9a7fba 100644
>>>>> --- a/drivers/iommu/intel/cache.c
>>>>> +++ b/drivers/iommu/intel/cache.c
>>>>> @@ -264,7 +264,7 @@ static unsigned long
>>>> calculate_psi_aligned_address(unsigned long start,
>>>>>
>>>>>     static void qi_batch_flush_descs(struct intel_iommu *iommu, struct
>> qi_batch
>>>> *batch)
>>>>>     {
>>>>> -	if (!iommu || !batch->index)
>>>>> +	if (!iommu || !batch || !batch->index)
>>>>
>>>> this is the same issue in the below link. :) And we should fix it by
>>>> allocating the qi_batch for parent domains. The nested parent domains is
>>>> not going to be attached to device at all. It acts more as a background
>>>> domain, so this fix will miss the future cache flushes. It would have
>>>> bigger problems. :)
>>>>
>>>> https://lore.kernel.org/linux-iommu/20241210130322.17175-1-
>>>> yi.l.liu@intel.com/
>>>
>>> Ah, just see this😊
>>> This patch tries to fix an issue that mapping setup on a paging domain before
>>> it's attached to a device, your patch fixed an issue that nested parent
>>> domain's qi_batch is not allocated even if nested domain is attached to
>>> a device. I think they are different issues?
>>
>> Oops. I see. I think your case is allocating a hwpt based on an IOAS that
>> already has mappings. When the hwpt is added to it, all the mappings of
>> this IOAS would be pushing to the hwpt. But the hwpt has not been attached
>> yet, so hit this issue. I remember there is a immediate_attach bool to let
>> iommufd_hwpt_paging_alloc() do an attach before calling
>> iopt_table_add_domain() which pushes the IOAS mappings to domain.
>>
>> One possible fix is to set the immediate_attach to be true. But I doubt if
>> it will be agreed since it was introduced due to some gap on ARM side. If
>> that gap has been resolved, this behavior would go away as well.
>>
>> So back to this issue, with this change, the flush would be skipped. It
>> looks ok to me to skip cache flush for map path. And we should not expect
>> any unmap on this domain since there is no device attached (parent domain
>> is an exception), hence nothing to be flushed even there is unmap in the
>> domain's IOAS. So it appears to be a acceptable fix. @Baolu, your opinion?
> 
> Hold on, it looks I'm wrong on analyzing related code qi_batch_flush_descs().
> The iommu should always be NULL in my suspected case, so
> qi_batch_flush_descs() will return early without issue.
> 
> I reproduced the backtrace when playing with iommufd qemu nesting, I think your
> previous comment is correct, I misunderstood the root cause of it, it's indeed
> due to nesting parent domain not paging domain. Please ignore this patch.

Great. I also had a try to allocate hwpt with an IOAS that has already got
a bunch of mappings, it can work as the iommu is null.

@Baolu, you may ignore this patch as it's already fixed.

-- 
Regards,
Yi Liu

