Return-Path: <stable+bounces-161543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106ECAFFBF6
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905F91C27197
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1828C03F;
	Thu, 10 Jul 2025 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfSusAGE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8128750A;
	Thu, 10 Jul 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135353; cv=fail; b=mLfNU8K1Lz2PmEq/i7Sl2KEUxHu4K/wMMbqvPIstGNdWBdQqScLeYdg++4n043TSWBUIvjil47jkmKBvIpzux3sUVpl03EEuRN2WTOZyUx+OCBcV1eJXGTFJcA2GOHeGxiICN8rDHkMYoCCEKb5nxWvu0DCwbfZMIu6HpbVqOi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135353; c=relaxed/simple;
	bh=GCnXUbm7fy9/BKI8R71DgVAMqK6pAIDt1y5giH6Ui/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1/GEGdMz4yGhJaCcaNfJmcGdZBm+g1l/hqplcacjxfnq+1kD7Bz9tqqTb3KMWSNs1K3IYN8R7Hu+c2St6A9EysO+OMvE3MJCxkNGQPN1XqxNvfIcNWT7K+kjtTxnoVsOESFCpfNngP8MUXt+26U+37dfBziiOZxcRPZZABUvwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfSusAGE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752135352; x=1783671352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GCnXUbm7fy9/BKI8R71DgVAMqK6pAIDt1y5giH6Ui/g=;
  b=OfSusAGEQsJO5Olz9dXSGZ6v8Ul0isnSnLzmxzJAr4FOOVfBBzoGd9rm
   PhUQIHz0CtMl8gPMHxSpPS2vv1N9TJuNhPLRTlpAunAIp3W+Qzfku1Ppg
   DZhPHqVjZIE5PJ4Op6qrOKchI3bDb5uVHDSN3WkMxoHFO8cT7YVGuJte5
   oTkXeBSwJkpJwzeIugVCPv4BY1mYVckRPaSpKjUeh9/F6aQTdny6Zaqyj
   Cdlz+rouWdfSTwFkt7zYjZ1B266MsF8Ur3Cb7ihkES1ciz5wKjVW7dyvF
   AhLnnY2C/8BA6bQESQOG6Mu19oo+wR0A9cJhTyvTmdpEWdDPG8Ax3b6If
   A==;
X-CSE-ConnectionGUID: Fs0IxJOwT9WOPFdhzaShqw==
X-CSE-MsgGUID: 4j3xxSFtS2e1Itum5J28Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54501181"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54501181"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:15:51 -0700
X-CSE-ConnectionGUID: wgHuTIbOSk6NcknsKg2ZyA==
X-CSE-MsgGUID: 4hsujQJgTLKMA1akO3R5oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156491941"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:15:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:15:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:15:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsktBuifkXIeMPfot9P2RgSoCkM6ZzLr+rr9+TyMchbCoJKuf21IgYq1LNkV6puW9HLE1jCr8AAxCVkniTUas7t9mb0S9GEy1DmpymBvG+VEW3gW/n6A0UO9r+mT5oPor0plQImXba0q55SNm2V4t8UgafR96tHzPh6M6vsrjhKXaLTO3fhd/dGazgqxGk0RWpmSSqC6tgDcIl8pH6EQUhKYwSZYHpaXWI1WnbDuL1Sg224hghpjelxC8es8tJgMbL7QYmwZ3zJtpGFqMz8lGFf8ixOoVxMwx+Hj+vgQWhpd9ADWvhNmmB9oCnVvI8UgxKriaDXoD+ZTRzNhkXNwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCnXUbm7fy9/BKI8R71DgVAMqK6pAIDt1y5giH6Ui/g=;
 b=fkJK1DcGO8DBsw0CJBBprr7asf388ermT7eRKRJZ5FqeEOALgMyYffg1L19HT1w5uOUDr8XhvK2EdUJMYN7XAC3BCEY5zsqStHIfiGojM0ltRDd6F58JczlVwTGOMrvRIIbh30TiHpn+aRbhIQYn0qVmcRQZKgc+Dcvrxr1T/qnhsYFVfP/g5UWIrG38MAD//wpjIoEnxKGyiNu5iBLE0YNkEHv/kts9RYxfsMYA09k14E8jlHI9cClTSRbW25K7stGOvh+5ESWLZvdLdhIz3ViVcz6Oa7ubjRgXk0ygNx4aJHGS2kWC7lM4xhwSjjA0wldcbKvbpXi3qTXdKU1ITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:15:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:15:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Alistair
 Popple" <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Andy Lutomirski <luto@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Topic: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Thread-Index: AQHb8JsDhmo0nc9lxUeepqGM5I/6nbQqqwhwgABYKICAAAC2QA==
