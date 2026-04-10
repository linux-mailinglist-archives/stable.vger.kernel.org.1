Return-Path: <stable+bounces-235559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN0FGnxu2GkhdQgAu9opvQ
	(envelope-from <stable+bounces-235559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 05:29:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C878F3D1D12
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 05:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AE2D3012BCA
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11130FC1A;
	Fri, 10 Apr 2026 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOdzzL1s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CE27456;
	Fri, 10 Apr 2026 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791737; cv=fail; b=SPH89fLQnPmcYXbGLTbqfnYbp5RtLzVw2mQtwqLqhvyxeTf/6QQfOxp2abd33SvGDj2ZaDafUbE5y0YMIpN+R/td8B831gPCRkr7OJTLzUU5aDIiq8tpim0QFDtpPKrJRHyD/SGjzYuO1LlYlCpK4gI5EILKwKopjNjBI2DIAfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791737; c=relaxed/simple;
	bh=4Pdh4Q53xWIzajSs+ct2qQUIISuH7wf6gF0Almfq760=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7q0fJoS9xHzegmGfsKTdnWwPKYqeHpCyk0RlFypLqaCN5jW4jauwu/7uqk1Rvp0H5ZwEM16bO4q1TXn910F3treWZTiuMFQwtTXla7Bh3zN32DgSj0wvF8MbTqQspsL800qFUMlou8l0Qw16P/Qh63nREBC07avrtEQZuR338c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOdzzL1s; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775791735; x=1807327735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Pdh4Q53xWIzajSs+ct2qQUIISuH7wf6gF0Almfq760=;
  b=cOdzzL1sBQNK/nfCiMWgDHsm09g4/BDhqySznYyRlhKf/rIzadWqlrlU
   LrQLAY9mZ2B+0RfO1aNBOGqWnatQtvMtsW+LjF7Bwpjw8csU+Wi1BaVlX
   ncL2AJBD/VqYGu8JgAoMhH7WNHklHnpjTJ5MIuLlJKNTU+sI2TQDprpzy
   bE+b/W47vMWnR7UXRpgIoWAX/vf4FUsyqfCeQ/EuRNojH8anGsQ/1eGYB
   pi9mD5NKYT+l+Ap9jQkZ3ASZHdrBVQDJj6PUZz99lzVkcLq3+lzEz83MD
   3q17lnfuPbNS1YUmxTboogvv54j88A5Tit8YwKWyZQBcWXMa9ZLtH/K8s
   w==;
X-CSE-ConnectionGUID: X0xwpsqKRzKEACJkpusgBA==
X-CSE-MsgGUID: 6gH3wK5pSKyFt4QfU+ImrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="99438158"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="99438158"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:28:55 -0700
X-CSE-ConnectionGUID: 3tjOQ360Qa6z2C+ytSUq9Q==
X-CSE-MsgGUID: hZFZf7efRT+uN6ot++gO1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="222468569"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:28:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 20:28:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 20:28:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 20:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BL1KyWNSKXQggx11v4y5UpGW9Ne3lgPpPJzonPq0IkoqbrgRa06lAhUccQfWbYqKyf0bC+fqwJBM30YwwNzkKMh6VXvpjb0iXU91R/dTY+bFqUqiWb481Xq8KNpAyBucXmaLilKEI1HLMXhbigrQoZghhasAyiW7+prccUBiUB4NO/PeWLdu/rYrsCSuMuk9SBIB9o4xbkRekaZHkIwwxZWXS2weix9+pM31Xiv+vGsQeXm3Eime+mHnWTp/uWWNQCtTebWfRQgSlNDMf3OPSU7xDcHXUwyK91qfGjW6UGnmd6TOor7c/jya0QppdQrPzpOwB5AZJR2GJIidAfo7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pdh4Q53xWIzajSs+ct2qQUIISuH7wf6gF0Almfq760=;
 b=MigVIOVBocoDOiUDGjY8kEoSC6f7HL6gbsjsoh5uCLcsx/a4YByt5LSI8SYi3xztnTsIbctHwOHqInBE0r0Nk0PY0dxtxPUNIy5teLPnSHxF84B8EAnbdzRi/2HJbVOiglGqiHLVHIK6w6Ji2nztZLPBAEOycgk6+kzVBHy5iPcOz9B3RxB98qJmhjYVJGTR8qetVN307JUux0ztpDUQhxHoooF/WJ1+0v8yvbiNBdHIbEvW7DemopdBYsM6TcsuYLKfYmcyPO/jC9+IRGStEce6nosXeX7Xu1fQX04yX1ofJ16sDXCM767wUwE09fP8BprBw/k5WIbDhLXYs7+PVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 03:28:49 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 03:28:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Sina Hassani <sina@openai.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Aaron Wisner <awiz@openai.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] Fixes a race in iopt_unmap_iova_range
