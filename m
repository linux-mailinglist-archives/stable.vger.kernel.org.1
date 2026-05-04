Return-Path: <stable+bounces-243887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ3gCBPZ+GlR2AIAu9opvQ
	(envelope-from <stable+bounces-243887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:36:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855014C1FD0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 769073017501
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B439BFEE;
	Mon,  4 May 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVCe/C/g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58041A9FAF;
	Mon,  4 May 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916176; cv=fail; b=TBXVItbmExC6aIdQ0KZrRfjVw97Ls9tKuf2hzruWzlUDuBFdlo+IApppJ4ljjVOX9Z5K/UyVpMX3/MW3pd0i7Bm/FEC/v9Q23lr7C7LJCBIBgHlGaTaqOhxhgaEDhk2zetdo1CmeaTmlKYCXBNr7BvN5WwYWfaTphnRPQIvaSB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916176; c=relaxed/simple;
	bh=Golc/wAhV8+ewkCiuEFtHlKrNgffTIcrTzOMSBZNN7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cW66u6niawyLKBkwbwEuEI6PIdjbxjlDJKYXtmIpFoxQR1HNvE4UAgUjVTJD29bDn2tert94I8cHpro5wF+f48AbGjCdeNvauZgOSsFLYLuVcJDka0OYasu84B4HSH1DpTnvAk9eXDxgWGjbjMbpenLthW7Ve9HExjD1HKB1FTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVCe/C/g; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777916173; x=1809452173;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Golc/wAhV8+ewkCiuEFtHlKrNgffTIcrTzOMSBZNN7Y=;
  b=ZVCe/C/gFjibcU1LMSSAM1PvxODgrqKxoaV+KpCS/g38rCxGxMJWSoRu
   ofpqYdSpipEXAt1ni9kWSStaDj+gJiIJvSx/Uah3eU9kz5mKOkz+rl8LA
   kS2UlvztXokHz26tuMTlKKtafU1j9AWU+31Yc0RmnUVRSOqhYDxjQNUOs
   n2h7Xtml2qDZRd675iLtSEP0Ax2rgr1dz84NTq8cchJCFkbgdPBNLgwQI
   D/uPjzjCyPF0HChe/ItWfBCCh7JKm5Ahk8GhF5ad1r/wPUMWDPMgJWGur
   juk2VstnMclVj6iWcHNJdph3DTjR0lshIp5O33ns99RopUBj4QtBBIGsE
   w==;
X-CSE-ConnectionGUID: piRO9A/rQ1GLG4G7r+mgVA==
X-CSE-MsgGUID: 3r6rTRSXScyytE2lPdvNvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89083931"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89083931"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 10:36:11 -0700
X-CSE-ConnectionGUID: RxjTNNI/QjWMO6454t5W2Q==
X-CSE-MsgGUID: H30KRS8fSkC3EMOvJ36E4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="231208189"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 10:36:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 10:36:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 10:36:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 10:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9EbHEXhMED2o8Reo9DxA7gs0PT/AWdcUEV63lBzg6O04YivAnX1kVhdOWTrfbm4/LUBCYk7A+RPq+UQF2i8eatSLnouEYYDNE3vp1MgTyGJGXsHT5KkkHcJ3UMU9A+rQHEbc79B2cPuvwp3g2cIBYcdJPwhhZHYW161gpgf2RPaashLvVZ+1vIASZgpQ2rEMUH+IkbupH2ReOTE0kO/198CUg8Eh8qRvlmzaw9g/VbiRUzIfWB3cnWKMrSQJB1B0H70FfnTwigxj6hucA4WPefJh487ogL5StxpMhUXzy1nCx7JsEHzDQuFDMCjhj1qPyGMEKxhsauFUJ8bVvte2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ncIXBOA67lAnBqLe5Tw51kNWWfhn1TMAAhl0FXE0ZQ=;
 b=BG/mbd6e64bXQg+09/2hLAcrU+EQQKE4s4IBEOnsiqIoE5ED1iuDPgqg5EacGrvO6TyuFLXdsrLxVQ1AFApEV4/jgnhv+YgvNFJnX9qE7ZT8zpDUNxphqOYA0JR4gE1YU54ZNW/cq7+HBT969An8HNyuJac8RIyls1+XLU9UhFvO1knb+nQpkHrit2n1H0tREJxRuCczy+AjClt1jwkDCUBw5/P6iA7wqjlui3cQ1MLB48jc9tOrQ9Ccu7lZ3nc0XyS8Mow6crxn1iBn2XQ6iQMGE1oiu/P9+94jGDPk4jPR3w/j9xtN1d8+JWAozsyz2XgVnM+JZgDtxiXZd/x9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by LV0PR11MB9838.namprd11.prod.outlook.com (2603:10b6:408:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 17:35:59 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 17:35:59 +0000
Date: Mon, 4 May 2026 10:35:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/ttm/pool: back up at native page order
Message-ID: <afjY/OHiSovekTTX@gsse-cloud1.jf.intel.com>
References: <20260504042619.2896273-1-matthew.brost@intel.com>
 <58ea6837e2aa808bf9f3ba304395058a2d08b8d0.camel@linux.intel.com>
 <afitheEYRoy7VoPu@gsse-cloud1.jf.intel.com>
 <017d25edabb2e4f60da7421278bffa20f51b0142.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <017d25edabb2e4f60da7421278bffa20f51b0142.camel@linux.intel.com>
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|LV0PR11MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b89a97-6393-402a-0c1b-08deaa039a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|20046099003;
X-Microsoft-Antispam-Message-Info: Dvm60QuSjm572OQcWGga2o8OH4tqfKRnX3Ycmd5bwqyhlXS4bqq80RCziazjK45jobQtSUN1LW6EwbkAf10JCTsVdxr0yDW5MkySqfWhiKjJ7L6oqml3pjBS+d/PUgitQWPncYBWb5KLqkFN0tw5UJMZ0q9fUztwcOZrlq4gEYTyodiFfdttylBWfhhZaejjglyQWwPcCo/CgKvZLEH+7RuHQ1RyIY45bGjz5y3HEJitUrQiyZ1bnYvvWoa6CECPmQ4xp0+xBRtc2bRAk/R79dj6Bi2hV57ZoqVRc5wtDqeWaEcmOHMzrTSo1koAbtpvuev+4rGtTWJ5lACbCmZKVx0jgBJKI1obcmshICNXqoM0jw7ioG2HcIiOmIlux5ID/GoSuRYOTVa5bwFSiR5CJvVDoVgt7KrZBOr8jnl79gjbu3/r/QexLB3WT6N0WYVkd1o219i9E6bwyj/WJWuxeVmLr2cg3uMDPJcE8WuRZyrxHjhvnKYEwmcjnLlBYvOyPQKUHmNcs92fDp+PD4C9pNZtSrV+1PQHcPceQfT/PlmaBts7zgPTai2IPej2hQ4VTBSOpTNEuDBQjXeZ/T5w2OYvoKBXtzafOLQUESPhOuv8iUQNJkKFLn1XMyqH+yO23qLEVcGZI1SMIY6o54wLjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhzRlk3NElsWTBCb3UvemVEL25rTnNKWVF5Wkx5ZFBjdDBVOGFVNDU3cENG?=
 =?utf-8?B?N3daVGh3djFkK0hIM2VpaUkrcEhTK3FvTmF2Y1pyVHEzQlNwSzhxUTg0VzZa?=
 =?utf-8?B?ckxWR3paVnhaeUlmU1l2ZE9GUWI0bUNvL3VNRzRYS0g4STY5aVkwd1VZem9Z?=
 =?utf-8?B?YkI5ek9DcVBFQlQrWGFlUE9QZ0RhbnBFVURkVU1EOGNkNjVZbVVRYll1U3Vq?=
 =?utf-8?B?VWlTekJMVFhUUVMxZEJyc0hmRVFFSEkxR2JrTkZpUUtVc3ZGZEl6a0lQajJ6?=
 =?utf-8?B?MWVsSUdab3ZFL0d0VUNKOHdmU25BbURLR2N1R2VlK2d1c0IwVXJ4b1gweTd6?=
 =?utf-8?B?YWhWdHhxV0hRMnR4WG0xLzJIcEtkSTFNWVMzOE05MDN0VWtjS1EyZDBwN0dW?=
 =?utf-8?B?T292M0ZKa3J2NkZZTUtKQWdCWXdxc1R5MUJrZFhkM0toZ25GanhxblBIOCt4?=
 =?utf-8?B?cFRNaGRxaFRrN0c5UVdxMXVhMnJRQlBXWTU4UkMxSktMNnlRalBZTHFsQUZB?=
 =?utf-8?B?STdoMXRiT3h1WEJudEIwdGlROGFvMmdZNlN6cmhiUCs0bzRlR0FvQm5YbDF0?=
 =?utf-8?B?c1NwcUNGQ3FlYysyM2pheld6TDNTamExRHZPWnVvQXJzSW9EakFtcU5qRjNw?=
 =?utf-8?B?Z1RvaWd6aXpaN1RzSkRLVU5BNVpFcnVwaHltVDVqOWxyT1J4NjJBQmd6NS9N?=
 =?utf-8?B?R0puYTlKdUNyT056R3dBb1V6c2IyYkRVZXoyYlhNd2syRVp3OStTN1RHV1Bv?=
 =?utf-8?B?K2JZZ096Q1B5enRxckp6ZUkyU3F0eS9zUUlRelJLNjI5NnpZS3l6cmJnTDEz?=
 =?utf-8?B?RkNTWkNXTWZuVHFRMkROUFVxZEZmWWxXWGtQcmVYQUgyMWZ1OXhWUVRJMnJM?=
 =?utf-8?B?VnhZUXdtY3JLUi9paUtRbFdyOHlHTkc1clplSnJ1TFZQNVdoUENJeEhSU3JK?=
 =?utf-8?B?NGFWZThQMUdYZVZXZ3lJNlpabXNra3J5U25FcENtNnJ5OWVIa1ZuNi9yWkxO?=
 =?utf-8?B?MkhkMGhyeHlmZ2VhTUZJTi9vYkZ2UmJmZmdXTzVJQnhpL1JXVWJtcUJRUTNE?=
 =?utf-8?B?MHQ3NkdaM3hwT0J2clNYbkNoQWROam9TN0k5QlVIenpZQlV5d2RPQkN5VGR6?=
 =?utf-8?B?R1lSQ1JHT0FUY2J5VllJenV2WVJ3QW8yLzZjN3pTRFdWYVdRU09iVTk1bGdn?=
 =?utf-8?B?aWdxOFVPUEd3SGJzVW5NTHE5QlMvMHdOK3ZCR3ZvQlRWNkRIZWh1bFArLy80?=
 =?utf-8?B?VWdVNGxhMVAyTTVYckZVR0JiVnBUeWJ2Q250anFTVG1SVWFPb1VuVTBOQ0U3?=
 =?utf-8?B?SUtacklld1BCODMyOWVTa3JKVFdEUk5aS2NUWSsreXRKK1RwZkhnZjFLRUFF?=
 =?utf-8?B?Vyt0aWZUTDdPUG9xck1sY254Q1dEenVteTdPOWJ2SVhSeUNHVFBETmVsVjcz?=
 =?utf-8?B?MlEvb1ViQjI1SWRqakZaL0dCa0JldmFoM3hBVDF1YVlHQkgvWk1xTjZZeTFE?=
 =?utf-8?B?a3k1dnUvaWNoWTlIYkhySzl3eEpURGlmSmR0Zm93V284V0FVYnpDeW5tb3Rq?=
 =?utf-8?B?NHdUY085WnU1K0p1VVJtOUhwK2hJeDNudnNPT2ZGdWI1aUlJbnpESURXZ09a?=
 =?utf-8?B?YldIQVZOYVVTZCs5Wm5VbW5kSk5xU3dnRlVjM25vK2k1a240UzQrcjB3aG5Q?=
 =?utf-8?B?SUt4MjcraVpSOW10b085ZnRJaDJPL0d1TzRybHJxT3lCSU9pTy9WZFA1ZzNk?=
 =?utf-8?B?N081c1FOclJNS2RBbkNFYWFpYXllNjhVNFVFV0xZWCtYMnNkdmJJSjZBQzB1?=
 =?utf-8?B?OUtzRzV2NGJSL1FJUklucjcwTHJwK296VkZKakVaT1hkMEhaZ05KWkxJbVlj?=
 =?utf-8?B?c1lLMkJGKzF6cHN6UWF0OVJWNTB6RTRSaDJUcHV4TGpJL0NaYUNMYUw1SlBx?=
 =?utf-8?B?OFdzazZDMW5aT0oyNzBqK1o4anUyWjF0V1ZSemd1ejZpcysvVG9sVU1hdFZk?=
 =?utf-8?B?dTN1SVdHaEx2L1o5Rm1yK2RiS3FXc2pmQzFwc242cEJZeXpNKzZadXBvdDk3?=
 =?utf-8?B?UUtJejNoY3VKTEdJMWhKbnh5MFlzdCtmQXY4dU1FN1F1YnBMTTkxNjNWc1Rk?=
 =?utf-8?B?MUVCU1ZjUzBkWFlWbjF4QzZmVEN6TkdMQ1EvcjVabXY3VGxhdDlwZzJIcXpZ?=
 =?utf-8?B?elE3YlFXcWIxak9NWVFTSDM0YzJaTDN5eVBpUWtPbmhMcmprajJPU0ErUGJG?=
 =?utf-8?B?K3VlUTNxaGhUcE9jQ05yK3p2ZmZwSkx0RWxHZUJaUkxKcDVlaGgxUEpOdm5O?=
 =?utf-8?B?cGsxMEw1WUpOL2Yvb3RoY0RPbkNyS05xZmRid21jYS9GS2VDb3VHN3lxdzVF?=
 =?utf-8?Q?oLxRRyZGxhH471oM=3D?=
X-Exchange-RoutingPolicyChecked: tyoMonfFzoA6qYtXLfiY4xcB6mjGvY5ZhrtgYfvjkvuWd74ejh0qJTdSDjU6DxJNYMnTb5z1YJMq0X7Z5mCqyQORECke0l8B9SUfCP7mNEGeitUx9LAbgC2PewXF2SC5rdIS8UHi+ix/aCoddAhhDs+hrGcIAqUUgHdRK+hMzod+K1JOxAmEPlNj/OeVSezDtngybN9+2ovHE2BMHRNJ/NmqvR8/6gkRlneOrKu3DIzoOZlcbnZFjm6UoQO3NaRerX0okngM9xmE7Iz0s/sjlWjGW7fr+HvJ5rEEn15d6mbR860UIFG9OC8u5YQFdFn6iSyrRBuot3zmeXOKwR2auA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b89a97-6393-402a-0c1b-08deaa039a8e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 17:35:58.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5Qt66lo9AJ67bRN23bPrYnTl/Sb1LpmueSk/sboz0dFQ2pjob7pj7QfocPxgU0Uw2PlCIYKQK2ECy1XLPswog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9838
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 855014C1FD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243887-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Mon, May 04, 2026 at 05:19:42PM +0200, Thomas Hellström wrote:
> On Mon, 2026-05-04 at 07:30 -0700, Matthew Brost wrote:
> > On Mon, May 04, 2026 at 10:35:23AM +0200, Thomas Hellström wrote:
> > > Hi, Matt,
> > > 
> > > On Sun, 2026-05-03 at 21:26 -0700, Matthew Brost wrote:
> > > > ttm_pool_split_for_swap() splits high-order pool pages into
> > > > order-0
> > > > pages during backup so each 4K page can be released to the system
> > > > as
> > > > soon as it has been written to shmem. While this minimizes the
> > > > allocator's working set during reclaim, it actively fragments
> > > > memory:
> > > > every TTM-backed compound page that the shrinker touches is
> > > > shattered
> > > > into order-0 pages, even when the rest of the system would prefer
> > > > that
> > > > the high-order block stay intact. Under sustained kswapd pressure
> > > > this
> > > > is enough to drive other parts of MM into recovery loops from
> > > > which
> > > > they cannot easily escape, because the memory TTM just freed is
> > > > no
> > > > longer contiguous.
> > > > 
> > > > Stop splitting on the backup path and back up each compound
> > > > atomically
> > > > at its native order in ttm_pool_backup():
> > > > 
> > > >   - For each non-handle slot, read the order from the head page
> > > > and
> > > >     back up all 1<<order subpages to consecutive shmem indices,
> > > >     writing the resulting handles into tt->pages[] as we go.
> > > >   - On any per-subpage backup failure, drop the handles we just
> > > > wrote
> > > >     for this compound and restore the original page pointers, so
> > > > the
> > > >     compound is left fully intact and may be retried later.
> > > > shrunken
> > > >     is only incremented once the whole compound succeeds.
> > > >   - On success, the compound is freed once at its native order.
> > > > No
> > > >     split_page(), no per-4K refcount juggling, no fragmentation
> > > >     introduced from this path.
> > > >   - Slots that already hold a backup handle from a previous
> > > > partial
> > > >     attempt are skipped. A compound that would extend past a
> > > >     fault-injection-truncated num_pages is skipped rather than
> > > > split.
> > > > 
> > > > The restore-side leftover-page branch in
> > > > ttm_pool_restore_commit() is
> > > > left as-is for now: that path can still split a previously-
> > > > retained
> > > > compound, but in practice it is unreachable under realistic
> > > > workloads
> > > > (per profiling we have not been able to trigger it), so it is not
> > > > worth complicating the restore state machine to avoid the split
> > > > there.
> > > > If it ever becomes a problem in practice it can be addressed
> > > > independently.
> > > > 
> > > > ttm_pool_split_for_swap() itself is retained for the restore
> > > > path's
> > > > sole remaining caller. The DMA-mapped pre-backup unmap loop, the
> > > > purge path, ttm_pool_free_*, and ttm_pool_unmap_and_free()
> > > > already
> > > > operate at native order and are unchanged.
> > > 
> > > This split is intentional in that without it, we'd need to first
> > > allocate 1 << order pages from the kernel's *reserves* in order to
> > > later free 2 << order pages, making the shrinker much more likely
> > > to
> > > fail in true OOM situations. (I believe this was one of the reasons
> > > the
> > > initial shrinker attempts from AMD didn't work as expected).
> > > 
> > 
> > So where exactly is allocation done—shmem_read_folio_gfp or
> > shmem_writeout? I did notice and called out, in the commit message,
> > that
> > those interfaces are a bit confusing with respect to whether they
> > actually work with higher-order allocations.
> 
> The interesting one is in shmem_read_folio_gfp(). This used to be 4K-
> page only (but i915 had some tricks to make this allocate 2M folios).


It looks like to_folio() in ttm_backup_backup_page() (the output from
shmem_read_folio_gfp()) is always order-0—at least with how I have the
kernel configured.

I see what you’re saying here: we need to allocate however many order-0
pages are required in shmem_read_folio_gfp() before we call
__free_pages_gpu_account() on the higher-order folio we’re backing up.
In the worst case (again, with my kernel configuration on x86), this is
order 10 (4MB). I think certain Kconfig options can make this larger,
and on platforms like ARM these higher orders can represent huge amounts
of memory.

> My understanding (to be verified) is that this recently was changed to
> allow 2M by default, and also to allow 2M folio writeout. Writeout
> moves the folio from the page-cache to the swap-cache and then starts a
> fs writeout operation. Pages are put back on the LRU and are freed when
> writeout completes.
> 
> As I understand it, shmem_read_folio_gfp() will also potentially
> allocate memory for the shmem object radix tree.
> 
> > 
> > Also, FWIW, this patch by itself seems to greatly help with
> > fragmentation, and I haven’t seen the OOM killer kick in. I’ve done
> > things like running WebGL in a bunch of Chrome tabs, then running
> > bonnie++ (which basically uses all memory), or running IGTs, which
> > also
> > use all available memory. Based on that, I’m leaning toward this
> > patch
> > alone working as designed.
> 
> Good to know. Perhaps it would feel safer if we completely restrict the
> xe TTM order to 2M and below (if we haven't already).
> 

We don’t do this today, but that seems like a reasonable idea, although
the default order-10 on x86 isn’t really all that bad either.

What if ttm_backup_backup_page() fails while we’re trying to back up a
higher-order page - We could then split the page, free the pages up to the
current point of iteration, and then retry to make forward progress. If
I recall correctly, if it fails again, the shrinker gracefully handles
partial backups.

> > 
> > > 
> > > I believe the solution here is in the ttm_backup layer, We should
> > > introduce a ttm_backup_backup_folio function and either insert the
> > > page
> > 
> > I think something like ttm_backup_backup_folio() makes sense, again I
> > called out in commit message.
> > 
> > > directly into the shmem object (zero-copy) or even directly into
> > > the
> > > swap cache. Then we should completely restrict xe page allocations
> > > to
> > > only allow THP and PAGE_SIZE (Possibly 64K pages, but they'd either
> > > need a split or perhaps they are small enough to be backed-up using
> > 
> > Yes, I did raise something like with Christian too [1]. IMO the
> > driver
> > should be able dictate to TTM the orders it likely to allocate at.
> > 
> > [1]
> > https://patchwork.freedesktop.org/patch/716362/?series=164338&rev=1
> > 
> > > one-go copy, similar to this patch, but in the backup layer). FWIW
> > > at
> > > the time the shrinker was put together, AFAIU SHMEM split large
> > > pages
> > > on swapping anyway, but since that appears to have changed, we need
> > > to
> > > catch up.
> > > 
> > > Inserting directly into the swap-cache WIP is here, rebased on a
> > > recent
> > > kernel (This is an old idea that has actually been out on RFC
> > > once).
> > > This needs a core mm bugfix (also in the branch), but I'm not sure
> > > the
> > > swap cache is the right place to do this, at least not if we don't
> > > immediately schedule a write to disc, it looks like current users
> > > don't
> > > want to keep pages in swap-cache for very long (related to that
> > > bug)
> > > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/thp_swapping2
> > > 
> > > Inserting directly into shmem (A fairly recent idea that is mostly
> > > untested)
> > > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/insert_shmem?ref_type=heads
> > > Since SHMEM schedules writeout immediately when pages are moved to
> > > the
> > > swap-cache, it's not as susceptible to the above bug, since swap-
> > > cache
> > > entries are not typically held for folios for which we haven't
> > > scheduled writeout.
> > > 
> > 
> > Let me take a look at these branches today.
> > 
> > > We should try to solicit feedback from mm people on these two
> > > approaches.
> > 
> > +1, but I think we should stop here if this patch, as‑is, is OK to go
> > in—ideally as a fix—since, based on my testing, it seems to help
> > quite a
> > bit and current upstream shrinker is badly broken.
> 
> Well I think the problem with testing shrinking behavior is that we
> haven't had good test-cases, so we don't really know if this change

I agree that we don’t have great test cases. We can try to get some
better IGTs, but I really think we need some end‑to‑end testing like
what I’ve been manually doing (e.g., opening a bunch of WebGL tabs on a
system without a lot of memory to trigger shrinking, and/or running
memory‑heavy workloads on the CLI at the same time—compiling the kernel
with a large number of threads is likely a decent option).

> would break something that currently works. In the shmem documentation
> there's even some wording about concerns that the shmem radix tree
> allocations could accumulate and drain the kernel reserves. 
> 
> According to Google AI, the kernel reserves are around 2MiB times the
> number of zones, controlled by vm.min_free_kbytes.
> 
> But I think if we would push this or something similar but then we
> should 
> 
> *) Move the ttm_backup interface to be folio-based.
> *) Restrict order to 2M

I can 'Restrict order to 2M' in this series if you think it is a good
idea.

> *) Craft a test-case that triggers a shmem_read_folio_gfp() error in
> the backup path and verify that they do behave gracefully.
> 

I think, as a stop-gap and backportable fix, this patch plus a fallback
to splitting with error injection (I have error injection in this series
but I have ran and injected errors) is a reasonable option. Longer term,
yes, moving ttm_backup to be folio-based makes sense.

> And then as follow-ups:
> 
> a) Investigate direct shmem insertion.
> b) Address any remaining flaws from partially backed-up bos.
> c) Cgroups integration, following up on airlied's work ensuring that
> the evictee is charged for the shmem memory.
> 

