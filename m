Return-Path: <stable+bounces-139088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05936AA4123
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D514A927CFF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B41CAA92;
	Wed, 30 Apr 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAsmwsOA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2312111
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981205; cv=fail; b=Y7byo4O4UNQAA7bMeUQgS+oGPQO84MSPGYjUDLVFcq71WMZLhGIlv2/3SpH3VGpU7hnBjmUwHqE3Vq1Tw0fToKE17XwMEbYFfgQy4DooXsasLtV+pTMg9IQLl1gyvTprTrb5XGBHECib0Bh5IB6+W3Hq9OXQ+RKhxpiRZv36cAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981205; c=relaxed/simple;
	bh=neA3GAUXU5TAXZZbmQaQNXeYHglxN4uLiLMbpV/grMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYN4SlqFlRtImnLoCIu5/4RmJHt9ejbbyXAsM+i5Lvi+8RdNq5bGVYCInXteCwieYJYKhN/NA3KJTdLYLS8H45jtLPkBvzJo/EWFd+XV7ydk3EcJTx1xdLvW326Mmf/tBvBGkY1z0RFNrUoeVyTU8fIWbiYN/tRBAVwxqev26QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAsmwsOA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745981204; x=1777517204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=neA3GAUXU5TAXZZbmQaQNXeYHglxN4uLiLMbpV/grMQ=;
  b=ZAsmwsOArxu5qJtrUZutT4LxiS2bFW4nF5rSrVGTgI976HleyQ0a73Bx
   Qub6+dW7NANm2dE0VfFPSS42V1RSWYJXN2GKWKXsd2bZgVq3EY0LbII0H
   HUY4ZmGOvyuO5e6J7B/luRXqwMaXMVE4zq39QIu9XDpG7a//x53Fi9enb
   spzc9G9k9PnC8iM76ZDPjfkeo1geTOcLjX+WmZTZe7C7ub3wH7psFN+72
   8FUzujkUexZlK/sND3fR+bw7RU6hWjuFs4rceTBiCfP+GobPBQL1LKMaK
   DyyGec7czsWJzWXjFr5Nk7Oqz/s2pWIOe0700cnT0wUPFua3BaC01sZ11
   A==;
X-CSE-ConnectionGUID: kOCd8kjQQimtrec1jQD6oA==
X-CSE-MsgGUID: wxCpDd4OQo69FTxGJ2EKOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47764041"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47764041"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:46:42 -0700
X-CSE-ConnectionGUID: OUD/yx6kTiS0Ci8huC0bbg==
X-CSE-MsgGUID: OGcx7oH6ThaJF/s0E3fLLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="133904044"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:46:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 19:46:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 19:46:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 19:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onH1cg84iRX2uYu5h775NOtbWHcbWbIfGmdw9bXGZmsXGEdwn67ZdQnJP07SWIV/+DkNv8tvzZXA3lrplcnhKMmCzo2uUVsc2DIogmx5BukLmyHGE714yjIOfrbgI9N4uUpkY6ceW1QLlTb57gQJ0xwQF3usnEdQLx/deJT2WQrxXFjukPXEDIiqUFrsemPAvLQasJZDSmWOLKJMdfY712O68AocTIX9uQr2i+aztdnpDAXrNreRmPFADr0egRa8OlPQjUGL46O7Z91x3TPQQqMc5zxJtrpn7Sxmm43RkN+p2WHcSnnfCGRDca7OpKxtwAmR0CpnffLSpEOJg6NQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRwFj67e4FMEXVL6ZxWENlq0QppoY3rjH2qWOYO1M7Q=;
 b=Tv1ZV/45wk1Cx8n/eEU0kfCYJ1RrffbeN1qGngw9H6aiHsQy1fllfRXM/2c78pzrAznJiwKevEzMg+blzYuZsaiw5wJjgMXBXH+hP7Dz0CmCPpNIS6RXhgWtIknX8/D82aPMR+54U/uowlYNsorb3fi8cJ+kPyIpfDh7LYHz+yg2NqxguLaUt3YuMSNz98wXCIU8IpKaarci8stygAAfme/HF4knvgeGF/GoX2baWHomSzWtaVsxTpnWvC9QnbI5ZZLdebe9NTgr4covxdbVOY7844Efgtuqg7vf0HdGhcW8WzUGBK4nLTQteSrRJ101W93BzC/MU/i1C06FbtpTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 02:46:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 02:46:27 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Kirill Shutemov
	<kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Vishal
 Annapurve" <vannapurve@google.com>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH v5] x86/devmem: Remove duplicate range_is_allowed() definition
