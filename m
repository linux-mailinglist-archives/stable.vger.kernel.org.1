Return-Path: <stable+bounces-139254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072EAA5873
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 01:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF7216B6D7
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D254226CFE;
	Wed, 30 Apr 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAMJHOOy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C706221271
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746054256; cv=fail; b=JxAT78VQtPZ4FqKlsPfj/+g9EDIgcBTQgZzxIcgQ45D96QEluyeAtMPiO4h9suIoOel441ZuS3tKgn6WCjwSqeVGxugzK6zlMRsEulKutGcPQoMKtx9hxWE8UdDD68q5gT7XIYFrhyKA1vPPDwldhOymV5Gp2pBS7tljfCcrygQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746054256; c=relaxed/simple;
	bh=JQvEAtMTPuT423H3RzUv5mg73YhcIMGuV+oRjcSYwJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G1W06sGbucI+Awwz+Pbn+icwL2KTIPcScYMOH2XnCB/6vhFWN9uJRAW4sewnFlT9x8JQYNHUIH0lhPjMgtmW4KuU2sMFu0ZzC9i3q2DqzS90hvt0woyfuq6LwpTNdgjiLjKbdXDb+47wQYEuvSVchCAsvnebyls9YIh2V/Lgxus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAMJHOOy; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746054255; x=1777590255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JQvEAtMTPuT423H3RzUv5mg73YhcIMGuV+oRjcSYwJI=;
  b=hAMJHOOyiy8vuPTufa/04IMT2pNQQrYbIgjU10vTymiB/ia4+6krEYbd
   W0pLhodMJh010RI07Xjq+x+iZdO86oq9mvsFXyd1T1L6PYDD3sc+fQjxl
   wWiS2rbTx/Uf5Ibl/Eer1TJu2+cMrM/WZoG3iXtUh7sCmz75JO6AA6L1Z
   SWJatKC6MDdpp7vu0c4liw3gvzUKCwvF3AfaJZ1cHIkSVcgigciPG8wGd
   mw8fqrCQEjVjIgeu2wvnyUYkWfAMw8QLrfNnmRuj75eq4BFgctHP8cjb+
   ZFSkih/F0swtl8XBJvrIe/hVfdbTO68J89ceI8SfcYFucyjJMDsCLhdtp
   Q==;
X-CSE-ConnectionGUID: lYVrgewDQRyAqnKqezDJbw==
X-CSE-MsgGUID: 1/GkYImXQ36ejIYMiVQIJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51397550"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51397550"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:04:02 -0700
X-CSE-ConnectionGUID: WV5S7zikSs6YxU4P1j4UQg==
X-CSE-MsgGUID: vN8nNmjnSo6b6zSmk1cttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="139425195"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:04:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 16:04:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 16:04:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 16:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C17yTU7KNhqU1EnxsgUWCCzBy9oS3W6x9gUUbVHW/EU7IkRL6f1SnND/IMriR68mL7gvQ7AOcwOzYbqADB5tVCoi1+K4R+1ouwgFuwXdJO1yCuys84k2ZIWFGcNI9Dc/7ZwD1jxx5SR2LQxRdwRwsiavEVSJ+0ILGNnhOgFPXwTLUUHtVB9G9S3aVXcaqyc2uOHaGsurszH6ohh2AV5231LPgqQsv6K5+2X+WMYhjspOOV++q4OM6Fq4lUbIztc7/TSbDvKMnXwuqrTIUO1i5MQuKBhvMKbAW92AQo+gJW/wMIjXA9BiBcujC3URxN78l7sdR1hn0Dp5TLd5zOOZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgMWFs9LCqLJwbbN7FKvF44pZIFo/NmzzrDh0LYX1cc=;
 b=J/7ZEueZNmU01BYhZMQR+YWpQMdxmFxKOjoP1eX0RolVm8V1vJ4MFcGLuuNTEyr9JWxdElNaYa3KWC2/wtUOtJjlWdRZBlSW+viq5vklpL3T+ULwoqOOkbJR9ofyWTB120xpCjC5FKPWui/W87pwOSq5SQvJgb605lnPjwStuOYjMZvdVGI/Oo4a6x1uQ1/aLBECfA/ma4tr3huUfPoONRLhc2bbXMb9JxynAGyn6ygUY//ZGmeyhH3MK5eW/6mDVRIuwq9c4osKB9yX4VJraru0PT6o2eedYT8/xL4CqunHOjRFSXDs4VCpM514LhffKXm8CDF8+Fl6U83PTfSkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 23:03:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 23:03:58 +0000
