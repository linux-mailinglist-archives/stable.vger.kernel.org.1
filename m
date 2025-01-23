Return-Path: <stable+bounces-110288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F2A1A64D
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1AB188921F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1020FABF;
	Thu, 23 Jan 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYNDE9Fq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A138B
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644046; cv=fail; b=l8pqfSWqkQgWSHL4fxQlhv1w023JGQAxXReKzFK91swZ4FAhy5OMgTt2Ofw2W6RIH2sQA6SgtBhgYJ/W8Zv8CJ1jQlpvAID80RgGkEquw5lhZaEMa9yyuWLb/PLYAh5zIwbnAX0LzJPa0f46eIZKVgz5jKJyjxbf33T0I3U8X5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644046; c=relaxed/simple;
	bh=uWZjS9vIYMP8809Dh6qxRFa7Su/u8alN2D3/i6Ab0Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DOEMI8EWVNPpZkeGUzA/BBui3YvCvfunSi0p/i87AtxoJNJlALZRB28QjOPxLtu/wQS7qWK2c2D5j4fbYqRq5tRn6IjIlzKvuFSXxZnN5vQSOQcBP/BWiL5g075D71tXUiHR5PSxCp2tbC/ZNtNiBb0YzZvKAHGJItUI072jiNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYNDE9Fq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737644044; x=1769180044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uWZjS9vIYMP8809Dh6qxRFa7Su/u8alN2D3/i6Ab0Bk=;
  b=DYNDE9FqFKw4dsKZo6uX71+9bxif+z8s534Y9I9J5mz/hK546ZFN0C7y
   3radclW0l1WJmEI4HpR90yQovC3AhXpKrx6ml5x6vr9A2mkNvnjf9fw/W
   Arn6T1mfQJjmMxKTLw6vPDwE2HXx7eQ4x5WH7PB3lnEEdm04aFTwNAKhd
   R1dBg4+ehmadsniZgg36bKbIDGsxAHjQuuNDRigwjSw7sxhf5qQVyEM8Q
   lgQpmop/bY8az7TuquCZm0syfd8l5cWDGsOC+JaACghIqNQxlifvYGsfV
   soKSxAFQ5b/gu3saJz7IOj0LDSnvat0Dqy0rzpv2qSXWXQUwEaN1T2wgL
   Q==;
X-CSE-ConnectionGUID: fSBjVxbRRyGbcC2VnouKSA==
X-CSE-MsgGUID: a0eWXsrxTdmSxbT0hHYgAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="40973196"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="40973196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:52:24 -0800
X-CSE-ConnectionGUID: 7afbmDY0TQWdKcHgKZuV0w==
X-CSE-MsgGUID: Ae7vLvP6QoKgCm1dY3d5bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107479667"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 06:52:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 06:52:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 06:52:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 06:52:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhQPVhX2m8pzv4ZM77+pkCIx+6a00SdkmyTwyO3nbCNir1EWGNqHLqlpNwoCMmFpd1sWneR6IFKHUwn/dRyvGJFW2zvJfcsHahAgHemzCsuNKXIAAG01nhvGD+ZIdJGTQ3L8pF2sNCnx9BIS3ebZ2N0+ChYHDSXgv4Gz5NcGncZHKfA/OLsh/NShK0xbyEXudnS6yZJ+fnmilqyJX1QR6TTmJQZkPxxJmeAPnQzezoTJR5iPLxQivAr3jnbFtWUw/v//KFV8PN9CV3wigwWvFaVs+5jyiL5dogYB/+O+G6dWfdLuRmPWIPAno4vJ+3HRbUDLgH9jST6TaHpv7HhXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWZjS9vIYMP8809Dh6qxRFa7Su/u8alN2D3/i6Ab0Bk=;
 b=WWmuii6YuVi/Lqe1/bw3DP4Y1Q8CYb9JFNBPhWkmPMTm8MjygN7yiM0aPfP/Q94xSuEY6dFB198/MEReS0yU0TG/RbyxO+CFsl9LjhIwNP/sHrY8WGoeBKAm3bTF9NAaZvK4GwIBl3lHYfz53JpgWg0F+bBw1erORhpKV0nsyWsWdYYCquJHclhiVGcjVbRay8MP6riyzxzK15ylc4OO78DurOPy8W7c3eWq9wyK3uJFeOffGTMh8J3YwbmA/vj5fmEit9io/SYqIdwjXi6gt1ynWlTveCd69jYz2D3PCH0TZW6ma67MOvNk+2xjyWA1l9G0S591z03MQcAjP6HxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 14:52:13 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:52:13 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Harrison, John C" <john.c.harrison@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Filipchuk, Julia" <julia.filipchuk@intel.com>
