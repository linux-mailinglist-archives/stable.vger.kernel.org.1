Return-Path: <stable+bounces-244455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LBGGMev+2lYfgMAu9opvQ
	(envelope-from <stable+bounces-244455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:16:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D44E08A2
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CA10301702D
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0823264CE;
	Wed,  6 May 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VK1zbNm6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896F30EF68;
	Wed,  6 May 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102205; cv=fail; b=oACelCgGIlYbXbNARRzMOsBQNatujSQgstuf9f5mLBjWWLtNiuLY4mP8cjKGk2pZecyAG98egvDgDPZTa9g85pmRk2boIJxe1dnUAlgfkU06NL7QovHSE3McU1f2LfIXKZsEDc3hJgJ3E4F2tV71PeV7TsPMODFXk7a7vejFEJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102205; c=relaxed/simple;
	bh=EBK1mCBdHy4MKTanjgi6TPwCRudFZ4+/VcvLK62FgeI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQWRD3tugNTkDz1Tie5aa1bDRohdLBj9ABoBVsW8Jtbrb7ivMrxcm+pGcCEOCokmM0o/rrK4VmdhQcCHqcDOytS67phdlxYkDbpd2Pk844G/XXQejaj+qiMavqrAfuSLQNxPlqU1O3/U4i+wseAL24C2a0fXwomX8tCqA8W4rfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VK1zbNm6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778102204; x=1809638204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EBK1mCBdHy4MKTanjgi6TPwCRudFZ4+/VcvLK62FgeI=;
  b=VK1zbNm6PqgZbqdYBvWElZljA+n37FygcdK0Us5EvqvUosIzHbRuoq7s
   RoV9SdzkdTpUHjeZ/CKX1uLwPTGWvx79zCHcVMb4kqDljgyRVnFxYn8a+
   1H5rYw/gJopVStoJ/7IxO9ixX0gloz2rV+RARcNgsLANaV3yrA5UbC6vR
   C+F0N/rOyT2EmDDG8aNd9IzYiRtWADeZyX4j8MorpwFp8OkcmMIoC2cIc
   dVJEV6cu2i6ZhW82EU+k6zHai2i4Obr1lpxAcM0Svyx6vFReMUUKVLHQz
   dLrijAXlz/9kMMgkj+1rQxRqFAaN4flqKJiqVORETccQwlPg55lGeatJa
   A==;
X-CSE-ConnectionGUID: kbUZUNBDQQ+G5GlvjfqwSw==
X-CSE-MsgGUID: 6OdDaRppRLaIduP7qR4fGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78196479"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78196479"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:16:43 -0700
X-CSE-ConnectionGUID: yg4Aqtk4SniM9hk0QR9qfA==
X-CSE-MsgGUID: Po+fizolRviPWP5VRG6T2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="231885227"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:16:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:16:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 14:16:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 14:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1fTj4DzuXp+nGOqJOOCEeYUmTdV4wNlvCu1fFPYtNMi6i415KJRE2pece2cYsgpsNkvctWJPsqEvPKcmNSGMGeDENQZpm3FsAfrHHES7CyTbfHcHM6OAq2uQWAoYnLmoxq8fFrqD6fIG0RXPoa5ILkgS10pJXAqivI43ADe2TYbjjDFn5xlq55+W9f9dypULESbT1u/po7ZOWFcBjl6UI6pMMRbbJ6JH9XMexiTH1Cx/ObrMo0qnyS4U03nsET4eDyhu8T5wpHgvivPCm7BJGRFeNlRrPOXVnRGYXgE6VKiEHlM1r5Lj7uhpVHK71NKthmBmJq/OVLyU4N6OTNVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2LFMZxLbPXbM8dR1yY8ToTGWm0RGX7iPb0P3iYBAGM=;
 b=ZwnE1RW/QeTldCuWkTENvtohHebrP0z1J3RogWHojBJmPA2Bwn7UigzBBuhancMtq5aukw5DfVV75pX+rme244P8XZ+kkbYaW8WmeWRc9fb+NXgIJBcEnr/so7aUQ6csKlNEEYFE3/7FkZESgW7i86IslZrIG+eD8YgsgHD/omxXvlSRh014cUBLDEuztWICaAuDfNBW5UncNsPjw94YSyzI3lf0VmmjMiMXtWfU4D30MrtIqgcfO6j1pStwyNXyFeXQaryf0o0boYILdFPT6oZEMmS5ccA+KRICSIkOvbW+vg3ANISDkO7sFiPIU/v1nu9Q6Kfm0OEYoRABzQSlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 21:16:39 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 21:16:39 +0000
Message-ID: <0558de37-fb75-428f-98d9-13b9594c4efe@intel.com>
Date: Wed, 6 May 2026 14:16:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 11/13] ice: fix PTP hang for E825C devices
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
	Willem de Bruijn <willemb@google.com>, Dave Ertman
	<david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Rinitha S <sx.rinitha@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-11-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-11-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: ad63376d-aae7-4f35-4627-08deabb4c337
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: lFcgD3OY6t0Aqbefi5dECcc2W6i2T9u1bWS9M6MgX0z5worxu9Y7Es7XMT1MP1zRSvUF4ikS8b0ZkKaIE5mfE7Ho9x2dCBZS+DVXOcYl1K+X6DG3wEco7fEi6n42gTABKv+mY+grqksXs9NDFlHbObIHa5Sm2TQWGE6wiSjgklkz0wJ9xDUSoPJe5iacmJQw2wDVYHZpJYMPXVP2vPt8s6z4EF0tj8PzhUr9Zs3WzHwfRQFzj4TnSgUKdnOlzgMcX/xss4SalnBP5GbKEoSQkd9fgtdqqz6Ma+xPm+XmYzpHUjevEoJYqm4EjsVqO5al4vgtilwFWuaQldMVm0n7N4LQ/2ZPI0Pfet+dZsLsv1Ns8hD0eJ8dqibS8bFffIWNhJmwBZBSPbsI/LCWHi+kQwdw8oGSIV62clZG9Xb+kDsRjZ4O483o8/cDwUOATfyifXs3cB4Zv/Dah2NvoSUaW+UAfbdLPGjbEIp9j8YhU0JYSKQm/jWUN212eHZqAS/5oVVNxi8RUVAcVZreBS/kYSJdhM9ZSXMPYulrldbAvB6ndv7oBwZsjUo4tS3Ye9CArQBmSyuSb72AJkNe1/4IcPz3aJB9sD8mbowwS6ifCvqGRRxonTro+cOUuHVZXKgMzV044Gqi5AtVbu6KErFCdUXR1gPo3ihYchD7u0dYCLTnl8poU1z8B9c28cxMNLY7P2y+FAYohtk5H8PsaTjQeiLhIK0ZPqmWpdh7lR9jr7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhwZjVUakt4Sm9MSW5YNXRQT1lpcXNld0JqZHBPS0FtZjVHM3JOY1l6RWJp?=
 =?utf-8?B?NStodWtDWC9OT3Jnei9MYSswS2lQMVRHTTFtSXVKZ1pGR25YYUNkdGFRZjV4?=
 =?utf-8?B?UFJySklVRDR4WkdkbHM1QldpNE9KSVB5TWVBQkkzTHQ2SU41Uk1NaEhxdUsw?=
 =?utf-8?B?UGtnSWFRSEd2ZFB0SG1qSk82V2Q1SVE4ak5ST1VqTTlJRGFIeDViK25udEY3?=
 =?utf-8?B?R0p0UFJrMG9EMXB6L0RBZnhQZ1JsWVVPd0hxRjZZVm9OOFdSMXJLanlWc0gx?=
 =?utf-8?B?MEhKcCtyQmhHaXNIeE5IcHBTYjNONmZURW82bW1iUlp5dkZLeTNrY0Y5MmZl?=
 =?utf-8?B?RFJhamJIaWtiVVRQSmdqQlhrSU1zTlV3YkdtdkhlOUtLaFJhbEpwTmx4bldS?=
 =?utf-8?B?NDB0WkphNkxjRnFyRzFva0RlbWVvalFDODQ0SERaa0UySkZQZGpXck40MFZT?=
 =?utf-8?B?aGVLYkZLQmRnbDZ4RjA1cDFwSU9IdWtqQ2tQQWdyQUNuS3gvTTBUU1RmS3dJ?=
 =?utf-8?B?aG5FNlcxZ2dXalZhR2xpQU9ieXlGMnlDNVNibmRQYitNVnVYTkdGa21lVXgw?=
 =?utf-8?B?aDRmTGMyL00velRIRTZJV1lOYjdxRkx3RWlSVTZVbVZ1N3dYVTJOYU5kRjNx?=
 =?utf-8?B?bFFzeitlb3NXOVZDQkMwZXVybERxMzhhcXV3anJEdU4rOXA5V2dwM2V5RndH?=
 =?utf-8?B?Z29ZQWRRUFZpRWd0ZWIyRW1YYXdtWEhWYm9CZ0lWSWMxa1gyZTFmUnhmYm83?=
 =?utf-8?B?TUpxbStWc0Fua3hvMHovUmVSaUExcGxpNEEyQTdOYzZiTFRmQmk3T3Y4NG1v?=
 =?utf-8?B?K3orYzBQdFBRc3JEQW1lRHEzS2k0bmloUy9YeEhCOGI1dUl5a05Nczk2UWFF?=
 =?utf-8?B?T001YUhjQUJGOFE0YVFwZzJwSEtxSjcwajc0VnJCV3lyRW4yV2g2dzV0SDY1?=
 =?utf-8?B?SExUVVh4SXV3UTlmS0dLb0M2ZEU1TnNLN2FMcys4cG1NSllIODZBL2JoTmV3?=
 =?utf-8?B?MlJZRWQ1RHp3NHFoSjNhb1JGZTNMTE1FckM5MTAzRis5Sk1jL0RqV1YvZDRP?=
 =?utf-8?B?cjBRSHlJOFA0SXlsQUJGSFlhbWhIQXhadGlhdTJEK1lJMlQwbnk1WkJhWUFm?=
 =?utf-8?B?cHovdkdPSnRzaFlHeWUrRnNhNTNaVFdieG9Gd0pSb2t6MS8zS2RlWkE5VVpN?=
 =?utf-8?B?R3pGVGg3N2c4MjdpbzMyMjRYLys2RStTMC9LMkV3cTdiNzErVUNpZ29OaFAy?=
 =?utf-8?B?Z3IwYTcrT2JHSXk5cndkNnJ1bXlrOVFDTHBUNGd3T3JQMHRySnBtOUluWEhF?=
 =?utf-8?B?anBSdHRvb3ZmOXdOaDI1dGsvVDZnTzVabDhHODVVb0hRTEdxQzFWY2dReEhW?=
 =?utf-8?B?eDlvZjhFK1dGOXJTc3c2RzN4emZKcDNYQWQrbnJ3VGo1MWRKVnZzMzZJbFJ2?=
 =?utf-8?B?aXY5MjA0bTM5dVlQVmw4LzJaUnlCUmlEWWZRcDN5N1NNQ09nMVRKTWpwZEZR?=
 =?utf-8?B?S0FEc1JYWk1sZnBBTEZieHNrVDBxMTdsc1p6cW9YemQ4Y1dvcWVYUWNyRXVO?=
 =?utf-8?B?VEFZUTBhZlpkWUhZZnhRV3h0Rm1US2NNSkZKekNHMXlmcFJzVWYwUFVGbWoz?=
 =?utf-8?B?S1hqOUgvSFNpalZtbDgzTUowUmpvbmc5YVBMRGUzbENiOHd1Y1pkYXRiK1Y0?=
 =?utf-8?B?N1lSd0cvTWZCL3owRHJtc1g1Mzc5MWpEWGl1Z2VLd3pXWUZ3eWhKTEZEOFYw?=
 =?utf-8?B?UnlNNFcySnFNKzNtRWhzdjFQZFNCTy9SRHlOS2hmUHhoVFl4dStpbThDSXU3?=
 =?utf-8?B?Wmh0eDJyRGZ1RmlxYUp3MjFhMVV4UWJrRTJid01mazZmVFZSUEt1MXRuUW5W?=
 =?utf-8?B?a0wyTkQwMjJtNy9xVUYxQSsvU0JaZVRvZVkxcFVsUDJKSDRFN1dKMDd4emx2?=
 =?utf-8?B?SzdlekV0UGFGdGkyQWI5emNHdW1SWGR0N0g5bzV2cVBxdGQyNy9ZT2thQ0p3?=
 =?utf-8?B?RElwQmkzZm0xTGIyb2hVNHdadC9mNDkzY0VKRXlSMnRycGJ5NVBSbTU1Wnc3?=
 =?utf-8?B?LzhnQjZqcTNmbUZRbnBRV3pPamdXWjR4cFRuNHZnSkQ1eVVVOHc0WG83S3lq?=
 =?utf-8?B?WjBQWGN6ZmMvbGI2NytXS05pZk1jaFBNc3UzYXIvSGdkWDduc1JTTkVydmdx?=
 =?utf-8?B?MHhuekxzN1hlVVZKenAvMEVROThwSlBpMWlLQlJ5R25qUkxqczkxVjJCMWpF?=
 =?utf-8?B?WUJJdjgweENJeFcxWVVVa2ZGdHJzMng2dDF2cExJNUExTkRkRFJvdUNuTnZG?=
 =?utf-8?B?VHFvN204U1B1OVk5dWFYc1BzMXJBSXZWZldxNWg1bFBMb3crd05SdDFiS2tz?=
 =?utf-8?Q?xfjmV+FQpLybNJhI=3D?=
