Return-Path: <stable+bounces-139089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0CAA4125
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 04:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550A61BC7B06
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6E1C8603;
	Wed, 30 Apr 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtSwoydI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828413957E
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981206; cv=fail; b=O+BdmoeJZPqkR6w9YLSzw9lVMHDegE+cTU+MGhPZxJ9YHsbGa5KTJB0vgXyUUzN+DbPoIG2srcFoW/Jskt8Hqyxs4uv/KVDf66bsFIqhQjQTm8XFTQDhuPCKQvr+/BZbWOhjMpstF1zxb5194mL5CLawa/W1TAZc3uMdwBcY0Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981206; c=relaxed/simple;
	bh=/Ws9Eq5WGmi0bjAI7IARTmyVl94Sc2sEHhQNGrF+Um4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G9AvrqI2s2nVVtLPvctRCwjyhW154br2LMs/K54BoefAM00hYdtMDM9hXkVdidxXzXhsMAin02Cam1awwJQSiq9oBc5JoFn5DjQ9tNqhmzXyAm0ncdn+28m8+GS1Oth1Br+G+2Dm4UvpQK4uBO4/d8ZRnHLtgY3IODhxBHSqHCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtSwoydI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745981204; x=1777517204;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/Ws9Eq5WGmi0bjAI7IARTmyVl94Sc2sEHhQNGrF+Um4=;
  b=gtSwoydIe0vpUvcjY4FcLDNXgsRubr78TOTX5TILRWTNia9822fEd6Zd
   4l+1DrizDxzBPG6T6iIN3+JTfgzbtk7Yr9SFefjdv6XfdmXpI8ozD1UGw
   ZgfjVNl4okGXQrhFEqXWsQsoFwnUu57DD3XstgdrIlCNQotfAChKrNjOu
   yvpTsRroC4+YUUyVHdkGEKmIJ64ZGT3p5pen3G94yinEMLVvBD7jGXSUk
   5rl/nH9fLXjU9PYsveH7AVvHM2rOAxROd5yEdapXp5w7G82SzbCdH4Mze
   rBmB3ed+cITDSF6O+GWGWNYXypTrrt7B/A77px1E2HVHR0IJW804RFSSG
   w==;
X-CSE-ConnectionGUID: 1d4bgJdUQK2WJq/TxxVsNQ==
X-CSE-MsgGUID: 94gGAC5xR+aiD4mkEA8V8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58260987"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58260987"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:46:43 -0700
X-CSE-ConnectionGUID: SSOTrRawROWBa/LJmsbW2Q==
X-CSE-MsgGUID: 8pD3oj3NRVeDdNxknos4Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="138009776"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 19:46:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 19:46:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 19:46:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 19:46:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMEFWFfDeJAwtyKVl3v8/xSojh4YTHeTjah/n5l9X+I0LJbVTALGg6+Pg5o0DSiXoiAXyaCB7dGpB632c5EbWzICK61k5eHlBaaHBmC2VIlMTZgBfMh+91omooy868/VaHQGo/yubAFWVBlCwI1zRLD/jcWBWIBShh3ugxQjYrggt734ug10K1MivDPPdFWjryrfRpJrsHb7XVbKayfE47W7eaMHbJscIIBkBoh21Vthm22XMyrJiL8c1oDsVTlBC1x3N7VmDQivAHcSeEgrP2GePm0kgnYZyNTlZo/Tc8zaTzHpNPavpi7urYlwlKizJQUAIu6xyxCMksSdYhe5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6Zh18aiu4rSRB8JsoAXeUz/RQsL9Px317NX/IJJzZc=;
 b=Rf1MH+/XiRa9Ls+Jfqbv1Vif1NRVkd+L3+yjjwyiLvSA/4vfGeuJgA9iMnlGLO3KhX4diNuK6B99ClK8pY8pW2Qy/F+6Qy34oUU/OcpKDJblDnsdATcgQJw4pqAd78PsFgTcJdmAn4Rc/hXCOimWyj3hxwHtZr7KawN1us486pKAuASbqYaEOXKbAqlM5xcUNJvSMt9Mzcxsn8Vbl6GujtrBMxj2HkosEcfb+g1Ziznob7EZ0Jhl7id+y/WWsdFm5gV+I3f/VZltPsJR3omPYhUq7F6bxZLK3U0+io5sX52RQ29Y2WdOtjvywhzC7yEHX5kalmlxCYjTX8VMMi0JRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 02:46:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 02:46:26 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.hansen@linux.intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Kirill Shutemov
	<kirill.shutemov@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
	<stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Vishal
 Annapurve" <vannapurve@google.com>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH v5] Restrict devmem for confidential VMs
