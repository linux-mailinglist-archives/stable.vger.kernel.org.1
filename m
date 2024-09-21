Return-Path: <stable+bounces-76844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BE97DB69
	for <lists+stable@lfdr.de>; Sat, 21 Sep 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EC128249D
	for <lists+stable@lfdr.de>; Sat, 21 Sep 2024 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D264D;
	Sat, 21 Sep 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt5Q7d9d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD88C1E
	for <stable@vger.kernel.org>; Sat, 21 Sep 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726884016; cv=fail; b=l/I7LRnBI6qpMeen8gbjvZTpy4u2q6nZzN0z0gIdAVy3rA3ClDtL4YXWV6uTY+dTpCj3C3j9f0HH+BGrarABMrFa3jTXct/72jmtr0YbpoHeqZGSfTSp//YhNpZMzIqCUa3zHCwTlMbbkLxb+Tb5R1hI8lGxO/kIlrbLaD6HSOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726884016; c=relaxed/simple;
	bh=dX/QElX5AbQpEB1qvIO3fgOtaXs81Huvx3xq2V+9jw0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyuwyzeVRZlH1OJnnNtrKFg14yFR4fexfOZXjqqYf7ttPMmcj1/M4y0x7WxDxJLfsQMWuIrB5OkcDRv5SpyaIlsalvZKEf/NOkhREvdEIfKnTH5ct1fGprqkKEPk+2Y0+H8/901IYBwlH9eCzjMa1nM2ap5O/vVnXgWrO2uqXno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt5Q7d9d; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726884015; x=1758420015;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dX/QElX5AbQpEB1qvIO3fgOtaXs81Huvx3xq2V+9jw0=;
  b=Rt5Q7d9dtRDccRTWKtanRk/btI7ftsz35LuiyRmk2inltEzSyVpmBaNG
   MqDBVIs2BoMgZVuE3R27Gi0oISOSwBK9JmqEmTkkiOS7CvY+9XCfI/JPn
   JOFEQv69zwwGSXNvaXcchYET3SzZQSRimvH2Tfmp87OY8y78/ahHd8Lhj
   U13lT8HUf/ouXgVr8BwmYV6Bor4/EJbFm1vTzMfYfsybUGpmrYBSdQvYf
   L+t4LFSqvmV0tq4bIhJ1UUquiI87QB0jRJNxp9TaTZMiAA47yW17z8uCK
   jblUOJRW7uetON7U4H6P8wy8dr0GfircCh3ayPlsbi6RHo2QPyKhxUrix
   Q==;
X-CSE-ConnectionGUID: H7zevj/tRsCCLJ8VU8V1mg==
X-CSE-MsgGUID: 5j4zz8sqSd2sWAvdAVafag==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="26089735"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="26089735"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 19:00:14 -0700
X-CSE-ConnectionGUID: WSvePC65R+yi8RWmHuNepQ==
X-CSE-MsgGUID: 1/hD4TZySseypLWpj5Fvkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="75045741"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 19:00:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 19:00:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 19:00:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 19:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjApcv5GPVvJWE/43hkd4+6z+MeLpfgR0DzNyLi5LzgRMvnOXtq6MhcKbXxjEQvMpAmwOmJJMxQhanQ/6AIzEWwMKKBIsv8BPnqz6/EBPmLuoM5uHWAw6JBsKcdaMVSutvGmRgsMz3RkpTAZHYwUk2ssFsS0l+jfyHHxkqo9H7hYzPQ1TBa8cNlrNAOA9H19DHtL3ORMRRaijNetYiZz+VIN+jO9HzYKErL/z+D3MpT7AeVzmfjg3cDMFHhFYtBhLBMMsWDWJSVPEoJHx85Ee5waM8jCvqBwq63DqX3sfNS15Aw75l0Rmijf8s2pZGxvme3mQ+ZwQRHdRNdBL7XIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmzFFn8Ogo1f/MEREE9WUpfV68mrMbcr0P2Hx0hDYkc=;
 b=Obylafa6ZPB7RveNRquY5Ab4gMuPYE1gY0vZ7JTgqigtTRaMYe8xi1qmQz14xY58ZKvjXbjmhFaeUWoIsIofuuNe17ABMhMWmApBS8WNb7xklsw+NLaOqNMY8XEhJxFaC0u6Bk/0wRh1F8Fhmn0CYHY0QgrjDQU1zQaRL1grur92VEPyzYReg36Is9fmrFRHrFTRVMcPl62l9qfuf85819IlPePb1cdKoykduLyB9hYC48k6GNxImnxclEBS93MhXaNxXFjzzX9ACQ7bJg2KNW0p5gyQvBUVQ42uscctS0s1wjfyXsn61S58q8jJA9ZJ9ZzndQhOSdX+COfHP080Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sat, 21 Sep
 2024 02:00:11 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%5]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 02:00:10 +0000
