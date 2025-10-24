Return-Path: <stable+bounces-189225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5848C05804
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735CC1B86791
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152D305065;
	Fri, 24 Oct 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuDbG45f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B68274B2E;
	Fri, 24 Oct 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300474; cv=fail; b=QbpTBLKgW/trVoxESdR+6CwionEicreAC4GQkhyACu6qjqU8AO8NT04gAgBn6hbrllUpQGyCzGU0sFVkROZ9PxxNu/XA6sSvoRy5bV5NlsTWVxJ1VbcI+0Dgh7QyhUBAzMtodWSo9vUAas+QctLlH+rU3fkujwNLe5LBuT0CKSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300474; c=relaxed/simple;
	bh=8bYO81sHsVNeyaFrpXCIh9id6U87szaHP8nBWFh315A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1Gi/cOVpXzkFTe7mHx0IMSGYLwgy3xSc1EMfB49mMkDfnA8oK2qdUSxBtsa6ceNpvCS5hZgw8cPF66wDF4fte4tVoBnfqTRADuquq6xVGRm6UNJtwExzRl7s1GsJilgCS7mYbIxiziicrG79PQlBFso8bu/D8kgsdCcMl/irKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuDbG45f; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761300473; x=1792836473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8bYO81sHsVNeyaFrpXCIh9id6U87szaHP8nBWFh315A=;
  b=QuDbG45fLzcBdqm1bggKtxcQOMTUykmiTbc2kuArqlXRD9Kr8Ei58FW2
   9+V3OCtVk9E5tRtTw9KuFt2FaASolNTK/79joO9fP331S0nHaRpgXDW4C
   1WtoWlCoEu1z50qXDVybMffpcM5jkzrCaFUG8xfp7hn4jKG1xLvXORVEj
   yvsLBT7bPCtWaRvCfI8THZIDz4c3Rt8RvEOXv5TaPgxGtUSDHyYX4GdZ+
   NajZMEysRePrB7fm8Lqg8KeWcOwKNm+vMRKO7FpQkmrxXPHgmybXuTwtV
   tBZPoVbH+DNyJzCZBTTjb3w8uiB9sq+XBax5L069ntBG8e/nuhdfq+2Py
   A==;
X-CSE-ConnectionGUID: 7xpfTed5R6KyuoReL0dRjg==
X-CSE-MsgGUID: /0SkSqyzRy+ZJLQ+Q17Hpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63576819"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="63576819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 03:07:52 -0700
X-CSE-ConnectionGUID: fgJXbV9bSpi1ZijjGtliCg==
X-CSE-MsgGUID: JsGJEQFKRXG/S4aboDCKTw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 03:07:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 03:07:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 03:07:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 03:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgmRTZaU3BtDvlzj8t0CSS2VEKyACdoNFbnXJJikFr6OJhhoYkP4h/d8o+/kuHtRlFbFym06ji716iLXzK1S1jk8tszp77CRjvgGznKK+N3d9zEL2nd/zqYxXCKREsMCW17xAp3c5OL3urxKGHSGdaI7TdWghUia3sytCbZVGfGDBsHYj0uYbqT1lKvryhyQWS6eje/LnCSxdUg6nUVebwWLfptLbspXCg6DFc2PtZdfclFhfa9H9gFPAma8+pYMd/69sgCiAR8q1KbdNkyDHBmZzeUuPfyIYSYMws65fe7qRUmQZGxH+/J/Qy30VF9dmp5wFdorhFbba6IEpolafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brkLX7xGLJuMyRtHW9cy8l3fijMIn4oZdocwoUHJBNk=;
 b=MtZ6BV9mHtIsuVzuXuwmqwiSjE1DFeZ4zBKGdnSvoWP+I+uGWp6U+umcIqo2h7ZuV/ZZfEeuP6cs+PF+8PknMsgHBUtLchgtSlSRDU4VX36m/EiuYgWebFeC/kK2U+BVhLLdsEZAYbvz6RoPej02ZjuzPx9fTe7l6dpL0s4GVWLsU0U0apyd8vfZA/9k3ZQhFrKX9V+V/I24a2hJjJAqL0W64cqC7Pxiyzgdzr8sGBPsf620wtNNcpV5jnAmPoBN4We2e78iVYpfwS0h/jkG3k4vyyhFf4HRZTK5sKfOGO7pqdAALgQ2nDeH7dDqcJcpahNhq0MENvOZ55wTxzRSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:07:44 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:07:44 +0000
