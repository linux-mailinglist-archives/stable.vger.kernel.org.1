Return-Path: <stable+bounces-164612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FEB10BCC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE960547B04
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10942D9783;
	Thu, 24 Jul 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCxPa1Fl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D852D94B2
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364679; cv=fail; b=pIf6m3YJmyXUjrAaxuPUXAhLC0AR85AmP2FFsugVP6GiA4RpGb2RQHR0/dybzqcCdKQwNaJumPMaVyM16ETj2BKUltTGcm6UhnGUVaoHAfBag4D4lH9nINOXZVddqepVYXAvf4izvnH9ngwGljAprVsy7tiZ0CLiL0w7qrMpEvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364679; c=relaxed/simple;
	bh=PgbQQCquuqlQJy6bXiYJDvYpuYdo9e/r6+ED513W7Ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c9Lpo4ZO+QZeeK+T6FBZYAQXvDD1bWKpIIHWW4AhLFrlCDUoL/4ojkjYaZCeNUhuQA+3CvQRVT9E+vxRulu2etq4/UUxX7t/F3eLPUak3JxpPg6bejSQQJSehBsv24tuj1etJmZAbPndeBunz3FoxpnXxU9aBi2OSuhm0lAESoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCxPa1Fl; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753364678; x=1784900678;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PgbQQCquuqlQJy6bXiYJDvYpuYdo9e/r6+ED513W7Ek=;
  b=VCxPa1FlaPjn0wO7Swkzl9A1evV6qXwiY/XLYmgTui1TjMsQsXV1vwOA
   VNkBhBb7Ijy+UPBl8ZFv6azc+RPjSy+v5phzc3lPZ+jC/as4t/aM4y+2n
   DMChta8VNXBwdxqQGXxg58pM5jPepVaU9Xh+s3QzdchR7G+9GHcWcpPSd
   pTY8LlAhMhapqcOdfrL0GXHbHHn9Za6F26dSJttnYSZZjKG5uVWYM3XSV
   OjUEGHPe07yNRNiOq9gjTm6j/65MpmujJuVs04bf3AnspT6WsoUfXUygo
   +kAhDwc9+CF6qXEhtn7ak9EtbBz/j/MWNY1oX5TJUWfTx2hpPL8xzQqTb
   A==;
X-CSE-ConnectionGUID: klF4ctpMQHqBeaBGe9DITg==
X-CSE-MsgGUID: nNKAQSfEQu2ign5DiLkRLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67031700"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="67031700"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 06:44:30 -0700
X-CSE-ConnectionGUID: ZR+3tIhFTgWC8Wx3nNftvQ==
X-CSE-MsgGUID: NcpEpxAsS+CGhFYYj7/bkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164306084"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 06:44:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 06:44:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 06:44:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.79)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 24 Jul 2025 06:44:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrAXRG+S+GV7Q8t+LdH73vXh/5o4+NkT5KgwDk+k0ELrzcHjNVNSo4w6wuxmwyth/lfvuEFHfqHJ/zNYtWKxi9jvf7xd3Sp/vVE+i+y3yAczum1UTmtwhRLI83OBFOXREfgLySB9tno4bQAVQyLkUdDu4fM9V8bdCWCtv1gcSD/m4tFhOMGCvPtt/GbanLMAlpjowUDTi63naksB+r8RShGvv1gserKSvWZXmZknX0LofhSfT5Y69OdHN7pDOAxG0/M9601aENQaKXgdXiBDmukxZs52tgQ+syPJ0UEsanF55ppxA4jfaKatr2PW5m7WD1v8YuypxCGwPU0rXIeqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oALhbEaYqeOoJ0Z6XaqidSTilfUrJuVaSiKQn5s2Gak=;
 b=BoB2ln4pAoecYvgMlSIElgx14ygDenl7sSa5mxx4CUEragwhWlCYeQk5QehzZSF7ODWbu/e61EVK8Nmd/GI0jbIwVQxJcrw+uWtsBwWy6S42GpgRepZ6rVD6vrlvvuj8zPPu2K01o6tgfdwuIZ/NkLbiqWKlKEHDoy4rpuWx0ph2TQ9+utScD/g7FnAq7DQtZSaMp/uts+qbMtFLPTn9M4ejUao8j3NSj4P0eCTV421aXEfHfpEQneGLi3+xVSvwq1VsO6WelZNGCKTZzZ1aoLqbbB0nw/pdSP9gL74jkhMpfuJsqSugGDvjHIhLOHKxggdi2QDmQ8QAfxfXt5B4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS4PPFCE18D981F.namprd11.prod.outlook.com (2603:10b6:f:fc02::50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 13:44:19 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 13:44:19 +0000
Date: Thu, 24 Jul 2025 14:44:09 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>, <giovanni.cabiddu@gmail.com>,
	<ahsan.atta@intel.com>, <qat-linux@intel.com>
Subject: Re: [PATCH 6.1 v2] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <aII4qdhdmAuBpoeF@gcabiddu-mobl.ger.corp.intel.com>
References: <20250722150910.6768-1-giovanni.cabiddu@intel.com>
 <1753226943-64f06291@stable.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1753226943-64f06291@stable.kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LO4P123CA0689.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::14) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|DS4PPFCE18D981F:EE_