Subject: Re: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Thread-Topic: [PATCH 1/2] drm/xe/devcoredump: Move exec queue snapshot to
 Contexts section
Thread-Index: AQHbbVVMFHgSix08VkSGVxA9T7ZR57MkZ3cAgAAEpgCAAAX6AA==
Date: Thu, 23 Jan 2025 14:52:13 +0000
Message-ID: <82a330f4d0c43036e088939cd6ba59790173447f.camel@intel.com>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
	 <20250123051112.1938193-2-lucas.demarchi@intel.com>
	 <f16aac40a9ea1ab40d1083228cd0b460e1d217e3.camel@intel.com>
	 <kw4rrdedc3ye5elnis6bjz2xg34ttrul2d6qye5lm3ixeee36l@ncfk65fdvb4s>
In-Reply-To: <kw4rrdedc3ye5elnis6bjz2xg34ttrul2d6qye5lm3ixeee36l@ncfk65fdvb4s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SA1PR11MB8521:EE_
x-ms-office365-filtering-correlation-id: fbdd4299-39e4-4072-26a0-08dd3bbd8596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzB5WFNudXovUjZsMDM0ZzNtaW95eTVYM0FjWnpRK00rcFRpc3g3d0pHMG0v?=
 =?utf-8?B?eis2MGliSXB0NndTa0NMY3E4cGR1L0MwQUkwbC96bnlYaVEyV1g4SHdVb1hk?=
 =?utf-8?B?dUxYdjBRYXpNMytzWktncDdKNzJWd3prZnVlZDFkUk9xSS9PZ3Uycyt0WnZE?=
 =?utf-8?B?bmI4T2Z2WWFHKyt0Zk1aOGxhNXdySENXa0RhUlQ0QUlPb3RGY0hwelRGYlNl?=
 =?utf-8?B?QkVPYTdxY2piQ2ZaZGxmTkVidldvWWtLWjhSMGFLa3BTd3dQWXd5U1J3Tzhy?=
 =?utf-8?B?WHF1WlgybFUwNHFJN3ZkRFFIYUFkUzNvQ250dEhldldzWFl0UCtXdU5WY21v?=
 =?utf-8?B?b2RKemY3TTZxRmQyUW05Ni9CbHRoRFd0ekhZZ0VNc3F4WUgvUTNteFV4UHFT?=
 =?utf-8?B?TDBVaDg0eVhYMllIRGx2dFJ6dWJoTTA1UjdPNWZJOTZYcUFGTWwxL0NuczNX?=
 =?utf-8?B?NXpBT0YwMS8rdi9IYnM1cDNsTWVBNitIaE9rYjcwWVY2aDRlM2xWY1c2aXJP?=
 =?utf-8?B?ZllZYUFtenVYWmRyYmlieGtkMm5TbUswSTNNeXZkSDlDTVkvcVdrbzhJemNT?=
 =?utf-8?B?V2NSY3RldzJUQ2I5SjFLeXFOZnlaNTh6QVoxV01KRVB1UlZwUE8xUm56b0Z6?=
 =?utf-8?B?Sk9kS1RPU21LWDFpK0gxNGVVWkkvTStlMnd1NEdoQktGSmNMT3Y5Y051WnRU?=
 =?utf-8?B?dkdVREE3R3pWWDZTUFl3UjA1cUs2bldGajlKL0QxRzZWNnZQMXc1QVBFdW9V?=
 =?utf-8?B?RVhheVZRRXdocS9hNVN1aTViM0tlcTUxa0F6NUxvOWx2VTFCN1hHQUl1aGxw?=
 =?utf-8?B?cVNUTDhpYnFjUWhYRk8vdU1DR2V6NW1UZFRwZTVnQUppaHdOQTFJOXJvQ241?=
 =?utf-8?B?cDJqNWxJVk5YaGpMYkxNZFp1WkFBQmdxWUhXWmx3OWdqVyt5akNSck9rcnQv?=
 =?utf-8?B?UHZHNEUwekI1eGowVmpOZEtHY2hqS2RhM3Yvb2tMeFRBM0pSK0p0UEtMMVF4?=
 =?utf-8?B?YlN5M0ZyNEYzcnBYc0VTUm55NXpMZVZWaXBTeVlDdWxDSUtqaTJjVG10R0ZL?=
 =?utf-8?B?VkR5SlFROVcrWFhZeGwySDZ3ZCtla1g0bzA1S2hDdjlQdnBlZ2NxUnJwOFVB?=
 =?utf-8?B?SUdiUUlqNEpTYTRnWGlpdHEyOTNRVkdGTVY1Y2p4VjFvbDdDRXN3Ty9lZlJD?=
 =?utf-8?B?bnhmQ2k3SGtsMWFGNlpBRmJuQllWbmlnKzNGNmVhRVg2ckJpa054K2pWT3pJ?=
 =?utf-8?B?RGhhemgyd1RJQ254UklKUnRtcG5FR2hBN0o5S3o3RlNSelkvcmdadlM0MzNY?=
 =?utf-8?B?Qlk0bk1iS2tTZkc0ZW5wYlpadkF2TklGNmpFaDVrWm45MFlLU1kzc25kQnc2?=
 =?utf-8?B?MDBjWDkxTkRyM2lSYUJTYVZVODlIaUhlNzNaZkN5blliSk5sdzRSTExGV1JL?=
 =?utf-8?B?a1FvZm0wdGptcU1iNi80bTNERnZKVDd3SWZpRnhjSHo1YjRvQXVxN2lmZnZK?=
 =?utf-8?B?aEY3OW8xOTZXQkFzUmdRbWo1TUhmVlEyWDFXVThlemlzNVNtRFZiU0paVkZk?=
 =?utf-8?B?LzNKbmlOOVJkY3hCYTgrUW54eEdYc2dXeU8rQVllNzluUFE0Y1VuRWx4aXdz?=
 =?utf-8?B?ZWM1Zk5KbVNmUlM3SnJDRFBQTXB0VkFKVCtmTFliNzRlamJlK1BPREE3T1Ji?=
 =?utf-8?B?ZFJZQVlSTnVDWUluWU1pcnlScDBkNU9NdUFCWElCN1FNeFlWT3ZyT2FJZVFh?=
 =?utf-8?B?NEtEU1dRTEc5am1va0E1WWNUL3RDaEhidTloTVhWbVN3M0d0cFh6bWgwWnFK?=
 =?utf-8?B?NEZaR0JZYTcvbGtGOVYvaWtXR1lEdWNBL3hsUXVvbDZaNENDanpLMzNwNEtU?=
 =?utf-8?Q?0qmOq7f2M8FQq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEpreDBReW5YSTVMcU51c1dkREFVWXpkZHhzYTNWYU5vUFhMSTQraXJjNDhi?=
 =?utf-8?B?dHdLOEZPN3RmUEtxdmhsSytIVjl2aUZjVGRMZzV0aWVQUHBhMEhhV1RTZG5O?=
 =?utf-8?B?ZkdEeURROVZXSThBTnlsVlNDT1hDbVpncS9NcnJqUFNGK3IzLzJ4QlVqVVc0?=
 =?utf-8?B?Vjd6d0k3aDJUZDJ6OTdJOEtFSnI1djR3dzJrYTJhMnZlQ1hDZXlaT3dQdHN1?=
 =?utf-8?B?cUJlQ2NocTRVeXY2YjAxdVdBcWcwcytoaGpHazRvZXhmNitmVzZkVlV1TjBx?=
 =?utf-8?B?dWFJWGU1OGQ4YXlnK0hpa2dWSWY2b01WNjBGeG1jY2xiTjRFTUhOS0VtdjJh?=
 =?utf-8?B?MDl3c2FoTUtHQk0rMktPTG10U0F6ZXRnVEhFcUlwUVEwVWxzbFpEL1c4ejh6?=
 =?utf-8?B?ZlBFNXRjZFEvZDlaRkJ2N0EyaVdoaEdjN3czckN1TklVZEx4Qll3UXdYajRN?=
 =?utf-8?B?TE9XN3djdmQ0bU9rRE8wUXoyckIrR2QvSXg4cDlibWtwalpCTjNIRENTbm5i?=
 =?utf-8?B?Q2Zva1BUaUFLam0zSjRPaVhMa1h5Y2tTOEgxV0VKN2pzdVVES2E3VGVsb0Ns?=
 =?utf-8?B?d3Q0dlNBdzF5S2NzN1U4czJVZ1BCTmNxWjhXcEZoU3FnOG0zWGNEYzBSUWNs?=
 =?utf-8?B?QkZNWmpsV2NXMm1iMVZISHNOcVNZYzFlSEs0aW9tbzFmNXIxVXp6OXVzdGZ2?=
 =?utf-8?B?d25NUWdXdm82K0NiS3Z6MEVwTG9HSlRiK0Y4bTJOOEg5UUx3RFh4blBVL1Va?=
 =?utf-8?B?UitZN05vem9Jb1VWTXU0UTM2TzJscDF4UDRnekdsMUh6L2tiaUxtSDM4dFJm?=
 =?utf-8?B?TGtKSkxWbnJ4R1UzcXYzbE5rd0xhTkpoK0Ztb0JKM3FmMFhPZXQwOVdHcHdD?=
 =?utf-8?B?aGU3YXlYS2JxNlg2bmdzeEt2dWVabnk1ODNITno0UjBpY1ViMkp6eVIxRjF0?=
 =?utf-8?B?RStCTHErdXFXeVl0cXZqUVlHL3QrUmhENmRuK01zSEF3czRMd25xelpmV3Bm?=
 =?utf-8?B?ODhFeTV5WlVmeWlMUlRlOEk4WlNIb3BQYkZleWIrTWZ3bG5GWWpQWWY2MWRl?=
 =?utf-8?B?UHA3RVQrdjZrclA4ZjJFYjlvK1hVMGZNbHdFRkwwcTErckYzbkVpNmN3clcw?=
 =?utf-8?B?bGNqd0JoQkh1aUN6VlBYTVpZdDVsZHk3UW95bkgwbTl1KzROYkdYRVl5TmRG?=
 =?utf-8?B?UlJOb2FjdHl6a2pzUDFkTUJJYjIzNUxyZ3FaMmJLSE9UZ2lJQmRKTDB1MHgy?=
 =?utf-8?B?WFUyU0JYRGtCaUVFTDFuaHVjc2tSUTZpUjYycHpHbjdiWGJ1a1paUWRMWkFu?=
 =?utf-8?B?NHhuMC9tYTNtSG5WalloWWRNMDVxems5Q1JwNW16bFB6ZHNDdWhXUU8wcmND?=
 =?utf-8?B?Y1N4WGpscnU4YTI4d29nZ2o0dmR6MTROcndYSjBwWVhuSFp3NHpYQnJtYW4x?=
 =?utf-8?B?cmQ1VzBEQmlIbUlLVERUQ01XYWNNbjllVUNyZUk3TFR0dDkySnlsdlBkZHo4?=
 =?utf-8?B?ZHlhUjJzNytRRFZ4dTZNYlhjMG9wdDI2ektSbmR0TFdCQTFtb2U5MndUd3M5?=
 =?utf-8?B?Z2k3ZHpjUFVXSXJCajRxUVZwS01KUlM3UWIrSWpRLzVrSjJkVXAzeTNrRTBa?=
 =?utf-8?B?dzRZMmdmZzZCUjExc3JYY3dZOFlhZCtGVnNlSkVrRTNiVVdTaGw3clJVQmdi?=
 =?utf-8?B?SmJTbjFlcmFuME8vV0V3Q0xENy9VZHdrZkVZbnRSWUwyNThPKzJZeWZLajdG?=
 =?utf-8?B?ZC9aOXhYaGdQZHpxRFU5eTFFOXU1ditXb2dYTVl3VVJrVTd1T25pWDdMWE1v?=
 =?utf-8?B?TXlKY2RzMmk2RDBpZFFrdThlNTB3cFZWV1pUNHVsckdKK0VSZDJYSFFUSXF3?=
 =?utf-8?B?eUo3L3lLdTIvZGIrN081VmQzems3RDNhZkxTNVpzR1N1ZnNkRkRPb1M4K0gy?=
 =?utf-8?B?UnVxb0tWYWtjV3RnbnNHLzFaSWs2cFVnOFdZbk5wcnpqd2FsR3hvQXhxK0pT?=
 =?utf-8?B?S3Vvem1maERSTTd4ek5BcUZlM3AvYW9qcFZPeHBKeWxJVGdBd05XWjBOalZQ?=
 =?utf-8?B?YzZ0dzdpQ1h6WitndXJjamZUN3pPaGp2eEJJUmpnUUNONnJ0RG5kSlJ3ejNU?=
 =?utf-8?B?UlpFOUsxaXBHc0hvNlVoaDk0WXFnT1YvdGhQTDRQMXdacmhPRlRhUXZTQW4x?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E5DB98A7F6C8C4FAC4E839DA585FBD0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdd4299-39e4-4072-26a0-08dd3bbd8596
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 14:52:13.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0DvlHe0M5vhIVfIX3ZPlLaW1FBpQkV33QiEz1HDPVVqImpcSSogg/0d6kh/WOv4wqvKsSOZTMmxEurds4JVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAxLTIzIGF0IDA4OjMwIC0wNjAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDIzLCAyMDI1IGF0IDA4OjE0OjExQU0gLTA2MDAsIEpvc2UgU291emEg
d3JvdGU6DQo+ID4gT24gV2VkLCAyMDI1LTAxLTIyIGF0IDIxOjExIC0wODAwLCBMdWNhcyBEZSBN
YXJjaGkgd3JvdGU6DQo+ID4gPiBIYXZpbmcgdGhlIGV4ZWMgcXVldWUgc25hcHNob3QgaW5zaWRl
IGEgIkd1QyBDVCIgc2VjdGlvbiB3YXMgYWx3YXlzDQo+ID4gPiB3cm9uZy4gIENvbW1pdCBjMjhm
ZDZjMzU4ZGIgKCJkcm0veGUvZGV2Y29yZWR1bXA6IEltcHJvdmUgc2VjdGlvbg0KPiA+ID4gaGVh
ZGluZ3MgYW5kIGFkZCB0aWxlIGluZm8iKSB0cmllZCB0byBmaXggdGhhdCBidWcsIGJ1dCB3aXRo
IHRoYXQgYWxzbw0KPiA+ID4gYnJva2UgdGhlIG1lc2EgdG9vbCB0aGF0IHBhcnNlcyB0aGUgZGV2
Y29yZWR1bXAsIGhlbmNlIGl0IHdhcyByZXZlcnRlZA0KPiA+ID4gaW4gY29tbWl0IDcwZmI4NmE4
NWRjOSAoImRybS94ZTogUmV2ZXJ0IHNvbWUgY2hhbmdlcyB0aGF0IGJyZWFrIGEgbWVzYQ0KPiA+
ID4gZGVidWcgdG9vbCIpLg0KPiA+ID4gDQo+ID4gPiBXaXRoIHRoZSBtZXNhIHRvb2wgYWxzbyBm
aXhlZCwgdGhpcyBjYW4gcHJvcGFnYXRlIGFzIGEgZml4IG9uIGJvdGgNCj4gPiA+IGtlcm5lbCBh
bmQgdXNlcnNwYWNlIHNpZGUgdG8gYXZvaWQgdW5uZWNlc3NhcnkgaGVhZGFjaGUgZm9yIGEgZGVi
dWcNCj4gPiA+IGZlYXR1cmUuDQo+ID4gDQo+ID4gVGhpcyB3aWxsIGJyZWFrIG9sZGVyIHZlcnNp
b25zIG9mIHRoZSBNZXNhIHBhcnNlci4gSXMgdGhpcyByZWFsbHkgbmVjZXNzYXJ5Pw0KPiANCj4g
U2VlIGNvdmVyIGxldHRlciB3aXRoIHRoZSBtZXNhIE1SIHRoYXQgd291bGQgZml4IHRoZSB0b29s
IHRvIGZvbGxvdyB0aGUNCj4ga2VybmVsIGZpeCBhbmQgd29yayB3aXRoIGJvdGggbmV3ZXIgYW5k
IG9sZGVyIGZvcm1hdC4gTGlua2luZyBpdCBoZXJlDQo+IGFueXdheTogaHR0cHM6Ly9naXRsYWIu
ZnJlZWRlc2t0b3Aub3JnL21lc2EvbWVzYS8tL21lcmdlX3JlcXVlc3RzLzMzMTc3DQoNClN0aWxs
IHNvbWVvbmUgcnVubmluZyB0aGUgb2xkZXIgdmVyc2lvbiBvZiB0aGUgcGFyc2VyIHdpdGggYSBu
ZXcgWGUgS01EIHdvdWxkIG5vdCBiZSBhYmxlIHRvIHBhcnNlIGl0Lg0KSSB1bmRlcnN0YW5kIHRo
YXQgd2UgY2FuIGJyZWFrIGl0IGJ1dCBpcyB0aGlzIHJlYWxseSB3b3J0aHk/IG5vdCBpbiBteSBv
cGluaW9uLg0KDQo+IA0KPiBJdCdzIGEgZml4IHNvIHNpbXBsZSB0aGF0IElNTyBpdCdzIGJldHRl
ciB0aGFuIGNhcnJ5aW5nIHRoZSBjcnVmdCBhZA0KPiBpbmZpbml0dW0gb24gYWxsIHRoZSB0b29s
cyB0aGF0IG1heSBwb3NzaWJseSBwYXJzZSB0aGUgZGV2Y29yZWR1bXAuDQo+IA0KPiANCj4gPiBJ
cyBpdCB3b3J0aCBicmVha2luZyB0aGUgdG9vbD8gSW4gbXkgb3BpbmlvbiwgaXQgaXMgbm90Lg0K
PiA+IA0KPiA+IEFsc28sIGRvIHdlIG5lZWQgdG8gZGlzY3VzcyB0aGlzIG5vdz8gV291bGRuJ3Qg
aXQgYmUgYmV0dGVyIHRvIGZvY3VzIG9uIGJyaW5naW5nIHRoZSBHdUMgbG9nIGluIGZpcnN0Pw0K
PiANCj4gVGhhdCdzIHdoYXQgdGhlIHNlY29uZCBwYXRjaCBkb2VzLiBXZSBuZWVkIHRvIGRpc2N1
c3MgYm90aCBub3cgYW5kDQo+IGRlY2lkZSwgb3RoZXJ3aXNlIHdlIGNhbid0IHJlLWVuYWJsZSBp
dCBhbmQgaGF2ZSBlaXRoZXIgdGhlIGd1YyBsb2cNCj4gcGFyc2VyIG9yIG1lc2EncyBhdWJpbmF0
b3JfZXJyb3JfZGVjb2RlX3hlIGJyb2tlbi4NCg0KSSBjYW4ndCB1bmRlcnN0YW5kIHdoeSBpdCBu
ZWVkcyBib3RoLCBjb3VsZCB5b3UgZXhwbGFpbiBmdXJ0aGVyPw0KDQo+IA0KPiBMdWNhcyBEZSBN
YXJjaGkNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IENjOiBKb2huIEhhcnJpc29uIDxKb2huLkMu
SGFycmlzb25ASW50ZWwuY29tPg0KPiA+ID4gQ2M6IEp1bGlhIEZpbGlwY2h1ayA8anVsaWEuZmls
aXBjaHVrQGludGVsLmNvbT4NCj4gPiA+IENjOiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3Nl
LnNvdXphQGludGVsLmNvbT4NCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4g
PiBGaXhlczogNzBmYjg2YTg1ZGM5ICgiZHJtL3hlOiBSZXZlcnQgc29tZSBjaGFuZ2VzIHRoYXQg
YnJlYWsgYSBtZXNhIGRlYnVnIHRvb2wiKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVjYXMgRGUg
TWFyY2hpIDxsdWNhcy5kZW1hcmNoaUBpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2
ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAuYyB8IDYgKy0tLS0tDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMgYi9kcml2ZXJz
L2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAuYw0KPiA+ID4gaW5kZXggODFkYzc3OTVjMDY1MS4u
YTc5NDZhNzY3NzdlNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9k
ZXZjb3JlZHVtcC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1
bXAuYw0KPiA+ID4gQEAgLTExOSwxMSArMTE5LDcgQEAgc3RhdGljIHNzaXplX3QgX194ZV9kZXZj
b3JlZHVtcF9yZWFkKGNoYXIgKmJ1ZmZlciwgc2l6ZV90IGNvdW50LA0KPiA+ID4gIAlkcm1fcHV0
cygmcCwgIlxuKioqKiBHdUMgQ1QgKioqKlxuIik7DQo+ID4gPiAgCXhlX2d1Y19jdF9zbmFwc2hv
dF9wcmludChzcy0+Z3VjLmN0LCAmcCk7DQo+ID4gPiANCj4gPiA+IC0JLyoNCj4gPiA+IC0JICog
RG9uJ3QgYWRkIGEgbmV3IHNlY3Rpb24gaGVhZGVyIGhlcmUgYmVjYXVzZSB0aGUgbWVzYSBkZWJ1
ZyBkZWNvZGVyDQo+ID4gPiAtCSAqIHRvb2wgZXhwZWN0cyB0aGUgY29udGV4dCBpbmZvcm1hdGlv
biB0byBiZSBpbiB0aGUgJ0d1QyBDVCcgc2VjdGlvbi4NCj4gPiA+IC0JICovDQo+ID4gPiAtCS8q
IGRybV9wdXRzKCZwLCAiXG4qKioqIENvbnRleHRzICoqKipcbiIpOyAqLw0KPiA+ID4gKwlkcm1f
cHV0cygmcCwgIlxuKioqKiBDb250ZXh0cyAqKioqXG4iKTsNCj4gPiA+ICAJeGVfZ3VjX2V4ZWNf
cXVldWVfc25hcHNob3RfcHJpbnQoc3MtPmdlLCAmcCk7DQo+ID4gPiANCj4gPiA+ICAJZHJtX3B1
dHMoJnAsICJcbioqKiogSm9iICoqKipcbiIpOw0KPiA+IA0KDQo=

