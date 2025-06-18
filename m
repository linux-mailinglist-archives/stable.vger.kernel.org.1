Return-Path: <stable+bounces-154702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44644ADF69A
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32774A1D71
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EBA207A32;
	Wed, 18 Jun 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akTAvQTA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C8212B0C
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273609; cv=fail; b=VQnpLYCQRThHM4wEI0srRjln+hVNWFp/poMPvFE6yFzDdWMQUOoxiBBSOYA5IFVK5YrRyARb7nffLGF7U8jMstLDtsfH5rqBxWf2V40dRhF86nrQVEbVbHnVt1j3B7vL19P6SGmiMu8AdRB6ovbV63Y4S4ONW1rgFrHVUjM0owI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273609; c=relaxed/simple;
	bh=GXZZF6v3v1nnlXyqaKPtqofIni6sYI7d+jFsH+t2kV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJnxrlUKKnOFenU0QTXHkuUrrIyBGMMRD+CGQWnJytATrXszvjjXD3d6fHRu5BFVfCA1N3Zy3nmOgWp82KCgfMo/qNySGAphvX3/cUrX31/JBpk//GDptlX3dsHgqH/jafFvVoZCZS5e2ZdpkqhAPF7ky0w7KnFOHYR/l6vZijg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akTAvQTA; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750273608; x=1781809608;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GXZZF6v3v1nnlXyqaKPtqofIni6sYI7d+jFsH+t2kV4=;
  b=akTAvQTAJ3SSrrMAylQMMoNu+HfAOHmJVxLH2qD33SlfMFyxlvwTV3n2
   Jjgfk1xeww2/9xplS9E26mv+PB7QyFm5DXr/W53BhKbH4u7KhF6CoItQQ
   F0BSYfWbthbIQgrzdGkKcJD/7Q538yYDmCNBZ5XaqyOXbLGecKe1vYfgL
   nNFTGWDeEQItqAPfr83V7JBqtLlHLkykKQZW8es7jVEuAV93eAmnZ34uD
   gQJVybQtAL97q7sEEKa/eA/YuPtI2MC7mQ+L2mnSVU1PEHOxldQPLyarl
   3gDFooA8fryl5QFWFwnBToG7x0oFTzu46bw4gZ3iaiGr0EQHyxTNumUoF
   A==;
X-CSE-ConnectionGUID: /hPN3z+XQ82MGpZhB4arOg==
X-CSE-MsgGUID: RKqW0sTsTYWcHX4T//sSiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52486614"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52486614"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:06:48 -0700
X-CSE-ConnectionGUID: aQ7NPfUJTJSuzIPOdRDLjA==
X-CSE-MsgGUID: gGfe63THSQuWL+3Qc352yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="155544249"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:06:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 12:06:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 12:06:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 12:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBRkcurcRTVgxi92HKpjgbg0mDftgjTDnGEna0Ct7B2/5ReVBZQTHzVtiyMjwDUMruI6bYkK2OsRkWUBQLmvwlj437EOPo2nX0NvRmvz4GW5ZCBVAH0MorhPlSOevtNXhMGdkRqFWX8Kxj+MlVNQ7VHzU5faeFaUCGqqyDxtpGeJFzBBLWCr7g2umMZUGbiBlyKOdw0TNPyE2C+jEQtlUOgxCqhX5A7Dx1Bn2qYUSNhh80Nq7iFMzXrscQllJUNiHWWC4Mx6aKD90D3qR8zwO2Fk9LQTGjh26urvox5ivFVh1UtynecnykmW+/wm5ztD3NBeG4hkNR0ZBYYBsJdNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m3X/NgpNJw7Ju0Eq+LdhZpe3EP/PmA9F2q883KOyZQ=;
 b=K8VsQX4MrFQ93O7VfRHOWMHOD88kvsaDnbNjMJ1BK8Bfstz96y07rl3Ri072MgV6fgb1h2niG+fSchNViaxfyw5Qkka1FrubKU6222eAQfTrCqn8CUvonuYlOJB9fZNOiTI14RdJZ/cdnfrPN0IO3TuLkC6WOnN8HxLhM1qnCOmkehrmqWcUx16KJcNsQzaCF8k7TDtl1/cF9yLpm/4jBPjB3bUeSsfL7i75V/+19ThofmHXSSzX15key0dZdddROiFFPmvQXism1XUopfOOVw5eyj6I9vsc/rDCYDv0jxYiohIM749nxJE3oY/yJ2tqXSSZskDcF8ruDQJAiZsdFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 19:06:42 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 19:06:42 +0000
