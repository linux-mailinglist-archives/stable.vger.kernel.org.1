Return-Path: <stable+bounces-219690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPnbH75Cn2laZgQAu9opvQ
	(envelope-from <stable+bounces-219690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:43:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CE19C63F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA9673056E73
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC982F12A1;
	Wed, 25 Feb 2026 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OO1kNd8k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36805344040;
	Wed, 25 Feb 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044987; cv=fail; b=pJs9e71FaiADrrG0gvX6NgNXcLIfAhA+5UGmqBQ5ITSBHfV67Jst9vY1D1B0lzLHfuuadCa9GyU4AI8wixMly02Gokr0kGZQNAKGxC6lwH0HXNG0uyKP4RsRLG+8CkAjUokVrAVdUiE2Uth7m4q4ffwNqENlt8avgiVdszNAezU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044987; c=relaxed/simple;
	bh=3luG2oVwMApUp5casm9W2Wm8KORBhvQTDUSLvAI56Ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=St4GYecFc/eXuC7YurHdUbofbyGJRpfvZNk4/+V6JqcTxUKrVaIYN7E3Z1CTVzX0R0dRw2Ts2w+OE2vqOf+OxbhQ6yfmcin6xpMn20FMe+KM4gxlue5pTCx12/RpMheJzJq5pQs2+WHwUe0erwbOzA6xCHTrEtafcSZxHDWnfbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OO1kNd8k; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772044986; x=1803580986;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3luG2oVwMApUp5casm9W2Wm8KORBhvQTDUSLvAI56Ro=;
  b=OO1kNd8kj4WqfMDAR/IKIKufEbedBkYfqjmy/QRi34Jg+7+/5pC6OmUa
   YkCS1YO1R5zR+UcZIY8PQvkHEtaYuPSiwXJUTJGBXMSgI+y+EU4b3SbWo
   VzRPErIOIG2SyRrzcyCaRBJEr4b3e3PRucxuwa6yaIGvmMpu+d5IFhcAO
   i6w1rzPSJgz7P2atDrLLm0CyrsM4Q7HHu7SzKce/kX8097mbKUk4oE2qU
   vRIOyLKRJKgTN3Z1aomFTqP+w5GGeG90MdEq/+SVX0ABxw02YCajZu3xL
   2pwVF+5FkQ4Npno9BjhzQcJthSLIVNlUfvWuWwe0jBgGILkTl8h0AB8jv
   g==;
X-CSE-ConnectionGUID: pwHg2EDmTV+SSpRoneaEiA==
X-CSE-MsgGUID: PcSlQ9JbTpSlY7MsT04h3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="90676781"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="90676781"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 10:43:05 -0800
X-CSE-ConnectionGUID: bYShb2H+TrCAGRaXvH+a6w==
X-CSE-MsgGUID: /6+nmV+ESCelJQ+Ua9g+0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="215078564"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 10:43:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 10:43:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 10:43:04 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 10:43:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orarud7qLaedFUDz8hSMwYWLbXSlq47YAHkVm3C7owz8E79+RO6YWzQziUKFDkHpJQssdoul2X5o4biVkMcWZO5gp2GFUWymkGWqAXImI7mlpHY9PFPf0VEu7MNqiEGW7rGlE9cvdrmK5DwFqwD5c4mAKIea8hG/UEPvveO7/gI7PTuPQ567ZR4Loet+h38teF0/CEkdKaB0qZPfOiBataJV6moelkSedFUsCSKWWnqsf7ZfAnERJlVrAb0HAG1pQ/fAmmIIMPfniS0IC31OhrQjrxeNftj8X0aDEk6o8U8Y4eqzJlKrSaaXcm6SbAdqWsLKvt6eEC1t1OvJfVm0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZC2+i65ZskNGO7bz2Y4pKDZo/3lBAnjICShAJK8TkY=;
 b=ukBtzpKRFzN4rDYG4UjAZnAJiMsIgPMWeZAoiZVq4UMknUu1xnA/n3AOohBq2j35jozk+MY9u0vnR1whFiQ1gIl4fMSBCPV1+zCddSDsMQvHRxhf3KxGQZvk3mDIeK3BPj45g993eE01Naan7CS6DQ5Sa6xcXdP8FsejG7BL6JdQVT+jRjV2h8NomMUobqK0jnRYA1p0e9Z4xLwSr0/YdphnQtR1XknT9joJhcGSy1a8EsJ5pbON++itLDoNCacR6lbYm+yDawLwHHVSGIOd6emuj1spj5J4yrc2+NIiS2YmQN3O+Ot9lbP5TiyWB8SnuWACyb2ZqrgY/WJ88ruzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 18:42:56 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:42:56 +0000
Message-ID: <de1e751c-d8ef-400d-81fe-12f9b7dd5bee@intel.com>
Date: Wed, 25 Feb 2026 10:42:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net,13/13] e1000e: correct TIMINCA on ADP/TGP systems with wrong
 XTAL frequency
