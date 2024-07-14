Return-Path: <stable+bounces-59251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E6A930ADA
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25D3B20C61
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDEB13AA2A;
	Sun, 14 Jul 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuHROwi0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36D1755A;
	Sun, 14 Jul 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720975781; cv=fail; b=S1HO7GnJHfLU144KpykrFFQMInchjiXBmRuvGFbylkpnvQGhOCJToNlhinwtxKR6L3UgV466CqdqWxEg9NlsCZGtkOpxd5RaTAurYWg11cZGlvRZr/aBTGeUG9rgJk1Q7K3mg4sH73xW3IMWOj0xaIiIdtorGx1DXO4MeH9XW3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720975781; c=relaxed/simple;
	bh=0NrCe2ep3GizlXyaOwwrJk0lXyOfUX2nfGo7VgDyH+I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Apkexq0i57nCtcQem8rwJsIxhishlG09gmvKJyHyz0I0KWyzPOh0uTviGeX9Q8LQ7oog9zozyTKllG+e9LFxc0j8cAxNtwNcmuWuAylznuqxchzS4XsikWmmEUOwZTFIKZfc6ToIvFLbjD2PfYlSY5ep4hgwOZQmpI25LbL2CKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuHROwi0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720975780; x=1752511780;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0NrCe2ep3GizlXyaOwwrJk0lXyOfUX2nfGo7VgDyH+I=;
  b=RuHROwi0mEHIGpd7A4IPhNzUP6Tk2VZ2WSM5iCzUQFlNHNP5rbcjCmgI
   vR0l54Vibxk6V7Epi4X8SgUgMY9fyiPxgX1cEcWfh6n4PUBCXMS+7txoF
   GnHiQkj3Qj2CbANl970UMvjhlGolymDt+SjwRT47hqd/LGimf3bSPiwD9
   Y/PO1CiIX0mOi7sbmNT3vnqlDXb3cwAiaaqVCbCwynG7UxyF4AzolLtwE
   pTRb1JiW09r25unCfmD0qtxXOhhi4wFai1SWqgGOEoJM++1xDuywHSWyT
   Cm3vtt2xoY1HetM4J9S27BBrz6hyTLsbKe6MhpFVxOBTswEP948yN7Fjt
   A==;
