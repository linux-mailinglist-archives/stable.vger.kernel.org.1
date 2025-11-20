Return-Path: <stable+bounces-195278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8CEC751B0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D536356D8A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4293612F9;
	Thu, 20 Nov 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6iuvrez"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5643612D1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652912; cv=fail; b=TSHTDE/rZcan1VuU+/7Mp8tQpCtGtZLc/Q3MKtcyLV9ciQqhbv95t+BPAtCVdcfk0RbpvKrJMRH4fMQptzIP3Qd/tu3IpKSn5XvnxOpaDVvAwhBcAy48X6CCPjOpO8CUxEY/emNldfI93O22PqFTbvtOoAKQ68z+6Yy0BLBqro4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652912; c=relaxed/simple;
	bh=e5bhMgAk0gVZM+w0eB1o7GAwYJykx3sSwsi0UaAYVYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QFttkNhZzoxuGBH+w83rAjbvRl0hzezDHJO/xRnklRKQyU1qKJcqKgItqUjlQjGEiBMS1PRo3yzI9CuMKFSs8+hRUHzN12j3BEj4ILpyLVYWItwt2E+VYKXB3n1240ilDBcnN5NIiZ2OqzDqqT0d2ezOto8To9XjWKEScrtS6Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6iuvrez; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763652910; x=1795188910;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=e5bhMgAk0gVZM+w0eB1o7GAwYJykx3sSwsi0UaAYVYM=;
  b=I6iuvrezpp4VZLUW7RqaM/e3Czbnl2djJUf2P6diNkPEBkMnvmhq+Pit
   6tCrLH0KDJLY9DSZliEDyfOAAa5RubzsAaK+yVIzQX56dwCAWhsTByak2
   SSkdBqwU4NT3ph5KFBWjXBlomV9q+wMwisu2dDXpgV/j/SImJaAU9wmlf
   2nF9g5ctqsNubiyzTXH826H8+PRqGhjw+0q/Wku+QPjiP4v1MRByOcbHi
   EC3phiFxrSMVJxT10hNgAPL9LLJSTUUYSK6IXCSd5egLgBfR8VjudPNJT
   EorS2GWLNafNfllD4hUUxtfzHDvQDgjNPq4bdTTgkt4TlNtJ6sJ1Douxq
   Q==;
X-CSE-ConnectionGUID: OcPvJ0jpS8iHqQ5ZusHyDQ==
X-CSE-MsgGUID: 8Ici+bNJRoy2t6gPvDoZ3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65814482"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65814482"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:34:53 -0800
X-CSE-ConnectionGUID: J3OR/+w1T/KK5UgJEcSn9g==
X-CSE-MsgGUID: uB9sQpQZQ5KLhxQFApKEdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="196538287"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:34:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 07:34:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 07:34:52 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 07:34:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zsutpyp+aCPTksgHeCV2s0edzYjeNucX1wETZQL06N6+8T4j6TVJBOwTbnVusIrQa7DuNuuXOCUpgTJ9pIaFEypJtlo5xoO8k1P9NG3LfgIMZKGeq+WdWFhTRWqm6OCzZjkUuDiBBA03Mln5PKTsHuT/GhE+jG8USy90X0mxqyfe65k9yvJHNgcyBEgY8Ue4RQHheVLyRCyzduILRBIcrI/VdEWTc7oC8zbJCDGpOOTrj379JTqDsg49xrxqpRjq8HOcF8xUY4UUL21mYZ670crHmrgbFKOimCdRpu/GfkljrKlTobT4TGN1PKRaGE/sSlnlR+Q/MvIRBrXlWMrgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BykpTULUn5ziPiG9aIn1fCjTGxg2bUqGCfLfXk1RCnw=;
 b=ehqGD35iAmaAFJUr1AFDNkAUhGoWFxDmMJV80QV4cDtaT21yl0gRTfZ2Sam81Xws8srG8Wm+mqYmY+QIPyJaxcHP8t1U0wdhdNW1IQWd/sMUxZFxW25Kgw2o2+ACecYBI4s7Ka0hszAQydu9HITOnui4ffI2putWzBGSkQ6okNbnCvU2j+pDMEB0+OBNz2cIStGORkMlAw9mqozwQP/CCLfWtDonERlV1YxW4ZjJDmuGt4Yv9ByUS21MFndDc+QUi2F8rt7995PwLUqaScu0pBqOtFCBa0JBKtXDOzNF70B65R++2V6/rLWV7bNyXtFp4bfyXLRO/NQQkwMsPrjO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 20 Nov
 2025 15:34:46 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 15:34:44 +0000
