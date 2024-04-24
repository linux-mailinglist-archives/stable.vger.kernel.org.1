Return-Path: <stable+bounces-41317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A785B8B0001
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 05:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C386BB215CB
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C013A863;
	Wed, 24 Apr 2024 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMKH2tqq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00685C59
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930371; cv=fail; b=XTeVoK8oZRg8UuvffrKpkreE3WUk3kCakt+hz3bXyVBYAMbxLupSabLci8vPXc734waejsAEZp22M39JDTTOrVsQ7Dca7/26myGZ++hQsmUOcwNADftc3LUyvMhLMdzG99Oob5aKhfV3DlMUJkLorbcODQvcBWMoVg6rni2MxZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930371; c=relaxed/simple;
	bh=pTv+3SDrd9Zltb6cUdNlcycA8uokHTposkK3IrVa61E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rmaHmCQWNrmTLeftmdZa2iZixiahvJrS9e48uwGD9pWH8sIapWuQk+t2GstSkAJRN0nJtlasMQuAqG3vK9sxyh7G+Xopnf0g4uu4xRYb4I5dx3XIO4XaO12buiJZ5Ba68f4qbdsaOOO4neBFG2nsbCsjvaCYA4BdGiXumYd4fIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMKH2tqq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713930370; x=1745466370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pTv+3SDrd9Zltb6cUdNlcycA8uokHTposkK3IrVa61E=;
  b=NMKH2tqqSnOhrtcshudYbn0w5uPI0m8jqITDT1hEskJXXXACaF4PqL75
   D94YS9ZufcaXFcikqKj5sgrifwyoh3ndh3Qxhd4fHhp7eoNNoOz5PJi8B
   Rjw//OBX4ECmM8QH41lcP+MUipJBW15lAzLWavJaFAnFtPuoD/gpEY56q
   GepkGfRY0o+NJeMk8jD4psI2jdkM/daKeLCqeh9bTezfOySqWGU1766/r
   nlNwqDObkRvwqvawzOCEnrE6ccopY177IlE5iuTLZIcIPZMlax328QLVj
   2TUBp56STqL2F2uGhcZKX23WNQQEKEA/LmkPlHUaQfLTJZXFOisUlEYPz
   w==;
X-CSE-ConnectionGUID: pao8uj2XTP2AUR0R+ZVBAQ==
X-CSE-MsgGUID: bmcbO4tSTBCtEk6DfxMuUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20237952"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20237952"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 20:46:09 -0700
X-CSE-ConnectionGUID: kUEuUujATA6KIVmdj8eZOA==
X-CSE-MsgGUID: CcnmC+VYS7WfNOk5H5+s4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="55775616"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 20:46:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:46:08 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:46:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 20:46:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHtMpWIQIMFl6ErIvlmV0ueMjuloccR5SwGqpNGoOOT1tBC7E1O1uQdfaOziO7zI/RV5zpzFyqc63CvMIlyF9ydoafUuwSfkckuBRxTnrmvVw0m3jUfsOvaAeOUUq1i15j/NKNeAz9uqXaG1tWFxszd1Bn2slFg02oLXqE54lC/AD4qZHNnZea93kvKJfRcp/5BlT/ESRAicwQN8HH2uAKTZ8pz2KuBYTotFSWdH7eIo168kTKvLhVD+A1mHkg8ENZ+Z0NkpqkbQaxRqRM5zwlF5BDmVqRg3bJpCXNJ01xnzVj7XEBwcW3jfY5d2/Pfe/MTOC1v4aC2ho1e22wqtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wr4NpoSpfcwIuLBEpxNXQVyEaL+gQ8MIqCbzf1S1TQ=;
 b=WG96c9gH2g3yEUhPv/oARfpcUeZkzEVgU9YaqLNIU03jnUYbyhJflJF7eo+zvD/vSb7czd4gklXU+W0Nd9h+CzZ0XQwW6rXG/ZNcZaq9BEW4tLqcFjyJTeQ5GIYgNuRx75vK61clsPWoVbjQ1pyF3HfSZIxTHSN66fJGxXwJ65MfOMt9bak2RAvdYoANZliNFKrCxnzlozWjFW40AhTqnilcGXGP8+uwgDMqCvQSY6HsoHIQHf4nWm0CXe9W5k9Ol7jg6GZWKHlGTlpLu+um/DDSJEc27OPsl3xpeiI0PcWb8GBP5U0POQoSsPjlQH7tGSno3ByOtkm6FVYwja+Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 03:46:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 03:46:05 +0000
