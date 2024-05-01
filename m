Return-Path: <stable+bounces-42840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32588B83CB
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 02:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F0E284A78
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578A3C2D;
	Wed,  1 May 2024 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWcqVXql"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E01847
	for <stable@vger.kernel.org>; Wed,  1 May 2024 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524061; cv=fail; b=cbk6uH9+lWGT3Wmw9Y9Udr3wiFFu6+m4pAMHGJ3dvDC9VEYhalq56QLMToK3RGXQG1b5rjBRJ+EIHvm7obHTOAT/jnrD5hxjnp1wu8IBpfvocSRH9aNlu/hEWOqIL2lKcHfQY/N6w8N0gd0Us7f/x5TaVhh5qwUeta4rCgrM6yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524061; c=relaxed/simple;
	bh=yf4fvLd0jzKsZNXSzTkD5U0cAR/pXM5WrtQ0e66J6aY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIwSOScdI6X5vmgElvdsGpIGlsFaNM5M3ReNc3lK613XLfm68js3i1E1apFk1msF9MdG7xY7Afgjsl2VvdZz56DBMStLt47vJYFHxnzVq37VYJtCF5jbgcxBHx0ylCiTHRjMqzfXjlLQB5PTb+yvWeEKIJvwnkNDrf6p+aroumQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWcqVXql; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714524060; x=1746060060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yf4fvLd0jzKsZNXSzTkD5U0cAR/pXM5WrtQ0e66J6aY=;
  b=BWcqVXqlDu1kkvCIzQHd12af5c/D/cN02TbwtbP9NqGjuokou9StW9Qw
   xoE8R1McudzC8JjqdjQkPwKSPStoci9xk8HxnV3jaU/aKbWzTWWXk0YLz
   DMlYCegctFnF/I/q6H+M5cKYoqDAHtbo5MdShQONoOEhyCyzgd/plTuT7
   BNtKbeh6c3So7aiftvzvsbzQi61FWkxO59HjJSqqf0ny2C+frZVTfM4WJ
   xJsz4wHtK0DUIKNE7TsVqR/tWFOUoa9laeqnyaModv3iTHe1n94SGm8np
   V0AwHaD9RAw/OtRQ2z26E+YHY3y3dJM/SAUzBJsLOLT4YvaQw3ziPJWs0
   A==;
X-CSE-ConnectionGUID: h4wzELYvQniY89XxY8LpWA==
X-CSE-MsgGUID: czrKo5qHR1yWQ9bdanVFsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21661680"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="21661680"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 17:40:59 -0700
X-CSE-ConnectionGUID: ddDUa0sOThaDNCt/yqi4Wg==
X-CSE-MsgGUID: nDMLBULFTNyuZiVNV9Yrjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26667240"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 17:40:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 17:40:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 17:40:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 17:40:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 17:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwXLsLkBDBfeSMt5MVYRLv1xA6kF0jd6rCwyDAVyJ/xI2XxqmRCDUrkA3q4FO/TqCgevBJMnIKT5sp5iKZ449qm09hpjjzVNofHFZvHMPG+NQJ4X97dgOgv6qOc9TLcasshhQtBYZpYx11m8rGLBfaQVLVw76ZfHq8J5xtdT3jXaFqSXcLjSPH5J2PEqA2HgGnSq1spkwOEJHcmqE3Xv/6kgG2d3EFoQ4z15Zk0PHcdBgTpbLp5qfvo8TJw1gFQN7zUqaaXy48HqTLXVNq2tdYAsEPRiD+lx8IxHCrMdYYPTApu6Uq5I1FcKu5afWeW7ZZWbKX9nDf2nN1oAc3dPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ue8KBMxos+mYHTpxK64BqZd/jLCMEWJ7EwdUomoStU=;
 b=TC7pT3ij+DJ62iXpObAMUdM9+w+eK56iE4qic/z6jWGkMPUkSsqjAj0B+6mQinRmQFpCHTlinJBdMFBnFccArW4v0FH82aYNyv8VFeG5zqdPYCK42Kb8XgMW8OrMQjAM2W2RRHRaNc+6Q7bkUvvuKIdPEeJSGy5pUs1K1mIfSPv1YcR3qSG47zakkemqGldCNLzPwMwKWfnmKLx6+QykbmOYAwnw5Q1ydSGOfzRb8WIufVe6lwPkkZE8vlYKsYqINXh7X3HDnC9k+3V4O0HPgq5MHf1c8xUsqdxcyh3hc3Qj4dkY/VQo474ipU1YqWqIFtR0/0+b1TnPk1Pkz9NGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21)
 by DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 00:40:56 +0000
