Return-Path: <stable+bounces-195203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6275C711B4
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 22:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E06304E1291
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049CD263F28;
	Wed, 19 Nov 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzIm4dyt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F841270542
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586218; cv=fail; b=qMS1MZ3aX1cJ9CXXesjqCmYapoFzT040MtyVY/ycz5Xzg/eS1ZkmCHwu4TDJheE/aB6xv09pFWXvlrp2mOc4zIrx2nCQcQLBNQyH9YzUSqOvZV+byAGKGrRjk2piV1cHMv96B35GV3iDQREqSz/x+RrdtUHpGd4km4jQAXpJ/t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586218; c=relaxed/simple;
	bh=KZm05GAlYZTT0ebaF6nrobzPwPLzpkSl3woSVs3+dK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+ffrbGe+0eUEzbIqqSvlta5/XTl1vA97NuExmvbMtgnnXCEhXw0lste78nQLcJJIL64Hq3T1YUh/OjVez0LQR4XjOqzGPsoc5jz3jkBkstwUb68msyahNVZrSAdZ7t04ad0VFGMtKu6Me4AYhvS+zNYYbB+r3htQEkN/fkPAWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzIm4dyt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763586216; x=1795122216;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KZm05GAlYZTT0ebaF6nrobzPwPLzpkSl3woSVs3+dK4=;
  b=lzIm4dyt8Htkz/699U3ZrBXJ+FEvL3Ikr2PqoMNr2njnBQRvYnJRbwsQ
   Kp6+B2DccQJxXX5o4yaGPtHPsfrfRwtJOU5yIf76DPb70980ZcKAkY6ab
   mDE4MpGRmMZzhSIxtJ1UKuTaaYij2uaAiLzFEwFl2LxyMB73Dh5ofFD6f
   9z3CIP/qWWd3wqk5+yO8WvgN4XMTFEU0TaIoelCODuzrzJPJf/VpbrsGt
   wGJ23VNLYFzW19cfVUhsSjLnoO0jumveqR0OpL8FKacvQS38gLIHBM975
   aRE8ihjr00VL8hq2ZhDBrjJD729338UymNjtIVr0tiM1yNN6ySJhCvGbW
   w==;
