Return-Path: <stable+bounces-238366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHnkDRtM4WmDrQAAu9opvQ
	(envelope-from <stable+bounces-238366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:52:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA259414BB4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 22:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2270530A7622
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53238B120;
	Thu, 16 Apr 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jnm587xj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4EF35DA4C;
	Thu, 16 Apr 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372636; cv=fail; b=bqq145qCVdX7MhclImErqPa1s3SraybiZOOr8fshXTCY9AyiWIKn5JZ4ceK12hQNvLHxPPnFZH0ca+PEuOLPy4S3pX4QW9YvHMqaLohDS0HxOC4ptDVPlvOAYQuAXOThW4nqlOrOGguwh+rZORlDgGKJJ8JFL0j77iC3c+M9png=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372636; c=relaxed/simple;
	bh=/1CO9q9YBCawdRhrP5E+r32gfsnLvTQEz2qLqOEgpX8=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=suK6M0GVGG+MK8AOADzadIa94HS4JUlQ4w2Vg4Scg0p1rK/Dshk07XAE8c23x3PbQu6tnPWLivK6UI7RRbBBNfGyq6qgVNQAZn2fqeHL/1sqnvhsrI0phVLsPWoXhkY7l9y/4WgUiX05zDoA0LVmYJ9qSKiq322Mrzqnn5b5Ma8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jnm587xj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776372635; x=1807908635;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/1CO9q9YBCawdRhrP5E+r32gfsnLvTQEz2qLqOEgpX8=;
  b=Jnm587xjoZ4xJJjLdmvcVkdPdczaCBIY1L+/3q2OJ0MGp/OucgZ8w1Xv
   2yhRalliYCgL8wmW2tg8wjTlzMm/MbZ+yera6zI2xQsgjRy0rn5XDQmVQ
   BrRdzD/F5IkuVblIL8+vVhjX7hybaD7cB6Au0LVvnDsCjfPIISnx6y0rs
   JBfA/T7Xi5h8TfxLLQBBmqpkn57ZvNVVsvna9wxu3V/6/EG2tF+IJGXEa
   Io8ifTXCJ8pTEkadIQW9VkxHliHxb7cCnDA1OxF+5bFavVz/lNCYbyQo0
   DEweaIpnBUbkrjHkBfgFmxcjRMIWhxDUxRhh7GLR1bMDFdjBKC16TahjO
   Q==;
X-CSE-ConnectionGUID: YzPOCKnTQ7KiMj3aM2NhfQ==
X-CSE-MsgGUID: eeSshSROQzKAJlfnlc9Obg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77503060"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77503060"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 13:50:34 -0700
X-CSE-ConnectionGUID: iK/ed1eTTPCTlEicMKi+Nw==
X-CSE-MsgGUID: Jj4IqmGzR4qC0EdacXtLdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="229832556"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 13:50:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:50:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 13:50:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:50:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFklvaTiMtmiGEp2se0u+eR6AzyVniAQaSf9hGKt1SA9qmkm2nuEktP74zl7PULZYOmWXw4q6AIG/JME0Q7mKhtced8L/H2rHQdPqKDpMlSyLIAY+DResgruToSwDh/DVhlnCgINqj8Wb0T9tkNEnMzoh1HXZlGCkmfEiWoM1CpI2T+1x8etLiRbRsy6QkhVkhzcUp9n2DMsr/Wu6L7s3g+pKwPBxwNGtHeI7BqfcO4ivnyjqUexUgCenOCcupLKXjbiCi1eu88j8QDmsf5uhdOHSH+XiBREw57PlzIqNjekcS5dJkp2/lFBWhBm2KbzCe82PuvRYy9eIiUFt2IRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RiAW8APQJkuAT3lxI9cCgRXruV0S9Enp1f/TaH/tks=;
 b=HeHH3UFTAfFPE1IdK1d5zvcjh01l7G0icLSZOAKT3B2kzTwuL4i9nvIGfqQFgYCJ4lwP29sYGqOI4YaeYh7yX8uTjiiLOMhaR+2yVmXfSgrQpT5A3IXSre3ehGheRxMmRsb1x93ERxJecDQvisxm2ZrGF55t8dupIHxh6dzGhKZkVyul/OvCNHZ2TS5LhnpevUoDORoUuCKZG2Ul4ZtnvAThsqvGwN9tHVdrmw8WNTFhqrfgm1WlkRpWyWoOFHXHLJxE7Ji3X+XzaB8rXK6Pok3MCD2ZjY3Oxf2TMBu7uWbARYaK+otPXhhUpUAyFnuZUHBNy+SOlLBpSg6zLkENOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 20:50:28 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 20:50:27 +0000
Message-ID: <f7ab5606-4939-4979-b08e-762097f4ed32@intel.com>
Date: Thu, 16 Apr 2026 13:50:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/13] i40e: fix napi_enable/disable skipping ringless
 q_vectors
