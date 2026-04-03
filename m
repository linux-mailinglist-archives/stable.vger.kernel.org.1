Return-Path: <stable+bounces-233216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKoYLBjrz2lF1wYAu9opvQ
	(envelope-from <stable+bounces-233216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264539666C
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67769304C2DF
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E963CD8B8;
	Fri,  3 Apr 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk35v5KQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1A3CCFA3;
	Fri,  3 Apr 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233459; cv=fail; b=FViAcPlCwE+UazQi76K+tGr/rO0EiXUeMzJhdgZ4p17yG0wF8oy3+1zS+rf/8jod1wfZtBbLXluxJQI9u/OiEDIjS6CnK3CyJdaOxksneiIYcxhJRjAp8TvLulbQth9WCgtz0oNbOl4wwsW7yOnOxaOIQ0I5ZlZbZ4oitbU5xao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233459; c=relaxed/simple;
	bh=l68+bTZ2/NOkYXj/hd/e0sIaM9ZNyH71O8wJ2B5DiLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6yXbZmyxKd4++3Y4HrhEXBXxe2WL+p5DXOkqz6IsegnMtnpORg/039tKRuJd+JiFGky21WTa+tWKCE5+48YdbIAoXYiju/RML8OkjHU1Nm7FRJLjZ6dfU+BPp202NPDSSSSHrx3gGmWQ1qg4i/SGexWyqL7ge+0LfxbEAjoo5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk35v5KQ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775233458; x=1806769458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l68+bTZ2/NOkYXj/hd/e0sIaM9ZNyH71O8wJ2B5DiLg=;
  b=Vk35v5KQrwI8ptCRNyGU/HLUseK5CVQrE/WtQLV3HXekZUiuSPx583JZ
   7aafyB+YG8xLmc/0wUzjj6HtuOrYJ0dMqUe+Gzz29MhB137frulxHF/aC
   s6VHjY/n3NcGqFyLYfJpUDLtSR9ymz35KMZpL9cMhCHSpkr4pHgptbGKn
   0JcFPTTfURxOx6WR5lYXKS9e+uO/ViN3wpG94NypPX9uA5u5h5YyrRp4r
   niEtC0RKppAAWzlwBWL4CqtdvbEcA2MWgf5D1qhWgLBn279/XIBvT+foY
   0GQ+KUtibr8cBsGCuPc1A80EZZOm/UCmAYr5u7qdBZB3+5yR8GShkxUbv
   g==;
X-CSE-ConnectionGUID: Vpj9JkAPR/+kAnc7MhD5Ag==
X-CSE-MsgGUID: /NBazH5XTWqSxvp2pGacCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87684750"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87684750"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:24:17 -0700
X-CSE-ConnectionGUID: sFlsvVOZT2qhddM7/soJQg==
X-CSE-MsgGUID: 6MkIvhcaT+yGHQp+0ZH1AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="227231899"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 09:24:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:24:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 09:24:15 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 09:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWQOPyZyXiJxzeFqiH8DAEOiyaVer1CZk/LqwFBXb6oVg/vbSUqbgqAb7s8uqET7PknhCyrH7asjAszTG+HPImBFtmewE0ScIhGlLrJfBYQVNfYy93zImSofLGCUF52g5+0icm2bOYQh+RWC59maSzhK2/qZGl+AdkiIYvvBTT1X7kAs3Bznommt/fY4Zn7nRx7n0ay5c9qNi8tn41Zga1S/OFALhUy3ZJUbewRntS1GNKPa0zbD0+Hmfh8rSqqW1qc1R5Cdsn4b1kJxvHTzhNtBohWAHeKXKcQXeVx+WZgnGNwU5W4kEvxHAamCMZ5kekwPlsU9WYUe9WE/izyBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l68+bTZ2/NOkYXj/hd/e0sIaM9ZNyH71O8wJ2B5DiLg=;
 b=Z1vDl/H+xbMtTtErs3tAlGaRR8QNBY9tGkI0ipwAT0qLGKhtoHygDOyMYl8bnigsPIXQ/vx0YxaKRq7GBFM6+vl+ROvSQ3QwHrF6CqsIY5q6INYKOLHGozznqBFRJxHr0uxjVDJfBre4Pd7xMPLX+CtzB9bk9pX1xzUcx/T11EnnD84TTD+a3t1UOdvi/j49SkAmFHGvUx0HnUlo/ZaZmhspg5lsWmcWHqr/h0l96akO3715MjF9gj4caqfxPTnco3h+S2maKkz8HJuqSH/8rJbDHQFMfB2FSzCUvpkBIWGIsgeKhoueUtXdmCGCXV0h+78bu+gRvDxmh+voZSXP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 16:24:13 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 16:24:13 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"clrkwllms@kernel.org" <clrkwllms@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, "sgzhang@google.com" <sgzhang@google.com>,
	"boolli@google.com" <boolli@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/3] idpf: improve locking
 around idpf_vc_xn_push_free()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/3] idpf: improve locking
 around idpf_vc_xn_push_free()