And then also +1 on exploring these options.

Matt

> 
> Thanks,
> Thomas
> 
> 
> 
> > Matt
> > 
> > > 
> > > /Thomas
> > > 
> > > > 
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper
> > > > to
> > > > shrink pages")
> > > > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Assisted-by: Claude:claude-opus-4.6
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > 
> > > > ---
> > > > 
> > > > A follow-up should attempt writeback to shmem at folio order as
> > > > well,
> > > > but the API for doing so is unclear and may be incomplete.
> > > > 
> > > > This patch is related to the pending series [1] and significantly
> > > > reduces the likelihood of Xe entering a kswapd loop under
> > > > fragmentation.
> > > > The kswapd → shrinker → Xe shrinker → TTM backup path is still
> > > > exercised; however, with this change the backup path no longer
> > > > worsens
> > > > fragmentation, which previously amplified reclaim pressure and
> > > > reinforced the kswapd loop.
> > > > 
> > > > Nonetheless, the pathological case that [1] aims to address still
> > > > exists
> > > > and requires a proper solution. Even with this patch, a kswapd
> > > > loop
> > > > due
> > > > to severe fragmentation can still be triggered, although it is
> > > > now
> > > > substantially harder to reproduce.
> > > > 
> > > > [1] https://patchwork.freedesktop.org/series/165330/
> > > > ---
> > > >  drivers/gpu/drm/ttm/ttm_pool.c | 71 +++++++++++++++++++++++++++-
> > > > ----
> > > > --
> > > >  1 file changed, 57 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > index 278bbe7a11ad..5ead0aba4bb7 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > @@ -1036,12 +1036,11 @@ long ttm_pool_backup(struct ttm_pool
> > > > *pool,
> > > > struct ttm_tt *tt,
> > > >  {
> > > >  	struct file *backup = tt->backup;
> > > >  	struct page *page;
> > > > -	unsigned long handle;
> > > >  	gfp_t alloc_gfp;
> > > >  	gfp_t gfp;
> > > >  	int ret = 0;
> > > >  	pgoff_t shrunken = 0;
> > > > -	pgoff_t i, num_pages;
> > > > +	pgoff_t i, num_pages, npages;
> > > >  
> > > >  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > > >  		return -EINVAL;
> > > > @@ -1097,28 +1096,72 @@ long ttm_pool_backup(struct ttm_pool
> > > > *pool,
> > > > struct ttm_tt *tt,
> > > >  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > > should_fail(&backup_fault_inject, 1))
> > > >  		num_pages = DIV_ROUND_UP(num_pages, 2);
> > > >  
> > > > -	for (i = 0; i < num_pages; ++i) {
> > > > -		s64 shandle;
> > > > +	for (i = 0; i < num_pages; i += npages) {
> > > > +		unsigned int order;
> > > > +		pgoff_t j;
> > > >  
> > > > +		npages = 1;
> > > >  		page = tt->pages[i];
> > > >  		if (unlikely(!page))
> > > >  			continue;
> > > >  
> > > > -		ttm_pool_split_for_swap(pool, page);
> > > > +		/* Already-handled entry from a previous
> > > > attempt. */
> > > > +		if
> > > > (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > > > +			continue;
> > > >  
> > > > -		shandle = ttm_backup_backup_page(backup, page,
> > > > flags->writeback, i,
> > > > -						 gfp,
> > > > alloc_gfp);
> > > > -		if (shandle < 0) {
> > > > -			/* We allow partially shrunken tts */
> > > > -			ret = shandle;
> > > > +		order = ttm_pool_page_order(pool, page);
> > > > +		npages = 1UL << order;
> > > > +
> > > > +		/*
> > > > +		 * Back up the compound atomically at its native
> > > > order. If
> > > > +		 * fault injection truncated num_pages mid-
> > > > compound,
> > > > skip
> > > > +		 * the partial tail rather than splitting.
> > > > +		 */
> > > > +		if (unlikely(i + npages > num_pages))
> > > >  			break;
> > > > +
> > > > +		for (j = 0; j < npages; ++j) {
> > > > +			unsigned long handle;
> > > > +			s64 shandle;
> > > > +
> > > > +			if (IS_ENABLED(CONFIG_FAULT_INJECTION)
> > > > &&
> > > > +			    should_fail(&backup_fault_inject,
> > > > 1))
> > > > +				shandle = -1;
> > > > +			else
> > > > +				shandle =
> > > > ttm_backup_backup_page(backup, page + j,
> > > > +								
> > > > flags->writeback,
> > > > +								
> > > > i +
> > > > j, gfp,
> > > > +								
> > > > alloc_gfp);
> > > > +
> > > > +			if (unlikely(shandle < 0)) {
> > > > +				pgoff_t k;
> > > > +
> > > > +				ret = shandle;
> > > > +				/*
> > > > +				 * Roll back: drop the handles
> > > > we
> > > > just wrote
> > > > +				 * and restore the original page
> > > > pointers so
> > > > +				 * the compound remains intact
> > > > and
> > > > may be
> > > > +				 * retried later.
> > > > +				 */
> > > > +				for (k = 0; k < j; ++k) {
> > > > +					handle =
> > > > ttm_backup_page_ptr_to_handle(tt->pages[i + k]);
> > > > +					ttm_backup_drop(backup,
> > > > handle);
> > > > +					tt->pages[i + k] = page
> > > > + k;
> > > > +				}
> > > > +
> > > > +				goto out;
> > > > +			}
> > > > +			handle = shandle;
> > > > +			tt->pages[i + j] =
> > > > ttm_backup_handle_to_page_ptr(shandle);
> > > >  		}
> > > > -		handle = shandle;
> > > > -		tt->pages[i] =
> > > > ttm_backup_handle_to_page_ptr(handle);
> > > > -		__free_pages_gpu_account(page, 0, false);
> > > > -		shrunken++;
> > > > +
> > > > +		/* Compound fully backed up; free at native
> > > > order.
> > > > */
> > > > +		page->private = 0;
> > > > +		__free_pages_gpu_account(page, order, false);
> > > > +		shrunken += npages;
> > > >  	}
> > > >  
> > > > +out:
> > > >  	return shrunken ? shrunken : ret;
> > > >  }
> > > >  

