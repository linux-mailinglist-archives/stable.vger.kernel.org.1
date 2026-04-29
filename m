Return-Path: <stable+bounces-241952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YoZRLsl78mlcrwEAu9opvQ
	(envelope-from <stable+bounces-241952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:44:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15149AAD7
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 839453022AB2
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A473A1692;
	Wed, 29 Apr 2026 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSEAD+CS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCCA5474F;
	Wed, 29 Apr 2026 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499075; cv=fail; b=QSdI7KQD6jMUNBs5paBW5eHFtK2qpYZxevZr7j1D8YYdqRz3WM0+6xOGDSf4AAdF9XpKoVa6HZre/8WEh4WqdGV2qSVtoixxa9EmZm8niooz8DZUKoOlYuJqtqxwikvucTkw8b8/W7eW3N1K8I9HUqcDbkG7nGzrkSTFHHAPCZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499075; c=relaxed/simple;
	bh=1bnRX6jPgROMUU+clBtoedqeeDaXh4ya6dY7NtW6OrI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CADDmukVZmUgctPq/3nugy2RpaWvkNKgYat5U5JEtAeUrSpApyAmM5exXS+oDocgGA3XI7TcBfytNOAKvx0OqxYxBBJM0s0pnaaMY9IBT7HTDo9H/1HOzd/SOfaSvC9YSPWbzZlvikXQmQ9Iu21SSdFTHLEqI7+l66TFIOLM1bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSEAD+CS; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777499074; x=1809035074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1bnRX6jPgROMUU+clBtoedqeeDaXh4ya6dY7NtW6OrI=;
  b=fSEAD+CSNENAaed5Vtezp1lhGlt/pKme6WNMr8CnnC3ucsNnJ9EzM5BX
   7HyLYf8gqkco+8y0hTIPrXupXD2GGfdpSh3K85MkpObMi47HRaM2AmDyI
   r891wYSVDQJY8YMqpp+dj4Z8d1LHPT9LTmxWFSE8ebaeImQGkTUW7NQMQ
   SMdsISHQvUqXmwV7bT+cYcFa2qmUDeqOyz01xnwSCKRc9OXB9KOOOLzWF
   0Foa4d65hMBPYbw+EC7RX6C4PUl1EJEkvXI/bHwM4PINcwCCuqPNO2Gey
   dwe9Ch9TAD2y+BXG89rPWCKKMaFR9Pk64LM5TOfPNnsbRKNj1A/HE7v22
   g==;
X-CSE-ConnectionGUID: M/TzCCRWQyOn4m13q4a26w==
X-CSE-MsgGUID: Z9wk1sDeQmuf6hGFuQfDIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78547046"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78547046"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 14:44:34 -0700
X-CSE-ConnectionGUID: 9ZoifJ6rQj28ayzrj55Ntg==
X-CSE-MsgGUID: HllDItUZRGWcEf80+rmkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234659086"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 14:44:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 14:44:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 14:44:33 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.67)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 14:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAEFbH5lQlC0c954gFYEn9uxcvxT7byUj0AtgwMj7Flgd22qzyE1l5CMhFoUbr90ghkmfKrPOdyMxHHv5Y1nj3l/BpGrEfGL483evWc7iQy1ZjD53dwB/gcf+2N2ZxNS4LB1qzG9dBcSsEnT+nZEuPED9wJjuXSAndZtw6mxirdr+27PzFvDPHvf7sTvrPUMVzAnJiJundnlRAn/TVcm9qmHorIaCAfdqwhoO1VkOp+5U38RAB1lZWz3w5u5e+FaDTpkb4P5ZCJCopUtHIs9KAMMy0EsMg8bvulhwymdxi7JGvfVbq8zh/9R6T6yKjT6twUlWfYp/WUtWHtPrxn+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad7d1SfNmPHbNcD5EuRIL9WBmsbT/JB+KL/eLDlwkZU=;
 b=dNqEMa/jo+Oq0WoCHKgr/ItWe2w+Cx45M46b1reXusWHQjUe8Cmvg03h2K+k7JLMGYeJK9+LpXjafKTWeK7plDXsVeilQnDU4iJjOX6tV0jcdWLsGQsCI6WruwKqUf3/9aVj2mC1tGuE2EPi+DTx/WLFDcDrs/+HJRTh0YhB3aXqsQgCxY0m62vZC6ImfHkm2YYohtiq8IE3IjoJJ6OR2Yozbzsq1FvnRQeqnYqoN97mmdJkSWTYaGDmT3i2QJns6dZpuqpGpEa5ySM5e1wT7DEMsSIDfKWFTXm3A9JXk3a30JwAPG1NBOwKo98wu2djC8KwQdoHE5IQpOuvCHKaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 21:44:28 +0000
Received: from IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::7f71:9797:c718:c891]) by IA1PR11MB7917.namprd11.prod.outlook.com
 ([fe80::7f71:9797:c718:c891%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 21:44:28 +0000
Message-ID: <a1614b76-192f-41b3-a4e9-a4ce6816d745@intel.com>
Date: Wed, 29 Apr 2026 14:44:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "x86/fpu: Refine and simplify the magic number
 check during signal return"
To: Andrei Vagin <avagin@gmail.com>
CC: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<criu@lists.linux.dev>, <x86@kernel.org>, <stable@vger.kernel.org>
References: <20260429000623.3356606-1-avagin@google.com>
 <7c2681ee-a53c-402c-8947-e7a74f8720c8@intel.com>
 <CANaxB-xvGc1A3Ga_ASh-RZbh0+abxp4e4qbiPKcMJ5-5Wtzr6Q@mail.gmail.com>
 <3ef742fe-9761-4714-84d9-e72fabc5def1@intel.com>
 <CANaxB-y4wh3JYUctDMWVuuOz9ZhVH9RAwopPZQ39JfmxkjN56g@mail.gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CANaxB-y4wh3JYUctDMWVuuOz9ZhVH9RAwopPZQ39JfmxkjN56g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To IA1PR11MB7917.namprd11.prod.outlook.com
 (2603:10b6:208:3fe::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7917:EE_|SJ5PPF2F7FC4EE6:EE_
X-MS-Office365-Filtering-Correlation-Id: 2693069e-9cc3-4095-ed21-08dea6387d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8dC/fTzrM0vhsUpZk5qUbPkRVIWS6WmrVPg4qouIceQxCM36/Y4ZtrKWdNbB+NybXViZN2SYlx/nH88wkUW9VTB+vkkbakm9O9gKsOFrMJsjhC22IpZjx+3vyApiyhjZq1NcYKKJW9kAWNrK9VGGGNZ4/2xHZDOduUpP+h0jjCGVJZpES9U76/ylgYJe6wwDxBuNWYPmUTGwfdtwvjiU3BIXc1LkNNliz53gim9RZMxBZRWRGZZ+aCs840Kd3WAPBlSpFeQPXzpi526JLxQb+rJVNwHR94KtHzJxWwNOTEG9r9CgXxhxHjZsX4aMHBLAoGm4Ql0duXtirbqk4UaTwu9bGAqHw4oy/uwr4pSHdN4iUQXSp9uaduRI2yhm77rQ9egpVdCwV9uX4DaLphym+H/+6wWOqvCAZhBRAJe5pVZWTPKPhuylF69MzKVgo0Rw4chR4ICHKY+KZXqt5xcw09D3LWzUfXu94iV4/s4t52FyBIGLVhiV0B+Toqb3jLiuhTmEcKUbo181RUz3dI5+0bSceEgusidJtqYRZJ9O1hYtWIYEMRKvBSZUwvYOUr0JBPqL6yLzMu8SPRhjWwiSa0a5efZmL5vvVjSi7MxKipXisHWT78GlDp/tIwLkEQi+lIjq1iA44bWSMzuePDUNn84Pl6MUcKgODXbOqujgJnNV28L6UymzaHxIr6zN8+X5wc+NXn/Ak1ZNP5AhS4IaS67LPbu/2tJeFmfId0F33tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7917.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNOV1dOc1hZU0ljNVBmWndxSXJLVjdaZTdxOWx1VmdMb2thT1dwMW9CRW1I?=
 =?utf-8?B?ZUMxVUJjNkJvOFJUMFZNRGt5eWNFaGlKdldxN3U2b3lhSlFkazllQ3pBTm5K?=
 =?utf-8?B?ZEZDTHJQMUNwdGVkNm5KRnRMY2tMeFZ3N3owZk9YNFBONCtlYzNmK1lqNDBG?=
 =?utf-8?B?eWRJRVFuZGFCR3ZXOE5LVkxVVUJha05OMjVJaHVrVUFPYWl4MzQ4L3JZUXRa?=
 =?utf-8?B?ZEpWZVRxcUVBKzB2d2NKNGtRekVadkhGRHk4QUpLQXlzMGpaWGFLOXZCaFpn?=
 =?utf-8?B?aDlUSU4vM2VWek5UeHljem5zNjhNcnQ3MFVCZGhWdy8ycHdYT01jeTlZeG5H?=
 =?utf-8?B?eVFMalJzSm5WeExHMjVVeERObjRNczViN0pDWmIzWUp5MHhRUVI2RFRwN0dK?=
 =?utf-8?B?VlJqQ3dMWlZvUmVBZDFpcElIK3FNRE1tSFJxMzRtWHplUGhBNlZZdThxRVdD?=
 =?utf-8?B?akNacUdMM2s2eFBCRjBwVUVraXpuWkhTQlNlbjArd2ZkRmEzeEw2YTZPUDdP?=
 =?utf-8?B?ZHdQVE5oQzI2Y0x3Q3FQRklZNTZ4SFhlMXl3QVorWlFYUGV6ZGlTRFRXdlNh?=
 =?utf-8?B?RDA2OUZKRmVuV2tSVG4vb0ZSaDRCNzlXNm9UMStmT04rMlFkT3VJcytPcmQz?=
 =?utf-8?B?bEVlaW5lQk9iRkhnRkc4eVVISUo0STFhNm05eEdNQklRenBCZHRGZWR6MEJr?=
 =?utf-8?B?aVZyZlZONDAwY0NqQ1o5QkVabFl3UzNEZXRzVHFFcEJ1NVBlZW9KaEFFRFZv?=
 =?utf-8?B?blBlN2VSVWdRaFQrVWQrNEMreUxJeVZzbVRWbkZBRndOTDk0aHlwMkhONkEy?=
 =?utf-8?B?dVErM2UwM1dyM3ZaUTFFN0E4blU5emM0bnpUVHhGdlRVcHI1RTZpdFVQdDhN?=
 =?utf-8?B?U0NXRXduWm1rRXZwT2NPWXBhUnN6VkFBMEgxMWpnVC82c1VUWVVEbldzT1VR?=
 =?utf-8?B?TXJDazZyMkpHaXhmaGllRU5hTmdJTzVoazAwbU5id25DSW9UdEUxVmZ4VVpm?=
 =?utf-8?B?RHdDSG5QVDVEZVVSVndjVkt6UUlCbTg3OUc3MlpkOU85b3ZNRHgxVnNNZC9v?=
 =?utf-8?B?aHZjY0c4MzJiMEVCbWlPS1JucWYrWTN2TCtlck4wUWRyK09CRjYzaTVWbzln?=
 =?utf-8?B?VmIzWXU4L0hHdEczeS9qMjQ3cmtKTTg3ZCtGRTBWalRXblBETjIwYXBkclor?=
 =?utf-8?B?a1NFK0h5b0R0YVRwYmFteUtmYnJiSzRhWUVjcDF3Wml3VWJSL1d4Y014d0hT?=
 =?utf-8?B?VmNqZittMGVJUzlYUlo3U3AvM3dLM2FNUlBOWGw3bW1NeXQ2VmQ1RTlKT3Ay?=
 =?utf-8?B?NUdtSU1BaVYvY21kY0gyN3h3dnBwNjc0eHlSMHg5cVVrQ0E2WExDdE80ODAx?=
 =?utf-8?B?Vkc4WXkrcm9RcEo4c3Yrc0NENXNoSmF2bUZzUUhJTitac3JmekpNV1NtK3FL?=
 =?utf-8?B?MDV2N3o4WVlvUGhxVVduYkJTdjVObFgrQ1d6ck96K1NJeXdUQTNabHNaK0t2?=
 =?utf-8?B?d015MFQ0YnpZSnRMdlFkL0NkYlJnMkJNMkxUVWhqU0krZ21uL1RaL3FOVjRi?=
 =?utf-8?B?NUtUSXpQSnBldmswK3lYemhkcldNRUNERFRhVzZGV0ZFdzBYdDk4TTFoSGFt?=
 =?utf-8?B?SVllUmlvckdHTVQ2OExzWEZ4ZjQyS2E1QWRyK1A2TzE2RWRkMHBxbFBLNkNO?=
 =?utf-8?B?bXQxWkZsR2lOaTFLTkJDQTZTeHorMGZ2U215ZGFPT3lZcDFod0NkNUxoQmly?=
 =?utf-8?B?SnpnbmVJNGpDeURPYXJNNmtJaVpUVmRaelhKUk5yOERZYURzTnNocUtjN2c3?=
 =?utf-8?B?b2F5UmZOY1lvOU4xckJFeXRXd01LMDVSYmdlZWVHTnBMNkN1Q0dBanY3c0ti?=
 =?utf-8?B?U3d4RXMwTi91c1VxS0ZuaXJwVVIrWFJZUmlhdDJBRTA4N0h1bmZSVnpkVnBo?=
 =?utf-8?B?K01wejBXWmM2M2NFMXdCNFM1M3NGR21FL0ZSTmtLZkJxdzNBUDB6MXM3Vk9N?=
 =?utf-8?B?MU05ZU9HYnlqcTJLR3VxVDNmdUd0TklZZFRud3YzZjU4MEViZFhwdkQrNUhW?=
 =?utf-8?B?aElHWWRNKzI5WXBqb01UQ2pxZmhTV0VaaWwvOFAvMzNlZ3U1Qmt4RWxTWlNF?=
 =?utf-8?B?UFlhbGMvajFReXhHZXc1WjZuMVYyKzJ3OU5lVGw3SGNYTHFEcGlTUVplQkla?=
 =?utf-8?B?b2tSaXlwU0xIRm41cUJDeFRBVGxweTdiWXhBRzQwQ2pVNmZ0aUlDM3VyOHhW?=
 =?utf-8?B?YVJ5MUlhcUFYQnVmOGVtRUxVZUwzaDdCOFZBRHR5NFBjRzcwdEVURUxtOTVO?=
 =?utf-8?B?U0lEOXZXTzZEMmZGWDFVbFZMQ01TZVpLMm56V2xHS1dTTFllK2RNUT09?=
X-Exchange-RoutingPolicyChecked: Jbbu3dBHw89RMeV7ap9h1EW1Ln5+Zc8h692Flgmm10cU+0CjUESDDdIwj20G/KEppOp1q68EU+1ObRn5GL2MMkFp2OO0bJInpE5M2nr8YvN6x+ZEDzxuhQZjR9dpJP8VVkavLg1EdMIdYoCNMvUQds3bXDozXfTUp6eQIsIjJ/MA5y0fJoZ82DDPNBL+9ll7DG5XwwlFTEG/f7k3z35QVaxcOzdPT5JY/xPk3nwJuVI1gNWMQq7Jo3vmhFcN71/qOlvPT0PR22sG+XNAY+w5mM7B7pBPNR8i0MMYo9p12NvnJ5ZYZoRWdXQAhS6R9CjTd4ygrzrdqvxtLj0yWeoDJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2693069e-9cc3-4095-ed21-08dea6387d20
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7917.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:44:28.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JXTLDlohDWYmavkTUFQfMuj+xDzy6MCZKngNW8X0Gm9ZjOWQm0JtkOwNUDZhrvUD4wyFPoo4tG+G6LZp3OY8fqSkwBxQ4fDBbnwN1gNNpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F7FC4EE6
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BF15149AAD7
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
	TAGGED_FROM(0.00)[bounces-241952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chang.seok.bae@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/29/2026 1:44 PM, Andrei Vagin wrote:
> 
> Enforcing validation against 'fpstate->user_size' instead of the frame's
> own 'fx_sw->xstate_size' changes the kernel ABI, it isn't strengthen the
> sanity check logic. When user-space supplies a valid, self-consistent
> frame with an explicit size that older kernels accepted, and the updated
> logic rejects it, which triggers a userspace regression.
Sorry, I don't get your version of ABI.

Eventually, XRSTOR will execute to restore the state. The kernel tracks 
each task's requested feature bitmap (RFBM), which determines the size. 
As describe SDM Vol.1, Section 13.13:

    An execution of an instruction in the XSAVE feature set may access
    any byte of any state component on which that execution operates even
    when saving a state component is omitted ...

Given this, the kernel must ensure the backing memory is valid and 
sufficient. So this consistency does matter.

Thanks,
Chang