Thread-Index: AQHct+VgWFsRM/ukg0GW8dRpHUF7d7W3Cn2AgAVHnICAEUpDcA==
Date: Fri, 3 Apr 2026 16:24:13 +0000
Message-ID: <SJ1PR11MB62976CE2D58C230ED10CE4579B5EA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
 <20260319211335.23236-3-emil.s.tantilov@intel.com>
 <20260320074245.f8dPuv4j@linutronix.de>
 <6c1cc71d-0b3e-4edf-84b5-a4bac52de4dd@intel.com>
In-Reply-To: <6c1cc71d-0b3e-4edf-84b5-a4bac52de4dd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: f3f37840-c644-4417-8a44-08de919d715d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ZeT3Psc3WdkOwwnLwDhEvEb/tVjUzh9f1OhVCFOkrqg+Xiif3LEdsTv/cxbobjnEfmEOt7Tgv+/QjQxxhE3VwovV9sRm8ATcyyaTthfFX4/ogVwiASlNtrzItZpMzAulpdXN06L/Nv569ZskHG1ZECYUkkyTu4LsHU2pl0VKd33BbFOKlA1wAzW+23IpgnF7c+TaCRGVy7zY49ReKj0FtUzxBltW6EplVYz0ItHGj9pUcAxLr0+xNL5RmXXJUhidNzlBPtJgGxKnDp2666+HcaQAT5BVOkWiujSCOlI8S60s+yBH6ETfXbuAhzK/laPXPPst/lQG0aIHwaLlWfsnIKdsB1S9zFFKGGB6QntsCbB/ayd6HIl6Hu8/dbNcrdaz84nOCR/odVCeiGTbxDO5ELL69URc2IQ+5jW1knTklrJktl0SYaJweSUaL8Pnx2mMoqQMTl4G/RZlKAx67g0z0S0JSXW/HWEQoHKBX8aB/hiiVrBN/3+8eCQ+AKnu6GUTD3d/H9j5WVeTkt2UPVDROR2mjScydtoAUYHD5169ekBqC4STE9Ogg9xAV5Vhld0FzPjhfYr5yW+fkJ8PnbRRBulRKMQaCBJcRE5G8IeGFFiNNeDpcAj5TNH5T6OKPPZt4rzf9PVRobdC60pvM+TbKN3YxTTxGzQB/va4epfIGlk7yCMLkAPu6TH0oZPt8kCdriksib68c+xQ1PsiVcIyEl3XVCRH6trVPiaGgayVkCgmz/s3WepVzEg2Qh/NcTgC2cyUwM6+LAns7nUXww1mC5wEcuAhdUGkVVkz3N5WXT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmpwOWhobWJhSmhXYUNpMnlHc2NUZVdZb0V0YmJaNGxDZ0tKdlRhV2JLdzJQ?=
 =?utf-8?B?M0QrWnVJM2RSSXU0dGFvL3I3dTBhSG5qeDllTmxkY0NLWURMVUprUWtNTTBP?=
 =?utf-8?B?QkRhOHJrN3o0cDk3OWplQ3VxUGREWGdXV3h4c2RlZU1PVXdsaUU0alRMcFpR?=
 =?utf-8?B?czUzR1R4bkljanBCUjJlNWhPWEVBODBCMi82b3NVZmFFZnJ0QWlOYUI3dG9h?=
 =?utf-8?B?cXkyclVyWWVFZ3ByZkdGcHJlVWIwODZOd05zYTFhcmJ5bVZCRG5PRXZjTXRF?=
 =?utf-8?B?cUJvdTdYUHc5MUNzV3VkWnhjS2dSbi9IVXNtRHE4MjU0UmJNMzByVjVXcjho?=
 =?utf-8?B?M2ovMmJpV25Pc2ZQOVRLbWszak1RUUl4cHVXSkQrSmFuNEMrZzMwOUlKVWZC?=
 =?utf-8?B?aDU5VlpJci90blgrR09mR2RyWnJTUkUyZmN3aFNYUWRKOW5DSzViMDFnTU10?=
 =?utf-8?B?NFNaL1NQTWhwUEMrMW44Q1NlandrQTh0L2ZDd0p0ZW5zR25pVzFCTWxnWFRG?=
 =?utf-8?B?ejdMeUczUHAwWFVxNUR2cEJZczlubkZHbVp5Ly81aDRpdERHa2VtWTFGVlUr?=
 =?utf-8?B?ZlFoU0IrNUpZUmg4YTRrendISU5qS1NXQ0loU250L3AycXlrQ1psdDlPcmhv?=
 =?utf-8?B?S01wRkdSSnlWRlZmMkRMWGVnUGFVdFBHblR5WWxVNzZzcVNiMW5mMWkvaERw?=
 =?utf-8?B?MGlTVDcyZnk3YThiSzVtWWlpY1JZZTFySGJYbjBRN2FqNWM3Q09RSEhHK0Uv?=
 =?utf-8?B?WDVKWHhFRjdoQnlleVJESDR5eWQ0dnJzb0diZjNuK2huRnBmWjBQWjZJU2Y1?=
 =?utf-8?B?UUVpaHRuWlMzRFErczZib3dab1FRalU1MmhrU291emIvM202Ly92dWJoQy9y?=
 =?utf-8?B?cEY0Q2RYa0dseGQyVHh5ODBXVUNVNDFDWjN3WHB6eUFWZ01vNDhUdVhhWjcv?=
 =?utf-8?B?cU9MdTBLcTl6VEYrdURNbmdqcVArT0FQc056N2RTNEFFRkFxdGtxWVhUa2pq?=
 =?utf-8?B?aEhicmxUcTNZRzB1dnlVdWxxaytOUThDOEtKTmpuby9kWjkrVHRqc3JQMGZ4?=
 =?utf-8?B?OUZPZVI5c3ZDRWh4ZXVyNVMvZWwxSXhhSVlseHNUSzBHM0FZK1JCREorN0xD?=
 =?utf-8?B?a2Nvb3I3ZmZldWFQSmpTWFd2UVBmMHRXalhFZjBFNHVqWnpJU0hjSHFOcHY2?=
 =?utf-8?B?VXNYelJMMWFROTZDcVlUTDc5OE4raE9PK1ZBQ3ZVNUozS1J0aTAwejN0YVV0?=
 =?utf-8?B?RzkxLytVaTBoSWE3ZzNubE9QUXNydzBsQzdER0h2L25BdFcxNDMzUW16V2t0?=
 =?utf-8?B?YXBKR2E4bzRweHdjNDlmaGxnUVk0WU9jeEtYSlFOZU9oMXFRR0hUa2YwanZv?=
 =?utf-8?B?eU8rLzNNb21zQmxiRTQ2SVRmazdOZFBFU1VjMHZBbmNaK3NEZW55RnRxRHQ1?=
 =?utf-8?B?ckt5R2dwUi9BS0ZUL3FITlVvK2JaMHhBTlp4SU5ZV29lK05yajZLWmRxRDAx?=
 =?utf-8?B?b1J3UEloeUNGZTYwR3dwbHZrN2tMMEdVY3hYYjF1VDB3UWE2QUhvS0xDSDZp?=
 =?utf-8?B?NUh5UFh5ak5SK08ya0NzaVVWMXI0Y1pkSnNtYkpCTEJ6N3BqeExTT3JuaTM5?=
 =?utf-8?B?Q1h6a0NjSzJkdkNMekN3Rk9XTXFaZkQvS0c0MGVIRXRnUjlvWlhaTWp0YlMr?=
 =?utf-8?B?RWRudUdHUXM5TzRwV3I4V3dkSTYxS0h2NnRRMU5GWVJPQmRMZWwvZFo5QWlZ?=
 =?utf-8?B?a0Foc2VsSXBaYW5ZUkl1MFhnc2lXZ0ZYb0pOdlVtKzkvV0Q5K2p4VWFTVU5D?=
 =?utf-8?B?K0VUUWEwTmdPVU4vTXJVOUdMQ0NWUzZ3MHcrSS95V0N5d2cwc3dsekpPdTZO?=
 =?utf-8?B?U1Q3blhMUmd3WUgyNExLeEtFNzU0S2hIT0J1ZTlqZDEvREpWL2ZkREZQL1ZW?=
 =?utf-8?B?UmdSY01vbWlIY05JdUJaQXNYTTBkc0ZXb3hLOFJ4eEtVREo0ZFI5RzNWWmh3?=
 =?utf-8?B?U3dlTkZyalh4ZGNJTVhYUHlYUFB6WEQxMEZKbjdxb0F5WXIyWVc5WVNMMVll?=
 =?utf-8?B?c21Za3R0TlJkZkRhb0ZQZHY5SUJVYUl3Mlp0YWRxQVZRM0o0cUs5RVlodWx2?=
 =?utf-8?B?U0xhNis3SlFuZEJ1eWlMU2lBYlJkVVFYU0xBOWtmR1VyYjd3SkJrR0Uwb2Ix?=
 =?utf-8?B?cmQwaWpYRnFnUnNEK250NXp2OHltSU5qZGtuTVBYQ1FmbTZsRnpHdGY3N3dq?=
 =?utf-8?B?RGVkbnp2ZEdQV1d5Z0dSeVQ1Qys4UituVWkxQXdQSjdKUlVKdmhHWUNFSmVq?=
 =?utf-8?B?WHJUSjRJdkRMZkErVGltQyt0eWZCd1dleW9KbHBQOXFyejhxMFlBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IVY6O0HH0N2bxFWNKmMOsnSeD0rA7rIKVjkyzSxAa9nZuWrbwCqG3YBP0Ti0ztgrPP5ZylAu310V1U9ZmFkLG7HDMJVPqV2l+lwvWZ4gsK5ufDtGgMsENYvvbPgjU1qh1MmxAIB1dtjEREW0cYhCarr065dNNuXkS3o/sDm14PWnkU4wL6Z1msKlzsbFpxTiTeN7UVPO8ZnJOtu+7XZpv0mGR/zfNk8DrNVKpptytTf08o3Vlt18XB4jrLN2daNWff2/G28uu8e0hfQNPhDw36Jk4/tLeu9plnr0NPBjzY7DPVNKbv8dujYByjWBwi4P0rPztVy+++KqGzh9G0XTfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f37840-c644-4417-8a44-08de919d715d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 16:24:13.0816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2yzrUcmAQwg1MI7w4fVbAsMmkZbrHOt21Y0+EGYTYNf7SdfYO6vRDk62fxoODpntoidZ3Z53jPcmhIFmTxojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233216-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.969];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6264539666C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBUYW50aWxv
