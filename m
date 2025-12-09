Return-Path: <stable+bounces-200486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0744DCB11F9
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 22:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9310730FD3F0
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4C3002A3;
	Tue,  9 Dec 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7zTBAgo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA62FFFB9
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314179; cv=fail; b=Z+hp15gNmWAJ5GNeTA6pUfL+GXFSPiAmVDK9HSPdRw1KEJMyQ9w7prO2baocSlevt2m3+lASID36kiASXGtWTE4iZ/UnJ/Dg5MthN3dVXSnsl5NE2QxIboe29cfMrEEBBJAM6PIOR2iMVu2ItYACQ2UbtRvr81Hrm2IZrUPrwJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314179; c=relaxed/simple;
	bh=DegyPAtj80dkQImBuiHww26glkfOEwpUF0U4C5kvBwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X/alde1aivNJFsjpXrlQppYkHqh+W59/q0C5xbx9yjhXI832w9cSet9abAXED5JGqlufDlHmkB0LvWpYbB89vD0ewvDz402DHnQkBCIvuJ08EIU6F4OoOd8XyDBRHeTaHR1ht/HMiGcVSBHqa3pZG/9BjaN5a34ULAxqHuclNQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7zTBAgo; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765314177; x=1796850177;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=DegyPAtj80dkQImBuiHww26glkfOEwpUF0U4C5kvBwI=;
  b=Z7zTBAgoyLxRqKM3zEs/7H1pgOVFkB4Ebl+RKJnxIYbqawvzZL3uUXBt
   occShM2hi/kQYyawdb89qn9kR7bq7h5o2KmogB9IugN4JguS33JIAcZxU
   Vkc4Y2CUJGhgt3MsfABBBKNToMjh71jXUKneN977WJ/vCdRi0yjllsdNN
   xpD6oAJsxWBGpgKbIPen1+lGWAnh0W4ebzF7HeqdO60aMcQmRXYLQrMJi
   E6Aeau2QVfhT10bOS9Cz8sEQ5jbs3f4rHW43J/56lL5of1FSvMuktdma0
   mhfRNEKdp5gEdoa3Mu2Psd1uN9xFxtXB/hcbTzNrZeyzBWzisSTSI/h2f
   Q==;
X-CSE-ConnectionGUID: xGUDSRvoRICWt+9llSGNKQ==
X-CSE-MsgGUID: hPzhiEl7RZKFK58E9rJ2lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="70902036"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="70902036"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:02:56 -0800
X-CSE-ConnectionGUID: aFcqPn/YQzWQA03s/rubFw==
X-CSE-MsgGUID: CXcmz/p7Roqq3c7gSXhVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196079180"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:02:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 13:02:55 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 13:02:55 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 13:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAc2wK5xABzEL7h/G+VVf3UDE3QUDjc2hqB/Ep5I7Zrko8Ncczfesvt8nGVEErpIwKk9T5GG8F8RKqk1LpRBwnO5wFgEtVpfznZN6wwnxLbTxezEz9MWjiS9fkgHBPXt638zM+QQBYi6BMumIG57MkMHmIu9Ic3xpNeq7Ij+Ih0Zl0nRI20nBrP7BuDnUCuTf5GN5AauTvon3M+oWW53twSGTPlLQ9NCnlAyC2VwEPJqFQWXz61SYmwPeVxzZp2Ir/mnjDyQztiqCHnemGeFIH3I/uPB33ELMvTSgvwrrjkDSTCAKfu/N3CiZ5qMO/eKzD2ZQ2qda+RBLuya9QKXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVJzSyWUd4EiB74C+jJxwa3xah28Jl4sPEIazBozXxY=;
 b=O7l1ceA3zRlHqC+ImpssFT3a0/vJAPTWqpByoZGRrubnMA1xdu/c4Ff8xXTgOW59l4Ij0zpw5AtuohXQLhy7ovTCpTFk0YmOf7dzpslfr1ZntAUYEIQ+FcZi2y83aEdFcwOJojZKuON2TXKnJA0XnVz+Ibo++SG4I44znL+N3zjaL9DqzZJeal6vEwkPXVgmE7s5X8CQR372Eg9luiNvVFmYGQ5rDIUbdvy18pk3sXvfe1Ky/nEeYCCZ5Q91Jx9Ghjlr+C6yhifrB+gX5i4b/LnCtRYiw0E4BqV6Xn0AxZPoBmK5OjEomOeJt3V3DLHhjYt397zvlVqdghDVjt1/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Tue, 9 Dec
 2025 21:02:50 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 21:02:50 +0000
