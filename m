Return-Path: <stable+bounces-249742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FUEN/YxDWpauQUAu9opvQ
	(envelope-from <stable+bounces-249742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:00:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3D58769F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D71413075121
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702B374756;
	Wed, 20 May 2026 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcXmpOBJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D58374721;
	Wed, 20 May 2026 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779249439; cv=fail; b=MDn6dQnZLngfL9b7wOf0jq6wb5Na6HMxQjpGDsE698j6KQbpfp4VC7L4PCTLbCwiPMuO6q0OrEzKTVFuqU4mYrMN8sCO8MEVWeRmov2BlJBK2YIYgol0MIQXrUhUA51exAYtRRSca0UwIUMMXZcI3eBGr7IOe0k7daV3ALOfLQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779249439; c=relaxed/simple;
	bh=WYo1kuzQHSuHM/jkoxbwzJVw+9tzyUdmW1SOrjbNVFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhrqJ41wOSoLKNbkZuZ3oW7KhN9bR7HQTLoFJbBu1hQkjCqndI6OtWH9tHGEyVtP/c6Mh1cytjD9yj+ElGekpuF9ZIf7EY3OA4O0fbFVnn2XIpz3gEXUb8U7NlTS3rm79+D/hxntLw2QeIRMRdn0jvpcnEzYer8Z+aj+g/IMW+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcXmpOBJ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779249435; x=1810785435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WYo1kuzQHSuHM/jkoxbwzJVw+9tzyUdmW1SOrjbNVFM=;
  b=BcXmpOBJF06ATZDae5ZzDLcONfqsdcAmLP2K2fsOCNqfojGmmIV+B8CC
   oMJRhufaKdxrDev/i/LyjrD469OXmqGEj+DywROf+mdpF6MWw1JU905IR
   ULZJtiAwpEr3xVDUhQChqPuN+lfQlq4e3xgLTwDKWTp8H3QJFTi0W5ofL
   bVYFYgWwcbG2XIZsDq6fvAR09lNNr+0uVyhxP5i+FP9EY2hvnQfQaD4Ln
   dbtaz5dN3runB2ZYQ+lpzJt/3vlfyjN6FK1cTkW5L/8GQG4LHiktKDeK5
   CPAMqRZdMgmDJMVeXXvqr1GbO0apJ1Z5D1p0AdQ4JjcP8QACLgKPYnLLA
   Q==;
X-CSE-ConnectionGUID: 5JE2QMQ9TfmoUnfNqBOzJQ==
X-CSE-MsgGUID: E/vFaN0ZT0aiIQpxY67dTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80193952"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80193952"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 20:57:13 -0700
X-CSE-ConnectionGUID: t4Pc/+K0QF+7bKkZ/eKPCQ==
X-CSE-MsgGUID: XUMUi/ppSbi5fgGvhDt5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239010439"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 20:57:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 20:57:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 20:57:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 20:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBzgWiws/2RlUuK69p2273hOwpudNvGyrCbS5YBbCj1VTddmEw15By6SV4akyL3smWB8GITXGCg690j2yuOxdeIJWZEhQuRAazx7NHDHdypRQ0N26JXWPa7HmpvsDrquBa5OQa9pvO4dijTFMJIQHQD0N/Xr9XuxNM8ubhc7Jxm+6DjnyOiyxLO1C5qfSAqNOe0/W4fvdJ/y7/N2fG9pKjxuXdJKHaG9vicNnz3Z8/LoQrKs+aSZB5TAjt6GvLKC/pxdJzfcwfsksZfv/d8Oh5vG5ZLHhSe08C0NNWltF/VLybwmKi17XkFqRl56Kpsy1ySpIqz/M5fivcm/2/3q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzgjHayD+/U9wDdXuwvjCje7TyJbasZ0/q8I9OEY730=;
 b=UM8Pir9KVaZt7UHjUfHSdGvHgMRVoeOCycxJKHJ2ckJRMYRprv1Yx4rkJ5eRfqWjE+mhZMXA2ZwFJNPqws8yWVesS2akYw2o55qcQqXg7UmWcjgWiancIRTLFm9T29Jwl7iILap+2hW9HUIn+JMH7dHubwxsMSaoHbNI8rQzey3+TddgS7Ha9rw1+Hc8JYE7CUWzX0ncnU0FPIUSnx6seuX3HR5MoSRC8QreTw/fGcdO5/qE6iAOouOrf2mbh0pIVdxaN/rmeT/sVErUl37c0+S4OOE6zfuBibPsSw6Lqb5YOF69+5Nfg25rwrha5hjIL0xRjPehTfKUXm0HJegx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9873.namprd11.prod.outlook.com (2603:10b6:806:4d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 03:57:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 03:57:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Kumar G, Naresh"
	<naresh.kumar.g@intel.com>
Subject: RE: [PATCH 1/1] iommu/vt-d: Avoid WARNING in sva unbind path
Thread-Topic: [PATCH 1/1] iommu/vt-d: Avoid WARNING in sva unbind path
Thread-Index: AQHc51DVDJgZGhnSx0SZSoZJBRDoI7YWSqAg
Date: Wed, 20 May 2026 03:57:08 +0000
Message-ID: <BN9PR11MB5276FE9C6396ED01D36CFFF98C012@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
In-Reply-To: <20260519052917.3729796-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9873:EE_
x-ms-office365-filtering-correlation-id: c2499a59-de54-4f87-5a5f-08deb623dd96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021|11063799006;
x-microsoft-antispam-message-info: GydoGdIIvZ8Wn/BdvEDdacVLoGW4Fc80+talGs1d3c7H5NC2JOMj3S6OTq3mKPj3YgxieiwyoGBjJUnbc0pjutPG5WZpoyf2/XF0omGSIbSnoGP+J8mBWa/Z5S8tv2i2AeYgFYAIsE3zxN6Pyvs2pPr2J1lPn+LGnSwsyzkJatPUKn0S5uAJHu1fcZTtd3O/1HwrjTdrBBOy76rIzwyjjkRIvcsXh//B+OxgjMdzeTsq+VzYEv2qfTImTNlrqBLKcWMM5PDLPDox0eJTVLVMF+dH77N97X18REjCgs5KHYx9f7ctsrMBS5wRb2Z7oodDotM2c0WVixyKyCB4leNh5Y6w37A3KeYfyBQdp3YuIixCZiGT10fWP446ix6Vx0PyKpZSGUEZuekEwZa1+xt1v/UuQDW04Tm2nnjddmU8sytIezHJWEj/qw42jZYqqTQyDzzJJJXUYTYGxHnNf2Z/EsK+EN4fz0GSRDZR8FitybEB/zmyvvd5aoBO8hmEqR+YD/ln4IH+usTDvqTurVogCfZu9UZFyNQsXwMIOwkHvrr0bIKg3jiWOC//gr3sr34uNgLzLSVELmBLYV1D8LhHIq9bVXxM4vefdrGqeJyiKP8e8/PKW6Vi3Ia80EwYUlla2RT6Vpxuc0AfuD5M5nJt5JcgyfPVIlkyi12znd8idA6uxfcyIuVS51CPihg4df3gNqes9xgenmQ8Xho/1GV27S6PB3Ke89pISzNQR8q8xWc6wUYA80EdYttxV3eY0x1Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8Wd3NbTjvUdh9ozt6t7xi6wqLMQ61MyJcU6erF1PqiWmpN1yLShuzKg86zm?=
 =?us-ascii?Q?v97v3uV2GAR/yIhi5IA/MQmYxJ3U7RFQMpKGRvRUCsmeBg9IVn1XT2Pdhk7v?=
 =?us-ascii?Q?9JbrgN71faZHmfZuIbP4wibCZpTZhR24Q0qGz1jzLrSGo5hV78FLtk5rsTC0?=
 =?us-ascii?Q?RDpNZDdHg3A5P4R9ue1YPtX9y6Q7UoFecf2rt/RKYXTgE88RsaStZli16AUv?=
 =?us-ascii?Q?FQTelxq5CZut1h64LsfJWzsTrXB4/k42m4HeS+qqBf9H4rRys5HKHgiUgpkI?=
 =?us-ascii?Q?NZCAGQDHbUe/98BkSTDCMyuIso2CjXvZnxhYCkoC0Z6+3KvHUZwjkUIl41lo?=
 =?us-ascii?Q?u42aPPpL9TEl/Wak7Yc42vFXeYSVaL6E4zef+c0Deb5Cnj9SkgtyjWp/DH86?=
 =?us-ascii?Q?KeF8mw7NMqChqxSvFDSPsbpKSNWM0cwcX7OpKW34+bb139jToYe2RPNXG+tL?=
 =?us-ascii?Q?MHEvF87RfYPt/3MmyQGKv+H7c+YvsA+XDvFkTyz6PBhGKYwU61WdPqrIJCdM?=
 =?us-ascii?Q?qBjuhQ7X+1yUMuF3k7Vo9O1bbZfST/swHcolatSQvh8mig2lYkZrLyNnN/5J?=
 =?us-ascii?Q?g+/aOF0KMbL0k3LUt2fKFVwkFufENdB4MnN9Z+pFyvzn1mnn9h7nlLNXm9NT?=
 =?us-ascii?Q?MvDiueLLK1gzV93+g9v586l+cwHI2jDjKJDCgQyINvsGjoM9lPqZhXE89bPV?=
 =?us-ascii?Q?zz1GHnU6aBezQI2taEUsdezH2GS8FuGNrMEztXuEsopPU0P4v8JWpelytDRp?=
 =?us-ascii?Q?NGv8WM5q4Esl40lVlBDdWyzKS/ZVOialqpN3p2/0WIIEnb1rtHBz+nBIJZ31?=
 =?us-ascii?Q?QIBKwkr6qIDlfL1iRqFi/O0knmWj4IugD568X7ceIiaQJwVRa4eNyxdKKgTy?=
 =?us-ascii?Q?pj7SH5vq6QhngrYJCmmkQDU4xJtnpoi53g3nre50JlUcWAV7Et8Sza+W46SN?=
 =?us-ascii?Q?FvgN19iouIpOi1f8BHvfzqHZsHhTd6ssd+QZk9tSw5oAZNHRzdbUjoV3Bo6s?=
 =?us-ascii?Q?iPv3UVa2tkbwkNhfLr0t07REvPv7vM+F3bEE97juM1ZYQjsEPzjpjp5WqPan?=
 =?us-ascii?Q?oyS4DH+8ygqZdZi6z2du8qMgi/pttU4LBXS2oYVzRYOJfVeduMKTvVQpuF8y?=
 =?us-ascii?Q?T3W6BGWJIUSGpf63BLn/h785bxC2o01u1gTh85Hpj8+Vu+GZ8AyKcO9Ej54j?=
 =?us-ascii?Q?hKs/ZlhfeGX68BeCKYIEKOD/zN0hwU86Uo3U5za+sVpdAbDAwBrohv+0BnTb?=
 =?us-ascii?Q?PwZHQ401e6/aTnyhrrVC4fdyJ2S5Vln+/xZAqRYTOQGtNIytGAhFVlMsYuyJ?=
 =?us-ascii?Q?i6jQAIElIgpBVy8dZSW3Sly9hI8NJUl0i7pFXuzZFB2sEEzkpkrQ97Qk+/oi?=
 =?us-ascii?Q?iBrkjv3B6LCFcTPcq108fMpqjmHgDicC/6HTFItIlTYxJ3f//hG5TPHuStax?=
 =?us-ascii?Q?hk1jUMZPeDJipUisi4jF0iPQagJ0KI1xUBc5n/25qRLHiBA/WuHJCZOKgoSD?=
 =?us-ascii?Q?a7JKMHV1Gy++4j5TWDP9nItxYIljZhOSzDPNvQwzSxCLKene1KMI2yXt6zAY?=
 =?us-ascii?Q?UpulE7ETqywfhSqeYsMuqWZdHjx/X34SAPfiUfOHU7rZkTU/nfjzvom/VJx8?=
 =?us-ascii?Q?eA5jPGzS7DeoNUtV1hLw0tDK0Y0YH5Sv1AFJNAoj1pnphkHVRJyiSfaxO+8i?=
 =?us-ascii?Q?Hh6/RxLvvbsj0AsptxAhvxru9hdCsVy2MvbYvJLJLrJ9u4OX+6ZYCSI3It+o?=
 =?us-ascii?Q?eKsoB01EYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mxgat9WUl5F2FIZ2aHlR5ABGBa6yS27iuyP6p6kZHpiqYMWvrFtKoyMlQW0YBe3HIAWfIqXIaEte9cHhr/MGkXPzG70f+Yjl/qXrUodMtNODbNqX0hgnVL9C8WZ+UODwOMTDMYbgMKbzfTbGSoAhcc2sLs9Xl35fgGkGtfdbBL8V0VHbNdu3IWw9LGLqsW6GDCtnJfCo0c0toVZA2jHu62RNBUB8C5gOykyiSSflMCFyG/ZUXk+SRZl25KNgDuIfKtRwkXXNoVxZ41Jb38l67ywoIRnJUjcE3J440BnQ8Vd0Hjq7JIwJueEgb3ibWE5/EECyNZO3JR+0vxjXS2TgUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2499a59-de54-4f87-5a5f-08deb623dd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 03:57:09.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXze5Sl12vlh7AJOs+/MBuRrN2b+TYpmv8qZGKXlU+nMbX2/zK/LNKIUxoPVOoExpB/uvaZZi81xmyH+8HCMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9873
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249742-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BN9PR11MB5276.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 53A3D58769F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, May 19, 2026 1:29 PM
>=20
> The Intel IOMMU driver allows SVA on devices even if they do not support
> PCI/PRI. Commit 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA
> when
> PRI is supported") modified the SVA bind path to allow this configuration
> by skipping IOPF enablement when PRI is missing. However, it failed to
> update the unbind path.
>=20
> This creates an imbalance: the unbind path attempts to disable IOPF for
> a device that never had it enabled, triggering a WARNING in
> intel_iommu_disable_iopf():
>=20
>  WARNING: drivers/iommu/intel/iommu.c:3475 at
> intel_iommu_disable_iopf+0x4f/0x90d
>  Call Trace:
>   <TASK>
>   blocking_domain_set_dev_pasid+0x50/0x70
>   iommu_detach_device_pasid+0x89/0xc0
>   iommu_sva_unbind_device+0x73/0x150
>   xe_vm_close_and_put+0x4d2/0x1200 [xe]
>=20
> Fix this by bypassing IOPF operations for SVA domains on non-PRI hardware
> in both the bind and unbind paths.
>=20
> Fixes: 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when PRI is
> supported")
> Cc: stable@vger.kernel.org
> Reported-by: Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

