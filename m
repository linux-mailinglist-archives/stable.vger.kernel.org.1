Return-Path: <stable+bounces-132194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACDFA85131
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 03:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75EF465E12
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5127604D;
	Fri, 11 Apr 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE4F/ajp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04E26FDBC;
	Fri, 11 Apr 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334576; cv=fail; b=UCnpffi5wA4QgwwnZX9QmjGps9tF9ZRrs/4vXlTLRRj9Zu70A75Da7fpd9ydz9RMPPrZ/Cf4O/8JR6z3fsC269ADfEduZ4nJ4+E3aC2xg5QLW4zC1s2jcU4TlnOfgfGwBCcO9rz90IWrxBDXpn6R7Mz0lTUAId1fUde0xE6LC6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334576; c=relaxed/simple;
	bh=TW5Nm9WnrJvwMCIm9KA8O5seowWbyARNGCeuunRy2Zk=;
	h=Subject:From:To:CC:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYbqEe8jsFIewZxBLfMGWQ+Duobcj6zKk1zW7HFge2WIFguaTZ+XWgBcCO4IkA5OT5pe5jBXOqH/C/OjkeKs3dngHwaFSC6WoM2Aw5/k29+2olgwVpeDag1F2AdbaenwjrP/nVNylnFqR029nVoQb5sC2fjENmX7HUtdQDMMMdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE4F/ajp; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744334575; x=1775870575;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TW5Nm9WnrJvwMCIm9KA8O5seowWbyARNGCeuunRy2Zk=;
  b=TE4F/ajpzR2RMXJtsyuJ+J+8l9Jz3SPPL+KsR7USFVSYbddGSHao3v+t
   F1EFu/sNt3UpOuFFYFJaJ2ChOAdDiEpsp/lELwfVg8KPwXJQbQxSpTsvq
   1ZqUkjCgzHBIZ3IupAKLzmi1kwpq1eDtcHh/oIgiBc2/JL/8xNwXBJZuw
   bWWwa4aLMHHQjD5Oz/It4hH1g/xk68Q3u4P3N42pHPR56EDLEM14+szq8
   uK30Sj2+8FfPPP8Y9qMNylQ5KFARk1H1o1dl8vwL+PCd1vFokWBFKqanV
   6GPNhKa5I2wl7ctxX9H2XVgqv6DplJlMBKPA7UFh3MYg23D40To2tfl6w
   A==;
X-CSE-ConnectionGUID: MsXbtSt3QPuYvc4gs/DuwA==
X-CSE-MsgGUID: eDL5BBTJTFG2O+rHlnDaiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45969856"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45969856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 18:22:54 -0700
X-CSE-ConnectionGUID: Llu7zXczQlKqxKad6ers2Q==
X-CSE-MsgGUID: zsgM02esRXKiRYmz4EfDNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133920566"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 18:22:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 18:22:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 18:22:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 18:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWwzMRsKBm4LDAOSQdVER7w+yPl6e+eJ5ZharAfWmB2bEACbP/+qAuONpzBqZBQD1AxxBD4P/EGus6ik/uT06XHKLjm8q2DkqmNfypT5/tb+0RKWRPTxoDiF9w2DZ6ipDvjkQL9azsetftSTA2jzdmgPTTVUNUALZcfqrCF5eWlXaraSrh+KIERovUF8WgDzoNDeoC3vAw9HJiCGWOzXOrrBt19xrlq11TfJDGj7e2WDEfjUV56U1Gf7Ue4IYiolQNHV5beSEx0QzNh4s4Yh7pT8SRxlg2SexhnsXh+AygNldT6jm/flNbmhgrzUgQY6Mq27zmFhdHr0KwRMunskzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=homHo1kaXhyc9T3pZgu4YWxIGQPiJQHhOI6hJ0VZVug=;
 b=KoKlVRWIfIE9o2v2mliEtw3IumpM8DCibGzVyc2Gfl+IcholQNjQP3uV+hvqWmFN0tesk03O8Be3bekNYbgP4z4877imaijxBZ+Qmi3jfd1ofRw5kvbGJ81hGtTk1rLfTuHNHOTzkXHggHPxYRyPEqF6fZjpJ7L87dtCabJzta70qpvK4PnD9mmsOmV4wRcv+mDGnUh0tRVeMZxP+p1Wei3Rp/+bq4p9Alf+hIVhlJdVGYCJt+66MDK2mkqc9y0yJw7bN0yIsloJvEUzgQRlGifI2y9ChsoMI6hXm2HGFJJ7VBoIUwarnYg1kB1ZbvTite/3R/0ryHOUIhZeN8wTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 01:22:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:22:41 +0000
