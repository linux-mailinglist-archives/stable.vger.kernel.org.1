Return-Path: <stable+bounces-108535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DEBA0C514
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF29C3A48FB
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A631DA632;
	Mon, 13 Jan 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HC6lcoXr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0C1CDFA9
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809277; cv=fail; b=NEN5cEYTULFKYdK3yWBBNTts2IYag2NRO46AwpePsvSScbhHcol43iIA/mpXGwwS7ZWOoBycwqpvMp5bHQ8UpVlyJ50dQOH5/SnCZQPavkQGzSMlAeaXt+vBGhtYx2z7gfRlZv2kG1+Yiiuay4Ssc5T1QK8WwxpPeKt0G2T7fr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809277; c=relaxed/simple;
	bh=srh8MBlRFKGLgrYV+lFrKNKc7fcBzflJFnYkAZqzKI4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n5B48orEMPBIJQ74JUphtNGnrmitJJgfqOzMAfKMwY9VYuJDQj/MTKNLpmOW7on7Kk+8OuRKw4kaJkjfr+HYOrSlGPYrhsNfpTafy/g3ZXFKG0io784Pel3iIHTDfdu7Ec4yjMa2T9OFibsO5EKA5MDadHlL/c6ndfQtC4Hua1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HC6lcoXr; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736809276; x=1768345276;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=srh8MBlRFKGLgrYV+lFrKNKc7fcBzflJFnYkAZqzKI4=;
  b=HC6lcoXrlaaZUcXnI/elIRtSslDvGW2eq1TqoolMZH1tyEl1YBeHLq3s
   r7iPHYeQDiW96NnLjpBkorZT+dcUNg19wr354fkHqftz7FUzSrJnVQ7/g
   IHXAWj0PPWv4eT0W5oyOt/h90nFb4UWLz4i4yJVa+LCBlC9LrhJBzXG4f
   A76BlpP0xbgjZF4lFd1ouUfdZrFnUGD3CAzQMPKCItR2OYtS3o0y50VhS
   Ltmb2bJmANcBWk0X+a6+U2l/JLbGJNqT1Kot9tc7m+AKpzWxBXUe2DeWV
   sENfLANXC1hLmrG+z/X+EIyR14MackXdJTgiX++o098gMhlzCd1ikVTqL
   Q==;
X-CSE-ConnectionGUID: f2oPSIITSdSl6Le7nZJk7g==
X-CSE-MsgGUID: Cj5ku/yzQt+Puz4LhBVNzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36973950"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36973950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 15:01:16 -0800
X-CSE-ConnectionGUID: Q52F7Vb7RAeawrifcvvGiw==
X-CSE-MsgGUID: LiOP5o9eR8WlFQqyQLhqzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="135452415"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 15:01:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 15:01:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 15:01:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 15:01:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQKHsVO6NCyOqB6gn9tO8ehY/bVUIpqW7SM15zqjw6+aYJ5gZ3agRBmCS4AFh6oEkVqerHLk8Tj0Ptx/NukAAwrulLVtnfGKRrOrHaYPE/j2ddMbnrllwpzR12hqU+HeA5oNik5B4u05WKPd0Bj9lQRTLirsMIZDMKoInvTLJGxoH87B/E0Qtt/ATLju8713jpg33Rqe76jXH9UdvLeP6eRsM62HRZTKWHOUHnk3qaRnvkZebRXkVLOzXJDq1NcREAg36ot59hVgZeAZy9PQjyhsRu/jwhKJwZ8pDOMqwR88QWWqT8qGqsL9UktROkmsh8aZ7pjpOxPL1/p9Ngk8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNbocwbrF3MOxgtjSTSbyC7lDmx3vBhxfzA4Slbj5io=;
 b=oENJ+gIktD8JGfH5uBAhGTSOxJdMhdv7rJMJ6L901ABYNJ2VbX/dqW5tzge5M8HxbjUEDxPUzcVvRZ7l98CoGG1aR/APbRMpWh0vDjG5/FNraMHfPO7sv5gRX9rBXxl0/gARKa9/r/+9IEl+mKkdzp0kEDN1rEPIb/+slizBUCFm97xcB+XJHul/UGzFE/oZLXdpfz8Rs2GIVoBXJpv/tj5hSeMI4+GtAjsb3tEU2HiaNF16qF4tZcOqWHJin4pT65ZE/Jmyo8ZRaFy7osG7B3NM7qouQPxNBaEJceKedjHKfgaFUb7nurvrCAwJ0+76+rnYb3w5Q3v22lVlWWJPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 23:00:57 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::6387:4b73:8906:7543%3]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 23:00:57 +0000
