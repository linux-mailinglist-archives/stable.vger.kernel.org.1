Return-Path: <stable+bounces-206263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88934D039D2
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79BA830205CD
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11FB3624C1;
	Thu,  8 Jan 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFG17ZCo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB073624B9;
	Thu,  8 Jan 2026 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858149; cv=fail; b=cdqwQDnzOmjEFFBM/YYi2goK8MNqH2CTxy9YvAckw8gH7jnhGCuNGMFzrE2i4GzMx3f4iRXsoZMfhYcKbHURxa0RP2OLXgoTuBCk0CNxA4my9tydQatZF5Lx8KJvoLzk30nDncrPSxqxxODIaYkmGhh8YVhZt/wC2bZMckPwN54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858149; c=relaxed/simple;
	bh=T/eE5c9OhKphgp/a2VeQHKlzVQAdbrve7LyCjRsbUrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4AKEeHQoNp/SPyBa6QWkdkvlb92OWdpcC8qNM/gLMcoo6jZ34SkrpyVskNd0f5pUDcQq1rxmmkIry6YeofEzL85XtZCYR6WNkThxnpHLN9EIOtTdZxpDX8e4evLCw94sYGxfjOqWM3UWpN6nF2nzyEMfim+fKrMGF5Kej6vk1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFG17ZCo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767858147; x=1799394147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/eE5c9OhKphgp/a2VeQHKlzVQAdbrve7LyCjRsbUrU=;
  b=fFG17ZCoAXDrJhlTCzGw8vYoWq/401BK3OzDDcDiiksVHlKAgyQFXd8H
   Ai3L5XYtc0z2zajP9GXBELPm6GTkgjUAsyHRkUxeM6H0zktjCsDzJxC4e
   mOa0MJ6arbL3wQyc6v5GPMICtREMUvdbkl4jxL0cvp184F3vzt5sVRohp
   Awhn5xeW+OOql6A0qTE0EYWLQ4kaetevAQG2sgB5sRllgORqRETRcZbvk
   2pvQf+4gRROlb/TIgIBBvAe+MaIimVAAprNhuq3e7vwHFFPddRTxHLOI/
   J1QM139w0SwcTnJupF1xozONpxB2ApZ47SNTso1vJOjbVwlAphw3p4yLg
   w==;
X-CSE-ConnectionGUID: 50Y9P9tEQ2mV2DsKBnt2Pg==
X-CSE-MsgGUID: Va92FYR3STeqZ7F2SJ36lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73086621"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73086621"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:42:25 -0800
X-CSE-ConnectionGUID: qcCoEh0WSJy42Et46e4QjA==
X-CSE-MsgGUID: hDcC985/QRuIOrmgJmKcPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="207976728"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:42:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:42:24 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 23:42:24 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 23:42:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIg5fo67wQQvOEhqs8+8emQMBPOoS6qn0PuaB2DUK8aeY8uiEUmGoJ6LL+QWfTN6TI+IlqMzIuBiD9fHdDviRBtGEZh008J1ZVeX2QAE7M86heBUXangggc+J30fxI48xh6ObSoKPbnVjPLRS8atIRYyypb1IRG7PUcDnHvvgUezA0ZHZHlocV2T0CK36JEiCtwPDwbRXjK6nzAIv4r7ldFmByNBR5rYVzASZXGNAUaGkTr9VgG0/OfZxdFt12uJrDQZQcS88WAip2sU2PgnF9Hgq2ZZ0trQeMvQ687MoQ6+/bV5NXPLVGb6PaaXXZPggZ+fpzso9qaSWywBSF06mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/eE5c9OhKphgp/a2VeQHKlzVQAdbrve7LyCjRsbUrU=;
 b=Vek8mbhTXCKD239Q7ux9nOTdu5lHBZ8fj7RalSW7EyS9/dsPJKkCBsxfsNgznQr5hI6Zz9F43lqBMrfwD/NpNG7p7DW9f0a+3zKYZ1Qam5NBrYicwB99O45TFifghi+G0OEgr90s7ajFz0FZpPeHDUaFU5o3nIK2zqzJ10TKN5x584l5pmekr2ynsOAB3DI9ATNQv5P+MeznzAi1bApmL4CUNz2T0lS9+jqodfWnPmz0nFxmihQbyn/O5S8VVcRfHxttEKmy++MUgmYmrbkjXLOWA4zNcA96UNJCjb0ln/C4Nq6sADqfKQZat6C01/NJwi4PZxVH/06lz/69mfGvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:42:22 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:42:22 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [char-misc v2] mei: trace: treat reg parameter as string
