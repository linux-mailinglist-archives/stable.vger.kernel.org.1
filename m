Return-Path: <stable+bounces-133205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC3A9202E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126AE8A1E48
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAD2522AA;
	Thu, 17 Apr 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZTj7y7T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33767251795
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901330; cv=fail; b=Tu81rKQXn6OwXJzdpfFoU2YpUd4lBFxNpzne/a6jCqEcVndl+a7qUZoMicVizs/eB6wvewU+aT1R8x91K+3NsXvLHBiMGMQpqVq0dnzhFLvv2+xHdjASdz2+7qV+TwyfYfYY6NuUFvpyJ6zMZ9K1/SbD8odk8T+a+qjAWGhOYIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901330; c=relaxed/simple;
	bh=xlqmFJ7JWWM1MCxLc7StXd1dsoV2ImN/z2EZjRXqItI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YEgcmHdYX5D3a/p2aKNcx7Jq8IUyhHrc43ve0yB/zC4P6X1bQGIPDmvikN9TFIrNfBqQnElviBNRq+iliGTB5Zt1C9WqId7i7KvkXDFut+zmdKQnwMXxUOSZGZp4pjm7JE/88aTyKSSRiqK4uLWwSFSI1bws6HhNwaq3qX55FbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZTj7y7T; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744901329; x=1776437329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xlqmFJ7JWWM1MCxLc7StXd1dsoV2ImN/z2EZjRXqItI=;
  b=GZTj7y7Ti9wCnRDISAtAvexj93NvHtBbXF+Yxn8YmFK7yRhqqmuGu5I+
   sWTO9NYcISDVKYRh4FrU7Y/yn8Qg17J1tq0CIaWBCmJfjtkytwL7xxQpw
   LaNV3CQAl9Mh2oFtds3g92Z1HJBZSCOjC3Ee5JVKk1sQOgqQEuBrxL3QS
   /BMEnpomegZMlNkFHZNekgHs7nkq6Ld8cWLApHDQ0vXis3BXBT6nZjyYt
   fpZ6lDnPqLCm4cmUuA3rz2AwrtrbNz8MlnYPztfIkdLHChVZWDfIPEVU7
   0Q2FzwM56sxd89D/JLz5Xi97qomCD4KX8iTF2YwtFl+nsRyabtsZcYfjp
   w==;
X-CSE-ConnectionGUID: bxhX036oSdKHTP8r6PsOdQ==
X-CSE-MsgGUID: DCI14fzFSdeI+TZXe8xCcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="63902156"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="63902156"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:48:48 -0700
X-CSE-ConnectionGUID: HJDmeS7fTiWxfjuV9+e6DA==
X-CSE-MsgGUID: oVXHGGi8TGeKQkfg1KEpnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130681865"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:48:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 07:48:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 07:48:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 07:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQIf7qAS3bsZP9Q+3PVFCIjwMqL9oeaESR6i97f05eQbh4JekZJ8uOsHo8hrdC9UQwx8IRvW4yV1QvqzRD5czAoVcnC1wxY5FIWyb1knQwVezTS1oFy19ACirNblT4LqW5k+1R5WgYzzzYPuNMFAFSyaByVEZODStQwkF24AWlaAlao5tGIBWmruD1Wiif1Wo6+0rJFvWc8ILCLp+1qZoHLR+xHdbWNKmkO2D6pZSZBIsD8aHzAXZvXLWJuS4YWXQi+vxgNrCNCUdtLSFhTYCPspi8RstUQg2iD9BO52H9Vb/KAV0yXfwE9PtiPxoQjh4YHJhjQV34btcaL5Enca9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkTviCGJC+5FReXgDoDoxO3INvQSpx6fM4p807zQVqU=;
 b=ZqHHwOT6LMb3912hoSMggtMfwA8dSO0GXlK7TTOx8slXUiHBns40utbMukR9i2WOZ0JC2KoG5kx7kMzsxKqt9eldZhhV6OjNH22QQR00Zv8x50MP7N1Us1p8LNfrF+cfbY/6Oyt0OgBOUu7XDuDHQhib7/obpV4PME6ul5Ns95GC8n4UkjcM56LJuDlnjBSkUZZqCKF5dXI9zYk41zVRxRJpqe5+/ZvU9VHZ7nMzTysCo+n3px/dWi9kRvU498+WKzom+vaBObBdO5prxGqSK1exbz56Q0ttxeg8ttky8G6jXQl5SeznuRnDn8OPWz+xr/oz/T1YO0XYEz18ugPluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:48:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 14:48:44 +0000