Received: from SA1PR11MB6991.namprd11.prod.outlook.com
 ([fe80::c06c:bf95:b3f4:198d]) by SA1PR11MB6991.namprd11.prod.outlook.com
 ([fe80::c06c:bf95:b3f4:198d%5]) with mapi id 15.20.7519.021; Wed, 1 May 2024
 00:40:55 +0000
From: "Zeng, Oak" <oak.zeng@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Thread-Topic: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Thread-Index: AQHamDIABv9a32EftUGqBpesvr5L7rF/R9wQgAA6IICAAW3fwIAACbGAgACWaOA=
Date: Wed, 1 May 2024 00:40:54 +0000
Message-ID: <SA1PR11MB69911C3AF844C24370866D0F92192@SA1PR11MB6991.namprd11.prod.outlook.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
 <SA1PR11MB69916393B52812A5D25302D9921B2@SA1PR11MB6991.namprd11.prod.outlook.com>
 <Zi/WSRbYmpZtELhK@DUT025-TGLU.fm.intel.com>
 <SA1PR11MB69916539EB7B6F7DD49E2214921A2@SA1PR11MB6991.namprd11.prod.outlook.com>
 <ZjERVdJYRq+Fl4X3@DUT025-TGLU.fm.intel.com>
In-Reply-To: <ZjERVdJYRq+Fl4X3@DUT025-TGLU.fm.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6991:EE_|DM4PR11MB6310:EE_
x-ms-office365-filtering-correlation-id: f0a8be57-485a-4ab1-9866-08dc69775c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XrlRhivM0pna5xIfIsU01wPqptL+TOnBb7o9fHjX4RUaBOdtybn+PVDyty?=
 =?iso-8859-1?Q?KzdJZFe57+MVDu47oKxkKc4XO7gu/Dj/V80ndG5rXP+0zEOKpRfZmDwXiL?=
 =?iso-8859-1?Q?N2W4RubVcM9iVXL6wxKbqyBc3xErIvGTsSmww4pIoJj299yfW08yjjTw2/?=
 =?iso-8859-1?Q?4pEUT3NebAxXvwe3BRK9y7pqV1EATvOkiY3t7kVqdRtW8e7weDVMU8188v?=
 =?iso-8859-1?Q?As4hxgMEuuz9mIVwHbLrPDTS19VSRcxAtx1C7AANrGnoBQ4WquiccRzTbH?=
 =?iso-8859-1?Q?VDpRibAxUr8tSZM1zdq+7+OdXE0QuDJ6xouLZxW+mJj4/lO5F+a4lScjlt?=
 =?iso-8859-1?Q?JHO1NSTea4awPziz/wKQ9uKQTXT37o7SXSr4e5hxr7pKKz9ELflUKbICRS?=
 =?iso-8859-1?Q?kWbXbUh4TedQc+a0MILABiRpgzhcOt/wMe6pVMcNZXqgRHT+ozCIGsfTs8?=
 =?iso-8859-1?Q?0Ron1lsaT6pXynUWr07qjcQAU/AWX0eOQfH5Lj4fhtQxtez6Q/ZZtlfP8u?=
 =?iso-8859-1?Q?/B0+9DJOhXFkX6QtM4qbu4PU0zhe2lmq+XE3UYsIxLEWVRa+UTSLGe1bWS?=
 =?iso-8859-1?Q?4Tv6OWekD3QkHdvdJn8tfvp2hi1jYCgutQ8yBIqzMEPlZSaccecG6MUJs8?=
 =?iso-8859-1?Q?xE62Yg1OvGrmyVQWkqdInezJuj7ofPwocYffgkea/yAd3kLrYCJsvouTwd?=
 =?iso-8859-1?Q?zw0Ofai58SwJAhlnvpUCIHft1obJE+5pS6civupY7zm43MLQ9r8Pkeiybx?=
 =?iso-8859-1?Q?Q62qyJxOBGTxHwVTzGdtOcsssNnyjJ0jheRiEMyz6PcfJ+yBrMd4ZST0kv?=
 =?iso-8859-1?Q?L6ANqkSEVcHD4P9KtXKt6+eJTeclrVSKlt+hinuwh8hxSye6fBC1Blxsjj?=
 =?iso-8859-1?Q?et6j40mivgm1i9B9Gqx2cH8kxPayzZdHTLam7ToxjRNMqiQZKwWWMZtImO?=
 =?iso-8859-1?Q?bVaYYVDO4wDSvPVqJC3naUjNvlLkZPvKu/0CtYNbwaK7w8wZgCafm8luqH?=
 =?iso-8859-1?Q?Mk+ylM0qse4LqdmpDePFQylYW4qcZW2+0vtEn9sBlWNwoeu0wu23cnmtUI?=
 =?iso-8859-1?Q?epIzs/Fcy+vGnY0e1lK01YU7BXr6gIQHnQhAlDQqhaP3qtpazA9Y6cZq5Y?=
 =?iso-8859-1?Q?N0P90QDY07g8vxg05x0c/qcldZqH493tmoOIPF3z0Aa/WcJbXz67siV6bu?=
 =?iso-8859-1?Q?RIlJDJIIpyITQQce+Ic73ETs6Nj6ZLps2R5QC6nVanjJZMVVe0rRYHkRKS?=
 =?iso-8859-1?Q?dw6d8t/tx7oWHdX+PSqi7A6zjZ8iBuFkk5mebAYtmiu/S/m/MQ9G7i5k0C?=
 =?iso-8859-1?Q?lxkxvkueTCgiysYggNNZNaZ2+zcBCeD6MTw0G5CIXi/5a/wtXIn31RB5C8?=
 =?iso-8859-1?Q?yVd6p4vTzdDfRr73NzLYAQoqwuEJ1soA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6991.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1tI2/JzBVjhVDs0reM9JRrhm7LDlWaUhpiiGJWtHGE2cQ40gsOPqB/7T5k?=
 =?iso-8859-1?Q?lUGbBRr9eAlAdANvfSpruVFp3sZtTyrEyExd4Oemhz5puhBmsAYglvwBpA?=
 =?iso-8859-1?Q?4dFAS2UGQUHQ7SuLw2y6ONPu6HOEn3oRd+fTDa88X/Kq8a7iIdmLw+jbBy?=
 =?iso-8859-1?Q?UVaiFXPp/W79sCyVHhH5JBs8ezD+i21VMkGCzLKhKe5eA/7z2G5V9d/4R+?=
 =?iso-8859-1?Q?0itA//QSwRjYerQHbxvw8erZVLj6ymCe0spOGn24eJGICSO/LzzCFJnBZh?=
 =?iso-8859-1?Q?5iXjF5fEmtgcu+Gylz3bGVjgi/YFg/GNKl/SVVsSVWQAKqP2CLs8kqXAVK?=
 =?iso-8859-1?Q?AbauqnXm81GIZOXeGNsfxh5hDfGxNqfO5r8Xsm+xyEN1lo42OBhCRcnvfp?=
 =?iso-8859-1?Q?SPCb+DHfyXKr+5IFbY8dECtnRNARaUleofKsK+2Ardk61toPJy137JKe1O?=
 =?iso-8859-1?Q?1omCVjzAA0MvssaFDA7Tn9wLOTogYER/m0bUiHioYELtab5hnvpiKz/Jy5?=
 =?iso-8859-1?Q?6SJ5cr6J1EaNWGmxJOTV7teeLRYdhitdJYi727CP4G8ya3cARMIpf4Zh+E?=
 =?iso-8859-1?Q?jJ2Urkg1u06sFzhLIT1JRc1xta9Oa4x+dGW7TzszsCY1wDPW3HxzZjgH4C?=
 =?iso-8859-1?Q?ayFS/J2ZXYICQ/YASJaqBuv0isnZex8cLLayeB+0rkAzHV5BeSaaj0SbMg?=
 =?iso-8859-1?Q?A9t5lesdw1wx+sQf1A/UK2vNTBEqDjDC1b29xHC03rnNQxMPKHnijjMo8R?=
 =?iso-8859-1?Q?l48p71ToMmxnmbNDniSGKafwSjjpYDs5Ajto91IVUsGbIfXxmx/ELV5b0M?=
 =?iso-8859-1?Q?GtJdxdk4WlIBFHbJPKXB7cswN8RkFrAJtOuGQi2qfG811d51LF4iP7r0bi?=
 =?iso-8859-1?Q?xIcYKEppLqlocIN0VSMW471nyfmO1C6wem3YE0+rYa1QnVK4XE3plSD3vR?=
 =?iso-8859-1?Q?NzPmKzqYkZcOwrj53+QBe03hMw8osinYu9OlyQ/OsJjZt6+9lnwFcQlnSm?=
 =?iso-8859-1?Q?ofXzlqMGBGNSmlNPRMTsamaz4yVO65PojKILwFlXM+sxZit+9hvOLZqQ/d?=
 =?iso-8859-1?Q?HpWWaWtWjOgQRs89ZGGFGwi0jzaVuKoFKYkpcmufvEXUzI/yXxy7RxmCC9?=
 =?iso-8859-1?Q?/km5WntQwAvI3NEMyfqaFsxDX9t/ONcNNWowHY9a3tr5u5OSvuE3jJNRrk?=
 =?iso-8859-1?Q?AqQTE6m9OxLct6mni7WbRJCB5tkwreXVtLOeEwmHn+UJGqLzzQy3Ml8bYG?=
 =?iso-8859-1?Q?QYOV6FkULnaVf7OIEI1zDHCMKsNfhoCJIK7ASBEFQzfYLbHKAokZjKANRZ?=
 =?iso-8859-1?Q?m0LxIHm6dGqkRp09kn/qFSyCeaFZKSpmo7rgtLAWoDaPiX6QTgrBdXE4/v?=
 =?iso-8859-1?Q?Y8LtbU/wKdcpZuBPvIJh8t2wam+erHIDked1lZZksR+kNgKfy5m+pLaQjV?=
 =?iso-8859-1?Q?CUa0wfZpB6cA75ioA9GR1rLJJdlXzvBWi2HHAl/8Z6fGO+HdjCR+YjSAS0?=
 =?iso-8859-1?Q?HpeWBLBhH6DyVdGPzeUIeipnW9rZXfqbwzb/98h45PCKTnTKqMUcw3EYjb?=
 =?iso-8859-1?Q?FEn2WQM01Mg6mnUopxyPrXhxsxjp262AlkD2Hhk0y02jZIeynqJopC8Fmx?=
 =?iso-8859-1?Q?UgsZ+DoXNng08=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6991.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a8be57-485a-4ab1-9866-08dc69775c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 00:40:54.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGXvtCfuPoIeKmCIjxcIrHKHKi3rMWW5GeGxNnhS92STdERCCCgtWsouvY3aeHNs36e30vPWPu4k4GMEZ6zXWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Brost, Matthew <matthew.brost@intel.com>
