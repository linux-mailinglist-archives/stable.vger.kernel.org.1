Return-Path: <stable+bounces-87802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F709ABDB1
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 07:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12ED1F24766
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 05:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240FD13C8F0;
	Wed, 23 Oct 2024 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQJNFT2d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84080142903
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660464; cv=fail; b=MKQTjh19ZRfl90gSAiUPza84yzxdYCy984Dt4dYuziPioRkaKeJcIoJ6YkNZ1Kg5xVYINKeD2Ke3cgT5r96XJUjr8YXkXTZT+J+/fGYX+a5UiwS9zqZaQXeyyQVJsCYtgIGk/WeoWOWXOuUhCi9V+E3PIiICnHR7UsS0WNHBGyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660464; c=relaxed/simple;
	bh=Wqb+PO1YqMBm0e+vdygEmRG+mfpAi+4RFghm00Ra8Us=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mYH6uZwGAb4QQGuyA8uuboUpcfx+xFkq5rbagT8aMONfpH0wSSedvPlsE5ZPSNrXhdej/rTU3wE2kf2hzojcrGqblbpICpFH12olpKfD5pdcHo7BgBCLbKxCv9rJNkRmIuTbE3JR9msKM0ANkFDoXvb4NLRgQoJSH8VzqTH3ino=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQJNFT2d; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729660464; x=1761196464;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wqb+PO1YqMBm0e+vdygEmRG+mfpAi+4RFghm00Ra8Us=;
  b=DQJNFT2dgdoEH9JYXSM4MO2C8FBQcaC1Ui8BHXgDbH6CM/JUcAYLmTqQ
   kOIyfiFVHvRkfK4n/0jfM19tuDK44M8OHrerFKxTDuO9cjr43LdrM3KIy
   ldQlgvREbftW943jvkCosqjqO3x8Pq6Cj5ANSxfWHw8l9G9XpEvWtz4ci
   N+/MGwZtK1VHgkqXEHkMZeSsGQ+jzUf/xP9zg5mjwNjS6EbzzHhkb4bX1
   Y1yNKClQs1s5XOydkqlR7sfUzW02qIVv/x8RmOrY4xZO6/PySYbhJFnDa
   BIHX0Na58MbxXhavTBxClCBMxXn1cPGPLH1OwymXk1w340rRNAYC5ocVk
   g==;
X-CSE-ConnectionGUID: oeJyiIFQSpmDtwKas9wozQ==
X-CSE-MsgGUID: YpT01E4gRpWsv9PsBqmnXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29337704"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="29337704"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:14:23 -0700
X-CSE-ConnectionGUID: Js6h99avT16M/HVLzmV6EA==
X-CSE-MsgGUID: bF+92mzgSRK69jvStaCxug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="103373535"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 22:14:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 22:14:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 22:14:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 22:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP47oBey0bbT/PuP11j10xPMQCB3xaz3/2nfosNpvpMoEWTFIRFDldMylCD/tHT1EOcYravAV0ac2VlJ7k6OVZOROXuEX+gCDYbyW6PTviawR6lldY7msCf0LQeiTvyfEh50ZKvwTuxFr4hwpcgJjJlBX2hQXPg6a30hbXiylomM5Spdz0MLJgmm4NptW2aydbqV8HKiZ8ybGzJQVZW0hPFe2eI83StSc+mHGLbLKlUCVKRvpqYTVZg4FiXEz5aZ4EJ0YV1d+1KdgtqGgSR5CpJM0cuVQvS/PL9V3Iu2flc+xpf5ULJEiwBB3q4Jj+7/4RCCedhwGC3u/WJgaP6o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvAEPElwv9JmfKKIcqfvdL8J4nZTJm7A8sVdoQ93okc=;
 b=xOrYrWFpmZkBCJ1lhkc6MZBjAH6QvijS3V3RiN2jbkkTmep8a6q1RPJqzY2xVWZW2gVHkR2em5ueihBLUxvoFN8lTIFp/YD7NZx5dRmpi7RCmMOLhED/FL8P4prv7PsVgeyBV0pfu0tyTAC5vZlrxd6zM7rMns4uz+xI3Y1PMoEczTxUJsnXwhRQs/Kcyjr7JPnFFhA3DCX0jvaJToU/RKbhYb1cnkDO+aN6vg78rcM+8md0CUYdPvNVerpkRFzBjwbxQDXYohjgiy8FxKVoT5NEQEQJn/VeGKthL/XoQhbex4dqIvzThhoggwXSo6IFjULp7ZnFmtZyd14crp7Erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 05:14:19 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:14:19 +0000
