Return-Path: <stable+bounces-154706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD443ADF743
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 21:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180CD3A78D5
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACD219A89;
	Wed, 18 Jun 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCOc29sh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394F1EDA1E;
	Wed, 18 Jun 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276295; cv=fail; b=g5013+pDxQfDPqzPvsn4rq1hr3KqHyVEahQ0kz4+MkP4hF3kfUZZyg6zKmkc2qobycsx1WMjqxj4w9cz8qxOilZErw6CrPPi3oRH5iUm/6wwinPJcAPD9bRjrwRCTORCVQAI3UzzJmeV0X1K+nb4/AtvibNbDRo4W1S0U/GdIw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276295; c=relaxed/simple;
	bh=tCQFDJnWIUhyv78NqfUh0/UP3zJGDsBUwunhO43uHZo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vqe+pCphdtuKFJI4nT8KJJh5yK8QsrtFgS1bWmof3EIRDbGloX01R4QH7C0uIGS5fJVtM/KWri1MEamAVRTefPXAMvt5lsoP9B1yGmOJ7lTXARmOsKdpRSlJDT2toGTJSoCi10fl8Ia0bBiD33JZOHpPCuKrx8tJGPdKpF9Aa8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCOc29sh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750276293; x=1781812293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tCQFDJnWIUhyv78NqfUh0/UP3zJGDsBUwunhO43uHZo=;
  b=VCOc29sh0MmOMRRnOVmbUYPFatvdRTqy1QF93shuxECEH69ERlCObYH1
   0N0jMEVSzL/dSYH6aL349XYs55tuGBDqu5SVM/yWpzApo1ZbT/bptf8fY
   77sLu5T6WtN1fKVX+FY5VxvuwI4jCDtv9gZhBkF2jh4aafShHtS5BaTCq
   /CLRWszJA1UR8eA75V2MkqGIdBVtg78Rd3qmXyWOLqxvX4SDmVsVE4Vbd
   t50ZT0mSRukUgVf03ofH22ATTMVEIrIyq+2t30GN6b4kR65hgqrmXEOKX
   N7DCp6uuaOgpaEg77gpwfcZD2/2Y5HRImhbwY59oybCn4iEK6zNnuAIJ7
   g==;
X-CSE-ConnectionGUID: 7JeoemHDSTmI6+jQWJwbCA==
X-CSE-MsgGUID: Nprgd06iTs6HqDMPTO2u+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63121692"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63121692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:51:32 -0700
X-CSE-ConnectionGUID: 2XFiDeu+RKWS64OC/8Iw2Q==
X-CSE-MsgGUID: nBhDdJgMSoWlwZ0hCYlHLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150606450"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:51:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 12:51:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 12:51:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.81) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 12:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3/zBxqTkzDIeiPL+UbWEYcB1WYgOPZ33oLPkvCQUCPzAvQzij7psyc7kb9PZk/kGTci31h8MN8G9xzHYvsG8Ip8f9j2ygvQw29ZIFCMTOBH0LW1NYw7kmO/+lUjEuX6oMyKOLo4d7nrJ7Ukx1yRLOt1f1uhJMnAJZZtpQ8xS/SJaYrZfmQrAhKLtatH7fh+17dXafAAURI64teYrylzvjz+YDsiSPbQN+sKn9hjbJxLrzcW5dV5zbnjdaxFdvTmULSZufUa/hLOJIf2LeqzG/X+X091qT2Z2kRAuXAuek9aGN3UxaG4q2Eu1Q0hLADN6W5YPkH7kFsIpmnDM84yaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cc7IcSynm2dcfaa5DCBFw4Eo32uDPMGfL0WtdhJs6E=;
 b=gkDjLduwRtTZIHljKygvYYwAtveRPPMdqnCdKWN3fzFY6ETjfBb5/olCysKs6s66mEdVM+Tzi4JSnmOuvGWBsc8Xf6zo9nSmMtCto5tRVflaEKA37Slz5nugY4BFHbxhdIhXa4Lu2wm2L7njt30Fzp1vyRhkOvMTGv6b/ObYDPf8llvDckXsNFpNj9ZFSGI4lWwYNNlpvgfAYRTK8IMQxSvnhxd66CuW+yS3B6XUmrbS/o9yi5Xsg+T66HWOPoKIXNyfRPE+VJu82l4j4pn1JU43IOCO3CUxsJa3KcC8UiC9g0lYXl/aVThFrBUgj18VGvFDY8pa07/5ufSkYBztjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 19:51:24 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 19:51:23 +0000
