Return-Path: <stable+bounces-158474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361EAE7494
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E045A55B7
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8622083;
	Wed, 25 Jun 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxemAR20"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D93074BD;
	Wed, 25 Jun 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816973; cv=fail; b=t3KqXRhrgFaekDxGO6Zaq6kMttauXyLBMP0baL+QDtZjHiXOWgZmx4Mg76MoJ7BvnF4Hcqb5ipaYiMivq1IUudhnQcEqkiw7LC+/3dHOdXjWSyDm+jiALQ7b4JE8thPl4SquZT8fzO87nhw+z/+5npCftAQJ+SiPOpAv8lV9mPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816973; c=relaxed/simple;
	bh=PM20zrbSVor9WBKlQmxg7Lc60vdtdIJ5uq2G3HhaRv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bd1RPu7VKlADbSQoT4AJNTQw+KESQQEGRUyI2qlBBHVbBzWC/TVY2X7abTFRlD+OD78kq9Z55Dl0DWOX3R13c9XXsOXXKcRBW+LqR5234LUzy+nOurinHZshA+aIt0SAHtOpw+rAN4UthBichPviZtIrNHwKYW7gJt4btfmHWkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxemAR20; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750816971; x=1782352971;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PM20zrbSVor9WBKlQmxg7Lc60vdtdIJ5uq2G3HhaRv0=;
  b=QxemAR202cFQNTqK2Ya35hV1QeVsuWGSUtyenT2mMpOTTVVGB2rCy41M
   YNRDHxXEfxhX0r5RwNmJ8eyyI/0cNRgYh8FIjFfgVWXf7UPsf3yrNTMD4
   aG3JpmmACPjM5wuGpe/cvSVzNCjAPTAwNKV91HKzsYG/i1+idZh8GxhNA
   SdMAS/C3KcYYwPo3bvr5LbM/Y+mmBEMVuHcEsiDZPUHUrL9ysthumlfYh
   QNj74pJGbU4bKlCP+JdxiqgHGXqHrkg4HKj08J/l6Nd6RgVWQLM0qx4ud
   n6KvOm5veefp/xegvmzDkVy9Z3OEsSlkE96dAya3Mg0dh7irwQIDczU+t
   A==;
X-CSE-ConnectionGUID: fqDL+tmuS0ictI9nK0h6kA==
X-CSE-MsgGUID: r5v+vtD6R3SemS4AZuvtwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70502784"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="70502784"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 19:02:50 -0700
X-CSE-ConnectionGUID: REQJEzi7RNyerPsqUXvZ8w==
X-CSE-MsgGUID: Gm9Bgi51QQm4iYwMuVObcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="151490622"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 19:02:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 19:02:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 19:02:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 19:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8eM+4K8kpTHRb4djj2M8AGwO2IPaLOliaETPRHQJJWO3IDYR4dYH3vFwFqtqPhknjlQQHy28wPUG0y8w7c/gOeP4yTbZd24fBq7DxzsBg8EfNWYSq3dheB8d0JBJE95Ie1HuWSBHuvdg00lcG//K2lWtWDmwGsJcUZEsexRuYGydkb0QLojjkzO3AzTiLpeJYHF1MesN/dsKJBcymiq51z2c4PlXJizBMKNtyTe5h1ki3K1ODh/4rH7cA2BHzismKXF/q95AnJkJt0bPbsd6ZHe7kkO5xz+YyWDMqILci5rRCNfsgi0gEKPykpJ8IUq2w+lOma7a5Y9NP4LlmD8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+2K5qJt7/gxHtDsgVs17JYR1YX5/hnfXnYnQim0KyI=;
 b=dgDiJ2al318dzB4rWRwe5YgFw861lGqANzRsJA8xTX13mGIWScYd5IMWXqXoeaT3sbpZPsRv6XJxVORy/FwKadY7sx5r02uUsB9UIbKOqvr2osZlHOnNWAfj93lnD4ZLie8PK2sejjdeGB4LhdcZZW5ZbZOLaA/7NhWnluPrmu9g1fDa49Uiqq/PVSGorw33tRDwAveicgwKke4n7Xg12Z6BA9WM0tFcvKtKa2TMcrYCLx3/bSu5SkVLNqRByj8rnV4BeXWItfaCBolBrEgye8wRuwtnmACK4lJ0Ai+BJjPZOrODtRdscfsVMbSgUtGI3c7X9oO66KalH/RGczlQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CYYPR11MB8332.namprd11.prod.outlook.com (2603:10b6:930:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 02:02:27 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%5]) with mapi id 15.20.8835.025; Wed, 25 Jun 2025
 02:02:27 +0000