Message-ID: <d6188f70-c38e-41f8-a62a-126e893604b8@intel.com>
Date: Thu, 17 Apr 2025 22:54:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] iommufd: Fail replace if device has not
 been attached" failed to apply to 6.14-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <stable@vger.kernel.org>
References: <2025041759-knee-unearned-530e@gregkh>
 <9160a4eb-fc69-4a0b-8bd9-5b9d5f4f5bc7@intel.com>
 <2025041711-handwash-sleep-09d0@gregkh>
 <3389628d-27ee-45c8-a11f-217ae1743a69@intel.com>
 <2025041718-smother-moneywise-2326@gregkh>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2025041718-smother-moneywise-2326@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS4PPF2AD6B04BA:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a47181-c233-45d2-8e26-08dd7dbef3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlJ5bmxjRFZ2VGVjQlljYndlRXlZK1ZuZml3U3RVS2lFZ0FFWkVOZ3VqMmJk?=
 =?utf-8?B?ZXhMSm95ZGdzNXM1bXZTUFJ0RlBLNS8xRzAxMnlkeWRBRUlzQVNJRHZUa3BT?=
 =?utf-8?B?bWFaVk5DRWU0YnZQZTlMTFJjV1dKMlA3WE9ob1hVMW5iQlRSYzg1SXVKRTVa?=
 =?utf-8?B?YzhiWEc5cE1NZ0RSQlhtdWxrZW5tZ3JXRU1Sb0RvWXBzdXo1MkEybU1Xbi9G?=
 =?utf-8?B?MjBNOGVneCtLRnltVk5OWVFaUTJ4eFNaK2xKVHNmVVRkTnpsRE1JaVNMV0pl?=
 =?utf-8?B?c0t6MFl4TEgrbU1vK0hJeCtLZnBEdVBHdVhHMU5oYkJmTHIvZGRDaG5USEVU?=
 =?utf-8?B?YUI3WG9Uc3p3djFyQlRKaHQ0eWk4cUJyMUUvcTU0c1VTOWZxajB5TlJZaWg4?=
 =?utf-8?B?ZityNDNCb0MyOGFOYmlyRG9GM2VWclNLL1ozRG50eVpwV0VLdGtGdldtTExM?=
 =?utf-8?B?bytybkpoUmcxamw2R29IeWo0NHFLV1JFaTlkemFQNzJsK0dSYmFSa1paTjk3?=
 =?utf-8?B?ZjRiYytTUEYycVRTUnN5Z0tHNEsrMW9RditDWFpjbVhQMTV0S1gyV2JFK1Bx?=
 =?utf-8?B?T1pqYkNOTTY1Vko0Mitld21IU3NQd2tCVkc4eno1dGJsVjV1dE5sYzI5dWRE?=
 =?utf-8?B?aHpUTFhWRUNIdVF0eEZkVWY2RWpKY1lYNmNhamR4ZHpBWjZRSVhETWFpcUlo?=
 =?utf-8?B?Zlk2cVFJMCtnL1FPbzFNS2xIbWRBS3F2STIwMTVjUGl3MUM3dUhJMHJSeXVm?=
 =?utf-8?B?SkEwSHhnOTBrdkdCUGRlQzQ5RjBLZk40Y2hsbmkzd0xQSGxjcFNsNU1ldktY?=
 =?utf-8?B?T255bmJGQTQ0ajNmanBDemdPWS9pajJGUGs3ZTFiYkZFT25TN0RBWkE2Vm84?=
 =?utf-8?B?Y1pjL0Uya21OaVoxVkptK2tmdWJsbURRME5RbmZLcjRUMHl0cGlyeHVEck1T?=
 =?utf-8?B?RVhtcHBiVk9oZEZtUmcxWGNFdUNmeEp5cmZaNERGT0hqM0k2V2d2L0hVU3F5?=
 =?utf-8?B?dUdwVVI1Q2QvZXRnQmlKQ3JxWjNRcnBzclE1NVpzZ0xtajVHd1Q0bW5CRVRn?=
 =?utf-8?B?RXVrTjZDVTRCOXAwU3FOYzNYejBFNkJqNDRiRmZYSUZ2T2x3bGN5SUFqS0Nl?=
 =?utf-8?B?dXBkWGlrQ1lINDJwenVVU1g2YWhlS0VCZHExL3lMQy8xa1EzMW93ZkVPVUJX?=
 =?utf-8?B?cEtEOVByd1Nvcmg0azBiQ1YyR2hKbURBRlBMTEZYWlpiajUyTERBaTdKSWYx?=
 =?utf-8?B?ZFZweVRqdnFIaXJJZU9raHhtcUlVQjR4bFhxSHdTaUNwV1NianByN1lwbG9H?=
 =?utf-8?B?MWVyTnhyd1lZRTlaT0RmMmNoSzl3dm9QTFVOME5WeXpVT1Z5VmwrSHZheWho?=
 =?utf-8?B?NUZEa0wyYzZqRFhZb3ZQVGxHVE0zdWphUjkxRThpeVlBN0RySUxEVkNVajI0?=
 =?utf-8?B?M21KK0lPdk5hOUlxU1FqWlBQQ2NOS1lNaitzT1M3TXhmM1l1aTFHYzBFRDJL?=
 =?utf-8?B?a0g2YnF3aFc5U1l6aTFQNVRTUW9Rb3ZPVXE2ZFFGR3ZKRmMrbnVpd2VlMyta?=
 =?utf-8?B?YXZ6aSs5SG9SN2tNZXF1NXkyTmpkZmFDK1dNdEVZVngzZDk5NUNoUnVSMXE5?=
 =?utf-8?B?K2pwMzBPbE5VU21vMkZLSTVkT2V3MVBzOVJ1MEdXRm9UVFpBTDhvSTJCeTlm?=
 =?utf-8?B?RWkrd2pZUzBJNUlBbmtHaFlBNXlYQVRJL0lwQWt3UXNTS2htRDlXNHFENTgw?=
 =?utf-8?B?SytoK0RFVVdDQTZlb3lpMW1NaVo2d2dYQVc5S1lCWE9SRDRPcU1ybUpqQWVk?=
 =?utf-8?B?NWM3WGl6anlRdWZMSzMzZjM2Ty9kVW51ZVhvVWJaUWRLaGE4d0FrcGJZODVX?=
 =?utf-8?Q?PONwBba9HFpvt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWtHZjlXL2ZnRnBFbDBUb1JmZnNHREJ4NTlBSk9iQzN6QW5PcnorcTRyZ2VP?=
 =?utf-8?B?MG1BeTd0a05JaGhVOFRtREhiT1F6WjlyTHBOMmh3cVoyc0o4bkRlbHJNRkQv?=
 =?utf-8?B?d1Vpb2lPdWR6SzM2aEVsRUV6MUF5cWNVbitwRTczMW5NMC9qVVRRWEo0Y1Bi?=
 =?utf-8?B?WnRRSWlwZlZucitmVjh5aGtRRHhXUGFWTW1UVUowMlhNUktBWVExZEMzVzlr?=
 =?utf-8?B?ZFY3azBtT3RweFUzV0VkOGFBaEdaNEszd2V2NDZTZlNLTEZqTkNjZkxDYnVH?=
 =?utf-8?B?M0JTTHpaejl4VmNFc2tHT1NjSW9oZThZdVNoT2ZwNTY4NVk4T0pqQTdQQnJ2?=
 =?utf-8?B?UTZMM0pDVHNEclA0U2QwajNJcGtXc1JXVTBBSElUVVVSck1tRkJJdzg3Z2sv?=
 =?utf-8?B?Rk1zNWdNdC92UlFRUXdHSjdhUU8vSVp6Y0NJeGx0UFRkdzl3VndUekxzMjQ0?=
 =?utf-8?B?cENvS0tjVDdCR2VTalN5UUtibUtIQkwrTWpOQWxmWWhialoyZ1h2aDZPYkx4?=
 =?utf-8?B?SHBLZkhHVVdoR1ptS0pnN3pCWUE2SE5GSU80OG1JZjBSQUxlSWtJMmRjbVVJ?=
 =?utf-8?B?Z0k0bkIxZ252K3JaTkxrRVI2TnVnZU5Rb0NUckx6ZzVRcGNra2c3ZkxuR3Ew?=
 =?utf-8?B?cGJKUE5XWFhrYS9Cb1BxMm5TQkliUnJnK1IwY29JS29kOTh2akpGRTk4Si9M?=
 =?utf-8?B?SUtLdzcraGl4RGUvSzh1M1ZkYnJuaTN5NFdkNWJJU2M4L2J6RFMrb3ljbHpG?=
 =?utf-8?B?ZG5LbTlrZUpaR1ZBdEc2TGtCNFNlb2xSQU9xdzlXNnVsVW9haUhqUkRYWHpw?=
 =?utf-8?B?M0gvNllNNFA2UGU4dmg5QUpGb3hNbzUyalQ1L21QTTFmdFp0K2NRQ3pLbkk0?=
 =?utf-8?B?T3JmVkZGN1ZKNjRkM1JoODl6MGt5VTQxQkhxb1l4UWpiK0RBcDd6VVpYQ01I?=
 =?utf-8?B?K3c2c0ZCclk4bC9oNGFYWE4rNG5mNy9TN2Z0bGU4d2lHLzVrMm03UmlKcHhK?=
 =?utf-8?B?VW54NUdwWEZleFFsRlpnVjJQTW1DYUIwN2J0b3lNWHFCajlFQ28xS0ZSNTg1?=
 =?utf-8?B?WUN1dEhDaFlNbEJFeVc2a01hY2ZBMUhmS0dOckdaWW9rbVlFeVQ4a0xXc1Jx?=
 =?utf-8?B?WVVvOW8reDlyODVmdkU1c3dKbmRhS2RwbWNuVERTRVd2YUhiYU4wWUczMGNF?=
 =?utf-8?B?RlRvNzNDT2dhMHJxdWxFQVRpN2tlSTdEbVZVanVVSzBxbUxMeE1JYy83Y3Ja?=
 =?utf-8?B?L1YwNHloVEhHUVFFbnlrRWF4dnZ3VitVaDR0bk9wTEdyc1JDKzVBYkRQZlZp?=
 =?utf-8?B?bTRseDd1VGxpRnFaeC9GQ1lNN2hzeSsvUnFtM0Jpb2FRZk9mUERUcXlaMFkz?=
 =?utf-8?B?TFAyajdsT1VheHJFOVNKYVNLQTVNMFh5eXU4VDg2bWtydzZXZm45MGJhVVZB?=
 =?utf-8?B?S0pkVVhIOGZ4UjgwR0lIWTVKSXJESXUvcmlMQTZuempzNW82c3dmL0ZwNllM?=
 =?utf-8?B?K2FKbXNPNGZ6bDdZRTA4aXFBVDI0SHhVcU5XaDl4cUNFa3pEV1BPMkM5MVp5?=
 =?utf-8?B?d1FtK0dPMHZ6aFkyclNaY3pORE1zbS9PbnhIU1MvNTd4QnJBRFVGcEpuSnBV?=
 =?utf-8?B?UHdoUkRMZUsyVmdGZTd6d2hVcVJhQUMzNk1HY0hpNHJEOGgzVFk0d0liajQv?=
 =?utf-8?B?R3VWVm5GUjgyY0RnN3B6SHdyUWNlZStFZnBVeHRjR1AwR1lBNTRueDNMME9F?=
 =?utf-8?B?UlpmSWR3WDlMOFJ5bitNblRpZXhBdjQveFVZdmlVQTAxQkFXUUQ0U2RROCtI?=
 =?utf-8?B?QkVzVUNzRWFMdCtReXdzcWVLbVJrMTZFb2ltcFAxVzhLTjZJZENhN0tTRk5N?=
 =?utf-8?B?aEI4aFhFNWRYU1JFVGRWQVVlT0hYRUs0VUk1enJtaE5jTVdSdnRVMXhEai9y?=
 =?utf-8?B?K3FrdHk2ZTlMWk5RY0I0bVJic3kreEd4MjBscHJPRTFYZm42eVQrdmM0QnpD?=
 =?utf-8?B?MTRVQ1pjQ1ZHbDdEalFYaHJrVDZGTHdxQXk2Z2RIcGVDVHVqa0I2NjVBR2U4?=
 =?utf-8?B?WlR0ZCtnRnRqYjl6RU9jaTgySTQ0YnlYb0dJOEQvLzZLcnM1WXc3M0psMjB6?=
 =?utf-8?Q?tizOnuj7AUbSRCHjFoBu89zk5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a47181-c233-45d2-8e26-08dd7dbef3d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:48:44.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LGqixwldp/lQ2EUafoMp74p8fMH6Xoy8krCYprtG5fAoPi7nucIX2aRjrPs+m2eQMDDLbKR0iW9t1zjOOkURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com