Subject: [PATCH v2 3/3] x86/devmem: Restrict /dev/mem access for potentially
 unaccepted memory by default
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Vishal Annapurve
	<vannapurve@google.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Nikolay Borisov
	<nik.borisov@suse.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Thu, 10 Apr 2025 18:22:38 -0700
Message-ID: <174433455868.924142.4040854723344197780.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
References: <174433453526.924142.15494575917593543330.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee862ba-8ccc-4003-7606-08dd78975aa4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDVpRmFYeU13MnRRaTVGOWZXSEhXRGdxV1Myb0Q4UXc4UGRENWpibExnSnBy?=
 =?utf-8?B?RHYyZlVoNEtnL2hJV3k5OVFlQnh3V2F2VUdLaVJHNjRtdHl1cTA5VFo0bEs4?=
 =?utf-8?B?SkFDVTZaYVVkWHJyWHdqbHpLOWQ5TlZ4bUxqR1U5VlNqWDJFenZxUy9yK1Bj?=
 =?utf-8?B?b2NnaGxud1J3bXE0cW5GaGxkSFY4bG53enZ1WS82MzRXemwxUGNzbU9lcnNQ?=
 =?utf-8?B?a2I5bFdGWGIvYUl0RHlKV21zcW9IcmdtemJ3Y3RGemxVOEdyajBoVHg2UTR1?=
 =?utf-8?B?WGU0QjVBQUx1eXlCcWdCZC9PbFc0MThKQjd0WnB5TERMT1ZwNys0ajE0V1pz?=
 =?utf-8?B?NVFOcDhBd3dxNjM5eFVOM0xvT3oweTRBMklOUGQ1MUNMdlVjNjdwa05raDMx?=
 =?utf-8?B?c1dZemVUanF6TE9SQTZHcGwzMmQ0Wi9JcmExMWY1YnN6WUNLOGpIZjloZGJM?=
 =?utf-8?B?UEVjdGxhems5TkZ6YW9Md2txMlh0Q3VUWEdXVStjaWpNRHBqT3dMYk1rK2la?=
 =?utf-8?B?VDliWFA2YnpEMldnMzREYXlPcW55NDdlN2FxSWtSeXY1UmVOQ0JHM3krN2Iz?=
 =?utf-8?B?aTAwbzgwWS94MEhONXAvUFB5TTJWVG44NlVrRHZrYjVpcXJmTGFXemlKS1N3?=
 =?utf-8?B?b3p2N2dSVXVRZTFXaW9kQkpGc0Y4cjhYY2pXNWRhMnIzMVQvRXlWK3JXSjVU?=
 =?utf-8?B?MVhaRlFBdUx3NU1uWmt5K1BkRkE4bGxXbDlRQ0dBYm4wcW9FODgzbFNFdmhz?=
 =?utf-8?B?Y2owNVppYkpaYW1KNlk4cCt6Ui9QZVFPVFpBVGFpUTJkbE9KTzgwSlN5MmI2?=
 =?utf-8?B?cm43S0ZsK0JGaVpCelVtbERGNXAzYllYMjBwMm41RWdCSS9PdHk1NE5Uc0hZ?=
 =?utf-8?B?WXZDazVwSnBacVM0blRTRU1lNmNJU2hoU2xrVnRjWjZBNXhQYWxzdzdjWWhw?=
 =?utf-8?B?Z0xVMDdYdlMrWTBvdm5yOERQYlc1QVJIQ2o4QXhoM05RNGhPK0prQjZkRFgy?=
 =?utf-8?B?dWtrZ016cTE5TzZleExGTDI4QXR5SXdZNHhSem80N0ZCU3djZWNmak54eity?=
 =?utf-8?B?MTExSlMwQlVsWFd5TXREQ3QwNFVTek5YeTg3ZDgwbTBtZktZNHRXM3RYVGpS?=
 =?utf-8?B?MElaZkZ1OHhKb2oxdVU2S29NR2pLS0JtajBoaTI5WFdiTldRSzBidTFmazlU?=
 =?utf-8?B?c2UrK1Jxb1V6bWlMTEpMcElkMyt3c3FveFRYQ1dEdThRdkkvZW5KQ1ZpdWUr?=
 =?utf-8?B?N3I0Ylc0ditvbVh2Q1RSamgyTk5LbFpHU1pUcW9qakRINlo2T1lWbEs5ZHFJ?=
 =?utf-8?B?Y2NoYkFia0c3enRnTnl1bmdEaFBQcXBrbmVvR0xXMTR0Nno1elNNa1FRUDhX?=
 =?utf-8?B?MTN1VTlTckN4YVg0NENTNVpGamFXajlmc2N0UkZkUHZwSytDUkhKZnpncTNF?=
 =?utf-8?B?alVsNitOVUpQbW5pRmhsNmp3aWpMc2E2WGJyblBnQmtyeHFUUlpHT0pGb1Fz?=
 =?utf-8?B?clJIeDhEOGM2SDRFTFNGM3RYQWdHS2JSTllNYzZuNkxSNDdsRjBkMWhkalZs?=
 =?utf-8?B?RG4rV25XMjJ2ZEFRanhiTUV5KzNIUWpjcmozMWdobE92QUJTUHMvU2dNTXRE?=
 =?utf-8?B?TEZIdTJGeXFsL1RMUGVuTStjQktkM0g2TU1qL2F0T1RqTlNRdjJMNHQzUVJw?=
 =?utf-8?B?Y2ZKYlg0ZXZJSnpDMlo2aW4rUFN5N1pVbFNyeENlSVRWaXB2Nys4bkd3TEZT?=
 =?utf-8?B?Q2cvQm5oT0dJQVBQK00vL2NOZzZ2azJYRDBoTU01OVROL0pya3VNVlRHbzN4?=
 =?utf-8?B?VktqZjdNb0hsUzZHR3pGcXNzQWNOMU5NaFdLZVU5alVMd3hvaWNUY0RpRGhv?=
 =?utf-8?B?SHBhZ0tLa0tKT0hXQjRrdDJHRytRaWVlRGJMbit3WlJncHdkUEtYemlxZTZW?=
 =?utf-8?Q?51tuT01Hw80=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFiVVdyZlJiZDAvRFhrNGhQT3RLaFp1dVdFcUZyaVFoRFZWNlg5bFQwL01H?=
 =?utf-8?B?aXZ1NXU1R2RFMEJoVGlIays5WGNTT0M4MkdqeEYrbE1SQXdSL2JhQmw3WWhz?=
 =?utf-8?B?ay9EZkpoWEhTaXk1OXY5cGFEbXlqd0NSOWVzUWRRUllLNDh0MU9QQWNTZHk2?=
 =?utf-8?B?eCsycDRxQ2N3VllHM1daWDgwRyt6ek5ETDI4VUhiYjkxeGxDcmVBR3dMUTMy?=
 =?utf-8?B?VytRN0swaXFWK2Q0eFJzcVdiME5LSnNhNXJVTS9EVzVtbSt4cGdKNmFSd2k4?=
 =?utf-8?B?aXBmV2FkQ3R2dnhuWUV1QS92WEJsTzRSejlmWUM4U05hckY2WWp5a2IxQTNu?=
 =?utf-8?B?cVlGNmRKWXk0VmFVMDNFbldqejNwNzVCWW1HU0pwajgvaWlHdTQ5ZUxnMWVq?=
 =?utf-8?B?WXZzUEJlYXVJQjkvQncvTmJmdjhNbTFTWlJSMGErQWRyc0lEeFFHODV2bzVJ?=
 =?utf-8?B?TTJjcklzcHE2YjB5M3BXTjJXQTB1VnlIUXIybGRGTmh6OFNrOTBCWUhnVVN5?=
 =?utf-8?B?MW50NlhhdXhpaEdlYU83a0hBK2V2YTFuVUhKbGQ2eGFGc3ZMcmtZWDIxVW5z?=
 =?utf-8?B?Y0crRzBpLytJYWxXb0JySzhVU1FsaEJ1VU81Z3hQWTRsVDZIc3c3anNaRDFH?=
 =?utf-8?B?OVl5UndNZGZpdDJnNll1bVIyNmw5eWhWcDltTXBSL0xuRjVsV1JxQkJITDNX?=
 =?utf-8?B?aEdzancyblBuYytUcjZzd2NnV25yQ0twajZjWm5HMFVJc0dDSjdoUFliUkhx?=
 =?utf-8?B?WDNKRFBvb0dEaUtYZ0ZMVmpvK1lyNng1K3RqdW5YeFdtemUrVXpyNC9GZmpW?=
 =?utf-8?B?dk9YVWNEUEdMQUVIVzdWdC9oOE5xNVBIQU4vVDhUekI5d3lGVHViUXp6SEVS?=
 =?utf-8?B?ZlZrUWdPQlRJdHg4TGtJb2g3ZDAzdkhnL1hZWFJnbFhMTlNkSTBVekJDOVUy?=
 =?utf-8?B?bEJlNjJ6VXNyMUtiekxzSTNZT2FNckkvME9hWEhvT0gwS3dCNXJJYi9tOG40?=
 =?utf-8?B?SWFxTTV0QXgxWHpXTDVNYmFpc1RNcXJyOENzdk9pcEgxd3l3YS9pS3V5SFV6?=
 =?utf-8?B?RVM4NUxsenUzRGtZSWkxeU5sQnFjV0R4d3ZaMm9WSWJrWEtWcThSMUpDT25t?=
 =?utf-8?B?TEpoanBDUmZlWisxckhwejZkUW8vdFpMaDI0bzhIZHYrN05sbUpiNkg4Wm0y?=
 =?utf-8?B?ekJzM0tPbjdoRmRmczc3K3B6bnN6ZzM5cGlCa0twVFFIYzlYdDRVQjdyVk80?=
 =?utf-8?B?aGlmMGhpeGY4SWM2TGhZRW9PS1g1NVg1QnJuZy9TeXZUcUxlZnluRVdNbEYy?=
 =?utf-8?B?UU5uV0JaRDZpamNSNzlueFhjZGgyc1ZOT05adWJoU1hjY1gxeEJDSEJqR0V1?=
 =?utf-8?B?KzBtaFJmek9qcGVUR1UxV2g1RUVieFU2QU5vS2RBNHhQazBYeDRibTlFWDlP?=
 =?utf-8?B?amUwTWliRENvNlEzT2JCVGNlR3FLeklGbVVTYUlrd1Y5R2VKQ3REbVlDTlZk?=
 =?utf-8?B?QVQ0WjhxOGVJRHpzYzIySzQwWE91T3dqTDZtencrazVRZzRLRFNTSmVIZW1o?=
 =?utf-8?B?czdWYmV6MjJZNXJETm84SDBJMXFkOUp1NlBkYUp0eDlCMUxBM3AvZ0ZXNitU?=
 =?utf-8?B?N0UrLytYUHkxald0TUhkLytzR1VQTERuOXdhRFdUY3FneDRMdUhxSS8zSGdJ?=
 =?utf-8?B?Yi9SdTExS1Y0cUdCSVRoby9qb2dLSGRQdlB0N014YW1sVGQxVTVIWXgrSnB3?=
 =?utf-8?B?ZEVwWGNMZlJMa1JMajZnUjhnc01zaUcwY1doK2dzMzZDcFBocnp4eUJ2V1ZU?=
 =?utf-8?B?dVVYaXlGTEFYWjlpcytNSTJGSVAzV1V5SUw0bnYzTTRQQjRuSHVvV083T0xS?=
 =?utf-8?B?dGJXQWFoMVBKSjU4cG1ZOHhXMUovMmVXT2dtUzFWWEZRL2laMjRuZlBjUWNm?=
 =?utf-8?B?YXgvRm43TitTcG5yVHA3alhmTkhxS1R1eTMxZ2RsQjJuSituM2JxTng5Ynk1?=
 =?utf-8?B?N1YvMVJ1NDZHNGZ3UFhBeGwrb3JJUmpMZzk5QVZ0NEY0TUtObUFxWDZ3cWRj?=
 =?utf-8?B?TWIrdEhkS3BSK1BwandwdVBsdzY3aXJ0UzgzdC9rRTVNYjRLekwzMDRpNFZG?=
 =?utf-8?B?SUZESDhlNW1GLzI4bVh0Y0xBS2JsbW5pbWtUR3lhZkZCR1BjNWFCallIOGUw?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee862ba-8ccc-4003-7606-08dd78975aa4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:22:41.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D91+rKw1j7HzqK3GT7MKHx9ahNclSQ+LWguEdCNP+2PGlbld05PTMvOLEEEZWn8lUzhMmKMkb8UWiw9ghFOzv7UFRCpydRh1QqMVdZniYQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com

Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
address space) via /dev/mem results in an SEPT violation.