Date: Tue, 29 Apr 2025 19:46:20 -0700
Message-ID: <20250430024622.1134277-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 906621bb-089a-4e8c-eb0f-08dd8791337c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLSOnZ12lqrTA3gV6qHd2j30ysEVq/owmRczih0SRqHNjQSAWWJUN1CRDaFG?=
 =?us-ascii?Q?36UPTaXqTtTJgIa8yGQNFyURGT/rQSCqUBIOGBJ2aZoE4Y7EHCzLkdRZZ7uf?=
 =?us-ascii?Q?ZzV/P4T4ZM/VXW2mploxK305yT2IygQDKYdU+D1Ye1aYwaEcm6zUcIi1k54F?=
 =?us-ascii?Q?NJHdNdps5iHR2Hg6AbZy4d5U/jIdZgESD17aVprQMZUTB8C2H7+zbVK4RTuG?=
 =?us-ascii?Q?rINJy8OX+fLI3CzD+AEfNwLBiXFDSlFUqazJEMvIthY/mPBSQZZVjiziQTtV?=
 =?us-ascii?Q?vcT2Hp5XD+6nHJ8mp0wx2cihPuVIdszjOCz0+IA7bTAdl5T3hU+SCy3x0KTk?=
 =?us-ascii?Q?klGGtbXR1yfozNC9PhDvrF5v0ISGhV0/nSTZg7AUjSLTC4ie8Imn3Zaf49HY?=
 =?us-ascii?Q?8vxyZH5OnDGfhR7aZZGEJvTpQZ5bdbgVCUTexu8+AKc5eAfZrPum45408WLj?=
 =?us-ascii?Q?CIIlJHFoNhzchMR9P75ROwewtyn9+3k24GjA+itgHirlKCeog1y+sqIgYybV?=
 =?us-ascii?Q?4/85Lqrlhec/knY3iZrNZXUIBPSpOgj9ajt5lwBMFV5Dq7xx4n7JhsEHHqo/?=
 =?us-ascii?Q?FKrCrRpRfU4oaSGknizkL/6y5doj1+9bOUScufp2MdfashgIlsfsH/QoHY17?=
 =?us-ascii?Q?9NXxdZ7uzYibusZs1M8Tp8jUisFIWSZi8am1HTTjIMalelWTUZj6A9pSOCI8?=
 =?us-ascii?Q?WtSzz12mTIoezUaXsO3IOE1cyERCbh4VhSQdGEa7H0fEWjb87iTWV0g7L4GP?=
 =?us-ascii?Q?JYjSsN2+RYM7U4W3FW5vrdkVxJQxNEwIFNAbCm8e6Vx5MuIqiu45lTw+8/ks?=
 =?us-ascii?Q?Mcs4mv5ktyw/AILYLCGsRt2HSgl5ebVo0EU6uORHC7OWq+vEFQcAiI83UxNj?=
 =?us-ascii?Q?UTpTDNWBCXjH7SuciPZkjm/jqPTAL83Dz+0+gN1zHmFeSqZDm8oK9D+L6koj?=
 =?us-ascii?Q?dz9f4mdC0ju3Vvdh4Zk+GAaNKhufFJ8LQT3MLh9hOAV+/mAsKITvAJ3Un4AU?=
 =?us-ascii?Q?y99XnuJn3oZslFmgWhNWuzlj5l6EPWQHOFlyg3FfK8avdq3TM3rvo8iA4/oK?=
 =?us-ascii?Q?B8e57PanRaN2b1iIi4PYsvWeEmXUtwUZYkkt0dZeOgehYshCFjbuWSmjJy9V?=
 =?us-ascii?Q?g8SSCgShznTqLXkJrW8VDP8k7i/UAk1MwyUzlPFnBtJ1e0CriXsP59zNS/PF?=
 =?us-ascii?Q?iqA7gh3nh+l3kumaiSB6dbEEULDSYRWFT/tdSqPBbRvKW2s/+clBSAAzXkFl?=
 =?us-ascii?Q?UdhcmQE3Ozogty8uwZ1rhnJklJyjOpzvTLgkJUBWRhgpWWqFf4OM6smdGgOj?=
 =?us-ascii?Q?Hy784m8M9apVZEhb446yuGtcDuHx9/mgyvM/6CLgaTtCMsY9MJXsE91+CWSg?=
 =?us-ascii?Q?JQmNf/WJb0kX47MXJa9QHaJgFk7ITH74RDSR88F/QTppVAXXT58O3x0PAal8?=
 =?us-ascii?Q?xvHnbVYzAhw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9tqPzn7Z/JPGsHsWWkaGMPiKOjzHfOBaoslkkCN95nIP6PxxfCWDfimJn7N?=
 =?us-ascii?Q?k83M+AkEQQBzh4KQNd73Ejy+7r/N0YQbmWh1lkERKcxNvNg8+g3AZb3c3Lgx?=
 =?us-ascii?Q?Ri4ZQc3BsI0yKhvjAlcgGaMvxDABu5kbh7LlbgLCde5G6ViTRTmjLAWVoQYJ?=
 =?us-ascii?Q?TjBHMQFKvtlPsvnY6DZ2VN8xHKM6vK7qxhpgL0iWsMfWcL6YabYr/nUvh4lq?=
 =?us-ascii?Q?LSFHz1WWrhBIp/oJ6TXgnK0y3mIGX+lG4d59n/OXl6wA+sKjSJalOcyoelxy?=
 =?us-ascii?Q?Y37VqpnEDohG8vWM7B3vl2RndDFXNFjDka240h18wQhyGr1W/RtLQKCqw6VQ?=
 =?us-ascii?Q?XTyc3GNPA4EQFCUSeMJMpzA4MiX2jtmL/4CWn/gSI5Xach979KRtZpnlMu2a?=
 =?us-ascii?Q?5LclC0FxbLQ4C4/tQ2YUBwvG/u1mA1OO8qfM97Hn69wGLXNV8xtSvSCx4MgO?=
 =?us-ascii?Q?4U869d63oNALRK4SMemjn0maSAvWMyAsLq3nEHSEDGJ8XZ6M49HkcIkya2k/?=
 =?us-ascii?Q?kMxwxaiMmUWLhjY+CEgaBKZOZQr2YCgCzGTzKssHa4BXZEMZJ/szdbhsG/y+?=
 =?us-ascii?Q?o/bwXhPgoMrJbs6xAp9fikeWoU4BptNROeKLdci0wSc7nyfLeD94juBHcdIa?=
 =?us-ascii?Q?u1ARJIxHbkr2Dzo/+iuRsxGnUzpvJ5HVYqKAtYlnhQaoBHs111CWavVmzNEu?=
 =?us-ascii?Q?luKCPDfTlx1ouoK6wLhX+WdcEDtmXC+DyHF+udMI9e4s580VxXrUvnMcmmh5?=
 =?us-ascii?Q?AyiIx1+4FOdX9vnSPVbq2LOSD0jAXt1vgwgwR6L8BiEJ9tTFP3J9tgT5NmI+?=
 =?us-ascii?Q?2ca/uI4QINFR9Y/ATZfh9pmKSjQXN+LOI0FuIh5CWslu3zomp1eeBFxbbUZm?=
 =?us-ascii?Q?OuApT5jitivYx2AzWzed4jrfcoZn95k/ed8q6onqo/9paiM1xAP7Ulhbyxh2?=
 =?us-ascii?Q?KsHX7+reOopPKgsPdapVbgqqmJ67TzFaTVl2+teuAIojIev2Xzfi3xX3BT8H?=
 =?us-ascii?Q?lP8OEUNoEax2F8NzBQIb97/GScsZEa+h4U2VtJZ2Eg7UcHkP4n4I4ovvAPtk?=
 =?us-ascii?Q?M4tS96pNqlWWuBoXuZ9bJhJkDkuB/amcwWTxo+haPeS+bWGB8R03tah1Gyfs?=
 =?us-ascii?Q?zjZC7YexyoYSwjqDCQh9lkTIl27MFwn+mC9jU7shGskkvR8h3UbB6rWZrzmw?=
 =?us-ascii?Q?s1Jlnehup/OPgSq0NmCRzVS5ow8/TkIyHVs7R3iOIepK3kMRif71pPIoI/8E?=
 =?us-ascii?Q?RmjSsgdWdsuxoYiL+YL0MFsJUDLPHwF613tsrYMnS/zV7zLOYAEk9iQPO99D?=
 =?us-ascii?Q?3u2FaC/6qB/mm4RDOgdbFjUwczoROuGr0aK7LuC2m2oO7rm8qV2q2rNI/3j5?=
 =?us-ascii?Q?fxY9rKn3Xd0hc7v4SgL+OGI8n+87Cw2hHpdt7LEXq0GiGhHZDbfqlTYZLvbx?=
 =?us-ascii?Q?HXZ/fdQWoqZQb2cGUl82+0mfeXmjqe9XyLkklsmWn6jn4npy5Qe7lRCIWAVZ?=
 =?us-ascii?Q?/QQ1qoaxrGUxJRnSOO03xzOg3I/O3DM5m97f1QX3CPv7zunEn9WXSqlvpOFL?=
 =?us-ascii?Q?evZyugksos/21LUxEeVAR45ihIUspHGQVtzexxOJM9P+72zQ+dqJmynWdz4E?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 906621bb-089a-4e8c-eb0f-08dd8791337c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:46:26.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ogy3b5RSRNf8+GiZdU7MxQ/T+xoEv/kUcAekTCFa6K27UWM1zvKUrVoL8sVm7V0ApP6h7UdORbRxpQIsNWtJm/9nKFBMJAhlnr5Vi7e9xbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

