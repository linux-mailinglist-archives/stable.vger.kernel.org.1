Return-Path: <stable+bounces-89916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23B9BD5BE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE71C20FC5
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21A1EABA6;
	Tue,  5 Nov 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShNPxiIy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40411E7C35
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834315; cv=fail; b=gYedhEz9IrX3CYlGd7mRBMFiurzLQfbOlvxNRersqmmCFoVhIw/q63QS3y9euGO57l7Ld6W5JN3LO23PUWuDOmqNeVn594SA9ndhMmqgmyfsgATNDWLnKPMzukFvm8R052LbgfhphTm1x2wmdcMc1H/Ayi171VlBwfUK3QJpFyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834315; c=relaxed/simple;
	bh=URqN28xuxgFLA3trzhzR19+jI5+r6KTRwK290kFo2PA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9WKzLBHFmB2AlJ0C7sR9+g7f9Y/Bz9py+rQLKNQhi+lckZAlpxZqYQSp1j8z4M+uWqhNscPT+LTEoAPJkX81yIwIstVeXbHkVHjB7+xBPRuRBQtWcc+YEha3eUqCS+9/zuCjvmopKSCS1GKpkU7KIa6YD4w7PEp1+LddkOvBMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShNPxiIy; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730834314; x=1762370314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=URqN28xuxgFLA3trzhzR19+jI5+r6KTRwK290kFo2PA=;
  b=ShNPxiIyhAOAftlm/P+dBJVHDTtM2sn81kdrpwMLaeby49/MmvbPlKb/
   A5lCKfWVLC5zS+ywK5Thh6IqIYg2V1OM7hd0M6Val1LooBLfP0gYjFFPW
   VleszD7lWlV/OiGVHVlRsn1Ez+a1bA5265h/nfciV7/g6eV/r8EqbbUWh
   KBa3nOYWh2ZrTNMApL/ulAmVasskZ4EgCU8x66oJpVonM9RDlH7GawnXQ
   La7V0TbQlaPqgow+rD5M0T5DZfAMsFhX1FpSKEpXmuFDqdm6ABRcq1FAA
   5st/21NUfO3KpHq0lt4wp+MpDC96wIehmOEcFCmwgYdo8YNPltjXhafVM
   g==;
X-CSE-ConnectionGUID: 2nsXgqY6RAOt/DvA+qTJTQ==
X-CSE-MsgGUID: a8qJvdxJSS2MBJJ2S56QxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41709626"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41709626"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 11:18:34 -0800
X-CSE-ConnectionGUID: ctbfE4QUQG2gy+BLjSPsyA==
X-CSE-MsgGUID: azYBnDVXQvigWTcDUSAXUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84958040"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 11:18:34 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 11:18:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 11:18:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 11:18:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaQuG0t95hhTeDxPhcpv6aAxIxzUMgmrG2P9dlytMhS8YLJiw0SQ4hFFuuvhr6H3vyNFuCNw2vSmgXDpiXeK/6uWRe9fwR2aauLKx209m436iDzS1ltGgJVTPhVkK2yJ/fUaHiB7Bmmkp8h+vOeK9oXz5J72IfTqxMLgO3hyqGxtS7i9sj/LdqxotJypKtr0BvHlIILTOh6zXj457qgJ6JWZLSrTzD2eQrscOJ94/9t8bt7F9id3RP67vW58GPOE27s2ezHrXtH8TKZy8WdiKV9nbw+oelgaTSZQRYzrtinJjs+JtbZHQdZVHkH5rRJ9CVUvPDXn7wHZhse7PsUh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx3/Mvfzuczo7gYJ5kkKcW/kA9XonKkAnjzfeOQR2OY=;
 b=gdrwHbWI0YW5S+owUfgEs4kakl+KqQ7cUjv5rGaoi+GnfXIsqX364LnHMBI8caZ/Y87lx/VCoLZUHlAO9muwp8kYBqXbezVViTwieFptZSX/sLG/NRTiWF89yUvpNOD3XOGjrATZCL5uZZX4E/wLgmESJNO7x0ZkK69Q9cRtZP2p6XMgKONTeICi2cEHBPsuut1QTxsHMfwq4xbDKtdBxqTWLJdZ87DiIMQid5my3Yp7of4xqCkOHuy9+tjSzc3asXzNK71CEwV8WwJc+Bn/WjGPvoEptgWgmXLY4CwIOkpIh9aDYIWLeuwzCBc6uVpNgK+K+F5CWJV1fHek4k0XAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:18:30 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 19:18:30 +0000
