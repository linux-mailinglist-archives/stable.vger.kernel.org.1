Return-Path: <stable+bounces-87778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D689AB8EF
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0660284D3A
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 21:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0F191F7B;
	Tue, 22 Oct 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CH8gzpfi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1431CCB5E
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633178; cv=fail; b=XYgZ42frk8yiw6wwujthN1qaZuX9lVElUkF0GbD40MlDzKF4mlgnkwTaqiBz0MYMXNQfpkQM00KoenwgFgII6MzyhUaeQvEWn7V9H5EviqS9XU1InvPbBBYLCiUtZUKhG+mYRyEg2N+Panjm6VCbggV99HDVYwKz1FmyF2YC/Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633178; c=relaxed/simple;
	bh=djCLqFvamHgEF9r/ISqMF9h7ucH4gLJof9sC5re2ZzY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=f2BxjsP/yamUsKq/fPq1/BcR2ohGNfXY1H9Qs282uXOgq0qAdjW3C4c2vyqvdFvxNrG6T8jwtLORqUpo6Hqrr1QVyuV06/AMDli+VqWj6ZUe8Ei2FTREcn1XaivtBgigmUwdSv4JUbOAIcnW2pJGqxIOHkSHtYCYRXzcAExqS8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CH8gzpfi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729633177; x=1761169177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=djCLqFvamHgEF9r/ISqMF9h7ucH4gLJof9sC5re2ZzY=;
  b=CH8gzpfiYBh1dNx0OuHLe2EYWrDGwwtPmONMwSja9t1SvPt+b/zYdgxv
   Qhdr2NOm/xekAiGIkA2nT3MltrMc+rmg4EnNp0KiqcrWgWaFX7KvWLMji
   9fTKi96gWOif6i9740NlHr4bTgK0V1SytrwgbWm5WkqxKh8ZPMr4PB8Vf
   koDAJf1Z0f3q7yDLax796E54oass5x+Pm/8cJsD/wUqIn0xcLcZ7bEyND
   2N3PKlW0dK+7RNVxWOzUDF5u2W4GfNgfI4T060e1uJt84rRh+S5ghvb1S
   B+FXJZ7L/fV7K0q3Yjvi/DiL2x5U/schFts2lDv61wUL1wqjDDdEwNUhl
   g==;
