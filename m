Return-Path: <stable+bounces-244516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO9yAwg3/GmUMwAAu9opvQ
	(envelope-from <stable+bounces-244516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:54:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65C4E3BF2
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 08:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6AA3025717
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0E342539;
	Thu,  7 May 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmGus5Z3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C41342517
	for <stable@vger.kernel.org>; Thu,  7 May 2026 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778136668; cv=fail; b=VYPw3ZrN8+ErnkHSyAzmp2ipn/wX9iY2eZRyVECf9cQHIGMWwXijLO9iGo3r8nkV2pwyAvVm8koahwk9/tQGkV3aO+/T5hQmp+6iLFlpU8+WbTIYsb1DqaTomGKnNS04f/yrannD2kaA9Ga3kwA1nJEF0hBMmKg/1qnRZ2sGmss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778136668; c=relaxed/simple;
	bh=zmyT/HNjtxFn7qups7yi4/isxscuozmhg0uHaow2BRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcScBi6YhnP1YNOtoQ5aHQ5inNXYXNht3iYwmWgiDYA/2L4MiSMt1jQ2HWThzsQSy0vM7diz3fVbln8fq8vu2qeVbtB4/JZ1H5YQvpqzuVTUEZ43NULtk1Be582nQyITx4stX7V5qRlA7CsbEHyxrlPCw4PzQIuQrZKhO8gasDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmGus5Z3; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778136665; x=1809672665;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zmyT/HNjtxFn7qups7yi4/isxscuozmhg0uHaow2BRk=;
  b=OmGus5Z386YCc3E2on4N3Js+zdCHMI+3KmXr95wNvatxFdHbmOqiZkkc
   B6lnH6gACDsBMGVe4WfbhlZ2Bazw1c4IpqaWuZt6S8c+52sBLlWuvumbL
   BEglN2RYV+49Widznskt8jdHuEMHpAj+2yA9ufG1KePsSsgkO4TMKrjWc
   8qF+Y+Cye8MA+JXWUu8Pf9EWF3bG2MrF4hPOa8PIzuANIGZ2lq2k1Rwcl
   7v/f15Z6JVKlzB50sdeDMhrOmjKZ0s6P5q7W6ZSwe8E6VFm0WZ5e50bhK
   NLxRoD8QD3LsN3A7jeyRe5eeUAV6GM/Ft9/Ew8pSBqML/ZIdwGJkG638K
   Q==;
X-CSE-ConnectionGUID: xyCW2zHtQ5SZotlL1b9Rgg==
X-CSE-MsgGUID: cHttu6VFTH+hkiVAZDpfYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78229593"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78229593"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 23:51:03 -0700
X-CSE-ConnectionGUID: SXlM1Lu+S0yWVpor26TWGQ==
X-CSE-MsgGUID: Ep4LU3S1SaqSIVKcWarhVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259809563"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 23:51:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 23:51:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 23:51:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 23:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCzhDDh0u3PC/33DawtE/KCeKesMITNRO/96WH52M5z5xinHdJ2Wsc2nZtRSP+WAERNe/bAbghkuVwWM0bxWPjhDZgPhM3MhWRpUMDQsN44jIZ+HY1J8CVxJIq252izc+xY8+IHvK1mXMP45zIvf0Layh5ILXJOxK2IiN3z0eLDqj9THIiWN/Da0BCm+KzhZdlP4XtBapVNP5d0qp91fQQHztyupzgk7qIw48zs+hL2H6YWE4VmwFa6Yjz1RStJkQdSJUpmF4HgpYgby5eONMfJQckM0h4vmqTJFxjRr5PB/+EaNvICU13KHrTjf2XsVfE2rvkkXQi1FB1TVTJYyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQGtZ7PVTfBgOynmmmajyWV+ElOiGfUYjpsmrBlfA1A=;
 b=gvnemGYwQkiPAAWGuPppMYhtriVg/w2F9YNwEgFVz/1dY7RzFf5GNTeexpnhvftXbC6hDZJS1FIKn/Nlyy4b8sVqOoQ7a4HE9qQ/aBZkZakR2NxYnmPqxvMh8MWASSbTdfDvehiLPupTlzhlSO+FcwfSWOcbN2kLs2yV/+h8vAUSuu1lwpaQA5LitsVKhV1TfzKjjk+D+eEX6291r5TGbOvdn2qRR/tavZXQN/RrjFvDKCWsrbj80EJHN3RRXG9vxfujyIY8EPN2ckstue8FJ4BF4uqyiqKmTSYESJ6xFO3Um/3fWD01GL1ZQ0bPGRMx1cF32ewg7+Nton1ywlBxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 06:50:55 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:50:55 +0000
Date: Wed, 6 May 2026 23:50:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Ramesh Adhikari <adhikari.resume@gmail.com>,
	<intel-xe@lists.freedesktop.org>, <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Add bounds check for num_binds to prevent memory
 exhaustion
Message-ID: <afw2SxbMLX10RXZ8@gsse-cloud1.jf.intel.com>
References: <20260506180636.23771-1-adhikari.resume@gmail.com>
 <afuWYH88a4UaABXs@gsse-cloud1.jf.intel.com>
 <7977ff722a61b0e235e3c8007d474ffb2e7b9506.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7977ff722a61b0e235e3c8007d474ffb2e7b9506.camel@linux.intel.com>
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e96d6f3-2756-4069-9d67-08deac04fc7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: Ghk5Hdj7iZgd8FBpLNbKwq2MGqAA1u1hKcTOf9Ah5SQLB0jJ1dPl6lALLYjYr5iQHUFzxHC0iVqmnfTBNSY/5C2fYWvDCnQbbEr0UalgB8Z6V5bb8nSyHA07XKZzrsg/f+6W/Fj56QDvLAVt/etkvJoofYuVNwVX2gRFS6k0UPW9ZK+LC257EPezRf/Ust+9oAb8NKqNPeZX1CGMf9NVBWq3hwNaB/PtiONM5HgvT51d0kkvdbeCNs8y+n4IJLhKyZR5klDgntZ48HRfKLjrx3VT6UKyouz9TA/Bvc0QD5GxWIfzI4ybxbOs3lKukk+H+M8iu1gbySLde3Zk/7KEJHqBEvupFGfm3bkQdDD8xAzxKuBDRvlgbsh08N7V06kHezkGl7Kjc0QLUukkouEHaYUeFZfaJwkvLklpktrPH1vz7jQxg/6xXSSLlLNHsIYakrfM/kI2fCvUP+LyXD261Pb7r9DCv+7c+CjOhVkSm5FbLX1Hi2rpWy3CARsSbDdOc8vHyiPZocRfvPwFdsJKkNqP1rFJdAYGGHrDyI7Y54c7gFs5FWXwSMQg++qYX+TP5Hkho/qubox/3bCr4x0qU6/QdKDlw2eSJMpoyiW2wkztYh4dXS6MTeyCUqmfAWOj0khTTwQE2dPiVIAVKXzz4ISbwRCF/WSoD+nTk4RM3zx5XfCYbpmorsPIPmTvrkWr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QD0ZjsKvnU5u/gB8smpfCBoTFrPdF87YtR++b5jQOKwWtYK/dhagbcnuSP?=
 =?iso-8859-1?Q?2uQLcwVVJ3lA+N31dqV4PEYVC4Rt1btkaU/Nlg2X/fDDPaTShMVYPRzo6L?=
 =?iso-8859-1?Q?PzdhOZPLTagAjumWOg6E6iPPtK9YlpwwMh1xQMiJShsWTqfI5vvnPPvfRf?=
 =?iso-8859-1?Q?5aqTyRvXpdSk2kXR1FOv2/ORqBFqi435nXJju1WG9wWepE6qT6DhEaEJxE?=
 =?iso-8859-1?Q?g8b+1Fv25yeerixp06o1k/Lubbq/ffseXMN2HCRobhbl9c8D6ixqkQkMw0?=
 =?iso-8859-1?Q?m1krXn87i/HxbrAH5b9JoNIjVwp5iWaRToDmw3r/05wYbur84wsDIhpBeq?=
 =?iso-8859-1?Q?b3JSPt+VFv4EZnt6Kq0FBL/yFnRYHTQ9j8GnFzES+I+YrYCRRuttFIiMMJ?=
 =?iso-8859-1?Q?oVcVSPr9OKtA7Jg5WN5sZWJkJEWIMAhRU2y4rQrZaMeB8oX3ahildc0V55?=
 =?iso-8859-1?Q?scFj36X4H0/uRXS6lhL0OqzxyNAfJfYloV+AG1JOiaDpNMX0m0S5c1Jf80?=
 =?iso-8859-1?Q?ObafVhIOysRnqUbvdfbKfN7cKfzBeiyVINMWbx8OnuT/szjYKl0+Ur0s05?=
 =?iso-8859-1?Q?zJRW46ZvNZ+JO9IviL/Z+HVwqs4B+WXIdqOuXVpD8GLO8lSexTI7omzVE1?=
 =?iso-8859-1?Q?SkZ4Rppytzvx9Qi+nK50MLCmLips3v8fsCdM2DuHeRRPCSrLyUH285sy96?=
 =?iso-8859-1?Q?VGvzQ4nAV5dkrjX7CvN+U9AnAP/4EUPrWvWNToXvPiDzmCLuouA/6/UwwG?=
 =?iso-8859-1?Q?BFcQzGrbOU5x7oHS+ZIlahokJ5bZlVgy4grk8mJPVzs1h6EbRsQHg/USWP?=
 =?iso-8859-1?Q?vvQn3dOW51ZEXpI5vYwMUPbL6diD6WTZooo17yjW0fcRUV4+jRLBoP/A31?=
 =?iso-8859-1?Q?/NF0uJUUZeAKcI00013xG7ODZH0Hi+IvV+E5QOcaMapYhVraKolNpDgAWG?=
 =?iso-8859-1?Q?6/EVs7LgclMPpKzh+C6jdUgOur1a36FKeU8zDOpgEZ0C692w87s9shTvcS?=
 =?iso-8859-1?Q?X4Qx/NudginS/ubIvpsVX3VpUz5PrTw/35bqaGRwLTr6tMv3OEebRBRxxm?=
 =?iso-8859-1?Q?gZheCf/TXbRRLZCBkT/J0FMB8zKCYDO0QXGSX5HrA2tA5fVWtgtFFWvKvJ?=
 =?iso-8859-1?Q?JeOlJJcpb6jpWvp4bhDDSplGGsDrWEQ9k2il3X1e3HOKw6z2V6q8R8a3zB?=
 =?iso-8859-1?Q?titk6YH4F9oAgTc1hxV8aztxThpukcvScFJQGZnN2rv/hd++e8nBt+pYrB?=
 =?iso-8859-1?Q?CKHRvSUF1W1KTAw7ik8SYjrjK52TpivbFLRI2u6b9wnlPuyKzF/f2VcgxY?=
 =?iso-8859-1?Q?vFnMJgTOp+2Qy52UyFYhN2TEoBfZkq4dhBLM0Q/+9R5rxMBkzoZNCfkm3J?=
 =?iso-8859-1?Q?6LgfogjUQedlanXhWbKR94M/GYTGNeyWSwYn6GZiahMXukm1+g7PR3Jjjv?=
 =?iso-8859-1?Q?kH0ZauGj5umEzBfFV/QKDG5QoHumYlIxb+b4Z4mbDPPxxmgi6DShAzHa2E?=
 =?iso-8859-1?Q?lv9dxkth4Umr5ThCGH3AHdnVizP8Etx/qj8cBTeARuk85u3aU+wIU7idz0?=
 =?iso-8859-1?Q?O8nkLTkUSaivBd/aIlK6VW4rAXsTl+1IUkp3GQ1OPjacS7u/rkzuFbc7gO?=
 =?iso-8859-1?Q?h3SJMu+C7dAHTnav3VPF2/+6pvE5uiE4a3c/r4X4dSzpQUtLicfjA6eOcF?=
 =?iso-8859-1?Q?eHojVJJfK++DdL0yGj9Gtl+WbTsEo+UU04bHMjguVHEZ7AXIz0jd/440b8?=
 =?iso-8859-1?Q?Ly+Dq3nv3xGz0/4JkDiIZ7Qk7B8zcJJkSFUOf1q4PedSbCLmG11xxMfQns?=
 =?iso-8859-1?Q?E8rL3ynJSQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: TdaZ8hwUPUXYT11QzPY6dGT88FN1j2lr2rlFR+904EO6vwqEQCK+tebtgaVrCDjWA6Kq4h4av646hK66YUSNUijfJhIly6KmkvP9OKNkNZLfiAkclO3VOrTBSkwxoBmHPSoH2q+vKy6WwIwdoyaHkAfdZSee9LMbUOHyKt/cQNOuUt8hwUZfLAbOYh8Cs7xHpcxUtaJJEYwR4Oj/08Z1/N+8IZezy16Co/W6+DItjZIg8/D1H2CRpY8WRlqxpI6DNNviawGARr0vClyr7GZE1iHuodJwAAR4KixKJc4eOonNgtY9/XiHgFCL6m4IKDpO3osKEOpSrKYb2zRKUNfDYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e96d6f3-2756-4069-9d67-08deac04fc7a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:50:55.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ecq+wUsuChxDqND3Ax34cWd+huMELRDM1WG+2GvRMdGZg8F9m0BNo0XgMXjbqHpm8trkKe9JO12pniUzL/WHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 5A65C4E3BF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244516-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:31:40AM +0200, Thomas Hellström wrote:
> On Wed, 2026-05-06 at 12:28 -0700, Matthew Brost wrote:
> > On Wed, May 06, 2026 at 11:36:36PM +0530, Ramesh Adhikari wrote:
> > > The xe_vm_bind_ioctl function accepts user-controlled num_binds
> > > without
> > > 
> > > bounds checking, allowing arbitrarily large memory allocations.
> > > This
> > > 
> > > follows the same vulnerability pattern that was fixed for num_syncs
> > > in
> > > 
> > > commit 8e461304009d ("drm/xe: Limit num_syncs to prevent huge
> > > allocations").
> > > 
> > 
> > The difference here is we issues kvmalloc (2G) vs kmalloc (4M) in the
> > sync case. So still possible a user triggers kvmalloc over 2G...
> > 
> > > Add DRM_XE_MAX_BINDS (1024) limit and validate num_binds before
> > > allocation,
> > > 
> > > matching the num_syncs fix pattern.
> > > 
> > > Similar unbounded allocations exist for num_mem_ranges and OA
> > > n_regs,
> > > 
> > > which should be addressed in follow-up patches.
> > > 
> > > Cc: stable@vger.kernel.org
> > > 
> > > Signed-off-by: Ramesh <adhikari.resume@gmail.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_vm.c | 5 +++++
> > >  include/uapi/drm/xe_drm.h  | 1 +
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > b/drivers/gpu/drm/xe/xe_vm.c
> > > index a717a2b8dea..1ff66874f43 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -3841,6 +3841,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev,
> > > void *data, struct drm_file *file)
> > >  		return -EINVAL;
> > >  
> > >  	err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
> > > +
> > > +	if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS))
> > > {
> > > +		err = -EINVAL;kvmalloc
> > > +		goto put_vm;
> > > +	}
> > 
> > We had something like this early Xe, IIRC, the max was 512 but we
> > found
> > for Vk / Mesa they will a huge number in an array of binds. So 1k
> > likely
> > isn't enough and this patch would be considered uAPI regression, so
> > this
> > as is a no go. Maybe we can figure out some reasonable upper bound
> > (64k,
> > 128k), idk.
> 
> IIRC we debated this back and forth. The challenging argument was that
> if we consume all memory we'd get an error back, which is sort of true
> but then we should've really made sure that all memory allocated was
> also accounted against the cgroup, with __GFP_ACCOUNT. We only did that
> for one large allocation.
> 
> But I think we made sure to avoid future regressions (functional, not
> performance) by requiring UMD to handle -ENOBUFS, meaning "split the
> array bind and retry". So whatever limit we come up with we should not
> return -EINVAL but -ENOBUFS. 

Yes, we can currently hit -ENOBUFS on large array of binds when we run
out space for instructions in batch buffers programming the bind and
Mesa gracefully handles this breaking down an array into individual
binds.

Matt 

> 
> Thanks,
> Thomas
> 
> 
> 
> > 
> > Matt
> > 
> > >  	if (err)
> > >  		goto put_vm;
> > >  
> > > diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> > > index ae2fda23ce7..804ccb23b11 100644
> > > --- a/include/uapi/drm/xe_drm.h
> > > +++ b/include/uapi/drm/xe_drm.h
> > > @@ -1606,6 +1606,7 @@ struct drm_xe_exec {
> > >  	__u32 exec_queue_id;
> > >  
> > >  #define DRM_XE_MAX_SYNCS 1024
> > > +#define DRM_XE_MAX_BINDS 1024
> > >  	/** @num_syncs: Amount of struct drm_xe_sync in array. */
> > >  	__u32 num_syncs;
> > >  
> > > -- 
> > > 2.43.0
> > > 

