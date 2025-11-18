Return-Path: <stable+bounces-195128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B8C6B728
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81FD04E55C0
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127482E9ECE;
	Tue, 18 Nov 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itDZbt3k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823A2D7DEB
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494161; cv=fail; b=QynVycRtKBANm161fc7Z0E0JpJmgyf85kIEl6G96gm1zqMFc3caCWwaNxm/zJPyVt9H2mgXsPqKLKrVJ2ckrUz8QUhS2yvtddGCXZ8czBb9g+T6ufn57UvYUfRmSxx6nd2ymnJcC3YkqhiCK8dS9Z0WwE/sp8Iw3LFrnSsPM4xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494161; c=relaxed/simple;
	bh=2lYZ/OIG28Jj6zXnP++TRgdDr4BEIjDOEhmpnndCa/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AMx19f0PaR7cm6MGig2pfYXBUDSCnWBmLNvXF1NW5rkPBXNTC2GrXq8d4sz5Wnbh9AgAHESJwjBbYrPpLWUZdTxIc+bLdQYqDColv1mejvxiircs7EI/vqHgT8utS9O+r3neKbkd8ZLenBLD0CQT10xdX6ua0HgPjM7WorV3wFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itDZbt3k; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763494160; x=1795030160;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2lYZ/OIG28Jj6zXnP++TRgdDr4BEIjDOEhmpnndCa/A=;
  b=itDZbt3k07s0PfQ9RtgvIxtPLT5b7/yvHdpBgR58PHoBM6LdOVPxE/4M
   fX/gn4XuiNbk9ytJ+wqZ4DKE6a29NMCoreHkQ98wiwZdVZJbrte6Z5MgC
   PI52AwtYU5zQxhpcz0+PNyzsrxqbM3g+ZbTunZuz8pqHfz5BrgLIZHaDN
   nL8UWPi5q658R4ljhDlxfE0ONwEkxbh5+lmBPi7YZkNflnf9aBq77ll2G
   +1/D9IlPOGMjA/wy2Gq7XgK33m1g3uDHHqRHWj1z+rOwwf8d5gGWKaMwD
   1hICfPmM0RvET7XN94sLyJbeu0jZkwroblrzVypKSai/mlYzLGv/qbyXl
   g==;
X-CSE-ConnectionGUID: eLSDk1xoSe+cpmbjo2+DNw==
X-CSE-MsgGUID: 3NaZZ7flSSy9ghkrWMqkOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="53099368"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="53099368"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:29:19 -0800
X-CSE-ConnectionGUID: aKndhov7QraoavuiTKgRoQ==
X-CSE-MsgGUID: AWHiCndlQMWa84g80qyX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="194958698"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 11:29:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 11:29:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 11:29:18 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 11:29:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/KE+9FtT42BouwwD66kbIkAyKy1i8fwzdOFnhshe57fm64B4QQ8uJixtdX6KUoJ2w9+iMzGBmdkYl4SCQescH7R/rXQV126iQg5h8wmkOF0WKJkFeNm9dOxT4jTu4x0zAJdM7j2AUd3TkvUgGPB53MTbrpVhmQrYhKRhMUpQrGqWTBaAvgs7rCECu1E8znSuZq59XmLpzkR9jjd+1mhgmrXlq+h/zUhwk59hufgnP2NrVBjD865PJdVY8oPoFUdsdVQAHJaffyDISMO93u8m3Vi7sFb2yp0q/qRzkD6C6vyygTfDfokz4IsCUdONBO06vgQiFRYIFVynB6P7VpDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aton2oPRxMQskG4pn7xEG+lUQ5kC4biGTLrYB6f3qBs=;
 b=d+3tOpeserNBudQUIrprKeCkwU7otNbM+w4ZgEL8VDQAhtTfCY6kYJavWQQvd+PG3e+Lav9jGmtTLFpnJapwx5RxwmT2kiSi8xIZ5Dr6dnML+zUT0vt4Gku72E0U6Brx1eQyjod+f45Cnx7Nl+TsptR5dD/9epjU8nhc1L4IGUfQsfGfqfFQZ+Ct2JNwCjtzhnhqDlC/1wa3KLcrKZBw3OKm4NEiXeogSni5wfwS9Ae7qAvD7Q/YlKQXnTWA7+7bV35e+X5bzimHekJbfxhpFHr8WGGZRXGnbCKT3uJFkwOLGYNg7dTsjqJTXwFPnmLk8CvpP6GTCDaFjSoQxNiJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 19:29:16 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::bbbc:5368:4433:4267%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 19:29:15 +0000
Message-ID: <ef8c82b6-fe55-4c11-9e3d-8dc501836039@intel.com>
Date: Tue, 18 Nov 2025 20:29:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/xe/guc: Fix stack_depot usage
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>, Sagar Ghuge
	<sagar.ghuge@intel.com>, Stuart Summers <stuart.summers@intel.com>,
	<stable@vger.kernel.org>
