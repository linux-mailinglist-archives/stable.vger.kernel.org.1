Return-Path: <stable+bounces-256784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEicCQ4CGmqQ0ggAu9opvQ
	(envelope-from <stable+bounces-256784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:15:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E81608CE6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0426F303524E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFF421F04;
	Fri, 29 May 2026 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW6IQVZ4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAD3DD50D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089271; cv=fail; b=VPWze15DlRGWGzr9J10ThdO1xj0M//o7uyoe4Mfmqaz1GlvYi0lZf6LSx0u27T3tWP70qJ+KYNJGW6jcute5rZWIyKt4yCTvxJrd0zbsO+er0zg4AFTEzTtAAvpCIpE1rAx27z+QCBNKgGVl4RrU4a9wHjQ5Rm3BryGgx4AG4/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089271; c=relaxed/simple;
	bh=Ckp2ieLkASXs7s5UJmdjyxwrovZ6gi/NxDoWdI/Ibr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYgff2vPZZdD5Lx6Q5BKpmEkgVIaPnJrBGlFGYJjrEmt4lOfpsLLic3aauHt5Hqgd1s85HDpsZozcOxs9heHDsUHVT2FMKeJuQL5hkCFOoXVqW7RyS2C1XsuBvSxyYZ5145DtiwsvXYLkXpOmOSwDLgGnvAotFMd4LI5xZOPvOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MW6IQVZ4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780089270; x=1811625270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ckp2ieLkASXs7s5UJmdjyxwrovZ6gi/NxDoWdI/Ibr4=;
  b=MW6IQVZ4qGwwXhtW/2MmFFn2gKMNIxhTdx/K3PYi/pJ9UnCVvEV3LiBi
   jxy0Nxj8P/Wg2NPrEkw6yz9N2NnH5Luj96brJIvkLWt7rb2FZib0MiioB
   Xqc1Dd8WM2GnrnHWjfWCwuDvjcCRDa5H1OkR56jG/zByVDrkyPcaYbtnJ
   gbBuY2wfSeyzLnU8iWWudw9kCVKK95BaxtUtfJD+KK79Z+Hp4Y3TXo97s
   sPeEb2uxgD9+kqlCVMiFhkG6wffoV2n96ZlIcshzSJ0EgP9RKXL847faH
   XKFq6tb6S7gYxfW7XAAGp9pDvI+Rs4ajJlnTbNoRyVwVyyj/7T7COeiBM
   Q==;
X-CSE-ConnectionGUID: oUeggfrsT7uMzYpHncNxHA==
X-CSE-MsgGUID: lMd+kjLBSE+ghiWvHZCpbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="68481560"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="68481560"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 14:14:29 -0700
X-CSE-ConnectionGUID: 89mYssViR3KcyiAWjZ2MlA==
X-CSE-MsgGUID: jW+U5EB8Rt6MsOthdeAlAg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 14:14:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 14:14:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 14:14:28 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 14:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig89Rs55peFDoRLJQIgdmlG96ltIaCr9FsWzdiTAlrzGBzOG5Fbnt+KC+Oy4kutK/fPRYiF6UDEF8f6rPM9pWhbnWPD+NPjTIJD87gOZqbOWO6h7W0CoKuzI1iXAGh/KZF02X2+cCsfng0nqn2Rg+igdR9nikiCmSG5J290ZeLQqW6TcdGbgFMgulL7puI0Wg4FpuISeh/F1AKBmbcPn8gqEAk8CkhqQP5yl3F6w48fvPHLnJZzfbYVdG843fy/yE1noabUhBKUOxMKG+6HhLaynecZZ6v/n1ZoR4gnfm1B2EhfgRcd2A+DWfvQNMKG6zP88QRIJJVGm5+qKPzsr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQz72PiL6KXobSsuk9ToglfI9BxCGvB7l1uhEgLjRjI=;
 b=cO/GBdM6BArHRhpjVxp5tD1LfrqIIYxi3DtE5rcjKxlKAWIDSEKYeBYVAo4sdxXJSr5KmczUA3DjufakPuyDb8Zx3vyzaAsbvaHmXOmT/+z7GHy7AgHCCWII3ZeJju035fTj98riXKQX8S6BBWrFeiYEpBGdtsbP7b/C99Gy/UJ9XRhjT+4xoesKEbnXke6oKLKi+p2c5Gnbs/fcEXLYBi6Ju2pgOE8NJ1uScEBq/m1OEgZJAOf7F/MIS52Bv7pBcev02mgC/e/r1XzGLpULzY5Pz4X2e7ROxBrvSroGiBECvEEx2A8Kti+DVGQ2babeP4zdbZrkBKXFTEoMdaxWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 21:14:24 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 21:14:24 +0000
Date: Fri, 29 May 2026 17:14:19 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Julia Filipchuk
	<julia.filipchuk@intel.com>, Matt Roper <matthew.d.roper@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 3/6] Revert "drm/xe/nvls: Define GuC firmware for NVL-S"
