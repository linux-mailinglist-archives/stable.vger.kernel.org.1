Return-Path: <stable+bounces-244448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPqoFrCk+2mvegMAu9opvQ
	(envelope-from <stable+bounces-244448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:29:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB24E0309
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284243016923
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191737FF54;
	Wed,  6 May 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgK+uJa3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658437F727;
	Wed,  6 May 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099348; cv=fail; b=X00CndN++s56gVQUmmdwdcPI/vSGRBsPC66YeFXvCrySMJWUmHLiTZ9l76I6yS+VrTmT0lwmHQ2nahaM3UTdnDJsBydq4daadDAW1m+A+HpDOjK0g/16GgYFEqB8UllnYrYx8HLC91tFyQ4dWfuhYbUkg7pIqFvVHdAIWKYwg9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099348; c=relaxed/simple;
	bh=SevNimjACyZ1/dsu9YTCzw9lfOgEIpLlCOpHwtc+c0g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcfOGZrWzNdbYE0YyvfhmiPmCdGt1NQy7zAA3yswOhGuQ6+1pAS8sJw/lsXuRFaO5oAT0qhqmVUdgFSjIK2zD7rM7Dsk+zgeJyOzF0AddKUEaD0QB5taulwHu+m+fTjIGYNIgxkjvP6Ng5njpDdSWz8l+D+aa8RuzQTjIL5X/gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgK+uJa3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778099346; x=1809635346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SevNimjACyZ1/dsu9YTCzw9lfOgEIpLlCOpHwtc+c0g=;
  b=EgK+uJa3DsFY6T9oW10TKZVoNePB/SR1Ot7Sta+wT/SKSFk72Rt9cu7P
   yeVYhJ9wHz//mJwfOTF+aXV3/Tb4ljQlOpP6fqyvCyxuxxZgLMsg+7moa
   uhEJi6SUgmQYRRJNbn0hBqsSmYJPW8Fnid4AAsWIHIPye/uFv73CIz6XW
   k5K0uAoDNOHQWEwZr3PSyHH971XiUwAiPPFvAN5yfNrRIh0xdSpZaGmgZ
   bEcOoUjrZJ3tkNqtyTGmWJ/8uNaEz0C1u5/BGQ67/eTFCnlgf3aKAMPR8
   iyITJRg/lTRMJV2uvBWrSvKd/0EAvcCNKmU32NQo0D/AjRajJdnrIdEO1
   Q==;
X-CSE-ConnectionGUID: dJO05w0YSM60I8wUyDQDBg==
X-CSE-MsgGUID: HH7uue0nRwKybyGixSbmPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89740784"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="89740784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:29:05 -0700
X-CSE-ConnectionGUID: rsjT+KmhRIWZBtdD+HqKRA==
X-CSE-MsgGUID: 4NJeZOoWRmu/osL4vpvSUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="240577787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:29:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:29:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 13:29:04 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHSChagz3eNohH4Fyhy6aolETPuivtYXtuzG7RQOC7wsqTeRm4uHamwG165b4T11ULe1pumBnAzvZrZHES2P0e5S0jPOMyPpO5fjWmLTo0QuM14f0O/29//RZpbVl3FZCMVlN7yzFMilNVYOUdPoRspKUBdZxwhxgDenT81WrjrBsAmymxDcKZ+qTgPUcYxORyihHeJqtmd7ykpGMGR6sT59H1CDBuCKCrMU3pBOLYR3EhWf1KugFrhlcXAshIo59wPfArpKh5N0VYuI6fpHuhaceUVduaCHcw1VxqElOSRRNbb/NiCgRlPBtmeZz6HpbOphdKVnj8R/GeS+bcuO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwdf6y1OcUkjGOVTanzxUFGaYLl++wOhcj37NWYNr80=;
 b=EYYXo34Wq5n56Sbqt2unoQnt6jqRH2Uec71Kt0eawiYPZduHprYynyv7tdTbQnAgfrndOl2Rwjm2OeZB49KSUF+y8nTgaMwyyDDFWFMDOpYqUl2CBbSsMnaRsmz/6u1cyA7H6k09BcE2wwSdSAe2RFSDPAQHOUavgZ0TPYHlNo1+I1/eD86xV907yj5t8p9o5H/87oIS3Ln7OfqXtXtBWd8S0CJfJiiTg5UyYcgSYri1fKv9JLO17RmnZ623PEhfo3jd1E0yawrZ4o3PwqkftItYWA0ieXe2n9ocja7ZCQtIXTbvhy8ZyGC9BlRUhFp5QGZhMWnH76+7+GcZPknHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS4PPF691668CDD.namprd11.prod.outlook.com (2603:10b6:f:fc02::2a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:28:54 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:28:54 +0000
Message-ID: <c2ac2c41-46a8-4cca-99b0-3e423114c91b@intel.com>
Date: Wed, 6 May 2026 13:28:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 02/13] i40e: Cleanup PTP pins on probe failure
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>,
	Willem de Bruijn <willemb@google.com>, Dave Ertman
	<david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Matt Vollrath
	<tactii@gmail.com>, Kohei Enju <kohei@enjuk.jp>, Paul Menzel
	<pmenzel@molgen.mpg.de>, Sunitha Mekala <sunithax.d.mekala@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-2-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-2-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0355.namprd04.prod.outlook.com
 (2603:10b6:303:8a::30) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|DS4PPF691668CDD:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfc245c-4e56-4497-d74a-08deabae17c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: JYD4OeuPkcmnDxSRSOC95fMdpxKWfKiJqIiKzXZZLE0cLd/+B+Dxcarc6eNDiiiXnaA/2cbr4o+v/pd7y8zZ9aZSaV9g1A1SkBahxU72GFQ3z1ZWSzjtqaKRCVuV/IWXPIQZ2JnFWtXg77rWRFs/QvdE8CUJEEsM0tuWU8WgNRMbfWEW5+MZy/6hZ5O05RXo580C8iLH66aY+X3F4DQmwaBAAfN/VgdLrfLw1afy1RGhOjIVW7JEueRoxhC82QArGYioGR472uFhgzXLfv5cw2LBk0+NBPNqVtvgTcacdeY5E/W+Dqv3NzX1CXOC922Ix8t9vf0KmzbpyBHon5m9n8qlmD+zoaQsxsS3SjzmNyVfm9W/ktAm9k44+P2YfXfjr4MQg1qxcGkPY8XuzbYK8ahDcqVIB+f1Go69fINfkgfd8VU2c2E2D7LeCFK8w/xHGuqVrZcOWiUGd6+RovKlEGofC/CXu/vaMSF5w4vN3SWzumRHfSolHTgPxb9kKm0hztif7we3HglxbMffe60r/PMTyxcrjv4WUSMHqiBE3hlRgD1qZye0+kyaC/1kcS2swAt+77zZHl2akSTKkapJGefJBCDPBHQ/S1fkXKplUEs5E1w11vCS8F0EjCWCt3Ban/TEoJC+YypMahNsGXtQveVze8vX0GBQ/XGbfwen1j3xQznH4yOLBRaGzNpJtUiXzS0fArV1HKk9N/tRujIQ6xYMNWCg2yQlF4zEWixiQoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhrTW9FTmE1bTBBL3pBYk5sSTN2MW4vWGRXd2RTajVqaHpwUVgwelNmcmdt?=
 =?utf-8?B?Wm5lNVVudzlJcUZCTW5HSDhoeldjRFp6aXRhb3RWSVhnOGg2TVM2WE1wUDRL?=
 =?utf-8?B?U2YzMVBoRC8zdm9EY1gzMHZ1YWpGeklNUHduM0tVYjFsTzZKaUQ4Z0RYNHBw?=
 =?utf-8?B?dlZXRFJPWmltaUhqcEJlaUhPNEhUeWJYSFdNRk11bFZGc1dBSlV0NFRIY2VS?=
 =?utf-8?B?ckFMM0JMQlIrNS9jWWZUbjBmZlVZRTdCNGRQR29LRjdIcXpZekRHVUpwQTJl?=
 =?utf-8?B?RVhNVjJrWlhXdnkyZjFJKzdrVXlLYUxCd0JvTlRPM0RGN1JmRXBpT2c0OE1J?=
 =?utf-8?B?TG9iOFFsSHNrL2k2QzM3S09PVmdodU51RXlMWEhnd0dlcUpMb3NBUnA0ZzNj?=
 =?utf-8?B?VjU3amxQcStYM09peFowNDZXNU9BUjg1UUJuZ3pYZ05uNEZyNjRoSWFnL3pM?=
 =?utf-8?B?US9qZXZaejVOaEtORU4vMWdOQmRmTlBVY0lTbFZCbFI2amdaVXpndDhKUmxP?=
 =?utf-8?B?MENXTkdISkh0NXlWU25OaTZHMXF0MEVjWGQ0VjBEU0d6VUFOQUZadlNNSjhB?=
 =?utf-8?B?MHNJcW5zR21kNWtpNnUzT0tHL1BKamdMWFJVMnB6SW5NOERPcCtyVnZ4dlR6?=
 =?utf-8?B?ZmJPUTc0cFgzb0JmWUJZMTA5T2NYelJFRDZFNzdHVXJsWm9UQXo2dUk4NEFq?=
 =?utf-8?B?eUhWY2ZWSWRyTjVhbisvNmplKzA1YXNva2wyUnVwVW5ZL1FjVjNjUm9qQlJG?=
 =?utf-8?B?TVFZYlJkbXQ0Q0xnQktvZGJrM2JLbnpsanlEb0tGZXoxaHFUTEptVzZIVC9z?=
 =?utf-8?B?ZTdCakJnaW1Denl1U3UrVDJVN0lMRmp4Sm9YZ2ZYVE8xQnhMR1RtbCtuaUZ2?=
 =?utf-8?B?Y2k2OTJhbnAyY1FYNFVoSUpTZndzSjU0dk5zTXFZbk0wekJLZTMzZDliZnBW?=
 =?utf-8?B?NmVJc0FpdUVoYzZaczJxazhLSERzRTN1Y0p1VHMwNEpZb01Jb1pkWGZVeDFu?=
 =?utf-8?B?RjNGQkxNQUIxZGFPQW04VmRhK1QxMTd4UXJLbnVoWmdiMWpoZ3AxVnBsTUdW?=
 =?utf-8?B?cEpLQ28zVzFGamlSMExKeWRHaGFFSFFkNWhaS2ZZOEV1aExyY1ZnT0JmYUFp?=
 =?utf-8?B?Q0MrQVUzSVFiSjdDdGlRRkNKK0EzOHVaTGhRTjZnSUNPTkdNV3dDaThGRHdG?=
 =?utf-8?B?cm9WNXdtdDROMGZyMjZkK0tNT1hlcUhiUTJEZ05WbHlacVRhaWlFcmRiYVox?=
 =?utf-8?B?UExNWStucGtHanRicGQ2dXdhOFJGNjBIdEpjMWtua0pXUjZZblJFTHVKMWI0?=
 =?utf-8?B?S1BSTTFLbG5LcjhlWnIyNm41dDYwbHh4NDk4ckxqUEZ5Q2xnVENvdy9EcnJG?=
 =?utf-8?B?bzZnNVE2ay90TFlERXkzTU9PYkExcStqS2U5bTJxZ2RlNXhJMDhSdGNyc0NY?=
 =?utf-8?B?TDgzZlhBSjg1YXRZR2o2SlRMMUl3ZGNycFVpZlROYnorcFB0Z3BOd2I5dnNr?=
 =?utf-8?B?K2Rqd2ovQ0dHcktibEtsNzc0NmtqMWZHSmpjWGpqNDUyZTJWWmIzODNXNkcx?=
 =?utf-8?B?d2VzbzQxd2ZPMFB5SUJRK2ZCZXpLVDFWOEhBdXZ0VjMxWUNBbldtcHdacHUx?=
 =?utf-8?B?T3ZLTm4vV0F0UVBoRWpQME9qZHhsNVV5cWJ0cjJkaEZXK0F1RHVZRkVheUpR?=
 =?utf-8?B?YXNMVXRWZ3FVa1VVMXd5YkpDQkpyd2htVnl0RDJMNDlSTmZnNmVXbGozR2x2?=
 =?utf-8?B?VURYOVUvUWx2NXJaZlRZeHpSbEdDOHhXdVNYYWdMWS82Y25uSmE2UmJUNDFO?=
 =?utf-8?B?UFpHWERUTFBLVDB3YjJiNHVMT251cnVDSGRxU0kzNW1KV21HM2xCdjJyeVdR?=
 =?utf-8?B?RHlzUVRpY01pUU5iWThlOUl4amZWcUFLWlpQRWcxemZtLzRML2dKR2N1cDdT?=
 =?utf-8?B?RkEvNXlyVXVTS3BqK3pKSVhSa3VCTXNOZmVmeFhKR2NldktpTEQvbzhMRWtL?=
 =?utf-8?B?OGdNQ0ZuZG1DSGZKTzRxWVFrc0RiZSt0QWhtNnZPT05zRllmNHJ2WlAvRXRP?=
 =?utf-8?B?bDU5WHNwUWEzVnM2YkgyU3dXbHBnQ2g4eVZHVUhxdTV6c01DN0VjL29LRzBI?=
 =?utf-8?B?UWFtQzhqakFYaTVNclFRVktCeXdxOWFkZDJFdm9EV1N0U0VOaTI2OUN5M2t0?=
 =?utf-8?B?OE5qM2R5MytsaHBzYlVCb2N4VnVTUElXZHZQYi9GTjg5ZERuZ2haMUFMbnZk?=
 =?utf-8?B?bUQ5b2RlRlBqbnJKajdUcjNqYUI0Tk81UVpiazdFamh1VnY3RTJYVUFuNXVQ?=
 =?utf-8?B?YTZGY1BqcEZvQVMwbFhDVnd5bVc0aksvYzc3S1UzY3dac0lidE9tVGxVRWZW?=
 =?utf-8?Q?LpF97sAvZj0bIZdM=3D?=
X-Exchange-RoutingPolicyChecked: LHJCuVmO3nJLJsxO93s2zbGA9ojXFhZ2yqREpmVE3CdoyFZU+wlOwrWtVG1IouhawlJvFzW/k2QOkF0fa8igl5kkPYgssRbpCv1Pc7SmGrVYg8oErfZRosE2XWhdjvOQ4H64UNJBX0YqpplVqU44Hk8q34mBgh19a+w78WhKSCJ/P0ryQsPL3jfMWnubtZPtOGHlDSympVzbc7SaziqJt6+N31OraqWdGAJg+JIQdgggEXnP/6tSF5tVsLQ3AISTZz1GFp5yL9OoJoAuAhWKLhDMG2fc2RlNZ1/RreSTnN5VApTgMcLTWUTtX0D1OYVqb7pO+ZYNJ/uYYV20PfqVhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfc245c-4e56-4497-d74a-08deabae17c2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:28:54.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbD6MJr/tESAPjEzUf/bNjP5Q3duK4RWUJOa4L2hJBj4EHkuMVkOr7FHoS+uIWdGq5yryRhwowH39fqtX3YyPAPpH3eI0wv0ousZSrk+9a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF691668CDD
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B4FB24E0309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244448-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,enjuk.jp,molgen.mpg.de,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> From: Matt Vollrath <tactii@gmail.com>
> 
> PTP pin structs are allocated early in probe, but never cleaned up.
> 
> Fix this by calling i40e_ptp_free_pins in the error path.
> 
> To support this, i40e_ptp_free_pins is added to the header and
> pin_config is correctly nullified after being freed.
> 
> This has been an issue since i40e_ptp_alloc_pins was introduced.
> 
> Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
> Reported-by: Kohei Enju <kohei@enjuk.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Kohei Enju <kohei@enjuk.jp>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
Sashiko points out some issues which are related but pre-existing this fix:

> This isn't a bug in this patch, but looking at i40e_probe(), the return
> value of i40e_ptp_alloc_pins() is ignored earlier in the probe sequence.
> If the memory allocation fails, pf->ptp_pins remains NULL, but the probe
> routine continues successfully.
> Later, if a user attempts to configure the PTP pins via the PTP clock ioctl
> (such as PTP_EXTTS_REQUEST), i40e_ptp_enable_pin() unconditionally dereferences
> the pointer:
> drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_enable_pin() {
>     ...
> 	pins.sdp3_2 = pf->ptp_pins->sdp3_2;
>     ...
> }
> Could this lead to a NULL pointer dereference panic triggered by userspace?


Probably we just need to add an error handling of the pin allocation
since failure to allocate memory is likely to hit a lot of other places
as well. This is also a pre-existing issue.

> This isn't a bug in this patch, but while looking at PTP cleanup, it appears
> the pf->ptp_extts0_work work item is never canceled during device removal.
> In i40e_remove(), i40e_ptp_stop() masks the PTP event interrupts, but it
> doesn't call cancel_work_sync(&pf->ptp_extts0_work) to flush any already-queued
> work.
> i40e_remove() later cancels service_task but completely omits ptp_extts0_work.
> If an interrupt triggers and schedules the work immediately before the teardown
> path masks the interrupt, will the work item execute after the pf structure is
> completely freed, resulting in a use-after-free?

This is also a pre-existing issue in the PTP teardown that was reported
on patch 1/13 as well: we need to cancel the extts0_work item.