> Sent: Tuesday, April 30, 2024 11:42 AM
> To: Zeng, Oak <oak.zeng@intel.com>
> Cc: intel-xe@lists.freedesktop.org; Thomas Hellstr=F6m
> <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
>=20
> On Tue, Apr 30, 2024 at 09:11:42AM -0600, Zeng, Oak wrote:
> >
> >
> > > -----Original Message-----
> > > From: Brost, Matthew <matthew.brost@intel.com>
> > > Sent: Monday, April 29, 2024 1:18 PM
> > > To: Zeng, Oak <oak.zeng@intel.com>
> > > Cc: intel-xe@lists.freedesktop.org; Thomas Hellstr=F6m
> > > <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> > > Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation
> notifier
> > >
> > > On Mon, Apr 29, 2024 at 07:55:22AM -0600, Zeng, Oak wrote:
> > > > Hi Matt
> > > >
> > > > > -----Original Message-----
> > > > > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf
> Of
> > > > > Matthew Brost
> > > > > Sent: Friday, April 26, 2024 7:33 PM
> > > > > To: intel-xe@lists.freedesktop.org
> > > > > Cc: Brost, Matthew <matthew.brost@intel.com>; Thomas Hellstr=F6m
> > > > > <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> > > > > Subject: [PATCH] drm/xe: Unmap userptr in MMU invalidation
> notifier
> > > > >
> > > > > To be secure, when a userptr is invalidated the pages should be d=
ma
> > > > > unmapped ensuring the device can no longer touch the invalidated
> pages.
> > > > >
> > > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Inte=
l
> > > GPUs")
> > > > > Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate
> user
> > > > > pages")
> > > > > Cc: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > > > > Cc: stable@vger.kernel.org # 6.8
> > > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > > ---
> > > > >  drivers/gpu/drm/xe/xe_vm.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> b/drivers/gpu/drm/xe/xe_vm.c
> > > > > index dfd31b346021..964a5b4d47d8 100644
> > > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > > @@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct
> > > > > mmu_interval_notifier *mni,
> > > > >  		XE_WARN_ON(err);
> > > > >  	}
> > > > >
> > > > > +	if (userptr->sg)
> > > > > +		xe_hmm_userptr_free_sg(uvma);
> > > >
> > > > Just some thoughts here. I think when we introduce system allocator=
,
> > > above should be made conditional. We should dma unmap userptr only
> for
> > > normal userptr but not for userptr created for system allocator (faul=
t
> usrptr
> > > in the system allocator series). Because for system allocator the dma=
-
> > > unmapping would be part of the garbage collector and vma destroy
> process.
> > > Right?
> > > >
> > >
> > > I don't think it should be conditional. In any case when a CPU addres=
s
> > > is invalidated we need to ensure the dma mapping (IOMMU mapping) is
> > > also invalid to ensure no path to the old (invalidate) pages exists.
> >
> > I understand for both normal userptr and fault userptr we need to dma
> unmap.
> >
> > I was saying, for fault userptr, the dma unmap would be done in the
> garbage collector codes (we destroy fault userptr vma there and dma unmap
> along with vam destroy), so we don't need dma unmap in your above codes.
> It would something like this:
> >
>=20
> I understand what you are suggesting, but no this is always needed.
>=20
> > If (userptr && not fault userptr)
> > 	Dma-unmap sg
> >
>=20
> With what you suggest, there is a window between the MMU notifier
> completing and garbage collector running in which the dma-mapping is
> valid. This is not allowed per the security model. Thus we need always
> invalidate dma-addresses in the notifier.

That make sense. Thanks for explain.

Oak

>=20
> Matt
>=20
> > If (fault userptr)
> > 	Trigger garbage collector - this will deal with dma-unmap
> >
> >
> > Oak
> >
> >
> > > This is an extra security that must be enforced. With removing the dm=
a
> > > mapping, in theory rouge accesses from the GPU could still access the
> > > old pages.
> > >
> > > Matt
> > >
> > > > Oak
> > > >
> > > > > +
> > > > >  	trace_xe_vma_userptr_invalidate_complete(vma);
> > > > >
> > > > >  	return true;
> > > > > --
> > > > > 2.34.1
> > > >

