Return-Path: <stable+bounces-132803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538F7A8AB5D
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 00:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F911885675
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E0728F530;
	Tue, 15 Apr 2025 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+tiPT42"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0515236431
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756881; cv=fail; b=FPuR+fh2wXcfjhC45Wy/Zip2oUb+z+YV5w6GrNInN5RgrdWr4hwsrTuh5KVO7005fWORIu7fHfYvhNROrBwTUJavygUFgGPzo4ndXoYeRBaI+ai+QJbbBQuCeyQBHAsxYIwTFr66fLIxvFAwV/4L28D1EhuHbAn8gfrpJ2NEsCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756881; c=relaxed/simple;
	bh=vo4qVTO2FI6yxT3lYXWVTisUjJUlpdZnUI0UBvAVlj8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=geVdA9WsNlHb36r/OWcxNhVE4vszb/tK0D6YL3zgPUFQaYo0MiiX7FJyq2+ZUH+Js522+5mmvKA+EZiEuozuCDZxmTNbnyvJ3S2JMW+Md179CyjEwFZWKIZWdrZOd/tiAqkyU4ayEK4qQqIXGd7Xupl8UjtRclytboNR1hBmGDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+tiPT42; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744756880; x=1776292880;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vo4qVTO2FI6yxT3lYXWVTisUjJUlpdZnUI0UBvAVlj8=;
  b=Y+tiPT42+OXwjj/rvXceXXvXHkkLEsrFZWLgAzrPHVdedlvUGwnhXVGu
   pPr3qCT9U9rakHBQCMjLd2WHYF0DiVnd4KnIoPFTYq45rVT0FNkB2HMrR
   ZITI5SlKUpkjrqdpaGUTtbiVfiRfsMzzgYHJZHELcFpu4MAkX5nMxk19s
   3a5ibJlcLI9nK7bO3UNzRsj2IGf8WoTpM00FGtb7rUJWM9X+CYPhioqe9
   rlsbxfPUbhs0/J9/x7Tz2iG+3qF1bv+vBNR0Yko0QjXNU64bMGmBKbIU2
   47eq5ZvhskUyykCunKmC44FvgokB13kzWfR+p3eMBCYpi+OnjThzUn3yo
   A==;
X-CSE-ConnectionGUID: f2FzvJo3QZa2hLt70ty7Iw==
X-CSE-MsgGUID: tdv864+7QXCxSYF396DAow==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46415371"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46415371"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 15:41:08 -0700
X-CSE-ConnectionGUID: 7QYmYm5WSda2y3/Da/MY1A==
X-CSE-MsgGUID: chAnFNHXQ0akm3TO4y84hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="135047688"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 15:41:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 15:41:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 15:41:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 15:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4uAFs0CNTeT/P00YM3KvF+pqI0r/nGGAwphoIY9X6Xi8AQKSckSTN2IgRkMDf3WnPqV1me3JTH60kHOhZ3C8d3UYSR7pebXgTtoHK+S2AybeOf8sqtL6NPVaKu5CqoodfgEJhF/XzbYIZH0GsHpBRmG/fSk4NamgW7mcLSiCtkTZdpmGjxkXm2BLdjyS9Kgo+6Pcwx5EKQKS80VuEvudKftLo3HHuYC+9yxIB9AmezTLFAUrE4ywXlR8cWFP83oCC8w3LsknS/z2VNTgg2IftzA4o6f8Ucq2OgivaMB/IrPXbodZYGJpgK9nxknItOJC3Qnw2w62ZDDpsaYaoyNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YHQvcJK2YDr9BfBS8WwZ8VeVJd+05be3TZ9jX6TvvQ=;
 b=FnTwgRQHdDa/QMz92bqYlAIj22jnED0CxdJKUCCi5yOrTUuKC6Rgmjih3NEkTW2QNMMUfWZgV9dYPCOmkVyDfvGmUPbWtn4Q+2sV1aQE7vEpsEQWV43AG3on5VtdE+ABtp43TB5K8ZHBOhAWiRpxAOd6tvQsRYlxzjt2u344tsW8r+oewL8WQl7PRF9WlsVvQMWTZaFmguk+VKu0g2oqGdSKBbxVOPGVAhxJmQlidN7KXO/hTT9JiaDYU6895tWjSIhS/ZS4t5+eSo9Khlw6pjGaPf5RWYwQoWemu6gsHLjY84CDM61E6/26LEBMZ3SSfGS/6shYCnDcrv9xOBsEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 22:41:01 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 22:41:01 +0000
