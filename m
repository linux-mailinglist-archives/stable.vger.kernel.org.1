Return-Path: <stable+bounces-224655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOpXAs8psWkBrgIAu9opvQ
	(envelope-from <stable+bounces-224655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:37:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B025F739
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C54F307F59C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C73B47EB;
	Wed, 11 Mar 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzdRkEzH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97523B637B;
	Wed, 11 Mar 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217786; cv=fail; b=icpzGg0w28+nBrklAu9p/Wd8kqD+P5ZWPEgPXXSHCgnCWBuWF94whuxhvFVqRmuP7AWUrd+EoMcryuOVXRJNtc3PxF1Gd0u9IWx7BfQ6c1y+6z3m2Ce8/JzdMGXKNfv19GsUZ81F48QcwBdSRkT9T8n7jlpUiE7CGOuDFjkZdaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217786; c=relaxed/simple;
	bh=VW26E/bH/SqLYwgg86KBOfK8iQaSNT6cBX5ccklZoAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTFEsWvstMWChTFR7+Nkkht/ospLH34hquQzm9ne7ezB1o+bMiIY3Btet1wRyOdj4aS9FwE/xbzNlCpwEgbE0lZS1DSnRMIY+tD1Lm70vRd/iDvbCb6dxZ5POs6HoqGPWwUWxSqplN6otA1Mr1kv32fWGX36kMjWSQnkOvQGntI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzdRkEzH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773217782; x=1804753782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VW26E/bH/SqLYwgg86KBOfK8iQaSNT6cBX5ccklZoAc=;
  b=LzdRkEzHjAfMlC5+5w/TSNZ5Ksfi/FQkEBkFGlSE50dtd1iTQ1fXPFGY
   LRd5FwzxiJmhXlXNPtY3xpvr7+Av8v0d+9VZ4S8Q8pg2Xchc1tfhpeYHk
   CFk7buhbWrEE4j8I7z3qag3ayyoY9Tbrol3fJoifB5nxQR3V9cVzXaCmD
   o5jKko5rSRiQ4cuWEK0PXYEfR5rgJfFJ+1SlDXSIYIfo2Ja9Uvj+eMuxL
   mUuEBk4v/VQgLkeU3cHY5Re9KCaqIguLrqBLDwNIMlNcBBSeLzH7PMn+b
   20wXC3XqIkW5vUgyGYVhvTh+9Ho0dq16EtlZ7eNPAFCd4Z491dqdq4E1L
   Q==;
X-CSE-ConnectionGUID: PWBf/ZLXQUKucZieBIuI2g==
X-CSE-MsgGUID: teboO9QRSQ+pq9hhtEiTUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74250934"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74250934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:29:42 -0700
X-CSE-ConnectionGUID: wg1LZX6wQpmJFXKJY/+g+Q==
X-CSE-MsgGUID: NDAIWqhdSBCsT5A51chPBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="250896691"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:29:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:29:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:29:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wx/DjhMgOn7XITuE23W31zh4tmdsyqVXPna5P1afLS6uDlDwC6kaNJZ7sektOr2xcGWlqV0nDLWGp77BRu/peyl2uO1PK1KJ4jqGYmFLOmUoqJylEXIk5jgLdow6Dgrlm7kM6096UjbVg9JwRR9b4FVKhg+shxM/wqzMF+ojmqQg9r3irgBpoLbh0LKwOh8bfMh/iD0XSC4P6d+DJpv6HXPxsDPvJyFxX7tA/F56ozJZobXJTb5EdOIiArzWlkXZlcuyfxnGqJK+thlNjJYotVwVM57GvMf/o1uwZF1JP8bvYTK9lEkke0yN2z/n+dCiFmY5FpbrTxb7OmQMJ/5L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW26E/bH/SqLYwgg86KBOfK8iQaSNT6cBX5ccklZoAc=;
 b=nLrLsa/kQDKa0oCtfuEjh728ZLe1SfiXmZMhHuJ3AuIIsnapKkz3L2MuBcmjehv3jfAPUFUjb134UwdR1pmmkNpeGdWst43cSLzxIYkv/DB2+w9rYvS+xRu11hlr+s988f4oNyAU1efLeI1SQUcAjdIHstHW7UqGFsSdam8tyAZIGWQvDdZqVuFT1dedQDHYD8FFO5lvgO2+fQg0oZ+mKQzLSK0QMfg1Bib7ZzPYF3QBsflt44AjCW51DYu8eBjk2+XImsxLMw4keG+xFrXJPuf/h1bWiu/QjRPWud+/FhKcW4KNXIQQPrKiBnenILXN5k2dW87fof35WCSz+ytQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 08:29:31 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:29:31 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Adin, Menachem" <menachem.adin@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: RE: [char-misc] mei: me: reduce the scope on unexpected reset
Thread-Topic: [char-misc] mei: me: reduce the scope on unexpected reset
Thread-Index: AQHcqVIWI7Og3IODGk+WnSNx+zHnR7WpDw+Q
Date: Wed, 11 Mar 2026 08:29:31 +0000
Message-ID: <CY5PR11MB6366DC9B0E28AE62940193E0ED47A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260301074621.2084367-1-alexander.usyskin@intel.com>
In-Reply-To: <20260301074621.2084367-1-alexander.usyskin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DM3PPF5217261E0:EE_
x-ms-office365-filtering-correlation-id: 521958f7-ab91-42b2-069c-08de7f4851a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: LMYgrAmb+13b2gDRnJgB7DjtfYDHDp57w8QsyBlhq2lR6wdGSTtP/WCsbr8MZHAdA1/dQVBSCBRsYRFoW6pUQGxbhavrZGrBAAdS8AR1ON/a0Xl+G8/z2rUSNfRWV/5+Bz+f7r3y+qUzdoM7uPhHwt4P5u7PAs+lzk4YdCZI6sObJQwSLgfG6kb/+sLhpmwcQrJpXnofQbMV3xw9YVM5a7BcBFABDVz8sxSZW1pMYnNQDE+LbYvUB7XSuDpTw2SfARd2iWO2WPorb9RLqkrZ62ADMpTXHoytIGekpyv7qxOtakJyGZnuyJnKweewCPE3BzTZydoclwdxYVeM372Ck7hWBNnkYsvLf4f+U+Z4Rw5ZvN8pWmZQkgWquMEsOyvL6RrhgbS+pAQfoJl8o5qEUJ9o/P0Zc9oiVkGEN9Ai6qm1wPu8bCE6aIKBR9Rk2KHZ89Eys7ikfhSGaGyQXkKVcV12Wa/8eFpyxDWemEaOL44QxOfpGmkSzeEDIHjhDdFRLwQaGsejHiK6Km9fHDXwZyGYfqcbFafDWvoAPQWUjwAqjV2RS09Zy12NXvY9lA+tiFe0RkYrtcsnT4TzR9dMk7PRhrGudn9T02dy2a8+WS+O8USweK/YyiRq1mPtSsmMrnuNJDbU7sGHjm4DPzwhcqHiLG/atpT5t/jLqVuA0LZo4svFBYogsXcDc4Qf8AhPp9RSgQaKABvxH5mdBnoiFjxGHzVoVxtZHlD/EpvWfHbrC/bxaESzy7Q0UazbstiF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWhTeDdFZEJNbDN3UEtPanU2TlJzdnoyY1NmN1ZyNWQ4L1hjMjZLZzV2U0w2?=
 =?utf-8?B?dzE5UWx4REJnbVA0STJwVWRETzJOZkwzWDdyQWVIdkYyeDlSU211SHV1eENR?=
 =?utf-8?B?WTEvenN0MGRkVHBSQnJsRlQ4TEkrYk1UUEpkYm5kNGNURTdYNXk5T0trcTVy?=
 =?utf-8?B?U1JJRHBucDdHNFdOSHFESHRLb1JUNkJWbjJKeEx4Y0k5aFR0YWY0Q2RrV2Zx?=
 =?utf-8?B?UzMxMDJLTFVwQmNua3NhWXZQeS9BTVZyWXlOS3MwWk9HV2o5SFduN0RvK2Y0?=
 =?utf-8?B?MFhzaWRSL1NobTNxcWQ4VVJQelpBdm82VG5aZGdlb1BkT2ViVGZkVjNxUzNu?=
 =?utf-8?B?eWpxdXc3bzgraDZoTFpzY1RwbVkyVVN0OVdEbUVCN1dCQUx0YXBDcVljR20y?=
 =?utf-8?B?T0FpNmY5QXZhQ2k0eWRzSDBPNGVwY0F3aWFtRFBWREc3ZmNWcTFkQnRDV1pw?=
 =?utf-8?B?MUg2L0lPbmphUTAybDBhaUpaYWpyc3FFTHhpQmhIdzhwRSt6UkRPTGlLbEMr?=
 =?utf-8?B?T1hzWWZNRFBtVHRuVnBudVFWcWN1R0YzRStGVUUxcUlsUUdFRWFpZG42b2NJ?=
 =?utf-8?B?UWlPSFo4dnhNOGhqZkJrNlBXUUVreHd4WlA5b1JXbSt4RUFqTVZxaDVHSGpK?=
 =?utf-8?B?Wm1xWkNuL0lNUGhOb2VmUDFoZk9DZ1B6LzVUbE5Ud0FpSVk4QkFmeWVJR1pk?=
 =?utf-8?B?cWYwdjcvWndKWkpVTjkwc3U2cmdQZzV1VFBPRnRiL0Z0UE9mSGsyVmJ6VEpj?=
 =?utf-8?B?QXkzQ1VkaEIyZkkyZkZHRGRkdVpDbG44QitCd0Y4My9JbW1OajYwa01SSUdC?=
 =?utf-8?B?RVNQV0lOWVVmNE9SS0JwVVJVeVRtamY4bHgwWW92TXNWZDBQNUE2RDAzYjRk?=
 =?utf-8?B?SlpibzhPUjgvUHBkeWYvOEJOdG9qaDRlbUlaR2UvMC9BTEQ2N3dJWmgxUmlO?=
 =?utf-8?B?cTU4Z1pacndRcm9xazZLdE40cm1lUXZyc0Z1eG5takh2MnJuK092dUg2OWlF?=
 =?utf-8?B?aUlMWmRoU1cydmRzdHdWd0dVNHVZUk5JZGJNR1FuUk14TzR4VzVTUVBqazhN?=
 =?utf-8?B?SS9jMDg5Zm1jMGEzU09uMHJ2NEFqbzJxQmR2VGltMER2OTFsbVA1MlpCbk5I?=
 =?utf-8?B?bHByd0ZSNjJnMGlBZFBHZE5QTGpMQ0k3Y3FoTW9lajRtUjBzMUsyakVJUGxx?=
 =?utf-8?B?a3owcEhZQzJXdG11RDZRMnZia3N5TmV1eHVwVzQ1NDlBR04wUkhOV3AyVkFj?=
 =?utf-8?B?SEIzaG5XVHIwTjFSSlIzMXkxZHdEQ3JsRWRxYlBacVFIWXhqN3NSRHcrMmVN?=
 =?utf-8?B?b0lnWWpOcHZpSVNFcHF0ZndpcEphRXVWYkJjdEVVN0MzZkNiMlVJWjdRZDBs?=
 =?utf-8?B?UFh0bkNiYmt1UThLYnhMN3IwZWtjUGkzYUVtZSsvdTJlSGhqMVV3K213V1M1?=
 =?utf-8?B?c1o0MWs2R1BwRElNQWlZRzI2T3h1dEo4bEVBRlhISVQyWXdLdVFZdU9QaUxD?=
 =?utf-8?B?RGE3ZGxuVkxyRFhMME4xZXhWWC9LcW92dXBXQnlOaVhKRGMzMkNob2hkOVFl?=
 =?utf-8?B?TGpLZjdvUGV3MkJrT04wMDA4WngySlRGeVZXb3FjY0FUVDlpTzd6NjQyWWdR?=
 =?utf-8?B?R2VKMVZyS1RtWGVzcG52K3BhZi9leTJTNU9SdC9LZ0Ezb2lCbUN6b1JyU3Zq?=
 =?utf-8?B?a0tXU0s4UzNNNWpJWkdaakZCbU13QVpaajZpWHJtWWtiL2h5TG96endVSmNY?=
 =?utf-8?B?N05DQ3B2blhvanZ2M0ZsMmdsSkp1SG1tSWUxVlVqK3N3YTd1a2Qzem9kL09w?=
 =?utf-8?B?T0EwOE1FQ09QdnFLRWdNU2RRU1VzVDQxU2pteVFRWVNBOFVCSHVUNXFpRDdv?=
 =?utf-8?B?cDZrY3crd1hVK0crU2xtUWJkMHJNK2xYYTVuNjlIVlhUNDE1bW85eDJ2OUox?=
 =?utf-8?B?ai9lVEFPWUpUSDFTRlhnaW1weDM5NWNuWVFHSzFoQlRCcVg0NjBlMUh4dENr?=
 =?utf-8?B?MHRCL2lTSDZDdVJJK3ladUJqZThOU0IxdWh0aFBUNlpMMmc0cUV4azE0TzQw?=
 =?utf-8?B?cENmY2I0TG45MVllcnJFaWhRS25jaUowV0ZTc1BURWkvS1diZmJ6TlNNWVJC?=
 =?utf-8?B?MUQ1SjR4VHpvbkN4b1E0NS9XWFJjNUtWTm5rUHBpeXhxR05sRVdKaUVMQUxQ?=
 =?utf-8?B?Rmx3U3o5dm82alQ4MmdSR3A2ZGJIbzFnenVGSGV3Y0tzODlNalV6WDJDWDlM?=
 =?utf-8?B?aHdZMDkySThTcnhxUzFpelZ0dkZ4MVlITytNaTNFTU5pdWZjUkdiblNNTHBX?=
 =?utf-8?B?TE00WEJ0TDcvdDg5eVg1NmllcDZGdGZwcGhFcXJRYWRFUXNMcXlNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NGFUFbqHJvlgfXE0PwB/8rErRJfOHpmPXW0US1bKSaClHCSl60jEaCs8BnUHJwL/Bcejn/bkiTzuBv2QKFvTnm2xYk61jLNQuhytTFmLDPHHIi8HEhvdFe79n145cIwNyKe5KZsGt+yc8CU2/zvGXuN/r5uDkeY08b8Cp15Fiq0joJ3ytqCUzgKDkTQTo6YIiK4+m63xH78Jdx1/2eKrOG902xKygiZfCszAe3PvG64q3OOy5G720YLDnwIHOkqTW9e+GAJ4o5+o0furpUqFaY8zmehgqKaQijZESThbrzUex/IQEsqfUELa2/twyAyA4RYffcghSpebpiIMSYIXfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521958f7-ab91-42b2-069c-08de7f4851a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:29:31.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pBeDZZeCiYSFW2g/RdMKC4gvCAeD93Nkuq5YVbUAqncUlSBSGuAhVGbNoU34Bh6B5uO+WhdmWU0RfMUVBPLYATYNB9/cspfbtRu34GsLRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9A6B025F739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,CY5PR11MB6366.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.usyskin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiBTdWJqZWN0OiBbY2hhci1taXNjXSBtZWk6IG1lOiByZWR1Y2UgdGhlIHNjb3BlIG9uIHVuZXhw
ZWN0ZWQgcmVzZXQNCj4gDQo+IEF2b2lkIGZhbHNlLXBvc2l0aXZlIGRldGVjdGlvbiBvZiB1bnJl
YWR5IGhhcmR3YXJlIGJ5DQo+IHRyaWdnZXJpbmcgbGluayByZXNldCBvbmx5IHdoZW4gd2UgaGF2
ZSBkcml2ZXIgaW4gRU5BQkxFRCBzdGF0ZS4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFJlcG9ydGVkLWJ5OiBUb2RkIEJyYW5kdCA8dG9kZC5lLmJyYW5kdEBsaW51eC5pbnRl
bC5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0yMjEwMjMNCj4gVGVzdGVkLWJ5OiBUb2RkIEJyYW5kdCA8dG9kZC5lLmJyYW5kdEBsaW51
eC5pbnRlbC5jb20+DQo+IEZpeGVzOiAyY2VkYjI5Njk4OGMgKCJtZWk6IG1lOiB0cmlnZ2VyIGxp
bmsgcmVzZXQgaWYgaHcgcmVhZHkgaXMgdW5leHBlY3RlZCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRlciBVc3lza2luIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9taXNjL21laS9ody1tZS5jIHwgMTQgKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCg0KSGkgR3JlZywg
aXMgc29tZXRoaW5nIHdyb25nIHdpdGggdGhpcyBwYXRjaD8NCkFtIEkgZG9pbmcgc29tZXRoaW5n
IHdyb25nIGluIFRvIGFuZCBDYz8NCkl0IGZpeGVzIHByZXR0eSBzZXJpb3VzIHJlZ3Jlc3Npb24s
IGFuZCBJIHByZWZlciB0byBoYXZlIGl0IG1lcmdlZCBpbiB0aGlzIGN5Y2xlLi4uDQoNCi0gLSAN
ClRoYW5rcywNClNhc2hhDQoNCg0K

