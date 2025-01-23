Return-Path: <stable+bounces-110302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1DA1A85B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02296168E25
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECB189F3B;
	Thu, 23 Jan 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJGVIsO/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2F156F21
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651889; cv=fail; b=e0r8KRC3rFeGTr12+1muTLUZ9lJTOqeegxt/mZH5PH07Wv9i+V/N7O8OgYWEQBG/4NFsQb/UG9mWONZXYQFuhgvBnoRHp76caGXses8IeJKzgnn+PHGPRHPzlQRflfW75FB74xN5iuJ5ANc/0FSgtONXaRIeJ6xQwBrNmcm9XfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651889; c=relaxed/simple;
	bh=Vw5No2wWGnJ7T3dESafX0+FZDuMc1Axz7jTGZ8F5ZNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DqOubtd3jskHWhXhfDjRZXdIeI8AgHZExP6n5ppSr1mLkQKxyHAm6ShQmI1jjJ6Y2mP8cDEf3IuZEZXP4Sy4J1pFFrWrlXDg+VX6qkhVfTvKF3I66w6euUEnLP23zO9o4q77WUfp6zyly5z0nX4rZyG5N8M+qK4NY08yFqIMFAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJGVIsO/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737651887; x=1769187887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vw5No2wWGnJ7T3dESafX0+FZDuMc1Axz7jTGZ8F5ZNM=;
  b=WJGVIsO/fIowLIKDmv21iI3+ue4WieWXfzbRqFQyJ8E34rHcKXP/vLpo
   86owfS8ST0zZTahBlWZe2z+R0CeORNJbzw1t/34rKhQpQTENwnBmE843o
   jR4e4yBcxB/ec/S4zxBv2oYhvH24NJIa12Q+iq84BNU6r+K1ejM2O2V4s
   J+7pAFwEI948jQf+Uwp28LG1+oI+gKFhcmF98c5iAZ7l/rgu4k6SIW7vF
   ctXv53wX4GFHQaxQNw2BgUhzFlBNEfQbsXczrRgoV9OZpGpiraROQACQe
   zJaVv+QNHZFU0O0/WQWAsPjqxDouIM3j8/qZ2p4GLKI8rlqJqiF22dm3F
   w==;
X-CSE-ConnectionGUID: FtXk3gBlQ+aGPXr35reh8Q==
X-CSE-MsgGUID: c5cNlc/kTSO6IV9I8sSFRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38043803"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38043803"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 09:04:46 -0800
X-CSE-ConnectionGUID: KMUs427HSeSqtd3VQKg/Ng==
X-CSE-MsgGUID: IC6ih4TDREqCO7QKyZD88A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108392094"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 09:04:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 09:04:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 09:04:45 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 09:04:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5t8va/sf+HfWL4BRjyWnD6GHhVGhXqSFdm08fzL3g0FDxNwpKUvFDVvtxhPQ3l72B8VA6Z1064sQgD/i7I8FSurOg6trMjND1blErsX+JEy34kPwnuUu3vPCf51Eo7DRXfFmALUfqpckyrDlmv6zCqCdk1R58w6k8BqNKAbVe8oXV1WWqZsN7sWJaABJnZN8PwRJO6t2gWqWUkVXimVXbOQxFr42Jlk66T2J4rZEsxUtuQkhI9878/SV4EgaYZ0rmmbO0y2j2n+36Qnn3Rd0wIaVrDfYUiVK5/mhpdDEaYf1Zx7NLYmrazIcYIUs4Ib1moBAxqQAeTK7py3oMLPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vw5No2wWGnJ7T3dESafX0+FZDuMc1Axz7jTGZ8F5ZNM=;
 b=rIjGG0hiq8IPffilDx/ZHKIjC18A3ribXdbEKbZK8SQK2u93589aovhGgoQg7xiZ9+4cQ5jqh8v5FgYLM+bCvtIZVBOOE9UyAokJK/y1yA9qKctRBPBVNvqXF6nzyvZHyvx6dw0i+kWpM/WUp8Hn4G82zby/g1ou0OJUBFESlUoyctvKAI6qm9NzubLD0mY5wZ1iof2Umm+IpzFKX2fvJd1qr3L4zqma75XEpTm7zJlOKRIcCw66/BtKWxYNCfcJGygBkTR82YkXE3WhTfKY6Uxm408ALjlTzpZH15QfO1MdIwcUTlG3yOznp51HAIjkbJg8Okjqjp9iVeObXd3MUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 17:04:27 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::f5c2:eb59:d98c:e8ba%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 17:04:27 +0000
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
Thread-Index: AQHbbVVMFHgSix08VkSGVxA9T7ZR57MkZ3cAgAAEpgCAAAX6AIAAH5oAgAAFWAA=
Date: Thu, 23 Jan 2025 17:04:27 +0000
Message-ID: <7c63b8da8dbf20b630f8dfb33858d7269441f4d8.camel@intel.com>
References: <20250123051112.1938193-1-lucas.demarchi@intel.com>
	 <20250123051112.1938193-2-lucas.demarchi@intel.com>
	 <f16aac40a9ea1ab40d1083228cd0b460e1d217e3.camel@intel.com>
	 <kw4rrdedc3ye5elnis6bjz2xg34ttrul2d6qye5lm3ixeee36l@ncfk65fdvb4s>
	 <82a330f4d0c43036e088939cd6ba59790173447f.camel@intel.com>
	 <eucwwgbk6fctubofysjtkvibcci2p4c76bzl2kdsar2c22xjug@zhvnmqvf7zw3>