Thread-Topic: [char-misc v2] mei: trace: treat reg parameter as string
Thread-Index: AQHcgG56oF4dZ48YGkGw3t9tMdQ0EbVH4y0AgAAARmA=
Date: Thu, 8 Jan 2026 07:42:22 +0000
Message-ID: <CY5PR11MB6366A429654AFBFAA5D41825ED85A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260108065702.1224300-1-alexander.usyskin@intel.com>
 <2026010824-symphony-moisture-cb3b@gregkh>
In-Reply-To: <2026010824-symphony-moisture-cb3b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ2PR11MB7501:EE_
x-ms-office365-filtering-correlation-id: 32322306-86db-4b66-328b-08de4e8975bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Vk5aYkRjeWs4Kyt5WElTbUI3V0tYWmhjNUljUzR4OXBOa3dnQjI0R2xwdm5L?=
 =?utf-8?B?NnQzY1g2OUF0Zzdzamc1dTZ4WTg4bzdyWm0yZCsxZlJlNnByRjZSRGZ5SHFi?=
 =?utf-8?B?MzJPNVUvSGFXVjdVUVJKanBsNGRMSEN4ajdKTlZpdm04aTA0M2k1VDdrSGJ1?=
 =?utf-8?B?R3g0RkVoMS9hSEVOTDlITFdsSWRZMEVQSTNjMHBCK2hmL1ZrdnZySkg4OW1B?=
 =?utf-8?B?b25PMVMvWlNmK3hrV0hxYkpidTR4aWR5eHRIckVOdjU1SVRqcGNEYnFOdktL?=
 =?utf-8?B?aGlsTk9mb0s3Z09VU0lFTjU3STNjcmx2eGpTZkZFTXNXeGNCTkhOVGozVFAv?=
 =?utf-8?B?ZXg3ZGFmaThyZC93eXkzb0VIdnlmN2pUVUtUTlllbGxheWRoV0YzOW9GR2g4?=
 =?utf-8?B?cW9ORE5ibUU5WHM2U2pONnJHMXM2bE5LQXNVNXRGT1N5emVwMUJra3N3cEdW?=
 =?utf-8?B?WkpubTEwZ1FhVm9MMnFGeGo5L3N6alBOeDdubUlEKzlpZVpMUmJOdmFweXR4?=
 =?utf-8?B?czIyY01qVkZSUGxUb1d1VVIydzViOEMvcHV6VE5KdkxmaGI5TkNEaEg4VkNS?=
 =?utf-8?B?MWNjd2trREhPR1VySlhvcnlZOWFRaXBKb0tncmpXM29SZWhqbkc0b1MrZ3ZU?=
 =?utf-8?B?SkFnOHdmQWZxV1Blbk9YWXpSZkhSWkdOakxxQXN3M05TbVBPdkhudGlJRDhi?=
 =?utf-8?B?VnQvTHU1RVZhYU5HRUJWa2h6NjBWWlVHZUhnejNONXE4QXk4dlhJaTArVFh1?=
 =?utf-8?B?VzRRSUh5S0QrbXZ5UWRaR0tueE9kMFVHanBDY2F4M2FNRGRMVzJDdjRiN3BX?=
 =?utf-8?B?cDBxbE9ldDhUUlhQV2ZnU1d1WWNXU0JjL2lCdjF2eEViUk9naU5BWnJhYm9n?=
 =?utf-8?B?bmZ5VUh4VWZPQVFRc0REenJ2MTJjMHkwcHRxdjN2emM3NUZIRWZFREoxQ3Ba?=
 =?utf-8?B?eW5FSWFVellNY0U5VzF0bS9iL2ZmaWxrTXU2SWZuZ01oSjZkZ2NsanI1d3NG?=
 =?utf-8?B?T3owYTUvVXhOcHVTMkZLMzFCQ0pXMHRZc0pZbTBSUjdlaHpLSE4wVHJ1bDdX?=
 =?utf-8?B?aXdrZS9GbHFMZGJRNU8wMGovMUFwZDdoTzBLbEZvVWN5WFN1TGFtSVJNY2sz?=
 =?utf-8?B?UHlTRTM0eGFMdkhvN2lSeXBoMFBDWXJTMFpPY0JXWXBxVW1wNUwwMmFjYmxR?=
 =?utf-8?B?c2VQUnNVZ0lrWTVETEFkSU9Sc1BTc3ZERTZTRTVtUVFJOWVJay90WTV3NXZ3?=
 =?utf-8?B?eE9UUk9MMUJnZXJmcHNQYmREaTl4WHFxejd5WFVVbUtTK0pjdGVkTzJQZFlO?=
 =?utf-8?B?L1o4bWx5UDg1V2NsRUk4ZjVmeUZwNFgxcXBaZkRXd3RLN2lteURxSVc5Z05Y?=
 =?utf-8?B?ak1MYTE1YThNZGdiUG5JdWV4K2RXTVBXWkZQNTREdTZ1TThuOUk3WWtlbWNz?=
 =?utf-8?B?bHRxTWxjeWY0VERING02cW9tNmlNUmVibmtPLzBBK1VJZjdjeWZYQzFQdzU3?=
 =?utf-8?B?K21UTHZYbGMyZHVwNFFuMEo0RTg4ZlI4N3Jka2xLQWtET3JvdlFPb2xrWmNs?=
 =?utf-8?B?cFQrNVNNTktrRkFBL3E5VHJXTm1VUXdUL0JQNXB4cjlSbGxlMVErWVZPamZF?=
 =?utf-8?B?TWRiQlQzNlVkY05WUUtlYy9VY2cxWnRsVlpZaHV3US9YME1nZTN4RE8vQkVZ?=
 =?utf-8?B?QzRtQWRrUSs0TFRWeE1saFVxNnh5aWpkZmU4M3F1OGpiZk9EcGM3YkQ5ZHFM?=
 =?utf-8?B?eXRBdzB0SG85djNuR25GWEJJV2dCTVE1dDJhWEdMeFlQK0ZtMVAzNDhxaTVl?=
 =?utf-8?B?SFFVT1BKYm02ZXI3WUFjN1R0S0hpejhmVm9ibUppSlNGemYwVGNzT0tiU3ZC?=
 =?utf-8?B?RWFzVzJ1eUpXQTVrRXgwR0k1ZXNrR2tGeVNzclNMZEUyYWRjam5iNHo1QmRp?=
 =?utf-8?B?Z2dlOGtjUHFtY3J0d3JveWRBVGVQSUt4OEhlZXByZCtkakhoVXhhMVdBbzVC?=
 =?utf-8?B?Rnd2L1k2UFA2ckQwYk5iOExGSmhyRFdlWkJFWlV1eXBJRm1DSHBJOG5qVTRY?=
 =?utf-8?Q?FbGyda?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjhVdjBTVTFjYmE0WW1rVEZBYkxzMGw5R1kyekRNSmczWDFKU0RFOUsyeXBT?=
 =?utf-8?B?YlZ6NHNDQjZicWkwTHMrcU5QdlZlTWh4TER0WW84SHRpOGNlT0ZwTXcyK053?=
 =?utf-8?B?L3R5dTFRQjlHcWZKQVZWWldxNGhocDgvc0dwTElZOTFGM0tFQk9sU2Zjangz?=
 =?utf-8?B?WStkTHUwWG9Qbzl4Yzc2dU1LQTdEWHBqMHNwWDdsUmt5MUxIU3R6dGdoUUtj?=
 =?utf-8?B?VzVnSXdKeFBrck13ekNWdnNvS0MxdlJpNVhJa0oyQTgzck1BUzd6WWRmMm5K?=
 =?utf-8?B?SjhFcjRrc3N4d0RiT0xVQ0xvU2lKdVpuUEo0eC9jTUVuczY0NC9uK3lkb2xq?=
 =?utf-8?B?WllkVVRpV3N1V1Y3SG5GbnpXQS9ldFE5TTgxVkVYUzY2STF5OXlNOXJidjVY?=
 =?utf-8?B?cE85SEg5M2c3MitTaW1zWUw4U2sxUWl1ZGxVYnpKT1VFTXh4TGtPa1FXS3pi?=
 =?utf-8?B?TktnS05qNzMrVGpPeE1tL09rdVZHdzJhQWM0Q0ZZc1lVZ0RpUHFvcHRZUnR4?=
 =?utf-8?B?c0hhaTJ6MEpFbGx5RDZBbi8zQ2V5UHZMbnd0Uyt6bWRZK010enpqdW1pWHZO?=
 =?utf-8?B?VWVzbFdoVXdidU9peU01MnJkMURWNGhwOURCNktMNDg3dVkyOVhRUnFnYTVx?=
 =?utf-8?B?dE9tdUcxK2NRUVQ2dnV1clFvbnY1bWZ2aWNUVGNjd2ZULzU4bFZTZFRYS3Yw?=
 =?utf-8?B?TUdKYVRQTGdKYnFuYU9MN2JFbVBZb3I0Q1gveVNGOXNqZlgxUlBLU1Fib0Rw?=
 =?utf-8?B?UEIxL3FtR0lPZDg1SzN3T2hhejNaMEZDTDNmWno1Wis1ZWNmZkIvWjZIMURu?=
 =?utf-8?B?UHN4bzc1RmVseUkzUDBlRjFUTnR5dXI0eGJwMDRVbzFXUWxNNWJHQ1FJQ1Fu?=
 =?utf-8?B?QVd0cDdma0k5Z2s0NGdJWUl2NE9PbFJTWTBWK0k5SUthOFJkWXRkd2YyaEZ6?=
 =?utf-8?B?N0s1dzA0Sk9vZjNuclQrcXRuOXNDNHpJeFhXN1dOV1IzcWp3RkJIWFlzRlVL?=
 =?utf-8?B?eEZydlBFeW9MSkhJbHovYTVKVTZpQitPVUU4ZmE4VktydmlqbUxVVEhYa1RG?=
 =?utf-8?B?eGxXdHdLOW5sQTR1aG9oVmlxdDBTOVdnWmRTSnhxWHVCWGROaitWczEvSDAv?=
 =?utf-8?B?WWZleEpZMVRzbGExejFKMFZYK3lrQUZrWncrem0vT2ZKWlorb2VUY3VvaVJn?=
 =?utf-8?B?dEszZmxidWVmR1JPNVlvdHcxQmE3WGFLaTNzQm4zeHhyN0hMZ29aTjBtN0hs?=
 =?utf-8?B?OTE4emdiWldXV1luSU5WNCtQYk1MdlY2Rkd5c21DUm9RMTVLYjl0c1ZlZHhm?=
 =?utf-8?B?QTRBUFNwOVB5SEpzQm5rcU9PVEo3RVBJZHBpVGg5SUk1VXc2Q2xMU2diaXF6?=
 =?utf-8?B?QlFHaGJoSzlPVzRYUkxGM0E5L3VtRjBDaW9qQ1FlaXdFR041QXFOamQwOWZu?=
 =?utf-8?B?Tk8wb2JwUmVzL2dTTjJvY0gyVDYzRXF3Y0R1UkNCS3RWSzFYaThlVHV6R0M1?=
 =?utf-8?B?bGdERjJIY3RlOWVtZHdrWGIrc0RtTVVpMFNQc21RSEJwN2NPMHZvL2cvZlhh?=
 =?utf-8?B?Y0ZxbVZmb2hQRzhDOWFFQ09TNTl6WEJEZ1pkWjkzNG94SnkzL0ZEN3NpRm82?=
 =?utf-8?B?VWNaeTA0WUVURmkvalNaS0pGRzQzWURkeUpTcWE5WXIyK2Y2UDk3S2daWjlp?=
 =?utf-8?B?NFdMS0NlZkRndVVlMnZJWWYyMkFaKzRhUDF3UlFFMlp5NzN2TDFsYUF2bmRF?=
 =?utf-8?B?U2ltNkIzUzhQVVg5UTVYS2FVdDlLM3lkL3pjN2NzMzR2dUtUa09PSlcrc3dz?=
 =?utf-8?B?SDVMVmVkQ1VhSXV4LzlGeUpCVUJzM3lyWkFCK3pNZGIycEVEYXRCT281VEpJ?=
 =?utf-8?B?RnRwcXRZZVJzSktITUdBc0ZQeEVmOFRXYVpPR3ppS0JsTnZWMklCeW53SUMw?=
 =?utf-8?B?L0tRU1I3MXBSdW9xVHI1TGtGWDJ2aWlPcEtacHJyMXFCd0tqdHZWRkwwK2xt?=
 =?utf-8?B?ZStCMEZVZWkrSHUyMGZ6K0EvbitFS1JUeERiYlpTV3VRRmxPQkRqK09LS2U5?=
 =?utf-8?B?QXNsc2FUamdScXArZ3E0V1NENkgraEpZditTai9hSFdrS2RSQjFsdENTS2Qw?=
 =?utf-8?B?QUU4clpFalRpbDlWNitNZmNxUGlSR0dCUUp6ZnpXSE1mRnJycG9DRHRjN1Np?=
 =?utf-8?B?Tnc1Y2Z2blJrOXRkQjRoOFQ3dVdSQVlNV25KMzFCUnUzVmU0SytDU0ptSm9p?=
 =?utf-8?B?ZzY2WWVzUk1YcnpWR2NaZnJBcjRycUdSZGYxcDJzeDNyMjQvU1RmbXZiRm9h?=
 =?utf-8?B?VjFISTlDMkh0a25Mc281cHgzb1FnUEpBWVY0dFg5MER1WjVzdGplbzg4bnFB?=
 =?utf-8?Q?26pILTtXAGzMWSGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32322306-86db-4b66-328b-08de4e8975bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 07:42:22.5875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbsL2EhB4Tg4uA3nY9WIMSme2J6qClL1JRab6uvzh1GcB3lLtBl+eaNapChY/WLoXJVxDJfodHPiCju0pcAsBr97h2nLQGajVF8/UPKy8xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYyB2Ml0gbWVpOiB0cmFjZTogdHJlYXQgcmVnIHBhcmFt
