Return-Path: <stable+bounces-232712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIBoNRfTzGlFWwYAu9opvQ
	(envelope-from <stable+bounces-232712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:11:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB821376859
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEE231A147B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837E384249;
	Wed,  1 Apr 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfgT5IAp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74238A720;
	Wed,  1 Apr 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030048; cv=fail; b=BL+MG6vd/zXeeN0FC5IjkpxjRn/vhnn98Tg99FEiJ4dW4a4sQwF6utmPnRTKXUXom4iqSx+kxM7xeOXPM80YsM/SfSzw0nel3NK9bqgAmDhdYgKJVXsJ+dr/8NJrgNGnN9bU8U7lBGn7gWp5+VT/JP0Zpq/TDkBYWOeoRXv+49c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030048; c=relaxed/simple;
	bh=YOsLHSvWLAKejMQ3OsCmAwWP6h+nDn6Z3PCjS3c+Q9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVkOQ26jM16La2ZZT35BmbWEKcBfvP8dLldeAYdNGnJGq2NZwlRNEp8fO7rx5atkP1JOP/o4+c4goVBtYdxhG1WWyLsKOz9XLfz4Z6NVoFAXrQYnq84Nt7PRDQXWq4dsA6qIvHlMYVFJM4fGBfYIk7cfd2t8Lsi4eApJysWK17U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfgT5IAp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775030046; x=1806566046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YOsLHSvWLAKejMQ3OsCmAwWP6h+nDn6Z3PCjS3c+Q9U=;
  b=gfgT5IAp6LsOvrIxkThRRhmoW2CpJdojqii0oQZIxDRUvdmBFSKpPp9n
   CZKWG41EtjbnzN/JwIozd/Vn/yu8IcsEekyY5HVwZLFTHSoG2EtFpib3c
   FLqy1zmgV63t08yGyg2jVU+ss7+k/QkrdYAQIiRCopjIoqlt0uI9vcYwW
   fFHJP5GbFyjVkLKEJUBdm6Y5B20J8w9x9ficuhs/GO5egVzX2IFxQUHo1
   G9psRMzDTMkwDB4362nJPrBfk79GKvVhz6VdRNW+p7vCQAKwP8rzyIprW
   syupNwoCiXTxduc8NFJmqiM7G7hzlSlZO2NMvRHBtb93Ih3HphJpuVp6+
   A==;
X-CSE-ConnectionGUID: ZVLdq/pIR/icRWmRmczpGw==
X-CSE-MsgGUID: K/EeWQC8R/6wjFFsohbl8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79664658"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79664658"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:54:05 -0700
X-CSE-ConnectionGUID: EW/p0EHrR0eBevRE2N2QKA==
X-CSE-MsgGUID: tCBxseuqS2epdWqavb4gJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221746475"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:54:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:54:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 00:54:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWqaqlkcG+26AG/Yamq/3IE1WQLL5MRartDE5T/haclXx+IeH3McgqVVdaJs2XBv0JPCt1fGHFk8K2C+lXxHVtBcM/3gt+Zy1A7vIqeOfDP760h8koxiYa1n569lchHjd9APeyuMbkAcxDtGhbf7sOLa+Tu8+wPpM3i607qBVWcx77yeXkGHUmExbOnS2Th+zjDX8Xv30eiZvqDc14igcXgFm9AgMemEmE05/Izo3biYWpEwmbVRBkooKN2799F/afau/xzznPcFvD+py88pjh1Cwk8hci4c7ytK000QDSnoFRuLO5aoDJ5HXwABxQpKEGBxCjGDcGNmdYqyjVMDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deXLde+ecArGzOTOgsJQwuRSeQOc+Q+AU5icVZPviNo=;
 b=Uiema97Ln+mFhjgLuRuYfybBMqimB8UjQqc7y1agAoaUDQ613wLxHOulbVtpGkfWkvj8Krd/F22ItQD+3z2vPG95U0fUTkr/wAC8z4//UyFJD8EJnEWLqpmohvZf+UpzUl+PpcfWVfGoR8JuBLm/f7616rWFiYU4RzU/fAgLGigcWbkeeoZY1OyqV88j74ZCv2L0nG7fa0aX8HPBK81FyYSfuOxnJwEnOopPG1AkngwudXSdrd7sk/KmcwGD5VQ1Uec5Kh810cauDHvuWQWVbQnLQCWLoZQSbBM6ZP3L3enCG0FM6WIgcJekapGKLSI1aU/QgVbBaODf20uEt7TctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:54:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Wed, 1 Apr 2026
 07:54:01 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Esau <aaron1esau@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: fix memcmp of pointer in
 i40e_hw_set_dcb_config()
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: fix memcmp of pointer in
 i40e_hw_set_dcb_config()
Thread-Index: AQHcwFpUPcCixIgHekeEV7L5yfHmcbXJ2KFQ
Date: Wed, 1 Apr 2026 07:54:01 +0000
Message-ID: <IA3PR11MB8986EE3107AC40A628FDD582E550A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260329162151.2043655-1-aaron1esau@gmail.com>
In-Reply-To: <20260329162151.2043655-1-aaron1esau@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8556:EE_
x-ms-office365-filtering-correlation-id: bb85e6a8-1a37-48e3-5824-08de8fc3d674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 7Pg334hcW5QNcXCsW+rXWhoar9bYzj1rLtM4z88GyLzrzXnSaGTZ8zpXE85EQWgSBGzP+vBYrBF2dZutA6W4jJHPUkYFudd1079ZL/OYLhl7PqmjB2oX7ZEN3iIT4HP+jVjIUsxREMbG+7a3xFDnVbcrTbhdpZKf53y2ILEx4cE2HXVUtxjxx2quuXhkYwutBKzsxOMSHTcCvUJBBYYpNQbTuIpz80kRObpYLW6/gq0E4sA+8xcHWagj3jJiH/RFPHkEvilD9UWPi96R7Q/g8dp6IKvi44L8+uFOvif4OWJPO71bYGG9ecxIZbsSQrY3veLkiooY8un2DOWKm5pEBJ9VAjtiaCyWAsRx2ZRNIJoMVnXlx/EujO82WWEEDcNi2ed0oN76vlogCrmAlp+dBctP5ZJk0IFfOdy3rAXP2XdeaZ8v6H2KUhqvlCb+SZD4eYuhNzOxDtYLDd2wWtypfsD2EoaV+i6f4pr/JWC1W1CuabSxkxgCDHYlZkX4BywmDczJVKbMP7idQYj7GY/UEOg2BbOsLAPC6rAGGqbiAxtYm/uuFBsl1urQFEth0amw9EHP2zVRIRVDia0cZyET8ziKfvJOy/OqUxEyq/lmRr6K2N99XSh+B6sXU4xSz87tNmvu5uv4Yu1zUMJGohiPoVJjPw5uqOElUFweGEgLYBCacEmUcshyP4V7DMyQ7JjpZ6Qn12gFjeCNEEbt7pcJ5CC3ml0U6WJzYH7DYh4+cQ3Kays45medqcs12C1q9MFaAHGtxv8xQ/q2Hu6yWWuiFxZwgLuXbjKf6SIm8vmT9cc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jkebLurM3EymB6H6PtJA8I6gHVjhWfK4wK2CfUIVJmoYX4SWjphaKoBUjwKq?=
 =?us-ascii?Q?eeModIkLPkjsoWXQgkrRtLnCb2fFAUXFmD6otqD9ZdIpHYyxEaz0QWjJ4gdK?=
 =?us-ascii?Q?3Fc+7j0MY2Ku5KhXJj1KXlj8zmnWIo6NLpI8RXJ9lMJVZZAPqthmDxgJznAD?=
 =?us-ascii?Q?4J7m/TV12R44hdUqGLVl2tHJMuuBSJ/g2nymDPdyLDbYnQ2fRxzbTmaZPHZt?=
 =?us-ascii?Q?kbWcophFIH8RMPsRbkXBNvLJZSHcixaBnsKyoIlr0zcuQGitZPjr6e8Y0vV9?=
 =?us-ascii?Q?vlbmn6KUPaHg7iRNC4/5lLf5biEow6dp5Qcujj3MmtyxRhq1UDuGqvfeNPZo?=
 =?us-ascii?Q?iLfFynUP83ECcRdLFypny0Ft4z0xbw9NpHqXdSxkQBeUs+ZeDTibBHvTuuER?=
 =?us-ascii?Q?uDBQTxPXr4WL5BJfN9fZdCd/by8iF623Zg8hRBDJGTE4T7qSzsFj+/FYg9o9?=
 =?us-ascii?Q?xrdmLJiSD5pxK/OHx0pFJjRwEmUL63dgvPrRG7b6dXQHDi1IShwVOpsLs3MX?=
 =?us-ascii?Q?Cv3S/1Gw0cw0+aLkMV9XExSwy0WnJHMHlsBlXLvQorOpn5naTa8bOv1NNdFr?=
 =?us-ascii?Q?L56c372Bj2M+u8aDtUjZ75bxw9mRFhuZkOvLly+4PFUBR9BzjodmU0c9TsS4?=
 =?us-ascii?Q?8B8bqhHkCYQxpHSI/iU56lA/BQU8p5cq+/w4nKg5Xp8tj7rPDRtaloX0IZM/?=
 =?us-ascii?Q?fn4fvKqLEUJQsuufLDUf+lwfsJSmAKHMX93xW9gHDgDklTLglFukRWsUgjmL?=
 =?us-ascii?Q?cAo//yYaOPZ5XjmPBm3jk7Y44x/rZ02zz69Fwhr+FqRejTOn9uiiWPzu0B3p?=
 =?us-ascii?Q?cQuzooUnEzIVQa5M4JbXEqeKntk6vVCmcKY5QEyEzIRATLyQYzYyUKyQnPGp?=
 =?us-ascii?Q?iF2eUAePWsDmCdyqSf/XtMMO5kqb/CoJbQzuwHuUitAJiUb4/Mc0knj0/jc1?=
 =?us-ascii?Q?GZ+JSrO7A7R7Hpb/eU00lYZrtyzPAYjM97Y7nEFWzC1rm9FHqOoiL0ClzbJT?=
 =?us-ascii?Q?Ouu1TKlxmn/GVnR/94R8p6Q5Gc2p+bZUUKb7o6la5ynlFi9q9IN+RsGso3hL?=
 =?us-ascii?Q?iANGucxCjsZ3gP6wyA4/AV2d0CkuExlqaW3EBpkzQeRovwsrpxYF7Xdpwf45?=
 =?us-ascii?Q?VoHr+BfCntVYyGtmZ7Qc4BZE02ui5H4k27ThpvXm3xTaT4vZPWxQ9KuG5Vbd?=
 =?us-ascii?Q?TGx21nipm+1QW2kN30TxG0TQTykRU9xFjI9PYSA025jIKp09pSIdRK3oZ/NS?=
 =?us-ascii?Q?dM+0y/QBEq+qUfX9dFOZoxx6DJ+bmObXEjEDkPjcrMc9eXHsat3RKMKRjQCR?=
 =?us-ascii?Q?xn+/0mUGL73f9Wh7J2TZllYZ11Gcm7klBETKc9/nHQl0CPYTIPmHBJMEwfVV?=
 =?us-ascii?Q?SAWuOUBicqkTMop/k8IQnAhcYIavQa9YHknfwHvydLm6ejTo6JojtHdXFhgI?=
 =?us-ascii?Q?SDNJG+1YyAmxgPZzfwFfFXVL/hhz0rerbcLoMV6p4M/LHXVpgE3xUe3ST5/g?=
 =?us-ascii?Q?TwCXcht2JKxtjE8Ia/i59ErS/KHrg6FOdGFj4njY/JJFk4yEPICabY/A6WJO?=
 =?us-ascii?Q?hgGldSDtnGdvb9d3yGjv6A7+8MglFRodw82ryyTtgUDUMf4EZ1mJPSoMu9At?=
 =?us-ascii?Q?guV3aP21d9rFkAxx6Nh7UQ7OvJF0jzl92dfQol2V+ozfvviE3/iNH5emX0yi?=
 =?us-ascii?Q?SAkzyqgwcXzIdowo522Ly3qqzoEdAsgE+cwOXSeWaYxJfAH6HHHFU/n2N/Fl?=
 =?us-ascii?Q?lK/+TSQ1+/wKEJ2y3LwJ97Bp3dRU5a8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TEpTzCimw1KPkkgIv7nwsp2ey0mDanVw/SCTD0PcpV4w+pfR2cMWzDJXmQLl0kR3Ytz9C6VD476lPDKiIUDeydP1M1iXEzr6esgl6wKuL/qOEbqKyqAXrJLfXBTLpsLxgbvo6Np994sUeX6HpA2p4uO5EFiVNOgSW+jMMzu8lfoC5Nb4iNhCdrVL3nCgnIf2ajMtebDkPJVRZJSq1exmofl0ytcDUk4MCVVyW/iAPO2ccRrbEGlGMHwb0u/Awp9oYULJ3NJs/RLWBNfhxNMwxYewLH+Wdyg63bjurYXlE0sjwYNKUzBRSAh5fKRuaf0XP0Nou9G9orPVJfOhxL9PmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb85e6a8-1a37-48e3-5824-08de8fc3d674
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 07:54:01.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+O4jxvrhx0ijCZ5Klk30bU5MEMONHtmF1A9p19EQedv5oCmG4vCca94DyLOHQA3wLV/EcbtFLh/kEw2n2IRd33DkqQnHxC/7GoRY5yBrTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email];
	TAGGED_FROM(0.00)[bounces-232712-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EB821376859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Aaron Esau
> Sent: Sunday, March 29, 2026 6:22 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; stable@vger.kernel.org; Aaron Esau
> <aaron1esau@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net] i40e: fix memcmp of pointer in
> i40e_hw_set_dcb_config()
>=20
> In i40e_hw_set_dcb_config(), both new_cfg and old_cfg are pointers to
> struct i40e_dcbx_config, so sizeof(new_cfg) evaluates to the size of a
> pointer (8 bytes on 64-bit) rather than the size of the struct.
> Likewise, &new_cfg and &old_cfg are the addresses of the pointer
> variables on the stack, not the addresses of the actual config
> structs.
>=20
> As a result, the memcmp never compares the actual configuration data,
> meaning the "no change needed" early return never fires. Every call to
> this function performs a full DCB reconfiguration (quiescing all VSIs,
> reprogramming via "Set LLDP MIB" AQC, and reconfiguring VEB/VSIs) even
> when the configuration has not changed.
>=20
> Fix this by comparing the structs themselves rather than the pointers.
>=20
> Fixes: 4b208eaa8078 ("i40e: Add init and default config of software
> based DCB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
> ---
>=20
> Found using Coccinelle/spatch with a semantic patch that matches
> sizeof(ptr) and &ptr used together where ptr is a pointer type.
>=20
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -6904,7 +6904,7 @@ static int i40e_hw_set_dcb_config(struct i40e_pf
> *pf,
>  	int ret;
>=20
>  	/* Check if need reconfiguration */
> -	if (!memcmp(&new_cfg, &old_cfg, sizeof(new_cfg))) {
> +	if (!memcmp(new_cfg, old_cfg, sizeof(*new_cfg))) {
>  		dev_dbg(&pf->pdev->dev, "No Change in DCB Config
> required.\n");
>  		return 0;
>  	}
> --
> 2.49.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

