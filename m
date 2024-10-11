Return-Path: <stable+bounces-83485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4AD99AAA9
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAD3285F6B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6A1B3B2E;
	Fri, 11 Oct 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGkDAMCs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF07F9;
	Fri, 11 Oct 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668809; cv=fail; b=Fkz60aOw9JRiEt4kRQdFosE16HA3iac8Y/qrjlaxqmxnZx6cQJsoWsZPhHf4mf7Lh6K8t5OC8kNL8y/DEJKHLdEMhADl22E9eAzJ/fVSNqyvAPVXFN4iUcyTe44w3tEXMHEyOJGnMhlQsgVdCPaNkokdoChiNV/mpZQ4fqJZ5Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668809; c=relaxed/simple;
	bh=T8ZbC0qn9J+qlKegcyDNWFcvGIxWfFeNFx2nDhdFnSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TW1zKuQpuEo8OdZ4jwYXYIABXdu7x5tLcrqEwpumTwFkMq+To/GxXT4P3+xqXDeL5aifQ+HOiXn6uZdYZufYESUG9Bx0Ys8IJ2n1JuJiuZ4mGpmh+yuM/Cz91oEhfy2TAFencXXjFxq95cJqFJ0AL03fDfqUGwWRdF4SopqCrN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGkDAMCs; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728668806; x=1760204806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T8ZbC0qn9J+qlKegcyDNWFcvGIxWfFeNFx2nDhdFnSU=;
  b=IGkDAMCsGf2F5JnLDOaEretg/lpVMpwCB+gDcJHPhNlqpJ01KtRXPrWw
   SpADCXPaT0cU56mx54VIoRbzcXBx4eZnkICI/7iTB2yZua1PDtThdjz6i
   XfTxZMOt9ckEwvWCxw1sthnzlNoxy9pImxzQx80JZbMBsTS9ld2emReRe
   gVdANcklnTuUGYYb4L48NgwDsDTF66Hui1Z6rUxKnfecqbYJHKtrArRep
   BlOV2z2P1CZYCgXBZvb3ok6huWTDOGCFXtNuAY0xuuY/U7XgKkXMRe4t+
   ZXXqEve3ZWnikkcdhEDTkb6588ipP2D3Qk49EhbNZXTCK5yjTJ40uaAmV
   A==;
X-CSE-ConnectionGUID: 1ALaEGkgTAiQY7YRzUZkHA==
X-CSE-MsgGUID: S7h7gnnpRhmtY5U2OLYcPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="27523307"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27523307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:46:46 -0700
X-CSE-ConnectionGUID: vmXLPgGYT3O9nVjRAdnMFw==
X-CSE-MsgGUID: hSlwNmhJTI2mOdbqGissew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="114433412"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 10:46:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:46:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:46:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 10:46:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 10:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9S7pegkQPMl6CgF/zkVIQWkP+H82c00vtFC6OWuo887Sok/neW8US8ZBPTTYp3QEVIwW2D8PqHZCzpGdhK7DfBtgbnuRLGWrA4oZyFH3CtyW1tbb47hc0GkCwSgSX8tauUoJbpwY05GfcrjP5LnoS5o5HnUG7GS8yH3YZk0Yonc8xsYJH4bowSvR1o6OSRg29Ofo4WYTbKrxA+TVVonBbpgJ44omwVr/8mam/IudJfHJpYHev2tpK41eXHAoXZH8WGvq9riGICDvkoeDkGt3WXQDTKumCWNykiGa0Qmevr4T+Cn5VmWoIr1vEqa8Ii7Jmu+a9TL7HKaYz2cOv44+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCh401AwjnVT16T/OxnX0nGv7oipuada9Nu6j7xXU7A=;
 b=tXF/d+ghfQSDJEiqJ7pdbJrFfoG0yH7TY2zhOns4kM32+sDlo4gBMWMgkUl6bY/t7Ou2aEjCHwKwJ118LBBPFL9EuJ49JRrylSkNI6MglPIq9sCBalgUYHRUqos7PF+xBgk3+4VLJyttXGG6XoPdqeSeP9VrlB65Jw+EbRv/IpU3r8tAcw6GW7LrPlcylEjGt21YFyOljiUZZrkwkH6mlrNqpOHjoOhx/JcjmkwKhpvdvMEwaCxZAdnWGmD82CHYkMJZOXLGcx1P1wENsQBTuRSZyxk0EJ5Nd35bosd5Bs3dcxMTDZwiYVhUaKIl73R/LfQCIRTYqUD9pDgs/WJTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 17:46:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 17:46:42 +0000