ZXRlciBhcyBzdHJpbmcNCj4gDQo+IE9uIFRodSwgSmFuIDA4LCAyMDI2IGF0IDA4OjU3OjAyQU0g
KzAyMDAsIEFsZXhhbmRlciBVc3lza2luIHdyb3RlOg0KPiA+IFVzZSB0aGUgc3RyaW5nIHdyYXBw
ZXIgdG8gY2hlY2sgc2FuaXR5IG9mIHRoZSByZWcgcGFyYW1ldGVycywNCj4gPiBzdG9yZSBpdCB2
YWx1ZSBpbmRlcGVuZGVudGx5IGFuZCBwcmV2ZW50IGludGVybmFsIGtlcm5lbCBkYXRhIGxlYWtz
Lg0KPiA+IFRyYWNlIHN1YnN5c3RlbSByZWZ1c2VzIHRvIGVtaXQgZXZlbnQgd2l0aCBwbGFpbiBj
aGFyKiwNCj4gPiB3aXRob3V0IHRoZSB3cmFwcGVyLg0KPiA+DQo+ID4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gDQo+IERvZXMgdGhpcyByZWFsbHkgZml4IGEgYnVnPyAgSWYgbm90LCB0
aGVyZSdzIG5vIG5lZWQgZm9yIGNjOiBzdGFibGUgb3I6DQo+IA0KPiA+IEZpeGVzOiBhMGE5Mjdk
MDZkNzkgKCJtZWk6IG1lOiBhZGQgaW8gcmVnaXN0ZXIgdHJhY2luZyIpDQo+IA0KPiBUaGF0IGxp
bmUgYXMgd2VsbC4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCldpdGhvdXQgdGhp
cyBwYXRjaCB0aGUgZXZlbnRzIGFyZSBub3QgZW1pdHRlZCBhdCBhbGwsIHRoZXkgYXJlIGRyb3Bw
ZWQNCmJ5IHRyYWNlIHNlY3VyaXR5IGNoZWNrZXIuDQoNCi0gLSANClRoYW5rcywNClNhc2hhDQoN
Cg0K

