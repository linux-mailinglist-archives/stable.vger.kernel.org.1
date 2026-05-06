Return-Path: <stable+bounces-244443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAC4GDqX+2ladAMAu9opvQ
	(envelope-from <stable+bounces-244443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 21:32:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E86444DFCC5
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 21:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D399C3007528
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8E31AAAA;
	Wed,  6 May 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUUVt19M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638C2E762C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095927; cv=fail; b=sLOZCyC6ASXQdJteqA7CSY3gvTz1D3rdy7vFieVx24KoF1bf+c4juQd1p7K1uilPPhBGKEU1eNrOdAh4cchYoqxwaMZ/16/VPIPJn0AEfGxLw2/Zr8NzduJLKOF39jpljoP7qCYxMDKhkSI531mc1rQGqqeztOlF+FSlAd5WMLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095927; c=relaxed/simple;
	bh=SD2On92BypFRfHqsXH+cGSrlauQqB8Ys/ls0T+hjZLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j2Tcywz9odxXqcXDE1V5Ld2sFjH45Whef4lz6DHSEpCYQDxLuowBOZ/p5wVhjPZQnmD398pXPDMEFKFCugxLjykOhciSXL2QsP5BwFQiSF3mmerv7RUtaigImn5t7gJrlv9Kj3v/saO+IqSzzuGZo2pKQvFtNWpIFyJUqMDW10s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUUVt19M; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778095926; x=1809631926;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SD2On92BypFRfHqsXH+cGSrlauQqB8Ys/ls0T+hjZLA=;
  b=bUUVt19MmDjhB2eVby/m0BVDaH9hTPSsB4YkhahePD1WxNwlXLVErewE
   0MJRt9BE0YEL2PQwO/0xslv3IHcPw5ullFMNNYAwlqBjdzWG6EVlt0MmW
   7gNOqgJSRQsbVTZg7k9ef3KKbeIGaiw0Ala27qg5O7I2E8PIyZiCeTNtP
   Ypq0qmHpJw7vbC9YbcurI+7M1Iyt7Pw2ksOn9s6/JO9gZumnXRrIXWhOl
   bXPFKad36615NHokut4QsxxglPxZJwXab6MS1aECDrQ+S0EYAPGdmhCxz
   kiOZ6QRO2j2+6jmCmiuahbo5hzbdxfnE3CzqoNwwoq2NeJazlwVwlqVzo
   Q==;
X-CSE-ConnectionGUID: naTamvJWQbSCzrsiYMNB9A==
X-CSE-MsgGUID: T95IOZDFS0aeJ0mxhdy7OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89737231"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="89737231"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 12:32:06 -0700
X-CSE-ConnectionGUID: w1g5jI3ZSqKVmGcKcP/zxw==
X-CSE-MsgGUID: tCnCDKSqQxCGrdK3Z/caOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="238045214"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 12:32:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 12:32:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 12:32:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 12:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyBj8+pv57u6Wpz71YbYlHpUvEjIgGQj5jM8E62W8YH1HKh7eBO+SK1eW5SuOu8NEQ4hFOWUGQXspXR9Yx9txlbm1GaE+25Le3xDAl5FiTcr0fby6vF8K3x2QfBA2gAl2TybJbWAEeT1WhAZnPU1qjI7H5d47hzFvg/g0ryKGm5gQf3/mnihOWNFgapnCx+Dy6yweoDQOIP9+00ry/kgIcj/8Uy8cmmHDg7sBEW8rrhiEzpVoncfTPOrAKnbw+mdYufs1THyt2XZgpBuGL5lAnRcGKiG2PA+BQGWn/zFlcdTBXZvm8LxMql4MWNlg4xKCH1BXrq7gTKrDMNKvb072w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S7Xhd/wkPPgRbU4S32aGV/Aci4DNiZgY8+TezbQ4rw=;
 b=XnDSXF3Mmjp8pR8idbLDYIbLvf42Lh+DISK3Bq8tFMn46ZpNlRCcczvwmRoNRRsbMhhvxGMwNNNu0V1yLBGRuqHKjMP7+YkrQnmR2WXy2O/xcQmtlLuipWPl3nHVg+PUFkXD7hNBLH7CyeL0QrgmptxIRA2hzIx5lrKUaxI4sMB4M+01g30RveyZGp14+SvHRiYXM9AUvcPRZB/G04JusY744KW3Bamy/7dj9RT/073F+oBR1/dES9nbzH8r0EkGFDEWi61OsYo8RkRF/91XUj0LHNoVdhRxqHHhJWX+g+t5uOylNrUKUFiEDUP0hv+6vmj7emJ0tPdf2X04m1k1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ5PPF33E90C8BE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 19:32:02 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:32:02 +0000
Date: Wed, 6 May 2026 12:32:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/dma-buf: handle empty bo and UAF races
Message-ID: <afuXMP5SURv5d54j@gsse-cloud1.jf.intel.com>
References: <20260506184332.86743-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506184332.86743-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ5PPF33E90C8BE:EE_
X-MS-Office365-Filtering-Correlation-Id: bf72c44f-31e8-460f-d6a3-08deaba62617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yT0cXEOBSNtImyiPkkBYRWOW2+QOPCa/OUlSZVNqX1QfPY1HuCWDi5Ygn1nGmq5R/mY8i/mg9LzOsZWNuR2CwUCc3H25P2pUuwLKjQKvHEC7QiHntgS/OS/5OVKIp4XlrVQ1xwMrsOibBMp/Ei5y10YC1J5gsXcsquJCjRgx3PQMPVqnedKFrOGbjsyVcFyHAZbSeRMVqVsqqqGItiyDWi3K99zHKzaWEOJYdozQaHUkX7u2B0LQpfOIv7sIgu3CKc+hVnFBpE0hpA8HVMeNBoL8yhRE1C6C8wVDitFGpLJW3lcbmxrauK7U3yW0xkinOuSAZlvmAK+iK9x6r8a64AGwnCGC3MXi/Sp3WnI0nGOJk62Qvm5sm79aY6538L43JDLpi9PrMBn7acajfKzq09KAsCkuHk8d2qWV1k3canLWCzNC9pgVbPT/5Lp7MULTmGHwaJoIxf1XhAGbWvRkhLK7dvLEoK1UFHa74UaXjj8E31kDavmOZ3Yqwuh6REIx4hgkGzkrn+/PcyhDHG6j86O3dX/dLubr4KgfE7vIPxAq1zstLpwiwTBVKmAGjc+0o1VLZb29mU+z+0uU0UYEsq60r4K0vqIJuL4qk+t6GGAXWF7U5mQ2bozifplmr/1ntkUu1o+PuuRzzwRniURDgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G31bFtUHB1M8NM9y7iFLwFUdN/C86TIH6OIwindAazWtew9SuqYaINYBgb?=
 =?iso-8859-1?Q?5B6PgYdHyQZ/lVVPoOqLYzXDZnxoPigjpgM+6svQVIQbVKtS2etkut2aP0?=
 =?iso-8859-1?Q?VerTXYISQVquBPsWJctSkdvC9EBjH1/B7J6QcTAra+XsGkm71PBM5JEi7h?=
 =?iso-8859-1?Q?I5D0yocm4shNyr44aS8Y6Cn1REXbI8a5K75a6i2lo8tfUXSQAg0xfsaOKw?=
 =?iso-8859-1?Q?ZAIkBpuBSIs9ynJnxYBIoobG+/+mJVE0DSu1ezgwRT8nSPKBZbB9r2r5OJ?=
 =?iso-8859-1?Q?JYKDS2aHdlvgPIeAfDA7GfgAoScP/t+WJ4A0wD3+/vQB8fE9pSl3Y98MR7?=
 =?iso-8859-1?Q?8ccMKROZU/p3E3SslIqubz9k9sYe6q1+7Zm6Wy+X2yt9oxq03T3BiERAwC?=
 =?iso-8859-1?Q?kN3Afqqd7wdS9nlCGmOXH+P7dMvObcGu2WHEX8e4iKo7JBd0zj7sgPnFgb?=
 =?iso-8859-1?Q?MHZEIhQIaOrFa4M3Iv7LYsjuK61ef6xJZ5ZoNAvUuBlwjIqhfGrYrZFjEx?=
 =?iso-8859-1?Q?ialhX46ndNcAgdweQgzkPYZv4CxvvdvCX8UmSRMBwzpRtejQm6pZqlZ62X?=
 =?iso-8859-1?Q?3AyV4xOzOEr/IEtF1aC5P4Dgz8KTs9Nb7d59Zp7EAU/h/ecXBZygLYhnFs?=
 =?iso-8859-1?Q?nfJ755FMUn/DslOfg23Ala5mIg30MFlhAaPYZhdyrAVCbA6AA9PW5+IRO0?=
 =?iso-8859-1?Q?d/P17Ch4ekMPbEhsbwnUgwcvHo/fKi6ba62r3m2OwRItZwX2dKkwAqVK6/?=
 =?iso-8859-1?Q?qK2wNDP1JOBVNjbq2Y4RQZplbPevs212ppUP+OhuLLzL9HsUDrTkPnKn5O?=
 =?iso-8859-1?Q?lbHok2OBh9L1vvUpUpFBB2r+xcKBieAy38rjlx+SLU48rCMWK7HnO1aEqK?=
 =?iso-8859-1?Q?ZuvYd8xp6rLh8ZJZ2CDkfJHVOCXIGNwDioCXw4Ti+9EiglTG3YXKwXyQfW?=
 =?iso-8859-1?Q?kRHMjx9kXb9ahmwkx0bIfymYFD9hjtayxagkjKXRjBJ0sIconBYu09BSvn?=
 =?iso-8859-1?Q?neusDL9ly8FA8oTtswVWQ8fRfeSmavxVhQLdSQ+m0GhNXiynYA8yvsImv4?=
 =?iso-8859-1?Q?dTbpcOZROpetBRdDIKTZ/Zk9HfXxN8mDsvnS0Yz+ig7A/JOuXMYk6XIpSA?=
 =?iso-8859-1?Q?Yqi/fDptXH2KhMGGyAOc2lURDaT5S1ZC6RSwArujpqKqPuNgp6qCXAbHiz?=
 =?iso-8859-1?Q?J58ZBvp46Hw5VDD4CByHJ+ow5Li7Baq9wYu35+mJVLitlQvHJXl7SSWAET?=
 =?iso-8859-1?Q?px6KAGNSs1R04CiPCtrJQuDIJVN3NLaBW/f/Ba6nqJcXwU7oZJjkQ/+bZ1?=
 =?iso-8859-1?Q?YfP330EGHlLn1Pm8dkJ+kUt995YQ3J3Y0SLahdKPCVfzys9bn6h5vwlX1y?=
 =?iso-8859-1?Q?X+zogijmeZyGzbBqiaG46X3JDmmQBF2/VnQpw0qYcA54dEyHZFa0KIh3E1?=
 =?iso-8859-1?Q?dMSNIQPYjOLeS3kj+B5E6KWcTDQVy5RJ701KtYHuBp7YgWBj9gLVrRyQQT?=
 =?iso-8859-1?Q?gTYjUvqOmVrH1wl5jfgRIg3P2DfzUbVjxZtsGtdNjxH6VLpkP+3iC0zwle?=
 =?iso-8859-1?Q?k8WwLHNkJCl3t1dk+a8jrdFI+yLcbmE+8ICY/NGfxKCMP6NsUgDlr+O4gw?=
 =?iso-8859-1?Q?cpdNSPu3lBQl/TuXpfmM15MJPPSg3OLqrIV5U093bWca+yB8EhkSwMiVsb?=
 =?iso-8859-1?Q?I6sdvAgeMTS30kLaQJRtmxbtfCM9nEgJvYlZ7WeVwtepw2/pDI8q7+RhI1?=
 =?iso-8859-1?Q?1ed0Kj2H/OmhR9aaKLIAbF68DcELQtei0jtGMqq7l3eDLCv4z1K6KAjNM3?=
 =?iso-8859-1?Q?OcfK/axiSGh2XfSKrdNuPXE//60SiXs=3D?=
X-Exchange-RoutingPolicyChecked: T71Xy5c21dWyPJWuS9hVnp28ewYh9WVaFpqpj7ElfLpk7+R31FxFqpt75Sj2fP60SSLtM499ff5CdVA+xG7+t3bR/ybyfBAoA2Os0GnFIiQgs+xK9pCZJ9ERlItLiX1BZZi4xkX4dDjB4rDfGtIPHJeWTCJreQtXLwDyFXayxaaW7pJ+Ev5eSzCu819yLIB6TLn54pMODVw7yBmtbXxdhEnLXbEnB5mDfVY6/GrX0kF5vOt+ROy/sRr35LGZDX95j2nVt/4F/yKWNtpErBHlECH2Mt5+z/TZuE+f9skHAVz8UGonO1od0KycQDG++mwpkPsN7TZ0IE8SvablF4ox4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf72c44f-31e8-460f-d6a3-08deaba62617
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 19:32:02.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ygdvH1o4iSW0dA5CuuEMVPYoPRDujgr8oLIwHwFLTmSOdezeB+Fzrcdw1l3/WEGF7xZSnO37A0a+nbxO+XSAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF33E90C8BE
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E86444DFCC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244443-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On Wed, May 06, 2026 at 07:43:33PM +0100, Matthew Auld wrote:
> There look to be some nasty races here when triggering the
> invalidate_mappings hook:
> 
> 1) We do xe_bo_alloc() followed by the attach, before the actual full bo
>    init step in xe_dma_buf_init_obj(). However the bo is visible on the
>    attachments list after the attach.  This is bad since exporter driver,
>    say amdgpu, can at any time call back into our invalidate_mappings hook,
>    with an empty/bogus bo, leading to potential bugs/crashes.
> 
> 2) Similar to 1) but here we get a UAF, when the invalidate_mappings
>    hook is triggered. For example, we get as far as xe_bo_init_locked()
>    but this fails in some way. But here the bo will be freed on error, but
>    we still have it attached from dma-buf pov, so if the
>    invalidate_mappings is now triggered then the bo we access is gone and
>    we trigger UAF and more bugs/crashes.
> 
> To fix this, move the attach step until after we actually have a fully
> set up buffer object. Note that the bo is not published to userspace
> until later, so not sure what the comment "Don't publish the bo
> until we have a valid attachment", is referring to.
> 
> We have at least two different customers reporting hitting a NULL ptr
> deref in evict_flags when importing something from amdgpu, followed by
> triggering the evict flow. Hit rate is also pretty low, which would
> hint at some kind of race, so something like 1) or 2) might explain
> this.
> 
> Assisted-by: Gemini:gemini-3 #debug
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7903
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/4055
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

