Return-Path: <stable+bounces-223010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF60GQ3jp2mrlAAAu9opvQ
	(envelope-from <stable+bounces-223010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:45:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285981FBCC6
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC25E3046D37
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3438239E;
	Wed,  4 Mar 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9EJ+Ge7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A337F8C7
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610307; cv=fail; b=kKrA9XnTqh+/IwgT6j3C3/+RrvB4QS04ayyC5vMQ7nz0X+IpKEqO28zdFd57VTPmmTL7kFeuLnLUfocty/+QTBHxlfDksyqv77+UzbKIQk7GUH1cqkdjNgVDnIht/J2MjA0CBCSMgSxRtrgvWfY91zQIM0K2+ZKVY/+wp9PQFVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610307; c=relaxed/simple;
	bh=AgzdTnLQCDKPUkkOzEN2EcCh8DlZHiJTp0ADI22NW6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TlzejfUf2NdOmyvCPZjbgZ7XdMdIImq+deN1OeKh8uRERuTgEWUYZdlJ7Yw0m42tgP36GZBlLycwS5iF82B5fqZHP2HpCXos0fUbQapxCV0ID8d1NBrGJabIlenF9+iAPsBUyP9UJEwQ9zqasEIBcSaZnM6didclFrImN7Bbmjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9EJ+Ge7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772610306; x=1804146306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AgzdTnLQCDKPUkkOzEN2EcCh8DlZHiJTp0ADI22NW6U=;
  b=a9EJ+Ge7STF9U9CTBj6RUbu5O/yxudW3id1qf1QhqEQB5r5oIBpq9rM2
   tHkUukWceuWM5s5iX6UWh7JhkC+MqFrotdhxPL0BmO0MixRgfsT8QzR6S
   QK9c7h7GC4aFDpdewzRougAJRDh/ZA8at7PoZpvmQx5juxcxdRvcsUoEa
   /OxTI/spZjhtYgWsGqRhPC+28DMAKddrrUupt0QCAiYKBGQdmMhp2kZYr
   XV+ZbHqMkDtKRCkMUBplO+AzCGFS5D1eai60JyVQYzCjXFOIQp6IF8JqM
   eYXk87nJAbEawHpx9zpyMUAVh0Vy0Y+YgfHNP4sHjxyJx7zzRw6FWuEcH
   g==;
X-CSE-ConnectionGUID: QLlA8V8cR/iffzfryVNIpw==
X-CSE-MsgGUID: jDmVb7voQ6GKBYheSS7O9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77533159"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77533159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:45:05 -0800
X-CSE-ConnectionGUID: ZoZ1k/T0QEWuRpoB8lRTpA==
X-CSE-MsgGUID: qUkrlI7NSiil1lda0AmJCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="218227256"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 23:45:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 23:45:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 23:45:04 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 23:45:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouA3yYhW0W5ot4/aPmEtrEzdgGW+ttiqj91Vv20wkuBPJGtkYJ8GfHUxM/vvKKe5yWiH4A9VORElYSWf+CQvfuA1aCJtljFAe6gjAHwU2j6hjjFCM5SqV4HQu+70bkvQXe1EZmkEJmfKGJfQlylknMtjFEVY6wHSse377XMA/QLJvY2ECpEwCmkzjLHm8OIBbL3lf56YDvBmDYPgqadvVLaAs9LOrrBgRn/U9ED0dxyNo+1QfGR+GnLy8sxMhNZmc+F6rrF1IXb0h50sBw+rCjJQ0EVXonKp5RRNLAOoppoq85dg132IZGLJoJBbcz+2ACH4OICF6jhoFxpbjCNxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJO8EZNzofDca9kM3KxyPCU6/ndGtal03GtO15rQF3Y=;
 b=QK94qXPxLKTxedeVC7KlXDTZST58dNgsQGqJKrs//IWo1Bxo5umg5y6eeAQCRy53U2ZNimvg5DOHKnYNCRecYGJfQksMYYTPpi3Bx7u9Sl/1kc6Pjz+eLg2AQbvQdU8hXGZ7C0M6OfXcTiTGKBQQre/Xxl1aPsZ435Om3vxjYExXHYMhYUANHo2C2PKa3TXQy9OQWdB/lvWiSUaPA4IbQC5IvuVZaPgl9kqwgqKPKJRAgiU6JKu060Bq0+IcWhoAN1/g0WBGluV1m0WfqjtD1dM3z9MP3Btt38a6iFwmUeMS3qSr5QJu2cUGTxYQia3SG71fRGawpQWZf2yBeB+NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22)
 by CH8PR11MB9484.namprd11.prod.outlook.com (2603:10b6:610:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 07:45:03 +0000
Received: from DM4PR11MB5341.namprd11.prod.outlook.com
 ([fe80::68b9:ea3c:8166:3cc4]) by DM4PR11MB5341.namprd11.prod.outlook.com
 ([fe80::68b9:ea3c:8166:3cc4%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 07:45:03 +0000
Message-ID: <8eaea8de-23cd-48ca-81e0-896815adfbb6@intel.com>
Date: Wed, 4 Mar 2026 13:14:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/i915/psr: Repeat Selective Update area
 alignment
To: =?UTF-8?Q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260303125409.503148-1-jouni.hogander@intel.com>
 <20260303125409.503148-2-jouni.hogander@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260303125409.503148-2-jouni.hogander@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::12) To DM4PR11MB5341.namprd11.prod.outlook.com
 (2603:10b6:5:390::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5341:EE_|CH8PR11MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc20c9d-7d1c-4f20-4323-08de79c1f1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: pvuvmqWdKrLmQ6ZUR+5/kPvlQDBK2I0cT421+QtbsJxQm9vN0ehK4+txfhCyc4PWk1xnNoGK83RW7IWS9q5+CsnKRlsq+Be7ZuDBVWWJXxpASr0RBOfyHk872R1w5YvGvBcFIZKriX8c1Th9uU7zi95CKgNKiC2b+Dr4PXp3RZ4LITtx6e8EayR1AiDnYqS3gSZ0RLFl2Jn7nfu1RkV6hyLFocGC4HSZttQzqtzfLPGwk793Tr1qUbXK0GrpPWnZW82ECBwZMu69L0ZSb6ubk/r1OCgchu85oeyWvf/sZrnxcQbK+XuIHcBpTtg+40IdRn/GSC1a7WsUNbdXkaXMfhMrXsP2yGpTr+DJXpyw9ODp4q/1PzGoavsbh0D2qsxMT8JfnWxQWRBpiJFvuPz9R9m+3W+xTHcEGDjTUs5xhNEwq7nJ+2caVC5BG4Tcn4z+gWfnJPNxCOa+XJ/lKH6Jeg/spD6NCdKL+IAvFfSRKErKJC2Xgk7/L1mvrB7+g0UYra9Lj5dR1zKxwL+hgeeJhYYYtBrU02DWzx35cEicYPuQkCr8MvRH41ew+K+3y1y3AQb7rH2xObDpUbR2MLRVG5qHv6TKlNoi+rL8CKizh3K22LCT2jD6sdNmECTrdRF8k2jywiMWsG3466x6/WlBXnCb7CgBD7ximjrNNdahL0yDJBJImWLj6SQ8ofRp7hOlQ7uLNnNRHkYkVGdqK+PuESQYQ4sNJRtIuzmOYHNnF2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lUV3NJZWJES1RERU56NmJGVlFaZE4rSjd2cE9JNWM5OTRMbEI5VUptRFVa?=
 =?utf-8?B?KytzS1NueTk2cVJwUmlxZVNOdW1CNm9BbnlZNFI4Ti9oWVdrRjJoTUoyWVJo?=
 =?utf-8?B?U1JHbTJKbEF6d2JRYzBiRDl5bGo4dTJnVld5NHhwbFp0cFFER2U0RE9iODlQ?=
 =?utf-8?B?VGlNNzdkQWhRMG8xNnNuY1g3N0Z2MGM3SHFMTFdMMnBQbXFMbFVJQUEvRkRx?=
 =?utf-8?B?ejlIMU8zTGNvdkFwdnRGVlN6Mk5IbHRqNGtYWWFjelhQcXJtQTFLRVp1OFEx?=
 =?utf-8?B?eEVyN3pxYUdEdjEzUDlpam9ESVFFeDl6eUxSbDYwYUVHR1pkSDFlN2pDV1hT?=
 =?utf-8?B?azNvTEpOMC8xQTRMcmJQL2NSTmNTT2twNEVJUWFoOTlBQlZ5RFdIVmhMM0Y2?=
 =?utf-8?B?bmQvQXZNK3k2YlBlaGpTN2xBRWZER3MzRXBwYmJLcmFLNktiS25icDNWNkxK?=
 =?utf-8?B?K2FrNy8zTU1oTTdRcFlKTzM0cGkxQ1NXeGhvZlBEYWlBOS95UzRFQm9kTm13?=
 =?utf-8?B?N1JteXBHaXZtVXBlYUxqRGdBNVdMQzNUMHoyeTVkVkhGcmthUGNHbDgxS2w0?=
 =?utf-8?B?SElwblZNaEttMWV0WmlmblZwS2hBRmJMWC9tWUZkQmduRVRkQ1FzMDZJSFpa?=
 =?utf-8?B?Y3hIUTZIZ0ZMZlh3Qk8wTE1TUllQV0NOSC9ZTW1LT3VpOEVpNE9PUkY2c0Rs?=
 =?utf-8?B?V3ZubTB1RHZ5NmFUdnlsc3luTnVYK3I3M2JOd3JWeDdmYlBsdzhqK2g3Tzk3?=
 =?utf-8?B?VzBmcHQ5NXhyWGZWUFk1WGhzTzg3ejBXMWdRb3VvNnFTK2xPRGdOdERIcHBy?=
 =?utf-8?B?eDN3cWVFRG9GUXhiVDhPVHdQVVFZeE5oa3FQUHZRZElGWHRxckJmSzZVVjNG?=
 =?utf-8?B?eE9jVnBqVWF2TGFlQmpJL1dOY0hjSHJxZ1NneXBxckVBcjI0K2tzcjRUTExK?=
 =?utf-8?B?RFdkZVlpdE5tNnZPMkF4Y0htdE5MSWFzUzZKVEF3VmtJVFRUQkcrS0NWbTdD?=
 =?utf-8?B?OXJWWEQ2SUNHTS9sOTFrRnhaUnJnN1h6S04zdnF2Vmt6Vmh4KzJlVlI3VkRT?=
 =?utf-8?B?eXFnVk5sRVgxZ1VNNTdmQnYvQjNiT1E3aG5LWHBySFhkekI3Q2xjNkVwOXor?=
 =?utf-8?B?VEhnK1BVZFVFbHdGRi9NclQyOWJ2N1hYK0FBOWRDR0tDeUJRY0QxQ2tKNno5?=
 =?utf-8?B?WCs5SjMrTXlnN2dPU0I3OFBUUlBQclF2VVg1eUVLaHdyZk9LVkFEQ3cvdVc1?=
 =?utf-8?B?dzJYM1pqZldQVXFEYk5pd1VRWkxrOHFhVFRtaXVXNjBKMnJhOXc5c0ZSeXFD?=
 =?utf-8?B?dFJJWWEvVllwbnY4VVdHZnZESHY3dGJSZXRVM1h0d2V0L1hGMHNWTjg0eTV2?=
 =?utf-8?B?STdQUjk2VEo2Q0swaURNVUhvYVIvRkY4bjRmWGFnMExmQUdaczRGN245NlNJ?=
 =?utf-8?B?TVl2RUZ3eGdDK0Y4eGNueWR6U0lwblU3OEhGL1MveEFhL3R4cjlxcXVYajNa?=
 =?utf-8?B?cXNCUlBQNVhJeEMrVTdZVFVOWWFUNFB4Wlg4bWdndm1NaEVOYjdicU9mY3py?=
 =?utf-8?B?MHVMQnZhSmJFdy9IUTFNMDA4VkpsaHdKU3FyQUdCQ1VRbzlta0lxd29JMHhy?=
 =?utf-8?B?bnR3bVpCWnk1ZERNNDgvNnlvRmxLMW9uNnZCcDkzc0dVbVVUUlpZd3pzV08r?=
 =?utf-8?B?emluQ3pCd2pKcnhkN0pZN2RjOCtiMlNudzl2MGdtMVdRS3Z3RjZwNHRtc08x?=
 =?utf-8?B?REFQSHBvSWtDUVAzelhNWEtNQnF1clZzYUxiVkxzVUVZSHVUM1ZXclBYUjdZ?=
 =?utf-8?B?THZpY2ZlNFBUUTUvQ2NQVjd3TGo0RmY5SVlGbVNNWDRNNGpEZGd1aDRNajRr?=
 =?utf-8?B?MGk0cjI3U1Q1REFxaktXNEI4bDMvREVBb0hnY2Q3aFl0SUNCRkNEVzlRNGN2?=
 =?utf-8?B?bUpzOEVMZUQ5azhqVVppVVJUOHhFYU05Vnk1R2p6VFZ4eWxzL091RXlHYi9B?=
 =?utf-8?B?bnhXRW9hNTVrM250RTI1STRtUm5rSDJ3UThvOTZua3BCeHo3NG1LNTZBUi9x?=
 =?utf-8?B?Rzd4MDhIT2VOWXlGRUpPWWFCZ1lhRFh6L0tQL1pxNXVEbHdVZWpDaXpyeHNQ?=
 =?utf-8?B?YnZJZGNhUy94T21qRXFpSWJIZUc3OUk5V2poUGRHekJTUlczNUpkamxVT0x5?=
 =?utf-8?B?SGM2SW8rSkRDVGkzSnRiMU9tV1JrUHRLdC8zSjF4TCt6a0VzTU52QklWMDJp?=
 =?utf-8?B?K2h4NkdwL3ZEMmpyK2lIQld0QVFpRkwvbnQxWXRIQnRDYXlVNDlVOTBBU3dY?=
 =?utf-8?B?OG9jamEydU5vb1hyVitTcFRlZCtUR0pPSWxya2lJVWEvcS82NHp6aVFKYjdp?=
 =?utf-8?Q?Y6/Bc8Al1K6t8rGU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc20c9d-7d1c-4f20-4323-08de79c1f1be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 07:45:02.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jt0hZJG4kVgVi7G0+t8exBrNgY+bbsIMDicFtO3pocWlVB6/isO1uHSTuNORetxJA5TdFWnU7oy1WDWULKOOKYNiRO46YTujJF1QavZ4bW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9484
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 285981FBCC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223010-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankit.k.nautiyal@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 3/3/2026 6:24 PM, Jouni Högander wrote:
> Currently we are aligning Selective Update area to cover cursor fully if
> needed only once. It may happen that cursor is in Selective Update area
> after pipe alignment and after that covering cursor plane only
> partially. Fix this by looping alignment as long as alignment isn't needed
> anymore.
>
> v2:
>    - do not unecessarily loop if cursor was already fully covered
>    - rename aligned as su_area_changed
>
> Fixes: 1bff93b8bc27 ("drm/i915/psr: Extend SU area to cover cursor fully if needed")
> Cc: <stable@vger.kernel.org> # v6.9+
> Signed-off-by: Jouni Högander <jouni.hogander@intel.com>


Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>


> ---
>   drivers/gpu/drm/i915/display/intel_psr.c | 50 ++++++++++++++++++------
>   1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 5bea2eda744b..7b197e84e77d 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -2688,11 +2688,12 @@ static void clip_area_update(struct drm_rect *overlap_damage_area,
>   		overlap_damage_area->y2 = damage_area->y2;
>   }
>   
> -static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
> +static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_state)
>   {
>   	struct intel_display *display = to_intel_display(crtc_state);
>   	const struct drm_dsc_config *vdsc_cfg = &crtc_state->dsc.config;
>   	u16 y_alignment;
> +	bool su_area_changed = false;
>   
>   	/* ADLP aligns the SU region to vdsc slice height in case dsc is enabled */
>   	if (crtc_state->dsc.compression_enable &&
> @@ -2701,10 +2702,18 @@ static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *crtc_st
>   	else
>   		y_alignment = crtc_state->su_y_granularity;
>   
> -	crtc_state->psr2_su_area.y1 -= crtc_state->psr2_su_area.y1 % y_alignment;
> -	if (crtc_state->psr2_su_area.y2 % y_alignment)
> +	if (crtc_state->psr2_su_area.y1 % y_alignment) {
> +		crtc_state->psr2_su_area.y1 -= crtc_state->psr2_su_area.y1 % y_alignment;
> +		su_area_changed = true;
> +	}
> +
> +	if (crtc_state->psr2_su_area.y2 % y_alignment) {
>   		crtc_state->psr2_su_area.y2 = ((crtc_state->psr2_su_area.y2 /
>   						y_alignment) + 1) * y_alignment;
> +		su_area_changed = true;
> +	}
> +
> +	return su_area_changed;
>   }
>   
>   /*
> @@ -2838,7 +2847,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
>   	struct intel_crtc_state *crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
>   	struct intel_plane_state *new_plane_state, *old_plane_state;
>   	struct intel_plane *plane;
> -	bool full_update = false, cursor_in_su_area = false;
> +	bool full_update = false, su_area_changed;
>   	int i, ret;
>   
>   	if (!crtc_state->enable_psr2_sel_fetch)
> @@ -2945,15 +2954,32 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * Adjust su area to cover cursor fully as necessary (early
> -	 * transport). This needs to be done after
> -	 * drm_atomic_add_affected_planes to ensure visible cursor is added into
> -	 * affected planes even when cursor is not updated by itself.
> -	 */
> -	intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
> +	do {
> +		bool cursor_in_su_area;
>   
> -	intel_psr2_sel_fetch_pipe_alignment(crtc_state);
> +		/*
> +		 * Adjust su area to cover cursor fully as necessary
> +		 * (early transport). This needs to be done after
> +		 * drm_atomic_add_affected_planes to ensure visible
> +		 * cursor is added into affected planes even when
> +		 * cursor is not updated by itself.
> +		 */
> +		intel_psr2_sel_fetch_et_alignment(state, crtc, &cursor_in_su_area);
> +
> +		su_area_changed = intel_psr2_sel_fetch_pipe_alignment(crtc_state);
> +
> +		/*
> +		 * If the cursor was outside the SU area before
> +		 * alignment, the alignment step (which only expands
> +		 * SU) may pull the cursor partially inside, so we
> +		 * must run ET alignment again to fully cover it. But
> +		 * if the cursor was already fully inside before
> +		 * alignment, expanding the SU area won't change that,
> +		 * so no further work is needed.
> +		 */
> +		if (cursor_in_su_area)
> +			break;
> +	} while (su_area_changed);
>   
>   	/*
>   	 * Now that we have the pipe damaged area check if it intersect with