Date: Wed, 18 Jun 2025 14:06:39 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/xe: Move DSB l2 flush to a more sensible place
Message-ID: <mmey6jwpnnwamwrj2trxzpre7j4jswrhjsisuqvx6d6knjbuv4@ddc6co4xn7ec>
References: <20250606104546.1996818-3-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250606104546.1996818-3-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: a732334f-b885-4f7e-f796-08ddae9b4305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mCfOKYvqRXgvcrQATyfTabQ0ucMitf9aiL3Fxim1eRMbi3qN6xYMDHUGASxt?=
 =?us-ascii?Q?MSQcLNH21+SuJ3Ow8ctMNVJdJMc3zrK32RZWS+H/PmgiWP0r4YSbIaMhVJWf?=
 =?us-ascii?Q?+206totFrPc3TfTp6W8W3y5THMJK0PU7CAoWR5kJKlv+h4+nfNWzGyOSm1Py?=
 =?us-ascii?Q?gPHK8Q8Ip4UtaRqHicHp+J9U7sZwFlEXZvK4WwDMwpzLXKn0rp/oaGiQY3as?=
 =?us-ascii?Q?875OklOgI1tOqf7sveDKcVbZ+vowCqoVulXNH0YFoESpnhc54xBxntUtf4ZD?=
 =?us-ascii?Q?TKHa+giOyux6lhcNuzyu2GZ9Bw6B7IPPTjUXTDzAzZdjA+yLIBfCSrZOOqEW?=
 =?us-ascii?Q?bpCVrNR+e53L0Otb+k4LwTW6MztISE1yH0o1nqU5RK/TZ6MoS59UmBUqt7eU?=
 =?us-ascii?Q?8huX21kMaVxkYT/4Hq5bC5IXoJJoVVHkNY3je+CJ85oDaKCv6JI1LnVqyDK1?=
 =?us-ascii?Q?zsqNEKfCUqicvMJ1v/isBZ9VslpXdHHigeqJ2bOe0hfQyveKS6GuzrcUckCg?=
 =?us-ascii?Q?FMRR9MlRHCia6qaHeGhEV5sfepnD3MtMPNA0QCZbh27bJ5GINRCxXis56/mP?=
 =?us-ascii?Q?aPJselrazjv5fGSIQRrfaj2RnEshuBtjmntCO6iR+lHsYeUoitNdY8OGCzuz?=
 =?us-ascii?Q?s3dKDC/fzD6B1m49x6AWALNHq9Ncbs+seY1ecUbwWph2XVFl+UiEO4byBAIW?=
 =?us-ascii?Q?EC6sxKFyXm2udkkzAK5cahB3QCYXAkqao0hPq7OT38P3yQhVKit9LGdw+SwA?=
 =?us-ascii?Q?s5uURY62sqodktqYF3Qdpy0XO2ziJdSAc7YvThLxizj9OIR2bSKOJi9XDskC?=
 =?us-ascii?Q?Okt2KxLA3f+mHHdHaxYv4G+zzezVvvDLqLAl4bL4MfyTUkiSvf9WvJmpHPyG?=
 =?us-ascii?Q?JiCuX9E/FlEVqATHTO8DKpc7KfAHczaACoGS5KaQJ64+5vOK0xntyJAqlM++?=
 =?us-ascii?Q?Vr9AVONcDx+rjzYIAjy++5gkkgVBwHeI9n55EstcX3XJ70CUr0cGdmlQ7dVm?=
 =?us-ascii?Q?y5L1fGfcd2ohbhF5bM/9VsgRnVU/3THHgsInR2NpmM/65D/eaUvtCuTO1ki+?=
 =?us-ascii?Q?G1MSkiSlcOTMj2s0ulc0VeunfenuS2muIv0puCmdY23PeLIANVioBbp//zNI?=
 =?us-ascii?Q?62QDrsUIrRueDH+wHMrE1vHq9MPj2mJFKMWAixR69VMm29jxbiLwGxL4CKvn?=
 =?us-ascii?Q?kLZcas/x/nrLEAa9DBu0xieXX2XpT+fzJwvgZfpTfR+oJljBFLYn+EdRkZ3L?=
 =?us-ascii?Q?8vD6RVBrx645Y5c7Tr/9+XdfeG5R+WgYm1/1/sYFcZBYB906HQoJEk8fFERF?=
 =?us-ascii?Q?kigIDSIGT0mL+fUluy9DaoYU3cio7JA8G1sSLMpkoRVGqSKf2F3tKWder7cM?=
 =?us-ascii?Q?O8mDnjTuHzknWmWpKFpl72RLZxALPlfZ6nQXhlEfuJ3K3zYq9u4RmB41lI8B?=
 =?us-ascii?Q?VoMYMniptf0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5qaUHMHUbgzewm4GoLxC3p/2yqEg4GwBBzbv5dJeX7tM2yBFwglJWszE1Tj?=
 =?us-ascii?Q?f7La/ZylWm/7/jR9D9dnh6E34CJrjsDmeTWhCD2bM8qJmQBzHgoSbKnlKkWj?=
 =?us-ascii?Q?JL4QmOm7e+rXSEwPHvAOXKGiWQCzZnYQfBUPEC0SOEKB8kD6LokkLqqVCI2u?=
 =?us-ascii?Q?bocGyqcHUrD9DIakELhj7xjOlZD6MJPEnlzRGsecjnfXYEHMR9KvKt3uuGkx?=
 =?us-ascii?Q?M8SfcUbosguwBTtx/XG8NUk1Lz6EfbkCOO5X94pFGWyqHH1crDWG22ht/XuR?=
 =?us-ascii?Q?YfRYDQ9b0h7wO7iXgJguqjOEpbBMwF6lXV4zuQWT4TlPIwlkqb7rZudAl3IQ?=
 =?us-ascii?Q?PUTb1E2/yYKr7HeWllGCMhppr8HB2f4mardAr8laTw9yH3skCBgBZJceIWkY?=
 =?us-ascii?Q?Bk1uYYJXMQm/FEz8wz+41mwW8U9KLOVveXU1gl8O0J0qVc/dGcieX5HeHzpj?=
 =?us-ascii?Q?LM3r+KySYp90S4Wt8oJNm/PvM1fN6ul5I2+9RBsrg1dWD48gTfpEixGH1krl?=
 =?us-ascii?Q?U+tnpayQXD6/amwj4ab5hr3QVlQraMrbrbKOZ1AvKjIrhS7sFm+vO3IcFXQk?=
 =?us-ascii?Q?yvjy93cuSCYWFxA3Zb0P+/4khGcyK2OsCk0B9EjVpbXqx7KJwaMfwZnS9lo2?=
 =?us-ascii?Q?jBoVHfqY8WoHHfAvbqkNfrg4j4b6lW5CL5prdTenV2AuCxyLf9kBwcp251TU?=
 =?us-ascii?Q?H/oFlA7CLSDaDK8xjpYPTzGoXz+GTpSd8daBhUAq6rkDaZm86TvYm1kcsXXv?=
 =?us-ascii?Q?bcCfpI3VVdel5YFesATPHA3r+jYJJR47TzUE+KZD1pzlUW/Yimcbo4jP6QiU?=
 =?us-ascii?Q?7jEbYC4KHBSK1mrOtIPT9xha/I5G+E6GZ7NMaybIkj60Y9GIUvZzwTPWzim6?=
 =?us-ascii?Q?ON/UbJQumhe8NwBE0UWXuQOTT4vtKFUYBJp1AS0691i5z7Q/oiEr7phXBUu4?=
 =?us-ascii?Q?QZ7hkGXajlIqZA6SnmnNJWLLCOOymgSoMaXrb91D/vGA2clr9lbyLa6rVC+2?=
 =?us-ascii?Q?W3kAyj1fj7292xd1BofG/FaKOGknTMizLVHRTB9b0mrpTuC1Ta5mf2ggOsi5?=
 =?us-ascii?Q?KWz2yzZHtH7Fq0G4ujHSrsbfkWLIloT4bs1BfwkodT2Nv2nMxrDSJca/upyi?=
 =?us-ascii?Q?+TBJPTDy9v7davKO9fLsqAm5kIHTEkyXoJShFl0CWk3fXQQ5gKiAfzYDW4tA?=
 =?us-ascii?Q?LOc/7tKAs/fXbJxbUyH3hO1yauedVNc+8k/9IMwDT9lDrloKuHynuY+OmwI3?=
 =?us-ascii?Q?djvrio4bpDozZ0c4+U53FNOd7QL0Hze3H3CpFn1OQFW9QLUQw7KDMUUjAez8?=
 =?us-ascii?Q?9mUXtTnNRQJ4MDwcBmq5KeqOR8/O9U3AAI3Vnx5pI8LlgCIO9XxQq0ZCXUaf?=
 =?us-ascii?Q?9RS3EEg6zU5UNkttjCNPz1tREzLjtqxtKypL1pIAypSfTnfho4GwIkfexbpj?=
 =?us-ascii?Q?MZ8FJA5/PJGur3T+3/PWX4TUFxedwMD7tya69Ml14zj89UDNLEifNAgm3N7/?=
 =?us-ascii?Q?e4U8BoazqYxsU5vAHq9X2FFCjZctnLuK2xE+d+FH9S1qKd5OVlbJRBzQrO6W?=
 =?us-ascii?Q?RizJ8a3nz14sMpMQFpDNI/qm51zQCq5TlSEI+U1PMzC+2Lhlbf9mzgXuu9tG?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a732334f-b885-4f7e-f796-08ddae9b4305
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:06:42.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zl5cDAfZh2HJOLzT5WAF+bQbe3uZCTkGcLsvsh5KY0wlpiMqIx5KrVTXFu7NxIB3NrJ56nXAxn6n9MJJ27clspntVpiJg6oVtiKHWNMy2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-OriginatorOrg: intel.com

