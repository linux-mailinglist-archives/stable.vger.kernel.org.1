Return-Path: <stable+bounces-246809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGzlB1NcBGqiHQIAu9opvQ
	(envelope-from <stable+bounces-246809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:11:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A801A531F0D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C15A130164B7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192563FBEC2;
	Wed, 13 May 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7JCvY8O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768437C0E4;
	Wed, 13 May 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670657; cv=fail; b=jAORswvAhDoWuG4ylvxYFbcu87c+iCpAdHLm7JLpx7qcSr1U8q29oeU8R5xKIrfkOnAJRcmdY73TQF0MDoU8QrwnzoRvoIWmZ8WnFj3CjZa54El4QhUdVI/UfZwlad2J/pPxmbcS8URWjetmZ6wQ7uFm7c8UScCih0LqNCRit6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670657; c=relaxed/simple;
	bh=6MqlIsh4Uf52XTlehxbX6+QOPwB5qV6HIpgjTIyqVRY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aerB08Cx4EIdgGdUWDSCYZbwORk462JIbl6+YIGpVWQi0bFtiFffRTfbHCREMMj0fgo5YZlwCkzrNVyqK8h35hbMaaY09sqK8RTa51G4MQbdmCQ6HVpLgzolR6N2ZHxiN6+mMqfiC4/yBPdCqT77oeVzj5sMfEbHhdXYq4gQzPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7JCvY8O; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778670656; x=1810206656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6MqlIsh4Uf52XTlehxbX6+QOPwB5qV6HIpgjTIyqVRY=;
  b=b7JCvY8OCNKXm2ga3k0MJlydRxJdvNhVy592LE4mlY9aC6YZIHYRyA/U
   dvyhIHPvNCvZVsSMxVwUZU1J32HH47rjLWYsaxZLM2gKGZd4Js9F2hZdW
   rsmKCTI0ZRC4JEsCSk3yTD3cietfG7hTtZq3OJ78FNUZq0g9FopTL51HC
   HZbXlAyyRBRCIGzpRVZsrojBD0SQqKVSiIi1O19aaP7ln5k/OnxHr8oGM
   jgZOJZc/AI8FXRdVUr5sXzsl/FKDOEMFlgQV0jgCp4SynNbSWTrkM3gJf
   IaWGjkwNWRL4e/VPL+iGe+yS15sOwR5C00FQPrJxgj6qc1Rit/vA0gfyh
   Q==;
X-CSE-ConnectionGUID: 2eFx/OHlQdaNFv9pIrUIMQ==
X-CSE-MsgGUID: ptDy4xt/TfCxi+jrtJ3aPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79490143"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79490143"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:10:54 -0700
X-CSE-ConnectionGUID: pqHv6xxZT5+KPazc7n8HgQ==
X-CSE-MsgGUID: e1Few6CJSACwugmDmlEK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="237072285"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:10:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 04:10:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 04:10:44 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 04:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfN0FYQVPsGuqX4K7CVH+owMiknhqsIywqMpGgzwzJabS+qwUQRZ3auzBXm6cHg/k5mGXr4ByNCcVqNMrbt0oD2K2eFDkqpEXOtkjBKWMk2bJOcf+3lf66NmPon0rCP5Ut05/ay5/g0uq6JlSpPbtdaEu2FZqQhbSEcfQA2SXvMEXMqgoQvt6MKTfOXyN3srJmgr/5itbuE6B5megtdFIAhMmfPgMniE4FB/Uh28WlJWxNOD/5FjD3dRlwG+a+k8FV9Z259SNDARl6pNMwg7StSlsy/b1wAHJJcjmhOFtcPDqN2wiwHlQ36zdI12YAmM2Ov95s8wCRIYXrkH/ykoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwKt+0R5v+NplFFPNS4HLGvK2cmE2Hu2d674cUiQ9+4=;
 b=Tpebq3bS4Dv0xlTNFoxmFeIpGAUYxxmqDPhNrgnlNIoZFzd8nMY1KVB6Ec2J7o+UGT3yQW/Qjvd8ZVA3tsEIxSriOAnQyzBENlemj12V6w3vuRnQMCYX4IUmvg4M+fKNGJS8A5IDDVpJiFtGAnstf3gjIoccT1/btvu7ipaeVTj2Zjcv/jnKXbA6K4KswDVlLRi0a7mRBTb6XZQfkFcf98+wp6Nm5vypFcrvygF15Xi9juRC5vJz7P0HOyUbxFbVe8Bh7PfmentCYLGJQDaov97r4ApYzyD0gNINvueQRiI+JlYW9ZG2050eJWciGqlLuyAsmZLAAbLDNIBRxF8XMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH0PR11MB9775.namprd11.prod.outlook.com (2603:10b6:510:397::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 11:10:37 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:10:37 +0000
Message-ID: <e7ab3958-c894-4089-aeaa-d4eead234bc4@intel.com>
Date: Wed, 13 May 2026 13:10:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] iavf: validate num_vsis in
 VIRTCHNL_OP_GET_VF_RESOURCES response
To: Junrui Luo <moonafterrain@outlook.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Yuhao Jiang <danisjiang@gmail.com>,
	<stable@vger.kernel.org>
References: <SYBPR01MB7881AF11C45AEDC0D4CA89C1AF062@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <SYBPR01MB7881AF11C45AEDC0D4CA89C1AF062@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH0PR11MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 950c2b80-2ab4-4a26-b4ca-08deb0e04274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: GPzADn96BCE14gIj7mm1ZFuFX8FCNb7i9Q2SUHvGlNWDT3dyrTT5ZtY5M/EzkLwAPPt8zZsKxPDA2Rnhr2OdE4DT4MtMK8k/8zcuDjq/nLpdqDS4CeQ0T1GuL1faypKhM2HGu0QP5JW/rS+XPsdW3/kAm/CFJT9wTMLzeRrv3RiM+FwXsTyAUZSZ8ozLvmiOXgNByIRUvDIbvevT7bdIuIWOG1G8jBoiX5lX8N3pZ7XoMDdotCCJddxiM7B8Zz2jdvuPwKCZP2Io4dJEhqDXKy6FtWO9aovNkr5IhhtjSI1XvJPQf+JC8aZlzDSkKNRNwMPnxcEsy3lcKWy7gLH2NByXmWSzepR3zft3U+Upho0SzVUrZpq7YHNf8+C7kQR25pU8HjF8Ts76fkb9uJHl+8AkfWefqDkeDeU9EUGO3Q24CeDZ/Q3ChmRkEs0dO1lhBk2w4pB1cC+wVePHaeD5EV9MdXdo7TlBnRq78J6jTAOcmSdvpNTnRKFBJjSeJTs/veu3tlLlGOB5vYtvmhN1Pb4McnIdsaSuHpxMLZI07jdzCqs5GNZWtHq6aVHhSNM7O3lH7r3m2VHkLdxy438V4xfJY6a3drmmzbpvXuJXJyS6jJ1CBagVjYrzaEeSXpyex5SlWgjEOA7QG2Cq5Hpfk2pE1l8nlwRhwy5FlvPBmzqrw1pxGZjbGJEXHdhLLqsr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtnWUlGTzFmVDBsWEJvVjZNMlloSFQzaFpRQWN2aVllQ3N2cHluN0NMay9u?=
 =?utf-8?B?Y1NoRWtSdWFTeXRLQXhYQ1JQZWl2bnZ3VFBESWdtYTd6cmpzZWI5L1dHL016?=
 =?utf-8?B?Um9WMy9kcU9nTUpSY281Y0ZiSll5V2FuaVFXem1yd3pFVk8xNm50L250MXlq?=
 =?utf-8?B?bmlpR0hBUzE5ZnhUaFNPemJ4aXVSa291UWo3dnRpVjRKYldXZFdnbU04Z2Fv?=
 =?utf-8?B?ZnJwQnl4MEhXTzRMWHpjSWI0VEk4NjFFY05GckErZjB0QzdVc3ZFeU1USE94?=
 =?utf-8?B?cHBucklDRTdkMDJ3QkNNM0tKQ1lob3dkSVNmekFIVHZBT3RDVnRxN29Id1Rx?=
 =?utf-8?B?cjRLc0RPWnNzdUtVTFBlRkowcTI3UWJ3QjRVdzFBWjVpTUMzZm1jWTJ3ckJm?=
 =?utf-8?B?MFZKTDgwOHo4Q0tLeVdBZ0ZUNkNSeW9hUkJqNVZ5T3I4a0dGSzdmV2phUXRi?=
 =?utf-8?B?alpjc3B5MThrRHM5NXk4WWxReTdUMVdsdFFtYUNsZExKRDhUNDJnQWZaY1lh?=
 =?utf-8?B?RXNYTm41ekdpMWFTckZySXVDVkV6d2RrU3UybVNKejBBNUFHa2tnTE5TNG01?=
 =?utf-8?B?bFo5UExlN0NVb2h3b1NEL2VOdnRXeHhEMCs5MGJxVTRkRDlZRHZ5elExTkhj?=
 =?utf-8?B?SUhCYmRZSDlacHF0eVVtTC9YRnR1a3lMdHhXTlc2dW43V3E3TXBjOEw1eGJF?=
 =?utf-8?B?T3FZQ1ZGcXhUQy85a1E1VVdBNXZ2QjZJODBBVWYvZFAyR0xVZXdzSTFCdEwx?=
 =?utf-8?B?RFRHVGxYcW10U2wxNnNsRk1LWnJRbTREQWJhVGxKdE9SWmpYRnBMOW5XSFFr?=
 =?utf-8?B?dFNEUmV3Nm1haUVpYzE0Slc4QjZpSkdlTDM4T2ExZGs4bE9WV1dSR1RBV2d0?=
 =?utf-8?B?bi8wNldhbGs1N1RxVzFITFhwRW51RURDcFVxVHhHYThBcG5BYk5mVXdIQ3M3?=
 =?utf-8?B?MS9hTXV4M0VXMS81ZWVTSkdFUlI4bm82TGI5T2FId1BWOTJMQ2RlSEc2enln?=
 =?utf-8?B?MkNPb3lxTS9aTCsra2hvekl6UzBEa0pNeS9id295emRtMTRRNXpzQUxkZ09q?=
 =?utf-8?B?TFZzd2ZuUWphTmlMQjV3OFVzaUk1VXJKcDhsdkhTTytZS3BGbm4yVmFJS0Er?=
 =?utf-8?B?RVhYRHo4U3lSd05nYUtnejVnWmtrczhOQUo4Yk0ya29Vam5hRURDUHpIT3dX?=
 =?utf-8?B?bXdSZTlJNTJMRmtyT25ZdDJ3NlozbmE3N3dab0pQSE8xU3Y2UXdpTmVkWlRU?=
 =?utf-8?B?KzhzaUtKL0E3cDZicGpQaDhLNUFhc3NvSVo1RHJwZEZwS24ySE41bjhaYUVV?=
 =?utf-8?B?ZG5jS3A3N09RVjN6eXVIS2gxdXd0ZWd3Y2VDdVI0WGtnMDF0MWZ3VHNLNllW?=
 =?utf-8?B?N0lHVXYvVmNnYTlEdFk3Y0lJYXVFWHdJTnhmaE1mTjlxVC9OVmUrbS9rWkt2?=
 =?utf-8?B?ODYvd3hmODZzV1FOMlFxSFMyL1ZxTDdMZ2FweWw4WVlQL2wyK3lBREVYc1Qy?=
 =?utf-8?B?YktCcnorVkVKdFZQZHZyTlZDbWN3VUs1OG1VRjh2a0djS2NxcW9Zb3NsY3lJ?=
 =?utf-8?B?UUZpRkdiS1BiY2R4LzNvdW5TTWFTVk43MlRpUkd4WmNiOWdZaTgvVElJT3k1?=
 =?utf-8?B?dGxvRHBoT1pET0JjVWFwVmJKcXdhbWVraUxNTFhJQlp5MlZTRE5LRFlGMDJF?=
 =?utf-8?B?MU0wT3RsMDREUjMrNDRpbVlhWllUQ2hVNVBrN01KOUprQ256aTd5NmVlcUhv?=
 =?utf-8?B?UG1HbXpYZzRmT3o3L1dKZ3pNeEcvbnFPVDNLR3A5Q1U1T1BjTWovMmpKQlhD?=
 =?utf-8?B?RXlmaUJZb09ZLzE0RHVsYi81SVE3b0g3bDhYVmJ5SDlyajRRVnM1TUpDTWNU?=
 =?utf-8?B?QjdZU2NjUHI2N2QyQXpRK1NOUU1MNnFzdWxrMEEwZk02V3VZQzJoMm1takNw?=
 =?utf-8?B?S2pNeHFrbGpGSm1GRFlBcDNYTjhqSzdNSTlRVUY2OXg4SXF5RmYwOUtnTGVF?=
 =?utf-8?B?Q1d4Y2JvS2p1bnNZaGpVT1Yxdk1pKzNiakJpeTMvYytNakdlczdhM2JtTXBq?=
 =?utf-8?B?WjRQY0FhOUZCTk5pZWJaQTllTVYrVmxrQzdKaWh3U3JtVStXTlJvWmFKeXRN?=
 =?utf-8?B?STVDZXdoMDVKOG9KOWE2dWp4dnE0dVVYcEJFbG5Ud2FMN3lWa0NnS2ZJb3Zv?=
 =?utf-8?B?ZTlPcGliVHIxWnBiNVlHN0c2bWdDdEdCNGxYQ3NiRVRZSW1OdGhzL0VHZGxC?=
 =?utf-8?B?NXR2MmRNSFc3bHpBaUNIZmxqMmRiaDB4b25qd3RlSVlEYXVzdTRvMzJFWFVI?=
 =?utf-8?B?bHh5c1d0OXJOSFB2dm1zNUkrelY5ZzBBcG9VNkxLbFR6MzFOc1piV1ozY3Fx?=
 =?utf-8?Q?e+64VONkE5g+w/kA=3D?=
X-Exchange-RoutingPolicyChecked: ecUnagzHF3OBFRtfrlqsQw0R+Zd/Oct/nVLMo9XG9/KrhD2hfyWQWOKoJOkTSAZyDvAQwVKFDrcgbwFkVlltJQTftqqmN7nVvhSjQskjsyp3mYSwMvrNiaB3BMWNRyufgMjYrd09Q6U6pu+Jkz18Ol+FDVWUKnuPV/6kylh+1vdMuQQfG02en2z84nAZl9s7474Tgv1cjEYN9TeXjfvANU+HE/f3iKwbfTL9l5Wt665IcEwMHzZE3o5xieSx47B2EvKY2kIa9USBr/i6KRYLyWpXER+KCbXbUayT54Tr2V7uSCvURN171EW0MFtRuqrYrU655fimnjIcD3rGoNN4xQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 950c2b80-2ab4-4a26-b4ca-08deb0e04274
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:10:36.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9akN+9YkSq1Fy/cDNjL88/Rp4pNwfuWi7f92aM1ANwcGaptx2E5LW7jlu8/U9B+1AMrno8VFVY2sZXbCZHzkQomwPK4wGhHEGfD1111RdIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9775
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A801A531F0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246809-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/13/26 10:51, Junrui Luo wrote:
> The VF allocates a fixed-size buffer for IAVF_MAX_VF_VSI (3) VSI

this is the MAX that iavf sends to PF (and only usage of the variable)

> entries when processing a VIRTCHNL_OP_GET_VF_RESOURCES response from
> the PF. However, num_vsis from the PF response is used unchecked as
> the loop bound when iterating over vsi_res[] in multiple functions.
> 
> A PF sending num_vsis greater than IAVF_MAX_VF_VSI leads to
> out-of-bounds accesses on the vsi_res[] array.

this array is part of the same message from PF as the counter

Thank you for reaching out,
as is, this is not a fix
if you want to add some hardening for iavf receiving side,
you could add some checks that passed msg lengths cover whole
messages (when accounted for FAM)

> 
> Clamp num_vsis to IAVF_MAX_VF_VSI in iavf_validate_num_queues(),
> following the same pattern already used for num_queue_pairs.
> 
> Fixes: 5eae00c57f5e ("i40evf: main driver core")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index a52c100dcbc5..2ebfb65a6f3b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -254,6 +254,12 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
>    **/
>   static void iavf_validate_num_queues(struct iavf_adapter *adapter)
>   {
> +	if (adapter->vf_res->num_vsis > IAVF_MAX_VF_VSI) {
> +		dev_info(&adapter->pdev->dev, "Received %d VSIs, but can only have a max of %d\n",
> +			 adapter->vf_res->num_vsis, IAVF_MAX_VF_VSI);
> +		adapter->vf_res->num_vsis = IAVF_MAX_VF_VSI;
> +	}
> +
>   	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
>   		struct virtchnl_vsi_resource *vsi_res;
>   		int i;
> 
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260513-fixes-26ec29fa50a5
> 
> Best regards,


