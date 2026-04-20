Return-Path: <stable+bounces-239993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAGuFAWD5mkIxgEAu9opvQ
	(envelope-from <stable+bounces-239993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:48:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB10433718
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6BAE3003830
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC423C872E;
	Mon, 20 Apr 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgtKclpN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3037BE64;
	Mon, 20 Apr 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714492; cv=fail; b=uT70ZCcM2gI+Vo/FE7HsTAwzz4ARaD6RHgDoG//FGkndJnn+fxX0/0GqiZJXk4uAtpiM6rVIC/VCUqj2CljSzn6xRmxZqEM46lWraW7JDKFmhTpXO9MCHQgrQ+bkKw8iqdtYHvAC3A9APctg4H+Iy7fv2rKDXIBxUYiOci4xkIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714492; c=relaxed/simple;
	bh=u2JMKPSNFG1FZVL9ycZBTu2hP3WpEG2vJ3y0HNSQGqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rp1OqQjwngPbtQ0wGAzPEIk5ECZimLElwZp2yzeSPOj/vGllhV2bnMJTd0DOSKczr19tdy4RYEqA858Kef9jtybqBmSzNjcEECErWPqhVC4iPkgWMEf2sHTusvoYIEsRTZgwJehJ8Bjz9Pu/eF0k65abDk++WhSLP5HaBAZ0b0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgtKclpN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776714490; x=1808250490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u2JMKPSNFG1FZVL9ycZBTu2hP3WpEG2vJ3y0HNSQGqs=;
  b=IgtKclpNJ7Qbz7J2gqXJWp4PlKLJq+PnLqrAZRYUH5tdjyfrM6GbFKV/
   mOhZYJtJbIBN+gZ/yB6ngboT65s2XE55NrzWSU41Js1n8J4J5YzBrvtUl
   ozrkwvdsOWo/0kiBmzlCGmw/m35M0fu3FRPBDGsGnMDPICEkd823MttRM
   XgjjggtTBwQ0eLQ5q+8aZXCPiajPAOYZZc+UFQKvudt6BJldqGP09E1kz
   BdWEbpMPpRctR+ZZHNTwjhlu/KGHvqkYkcFg0CN2zOIosVWZGXusb/T7d
   zKGyzEP+QOlgS+3T37zLElqoWSy0u0OcHNiXaMSzyJCSOWPfarVkvEfqg
   w==;
X-CSE-ConnectionGUID: tctqmWs6RGmLeDoS/qsuIA==
X-CSE-MsgGUID: jvUECO79Qx+0HFaxHpXBdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89110197"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="89110197"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 12:48:10 -0700
X-CSE-ConnectionGUID: i4X8aLjNT4urWBG+zRT53Q==
X-CSE-MsgGUID: RbaFUNaFSuSbMrWKccpOcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="255071831"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 12:48:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:48:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 12:48:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 12:48:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL1GMHMvIeE9ZnE/5hBUD7E4mV+6XawEBGeW9MLFBycGeFdiBVF/bNcRaKrXlcvQqIIFfoEIeABC5UhDU6WO0EEy7wP9n+9SgojEtVbfHugYGenREMXlGc7HGBFoTChPiqqfegWAt098cXg9KDCvLTKLf0sacvR9zQNumi6pXqLyM7t3Fe+/2ysA68FOvJbOxgiqPlNrQMcyQ7MSqqGpZsBeLjTs+LvuHlH/yd+JHbYMXnSzJUoqnn/jOI7M281zopLDQagXDVbM+hk7kE2k3P8zApwFnZCjC76NinlP0KjO7mOJ/ohgn6ubm3m8YzDX3oBnGGIy2chnrv2FW1PDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c9Et9RgNzV4pQuI1g6xzGbjQmOZpCd5hlGoiKujCjQ=;
 b=WvdFzcHMKVKyqij6HvkX1jok2PPDOQwD2iXBMUOMubQMwEWae4503IXwy1jFnO3K6mjv50feIM7k3b6Yp13W8e8C9LwGI/9hVLi9wKI+v9X9ntCYwXtbbfhVj14Niv5oo+8kgBdAraGlTuWxwpncZaSLhZCzF2QiGR3jrvOVWpJNmV5ZaK9N1QLBBIzeBBqH5ZyA2GoK37IKP3ArOOHu+L+OKuGkKy4k072t/dva2b0bzcYFfMswlz0rqwLY3WHRFmxa8IOqAxPWrWNLHWMDjL/Z/QHxULjNhqwZlH0sFsIj2/pEjgPMpQ3mDsDu9MDqWnksAzTc51aBO1lToMuS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH3PPFFA27DACA6.namprd11.prod.outlook.com (2603:10b6:518:1::d63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 19:48:04 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:48:04 +0000
Message-ID: <1edbd9e7-19ad-4cde-9567-ea46f9026c38@intel.com>
Date: Mon, 20 Apr 2026 12:48:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 11/12] idpf: fix xdp crash in soft reset error path
To: Joshua Hay <joshua.a.hay@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<stable@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<patryk.holda@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-11-686c33c9828d@intel.com>
 <20260418190019.194263-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260418190019.194263-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0326.namprd04.prod.outlook.com
 (2603:10b6:303:82::31) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH3PPFFA27DACA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa551a3-2b36-4df4-6e00-08de9f15bcb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0z9YWFfbclI7Xh98jFOG1E3WnJdi+r+cI/26nC2EYh6+zatG94F6zPuBUNBmWLyQLHJzf13aaJYGR1ajECvKAxdApfOnVJ51PtIN1wmLfHnEPvMxuZWYIhqj/aO4CGAPgud5dFNnWRteOoPX5hshX4cROcUcQtlI2GEKpW6hXJ0AhxyJoVvSSDpPxXHyphDCQ2PU0TD5JmuYGzXn243Yx3KhUZqmXjOySL9X1nJwi/8bsVzdRVaZ1b909wiN3vSbXXIqIFNF1mUEe2w4UycdkwYOObI8e0XzOW6glUXz5rMl2yDE++/N9laK+YXCGcsEqjJpwBprTRvb8YkzlOY6jrJgdW1VuBoSjbav459mIzdTDcvOGFA5Eqj9zepVCARoqqhfFZZxDrKfrDFHdpnmkgDoAN7gT6sr1Rs8QJ/KB07tVOjQdVJuGWQazkRWQuWGHsRhVzQU/+RYsb8AAGHlEPOvG5j3GnUOl+3Zg/f5+B/h1M7oSbgVWf99l8rq/s2O4Y99DPecHwuBOG63Q31SP77VduzcFoWgTR+libXUTCx/muvTsm8TSWj9iLZV6fpq27+nw2WyFxoIeI2Q5O9QTkwaOcZxniFmRB166flwESIhykhdwJI1Vhy6aCoOE540YWOKByrgilKindVEfxkC1r/yb5N5uxDkJqJ1xFhEjp2J8SibEY2zz0Yg5+NVwEo/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZrK3Y5aENmMVlEa2FNY2lYWElwM2dhNkIrQmpHMnhKQVF3eGora0xCR29o?=
 =?utf-8?B?TklVckNWekRvWEhJWjNmNldyNHo5YXZiS0tXdmNPZmpidGh6c2pucGQwdFpN?=
 =?utf-8?B?SVZaT3dGSWlqeWFyUEw1Y2IzNVJBQ3NpOG1ra1loSnhIZTJiMXVybzNkTzVX?=
 =?utf-8?B?aHNhYk1NZGJpZkRXMkJ5TGtNWWJPbU9YcGt6OHBzbFdpOWd4dUtkTmI0NFlN?=
 =?utf-8?B?eXBFdkFuTTE0R0lKc1MwL0hNRUtxMk5oay83N21VeXU3clRycXgxZS9ia0Qw?=
 =?utf-8?B?ZUR2VUtTd1ZYc055RlRZdVFJaGxvRGhYVEgzM0lUTTBNK25McTN5eVdVMnpi?=
 =?utf-8?B?emFGdFp4SEhGaFpnQzR5bzc2QkJ1OFE1MVhhSTZOVWp5aGVIWmxuMmdGVE1k?=
 =?utf-8?B?L2s4N0VQMm9reVFBM1IxVmVyVTNGQ1dVZGxZNGhCVG50cHlKQ0RXMm9RZ2Q5?=
 =?utf-8?B?UUsyRmV1YUM3aUQ0VDBMNHpwVnpBaEI2R1V6dHJ0TXdzUS9ndGp6MGVOZDQ1?=
 =?utf-8?B?b0pmRXkvVDg3NWlKL2F1eHdoZ2ZxUzRzcWNFbitTT2RkdThreFdiSXpaN2FE?=
 =?utf-8?B?VVlqVTZ6TEJJUkwrQm9zZytENk1id1lrMXBValZVaGxGc243UmxSeFhEWFRN?=
 =?utf-8?B?WEVNU1pNZzRmU25qeVZPbEtFakU5ZUV2WXEwQXJhYWlmMzNBMTVJeHVUVnJM?=
 =?utf-8?B?dGxHeGY3cE1QK08rWVRsdEt6Nk5pUVN2d1gxRG9INURpQzZCOGlRU1J2UmQy?=
 =?utf-8?B?ZjZ1ZmhPOU1DdmpSUitGa3hCUnZQcVFSSGhKMDNrVGpqbnJPb3A3TVowTzNI?=
 =?utf-8?B?VjV6cWdvQjVuNkRwVkx6TEJ1T3FIWG8rNnB2T2s1MjZuUjBaUGxjTlRMWFpB?=
 =?utf-8?B?Ui9sdldiSG5NcHVQSUVvTXBVakR1eXJieGNSelFXc3RmMjBURGJPZytPclps?=
 =?utf-8?B?WjQya0xYVlZmYWViQmR3bUUrSEVRVGFaK1BGQXQwd1lJV1RqNkdScENlM0Vk?=
 =?utf-8?B?UFBRZ1VCOHhYS2FaTzNIelYrM3FKL01iNi9hcmRJTzlzZG1Cdk1uZksvc0Js?=
 =?utf-8?B?QzJoK014UGp6cnJ1MHlaSWprZ3pFYWp3VlJodktZNlFKMk1zVWFlRzdEQTVo?=
 =?utf-8?B?MHp2cUtDRHpPYkxkakJGblQxY0hrVzE1L2daV3Z1T2N5ZEk2N2JJMWphcEZp?=
 =?utf-8?B?bzNuMWxxYlhGOGl4dERSQUZWQ1NNZFdSTHNzSDdXUDBvaVNOdVByUUxFTFBv?=
 =?utf-8?B?bTR0ekgvREpUSXVTaDIwY3hBSjFnQkxiSDdBRHp1dzlSU3BleHJtUHA2akJV?=
 =?utf-8?B?UGNGK21JVE9rL0FGUXV1WFQ3MWR6anBsVnNQM2xwZ2tLT1N0VnhaQjliQTBz?=
 =?utf-8?B?dlptdldNT0VsemVJVUxIcFFaQnZPV3JzbDRnRGhmcVM4dFNSY3E3anZkZUtt?=
 =?utf-8?B?Rld4MUd2Vi95akM1QmEyWHdLNWtJbVJ2b1dSY2tlYTRGaWtGb09rZk56U3Bp?=
 =?utf-8?B?TUM3S0lhRHd5dVp0aDR3dEwxR21KZHNDUzRLVEYwVVhZYVc4ZXdGTHZES1Vm?=
 =?utf-8?B?dnN5UWE5Nm10Nk9GbmRITHNRNHM3dE5WSjB4VVdvVmt0ZEVsL1liM0xCQUFH?=
 =?utf-8?B?NmJ2R1l4ZjU5Y0JkN0Ribkdya09EWHdvcjJnc25rQXRJNWhZMTMzRnBXQmNp?=
 =?utf-8?B?TFczTEJNeUR3bDNWdGFCL3V4TnBCbGRlc0RLMmdldW9XTjA1ZDloV1hjQTI1?=
 =?utf-8?B?N3JHcFJxdmlmei80V28rWS9Wd3BVc2FCYjI4dlBMNG1iamc1ZWx4YytCdGYv?=
 =?utf-8?B?L2JxSUNRaUdEL2dURVhoOHE4MG1yd0JRTGxvOGZ3b3JnaVp3THMzc0w2UXlt?=
 =?utf-8?B?RTlvSFpPWEF1bU1ZS0dVb1l6MTl2MGtERXJiWU5MTVhTWUkrUlVSUzZQUkNF?=
 =?utf-8?B?Z01wUlF1YzI1QmlNNytINHlrTERjeHJsV1lsTStiODA2djl0Wi9Dak5FZzRq?=
 =?utf-8?B?VWYyWm5TRFc5dlJ2aDdGd2JXV3p1K1hjMVYvb2VxMDhWL3cwODFuY3pSWHNk?=
 =?utf-8?B?KytJMXVpeEJRYUcxek9PM0ZZY2RiUGpldGZiU1BOS3NHbFhScjRKUjRKVFFO?=
 =?utf-8?B?QmZoNmhCOHhKZ203aDc5OUYrdWIwQkJFd2JUM1k3Z2ZYZmI5UU1XZWtOaWUv?=
 =?utf-8?B?N3pNY28zL01SNWcwZ0FoMmdKaGl4eFdpQmV2VUxvcE9BU2dHR1d4RmEzSVU2?=
 =?utf-8?B?TkRnT202clJmelB5QWwwbXRhbnkvb2ZWSFlialVQREVyWlBvdEdoTXZpQ3gz?=
 =?utf-8?B?NzB1WElFcG5PbmN0MXl1Q1prYkJaQVEwMXhIVEpuTVZCZ2JsZEVqZz09?=
X-Exchange-RoutingPolicyChecked: CEtYCgieH7ABBQ1Tw4IqhmZ9bGjHFiA+Vog5uEUGWIKO1KOv4Jy1wAT23xMjf/fy7C9sXz0VTcGJreCzp/VqnE501+kVSpMyA+JG+kXuy99lxsK4qVDtUo9TwFVBT2QDJVeiQ8yT0lfI3rAY1HrZ6orog/M68gJNOSp8F4a0hi4itv+ieDLiCi5hDMELojDNyh5eeD/Fpy49IO/O4MEeQyKJIJhX4K7WQFxihjJlSp6Lc7vbbPafApvX5Td+u5RaKsUbqNnwexug1LfbXbGxa7QGCwYhA1Rbq+djcWagyoFzUQwipwyNOF5ur+7EOgtS8l886oJnX/ZiWyovNRM52A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa551a3-2b36-4df4-6e00-08de9f15bcb9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:48:04.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Il6JNUNS1fgoc8oGyi95QDi2S3xj/m2krB9A8at958yx3W0TOF8iO5m00ChX86mowMmBx1h4sxPCReMSfMoBgip1hIp5n3W/HVKN0IwSAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFFA27DACA6
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239993-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3FB10433718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here's the full review on the website if it helps:

https://sashiko.dev/#/patchset/20260319224159.23885-1-emil.s.tantilov%40intel.com

Thanks,
Jake

On 4/18/2026 12:00 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> Jakub: I'll drop this patch and apply the rest.
> ---
> idpf: fix xdp crash in soft reset error path
> 
> This commit fixes a NULL pointer dereference in idpf_vport_open() when
> soft reset fails by restoring vport->xdp_prog to the old value. It also
> updates the restart check to use IDPF_VPORT_UP instead of netif_running().
> 
> Cc: stable@vger.kernel.org
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
>> --- a/drivers/net/ethernet/intel/idpf/xdp.c
>> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
>> @@ -488,6 +488,7 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
>>  				   "Could not reopen the vport after XDP setup");
>>  
>>  		cfg->user_config.xdp_prog = old;
>> +		vport->xdp_prog = old;
> 
> Does this also need to roll back vport->num_xdp_txq?
> 
> Because idpf_initiate_soft_reset() overwrites the vport struct with the new
> queue configuration before failing, vport->num_xdp_txq might remain > 0
> while vport->xdp_prog is restored to NULL.
> 
> When the interface is brought up, idpf_xdpsqs_get() evaluates
> idpf_xdp_enabled(vport) as false and returns early without allocating the
> NAPI timers (xdpsq->timer).
> 
> Could another interface redirect XDP frames via ndo_xdp_xmit, bypassing the
> check because vport->num_xdp_txq > 0, and cause a NULL pointer dereference
> in libeth_xdpsq_queue_timer() during idpf_xdp_tx_finalize()?
> 
>>  		old = prog;
>>  	}
> 
> Is this old = prog assignment leading to a double-put of the BPF program?
> 
> If idpf_initiate_soft_reset() fails, this error path drops a reference to
> the newly provided prog when it calls bpf_prog_put(old) right after this
> block.
> 
> Since the function returns an error code to the core network stack, won't
> dev_xdp_install() in net/core/dev.c also explicitly call bpf_prog_put(prog)
> assuming ownership of the error cleanup?
> 
> Could this underflow the reference count and cause a use-after-free?
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
>> --- a/drivers/net/ethernet/intel/idpf/xsk.c
>> +++ b/drivers/net/ethernet/intel/idpf/xsk.c
>> @@ -568,7 +569,8 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
>>  		return -EINVAL;
>>  	}
>>  
>> -	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
>> +	restart = idpf_xdp_enabled(vport) &&
>> +		  test_bit(IDPF_VPORT_UP, np->state);
>>  	if (!restart)
>>  		goto pool;
> 
> Does this function leave the queue pair permanently disabled if the pool
> setup fails?
> 
> If restart is true, the queue pair is disabled via:
>     idpf_qp_switch(vport, qid, false);
> 
> If the subsequent call to libeth_xsk_setup_pool() fails, the function
> returns early:
> 
>     ret = libeth_xsk_setup_pool(vport->netdev, qid, pool);
>     if (ret) {
>         ...
>         return ret;
>     }
> 
> Does this early return bypass the idpf_qp_switch(vport, qid, true) call
> expected later, causing a permanent partial loss of connectivity until the
> interface is manually restarted?


