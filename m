Return-Path: <stable+bounces-41756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCA28B5FEE
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0E01F21109
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1318627A;
	Mon, 29 Apr 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RK1u8kJU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3E86626
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411104; cv=fail; b=rtDx/kYDeMWJ6Mhn4RQOq4Q818JJgv9BypaGVimnIL2k0y58pNCAnbZs8ai4vKoMddziG2HCYyWoxH3MXbmEzUFt6X0+cvci0ZQDbUVWaiio3LEaJOk/vTA1VFa57nc3kscRIT/MWOfbrlo5+LoxmZzNo5sG0mBz+VMhBXNEW/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411104; c=relaxed/simple;
	bh=pzZ9MnY3s8l6A9CWQ9rv12zFcBoFjmZORzOvQfiSpz0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EXDQPQywbkSjZ2MNmvu0BnanSnALKSzYpWkIozse6vb/UdJMXuBRN1s5kzesRoqjzwy2h86AkMbOTbZVch2GmK5dMWKdVjd3vG396xTUfyNTQAlVM0XPObsif9O7dclq4muKoy22O+gjhigeMeS7XwuR17xzSRGpyMk8x4ZwffI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RK1u8kJU; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714411104; x=1745947104;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pzZ9MnY3s8l6A9CWQ9rv12zFcBoFjmZORzOvQfiSpz0=;
  b=RK1u8kJUUxiNrZhyItdwm0ApuApVYkUG3asMndnX1cwvDhE1uA6lWBXl
   97cRzDkZj0EY+90oRk4e4K59wRxd+GKn1fq/ceDRBD5b55QnG0efYP/xC
   hgezp21cKM4b1OUd2xTJCAD+QxhI6B05Av8O0qibW4tly24mTWDvMrpL8
   1LHBdP6aScSYNcHWQH2uK6bWOXA4GAa9+ynWNfxLZ+ZI8xvd68jcIXyU0
   qK3zVQds3QaOjch4IAK8gwL/d1uBMrQIiYZvH6mVqFhsd6A0dRrxmf4s/
   58gMbmFSBES+uLnegTRgwyZHs560oSjhJJbKBiYX2xxRqOaM1fWg4iw7R
   A==;
X-CSE-ConnectionGUID: mPMspa2GTKKs4oMI7dO/JQ==
X-CSE-MsgGUID: fvomjJADTLqnZoTLujdZmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10253246"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10253246"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 10:18:18 -0700
X-CSE-ConnectionGUID: q9EUssBqToyGLFVHxVWYhA==
X-CSE-MsgGUID: MVbqtt4VTkexMNpbBnMNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57368902"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 10:18:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:18:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 10:18:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 10:18:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:18:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdYvCSTiVdgyT00GEAS1TZweEjmGlQb3SIFeJW+rXQPim+L1N6s7RshyoFlH9AOBCBk2fBidYGmFuoVvaN2VtRai1qcRn9g5cUec7tRQz1NiIlxG6QH3ZgCcauXNYbrcM4JR1ELp7FH+ICRSPLv8tvbVSk2ZQ3ww7hy8T//idWtxhLNcfkw5X4hQYJLDoEn5EqWlG321Z6zpPZ6upxJXk2X+73hLOpNXafgxnF4ZkM/8lqqZ6eLqcOeUm5bEMzzwddfDPDnH6OKbmgezTGYJcPJHsZnOfZdk+qi0hAKHDGtlxOHNt6p1ZVFkF+QepJoUQ7olqwKfhrbBX0XocddYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNY7msVA2bHnI+v/12O43r9nSEEAmdByzAlYWXAET94=;
 b=jCQeCQmqZAe9EW32eAfYBDIhEtW6nAC9x5OJZbWFzRNqKcfpaSwPX0kpdJIALg9kngvD2E8ywv+YSaewrDBYl4YkwhKCWWCPQXWe49zzq3+8c61Zouj+5HJQI92yuaLmCwiwuQ93qGtEI3VsFcIh/lREGJFnCjdZeTIaN2fIKNPeHKhmqWmSjwKB9+VbZwLG5y6LapBacr1VZWqqmVPHyzyU6pVr1mA48dpDaoB6hVEwuwmW7B8K2J+dYbfwgojPJs+0neTtqFlmUTuQPvGhPqJ5HAFgj9OHlB++Oj5VJsbZ9EVTy/+QNR16VNpnnlr4eTNISNoB+dTr+DqhWgLAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 17:18:11 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:18:11 +0000
