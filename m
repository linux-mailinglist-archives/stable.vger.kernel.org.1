Return-Path: <stable+bounces-244429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH5zCRtr+2miawMAu9opvQ
	(envelope-from <stable+bounces-244429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:23:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C92F4DE0CA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB82B3059212
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE347DD72;
	Wed,  6 May 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfzUNdui"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579C4921BB;
	Wed,  6 May 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084213; cv=fail; b=hd5HEp36p8dq6mgZzqv5djIVlXRePOCRovFFcX605F8CAIZLFAIHCXmpS6qBEvXj2CxAwZlok8/cAqtG3qQWE0vDDeSQcOsBvFQFcpEwFjnAqHjkI/GNgYoV9N7xRvRHdiVh3OqBY+MlcRBUNRoqb/zYgU1lM16RgEAFsEqoslI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084213; c=relaxed/simple;
	bh=wGySv6psByX83RrizmlhY8I2rZ+VFkya3xx0bBFjPk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AtaPcFgvUuDhxipe0SNSuE7QUWXDLAQZ92Uk2i8RgkUBol+rCHgc4KFwhG8O6iC51A6VmfC5mjmJSa5R62MA76CEkPwc5iNHUxrS0aeUh27EWen8/8n9zAbr+L9MG0YlxqdoT7AEa6Z4rVPzY5vZoYUcvOvNG3v1Q7TNt0bQm/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfzUNdui; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778084207; x=1809620207;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wGySv6psByX83RrizmlhY8I2rZ+VFkya3xx0bBFjPk0=;
  b=NfzUNdui25c1Lf9lVU5GeTYzk1enaPI8oqKCl3RRGFrJP6AhsnzxmYVb
   UzeRkLW+0joe9LdH5a5WRUEIF45cF9LdhOlfKjUbNKJXVUB5gkvWsR4a7
   hlPKQg+PpHI3Gef7ijRZmmRlpIl/+krRyoDOy7Is4Met69oAvhM/7qdXq
   7657UiJJfNRiEzjDmrN/0XqnsqwE525VjMxp+gGzNVnyPNRGbBHGewPj7
   mIzrBH2zisFr+EaQGHqzoAopvRrWcRB1KJzY8ot1vNzm5k/TNVJyXXbM1
   LXXvADETUdjXA8ySU+TTo08WI5I18sKJCyZfax9/QgVcufV+Qmt/s6K2U
   Q==;
X-CSE-ConnectionGUID: 1EBQ4DkCQhqScCvd1oHA/w==
X-CSE-MsgGUID: QwcpB0W+SY+wPUer4vpJvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82893164"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82893164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 09:16:44 -0700
X-CSE-ConnectionGUID: 661D5kQ0QKy3HkZ0F/Rk4w==
X-CSE-MsgGUID: WRYLnlFiRT6DwhPeQ/IyVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="266542410"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 09:16:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:16:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 09:16:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV0ngiS+rm1P2GFnWSg8VQi77OOJUV+oDgeIZ15iH8hvxL/KvC/uF1yClLeEzZKVpO0jhbZcGgHTDZ6vjEjwBKoSGLt7MwGrPcdy45jICXgQRBEI+szAOJFdllsoC9kkbhvbLJeEgQgJN3KLWgx87qQ2dwVw4HR6fudpms8OqngeeVnHqflPqzatkLHR8Dk2MtrJs5fcvcZVWf62gI2dVLPOrCDB9umd0DNi5xGsRC5v29fCXfK3h793D6pEJSBgcs1CkNHxPDQi2HtC1QTtX3j8sugcSLvCpSat0tRmC0heOt6Le+MxDWHE/xqD/XU8//PXwsL1vbMogOjGmqboMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lju/V3bKFsZR/lVQeCQHHJsBq5vxrw0EOK2RwQm0huE=;
 b=K+B2vfokJfN+5JI/SOj9H5g4V8Fjx1uqjkmP4j/OGuq4+7DCRrSrEHJPSRjM3LrQ4cdllSZWF40FC4Yy+LZfh7UKcsl52FgBv0ctDPOw732GpIIImcqOWHz22QwfzRz173UXjSccwYdmoZPB8l4wIg8GVS9nycmuKA6OnbsQkZn0cTU/YTRxwCC1wwYe+AjCBbmOBj32AICsvtLunDojT/tWaoUrXbryEGOu7UpO2ASM0ElgFlYGqfUBT84obPRplf641KBUVY2HLKkrhC7LsmLiF/BfwdtkAq09Tc6RbsdF1uwSPgWESy/IQTmANm3rtFVV5FSGh4tc0RoiLtyhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH3PPFB9A266170.namprd11.prod.outlook.com (2603:10b6:518:1::d45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 16:16:41 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:16:41 +0000
Date: Wed, 6 May 2026 09:16:37 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] drm/ttm/pool: back up at native page order
Message-ID: <aftpZSx0lua7yjx8@gsse-cloud1.jf.intel.com>
References: <20260505200443.3300962-1-matthew.brost@intel.com>
 <20260505200443.3300962-3-matthew.brost@intel.com>
 <47256c5547c75296af32ca87161188588cacf727.camel@linux.intel.com>
 <afto1UzV/yfNrv1S@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afto1UzV/yfNrv1S@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH3PPFB9A266170:EE_
X-MS-Office365-Filtering-Correlation-Id: 632f39d4-d9e3-43e9-3b6d-08deab8adb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|20046099003;
X-Microsoft-Antispam-Message-Info: hR6hidELXAD53kS1RC+6aP9vMU32M0fonYLiNH1u/HARxYFU082cIRoRm2I+8llERxf2pDfOiFGI+/8XLlmLxE8q/4/+ay6GOp7jQKnN6FxDhSDiUJs0b5Jb8iw/NbH0H+3VfpZSWXfojR4Rl7RNMf5tfoVi+oQD+UYbODhijUXVpM3knXcVsyKfZslQzLZObk5onfD4KjvMXpSnHOq9N8PvoFPugomqyOkF/viHS5WR+L6ruD+nNisgPM9b6bVu0OvBPE/CW0RaimiclIpDOymVe8vOGrYQWcvW+L4jH9XCF1hmt+0CrMcePPuSFMWQ2z9FVER005BjJdDYeVk1eTmdEvzfbpjyMutW0vNqz8XBJfqYjvk8NaCOIwZ3Hr8bVqvsRpYVmrIDXRPmqPjZs4BUQQA0BQDvbnO9CkXrtDus36QLSaYBAhe8rb22mnDRNK8BsQQ9uY3LmYGxeUYbdKYASoNuP1El5SgKlWRLNjrP3ZMRvOyz6QaWxQHsfI/Z1GPii78ZdYDP2LVrkm02jc0s821V9v1xZpxHGqNMXc90z3Mk48ejsb3uC0ysjLdND3hU3KjDO5W0fcKhz7IBZgv1OHJLm5Cr8/gAXMfJaR5xuYyY3a+4Yi9J8Q8rnlG7kYRsRgI0H4FFrLS8Suiouw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlvWFNiNFo2dGorQU1Nc09MT0M3NE1kdjE5UEJLd0J2cmFPamZCUkprUnBO?=
 =?utf-8?B?RXN1Um9tV1BLVnFDaDFob1kra3hJYlZOeDgyYkl0SlpZUzZzWk1yaGptWHIr?=
 =?utf-8?B?WVhjZXFsSU5NM3Z5N3BNMkxMMkRiU0pWajZGaUtlZE1xaE1pSUVIaUxzcTRr?=
 =?utf-8?B?ZkFUQy9HNDlpS25QQkgyU3BBbXBlQ2xPeXRjTXEvd3dHZHZaMjhWakJxSmlB?=
 =?utf-8?B?VWFvaHpaZS82UDRmL1NXNldwekd4TWdnc2phOHZ6cUZKcW9CTkR2eFBrVDRC?=
 =?utf-8?B?RzhZZ1JvZXJvRVFQNllNMGFwOUxvdkt3TjR0Nkk5c2RiQ29NUjA3U25IQ1JP?=
 =?utf-8?B?QmxNNTRVVjhvbkVTNnlMVmxUV1plNmd0ZjZ1Zjl1S0NGNkxPMHlPNGcycWZu?=
 =?utf-8?B?RC9ScVRoTlpja2x6ZVVxY1lrVVpmVGhWUFFLMkt4T3Ric1pmYXZUT0hlZzM4?=
 =?utf-8?B?V281N1pKT09TYnJJdm9mckF5Zy94OW9xTGREV29COHYyd3BEdXhJTXUwcnVm?=
 =?utf-8?B?N1BKNmdzbWJVeWcxRThOR0U3YXZzUFVON2lZUHNKUUY4cDhlOTNKQ1BlVnRn?=
 =?utf-8?B?VElvMnZ4WkpuWG1CWUUxOTlzdC9lNGVvTnJHeHM1Vm9WbXJBd25mTUZtQkVI?=
 =?utf-8?B?TEtDTzNIZkdJQkdMMVNlckZQUmE4akZOZ1RiTzhPeDFRU3pvSVlnRnEvTFhi?=
 =?utf-8?B?clpRM3pkSm1Gd0ZZaXFCNnhxV0oyZ3A5UVRLZnRDZVkrNWFOM05Ub1R5TkNp?=
 =?utf-8?B?ZHZ4SHVIZE1ydE9QRVJObjBFaEVDS0swSVJ6VUFKYmFPL0FuWTdKT2FseG9s?=
 =?utf-8?B?dm1XVzMxZHhPM2JmbFQrK3FvaDFpaitnTEhKSHhWVGlUY0NCcUhhaUNsN00w?=
 =?utf-8?B?QVRpOURMMU9lMVpTUDUrUk83bk5yMTJMa1VvUWxRcVJGdEdqa2s1WC9oM2tj?=
 =?utf-8?B?bEhuNkptUFh2NDVVZmoyMVBMRDNsaUxxSFVPWGk2TWg3KzVCTnQ1NUFWMTRF?=
 =?utf-8?B?dVA4VitOUFVEM3NjMzJ6d3VyWkRKS25BQVdqQzBuaVhiU3N2QnBXUy9UbkJi?=
 =?utf-8?B?ZmhKaWU2SVlQTFg1L3JrbVdVYW13TEJZWm5ZM2t4ZVhpeU41ZHhCKzRudzVs?=
 =?utf-8?B?RUpmNm1pL3BDcVE0YWcwcS9TK2ExQkxIZHhhM1NOTkMzcUswb2R0WFdYcU0r?=
 =?utf-8?B?emxYU1VaRTl3dXpURWsreU9ZUWk4R0xteWFVTFhSSzZQS3ZWN0xoQTlPMzBO?=
 =?utf-8?B?TlFEYVZYTm9uRnVRdTFhRXNrcWpyVFkzUU5VUFRyYmtaVU8zaXJGcnhWV3Rt?=
 =?utf-8?B?MnVWOXNSUDlqREVaVVc5NGwwcG9tNlZPNGlKVktVV2labSt0K29rQjl6dTVn?=
 =?utf-8?B?Nmx2Q0FEVFdzTG1QTUhtR2VxanFEOXJ3aExMR0pSWFgyTlZNK3RJcTlmOTNG?=
 =?utf-8?B?ZDJwN0lCb0JLVzZMejBGV21KMFlvNDgvTUN3L2FCKzUvelpOTytzL2ZFWVo0?=
 =?utf-8?B?TVpMTFlTdDJOc0ZZNnhoUnl4dVVEdnFPbHZ0NUE4YmRaMGd6OE5lNjFVV0Vs?=
 =?utf-8?B?RklTODlFSXJJMkc1VnE2bkpFMjJSeUpoWlZ1MlFOZkZudXNTZGUvNlFLSFdK?=
 =?utf-8?B?eWo0Q0RDN3pQeU40cmNsNm5DcGQ4ZmtVaE5lNGJRS01GOXdxV1NlM09PMkhH?=
 =?utf-8?B?bkhHTGN4cEM0elVsRHNtcDZLbERHVHduRElnTlQ1YXp0TU5xM0Q5MUtzL3My?=
 =?utf-8?B?cGZpRGl4UXM0bktaZlY4T0hBVjNmRzZMTlBJSWt0bmJCTmlhUCtnWnZwdVNu?=
 =?utf-8?B?YktIdXhZeGRnQVZPbkZCeU1BV2Rqb211RUdYeitOUTNNOUZRaVBKZkt2d3ZF?=
 =?utf-8?B?NUgxRHF6SUpWT0xRZFYxdktNbXZzZGxjTFhhOUtkZGord2NZK0tsNjhKRnBw?=
 =?utf-8?B?bWVjRHhxZzAwN2l4N0JlU0toaUh0cDZTTUxxKzltZklHdkc3SnR2UndCWHhW?=
 =?utf-8?B?czljTHJ2NU9PcGE2c0ZIdC9KRCtQYjJvYmdsZmdxekZrUWNaOVE1czEvR3FH?=
 =?utf-8?B?a0FiSlB4akhaVURnMzhRcTdsZWRUSXhzeTJ5b3l6OWtucDVRMjUxQ0owZDJ0?=
 =?utf-8?B?ZUxVRWVJVks3L0hkZFdmR3NPM3ZEMEpDYjBiZzFNSzFiSjdiSUxvTEZnT09y?=
 =?utf-8?B?R1Q4aWtaZG8reWk2OGpGSThyR0hJaDVqSFZrcFJVd09pbnU3WjRuMmh5dGo2?=
 =?utf-8?B?UnpwcVNUZXVBZjloTEZrN2lDNml4MUtjTnZZaW5GSEZ0UE0xSzdlcWxIeStD?=
 =?utf-8?B?UlZlS0UwR1NiUS9PQ3hqbFF6OEVEYlhXdytqZktXTWQ4NEs5Rm5oMGE0NzUx?=
 =?utf-8?Q?Oq17wfEpOIWrHNXo=3D?=
X-Exchange-RoutingPolicyChecked: iWMWMMd15FvrUzndiP2CoNENrH3UuV5FGcTcteuddeYn6fS+w99OhEuppBcguAenki2Qjdb/dSP7rwpfZ9TsYgFJBkaCX8JcLLiqa2TolAvnXgbdymu2B5/O4A1lu1pFNRIGqUaqAWSuQeDFO/+/9XLFSrdr9dXuhS/AOTi7DbX9HJXgz/gaujXA8l5zVFG8/7pXnnOohfk/rE9hIkdpzjKTsNJwr49pCvkgMou6j2bLTYLTzbU1bvH9SeIFLlS0BgOFgc8UI1WFe4FZwwUhoGAo8a4hi1D9YfPDzExIw5fAlqhzMrFN64617iZsz3uF1Z43TdihTW6BSFdZ7UCRlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 632f39d4-d9e3-43e9-3b6d-08deab8adb88
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:16:41.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kngARw52VnMZS03FqUbXlSrKzv4vu5+j5IL6dGWmgJ8R5yfgr2DyF0/VSU51uiPThpUfOfTEAhxgCvIQmIx5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB9A266170
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1C92F4DE0CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244429-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Wed, May 06, 2026 at 09:14:13AM -0700, Matthew Brost wrote:
> On Wed, May 06, 2026 at 04:23:29PM +0200, Thomas Hellström wrote:
> > Hi, Matt
> > 
> > On Tue, 2026-05-05 at 13:04 -0700, Matthew Brost wrote:
> > > ttm_pool_split_for_swap() splits high-order pool pages into order-0
> > > pages during backup so each 4K page can be released to the system as
> > > soon as it has been written to shmem. While this minimizes the
> > > allocator's working set during reclaim, it actively fragments memory:
> > > every TTM-backed compound page that the shrinker touches is shattered
> > > into order-0 pages, even when the rest of the system would prefer
> > > that
> > > the high-order block stay intact. Under sustained kswapd pressure
> > > this
> > > is enough to drive other parts of MM into recovery loops from which
> > > they cannot easily escape, because the memory TTM just freed is no
> > > longer contiguous.
> > > 
> > > Stop unconditionally splitting on the backup path and back up each
> > > compound at its native order in ttm_pool_backup():
> > > 
> > >   - For each non-handle slot, read the order from the head page and
> > >     back up all 1<<order subpages to consecutive shmem indices,
> > >     writing the resulting handles into tt->pages[] as we go.
> > >   - On success, the compound is freed once at its native order. No
> > >     split_page(), no per-4K refcount juggling, no fragmentation
> > >     introduced from this path.
> > >   - Slots that already hold a backup handle from a previous partial
> > >     attempt are skipped. A compound that would extend past a
> > >     fault-injection-truncated num_pages is skipped rather than split.
> > > 
> > > A per-subpage backup failure cannot be made fully atomic: backing up
> > > a
> > > subpage allocates a shmem folio before the source page can be
> > > released,
> > > so under true OOM any subpage in a compound (not just the first) may
> > > fail to be backed up with the rest of the source compound still live
> > > and contiguous. To make forward progress in that case, fall back to
> > > splitting the source compound and backing up its remaining subpages
> > > individually:
> > > 
> > >   - On the first per-subpage failure for a compound (and only if
> > >     order > 0), call ttm_pool_split_for_swap() to split the source
> > >     compound, release the subpages whose contents already live in
> > >     shmem (their handles in tt->pages stay valid), and retry the
> > >     failing subpage at order 0.
> > >   - Subsequent successful subpage backups in the now-split compound
> > >     free their source page individually as soon as the handle is
> > >     written.
> > >   - A second failure after splitting terminates the loop with partial
> > >     progress; the remaining order-0 subpages stay in tt->pages as
> > >     plain page pointers and are cleaned up by the normal
> > >     ttm_pool_drop_backed_up() / ttm_pool_free_range() paths.
> > > 
> > > This restores the original split-on-OOM fallback behavior while
> > > keeping the common, non-OOM case fragmentation-free. It also
> > > preserves the "partial backup is allowed" contract: shrunken is
> > > incremented per backed-up subpage so the caller still sees forward
> > > progress when a compound only partially succeeds.
> > > 
> > > The restore-side leftover-page branch in ttm_pool_restore_commit() is
> > > left as-is for now: that path can still split a previously-retained
> > > compound, but in practice it is unreachable under realistic workloads
> > > (per profiling we have not been able to trigger it), so it is not
> > > worth complicating the restore state machine to avoid the split
> > > there.
> > > If it ever becomes a problem in practice it can be addressed
> > > independently.
> > > 
> > > ttm_pool_split_for_swap() itself is retained both for the OOM
> > > fallback above and for the restore path's remaining caller. The
> > > DMA-mapped pre-backup unmap loop, the purge path, ttm_pool_free_*,
> > > and ttm_pool_unmap_and_free() already operate at native order and
> > > are unchanged.
> > > 
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: stable@vger.kernel.org
> > > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> > > shrink pages")
> > > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > 
> > > ---
> > > 
> > > A follow-up should attempt writeback to shmem at folio order as well,
> > > but the API for doing so is unclear and may be incomplete.
> > > 
> > > This patch is related to the pending series [1] and significantly
> > > reduces the likelihood of Xe entering a kswapd loop under
> > > fragmentation.
> > > The kswapd → shrinker → Xe shrinker → TTM backup path is still
> > > exercised; however, with this change the backup path no longer
> > > worsens
> > > fragmentation, which previously amplified reclaim pressure and
> > > reinforced the kswapd loop.
> > > 
> > > Nonetheless, the pathological case that [1] aims to address still
> > > exists
> > > and requires a proper solution. Even with this patch, a kswapd loop
> > > due
> > > to severe fragmentation can still be triggered, although it is now
> > > substantially harder to reproduce.
> > > 
> > > v2:
> > >  - Split pages and free immediately if backup fails are higher order
> > >    (Thomas)
> > > v3:
> > >  - Skip handles in purge path (sashiko)
> > > v5:
> > >  - Refactor into ttm_pool_backup_folio (Thomas)
> > > 
> > > [1] https://patchwork.freedesktop.org/series/165330/
> > > ---
> > >  drivers/gpu/drm/ttm/ttm_pool.c | 110 ++++++++++++++++++++++++++++---
> > > --
> > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > > b/drivers/gpu/drm/ttm/ttm_pool.c
> > > index d380a3c7fe40..78efc8524133 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > @@ -1019,6 +1019,70 @@ void ttm_pool_drop_backed_up(struct ttm_tt
> > > *tt)
> > >  	ttm_pool_free_range(NULL, tt, ttm_cached, start_page, tt-
> > > >num_pages);
> > >  }
> > >  
> > > +static int ttm_pool_backup_folio(struct ttm_pool *pool, struct
> > > ttm_tt *tt,
> > > +				 struct file *backup, struct folio
> > > *folio,
> > > +				 unsigned int order, bool writeback,
> > > +				 pgoff_t idx, gfp_t page_gfp, gfp_t
> > > alloc_gfp)
> > 
> > I don't really understand why we can't end up with a
> > ttm_backup_backup_folio(), which I believe is the proper layering,
> > already at this point? Please see a suggestion at 
> > 
> > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/ttm_swapout?ref_type=heads
> > 
> > Here the splitting logic is kept in the ttm_pool, but ttm_backup
> > supports handing large folios to it.
> > 
> > Although the cumulative diffstat becomes larger, the end code becomes
> > smaller and IMO easier to read, and we don't need to introduce code
> > that we immediately have to refactor.
> 
> That version looks fine too. If that is preference no issue.
> 
> My goal with this series is get something than can reasonably be
> backported to LTS kernels so the desktop doesn't frequently enter kswapd
> because of fragmentation. We now have at least 3 reports of this being
> an issue.
> 
> This is larger fix [1] which works in tandem but seemly unlikely to
> backportable given it add new concepts to the core MM [1].
> 
> [1] https://patchwork.freedesktop.org/series/165329/
> 
> > 
> > But I'm starting to question the general approach: Even if the
> > *shrinker* can recover from a total kernel memory reserve depletion, it
> > can't really be considered a reasonable practice, since if we
> > frequently deplete the reserves, *other* important allocations in the
> > system like GFP_ATOMIC, PF_MEMALLOC may spuriously start to fail and
> > people will have a hard time finding out why.
> > 
> 
> Wouldn’t GFP_ATOMIC enter direct reclaim, hit our shrinker, and
> eventually make progress—i.e., take the split path if needed? I’m not
> 100% sure, but my initial reaction is that this concern may not be
> valid; however, MM is hard to reason about.
> 
> Again, FWIW, I’ve tried a lot of things to trigger OOM—for example,
> running WebGL tabs and then kicking off various very memory-intensive
> workloads from the CLI—and I still haven’t hit OOM or seen memory
> allocation failures or warnings.
> 
> > So I actually don't think we can be avoiding the splitting without
> > direct insertion. FWIW, up until recently when shmem started supporting
> 
> I agree direct insertion is better solution. Do you think this something
> we could reasonably get working and backport? I haven't done any
> research on direct insertion yet, thus why I'm asking.
> 
> > huge page swapping, other GPU drivers basically also split pages at
> > swapout.
> 
> I wonder if other drivers have the same issue? The deadly combo is allow
> GPUs to subscribe all of system memory, allocate THP pages (or higher
> order pages), and split them in the shrinker. Xe might be the only
> driver with right combo to hit this but not 100% sure without a deep
> dive.
> 

