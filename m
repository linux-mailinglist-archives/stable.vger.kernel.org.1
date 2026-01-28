Return-Path: <stable+bounces-211923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHWcMByFeWnGxQEAu9opvQ
	(envelope-from <stable+bounces-211923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 04:40:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C26129CC94
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 04:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57DB13008785
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98522327A3;
	Wed, 28 Jan 2026 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZddpGvWK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0A32F746
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571552; cv=fail; b=SNKuRqJCHjK47RccvZeaNRLftbEuvN2+z6bNNAtjBOAZc69FjAIK7VQcMTRsOHjMcVNfMIMgiS+nKApxgyjHehJxHyKcQ828nds1Su8EEME7d0liY/SbqGTJXWrnIbOAbFcVT6KWRAAweyFg4NsLpqotj4aa1mFZ7ioR2obVVlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571552; c=relaxed/simple;
	bh=AJTIqXBdsRRdRqyMhUNmDgjZtsixJhrqu3dG8rtVYvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LvRfi1NSBAfRtkKqiOkiO7vmlgk0cAaDPzSh0q4bt33ZA281OU7OZdeRouev3/cq2q2lCkxt87FWwU8cD5inHqMr6x9COeh80PXoPw1jnSYOPWuKHuGO+UvYdiY11+i4TeoY/A+tETrYe5brIQTvn1loK/sknMsDmiIqvELbqVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZddpGvWK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769571551; x=1801107551;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AJTIqXBdsRRdRqyMhUNmDgjZtsixJhrqu3dG8rtVYvI=;
  b=ZddpGvWKwX9lL3a6PbObkbDrnoXoZ2xWBeO3ktpJKpVOBHOhrjnIqYJz
   6AnocHouev6FPG/3LHHPEZEwQPnvnHwIJ/FLnpJnVArALzN2LQfbRGFLS
   Wc/+o57ZCki8ddA/g0fPqejJeOuMmuJ0x7EFHiu493J8cKuHvE9rddge9
   0SpLD3hjUgMsxgB7K91FjhY3PScoee3u27GpEx4jTPCKc7x+yZE0ZlPit
   fpKBjEZH5iOf7O+ME8ZglCyQ1I9qYsDtRzWRgjaEKQWa49Nx+b2IIHQy3
   t78B0BjMeFjOL4/Ii5QjiNB7jnhZJR0dGgpwtDlXQMBIEtklEUKMlbap1
   g==;
X-CSE-ConnectionGUID: JgOYzTaIRbGR7DOpj6fuSQ==
X-CSE-MsgGUID: ENavOtDjQ/aaYPHv8rTtuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81887390"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81887390"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 19:39:09 -0800
X-CSE-ConnectionGUID: BPJgQh4JRNG2gWvf41fvEQ==
X-CSE-MsgGUID: ZPRavc8hRpyi5yAxuIBCEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207394463"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 19:39:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 19:39:08 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 19:39:08 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 19:39:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0180HYPdyDz7V1mLHJcpZIz7t0v7uEnFU/bdZy+rh2gDsqIm92qWBk7EyqEQBwzF09trsWcLiPbKNbsRzjLmIc1ReBbuc/fwps+W4RW87qOJXPY1jI3JJfY4ZfbYo2bnsTw5/LgItSDITjE7M8S1oQpTSu2/MI7y+0ob80ChTH6qk1wHS5acTYze3SrhrlX9/txD7Bn0u5iWwtNREN9iw4UMJ3qRjS6ISoOUy/JwGtox4N6Bnmui14DW9XJegoRBTd313sLT1wq6nG49j4JiBjr4Jvup0JnO4RZuYh7EjQz739tnC7VPgyj5s4WGONkYk/ozEQ+LgXv142CwxVr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZKaHBllZ4kpicRc3c5Mci6nfeezx6mdp2sWo8T+1kc=;
 b=rvFi+RHb9ldIChip1I+yMpxJiB0t6obvWfZZg12vKzqUa4OeftoOE2OFGdavQ4dTMuknq6P4wFAUFXDk8t9c0GfjyyIVF6U8rLuf6ftPy+VPR2EE+DTFxDkUBFBmWYqm4aVyR/HtPurLiCC8+f6T1rcBmgd1Bu6TpSqY63+thezzd4m+0A1Af25sjopIrRIC+TepE8HTzrbU4cmWnCPziZYwapl4ZQb52pk152roB1f+oxcF/BQI48GUaf7oO59vmajlSKx6S6sLS3JnxUkY6eb5w8F4Pi8mF8054nj9JGzr0gtvUtUWLjAKD7+BKl2PivwtiDGnIGszelNZce77Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 03:39:06 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 03:39:06 +0000
Date: Tue, 27 Jan 2026 19:39:03 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: Zhanjun Dong <zhanjun.dong@intel.com>, <intel-xe@lists.freedesktop.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] drm/xe: Trigger queue cleanup if not in wedged
 mode 2
