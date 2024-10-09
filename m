Return-Path: <stable+bounces-83243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E6996FC9
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8509B1F238A3
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265D1A255A;
	Wed,  9 Oct 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dqs96+G/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9019DF6A;
	Wed,  9 Oct 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487601; cv=fail; b=hdQsBs2UtzR1N1H3ovANR65HNefPR8ys38Hn3Lj8bzIRDK7scFhMWmRqU8JaKxLhIW95oD801jZ6DsZghDgi4o/oW2LUcuMqij0y2vFbrpkJduXi7napX6HOQUm1usqpP6yEE/R6irx11P3ZvhGZ1zzBrRCknQDrzqoN4m6c6p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487601; c=relaxed/simple;
	bh=qg4YU/1vVRfoRuMQZeFii5puEv8/TsEcSnv+za23D+M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OluzeLOc4+vnTTiwMPoAxagn2uAUuX5WTFv1zScMDnxB5Rrw+jQ1TKAVq/bI+rsi5Cdi6JYHG9KrWkZrp9MTo1YhPvs04tFwBrd/M0hZFX8TRNeEEQlPQ7tUIGIT8qsFZIWo7YetpSfnRye16Kk9Uz4YSCllaYgpis8JCoqgT70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dqs96+G/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487600; x=1760023600;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qg4YU/1vVRfoRuMQZeFii5puEv8/TsEcSnv+za23D+M=;
  b=Dqs96+G/wd4l5xgI+LTSpd/c/W4jxejkUW3qRMqniO0dOjCBFwzD1PiY
   lsv35bVpxNj306JijRlQaz7mFpU4KzfBSzDfYhGyJmFqJSLG0Mb+m2SmP
   2E++ehvtPGV+WjWGq99tbZ5k2H87+E/9Hkl7fvQFI3hoGqEeKit5tOU3S
   ltcrtrAcIeLI/4aEFvG+Ks7x04zOFfSRqk68dn/JogSwV+L8D9mi11pCX
   bQSaWqo5IqpgEbYW2A2EHIdFgdCk6MO/gQ6U4nuBGMTAr2jLKuBnYLQQZ
   dRV3F0kv18XZBb80J7ADzaUyV6tUqNp/Ea/BnxCI6aLmMrsLL1++87fXo
   Q==;
X-CSE-ConnectionGUID: mPIOK9eUTu6a5LVbGjaIyw==
X-CSE-MsgGUID: /+nWllhgQuCAoZIpbjdsvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27275056"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27275056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:26:32 -0700
X-CSE-ConnectionGUID: PCq6IG0nTGyo1Mkbqzw4rQ==
X-CSE-MsgGUID: zUGiSYObTFGCWXeodQsZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76749848"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 08:26:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 08:26:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 08:26:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 08:26:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUcNiCh+rcn3FOXhYjFYBwYDJeFshqHU0dow8SMCnz3c3QmdXg+73COi76NbTmTcxNj/r69eHMW6aPZqCSmLc5iBIYZ4ygoFCOn0GKVGT78EIWNtAegWNyijX8Io1eF07o1wxE+rne5AXMMx/b/jXUvv8Il6pfApJj5UVDbfKsdaOHEAN2qJxp5qCHtL7e7Ouq8golSL6zDWve+Uiyst5uLBK3qftOMaBHHoaJhePcJK1MEitZuJgWA0N6GUCf3akM4uefB3hrof7zDA6apicn+j912232wXnc3dNBq7AxtU8u3+bfwi4ikjH7vetJI1hDUT+bOEvRfGJe04rWynqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVdjRuV3d1RhvIzbVBM4+RF9NNM4TFBQAW1SRy9LqoM=;
 b=N+rFFV0HUNEqdrK4MRlsujtmn81Q7buXX8i7VvH29eXJeFrbSSqlEuiszntRZbvslZ5KRFwYZVDky1+uXSKbz8Z9LiavcaylGno1DNxaEO3+Z2ZrWTCMZZ1PU1IZ9nAhqj6Ih3EgaFb7J7Hnu7sNjJjAhZ13T2mOxlOj7kZdCIS7ZKraMQMAjRNCwyCeHUttdNYiB9U/72c10GpWXydDrxEk+UPOXOgWgZYC6NRaZGFuDId1lPg4bhJtHIzyPUEB3tYOsxHpI0uxdgR9eXKi+6Pp6Q0+P+sjefS5bRw5ZdzeiGNJzMcxr4aIpCulL4TnOqc0xMQ2tlFHy+Df0r/Fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 9 Oct
 2024 15:26:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 15:26:24 +0000
Message-ID: <40f59adc-9d1e-4466-917a-69f3c8d77b5f@intel.com>
Date: Wed, 9 Oct 2024 17:26:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware/psci: fix missing '%u' format literal in
 kthread_create_on_cpu()
