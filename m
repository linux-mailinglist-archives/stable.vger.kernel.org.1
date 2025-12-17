Return-Path: <stable+bounces-202903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C4CC9949
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 22:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4EC4301B2E2
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4C2ED853;
	Wed, 17 Dec 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/qVW0La"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851501DDA18
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006511; cv=fail; b=X0003fFAKRJXxLpGslV3HxvEBbw+kzi1QWHOCVSLxyaE8ylfYAsDfNDzDjubId4dPDqV1Pdf83C3kBRjh/K8xCPKnG3nrivDpfkW8jfm06yc39ll8dmOxV9D0VdqZ0LFqe6xfRXcYVEopZxA6pyguNFGPzRZ2x0KIcWmg2dHBEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006511; c=relaxed/simple;
	bh=S4pSEHSIWLOUAhVTJ8ZDaed1FgWkohXSA/8cM589he8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k5lAML65bkR1/ijo1b/CwZWrdXHOYU+x3A9aMt7cUokVS0lKyxLohIDroIZZ+DJgp28NvaRKIgunOOUR+qXX0CO4e9/Rp63enDY9b2jZN2rNOubZaYGLiDBn/q9ZXWgaTbQ4oXyoxP9kVAzUBUpnP9B5u+HO9FL9x45T2aBo3sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/qVW0La; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766006510; x=1797542510;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=S4pSEHSIWLOUAhVTJ8ZDaed1FgWkohXSA/8cM589he8=;
  b=Y/qVW0LaHD6Im+DIxNxpV+GMdhx9VXyLt7UXoCsl5qE1EvdvsOs6fHEz
   sc9dhkyyAp0AYdbBIZ8ZaVA4jkcFQZLJF0GINc4RYdyJ1s90xk1xHOjMW
   cMfoXIXFr9T7OckhK/P6RGFRNsnA03W5OefeGGscfg4FrKUj72Zg3B1p6
   aTGnlQdVqHpIDQOvhht0Z15m/WTmrmXXrGaqRJ0Ut2HVTLZYJgwRDcudm
   5be7Bg/qKGoHSeJQkO0PcfrFFddsnV+9n2DFj5nmlm3n736dCdbcudfRG
   akjPuj2FkUlPX2RMJsW4Z6OFk2Ckx8CW7WwM6EoVYxmrZlsBW7SJ1ldGa
   w==;
