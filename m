Return-Path: <stable+bounces-203353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0955CCDB36E
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 04:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B806F302B772
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 03:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1222CBF1;
	Wed, 24 Dec 2025 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJ4JxJry"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1134224240;
	Wed, 24 Dec 2025 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766545734; cv=fail; b=TNLhPvKXc2EXhQDj8BRnllO/HgLWUZlRKXoGxS92w9ICXwuHoCz3X3JxQV8tHDodDMaNiVBTk4FzsnLRvKDkUVhRGd0KFWMeppK6lTmF/2QnRWM0B9gpRnp/URWQe06jbzW7E8OxASpgpcfJyw3kKHmUKdh23L/VnbUdIrBnN74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766545734; c=relaxed/simple;
	bh=aVgOitj7JD9Yy44BzB/L/9m6OgsQGj3bo88GZgB6+18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kcbVlyfvXNy8BtPkZjg2tgluHGnMNAtRCeftHiKI93RU6nF0ZPbwE6MJ46pl4jOY1VE/zpYfMXQNs94DHjRapYFTcnbCmprNzuz9QK3AUcsP60Faaf+E7ZOuKxlJ+VDe2YNVeM25U05gKwpcygAy7J576gAGY65ZAv6zzHP/6Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJ4JxJry; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766545732; x=1798081732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aVgOitj7JD9Yy44BzB/L/9m6OgsQGj3bo88GZgB6+18=;
  b=AJ4JxJryGZfGrdl9//c95TTox6N7HXQvpO+1F7v/DjQpdSMQVL6nCUGF
   z8UOHYpq9qRteKH4BsWHlYG82kZIWLLsz11n0BemBg0EVpJT3rb4BghyW
   2RyY4iGwsidvdVPuC8wQjTRtiQBM9rFC11M8j9/NRj6ood1nZKNk/iadV
   PIP/sqJFp0TsUsbE2pvEgodOQ3ZTWrcOD5S0IyGmnBXbU1PbpvclaBRgL
   zVHDkdx6Mye4JSCJOo7ozGIBrKKtXifYDhqF6iXt4fyCIWfYJ7u7hE6Wt
   wPdz6ogKk+DR2jcPG/r88Pd9+zJSWuTltM9sc3YXnIr4uKro+HUQO1euN
   g==;