References: <20251118-fix-debug-guc-v1-0-9f780c6bedf8@intel.com>
 <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20251118-fix-debug-guc-v1-1-9f780c6bedf8@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a09f197-6c88-49f4-af02-08de26d8c277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFlHclRaL1NWZnRrRXRUVEVpNnRDNEFpeEhHaUQydS9FRjZ5MEtsRmhRTnFL?=
 =?utf-8?B?RFFXejE0dDB4YXJ0bGVjL2Z2NGZReHR4ZUc1NWNKa1pnZGhmNGVrQXh5ZFNS?=
 =?utf-8?B?dDRHR0l1aGV4dmp4QTRMT0RxTENneGsyYkJ3dDN1NzlkeVN5dTB1bVRNODdL?=
 =?utf-8?B?emV6SkJMVnNhaUE5Nk9rRUpQWENXVEZTR1JpcGpHWVVyT0QyMk9jQ2pEeXc5?=
 =?utf-8?B?VFpMeXJEMGpEWnlXUkFDa3RJenVaL1JQd2xwVXJSOUhpamVUS0F6dytYdXla?=
 =?utf-8?B?cnVPZm90NnNZZ3pRM21xekl3NGxuZ1hxRWZjekJEZ1lhbGJmaFpxUnowaGpL?=
 =?utf-8?B?dU1tN0pTSHRKY0lJWUJRR2p4VUUwVlVtdVhYMStma01MZjBpR0hZQ25WSDZL?=
 =?utf-8?B?NC9ESUVtYzd3d3lMcjAvL1NVbUtkQUpVVzRqRmwyT25hT1Vvc2RyKzd3UzY1?=
 =?utf-8?B?Umc2TXV4NzR1SHBDbnJlZWJ0Q1YwTnNqWWxWc3NRT3FrazR6eFZGMVdIS2Ro?=
 =?utf-8?B?c0t5K3FxME1ac3dqT1F3L2hOK1JyWWQzeCs4UXdHWnl1aTNIUWRZRzAreWUw?=
 =?utf-8?B?WmhFa2JyN0R2U3VWemVuWnBJZ0YxVDFremtxWXpwY1dKdjdKY1RQOGd6clFP?=
 =?utf-8?B?RW81NUZncUxHenhUM2pnTDFEZTRrR1gwSFVCQ0FPUktFekJwOG1nVWVPL1Ux?=
 =?utf-8?B?U3c2eVRzcWFDSXFFVmROVW1ibXBEanZvcEJyRkt3TjlCVEorYUVxdFB4MXFl?=
 =?utf-8?B?a25hckxjTi8wRSt4dGhvMXFNbjQ1RWs5dCt2RVR6RkdYeEdZRTZCYm5kb0h1?=
 =?utf-8?B?T0Z1QVpEaHJycGZBMjY4YmJ2RXhMYkdIU0ZETzBpalBubmwvM0JWQzZUdExF?=
 =?utf-8?B?SlZBUWlPYkVsYThqOUtsOENQdzhuOU1mODdLNU9YT0ZmWldXcEcrL3RFb0VI?=
 =?utf-8?B?RjVEcm1pakhVSUVXVUY5OHk4cU9ub1o0ZUw5dEo4SCswQ0s4Zkx1bjFDTWQv?=
 =?utf-8?B?Wm1LZlFLZ25WMFJlR1pmYXY1c004VmtTTXhnSVhDM0Vtd0VJeWlyRGVQNnRY?=
 =?utf-8?B?ZkNPOEg0STdnZTdDTlVQVmk2Y3hzMndQSzBSc0VxMkQ3Y0RHUEFraFM2YjdT?=
 =?utf-8?B?TE1wbTJSb1c5dEZHTjBGZVNUbmdTMXg5ZDRWTlV0ckwrN3VoNTdmakJFd05T?=
 =?utf-8?B?ZzZNdjdsbFY0ME5TY09yZnNKdlFtRERWc3QrY1dDMCtFMkVmUU5hT2RDbGJa?=
 =?utf-8?B?Mk9WUEpIYTRucTF1TnhpR0NzYjI5UnJ6bXNnd2lVNlB1L1VTcEJzN1A0MHM1?=
 =?utf-8?B?b2xUazFhZXA0WkVja2tubVoyZ0l3SjlhS3IxN2IyWU9ZK2JoZ3BGQ3dZQUtC?=
 =?utf-8?B?S1YybTA4NzF5dTJZcXpTeTBHY1Z1Z3dvZWRqNFYvL05tTVcveGpEL2FDWlBL?=
 =?utf-8?B?bDFaS3lXdHdOTmd5NVc5Qzlwc1diMlhPczFpRzRadjJYUlVCOHFBazBsOEs0?=
 =?utf-8?B?TmNNMmdvVzFXa1o0Nm5kSHE5c1F3OVo0ZllYQjZEMnFyWiswekJyYUpqZ0Mw?=
 =?utf-8?B?WUNzZzRsWjZvL09lWFRkMlR3SXc5SkFqZEdIYW1tUUZseVVZTTFnWWNCM0F4?=
 =?utf-8?B?SDFFUnZFemMyL2xDdkc5OU92RDVNY29BSWVRYU53d3h0TVZOMUxzalF3dThB?=
 =?utf-8?B?WGdENnZ3RFpIYTRQUEpOYXNXbG8vVmZIQ1R3NHRHdzRFK3VnTitLRG9rK2ls?=
 =?utf-8?B?eHE3L3p0SFZUR0hwWFM3UDBZSHZ0N2FoU0JjWTdzcWxYcEtHVWJwcW5FR0tx?=
 =?utf-8?B?NDh1ejY2UDVkeVM2dFdScFVZWmcvMUg5clNjaWtIMTlUb2tZcXdoeUMrMWdU?=
 =?utf-8?B?aFN0R2FBblFhUWU2QVFOMlJwQWdQVlhNcCtxWWhkTUlWTlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THF0Rm1xcFVMck4yYlI3M3FRT2k4RVB0eFROUW9mSCsvQTVaVStGclp0c1Q3?=
 =?utf-8?B?RUw1d0VmM3JnOWRmZmRkNnlkSFFYb1JQSmV6Nm9Pek1ZR0UycUNLZ1RxQ1d0?=
 =?utf-8?B?SHEraFVONm9yTE1JcE5JMzVWdkJ3b1pKcDhVVXMwQTAxMmhDaVd5Q2FNYnRM?=
 =?utf-8?B?aVFzM1h4RDFNOG5YUC9SMTkyQnVySXZDaXF0ckM0Qnp6VXRjNUExWlppT0ZS?=
 =?utf-8?B?L2p6TUdTQW1GWndFcThhUlN4Z3BxYU1WVFV2OGRyMkVJTWdjUk5tY2JrK2J5?=
 =?utf-8?B?N05YdGRFTDB3Mmd6eFFRdE83VThVYzlMTTFWQnZxSEYycDZOV1N6Z3h4MVNL?=
 =?utf-8?B?d3JBWUljSE13R2VEOGJoZ1NSYnpuNDhYdDFYQXZRK3B6RkZXVXJvcWFxYTdF?=
 =?utf-8?B?Sk1Nd1MwQlJLbnUzVTlQckVpeGhsSE9WM0hmZkR3R2lQWUZGV3laWFVEblpF?=
 =?utf-8?B?azFoc3NnTjNQeTRvSmI1elRSMWNLUzE5RkoxanNrQWRZZXpwdjRUVHBIL2E3?=
 =?utf-8?B?K3Fzc256dnJQNG9yTGZRSlNhdTdUaDYxaURDN2c2MmZCZzIvZ0grSU13NUZ5?=
 =?utf-8?B?M1dLTkRZY3ZleWhqT1BKU0cyMHpCcVduMVdyeEM1WlBEbkFlemVRLzduY0tS?=
 =?utf-8?B?RnZRdkkzeUVHRFd5VkZkM3pWSFZ0c1BacExSNUhnOFdTUlA3ZnZFQWphMFBw?=
 =?utf-8?B?WHNoN21aU2NubkdzOUQyaTlRNlRQSWJXV292dDZRdVVUNlhMU05tdGJjTUtZ?=
 =?utf-8?B?U1R3YzNCcy9ZRnJkTjJDalZvcWdJcHpKK0pUZkNEbEFGY3RFMFFIbkxCdXkw?=
 =?utf-8?B?M2hzTitSTm5idU5YTGZQRk12RTA4UnBmY1NvQVBsK3YzTHFtN2hkRzIzbnhv?=
 =?utf-8?B?T21PRi9CTzZKM1pwMm9rNUNaNmJrYlJlZEM3eHU1c2RhQ0RIT2RSclhBNXZT?=
 =?utf-8?B?MGZ2cWZkMnI0akYxUUtCN01FSTBGNWFyY1Z0N3hPb1N2L29Cb3FZL1l0c2x6?=
 =?utf-8?B?TytHL2R6YXlETmYvS0pwTGtkaFpudTVnYnFiZFNUSGp2SFNBeGNpV2ZjTVNW?=
 =?utf-8?B?MjlpUXdQVmtBengwdDdtaUFnMGRJeFhGYi9yMjBjUmpNV1kwbm84UWYrbXE5?=
 =?utf-8?B?Y0kvWDVobUR4anFocSthVkhIRjF6eWdoT1BwVzZlT3lkYU5mQ0F2cnJSQTMx?=
 =?utf-8?B?THVZYTRHOWQrZnR2TC9kS2VSQVVPT2hDTXRlQzU5QTlJL1hBbEFEWXlCREpB?=
 =?utf-8?B?dW51SmlaUWpjY0FKTHk5T1BqSEdyYVlDV3BIVVl4cDZXeUFMMlVwc3Q3TUVi?=
 =?utf-8?B?VG5uSzZISTlJS2w4TjJDM25ZQldnVks1N01wa2pHSythUTNETHZaUVlnSlVx?=
 =?utf-8?B?R011MndDMkR2T2tNT25pZzMxalRpRnFtOE9wTTJmVysxK3NtUXRGODdGaTdO?=
 =?utf-8?B?aHA1UklzZ2MzbXdVeDA2M0NTeDM2WnVlRGd4dHFOb0VLMDJKdzZtTmY2YURM?=
 =?utf-8?B?ZVRHaCtheGV2VXVwQVpTaXdSTGQvU2Y0WlB3QVFnbHMrVzV4U3lyWHhOQmZ3?=
 =?utf-8?B?Ulp0cURocEJKOEd3Zlk1eEduNVlubWNFZXdzZW8rSHVFempIVDkvS1VkbC9s?=
 =?utf-8?B?TzVRSG5TVjdnU2hISXIxaUJtVU1mTTRjU3Z6dC9STzVaREFzdExTYzhpWndn?=
 =?utf-8?B?MTF1eU5UWVpxUTlucEd6a3N6bkwyY1JXSTkzbk1OUlh1bTZrbGpaeExqYXRL?=
 =?utf-8?B?VGRQNHcxU0R2TFllQUVsMUExc3F3eURRTVM2VkNsdkRJZlhqK090N2d1dXZY?=
 =?utf-8?B?WjVuQk0xclpyTG5VNlZmYm9aVmJxZ1o2VWRRbit6MGVrRjl2dTNvbktod3hq?=
 =?utf-8?B?M2lwbWJvdnkxS25xOGlmdC9rbVZ4eDBSU0ZXMUhtWFdGaE5xdVgrN1VZZlN5?=
 =?utf-8?B?bXdNTVkrVDlzOTRST1JIOVY4N1YwRlF4MTh6RlBQclNrQUFicjVBZnlJazdH?=
 =?utf-8?B?Y2xYWW1vSWVYVUZlMDJMUzFpWmxwZW42eVNhYzNPSGNUYU16QWczSmRiMGVr?=
 =?utf-8?B?ZzBpeGpCMHFOUlpZYTcva2drMkdNZGZha1d0bTM1QmlsS1ZRL0dIY2lqYmZK?=
 =?utf-8?B?MGFGOW5FeExNdVdFUFgya0ROb1BxL0RxUjY5aDU5blVEVFlydWlnQWg5V2hF?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a09f197-6c88-49f4-af02-08de26d8c277
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:29:15.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa8KynlEsESwJd4zZI1Kvzqnq5dluZfovmXL1tUUF84XWeSnS6ZDxfAjm6c1Q3i3gUktErDVZjCdsO4eP8sl5W/zIjcUlRnp4JrhjtmLayc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com



