Return-Path: <stable+bounces-170045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED9B2A086
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64307188E492
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309431B122;
	Mon, 18 Aug 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJsgATdY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF831B10A
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516568; cv=fail; b=iRAeGxoLZTLIFI1yKWQbrmnhJmjgI2UorCEoWtdrPos4W3vEMPV563S8NZNHiqXowfDxtN3e0uiTDJo1uVZrv3f3srzWwUv3/28Pe7Ywa4LmVLI6ReGIUKUhbp6AbVxOBO0mNnMOiQbamhIlxVRtYuiVWuDynsCePtmzFN5a+jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516568; c=relaxed/simple;
	bh=V2/7qmCprbpMMD6ogmDKTMcsA32X1CLmROc+yfuj6bA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tyNyIdgJpcWt1s/yqZedNVEG6uFBYd4E4oQPDxjUXK2aLZb13gv9m4nszB4kTDbx0FfXX3F+tuwFcLNOEKQ+6DBndunsdQwCNM4MC6ANPNd0eZoSIJFyduBTWKHFrRaGA69bTHBYVZeBo+xeplX3HA4lXv3l98MpmQSwgv/vtjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJsgATdY; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755516566; x=1787052566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V2/7qmCprbpMMD6ogmDKTMcsA32X1CLmROc+yfuj6bA=;
  b=EJsgATdYY4qzGHfXxRjeZcmINnJz7Yq6sx605S3aeYqzx7LxTCHshfKw
   xxvPsvmnD9TC8ZIVjaiRQjSs0WTr01S3N+pTW8XYkZxC7ML801VDeg7nF
   DkEHixR8MBx21keW7qr4uwbSYumbC8qB+g8e+0P5PCi9BpWAydIC2GicH
   qK/vphHKQgyI+50gt+1EshkJ/dAAvqc2T0JGtEQKGZBEvJypf9OP65V4N
   uApeVqJOVjxH3X63sTNPxUznzQn1gZRB4VdE3tKN4hzyNTahrquvLcxV/
   bkFK9K9hDO/dLwFV9KBvKExVjtOw/YRXZRhQsD17Z2rii6cPS7kZn9pPJ
   A==;
X-CSE-ConnectionGUID: gLKrgd/6QQuhL9G5DakiNg==
X-CSE-MsgGUID: djkf+ztuQx2bPVrPDOWSZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69110699"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69110699"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 04:29:25 -0700
X-CSE-ConnectionGUID: imB0zXvRRUuxLAnEMUdQ5A==
X-CSE-MsgGUID: wjdcCR5yRoyfLn9goYgBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167945643"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 04:29:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 04:29:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 04:29:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 04:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zACEHdHZ/P4VIHiczjkwiQsGUp2CWXVNDovRCG1LBuCztZyG20mb66Ja9vcl1Wp2xvD8jeESYQQZRwHOGDEHghQXrL4Qh+VnanadYVlpfJ8DEBqd5RAUyOZGedkVuc8+HqfTuAxpTkPYpjOO1P2i/XCbokcUxmu0dI/RBRIsJt6xSjhBswkocUh3AKDnrxWpo0S3Hv/jbVMOHboXRzGXcXmvRmsk1jZhUazPOHDR/F6mlLEpclZni7a31ADBbBVN8tezDFB2Xvygp8yJ+nAZgngFLVpMxeScl6MCwKBcMtUczRu7fvFJni0FdPrP15FIxeyWm3H41ULRfTfnw2ghxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y2HBZMJy2S66Fn9zSHYf+kas1vywRKabrelcssuA3I=;
 b=w3Bnpq3gZodGVaDna5pyuwNmLdAVd3IwzkRxf8C2qRLGomhAyksKH4z0vVzTiafOV15TQGw+R/y1apzrapdB5DL+Yjhod52r2zN/TOuOAx7LluZZU5A6Ld8B8KX/WGN47R5hg5mMZLUucv5OXYJiGBnRnY0it18C9L48KOU4C6AOzmvqgRfqm/MYcFxQntUKKkW1++HmX3Dip/uQ3Ut4Znl/ibb3AXgGgY6iXtWKIF4Nm4bY0gYhBpHMtbW9o5yvaTjJRjGNuIqvYqZ2HwbO0yJIUeGYi9aEI91MDR6mb0FknKk4L47fMzQjK6n/mJtVY/TW7an0nHQ4p3+5kLPhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:29:23 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:29:23 +0000
