Return-Path: <stable+bounces-88075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E49AE85D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C861C22B50
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD21EBFF9;
	Thu, 24 Oct 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fm3OJuqk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C681FB3FF;
	Thu, 24 Oct 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779307; cv=fail; b=I3xC3hsrCChrPCEIi5wQFMxvu7HJEC60+COC5vAZDDjKG4UosEhmqx0pjT25rUzkNvE67C1fQEyGmxbDI1TZEm9lOH2OVCsJ1/XSuA7uq1SlPyRBjZfD4XVGg9Bz5pn7yDeRNZIjWx6Xu4zwiarnxd/z2wBLL6HIJ8znP45Zf8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779307; c=relaxed/simple;
	bh=Oc4fKNxh6tuRTYeERTMT3lCEXOx/hdVqPv47l48r+Lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o0zKwDLLHWFQZA+JCDnMKvopgPVGcj/gKY2zhIbFzLhoqfj2L67niQ2oqcT2Hz0FH3/imaWN8CF1m/aBuEErwhHgYbwyjJgP0pOIQjoISLZMt1SwtK+l2fClHEzdcVkTP2Dtd+x4gsqmNxw9h5tBnqfNunncJTjmfpqgvoQZHx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fm3OJuqk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729779305; x=1761315305;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oc4fKNxh6tuRTYeERTMT3lCEXOx/hdVqPv47l48r+Lg=;
  b=Fm3OJuqkyeLVwrmzklTNny5b/tHb9NpmfLCmM5d9P6L/3yGSPPw703Rz
   U8OaCL5Mi56vLTpjz0wcRq+fhJY62cpdO+COyuefubCVDWlXSq1bPFSCK
   7lZCAWIX+gyisUz0kTifW+uIVHNOqyFmit4jQPQ3wpdYmhpMoYBZ//cBG
   57CcePIyOuexk+guSb4JockVOUQ4affP17caW/nzTvyqPiPbcLxyuXS6m
   T+uLVTX31eEXjn8MUydM8QymM6yKfT8o40EKHWu08OJ7J//MonxeiR/lA
   X9YCPWn+Bgm9UXo8ygvUdO9d31/WH6KBeLdkAS9pyN/GhBtsrgkkZS6yx
   g==;
X-CSE-ConnectionGUID: f+/jwRTDT6qvlYT1ugxSaw==
X-CSE-MsgGUID: KBz6l5FrT32X/EmlE32RGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40778576"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40778576"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 07:15:04 -0700
X-CSE-ConnectionGUID: HlwQnPy3SU2xsEbCIXKuhQ==
X-CSE-MsgGUID: fHuF4OjmS+uBYksvCrAKTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80523897"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 07:15:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 07:15:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 07:15:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 07:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhqYc7XPrSbcY/RW/ZgDJVSawXTt5AMNTioyE2tC7c9eNIr+r3uM9J7uahOoA7svHxBBMTHe3I+SI5DcT3dYfheD80Ddpu2kGcVR1boKgMchkQlySY0qNzwGUHHgmHapSGfYp4HxwHuoOiKEgPwhY/uZnCyTeQLIWTs075fYO8WbaCd/6Jvzd7HtbiQNmryx+oKzBXf9DDtAItpkAxDWnyjG8E7xipF0Sw1HfbWLON9OM/tblbx6k/nlCVyhGqxn9e4ERlUff7rgKNAPItMYxaVCEwUj2ri3z39T0Q+BZJSbz0MIje+g2a9W1YobU+pQFbzWvjl7I/5+pyzFLDeyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0ZuhslBiCUFLZAq5egQjyHaaC3cb+GIHa4gB9Q9Pk4=;
 b=kG7oIQ4yo4hs1ZfUiRnCQ0krYOaaPvojJjt5Z9v2iYB5cmPf+WC9qQCZyFKDB9JfalCAUuoGN6kRLXe//q2GNAEIm4aJT4zJmEkNm0P+rVI46sZUY61wGRXHdxAUvzWLpJLN0KyhP8pvUQM1Q8ViUMzPOyeB+J017uKEHF7V/xCEcrZP+5grgDbFl4vVFi9R81+ZduHXVEX+JRbPmexnNT54Jp2tizP96aCvt4XuJqsD8sHY3ehWwHF39TN2Vd+R+8MRsolxqum6l2JvHYyCd0BlyF/1mo/l6zeKcABYbj4xffY2Se2FHblMdvmlGjKvzesbG4jzclKPlKJI4dvD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 14:14:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 14:14:59 +0000