X-CSE-ConnectionGUID: Mk6dk1R4SGCCLvfp4PGoew==
X-CSE-MsgGUID: oc3VP30YTV+TzpNworTGHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65801417"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65801417"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:03:36 -0800
X-CSE-ConnectionGUID: 6Q5SqygvS+eR89MLTjRM9w==
X-CSE-MsgGUID: eNdSzdbVSo+B3NWLJlWRTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="195471765"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:03:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 13:03:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 13:03:35 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 13:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4Nm/7TUheMaJyyh7fxgSxMx1Cu3Tjy/QsuPYyJMvgwU8x30DzSVv7PVEVErBTxlB/tZSPcnROnmyq41SNuy8/k7SC0Z7m35LFAa4mzBp5YaReDNhTat3AbvdEMncE7bJ+BgXOkQr7Qa69KoKtPxKIBqXI1IEH1YeJ2RgY1X3sMNUM7ApkHLKnBWMH/NcC4zTDJMLzT5aonyskZDLXzqFgKlPK233U5ip8KhzpZz6ABCGj3YSn5Oa79GNwVNFW1BDnRtqlbWYWR/cN0UWyJRcFRj9diJ2rZRL4Xp+YqXQhfG/+HqMxngsTA5jmckyXMXE7G68sm3+zp66pHikcsT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7OsVtN+Zounf2vId0+CSWi6VqzWQBY/U2zX9pNER/U=;
 b=d/R+6bDNSsh/rbiIkljRk6t/7SfqLzphg8/SZJ9tBJ3h83x3Mbkr6/wx2bnb6Amcd5PFKYcac4SqRiR6HS7tpXXEDmsr7WL8bZTT2MMYkrbYpkqxFWy8VF00EJJE4k8ujya4evyGxF9Cws0jAOuDxSLkCWOi+qss/Z5WW0yrrzx9GL9nnXdx0uaGaL7eVhQsmA1rdS3WbEoxFKvJ3PSimDJfB2GyKhVhX3TerKoVFFK9a74BGF7dpgv3zhoYnP742bjXBgg1Av2FJ5glsePNs/TjlFM+LDZANhe/VM66dh2Z8biWMjkvm8WCYLUVyD3gzQJsklik3K7x7LIEY9IK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PPFC3B7BD011.namprd11.prod.outlook.com (2603:10b6:f:fc00::f49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 21:03:33 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 21:03:33 +0000
Date: Wed, 19 Nov 2025 13:03:31 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Michal Mrozek <michal.mrozek@intel.com>,
	Jose Souza <jose.souza@intel.com>, Carl Zhang <carl.zhang@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe/uapi: disallow bind queue sharing
Message-ID: <aR4woyxvDvQHGNCc@lstrano-desk.jf.intel.com>
References: <20251119203031.267625-4-matthew.auld@intel.com>
 <20251119203031.267625-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119203031.267625-5-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PPFC3B7BD011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fec0d83-b681-4020-0103-08de27af195c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cCSgO17rFav40o+KiNbcSBhF0dbBWCywWvzYJMiSvNtgToQ2UUQN+NvmBD?=
 =?iso-8859-1?Q?jEiR9vJe5UACn3DY3EaRfSNr8vqDMWL2qWXwl+fwhT6qRsQKNphEIzmfgP?=
 =?iso-8859-1?Q?RePDFp1+7FbWxH/TUn195+7d87nl8WH2wsedWEdNeQYXswrzFqwqREgDvh?=
 =?iso-8859-1?Q?gEEuhE1bbJLu5zHaRaRSaBDEWQtRRAWthvrUivHEoFkaEcKOjouLfA6prZ?=
 =?iso-8859-1?Q?TircGFlKpHu40K7oo5R0DQYLYyS5NhRnPn7M7a1IXJWZ/MQ/Vx1Js1Nqqp?=
 =?iso-8859-1?Q?RLvULtKPkxlKGfC1UqNAnvVpQ7uD2UkrohAC5KvjTGqvUFtYBIGn5mt+G5?=
 =?iso-8859-1?Q?MA70CO3DQ4KVw5PF8uH1oogsEXGXYNzbwbYIr67G0yKgSj/D48Eyu7Tg0x?=
 =?iso-8859-1?Q?icQG7UpCIat0t08ZTSkXNqIKq+rBxP1MmOcukpQdoKs0WDDVAvhfCzte5n?=
 =?iso-8859-1?Q?JXlNmur7pBemlD799mVCS4K0pWtVyw2R/zBZwbBL2KgQ5ZqyjVTB/WW3V1?=
 =?iso-8859-1?Q?bo4BFooWpqAJfdPW0ppQg37kf4q6oXssoT58ZFAFpG4r62P9i5FlMi83TL?=
 =?iso-8859-1?Q?ujaWg1GjSPxRSDSUHsi2JVUItIQJ/7jgsKMd2a/S0+6Vlzf/uIYpx2lGYI?=
 =?iso-8859-1?Q?D99cqE/3a1XMBGmqrAtgaE5MmTpkjicCWu+DdfF02RTqs6iaInQ8PrOYdD?=
 =?iso-8859-1?Q?Ye/3vLKYh+KPiMpSlHuzkD/55bj4BTAmTeM08C9exJQv/kpgCTPuuibFyn?=
 =?iso-8859-1?Q?hW0W1kBGjIXhIOf+jHlE3cqpzZkRdZ459CmOIN0P2ooJ8N5vXvguYPgplJ?=
 =?iso-8859-1?Q?h8ZYPDPENPFKtqtn4CXUHd+v5Fhpu6AACkfiQ51PvTDpfJmeUCECzKsCk/?=
 =?iso-8859-1?Q?gueTyUHVc1ivowtgvuHaMbELjDMnezWHuPHXkTplgPcZXUHgdoK0KNR2tR?=
 =?iso-8859-1?Q?5pjSsES/aRBeG4+5c0IHX1N7xdfNw8eFvnuxl+1D4eCUs4iGObJWFjQSuR?=
 =?iso-8859-1?Q?zcoPfYlPJBbzhqbO0OXKJaX/irVm/0kIiC1guZYJogRSwLJ6wGuiQyskzt?=
 =?iso-8859-1?Q?0m0HoZ55OnBX3yOBuLvA+UUv3xLpajeKpSGBTvGXa4vkrdCrVbIhAuLOTa?=
 =?iso-8859-1?Q?epuwlQcJzmHUy3jGAt+dvAKDasJeVeRa0IXmpzPmRkt7V83hMnFFghAUFZ?=
 =?iso-8859-1?Q?4PptSLshos5B3KHKn3JOm5UcdQt6+6hKOq3X0VKX0mg4tziM4nJ8c/4PK1?=
 =?iso-8859-1?Q?P2yy/XzBoONnYS0KX+o5vPQXC03ZzRuQTc85uNZYaeGvCijpN1QT2thc1k?=
 =?iso-8859-1?Q?sygEfD3R3Gaw7HOLC81MvzffW6K8jXuiqSxideg2K9bCcF/ageMWxuB19/?=
 =?iso-8859-1?Q?ZlEI1yrVWE0k5B+vgKojH+f/5DUgpGfOeBx9vw6qFU6GDyPMCVpoCLy9kf?=
 =?iso-8859-1?Q?8v9GPyiMp88+Uwc2l5sn7mkpZqtgUkNMiS+SOWBZDKMsmUl+928BIPM90C?=
 =?iso-8859-1?Q?iYpJvfUV1DaF+4OzaYj71s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?URD6yCVw2DH1eqIF9wlUvM7MloPT4MnyAUoNF4onPW2Am8JQZuTqD6s177?=
 =?iso-8859-1?Q?gkfan94HhVNO+UfoXmggZVlJz4l7SvpF3QbgQ09pzYmnyym9I20SDPct//?=
 =?iso-8859-1?Q?O474/veyTOpyY01H6DU8uuxeaCB4DL+cwOhH4meaAMmppppcJm2R/k0gWo?=
 =?iso-8859-1?Q?w6Yee7rafiwhnHyCw3FpCY9Ygu5fFic1/LlyA7s1dftvp5B85emTsZWIBD?=
 =?iso-8859-1?Q?n/weLRnCuE7sb/HCw0XKzQaI6QAtZkwwtollZzfT5IMwifFDBKgQE19pdD?=
 =?iso-8859-1?Q?D7Z75qmA7J9/6Wu5zoQHrt76+I0MSdoktzjQSsXA1GUik+1M9U7XoQ1MV9?=
 =?iso-8859-1?Q?yN3vbWg4YfOhchxm1zXJCE8RRylZLGYV/yeRMt94ful+ZF9qhWdyiNWr5G?=
 =?iso-8859-1?Q?7a2Y0AqaOFtKyv/QdWCffe6DrDg7MV+dxM8zzuH3FEQj6DKZFpi8f+rKGB?=
 =?iso-8859-1?Q?l7gAE4pGqs9Zyml4HPvdruE2FiPsRXqzXY4Zd/q0emnHxgK0y2HaB8IP6j?=
 =?iso-8859-1?Q?JSBZTikXjLMQOoy+j7GHJVsf7TbMQWjA88FVPi+vBlcb7csgteH686ZN5R?=
 =?iso-8859-1?Q?MkAUwjhDrcKIQnVbssohImtLAlvWYOuAVbcKnJ10pGCQjOp5K1dk96Bvfl?=
 =?iso-8859-1?Q?Uzk1W5DC1ja7bTI10IdxTdwWNH7Q3l01w6xb4WN0BRIs4ipA/AokcYs6iD?=
 =?iso-8859-1?Q?vtSINWIngGbrpBUO7svZjSL1HigtM/xKE6QFkBMKuOLvnBofpEh6bO41T6?=
 =?iso-8859-1?Q?opT9aeDAc9yspGAYro2inuy3EC0xiZriPQHU5NBoCsw0Sy8MJwPuZx2C6M?=
 =?iso-8859-1?Q?L7ah9R/bBPHhiRBVrLgL2nPHwJu7+6W0Rsvevn/cToAlRfeRXBm93GX6Gm?=
 =?iso-8859-1?Q?Eu8CUrShYjJJDP7Hu1uk6fDyt7UvkCdlHWydIK77r2smCBGdT2BssyqC6p?=
 =?iso-8859-1?Q?ebjNZc4Dk5g2fJLtzF9rENipM3aoIy2/y1gTtz1UeUejtzWD7oXSqeDJBG?=
 =?iso-8859-1?Q?cLCQiR/rw740iYD4k7Ruv0hPAQPwvDInN4c9bMvMef0bREZtz207Eni4UQ?=
 =?iso-8859-1?Q?qKEA8IKs6fv7A8pvzSHLq15OGdtzee09/So26kA/4aLG09XbRFQgWliiu6?=
 =?iso-8859-1?Q?Y+U9TxZG4WIuzwwfBKn+W3ciuIsmv/scDPsT0wHBmkVO4bKj6/2vfT2kf9?=
 =?iso-8859-1?Q?CTSyITnPzXL1yPRObmV4XyGfma/AhIfkd6pskrsgUPoCpql/GZOGta8dm3?=
 =?iso-8859-1?Q?8W3QZyHRZBaUwP/AqFqBtf+hEZVu7HX78Cn3+NrJbl/81PRrv6gqNiTGZw?=
 =?iso-8859-1?Q?G0opbz/tAIWrvkMN4cJ2E3ul3MrfApqrphON7cCoeyvfAflcacfgxL6b8W?=
 =?iso-8859-1?Q?fkUSQzxlr+AaG7vN6k/Ni5LO0OtnHN0H3IOqvInMbKHXRh38C5Mgf1vRGF?=
 =?iso-8859-1?Q?3fWMNW6yOcSUGBNk7qhYe8KyVwXHjtsFBfAIJFpitB73CtrowXCQeESDHU?=
 =?iso-8859-1?Q?rFOCeSSeS9sz2JrVVBwC160hNrtusN5IT9NUr5hqEYAZR+VdmfjuDc5BoO?=
 =?iso-8859-1?Q?T/fQ0q0L7tKGGzgLRbSZfTwndJ8lX2CPt8BpaYPzVQyxAgIVxL90Of611E?=
 =?iso-8859-1?Q?umtKadEgyVMqJRiiYSzWF/M0Q2PETkhTUawAHJ1zH/54zEPUvqz5bEGQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fec0d83-b681-4020-0103-08de27af195c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 21:03:33.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r05z9vUWJidto5HkxfLJF1y9/nXMmYeim+rQlfI2CFHBXPI5AG+I3nATB1EEJW3rha8i1G9OXGwq65CfPUf59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC3B7BD011
X-OriginatorOrg: intel.com

On Wed, Nov 19, 2025 at 08:30:33PM +0000, Matthew Auld wrote:
> From: Matthew Brost <matthew.brost@intel.com>
> 

Feel free to take authorship as you have modified what I sent over
privately enough.

> Currently this is very broken if someone attempts to create a bind
> queue and share it across multiple VMs. For example currently we assume
> it is safe to acquire the user VM lock to protect some of the bind queue
> state, but if allow sharing the bind queue with multiple VMs then this
> quickly breaks down.
> 
> To fix this reject using a bind queue with any VM that is not the same
> VM that was originally passed when creating the bind queue. This a uAPI
> change, however this was more of an oversight on kernel side that we
> didn't reject this, and expectation is that userspace shouldn't be using
> bind queues in this way, so in theory this change should go unnoticed.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Co-developed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Jose Souza <jose.souza@intel.com>
> Cc: Carl Zhang <carl.zhang@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_exec_queue.c       | 27 +++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_exec_queue.h       |  1 +
>  drivers/gpu/drm/xe/xe_exec_queue_types.h |  6 ++++++
>  drivers/gpu/drm/xe/xe_sriov_vf_ccs.c     |  2 +-
>  drivers/gpu/drm/xe/xe_vm.c               |  7 +++++-
>  5 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
> index 8724f8de67e2..31bb051cbb78 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -328,6 +328,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
>   * @xe: Xe device.
>   * @tile: tile which bind exec queue belongs to.
>   * @flags: exec queue creation flags
> + * @user_vm: The user VM which this exec queue belongs to
>   * @extensions: exec queue creation extensions
>   *
>   * Normalize bind exec queue creation. Bind exec queue is tied to migration VM
> @@ -341,6 +342,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
>   */
>  struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>  						struct xe_tile *tile,
> +						struct xe_vm *user_vm,
>  						u32 flags, u64 extensions)
>  {
>  	struct xe_gt *gt = tile->primary_gt;
> @@ -379,6 +381,9 @@ struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>  		}
>  	}
>  
> +	if (user_vm)
> +		q->user_vm = xe_vm_get(user_vm);
> +
>  	return q;
>  }
>  ALLOW_ERROR_INJECTION(xe_exec_queue_create_bind, ERRNO);
> @@ -407,6 +412,8 @@ void xe_exec_queue_destroy(struct kref *ref)
>  			xe_exec_queue_put(eq);
>  	}
>  

