Return-Path: <stable+bounces-210075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2DD33941
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D56302F823
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3C4394493;
	Fri, 16 Jan 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8FpZMiY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A683112BA
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581995; cv=fail; b=UlBOiKhN2hzZUxlCgNbF6ixKgCmnKvhyckt4kAKr1OhXgW+Z/SNW8+pmqBErDEw9Y5ZFoV1y1nnAFiUn8Q3MDlpsO1rLGGh/FunTHxY8v4SC5BFpJ2bS1FaI0z8wZEBZHQwgAgD2q1e0KtijLaFtV18uKOInswJBeNsK+CKKLrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581995; c=relaxed/simple;
	bh=JIRSxWN9ZRO3V8PAQ0rE3xHjTAzhLAPzoqeiqip1dSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZt2lXN9GFwdE/j0TCCGv9t/dLN6rT901FWJ1kr019jCZh9/jOdX2T/OqQ+P1RMI6RA4Z567M3q2c5Csr/CpvxoHUbASn08guvbeV3SF8b5uMrUJXQxDM7Deo2Ea/+4BDImlAukKrkrCa6insOWdjZDywgrBQVluDaG+97yyFJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8FpZMiY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768581993; x=1800117993;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JIRSxWN9ZRO3V8PAQ0rE3xHjTAzhLAPzoqeiqip1dSg=;
  b=J8FpZMiYOMimGLKieQ42oRHkALc8V8Jhc3huvSRJoAgn/s3K/JXf/InQ
   l1Ee+fSVFZpv86ImxQ6FLo4J3LXhz3boMYBFabuOcISHfW9EnrfUrB5NJ
   ry80LBusuWBuU2zlrQOl0W2/OrV0eyvk4nhUyQfqgbgxFI5way0xX4S0l
   Y1iSZSSUbuvwfAxTjEzj0oxQNL/NlqZLUdaVqMmw8rzhkYm3KxL8fqyip
   i7976LVE9m0/+BxixbrckscDPOaOumaMFi5SshfIDKSl+Wk/PGQd/ndDd
   tuL4h6t0XTkdizsiGfWJ0RQYmcpOsklr46sYd/4I6sylmNfSHvHLc37yU
   A==;
X-CSE-ConnectionGUID: UPCvIBIgR7qUgFZzWtcxKw==
X-CSE-MsgGUID: YnyS28kwTZyH2avyNSH/Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69875298"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="69875298"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 08:46:32 -0800
X-CSE-ConnectionGUID: YTqwkR+gSzyCakyqm9eyrg==
X-CSE-MsgGUID: 4sUIq1fXThascH8nY33Ntw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="236550110"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 08:46:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 08:46:31 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 08:46:31 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 08:46:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFuK/CYhoo/uOcU3ZQBw6pgMNJTAlWAgPJXx3qq2WCAf622VOnnIYPksmLB6pTcvhc7LI/R8vlUjk+gQtOMOLfzcP4UTapq5UDhX6OSO0yS6rA6rAKPVFy30VqQzwdOpH02iyeUFtv2jsurEyWzrSni+9XjqGQAwccnZ71bAmbwTpa82JnX4y8l65NJl/U186VYDlXcRZPVQ4fBdDgIDMjuYw28B7mYxDNngaCgVWekcVRN0FK4xHX6gRE/UinNp6MY/yrkEE5P41l5iWfGFUAzk/u8sVKQfsxgFOjUWiLoelY9cm/cirIigojApWTRX/U2YcgGcKb5tfvebMJ4h1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAOF0gWKmDi4jVLa3Vev/ckcmJ5wYQfTEDqpsD4MmN4=;
 b=n9aVSALMj1NpRCADamI4sIvadvgiA78a3Bv4PM/10AsVLtDTZlDn8HJ8mHSaoInxNTWFIDNTBDIhKBBtXuM3iG1/PBtNrdC/HN1IfTSOmUwzEMVZFNXctORQfYM9VXW6A2YWR3QVNoLC215NHvFiDfccWGG7jdehCngIyDh/U2Dp0AlMzjWI3IV1gf5O64+UVEYEbwyouLtZ40bBRKxIhspPtnDWg/AbIY+qkmFLpM0rnUaG9yjx7uwrhDSOf0F9n6k8brnXrHvLNYb4KvP28dfiNhHzmjF3MPJPH/pZKBrn+34ugFhMG/JvhwOyi6YgpU7G/8IFC3zEV2mIXBENIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 16:46:27 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 16:46:27 +0000
