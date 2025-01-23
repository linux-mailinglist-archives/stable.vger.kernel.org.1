Return-Path: <stable+bounces-110322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7608A1A99F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019B216B29A
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1EE13D891;
	Thu, 23 Jan 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyXC2XY1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB494A1D
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656723; cv=fail; b=nqtKrC4l5C6nJcXlj3P/bO0kioqqij+FY42mfBzC5sef+BNR5pXHkZ7fqXuofUqg0mOIEpwCvtIePS8r/zfFe6RCVUZBh4YeuikbKSb+yTzt4qFaOB2ZTfuWmLhqgba/m8hSUJTV7F46L+0UCxJNJHS9MezO/ZaCEc2jY3ITQFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656723; c=relaxed/simple;
	bh=nGksHOPWfgzgu23HdlQvJsLzFmXv4dyIede892LdhpA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=acyois4DfuuCR/DX1b0Z2TfG+Uzcx3tXVnACZB1GUfoyQyJxgvUGvIK8mkbjcaEtvI/1YLpYKwGhHT5Sw2kRGeoL1Sdz3u2cfoheZpwANMCfPvoawnV4at/9z+4zmP5YEPP02/cusSF/FMVSL6OAyot7Vj160qjEqFG6Stglo/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyXC2XY1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656723; x=1769192723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nGksHOPWfgzgu23HdlQvJsLzFmXv4dyIede892LdhpA=;
  b=dyXC2XY1km8OYBeg879/z6KYAPIU3zkAZ+elw1XjKDx6OWnEtMtYaJsb
   pOaIMD24/hgzOWziVZlb8fcH74JhKZxyv7eWD95QVeoEsxGgbi/jBznGB
   /3rFCRMyS8NjRuiB+Pe6QRiB0vFT00uIXWxW49e4Jyp2i5TJ34KTeWy7s
   bAbM57q3gnkkbckenSnZFo39caj7O7L2X7GqxErVNftV7VtxAGGCtNWJ/
   j/TeyQN6qQsYEDlYOLJMGWTF+xCczebXtLNKhz6R7KdusTEhzk/rRKdk3
   Cype0uQVe+PfJ4uDdV8MR79SybEtwuG1ogqMGQng0VjVNIXi63RT1BTfp
   Q==;
X-CSE-ConnectionGUID: z9sB4aEQR/WO/RuI9VMGog==
X-CSE-MsgGUID: G+/doD4pQxuWlNUkQ2HWHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="60642037"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="60642037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:25:21 -0800
X-CSE-ConnectionGUID: yFnofTTPTSaGZiwuJYFONg==
X-CSE-MsgGUID: tsQd+rdNSVqo5xyv5oRwLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112177620"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 10:25:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 10:25:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 10:25:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 10:25:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCd6sjgOBGNWthZVaTgu8ruofGSfF0nyG/wBBcSwHhNDgnquCdwFX+3SOYhZySLC2qSfYz47UwIrwK/Rif8N/4byLlgYVMohb+dufFWi/bLqH6bu1zUl0Z6PZ7jssZf6Vu+W8qmh14dqceq1JjlNC8geEltCn2jJxjkZje6edEg9IF5h5nlIK6SNuJ9ksXz3OfHTSCJN0rTQpSeDx3qxxvRJrBpXG81tKj5H2eYGWuHqmNJIh6wMbXRDPOzkPthbJOljW8/flTLHGD91pUMoRCC0dDdH1Um4Spcm42QL4MU/mP4Xj50LlZVkKEjCMvlofykrj6jwmSd77hL1kWTTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW1/BA0j60fCtOFbyJO8eRsG2E3em4U3Yw/mxYdZJ78=;
 b=M4fE2YiIBT/jOmwZa2Tz5jOnUfsVIiQzK82dcllELOzc0AH05Am3Sw0TY1WriLA9DGsTBZXYzLmcEDmQ4u5o7/CN63ONIDygnWuqdkjEE2/djmke8fzyb6d4Ugv/B5iT/Dr5/LwzcB2Xhg+pLo0ob6FSRdbXw7MrZoXCTZu8bkgA/u7o3HDWFpACYoCNR2yHBdClcTh81wlt8mfZIwtDxVWEaXfWctlfF0+U2eIirOgdjdj8yQRUFFPWtcWKFDAcNJ4ADSQ4Erka7tCDc4oAeehGzrqCy368OR7QLXbawaRu6f0UDu1jWVl1ZaHoLQYL0TLSWFd3akM8Mr+cjbER+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 18:25:16 +0000
Received: from SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e]) by SJ2PR11MB8450.namprd11.prod.outlook.com
 ([fe80::5c1b:f14a:ef14:121e%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 18:25:16 +0000
Message-ID: <1dd0e42d-0163-469e-8fd2-9c3b941c23bc@intel.com>
Date: Thu, 23 Jan 2025 10:25:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Julia Filipchuk <julia.filipchuk@intel.com>,
	=?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
 <20250123051112.1938193-3-lucas.demarchi@intel.com>
Content-Language: en-GB
From: John Harrison <john.c.harrison@intel.com>
In-Reply-To: <20250123051112.1938193-3-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To SJ2PR11MB8450.namprd11.prod.outlook.com
 (2603:10b6:a03:578::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8450:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9414b1-bcdb-42a3-c1d0-08dd3bdb48fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnRjZTkrV2hGMVlVWG1LQldwVnVzeVdCM2ZmcVdWU3F0RVBjQXBkbkFKeHF5?=
 =?utf-8?B?ZmYvMTRMVTczMDFUSkNSV3N2L21waXVlOUFoUUpIVzRPalVPSE5FOGNXQzU2?=
 =?utf-8?B?dTExSHpKR1UzazZSazNpM3kxc1lESWtQQ1NEZ1NWWlg2VUJ5eW9VVkl6RGtT?=
 =?utf-8?B?UndwUFVvYUF2WEF1THVsOXFjRVdnZ29FQmY5aS9MK0kyT2ZqQ0paUERPVE01?=
 =?utf-8?B?bTlaZzBsQlF3Ri9JaWNRUnArUGJYZXA5Sjk1dSt3NWcwQ25kNzJWU0NtZkJX?=
 =?utf-8?B?K2I2WkNVaC9NUlNMZVFWQ2NHY1Q4cWpXYjh4M1N3enpWSnlNb0NtZUhXcTI5?=
 =?utf-8?B?ZXkyZzJTeEttLzM3cTlSWW5zaGxNTEdITnliQ1ozQkNNMUwzUk9maFdLaTRN?=
 =?utf-8?B?eHJScE9RRmhFN2VkTjh0TTZ2MWNxd082VFFsaFFGUFVSbnZWNFpZajJPWEww?=
 =?utf-8?B?SXkrYjRZbzFLM0FJVkpxaUZNS3FlTkRiN2JMSlowMDlVMzd0TkpaZFprTExi?=
 =?utf-8?B?WTd4OU9oazZ0Qm04czFTZ0ZzRDZ0MkhyaUVQS0dOOGNJeUh2VGhRZU1CdEJo?=
 =?utf-8?B?V3Rmc2RReWgwSGZ1T1ZXMmJpTmlZd0FkaU53cTArZm9nVFhFb2NmNk9TLytu?=
 =?utf-8?B?VWJMdXNycE9pR3pRa0xEdXlxTjUrSGhzdVA0QmhYSDdEa2NIaUwwNlRQaFdw?=
 =?utf-8?B?NGVPL2dDbU1nQllXQ1JucjhLRFZGeFpjZksxeTcyQlZGV0loTys1cEZlN3c1?=
 =?utf-8?B?U0dkNHVCUzNSYWxsQVBxcCtraCtWMkVJaUZzSnNKYkQzYURQdWxHTWozeWZ1?=
 =?utf-8?B?OGk3WGp6cUFuS0dTZTNZSWxuZ1NrVWdzTFVhdkw1czB1aW5pbEt6NzBwV01V?=
 =?utf-8?B?anZTL3pPekY4VXgvN2lEbS91VkYwaXJuNk9OelBwN0xJdmpiS0tJYWhTSnhi?=
 =?utf-8?B?THZWY3FQbnEvR1UvbklRbW1kQjRxczYySFBweEQrb1FWY1ovUEM2OHhHRVUz?=
 =?utf-8?B?dmdsSHNoOExyZ1ZJMU9YVXNXRE0rM08vL1llQTNYdWVzekYrWW83VGtpNkpv?=
 =?utf-8?B?VDFjZDl5RzRaa1ExWjBNdmNoNE03bkJoSkpaZDJLb3Z0d3ZNcTE1V0liZ0RX?=
 =?utf-8?B?ckRYU2RZUjdqdzMwdFlaSGtwc3dEUEdZekFxa253NUk4ckp0dDR0dmVZM3Iy?=
 =?utf-8?B?R2tPYnZ4N0RrTDNzM1NOdlFpTHkwanBJUWRPSjU0RmVNNTZKS0pVVFlxL0F5?=
 =?utf-8?B?VUNUelRxRk84YWxaTDRzekJBWk9lbU9XTnJBcFdJT3ZiMFBrS2t1NmsyYm1U?=
 =?utf-8?B?WDBSK1N3TjUxMjFNYVd2bzV5L1lGMHZmWURkdlFuTmM0ZDZYenBRYjRnUkRI?=
 =?utf-8?B?aTZtakFtOThZUjU1L3lncXFiNGc5QmJET1ZOZUFPSldmTDduZm5jQ2F4bkNl?=
 =?utf-8?B?by9ocmt6c1JNdDV4WS8vNkR0dmp0Qk5FcCtUNHlUYy9xV2JQL0RoN3hlLzVi?=
 =?utf-8?B?M0I1Wk5MSytoZVVmUW9ZR2x5MUh3VkJ4dUJMU09RWXEzdlBZQ0t3dVl1VG9q?=
 =?utf-8?B?Y1UwUVJsR2UvTHJ5NWZoSE1YalQzbHR3M1RNYnUraGhyNzdtc1lGNUEvb2NE?=
 =?utf-8?B?OHVaeitVVUk5YVcxQXFiaUlsakI0Wkd3LzNxZDMwdXBCNGJlN2NBYUhnUlh5?=
 =?utf-8?B?OWxsMmFFaDBhUkEwbHVmMWhxVzJRVTh1MVR6aThzOWpLMmlMbDAzVXJmbEtu?=
 =?utf-8?B?L1RVRE5jR2s1TTNuTmphbVEzS2h2cllaZEFIQ1FuRElMS1RHV0xrTitWckdn?=
 =?utf-8?B?NTFZSFNhL0MzRlBXaEF3K3JhYWh4cHRWZHhkQ3FTNkgwcXlXN0YyR01oSHUw?=
 =?utf-8?Q?Z4PBqWcc7LpYW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dVSVFmMVFjbU81UkIvMXVPNU5ZcmszbVg1R2pzazd2cmhtVnlIeTN2TjZx?=
 =?utf-8?B?UXlLMGkxb0FJa2x3eVlsMWJSamRrbklUYkVuclgwQ09PN0JXRVUxb1Y0Yi9O?=
 =?utf-8?B?dmIzTmkzUTUvVUVIY2JhdEQzYjFSRVpnQjFGSElFZWhiNlBoN2NlOW1hMHNS?=
 =?utf-8?B?TGx6Uy9COTZTNGp3VUZ5OTNyclA0NnZXNjZaeHNsK2dMdG16RytZQUhyT08x?=
 =?utf-8?B?U3dTWUtlYy9VVGZDeGJmZWFRbHpNbGZhcFZWbDA3V3pSK2hDaERuT3lMZ3J6?=
 =?utf-8?B?ZTBkbXVPdEc5WmVrZTZwNlVyZ0xxeEtXVlNOelNaSUpFRFkyUHFjY045MmtY?=
 =?utf-8?B?SUp1Q3N0UEtTZzBzOFZ2d0w3bnRVNXVaQmRvb2JGN2Q5ZS9WdW5iTy9IeXlK?=
 =?utf-8?B?MTRUSHZ0RGFiSWRBaFc2UlpHNWZkK3Y1eXNacDRnR09KQjVSZGcwSmhITEEr?=
 =?utf-8?B?K3Y4RURTaXFUR2d2Ym9QbEYxY0h4S25YRllVN2MwVEdQcXJITUNOMStUWUtl?=
 =?utf-8?B?TVMwcVUrQ1lubWE5YUFkREJFRlU2a2lSMFh4MkNNRWZnbm5aVWxGa24rNTZn?=
 =?utf-8?B?YlV6V0x2UlE2M0IrczBOMzRHZm9mMm5wQ2doN2JVTS9GQTdDaTZNSGJyTmpD?=
 =?utf-8?B?TnVienp5cGd5YjJMTFE3U2ZnZTFBSjZBSTg1V2kwaGdmeU9uUlZia3Rma0ZK?=
 =?utf-8?B?R1M2dlNuWitSTWczNmVQc3NhR0drYjcvSXFQZTNrUm1ab0xYM2ErcWw5OTRP?=
 =?utf-8?B?V0pNQmtORks2UHhieFNSNlErWlByZStxeVVORHYrODF2bWIzM2JGWlphcmZw?=
 =?utf-8?B?UDEwaGUzRGR4dlB3aW1PNnRFdG1VbngzeU1KbEJQZHZaY015UkdUMWsyOGM0?=
 =?utf-8?B?RVN1VUxuemErckJLZURwU2twL1Z2NVVENmppdCtiaUdraElOWVJDUzhTY004?=
 =?utf-8?B?YWpNbzFTQkxJVy9NbG53NzVpV1h1K1o0N0pJbUJBQ0VGYnFIbVlCK0xMWldy?=
 =?utf-8?B?RVFXTWRkOEVpeDgzU05CcGRRbFdQWm5HeEZPT3llSm1IbUpzUVBMZjJ2UjJ4?=
 =?utf-8?B?OVVXWU5PWDA1dExwUnptaWE1Y25rbnFHdm5XZTZubFlHOVFTM0VhMkViMmxv?=
 =?utf-8?B?V25mVjJ0N2VMdG1MdTdhNjlkeW9rdWF1SFk5dEF1VU1UV0xBVThra1hkSnpS?=
 =?utf-8?B?WVcyYnROWEd6SjlrNHoyV04xc0FOL3N4TnQxZjlTTFBvMlFZbmsvNk4zUWR2?=
 =?utf-8?B?T1l1UGRyUWszQ3JpdnZCMnNQMVZHckx2WDdVMm8xZ1NuNWtma3p2b2o1TTRQ?=
 =?utf-8?B?UWtzNDIxZk1GNEN4ZFp1bzFJSC80Y2NLSk5UMmk0V093NFVFZDIydU9YbFdl?=
 =?utf-8?B?Mms5amFXSFlaR29mM01GcFAweGdsY2dENmRINS9ITC95SVRob0kyVjV1bFNh?=
 =?utf-8?B?NG44RzcyWGxsdEcrSFczTk56cFZNQURzd3d2ckduUGpnZVJ0NUtUQ3Z2UXhi?=
 =?utf-8?B?Ympvc2pnemFObkRqbEY0YUNwMzdTRE0yTWswODAzTHlUSXJGZkFyV25uemlZ?=
 =?utf-8?B?dENYYWM1VGFhOTB2b0RzZ3dlQjIya2tvK3dNcnBVNGlrMis4Q2NLRHc2UXk3?=
 =?utf-8?B?Rm5GZnB1NDNCWGh4bW0zUHlOVUxTZ2lhZUVNdHZJcFZDdGREYnoySVBPTnhk?=
 =?utf-8?B?Q1Z6bkxYMXY0ZGhrS0locnJGWWEzR21xdFlGdHBKeSt2LzlRUVZjKzVDSW5K?=
 =?utf-8?B?NHZMRjRMOEZWMmhRQzNsY2JQQURYejVSVTl5Rkg5UzVzMWVjMHI4ZWdpdmhW?=
 =?utf-8?B?SWZMeWRhLzVtbGxMbXM3MkdwMzErdXFhR25mY1RvNHFBbSt1U3IvZElsZHh3?=
 =?utf-8?B?RFZnbkZQQlJIdTl6ZnNkTHBjdlM0VTA5aFJYRlY5YlJ1TkN3TytmWk93T0Uz?=
 =?utf-8?B?UFNhazI2dlJTbHh1UERSc0NQdk9iN2REU1BEYlRxMjVFM3VMZ1REYmFqUDlF?=
 =?utf-8?B?b1JacTU0R3U5dE16eUIrT0duK3VGRlJVTnZyQkN0VFVJTm1mTngwVmZnMU9F?=
 =?utf-8?B?cExPVGplZmZYc3BJNWxwbDkxNU1zajZHVHFPMmZyMlhKcDN4MGpET2ZCMW1Z?=
 =?utf-8?B?NFR1Zkl5dFJWbWEzRHdBZEpub3BrMWN6WVZBcnllMytKU2lJRERwcVdxMjB5?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9414b1-bcdb-42a3-c1d0-08dd3bdb48fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:25:16.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBb8jmOHpWrehjsDqIgt+hPTNYtVE07R79Vmj+Ik2l2jCZDqgWYMUU3P9NpK/3VoHk67g+rcZPNPPo6rKcTurApneBrLzEPCFLBkkKNR4/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com

On 1/22/2025 21:11, Lucas De Marchi wrote:
> Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
> debug tool") partially reverted some changes to workaround breakage
> caused to mesa tools. However, in doing so it also broke fetching the
> GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>
> The fix is to avoid the extra newlines: the devcoredump interface is
> line-oriented and adding random newlines in the middle breaks it. If a
> tool is able to parse it by looking at the data and checking for chars
> that are out of the ascii85 space, it can still do so. A format change
> that breaks the line-oriented output on devcoredump however needs better
> coordination with existing tools.
>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
> Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_devcoredump.c | 30 +++++++++--------------------
>   drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
>   drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
>   drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
>   4 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index a7946a76777e7..d9b71bb690860 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -391,42 +391,30 @@ int xe_devcoredump_init(struct xe_device *xe)
>   /**
>    * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
>    *
> - * The output is split to multiple lines because some print targets, e.g. dmesg
> - * cannot handle arbitrarily long lines. Note also that printing to dmesg in
> - * piece-meal fashion is not possible, each separate call to drm_puts() has a
> - * line-feed automatically added! Therefore, the entire output line must be
> - * constructed in a local buffer first, then printed in one atomic output call.
> + * The output is split to multiple print calls because some print targets, e.g.
> + * dmesg cannot handle arbitrarily long lines. These targets may add newline
> + * between calls.
Newlines between calls does not help.

>    *
>    * There is also a scheduler yield call to prevent the 'task has been stuck for
>    * 120s' kernel hang check feature from firing when printing to a slow target
>    * such as dmesg over a serial port.
>    *
> - * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
> - *
>    * @p: the printer object to output to
>    * @prefix: optional prefix to add to output string
>    * @blob: the Binary Large OBject to dump out
>    * @offset: offset in bytes to skip from the front of the BLOB, must be a multiple of sizeof(u32)
>    * @size: the size in bytes of the BLOB, must be a multiple of sizeof(u32)
>    */
> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> +void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>   			   const void *blob, size_t offset, size_t size)
>   {
>   	const u32 *blob32 = (const u32 *)blob;
>   	char buff[ASCII85_BUFSZ], *line_buff;
>   	size_t line_pos = 0;
>   
> -	/*
> -	 * Splitting blobs across multiple lines is not compatible with the mesa
> -	 * debug decoder tool. Note that even dropping the explicit '\n' below
> -	 * doesn't help because the GuC log is so big some underlying implementation
> -	 * still splits the lines at 512K characters. So just bail completely for
> -	 * the moment.
> -	 */
> -	return;
> -
>   #define DMESG_MAX_LINE_LEN	800
> -#define MIN_SPACE		(ASCII85_BUFSZ + 2)		/* 85 + "\n\0" */
> +	/* Always leave space for the suffix char and the \0 */
> +#define MIN_SPACE		(ASCII85_BUFSZ + 2)	/* 85 + "<suffix>\0" */
>   
>   	if (size & 3)
>   		drm_printf(p, "Size not word aligned: %zu", size);
> @@ -458,7 +446,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>   		line_pos += strlen(line_buff + line_pos);
>   
>   		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
> -			line_buff[line_pos++] = '\n';
If you remove this then dmesg output is broken. It has to be wrapped at 
less than the dmesg buffer size. Otherwise the line is truncated and 
data is lost.

John.

>   			line_buff[line_pos++] = 0;
>   
>   			drm_puts(p, line_buff);
> @@ -470,10 +457,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>   		}
>   	}
>   
> +	if (suffix)
> +		line_buff[line_pos++] = suffix;
> +
>   	if (line_pos) {
> -		line_buff[line_pos++] = '\n';
>   		line_buff[line_pos++] = 0;
> -
>   		drm_puts(p, line_buff);
>   	}
>   
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
> index 6a17e6d601022..5391a80a4d1ba 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.h
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.h
> @@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
>   }
>   #endif
>   
> -void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
> +void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>   			   const void *blob, size_t offset, size_t size);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index 8b65c5e959cc2..50c8076b51585 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
>   			   snapshot->g2h_outstanding);
>   
>   		if (snapshot->ctb)
> -			xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, snapshot->ctb_size);
> +			xe_print_blob_ascii85(p, "CTB data", '\n',
> +					      snapshot->ctb, 0, snapshot->ctb_size);
>   	} else {
>   		drm_puts(p, "CT disabled\n");
>   	}
> diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
> index 80151ff6a71f8..44482ea919924 100644
> --- a/drivers/gpu/drm/xe/xe_guc_log.c
> +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> @@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct xe_guc_log_snapshot *snapshot, struct drm_
>   	remain = snapshot->size;
>   	for (i = 0; i < snapshot->num_chunks; i++) {
>   		size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
> +		const char *prefix = i ? NULL : "Log data";
> +		char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>   
> -		xe_print_blob_ascii85(p, i ? NULL : "Log data", snapshot->copy[i], 0, size);
> +		xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 0, size);
>   		remain -= size;
>   	}
>   }