Date: Sat, 21 Sep 2024 01:58:25 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/guc_submit: fix UAF in run_job()
Message-ID: <Zu4oQbrE8ImNBHfu@DUT025-TGLU.fm.intel.com>
References: <20240920123806.176709-2-matthew.auld@intel.com>
 <Zu3H+GgPXAsRWQjB@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zu3H+GgPXAsRWQjB@DUT025-TGLU.fm.intel.com>
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BN9PR11MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 481f740e-5939-4bef-8b2a-08dcd9e1200c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKEAZBZ6serYAhFzmXJqb9KUjBhcaHjgFP/mZ8SDCCK0shgyd120cSOoSI8P?=
 =?us-ascii?Q?lZ0XHp+J0RK4UaxAfRfrxIT4YPyo6JuPzjKONBCezo+bYH6Muw3XIjO/LDWN?=
 =?us-ascii?Q?/5BxMuIhI6aZ7KINIcSM6m8QR7zfQB8EvYpwVdknTU9bAeeAsxqJZyaX9uUo?=
 =?us-ascii?Q?eEacJX83YZ+K7xD9+p1UMAUgy+P4tyJDWzBMlPKKqW2Dxdqbt2bjvXVT/Cro?=
 =?us-ascii?Q?6IBdS5akWiy3t8UXstlk1ny5KYE5EcZ/YMV0NASewwmtl+AbyaSjeEChzmbv?=
 =?us-ascii?Q?ZzIhKP+RUei9dHzy0l7scqiluBk0cn/GsIQ15kM3Uh5SkH/OMpOJIGWggtB+?=
 =?us-ascii?Q?syiOy12lfBcnOLomhgQ68O5hl3AjjwGE1hUjpxVXXRFXj0pqSWSh7IwM1TmJ?=
 =?us-ascii?Q?xgpyPUjBQFtNE1LzqWA4kRz3faG3EMi+wRu35k2Rdz00F3wbKkzupokVT16D?=
 =?us-ascii?Q?R446/4pJ1adj8VCEVK2xUVhB7r+RgPkCKm2hVBIIHcEvVsn2KKZCHhN/ykDV?=
 =?us-ascii?Q?dN7c+IYcmq7rdanqvOmTI4g0c84gpmpWVjkOw1IELIiP7rM/rEkffe+Qw5Ml?=
 =?us-ascii?Q?0igkhqNu8YXkeeTcF7z4xI8aAk/I5kTtEQDw0E86XEfgS5rkGnnt2gTMxSCt?=
 =?us-ascii?Q?7M3GHfl6X+U3U5Cbv8NnlHlsoCIC56lrBgIhMv+5XWzTBYc1N55skDsmw/Hy?=
 =?us-ascii?Q?WTQnC5uwypWAYoRh1VaOejkxGdqOGjNmqONeptRQ79c2csWO0K5eCwLD4Lkj?=
 =?us-ascii?Q?4zbnIitTxjARZ0kifeLbJENTE+EczBnw7pDN04dEtPATmvmUikdZi17q/3El?=
 =?us-ascii?Q?WXKjJKAbb86Kx7aEgdvyOBUGEwMLJtAyqkoFN/o5jSTos+6evj39YbmwnBP6?=
 =?us-ascii?Q?lfzD9LQiG0HDlDny6fcS0nWgf1vMMCLjEZQqN4Xb1DlcVY3ecd51G0SuHdfd?=
 =?us-ascii?Q?jMGXSAU7JNMSdfwVjm9n+WnyOazc3b8P5vidrs67Ib2nVpYQ5EkJLjHuEqtE?=
 =?us-ascii?Q?9GDB4aBxGWcJQFj9SbFihqGRcWcMyT612s/D44efQ43dspDW0NjRmJN0OhAn?=
 =?us-ascii?Q?m3zfjvqMZZUCpMexxIcdeOGuC+D/CsCv806LqtGy634AegBfNctpRTP0pQGb?=
 =?us-ascii?Q?ILl1IWCX4yKhDLwgfQBQKvoIM9K0fsTwVbZLeqNlzCPWZFja+J2Bvgg9eWA5?=
 =?us-ascii?Q?IUeGNyOaKoOL4T32cgK51QtXolKm7YzYq/cQgLRCYe+7s2/coeAj6/G9RAzZ?=
 =?us-ascii?Q?iO0gdkSQRK7axNuNKsaYblwmdO9qJNNMkicKj1n9IXPlZYbfhzc7Qlusp5yw?=
 =?us-ascii?Q?3eg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7oZc0IvfJfMER8mdaF/V3soS0uGyWmKHUOxoF5iw02V/pjEuA52C51suLnCT?=
 =?us-ascii?Q?W87113VcTu8lEdBNur5abvOckdga0p70nXwtvWS9TysMy0jfuT/ZP9NcoxGa?=
 =?us-ascii?Q?O1IbFbpSva+WuLan+3eujhuy8NgoY3pLZNg2Vbai+brdGl+zzqDdU0JmtuBQ?=
 =?us-ascii?Q?I+zEuF22x4KHSJu9IiekQtajZVJjOOTBttgZaUvh7BrQzc92Vk/auI+OgjP8?=
 =?us-ascii?Q?KNtPyqkDhRdl/uaeaDqw9GpfeSspZD/HHDXRav5uudlYQJkSok0qOSowHxq2?=
 =?us-ascii?Q?wTFrstooRFnJvUxr7eiNyjWSUr8bXfYy4n3px5h3vFK5my6NMwpnkpJ5mpty?=
 =?us-ascii?Q?Wb1/sPAWViTJZrldvXsbv49+u0ZcGlhCeuqNJOl2C2MVyRihtLjRVvSntgYb?=
 =?us-ascii?Q?RYVrHdOoJNT53IOdVTZZZDMpKS5aWG86rNw914KoJIJ/oXzfVpHWb710z7pr?=
 =?us-ascii?Q?Lq/T6N3dpQ9grg7gsiy2L/T2XqVG6Y/weG8xOkEDNqwg4UvFwusKak0j1ZaA?=
 =?us-ascii?Q?KDkIG+EUTdtataAhBMS+7RguCc5cHLhN5ocd7MUePo8c3/JN4scvy9bef7AJ?=
 =?us-ascii?Q?vJrHQsXQ+cwORPtDlRZyzC+XsE2t3y56JibV3I+4OYwzWJDcanv+HTY+9sMr?=
 =?us-ascii?Q?ISVaj3O9spW8/U/WDYFW4eiPR++dzziv4CdEha5pbCBWpInMgVr4iLfxYJQd?=
 =?us-ascii?Q?ZvvfOrglZi3wcL9tt9ZPoPsOjPF7ynaQMswKmpZ+OpgH352qX2O6SaTr6f/b?=
 =?us-ascii?Q?X2gh9ZOQ4j1IHlc9fBsYz1no07laS4CT19aZ8OpqQlsfdP4lZ7ntHKwbPy8B?=
 =?us-ascii?Q?rtoaLERedWuoHHjlXspJqfk7BPT1UlCyA+9Owkk2W874RB5OBH/L34c/f8yh?=
 =?us-ascii?Q?PRz7Y5zqE6X5pFTRirYFFmHLsV4g5YhjZD2uvVp854zZ+tdT6X2XqT+GQXru?=
 =?us-ascii?Q?yMJYpx42uN/h4vzR8beTBPvMhiji9iEmhkbHDt/Tnfs325pWbVPMWHP4twPx?=
 =?us-ascii?Q?R64NF4/fzfI0qDDUZ5FbNpta9LRZkEjhW86xg8cUbNXrBU8aij5O+zne1Ibt?=
 =?us-ascii?Q?X6A+ayJssepwnRvVtmeEeZKeVUCWuVqa1qd3rjUdy2bKG4Frfjdf13vuOR+e?=
 =?us-ascii?Q?la1xzhHNax+oaZQMTBBXqiNHRpnPmBNLQQ5rizAuJumSM74N+4XGu5WHidl4?=
 =?us-ascii?Q?QvJmeYhMco/TfT4I+kX+Xn0YPeKaOKA/d433ipd51fhY67+22AcjlOmq+ofw?=
 =?us-ascii?Q?ozZgOQlUb0FhaiyMdnTCHI+MeiSgRArAdVNsV+3aLKdrqg8hYi0R/Sy6A4sN?=
 =?us-ascii?Q?x836eT9p4uFfDCiscNqRDPDQ0eNq0akrqfWmJ1NJLy8YayPqv1JsYCfS5TpW?=
 =?us-ascii?Q?6vzMuZOpHDNuTrvkquFq3pdOPeDcPDVsO+ZSyhdmzoZ4JrGgOKnkJkvneDP/?=
 =?us-ascii?Q?eYkxLJBmNapPCPXtlHx86s6EHBe2fSTUWyJVtSH3pzNGLV+STMPpmy8YGzT6?=
 =?us-ascii?Q?HrY96CEhGcbJRC7DFS+0aB4vFQUfGJ2x3RtQERrxkdcB+CfJ+zzNQStuofj2?=
 =?us-ascii?Q?IRtAapbWee0QL/Qg+mrdkQ1v7eNDBYDoA3UtFfh1r9rk+cTP33DuVHXWBhUh?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 481f740e-5939-4bef-8b2a-08dcd9e1200c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 02:00:10.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+W8XVFhldyiWP6R5kK1DKH1zxmsOihIqfhJgYL1nseGk9wNGJ8c+Kja0LQXm0OESzVUtnnV/Rim21DUtpv36A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com

