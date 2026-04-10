Return-Path: <stable+bounces-235675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODlMGtR+2WmjqAgAu9opvQ
	(envelope-from <stable+bounces-235675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:51:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D033DD513
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D343046F23
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306553446CA;
	Fri, 10 Apr 2026 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3sBUzDn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8823D994;
	Fri, 10 Apr 2026 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861452; cv=fail; b=pL37GV4XjCljrdJ3S00OnjN5bWC9hL5nLAJzx+TK8yC8Jo54GcbeIO/QknPci33v4lTNr5c0JbTtcv+ETFEwC9xZFff04GQ9wAtQBX9OnFXl9qnTVKj8I9nW5UGE52MYFkcJg8ZfIMcNLHA0OH/C+gMHuvMOx194SD1ZGp0pUSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861452; c=relaxed/simple;
	bh=zgnpn50YbOBhXHleuWjSmnxnUR3mwY0joUrFw46HUmQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iYgM3COL1W5cqS59z5eiXnGvKNo5+dPQkazK5WOYG4iaFBw77tVaAJsB9SBma+WcRuRfelLNZaaWopxzylDS13sBV44mf93JuDNXczRO9UpksbNNki23TF7UYEQ9DPg9sZNcl2GPTsiNsDNx6ext6yAn98InhcWFvAU+A8+kWAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3sBUzDn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775861450; x=1807397450;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zgnpn50YbOBhXHleuWjSmnxnUR3mwY0joUrFw46HUmQ=;
  b=J3sBUzDnZNq6XaiZKv/F3v3gK4qGlbrsj+B0S+oWu0orrp8VzF/oTLHd
   6aHvXUYpCYLbxnOn8MKzd1S83PwSIk9GIu4Uis9/NxdnHghzbwyxZ20B2
   gjZQO5DiU3iSdaEXQcPj9EbLYo4ezaKE+QCYE6B5YkPJEoOjjYCQknaOy
   F6OoS+rXbrAhMQvko5yj1szUufABfJJHK28dr83CZQAc5nIQho0ul3t73
   6ofqbjHDu8QR1FLmFHr5EvMz6gevUvPbrSD6QefIBeII2iLWoimyReoXP
   q7tvD/NSONxHAw04W4OHbxwXc8FbaGF4Cg3qyKgAm59O2XNQ5Mic84XAS
   w==;
X-CSE-ConnectionGUID: iXgRzcESQICWYVGTRR15Fw==
X-CSE-MsgGUID: Usle6KBYQ+q10f4zsqBHlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76777178"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76777178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:50:49 -0700
X-CSE-ConnectionGUID: L52dYbCrSWGUvEB90YLwRQ==
X-CSE-MsgGUID: 0nZ69hFyT4i2105X4YwIEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="226054828"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:50:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 15:50:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 15:50:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 15:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5lf56KKx+U3b2C7o/wc1KFiAMCAQc8weC8hmXhBPcZMpfQA2HR2s7zqHgtHLZgdiRriTI5R56+M+HjRjsSt0T+WiIC5vRVzuwvF+9qI4HJKrvUQDwMgEaX1ENQ2jCUhGcIhp/p/pdXzwNxq5pay56s/MpI994BUQlCBRRX8iPxog495zwMlnOWwme8+1pOKiiGvkK9vblWYPaixTs06xocGdfJ/oA1UUMLnBAG1dZf08qnQvzseHq+BsPHhXa9gS3eaoppHUusSRda8vrqTwNafW0bYvImpymothHN92dVu9flp+1mluDmCOXzSZQXTUKcc+KEFbF1Ek+UKkIeXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEnIy15fgRmDxvMRD7/IoVnsq6G4O2WbVf49hcSC4DQ=;
 b=bVMqHROXimqM3FjWNUDE3Sff9u+uNE6jcEufUHgaNv1182xeVltcjJDKRhCojJE227cnrrKucg0eDcyjyt2IGwS8yEUunf+Q9zz0ujpWuSkBum767eqbHBJuApE2zEwVTsWviTLtlMbgNvBEezCXLs7QjSTbA5nRlkFNjm8WxgOeoWU5ySq0eqzg2TzEPLnsrpDHrL+QnH0YLr28QK6mbsqUaAPZLOGRTVjes1wS8B1Wrgufn5Z0/OQZAjDQ5aovYY0Y7zDOoRLTDXlWvax1UkH5s2bMN7jHVesMefJOaxQ3g70Z19f/X0v37dVB0kkgpA3tSNwjxyV86NzmRqu+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Fri, 10 Apr
 2026 22:50:46 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9769.020; Fri, 10 Apr 2026
 22:50:45 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	"Shameer Kolothum" <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] vfio/xe: Reorganize the init to decouple migration from reset