Date: Wed, 25 Jun 2025 10:02:17 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Chang S.Bae <chang.seok.bae@intel.com>, "Eric
 Biggers" <ebiggers@google.com>, Rik van Riel <riel@redhat.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] [v2] x86/fpu: Delay instruction pointer fixup until
 after warning
Message-ID: <aFtYqW5jGcgeDf4n@intel.com>
References: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624210148.97126F9E@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CYYPR11MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd705ce-8d59-45e1-b71f-08ddb38c5597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RkgOnCXJZcdtDEFqVkFjWhraEkIkvARJKVpoK7a1w1RWAYJpyxn+DYkkxaD0?=
 =?us-ascii?Q?KJnQQaZvEeA7fKS2DZDmoEMpyQyTDJRMS8I15i/PbGD2ICeQe3nipr2hzvqt?=
 =?us-ascii?Q?m8syZvN8ojh1onKP89mxwN5s8TyuOZVLijVf+28nJRbzQU1SiuThWkiCDT6S?=
 =?us-ascii?Q?ngotTk+4DqZ5V5I2rPKFvF5kt/fpBbpRuxYAsg3s8UoFHQDkqCIz9HIUjDz4?=
 =?us-ascii?Q?nxpH82k2zSZmW42D3OZALcrLo8riigSMibHu2GQVf2R7oYGz91Hjb6Ce5f6d?=
 =?us-ascii?Q?nIkdfUH48OBD6+l/R4fIwzubk1iA96enpdFgcdM3Z6wpYtxfOeewVWp/+Z6S?=
 =?us-ascii?Q?8ZksMGcvSdObQaBguCAb+mZz57w5mMaU093nHCaKM6cAdaN7QQl0ZLssG7qF?=
 =?us-ascii?Q?e5+9akoVLoksohncFsEcXsc2H7pMY3xshowuyTJ+LULYPE7yUsg1ObXgog6O?=
 =?us-ascii?Q?TShyNKBpuhjwyBm7WH+0q7BEZ9sxtW/nZawmFR8KMnHlucCGOpheLNCs816z?=
 =?us-ascii?Q?yzYDXkZcQhwkdizK4czaLDqgXG0CBeBQIgaycGIGAw/2ki50ci5OkTlrC5Rm?=
 =?us-ascii?Q?xeYstRzcg0wvU5KB01A91dawSu+hVIVZsS5O16F4TWvyAyULFR5fq98YMdju?=
 =?us-ascii?Q?O/rX2iLB5St155Bp+Sg/hJ1q0pG/5nzO41TkyT3Dyavy5EdXoHzVHDG8w5R7?=
 =?us-ascii?Q?QdT2g5u93+hj6WW1AN0oIyzXB7OfD/Qg5JsjcLzuRq5c+XPMeRD2tV+qNR0N?=
 =?us-ascii?Q?1y5VXrafYB1WwecHRRMuvXdHrTBAqv48u8imdyJ5JOcYix/p7iI0fsb9LQk8?=
 =?us-ascii?Q?rqIrwN3Lit/rEPCxEYX9W1+yxFxFpIpMBDXcpAC1FYGdtxfBwFvS+nr0gPO6?=
 =?us-ascii?Q?qqx1ljE8fSQaIKeKhXJLbyhybsM3Uql1DIqBu+jSkFQeujj0G5TTP8KArirW?=
 =?us-ascii?Q?WPbU7riqRS6NV19qpQNmDdsxlH/hNAiXkjIpdk4gheot8ytWwE9k1g8vzC2w?=
 =?us-ascii?Q?2CENzOPorG3GjqIDhbxGqJtxDix1qwG77t6hdMi1lJBWEMvEPq8YxV5/Uam8?=
 =?us-ascii?Q?ebqr/Z6v2K5zz42VkB+/wsKH4Bk3vzXemOVp6Fo/tpdN05h5AqzwgRBeUuQr?=
 =?us-ascii?Q?8cgSMz6Q+BJBW6nM+hD9Yhq3UNY9uPBhyE0weJ8SClJtHxIupo6Yc3xopc3O?=
 =?us-ascii?Q?z1ouX1nqzHWgOcHYo8CeGSihzvV/fFBJXDWIquIJuAoHZmMvgAW+YFH4ADMj?=
 =?us-ascii?Q?YmaGdNd+EEFhX4Emt/AjPYcGBPni46p1jwZWb2u39ie9wTt6JHGLXJXLbNus?=
 =?us-ascii?Q?XQBmNngi2EzHGFAdB9hItE8Pkoer97pFqLT9ldvzOoQL3r1Jpg48tZZd5duE?=
 =?us-ascii?Q?HvhVR3PvRduHiqsW8Cf40zmDJho42xJUWr4PRYwR0Kjw0g6W+8np9VwMNndb?=
 =?us-ascii?Q?NUZU+YQx9dY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFlxO6zqCfebx3L/W+/KMHH9cRAit5NH07uDMG8kvBYdRPSctVLbcMc4Sieb?=
 =?us-ascii?Q?Jb2P3vbuT09/jj0lk22my5k26s2/1imJI/3sbR1oV2NFujJ+WbPexYV3fqUi?=
 =?us-ascii?Q?jyMRmnCDfKAXB577B6X1Q1ASQbH2U8pmfhCRfxEQnpJB7B1yv5k3WqDa/Fl8?=
 =?us-ascii?Q?VqrP6KXPzYkW7XSMzqeyviNR9b7oD2gC3dkIW8mye/QIbEcas8MZ87gKiJbM?=
 =?us-ascii?Q?yXATW6PCWkMWT8/I7VVbgZ2q4mhplPAMSJrP0iJSDQ889yDnqZH9azChg1/e?=
 =?us-ascii?Q?DoD7WJoHfon3A96dXNKOyKjdfOl56P3kYZ9rLCAMiTqSP96F9uuQaPIbMR5M?=
 =?us-ascii?Q?anm5an/pugRhEMhnjvAf49heCKpeAUGbekfKFhc4LsoJJA4QQvsnYuYt8+G+?=
 =?us-ascii?Q?VdbPQMZv14DDDiqoIRhXOxoKUhtT94Wy0ZSqZcd1Vgwv11kamJqLjx5WvELj?=
 =?us-ascii?Q?HyAnhK78Hzt3ChwVPbMrUNqVGXc2TEoBD/itMqJlZvoDecBZPueK/QrJlmO4?=
 =?us-ascii?Q?K6DmrbBoa2OUbqm98Sp6fMfF3+Aesa9SOmtvf9ny4oemCvDxnXsw0cHRQp1h?=
 =?us-ascii?Q?LMLTWDFS3wSyNgagmRM7REf4WW1COhpLbjrqkuVFS+xAhMunHI3kejPifSFW?=
 =?us-ascii?Q?zIznF0XEU6yZRFeehcfuXKW7OEV6sxRZH1MQoD5BIucycMV3nmI35iSlhYba?=
 =?us-ascii?Q?t2BPMUsLI55h1nNzZLsUaogq81HCAviIRM964UvCyefFCQ3luG6Up/pARG5x?=
 =?us-ascii?Q?oBth+wY6IVk6+L6xJQzmOrRQeqfARMbZ7yXFAK5e1Msawd74uOsQxy9dtsY9?=
 =?us-ascii?Q?bhmzK/dGrYOjy0x7adQV9fBC1vT7LayJPvIj+DwGZhuAAFLsoDXq+OAzygev?=
 =?us-ascii?Q?w86bwNY05bX4sewV9jkuurLoRiELcp3ZNeVJxSsX5W+PuOmDKbW9mXqDaSn1?=
 =?us-ascii?Q?wxxOqTZ6z7Y6QXG5/isIAvEaYvW+mMRiF5X9aXygEKcaO3ldUVDOq2f+Cer5?=
 =?us-ascii?Q?mReDiaqNPIQXF393vUBdnicZM3mvymlO1QPh58p6m5zZx5j/ed2J6dFs6iSq?=
 =?us-ascii?Q?oxb/PNayVSpsf+zw3CimQxAf7i8YNSDCBuAo7KiPQ/yHjJeRD+wD3H9MMz8N?=
 =?us-ascii?Q?h3S8RWxCDy03J4X8qZIP60iDd0gwJ40O4jXdr3ajfwib4sfm/SiU/VkGPZi8?=
 =?us-ascii?Q?ltfDLTp5J0Jt66bIW5QnXZr/jH6XoDbaTtuAssowrseFChe9qkzk1oqLM6NC?=
 =?us-ascii?Q?hYdPd3w4/hFqtCZQGsJwiNKqBbOAIaTwaZd4agVRm3b/+kVjWnS11z2drX6X?=
 =?us-ascii?Q?Nb0jr+6yaqlJu3TXLCS5kJHZ5UAR/wpmhAOUAz4KWTgjqguz1PvPgWuWqDOp?=
 =?us-ascii?Q?RSyLWeDCOD0mVn+F/JfXpFT+JpgeJDzUWY0HRMQSolSI6DSb6VrpZxodas/x?=
 =?us-ascii?Q?QCdWoTur/Wf/SEi1XAKYwBNkthOMjULA2WkLL8GiEZwGFTUBYkEBICFqPxZn?=
 =?us-ascii?Q?8h9WIbJStjJuot7Uv5dmyMmk1HE4lXIPFKCSyBWkHagvkwCZq3xzIWWxjo/a?=
 =?us-ascii?Q?syPxqkoRPcqMq8+1O5JY3HNr7IZVHCEwMBgFjAFu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd705ce-8d59-45e1-b71f-08ddb38c5597
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 02:02:27.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHFbXhwrJB0tBSwk49Dihfl1ds8ItqiwPHir8FF+BKuDNlQgAPg3n4NtxWvJEGfD7tqNQc+vTw3F9JVyCMrRTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8332
X-OriginatorOrg: intel.com

On Tue, Jun 24, 2025 at 02:01:48PM -0700, Dave Hansen wrote:
>
>Changes from v1:
> * Fix minor typos
> * Use the more generic and standard ex_handler_default(). Had the
>   original code used this helper, the bug would not have been there
>   in the first place.
>
>--
>
>From: Dave Hansen <dave.hansen@linux.intel.com>
>
>Right now, if XRSTOR fails a console message like this is be printed:
>
>	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.
>
>However, the text location (...+0x9a in this case) is the instruction
>*AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
>also points one instruction late.
>
>The reason is that the "fixup" moves RIP up to pass the bad XRSTOR and
>keep on running after returning from the #GP handler. But it does this
>fixup before warning.
>
>The resulting warning output is nonsensical because it looks like the
>non-FPU-related instruction is #GP'ing.
>
>Do not fix up RIP until after printing the warning. Do this by using
>the more generic and standard ex_handler_default().
>
>Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
>Acked-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>

