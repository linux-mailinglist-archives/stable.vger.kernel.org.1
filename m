Return-Path: <stable+bounces-165530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B99B162FC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D6E18C80F7
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBEF2DA776;
	Wed, 30 Jul 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzLEW5z3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA672DA76B;
	Wed, 30 Jul 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886564; cv=fail; b=Ghk73L6/ErHPbGhFqLCkFldzyHW0TlSx5zSN3h1ytKlahA6OK43wyZ3ezt8Uw8ve5Fsv/sXkVUJRxMQTljJh6IPqr3kZR9iBWcjPVhDGarTU/dZkaDjbwEL2M3gQcstAbg2nczClzL1BZ5IXVhtW2+zR7Pf6kh30PjaPaAy2i38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886564; c=relaxed/simple;
	bh=HvdIHoYheZvLhIY8zC9VDt6KuSrcsZsyFIBued06AXM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHy0jqLuLnLPghpXKVkP9HEfbUk5Zaer01EjgzGw1sZNhIlH14t0WSj6Zv2Vm+GTANnXigZ8ogQ4frGVYji0u+NlOT+d0PmC//Iz+1QVz7f6c0qPtK6N6jOjw2gKt2+4L+DrzpgadFBCRTxqtgrjfNrqX1bvuvpQnFu04XbsYw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzLEW5z3; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753886563; x=1785422563;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HvdIHoYheZvLhIY8zC9VDt6KuSrcsZsyFIBued06AXM=;
  b=YzLEW5z3sJd6QcBDIQV3Sl2Ix9KjhOrF7g6bpz3Hoe+bc6u547vUIEgZ
   LQ9sUWjjJ6ZNA7AVxvSD/5P+zUvJLgOW7mRNzL7K24nKU8bB45ytdQvgE
   7xO9RkdO6CLipjB86n0lBtAilyZ21lTVTBW66KP/dbXXjuZhq4ym07be0
   JryWgkH4NphF4JkTNPqNZ40tbBsxx52S96Qay2U4nohjR6QE0Rdms//AY
   jwfGziFgnhodPTwEgx5+oouDN3gNfEHrp2MCmLufzEORHDg8M7Dokee0K
   6L1YZC20835MRRYWrhEb3dJgYwAI0VJJsbQzvB9M7MaHAMjLQFoLizkqK
   Q==;
X-CSE-ConnectionGUID: 3JNS5SxRQ1qpOL09RW3Djg==
X-CSE-MsgGUID: xfPbHQ1aTSym+u2GxGw1dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73778879"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73778879"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:42:42 -0700
X-CSE-ConnectionGUID: ir6Flr99RYKVT89uITWOaw==
X-CSE-MsgGUID: e5vyarXdQOew2Ljuu5C/cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="168301490"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:42:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 07:42:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 07:42:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 07:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBg0+Zaw+QWxOe5jDgssUvic4A4hpUn6kyBLO7FhFLjnyGiLy/YnhjysU/ZgMYpCb4mVkv4W7+kMa5wDdyxWtDU7INKCn0uQPZI+pMmhLTxwXF0zR0281jM3EAv/8hrZicPdP5IVVxP69uFZikB8GUeeJhk5xLO1SOhwp5/qGKzZgbVMmh248kFxaqR6BbA2EoLf2hKeycLYdsLYanPFv/SANikstFHatGwPE0i0Tfi7zf99ayEg918iCbDkHiRYVxmm3Hjx0rcvlRQyuj5r0fYXV47ZmcMgiJ9icdwemuoEfttmMAFS40xBi2TMA+eTUERsJgR/7nOGnH9eh72Dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jljZsXNXWEm95pECO1mwX4r4LUUd+Nqn84R+mQM1bLc=;
 b=xON5c92x5IcQu1dVe8XMgRBwMyI8xiMVzugpnsTKKa2Re1ymQ43Z6TWFFvjbKWSgxAzEVYNpSycvrLsiKc1bBMXT09vx/PyoU87K5kLp4O+sLFnD4y3D3XeDkk5HidOhm1q1nlxWqnB0sh9t0Jvw7M3iRljuPqqy6HGTGNiXqKGQxS5y8IKEI+UVsBeP5JtSVuTvUT8yerhOZ9YvEFNBsrWPbNHeYTrglnp1eMJKO5NCcWOsaCc6XrTrsauLT7dE6dGzlNTnogU6sT5Y6FZ4c9mnn9rR8qxLehLcisTL2FM2vUCs0jtoXF3+409Z0/rcIboe+lNgldIykX4e9v2ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 14:42:38 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 14:42:37 +0000