Date: Thu, 10 Jul 2025 08:15:27 +0000
Message-ID: <BN9PR11MB5276F8759367004AD36F6DA88C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52765F651EBE0988E35E15FF8C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <w3xhahute7xeci2swawsaaet5frxc3cacufsawok6hzkeklzo5@jzvkcpwp46lx>
In-Reply-To: <w3xhahute7xeci2swawsaaet5frxc3cacufsawok6hzkeklzo5@jzvkcpwp46lx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: ed267b77-99a7-4b31-793a-08ddbf89ede9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?q2nMScfPe98qEHTB0FpWnAJbFY9uUQAymdOXO/EugLcNcK50FA2LZJinDX0q?=
 =?us-ascii?Q?mWHwazOwira6zRsrG+IkMDUJCGrz1j+IlDBQTQITbBjgcop5mFa3E+fch+WU?=
 =?us-ascii?Q?0HQYh6vEuEqPErV/UPEpkjImJy7X5PEsEwhOeei/YSG1GjhQlw9U0RMni89c?=
 =?us-ascii?Q?w5ceL7y+cpVQlMS5sXu5+h0Wyz6iTjUT361QOQh+HH3LZnFdH87Mm+lt9Wj+?=
 =?us-ascii?Q?IKX63nztwYp9CvaZi1fe3DjI9CGi41zm4/RmRHW/YLtOMjGmbiQKNQnkWsES?=
 =?us-ascii?Q?R8Ea1k+EIqXQ+Htyh1oNjPNNFpPPVJGLpbSorXzZGgYpNgJiq5S/INbyWwWk?=
 =?us-ascii?Q?DgCfRmYknMIt9wM2Bp0glKD73kG34LQKLFYY5wNWccYCNDdCjueq0wcTarmG?=
 =?us-ascii?Q?UDC8lsNw8SNafVSjVCy+PDi7VBep1zWyCY8n2H5xTt8Lu58z36sliXhf9lXH?=
 =?us-ascii?Q?dCOaXOwhFIwd3cT/Y9EyIpMMM42LZPfHJyb8s53+7nF+dMti87465SBlPrB+?=
 =?us-ascii?Q?l05ylR2FiUpF2G06rkBJEZcl3R24yyjhfuHEm6oCq7A8Ba9j4GVOoO3pMN0G?=
 =?us-ascii?Q?/eKxmheX0HkVji6ari6YPIuH9+1XgThzJGPGLDOr+fcHhJEB7vVUaVvcExy2?=
 =?us-ascii?Q?xcnagpDW7qrrWUz0ZEZ8DbzZH9SJB/Q0QVBxFgix4LVx28qmZbgFa0woI58f?=
 =?us-ascii?Q?TVQE+hSZGnm8CRsqmHjzLpHGC/oqbrhO/srtkvhZLNPdjquyGGvznS9T4q2O?=
 =?us-ascii?Q?UFa3lIHOQ5SCD6U2pXeMkdgS4ucmbCBslB1VVwMB2V5B34JRFJXwlsgV9IW4?=
 =?us-ascii?Q?nd03XENUVwtBbqzsUIGyaUv6u5qSCSU5mJCiD1vY+sDZDSXv1qiCxvw6+mgP?=
 =?us-ascii?Q?JY/0d7/RjaFU1xaGbwYIGFtnSiSMn/wPSaFyqNfxop5s7yTtBvYmiDh+SaaY?=
 =?us-ascii?Q?BbaUjukrvAvd/+JuJC6UoUtkIMvbVCox1zKZUHD8r35E7BsNC+LJ9RZPcc1x?=
 =?us-ascii?Q?Nk66xYpZkoo3mbrzh2Jvh/Je+fF3/QIXue3MmfvI2bz6EgYDbnSN95rkFMVs?=
 =?us-ascii?Q?sT6vpMrcndRAIiUOWtPllYEawtg4ub1QQ/JbJanQ0LIeAJ+G0gFwzMTQlOuO?=
 =?us-ascii?Q?wGAPuuDItflAva2GmQzhy7k00e4ZvLh+9WgnMgRAY1A2MPnqLSfxnAIoYQxf?=
 =?us-ascii?Q?Gedp/VlEmOB3u7U+cV1buSIbbrjc6y9ApEWbkZTvsrJmU7fcqO4I5e9B5/ZB?=
 =?us-ascii?Q?fOTi2lnC5YeF1s94lAbJEWwXY0M6KX62EbcYiXSiag++d/Ri3x5BxSpzu7tR?=
 =?us-ascii?Q?wVfzkdTC61Oml5G0H9C8R+fOhEntbVOeGnYSDnAIM2UoYS5TwvTpTv/3bop8?=
 =?us-ascii?Q?rTp3Sx+HejZnFvbc+7H3MLTiE+kOwvPhXAGKM6XSXUcJPrQSzKL0dBVPtmC2?=
 =?us-ascii?Q?jdd52dZuLKC86bG1pQJKJdp5a+07gHOrL573OUN9QXL9ODLeqc4pYTfH21v6?=
 =?us-ascii?Q?VxpyBLheMtQsEls=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aCKjnEsBftyxO8nHHCAx3PN8s8ONr2BANb/zg+VkOHf+OIbRRIYLfyDpxjtj?=
 =?us-ascii?Q?Lcv7l9EJteMdNpx//nvdSwrq6hpR1/mzdYFQB5yJwxi8cHKG3BvmYTepxPtn?=
 =?us-ascii?Q?KCKFJ6RkVCIQolzggsL+Ti3jQqqVtZLB5J7OH1ZNMPAfcE05TTDeQzqG1SSE?=
 =?us-ascii?Q?OwDC5kXWdgWtqTVJI1APMcFXmrOgaw/KxDrIvbK1XglP49owa4Md2W7ru/H/?=
 =?us-ascii?Q?DQzBfbk9IqWVCNygzk3J7V0d7i6Q9iVfYyMkte/YnbEEqj2ndFYXF3WLsDcw?=
 =?us-ascii?Q?ToX8lv0rWoupAWr7J49SHBWsykQkJKt9lR8fPz5dbdV7st6H7I72RXXtrqJk?=
 =?us-ascii?Q?EzP4aeZKlQz7WcZtAF8Q8NM7YwjrFS550QmpDVFTebrDf2MoJjpYCAo181hT?=
 =?us-ascii?Q?oUDA0VoaFBq6j5rGxwU1roDo/DNcIL0Mp/O2ojWbF33I5aLV9WL+0OZ6IpfM?=
 =?us-ascii?Q?gP+nYk+9JXyD0rm4FMqiWv4eAZB5rCCExqV2Ymt7ceT5xC85QAN+ABM1Qly0?=
 =?us-ascii?Q?MeIfrRosjzTpHc01bYodSfVb9h8kFbknXuRHALqmFVLTNX+5fthgtAvzXcoR?=
 =?us-ascii?Q?B+eVnTlIF3nY1U5TGogFK+TbdOaBDZxVlfplhL9b65Bu+homqUiKL0sKjDw8?=
 =?us-ascii?Q?d388+FkDbEodLkBinpCSdPTlI5y1Iz1stYYlpWudd4liDA2MF74z3sWI/gUv?=
 =?us-ascii?Q?ptD59L0E+NQ8yLPtknprVO4+g5Pk01FSW4hlrfGeIJh3HMbWQ82gyb8j5yKm?=
 =?us-ascii?Q?YFqEU/1kz9pnumGIYua0m1ukOOBkp20pD4K5dBO6soHLbwGvYk0FwNS2xaXn?=
 =?us-ascii?Q?MfFXo8anNXNczBW9TD6VXM6gizJ7ajMHe5sPoDEOGhq30TZn8kp3rMCxkjKN?=
 =?us-ascii?Q?1GqlhNV0sXGlfxeyUwmgtj3NpMyG0UBlXo6W/5Pd0gPJpcogDgkrGVL7NVmK?=
 =?us-ascii?Q?5efOikUVdVX8LD1aksqj7Ga4YAfUTZpUWaZd4aIFro2pp/dyGLf8pV36j69n?=
 =?us-ascii?Q?vzo+FqZhJF7CVcUGW/5Z6akx40wP+ShDwi60YsFBN8+9XsRU2TuM7z38OA0B?=
 =?us-ascii?Q?gX+2AgOv9nwdbYxGmiFdN2528FG7HeGiFOO8Ps/NgvU9SD67lBpLxStIZMJK?=
 =?us-ascii?Q?WmYtVp3BsWaXFr2+9cgWKPu0S93/NVYsXyY6giCOehqwuq0LyehZ1YGxiYGv?=
 =?us-ascii?Q?siKK06s3aw+2uXOWjylOtkSX7QT7gsoCqyppu8N2qGgLFcJBT10/wRzAtYEn?=
 =?us-ascii?Q?N2yUCWj21UruH75i3lh8bPeD9P4mu1VUVuhddPETAZyjSDwdDzohSQhNqlGn?=
 =?us-ascii?Q?4VOl7mkhMBsZ96e2ro1/cu/eSApcOlJ4w9V1vMfeR+1ME+1/ciLIL6ld4GiR?=
 =?us-ascii?Q?jHIk27cd6K9qJdyCi1bmIa1LH3SONqyRMOiMIRaMPdetTkZZIDFAFCIDqmGJ?=
 =?us-ascii?Q?Awn/oJM+XWrfP0PVbcHkB1YJeXvCyby/8S0qPK2SQLtUHcQAix7kAArZh76y?=
 =?us-ascii?Q?XYdTR9Wq2/BxrPpL4oT4iIgwjJomZfbOkCKr5vx/QdK191hwCDM294BSPvE3?=
 =?us-ascii?Q?V36sjJ0g7gicBLz/XeNHWEPrw3TPekCpKahbnQKA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed267b77-99a7-4b31-793a-08ddbf89ede9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 08:15:27.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GjrPEuA/jIcTAcBloVIchQaE+ly6OKmN0t4C79+SIGjH9JY+VUxBPpZvXy8FGjW/E+N1mV9caXbSJss4B7XdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com

