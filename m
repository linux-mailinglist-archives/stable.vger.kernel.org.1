Return-Path: <stable+bounces-213332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCVdLPWjgmlpXAMAu9opvQ
	(envelope-from <stable+bounces-213332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:42:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3CE07E1
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031B530689A3
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 01:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B373285CA7;
	Wed,  4 Feb 2026 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3lBwUYK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934B280014;
	Wed,  4 Feb 2026 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169319; cv=fail; b=tHEMB3ymt4WU+BBW5F41GImLEUCGi+9pwXW0ff/rjdHNyzmtOnpK5nWX5G/hkepJ0/FrS99r7m/eIwZTif2faBVzFT5f8V+p+G+ClTTBJVeOo9D2RlsQ+2QW1/15C0Gfr4bNun4PJnHkUVYDMSP1Zmp+RtIftFq7xQqpS4azIRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169319; c=relaxed/simple;
	bh=S3ccX0H0QjZ8UXkcEegbHmwWwkdcQATUuS0yVOM3gkU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCvt65fpnz1iSry2iDtTMfxu+bDhRYapkitCDhw8q/uZCTYF2zbei7LW3QaX6r+4E7/nDkeQXisqVgVheIAblLPK6nnAIFEsZPlg32WLHPOgDWod1RP7kylqkgyp7pjU53tZMFp5KWLWIwfh5sZdv18LMrsLSxuCbbc/7fRLjNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3lBwUYK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770169318; x=1801705318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S3ccX0H0QjZ8UXkcEegbHmwWwkdcQATUuS0yVOM3gkU=;
  b=M3lBwUYKoAGXttmkEgN39S7M75JRsxUxuWzAbRY9ATnO3sNPQDPkjn0b
   1qlBgGkzWCTqQf6RyQTDn5okhedqHhFC+JlNvN0uULJlcRBddNV8g21Nk
   DW9EVeASl55bVLuNJHOSU91eOt9Tdx92fRMIxWtN/EOJ8LKEWmKHP54hP
   9CpaNDeKJ2ODaGkbQMkD+2Gvj6njyKHXiDIsNUTscMk0eCzPHMjbAIICy
   zrax9dpQ2LYD0cxUwOXP7tyv42m663IhMDMYTxuCCHXYheZlRLHwoDFAP
   8gh59qKmeAa90OoD/CnfchDq4pesgoB7FoO8wra4XcuyOGquF7JB5IKfD
   Q==;
X-CSE-ConnectionGUID: HSyRtWgASgGA2quxZb8Z7A==
X-CSE-MsgGUID: CcYZYvdUR+6UQPxv712WuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96807526"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="96807526"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:41:57 -0800
X-CSE-ConnectionGUID: 1JV9WgY/TheA+RugPsuoiQ==
X-CSE-MsgGUID: t3CnKZvXRnGqzzKjO+5vLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210123924"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:41:57 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 17:41:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 17:41:55 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 17:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMY9qwYuH+SBjPdwPBXi+ngByJQSkIVnIlft81wd981TY0hPl06tESXt6D0D4nmLxePTUjfuoXVmokxMCvi9No4fbgOSJzCmkl54Gm0sGmZxY5QLGJLsm/BQWA6TYd5cPM7Xz7Fum+VJMFWi3fWgapiBRyVQ6v0OnaTOD9ScAKslhEBAR/7QebT4GTdGQnhxa6vNhXMit1NUztgouU7dUDFjo/pNGt4jyzF9WaTs0kCP8A2QIjBUpx+MwiDRnVoGmooyFP3mJufx0jRonOogN3TLR0Uar0jttUOwC2sVNzik/QBybeUeg0oN9qONRp4BMmuq/mPWcTMxsGxsEgNGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rV7qX+0yrT7teGdXk3uJNx5wDRBOPifWXC/8UulqKE=;
 b=eb+mKpKsKLiA8jMZLrsdHJa1siE/I+Aua3f88fVVJ2F6ZlFtlkpFXIm4seOKGOjG0Hd4V0cTyShuCE9BzEq2H/+1l/7757Jg14eyZTP2afUWVktRggFrDrGb8NttEv7P/syUHM50gLf7w4DjnHX8uqvjn5fTI0mLTqRDREZ/CX+tD+hojTGLEbLUZ1oUCa85JTRjLxFWCfLiXGzR94NhghPMnbO7bCZ2PBD0SRDEa1EXx2jS5dGvyreQMlZcb5eQvwmZnmTXzgo6JJvExCxNfNUtPRZHSAHTsyU498Ebnfr7OPcjgZRLWxxU+RScTVRegWNkfgXXBpoMOFNO2E571A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 01:41:53 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 01:41:53 +0000
Message-ID: <5147b618-cc2e-4edb-8e9c-978c48f2dd55@intel.com>
Date: Tue, 3 Feb 2026 17:41:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] gve: Fix stats report corruption on queue count
 change
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <ziweixiao@google.com>, <jordanrhee@google.com>,
	<nktgrg@google.com>, <kuozhao@google.com>, <yangchun@google.com>,
	<awogbemila@google.com>, <maolson@google.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.com>, Debarghya Kundu <debarghyak@google.com>,
	<stable@vger.kernel.org>