To: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>
CC: Kevin Brodsky <kevin.brodsky@arm.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, kernel test robot
	<lkp@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240930154433.521715-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240930154433.521715-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0021.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c98830f-fe01-490b-a9bf-08dce876bc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnpJZFJLYWZBUFZadzg1UzB0SUw5SWNTMnM4WmtlRzFOQWhWc1dmQ01vMzdn?=
 =?utf-8?B?ZWJncU85elUyWnRrekdQcDBleXNRWEVlaTl2SVVQTU53cUQxRHBLNHVOeDZ0?=
 =?utf-8?B?MTRvcnNOdWNwMElWSk1UN2ZEV01La1JHY1l4dWhTWWtCUzZsQjJoVG80cUd6?=
 =?utf-8?B?cHdBbG1Qa1hEdDB0QmhTMjFkM1FIaktVWE9hdVdVdUVSRGRCaTFEaVZOaHpQ?=
 =?utf-8?B?UFZhWm9pTFpiaUpuOC9DMHBRNkdCT0hLeXIydlo1ZTNKajR1eTYrSHY1S2ts?=
 =?utf-8?B?R0orUStGTGlhaHFBb1c3WTBkbUpQVUdLY3BPYnU0WExiU1psbVVKbkRES2NP?=
 =?utf-8?B?cWVveHlTbzZscFNscWhGTkt4amZJK2ZscVREcFQ3U2d6RDc4MkRMZVNMV3ps?=
 =?utf-8?B?Lzl2SXdzTHl6MnVWbXVpNlA5bWRUckJyOVQvZmZCR2RYUHpQUENVK3RVdmJV?=
 =?utf-8?B?aVhhZmdNaUhWK3g0V1hjQmlaV3RCWTRaNS9PdEZWakIxWU5xTGNjZFdvaTlZ?=
 =?utf-8?B?WHNhckdNcVNrZ3MwWmdNT0NsZWhlUDVuZkt2UExkcjlOeXh4dzI5aUFuM2dE?=
 =?utf-8?B?RzFxNlFnbEp1aTFMaGhEamEvdHNhbHZQOTFWOER5WDdibWFSQlZIcjhmSHJx?=
 =?utf-8?B?UzMvdnpLV3gzYmluOFJHcE01eVlIcks1dEdZZVl4VWprekZiMW0wWG5DbmQ2?=
 =?utf-8?B?ZXZETDdZWHVXU2RIVktYazRVNnFQUm1EdDdnY1hhQ0ZNQkFWa3F6Tmd0c0V6?=
 =?utf-8?B?K3d6bkVxaHlzdzJ6N2dTTUV0emV0b2xJVVhkY2JGSGRaaGc5cy9iZXVXRUFt?=
 =?utf-8?B?T0NWZ3lTQ0M3aUNMemMwK2p5SWtYSFgvV3VMeUM4c0JZUnNTcjRDUWFDTDFy?=
 =?utf-8?B?WVd5aDJ1eEdhN1hhQnpPUE1VZHIwU3JZTktTVWloNW5xdmJIbUUzNzljOTBm?=
 =?utf-8?B?aHZpRDczV0U3Ykx1bEg1OE0wbTFxUExuREhRc09YYWU5bE01cVVmZ3RGeVAv?=
 =?utf-8?B?UjEraTFQSlYwdVhGcElubUZQTXFuVHlRS0djdUxIUGhMcWw0T2JQTDJjTzZF?=
 =?utf-8?B?WGtuTXZKV0d6RFl5Z1haZHV6VkZYV2NKL0FTcFR5QjZMRE5YOXN0SmZXaUhw?=
 =?utf-8?B?YTNrb2kybVBTYUNZNmdzQW4yS0VQWko3cEpCdEIzWFR0Qjg1OVZBMTdaT29I?=
 =?utf-8?B?WEFkM1JsT0E4MUJpRm9xSi96REtOVHU2RmRvRDZTem9CY05JU0w1RWZKcklV?=
 =?utf-8?B?Y3lnNVBacEpDYVdsVGp5LzRlKzVubnl4M0VpeEF3MnpiQUh2VmJCbWhyVWFY?=
 =?utf-8?B?L1NlWGRLcUFzWTNiRVdPcWx2TXRVVXRTdjZBRCtNYWVlVEpDOVRoTXR3TVE5?=
 =?utf-8?B?ZFRDOFg2TGxnbjFSSlZ6VVp2d3VVc3U2b1BZZm8vbVI1eURKUzhQaXZzeC94?=
 =?utf-8?B?NGV4RVdYUkRRSWxLQWd1NUdENGpwWlBrY1luR01wUW5lNUt5V3JCRFB5dWpP?=
 =?utf-8?B?ZzNlbGloQnU0UHBwK2pBNTQzV3pEbVVkSU5Xc3N3UUJlMkZENGQ3VmowODNp?=
 =?utf-8?B?QS9oNW96cFBlRGRmK24wNkNTQ0hObHdZamgwdlFCVHhvbXA2MDZ5TnlvQTkz?=
 =?utf-8?B?NGhUN25qQWF6cnFxRlcydVplR210NndoWGs5WGM0bTdHZFlmZzRhZVhHREVF?=
 =?utf-8?B?cmxOaTZJclFRb1loNjJsU0pGeWJSazJGR1RPYXRVUGFjR3oxcVQ3ZmNJYXhO?=
 =?utf-8?Q?adsQUAftKnKmMM6OiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDd5bk9JT1VyQ0ZkZTN5V2ZpYW8yQ3VYUG8wUk1UTzlQVFV2YnlkTDRuODJD?=
 =?utf-8?B?MnE0T0srMkZIbzViZXFjNXEyK0FlclcvdktsTHpDeHF5RFJxT2FhR1JnbFZK?=
 =?utf-8?B?c2UyeUZlcDlGZlc3S2pDVE5OOXhUSTZnczVhRmlwaURtUlV3M1pONFlvcjRX?=
 =?utf-8?B?L1drVW5DRjU1SkphMXBvU1k3VjZCUHNncmtJNzlNQzlBVE5FL2JuNFRGQ2RQ?=
 =?utf-8?B?K01LQWttQUxzTUVrZXVScXUrWGFDSWFtaW1BSGFlYm9vcDlaaWxFa2ZJYklw?=
 =?utf-8?B?OGdKRFh6NU1iVWZuNmhjTTdONmJRYWp5WVpyNGU4cnEvR2dOMXcvdlhqakhV?=
 =?utf-8?B?ak5HMUVnWlUvbzJWMjNEemxoMWp5M3RhMjdZaVdlN3RmaElmay85Y0JiWjBu?=
 =?utf-8?B?cFFQY1BYclYzSWZuS0l3SGFoc2Q3OU1kVDZTUlV1aUpGbkNUbFNqclRoUWND?=
 =?utf-8?B?UGl4MFVCeVpVN1NqYmpKZ3VRSlYxT1VHa0libzY5bHMxSlhoM3hRVk1ZMzhy?=
 =?utf-8?B?N0pCaWJWME55R0hQRzkrOUJuNXR3bmdaRkx5RzlMWmE3QkpKKzBKcTZrNStK?=
 =?utf-8?B?ZjZ5VkhwRGNkVnNtWUcybUZHSUpmYVhDWHJCdzg5MU5FNHFSUE9GRmlBYW1i?=
 =?utf-8?B?elA1cjVSemdsdHh4OVQyZENLZ1Zyc1FaVVFEb2JPNlF0Z3FWMURmTVU4NVV2?=
 =?utf-8?B?VE5yc3ZHclpwMmkwc3BSa3k1b29CanZNRUNLOW4renNWSmR6cDZXeXFsVE50?=
 =?utf-8?B?aDJick9rQ3JMMkpTL1B6TkVJNnVZSlBWWjZPVE5Yd0VsS1c2RVMwbFZrcWVW?=
 =?utf-8?B?Z1IwNlA4T0JLNVZkUmVEUy9jZkU2SGY4TEI3ZHFSTHNMR3lreHJWY3pGRkwy?=
 =?utf-8?B?TWtlMHZMNi8zNUVQWDljci8xbDA5V1NQUTQ4OHlTVzdqK0hTL3lWTFhGQk5h?=
 =?utf-8?B?OCtLVm15bjkzNXhLY1lLRWFJSDVibnBza0J1TWJlZ1kwN3VtaVIvRUg5K1Rj?=
 =?utf-8?B?azZTTzl4RkFub2FnOW9oVlJIdWVWWG92TzVyczJPRWkrdmQzV0JBVnVMSWo3?=
 =?utf-8?B?cXlNUC9jajQ1eFM2dWk4Q1FIb21BTy9HUXc5cXlxQ0tCTkpkeXdETlNGUmhr?=
 =?utf-8?B?OEloK0hOeGFERkRMSVJUc1A5SnlnWFJyOVkrdjVKWW5mS1RsN202YXFKMXBs?=
 =?utf-8?B?cVZ1Sml3UHYxZ2dkOWxtRmJ0VVU0L01YR2E0bUMyZFRaZXNaaEttZUF0Rnk4?=
 =?utf-8?B?RUJMZGhWNjk0ZnRnRVNRVnZtUHBmbDJhT3pyQ0djZDNUWllnSFJSaGZ1Wk9a?=
 =?utf-8?B?TDFsaWlUMDZkRzhCVXdPS2d2ZFVoTEdTZ1luS0Zhd2J4aHJwL09GRE5JMVdm?=
 =?utf-8?B?aEh4QWJjU3cxcTNwaVZpSzdsc3RrZUNVdWgrNHRtTkJ1R3JLalBmbmJnWXBs?=
 =?utf-8?B?WUo1RnJ6RUhYcmdTQzZEY1VTMXA3V0NaUnhHcU5mNlFWQUZMRXJxdnNRc28r?=
 =?utf-8?B?TEpBL2R1YTVSWHVPUzAySGdnRjZZV25zRjcxMnZnd0lvZHRkMWpsRlNRMUQw?=
 =?utf-8?B?MEJzNWovQm83QVhXS1MyZ3I3eEhUejhGNUk1Y0NVckpYb1NiZHZmMDNPYTNN?=
 =?utf-8?B?N0lVK0J3RHhTTGtQeHNPUWxpWktlUngvczFWWVgyRytraVdubDZQREdyZFN2?=
 =?utf-8?B?RVRzckxOb0xHQVBPa3V0ODRVVjlidnZIeDV0NVdIM0ljcXBqVDN6aGpZQ1Nq?=
 =?utf-8?B?SmRqS3lIZkdZOFg1SWRoYkUraGlnYUtWNCt1bGlPeUdjdGtFNmZ0c3lxdE1T?=
 =?utf-8?B?K2NDRFppY011WTBpeFpqRlV0V0FDdWxsUk8wQk9xUkltcitJYnU5S216WlNl?=
 =?utf-8?B?cW9VRmZMcGxTdUZqS2lGY0pPL01ZOEx1NmQxTFlHL21hdWtNMk0zK3Q2T2lo?=
 =?utf-8?B?VS9SODlqZkQzMUZWVW4zODZwYm5aVDBHVEo1eThJR3lPVktPdnZoYWhQd3BC?=
 =?utf-8?B?WlJDZVJ1KzA3ZWJLZDIyeS9icXdIWnRuTEtqdFFBSmQ3L01aaEc2TEdadm9x?=
 =?utf-8?B?RG01UEd0Tm9PdytuNnpwaENNNW0wVEkyR1k5ZEp1ZnlnRXRxRjEwMCt0N0Vq?=
 =?utf-8?B?YXZXM3dDY3VNTU5BMzVzTDBpaEYyMTVjWHU2RjZkZnVBaGtjaGtRbktlM2FW?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c98830f-fe01-490b-a9bf-08dce876bc16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 15:26:24.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM29crfcEgW5d9rCW8gqeSWp/sIxqyJKcVIKvroZAw7PCAYpV94sxh6gyy5AB/IxBrqSOR3NbKjvodcbJSeLww8ZRYG04PCqmyOv+xXRaPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Mon, 30 Sep 2024 17:44:33 +0200