On Fri, Jun 06, 2025 at 11:45:47AM +0100, Matthew Auld wrote:
>From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>
>Flushing l2 is only needed after all data has been written.
>
>Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
>Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: <stable@vger.kernel.org> # v6.12+
>Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>---
> drivers/gpu/drm/xe/display/xe_dsb_buffer.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
>index f95375451e2f..9f941fc2e36b 100644
>--- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
>+++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
>@@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
>
> void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
> {
>-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
>-
> 	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
>-	xe_device_l2_flush(xe);
> }
>
> u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
>@@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
>
> void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
> {
>-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
>-
> 	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
>
> 	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
>-	xe_device_l2_flush(xe);
> }
>
> bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
>@@ -74,9 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
>
> void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)

assuming the calls to this function are already in the right place,

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

... but it seems quite fragile as we are exposing the other the
functions writing to it. Not something introduced here though.


Lucas De Marchi

> {
>+	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
>+
> 	/*
> 	 * The memory barrier here is to ensure coherency of DSB vs MMIO,
> 	 * both for weak ordering archs and discrete cards.
> 	 */
>-	xe_device_wmb(dsb_buf->vma->bo->tile->xe);
>+	xe_device_wmb(xe);
>+	xe_device_l2_flush(xe);
> }
>-- 
>2.49.0
>