Date: Mon, 29 Apr 2024 17:18:01 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: "Zeng, Oak" <oak.zeng@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Message-ID: <Zi/WSRbYmpZtELhK@DUT025-TGLU.fm.intel.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
 <SA1PR11MB69916393B52812A5D25302D9921B2@SA1PR11MB6991.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR11MB69916393B52812A5D25302D9921B2@SA1PR11MB6991.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM6PR11MB4628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd06ddc-7c73-4d36-d159-08dc687058a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5IhkyKwJ0kdUjCIBDhnc7921G4GDX/PPf9s6MZZTUp2ZltBuxt1szbY2WL?=
 =?iso-8859-1?Q?Lib3CfdKG4d/0yDBAzd5MYwdF+IrmZoHA41r2SAgbmR0C9IEkun5+Avn+l?=
 =?iso-8859-1?Q?Hr2Vk4ycR3L6uTnswTmxa0H0xYsPD9bb8zArnH9fnxnGW2EyplLqF6OAQz?=
 =?iso-8859-1?Q?vnjKNw9QO/fDOs24BLnhioWmq7wZcNomKosVNiLL0lseoGYAmuYm3p6ynY?=
 =?iso-8859-1?Q?0lqtDq/ARfJquGLokTlQJ/uuKYwc9yQvXvrgXowD1EQydcdb3CJfvn3jr0?=
 =?iso-8859-1?Q?kUtcuO/eV8zp+V1zDMEC+t0YVd4QC2kaC96c+brkn9KV3tN98/0nUmFUR1?=
 =?iso-8859-1?Q?PEREXRpKRh5kIreiIpXtACUhkRs3V3nSuXheMHLdkYfztDpGZVv960UcrN?=
 =?iso-8859-1?Q?LPFQAHROexUjXNXBIfLOSfWVxUzUSsQmnymZW08Q4uFFnCIGzrKJbS0ZC0?=
 =?iso-8859-1?Q?M3FkIvgFjv6XO9sbvBjbZfbzKKIpu+pcy1sJvO6L17MiabueYm8ma1WbyL?=
 =?iso-8859-1?Q?M7zLVpF6A+3qxPg2bzoIwsZjydjlkjeyZsUeXe1V+i01fvItfS62yCBnAc?=
 =?iso-8859-1?Q?KpBioK+kYEwt9ADo5ltQ79NF4JP2FnvRi+wAxYomrcD4O/AZyp2vIY8O7E?=
 =?iso-8859-1?Q?3mL+oXqFM6Mr2i9Otpv0UhriDX/Tob/yyqaMDR8pgoegmTdTLQVTg7hAPz?=
 =?iso-8859-1?Q?/em9c+Lzso1RZhwzodSSlLcE5NhTMmhaqI8q/bp8ovMo1A4p8Zr+B7wEl7?=
 =?iso-8859-1?Q?bDKNENgUZIZuDNvluTVooFcEudqcWKVuFzsepRUKyC45qqPSVlDNgraWji?=
 =?iso-8859-1?Q?zrlYjGaZ3KVualVVhajguemaFvUbBiSUgeFP0Hxp+MJnyJi+M9t3uuc1Fl?=
 =?iso-8859-1?Q?BSgKfeg51q9p6V9oYcIi4RgnHNgwUg50eAdb1TZYPdTkXo+Yu+ngUtdPBn?=
 =?iso-8859-1?Q?IVNgKiZ5ZDtF826u0K+0Txw3JvKFqRJWAaOtq+LSyi9/MejLZDjRXncPa+?=
 =?iso-8859-1?Q?m8p6jPDsEAvdWo068uVIN0OSTNzZHjHx8XFDusk+1zenb36KQMr2BuxVF6?=
 =?iso-8859-1?Q?vNhGLOOltAkKAly1Zd3thdCmqhDbTe6FhG3pVhG7JdW97YaHrUm/ecY6uS?=
 =?iso-8859-1?Q?mN29cKrjf3zJBrr5cenc1k17ybPy/uwzO+QXdG6LHVIbDHrV0zUof83pb0?=
 =?iso-8859-1?Q?alKk2gRn3UZKfl42/6TGXBDBjosIqrbc7eml/IeJeMVw9iAXoVMCNvj2JL?=
 =?iso-8859-1?Q?UiZwAk7i7hdaZt1jjFDNCqlp12p1qVAvF9vP8mF4eH/1jbun0Z2T/ZBuJr?=
 =?iso-8859-1?Q?jVdE1dPwqJWI/8OK0fk/jsASIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uMOUh41Pg4t3jE+mvrvX5VW+EIob2/FIRRNdTmevCYBMF1LsT/F5pXna36?=
 =?iso-8859-1?Q?FLgxYJvcCjnSKShI/xXBliaZ6sRWk6gkk4+fh+0dwWFFgOuNC7Swu9NPZu?=
 =?iso-8859-1?Q?m0I3sfBkst2DjeG7P8lQA5AR5oqFKu4oPtGMZIyrtlNqfJBPQfF2+UixYq?=
 =?iso-8859-1?Q?L/OsxypEy8k8N94EXQFrOTqT+i4u7pRjdghDstLCLkb7H9OpT2PZ71FF4z?=
 =?iso-8859-1?Q?cI66vt4LLza0hHHtPggqgFN7fm0P18YzUrjZ2Km58YxupQVVXydNGupjyO?=
 =?iso-8859-1?Q?r5sbWqKckrUxiWbambju9bkBZaJ0tCVHRe7mxIDnaukndZ0At1+yuet79g?=
 =?iso-8859-1?Q?DOZhEHiC4WwbIpIlNTK5nyUEZaX4lQvR9A8ErYUWkUwKYTJiWwMfXJRM5w?=
 =?iso-8859-1?Q?DDJgLiL4Jp5IzmRCel5eFJEnq3R2liVLU7p7V64+C6yCFE+Zz+Zma+ezZA?=
 =?iso-8859-1?Q?p5n6gTcJtyQv2M9JSu3NHmE/WrefqnUH2N5ruwJHo+OltzXxwhWWErcC9Z?=
 =?iso-8859-1?Q?yu+TH9PaYrfeL70q6pDbiKfXxTzhY2PvSVZ8qbXtpTBCFVnxDFNNXu584D?=
 =?iso-8859-1?Q?vUuuLCixJXlek4oiZnVjg6nEVG5QI4r16NAKPLeCYC3ByNlilb1xqWfG0b?=
 =?iso-8859-1?Q?IOy4bXILn+HLJ6XMettULAMy4ZrKhtBrNKyhq3ZCD2PdkWrcY3d6d8hIdC?=
 =?iso-8859-1?Q?/cg0vj0EWzUyZdkd2bnd9rrtlmrzqjZTVFu4tlnFvVtqAAPsxj7qkavuLl?=
 =?iso-8859-1?Q?Tk8sJ4A3A85UzZYWC+0NXtkte9kakefwdBEAHltnvsfYqrRWoN33FCLKXC?=
 =?iso-8859-1?Q?7xH6mCykrbtu0rJ+pMjdivywvrIrnCq9tyB7xS1hi6XS+Hfxp5Cf4Or6Uj?=
 =?iso-8859-1?Q?QZlCYW69WQovIuwrkO2l4wUaM5qc2MJi0Kv1JMl/sggLNcfZinT6u79Bji?=
 =?iso-8859-1?Q?CjBGzwL2HweL+YUUls7Y+J5CixeATHpPOO4vpV8fwebF7oFn291cFzb/lx?=
 =?iso-8859-1?Q?IHR/nkOK9hfLY4o3ooX0JAx8yoIpgfgPQ8VfdHBOx55fmR7tuFPlW3fM6n?=
 =?iso-8859-1?Q?4zLGj9rgJcd+rSgaC5RxRZNi3a9NRPuWyLC3d0LC6lF+i6eo5On2zG2mSE?=
 =?iso-8859-1?Q?fBLVPm3Ygmcsv4WgaC3LTIQD3KQcMdDTb01FQCO2RHupLcZZmVfMGmjmlF?=
 =?iso-8859-1?Q?VS4U1TqbQ629WxXWzKaErQNo333IY8I9XSHlGE3aVFaZF5NRyNoKXuuWbN?=
 =?iso-8859-1?Q?JMtGG2jDN5A4Mc5FZDyhtzOPO0z74+W3lzRRR/Bw/c7qPTaeQWAIBtbG90?=
 =?iso-8859-1?Q?Zm4mdJ5NYqTggC3iIxRQ1IuwF+pg6+9s8ef2L1l/bewc837CEbbbRNWzaH?=
 =?iso-8859-1?Q?4QZ19/Tojo6lqGMnllrhSIKv0P0KZdTcDCpPViXNUxqe2hBN1kaLy6mJwG?=
 =?iso-8859-1?Q?n3mXxFkV6xaIG9dE6KiLYqeknAcD+4rs7OC3jE5RjdFTzZzTvF7b6AZus0?=
 =?iso-8859-1?Q?kDR1dpSqMErr6Pxqs9jwpJL2tmq8b7Dh3dSVnVXr8OIysg4YX6tRUxKKoQ?=
 =?iso-8859-1?Q?AGYQIk65W+0z5quPgP1+7A7Hh3xQgiI9XhktJfUFYV8N0P41anieqbVbA5?=
 =?iso-8859-1?Q?HXWDJLFlaDrvwvZHLs0Xof1Ln5Ga+JE+xxfkR+UKtqsbEXRDOinx5Z7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd06ddc-7c73-4d36-d159-08dc687058a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:18:11.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di+vzfKZ3lGZt3D6CP3qovj7JnG4F8SEMMWKhIbUAhAZPUnyf+79g12qjQllahJYKJ/qAQ9De3kTZMCy0zXDBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com

