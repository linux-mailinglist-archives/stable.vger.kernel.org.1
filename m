Return-Path: <stable+bounces-40744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845258AF590
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E52896FA
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2113DDB4;
	Tue, 23 Apr 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoKT3QVi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2613D287;
	Tue, 23 Apr 2024 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893738; cv=fail; b=Oki0sMn2uNgrv6OftX/3xwbV28aEOV9aeWPLxbFv835CqgHgRAbePYkcVWKkEZq+dUkfPlOOKMP1TBKNujrB4obqjkNph7TDF4q7NWZZH7hs1awqXO/FiYKsJK0tT2ciGv1miLaZT5cvSmA3JX5M7f2RBvN56x08oA30J+wWYqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893738; c=relaxed/simple;
	bh=zqvujHytJg17DB50Tq8ZKUnY2JkGEvszSx//X1+uwkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sdlvDwWbus4t4wG8SzJr06wCFjUOi0ozZmxoCPJS59c+HQZ9ukFOf5OYUqvCPwr+EMz7EqSw+/PyRKPQZBbdvoNq4e1Rpn8bgEq5SaDH7mQFWsALhk9tEGdjlNfpcjyBbRj+0AZ4yIZgZpcvFj4Cz4Hgu/xgS1V0OQqNHMoZpHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoKT3QVi; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713893737; x=1745429737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zqvujHytJg17DB50Tq8ZKUnY2JkGEvszSx//X1+uwkg=;
  b=QoKT3QVii95D4hZK4A/+VSAwm2aKtJzOLbQ7FUhzqABIYfe7XZyXZCnZ
   Kxy5Wo02N3OVJpcholvT6nBrhjWsTTVodC94MJkUAehjkLmPPZEPB/Wwl
   /JDPijRSulMkeHalQt/5fcCYurrPit0uF83eeT51LEHppCETG3JZ8tzET
   JVjcvt8uHAg1T6k8ilA6juyOS89tzmgmEVGUTcIn11hRa/uHVzWY4qacK
   AJN06EBxjCYvTnBOkcuogpgw0wkGenqbpUFBDRSGZjvMuRvSZxf0P2JlJ
   KV1QPLcYDnYfqO4x77lImrTNzw1VKPhVmiWOlVWWi4gJCap8fLSRgY1L0
   w==;