Date: Fri, 11 Oct 2024 10:46:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/port: Fix use-after-free, permit out-of-order
 decoder shutdown
Message-ID: <6709647f66d94_964f2294ae@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
 <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a7b8a007-907a-4fda-9a35-68faed109ed3@icloud.com>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da8d823-d6e5-47f0-bda0-08dcea1caa61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tfati54fvyfsrRZDbcMi+W3H617Yscup3pI+H8IqK9OvwWxvfvqk9RARtH0V?=
 =?us-ascii?Q?7ALB6mbzODFXiWVPS7DHGDFDQeYMf07jsGqKJTF5Wlu4ev5Zw1uBbs55MgfN?=
 =?us-ascii?Q?fy01WCzci2f9UxvAVB3I5C3mG4R882UyrK/0xJjf6rpF4QiwagYBBzNNcY0r?=
 =?us-ascii?Q?FRQE9gytokq+q7L7uFWnIsg0X1WABFUqvqm+OFqMtW7KfKZ1b2zLeAw/LLT+?=
 =?us-ascii?Q?0ha8p0V2ILCNELGnSAwU7l2RVcHZA+/nTzhICaYdPUE5xm5jTACQWBqmDP6r?=
 =?us-ascii?Q?/ViLYnGbhjHISRylU9D5KjsukfdgqSqSBDAgqX1Kj/L+VtFVkA17yGwSxXy/?=
 =?us-ascii?Q?wWuYWAKvrr36QR9Bgy5VSa8/7AzkAaNg7T1eprLzqafQIjl7ONwG1/wKSwEv?=
 =?us-ascii?Q?wLSKD9vaglZvl6cTjQf+9aI476dK+rHRrGy6axyBmW4p9cO56OMVQsZrvOTu?=
 =?us-ascii?Q?byblBFwoMlAiRPTipK//5jWS10GBJ6WoPCqCqmNSlExlzArhcLqLOa1OE9eO?=
 =?us-ascii?Q?KPuqH/ueknRiDpIH9XQ4U/xGhooaD9GWrbXJkkacOxDBLrlLjYmFPdMz+HUR?=
 =?us-ascii?Q?wy0eKueXInSpZIhbzjnpTOTdXnVv2vK9apIPDt5R8w36uQSookd9Qu6Yq+2e?=
 =?us-ascii?Q?xSAombCt5QInGqCSTjr5lAL7V2pG1/gDhUGhYH6ZPcCu5Ocj/tfwEm6Aahk4?=
 =?us-ascii?Q?svaEvW7j56bthEL4z6+PGLrpu86MHi8aBG4YAVLlHFfkNJsaMBM4EgjgSoEL?=
 =?us-ascii?Q?t+hM/qzJl2SF0QbhJXlxymVWHMeb2GcFdkUk7ZA8wbnIG9emo0cEtWVM2yz9?=
 =?us-ascii?Q?qdF3+owyVRJCyF/QSnyJBjHwGA8MWT9pwTyNL0766eQD5/EWwf4pAHepwfI7?=
 =?us-ascii?Q?Z4PWJecEpKyLNDfHGodYEemfft4oAwKuDo+MSGPDSCY99LOPn4zY4woVKR1l?=
 =?us-ascii?Q?/FItG6bwrEDPr/64Y/adNKe3QEbyy+6yw7FbiNQ3KzUcFbfexNf1VMCBqJwg?=
 =?us-ascii?Q?aEq7ls/QCtD3VNK3o3HZiL4XMVs0fUh83eNpxU3uHHNDC0MWHhNCT8vKfNii?=
 =?us-ascii?Q?QgbBWW9T7kCY7m/GUak1rbc+IcrNtIxQW91m+fK0/dKnOqTkwnxZt0IA9Xa+?=
 =?us-ascii?Q?hc/quInTAhuD0iue9cf1e2SXapxckAgCzwr3PlEBJnNzz2tCitTO5cfrXRqt?=
 =?us-ascii?Q?tTxRQxcnguQLL7vPmykK8rzmVQtytRtzqyqKIN2PmJNSmJkeYwOXvxWlXP9e?=
 =?us-ascii?Q?DSF4D7DI1joYaka2hR7Z/S9SFUg1wMg2NnaSnmOV7btRRGg56kVH45RY+PFL?=
 =?us-ascii?Q?XeM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXYMUca5XnBz6f6t4OrTYj9KguqjQra1RO6o70BN2r+N4tBdRaVvIMaTTBOD?=
 =?us-ascii?Q?5VJo0MUxoh8bXCs0fKRm2/scAghTX5JTxphufJSrFvTt50DyHJIJTzrClgk4?=
 =?us-ascii?Q?c+2NnyEHx8QS9JO/CEMMXqHaFaeYoNq0aZtgP3DN6SaC2eK8wmk4+pwjrS8d?=
 =?us-ascii?Q?0lvI+Ogk6jjSOmgToZGa8qGPPqJAOkLfN0cRUONS5zA/9XhiLXkBvgPCqTjz?=
 =?us-ascii?Q?UbKTxRkhllTINWfEVAqsP8iDhS9LBkgUiUIET8ayEVBKtKmTfBn2Amfk5wZH?=
 =?us-ascii?Q?0hqIgWVfLKxyfWvrlvYGwI3j4iZQ3sHPKx2xK5F5cnEAA8mp11l6de+FUUN2?=
 =?us-ascii?Q?RRraCp1CrMiBjNRAQy5LZJZ2td5PNP8TbAfnCzlPyoRY9paOejayV/O5JgbX?=
 =?us-ascii?Q?Eh26vIuh9WRjPqoCVioHuAQ/2UhOnoQHy3vFjtfnJBAFlZzsRstpZsDxucE/?=
 =?us-ascii?Q?h+cTEVQWA+z+faiTlg6MVWLiNvVWXCsfoHjbrDsJQ8SURl6WTh8RuRBXcVN1?=
 =?us-ascii?Q?TL9lkj13bxGwKq3TbzteqNkJ8cC5cXHiIsW/8ov2bJHXz9sbY6Js3Irw5nrZ?=
 =?us-ascii?Q?s0JkbxSyTKW7+Nk/GkrnyAni79j6xqh6VcmNz13oEJYUnSztZFOMMUxD/x4r?=
 =?us-ascii?Q?fOWvffd+jARo8Tkj173E5VlquDmQMYw9HhsTiNhBKdSlcnGjT+DrwYGlWwTu?=
 =?us-ascii?Q?qYUi/DQp4iM5FcroJVraK9F+GZY2L6wspnEIULuteON4V4ft0aQrkZ7vDFh9?=
 =?us-ascii?Q?SNHZIjFIgEILFo9HlO17jziG2mxdaWYrkCQV8MZ/Iu9/4gEdkry00slGgBX8?=
 =?us-ascii?Q?9cCdIp0TTztr3q5cAecmx5No2pbo3KSd/BmYbJCSdNKr7oj/EXAogE926hsw?=
 =?us-ascii?Q?VVLtPiceZH7rS8lrRYqk8E9H8OiCZA1Vd92+pmhgiYZttXJG0JEKpJDDj9pr?=
 =?us-ascii?Q?tnAUe6vbW8jnEmVFrm1OXUQPX6cLv0BNC+tykRUBuV+qKqHz+rjl54x1q8OZ?=
 =?us-ascii?Q?mHWAgHDKfFBHVf5Xxv/+E2gF7Lgn2xR7sjobuuSqt4oSOww2tpMOhNoeXaGo?=
 =?us-ascii?Q?8rUKDRZ1trCom9krqDrKwonjoP7eElCHm2s9u431yvm0f8yz7kKX8FKcvkDr?=
 =?us-ascii?Q?onCC6QGM+dAaUBt01jNJPDJKzx34AByqL9XkpiPbUMYzU9+0q3JGISF0c+cF?=
 =?us-ascii?Q?gpzqTLBVwChX9so+lwS7N1s7Y6LBH/ObEbXq0LaWN/psLKMxar6HWT09bu0B?=
 =?us-ascii?Q?zdaHiolv/7XL1PopnXRNZdpjWCLEJB2wK8KpPaKkDQ8qZmyhgnk3UQmMis4V?=
 =?us-ascii?Q?iGGN8SQ93LIzLHYkyKOv4vwCVqew+L0+3R4Il40dourwMK5YRVbEh33Kb/kg?=
 =?us-ascii?Q?EMUaYxp58qCTBa8RvIVzKSqTX70GuLkBsgYLPXwumZS7cworrvn/NpN7rWF1?=
 =?us-ascii?Q?JsOkInf7qL2LqwsjSlsX8OBAeijMNfoaxDzMj9Mzx3JPn6tRWV6ED4y4yedm?=
 =?us-ascii?Q?kFwJBOAovub6m13nYgmPdNcIbmj9IEoNA2uMAdENv+sm7/yxjAjXPVPF2qML?=
 =?us-ascii?Q?v/9v3mVOcububnpdQdJeJ/NmF60FOQ4keyFxOUUkTdPYTGS2S6lGCJqf5nzZ?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da8d823-d6e5-47f0-bda0-08dcea1caa61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:46:41.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TQNajMfMtXPAVKU0ny1/PdCgMzSJOLIrlgHauyEfkW/gxgQTOABmJeyrIZ5sp6dI/bWfzwf0RXq8NezpEufXeI1eZ8MDergr7pTx2OcnwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/10/11 13:34, Dan Williams wrote:
> > In support of investigating an initialization failure report [1],
> > cxl_test was updated to register mock memory-devices after the mock
> > root-port/bus device had been registered. That led to cxl_test crashing
> > with a use-after-free bug with the following signature:
> > 
> >     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
> >     cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
> >     cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
> > 1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
> >     [..]
> >     cxld_unregister: cxl decoder14.0:
> >     cxl_region_decode_reset: cxl_region region3:
> >     mock_decoder_reset: cxl_port port3: decoder3.0 reset
> > 2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
> >     cxl_endpoint_decoder_release: cxl decoder14.0:
> >     [..]
> >     cxld_unregister: cxl decoder7.0:
> > 3)  cxl_region_decode_reset: cxl_region region3:
> >     Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
> >     [..]
> >     RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
> >     [..]
> >     Call Trace:
> >      <TASK>
> >      cxl_region_decode_reset+0x69/0x190 [cxl_core]
> >      cxl_region_detach+0xe8/0x210 [cxl_core]
> >      cxl_decoder_kill_region+0x27/0x40 [cxl_core]
> >      cxld_unregister+0x5d/0x60 [cxl_core]
> > 
> > At 1) a region has been established with 2 endpoint decoders (7.0 and
> > 14.0). Those endpoints share a common switch-decoder in the topology
> > (3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
> > the "out of order reset case" in the switch decoder. The effect though
> > is that region3 cleanup is aborted leaving it in-tact and
> > referencing decoder14.0. At 3) the second attempt to teardown region3
> > trips over the stale decoder14.0 object which has long since been
> > deleted.
> > 
> > The fix here is to recognize that the CXL specification places no
> > mandate on in-order shutdown of switch-decoders, the driver enforces
> > in-order allocation, and hardware enforces in-order commit. So, rather
> > than fail and leave objects dangling, always remove them.
> > 
> > In support of making cxl_region_decode_reset() always succeed,
> > cxl_region_invalidate_memregion() failures are turned into warnings.
> > Crashing the kernel is ok there since system integrity is at risk if
> > caches cannot be managed around physical address mutation events like
> > CXL region destruction.
> > 
> > A new device_for_each_child_reverse_from() is added to cleanup
> > port->commit_end after all dependent decoders have been disabled. In
> > other words if decoders are allocated 0->1->2 and disabled 1->2->0 then
> > port->commit_end only decrements from 2 after 2 has been disabled, and
> > it decrements all the way to zero since 1 was disabled previously.
> > 
> > Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> > Cc: <stable@vger.kernel.org>
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Zijun Hu <zijun_hu@icloud.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/base/core.c          |   35 +++++++++++++++++++++++++++++
> >  drivers/cxl/core/hdm.c       |   50 +++++++++++++++++++++++++++++++++++-------
> >  drivers/cxl/core/region.c    |   48 +++++++++++-----------------------------
> >  drivers/cxl/cxl.h            |    3 ++-
> >  include/linux/device.h       |    3 +++
> >  tools/testing/cxl/test/cxl.c |   14 ++++--------
> >  6 files changed, 100 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index a4c853411a6b..e42f1ad73078 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -4037,6 +4037,41 @@ int device_for_each_child_reverse(struct device *parent, void *data,
> >  }
> >  EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
> >  
> > +/**
> > + * device_for_each_child_reverse_from - device child iterator in reversed order.
> > + * @parent: parent struct device.
> > + * @from: optional starting point in child list
> > + * @fn: function to be called for each device.
> > + * @data: data for the callback.
> > + *
> > + * Iterate over @parent's child devices, starting at @from, and call @fn
> > + * for each, passing it @data. This helper is identical to
> > + * device_for_each_child_reverse() when @from is NULL.
> > + *
> > + * @fn is checked each iteration. If it returns anything other than 0,
> > + * iteration stop and that value is returned to the caller of
> > + * device_for_each_child_reverse_from();
> > + */
> > +int device_for_each_child_reverse_from(struct device *parent,
> > +				       struct device *from, const void *data,
> > +				       int (*fn)(struct device *, const void *))
> > +{
> > +	struct klist_iter i;
> > +	struct device *child;
> > +	int error = 0;
> > +
> > +	if (!parent->p)
> > +		return 0;
> > +
> > +	klist_iter_init_node(&parent->p->klist_children, &i,
> > +			     (from ? &from->p->knode_parent : NULL));
> > +	while ((child = prev_device(&i)) && !error)
> > +		error = fn(child, data);
> > +	klist_iter_exit(&i);
> > +	return error;
> > +}
> > +EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
> > +
> 
> it does NOT deserve, also does NOT need to introduce a new core driver
> API device_for_each_child_reverse_from(). existing
> device_for_each_child_reverse() can do what the _from() wants to do.
> 
> we can use similar approach as below link shown:
> https://lore.kernel.org/all/20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com/