X-Exchange-RoutingPolicyChecked: rHg5poYWkd1jhoKw9n7C/0Tw1/phwoEdm9qLbgTmifhx3AYebV+vptLTQnyZ7KR6b4IErIKZmf9fz8LPBJTJqysCXybC45/2vxu37To9Pt/2CmBAcbnqmWgD178dAKTufZFj07p5KRkoQ3bmudGxR9BJPg+ZXQ0H/++1OIw/DWaiCG9Lhu8ISGsQtuVWVlgKXHrsrlb3uJcZ6e70HOqmG2JaI0s62YgAfpcX9wPLBxetLRlTJj5STmlfUYKXgSBmMrBruv+Qjuc70g1j1/T9VnccKzvo6Yeum1RTAWxEyaJnQrlMz4uEe9RrwBqfMNSvPpXuQtGcSRVaw+rQRpSilw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad63376d-aae7-4f35-4627-08deabb4c337
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 21:16:39.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGG54l5555gHNm07EGOSIn60BxBUf6uWV6IzCYUqjLdOI19LgTN6XoI2oJ5PvGm4uPe9g6bSfwwjf+IpHIFrehG9CETxIR74WHsDIupKydM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B42D44E08A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244455-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Change the order of PTP reconfiguration when port goes down or up
> (ice_down and ice_up calls) to be more graceful and consistent from
> timestamp interrupts processing perspective.
> 
> For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
> is called which starts/stops PTP timer. This patch changes the order:
> - while link goes down: disable net device Tx first (netif_carrier_off,
>   netif_tx_disable), then call ice_ptp_link_change
> - while link goes up: ice_ptp_link_change called first, then re-enable
>   net device Tx (netif_tx_start_all_queues)
> 
> Otherwise, there is a narrow window in which PTP timestamp request has
> been triggered and timestamp processing occurs when PTP timer is not
> enabled yet (up case) or already disabled (down case). This may lead to
> undefined behavior and receiving invalid timestamps. This case was
> observed on E825C devices only.
> 

