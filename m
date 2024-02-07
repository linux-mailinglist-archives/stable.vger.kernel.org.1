Return-Path: <stable+bounces-19026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D591784C252
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 03:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3128210D
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 02:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094ADF6B;
	Wed,  7 Feb 2024 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHR73jYT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FBEEDE
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272146; cv=fail; b=aW3kPgljp7ZQSupJdV58nLKmLXQqBGDZh5tY9p+SRTgcWH8V9nTkCFDBpBcu+3Fk+SfyLbiG94XltSDkxCY6ZTynxKc87AAaXbumNkhEB73mzNktXiZ/vcprRKAUPmfwWeR1xIQHBDvTAwfjwCAO7iLSZpFgwkxIh+GA3R8P96k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272146; c=relaxed/simple;
	bh=F5XW9Vk7Zwter6OoUewekf2U+XkH5ZI6PiNjcqi3E9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VyHJYqmZ9C1C4ZQw7ZrrnX2vSmYHWWaPLKJi2ZsuCK00M9/hjWSyWwuV3Cm6mpMiWS8i8Oo/ajWJ+kQ8dyQwsWGb64Akrbj3OWb0ifHzstq+ow/os5yU0tN9LPzQkG4DQZbswv6dkskjiNBH8THUErE+wlypVBVCpA9EZh8X6JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHR73jYT; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707272144; x=1738808144;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F5XW9Vk7Zwter6OoUewekf2U+XkH5ZI6PiNjcqi3E9g=;
  b=UHR73jYT/zxfSHPQxozUhAXhnbF5N1h3w7Z6bzqUsoMK9Xe7ht+RYMKC
   pouBUJlBJCOkJw1ZtvIbgrZ2WhzPWUY02kqQiPrE1DRCPwHQtQIFjh6VW
   ymb6f5LOoQ0NspNJDcw6pUOLuA65AICMF0148+5NFVE/CDqY9gY8up/ED
   EowoqrB3z5Y+8/IY3qntHE16hd3qhFAo/LmhjI5Vf58meancc9WlimBzV
   ZYBpZUkzx78P1BGsd4PBofpSm8pEJVWbD498Om4T09z23Jn6JkbzEIr22
   q11aFWrdMwgfuxA9B41ZN3dAVW5F0QYuDBkwjP5C6y3Ni4VAtcKMpAY+4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1168599"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1168599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="933647694"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="933647694"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 18:15:43 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 18:15:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 18:15:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 18:15:42 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 18:15:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja4Yu5B4SblnWCV0WHQ1q2OO2B9ip6wDI10XvwNZU9E/bykQtZKavn7ZLJafQGbs60OA7BcvuVTnihH+h++T9gyugQ8A40gVPhq2+epoaco7OVuR3uw4syWHVIZ2r/34QspGTkcQyOttlx/qQVKbo8nSsU5ZvKCEl/l9pC85lHpUMCZ+yvPJHNG6llVcmh4Q/PXhJynfMs8asbp1q8wkClYiPpk97TDuLnUJpoXckxqK88QofQs9Jks8XseXV9kRax5rMFbaIQdcun612biqjSScUnBYC8XMuiipS5gsM8nTyJZFS95KqjGYBxKakzy169k5UFTIqmG71w8rAWm6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArEgMIcXfcmrly5PAVO9/Dn1w6Yxw7sz4Ksa3cGLALA=;
 b=P9xjTXhEKCv38qqgXw+dD91a7anAlL17TeLhHhiARB1UU2V1O3mfV07xC5w6oeXlfN7hbhiCd0bQQfqovK8yKtWBRIymebr+MhaLiXJ/mdkK3R58QuVL4FAgBuL00IYWgoB9RsHLzQkUR28Rnh7ZW3s2JRfi01FcNctpYzQ71nVvzV+20VXPjc1eP4f121RKz06daugiZQJbKFL7nZDEQHjpZwg47ONx9HdUw0KRPhm8LyZrWrGmRntoj2hZohDVOngoN4I5j7/CcHCqCm3rc3dTPoJ8qnu/zinTWXyd2Ij4yJODtiYU9eysG7eT97HIobqtJivVfFwwhtm1mRL2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 02:15:39 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 02:15:39 +0000
