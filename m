Return-Path: <stable+bounces-235407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEDvIimf12kUQQgAu9opvQ
	(envelope-from <stable+bounces-235407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D35293CA904
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7BC33035A95
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A63CCFD4;
	Thu,  9 Apr 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LApb9+yi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA833CAE6C;
	Thu,  9 Apr 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738592; cv=fail; b=eZhXdW6q36Vpp/uY28TTg3kjmpNM8A7E+YurhzREns3jptybe3UzxRAhJH07VWBarVq4MvGeWZPV4cAomebcm9bqePeIre2Zj1RQTtm5cAy1RUn7KgLyOx/m+Kmu4Fig8qh6CLRNov9HlwwQaCm3EZzCMBRBG1Jq0csVmVzT5HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738592; c=relaxed/simple;
	bh=nGwmdtWdL3JZE4jDRpc3UGjGQBLRt7i7IwjdWUtM430=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cg3HnEHfS13J28qOpeo7zG68axacOfM6TRWMTxOUQuiAHhDxlIoTlXLso8PKFWkGRwQ7wuLCSAS48UKJviA9wVWlBnC+pDlLmnAwGOwTc5XOfgfomeRevOQ4kNS4Vd6L99pLSsOP7oANyTLEsBdc/zmp2RIOfNDQ9ba/UNH50YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LApb9+yi; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775738591; x=1807274591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nGwmdtWdL3JZE4jDRpc3UGjGQBLRt7i7IwjdWUtM430=;
  b=LApb9+yiFua+gDWzJRILgrOGC6EeFN54le7Cd0aoFMUkNgYgXLiL9BI0
   ZwvUd0ybz9r2tT2ntI+XH3VwrU4nMu022aAAqZg7Oy4FnNCMMfAMChWiO
   ECaiuUXrM34heZ+U7/S7yXnTB26VpieBVTrCr4BZzh4q9stRZlY1Oqvzr
   RcFHvrl2a8lDb/GtxK9MXmCD6hf9vXNt2eV+ERoRWPq51Ja5+VqLU2oSr
   UiujtDSvqlcBhoMH6hlgbarfd8TfyfqLVqke4gbC6Szw3H35EPu/xui/6
   Sjw6AaRrHZk3CkfU6Xy4VYYg946RafhqLkv48G49+ozo+aHTYfl0LU0wW
   A==;
X-CSE-ConnectionGUID: IcHjdY4wQvqtZqbJT4q3aQ==
X-CSE-MsgGUID: bOyHLuegQB2Rgfd5Gdew1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87815766"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87815766"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 05:43:10 -0700
X-CSE-ConnectionGUID: zCrGoGGxQXat/tuqPZxCqw==
X-CSE-MsgGUID: d0GkJdP+TUSfAEpvV10uhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="226003967"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 05:43:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 05:43:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 05:43:09 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 05:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZF/IDWiPRQZ+PotR502Zoo4tiMtMl+7qOrUi5f7XzihU9G/0pkDLFkgulkAwy72b+TqoT7lxo6ggZTi2HMM4harJdejTvPq1f6dIkQs2TNgTdAlwnJXAmQWA9lezY4dTIRBQEdU2AsuyX67gwSSoMJfzM1npF0YRA0yJ5CKxmdlP7630n8ZyJUpnFaeDI20dinNTgtkZYnjXyhK0PRNERo5qD37tgtESFQpikOa4WmlY6/3JP7n3YI3ZX57Te/gwlvGq+VEUwVqin6h8inHJlTcU9eYmjrJrqby0BwKktFpIlF7rYq1uecERF2iQ7DwQyLsWo9t/7x55DBjJGHEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL+Wx4pBq0LjAtsJxOGBqKis4fgHe12vFEml8hNZp8E=;
 b=H4wEp/U78t6JFmj0vV9L8mEoK7fr4ZTB8p8bkzX4Bf/g14aHvHs2AuCzTtHSAmE/gMVFeq/9ERKy8wEwQujvpS+zaDKJ1N40GEjUFTBNOdzkZqG6ezt52FCmV3ubuXLr2Of+rLpkS0uwiaw+P8KvrxYevzCJdTG51FndqHHf2VxmjGp1UiEUHYl3YOA4Qcv1VaJEpMt+yonvPUrxnisOq8srM74W+qFEN++n69nV4Qc8KtmvqiIN1lq49rI9vJ+zK3me5tsY2ad6VQTZPZY7eNQFgyYC10YjArR6U4V4mBJqznTLjB86u4NuqLdnHiU9C2HKqTuUiIKc/XusNHFDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by PH3PPF310D5CFFC.namprd11.prod.outlook.com (2603:10b6:518:1::d14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 9 Apr
 2026 12:43:04 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::2769:b184:69c6:6eb0%6]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 12:42:58 +0000
Message-ID: <89bfd605-1877-4d40-95e1-bfeae6624168@intel.com>
Date: Thu, 9 Apr 2026 14:47:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/4] iavf: send MAC change
 request synchronously
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	"Petr Oros" <poros@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
References: <20260407165206.1121317-1-jtornosm@redhat.com>
 <20260407165206.1121317-4-jtornosm@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260407165206.1121317-4-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|PH3PPF310D5CFFC:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a2c18e-f082-4748-9cb4-08de96358737
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hU4INtTdaJSM4Vpt0Pb2zhTu+pkYApG/1h1NFcaatHKH72DpJl8UEo6XyWWumnc4guwZIFZx6IY/0WClXYlnn5PJAPj7Ntgrabe0rxUpcGQhvITZ1/0NTdIZdyWOiCAmJaGUDcLPdsFauqaHmkQaya4wO1F099nQTHYBYlSUvalVh8V/ra30Hkl6cEP/MVYnzvUriazIVGM2Nx85pCMutwWotRt3kCOSPmCeX08y17d5XddIlSwhTBQ28GysN1EZpSJSb46RGEgKIKEnJ82ltQ3yGxLVDSOGxgiVKbgVuc1+dSkLwem0s+0pQpl/7Kv/3lCvyhFKXVk49suPoMiJ4MIIzhERlXCCHteVRjPl+kDumN0qxnFJIZMVxKO1WySkiwEsDUu+t8OlP/iips5iDIyC5TYWQHtgU3xdwhxNmaiqdILlhNeV9Kr15sJ9rwBWV5YlX0c7waxQZ1rhdtXkQI3+ROQud5cgx1AbpWGjr96Z+qEDh1QJ3Vu8tt/OvXDkyj2k9W32FcLCW7+Io+mE8jUP45TB05kHVktw43ST3JDzuOZRCZM89/A8uyZx+bhvvNoQ7aFD0l8t2hWOUMtmwud2Q7oI2F5ZV4JYJ/NFJZeotfuoDDc/6SFnDV6dtOTdzTEwN2NKsESrl89oh2f1iLNZSdqfE8ka8jMdC6o0Bl6512XBUN9Sr0o9PZc07+GVBwjvA4eNpN1ju9jDKjc89RDUTCx5h1P3daPnINvAtjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBraUo3VGdpVzl4dDFJL2ZCQTRsdmllei9Xbk9LbDQvSEU4UmZra01FL003?=
 =?utf-8?B?OFJVREx4NmZIa1pqNW1seGd0KzNLbU03UUFZUE1RSDJMQWpaUkZUMXRwN09C?=
 =?utf-8?B?MWRScGVBZjhNa3pBczNrRSt6RzlEQzA5dXhOSGRweFFvZFBBLy9KRE9yNERi?=
 =?utf-8?B?N2k1dmVrN2swWENmQ2cvOHBQQll0MEhEWDFmYU9yREFsd0Q2ODh5QzhNV1Rs?=
 =?utf-8?B?aGVXMDB2cVdSREFrR1pCRmpNOUFDaEpoUVlIQ3IvUTdmZlo0cG5zSEhZYXIr?=
 =?utf-8?B?Lzd2WTg1ZUtVenp0NlB0ZXlGYzZOMTNaTkNBYnRCZWNya2h5SFUxRXZMbnM3?=
 =?utf-8?B?MVhUQzI5ZVJjRGIyMUhwOXd3WkpTYnN4VnoybCsvTFl1SE14YXhKSDJCVDVP?=
 =?utf-8?B?WGRIMksvU1RRQWxJZnpMYlpRaXdobDRnb2tZTFZYamo5L0M1S2lucDY1b1Bn?=
 =?utf-8?B?cWNpbVRpeWJ1MmFlU1pJRHhPS1QrQmsybHJoMUFrZ3grS3RHYUwvNkxGR2Jh?=
 =?utf-8?B?all6TU5zUGNDcTlLaWJ5QlArYjJjVUFCN0w5amROWityRTluTCtuTUlRQ0Uv?=
 =?utf-8?B?akxudjh6clo1Z1k0aGsxRWJXVFR4TDNnWVhMK1BBS211VVA5SU1TaXFsdTU2?=
 =?utf-8?B?SmlhWk9TN2c3bkdBbHVhWDgxMGYzNjlMaFZnTTB0UU1nVDNYL0tQa2ZuM0RK?=
 =?utf-8?B?VDJFQ09MVGIwWTdad0Y0VkRRWEdjMC9nV2ZwbExLNGgydGM4L2J1NjhTRHIx?=
 =?utf-8?B?QWxaUDdhcGhqNmpQUXlYNllDRVBGOWdYeWF5Vy95WmFrN1N1bDhGMWZTeTJG?=
 =?utf-8?B?MHMvbk9WTmJSY2NXN0hJSWJxL3RXaGRxU0l5K1ZZNFJEYUkvS0RVT2kyaU1h?=
 =?utf-8?B?TnZaai9tZXlsNHpscUJrQ20vUU1WRjMya3V6SFl1K3R3bXp1V25WWjdtY1Zm?=
 =?utf-8?B?OGNURHp0dlE4eU1GQk9oOVIrNTJFaGdUZmlLcjlxMW9vKzVWU2ZZWEVkd3NX?=
 =?utf-8?B?Y0VSTUVCMkFxZjRJQnFNOXRvbGxUTFpPbmpyWHhYOTRNbGFodk9MNlJMQXB0?=
 =?utf-8?B?RC9naEp3c1FSTERSZlhlUTBPTFZvOEg5Sm9GbFJYTnBmWUJyb0ZTTUNSeVlz?=
 =?utf-8?B?ckh1eEo2N08zaE5CK0FmYUlHZTV1TmgvT0RiUEVER3NYRHNyYXhiSkRBQXVN?=
 =?utf-8?B?NWZ6UE1DdDN2WnNSclBESHNTdWRLcU1wMkVMWGM0L241TmFnelBrbFJQN0dt?=
 =?utf-8?B?UUV3cnFyQTlBbmNBVUJoa0pGRTF2S1JxeFljLzMwZ0JQUERYdVg4dHpwWlpi?=
 =?utf-8?B?SHFyU2tqVUxEdnNTQ3ZSQ0FDUGhFeTg5Z1V0amNaTTlVQU12NGZtSHF2bm9a?=
 =?utf-8?B?WXlkOEhNWGJURmZGTXpkMXg3OVJtbmxpNTZ5UHFDeGFBMjdVTUs5NitZMG9Z?=
 =?utf-8?B?SUNjMlJCR2c5c2thVnZrRGxESUF0T1NsMkN1ZklQSTBBRVBjOU1YWEtBZ21F?=
 =?utf-8?B?b21TazQ2Ym5RbmVSWWcxQk5aUGZvQ1Nqb3ZNVFVHUHlRK2JBUmRiWXJXZG9m?=
 =?utf-8?B?N3hLaFhRTmRNcmpFYms1YVllOVBMWWtydm1peTRGdU9ObGhLVXM1MVFnVVZq?=
 =?utf-8?B?azkvRS9kQVNsQkxpMHRLcTZVZXJxMlhkdktFcll2dXFCZ25KSkdET2VGRUdE?=
 =?utf-8?B?RTM1cUtPVkxRSlNqSmJhSEJiZ1B1Y0pVdlUzbVpCQ05hc3NIQ2tIejhUMmYr?=
 =?utf-8?B?dmZWZ0tIbFRnc1NxbU9JZnIyVWNGeW92YkFscHkyRTNQYjV0T3d6MmN5WjBH?=
 =?utf-8?B?M3plelFCUy8xT2RlTXJSSVpkN093WFdFa3ZJV0dTaDI4Qk9YZ3JXdThSMk1o?=
 =?utf-8?B?TmEwcTcwcG51aDJpdEZGT1BvbHZNbi9SeWRTUXRuTGVPa2toSjltMTE2N2FV?=
 =?utf-8?B?eDFJWkxQZTU2emRETE9UWHViSlF4cWovYlU4TGkraDNrS1pSOHowb3RMblZz?=
 =?utf-8?B?R1pIRlFRWjlpVDh3MGQrd3VDazlmekI5WE5lK3JiYzQzU003SDhzNjB2blhy?=
 =?utf-8?B?ZzNQRXlNZzhMN0VmK3NvUEgxanpnNGJjbmlyd1FHUG5FNVdDZHNiVTZ5eUFM?=
 =?utf-8?B?V2lMUzFGcSttbWZDMkttOGIxZEt6ZU9BTVlReTBzdmRnOE83ZkFxa3FmWkpX?=
 =?utf-8?B?eXB0R21HWkx0Nm5EY1lqMXZhS2ovczc3OVFFSlRHUk9jOEFRVnBxMERSYjFP?=
 =?utf-8?B?dERBb1dZZ0tXcEJEYkY3eGhta3BqeFB6T3pGU012anJpVGcxTkhxdGJxTkJH?=
 =?utf-8?B?b2xKYUNhRFRLbXpOOG81YXNxekF5Yk9yR2RsN25JSDB2SWQ3TGpDL1MyZWF1?=
 =?utf-8?Q?I1A1Wrsg/wgnrU78=3D?=