On Fri, Sep 20, 2024 at 07:07:36PM +0000, Matthew Brost wrote:
> On Fri, Sep 20, 2024 at 01:38:07PM +0100, Matthew Auld wrote:
> > The initial kref from dma_fence_init() should match up with whatever
> > signals the fence, however here we are submitting the job first to the
> > hw and only then grabbing the extra ref and even then we touch some
> > fence state before this. This might be too late if the fence is
> > signalled before we can grab the extra ref. Rather always grab the
> > refcount early before we do the submission part.
> > 
> 
> I think I see the race. Let me make sure I understand.
> 
> Current flow:
> 
> 1. guc_exec_queue_run_job enters
> 2. guc_exec_queue_run_job submits job to hardware
> 3. job finishes on hardware
> 4. irq handler for job completion fires, signals job->fence, does last
>    put on job->fence freeing the memory
> 5. guc_exec_queue_run_job takes a ref job->fence and BOOM UAF
> 
> The extra ref between steps 1/2 dropped after 5 prevents this. Is that
> right?
> 
> Assuming my understanding is correct:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> 

Revoking this RB. I should've looked a bit deeper here before the
initial reply, but I think I have this fixed here [1]. Let me know if
that patch makes sense or if you have have any questions, concerns, or
comments.

Matt