Message-ID: <67e81a9a-56bb-4a24-81ce-43e50bfdf869@intel.com>
Date: Fri, 24 Oct 2025 13:07:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Disable bounce buffer on SDIO
To: Linus Walleij <linus.walleij@linaro.org>, Michael Garofalo
	<officialtechflashyt@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <stable@vger.kernel.org>
References: <20251024-sdhci-bb-regression-v1-1-b57a3d4dbc9f@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251024-sdhci-bb-regression-v1-1-b57a3d4dbc9f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0277.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b343ed8-67af-457c-8382-08de12e52ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU9QdTl0bDJ6NmJIRzVQVXdoWnVmUCtkeVZlTG43SHNjT2FOREx3WmphRHhV?=
 =?utf-8?B?ZUowNk0zM2loMGQ2TDJ2ZG1laG9rbmhOUUVyeVBYSGtucUx5UmRmZXRudEsr?=
 =?utf-8?B?MFlkZEVtZUxkWWZQWmdHQXVNSmpmeVdwaGluSDZCZnorbmxMcTJHZG5BUCth?=
 =?utf-8?B?dFBDYW5xaFFobHpoZGxaRDVWSllQaUY2akliVzBBSVhSRmczb2c2Y25VeGI5?=
 =?utf-8?B?bURxak5oUTJ0bUhKQ29MbVFteDkvRzcxWFEwZHgzWERRQWpWajg5N3hZbkt3?=
 =?utf-8?B?WlE1elNNMkxuOHQzcVd0MDRkdFpacmRURkFjMWUwZ2I3V2dlRHBMcWxUUXZu?=
 =?utf-8?B?MjhJZWdPV0NkT0JCdEFVVGxtb0lSNmh1TW1GUzY0WWhQTWVQUVdteFRVM0pK?=
 =?utf-8?B?UWtqUHg0MStKRW1qRUNYNnNKY2R4dFFtT1NVVnBkbmJVRmh2R1lvU1VEd1Bw?=
 =?utf-8?B?WnhtMmlhRlF3a2J3cjg4bHBYMUJFSlBJT24rbkdEeFBWdzZ0UkNxZS9rZ3V1?=
 =?utf-8?B?QzZQN0I3bXI0K0ZUcE1jQTJWTktwallNZFZrZDl1ZXpoTVJjL3dHZkhjY2gy?=
 =?utf-8?B?OStnLzJZejRUUng2UmV1dDN2WmhoM1BIY2d2MGhyb04yeUxRTndsRXZMdlBZ?=
 =?utf-8?B?L2lYNVFYam5uOXhDdmZkTk56L09ZbFlZakI1TU5vK0FJQno5UTFuWGpzWnpv?=
 =?utf-8?B?aDlsQWprZGhhMlpZMlZWZzdqNWxqWC93VWlKU1dLenFGVjVQQkl3eXhLem4r?=
 =?utf-8?B?SEpOY0twNXVtWFM0VmwybDZ4bXBtQVU4OGwzRFczR3U2cG0rTkdrMkZUelhS?=
 =?utf-8?B?ZFRITnJVNzgwMFpZSnNNYThUUDJZdC92UVJ3MWUybjFVR1lqMjFwU011SHZi?=
 =?utf-8?B?alFVcWhTdHZrVm1oTk5iK244WThEZnNWd3FueHZ2eVIwOHlCdk13b0ZyampQ?=
 =?utf-8?B?RWxINXBPNkFVUzhCQVFoSHZMK0tzbGUreFUyVmxyNkorTjVnVENVTjdFaFUz?=
 =?utf-8?B?WVNRVG40VExSdjZBSkFJVytJK2VValovbC9qR2lmWFRKdmJ4SXEvWU1Qbkl4?=
 =?utf-8?B?NzV5Nm5vMXY0NHBqdzV2dzE4VzN4RGVtek1tVmM2MVBKUFNyY1dJUTBxRlBk?=
 =?utf-8?B?eXRyRll2ZnVwd0pXdDdQS2lZK01XUDZSbllVTVBlQ1doZjRkbER1aXhDeFZK?=
 =?utf-8?B?ckhlUTVDcVVHaHFSb3hlMGVzT0h6bmZLQlpBSDJVMVVHcXFGOTJ3SkhzTXRu?=
 =?utf-8?B?WWRWU2xJdzFnVnM2TmZMWFlZa0pNOVlDWmdXSzU4aHpteEJwNlJLaHI1aDRw?=
 =?utf-8?B?Tk9FSkVYOGJSdmFGQTlqVEk2TTlMTEVPaEhHT0E4akpTK2djY2lXRFVybjZR?=
 =?utf-8?B?ZmFiOEFEbm4yVXZjQXlRa2JLWnlaU3dLaUFyL1F3ZStDcTNCV2lZT3BZZ3hi?=
 =?utf-8?B?YTJOVkgyM25aZW5MMHBNSEk4WGQzSC9reTVJUFVTd2ZORHJocERsSFk5NzMy?=
 =?utf-8?B?SkovUTNPRmhtQnljQ3VaVlNJWXRZK3hOWlRQbXk4eHV5QXJXSzk1TTdzMjMy?=
 =?utf-8?B?NlRpZnE3OGJjRlBhRjV4N05WSWVXaDZtWHRQcno5bTlLK0hJSm9QaHhYMG5q?=
 =?utf-8?B?QjA0WUJHTG1qZGM4azdweXIvelhDTFVWamxQTzZsZWVyRE5OUXpJZElJRzNB?=
 =?utf-8?B?enNObSsxK2lQbktVT1ZlZ015VDZSVmpEOW1vTDlPR2pwWEZ6dkxtUGlBUGZS?=
 =?utf-8?B?UldFWnVYM3hveW1TelZlYkR4SktmSDgyKzNXTCtIZ3ZIQzBsQkpDdmxoOTRx?=
 =?utf-8?B?VWtqV2QzZ2UvTjNLMzU4VDE0UWtUTkZPUk5yVGJzcExVeHIwdWI3dnl3dDVS?=
 =?utf-8?B?dFZUNkxKU3NWamRJbHRYcGhLTUN4K0VlQURJUDZuSVlBNnp6azZBMkc3YUc1?=
 =?utf-8?B?SmxtK3dnZFVuQkZ1a001RERIYktBMmY5MXlGNVJBekRkYWdTQ1hmb1M4ZlpR?=
 =?utf-8?B?WVBuclFuUExRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRxUVBWeDhLdkl4dHBzaXpPWVNsM1BvYVVUUkNMS09QeE9heVpoSDlQemJ1?=
 =?utf-8?B?NzUrVkF0MzFFamE3NzRLM3lraTQvMVRSY1dzTjV3djBkQTE3Q3ROaEFUcjBz?=
 =?utf-8?B?dGszYVk3SVFDUWJkZVd2Z2xRczVLMVFzaUFIZzBPVXVpZW1Ha3cvdlY3bWVS?=
 =?utf-8?B?ZzhNSmpDQjZsZm53SVh1cUo3T0FnWXF1VTdweklCRElWQ1ZFSWdBanBoTklH?=
 =?utf-8?B?VnZDM1dqM0ZabVZ0R2NqcEtFZ3kyR0tPZ2t6ZXdzQ3o2Vyt4M2xidmdiNDNU?=
 =?utf-8?B?akVaMndPT1U5QkRaL2ptNmpyMTg2cnQzZE9HQ1FYQ0pUV3ZZVFA2c0MrWXVG?=
 =?utf-8?B?MU16QTlDYm0reGVpc0FaWU9yUDFyRHpFeElmZW9BYWtHNjNCcnlqa2VGSnhP?=
 =?utf-8?B?MHdRcklJUWJMcEl2MkJaM2JlVDdFVGZhaFRXVkU2N1lXRVgycithaHphR1hD?=
 =?utf-8?B?KzVNZjVGby92cXYyWXF2dXVpSmNJaUxQMDh2Z3FzZTB2cHFRUC94NzZnNHZC?=
 =?utf-8?B?V05vNmlva1pESENQUkpSMjNTUW5LMWtTSllhZ05kdFpLeitaa09LM0YxdzVq?=
 =?utf-8?B?TG5BNEJwVytZZ1Zsd2R0V1RCSWNFcVl3ZjVJWnQ3LzNVaWZEVGFnWkpHK0RO?=
 =?utf-8?B?VEZuY3p6TjRHWEUvWkV4cGJyTE5QWGhMNkxhcGtiRlg5QkFhblRpZ1AxQ3A3?=
 =?utf-8?B?S3RwTDQvN2lQanh6V3VXMmZIN3lXY0ZENzFVTm5CRUczWGw5R2VaVVdOajZP?=
 =?utf-8?B?eFlrQ0QxaXZiMFVCdVJldFFjRDZISkJkcFg4TEEzb09sNW5sd2djbkNRaUdO?=
 =?utf-8?B?dUpWYkIrb0NRcnphZE4vQzlQSHFuK1ZXUzVZMlFqTXFTY2R5M05xWnRrL0c0?=
 =?utf-8?B?bjVNNWdFZzJsNnRxZkkwTFFNT1ZMZWpoSEV2OWc1UzhxL0NMZ2NTOE1TRlRn?=
 =?utf-8?B?dkNYY29aL3FkQXVKSitad2lyek9WNWlTYzhJenJmUWlmNDBJVVNZTmFCeHNC?=
 =?utf-8?B?Y2l2alBQWHh0VWloSG1KVENadHFoN3VVc1FjN0FpNmlVQ2VBKzNNK3F0WXVG?=
 =?utf-8?B?MkxiQ1N4WStKbjVFeFA4M01BNEUzQnBIQis3d29KcVgwY1ZQYnFFZlNZbE5r?=
 =?utf-8?B?eEdVNldaUC80WUtiNzRnWjFjSUVya1RMMG1uZlRjcE5oeTFBOVJxeVFsZUJa?=
 =?utf-8?B?MENrWkF5R2hTbm42bkNCNTJWSGp0UzBvUG5ESWRrbXZKbjVqcWxkUjN3RVNw?=
 =?utf-8?B?NzgyOXp5ZXBneDRlQ2oxT1cyUjQ2MXR4YWhVRVFtaUs5RS9pcUY4RU9RSjMx?=
 =?utf-8?B?aU1SK2sxdzZYbUZSSGlybE1ScFNKUXFCOG9DZDBycms3MlpvOU5kVVhHdVRG?=
 =?utf-8?B?K3JQb24wRy9nNkZRMW9IeUhPVi9FenE0QlVDdUJEbTZWeVJXc01DTW5MMFFa?=
 =?utf-8?B?Ylo4dlBoRmk1UENFYm5xdm8zYXc4YWlSckpqV0h6QVM4UGUrS0xhQkU0cXIv?=
 =?utf-8?B?K2xkcFcvU0tNSHFtbCtyTTN2MjhzU2d6WlFRcDEvekoxdy9IZ25rQ25Lb2pZ?=
 =?utf-8?B?aHA2L1Z0V2dSdUhvNERLWVU5ekVEOUpFL01VRkdkUjYzZmYvTGQ4bU1JZHNS?=
 =?utf-8?B?WXZadkdOOU5iNTNFaEY2Ni90Q201dkExeTRvQmV1SzhQUXFHb3c2dTJVZ1pR?=
 =?utf-8?B?QjRXTGZTaU4vaWcrVE9sdFJrUi95SDFnNWh5aHFqQVladFdZajY1VGZTYTN4?=
 =?utf-8?B?cm5RZnBjMEV2bjZ0L3pYSDdPQmhiNmtCbDA4WDFjYWMxT0lubDIybG1COTcr?=
 =?utf-8?B?OUdMVlJPOFR3WmFoakN2NVpwNmZmazVpNHU3aGlSM0psRHF5d0ErNzBmVGkz?=
 =?utf-8?B?RFVlRnVEWGtwbVlSRXRjYXZaQmhhTEdtK3picUlReHkwUUx3ZEpacldwUWlL?=
 =?utf-8?B?MjlNVUVtMU1ZWE1yREVZdTJmaFhISXhKL0FLU0RhWm5DeW96MXZUak1TNG5w?=
 =?utf-8?B?bFFRWExyTGVxanIvWVlUd0xiakJVbk0ycllkekxidnZtMy9zd3NSMHl6cWJG?=
 =?utf-8?B?Rk9jeFdjeU5Ca01hdlBWZ0ZrQlpQMzgzSldiKzF0RVBzaHYvUFhqaFQ1V0pn?=
 =?utf-8?B?dUwrSTVLLzZlMWhybGdGYjdpQkd0VDVFSERmUDhKK09wNlByZ1loazhQODNo?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b343ed8-67af-457c-8382-08de12e52ce1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:07:44.6114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzhsWFnL/MdG9OWk96IWLvsl5gQBM3z4vKcCp1roRT03BAF9vLcG/nc/iGLmd5912ahoNOhHgsCEn4hLVJcFoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com

