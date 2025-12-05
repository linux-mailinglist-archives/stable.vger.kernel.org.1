Return-Path: <stable+bounces-200202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD82CA9624
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E743016EE8
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB82F2611;
	Fri,  5 Dec 2025 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhiTUeSY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED412EFD89
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969827; cv=fail; b=OeWO6VzUDAIdYNT3lPYiRj0T2fcvS8yZWKNSaizzOLvZDHEQHT6yLXpWa46pw99TUGCAB7onpaB5xvSzNKwPLDTiFwRGwdvVUpt1369tcLi1kYiPxhsgnX9eytqYcWeoXpQ1y1uT5c9h+jyUqwbbZctciPzq8dqmVhJvW6M2BhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969827; c=relaxed/simple;
	bh=XpErEgBmmP0uDw7gQXI59K2OGFTxnHgztuoR56ZVJiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SXjHKXOIGyngip3rZfbQac9P2LX4O5abTFSuqtMRUHdgguLcCPEjMCmTbTmZ80vZqc8JsDkPYLFc3SeGzhM6z4XfEbdWLkW4ZKiJ2dM1dmp+0H+3VVoA7iG/1wz6vns65xh6wbYU4OsF8E+gsP9dsfnNMwVu1xkKCmIcI/kehos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EhiTUeSY; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764969826; x=1796505826;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XpErEgBmmP0uDw7gQXI59K2OGFTxnHgztuoR56ZVJiA=;
  b=EhiTUeSYadL06/fUYDKl/abdn9rFFo4x/m4mfycfjMWa9VU2QeRM7tOp
   Gjhsy/GJIuX3kAE/DMPdCAvL6cDMUBOGjl+auXTSH+xMojt03kTbLJ5Om
   HlnRo0+Md+1aeKfq9w8Irv3mdapzmeWAzAzQtx4/DaAA225VaxqLpuARg
   pYzgqch2nE688s2HPtKDlc/ehNJmvQExHSs8u3YygkB2nTxRHqnLaXnel
   tne4KFXP0Qa1Kr9Jw9Fh/4Vc8f26wwdTqIREJq4eEjlh0gWR2P6ttxhi8
   lMltY2X1DsALlP9/vzGmsMHyApXyVpToI/SqJWoFGl5mEH62hGWLRyxzj
   Q==;
X-CSE-ConnectionGUID: gFFBdnLtQc+KwaHIy8sAvg==
X-CSE-MsgGUID: Cb/Vn+ENSpaDarIdwaYXtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77694717"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="77694717"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:23:45 -0800
X-CSE-ConnectionGUID: 55Si2jc4TrWajw0Lcvhonw==
X-CSE-MsgGUID: 6hchmYWrRs6g6lkRXKKhgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="232771534"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:23:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:23:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 13:23:44 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:23:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7pD9Msj9ZXuHhx2F8w16QfNLlBe4ish+59j+Y29e3tLelIjzIkAqgHmKbJUQNSwY+SegUmgGwjA0xR3TErlwJr9UDtQkLbRkHneCC3Fzpx9nwL9nhkHD0Y1vzIfhj7yzt/5D/kK4UZGo1MFB4Xsrn5FdJ5YNYQ31sZXLWD+sVuoBw1dYnA7MJ5dCUpo/yEIZMbnVwkgipf2jkb7e9O49yjKumbgaL5PQ86QbKTYtSuWCvzuO677s3/y5f7el+gpJJdBEF30E0YEgIns3pair4R+Rz5heOzolKpZ2lEy4GN/uLkkRlzGMhirX7tcD0W2wRCRSc1FEF4roQ83HZxNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsGtYwifbKkvGrtps8ZWjWG7LOOYcQCr7FSx4o9In4M=;
 b=O6VUy05p0TiXMAFkC5ETnGPldgFnQkOpNzwg/8YeZNI6y4cV6+Udmm5FdO1/lcBJqv1XPvhLvQgBmBJoqC35CAIsNWE7aUwNvtl4lp0thWLkGsEe1K6QShx/9FRdgOLn3hjJatAKtbQp+v1eyfJwzs0EwkV5hmUmOZ8NAf8CHlHRTS/UZpfPDF1isOazkcrbWHbcUDT2VD1I3V1AVDX5QAnQNN/cqOCT/4QiOWoGmRgVl8oilSdmCZXiHQbzgtr2k+v5MuMoEd181RfX4nS/nGtA3ZHdT4MXOfcpy66RpfOVpQRUYNtuIvyeBaL/DoyNdYZFCp7QD+A3QJeDCW1Z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:23:37 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 21:23:36 +0000
