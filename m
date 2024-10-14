Return-Path: <stable+bounces-85070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267F99D784
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712161C22921
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C101C8776;
	Mon, 14 Oct 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt5Ym90d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92171A7273;
	Mon, 14 Oct 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934397; cv=fail; b=KPVTImohhyuAsdr0WUojqLQP8FHPAsBJ2+1xthRxuyzO9IP4VR9tFuq6LrKXHuRH6wtiYyRr87UtKbRMVxpmYW3XaptZd76avu3bzL0D+9dgZARHvmyCkWNy8ejhWGAF2Bdrj5djalX1K89rzjhdQDdvh0WrimeYeY7jOHvo1Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934397; c=relaxed/simple;
	bh=RHbdoCH4cPPoXd97s/5lNA8223QzmVPDU2Fd+vt/AEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dW8d34A/j5rVbRKJnlO9c5cT27KoZK1mnF9RCr1OJWCrXgPBIG2f3cvZmEWHLu8EpdPZjMqJsA+CbHr4zvLUHSn1ov2MiM5QHJwkxDv72KUkMtytmAeMvBN2Q8zQd28kuB73R5yOVDLtrI4Pj6BsW+6/7JEQmRhiKs05w+ob69s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt5Ym90d; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728934395; x=1760470395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RHbdoCH4cPPoXd97s/5lNA8223QzmVPDU2Fd+vt/AEA=;
  b=Yt5Ym90dIiMGr0kYDbbbdlqWJvyAC4qxcB+ZvLZbtv6LNzCL8LThFmtU
   yIR7Tzk/zNJO7p3p+G8/D/kR4YdWmeCwbT3uc93mUrAi8RreYXxdIWpJy
   bZgf5ul/N90ctPmdGixNOnZzETXPXdUJTq2aZD2jRRKMcCB1nx+uHSANl
   3eg5XlrhG1KCeqD4B2tJx6Mp0FvOM1HvO2WdqHJr1FSGlOUY+TrdXmyYe
   jkj50V/MQ/XLrj5ewkNZlMfxcF7IWs+dtshBofDHwEBoZSbnmrnnd9yLr
   14ODwPdVCQsoNBWNolT7wyQFwrac7HPC++k3zluqj9hepT+43iL0wLyOM
   w==;
X-CSE-ConnectionGUID: pN8gV28HSO6WshNlOVVM0g==
X-CSE-MsgGUID: 1Zp5CdsJQ1CzxI1DgE21Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32100941"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="32100941"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 12:33:05 -0700
X-CSE-ConnectionGUID: 5r+t1+iCR4eilP/dKNjFJQ==
X-CSE-MsgGUID: 0cZ46BhGQ8WXt9m9AeAbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82438188"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 12:33:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:33:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:33:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 12:33:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 12:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMDhj2J1hhpR29SvPROMcwufP2OakB9w+AM9Mcw5ubHPlqWASEPuPqzgIF1omkR0MZgMUM7e410BKD0rUIRMFTKr9mJPOGsDss9zWc3qia4I9KXV/n/45dC0/kpWaseTf17u//LdZhb2Y1dlbQFol4ULIWDHtlTmk4A+g6PtmY7zuIGKSWfOz6fvKNK/gZ3kb4FPvlJ13lhQmNEq6s1IAVHQBGe/JhLCLsi0NnBWtOYt1+YzS2BEugd7NVPSCPE2HOx+Mft27NAwxMaZ9ock3x8ch9s8ijNkuSxhOaQE/EUYhmhFBdba2JU9GSnHtW0y2CMbxkOWAJOwZ5DAGD7Zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+kPtw0snwn/kJRhpzyTJvRuqyANIQyFgsFszT7hUEk=;
 b=RSsEEBwRQ/z4OfvTklwD6fHdStfuOLoM+1eFekfr3D6A+AGmHrYFSeG458bt2DhPv5fo11/MqMhK/ev7dTbyQa0lsPgI5VD2JX3VF1+JyKgDfpHQ+f4Q0KfWyAfJ6t0JAXBUTigc9T7VTQJyr6fCOVYZtQDUHKNoUd67HePi9J31n29cx5qf7rqxwIgkXysMX5uJJazyU20udrFHvBOACdPTd/Vr27FaMVbMNBmS5ebsYJqplhZwgy8VJWfpyOyPigbCwT/yS18w5GDGgW7fksVagHRlfqLEgoO+sRN6LSx4k8BUEaTLGXiYeYzmeHTOfjSq9olQFYsZ+pvv2hhFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 19:32:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:32:06 +0000
