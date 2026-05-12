Return-Path: <stable+bounces-246685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHiKClagA2pL8QEAu9opvQ
	(envelope-from <stable+bounces-246685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:49:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 961BF52A99A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2DD3081AB9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8F392C36;
	Tue, 12 May 2026 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/9vyKey"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053042BE7D1;
	Tue, 12 May 2026 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622543; cv=fail; b=LAE/LKfnk3CofXKby6rJH0Rs8Vpadk+CYe4guE+fy//vtCHironZhbBXr40qJ8u/gTyNWDX87P8wuxpNuvVCZXPv5ZsyaENbcd1VRv68KAiqOghnzaoulmHjZov+CtIvoqJ6uhoEUfHg/VS7nW2DYdL73XWZsLU4XREjVhW8bO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622543; c=relaxed/simple;
	bh=zkDVys3o97yO6sPo5sBTZLv6WfZqMpIff2dzYmXAg8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BPIPPR6ca7+xQ+fxRtqbjXKiC0+blOAn+gQD7GBvV1jR2Q065cuPwuaP+TtL2UE0KdzvNZu5ZRzE5Nc6XCxixAhpv5q5zq3ptRq9dQePK3EDwGtJh+bYQNPMsQg6ydrT+5nRVAUPjDHTlfTLoBiytgo+2ZjYS4eI6p8hl7WIMRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/9vyKey; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778622541; x=1810158541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zkDVys3o97yO6sPo5sBTZLv6WfZqMpIff2dzYmXAg8Y=;
  b=W/9vyKeyR6lxWdWEaC40cknIgrZaVPsDKC2wCThmsk444p0XSrPQcbRm
   ltRO1kStgoUlSnrJu3Y/E290qGLZqZLoQQj0dZKT0hTU/uqRkljKr0xyU
   35x2emaVzGp7jsYj/SIjENd6iEWQ7jW84Llk2PKtAzq6DI3vCM1R878pq
   F15ul1QFLar2i8tUz7IThyOX4kt1E++PlmBWeJ/govVHjexFMebIbNGpt
   dkbB9K/tvhI8SlOTeweBQQkxlCB6c7/d2bA92klurKhYAQXlH4V/feUgL
   2C8emKTjTNtASKg6TCGAukgCjzX0kjLoGkL31a0BjIrC+NThVZFMo1ugO
   g==;
X-CSE-ConnectionGUID: 8xFWZhuRSui0JRJsnbbXSg==
X-CSE-MsgGUID: QjnzohiATMyXIPZlCrjzew==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79652600"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79652600"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 14:49:00 -0700
X-CSE-ConnectionGUID: kSrmjGd+S2OEyTFiw4VNNA==
X-CSE-MsgGUID: WenS8ICxSnKLkEFlSj9UdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="261386766"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 14:48:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 14:48:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 14:48:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 14:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jybJoPMbszZp+qCvX2SzBfKbFSoiS5g0OfIGuEz7UnGok0adBg3+vCsSUu4FtBkmintLPPe2VDqTizuklkXHQdbvflan+xs3Le0qwAVkVcB+qZUgZ2SHo9MMoooFhSnL/wxMTN4IJ0wZXz3cujKalHb5FyUOy8NeUk8vgK3MlGwiRZ2QgggTCCA2sj5wACRb97IB6wE6uJwIEcwXqOqwpXqj0On13FZ+5T1w5U/YO1TIi6oiHgKuWNQZ9Cqpn4jaz1+z8gAgs3r2FlWFYnEnnLl7swpVYZhCz7tH40kBTz7ovR4E47tac/78KX0IYmJMw5llLGHpsFBHMj+XWBQnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkDVys3o97yO6sPo5sBTZLv6WfZqMpIff2dzYmXAg8Y=;
 b=B0i1X9jMAXnDwnK/TBChLWFEnHtrt24hPyvZMxbdnHc12N5Lgtu3Rk6TfU+CiXgR/XTMInsptTpCyG+JLNKvBD115zC5ddjGZzF7F375lOTenUoneyGpauLZr2sGONZuzzgQnhLKOusI/loVFEA7IQSOmRj1UJUu1DPrslnGmWReN4fzUbpNuBZExX1wOEOMdKfqLK6fLll5Uu4zb4QjXn50M9FXAB8ejqn+qw1mwKazSyqP2ElrJ87EZ22uIs1/clCIhn5h6BwM7TGWsTdEztnIO6/FLHeV9pmxc6gsdWUPgrrFjESSm/2ctiITFP3Etz/11IwjWwmhqpgSd8Jt4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) by
 SN7PR11MB7492.namprd11.prod.outlook.com (2603:10b6:806:347::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Tue, 12 May
 2026 21:48:55 +0000
Received: from DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f]) by DM6PR11MB3018.namprd11.prod.outlook.com
 ([fe80::d5a2:c5ee:1227:9d1f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 21:48:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"clopez@suse.de" <clopez@suse.de>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "ak@linux.intel.com" <ak@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
Thread-Topic: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
Thread-Index: AQHc4leZtVFzGNxN3EuH83/xEfDKtLYK7ZEA
Date: Tue, 12 May 2026 21:48:55 +0000
Message-ID: <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
References: <20260512213719.20974-1-clopez@suse.de>
In-Reply-To: <20260512213719.20974-1-clopez@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_|SN7PR11MB7492:EE_
x-ms-office365-filtering-correlation-id: b204da34-c302-4164-ef9a-08deb07043e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|11063799003|22082099003|56012099003|18002099003|3023799003;
x-microsoft-antispam-message-info: 0LHZrPxBgoo+tTK6rz10kSwuNRKx0yr8hu5Ta1lb+2Aqy9v1oSNQE0ehf1LHLXmcNZi7IpKOj4OYTJKmwpHpAn01mb2wZazq4GB0bJWoq5pM6n5oA6aHw4ZDCKCp+fEsou6HXO3G3wWQOAlWeKzKE2wTbTMXUoCiKucy5sHEAl8eGy5GESFo+36Gndtv6FurR5oQHi+CNU2MttdGHLWT5KChqgZcpzZbO2yJW2H2iZ09rdp8LqFL4rJekryqXzQJHq+A/wIq4tc9Asv2cTvM9O6WwZeHrwp2PJf1UV7c+1retb9UISDQgBdH8OARIW/wk9SdOXp4NndBR9TtH0LvbPVaardtUud2K618+f/Lh+HmUJiiPzl5m4SmSRJXCqeFolMV7o3QwFe8dpHo4jIYkNKFO1f5VebwqF5A086AwA1iWQ8PGDE4Gvjz827E4YdDsxN3lurboEoC6nujK2sl2LU5UeJO4ND6ZcKads0BAUNWGVqC4GshZfsNge7mkQp71iEC0nUQJ5Y7pRB4iQnlbBbQeLrX20aWzZSQeyE/HiF7593o85qkjbS5PfviThPWwCMdm4p70Nde8/X/fWpJZgTc1Fkftf+IBiPUW0VJ1hadCXJKX6gKEawcz5xrehuT/VJDiJwpW93GiKNG5FnGXIOyA0yGp6B4th6c31Q7qsMUc4ghWyEGMDY7izNKnY1jRfXvLN+bZEbZjMnAPsTMnivXa0PgnMC7VphqvMGZg4/J7kMbjyL1vJlGo4VMXTeD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R08wSk15Smp1RDBKU09xR3FvZm42T1A0elZDUmx1VmR0cDV6aDhXVDdHMmtm?=
 =?utf-8?B?bUZ3alR5dEdycjg4aWJITVZNbExlQTBDZUVRd3l2b1pGV2svU3JmR0tsanFj?=
 =?utf-8?B?b1lmM0FvRVNod085NmgwMDR0aVpkeUNHM2tEOGp6NnN3NEo3N0dtcGpKeEU1?=
 =?utf-8?B?dDA0dHh6TWZMQjlybVduS2gxMUNiQk5wR1MySXlGd1VyOEE1bkdwNE9Zd0RM?=
 =?utf-8?B?UFdSampZN2ltRHZTMzdmdFBsMlVyZDdCdC85WHMxOEpBdkgycTdMdk9xTi9O?=
 =?utf-8?B?a3BIcjlGMDQxSzBPcjZQZ3ZPME5vVlhBSjl0ZXdjeGxuUDRpTEpDMEU3NG5E?=
 =?utf-8?B?OW9yRW0vbXpCL0p0UXl4clNCdmtiZHcxRWUvTDhPc2JBNVJ2RGpMUDh6UHNR?=
 =?utf-8?B?MlBzcVJ2QW42bzhjeHliNHJRL1lUY2hzelBSeGsvMVU2Umo0VG1hYnplanVt?=
 =?utf-8?B?SW43elhqQkZOT0hWVVVFT3BNeW9JcGY3TTBFQnNKdEx3dUFzVFhKKy9yd0pB?=
 =?utf-8?B?SnZHdFJtNS91dmU2K21ZbzZFcVNiZWNva0dicXVLeWxBdjIyT2RLZW11Slc0?=
 =?utf-8?B?OUE2aDZsM2plL1dlRlRrUWx4TmNTT3BGRStXRmVqVCtVWWpGeDFjMzcrT0Nu?=
 =?utf-8?B?dDk1dGFiOFlGN2c2TldIcE05VnlXNnBjQXJsdlZKOWs1NHowMHZoc251b1Ir?=
 =?utf-8?B?YWN2czVCUGNkbzBqeFBYZWZKUzQyaUtiRnIzSmhaVThRcGlLRkd4TDcxNkJH?=
 =?utf-8?B?VVlKTnZHZnhhUE9ra3VDT1BzSTh1QzdRS0FEL210WjA2S3R3VWN2TzBmNlo3?=
 =?utf-8?B?R0k4akYxdTRSM3pVaTNIM0JKQ0JJNUhPSmtEZW9NQXg3dXZTM1hHRUFldEZS?=
 =?utf-8?B?V28veWtNaTFxeEo5Mlo0Z05DNmhzTjZLc3RjS3VoaTNnKzlVRzYvTWZtZHBC?=
 =?utf-8?B?NG5MRTVRZnk2WEhzNi9tVm9FdXpZSlpoQm9Sa0NRUkdCdEg1ZEZNcEtib09W?=
 =?utf-8?B?V2RTL0p2WGl3MUlOaDNURGpuYXc3Q1VpejZ3aWV6SXlhVi9LMXZxUms0OUJP?=
 =?utf-8?B?R2E5WnM3SXVJNk01ZkJoYnhCSk9CS0x2R3ZEUGxXRitZMnFOTFowZzEwZWRv?=
 =?utf-8?B?M015MUxtSVdoRHZWVk1pbnczejRRTWxEem9BaXZQem5VT242MURSQjZuUVp5?=
 =?utf-8?B?ZjUxV3JPblNFSWtSZzcxNW0yRUFQVmhldEpvb2ljTVNMT1gxTkdDTE9uSTFv?=
 =?utf-8?B?Rzl5WHhYcXVnRFdIcHIvTWdwWTRaY2FLVzZIQ2hERlNpY040ZDUyZ0RIZk14?=
 =?utf-8?B?U0ZNTCsxQTdVaDJabmxLTDB6bGRydEtpMElqaksyZEhLeWZuOVhvRFIzc0RV?=
 =?utf-8?B?ZmdOY05vVjBHclJxczlxQ3JIV1NOek51NEdsZTRpZHJldnBvaXZjYXFIRDN0?=
 =?utf-8?B?ZWQ5RTFHY2RjYy9BaWlUd2MyRzdDY09KeXJIcXZ0SEh0WE9IcDFVSkdXY21O?=
 =?utf-8?B?RE1WWFVhNWtYTkpJdjU4SWVEc3phb3pPcS9RdU9xNk9kSjlEWk9CT3FXWk1Y?=
 =?utf-8?B?WHl5RlEzei9TWUN3cUxhbW55Q0VvcjRla0tGNG96T00reEVNd2VXMDRvcytq?=
 =?utf-8?B?UzlHM25LdTBOR0Z1TVZ0dHdtWmdRRDNER3gyWE91UUhJK1QrU3dWZG5xb01m?=
 =?utf-8?B?UlNHMm5oU2NmODRCZkdBbVI1UnBDY3RoYzFSd0FkSnBUN1dLd2dEVnRQWHc3?=
 =?utf-8?B?aWlOMS8xbksxQjFzNWVKSFN1UCs4d1lCZVNJc2UvbFJlRGp6TXgzbEZTV3hu?=
 =?utf-8?B?U3I5MUlLNng2Y0lBc3BEUGkrNWJ0QkZZc05DWC9xLzVLWWlrRVh3djN1TkxF?=
 =?utf-8?B?OXJYYnBVWUljVzMvUVczMVIxQWQ0a1NZU2llaWdodFB0czQ4MU5ZWDFiRU1y?=
 =?utf-8?B?Y2h5ZTdoL0pOWmFldmhTemYvY3REYSt4aEU4WXh1RytuZ1FQODh6Rnk0Y0pP?=
 =?utf-8?B?WndPSXNGMXdpUkdXNmF1empsS2hVYW9EVmt4UFBTUitsZTNjTjN0cHlFeWJM?=
 =?utf-8?B?M04wZVp2SllrR1o1ZnFiVCtjU1lIdEcyK1ErQjl1eTRtb1hwVUQ0dzZQTDNP?=
 =?utf-8?B?RGIvd05tOVNxcXZPN0VYc0hDdEllbThqWFFmd3FXaUNwb0ZkRzEySEdpTGVo?=
 =?utf-8?B?eXBBMUcrTDZyK2c5WW5sSmxoU25wSmFCREJHODJONmVIMnZoTEtsWG1DNEVH?=
 =?utf-8?B?dlErREMxa2VQMTVzN1dpSTRMY1kzVkRReHNJN0owb3E1MHE1dzNuQU4xVHBs?=
 =?utf-8?B?eGVpSzI4ckRodVJUSzQvRE84QVIzTEZtVjVnK2FCZHR5T2JGM0FOUmVkUksy?=
 =?utf-8?Q?a2BoytN96ltzFUT4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00E500F6343B9F418321C805F9949039@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZlPblXBzoVgXiQh9b4R0KCIqqOsQDXkEkMWkEkoIJZYAas/3rmNTQ1MBg5k8X10TUVRkJKdHMYhf9er4czcWYwUbK0/54u5lWKICWHhw2vCi8x+Y8xNjTqm2A5X49cvxSfxAv63dITD2gA0cNKMePsf9KSMq+q9I2oj2u3I+ZqLQREVHUk6V0aEikcYzDQ5MiklaUqx+Xm8PzCHEfwMCxFYI9UFNK4ln6oIvgb3esUPi58laGPVIOD0QunwDzmdKd6RvFgDGScTftIK+dC1Fkn5O1vpqtQzFccoyVpPZWLLPFv1WwOY4t8gCvx8IDV0KAfDPj24S4EJK/kwjY/N+cA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b204da34-c302-4164-ef9a-08deb07043e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 21:48:55.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neiOCVKPPvy50+0jWI0D6PdxQgmAvMpbtuMHINTzZ9c3ONlFI9HBnhqlbPmtPhBonMdn7IQTyGz7guBCXq3tOAIUdwnRCzPgZPHrtoAYlLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7492
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 961BF52A99A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rick.p.edgecombe@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDIzOjM3ICswMjAwLCBDYXJsb3MgTMOzcGV6IHdyb3RlOg0K
PiBJbiB0aGUgeDg2IGFyY2hpdGVjdHVyZSwgMzItYml0IG9wZXJhdGlvbnMgemVyby1leHRlbmQg
dGhlIHJlc3VsdCBpbiB0aGUNCj4gZGVzdGluYXRpb24gcmVnaXN0ZXIgdG8gNjQgYml0cy4gVGhp
cyBpbmNsdWRlcyB0aGUgQ1BVSUQgaW5zdHJ1Y3Rpb24sDQo+IHdoaWNoIHdyaXRlcyAzMi1iaXQg
dmFsdWVzIEVBWC9FQlgvRUNYL0VEWC4NCj4gDQo+IFdoZW4gaGFuZGxpbmcgdGhlIENQVUlEIGlu
c3RydWN0aW9uIHZpYSAjVkUsIGNvcHkgb25seSB0aGUgbG93ZXIgMzItYml0cw0KPiBwcm92aWRl
ZCBieSB0aGUgaHlwZXJ2aXNvciBmb3IgdGhlIG91dHB1dCByZWdpc3RlcnMsIGFuZCB6ZXJvIG91
dCB0aGUNCj4gdXBwZXIgaGFsZi4NCj4gDQo+IEZpeGVzOiBjMTQxZmEyYzJiYmEgKCJ4ODYvdGR4
OiBIYW5kbGUgQ1BVSUQgdmlhICNWRSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IENhcmxvcyBMw7NwZXogPGNsb3BlekBzdXNlLmRlPg0KPiAtLS0NCj4g
wqBhcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyB8IDggKysrKy0tLS0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2NvY28vdGR4L3RkeC5jIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCj4gaW5kZXgg
YzhiOWU4NmQwNDg4Li5hMmZlMWFlMDE5YmQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2NvY28v
dGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+IEBAIC01NDMsMTAg
KzU0MywxMCBAQCBzdGF0aWMgaW50IGhhbmRsZV9jcHVpZChzdHJ1Y3QgcHRfcmVncyAqcmVncywg
c3RydWN0IHZlX2luZm8gKnZlKQ0KPiDCoAkgKiBFQVgsIEVCWCwgRUNYLCBFRFggcmVnaXN0ZXJz
IGFmdGVyIHRoZSBDUFVJRCBpbnN0cnVjdGlvbiBleGVjdXRpb24uDQo+IMKgCSAqIFNvIGNvcHkg
dGhlIHJlZ2lzdGVyIGNvbnRlbnRzIGJhY2sgdG8gcHRfcmVncy4NCj4gwqAJICovDQo+IC0JcmVn
cy0+YXggPSBhcmdzLnIxMjsNCj4gLQlyZWdzLT5ieCA9IGFyZ3MucjEzOw0KPiAtCXJlZ3MtPmN4
ID0gYXJncy5yMTQ7DQo+IC0JcmVncy0+ZHggPSBhcmdzLnIxNTsNCj4gKwlyZWdzLT5heCA9IGxv
d2VyXzMyX2JpdHMoYXJncy5yMTIpOw0KPiArCXJlZ3MtPmJ4ID0gbG93ZXJfMzJfYml0cyhhcmdz
LnIxMyk7DQo+ICsJcmVncy0+Y3ggPSBsb3dlcl8zMl9iaXRzKGFyZ3MucjE0KTsNCj4gKwlyZWdz
LT5keCA9IGxvd2VyXzMyX2JpdHMoYXJncy5yMTUpOw0KPiDCoA0KDQpDYW4geW91IGV4cGxhaW4g
dGhlIGltcGFjdCBoZXJlPyBXaHkgc2hvdWxkIHRoZSBndWVzdCBmaXh1cCB3aGF0IHRoZSBWTU0N
CmVtdWxhdGVzPw0K