Message-ID: <aXmE19aGZIjWjDaF@lstrano-desk.jf.intel.com>
References: <20260127170455.618616-1-zhanjun.dong@intel.com>
 <20260127170455.618616-4-zhanjun.dong@intel.com>
 <0d5a5fc7-10e6-44c4-810e-071c10c45cd0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d5a5fc7-10e6-44c4-810e-071c10c45cd0@intel.com>
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 032568a9-40db-4d71-e6e6-08de5e1ec9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a4TEV+xN+oMFlUknB1rbiZbKgutZ4Rn+wRaD/K6/PaHMod7ydUwHbj+64wB6?=
 =?us-ascii?Q?G16wKhWBnnQrVDniQH6L+ab8LLy0uoTd52ELMCJCMmQIipFnN4ZedNxHXnwx?=
 =?us-ascii?Q?i0gPEXdAVm+/J/vCPZv6p8YSLyFUkY6QxPhvDwXHdbaqPXHAUtZ+as7NWj4l?=
 =?us-ascii?Q?ZwOb0B0TpfmQBfrBSQFOjPdgrwNmCW46LGxZXewUqCkUWf4fw79LqtqkcmeH?=
 =?us-ascii?Q?gla31MG/ojA6Du9T253pPH9V0+vPsnfATBAHOgPdweibCl0HkU29lsFukeFx?=
 =?us-ascii?Q?sxppl8b23SVaoLJd/5HachzXEKs+BocuL9g+TQbCOSLLWlAiAJLcY/aim6j2?=
 =?us-ascii?Q?WJkr78BcR7gRP+vUdQl9ljXVk/V/2eyfBeRu79mKbGBLNEv4hUhGS/95TAfn?=
 =?us-ascii?Q?j3hkVloAvgICpjd0xRF2vBJxDOjlncDwcLfRbZYfB6cXl0IBSglJRm9AUYtP?=
 =?us-ascii?Q?mSGcf7liEh817A8J2w1Pq7pMpKwWFZteN7WWKnji9Tu3nWRP27NWEEwNUcVY?=
 =?us-ascii?Q?2dvpOdXXwDLUqQwrfMWM0cRIv1Oz9AH4WmMud65QEdq29eouKfQAFRxWikRe?=
 =?us-ascii?Q?8AF3P1xqAwoVE4SaUn7RahRHOwQM+x5Jj/8+KSb79jk6fhhq+qektu+Bj5FA?=
 =?us-ascii?Q?FGDMfPJu9+3pjv0yzxA3K6cEDUPJA7t1FSPoa399mgnK3AXVY/55E+aemiGb?=
 =?us-ascii?Q?AgWEf/NCrVDct1SnO8nfopkeQfDuHBc2ukpOvhZ/IiJpkjUxa6iCxVo6X1l4?=
 =?us-ascii?Q?vZ8Cw6VKBsbS09nXxvpx1Ix+QkWmpjVn2xEq/KwELkbj6VeIEY1f6500swjU?=
 =?us-ascii?Q?q++2L/GoJNz3u2ngVvf6rSA0nCC8IGE/PNQNIwj4LSeMSWND69tYd2ERlzRd?=
 =?us-ascii?Q?tQN1u9PrMOqSr3vB/goRQofoicCdb0VLYT/JywDdrFK9MQQAZI7y6N4SonlE?=
 =?us-ascii?Q?J2AsDDGqP05BFiaJRHlMLxTxwkP1vTmHUQknpG+JOVQvzYilaN3EjdT5MTwx?=
 =?us-ascii?Q?hKl3TRVCYM5+fySkp/Er4JZJT3SYHX3SwTMw4l8Rw3fsgVCFPLfTkdu2ISGh?=
 =?us-ascii?Q?RvdSw8nJ77oF21IQSV993kZW3hTasaO+YEvkWVXUhs4+fxpB8e5DFycOcS+h?=
 =?us-ascii?Q?RdBtZAObgB1spmE21EHSLE8adMWIumHetsmWmzvKbTsFk+8DuctitPRHuIEA?=
 =?us-ascii?Q?Q1D8qrfuJHay1croFndl0XNzxMwTA07K9/6XfVYAeYiQ8XMUVEpH2WRc/fU4?=
 =?us-ascii?Q?1cazCVZqZJB3YtntOHZkVCRrADhyfl0ALeDEhL6IcIMkMMGxoFKJYtKv9VKX?=
 =?us-ascii?Q?Eue1e3+Z9Fy67UQv/qKsD3ilxUNRgOQd81eJ7Xm8FrxOYejv9fOyXjSgIQiV?=
 =?us-ascii?Q?/7OVkmf/BdjBqqQnZQ6Flb7/CDUTAcHmvPqcn+aXhKfnHQzjdCklTcrlvZZQ?=
 =?us-ascii?Q?Y+t9cEOfngz10N0RgfrCsakDtfdlvTXIB2VGzKnvLt5/EJ0vd4zuxrQt+LZG?=
 =?us-ascii?Q?44RlPqE9okIjTDZmolCCP5LG7a5wttIo3eyFEOoi9bDRh+oK2G/HNoygiKYj?=
 =?us-ascii?Q?C+FPj1tGpZAko+r2tXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4i+fQ/90fdQznqROzo/yCj0d0o7FUX4CT8yiEpOoysETRAtR2AyDhr/ccyiD?=
 =?us-ascii?Q?BPYhEQCgeyXTBDl+5jB5dVBiKFp0nPcpJ58p4AI02eZtgyjgsJ/b6fhmoKcf?=
 =?us-ascii?Q?W9ggWEK6Vng+tX40tnvms6pFbfMWQO2quPiHAnL8fkb+AnXQQgBLqtTw1cyu?=
 =?us-ascii?Q?qdHw/nYMU6uZM3NDTl45ZDN84CXxOJwBWkqfzszQv1Vk3ft+q9oPUDOL/89T?=
 =?us-ascii?Q?Wr2iA3AZ36e99xpppZ2jBB0v0zUWz+CvQ8ysc4mMWHaUCRnctg3xCae/Vnlz?=
 =?us-ascii?Q?jc/2Ojk4I0Jdic5vxK1BUCpIVN1/4GWK4n5JXLCZ6HTcg8CtH6tzagN1EWtc?=
 =?us-ascii?Q?mq1TN6qiI4wDGxlykpzK5D79hda6rAdXvLVVTFY4wyF1kGaueu9AqMspxFAQ?=
 =?us-ascii?Q?4OabJdDMJVAn/McDujDaYraSz4F+YSWT7MQ0/+OHprEyuWzr10tJqMHhsrnZ?=
 =?us-ascii?Q?K9CZiyBhpa9B1dFLgKQt7/o8UlHPfNBnLwENuAfbVNlYSodntS9MmbB+rHLw?=
 =?us-ascii?Q?6IMxVDgbqHLQF+Ny+1sKEqBsKS/MqfOZLuFWXhWsOejVhy7qKXvSaRzwx5F/?=
 =?us-ascii?Q?3HDRaU5Go/JxbzsG7S1pAA8+R2kRAOy09siD7vv47yXGUNMIgLsCs23Mw6/w?=
 =?us-ascii?Q?qcQKWC36WTqaz4vyLOADYHtbr+XH6RNCzPcVcPHCP/vJYdaGScgRK+SEeGhL?=
 =?us-ascii?Q?aC/L22ImSdEZ0WBNT9dNjyIf8OBV2SUrUlYR+WSIqtByRJYBdU4oTbM5kaiJ?=
 =?us-ascii?Q?yivnIvi5sF0EGsdzrPFT3NLCVZ6RoTyk4e/rHjybWa/8IuViSpiHmkHqtoYW?=
 =?us-ascii?Q?DBQcfFzgsozrdQm9FjTrCCxnUMbw9nMSz/RmW72rosf5rTLlJvULA9c6MLaA?=
 =?us-ascii?Q?KDrA5DhmdJSyB9x0QguoeNLr8GDHy3tl1sUSQ/QteuC9j38Q9kz9xxbpraFG?=
 =?us-ascii?Q?mdGqo/RZXx8g3Ym6eST8vIou1H44t2sbzaITK76JAB3RNB4uQmUDnR4QtPRo?=
 =?us-ascii?Q?dJAPh5iT7pKRVtsRunBvsWhDcoFMiyd7umRu9hiodnjFoYmjehRWIMP/OXuO?=
 =?us-ascii?Q?DR7+qMGxhV6czzFIXEUeKgaSWk0AoYUo84d8y/UhjQpjMm9MS6isccV0ZUIS?=
 =?us-ascii?Q?M18xvqdIcW7XE+Xx5Jxm6xqUMuU7qpA4fz0qkuBBMS/lJxapw82f27eRlL+h?=
 =?us-ascii?Q?9ALHqmB8+mzKs1D11eJxdCX9SeGhy/KwbalFNO9MUyV+lJAU2eYNitV+9pWk?=
 =?us-ascii?Q?8hythsObh1LU+hsV80YJL9pEjtcB/EHy6+4sfusWX+WN7z5HtABCqGiy5Vmd?=
 =?us-ascii?Q?rKIuCeOj40kL6CSdFTcsHVj4iCB1tQ4UyGmE4vFYtHDMniKtjAXUUpqAdSC+?=
 =?us-ascii?Q?a426/I5S1ksQAA7E0ngfyXejFJlJvogyM4LhOHAGlSI2hSTw29taCGhsY8Xg?=
 =?us-ascii?Q?09serHsY7i6iHg+8s1O0pK5QLStICBRGvCj6eC/X+ACceT8g5zkY8AEGOCr2?=
 =?us-ascii?Q?MfX7JHLk3RbA5gUo/A0Khi6zbxPE1ETSQlRD5UhMFZ5h2PMsrDe0xu9cjZJ/?=
 =?us-ascii?Q?zkKnO4y4bwcdt40FDtp28H/SpCN7ZpflmkD/muGG86q2mfp2aCrf/y34gcpA?=
 =?us-ascii?Q?Xiv5+C49GOh6uULp4TW5nPcngy3t1eVzJVjDlrSy0tpz7CsMsL6+Mg1d5PJ0?=
 =?us-ascii?Q?bhtG8fs7vPFmDiVAxw7HmbucTxgVDkH6c2ntNIrbUf8HlN7Cj8sAf94Sty9Y?=
 =?us-ascii?Q?MHunK+Y0GYANDPaZ7JgwgEYfVhbZhWg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 032568a9-40db-4d71-e6e6-08de5e1ec9bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 03:39:06.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6hfqekWeh/55nZ7zBg4prVwe672kILgN3m5/VGFChxztxV923IigWXrS9h5lVWeoIlPWHVoQm8NP82WoFirxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211923-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C26129CC94
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:02:42PM +0100, Michal Wajdeczko wrote:
> 
> 
> On 1/27/2026 6:04 PM, Zhanjun Dong wrote:
> > From: Matthew Brost <matthew.brost@intel.com>
> > 
> > The intent of wedging a device is to allow queues to continue running
> > only in wedged mode 2. In other modes, queues should initiate cleanup
> > and signal all remaining fences. Fix xe_guc_submit_wedge to correctly
> > clean up queues when wedge mode != 2.
> > 
> > Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_guc_submit.c | 34 ++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > index 92ea32423838..f29ed62d2b12 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > @@ -1326,6 +1326,7 @@ static void disable_scheduling_deregister(struct xe_guc *guc,
> >   */
> >  void xe_guc_submit_wedge(struct xe_guc *guc)
> >  {
> > +	struct xe_device *xe = guc_to_xe(guc);
> >  	struct xe_gt *gt = guc_to_gt(guc);
> >  	struct xe_exec_queue *q;
> >  	unsigned long index;
> > @@ -1340,20 +1341,27 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
> >  	if (!guc->submission_state.initialized)
> >  		return;
> >  
> > -	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> > -				       guc_submit_wedged_fini, guc);
> > -	if (err) {
> > -		xe_gt_err(gt, "Failed to register clean-up in wedged.mode=%s; "
> > -			  "Although device is wedged.\n",
> > -			  xe_wedged_mode_to_string(XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET));
> > -		return;
> > -	}
> > +	if (xe->wedged.mode == 2) {
> 
> wedged.mode is now an enum
> you should use XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET instead of plain 2
> 

Yes it should be. This is a fixes patch though and with
XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET, this patch will not cleanly apply
to stable kernels. A later patch in the series could add in the enum I
guess but maybe not an issue as xe_guc_submit_pause_abort isn't present
in a lot kernels either.

> > +		err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
> > +					       guc_submit_wedged_fini, guc);
> > +		if (err) {
> > +			xe_gt_err(gt, "Failed to register clean-up on wedged.mode=2; "
> > +				  "Although device is wedged.\n");
> > +			return;
> 
> if we want to continue, shouldn't we call just devm_add_action() here?
> some default cleanup will be done later anyway, no?
> 

Ah, no. If guc_submit_wedged_fini doesn't run at the end the driver will
not unload cleanly. This could be refactored but it is correct as is.

> > +		}
> >  
> > -	mutex_lock(&guc->submission_state.lock);
> > -	xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> > -		if (xe_exec_queue_get_unless_zero(q))
> > -			set_exec_queue_wedged(q);
> > -	mutex_unlock(&guc->submission_state.lock);
> > +		mutex_lock(&guc->submission_state.lock);
> > +		xa_for_each(&guc->submission_state.exec_queue_lookup, index, q)
> > +			if (xe_exec_queue_get_unless_zero(q))
> > +				set_exec_queue_wedged(q);
> > +		mutex_unlock(&guc->submission_state.lock);
> > +	} else {
> > +		/* Forcefully kill any remaining exec queues, signal fences */
> > +		xe_guc_ct_stop(&guc->ct);
> 
> this was already called by xe_guc_declare_wedged() before calling us here
> 
> > +		__xe_guc_submit_reset_prepare(guc);

We actually can skip __xe_guc_submit_reset_prepare too I believe as that
is also called by an upper layer.

Matt

> > +		xe_guc_submit_stop(guc);
> > +		xe_guc_submit_pause_abort(guc);
> > +	}
> >  }
> >  
> >  static bool guc_submit_hint_wedged(struct xe_guc *guc)
> 