X-Exchange-RoutingPolicyChecked: b+Wisb7Wj0fKAGF7q+yR+eJBKc5Ni8eakyZ+J2670I7Lagq2l+o+qXeDXopRcNojuKITLCUd/u5xuj9Ca9HAnU2rBgsRO749gXiNfGgw8270eNBv50I1zpkP4LcR7tVQi4nAOuFWMBPDcsBTHSiMAjxi0p3QbpkoRqr80ksPnNyuoaTNgYod8uQnnVLpDlSblphqW2GyitGvybt5ngWwIVND+w1mMNh/l4FTifbYY1TM26M2Gi05V4GnAh9W5nBFXUd/HkrwvpzluzsJRLyYW9nlLBC7THLUIZKKpwxEPTKccxImcEfQuCvoxHek950o6UMf3Fp6Y+0K/LWhz4cMQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a2c18e-f082-4748-9cb4-08de96358737
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:42:58.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVE5XmtkHvqC5wZ/YKznj5DCgYTe3V9ZdEihDnYO6N/Y50pJRmind73ga2gDlHn6jq2jDaa6EWeJcfeb1aymdtzWaAca73LC+tzWPxz+bCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF310D5CFFC
X-OriginatorOrg: intel.com
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235407-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D35293CA904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 18:52, Jose Ignacio Tornos Martinez wrote:
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), iavf_set_mac() is called with the netdev instance lock
> already held.
> 
> The function queues a MAC address change request via
> iavf_replace_primary_mac() and then waits for completion. However, in
> the current flow, the actual virtchnl message is sent by the watchdog
> task, which also needs to acquire the netdev lock to run. Additionally,
> the adminq_task which processes virtchnl responses also needs the netdev
> lock.
> 
> This creates a deadlock scenario:
> 1. iavf_set_mac() holds netdev lock and waits for MAC change
> 2. Watchdog needs netdev lock to send the request -> blocked
> 3. Even if request is sent, adminq_task needs netdev lock to process
>     PF response -> blocked
> 4. MAC change times out after 2.5 seconds
> 5. iavf_set_mac() returns -EAGAIN
> 
> This particularly affects VFs during bonding setup when multiple VFs are
> enslaved in quick succession.
> 
> Fix by implementing a synchronous MAC change operation similar to the
> approach used in commit fdadbf6e84c4 ("iavf: fix incorrect reset handling
> in callbacks").
> 
> The solution:
> 1. Send the virtchnl ADD_ETH_ADDR message directly (not via watchdog)
> 2. Poll the admin queue hardware directly for responses
> 3. Process all received messages (including non-MAC messages)
> 4. Return when MAC change completes or times out
> 
> A new generic function iavf_poll_virtchnl_response() is introduced that
> can be reused for any future synchronous virtchnl operations. It takes a
> callback to check completion, allowing flexible condition checking.
> 
> This allows the operation to complete synchronously while holding
> netdev_lock, without relying on watchdog or adminq_task. The function
> can sleep for up to 2.5 seconds polling hardware, but this is acceptable
> since netdev_lock is per-device and only serializes operations on the
> same interface.
> 
> To support this, change iavf_add_ether_addrs() to return an error code
> instead of void, allowing callers to detect failures.
> 
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v2: Complete rewrite using synchronous polling approach instead of dropping
>      the netdev lock. New approach:
>      - Polls admin queue hardware directly (similar to iavf_reset_step)
>      - Processes all virtchnl messages inline while holding netdev_lock
>      - Introduced generic iavf_poll_virtchnl_response() for code reuse
>      - No lock dropping, following accepted pattern from ndo_change_mtu fix
> v1: https://lore.kernel.org/netdev/20260406112057.906685-4-jtornosm@redhat.com/
> 
>   drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
>   drivers/net/ethernet/intel/iavf/iavf_main.c   | 118 +++++++++++++++---
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  11 +-
>   3 files changed, 110 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> index e9fb0a0919e3..5bc23519fe9c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -589,7 +589,7 @@ void iavf_configure_queues(struct iavf_adapter *adapter);
>   void iavf_enable_queues(struct iavf_adapter *adapter);
>   void iavf_disable_queues(struct iavf_adapter *adapter);
>   void iavf_map_queues(struct iavf_adapter *adapter);
> -void iavf_add_ether_addrs(struct iavf_adapter *adapter);
> +int iavf_add_ether_addrs(struct iavf_adapter *adapter);
>   void iavf_del_ether_addrs(struct iavf_adapter *adapter);
>   void iavf_add_vlans(struct iavf_adapter *adapter);
>   void iavf_del_vlans(struct iavf_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 67aa14350b1b..2ef30b1ef35c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1047,6 +1047,105 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
>   	return ret;
>   }
>   
> +/**
> + * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
> + * @adapter: board private structure
> + * @condition: callback to check if desired response received
> + * @cond_data: context data passed to condition callback
> + * @timeout_ms: maximum time to wait in milliseconds
> + *
> + * Polls admin queue and processes all messages until condition returns true
> + * or timeout expires. Caller must hold netdev_lock. This can sleep for up to
> + * timeout_ms while polling hardware.
> + *
> + * Returns 0 on success (condition met), -EAGAIN on timeout or error
> + */
> +static int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
> +				       bool (*condition)(struct iavf_adapter *, void *),
> +				       void *cond_data,

this could be const, then no cast on the callsite

> +				       unsigned int timeout_ms)
> +{
> +	struct iavf_hw *hw = &adapter->hw;
> +	struct iavf_arq_event_info event;
> +	enum virtchnl_ops v_op;
> +	enum iavf_status v_ret;
> +	unsigned long timeout;
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf)
> +		return -ENOMEM;
> +
> +	timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	while (time_before(jiffies, timeout)) {
> +		if (condition(adapter, cond_data)) {

if condition is met, but timed out, there should be no error

> +			ret = 0;
> +			goto out;
> +		}
> +
> +		ret = iavf_clean_arq_element(hw, &event, NULL);
> +		if (!ret) {
> +			v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
> +			v_ret = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
> +
> +			iavf_virtchnl_completion(adapter, v_op, v_ret,
> +						 event.msg_buf, event.msg_len);
> +
> +			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
> +		}
> +
> +		usleep_range(1000, 2000);

no sleep after message received (ok to do on empty queue)

> +	}
> +
> +	ret = -EAGAIN;
> +out:
> +	kfree(event.msg_buf);
> +	return ret;
> +}
> +
> +/**
> + * iavf_mac_change_done - Check if MAC change completed
> + * @adapter: board private structure
> + * @data: MAC address being checked (as void *)
> + *
> + * Callback for iavf_poll_virtchnl_response() to check if MAC change completed.
> + *
> + * Returns true if MAC change completed, false otherwise
> + */
> +static bool iavf_mac_change_done(struct iavf_adapter *adapter, void *data)
> +{
> +	const u8 *addr = data;
> +
> +	return iavf_is_mac_set_handled(adapter->netdev, addr);
> +}
> +
> +/**
> + * iavf_set_mac_sync - Synchronously change MAC address
> + * @adapter: board private structure
> + * @addr: MAC address to set
> + *
> + * Sends MAC change request to PF and polls admin queue for response.
> + * Caller must hold netdev_lock. This can sleep for up to 2.5 seconds.
> + *
> + * Returns 0 on success or error
> + */
> +static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
> +{
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	ret = iavf_add_ether_addrs(adapter);
> +	if (ret)
> +		return ret;
> +
> +	return iavf_poll_virtchnl_response(adapter, iavf_mac_change_done,
> +					   (void *)addr, 2500);

this function looks elegant, thank you

I'm a little affraid that this model (if applied to other things than
setting MAC) will skip some of our "much needed" logic in the watchdog.

I have not thinked about much yet.

unrelated: callback looks elegant, but for virtchnl, it is almost always
the case that we wait for some VC OPCODE to come back, and this is just
a number. It could be easily coded as a callback too, passing wanted
value masked in pointer, but I would say that just passing a normal u32
param will be most clean



