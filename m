Return-Path: <stable+bounces-232589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE3lNWZFzGm+RgYAu9opvQ
	(envelope-from <stable+bounces-232589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC73724AB
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E98A3012BF4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD74534AE;
	Tue, 31 Mar 2026 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AW7uz40a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A063A383B;
	Tue, 31 Mar 2026 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994784; cv=fail; b=CehZX6Lip+wjtyr7q9BuynyUsVhQFQ9bfPT3BWBzZCN4F5FPJdvjBC0cVDqQObo6OaNbFT4RtcN4Nw808tN0a+dBtyWTeKCFxiGXC/76Rb/VkUG4WY6bCutJUUkXav9cb3oThgXdv7uiPyFcES/iuGQlwX2hZxlpU+MU1KWNzTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994784; c=relaxed/simple;
	bh=o9MOk64WMhv7lkGD8H83BajJ3qPFKUMbIxsLazfbCz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmM88CjklZXQYa2yv1yvslIlYnvHZJDumiAz4YUzxfOtsjJ47Nvz1VZgFYNsf0+F2irnLx5aNp+DYNiibjw+OyKvQVvVWw9kTK70Kn/L8wyvFIczykLNebMIZjWyGGMFglUCWlWVxvkrnIa8L1OBDD9FjsMurigm/fEb0OQWQwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AW7uz40a; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774994783; x=1806530783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o9MOk64WMhv7lkGD8H83BajJ3qPFKUMbIxsLazfbCz8=;
  b=AW7uz40a4xOf6N7FgK/LXsMN9p0UsSaCWfbg/ndWoHY5MB6W2iyPNJDv
   i7sCVgKopadbFz4H22/VwpRAizcN2PGD6kpzzLN3gx2ewfjauHycsWqM+
   4xUy1jIf14P1Vmil0+FLBNk1igx3AFPQXczxKjVZdOU9E8/ROU1Oaj0nZ
   aZgU7Nf5N6zxuCHONP2nM6qGx9qResRNRlxgeI9/9fdvlf7JE/MTGVO6y
   eYhgsoH2AGDiXMVDNHx6l5IMKniqFxzZtTrsnB7X+kHDo6ikCCSewETL4
   PcYMQqK/mIyw2EuaTUakeABihJfOsDx0bEziCtsGm3z9PZWxH2LcFdZo5
   A==;
X-CSE-ConnectionGUID: biJjMoF7Q+yhHe8wQZQuaA==
X-CSE-MsgGUID: 3IpDQaoNTcK4TvjQPIhM+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75985803"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75985803"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:06:23 -0700
X-CSE-ConnectionGUID: Nd4t8yXOSNa4rEMxH8H36w==
X-CSE-MsgGUID: VGBQtnJnQqGlq8nvDwPpPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230559544"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 15:06:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:06:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 15:06:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 15:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFmVSxkmSueKnlRGPT8N3eFSWlyNU96zFu4vxrr28j4yPA/SVVAo7RsVYyFdraOEL0cFzDWFmlgutVJYA8/B483fEs8+VWxD0gIstaJLro0kfTEAY3nOGDMjKV1QlDKNbPk4va0anp3mtuWrH65AzDe8NJzhmR/hWsRx6t2Yesqnmmz/OF3MRkoJh/KiMViK1ThW2UV0mJg7z/9ym81wIsDMhS94ncjxVkvoqnQUgHUkir4y9X49XFnrHX9LFLK5h5Mpcmx9wi9hxNdN68Wm9RXw01wyjCm8O0eeo5EK7fTQmm5tlnkCe8jl8zfNlT+4E5Ay+zLzCaYWIgLtMz6/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MOk64WMhv7lkGD8H83BajJ3qPFKUMbIxsLazfbCz8=;
 b=c/BIgT36lnCZfYskrcR8a2mwQ+POaPVAzsDWotC1JjdMzJ9WQeqtxnKBS4qyNSny7WkHIo/zmEfXKlSKfEEkBwT2gA85FJPRVZrJ2DWU6Zj1hrMvferykiKLH57YpHEEhB9Nlg3At2Ay2WMrma3NBHtFLYH25S6Sngmzlu1Ed+ftWelgJIbpbdqjr6X2l5yz1SfUPfCfpJAwEXMjuMS0/C7NUjvGLnCms9lCwDCkJKRRQgr5FNInd9oO9IkkvSvWpxbkQMzSzmR9b/EPcBDY2dJx5VlS3Cppu9owhGHVvyVKoHDaE7uqY2NcqPva+WJB+ikDP1N+Imelrq3IIfexlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 22:06:13 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 22:06:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kas@kernel.org" <kas@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tsyrulnikov.borys@gmail.com"
	<tsyrulnikov.borys@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 1/2] x86/tdx: Fix off-by-one in port I/O handling