Date: Tue, 29 Apr 2025 19:46:21 -0700
Message-ID: <20250430024622.1134277-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430024622.1134277-1-dan.j.williams@intel.com>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da6197d-c00c-45ca-0ab5-08dd8791344e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G5AnhLawgHCEjfgQJRp24Cw7el+jJIyNCUXAlulSQ/uZxqAfQvT+zol6XciB?=
 =?us-ascii?Q?B9e5Z5g3Xo5rrun0Yx1XOvgP/ONs8P4Rr7A5eHt+DRHQpVRuXmdjozPMJC+j?=
 =?us-ascii?Q?UeMaR/Q25+eZRyfzT1MqImaAjqmAVCtN8z4Lm6p3HxYU4PP5ZCVBGl4edWj0?=
 =?us-ascii?Q?/yWo6dund8mNoBvhzfx/YlwI4Rc+ZxJeTWFKl+hjO9ylcrBE3VpwzczCvwT2?=
 =?us-ascii?Q?7YEQzM5AVuaGqa3OhDps8uAwhrAkCE2Y4nNd+swfSkxhrUbk29rnkiMBsUmN?=
 =?us-ascii?Q?ndWVjrsYv13kJWn1adgfAlbm+x9WXeYRWlAZ74MubrhpvPdLtZNlOKEgnxSX?=
 =?us-ascii?Q?ZCGwQ5gN18klNfPqPWIe3FViD+Imy7TNXJqjkgViA2Iwo/Zq5ZJ1KN3FpUta?=
 =?us-ascii?Q?eZu7AiVWzM2aSVsmr3oPPAagFjpKRttgInJ3GQksxzhUo3qqhXsoVTts+TD3?=
 =?us-ascii?Q?m/mtF4x1d4jlRqlzMOibxZ4Vr+wLN+FIWpc2ZEKowEhRR7cU8SOb9KOmKao+?=
 =?us-ascii?Q?IfQHutDgXDkdfGV9w5VlU/2EkI1nOwR1lRf/6g/QHByyKTS4HysldhCI/+eQ?=
 =?us-ascii?Q?OIqRdZ46d9+vcQc7SBD/awwZ+VaMPFd+4jZ5mfH2b0dibw3Msedgy1It9nn0?=
 =?us-ascii?Q?sW50OhOQytJGYuwvzNi78IR3tSyNgL3BgkKBqz540BXHaFD3jLHdFmgMmra1?=
 =?us-ascii?Q?u4q5RkHGK4UWpRq1Jqq5OEJRyeu8t+RB8W59H/SszesLKDl2++9vl1xcPA/B?=
 =?us-ascii?Q?t+g/U+Bf+jMZrpb5LZKlNbqDJPFhMRoOFi3/YXP1oLGPeb3ZlfEYKQ42Bh3C?=
 =?us-ascii?Q?27eiEgV7npxLHPW9cKbqLiACCuUgCf8J2FeIohe7Q2E2eTLEyqDhj9JaEXzM?=
 =?us-ascii?Q?7//9Tl+6lOG2+aGm1I31jEz8QMcJnSArhf+w+CsZ3+sPkFu5MZxpEH81NRAP?=
 =?us-ascii?Q?TYR1bbnVeRwT74Ezq66nR23vJwkVjBUSdm6Gtu+iYCznDJbfNqam2ZeAJQTF?=
 =?us-ascii?Q?YNT/J6b3+xjtgXGYMXXOFgJMhLM1gA0fKf1qs2MGG8evPZ9+qVdGaBSCWiCb?=
 =?us-ascii?Q?TZfrqpvg+EgTP1FjBR24zSXYD5lMfSUALJPzciAQAhupsnWIyXwjSi6fTrAf?=
 =?us-ascii?Q?qFbBtrNZbBwn9tgR+w6OiKGAenCa3XOkkk8i3zlILNpsvW8wCzjdhJ0MYQ9m?=
 =?us-ascii?Q?xYf/7GpfjBPde5hbJhfpWfkbH0dVQIVg/lrblaE4rTeWzcauQcWdFvS1IX03?=
 =?us-ascii?Q?A6uXRx5SeOzzyOxwRFqA+RSN22o768JNild5oOzk5LiiO37iOXRRJqCJgZgg?=
 =?us-ascii?Q?FoPqGhPSF+BR2wayl3z7T4WwTmNWPeElbJGM4kF/iYSio1FPvD/Ihj+C0omm?=
 =?us-ascii?Q?JFCLznQ9kbWuMqPh/eXBCbzJWqUk+TL0HLjD27L/QD0NbZXAMN9yf8IXVYYp?=
 =?us-ascii?Q?vQbL/lCccpE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zln6Uxo399igYQI7Rkx8unIt7qCo45y16xez4XNWYN+JjXFMvOjsOHEYcLtI?=
 =?us-ascii?Q?/UrOQpP1SDEbKE1B1XnYZ90zLzu7w55thYjNlS83HhNONtojvSmOtxcgWzU+?=
 =?us-ascii?Q?dioY83PKkFGvYI+FXw9bE1lpgecyEjZTyp1n4xP8AskLwytCWn21v2Pr5oEU?=
 =?us-ascii?Q?+LowPhk2uaQSl8E/Ry4jq0gwWN5Wur+IQ1TO/b+ssnHfgFZBMa8B4nuPHVt7?=
 =?us-ascii?Q?mfJantgk8MfjdrVfiN+VeYz73x9bsv/9Ww9SAPlZBCQn+bEarcilozhUbhAU?=
 =?us-ascii?Q?qNxqeAuVEYiCaHGOtcNLHxiO4d/TgkYk7HB9a1RMkvqu/gE9r9I0TZW+XA79?=
 =?us-ascii?Q?0qokMH+1OAV9Mu4Bi4rkH43TCgoQ0qJqPK54xzmZEqspDFXSUvUMvjAC54aB?=
 =?us-ascii?Q?9qoIgka/X7uC+1p3Ru8CwO7A+M+12yPnYzmhdzVMWygYRl0VkfkPfeK1fXUa?=
 =?us-ascii?Q?5+5Ip2bcpZ5MRDs4bR+lHd4XCrg1ATBfqjHXJMxV9bkHczZA2GBuxfqong72?=
 =?us-ascii?Q?4bTmdFkCfeWK8s5x33Y/PncAgoDpIMpJ/X3ulQItcGmGWqx/mK/bLqUFsI0t?=
 =?us-ascii?Q?m675dIpedG12amWtzJ6umocDZ7jS1oPatDMSYougUvBiPI4LH34rc7qkKBgP?=
 =?us-ascii?Q?HiPaLSTcC8UVMW0wIGAxmJMLVof236TbGT6OkXGC84MJanV8y38vLPT0L/r0?=
 =?us-ascii?Q?u3q7FbneKgFG4kzQUF3V05W1+hyMXSjNLguClXofbLEm14gqn2Pt1S2NYj0I?=
 =?us-ascii?Q?cmGXrc2KuF+iMsAXAFHYf4jj+gqSE+AXn//axKxrzOhimd9y9eWYdoRXV9dS?=
 =?us-ascii?Q?FdEI32589SvdlvbSHQ69azIw2JED+Ta34+kTVGHqIc2Im2rpFtzycbm2b0JH?=
 =?us-ascii?Q?Nv/RnekZJtY9PT7TkwEDCAFRfAUD22b1ttG4dFfCjmsHUBSBUlQJWseA4fty?=
 =?us-ascii?Q?rmqnZ8xjgZSU7f3X4ZBEOGjZNx2KMDN1ssv9Xk5J8va4M7GiLKIljhUlniGC?=
 =?us-ascii?Q?7hv+59gxqh8eZytwyuy0WbzjC7sTKZpbSIHsefOGdfcFUJZKxnIMFkSkhe7r?=
 =?us-ascii?Q?Y6j8f+u6s//nEnvrVE26BzxMuJUrHnRZz7WoNMSghj2pD5nI8G9ErefL9Ged?=
 =?us-ascii?Q?OHBkRo5PuqpGwHxrIsnpofU3BsCcNKK7lHDPBc/oe3Id3ID5uJxByok1K2zQ?=
 =?us-ascii?Q?4oJ4i+LSXse+Uh2z0EKMFG9AtHEjAedsZAC3hMoVQoL15hv01+dqJKPThqP+?=
 =?us-ascii?Q?2iGKntagozXOdxCFpju23hHP037lzDzrmjxkYNZxvUoa9N1MZcCrPyC8070R?=
 =?us-ascii?Q?gSM9TMvThAsCq/HrJBgIl4yWhWFgmi45X0Dy5JI39W6gzTuND0z8zxMkpq7x?=
 =?us-ascii?Q?yi0L1gUNOXYcvl0ct4EwP9VujRbnbeG/rW6a62/G4pkhWryr7OczJDT5bxhJ?=
 =?us-ascii?Q?de9pDf4Df5CrA6Nzzj1iZKafE9W4Xc/xGlIFMuCyDzQSokusAqshA/n1KCsV?=
 =?us-ascii?Q?+VQrZcRrspLbwZKuKqaFTg4u0QYFTl2jC31o6vZn35xZ86UXpZi0CWtvYmqn?=
 =?us-ascii?Q?Ag90xevdEB3DyK0GdQUzK3lZn7P7AH3woY67mnjVgu3xBIOft5iihjJa7MTC?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da6197d-c00c-45ca-0ab5-08dd8791344e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:46:27.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORkH7wUZmTx3V2sJlIyFdW23LBdjuWUMMrGforJDJNMOmCIhWeeCP48KZqC6Y99Z4kGnZG7jgDs6OI1RS7WGGwSHdSnlEl1ldFb57nasDTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