Message-ID: <ahoBq8-lLb9HeTXG@intel.com>
References: <20260529193558.185436-8-daniele.ceraolospurio@intel.com>
 <20260529193558.185436-11-daniele.ceraolospurio@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529193558.185436-11-daniele.ceraolospurio@intel.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|MN2PR11MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 90eda449-ebeb-48f1-52d8-08debdc74256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: a2JipSNQLLZ6jRmh8EzF95sB4W+eemOo0ggvDsJTCXbIPHJIFcSJ/L0GQC7pX2EkzEgJz/YAtjNgvfRkRxaGEbC6kdt0eQUhc/TWe+H8EFODpyQLbB7kSkkxvKJzJWP+X2lloZNmp0pOk0wOENXfj4XI+BKshKbZN4VoPXTCWttrPMS+gpe57xwgkNI+PdKTp+EjmguvXDh3wq3oWOIxF8CaQf8lhVtf9S/0FYMDObcp1i3G4GSQHUrHNNlJJglLFtUQ2h0ysqI/TcQDxINdM1GLTmKh6TzTxrFQGEE81eGdVqE/qBwfVtIEuX+UWhGDvrBN0lSFC+vy89wc+UJ8/Bah1sA812BPKBcQ/VZd6oghL33L9gKcRWeN8UwUODGrUIz/xMp8EOpXpIsIfRikvaOidmaZSNBkU9GBMo+juhdlfx5sN4qaoCkPKBRqOMsxbxFFzlTAfzOKaqop+CS/ZB0PAs8OpBbmg/+p7rqdp6VZxb+8HDyxMUCp483zUsrrLr65K05Qwxk0ETnox2+Zf/IgHOGZ67cbTDE0gusngwFj76QF7Wik0VV59Tby3v6BUmULemGDtGdZEK4QT7QN6ZfrJnwV+SkyNo0oNeNI/3P6hDt2VaAsmAqyRizPJJdnb59FNjBrCS2I27dwsMw/dfPYpeqLUzufK/37OceHyjB1iBLWuUGmLufqaSu6VpmS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GeuUNtF7Q4tDcaq+lpEaGtFhpwLVinwFheb/r8zj0z2N4IyoNUVAjKAJcmAu?=
 =?us-ascii?Q?sEmFHgyTQGMUQfwxKUxO2EkQwezusE9ZKUONFud4uum4Otzvlygmp9r07z9s?=
 =?us-ascii?Q?waCsxuAyh9kmz1ICnCrsLvbQkAIiVlfxOjrsYm1CpnLXfX5MnqJrnnYCs3VW?=
 =?us-ascii?Q?1RaGe/UrSed6cMuJV1Cko2DIvhsCfboh2/ViFr/G+neBgxoY5p0FHLkAYL3G?=
 =?us-ascii?Q?7OfiPQtmblnseQYP4QVPiMXSbsEISXqfTZlVO3x7nNnMnOVV2ax/nOOspQNn?=
 =?us-ascii?Q?IEkMWLaaxMv6yOnnzUxma/tb9/jDFaQo6UAJuelVsreRtmm/KVVtswNzf16b?=
 =?us-ascii?Q?5TEhVSopSl3P31NpIN0jpVcmXN+kyWSC72HGkbUl2KOVxhIJ904HyHfYJ9tv?=
 =?us-ascii?Q?gmIndmIyiI4uhJag1O0do6s/bqN2quEXxj4xVaThbjjRkMPE2GXzDD3x6B3d?=
 =?us-ascii?Q?DMgvJTXD9MvDl8kAH7IxiJzZTfIL6AmY3R+Em5kKI9Jx1ZtPwoVgiv73IHuI?=
 =?us-ascii?Q?c6RUR/jn7o1CDYBYB2dmWkG91Yqjp9xcNMTwLOuuCx8tM+VEK5tyI8Lv8JQB?=
 =?us-ascii?Q?ElHn7vlM64w8rdKPyvoEzBlRUy1D66jKkrtpM1QD5ouFgkgG0oFtOsoAb5Gf?=
 =?us-ascii?Q?McT4c9dGUo4o2PxXFxzGMnw9edPjiN8hMgo6dblTuBnW+Fnzm1NfIGNsRrNQ?=
 =?us-ascii?Q?5DxkChLbz7WsLcXriXchcE1C0uzIOFlX8vxQbwcX2YqYyZs+Br1eMduyO2VE?=
 =?us-ascii?Q?rWlwJa1SSscRdIndUZZEt32z3iCHDjj3gnPO+LY5TDtY8PPklryD6t9sr/+A?=
 =?us-ascii?Q?R1A7fSMT8xaembxhemBVgI1CuiG1oJldKw2t5a/66MrE5w28wyNRMkAPJYFa?=
 =?us-ascii?Q?9SD9TIV/5LnbEpz47f9GN2pK+0DEzYwqGmpBMtBErfOWkPbGgT/TNDRkmA5H?=
 =?us-ascii?Q?8bXvaBNnAqYTWDMNNp9j2ABl252upYXtweAxmxMZhkXBfcvJLwOen6eOXffT?=
 =?us-ascii?Q?xZm3pz1FxaF3NgbTimGhEs8m0VvQ/TN/P22wnIDcSiDRlR6F6Q2XHLXuiLr4?=
 =?us-ascii?Q?DZVqjgXx7UBM1ZHoDDKTfTutsVOs4R8r1Q8GwJCL6R5HkcJgGCnWFtY7nigh?=
 =?us-ascii?Q?UL15PVb4HKF95jEuANTP9FPv4O53KcJiTVL9YGl/1fuIgFPugY45HfMwE2cI?=
 =?us-ascii?Q?n6TVjaAgFEGC4LaAVZ2Q/2h6yVgKS4avLYGGvWbptbodRiWSPowCwJfbghfi?=
 =?us-ascii?Q?gozmlYMNNkSC1kGPtTxXrB6Y9hZ4V9cDtaVdJU7YreXHkW3oWdTJrA4+8vOb?=
 =?us-ascii?Q?53chlu8eMfOQpUTn/D5ZI4jtxp62oTWgPzNArf3DdYV0OyMvKyf1w232s1hA?=
 =?us-ascii?Q?oJHbY6PKr5/aeurXbeHKd1NRxehPAP/KaBFDaiB3t2LL4MTExZCPPfF1Pdn1?=
 =?us-ascii?Q?HwXwsVpc9Azxfq23siUg5kj8R3cE/CFjSXScWfTksj6hZIkEXlOCYkFxram0?=
 =?us-ascii?Q?26U2keGdkqTcFY9WFf35vmKqGQQnrDa4WEYUdBxSQmIpUlq0awxssxltHUKd?=
 =?us-ascii?Q?+G8HhbwTC68V/BSoK7YX1c3v4pyny6LosXXrFbxotf0qUG7CcTwF40QqhKJS?=
 =?us-ascii?Q?9khJAAsdeXAxpL10VznOExTQ7hX+nQQ194E8c0IbsQqocPchhvJAGpTfx/JC?=
 =?us-ascii?Q?bEwN6w7QS0n9ONuqXdya4fAm5iXjnMtwAyW5fGI1JCNMZmhBArJNfNZaLlx4?=
 =?us-ascii?Q?ZeAfL3KjFg=3D=3D?=