Message-ID: <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com>
Date: Wed, 30 Jul 2025 07:42:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
Content-Language: en-US
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <darwi@linutronix.de>, <peterz@infradead.org>,
	<ravi.bangoria@amd.com>
CC: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3dd5a0-fbb6-416a-2bbd-08ddcf775422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGRKOTJHOXRUa2d2Rm16eXlrTWlaQnhWSkRZKzhDaUNINklsREZmUmdMZ2tj?=
 =?utf-8?B?RTFEVVV5bVEvNE9sUmFlK2JHendKWUpPWmNvdWRxTTU5U0pYZUN3NHh0Z2ZS?=
 =?utf-8?B?KzhFdHo2NFlwcEdmSlJEMjIxdEVwaHpXVEQ5UmxSSGtOc1lJM3BxSDlNNUlI?=
 =?utf-8?B?OFUyMU9VOWRsd1V5ZWpFY1lRNHQ0Q0NNVm9CUSs4dTlmNXp3QU5PdG02MVRK?=
 =?utf-8?B?WGRLckdzSUg2RjJOYjZLeExVWjhSclM0QzhjR2tyU2dXcmhjMXZkRGhtWnpS?=
 =?utf-8?B?bVRFUVd2bnFEbHN3alZjQzdHdlBYdU1ZS2UrK09QWlVEMGpBejZwVE1BZHY1?=
 =?utf-8?B?aS95Z2h5WTVxemhMSWFLTnIydkpqRDVSRW16WUlDWVlMQVhzbmRZVThEN1Nj?=
 =?utf-8?B?QTRRVkdsUHhMUmtQUE1UVytYRHBCS1F0RWFFM1VYTkM1WmEzNEUraG9nUXlo?=
 =?utf-8?B?ZmptbkFzUkZJZmVNSXNXTmt1YU5WaXJHYy80WWdWN2tBa29GWFA0MGR1WVpk?=
 =?utf-8?B?VzBZNitRVnNvMTZYb0xpS3BraWZPV1JCNjViZ1QyYUdzZEpXaityQ0ZnR3VZ?=
 =?utf-8?B?dUJrbGVYc2hwcW5FdFVUcGY3Mm55ZG5KaHpCSUNWeUt6bEVKYTI0UlBxUGRL?=
 =?utf-8?B?ZnVlaDZ0eHRHV1NGRFNmbXRDbmlud2xQM3VITm1kT2dhMlRtOWxDR2NCMytC?=
 =?utf-8?B?dG5qN0l3U0oyZURUYmtrdW1LcEpzUm1TcG9EcUdheGdLbURLdU55LzhFMVk4?=
 =?utf-8?B?REEzcFdreFJvWXd1UHFlZkNtVHFZajFxUkJKTzZVdjdheTVPSTlFVXhZOFB5?=
 =?utf-8?B?TUJMb2hiaE5xS3dDTnh3dEZtcDNvSXJycFM1b2QyaXZaVE1iQkZNRnpjcXdw?=
 =?utf-8?B?SlV2aldsV2RJemdVNlZjR0U1SVE2bUo3ZkhHWktZT1dLeGs3anpaUVlST3dS?=
 =?utf-8?B?Qk02djJHcDVSWTJwZVJKYzhFdGR2ekVxUFBpM0s3Y0drRjhHSG1vZzlwcTZW?=
 =?utf-8?B?RlR1c1FNWFk1dGdwdmNXcmxDMUkzRFE2elBCbERFSzNrdlZGOWxwK1pCdGI4?=
 =?utf-8?B?TVlGU3UvR21ES3JSazQwS0xSbVlCQmI0MlE5UE9UT2NEMlJ4L1ZDM1dLRG1W?=
 =?utf-8?B?Qk1aY2ZPajl5S3dxUXl6MkxPUm82NmFWRWF1aHIxWXBnKzRmV0NvVzBMSWFx?=
 =?utf-8?B?dmVjNFhOazdPVTJRUi9Ya3lOTVdkKzdXQzFOMmIwNDQ4TEpRVkk0ZTJDWUFB?=
 =?utf-8?B?U3pESHdKblRuRTZiRXNWOStzMkdUVHRvd0dzZG4vTEk3c1k4Q2JBaTc1TEg5?=
 =?utf-8?B?eGR2SXlWUHdOblZaNlFpWkNHblY3VUtRRVh0RXJ0SEVVL01FeHcvVktWT3pE?=
 =?utf-8?B?UTlsNmUvZzBGamVyOWhMUFNQL1IvaHczQkN2aXdhY2dzcWordkx6a3hVd2cr?=
 =?utf-8?B?MEV3VUp2aDJlSzNDTlVuWGdHOCtHNExUQkVFRFZTdzdKQ01xNVVvUnF3OHhT?=
 =?utf-8?B?SnFKKzlRaGtQeFdBcEVsbHRsNnk0K3FyVW0zUVNpazdzTm91MTJQak1kNTMr?=
 =?utf-8?B?eHNScWZEY3NabXhuOW1YU29ab09FRGxnRkVKWG1ITXptYTlVb2pMaDYyaHpD?=
 =?utf-8?B?WnBJOXdYZFFNMzV6bnlqU1IyRlg2dXVtdUhsNG96a3ZjSUhOMjVFenhBNTU1?=
 =?utf-8?B?b3JGNDhkNnRyeFc4ZitHd3NUQ0VqWERoaVRSRk5ld0YrOVlURDBWbW14UHJp?=
 =?utf-8?B?bFBtRk1aakNlMlJXWG10MkM3L2U5ckhCM0ZTMjNxY1BrQ01tVWdJMWllQzF2?=
 =?utf-8?B?aFcrakJqNXZndFZRMldDTktTekNzelg5ZlhHWGVVdXNGdnMybGFDR2pEQnQx?=
 =?utf-8?B?K0tLTjNIaUZxRWYxcDJUUTRuZHQvU3dNSFc4bFJXdHgyVTZQYy94di9jQnl0?=
 =?utf-8?Q?c5Ne0o2+ml0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNMbndHV3R1T3R3b0FZNWtGSFlnakwxa2R5aURsMWNuRCtONm12ODFtWlBZ?=
 =?utf-8?B?YmwvT3RKRFV2TW9lMVVncFlRa09kUlBzY3JBeVp4cVdqQXY3RUtweUxWWTNM?=
 =?utf-8?B?aVZsa29qdHpCVnRqZXV3V0N4ZTNYK2xEQm8rNXREUDI2NzdJRjlOTnVNeVFO?=
 =?utf-8?B?UmJmUU93WklvKzR4YmxrK2tCazBHbmY3dHJMaHEyYmNtbDhZb2NzeWlBR2lU?=
 =?utf-8?B?VlBHNE43ZjRDT3J5cEI4Nnlyd2pBbEw5T3RlU0docmttQStheWVDOTdPK0VF?=
 =?utf-8?B?Smk2SmkrekI3TTJSYkZ1T1ZDdERoOE9qMnlwVFBmT0RPTnErZXBYdGZxRzRX?=
 =?utf-8?B?T1RVZnRua1pneWVkNVZHVEJoWWFNODJsVE83eVErN1grS3FwS0ZMNnZ5Z0ht?=
 =?utf-8?B?YzcwQURQYUIwMnZ2Ym9oR0YxRVA3R2RnQ3k4RWRCN1dleXJSNFNyYnZDR1pW?=
 =?utf-8?B?WXZFNWlUNkZOa2JXTzk5bUxIcFEyZjMyTjNnd1NxNGIwRnEwOSt4aHVkMXU5?=
 =?utf-8?B?a0VTTytjS0NZcmNJeHhkMTVoQUZkTER0NUtIVnpTb01PdDQyNXFWQXNvckt5?=
 =?utf-8?B?MUNGYXpIUm5JTW8rMk5DT2s5Y2NKdVhjcVlKMElBcDhhWllUQzZyWU9YVnd5?=
 =?utf-8?B?SEZkcUNabmt6b2FuRWxjUDZkZXNZSDQwQStDZ1J0WXcyMTRBK1VwWG1rN3dq?=
 =?utf-8?B?OEMyODRuTDBsTTlFT21EZTBoVFcwNnJGZGt4czZtK2FOTjN1L05rOGtsdGs0?=
 =?utf-8?B?SUY4bVJWVnVYbTF2eUdqaFdwcG9JSGdhTHZFU1lFM040ODV4UUh4V1NlMjh1?=
 =?utf-8?B?SThDZmthZzJhWDgrRTlMd1JjU05lTXI0aGhWcmE3SGVuNXNxUXdnUGxpTlJF?=
 =?utf-8?B?c0o4dGdWd0FwdDQ4WTllYzVjNS9GcVVpWkpRa09tTk92TGd3emhRYUR0ZVB1?=
 =?utf-8?B?SFdmVGw5LzkzUEVLRWpOeUVHWjUveGdHOGk5ZzcvZ1pSUDRIUnM4bU1uaHF1?=
 =?utf-8?B?VEZ6Q0lUQlg0eWtrUW9DN1Y0NDA2Qm9GamF6am51SzlTMXVHaElGYldkL25r?=
 =?utf-8?B?d3NydHk5ckh1QkczREc1QkI1bXpNZmVEdElkV1UzYmVjejZScFJNWVdSZVRy?=
 =?utf-8?B?ajZvUkROTVloU3RrSUVDOGlHYk9pZzFnR1hvRWhwdDZ2dGIvSElyU0Q3ZjZF?=
 =?utf-8?B?MGxaTWU2dmpkTCs1Ujdoemp2VG5DWmtGTHZnWW5IaThiNFF5UmJKYVp5TUZH?=
 =?utf-8?B?aWwvclFzY09XNDdycEVaUWZlTlhLWDY5MlU0VkdtaUd5cmV0blF6MHNpbXVR?=
 =?utf-8?B?dklkMGNvdDUzWmIrK1ByUHgyMWxIN2pGK2RNNC9YNmhWS2RsaFZ6MjU5ZGVF?=
 =?utf-8?B?UnJtd0NNRnBzT0xzbGRBS2tWNTA1aWMxeWsvWkIwWUFKc3dLcmJ1U240OC9o?=
 =?utf-8?B?S0JGZW1GM3oxdTl4NDRKN1pOSWd3ck1ibENSRFpvVTVHVkpPeW45T2x0RDRG?=
 =?utf-8?B?MXoxd1lod2VGVitlS015bmpya0c0ak9PZWhjU0trL1ZjN0lhVStUcXRtOGtY?=
 =?utf-8?B?UDl6ZUY1eHh5V2doeWIzR29SMThyUnNueEhRTDVieUtZTVAyS2g0Vm4yaENQ?=
 =?utf-8?B?dnc3UUZ5U2xTcEhDY1lXSHNQVTlYYmpMZWRWbUNzS0dyVXRLRkdjenBIenlU?=
 =?utf-8?B?bWloT1hmV3lqb1hHci9maTYwL25rYkY2bTlyWTE4c1h2aVFCSWFhV0R0WkRI?=
 =?utf-8?B?R0J0R1FESmZBOWMwem1kUUZOdjRDUUJmaERXWS9JaTFPUXlRQ0swUG5XTitz?=
 =?utf-8?B?ZUdqbldOR0EzYy9ydGNwa1g4ZnpwQk1sbzNwS20yZnQ1Z2JIY2lFd2hXVmtL?=
 =?utf-8?B?VFlUanh3alFiZGU5UDZpTGlMS0xQSkdqSXo0SHk2K2JmUjFWRWl1SkdnSWh6?=
 =?utf-8?B?aUhRQ0x2U2VBMjRmNlJhRkp0SFVZaDNYdjhyQzlGejRyN0pFalJFWUVWYzB0?=
 =?utf-8?B?VFJaUzFnNjgzcWlMUmtVeXRSMGZreHNJWlFvN2FaRVAwcTJBWlRoN1FhSllV?=
 =?utf-8?B?d2ZDeGNhTmlMbENqaDBlS1AwRVpLUWdBMld3RFUxdWVFYi9EZkVTMFJPZXQx?=
 =?utf-8?Q?y2DrTvCqaLKyEXrW1AQrfIaSo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3dd5a0-fbb6-416a-2bbd-08ddcf775422
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:42:37.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l4cgDASM1SYxyzbwOJRGv0wXiQlMlAs+JNAHT82MnndJdP0J16lEKsU/aYRdJyGOt5TTdbyY+jZKC3VAd/mqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5096
X-OriginatorOrg: intel.com

Hi Suchit,

The patch looks good to me except for a few nits below.

On 7/29/2025 9:26 PM, Suchit Karunakaran wrote:
> The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.

A blank line here would be useful to separate the two paragraphs.

> The error was introduced while replacing the x86_model check with a VFM
> one. The original check was as follows:

Maybe to make it more precise and avoid confusion.

The original check before the erroneous code was as follows:

>         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
>                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> 
> Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> Cedarmill (model 6) which is the last model released in Family 15.
> 
> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> 
> Cc: <stable@vger.kernel.org> # v6.15
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
(without the blank lines as Greg mentioned)

> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 076eaa41b8c8..6f5bd5dbc249 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	if (c->x86_power & (1 << 8)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +	} else if ((c->x86_vfm >=  INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||

The alignment here seems to have changed because the extra space after
INTEL_P4_PRESCOTT was moved before it. The current code has alignment
matched with the below line. It isn't a big deal, but keeps the code
easier to read.


>  		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>  		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>  	}