Date: Wed, 30 Apr 2025 16:03:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Kirill Shutemov
	<kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Vishal
 Annapurve" <vannapurve@google.com>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v5] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <6812ac5a4d8b2_10d8f62942d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250430024622.1134277-1-dan.j.williams@intel.com>
 <20250430024622.1134277-3-dan.j.williams@intel.com>
 <2025043025-cathouse-headlamp-7bde@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2025043025-cathouse-headlamp-7bde@gregkh>
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad4cda7-24c4-4121-934f-08dd883b49e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AHmmtEcHPsnVIbP4Qo08bNzJTN1QEXnIDD2dXeCXpbfyjg3GEwP8CmGd64yV?=
 =?us-ascii?Q?/L6np5jmwzigBYf66FGnuYehN42+8NFdcbIbby/M/59CgPvXqglNDj5h3Mu6?=
 =?us-ascii?Q?Qb50tRliFZhaRLo6wRijrcXxoSiHpa9Z000fpEI+Qh9VeAG8vV32RyrItJga?=
 =?us-ascii?Q?s1VCgBt1xRt1npErmYrlRYATr6TspMKMnc+4VffVG6p7KeVB2VXeeQB6xYPy?=
 =?us-ascii?Q?KGWHr1QyJMLa3UX3tlnPIIMQPY/NNbqJZA6pj2vHskvmeSyBMGhSG1zTabZ0?=
 =?us-ascii?Q?NiSh9s4GZ7EgPxV20OJX4bgoNVWUCq2363hgm2A4tmbSrmDwjM5kFcYP1L5S?=
 =?us-ascii?Q?ShpuBID8RP7Ny+Yo5dJgQ1jH/9n6XkVKk/Xjt7p/eB0oX2Zx3kr5GLO8Kc0R?=
 =?us-ascii?Q?nthjJQdJw6n1WDLvrl+mFEofhZRjVpXTYK5NJmppkIqVhkmKI//HbP0dptAG?=
 =?us-ascii?Q?x+Sv5MWKf7NsNgOtYN+J+pSrS3J6cVxhzkxCTmZabfriOoUKIRG028Mcsp1P?=
 =?us-ascii?Q?KAD6n+iaLD+ksqu8o6+A3TyStFzFsvdKKqAOSYj+Lhb/0yHPvsCn6SeEDbY8?=
 =?us-ascii?Q?DyqrlgZvsfnNy+5ykaOWwxTshAMPmvXCCKltpvmJRcZBIzRdFrnitFl+yoaE?=
 =?us-ascii?Q?cD0FDtrni4K4KfxMJZ18ztO6o+foPnhranWh1GHj2BZdNYq0+lDg1utueRVk?=
 =?us-ascii?Q?wGLaVLl0yvk5b4K3mR3ye4WYSUitYF56l+ZZsUZzsjjk/o5ptZEI4efQSBKu?=
 =?us-ascii?Q?RL3sd3BlHkrttBM1GztH93zqdtYDxpw+JaV2cbi1UUKMvHI7AdfnDmxPrt1F?=
 =?us-ascii?Q?7ilft3/R1/rpcKBDTEODeX3YOfj8xMvCrlRf+yVIZG9m8H703dzE64+Agy3X?=
 =?us-ascii?Q?oaISBqHhoDN52HFguV26jSFxYpXaRaz659ophPMnatLuoJ2eg+R9XxH/V6iK?=
 =?us-ascii?Q?EtKovwRGxtn5es9gJKI65eDLoDr+n7qRgU/4+NfZZpUje54mIDVqsPtpj8EN?=
 =?us-ascii?Q?tw3m1OTF+6z00K70dGuwRMcTFzXxQhqM9lnZ92rpq23tF015d+WXE6dAxuzI?=
 =?us-ascii?Q?K0DQ4SI8jsS+7iZcCLpERYQHNDPimyH5/QkzF/bNQNmRjG+rm58g9+j9P4Gs?=
 =?us-ascii?Q?W7IyQvpKP6bn4Yymk9QdLQ9ryN9OSJ6PKISrptSWpJOpF3V1hGg+j/QLyaWd?=
 =?us-ascii?Q?mcW91masuJ2F2EOLw9P/tUGcMqDSsLlrlTu+6nZdbyS9UjfzWnPT2xvzWLIe?=
 =?us-ascii?Q?t+WKp3TrjCBvheJ6Cu3+LXvz5GWcNJ6zVh3S5g1xLyXtcHj078pqIcM2Qunu?=
 =?us-ascii?Q?0D+bh6VoQu0RIU7NxKMafIUrEvPCjZzOQ/xXH1K8+8CWmuCBEUBpiyjf/nvm?=
 =?us-ascii?Q?b8StqZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8SMK1y6Z7NZp+rbFOnwrvAhY6nbnBR3rW8t5MH391HG1iexFUG6v5L79JGB?=
 =?us-ascii?Q?2jkIvamsnX54KgCWRJw9h7zrpGWFhhO7rwBnOcxP/PtqsYwXmsf8d+JYMTzW?=
 =?us-ascii?Q?Jv1sGaSFF8tVnoevTna8Zaqmn0YXzcKKvxtjA5TeubPHSA66OFcbjGYlewAy?=
 =?us-ascii?Q?sFShbkGwqdxTJHKD6t0MPFHGRUYZDsHO2gn6dNMQg2soP+ZiwEuufmSB3Exv?=
 =?us-ascii?Q?27cHiI/2wxJHY1aY01CLpe3D3hcllsLu+1syzRVyuvD0T33Vf0N2ccu8Brek?=
 =?us-ascii?Q?/yl6CXxAY9fT4l+Orz9ELKTQdZXN3dwNOdDanfy6GjNZXwSU2104jWS55k82?=
 =?us-ascii?Q?4/tS6V9cn2BTWf3nFQjEAXEDKzPk5yXh7d1FjVsJzC1G4Ml0yupch0BPBsSN?=
 =?us-ascii?Q?ofY/gJZQaMiIrN8tqpULvZNIe10oyFUlYogC/xRVhxnXkPhlvUUKd4esViZ/?=
 =?us-ascii?Q?U4ZFCX1hK8vw/7S//rcuJGaoLeetPH3EfWY5td8eBI2cuYa6B93qnHuvWDNN?=
 =?us-ascii?Q?gop5MkwGw1+L4IEOFIdvQ29181JpPv6/JHK6Pgwi+dnG5ZEj49lsftjWFjig?=
 =?us-ascii?Q?RUgvlt4wTes/B8MY2RJm1uD0cVPQSklJ3JD5v0WEl0Y2nHinTLdkyfi+c8sQ?=
 =?us-ascii?Q?hj60r7YUzXocDhhysiLuanoaq51TV8Sxd8AYK6u0IUKcUDixklryZZS58f26?=
 =?us-ascii?Q?srdjaeWRhN4WdB5Z0lPJnnKhDr52rPxsPTi132QHe/Nr/8kQRSsDTPKwgeaX?=
 =?us-ascii?Q?c6l0++kGV8Vr9tCp2NQTZXnvySdSw8xZKckShJTjpW/P9226aybtM++OQiPT?=
 =?us-ascii?Q?jEyG7XS5vRwd374zOCYRcVsKdrYAyBnGF0uLdX2MAU2FlzNiVMq0lusED+pr?=
 =?us-ascii?Q?AHBqtuCh8Ukb60k9Z+7Af5LusyJaTYsTtGJbLDRaS9ZNW38QvSyEwIeYX1bn?=
 =?us-ascii?Q?elmuhdw9r3Ew76+SHKiVofzkHhJalcuov8Ezxu4XjE9N2DQJaYdReRod3fUC?=
 =?us-ascii?Q?nlTzCn+7c51FKioT/Sa61mJULDCY9pi17Ip1A8SOqt8PEPYS+oJcENZZ5Gs/?=
 =?us-ascii?Q?pr4MSIwMdDr4eTrLzmKqiMTVv879YagraQJPpPAae7WtQOqI4gaQAqYiBbrG?=
 =?us-ascii?Q?GvZLKZarasHFh6yd9ob/CvZpTSGx5VDoA1sC7vuI2ihryi5bTzbrbIpLcni/?=
 =?us-ascii?Q?9aKVZt5xzA5XWTtw3CTFhcY6gXPJJ5a9wPBx2U1L/KD3V4YPXtyNprfVN+9/?=
 =?us-ascii?Q?bbsyQuNjhF39q9AnjlQy/GlOtHy69ac7HY/Lx/u8HBfT/CrXIqKOEiA7zyac?=
 =?us-ascii?Q?ApD77aT64laL1S1T5X/QaSI9yR+HBfiDKycSu7gBP3ealS6hzTPvy10N+LBC?=
 =?us-ascii?Q?jjx/I/a2D+VavtS5cpZxDMQRGie9+/80fMmYzQz+7b6OCcuPcaFjvJm3w71G?=
 =?us-ascii?Q?0u7HI+Bg8zXs5v7u8U61uf1Jzz5CWhCPM4O0yHF3I0LBzIOJ8a32D7SP7vUW?=
 =?us-ascii?Q?oaL/eCOj2pEUHICd2cj7UxXOODaapRs+aWbr8AAi2s1YCZciUVfWTAdU62TM?=
 =?us-ascii?Q?PFM9IJRsZzBYf+48VIt7UCLHxBx36RUe4a+FS+qT6UmF3XIxHgGJNjUpnEsT?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad4cda7-24c4-4121-934f-08dd883b49e3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 23:03:58.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGq0SPYjuGcbm0snJriBi3cZMzYiKZO/fCwzvR2dUxPiSC2/sxzOpekZBRMbQE8Kvi0TE7gmKYiRb2EB7Q+fjs1kJVpJosFiq96YqlPCtzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> On Tue, Apr 29, 2025 at 07:46:22PM -0700, Dan Williams wrote:
> > Nikolay reports that accessing BIOS data (first 1MB of the physical
> > address space) via /dev/mem results in a "crash" / terminated VM
> > (unhandled SEPT violation). See report [1] for details.
> > 
> > The cause is ioremap() (via xlate_dev_mem_ptr()) establishes an
> > unencrypted mapping where the kernel had established an encrypted
> > mapping previously. The CPU enforces mapping consistency with a fault
> > upon detecting a mismatch. A similar situation arises with devmem access
> > to "unaccepted" confidential memory. In summary, it is fraught to allow
> > uncoordinated userspace mapping of confidential memory.
> > 
> > While there is an existing mitigation to simulate and redirect access to
> > the BIOS data area with STRICT_DEVMEM=y, it is insufficient.
> > Specifically, STRICT_DEVMEM=y traps read(2) access to the BIOS data
> > area, and returns a zeroed buffer.  However, it turns out the kernel
> > fails to enforce the same via mmap(2), and a direct mapping is
> > established. This is a hole, and unfortunately userspace has learned to
> > exploit it [2].
> > 
> > This means the kernel either needs: a mechanism to ensure consistent
> > plus accepted "encrypted" mappings of this /dev/mem mmap() hole, close
> > the hole by mapping the zero page in the mmap(2) path, block only BIOS
> > data access and let typical STRICT_DEVMEM protect the rest, or disable
> > /dev/mem altogether.
> > 
> > The simplest option for now is arrange for /dev/mem to always behave as
> > if lockdown is enabled for confidential guests. Require confidential
> > guest userspace to jettison legacy dependencies on /dev/mem similar to
> > how other legacy mechanisms are jettisoned for confidential operation.
> > Recall that modern methods for BIOS data access are available like
> > /sys/firmware/dmi/tables.
> > 
> > Now, this begs the question what to do with PCI sysfs which allows
> > userspace mappings of confidential MMIO with similar mapping consistency
> > and acceptance expectations? Here, the existing mitigation of
> > IO_STRICT_DEVMEM is likely sufficient. The kernel is expected to use
> > request_mem_region() when toggling the state of MMIO. With
> > IO_STRICT_DEVMEM that enforces kernel-exclusive access until
> > release_mem_region(), i.e. mapping conflicts are prevented.
> > 
> > Cc: <x86@kernel.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Link: https://sources.debian.org/src/libdebian-installer/0.125/src/system/subarch-x86-linux.c/?hl=113#L93 [2]
> > Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> > Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
> > Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
> > Cc: <stable@vger.kernel.org>
> > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/Kconfig   |  4 ++++
> >  drivers/char/mem.c | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 4b9f378e05f6..36f11aad1ae5 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -891,6 +891,8 @@ config INTEL_TDX_GUEST
> >  	depends on X86_X2APIC
> >  	depends on EFI_STUB
> >  	depends on PARAVIRT
> > +	select STRICT_DEVMEM
> > +	select IO_STRICT_DEVMEM
> >  	select ARCH_HAS_CC_PLATFORM
> >  	select X86_MEM_ENCRYPT
> >  	select X86_MCE
> > @@ -1510,6 +1512,8 @@ config AMD_MEM_ENCRYPT
> >  	bool "AMD Secure Memory Encryption (SME) support"
> >  	depends on X86_64 && CPU_SUP_AMD
> >  	depends on EFI_STUB
> > +	select STRICT_DEVMEM
> > +	select IO_STRICT_DEVMEM
> >  	select DMA_COHERENT_POOL
> >  	select ARCH_USE_MEMREMAP_PROT
> >  	select INSTRUCTION_DECODER
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 48839958b0b1..47729606b817 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/security.h>
> > +#include <linux/cc_platform.h>
> >  
> >  #define DEVMEM_MINOR	1
> >  #define DEVPORT_MINOR	4
> > @@ -595,6 +596,15 @@ static int open_port(struct inode *inode, struct file *filp)
> >  	if (rc)
> >  		return rc;
> >  
> > +	/*
> > +	 * Enforce encrypted mapping consistency and avoid unaccepted
> > +	 * memory conflicts, "lockdown" /dev/mem for confidential
> > +	 * guests.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
> > +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +		return -EPERM;
> 
> I hate to ask, but why not force the whole "confidential computing"
> stuff to enable IO_STRICT_DEVMEM as well?  I don't see why you would
> want a cc guest raw access to devmem, do you?

This patch at least forces it for x86 CC guests. I was not quite ready
to say any platform that has "select ARCH_HAS_CC_PLATFORM" should get
the same treatment. At the same time, no strong reason *not* to do that.

> You kind of mention it above in the last paragraph, but forcing that on
> for these guests feels like the best, and simplest, solution overall as
> the number of different "is this secure, no really is this secure, no
> what about this option" chain of tests that we have in this driver is
> getting kind of silly.

True, and this matches what Arnd is saying.

> OR, why not just force all cc guests to enable a security module that
> implements this for them?  :)

Let me take a look at that option as that seems to be where Arnd's
questions are leading me as well.