X-CSE-ConnectionGUID: fkMLFlFpSDewpkLDV/DMww==
X-CSE-MsgGUID: cbOnQFs+RZutNOh06k7o3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="90614389"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="90614389"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 13:21:45 -0800
X-CSE-ConnectionGUID: T3JjCJLiTueZpMNvpcNBeQ==
X-CSE-MsgGUID: 1i/liPP3Q4qFoVPfYR6BmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198016472"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 13:21:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 13:21:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 13:21:40 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 13:21:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiihw/nejrXfWMdLK4dqH0cKaeaTsXEEMkjrP0hW5Us4Jzq+9CfUt6dCQvCGmYgZQnTmSfrkEUpltA7NpcRq1TR1jVFljM3c70ZOlq5kFKB69oLlZR2hYLP5N2alxx9XvjmRlWFJetc+JpBpk9gUTqEpHz61VQR3U3hwh7mQnOdiM+7l9v8ERbzWaiovg5d85bNLwFW3J6QCx8/m7ICIGdUI4ORPih3UiaQX4BCWtvxapmrZCpZ2FXnTc0a3yN8fCYF1sPn0QDGfXc/rEsTMoT6S6+15ZCg7EF/lieN/Kh6mO13oQEyazLO30N+8IkvJkDFdpTl9tOrpwTDlDnycdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M4DApssH3eWCISWHqx88LgnL0leCPl/5Ajxy1tSyHA=;
 b=trlO8XQNHOxkgGcbV6fIqtkNa3ktaoYVa5x7Edd0nohfMPKsWYUdsmjNCVyL9Hh55IbrqjUET8uac4A3NP9CUJLQFSFnBpJTQDblHwZNDLDoxVLSUYB+RXDVGB53wyvaz5YNgtWyBnrB8xzSwi12VKbaeBrqaH0B7bapp7ACWZZ8toSU7SFJda8cuh6P1lHj6O7HEwCuZePxCblUzlEKugx2cyTSCPLCmZlcjX2KYgFahr6G9bukB9LDVZMQvBdcSV1qqq4eOM9FOUt96TgkVDJVwmZyVCfzuSUKZJKGrDuhGmTkDXTuyaBjAmo1sNmR43mWV4Ag92XdAFTQCNqHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ1PR11MB6106.namprd11.prod.outlook.com (2603:10b6:a03:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 21:21:38 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 21:21:38 +0000
Date: Wed, 17 Dec 2025 13:21:35 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Drop preempt-fences when destroying imported
 dma-bufs.
Message-ID: <aUMe31rH8u9ws2UD@lstrano-desk.jf.intel.com>
References: <20251217093441.5073-1-thomas.hellstrom@linux.intel.com>
 <aUMQE1wZd4k7j2Kw@lstrano-desk.jf.intel.com>
 <eaf85643f5296ea93c68201d748d64e8463887ed.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaf85643f5296ea93c68201d748d64e8463887ed.camel@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ1PR11MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: f23a906c-ee36-4764-a9c8-08de3db24388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2ErV0Rhb3duaUJ6eGNyTGdOS1RXM3gyd1JROWpGMkFYRlJiSmZCbnZ2UWVi?=
 =?utf-8?B?K2RhQlNlZEt3RTFUeS9rN3BPNzJSRVF2cGhPUkpjSXFFdGtadlA0bXVIdEJa?=
 =?utf-8?B?allTeEtpTDVxTXovakN5ZG42aGhPV2dZM25jK2RyR0VPNzJhcTdXbFJOZ2Fv?=
 =?utf-8?B?LzErVlNMYlp0bk5oTkQ3WGh5bzFkN1VmNWVLQVR2S2FtUUFsQzVlajVScTJs?=
 =?utf-8?B?SlhOd2FBdFZjZmVNMjVheVJWT1J3bHFNNVpHV2hFelVRbC9VZWFlLzBjNGVs?=
 =?utf-8?B?TzJ5d21TYVROWnZVV3FOQURSeFMvR1pDNm9PcWpnUVdENjJKNkNSZE9xYWc5?=
 =?utf-8?B?WDNoWW1QdjJYK3lZcUtIeGpYckw2Z0V0UktOajZCcHlqWHZqYkdIM0hvckVt?=
 =?utf-8?B?YzkwaHZpK0oybXJDeEVvc1I3TDdMWklTaWU5V0NZL2I1dCtXNjhVd2txSi8r?=
 =?utf-8?B?dW5rNDNEajlhcW1SWEMxSC9wSzlIM250Sm8yNHk5T2pIYUhGUk5odGdzNUtq?=
 =?utf-8?B?OURQTytlVUtMZEtIazFtWlVkYXZZNGovUlJ6cDdiVU5IMkVnL3BWVm5Kc1lN?=
 =?utf-8?B?djJmNk5pMzJEVVhIWmpnWHA3RUt4bXZBdW9tcXBLNzZwMkx2VnV5VE5TN0V0?=
 =?utf-8?B?VHJIMlB1OWpMRkxMUk5QSTgzak5sbnEyR3l3dmRQWVpYNmQ1MmVPdFlOM3A5?=
 =?utf-8?B?Zm9lMGFoUXBaVXVHMkNOdEZrclRqbTRxZUJ1b1EwcFZBdWFvR05pL3gvUUJp?=
 =?utf-8?B?cEdtY2tmU0MxeE0ybUx2NHNPcDBhV0lGdFViRFlKV0dxSjM5RjFwV3d2bHVy?=
 =?utf-8?B?eHlkMWtiM0RVWDREWkZ5SkNuSE1BUW9CMTNRSzUxV0lUT1N2N1ZJOUp3T0xT?=
 =?utf-8?B?TmxGb2dZNnBMZlhONE5lbng4U1dSY0cyaEp6SE9VSWZEMjc4Q1hXb2dDbzJB?=
 =?utf-8?B?ZTRxbXdlOGhnampSZkQ0bit5ZUJMZnRrakY3SUtxd3NyOXltVTVCVUlTS0Ny?=
 =?utf-8?B?QUpxK05WdHI2Tis0a1QyT0tpeTcwOEsrcWxWcjl6b3ZKVmNGSFZWazVlVVlD?=
 =?utf-8?B?VDRZbHJPamdVT2lIN2NGWnlXZ2pXNzQ4OGxlZ1BGb25RdzFocmdLWGlRcEcr?=
 =?utf-8?B?LzBZR1RnTnRwMkV4K3RuRkpLVFJrc2hwUXhVVFB6ekNjcmEvMjNSRDNhNkg4?=
 =?utf-8?B?YWNZYjZBemhiNi9KTTRQVlJOaHBLb0MrSjd0ZTRBTitibnRXQm5xc2ZpaGVF?=
 =?utf-8?B?VTRMZi9mNXdXTkc4MHRFRUtaMjNwVGtVRldHcWdTZnJ4cGZQaVVUT0docS9B?=
 =?utf-8?B?a2RUYmpoS2Rid0hQYTJBMmM2ak91anpVMVVJRXNnaFJFRnJxaitreFFmUjIx?=
 =?utf-8?B?elZja2xtSnJuRW5haHRWamt4b0NIWjBCVVlkSVVKNkNMM0FwTjhlM0FVM09h?=
 =?utf-8?B?TzRPWmM3ZjJhWXJ6OGYzTzMyanZYYzduaUE4Z1g2Wk5iYVI4Z2l5MDJvQk1h?=
 =?utf-8?B?VVl0WmNCKzE0RUo1U1B4bmx6d3JNZ25oUkthU1V0UXRPMHFKWmxSTFplU1lC?=
 =?utf-8?B?K24yakEvRFcxNzAwZ3VPVWdQOGpJemVtNHU2UDJQUXQxUmZEaXVRUVloL3Bu?=
 =?utf-8?B?ZWh0Rkt6RkpXMVo0QzV6Y3p2MWxGdWllZjNOSVZsSG5OUnUydi9WdnRxQ0Zy?=
 =?utf-8?B?V0NKSVpBSTNlUEx6R0Y1YXBJS3dVWnU1T0szK2tjVmU5T0RJZzljT0hrN0FX?=
 =?utf-8?B?cXlJd3oxSHI5YUpYa1hWNFBOSjduM3k5ZmZ4WHB6THIxbVlEUFFVcWxLWXN6?=
 =?utf-8?B?TkhZZU9LdGRQaE8zSkVhK25DYXVhdnprRi9LTGpORC9yUC9zbzB6NktIdkhS?=
 =?utf-8?B?WHB3RFRzdEhlbzVKa0NFR3lWSjdlTC9iM2xadHowVmFZc1BCY0pzVGpUeE5B?=
 =?utf-8?Q?xxW7rYoTko3gNiE43naaizsb0K7faAEP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZElNY2ZvUEtTS3h5WUthVUFrQzFudW4zRUxrTGt1NDNKZWprMTl3ZFZtOEkv?=
 =?utf-8?B?dTBPYXdnZC9lN0ZqLzZ5eHhaSVo5RmZXOVhVZkQza0d1TnFkZ3BUOS9QNk05?=
 =?utf-8?B?WFV5dWg1RUwyVkxLVlZRZVV1S3BYY2wwVmx0dDB6N05xV1BhY3VaTVNPU284?=
 =?utf-8?B?L0pMTlBSRWdhUXVLd0tVeDE2YXZNb3ZHa1RXWjhaKzZmVjVrczZIWGV5KzR2?=
 =?utf-8?B?YmRSQW5nL2N1RGEwSWgxTjlRSE1LZzZQSkVyUmthendheFpubFVhU0JKL05Q?=
 =?utf-8?B?UTE2Y1o2cm5pWlFyZUtiNlF1V1hxRC9LQkFNcmoyUGxSSlFkRVp1V0pNdlpS?=
 =?utf-8?B?ZVpyVEZTQzM3d2xMRXdUVlhKdG90c2RiY0NXaXA0L3ZSd0JPLzJseEpYNUJp?=
 =?utf-8?B?eTEybFE4OUtybE9uTllHMERNQURRZnp5cFFtUUFod2x1Y010eGpnSUZJdlcz?=
 =?utf-8?B?OHRML2psaGJDckFKZ3A4bGFNSzZ3Mi9WNndHeHZaQUk5RjV1aWJiZ3lUbkFM?=
 =?utf-8?B?YkZnV3N3NzlWWEc5RENpRDMzVVZncDFaVlVJdEw1SWVpdWJ2UjJZU094dzRo?=
 =?utf-8?B?cUVFaFRyak9oc01FQ0laaU9qSnQ1TXJNRFpGSTlRUC9aaVBYZ0RDUTN4Y1dR?=
 =?utf-8?B?YmtyM01qL1dtclVZSlRXaWRDNVIyK2wzd2hha1dwNnNRaDM5UmJtdHM0THhL?=
 =?utf-8?B?OFkxc0d4bElDRFVDSDgyNEhvc0JCbnNiVVVVREhmNnNFbEZrdzZWc0h6RHhW?=
 =?utf-8?B?cDFVeDZuS1FGSC8wbXVZelFBdUFKWXplRUEzOFJMK3NSUHgrRU90ZGpicmEr?=
 =?utf-8?B?WUdLV012Uk5iYlM1UklQYWduNzFENXBYWk1nMjVoWWJxR3J4UjZBdkhJTnVm?=
 =?utf-8?B?dEpROGZqS2h3UktsSHB3R2hTQkJ1akJQVFR1UnRqT0Y0dENMN24zdlA5bE1L?=
 =?utf-8?B?cnlRWXVFYTdVWXoweWpUejd4SlNlVjAyS2JxUTFSdGpOMTZpVTNNS08wS3I1?=
 =?utf-8?B?UG02WFJkUHZUNUxCQ2NxQitsR3RLcmtHNEw1a1ZqYmJoKzVJaFYvK25ZUFUw?=
 =?utf-8?B?WU9qL2MrV2FmZmhEK3VjNTVBY2VUOTExNk9rQkt2RWZYZkoxcXNraGdVNFZm?=
 =?utf-8?B?QWJ6YnhqOFBUS3V3Q2dZQzV1Nmw0eEhPbWliK1F3eVhWekdVbzdDTnQ3dnRl?=
 =?utf-8?B?L2dveXZTSnVGY1JvRkpZSG5VL1BleDhVVjhDVE4rVjd2dW9pcjZ4R0I0bnZJ?=
 =?utf-8?B?dml4b3M2NDJGNTFFYjY5WEJTanJZY0ZvQTV0L1F0TWZIaEhPbzBLWjRUZlJU?=
 =?utf-8?B?elNTdnRLNFBJTmRQTW1Zc2VFTVAxSCtTWTI4VERuQk9STGUzS0RwYVFEN3Ra?=
 =?utf-8?B?RHNaZ3pvT093ZlI1Y0xMVEg3TjVGUTFMT1I2clV4aCtjUUZqWHBsNjluRk9t?=
 =?utf-8?B?a245VnphcUUrNW9yRTVzTVpBdDVDbkZUT2hXRUQ5WlVwNWhSR2pIcGx4V1px?=
 =?utf-8?B?RTFhemJ3aTU2T21mSndYRFRYQVR4UkI4K0s5T0tRVEJic1VQbkdsZW1YZmp5?=
 =?utf-8?B?WllOV1BsbFVtQWJtSnpKMm5yTXRlRk9CNjFub0d5cE9wQUdGRXZkeThMQnZB?=
 =?utf-8?B?ZnZDNFI4dlZrUGJLcEZJRWI3THA0MEM3bWdKenVlZGFMVUE4Sjh2cW9jd0RO?=
 =?utf-8?B?K1A4T0w1WlV5U1IrZ2c4MnBNa2N5OHJnanViMVNDZEMyZ0RieEdqa1dSdWxE?=
 =?utf-8?B?NXdJc25kQ2VFNUFJTythWWpXM1orT3lpeWlKTnpvQ3l2bjZra2FzNDZDSjRJ?=
 =?utf-8?B?d3NNZGJpbmJWY2FzWkZHVGlIdko1d2dpVER0SDArTHN5OVNKUGRCa0pvbVA5?=
 =?utf-8?B?b0ovaDI0OU5IckllMWJHcEpyNlI4ZSs5N0NlWGZmSy96UUFmR0hrMHU5dE83?=
 =?utf-8?B?WU9ENEZXNmNyZTlhMWJlbm9uK2xlVEx0aXRHbG9zYzVjNVZzY05RenFIWHE4?=
 =?utf-8?B?TVVHNlZUa0ZBNm1RbUdLNDVucUdXUE96OGtCZWkvdjB2QUE5R0RnRFZHNEF2?=
 =?utf-8?B?UitLdHBEcW83SzlRbW42RUZyZTNIMGdrNkVhM3dlcFNIM1EwMmZyRDZhUnF4?=
 =?utf-8?B?NFZyVEdHbHplV3NHUXhWMi9NRVBZUWVMMnp6Z2tHd1hVYkJ3eDVGdzJiSFF4?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f23a906c-ee36-4764-a9c8-08de3db24388
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:21:38.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfs+BzsS+X6SHVqkNKREm7PMo/k8vrHMau5E7VMWo7+sQUr3WY6jg0cuG4XFF/lQXOEIa0IeTMM+7ft+sPLolQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6106
X-OriginatorOrg: intel.com

On Wed, Dec 17, 2025 at 09:51:38PM +0100, Thomas Hellström wrote:
> On Wed, 2025-12-17 at 12:18 -0800, Matthew Brost wrote:
> > On Wed, Dec 17, 2025 at 10:34:41AM +0100, Thomas Hellström wrote:
> > > When imported dma-bufs are destroyed, TTM is not fully
> > > individualizing the dma-resv, but it *is* copying the fences that
> > > need to be waited for before declaring idle. So in the case where
> > > the bo->resv != bo->_resv we can still drop the preempt-fences, but
> > > make sure we do that on bo->_resv which contains the fence-pointer
> > > copy.
> > > 
> > > In the case where the copying fails, bo->_resv will typically not
> > > contain any fences pointers at all, so there will be nothing to
> > > drop. In that case, TTM would have ensured all fences that would
> > > have been copied are signaled, including any remaining preempt
> > > fences.
> > > 
> > 
> > Is this enough, though? There seems to be some incongruence in TTM
> > regarding resv vs. _resv handling, which still looks problematic.
> > 
> > For example:
> > 
> > - ttm_bo_flush_all_fences operates on '_resv', which seems correct.
> 
> Yes, correct.
> 
> > 
> > - ttm_bo_delayed_delete waits on 'resv', which doesn’t seem right or
> > at 
> >   least I’m reasoning that preempt fences will get triggered there
> > too.
> 
> No it waits for _resv, but then locks resv (the shared lock) to be able
> to correctly release the attachments. So this appears correct to me.
> 

It does. Sorry I looking at 6.14 Ubuntu backport branch. It is wrong
there, but drm-tip looks correct.
 
> > 
> > - the test in ttm_bo_release for dma-resv being idle uses 'resv',
> > which
> >   also doesn't look right.
> 
> 		if (!dma_resv_test_signaled(&bo->base._resv,
> 					    DMA_RESV_USAGE_BOOKKEEP)
> ||
> 		    (want_init_on_free() && (bo->ttm != NULL)) ||
> 		    bo->type == ttm_bo_type_sg ||
> 		    !dma_resv_trylock(bo->base.resv)) {
> 
> Again, waiting for _resv but trylocking resv, which is the correct
> approach for sg bo's afaict.

Again same above, 6.14 Ubuntu backport branch has this wrong.

So again agree drm-tip looks correct.

> 
> > 
> > I suppose I can test this out since I have a solid test case and
> > report
> > back.
> 

Look like I'll need to pull in some TTM fixes in the 6.14 backport
branch to test this too. Sorry for the noise.

Matt

> Please do.
> Thanks,
> Thomas
> 
> 
> > 
> > Matt
> > 
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > > GPUs")
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_bo.c | 15 ++++-----------
> > >  1 file changed, 4 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > > b/drivers/gpu/drm/xe/xe_bo.c
> > > index 6280e6a013ff..8b6474cd3eaf 100644
> > > --- a/drivers/gpu/drm/xe/xe_bo.c
> > > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > > @@ -1526,7 +1526,7 @@ static bool
> > > xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
> > >  	 * always succeed here, as long as we hold the lru lock.
> > >  	 */
> > >  	spin_lock(&ttm_bo->bdev->lru_lock);
> > > -	locked = dma_resv_trylock(ttm_bo->base.resv);
> > > +	locked = dma_resv_trylock(&ttm_bo->base._resv);
> > >  	spin_unlock(&ttm_bo->bdev->lru_lock);
> > >  	xe_assert(xe, locked);
> > >  
> > > @@ -1546,13 +1546,6 @@ static void xe_ttm_bo_release_notify(struct
> > > ttm_buffer_object *ttm_bo)
> > >  	bo = ttm_to_xe_bo(ttm_bo);
> > >  	xe_assert(xe_bo_device(bo), !(bo->created &&
> > > kref_read(&ttm_bo->base.refcount)));
> > >  
> > > -	/*
> > > -	 * Corner case where TTM fails to allocate memory and this
> > > BOs resv
> > > -	 * still points the VMs resv
> > > -	 */
> > > -	if (ttm_bo->base.resv != &ttm_bo->base._resv)
> > > -		return;
> > > -
> > >  	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
> > >  		return;
> > >  
> > > @@ -1562,14 +1555,14 @@ static void xe_ttm_bo_release_notify(struct
> > > ttm_buffer_object *ttm_bo)
> > >  	 * TODO: Don't do this for external bos once we scrub them
> > > after
> > >  	 * unbind.
> > >  	 */
> > > -	dma_resv_for_each_fence(&cursor, ttm_bo->base.resv,
> > > +	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
> > >  				DMA_RESV_USAGE_BOOKKEEP, fence) {
> > >  		if (xe_fence_is_xe_preempt(fence) &&
> > >  		    !dma_fence_is_signaled(fence)) {
> > >  			if (!replacement)
> > >  				replacement =
> > > dma_fence_get_stub();
> > >  
> > > -			dma_resv_replace_fences(ttm_bo->base.resv,
> > > +			dma_resv_replace_fences(&ttm_bo-
> > > >base._resv,
> > >  						fence->context,
> > >  						replacement,
> > >  						DMA_RESV_USAGE_BOO
> > > KKEEP);
> > > @@ -1577,7 +1570,7 @@ static void xe_ttm_bo_release_notify(struct
> > > ttm_buffer_object *ttm_bo)
> > >  	}
> > >  	dma_fence_put(replacement);
> > >  
> > > -	dma_resv_unlock(ttm_bo->base.resv);
> > > +	dma_resv_unlock(&ttm_bo->base._resv);
> > >  }
> > >  
> > >  static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object
> > > *ttm_bo)
> > > -- 
> > > 2.51.1
> > > 
> 

