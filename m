Return-Path: <stable+bounces-164594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21793B10862
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A601CE56A3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1DE1FDA61;
	Thu, 24 Jul 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjCaWBH8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB631553A3;
	Thu, 24 Jul 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354899; cv=fail; b=WHJLk14PG3TdF1RglrAmntjb+5D6h8R4vBiKP+ZTexUHJacVCMjwLcy8ZuWsOaIFiLcgGElsBuQSh8C/aRjyH7cBdghOmAUkWQkswO+mmE+50YkWyZL+pEVpN9/bk8LIimWpzcgIa2rPvN8ENWaKwhik/jrCHGvh7pBdFASPpkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354899; c=relaxed/simple;
	bh=80c2Iy1r1NnqddTQGBHlY2WonNHDpcFNG4OTDMTOvfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1P+x8UyMIgItrcT34s9MlaXMg0m/zWCeRCxXxFQVYpfsyyGkmjiZowDWFU3grwED0KOtcJseLOnpuNRjp7sY0oXbD8UhHa8aJbNou/5AYp3EgxfrY49BiNu0xvS40mKmuBlgb+0dIUF5wgoFrvEMVcIYv4C8b/vs370F+GOu/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjCaWBH8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753354898; x=1784890898;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=80c2Iy1r1NnqddTQGBHlY2WonNHDpcFNG4OTDMTOvfQ=;
  b=TjCaWBH8NUn8Y+lG5Ouk2LkpXnAEveN0/ppYteJbg5fS0Vh013qlE2cw
   LURenXEln6kagTxeP2S1Dgwhw8QLTM5kCjWnavMWhW0qVJQ+QkCd8r7Uj
   4mfJWv21p9+LOI2rGWlMxuc8f8e299Laks5VFuU7qEWaIxAIJS5rqshLp
   0qNqZLecuWFlfk0Xsn9eSy8X8aiMgRWHpAG36kfzwpa7gRPqtOKvedzkN
   8I9JL7BTW9VGe5ooJmyCueMxOYaxpHaprs2XrWjUt5EOYJF3+cH/SREN+
   2pJxtczq6Wf/nRRNFafn+euf/PdFKA+J/1Ib/SahoohFzke9NbHyA0W+N
   w==;