On 24/10/2025 11:40, Linus Walleij wrote:
> As reported by Michael Garofalo, the b43 WLAN driver request
> a strict 64 byte block size because of FIFO limitations.

Thanks a lot for looking at this!

> When the bounce buffer is active, all requests will be coalesced
> into bigger (up to 64KB) chunks, which breaks SDIO.

Thing is, I cannot see any use of max_segs or anything else that
would affect the request size.

Michael, are you using the upstream SDIO/Wifi drivers?

> Fix this by checking if we are using an SDIO card, and in that
> case do not use the bounce buffer.
> 
> Link: https://lore.kernel.org/linux-mmc/20251006013700.2272166-1-officialTechflashYT@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ac7e11f37af71fa5a70eb579fd812227b9347f83..c349e5b507b63a5ee9a9dcb08ac95cae6b3d7075 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -650,6 +650,21 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
>  	DBG("PIO transfer complete.\n");
>  }
>  
> +static bool sdhci_use_bounce_buffer(struct sdhci_host *host)
> +{
> +	/*
> +	 * Don't bounce SDIO messages: these need the block size
> +	 * to be strictly respected (FIFOs in the device).
> +	 */
> +	if (mmc_card_sdio(host->mmc->card))
> +		return false;

sdhci_allocate_bounce_buffer() has still amended

	mmc->max_segs = max_blocks;
	mmc->max_seg_size = bounce_size;
	mmc->max_req_size = bounce_size;


> +
> +	if (host->bounce_buffer)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>  				  struct mmc_data *data, int cookie)
>  {
> @@ -663,7 +678,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>  		return data->sg_count;
>  
>  	/* Bounce write requests to the bounce buffer */
> -	if (host->bounce_buffer) {
> +	if (sdhci_use_bounce_buffer(host)) {
>  		unsigned int length = data->blksz * data->blocks;
>  
>  		if (length > host->bounce_buffer_size) {
> @@ -890,7 +905,7 @@ static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
>  
>  static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
> -	if (host->bounce_buffer)
> +	if (sdhci_use_bounce_buffer(host))
>  		return host->bounce_addr;
>  	else
>  		return sg_dma_address(host->data->sg);
> @@ -3030,7 +3045,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
>  	 * for that we would need two bounce buffers since one buffer is
>  	 * in flight when this is getting called.
>  	 */
> -	if (host->flags & SDHCI_REQ_USE_DMA && !host->bounce_buffer)
> +	if (host->flags & SDHCI_REQ_USE_DMA && !sdhci_use_bounce_buffer(host))
>  		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
>  }
>  
> @@ -3104,7 +3119,7 @@ void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
>  	struct mmc_data *data = mrq->data;
>  
>  	if (data && data->host_cookie == COOKIE_MAPPED) {
> -		if (host->bounce_buffer) {
> +		if (sdhci_use_bounce_buffer(host)) {
>  			/*
>  			 * On reads, copy the bounced data into the
>  			 * sglist
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251024-sdhci-bb-regression-a26822c56951
> 
> Best regards,


