Return-Path: <stable+bounces-158968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A19AEE1CE
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552781896775
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955028C5BD;
	Mon, 30 Jun 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FR5+5ncO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE56239E6A;
	Mon, 30 Jun 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295661; cv=fail; b=FTtTSYXYpoZ3++fTuKBWm8HOIpRjE4YgOU3XOZKxZ0Ih0qUG680CU+2eEFO49TXIo4dJBYw6xLaBTOsscQLRfN7nxVCQpHUXCRIGamfkqCspR2L1bsdsyqAKuQiJ1yQT7VN0jKdgKJIT95SfXe7Mi5SIMVcpQKT0MJNRWvRVhAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295661; c=relaxed/simple;
	bh=bSnpiUVA7fS4AUVV7DnsVc8CWi+XZRO19FLxmGs2s+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sSkJCfDWJHumRk/cN5y/SHfivplyHiNbVjHAXA8VDlUJ46JQgtj+6MN1n0upmGfiooeZJCnqG4eQMG6CeCt6HBqGh2mED4M46HMSS1qgvaboG0SwBs1g7A0PeM73iD7OBpRKfzl8hqoSfubblKK+JOdF21WUbqaSUJjk0UgDl+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FR5+5ncO; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751295660; x=1782831660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bSnpiUVA7fS4AUVV7DnsVc8CWi+XZRO19FLxmGs2s+U=;
  b=FR5+5ncOknhlrkg9ok+X1A7qfrS/K1yFYIEVHXhbZVK4d84EHMinZpmo
   sIvxQ8iAGa0QTV2zEhy6m6iXUiUoFiVfW3mnoI3ug1Md9ZoczsW791yZg
   abAdEeYu4xjg3zQFPNVA4qTInGGDkRzCpB1qxI1eiGIYHVzO+rEnm0Wvm
   lJZqzDkvjCWCwSfzDsRmW4X8NUKGcVI3jbCMeOJ05D01kala8U5vvI4Nk
   1BPg1qPrd83CcEjdUVSxMcAP/tSE1KQCNgy5sLdmVxcd39by52Y9XWjaK
   4MfmF64tjKiiYD1QRjKctrXprSXRJLUv59GuPxJcZm8V2T2kylGul69ta
   g==;
X-CSE-ConnectionGUID: REv6TM4CRHOL4SdgJpI36w==
X-CSE-MsgGUID: kkw5XxyiRXil4QHfYU5Rlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64219910"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="64219910"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 08:00:59 -0700
X-CSE-ConnectionGUID: d65aChS2Qpi5rL/JOwxfcw==
X-CSE-MsgGUID: jXwhrd10TeuSo/L+X/CWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="157761102"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 08:00:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:00:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 08:00:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 08:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw5HRSFYsiMxkYkDsKBGqUMu7fDGIE4hbSSHz/vcZ0o5SSUu2jb/FArf7G5+hCFPTzBoEjtzwnip6RlcD/HHHxdUXOBPm4eZX9+Pe/LQfo2lK+Vzd2KFnUOkRDmdYKbx/uV9NsaesNobysAhYDHTHiHdqcmsbZnJnqE6SaObt5Z9R9Ct2gFnK12mtug5j1NbR11Rk6C13MuXV3Jz+iUAIz+w6hVmyCZa43ZYGrTtnn29n0QWYqjhndF+84oVDu1QxbxWKfISWFdtT6GM4UGhVmpEraoPkpL8eOf0eGK4S5XI0J/afoGyM0iLA/muCxGFfEOgQUBtx2/qFstEy/wCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N2Or24G1+SgSznY8LXDHXhKg+sDyKtvhNPwZol4Ovk=;
 b=HGnyq4RgsfRgTh+hDFHT0sqdhyr8gdHa6fIersFJVGxXl5/qDeEIhUuP50mk1Yxe2XvAVkCwSgQ/wr9Rv5qkUjcuP3KbCD9jMO90XXaurTTgoYm/3N0emwcB18TQIZYyVO8WY9T46kiZamMtXWbphdMo+8fBuXYzmPDt8KIMt8p8PHeH3Hy5LoZV++TLgWA3B4TQpgnqVaKlfZbWSBm7Nv4uyXrl2y8N3E1UuMLYlwYdKk9wSZ7zWc7ckjWjyD4ckAxg2PiiN8DTgbEWIVdFeLOFvXpyR9rygzfvLQL+oufqFhYWzhuQbQ9ySXZp32I8mc0yJut4vnf6AWdtMuCy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 15:00:13 +0000