X-CSE-ConnectionGUID: CjuF1SU8TFSugECQdKYg9g==
X-CSE-MsgGUID: ElP4r12vR4qpucVp2l+YbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="43767294"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="43767294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 09:49:40 -0700
X-CSE-ConnectionGUID: ykmWolzqSOeJ7fZ8poq83g==
X-CSE-MsgGUID: ye0z89bKSLSG3mHFpnpT/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="72614666"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 09:49:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 09:49:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 09:49:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 09:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCfCkZiNxTqTjGpybifFl89RXyyEI2JOYqkMWEemK9kgjXe5JuOaG+esTXNT5Hjw1ux4IBRQsw00ZS0rF21SU9csNG75PicFechqlKUfTJ7HdBNNaU4LVQtVopxgu/xNwWRF/G4hhGiq3+tyKaE688gW9qCc+W/p16kICO/xNeoeIGBTVe7SorSTf18JYidqfx87prhzkv8XSDaH81ngr0V6HNKxCj4fxPE13Gx5KLMbQ3GxSEmJpKvmVHwTsq0kD68dnuPts1CVO8J3EGC1VccBfACEVK5DwZkSFkPJuSHuORoGSF8/tCHh8LEjjPER+d1A9uXHux4iNkPJ9rIyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEQdY7JLgOM5nbNuPKnQYT7aT3MMHPXSSm58TLbix5k=;
 b=kARFKt+kiklaKeTn2s/uSKI80nyzLQjYjwK7vr3xpYwB5GFaUyhS078GiCHyeIUhzm/deu6gvSSVqoGUaoCPFGZK6CkBZXK5rKGXrKjG9QFq6F94zC6NRmXL61wnnlVXelPjDY1Zq5qLXdRBqDkuugMkfb8cIBu981s4WhP00v0m/X6xs2VGHNG4PwWMpDgm95tiRHCHffKNFTpCwKnqwyLwB694XaWH0TqCC4O2F3Y6QJeoM3sgf1jH+6SfgKa4cN8xWJ4+n5yWSN033TbdQwa1bQO38/Sgo/N6fMKjE++NJuzVqUSC9DIbSZC225chErhy/bgO8ha345StGbtF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8211.namprd11.prod.outlook.com (2603:10b6:610:15f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sun, 14 Jul
 2024 16:49:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:49:34 +0000
Date: Sun, 14 Jul 2024 09:49:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>, Tetsuo Handa
	<penguin-kernel@i-love.sakura.ne.jp>, <stable@vger.kernel.org>, "Ashish
 Sangwan" <a.sangwan@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>,
	"Dirk Behme" <dirk.behme@de.bosch.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
Message-ID: <66940199e8592_8f74d294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
 <2024071438-perceive-earache-db11@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024071438-perceive-earache-db11@gregkh>
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: bc29cca7-c28e-4c14-0a07-08dca424f062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5D8HxpbkJWGeoaaJnIiXX6ePOzXs5/osObPGtHOISYMMX7RBc9wimbwikQYZ?=
 =?us-ascii?Q?1mjib59yrhV5VE8ht6KrkiHLzrmma27Ne+FgnVdbiJZL4wzPTBvCZb5foN01?=
 =?us-ascii?Q?oElCpZOpE4QlcOSGiJz7DXYYGwMyBNloaMp7GpbR8S1UvqZQVr/XOEuCHk6c?=
 =?us-ascii?Q?NXu7cKbhYW2JI/s01yd7fe4DDX36luWheagT2Ton5qA+w8EIAkIHFI1TIyUL?=
 =?us-ascii?Q?qhX/V3eF8BLxYebZK8nkUF+V8BcEYeVBaeL7m5+ZcxBVVNTkajeHOszu3CxE?=
 =?us-ascii?Q?DL4pMCkm+iw6sGyQnF+DbdVuL1wwNUVSF9PrKfMQ0R5W/3X0kYYVDjdw0DBi?=
 =?us-ascii?Q?be7HLXDzRvHRBlSg8v8x5F06XB03QgR7Cp9y6uesYJSmCLntHU6SepQ5Y1gD?=
 =?us-ascii?Q?SdjgVpOLQ6vXlVU+/Kr7WU8yjH3r2h5OVfCtl1KHiPfqFWM9A7AaOHApQpfE?=
 =?us-ascii?Q?gyq6DGNDTxIUC4/QLjsq8DCQUEOkvzaQVzy/E8LDAwTytfZc5iyUFrE4GlXS?=
 =?us-ascii?Q?u12j079+G1mF0uXQQ/jR4iSqQQHqQIJF+rSygzfBgExzv2JSxhX5N8MhRDVx?=
 =?us-ascii?Q?+rsdiPkLCik0+HdtfVG3lWodm2PfCQ8VHggl/utDUVbsvvRde2jcYKLsG8Ns?=
 =?us-ascii?Q?lX74WiRhl0BvBRfZFVZm5er6LFxr7E7+i2U3SaRUmh1LXp5gMVviBBuQFgcm?=
 =?us-ascii?Q?skikn9/3o8T0SeuffGo0IHBpKtdojNc0RcNguIucjszEZngu/zBp/ptryUrR?=
 =?us-ascii?Q?EvNgA7PAGeBXn15LkhPxR6iP5uXMhyVHEDRANpFa6mnCgXJL7VdMOoj63TLL?=
 =?us-ascii?Q?jAyCZHZswn4+FiosAu41ZPFmMjk6GnXtH+kDLuNBAmWnQe2gRkT1FVdrGMf8?=
 =?us-ascii?Q?KHJoxZKk0pyxMfVjYZiaSsLqNxspyejbkOBXVR4ML6XgJCx/+PKdIxmIfjZK?=
 =?us-ascii?Q?YPRx3/Cb+8TKk7TPyRhgy6XM038bwpk/y6Kc13jqDLpWXv6yqjLjgM2DaU+q?=
 =?us-ascii?Q?7sxARKFkie9GowFT6oJuVk4slnPCnk9henxiQViqxHEOQwxdQVaXGHVMEctL?=
 =?us-ascii?Q?2CJT20wZA9FZEva12tdILYIfcDpa5ER8udKFGmjst/aXKbH1jC6EoTMKfIeT?=
 =?us-ascii?Q?ZU9BkZUt3JtekGZ4NljK+yxs6eTE5Gmnzmg1f38ro4B8o7FOlt7O1u6YbFlq?=
 =?us-ascii?Q?YFABJOpbBKb93BkKj6oiasaWF7OwJ6ZntAYK8wp3fe6rKssfFLnKt5RRaHh+?=
 =?us-ascii?Q?r4bVWAaXKfQ/hpVA8oSWWuTlwlUeYCX/aF196/2vgxksSOzqFvBdwRfYc9YP?=
 =?us-ascii?Q?y71wOrL0PmiIubWIVtjUH70QOvzqDMVbnLwFP1I05v1JNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvGfcxnqLFclbhMTtQEC2/a2MRNVfb2o2pw7c74735zIieRqgUZkX7h0Sxf+?=
 =?us-ascii?Q?kh1Nr2noGfqgNjGsBW+XD1pYj1U+Ucxh+TTkxBXnaysbpejimnLuj91t2Jef?=
 =?us-ascii?Q?Ci/IzmvrK9SNieUE2lCCL+OxI5UgoK2c91HUCTs58CvJ2w6tHKcNc+LqiamP?=
 =?us-ascii?Q?EIY/cenVmrmql/KFVi/8lcNAZOImy5V1O9/LtuN20G6wLTjSTZhtyWS0JSdO?=
 =?us-ascii?Q?qu4EyqHay1SwWM5iWcU4uBEessZd2r/8dXvaKxelCoSxeR25n4kMzu8TW1Hb?=
 =?us-ascii?Q?gnrIE4YjICrBBycc9AkGYxGWXqjUnaLnCSm7nyOBH81qd8mtTfF5yRhpCUfh?=
 =?us-ascii?Q?HH31OYySzXhs4b8IAdeT2JfrzupXSoZ8uXk89kC48lueD4vBmJ6yDCicrZO3?=
 =?us-ascii?Q?Mqar/++yBxaOkWR+IpkTrMfQy/ipYF7aCtY8CU/M/YZDuIJzjftoLzy5PBoO?=
 =?us-ascii?Q?+z4QawKPGhPHsBTBr3IASvbzEKsuAUCx0mK5p6gd4nLMUiWlaRnxQBu/s31o?=
 =?us-ascii?Q?vKqGoV9PWb0o2z78m4ddi4eCBpFfZ537MrSjcACyNxQ08VAi6Iudj03hQS8N?=
 =?us-ascii?Q?stshTRX7IF+YVAUuZ8WZR4TQ5AVX/n6ILM48yu9UcFKqACJde8Xpcjyh7d9S?=
 =?us-ascii?Q?IYT6Fd+9PN1J7HRoeNxrhwqHnEfD22B2izgz2+R7BkVZzoOrVygqslnkXToj?=
 =?us-ascii?Q?0hI+Xe4/t5YtHl1BZ0tiwjA638kX7Lz46pK2qejde2RquhExGiEDnb4VdfiH?=
 =?us-ascii?Q?HhXSaKozCh5wMujGJGlEL7GBBjW5dJJIhlR+WwI4iVnpuOIcPjSIQ8du8+Fb?=
 =?us-ascii?Q?9RxuaT6JDagFCHdzQ3y/0pqRKB9AasHw4A75qa4AAgfQQUUiS5CIX5J24j6k?=
 =?us-ascii?Q?YlfFiRusgs3ghhekfcxKe3oTeL+a3WA/+srsVUR316nFT9Oz+216DfyJC/yC?=
 =?us-ascii?Q?TuPhFZxWu7jlclNtkFS2cLp4M9MOgvCOvlq1HXsM+nJOv5dv2Zh/MBCBzaZy?=
 =?us-ascii?Q?It90QfeOg+3lzEqkJix36LViUkVIT6MISQ+oXVROAh0rgisf/H4YnNed+cQl?=
 =?us-ascii?Q?G32AJanbOJh5ilnK2xaa16+o8ONOESMiX61Nk2TkivDx74oPRdA466bZ2wV+?=
 =?us-ascii?Q?Sf2qpxW9VFXHBocNvUmOTSgxAhRBoDJHF+gUPXfIJD/mYTpfuJut2SNNGGcj?=
 =?us-ascii?Q?dmwD8ocU5p+QTmDjBC23yGnogj+9s/6zzqXs7geKFch1PMahuETMbLj1F/li?=
 =?us-ascii?Q?9P9olEPAex5YygG+zxNCltYlQeVDwb+gNIuLhK5JF0u9d49dDbCOh0YXrJ3h?=
 =?us-ascii?Q?31ZqPV6zyp9UwrIZtGob0D/cb8rvrjld+iv7NG1jRhI1KGj1UdX0tDUY593z?=
 =?us-ascii?Q?MRZo8bwexD6DfibBN9dhl4FyuEH4lCY89vPeVZkKD/0SjwGPAqUvqyp3UQ0x?=
 =?us-ascii?Q?XAZeyQgwvyvti5hEzKk2Cgg7tuPqbLS/bX7FWYf/QvfeBdmzQsiSTo4qug2b?=
 =?us-ascii?Q?L1pPH43fybQN2zM/cHMl/4g46zBPMyr+9iUoE4cCPN1mBVrMbSlyRHLrYrXP?=
 =?us-ascii?Q?zGj6YuRv20zKY5iJ30MNaznO3kgPZQnUHnWMdMVsxQVbbWSOgkelAIcV7ZKp?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc29cca7-c28e-4c14-0a07-08dca424f062
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 16:49:33.9635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB+AZjSYxLVA5881+9ahqspSZB86tE1TmqdQsPAWb9JZeVvGB8/YNN95kamFMFlMW6hqW4wfMU/apksw3C2aJLwd+SbI7ILyMuzEEmhTXf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8211
X-OriginatorOrg: intel.com

Greg KH wrote:
[..]
> It's a lot of work for a "simple" thing of just "tell userspace what
> happened" type of thing.  But it makes sense.
> 
> I'll queue this up after -rc1 is out, there's no rush before then as
> it's only lockdep warnings happening now, right?

Right, only theoretical lockup reports so far, no rush that I can see.