To: Jakub Kicinski <kuba@kernel.org>
CC: Simon Horman <horms@kernel.org>, <joshua.a.hay@intel.com>,
	<aaron.ma@canonical.com>, <przemyslaw.kitszel@intel.com>,
	<Samuel.salin@intel.com>, <jacob.e.keller@intel.com>,
	<pmenzel@molgen.mpg.de>, <sridhar.samudrala@intel.com>,
	<brett.creeley@amd.com>, <decot@google.com>, <david.m.ertman@intel.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <sreedevi.joshi@intel.com>,
	<rafal.romanowski@intel.com>, <en-wei.wu@canonical.com>,
	<dima.ruinskiy@intel.com>, <michal.kubiak@intel.com>, <tglx@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <avigailx.dahan@intel.com>,
	<davem@davemloft.net>, <aleksandr.loktionov@intel.com>,
	<edumazet@google.com>, <piotr.kwapulinski@intel.com>, <sx.rinitha@intel.com>,
	<emil.s.tantilov@intel.com>, <brianvv@google.com>,
	<vitaly.lifshits@intel.com>, <jedrzej.jagielski@intel.com>,
	<stable@vger.kernel.org>, <richardcochran@gmail.com>, <joe@dama.to>,
	<mschmidt@redhat.com>, <boolli@google.com>