In-Reply-To: <eucwwgbk6fctubofysjtkvibcci2p4c76bzl2kdsar2c22xjug@zhvnmqvf7zw3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SN7PR11MB6969:EE_
x-ms-office365-filtering-correlation-id: 525189f3-5769-4082-24d6-08dd3bcffe9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWJBRnJaVVBpSGdhNDFaR1Bsc2J1NUtOd3h2VXVtNUZYbzBCOHYrYUNoOFVV?=
 =?utf-8?B?MHgwcG1kVExaQnlvZ0xTWGdlVCtxWlFnSEdVRHVsVVFNTWQ1OFZxRTk3clhL?=
 =?utf-8?B?Qms1VjNzang3OHI2NXVQUHF3RzB3UUpBbm5aV1FlMTJXMHRUcEtEM3pSeU9C?=
 =?utf-8?B?NkNvbXVXSlQ0Wlk3OHFVOFVHSWM0TnpMVndrMFFwaXNxZWNqRDRHakRLME5t?=
 =?utf-8?B?QVFtWmt6b2hzbzhqUklxb2R0QzNkb1A0QSs4aVliQXR5azFMdnY1NXBldlRk?=
 =?utf-8?B?VVdNMUIzVEZqNXBJa2FvcVE1MkJ4V1hOdHRaa2Rmd0lYV004WUlIeTNPZ2lY?=
 =?utf-8?B?WitRbzUrbys0MjJJSFcyNDFUUWFVWllnVFFTRWVaQkt0N05tNkpOdFdlME9C?=
 =?utf-8?B?enNuRkh0Q2h1WDZKaDlheVhiU3djeGxPOHQ5VTRQdXVzaXpDM2djaHpjenQ4?=
 =?utf-8?B?RVhNQTF6TU8wVEpSVGdMTjR2Wmd5SFJlbk9HTWhsT2NVZzBJMHFyNmhJSkpM?=
 =?utf-8?B?M1ZkZXg2WDF0SUM0TThDb3B4Q0ZDYnFsbUZ0RXNSN0JzSnladFRXQ0xLRVJV?=
 =?utf-8?B?VzM5R0JFc3h2M29KcE1CRm45bUdMWkhPeUJoTmZtMTArdkkxYW5PQklmaW5p?=
 =?utf-8?B?Ry9UaERiQnRPTW04bG1xS05KalFpUk42RGNGazl6NlZRdzcxaDZnN3AwYmEy?=
 =?utf-8?B?VW5sYXJLY0ltQTVpTExMZkYwT084ZHJWQW5mektTVDlVMVE1MnpTc3ZXbnFH?=
 =?utf-8?B?djJFU2hKUzdUKzF6eVNhWXF4UW9LNmVxUXF3QU12ZDdTMVJjRVRlcUEybnRP?=
 =?utf-8?B?R2xmVEJyMWJBOW85bS9MY3RlTUZtalc3dmx5V3o3OHBNNzY5RXFUVkJiQkRQ?=
 =?utf-8?B?Y1dQdnBSQmRwU1Z1dnpUS05RQ0FCQVpBQW5uSXE0bHV0enRnanA1ZDg0Rlgw?=
 =?utf-8?B?Rm9IUHl1enl4R0VuN2tSRmhuTnE3UEs3dW9Fd09xaDBCWFh1dmxXT1A1eDZi?=
 =?utf-8?B?MnJqYlpBckNGQmQ2aGVDVjFEWWJCVm9KQmRQVUtadUFzZ0FLekNEcmxHdXJw?=
 =?utf-8?B?Y2Z1M2tVRlhRWjFKUm5lL1BCbUJVT2Q5d0RwSkJoaG1TQjVHZ3lweXJrc05D?=
 =?utf-8?B?WXhaVWxMVFZGY3JlVU9UdVNYRTVlWms3M0dVK3RyZUFoaGNsaDhLWUVLMlRU?=
 =?utf-8?B?NmJYK25hd1I0L2dndFJodVNXRTcwWWl3MnYvUElDMExHUmU2STBkUzVnMWUx?=
 =?utf-8?B?eHN6MlNqeElsUkZSSXp4WHFCd2lVaUVrRGpySEhpb2lyNDVPaUlydTQzZ2VO?=
 =?utf-8?B?bitrbU1TamZWaEJsNGhQVkU5QWx6QnlJZzFlTGxrbWZOL3pza1JyNUpOMkg1?=
 =?utf-8?B?S1ExWVN3ZExoY3p2TkYrVkhqVStTVW9SSkNxRWV4Y2toV2J2UmowYW0zclBi?=
 =?utf-8?B?Y3l3MWdOS3p0clNpYWpMVGJ3QUJMa0ZHTEE5Qnl4ZVNrcGpob1JvK1pUd2wz?=
 =?utf-8?B?aGNxd0FZcWVucXhGRXpJVmkyTGFmRks2Qm94b3JWVmdVSkZvTVpkdWNSMUhO?=
 =?utf-8?B?MVcxSUxONE90OXRjOUIwcUxzNDJBZHNPUFl0NHgxQVZrMDN3L1JVaVNpUFFW?=
 =?utf-8?B?cXgyZ0xsQkJtdkNoUEJHTk43UnUrUW4yakZ1OEUyL3MvRWNQazNnZWhTWHJ2?=
 =?utf-8?B?SE9CbDNIVVI3RlRBcmthd3FKbWp4U1lGYlNmTmhacy9zckFGRnpzaW5SNmNO?=
 =?utf-8?B?andOUWtPS1A2U1Q5ZGFQRFBOUFBrNmZ4cXdoejc3V2dieXNSc0NQRWFGOVBk?=
 =?utf-8?B?YUhFYU03clpSbnVjWHNKTC8wOVFpWkdaVTJzWlRFNUpUZFVQRDZoNHBtUEpo?=
 =?utf-8?Q?/WE09uqU1tHpr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWFKVG1SN0hxWDlpL1lvc3I4VWZjeTZIa0dtMW1hWi9ZRjB5bEcyMldkc01p?=
 =?utf-8?B?VkhjNXQ5MCszUXd5OXU0ck1YczY2RW54WUlkdFRicVgyaVJROXM5dWljSUp3?=
 =?utf-8?B?dzRQRVlJakpoRUtQOXFSR3FZUVllYS9CWWxDLzNSaWR3V2pZYVFmUzd2MzFn?=
 =?utf-8?B?MkJJc3o4L3N3SC9XSVl2Y0ltcnJQeGRCTXVmN2tZU2QwSG9iZDB0SVhUbnpJ?=
 =?utf-8?B?bWlyM1VTRE9MZXEzZ2hxTFpNT1FLU09CQzRYNjJxUjRKVGpjNFV3bUF2UElO?=
 =?utf-8?B?WmpwNWd3TEN1Vll6Qnh1VzNqNCtHMUU4c3BheDBTeEFidzh0TFRaWVI3ZlBk?=
 =?utf-8?B?R2FhV1JEbjFVUU13amVmQlY1RGxTRkxVa0xFUmtiNzZ3akRhYVNsUlFrY0Nw?=
 =?utf-8?B?N3BwNmo4N1N5ek1jTFRKUmgwSU9CS1dJZjVFdGM5TjZPMzBsMFNKK1lCYTkw?=
 =?utf-8?B?ZjNNenl2T2pIa1pXOFBua3BCSVFId1RjVCt1REdzT3orN0ZnN1h0R2lXSktn?=
 =?utf-8?B?RjFJVXRNclZ4ZmlKMVEyWlVkWXE2ODF0YlE3Y2paSXlSRldjNHU2TXVpRFU3?=
 =?utf-8?B?LzM5UmJ3amx1S3grOTVadXJyOFRPQ2o4MVBpK3R2Z3dlNDVPUXhGNlVMQUlK?=
 =?utf-8?B?em9naFFWUEM5QzN4ajBnbkJvMnpYR3VWUk8xT2toMFdvYVh3elE2azNUVllI?=
 =?utf-8?B?blovU2hmd1VTYnBSRmFLUzZEOU13WGdYNzVTc2hOZ2w1b2FqWmJqNUQxb0pB?=
 =?utf-8?B?dGhIYVVBRkxQTDNrY0RCMzlzWERLZlh5TGIzb2FwaEdjU0RDUXNOUVg1eWJk?=
 =?utf-8?B?YUU5cXNzYjF2Q3hEVys2MUJaaVFWdWNpOC9pQWdhTWVrYk1VaU1IUkY0cmdq?=
 =?utf-8?B?eWVVeDkrdUFpVTR3N2xPeW0zaVRXUUl1OW90UjJvYTJOelVaLzNrOGk1Wmcy?=
 =?utf-8?B?dFlsSUpLaThVbWRjUk5NYW9SNzRjNnpDdmlJWkFhdUpQTTJsdDJ2WFVKK1lN?=
 =?utf-8?B?aWRJWThRcmRsZnZNellvaWVXVFJtaSs0Q2tEdzBhbS9IbDJGNndrV09ZTFpy?=
 =?utf-8?B?TEYzc0pNaHoxZnFhV3BlSThMWklSd2hTaXdaSkt4VXhYaDl3ZFRldSs1bUpO?=
 =?utf-8?B?NU0yYnpKeElSTHBLS0c4ak5za2wxVWFwQ29BRktOcTREVHlhN3lUMDlxK2gz?=
 =?utf-8?B?eWpWNk9XVXNRaEpsazZKTWVQcUFrbGFTSE5XbWJ0dXk3WTE0NURTUHBwa3l0?=
 =?utf-8?B?d29weDdmaXFscExkSEZrd0J2SXBQUHZHblM2UFgxN3Qzb1Vtd2orZmxGeDdV?=
 =?utf-8?B?dHdzY3c3MHROZTJaRVdveWNBaktKZWpmOW1NanRpeUZKVlAyR2hjNVpIVEZw?=
 =?utf-8?B?NGNjOWpMOHBpUlY1M0kwRHFFNGdzK2RYdGdlSC9UaXVEeG1WQmVmWTB1Tklm?=
 =?utf-8?B?WHJYTVNOWmpqQlNrbHEyeHQxbThEbzhOTWtRVnlYL2Rid0puSGIwOWErK3hk?=
 =?utf-8?B?eUNaU254MzhoMWZHTDFHeVZLNFhNa29HYW44Mk51bUhaSmFTdWx0WVQxbXJ5?=
 =?utf-8?B?dWlVZktlbC9QaysyZTVtK2d0bW9TdDUrb3BsKzdCYjBTTHZiVjlSZmFjQkRZ?=
 =?utf-8?B?N0hjNnRRK3BPZW9IVW5Kbm5vKy9XWDZqTmFvbTI2dW90R0ZZR0RpN28zL2Rl?=
 =?utf-8?B?c1A4RDNnbE80SEJrOHMxNTJWai92ZHFrNGNJamlOaUhGK1hYTzB3VGM0Ny9L?=
 =?utf-8?B?YkNhMVlDV3dEZmxtS21HZHZkcUF4UlpSNXRTOENmQ204R2w5cm1waHNhMWRR?=
 =?utf-8?B?V2JXVzBRWVkxSytWWTJMOVBvdDNqaG1lbWtsNzRKZWJHNG9WMDgrSEFHSzB3?=
 =?utf-8?B?WHkvdnZYS1BRM0prcGphbTNMeGlqRWlTZGwyOEN2T2UxQXNRSDRLYlpRTnVp?=
 =?utf-8?B?bzRXK1RXeFJuaklqNVlWMWpzd0ovaldqQndzWXhtblJoVmRIZ3pnUUxHWnFV?=
 =?utf-8?B?QVRpS3NjeXFqTXJqeUhHeDU1NDdVcDEvL1JLV3NnZVFmUjUzNm9xbmdSeWsw?=
 =?utf-8?B?cXpKanRMSmtCUytNeFltK0puaGFoT2pBQjJ1V002eFpRMXZlcEZId0Y1aHU5?=
 =?utf-8?B?eGdMSXlXRXhaR1M1WW4rcnUrcmNsMWpQNGJRVERZZXlCOXBVUGN0RDUxa3NY?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62896E0D584C749B0B52B4F4F366305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525189f3-5769-4082-24d6-08dd3bcffe9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 17:04:27.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKl9DyVdle4izxbRrWbFxyazvQfPgO0Z7iY1vNJ2RxTYNRN4YE1QPPGQsq44REr4zsk7hYKAlE/5cVPN9sI++Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAxLTIzIGF0IDEwOjQ1IC0wNjAwLCBMdWNhcyBEZSBNYXJjaGkgd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDIzLCAyMDI1IGF0IDA4OjUyOjEzQU0gLTA2MDAsIEpvc2UgU291emEg
