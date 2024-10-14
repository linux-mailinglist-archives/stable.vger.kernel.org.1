Return-Path: <stable+bounces-85074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A6699D9C2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 00:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76752822BE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 22:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AEF1591EA;
	Mon, 14 Oct 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJZpSjll"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EC15687C;
	Mon, 14 Oct 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944673; cv=fail; b=thUVp39tVgYbd8evsE3oYAUhr86SdXplEODcP0//W2R3Y8aDtHZA7KRieOFaoWmhP+hyhLUXPTPIOY1/AFPl9EdqgLkBKYW8qBH3FmXKHHmtwfXgEtpt2VKt/s0T4FkCjnfHsVT9Ftq0nv4iRgzPRV9h0IF/rg7rlG6+pvThc5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944673; c=relaxed/simple;
	bh=WdI6P2ZV1U9SJijicLbMPKJ7EK/WUBMtazkIe7s9Ueg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bxd02Mc/2u7uS4jPRvgk95Q29my0genmpqUU36pIw196rxO50ry2dxpoJBUNdNDt0dECxSPwDa4WXjD0+CsoX1tiyYnchDlg5GoILiCw1GSsx7yyX73kBou8nAa8N8LA4/MusUVXRp5UynJ97vLp2NhwYLyOTmalTtlfJRuBbIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJZpSjll; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728944672; x=1760480672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WdI6P2ZV1U9SJijicLbMPKJ7EK/WUBMtazkIe7s9Ueg=;
  b=TJZpSjllfH9EfALFB2zBfLfhnHwLhTny+ZdbYf1EBvZSW4WxWJ6sN2C2
   xxhol0OBBwMYhcnNN9wzJ9EdmXF8CapYqVeedys3sX8HubFAKt0xesSL5
   POA+PC0zNW1sTixR+4Zva+QbucKI2YI5fvjkT2BTQDMUlaT0YlTuyGLqf
   +dOOvTJBFh8QCOHQSIOZui0CYGZk0MeA6vsvGJpxRr9tyHmRw8gVGZcwG
   wtRMtFHDHwoAK+8KGxJHxKhWScBoKBRBV/GGo4izz87Hb8oDik2J6UEh1
   QBYOueT7In5ckQkg8U898Jn7NH/8FvmjLU/ptTZ+4p63tZ3PDy0lZyUuC
   A==;