Date: Mon, 14 Oct 2024 12:32:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <670d71b354c30_3ee2294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
 <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
 <060193f9-5de1-422b-abfb-6328a1c7b806@icloud.com>
 <670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch>
 <695d1a26-255f-464b-884b-47a5b7421128@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <695d1a26-255f-464b-884b-47a5b7421128@icloud.com>
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 41613195-630e-4b05-f709-08dcec86e327
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+v5jxsoXsIgq+nbQcJTKvPbkPHXTmGaS6vVAs+hz9jauoALp9P8RVAJ2Q9dw?=
 =?us-ascii?Q?+aBVW9d6KUe0t4A0ev44DVLKc81jChAeFJyP09S3MdZB6NEt/8xGqG9Kemfh?=
 =?us-ascii?Q?VeC/NknfHXTqF/e/xpNcO58OJEPDx6QtNey7aVMfMbrRrsiBHzVCl0LT75f+?=
 =?us-ascii?Q?PtKGazk7dbJfNXVuSDQDMm/JUTs2E80QCEoCGm2Ss0EDv/JY0hX1v2iTR7No?=
 =?us-ascii?Q?n0NeziYSerfst9YkRFpdyZ1uQ62PxQuDwQ06TtedNgMBBGo23mijod7vqFVd?=
 =?us-ascii?Q?Dj44REaGWECxjVryvHjy1bynqWHW8mW8OHeB9vgUQ//KjOw+eop/ovWgBSdX?=
 =?us-ascii?Q?+fzGW2XmcZ1f0m8POk+a6vq5J/kSzMVOhdztCm8Vwxj9kQhtGdpMqzhQX9On?=
 =?us-ascii?Q?8vH7fbft5xA3nCH02BgkR/FtsnSjIsgrthY831lkZkhXR6Xal+iN/3L9DApV?=
 =?us-ascii?Q?cVGwj6xNcs5RbgW+hqORKGrQP3Zz8EUprHdpY/kdSK83tW396UI36FN9mTCM?=
 =?us-ascii?Q?MzDCaL6lUKBOJR5a2zwC20AEQAay81sh6CN33Uw5TiYL04SShgNNc5tDsTp9?=
 =?us-ascii?Q?tFMb5DfQGXdYUjrBCqswkC6y5c0iseFeTkxH8piFxfHRQdvJqPHBkpmmh9ir?=
 =?us-ascii?Q?6lov1d2cKXQA/v6l5L1dnAAIbLfuwiCcicMZM/qpMRYVrPVxtyJd+nso4uKO?=
 =?us-ascii?Q?DoNP/PCsVFPTYarpq8zjlPctUvzSRwnKvaRO6E9bPmOR23RW4QsdeD8JgRoO?=
 =?us-ascii?Q?4Yim62shY324yTuX6dtmNcIVR5CAbg5HGEryzMQUaSlxnY6C3eVIE3Y7uv9s?=
 =?us-ascii?Q?tVeg5Qa9ekHfeHQe8a7OLwvll/XmATwra/fSKCmVFATzuW2cjBXMjksgVn1l?=
 =?us-ascii?Q?GuLtHooL6304SZ3uVWkdieUw0SPPucF2HSKpcFCaXeyWSl9fWIhpPfFzrwmm?=
 =?us-ascii?Q?DaEqxm4+nno+e2tDtzt7Fz8OiZQFGTrHlsj2B1SOj4ZFt+y1GWPgonyzdd38?=
 =?us-ascii?Q?DUbtco3AZhVdWjbcETrkwVHNl4aEJayCotzeSvkUjhrWw6o9+EPMo/v6lmZV?=
 =?us-ascii?Q?DopVybNKt2Le+t6gOqaXTCleUEBDvhGf/faLXjFZcLX7DL7nhL0IKn1WeEfr?=
 =?us-ascii?Q?pchgwZ3FYWiOdw8P/mq4IvyBmS/HAHr89V4ma2S3v5o6X30e+l9X3f9z/+N4?=
 =?us-ascii?Q?RA8duyXg01MySgSD8YsOSuCm4/e7ZFgpRUv6nzFDyjwbKfpfK3/VkEjHcY89?=
 =?us-ascii?Q?BcJIfWQwMephbTRSAzILk3p/7rjo+9pSck1j14crPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TarvfS24CGpiJZIxySGpNkLtuvy3AzY9qkGc2t2pVhajQ1fefindML2PltG3?=
 =?us-ascii?Q?hKt7r84SUENyZKLHgy1vmAjaJAVdCwkjp/bKLaa0ltgzqxQzrExvqPW1R4iv?=
 =?us-ascii?Q?EmwyYVnWaDXnIHYMecdMm/8nozoB7EiOwpfQRQ3EldS2vR7fwokMBHMw8JAA?=
 =?us-ascii?Q?XWFHH6YRg5G+xdeFvgfuy8MLVG37CEA8FY79jl/yDQ4+Df5bOaUWVyLqNXcY?=
 =?us-ascii?Q?HKQpXcvg/FSBA7sDlAwWDRU33G3Vae87K8rH7w4hXw8YwAU3O//OZzH9DSQi?=
 =?us-ascii?Q?VgbY9sAhgnkZmjaxkglYihBxjylpU6EBdKCVFcz28thNsD1NAXWmBulCP71z?=
 =?us-ascii?Q?fAaGfqfm/IAmQtlyQRrdsYksfbH7uM6EcA3QBfnXYc3f0TX/n7tAjv/z7FJM?=
 =?us-ascii?Q?ntp7U24ljvSeFF2AgBYN3lA9hie8OfKtPu4JaiNFcP9sd85rgxhULAod62y2?=
 =?us-ascii?Q?ARDLn5s9/9coPG9dIHIZ19V4rAmrH9hNhDI6RD6m0zovBLJIuZzi8puiE8JV?=
 =?us-ascii?Q?y+IzSYVyh8W2waYwhQHCjFbrVrB8UMsBTorkGPt2a1FHzw2jxYbIidyaSgbp?=
 =?us-ascii?Q?iu/lgyeXcsHnbEeQGSI0vEpY17PgEVMGwV3iSJcho9uZTw4oMTV5lGulfaGI?=
 =?us-ascii?Q?o7SmiKjtOI2VRT9cDGh1q/yA8Q0zNKBygnI17c0BJQ9bRipZJtasSBn95j8g?=
 =?us-ascii?Q?p/V3MdylwNH7TeuYwxBtqBs/nfbwWI7tUzrZ3zXLEIWLgY0eqLUSIUI04l14?=
 =?us-ascii?Q?PDyFfzALECWEjW8WLtAq8o+y0QDukuyxdCmR1gMX35TmqwjzQYEYElCuq22O?=
 =?us-ascii?Q?btrLkCZbRJsiLCkBhxBfuKxcw36KJx46g2cYeIbAGIzhSwfwiv8WL1zSeqeW?=
 =?us-ascii?Q?yyZF0ZfZqoGXJ90pu1lR7siCuCF3eygPNQ9++PsEu0H85v2bI+1RQHM38w0g?=
 =?us-ascii?Q?oZTbltHP7g4gf1I5gVvFpXSdnZyWNVr+nJUWjfGqKAXpYaCUorj9TTcP1A8t?=
 =?us-ascii?Q?IQ273ezJNK17Iv450yRQDEX+bUA++6cmFB7iwDgPeMILgHA24Av/0CvpIW54?=
 =?us-ascii?Q?TDSqfMZiiUN5BflIC36ZvIZO1uTFKNd58bROukZLolZ27CKyA5mdtB8ooaO0?=
 =?us-ascii?Q?TB2adlErWOy/DocLNCovKvEgyYB23xVcmZOEdCWIEdCkk8Na4KORzYEHiKhE?=
 =?us-ascii?Q?9GhV6g/JG8LHOdpgSLLprtnN8pGdZmISxjM9cxbRXaQ9CbiHgT6nb8hGlKFd?=
 =?us-ascii?Q?IMeICO6f/Z8dLzXyztsFNEOTITK6OvMPRjBWRRp0S4S5SHGI1A/KIrd6RQnt?=
 =?us-ascii?Q?V+g5vljS5xSbx7C+iNU+51zw7/I/hE/ZK1YEcDlfWceTu6tvKp7zGyYt88HF?=
 =?us-ascii?Q?UHxAoiyeMKdHS3MgdjY8dlow3GlWXQ/lqq1ETN/q5na7TK7sf9IM1tNfRlPJ?=
 =?us-ascii?Q?JvgdYROueXt9B+bx47xZ0UP8rZNZNT/K1bQA4I+cSv1uWbUPN0QvIUtQ1x9z?=
 =?us-ascii?Q?PiaYvamBXvv8QvgoD5b/8tp6Rr/M0cGeu9qkRRcaX7klpmR9GQmEawN8OvBG?=
 =?us-ascii?Q?c9JIbpOtL/PcTKtuS29hd4DKy+D8GVTj5mTWUy0rxf5ahcQNqAz94qeBQmB2?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41613195-630e-4b05-f709-08dcec86e327
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:32:06.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTiPS+RWqsdvP8hYqqc00WMCEiIWWBx0G78qAkkUkwEQfH6WEnM671ITPdFg84y4h0dWzZXUs1wW9/ZUdZWAVZFY6aajd7KZMRHk7FHOkgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/10/13 06:16, Dan Williams wrote:
> > Zijun Hu wrote:
> > [..]
> >>>> it does NOT deserve, also does NOT need to introduce a new core driver
> >>>> API device_for_each_child_reverse_from(). existing
> >>>> device_for_each_child_reverse() can do what the _from() wants to do.
> >>>>
> >>>> we can use similar approach as below link shown:
> >>>> https://lore.kernel.org/all/20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com/
> >>>
> >>> No, just have a simple starting point parameter. I understand that more
> >>> logic can be placed around device_for_each_child_reverse() to achieve
> >>> the same effect, but the core helpers should be removing logic from
> >>> consumers, not forcing them to add more.
> >>>
> >>> If bloat is a concern, then after your const cleanups go through
> >>> device_for_each_child_reverse() can be rewritten in terms of
> >>> device_for_each_child_reverse_from() as (untested):
> >>>
> >>
> >> bloat is one aspect, the other aspect is that there are redundant
> >> between both driver core APIs, namely, there are a question:
> >>
> >> why to still need device_for_each_child_reverse() if it is same as
> >> _from(..., NULL, ...) ?
> > 
> > To allow access to the new functionality without burdening existing
> > callers. With device_for_each_child_reverse() re-written to internally
> > use device_for_each_child_reverse_from() Linux gets more functionality
> > with no disruption to existing users and no bloat. This is typical API
> > evolution.
> > 
> >> So i suggest use existing API now.
> > 
> > No, I am failing to understand your concern.
> > 
> >> if there are more users who have such starting point requirement, then
> >> add the parameter into device_for_each_child_reverse() which is
> >> consistent with other existing *_for_each_*() core APIs such as
> >> (class|driver|bus)_for_each_device() and bus_for_each_drv(), that may
> >> need much efforts.
> > 
> > There are ~370 existing device_for_each* callers. Let's not thrash them.
> > 
> > Introduce new superset calls with the additional parameter and then
> > rewrite the old routines to just have a simple wrapper that passes a
> > NULL @start parameter.
> > 
> > Now, if Greg has the appetite to go touch all ~370 existing callers, so
> > be it, but introducing a superset-iterator-helper and a compat-wrapper
> > for legacy is the path I would take.
> > 
> 
> current kernel tree ONLY has 15 usages of
> device_for_each_child_reverse(), i would like to
> add an extra parameter @start as existing
> (class|driver)_for_each_device() and bus_for_each_(dev|drv)() do
> if it is required.