Date: Thu, 20 Nov 2025 09:34:41 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
	<thomas.hellstrom@linux.intel.com>, =?utf-8?B?Sm9zw6k=?= Roberto de Souza
	<jose.souza@intel.com>, Matthew Brost <matthew.brost@intel.com>, "Michal
 Mrozek" <michal.mrozek@intel.com>, Carl Zhang <carl.zhang@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm/xe/uapi: disallow bind queue sharing
Message-ID: <fh6dgogrt3ibrod7qkguejy4bj3cmvlbnxksmedhvfx3ejglk2@nu3h6doh7sdx>
References: <20251120132727.575986-4-matthew.auld@intel.com>
 <20251120132727.575986-5-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120132727.575986-5-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8f1376-ae6b-4bb2-828d-08de284a5487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3RWRCm46McO24xcOfHihb4oF8LeL6bzeaNFYxVZcjJ56iQZ6DBYKCdhnbe?=
 =?iso-8859-1?Q?8JBpZ4nm2SMp/HzuMbj0JLqReVVUPS5c/Ibu4CW3V80tPNvHAt7PS0WaOO?=
 =?iso-8859-1?Q?Fc7kU5mntYZBYNS2alvMbqdjDa8FoNgNyMNBqbNCI2cwAPhvHNoCLJeWn/?=
 =?iso-8859-1?Q?aiRfvZMxiKWe8hFHilfflhPDUNrlvDPUQpeycMYtyJxSKgegYgLoCxeLgB?=
 =?iso-8859-1?Q?htLwNi07jjTyhZFEz5q953tgbvja7MG4/hNISSsCE+TIG7iCRvVJYv/dsZ?=
 =?iso-8859-1?Q?BK2j/YK4Z7/6G3YHRXgNsjAPFZc1qIFgxqF/KUZP16VnW0jAyNOdzzq1KD?=
 =?iso-8859-1?Q?5/3XaubxEgmmzKA8G7SbxcSR2zLuvARhPdokSUMsFS8hy9Kjyrz0bbsKM9?=
 =?iso-8859-1?Q?qlyA8dtrs8BsF9kZ2tEIfNwR+NWPm5HNelwDfM9GrKTjvHtkNxXa9xWubk?=
 =?iso-8859-1?Q?ewYYRLn3KagD+W8Nub8Lb87JYHjNpaT3y/gZ5HUU/ufNqEho5YldeY3j7j?=
 =?iso-8859-1?Q?56AMqEjlqBLbXamjwd/DP2zU85Wg7BJ34J4BZmjONqa3dFdkD5i3b8KWiA?=
 =?iso-8859-1?Q?3SS+so8o66MAWmXTYJpppu0FH1wKAfzQBNGn4qwzJlJRatxSPX016EaI2U?=
 =?iso-8859-1?Q?WpSe/S/Nc+Ffd1mwv6BRSO+RVjgz2hcjjKAUZAf+yGsW5OOF/dI+vveY5b?=
 =?iso-8859-1?Q?uL6/ogGLLeUaVarvo5HTBrDAnQWrexMOMVqec52QVBbdHc6gCwRjq0O+R3?=
 =?iso-8859-1?Q?1tbzKsZVd5kGJCIUWnyKXlnkUFg+tqkrqE4OewH5/kuNoJCUJL3RUlMOvD?=
 =?iso-8859-1?Q?s0QsQlXMkuBmqSdjHuWoSsrhCsXiaGUZZVeq72m//jrd9GuVXZQX7GMPj2?=
 =?iso-8859-1?Q?Ol9UmSZnDiPupv3LBLkcpSAkwgSNzhdACcPSrVJzMmF/IF0ybB0uNkNZYB?=
 =?iso-8859-1?Q?WIgCRGGvFucdUCcO6MIua4ZkEObvVyRaw1pGt/MdIEa4LhXoUwqbL5IJcv?=
 =?iso-8859-1?Q?V0WWVOXvb7DHo2nfyEvB6dY5ofcKOCZnbK/qAFSoSz7YC+ql99yIjul8JQ?=
 =?iso-8859-1?Q?WJEwU2srqqdqJQqj3WI37/HRIexfZpNI36btmsi7BHr1midUm1MJcX9Cbq?=
 =?iso-8859-1?Q?tiN0lZY356UVCG0XT/alN5ebDlaELXj79YX/l4N/h98F6WeIhLHyr7HFkq?=
 =?iso-8859-1?Q?Nbb1PXJCfWYMHQcb4HkyIsZg5K82H49wqjDyRpA97NxVgOHh72JynefqjG?=
 =?iso-8859-1?Q?3766CYqaRrM3MJQdMJ3qI7M6Qz+flEtk/YZ2d1DEwN3FrbGVSbbW29D6fQ?=
 =?iso-8859-1?Q?KG9DHz/UjLZutmC8QpHWOXxZeDOXyT/UgwD6ZJyQwtLGzvz/ATLZMIky2e?=
 =?iso-8859-1?Q?QQ/KKLBqDoFrL0LiHw/Q1ayEe9Q1cizvVvY7y6qmcdldOw6xfpnWOVJ+w5?=
 =?iso-8859-1?Q?2njoWJpYVLdiHhtoPMq9qG5/SyN7zwK/WQYN0qT4ZLDvHIEeddh9at7+gk?=
 =?iso-8859-1?Q?za84b+nepqD317NpGWKG9J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n8At4pp8g/eYRhNrqeUYLvtCHEIcT6846Ud7fyCSiJnlXpmG72/Y6n/GgZ?=
 =?iso-8859-1?Q?IUrPCyLbaU++hCi3+0T/5QVoO1DI2uzdlKGNc596fpoVhFnn9h4+aUVrHK?=
 =?iso-8859-1?Q?s9Aj56WnRg8+M6U1gywrLVbsT4hIF08NtilA/uVdkdqykKz7s1DjzxvxVM?=
 =?iso-8859-1?Q?U+6X1RAvaa94NcmlMJRXKonOxZ5B+b4fLxEdAoXhpUqZ+uq+4lhE8dRHXy?=
 =?iso-8859-1?Q?u61Bp5MSfGZyYWQ9xqsZKKEjvlzozqaNvYsRzP2e0Z0d/RfUCPcFmyu3Ef?=
 =?iso-8859-1?Q?1BZfpDysVwCZI1MWVpMY1CCPYMuf8Tp6AqN1gs4PN4GzGhgqeYvT6lTz4D?=
 =?iso-8859-1?Q?weX3UrshnWojEqkRv55V40LOjO1kgT4S1JzfpEE0Lg3zAzYd8Mt3jstPil?=
 =?iso-8859-1?Q?h8uU+wTtz2hm6ZYU8pdqBoNxGkGI6zIgJuv5WNJ8CQgyObYKBWYzO5Br+A?=
 =?iso-8859-1?Q?Rwn4pgCcrBVXT2/7FNNnvx9yeN2WX6EOS5FUJcD7hhbEz8sgBZmoH66F+6?=
 =?iso-8859-1?Q?d4c67eTSYYb18Yfcm6V+KpFQwEYu6rHc8rd4yF1lWZMCBsKPtRbfi9nVKh?=
 =?iso-8859-1?Q?yQExQwAs205++3VtGYRMWajIJrLlUYfCR3OohMBEqoHYgcAMdf89pMfYfa?=
 =?iso-8859-1?Q?gRS0da4e49aGPE+5ghGEZUJZKrun4931c59Agz8vkDfWr1frAOqFmphNab?=
 =?iso-8859-1?Q?dIS4mdmf3tiKd62WwYMKAz0bZI+T+YgFu6lcpkEMt0B3R5SvCifWckoqXT?=
 =?iso-8859-1?Q?GDBB9IFZ8m2jF76UTJB2NNeakoc/DMq6BWtB3+7s7DA/jhDQC2UcI3qm5O?=
 =?iso-8859-1?Q?E793+Qdh1/8a0buFk7LbwCYNFCpqsjDfbamzC1EQE3+KZ9uAUxx/XrgmzX?=
 =?iso-8859-1?Q?/NAuN2yGJ25qAIulet+bHrfrhECh+7oZBUSjD+19fneA8j9pSU5VY+Z3ZQ?=
 =?iso-8859-1?Q?vyv3r+Ub1+xcWVqUBJRQSkGE63C3UqNeugEPZcJhAp464lHR52RcTqIvCu?=
 =?iso-8859-1?Q?zROkfjbC1B+ExyjpdDO5IGzPBVmVto1uP9/tUWS5LxP1ShUUniw1ekoQSE?=
 =?iso-8859-1?Q?Vhiq/Yietbsc3Fs/Fa162cgGnYi7JSkmf0vpSlZSxSLe5L/ek1qlYMrFEh?=
 =?iso-8859-1?Q?oVl0UXWUCbnMdoB3rM69fQoX8u3SaTo+r1DtwR/pAHTNB8HrTkYTwXrmN6?=
 =?iso-8859-1?Q?68mpLvmPeikbb5Wg750ZquRAqCHOvcSFVIk+jrS+Syd8big4Mc1/JgJ74/?=
 =?iso-8859-1?Q?4OxKxkkOa5idjbyG0P4IwgcQ20e3HybukaSDSgHFbXgCUxhRRAo08+czLf?=
 =?iso-8859-1?Q?oGmfnlImtzvqOTeybJ8B1PJS3mOGoOUWKCWOzdaLycQBKJBFMEpY7Zssgr?=
 =?iso-8859-1?Q?NSjtgowc0tvpdE8/174S0krv4Qe7Xe4nJMqWJ+2XJajBtW0QgwZPDDVlK+?=
 =?iso-8859-1?Q?PIARzTmjyiUxq1pBL4ifw5jrfaIPqwPwc7qq2SzU/0tDJW+ZXR5J/Ck4+d?=
 =?iso-8859-1?Q?p5d9EZK4sgYJQbdz1asUPcQu6aVcs9owpsIyB+bpoi6zvhQHF0ndY4qz2z?=
 =?iso-8859-1?Q?0CpAKlA3AA4vgLYnRUtCOyKbgsgEzo9i6qYaxB0Pr80KifR86d2zIyxOIH?=
 =?iso-8859-1?Q?/gnP6ryxXG7TLtLiQ2eHOeIUaVeJeiS/Rqh3mj4dwKQFSN1tfETwAz0Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8f1376-ae6b-4bb2-828d-08de284a5487
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:34:44.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N97XxkAj+Ei3FU/4/4oiHEH/JttIlRnGJjhGnZApUi5OLHloo13sv4nM9z2KT++topndShcReAYk2FhaCVuZ4Lvglpc87oRXcHnAvGvm1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com

