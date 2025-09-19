Return-Path: <stable+bounces-180717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8DB8B999
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 01:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83891A04CD8
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3441A239A;
	Fri, 19 Sep 2025 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUJhd/n1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA802AD24
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323168; cv=fail; b=W28Jnl2oNHQ43G8CKpSc1rwsHiGiQdJWiqPXSvhxL/EwL978F7dyugK4cHhPv++bvtxDbAbbZFnbYZZhUrUBs90GE/+OR+ik647ZlOv1HSfhzQHG8vWcLIQZd7XMlNNy+x/DmW1iC23GKrJPCjwHC+a/h7LlYsY+Pe73Bb+rtv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323168; c=relaxed/simple;
	bh=ZpvafST9taGJuRiJjUgzuWuwmSRKdRyQImzwtu6Nx+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kUaI1LqnbBsOXQVjBDdC5u5zCSHU3AfqgQwhXDjOx0Z6mQjPa8mVV32N337e1Q0So/qtF9WUvGjjgQgxtq38zNHrlGKycKSqGPSjJ/OT3G1oq+FmZdqx8l6zvJFuHEACZvS2XIhMlwygM3uU0Dxzxhgdzaa7Zd6Ojj0Wvro+2Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUJhd/n1; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758323164; x=1789859164;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZpvafST9taGJuRiJjUgzuWuwmSRKdRyQImzwtu6Nx+Y=;
  b=WUJhd/n1GJobk/s5co++SnO0DtHVDcGw0/P3vfRhXfA1t+wYYP+UPHkh
   URehqgHdU33P9W8RYo2/wY97NBPW8/pP/pDaG2O8tcFagVIvxaYdhXJyf
   DjnZHTLZbv+0pYQq5UzmnlLqQ19ZaFZSFhYH5sdo4bTRwpe5CtGK4CruV
   daqD/X5ZEWtzAMVx9HkC7ObXsHIEHqMD1XkbuZnQ8DWlRJ8mh+ETR8UHJ
   JbXKBSIDHrR3I/k+La9N5VHX4VSZXVV67ZyxRiu7AGLtVT3xsHvwF4WYZ
   7pZjYXB9f0qV3RNCxNvAfnemW04gNrHpCBNyJ5fNpHNsBmz+4yZmdPowV
   A==;
X-CSE-ConnectionGUID: 6CW6uPavRmqsdx0qoOvP9g==
X-CSE-MsgGUID: zBZ2ekReS3mHK9kKZ+r/bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71354621"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="71354621"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 16:06:04 -0700
X-CSE-ConnectionGUID: SbKHsmgqR4SfYFdMQlyGJA==
X-CSE-MsgGUID: CXYgbKOZRCWBKlkx4yHBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="181208371"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 16:06:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 16:06:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 16:06:03 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 16:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgETOOnFO7phCCZ89LcSRkLY0BzNhQOidT1HiTiOEypaesHzQv9dTI9qUTHDE32FC3PpjY3zlaqOsocCSVvXPRWdXT0US5fZjmZuhUMExhScBeel4WPYWW2CKGp7zJZ+boy8sJ/FzHJOg4UaI3td2xFBk3ISrzRW8fQ5xjTTodiyxZanRcLCeWxoXTCnqSOipHho16rmn6o1LYObIw41/A6S2GxR5bRZ1f+ZwRGWNFTUsODzDsLZJ8TfLLSaOSTHiN2NPAHghrI/G3fSufPL5eGO8o8NVNo1K6lMBs9xrQN0zJngOXE1OKVmFS2pZWQ7ygy0hQuMz2jFaJLeagyAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrl5XAEIZPtfJswBv4MfWKI/EjOtkqdAfvUQisGQxuM=;
 b=tqKrnVMAfLRNnJCYAdw1+wbH2jBFTjuCzagpCJp8Sn2I8OvMgQE/9BbZeIAIppItII4lQO7gbzJEZ5VNRrtezAI+SQIoN5Qo/4yr9MDL2e8XYx1oNNqz4SBk1MHY/kCXkZP3GTGOcnc7Jx5poURe3uhlb4k/d7CP9qQ2o9fWHgF39UHwfDQOOASPyNdVSbpv9IBbQ0/j8lnxITPo/lN0f0C/wFWf5fOb4jLo35iaEP9qBb11IUA/tU+NExBtq2qKCV9M54JM8L3bbgd5i4z8yz4zRfBw2LxSQgnr94KMOdNvg23x6riXc0x2ocqQqXrZyCOOahEHfx9th2jOrOQ/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 23:05:56 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 23:05:56 +0000