17 years ago, Venki suggested [1] "A future improvement would be to
avoid the range_is_allowed duplication".

The only thing preventing a common implementation is that
phys_mem_access_prot_allowed() expects the range check to exit
immediately when PAT is disabled [2]. I.e. there is no cache conflict to
manage in that case. This cleanup was noticed on the path to
considering changing range_is_allowed() policy to blanket deny /dev/mem
for private (confidential computing) memory.

Note, however that phys_mem_access_prot_allowed() has long since stopped
being relevant for managing cache-type validation due to [3], and [4].

Commit 0124cecfc85a ("x86, PAT: disable /dev/mem mmap RAM with PAT") [1]
Commit 9e41bff2708e ("x86: fix /dev/mem mmap breakage when PAT is disabled") [2]
Commit 1886297ce0c8 ("x86/mm/pat: Fix BUG_ON() in mmap_mem() on QEMU/i386") [3]
Commit 0c3c8a18361a ("x86, PAT: Remove duplicate memtype reserve in devmem mmap") [4]

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Naveen N Rao" <naveen@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/pat/memtype.c | 31 ++++---------------------------
 drivers/char/mem.c        | 18 ------------------
 include/linux/io.h        | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc61158..c97b6598f187 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/pfn_t.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/fs.h>
@@ -773,38 +774,14 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	return vma_prot;
 }
 