> kthread_create_on_cpu() always requires format string to contain one
> '%u' at the end, as it automatically adds the CPU ID when passing it
> to kthread_create_on_node(). The former isn't marked as __printf()
> as it's not printf-like itself, which effectively hides this from
> the compiler.
> If you convert this function to printf-like, you'll see the following:
> 
> In file included from drivers/firmware/psci/psci_checker.c:15:
> drivers/firmware/psci/psci_checker.c: In function 'suspend_tests':
> drivers/firmware/psci/psci_checker.c:401:48: warning: too many arguments for format [-Wformat-extra-args]
>      401 |                                                "psci_suspend_test");
>          |                                                ^~~~~~~~~~~~~~~~~~~
> drivers/firmware/psci/psci_checker.c:400:32: warning: data argument not used by format string [-Wformat-extra-args]
>      400 |                                                (void *)(long)cpu, cpu,
>          |                                                                   ^
>      401 |                                                "psci_suspend_test");
>          |                                                ~~~~~~~~~~~~~~~~~~~
> 
> Add the missing format literal to fix this. Now the corresponding
> kthread will be named as "psci_suspend_test-<cpuid>", as it's meant by
> kthread_create_on_cpu().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408141012.KhvKaxoh-lkp@intel.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202408141243.eQiEOQQe-lkp@intel.com
> Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> Cc: stable@vger.kernel.org # 4.10+
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Ping? Who's taking this?

> ---
>  drivers/firmware/psci/psci_checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index 116eb465cdb4..ecc511c745ce 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -398,7 +398,7 @@ static int suspend_tests(void)
>  
>  		thread = kthread_create_on_cpu(suspend_test_thread,
>  					       (void *)(long)cpu, cpu,
> -					       "psci_suspend_test");
> +					       "psci_suspend_test-%u");
>  		if (IS_ERR(thread))
>  			pr_err("Failed to create kthread on CPU %d\n", cpu);
>  		else

Thanks,
Olek