Date: Fri, 16 Jan 2026 08:46:24 -0800
From: Matt Roper <matthew.d.roper@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <intel-xe@lists.freedesktop.org>, <kernel-dev@igalia.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
Message-ID: <20260116164624.GE458813@mdroper-desk1.amr.corp.intel.com>
References: <20260116095040.49335-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116095040.49335-1-tvrtko.ursulin@igalia.com>
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|DM4PR11MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: b3501ee4-cbd9-41bf-3558-08de551eca9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?oorShBH69sC04cQKq/bEGXLfrKG+2CuiBYqMxkRTc5WaIA1Xn+yneAzYkk?=
 =?iso-8859-1?Q?5UzSc6S+nuk1fkVag12Ef7ZrziSGJ3cmeq3RGPCaZtVtplho+wc1CtEQ8U?=
 =?iso-8859-1?Q?IpYyI48U6a5GtTnaH2/r3PC4yhL78Q9jJ++c4JLQa/xlk2gZDObGbez3oI?=
 =?iso-8859-1?Q?bJjxlkM2LSXijdgy73I7riZxMY8qF+4jG8sIAvueQwcu/bSetRdysbmItK?=
 =?iso-8859-1?Q?6JFWf34GyGFsBedxDlAfTFi06NrVskhXYuZE2OLxzg6iM7ZFcXjQSSmO/Q?=
 =?iso-8859-1?Q?rAehXEw/bIidHQJyjGoMyvuEcbOAR8+ZKPc7r9QFIW848qSqNJc6KQ1bHq?=
 =?iso-8859-1?Q?B99+YPn375DxoqGE3il5Twch7RMxTaee1Q0ptUez4iBHmRiVwvYoXAmgGK?=
 =?iso-8859-1?Q?YN7HwJ1rwDikzpf3i9CL70PEeEz7eLWBsB8bXWX4peFgOJV+8zY3UVydUZ?=
 =?iso-8859-1?Q?huzu8aDevIrFRsu3acmRn50PjfJ4vEWZkammNZ/6gu4GsmSP3AvPZk+UaY?=
 =?iso-8859-1?Q?Jr/Qd5gs92IL1A7z2ZdaXN56V7D0PUgjFMe2fRykwsDJ03H6s/Pkgg4gr3?=
 =?iso-8859-1?Q?S4EEIKUUGk8DvAaJNCyEtkNtYhXAS16IhmO+s9ZOYQIlp62AWobYieeD+H?=
 =?iso-8859-1?Q?uy6yeTIrAFSvXPJA2fgyYKTsTPy961YZRHCpAv3qiHBbQG5ANluca8k3nZ?=
 =?iso-8859-1?Q?MBy26TmKv6QBx28r0tlDQLkmtnGvh70bAs330no1A2eJyw3WAPAfwaZC63?=
 =?iso-8859-1?Q?GTrLAfbSSWOzMaRSjbdDmjM/TIaGd9HjKSCvLKkvoxm4Na83JNgIgslhwQ?=
 =?iso-8859-1?Q?0wwdGK+QSC4IH6IhtHSRpn50aw7JStzlKWVzKOrNa93d4gUG62PqivMzd0?=
 =?iso-8859-1?Q?4nJtcF3XI9sYpdUOTSe6INbdeAzSiVSoHGf2rjIwAWa5tLOstZscSa16f7?=
 =?iso-8859-1?Q?5fxF8bMtmZaHlcGTPL0y0Zwm3nw2TJNasd9JK8LU0H7QFZxBzAdZeuSkPp?=
 =?iso-8859-1?Q?sHueEvRHutHaqKDJrP+VyHdhOFP9Dm3HDhS42IS9N1wcuxMzGhrjK3i/hA?=
 =?iso-8859-1?Q?V0f63Wijppjizz84mp76prEKdj3K6oLn7DIXxG4RiXKbvKGRSMjO7i4X0M?=
 =?iso-8859-1?Q?VBgnQHAM/PFlsWFcT99P7zPt3/g3m8lR7Exi5LUVyYc0jZp7b11VHB4w7Z?=
 =?iso-8859-1?Q?WmYNSNrEXo3qu/QBqkJPV9dWK1r7ZI81QDAkhTRv5bMOT5hHX47i8LVIOb?=
 =?iso-8859-1?Q?ObsqhBTHgeaZmZAeiNsjDfY70p1pc6fsF7/jlogcj7oUeVgOVRHtiKTF/Y?=
 =?iso-8859-1?Q?ltqMkywX7fNSLyywUOgGtI2eKtzf/z7aaxaoIZWfi/y7QfCa4k0kwXefRz?=
 =?iso-8859-1?Q?RxGF6mAgJLLoiSTPRLs2aGY2T+joncD3PzRMUA8Fs6kFVzXGaPjsmNwR76?=
 =?iso-8859-1?Q?nntVacENvpbqHW/9jCs/pHZNd/G4zplNbvxYYIv646HcC3nblMXvrP3kzW?=
 =?iso-8859-1?Q?+0mmExd8GKjcCwNUNw3iM2MeLLZkfmvYOkABkHy9rtvDdx7fIPAaqaArO+?=
 =?iso-8859-1?Q?ik4evafwK3kQ/P55bRrXU9iQiPoJOEIzuvrcAIsCHhMXNJk/6h9eSdImH5?=
 =?iso-8859-1?Q?XKtCr+CxUjJGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Y52iuU2CYDBGUyRxvQMabru7Vose1IJPb6xTxMVd1g1zu8t27GY/TCBNbX?=
 =?iso-8859-1?Q?QfR9Y9HBpfQAGerzuya/OCqpwgJ6ctSTEQTWG9/2KTwppvIbQpr6ci00or?=
 =?iso-8859-1?Q?rjUn37j/HsKnj1AAsZ+JMEcM6UKtFuPGoxrBIh+B5dCbpVcUBXDVOoDtk2?=
 =?iso-8859-1?Q?zgFIYNMw+1MTZXPF2oftkZTXkE3YgsWkhFsLDWGjto6OjRnWR7p7s9bidp?=
 =?iso-8859-1?Q?ETn9HmcHh9XEkENinHoqgMl6BcH62rqkpylYukaaPi0O2jku1ZtFONAMQr?=
 =?iso-8859-1?Q?+PPVuiUTuh01aNTkREx3BCRnq2886FMhRjNb4aZGDaVXESOW5pKmpTaUda?=
 =?iso-8859-1?Q?f4b5A8vAtdux0zC61utMmYNMMdZ6MYoNHBhF3IowpE09+s5zkz1LAehNKV?=
 =?iso-8859-1?Q?fsCwWNQvMys02qvp3SSYvhJHlwmDYV8SdnejHT5K+/rpmhJwsRr4osw0aK?=
 =?iso-8859-1?Q?P/UXM3nCShLhrgtJ5nf15WyF/dLtJArqjJirQmm6puioxsiTwJ+AuOhkdL?=
 =?iso-8859-1?Q?rAEXPRIpKGxhV5Dbku4AZTDX5OpGbPhG+1cXwy3cGBJtChLaKslIFOlr1C?=
 =?iso-8859-1?Q?p17J+61nylm154qTC/JfdcYGmVLaxVhoq3I5lz0SJtyTHqfAyyZDnWqvvn?=
 =?iso-8859-1?Q?UsplswVzu1DJvv+puuWW/le+lDBLT9qYCfHUWdlGNuvwyICfYA5p0E6WUf?=
 =?iso-8859-1?Q?iBUJQ9dLfo/HQ/XCKgJxFbF6HDWX3NXwWE9IVOnBo/0zoWaaOeSd1AGLub?=
 =?iso-8859-1?Q?Tli2GDgNY0KV2plGrzbdpkV1B6x+XTEI9pd19VeFHpuEfHHguRymBwOSea?=
 =?iso-8859-1?Q?Vg4+IHyriOHvvLIZ4YIb2IVjKCHBTQQvVJPedYdjiaxjXCjT9FajWEETUh?=
 =?iso-8859-1?Q?S3VYLhGmpcNEsPn4M3g9pEV98zKigOsGTeUaL2sPkjMi9EfU9j5xfJ2ThR?=
 =?iso-8859-1?Q?EpRTI1YEc6S10dmWX2Q0LYqLOExq/iNYfEO3BVjssAWAYfWy1DR3w3gt1U?=
 =?iso-8859-1?Q?qd4pGkjNV91N138Lr2KTcTd7GMkhmeJm/idQRufnm6DLzr7dIp6fdguA8Y?=
 =?iso-8859-1?Q?p/z0tNTvqCxCICNtCIt4XuC5TMFo2kn+DQNxj/UxkCZmEHg4cDy5LEba6H?=
 =?iso-8859-1?Q?bsEudEis3ecYfQayDCwEVlmKCicwZ5PVf38eiilGhmCWYZU4XsL7JIk055?=
 =?iso-8859-1?Q?8qf0bFlJ805OSSEBXsyX6el5jhR3nQJeAY36sQ0Bvr6NZeYE2gOipH9t0I?=
 =?iso-8859-1?Q?ooPZ/YnxAijlECzDE8uX57AajPtuagcsVKFKOcNyqZed4qlcvQgOtFDEFo?=
 =?iso-8859-1?Q?s79r/LwO7a7fc1lgyKjpA6b7dbcsMSG0p8tOdrFDnetbz91vY3u7Flo6y/?=
 =?iso-8859-1?Q?LRAiOivcMKh6xRuESdclh4cf+kJm+0NZP5z5aZaZjCzMO0nYVXptzIPa8f?=
 =?iso-8859-1?Q?Cw7Y2jS5/Hr3iCoWJhwXMogfTU0Zb/B9f5DtmaH/crIiyugiN0ILssKw6x?=
 =?iso-8859-1?Q?i6Rop8JORy7qFZUErWI7d8XLEj90WP5mooPIQl6tnphc6DkI5M+cY/TLw8?=
 =?iso-8859-1?Q?QcAwFmJQHAmOUd780SA1nxh/KeQsE1Fvk83U92uUQaYtd4vb3VE8CYlBeo?=
 =?iso-8859-1?Q?z4lOAm79lxOKrFQ6ZtDB0c6gPtYolkwKiEKPL3euY4DLgpJgA1U1gaIYD1?=
 =?iso-8859-1?Q?GtVqBIYftYAVtaJQevi0g/McM5JHE++3HN9It6Mqp6FGbpxgPe5VAcV2bZ?=
 =?iso-8859-1?Q?vJzytAINs1ltPonatFRhSJeKwtHHELlbRCS6B/5MRWw+4jVS1taR8F6DsW?=
 =?iso-8859-1?Q?GW+D/4pjqj0gwc7sf44eUW9ClzoqT2g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3501ee4-cbd9-41bf-3558-08de551eca9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:46:27.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHXZ5XRqIDClV5tFbhdEtzCYJZIq5lwdk668DOIBpouAsp74duwpM0mq5qFY1OEetbKtjTTBFGEZaIl7QKLLIJc4eGk016HXBONCcyj22mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com