if (q->user_vm)

As far as I can tell xe_vm_put is not NULL pointer safe.

> +	xe_vm_put(q->user_vm);
> +
>  	q->ops->destroy(q);
>  }
>  
> @@ -742,6 +749,23 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  		    XE_IOCTL_DBG(xe, eci[0].engine_instance != 0))
>  			return -EINVAL;
>  
> +		vm = xe_vm_lookup(xef, args->vm_id);
> +		if (XE_IOCTL_DBG(xe, !vm))
> +			return -ENOENT;
> +
> +		err = down_read_interruptible(&vm->lock);
> +		if (err) {
> +			xe_vm_put(vm);
> +			return err;
> +		}
> +
> +		if (XE_IOCTL_DBG(xe, xe_vm_is_closed_or_banned(vm))) {
> +			up_read(&vm->lock);
> +			xe_vm_put(vm);
> +			return -ENOENT;
> +		}
> +		up_read(&vm->lock);

We need to hold vm->lock through the xe_exec_queue_create_bind create I
think or the check is meaningless as the VM can immediately be closed or
banned.

Matt

> +
>  		for_each_tile(tile, xe, id) {
>  			struct xe_exec_queue *new;
>  
> @@ -749,7 +773,7 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  			if (id)
>  				flags |= EXEC_QUEUE_FLAG_BIND_ENGINE_CHILD;
>  
> -			new = xe_exec_queue_create_bind(xe, tile, flags,
> +			new = xe_exec_queue_create_bind(xe, tile, vm, flags,
>  							args->extensions);
>  			if (IS_ERR(new)) {
>  				err = PTR_ERR(new);
> @@ -763,6 +787,7 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
>  				list_add_tail(&new->multi_gt_list,
>  					      &q->multi_gt_link);
>  		}
> +		xe_vm_put(vm);
>  	} else {
>  		logical_mask = calc_validate_logical_mask(xe, eci,
>  							  args->width,
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.h b/drivers/gpu/drm/xe/xe_exec_queue.h
> index fda4d4f9bda8..37a9da22f420 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.h
> @@ -28,6 +28,7 @@ struct xe_exec_queue *xe_exec_queue_create_class(struct xe_device *xe, struct xe
>  						 u32 flags, u64 extensions);
>  struct xe_exec_queue *xe_exec_queue_create_bind(struct xe_device *xe,
>  						struct xe_tile *tile,
> +						struct xe_vm *user_vm,
>  						u32 flags, u64 extensions);
>  
>  void xe_exec_queue_fini(struct xe_exec_queue *q);
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> index 771ffe35cd0c..3a4263c92b3d 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
> +++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
> @@ -54,6 +54,12 @@ struct xe_exec_queue {
>  	struct kref refcount;
>  	/** @vm: VM (address space) for this exec queue */
>  	struct xe_vm *vm;
> +	/**
> +	 * @user_vm: User VM (address space) for this exec queue (bind queues
> +	 * only)
> +	 */
> +	struct xe_vm *user_vm;
> +
>  	/** @class: class of this exec queue */
>  	enum xe_engine_class class;
>  	/**
> diff --git a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> index 33f4238604e1..f7b7c44cf2f6 100644
> --- a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> +++ b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
> @@ -350,7 +350,7 @@ int xe_sriov_vf_ccs_init(struct xe_device *xe)
>  		flags = EXEC_QUEUE_FLAG_KERNEL |
>  			EXEC_QUEUE_FLAG_PERMANENT |
>  			EXEC_QUEUE_FLAG_MIGRATE;
> -		q = xe_exec_queue_create_bind(xe, tile, flags, 0);
> +		q = xe_exec_queue_create_bind(xe, tile, NULL, flags, 0);
>  		if (IS_ERR(q)) {
>  			err = PTR_ERR(q);
>  			goto err_ret;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index f9989a7a710c..7973d654540a 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1614,7 +1614,7 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags, struct xe_file *xef)
>  			if (!vm->pt_root[id])
>  				continue;
>  
> -			q = xe_exec_queue_create_bind(xe, tile, create_flags, 0);
> +			q = xe_exec_queue_create_bind(xe, tile, vm, create_flags, 0);
>  			if (IS_ERR(q)) {
>  				err = PTR_ERR(q);
>  				goto err_close;
> @@ -3571,6 +3571,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  		}
>  	}
>  
> +	if (XE_IOCTL_DBG(xe, q && vm != q->user_vm)) {
> +		err = -EINVAL;
> +		goto put_exec_queue;
> +	}
> +
>  	/* Ensure all UNMAPs visible */
>  	xe_svm_flush(vm);
>  
> -- 
> 2.51.1
> 