diwgRW1pbCBTDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjMsIDIwMjYgOToyMCBBTQ0KPiBUbzog
U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiBDYzog
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7
IE5ndXllbiwNCj4gQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IExva3Rp
b25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IEtpdHN6
ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGNscmt3bGxtc0BrZXJu
ZWwub3JnOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBsaW51eC1ydC0NCj4gZGV2ZWxAbGlzdHMubGlu
dXguZGV2OyBzZ3poYW5nQGdvb2dsZS5jb207IGJvb2xsaUBnb29nbGUuY29tOw0KPiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0gg
aXdsLW5ldCB2MiAyLzNdIGlkcGY6IGltcHJvdmUgbG9ja2luZw0KPiBhcm91bmQgaWRwZl92Y194
bl9wdXNoX2ZyZWUoKQ0KPiANCj4gDQo+IA0KPiBPbiAzLzIwLzIwMjYgMTI6NDIgQU0sIFNlYmFz
dGlhbiBBbmRyemVqIFNpZXdpb3Igd3JvdGU6DQo+ID4gT24gMjAyNi0wMy0xOSAxNDoxMzozNCBb
LTA3MDBdLCBFbWlsIFRhbnRpbG92IHdyb3RlOg0KPiA+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jIHwgMiArKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+ID4+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sLmMNCj4gPj4gaW5kZXggNTgyZTBjOGU5ZGMw
Li5mYmQ1YTE1YjAxNWMgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5jDQo+ID4+IEBAIC00MDIsNyArNDAyLDkgQEAgc3Rh
dGljIHZvaWQgaWRwZl92Y194bl9wdXNoX2ZyZWUoc3RydWN0DQo+IGlkcGZfdmNfeG5fbWFuYWdl
ciAqdmN4bl9tbmdyLA0KPiA+PiAgIAkJCQkgc3RydWN0IGlkcGZfdmNfeG4gKnhuKQ0KPiA+PiAg
IHsNCj4gPj4gICAJaWRwZl92Y194bl9yZWxlYXNlX2J1ZnMoeG4pOw0KPiA+PiArCXNwaW5fbG9j
a19iaCgmdmN4bl9tbmdyLT54bl9ibV9sb2NrKTsNCj4gPj4gICAJc2V0X2JpdCh4bi0+aWR4LCB2
Y3huX21uZ3ItPmZyZWVfeG5fYm0pOw0KPiA+DQo+ID4gSWYgYWxsIG9mIHlvdXIgYml0IG1hbmlw
dWxhdGlvbnMgaGFwcGVuIHVuZGVyIHRoZSBzYW1lIGxvY2sgeW91IGNvdWxkDQo+ID4gcmVwbGFj
ZSBhdG9taWMgc2V0X2JpdCgpLyBjbGVhcl9iaXQoKSB3aXRoIHRoZWlyIG5vbi1hdG9taWMgY291
bnRlcg0KPiA+IHBhcnRzIF9fc2V0X2JpdCgpLyBfX2NsZWFyX2JpdCgpLg0KPiANCj4gV2UgaGF2
ZSB0YWtlbiBzaW1pbGFyIGFwcHJvYWNoIGluIHRoZSByZWZhY3Rvci9tb3ZlIHRvIGxpYmllOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTExMTcxMzQ5MTIuMTg1NjYtNy0N
Cj4gbGFyeXNhLnphcmVtYmFAaW50ZWwuY29tLw0KPiANCj4gVGhhbmtzLA0KPiBFbWlsDQo+IA0K
PiA+DQo+ID4gVGhlIGxvY2tsZXNzIGFsdGVybmF0aXZlIHdvdWxkIGJlIGZpbmRfZmlyc3RfYml0
KCkgKw0KPiA+IHRlc3RfYW5kX3NldF9iaXQoKSBsb29wLiBQcm9iYWJseSBhbm90aGVyIGF0b21p
YyBvcCBmb3Igc2FsdC4gVXNpbmcNCj4gPiB0aGUgX18gaXMgZnJlZSB3aXRoIHRoaXMgY2hhbmdl
Lg0KPiA+DQo+ID4+ICsJc3Bpbl91bmxvY2tfYmgoJnZjeG5fbW5nci0+eG5fYm1fbG9jayk7DQo+
ID4+ICAgfQ0KPiA+DQo+ID4gU2ViYXN0aWFuDQoNClRlc3RlZC1ieTogU2FtdWVsIFNhbGluIDxT
YW11ZWwuc2FsaW5AaW50ZWwuY29tPg0K