On Fri, Jan 16, 2026 at 09:50:40AM +0000, Tvrtko Ursulin wrote:
> It looks I mistyped CS_DEBUG_MODE2 as CS_DEBUG_MODE1 when adding the
> workaround. Fix it.

This matches the explanation of "option 1" for the workaround, but I'm
wondering if we want/need this workaround at all.  Option 1 is to write
the CS_DEBUG_MODE2 register (as you're doing here), but Option 2 is to
do a constant cache invalidation (PIPE_CONTROL[DW1][Bit3]) during
top-of-pipe invalidation and it looks like we already do that in general
in emit_pipe_invalidate(), so it seems like we're implementing both
options at the same time.  It looks like there's similar redundancy in
i915 as well...

Are you seeing the programming of the correct register here actually
change/fix anything?  If so, does just deleting the programming of the
wrong register without programming the right one also fix the issue?


Matt

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.18+
> ---
>  drivers/gpu/drm/xe/xe_lrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 70eae7d03a27..44f112df4eb2 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1200,7 +1200,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
>  		return -ENOSPC;
>  
>  	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
> -	*cmd++ = CS_DEBUG_MODE1(0).addr;
> +	*cmd++ = CS_DEBUG_MODE2(0).addr;
>  	*cmd++ = _MASKED_BIT_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
>  
>  	return cmd - batch;
> -- 
> 2.52.0
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation

