Return-Path: <stable+bounces-147979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF0AC6D2A
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D968A4E2523
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D651C862F;
	Wed, 28 May 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XS+e70lb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578531C860C
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447244; cv=fail; b=h/DKExjFVfyiojONOc5nJg+Ll06VMtcjO9gO5g86sPMp7/H+9LBvZGvQ6Dpnit+b3vqsejlr7OAKs6jfh2BEXopm/rBM5dTkDktdbEAekTrLrUa0oJZE2Qw/XQNLf1f2FvCm2H9x3I7QAOi88/0BZFBhJeXcXxZk6knhq/k68E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447244; c=relaxed/simple;
	bh=j424SKDLnkUMSjULDvT3cIrxS+WE1pFYtQGrXT5jn/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azP0/7i9c3Dzx65kHp5/uWMKITPHKAozORZOb7/91EYpb6iijkuCy1F/lOa+HuysP0/ZGtOtqvb8f+1lFHyp8inXwoCL4qn5Qfq07JZyTaSSbB9Fk1NdPT04WTL0Ze2AMF3MkcWBG9eXI6RDVWLD0ZISmUgLBHzR16Sam51bARY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XS+e70lb; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748447242; x=1779983242;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=j424SKDLnkUMSjULDvT3cIrxS+WE1pFYtQGrXT5jn/Y=;
  b=XS+e70lbjCRY7LLclQJh3PI2ZU4ku6sz/9y9mZK3gcfwhi5vAHD1K5no
   xTAtBwZK+nZFPFAGlSRao9uX/joa31SQPGfhKVj1REjPKvt+DAwCVxTFk
   On1y4gzGvtKRkyl9IYpeNeeF6LTxx9AEdNrYT9QTRgF1TOt0HG/g4qnBS
   nlMNMyfDoQvd3creoUQ6ui0njAHwRTRe1euAUZU13x5V2Ara/Qp41hvH1
   TsxH4g25s9yctWIbxO48CZYrV5D+O6tTtwx9iqKFndT6XQdLy03HAA+Ns
   pdMIKm26o/4BSWUTp1REcWkp1kzFdGyx7Tuf/kxV3X60DnT/ZujjQeG1a
   w==;
X-CSE-ConnectionGUID: KApa8YiETp6EFhhfq4919g==
X-CSE-MsgGUID: 0fAJ7dqFTc6rxQaysAVUBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50407486"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50407486"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:47:21 -0700
X-CSE-ConnectionGUID: 8TfnYb+tSn21oSdSG5s1+w==
X-CSE-MsgGUID: uyKjIjJHSyCxrcKEQLNeKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148580885"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:47:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 08:47:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 08:47:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.42)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 08:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/3xG10s+bigBAiyLiaD8I5YnfIGWw0iYSDAT7djFLbtYb5jUZCrCh/XQ+XRt9U2m3qbpURsaznkuH66ISjwaQ+TQONApGUpKmu/QLuqUyGgmQCrLTss1rzil1+Z5CcM4nKhyLWkN9v/x52z3PxetIVsQ/3/BeK735XbaCvY/e2WCY5y3JlXIeEqaCFMEDnN0AsA1svKfjSeTOOk2HwdJjOdLpQTZ/5YHpRXdEFP+8quC9oUZEXUadjuY2cBEhU/YyS6g9xNvi+mYTZh2DEC3X0FwjnqKjB97Kr1eyBML4com0X+40ppY+h3DaV1VpXCSPyMU3OYTwPGrHQnmCrnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qevzqsUNYn14/Gj+KTpOiRiY09sRpDzAY3Oec3bWOGs=;
 b=tXEupuL+JdZo6Xta5ZcgFFkdLvKOc88GpE66xDXUTHJ3BojUtKJmiI/9S4o3lCZrzm6abTWFQ/eHm+8iIzOo/7BDVku4eOklA/iwBJMZWWN5bXTgnYnhdJGbTdU5cJYH680KLTvJM7Bt5eE0hXquIk8EanOaMvCi3V7e1aYSSADqGRGcRXgyUwHMggweX4kXrOQBwRZ3FMQy9DOQt+UGfKXrJknIUK22i2PN5w7iV2UbWBKf4Py+rws6fijDO2mpxf/37PgN/ktFs2twgN5wEkhYNSxcllPe32tZ9aHWUl3/zZ52LgzaVebBZ5zF0Bw5sw8ZswJafHfVWbRSVn3jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 28 May
 2025 15:47:18 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%5]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 15:47:18 +0000
Date: Wed, 28 May 2025 08:48:49 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Tseng,
 William" <william.tseng@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
Message-ID: <aDcwYSHft86dfxq9@lstrano-desk.jf.intel.com>
References: <20250528113328.289392-2-matthew.auld@intel.com>
 <SJ1PR11MB6204E84396E9C554AE7E80328167A@SJ1PR11MB6204.namprd11.prod.outlook.com>
 <aabaf5db-92aa-4ec9-b0a8-6eb9694fa7c7@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aabaf5db-92aa-4ec9-b0a8-6eb9694fa7c7@intel.com>
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 03553ba6-5085-4719-caad-08dd9dfeece4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JaPtyeaLUzAyhZ4h3C30mZOn4LQNx8uMhXAt/r394/765UbVl3Tx8wMtBV?=
 =?iso-8859-1?Q?PZp9oJxBsF4un/VzDMGYvZvBWzUH1nelST1p0RwHqxOgdXCo3ZT4CR9j6s?=
 =?iso-8859-1?Q?DLZoH5kku/rjDtqL3GbxlE8rCF+fBOXsz+14L8v15rbWs2vwk1m2djh8yF?=
 =?iso-8859-1?Q?0bW1bwPYgcucRjEzLaTxDbNTKn5yw7Eq3TVGA3uJ9l1wQDDhAnM1Lovdx6?=
 =?iso-8859-1?Q?eyz0vKvUVu1hG65RIxBDwQgsBLjoWP2hXb6MgID+HWRGbI+ao43xl6hy2T?=
 =?iso-8859-1?Q?T5SWT+YDaRG9oW+oDAnbKFF20Btv0SXEHo4VT6Y4tZpRX8N5T+kvxYTXWw?=
 =?iso-8859-1?Q?07DJQ8IMjiFLgNnXljv036ygnaBo9AngFYq2vN+5DW6NfFLBTYt/D08G7W?=
 =?iso-8859-1?Q?wkEEsxA/6M3AIfLxnhmYKDPQoiGbRGbAvIzedJfNCyI1x0Q+qFyiRof6AM?=
 =?iso-8859-1?Q?GMr37Maz+bRE7Yow3XuLV9hhwY2SOr3C+U6V+/JLat2OlatitBVuujY5mE?=
 =?iso-8859-1?Q?GoJhKKZanZ6zlZvHhFyNmrWM8Gs8RL79PYFN6XTaZkDFHYw7GYNlmu3R92?=
 =?iso-8859-1?Q?1gFsHnNMr2nAV4p9krB0RxfHc7v5tpp0gFr4faJMOmyleIN/HL66QSRXrm?=
 =?iso-8859-1?Q?9O94NYbFC7zGT7hQ11MM9nz0uKiBT7o0GPZnG0U4utq9G4CRhe9LujTRXU?=
 =?iso-8859-1?Q?KnBFfR3NhMRdXlWwPLGirMGH/WHf3ExU1/fZ1rpAZNi64GHAWnDAiH7ede?=
 =?iso-8859-1?Q?6EPllzhRguq4WzWNO/482x6EXvD2HhRZuICHD5m8Hs86xNvTd12dD5gdE0?=
 =?iso-8859-1?Q?9fniHtkeDx5bDP4OtU2gk1FRu1Sz5wtgzpX+x3371KR9VsYAjoXHczCMqK?=
 =?iso-8859-1?Q?8dO7kdr2o6Y5I/p3kQxZV8SFli4/Kp6Sb0giftfELz9TGVWiET5mQrSVQU?=
 =?iso-8859-1?Q?sJ5fPQLYHnEoeqq5hmlj53TKJsRw5CnAyZeHJag+ZGhLuX9WRewij9uWL+?=
 =?iso-8859-1?Q?TmUvS/RapG7Zf79yInVC2B4yXrP7R5qYhmpOp4bVPTyQin9WtCMsJ/BR5X?=
 =?iso-8859-1?Q?0vHSTrjLu4RxMdgagse6zN7Ui15maHGYBiI3NQZVnJ3Tnjiug4/td7TU41?=
 =?iso-8859-1?Q?/YG5HPdpHQg/IepCf2/udnxfG9KfhSqotaOmqB10kR/Z/F+0kuZ9v45Su6?=
 =?iso-8859-1?Q?LHudMSwlbGRYUeBSGIC6Rq0xu5IPWzqkmrs/UoLnXWQax0Li7cRPsLA4kp?=
 =?iso-8859-1?Q?rncKl1s5DGqGXEpzUVRHw7xDbIh2EvhV4YiWCtTqDHmHVHAjtipaGZUM7d?=
 =?iso-8859-1?Q?b55VXSGoDIp4bqS6WKdbprLBrsyeU+1Uv3Vh19/PCWhGDadYKTASM+0+b+?=
 =?iso-8859-1?Q?hKpDIflQjKd7QYEhmps1iguu4tfLK5vfM/+iKYh+WL0hKwwfJB1BU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9HwY43R3S3gheG51Zu8HQodgZ3ntyPO+GImrLXauUKejp8HF2SBHXZ4ysP?=
 =?iso-8859-1?Q?dG+Pzg65GKQYgTLYv/8RjRrZ5MsasII4KFC3rW6yY8UsCubmdWCPCsUTdi?=
 =?iso-8859-1?Q?WlgIN0EF0IU+Qu0ju/rfq7PDOl3Q0RsigAwUD/z7ZVUCFO63bnYSoLYbsw?=
 =?iso-8859-1?Q?WSYEa6rwvfeQe4Bu/4lvJSD3f4ZRGsFjhCJ77KiqIQOrn5L2nubJ+zHUMG?=
 =?iso-8859-1?Q?/dpMd0p2fsrTL7/PMPOowfVmvbSr52b1RzCjz09l00wX5fjx8RmK30FCs8?=
 =?iso-8859-1?Q?OxIpv4B4VJp53W+ZnyF6gJFWvE4widNv8uNQQBj2mqyGblbiw9p/OYKswE?=
 =?iso-8859-1?Q?Bcp/WDynpGI3hyW5Ch3E4hSt6HlyA+BPPtUBTv3OPMjq4OdkFIBkCdpRiQ?=
 =?iso-8859-1?Q?GcIijm4KAS5Dd1bjBe4Iq1MLJa0ggZCDmq1nWBGz+92Tt5EI6NIa8NlZsV?=
 =?iso-8859-1?Q?iJK/+Yg9JY4qEC1Tz15uMfe+30STIMnznzEUxNchWdMtJF2rzVxdVWlX9e?=
 =?iso-8859-1?Q?w5h/3TTH3/b/jw20OL6WfZl3Nl6pUTtb9KnJ+DhIwJMZNlwhDuk9Tr5UiU?=
 =?iso-8859-1?Q?SChewafQByEzZLJeCxYaAQwRGlAu/MajUt2HlqElkiLCfWLJAMekwAYhqZ?=
 =?iso-8859-1?Q?hoKheQJurFn65DFzMP8nSqIMp2WWh2SNnLzRqZ1AzBDCDkz8A0ooR/+mpO?=
 =?iso-8859-1?Q?g0XrbDqQYz8xjT3gwJ3WbQfUlnrWTxYfEl9PEwWZlpb1RqDjXpjW34yGFE?=
 =?iso-8859-1?Q?zz2rVoXjQ/km2KXG2bRPLHVL5e3HMK5P9T5SvT1G2+2MIRWbrpdSb3fX4g?=
 =?iso-8859-1?Q?OOxHSU63svcSIlAPmOvrsOEArWNLahC0T2x4WhqEXOg8WSNydPZzMDn6T/?=
 =?iso-8859-1?Q?L2xCbXOAUceXN0MGh74Sb76sDw6O51oXJOQUFglK0EiyAdCVnB4+adA2YP?=
 =?iso-8859-1?Q?xPldsz2YBa0SBS+1HpAVj/v+FjmCQmcw8kX2TpFCASgUsNhs/cRdFi3USP?=
 =?iso-8859-1?Q?lwTSu4hNqi0onjHyr1it4etj1BM/M6a5V8d1W6VLPQFHEfzZR1T+Hsn9UU?=
 =?iso-8859-1?Q?7ciHlLAM74MP1kKXQfdnyqjEga+eOUcecytY/DIVDfTFXtrMkeYdBWMGk+?=
 =?iso-8859-1?Q?2plf1qYQjYM9OAt7quRe9xrJ21+n2fvNeCqmBRswkiHnZoAQ8wDbzhxxCb?=
 =?iso-8859-1?Q?iQVXEtkjvQbyU0KR48o8EzuYeBXyiwZ7wDJO7atxynfT/C5N2paSXz5u4W?=
 =?iso-8859-1?Q?wp9S+NExncQD4qaiDhe5O4EHwUrmEc+tVkC9E6eMkCb3Wi5v4+pNqKHdr/?=
 =?iso-8859-1?Q?wkS75jsnP8SuV3uRHmfQTGFFkdQ1gcgeXDKaDrPQK1t5bHrfQApGNNEeVN?=
 =?iso-8859-1?Q?OnvxiJuNSrUQ41PSs8Fmrs74G7OrEGn2ZfuT7tESIGuqY49cHgKMwtUW4E?=
 =?iso-8859-1?Q?8ifiT3IutshtAbzIXz+VcV5taAzv8mvad0xdtKIpPVrtDVI2g9LYFJXKJZ?=
 =?iso-8859-1?Q?QvVZ8gMvFpAvBtqf9X86VvL9MOQ2Udc74hAd7dV8+ze8ApxeeXqPbuKe4r?=
 =?iso-8859-1?Q?leCEpysbQMd7h94Il9Zeh/1q2Fak/NeFQodFB9y7MeVWc2I2VmIpHmiHx5?=
 =?iso-8859-1?Q?bEXUl8yi7vOvXNUeaTt6GFeJHjfvcR3pMC2VTvy9c/mtdlQ2v4dd566w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03553ba6-5085-4719-caad-08dd9dfeece4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:47:17.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEgRX7iSL0NTL5AtPfhsk4s1v5azMQVZMiLPWOh++RJ7fZRzxkb11LjEVXrwdl1dKNjg05aVSpPZaxyHDd9ERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