X-CSE-ConnectionGUID: f+MOeu8DStG+M3AAPfDWCg==
X-CSE-MsgGUID: G+g69DpoSmCch9dIbOwcmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9712177"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9712177"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:35:36 -0700
X-CSE-ConnectionGUID: biMlySgwRjGt0e3BdFjJ8A==
X-CSE-MsgGUID: eN3ljKSiTRmVIdMn9hvoAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29096829"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 10:35:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:35:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:35:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 10:35:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:35:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCD27JkD7kHbWFvvySOPbW04W/KtgJjByyVo3RMOAtjdHgWViJx+r7mrt096zZ4e8meajJ56Vuula5MJL/AckqMYvWBUNH0KpAdLTXc6uRYKFSJ7C7UP5gX1BfNa/x2A/xbHDeB6i2rmXXVdf93KVlH3hFXAD1R7YrVnQASWYtW1u3wwi1G75NtAS0iCKkn5T8Zq2pHWqgkBw9mpFjBm3L4V4jL9lxksdUbkg7mEQACi5a9N7l5fG+qilJBINXwx3B+KQsHFUYLwwBWSZ0RRBhuFevTIECz0qIQbZ/yJpphg1nkT165V21YMK3FWqB5Mk4cgzQgctoHTI9BVk3FuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaQGGEa2278Im9pgawdhUnLA2g9uCJHrZ5De3xJ1ajo=;
 b=NCcIb4Rpw0lCQqjbgYgs7KqjCInLNQNftHwVfItr5Ca8hGE4O2neKAiz29tY1pqR6WXaMKXsDK3doFpqUtX+0G5laX7ln3XSsbB7BmUoVCuskxrZun6q6gXav3GJnwVfgGYEmObcsJUe+fzGnTghNGvawVy+LxJPTbt+Qz6vdkKvbtXo/g6+M/9DAIDFLdgu2zpUy1Po8N2CgKKpk94qiY7QtBU5tYZmSqJ56/2ZOOPXtTNWQEYZ/aK06TeeqDLMgwzVP1xpwUjlRVOAy/ItF39NoxPrSOY76ZU22KfrlYNglLVqPmiw/h7mZw4BQUCmUKNPl22UFatR3XUVKI/kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8425.namprd11.prod.outlook.com (2603:10b6:806:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 17:35:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 17:35:29 +0000
Date: Tue, 23 Apr 2024 10:35:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <ira.weiny@intel.com>, <alison.schofield@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Message-ID: <6627f15f572ed_a96f2942a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fb5770-db98-42a7-5002-08dc63bbc515
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0XCndvV6hSR1quuFerDKMGLEiU2a+XQ1pbA8hWteSS4LEdFllZ3iecO86MWc?=
 =?us-ascii?Q?xdRq1tEUZbnPkOoDKarKBheiroxVnPhqPuQgZvVmVl2pEAoy6crfTo0RcoY1?=
 =?us-ascii?Q?DzT5p9vry82+GQXGefRTbJZTIulBIR9yx3yM0Ww+dfs9viE5wLV+Nm1Myp6b?=
 =?us-ascii?Q?PyetMf3yAciQn470HEb1ScIjW/ougTLMd7BRCA0NL+xcljMuNjs9Q1TglZCI?=
 =?us-ascii?Q?6GcC2qxmjjz+hAHlqKgSAC1L/kTtpAeIRPfU4HdEhHvA4aVPDHjPrq9wdycK?=
 =?us-ascii?Q?ROfrN504SNHM6KeB2fWsYbkyDEvVpMTIn19ENEcqLsx9S8uS7ewD5zLMqlZL?=
 =?us-ascii?Q?LU/f+jWxQ835Ei1lm1vdx9X4HZ4bGWWj4qX27fj/MFNWUgBhI1vVGEAovBHj?=
 =?us-ascii?Q?/ulDSqrQ6Jg2NLS2whm8o+BI4vVxJV3v+JZmmGINPa0bPoJ2SmfZECh/F10i?=
 =?us-ascii?Q?ZP//8tvhXSGjQL5uFOV6Aa5eUM5tyJm7NFOgz6MS2qgbCzs2JUEOaZmJ82hq?=
 =?us-ascii?Q?sGIyAYyL3wh9fwkKOv1KNyrVZnCEt5BqJtZwdwFLq7NNY5OyWFF+ZjAcT/aJ?=
 =?us-ascii?Q?kyZBd6ZQ81WllYXv9ak/6OVRhhWSdYHZmFex9UuePREjzItupX1n3GgO9ODM?=
 =?us-ascii?Q?O8L1B3SNu3MoW3rIF0Yc9NTfB/4/8TGf+vSPZATHHwbpaulX2XznogjlxTLA?=
 =?us-ascii?Q?7RnztlZ/O5Rh77uRAVH/BUj1EjOra+Ae5w2osfrwMqNOK/7o+TFh1YtKZWG2?=
 =?us-ascii?Q?27FnC30m+GgM+PBERUFaXIkY9kKGJ3PaqufOa990sKdpH12bLVw/xAd7OhGA?=
 =?us-ascii?Q?mFtiQTYI4qc3mDvVEkNrPdmyS57TVz9WsW9xvd2XvcdyfZKbW3fpWM2CME+u?=
 =?us-ascii?Q?JLch3cSj9PUYQ2iyGuJXQnnKZxUHAn/4p/7dQLvKLhicTCGLt7+IXtkqlLIA?=
 =?us-ascii?Q?2Vzo+mUXbOyz2tVrYP9ybUMc1O/iOw14L8p/5Dqusx/Up8pVTmqwqT/kArGq?=
 =?us-ascii?Q?R1CLK9cn9U6ZLLJZIBsdi7/oZoil4X+gc9TOYZ+Vi7Kvt/Ud/Mc7pHyqArvb?=
 =?us-ascii?Q?CtEIb5k1Xk4eaOoIiRAA+kXERXktOaaXZE13aWg0hJCRIF4/VhsmmBz9pYiT?=
 =?us-ascii?Q?5R8UUFqpVEslb5Z3sXSKV9c8gAwQOs1UHNi0E9k1526m2SdA8p25xj4thwMx?=
 =?us-ascii?Q?AFEgo2945cGVXLlNjcB460uRfa/HAkLC+0zUYc6FlpDz+O1u9AeJnhrm33e8?=
 =?us-ascii?Q?qnVmx5TYckefUGFKccW6k3s8H6Z3G2fQdXv7pHBVCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0DzQdFSxE7L8SSYdbynAmukesu8N217lSGECKqfNQHKSVD/yZ64dTv71iTE?=
 =?us-ascii?Q?cz/kO9R+4OsWaT6LBlhZsVE+SK02E7pu06O0vUOdAgFSlFw8eOXjPHy9FlgN?=
 =?us-ascii?Q?GYyz8cQ0crIXLDiBtd8z2jJH22EgFtUh0B6B53scb9Pm4newROYy1YPIcIK0?=
 =?us-ascii?Q?uXTxFT0cnQAxXK9CB6V7RhChl8sCrMNtzomOfkOu/CLCmdOYQssonHyxul6e?=
 =?us-ascii?Q?O+ZYSrD2Rxwx+DWRFNcqnu38Doid/+5e++E/wRSJT09ZrYCl9wEbtctbwDQr?=
 =?us-ascii?Q?Fym9POx/usi0vtCDxi9DTX8nKD7gtoPOjpc7ECrIMuI7vtd9xP82upulnQEg?=
 =?us-ascii?Q?heM/D7ibBf4Y8H6E97uZzR4s+FXms3lbGfNv3f46BmGDDRSIiY4zVfErmyem?=
 =?us-ascii?Q?yurXCZ2sPrqa4DAMP31129Am/BB64A+EUhnH3MscwELpg2LDmlaD/yUjZhK7?=
 =?us-ascii?Q?+XmUJ/sz+W/jdG2iePyAxRYL1xbRStdi2+gXXTWrRteKcgwMsZnUdqmE5ubp?=
 =?us-ascii?Q?l2jhp8c6YUzmO6Rjl/UtW5tx5S0xSm3o67fhFc+HuvHYKm7fTby+IhVXsqKx?=
 =?us-ascii?Q?5dLvFvwzWeJQ24+Xrvgm/RaO/d3DuYVQ6Q+Mdl3SI8KGTntnJrjDz6gjumw2?=
 =?us-ascii?Q?3OzA7wlBO27pX7X9iVstkweJsUvopkM4WtpUQX3UTs9Z/7SdRITiYlmIc/fR?=
 =?us-ascii?Q?7FkbvBqTM076X0HFF16jnIKoVkKB0IhF03EA6jdFpUg/a3SstK3V7J2kNIAY?=
 =?us-ascii?Q?slYlmFEaeEvMJzttxYW6hug5veUF6BRErHawoe+bTrn8eg5qWDqleaPKQvqa?=
 =?us-ascii?Q?6vQvtjWWJJfgc3VA9EKIXmMqojW5RlV30PYBlaTM/QCulEFj6WOIbjkAe17i?=
 =?us-ascii?Q?e4utzBpqVSSniXxv+k8EH2kQkTbdbR4zb/6ulnqc24gLlBkeJWgSm534Rn4p?=
 =?us-ascii?Q?Et92DptSV51ffmhfjGBsWA/G7rcVgV/NEZdubBXySREEmymJ8R+sqD3venAv?=
 =?us-ascii?Q?Gp5ajzRSl1322W3H2MEJhC7f+buYMw90SJfADqN0j9mxC9y06ikTbuvWWUXY?=
 =?us-ascii?Q?VZ0atXhfYl7nH3Z1s9jajBMvmxPcN37/sA4MavXCt7qSbyUz2Vd9GxqILjmu?=
 =?us-ascii?Q?AJBKAmhfXpQIBV648IZhKHNcgYvoZVrTxywUZXHQFuiEoN0J9pfD9ru0hCOv?=
 =?us-ascii?Q?PgPs7T3H1KXmU56Vh4YdOjGhCCioXz9jE3xLd5TdslZqA0kdhvFKr6pzifuV?=
 =?us-ascii?Q?HuFpCkhW1At79AjJVlTqjPWae0FdNXSVZTm0fW5O05bsZwFhEOAPzSccZ8J0?=
 =?us-ascii?Q?4AuRkzoZFftmSgnzgT21F/Svwm6/sxmWPnbWHk2yK57JxrGSh1W6avsubaqC?=
 =?us-ascii?Q?WC895cOLqq1447cgyBqkqkLT1JXqXnDWkAq4/GlQNwZuUz1uKbqdKqbldvFQ?=
 =?us-ascii?Q?c/u8qagD05xn5GVZ/esBnvUa298R5Hr4YMefG2e0BEpqITv6Qq53Pr4qZP8a?=
 =?us-ascii?Q?+KueAWad58HiVOny0hXrxINWjqtJ1KxVtPd/yKQWAfPK2AUKzrE4qW+lmE8z?=
 =?us-ascii?Q?qqaSMLd10CLwfYk8pOkJEyNf/yLjaW4kt8Mcyju9/2Px09ptNm/5EinDSzQE?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fb5770-db98-42a7-5002-08dc63bbc515
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:35:29.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zCjljenCfW1CU5aEMcWptaoqFnh4d/4K0um53rY2uxy0Joe+ghOzHJwfRvqxqwbb67CTvd1T4L71kDTd1/Yz7GoJMidz2xT5PICw7LxMro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8425
X-OriginatorOrg: intel.com

Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.
> Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
> mask off the upper-32-bits of DPA addresses. The cxl_poison event is
> unaffected.
> 
> If userspace was doing its own DPA-to-HPA translation this could lead to
> incorrect page retirement decisions, but there is no known consumer
> (like rasdaemon) of this event today.
> 
> Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
> Cc: <stable@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e5f13260fc52..cdfce932d5b1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
>  #define CXL_DPA_VOLATILE			BIT(0)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

