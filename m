Return-Path: <stable+bounces-206213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C671D0005C
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 21:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E393015D1A
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3C329E6D;
	Wed,  7 Jan 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd/4SW65"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD13054EB
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818159; cv=fail; b=bkNYnQ3b+IFn8d5jIJEBAegZnwZund4lcL+kc7YnIvDieKJ8rhCJoTjiHilnRDDkcK8/292jRH7g/vk4OEPgQsTKE/QQkas8wFMgIuNDS7T+Yz9tKvoiaxE2C6eszpJHTYeiOJzcaPohrkea4RmhtaMMTaczzDYKg65foa42uRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818159; c=relaxed/simple;
	bh=f2PHOhgscuiU0VP+0OQ2ECTaG3iMpsBTe9FweuXzDUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PkFgz64eX9mPdC8sT2lSeeX1EEPVwoZickZ5cZtMbQbN4/GlKNYt02eRRBdqP3UBNfF2ofrt01OrtHLkFz7g3SvkVq9kQ7w3NogbNM/Smk/bvJbtevWuy6rqTw0ibCgxTMGuqPgWf+ydBjGLxeiRxt4kMc3kzeQIajcPteAW2Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd/4SW65; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767818157; x=1799354157;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=f2PHOhgscuiU0VP+0OQ2ECTaG3iMpsBTe9FweuXzDUk=;
  b=Sd/4SW65ivMj7ulFaUPYE56b+aOrvTsXTYxdU9EWviUeHjkNS3u4Eejr
   ErXam/H3EWaz76XJrjms63HPOrj3az2g/NauODt3lkZLQtrhPHJdihipc
   uE8blMD8aXEomV/FP9YmkA8H/gVkrdAcyXSUAu4sAtrNQXvP6LRvuk5T5
   MVhPGKxpXn/uTXgObvT+KM3Iy89JI609HIPSmpP8d53O/fC8HYT0Bxlk4
   +F1+ATXtfDMNgaNRPD3qgDRw6rKWrBwRKLYlVHtWyzio9lIObLCpHuxhP
   x91r/WFIW9QLoWK5l5rdmt9iFBy/vRJPWaSl7ygcyftJBJlCClftbSRC/
   g==;
X-CSE-ConnectionGUID: 5Vw0DYaQTbKwgqXbxspwIg==
X-CSE-MsgGUID: ttys5wlxSUSXYoFN76oWrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69272156"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69272156"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:35:55 -0800
X-CSE-ConnectionGUID: wW44xfVtTOOm+AQaCKAoCQ==
X-CSE-MsgGUID: 6DmQTRiCRhe5yIa37U/yqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203073007"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:35:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 12:35:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 12:35:54 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.25) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 12:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyzqwH2qkEOJ4dg25j35KkklXj5HJ5cMKliD/qk7ZRWnZAwRTv22RuSKgRVByjhamlcMApLFl8r0oiJOvJ9k6s9eExB1YwqRPYc0HKq4JZ032oIZovdokRhJBxrW56C5nyveI32BM9MNswd9r/Q343zSoFILf17VzQmmrfOyuJT65ETUgOu1pdehL55K6Dbi1iSe5yC7PapwZ45WMNLty7eg8Umj4HGKkIWJGTMovcb6438HvBJchy3B+/wfS2tCT5X781RXOZCUGdri+j2rUM6MAUw03pro8EsocMWp6W61bAIuJx7kpJ8teXtvWATjTbCxmReAybjX/2hRndl+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LrpBWIhEY8kF1IU7zcc/QKDLPlrPIrOBB41BK/LimQ=;
 b=O8P23A0rlKa7+pFN7hrfQBp7pd5aw3qe19uTJf1DSvcn2ApF1Z/tnDLTSP2kp1MAIemw2/lr8yzQlwnkMeSBsv1q/5AYo0VrgpPQt29TAbn3Lglt+K+NsqaMa3NjF5LEQ2kmy+Ir/T1qvPAbHEDypRehAg29bH/UwDt463F/KR56frMrmajDd4+VQWV/QCV3l13nl8vJoXKsu499cAAJrZsSK5JxnYwyN9foYGsssqvLq9QNrzx9pHsOXhxIng2FH76Da5n5UH8IHYbIJ/E0IJ8+yiuqzEgeJk3vttzeinbuOkekdWDLtIQ7yeBVasFcimhgXAGsiV6lt606sKY8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 20:35:43 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9456.015; Wed, 7 Jan 2026
 20:35:43 +0000
Date: Wed, 7 Jan 2026 12:35:40 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: "Summers, Stuart" <stuart.summers@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Alvi, Arselan"
	<arselan.alvi@intel.com>
Subject: Re: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting
 functions