Date: Tue, 5 Nov 2024 13:18:27 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>, <ulisses.furquim@intel.com>
Subject: Re: [PATCH v2] drm/xe: improve hibernation on igpu
Message-ID: <huirzn2ia4hs372ov7r77awhjun4fpezltrxcwfxgzzz4r3pga@h5jprda4zrir>
References: <20241101170156.213490-2-matthew.auld@intel.com>
 <o3edyxjyz4fd5n53dmi2hntoacioufr3rqelxpn5mkbp6vvaue@v4nxwlz6gpte>
 <ZyUpAwD3jzlW+hbA@lstrano-desk.jf.intel.com>
 <zwfqm64323vefwfugk3tcjvhz4mnowbz6ekixeyinh5bmeap5k@hts3jqvzmwvj>
 <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZypgCGh/bCP8K7aK@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f5719e-f2df-48e6-a9a0-08dcfdcea1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XW8E3kKSPNaqspkYNVGSOOWBkkv+c8BodJjyn3fIpw/5QUov1TXLIzjZ3s2i?=
 =?us-ascii?Q?5Ic3DK0t8JmHrr9VtnISyCPeTRZxrnwMkv9Io7MQZ+59YNOw6z9GBCAzcFYz?=
 =?us-ascii?Q?sbrXMsJ8Xoldmpw+gM8FohpUfnyu5tE1b+Z/QOjDxUcFNq4Z2RN3CYDNEGH9?=
 =?us-ascii?Q?ulTUySJ9Pu3gJI/cnZwteknfOEn0ANjJDCmoni0wH5rRO6C61J/uIIHIwTTi?=
 =?us-ascii?Q?jg/LCBY4BIgg2vIe9/85kvS9OaeA95OG4CylsqZRouxZV+1r6GpniwCZFKSC?=
 =?us-ascii?Q?atNjoiBMVhR5fl65+HOMIU9EWecOVgezP5hs3sh7nHonVU5x6XTfvBllZoFn?=
 =?us-ascii?Q?P1MZ4stDHvxTxd2vytTqnZAsh5V3x1GMRr5jZywCG7sWPwbrMZjoEiErgL7R?=
 =?us-ascii?Q?72iRWFBaqzli+5Z8Fl83JxfslXXlMKt8H/vEQoikj2QNYyTbQjA8tkzYub6U?=
 =?us-ascii?Q?DhzhnTwHp16WEGBLeMk/JD7opEo77aUvwTswS0wmC1pd65oof25USpJbKHek?=
 =?us-ascii?Q?v9qA8Puz+PUIOCf0SIEE7CJRhV02yDPl9bhhEo8W0QdKxFkjK3hVjkDyu/ln?=
 =?us-ascii?Q?Cio+3kC80K5rWE3Gnyr8bgF8EOPI1gglRHDr6VM88P1PES9o/IMA2EfU92L9?=
 =?us-ascii?Q?fBRpKiJfvn/AJToZ/GcMx59IppbBekOV6hdSzo69iBOUkMdscMUke16NtnAb?=
 =?us-ascii?Q?6aZ6kgJCk7KfHkoxH+Zoxcn+1HgBQILY1vXk4Yt3AkD+zu+ftFh47tzTEOeb?=
 =?us-ascii?Q?FUR3Cc4lB7i2BmYITXKRtnOPHjPGSr2iXVQdS4nN7rKeNL6BEJCqbmAtMX91?=
 =?us-ascii?Q?3LiR/xVMOtzISQ+Jtp0c6lYtva7U29S/3JGBbd0l+Rq0p6ZaIR853Qyfk8DR?=
 =?us-ascii?Q?IUR7AQUOgemBc05w7Ooo7H7XjwVZAfDPcB020QT/C4bVx8zMMD8Inulrf7aJ?=
 =?us-ascii?Q?bIJMtxHuha9I/lsb3NWW3eQ9+JvFdP2iOhpDfiXC/TWrAAilMS+PlVC8yaNg?=
 =?us-ascii?Q?vm7FQXQgauAqZI9ys3NnwXRGkRLmcS3828i5m9SZdrX+IUGWK/EnWxauz2+H?=
 =?us-ascii?Q?uM27kAGEpgV/v5UNMsUtSx2yCtiWsmk7/a8hhIBjzwdp36yj1AMdZTSGSDbp?=
 =?us-ascii?Q?EUDMCdEUmFfgpjdPRmlh3N2LTILNnC4MWT7BDz/ED5iwxLcRjyLsN4YbH/V6?=
 =?us-ascii?Q?zWsN+oIWW05EF2myxCGMa4ZYxG7OUwtIpy3vlWNJ4anxQMtgCLqg7f19ym//?=
 =?us-ascii?Q?mjZxxE6n7xR5yDsjaqyH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XtaaIkEDNH0i4bXAZ32qX6Zvp/XT1x0CVKmFs6uPeri60znht/Qnd1sxPf3?=
 =?us-ascii?Q?tsNE8Kk8TaT00TSBVuBOjERAaS8vTi2C1PTfdt1/kq37utKqEpvvi0yHCi2u?=
 =?us-ascii?Q?9p6nc9W8j0unJHvK/JWiP3yIngpajoMzTwMiuPvXqZJ2MidAZUKF3W3w7m/k?=
 =?us-ascii?Q?Ugxyr9UwKVkh/YqPt18bRcsXNC54LwmllVPK888UIDt9yD/cZDQqVxBJR+ij?=
 =?us-ascii?Q?t3J+vTzIfm4S/5VLxWjSeLwcOYZTJG/3kxkNDXtKRWzx7RgiCTOFmhu6D3C4?=
 =?us-ascii?Q?qJT+OcXRmR4KTX+cnAZT0TFcmimZupZLXwEV1oJEyLDi3mCgLSlDxeyXrZ7r?=
 =?us-ascii?Q?9FSepTHCW99FwO+OIsWGQwUg2Ix+Bt4sQ5HzfkHwMhcJbeOEtMhKc2XvwPlm?=
 =?us-ascii?Q?hfQA28p5k1QigldmdPm9tG+xeMzB0ejpfMMNEe7RCrJyOnWtuW6qFhoBfIei?=
 =?us-ascii?Q?uu6Q1Gg+HSpmeVK78TUp9ktba62sccxwEAqIYCjpqDkPh74kw1ZXfVDgyhdy?=
 =?us-ascii?Q?frEq8lE3YQIbPMsvMRs2mQJ2ekcfy4xNfx8AGsaS/VZ25jUyMKW5SKsnwrLU?=
 =?us-ascii?Q?dEn271M/rs/dbUhIrp9FaRUog5mOgP32SGo8KTYT5bfBkNj/TbvKUJJ2pSrl?=
 =?us-ascii?Q?9Ktc+R9lH7mJGW7rNRzmXyeGJvUKGeLfFSe8nuZkzdkDdY/GORB2WfmJFjG5?=
 =?us-ascii?Q?kbgPPxanOE4zTr+qdWV4/XowEXBEzb5hvA00oH8nArGr8zhdoso6zgc8LOvA?=
 =?us-ascii?Q?t71EBwKM/y1s4AyCRo8UD0FfXaTR5230wC3V8cV77gZHtj9u9OR+io4acg9a?=
 =?us-ascii?Q?zqRgQh0q9haM3Tn/m8r/LfzETFzjewweweN9mHNhGxd8h9ECs6DLdkDsg2LN?=
 =?us-ascii?Q?TM4/DKucEpzS7HrJQ4DW/7zYWGtvn4XUZHABC+EelMk/5QpRKhVtY+VYOuEb?=
 =?us-ascii?Q?F2GJlp5ekYgmd7tqsDK7ap/HzHQDWbq+mQc7ke3vv9XqklxWRaUuFM2Rb9JI?=
 =?us-ascii?Q?yOq3mnaTM7Fv9XXUa41TysjLWHp7OL48ZqNiko+jFNUXIOou6J5sP99HPtqG?=
 =?us-ascii?Q?+pxEslQxyIGWB1aaw0vAQK0dP8ejHJZG20VmdQ5w8stkhH7ljS9gc3kxVx3i?=
 =?us-ascii?Q?aIfnH9JINtrHobuEpawmdvTA5Fx0RjZZS4KBtcURCAccArmBx/vVoIb7x9Hk?=
 =?us-ascii?Q?eVpM2veoh19sCGh3S0xI1rO4WRuJojX/uoyWSSwCuxWzyMEvBbJDxQi5taQq?=
 =?us-ascii?Q?3zP7O3lhGwEsCTigH8ZkdQfgllu19iJuEmzJ7gA+rkMsbSTxqgRrbrFgYPQe?=
 =?us-ascii?Q?Sc8pnKWqSJi5U0crZzhQbUanRTGxItgXOK4lzLGnonmQgURZoymsIfgJseZ+?=
 =?us-ascii?Q?LZ4hu50xbzwmX1fhJPSraJ8H0Zzo+7wWqGbB5cQ2ly491mEzsPfGmgqrcBCU?=
 =?us-ascii?Q?QhFE97IxI+dNNFpr6f6kO8iN2EZHYQqR2c3o+4CbMyCJzdEjJpMLraSJfFwk?=
 =?us-ascii?Q?G3dLLVNLkqkI0O6lPrNTsrh2sNRy248/j3em/vnPYuFhXVXXPboPXKqOrb2A?=
 =?us-ascii?Q?k6FENNN6BB0sAAxxGe5jsbYBK5XE45YHDQQ4WqWXEpMpmJYrIYtEA4nuP9LP?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f5719e-f2df-48e6-a9a0-08dcfdcea1bb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:18:30.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGLGC0WpIF/9I30duZEyK3TKHQ/nSQpiQrz5lQMS5CVXKttqUqWNu0GAPJxt7Yl92o1NTEF3lqmXvrtDzyxeQgzEJ2eVHEoR471iXaI5HlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-OriginatorOrg: intel.com

