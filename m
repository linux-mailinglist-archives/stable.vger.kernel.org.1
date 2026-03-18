Return-Path: <stable+bounces-227075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIdSBtqsumn9aQIAu9opvQ
	(envelope-from <stable+bounces-227075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:47:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7B2BC497
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAD79300232A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06923D6CA3;
	Wed, 18 Mar 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xqxba5EF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D13A7F4C
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841619; cv=fail; b=CqINtXp6dn7etz/AEl5Ma/Mj0YpTSG/mWjvdSz+YUwKUZ+n5Z55YTR2w71fbjkt0PUMXTn4+B1AAjb8rGXPzOQQw/DLnQ8Hhl5lnR5R7lrQtbBqjlRPbk+fLRnWKXT1AT/M45N4FVIJ7ORiU8yRdAF21opKok+mO08FgZ7GHcq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841619; c=relaxed/simple;
	bh=3Gl/cQRAzEMMtd7LQjJ8zd/n57zF5DUBiPu/HaY7u3s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qBcYdXHrBMnSiVtQfzTEIO22jMkotD9PEF3LGVScWYUjOoiIAKHCmQqs4cA6gl4sEWYThcHu1oEOh5TGpHzTN7zxS5Nd+qM4XaYAKfs7bB8LXn0GhyAkP0cfYTBvDIdE7Ri1nW92qCLh9HfjFLe4kOfYzixNmel9P0lREshqPEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xqxba5EF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773841618; x=1805377618;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3Gl/cQRAzEMMtd7LQjJ8zd/n57zF5DUBiPu/HaY7u3s=;
  b=Xqxba5EF0u/n0B6uTsLGf8egQo87MzC9sfH/G21paNIrPGZ1zPyxWzqf
   QhY8dFdbVgF0fxAVLv82VZ8A/wmcIEALvc2pgtiumjP7xjG/rd3l6BtSi
   pRG8u89wD6GsLowQkVCZzk0ZSd7DX+6nwrIySKzENLS7bvOE1oDATZl8I
   55wOt1zoOzPC5zZcdUE2vrZhxOUHUFykHHj3FOjAZOMvqtG8TLFR1FiLC
   ubSA8UISpcveIMv3RP///A3yklkCSXi0yqAM9LXcXWXZLTug/21ZNNzNP
   p2P/HeXKN27IrmRqn6VSI7+aruCHlPW24TsosbFtNP8/OQAbDMrqD/ci0
   Q==;
X-CSE-ConnectionGUID: HTfM2SQlRn6oaNsfEeVGog==
X-CSE-MsgGUID: YVEIUemJRvmiH0B3jnR1KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85208658"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85208658"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:46:58 -0700
X-CSE-ConnectionGUID: k17ZnBg7TRuyEPC7C9a9ug==
X-CSE-MsgGUID: pRWn6wetQo2eskUn5NniCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221703888"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:46:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:46:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 06:46:56 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 06:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC+jNX0wRT49MBhc4M1BAEY04jbgAt48r59ijBWdHwEK6JfLeVUwTLLN5R1xFL8OUifvF7HkNKqyx0F1dGsRNvIpPiPfcuBcKETzFsEcc3f9tUXYiK8NtqowO0ZP3tU90Yw4gcAAuXHfRYWTvvSTOkjS3MwmiATX9J0Sfr7D4vY8TNCkGif8DitDA+zB41yEAauU/AFv/3qQaV/P2KNPBZKewnqq3R9kcyd4Ljy+2QMVWUQDtX5PDgQihKHf3iWw9rM9bi5Q3Sm5CMiz77DwdMzYWXZG4ZLdLE1P0+syRljgpKHCR3CZEb+NKcjqwFO5J93K+iSvNjewa4mGfZFLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gl/cQRAzEMMtd7LQjJ8zd/n57zF5DUBiPu/HaY7u3s=;
 b=gkatdr3hqQTuci7kiUJL5mCp8rbFNmSHZH3VxrC5xKR6s9lcYq35RLMhpwyWUQWw17WwVcugXa5eXXwMoLZYhNHGDHOBSDRa1dhjJOVcK0H8IX6JrpbWk1JkIfxeVSbosO58IPBg6j1PNhHvUhvBiRGxQBGW43TchyzocNLrQPRDi/9emJL/2q43l2GUEafeY6g1hc3xy3/N6iSffR4SPdm0dh5uZ7isFIACoubu4zsM4KsH0delksHb2OKvx+cBPIqVvc/WBMizkHGXZibWmxc+IFhuzMbn63ALF8VEkEriLOVyf4yhkvE2IhF3y1DBni2xpkuwRvmnszHSchnpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 13:46:53 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 13:46:53 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "tursulin@ursulin.net" <tursulin@ursulin.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Nautiyal, Ankit
 K" <ankit.k.nautiyal@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/i915/psr: Write DSC parameters on
 Selective Update in ET" failed to apply to 6.19-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/i915/psr: Write DSC parameters on
 Selective Update in ET" failed to apply to 6.19-stable tree
Thread-Index: AQHcthGJIpxfZ4Jws0e/mWmsprc/WLW0TzWA
Date: Wed, 18 Mar 2026 13:46:53 +0000
Message-ID: <abc8eb61525225dd875f49b7fd0bbc5265b97b24.camel@intel.com>
References: <2026031712-strep-autopilot-0999@gregkh>
In-Reply-To: <2026031712-strep-autopilot-0999@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CY5PR11MB6317:EE_
x-ms-office365-filtering-correlation-id: 4bb569ad-a32f-48c0-a354-08de84f4d014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: u3FuoJFMBCAdV9ZQdh1EJ3wTzkqwNbvrf3K5t9zealqod//G80dbR8G5EOL1HH9kSmU9v8xPP3QjIT1Ud/co/1wTQS2IlOOG/yVQY0w/yS5oRarRIV68jdz7EmNNq62o4LGCXvtVe1IW3ngL3XLwT+zNTO6bmXbk2KxbQvm2A1LxREufCVujx9TSOFf1UCf2x8DgG2nkqMCIRE+YyF4Zglf9V/dvmFkDuRunH0VTdlySCaXId7YO878KMkREHZSgqHyilQ0mS5cbxzWh1835oAMy+ODybwkZrXkaqGUQeux1QmdFHDfq/bKK4MIv8GtoYGpXSkvn9lrY/k9+Qkt0Lc0L1TWky39Pglis/ZQaoXOpLZmCVu4R8+MevzQAzPIqkyy+fqdZojybS94J293yuOHxwOJ3Xh5AlB6i9qqDrQtL0DH9+ECmXDMqN+UG3/GIMa8ccBzzfHm8ny7mToh6XoTY1nw2SFVb80AV8+N2CeVYBwPGpS1iLaOju9yy3ZK7v2w9SvPvxZ4+NavCbuXmyt1XcXoLJab4zuPH7RZj/5mnru8SliI4ppeN3KD5nURBLA8QwTR/aMI6ZJINtbtvHaXtjtli/nyerzneyiyq31u5Y9eyh6wZfR/+TOi481SwIl0dQJlvAfA7bQsp8qrUMT0MVN2PDc4NswGB0NlT9luJ0hmzfCLjF5FgEkLVEMbHL1K+/Xde0/hY9ja+aV19QyRl303oOmh9b4mkGusSHdy6DE/gaZdl0Vxwe6x3a2Zk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWNmNGlibVhuOGVxMnBod3dmRW9aeXZoWUlQTmF0T1U5QnJFeFU1aCtqY3FX?=
 =?utf-8?B?TXYxWUVuNW1xVFVWT0VwY2F1d3NQdy9KNVZydkRxa0JmbzR1dWp4dEk1OTMr?=
 =?utf-8?B?dk1KcFZOR3RJbzMvdkhEcFZzUmhBZEtxZC9Yc0tZcmhGa1VHSngwZ0pTZ0t0?=
 =?utf-8?B?bmhMNEI1dDF6MW9RWStZa1UrZ1NyYzhOTnVlbVdGOVdJL0tSY2VHRXppVU5r?=
 =?utf-8?B?R0JiVVNEY21tSEwrYk9Wa0NlOWhzU1J2dDcrTWNtc050WkEybW9pK0c5cHhr?=
 =?utf-8?B?UW92SHdkMmNpZ0dEeEo1K2pkVnBMOGhJa3hOcFNmNmxKN1FMQlg0UkdkR0Zo?=
 =?utf-8?B?VG5Mb2hweloxZmsvV0VXcGRBbHVRV1llSkxjY1ZaSTBJY2Ixald6NGtOQmRH?=
 =?utf-8?B?ZVNEelAzSEhrclFsa2VFaEhlNVcvMmJDVG9pV0lQM2hnV0l2NWFWM2UxQWd1?=
 =?utf-8?B?VUI5b3dpYVhnZHF0VE4rZk9NdEhweHdsdE9kcFNjdTlqaTBSdTVNcmRPejFp?=
 =?utf-8?B?S0JOK3BiZjZBejI2dlFCZzA4aUNUTjZUY2VwOTFjL3JJSWJJYmRiV0t1dlVR?=
 =?utf-8?B?a1M5ZVRHVm9BRC9PUm1McU5OREJPUXhLZEZXKzdNdHpkTW9Pck1HbW40ZTBK?=
 =?utf-8?B?a3BlSklRZ3grQU12WjEyWGlHM1ZmT1lhd052WmsvcnhZSUY1VXUyK2ZWNXAz?=
 =?utf-8?B?emZ6em9XRGZxQ1NSc1lUSEhZamRHcUVmVjV5aXRjd0RPV3gwR3ZOL3pnbXJI?=
 =?utf-8?B?RTFub2swa1k3d28rY1JNVElEUklhbi8vWWlTcm9RV0JBcFpSVmx3SGVLZFVx?=
 =?utf-8?B?TXIyZ3JqVFZzSGZvZ2xWczB2eW9pbTVVRGhRVm9wZ0dOeGlnMno1bnJNRnI4?=
 =?utf-8?B?aGZEV0xtVmp3ZkNzWHlyUk5qOVFFN25zTDBDWHloTGxPWm9QQWxsWWsrU1Jj?=
 =?utf-8?B?MkthTjdZMEpmeGExbTlnajY4cFltMEF4Z3dVcmk2OTZBRjYwWnEvWmFQdUdN?=
 =?utf-8?B?bUk3bHJnY2xrbHExZzRGTjA4dFMvektXMS9jY2FjVytwcm0rcXZLTml2RlFZ?=
 =?utf-8?B?VTRIallvdldIN0NqT1hsZVBoM2IrSFdFWERiSWhyTm0yKy9HczVqZUJYQ3pY?=
 =?utf-8?B?Z1JZMzl6cFRCVDJaeVB4SjVpRlhOMW0wekdOdXVoZlg0c0pBaXZsbzBxZnJO?=
 =?utf-8?B?a0ZQYWVINyt4ekNWVnZKQjJTbHFKZHRWOEhhbFRmWnYwMzBSZExnSTlFazdu?=
 =?utf-8?B?TE5tM1NhWk1ZUDkvMWo0b0Z4bVlhcXVLMWJVaUNrd1NmUXNlSEdOcDJDUENY?=
 =?utf-8?B?RTM3UHM4U0lTdGp3dHdHMThnY0RJNm5RUW5VczZLb3B2dmt6K3VVTTczNUFo?=
 =?utf-8?B?andyTkV5YUZzSEp3SlkyVlZBTytiUFVkMlo2VmtHNEZUaTJXcmI0S0xuNHRz?=
 =?utf-8?B?RU9IN2Z5Z1Vla1ZQdU4zeEQzQTdIdXRQYkFEQTFLWjZuY1dKL0pWSTB2RmZX?=
 =?utf-8?B?LzdoSWEyeTg3SmlPdlJ6NCtpblR3ZjBrZ0RLbDZnVEdZZXpDOS9ybmZqSkRp?=
 =?utf-8?B?UVJILzZ4NndNb2xyTkpURVVCUzdTN2VyYzVRNkZCQlpYaFJuUjY3M1lCazdi?=
 =?utf-8?B?MDQ1NTc0enQ2SWp5bW9qNllPT29DdnA1anRtZkx2UE9jZW9TaUp6anNCR2pO?=
 =?utf-8?B?VUZDYXI2aWNWemJITzFkNEd6UzNJcUNsb3FiTitHbDV0bW1oSGIya2drL0xN?=
 =?utf-8?B?eVNDOFZHa093ME00ZDh1ZUl6UDdnN2hOWlh4OGc4RWJ0RkEzdkhZZ3lPcFpO?=
 =?utf-8?B?T2gwWVBMSWt4NU9YaitSL2l3bzY1ZmFGOS9hclVUUWlkdkJXNUlLMmwwU21p?=
 =?utf-8?B?b3YzM0tLMFBQWjRVTkx2M3cvUW4ySXBCS3BjQmlkeWIvQzUybmZYZTQrcXZK?=
 =?utf-8?B?YWpFVDdHTElLejZQQ1ZpbE5BZm54dDlGRURUakR4NWtMNUdVRTBhQVVwODNP?=
 =?utf-8?B?WitZVU9rWXh4eDFrdkxrbWJTaHU0ckgyVGhab2ZiQkdSSlBTaU9BN0QyTVJ2?=
 =?utf-8?B?SVhqcmNlQUNxYXZFQUMwdU1nK3RxR085UHM5V2RKdGVGU1I4QjVocTBvUmt1?=
 =?utf-8?B?TTVVU0E2U2N2b3AyZEFpVXBtNWJDbllpM2JIK1hRSFl3OTVPTnZFZkZRUUkw?=
 =?utf-8?B?cks1SWl2UXpJdGQyME1nQWs2R2JDVW9lbW4waWpVcFhSODBiZDNTU1dtRW5R?=
 =?utf-8?B?TVRJcUVGZEUybkE3bW5zeTg0ajRDWHpDd2xWSHh2cUthVjk1eDJnN3plNWdN?=
 =?utf-8?B?b0FxeXJmNmppMzR1bGhkSnQwaWw2T3BqOUgxSnpUU1pqakZZWndXRTB4ZFRK?=
 =?utf-8?Q?O4Sp4uhws+VdzinrJAUGHVjR4JNC9PfPTqbLhGtwZ//hJ?=
x-ms-exchange-antispam-messagedata-1: +wKMaS1ux7BmUh/0qb0Fjz4EA/QbMPhDrzU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE41CABF92F07A40942DDDFF11E169D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KgozvirXhon5K6gQ//ltR+vnCH3Izc40O1kQrEfOprvylII4qYZc8O1vdBdTgwhKGTm5oBN0+zCuyyFCFexJLsIaIBqaFiujatYrM5XJ2niCX7aOT8gFvhTaHQ4GdYWTAov/NF/7OS49uP1doR0K8hAUUkftWA4lWntjNneenGWh97DVcYQnIesjBrphzcrUl3XVXfqXvlPSRf23Hj3wL9I8g+xgtvdIwRJ2oX+M0ONmCiLrN6z0naCWwC9PclXd+vF/xZBo1CLjt2HAtitvuN9Vdv02BgDfavc++Xsr8tdx8cs1iQnGcOwqUdGrMJ9x5w2dNt6EmgW6dkOCA3qXFw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb569ad-a32f-48c0-a354-08de84f4d014
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 13:46:53.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFBMgpAxnYNBw3pMpFxh4+iNSbliwF+De1K/2+zWX7JIQOLQoO6sgoA/ZecuhDraB3w0FDn2ncxCYGiwY1BOYjhjqVlOpPqGgsSJJugbWgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227075-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,ursulin.net:email,intel.com:dkim,intel.com:email,intel.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A3B7B2BC497
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDE0OjI1ICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IFRoZSBwYXRjaCBiZWxvdyBkb2VzIG5vdCBhcHBseSB0byB0aGUg
Ni4xOS1zdGFibGUgdHJlZS4NCj4gSWYgc29tZW9uZSB3YW50cyBpdCBhcHBsaWVkIHRoZXJlLCBv
ciB0byBhbnkgb3RoZXIgc3RhYmxlIG9yIGxvbmd0ZXJtDQo+IHRyZWUsIHRoZW4gcGxlYXNlIGVt
YWlsIHRoZSBiYWNrcG9ydCwgaW5jbHVkaW5nIHRoZSBvcmlnaW5hbCBnaXQNCj4gY29tbWl0DQo+
IGlkIHRvIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPi4NCg0KWW91IGNhbiBzb2x2ZSB0aGlzIGJ5
IGZpcnN0IGNoZXJyeS1waWNraW5nIHR3byBkZXBlbmRlbmNpZXM6DQoNCmMyYzc5YzZkNWI5Mzlh
ZThhNDJkZGI4ODRmNTc2YmRkYWU2ODU2NzIgKGRybS9pOTE1L2RzYzogQWRkIFNlbGVjdGl2ZQ0K
VXBkYXRlIHJlZ2lzdGVyIGRlZmluaXRpb24pDQoNCmJiNWYxY2QxMDEwMWMyNTY3YmZmNGQwZTc2
MGI3NGFlZTdjNDJmNDQgKGRybS9pOTE1L2RzYzogQWRkIGhlbHBlciBmb3INCndyaXRpbmcgRFND
IFNlbGVjdGl2ZSBVcGRhdGUgRVQgcGFyYW1ldGVycykNCg0KYW5kIG9ubHkgYWZ0ZXIgdGhhdCB0
aGUgZml4IGl0c2VsZjoNCg0KNTkyM2E2ZTA0NTlmZGQzZWRhYzRhZDVhYmNjYjI0ZDc3N2Q4ZjFi
NiAoZHJtL2k5MTUvcHNyOiBXcml0ZSBEU0MNCnBhcmFtZXRlcnMgb24gU2VsZWN0aXZlIFVwZGF0
ZSBpbiBFVCBtb2RlKQ0KDQpCUiwNCkpvdW5pIEjDtmdhbmRlcg0KDQo+IA0KPiBUbyByZXByb2R1
Y2UgdGhlIGNvbmZsaWN0IGFuZCByZXN1Ym1pdCwgeW91IG1heSB1c2UgdGhlIGZvbGxvd2luZw0K
PiBjb21tYW5kczoNCj4gDQo+IGdpdCBmZXRjaA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L8KgbGluDQo+IHV4LTYuMTku
eQ0KPiBnaXQgY2hlY2tvdXQgRkVUQ0hfSEVBRA0KPiBnaXQgY2hlcnJ5LXBpY2sgLXggNTkyM2E2
ZTA0NTlmZGQzZWRhYzRhZDVhYmNjYjI0ZDc3N2Q4ZjFiNg0KPiAjIDxyZXNvbHZlIGNvbmZsaWN0
cywgYnVpbGQsIHRlc3QsIGV0Yy4+DQo+IGdpdCBjb21taXQgLXMNCj4gZ2l0IHNlbmQtZW1haWwg
LS10byAnPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+JyAtLWluLXJlcGx5LXRvDQo+ICcyMDI2MDMx
NzEyLXN0cmVwLWF1dG9waWxvdC0wOTk5QGdyZWdraCcgLS1zdWJqZWN0LXByZWZpeCAnUEFUQ0gN
Cj4gNi4xOS55JyBIRUFEXi4uDQo+IA0KPiBQb3NzaWJsZSBkZXBlbmRlbmNpZXM6DQo+IA0KPiAN
Cj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0g
b3JpZ2luYWwgY29tbWl0IGluIExpbnVzJ3MgdHJlZSAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+
IEZyb20gNTkyM2E2ZTA0NTlmZGQzZWRhYzRhZDVhYmNjYjI0ZDc3N2Q4ZjFiNiBNb24gU2VwIDE3
IDAwOjAwOjAwDQo+IDIwMDENCj4gRnJvbTogPT9VVEYtOD9xP0pvdW5pPTIwSD1DMz1CNmdhbmRl
cj89IDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IERhdGU6IFdlZCwgNCBNYXIgMjAyNiAx
MzozMDoxMSArMDIwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9pOTE1L3BzcjogV3JpdGUgRFND
IHBhcmFtZXRlcnMgb24gU2VsZWN0aXZlDQo+IFVwZGF0ZSBpbiBFVA0KPiDCoG1vZGUNCj4gTUlN
RS1WZXJzaW9uOiAxLjANCj4gQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
DQo+IENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCj4gDQo+IFRoZXJlIGFyZSBzbGlj
ZSByb3cgcGVyIGZyYW1lIGFuZCBwaWMgaGVpZ2h0IHBhcmFtZXRlcnMgaW4gRFNDIHRoYXQNCj4g
bmVlZHMNCj4gdG8gYmUgY29uZmlndXJlZCBvbiBldmVyeSBTZWxlY3RpdmUgVXBkYXRlIGluIEVh
cmx5IFRyYW5zcG9ydCBtb2RlLg0KPiBVc2UNCj4gaGVscGVyIHByb3ZpZGVkIGJ5IERTQyBjb2Rl
IHRvIGNvbmZpZ3VyZSB0aGVzZSBvbiBTZWxlY3RpdmUgVXBkYXRlDQo+IHdoZW4gaW4NCj4gRWFy
bHkgVHJhbnNwb3J0IG1vZGUuIEFsc28gZmlsbCBjcnRjX3N0YXRlLT5wc3IyX3N1X2FyZWEgd2l0
aCBmdWxsDQo+IGZyYW1lDQo+IGFyZWEgb24gZnVsbCBmcmFtZSB1cGRhdGUgZm9yIERTQyBjYWxj
dWxhdGlvbi4NCj4gDQo+IHYyOiBtb3ZlIHBzcjJfc3VfYXJlYSB1bmRlciBza2lwX3NlbF9mZXRj
aF9zZXRfbG9vcCBsYWJlbA0KPiANCj4gQnNwZWM6IDY4OTI3LCA3MTcwOQ0KPiBGaXhlczogNDY3
ZTRlMDYxYzQ0ICgiZHJtL2k5MTUvcHNyOiBFbmFibGUgcHNyMiBlYXJseSB0cmFuc3BvcnQgYXMN
Cj4gcG9zc2libGUiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYuOSsNCj4g
U2lnbmVkLW9mZi1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBBbmtpdCBOYXV0aXlhbCA8YW5raXQuay5uYXV0aXlhbEBpbnRlbC5j
b20+DQo+IExpbms6DQo+IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDMwNDExMzAxMS42
MjY1NDItNS1qb3VuaS5ob2dhbmRlckBpbnRlbC5jb20NCj4gKGNoZXJyeSBwaWNrZWQgZnJvbSBj
b21taXQgMzE0MGFmMmZhYjUwNWE0Y2Q0N2Q1MTYyODQ1MjliZjE1ODU2MjhiZSkNCj4gU2lnbmVk
LW9mZi1ieTogVHZydGtvIFVyc3VsaW4gPHR1cnN1bGluQHVyc3VsaW4ubmV0Pg0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jDQo+IGluZGV4IDM4NDhjZDRm
YmEwZS4uYjczMDJhMzJkZWQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX3Bzci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfcHNyLmMNCj4gQEAgLTI2MTksNiArMjYxOSwxMiBAQCB2b2lkDQo+IGludGVsX3BzcjJf
cHJvZ3JhbV90cmFuc19tYW5fdHJrX2N0bChzdHJ1Y3QgaW50ZWxfZHNiICpkc2IsDQo+IMKgDQo+
IMKgCWludGVsX2RlX3dyaXRlX2RzYihkaXNwbGF5LCBkc2IsIFBJUEVfU1JDU1pfRVJMWV9UUFQo
Y3J0Yy0NCj4gPnBpcGUpLA0KPiDCoAkJCcKgwqAgY3J0Y19zdGF0ZS0+cGlwZV9zcmNzel9lYXJs
eV90cHQpOw0KPiArDQo+ICsJaWYgKCFjcnRjX3N0YXRlLT5kc2MuY29tcHJlc3Npb25fZW5hYmxl
KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlpbnRlbF9kc2Nfc3VfZXRfcGFyYW1ldGVyc19jb25m
aWd1cmUoZHNiLCBlbmNvZGVyLA0KPiBjcnRjX3N0YXRlLA0KPiArCQkJCQnCoMKgwqDCoA0KPiBk
cm1fcmVjdF9oZWlnaHQoJmNydGNfc3RhdGUtPnBzcjJfc3VfYXJlYSkpOw0KPiDCoH0NCj4gwqAN
Cj4gwqBzdGF0aWMgdm9pZCBwc3IyX21hbl90cmtfY3RsX2NhbGMoc3RydWN0IGludGVsX2NydGNf
c3RhdGUNCj4gKmNydGNfc3RhdGUsDQo+IEBAIC0zMDQwLDYgKzMwNDYsMTAgQEAgaW50IGludGVs
X3BzcjJfc2VsX2ZldGNoX3VwZGF0ZShzdHJ1Y3QNCj4gaW50ZWxfYXRvbWljX3N0YXRlICpzdGF0
ZSwNCj4gwqAJfQ0KPiDCoA0KPiDCoHNraXBfc2VsX2ZldGNoX3NldF9sb29wOg0KPiArCWlmIChm
dWxsX3VwZGF0ZSkNCj4gKwkJY2xpcF9hcmVhX3VwZGF0ZSgmY3J0Y19zdGF0ZS0+cHNyMl9zdV9h
cmVhLA0KPiAmY3J0Y19zdGF0ZS0+cGlwZV9zcmMsDQo+ICsJCQkJICZjcnRjX3N0YXRlLT5waXBl
X3NyYyk7DQo+ICsNCj4gwqAJcHNyMl9tYW5fdHJrX2N0bF9jYWxjKGNydGNfc3RhdGUsIGZ1bGxf
dXBkYXRlKTsNCj4gwqAJY3J0Y19zdGF0ZS0+cGlwZV9zcmNzel9lYXJseV90cHQgPQ0KPiDCoAkJ
cHNyMl9waXBlX3NyY3N6X2Vhcmx5X3RwdF9jYWxjKGNydGNfc3RhdGUsDQo+IGZ1bGxfdXBkYXRl
KTsNCj4gDQoNCg==

