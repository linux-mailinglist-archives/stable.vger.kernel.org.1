Return-Path: <stable+bounces-225377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NYPCXpctGklmQAAu9opvQ
	(envelope-from <stable+bounces-225377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:50:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5042288F6A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A15530C4005
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457723E120A;
	Fri, 13 Mar 2026 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xeizjkx1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67C3C9EE4
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427707; cv=fail; b=etSg7YVNvEP/twZmgkcFyeWwJNcbz2Jo3z74hyJ3sXjJFuIXP7Mrqy3hM6UQSfMqa7y5rMGeMBK1nRClFnq46Pqbn6fSTiLkTKzECiEPrB/W/+AMX7wYw3UpW+8k022qEku7IZLHCtiH7DbH/R5R8uCKXijJ9i1vaHc1mS9Lfo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427707; c=relaxed/simple;
	bh=g8C1ab0XL0EadQrFr+zeHx1LDJXNlZWmSg3F4/s/SQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFihiy75SEPU5YPL+Vbi010DTBMEjlwgE4ADZzkNthX9gXZaXdt4X3tJdcCl36TT1aB6yYors90v/k7y6NnevDo/6/u4heI8+Xk1FEcw2MgR8lOTA0x8guROrFIoJrfb+nQ5qGZkq6HW2L2MbFWdEOE+Z9CDnYC4fbxDSU8j4+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xeizjkx1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773427706; x=1804963706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g8C1ab0XL0EadQrFr+zeHx1LDJXNlZWmSg3F4/s/SQc=;
  b=Xeizjkx1UoLr2BuW+ZDeLrAsO1oT+rEuGX8fI9vaQwqq/WeIuHuJPcrc
   am7iNoi/AvFww3ucATOncHUNdCzyOL49vmPQVxwqPkJglqIRrDv1Rfzwd
   koVOVHk2pMxkgngLCB5cyl7Hyne2zuPFH3dHW9EpMcSq3ICqjU+tQ+tXn
   gDsskJUBR2LS7cEayp8rigcEwMG7fqAjKOIGpye/Vnpszzl5+KHRnuLn4
   iqHnntnZsq+2s4XiW72PeLKpZh/6jiqld1g1cX/WF/XN1m6pzLzpqiJF8
   7unE02q2aUPYpPYVtX3eQHje9L5Cf4aZKdH8kbpZBKIip62v+JPZiWy6P
   w==;
X-CSE-ConnectionGUID: Ey1mfxmuTOqUXuD8dcjggA==
X-CSE-MsgGUID: +9XQoIPgSaCsEa2K+Tcx3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85627403"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85627403"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:48:25 -0700
X-CSE-ConnectionGUID: Mj1jCwU+SPS4XmoeelL3lg==
X-CSE-MsgGUID: W7db4mdRSjipz+qAhIN9Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225356294"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:48:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:48:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 11:48:24 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 11:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dfd2Y2boAu8uIdI18tsrS9ILT2/oUOpLK00uObOlLudPoAoZSM3MFbw092wOFizx9PDmVaeFJtZ0BLP2xP0Yo8odYvDZiRvKwO+z8aYVd+faXZVzVd0Xtk6+dNtSxRe7pOLtJhqly4G5ZoUoH54RZFb3f0QTN4unw4fZ/9fObmTT+5pVAWbX3WO0Cir2K09X4bVIhIhbCoxOY/BXvsbNsg9Y0BIS/RaMIZmWfGO11hR7w1YyQBZSab7HuVjxqvf9Tvury4gevgmwbLRMt/Iqo/zhPr1XzRX91J/L9nZR1ysEaeRFY/HvhAFutPUi3dYjPyU5DAgVNTaUUUN8GTwXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjhoPMQqMjSg2+tgN0KjCub4v0q5/4VaULIjumkjOPI=;
 b=WwGZqUdZu2OO6zfg7xtJudwJvzXc5UISUiqS6ZwSulZ7Wv5ot+jpszkX7vvrUbAmsz2WPQZsjunLtf19FucnQzJtvl1CbUCZgvfg5vIJsUtaZyrMkTopY/EfZKOHLZUG+1A0yWCZJnCJ029pHmb3YOgCfE0dhr4rbQ7Sf7ZP85V0OnOq96DKqO85fUIEyMvQpCsLjTNV9p/vxEoHFjJYy2MC8t+/DEe7YmEdAb4yfmuR11/9FB4O5MFnrnkeM5I8ChM+T29c4V/mGNosoKr3V95NcRxMwEcIdKA4n/PhKPtyC1lfib27KCrdd6Wh5W1w+AAGxQXGy7y7YSQcaARy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 18:48:22 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 18:48:22 +0000
Date: Fri, 13 Mar 2026 11:48:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Dong, Zhanjun" <zhanjun.dong@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v9 2/7] drm/xe: Forcefully tear down exec queues in GuC
 submit fini
Message-ID: <abRb842rJCYXF3dK@lstrano-desk.jf.intel.com>
References: <20260310225039.1320161-1-zhanjun.dong@intel.com>
 <20260310225039.1320161-3-zhanjun.dong@intel.com>
 <70fc23c8-a926-4767-bb8b-bf134a6eea95@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70fc23c8-a926-4767-bb8b-bf134a6eea95@intel.com>
X-ClientProxiedBy: MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 45963fc9-11d2-4919-8431-08de813119de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: KZ+Yrq1w3F5zgKZkeFkPisO4A2ABeq0KUPEI5yZ2w5Fgn7sv29PZDcLvjtXOieiOUjAyNWGeGWmVDM7dS+2dz6RiO9zXV8EDa28/CRgo/H7K0RIbrnQcIdn9S1t3BOCmqtoDCjlDaWdF3nO3XpRGx2oTL+Z0C0qTV1nbjAfHj63/tRSxFkT8j5LkB/uyCgOnzk4lhl2HGXQXGpoEB1fkTE4d7ooz98tff7jgQdVzibUleFTu2jHBulBjYrCur3t22IG1XmG+fylnU+vuyXLceNUpWOV+ApfEYx9YYQpSW5lNgkbszIUTrOJlRVfLhgov6YL2SEkv1YPtMH1UjV88EnRm9VIODM5Z4DZZXQVeEChrAw0k36Od6nDJDFlKpJgNQfTmYqyruHONBX2cYeem6UtUBAfXXZaBZlsJyn7IeXnpblJweNQk6HNXHbpEU/xfp2OSeT2OGY8rFPrw75QoFImUhz3IIglJ3Oj8+a6Fq3BhAquDEM12EArtDgg+O8PHEzpIsQxT/rQBJ2OVwaCfY+m5Ut3S041Cx6/t321fTYlhJPTYENaR55lc8KH6G8P9qee8Ajh6EKEhZnI9q3g7YBg4odj9wUOtFjxLNeyqTJ/hlTlWQmsSKT8mwlKxh131j+QCp0J+1PvyFseXq5Ym62KHcJ+H8sLD3V4mE6MYHnJvbbM9IgSF68P1v0FaZcxY/6PrqHzQ9YteqjMBBXe+emQi5tBGbExg12CQIF1MhJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jlax+A/NEN9HSW/pD2AaYIziKXs1/AvlBTgvYImxwLVrz+mUQgsoVPzVJUMG?=
 =?us-ascii?Q?NGFg8fp5vQI5nWuGdNdLSgXNIXyhMbByDjh/YloWKdwmKLE9Xrq9f52k92ni?=
 =?us-ascii?Q?5iHMFwmPc6g8LIT5JiCMKe0xvbBTKbGSBWV3pY8QggCEiT1gdtDtezSUWfhP?=
 =?us-ascii?Q?8cn/WqeEuonGW0eZdzO25XzrsEptg/zJnBogIQw6iw2UdZB16ZlTYaaFK5sB?=
 =?us-ascii?Q?uACZmtCjiR5pv4ClKiAeSOCs+OghhmQ0xHnecdanGRmLsJjRZjYX3rq49s7Y?=
 =?us-ascii?Q?1cibCkXMLOZ7q8A0oG7rkBiFtJ6PifqNVNLltPoHBX3eNBi8Kvt+J3H8ZOuB?=
 =?us-ascii?Q?FvL85CTpmZaN3LpHc9+MpxkrqTd398Z67dEOFuUkKHVaKUkhPCrHEHPmDav2?=
 =?us-ascii?Q?hHdAukZr+VxtTv0QHkHJ3MFr36QHEdLjVCX8CD3ecPahnIIL/5DKABlhh4WH?=
 =?us-ascii?Q?hgrrl+M8XSphwyFlm/E0udgAxnshXBJxrlxr8daXJwMp1T9mLjJXICtfscRP?=
 =?us-ascii?Q?w0X3syS6cYuTE56uwkVxoY/Qy9TW9sUuWupEg1c52fI+iFNNM8eQFocKE/eY?=
 =?us-ascii?Q?m4yLwyfCwdRLzgzG0MDsAoAd0kjnCCOou60W26Yd24mcGETs+Wy6v7J2W7fl?=
 =?us-ascii?Q?6OHC0baHu0iJZbWSyec8eGdXjiWMX6re0fLkoaYxDjx1h0NSown4lrhK777j?=
 =?us-ascii?Q?+cWdg3+KOMJegDIbDWm3edTsmWcpUcs0kzoRBaDd0i1Vb3ayccFDN5JCk9hL?=
 =?us-ascii?Q?xlQMtfu1W/T0QPHAxms7I+iziFqfqxirZ9ITXxI61isPrEKWSgUYbmU52DSr?=
 =?us-ascii?Q?PZajdFMnMqoVrwsXea/QCIiRBm0eMxAYfuEVa0DvpY8gcMx/r2FM3usFTzZB?=
 =?us-ascii?Q?U59vHrWCIE28CZEZwquRdE5iwuhPn/dqMjlgQtW+73l5XvjixG92OkabEcOB?=
 =?us-ascii?Q?eX9XF5FKxMFMAc7MBSBsrucLnxhDOVKgCsi7NSyWTjgsqxV0/WPnPvhjb/FO?=
 =?us-ascii?Q?aaz2zZDdXDHwaQUdKmWfX+zerMx2Yhe2XwElUu8F/qfZXsFxetaW6uW7i2EN?=
 =?us-ascii?Q?IfqoBGQ9xJ7Y8LdUyYzYUS/bGXUCYuPPLYrr/4THEU2i0atIYMM61VLFskZw?=
 =?us-ascii?Q?leDl5w5BQUO+Ud4XitaVz+EC46pXf68L9HS44dFi14gbaS5FzG0edFQp9kbH?=
 =?us-ascii?Q?V+Dn7HJwhElANpfnlzluV7dkcOHqUHYEGKKujJH6DO1ouB6rcWpT1oCDO2ty?=
 =?us-ascii?Q?0I/lOO+MDs2mLK1AebVqHbQv8drrsLcg86R521HrSV+rxwlSTrFC7SBv/SVc?=
 =?us-ascii?Q?D0pbP6uusJRkFhKcCFXsUQ1xIHOiG8CC9aT1lrzifmm2nwywVaYgQF92p0Op?=
 =?us-ascii?Q?5xoOlzsGX9q4FC/TCQiJNrCLRGksJwfZ5PIULmgG8UEhBtUfXr2N4OenZrpj?=
 =?us-ascii?Q?lDZ7mD8CvjS2UjQ5m6BS1QvFRjemmb9wULg7Jmxu/2PkT1WYU/BmZemjuONb?=
 =?us-ascii?Q?Du3ER81grn901Qb88ctY0kgLeIfUdMkdr+2JP1i9Iwxk7zDSvzZovFwD2BGX?=
 =?us-ascii?Q?T7y47vgxTucgC6VgVsa/Q0X48MObDnrRLUosbcxVEoSW6FplWIDi8+TF+jQT?=
 =?us-ascii?Q?59x97IFonBD5h0o+sjhmQoUeSW/Mx3/JPT97D76dGWntJSHgiIvbZ3WdyHf+?=
 =?us-ascii?Q?UaDJfaam72n6fFjneuN34Un+m3zalzWVBYPCzIbaDskDUUJukcSLiDnrQMM2?=
 =?us-ascii?Q?gzT1vTRFG1h3tu4MXUaAVlhEeP+Sink=3D?=
X-Exchange-RoutingPolicyChecked: UEeq6isiAitFqu+CRApRfvPgrnvF10OBNsAyChRN7MXtiewc8+zwuT4X0SD14DcC2I8kKy6AYIQ8oGg0DAirIEmXS6MGOnFc0dTiqhYBDOr3gYQlBy4uL3Xkr13+Wd/sfOhUwJHyw9l8++FuW9lrMi7AehA5Hw0Iyr8WzC3lce74APMYtJlwfAdLB0rOyWF+vwyEA7bMXDzvl9jQG4ybEDn/7CJpckXDU0Y9wE+7vvWM1Klw8D51P5gUKtzaoIXiEGT0t/6/QpYfZWy0i9nCtyrWObmhrm0xcYog3jX5O4sSA7mcJBzB2OJ/lyavZfrLbOaYz0hdnKnCQFFdicYJdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45963fc9-11d2-4919-8431-08de813119de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:48:22.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRWRI2knnU3W9gjL7G8GjEgNfmqVP+scBd1OUEanbkvwx7g3ExHuu5+MV7+wIeY0hyc18wo/5Gm8bBfpJGU+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-225377-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lstrano-desk.jf.intel.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A5042288F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:34:30PM -0400, Dong, Zhanjun wrote:
> 
> 
> On 2026-03-10 6:50 p.m., Zhanjun Dong wrote:
> > In GuC submit fini, forcefully tear down any exec queues by disabling
> > CTs, stopping the scheduler (which cleans up lost G2H), killing all
> > remaining queues, and resuming scheduling to allow any remaining cleanup
> > actions to complete and signal any remaining fences.
> > 
> > Split guc_submit_fini into device related and software only part. Using
> > device-managed and drm-managed action guarantees the correct ordering of
> > cleanup.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_guc.c        | 26 ++++++++++++++--
> >   drivers/gpu/drm/xe/xe_guc.h        |  1 +
> >   drivers/gpu/drm/xe/xe_guc_submit.c | 48 +++++++++++++++++++++++-------
> >   3 files changed, 63 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > index e75653a5e797..f6964b8f8ede 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.c
> > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > @@ -1399,15 +1399,37 @@ int xe_guc_enable_communication(struct xe_guc *guc)
> >   	return 0;
> >   }
> > -int xe_guc_suspend(struct xe_guc *guc)
> > +/**
> > + * xe_guc_softreset() - Soft reset GuC
> > + * @guc: The GuC object
> > + *
> > + * Send soft reset command to GuC through mmio send.
> > + *
> > + * Return: 0 if success, otherwise error code
> > + */
> > +int xe_guc_softreset(struct xe_guc *guc)
> >   {
> > -	struct xe_gt *gt = guc_to_gt(guc);
> >   	u32 action[] = {
> >   		XE_GUC_ACTION_CLIENT_SOFT_RESET,
> >   	};
> >   	int ret;
> > +	if (!xe_uc_fw_is_running(&guc->fw))
> > +		return 0;
> > +
> >   	ret = xe_guc_mmio_send(guc, action, ARRAY_SIZE(action));
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +int xe_guc_suspend(struct xe_guc *guc)
> > +{
> > +	struct xe_gt *gt = guc_to_gt(guc);
> > +	int ret;
> > +
> > +	ret = xe_guc_softreset(guc);
> >   	if (ret) {
> >   		xe_gt_err(gt, "GuC suspend failed: %pe\n", ERR_PTR(ret));
> >   		return ret;
> > diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> > index 66e7edc70ed9..02514914f404 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.h
> > +++ b/drivers/gpu/drm/xe/xe_guc.h
> > @@ -44,6 +44,7 @@ int xe_guc_opt_in_features_enable(struct xe_guc *guc);
> >   void xe_guc_runtime_suspend(struct xe_guc *guc);
> >   void xe_guc_runtime_resume(struct xe_guc *guc);
> >   int xe_guc_suspend(struct xe_guc *guc);
> > +int xe_guc_softreset(struct xe_guc *guc);
> >   void xe_guc_notify(struct xe_guc *guc);
> >   int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
> >   int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index b31e0e0af5cb..8afd424b27fb 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -47,6 +47,8 @@
> >   #define XE_GUC_EXEC_QUEUE_CGP_CONTEXT_ERROR_LEN		6
> > +static int guc_submit_reset_prepare(struct xe_guc *guc);
> > +
> >   static struct xe_guc *
> >   exec_queue_to_guc(struct xe_exec_queue *q)
> >   {
> > @@ -238,7 +240,7 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
> >   		 EXEC_QUEUE_STATE_BANNED));
> >   }
> > -static void guc_submit_fini(struct drm_device *drm, void *arg)
> > +static void guc_submit_sw_fini(struct drm_device *drm, void *arg)
> >   {
> >   	struct xe_guc *guc = arg;
> >   	struct xe_device *xe = guc_to_xe(guc);
> > @@ -256,6 +258,19 @@ static void guc_submit_fini(struct drm_device *drm, void *arg)
> >   	xa_destroy(&guc->submission_state.exec_queue_lookup);
> >   }
> > +static void guc_submit_fini(void *arg)
> > +{
> > +	struct xe_guc *guc = arg;
> > +
> > +	/* Forcefully kill any remaining exec queues */
> Shall we do VF bypass here?
> 

Why? These flows work on VFs and are still required. This is initiating
a software cut off communication with the GuC and cleaning up any lost
communications with the GuC so all queues are destroyed.

Matt

> Regards,
> Zhanjun Dong
> > +	xe_guc_ct_stop(&guc->ct);
> > +	guc_submit_reset_prepare(guc);
> > +	xe_guc_softreset(guc);
> > +	xe_guc_submit_stop(guc);
> > +	xe_uc_fw_sanitize(&guc->fw);
> > +	xe_guc_submit_pause_abort(guc);
> > +}
> > +
> >   static void guc_submit_wedged_fini(void *arg)
> >   {
> >   	struct xe_guc *guc = arg;
> > @@ -325,7 +340,11 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
> >   	guc->submission_state.initialized = true;
> > -	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
> > +	err = drmm_add_action_or_reset(&xe->drm, guc_submit_sw_fini, guc);
> > +	if (err)
> > +		return err;
> > +
> > +	return devm_add_action_or_reset(xe->drm.dev, guc_submit_fini, guc);
> >   }
> >   /*
> > @@ -2298,6 +2317,7 @@ static const struct xe_exec_queue_ops guc_exec_queue_ops = {
> >   static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
> >   {
> >   	struct xe_gpu_scheduler *sched = &q->guc->sched;
> > +	bool do_destroy = false;
> >   	/* Stop scheduling + flush any DRM scheduler operations */
> >   	xe_sched_submission_stop(sched);
> > @@ -2305,7 +2325,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
> >   	/* Clean up lost G2H + reset engine state */
> >   	if (exec_queue_registered(q)) {
> >   		if (exec_queue_destroyed(q))
> > -			__guc_exec_queue_destroy(guc, q);
> > +			do_destroy = true;
> >   	}
> >   	if (q->guc->suspend_pending) {
> >   		set_exec_queue_suspended(q);
> > @@ -2341,18 +2361,15 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
> >   			xe_guc_exec_queue_trigger_cleanup(q);
> >   		}
> >   	}
> > +
> > +	if (do_destroy)
> > +		__guc_exec_queue_destroy(guc, q);
> >   }
> > -int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> > +static int guc_submit_reset_prepare(struct xe_guc *guc)
> >   {
> >   	int ret;
> > -	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> > -		return 0;
> > -
> > -	if (!guc->submission_state.initialized)
> > -		return 0;
> > -
> >   	/*
> >   	 * Using an atomic here rather than submission_state.lock as this
> >   	 * function can be called while holding the CT lock (engine reset
> > @@ -2367,6 +2384,17 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> >   	return ret;
> >   }
> > +int xe_guc_submit_reset_prepare(struct xe_guc *guc)
> > +{
> > +	if (xe_gt_WARN_ON(guc_to_gt(guc), vf_recovery(guc)))
> > +		return 0;
> > +
> > +	if (!guc->submission_state.initialized)
> > +		return 0;
> > +
> > +	return guc_submit_reset_prepare(guc);
> > +}
> > +
> >   void xe_guc_submit_reset_wait(struct xe_guc *guc)
> >   {
> >   	wait_event(guc->ct.wq, xe_device_wedged(guc_to_xe(guc)) ||
> 