Date: Mon, 18 Aug 2025 12:29:13 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: <qat-linux@intel.com>, Damian Muszynski <damian.muszynski@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH 6.1 v2] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <aKMOiXg0KvyxWb6F@gcabiddu-mobl.ger.corp.intel.com>
References: <20250722150910.6768-1-giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722150910.6768-1-giovanni.cabiddu@intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU6P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::28) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fdeaa0-6135-401d-5a92-08ddde4a7b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGMr2bjp2Wnuq86YjXTkrx1VzWEqnlnJSOxOPvcu599ogqWRLTy/36lOjXh0?=
 =?us-ascii?Q?g4yd6IrVeSQ8TJMl2qPIyKq9nbI+dchG01SWJzbTXmKsNLYt4mFbGoX8BXHl?=
 =?us-ascii?Q?qHxq5zuIbIvCr5TLrGuHXhE9muyO3wA/nTkZXvjR7q9O6fAkMdBY8/oHZmqz?=
 =?us-ascii?Q?j88ABhaYyZaa0XjV8iXBPEiVSV/vI3st3bOcT7h6IoDacfG5a3WMta2tFKeV?=
 =?us-ascii?Q?UrpsrENVWuXl+c3OaWDOF5A5yv7dc7J99N7Syk59sQDcPVlHF1G9617UbIVi?=
 =?us-ascii?Q?xroyLDwB1tAJXtjqZINJ80p3XXsKa8cF0TmwIc76qaoWPEJEdCl14a1dOLGc?=
 =?us-ascii?Q?dcnZDyzWrRRP3S6Msi0ucVxXFipcXGd386zpfVqSPh3/uEoIaYX6TkP7TpWj?=
 =?us-ascii?Q?apONOfD4Orw2optGuksR5jHvGnIhc6mdKyN/RjcDijrjkv0pZ3RVs2BiFuOw?=
 =?us-ascii?Q?bU4nHqogZuiLIPnFhOqItP6jaEs+rpFDccqBgfgANnM9mi+r2LRKZwvxRPmg?=
 =?us-ascii?Q?m9+gMoGBbQNq+De+1s1LrB2dS5p3G15POgPO6ssUrzSHKHOGXQn/VCSZA9gW?=
 =?us-ascii?Q?7oFawqCNwZcKyTcPTgnGKD8JMpJYah92N1fTbyuyIg0cPMV0jCTj18q/BZve?=
 =?us-ascii?Q?v+l5sYi/1zmUib83c6XewY0oH8XONq6WGGOqZLWL8mLlMkI+XCk4LRAzNkAX?=
 =?us-ascii?Q?FS87ZkWJSh+8J1u3zrbMWZoMgar/eqSm8NyqRpUQBrUExgGgIAkr26kaj8EU?=
 =?us-ascii?Q?JWqQd/o+vieMqCsAk17TRfeP41htM4eZRr+1v+9FOh2aFaCz0jrwXLTXz+VM?=
 =?us-ascii?Q?ZSMmWLLkFAjrA37QAXXQIlGROscPGRFvnTEoOszPq8OrmUW/4cFbjIspjkI/?=
 =?us-ascii?Q?gGWd7o9o7L40tTqOj/hyAM5Hp/KRB4okp80WnP/Zqndl8BcYP0JDWVs9HMz5?=
 =?us-ascii?Q?o5GFCabl8d9WKFV/n/he59EGLDfTvNlKoMocWoPgVMzihji26WWPUKuO8l4W?=
 =?us-ascii?Q?+SSmB9ZbHG2QCUHwuGlj0OX7/if2511oQbL8UFupYOpAP+lOxSQpyRawxf5w?=
 =?us-ascii?Q?ubjOI8jOHK7A4n3x8Nuo85fXaKzBfrv6lTUTvRRtqlidQeR05CAAlDL1yog7?=
 =?us-ascii?Q?0Rwqbm2Sgai6aT3D+JK+X5DUV4oJk/v34sHKKjPJ1OKloGLFP9lyX62JvvLU?=
 =?us-ascii?Q?hjYlucuvQ7ywsHxEQh6L9tPEsksJEajK+KfuJ14yCkFSVheuyGm16IOq78r6?=
 =?us-ascii?Q?ApfhDsrrM0Zj1zRFBuQDfvbSGbDkMpDNF6Mkfe/DEZ3FIum40M8OTQP/rmVE?=
 =?us-ascii?Q?taBqG19+X1dyHUTAIomd8iPflFWD4PsQrylGH901W0uU86gUPj4g5sSraQrz?=
 =?us-ascii?Q?rMgMEYw+4bjFH4M3k7kpfTJ81hZGCoBoBoAvVYR0okqO1TqIjvJS6toqO+/D?=
 =?us-ascii?Q?OxtMPMJjGYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojO/Qi6tC52cJ3n5QBsmSP047yVsXICcKliY//JXvJn07pgCOGnzZK4AFoCj?=
 =?us-ascii?Q?bFEi5cbClQUNeQkiAq54o7uXQjEykTonLS4H1zgbbDmLj8hi88AM+bKIsNqk?=
 =?us-ascii?Q?00LoEvfqFFAF/7n2RcEv+JjN2OAl/b90sgsuGzYapP5XAbeEEYgQq3yPknFu?=
 =?us-ascii?Q?WFnpzkyEL2rEK2F8f3nkgW0LfEmAZ3gxoLOaU6V3b9cH/SMP98iMydZk1jK1?=
 =?us-ascii?Q?mKAE0bjPKI2GE83s0kZkYHlLKKIyhrsCFJlHZbHtpPwcWjhRDgFcpntVzKIX?=
 =?us-ascii?Q?16RaD3eGGirnxhCMMgBO1mCdPHUCoNelJ9NRRS5qzaQRkj5n+IwzUeimbTKl?=
 =?us-ascii?Q?qvbNder8kUosfYIClhJky2ELVH57CMVZNm+3JNYPPBczxW9Z7EsCd5O/7meR?=
 =?us-ascii?Q?He+36U4D2/6Mp1phKlLX4DKgqWKtf6EgEAtSnfMzvb4e69Zwt+ZzOdIXJo/8?=
 =?us-ascii?Q?AQX0ucbNbLtfLWeU8rY5xmk0244BGAkZsKlp0+ADWdHx18qR8907951hCmvb?=
 =?us-ascii?Q?uR3cVxu6EYl02opDphCrOrMSYjBInGrN4I2bIu+LxVFKTTk0tv4bvCe7XESx?=
 =?us-ascii?Q?DBKfvLC4+04s9L8Km4S2p/7+VVFnYkbfV8wm7lBtRnQD8EQqdW9ZW9L5Dl7c?=
 =?us-ascii?Q?un6QoWGGuYhncREnCxCJlTpMvWSrHR0EUc7sEgafomTqlnApHpoWBTl+qk3E?=
 =?us-ascii?Q?NfNk9zS9iRCXgXjh96jhChlNxZtHE+TIViLFdLn5RBHVi5k7jsot6rnTxt9B?=
 =?us-ascii?Q?1V8MsbEQEVawCHoXj0Bs8W8XaLblKKvxEfJ3uvfJq6XxySzJwLXKNqplnzTL?=
 =?us-ascii?Q?38HDJ14yyOnBYlenyov6sRmkOOMeZRRI4yrzbCCmeoWGSI5zRycicZNpmlrF?=
 =?us-ascii?Q?4H7PK8LvSTtf37GS/Z1isOxv0J3rJqkYGCEG4/bL0dMfm7GEhuJ10REZ3uUH?=
 =?us-ascii?Q?1hVHIdAdoNAWS5CTCwcFlHhNsDxesSepokXpLIjZljJAA74ge9AIZOMXJrAp?=
 =?us-ascii?Q?oUVXzk8EFbch2f040S6+HKBTaFNAT9wxwy1Q96ogNfr+XDWi1twcfcH9UG6x?=
 =?us-ascii?Q?bSbUlisu8kn+/JuG4PsELpsLfautuZUYaV8XOkRh4jXLYjwYWXBNxN3vZnj4?=
 =?us-ascii?Q?kBRZiNDicqTgbVgqLUbIE+8VBb2nG44Af1oN1NB8aRd6ogDloMMqIo40/yq/?=
 =?us-ascii?Q?qfhKNLvPMKhTmNgYoAU0NKmC+2hVH5RyCrwPIuTS9W+xgxCCV4y17TNk6fhg?=
 =?us-ascii?Q?gjB6jmbBX57/eGw6IJuVD6XtUNZDUGV3fnfTz56dV5S8oSntmveGxtlUlZae?=
 =?us-ascii?Q?WfXnwRkNEq5zkbO5xul1jOYdWGXpkKiMMXOnE/gdp512kFsu4zTCygJ/XeDx?=
 =?us-ascii?Q?dpRufKRrLnw37mQUZOP05YtiQQ6zYEE5cqelp5GQYIXkalFPMHtZ2NoGeDVh?=
 =?us-ascii?Q?f+V1bynFcoLrochwv/NZDmlVu5vqb6RCxbiDQL8+NWhVSmdOhNBUhi1s2+zH?=
 =?us-ascii?Q?t1CY4pgUVSkjaH1XYi8EzSHe22ncdY7aezxpHpoqedByLiPLwFowbTqriqO6?=
 =?us-ascii?Q?atgghdo0JPcJk7mv7qfvCN/HVY/Lsz0mthweKYAAqzdF9lhzxx3KfP1jjLV3?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fdeaa0-6135-401d-5a92-08ddde4a7b28
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:29:23.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/gUxB8lovj7rvQ78GgmmDezfr82emmQO0Erq6ihWnfzI1HE61gupIpaJio/4XfJWsH35y1SjiZ60ifWVRRpSTWIqzwMClFCDdE0AKm+LVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com