Date: Tue, 15 Apr 2025 15:42:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/userptr: fix notifier vs folio deadlock
Message-ID: <Z/7gzLDCtXfY2bz4@lstrano-desk.jf.intel.com>
References: <20250414132539.26654-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414132539.26654-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9a8f16-e8e7-42ae-a1b7-08dd7c6e9947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qPWL15e1CysB9gwVWMNfVTWAEJSfS87T6f8Z0NviXao3Dl/FM1FxohUBVW?=
 =?iso-8859-1?Q?se1A3XA8HY56XLMI4bNDTSisewyncmxbR/jeIqtDkONbT9kMKksjcmacda?=
 =?iso-8859-1?Q?1xCJupOew+j/jpZHeXI43wKM6q4Y9W8+Ul/Ei4T23Fit1pMM9JOzenz5F9?=
 =?iso-8859-1?Q?RNhFUEl+lMiWKvyg6rDtG+LhEYUR10Q1tsG1XgotF8o4WUuflN50Gf1uXW?=
 =?iso-8859-1?Q?87aiX5hgNv9r5deWPdGg1l4LhTX1vXet8g1h9IgdJ9/uKMahwJ+oxQ2RCb?=
 =?iso-8859-1?Q?Am91LdVVEcA/kziSJInu5oKDiJrOt5RdJaOLydzNJMctiDxdbw+akWPIQj?=
 =?iso-8859-1?Q?SqtjviMrgkz26Ekvy5H2oPka/BBnQKU5KLjlXk7S42fIjXKT7AkXfQRkYq?=
 =?iso-8859-1?Q?8eqTqx5qy6BAvsQAgs/49IAYZfRy0Fyl/Pkvx/qDco2lQvRUL5IT3+L0NI?=
 =?iso-8859-1?Q?lEqqeTeGj/5qBqGKLpFFObb8LFreSz2Zu4xrtxLErEsQ129VnDbSAJFL4x?=
 =?iso-8859-1?Q?wRwu6eBPgforto8w938gcg4TnkWIjF4rjVEzGeIUJHgMTVTCt3bllIv+l8?=
 =?iso-8859-1?Q?qqsezhgME+lcOLC8VXESZHR6k8RDQ/jcK6xek1lEwx1sUaRQ19TVhfSXsx?=
 =?iso-8859-1?Q?VzYH+wWNq8Ip6kd37qN+G0P7VK5FVBRq7nTFwBCmGo1bLmdfVJHgfzJZUm?=
 =?iso-8859-1?Q?GsxNosuRRPf2/wyobBuWIGDDb4vfvYPVHw8Mu7n4mBH3J7aQ3kqEFex+Yx?=
 =?iso-8859-1?Q?tv6GmHKCTPFqrrlR77OhqQanHOLpIj+av9ZntT0dbPqOEuXJZMrP9o8VvD?=
 =?iso-8859-1?Q?wnjxtCMkB5SH+twGS52J68PQstFB901la8dlL9QasEr3+Rb8+/U1fRDhMg?=
 =?iso-8859-1?Q?tUjFsm1mhn9W3BINJvXHLgakVYYIXFZGmFWkBVIfAYCj8mhCzglbRZ4NUr?=
 =?iso-8859-1?Q?xRoQsNv8NBDXuv1l+okPv/GvPTEvIUAZKcQSnBf4YqsiBsBxldhf9w1NKk?=
 =?iso-8859-1?Q?gn/eQceGkxDoVylRwDRWCuX7r/E0lHFjlk9Gu92nxR1F8hj65OCLl2/WMm?=
 =?iso-8859-1?Q?vh+rm73DfkslrxWNrxvejfOMNHYHRf+9hL0rlQfou990xE6Gajo5+WXdUw?=
 =?iso-8859-1?Q?yPw8f1smUe1N188Ou0oN391oLSsEn4kFCdsYD4wNR3MUSTt3NXcUfRXSB6?=
 =?iso-8859-1?Q?sXNpQBen5GhAtYNousogXwIcDEMcD7F0Rxug2GqpZvgt+zZOGVu6W1kp7V?=
 =?iso-8859-1?Q?ssQVAdZdWpOWERFEoibYG/8EQH5e1rQ5hWz+k/Fpmxf5N2uTNTWOXVYyyc?=
 =?iso-8859-1?Q?rWVpa6Q7nVjN4yqvfFU8dUmGIBD6OUFolvyM5maH9mnaSuyWz3Zb2T8kZv?=
 =?iso-8859-1?Q?rg5ln4OGLgPMcdeTlTB4D1N3JZyUhDerZ7Gp+SMsaOtbuZQndSicU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FNCIFFMunadt7s2IlrmvOg2xIr74EAj+OE4O+72yXAvc9mMD4dRMjZXmsc?=
 =?iso-8859-1?Q?/3mwV2LI/u7jsf5LqPfCopyExn3oiiEvOIajqMZZP4h1iosRYff0VQrhYs?=
 =?iso-8859-1?Q?bMYTzShEyaw87lm0OekLgkWu4TlfGbIU8qScodbsnWyOBVbQHzoUHsMAw9?=
 =?iso-8859-1?Q?vhT10wRI4dk93yeH4dY7Vhx41kxtcI7OTSSFrt3hk0N6oBNavKSKAj40VE?=
 =?iso-8859-1?Q?5xa5A8gPzyNW+aeD2faeGHcEtCIL+PGVpOCqNX5QETs9w6drHKmbcoYaLb?=
 =?iso-8859-1?Q?5QFnZVBpqwFICr/IwskUrtnBlqLmwucANZKiRaHpGGaNRPLe/A30TsceU6?=
 =?iso-8859-1?Q?DchBCnfoOM+RLMZpnF82ecs/Y49l5yNiCv6j9zHSCaA7ix0JrMwWfM+6Re?=
 =?iso-8859-1?Q?BAsFCyRMHChxg9Fvw3ThUO1ZFz6+YWQG1PC58c0cTLvHvDWlMSfAZhUU+p?=
 =?iso-8859-1?Q?gJi4M7WGx8G3AoQs9gSS5ztuPJkloBL//9DdWovjOJvhrhUxwDadRCUFOf?=
 =?iso-8859-1?Q?dNHPabAEdlswZFvNj79xxQwEb3ISYduSg2Q7ZluXMWgIdcrhYyLotkgEjl?=
 =?iso-8859-1?Q?9bVnmHKJoD/pOMiUSla56V+oIkz3kq0lBvA6ATbgT0XzDXaJFw2GEkhs6n?=
 =?iso-8859-1?Q?oqe9/g0jaIA6GEnRtgN69O85rviZDalw+M6iLa3qRF0362SpgY7JVzdbQu?=
 =?iso-8859-1?Q?0roi6qirjl9IBeUtg3wMUTzPWDuyzyUZdMaJqJ5x5aJmRckQfpK27CKyOs?=
 =?iso-8859-1?Q?bNuoO1oibTpKzK666lrm3uSGoDWSu320TlcFWgL2nGilcg4Fdwp7pTvD8K?=
 =?iso-8859-1?Q?QfrRDQI8Q0+IhALCyOrsNV1JEoALo3j/87MpTumteKLZU6QcF0xx9o9UlK?=
 =?iso-8859-1?Q?AG1vViRaJ7h3GkkPb/IahS4XDJPN9TIMWEZtd8HkSoxiLpTvERWYmM4+cj?=
 =?iso-8859-1?Q?1hcKiGmBpmc52aYO258gbPK1LMXc8fQPlpgCabOj3PBX0CmXov5bRJWT9m?=
 =?iso-8859-1?Q?XlK8dvxuEb8ZRWYv00QWOalqpKUqMLDOYG45SLsccFJW/7T6QNzIxryV8j?=
 =?iso-8859-1?Q?4+en2GXly6LVoREB3Q8m0dvfwx4oRdznw96pI5TAebeBMSLHIJU4IvqdN+?=
 =?iso-8859-1?Q?yIfJ8OoeeK33QnIl8EZtaJh87kjbaEDGedTZYE28EUCh/H0FQ4nDeLOmHL?=
 =?iso-8859-1?Q?inFqfleMZXck41b2iV8I3Ox7xclH5cGpKflaPgTs+H8JjuWK+ZGJQWuox4?=
 =?iso-8859-1?Q?A/eVy3wNJH3JOSm7IouauSlxl8La8IbmDOkOs46Ty+OZ/c82Ns1kGjQSux?=
 =?iso-8859-1?Q?/S77n+v1sct+Op31RwEKtJ7VWyqmWUBrDpUgP6LOqDn6gnistjrpHSNaBz?=
 =?iso-8859-1?Q?MXcaIG+2uQT7IWTKQkud7hx6Ms5nz4oBMdlTF3MRZR5UCC+E9hN9m2m4s+?=
 =?iso-8859-1?Q?7BIp7ciBemv1GIHLBvhjSkXIJbLhf+1ryuSGfuL2t5sdmrdqcIqLCr3VIG?=
 =?iso-8859-1?Q?Hnpawv0Cz1Wf9RbzGY9ae4RMj2kmR9q3cF+fASXJ5XwZFz16xKx7g28e7w?=
 =?iso-8859-1?Q?2LrfzeJQ/wLynOIEDYIEXzM1YGPffkQOKU5+nhH4tpEMM//CimQOqdz+Bx?=
 =?iso-8859-1?Q?ktKf054ZZsHq2xNzZFjDiVloqd2sSYqi+/eEoE4Dtq/FfjhmsG9Ldkpw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9a8f16-e8e7-42ae-a1b7-08dd7c6e9947
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 22:41:01.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKCVgJMoSjLGs+URPEFrfE/8eOvwZqdE+BeoMm92RxXbYcM0Gut9j1k6kk2DhXtU4rbUzUCySZORkFS7T6Y/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com