Date: Wed, 7 Feb 2024 10:08:40 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: kernel test robot <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
	<stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [v6.6][PATCH 09/57] eventfs: Use ERR_CAST() in
 eventfs_create_events_dir()
Message-ID: <ZcLmKFhf7Maq+uVx@yujie-X299>
References: <20240206120947.843106843@rostedt.homelinux.com>
 <ZcIjPz0OgAbfVmIb@ddcdc6924185>
 <2024020618-octopus-passive-367e@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024020618-octopus-passive-367e@gregkh>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: b63ae325-c033-443c-2b67-08dc2782addb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJ+lt+pFVPFuRw6jrLwX76XgfAZY/9zY2Y1U5lFlLvVp46biusen4LMD1vNAB0fn6oXzprA7T4YzvRzE2nt4q/j/uSSWnXOFs7vUeD2TQRtGqUlPXslKcDMIDBL4BFrOuyG6oCQHKJbyVh6xVwJrMA9jNo9hydArwZDuGBmSZObeb2C+R6v6oWwFbIrsMLI0KyzXRhI3zgqHSntSlO12LXEt90TJl6b+daScJQQnm2qDu7VMy8WAs610kV+hGtnOBBSoUvimeH7OZafZWy7y3Sj8qXjwcq+hFuBqRzrmJwJUJsPvXdqUEqZvrHOquGsotKuwwYV+SC/5tIXX25xId59+/tAlxglGYT8BKi63pMtnUXYQbMgsElhYFbJndip1UsGxaB/xg5f8+XIebUSuAnfUq7ltywTLbTuBq0r6aT+wV4VfNEKASjk4tlqgT4Jw32naTR5fvoIm45ir7iTYu565/TKVSCGyiBaauVhJr6BGL1ancWyqSrXwEDl287AEllavE+VUPcRwovSIXXIgFVXGWEfyHgFopzFySDmuFT96WBNp4tCWD4RUBnbfRvGK2ijON5kGnPuXvPSDUEhyDp+mBH83ehpICx+R4Yao1c6sSgU00uA8Nr1jiyweRKvZlsoftv4HT4wepplevkrhOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(26005)(86362001)(6512007)(41300700001)(966005)(4744005)(6486002)(5660300002)(2906002)(478600001)(66556008)(54906003)(316002)(6916009)(66946007)(44832011)(66476007)(9686003)(8936002)(8676002)(4326008)(6506007)(6666004)(82960400001)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/s3F03N7v6ejB6GyoEyvJIQCRzDPQZxUTQIxGVwbVTnliZblR2ZfmQHo02iq?=
 =?us-ascii?Q?TKbQA9jbiUBz1FU9iPevQ2jiwwAxkShpqGnhpXvcyVmugk8y5r1LYed4PGFf?=
 =?us-ascii?Q?OlozII9IXtUiH/2lD5eUvffCiIDKw3vx4PV8QlkZ+iVJ71BI5PloQrTJKPRP?=
 =?us-ascii?Q?J8GS5Udpl3vKInYToQm8uh9CTllvqkn7uVub0Lbm4C3r8JSWEemW5ocxPsve?=
 =?us-ascii?Q?sq9mB6b6smZfKuUrAp4wZVWHjxb0Mjc3mxjlDD+IS7dCUT1LeqxWYUz40Fcv?=
 =?us-ascii?Q?hH/PkHl0oFRMRtMZzOI1BcGeORAmbcC7Z12Am7ArEINvFsbLBTACOWZfot78?=
 =?us-ascii?Q?AAAz594nIPamfU/Xl9YDuGoU++y6i1UzOIyHeiaN8MJ9OeT3lKfi2RL/ZPZ3?=
 =?us-ascii?Q?8AGPk38jSt5gDjC/Ez+p8X2Qk7H/IGvgcP+sBYXmz7kRtJlMh7b3t72YM3m8?=
 =?us-ascii?Q?7xl+SDOU0XaHE49w8qqHT5Z7VT5qUYVzegpL1OLMlwhHGKADFjw8+aU9jktW?=
 =?us-ascii?Q?LAWZZbwlMnyiHPH0bhNkhqzGDw23XUUQKDkWYDRxp0TiEbQ1BvtvmLI0Lvmb?=
 =?us-ascii?Q?IeYid03jkvW/N63iYlTqn39jcrxUf8UiATH/heqJ9KfMWEwhm39b7EgGVl9/?=
 =?us-ascii?Q?uTPvYAC9XqrTK0ZXbeQZGfKMyF7orp/VxsTl5PoXzCxjrh6iFGqVILuKSZ1g?=
 =?us-ascii?Q?3wczUh2+VEZ8S9XatfCCNtakArMSvEwpIoALSjeoI8zhkFg7aITOt8Yz+Mlm?=
 =?us-ascii?Q?jdqoHqCNfGwLWkWoIiu/cFix9hhSIfPgL+tld6jhxSmdBsWCnwedfv0+IvMX?=
 =?us-ascii?Q?StIlDjizJNFCiq0TFIcasUcJK2VO/ub0uCbXoAMCYLG7TVJ7lfUvHMSJzcWz?=
 =?us-ascii?Q?C8n11ThdyjF3ZWEVkRhP0kBcq9ls9zEJ8DzercSRr76SIGg/+KFLRaACVRgk?=
 =?us-ascii?Q?op1+BD2K/awHFMZhQrybd8koJp3LwkSQROCZVOUliYCD8z+BpGbdnfQf7QA+?=
 =?us-ascii?Q?YiF87Y5hb6cC3Ef3fspFbAMCMdo+LcaG3PNTseaDLKJoQq5q9c5x6trp+Kse?=
 =?us-ascii?Q?RvxyinM1FA/+5ns25svLbFtRdC6p5MetLhIZ5beFkLO2iabjrFUkEeagdlaU?=
 =?us-ascii?Q?IejoX5cEsWeoa4DeOM3RbEeAg/OS2TMF9lrGXXLdyPwif861QeOR9/JEWDD2?=
 =?us-ascii?Q?8L5E89R2QqFnK89MhkrfH8w3umnNSpflUfjYYDukVHhXnCcW8gc7b4MncgfU?=
 =?us-ascii?Q?RRRnDRUZzELCk4oFMwftkUmNX1UFwGM/FAXYvTVfai8QON4Mu0DKn2jke9sL?=
 =?us-ascii?Q?dLTE7Mv0KoKkYylPpMAVGdPYdsdzhTsamWEolDZm2GfSPUJvX7bjdXHQfsis?=
 =?us-ascii?Q?hbfqJbHK7cdB7CKqdBiCpfAckoWar8v3WqerfyEC55ORpdXUCTFbdI5jhsPT?=
 =?us-ascii?Q?COrmzNtmLvRIBClTAYaUcnKgP/O+prCRKBEF+JylgzbURP+LhcKsxKPGfcq+?=
 =?us-ascii?Q?VFdtRUWNYa1LmcBhmaxF/5g8bGgOwJbgRr2mPVxWD1Rl8mS8WJY4iSj9Ypii?=
 =?us-ascii?Q?ew8pMNKBfZQz4Nk+ZXZziMwj05nkz0/dDrvnZck5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b63ae325-c033-443c-2b67-08dc2782addb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:15:39.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xjzt725SiOz10i2Y0NWtaaz5kGDP9T9+nZD+xhPO4UXhJK0IhqIYbWBaxOTfxxo6p38cFmtTno0t9dikHqYbrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com

On Tue, Feb 06, 2024 at 02:21:29PM +0000, Greg KH wrote:
> On Tue, Feb 06, 2024 at 08:17:03PM +0800, kernel test robot wrote:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > 
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [v6.6][PATCH 09/57] eventfs: Use ERR_CAST() in eventfs_create_events_dir()
> > Link: https://lore.kernel.org/stable/20240206120947.843106843%40rostedt.homelinux.com
> 
> False-positive :(

Sorry for the false positive. The bot wrongly parsed the prefix
"[v6.6][PATCH ...]". We will fix it ASAP.

Best Regards,
Yujie