Date: Tue, 9 Dec 2025 13:02:48 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/bo: Don't include the CCS metadata in the dma-buf
 sg-table
Message-ID: <aTiOePVtfPT7MKu3@lstrano-desk.jf.intel.com>
References: <20251209204920.224374-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251209204920.224374-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be96358-01fd-4e3c-45a3-08de3766504d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gLD4Go9n2OkfzOfp1PHpOBsbcvwNUZ4d7CJxJiYoxfJyjkEAAtedSP+wKU?=
 =?iso-8859-1?Q?5GtT8evAAlQSm3bp4Zlifl9c3QB8xDS4hZuDrMmiA5vopMJkJcVNxJxWaH?=
 =?iso-8859-1?Q?l6LhJ4QNhsR1dHzpVlEBaQlq1Ny78Mk/zF+I+C6qy5vaRxu8RZwD1LBQr6?=
 =?iso-8859-1?Q?8TWF2tK+1yKuQTWM4YUenwAzih+MjMAPykM7zr6gHFr0pTzc95qwH/47k9?=
 =?iso-8859-1?Q?Eo56ugvHMSTuuRUwFAKCg7IuOFZ2H1v6GgZtRCBTB3GXjpLXYvsXCAdy5H?=
 =?iso-8859-1?Q?REyorPQ1QZNEAgpYhbW5WmWntqcrV5XbazSt+FXzM4XmnbnzuqbIVjCwb0?=
 =?iso-8859-1?Q?/JTfg2kYbCn7zRyo4REyk1duvE++QaCJ+1OZlgjF4Sfmb0WMMwcah9vLnk?=
 =?iso-8859-1?Q?fKQGYSqKAFm2fNfWE/JbmVcD/pVPuIR5S17+SHsi+3DF5wdIlxiURe2Xln?=
 =?iso-8859-1?Q?iJ2TPCyibpIMl2oJnBGlO2znwbV2KRudH2Ziq5tBsXLhw+qEKY2E8kH5Tv?=
 =?iso-8859-1?Q?xirkoGCsiyNaaNOxvMpLD/w7d1U+RmuH+Ci0N2/tzLUbT6k5ZrmwF1KUM3?=
 =?iso-8859-1?Q?c9QHCPfMgQmLuumdukdBV/j+Yz5mzmH9AsUmpMJi5xHW8K/hDamqmzTXt4?=
 =?iso-8859-1?Q?GavaR1pqcMQ0DlQbwDTy1dC9vggDXiGSKenOCnsuOCI/9e7sXlwLIYceRk?=
 =?iso-8859-1?Q?k8/ifTAMTH2J7ASU6R/wzh8qjNqTdA3YmfQsj2S8PSnzc/NBBKv5exBEmO?=
 =?iso-8859-1?Q?tAaOw6+QtZHRwuuloQBg22vSEFL6ERpmUJab4munpGkuU1Oyhzb3pBhlQA?=
 =?iso-8859-1?Q?/yU0hTPXATpNKom5J7XJQbt6rNpvLNekWhht8goJeWPKGRxnsjxNH5e/ET?=
 =?iso-8859-1?Q?CufAsP2r4ZDCpyLGWb+EmgD8ZeJR3/j6TGbOQvlRscA6Uvwnc0aidLWIq4?=
 =?iso-8859-1?Q?GwgdWtliU8WmAUoo8LJUJTE/uY00zeCXxBZvEQCkNsGpOEoVAmP0tfIg6h?=
 =?iso-8859-1?Q?eiZCdwlwWDl0qhEGRithEkt0Y5ppN1shTiirS2vSfeTOBGs8H1MaPfPMat?=
 =?iso-8859-1?Q?Rx0Y6m3ECO6zkr7yzEnpLuLSwGDHXX7Y7p8GUHaIXiuZsBTHGVj/JGMfdL?=
 =?iso-8859-1?Q?VSA6ymFk7yWgwZZi2W2fWe2dBrJTKj8X/Z+Zy4P+/UoPxpBviZpm+1iFZx?=
 =?iso-8859-1?Q?8ZkFJN2sVXmjV4Gm5dFE3D9BwK5X281q70FwiYyTNM6gYEsWGZNKBHKW2q?=
 =?iso-8859-1?Q?o/TJPUWYO4sw6N5Mm1wHgyQw2C2woC50zo+UdbyTy64rBldfje5j2PgtLY?=
 =?iso-8859-1?Q?ufLGaVrriJuJ1PFLm5z19D984fKY9m8Rvk7QiOtnEFAHTvMhna/PQRkWHo?=
 =?iso-8859-1?Q?kAsnkhmwHE7iSk0Ra+bV5vnOuOSNOpjnsAByigG4G/PcP9Q0182ldJLfiR?=
 =?iso-8859-1?Q?ic3GpZiJqCQydUHcp2gvtvyACeB/feEiXqLHxZY7RZ0gHCsosMW+J2RyNt?=
 =?iso-8859-1?Q?s4tYYY1uc+bfOQQ0hMNxNc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?t4MH9dILOQ4iVKvl+42WMBQb02RpdqqIdAVAWDVCfipdlrGZEwXcQiTAgP?=
 =?iso-8859-1?Q?NEJx9667XbloAQ/cGDFDrgusbjprN4lPk2jWQUeLCa7AM9cS/DhF/sf0qu?=
 =?iso-8859-1?Q?6+bFmFMee9mWB6FUObfgGiFOpDqjTc//Pu4kYmTBMYbBoXp7cFgDJTno7x?=
 =?iso-8859-1?Q?7XcSxLqWvFUWkXDNWIuYwLY2KA/M+XmlI338I4NtzhaIDe0oAQeztvXUUT?=
 =?iso-8859-1?Q?TJsULsMKjsUa9tU2O6c8J8wRTt+nEdzS4PM5JrLGKrrRxaseMwZFQUjSEb?=
 =?iso-8859-1?Q?CcDeUnfBm4Rh/Maf0eNh7sGHkkKh5/InTSteEF3Ns3Q+NfRiUjQjYd1fYt?=
 =?iso-8859-1?Q?brRq0pq5m/rb8gUzj7k5OpqfzvnbQcc/G+paf9HADJDQufUvsEbe67e3zp?=
 =?iso-8859-1?Q?tr4bQu/oprViWCIchqeJz49jo6u4dh2maqiU/vq6LD6bP6dfRjigPwiS8G?=
 =?iso-8859-1?Q?mGgK7izq4WM5lDh8kHsJD66Q5owy9P22g79guhYcz4yGj28L6QxenBLKw4?=
 =?iso-8859-1?Q?ew4Br8vDwOJTJhWvJKT94tLjd/dDrGZSQ4CP1hyNVXMqqYdqI+2LH5Gk3B?=
 =?iso-8859-1?Q?/JqbaBYo1X9VIi3xpTkgSpQh38BaI3tZVbqGKHmxdi04G3jMbes9EvZ1Qg?=
 =?iso-8859-1?Q?pXVHxdY74KjobrfWi2hTti21xKtBEhErI9GfxRc5ngjq4BcBYqH5KY+B9Y?=
 =?iso-8859-1?Q?VzZ0KDoFV2yo/45DYgCv6fIAR2MoF/BuVuOm37bWb5c+hwJ4NIZ8D/7NEw?=
 =?iso-8859-1?Q?YKtFr+aO5zNEfxBE8lR6fLohic1b+3bwVyAlSlD24h4SIp2GZyNMwyJGXa?=
 =?iso-8859-1?Q?36OuIbPGbvtc0Iuxp0z35N/A27wRjWwDGTt3G3nbomG13xUdfHr6oPnLSh?=
 =?iso-8859-1?Q?7+MuE38TBJn7kTCQLsS2F9dStYnYGP2cmRyEJcvICw3Riap5nOMV8JOnez?=
 =?iso-8859-1?Q?41PXf1++eVrXI3cICgw/fYQWcbgAjzFU0IZVKEM0rtQELwEBnkVkaWqdHO?=
 =?iso-8859-1?Q?71rqJ3WZEZe2VTx4B2WOdZntGLYCLLYAuENdq5hSKJZvGCRxTF3Fztv1bU?=
 =?iso-8859-1?Q?co88MKLzrqipf2yzHp5NaawucopwdJHjlhIeA20p/aYDBNghUtNmiih8qv?=
 =?iso-8859-1?Q?STGvdN9KDBAylRwgvxur1H0xomKeDBjVDRI7N3+NYkRIv9lAIOddx9e3jh?=
 =?iso-8859-1?Q?66iWeqOOGRYs0rIgQlAhxF6QnuwoTnFfUQJ8ueFZz6KeG2T+MBrXvCkd0F?=
 =?iso-8859-1?Q?q387cPynxiG8F6dLjetnhWfSVuHMVwoniI+aFmzHrV3o5Z6ShFTVVkx2he?=
 =?iso-8859-1?Q?yfuExmCi426nR9AbsJIfJiK/qdOv2UCXiLx7PNEc3fOqz8zJMHQJ2lTTe/?=
 =?iso-8859-1?Q?vb2a1yMgFXZJJGhpI8RepxmmG1iw928VzAxhvyvIyx3L3OrtL7arNhIb1r?=
 =?iso-8859-1?Q?p8on4TTobWJv8p+gkrGPCgG9BSEx5Ua2Z6MTnKQI4IDSX6m5ceAG5sEp9t?=
 =?iso-8859-1?Q?vUb8LiqSXvvDXo6WtyLu48/nAX9wl5VFTCssi2zhRmZRAxO6+DakB0ef5T?=
 =?iso-8859-1?Q?8euJFvtapiNAF3n3CJ+ajZXPHq+Toyh8G0aEH2uUS+2Xtbx6ynRviWbzXa?=
 =?iso-8859-1?Q?uiMxcz/eLfgTR7IRSpsTyofip+ghBpSUjonJjrw1MFHFpR9kNaETDiXg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be96358-01fd-4e3c-45a3-08de3766504d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 21:02:50.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC3Lbv0Tzz3agkpabQvb3y+ebfBaJw/xeMpjW/3oqOHk2u0Met26bL46PEwT8w24XgLH5+K8kjMeDwvGwpRgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com

On Tue, Dec 09, 2025 at 09:49:20PM +0100, Thomas Hellström wrote:
> Some Xe bos are allocated with extra backing-store for the CCS
> metadata. It's never been the intention to share the CCS metadata
> when exporting such bos as dma-buf. Don't include it in the
> dma-buf sg-table.
> 

Indeed, good catch.

> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 54e42960daad..7c74a31d4486 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -124,7 +124,7 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>  	case XE_PL_TT:
>  		sgt = drm_prime_pages_to_sg(obj->dev,
>  					    bo->ttm.ttm->pages,
> -					    bo->ttm.ttm->num_pages);
> +					    obj->size >> PAGE_SHIFT);
>  		if (IS_ERR(sgt))
>  			return sgt;
>  
> -- 
> 2.51.1
> 

