Return-Path: <stable+bounces-164481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2EB0F7EE
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3903B438B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC070838;
	Wed, 23 Jul 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3Q5o9n6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDE2E36EB;
	Wed, 23 Jul 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287496; cv=fail; b=NjaCOCmaHgWXijmJUDPuXhn5JpbCvidvBQrqP946Xf4upDxAJWExWzTWQK5qAowfiNbb3m1Wu1zA577pC5HjnPk3CjoaE6sUSPuUMVyN+MgphX5bIg9fUAWIvRBa6ApaCS/83JhrxdIZN4SgETsVQkS/6fkM07EPqr2zEFgPLUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287496; c=relaxed/simple;
	bh=jyIgK7nPToDeU/vJh8cvXU5XDWecOO96aJkfuuuUr6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K3mIZa9HBfO6JlzGFIxpnm1S5raGjd5LLtXyFI/l0ccN7wgNuH1YIn/F+5Zv/+Gn8fNhh+ktkBZxWXYCUuz5bB0RpMdZa9ANH953h8eGFo/98hDRZOwdPJIld3mMcJcDuVUjgdb4q/3xUfxHhS9MUd8SgpMfNRiJlXQsUw0tWB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3Q5o9n6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753287495; x=1784823495;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jyIgK7nPToDeU/vJh8cvXU5XDWecOO96aJkfuuuUr6E=;
  b=a3Q5o9n6wSRdFyGQNl83pp/8guRqjVPSqfYOpC7WdXYtXR07Q9Nz1hTJ
   Vnl8Nymlo/9OS6RufsAuK2G4lyCUSvRP2zJiDnhX9mtgVCqMKM6kMrfXZ
   JoGiu0RMtn+gTSWcIHL+Ifji1eazpAy+MwYzlloKQFM9QQaaXmWkRh9H0
   3vPkZSrxDpE7ZZkjCn0uuIlpu/9/fkY0KCcNAroF4i0CAGrSLanzQFnME
   z6R7vxmnDhfdlD+/vjGfGK7VSsby9e0CzF6B4X5Ktzi0r0HV9aVemIdxG
   L3EU3qquL7wMWTdsBo3EgCpgHy8VUj2sjpgFqCR+maTd4k+A+nuDhlS0N
   w==;