d3JvdGU6DQo+ID4gT24gVGh1LCAyMDI1LTAxLTIzIGF0IDA4OjMwIC0wNjAwLCBMdWNhcyBEZSBN
YXJjaGkgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEphbiAyMywgMjAyNSBhdCAwODoxNDoxMUFNIC0w
NjAwLCBKb3NlIFNvdXphIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDIwMjUtMDEtMjIgYXQgMjE6
MTEgLTA4MDAsIEx1Y2FzIERlIE1hcmNoaSB3cm90ZToNCj4gPiA+ID4gPiBIYXZpbmcgdGhlIGV4
ZWMgcXVldWUgc25hcHNob3QgaW5zaWRlIGEgIkd1QyBDVCIgc2VjdGlvbiB3YXMgYWx3YXlzDQo+
ID4gPiA+ID4gd3JvbmcuICBDb21taXQgYzI4ZmQ2YzM1OGRiICgiZHJtL3hlL2RldmNvcmVkdW1w
OiBJbXByb3ZlIHNlY3Rpb24NCj4gPiA+ID4gPiBoZWFkaW5ncyBhbmQgYWRkIHRpbGUgaW5mbyIp
IHRyaWVkIHRvIGZpeCB0aGF0IGJ1ZywgYnV0IHdpdGggdGhhdCBhbHNvDQo+ID4gPiA+ID4gYnJv
a2UgdGhlIG1lc2EgdG9vbCB0aGF0IHBhcnNlcyB0aGUgZGV2Y29yZWR1bXAsIGhlbmNlIGl0IHdh
cyByZXZlcnRlZA0KPiA+ID4gPiA+IGluIGNvbW1pdCA3MGZiODZhODVkYzkgKCJkcm0veGU6IFJl
dmVydCBzb21lIGNoYW5nZXMgdGhhdCBicmVhayBhIG1lc2ENCj4gPiA+ID4gPiBkZWJ1ZyB0b29s
IikuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2l0aCB0aGUgbWVzYSB0b29sIGFsc28gZml4ZWQs
IHRoaXMgY2FuIHByb3BhZ2F0ZSBhcyBhIGZpeCBvbiBib3RoDQo+ID4gPiA+ID4ga2VybmVsIGFu
ZCB1c2Vyc3BhY2Ugc2lkZSB0byBhdm9pZCB1bm5lY2Vzc2FyeSBoZWFkYWNoZSBmb3IgYSBkZWJ1
Zw0KPiA+ID4gPiA+IGZlYXR1cmUuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHdpbGwgYnJlYWsg
b2xkZXIgdmVyc2lvbnMgb2YgdGhlIE1lc2EgcGFyc2VyLiBJcyB0aGlzIHJlYWxseSBuZWNlc3Nh
cnk/DQo+ID4gPiANCj4gPiA+IFNlZSBjb3ZlciBsZXR0ZXIgd2l0aCB0aGUgbWVzYSBNUiB0aGF0
IHdvdWxkIGZpeCB0aGUgdG9vbCB0byBmb2xsb3cgdGhlDQo+ID4gPiBrZXJuZWwgZml4IGFuZCB3
b3JrIHdpdGggYm90aCBuZXdlciBhbmQgb2xkZXIgZm9ybWF0LiBMaW5raW5nIGl0IGhlcmUNCj4g
PiA+IGFueXdheTogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL21lc2EvbWVzYS8tL21l
cmdlX3JlcXVlc3RzLzMzMTc3DQo+ID4gDQo+ID4gU3RpbGwgc29tZW9uZSBydW5uaW5nIHRoZSBv
bGRlciB2ZXJzaW9uIG9mIHRoZSBwYXJzZXIgd2l0aCBhIG5ldyBYZSBLTUQgd291bGQgbm90IGJl
IGFibGUgdG8gcGFyc2UgaXQuDQo+ID4gSSB1bmRlcnN0YW5kIHRoYXQgd2UgY2FuIGJyZWFrIGl0
IGJ1dCBpcyB0aGlzIHJlYWxseSB3b3J0aHk/IG5vdCBpbiBteSBvcGluaW9uLg0KPiANCj4gYmVj
YXVzZSBmb3IgdGhlIGRlYnVnIG5hdHVyZSBvZiB0aGlzIGZpbGUsIGl0J3MgaGFyZCBpZiB3ZSBh
bHdheXMga2VlcA0KPiB0aGUgY3J1ZnQgYXJvdW5kLiBJbiA1IHllYXJzIGRldmVsb3BlcnMgaW1w
bGVtZW50aW5nIG5ldyBkZWNvZGVycyB3aWxsDQo+IGhhdmUgdG8gZ2V0IGRhdGEgZnJvbSByYW5k
b20gcGxhY2VzIGJlY2F1c2Ugd2Ugd2lsbCBub3RpY2UgdGhpbmdzIGFyZQ0KPiB3cm9uZ2x5IHBs
YWNlZC4NCj4gDQo+IGlzbid0IGl0IGVhc2llciB0byBkbyBkbyBpdCBlYXJseSBzbyB3ZSBkb24n
dCBpbmNyZWFzZSB0aGUgZXhwb3N1cmUNCj4gYW5kIGp1c3Qgc2F5ICJrZXJuZWwgc2NyZXdlZCB0
aGF0IHVwIGFuZCBmaXhlZCBpdCIsIHRoZW4gcHJvcGFnYXRlIHRoZQ0KPiBjaGFuZ2UgaW4gbWVz
YSBpbiBhIHN0YWJsZSByZWxlYXNlLCBqdXN0IGxpa2Ugd2UgYXJlIGRvaW5nIGluIHRoZQ0KPiBr
ZXJuZWw/DQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiBJdCdzIGEgZml4IHNvIHNpbXBsZSB0aGF0
IElNTyBpdCdzIGJldHRlciB0aGFuIGNhcnJ5aW5nIHRoZSBjcnVmdCBhZA0KPiA+ID4gaW5maW5p
dHVtIG9uIGFsbCB0aGUgdG9vbHMgdGhhdCBtYXkgcG9zc2libHkgcGFyc2UgdGhlIGRldmNvcmVk
dW1wLg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4gSXMgaXQgd29ydGggYnJlYWtpbmcgdGhlIHRv
b2w/IEluIG15IG9waW5pb24sIGl0IGlzIG5vdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEFsc28sIGRv
IHdlIG5lZWQgdG8gZGlzY3VzcyB0aGlzIG5vdz8gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGZv
Y3VzIG9uIGJyaW5naW5nIHRoZSBHdUMgbG9nIGluIGZpcnN0Pw0KPiA+ID4gDQo+ID4gPiBUaGF0
J3Mgd2hhdCB0aGUgc2Vjb25kIHBhdGNoIGRvZXMuIFdlIG5lZWQgdG8gZGlzY3VzcyBib3RoIG5v
dyBhbmQNCj4gPiA+IGRlY2lkZSwgb3RoZXJ3aXNlIHdlIGNhbid0IHJlLWVuYWJsZSBpdCBhbmQg
aGF2ZSBlaXRoZXIgdGhlIGd1YyBsb2cNCj4gPiA+IHBhcnNlciBvciBtZXNhJ3MgYXViaW5hdG9y
X2Vycm9yX2RlY29kZV94ZSBicm9rZW4uDQo+ID4gDQo+ID4gSSBjYW4ndCB1bmRlcnN0YW5kIHdo
eSBpdCBuZWVkcyBib3RoLCBjb3VsZCB5b3UgZXhwbGFpbiBmdXJ0aGVyPw0KPiANCj4gd2UgYXJl
IGFscmVhZHkgZGlzY3Vzc2luZyBpdCwgd2h5IG5vdD8gIEFsc28gYXMgSSBzYWlkIHRoZXJlJ3Mg
dGhlIGd1Yw0KPiBsb2cgcGFyc2VyLCBhbm90aGVyIHRvb2wsIHRoYXQgaXMgYWxyZWFkeSBleHBl
Y3RpbmcgaXQgaW4gdGhlIG90aGVyDQo+IHBsYWNlLiBTbyBpZiB3ZSBhcmUgZ29pbmcgdG8gcmUt
ZW5hYmxlIHRoZSBndWMgbG9nLCBpdCdzIHRoZSBiZXN0DQo+IG9wcG9ydHVuaXR5IHRvIGZpeCB0
aGlzLCBvdGhlcndpc2Ugd2Ugd2lsbCBwcm9iYWJseSBuZXZlciBkbyBpdCBhbmQga2VlcA0KPiBh
Y2N1bXVsYXRpbmcuDQoNCk11Y2ggZWFzaWVyIGNoYW5nZSBhIGludGVybmFsIHRvb2wsIG5vPw0K
DQpUaGUgR3VDIGxvZyBpcyBpbiBvdGhlciBzZWN0aW9uKCIqKioqIEd1QyBMb2cgKioqKiIpLCB0
byBtZSB0aGlzIGNoYW5nZSBpcyBtb3JlIGNvc21ldGljIHRoYW4gZnVuY3Rpb24gYW5kIG5vdCB3
b3J0aHkgdG8gYnJlYWsgb2xkZXIgdmVyc2lvbnMgb2YgdGhlDQpwYXJzZXIuDQoNCkkgY2FuIGxp
dmUgd2l0aCB0aGF0IGJ1dCB5b3Ugd2lsbCBuZWVkIHRvIGNvbnZpbmNlIG90aGVyIEludGVsIE1l
c2EgZW5naW5lZXJzLCB3aGVuIEkgbWVudGlvbmVkIHRoYXQgTWVzYSBwYXJzZXIgd2FzIGJyb2tl
biBpbiBhIE1lc2Egc3RhZmYgbWVldGluZywgSQ0Kd2FzIGFza2VkIHRvIHB1c2ggaGFyZCB0byBn
ZXQgdGhlIFhlIEtNRCBwYXRjaCByZXZlcnRlZC4NClRoYXQgaXMgd2h5IEkgdGhpbmsgaXQgc2hv
dWxkIGJlIHRha2VuIGNhcmUgaW4gYW5vdGhlciBwYXRjaCBzZXJpZXMgYXMgaXQgY291bGQgdGFr
ZSBtb3JlIHRpbWUuLi4NCg0KPiANCj4gTHVjYXMgRGUgTWFyY2hpDQo+IA0KPiA+IA0KPiA+ID4g
DQo+ID4gPiBMdWNhcyBEZSBNYXJjaGkNCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBDYzogSm9obiBIYXJyaXNvbiA8Sm9obi5DLkhhcnJpc29uQEludGVsLmNvbT4NCj4g
PiA+ID4gPiBDYzogSnVsaWEgRmlsaXBjaHVrIDxqdWxpYS5maWxpcGNodWtAaW50ZWwuY29tPg0K
PiA+ID4gPiA+IENjOiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGludGVsLmNv
bT4NCj4gPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IEZpeGVz
OiA3MGZiODZhODVkYzkgKCJkcm0veGU6IFJldmVydCBzb21lIGNoYW5nZXMgdGhhdCBicmVhayBh
IG1lc2EgZGVidWcgdG9vbCIpDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVjYXMgRGUgTWFy
Y2hpIDxsdWNhcy5kZW1hcmNoaUBpbnRlbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4g
IGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jIHwgNiArLS0tLS0NCj4gPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29y
ZWR1bXAuYyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jDQo+ID4gPiA+ID4g
aW5kZXggODFkYzc3OTVjMDY1MS4uYTc5NDZhNzY3NzdlNyAxMDA2NDQNCj4gPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1bXAuYw0KPiA+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jDQo+ID4gPiA+ID4gQEAgLTExOSwxMSAr
MTE5LDcgQEAgc3RhdGljIHNzaXplX3QgX194ZV9kZXZjb3JlZHVtcF9yZWFkKGNoYXIgKmJ1ZmZl
ciwgc2l6ZV90IGNvdW50LA0KPiA+ID4gPiA+ICAJZHJtX3B1dHMoJnAsICJcbioqKiogR3VDIENU
ICoqKipcbiIpOw0KPiA+ID4gPiA+ICAJeGVfZ3VjX2N0X3NuYXBzaG90X3ByaW50KHNzLT5ndWMu
Y3QsICZwKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtCS8qDQo+ID4gPiA+ID4gLQkgKiBEb24n
dCBhZGQgYSBuZXcgc2VjdGlvbiBoZWFkZXIgaGVyZSBiZWNhdXNlIHRoZSBtZXNhIGRlYnVnIGRl
Y29kZXINCj4gPiA+ID4gPiAtCSAqIHRvb2wgZXhwZWN0cyB0aGUgY29udGV4dCBpbmZvcm1hdGlv
biB0byBiZSBpbiB0aGUgJ0d1QyBDVCcgc2VjdGlvbi4NCj4gPiA+ID4gPiAtCSAqLw0KPiA+ID4g
PiA+IC0JLyogZHJtX3B1dHMoJnAsICJcbioqKiogQ29udGV4dHMgKioqKlxuIik7ICovDQo+ID4g
PiA+ID4gKwlkcm1fcHV0cygmcCwgIlxuKioqKiBDb250ZXh0cyAqKioqXG4iKTsNCj4gPiA+ID4g
PiAgCXhlX2d1Y19leGVjX3F1ZXVlX3NuYXBzaG90X3ByaW50KHNzLT5nZSwgJnApOw0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ICAJZHJtX3B1dHMoJnAsICJcbioqKiogSm9iICoqKipcbiIpOw0KPiA+
ID4gPiANCj4gPiANCg0K