A new parameter to a new wrapper symbol sounds fine to me. Otherwise,
please do not go thrash all the call sites to pass an unused NULL @start
parameter. Just accept that device_for_each_* did not follow the
{class,driver,bus}_for_each_* example and instead introduce a new symbol
to wrap the new functionality that so far only has the single CXL user.

[..]
> > If I understand your question correctly you are asking how does
> > device_for_each_child_reverse_from() get used in
> > cxl_region_find_decoder() to enforce in-order allocation?
> > 
> 
> yes. your recommendation may help me understand it.
> 
> > The recommendation is the following:
> > 
> > -- 8< --
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3478d2058303..32cde18ff31b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -778,26 +778,50 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
> >  	return rc;
> >  }
> >  
> > +static int check_commit_order(struct device *dev, const void *data)
> > +{
> > +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > +
> > +	/*
> > +	 * if port->commit_end is not the only free decoder, then out of
> > +	 * order shutdown has occurred, block further allocations until
> > +	 * that is resolved
> > +	 */
> > +	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
> > +		return -EBUSY;
> > +	return 0;
> > +}
> > +
> >  static int match_free_decoder(struct device *dev, void *data)
> >  {
> > +	struct cxl_port *port = to_cxl_port(dev->parent);
> >  	struct cxl_decoder *cxld;
> > -	int *id = data;
> > +	int rc;
> >  
> >  	if (!is_switch_decoder(dev))
> >  		return 0;
> >  
> >  	cxld = to_cxl_decoder(dev);
> >  
> > -	/* enforce ordered allocation */
> > -	if (cxld->id != *id)
> > +	if (cxld->id != port->commit_end + 1)
> >  		return 0;
> >  
> 
> for a port, is it possible that there are multiple CXLDs with same IDs?

Not possible, that is also enforced by the driver core, all kernel
object names must be unique (at least if they have the same parent), and
the local subsystem convention is that all decoders are registered in
id-order.