X-CSE-ConnectionGUID: nlxdSYsjTCKYSK5S7mkRnw==
X-CSE-MsgGUID: kM6XCU6pT0qe46QkJffTOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54600295"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="54600295"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 14:39:36 -0700
X-CSE-ConnectionGUID: C/qa8jJcTDG55he8dWaMlQ==
X-CSE-MsgGUID: 7KUcszpyRdGtCNtCb9/XwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110787418"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 14:39:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:39:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:39:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 14:39:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 14:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFR9zcimG1ODdhLzJhQHJwkKH1aI5CoH3mQkYARQAr+E2mQcUeo20Qk5phayewyjy9lIQGZB4ctVhZzr7zDmRdgtdj4wFD1D9E4ivQrPUTDQ/DdL8KeLrvVMgECLKvainHdLUF3y0FybX8JElyUQVTOG4ycsUk8dJ7JsgMeg8Hais33SIlVPS09t+QH4NPe7tkK5tDuEVtqmfScp0itS/Q6IcU4fHH4X6fSFn4GAH5/WN5MQYpEwTlX8Yl8TJC0SGlhl7pnOcl17b6H+H8Gl0Lght/EptfrRs2NgWpCLf4hkzVluGPlsdadP9YS6nGlvYpxUb+a5ucw+K5XzYu4aGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzj3/pUsCvEV/zOlSWTepWWSuepa5lyuV5PEgI/4xz0=;
 b=VLzmxCe3NQ/qi661G2Guj1PoljH4WPLnn1zO5xtkdgSctsdj/7RCKQANYcaSkTimBef+5pmfe0itGxsmTI9GKhN2WRjvoqOrZrLadauUBOx/PkF0ELe1zXQU2qJ2du7dtmmPOhZ5Z7cUw1fNC7+JKe8nQ7ae0rHybjr11Xy37corjBMYdWa6d1DEFR7cXNZlDcP2aHMnCh+99+MyK3dC27BDVrkLFBQ9WyhF57xWXJH+dSrIw2q+irZwjbdIg5fmsCltiRkr5Yci3dxwfhY8SPGwJhAMdutRTBxksddP6XYlFtNLq3TI+k3jhCd18bXsFzwsfM+aH3wr7iiBRoGCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB5878.namprd11.prod.outlook.com (2603:10b6:510:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 21:39:32 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 21:39:32 +0000
Date: Tue, 22 Oct 2024 16:39:29 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <stable@vger.kernel.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Request to include xe and i915 patches for 6.11.y
Message-ID: <k5xojgkymtcgybwu5hbhvidgptxwhv4m4plbhdx26qzmlfryvn@mh4i7xvpx5gi>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5d395b-4fb7-4ca9-6a37-08dcf2e203cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hFSS7zdhpOIQeLRpOhmXMfZVJKFZDBos82pTHHrVp8DjqkTLzh+3L+NW8H4v?=
 =?us-ascii?Q?QfmiGOsNPjZILJ/ZvRQURg/1PXArVvrhCX8/MgofbOQvlH6sppxFvTbsPDIB?=
 =?us-ascii?Q?skWMAr3zpvv3gFijOfZU/4a2KGZvy9sA0sm5n72nJy8+Fq38YdnKm7WD6y9M?=
 =?us-ascii?Q?fcy9bWXP3XkbCc767aDmyUCG4CQsJTmoZe4zx11US4YGMxiC/jMwaWucAZan?=
 =?us-ascii?Q?zqyrTzlquOc0PNbvuLHAXRhAPN8kqKFwaZUNJbf3OYCfE9pW3gm+6A+jqFuY?=
 =?us-ascii?Q?HHXoD1lN966kVx9nOSMmMwGcF5TsdP+5UP5XaRKYJtXI5QUOobqKUpIKb3BB?=
 =?us-ascii?Q?BKQZyJGHZyEsZTa8LbFj8ouqfWtv1GE+/JCwtW3xtI/FiTJI9UuJMdcuUclF?=
 =?us-ascii?Q?K31q4gaMZT1FagGhDbt7TvAu8P0f4xbDjFo4tlUBI1IU6dwk0domKjyLoOSi?=
 =?us-ascii?Q?bIbnxQs070ESq81emQ59EYGGxEXqUrs4RWAfnGSi3dwdlS5y3twwrZXeyevB?=
 =?us-ascii?Q?/AftxlmY7Mo1RySqB1woiQbxD43Eph63sy4wJxvpczcR4+xmcIQH1n7s83Ev?=
 =?us-ascii?Q?1egbqyObpbURqHANndSUcHx+syG/TccqKgx95A4HlbgE6O3AYxGxdD0EhKXW?=
 =?us-ascii?Q?a7j5MbPalGxfcHnA0GfCR2RxgNeCCTN6853kB5BAzaMaE+QKjQAqNMu48+z8?=
 =?us-ascii?Q?L3sXGE19EPCV+peAzauG/OnYBXvGcXwwtN7eb057Ka1/sz3NBjx/WUEsmThc?=
 =?us-ascii?Q?GjK9/77UeSD/T5sTHxIHeQN5KlzY9El8ilwtW8n3FrMtPpmrKD/+kH33QKec?=
 =?us-ascii?Q?2PsROBOpKq1cHOmltPV4ITzQjCKGrbWHsHSXRGuDBXV4dcJ8CMm1K1cgVNmG?=
 =?us-ascii?Q?4tE1DPXf+zM5tilUWQ8v1rkEqxRqO8SxFVA4qcr84ZBzqdjP30SB+WeslY6b?=
 =?us-ascii?Q?50vb62QG82FGnU/AbT1uyCukXb4sN148jEDeDhfnkr/qFBdevmOQ/bbwjYv3?=
 =?us-ascii?Q?CHlg6ACGZELLharbNErMg8zqtjtXDphHkEQCAhGoS0HcCxpfg5alkE/gIucL?=
 =?us-ascii?Q?luc+cxQ8++2nM8frb5RFaFzXnarCRRUZOfJOYjJuvOsNNv9iqbZpnfxLcL7J?=
 =?us-ascii?Q?4yX6xU4hWlihD6t74swAL7S5XxAv7iH8DF2G9SGqYL8wTHeO6d5kNdce6KA0?=
 =?us-ascii?Q?FIA8ps5BBM2g4QahSSeHseuHgNl0piIPOTHgYwqiUCfZgLdqxGY4SDFLouoR?=
 =?us-ascii?Q?Syf+Jp4lM69lxXZYKRgS8s+l9RoniXFkkaGzCwnzbcNDYqQb0qd7v3uCP5Y2?=
 =?us-ascii?Q?pwcUtkj+aWg+ijHtO67q7oJZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUWueOf7k5dC3wZWO55qyfExECP2vDE3buPBw02gTVn4KuUY4eJc1Su+1uu6?=
 =?us-ascii?Q?x1pfMP/Ipuy7cnnbGxDdhX01Wy83gcxm141354eOv6gGhkuCLr38PvWYiKIn?=
 =?us-ascii?Q?eZciYCfDUZfqkrTQOtj5/TaGZyPF0eORtB6EH5XRryELTOkEJnWitmtJ/4ah?=
 =?us-ascii?Q?Gl7fQGPYnxKVD7yJkPodyNMeWDuq2cbj8VWP4yy2MCMv2eqEyU2lzJTCqjFn?=
 =?us-ascii?Q?yZaXexqFyyHd7AyHEA9Hdz0XVzKYWAxXTtAtGDGvUixGMuI3kbPlUKJIYIfA?=
 =?us-ascii?Q?Op0Bmn7Fd4t+v1YcRJnpbtQWK+SmiRxHm6IhiM68H7XPKNKLxjRv/Heg/LaD?=
 =?us-ascii?Q?eXGeVioiEH8DDqqbBpgEEmmeH52dXD52ZNq2ed4wvyIebdcmpWcixjJL5Ax1?=
 =?us-ascii?Q?B9ORqm0ZkOkb3O2ZehOtIKmtUPeZIeEBjuigS7W++om+l5y9PosfXXW4eLVP?=
 =?us-ascii?Q?uyIOHxUDBqoZ6nc8/Q8XY9nT8gD5RJ5D14v9K0Y2jcujU4sVJZkfnePUjgZX?=
 =?us-ascii?Q?lyqKypJGBwkfagYkAAkpd0YfUuszQmm0p+elQl0DW3oo8V7HsR/nGpm/MHAm?=
 =?us-ascii?Q?JRnbSetjlBbtZzOhKcZZAbbwglObwunOjUwvnsAJC5NI4aPUtL6KPM5yanXS?=
 =?us-ascii?Q?ltTpT15bIngeXG9snAi+fLbidSX4jss3tCd/QIq4gbS1deeAXk32zDtHVtlm?=
 =?us-ascii?Q?9PLqqiKQ9W9P/dwTurJEsEwMSjZZet79/e47j1RU8zzqagKFkpnOrrfV0BC7?=
 =?us-ascii?Q?1nlvhDBAVM0j3PBrT+35m/Wb2qTeQ6qPXJ2jsFHesjBhiNlJYaUKAJsnNqAu?=
 =?us-ascii?Q?zM82aatSIH2itg0KUeXqnFFJnSiQFe73xPidGB6eCxsEowSQ9immHZkKYm7k?=
 =?us-ascii?Q?idSyjPJWmbt1wjP2XFCvJsgRtOUA10u8OolD5Aj86NqR0OxkzMgWYmzKTD/Y?=
 =?us-ascii?Q?iild9Xblder4op7ZhHgPs4J2IAVtACpBX46aazMOBoZ3L6YWT6g4Fg+CVtng?=
 =?us-ascii?Q?ogCZdWZN/waIyHXraWqDgXVCYGnRpAcLxSkc3df+5ygQ/pHnLFXTDn4ZQxiW?=
 =?us-ascii?Q?KXEEzBlhukDqWIAhcbeLzSye22qnrHvlRJafb58iAF/u/WoWLZuNoTX4vIuX?=
 =?us-ascii?Q?cITwfRI9Nb3rDbYK6DyGmMnFzUYLJ5SK5obxBt+8HJ6ufGWXS6rv5IgurKM/?=
 =?us-ascii?Q?dleSVqBjIyRSD6fFHT7q9wEe9+Q6UYdHF03MLWmWI33QnDyHtgcZpQ5YRTzq?=
 =?us-ascii?Q?6PTvpImz2+bm2lDI01vDCykZbpcD0jbQU3IqSqE0Jgt9lFv9Fwda0PfU/zRf?=
 =?us-ascii?Q?AKSF8VnmKa3H4hx7rsduqrcMq+7as25ecZ/FRm/crVfwAF6zmSdT8sk/vJOj?=
 =?us-ascii?Q?Q5ObwJS3FzyIetvt2FQ4f/xzQm/kweWflY5UorPiQinHcf89tUQY3VTqHsdw?=
 =?us-ascii?Q?NiZsqvgNGxBH+fMJsfEdiuKkXOSC5Wh+0sKF5hHTh0zjjYbjWqEr15sE+/JY?=
 =?us-ascii?Q?1ans0YqE9RapIT9diZXkZejyIe/S6sAmCFMIfZQVmbKJpap35lcgqG4DiPSZ?=
 =?us-ascii?Q?JmF+IBy3H66oHm7/xfvR7QMJVDk4wWu6QUH3ZtkqZqdmN72QNXsdgDNWtziF?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d395b-4fb7-4ca9-6a37-08dcf2e203cd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:39:32.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXUXp6nwt71fBfAOnaxt/uoR/QtlPsqLfiXFYRsrxfwMPgOfPKn0yJtJ7MnWSD6ZKZBmOh9Tvk2SHyIpvUiAHeWHRfxOlNoqpgf+h8YrU+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com

Hi,

I have tested 6.11.4 with these additional fixes for the xe and i915
drivers:

	f0ffa657e9f3913c7921cbd4d876343401f15f52
	4551d60299b5ddc2655b6b365a4b92634e14e04f
	ecabb5e6ce54711c28706fc794d77adb3ecd0605
	2009e808bc3e0df6d4d83e2271bc25ae63a4ac05
	e4ac526c440af8aa94d2bdfe6066339dd93b4db2
	ab0d6ef864c5fa820e894ee1a07f861e63851664
	7929ffce0f8b9c76cb5c2a67d1966beaed20ab61
	da9a73b7b25eab574cb9c984fcce0b5e240bdd2c
	014125c64d09e58e90dde49fbb57d802a13e2559
	4cce34b3835b6f7dc52ee2da95c96b6364bb72e5
	a8efd8ce280996fe29f2564f705e96e18da3fa62
	f15e5587448989a55cf8b4feaad0df72ca3aa6a0
	a9556637a23311dea96f27fa3c3e5bfba0b38ae4
	c7085d08c7e53d9aef0cdd4b20798356f6f5d469
	eb53e5b933b9ff315087305b3dc931af3067d19c
	3e307d6c28e7bc7d94b5699d0ed7fe07df6db094
	d34f4f058edf1235c103ca9c921dc54820d14d40
	31b42af516afa1e184d1a9f9dd4096c54044269a
	7fbad577c82c5dd6db7217855c26f51554e53d85
	b2013783c4458a1fe8b25c0b249d2e878bcf6999
	c55f79f317ab428ae6d005965bc07e37496f209f
	9fc97277eb2d17492de636b68cf7d2f5c4f15c1b

I have them applied locally and could submit that if preferred, but
there were no conflicts (since it also brings some additional patches as
required for fixes to apply), so it should be trivial.

All of these patches are already in upstream.  Some of them are brought
as dependency. The ones mentioning "performance changes" are knobs to
follow the hw spec and could be considered as fixes too.  These patches
are also enabled downstream in Ubuntu 24.10 in order to allow the new
Lunar Lake and Battlemage to work correctly. They have more patches not
included here, but I may follow up with more depending on the acceptance
of these patches.

thanks
Lucas De Marchi

