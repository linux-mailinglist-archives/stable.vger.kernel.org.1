Return-Path: <stable+bounces-223735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M3sMjRcr2nbVwIAu9opvQ
	(envelope-from <stable+bounces-223735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 00:48:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAF4242BA8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 00:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D10DD301BEEF
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 23:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EB28689B;
	Mon,  9 Mar 2026 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrK2VKUS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E43D544;
	Mon,  9 Mar 2026 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100079; cv=fail; b=gIg52Cr0wPl45SX+u4hY58ucJnlhwWOmIY3HMD8tfnrWQUdYlN7ck6lJ6/xdsO2Arxdc78LpL7CznQrp9BzH9VsD5si/ZL+fNtIWbPZadgdBh3H7qw77hCafJTuvPt3MeMYw8TA1evenJ4kxSwZbt5TI40eHbSiZignb6YYVjiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100079; c=relaxed/simple;
	bh=cTag1JIDY4KyhGTXyJcZ3WNnsN2Mbtxyd5PWNb9jyWs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K4GVdcVEY5KNBhzAhHeskfU8ZoQ2YShho5V3iVJqGxiMGciPeawgrRISObcZFJ8YeWcYmGYRYLg2dPBXB2SGV4AqLwxLDqtd3QEZ4mHlQPSk6UPIfAA3JVzYL7GCS2+EIldraeG1BfbWa0eoNXuqSTOZZZaytTuEI1IN0OiE1cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrK2VKUS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773100078; x=1804636078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cTag1JIDY4KyhGTXyJcZ3WNnsN2Mbtxyd5PWNb9jyWs=;
  b=WrK2VKUSncwMvwufeUZb0UT6q49L+fBZTMpBlB9zsQO7/afCX1zt1hrH
   +AF8KS8a5oReuSna4YAfkcq3RX6M+1DPhQ/Rc0XDb7I+VwT4Rkeu49eVH
   3nr3P32AgAXf15qAHbQ1a/chitxJCtKvsuW+ceqi4gfB+pAtMX0Q29PI2
   QRCJUUZWiYejRjYt9RmMlkuH+jm72dJOkYNbA/DYwcT4oAWyzCaNXK7m0
   xy6njQSdQwEtpgpBe7DoW/YZt3B+KyKkLsLrIugZKKoY0aszjZzmXsOmo
   CeJFhU6G9D1mhEFrynGMmstVPbd7PizO3BONlnsfamzO7SqBhHF7qYx+k
   g==;
X-CSE-ConnectionGUID: A5Fg4WHdRD63IGPkzUIk4Q==
X-CSE-MsgGUID: gsNnwd5HRr2Xia/3idA0bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="96756740"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="96756740"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 16:47:57 -0700
X-CSE-ConnectionGUID: 49lGbDWqRduKbmMT0n357w==
X-CSE-MsgGUID: EnWpfrvZQzSG840Ro+vazg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="242923230"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 16:47:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 16:47:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 16:47:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 16:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/cjmdfYpfoGsnsoxEfqsXk6oBKq9GwJ4xRrIWuFR5VaeQwND1cujHXO9WCseAnWH6TpHS9lFzv7uy0aZ5xYvOzeAeI5Cmbb2kQdDBSWWPLU7IzxkecvFNiEpp9cuCP/etWt8SdWKaMrAmNmUxWiyKeLjQcD9XpK1hy9IOeVc7alr9htMm6b3B4615hMqvf8d12aoQMDTk0gpzN4SmHOgfZKrUgzjPAMn4JVOfgaqO2AMMZyOpCCwrwFJvh6wg2K928kCnH8V6rN6XxF8nmTiFr9OtqTe/bDilziQsGZvElgAbMC4zLC8u3ToFQ1WvLv0YWz5P9z4/YN49kAaRBxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAU+qXl6L1BbXy4Hqvp1DwPg40LOYMbSn6oFR6u+HI0=;
 b=Zy/fBBGYRb8cmO7cb8meYMAc2S0alyZuV8LJP07/GqnKAtEm3K4wVLFQpfnbDRq0H+v25ASBYxin3F9Iu2f72txMjduLcXW7g4RhRSaxSteA18BRO6kXt4PNCoeNz3R3eEaQYEXWsqADSxoyRVgKsoxtU/zmvJmhpxPOxzWXPU7xyZQFb8+AyfvH9AeSXXTnCjfzZtAiqc4E2zPVUN9Wc2KUmGGUigfAx2E29R55np8rGTRtFouY70iYsAwFT+lPWFZV4+EkTFrP2cdvKVJk2mJTP8I/8sSTz4YtjcwEko02x4K15QE/jz0WN2sQk4cKRX1CvESlePYE79MTx5BBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by MW3PR11MB4731.namprd11.prod.outlook.com (2603:10b6:303:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 23:47:51 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 23:47:51 +0000
Message-ID: <eb26dda1-f0bf-498f-b4c6-874a6c2878e3@intel.com>
Date: Mon, 9 Mar 2026 16:47:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at
 compile-time
Content-Language: en-US
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
CC: Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1772453012.git.m.wieczorretman@pm.me>
 <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|MW3PR11MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: d21c942b-fb4b-4666-4682-08de7e3646a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: xvQXL8ReeHv2gVpveVydPkbzn58UnVYDFZhGaprL5Av31qsyosHb6hB2i8owvbTV+j+ot+ZZb8qLqdMJ4IA0e2izduRBgDrekPT2oSGUjn3IJAzRiWqeXj8+KL2Z0IIqTDK0kSgCwFch06+RRH3sGcWAGN0leyJHrh5fksZ/8CiN/CEF97YtOF8zMfYdCV56UNH6tFbwZVuJnnedu+bO/73quAKvWFi7wVeEMVzud3nVeMQZe51yZR+E6MHDa/MHF/yTQ4gIPSXniMagpR2fRgXa4ZGzg4DHaKd77kCsFqT3xyY6BoIk76bIXFGGpOBI8CHebHQvVIbbo/UP2pCUSl5pm5YW2hIjSdHcDD1CjuYB9ekhiRS+e5zxmO4rCrQjRZpbCcy6Q651O/+g230qqoUN1l+aKjiWfOc2dytkckbsJ83kWqMXgXc08qPS/j5w1E0WToUdODDRCmhucLBGHUPzCKUgIqFf0tfButH231I8owRtTBwDT5xSB+byq3b90wCb+lni09EMau2A7UQZGB77SDe42/BWiLKqITZbv2u540OaPNJ3B0HhuzdpLA7DHYkBtS3mlS2H+Hlihm29mjwayGohGGohNqxNn2kfxGYrNWJgoN2EpLLiMzBqJ9E/NDedQiLJbmfz96hhKtvmSbvcrMfBl2DJHWWzDd3FD4ToaKGFKVOQbv/B7v9Vqj0pCYvA9JHbMjO2UMzWRQQFiqVfnhPAWZT6qD5F2GYn6qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um1IbjdaSStmdUtCd3FQN1lVUi8zRDB3dkYwc3hXR0o0WEYzaGZKUGcxaFNK?=
 =?utf-8?B?WTFrN0dXVmFtdGVOa0w3OTUyLzBTQmlsRUZVcnViYTVDdStOVkpUN3AwVXp1?=
 =?utf-8?B?V0tvM0JCN05BMFROZENVT1lXVHllM2hwSVJTT0NQVThEaTYra1kvVGdiYzFt?=
 =?utf-8?B?Tndjb0Rpa055UE9JSFViY21rUlA2eGFEK2Y3RW80ekgyMGcrcWdscGZrM3lY?=
 =?utf-8?B?RmxKbHNBdFRLOFBKOU1KZkc5Rno0Mk9jZEpiZmlXb3lXdjczWHVUay9pdFVi?=
 =?utf-8?B?VXFIU1BlMGs0alVWM3BQSmN4Z1B6aWprcmRPSUNmSlNWdW13VmNPVU5BNUxw?=
 =?utf-8?B?RmZzVFJvc0ZuNFNOcjFiZkhsa3VkYUpZUklSMGV4MmdGRWhkMU81dkxJTTE5?=
 =?utf-8?B?YXBocldxaEVjWDB3UXB6dmZDeFVmdXgwWG84dnpOVjBRT0dYbDVWaUprODZx?=
 =?utf-8?B?NEVmWWI4RTZkeWtEMEJHK0tKYlV5UUxabkFYK0FBazRVRXU5Zmc2RGZRbitC?=
 =?utf-8?B?THh4cEFEdjMzRzZudmwyUHllNEl3MkFKRk55N3N0V3d0RExDaUo1RnN3T0RN?=
 =?utf-8?B?UlRieURMQitLa2VkNUtwcEs2ZTZNa1pDYUZnUEU4aG1qc2ZyN0dYNm9ncGNM?=
 =?utf-8?B?clhTSHhGT3daeUcwWU9JSmFubHcrYjMyRzRYSDJDLzJCekZ6ZlNnR3d3dFdN?=
 =?utf-8?B?OGpLalQ5Y0xZOFBlenUzUjJzNm5BRXV3WWJTYjU5SThrL0ZNZmk4SFVPOVU4?=
 =?utf-8?B?dXV4VjRKbmdIQWhjdzdYQ0RhaTVLOGxnZzhENmFlWWhhb0xuMUFqZnpKVE05?=
 =?utf-8?B?U0hlSlYyUDRBWVZWN1Jsakw4VlJIcTBwQUtHeHVIR1hxVlB6aVJReW9EUXVS?=
 =?utf-8?B?S0JKTDFudnJXZDlOVUIvWkMwUUQ1VU82R3BGVjdxQVErMU5nS1hvaW01YzFO?=
 =?utf-8?B?dmt6NDB0K1FoRWJpZE1acDkrQXNNQTVUT3ZtWEJlQjVXN1lSOUxzVEpQcGY3?=
 =?utf-8?B?MXloNkpScVhnQ1NTVi9jYWs2TkdrNUU5cDk4VDNPT3FCZ2grNWNuY2pGa3Bs?=
 =?utf-8?B?K2U5Z3dwRXJkNjhUZGd1Q3d4bTVtcWdmVERGb29uNzZDcGxNR0M2Qzd1TDI2?=
 =?utf-8?B?NEUwcy8yZ1FuRkZ1MVIrRE95SGI4dmNUYXJiaHB5cjFzUURRQ3BqUkZJcHpq?=
 =?utf-8?B?OWlzOEpwaFFEUm1sSGlPYnVMcHZ3MXdUS080cjRZQkdZN2VwbE84cS90bEZy?=
 =?utf-8?B?M2d5a0NING1TbEtHRlFSUFVlL2xneUtXSkxlcE5IVGJFRmRhYjAxVHpHWjhD?=
 =?utf-8?B?cFVzdFAwRmZCWk5Ia3RvbG9MTjBJVmJpMEFKOEpuUHcyUXRLai9kQzlnbS85?=
 =?utf-8?B?SUtHTWxsY2NTYVlGOHpSR1FtanVxanZqSWZ2cmVaQUNxZWtnZzc0Ri93TTk0?=
 =?utf-8?B?ektoVlphRy9PWWpJelV3N1BSNlRMOUJhK0dtdVYxS0I2ai83aTBQS25FWTNJ?=
 =?utf-8?B?ZTd0VGxZd293Y0h2WDZraXBkWHpzTzhuSVc4eHAzaEJhRkdKQzFOTGd2ZWsv?=
 =?utf-8?B?SCtIOUw3VFZ1ait0YjR5TUxGaXBrVWlBV1NKd1ZrVkRDdmJXRkNYV1JPcUFN?=
 =?utf-8?B?TlhHVXNBZEVlODI1dnM0RXd3S3JJdDNvY29KNzJ2MHErT1dSK0FwQTFHNHUr?=
 =?utf-8?B?dmwxM0VCeGJnN080WllVU2taWkZNM2czMjJRQ1g2cXY5QS9pelVtWVVsVkFw?=
 =?utf-8?B?aXhCTUh4VklveXRjbzd0Q1FEU1lSOThaSmNaU1pVdTYrNXRSYlNoNUJNQ24y?=
 =?utf-8?B?ajJPa1UwMUVyTXozMDlMVmJHWXZYRllIc1o1UDYzaHJtYjZVRjFITXdDeW5G?=
 =?utf-8?B?MndsbXhxZTdrSWdKZ29JRmk1ckgzWEJZd0FmYldaN2VmQTFGVWMvK3BSKzIw?=
 =?utf-8?B?azNzN2g5N2tCTWZta0VCRkVQcmI4Q0U1UDRwUk0vdnBLUFpwRUQ0QldlQ3hs?=
 =?utf-8?B?WVBEL1E5Z25JSFJyaS8zTEZrSjBKOVZ0TXFwZkJVSFhFaXdGai8zNXJQOXha?=
 =?utf-8?B?UUVCcHBoaUh1UTRQSEVobStvTnFQNXhmRFEvSnRWbUYva0J3TDRtOXBjV1E4?=
 =?utf-8?B?RDZ6WXBoaEF6TUJ1Q1VmSzFQKzd4cEpXQmRjNVE2RXpUSC9vZHFtUm5zOHBO?=
 =?utf-8?B?MnhwYlUzaW5aVlBRc3huQm5ZZkVEVFYxdkZESVQ2aVZEbnBreUJaU3lKZDli?=
 =?utf-8?B?RjZVZG1YN0o4Tk1wTWhydTdqT2FWd05BOEZhTys3Q1FHeTd6MXFIRjZacmxu?=
 =?utf-8?B?cXg2WjdqRzI4cndYaUE5R2F4bXJEcTM2cUpxaXJvRzd1RXVSLzJHdz09?=
X-Exchange-RoutingPolicyChecked: nFPTXkYRm3gxIqmhvjnnVIYIt6OvqPyYY0ZNUos4G8daiDCTKD/edOjyu3T4xk5r7bKiV8KKbO7R9Sog1/Auttxc9FRPOgl4S2NUActIfA8GZgQ/PcMAwT5gwP7VQ4swQjh3hmLFKU8xwDgiP91Wy89jRzl9TH/m2tOtgFR6O1Ix48pdeXhByT4mXz0qrlrMwtHBmHU1F9wF6ixOWhko32m5si+voc648FeZXPPlc/KidKZbjdkqMzYz2Oums5i1TyWGDbnlgcUQ28e1Uyq76kdWssY4dHkQUdgu/08ztxoZ/9PlbVddLIKzev9I5vWqpFzaaYe6CUlJ+KOZOFm+dA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d21c942b-fb4b-4666-4682-08de7e3646a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 23:47:51.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TueJCu4u30QoyHtejYP52YC9i5D6/iq8zFZf0M/kAdSh+zY2xI3CW6kqhA4cxJEJP77LqmtItxLMAmPt4vb/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4731
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 3AAF4242BA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223735-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/2/2026 7:25 AM, Maciej Wieczor-Retman wrote:

>  /* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
> -__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
> +__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long)) =
> +	DISABLED_MASK_INITIALIZER;

IIUC, DISABLED_MASK_INITIALIZER only contains the X86_FEATURE_* bits.
So, the NBUGINTS bits in cpu_caps_cleared[] are implicitly set to 0.

Should that be mentioned in the comment above? It wasn't obvious to me
when I first looked at it.

>  __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/tools/cpufeaturemasks.awk b/arch/x86/tools/cpufeaturemasks.awk
> index 173d5bf2d999..b7f4e775a365 100755
> --- a/arch/x86/tools/cpufeaturemasks.awk
> +++ b/arch/x86/tools/cpufeaturemasks.awk
> @@ -82,6 +82,12 @@ END {
>  		}
>  		printf " 0\t\\\n";
>  		printf "\t) & (1U << ((x) & 31)))\n\n";
> +
> +		printf "\n#define %s_MASK_INITIALIZER\t\t\t\\", s;
> +		printf "\n\t{\t\t\t\t\t\t\\";
> +		for (i = 0; i < ncapints; i++)
> +			printf "\n\t\t%s_MASK%d,\t\t\t\\", s, i;
> +		printf "\n\t}\n\n";
>  	}
>  
>  	printf "#endif /* _ASM_X86_CPUFEATUREMASKS_H */\n";