Date: Fri, 5 Dec 2025 13:23:33 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Shuicheng Lin <shuicheng.lin@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>, <stable@vger.kernel.org>,
	Michal Mrozek <michal.mrozek@intel.com>, Carl Zhang <carl.zhang@intel.com>,
	=?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, "Lionel
 Landwerlin" <lionel.g.landwerlin@intel.com>, Ivan Briano
	<ivan.briano@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH 1/3] drm/xe/exec: Limit num_syncs to prevent oversized
 allocations
Message-ID: <aTNNVbxLg9DBDmP2@lstrano-desk.jf.intel.com>
References: <20251205190506.2426471-5-shuicheng.lin@intel.com>
 <20251205190506.2426471-6-shuicheng.lin@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251205190506.2426471-6-shuicheng.lin@intel.com>
X-ClientProxiedBy: MW4PR04CA0358.namprd04.prod.outlook.com
 (2603:10b6:303:8a::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: a3187600-89cd-4518-6686-08de34448d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?YYACwEtPO/DvBTtJ+ragPbdQMpqQqzSfcg4pJshzNFDgqt6xOP69e2axU7?=
 =?iso-8859-1?Q?GtMg2LLUoozDw41tzcZYebWY8A6HN/lr5AH90GLXYAkTpefde2xhxPgODg?=
 =?iso-8859-1?Q?LFAwuljikL28hsC2T9fvD4XKwzjNXpfSlDhPdV9Oe1FOVITO4ms5VNXjgG?=
 =?iso-8859-1?Q?0EkwRPA4wGbOlbJyX9DeFVa1stLC7lzkvS2yU0ZptmoJp1IZkpUyJeAFc2?=
 =?iso-8859-1?Q?zsK2zWrlYo6+Odv+U0sApdQAFlpDHEXiUpIJjDwMvrDfKp4/E+OKE1Aekq?=
 =?iso-8859-1?Q?TpKtz3282x7dorsZy08l0XxrouB9ajLloX66KhOJX3BR9tGDDU1fCww1qU?=
 =?iso-8859-1?Q?fkEWU9kI42aLA1hrj6Yb4CjFyqKcMzVztM61Uk59sBBPMmWQwwfPcIolgp?=
 =?iso-8859-1?Q?e6p9TK4UQfphnZKNCkEGCimQ2SKKpF5s6EbP33DF+Wn7wL3ZEzdDGBRemh?=
 =?iso-8859-1?Q?QJpMo4Zqq2LTDUcrsSAB5kK/zb1jPORzxpbei2KiFpjAMKH/32EzDekybT?=
 =?iso-8859-1?Q?P61bWUy5yPS1bjhdFMD49tXCVu3KGKbuiu1On09A8imuOyDworOGKDWKX0?=
 =?iso-8859-1?Q?c9VpZYupc+aFzAY27npbN7rZlTQdvb+xnILCs476ckO3Jpnkq/FhIOEUEb?=
 =?iso-8859-1?Q?DiBQcZwtcbdNusIq46p41Zhr6TqXqfLd89aiyxLT6I+vPwzauhN91oa2eE?=
 =?iso-8859-1?Q?StA/SzscK6BFyh0mmwie5VBAMAdvPqSE2oQsZX117OstcsSAmFG4kRhGP/?=
 =?iso-8859-1?Q?RYyZ0Ashiw1fzY5cE2LWp36vvLMnsiCz/KJB+Yg9Wkg/KZVZSdpJEW9TMR?=
 =?iso-8859-1?Q?rQ0RkZrM9S9fqAEUNiDj+eZ5f1Q83tqjYQgdSKZyeZ6H6ugoXrJzJEQInL?=
 =?iso-8859-1?Q?u4+VB9B90DuKScL4T48PPu2Fwk44rwKP3cE8neHnI94W/JMBNJGftJbKKC?=
 =?iso-8859-1?Q?+K2KTyAppAp6F0IFcNG4kfmQE7mkJOSi5wA7c6yZoNtLa7EDs+c6uvecOX?=
 =?iso-8859-1?Q?TrxJ7EMEyIMMDV4o2CU0Dwo9jn0fff6DGSudCzbp4dwdcdQr+ZTpYlnluS?=
 =?iso-8859-1?Q?IsYUZ0TgY6QS/miOb7wETBs1hDOWdLnrIbXt7W0skX3viEvGKjmU3kyOkb?=
 =?iso-8859-1?Q?U4HMa4W4oobKwM9IMFmb5w/w4ipcqhaZj6JsEp7tReANoPuGOhpUJp+KzF?=
 =?iso-8859-1?Q?v3SOEkF3ciQh58jap+4siUNskwaf27hxEpHjebzYnvvx2sK65HIQNE/YF7?=
 =?iso-8859-1?Q?LmQIuRkvvicnbgDSAH6G2yicHpK3r+NgHbXUnvtRTNQzFiY0x8VbszzrnE?=
 =?iso-8859-1?Q?77TVRPcf8WjRRoBiwXYmglOLl61G7TqFYRWhoAgLfxwuGyLW3OzRZXyeR6?=
 =?iso-8859-1?Q?XgQdI+6rAGktnIEKBWTHAUboT5xxLZMQkTcVHmWJwnTwi39RgFScwANOnE?=
 =?iso-8859-1?Q?HQDz/MiBllCyHXY/RaZN2dKL5K5PeBIgf1qJDb7i4rJuAEmNTL+RcQ3v5e?=
 =?iso-8859-1?Q?R8GJFvBx3OmQqLjCiNUENd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ue16gac3terqFXV0g9kDjf+mGqWhkstMCa6WX8JQkX6twkcjeApPI7pOSe?=
 =?iso-8859-1?Q?UmLA6cSQxGT13mf1x0irKD6DMXciw4Pl2f+AVmdnS+7O32OxjIS3hKNKOD?=
 =?iso-8859-1?Q?KajNVH3JjMPtVbPSOHYoW28u/AMxwu85i8AH1x1IasPf5iZHbrP7ce/LI/?=
 =?iso-8859-1?Q?jjvFEgH4+j753tKwB8qbmGe2BT+51Pozb97w9Q5Zm5LzHBaUd0V/6Fy6+x?=
 =?iso-8859-1?Q?eL3g8scd+KIGQ+Aj4Zcz2Qo39vAB8BzSFdd1jrYrfRErDT1bvGPIwomYUO?=
 =?iso-8859-1?Q?y/oFz1QHYQp6tkUeNI+ZPP4xQj6Ai1O73rOnS3+04+zdxtAMeIGpvELYCF?=
 =?iso-8859-1?Q?hwPyPZAQ/VMIiWujS5sFwC0cfoLG5bOfORfPhnHH5IThD9tdW244AoIKVS?=
 =?iso-8859-1?Q?uBXXzISVyTjlGUUdwPNNpRpk8gNQ4RrKDYCKZvvUtFfu2BnyAnYp5v4Wqk?=
 =?iso-8859-1?Q?oXl6TAmY+X8lbTLLzugD9N9LrQW/KnJtrGBxsnsDsmg0qwdL3jB6PqBhaO?=
 =?iso-8859-1?Q?tgIplUQpFbscz+ov3gKEgdOQilDtx+HajNDZqrPZunGVLQBql2CIhbb9B5?=
 =?iso-8859-1?Q?a5BeZR7Vn74MpnBdhSkjc/BOzENjVeAAqLA23p8ASH6f7LXYl0n7HexUTE?=
 =?iso-8859-1?Q?GXPNezpiK3TVvmRad/9b1YdDYiwaRv4Gy4AeCYFmj2qfwbUaFufwEP+Xym?=
 =?iso-8859-1?Q?cBjqhpwd6uTOM3O7/GVU7fq/VxKeUCE3anF25qx22XTfIwLmm2nJROWXd6?=
 =?iso-8859-1?Q?dyo49o2DkMSeI2bmRw/hSatXhxzXVMEvBdLcyp1v9AbvQaS0eAMc4EjuX/?=
 =?iso-8859-1?Q?WG3MlRz753wAP6sFDD2MaRXVgUxpLPjTUAPEVHlOJ+hZsfVjIMlqvcAzOL?=
 =?iso-8859-1?Q?EuBwwVFnqx2ArXQP61MnK+qV9o6fctZMCrvUzpyqo+UVxoRzw6rQQkq8Cj?=
 =?iso-8859-1?Q?MQeJ08YTQouzzhKzqzto8K+3FvJJcFIygb3ccCLMwI9O7QNiNctmKjTok2?=
 =?iso-8859-1?Q?0CyzjAvMx/L06qUXUL3LZlvtpsNivYavmAMZeeunBbplV0g7+iOawtkJiO?=
 =?iso-8859-1?Q?CjiN+9EnNN35T+/B/goiacu1HNQONZoqCRWDbphxA9wOD0gfkfsVJhgfJS?=
 =?iso-8859-1?Q?HP6D3+SAvlZLmlF1z+UEurLxEAJo+IfCAplTJ/K/8UhrgvjWTbjnOCBZZa?=
 =?iso-8859-1?Q?0djXQz+l3GinhLJJVQueIszu2enQKgi020Q/jfsg23C+hpxqxfs7h8Mp1/?=
 =?iso-8859-1?Q?LBeAuo8V7OhQa50aBumiH0JUJ5acVhPt3rb1zWeoOUQuJXUHn7lB+Jw51L?=
 =?iso-8859-1?Q?64riyjXQPc/JhcCtHgV5txq2usdU59fy5MAsA5iIyg69AowDa9BnGqsP4T?=
 =?iso-8859-1?Q?B4KYJtb6/X1sUg8ylFBP7LYEuCLyk8miwk5U8wbYjrM/O4sadMeZp3od6z?=
 =?iso-8859-1?Q?0FNJS15b2mn/VfG54MDswtzBPaQzZ8W6R+BSqg9PukOXtbvoghtR5YNGQZ?=
 =?iso-8859-1?Q?pJdwVHz7AFhmaUH/zK6sLx0Em6iW6tPqbLEvpYb1t7lhAWIBDRcsCA6IF5?=
 =?iso-8859-1?Q?B4hglTk4xpiO/TGaIuE22buzCyMtl9YZKT59D+owiK+qhk+EMuhlBSRjkz?=
 =?iso-8859-1?Q?uDq/xMRseX1C3wjXgPRx00lKg+S2S22v1DrXOaGW311HZPl3YMtoSskQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3187600-89cd-4518-6686-08de34448d28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:23:36.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yw3xsMync9TPD9oRdmMeDxjuk5kyGXCp6D1FMIGPCcm5yJzxYifn6Qkd/MZZ8vZ4SHGN4fhVY/5yho8ClDcXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com

On Fri, Dec 05, 2025 at 07:05:08PM +0000, Shuicheng Lin wrote:
> The exec ioctl allows userspace to specify an arbitrary num_syncs
> value. Without bounds checking, a very large num_syncs can force
> an excessively large allocation, leading to kernel warnings from
> the page allocator as below.
> 
> Introduce XE_MAX_SYNCS (set to 1024) and reject any request
> exceeding this limit.
> 
> "
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1217 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2f8/0x2180 mm/page_alloc.c:5124
> ...
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0xe4/0x330 mm/mempolicy.c:2416
>  ___kmalloc_large_node+0xd8/0x110 mm/slub.c:4317
>  __kmalloc_large_node_noprof+0x18/0xe0 mm/slub.c:4348
>  __do_kmalloc_node mm/slub.c:4364 [inline]
>  __kmalloc_noprof+0x3d4/0x4b0 mm/slub.c:4388
>  kmalloc_noprof include/linux/slab.h:909 [inline]
>  kmalloc_array_noprof include/linux/slab.h:948 [inline]
>  xe_exec_ioctl+0xa47/0x1e70 drivers/gpu/drm/xe/xe_exec.c:158
>  drm_ioctl_kernel+0x1f1/0x3e0 drivers/gpu/drm/drm_ioctl.c:797
>  drm_ioctl+0x5e7/0xc50 drivers/gpu/drm/drm_ioctl.c:894
>  xe_drm_ioctl+0x10b/0x170 drivers/gpu/drm/xe/xe_device.c:224
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl fs/ioctl.c:584 [inline]
>  __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xbb/0x380 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ...
> "
> 
> v2: Add "Reported-by" and Cc stable kernels.
> v3: Change XE_MAX_SYNCS from 64 to 1024. (Matt & Ashutosh)
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6450
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Reported-by: Koen Koning <koen.koning@intel.com>
> Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Carl Zhang <carl.zhang@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Ivan Briano <ivan.briano@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_exec.c | 5 +++++
>  include/uapi/drm/xe_drm.h    | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index 4d81210e41f5..fdc7d410defa 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -162,6 +162,11 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  	}
>  
>  	if (args->num_syncs) {
> +		if (XE_IOCTL_DBG(xe, args->num_syncs > XE_MAX_SYNCS)) {
> +			err = -EINVAL;
> +			goto err_exec_queue;
> +		}
> +
>  		syncs = kcalloc(args->num_syncs, sizeof(*syncs), GFP_KERNEL);
>  		if (!syncs) {
>  			err = -ENOMEM;
> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 876a076fa6c0..ae040989fca8 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1237,6 +1237,7 @@ struct drm_xe_vm_bind {
>  	/** @pad2: MBZ */
>  	__u32 pad2;
>  
> +#define XE_MAX_SYNCS 1024

s/XE_MAX_SYNCS/DRM_XE_MAX_SYNCS/

I think this patch and the next can be squashed into the same patch
since they fix the same baseline patch but keep the OA part seperate.

Matt

>  	/** @num_syncs: amount of syncs to wait on */
>  	__u32 num_syncs;
>  
> -- 
> 2.50.1
> 

