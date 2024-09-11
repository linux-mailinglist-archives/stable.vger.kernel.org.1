Return-Path: <stable+bounces-75878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825579758CE
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76BF1C22E0A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B71AED2C;
	Wed, 11 Sep 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgdbXaa6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA64D8B9;
	Wed, 11 Sep 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073689; cv=fail; b=pHbhLZ/XdDAKVezbPTrBKv55/sJ1n+TzvAD/iWY1AWGh2jPoX5utPPgn/UGl8qf/VXpcBRz0moBy5bjtDAEQTaEYrmGMSTgY7t2BIhIJvJK9RAH+DmrBs6LWyT7WWu3B1HM52jiBSz97HmSBSVYcXp/YvEaQqkMFEi85y/3bje0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073689; c=relaxed/simple;
	bh=yGa0zbcep2YL+lTeheGAmR/gBTAEHycm9HgpHA+OsGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q9gH4JNUUxLl+ERaC8m03oWnk0U4wSj88BxKuutKNvw6WFRngVVN9ODWc+qRaSwU7ZwTNp2PRDYVELSlEgED0UFQu+Dih7aJmQVvsLx/67MPqFNSuFzXpvyPbJ0uN7J/UWPLPNJ1vJym33/UgxEdJCsJL1Y3EY17yIR1jE5jy0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgdbXaa6; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726073688; x=1757609688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yGa0zbcep2YL+lTeheGAmR/gBTAEHycm9HgpHA+OsGM=;
  b=CgdbXaa6Casj1yTke1fkxunwwTXSRcEt/EH92mzyM9j/RuQrxNT2yUxk
   Medv5goQRddpBrazVApJYJHxwvGQ2bX5G58SbHqbAGxDS24aPzog/Hx1x
   Oxne9m5AzKm8QyqTlv2wNGSuTqTw3MR+T6ZTBb/wzXUWxMpa6/MYNRMjv
   ZoAXMlTBvUEmcPIvK73xQjbUk5a17YHIgCKQ1QKwZna91PSJdahWiBjYE
   Hqc5iVy8oSu3olVsmzRaX1op+xJeu03QhwOJy8cJW2ArVRWQfLGeuFbD4
   GD7w+gQdHn8DKUJ+b/k1A3SRFn1AbEQHWxV7ToKh3QS37N92prj0i5RZr
   w==;
X-CSE-ConnectionGUID: 7txRwc7NTwuFCxj5uGKuTQ==
X-CSE-MsgGUID: OiKZuUm+SZCMiXE2ALuPoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24428252"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24428252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 09:54:47 -0700
X-CSE-ConnectionGUID: 1GJF6bGmT8Ck0PGAYDTrRw==
X-CSE-MsgGUID: SDuzIsh5QIOYUG9MeLqSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="72198361"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 09:54:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 09:54:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 09:54:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 09:54:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 09:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlyt0esc7txnmZ1aJeJQlJHFxDqZf6+g7upMLS616Z5Wq/qpWT1fc3+qJEBh0ptaN/wfOlq3P/m0j5PzO14YzAyovKhdjLhKAAQlExDLy0ZdsH/EF9df/voP5xU93NhJaxI/qjdoV7Fu9Y+tpUaKZblXeTNEkkG/GCoxv+j6lwri4ILk9Zzrwf7TBzWa2hcTbNR2FBaF5wZKczpSDqX0crzM7goffOyfK7CYZj2jPpxrmyfwmIi7Nq0Bhhi6dotEwhqVRDAsqH9biAM+gtlq4iDDvR8qg0LUxCHKgcEdHsFjNPKPL0nJWimBTu310n5I0fh1UJdEONIOR2WQhMw8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wUpoiTItb8NiSnEcdegQYahmQuRcbUQWD2uCsLuKcM=;
 b=dpuvGMEGWl1RA4AeVReqW9B/Hf3aToLE+m8wgJrCXZfgg4HQzpfGb+n7b2F0/lljf0JJl0kChtRB4ISm2fpNtZVpS2DyHocmfewylLeZ2B6qseoa06K5b/wthIj22HMajyv6uVixpg4Bo6fZPh8pwuYQiJqBsBMes5UlmMBSjfh0zFyCKT2FrO4xYf7DdzDvW/BY449wWRfKxmOg1aG6AhbJUgTFBciEbTCAaqonjld+N/XNvkaHo0xy9l4n1vTBXJ8RheD9eV4nUyZKELp/s7R8G1qZSW8aOOYiDTuqsgTnBzFEKDRS55BIiR9xbouBzg3T/z62gFnf+Z159VHkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by MW6PR11MB8409.namprd11.prod.outlook.com (2603:10b6:303:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 11 Sep
 2024 16:54:38 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 16:54:38 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Gui-Dong Han <hanguidong02@outlook.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "baijiaju1990@gmail.com"
	<baijiaju1990@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH v2] ice: Fix improper handling of
 refcount in ice_dpll_init_rclk_pins()