Date: Thu, 24 Oct 2024 09:14:53 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: Gregory Price <gourry@gourry.net>, <stable@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Message-ID: <671a565d2289e_f5b20294d9@iweiny-mobl.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9aa38e-0a8e-452b-daea-08dcf4363e25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWAov2NpKIEm0viMIXwHT57lY0ftalZPIRjPQg3EHfPWWJA1b2LHK6aFFiJX?=
 =?us-ascii?Q?SVEDt2fPoSVV5CNKiA/01oZFAUVD7J76BEZ45koy2kxsfIIorJXaCU8mKk8g?=
 =?us-ascii?Q?XORMPZ3JjNVuV9CQkYIrC49YSvBlHYj7c5nDQQAIROIEAiAlDFDKSQzGIUNP?=
 =?us-ascii?Q?xQQNso3p2LeROsly1PRaQUA0OqAcHBOveZp2AQusn4JIedthsvee3XiQ7bQf?=
 =?us-ascii?Q?92w6a9kXwJ3jSG/InbhBXCvo1UAlKWJn+yPt8rlzzzWgOp2AJfvSfRsk55eu?=
 =?us-ascii?Q?Sved6GoziP8XEo9UzQ1laewdimGem5/WySh5jgRcVUEcX/bV7LW1GzoMZqc0?=
 =?us-ascii?Q?hwfcbrIIbQilvb8WhJdhtxSoTnDfWsjLHsHEx70+nSwZ9us5kW50NCWR2WOI?=
 =?us-ascii?Q?Dq2P27bLEI6oM81zV+o6gSbRUsoMLGJINt7XhO2YsgTrVi1HSUdanSSAxoKU?=
 =?us-ascii?Q?ZTBb6Spzr2a4Y+j724EOVh/46WpynNxt3BCdktOPTHq6GJYDaFc5OWzHCISS?=
 =?us-ascii?Q?CWLFB656QzlSWMY24aMjuSjcj9JUpxl6Auv5ykppi2qqSIJgbfR2ToP92q/9?=
 =?us-ascii?Q?eeoqWcksFNIijXk1Z2qnDnk3xWSasOfQp4M3VCNLdtIF5v4HrlbsMiUr95ui?=
 =?us-ascii?Q?SgmYuOuFnc4YNT5ZUPPSUKJTpxkwBE1FAq+aoVYirnBsuiWmDRxUbZfHCqSm?=
 =?us-ascii?Q?erH+G4RGE/hbJMVLkLFinhOJ/HD8F0nOsXAYEy0ETn0tBhuIb2Alnz9ygAY8?=
 =?us-ascii?Q?0VZA/v3PcxrRsd3VbZhFvVzX49B4AvzRvfpYQoEEsOvOreIcRtzAgjGdLonA?=
 =?us-ascii?Q?k09LWc18oTqTqCJLbzWsqEZchRpJlRLq+biRLY9FOp+D/Q11I89i7AqrVKDv?=
 =?us-ascii?Q?6iHx2yhxIgvQP80B/cIUDyTEEmXAM1R25zLW0Q7HiC5Yp4mBz8DydbPPngz9?=
 =?us-ascii?Q?VAG43ac0hq6hQalrxKeiYdfEOZtdJxaBbt5REn56Tl/k6cRe/wd+oJnaShxW?=
 =?us-ascii?Q?khy0iabKrsJim5HzOkNGuoagJwkC6P6pFpK1Ht36zHGJzDnTkpOQbryzXfVg?=
 =?us-ascii?Q?DxWpMMHvV91qUMF53suj+Y85oqmdAj3Z/QDTWwSytZQB+TuVZF+AKT2Uw7p4?=
 =?us-ascii?Q?Xpop7nhxvjgrWfgPbuRMjm+x1hlKBdptmGFjTjsn2FkaqSUl7LDHffkpX+UR?=
 =?us-ascii?Q?PGXtnL0I7LkmZFHmZLa8tjrl9ZBxF/aOChatMlM4dyhlpb3Aw+nRgyug0vwW?=
 =?us-ascii?Q?+sy7rkJAZXy6FFJROL9Ab0b/fE4/Xt+1JnnTdOtodlvxURb3jW5yqVoJjqwN?=
 =?us-ascii?Q?rE3Abj4O6lYp5aVH073+lv2B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lz1BJfZo7B0OPCQeacgfu31cHCTtsu3og3RCB9owA+2NJOlTVIimoAW1svyh?=
 =?us-ascii?Q?kycHn4266l1kkhqaV1yWsUrNjTVWGSZCSadr2FhWSJn/varihmTfrrsPET4n?=
 =?us-ascii?Q?T4gtjRue7qxLKWp89mAGhKLYy/FHco35W8NZo3HFf/DNLcq0vAZu8245WQmL?=
 =?us-ascii?Q?ki4dUP5g56ZANtruR8WaKzW3AfX3jflvNp4GzQCkPnjWVrFB6TJwAyJEwL+r?=
 =?us-ascii?Q?1D3l6GyJv2XYJaxdK5AS5KiRcffIKm/fxxE1ihz/3wkXVtHFucYp+zx1OlJQ?=
 =?us-ascii?Q?0TaYTSxtF2erO0R9dhgUefGEwqNWceqvarjtz68VDnlMd2kJ8Zg70Mw8a84k?=
 =?us-ascii?Q?OV9jC98wXei2gXYU+Kzh0kiW5HeTLFirL8Csu728Z/km14sg73wv0fMzxcDB?=
 =?us-ascii?Q?qp06g4bPrWDO6yzep4PZlTx9lcVZmlaBdmFxbVGumuKNeQ2Z0avOxtGl0tH7?=
 =?us-ascii?Q?gFrDRg/lH+0dwEgLaexXP3qee9icJPJzK1rsxOLJ0QlBBYDpd0pLqFWJt4l6?=
 =?us-ascii?Q?a6s+iIB+BkxLz2+4ZTePYaXifwbgRWBKKRWcfbFWiQ8pMDoOv+yAb6ffwuGM?=
 =?us-ascii?Q?CLnmz9CmWRdNlYRGr38/f9Gxwf8OGnrBbcVPG+NanunWi7y7dhhoWPiga+Ea?=
 =?us-ascii?Q?w9fYJEPh8kg0N9iVhh9MqBcbdC7o5yeeNd8Yuh23EoO5ctOxDB04mC49lvZl?=
 =?us-ascii?Q?770MNgJw9RYT/YGoTu6BVeLs6eoMw9aKD6gjB+2U1puOmBMsS3ayea/WBDlw?=
 =?us-ascii?Q?JECCwQSxM5LnDt89fec/QS1IMHcbHwhn69N/T2VD16L/k6ONvXCY/gpTxxro?=
 =?us-ascii?Q?BTYeWKp3MLQTVD9lu9Bk6nQvDRmX+zXfWg7MEfOHZTWjK3W5VpNBtiXrechO?=
 =?us-ascii?Q?x9Qy/ssJY1lBIpMZ9CpOzMewIO399c8ZSHo7jlzxK2WaW25R2QU6VJi43V59?=
 =?us-ascii?Q?TXWyQB/7B4zq7ZOWiqoKIKVl+Rwox2aC28lmo+HagjNugQa+uGPDACKJjRN5?=
 =?us-ascii?Q?Ycb8g9DpZ1gh4BuD7Y4KInMlxPfD2S+Gg5yGaMqUO78zYl1eEvPNWn/Ux88N?=
 =?us-ascii?Q?e6EA/psaLgLSlCcYxCN7HIuh6igc+kpkxJXWodyDGUSE88wNg9wd9Bv8eVMC?=
 =?us-ascii?Q?jgBBhu+wGANuRZEC9NNFdDgAGsW1QhO8VwUscps03LRpuP+ZHeBKZzkB7NcZ?=
 =?us-ascii?Q?fxE3AnBu1jOrpjC8c/NEiW3zRNx1BXtasjeiHxuMR0zcY4vtfcankNx2I4d7?=
 =?us-ascii?Q?0o1kB0qc2CF7pBTpZQs5p2lKY0Vyh+muV2un0sdrSF3J/LlfKoYBOM1chihF?=
 =?us-ascii?Q?VMU+nZP/+8lBTckgGkrw3Y/ZGXSeghkUsmmtjLeSa+UrWnZjpstOON3RdKGf?=
 =?us-ascii?Q?IHPPBs53+woNvRn/bfhTiefz4m/6sKTsn3TsJotSSmi0tGIwhts1Y4WCtOVN?=
 =?us-ascii?Q?i8ypmcaUoYIDxjiQczzwdSuAKcxZWuYoPXGHh9++0J9bxBt8WEY50sK0lPBP?=
 =?us-ascii?Q?ExGFNxlaTFuAaY0Jkj1pJphvH9QIRavwuesnp0xGWilXwi1GjhZO6r2Bqauq?=
 =?us-ascii?Q?Y1P+XUAqsEoLOry9Oye/Kz1qQdbzJdj+jsRISMZn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9aa38e-0a8e-452b-daea-08dcf4363e25
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:14:58.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qboOMc2tzusG2cRBfziodgrkKOSl1mVg8YiWqHOZIuuwhQcjMUhI7fnnEAVvNd7+/K6s1DgiYw6KCJ+YScPv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com

Dan Williams wrote:
> When the CXL subsystem is built-in the module init order is determined
> by Makefile order. That order violates expectations. The expectation is
> that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> the race cxl_mem will find the enabled CXL root ports it needs and if
> cxl_acpi loses the race it will retrigger cxl_mem to attach via
> cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> enabled immediately upon cxl_acpi_probe() return. That in turn can only
> happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
> before the cxl_acpi object in the Makefile.
> 
> Fix up the order to prevent initialization failures, and make sure that
> cxl_port is built-in if cxl_acpi is also built-in.
> 
> As for what contributed to this not being found earlier, the CXL
> regression environment, cxl_test, builds all CXL functionality as a
> module to allow to symbol mocking and other dynamic reload tests.  As a
> result there is no regression coverage for the built-in case.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> Tested-by: Gregory Price <gourry@gourry.net>
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Cc: <stable@vger.kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