From: Jacob Keller <jacob.e.keller@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, <stable@vger.kernel.org>, Sunitha Mekala
	<sunithax.d.mekala@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
 <20260414-iwl-net-submission-2026-04-14-v1-10-852f38e7da39@intel.com>
 <6cc3c5b2-fb71-42a4-8d5b-57cd85de2f02@intel.com>
 <70776680-1b60-4898-b9cd-bcc48abaac76@intel.com>
Content-Language: en-US
In-Reply-To: <70776680-1b60-4898-b9cd-bcc48abaac76@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0361.namprd04.prod.outlook.com
 (2603:10b6:303:81::6) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c0d8a9-0174-4a70-7967-08de9bf9ca07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mMk6i6eAzWTq5sSIUWGGom4k/2ECCe4xPzlWRcFzMu7Zt17cJ3mnMSVLbbnsqB1M3EziqtFykxJEC5e/4USt1beEOUVGQF+nBp8aZl8PWeydBfmadCYD9hIBvgtXtmIPSvwlcIqD+7azxvUAzdMKhawOx2XU82/Uo6qBiSWFf5uYIY+C5g5rgCa6jumcPLD9uzKG1RB4e5ypplVGDVWBunp79ivd6fTQepy1BFA1MWcgn/HyDurQ/MNCH5GXZUuZwthSsUWcGuI32h6Zof4ZUKPu4RAOIoI8LRIO8mSi2GyquFSRV3tfNLs5TbB8NK/NTSq+Lg/QcZaZXlJEBdDcBwcOn/0OpwTo0H43pmFoN+1OeAGSMva/xLP78aOkRqb/M0Koq4MjVAkM8ABORw3RPT7TEeLI/99i9sdPaqC4QzIUeyzGvV5XosfxjEp7HyVZNRT1/F3tuUsPw3utZtexYwngjXQvetsGN+bgVtQsCHEQ4DsfmTyooypuKsl5Sf1jaSw1wQlwSFCnetTWeojmjrNdhRhVOvqAtOCqiLULRHjnWViV15VJXgrvjYIcpiryBDBFUmcqTQo0MZt5ke5ek5qa9qwnvBz5JCwZhrvspamQUb5mtW89aiURUko2FwXGlAFl9YP+IG7nn+OoBEFNW8wFwF1YIbMpSvpl9fJWYpZizIhgn/WWuICchOk06T9D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Q4aU9PTDNvdkxZazhyN2ErczJodys1akhGbnAzSmNHZS9jTXU0WmIxYmxh?=
 =?utf-8?B?MWRZVGRpVzhKQUIzQ2NobVMvSWlXeEFpdkthYWgvU1hxamxUYURnQjhhQUNY?=
 =?utf-8?B?Zm95ZE5vMzZhNkdOQ0pGVDRkWTVJSVowZUlNb1ZzMWZFUFB6UFdhRitmS3hO?=
 =?utf-8?B?T3RSN0l0RTVzWTliYnE3Y1BOa241OThnZ0JQOUlReWZnSkRrRFhaRG54NWFN?=
 =?utf-8?B?S1o1M25Xb2hKM1JBRjVaRzF6WW9VbFVjcmQ5VllqUlUwZXduZGpLMVhleW9o?=
 =?utf-8?B?NmRtOWltc2lDOGNIRjZTVVNCZmgwV3RWeENWVmMrRk9TQ1laL3hQN0JISVN6?=
 =?utf-8?B?b3Y4amFyaU1vYnF0UVc5SlVvQXhaVDAvTlUvMkdXRy95d2EvZjlFYldPZWtN?=
 =?utf-8?B?UUdDQ2FBaGZTZkNNbHE5NmZYUWNRVHo0d0dERElJREZyaCtPcXVOLzQ1SjRj?=
 =?utf-8?B?RU9mc2RxY2Jma0tRQ3V5ejFqM3Fnbm1NRjVCV2hEY2VTL01pMytxT0x3SDk3?=
 =?utf-8?B?bThRRzJ4MjZXRUtIbFZQQ0V5Qy9wUXovNjF3V3lxb1RMbDk2MEVEVjZmdXhN?=
 =?utf-8?B?RDZ1ZDRIUFdCYzFRZXg2a1hoc1UvN3ZIc2VoUEcrN0wvZDVDOVhRTUxORndM?=
 =?utf-8?B?ZzJoK0VYazZKRjZIa2ZmMDZYako4STdoSVpPcjNuVUFtOURKLzYrN0pLeU5u?=
 =?utf-8?B?bmFNcXFQSUZxK3RJU1dpUjNKTmsvRlJnQTN0QjhMOEtkZ2g1dUhPeVFLbXht?=
 =?utf-8?B?QjB0b29lM1l5eG9yMmhVZ2kzUDJXcVl5anZJQ2tqSExFY2NKeU1zUEw3dWpS?=
 =?utf-8?B?MzhSaWdUOWZkYkNwQWd1c0l0dFNHYW4rMStHM053VDVMNXV6bElWZldjeUlU?=
 =?utf-8?B?UnU4L0VkTFdrK0xyaWxQOVRMVzk5QjdaSTZubENjR0t4Z3ZTc24rSzI1SlZS?=
 =?utf-8?B?QkdxWG50UWRncjljQzkvL0FYTWRFSS9TZ20zaHZFVFlqdEF4bTJpZmFZRSs3?=
 =?utf-8?B?aDBYQkpwNkpwaFRzbjJLc2pEUnRDVmsxRTY0TmJhaFRXcjIwc3JoVGdwUmZ2?=
 =?utf-8?B?TU9lMEJLN3VHMGpGUHpxczRzc01LbGt0N2xTNEh3b3FGeGVzQXBGeXFSZmVw?=
 =?utf-8?B?clpCL3ZVSHZCMCtMVGtBY1o5MTZJZlBlOEFqUW1OMTU5M0tDTFlwMVNxWEJ3?=
 =?utf-8?B?djh1T2h0aUZSa3VjZCtMeDE3SXJFTldrZFV0Q0NRckMxRlFEaEx6SFRiankz?=
 =?utf-8?B?S2pzTXBIRlNHZmdwREJGRU1FRTMxckFXbE8zWkFvMDcxaU1KVDFzZ2xhQ2dT?=
 =?utf-8?B?VmNpclYzQmdMZmFiU2JFWmhiWUdMRmtTR1MycndQKzZDTHoyM0lhaU9aWTQ3?=
 =?utf-8?B?WmphNElTZS9xUC9kbHBKamJVdGpsb1l3MmtmWGlJT2R0MVhHR3dHL2l4eXpL?=
 =?utf-8?B?RzMvZEthVnBydUFzajNSeVpaeXZEYWdUQ1Q3a0hCWjE3SkRmbkNEc2QyQkxV?=
 =?utf-8?B?QzJFUG1weDIxZ0p4NXBkYmdHOUJPTXo4djdmajlsb3hVQkkyQjRZVVR1M21t?=
 =?utf-8?B?eUNjUWQ4NDZqZW9ieElWMDF6WWs3NTFXRHVlTHJhZzlSNlNkMXB5WEN0UEtq?=
 =?utf-8?B?Tlh0QW9od01JSnhvcTNOYTFmaHdPajh5YVdlZFJ6T3BnbUZUQTF4anVUQ3Nn?=
 =?utf-8?B?RUx2Rlk4SVVpK1k5czdDVCtEazNJVGlRUTF2Z0hFVHg4bWpuVmFFSTQ4NE80?=
 =?utf-8?B?VzNkVm5na3BqN1VPb0hsUWFqb3Y2bmNsMTRxWTB4dzlhVGFKWDc3MHB1eUdm?=
 =?utf-8?B?WGYwVXdnY0pRZ1ZxQnB1VlprblNaOGxhNE9ucndFUW1mSloxN3NhVnVwb01P?=
 =?utf-8?B?dVRmWkpQNkVNaWZZZy9YcHRaUXVhS1BhVEhRa3hWS2szc3grM2dTQ2N6UmIx?=
 =?utf-8?B?RURQSjJSSEkwV0hYQTFRNmZRTlpVV3krTGJwOEZ6T1dzN1lYL3RsZE1vN0RJ?=
 =?utf-8?B?c1Y4MGh5YnRtUVpvVncxTXVRTVRpK1FueDlNK0pzcm1UQW9OU0VXNUt6R1pC?=
 =?utf-8?B?Z1Y2TTlORXhpUVNWZEFXaEhTNit0enkwRFBaWkNmbVhRaHprUUR2NHFIbith?=
 =?utf-8?B?YVZLSHJJMlcxQUk3eUhQRlBFbW1xZTd6dGpuVnUyK0pObVVGMlhRTDJBNTYy?=
 =?utf-8?B?Y1ZSQytlVDRhMmlaL3YwVmpGODAxNC8yNFVkMUZ2RHp3MDVjcmVuWmV0YkdT?=
 =?utf-8?B?TmJCVlE2SEc5MExaQitzU1hVQVhnbDE1U3RGZWtuU1VMYmorMWI1c3laY3B0?=
 =?utf-8?B?R1NvMkFsZmovS2VBZmVEbm9VTlpnc0FUcGZTTGJ3RlhxdUJNbEg1dz09?=