On Mon, Apr 14, 2025 at 02:25:40PM +0100, Matthew Auld wrote:
> User is reporting what smells like notifier vs folio deadlock, where
> migrate_pages_batch() on core kernel side is holding folio lock(s) and
> then interacting with the mappings of it, however those mappings are
> tied to some userptr, which means calling into the notifier callback and
> grabbing the notifier lock. With perfect timing it looks possible that
> the pages we pulled from the hmm fault can get sniped by
> migrate_pages_batch() at the same time that we are holding the notifier
> lock to mark the pages as accessed/dirty, but at this point we also want
> to grab the folio locks(s) to mark them as dirty, but if they are
> contended from notifier/migrate_pages_batch side then we deadlock since
> folio lock won't be dropped until we drop the notifier lock.
> 
> Fortunately the mark_page_accessed/dirty is not really needed in the
> first place it seems and should have already been done by hmm fault, so
> just remove it.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4765
> Fixes: 0a98219bcc96 ("drm/xe/hmm: Don't dereference struct page pointers without notifier lock")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/xe/xe_hmm.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
> index c3cc0fa105e8..57b71956ddf4 100644
> --- a/drivers/gpu/drm/xe/xe_hmm.c
> +++ b/drivers/gpu/drm/xe/xe_hmm.c
> @@ -19,29 +19,6 @@ static u64 xe_npages_in_range(unsigned long start, unsigned long end)
>  	return (end - start) >> PAGE_SHIFT;
>  }
>  
> -/**
> - * xe_mark_range_accessed() - mark a range is accessed, so core mm
> - * have such information for memory eviction or write back to
> - * hard disk
> - * @range: the range to mark
> - * @write: if write to this range, we mark pages in this range
> - * as dirty
> - */
> -static void xe_mark_range_accessed(struct hmm_range *range, bool write)
> -{
> -	struct page *page;
> -	u64 i, npages;
> -
> -	npages = xe_npages_in_range(range->start, range->end);
> -	for (i = 0; i < npages; i++) {
> -		page = hmm_pfn_to_page(range->hmm_pfns[i]);
> -		if (write)
> -			set_page_dirty_lock(page);
> -
> -		mark_page_accessed(page);
> -	}
> -}
> -
>  static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
>  		       struct hmm_range *range, struct rw_semaphore *notifier_sem)
>  {
> @@ -331,7 +308,6 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
>  	if (ret)
>  		goto out_unlock;
>  
> -	xe_mark_range_accessed(&hmm_range, write);
>  	userptr->sg = &userptr->sgt;
>  	xe_hmm_userptr_set_mapped(uvma);
>  	userptr->notifier_seq = hmm_range.notifier_seq;
> -- 
> 2.49.0
> 