X-CSE-ConnectionGUID: UWc1UZ5ySsqR5W1axSTmsw==
X-CSE-MsgGUID: 6F0pO/A6SCSd0Px8LloDnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68285479"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="68285479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 19:08:52 -0800
X-CSE-ConnectionGUID: sHhSWMuaQUyqzfW9iYAr+Q==
X-CSE-MsgGUID: Z/ObDE7LSI2YDCQ/KNxLBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="204990082"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 19:08:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 23 Dec 2025 19:08:51 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 23 Dec 2025 19:08:51 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 23 Dec 2025 19:08:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkNMIfZPlEjsSfOBHb7adKXZlLXVuY8t8JFHmts/GnQT0IKqvhMhyFI7+3FTBP5Cj+Sw/pNCuq4pF+IEHNalsJtcegaQkQn58/gv7eqf68ttSV2LpXou+DQinup1p9X9y+69+IHB6qNbdtnsUDxgfyJTmIo9xW3HmW2DPAqETWM91lizh2jOrWggZi48mistbcx7W9SLDBYwqBOLXH2sdFYOfoobeiteMrvo82PRiN3xMh3QWH+oa8N51e8ANLNh3kOg8YSlAWDihPpZP6MGatGvRBenwSSEeUvDAsQWWANy4vkcAq3Lga7PBvfzTJuCTvDsMUOQiSyDKHiaR2EORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVgOitj7JD9Yy44BzB/L/9m6OgsQGj3bo88GZgB6+18=;
 b=LrtjVnNQxgm4hBrhEzGYgFQrT671Znk+3EG75luxdEwLTcg4rFNSdufchGOqirlATVnMpsQYlPNPKvoSwAeb5iDFuvtyzWIIGYs7fu2Mam/QXeVN8aLV6f/3crCypJkcS+8dJN1aEhecciyoZsKU+1/l3OWVeiP7gTFBUgeNq6pml9dtjONehoikhCZRW4QdDf1XkR0DV8NAmQEKNqLaynIiFOJJV492NIA63gF+7RBPzE2POJ74fK0Z2nb8bA0qOpxjroOrelg5xSPXxpg0AfygvMLLfxZV75wuShyoz4xbqDkrpX/hzVZnbyC2K/tta5NkZRVZXFmukK0pKPQiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA3PR11MB8966.namprd11.prod.outlook.com (2603:10b6:208:572::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 03:08:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 03:08:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Guo, Jinhui"
	<guojinhui.liam@bytedance.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "will@kernel.org"
	<will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Thread-Topic: [PATCH v2 2/2] iommu/vt-d: Flush dev-IOTLB only when PCIe device
 is accessible in scalable mode
Thread-Index: AQHcalLjYTc62byjOUyaz3iqPujJhLUnDxcQgAaF94CAARlNAIABfnmA
Date: Wed, 24 Dec 2025 03:08:49 +0000
Message-ID: <BN9PR11MB5276FCF5D751DE7432A32BBB8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB52763E38B4C8B59C9A9AD9E18CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251222111935.489-1-guojinhui.liam@bytedance.com>
 <aa1eda8a-4463-467a-b157-c6155882f293@linux.intel.com>
In-Reply-To: <aa1eda8a-4463-467a-b157-c6155882f293@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA3PR11MB8966:EE_
x-ms-office365-filtering-correlation-id: bd4aeda9-1e86-4af2-c654-08de4299c276
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NTBpMW5UTXFpYWl1ZXk0d1BvS2FxMG52UFNwaW95NUhhQ3MrOE1zbWR5S2lh?=
 =?utf-8?B?S2gvSDA4RldOV2dkZFJHZmNrRnhjd3FaS0pRTWhNKzVBa2hHc0I5amE2VEo1?=
 =?utf-8?B?NFJWMzlsaUlWUDdzUFZBdTJoM0RtSDkrZUtUejBlWGNzYldqNnFFZG1zcmhv?=
 =?utf-8?B?Wk1ZRFRNenFkdkxNNFJBT2pMemwxRmFrVE9PNFBFQUxQc2lSTFREd0JwNGZC?=
 =?utf-8?B?Wlg2cnR2ekwza1hrUDZSVzhIWEVnc2JNMExkZnZiNWJ0OExqV1pRRkR0czdt?=
 =?utf-8?B?ZTdzRXJNd3BPb1A4UUdtSnBIV216M29GVG1Fd1Rnbkw5aWtaSmx3WitwejRo?=
 =?utf-8?B?dU5CeFdPQXJYeWJvdmlyWmtaUVAxbklKbDVVY3RRKzQ0VG1wZ0NnSlozUGpH?=
 =?utf-8?B?R251T2NTM3E1Vk5yb3JCZXZSaHRvL2tmblMyanVRQ3UyZWVFOTQrbGtMeHl4?=
 =?utf-8?B?Q2tkZVdDaDV2cXI5QzVoS1RQVlhjeStudEtzT2hxOTE2RlQzc29ZME01K1pX?=
 =?utf-8?B?VHVhOG5xU0U3OU1mZXZhcUVzbFFzUllzQ3FRMDdCUTNvZGZsZFBWSThha1RN?=
 =?utf-8?B?bEs0YkY4bTZhaEVXY2hYRW50QU9rNzNRcDlKanFkYXJaOTY2d2RXZERJS3J5?=
 =?utf-8?B?b0kybXRBNFdiUjBGTUdreXF3REMzZnNubVRnOElSQU5MQTFGcFdXZ0JEWkFy?=
 =?utf-8?B?VjdqZDBmUWk5V25XWTN1c1dLajFiKzFtdkMxc29YMmhka2tza05NRFNPdlQv?=
 =?utf-8?B?bWdoVWF3Q0oyZXM0WkNhUEwwdU9qMlFyc0lZdWdLU1pyeldPc2FwL1dNT2Y2?=
 =?utf-8?B?bm5PY3BKQlJSRjRQS1NpaFZhMnZTUGxKbnY3YUJYUHp6Y1Rza21INjEvY3pI?=
 =?utf-8?B?TXFpMGRNays5UzNSY25keDVtQnJGVGZFOXlvWHlYZWVxS0JoaXJWKytCU3Z1?=
 =?utf-8?B?UWgvS1JWMWRyRERpN0hMd01rcm1XU2dBSGJ0YmZPN1h4L085eDI4Z1Z2UFNI?=
 =?utf-8?B?b3lsai9nY0JTUVhaMW5ud1VQZWUrREw0WjI1SXBkRjRkaTdQUUFQUXdreUVr?=
 =?utf-8?B?THA3TTNzWTV0TC9sUjNQUS9lOUVZWGlzcy9Jb1BaRVo0L2NUTW5zUUVIREI4?=
 =?utf-8?B?SENGOGdXNXZSSWFyUzlyUEhUdWJ0bCt4ZCtzSDJucUdXRnN0WHN3YXZweE5J?=
 =?utf-8?B?WnE5NGJCeG05ZWFTYmJRS3JyeVE4dTM4RWNoYVdqZVRkL3o1dlBCKzE5M2lr?=
 =?utf-8?B?cE4rTTZyUUIwMld6WnhvejBXWWxtSmNBVk5ZVXh5TjBja2FrVmlwa2VWMnhC?=
 =?utf-8?B?VVFPc2lWdHlYOElDcmlCNHZoQitYZEtyQlBra1MxOUJrVkFyN09HZ1M1RVlt?=
 =?utf-8?B?emhTZkJXWjU2aFkySkxka2kxNzdjSE5iRjVmN2xiYTIwWGJTQnhiVFJNdFk2?=
 =?utf-8?B?dGFrMmJoemV0ZGR4bmNsRTNxUWhvbHBKMTNsQ2FJWUdOMFR2ME1TWTl6azE2?=
 =?utf-8?B?VVBhYjBGd2pwUXJ4VzV2aC9haVh6T3RhQ3NQZXpVbWlxejVySlFmSXJKMUZ5?=
 =?utf-8?B?SDNVYk0wYjl4eEJLRHhYRUJUVTNuVWw3YWxrUEkvS0JkYzlNZEpWRm01cUt5?=
 =?utf-8?B?dFZncnpNMXZkWmEza2tDaVdSamg2SUNIdmhyRm85bzcwcWZwaXFodUpYR2FT?=
 =?utf-8?B?YUZBY3A5ZWF0TUNReWJQaVJnM0d0emhHNldYbXhmdlpFYlQwdmpTc1REVldy?=
 =?utf-8?B?VUFVaWwvQThDTEJnY3lxdzgwUXBlMWRmR2xCRUJmNXBPRGNEQjRzbGJ6Z1po?=
 =?utf-8?B?VjZtdnJ6R05LREcySWtwcEhqZGtUQWtQajIvMHJMeFVpV2paNG9TWUpYU2pl?=
 =?utf-8?B?dHBkV3dpb1cwSGdQYld6MEpDcXVFMjV5cWFJb3IxZ2RxSDAvcmkvZVArcDFZ?=
 =?utf-8?B?RTRSSE0wb1R1YnZZd25ncE11TGJvb2dJaUcrNXNwdFA4VzNYMlFiTkxmemRY?=
 =?utf-8?B?ZnJ5cE5UeWZsbHZKNllka3RzdHNkYTdMUkI2NnJWMGxVQkg3TkZjM3cxaFpY?=
 =?utf-8?Q?LBHcPt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmYzSy83c3JvVlZSVGRqSXkxNm9TNTA5OWVJRzBoL2c4cXhILzdzMktac3NR?=
 =?utf-8?B?UExUVVhUVE1FSXYzS2tROXAxcURkYWNTU0Q3dGllSWd3aFU5aGxVcDVzYmVQ?=
 =?utf-8?B?K2JtNU40R211VkN2T1FmQmsrRkN6UnVQR2lwRHQxeVJRVjFUTEFTV2pBNXVm?=
 =?utf-8?B?Si8rdk5lUUFVanJudVdqbVFIcVNQbTZWZGNqZitPWkppdThYSHdyTGNPTnQ1?=
 =?utf-8?B?emc3M1BKNGFMcW5BbEYwcnNDU0NFQnBvQkRhVEVabU56cTR4UlZMSTdQTTY1?=
 =?utf-8?B?KzNVMUFlQkg1Y1FzMTRPQ25NOTAyVGxacXl0UHRMOW1SdkJWUUxrZFIxMjJY?=
 =?utf-8?B?ZFpPRGh5M1lBbjlCNDlsY1RTVDErQzdxbUgyQ1RqUzhxOSt2L3VZTGpiMjl0?=
 =?utf-8?B?QjRXZHA5N1ZQVGVVcERBdDRhNVJSakZVMEUwbnlPSkNhMFpZNG5lanJUdlRs?=
 =?utf-8?B?WHdEYlRXQ2o0ZkYreVBxc2JVOHY2Z0pEUVdiTm9mMDBlZTdzdlNveDBZVWZO?=
 =?utf-8?B?SGpwZEFGb21sWkN0SjVSeis0MUpNcVd4VmpuUkZYd3kyK3JXb1lnMGg4RzVh?=
 =?utf-8?B?UHFvd1N5UnZzNGJ6WEFwV0hsSmdySzhlUGI1dzloRnNZSy8wWW9jKytzbzBX?=
 =?utf-8?B?Z0Z5MS9XaDlCMlJIa2dQV2ZQMGg3NlplSHBhaWNpOU9Xc0xwZkFRaGlHNndT?=
 =?utf-8?B?bXZhZGVXRml1WDVFbENIbEQ3Q244aFhncVJZUUxLV3FLNFBwSVZkMlJ5TkpO?=
 =?utf-8?B?OW5OcVVPOWxzNFQraFpXMHNuY01ZZHRhaS9CZ3NtTERsaXd5ZG51SWVzOGhJ?=
 =?utf-8?B?ZkpGUkdHT2cxVW9BSGoxSFVSSk9JSTlrbGdaQ3ZuSVVJSkJvdXljcDBwMlVI?=
 =?utf-8?B?YVcxLzZ4cnIwYjUzUmRGVFlOTXZ2aTRFWUt0S0c1Y3RSd25GWFRPemovNVpJ?=
 =?utf-8?B?RjB3aitDdWFrWXhveC84a1BRWnEzY3NZMW0reG9CNW1YcUJWUml6NUp4UlFa?=
 =?utf-8?B?WHZZRnpmbUxqWEIrQkRGN3BsbG5SbFZOSkJsNmlJQnpoZWRjNFdrM3NIOXc4?=
 =?utf-8?B?aW0rMGVwWm51YnRmWlA1K2p6eFozOGV6SUt1QmhTWWZqdFlpL3FEQjNSWHdL?=
 =?utf-8?B?NzlTbGtrUWJBSDF1WHBlUFc5MlUzcDQ1YnB2RjdLYWhxUGxhYi82MjRjUlBs?=
 =?utf-8?B?Tll5UTl5TDVsOFFZQnYwc0ZjSG9HclVPb3hLenN4L3F3OFVPK3FUQ0xnc01Y?=
 =?utf-8?B?eE5hdVc1U3lIbmRIZWFuWCtyMmFjSU9zVDFZcC9rOFhTdVpOTDVKMkNDNk9W?=
 =?utf-8?B?TXRjdHlKaFQ5bS94aTJWaERMbHQ2dWlETWRVSE15WlpFWEtpTTJ2a1BFc1dP?=
 =?utf-8?B?cVpERVcxTjRvRk1BWkx6eGlzQWd2Ukc0NVFKekJBWHp6eW50Uyt3TEp6NWVi?=
 =?utf-8?B?RXRKbnUzUWF6VUNxUUIrSiszWmdUUFdYWEt4Nkx6bEpzc2x4a2loem9Xc0lW?=
 =?utf-8?B?WktKUWZRMzRGUmlzSml1ajB1OUhrODlCYUtYL1J2WU5IbTlXbzhqU1Vpa1Nm?=
 =?utf-8?B?R0R6emdDV1padW5rSVZkMVpDSldvS2FnK3I3L2ozNEVaK3EwZ1FkWE9GZFY5?=
 =?utf-8?B?ai82eFFDcVk1dUo0dHBRbUNlK0hlOXRkSjZkRGpjcnNDc2d5ZFR6enFjZnh1?=
 =?utf-8?B?SzhSbUNFYWllUWgrdlk5UGwvampySVZpdDJxYlc5RUxLOE1rR3JiOHJvT0Yx?=
 =?utf-8?B?T3hXOTErVkp2Y210anNjM3JXWGVtcmx3dGdFVTRCZ2l5MFRoL0xjZUE5RVBq?=
 =?utf-8?B?UEl1dUFWenhyekVibm5KNjBqZjAvZWtMZzJtZVZDQW94VFc5OUYzRm92VXJE?=
 =?utf-8?B?NDdmcW16eXMvbVY4YmdtNGFncjNBU3k2NkJYS1puSmtSZWwzVWZtcG1zN1JN?=
 =?utf-8?B?YUtLU2ozaHhpcldDS3hQRlQ3VzN4aVBsd2lDWEJGdnE3VlZES0cvaEhuakpC?=
 =?utf-8?B?WHlNMzNTcEk5SjdTaUFJRW1peS9yTzhZRkVHckdnVDZ1Tjl5bFFrcmVqNVFr?=
 =?utf-8?B?QjJUZFBjYjczZ0hQdVVrdVIycktCSkcwc2l4Q0xwVHdTNDFISytvbldaMVJC?=
 =?utf-8?B?aWF1MHFpNGtFUmN0RUhzZ1ZyOGZvVFd3cmlib1RyMm1lcVFLOVlOMndua0xV?=
 =?utf-8?B?SGpLUm9CMlFkZjI2WGl3Mm41Mks2S3Z1VlRVWTM5NUhoQjVRMUVFeWUxZ2ti?=
 =?utf-8?B?QnlCaVZkM1dsZkhwS1QwWklTVUMzcmJXM1NTQlVTcTlUb0NOU21jcGpSbEIr?=
 =?utf-8?B?a09GbkVqR2VmK1FuVzZWUTFsRE9qdVZQOXRnREFoV1VjVFBuWWRIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4aeda9-1e86-4af2-c654-08de4299c276
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 03:08:49.2711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50tczA5r0wNkz/QfNAGFZjjRIxPGllwrUUEj/ARW+uyAHRLj48iW7ectcKq2lyDHhSupjFUXkoBC/MbndMjiig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8966
X-OriginatorOrg: intel.com

K0Jqb3JuIGZvciBndWlkYW5jZS4NCg0KcXVpY2sgY29udGV4dCAtIHByZXZpb3VzbHkgaW50ZWwt
aW9tbXUgZHJpdmVyIGZpeGVkIGEgbG9ja3VwIGlzc3VlIGluIHN1cnByaXNlDQpyZW1vdmFsLCBi
eSBjaGVja2luZyBwY2lfZGV2X2lzX2Rpc2Nvbm5lY3RlZCgpLiBCdXQgSmluaHVpIHN0aWxsIG9i
c2VydmVkIHRoZQ0KbG9ja3VwIGlzc3VlIGluIGEgc2V0dXAgd2hlcmUgbm8gaW50ZXJydXB0IGlz
IHJhaXNlZCB0byBwY2kgY29yZSB1cG9uIHN1cnByaXNlDQpyZW1vdmFsIChzbyBwY2lfZGV2X2lz
X2Rpc2Nvbm5lY3RlZCgpIGlzIGZhbHNlKSwgaGVuY2Ugc3VnZ2VzdGluZyB0byByZXBsYWNlDQp0
aGUgY2hlY2sgd2l0aCBwY2lfZGV2aWNlX2lzX3ByZXNlbnQoKSBpbnN0ZWFkLg0KDQpCam9ybiwg
aXMgaXQgYSBjb21tb24gcHJhY3RpY2UgdG8gZml4IGl0IGRpcmVjdGx5L29ubHkgaW4gZHJpdmVy
cyBvciBzaG91bGQgdGhlDQpwY2kgY29yZSBiZSBub3RpZmllZCBlLmcuIHNpbXVsYXRpbmcgYSBs
YXRlIHJlbW92YWwgZXZlbnQ/IEJ5IHNlYXJjaGluZyB0aGUNCmNvZGUgbG9va3MgaXQncyB0aGUg
Zm9ybWVyLCBidXQgYmV0dGVyIGNvbmZpcm0gd2l0aCB5b3UgYmVmb3JlIHBpY2tpbmcgdGhpcw0K
Zml4Li4uDQoNCj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4g
U2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjMsIDIwMjUgMTI6MDYgUE0NCj4gDQo+IE9uIDEyLzIy
LzI1IDE5OjE5LCBKaW5odWkgR3VvIHdyb3RlOg0KPiA+IE9uIFRodSwgRGVjIDE4LCAyMDI1IDA4
OjA0OjIwQU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4gRnJvbTogSmluaHVpIEd1
bzxndW9qaW5odWkubGlhbUBieXRlZGFuY2UuY29tPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIERl
Y2VtYmVyIDExLCAyMDI1IDEyOjAwIFBNDQo+ID4+Pg0KPiA+Pj4gQ29tbWl0IDRmYzgyY2Q5MDdh
YyAoImlvbW11L3Z0LWQ6IERvbid0IGlzc3VlIEFUUyBJbnZhbGlkYXRpb24NCj4gPj4+IHJlcXVl
c3Qgd2hlbiBkZXZpY2UgaXMgZGlzY29ubmVjdGVkIikgcmVsaWVzIG9uDQo+ID4+PiBwY2lfZGV2
X2lzX2Rpc2Nvbm5lY3RlZCgpIHRvIHNraXAgQVRTIGludmFsaWRhdGlvbiBmb3INCj4gPj4+IHNh
ZmVseS1yZW1vdmVkIGRldmljZXMsIGJ1dCBpdCBkb2VzIG5vdCBjb3ZlciBsaW5rLWRvd24gY2F1
c2VkDQo+ID4+PiBieSBmYXVsdHMsIHdoaWNoIGNhbiBzdGlsbCBoYXJkLWxvY2sgdGhlIHN5c3Rl
bS4NCj4gPj4gQWNjb3JkaW5nIHRvIHRoZSBjb21taXQgbXNnIGl0IGFjdHVhbGx5IHRyaWVzIHRv
IGZpeCB0aGUgaGFyZCBsb2NrdXANCj4gPj4gd2l0aCBzdXJwcmlzZSByZW1vdmFsLiBGb3Igc2Fm
ZSByZW1vdmFsIHRoZSBkZXZpY2UgaXMgbm90IHJlbW92ZWQNCj4gPj4gYmVmb3JlIGludmFsaWRh
dGlvbiBpcyBkb25lOg0KPiA+Pg0KPiA+PiAiDQo+ID4+ICAgICAgRm9yIHNhZmUgcmVtb3ZhbCwg
ZGV2aWNlIHdvdWxkbid0IGJlIHJlbW92ZWQgdW50aWwgdGhlIHdob2xlIHNvZnR3YXJlDQo+ID4+
ICAgICAgaGFuZGxpbmcgcHJvY2VzcyBpcyBkb25lLCBpdCB3b3VsZG4ndCB0cmlnZ2VyIHRoZSBo
YXJkIGxvY2sgdXAgaXNzdWUNCj4gPj4gICAgICBjYXVzZWQgYnkgdG9vIGxvbmcgQVRTIEludmFs
aWRhdGlvbiB0aW1lb3V0IHdhaXQuDQo+ID4+ICINCj4gPj4NCj4gPj4gQ2FuIHlvdSBoZWxwIGFy
dGljdWxhdGUgdGhlIHByb2JsZW0gZXNwZWNpYWxseSBhYm91dCB0aGUgcGFydA0KPiA+PiAnbGlu
ay1kb3duIGNhdXNlZCBieSBmYXVsdHMiPyBXaGF0IGFyZSB0aG9zZSBmYXVsdHM/IEhvdyBhcmUN
Cj4gPj4gdGhleSBkaWZmZXJlbnQgZnJvbSB0aGUgc2FpZCBzdXJwcmlzZSByZW1vdmFsIGluIHRo
ZSBjb21taXQNCj4gPj4gbXNnIHRvIG5vdCBzZXQgcGNpX2Rldl9pc19kaXNjb25uZWN0ZWQoKT8N
Cj4gPj4NCj4gPiBIaSwga2V2aW4sIHNvcnJ5IGZvciB0aGUgZGVsYXllZCByZXBseS4NCj4gPg0K
PiA+IEEgbm9ybWFsIG9yIHN1cnByaXNlIHJlbW92YWwgb2YgYSBQQ0llIGRldmljZSBvbiBhIGhv
dC1wbHVnIHBvcnQgbm9ybWFsbHkNCj4gPiB0cmlnZ2VycyBhbiBpbnRlcnJ1cHQgZnJvbSB0aGUg
UENJZSBzd2l0Y2guDQo+ID4NCj4gPiBXZSBoYXZlLCBob3dldmVyLCBvYnNlcnZlZCBjYXNlcyB3
aGVyZSBubyBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkIHdoZW4NCj4gdGhlDQo+ID4gZGV2aWNlIHN1
ZGRlbmx5IGxvc2VzIGl0cyBsaW5rOyB0aGUgYmVoYXZpb3VyIGlzIGlkZW50aWNhbCB0byBzZXR0
aW5nIHRoZQ0KPiA+IExpbmsgRGlzYWJsZSBiaXQgaW4gdGhlIHN3aXRjaOKAmXMgTGluayBDb250
cm9sIHJlZ2lzdGVyIChvZmZzZXQgMTBoKS4gRXhhY3RseQ0KPiA+IHdoYXQgZ29lcyB3cm9uZyBp
biB0aGUgTFRTU00gYmV0d2VlbiB0aGUgUENJZSBzd2l0Y2ggYW5kIHRoZSBlbmRwb2ludA0KPiBy
ZW1haW5zDQo+ID4gdW5rbm93bi4NCj4gDQo+IEluIHRoaXMgc2NlbmFyaW8sIHRoZSBoYXJkd2Fy
ZSBoYXMgZWZmZWN0aXZlbHkgdmFuaXNoZWQsIHlldCB0aGUgZGV2aWNlDQo+IGRyaXZlciByZW1h
aW5zIGJvdW5kIGFuZCB0aGUgSU9NTVUgcmVzb3VyY2VzIGhhdmVuJ3QgYmVlbiByZWxlYXNlZC4g
SeKAmW0NCj4ganVzdCBjdXJpb3VzIGlmIHRoaXMgc3RhbGUgc3RhdGUgY291bGQgdHJpZ2dlciBp
c3N1ZXMgaW4gb3RoZXIgcGxhY2VzDQo+IGJlZm9yZSB0aGUga2VybmVsIGZ1bGx5IHJlYWxpemVz
IHRoZSBkZXZpY2UgaXMgZ29uZT8gSeKAmW0gbm90IG9iamVjdGluZw0KPiB0byB0aGUgZml4LiBJ
J20ganVzdCBpbnRlcmVzdGVkIGluIHdoZXRoZXIgdGhpcyAnem9tYmllJyBzdGF0ZSBjcmVhdGVz
DQo+IHJpc2tzIGVsc2V3aGVyZS4NCj4gDQo=