X-Exchange-RoutingPolicyChecked: lVq9L9hyCYKmp0edsIh1Vh9kwlw2x8Xc1Dl80+PkJcPVN7yocHp9XuPDJE25Wy6mdve9Uw9xxZt1NFElyJwsfw+xHtMXCL9ZX9Gn+lbuc9ZxYmHvO7Xf0cO8HJor0IaEjFJn1k6rtcnVfIZWs5Ul+tbHtq6UY2KS/1vbk/iSeYdDcQgjYvAyi1VylMgOoZU5D/PBuUkgyzaYqxB9feFARM+y0N8eFACO0/QlfE24IRFM7z9LaA0iiXHwE67zJX4+mSqS5M/Gh+7etmUL40dqm6j0KCA1rTqOh6JjB8/PzhOUW9Ut0NaNYXvl4meqnbmbq7fWB5dQkCIeTaDPoBZEQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c0d8a9-0174-4a70-7967-08de9bf9ca07
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:50:27.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53+/G2i2DqRYV8+p/dXDGD5qOl1SJ6UA5C107JbcPGBXuHpNjPTrwUvCLifFK3snzF+p8tlQFcNVflwn6K/BOGIhf/fsxq7CvZBSZ5z4ImU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238366-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CA259414BB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/2026 1:46 PM, Jacob Keller wrote:
> On 4/15/2026 9:20 PM, Przemek Kitszel wrote:
>> On 4/15/26 07:48, Jacob Keller wrote:
>>> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>
>>> After ethtool -L reduces the queue count, i40e_napi_disable_all() sets
>>> NAPI_STATE_SCHED on all q_vectors, then i40e_vsi_map_rings_to_vectors()
>>> clears ring pointers on the excess ones.  i40e_napi_enable_all() skips
>>> those with:
>>>
>>>     if (q_vector->rx.ring || q_vector->tx.ring)
>>>         napi_enable(&q_vector->napi);
>>>
>>> leaving them on dev->napi_list with NAPI_STATE_SCHED permanently set.
>>>
>>> Writing to /sys/class/net/<iface>/threaded calls napi_stop_kthread()
>>> on every entry in dev->napi_list.  The function loops on msleep(20)
>>> waiting for NAPI_STATE_SCHED to clear -- which never happens for the
>>> stale q_vectors.  The task hangs in D state forever; a concurrent write
>>> deadlocks on dev->lock held by the first.
>>>
>>> Commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no
>>> rings") added the guard to prevent a divide-by-zero in i40e_napi_poll()
>>> when epoll busy-poll iterated all device NAPIs (4.x era). Since
>>> 7adc3d57fe2b ("net: Introduce preferred busy-polling"), from v5.11,
>>> napi_busy_loop() polls by napi_id keyed to the socket, so ringless
>>> q_vectors are never selected.  i40e_msix_clean_rings() also independently
>>> avoids scheduling NAPI for them.  The guard is safe to remove.
>>>
>>> Add an early return in i40e_napi_poll() for num_ringpairs == 0 so the
>>> function is self-defending against a NULL tx.ring dereference at the
>>> WB_ON_ITR check, should the NAPI ever fire through an unexpected path.
>>>
>>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>>> Closes: https://lore.kernel.org/intel-wired-
>>> lan/20260316133100.6054a11f@kernel.org/
>>
>> Maciej developed a better fix for the problem, and he explicitly asked
>> to not include this patch. Please drop it from this series.
>>
>> Maciej's fix:
>> https://lore.kernel.org/intel-wired-lan/20260414121405.631092-1-
>> maciej.fijalkowski@intel.com/T/#u
>>
>> ask for reject:
>> https://lore.kernel.org/intel-wired-lan/
>> PH0PR11MB75223C8A00C3183C5082A096A0252@PH0PR11MB7522.namprd11.prod.outlook.com/T/#mbac55f7219d7855a2e5d1527904b2da43ad080cb
>>
> 
> Ugh, sorry for failing to notice this when batching this series up :(
> 
> Thanks,
> Jake
> 

Jakub,

Can you discard this patch out of the series when applying? Or should I
go ahead and send a v2?

Thanks,
Jake