X-Exchange-RoutingPolicyChecked: CPjr1hkJLKli25RvMlJSW6Fx+FGqVqT1o53e4TIFw2N2MSVgE9K+ASUeBEXbcLlEv3S4xicuwFJynjYFHnbtFBfDKAaxrFNU8t1o9HoQUJ3tNGdEvshq1LdAHeShSmucr8XRm4jBNa4WJST/BSN/oOX2Di7+I4jkZlFQeiKoLeRt4hb0R0gg2eDE1V8eO7M+25mdYlEW4Fp+0YsKImAmY+ztqJHkqXF1Mkhb9UK+HWDgMYngHTKL2TfehtSSNMwebumJXYKD0OyEYcrbuRrV4HRa6FJfRdZYFKkE0z+DYut528a3kQ2Wi/2BY+i8S7Bz9wGflwjw/S+BGdoP7CBR0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eda449-ebeb-48f1-52d8-08debdc74256
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 21:14:24.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytl8xsGK/dj7wqNtuafVFT45ppidBV4iyC1SFsXdscoDejPR320O1rNy+hhNKRcwbcX19oIz3tywVXj/zW+Acg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rodrigo.vivi@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 70E81608CE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 12:36:02PM -0700, Daniele Ceraolo Spurio wrote:
> This reverts commit 4e88de313ff4d1c67b644b1f39f9fb4089711b71.
> 
> The early GuC FW definition meant for our CI branch was accidentally
> merged to the drm-xe-next branch instead. This GuC FW will never be
> released to linux-firmware, so we do not want the definition to be
> available in the mainline Linux codebase.
> 
> Fixes: 4e88de313ff4 ("drm/xe/nvls: Define GuC firmware for NVL-S")
> Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Cc: Julia Filipchuk <julia.filipchuk@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: <stable@vger.kernel.org> # v7.0+

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Thanks for that and sorry for the accidental miss-merge!