On 2025/4/17 22:29, Greg KH wrote:
> On Thu, Apr 17, 2025 at 10:21:51PM +0800, Yi Liu wrote:
>> On 2025/4/17 22:12, Greg KH wrote:
>>> On Thu, Apr 17, 2025 at 08:52:16PM +0800, Yi Liu wrote:
>>>> On 2025/4/17 19:42, gregkh@linuxfoundation.org wrote:
>>>>>
>>>>> The patch below does not apply to the 6.14-stable tree.
>>>>> If someone wants it applied there, or to any other stable or longterm
>>>>> tree, then please email the backport, including the original git commit
>>>>> id to <stable@vger.kernel.org>.
>>>>>
>>>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>>>
>>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
>>>>> git checkout FETCH_HEAD
>>>>> git cherry-pick -x 55c85fa7579dc2e3f5399ef5bad67a44257c1a48
>>>>> # <resolve conflicts, build, test, etc.>
>>>>> git commit -s
>>>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-knee-unearned-530e@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
>>>>>
>>>>> Possible dependencies:
>>>>
>>>> I think the possible dependency is the below commit. This patch adds a
>>>> helper before iommufd_hwpt_attach_device() which is added by below commit.
>>>>
>>>> commit fb21b1568adaa76af7a8c853f37c60fba8b28661
>>>> Author: Nicolin Chen <nicolinc@nvidia.com>
>>>> Date:   Mon Feb 3 21:00:54 2025 -0800
>>>>
>>>>       iommufd: Make attach_handle generic than fault specific
>>>>
>>>>       "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
>>>>       used by IOPF/PRI use cases. Now, both the MSI and PASID series require to
>>>>       reuse the attach_handle for non-fault cases.
>>>>
>>>>       Add a set of new attach/detach/replace helpers that does the attach_handle
>>>>       allocation/releasing/replacement in the common path and also handles those
>>>>       fault specific routines such as iopf enabling/disabling and auto response.
>>>>
>>>>       This covers both non-fault and fault cases in a clean way, replacing those
>>>>       inline helpers in the header. The following patch will clean up those old
>>>>       helpers in the fault.c file.
>>>>
>>>>       Link: https://patch.msgid.link/r/32687df01c02291d89986a9fca897bbbe2b10987.1738645017.git.nicolinc@nvidia.com
>>>>       Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>       Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>>>       Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>
>>>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>>>> index dfd0898fb6c1..0786290b4056 100644
>>>> --- a/drivers/iommu/iommufd/device.c
>>>> +++ b/drivers/iommu/iommufd/device.c
>>>> @@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct
>>>> iommufd_device *idev,
>>>>           return 0;
>>>>    }
>>>>
>>>> +/* The device attach/detach/replace helpers for attach_handle */
>>>> +
>>>> +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>>>> +                                     struct iommufd_device *idev)
>>>> +{
>>>> +       struct iommufd_attach_handle *handle;
>>>> +       int rc;
>>>> +
>>>> +       lockdep_assert_held(&idev->igroup->lock);
>>>>
>>>>
>>>> @Greg, anything I need to do here?
>>>
>>> That should be it, thanks!
>>>
>>
>>
>> you are welcome. For 6.6, it might be difficult to apply all dependencies.
>> I've posted a patch based on 6.6. Please let me know if it is not preferred.
> 
> You forgot the git id in that commit :(
> 
> I fixed it up and took it now, thanks.

oops, yes. I missed it. Thanks. Let me be careful next time. :)

-- 
Regards,
Yi Liu

