Return-Path: <stable+bounces-73598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19696D960
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA751F22630
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D819B5BE;
	Thu,  5 Sep 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/X/EKLs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75619B589
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540631; cv=fail; b=B6ReuEOzYcWaI1/GIkdLzh/54Zu+0tPJvBkTK9KI+DPvTfqUm8vWWosTMFbww2NBEhco9cYboWWPtqpk1BsV2jbMQ/BGoj7f+mTQgk+X61Eyq0Cfw/ZoVJ4V/0C5aZQSOUb/Fs349mpZ56zoqbHZ/bqiklsZUAbJqRuJka1QTkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540631; c=relaxed/simple;
	bh=Qa5cMJKkOkSMXRSUoXTUMgIjgTOvbcuXFS6qFrzvcw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QFZhlDcI/88Ph7IY1cRxwmLrRYEasvvpEjI2O/D3UHiqQh75ZMP5LR0yAvWUEnbwhoH9eBOVKLQ/wjxpRXs/KAyDcnkAF12yPhStrtmdCK2Ci8sCmvn2fM7vjNm0FeaU2ohn/6Jgf0E0QzZg4Z6KaZUdLY4xZAB8do+Qeiiqgco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/X/EKLs; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540630; x=1757076630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qa5cMJKkOkSMXRSUoXTUMgIjgTOvbcuXFS6qFrzvcw0=;
  b=a/X/EKLsJGP9LADQfTAqst8+QoOrhzUuIXOvO2evobdU+u0Mj3BcGbiP
   fXQU1Le0ZNRHl5ipm3Nm3jxnMqmVLkPncY9gYxS7EA0iGyFfV0hnPdyWm
   bhNS+M9HScBuBwGaVIjEbq6IQJSF93suR/nSEfgk3v3bqQFNiMnBrimGd
   h2bY/Wd2y7niLz4Ds1oZDFiw6EueO+wZ+lIgbOQdq8M+p5CnHLFVGBJdn
   qwGlmsZD7ubqQbHLdBYY1no7Ie+SW/eGBmKUIMz/ogpUmBYupPhr8riLG
   nZm/Ap+gq2NTV1bwPkxmuKXd2UrYIsJyH+YEXwYSbkALJ53AWuiD0dg9f
   w==;