> From: Yu Zhang <zhangyu1@linux.microsoft.com>
> Sent: Thursday, July 10, 2025 4:11 PM
>=20
> On Thu, Jul 10, 2025 at 03:02:07AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Wednesday, July 9, 2025 2:28 PM
> > >
> > > The vmalloc() and vfree() functions manage virtually contiguous, but =
not
> > > necessarily physically contiguous, kernel memory regions. When vfree(=
)
> > > unmaps such a region, it tears down the associated kernel page table
> > > entries and frees the physical pages.
> > >
> > > In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> > > hardware
> > > shares and walks the CPU's page tables. Architectures like x86 share
> > > static kernel address mappings across all user page tables, allowing =
the
> >
> > I'd remove 'static'
> >
> > > IOMMU to access the kernel portion of these tables.
> > >
> > > Modern IOMMUs often cache page table entries to optimize walk
> > > performance,
> > > even for intermediate page table levels. If kernel page table mapping=
s are
> > > changed (e.g., by vfree()), but the IOMMU's internal caches retain st=
ale
> > > entries, Use-After-Free (UAF) vulnerability condition arises. If thes=
e
> > > freed page table pages are reallocated for a different purpose, poten=
tially
> > > by an attacker, the IOMMU could misinterpret the new data as valid pa=
ge
> > > table entries. This allows the IOMMU to walk into attacker-controlled
> > > memory, leading to arbitrary physical memory DMA access or privilege
> > > escalation.
> >
> > this lacks of a background that currently the iommu driver is notified
> > only for changes of user VA mappings, so the IOMMU's internal caches
> > may retain stale entries for kernel VA.
> >
> > >
> > > To mitigate this, introduce a new iommu interface to flush IOMMU cach=
es
> > > and fence pending page table walks when kernel page mappings are
> updated.
> > > This interface should be invoked from architecture-specific code that
> > > manages combined user and kernel page tables.
> >
> > this also needs some words about the fact that new flushes are triggere=
d
> > not just for freeing page tables.
> >
> Thank you, Kevin. A question about the background of this issue:
>=20
> My understanding of the attacking scenario is, a malicious user applicati=
on
> could initiate DMAs to some vmalloced address, causing the paging structu=
re
> cache being loaded and then possibly being used after that paging structu=
re
> is freed(may be allocated to some other users later).
>=20
> If that is the case, only when the paging structures are freed, do we nee=
d
> to do the flush. I mean, the IOTLB entries may not be loaded at all when =
the
> permission check failes. Did I miss anything? :)
>=20

It's about the paging structure cache instead of IOTLB.

You may look at the discussion in v1 for more background, especially
the latest reply from Baolu about a detailed example:

https://lore.kernel.org/linux-iommu/2080aaea-0d6e-418e-8391-ddac9b39c109@li=
nux.intel.com/