On 11/18/2025 8:08 PM, Lucas De Marchi wrote:
> Add missing stack_depot_init() call when CONFIG_DRM_XE_DEBUG_GUC is
> enabled to fix the following call stack:
> 
> 	[] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 	[] Workqueue:  drm_sched_run_job_work [gpu_sched]
> 	[] RIP: 0010:stack_depot_save_flags+0x172/0x870
> 	[] Call Trace:
> 	[]  <TASK>
> 	[]  fast_req_track+0x58/0xb0 [xe]
> 
> Fixes: 16b7e65d299d ("drm/xe/guc: Track FAST_REQ H2Gs to report where errors came from")
> Tested-by: Sagar Ghuge <sagar.ghuge@intel.com>
> Cc: <stable@vger.kernel.org> # v6.17+
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_ct.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 2697d711adb2b..07ae0d601910e 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -236,6 +236,9 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
>  #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
>  	spin_lock_init(&ct->dead.lock);
>  	INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
> +#if IS_ENABLED(CONFIG_DRM_XE_DEBUG_GUC)
> +	stack_depot_init();
> +#endif

shouldn't we just update our Kconfig by adding in DRM_XE_DEBUG_GUC

	select STACKDEPOT_ALWAYS_INIT

it's the first option listed in [1]

[1] https://elixir.bootlin.com/linux/v6.18-rc6/source/include/linux/stackdepot.h#L94

>  #endif
>  	init_waitqueue_head(&ct->wq);
>  	init_waitqueue_head(&ct->g2h_fence_wq);
> 