One suggestion...

> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index b9828da15897..e6c2f7d30abb 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -357,11 +357,6 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>  		}
>  	}
>  
> -	/*
> -	 * Don't publish the bo until we have a valid attachment, and a
> -	 * valid attachment needs the bo address. So pre-create a bo before
> -	 * creating the attachment and publish.
> -	 */
>  	bo = xe_bo_alloc();
>  	if (IS_ERR(bo))
>  		return ERR_CAST(bo);
> @@ -371,6 +366,13 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>  	if (test)
>  		attach_ops = test->attach_ops;
>  #endif
> +	/*
> +	 * xe_dma_buf_init_obj() takes ownership of bo on both success
> +	 * and failure, so we must not touch bo after this call.

Maybe quick comment indicating something like in the commit message why
this must be done before dma_buf_dynamic_attach.

Matt

> +	 */
> +	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
> +	if (IS_ERR(obj))
> +		return obj;
>  
>  	attach = dma_buf_dynamic_attach(dma_buf, dev->dev, attach_ops, &bo->ttm.base);
>  	if (IS_ERR(attach)) {
> @@ -378,21 +380,12 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
>  		goto out_err;
>  	}
>  
> -	/*
> -	 * xe_dma_buf_init_obj() takes ownership of bo on both success
> -	 * and failure, so we must not touch bo after this call.
> -	 */
> -	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
> -	if (IS_ERR(obj)) {
> -		dma_buf_detach(dma_buf, attach);
> -		return obj;
> -	}
>  	get_dma_buf(dma_buf);
>  	obj->import_attach = attach;
>  	return obj;
>  
>  out_err:
> -	xe_bo_free(bo);
> +	xe_bo_put(bo);
>  
>  	return obj;
>  }
> -- 
> 2.53.0
> 