-#ifdef CONFIG_STRICT_DEVMEM
-/* This check is done in drivers/char/mem.c in case of STRICT_DEVMEM */
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
-}
-#else
-/* This check is needed to avoid cache aliasing when PAT is enabled */
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	u64 from = ((u64)pfn) << PAGE_SHIFT;
-	u64 to = from + size;
-	u64 cursor = from;
-
-	if (!pat_enabled())
-		return 1;
-
-	while (cursor < to) {
-		if (!devmem_is_allowed(pfn))
-			return 0;
-		cursor += PAGE_SIZE;
-		pfn++;
-	}
-	return 1;
-}
-#endif /* CONFIG_STRICT_DEVMEM */
-
 int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t *vma_prot)
 {
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_WB;
 
+	if (!pat_enabled())
+		return 1;
+
 	if (!range_is_allowed(pfn, size))
 		return 0;
 
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 169eed162a7f..48839958b0b1 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -61,29 +61,11 @@ static inline int page_is_allowed(unsigned long pfn)
 {
 	return devmem_is_allowed(pfn);
 }
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	u64 from = ((u64)pfn) << PAGE_SHIFT;
-	u64 to = from + size;
-	u64 cursor = from;
-
-	while (cursor < to) {
-		if (!devmem_is_allowed(pfn))
-			return 0;
-		cursor += PAGE_SIZE;
-		pfn++;
-	}
-	return 1;
-}
 #else
 static inline int page_is_allowed(unsigned long pfn)
 {
 	return 1;
 }
-static inline int range_is_allowed(unsigned long pfn, unsigned long size)
-{
-	return 1;
-}
 #endif
 
 static inline bool should_stop_iteration(void)
diff --git a/include/linux/io.h b/include/linux/io.h
index 6a6bc4d46d0a..0642c7ee41db 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -183,4 +183,25 @@ static inline void arch_io_free_memtype_wc(resource_size_t base,
 int devm_arch_io_reserve_memtype_wc(struct device *dev, resource_size_t start,
 				    resource_size_t size);
 
+#ifdef CONFIG_STRICT_DEVMEM
+static inline int range_is_allowed(unsigned long pfn, unsigned long size)
+{
+	u64 from = ((u64)pfn) << PAGE_SHIFT;
+	u64 to = from + size;
+	u64 cursor = from;
+
+	while (cursor < to) {
+		if (!devmem_is_allowed(pfn))
+			return 0;
+		cursor += PAGE_SIZE;
+		pfn++;
+	}
+	return 1;
+}
+#else
+static inline int range_is_allowed(unsigned long pfn, unsigned long size)
+{
+	return 1;
+}
+#endif
 #endif /* _LINUX_IO_H */
-- 
2.49.0