X-MS-Office365-Filtering-Correlation-Id: f895ab96-9cf5-42a2-5516-08ddcab83072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDRuWUE4b0I3bWtjL0kxak13YVBlaUtwVlBZRHNqRTNoZGpUaU1ROWk4YmZC?=
 =?utf-8?B?MGQvcUJnd0xpbUY1MTkvRWcxbUNsVmlCRGN2Z0ZPQ0Q0ZWVNZU1UR1A3VzZN?=
 =?utf-8?B?djNKdHhKSjdvTUJ2Tlgxa2FCKzNrS1g2d2Q0bk1UMVlXV3hvQXFUbVgxWnNw?=
 =?utf-8?B?MnVkZFo4a3M4Y3pGYitGb2NuWGd1YVBZRTUrZ2lob3FCeWlmV0drdXBRTWJH?=
 =?utf-8?B?ajNkOElkNGdkUmlnMklSSnpBOSsxdWNrNDEzK2FaakRYV3FjMS9KSUdMZ0xJ?=
 =?utf-8?B?YmFuUnFTSzh4N2crOHpQMHpMT09STnhuUW05cnhSckRwZHRjZHFrV05SWUt0?=
 =?utf-8?B?R3FWWmJWNG9iNkFZYzJIQThvRGVVNXBhdm1uMFE3Mk1UbHROMjFjNTlreVVR?=
 =?utf-8?B?eTFOa1VBanJmQTNJd0FkNGlRZm9KaGtMOHdlS1hiUldzZ3RBK3JISDJPbi9D?=
 =?utf-8?B?SkZEQ0VQdEpJSjU2YkNkK1NGMDdyQTdjQlZJVGxyclFBVEpVV25DMHR6a251?=
 =?utf-8?B?OG5zU0wxeDFpa0taL2tZMDJLaEdxUXlPelZMQndYTGQ4L1p0YTlhTkdocUlQ?=
 =?utf-8?B?bmdONG85SDlOZy9zTCs5Z3ltaXo4THdMc0NReWhRbUg2UVVpd2JmMVE1RU0w?=
 =?utf-8?B?SW4rYUo3WmdRaXl4N3NDVDcyZjdyTGtoOW5LUG5zbWNUNHRnSkZ2ZlNxMWp0?=
 =?utf-8?B?emZDdUk0TUVuRmVuWWY0OXRxNGdxQTkwRjgzUVhmL1FLMzJQaVdnTXArYVVn?=
 =?utf-8?B?eHlsZUFpK21NWmVxOWl5d3NRdk4yZ1Z1OXBOeHJpQlArQVlMNlhjK1Q0ZWhp?=
 =?utf-8?B?NmtLYnlnN2FORmF5MkZNR1VrSHFWSlBxTTkwMzB2aDdVMWZ6TU9DelVmZGNu?=
 =?utf-8?B?N3BscTRJN1lLU2pPaEdrekpsek1WTk9ZM2FTMjVZMldBWHN2Y2dIRW1sNTZm?=
 =?utf-8?B?UVhXMTBzNGZ4OXZvYW9LcWZqWUhFOXdKblpHVWVqL05oa2p0bEc2YXVtdGVP?=
 =?utf-8?B?SEcxZlF0NERFemlpeVhidTNBMU83YUF4cU9XMkJ0VkFuS0FtcmFkZ1FIVWhZ?=
 =?utf-8?B?UVFkZS9VVG1DV294SGRhTTBJUWlPcXpDRmdMbjl2RnBEUmhBZzJwUTFUeEZU?=
 =?utf-8?B?bWNGNmc1V2pXVktaS0VXTkVuTmZHR1hHa0Yza2FwQjBiVHpkTUZqZDFUcjFa?=
 =?utf-8?B?dkpRbFhCekxmbm9Cak5kYVFrUjVYditPd2hadFZQc1VWVE16L1I4eUIyNXdi?=
 =?utf-8?B?ZFhlaGs3R0NxVm16TkhxdGtpKzFCREtRZXVBSU1OdW5laHRYRC95VHBkNGhw?=
 =?utf-8?B?QlM3WUlnSG9SbExzUE05Q210V2pHY0I1N2VVWXo2TGlnS28xQzhsSnNEVmFC?=
 =?utf-8?B?RFVkbFlXRU5oTU5KeFhPNFZZN1l3ZkxUV0VsSTd5Ly82eWlXazlCRVRpNUxI?=
 =?utf-8?B?cFIvQXBZWGFuUkhJMW9jTHdUdUhlQnlNbHVCV3VFSXBLODBsVW12YzlEaW1K?=
 =?utf-8?B?b2FoOWFIZU9HeW9WQlBEcHVNSExPdStWa2lUYWhUQWJIRGw2Z0dXSlZVKzNH?=
 =?utf-8?B?MHZJTk5xMHJxbTd1amxJRGprTzBraUhlRndKUUlKQ1NoVml6bkpvd0dlTkl5?=
 =?utf-8?B?Q1RpTDJzNk5QL0EzcGlLMHQwdXlyTXZTTzkzYktYVVBCNXJEclhFMTFIY3VQ?=
 =?utf-8?B?Y0Zwd3I2aythSFgzcWhRdjYxa0dYZDAwM1BsdkFRSFVGOHllZ2ZRZVNXeE00?=
 =?utf-8?B?S25tUkJsdElNaGJqa0NjblJ0OVZtNzNuT0oyRXl6M2U3WGVsdFdndGxWVFR0?=
 =?utf-8?Q?Hz+I59U7u3omn1No/HEMcUXXbrUV4hS8gS4CQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Nib0JPNnBneTRveTJLSXZMVDRuelBSYjhPck1kU0ZicG1QMVFqVHcvaldD?=
 =?utf-8?B?aDJ2YVYwVlBtdG9tOFVxRXQ1cDdzL0FEL3VKYUhSYmZ1M0JCR2lidUM2d2ZC?=
 =?utf-8?B?KzNJNkJMNWlvR28xazZUanFzR3lITHBLQ0dJOVlJZ2thNTFHNzRJdGlhbE1J?=
 =?utf-8?B?TXQ2b0VhdFUvVUZrSUJ5S0YzUkdkNTVuOEMwNmhiUWpkZ20xTTRpY0pwWlBo?=
 =?utf-8?B?Z3hPYU1KZWZXaWNsaTdvWnpUeVpUTm0wWGthSEU1Yk96MjJoTFlKUHZPTHdu?=
 =?utf-8?B?NHlaMWRNcnJzMkJzR1dhUEczRmZDYTNlN0xJMGpIM1BMVHZveFJvcTVqekVO?=
 =?utf-8?B?SEdaT09CdVM1ZUdsa0c1RUxlN0duNUVQQUNiaDZYQ3RzSmJqN3EyNE9SYzNa?=
 =?utf-8?B?Zjc2eDdDTHRZeFVSVkU0OU8vK1Q3TWdwY0dDY0EwNG5aRVNKOHhubWNEcmJT?=
 =?utf-8?B?Tjk1WDBoc2syTG9ucU9sZDRJZEFkd055T0JhTG9qMXZNUFozZ1JkSHdiZFFa?=
 =?utf-8?B?b3RTbXdodElqNjRJMTdsVlJzK0dQV2xFajZBZkVaeElTS0RLTHNPNUxPbHM5?=
 =?utf-8?B?UGdtNjc0dHJnTTFLbkNoYjU4V2NQQXg3d0FIZnBNenpSK3RvOHE0eTZ4L3BK?=
 =?utf-8?B?SmlhbDBuSzgycVpmbHVxS1R6ei9pRVlzMlNBRktBS0RJYzRTQTd6MndoTCt0?=
 =?utf-8?B?dHFQMFZHV1NJZi9LZkNObC9wZ05BdmZQamhnVFpWU3EwTU1TY0ZXdE5hOWd6?=
 =?utf-8?B?OUNoSU05Y3dHdEFIc3pnZndVMkJ5VDV5VFk1UEdpbkhOR0wvSXN6YzdUMi9r?=
 =?utf-8?B?U3AxY3IvZExENlBXdDZ3bkFreW03Sk5WS0hwaWJJSlNTUXBNQmhmZE9objNM?=
 =?utf-8?B?MXdYcWpCZXlVRVBUMkljRXhnY2lmM0VVUk5nRnBIdXluT1ZhZ3hER1ozQmFI?=
 =?utf-8?B?eTlFNVM0S0E5Q0FuK2kwdHk5ejFmMVJCQTVyYkFpSTM0OHRDbnFQNkhrMXpO?=
 =?utf-8?B?a0pCemR1SEp5UEFmR2ZGd3MwV0NsZnVjVnlqZHVlV2NITmk3WmxMVkVXeUMx?=
 =?utf-8?B?dE9HOW1vWlJBYlhNK2VJdDZGVnliQ1JqK2MxT2hDTmhDdUNDNStyVzZ5elMx?=
 =?utf-8?B?VndvQVV6RksrZlpCdzFuVlVrZndWSFNDYmJEeHN3aGErZWo5c0ZIbWxCcWJj?=
 =?utf-8?B?MGlrRWhRL2NhckFmak1TTDRoeUl0U3pTa2VsK21yenVmNlRITlUxTFVZUE4x?=
 =?utf-8?B?ajI1amNQVFlZdTFKcThKdTdmZm0rMWZ4MFZVaCs4ZTZDMmVSUm5ocmFjY0Zn?=
 =?utf-8?B?dE9COGxxeGt3UTN2bFdmU29sM1ZXV0tDTyt0RTFqdFo5eERjNDcxSmFyWUIr?=
 =?utf-8?B?UW9ZWWI2TU9TTjFDU25XaVVNSFpFS1UwR1EvZTFDZWNkSzgxVWZFdzd2M0M1?=
 =?utf-8?B?MGNCT2JBTUo2eVEvRms4YjlMMmQ2b1dhNUoyWDZmZzl6NFhLYkpLd2IxRThL?=
 =?utf-8?B?V0VLbVM0bjlhTTZVNUJJd3c5QlRqdXIybURnWFovVXE3Y1VCeXpjb28vRXRB?=
 =?utf-8?B?NlJDWi9TUVRxbGpFQndoajVwZzNEOGdOTUlzRlNuR28yZ0xkMzN2ZUFoNkQv?=
 =?utf-8?B?U1k1akFGZGFQcDNWWUFxNDlxOE4yclk4MGdzUzJOZG1EWlVrS0wwNVJ5VWdm?=
 =?utf-8?B?TnU0NWpieHA3aXNJY05UWUpWNVh4RGNqcVM0Y00weTVjSjE1UlBQYnkyRkpR?=
 =?utf-8?B?MDVkM0Z5SThYK3RCMUxXMWhTUmp3VEpTcTJDeGdTbHRSTzZLRVg3Wk96MHR1?=
 =?utf-8?B?ZmFCUTFGUjh2aHo1blVRMjJIaUxuVUZLRUx0c01USGI5c2c3dGRRSEt3emJx?=
 =?utf-8?B?TWFycHdldDlEd2d5Y2lhZEFWZnIwT0pKQVhFN2I2TVhQVXZ0eG92dy9wVUZZ?=
 =?utf-8?B?RjB2T0E3SElFWW1HR09Tdk90Uk81RXl5M1ZHMDk4QTByd1RHRHA3VGhrSjMw?=
 =?utf-8?B?eHR3TXc1dENqSy9VeWFFSDRYOEd3cnhzbVNDNjZMcEZ3ZUlzWGhHa25KMU9j?=
 =?utf-8?B?SXRWOGo3WnVoYzJGdytWMHZObUNPcDg3NlRObFluL0k1eFpTbFlTWTgvbmxF?=
 =?utf-8?B?WWg5YktxV1FuV1BlTEhXWEZzaDJHQjBSd1hJZ0dRNWlFdzRkMkxDM3NBVEpa?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f895ab96-9cf5-42a2-5516-08ddcab83072
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:44:19.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqsB/JhXhfPqdIszQDaeVtYYq0zciB1ERHjv7renGzXyWO+xf61Zzcr8lS6lQ4zzW2527YMcI3hXY7iaZLGgExaRJQuJdizR7dhHpP61I7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCE18D981F
X-OriginatorOrg: intel.com

Hi Sasha,

On Wed, Jul 23, 2025 at 12:33:49AM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found follow-up fixes in mainline
> 
> The upstream commit SHA1 provided is correct: a238487f7965d102794ed9f8aff0b667cd2ae886
> 
> Status in newer kernel trees:
> 6.15.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (different SHA1: 82e4aa18bb6d)
> 
> Found fixes commits:
> df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  a238487f7965 < -:  ------------ crypto: qat - fix ring to service map for QAT GEN4
> -:  ------------ > 1:  58ce42abb968 crypto: qat - fix ring to service map for QAT GEN4
> 
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | origin/linux-6.1.y        | Success     | Success    |
>
Here is a summary of the reply in v1 [1]:
  * This patch applies only to Kernel v6.1.y.
  * The follow-up fix (df018f82002a crypto: qat - fix ring to service
    map for dcc in 4xxx) is not required as the `dcc service` is not
    supported by the QAT driver in v6.1.
  * This is a cherry pick with modifications. The fix has been
    simplified as (1) the QAT driver in v6.1 supports only two services
    (crypto only and compression) and (2) there is low value in brining all
    the dependencies required to port the algorithm that builds the ring
    to service map dynamically.

[1] https://lore.kernel.org/stable/aHnvq5RvK%2FUC7h15@gcabiddu-mobl.ger.corp.intel.com/

Regards,

-- 
Giovanni