Date: Wed, 24 Apr 2024 03:45:32 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/xe/vm: prevent UAF in rebind_work_func()
Message-ID: <ZiiAXBFAjT+PbF2T@DUT025-TGLU.fm.intel.com>
References: <20240423074721.119633-3-matthew.auld@intel.com>
 <20240423074721.119633-4-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240423074721.119633-4-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:a03:333::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: d799817b-9ddd-4a09-34be-08dc641111dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WpD6/a3siXn/sdGiwxEM34RJA1vciEziyJLvfcHIf64RlDunGJI5w2wi2wNB?=
 =?us-ascii?Q?PWyzDvdJFt7m6+077lE5ObrgFuSyJ5PxWXSg/jZIIYoLPE4gC9K3+0RMtRAu?=
 =?us-ascii?Q?0XQhoexbxU+GpthzL0c+irDaoLlh/kvk6JS2CCCqUY9oLDZteccbbdY2tjaP?=
 =?us-ascii?Q?OO9Z1gUEjFNZLKZzu0j6kmT3vcDxelQWvHjH9NTdX0Gt+6hq/42z2cAlhL85?=
 =?us-ascii?Q?CRq4e9Ywit3L7x+2APm2q45uzHq+rzLPwTZP+BWagZSL+1SPB8nYvyDwbgL+?=
 =?us-ascii?Q?G/25PNLHMUJXHXvAlIi8IXwOcfPEipIUIT8KWMv+26GY5UjshJj08qIAN4x7?=
 =?us-ascii?Q?1SpbIVdq9w+7ZnSyuQqRUVQZHlQvyNhWhKk8/uZgV+8YLO/2p9PoaySyIWP3?=
 =?us-ascii?Q?FMa+456ymfXihWLLjNbe0iJq163rTtD1kzHQ2cQxISq1rbXVMmi3XIUifWaH?=
 =?us-ascii?Q?Do4XOr/nyDFXIg7OSH/FSFI3t3/sfBLiBErLE7+UZJ8E7lS55xseMHA6jryx?=
 =?us-ascii?Q?p/HZtiqYZm7k9RH+hik3U83xwjW+faZ5yCDIDunVq+t65fz9HgDwydym4mHQ?=
 =?us-ascii?Q?27zAPXeveIuRyG3QbMxJZJJ6MX7FEG6spnvWuVXvJGM/gINUe2kNOD282pR6?=
 =?us-ascii?Q?vREsJPI2z6844K9BzbyYArGMG6WOgZ9ka83SVTCZ8KjyWazL6mMhtNvotqgk?=
 =?us-ascii?Q?xMMNDFYhVmGjaaVgyaoqxAiwJ9grHttlNRTV6i0l+hVYgdSKBK+nyrWY/S+j?=
 =?us-ascii?Q?KF0XqhpZlBmLDSPYU4htOdlX5gFjOx+1viHrEP45dlfqAkdyONdEMYdfLWp4?=
 =?us-ascii?Q?5z02Q88gKKaU9LrQF4/8qgoX3+PeTtgOYLyS3tZEMYS54sQd4OD+v/UOwHLM?=
 =?us-ascii?Q?MPGyz0MS5qfr8/WZklWuKdAYtX/XDkHkrFZ1PYtTsjMspeiYaz97irjk/zGu?=
 =?us-ascii?Q?vhCn4ifqTxZQjg0PBAJeKWZIt364O+W+7x9/V0feiuuoAWPQUbXacwcY591T?=
 =?us-ascii?Q?ulbRFeJGLQTc8bhXETIz8hDJsBlyNOmQKHU4+TV0u+asS+o944NYEj4kA0Zs?=
 =?us-ascii?Q?rCcT5EwWmRY0un7e3ko4OucfLZKeUpjSFoE+DH2aFz+301H8Q4xNvmiK+OIg?=
 =?us-ascii?Q?tDweigj9lCau5zOqnoLQgZtRuSORsowlU8nGZv3kmYbbq+rM0VdzN8VwjJ83?=
 =?us-ascii?Q?SvwiLHZUtUXh/mXrId2L0uYV5W0NKA/RKiBzBgGNV28HldXKo7D6k5RsKeE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IHc+thKRyWf9t7Djybi7wF8K0qYproW+9DSjKnZvuCISWdrumKGXOE/uHkO/?=
 =?us-ascii?Q?QTZ9RZbkhkYyEoqk2/NxPlb7iG7P0+ucAczdePUFDLjykA7Y7vbLu4AKNImg?=
 =?us-ascii?Q?xLdr8g9ERQdJ5AZWYMffcjpnnHwJUGuEaVNxe+6OopQQd5toUaf6z0r00LpJ?=
 =?us-ascii?Q?CF/T4xJymVR8JxpoHuZ/xfbCencgeFY7Xac68SbcUTd8VciuqF7RBTAVqB/v?=
 =?us-ascii?Q?Mx8HiXYfe0GD8e/bSJ9NO3yhxzIueZ34/3ETqT0pRAnedE/2qFAtv1j4Fag3?=
 =?us-ascii?Q?IHoPHLZk1gHt88cTrQPluLmZ+QYtVr/S9EcT/tLCdWlvwEoBxZrzEimbnEgs?=
 =?us-ascii?Q?H1bpAcxXzs0SzK+CAH2+kvKNsBKudXwezKkSm1brRQA1MNU7lkrCRQXu8wpj?=
 =?us-ascii?Q?2gFJKSLDuQtp6GPgj/ytWJWeR4VUspdM0tMcY91pcYoBzWQ8ed7I/OjRBaMk?=
 =?us-ascii?Q?9BrfHobZilzRjBcr6BGjglJJ8kXMF8HNsKr20AcOf9Ai8yOx5af8MCNtLoFJ?=
 =?us-ascii?Q?G+XPX5SJiR8usz3vAJWIPwTkzRHJa8p+ig0zt6NW+Bs5399p7UFFazqSQBiA?=
 =?us-ascii?Q?JCSYdNekZUyhb3lDQ4A0rbjsos6IUm0n3QDl9MKlGQrGGtyBCJdIQAQmCkmb?=
 =?us-ascii?Q?c/zryrcD9G5sf2RKo62ImlJ43rM642fLZeDDVZvPXTIvMgWAVXx/zu+EZKr+?=
 =?us-ascii?Q?n+8M6HZpgT7nq4WCD0zjbaHN4K9pCzIvInqPBffxgKTfjYLyPTl6XeflBf/3?=
 =?us-ascii?Q?HjUD0x4l0G4YiNl2v3FPESIhVrAEmyB3uKiHmPAADClYf3ErdPCVaEdNjwzm?=
 =?us-ascii?Q?iX4SoiqkkIfgE+EHm8XDJSoWPusQWoEGmpct1wE4RKsHSSZPAi/YEAbmGtnO?=
 =?us-ascii?Q?SYBjNWU/2n0xuk5Mfrw4zvPrpsmevugw8MTYrVCWx9ShhNCxntelNkeb4juw?=
 =?us-ascii?Q?TnGvknm6VqF06Thc2KqyuJewkIpcPvI816AIi6M3VVaTRTQoAXEQisDfum6N?=
 =?us-ascii?Q?PeUYO5pY2TYEiL6cXRQpFPoJShu6o8WeQAysHFteq43LY46FFRwqfX3hbpCm?=
 =?us-ascii?Q?e3ZGYGF0jUW3aU9vLbuZnfvQqkGdKBPU295wwl5bZE+k/b6/ArDMnBGnylBn?=
 =?us-ascii?Q?v812FpnzM5nMJ95wv/BtJ+TindLp8/NnsUGgt9FrWh+ZaHTusQD9KjUUIMz2?=
 =?us-ascii?Q?hENL/sHCXK6KLG+bkLWYhZvEXoVgc33fHuoUfr2qc2um0HUejp0dzD5XRWAX?=
 =?us-ascii?Q?OzsZdvrtpySaIZqu8FXjj3yMiyR6PrlQTJiYubrst8HofxizlLOVfxZX8Uvz?=
 =?us-ascii?Q?eKLRbbCtrjLxk/LlYvLHb37VHlDpnk/Y6pJNYWJSCNuORY3oRRRpnPnNJ0gO?=
 =?us-ascii?Q?eTrgnN7dUoakK0vBWucTCwhLM/YRDijmb7w+KWZxIUTRsUFgriM4RUNg/Shj?=
 =?us-ascii?Q?YJqXtzC1o2qN29hN49u3woptPT/Hs+x8/gALxLSUQvYkX7wdVIAYkyr2vRsY?=
 =?us-ascii?Q?ojGILUxbJN0u/7JONas5aWEOZyP6fObZ587jkNPG6d7YXgKNy9nC41Y6T/98?=
 =?us-ascii?Q?DZPbOlawSXpnY8nQtBTNHV9GniVAxvPlfWdoKmpAk2C+pWW705kLuB1tTqVF?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d799817b-9ddd-4a09-34be-08dc641111dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 03:46:05.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFmUp2eth4uc2bZkXYu2Po8zpf/JZVVXkevPExBGZ/PBEX+bvGyQGOP7jv9cnABcZxq6r9hGu/8wpNr4/DNSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com