Date: Wed, 23 Oct 2024 00:14:16 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <stable@vger.kernel.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: Request to include xe and i915 patches for 6.11.y
Message-ID: <u2siwbshu4yquvwg4jssffi4uvguqwl7rvkq3rx24w2jlxhy6q@7mqqqswo4itl>
References: <k5xojgkymtcgybwu5hbhvidgptxwhv4m4plbhdx26qzmlfryvn@mh4i7xvpx5gi>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <k5xojgkymtcgybwu5hbhvidgptxwhv4m4plbhdx26qzmlfryvn@mh4i7xvpx5gi>
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e7b93a-34b6-4dd6-4937-08dcf3218c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWjueXkKFnzhny5RqKcFjqo/B+dh9t28fXdn3PhmROcvYVvFLvMrR3GHee6C?=
 =?us-ascii?Q?wcGIydJlDbB9fgf6gJgs6pjZuGnruXYdUV4oVlDZqtG4zIWk+KU7iVDGXDq5?=
 =?us-ascii?Q?e9ubtHAsA+wwSYIbWAVSKOi/ofYlTAzPtctq3vl6Q9GhWdJgZLLkIjAkrbuK?=
 =?us-ascii?Q?rvdhCPV1DP3Kb7gjayOih5Zz8W+POx3lv3IMc16R5EWaj0B2HtyXKHOBhUZf?=
 =?us-ascii?Q?/GLY6Nd+FPYCdEPZKdipaUK+SR3GWfZZSICU8/nUKoZwKooCzdfVE4PHMsEJ?=
 =?us-ascii?Q?yJzz4WvixHYLriSiXnjunuNhLOEtUQ9nvrwY/ybz3OI/BChk/01RymIsGOWM?=
 =?us-ascii?Q?PAlW0Cu1Lp7LZyw2ObngEKzPLqXuEpNFITgrMyYxUnAOQUZGL7538Ir7icYp?=
 =?us-ascii?Q?ksMsIAnejD/SymnfuQ9AqnuFYnMYKvO7HfAhiP7BF+T6c4X0LKPagPa9cbUj?=
 =?us-ascii?Q?EB31puRau1SDG6Tiww+aoIBq0yiOBb6Vn0KzTlE0f9KDwgFsfDo3Qr3OZts5?=
 =?us-ascii?Q?LLlpGrsN1WemP1wO8pEXTSGu7sYYOszkLOKg9edYmwWeBZqK5pDgDfqWEnyk?=
 =?us-ascii?Q?h/1Hczxw5YXQVA1LlFbj33hL4Dgdj4PejSd3HaNgOljeq4pFVXgNks5w9kCm?=
 =?us-ascii?Q?XGZMLbWOhy6OGvO4jjVL9G8HL2l72Y807vAIWnHKQV5WBnAr+HbwQIrZD2pq?=
 =?us-ascii?Q?I6xWzG5FVoyV2KGBSq43LIOpLicb+WuEjB7yBNeSMsMByF3Rm4R6/URzvjz9?=
 =?us-ascii?Q?8Vk+JKoFpAD0p0GFwH4sm16QQSsbuKg1AHtSszr4rcY4KFl18AHUkN5OIq2C?=
 =?us-ascii?Q?Vic0E7HpujWDxMqHTuKqOAVlwr8mYR+GhpPRt6cnMAhWVuFQNPGgiiLO3a2y?=
 =?us-ascii?Q?UWN+iQp29ebS3uby5R6N3XocX/b4fWCVCxoV+A+9XLAUOvgCc9Tnq42/qwX6?=
 =?us-ascii?Q?/8WbVVARbfFwugbEfu7a1svfw4DQi3FAJl53hOawJay0TW5NmI402CtCfb28?=
 =?us-ascii?Q?IJzNfS9jth3VfaHaBst/icqhGXKHvEl5kwl4c+ex3iGJQOh3dUjZaW5wpqdI?=
 =?us-ascii?Q?GZlqxuwBN42MDezy0HuAnPPWMiKcDhTP5bfjFidT1PjQ7McspIlVVIjbUN93?=
 =?us-ascii?Q?R24/WHLPq24OJ8+uefkci0ELo3/sO1lxs0Xnu8+yxaBO1XRgXXl06BliYbzQ?=
 =?us-ascii?Q?oc1HfPgW0QTiCmk9chl4axL7SOE4THv7ql1GHi6svBkFbDcsSMkjECO0Dkdz?=
 =?us-ascii?Q?fU8QFPY5QXNUl1FEXWlFpe5D7QSV+5Og8iGUxCkp21U47fspAy/8xb0viZap?=
 =?us-ascii?Q?8wGPpkn9nnzNx0pNrYqwuNEQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZP6WjzHks6tI+2ha42aOLDYRLLmFSIpNJ4i2GeefSmRN6Xut6gq+MDvLqPa?=
 =?us-ascii?Q?Ptb63g2UFYxnuumJ/qt0BepBnkcvjyN/POLmS09oPgXd39/CHbMOPSeZwhR6?=
 =?us-ascii?Q?ZYO/12wyUKvUHsXi2sLj5GKjVxwq1UJ0IW66vTAJ0Vlhzl/FERps2Q/7SuBn?=
 =?us-ascii?Q?vjlS/h/PxlgJZ0tHEcCky6EIscf0aeP5dAA3w5unk/Em4x6G1OoiuxoR7NSW?=
 =?us-ascii?Q?1BfwV5haPiouAwJZOjZZitViuWotAU2SX9xHU3L3rX3Az4v9Fp0377Qn/+SZ?=
 =?us-ascii?Q?OsfetUYxqKWD9ZcDeax89RzGD+gWAcBdtOSnY0bzKS3uczogrRGJtb9sZMa/?=
 =?us-ascii?Q?onoIEuV+ZZyq/kJSCMRY9c+YuxG8XA0K0Uaahvgb7/7Usp5pzXtdxW8ovEM8?=
 =?us-ascii?Q?8IK0SvMz7H5ypP8humntamRtqKIKiTlMZT8y4ifZD8Y18HJtY4JZ8r17wFNL?=
 =?us-ascii?Q?0h4fYW+2AxyOVWGFgtvsnuK8k/07xP6KjLVkX1X20l/JlXVXUVFH1GYgRSFy?=
 =?us-ascii?Q?yZuFRXmqUyAfjmAWsUbRQNW+rgJAqyB5q3Y5WrGyT9qs0+JRtXpMJrJwmFaE?=
 =?us-ascii?Q?X1J82kF5Vge0wjhU7V6IXVR+haG8DGFFe7lEN9I/RwlzWh6UBf/Gjf932SYg?=
 =?us-ascii?Q?KDYihG2SlcxbBAh/h2DnBDEHlrEkoVq6O3gXTQV3j51ol6NU7C+6pLIyrZq2?=
 =?us-ascii?Q?pukeXfuwsAZyLUNjBUgWqJy6j4WKIARlVKCIDa38Csl9rfvQvf8SiHptxNo+?=
 =?us-ascii?Q?IRJaYsfuV1qpZMyTcNmybKWT3epLHhq6Cv7uo52MHhGV3leQO2DyUt3P+pqe?=
 =?us-ascii?Q?bE1aP+8t/aYNt7K6c6UMyy3DU2x7F+1HZMv0c/Q0jxcQgRZ8mANk/C5J3nn7?=
 =?us-ascii?Q?yK0N9dTbSCBolfGpEZiz6cybUZUERd/Sx8Y/SZm2ihGGVgSg0fA8rD/aqx24?=
 =?us-ascii?Q?3A/ASJopAMaEoYOAiFV1TU1l0HGWFD5JL5SIleLDLGQRWndEcAuNIDSGuqP7?=
 =?us-ascii?Q?nLeYiu18nYJcDiWlIs7VqZpuSEJJ/Xyy2tKtr8NbHGApWp4t5xaazvfp5qwb?=
 =?us-ascii?Q?OkWwW/qpTbWo0N++rflTzBjS6nD9fbqYmlNhQQ4tu15L7KJ6DOHuxhaLUN9E?=
 =?us-ascii?Q?ChTSC7xustYu2QwgIo7T2YPd0lCgZS3vBHEWKWNAiRuAZ7eB+Vqt6WEu6z4s?=
 =?us-ascii?Q?M8C648z2G+4SV4kVLBov19Opic86QbY/bMmpgFheCGv21rq7m7QMjboiMyYB?=
 =?us-ascii?Q?bWylwqWqWL1bHmytKLdJzd3T93SCDhLx6FdlE6ndONwO0B7x4PX+ceQAdse+?=
 =?us-ascii?Q?KGtc84NXY/w/0aeCznTgeSj6ADqkva8zFDTeNMpx20Nrn5zLyRsYvhs+7adm?=
 =?us-ascii?Q?u7EuANhLHs+BLbUQWJsQDyZhyOFkVSPDw2NwZEPzIoSUhd1s5SVySRB1Sw0Q?=
 =?us-ascii?Q?cIsyHdeFkH4dD8Hju2szBEwpHZXN8zWfukLynFmcPFzhkDd5Py4W/bq7euCW?=
 =?us-ascii?Q?oMPpOCMiUP+jbi2OYoG4Ho6z8wMlxR9Q1CzzRNjoijKBGFP48armelFwyNw6?=
 =?us-ascii?Q?rMAcCoDx62Rnpvat2FO+aUQA6Zm4dAiKoIt8qJDPo8W2rrZZI85wwAcLm82H?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e7b93a-34b6-4dd6-4937-08dcf3218c44
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:14:19.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2WwYaZ20Xg87HjSNUkmrKk/Mc8CxJFAafv8P0z4SYSTqHm9vEg7dcSY1bxcVVN7WnC2ZU2K1+toQwlS9jwEhlXtXwr93mlPwoU/IZZd+qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com