Thread-Topic: [PATCH v3] Fixes a race in iopt_unmap_iova_range
Thread-Index: AQHcyG24YrxRsswYrEOu01njnUjXC7XXorgg
Date: Fri, 10 Apr 2026 03:28:49 +0000
Message-ID: <BL1PR11MB52718837B34DB23713CEC2978C592@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <CAAJpGJQ4VyeaZyVwh0Y-tanUCAqiY8v=rmiGr8cp_XmFph=SGQ@mail.gmail.com>
In-Reply-To: <CAAJpGJQ4VyeaZyVwh0Y-tanUCAqiY8v=rmiGr8cp_XmFph=SGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ0PR11MB6621:EE_
x-ms-office365-filtering-correlation-id: 49ec55d7-3867-44ed-cdeb-08de96b1482e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: YCHjscvj7rmYx9Y47iiH/8GOuov1hT9f+0G2OhrCIQBTUNfN0x/dO3/XUKFWg1Pj0r0VdOVObHCSdJcT1cCPMJV8+HRO22KoT8puOffVrao5wl77jdLSSfYbmfBN84LVCIfmgfZTFdlEvWuuZyyBp4qJgNjknkB3Qu8a2EPS+xOI7HVV2Syv/EtEc86nof9dun2E/JHDZozSSTFINNaM7YQT5uy3ZhN4HrQMwxIRmb66/hdVKdYS7FWGiAxP29oDSvmTDwjFXW4CwV7doBbNKOLVAlYx7uN1YZRRSKd+4VsUm5aloafdhuF28LaM2+B5SQBW93zGvHNIseA9E/d9nRLLbdq8mAXJijyuqMaNmk0kshXtsIaAaZWL43nyLg8P/gdXqqO4ctHWsq/zYXDaEyzBcHXqP9IyYcU4gUaqLuLGYRjqHSZTKgG1WRQGxcGVu1yjs0Stq6QHarK+ctBmQGMK87Azum1+VYlsDq5U/YsyLfvW3r+Tdetn6sHEAp4SV/sKnrATaxcrNDLBZCv1XnIxInv7QYhCBWAx685ry/Zy3D5Hdwd1DkkZOxnQL0oQIpjtJkDmt9nor7/+r7y8bK3pPUZ7lkv2vq8w9Kbugpe0paXb1fJlDroQevtPAfinbC+r/igSmosKvY+vnn5v9dtEVH2xY8DUM6BhkJHQA2vto0sno2MdXLhXQ5kMZvaSjEwEtLKXP2MGXMD7WRpx7ew9NQ2ba80yb4lk2xuPDngvhAoyadP3Os8hjkyHkdo1D8zyOedA2B3d86ntgMvfXI1svGQ1p5ZeMOb8G088mAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjd5VW9VNWIrcWtVZTM2Q3Bja2VPUjlrVUVjK3JYUEVUSjllTThDRFJtLzVu?=
 =?utf-8?B?eHBlWEc3UmRZQjFJdXM2dmRFUjMwL21YWlpBMnRQQWE4cnhkRENBaHoxVUhZ?=
 =?utf-8?B?bDVQYU92VVJNZkY0NXlsYzhINFhrQXNqd2dRbjl5cVg2OWdTMGRiWndlUHFM?=
 =?utf-8?B?eHQvVGxrQnJ3eVprdXE0UHhoN3B3MTk4aS85MHNJT1lLMDZGWlZRZXpaT25s?=
 =?utf-8?B?RkF5a0R2RWtUMytiWTJGT3pPLzI3R2xNcnN0b3Bpc1J2V1JBcFZYK0RSWlBT?=
 =?utf-8?B?ZGk0d2x4cU8xYllFUE1saTI4N2xqUWcyajdoaHVYamMwdjdSQ0p0cjNyRkM2?=
 =?utf-8?B?RHhhVlNxWWlqdDRCVWtnWTdpVGVWeTg4T2hxQ0hmdzl6bFI3TkZEVlk2ZXJp?=
 =?utf-8?B?MXFyd1hqcHgyM0MvWitmOWhuYkpJRE8xR3VFSnRtV2g3TEFsUmdFNTdVQlBT?=
 =?utf-8?B?UjhoTUFwSzRTWkFEVTlyUGdGMGdqSGpybC9sZ3crSEFBejRjdVhnYzhMNWlk?=
 =?utf-8?B?OElxak9NUWM1ZXN4S2FIRmV6MG5nTUlmbkM4alpsbElqc2VpdnBYaFM1VE5o?=
 =?utf-8?B?azhDUUYrU2ZLUmFxSFZRYm5MMy9iSDZmV1ZZQVRONmZER0h4VnRhcGdzMFZv?=
 =?utf-8?B?V2RpdFdKeFYvemc4Z1JuWkRlTUpKZjJDYVZRaFdveTRRc2RWTGtTOWFUNGpk?=
 =?utf-8?B?S1VKbTJpbHpiMGV2VXd1LzdBY0ZuaDlhWDJlRXNTTmhkWVJqNVN4MFNveWJT?=
 =?utf-8?B?ajBxVlJRSFlYUXRIZ0E0bVJEczErUlRrMHNUcGs0dFBuWncvUWNwOGk3VEYx?=
 =?utf-8?B?ZWdmMzZ1RVpvZ0FJaXJJdnREck9KclE5alJwMnl0R2pUMUZaTWhHeml4TWlZ?=
 =?utf-8?B?ZzZRUUFoNFNxUStxYm1KUzZyVk83NEVCdDhLUjlsSGtnckI2K29ROFRpdEhw?=
 =?utf-8?B?bFMyOXBFU1pMOWZpMno3WnpvSmJyRFEyVVVHN2VDL3o5UlQwd3ZzWUZRMUsv?=
 =?utf-8?B?MFBlUmIrMjBad3ZCZUtLYmpyaE9DMENUaGNDMWNXYmJnSVJNcHhmemFWVm9Z?=
 =?utf-8?B?MnhaNFJkUXFXM2d3QkwxWGEzbU5IUmtMQmlTcjdCUEhMdGNrNXFVbE5jUWRw?=
 =?utf-8?B?emN0UTBPa0N6RkNFMmNQaWxwY1dsZ2tJOEFkZ0ZtUlc5SUFYSFdtVEM2Si9k?=
 =?utf-8?B?Qk56OFczcmtXalMzUUs2NlpKL3c2eGp1am5XdFMvMFA2V09ZZzdnRlBhOE5T?=
 =?utf-8?B?OEp6ckMwNk9ET2ptZDhxcVN6NEhSb21WSHlKWCtISzM0UEp4VHZPU1BqZ3Jp?=
 =?utf-8?B?OUpxd0ZwWHdEbUovYjFGRHcvenpHODl2Y3djNjFFbWpwc00yNUlwTEtSZHpB?=
 =?utf-8?B?bFViNFhZUXNmWStZZUxoS0VIamhIejVDWnRobW5FOXRma0V3ankwOC83Ym05?=
 =?utf-8?B?b0lzZGRWSFV6VWVTV2NaZ3FRcXBjdnBmeXRvUmhnOGFUd2lPNi9VUVBGZDQ1?=
 =?utf-8?B?OVcrVEwzZ0d2bVo5L1h6UUpadFVPOTNLd2c2aXdQeU9OU0xKZUxkc1J2SUNl?=
 =?utf-8?B?WmFGOEpFNitsUCtObU9KSC8rYjNjTURPa0FtMkZYQmY3RjNRcForOGQwWnBj?=
 =?utf-8?B?Ulp4V0tLaHpwcE91RTg0VnBjNDIyUHVmN3hxWWZxcWh3RXl1cmVXZjEwRXpD?=
 =?utf-8?B?YTRZRUVuYXJ6cTFIZ1dSMlVyVGU1Qk1Xc1p2ajVQMno0L2JoUTZnZDZ0OTFr?=
 =?utf-8?B?NFBkdEhCaDlXRkNLVUtjdEFJa1lOL1o2Q0VUOXRVaWx4RzNiQjdrMk1ES0w4?=
 =?utf-8?B?SC9nVXN4emQ2YkFGUU1rUFNRZW1zU3piUVlWeDhvZDZnRnlsN1k4VHdubW5t?=
 =?utf-8?B?anp0VEoyaUJUSlo3aWFPR3dwTFVQRG52YjArY2tPUnJBUlRQa1l4dnJFTTRF?=
 =?utf-8?B?cUJOdlRCYmdTa2QzUDY5WkFXbEluVGxzOE1vVWp5aVR5NHVnZVhHL2pSVUN3?=
 =?utf-8?B?QWphY1BMUWQvSTVzUTF3eWU2SUxhRHhYcmRBbVJUQjlVN3ptSFNPaXRXMXhv?=
 =?utf-8?B?Zmw5Vko4anUwVkJoM3kyeXQzdHp4c3RENTVYaDBUNW42REY1Vzh5SFd4Ri9R?=
 =?utf-8?B?dEJBYk96UWFpaHhJa2ZrU3M0WE9XcTcvN3hEVGF4NU1kSFNPWnIrRnFZTisw?=
 =?utf-8?B?TGMxU2RjejJVTEJ2UGxiQWdYREN1U2FVRjZ3YmRBVXpGTUdkbVg5bWpEMHdl?=
 =?utf-8?B?eGJYc0NiWW1zT2x3QzREVmlCL0owZ1hIU3h0YXdmMHFwQVRabzJVOXJCS3Jv?=
 =?utf-8?B?ODhtb1I2cGVvNnBmeFNPK2lycnFUS2EvVXN1S1ZZbElHNGVjdEs3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KKbKYX8BhmTZ0SjeDNlfXusizc6Q8C2toYOZF3vxOFS6SOkkjtdDHeAmZsL1NdxFqRuiwUSmcQ7s1l6B3oyRuAJdb/CQzNoKuPl0whYzKrsKtTHGF2gWXem58GrYgU8BnhT0SyW/KRV6Qe5ooD7dUJzjrVtD6iw3NTmjqj+gG5QQ7E6ZP7oErQ0t1n3VqbOUoA+j+JtoKbgKKjugAYaMXOJN9/gaLeQ1KCn1nU9L/pzLEKJop+h8O0jxpJORprTEHFgu0wKb/bH3cLkmpvj3vkvT8X7KAR58GjOFt5jgQsmOpNmsjzBNzA0lQ65No96GORT4F+gxL4K/8uM2jKIxKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ec55d7-3867-44ed-cdeb-08de96b1482e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 03:28:49.7175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwZtNgTyQwPwnrQqyk24MlraA+xVjsPtik7Zs9ztGBMvY0f6aQT0ryx2xqnwk/7oZE9Pr2QUHm+XNqaGwNXUew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235559-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C878F3D1D12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBGcm9tOiBTaW5hIEhhc3NhbmkgPHNpbmFAb3BlbmFpLmNvbT4NCj4gU2VudDogRnJpZGF5LCBB
cHJpbCAxMCwgMjAyNiA2OjEwIEFNDQo+IA0KPiBCdWc6IGlvcHRfdW5tYXBfaW92YV9yYW5nZSBy
ZWxlYXNlcyB0aGUgbG9jayBvbiBpb3ZhX3J3c2VtIGluc2lkZSB0aGUNCj4gbG9vcA0KPiBib2R5
IHdoZW4gZ2V0dGluZyB0byB0aGUgbW9yZSBleHBlbnNpdmUgdW5tYXAgb3BlcmF0aW9ucy4gVGhp
cyBpcyBmaW5lIG9uDQo+IGl0cyBvd24gZXhjZXB0IHRoZSBsb29wIGNvbmRpdGlvbiBpcyBiYXNl
ZCBvbiB0aGUgZmlyc3QgYXJlYSB0aGF0IG1hdGNoZXMNCj4gdGhlIHVubWFwIGFkZHJlc3MgcmFu
Z2UuIElmIGEgY29uY3VycmVudCBjYWxsIHRvIG1hcCBwaWNrcyBhbiBhcmVhIHRoYXQgd2FzDQo+
IHVubWFwcGVkIGluIHRoZSBwcmV2aW91cyBpdGVyYXRpb25zLCB0aGlzIGxvb3Agd2lsbCB0cnkg
dG8gbWlzdGFrZW5seSB1bm1hcA0KPiB0aGVtLg0KPiANCj4gSG93IHRvIHJlcHJvZHVjZTogSSB3
YXMgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBieSBoYXZpbmcgb25lIHVzZXJzcGFjZQ0KPiB0aHJl
YWQgbWFwcGluZyBidWZmZXJzIGFuZCBwYXNzaW5nIHRoZW0gdG8gYW5vdGhlciB0aHJlYWQgdGhh
dCB1bm1hcHMNCj4gdGhlbS4gVGhlIHByb2JsZW0gZWFzaWx5IHNob3dzIHVwIGFzIGVidXN5IGVy
cm9ycyBpZiB5b3UgdXNlIHNpbmdsZSBwYWdlDQo+IG1hcHBpbmdzLg0KPiANCj4gVGhlIGZpeDog
QSBzaW1wbGUgZml4IHRoYXQgSSBpbXBsZW1lbnRlZCBoZXJlIGlzIHRvIGFkdmFuY2UgdGhlIHN0
YXJ0DQo+IHBvaW50ZXIgYWZ0ZXIgd2UgdW5tYXAgYW4gYXJlYS4gVGhhdCB3YXkgd2UgYXJlIG9u
bHkgbG9va2luZyBhdCB0aGUNCj4gSU9WQSByYW5nZSB0aGF0IGlzIG1hcHBlZCBhbmQgaGVuY2Ug
Z3VhcmFudGVlZCB0byBub3QgaGF2ZSBhbnkgb3ZlcmxhcHMNCj4gaW4gZWFjaCBpdGVyYXRpb24u
DQo+IA0KPiBUZXN0OiBJIHRlc3RlZCB0aGlzIGFnYWluc3QgdGhlIHJlcHJvIG1lbnRpb25lZCBh
Ym92ZSBhbmQgaXQgd29ya3MgZmluZS4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IFNpZ25lZC1vZmYtYnk6IFNpbmEgSGFzc2FuaSA8c2luYUBvcGVuYWkuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvaW9tbXUvaW9tbXVmZC9pb19wYWdldGFibGUuYyB8IDggKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2lvbW11ZmQvaW9fcGFnZXRhYmxlLmMNCj4gYi9kcml2ZXJzL2lvbW11L2lvbW11
ZmQvaW9fcGFnZXRhYmxlLmMNCj4gaW5kZXggZWUwMDNiYjJmNjQ3Li5lMzA2ODcxZGUwNmQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9pb19wYWdldGFibGUuYw0KPiArKysg
Yi9kcml2ZXJzL2lvbW11L2lvbW11ZmQvaW9fcGFnZXRhYmxlLmMNCj4gQEAgLTgxNCw2ICs4MTQs
MTQgQEAgc3RhdGljIGludCBpb3B0X3VubWFwX2lvdmFfcmFuZ2Uoc3RydWN0DQo+IGlvX3BhZ2V0
YWJsZSAqaW9wdCwgdW5zaWduZWQgbG9uZyBzdGFydCwNCj4gICAgICAgICAgICAgICAgIHVubWFw
cGVkX2J5dGVzICs9IGFyZWFfbGFzdCAtIGFyZWFfZmlyc3QgKyAxOw0KPiANCj4gICAgICAgICAg
ICAgICAgIGRvd25fd3JpdGUoJmlvcHQtPmlvdmFfcndzZW0pOw0KPiArDQo+ICsgICAgICAgICAg
ICAgICAvKiBEbyBub3QgcmVjb25zaWRlciB0aGluZ3MgYWxyZWFkeSB1bm1hcHBlZCBpbiBjYXNl
IG9mDQo+ICsgICAgICAgICAgICAgICAgKiBjb25jdXJyZW50IGFsbG9jYXRpb24gKi8NCj4gKyAg
ICAgICAgICAgICAgIGlmIChhcmVhX2xhc3QgPj0gbGFzdCkgew0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHN0YXJ0ID0gYXJlYV9sYXN0ICsgMTsNCj4gKyAgICAgICAgICAgICAgIH0N
Cj4gICAgICAgICB9DQoNCnRoaXMgY291bGQgc2ltcGx5IGJlOg0KDQoJaWYgKGFyZWFfbGFzdCA+
PSBsYXN0KQ0KCQlicmVhazsNCglzdGFydCA9IGFyZWFfbGFzdCArIDE7DQoNClJldmlld2VkLWJ5
OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==

