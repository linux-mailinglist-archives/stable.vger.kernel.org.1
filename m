Return-Path: <stable+bounces-244227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNV3B80q+mkhKgMAu9opvQ
	(envelope-from <stable+bounces-244227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:37:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA84D226D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 420563050252
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB148C8B6;
	Tue,  5 May 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeSEyTT1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6A293C4E;
	Tue,  5 May 2026 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002632; cv=fail; b=kUvMC0dFhSySMmflmde8qEBGkQGQkgyZ9Zqj3QYk95f6vZG7xE9UEPNVo9XfJwctbrXEGHIwCCFjhPGj/HExPEP3Tj+ina8JXHeFvGKWscWs7d4ydmDlTBwqBtAvucvDb5BJJChhn3ca5+uhYtHIu7K9Q8iL50bnQrg6ctVn94M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002632; c=relaxed/simple;
	bh=C3VFwU/tXuTIlPezJvReYDf1s58wxYxejPAJvoFYZmE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gs2iuqcG01Cz59h4XhcSKjosFyOUQZIPKNtw8ZDDRqlWJJ7fsZd61GJRMq4P3BKNOiaRSk9q+bCc7LdtDwwhmQ/qm5L/CafvDcr0wB1ABdPCTr7CgWsr/NrjyFenZ6xf0YadUrBZaUXBpnRuXz0opcJG0jWlDZUk3CyvYkflccY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeSEyTT1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778002630; x=1809538630;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=C3VFwU/tXuTIlPezJvReYDf1s58wxYxejPAJvoFYZmE=;
  b=PeSEyTT1sN+ukjSuY4hgKCjtn2hP4qPgztDMzuZBnlrP0/dX3+Ei5+Pw
   65Gv2Q3+POM6Sh46Xb3zuxcfbEuade8YfHjcv7BRa8xa9jL0j6V91S87M
   JPs0YmdUsxi+t+RfwhAxPqhPwd9kYKkG2aDdU//O9uRktuv6sR/siZbzH
   iAPA2PL402HzDeZP8U2ABSqBgdzLAddThWDPajV2Rsed/XYmztdFh0TkD
   fsxf+T+NwBTDJgSuZcAo6kqheDNZADIefM3ItM7+rHlSh4uSBwr0i26HN
   mEu3xP7gCMTbX3nuaMTUcMISlRfNSZxARAYLvK7+lY15GBXpK1B8SghGS
   g==;
X-CSE-ConnectionGUID: sCHc2ragRDimciwkBiBt+A==
X-CSE-MsgGUID: 1eMJ9RSfSmmRCLsmgYsC+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96449475"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="96449475"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:37:09 -0700
X-CSE-ConnectionGUID: DvzhYvLOSxGWUpRRLA/OpA==
X-CSE-MsgGUID: PDThkDGcQWqO4eq5r3msqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="239862288"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 10:37:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:37:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 10:37:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RALqRYq2qysqRhgv8mlTk89KTdV8esWjnZJVEGD99NZrhs1KAvS/BqUV3g8L3dZCz0D+yDgJtd0uaXiuhSxW601BVNRMvZY6U7rCvJGi5jgC/vRXKI45P0EyjFUOp52LzEZXQwoFC02JzsD9o+1l2/qa1XeEyAS0cZFwWjnlBLsEfURoVaxLx+zAn8e8+XqWyQwnE2llfR1Z/xnFncsNXxzYmFIBHONKkFF1Elwe8yzTZHYQCiZQQqG0mAPsJatL2p8fnpE+lqRpTqLXKLUV6nNQhk3FPaaHujee5GnLc4CsSnz9kYWAjiQy+kA9PyC1p0TAh29B4SsFkBH214a1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDN7wHXLm/AOvxvFPQU47N6nY7514jdGNsZs60NUCYM=;
 b=HOJ9NVaNkrMjmv9hEZajvULg1W8qF53KEQbG9DF3QUB+xQsMCVKZc2lS8ZcUsnKlFsAfg5nGKySwo/zhfveorxz1dip1FClMSoqqNTeWsNJX0E4vi3M+LpL9RiAIaHfGCPNqMsay0l9ErDaBhNfSQCQKdcV3fnF/laPpZATSewJdnjqwwrHcMgKkSCAORJXKGCKTxun/pFnt1LmDQXG43p3ZEFnVI0Vj5/XHlCr+NnsfSQkktNc65cHbODOs1ZVkeQjZEePh24dAO7MxiacJZXj9drMEo+WN7AehvxJcppU7x45DBfTk8vKFC9QviNuH0ichbp79dXX6UU6rrUOB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 17:37:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 17:37:05 +0000
Date: Tue, 5 May 2026 10:36:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] drm/ttm/pool: back up at native page order
Message-ID: <afoqt1WhpqhPoqL3@gsse-cloud1.jf.intel.com>
References: <20260505033013.3266938-1-matthew.brost@intel.com>
 <20260505033013.3266938-3-matthew.brost@intel.com>
 <12feb16f1f8dd00458e982785d45415d42a3e768.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12feb16f1f8dd00458e982785d45415d42a3e768.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 939070cb-7fb5-4c1f-989f-08deaaccec54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|20046099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: TTEFPPKLH1nilupYb1NpsXV5dxjMU3sjozoAxDoU+6zvtvNXZsWlRsEPCfFz86GN11Y7+QuQ5mvOj8o3ke9khn1eYTE3Ef3wtKUIneGzgx3OjUYLF+d3FtNFqg1zm5LRm189ldrRI0sJHSABVrTYsbZX3FSR2XLeX6z3ugbVYiDtc9XiWydZoQun/jiIeE7pfOP6J8Ts+XztnPpX4cshGxdvUkKYeycNFwgzzMKlfNg0hVtQN1hHLwrksbs5tSn7aVBRH+F803j5OdNMTQ0Z6FltCiRW+idjs9T0db6qPcNomRDMe0y6bM54vPnOAZJW9nj6o/Z4FeQAtvWnsIYWn0wFz947SWbLcZSXkDFcEpMdSD9GLtY732irJOVmTqgwL3R2qVYDw7qfMbeJOQCPmYiNWQW28IwKnmF7qw/qI1k8cl6W2tcAhxdwwo4OBqf2vnXHyPv1pZ75+FM+bky2Yyiohc5KmLcjzUooN71OtLj4+dzgGqGFVWxOAK96CvsC1hR5bdwLaFIGpj7VeMsFX6SH/xV9I6LV7Talti/qJ7L8C7FGv2xkqMAAml2nl0+BoyhTctCBwt3u8rakeq39yh6Ve2j8HNv9qrH/3G5p6KNk5e0jvTrCXDX5QuwrElQTvUxTGQg77+uS/BinObuxOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(20046099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFsQnBpbDJGdGxEbExGV0k5V1VkM2NYTVdDaUtwZUxzbWFrOVdWODFRWmV2?=
 =?utf-8?B?a2FuMy9zRUxkQkE4TmhIbTNDR0p5TjJRaXdIb3pQYjF4OXd0L1JiUHIraThB?=
 =?utf-8?B?Z2FUK0I5bmY2UmhuSUUySTNpYktyTWw4dW9hdE91bWZtNXZOWmtEZnRNY2pC?=
 =?utf-8?B?ZkpaaGtjbjBmUFI2b3VBQm16emxPQkZ5cmNVZmhSOFFIUGh3T2NhQlZyTmEy?=
 =?utf-8?B?TnFmeWFNQzNRMVZlVnFaL1MzbzlUdGtNU1dmbU9HY1lxR3lEVW9pTDBTbzVk?=
 =?utf-8?B?cUhCaHc5YzBkSEtJM2YyOWZGci81a3JybVZRaDFaMExBN3ExYzZ4YndjZ3gx?=
 =?utf-8?B?emp4SmlTUGlSOVNIZitJS2E1dUtVSTJiSGN6cXNBOEtmYjhlekQrcStHdkNG?=
 =?utf-8?B?eFVTQks1Q2xoQXY2OU85NnBIUnpWR2xqTDdQMk5TNWtUL0FEdUNnczkxWUNR?=
 =?utf-8?B?SlRiN0FWbHJiY1JEQ3czL3VHaG9nZURyNytvdkdPUGdTbGF1RURnTyt4RzVa?=
 =?utf-8?B?MHBVSHdEbS9MSDM2QlJsWnVlYTRGTUROVUxzNzIrU3hwcjQ4K1hQeWRua0E3?=
 =?utf-8?B?M1ZaTSt0bkhDZ3RnM0JRdmcvcWFQazFtOUp3dzcwcERZSGVURTFxaXN0UzE2?=
 =?utf-8?B?cFUrcmpvZjBabzZETDlodG02TmpVSTIxR0RtRkpkb05aNGVqY0huaFovT1lK?=
 =?utf-8?B?QmdQbCt0SnBIY3FLd3FVRFo4eDRzYjBTUXpFUG1kSGpySllRK2ZLbDRFbFlK?=
 =?utf-8?B?eDIvYnU3NTJYa0phb3UzZjRjRW1kSjJEb1pSU2VpTmlXejBrbzJFQ3VkMzk5?=
 =?utf-8?B?V0pWd1JSWTJqODFuWHBrVlhrcHNGQmovM0IrQ1grZVJXdzY1a04wYjZyRGdn?=
 =?utf-8?B?UzFQQUU2enU4UTNsK3BYUTgzUnZxaVNoMHkvQlRCbjdzRUZHV3UyZFBZZjZk?=
 =?utf-8?B?VGdQTmZZdi9aRTJXSkdWYUxaZ2Z4SThmM3krVjdxRGdmUlpoeFJOZ3d3YUpV?=
 =?utf-8?B?WGU0ZG9uOG9sSjZWVkc2cTR1WW8rand4RkZLUjRjQjBXeis1QWsra0oyMGhx?=
 =?utf-8?B?TXNHU3phTG51NkNVeUhaYlFDcnU0TzZCeU9oTkVLT2V0NFl4OFljZWFYOVV6?=
 =?utf-8?B?UERiU3dFVzQ0M3dRNkJ2aU1ZYUtpcnZyYWRaaFFOcm9qaFpObUlNQW92Sy96?=
 =?utf-8?B?QU1YWE9UejZWWDB1YlRyZ1BiV3RZUThEeXlhdG9TdjUyYkJoSTRadDN1cnAr?=
 =?utf-8?B?eFNaRGpIbGV1ckVXMWc2ekFjSXJXTk41QWY2elQ5RnRQcXdIb2gwaDREMXow?=
 =?utf-8?B?NHYrUEtERW0wb0JpZGtpN0JVWWFlN0lKL0x4NUNsTGZFZzBISlZwcWw1UzN1?=
 =?utf-8?B?Qy9WWDQvQXc1SXdDOEpQc1A0UUJqUW0zYXRBbXhxZjZOZjFFNEh5VnhCaDRF?=
 =?utf-8?B?TTY4VTdqUnFzUGROZHZic3Z4WHB6YUZjUDVaTERwbUgwMmM0N2QxTVh3U1Jj?=
 =?utf-8?B?ci9jZ1BJWW5ydXNLOUZ0MU55dzVPaXo4aHdaOGlwekZSVUdxMy9yanFqQXly?=
 =?utf-8?B?NjFwVk9JSTFUV2VqREdWdmpsQXR5TS93c0FHU2ltZXpONUFXcVZsZmk2YWhK?=
 =?utf-8?B?RTVHdElRWE9lVnU5L2J1aHcyM3BadkpjZFc0TmwxNC9TS29uSklCVU11Ylln?=
 =?utf-8?B?elM5cU05UUV4ZXEvaUxBYk9GWWs2RjFnTVBhR0tVQTdkeDdwdy9hbDRwMXcx?=
 =?utf-8?B?blM5SitEVCtYOGxrMmR2dGdneUJ5ZVc0b3ppUVd3QTJHSnRpM0JaZ0VaRFZx?=
 =?utf-8?B?L2VuQzhpdTU4Umt3Wnp6ODdCdGV5Q3NZUWQvbDdoMkplcjNoeHdwVVZFVVEy?=
 =?utf-8?B?YWZOWmVaTlRaMlVwS0hFVzRqNDFTOGE1UmU5Vk5NdjZ5SS9oOU1zM2p3a1hZ?=
 =?utf-8?B?UlNtMUpnbHd1c28vZDh4N1ZNYzRJUG1oZ2Y5VEhTZm40Y2VtRDlDcjJ3aEpx?=
 =?utf-8?B?WUU0aUxsNU01dEZYWDJwUEtseE82WUdEV2hLcUcwMTZNQmYyWG96RTJ4REVK?=
 =?utf-8?B?bFRuVjhuZVg3M0UrQk5sSDF2YWRaVnVYdGVWR2hRdm5DUThQSXUzOUR5aGpC?=
 =?utf-8?B?dnVqOStSSm5YWWRtbzdJd1o4QWxITVRFVytweE4yeitPeDlNN3JCUE1zQTc4?=
 =?utf-8?B?ZzBJZnBkVmZoaERJb3FrcXd2TklpQlRFNERDM0t3aUIwSDNsL3dLTGJYS01T?=
 =?utf-8?B?QkRUNlB4REJscU5yd1lxc1VTWURxeDF6ZW5yV2laa3hENGJFRW9YMmxtK1N5?=
 =?utf-8?B?bWpjVHFKclBBelFOTHlsTzBKai92blV5ZGVwVm1KL0swSXNFeGtwK1JsQWlD?=
 =?utf-8?Q?XQZ0CkX/HHsOADpE=3D?=
X-Exchange-RoutingPolicyChecked: glYBKxerpARSzXJXXm6V83H/85fBaikBo+Z2jTUryb1BuGQbR2GDmevB+rBUGP6HmIi2cvKWAc9uf/+7VVCEO1ZzAwxrbEuvmFwzXibI7+z8+qF6SapdDM0JIB0npk94/HiTdIi7+5QT3SaG26O6xm4nBkqze3slfhA3zBXpda3BP+QK5cPi9a+qMxJAcVl577mLRsAuW7sTMjcPIvtTeQCX8Wf+okeQ3N8dTOtJAOyY91xf7cefL/A/eW6bmJ8cLAnugQWs9wuGU+ZKHChLzlOfQFzs1GCLJvrt4v0UYC/PfUio6gB6HGyIVOs8voNN0lLj9ZSmOVLdO6z4Dc727w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 939070cb-7fb5-4c1f-989f-08deaaccec54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:37:05.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZb20qeDruESvkM7Z/97JvNxS5uSWg68pMdeo+cYz8sIGgcpbW3pYGW10nl44wzC0LcWERA8wSoRGzeT/XCH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 80AA84D226D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244227-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Tue, May 05, 2026 at 11:02:35AM +0200, Thomas Hellström wrote:
> On Mon, 2026-05-04 at 20:30 -0700, Matthew Brost wrote:
> > ttm_pool_split_for_swap() splits high-order pool pages into order-0
> > pages during backup so each 4K page can be released to the system as
> > soon as it has been written to shmem. While this minimizes the
> > allocator's working set during reclaim, it actively fragments memory:
> > every TTM-backed compound page that the shrinker touches is shattered
> > into order-0 pages, even when the rest of the system would prefer
> > that
> > the high-order block stay intact. Under sustained kswapd pressure
> > this
> > is enough to drive other parts of MM into recovery loops from which
> > they cannot easily escape, because the memory TTM just freed is no
> > longer contiguous.
> > 
> > Stop unconditionally splitting on the backup path and back up each
> > compound at its native order in ttm_pool_backup():
> > 
> >   - For each non-handle slot, read the order from the head page and
> >     back up all 1<<order subpages to consecutive shmem indices,
> >     writing the resulting handles into tt->pages[] as we go.
> >   - On success, the compound is freed once at its native order. No
> >     split_page(), no per-4K refcount juggling, no fragmentation
> >     introduced from this path.
> >   - Slots that already hold a backup handle from a previous partial
> >     attempt are skipped. A compound that would extend past a
> >     fault-injection-truncated num_pages is skipped rather than split.
> > 
> > A per-subpage backup failure cannot be made fully atomic: backing up
> > a
> > subpage allocates a shmem folio before the source page can be
> > released,
> > so under true OOM any subpage in a compound (not just the first) may
> > fail to be backed up with the rest of the source compound still live
> > and contiguous. To make forward progress in that case, fall back to
> > splitting the source compound and backing up its remaining subpages
> > individually:
> > 
> >   - On the first per-subpage failure for a compound (and only if
> >     order > 0), call ttm_pool_split_for_swap() to split the source
> >     compound, release the subpages whose contents already live in
> >     shmem (their handles in tt->pages stay valid), and retry the
> >     failing subpage at order 0.
> >   - Subsequent successful subpage backups in the now-split compound
> >     free their source page individually as soon as the handle is
> >     written.
> >   - A second failure after splitting terminates the loop with partial
> >     progress; the remaining order-0 subpages stay in tt->pages as
> >     plain page pointers and are cleaned up by the normal
> >     ttm_pool_drop_backed_up() / ttm_pool_free_range() paths.
> > 
> > This restores the original split-on-OOM fallback behavior while
> > keeping the common, non-OOM case fragmentation-free. It also
> > preserves the "partial backup is allowed" contract: shrunken is
> > incremented per backed-up subpage so the caller still sees forward
> > progress when a compound only partially succeeds.
> > 
> > The restore-side leftover-page branch in ttm_pool_restore_commit() is
> > left as-is for now: that path can still split a previously-retained
> > compound, but in practice it is unreachable under realistic workloads
> > (per profiling we have not been able to trigger it), so it is not
> > worth complicating the restore state machine to avoid the split
> > there.
> > If it ever becomes a problem in practice it can be addressed
> > independently.
> > 
> > ttm_pool_split_for_swap() itself is retained both for the OOM
> > fallback above and for the restore path's remaining caller. The
> > DMA-mapped pre-backup unmap loop, the purge path, ttm_pool_free_*,
> > and ttm_pool_unmap_and_free() already operate at native order and
> > are unchanged.
> > 
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> > shrink pages")
> > Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > A follow-up should attempt writeback to shmem at folio order as well,
> > but the API for doing so is unclear and may be incomplete.
> > 
> > This patch is related to the pending series [1] and significantly
> > reduces the likelihood of Xe entering a kswapd loop under
> > fragmentation.
> > The kswapd → shrinker → Xe shrinker → TTM backup path is still
> > exercised; however, with this change the backup path no longer
> > worsens
> > fragmentation, which previously amplified reclaim pressure and
> > reinforced the kswapd loop.
> > 
> > Nonetheless, the pathological case that [1] aims to address still
> > exists
> > and requires a proper solution. Even with this patch, a kswapd loop
> > due
> > to severe fragmentation can still be triggered, although it is now
> > substantially harder to reproduce.
> > 
> > v2:
> >  - Split pages and free immediately if backup fails are higher order
> >    (Thomas)
> > v3:
> >  - Skip handles in purge path (sashiko)
> > 
> > [1] https://patchwork.freedesktop.org/series/165330/
> > ---
> >  drivers/gpu/drm/ttm/ttm_pool.c | 87 ++++++++++++++++++++++++++++----
> > --
> >  1 file changed, 72 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index c7aab60b7f01..f9e631a20979 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -1047,12 +1047,11 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  {
> >  	struct file *backup = tt->backup;
> >  	struct page *page;
> > -	unsigned long handle;
> >  	gfp_t alloc_gfp;
> >  	gfp_t gfp;
> >  	int ret = 0;
> >  	pgoff_t shrunken = 0;
> > -	pgoff_t i, num_pages;
> > +	pgoff_t i, num_pages, npages;
> >  
> >  	if (WARN_ON(ttm_tt_is_backed_up(tt)))
> >  		return -EINVAL;
> > @@ -1072,7 +1071,8 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  			unsigned int order;
> >  
> >  			page = tt->pages[i];
> > -			if (unlikely(!page)) {
> > +			if (unlikely(!page ||
> > +				    
> > ttm_backup_page_ptr_is_handle(page))) {
> >  				num_pages = 1;
> >  				continue;
> >  			}
> > @@ -1108,28 +1108,85 @@ long ttm_pool_backup(struct ttm_pool *pool,
> > struct ttm_tt *tt,
> >  	if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > should_fail(&backup_fault_inject, 1))
> >  		num_pages = DIV_ROUND_UP(num_pages, 2);
> >  
> > -	for (i = 0; i < num_pages; ++i) {
> > -		s64 shandle;
> > +	for (i = 0; i < num_pages; i += npages) {
> > +		unsigned int order;
> > +		pgoff_t j;
> > +		bool folio_has_been_split = false;
> >  
> > +		npages = 1;
> >  		page = tt->pages[i];
> >  		if (unlikely(!page))
> >  			continue;
> >  
> > -		ttm_pool_split_for_swap(pool, page);
> > +		/* Already-handled entry from a previous attempt. */
> > +		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
> > +			continue;
> > +
> > +		order = ttm_pool_page_order(pool, page);
> > +		npages = 1UL << order;
> >  
> > -		shandle = ttm_backup_backup_page(backup, page,
> > flags->writeback, i,
> > -						 gfp, alloc_gfp);
> > -		if (shandle < 0) {
> > -			/* We allow partially shrunken tts */
> > -			ret = shandle;
> > +		/*
> > +		 * Back up the compound atomically at its native
> > order. If
> > +		 * fault injection truncated num_pages mid-compound,
> > skip
> > +		 * the partial tail rather than splitting.
> > +		 */
> > +		if (unlikely(i + npages > num_pages))
> >  			break;
> > +
> > +		for (j = 0; j < npages; ++j) {
> > +			s64 shandle;
> 
> I still think we should move part of this loop to
> ttm_backup_backup_folio() at this point, rather than open-coding it
> here. It's the design we want to move forward with and would probably
> make the pool code cleaner as well. If we think failures would be
> common we could have ttm_backup_backup_folio() return the number of
> pages that were actually backed up or error Otherwise just return
> success or error and on error truncate the shmem pages that were
> already copied.
> 

Yes, for now I think helper should be ttm_pool layer as it relies a
several other things in ttm_pool.c that at for fixes patch I don't want
to shuffle around. So ttm_pool_backup_folio I think.

Matt

> Thanks,
> Thomas
> 
> 
> > +
> > +try_again_after_split:
> > +			if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
> > +			    should_fail(&backup_fault_inject, 1))
> > +				shandle = -ENOMEM;
> > +			else
> > +				shandle =
> > ttm_backup_backup_page(backup, page + j,
> > +								
> > flags->writeback,
> > +								 i +
> > j, gfp,
> > +								
> > alloc_gfp);
> > +
> > +			if (shandle < 0 && !folio_has_been_split &&
> > order) {
> > +				pgoff_t k;
> > +
> > +				/*
> > +				 * True OOM: could not allocate a
> > shmem folio
> > +				 * for the next subpage. Fall back
> > to splitting
> > +				 * the source compound and backing
> > up subpages
> > +				 * individually. Release the
> > already-backed-up
> > +				 * subpages whose contents now live
> > in shmem;
> > +				 * any further failure terminates
> > the loop with
> > +				 * partial progress (handled by the
> > caller).
> > +				 */
> > +				folio_has_been_split = true;
> > +				ttm_pool_split_for_swap(pool, page);
> > +
> > +				for (k = 0; k < j; ++k) {
> > +					__free_pages_gpu_account(pag
> > e + k, 0, false);
> > +					shrunken++;
> > +				}
> > +
> > +				goto try_again_after_split;
> > +			} else if (shandle < 0) {
> > +				ret = shandle;
> > +				goto out;
> > +			} else if (folio_has_been_split) {
> > +				__free_pages_gpu_account(page + j,
> > 0, false);
> > +				shrunken++;
> > +			}
> > +
> > +			tt->pages[i + j] =
> > ttm_backup_handle_to_page_ptr(shandle);
> > +		}
> > +
> > +		if (!folio_has_been_split) {
> > +			/* Compound fully backed up; free at native
> > order. */
> > +			page->private = 0;
> > +			__free_pages_gpu_account(page, order,
> > false);
> > +			shrunken += npages;
> >  		}
> > -		handle = shandle;
> > -		tt->pages[i] =
> > ttm_backup_handle_to_page_ptr(handle);
> > -		__free_pages_gpu_account(page, 0, false);
> > -		shrunken++;
> >  	}
> >  
> > +out:
> >  	return shrunken ? shrunken : ret;
> >  }
> >  