Date: Wed, 18 Jun 2025 12:51:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@kernel.org>, "Chang S. Bae"
	<chang.seok.bae@intel.com>, Eric Biggers <ebiggers@google.com>, Rik van Riel
	<riel@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: Delay instruction pointer fixup until after
 after warning
Message-ID: <aFMYsfwyALoi_X_x@aschofie-mobl2.lan>
References: <20250618193313.17F0EF2E@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618193313.17F0EF2E@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: MN2PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:208:237::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: e975f829-c38b-4a15-6d0f-08ddaea18113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5nzUwGvwkTtz8+WgooNNBsF8rmxoPsRyYR6Vz4E+v/ATsmJumtvDidZMr9tV?=
 =?us-ascii?Q?kdDN6OnkrCtC0DJ7GuIVqhLkkoAYrJOwKIIu0QpR0itDjSb+NbGs5RRaUqsb?=
 =?us-ascii?Q?LIRrDSBJzP/H4P6SIgqmz4caPpZyQbmej3Pt0rYn/O7EDn9/haOmr6SHbJQl?=
 =?us-ascii?Q?E4QUvyZufXh7pUOiWIZ/WSKbj8bJHSpe5R503rq0aP4SEqpOxCD/jrEVipI+?=
 =?us-ascii?Q?hyHGNfBQ2sR7L31cbhipY/2Y9IqrLV3F8oO6AWpAMwxyc/hX7LrDs5X6oc6o?=
 =?us-ascii?Q?w73sweN6HkY11t9TJ2dxY7DD3TqEmq7WPeRJXgR8mxClgA57rGbCX7L9MXcw?=
 =?us-ascii?Q?JkJm+VAupc42lDDzzOy8bX1Bt/zPGYcOkl3kLurYlUSB8DbPWbA/GRYzfP4+?=
 =?us-ascii?Q?AlEL9AnYOm+t1L4MKG/oNchCSvTYmrkE6IMg2NN1fR6yGd5iP0XuThx2gjPj?=
 =?us-ascii?Q?iaqmZ29oDHcoEaM1TbaV+n0OkTXxM+JkYGgLi6oxkcHfldOKAQbcfETuTelL?=
 =?us-ascii?Q?YmEA3shLRLIvr2qMApm35Ere6TiBmQNJoBctn5XQi3cffaY9FCpvw0EaFee6?=
 =?us-ascii?Q?Z6SeI5/iXOb9GRAWspAHUKLW9T0XU7QG8dYLbAYF/qYhMiaiOpJcdIITYXe1?=
 =?us-ascii?Q?1DZW9mXYod/dnRb+P+0g0EY/YTXulqiFHhUQ9fJBqBOVpIHBkBcGI5zUF6bO?=
 =?us-ascii?Q?8VoF7uFn88EPsmkn6RrjsfOtFSUQrRs2hY7ifMKq5wydjn3OV/dJkFU48QEU?=
 =?us-ascii?Q?hGmCcGdmFenqMHRUepB7+o6dZC8mqfAQxZrwX5S36FoDp/SCdiuv97HYwrWd?=
 =?us-ascii?Q?cmCYpBHBYKhd2WTUSPfZ4MYldRFVUz8ZTJ758uRBFayH589t37G+iG2tW/9A?=
 =?us-ascii?Q?TCJ5UP9wwWf2sW6bmvAoJfUjsW6TmVsKBC10l3wi0tWU9qudabC6Tqsvq+6H?=
 =?us-ascii?Q?85Oolq2qGlEvxD6qM/aaHUecBHqN55iwVOdOZzfWC02jO0VwTsPBg2c4Y4F1?=
 =?us-ascii?Q?lxIwf2EmySH9yiQsVhPEsS1OX+8jVO3cihJX5E5PqW5HYFMWKjHtX+gE6iPX?=
 =?us-ascii?Q?G2gackmSUTTT2NpR2n1oDr07wI+8QCOEjUpRZ1fFp2jDq0ks8Jc+qObsiU2V?=
 =?us-ascii?Q?r2UUKxFOaFJ/mF1fISf5gf1p8Yev1/lduwmG75XAFEfizM5CBEHqJL5iNMAQ?=
 =?us-ascii?Q?0QTkl70k5xP1b9NloWL2/YnMgsQ+7iacp/HpoA7O3n9OyoW7GKCuXG/Btu4r?=
 =?us-ascii?Q?moHhLTXJxUArBwLd6MtwmXLG0cZ7Y8aQ5F8Y2luP5x7wXucAfHLkcPX2KmqX?=
 =?us-ascii?Q?IqkrTxkX4I2wHvwVfz6kFVJw1betPg+ssb5XiVPKoiY6dKnUdK9I7fCfcnti?=
 =?us-ascii?Q?WPXjmn4T1LKzYP9iPlTwtjz4PjiZqWnJCM12d1AC9e6heHoWu7cos7gYD/At?=
 =?us-ascii?Q?dHDxo/OWxE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUoL/V88jNlmxt9Xyg3aq0Vz+/IUA8ILwF4ptWyV360bOJQ3N5HGu93cOfsl?=
 =?us-ascii?Q?SfeiRvGJ4ptggJfF5MS/1icquZXOO7YJzddS2gGaWU564FKfv+zna0ucRSQA?=
 =?us-ascii?Q?0bt0GSG4Ryy8jUo9371ku5UyH+u1hXlTLCJlXmbqJzOp0FlEepFzxPKTjgYO?=
 =?us-ascii?Q?edpjk6INAfVkzvDHXph6EcEUS94kNVkek8EoE7MxDT/Lj/xT/NDWeBaO/nfn?=
 =?us-ascii?Q?g48+NEmA8XBeoM2BFnBbBp2RuCjiKABPBsupoSrTqdYKccqMF9Nb9mc+bdl2?=
 =?us-ascii?Q?CfDHplr6nAURJlkP5YHJYs0PQJKKIbU+OrS3spLt+am3NcuaAgUGFnUwMTb+?=
 =?us-ascii?Q?Ua7PTjcd+aAafNhNavcb9adPdu+kGgnyIRZaABN9NfXK8ZdJzy6la12CniVv?=
 =?us-ascii?Q?jIr6v8wd8saLxxd4lb8FsR+IcsHH0jWyr9vnAmXkfiO0hfXYJuJneMIYeWdz?=
 =?us-ascii?Q?qO9e94BIMebV//t09iW8KNwA0KvyuAANsLYSH4Ah17enp0Dh9aYIFnv5JW6E?=
 =?us-ascii?Q?5PwPT4zDM5CBervgutRpOGtC7aCdYU5FQFmYbrC/ny/FUkWCGucQIaBkQtyk?=
 =?us-ascii?Q?YZcJIpJHodZwWzaFZ9PhIs53Tm8B33pzmpqY/eJw1jLmdPz7qh+hxapFol6P?=
 =?us-ascii?Q?LkLwpyCUeyJB0Ve6Lq8DpFfSIsUwqsQa+9sOt53XzqySAA995H6ofLv/MP+H?=
 =?us-ascii?Q?9OXfcrmNrWCNJQw+BRW7lSdrTmI67WxXMQfPzjsCoQvtmzw53Ea+kFyWoSFn?=
 =?us-ascii?Q?osDzEwBsiV55XBedZe6+4FfTejWBxIkBShogmUMYQuFNeZrKKVKQ+uK0Dke6?=
 =?us-ascii?Q?MdsKJVVFnG9Sx3GvQFjxgtlgpGCuB4cD3wKlmgrNcj9t4FT7I+Hrs2BwZbSX?=
 =?us-ascii?Q?9aptXP7Hgm1bI5xrHm7hubl6PiAq5vbJkPhf3icIrml1K7iFFpdTWP7pWn1k?=
 =?us-ascii?Q?yI++FltpQwHMvwIntqiwpCT8tomU4GJ6INis4OUG/p9VUn8Mh4/y6o03+BKz?=
 =?us-ascii?Q?UZeoNKjQYO9SP1sTLN492EPZc8RnooQHYsIZVevGlff1+OHHOpwTasjI0mxP?=
 =?us-ascii?Q?EyoRNxIderH4f1qU4LxrIUxAR5L+T5Rt0CLnnjvOk3/JcXsyFTtGtg4n192t?=
 =?us-ascii?Q?/mxiM42Ik9GsjgJHkhGEvkH2ZvIayfAH8GFg4jmyZebs2W81s8f8JC2NKzra?=
 =?us-ascii?Q?h/FJv3UB4moy3LoSFzqH4Ie2X+Xk1GXm4DYkfygTOkZgrsYkXzj2qbAeJrJB?=
 =?us-ascii?Q?feih1FVZp4B/npcLNBdq9lGfJDnzMV97FGRGT4wnwW3l0ItqAiu0YehgcbD4?=
 =?us-ascii?Q?0JhgVvCPl4yat+WPnFS9WlgdFizMRVCAwfZ+gPtOWXWoNB+pY+KumSs2BZPh?=
 =?us-ascii?Q?VGM0dMmrJQ3oHsmmI89MhizxN2XLf+dgf5TxaXK8f6jLCWg9NnqO0NPiE6G+?=
 =?us-ascii?Q?j9BcljX4bHcFE/N9kb5JTRuFrUqOw6xgdo2QZSR0b1OIRew3Nhz5Iyvz49HR?=
 =?us-ascii?Q?i8BcnzGh1r0H7cw59lma/1PM9TbFv6a28ajfrSjRZOlXB4TyoF7fIL2+Q1uI?=
 =?us-ascii?Q?BIumWS1DEr0hvpHrA7QHLTRNtwpYbAikC38r3kLGz5T5c4uy0sgE21NdHMD+?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e975f829-c38b-4a15-6d0f-08ddaea18113
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:51:23.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXG4o3fEFE6jntihfp90VsM7Pk5CVKgVOM4dBpOE/EaGv2vhc74LYv58YUmThScKUeZOHuYUMTgOvq6WODNieBZchWlE3juphaxBprQvIxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 12:33:13PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>

