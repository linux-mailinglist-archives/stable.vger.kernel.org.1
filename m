Return-Path: <stable+bounces-223286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIMYECUYqmlfLAEAu9opvQ
	(envelope-from <stable+bounces-223286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 00:56:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A392E2198E9
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F73D3050D7D
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 23:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26475369964;
	Thu,  5 Mar 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTTmiF6Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D13624AB;
	Thu,  5 Mar 2026 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754964; cv=fail; b=QDukWmu2JjijFxmxDYSeGh+DcBTzhdzgOr5+rrIXi4MWbQEO3jYcZcmFQIYOTqop1Wez4Mt3rVdN/CWAO1lNQlS+7HCkjpN1cEvZVO7lVeWGrWX4lFFWF8FsCWmV4tiPsKeN3xG8oDL48wiFMN8kg77v7ypHV2QS9byKSJZnrXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754964; c=relaxed/simple;
	bh=InLJnunynhxfFtPm1DE/0K3ZooOCnpkwOzJ9LLYg/fo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTsSCTmBxHbfHTK5pecdApxbp3oLEEp/A9JHUZS/oeZ7Ka2gvg6lZTsBwn0kMi05JCXN5iaFFSTLUKlmGC7/ldbAaItHixNRwjQxegmR9lxFTqyqFaUiHloZIqRFaMJPCqAl32LYYPtnAnKrik3RWzP1IYV60NX/+2Er3lnRg5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTTmiF6Z; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772754963; x=1804290963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=InLJnunynhxfFtPm1DE/0K3ZooOCnpkwOzJ9LLYg/fo=;
  b=GTTmiF6ZVG5Qk0DYJkDipRQMyWJXOjZ3fVDjCFhfSC5+AqYU7hJlzj2u
   VkpOYOLFG8JofYwRjYy/vLPNEwoXlLjm7EpMGXzyd5bDqR0uf4v6siHpE
   XT4QcrfixDaYD4Dne5XvYwU3AcCFDFmhRjZBxLiud5O3rvbT+Nf39Oa+n
   RY+6aVEeDqfmWLdooTnnbA8cNtKQAdRGtNNQbNGR4oXuv3ESEMhe4dIpm
   KeUCVjkRYgCtNDrKr4z3EPYruDZpoHt/BKNon7d7gVTWl/JtDLmy5HZCQ
   JxltuZXVdRLHRJh7ye/HQZoLOZ4N3Y6tWGhRxg3CIxQh7JIKTFMuxtgnK
   Q==;
X-CSE-ConnectionGUID: hSvB7AeaTgCx2cTMa65blg==
X-CSE-MsgGUID: Q17rrPWWS9OWVZV9glVGMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91433304"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="91433304"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 15:56:02 -0800
X-CSE-ConnectionGUID: 0QqDG0k8RJSbyRjabQYDZw==
X-CSE-MsgGUID: N0o2BHCNTu2u75P61u7Pcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223534157"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 15:56:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 15:56:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 15:56:01 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 15:56:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlQiT5381z2sjt/pYmtlzNvkXfwWbeI/p49wMLNCeWuvaqc1cRDBFmAEVhrh0RkDNukFXzWbUv4bZCkTSRKiu00KO9gZ7hlFbafbiCMGVooW9KE0ccTD+FG3V+3VOMuLs1axWUhz3QmzCj7ELR7x3nltPeA4ga75wIv4roGAVpT9AhB1ZYL6A68cr2n0/UH3/OHeY/TuHhzfOIhJGn1xIMZXAsw+2iBd7nYxyvRP4SSQstc9fq/z9Sm2aCk5NzfN7J4sZrWAKYKiH2UQFNld/o4QDjCgSDrAu3ifzXbe4pkfEWFxMz20OyVWB6kg6B/AFkAtS1uvTJWR9FND8efNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMiUEa9nE1Rplv9S0j4FULz98CcLQbsHbqHeUcLz1Bg=;
 b=rpQG7tnuBTQD1jbu7QO/XkfBe9vxXBgE9di1VPeh15cN6MEet2qI9i97D4Cyt0taUk/VXNM2FpN1kgiceokGHz73INcDGkEIdylQwwQKriTUVfjAmDnPqGff8oNXZtaLbNx0ietMunXHS++l1sAhX6yK/dE81AnfKss8xTb1FBjhsj0nUB9/k97LZiMSVFfX8CK/WOYFgC3UisNFHT8gEuiTz1OKH8S22K18ZS49flrS3XlLb/tBQbXuk7qmVsQvcxndQbxXXRvCduzbPw/3SXAfF0rfauAiI60V/9rtkQmSZ/+16z70LdO+ihXCbfHDUN/WUc0GU30bb0Y6WZbDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CH3PR11MB8517.namprd11.prod.outlook.com (2603:10b6:610:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 23:55:57 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 23:55:57 +0000
Message-ID: <40efc530-4048-40c7-b702-ffc999192cc0@intel.com>
Date: Thu, 5 Mar 2026 15:55:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] ice: fix retry for AQ command 0x06EE
To: Dawid Osuchowski <linux@osuchow.ski>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	<przemyslaw.kitszel@intel.com>, <scott.w.taylor@intel.com>,
	<stable@vger.kernel.org>, Dawid Osuchowski
	<dawid.osuchowski@linux.intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
	"Rinitha S" <sx.rinitha@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
 <20260303231155.2895065-4-anthony.l.nguyen@intel.com>
 <07f515d2-af41-46f7-9336-28b5ecf36d9b@osuchow.ski>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <07f515d2-af41-46f7-9336-28b5ecf36d9b@osuchow.ski>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CH3PR11MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 660ad952-1001-44a8-6377-08de7b12be8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: ufnHOm04RUS+fytR/34xB9DGXouM+3I/TPKnHyVNCPkeAdt7MKDsCBSNC8zvJrm0ZeSUA6eOYQZN0BZ4ilM6Qx3psGKiPnfU1ezT5ugkoKQzEC7MuuOYarOZYQfreZ/ZxCNIpfkMcAoqTFtWK5N5K2jwbY/dgaoPA1+mTP4X/xi2gr94/4Q9KJ0UdMMvwe1qsCaEPvicmMT8D2xh35+zwMQSu42Kyvc7aJ8aHcc4JrC7I+/ehfPtnOTkp4v5fsJ0b/v+XlDiTtHIz4vzg47mI+fMBQVbfLsfKPvh6w5QSNzERwqtELs63dDbfCh3cWU++jlvc2o6JlbJRQQEdFFx/UUDSFQxHqgQPqX8dx4hEdqpOw6HWlAUKxSs/4rP+JR9IGjgXshwXL2M2tj0fxp6HYSU8a/NpEWNQEL5n1uzMpuwG3sshKJIywUBxafbQXSzjONR/AORhEJSfFK8pzAQw3ts0g/WV5Bq7xTEf/8HcAVbOSZEpeHoR1KaXskUL5eaIXAS0CzomCMUOgN4Wc3C3U5LAAPfaVjAQKoB+UY3VLX0/dC5NYiJ0HOHjYPFoF8zFpWPOgomUiiwLFnnm6sGk4Vj35fA5UjOKPpx9fdzoZ9Ildxdyd/oPYeeO2n9IX0joJgSKtEmg67vgaGQExpvmbV1/AIuBGYg3iVrPqd+Po9VQ1dbmICqbyIa1v1NGgbOQRWEgDJi+XPQVp7DsfJmrqtRtyYp5k/nmL10htnBs/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWYyRzJxQ0F5QThMTHdtT2dSaWRnazV5elUyVkcray82d0lKQ0pZbmpLdGF2?=
 =?utf-8?B?WHgrb0h2N2NUaDlhL2h4KzZoVDdPSHMveTZUZUh5UmM5YmRVMGFJZUdtZW9y?=
 =?utf-8?B?NmM5dmJhckVCYkN0YmFtR01BVXNzeXU4bTVuOFlPUW5wTnVxMlYrRTRMUGhK?=
 =?utf-8?B?RFZXTk8xMWpodTNMTEZRNEYrTGlIV281TFZ2SFhFZnJsRzNNdXpPTWdFQzBq?=
 =?utf-8?B?Qnc4VisvSEtYYmRuRUErUitvWGlhWDZNd0R1dWozVyt3RHVkY0E4ZlZCOWRU?=
 =?utf-8?B?M0hiVGoweDNmVWtNaWdUYWdhZkF1UkFLYUVHTEFvbmlWY0hDM2M4ZS9CdFhI?=
 =?utf-8?B?bzUray9IamN6Yzc0dXNKeEZHb2t2ZUg0Z3VNOEVwY3FYVGF4Wi9lM08wU0gx?=
 =?utf-8?B?a3VpOGJ6cGlablRPQTlZZnNLc1hsS0ZGelIxVWJ2Qno3SFJPSUpjRHNtUUZK?=
 =?utf-8?B?TVFuU3o2bHZxVjdhaTI1c1RPVUdlbTZObXpSY3BYSmFVdElycjNybGtEM3Fs?=
 =?utf-8?B?Ync1UGRyS3pxcitBc1l6R0FxOXp3MHhrRTdJWXJoWnZDcXNTUHV0ekxLQXgz?=
 =?utf-8?B?dEt5K3Z6V2EwOFZEOTJ5aWxOZU96bVdNNU5ma05CZVJ0ZmdIYWJ1U25kTzdz?=
 =?utf-8?B?MUpqMUZ3VUhETjczUlRFL3hma1I5dThrRC8yaW00WThGQjk4azIvUGI4SnJD?=
 =?utf-8?B?N0tTN25LY1FzRGxteG5aS05jN2lzWm5wTDJKN3JVVDcycisyOXE5c2NCNkpx?=
 =?utf-8?B?MGFXeHd3Wm52ZGw1NE52anZyUktqMWhTUjZselNONzZsQkljWUtCYWFqaENB?=
 =?utf-8?B?YnlWWjBnOUNZUEJKMG5GVGxsOVd0cGdFZnhweVprYU5ETVk2c3VGSVVWc3RX?=
 =?utf-8?B?emF4a3VURTVVMm1CVmRaOXNPSGhycVJ3cjhBUkFWRWQxU09EVTBxQUw1WjFz?=
 =?utf-8?B?MkdDczhYMXp3cFYrNnBHNzhUZGtVS0xTM29BWFR0eDh1QlhzMWR2MEN2eE9m?=
 =?utf-8?B?akh2L0p0MnZGdzVqbWgzVmVVTGdmYUlYUlJSbkpvdEdoOEY4Wk5hcWhOa3RP?=
 =?utf-8?B?NGZ5dnh4bkdCODdPa2VITVVwdmhkNnZhVkpGbDIzQW9YYm8zQkUxTlRvVlNp?=
 =?utf-8?B?YTBUMll5WVhaRjNhTzM1TDVrbXhPN2ZLODU0cFNMMzRvL3A4c2I3MDRmckU1?=
 =?utf-8?B?VjBrVm9mYUhxWjhSbjlrdUNkb3ZRN2FqbldWSkxkNC8zdlJxY2FrL2twRnRh?=
 =?utf-8?B?SERPQkxHR3lhRVo5QnNJdHdvQW5IbGNJQkcvNzRjOTVFVHNqL0owbGpWcTc4?=
 =?utf-8?B?V2NuYzVOeVdhenVjYmtHZmlPWlVqQXlUTTVIQjNNYjhTaDdUU3h6UldKazg4?=
 =?utf-8?B?S29WMnVaQVJMWVYwcWtEVnU4eFhMNENnaWRFcHlSSWE4VTVuWUE3a1VoYzhG?=
 =?utf-8?B?WmJaTHlDRFhKelozZDJDd3dMcmF3NFJRakxlanQ0WjRreHozRDhRWURFSXJ5?=
 =?utf-8?B?RG9WWW0rck9SbTBXNTNmYURRVTNoYzZzbFY0Wkt0bUtjbC9zOWtYalhHdXpz?=
 =?utf-8?B?T2x3ckUzMGxNZE9FQXdpVWNGdkNxN09zdGIyc1JodkRHRENJWlR6blRaRy9w?=
 =?utf-8?B?aERISWYraEl2QStka1U1bWtMNy9FaTFod0Z3NGUwcUI0RkxFSjIzVU8vcFFi?=
 =?utf-8?B?QjVoTGUrUW9JZ3dEd0RvWGt2aTY4Zjh6S0pEemF3TEZVU2kyM2JrY3BjM284?=
 =?utf-8?B?azhSTjBGZ1crWUVEL1RiR2ViWWZ3QzhNVlN2Tzd0OVR4eGtHMXNIdnY5MDdB?=
 =?utf-8?B?V1pJRldVOFVYVzYzZXhoeXBVM0VQcVI1YnNXNEdVbHZhZnFUYktWaXVoNmtx?=
 =?utf-8?B?U28xV2w1ZnN3cWkxcHBMeFR4MzF2dzluOVBORXBCaXBuSDdaS3ZBMnhzbHUv?=
 =?utf-8?B?VlB2TFF6amVMenBMQ1JLekg0dHJadXc2T3RqVjNqZWZCOHRWcFVZWE1TdXhp?=
 =?utf-8?B?RnJpTTVjeGtTZEEwSDM4aXBjYUNDdjBnTWxKZHY3U090eDR0SVUzTWJFQUtv?=
 =?utf-8?B?N2gxalpoOVhrZUd4V1RzejRFUDY0V3BSbXBKZm1PTVFaZGlNRHVSamdDUkRT?=
 =?utf-8?B?dEtZM1g3SE40SFlhemlGbWZUWVZYWWgwNHYyalVab3liQXpEb25iZFZuNmxa?=
 =?utf-8?B?ei9DT01YWU1nSWxMR2FnSkZyUjVyVzlQb2kyTTFjWHFxb3lQRncyR2dRQVJS?=
 =?utf-8?B?bm02U0syTTJtcjcwTzU1dWdyYVF5VjRkSUl3M0h4YWpPdkR4V1YrUUxRY3RY?=
 =?utf-8?B?d1h3clVYV3FsVnN1VXBrTy9jTlZRTWNMWDc1UVVSa1JhZUpnRTNUZEgrSjZN?=
 =?utf-8?Q?p2/nhMkjgG7foTS8=3D?=
X-Exchange-RoutingPolicyChecked: eSqBPVhOQ/+7+Sx5PyUdFKmP+gEdZ0yXDi410ONq3qtxjU6fl8hDszveA4PnOJGVYcmGdMjGq0swkyeB89/j7Ba0epPpeLJurBE9TGoS/nXuQ8rrcRNUMDBIFEzzNa4YXc7dtYx7CE+PKsCfDg5iKxwNn1CKlsJQ3AkzaLSTT6tqNHTZ1LekiiTSy04mHTszT59v4Zlmz4Fqtx7q9aCWRBuOrRQ5wA8ZRgQ2TQzCcI1AdloT1EMcZxaB4iEW1kETXuWfzhBV2GA3y2dlAdrfMkSLpPMf2tF90622hHM7yf0hFMHefmwuiJDElj1dedUotLA8zyNIZcpys8wgTrcIJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ad952-1001-44a8-6377-08de7b12be8b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 23:55:57.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn7l1SeLgC0Tb9lFMDoCKx0C7rF+jvCmPsfelzMbE6WkTz/BMO38K6rE7yZbYFyXhfWpaZX0PiR7ntHvMKZPEREvcf5yHRJHwckcmli6qA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8517
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A392E2198E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-223286-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 3/5/2026 3:24 PM, Dawid Osuchowski wrote:

...

> Could I ask Kuba or whoever would pull this in to fix this typo in the 
> final commit message that will land in netdev? :D

Hi Dawid,

This was pulled by netdev already so it's too late to change it now :(

Thanks,
Tony

> Thanks,
> Dawid