No, just have a simple starting point parameter. I understand that more
logic can be placed around device_for_each_child_reverse() to achieve
the same effect, but the core helpers should be removing logic from
consumers, not forcing them to add more.

If bloat is a concern, then after your const cleanups go through
device_for_each_child_reverse() can be rewritten in terms of
device_for_each_child_reverse_from() as (untested):

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e42f1ad73078..2571c910da46 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4007,36 +4007,6 @@ int device_for_each_child(struct device *parent, void *data,
 }
 EXPORT_SYMBOL_GPL(device_for_each_child);
 
-/**
- * device_for_each_child_reverse - device child iterator in reversed order.
- * @parent: parent struct device.
- * @fn: function to be called for each device.
- * @data: data for the callback.
- *
- * Iterate over @parent's child devices, and call @fn for each,
- * passing it @data.
- *
- * We check the return of @fn each time. If it returns anything
- * other than 0, we break out and return that value.
- */
-int device_for_each_child_reverse(struct device *parent, void *data,
-				  int (*fn)(struct device *dev, void *data))
-{
-	struct klist_iter i;
-	struct device *child;
-	int error = 0;
-
-	if (!parent || !parent->p)
-		return 0;
-
-	klist_iter_init(&parent->p->klist_children, &i);
-	while ((child = prev_device(&i)) && !error)
-		error = fn(child, data);
-	klist_iter_exit(&i);
-	return error;
-}
-EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
-
 /**
  * device_for_each_child_reverse_from - device child iterator in reversed order.
  * @parent: parent struct device.
diff --git a/include/linux/device.h b/include/linux/device.h
index 667cb6db9019..96a2c072bf5b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1076,11 +1076,14 @@ DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
 
 int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
-int device_for_each_child_reverse(struct device *dev, void *data,
-				  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse_from(struct device *parent,
 				       struct device *from, const void *data,
 				       int (*fn)(struct device *, const void *));
+static inline int device_for_each_child_reverse(struct device *dev, const void *data,
+						int (*fn)(struct device *, const void *))
+{
+	return device_for_each_child_reverse_from(dev, NULL, data, fn);
+}
 struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,