X-CSE-ConnectionGUID: D+7X6ldsS8WSZmVfE/vlEg==
X-CSE-MsgGUID: B+VV2VevSL6lzXMLrPswUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59236225"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59236225"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 09:18:10 -0700
X-CSE-ConnectionGUID: 5iuZrjYySnaaSSSp3mWH4w==
X-CSE-MsgGUID: mD0NW/Z1S6yZWC1XSz80cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163669361"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 09:18:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 09:18:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 09:18:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 23 Jul 2025 09:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRhHeScZCUxuvKzmf/NeCzD7qXRthI3wIyj7wfGCXSWCVkwruTPkyaFwNZ4ajd2BUaOjGuWS26m6iq2h49fTV1pyn1qse3dPNxjZKvK0VYiofVQqKsSl5EvQRYg5BgxT1S6aFFVlSi+RZsH6rR+3/x5YNvOMZlsXJgj47/uZgrPUV1sz3h4lC7cUuUwEeCEM8++UOmoZg8Yfv74X+U8gZSQahiVw/eZS7ejOvu+noB3EcaDzbYxC05KPznv15uy++rsrsj2wWFYFuKxq9qHAske50yI9IOOvdsbqZe4Pq6LytZ6zPqMvsZt5Qg4QYIghtVYaYWCJvOtG/8L46+FPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZvNPvy7ZIzG/dMQVQHORyZZDHAaThmCp4NYw9WAMDc=;
 b=uAg6H6pNX55UCs9uuHeStC2MdYj53Tfb3u4gJBkTJmub0yNjD5TscVd/RlcZD/Kq1g8ypq/OAMM8erbhY1b1dOalOwpqsg3eZ+TGVAFdUOcntmPA8eG5N7ArKOx58a58GvkLuCNE2DpVmaIKKO8uWOfWXUckl0sOQ9CvmLuq+dWNl99cwg2bHbaZzP2weBBF+TSrsX2FknoJ15u/RM+xokqjFm9x131ig0Ywb1H2XaNGcgo9oXSSBkO7QqDYPfWDb+77qYXrlWzHiVjnS3DHkCVuYiNoXch681vat4PhgvQ7C8ZHo+UsdY+rOUlIqzgS7Ji4Qj7Zog0mO1OT1jGxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3934.namprd11.prod.outlook.com (2603:10b6:208:152::20)
 by DS4PPFCAADA7A6C.namprd11.prod.outlook.com (2603:10b6:f:fc02::4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 16:17:55 +0000
Received: from MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2]) by MN2PR11MB3934.namprd11.prod.outlook.com
 ([fe80::45fd:d835:38c1:f5c2%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 16:17:55 +0000
Date: Wed, 23 Jul 2025 18:17:03 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "Kirill A. Shutemov" <kas@kernel.org>, Alexander Potapenko
	<glider@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Xin Li
	<xin3.li@intel.com>, Sai Praneeth <sai.praneeth.prakhya@intel.com>, "Jethro
 Beekman" <jethro@fortanix.com>, Jarkko Sakkinen <jarkko@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Tony Luck <tony.luck@intel.com>,
	"Fenghua Yu" <fenghua.yu@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kees Cook <kees@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, <stable@vger.kernel.org>, Borislav
 Petkov <bp@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
Message-ID: <jaulcyha4kke42um3nnfiw7hvd7kienemqg2breloz6auchqa4@zmzt3his7ovy>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
 <641393bd-c3d7-4bd0-a3c7-da600685be1b@zytor.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <641393bd-c3d7-4bd0-a3c7-da600685be1b@zytor.com>
X-ClientProxiedBy: DU7P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::8) To MN2PR11MB3934.namprd11.prod.outlook.com
 (2603:10b6:208:152::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3934:EE_|DS4PPFCAADA7A6C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce0f5a3-77d8-4762-9527-08ddca047b3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qiZu2GL5LoqtsKrDnCLw6BJIG4Ss6jreGh56m+a9lSdFFN/7znyoRMmBRN?=
 =?iso-8859-1?Q?NOGHRQDDIJ+l4J9rv2lJJQpSbnMjtJ9p/PsNtVOn1XmRrCa1o9mMUcQfau?=
 =?iso-8859-1?Q?yjBx6xIf60WvHf6JNwaBzWqFOFpnC9S5M/kCKbAjithTHyBWHZrmEX9Bvm?=
 =?iso-8859-1?Q?CE3KxByyBLbWor/AXH9OQy6VAtUpw6gn5V0+ZfLiG1yoAt7UaG+uadvadM?=
 =?iso-8859-1?Q?R9tSk2KryDnpwxujUyE4IV8eYTSFeF1z5sfYh/nFpRP6/TYUyIBvIy4TY7?=
 =?iso-8859-1?Q?U9r4oOLLaZEP8wR9stokFR8rTW7qP3Z89d200O43TCd0EVFq6pQ1s4YgLG?=
 =?iso-8859-1?Q?E8+qi/HhJiFaOJGXs0bqFph8IVuBMG4UP6AoT985pdZ5YFAzHjqbuULMIA?=
 =?iso-8859-1?Q?GTpmuLHWnAg6DXgsqQGaH7oy+17cB3POu+ye8k4ALN7A3vJIqg5PMrmn54?=
 =?iso-8859-1?Q?PN+dUupCVatiE63ZNwKv9e0hGo5R/XZi9inXSjnKWyGrj1vxH04laLxXRP?=
 =?iso-8859-1?Q?fF9J5nw8zA8Sdk/KL1F9ISdoA0wbJ6NaaY31WZKJgtjzxdj9yZ+chR0uQX?=
 =?iso-8859-1?Q?eDVDfXyLa1jLdPcISgQ+9hwm6OxY8gH3ILZLUKjtATt3aaKQdOZKtSzwXu?=
 =?iso-8859-1?Q?rqCJRUmYNxTsR7axPIseU2U3ZujnLldPYFBjHb9sYOWKX4fDpWGBurC+XU?=
 =?iso-8859-1?Q?HjRAvjjoO0WPngfUMo5d/JKnqPSaHPQapxmirbN1MgFKa7WQdfwmmdJr5j?=
 =?iso-8859-1?Q?/hSN04oAHXXUdGQVIHwFz8h6O2HfSLVM/jK9a/p5bKC/3dpGFjSc8i0TLe?=
 =?iso-8859-1?Q?3y2O6wUwQVyVJyvZq0VUSKY2+BR3CBmUTwNYLNe5W+6Sncz2M1t+ffJtvN?=
 =?iso-8859-1?Q?FvDlyFDntEIuYDblzh0J5ffoMHjOV7PnzLO5omZlgZI4oP4ioDmLhAipz7?=
 =?iso-8859-1?Q?N9lWfknpAxlk31WSz6V0xVTtPbpNZrUGp+lbZeAEr+eteMPDGUcUFmz9eg?=
 =?iso-8859-1?Q?gl1OkgWZIr6U3aIGqEEKmR9WMplkTNteSbzdzgmXB+AE59oU4pD7zMaE5g?=
 =?iso-8859-1?Q?LNwzdrM+18d9TEzT7/rN0RcSAbwosDwbo0dbV/ZvV178vfk2DSkyy3o7vd?=
 =?iso-8859-1?Q?rjOfm89n3byYx84Q7+OXLlYw0+uXEXndW6NYtujP+hP9/IOE9tkj4w83NN?=
 =?iso-8859-1?Q?d3oal9mWJanG0cUSRcGuozMM2nbwAvmbCi6H5vq+8VtLh4EuSUGvBtd8Y0?=
 =?iso-8859-1?Q?QInTgg/yg2euQBllGKeK6pOQittBOb5OqiHmBa4urN18U1VZE334tS3J54?=
 =?iso-8859-1?Q?aGbuCW7hnOsku0e2mhUZDA2ixYbxrDD9ZgGBLqBTiZu4o7LtZjOdhvfgiC?=
 =?iso-8859-1?Q?MBbv9Kj4NR7uBus2WQVpxzV6WhILJztiQNf6gKd167g2zh4ISySOs9aqr4?=
 =?iso-8859-1?Q?ThJVQO4aviOecktKm53K5Z+ayE2G1S1Ahvy9R6feIgxMuQFDN1FblRcvyD?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3934.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F0b4PjT8fv4JBgK4QiqyUYFHoLuD/hIUaufi2T8IwWmpSswjCHECM3bavK?=
 =?iso-8859-1?Q?CAIzE8ec+hgOdrSV7nUys6mTGD2BQOqPVblR8L+y1d7NKexR/PAm9HltR1?=
 =?iso-8859-1?Q?SO2b9gfcYE3kwzM22mYBYmM2F3701WeD9VnQlhsLiEAb0yXene75XM8lkh?=
 =?iso-8859-1?Q?33SY1DseAG9YKWffqSvDGvTkT4WM/fQFoZ0ekglIJGO9jecrFhQg+wcKaN?=
 =?iso-8859-1?Q?DtuhJ8IYn2xlS+TOf9JiUynb3UTuFX+5rpvh3GLoqEXO+S1rC03lPxVpjk?=
 =?iso-8859-1?Q?d67qLDQGE0TIc2R2oj1yA5DJ5pTEBnYTeH+vuN8tq02LBHQZagiLc/6UbH?=
 =?iso-8859-1?Q?CXUV8XWVxAErJfv/z6PgKgF8lk9ovROp79VWtvB12blCL44p+URTkhZfm8?=
 =?iso-8859-1?Q?gMdxGFUM05vKBMSpNV955HQf8XJ2bLKbJjI5dOIMxAwbs0TZFjndNm2UVN?=
 =?iso-8859-1?Q?YFJ4YPcVyXLBtScgSVtN9FA7MP6FsQmjDMnT5zvy90PMDN42rO1/BgjF9U?=
 =?iso-8859-1?Q?kKczEzk5wCFPdUSAcXLiYBJmq/kTtoOxlqaWPCoiU0V1D7Ku7yyUkyLr3A?=
 =?iso-8859-1?Q?dGisZwqAYBMc4V28xqaw/OYDUGgu5WEJBHmIL4U4fuZB+1Sa4vvE5ULfU6?=
 =?iso-8859-1?Q?/qg4hpnGsmOcu1l4e53GJNvh79f7Lm/pNeNPs37GuTybXep9ksGd05IjE2?=
 =?iso-8859-1?Q?kJz/4OQpxQ7ZBWJ9eQiIuZmjFSyirEGtFDanigvK6UJfoeAMoqz5HT5jLw?=
 =?iso-8859-1?Q?Z5B/IOTEJ5gVH+juQZ7aVfRus03syN9Jyy4OkcfEmys5Kk0S98E2voUHmy?=
 =?iso-8859-1?Q?Uip09HjOMVSbq0FOuoUNzZuL6OaZxhvtbSnpDdDCDkeQtM/8RjTpyw2Al7?=
 =?iso-8859-1?Q?0ZepZUNss7gfA51uEFNdMz66WUIB24yq4EabXi9weecXKJqsP5GpWsrsMx?=
 =?iso-8859-1?Q?tHUgkSXE4YuMoFD5X0btsrK+YI9YWZNSvfdZkDEDrE2+RaZjap8PrEW2Ck?=
 =?iso-8859-1?Q?R+1QfeDxXpfz0Qq1ulmJKZq5etf9G1y9gFf0DK8s60R7lFeyYJ4S5m/9TY?=
 =?iso-8859-1?Q?S1YnhK1eUTjLq/Uaq36hgI4MGhkWaxYVqYZ6H1wa4J7O0kHiL5NA5kw9NM?=
 =?iso-8859-1?Q?WkXfVTPjRvf2ZWzYo+GTwQi8z3RSUbX+hvVl1Sz7GCZmUFVOpk9sIFtKNQ?=
 =?iso-8859-1?Q?Ej1cyp5oCD4O/dv6iQAmPCuiQZ/kMtugUYXPskcKqXxYFi3WPeAHyXT08r?=
 =?iso-8859-1?Q?3FtaK7uytQI3fsvcft8ON5e9Y6ct8bi/rEty7D3WliASP/jJog6J1zMjK7?=
 =?iso-8859-1?Q?o7hFvyPbHcNWXW8jAuD+8tEfDxSxY8IfVZl0BTxoC32eBJTUOsOJ3h/auf?=
 =?iso-8859-1?Q?dP67y8os8MU+9PReAj4JhjksXRHW97YjIfvp5kbCnOzw9rDAawl1/zGRex?=
 =?iso-8859-1?Q?zpGS+bGQ00xuKWsJvVicGoGFC+hw/2kG/NHrTTpvX5wZv1CZuZDQtggIvN?=
 =?iso-8859-1?Q?mF3KTzPibywHJXChdz7wzkkKqrZYj+RPJohUueadeLlEot4jzCHGIDue90?=
 =?iso-8859-1?Q?FDK37YZWxyLJNfV+T3EvM+D/uMWQVaykjTVoC86gzxCpkd1UM4Zbsa865U?=
 =?iso-8859-1?Q?bu3sFV83hu+iF8rbxhy7yze/Vl59jIQmncf+RekHAXif/HBoqnEaymwsq7?=
 =?iso-8859-1?Q?lnl1FCKJpckKCskoC2Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce0f5a3-77d8-4762-9527-08ddca047b3b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3934.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:17:55.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzFPsKBN7nSAAR1cVc0yFQPjNPepu8fRUM04V3raR8m+oKMdntVmAHnbw5M/+0PWOZDu64CMaVo/+rdguccD2KRfoMGRsFbu49rgzMRXIrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCAADA7A6C
X-OriginatorOrg: intel.com

On 2025-07-23 at 07:08:43 -0700, H. Peter Anvin wrote:
>On 2025-07-23 02:22, Maciej Wieczor-Retman wrote:
>> 
>>  arch/x86/kernel/cpu/common.c       | 12 ++++++++++++
>>  arch/x86/tools/cpufeaturemasks.awk |  8 ++++++++
>>  2 files changed, 20 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 77afca95cced..ba8b5fba8552 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -1709,6 +1709,16 @@ static void __init cpu_parse_early_param(void)
>>  	}
>>  }
>>  
>> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < NCAPINTS; i++) {
>> +		cpu_caps_set[i] = REQUIRED_MASK(i);
>> +		cpu_caps_cleared[i] = DISABLED_MASK(i);
>> +	}
>> +}
>> +
>
>No... just use an static array initializer for cpu_caps_cleared[].  You
>don't even need to add any code at all.

Oh, right, that seems simpler

>
>Ironically enough, I actually had those macros generated in the original
>awk script version, but they weren't used.
>
>And you MUST NOT initialize cpu_caps_set[]. 

After thinking about it more I can see why doing that could be a problem, yes.

>What we *can* and probably should do is, at the very end of the process, verify
>that the final mask conforms to cpu_caps_set[] and print a nasty message and
>set the TAINT_CPU_OUT_OF_SPEC flag:
>
>	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK)

Where would that end be though? End of identify_cpu()? apply_forced_caps() is
almost at the end of the function, and other functions don't seem to modify
x86_cpuinfo or cpu_caps_set[].

>... but that is a separate patch, and doesn't need to be backported.
>
>Xin send me a patch privately (attached) but it needs to have the
>REQUIRED_MASK_INIT_VALUES part removed and made into a proper patch.
>
>Xin didn't add an SoB on it, but you can use mine:
>
>Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Thanks, I'll work with that.

>
>	-hpa



-- 
Kind regards
Maciej Wieczór-Retman