+ For completeness the THP allocation must have GFP flags to enter reclaim.

Matt

> > 
> > Another idea for improving on the compaction loop, perhaps worth trying
> > is this change, shamelessly stolen from i915:
> > 
> > https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/shrinker_batch?ref_type=heads
> > 
> 
> I'd have to give this a try - I'm quickly running out of time before I
> leave for month though.
> 
> Matt
> 
> > /Thomas
> > 
> > 
> > > +{
> > > +	struct page *page = folio_page(folio, 0);
> > > +	int shrunken = 0, npages = 1UL << order, ret = 0, i;
> > > +	bool folio_has_been_split = false;
> > > +
> > > +	for (i = 0; i < npages; ++i) {
> > > +		s64 shandle;
> > > +
> > > +try_again_after_split:
> > > +		if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > +		    should_fail(&backup_fault_inject, 1))
> > > +			shandle = -ENOMEM;
> > > +		else
> > > +			shandle = ttm_backup_backup_page(backup,
> > > page + i,
> > > +							 writeback,
> > > idx + i,
> > > +							 page_gfp,
> > > alloc_gfp);
> > > +
> > > +		if (shandle < 0 && !folio_has_been_split && order) {
> > > +			pgoff_t j;
> > > +
> > > +			/*
> > > +			 * True OOM: could not allocate a shmem
> > > folio
> > > +			 * for the next subpage. Fall back to
> > > splitting
> > > +			 * the source compound and backing up
> > > subpages
> > > +			 * individually. Release the already-backed-
> > > up
> > > +			 * subpages whose contents now live in
> > > shmem;
> > > +			 * any further failure terminates the loop
> > > with
> > > +			 * partial progress (handled by the caller).
> > > +			 */
> > > +			folio_has_been_split = true;
> > > +			ttm_pool_split_for_swap(pool, page);
> > > +
> > > +			for (j = 0; j < i; ++j) {
> > > +				__free_pages_gpu_account(page + j,
> > > 0, false);
> > > +				shrunken++;
> > > +			}
> > > +
> > > +			goto try_again_after_split;
> > > +		} else if (shandle < 0) {
> > > +			ret = shandle;
> > > +			goto out;
> > > +		} else if (folio_has_been_split) {
> > > +			__free_pages_gpu_account(page + i, 0,
> > > false);
> > > +			shrunken++;
> > > +		}
> > > +
> > > +		tt->pages[idx + i] =
> > > ttm_backup_handle_to_page_ptr(shandle);
> > > +	}
> > > +
> > > +	if (!folio_has_been_split) {
> > > +		/* Compound fully backed up; free at native order.
> > > */
> > > +		page->private = 0;
> > > +		__free_pages_gpu_account(page, order, false);
> > > +		shrunken += npages;
> > > +	}
> > > +
> > > +out:
> > > +	return shrunken ? shrunken : ret;
> > > +}
> > > +
> > >  /**
> > >   * ttm_pool_backup() - Back up or purge a struct ttm_tt
> > >   * @pool: The pool used when allocating the struct ttm_tt.
> > > @@ -1045,12 +1109,11 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > > struct ttm_tt *tt,
> > >  {
> > >  	struct file *backup = tt->backup;
> > >  	struct page *page;
> > > -	unsigned long handle;
> > >  	gfp_t alloc_gfp;
> > >  	gfp_t gfp;
> > >  	int ret = 0;
> > >  	pgoff_t shrunken = 0;
> > > -	pgoff_t i, num_pages;
> > > +	pgoff_t i, num_pages, npages;
> > >  
> > >  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> > >  		return -EINVAL;
> > > @@ -1070,7 +1133,8 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > > struct ttm_tt *tt,
> > >  			unsigned int order;
> > >  
> > >  			page = tt->pages[i];
> > > -			if (unlikely(!page)) {
> > > +			if (unlikely(!page ||
> > > +				    
> > > ttm_backup_page_ptr_is_handle(page))) {
> > >  				num_pages = 1;
> > >  				continue;
> > >  			}
> > > @@ -1106,26 +1170,40 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > > struct ttm_tt *tt,
> > >  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > > should_fail(&backup_fault_inject, 1))
> > >  		num_pages = DIV_ROUND_UP(num_pages, 2);
> > >  
> > > -	for (i = 0; i < num_pages; ++i) {
> > > -		s64 shandle;
> > > +	for (i = 0; i < num_pages; i += npages) {
> > > +		unsigned int order;
> > >  
> > > +		npages = 1;
> > >  		page = tt->pages[i];
> > >  		if (unlikely(!page))
> > >  			continue;
> > >  
> > > -		ttm_pool_split_for_swap(pool, page);
> > > +		/* Already-handled entry from a previous attempt. */
> > > +		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > > +			continue;
> > >  
> > > -		shandle = ttm_backup_backup_page(backup, page,
> > > flags->writeback, i,
> > > -						 gfp, alloc_gfp);
> > > -		if (shandle < 0) {
> > > -			/* We allow partially shrunken tts */
> > > -			ret = shandle;
> > > +		order = ttm_pool_page_order(pool, page);
> > > +		npages = 1UL << order;
> > > +
> > > +		/*
> > > +		 * Back up the compound atomically at its native
> > > order. If
> > > +		 * fault injection truncated num_pages mid-compound,
> > > skip
> > > +		 * the partial tail rather than splitting.
> > > +		 */
> > > +		if (unlikely(i + npages > num_pages))
> > > +			break;
> > > +
> > > +		ret = ttm_pool_backup_folio(pool, tt, backup,
> > > page_folio(page),
> > > +					    order, flags->writeback,
> > > i, gfp,
> > > +					    alloc_gfp);
> > > +		if (unlikely(ret < 0))
> > > +			break;
> > > +
> > > +		shrunken += ret;
> > > +
> > > +		/* partial backup */
> > > +		if (unlikely(ret != npages))
> > >  			break;
> > > -		}
> > > -		handle = shandle;
> > > -		tt->pages[i] =
> > > ttm_backup_handle_to_page_ptr(handle);
> > > -		__free_pages_gpu_account(page, 0, false);
> > > -		shrunken++;
> > >  	}
> > >  
> > >  	return shrunken ? shrunken : ret;