References: <20260220004027.729384-14-anthony.l.nguyen@intel.com>
 <20260222162835.23954-1-horms@kernel.org>
 <842bb101-d73c-4470-a01e-f49f96847370@intel.com>
 <20260224161125.4dc744eb@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260224161125.4dc744eb@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc79754-48f1-4a9a-5ca4-08de749db0d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 79S5pNhSp3+HlT1+QP4lHScj8c3v9LxzKPGT8AazrHwhcRnmylebTqmPwSScd2p8hPtDLw2tkiPGp7qoq4VNNmJ/2nKBr7oNcEHrcC3d1XpSGVe9C4vcThwRMbPX9XNXnTXq8TstiW8x9MIBI8D/eXZ6vYiTXMRJQ1165wnzK5OJT2WYFkf0woeoXF4MyKLWC7eM+O6ioCTazGG95EaLfCNWb1odI5ykM3g0UFHyjqNo/ypypyF+PQAWPqOFWmAjO0jp/2s5MmHbQ6AkJFi4jJG/mYRcen1nZtiN5p5lW9CUqrf+9GSbIqvgGEHZLlWGTGOnpGaEggbuQ4BWcZu4N3/h14bGf/5ny7WCI73OvMudnLAjyFhR0ushNdBSND810VXCIiBvRKEqr9jmt+KD9BMmd/WNtGSJsMAUqxvxyEnFgJhCujcOpbjxs0xBTqMTnvaKH0a8E2vhZSixZCnZbK4HrzwLFY4PaU41GXYK7P2DJWprF1CcFD73qF8qMnPzjvFk6AuItGl+pKUeslz3zIf/UzUoJbtOhcGYneHhhcyNxTPElfLq6VHyt1RZqrwdZpVQKBR9Yl5s1xE9+rrGBfUyH/s+VUTbep8O44HlFfVlU8xdC0N6ht24mrbLIMUpzQTtEXuUUzm8OujtdPXSo5s7icQ3dBkXDLqhvJPh7tccnBWdkaw/NezVq2OeEeJT/zgbpPdvrVOUHBOREjBtW88r1hoG6bsZytgNoRT6+M8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZPcXdiRFpwOFA0ZzV0UGREZnFUaVM5UkFGQkNhclp1OXJpMmZod2g2cWlr?=
 =?utf-8?B?UFRGR0NKM253VStxVTRXZ095ajFhaXJTVnFUUUoyTlgyZHRZRk40UzBuYk9J?=
 =?utf-8?B?aSttU3Q5SnlNcWVJTTVIbEwyMGo0cFlYdjg1dVpSQm5XVEtnMTdES1pSbGY1?=
 =?utf-8?B?VXA5elBTdTJ5WVN3TkNqRWVQYzdMMXBhL1QzVkg1YWhxVEJKaXNkTHlYZUFY?=
 =?utf-8?B?eEZvd01iNmR0eEJ0eE1CY2dEQjJlK3BTSXQ0MlhYU3pzcVlweVIxUGxZbXU4?=
 =?utf-8?B?VUlxZWpxdlJPNGZQSDNadEFJaDJhTlZrRGRYUTR3VjYwVzFhZjZ5TmVweWQz?=
 =?utf-8?B?eUNLZjJGaFRPaHRHUmtLOEJ4anQ2VHFHTlVVTytBU1ppZDZNRTdnU0cvMUt5?=
 =?utf-8?B?bGcrWjQxYlhWZEk3RWV2eG02N2doVlZOOTZIQThkZE1GSndtQ29oT2FQSEMv?=
 =?utf-8?B?aWxMQkdQalB0V25DcmNEZ1NmSXJJa0xMV3hVYlFRQVQyNFNYK05aN0RRRmdV?=
 =?utf-8?B?NngzWUhHUU9YU0hCODQ2T1IzQnArRUxwT3JnRUw0UlZVWWxxVmlacERSM1Bt?=
 =?utf-8?B?K2tPbGhoYWdORWVscW1HWUpmRmFGWDFhR1JoWkxhMG9vOHZqYVBTb25jNWlz?=
 =?utf-8?B?V01lZUdETnF6OW5QTVFSdlVjZ0VZbldrS1R2UlF0VXovUDdHbWE5S1kvZTZB?=
 =?utf-8?B?VDlBaE0zc1JUQVgvbkRUeWVnaGRTZlJqS0QrRkFTZEN5ajNFdXpIQVVsQ2xZ?=
 =?utf-8?B?VVNweldPeWc3QVVKd3ZXbXNpekYvWGthVmNPVThHQ0VjeTNOblBvV2Ric2Mv?=
 =?utf-8?B?dU5aTjRYNUxqNHdLS0ppbXA5b2pyZlMvK1RTY1VVVFE1TFhaa1ZSaFRCZSt3?=
 =?utf-8?B?QXBWRzBJbDRnOGZTL1M3RnFORUNtRFk4T09ueWVrZDBqWFdOYTd2c2c4WlNa?=
 =?utf-8?B?ZjV4OFA3RDJEbXhUbWZpK3R1WHN0aUFrRWJ4SG9aMXdEc1RjZVkvWVgzZTAv?=
 =?utf-8?B?SmNFdzMxamVtVlRvTjd5bU01a0xEaG1nY3lkaDFzaFhyV0RyV0ZvclJBb202?=
 =?utf-8?B?Y3ZnamwwaEc1cjhwMkVnNGJCRnpFazRjZElaRk5ZUEh6QmNFUkdidHg2cm1E?=
 =?utf-8?B?V1lUcFhTU1R5MWMxRnp4VUhjdjBiRzNkUGFMWlJJUGgrRng2V3hhWm1YczBo?=
 =?utf-8?B?bUMzQXNSZW83Q2xJTm1LbHBjM1pXNlo0aVk3cmdTdWd2dzQwaU1EamI3WmF2?=
 =?utf-8?B?dG91ZS8wTy9FSjJPdzI4aFVHZHUrRnBsTzFleGxybHhHWnRNc2Z3OExjTkla?=
 =?utf-8?B?czFUV1o2M2RuWmpVM2RabnZBenQ2V1VMRnhMYTBMaEVPNnJRd1VRSlcxMU1l?=
 =?utf-8?B?b25vU2l3QkN5ZDMxdStIVEc4WGU3YmpSZXNheXFPVlVlY2d6MzB1cDlSTVR6?=
 =?utf-8?B?N3FpYVlBSnd1U2lOUk5zZ2ZEL0ZiUStjRzVhY0dUWkJRbzd3dGpmYm83SG1M?=
 =?utf-8?B?U1JTYU05NEwxSkw4bWZGZEFKeTQrM3NrcWY5aXBKa1k5QStibW9OeHZpMmRX?=
 =?utf-8?B?bWl4QlVCWUEwMHhlbzdrYmVKczBweGErMFh4VDh5aW5TS1FjdFJRYzg3K21i?=
 =?utf-8?B?SElpODRHY1ZPMEliVXBjZDdJWkIvTkxHWGpHckNCRzVUNFhtMDR0eUlHTS90?=
 =?utf-8?B?R2F2cHY3VE9KNGZtc0U4YnRxRC93c0JMcG5FK3FFNldxVU1HbU5JNlZmQkUy?=
 =?utf-8?B?NWdESklGUjJQU3pQVjZXMGFUUUN0MXExSG5Wd0FZR2J4MU9Cd3hnMlloZTYx?=
 =?utf-8?B?TGQ1UE9LZW9haUlsQk1HaU96cTRNREZ2bUZrRmxpZ0FmRHRaUElGVEt4cGZU?=
 =?utf-8?B?TjFaMytsaWgxbG95bVRHS1dLRU9XZTVTeWdTRUlCT3lGRzdOeXlobHRkTElD?=
 =?utf-8?B?cHZpOTBxcWdvR2pxc0dEdDhnK2s1QmJjOEJJRndQc1dzcWlOYjhIR3FsQnM0?=
 =?utf-8?B?MTJvWDBZSzhuK1VVVCthM0pSbTNiaWpaZCtqL0dWUkxXSEVGaFNZZmJCMTB1?=
 =?utf-8?B?akdVZzZab1lmYkYyZ0wyTzJ3M3NrMVhpWHZBblFubm9vdFdmRW1XS09Delhz?=
 =?utf-8?B?UUwraVlxaHJqdHpzam4vUkREUWFwSXlzdy91WjB5Lzl3d0pWKzZkN1dDaldx?=
 =?utf-8?B?d3R1QnRBWFFKc1VCQzZudlJLeldKUGdtS0JMVGxPaTBmdm92c3ErWTllQUFF?=
 =?utf-8?B?dzhnT2ZqdVlobzFkRGVJa1FGZmdZckFvMFNrVHJoMXNxSE9mTStHV1F1STg0?=
 =?utf-8?B?bGVJemg4ZUxTWGNXczJxUUZ1Z3E1WEVXckcvbUF1NHcxeWJxV0VKT1NENDdX?=
 =?utf-8?Q?khB/3jbQGfP8QXhg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc79754-48f1-4a9a-5ca4-08de749db0d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:42:56.1287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk3RKQjdenjEBrDsYbAoFcaFSfT9I254YOJltWZwxjmEQYNYc4tpGAKH/dyyt4GZknCbAXCnPqq9C/UiBgoeXW17qh79SXa5eqN9BMqkgvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219690-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,canonical.com,molgen.mpg.de,amd.com,google.com,lunn.ch,vger.kernel.org,lists.osuosl.org,redhat.com,davemloft.net,gmail.com,dama.to];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F28CE19C63F
X-Rspamd-Action: no action



On 2/24/2026 4:11 PM, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 14:59:36 -0800 Tony Nguyen wrote:
>> Yea, looks like we need to do some adjustments here. Also, the AI review
>> I just ran on this is reporting another issue that we'll need to look
>> into. I'm going to drop this one from the series to not hold the others
>> up on this.
> 
> I'd sometimes apply series partially for y'all but FWIW the idpf
> "defensive programming instead of proper rollback" patches really
> don't make me want to interact with this series more than I have to.
> You don't have to rework them. Just expect some delays, I guess.

Hi Jakub,

Yea, when we reviewed them, we tried to come up with a solution to 
suggest that wouldn't need the added checks but couldn't come up with 
anything that wouldn't require large amounts of changes/refactoring. 
I'll send out a new version without this last patch 😐

Thanks,
Tony