On Tue, Oct 22, 2024 at 04:39:32PM -0500, Lucas De Marchi wrote:
>Hi,
>
>I have tested 6.11.4 with these additional fixes for the xe and i915
>drivers:

just noticed 6.11.5 was released and rebased on that without
conflicts. To apply, the order below needs to be reversed.

Lucas De Marchi

>
>	f0ffa657e9f3913c7921cbd4d876343401f15f52
>	4551d60299b5ddc2655b6b365a4b92634e14e04f
>	ecabb5e6ce54711c28706fc794d77adb3ecd0605
>	2009e808bc3e0df6d4d83e2271bc25ae63a4ac05
>	e4ac526c440af8aa94d2bdfe6066339dd93b4db2
>	ab0d6ef864c5fa820e894ee1a07f861e63851664
>	7929ffce0f8b9c76cb5c2a67d1966beaed20ab61
>	da9a73b7b25eab574cb9c984fcce0b5e240bdd2c
>	014125c64d09e58e90dde49fbb57d802a13e2559
>	4cce34b3835b6f7dc52ee2da95c96b6364bb72e5
>	a8efd8ce280996fe29f2564f705e96e18da3fa62
>	f15e5587448989a55cf8b4feaad0df72ca3aa6a0
>	a9556637a23311dea96f27fa3c3e5bfba0b38ae4
>	c7085d08c7e53d9aef0cdd4b20798356f6f5d469
>	eb53e5b933b9ff315087305b3dc931af3067d19c
>	3e307d6c28e7bc7d94b5699d0ed7fe07df6db094
>	d34f4f058edf1235c103ca9c921dc54820d14d40
>	31b42af516afa1e184d1a9f9dd4096c54044269a
>	7fbad577c82c5dd6db7217855c26f51554e53d85
>	b2013783c4458a1fe8b25c0b249d2e878bcf6999
>	c55f79f317ab428ae6d005965bc07e37496f209f
>	9fc97277eb2d17492de636b68cf7d2f5c4f15c1b
>
>I have them applied locally and could submit that if preferred, but
>there were no conflicts (since it also brings some additional patches as
>required for fixes to apply), so it should be trivial.
>
>All of these patches are already in upstream.  Some of them are brought
>as dependency. The ones mentioning "performance changes" are knobs to
>follow the hw spec and could be considered as fixes too.  These patches
>are also enabled downstream in Ubuntu 24.10 in order to allow the new
>Lunar Lake and Battlemage to work correctly. They have more patches not
>included here, but I may follow up with more depending on the acceptance
>of these patches.
>
>thanks
>Lucas De Marchi