> ---
>  drivers/gpu/drm/xe/xe_uc_fw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_uc_fw.c b/drivers/gpu/drm/xe/xe_uc_fw.c
> index 70bccbc1af82..498c89452779 100644
> --- a/drivers/gpu/drm/xe/xe_uc_fw.c
> +++ b/drivers/gpu/drm/xe/xe_uc_fw.c
> @@ -115,7 +115,6 @@ struct fw_blobs_by_type {
>  #define XE_GT_TYPE_ANY XE_GT_TYPE_UNINITIALIZED
>  
>  #define XE_GUC_FIRMWARE_DEFS(fw_def, mmp_ver, major_ver)					\
> -	fw_def(NOVALAKE_S,	GT_TYPE_ANY,	mmp_ver(xe,	guc,	nvl,	70, 55, 4))	\
>  	fw_def(PANTHERLAKE,	GT_TYPE_ANY,	major_ver(xe,	guc,	ptl,	70, 54, 0))	\
>  	fw_def(BATTLEMAGE,	GT_TYPE_ANY,	major_ver(xe,	guc,	bmg,	70, 54, 0))	\
>  	fw_def(LUNARLAKE,	GT_TYPE_ANY,	major_ver(xe,	guc,	lnl,	70, 53, 0))	\
> -- 
> 2.43.0
> 

