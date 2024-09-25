Return-Path: <stable+bounces-77714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60F986479
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E20D1F28755
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB4208D1;
	Wed, 25 Sep 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN5jrf3M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A812F5B
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280483; cv=fail; b=VXPXg7wjdHXFUN0PuRjtOHKbDqEd8TQ4L8A4s6+0EUEKLp1E/2JeRbxp+le1JgtwZMwWKr3K0shlu6bQcRl1/D+J9Oqlm9XijlZs5mnQr0+9mNNDXNUOE1PgNeQAQOY4pEinr+PcEUBSU0AUJerRm8bYz5Gyu2DqP51AdCS5a1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280483; c=relaxed/simple;
	bh=qZ0aT6nAb0cxjtysOj6jd76jLeyuYk2WOv15voipFwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QtmCGfNa5kJs9qrWwn3EVsU2+zmxrmhT52ihPy4HI/KhGdQ4j0BIFHLKynlUopYDtvw5QsoZ0PChenr6ZXYmqCh06dzlmLEi0xvXuv5Tk95DNSxLBVTC89vTVZw+Qauwg0pcIA76FUVg2HO+LHXvO/A+h4kpNx5X7yRoGHHHcRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN5jrf3M; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727280482; x=1758816482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZ0aT6nAb0cxjtysOj6jd76jLeyuYk2WOv15voipFwM=;
  b=bN5jrf3MFl2p8N75XDDWY1aoyN/yjcL4/ZjXa84vrWLzHPMSKULUCYNQ
   gjvc0uvtJ4/hSnNnbnfXZq+c/iHRmzjuSWa7X8NNzMYej51MMBpI/TYFR
   zxffRijqvKzM187sGhk8crVO64Zn+nF0fux9l/b+yTNEerH82Q2/MvMV3
   w1HrecjbXWCdvwjFJlGQ134vOt7qurmDRnRN6tqanxEWmAAderfWrmBgA
   qN8sckQl8rlbvtOoB1fsnpba77APIbbvlusIrSHrV18g+vfjgxtmX/gAS
   8YNR0w8mPpAGLo3UL2vNDY0NwI9g4vrJeRgZY5jcY+MWajlkKWU24U8jX
   w==;
X-CSE-ConnectionGUID: nlUCh9+DT1qiSSfMz9WDKA==
X-CSE-MsgGUID: TqMWlJKiSGqpEQLlZIOrog==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="30050130"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="30050130"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 09:08:01 -0700
X-CSE-ConnectionGUID: bSvWHNuyQiqyXSz99/Vo7Q==
X-CSE-MsgGUID: N2UdU6NnQH6nz4L9qINcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="72634511"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 09:08:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 09:08:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 09:08:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyxLFDcSrD3koPw8zJ9xjAu1HOWHBIk52Sd8qo4rA0rBPsQpyu1vYRs9gYnMAF4kjOfUdcW/L6GCdTq4fXrqNn15tSSQt838XoJp+czp7/N5XdVyUWczbUBnfrvpr1+fthhd0qhyoXTFEz1EnXexRVLs4WXOIrdVV8ilOSxuILoKLXx+MRBSUDLAug6jjiZBvJcba2UM1QaXS0hCOYM+bwp08BVW+TtlqAFHwJtdZpJA84mhwSWgSfDod3ZlMV73vsNPrUWGQRWcAVkL36CnsvOGn1jJu1mn26bipzxLwo0b3OmbrAxHnG1XSfA97YHkzv9dEJtFb80Rkh56b9S/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ0aT6nAb0cxjtysOj6jd76jLeyuYk2WOv15voipFwM=;
 b=LxYturj8JVtGcggqP0XeK5RUkvpbVS6/9S28U6+9HfpDOVhMvTzSNAqJxbPW9vVP+r/kmokD7P/jabBrHe5mxhLe7SKHfoxze351e9pXPwJNQ+fb0UmqsmJ7WPjyxl+EP7nYc6a1MCtOyYbr5u9vGJE+d/zVypUmRwcf/51cRjsq1jimbmqeLcrTEwZ11iPdJuWVZ5aO0PV+TtsUliV/aV5UWbQIkdRIYIcdOt/4iVgSwN0uM8D33OXJ3a2jAeCsTHMlClb9xvrgq1ai+el7aOB8mY8bIzFow+/LW7XCKSDEN4Pv5Ooag5/Z1iqw8qDzzVfmhNRJNXBo2wDDlYdqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 16:07:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 16:07:55 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "Gupta, Pawan Kumar"
	<pawan.kumar.gupta@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Thomas
 Lindroth" <thomas.lindroth@gmail.com>, "Neri, Ricardo"
	<ricardo.neri@intel.com>
