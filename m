Return-Path: <stable+bounces-126711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78CA7179E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 14:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6186F7A4EE9
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C51E98EC;
	Wed, 26 Mar 2025 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgZ7UBNb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77C1E8330
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996131; cv=fail; b=erwrs7GweI02e4rClvzugijoZHMRno/SGSw7421WerdVbbZ2y3IAKwGGWbkacYAx/+pkaCYhwgwpUs1OwfJFYFeI8uzpH2oTHRs5F+SUX9FwuDaV6/aAkUJgM/VqLKWwy7SwY49/+lCDVRjLRvGo1kW8+rFyJSrJ3ffVeDobwpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996131; c=relaxed/simple;
	bh=RQcwykeYHTgbqjpKXiTFroVVuAfATOjSg9qgHq0Rr9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6Mps5Nkkfha7JZgxuUNMvc9waCnQEhlsnNtJKENrINF8SXnrf64+A86ka8zbufxPNdUAZIfvdHdUPObbTa/sUT+B8y4tiBxqwhErMcEENihJTj5zDt11rKdzNQ52VVGpbP92TsWaIcoUM9ro1rfgwWGb3qMjmQ7pINf36foeEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgZ7UBNb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742996130; x=1774532130;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RQcwykeYHTgbqjpKXiTFroVVuAfATOjSg9qgHq0Rr9g=;
  b=mgZ7UBNbrO/1XXk0O80LsQOW14GUh5ALa7fPI6AxYWkQXpb2b5UgHtGQ
   7hDLTTPTswyhM7XqNSui4elf+PJ5Y8xWIhuXu4jkAglIWLVuJUMfIbsOa
   r3pcZk4bvKLqu2Ec2X/sAbLhLyGS4YMfbixjDoScIdWabNeA7wQToA+Vo
   kA4CDLGEkzNiGuG5FfxjaAbWwuyQALLhVqJpWrYlaA+uhqecLy9Tq0K4j
   bmI6mPPpXbfPMWy0gyhzHUf+F/CvakAG544OTGNqZb5nH+jZ99you9Aku
   BkQtsZz3wlDMRAwfSxVLPQBe98qKjmDRSZtnH2jNHQ6F430arCPYICCF0
   g==;
X-CSE-ConnectionGUID: PXNELGP0TpmZFTA86wfu4g==
X-CSE-MsgGUID: wwgoWZBnQaeg2EwO+XXnMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="54487785"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="54487785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 06:35:29 -0700
X-CSE-ConnectionGUID: yooKpc0rRLy0c0K0CwSn4g==
X-CSE-MsgGUID: W2sCT6qmSlqxI4+7E7yeSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129613368"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2025 06:35:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 06:35:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 06:35:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 06:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9S82D7fSlCRAsgfDZphq3+eoD0XFmipw7UpoiuiAu/Qf3w7O5gw4FU9CZWUxvF7FUtcNWzgDYHIoxSI0o8qd5qydH5popOJwQVjUWBPtbwaZ95iGStENftXYh7z9gsL/cfmUwIz6ePmn189F4vcfYxZrmpAPSO1n3y7v501u8zqERaXQJHN4YsIxNZFp4wTsyM84JU3xzYEs0PtDnqCER1bTHeaT0xsWIc6ZICKiBJy1rAce/zkgEiToLwwS7ChuUY5Td6Dvj72Ifdytc2OGk7Deoi49QBPXwBVcxqmtMcFazz0iPaCsGGQb5fTFl0C+JUN83eu6fPgZ4qBNSQHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3aUA4w9Bqg+zhVdx67/0BidIfIHuXlRnRoBcpc/pq8=;
 b=A8xYIzChGrJ0Tl7ETDNbG26Rc63eeSY1cf9a4VE12gRxqJjxZ8DPw3abs1kfFO4tm7V/0JygiVbamLlOOqFAB4DGBOrLznjGNs6UHshhbRvXE7Y/npvkr9a5CGPJAEAUDCH0Ebhnix/pkdFBTva1ckjG2hGRqCrpEXoLR4bH4VFOy9JB1f88TkJsmBQFYQtk613x4xZX2XkRR5QvKS5qijI/PRPgcCHwGmqz/9qhZOI8h9cni4HnRB9v9GTdm8XTa9YGi97pJ0HPtNO53Y3MA1O/tR4Ve2PR2VcRHd9w0jUYGfNc2YYJOG+0GpuHAkOQqNnZPmzQNiv74U3kp70gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM3PPF7D18F34A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 13:34:58 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 13:34:57 +0000