Thread-Topic: [Intel-wired-lan] [PATCH v2] ice: Fix improper handling of
 refcount in ice_dpll_init_rclk_pins()
Thread-Index: AQHa/hJyDFp9ie+S+kCRwGSOskH2nLJS2doQ
Date: Wed, 11 Sep 2024 16:54:38 +0000
Message-ID: <CYYPR11MB842927FFCC14C0B1B4F39534BD9B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <SY8P300MB0460F0F4B5D0BC6768DCA466C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB0460F0F4B5D0BC6768DCA466C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|MW6PR11MB8409:EE_
x-ms-office365-filtering-correlation-id: db62c21f-f73d-4b9e-bfa8-08dcd2826c41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?l5P/9XbpXfodzbvzjD5PEyaIE6ahyW+TEjPuZY6raPyI4leflyf0gRkE22Pv?=
 =?us-ascii?Q?MKJ81PLulhjVgpfdvt8Z5KaSFn4cLc8ZBNTUl86KJFVVde0WaFM2S2OmoYiS?=
 =?us-ascii?Q?LDCMKhaf/RwYUbi/HKrsyXKfhYcsxSUUjHaT/wjnW48B+29sqUVpSOkD9ey1?=
 =?us-ascii?Q?LQmx+AArgD0eDkUwNJuEkYuo/q+n/xtXILy0x3I9cUBSzWf/SKAFjF7kn6Tz?=
 =?us-ascii?Q?IubhNhNm2NEixoxElFNvJPEuxTcjBp/l6TWg+dIxwsldWoVHd1JZRliXVmrn?=
 =?us-ascii?Q?KO8LEG9RWlM1iCDnylcAZAlbf7SzikMCAPtw0EXfREQwJjBzwWGnAoirJdgc?=
 =?us-ascii?Q?D5j2izJfGB8/9pCB88JKgMNCvCyQgn4ofiU8CnMMweGCcNAk2+kRsPPgLlh1?=
 =?us-ascii?Q?ZLTw8SU/zYFSG63X7Z7hSBlspfmUiVwAQWQH5pusqfve8mlJZz7nZy/RIMYZ?=
 =?us-ascii?Q?Y3Qh05FhfOCH5NLBaV6gRcAbXc8VZkNKP++zk8XEXNiZuB8apX2lZDAyz+T2?=
 =?us-ascii?Q?nVu2hEX27KE+Z51zLyJFW896HBiIimB6GKe8sgKKK1/dEF+7PJhK1JEdJ/Mn?=
 =?us-ascii?Q?/oYXUkJ5qsrPRkHQivJEhEYhk8uvaNA2QJROwlz6l0t5bh+xr7u7NlDJoXvP?=
 =?us-ascii?Q?auciUH3haR4RlJ1hP3rAph6aQB1udZzggJoHCjIN59bCZkebX1sm5R2Y2/H5?=
 =?us-ascii?Q?ybC3uQwA2uW5DBfpzLfJ33qmqou4lYK7EpmgxjAIj0gEFuuSS9cxbMswGP0C?=
 =?us-ascii?Q?FxhFi3+tDtyitc4jeD8jJshTq3MqMN9hmUgegTbryvB0dj+ysX9VmXkDZA3t?=
 =?us-ascii?Q?7InHdXvxtCnzcTriPZ0+rTnsnwz5t3b4G9MXdkXt6Hnu837Syrpbvp6BKBbn?=
 =?us-ascii?Q?F21dfpmurHj58s19gJbmbozG4Iz5TDYlLHbCIWmwnBLIRTPaRoIQnbKfsPVm?=
 =?us-ascii?Q?AN5v0orAHopb6JG/klNIKz+o+U2Bhjb81CYDVKKX+v3s+ihqSdgBdO+8/hh/?=
 =?us-ascii?Q?S3uVOxUHkqo3yphbGCrJbAGzqIYS7PjPBuylwtih/TV917FfNAhpDPRtWy6b?=
 =?us-ascii?Q?zKzgPz0xNYYA5u5lK0C+hqIyP1QglMNai87R0n3/fDP6KHAfS+eDDNEObpmd?=
 =?us-ascii?Q?9ge2UqUUphOUAd4EwadMoIxdEtLxPmYend8hcwC3uAfwaWF+f6Rk9mLrStJJ?=
 =?us-ascii?Q?dv/+cPnFE21nXZLP8XhfUtTtDP+DVwqRSa1+6AyeYJpG4/kAeh3bItaGlDki?=
 =?us-ascii?Q?MhZGDGCEsNNlP8WaHkXS5Z6L7BCkXjGLvZRnmtGME6FvoATyZkn78Iqqy7v8?=
 =?us-ascii?Q?j6X/52z3U2SdQf/zG0Ot3iljk0xXFH7m0SD6nH3+U3OcRv/RAUJTJF4J2Ldq?=
 =?us-ascii?Q?hGVc5jys0Lg+Zf5RpdLparU0hoQrbeGeJjgZSR+7HAoCYHXcFQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rMHR9sre7wXNR1UdHE37BU4gAqotT/o9ZM+5+rRXXj8y2UC6S60yE8JQc4ha?=
 =?us-ascii?Q?B6Ozm0DfcmfspQFoVc6wGh7LdoC435RDBLK/Rm4xAkqHnhaM8nomOTJTxlVb?=
 =?us-ascii?Q?qgkfJYNDWO4+wbflh236IImtNnrhnEmDOUjt4PsKMncbBf8t0jFwAEfLUwMS?=
 =?us-ascii?Q?VNtJjvGTDyRzZAj/p/7kBLkbRRAR43tigsf8ls9hG4zNQZaRI1UuRszFx8vH?=
 =?us-ascii?Q?FXYgr1XwbSWheksrrlkAekX6aeoTaE/XdwmTHEvAaxi6cIJahOU1RJjygxPW?=
 =?us-ascii?Q?eJ68oswIFH01pRLWbCTI/qRNrI7e5IRoNHHhdh/hCOhtfcuv8cbSssy4ucy4?=
 =?us-ascii?Q?t14pKoCdhpW4CKcSd/6s+HhRb+nxiso/H+KEMUJi8V7+ADJRDOsBJCY7bR84?=
 =?us-ascii?Q?lHbYOeGu+frkaBnsIyzndRY0/KcXVhQTm4Xrxs1d/RthM9uQKsWGpDvGyv6e?=
 =?us-ascii?Q?PFOgCIObzMawrSoz+s6LUsaJgLH0LNfhb3SajwgEd+p+q2uXjMMonDzIs8n3?=
 =?us-ascii?Q?qc1lgAmPR5sKc5QKoZnZTI7ANAkcWNh7RCAhRshIPnHyWsj2QheaChjBpvYA?=
 =?us-ascii?Q?FefoVMlY2mFjLjHQtfohBupfkTQjhArTNBawDbB+gN2jm4NHFA6xcc+G/GYT?=
 =?us-ascii?Q?oMMyqAr/samMiszqWuBS+vBwViJ5wVo/aSrquuRp36qiRV20KavkV4dGXd29?=
 =?us-ascii?Q?mRu7EZ+A5Gil6Zl6nkKm4qZjTc4vFla/3HlnJV/8dxRbFi7Icazu6tAVC2yQ?=
 =?us-ascii?Q?fOPaCR5pIprdRdPgagKD/pWcEEhYuGBz3hCKchi40BWdewRaJqTulZx0UpwE?=
 =?us-ascii?Q?zCQnqBG9OAZ/j6twOLQHxnfC87shwUcVorgW0R+p44Ce/u+DqI9w2SebPQXy?=
 =?us-ascii?Q?l0/H6lB+yEaQdwdAXKCRuCSKzEllWf3GEIRc9wwU/52cCwhxZ25EyVkRCZnz?=
 =?us-ascii?Q?77Wyh0y5f57KtwdnMGG2rm5QagmpbnGfEJXrKHesNJM2WfA2rWN7OvkLHi3R?=
 =?us-ascii?Q?wPEO9G1OqBSLfaXae59SjnVmt6UsVZZS9Oh/P4LgSG8bZ1UYJmOFkrL1G8zS?=
 =?us-ascii?Q?x1j3ml/EQ7oKU2dPFwaNzxxwER36AkvPSlycLObrM+301EqMrl1uHYm5XETM?=
 =?us-ascii?Q?KLoHQGlRzm8paCgse5+C+ar0YvWg0kKm7BeHYskXT+SijsVxe+xKlOSBxfYy?=
 =?us-ascii?Q?LN0snJLMn8+RUGrSq+ed/LgVhrBw9oP9uDGo6BvsyBb46Qazb5cv9Po83iI9?=
 =?us-ascii?Q?caDBbE2EFJ2OuEGfzF8u9Xfh892cE0oVL2FMLDrlLmL1w5H3Yu4ja/RWhsJf?=
 =?us-ascii?Q?gcb0Wu0cK4BjR86D3//Lf2D3Sl7/T9YPspi5tCio8T0lfPvvERnx9FOF8lFh?=
 =?us-ascii?Q?LhVXgcTBjTI57kqfoQv6r5n0NHOorpU/s6cxugR5JFM6HR04QpXZVSgBxNDf?=
 =?us-ascii?Q?+DMZqvHE/lEGTEg+I4UariYvWSjCKTOhbrrpUVL6n1TqRVtsrcsMklxeSIPG?=
 =?us-ascii?Q?bE0d21YPjnkyrFb0jTYIDupQxBmlDu502+XC45kqjbBCf+aRGYii65JiKa5J?=
 =?us-ascii?Q?0slufIZZ6ChlUS8x7t2ukmHG+yJYNoY2cctO92ggpD2/etg3+Xdgv+CzByNh?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db62c21f-f73d-4b9e-bfa8-08dcd2826c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 16:54:38.3053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdEX6dfOMymrR9K2xzkricr3Pedt0d3WHg/Z7ioZnhu6bqevjcKlq+R87Zf/9BixUUijE/Ngr9LKT8ZME/cn7YxrVpb2FQx3RTaw0TmHh+fVETxRj+RgJZ+pzsKE0C5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8409
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
ui-Dong Han
> Sent: Tuesday, September 3, 2024 5:19 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; davem@davemloft.net; edumazet@google.com; ku=
ba@kernel.org; pabeni@redhat.com
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; stable@vger.ker=
nel.org; Gui-Dong Han <hanguidong02@outlook.com>; baijiaju1990@gmail.com; i=
ntel-wired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ice: Fix improper handling of refco=
unt in ice_dpll_init_rclk_pins()
>
> This patch addresses a reference count handling issue in the
> ice_dpll_init_rclk_pins() function. The function calls ice_dpll_get_pins(=
), which increments the reference count of the relevant resources. However,=
 if the condition WARN_ON((!vsi || !vsi->netdev)) is met, the function curr=
ently returns an error without properly releasing the > resources acquired =
by ice_dpll_get_pins(), leading to a reference count leak.
>
> To resolve this, the check has been moved to the top of the function. Thi=
s ensures that the function verifies the state before any resources are acq=
uired, avoiding the need for additional resource management in the error pa=
th.=20
>
> This bug was identified by an experimental static analysis tool developed=
 by our team. The tool specializes in analyzing reference count operations =
and detecting potential issues where resources are not properly managed.
> In this case, the tool flagged the missing release operation as a potenti=
al problem, which led to the development of this patch.
>
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> ---
> v2:
> * In this patch v2, the check for vsi and vsi->netdev has been moved to t=
he top of the function to simplify error handling and avoid the need for re=
source unwinding.
>   Thanks to Simon Horman for suggesting this improvement.
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