[1] https://patchwork.freedesktop.org/patch/615304/?series=138939&rev=1

> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2811
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.8+
> > ---
> >  drivers/gpu/drm/xe/xe_guc_submit.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index fbbe6a487bbb..b33f3d23a068 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -766,12 +766,15 @@ guc_exec_queue_run_job(struct drm_sched_job *drm_job)
> >  	struct xe_guc *guc = exec_queue_to_guc(q);
> >  	struct xe_device *xe = guc_to_xe(guc);
> >  	bool lr = xe_exec_queue_is_lr(q);
> > +	struct dma_fence *fence;
> >  
> >  	xe_assert(xe, !(exec_queue_destroyed(q) || exec_queue_pending_disable(q)) ||
> >  		  exec_queue_banned(q) || exec_queue_suspended(q));
> >  
> >  	trace_xe_sched_job_run(job);
> >  
> > +	dma_fence_get(job->fence);
> > +
> >  	if (!exec_queue_killed_or_banned_or_wedged(q) && !xe_sched_job_is_error(job)) {
> >  		if (!exec_queue_registered(q))
> >  			register_exec_queue(q);
> > @@ -782,12 +785,16 @@ guc_exec_queue_run_job(struct drm_sched_job *drm_job)
> >  
> >  	if (lr) {
> >  		xe_sched_job_set_error(job, -EOPNOTSUPP);
> > -		return NULL;
> > +		fence = NULL;
> >  	} else if (test_and_set_bit(JOB_FLAG_SUBMIT, &job->fence->flags)) {
> > -		return job->fence;
> > +		fence = job->fence;
> >  	} else {
> > -		return dma_fence_get(job->fence);
> > +		fence = dma_fence_get(job->fence);
> >  	}
> > +
> > +	dma_fence_put(job->fence);
> > +
> > +	return fence;
> >  }
> >  
> >  static void guc_exec_queue_free_job(struct drm_sched_job *drm_job)
> > -- 
> > 2.46.0
> > 