Hi Greg and Sasha,

On Tue, Jul 22, 2025 at 04:07:09PM +0100, Giovanni Cabiddu wrote:
> [ Upstream commit a238487f7965d102794ed9f8aff0b667cd2ae886 ]
> 
> The 4xxx drivers hardcode the ring to service mapping. However, when
> additional configurations where added to the driver, the mappings were
> not updated. This implies that an incorrect mapping might be reported
> through pfvf for certain configurations.
> 
> This is a backport of the upstream commit with modifications, as the
> original patch does not apply cleanly to kernel v6.1.x. The logic has
> been simplified to reflect the limited configurations of the QAT driver
> in this version: crypto-only and compression.
> 
> Instead of dynamically computing the ring to service mappings, these are
> now hardcoded to simplify the backport.
> 
> Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> (cherry-picked from commit a238487f7965d102794ed9f8aff0b667cd2ae886)
> [Giovanni: backport to 6.1.y, conflict resolved simplifying the logic
> in the function get_ring_to_svc_map() as the QAT driver in v6.1 supports
> only limited configurations (crypto only and compression).  Differs from
> upstream as the ring to service mapping is hardcoded rather than being
> dynamically computed.]
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> Tested-by: Ahsan Atta <ahsan.atta@intel.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
> V1 -> V2: changed signed-off-by area:
>   * added (cherry-picked from ...) after last tag from upstream commit
>   * added a note explaining how this backport differs from the original patch
>   * added a new Signed-off-by tag for the backport author.

Just following up on this patch as I haven't seen any activity on it yet.

Was it possibly missed, or is there anything I should do to move it
forward?

Thanks,

-- 
Giovanni