Date: Sat, 11 Apr 2026 00:49:47 +0200
Message-ID: <20260410224948.900550-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::46) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f1876d-5034-4dc6-2c83-08de975398a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uv6CUD7OwaqOEKBAbnpjywQRcMRx0TIT1FV2ekngOCcZmR/6Y2dyhVQP+n8UR4UnbvYJOF8hP1WLrqdrhnDozD+x0vkQruWESRQ2DnhjlW4a09ca3FDPU4cUDhYo0nmHCt+Httk5TDddIYeufEBGJXsGmwwmcrkY8WfV4FIgr825YcSXLmaCUVfpzFESZ0/Z69ZMUvV+Y+KlnOcsOoRs3g/vs2op/7sElJ8nPOCspT34YDvJOhsJ6b1zzM7Oy1XPJQGtxQIz6G12dkihiNUDZlTYIru2AP04rdFs67zZfVs/AEMFd8JcyNe+NzmbGjKCHf+O/Q8jKMvmZELyg4/tAYbwCQ9CdfVVkGpbJdCp8wUXhyvMtXJgIcndFFYUyv7wkP7rq55GdYKWlbSYO7WUdeKj0tQHmyAG2AZFuueKc6Zzhk0TBBYUCXZLM5fCjSE1NTuYTVXlrs1z0GjgbyukCY47PyvnnoY16ZwPrLvRUFTKxUayfKmtXYxVOp9tTO4HQBBVf6nhyq+sOSCzOyaobdEPtS4Ehh+Z8YLdOZBOE2uljs8y7PczQIGjbMg2VYBQ1PlUjc7svZQPewPgx3RFdW62OmzrAjXFgYYtI+dHeeNbU2+pWg/JY+R0umKV3S8CV9Aw2xpxTDN0xawsl7uhyh7NeMy489MUOOnvdIJcZkajzmz8Z2xBAXo6lKzQdjMI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDJaaW1ObmYxZyt0R1lwYVNsTmt5clZEelcyUnc0NWFBQmMyK1l1aXIwTlZX?=
 =?utf-8?B?ZDdxSUk4a0xBVCtnMWJ0TzFweWtEMGdBVURkQVAzcThhR1kvcFM3T2I1NHNp?=
 =?utf-8?B?dm1XNDNBTEZxdFRObkNVZzRwY1U4MWVhR3RJVldGTlp5cWkwLzI4VGlTWHo4?=
 =?utf-8?B?UGxRcUMzaTU2QWhxZmQyYmFjOTk5R2lJRnkvMnZTdFU0UG05NHgzZENYcVFp?=
 =?utf-8?B?WW9ZeDYzS2JoMnhaYTg3K3VmUExDVnl3cFliS3FFdXpidG9lOVVPQzdQQTNy?=
 =?utf-8?B?TmluYjRPdlVnNzNVMWdyTHlybmxlMzd3RU5hOFZ4ZndsZ2U0UndiTHV4eklh?=
 =?utf-8?B?REhKZzB2bGhOSG05cHlxTUFlZW9jblkyU3lNbUlzcysvdEdzN3pabEpVdGdo?=
 =?utf-8?B?bnlVWFhCaXAxOEFXZllYQWdMMjgxamRzMjhGbkI5Y1p4clZlb2xUazY3c2dM?=
 =?utf-8?B?RlZqN2dqeTdpYkJaL0xsRVpNb2pUaTFQU2EvbDQ3UjFMd1VGK2tPZVJTVjJo?=
 =?utf-8?B?WS9kMVMwZ0ZaUUJSZTRKdkhMSVI5eVhyRHFZOFc4b21YSEs1WmszWjBFWXAv?=
 =?utf-8?B?Y3F3M3RrUzc0UDgxRURJRElDWEFtL0NoaVF6ZHhaZlZPeHp1YmJKMHV4Syt0?=
 =?utf-8?B?TWV2STRpN3ZlSmFudHNZU2ltMXdwTDBaN3RzUnN1MStwTnVzRkFKM0NlM0xq?=
 =?utf-8?B?R1dxZ2NkSmkwWExMcWRSY3Q1Wm1GZFE3VDVHY0pqOGo1VVdxSGRqV2VrL0lu?=
 =?utf-8?B?SlYrLy8xMlNWQk1yS2s4RXZqNkZPREN6eGNFU053aWNaV0FZNnpwMVgxbFBx?=
 =?utf-8?B?ZlpZeERqd0dNSGxxbUZudExmNHcyVVN4NW9tUXNkcFJ0dWc5bGNJVXUxbkxO?=
 =?utf-8?B?WTZMbXhlUVFoZC81dytDa1BRTVNkeUd6ZGwrNlJkak5qSHQxVkRLLzRkZlMv?=
 =?utf-8?B?elNwOVRucjllNkJzSUdCQXBLZ3hmcmQzVUpzVGRsTS8raHBCTE92U2RCL013?=
 =?utf-8?B?cDI0dE9rTFZSbFg0S2V6bDFUSWZMeXVqWUdTSmJMNytqTk8xbWM5MHRYUTdk?=
 =?utf-8?B?R1gyWkhFUGdlVWxJYStmNk92M21jb2cxdVg3czNwTUZsMVI4V3hnSWgvam8v?=
 =?utf-8?B?Y1R6d2p2azFLcVdEbXh5VUhMUm1kK0pFeUZIdHFkS25XUjhhRm9jZzh2d21s?=
 =?utf-8?B?cU5hY3JlSnlleWR5ZWtqeUo4QmdPTHlSUFNvc3NWclpXSmtNMzlNU2RTOVV1?=
 =?utf-8?B?ZDRsd0daMFZTWTkvbUYzWmhNR1Z6clMyczIxYWhpYW5tZHVNcHIzM2d0eXhV?=
 =?utf-8?B?MmxBcy9Ra214WEdCZnFmQ1cxKzZHd1prd3JyYWdXMjYySXREY3hUanJ6dzRE?=
 =?utf-8?B?aDZWOVg5ZVZTVlVSU0dkWllmdFJNdG1ZUGpQRGRwc3FjOHd4TnJsUFQxQUt3?=
 =?utf-8?B?V3VHV1BEM3FOYXZUektaZGVjUExGWUVLazRMMzBJeFBNYmtoODF0UklsRlFQ?=
 =?utf-8?B?a1lKdGNMUmZtdEI3eDRJdlc0dlIzTnVYYktuL0kzaFl2M1BVWXVWSkNwM0pM?=
 =?utf-8?B?eEtGMVNDY0Y1c0plbUF0MDNHODRPMVU0SEU3TFNqbVdROVlPVHJqbHc4bjZs?=
 =?utf-8?B?aUZWRERtWG5kUlU4aURtT2pKWkhVRSt4OUlCWVJ3RXFlTGV2UXZXYzJ4VjZl?=
 =?utf-8?B?SEJ2Q2pLTzA1QWVNWkRJdCt0UEFmUmUwUzVaK1dzWTFJS2lBVG1lQXhqUy9T?=
 =?utf-8?B?MG1CWjM1cmI1QzZaODFYTzVBS09jRW5aejZFdVhRRVRvTG1aTUJseFQyVHNB?=
 =?utf-8?B?RWhPMklOcXoxYW5OWlpGUVlGd3RTSFhCRmVvaS82WGZqcWdlSzlnR1JzVGhk?=
 =?utf-8?B?bDg4VlcrcWpsOXMxVnVNT1dKRUpTZ3N6dnVGSWhvazRQT3NDSTJmL1BHWUlX?=
 =?utf-8?B?T1M3RktoRjBMMlZkOGVGYkxFTVNFMHQwYm8zZnRpSExtOGJ0L2pSY3RBazVU?=
 =?utf-8?B?bjVDcjE3cE90SHVNTnNFcWtrcEJnOHFkaUl5U3E5YkNGZjBjaFdTaUx1aE5M?=
 =?utf-8?B?anJJcUJCakVGOEwyK0tzZ2FCLzZYcFZmeEcwUFBDdHNlbi9ZOUF4NG9XOE10?=
 =?utf-8?B?Und6SmkwVDdlOXJBekhobWhnWVBidkk2K1FXbGRWV2JhWks5MUZwUloyMmMw?=
 =?utf-8?B?QzZ0RWQ0Qld4aXk0S0xNbUEzZ0daTHpiSkRKcnE2NFdGYldmdnRQUGFCWE1C?=
 =?utf-8?B?L3dCMlQ3WFYrRVJ6ZzNsRGNnd3J3cU9vT0FXb0JIeTZJRGhMemUwTFBmOUtD?=
 =?utf-8?B?YWZ6T242UnRPTTVCL29yeWhzYTFvMVpYVVBRTFUwd3R6V0hqYmRnY2FQOEgx?=
 =?utf-8?Q?zEVL/001mlZVatoc=3D?=
X-Exchange-RoutingPolicyChecked: tHEq0YGEUT95lfQTJTVN2ltZouArGqoX+lU8phufopoCbY0CKGcfuyLdJC/1sBDOPdFqkpTrfbSFaILccRiI/P6YuqsVMfZ+ajE3Ljn4UJewPrtUygF2Ec9sFvWZk/Pxfh3efagT5VR61OKuO8wTLC1C4Xkf+DQCW9egV7nWM2b8YY2UJRYvqbnXxEwe7IUxNypOTSQoNhpv04DH1JnG0nFt1wAVaBnqVxQMqIxUvOxOAfpGCEQeY0efr5NX+NEph0izmylgSFZOKmPdvsaWzxOEmC1nXqVoTYf7lObOxoc+u8joHTv7gifuev9FtaxZ2GQ39U2BrIBEjX02rrZceA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f1876d-5034-4dc6-2c83-08de975398a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 22:50:45.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RhjEgvybG2uYXmo/5Az6RewV71eGIPnYIYpsZIZ2nIdWROgsuuNfJLWP9rjnFU3YQ5lT7ErErxVLT+qDlWe8xEXDBZw0luADJH+3X2hw4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235675-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,gitlab.freedesktop.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.winiarski@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D7D033DD513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Attempting to issue reset on VF devices that don't support migration
leads to the following:

  BUG: unable to handle page fault for address: 00000000000011f8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 2 UID: 0 PID: 7443 Comm: xe_sriov_flr Tainted: G S   U              7.0.0-rc1-lgci-xe-xe-4588-cec43d5c2696af219-nodebug+ #1 PREEMPT(lazy)
  Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER
  Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR4 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
  RIP: 0010:xe_sriov_vfio_wait_flr_done+0xc/0x80 [xe]
  Code: ff c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 54 53 <83> bf f8 11 00 00 02 75 61 41 89 f4 85 f6 74 52 48 8b 47 08 48 89
  RSP: 0018:ffffc9000f7c39b8 EFLAGS: 00010202
  RAX: ffffffffa04d8660 RBX: ffff88813e3e4000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc9000f7c39c8 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101a48800
  R13: ffff88813e3e4150 R14: ffff888130d0d008 R15: ffff88813e3e40d0
  FS:  00007877d3d0d940(0000) GS:ffff88890b6d3000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000011f8 CR3: 000000015a762000 CR4: 0000000000f52ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   xe_vfio_pci_reset_done+0x49/0x120 [xe_vfio_pci]
   pci_dev_restore+0x3b/0x80
   pci_reset_function+0x109/0x140
   reset_store+0x5c/0xb0
   dev_attr_store+0x17/0x40
   sysfs_kf_write+0x72/0x90
   kernfs_fop_write_iter+0x161/0x1f0
   vfs_write+0x261/0x440
   ksys_write+0x69/0xf0
   __x64_sys_write+0x19/0x30
   x64_sys_call+0x259/0x26e0
   do_syscall_64+0xcb/0x1500
   ? __fput+0x1a2/0x2d0
   ? fput_close_sync+0x3d/0xa0
   ? __x64_sys_close+0x3e/0x90
   ? x64_sys_call+0x1b7c/0x26e0
   ? do_syscall_64+0x109/0x1500
   ? __task_pid_nr_ns+0x68/0x100
   ? __do_sys_getpid+0x1d/0x30
   ? x64_sys_call+0x10b5/0x26e0
   ? do_syscall_64+0x109/0x1500
   ? putname+0x41/0x90
   ? do_faccessat+0x1e8/0x300
   ? __x64_sys_access+0x1c/0x30
   ? x64_sys_call+0x1822/0x26e0
   ? do_syscall_64+0x109/0x1500
   ? tick_program_event+0x43/0xa0
   ? hrtimer_interrupt+0x126/0x260
   ? irqentry_exit+0xb2/0x710
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7877d5f1c5a4
  Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d a5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
  RSP: 002b:00007fff48e5f908 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007877d5f1c5a4
  RDX: 0000000000000001 RSI: 00007877d621b0c9 RDI: 0000000000000009
  RBP: 0000000000000001 R08: 00005fb49113b010 R09: 0000000000000007
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007877d621b0c9
  R13: 0000000000000009 R14: 00007fff48e5fac0 R15: 00007fff48e5fac0
   </TASK>