X-OriginatorOrg: intel.com

On Wed, May 28, 2025 at 03:29:17PM +0100, Matthew Auld wrote:
> On 28/05/2025 14:06, Upadhyay, Tejas wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> > > Matthew Auld
> > > Sent: 28 May 2025 17:03
> > > To: intel-xe@lists.freedesktop.org
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>; Brost, Matthew
> > > <matthew.brost@intel.com>; Tseng, William <william.tseng@intel.com>;
> > > stable@vger.kernel.org
> > > Subject: [PATCH v3] drm/xe/sched: stop re-submitting signalled jobs
> > > 
> > > Customer is reporting a really subtle issue where we get random DMAR faults,
> > > hangs and other nasties for kernel migration jobs when stressing stuff like
> > > s2idle/s3/s4. The explosions seems to happen somewhere after resuming the
> > > system with splats looking something like:
> > > 
> > > PM: suspend exit
> > > rfkill: input handler disabled
> > > xe 0000:00:02.0: [drm] GT0: Engine reset: engine_class=bcs, logical_mask:
> > > 0x2, guc_id=0 xe 0000:00:02.0: [drm] GT0: Timedout job: seqno=24496,
> > > lrc_seqno=24496, guc_id=0, flags=0x13 in no process [-1] xe 0000:00:02.0:
> > > [drm] GT0: Kernel-submitted job timed out
> > > 
> > > The likely cause appears to be a race between suspend cancelling the worker
> > > that processes the free_job()'s, such that we still have pending jobs to be
> > > freed after the cancel. Following from this, on resume the pending_list will
> > > now contain at least one already complete job, but it looks like we call
> > > drm_sched_resubmit_jobs(), which will then call
> > > run_job() on everything still on the pending_list. But if the job was already
> > > complete, then all the resources tied to the job, like the bb itself, any memory
> > > that is being accessed, the iommu mappings etc. might be long gone since
> > > those are usually tied to the fence signalling.
> > > 
> > > This scenario can be seen in ftrace when running a slightly modified xe_pm
> > > (kernel was only modified to inject artificial latency into free_job to make the
> > > race easier to hit):
> > > 
> > > xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0,
> > > lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
> > > xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0,
> > > guc_state=0x0, flags=0x13
> > > xe_exec_queue_stop:   dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=1,
> > > guc_state=0x0, flags=0x4
> > > xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=0,
> > > guc_state=0x0, flags=0x3
> > > xe_exec_queue_stop:   dev=0000:00:02.0, 1:0x1, gt=1, width=1, guc_id=1,
> > > guc_state=0x0, flags=0x3
> > > xe_exec_queue_stop:   dev=0000:00:02.0, 4:0x1, gt=1, width=1, guc_id=2,
> > > guc_state=0x0, flags=0x3
> > > xe_exec_queue_resubmit: dev=0000:00:02.0, 3:0x2, gt=0, width=1, guc_id=0,
> > > guc_state=0x0, flags=0x13
> > > xe_sched_job_run: dev=0000:00:02.0, fence=0xffff888276cc8540, seqno=0,
> > > lrc_seqno=0, gt=0, guc_id=0, batch_addr=0x000000146910 ...
> > > .....
> > > xe_exec_queue_memory_cat_error: dev=0000:00:02.0, 3:0x2, gt=0, width=1,
> > > guc_id=0, guc_state=0x3, flags=0x13
> > > 
> > > So the job_run() is clearly triggered twice for the same job, even though the
> > > first must have already signalled to completion during suspend. We can also
> > > see a CAT error after the re-submit.
> > > 
> > > To prevent this try to call xe_sched_stop() to forcefully remove anything on
> > > the pending_list that has already signalled, before we re-submit.
> > > 
> > > v2:
> > >    - Make sure to re-arm the fence callbacks with sched_start().
> > > v3 (Matt B):
> > >    - Stop using drm_sched_resubmit_jobs(), which appears to be deprecated
> > >      and just open-code a simple loop such that we skip calling run_job()
> > >      and anything already signalled.
> > > 
> > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4856
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: William Tseng <william.tseng@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > ---
> > >   drivers/gpu/drm/xe/xe_gpu_scheduler.h | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> > > b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> > > index c250ea773491..308061f0cf37 100644
> > > --- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> > > +++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
> > > @@ -51,7 +51,15 @@ static inline void xe_sched_tdr_queue_imm(struct
> > > xe_gpu_scheduler *sched)
> > > 
> > >   static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)  {
> > > -	drm_sched_resubmit_jobs(&sched->base);
> > > +	struct drm_sched_job *s_job;
> > > +
> > > +	list_for_each_entry(s_job, &sched->base.pending_list, list) {
> > > +		struct drm_sched_fence *s_fence = s_job->s_fence;
> > > +		struct dma_fence *hw_fence = s_fence->parent;
> > > +
> > > +		if (hw_fence && !dma_fence_is_signaled(hw_fence))
> > > +			sched->base.ops->run_job(s_job);
> > > +	}
> > 
> > While this change looks correct, what about those hanging contexts which is indicated to waiters by dma_fence_set_error(&s_fence->finished, -ECANCELED);!
> 
> I think a hanging context will usually be banned, so we shouldn't reach this
> point AFAICT. Can you share some more info on what your concern is here? I
> don't think we would normally want to call run_job() again on jobs from a
> hanging context. It looks like our run_job() will bail if the hw fence is
> marked with an error.
> 

Also I the hw_fence will be signaled if in an eror state - see
xe_hw_fence_signaled. I believe we could remove that check from run_job
now but can do that in a follow up.

Anyways, this patch LGTM:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> > 
> > Tejas
> > >   }
> > > 
> > >   static inline bool
> > > --
> > > 2.49.0
> > 
> 