Thread-Topic: [PATCH 1/2] x86/tdx: Fix off-by-one in port I/O handling
Thread-Index: AQHcwQHL9xozelkPyUK+d7xp24mnj7XJMyaA
Date: Tue, 31 Mar 2026 22:06:13 +0000
Message-ID: <7b3396cf42daede77150dc96789c318bcee7ef54.camel@intel.com>
References: <20260331112430.71425-1-kas@kernel.org>
	 <20260331112430.71425-2-kas@kernel.org>
In-Reply-To: <20260331112430.71425-2-kas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA0PR11MB4765:EE_
x-ms-office365-filtering-correlation-id: 888d020b-00e8-4a4f-02a5-08de8f71b956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ezuLWhsvhgM+f9JRwFwnLFhHhIgoKYlY0uLaAUsMyFZuIHiTrG+tTyWiaEzDhf/qOekD1K1duDKzXV5zPOaXHduEFzpLAgZCsCIsS/u23yTNGLdjM8/Vmq8jsx4q8blr6Uh7kmKey2bZRhqv/S478DF7rlAO0pIBD1qtyTT0p7btUsZ5Ov+GQRPCFBiX1WpDyVpi5mQrLqCiGr1ddzjwQXVxV9b8LSScTzU3ULXAkqiuCgmFQl7ZTV9vINe2uT9ghKA+H2HOdBLxrHAOaj+nPyv/DiaS0JeIjUfuFCmKSZReq91kUGDILEOm8S6qlQDNEC+mLPgLajJxm1EBvHWUeCCPjFRxnKtK3bzY8+PFfWB0q4AYer8H8BisL00LW+6X9iI5kQDD8yQ18eDvsmKdq+JibZ+yQAf08KkmhWZOrasV17FPOmnkVcgfEtl65XD5aDIM/s8xA7y1F4diVTXmNi3G+FtuaAzkSh0dfCSIgmRRYDW4hqoQxB/Of/98Y66be8FdSycJ4qmBO9N9M3gVKg84dmpkwXIJDPYTupC79WF0sjqt37vVBO44njzwYj+0XUO4oSyNoHlUoKXLVA3M6gFhbZmOcYgiyGcseXK9wMaJ7nSWA9YT6o1rd+2aLk0JMigbzhZTL3xt3dpBoV7nN0u9Pt0X63vzTDIbFrQX+pvZ5VaG0WOh7WEN6gtKODd2OUNAsmNnMwGoMc88O4Mga+FfCjkkvrB2GqUfBU4KL6xKuss/9lf3IF3OD0aO9lD+aqrkOsaBkRZ0wmMzQVyW3t7JqIYRasTZnQQ6ErzgWnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk5RRm56TVpKQjNBZ2xWcW81RzdlTW9EY25SUXRLTmlZbnk0dWhNRnpsRkZW?=
 =?utf-8?B?TStXYnp1UGpNejg2aytjSE01aTZNQ3JOQnhvZklaaFBBVHBJTXc2T2JZemVu?=
 =?utf-8?B?Q1I0SE5ncnRXTVBjcFp2WnZMU3drbzZRSTNaMExKU0JFbi9wWWxDcFJTUkdO?=
 =?utf-8?B?OTlDS0l5SFJZVDN1N1hMcjJ3blpqNzAzbTVjUUxickwrM3JSNGRFQnBKb0w4?=
 =?utf-8?B?Q0JwaUlBWnUwZVV2Zy9QbjFSNEM1bVJRbVYycjI4Qm11Z05ON0xnSS96MVhC?=
 =?utf-8?B?V2s0bzhLOHIrenRqRzZZTUhMc3FHTStJUDFieFBNck9WSDZyTzlxZnlsd2JX?=
 =?utf-8?B?VUFNS2xBaVdXRi9qajFpZ0JBWWxURnIvc3RPSUNJUnVsS0lVMVZwSGczNVlT?=
 =?utf-8?B?UElpQTVqUnhUdndPeE1pUWZKRkJrNjkveThpRDVDWitmemhGNUlPVFZ5M3Z0?=
 =?utf-8?B?Z3grM3czL0kwUjF1R3ZhK2hzRUpienNUenNDdmNZV2tETW1Oa3JDYjZNYVl5?=
 =?utf-8?B?Z294bTNsSXlKanJlK0tOUm8zb1BMVFY1eE1JS3gvcGRXeXI1WWNUbGVlSmpG?=
 =?utf-8?B?QnFMSlhOK3lhNGJuVGpWczV6OGNEMHdIRzZ2UWd1eTdrSU4xbXo5Y1k1RFZm?=
 =?utf-8?B?U1VFMkdTUmNVdUFraU1FdTZTSk8ralhDcThteGVoOGt1MU5DdzZucENyblRi?=
 =?utf-8?B?djdreTdkelRSeFZiNHZEVml1VWZ5ZEQ4YXljbklYYnYrU2FmenMzNWsvcXh4?=
 =?utf-8?B?ODF0ZEZOVnNpaVg1M1BFMFY0dWQvZlRPSzUyS3NEU1FYbDdUR2loanBGUEw0?=
 =?utf-8?B?UzdiY0dDd21TYlFDcTlpeFdCVnZobVFXVzk5RDZjYWxvZEp4Q1B0WFFLZW9z?=
 =?utf-8?B?UXdLUlNVV2Y1KzRwMEVFOFkxbSt5YlR0ZnJTMXRvNnBwN3M3b0ZrWVdNdWY3?=
 =?utf-8?B?bTNNcHR0SFNxbDFGcGk0ZFN5aWs3YUZVdW55eVJRS01PRWh2UzVQbFo5S1Ny?=
 =?utf-8?B?RDhCeTB6NkdxVjVhOW5YVk1lUi9tKzJ3bnFOSnlPRjQ1a3plVnFHSXk0VWU0?=
 =?utf-8?B?U1ExNHdhdloxYVhiRThuN3FtdXhrSktoWU9QbzRraVZOSFdqa0x6WDdmcVho?=
 =?utf-8?B?QVhzTlBqdE53WWphVFI2ZG5wU25MRlRDT2VHUVJhdm1IVXJNWCtGKy9jOXpF?=
 =?utf-8?B?UUIrOWZYMXNqaHk4SVBmWUxLbWhRNHNsUnltbzBHY0FUaGFtbFBRVk1NTER1?=
 =?utf-8?B?aDFHeUVCa1NkbkpQQkQzdUZ3cGNYZzhhMVpVb1NTT3BmdCtYTmpPekxmWWln?=
 =?utf-8?B?cEloak1kUkF2OW0zeFByQ29RS3VtaHg4Vm1vaG1JVXByNkJiV3I1dDJBV3Ux?=
 =?utf-8?B?Ui94c3dmM0s4Rnl6TDdpRzkzTWpubkVsNHZuQmRyaVdVc0wvTkpJYnliWU0y?=
 =?utf-8?B?TWtxcFc1OWd3WDd0QUNJRlFzQUpHd01vTlJNaXFWMHFkMS9pQ1hKQnp5V2Vm?=
 =?utf-8?B?S1FTaTR0YWFaNWM2Y0FqcnVNazBIaTVMa3RIRFFDY3Y2WTZDZjgwNjlVTndo?=
 =?utf-8?B?bVRJSlpwYUFWRElreDBzV3VBNURHSDRsaGxVNnFJamtGb21KYi9BbGlLNEpP?=
 =?utf-8?B?ZWlDN0YvQlpkcEVUVkdKVHYrNzFHb2FiaEVrODlyYTB3YUR4RVpSNVByQjMy?=
 =?utf-8?B?dnh5V2tQUFd2dFdIUTluU3RrZUJUMENRUDJOUXRDczRJMzBldVhEQk1IMWdG?=
 =?utf-8?B?MVhhK3d4VVNpM3lOYytDeEkyM2pmOFpQazZXMkhQbmx0Zlo5UlZZbEdVZUwy?=
 =?utf-8?B?ckdVYTZZK3d4czJRMTA5Y0FRQUcySzVydGR0SWh5Mmh4Y1JJeVZoVGF5akEx?=
 =?utf-8?B?ZnZ0TWM0RE5OL25OYXZITWo1NzlXUC9HSkkyZ0xnRnNBRzVxd0VkK28wNzRy?=
 =?utf-8?B?MUdjUm14U1lRKzFrMTNBTmlycHlxQURIbkF6cnZMWUdIdVNBM09CdmExVnht?=
 =?utf-8?B?VWlTanNONmlGNk5WZmhDYnQxLzIzTGZGc0dGdm9xaXhSTkxrZk9obEVoUGV0?=
 =?utf-8?B?VE9QRjVsMzFjU3o5bEF4T3dsbE5DVnI4NkhSd3gvaW05dUFRcTBMd2xRTVlQ?=
 =?utf-8?B?YkpBbVllM3kxVE9DVXU5K3c4R0gwUlJ6bmI3MEJidDJlMzkvTlZGNSt1YVQz?=
 =?utf-8?B?ZzBod3NUSFNYTzR5S2NOYjdXSjlLNHJHcGJkR3BGR0lqLzlOaGViNlBFNW1B?=
 =?utf-8?B?UGpBdTVmZEZIL0tmektYVWw5Uy9YRVJTYkVvbml0T1E3WmFJRUFuOFg3dzBQ?=
 =?utf-8?B?N3FVc1AvaUdscFM0dVY4QlNxVkdxTytQOFpmK1cyRGFWODBEWW8zUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D7DF2D88809C4DBEE0F874C1BE88A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bg3OGLuzGT4Z4HLP5cFqeDTd/LDkkbfDcJQ8KDiwvLx/3Ik0ylqL+lxooDrduY7Ccc2wvLeZVGDkYIc/rsk7RzYR5adMGJF06rbJOLvS9cUGfCOsT50wIMFs6dnPynCmS7RKSS8P4mMoJl3tB1ZlR0aVfYpbAV+wdeIBK25z9RTlynVSmkc9rNfoJA9RonsqsDlDBayg1eoEnHzI1J1UqbybkyK8qTr4Ijr8/78lYNxZ5cUUKJYqFj8k0Jq+op0K0CQuwvIo5fHLwN+4ytULvpsjf2LLOBbcvy3jeGPGWlGBvKWGYNuagGNkS+3nY6bXUZaP+by7O1mKyQA3ycrtZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888d020b-00e8-4a4f-02a5-08de8f71b956
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 22:06:13.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fgFmgr2Y3A9mNQFyjbz229h/C4kcBFscr9plM+JZOTxHMiZci348x/1YljqvSFl0N04cMsmt9pBA/QeQ0T3yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232589-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,zytor.com,linux.intel.com,vger.kernel.org,gmail.com,lists.linux.dev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4FAC73724AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEyOjI0ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IHdyb3RlOg0KPiBoYW5kbGVfaW4oKSBhbmQgaGFuZGxlX291dCgpIGluIGFyY2gveDg2L2NvY28v
dGR4L3RkeC5jIHVzZToNCj4gDQo+ICAgICB1NjQgbWFzayA9IEdFTk1BU0soQklUU19QRVJfQllU
RSAqIHNpemUsIDApOw0KPiANCj4gR0VOTUFTSyhoLCBsKSBpbmNsdWRlcyBiaXQgaC4gRm9yIHNp
emU9MSAoSU5CKSwgdGhpcyBwcm9kdWNlcw0KPiBHRU5NQVNLKDgsIDApID0gMHgxRkYgKDkgYml0
cykgaW5zdGVhZCBvZiBHRU5NQVNLKDcsIDApID0gMHhGRiAoOA0KPiBiaXRzKS4gVGhlIG1hc2sg
aXMgb25lIGJpdCB0b28gd2lkZSBmb3IgYWxsIEkvTyBzaXplcy4NCj4gDQo+IEZpeCB0aGUgbWFz
ayBjYWxjdWxhdGlvbi4NCj4gDQo+IEZpeGVzOiAwMzE0OTk0ODgzMmEgKCJ4ODYvdGR4OiBQb3J0
IEkvTzogQWRkIHJ1bnRpbWUgaHlwZXJjYWxscyIpDQo+IFJlcG9ydGVkLWJ5OiBCb3J5cyBUc3ly
dWxuaWtvdiA8dHN5cnVsbmlrb3YuYm9yeXNAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBL
aXJ5bCBTaHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4NCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNv
bT4NCg==