Changes since v3 [1] (note v4 was a partial re-roll, but more feedback
came in requiring a v5):
- Fix a kbuild robot report for a missing header include of cc_platform.h
- Switch to selecting STRICT_DEVMEM and IOSTRICT_DEVMEM rather than
  "depends on". (Naveen)
- Clarify the "SEPT violation" vs "crash" and other changelog fixups for
  devmem maintainers and other arch maintainers. (Dave)
- Drop patch numbering since patch2 is a fix and has no dependencies on
  patch1

[1]: http://lore.kernel.org/174491711228.1395340.3647010925173796093.stgit@dwillia2-xfh.jf.intel.com

---
The original response to Nikolay's report of a "crash" (unhandled SEPT
violation) triggered by /dev/mem access to private memory was "let's
just turn off /dev/mem".

After some machinations of x86_platform_ops to block a subset of
problematic access, spelunking the history of devmem_is_allowed()
returning "2" to enable some compatibility benefits while blocking
access, and discovering that userspace depends buggy kernel behavior for
mmap(2) of the first 1MB of memory on x86, the proposal has circled back
to "disable /dev/mem".

Require both STRICT_DEVMEM and IO_STRICT_DEVMEM for x86 confidential
guests to close /dev/mem hole while still allowing for userspace
mapping of PCI MMIO as long as the kernel and userspace are not mapping
the range at the same time.

The range_is_allowed() cleanup is not strictly necessary, but might as
well close a 17 year-old "TODO".

Dan Williams (2):
  x86/devmem: Remove duplicate range_is_allowed() definition
  x86/devmem: Drop /dev/mem access for confidential guests

 arch/x86/Kconfig          |  4 ++++
 arch/x86/mm/pat/memtype.c | 31 ++++---------------------------
 drivers/char/mem.c        | 28 ++++++++++------------------
 include/linux/io.h        | 21 +++++++++++++++++++++
 4 files changed, 39 insertions(+), 45 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0