X-CSE-ConnectionGUID: 53yTbNYiRjKIBiOAUzkndg==
X-CSE-MsgGUID: lbz5NO2MS9ikRps3S6DKhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28043679"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28043679"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:50:29 -0700
X-CSE-ConnectionGUID: t4cZ8YBYRJa+l4pwnhn8iQ==
X-CSE-MsgGUID: ecjGFZOYSCqmUok8YlkeBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70412872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 05:50:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 05:50:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 05:50:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 05:50:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 05:50:27 -0700
Received: from SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:50:22 +0000
Received: from SJ0PR11MB6789.namprd11.prod.outlook.com
 ([fe80::c0dd:2dd9:aec0:94f7]) by SJ0PR11MB6789.namprd11.prod.outlook.com
 ([fe80::c0dd:2dd9:aec0:94f7%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:50:22 +0000
From: "Kulkarni, Vandita" <vandita.kulkarni@intel.com>
To: "Nikula, Jani" <jani.nikula@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
CC: "Nikula, Jani" <jani.nikula@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/bios: fix printk format width
Thread-Topic: [PATCH] drm/i915/bios: fix printk format width
Thread-Index: AQHa/4ZapWcrE5os0U2EU9FWr8SuNLJJJNwg
Date: Thu, 5 Sep 2024 12:50:22 +0000
Message-ID: <SJ0PR11MB6789D9701C99A53699E65D438D9D2@SJ0PR11MB6789.namprd11.prod.outlook.com>
References: <20240905112519.4186408-1-jani.nikula@intel.com>
In-Reply-To: <20240905112519.4186408-1-jani.nikula@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6789:EE_|PH0PR11MB7544:EE_
x-ms-office365-filtering-correlation-id: 4f22507f-eb56-492f-7761-08dccda94e4d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8dfuKuiZCqwRHVjvvQus55LQHMfecW60NHY5274VBDhFYd0MDaNt15LIu4A2?=
 =?us-ascii?Q?54Q763+G/B4QC0UjgCNsNQXSXAsZ9c+IwfRQ+qb8RpsubY3e+6a8XC14BXpB?=
 =?us-ascii?Q?bSBF8iNM4XuAWMYIiyn/lkL2aLjCNeN/ycgURqX55PI2gZ7aHvixw85jBUpk?=
 =?us-ascii?Q?knZL+CBcnnrh4G7zJ24Lyp2RiTwEixGa9Gwi5zE2pGI+K++2oWP24Tf+a1YA?=
 =?us-ascii?Q?yUsTZJHMmytSG/KyBnvfP6h92Ivsy/VPYqc9VyIZy5rkf70DBhLxyJgZ4a18?=
 =?us-ascii?Q?/TB4CO3v6iWx66gryePXF7qkLsaAwRUO29XgY3iUfLnTKFawG088yBfRdg23?=
 =?us-ascii?Q?wTRUsb1100WbCF+45WoFJfhyrQqnmhbKiC4Ur+0aTgfUju3O2P2c4hGM0BPM?=
 =?us-ascii?Q?mPms9FjLqZDeQpiNqko4yn1FfAN6RZz3mx81tUDJfgFvhcGi5HtYQcs7cxkf?=
 =?us-ascii?Q?tkTG78KkjBn6eCwXtcHQUXwnhHh9VfY0qsZXm211agYX5igTEBCiqN08P2km?=
 =?us-ascii?Q?xf5/YUm7JLde7lKZjBrf5cyBLHl/6WUopo/RsD0JAzPJV0GvETDp5R72SIRo?=
 =?us-ascii?Q?mZBCK4w3AXqs9v0EU6RDF2qV752ICeRvJ0l4K18eTDCJP5bc+CbL93wA7gGI?=
 =?us-ascii?Q?PiJBkV8zmefHjklSmmNGhiFeGmP6+Yi0tu0GVY9atuK0lhGjWyImOUfO/Ei4?=
 =?us-ascii?Q?bWUUyHVoDiliwzdlchQhURqIET44iSQ3aGoDRex0BGwITUmmJJP3kSba08RP?=
 =?us-ascii?Q?F/4v1bSSuQ90UqOw5RrkjuMgenkF8I0cj8iHhx2fIK1+GzCvJ9yKeQ2jSukF?=
 =?us-ascii?Q?8p76wPn5QNpIEtaMMqNTFE6SknTTLLYI2JOoYhThiqoHLMC3jK7Uy89wXs5B?=
 =?us-ascii?Q?tOZaJElOHkfGfsoaJkg9M00wxspYQkA2KYzCGhTZ4iHDsr+gjxnXSLrU7+Yw?=
 =?us-ascii?Q?aVPK/BdiYtFXUB3nCJdaX64z2Y07o+DOqislFdtfSMafQiaWxAajCfyDt+yI?=
 =?us-ascii?Q?9fLpCz3LPWzihN8kOc1ScTJks3gGYul1cuKCK347JJI7C+2bGblMMVu3xrlh?=
 =?us-ascii?Q?NCFIUajS3xdaLCB+zspPhwUIyLKaLyHxDP4JIeQuquSfUcCDyUn9B/fUrlND?=
 =?us-ascii?Q?7RKRRbayEebv30eJJ1m+642H+MZZGGU87EfM842yjSYfRcfzXZzKKD/a9iaj?=
 =?us-ascii?Q?7fV/AsA+t0JSk59GN/qOCyxSxbzKrJf+elQgMemvjPc34daHkWlIIPDfkubY?=
 =?us-ascii?Q?V0htzh+YpEmgOOr/snfegTTfWQ4HIg79gyYgR3j+GVopqp3y95Mu7ZL0Yepj?=
 =?us-ascii?Q?ZriL0Oi7uUekAXDKSpCktEFtwaBwft/BZvKg7LfrKXJbU4H8cGaBbhhL/mGb?=
 =?us-ascii?Q?k7PUdYoZBgufQXhlOgg1YL2mED79CZ38mgG43+l1+BkbucdvwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NbGeKlnk2MnPB1UsmJW6kiLWbJM8/sIDsJ3M2tMhW9cD7yuLc3C0W3nDbhbF?=
 =?us-ascii?Q?zuaxV5mo2mOkr7nu3prmpty4zsQyvJFpM/ihq8SMbPYXN0It1wi8/7RHD18o?=
 =?us-ascii?Q?2on6f6icc0KC3LmCqrNDZe5Otaqa43l73MY3a00wz3bWeWTRK/rwQYqZBgk0?=
 =?us-ascii?Q?jY8irOwTRwKMQdMRWydF8W+ka6l7ak8Sjvv02jQhb7LTQ5EKkC1ogFYaaXYa?=
 =?us-ascii?Q?tJo03SZjrydBI7Q/Ye2Z4HEelpDtLdZGzoEK55VuogRWorsLRx31coQEK8hV?=
 =?us-ascii?Q?R+M2RQ4AA6yuE1K/UFqp1E02okWxihd9nporQDBfwS/vH/No4+lI/VT6enqN?=
 =?us-ascii?Q?w8DduPgJcH/Jz4F6vaZ9Pp6AdpxRrMgyP3dygTOeTWw81paWKU3NEvXj509w?=
 =?us-ascii?Q?CtTz0zTQm4p++Ce1TMRwt7Ci3h2B9vocapFRmBuIJtz9vq4NNejqUTv3olSO?=
 =?us-ascii?Q?jVvzs/FePDVYmcHUgqMwnjxEhjmOZadA1EXRNlKsBdbCqc+dRsRSj5cVHKCk?=
 =?us-ascii?Q?FsYksfx9/KrAUK81F4gMaOvof6BW0E51bMz1KLO1565+nljnc+09OjcxxhGT?=
 =?us-ascii?Q?kY7tbrPvvlsszw3/DVFffe1oKsq3ykEqlT1uleqbM5yy53z276xN8MUDMtzX?=
 =?us-ascii?Q?LD7vmKVu5cknoGord7TQQHwU8+eUb+qqialNMJzeJPUssKLC/J2E10rTVg0w?=
 =?us-ascii?Q?GtNfsT2Pq+i20HGfz7lHT9D26nBCDEuMVDMseQhfTqnxfvy0gIPKxt7rVEwQ?=
 =?us-ascii?Q?YxJCsGSJUcuRqeEuf5Y4NZH11rqKY3RVN065TmXY5OqjHc2scw3897L0XMdR?=
 =?us-ascii?Q?5BB4c/eWzF1ZxfSWSA7t7OMBIHpBKXhv/o/CK3dVqZ62zDMGeOtvedief4EW?=
 =?us-ascii?Q?8vDdz/ZKfbFK6hA0vc5nZR+tEJ3Os1BG5QRMcJCN/rnXZT7sAMK/C9N4RcSx?=
 =?us-ascii?Q?qqaqKQq6hjeN5V+LDdQuJ5SlCdl0m3hG1wreglLBSCmdOYlFaBDXguZnvZHN?=
 =?us-ascii?Q?N5nCRymjzhdIAhZgbLH6oIOj3axUUoyGt3oNg53MsXyMM/SFgDy8PYwc/Nc1?=
 =?us-ascii?Q?iu526suxX6LTobZJ2Co+Pa8UBaLDEj+d/qXJGF8EUJI53dM7v1SGA2RtGMXd?=
 =?us-ascii?Q?vmMpropvQs95XcwU8o+i6igxFG2NUIhFjVJU1IDhT5BeAUnKLnuszyW+q2QB?=
 =?us-ascii?Q?8L7oZdQvotLaam9uaOEtH0kFUY9rFj7H/otU2RH51ghVcROwaVbcQAt4yFiK?=
 =?us-ascii?Q?DNXBiGy6CY0aRdalP/2zk4nJHL9ABt3GO9ILDQ3h4ejVnKp4LuccwBV7Udf8?=
 =?us-ascii?Q?l08FnILTCt1rYI1asI2TE88rjgrzxmAS9A2p0q52OertuzU7EQ7vLgI1NJn5?=
 =?us-ascii?Q?BdPkKvGFYVpfsme/sFlbopBKT1a6hMCXpz7pxaidA1gdWPF4r1nN/j3ei/hC?=
 =?us-ascii?Q?dAlZIT7MzVustsUwbIFLlpFVj9vGxzm9SgZV6sutgY4lxCuvt6TCsnksak2J?=
 =?us-ascii?Q?Ky/O+QZPealJGSd8uuX/KrFNr4nu67M3RjCvTCHjZt3aY5Vh98Yc0ekdHZgD?=
 =?us-ascii?Q?QnLuYrp3NJG5uUwOs+kwPtlGj4oXNcfZWcMYVAcruz/R2NlkQNDzOAQpiy9X?=
 =?us-ascii?Q?IQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPObu78pDT6zSWaaKzzF8BqEX6h7E5A77q9S9SZagns+amqUyK/6dNseVIKNAzu6C93GcdsR0fgj+womnPUiTVcByh0cv4+24eb7sBSp0GTuGDMVZka8Fv/CyE7ILlfQ4TWLmu5SsXXUXSzhQ9CloL1Il7a3Mu/ZGW32FTYc8+LcCsOEYqRFJ+kkvo/V5QA1mkzN45xDpQ2C3k+a0e3uv+fn9C4iMsoiC8CNMkJd+6VN51ewSyUFFNKgl225wm9qTjzgiU/grkONnemGqBEDDc1fbMyXc0TSKPRiYBanlWrsBfb6qjLTbQ4UIlNHn4siAwGpKlg9JlipTZ7FU4x8ZQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rtItXBhNZSPvStpx4Rlr8/zeYi6S/xY7D+YOzJuk1E=;
 b=l38NjwuxvpnEmncVOLv31rImVE+6RoSxbBCzSEba+0fbCOy8+zr0YdKlttf4Q9xzxyjV+bZJYkCTjvtUyan0ga3Et7CEztn+/4/aXy6YaVB4kDZGQiV2lmkhePJbwCXYDJ2c5x+Lz2Z3FXKySlY1IWRZEISuCqBzvkHfdhOA2hKi6Lk4sUUajYhSvuKndl++MtEVWKEEHQA8cqZgJjpercEOh1N4V8FOfbVrXcwJFhLZnJPSLFDRAHuLFbb8tHilThVhFJW28jIU8cZSFCbxnzJDgi63/ZUYEcR1xpNyBPOrRDPOv+n1uc/8KuwILGF4csYScmZ2Zf5ZFjKBjakbBA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR11MB6789.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4f22507f-eb56-492f-7761-08dccda94e4d
x-ms-exchange-crosstenant-originalarrivaltime: 05 Sep 2024 12:50:22.6524 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: suBvOA79cI2RNAeMjYMKi4D+hloLeGFdU8oHgUwSsYdFggdbRWWxKvIVO4PMJr42trJ3B70WdyT/Ve6R6X4qRoCWcQwdL95HeddiMw2/1tk=
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR11MB7544
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Ja=
ni
> Nikula
> Sent: Thursday, September 5, 2024 4:55 PM
> To: intel-gfx@lists.freedesktop.org
> Cc: Nikula, Jani <jani.nikula@intel.com>; stable@vger.kernel.org
> Subject: [PATCH] drm/i915/bios: fix printk format width
>
> s/0x04%x/0x%04x/ to use 0 prefixed width 4 instead of printing 04 verbati=
m.
>
> Fixes: 51f5748179d4 ("drm/i915/bios: create fake child devices on missing
> VBT")
> Cc: <stable@vger.kernel.org> # v5.13+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---

LGTM.
Reviewed-by: Vandita Kulkarni <vandita.kulkarni@intel.com>

Thanks.
>  drivers/gpu/drm/i915/display/intel_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c
> b/drivers/gpu/drm/i915/display/intel_bios.c
> index cd32c9cd38a9..daa4b9535123 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -2949,7 +2949,7 @@ init_vbt_missing_defaults(struct intel_display
> *display)
>               list_add_tail(&devdata->node, &display-
> >vbt.display_devices);
>
>               drm_dbg_kms(display->drm,
> -                         "Generating default VBT child device with type
> 0x04%x on port %c\n",
> +                         "Generating default VBT child device with type
> 0x%04x on port
> +%c\n",
>                           child->device_type, port_name(port));
>       }
>
> --
> 2.39.2