On Thu, Nov 20, 2025 at 01:27:29PM +0000, Matthew Auld wrote:
>Currently this is very broken if someone attempts to create a bind
>queue and share it across multiple VMs. For example currently we assume
>it is safe to acquire the user VM lock to protect some of the bind queue
>state, but if allow sharing the bind queue with multiple VMs then this
>quickly breaks down.
>
>To fix this reject using a bind queue with any VM that is not the same
>VM that was originally passed when creating the bind queue. This a uAPI
>change, however this was more of an oversight on kernel side that we
>didn't reject this, and expectation is that userspace shouldn't be using
>bind queues in this way, so in theory this change should go unnoticed.
>
>Based on a patch from Matt Brost.
>
>v2 (Matt B):
>  - Hold the vm lock over queue create, to ensure it can't be closed as
>    we attach the user_vm to the queue.
>  - Make sure we actually check for NULL user_vm in destruction path.
>v3:
>  - Fix error path handling.
>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>Cc: José Roberto de Souza <jose.souza@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: Michal Mrozek <michal.mrozek@intel.com>
>Cc: Carl Zhang <carl.zhang@intel.com>
>Cc: <stable@vger.kernel.org> # v6.8+

we never had any platform officially supported back in 6.8. Let's make
it 6.12 to avoid useless backporting work.

>Acked-by: José Roberto de Souza <jose.souza@intel.com>

Michal / Carl, can you also ack compute/media are ok with this change?

Lucas De Marchi

