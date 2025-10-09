Return-Path: <stable+bounces-183710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E50BC9AB2
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE273A56C7
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C862EC092;
	Thu,  9 Oct 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbZUTQr6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F864A06
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022025; cv=fail; b=osxfGQ2BUOVXJcSjo0HyiDee1YOWoArfaRttvRmwVV0zkMj7TzDBpI2Q3LOOsmDHSY3N9oUhC2Y+b9LllzqlLjt+Rox6heldOD1d2F3zAs8TZsOpjfiBjVysFh5QPHNSVqBsgQG8amAKpNBTUm4nxcunEa9mT9WqRge9OpVe+ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022025; c=relaxed/simple;
	bh=pqinQ7CZRP87dX0BWPA7ZT/DjOjzpqqYeaAJqOn232Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L/lDo/BIbER/ksayFY5rsaWqhLKd1sGBM4/E0spXFp3x0e/+RIO6SJHuwhbXpwTb8s0f9tqO3NdHPJL0BDZJt3xK2CQQvSSwmdrt+M01+FuE93VFjXn3RzocmpEs+wHwC716eWiLxgp6iOdmhY+QWm+/WZrCeFJpjOWeQWgK+Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbZUTQr6; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760022024; x=1791558024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pqinQ7CZRP87dX0BWPA7ZT/DjOjzpqqYeaAJqOn232Y=;
  b=IbZUTQr6Ck2m/yDKdK2ZYCMm0CaoGzL7NGWCl40/0p6oVHCDRjBRQ/0e
   Nchr8aJL9qRKphSIf+PkHgUzJ7tyKKZOtnoDwG5c99Weus3jDv1yoYGyu
   F9QlhXFzVLCuuwtLs2e5gToXh9t0+nECX6Viu0ffXsb8Fqqf0o1fJ/n/L
   QhxI8pLG/bvHtyagzt9+FAQGj07Mj9j4z9laIuKWeyTDV1LfFjtjzu1Ll
   kUC29HNiboAm1erE2G9i2pRROsOhkM7VeNDv3S3FHJuSeVpFOgqr/yAAM
   zPTiewj6RygVRyqBNckPPF9HbRjT0KLExPGVx574zCwTnCFgbZRni7wUF
   Q==;
