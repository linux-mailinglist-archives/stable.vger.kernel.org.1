Return-Path: <stable+bounces-230206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCpaDe3NwmkBmQQAu9opvQ
	(envelope-from <stable+bounces-230206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:46:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D3931A3E2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 536293042DA6
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9F408223;
	Tue, 24 Mar 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDYxKjTU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895540759B
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374242; cv=fail; b=AR7AXMztdfQ7N1hfkBL/CvMsoMWrqGMWrYduZgH5EH+8F2rR8W27tBU1vHNrhPZs6IRQDpMfaUcuOLkTs75SVCjQinkczwqSzdx9mUCE7s9qJg4erNTbPeKGqK1xpAS5zkwoSRUBNSzMi7+7UI7N75UBUIU4MYyjBhSeSK56bc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374242; c=relaxed/simple;
	bh=OPpZkljF7fWUAfBwsZRGq6I+rFC/Htsa0XHpzE5BIIU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OW2OfvEFM3x3b1VFy3eE6bkUJHh57dO2JScivv8Sq0BUvJZ2WS/mfITOCYuNwoXYXgcI6MXq8jLyvQCPi4OAJ5E9a0SoiSjRd6OKodU998JPJXCZrI3jEPgViZFODC2z2saJMDfbO6lNmaEEDNUvIVnJ2THd6EXuHdv9UfFAyF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDYxKjTU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774374241; x=1805910241;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OPpZkljF7fWUAfBwsZRGq6I+rFC/Htsa0XHpzE5BIIU=;
  b=kDYxKjTUu9PqexrRC/o2M153Kk/JzlHKe0kDlqnkdiqpGqKJG/uayQZR
   yoWyQ+h8Dytci8whFevMPHCqRywHTnxqnG/aGKU5HLgUAZW6U3ZMdn2Bh
   XsaPJ1RtLow8P3s5Wf5ffwdzQBbkXTRfT87d2LsWAa50FdWYb1PogzuRm
   GzCnHfJPouAAs0ImluPiUgXpz4y+8xHi3ZKJuAFWn4c0RKWV8Yz28+ibG
   drZlGzwvudNS6Ffk0M+lUjCGz9wMhOmDdkexLKNwa/+eRCWcM8hgL4A+L
   pMt/HD501954ZyiXOuT87hLH559Z7KLtRkeG2M5+FyltEBn1I6omPd8O5
   w==;
X-CSE-ConnectionGUID: M5UhfYCaRZqvQuuuQkHQSw==
X-CSE-MsgGUID: M8Jy3fZgTJGEjGLzn1WjFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78003447"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="78003447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:44:00 -0700
X-CSE-ConnectionGUID: tQVsyq/oTf2mRsPh2z52QQ==
X-CSE-MsgGUID: yUhdmqfhQyiskbKshzD6eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="262353443"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:44:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 10:43:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 10:43:59 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 10:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bggKajeQvkCL77JgP2ztEGNY9RsMn1Kzo0LX/h3h3Ho6Vqd+XPwOoKQhADJ+jsRIZjGhLHEHkFykbycmdx0Y9eUJuU6J8HT6m0Ix7RC7lCkM+0JoJkFbjnxUlkeID/DITLtEQSWUCWw9P5STrXKh/7bZCAJwvziXfsGpPQgKgrVT1eBCq1IEDhT4xCtdrmjlyuOOIqKrZ1gSzHzkJDetKhDYzBwQ8vs46FGFqlAN7j1eHkzOMkuDNZc8ZGFHigsOFZE92JmAuhXjXJxRig5NEpHMF0WgaQGIAwJNxtAren+O03dhZ/LX2fsHarn+JAXKcwKUCuKWL8Pj0heT6VqFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6bqzzRWivNn8YlWW7j2Sxk2DygIImaf1kpZLZ0r2Oo=;
 b=kTs7S6oG7hb4PQ881/M2/4AXNQLhP8RQDeubF+wlfY7c3R9M3pfo2X8dyrwO/6puBYOvXXMxjkQK0bO+3/Z26ZOhO6mz3LfueMTj/M83xfErbED4TI9ExbZmLOezBRVkMw65k8oLA6cPqOLJaU0QldEznnK/7SDvHTac2i02RPU79yhLMTwb2cWYZ5cbJjTfOKaUYMpmfbVg8ouN/B2eC+g1Q30y4iPtt0jsi/6Oo0KbK4NOBu5OYI3hxJpdRKbRYiFQkq8aHWTY7orP4SmaLuB5+36vHvBmMyDi7+3hsXfC7y7veFC+ZbBPqkaXhNXox99EaM8qx5ukago1fumyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:43:56 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 17:43:56 +0000
Date: Tue, 24 Mar 2026 10:43:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe: always keep track of remap prev/next
Message-ID: <acLNWIciv5Igz8Ye@lstrano-desk.jf.intel.com>
References: <20260318100208.78097-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260318100208.78097-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH7PR11MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 089a5c6b-2b1c-41dc-c679-08de89ccebe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UxAV3e+lAmBe98Urr2hYcXNvJuFiSatYYnPyTW/xDm//ZwSCFyRfGzLatAMNXxI4QMkd5K23cMkVbD7HkS+oR60pDEbZcsfKFUjOn3jri/mAqAxF7k00iXk6FRl799/JB5Zqfa/5vC6BOsyiqsjLJsI+P/MHMBm7ijo2119++q1YIg4p0f1V60zEFHeiU2G0OD8aoXrNcJnTxuINdcy4bnKVXrL1bnRv625xJluBtQ33EhG51QoS4UqIOVOAmYHypu9jy+rR9fFbh1vsAdLBDGQpX29Sq7I7+6Gf8gamh6RMIHGWLTyWjz7rhprtKiJozLDmgrWk3lN2H6GY5UFZ3Tv/cJ06EMyMQUZm3ik8G4doalF0iuoz+DeZmrDkLBKZ4SsIC0REx0RMPHHN8xkyf6hZSl5A/sHl8EIf9fbFXSSZBWYFaKsIjrK9FBwWcaeyWHo+4dKzCGWXq7sJwRkOdD+OQBGeS1etCE3o59u0G34f/UeSXM3GDwZ8WLWC4W/eAHZUaCbm/joBE4ihSGfAkPZSAmLNROoff8OuIeWL5ZVj2OHYLrE15VLx2RxKrD+TKBaynYlG8+GVce3UB8nhClWrE/MRIf+K6JRxVs39c9MplFpRuDeMap0nyc+JuRAGB6/ZuqWdFJ0usRGQuqQEZULQz9x6mSfIeOaYEL+g5xuauNdLCSD5i84Z8l6d6mtF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3C3YmvYPRjESETlArsHMNbIdLp/HZ4v1iPDl6rtcBsqSXDKqjf840Hdk43/s?=
 =?us-ascii?Q?HasHNvIgBN+cpADVq244ClMjgmsiyuFjs2IkETl+KIbbny4vPPlUhVM1ZXFN?=
 =?us-ascii?Q?6F2mHXn+giwlYD7+7zzy0VWUtef3U9y5aOcenfPxtNt9aW5tHrQ7mZH312AZ?=
 =?us-ascii?Q?BVpYWD2sE3EPmoRALw2DKMHParPnIiP1sUkOqxQIc8g+C9g+62DMyu5d9xvD?=
 =?us-ascii?Q?P+NYmYlAHHOED6s0xeMCzZe4pqSFSvBzpfGyYueb4NB64XjD6w6GHwxPhZUx?=
 =?us-ascii?Q?803XHrxTEWhfXfmbhvlpYkCh7hwpGqH2x+PoPfxsC12p1qdUxnia/UT+UhKs?=
 =?us-ascii?Q?WFC41S/SO/z6NvpUNOf9tMeX/UDWs1mRAzBrit4w8Z30N7gnYqymjKRuAyIu?=
 =?us-ascii?Q?+Ym1IhaiipedAymSFqlDY0tP3DmsgrpqsfogD6G1P2psLNsD3I/uRbIwnOzR?=
 =?us-ascii?Q?fzvddgP7Xv7fG1Qh+Ps6hHZ7wWWId+JxBFHRWUfaTObnsIK+ZKv5h0VOK88d?=
 =?us-ascii?Q?YiSyvhtGnuwRiYh0jJ145vcTLDf+qJGnhMhZ9xPQ5yFjZv3xvlRGFyTecYuJ?=
 =?us-ascii?Q?TG+qbPD7D2ss8XOKKba1FkYw41MOHO+QNCiv+Lvipn/skTHaghneyxrcSLlF?=
 =?us-ascii?Q?ExmVJIg70qCw663mRqi5ATQ6wFgVjr9cFvCzT4Id8fIP1uzexUozs0rCiB4K?=
 =?us-ascii?Q?SLEUGxFxaL2qkwMOE666RsSn4ZFcLawQjQ5/H7xkeIPh2u5PaVCIP73aAOWi?=
 =?us-ascii?Q?EQTKg2B/ouuPLGHkXWVh61l3HzO8cnNuOQtuinlh3AbUOSn/6X5FTEAobpn4?=
 =?us-ascii?Q?YdHy5lZPfeOU+CaY8dIuGmUrAay03NkcNts15HL9q14JK4UrV8EV5iIyO/0C?=
 =?us-ascii?Q?WJwqLPCG9DPasWluSyM7EFSg6bf4shOj/lYeBXXIzW4rqT1ZgZ11cioLI3z1?=
 =?us-ascii?Q?DEKEzhUQGgsCeNYoA+lcLILVAUR7bW092ratPvD4F1RtKK3+ve9cppcPzxnu?=
 =?us-ascii?Q?YvA58VYZQlB77T8mejman2w32vnhpZCYbKb+kUKuJQxz0kmmLV8W6vL4rRLk?=
 =?us-ascii?Q?0ilJ0WAoLS4/bko/cATOULjL/5RUYicLXx0iMf72WfqF3mvvCdFQgrWODium?=
 =?us-ascii?Q?popk5dZ99wLArAgpsUr/tM0egBKPoZI+wHThrJbFvNT41Mz4rNcJmPTZz2O7?=
 =?us-ascii?Q?zXwtq5mMeRO96Sht3qCe6V8HqmxpsvuWv+8RA0cDdZ8vpxXicq9rjoPpm+kF?=
 =?us-ascii?Q?dT3lof4LPkPDVkyS8iuwjflvIJYdFXcK4eKO3qNLmEklAqnFDwpdhwPmBBrS?=
 =?us-ascii?Q?i7wkVtsMb5XkpaAzh1C01V0EQs5gT5G+SFU+ByP27fnDrCbgcbB3h26VF5Mg?=
 =?us-ascii?Q?yNs4IU7C/a/iwOz6VO2I8QNX5y/jPDVfBNCyK4JJCjqWtoPs2CBKQeR86JLW?=
 =?us-ascii?Q?5gJYvvSR41v6rLG0m7WU0odjWrsA9wQKLfFnn2FNpz0lShk1p/iG3wv+HMFK?=
 =?us-ascii?Q?eNLt5lA7/tUdOzB1akNajnGa2wmiBx2PJwqBqMqwc8hyvV6wB7u9u6+Y/3q7?=
 =?us-ascii?Q?+BS7zH0ruenK2edPv+rJFISdS2XHi62nwSqeZThrNF83wbx7EdU7H7UB4HAD?=
 =?us-ascii?Q?Q+bTtHiCh9aLpBthT/37ANXYL0g8Q9az3XO7pEaDwFfgDcDBCgcElidlJGa7?=
 =?us-ascii?Q?eqZ9qY3agcJeKvxetx7GjlOUzwVf39P4WA2S+DFLWdgM25feq8KvBaMKK7Fy?=
 =?us-ascii?Q?0JFcRWfnJifw5Br5/8szzesnzfoH38k=3D?=
X-Exchange-RoutingPolicyChecked: YGhidFJSfgLChvVJZ+XIBhXfeU1/3SKSPs3gdEeL2LUaPWNWBzZYgCbmPNipQVPERy44OsZ5W5vSu6Lac01e6eNIZF/UMMwpQhGTHwu2YlAR1e1/fifiBOovcZinoUSsARnArUnxYLA9ClQDFZSHlfwcnUGdhf1HJ/rEFIX602AMd/puoNAXhgc1OKW/WG2loPdpTSfxzGtPBD7NDqN/cYiQBTe5u9qx/MaSnt8G6Gpf10oK/NZI4B/H95ib7V1RTzv8DuCrAqZv4djmYZSSdyNh1ks6gSLloU1GB6ut9Ud03K5BP0sIAgYq9Hq8ZFV8j9f6eThT+8rgBsmnVRIAxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 089a5c6b-2b1c-41dc-c679-08de89ccebe2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:43:55.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaS8epc7mWg28m8tdMSKAWheIzWatLrji3rcANhXg0gm4ZRTK2IFPt7L7A1RyxdKERN+TEfpeRJYvmOzg0SF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-230206-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 69D3931A3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:02:09AM +0000, Matthew Auld wrote:
> During 3D workload, user is reporting hitting:
> 
> [  413.361679] WARNING: drivers/gpu/drm/xe/xe_vm.c:1217 at vm_bind_ioctl_ops_unwind+0x1e2/0x2e0 [xe], CPU#7: vkd3d_queue/9925
> [  413.361944] CPU: 7 UID: 1000 PID: 9925 Comm: vkd3d_queue Kdump: loaded Not tainted 7.0.0-070000rc3-generic #202603090038 PREEMPT(lazy)
> [  413.361949] RIP: 0010:vm_bind_ioctl_ops_unwind+0x1e2/0x2e0 [xe]
> [  413.362074] RSP: 0018:ffffd4c25c3df930 EFLAGS: 00010282
> [  413.362077] RAX: 0000000000000000 RBX: ffff8f3ee817ed10 RCX: 0000000000000000
> [  413.362078] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  413.362079] RBP: ffffd4c25c3df980 R08: 0000000000000000 R09: 0000000000000000
> [  413.362081] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8f41fbf99380
> [  413.362082] R13: ffff8f3ee817e968 R14: 00000000ffffffef R15: ffff8f43d00bd380
> [  413.362083] FS:  00000001040ff6c0(0000) GS:ffff8f4696d89000(0000) knlGS:00000000330b0000
> [  413.362085] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [  413.362086] CR2: 00007ddfc4747000 CR3: 00000002e6262005 CR4: 0000000000f72ef0
> [  413.362088] PKRU: 55555554
> [  413.362089] Call Trace:
> [  413.362092]  <TASK>
> [  413.362096]  xe_vm_bind_ioctl+0xa9a/0xc60 [xe]
> 
> Which seems to hint that the vma we are re-inserting for the ops unwind
> is either invalid or overlapping with something already inserted in the
> vm. It shouldn't be invalid since this is a re-insertion, so must have
> worked before. Leaving the likely culprit as something already placed
> where we want to insert the vma.
> 
> Following from that, for the case where we do something like a rebind in
> the middle of a vma, and one or both mapped ends are already compatible,
> we skip doing the rebind of those vma and set next/prev to NULL. As well
> as then adjust the original unmap va range, to avoid unmapping the ends.
> However, if we trigger the unwind path, we end up with three va, with
> the two ends never being removed and the original va range in the middle
> still being the shrunken size.
> 
> If this occurs, one failure mode is when another unwind op needs to
> interact with that range, which can happen with a vector of binds. For
> example, if we need to re-insert something in place of the original va.
> In this case the va is still the shrunken version, so when removing it
> and then doing a re-insert it can overlap with the ends, which were
> never removed, triggering a warning like above, plus leaving the vm in a
> bad state.
> 
> With that, we need two things here:
> 
>  1) Stop nuking the prev/next tracking for the skip cases. Instead
>     relying on checking for skip prev/next, where needed. That way on the
>     unwind path, we now correctly remove both ends.
> 
>  2) Undo the unmap va shrinkage, on the unwind path. With the two ends
>     now removed the unmap va should expand back to the original size again,
>     before re-insertion.
> 
> v2:
>   - Update the explanation in the commit message, based on an actual IGT of
>     triggering this issue, rather than conjecture.
>   - Also undo the unmap shrinkage, for the skip case. With the two ends
>     now removed, the original unmap va range should expand back to the
>     original range.
> v3:
>   - Track the old start/range separately. vma_size/start() uses the va
>     info directly.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7602
> Fixes: 8f33b4f054fc ("drm/xe: Avoid doing rebinds")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_pt.c       | 12 ++++++------
>  drivers/gpu/drm/xe/xe_vm.c       | 22 ++++++++++++++++++----
>  drivers/gpu/drm/xe/xe_vm_types.h |  4 ++++
>  3 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2d9ce2c4cb4f..713a303c9053 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1442,9 +1442,9 @@ static int op_check_svm_userptr(struct xe_vm *vm, struct xe_vma_op *op,
>  		err = vma_check_userptr(vm, op->map.vma, pt_update);
>  		break;
>  	case DRM_GPUVA_OP_REMAP:
> -		if (op->remap.prev)
> +		if (op->remap.prev && !op->remap.skip_prev)
>  			err = vma_check_userptr(vm, op->remap.prev, pt_update);
> -		if (!err && op->remap.next)
> +		if (!err && op->remap.next && !op->remap.skip_next)
>  			err = vma_check_userptr(vm, op->remap.next, pt_update);
>  		break;
>  	case DRM_GPUVA_OP_UNMAP:
> @@ -2198,12 +2198,12 @@ static int op_prepare(struct xe_vm *vm,
>  
>  		err = unbind_op_prepare(tile, pt_update_ops, old);
>  
> -		if (!err && op->remap.prev) {
> +		if (!err && op->remap.prev && !op->remap.skip_prev) {
>  			err = bind_op_prepare(vm, tile, pt_update_ops,
>  					      op->remap.prev, false);
>  			pt_update_ops->wait_vm_bookkeep = true;
>  		}
> -		if (!err && op->remap.next) {
> +		if (!err && op->remap.next && !op->remap.skip_next) {
>  			err = bind_op_prepare(vm, tile, pt_update_ops,
>  					      op->remap.next, false);
>  			pt_update_ops->wait_vm_bookkeep = true;
> @@ -2428,10 +2428,10 @@ static void op_commit(struct xe_vm *vm,
>  
>  		unbind_op_commit(vm, tile, pt_update_ops, old, fence, fence2);
>  
> -		if (op->remap.prev)
> +		if (op->remap.prev && !op->remap.skip_prev)
>  			bind_op_commit(vm, tile, pt_update_ops, op->remap.prev,
>  				       fence, fence2, false);
> -		if (op->remap.next)
> +		if (op->remap.next && !op->remap.skip_next)
>  			bind_op_commit(vm, tile, pt_update_ops, op->remap.next,
>  				       fence, fence2, false);
>  		break;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 5572e12c2a7e..2773f1ee90d4 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2584,7 +2584,6 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>  			if (!err && op->remap.skip_prev) {
>  				op->remap.prev->tile_present =
>  					tile_present;
> -				op->remap.prev = NULL;
>  			}
>  		}
>  		if (op->remap.next) {
> @@ -2594,11 +2593,13 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>  			if (!err && op->remap.skip_next) {
>  				op->remap.next->tile_present =
>  					tile_present;
> -				op->remap.next = NULL;
>  			}
>  		}
>  
> -		/* Adjust for partial unbind after removing VMA from VM */
> +		/*
> +		 * Adjust for partial unbind after removing VMA from VM. In case
> +		 * of unwind we might need to undo this later.
> +		 */
>  		if (!err) {
>  			op->base.remap.unmap->va->va.addr = op->remap.start;
>  			op->base.remap.unmap->va->va.range = op->remap.range;
> @@ -2717,6 +2718,8 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
>  
>  			op->remap.start = xe_vma_start(old);
>  			op->remap.range = xe_vma_size(old);
> +			op->remap.old_start = op->remap.start;
> +			op->remap.old_range = op->remap.range;
>  
>  			flags |= op->base.remap.unmap->va->flags & XE_VMA_CREATE_MASK;
>  			if (op->base.remap.prev) {
> @@ -2865,8 +2868,19 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>  			xe_svm_notifier_lock(vm);
>  			vma->gpuva.flags &= ~XE_VMA_DESTROYED;
>  			xe_svm_notifier_unlock(vm);
> -			if (post_commit)
> +			if (post_commit) {
> +				/*
> +				 * Restore the old va range, in case of the
> +				 * prev/next skip optimisation. Otherwise what
> +				 * we re-insert here could be smaller than the
> +				 * original range.
> +				 */
> +				op->base.remap.unmap->va->va.addr =
> +					op->remap.old_start;
> +				op->base.remap.unmap->va->va.range =
> +					op->remap.old_range;
>  				xe_vm_insert_vma(vm, vma);
> +			}
>  		}
>  		break;
>  	}
> diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
> index 69e80c94138a..fc811b5e308c 100644
> --- a/drivers/gpu/drm/xe/xe_vm_types.h
> +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> @@ -393,6 +393,10 @@ struct xe_vma_op_remap {
>  	u64 start;
>  	/** @range: range of the VMA unmap */
>  	u64 range;
> +	/** @old_start: Original start of the VMA we unmap */
> +	u64 old_start;
> +	/** @old_range: Original range of the VMA we unmap */
> +	u64 old_range;
>  	/** @skip_prev: skip prev rebind */
>  	bool skip_prev;
>  	/** @skip_next: skip next rebind */
> -- 
> 2.53.0
> 