X-CSE-ConnectionGUID: 3o+/ow+HQku7WeNe1jU98w==
X-CSE-MsgGUID: HYzTbKL5Ts6crKsZWYjnPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66227871"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="66227871"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:01:36 -0700
X-CSE-ConnectionGUID: inxFsjpCRkmqSihW80VoIA==
X-CSE-MsgGUID: r8mqUimMQR2PQDbAzy3QCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="165701663"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:01:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:01:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 04:01:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:01:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2HOp6h+xoSQB43IjdPHb4Tr6403sFTByswkfufDIaO6EWo+wydpCoOm2GwzzkMzO+04HPw28XKDhziEQkiYhZpysk4+bO13HtnsmGL8Og8OivogruRsak9nx2YItS4aiGbD4dnwUJFL9F7N3Ma9HXTiZgyg3hK2iTFTkuGD+cuKoRaWmDc2MQ00rth2CRyjWAbKzC9w4/ZUzamQmbRp+4Oqmsb6rBgxmV768jy1wcOG2WFm+opFkZ7okJj33c+xFZBUAXnAP4bTlkr0FYFG976NejW3+HlLkicD3GbnkAGdLbw72eHKQ/Beg53I/8SZhhCKbOHIxsSBdOho18z8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcWLi7d5x5YnXL6xSi41bbeuHPSatOfwPdDg/uSz4KE=;
 b=nIeD3Ng4Uu00xhBwnyh+o+REzWUNJoEYHFFiNvJPtIjxjKKV45jKSAPW0uZaNlLov/clD8+A1JYSJfqSrNpyOrS542HGwMGsLunxnkO/u6GRGgk2isuGgvjAlrxxtT77mPUyUBu31YqwF/otH80zIqHfsnMaB8YeVekqvXyKV6aJx8za5QsjndnlTgSJizGz3YLaJm4Ii7WotRQHz7WSuA9SIBtk9RSlPtXLST6II3k6g+g2Eqzd3B8L4vp0M6qnv/FeQBNkr1/J6NF6EGegIcfKb8hB1roYnqM+b6KvX9judYPBBpCNltABvr5PLrrrwgq9tS400dEO2gsOgyf9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by IA0PR11MB8335.namprd11.prod.outlook.com (2603:10b6:208:493::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 11:01:26 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 11:01:26 +0000
Date: Thu, 24 Jul 2025 13:01:19 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kyung Min Park
	<kyung.min.park@intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
	<xin3.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
	<stable@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
Message-ID: <iv5mxuijo6f4kuhwyvjwsl32bvv3jppy3ecbbkmh3nx3yhyupt@irecobb7gydu>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
 <7rugd7emqxsfq4jhfz47weezipfoskf43xslgzgwea2rvun7z6@3tdprstsluw4>
 <2025072459-emergency-slighting-9d60@gregkh>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025072459-emergency-slighting-9d60@gregkh>
X-ClientProxiedBy: DB8PR06CA0066.eurprd06.prod.outlook.com
 (2603:10a6:10:120::40) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|IA0PR11MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dd0668-c743-4af1-ce97-08ddcaa16f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?nG/g6MNrrQoFEZa2AlRd2XAsWGp/AeUlC++pYw+rlh2qKeBLdhF39/mwJc?=
 =?iso-8859-1?Q?IA77LwMl41MYi/oEFasYAbs5Hio9ccjwxWAxhSVkrgckYvNV2RAFYP8gRd?=
 =?iso-8859-1?Q?ScY+d4BPjmx5j34wK8ZU09S9aiwF5qMIuw/2CbQqzQPjh0Y3vIwJZyLrCr?=
 =?iso-8859-1?Q?NQ34PtGHB9Pvs9HpPJb69SEmpoDEqnb8miLVr8MTswrXyhj+T9WBY/2IBA?=
 =?iso-8859-1?Q?f0MSbaSh+7WKOZIssx6/79MAlPMR1Mpo6w/hWfDqgf70AFWKF6smk9yPin?=
 =?iso-8859-1?Q?oGcwWPz4GjlW3RvZBZzlMqmZinVXdmmhq7mtMWq8s08BcY/Wlpx8JSB5Ln?=
 =?iso-8859-1?Q?dmi2aNWy0Oouew1uUhLVbdaf+H9v73CBAt+84j4fKdlBEK30PCtx4Stx4k?=
 =?iso-8859-1?Q?UShxCtQLZGBGxQ/j1UxyukBzc0dVa+xJAb8+YxcxrWobnMQRJ/A1g1KRSM?=
 =?iso-8859-1?Q?KksyYTi3xNO3Chdik6uJrhuBsmiMNXEXfbRcIWDM/JHVtUoFPJvZFgNMxy?=
 =?iso-8859-1?Q?7tWFWpAYkyUhgvQm9AVBlE2UVFDZNy0lxcWuxWarDJs2EkEK1pppCsViQt?=
 =?iso-8859-1?Q?cQFqnucAG5WTYuRDIjiQXC/8L0upceHO853Okrd2XS1aSu4zdsWM4FL3qM?=
 =?iso-8859-1?Q?BMeqtjxLKxz8LxrUJ434Nq+xWsxwQS3CmLnximhyynV3R47EgxQMOPR4J1?=
 =?iso-8859-1?Q?ONFRFCMFBGXoAIMCu4uKj350gUYraHTcEaNbGmDN2WJZ8uaUW2lvyt9+sH?=
 =?iso-8859-1?Q?K3oDc1ephuWrM85vmDWTo9m0zrrYSf2VR6rMwM3gVHxTzETJmzt0sRN1lm?=
 =?iso-8859-1?Q?YEN1A1Sh7kz1V+tzJgUNviXqmuuPjtPAYZMy4lX3ptkdwfeHQ8/eFbTlas?=
 =?iso-8859-1?Q?tyG4XhDciC88qWuOz6LfR9TFVieW6DhbuWR7VZELe9d8u//AAj3q2cp7yx?=
 =?iso-8859-1?Q?a3tBY5+T6dES8D7/EV8DkvnpNELksJJsT96J7wipeKQd7Nf/UBsAt5bWwI?=
 =?iso-8859-1?Q?LLysN1Oa69TmzKOlzCXY7xfk5VfqG2CyKSNaOmQ9hXd5NVTiLBc/UngJxC?=
 =?iso-8859-1?Q?HO7OEkiUlIoSu/jD1r1YPt7NMVEudSDJ+Dzp4WE+x/RxxKyfIJJFht4si5?=
 =?iso-8859-1?Q?QojGpk2199DizB+gWUODvPdIE6f/NIsWCTrAZp1PGnPzxDgsQcZJh7E+6S?=
 =?iso-8859-1?Q?pVNCwsDYDNQ1q8TUplV5iFKRqU6J03PW4tOLm3sjcFrsd9nc1of4XMDhHs?=
 =?iso-8859-1?Q?+nARBdPoqll6QsGdjoqrNVubTNszDPd+8iBzE9URT6kk2NKn1bI0vaywPV?=
 =?iso-8859-1?Q?WmaKbMsC9owk9j2Jamq21ALhG6VOZNAC8xWg0wuuzOfRQKcyfWGFd0djux?=
 =?iso-8859-1?Q?o3bB6BcZag1qQO3Sb1+s9Kpg+xZ2Oscy5VYQS8Fm6nm8Mzzw98zHIxaaEP?=
 =?iso-8859-1?Q?44VzPMBcmkgXFhqtwAH9mgyW0SLa3GuQH7T1vcNAgvW0E/JE6e8pLA9ZWb?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8Ns/jeZF1a2svzSygiOJtarhY+vW71c9smv+/7L72zUfI4vyHZ/dbTeAnM?=
 =?iso-8859-1?Q?+dOyiA+yy0K0Q9NWkabpavtj4tjXfT01xc4SwzNSWjymKNUDG0lbp0Ja/5?=
 =?iso-8859-1?Q?VOP5QH8xIV3rhkiO6zz4U0I3e8ZaMwywVsHaqMTOcfxXTqCYqGQYFzLgwk?=
 =?iso-8859-1?Q?9jOjoH8IaAcbgQDTjtq2MM1Sblw0cHh7VKNSCs+SqhqPPf+Y+nkCS/MtG0?=
 =?iso-8859-1?Q?lnxdrGCtYkHpLc8dNNVUi7yvwIKngU6N8xqpuSHM9S35teggS24oyJklh2?=
 =?iso-8859-1?Q?v2QPMC/VXz/vWGsCbaCw+Bq1h60DbKEHrtopz4a8HcFE62E39mbkyR7ICC?=
 =?iso-8859-1?Q?2oJ9NQAijKNNhT0J5obyJubDARS+3OzCUhgtRVt1sQrAQ7H24+t2A1MdwJ?=
 =?iso-8859-1?Q?CIlrh9m729kXzMvesKuWsoA6I0AVnYDBHhbWAFsgSx8iieKdktGN3sgW+e?=
 =?iso-8859-1?Q?h2BTTAf24+mJn0JeRohK9Z/FZduTuNl2esGgtR0tYffZMrxizx1e9LUDbl?=
 =?iso-8859-1?Q?H+YVBHr5UlByYyYsDuWqfpQ/eAcKE6KmvPUHIMY0qFhzfFjhBTlBGxnuD1?=
 =?iso-8859-1?Q?N18TbDPaQc/eZUX4wPZ5orir0PNtG/Q6wgfg6jK7XECz/pO+Jlehh0MLg/?=
 =?iso-8859-1?Q?2cf9D03kcs0sxPxMgl/Bjr7yzwTNeOYXJmn5pcj43pplpD6OwN4iLe4PTQ?=
 =?iso-8859-1?Q?BkVVWT8Zp3VKRLUUgguL0EIOw97hFa/hXZjZB9D2CFPpCRQsrbhIg0j6uy?=
 =?iso-8859-1?Q?V62AVJOkydZPj2XZrSQkaK1n3Q9WvCBuJaCF0Psd4+P0ZwWaC+nlFPt+5k?=
 =?iso-8859-1?Q?w+VsS00fdz0iUmOWda+PmlXJM+od2xpbwinTPwywel2Q2Yf6NseFA5d5PG?=
 =?iso-8859-1?Q?ci/vwcsCntZiSi2LlSAhNp/XiycinY7lEN0A6cp4kNOwLWN9J6LjMCcfRz?=
 =?iso-8859-1?Q?nAtbE8QE+C21PipqVbfdxBIBVk1EBA21teS6hj0DnIsvRbUWJd2HCJbIeD?=
 =?iso-8859-1?Q?2GrteAvHF23xfiSJ6hDRSVGIU7ZO72ZwCXv2+MSCANQLJGh9tQpev5+lKl?=
 =?iso-8859-1?Q?ZAG/15UeByldNfMrfXYjO/oR7yeGa8wrTqba0tiz/lvZkraiTCdvqEgnBh?=
 =?iso-8859-1?Q?Fksgt+evldvlxP6t3Ab8pAR2OUyVilVIZnwOa1WVnoD+E49AVY+7gQ5ebV?=
 =?iso-8859-1?Q?6N53L7oRMXz5dX5pqJlO/AA7y0ahjRR3EZ4IezsByUQwdNn65Ali+38IAS?=
 =?iso-8859-1?Q?XCyKcUZteBk73PW7DEJ73xZuxgkEyQvJaKTPINnwHtyF5YDKEOoeIyXzM0?=
 =?iso-8859-1?Q?yrfnA2jsXNHwcC2rS9DV1NtrAVyK6frqAw+iFA7OBMdCeqcm4EL/oXOQ4F?=
 =?iso-8859-1?Q?kfWmPyk8x+xHo+J/PKWVqiflS1Jc+91mTxyGSmyUTAJSqldTmML3UVy9lE?=
 =?iso-8859-1?Q?qzNLFFuSpTf8B2rnXJiw4AfuxhzMylYKFdx7oRBKuf7ONxPPxJj9IOd9Lu?=
 =?iso-8859-1?Q?w8Z22dy/ssgtnW/U9lMBNPrSjSUGFdwb98dcnmHZbeG9MdRKclkNEO4JY+?=
 =?iso-8859-1?Q?7A6XkgckVFj8XlRZdQzDWAhgLuMWepRza+VMXvWkQv+8qhGlR06kzYt7V/?=
 =?iso-8859-1?Q?xBWQkXfD69FhNej5sWpIdnFpnwaGooOlRLaoheFYta/ooktAeZYfwj2mnL?=
 =?iso-8859-1?Q?6+qwTbiOmEDv/WRieK0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dd0668-c743-4af1-ce97-08ddcaa16f32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 11:01:26.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+hNcvS88WkpQ0G8LD4oAEzOxvBDWvw6v9d/ma/YxYK9K1Z18iC79X2z7UG02IfymYQ+2CMjPlYOJ/oY8OdGRw9CyJPECah/t0OuFpova64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8335
X-OriginatorOrg: intel.com

On 2025-07-24 at 12:34:38 +0200, Greg KH wrote:
>On Thu, Jul 24, 2025 at 12:13:25PM +0200, Maciej Wieczor-Retman wrote:
>> Hello Greg,
>> 
>> I'd like to ask you for guidence on how to proceed with backporting this change
>> to the 5.10 stable kernel and newer ones.
>
>Don't worry about it UNTIL your patch lands in Linus's tree.  Then, if
>it doesn't apply to a specific stable branch, just send us a working
>backport.  Not too complex :)
>
>thanks,
>
>greg k-h

Thank you :)

-- 
Kind regards
Maciej Wieczór-Retman