In the subject line: s/after after/after

> 
> Right now, if XRSTOR fails a console message like this is be printed:
> 
> 	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.
> 
> However, the text location (...+0x9a in this case) is the instruction
> *AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
> also points one instruction late.
> 
> The reason is that the "fixup" moves RIP up to pass the bad XRSTOR
> and keep on running after returning from the #GP handler. But it
> does this fixup before warning.
> 
> The resulting warning output is nonsensical because it looks like
> e non-FPU-related instruction is #GP'ing.

s/e/the

> 
> Do not fix up RIP until after printing the warning.

How was this found and how is the change verified?
ie. do we have a mechanism for hitting this path easily?

With the grammar cleanups,
Acked-by: Alison Schofield <alison.schofield@intel.com>


> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
> Cc: stable@vger.kernel.org
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> 
>  b/arch/x86/mm/extable.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/mm/extable.c~fixup-fpu-gp-ip-later arch/x86/mm/extable.c
> --- a/arch/x86/mm/extable.c~fixup-fpu-gp-ip-later	2025-06-18 12:21:30.231719499 -0700
> +++ b/arch/x86/mm/extable.c	2025-06-18 12:25:53.979954060 -0700
> @@ -122,11 +122,11 @@ static bool ex_handler_sgx(const struct
>  static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
>  				 struct pt_regs *regs)
>  {
> -	regs->ip = ex_fixup_addr(fixup);
> -
>  	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
>  		  (void *)instruction_pointer(regs));
>  
> +	regs->ip = ex_fixup_addr(fixup);
> +
>  	fpu_reset_from_exception_fixup();
>  	return true;
>  }
> _

