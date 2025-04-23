Return-Path: <stable+bounces-136482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23053A999D5
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCC45A2249
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102D19F40B;
	Wed, 23 Apr 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mh4/5iHz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC21465AE
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442096; cv=fail; b=jqFjPbMQb8q5l9P7QKiLsBHrl+R/vvnQSsA4ywRXctRW2IM9l3rvcVCDugXKbCd1tPVMF9v2cpeDMhw24TcQggkT7D5JCzIBNBvoeLC3Pp1/MTP4kzR+7/ZDPjo7hxTJuYDDDdzCdouE8s5uLt8HqCY9TZWNKjr/KRY9g4V8Q/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442096; c=relaxed/simple;
	bh=FpEwLL4TKS8UsEDmccS/OAW/oX/qgmPTucki7LzYiaA=;
	h=Subject:From:To:CC:Date:Message-ID:Content-Type:MIME-Version; b=WEQAyKOGCXDhyy63fOZ2IH11pHKZY5/zALBTCkGqdawZQBDOCErw38qFS7gdVAnJLf1BeoPfiqnYqmLh1YhD0nZydEUFBRh3GwrEhOFAaGkjF/qAId0R44vr2/70QwL4zInscHUH1xu2kDqEx8Hy3yZKEZRnxGyfr5nkeI2XdXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mh4/5iHz; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745442094; x=1776978094;
  h=subject:from:to:cc:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FpEwLL4TKS8UsEDmccS/OAW/oX/qgmPTucki7LzYiaA=;
  b=mh4/5iHzGeDwsYB8y0oLG2vS1PTy6nDLysMv5XLQhHuOqzAVQtmp4Fji
   8KZBCCOqKJy/e9nRAab5viEVQALD0Zs8xCFzSCFBoUKUetkL+nexGlJ3a
   kLsOjOSXFuwZF+iXcfjiXqYqvLFJYG6fGtmhaPx91Dw9thkuJru9YYphv
   Msa9g9e6ayT++UR0/tFjKvDXVVj5QbdiGZomwo/cKAfLmBAQMa5ThSmuu
   4EUX0q7zBuuuYBjZl60kdrdRovfzKJKf8ayPdT5Us/TWv/SZFnvOfpMMF
   LMjJvbhHHbwyCjOTbTnvUSmcUIu9tLGhDFI68F4szzlam94kaUInQakgx
   Q==;
X-CSE-ConnectionGUID: dFsx9aMpSxyrRdQ7zHiS2Q==
X-CSE-MsgGUID: SD9KeXvnTy67hL+eTMNHQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47232762"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47232762"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 14:01:34 -0700
X-CSE-ConnectionGUID: s7mBAxtJSw6t1AtJ3ctuug==
X-CSE-MsgGUID: X2e6lCh2SbemDKNukng6LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132263809"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 14:01:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 14:01:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 14:01:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 14:01:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiBUYxNY9cHuFczHSdMjm7NBz254BzD9olBNH01yFeJbzmhDPbeKHTjE57Aqr3yQ5yHNIJZUHek9acff4D+wvWiCOh8wxOHdENZxeek4c+fy2yHss3x69NO30nBhs73aX6qbJBUd2CE61E5RlF+hcD9DGoP7MdOzC3ijUXYOlStQHTasG6Ie3LJIWxBw3HAoHRXXT+GWLDIralwlehIObKJCegtwvIk7Le2eND2FgnfYZv08cQFbI2Q2M3bGFPqyAgMAqvvGDIVQBxjYDQxwEmGn6RPr/gLLfx0lLEdoWCH9FrRUAkiuDUHaaF2bb7odKOgB5Wkm2YxLjesl9zTlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyspxh+nSB1nKv7PhAvQ6jcAgrmofZxce8UFjkvAlIg=;
 b=nR2Lao0shnswDxb16DW7V5+uN3BE9vBcEKOZkzYd6T/C+GzbZGD37PE4H89iu0fvQHAWrKRv1+We75bJvoIvkTE25tgcGPtzFPGqCqV0mQtu/WM8KY5JSqL4OsXvUTKbREH2+VOCDHsgF5iOqtrOj+NZgo+TGMsxBmnbwnnbKIj4Lf4Z6yB6enAJEvBXwNh39/1VGxEZMtkWGTe7YsuoyeJyL6vn4kI6PJtTZPQAdQpkcqKQt8bc2gRSr+KfW+uKCOOOChCnJOAeLHnJwD1iKC0p9wWBWowhE4OuH0xMqwpeg3mc1N8eJtNy/q6EHnSwrNFtj5epC02RxkZeD+c0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 21:01:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 21:01:13 +0000