Sashiko has some concerns:

> Does this sequence still leave a window for early packets to trigger PTP
> processing before the timer is ready?
> Looking earlier in ice_up_complete(), the hardware Rx rings are started
> before we reach this point:
> 	err = ice_vsi_start_all_rx_rings(vsi);
> 	if (err)
> 		return err;
> Since ice_vsi_start_all_rx_rings() is called before ice_ptp_link_change(),
> could packets be received and timestamped before the PTP timer is actually
> enabled?

This doesn't matter. The issue is for Tx timestamps and the Rx path is
unrelated here.

Sashiko also says:

> Is the race condition fully closed by moving ice_ptp_link_change() here?
> While netif_tx_disable() stops the OS networking stack from enqueuing new
> packets, it does not flush or wait for the hardware DMA rings to drain. The
> hardware Tx rings are actually stopped later in the teardown process:
> 	ice_vsi_dis_irq(vsi);
> 	tx_err = ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
> If an in-flight packet from the hardware Tx ring triggers a PTP timestamp
> request after ice_ptp_link_change() has set ptp_port->link_up = false,
> wouldn't the software worker ignore the timestamp?
> Leaving a valid timestamp unread in the hardware FIFO is noted as the cause
> of the PHY hang. Should ice_ptp_link_change() be called after the hardware
> rings are fully stopped to completely avoid this regression?
> Additionally, is there a missing VSI type check here in ice_down()?
> Unlike ice_up_complete(), which checks if the VSI is a PF or SF, this block
> executes for any VSI that has a netdev.
> Because the PTP timer is shared at the physical port level, could bringing
> down a secondary interface (like a sub-function) invoke ice_down() and
> unconditionally disable the PTP timer for vsi->back?
> This seems like it would break PTP functionality for the main PF interface
> and any other active sub-functions on that port.

This I am not sure. Gregorz, do you have any thoughts? I thought we had
spoken about this and were maybe investigating separating the PTP link
state from the admin up/down state entirely.