Date: Wed, 26 Mar 2025 08:34:54 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Fix an out-of-bounds shift when invalidating TLB
Message-ID: <7r2m5yyuigo5b53uayvyoclnae2t6kev3plxsnlwqy3cfmkux6@gfpjluntolqr>
References: <20250326115117.14673-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326115117.14673-1-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM3PPF7D18F34A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7619e34d-e24c-4786-06d9-08dd6c6b0025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?c7ksxL28QrnfDws6RONSxn4h8pB5uA+UClwgKX4RReHDp7DcXkGdQLTr8H?=
 =?iso-8859-1?Q?c5vjEEGPryel02pATCdoUvL+NI657sNEATlqbiWQjCN0lNItp1Swhc5s3h?=
 =?iso-8859-1?Q?6bLb/CLAH4mgrITJfnrbYbXZal+U615QeN4BTjWH0P2VF7uvWsNXI5QPp9?=
 =?iso-8859-1?Q?NFy8KD3pJJ2hN6MgVMk8Chz7yWWujY5bEKhxK+GCOYmIaM5wWDSdafCnIb?=
 =?iso-8859-1?Q?ImUVnyrWVxqFNrLMrLLQwDJc7/M4DfUwbWx1tLgakKBFHYx1GGhxXXUyHc?=
 =?iso-8859-1?Q?8ekBhI/kkPs8220HXyrajXQRPS3hYliBdgsFUqSfdpNhg4Mx6t2CtEtOBn?=
 =?iso-8859-1?Q?VjB7gG0Hmsvk2v9ct0hquaiXo69twYmkGT6h7WEKZUIBoxWvoQDvqu0uUH?=
 =?iso-8859-1?Q?aJlm0motvF/oyyKIz0qts7eecIc/gWmi8cH+PqXgaa7XRtHqZFsVSu0gtU?=
 =?iso-8859-1?Q?DVVodL4vgDx1poj14zyLF/nvZr9Aa8LywqWuzD/7gkj9rTIeNu8L0lDEbz?=
 =?iso-8859-1?Q?eRdzGLGFyr8a6IyMp15AOZSBs9haSbhKJ2/01NaznG1UwPizOrDP+R8337?=
 =?iso-8859-1?Q?wCNhTs2wYsUOHSK/N+VY2+oYugB7wSjrzeCPuP1Fyn5t9iJjT4eQu3qTo0?=
 =?iso-8859-1?Q?J+iwwuzIOLJPiGVBl8d3QWfCZYRRFRlKpGnjdOt1LOHLBuO5hZFy5q8nWO?=
 =?iso-8859-1?Q?qMag6qWrzjXmpR2G+6d9yLz9JMi/TZuKVgVwPSnR/yDme6UHU63MrPMrvR?=
 =?iso-8859-1?Q?GechFg26ugehD8Ug+rqbSCTdqLoTetb+Eqk51CQC5gEpFsf5iAtQsguveC?=
 =?iso-8859-1?Q?YGIsmZSGBAgYdbdd8iTgN6pMaMiDRgdBBm+6FnLtuTotlO0T5evB1j2wcN?=
 =?iso-8859-1?Q?HVQXPw98362qS20EbSXLchxMR3v5QDhRVnkRH1fNMha1VU8RY6rSCYJcQO?=
 =?iso-8859-1?Q?Q2Nk14JpkpSy0wXYFdSbEdcma9+aY0Z+7Hgl6YWukBUsqhzuoiF0EEnvyv?=
 =?iso-8859-1?Q?yZh80/PMXjPlpfLSMnsagjt/iqljSEa/dSmykwfIO9Zr0DhzchcyH4xwOO?=
 =?iso-8859-1?Q?VHxnr/NY7196IfkTinnsqMJ89iwqsrgp0pBSF8qfmtpIdK3bvDw8bOezey?=
 =?iso-8859-1?Q?AmxqzDk12KcxLpq2AVQJScPH5kzsCvxfOB/zpGlww1jPg9f/H5NfwfoRL0?=
 =?iso-8859-1?Q?IAeK6X9UI0vB26Uwt7Z+NIx0bythuSLOPx7OcHWaDcfZXgMgKq9EO31UTp?=
 =?iso-8859-1?Q?e6N60xZ4zTJaPChdjO/5MvHZVxTBGvvLyWMyrda/1P893j8SEtYTj+p0zb?=
 =?iso-8859-1?Q?1XfwjhJFhSKBCs0XuWJi7azbY3evhB0E3axoV5T2CjG4MSDNTTHrzLqBu7?=
 =?iso-8859-1?Q?r6QKiNRcpzqA9prDeHPUnXrpJdz7BYX0XJbD/01T3MK9iwkL8KUatb3RPE?=
 =?iso-8859-1?Q?v07IUG0hs8bi6n3h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7Ffkp69xbLzdmb8XnpS2nbqhsJeMJrVb/yKtn7FfqvpFGETiD1KC/QIY3y?=
 =?iso-8859-1?Q?J4h1AghaO2rIyTBY6Yq+lRPqy2a6wQ0driKOzCKG4vwtgQ5iNn4f55+lfO?=
 =?iso-8859-1?Q?KlBzKuY1itzYRpdz1GSBFtMo6rLv4yfHk1T9xuhSv7JKKyaSzXYUdcvBYF?=
 =?iso-8859-1?Q?Dyz0hKlRqPSWAHRTpgFNXxug6Hx88oT99B8MydeMO89WJ87rKqYN+XrDEp?=
 =?iso-8859-1?Q?TiaPrXER9vdMMRjpA7zJsYWtSB1Vnd8jlt9sglqlA9AxZOh60ukYMi5RZP?=
 =?iso-8859-1?Q?wNX/F1WFbUroBJ7JOJFIjChCZARKFelRcPo8X4CyRJs2aR1YlXdVT3Jupz?=
 =?iso-8859-1?Q?M/w6crXAeiUcWSy2ExrHtm3kFKCn7eubkIuiQQE/2qTrV2oI3qBuEr25M3?=
 =?iso-8859-1?Q?T5bSbFypKfxKpQuO/HZyIYhswWPrNWCFsy7vQsFWNPt/vi0PVDwHN6S33P?=
 =?iso-8859-1?Q?ZnES7uhVuRMLGPrIbH0nI2OvhvHp1YpqgiNsQq/6sKFUBpzRW5j/U1dOAh?=
 =?iso-8859-1?Q?Z4W1cfmMO4/gv4N++9GRa2vyw6C1yOy6IT9hkWQ+n1UjGyD183Um8MwlDT?=
 =?iso-8859-1?Q?eMh8MO1HqpjB8cnSq4y5yMsiJl5QMtj8K9J8g2bMSZmVjfJQZ3wnq6IrPs?=
 =?iso-8859-1?Q?oC5dyLlOorHTZ+DWnaA4HoJ9LaPO5Py64z06c06aHtgAjr0Wrf85ANXGfw?=
 =?iso-8859-1?Q?TAgcQrX81V+QQ7b6wbX3VEWt7RgXQC2D3Iajnr1K+JEvN7uWEPtzFJAxRl?=
 =?iso-8859-1?Q?Kc6x+UE7iAeap9h5P+BD9zwrwahzFwYSm6KRR0wyQ6AlqQO+MFCVW41Prz?=
 =?iso-8859-1?Q?RrBcWAqLCVZxq7jVTEwTLKt6g4CebPH7o0y8PEHAmNsRa08B6xejipX26u?=
 =?iso-8859-1?Q?73wLoRNTSmBV+vD6I50AWiuiyF74zyNm3qSjsNsk/Eg/6q8xn/5v9ZrcKd?=
 =?iso-8859-1?Q?mcL0+EdCqmiPWQDinAJMCjehg+HftsNAEc88oaHyX2U4NFHZpvgzTztIa6?=
 =?iso-8859-1?Q?Fv/C+ODbclBgrQSVw/P1QwAWo7KfqqO8wEHkwg/a/q4a6iWrFsrtfg0O26?=
 =?iso-8859-1?Q?sA1fg1O363PeHTohJpA1AwEaeNaWkL+fT7RtLJmN1sWrpnAnokzs834WSN?=
 =?iso-8859-1?Q?YbQoXdLZU3dD4WNmyP/sKbx38IcVqUS/9go1kUvAi5EmdmtOcyzB3Ftrf8?=
 =?iso-8859-1?Q?9K77zr884g/1PuzceezQXoctpKw4HYqKBfaoyiS/U3GvWZN8l2JHXKhAkH?=
 =?iso-8859-1?Q?9c7hPuhhaYWTfomGUj4Yaps2PriXm4KAVHUmfOg4066sT4kMI+FbaJnlqR?=
 =?iso-8859-1?Q?EyeveHGY8ymGxIGRIjB3TL4jtG2C57nlSqcBWEynoaqs0lH7OfoApuvxRw?=
 =?iso-8859-1?Q?AFS8cDxE3+1/twfJcVU8OWyaRSEmDmURL+qwi5FHaAbzEY+T27HqX7yVzu?=
 =?iso-8859-1?Q?nAq60CNufs6OMfqF+orFaMPCIDSU13sofsA4D2BClP6hxfiZOU3v4t+Xf+?=
 =?iso-8859-1?Q?TWgbq4WIw5VAu0t6m2rQIjssDqPfMaLW1Sig7Clac8DeK1OBOfLIvmOTV7?=
 =?iso-8859-1?Q?k3BfoE/28Im56ApzfqBeP2g40t8OOkSNDiuw5O6fu/5mAZyRJO3omXIKHJ?=
 =?iso-8859-1?Q?yJKT4OcpHiC8tQfqgaa7Npna3eT4VfHkMwjIcHOyGVTn+zQyos5yF/WQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7619e34d-e24c-4786-06d9-08dd6c6b0025
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:34:57.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMeSKfONlt8SdT49rvjm2BNUI0pYxBNfRwtB7ABTugFIz7OsAFC87m5IMQsDqfs8v04p+dJVqGH433RdJLASybakLB/pG3F6Qz6eXrXI7tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7D18F34A1
X-OriginatorOrg: intel.com