Subject: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>
CC: <stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Cedric Xing
	<cedric.xing@intel.com>, <x86@kernel.org>
Date: Wed, 23 Apr 2025 14:01:10 -0700
Message-ID: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:303:dd::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: f187c089-32c1-4bb2-dd8b-08dd82a9fb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVJzV3VYbDE2MkRCL2N1RCtJZUJtUVdadXAzV1YwOVRCU3BLbG1zUUFKYUk5?=
 =?utf-8?B?RTd5Ym9sL2kwQUphV1cwNHRaeUErYXJ2ZXI2aUZodWdsU1gyajBudnhORDNX?=
 =?utf-8?B?cDV3WWFvU1VsNGlBd2NpcG81ZnZka2pKMVNDWm8yQ2pMZFJMY2pIWlArZlIw?=
 =?utf-8?B?bnMwOVlrZmJrZ0RLVE82eDN1R0x5cVMzRGxIeE5UTFl6eDZvenovYkxiNlBl?=
 =?utf-8?B?c0tVdHBQNjh0VC85V096cXpBQTgwVno2dW1iRjIvY2tISWlvRFRZUWJ2NjMy?=
 =?utf-8?B?cUZnN1I1Vzh5UXU1Y1BQdHF3cW9BRHFvUlQwc2lFcm0vOWF5NkdXTVFnb1Ir?=
 =?utf-8?B?V1ovSW9wRzgxLzJuUXFQVGFFZlNRR1N6L3pJOWFzMDl4R2ptWnErVWhIS1lP?=
 =?utf-8?B?Zk5DalordzNxcWVHWVY1cVNscWcyaEk2dUFaUy9HTjhhRHI2ZzIzbnhMMXUy?=
 =?utf-8?B?NWk1MzFVSmNUR3lScXJHWGh1VlU2Nmc4OUxZd3RBRGZWeWRHWHRtQXVWUU9B?=
 =?utf-8?B?RjNpM1EyMHphdU9aVjhnaUF3U3RQOU1Ra0VjanZVZVZKb1liRWxuKzFGVjVZ?=
 =?utf-8?B?eVA1cDFpek02L09laHoxMEcyMkdCVTBGODlnQm1qRVZQaG1mYXJ0TlZ4cWNI?=
 =?utf-8?B?Y3BBQ29TR0lYbW9HczErZ3g2YXFrejlCYUwxNHdvTitoenZKOVZONVRhS2ZS?=
 =?utf-8?B?ZWY4QnpEN21vbXNDWWJRQjNPQXBzc1dHMDAzSmJYMnh2TGRQWWNQK21jUi9D?=
 =?utf-8?B?a2Y5VXB4SzNOQWhmSTNKVzhVdmZ0am1WRjRvRVorN3psWGs5RDcydjZsVVFm?=
 =?utf-8?B?SlozdjlrdlZpZGNrODhIVkFUSXppSEJQMGN4YnU4ZUd6Z0ZpOEFYUTB6eWV6?=
 =?utf-8?B?Q3NqcktuUkcrVUtwa0pEazBzQjRPWXRaRHN3ck1VMzYzLzczdVJ4VXNCRTE0?=
 =?utf-8?B?NUtadWliekhnZzQzZFZvcC81NnEwVzNGNkovYXNKRitBTERzZmRnUUpoM3U5?=
 =?utf-8?B?WkFCZXR6NmVVbWk5Z09aSXBaSEJlMmcwWGtYbzNxRkhnVndUNHZ1N1lwY0x1?=
 =?utf-8?B?cHQvYWFRVnQ2NWM1MW5zelRHVWFRZWtkTGhGTEw0djVNSW5HQ0RyVG4rMlJq?=
 =?utf-8?B?ckZUZ0syZmh6TGRkTXl6L3lOL1FDamVrcCtwUXRSVFoydzhKNzRsZ0tiMTBx?=
 =?utf-8?B?d1BCR1RYcU9kN1E1UlRSYklEVXo2RDBZQ1dDWnp3d3Vocm9HbWdvWW13TlRU?=
 =?utf-8?B?R0QwMStzTmtjd0dteCt4K08va1EyL3pmRi9zVjZtM2dzcDVtbitNdS8rR2JE?=
 =?utf-8?B?WFpHM2tMSVFGc2FObWtNTUh5YlJIQTJ3d0Q3VXRzN3A0OXhQOWZJRkNzdTNO?=
 =?utf-8?B?Q2YrZEF1MWlEQTNxNXZRNVBLR3luT2srNTBoQkkyczMyeDdsekdwczN1QUJW?=
 =?utf-8?B?QkdYVnR5cWd3Z25HMFQ0SFBiL05DNExiVXAySFdWanFrVVp5WDgrU0pRWEdl?=
 =?utf-8?B?ZjZQTmtMaTF6dUFLSitvdDJUMGRrSkQ4N2VScXdsWnNONUNmdkV1M3UzaGFl?=
 =?utf-8?B?OW1uK2RoR0ZEakxWWmVTbzBtcGR5Nzd1OWRuMkFHS1ArTEEyRGNSQWNxZm9Y?=
 =?utf-8?B?Y1dnUWFNLzdaZ3VZMzdXQk8wdHoxczFSV2VkMThSNjBRU0R4dWc4eFBRMThV?=
 =?utf-8?B?Y2JvbUJOQ3FQWVh1R3phekRQV0dyOC9HSndsOWppWUZJUDZoc05yY3FQNXVa?=
 =?utf-8?B?dVNCallMN05IdDJacW1oUVc2V0IwaEE5eWdCeU9uZzd3dWJuRzA4TVR4Nnl3?=
 =?utf-8?B?WmxqRnpPUndHNktuVHhiMG44OU5mb1NuN0QrTEZSaVBXZDlqU29SaTNlc2ox?=
 =?utf-8?B?MXVRcVhHaFVTQU9XMUpHVENsYmovSEJNdGxFSGhjUTMwYUthM3VZbkFSei9G?=
 =?utf-8?Q?m9l/s9A8cBc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhsbGszZHh3dEhNNXdwMmNJbm1JMVN3U0RkVXVvNUljRkRMSGhyRVNjWHN0?=
 =?utf-8?B?UGhVdFFoTGR0Q3ljYmRDNUVubExkcGVXbS9wd29lcVlwN0ZDekpiR3R2Unky?=
 =?utf-8?B?S2F2djNRblArWVpEZDFrNWkwSVZEWUVlZ040VmRUS2ExZThRNEt3bkNPcUdn?=
 =?utf-8?B?STRvWmduT1FweWRoUExkZE9WRWVpcTczZXRPNGRvTU5wTDhsVUgwNVFXMnFK?=
 =?utf-8?B?K2JUbU1SbDF3SWVrbDN6Yk9UelozMjZObG0xL0ZzY0Zab1hXWmk1dk1pMkEz?=
 =?utf-8?B?Q2FmOVROdlRPYnNQbzRzcm56SFhGSDhWVjFNbHFrUTFveUNnTGVhb1NpZnM4?=
 =?utf-8?B?RlBVcHA5YjNFY3p2NnpwM3NiT2U0N1VJMlRkME5XejFBRVJJRFpFOHpTeWdL?=
 =?utf-8?B?SXFIYVVSc3Q0UXg0ZWxNa3h3NmtTUE9FZXA0V3RIRGYybWZ6djdhVzk0NXFH?=
 =?utf-8?B?dUdvRUpTNDA2SXhJRlU1V0NYNE8rQ2Q3bkdiakxQeFhHeDVEY2czOVZLQmhu?=
 =?utf-8?B?dVZNYSthL24wazFoWW9Lek0rRk1PN0FkNzJKZUJRdktDZzlSREd6U0I0V290?=
 =?utf-8?B?Zm5XVkdkODdMVllQTDh4K0Y0MTh0SHcvMW9KbU9vcStOSVArU2wwejVBditF?=
 =?utf-8?B?NUtjN2o2dE82cHBQejhSU3RsRnRhWFZkNm9JeFZWNHRRejkwR0ZPc0ppc3Zs?=
 =?utf-8?B?OUROZENZWVQ2Wkx2ZURDcTd6VWhjRkcrT3RNQ1Z3SnFXeko4MXkvbktXRUFP?=
 =?utf-8?B?QW45ZFd5NGM2U0tTYUFBSmhLemM5dkpvUzhlRDVHbTVjNmZUY3M0TzZmeks5?=
 =?utf-8?B?bWhFdzd0bnBJMnpic2Z2cG9DOE02Qlh3d1FhUEplaWc5R3NiUFR5RHZ3S0V4?=
 =?utf-8?B?aUtWUXVLN2NIOTdESHRlWHZHKzdOVzh2RC9pZ3J2SkRYVEw1amdnZCtFMU5W?=
 =?utf-8?B?KzlwK1Ura3BTVDZZMTNhNlFqYzJ2OUhVaXA2Q1FqaFlZb2ZuNnZUd0hwbHpH?=
 =?utf-8?B?N3hLdlN0YWtZbzhOMzhXQWpDUkJMSTJLc3FEcTRTY3NRTzd1ayt6cUFUc1Bv?=
 =?utf-8?B?RlZsbGo4dlRMR2p3UTR5aUR2bFlVTlJiUk1EVjRHTnlOay9tSXlUbjZmTkM3?=
 =?utf-8?B?cm1DN3IxN202ZXhLUlV5cjVzSXNWM1hWV2kydndKbXBKZEFIM09MMmNYYmpW?=
 =?utf-8?B?NnZDTFZWWm8yWHlLK1RVVTNnV05tTnJkY1Z4VWNBZjlqN0VTNUZBU0lOYUQ1?=
 =?utf-8?B?cjlrb3VSWFl4bjNVRjQ2djlncmpsSTRBazdyYmd0VFoyck4zbUNONmRHVmZs?=
 =?utf-8?B?ZFdTRk1oK0lnU2huWGNuOElVZlNUV1FpaGJUWWxTRURZT2NOSU9lMzJ6cks4?=
 =?utf-8?B?NnVtZlU1N2k3R2IzV1pINGVsMkplelBlSGhBcHN5UHk2MGl3RVNZM3hmYUtJ?=
 =?utf-8?B?L3gxYXhrUFl0Y2U0b3FFdmJVclZRS0Z1L3RRMCtoM3QyZFR1anhoR2cyUWRl?=
 =?utf-8?B?M3poTlJDM2ZZQkV1N3NSNC9qcTM0cFZpQzNGWXhra1B6cUVKWGsvU0htWE90?=
 =?utf-8?B?WW5udVIzOEQ1bjJWMkN4bC9sclRTRVMzN3RmYTNtTDlmclBvbXZ3Y1Q3NHJK?=
 =?utf-8?B?R3R5RDBiWDBYYnBOUEN5UE00U3hzaU1kbzVFMWpIdWRtR0QwMlJMY2k2bHJr?=
 =?utf-8?B?enFSWllFc2dERnIyalVtUys4dER2SDVzSVIydGYrY2oySG1yYTBoUEFyTnQz?=
 =?utf-8?B?dC9wSm1wZnNvOUpGa1BOc0FKVHc4M2NPdHNQY2w3dFdpU3V0Tm5uTW5keFBi?=
 =?utf-8?B?a3NnWnFiVCt5ME9MUzFWUjAwTXUvbVE0MzVSRG5kcVdLU2YvY3pOUHQvL3hO?=
 =?utf-8?B?OGthb1VHSDlPUW9xVTdkOGI2Yy9rUGcyQzl6L081OFBDWTErMEs3M0xJTGNn?=
 =?utf-8?B?QlV4b3UxTlJ0SzZLU0k0WlR0QUhmbXhvdEoyTm84aDJoTjJseFgwaTB2ZmFJ?=
 =?utf-8?B?NG5kaDV1RUZTNGNrYW5ac25NM29qUXlLVXlCODZiZSszOFIzS2FwMXhOeHBB?=
 =?utf-8?B?MUVZbVpKL1pWcWR5Q3pOa1dEQzJCTjcvVXVXREo2a2ZicnZwRGs3WG5JL1hC?=
 =?utf-8?B?V1djRS91MzVybkhsdVBtTEtPSW55WUx0bzh1YU12WFFOTjI1dFJWd0VkSFdU?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f187c089-32c1-4bb2-dd8b-08dd82a9fb45
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 21:01:13.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyYBazdRCeiAs4vhKs2A40nO0Ht3bD34F2DYJx5RBqY7A0F1RDaK7a99Uwl01uUVIqN8D/Jf1oPNvfZR6Kv8M4+luG+uD6OIHcIkU4TxzE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8496
X-OriginatorOrg: intel.com

