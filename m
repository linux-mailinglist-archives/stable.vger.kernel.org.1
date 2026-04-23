Return-Path: <stable+bounces-240525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D9DLbxn6mkHzAIAu9opvQ
	(envelope-from <stable+bounces-240525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:41:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3683E45627E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F88A3015E32
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A0384233;
	Thu, 23 Apr 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVQ4XM9d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79C175A70;
	Thu, 23 Apr 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969625; cv=fail; b=NLgbpfoU4vOiT+6MdMNYyMn4St4qR+03yUndibc2negOWcEtuwLXhOxdd7v0XfB5N7p+CZYQgM1OCYt2/Jgkptekk3E7LoYKAQ4Vdg4+U2LOKXTX6CryqOZ0U4DwG60OajfulywS2ZkBblz690u2QK0DCR871rjy0uRFkQM5iE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969625; c=relaxed/simple;
	bh=WLHCorsCt3ehYHPJCk84TimjQuYrQJ3Kxg/zY6eDZ7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MXkRK9ykXLnnN+X7Eyogdbz0jCzadrB/ensCYOwLr6LY2QYyl9CXZlAiRKviaRywKbW2Zpjlmztucf+y3S5I1dFG/seCUIFDtm2AdmqOWDPZBfm2jcjr63iFl0VCsGkdWg0DaA2anoA5lDGZyI9TOa+UBQlmzcl4KIFWX3bk18o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVQ4XM9d; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776969622; x=1808505622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLHCorsCt3ehYHPJCk84TimjQuYrQJ3Kxg/zY6eDZ7c=;
  b=dVQ4XM9dEmIhOY0UegjrifPZtDpw5JocZrX19Dgox6+LgAzV2PXS1fc0
   /pqZgKOZD4WXMvs4OpJ5YEwo9Xnva8ievyhrzowNdoWGjxPq+KiaDV4KC
   Zih9BMb4EoWPUyM+gSidrkhm57FCvDxQAYIBPwTXwx4I1BnDCzoRsN3U3
   xdVOiL2wVSSddYrt6LXd/uTKOuRPa/DCYOOfyvwl+ZY9YUPmfDbSQLb7w
   SrEzUIHx7/lUKsyWElSYK7ki6ylVMmZ85cid0eQlHU6pIwm4jIxlkkYXa
   0mft0m/0SWIyp1nS7s2PCOt1wMM9LzhJ+t/PUr0M7TL9f2oiemWr7KlMq
   A==;
X-CSE-ConnectionGUID: RW3Dki4kSka+q6uZHxx4Yg==
X-CSE-MsgGUID: 90Hma8SESHi2S83vH0cNAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77115565"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="77115565"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 11:40:20 -0700
X-CSE-ConnectionGUID: GpbQXfb1R5yo4j8hZziP3Q==
X-CSE-MsgGUID: 5r2Mk9SRTMWXmaMAkgW9ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="263131772"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 11:40:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 11:40:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 11:40:20 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 11:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxAxRD9mmxBeLrqeNUjjFYdV31m8MI5RwF77wB6xHDkPR0/5u65JN41KotlbpLatEadeUKqHjLvqnVhoi6kHs1mjz9TI8sdq4vHCv7YFz/miULlzlsZttdjgcYQkjB/MRLLm6Ss5ejo/9LjVORv4SO4YZYKWBDeh4nB1cMyuidLKd4hzGBRoevcSCAECvHoR203IGU1e7JA58DEx6BjWTGa/G6nXAGn4yzZvgn26z5OFqfsuRg+Vpj7awy2nWfEE800+Ij/ezw1Q3KJJtZavtDT/N8PGyVrRiovgbI7P9XJ1zL8J013cl6H58IEvNlnP12JuezvW7f3y5T8yaAZ04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzLfioNbCLPt912VqEfffGknU1pPjgUvQSsBfLNqHE8=;
 b=i49r7wETX4jbtpMVQgRLwiM1Lj8HNRef9+DRzVBOF1JQ1QN9I4Bu5+2fwp4IBFrHpXe8Z6MdXsM9PvHZYZgTZkGNjcgwT9avr1Mj7bjeAbnyqmDRVVv2ozVeQuIUHHJwlYu4JteIufM7AGUCYX2YGRmkOPY7/HfnadtwYqTJXzWvvM1ENzl3yA57VPHQSNWS0CoOR+YsDsD36l6L0t5wFfWvXYzzDDyUJuk+sqY2Pz6RaPKOvdxe8ZOQnfJV7y+bBUe24PDZPcugryjtln4mJhavEwCAHOtud6UApJDZr6uwa5X5V6QpUxd41cpmuqcgNVY7lxhqUL2R/2ycsLzdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Thu, 23 Apr 2026 18:40:17 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 18:40:17 +0000
Message-ID: <25163a38-53b5-445c-936c-0cba94cb731f@intel.com>
Date: Thu, 23 Apr 2026 11:40:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: do not perform flow
 ops when netdev is detached
To: Simon Horman <horms@kernel.org>, <boolli@google.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <decot@google.com>,
	<anjali.singhai@intel.com>, <sridhar.samudrala@intel.com>,
	<brianvv@google.com>, <emil.s.tantilov@intel.com>, <stable@vger.kernel.org>
References: <20260421051641.370436-1-boolli@google.com>
 <20260423163307.989421-3-horms@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260423163307.989421-3-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|CO1PR11MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2422d5-5176-46ad-f229-08dea167c3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: vx80BKTH0GHP7kFB9pTJAiBL3i0zNSEcNNFo0F5CUqvkAk2X0j/JnahVPzFZ9RkW1ME02QrQnLcSFQwnfAvHhnCId8dpPTaU7JKq2R4E1XmSflm/DmuRh1o1ksdLehLkSBFT5iat2FzYD0gVYJigJQG67QSqDIz0jbKTlqzGrhtaGyXDBOlA/cGqjI94hWCSmVd4CoVQ4tG5CKuQyd7cXFAhH1sCw+jAAEtScDEfdmw6QSqmKE/r6JIJ+hjoT4u+Z8OJU2XT7iL2KK3iUXQRaw3Dh6wrOWHH5PjPF1WWm9+X8hRBTVh1JZ8TFcupqkWFJYD3eZext+GrZ+gddqBTOwU9uWJ2j3018YpfueN8eS8xRe02tFWp6Q9p/E04s92eEAD42XSLZHKIxtdTHjdYWDEgYxAIjCLe7Iq5v0SjLFGgdPSvRqd1g7yY1zq/Or85bt8SW1Gko4Wa72qDRFpV2dldoFDoUY62+d8240Njdr3l0t+F5T9ShLaZ/5iueagCiHydzYJ60UsqOyQYjaoiB8y3sUFsar8Z+8EVGByOJ1GTYgnmsplXmkZ2IHdWzqbsm1X9bFvOgwY/m2oNZouTVGEDnVJPu9W0zW5YNyqhQTREnzH/WaltP0/hpfoGCgw93BhdD9brRkD4OChZXltA0OCyc8vv+Qx/4zn1EBluw2/KsO6cIom6clq7ky+XM7MX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xnelRJbFFxbDRuaFFOalhjNEZIMzFneUN4ajZ1RU1OcEdSQmU2UHFLa0th?=
 =?utf-8?B?clg1YlRZR2Q2UFlMRXpYTXVHM0MwRW4rWFh1WlZJMUJZQUMwRWM0dk9qWnl4?=
 =?utf-8?B?UDFHSk1NUS9MMERDR0pIaGt6TW41aVRXWjBHT3RvL0JMcDA5VHdrclJ2TnQ1?=
 =?utf-8?B?RnBOTGtuMTFMNStkR1dIbHBWZlZQVml0Z1pudG1FYWQzVHFXWEFpSHU2dVhC?=
 =?utf-8?B?bmZQdjlBTUNpWHJlTSs1WFFBTEVtbVRPVUI2VnZ5cnpIZ2ZwZm1mS1ZKdzlV?=
 =?utf-8?B?NHZ3MWVpZG0yc3ZiN0FBWS9tM3QvSmpmUTd4ck5WWVFVMWZvYjNiVXVTYTA5?=
 =?utf-8?B?ZVNwaUo1QkxXN3lrRTJyOXN0c2x0YWRtbC80b0NOY2NsK2N5cnplTEFwaWdG?=
 =?utf-8?B?by9JQXQ1N0Y4ZUN1YU5jZ1NlVlNML3dGQ1RnTFp6V0tpMDVBQVZ4QXduNWMy?=
 =?utf-8?B?NmtTQTZPTnZZYzY1RzI2RHJzb3ppREVEK0UrbWZncFlOVlZKdkRJN1JCUTRj?=
 =?utf-8?B?QzNnNytMZlNJbkhQUmMvQ2pabjlRVjZYa0ZrT2YyemxLMEliZ2trNXFpS0hH?=
 =?utf-8?B?aVNlVkpraUtDNiszM3RUWER0RWd0eElPSFJBc2I2UHlReDVXVnpwRzZrblc2?=
 =?utf-8?B?RFJQTEl2Y1dQalVOMHc4UHZzSWx3WEptaGV5ZkY0SHZCbWgyL0FjbHJPWkw0?=
 =?utf-8?B?VHZBanJjTnFQSmZlZGJPMytLMmVaZ3lTc3BlM29XMEFaMHlJUGlFempYZjdm?=
 =?utf-8?B?L1pHdERTQ2xwQzlMNG1VS1RNeTBNZFUrM1h1RWlJbkZmdDY0clE4cWdldGZR?=
 =?utf-8?B?Ty9CeXVDVStsek5HSzUremxQR2xlKzNCaldwWWJhUlVHdlhvYkR0c3BpQmlS?=
 =?utf-8?B?L2lSOXRKQ0NNdDZ6SWp6TkJjeUdCQ2t0cVFNSGtFQUpZSUhlY00wNkg2OHVG?=
 =?utf-8?B?VDJZRms3OUNhbCtkMmROaVV0WHBlNFdIdndaSEQrdllWb3RLNTFKUHcxOHEv?=
 =?utf-8?B?ZXYrRUlIR3dFbGlrQk1hbnY0WlNrd1dxR0RHN0lKVTJ3ODI3bmdTOEZoSjRD?=
 =?utf-8?B?L1E1M1Vpam8rUEk5UWtWZUhlby9DbzNyUFJQTjJJTkpXTHZLWXZXUWxUaVdE?=
 =?utf-8?B?QVg2Ny9JZ2VMVktWY0RTQlpGYVZLZmNNVzY1dHJNTlcwTkVhQk1hb3l0M3FR?=
 =?utf-8?B?VTZ2bVJEaFREZFB4OUJPRllRdG9EU1cxSWt1aWFaVFFlZ1ZkbEI1am9Jbkl5?=
 =?utf-8?B?elF5VnBGbnREc1diOStBY3R5NjYxZkJCd2NYKzRNVVNBL0grRzJUNkpJbG4w?=
 =?utf-8?B?ckpQdnRzVG1LSGNuWkRoWkFHbmYwQU1iNElvT053dVBGa1dWV1hQQXNyRUhZ?=
 =?utf-8?B?WlJFN21QTVhqRUZhVWxRZmsvUThJanV3RU1EbkZqUXNVUVB4MXNDM0pkYy9R?=
 =?utf-8?B?b2M1Y2xrcjFKVU05Unl5UVFXc09zZVJXam5VQWMrQXU1b3FqRWRWTEZyU2ZP?=
 =?utf-8?B?YUpURytnck1na3EzWkllNXh2bzVnaExIYXIxY1FtZVJnd1NJcWsvUFNEN3NG?=
 =?utf-8?B?NU9LdVhHZzhJVmx6aEYvbjA5S09CU3ZOazdoMnRJTVRDMGNHNmNqeGVBTTkv?=
 =?utf-8?B?Y2VFTWlVQlJEaDRHQkxlZTJxTjZnaVI4TXJCM1B2WDNqMlRuWlJHVEZyZUE1?=
 =?utf-8?B?MkdRbHAzVXFnQVVqaExWL0NGcE4vWlFnY3k1MEVwNGEvSE9mQTNUZU9pRk5B?=
 =?utf-8?B?ZHhOZGNSdDhvYndQd0tMcDg1Z2NiZE5uZmNlRlRhZDVpaTdRTWtoUkNaaVE0?=
 =?utf-8?B?TVRIMU5EQkxyMDhaUy9ta0hJeG1TbG4remhHazV5ekFPZzlEaStEb2Q1eGhF?=
 =?utf-8?B?NjZyZnd0V2w4bDVYb1V3MWRzdXZkMmtoWWlIaUtPb3dESUoxYWRHZi9mWGI3?=
 =?utf-8?B?SElvUE83cUg2QTFjVnlPcEdjSWczeko5UFhpMzhGMkVYOUFNKzhvNzFJNmlZ?=
 =?utf-8?B?M3prZm1oOHZEdSs3OCs2WC83bmlIdHhrZFI4QzNlUmI0RXh5ZGxaakoyaU53?=
 =?utf-8?B?RUlOSGE2ZDQweWdmZ3pWMGxDTHhvOWRNOTYwMDgxN2hPSlpLVXJQNi9CZC93?=
 =?utf-8?B?dDd0Z1NWQXBzY1RNK2kwOFZNK2dPN1pHemwxK1RRNjFubGxNazM5QXpUNG5N?=
 =?utf-8?B?RkNJN2Qyd2c4eWZaZ0RjUGJvUzlJTnIyT0t5ZmtmWWlROVVOSU9TaStwdjB1?=
 =?utf-8?B?bG5BMXY0emErSFNjRU85bHlDMk5hTzBKQ2RnSFNuQWpTRUt4Nyt3d2t6MFVp?=
 =?utf-8?B?WFJrWWFjUGpVeUZzeVBVelplRk9CMEM2djM0d3VmSHFlR0hOdFFTZFVLYmZF?=
 =?utf-8?Q?tDY9k2WW9wIwLc3w=3D?=
X-Exchange-RoutingPolicyChecked: EkdOC3V0NZ+fDUzMtQBZiMWGEF7mG4gh3LJ3hai9knIjhlYYoFOYXXQZ14tuZhqhfQhtkhz3CpGkP7WQbnWECnw4O7qDt7WypdKOvfH5rG8qKFYq4jXebmPNRemMel+8tI9rSkraMGwOCYey7l1GehkXgXHBYgIGVFzHbgcyrHY9b7mtCamJNz7bMCs9DPQeybJuAdZWuqsWiqpcmtfGW0xJrI9YVIbd++FrrrTKZZEk21anosyqG6zXDUV+pyqgEzTAjwrKdomfRIcPQyxY9Yc6RnUxCMoSQ98c20CzOEOmZnSYLlh+0AHL5CtFiAx9EC/cXd+EZxSBqBT7WWVmfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2422d5-5176-46ad-f229-08dea167c3e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 18:40:17.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnK4CjVfmOESHyYu0ZkZMwxkusAwUoVqH9F9NPYbnVnPTQk5g/byVOsV+uhDbLrbbXCgtTQIlSlLtSZIeIjggN2RVQiR3JMlVUK2qFmQaqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3683E45627E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/2026 9:33 AM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> idpf: do not perform flow ops when netdev is detached
> 
> This commit adds checks to prevent crashes when out-of-tree modules bypass
> ethtool core locks and call flow operations on detached netdevs during a
> hardware reset. It introduces netdev and netif_device_present checks in
> idpf_get_rxnfc and idpf_set_rxnfc.
> 
>> Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
>> handling a reset") prevents ethtool -N/-n operations to operate on
>> detached netdevs, we found that out-of-tree workflows like OpenOnload
>> can bypass ethtool core locks and call idpf_set_rxnfc directly during
>> an idpf HW reset.
> 
> Is it acceptable to add defensive checks upstream solely to accommodate
> out-of-tree modules that bypass core kernel locking?
> 
> The core ethtool infrastructure manages locks like rtnl_lock for in-tree
> callers to guarantee safety. Modifying the upstream driver to paper over
> locking violations in out-of-tree modules might contradict upstream policies.
> 
> Simon says: If this is to address OOT module behaviour then I am concerned.
>             And I would suggest that the correct approach is to fix
> 	    the OOT kernel module.
> 

The commit message says: "OpenOnload can bypass ethtool core locks and
call idpf_set_rxnfc directly". But if it somehow calls
idpf_set_rxnfc_directly without holding the appropriate locks, then no
amount of changes to the idpf driver will fix that issue. It is simply
unsafe for that to be occurring, and this feels like it just patches one
specific problem without addressing the root cause that something is
calling the drivers ethtool function without correctly holding the
expected locks.


@Li Li, could you please explain more details about the workflow that
triggers these behaviors? If it can't be reproduced with in-tree modules
then I don't think we can accept this fix.