Date: Fri, 19 Sep 2025 18:05:53 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, Joshua Santosh
	<joshua.santosh.ranjan@intel.com>, =?utf-8?B?Sm9zw6k=?= Roberto de Souza
	<jose.souza@intel.com>, Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/uapi: loosen used tracking restriction
Message-ID: <6tdf27br3mcafpco2kxxk3razrqvigawsr2r7m4jis3rv6kvhg@h63q7sepv2qo>
References: <20250919122052.420979-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919122052.420979-2-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a9b41e-20ff-4b18-db9a-08ddf7d116a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/cxOSuayEpXl+jA7LbW/StiEPocaJJ56Z5UmJAikPaepiu3u7t4AswGDYp?=
 =?iso-8859-1?Q?LRnEQOrx0F3KvU6/DOOTLmcW0W2XWi9e70ra20cFwCJ60yFxFl4sAPsQVB?=
 =?iso-8859-1?Q?YvKILoSQWr7juszXZOI37zGyFHD7GnlsYI89DAK4Zuvl73Egv/WRTQ+dCh?=
 =?iso-8859-1?Q?L2/nAkNpTVEK177NLgxqjOujK7cEORJMz+3B3OtWzni5KAMUC7IMpx/MiH?=
 =?iso-8859-1?Q?sHHemMH/vIuSmozK7zW+S+CIwqwJJ4eZ+XJpPM9ff8z4ssCWIpR5rxWnaQ?=
 =?iso-8859-1?Q?agrTQiojmK/Y53AnRmT1RJBuhIb/aqQ3K19v+7MZpahiARcUoTwHttxbCE?=
 =?iso-8859-1?Q?FW27yQ6oqWO2w4UFuBNOfgAXwSETxWoe842lB6dGf5fmVX3evATln9Qj8w?=
 =?iso-8859-1?Q?llKK7Jz/yAkJvNNJOr6FOvUpC+vfdT8RU1sZuiEewDkVJrNgKGYNMC1eB0?=
 =?iso-8859-1?Q?SrbMohhYhIgLjLjeeraOJxbF7CmbLiI8anBcTmjMUoYA13RloDMttqTQry?=
 =?iso-8859-1?Q?0KijS/UCFngLzabWog67V3oIb9U5rQyb6P8dWKZoUiejFEHCeNs8LVHDFV?=
 =?iso-8859-1?Q?+NvOstNvlQuosqKjn2mspLZjFzZSn1fVygzYhrFs2VqOEQU9Ls4FEn+xXy?=
 =?iso-8859-1?Q?CTuyfYUAuR4wb2mihaNWA+o8Dk8un3l3vQ1mpfkprsiw/XTYmCCI0KJX2r?=
 =?iso-8859-1?Q?qkgfrLsO6nTNrY5maX9EyWe/w8xLwM7PGoGvrza+oL5Odj/kHxARC5Jeju?=
 =?iso-8859-1?Q?av5Z57ZPqWWW8OIZAoSfFsu90Bp++lMpEBDFTldFbqGVSOKXvmOZNWs++z?=
 =?iso-8859-1?Q?S3knffi0z9ngncs4QvSiMpgjF2FVLKri5PcgZRlQOIxeDY6OvCXw4grIhX?=
 =?iso-8859-1?Q?F9l0RdSpzjj44ctVNuIcazzxxsf3EagBJiJo0G8aZFPJ4gDHe4M05p2kJc?=
 =?iso-8859-1?Q?16BK5u5KTiG3LytR0TbWxQq78Zv/GOpMD+pynxFQFZSmv3Y/wODBY9Er0E?=
 =?iso-8859-1?Q?vgK80yaebvrXMpe0qKWGg/KW7nYK8Kv+ahdC9DTRVH7+AqJbXr6lVhn7Xd?=
 =?iso-8859-1?Q?MzT4Nuj+wq3XIq6YQChjuv+/FCDJOHmKyAoS2RBit1XiINXXdjvYj5tOXe?=
 =?iso-8859-1?Q?ktKg3efZAY3OZWozcklUnXgZ2Qo6OrgGpQlTCmbSqt0Jb+9D7x1QEJU4O9?=
 =?iso-8859-1?Q?Kpi7Fwd7yu8/bc2UomLbqaFI9tWwDQdxrXRfweEJWsBWhUzsdZQFi5ADJ7?=
 =?iso-8859-1?Q?hmtf9rAXAbIktig5G3NtKfGf9rdLrzaojHoOqOf10SmozFGKqUXXc3J7F4?=
 =?iso-8859-1?Q?E7zqIoFeNPVmj8onQ9c/hgc2/cWwZJ6QLO3a0RsSlEEU4VP2iWbtiTLRiY?=
 =?iso-8859-1?Q?oHbWjSRoraqAFgtqFbVOh39ged1gGP16uQNkmN97rrqY1/A8jTgHql2BcX?=
 =?iso-8859-1?Q?79nifXylCI82gcXO6WmH8GaQHZL4tDXCFAZG2i8bGsiAInzghl8xOiW1mO?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tUqaVfYExEZ+jZZVVQUxpMQEhbJ32YaNXdIKNUmozUgpkJizE5dX9vJdsm?=
 =?iso-8859-1?Q?zKONgTfBPKAzuj8Z3CCAqgkFGrpcs+HDARDB/9rm/R7zjVrAMSTxDviHSs?=
 =?iso-8859-1?Q?4ht44BkfwXENHjFWBrx7mKtOPBUwBPTEaQ4ib6HiPPjCihwc0TaUq1w5wh?=
 =?iso-8859-1?Q?ft5NzXWma5SVL1x1HWYrI1h5X6rT81GbCjW0q/AHWHC/UEBw1jqlGzk0lE?=
 =?iso-8859-1?Q?/kSSbT66a8xkszbI0XdO8pAIFgOCCHfRx3XXpOBcbhoH8eBf43aajTqwA1?=
 =?iso-8859-1?Q?6aLUguZyYpCQIbW6EDaXZdr8POtDMncd6iVgjHe4N+P1TL8ExH6sODnWKb?=
 =?iso-8859-1?Q?YdVnkQwNxxJuPFSg6c6I05zVsLAKX9cb6n+IPwIDUDAf7SocbfdWcCV2gJ?=
 =?iso-8859-1?Q?VKokdjULLnJROph8Ieo6tR5zeFA28lwQNyqZRfhf63RDZp6tQ6RQbbo4EQ?=
 =?iso-8859-1?Q?kA0RmgsOnDQ59UMHCZza+VJar8ArcRLsCpfvnkGCBy8T4mhRglKofr7ghd?=
 =?iso-8859-1?Q?jH8hMN7hfAgfhgHe+ehmEhSXr0R/+/INsL8moYrQ8MVB2tnWLMLDxXCVMw?=
 =?iso-8859-1?Q?g5iz0J2K2WlswJ+GstirT3MTbFsd+1Fa2bguovP+yez4N+u/upmfA7DOfu?=
 =?iso-8859-1?Q?2bDyAEJg2PbwM0BPjfO3rVan8ZMI7QCY/puzUJqldbZjzgDl7Xdy9kE6vG?=
 =?iso-8859-1?Q?lXf7pAlW5RZoK+CB9xwKWVBNbyeBJTBr8N1hdAo5JWyZ0fzsyE0NdVHuGc?=
 =?iso-8859-1?Q?IGcp1vcH45PbR6YrHNBqVMNNUOBNUJHr1YGIVGBvd4GnyBw8XwebDx7IdV?=
 =?iso-8859-1?Q?5YN03v+YrhoH/SDgPNac0uQovKsc5esjrojbjOlSk0OajRWrUNiMak1a4J?=
 =?iso-8859-1?Q?YNZ+TgfZWUsTrDQK9vovBGxZEgxxVeQ5lyTzalKk7708hkKBRlkxRNYewc?=
 =?iso-8859-1?Q?SpB8daXv6KJzj5gtXeoLFq7zK/onz2pq0544fVg7BOosooMJbVBbNva2o8?=
 =?iso-8859-1?Q?CDnqDUwQ2/sf2sB6s5JLBiA1xJv6olrO+XGqlS8RoELCbxOkXJGsf7+4iH?=
 =?iso-8859-1?Q?THaSMyOYn+MGws6qgkL4bMyAGwGACwyFluSgdm3uZ8ytm9Sqhk1mmj3lNO?=
 =?iso-8859-1?Q?YA8PdVR+GLubiMvdo8psLPC0zwRioRMXB9PAyveyDeA+f20xKs5um9kP2n?=
 =?iso-8859-1?Q?6hgdmnywtfPEO6zXKBM0rTxrAaZc8dXbwis6uXRjCtJKT7U0d1SY/OiZpg?=
 =?iso-8859-1?Q?RaecNCLV7+AR7e0aQ5YaChgql55q3GPrMmyfqiuCNl6Gv1/jLCsUO+IpPH?=
 =?iso-8859-1?Q?NTFD4LGykOZ6aUPMW3aIptSbCVMKqdcqqpmye5CSvgVAm+66ddDfvAun7T?=
 =?iso-8859-1?Q?dCw27D/M7CFMFeNTOwnWyBxPGR/yOoiHLlDYfRUh3TaXfXjHoaHrn7sxbH?=
 =?iso-8859-1?Q?QYnA3czD6HWZsSWa9Z95qcZhqanmBcLEsfe2mseUUdWqwxf/fqcO4TBeTc?=
 =?iso-8859-1?Q?Ve6G47ixefDq2A35cNFedP7Jf99q0vvababcnXPhTdTzezKK55QbTGNRCu?=
 =?iso-8859-1?Q?2KwPJiFOY8u1gIZDQxT2Y0QvzZ9BKpXKJ6T/6gI0+/ui/aY17es5/7NR0P?=
 =?iso-8859-1?Q?5gx+hdRF8naQTMmjPCLt96MFtUDZP2sZxl5+lhLuPvGTsXriWWYTdMEQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a9b41e-20ff-4b18-db9a-08ddf7d116a8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 23:05:55.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub2oDVu2tkUFGNQ4Jmj2Sen5GJCItAaLoewU9y2sbb8ouqqMQB+huPlIMNZuTR3J0MJdFzGDsSecuZaSsfTA3ods6Ze9Lxp1ZvYPky/QoBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 01:20:53PM +0100, Matthew Auld wrote:
>Currently this is hidden behind perfmon_capable() since this is
>technically an info leak, given that this is a system wide metric.
>However the granularity reported here is always PAGE_SIZE aligned, which
>matches what the core kernel is already willing to expose to userspace
>if querying how many free RAM pages there are on the system, and that
>doesn't need any special privileges. In addition other drm drivers seem
>happy to expose this.
>
>The motivation here if with oneAPI where they want to use the system
>wide 'used' reporting here, so not the per-client fdinfo stats. This has
>also come up with some perf overlay applications wanting this
>information.
>
>Fixes: 1105ac15d2a1 ("drm/xe/uapi: restrict system wide accounting")
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Cc: Joshua Santosh <joshua.santosh.ranjan@intel.com>
>Cc: José Roberto de Souza <jose.souza@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