Unlike sysfs, the lifetime of configfs objects is controlled by
userspace. There is no mechanism for the kernel to find and delete all
created config-items. Instead, the configfs-tsm-report mechanism has an
expectation that tsm_unregister() can happen at any time and cause
established config-item access to start failing.

That expectation is not fully satisfied. While tsm_report_read(),
tsm_report_{is,is_bin}_visible(), and tsm_report_make_item() safely fail
if tsm_ops have been unregistered, tsm_report_privlevel_store()
tsm_report_provider_show() fail to check for ops registration. Add the
missing checks for tsm_ops having been removed.

Now, in supporting the ability for tsm_unregister() to always succeed,
it leaves the problem of what to do with lingering config-items. The
expectation is that the admin that arranges for the ->remove() (unbind)
of the ${tsm_arch}-guest driver is also responsible for deletion of all
open config-items. Until that deletion happens, ->probe() (reload /
bind) of the ${tsm_arch}-guest driver fails.

This allows for emergency shutdown / revocation of attestation
interfaces, and requires coordinated restart.

Fixes: 70e6f7e2b985 ("configfs-tsm: Introduce a shared ABI for attestation reports")
Cc: stable@vger.kernel.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Sami Mujawar <sami.mujawar@arm.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reported-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/tsm.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 9432d4e303f1..096f4f7c0c11 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -15,6 +15,7 @@
 static struct tsm_provider {
 	const struct tsm_ops *ops;
 	void *data;
+	atomic_t count;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
 
@@ -92,6 +93,10 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
 	if (rc)
 		return rc;
 
+	guard(rwsem_write)(&tsm_rwsem);
+	if (!provider.ops)
+		return -ENXIO;
+
 	/*
 	 * The valid privilege levels that a TSM might accept, if it accepts a
 	 * privilege level setting at all, are a max of TSM_PRIVLEVEL_MAX (see
@@ -101,7 +106,6 @@ static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
 	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
 		return -EINVAL;
 
-	guard(rwsem_write)(&tsm_rwsem);
 	rc = try_advance_write_generation(report);
 	if (rc)
 		return rc;
@@ -115,6 +119,10 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
 					       char *buf)
 {
 	guard(rwsem_read)(&tsm_rwsem);
+
+	if (!provider.ops)
+		return -ENXIO;
+
 	return sysfs_emit(buf, "%u\n", provider.ops->privlevel_floor);
 }
 CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
@@ -217,6 +225,9 @@ CONFIGFS_ATTR_RO(tsm_report_, generation);
 static ssize_t tsm_report_provider_show(struct config_item *cfg, char *buf)
 {
 	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return -ENXIO;
+
 	return sysfs_emit(buf, "%s\n", provider.ops->name);
 }
 CONFIGFS_ATTR_RO(tsm_report_, provider);
@@ -421,12 +432,20 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
+	atomic_inc(&provider.count);
 	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
 	return &state->cfg;
 }
 
+static void tsm_report_drop_item(struct config_group *group, struct config_item *item)
+{
+	config_item_put(item);
+	atomic_dec(&provider.count);
+}
+
 static struct configfs_group_operations tsm_report_group_ops = {
 	.make_item = tsm_report_make_item,
+	.drop_item = tsm_report_drop_item,
 };
 
 static const struct config_item_type tsm_reports_type = {
@@ -459,6 +478,11 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
 		return -EBUSY;
 	}
 
+	if (atomic_read(&provider.count)) {
+		pr_err("configfs/tsm not empty\n");
+		return -EBUSY;
+	}
+
 	provider.ops = ops;
 	provider.data = priv;
 	return 0;