References: <20260202193925.3106272-1-hramamurthy@google.com>
 <20260202193925.3106272-2-hramamurthy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260202193925.3106272-2-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 92975387-2efd-4315-c1d8-08de638e929b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHByRkJFazBkNmMzQmJadHU5SVJueTQzTHVPSzF2ejdNZDZudGhWWmUvelJl?=
 =?utf-8?B?QmV3T0VDRStYYmdYb2k3TnU0Ly9tY1J0anZPajE0ZFp5aEJwUjFQRXlJQVBp?=
 =?utf-8?B?TUpRMGxYUEZsc1FkTmZoOWpBbWxkaTNaTkwrMlhjNkw1K3pCYTZOM2pKTnRF?=
 =?utf-8?B?TXhtaDczaVBtdCt3SlpRUGdxZ1gwMmpvTDJEVTh2VkhGSmpLV1JyNisvRXJY?=
 =?utf-8?B?anZXZzZjc1BOZGpuRU9mdlgwN1QrRVM2eXFYYms3L3dZcW9SYWllWXF3YU5G?=
 =?utf-8?B?T2RCVm5iUHAzRXk0WENjUUVlQnYydCthbGo3WjF4Vyt1N3pXSVgxRHZQTUlZ?=
 =?utf-8?B?T2hqbHVxblJUdHFDY3hBQUh3SmJEK2M1MWJTZnVUWng1U3BDOWtobTd3bUdH?=
 =?utf-8?B?M0NaVit0aUZTYlFSWjJ6cnlxbWphK003TWVzR3AvN0c1QW9IaFVkNmJJbTI3?=
 =?utf-8?B?dTZUa0VNOXJBREVCYXFMdDE4SG1NL2o2S1I4VktIRlhPcDBob2pqZEFvMzBI?=
 =?utf-8?B?YXVmc0Jyc24yU1VBQzluVCthc1RiY1RJc0YxdVJwbTRqLyt1N3RzY294eHhV?=
 =?utf-8?B?QWRFYTc2Mk1UblhTRW5wenpENHJzbFZ2ZHpGUndtTHBUZkVFaEc2ck9KY2E4?=
 =?utf-8?B?RHpiblUxdUw0NWFpckltN2NCNmZJR0RnUERIYTJVS1NQS3hVWHNVUEYzMWJm?=
 =?utf-8?B?cXNRamQ5TGc1bEVSV2I2aS9SVzF0bmg0bzZHVlhSYmtySnJzbFVtNlZmclZp?=
 =?utf-8?B?ZnExOW1LRm9YUkpVQmxIeUxJckhZQ09uU05xK2dKZ2RzYmVXNDdrVzV3b2ZD?=
 =?utf-8?B?a1hKTmlMWmNXWVNONXUxeGlocGY4TGlSNTdoSStocFlqRGxUNjRJTGlIbWhC?=
 =?utf-8?B?Yy9SYlB2bDdEdVd1NUNEUzlGV29ob2d5dDlHTFJIR0ZNNm11ZTk2d0FjN3k5?=
 =?utf-8?B?S21GYXlKSmhVRThvdzRlanV5Zmdad1QzYWJsZEFFZU1VTm5XS3Z4c0U3cU9F?=
 =?utf-8?B?UkxpU3crUjhhZXZMMjRWbURaN0xWQ2FUMU52aU5ibHJKTnJ6NGN3Vm5heGZ3?=
 =?utf-8?B?YkRnYkVodUNVNmRiWnhQL3ZOUzVMVThTN0V1MnY3YzdUam9QbStlY0FNREo0?=
 =?utf-8?B?SmNiV0dCeWI4cmZCOG5OUlN2MUx0RnM0UjJEU2FlSm14RjZBWUwySTR3aGc5?=
 =?utf-8?B?WlZBR1p5cVJBbU1HdlNpOFZRSzNKODZyT1ZzTjFsaVZMYnZyZE8yT1l1UUQv?=
 =?utf-8?B?Sm1uYVdoeGdvaCt0NFFqU2FPYjRzN1haUmlhUDB3WGkvYlJ1TC9qRDdzVmor?=
 =?utf-8?B?TlQvTzhkVE9PYTFVZm5Xc1I1eTkwVWNsSGgyYmxCSmRYVS96TXpnQjFLSGVt?=
 =?utf-8?B?Q3puVHM5ak4vV3NRVWdLSmtMcUJFTnNUMWtwcHJkbnNQMTIvaXFod3hnTGRy?=
 =?utf-8?B?dVBuUzJaZlZzUHdUZ2JQQzJ0VUc5WldrLzJUbmtQcWtkOEVQRG9hSHBOdU5Z?=
 =?utf-8?B?SlI0a2Rnei81U3VEM0p4LzlJTUlrMG11UGk4c3BUbDVtc28zRDFPUFA1RjJH?=
 =?utf-8?B?NnhQcnRjWWV0YXNiMitkeXFXdzZNNUgxWGJSVjRieHQ0OWU2eG01V2ZOKzM4?=
 =?utf-8?B?TEdFSCtiblBNT1QrSHpuNkh1V1htN1lmRWZEUzZqWTF0WXQySTZjOGh6MGhs?=
 =?utf-8?B?MmRBd0hBYUQwZ3BiOGM2ditOKzA2eWhwcCswNDFUQ1hVS0FjdGJiN2c4Q0JL?=
 =?utf-8?B?TDlFYldXcXpuaGdQZk5uNzcxS0NWUHBpVHNJYmFyVjJacHB2UVNKbk5pTjNW?=
 =?utf-8?B?NkRNNkFDQ3Zobi9xeTNMeTltZGYzODd0WFdCclEyZjR3ZzRHVmkvcUZYdzZx?=
 =?utf-8?B?Q2IrdnRFbTZ6aENsL0lUOVplTWt4MnE5VXVMYWs2ckptcm9PdWJXcXFNVnFm?=
 =?utf-8?B?azJzd3BPWjVRaHRnQkh6b0ZOZGlPZlNTZU5zL0VtWE1sQUFBc0RGNGJqSGUy?=
 =?utf-8?B?ZUs2VW8wN0lJbTNJZnMyYmNyQnJxUXU1WGNKaHRsV3lwQlpVTHpGTXIvakUw?=
 =?utf-8?B?d1hsMEdkZExNOG9TaGU5L0YrR2duWnBBK0NQNlIyaWRvNGprTTZYU2M2eTZC?=
 =?utf-8?Q?zk7k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZMMFQ0RDdyRXpaSU5HQTMyUkdocWRiWEZvdXdyb3V2aEc0RkxxbFYyMFRm?=
 =?utf-8?B?TWhIbDV4czJwMEZDVFUwRjd1K1BjUUlFRjI2SzRvdzJWU2dKakoxNTljeksy?=
 =?utf-8?B?V21EUDlHSGh3cWNZSjVsMTg4Y3ZzcjBLNlBwZnRMc1o1MGo1cExNT0lhUldP?=
 =?utf-8?B?UHREZ2FUM3VoUDVDa2E4OGtLeEw0U2lNc0gvY0hTM3hHWHZkVjdkT0NDbVdk?=
 =?utf-8?B?L29xT05sRnNhQ1hxRjM1WDRTVVd1Y1VNaW5MaGg0d1RCc0dSWFpnTndkYkkr?=
 =?utf-8?B?OGprYll5ZVRLTHVPaVpLK2drczFWUmNKTk5VUHQ2T2g4YVkycmJXU0tCa1ZT?=
 =?utf-8?B?c05LTStQalZaNFZOQ2duek1qMHJwUENNa0pNZkIwek55MnovSDA2VHJSZ0Ru?=
 =?utf-8?B?WXAwYTc2YzZETmRobHdQWTZUazZ6MytWaVBPTGowa1V2S1JzTlRZK090bGpU?=
 =?utf-8?B?dlY3ci9mSUEwVFh3djRTVHB4WEtqL2Z5QVhUWmhuUjJMZzQ4eHpEa1lkTEFM?=
 =?utf-8?B?My81ZGQ3N0Nmd3lFQVZUNXorNHlUaW8yUzFrMDB0T0RlcGJOR1pJU2JwaTRJ?=
 =?utf-8?B?WThtNWlqcmFNLzZSTURhTElwS3IzWVVkOXl5dTdaOHhmSGZRdDU4SWpnVXFM?=
 =?utf-8?B?VExrRXRMSFlGUkJjVlg2UHhoZ2E3TWgyZVlaeHU5cDFiY0ZPVmNtbFRGWjRq?=
 =?utf-8?B?NUtFYXBSTjJ4c1ZJUkkxb2ZJUkV0MlZJT0pEU3VjQ2FiZktEU1N4QzVJUFJK?=
 =?utf-8?B?cCt5ak1LM053VEY0NTFNN3JIZTRmZDd0Y2hXakdocW1qVWdsbHVpMS9PVDhv?=
 =?utf-8?B?UHREMXdtOFdReTdCc1c4OGhYMktiRzdIS3FsT1NzWlkyallQV2c1eXR0OHRJ?=
 =?utf-8?B?QWVMZDhHUW5SSjlvR2xqVG40TTNTWVB1L2ptZ3VxL21NaHlYVUVWTkFnelJB?=
 =?utf-8?B?OVF6N1h0VWlRZVgzRENKaHFFOThBN1hici96NTBoNE92cGt4Lzd0TzhOVlNy?=
 =?utf-8?B?R0hLQVlLeTRrVnFnYUJWN2llaXZNUWcyRm1BbVprU3FPc252NktHYlhRZURV?=
 =?utf-8?B?T0FTUVRQZWoxT1lSZWcxSndKNmttK3kxSlBuTFhKa0F0MEg4T3I5SzF5MW5q?=
 =?utf-8?B?NlhSeDZjdGFpbGl6SGFTaGZpc0NPOEJyaDU1dFZTQ2lxWHowN3hmcm5GY2Jm?=
 =?utf-8?B?Uis2MkFiQ2U3ZW9zMDg3aTB4WlQ5UWdVN0ZJQ2tiMmc2MTlNeXFJdzN4VkhX?=
 =?utf-8?B?eGZraTVxQlpzYlZuTXgydWVuR0tQbjhuSkVEQVJESVphS1d5R0NlZnhRYjc5?=
 =?utf-8?B?NEMrSUx2MmZqTnhFcG13UkRrbDU5NlpDYlc2TGxxamJMWUY2R2RaRGRJbUJN?=
 =?utf-8?B?ZnVHdGJDMUNsZkUyUHJGVi9FaFRvNGZ5Y2t0dk9KcGtTSFJPNVN2YklaOFh0?=
 =?utf-8?B?RFB0bFZ0YzNHeitzTjlVMk52aTZkKzZLWUs5Z0IxQTJmZEEwU2kxTm01T3Rs?=
 =?utf-8?B?UUI1bnlOQ3k0UEVOZERnMmw4QUhYQUdKby9JWXl0UlNDQ01iUXFKd1grUGZy?=
 =?utf-8?B?Tm0ybit4S2ZmcWFrTUhBdVFMK2JRR0xVTWJJTHlmbmtGWFViSDZraUhJMFJu?=
 =?utf-8?B?eE1JbWlvdnc5Ry91elVjTGhzUk05S3RHRW1mMHU2bytMcXl1RXk4OUVyWDFL?=
 =?utf-8?B?eHAxb01Ha3RxM3Z1alpXRW1MOXBmTko1VGE0SkZHb0tNN0ZjVk1ydFZLTXFV?=
 =?utf-8?B?M09HZ0ZYOWVzT01ZaW1zam1yMVlvV0pFSDNlb2FBYzlNalFySDZSczNmNWd6?=
 =?utf-8?B?NzNZZm1QWG5rbDFnT21YRlFpREdNdSsveC9EVy83anpGdTZ5WDZ5K2pTSnVq?=
 =?utf-8?B?RmhHZWk4NVRXNzl2TUE4dWFNUXFiNktocnlVaXFPQ0FNWng3T3dRZXlIZXdL?=
 =?utf-8?B?QmU3V2c3R2ZjMnBQT284ejJudUhRa1NUMWtnU09BUTZseitBaWxNMGxvOXc3?=
 =?utf-8?B?TStvMDJwb0FXTVZZYmhIZ3M2M3ZpbDBxZFphNDFCd2FUVTZJd014bXZ6UndK?=
 =?utf-8?B?VFJRQ0hiSXFMajFFb1RoNUhRNm1YaWIwb3JhRUphR2NkWXBJeDZ4cWt5R3NP?=
 =?utf-8?B?MGYxamJROWRwRmJvNnRDcDRpbTljWFUxMTdoZU9Na1ZOUnRJU1pFOGpNRmJo?=
 =?utf-8?B?VHBtU05veWFFUnJKNzM0YmJKZUxtanJXTjdvbHhDdHAwN1VWd3JqSW5KSHBp?=
 =?utf-8?B?c1ErOFZjbzZyMXpkbHB2ZE5YdkE1VTZPNmNVSVlxblpmNjBpQ1VMeDNqVEtj?=
 =?utf-8?B?VUM5cUVHdXhxb3FhL29wZ3liaXpncGxyc2lMTExML3NRK1Myd0twZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92975387-2efd-4315-c1d8-08de638e929b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 01:41:53.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBOLkfeQE9vQ5y9CZusTtl9MvGCTI7detv6tcuo9ohxPjgQWB4+u8sC2TgUyJXzwzvywwip7CMkauztuKLmOlzsquml+02IXpLMVUL5e0t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213332-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,vger.kernel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 53F3CE07E1
X-Rspamd-Action: no action



On 2/2/2026 11:39 AM, Harshitha Ramamurthy wrote:
> From: Debarghya Kundu <debarghyak@google.com>
> 
> The driver and the NIC share a region in memory for stats reporting.
> The NIC calculates its offset into this region based on the total size
> of the stats region and the size of the NIC's stats.
> 
> When the number of queues is changed, the driver's stats region is
> resized. If the queue count is increased, the NIC can write past
> the end of the allocated stats region, causing memory corruption.
> If the queue count is decreased, there is a gap between the driver
> and NIC stats, leading to incorrect stats reporting.
> 
> This change fixes the issue by allocating stats region with maximum
> size, and the offset calculation for NIC stats is changed to match
> with the calculation of the NIC.
> 
> Cc: stable@vger.kernel.org
> Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
> Signed-off-by: Debarghya Kundu <debarghyak@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