On Tue, Nov 05, 2024 at 10:12:24AM -0800, Matthew Brost wrote:
>On Tue, Nov 05, 2024 at 11:32:37AM -0600, Lucas De Marchi wrote:
>> On Fri, Nov 01, 2024 at 12:16:19PM -0700, Matthew Brost wrote:
>> > On Fri, Nov 01, 2024 at 12:38:19PM -0500, Lucas De Marchi wrote:
>> > > On Fri, Nov 01, 2024 at 05:01:57PM +0000, Matthew Auld wrote:
>> > > > The GGTT looks to be stored inside stolen memory on igpu which is not
>> > > > treated as normal RAM.  The core kernel skips this memory range when
>> > > > creating the hibernation image, therefore when coming back from
>> > >
>> > > can you add the log for e820 mapping to confirm?
>> > >
>> > > > hibernation the GGTT programming is lost. This seems to cause issues
>> > > > with broken resume where GuC FW fails to load:
>> > > >
>> > > > [drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
>> > > > [drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>> > > > [drm] *ERROR* GT0: firmware signature verification failed
>> > > > [drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.
>> > >
>> > > it seems the message above is cut short. Just above these lines don't
>> > > you have a log with __xe_guc_upload? Which means: we actually upload the
>> > > firmware again to stolen and it doesn't matter that we lost it when
>> > > hibernating.
>> > >
>> >
>> > The image is always uploaded. The upload logic uses a GGTT address to
>> > find firmware image in SRAM...
>> >
>> > See snippet from uc_fw_xfer:
>> >
>> > 821         /* Set the source address for the uCode */
>> > 822         src_offset = uc_fw_ggtt_offset(uc_fw) + uc_fw->css_offset;
>> > 823         xe_mmio_write32(mmio, DMA_ADDR_0_LOW, lower_32_bits(src_offset));
>> > 824         xe_mmio_write32(mmio, DMA_ADDR_0_HIGH,
>> > 825                         upper_32_bits(src_offset) | DMA_ADDRESS_SPACE_GGTT);
>> >
>> > If the GGTT mappings are in stolen and not restored we will not be
>> > uploading the correct data for the image.
>> >
>> > See the gitlab issue, this has been confirmed to fix a real problem from
>> > a customer.
>>
>> I don't doubt it fixes it, but the justification here is not making much
>> sense.  AFAICS it doesn't really correspond to what the patch is doing.
>>
>> >
>> > Matt
>> >
>> > > It'd be good to know the size of the rsa key in the failing scenarios.
>> > >
>> > > Also it seems this is also reproduced in DG2 and I wonder if it's the
>> > > same issue or something different:
>> > >
>> > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000064 [0x32/00]
>> > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000072 [0x39/00]
>> > > 	[drm:__xe_guc_upload.isra.0 [xe]] GT0: load still in progress, timeouts = 0, freq = 1700MHz (req 2050MHz), status = 0x00000086 [0x43/00]
>> > > 	[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 5ms, freq = 1700MHz (req 2050MHz), done = -1
>> > > 	[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
>> > > 	[drm] *ERROR* GT0: firmware signature verification failed
>> > >
>> > > Cc Ulisses.
>> > >
>> > > >
>> > > > Current GGTT users are kernel internal and tracked as pinned, so it
>> > > > should be possible to hook into the existing save/restore logic that we
>> > > > use for dgpu, where the actual evict is skipped but on restore we
>> > > > importantly restore the GGTT programming.  This has been confirmed to
>> > > > fix hibernation on at least ADL and MTL, though likely all igpu
>> > > > platforms are affected.
>> > > >
>> > > > This also means we have a hole in our testing, where the existing s4
>> > > > tests only really test the driver hooks, and don't go as far as actually
>> > > > rebooting and restoring from the hibernation image and in turn powering
>> > > > down RAM (and therefore losing the contents of stolen).
>> > >
>> > > yeah, the problem is that enabling it to go through the entire sequence
>> > > we reproduce all kind of issues in other parts of the kernel and userspace
>> > > env leading to flaky tests that are usually red in CI. The most annoying
>> > > one is the network not coming back so we mark the test as failure
>> > > (actually abort. since we stop running everything).
>> > >
>> > >
>> > > >
>> > > > v2 (Brost)
>> > > > - Remove extra newline and drop unnecessary parentheses.
>> > > >
>> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
>> > > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> > > > Cc: Matthew Brost <matthew.brost@intel.com>
>> > > > Cc: <stable@vger.kernel.org> # v6.8+
>> > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>> > > > ---
>> > > > drivers/gpu/drm/xe/xe_bo.c       | 37 ++++++++++++++------------------
>> > > > drivers/gpu/drm/xe/xe_bo_evict.c |  6 ------
>> > > > 2 files changed, 16 insertions(+), 27 deletions(-)
>> > > >
>> > > > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>> > > > index 8286cbc23721..549866da5cd1 100644
>> > > > --- a/drivers/gpu/drm/xe/xe_bo.c
>> > > > +++ b/drivers/gpu/drm/xe/xe_bo.c
>> > > > @@ -952,7 +952,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>> > > > 	if (WARN_ON(!xe_bo_is_pinned(bo)))
>> > > > 		return -EINVAL;
>> > > >
>> > > > -	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
>> > > > +	if (WARN_ON(xe_bo_is_vram(bo)))
>> > > > +		return -EINVAL;
>> > > > +
>> > > > +	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
>> > > > 		return -EINVAL;
>> > > >
>> > > > 	if (!mem_type_is_vram(place->mem_type))
>> > > > @@ -1774,6 +1777,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
>> > > >
>> > > > int xe_bo_pin(struct xe_bo *bo)
>> > > > {
>> > > > +	struct ttm_place *place = &bo->placements[0];
>> > > > 	struct xe_device *xe = xe_bo_device(bo);
>> > > > 	int err;
>> > > >
>> > > > @@ -1804,8 +1808,6 @@ int xe_bo_pin(struct xe_bo *bo)
>> > > > 	 */
>> > > > 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
>> > > > 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
>> > > > -		struct ttm_place *place = &(bo->placements[0]);
>> > > > -
>> > > > 		if (mem_type_is_vram(place->mem_type)) {
>> > > > 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
>> > > >
>> > > > @@ -1813,13 +1815,12 @@ int xe_bo_pin(struct xe_bo *bo)
>> > > > 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
>> > > > 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
>> > > > 		}
>> > > > +	}
>> > > >
>> > > > -		if (mem_type_is_vram(place->mem_type) ||
>> > > > -		    bo->flags & XE_BO_FLAG_GGTT) {
>> > > > -			spin_lock(&xe->pinned.lock);
>> > > > -			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
>> > > > -			spin_unlock(&xe->pinned.lock);
>> > > > -		}
>> > > > +	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
>>
>>
>> again... why do you say we are restoring the GGTT itself? this seems
>> rather to allow pinning and then restoring anything that has
>> the XE_BO_FLAG_GGTT - that's any BO that uses the GGTT, not the GGTT.
>>
>
>I think what you are sayings is right - the patch restores every BOs
>GGTT mappings rather than restoring the entire contents of the GGTT.
>
>This might be a larger problem then as I think the scratch GGTT entries
>will not be restored - this is problem for both igpu and dgfx devices.
>
>This patch should help but is not complete.
>
>I think we need a follow up to either...
>
>1. Setup all scratch pages in the GGTT prior to calling
>xe_bo_restore_kernel and use this flow to restore individual BOs GGTTs.

yes, but for BOs already in system memory we don't need this flow - we
only need them to be mapped again.

>
>2. Drop restoring of individual BOs GGTTs entirely and save / restore
>the GGTTs contents.

... if we don't risk adding entries to discarded BOs. As long as the
save happens after invalidating the entries, I think it could work.

>
>Does this make sense?

yep, thanks.

Lucas De Marchi