On Wed, Mar 26, 2025 at 12:51:17PM +0100, Thomas Hellström wrote:
>When the size of the range invalidated is larger than
>U64_MAX / 2 + 1, The function roundup_pow_of_two(length) will
>hit an out-of-bounds shift.
>
>Use a full TLB invalidation for such cases.
>
>[   39.202421] ------------[ cut here ]------------
>[   39.202657] UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>[   39.202673] shift exponent 64 is too large for 64-bit type 'long unsigned int'
>[   39.202688] CPU: 8 UID: 0 PID: 3129 Comm: xe_exec_system_ Tainted: G     U             6.14.0+ #10
>[   39.202690] Tainted: [U]=USER
>[   39.202690] Hardware name: ASUS System Product Name/PRIME B560M-A AC, BIOS 2001 02/01/2023
>[   39.202691] Call Trace:
>[   39.202692]  <TASK>
>[   39.202695]  dump_stack_lvl+0x6e/0xa0
>[   39.202699]  ubsan_epilogue+0x5/0x30
>[   39.202701]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe6
>[   39.202705]  xe_gt_tlb_invalidation_range.cold+0x1d/0x3a [xe]
>[   39.202800]  ? find_held_lock+0x2b/0x80
>[   39.202803]  ? mark_held_locks+0x40/0x70
>[   39.202806]  xe_svm_invalidate+0x459/0x700 [xe]
>[   39.202897]  drm_gpusvm_notifier_invalidate+0x4d/0x70 [drm_gpusvm]
>[   39.202900]  __mmu_notifier_release+0x1f5/0x270
>[   39.202905]  exit_mmap+0x40e/0x450
>[   39.202912]  __mmput+0x45/0x110
>[   39.202914]  exit_mm+0xc5/0x130
>[   39.202916]  do_exit+0x21c/0x500
>[   39.202918]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
>[   39.202920]  do_group_exit+0x36/0xa0
>[   39.202922]  get_signal+0x8f8/0x900
>[   39.202926]  arch_do_signal_or_restart+0x35/0x100
>[   39.202930]  syscall_exit_to_user_mode+0x1fc/0x290
>[   39.202932]  do_syscall_64+0xa1/0x180
>[   39.202934]  ? do_user_addr_fault+0x59f/0x8a0
>[   39.202937]  ? lock_release+0xd2/0x2a0
>[   39.202939]  ? do_user_addr_fault+0x5a9/0x8a0
>[   39.202942]  ? trace_hardirqs_off+0x4b/0xc0
>[   39.202944]  ? clear_bhb_loop+0x25/0x80
>[   39.202946]  ? clear_bhb_loop+0x25/0x80
>[   39.202947]  ? clear_bhb_loop+0x25/0x80
>[   39.202950]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>[   39.202952] RIP: 0033:0x7fa945e543e1
>[   39.202961] Code: Unable to access opcode bytes at 0x7fa945e543b7.
>[   39.202962] RSP: 002b:00007ffca8fb4170 EFLAGS: 00000293
>[   39.202963] RAX: 000000000000003d RBX: 0000000000000000 RCX: 00007fa945e543e3
>[   39.202964] RDX: 0000000000000000 RSI: 00007ffca8fb41ac RDI: 00000000ffffffff
>[   39.202964] RBP: 00007ffca8fb4190 R08: 0000000000000000 R09: 00007fa945f600a0
>[   39.202965] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
>[   39.202966] R13: 00007fa9460dd310 R14: 00007ffca8fb41ac R15: 0000000000000000
>[   39.202970]  </TASK>
>[   39.202970] ---[ end trace ]---
>
>Fixes: 332dd0116c82 ("drm/xe: Add range based TLB invalidations")
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+
>Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>---
> drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>index 03072e094991..79f8fe127867 100644
>--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
>@@ -346,6 +346,7 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
> 	struct xe_device *xe = gt_to_xe(gt);
> #define MAX_TLB_INVALIDATION_LEN	7
> 	u32 action[MAX_TLB_INVALIDATION_LEN];
>+	u64 length = end - start;
> 	int len = 0;
>
> 	xe_gt_assert(gt, fence);
>@@ -358,11 +359,10 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
>
> 	action[len++] = XE_GUC_ACTION_TLB_INVALIDATION;
> 	action[len++] = 0; /* seqno, replaced in send_tlb_invalidation */
>-	if (!xe->info.has_range_tlb_invalidation) {
>+	if (!xe->info.has_range_tlb_invalidation || length > (U64_MAX >> 1) + 1) {

maybe add a

#define MAX_RANGE_TLB_INVALIDATION_LEN ((U64_MAX >> 1) + 1)

here?

Anyway,

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

> 		action[len++] = MAKE_INVAL_OP(XE_GUC_TLB_INVAL_FULL);
> 	} else {
> 		u64 orig_start = start;
>-		u64 length = end - start;
> 		u64 align;
>
> 		if (length < SZ_4K)
>-- 
>2.48.1
>