Date: Mon, 13 Jan 2025 15:00:55 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>
Subject: Re: [PATCH v2] drm/xe/client: Better correlate exec_queue and GT
 timestamps
Message-ID: <Z4WbJ4DMaPS+LfJ5@orsosgc001>
References: <20250109200340.1774314-1-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250109200340.1774314-1-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 134d0747-b7f0-4a22-05bb-08dd342623b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzFoZ2xuWHRpcE1wTXhwc0lhNURLRm00VzdON0M0OFZ5dFJnZUloQTdBbU5F?=
 =?utf-8?B?YU5jQmxpNVRkMkgxRjZDZmk1OE0rMUIzRm9zbWd4UFN0LzN6enRQbWlXcDdX?=
 =?utf-8?B?RnU0Q3o5dUpHVEtFMm9IN1Nab0YvREl3Vmp5ajIxYWNGVXppWmFwc0NjR1Y3?=
 =?utf-8?B?cUVKNm5aV1k5L3RoK3Boa1c2aHJ2MjdzTjdlUWwrWXNxOVdMUEY1OStMU21q?=
 =?utf-8?B?NlNqYUxBbWIycHlvVUVpT3Z6UGRnVHg3SXRSeGV3WWlLSlJiYXlPUGNGWGJv?=
 =?utf-8?B?SzlpRGsxeVVSNEFadi9sTlU0a3pnd2Vnb2lSaDY4MWZIenVUa3JSZzBkTjVv?=
 =?utf-8?B?aERsekdUY2drWWtkUUp6R1pvak94S3JSVlpva3dSRUE0WmkzL2J3YlI3bmpD?=
 =?utf-8?B?ME5uRjVxRU1VN3lpTlFrQzVyWmFEUDB4K2tnL3J3YUJRbEt5Y1FjRWdQTzBx?=
 =?utf-8?B?TTZoZnVWckI0enprRkRuMVRxUnFEUkU0TmVraHp3ZFNKWExyRUJzRVhiZFBP?=
 =?utf-8?B?NnQ1S0VqTUp1c2I2V3BQS2hFV2xpeGVHaUFGWVJQdTh3Uzk2NGk5NndMQmlm?=
 =?utf-8?B?U1YrK2FGdS9KSFBJK3dTeGFPYm5URVd2czc0SVdvUHl5ODVGdlZUcnREQU9E?=
 =?utf-8?B?UEFNOFBGTUd5VkFRazIvcDBIWFMyRlpBem1CT0hETmM1YjVXMWNnVGszWUxZ?=
 =?utf-8?B?MHpIOFB6NEdCajgxclFlSFpzSU9TZkVCb2VyTU1XWmVJQ3FUR2pnSjZveGpQ?=
 =?utf-8?B?WVQwWUphVjk5RXZLQmtaekFlS2NIS21rVjdWYmxKTDllcVpnNzBVL2dDRXRN?=
 =?utf-8?B?Tm1zc0hpWS8yVW9XYkhIbVMreERQd1lLdUR6ekZVTExOdDF1cEx6U0Z3NE9S?=
 =?utf-8?B?MVcrM2trdXVOM0VjdGhYYXJ2V3FGQjFmcjJwV1pMS3JicEFaaVZLdmxza1Z5?=
 =?utf-8?B?dFp0MWgyTzNTeW9zSjUyR0FOTS96QnN4MkN2bXg5TElaZ3lPSk9LRlRNcHFV?=
 =?utf-8?B?ckxNaVdoR2lrOUg1aG9Pb1orTVpHdWQ1OWIvOE1RTDFQL1hEbFBqZnJrZXhE?=
 =?utf-8?B?aDhkZzNZYXJQMEdMc2xGMWpTaXpRK1RTQ1NmUVFybk42NDg5eGxiSjB6Ylpi?=
 =?utf-8?B?R3JTalk2VlRBZHJrNDhUZndEbW9wc3pFbDZuelhuSE5IT2x3eUU2NmIyN1Fo?=
 =?utf-8?B?RWZHRkoycHF0Z0pXZUM0ZTArVXZ0ZVRVbFltU1Rnb2tOSGhiVzk2bHBLTkNK?=
 =?utf-8?B?cWZBU3UwRENvTkxLcFN1Q0Y0U2FEWTBTRzl5N1lSTVBWeUZPMU10Q2V0YlNH?=
 =?utf-8?B?Tmx4dlQvY1l1Y2VrZjdrWUVLUFFjYUMrYXNXcVp6blV5OWNBZ21lMXQvZHRu?=
 =?utf-8?B?a0RzNUJBa2VqM3lOeUdERTJPUkI1cVVyY3lTZktJV1NUWHVlQ2NSR2FqMTI3?=
 =?utf-8?B?Wmw5dExRbDQramg1TmhtMFROeENFdGZ3QTVoMHAxUXlOTExTMmFCRFE3VTNa?=
 =?utf-8?B?MEtiNnR5T2p0bllkVW9ZOERHOGFweGtxanlMZjc5cEV3YlFnSThjOXNKUDRi?=
 =?utf-8?B?Wk9JUU5zWUttUlBDZXJkTndGMm9DcWJXekV0ajd4ajczSDkzVENSOXdLVjBD?=
 =?utf-8?B?NC9nWWhBbjlQZVN1QlRqK3hPY1ZUbEdSeGExeWJmRHNrV2V6WC8xWWIvOUNR?=
 =?utf-8?B?Wkd5WUdVNCtDUFoyMmFaTkNTUHhSUGxXYVlkODZXbFpNSjFIODVpSUEvL3pv?=
 =?utf-8?B?TlpwMjFpemFZZ0pia3IybHA2elZNK3Bab2ZnOXFxVGhoTGt2THcrM0J1OENz?=
 =?utf-8?B?SUNUYlR3SnFwR1VoUkhkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnlhWlVjcUJWcHh3L3RoTUEzTTRxeTNzM1FKNHg4cVdxSUwreFdPajNpQjJ2?=
 =?utf-8?B?UlFWQU5xZzRVZmlzLzcxYVFSL0dhQWlJc0tXbnp1MlM0QXlGdG5rNWI3VE96?=
 =?utf-8?B?bnZpYURYVlQvZWZ3UHc5SjJkU1JKK21NbXczT0JveVNuaFhFVzZFTXNHcTFI?=
 =?utf-8?B?TlVjZFFSWUg0Yko1TkUwWTZ0T1doQmNEOG9DSE9ieWRIQ3pmdzRSWlJwUFBH?=
 =?utf-8?B?K1VDL0w0OHpReExPTUd3bk56RVRZd3EyVHp2b2xHZlBYbVNPYXlRU2ppT0Ft?=
 =?utf-8?B?SlpxMFRubUFYakxTdmw1SVpIZytFdG5aYjlwck1UQUhmdlo5UjVUQTVQais2?=
 =?utf-8?B?ckxjQ2EyQU9RS014QUdDZEdzVWVpUmtnVE42WWhiYzFjUDYrcUxCQlQvbEZC?=
 =?utf-8?B?SG4zTUg0UHd0SUlub0tIazk3TTdGamVzUEovTVgyeXcvZEc4bWIxSnJBckdp?=
 =?utf-8?B?YnpvVEdJMlJYUVJmZWNnVHl6NVJIWHVKdFRVcXVXY3pZMHkrSTQvMzB4TUVi?=
 =?utf-8?B?ZWQwTzE4enF5OFZnRmxROHhVeEV5RVpJQnl1L3RlUFZkNW1xVlRlQlE0Ti9K?=
 =?utf-8?B?eVpTMjhsL2xhSVBrTXZlUXpCUXVKbDROU0N1ZFozNW95VXhndVVLZzZ2R21Z?=
 =?utf-8?B?Qk5LV0EvaEFwS1E0R1ZkcEFnU1RYRkZLa2wxRW1BYjVvYlo4VEdQdU9OSVc5?=
 =?utf-8?B?ak12UHBnMldOdzdHdnpMay93Ylh0N29vb3JzNVJKbzcvT0FVWmlUa0p6V0tG?=
 =?utf-8?B?OFBib2xxSHpjeHJ1cjBHcFBpbU5ucVc2OStnSzdEeGl4R3REVlZka2htck5V?=
 =?utf-8?B?L3RFYXRFNGNPbVNkZkRZUjhzdy81Q2VJcG5JYng3R2xyanJhUnJxaHhnTWpO?=
 =?utf-8?B?KzJ6aSsxaCtqSmQ3Y3FFaDR2aS9kZkpiTUNSQ2c1eUVvVUJmSlZaRWMzYy9M?=
 =?utf-8?B?dGJGc1lYdXJTMVRFNW1OQnlqU283Z2hGNXRNd1RoMWgyK1UzNy9PWTZ1SU54?=
 =?utf-8?B?N1U1c3dydXpxYmZSNEhMb0VMNUllaTF0T3lWeFpEUGxSVXlnM0Y2TDNxeW5m?=
 =?utf-8?B?UmpYeXNGWXdvYnRsYkRmZGZrd1FVRjh2ak5XeVpkbG1xZytXWXAwRVBkTEF1?=
 =?utf-8?B?WUNubWZvNkFUVjU4OFZ1WjlCQnBuNVI4bGZlbm03SkpvL1dSVzI0WW9JTmty?=
 =?utf-8?B?dGtvdnh1SXkxTCtXczNPVHdrR1hGNnZkM1hyWStxMWNKR2VrQXhkZTJLbUJk?=
 =?utf-8?B?MGRORjFYT3puT0FyZmd5VS94V3Z0UDFHNzlMaWVwOUl5eFFpMEVlWXBOMGlM?=
 =?utf-8?B?ZUlIL0NuK0lTK2VidGdHMVpOOGZPeG9qTjF0QzJIQ1BHTlhIZEpDNU9TNXV0?=
 =?utf-8?B?YXRyc2lidnVkK1NIaGhEQWlHNmpqUlRQdzZWQkdqL1A4b0Nxa1ZXVDUzaklV?=
 =?utf-8?B?V1o5d3FJVjgyS0tzWklUaFlrRlZySlRyMXd2Uy9NT1JmeHRlSGN5bE9qMG9u?=
 =?utf-8?B?UXEyU1Y4YUovdVlxcWRFZFVVeUxWZmNxUXNSNmVEUHp0ankxeEdGWE1idVhh?=
 =?utf-8?B?Tnd3SVZJWi9vZlJhYkRNVjdhdldweTI4czNBSi9iVUkvcW15RnlYQ1BvQjRh?=
 =?utf-8?B?bW14eUlLdERiUW5semJXcWpySWRlMEUySCtPby9lUEQ2VWtCOUlJWHJZYXFl?=
 =?utf-8?B?V0tyQ1VSRUFjWlY3SFlqQzQzK0VKMC8rTENNdTQ0TjBXN0dtRnU2dmdxbmQ2?=
 =?utf-8?B?SjBwa254OWtiOXU3WERTVjcxY1p1MVRiT0lFZ2pyNUVaMnU5T00yaXE5QXJO?=
 =?utf-8?B?VDU3bmhWYmMxZzhHeWQ5OFJkTEF6bTZSdzF5SEJDbklEMUIwNVRxQTBFQzRv?=
 =?utf-8?B?WEkxRUZpc3NLM0NLTE4xeWxXTUFmUWdSN0RiMTVBKytud3BBNzIrYThrdnVs?=
 =?utf-8?B?WHRMb3VLbG9aY2FpUDNOSVlBWTJvQU5TcmNyYjhncTlXTXZJdGdpS05MSGFC?=
 =?utf-8?B?SEZmUEROQTRjQ1h6YTU3Mlp4Y3ZsOGVxUEc2dGgrU2RUTVJZVDllQ080N3RQ?=
 =?utf-8?B?d3RXOHUzRnpNZURNWE9pY3YrNVpwSkg5bFZmNk1sOC96TUs0aWgrUjhKUFh6?=
 =?utf-8?B?M0M4ZkxVdEQ5NEdzaVZJVlNndGxPUUVFRzZtVHhPREV3RytzWnJiVDhHU1l1?=
 =?utf-8?Q?IQ+UVFbrpFOv4+OJCrnASrw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 134d0747-b7f0-4a22-05bb-08dd342623b1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:00:57.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyW8zHhw6OSLAOexculZIwjuKdTkoYuJHd5i/APJ+M8tilK2a7GvFoHWMwieWFaZSURE+jkOZugWibb6Gew2fHlTAqZO8lCv4c9ypBV3nP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
X-OriginatorOrg: intel.com

On Thu, Jan 09, 2025 at 12:03:40PM -0800, Lucas De Marchi wrote:
>This partially reverts commit fe4f5d4b6616 ("drm/xe: Clean up VM / exec
>queue file lock usage."). While it's desired to have the mutex to
>protect only the reference to the exec queue, getting and dropping each
>mutex and then later getting the GPU timestamp, doesn't produce a
>correct result: it introduces multiple opportunities for the task to be
>scheduled out and thus wrecking havoc the deltas reported to userspace.
>
>Also, to better correlate the timestamp from the exec queues with the
>GPU, disable preemption so they can be updated without allowing the task
>to be scheduled out. We leave interrupts enabled as that shouldn't be
>enough disturbance for the deltas to matter to userspace.
>
>Test scenario:
>
>	* IGT'S `xe_drm_fdinfo --r utilization-single-full-load`
>	* Platform: LNL, where CI occasionally reports failures
>	* `stress -c $(nproc)` running in parallel to disturb the
>	  system
>
>This brings a first failure from "after ~150 executions" to "never
>occurs after 1000 attempts".
>
>v2: Also keep xe_hw_engine_read_timestamp() call inside the
>    preemption-disabled section (Umesh)
>
>Cc: stable@vger.kernel.org # v6.11+
>Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3512
>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/gpu/drm/xe/xe_drm_client.c | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
>index 7d55ad846bac5..2220a09bf9751 100644
>--- a/drivers/gpu/drm/xe/xe_drm_client.c
>+++ b/drivers/gpu/drm/xe/xe_drm_client.c
>@@ -337,20 +337,18 @@ static void show_run_ticks(struct drm_printer *p, struct drm_file *file)
> 		return;
> 	}
>
>+	/* Let both the GPU timestamp and exec queue be updated together */
>+	preempt_disable();
>+	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>+
> 	/* Accumulate all the exec queues from this client */
> 	mutex_lock(&xef->exec_queue.lock);

mutex_lock could sleep and you have disabled preemption above, so not a 
good idea. I think it will bug check if the lock is contended.

Earlier you had mutex_lock on the outside, so that was fine.

Thanks,
Umesh

>-	xa_for_each(&xef->exec_queue.xa, i, q) {
>-		xe_exec_queue_get(q);
>-		mutex_unlock(&xef->exec_queue.lock);
>
>+	xa_for_each(&xef->exec_queue.xa, i, q)
> 		xe_exec_queue_update_run_ticks(q);
>
>-		mutex_lock(&xef->exec_queue.lock);
>-		xe_exec_queue_put(q);
>-	}
> 	mutex_unlock(&xef->exec_queue.lock);
>-
>-	gpu_timestamp = xe_hw_engine_read_timestamp(hwe);
>+	preempt_enable();
>
> 	xe_force_wake_put(gt_to_fw(hwe->gt), fw_ref);
> 	xe_pm_runtime_put(xe);
>-- 
>2.47.0
>