Received: from IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::68b8:5391:865e:a83]) by IA1PR11MB6418.namprd11.prod.outlook.com
 ([fe80::68b8:5391:865e:a83%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 15:00:13 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, "De
 Marchi, Lucas" <lucas.demarchi@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "thomas.hellstrom@linux.intel.com"
	<thomas.hellstrom@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "david.e.box@linux.intel.com"
	<david.e.box@linux.intel.com>, "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v5 01/12] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
Thread-Topic: [PATCH v5 01/12] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
Thread-Index: AQHb56QsZbgAspdI/0qZKBKDkkrWd7Qbc4kAgABWn2A=
Date: Mon, 30 Jun 2025 15:00:13 +0000
Message-ID: <IA1PR11MB64183C7CD3EE5D532B7165FCC146A@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20250627204321.521628-1-michael.j.ruhl@intel.com>
 <20250627204321.521628-2-michael.j.ruhl@intel.com>
 <e860ab9b-4f75-b6ef-3b82-f4e45f478d03@linux.intel.com>
In-Reply-To: <e860ab9b-4f75-b6ef-3b82-f4e45f478d03@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6418:EE_|SA1PR11MB6758:EE_
x-ms-office365-filtering-correlation-id: ea0ab54c-0def-4244-2599-08ddb7e6d136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?41CySq50KEZ+eVf/z5IjbNB2FwnHhUFU+qrXZD/rPp+FA2VT9hc6GCVTGX?=
 =?iso-8859-1?Q?tuXPv38Oke9GJ8nkJrI6aC74U54+c6GivgYtiBjyr/OZrKy03SrVSujN1O?=
 =?iso-8859-1?Q?GrEUfDJtlfHpVm/M5+d2Av1N34nHcUyE2TgqY+0Zv6hlGdiIt069VLhkLB?=
 =?iso-8859-1?Q?lyn8OGyWeed5pguKMW+NS6NzgwyKK14w+vM9hJfmH9aJJid1zXfqqGR9Yv?=
 =?iso-8859-1?Q?iJcEkraXucBmAfbFKeJZcPikQRJISVrxIubNBkGGmaVNS9X5Et4aur1eVL?=
 =?iso-8859-1?Q?suidOzq38x4FTj/JqFVmnZ4JckMJOkM6FVIWyc6tU6XTysjN0+GVlOXAAt?=
 =?iso-8859-1?Q?nZqK2sCbMMcQrIj0QK/XY/Id/P1yH1C5yN+MS0UAtiq0YPrVHzybdlW6BX?=
 =?iso-8859-1?Q?/Ck+3j5COtxGJAgzqqymbbyqaqzlL31erLn8ZSRCHtx+/OAyjFQB4M9rTj?=
 =?iso-8859-1?Q?on2P1O6tKy3An1HtQVqiLiO+ONfWDv/ucRAFJnXGAikhxE5RnPHYJUZumT?=
 =?iso-8859-1?Q?YymxqiM8e6E+yPdbOJyfUpusbblPZrJe4Jfc/bGz/midg4reVA96DXy1C6?=
 =?iso-8859-1?Q?urz/onhODq95AAkHCsx/to6PMKo7zokYVHpkjF8pOOnA/SS1xU7lzRrZYu?=
 =?iso-8859-1?Q?05QNyP8yxAp+gckrNVZmRPtAAiG+Jd0Az62X8iO21sfDC5FTZ7/E5KMFwT?=
 =?iso-8859-1?Q?CI1+6D0aazWaI1rHRm6Bv1FpMUK7/3t9dqkLIy39Fru5mvgTLOI1tXj+io?=
 =?iso-8859-1?Q?7oL3ZTEwroaOzX/6ZyLDxeNtRBjcMNjMS0ePy/5Vpe2NfhWpe47sveiwWt?=
 =?iso-8859-1?Q?9WaD15fvUgw2kOiMdy+nHMZtFTW290KSEZUHnPiskhgg136nv60uctybdh?=
 =?iso-8859-1?Q?ey8fCjiRop3+LZ+Bus8mzzItKnOyED3gScQPt+UiFpNhRs6cismi2ZEz6j?=
 =?iso-8859-1?Q?bcInOTJlzX+TwIo8TvKpJwUFscry+yY8ruhgYTIziypaDFOkTCvdqZqgTJ?=
 =?iso-8859-1?Q?z9rtp8jWbq4GGIT/dyjgH7qWDLo+j2fewq65gbevxh7NBFi2CpmRfD5AbW?=
 =?iso-8859-1?Q?mzWsGHDH/zXERiMbIS8tzQJ4MVzZe90kWlrwKpHq4OnBfga4LdNoZgXwkn?=
 =?iso-8859-1?Q?jAVQx9+Pa/5nYHpqya0f8umMbfPNTlrFYSniRXHMJiw+M8oG/Umk5cDP+k?=
 =?iso-8859-1?Q?2QJ3wE0XbjM6sS5yd7WJ2haFNeYWMl5X8tEYQKQVL+TXNFnZA4qrht3scZ?=
 =?iso-8859-1?Q?RV2rHfZUnCKA1ZoBzlWBJGWxIiyLmzktcFF7grdWhy7aMFWz3Hr37QPDwp?=
 =?iso-8859-1?Q?cDm3d/zWuw+pFkTKQ92pJ6iPOYAB7K/dSwxGcIYSjKMDPJH2YbolNXjsRN?=
 =?iso-8859-1?Q?6thdMfIdactze4MaRybPF8zqxhwQxnBW6VmZSdZC+0UEXLcWJ/SYGwl5Yl?=
 =?iso-8859-1?Q?FroiTpLua6cEpV9gAmjSgq71kLlPu8egU4D3UEWXTi9DNlYIASc8MmKJH+?=
 =?iso-8859-1?Q?Z+ZZBxJEeMmQxb7hqVITACuir/sq7ZKuboJjC4YFxe/FdoZIZ0lUnG7QB4?=
 =?iso-8859-1?Q?gkFe02I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6418.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pvPPN61oNGfvFrkvphoH/UrNc+fBE2IFe3UXn2tX5YRAZuUFUrhKCDCzBL?=
 =?iso-8859-1?Q?9JuLbZ0suXS2noZrUhpAOxYxtLjg1vtK+1RXmTUJVboxh0nvO+vrD+ScOH?=
 =?iso-8859-1?Q?KMtIlR0KSho7IjFzYH2EABk+EYSq3hMeS8ETcS8lr0nC57pD0W/oTYYKie?=
 =?iso-8859-1?Q?N2kW31UW3cNRSa8b0cJVvWrUho0GLQhBeNqo6ds/u9vZwD+rsUeLm4gBiu?=
 =?iso-8859-1?Q?QxRu44X9B35q+4wvqaoZEKcKwQwRyMbXqIsp2GIfVXr+HjTPf1MumJeHrx?=
 =?iso-8859-1?Q?CRRFnpgVBh9vvk+xzjEFJyza/ZmuZpIJ717Z8l+fni8fG4nbgtI/uKtFsV?=
 =?iso-8859-1?Q?rpi5OIv0mQHAQE+2teA3rvA2aG5B3PWPDCLpQhIDACdhNYEvQC7Dehy5gs?=
 =?iso-8859-1?Q?64BW2tIE/vytXG3hNWTyAG3IprxN6jXikSc8epPBUYvjm7x+5/mt7qglC7?=
 =?iso-8859-1?Q?CopneUraBSS2CJlEdQ0IT45lAu8OPMmsLH9AunmYmZpyL6fTNnjwRKvA3R?=
 =?iso-8859-1?Q?c8vACK/JLSo8/AygAjr6MvClvguPici0aPTx8YUjqaVBI4LYJqHkT0eicO?=
 =?iso-8859-1?Q?VP5umGQnDl4Gs2XZYfXn5Lp5O2bxE04FjxS7L0fJL/rRhdJSLBQUNbqdtQ?=
 =?iso-8859-1?Q?36IMYJs5sxKYg2rncK8YErmCG6uuxqU0nW/kO5PcaMoy4jBCd63Sdjhetk?=
 =?iso-8859-1?Q?MHMUWYYaWeQjUUhC5szqp9wOcSoQGc2TTOq/6RXacOgtKFF62GJ8Ipum2K?=
 =?iso-8859-1?Q?DThbUa2hDNyU4OzY36OCpk9St+F6HNv+BgnTkLdUYYO8lmsH58OZNLOC5B?=
 =?iso-8859-1?Q?4Op7JhR1Os3GW2kGA+xnc/7AWRux0sXQvUzPt5FX7va02tr3uy+0eIq1yv?=
 =?iso-8859-1?Q?tQ19kxL5Ouo9koeKTlpMFatdCfr7DxnCatl9VHXRndTdG+lxvLTJxUS4Fp?=
 =?iso-8859-1?Q?RIqOXxPljIsC6vXhbMPWs4zmQb8ZtWp0I7hOfC7WHVeSE3zV/AbEqckkBt?=
 =?iso-8859-1?Q?0HwS7SVCexclJ/FRovCmyTLdSpjFnHJrkLNUF89Qths32h1Sa2UILXIO43?=
 =?iso-8859-1?Q?ZA0nGkCv7yh2Gi6KLTYCVLOx97iwZ7JA2uCcqfYQA0D4pZvZww7IouCN9D?=
 =?iso-8859-1?Q?f4riWMsusiRQLyYE0W8okUDxVuuxfOA8RcxkrhbWNQMhcJPEeREwevTyI9?=
 =?iso-8859-1?Q?9HI0jCm9Aa9A+FqrFoI4slDBwrl6Exiq6Jfb4bZ3xiacbmCSL7iEjQXzZT?=
 =?iso-8859-1?Q?QJb21Xiyx/tMLgET0aU9uTYzMBMcAwoQyBlnh24RdnmhKzcOjFeo0zjGXH?=
 =?iso-8859-1?Q?1DZrLZZcwEEREiKPGW1D0Lg9VfUUJxrZoafx1/EeTXAZLCJr1xwIGTs39O?=
 =?iso-8859-1?Q?PJQtFR2x7x8hg7mhvTS+JMQxAJdiOihe2UCqqG7lsbQiAVHhX2UXM04hGz?=
 =?iso-8859-1?Q?8G1iDh2PIONJ0Y8MbBp9UATSlAhU80Czk2D8jsnIWZCvrcVuMnm7E9a1PG?=
 =?iso-8859-1?Q?aZe+AQ5prWRZSEKPjEtF0xaXHY579I3wmP9NwEUm5cq7VcPYC760nQpgB9?=
 =?iso-8859-1?Q?0ClTTHvn56ZGIOsdR2Ar0ElhiPlhfyol0U8qPXOfnIsKhOUCoa2cAZNTiD?=
 =?iso-8859-1?Q?zLuvsHAQPvx26omUbedTW+DExw+CYxJTM2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6418.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0ab54c-0def-4244-2599-08ddb7e6d136
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 15:00:13.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5GRWFJkeeIDapQE+Dc6icJPc2GHSUPbTL7uxTFjuSQR2lbPRDu1teEBPMzFB6cyKAn8kkFB9bcNGqs5Kjlh6+GM7jNxpJOCjTEUbaKlUdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>Sent: Monday, June 30, 2025 5:29 AM
>To: Ruhl, Michael J <michael.j.ruhl@intel.com>
>Cc: platform-driver-x86@vger.kernel.org; intel-xe@lists.freedesktop.org; H=
ans
>de Goede <hdegoede@redhat.com>; De Marchi, Lucas
><lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
>thomas.hellstrom@linux.intel.com; airlied@gmail.com; simona@ffwll.ch;
>david.e.box@linux.intel.com; Upadhyay, Tejas <tejas.upadhyay@intel.com>;
>stable@vger.kernel.org
>Subject: Re: [PATCH v5 01/12] platform/x86/intel/pmt: fix a crashlog NULL
>pointer access
>
>On Fri, 27 Jun 2025, Michael J. Ruhl wrote:
>
>> Usage of the intel_pmt_read() for binary sysfs, requires a pcidev. The
>> current use of the endpoint value is only valid for telemetry endpoint
>> usage.
>>
>> Without the ep, the crashlog usage causes the following NULL pointer
>> exception:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> RIP: 0010:intel_pmt_read+0x3b/0x70 [pmt_class]
>> Code:
>> Call Trace:
>>  <TASK>
>>  ? sysfs_kf_bin_read+0xc0/0xe0
>>  kernfs_fop_read_iter+0xac/0x1a0
>>  vfs_read+0x26d/0x350
>>  ksys_read+0x6b/0xe0
>>  __x64_sys_read+0x1d/0x30
>>  x64_sys_call+0x1bc8/0x1d70
>>  do_syscall_64+0x6d/0x110
>
>Can you confirm, if this was possible to trigger only after this series
>has been applied, not with the current mainline code?

Hi Ilpo,

I somehow got the wrong fixes patch.  It should be:

Fixes: 045a513040cc ("platform/x86/intel/pmt: Use PMT callbacks")

The issue occurs before my patches are applied.

Does this answer your question?

M

>--
> i.
>
>> Augment struct intel_pmt_entry with a pointer to the pcidev to avoid
>> the NULL pointer exception.
>>
>> Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
>> Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to r=
ead
>telemetry")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> ---
>>  drivers/platform/x86/intel/pmt/class.c | 3 ++-
>>  drivers/platform/x86/intel/pmt/class.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmt/class.c
>b/drivers/platform/x86/intel/pmt/class.c
>> index 7233b654bbad..d046e8752173 100644
>> --- a/drivers/platform/x86/intel/pmt/class.c
>> +++ b/drivers/platform/x86/intel/pmt/class.c
>> @@ -97,7 +97,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj=
,
>>  	if (count > entry->size - off)
>>  		count =3D entry->size - off;
>>
>> -	count =3D pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry-
>>header.guid, buf,
>> +	count =3D pmt_telem_read_mmio(entry->pcidev, entry->cb, entry-
>>header.guid, buf,
>>  				    entry->base, off, count);
>>
>>  	return count;
>> @@ -252,6 +252,7 @@ static int intel_pmt_populate_entry(struct
>intel_pmt_entry *entry,
>>  		return -EINVAL;
>>  	}
>>
>> +	entry->pcidev =3D pci_dev;
>>  	entry->guid =3D header->guid;
>>  	entry->size =3D header->size;
>>  	entry->cb =3D ivdev->priv_data;
>> diff --git a/drivers/platform/x86/intel/pmt/class.h
>b/drivers/platform/x86/intel/pmt/class.h
>> index b2006d57779d..f6ce80c4e051 100644
>> --- a/drivers/platform/x86/intel/pmt/class.h
>> +++ b/drivers/platform/x86/intel/pmt/class.h
>> @@ -39,6 +39,7 @@ struct intel_pmt_header {
>>
>>  struct intel_pmt_entry {
>>  	struct telem_endpoint	*ep;
>> +	struct pci_dev		*pcidev;
>>  	struct intel_pmt_header	header;
>>  	struct bin_attribute	pmt_bin_attr;
>>  	struct kobject		*kobj;
>>