The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
unencrypted mapping where the kernel had established an encrypted
mapping previously.

An initial attempt to fix this revealed that TDX and SEV-SNP have
different expectations about which and when address ranges can be mapped
via /dev/mem.

Rather than develop a precise set of allowed /dev/mem capable TVM
address ranges, teach devmem_is_allowed() to always restrict access to
the BIOS data space. This means return 0s for read(), drop write(), and
-EPERM mmap(). This can still be later relaxed as specific needs arise,
but in the meantime, close off this source of mismatched
IORES_MAP_ENCRYPTED expectations.

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/Kconfig                |    2 ++
 arch/x86/include/asm/x86_init.h |    2 ++
 arch/x86/kernel/x86_init.c      |    6 ++++++
 arch/x86/mm/init.c              |   23 +++++++++++++++++------
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..12a1b5acd55b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -891,6 +891,7 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	depends on EFI_STUB
 	depends on PARAVIRT
+	depends on STRICT_DEVMEM
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
@@ -1510,6 +1511,7 @@ config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	depends on EFI_STUB
+	depends on STRICT_DEVMEM
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 213cf5379a5a..0ae436b34b88 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -305,6 +305,7 @@ struct x86_hyper_runtime {
  * 				semantics.
  * @realmode_reserve:		reserve memory for realmode trampoline
  * @realmode_init:		initialize realmode trampoline
+ * @devmem_is_allowed		restrict /dev/mem and PCI sysfs resource access
  * @hyper:			x86 hypervisor specific runtime callbacks
  */
 struct x86_platform_ops {
@@ -323,6 +324,7 @@ struct x86_platform_ops {
 	void (*set_legacy_features)(void);
 	void (*realmode_reserve)(void);
 	void (*realmode_init)(void);
+	bool (*devmem_is_allowed)(unsigned long pfn);
 	struct x86_hyper_runtime hyper;
 	struct x86_guest guest;
 };
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 0a2bbd674a6d..346301375bd4 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -143,6 +143,11 @@ static void enc_kexec_begin_noop(void) {}
 static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
+static bool platform_devmem_is_allowed(unsigned long pfn)
+{
+	return !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+}
+
 struct x86_platform_ops x86_platform __ro_after_init = {
 	.calibrate_cpu			= native_calibrate_cpu_early,
 	.calibrate_tsc			= native_calibrate_tsc,
@@ -156,6 +161,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 	.restore_sched_clock_state	= tsc_restore_sched_clock_state,
 	.realmode_reserve		= reserve_real_mode,
 	.realmode_init			= init_real_mode,
+	.devmem_is_allowed		= platform_devmem_is_allowed,
 	.hyper.pin_vcpu			= x86_op_int_noop,
 	.hyper.is_private_mmio		= is_private_mmio_noop,
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bfa444a7dbb0..df5435c8dbea 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -861,18 +861,23 @@ void __init poking_init(void)
  * area traditionally contains BIOS code and data regions used by X, dosemu,
  * and similar apps. Since they map the entire memory range, the whole range
  * must be allowed (for mapping), but any areas that would otherwise be
- * disallowed are flagged as being "zero filled" instead of rejected.
+ * disallowed are flagged as being "zero filled" instead of rejected, for
+ * read()/write().
+ *
  * Access has to be given to non-kernel-ram areas as well, these contain the
  * PCI mmio resources as well as potential bios/acpi data regions.
  */
 int devmem_is_allowed(unsigned long pagenr)
 {
+	bool platform_allowed = x86_platform.devmem_is_allowed(pagenr);
+
 	if (region_intersects(PFN_PHYS(pagenr), PAGE_SIZE,
 				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
 			!= REGION_DISJOINT) {
 		/*
-		 * For disallowed memory regions in the low 1MB range,
-		 * request that the page be shown as all zeros.
+		 * For disallowed memory regions in the low 1MB range, request
+		 * that the page be shown as all zeros for read()/write(), fail
+		 * mmap()
 		 */
 		if (pagenr < 256)
 			return 2;
@@ -885,14 +890,20 @@ int devmem_is_allowed(unsigned long pagenr)
 	 * restricted resource under CONFIG_STRICT_DEVMEM.
 	 */
 	if (iomem_is_exclusive(pagenr << PAGE_SHIFT)) {
-		/* Low 1MB bypasses iomem restrictions. */
-		if (pagenr < 256)
+		/*
+		 * Low 1MB bypasses iomem restrictions unless the platform says
+		 * the physical address is not suitable for direct access.
+		 */
+		if (pagenr < 256) {
+			if (!platform_allowed)
+				return 2;
 			return 1;
+		}
 
 		return 0;
 	}
 
-	return 1;
+	return platform_allowed;
 }
 
 void free_init_pages(const char *what, unsigned long begin, unsigned long end)