On Mon, Apr 29, 2024 at 07:55:22AM -0600, Zeng, Oak wrote:
> Hi Matt
> 
> > -----Original Message-----
> > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> > Matthew Brost
> > Sent: Friday, April 26, 2024 7:33 PM
> > To: intel-xe@lists.freedesktop.org
> > Cc: Brost, Matthew <matthew.brost@intel.com>; Thomas Hellström
> > <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> > Subject: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
> > 
> > To be secure, when a userptr is invalidated the pages should be dma
> > unmapped ensuring the device can no longer touch the invalidated pages.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user
> > pages")
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: stable@vger.kernel.org # 6.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_vm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index dfd31b346021..964a5b4d47d8 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct
> > mmu_interval_notifier *mni,
> >  		XE_WARN_ON(err);
> >  	}
> > 
> > +	if (userptr->sg)
> > +		xe_hmm_userptr_free_sg(uvma);
> 
> Just some thoughts here. I think when we introduce system allocator, above should be made conditional. We should dma unmap userptr only for normal userptr but not for userptr created for system allocator (fault usrptr in the system allocator series). Because for system allocator the dma-unmapping would be part of the garbage collector and vma destroy process. Right?
> 

I don't think it should be conditional. In any case when a CPU address
is invalidated we need to ensure the dma mapping (IOMMU mapping) is
also invalid to ensure no path to the old (invalidate) pages exists.
This is an extra security that must be enforced. With removing the dma
mapping, in theory rouge accesses from the GPU could still access the
old pages.

Matt

> Oak 
> 
> > +
> >  	trace_xe_vma_userptr_invalidate_complete(vma);
> > 
> >  	return true;
> > --
> > 2.34.1
> 

