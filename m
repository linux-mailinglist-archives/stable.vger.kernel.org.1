Return-Path: <stable+bounces-240379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PgCJjob6Wm7UQIAu9opvQ
	(envelope-from <stable+bounces-240379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:02:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DB449FE8
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192563004F5F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BD271468;
	Wed, 22 Apr 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvtTrlK+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9C8332615;
	Wed, 22 Apr 2026 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884529; cv=fail; b=ObJLx2seNIueBLfYimObzl5f4H5JhrwXDOXodndZ4tvk5kZoVk91UWlN2KIKJZ+LI+2u5ZVLSzx74OoJIWGHFaAuDZ1NuMX2Wy1/nsjt7nHxfDlg37PSk1hQqhW799WkrhXq7J43zRmUr2NPEK716MKhY7i0gGtPIHiaNhqXlx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884529; c=relaxed/simple;
	bh=b+Yzj8MdylmUxLaxv7w7NeJu772rVF+IcloXrVSNg98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=an71QiAces+YWQSDEXK7xBff4S2y+s/PenaSnyPtSiYMNT9Gg2EPqQmXbBEzvq1OhUqgz4kjqrEUZBFnU9f4vw9NL9BCPdaZbxjBK0DAlEGNMCVGMdUQhKT6JJ8A3jXqHENMFfcofSENP2KvGB3JGfB5Wlv5wq6wlB5e6QpWST4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvtTrlK+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776884521; x=1808420521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b+Yzj8MdylmUxLaxv7w7NeJu772rVF+IcloXrVSNg98=;
  b=UvtTrlK+ecm+zZxGpD4+kUx0LT6If/FToFtKjI/x9BVY1KhR49n9Pl4l
   8g+ZmlDY/S5OILBaNJTRMyXjDh/1Q1FOTa19633U/K/APOBKL8PTGz6EQ
   JPK42scxXBZqXdINm7BjhrApuQXbOJcPcG9GK3MQgCo+kldbLDADeAKob
   rMOKdDJgx0cVGIL/4TEhJC5MK80TY4MudfcU9uYTJqu65Cv4XX/aLFf1G
   9cmJifafrkzbfkOle7IRQAh4mW4umom5aGKkngRxGt7XbhTuLUIwBVfP0
   vuqRcSsM/hXndGiwU3dgXHMRz4sUMt9duIFpWUmB0RjzaJE92hbUtNtU8
   g==;
X-CSE-ConnectionGUID: PdtxzGWwSv63ceg0b4s6ow==
X-CSE-MsgGUID: elc9JDMTSRWQMEZJfd9fJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88924576"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88924576"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:01:57 -0700
X-CSE-ConnectionGUID: CcMHRAjOQxep/ICKX1Lt0A==
X-CSE-MsgGUID: PQiHBuPYRO+hXLQidiOTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="229255728"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:01:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:01:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 12:01:55 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 12:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoScdAhbzHCR4UIEjV9yFPGpOsHwKSWPAboxaUAQ9lebHVmc+zUMkOqVlfhgGQXtjkJXdHi5tYagr1ckF5bvuvTDZkG3ASb3Yq1fe8zVrJYP3M6lLTYc73pXDFN9XYm53iBmXcCJBX8m3JOdREloi1+2SzUq/aF0cEP8CLQvvmckMgIpCuFes/VTBJczINWMyKTAf8IChQD98wcBvDf5KA0YEe+2i6zVEQ3nH/gSOepm9M72Q7MAKUJ8Nfwt50VzkvdiZSQWPw1SZsjRqNiZu/pN+x+Ndj011f4uz75Eui6GMcKmDivmG5RNrspLIH6jghKo8TNkkmApfxARml5cRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRbwn4b6Xhzwdw/4ARMlxkEVvbucN8HMBNljJSINXaU=;
 b=Lu1ZSoNULqUZu46eoLH4LCr1ADUp1LaP9f+A9AgTUoll0WXDb6EH+anUnAa3EAhLMq9MniqdZ/dXg32y4HvD8DAuNeG/vwDSp567nwE+v2NTDoX+M9qI8pRfKIJnMd8pXtZm3aNSrimx6rqUfIQOelSHRi7Rsqrdj9A9+B8oBvG7UEOrKltsh7boX2AHWIOwy3qnYlcwx4P2MbugpBuy6Vfy+A/TPXNlHx+/LQyJhHjv81INbjAaOjkzqza2yUIKxbVG8S3v++YTG5IwXhvXufU73ZGJnBjQsjJJXYDfXGieugNMZYRTrof3So4xVQ7MCpqIDxrbXUYtSPSQN8PNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB8793.namprd11.prod.outlook.com (2603:10b6:806:46b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.12; Wed, 22 Apr 2026 19:01:52 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 19:01:52 +0000
Message-ID: <4ac660ad-be10-40e7-b336-d020858fbad1@intel.com>
Date: Wed, 22 Apr 2026 12:01:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: txgbe: fix firmware version check
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<stable@vger.kernel.org>
References: <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: e0107698-1c30-4650-cdd2-08dea0a19d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RE9IkDEHQyLzZs1Ysav8maptkfJ4NXnZ/1jjQm7XUd7COA4AsG2dviiXxvsp73Pb6MoVJMBpq2t79iypaKFrlf2HbSnGp8a7GUaBAyIeOZuTBa2FCapdFC6lQ9UWYa83wuGxw+huGge3PnCpLBCVRYGG3CDdWjTTAOzEyh99tDwoZUj0pwZ54eWWvER7b0rCGAbqQ7RH6WAT4lLx3WRsObSqyQAX1msCJgSi3UbD05gIkW1AAWrVwy4qZpow5mr76v9MkEl15kHkdyVdzbjXlqJ8BSaM3t/I+V8HN7/youHMADJP3oi9U+cJ4jTlNnPx+tpXM5zEu9YNjLtjh6f+xp8aGTRZM+ePTcyxHdhtp9Mvk1pk4XEMghGgOHiUz0yqY6tRxJBOQamKKvd1bEMht3k96LCp5UOjlfasFa5RjTvLI0jQ+P5RFkj38yGdWdLII00BGEHP/o4XS5/PkhXJVBIYCmPScZjXugYit8pJUcvTcRuUIeoD6Qh+4c0y1BRf5B5Osuzj8bmnyMNXH5/Sgi68DMceI4SkFBwasJ2v7LYLUS8LQhodxQ/5P+FmiWmsvga8EYQk0ABsg4T3c5GnhrFIZVW0joNUuEShbI93EA6QtTVmBxxt+ofj86wz29DuZgUicEpaYS4TlIQHlB5Gx9j0GK55ecj6s78tADbf70KVVxlITqCGII0qhUxL9Hqt193QBGtPF4+hf6u5uvogxTyDyQDzTC4kAX5phFbti8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9seFpZNzJiemN0WmgrVWxPM0sra2tLaStTSnFtMzJ2M2s5WC83OHFCVFBR?=
 =?utf-8?B?dXhnRHlmSWRYTS9aeEhxekE0M291aFR4ZmZISHVrdnV6aStnV1N6N0ZnR284?=
 =?utf-8?B?VGNBdjNsSHpYMTVpVXFrcHFSb0ZrRUQ1Qkdic1pkTGN1dFRyaG1MSk95RUVQ?=
 =?utf-8?B?YzBJOEIyWmwwWDFwUE0zVnljM3lHNGV6ekpjUHVWbng0L2QzV3pwWHhKZktz?=
 =?utf-8?B?WDRnaWtOc2RCYlViK24yWFo3TjRidmZrc1NjZ2RpV2p0Zk92VDlobEFRaCtZ?=
 =?utf-8?B?YXhOcDJzcFV1cDl3VUpWYkRLSjJibENNbHY0MHpBc2xEa0dsdXJ5cDhIMFBV?=
 =?utf-8?B?cVl0Mk5YdFlJV3VSV2VvbUdQYUpVdnBQOXBhTVcrZG91K29UR0hVQnR5Qmlt?=
 =?utf-8?B?UCswdTJ3Z1lVODJISWFBb3pVcWNKb2EzY3NsanFWMVgzYjNmNEoyZnhFb08w?=
 =?utf-8?B?ZHFhWXMwZENQU2I3SHRHL2hkQlpMb3g1OXN5dzhieitRS3RscEI1ODVLQlZx?=
 =?utf-8?B?T1dXTEdBM2xVN1NWVGtJS0pSQXpYeWRuRDRXU2o3Yy94VlU0ZVdYeWtBZXZw?=
 =?utf-8?B?bVgyR3pySThNTXNHOE5NcVVGRzdiMzZTK0lQVVZBMlVDNEgydEFmdXdMcENy?=
 =?utf-8?B?UEdPdW1mb01WZyt4QlhQMWRPZFloRG92YzBLMkxNMXpBYS8yT1N5UmFBdm43?=
 =?utf-8?B?cXBlTFRCcGZXMElUa3pBaDR2Qk93eVdIbnltZEpNL3h1VWdlTWVxbjBzcVV6?=
 =?utf-8?B?U2EzSUIzWDdhTDJ2T09hdHN5NVFuWTJRaHdOV0lDQ0NOSFdLTjNNMDd1SFRH?=
 =?utf-8?B?UWdQTUk3YTBYWFc4NGhzWlNISWVHbXh2ODVwdXpIT3BudUVLamptLzFYaHkz?=
 =?utf-8?B?THFmOXlpVVlPZjZlNWkrYzdjYTBrcWtRZHZBVjJkMDl5dmtXSDZGZTJJdEJF?=
 =?utf-8?B?aGV6eDhmSWpock9SaHpaNG9SOE00ZGNJVEVvRzVHZmZHdVF3Y0F4TTFVT0k0?=
 =?utf-8?B?VXZIQmJYU1NiOFl1QWhaaDNLK2VZb3VrSHR6Q3NRaHlhcU5kYURkU2RFREhr?=
 =?utf-8?B?K1RWdXVoaXBLZFgxbExiSjFBNGU2akRLTm9OaVVKTXVXVm1qZ0JLRjk5RHZh?=
 =?utf-8?B?cVU3VFVDWVhnakN5Y1UrMStBamtsUGsrSXZmWWtUVkp4ODZPOWVNT2J1bEE1?=
 =?utf-8?B?VVNCS0gvRVgwV29TL1I3VkhFTHVmOWQ5S2dBc0ZaYWI2Mjc5a0c0dzd4S3BH?=
 =?utf-8?B?dGRuV2R1M1B6a3Q3QWVObW1OZTkrcG9TSkpqVEQ5bFJWVUMxMFRRd2VKeTVS?=
 =?utf-8?B?K0dXeUFIUlJMK0hWQndNbGJnZHY2b3FyZktaSEQ4U0lFMUE4cTFSYmc3aEFn?=
 =?utf-8?B?ZVNwa09pV2h2MWF4dlNUSHVXVHRueW4vOFZQcTdoMEJmd0JnQitxTWdwdjlx?=
 =?utf-8?B?djNLWmphLytMbldBeG1ia3V6Q0wzZzQwdVZwTm9CYnhWbW9kL3d0ODBBWmtU?=
 =?utf-8?B?eTdrRC9wTWdPdy9nVitwcklDNjVsaHNnOTB4S3A2QTRZVnJHcVZOS0kwK0VH?=
 =?utf-8?B?amUzQStsbHlnbDlucS9odUtWcWJia09URURpTFdCZUhXZkV4TXA0MGxYdXc1?=
 =?utf-8?B?SGZ4WDBtSjJsbWJzWUV4S1VBS2s1U01rSXRUcG5Ha3NRN09EKzNGYVVUbHVZ?=
 =?utf-8?B?RTVwTmZPQnYzWFRFYk5yL0txWDR6dDExVisvcnpSSUsrQlZSVnJ3WEM3NGFW?=
 =?utf-8?B?OW5WUlVkOEFJanNXbGZpc0RZbStFNUNxSDFIV013SUFONmJPdTRnY3FpNkM2?=
 =?utf-8?B?Y0NrK09NY1JIS211OXBvcVIveCtKM0tqSVgzc1JOazJEQm5Panh2UXNxeXRP?=
 =?utf-8?B?YVZuNEc0Snl0Y0lXTDU3K1BQbWwzbzROVkVNMGt3SW5oak1EOE9oRlNMWVI2?=
 =?utf-8?B?ejdPQ2FTMEVRYW5uTmRUR2VtOHlsUk5XYTFBZ1IySEFQUEVib25VejVzMDMr?=
 =?utf-8?B?MDZPTmZvbkVvNW9lL29sUUo3NGxTWE5ad1lqMWc0VHlSRlRhWENaNkFTQklX?=
 =?utf-8?B?VDcvTHBWOEdKL0RsYTNNZ1BqWlBKTHVsL2s4V1hNS0JiMUhqejNRZzZyeFdi?=
 =?utf-8?B?enZUOEZXRVlLZm9EUFg5eFlwano4R01qa2k5U1M2aHBQZ2dkZEtUY0ZLQlNk?=
 =?utf-8?B?NUp6VXNNUnk0M21aeksxMzgrOWo3bVJyZ1ZDRURLOStUVXFYRzNLejNnNWZ1?=
 =?utf-8?B?aFVJeDBkMUxHbC9Ub2xLQnV0Y2lWWUd0RURaVU1uOG94aGQzSVdUbi92NlJC?=
 =?utf-8?B?KzNGSG41dmZvSnNMRklMY2NtNW5TRE1iVzhFMnZodmRPN3Y2RWh1eStRckl5?=
 =?utf-8?Q?5TDwm4nUEq8Jbq94=3D?=
X-Exchange-RoutingPolicyChecked: HlcW1uhbE5eaMztDocgkFMKEZiW/g5z1K0ChJnLDXg9vrJ0Pf21GX7hOD///KoesXmFYIlGvjG3rt4+GkWwuHNzpdrjwVByKtSys853j/ieToOSIiWuGKNe5j40KZK082gzlfesCI/cWZy6+OpKYO/53sJcV+7ZHzL64oWuxt9wCDVcdNlSS/488r4ouBubgJ9MGa3YYoIusr2xB6pbTZHa+HJ0AqojA5Km3XchumdwGxLCwHjAsJ/jRjR7jc/QXItFqEDL9LB9hZ8jpLBad1fDIUO8vK7sBDD9Xs8pQx6p4W5pLDh/ZCL1p3tcktmyER3umRrtC9Br/OYPRtfr15A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0107698-1c30-4650-cdd2-08dea0a19d1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 19:01:52.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v601IhFnhqhA/yT1bqbQfNRhFisGPlXe77jrHutcDhVqF7KVt0kGQ8La1SFJyX/Ulr5VwopB6tzXwVcOHGK034jLCBPwYpZfFsBXMlSDvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8793
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240379-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,trustnetic.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 428DB449FE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 12:18 AM, Jiawen Wu wrote:
> For the device SP, the firmware version is a 32-bit value where the
> lower 20 bits represent the base version number. And the customized
> firmware version populates the upper 12 bits with a specific
> identification number.
> 
> For other devices AML 25G and 40G, the upper 12 bits of the firmware
> version is always non-zero, and they have other naming conventions.
> 
> Only SP devices need to check this to tell if XPCS will work properly.
> So the judgement of MAC type is added here.
> 
> And the original logic compared the entire 32-bit value against 0x20010,
> which caused the outdated base firmwares bypass the version check
> without a warning. Apply a mask 0xfffff to isolate the lower 20 bits for
> an accurate base version comparison.
> 
> Fixes: ab928c24e6cd ("net: txgbe: add FW version warning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index ec32a5f422f2..8b7c3753bb6a 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -864,7 +864,8 @@ static int txgbe_probe(struct pci_dev *pdev,
>  			 "0x%08x", etrack_id);
>  	}
>  
> -	if (etrack_id < 0x20010)
> +	if (wx->mac.type == wx_mac_sp &&
> +	    ((etrack_id & 0xfffff) < 0x20010))
>  		dev_warn(&pdev->dev, "Please upgrade the firmware to 0x20010 or above.\n");
>  

Minor nit/comment, and I don't have any objection to merging as-is.
This might be more readable with a FIELD_GET() and an associated mask. I
guess the mask is fairly obvious, so it doesn't really warrant a v2 of
the fix.

Either way:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

>  	err = txgbe_test_hostif(wx);