X-CSE-ConnectionGUID: ZJeZ6WZATGeT9kSmEWzuvQ==
X-CSE-MsgGUID: W8dqG1JGTsqJEj6lU7fBXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28402797"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28402797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 15:24:31 -0700
X-CSE-ConnectionGUID: DLTHg39dSTiJaIpZC0KOxw==
X-CSE-MsgGUID: ogsh4rOORDWeFB1Bjvh/Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77573467"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 15:24:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 15:24:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 15:24:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 15:24:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 15:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUIJAiybBsF0b0YcQwQfAyiTdv8ZDEAQL/v+3dFdMuQqJjqGuQUfZEVB8inqUD0wvm4/okvO1KxNdjvcyTE8BXI5IHsb4x0amBkIEpthqcYuUyqSIpCg+EaFjIULy9hS48aqmIrMXg47TlfxKrmM530qeDS6iqJXIAv6XFQ8yKz/63yaUuauXOAYr7E7BpRG1RUoVf7axFxPGVpEVFhSZoCoBzVjbcFDugurQm6k9p8drUKkHK6iiPSw8F5ES0k7J0ddAbxBqeXAdL9f5aInnMXTkcg1mt9du4AK4nHpwQB0qPyWIuxRxstHBzeukOCLTLQK0IMF6I5yaEYDChAC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbaKhiRIfU0pNpyrbcR9cS6m7dfZqpqpWV161pTSv+g=;
 b=eeQZ3rZEWlgL9VLjWtbFj6y8nTqw70Vipr0ms3cNZ00vmQ4XTunvHGsdpVyxD7nZo6Jh19kIBlkx/OvZacKEjARMEnBxLb+Tq3DdnQ1XGHf/qtCKnzWygPTaxB5k3VsAgSowaP8tK4WmkDjeqwzmCpxWklLF8zRGtFm0JBGMPSY71mIE/dpzYKvksewasxVykEZLcOStwJxB2Mw9bFQaOOYm2grNoeG1tcOw8EqO3mx8vo89ca/OZb1m3ClBFbgYRqU0lj7YJkn64SiG0uDlvEfxI7wGGx8b+6QENdY1qDzO3CZkzXVpxYhYlp75W8BOG7uQoWyH3bK3F/c8XvZmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV1PR11MB8789.namprd11.prod.outlook.com (2603:10b6:408:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 22:24:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 22:24:22 +0000
Date: Mon, 14 Oct 2024 15:24:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <stable@vger.kernel.org>, Zijun Hu
	<zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>, Gregory Price
	<gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Message-ID: <670d9a13b4869_3ee2294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
 <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
 <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
X-ClientProxiedBy: MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV1PR11MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 2022fb82-176e-42e7-fc01-08dcec9ef40f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WVFsZvvoAiVWU853BICROGjLmKiptEPGgZCf8H8J1yumSw+X6TlXMcJOWMfc?=
 =?us-ascii?Q?r7xw4XYTqn6Apl8JIVlUtLDuBsph3eLf8XBfnHQDygYUkzF4NeTPiRIqraG2?=
 =?us-ascii?Q?4vtvlrHNamctjh2z5nmNLfIGPrlbuY7B0bGCEwWwdEbggRj7cKRVKWL7RQeC?=
 =?us-ascii?Q?de89DNePG7HLv0hE5Snvc5uPHWJLH8XT4ndMVVSFgwWGH1TDqKjJJM30iGCx?=
 =?us-ascii?Q?3ddeOApqaUG3p0XrUkWPHm+8IR9yoOUS4UmR6auUp2AjOEmkiSrVUz1W3ZQ9?=
 =?us-ascii?Q?dC4UG6EUJBrqAujgPc1wCmoGNbK1C7stUWrW3a6Bnr26OZ+wqFtNCyGv4W0y?=
 =?us-ascii?Q?7u38x+ypM8bRBbV87w2++oJRGN35ocHlPBLoV2tgekR9wORPnOJIK3RO6QI0?=
 =?us-ascii?Q?Uuj74ENogi5mcew4pvEtx6jdGqy7beHzP8Id0AP4V9z83IW7z8yTPwlQUD1R?=
 =?us-ascii?Q?3SNODA2D7km/FI3SynWm5wRjUVIjX15wAYjhDMP3meHAY2Icj4echnAyG1tm?=
 =?us-ascii?Q?2W5i4wfLnkuBTzUqOSkxpapkbn4NTz3XHMo9GMr3DnvDUP33sHnBRwTw/cPF?=
 =?us-ascii?Q?//oL4wFXnDtCMbp/JKpAxCXkwICyQaJpYCoEHrDXePaVj6ILZmZ5WQNx5I3J?=
 =?us-ascii?Q?Oc2olPqWn8mDsvxOmOpReULEg5+rvRgPp0v+PAgzLlxrjXvnwSmRiQ5VkKsm?=
 =?us-ascii?Q?1hntVrF60jifyGKCq5FCjI4JNcqUG+cdEFPDUUxVBat2XUAHyXDu0eW7EtV2?=
 =?us-ascii?Q?O9fjRDuw30SUlaNI6IJ66soo36A2M6TdhnQWBVB/ZUeNj0COsesjRX/6XjRI?=
 =?us-ascii?Q?xnAcyoaOqVhi3dPzDLkS0s+Z1cv2d11Oj9CIv16pfRS/GaoA0dstwgsR4XPM?=
 =?us-ascii?Q?SI+ThpzEaut6gMKkK3QCjjH+7qlbhfeYvFXmwCD0ZQy6v5m95JYrp/HhNeoV?=
 =?us-ascii?Q?vuWFXHXsNf5SMj7679aUDKyBANZuSoJlhTwWVF/vqIM0YiDjwJlwjh8MhUQe?=
 =?us-ascii?Q?ANc8JvDl9UUAfvMUI1oPTG0qHxmnE1GNxQUNKl4ceIVuPHXLVZNB+BGN/Wnj?=
 =?us-ascii?Q?3pQoFp7/li32Aap3zEgw1ToKlChwpTHJOw3auZTxQ6T1FzFPMpG+JhgAor7P?=
 =?us-ascii?Q?a37LMeoX95jFsB16gS9avC6I2py8qsld/dV5Dy6EQW+byLrHUC2Q4kl3oRFU?=
 =?us-ascii?Q?hCwG86o73f8IG0YSj07wW5LrVsLpU8mk3OxcSeB+0npf1xXAmewbs/noAQFv?=
 =?us-ascii?Q?VWKHbHhIrSAuGORGt+EN8WwaZlqjRjtJ5dkAxi2sNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKvmQpSZ99xHrPDgnCU+Dr9TW2pQ5qxNv49OvedA7YdVTJjwLEAWuVz/zPMT?=
 =?us-ascii?Q?pjdzphe68lbN2dX4jHDOk5Dy/KC6o0Dw7O9bz9Hc9Il25qUGautFA20i+aPz?=
 =?us-ascii?Q?SKM2KFGZ7xBoF44KTgpdpT0C95kwGbEpwVJaW/5CHxWY4tb73HKQvrzWGs/X?=
 =?us-ascii?Q?x6UVySVjszWXgemXHt2I6JZ4WEn0vVqNYRF9Qz5E8mRQbJzQRZaLB21fLSlm?=
 =?us-ascii?Q?R0k0Rg2wR7+urPOs5GGQi0rGLEiR3r+EL25muYR8hVUyLPAcan1dIaXOXpDG?=
 =?us-ascii?Q?WZXltPXt9MVLqIzg9VLyUEEz/bpRHni7spVQfsLKOCzyvlnPAaBxjQIyeHYC?=
 =?us-ascii?Q?E9Pu0ogS/Y52ZQGmWgEee6C4WKQDe6p0atTLEZiYXFmfniRWjdYclBNu7dz0?=
 =?us-ascii?Q?SWFLjakKh6VS1Xq9AWfz2NWJa7LGUIGU9CrNDLWOLoBBWqH6PueeDPrf9byc?=
 =?us-ascii?Q?tThm9cEiSSa8X7ijz9tNMLQQtpjxbss/AT+kEeGfmTnhZmTvs/Ooj9j7uc2e?=
 =?us-ascii?Q?Sbd+gNBJlTfPoSuNTr0R8o+0lMh89Vaz0eXJpiF3QRb5YOqoWFMRNmNp2Ggs?=
 =?us-ascii?Q?boCOlwRhjmqWISv7QXZh4NQ8m+678yZFZa8IoQy/qLmjlqxk0M5ewXaec1D+?=
 =?us-ascii?Q?2RsdYqCMeulR/GkoZqcsNiMR7ldlRHcr8z+tSc4JpQdOJgG9hUzjK0X7IkOm?=
 =?us-ascii?Q?QMQ33BpPK/OpYqvUi/6Jra5sblfRCKBJU+qkzYcTJvdaykxzip4b6+l48Smz?=
 =?us-ascii?Q?Ks/ULWEYHHDgjfU0pjWAwTvq+zYswrwoyGLYqXJ3AK733/I1uEQuIWsRtlOW?=
 =?us-ascii?Q?LTe5kUVLyuQdk+zspdmp8wNaLwOp2gAq4ABHnvj0uTS/WsAxDCE/HP7OVimI?=
 =?us-ascii?Q?tcDzcBmBBipdPI9xfssC39SqVI3JhuWEeVz1lHhSPINP59T96Xr3RvbP5slZ?=
 =?us-ascii?Q?p2Ox7DNvRZg5Ng3bdm1TqRf8OWPH2zamED8OgroDpjA9n8u/xw1FbYV94WWW?=
 =?us-ascii?Q?a3IqZxNRbb2Q1iM57pZTaijDaMgWN6L2m5r82QyB7VSOQbAM5GRh7bEQpm1f?=
 =?us-ascii?Q?wv8+HsdYOHeL3fpBpBRQt5wpw2EyEFAYPDy9fMJY72c16Chj7JJn8t0P4xjM?=
 =?us-ascii?Q?9RDu2rZl/8kgPHeTFGOxhpWbA7ZLEMEHAQAZcnYr4T9DgDRbbZiTruYjBZzf?=
 =?us-ascii?Q?vtBlgBRXyWOsVHdKbt58GKBdZ0iW1ZkvWK/E3pQrof2uQO4Bxlqnb5fuoGzg?=
 =?us-ascii?Q?K4gutjFnqbgbiDLct5o8ZnwiZ8rku1mvSIJ+LebzJapSWqiJ+LCSaF29tKrs?=
 =?us-ascii?Q?7153u8q408kkxDoIxPFXTUkZ6SyPa9phhbvbewj3R8JrPivitOdCup0UusgK?=
 =?us-ascii?Q?mHDrik54Bp3UhjrL0GHwENA2oz+kfETMIPyHGFrTESK5i3GAsoYI3M1zmVeq?=
 =?us-ascii?Q?116gNPyK5oyrsS2l5/2OZrQW5bGgtfX8VYBq8wKe2V3/tEm+/DnPVQQITEg5?=
 =?us-ascii?Q?TfM3UOidxWvwy1jCatgDxl8XXE4HsJRfy95tEu0cI/DxXvGY1gCrYGBgTgH5?=
 =?us-ascii?Q?wr3LqiS5hmsvlExNwW2aZyszp/D6bcbG+uOD0Jef9xNqq9P4P0KrKg1iu2p6?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2022fb82-176e-42e7-fc01-08dcec9ef40f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 22:24:22.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0kjGhX9jMkxpxybU6ArGYxBPhvMai05mhKw9rDVnBKpqlv9DipQNhLxaQbXce6htOariALqS0/d8hkk0V4JkeBTsx5qorWs7DLQcVb1a94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8789
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 10/12/24 22:57, Dan Williams wrote:
> > Alejandro Lucero Palau wrote:
> > [..]
> >>> I am skeptical that PROBE_FORCE_SYNCRONOUS is a fix for any
> >>> device-readiness bug. Some other assumption is violated if that is
> >>> required.
> >>
> >> But that problem is not about device readiness but just how the device
> >> model works. In this case the memdev creation is adding devices, no real
> >> ones but those abstractions we use from the device model, and that
> >> device creation is done asynchronously.
> > Device creation is not done asynchronously, the PCI driver is attaching
> > asynchrounously. When the PCI driver attaches it creates memdevs and
> > those are attached to cxl_mem synchronously.
> >
> >> memdev, a Type2 driver in my case, is going to work with such a device
> >> abstraction just after the memdev creation, it is not there yet.
> > Oh, is the concern that you always want to have the memdev attached to
> > cxl_mem immediately after it is registered?
> >
> > I think that is another case where "MODULE_SOFTDEP("pre: cxl_mem")" is
> > needed. However, to fix this situation once and for all I think I would
> > rather just drop all this modularity and move both cxl_port and cxl_mem
> > to be drivers internal to cxl_core.ko similar to the cxl_region driver.
> 
> 
> Oh, so the problem is the code is not ready because the functionality is 
> in a module not loaded yet.

Right.

> Then it makes sense that change. I'll do it if not already taken. I'll 
> send v4 without the PROBE_FORCE_SYNCHRONOUS flag and without the 
> previous loop with delays implemented in v3.

So I think EPROBE_DEFER can stay out of the CXL core because it is up to
the accelerator driver to decide whether CXL availability is fatal to
init or not.

Additionally, I am less and less convinced that Type-2 drivers should be
forced to depend on the cxl_mem driver to attach vs just arranging for
those Type-2 drivers to call devm_cxl_enumerate_ports() and
devm_cxl_add_endpoint() directly. In other words I am starting to worry
that the generic cxl_mem driver design pattern is a midlayer mistake.

So, if it makes it easier for sfc, I would be open to exploring a direct
scheme for endpoint attachment, and not requiring the generic cxl_mem
driver as an intermediary.

