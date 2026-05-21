Return-Path: <stable+bounces-253616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLnZNNo8D2rQIAYAu9opvQ
	(envelope-from <stable+bounces-253616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:11:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D37075A9F31
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A2230BB14F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430F32B105;
	Thu, 21 May 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMQTPl2U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3237204E
	for <stable@vger.kernel.org>; Thu, 21 May 2026 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380903; cv=fail; b=lrvp0AiYcYGnEgvAPe8QP+wJdxxhhdm54UoYv564Ha1lPLLVXxgmgdA0tv2NiGHpBZgywgbdKTGWVl8UsJ5KJ7vh65P9F17hausKY4QZIZVpim+ZxFGfn6pIooHx/CXAp683f5Nrvum8CdMewAHPx7tHEVPVG/R+oiccP0VDHKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380903; c=relaxed/simple;
	bh=F0MAIS7BO2ea0CTjMhIP4/AnCtj7xB1qBh1UGoaVmyA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUPsOCLh8Nmux0G8gpcBmWUSldHbY8HvKyK1mVydOaDHMFWY+xwk8UyEG59DEnODRlPbQdDUa/wQleggmXxlYJefuYVV+1VvEWkHeO8mpWFiu6vuREYNrwFeP3xRhrUMjz6R/idWGZ3vlLy35V7bI9iUn1VF4Uw8aeUcQ9o0UFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMQTPl2U; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779380901; x=1810916901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F0MAIS7BO2ea0CTjMhIP4/AnCtj7xB1qBh1UGoaVmyA=;
  b=FMQTPl2U5MH70Tj8fqwRKugcGl6QMfkqN5CjI34E3tZNw/67f+S3Fka5
   BD/rDNcZ2/ITCoB7F6qXoI8EHXw4gkr9yvPMArzXmNRufhYX788/jcI3H
   P8UGsOzYszXeNq3gKMus7qdDPz5RjizTeSuX0fFlDVP2SPpq4oQnLJEB0
   Mqy27Aw7sc1oETKy0h2a2qVD/RnD1feod5d5qBsrZgsOH5OToovAM/Vft
   01Hv7EgcnNIPhOAlVXHN3X9CZH1GD5niyo0hQDZFWPqfKDBfST/hvd5qe
   sh4EesNFT12PupawcbBbdQLmd5Q8PJ1KeKeGODTBgAagW+w8qQWzvBXqk
   Q==;
X-CSE-ConnectionGUID: 24xL8cYpTuibxtkRjjTBjw==
X-CSE-MsgGUID: P7i5x2QrQCeXuzYYBADiqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80424120"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="80424120"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:28:20 -0700
X-CSE-ConnectionGUID: WN6s4YboTOuKX8Tbd9WHpQ==
X-CSE-MsgGUID: 7Tc8HJgUQHmTQQDlXxiAeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="244586269"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:28:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:28:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 09:28:19 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeAcU1apr2HayDT9K4lJFU4khOqJRt+HxRIcsue+RHGfWjeTHZkczNcyo88zg82vPGbQHsY12edQfBiVNvPfDfbVWeHKHbuMjxtL74GdpfyXGG+YZEIA3HO+Au9XUpbo9PEzqg7c9000RpKMt1zOk+rUvaqcj5SA/jnxY5G6U0+BmJ8LpZBGqj+FGx3daNu2YI4ahJDcxurawuYD2yydOfbUYHF2GjHpweBCcDYF1UgDJINTltAZJ6HOQfyc2DNe0LcGY0BKGn7j1XvzzMsdmJWXCik9ilkS+HXvwxaoVfDTJyGKrT+Iff/GiNdtPsQzCtdrdK/404x3gmzH/HfPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45w9vbONP0Bg6Y8UT246Q6eEgEUQuaCxBxm6+6AHAjg=;
 b=LIWnWAUMsbMtfvAjpB6brPpQCD+Pu/2mzj/PEJJtCwjXak3vFuFAl95uLj3vWlmhTdfXdZGu1E6styYgKEtScmHGE9HoDa8xWQ1h2Flr3kfBYXEXtGnr4Rk4+wQxxjMWCMVin7lk2AW6YI3q1lR6sInpiARuhE+TtRlDXhEiWzXviuD51rRrgopJZoeHc7QfD0MniK/NsHolXWCvdelnTNXDohBc15rXIfn55NvkG4Ij/xv7ETwxQXtKRwyxGuhTG6+4UZvnKF7IQMNl3gIJNevvgcM1rqHzzp2IaFPviTNXWf8aOcttc9FzBpcccaghpKO5Xqe/6sGGvfVDJM1KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20)
 by IA0PR11MB7839.namprd11.prod.outlook.com (2603:10b6:208:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:28:14 +0000
Received: from SN7PR11MB6678.namprd11.prod.outlook.com
 ([fe80::30df:f39d:e75c:da99]) by SN7PR11MB6678.namprd11.prod.outlook.com
 ([fe80::30df:f39d:e75c:da99%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:28:14 +0000
Message-ID: <3bce5464-3dec-44db-a8e7-b071c2c8882b@intel.com>
Date: Thu, 21 May 2026 09:28:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Use PDE mask for 2M page reclaim entries
To: Brian Nguyen <brian3.nguyen@intel.com>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260520234946.1055572-2-brian3.nguyen@intel.com>
Content-Language: en-US
From: "Bai, Zongyao" <zongyao.bai@intel.com>
In-Reply-To: <20260520234946.1055572-2-brian3.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To SN7PR11MB6678.namprd11.prod.outlook.com
 (2603:10b6:806:26a::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB6678:EE_|IA0PR11MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 321a5d51-0a35-4073-890c-08deb755f4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZNuN+lcAAqq4jod5WnkujBkQr6BUBAz/oK8p1XPHLpkfMcX67wzhrWE5UQZ1CmbpwMUZ29JtdOC1oQtoIdlVQ/x7Qmwdn9fKJf1JjlNjx8MEKr8vI3yonxKfEa4pZXqWD/vc9FA47rTmA6+j0eNznoWNwjYY/s0eqpFDGVPSFvYu63TbRd+9T1Oq6QST8ARdNAkvxU5VjJVdj6tWA50gv5uOiJzssIKqDaIQrnPbg7SG0WZYOEDR5ywn5d9wF6FZdlL0v7cWdc2UpiWcN215ZplNndomGaOCiFQrOOf/BSNwMta6M2zq3ull9S4gu4ILMEiSzkf5zdpTCse2mZzCiHC7t9rc5zlGhnELoSaKlMlTqvaxLNFL1HDtgccDt/ju3gqwK4LSdGKHH9hZ0nYxHzLDp9IikzG/o8cMexIDtQlnKLFvlwqECNDz95RcM8RJ2wcuGAby96cduqu/lHNcP0O1AzPWDd+9JmCy3zV0kaWuW5euOrZ+5BrHv2Bv15hACSvVRDuCDNaPaXUddVlaGc8tcWiOl71pqYIimDL1QeGu8VJO6sBkt0utYyL2n+38RfagbbdRoW7PeevscFMI+N5da4xU3sKD0ynM2c6hjh/fu9N6lgaFlTp0BMIqzm5TMBzz8ofvchxxue3+6hB+koTL4xUnDk3YmjgpANXxLmBzsfIuud3ZtAPhj7k9/m9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdseWxNMnIzZDBBMDRGRStNWGFPaUxKRTRGT0VzcXE4eDlUaGhqWjFXM1Vi?=
 =?utf-8?B?WGdFL3k0NE4yaStRR2Ftdk10Zmc3a0hKS3dhNDUrOTAyMEs2RGplT0ZwVmlj?=
 =?utf-8?B?Y3BVdDA1L0MzUmx3MDZhazM3VkpRVUIwQnVJc2lQTVVJUEJkczA3MXpkNzlX?=
 =?utf-8?B?VWwwYjcxRTd6M3lYSjU5WGdBclJBb1RpSmh0d25tMVAvd3l6M2VRcnlDdTJS?=
 =?utf-8?B?VUpMTE5Lb1AwcEt6bmU4dkpUdXRJczQxeWs0U1RpV2xaS1JLSjd5SkprWEds?=
 =?utf-8?B?ellnV2RaNWtIMG9seUZFZ09HL0Z2YjdLZ1JlaFVnc1ZYMG5uY0YzcXltOTNk?=
 =?utf-8?B?dXFGME90d0IxZDJFZlZFQU9EQ2dHSTNxWitMWHNpQ3FiZklDUlYzdWgwc0U4?=
 =?utf-8?B?eGNWTDNCUzByMUZQN2FKTUpxcVNGakVsTEFNYTNNWUl0cEYwNmRrWGdmN2Uw?=
 =?utf-8?B?VGdRYkhuZ3o3dUFSTU5VRy9xWkRSdWYyaWtsRzRBQnBQaHNWUWU2c0s4ZDEw?=
 =?utf-8?B?MTczUE1sSUdYRWs1aVZMRHU1RHNJcmt3VEhDcHJiVlUvbGdEYyt0M0dQNEJm?=
 =?utf-8?B?dDRuQVFpTzBnMGw2ZEMvRktxbWpwSlQwQmZpWVlaTXo4Mm9MT3NQaHFlRUV6?=
 =?utf-8?B?ZkNvTC95UStpeDZhSjc3c0RDdUlIa1FzRlBNQ1VHeFQ4YjNHREg1QlNYcjBk?=
 =?utf-8?B?Rm83TmxTYTJrOGlxNGtnK2VuSEkxR1VEdjFEL2FKVkNpTTl6aDREYktvaDBQ?=
 =?utf-8?B?bE9Ia2tXQU05ejliYnNkK05JT0xaSDdCMWIrU2g3cUcvb0VMekRMbDhhTUZB?=
 =?utf-8?B?aytVNTIyVE4wb3lLbTlNZkVhL2dOS1RnKzhTbEJQMnF1cXhzNkdXMDRNQVJj?=
 =?utf-8?B?S1o1T3NnQjltM2xtdWNlSzFEd0Q0RVVMZ2tMMVhQbHVXNU0rUW8rZnh0ZEpM?=
 =?utf-8?B?RW5uK1h0MU9iR2ZaSmI2WUh0amIzRnM5K3g5bUw2elZhMGYya09rcWxrRVhh?=
 =?utf-8?B?b2RMbTl5NEcvSXA0TGk2VFJESWdBOWo4VUlhbURDRGw5cUhxL29PYzZXQkMr?=
 =?utf-8?B?cTZ4anB6bFlnc1RzTVN2eFRwM2szeG5XU1JBNFc1QVQrQlM1RDQwV0ZPT0Q2?=
 =?utf-8?B?c3dMaVZOQXVzK1NXcUowb28zamE4cTl1dloybFh4dy8va1I5d2dDY0VwakZ2?=
 =?utf-8?B?YTFueUJnOWE3L0pQZlcvNlJ2cnU0ZEsxOFAyMGw5SE9SZnNxTmpHMk1oZ3Yx?=
 =?utf-8?B?emMzdncwOE52LzFhMG85WmY5WFArYWowaDI2T2YwaFdpNXdGNDk4Q2dHcEc5?=
 =?utf-8?B?MWtiSS9zVUhOdTNqVTJQV3NWdDFFS2NOS3AyaHFwSmlMM0NVMEVLZVZnc2s5?=
 =?utf-8?B?Z09zNTJhbmpOZnNBbmtuL3NnRDhDUFdZSnhHaTRIVTd3dFN5TlJjVEhPMi9B?=
 =?utf-8?B?NTlUQUZyWmVmN1ZnNnlvbTJqY1ZPSml2dmtPMWxJWUEyNm43OG5aUWdWRSt4?=
 =?utf-8?B?c2lOYU9TMVgyQjZpS1Bwa2cwdnN0QjhwVXYwRXVaQktGcWVkZ0czVjJBMUQ4?=
 =?utf-8?B?YW9hNG1URGgwWU00NDAzR092L1NabXErMWZ3RThodG1VemJPU3hsZEVvcGo5?=
 =?utf-8?B?ZGhBTXFFOS9yYktnbmZyaEhWZkxoNlZRTjF4UFc2bmFiTlpZbDNxUm1YdVFl?=
 =?utf-8?B?QVFUbGVJWk00LzY4ZUZDL3lZMGp4TGdDQUVaME9iL1JBSkVxZmxoWVlBSEdk?=
 =?utf-8?B?ZjFTMmRnMElYUWk0Q0JocVhwRDhWMUVxalhNK01iWm9WcjVKYlFDazl0UEpB?=
 =?utf-8?B?MkxJVUZraXgwUHdOR0VMNHd1dUxuSmlBOXJkMXZPTnNNaGdQKzA4V1VWQXYw?=
 =?utf-8?B?N1lST29DeURjYVRBdE5acmdvMGhyNUhRRTY2VXk5SDZWOVk1TndEYWFuanF5?=
 =?utf-8?B?TElISVFyZTh5K3Q2OFpFMHVQSjFIMUhpVHhtWUtwTjR6QmhoTXpwaUN5d1Bv?=
 =?utf-8?B?eVk0NE9KeHE4SkFEWVM1ZW1xclNUbmxvQ3VCU2pTUDBtWGhmVkI2eTliREc5?=
 =?utf-8?B?cUxFRFJ2Z2dKdmNUN0kvbDFuSW55OE8raXJQcCs2T2lEOStMWnBlZklSVEh3?=
 =?utf-8?B?eEtUWjZmelFocUdXRGQ0SlRyWlRGcmFpQTR2dHJYRjVLU1NxM2VsazlhNjVt?=
 =?utf-8?B?eEs4N0orTkEzK0FBU2liTGN5RE1Qak5pS2dGNEhraEhRd254NnZ5T3N4cHdo?=
 =?utf-8?B?ZllpdEE4U2pzd3Z2eUdIMkhQOTQyUmY5dk9HcEtrdXBmN2RjcTZ6Z0NJOEZz?=
 =?utf-8?B?d0FRbWowaGJjb3lab0EwSy80UC9POFBQZFU3ejVXUDkweDc0UEhmZz09?=
X-Exchange-RoutingPolicyChecked: TEP5CiKkHXvLclG8y0BYDwLpl20uemdGvyU6SYX6ZVB/GZ+PXqJcSEDHihWQ44pjNhqHTRdUhAt4MFCc7IT+1ZnB3ZnXp8PmirIyyjQZxENgfDyVVRN/hQWybAxuuFfXZqUuh3vAghWvZhymBlWY5MXWRyffrbMigVI8ZSJ2tZgrkDEzT2/caINBWGriaXImI4fFxYex/H/LXT5RHdho8I6gWNnibvim9r00Fh36aaQaqANWdw1jFQv4nfGmc4cvfMAX1ydC9PwIi7OwF72rmhgrDlR6rh273Z7wZQvKTzTuUEO/mE+Uy5P7ErKdXcTsrDQ3k5z/hL+m6uqa/RrkXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 321a5d51-0a35-4073-890c-08deb755f4d4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:28:14.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9l4QUlMoXtBZp5Wy8/kBsdIHAIARbVsx9CV2HHIY0fp3tRmkLc73WDB/bgxMHM6P0oIB3MN8Y6+njrqAQKzVqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7839
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-253616-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zongyao.bai@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D37075A9F31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify Pass in the modified branch

LGTM

On 5/20/2026 4:49 PM, Brian Nguyen wrote:
> 2M pages use PDE encoding where the physical address occupies bits [51:21],
> but generate_reclaim_entry() uses XE_PTE_ADDR_MASK (bits [51:12]) for all
> leaf entries. Add XE_PDE_ADDR_MASK and select the correct mask based on
> whether the entry is a 2M PDE.
>
> Fixes: 83b914f972bb ("drm/xe: Fix page reclaim entry handling for large pages")
> Cc: stable@vger.kernel.org
> Suggested-by: Zongyao Bai <zongyao.bai@intel.com>
> Signed-off-by: Brian Nguyen <brian3.nguyen@intel.com>
> ---
>   drivers/gpu/drm/xe/regs/xe_gtt_defs.h | 1 +
>   drivers/gpu/drm/xe/xe_pt.c            | 8 ++++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> index 4d83461e538b..22a6c197ed96 100644
> --- a/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_gtt_defs.h
> @@ -10,6 +10,7 @@
>   #define XELPG_GGTT_PTE_PAT1	BIT_ULL(53)
>   
>   #define XE_PTE_ADDR_MASK	GENMASK_ULL(51, 12)
> +#define XE_PDE_ADDR_MASK	GENMASK_ULL(51, 21)
>   #define GGTT_PTE_VFID		GENMASK_ULL(11, 2)
>   
>   #define GUC_GGTT_TOP		0xFEE00000
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2669ff5ee747..ae5ed0370d72 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -1615,7 +1615,11 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   {
>   	struct xe_gt *gt = tile->primary_gt;
>   	struct xe_guc_page_reclaim_entry *reclaim_entries = prl->entries;
> -	u64 phys_addr = pte & XE_PTE_ADDR_MASK;
> +	bool is_2m = xe_child->level == 1 && (pte & XE_PDE_PS_2M);
> +	/* 2M pages are encoded as PDEs, other reclaimable pages use PTE encoding */
> +	u64 addr_mask = is_2m ? XE_PDE_ADDR_MASK : XE_PTE_ADDR_MASK;
> +	u64 phys_addr = pte & addr_mask;
> +	/* Page address is relative to 4K page regardless of entry level */
>   	u64 phys_page = phys_addr >> XE_PTE_SHIFT;
>   	int num_entries = prl->num_entries;
>   	u32 reclamation_size;
> @@ -1641,7 +1645,7 @@ static int generate_reclaim_entry(struct xe_tile *tile,
>   		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_64K_ENTRY_COUNT, 1);
>   		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_64K); /* reclamation_size = 4 */
>   		xe_tile_assert(tile, phys_addr % SZ_64K == 0);
> -	} else if (xe_child->level == 1 && pte & XE_PDE_PS_2M) {
> +	} else if (is_2m) {
>   		xe_gt_stats_incr(gt, XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT, 1);
>   		reclamation_size = COMPUTE_RECLAIM_ADDRESS_MASK(SZ_2M);  /* reclamation_size = 9 */
>   		xe_tile_assert(tile, phys_addr % SZ_2M == 0);