X-CSE-ConnectionGUID: kPfeFKQ6SmeUBMur9xEQwg==
X-CSE-MsgGUID: tW2Q1EJcQwGonn1mriF44Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62174962"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62174962"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 08:00:23 -0700
X-CSE-ConnectionGUID: 9/imFzxcRGqdpI/Kb7CYbA==
X-CSE-MsgGUID: l0neK/KCQnaRM4QlcpFCwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="180749125"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 08:00:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:00:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 08:00:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 08:00:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMwgzuhCcv5lZ6iPkoc1m5weEIpVnrHxgB80zG6gB6NmS/ix5JV/T1oLU/NQgPuI92bsUJhIIOkNHaV5ooQ9p2eMNQabG+leQOklyYKFJMStj0TxV5Ee2/16JbhDnLmZ04rzzxtumA7JpcCfDs/S4HcpwwlGSrbo7lKKFuK9gPp9E+joKTO8UC2d8zvYOGCxTgdkxIkVgvZwMe7kIqXe/IC4+iX/0iCPg4gW9m4tnXfIgDYv+/d/OgQUZU58ZPiJtNapanOw8ANwgSO7m2vgh2DJZAmzVfucP+mSkpfcrRp2jNhyiIQEMJ4Urucz6/nrW/VKOK3rdZ9lCJlL1rTokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARmtq7XVC8xUruqQ+eA+iQYUnWzrbKDvExMHZ8wdeKU=;
 b=s+79fzzebEiUq6J/3NHciPkE28bXutCjfouZqS26Wv+wzxqDKfhId9VPPuu7mlcaWG7aLcSPraTwKJaDxVWrza0wmfQgBNh7YJ5McTMWGiFde/STdmJPYoQ8PbjVeFGSbzDEMlS5CKEFOdgL4+J7fQ+3FZG/nF8RentenJc9Bb/rHsKYvDYoK21XC3f6QrAhezFmBo/uUlQhe8sP5BraBCGxEovbef+AtkKg/9ScPYr3dr7qfeGm99TN66xmKwGJjDbIDZyX95IIN+ZGUwnZoegZZQomRiMr4xDhp0Qk/GBcohaR50kst3cIRaDz8jyI4d5QaPjjczhxrDrxUxwRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH3PPF5AF05F6D9.namprd11.prod.outlook.com (2603:10b6:518:1::d24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 15:00:18 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 15:00:18 +0000
Date: Thu, 9 Oct 2025 10:00:12 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
CC: Kenneth Graunke <kenneth@whitecape.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Maarten Lankhorst <dev@lankhorst.se>, "Auld,
 Matthew" <matthew.auld@intel.com>
Subject: Re: [PATCH] drm/xe: Increase global invalidation timeout to 1000us
Message-ID: <364ldtfilw7owntwdb45qxkfzjhfzbv3wajddjtjtptdrrh6sq@76bwn5y2qbnh>
References: <20250912223254.147940-1-kenneth@whitecape.org>
 <DM4PR11MB5456189485C6F8A8AD53D6C0EAEEA@DM4PR11MB5456.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5456189485C6F8A8AD53D6C0EAEEA@DM4PR11MB5456.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH3PPF5AF05F6D9:EE_
X-MS-Office365-Filtering-Correlation-Id: 996eac43-a117-4fd8-0453-08de07448f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iJclXWcrA/LIdw2gp8OlH5yYqMpZkxtdw0Ed9n61CLR1jj5nylvp5GLlSyh6?=
 =?us-ascii?Q?KN48PmWU00OrLuuWssozQUnkyItCGpAh6zrLL0JzeRt17eb00Ij9cA0KGLtV?=
 =?us-ascii?Q?2fsV5qrw+LV7lhjtmPSlWzHZ/LnGAN5sYXgX1MIpamYIvhTUDWkIOEoGPpHi?=
 =?us-ascii?Q?w5DGdhjrRfmI+fcyqe1gZcOCd6Aaldl0x8rRCxAzybmB/rLqQzH2YI2s5UIa?=
 =?us-ascii?Q?5BBUEBNs8NmEm7+6vYhDhhULGQI1I++XQcwTqsaDoE/FgdvqtNw1lnhj8Lim?=
 =?us-ascii?Q?Sinb50yM2ZmRvcQLAjWG0yVRkHAqB86PoJJjZ2Kp4Z/I6v8y4x/aGyAXAaYU?=
 =?us-ascii?Q?UVeYwO92kEqf1Lxt1mSjC7SMhDSIWBDbt4n77qypdO/8JylhkYRLhLvVIKgK?=
 =?us-ascii?Q?xDweZQMkybVRlwffDGv3F+SOJMAHJuoZaSHu96KBQD4SEpkBsQMwVbOctGp5?=
 =?us-ascii?Q?oRQpSn47IEW1utsUIhS/u8v2Ij7LmY7cS520zjWijv5xlHsjmkqd7f53PoOK?=
 =?us-ascii?Q?kPb8DqQjnNHgE82PMSVFDpbBTCQOBXJ82mSbGOaQIkvpJDY516bXlEbu86G2?=
 =?us-ascii?Q?Ry96DQ0CFQXHk6L7hrZTfW9GknCJjx5cMP5Qmo0y028tst+jK6KA0Ajm3wwc?=
 =?us-ascii?Q?AyRHTLvmJSxCaZUJ2wvJuplV6PGFfmy7ap2x0MRBrifOyJYXBYPXgobnp6C2?=
 =?us-ascii?Q?2Lvi2+KBifVMQcgGTVPZxfMOPhq9VFuQtHzc21h6Q+Estr4rzIyE+XS9FV91?=
 =?us-ascii?Q?109sj5JBSr32pu4N/BZ8ahO/W0ZrvPzL8f3U6Wd2jIF7SHIHp92hvRR+cKWu?=
 =?us-ascii?Q?9xtybNZJ0yypooeVDEw0+1B/67hEo1XmNKwMY9tkC3SqvwWzta7sWwIz0X5s?=
 =?us-ascii?Q?dIVTEiDOtTWf7IlaObEPL0RozBGjEhdSL7KTClVUIYHios24kxxNVbGJXc44?=
 =?us-ascii?Q?CnHO2mFy/0K3W59M60EgR13MxjI3reioSis/G2CrcATNtTh9I7ZLJsT0VMww?=
 =?us-ascii?Q?fv20qTrmMdohxW6ywfereWgQK2mHYTQUG0KMqsR5jqSodG6CZtggQCfmK7BT?=
 =?us-ascii?Q?rzj2kVBAIf013P7OX3djImEKg0fyxjJ5lTQNw2SZKct/b4Bl8C68Tj95D73W?=
 =?us-ascii?Q?d95sUzKIGR6XOEJyf1LL5h74Dp/I2wubTUqi5WfJENlfKmnkUFlTy3lRLEk5?=
 =?us-ascii?Q?jPFH0D1RdY4U0iZ7+2RemqqkxtdANvWoQtIWgemoSRFUKkEc4mojLOOOrbjj?=
 =?us-ascii?Q?yBTPPiQ8HCemwxqR+SeG3/ZdWqjt+lnBcL5p6VWqM3emNoGH3bHOOn/BT03A?=
 =?us-ascii?Q?sRO8AcqSuCjAT5fMZnQ+aDyC6zgqzWW7aP7hHL7b0T8/VQhlSa+nNP2/9LV9?=
 =?us-ascii?Q?adMB9ZCPlFXS3stwcoXYdlpJXn+dIPCNgzMJ/8bb7CWu7QV85g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmoMKY2ljZXhALzH+PRdh6Z641CYFx4tKZTlMZ3AXKHUT0VBi1HPFTR77IsC?=
 =?us-ascii?Q?gkPPuVQqdWG8AGRkHD5/r4N5GNjkQSSKjUiwf2GGSSsXa8WEwHjS/IDSNq4o?=
 =?us-ascii?Q?9brl6dOJ5pXv5gOQ1VruQChTS4qvmg4qtSC8s/AMkGIl6wPTDAPJqBaZy0yw?=
 =?us-ascii?Q?QaHmkt+K/WOKgPgnh4Wr78u/xmdUTRf3BKxDS7er6Cpoql0UeixnS9UExdRz?=
 =?us-ascii?Q?2e6wsZyFy/s+H1zcqBgrhSDFOjq4Ct3639+9ixD6cUjJio8k0iGel8aYCMtp?=
 =?us-ascii?Q?l/ewGaMfWPMsHxx78K6q1mp2orVDdPreb9gU6JjR3rRwTcbKizyTKFzNrs1y?=
 =?us-ascii?Q?Pz84HXxsSvJyR/SK2IV76q78TGgu+vb/vHQi4BNPQdFFwgADS0OTmQ9x9IBY?=
 =?us-ascii?Q?fKxrz7vFwNelB6cq0WsSDhx1icFpschou5ID7ZCDevTijjypqaqY964aJOZ4?=
 =?us-ascii?Q?YkycAXt8GKA9TadJi9l7p1mnXr/Mo7XRs5TWFHOxYT2CmCybg1TUekpIIEcJ?=
 =?us-ascii?Q?p4Oy9TB9id0tZark9h95VBsAiHTSPgxgZQ8/YfsY+4b7fC8K6T7ZLIViPuMk?=
 =?us-ascii?Q?V5PAWKEEz4p7vhipvnsGei1SzqUvTP0jycKCZvWGqAgvEOfJVsA+e8E2dV2i?=
 =?us-ascii?Q?TJVS+BKyWtD3rue9ZVpkjqwmUjJmgdTqN09Rd92y/oL2R6ljlHPJCcMpuSz3?=
 =?us-ascii?Q?8Qea0JM2I1DWa8HfQSFhsUVIQ/zOqotiOjuQKJYJ/VJev1jhSLUc/hrBa38X?=
 =?us-ascii?Q?huyOJbQgLxhYvlAvsbPFU/h/nXuTz9U2kZofqD2vKIqSyaany9HcaAmMpQf0?=
 =?us-ascii?Q?BRNxSKEuegGE6wsa15rybutsprLqjvWq5apyLRJ9SOO2TNSMLv5QmO+cb0WM?=
 =?us-ascii?Q?phaAoQ+lYyXirYUGoEMJd96he+tfIlle8wa9N8dk57ByH6mTIWQLiHWFIQiK?=
 =?us-ascii?Q?be1zH+Gh/A+Y3JeEqBwLgupNleOrtmzz0HDHa7F58QHjskwZLAuK6eAH2b6v?=
 =?us-ascii?Q?nlq5VToanhQj6FZ8M8FtfE+nTC/FwMDCYU2tUVUyjQSLLQN/DdDM/CsEaTFL?=
 =?us-ascii?Q?dk7Iatu/c67OzaSEiXqojsvRdtaMzt/JMl4OS/oWjZn4s4bs0Z/YugNffLag?=
 =?us-ascii?Q?WpNsZubCFQWkRmBhH+YkZPb/NHan2HMjsLbdSdWBXBBZIIdkoKKVlucFh+2p?=
 =?us-ascii?Q?k1HVsN1cISjyKDSFZeYf/mhoIbl7TfpvO8w/kN6g9tzeaES7VgyZ0peBuGKd?=
 =?us-ascii?Q?waVJvgJ43CagsL42wbmMjCSGvE2o0vj2S5EtxWkqbuOJXcPOtiANKZ/TTopJ?=
 =?us-ascii?Q?CCLX1B6Z60zKSb9bgqif6GEooqQ6hVXyNtSxmTQaT4ylKzH07FjT0b+I6GFU?=
 =?us-ascii?Q?732/kDXI340NcBULU5z4uwz1JijTvbG5zoAZpu/LJoy+R8x1ZPrXvBIKIPNO?=
 =?us-ascii?Q?lx48Icm1FKQFon2I34lfhAwfqwHtSKkEr4TPe5B+wts+eIk96TzqBjPdo4mK?=
 =?us-ascii?Q?2odMlnthw2aRWHVymy0zQwciW+JoLkBCNHZfVY0rTWgsORklLNFcyloZo2SD?=
 =?us-ascii?Q?z+KE6lXgQcOcV01n/+ucXSQVgJRgQyfWVIKB8YcNJC0OwNGMil1lcNvVgKbA?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 996eac43-a117-4fd8-0453-08de07448f35
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:00:17.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUK0T8Zjum/Af16B1C8OGAZKoa3fcr1ejDitNjAQMGK7+4mqHXkS3s+4mMwfqh3FCEuzseAFD7cfxje6oiSl3xRSLMiC0IjlpMtmI9YxUE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5AF05F6D9
X-OriginatorOrg: intel.com

On Thu, Oct 09, 2025 at 02:33:09PM +0000, Lin, Shuicheng wrote:
>On Fri, Sep 12, 2025 3:32 PM Kenneth Graunke wrote:
>> The previous timeout of 500us seems to be too small; panning the map in the
>> Roll20 VTT in Firefox on a KDE/Wayland desktop reliably triggered timeouts
>> within a few seconds of usage, causing the monitor to freeze and the following
>> to be printed to dmesg:
>>
>> [Jul30 13:44] xe 0000:03:00.0: [drm] *ERROR* GT0: Global invalidation
>> timeout
>> [Jul30 13:48] xe 0000:03:00.0: [drm] *ERROR* [CRTC:82:pipe A] flip_done
>> timed out
>>
>> I haven't hit a single timeout since increasing it to 1000us even after several
>> multi-hour testing sessions.
>>
>> Fixes: c0114fdf6d4a ("drm/xe: Move DSB l2 flush to a more sensible place")

it looks like you used the commit hash of the backport to 6.15:

$ git tag --contains c0114fdf6d4a
v6.15.10
v6.15.11
v6.15.5
v6.15.6
v6.15.7
v6.15.8
v6.15.9

I'm changing this to the commit in Linus' tree:

Fixes: 0dd2dd0182bc ("drm/xe: Move DSB l2 flush to a more sensible place")


>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5710
>> Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
>> Cc: stable@vger.kernel.org
>> Cc: Maarten Lankhorst <dev@lankhorst.se>
>> ---
>>  drivers/gpu/drm/xe/xe_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This fixes my desktop which has been broken since 6.15.  Given that
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6097 was recently
>> filed and they seem to need a timeout of 2000 (and are having somewhat
>> different issues), maybe more work's needed here...but I figured I'd send out
>> the fix for my system and let xe folks figure out what they'd like to do.
>> Thanks :)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>> index a4d12ee7d575..6339b8800914 100644
>> --- a/drivers/gpu/drm/xe/xe_device.c
>> +++ b/drivers/gpu/drm/xe/xe_device.c
>> @@ -1064,7 +1064,7 @@ void xe_device_l2_flush(struct xe_device *xe)
>>  	spin_lock(&gt->global_invl_lock);
>>
>>  	xe_mmio_write32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1);
>> -	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0, 500,
>> NULL, true))
>> +	if (xe_mmio_wait32(&gt->mmio, XE2_GLOBAL_INVAL, 0x1, 0x0,
>> 1000, NULL,
>> +true))
>
>It should be safe to increase the timeout value, since xe_mmio_wait32() divides the total wait time into several intervals and checks the MMIO register value in each iteration.
>In normal cases, the actual wait duration remains unchanged, while in abnormal cases, the extended timeout is necessary to handle longer delays properly.
>
>Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>

Agreed.

Merged to drm-xe-next, thanks!

[1/1] drm/xe: Increase global invalidation timeout to 1000us
       commit: 146046907b56578263434107f5a7d5051847c459

thanks,
Lucas De Marchi

>
>>  		xe_gt_err_once(gt, "Global invalidation timeout\n");
>>
>>  	spin_unlock(&gt->global_invl_lock);
>> --
>> 2.51.0
>