Message-ID: <aV7DnC5WGHdAO4Nz@lstrano-desk.jf.intel.com>
References: <20260107002154.1934332-1-matthew.brost@intel.com>
 <b019bd43e7f71676e6ac2970253a073af45d8438.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b019bd43e7f71676e6ac2970253a073af45d8438.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0155.namprd05.prod.outlook.com
 (2603:10b6:a03:339::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA2PR11MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: f69b5350-54cc-43ee-527d-08de4e2c53ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5LQ41v83CoviSybdK2t1AX/FU1lDcxweT3CB7jfEx9k5m4yB94pXayqu+I?=
 =?iso-8859-1?Q?C4BZhuD820kYQL+5PT2LWF24mapPDawJAe5xwlmdveeZHxQ/ASlqZmF41+?=
 =?iso-8859-1?Q?kvOb5IZJSIPh+9DOdnOXUUecR1BxWAKzqR0dIjQJqKHTzXWgGp0DH7luwH?=
 =?iso-8859-1?Q?Ya86Yp95wE6OCpPvrX/IMFwxFBngBFCAmkuqP3IES39I4kYYtDkshRu6JJ?=
 =?iso-8859-1?Q?LgRpfkXv3pxNW/9pRLjG9ugZkfdyIkQYv5feyEIw3ZOXDXIeQ28O3fsghz?=
 =?iso-8859-1?Q?72fwp8tq/bypgLO/3q95a21JKkfv1yndBgy+KSyg1jXt/Ac48ti5EUz0xA?=
 =?iso-8859-1?Q?p4/YZ/EbSfVnuF/sl9b8wSbtjoVmuATGVzvuoNiYcyFJmPZg+Ol+J4XRx0?=
 =?iso-8859-1?Q?4vR2XAMTart2N5eFizk1vkKPuZq2DYx3LGQwPdktOxFTlm/dkDpvOFJwTq?=
 =?iso-8859-1?Q?45D2WPpcaXN5h8Ly0sSYdcyIkXC0xgWbG7q+0b78yjYfJSBvu2c79YkdiO?=
 =?iso-8859-1?Q?1u7QuuH9Q9dTeHyQQkeJsdGqdf4HvK+k8tB6y4lQZAuJwYcXet5f74d+IS?=
 =?iso-8859-1?Q?ujCvgvO08KQdXCvZLawC2FzKCDeYGs0+oFWFu8Xt7rVe4NraHA8NqcU9QX?=
 =?iso-8859-1?Q?D2eb2yAUEKHMMfs4ToNrTuDp8i0TNtYRGvoXUZvWlUO047Zp7DYFNCgoPv?=
 =?iso-8859-1?Q?385iRoS5924Gvc2YN5l9hYad786weG2AMMM9glvpt/JLwaG1qy4J/LVlmt?=
 =?iso-8859-1?Q?AyFGTDMr2PjI8ba2t8GzUIO2kqIyDjwurvSX9xhbNzeyhOAQDZKp27fjST?=
 =?iso-8859-1?Q?Szw4z1m8gH2BXDCKXYpoYaypvEOQKTbGdIidfkhoJFYrVsvdOQPhQm2SnE?=
 =?iso-8859-1?Q?ijxEPds4+zWHq6cDhQnrVv1J96YCFX15o36ZHVU4Q/xbfksL32gG3k+Vg1?=
 =?iso-8859-1?Q?hpEcmzLKElM8GFCdlViDLPVZBI6+4dpFpnAnzGAFTHgVJaHGyPLJaT3PC6?=
 =?iso-8859-1?Q?zRaNIBO5/uirm5w0+Y9z5Tb633yXA/2vGPXob/VcgWiM34KbJ5JMT3CCI6?=
 =?iso-8859-1?Q?DDZJ4UmLh3SXOs+IW+YPEfqEXfoq6OBynQg5WJEdcgZeRq3ECrNFGqHstq?=
 =?iso-8859-1?Q?yblnJmpfub+v5VjDnyIKqbeHXgnxlBnex5BgU1pQVB5umyHszBwbkOq3Gk?=
 =?iso-8859-1?Q?CdZ6o7J1nPZLRT4Sld42ENaGwJtvO+sVUczHGA6hjrHjiU2Gtv+LS7yj1+?=
 =?iso-8859-1?Q?atRT96bVvZDOWfi4bJ2/GMBQEwfoSnBXXHGXCMvTeY6ZhpAW2R5I2Dni0a?=
 =?iso-8859-1?Q?wzLr4elkVcZbqhVNDTpip+XgB5eWIODdIakUR6TeDwKTTadWcqFY4sTHST?=
 =?iso-8859-1?Q?UftHRh6aIu2U/z5qoafBPqosDYdZLGvMZk82QkfK37koJDHUxABC6zLbh6?=
 =?iso-8859-1?Q?dAkPe9yx3aUklMvlp6HHnp3yFyXdJdUCEhCJ8ax1Es7y4VtDqGzl5LaRlp?=
 =?iso-8859-1?Q?J40WKzsVgVX/OGoqKunIwj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?c5AJ1ONdMd8U9oLjgzJ1GVshwV8IO12V00Yd5MQDXlmCPSaHjctP+sGYA5?=
 =?iso-8859-1?Q?Z6Zk/ECVlHtpYvhMMt2bIuFPVYqMgSwab9bPPpc6idbhst+Ti/sMJLmluq?=
 =?iso-8859-1?Q?lUUInRFFjg0q8+jM9pBwyOXMQPH3/dKwxNNhIfELnw5qlr8ulxplHUXs80?=
 =?iso-8859-1?Q?45XheYjEW+ODknAdNDsjF+2CS2MTD0vnxDKsPBvhY2weGR87KU50pjPAYC?=
 =?iso-8859-1?Q?IQKzqWGsHZrZyZQj5NfrZC3nCg1NtheuQlcy/1oTm1HkV/gUswXqmuqfXO?=
 =?iso-8859-1?Q?DqMevrp9o13k94oyHq3498KkLYOYmJTZaGz9EWLgkuSBZO3nRmk+05eR1U?=
 =?iso-8859-1?Q?0yc8vFK/JZJAlBeTppdIq17/6aBY38aWllzq1QnPupPYI1aY4EG/PzeMff?=
 =?iso-8859-1?Q?odvDypO2G0Ay8SpxIjiahZ0mp6pqPxFRQG8i4E8JojFDy/LKuJud0OjN3W?=
 =?iso-8859-1?Q?iEtSHEcGjyb5qElnbxuPNxDTHFw/YkdJ/BoCnjKwRrThmTEa3N8Ud1lmXR?=
 =?iso-8859-1?Q?74AjN/EgwmqRPgohm9d6pLQiU+vaLKs0UuRIyxiMFrDGkYCpyB6SLABI4G?=
 =?iso-8859-1?Q?rQdARZlu6LSZiZjjMRcipLycM/SK971wf4n4ArxcsbfM0m7Av55SceWMbf?=
 =?iso-8859-1?Q?mDB+pvl8mgry3aGcV56Th/IqdwFih4pJZsLyFXAL4rS9Sx1N5f4pqJ3Phf?=
 =?iso-8859-1?Q?mjKrNEsCnmd3ajrbhphWl1jKFQBn+X7rttTrzjKnRLLZRIFQajMYbS2mJp?=
 =?iso-8859-1?Q?B6MIbTh+DxXUSDo5nPhGd06agFSBhW/oO8clDGPCIU5ohPjl77y0Q7u+31?=
 =?iso-8859-1?Q?IEHDByg/B9ZkhJVXsBwV24PjLk5HV7YHfYTr2AqXYo67tncyS1WxpigdgY?=
 =?iso-8859-1?Q?7OuFTcgEVD1lPqSKbQKxSEvyFUHz/4LHyIiZEKcw+lJZTp1Vt5kqTsSno+?=
 =?iso-8859-1?Q?KlpByAN5TNM/hkqtI+eGvkk6g3LeCnOneGx6q66Hjzct4gFCVjZmWQMssX?=
 =?iso-8859-1?Q?IfY0sn5CUxiP/3UW5xBunOonwRLTUuDJn1RbT9H4eMxcVrpmS1VRf+QNcR?=
 =?iso-8859-1?Q?tyCG2n7zWO/a7UyKQ57JKJXLWMX4PSJBvyeYWJGVGKkx4SmIbzIC7hPQIH?=
 =?iso-8859-1?Q?tyKLaKkH98jfLtzNP8Yo4AofmpF8wvcfO7U+Op4UOJ5EYIPCbVCS7QRTtv?=
 =?iso-8859-1?Q?ZQWc+rIF2sucAUx99itSifukh/xY6VV+Y56LX4Lmd3vop7gmKzxBjutBrU?=
 =?iso-8859-1?Q?uU258r0S2xKEWLwnJTeD4fNfx30+UMN38KRwMnYZ/2dt29p7dB8oYG5UZf?=
 =?iso-8859-1?Q?rCGamQGe5u68kIDmrgEMTOvLepafwETDlORiaEIwMgCVgQWIOeyh5dA2+0?=
 =?iso-8859-1?Q?RhiKVsVBA3jRbRDNWudixvYUqFCMY/PcMryRTqZi2x6ehb9GmxoBZjqyUO?=
 =?iso-8859-1?Q?vY3qsG+FoFr9TOFgYC0TV49cqy1l8sSMcQQexJyKCAzcZf08KtKXUFa22B?=
 =?iso-8859-1?Q?IldMGMBb214TNZjK1BNzEgloUPAec0felEmlVbR0aYMYVPFCH/+7oz5BN8?=
 =?iso-8859-1?Q?uEPL5zBcg+8aojWohkYQz3L0eh7Vk3UdlPT/4HH4JG0hOg6PpTS4waBtYT?=
 =?iso-8859-1?Q?J11UVc/CXZjAPq9wK/Kiu395kDi+miHqMfaCmoKQU4dERwAVmPb8WnAqcT?=
 =?iso-8859-1?Q?kGlH90xloCSqWenRPy8HIVecqNV0gw3e1o/i+Xddt6MKlnIeKswUIOEuvl?=
 =?iso-8859-1?Q?USX4kXSm2gYJ8gJ+Qg8TdHTk2jRNuxhuja/J7UD6x6RkC7LK+SI7ysdWUv?=
 =?iso-8859-1?Q?E8UM2eRSVIP/Cg+V/CLJfoc6gPnKgeU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f69b5350-54cc-43ee-527d-08de4e2c53ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 20:35:42.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RFy3vn1SRlYG7jq4BNDFC0OQTKDRx5WEmxjaeO9iv4mFQOFesb0ndyMLY+19foQs/BdhvNIt7+XsBUVOGli1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4874
X-OriginatorOrg: intel.com

On Wed, Jan 07, 2026 at 01:01:12PM -0700, Summers, Stuart wrote:
> On Tue, 2026-01-06 at 16:21 -0800, Matthew Brost wrote:
> > Page accounting can change via the shrinker without calling
> > xe_ttm_tt_unpopulate(), but those paths already update accounting
> > through the xe_ttm_tt_account_*() helpers.
> 
> I see this is getting also called through the xe_bo_pin/unpin functions
> with a check for ttm_tt_is_populated(). Does that mean after this
> change we'd get a double accounting in those cases?
> 

Ah, good catch. It would actually be the inverse of that - we'd not
account for pinned pages in global page counter. Let me fix this.

Matt

> Thanks,
> Stuart
> 
> > 
> > Move the page count tracepoints into xe_ttm_tt_account_add() and
> > xe_ttm_tt_account_subtract() so accounting updates are recorded
> > consistently, regardless of whether pages are populated, unpopulated,
> > or reclaimed via the shrinker.
> > 
> > This avoids missing page count updates and keeps global accounting
> > balanced across all TT lifecycle paths.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ce3d39fae3d3 ("drm/xe/bo: add GPU memory trace points")
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_bo.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 8b6474cd3eaf..33afaee38f48 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -432,6 +432,9 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
> >         return xe_tt->sg;
> >  }
> >  
> > +static void update_global_total_pages(struct ttm_device *ttm_dev,
> > +                                     long num_pages);
> > +
> >  /*
> >   * Account ttm pages against the device shrinker's shrinkable and
> >   * purgeable counts.
> > @@ -440,6 +443,7 @@ static void xe_ttm_tt_account_add(struct
> > xe_device *xe, struct ttm_tt *tt)
> >  {
> >         struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt,
> > ttm);
> >  
> > +       update_global_total_pages(&xe->ttm, tt->num_pages);
> >         if (xe_tt->purgeable)
> >                 xe_shrinker_mod_pages(xe->mem.shrinker, 0, tt-
> > >num_pages);
> >         else
> > @@ -450,6 +454,7 @@ static void xe_ttm_tt_account_subtract(struct
> > xe_device *xe, struct ttm_tt *tt)
> >  {
> >         struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt,
> > ttm);
> >  
> > +       update_global_total_pages(&xe->ttm, -(long)tt->num_pages);
> >         if (xe_tt->purgeable)
> >                 xe_shrinker_mod_pages(xe->mem.shrinker, 0, -(long)tt-
> > >num_pages);
> >         else
> > @@ -575,7 +580,6 @@ static int xe_ttm_tt_populate(struct ttm_device
> > *ttm_dev, struct ttm_tt *tt,
> >  
> >         xe_tt->purgeable = false;
> >         xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt);
> > -       update_global_total_pages(ttm_dev, tt->num_pages);
> >  
> >         return 0;
> >  }
> > @@ -592,7 +596,6 @@ static void xe_ttm_tt_unpopulate(struct
> > ttm_device *ttm_dev, struct ttm_tt *tt)
> >  
> >         ttm_pool_free(&ttm_dev->pool, tt);
> >         xe_ttm_tt_account_subtract(xe, tt);
> > -       update_global_total_pages(ttm_dev, -(long)tt->num_pages);
> >  }
> >  
> >  static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct
> > ttm_tt *tt)
> 