This is caused by the fact that some of the xe_vfio_pci_core_device
members needed for handling reset are only initialized as part of
migration init.

Fix the problem by reorganizing the code to decouple VF init from
migration init.

Fixes: 1f5556ec8b9ef ("vfio/xe: Add device specific vfio_pci driver variant for Intel graphics")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7352
Cc: stable@vger.kernel.org
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/vfio/pci/xe/main.c | 43 ++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 88acfcf840fcc..c20011eb4af3d 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -468,39 +468,46 @@ static const struct vfio_migration_ops xe_vfio_pci_migration_ops = {
 static void xe_vfio_pci_migration_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
 	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
-	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
-	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	if (!xe)
+	if (!xe_sriov_vfio_migration_supported(xe_vdev->xe))
 		return;
-	if (!xe_sriov_vfio_migration_supported(xe))
-		return;
-
-	mutex_init(&xe_vdev->state_mutex);
-	spin_lock_init(&xe_vdev->reset_lock);
-
-	/* PF internal control uses vfid index starting from 1 */
-	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
-	xe_vdev->xe = xe;
 
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	core_vdev->mig_ops = &xe_vfio_pci_migration_ops;
 }
 
-static void xe_vfio_pci_migration_fini(struct xe_vfio_pci_core_device *xe_vdev)
+static int xe_vfio_pci_vf_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
-	if (!xe_vdev->vfid)
-		return;
+	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
+	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
+	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	mutex_destroy(&xe_vdev->state_mutex);
+	if (!pdev->is_virtfn)
+		return 0;
+	if (!xe)
+		return -ENODEV;
+	xe_vdev->xe = xe;
+
+	/* PF internal control uses vfid index starting from 1 */
+	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
+
+	xe_vfio_pci_migration_init(xe_vdev);
+
+	return 0;
 }
 
 static int xe_vfio_pci_init_dev(struct vfio_device *core_vdev)
 {
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
+	int ret;
 
-	xe_vfio_pci_migration_init(xe_vdev);
+	mutex_init(&xe_vdev->state_mutex);
+	spin_lock_init(&xe_vdev->reset_lock);
+
+	ret = xe_vfio_pci_vf_init(xe_vdev);
+	if (ret)
+		return ret;
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
@@ -510,7 +517,7 @@ static void xe_vfio_pci_release_dev(struct vfio_device *core_vdev)
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
 
-	xe_vfio_pci_migration_fini(xe_vdev);
+	mutex_destroy(&xe_vdev->state_mutex);
 }
 
 static const struct vfio_device_ops xe_vfio_pci_ops = {
-- 
2.53.0