On Tue, Apr 23, 2024 at 08:47:23AM +0100, Matthew Auld wrote:
> We flush the rebind worker during the vm close phase, however in places
> like preempt_fence_work_func() we seem to queue the rebind worker
> without first checking if the vm has already been closed.  The concern
> here is the vm being closed with the worker flushed, but then being
> rearmed later, which looks like potential uaf, since there is no actual
> refcounting to track the queued worker. We can't take the vm->lock here
> in preempt_rebind_work_func() to first check if the vm is closed since
> that will deadlock, so instead flush the worker again when the vm
> refcount reaches zero.
> 
> v2:
>  - Grabbing vm->lock in the preempt worker creates a deadlock, so
>    checking the closed state is tricky. Instead flush the worker when
>    the refcount reaches zero. It should be impossible to queue the
>    preempt worker without already holding vm ref.
> 

Comment in the previous patch applies here as well, with that:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1676
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1591
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1304
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1249
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 2ba7c920a8af..71de9848bdc2 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1509,6 +1509,9 @@ static void vm_destroy_work_func(struct work_struct *w)
>  	/* xe_vm_close_and_put was not called? */
>  	xe_assert(xe, !vm->size);
>  
> +	if (xe_vm_in_preempt_fence_mode(vm))
> +		flush_work(&vm->preempt.rebind_work);
> +
>  	mutex_destroy(&vm->snap_mutex);
>  
>  	if (!(vm->flags & XE_VM_FLAG_MIGRATION))
> -- 
> 2.44.0
> 