Subject: RE: [PATCH 6.6.y] x86/mm: Switch to new Intel CPU model defines
Thread-Topic: [PATCH 6.6.y] x86/mm: Switch to new Intel CPU model defines
Thread-Index: AQHbDv570RNadZKaaUeO98pZpvmh1rJoq7sg
Date: Wed, 25 Sep 2024 16:07:55 +0000
Message-ID: <SJ1PR11MB608342DD5D67CFF7E6894B11FC692@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240925035857.15487-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240925035857.15487-1-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM6PR11MB4740:EE_
x-ms-office365-filtering-correlation-id: 9856ccda-0563-4eaf-6a45-08dcdd7c374f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gX/sRa7Z/h0Io1udQd+5BLE4AJst4S1U11UjGvhsMUdPTZFZQKnaIRqTL/tK?=
 =?us-ascii?Q?RoqsQ0QnVbUOaeEMhz6safPR+oSDIJnUxJct4+2PSaa6itq2/kgcW98BflAu?=
 =?us-ascii?Q?gaXFQX37UwfHT6yLTsVnxRVY4x8KnDL9W2ltZ7+B0KMJp4/qDicNRg/RCYL9?=
 =?us-ascii?Q?PUVXTRtmcQF0hnQcbcf1JeTWyzlbuTRgyJuqoBXAEXlkFlOJuPBJK5jd44Bg?=
 =?us-ascii?Q?BBSNluQ3sGSwGQWVKAAMODkq5Z0NHwHsIMQk9+iXV5uezq8ZygAI/VZt41Ip?=
 =?us-ascii?Q?RCem5VDLae2iKUWrJTXDqLk5zL/OJyBH4IbkbNMv4ztuFc8xT07hnMJqLMM1?=
 =?us-ascii?Q?rjlN7aUo2yGUFw3rGp4X7WlTLh2SoW0gexjnV0fe3TqiJyNOJPiKxphYmUDM?=
 =?us-ascii?Q?v81/FQMv+KNhFJgLjeZ0vMKmkWkHoDeDdZnZptjduMHtvqXOxiTjP2YoqnWH?=
 =?us-ascii?Q?deouKGOTWeZmDQk5rfIbctKhmsNrk7z/wZdrzlAPzzekZgerVlEUu9uES8eN?=
 =?us-ascii?Q?UhCZFu6D43Wz3+L9N8JM2+5JKZz8T1LNbzdIgylSxHpLrK3m0wTvltSRPosZ?=
 =?us-ascii?Q?wAKV2ek/BnCpexvvuolgdqG2KF8KLsSUXga3hvNckP/Vqura4Tdn/Jdq7xU2?=
 =?us-ascii?Q?KD8uL1xhscE7D8gdbRKxm0vm3ylFzkRY4AAQ5YlVfHvFFbe0hGeHav/KIjyv?=
 =?us-ascii?Q?8A6Kp+dRGlP7iAt7Ed/V5ACfZFCFsqYWZuxyxTW74p8U34CdEPWsqoi9Hosv?=
 =?us-ascii?Q?RFz5FdhGjirRUaHoU5Kl/lPsWO1BvUMV4BBRfDdeoNicr6M5C3AiJ08nivRf?=
 =?us-ascii?Q?3qp5rLWEnIMOZPOPrKF9AaUAJuuQmB7ikfYmdxO7LZERzuqGZVmazyMUzYQB?=
 =?us-ascii?Q?bTEhxqO60ADczC6tCZD8RoC53vLM4z1xFA7Fr6hmTBe4mC612f9rJBGMlL6V?=
 =?us-ascii?Q?wcH13+r3gxxdoykD0ONZ9YjipS1B6kS454sAzduTLrwmKdK1mZdOAras3Bkg?=
 =?us-ascii?Q?B0wdcWRGQj83ztB0xAEICWcj7EnplTcg/m689SlWVIGNOV9aUItb6bgXWixX?=
 =?us-ascii?Q?X9gm81zuM/mnSaiNUqUaamhL+ZKXA8b5qr8sg4J9IvO9cujzbZVcOwjtQzsn?=
 =?us-ascii?Q?yjzFLA9yopdOOtNGyzZhx/QXbv/m2oEsBLhLafk+3MTdMf6UErBoL/c7Y9zJ?=
 =?us-ascii?Q?qmpXXUyW/NO0Xwsu/Rwh4l7ngkBJgYpq45gem8kHLYs/KbLefF3Li2WrqXlY?=
 =?us-ascii?Q?1uVWCa37BbXIYV4E4XnvCTHOTsmlFPox6whHEauHXCTyiCy/PeKNgpCFX6D6?=
 =?us-ascii?Q?lgdVE7SitBiTLX7qV215zZJeX2G8XF9+ALJSiseDVjJ2QRFjCDwQMOBv4+n6?=
 =?us-ascii?Q?mHdQ85FmJRM2ikNGZG7vr8TexMewuL018qlv9zaKw8zfRRjlmQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1rnNqiwYr67fwZpXeknvjcDD+iWgpqWIPgrKhWTxq8ztQdqTFCf49WuMghir?=
 =?us-ascii?Q?CqMwXCaSTNjZjuwyVD0rOd5XQPAJJboDfWBjOQxaFdaapgz4X1CZayatpGcW?=
 =?us-ascii?Q?qaBihPtUF4sxwQ71GArQhijOp+17+1Osrkvc/JJwBIQP6nujYT8PQxKXDM8U?=
 =?us-ascii?Q?r3rmVYBvloZcNOWASI2QVDwOspuZucz2iSAPhjgV0IRNtMH/9uR8/Dlp+PlX?=
 =?us-ascii?Q?QZgdW53gbNGAZrjWrPclhnnO3TI789egarYIsCuAtqpFo0I56mQo4SZ6Jj1T?=
 =?us-ascii?Q?1xYaEnyWg+P9GQJ5Z3M3cd2gug0FAaJtyCkP+uEGUOMyLVi8Pziz5PJ5mEh4?=
 =?us-ascii?Q?IOISTbM+mg+jywS2sGm3O3240tISBRxQJz8HpRUF12vdRcMkyc3oGNlQQRVw?=
 =?us-ascii?Q?MO2/ZbbH3nSY3IJgj6SbuLOluHGHN6LrZSaK4GczBvPidQUkLHQk60RU2hyz?=
 =?us-ascii?Q?uYP6r68FBkGg3ycvoIaJEjK9U4mTx1gI7PFbH8vmhzocJtU5itynGD9ZXCKa?=
 =?us-ascii?Q?EcjsIlen7WqsaMExAhJ26XQV1HkmIahQP8VJf+DtEqce92I5Wndb9FK9E//f?=
 =?us-ascii?Q?k+AT48FzL4WlvFDTF7ReRfQ0svt9nnJax96gb0l5vW14xzMPubsPND7jxGTj?=
 =?us-ascii?Q?xxVX77WFQTZkPQgMuDdDpKwSau+RekxxLZ8xE2nMalE+K3wJ7x0c2jJ3Y2eS?=
 =?us-ascii?Q?F+aml6DhaOmfNnpRJuLy3gH8uA4RAF948twSZPeh9IPvOJ63Gq8FPJScfLZ7?=
 =?us-ascii?Q?7RsjwCtOSgTiZSNNVNL7/rrnB/icfkWo3MTA2Pb1KaJKGIVHNp9fyIDBthsA?=
 =?us-ascii?Q?YKtrO+BGkt30G1l2VBqbUCOCLxEUloXw4AtaLJF1P9i25QMigvFH1GXmF9k/?=
 =?us-ascii?Q?xh+Sw78efXoam0svX8hdt8c4L1lg5zsn8NFHZ2h8uxkFZaEZ780i7Ir9q780?=
 =?us-ascii?Q?yDdBWH4hV87ew9UVmF8q3Ooz3555NFi8aI7pkOYgOcjWVY0eIkpngbyJlqNo?=
 =?us-ascii?Q?UYzbmV9OOEytTJUNfh3Ql1TIkfzCh1N9zWZuQViC+37s2pv6sVSyI1WuzgHw?=
 =?us-ascii?Q?fzCGLEy31CkgDEdiFe1qQzPGpvWiGEVB2zf+vo+W3GbacB2e8llSfSpggFHm?=
 =?us-ascii?Q?tN9rp3OK3fVAJ5toBHiMMoBcRCLqZrYUopMCj9g5a8h6pzPmRfBwJ+ZKIYHt?=
 =?us-ascii?Q?aSFSVQarfVbIMM5ITC5sUwUB8WNo+845xT2d/9zk28NJxayjwU9t1uJcOrZ8?=
 =?us-ascii?Q?VcFzOQhehe6lLwEJrdzMyvbxC7ug96XMLUP/amFybuX4NH+p6Z2WkmtLBhKI?=
 =?us-ascii?Q?hOZFY0/Txw7B3rtx9pDBU+dB5TCRyadHHN5h/D+wLQCThKk8Nwy2qPHwVT4s?=
 =?us-ascii?Q?bCJiGU9R3HTSEHRHuAHyAFH/7qwqo3hu8nEcGb6CgOrrBfcwJ2vfGPVvYwIi?=
 =?us-ascii?Q?W3dSqRYVEPLkZOYLl76jNaMJRvPJzKqRQlcso+zeNJqg9OZP2uigeoBOpB2g?=
 =?us-ascii?Q?pLQ3uvWlAZD2vWdnGqV2w9quYcYntVDj4wF9gBCcty6ubFldOE0c8SPdFvyu?=
 =?us-ascii?Q?z2ky2h6jSidn82FuD7l9HKP/7CrpAmbz7f4sGFTw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9856ccda-0563-4eaf-6a45-08dcdd7c374f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 16:07:55.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgFMf4OhVguPBgOPyewr2leJFhsNgBY81EOIEXaxMdfMJPSagKwhIO3unDUxSRZNtFzrsFFKeLxtYblaqTvaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com

> Maybe Tony and/or the x86 maintainers can ack this backport?

Ricardo,

Thanks for doing this backport (and checking all the other FAM6 uses)

LGTM

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony


