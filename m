Return-Path: <stable+bounces-105631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECD49FB0AE
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAD3162851
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017374E09;
	Mon, 23 Dec 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOWX1Z2q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B174EAD7
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734967562; cv=fail; b=u4EuC6SXVx0R3csEa/hVL0lVZrXQhv9R/Maxu/YcbGoFkDxleiKXKFcO2gQl0YiaJaI/4rqX3qUwWgLp4YvmQbPeMP8ZdSMXC5B4te3zc+Nyk++BzZAoevqSaQ4fEYqY67k0P615zjZHf3NYV2gsnLfF0jaSPCN4tsbPyWcUZJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734967562; c=relaxed/simple;
	bh=M1DlibBT4cs/PavoBWuB/A747jRZZZFj80TxUZPxF7Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CfUjvW8nQz1BzWLNqJyAh/P3n4pBcvotkNlY+Ovi9v7PxAAchuM/5BmDdO03bAyX0RsSdu8Wn6sTzrEkTG3zgHfixWzyFRAdH5QRr3lxPpvnO71RGgRFiRTIPZfbxjSWitDvYig6TiG8Cs6VR9HJrbSoxsjDxvsZZrBZ2IIpwxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOWX1Z2q; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734967560; x=1766503560;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=M1DlibBT4cs/PavoBWuB/A747jRZZZFj80TxUZPxF7Y=;
  b=EOWX1Z2q2URLyI/BiG6mOPpygqa/p36LqJLhJp7jNE2LVnVIZEGANe25
   lFAO9kNmuepcdO+awY/Ct/ZANRGKks2qmdL4i8a9yRZ3dKPTtr5HsZE0i
   Iv3H3POalDrI9PtX1+Xol6z1oJWwEUas6uep7zzJ3Pjj5G/g7c3Qq8wX4
   yp6kpHqkOqjFIcppXtBnuV6ZT9VYUA2l/omJ1CH9nwbyRH/+yM+Bnd978
   BFk6upoNVUPUWVB6rgN5c5wovzXGOvH4bRuV5iFYOW3ig5HsoJqGnEULo
   aJEurx97o97E2WtguUJVaXhb4zb1jcn4O3DjsKspmeA952Ung9lVyDdTA
   Q==;
X-CSE-ConnectionGUID: Cu1ZxXHLRTeRGwjASlRKxA==
X-CSE-MsgGUID: Y7cIs/fvRKuP2XsabL3oMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="46441780"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="46441780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 07:26:00 -0800
X-CSE-ConnectionGUID: PKLsOqVeSZCw/hm7Q909WA==
X-CSE-MsgGUID: PN2RQ6kIRqmwQVtcgTj1qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99753661"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 07:25:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 07:25:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 07:25:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 07:25:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8OIc7zC3F79n69PlcQV4DNusIbBKPAJfnCYEyNY3Hhkyf+6HiEYcgbdcY/qO4lqGmR5OTR1KErFU/YyFOKAU0zInUWlScJKMa/SgdibzRQaKMsQJi29R1waAeYshtIH9ReS/qmtlvOwKigkJSpIQ/UM/Kf8f0ph5oX5x1upcqAZqE1mWDkK24K0FscuZrZH5pdpp7xLpWkMfxABjEEkb5HluBcLAkgG01F9BfZtDooCwN4KXeqB3ggbiAJ9iBaFsU/3ZLuTx94AYArogKGnf6C/SQMqXVAo/V3C+leDFQMH5N5IYuWjKVom6qMbHV05oKTFGUcF7dD4KJMD9JIWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1DlibBT4cs/PavoBWuB/A747jRZZZFj80TxUZPxF7Y=;
 b=PwBixnbkpMCWqlN7L5bqqm3EJFkNkEAeKVKCiJfTxzRNN0I/gaCtUUMhcSbSSHQXfZp+QOJNGjgeOHlYu8riM3KwKGlTYeVCNz6m/zI2er6KELYSh4njsP7AgARQFHn8Bq7OjD8JDj2CdiN8p9/joZG9ZQDLieKk9JzjWfMFbO82L1HLBIIC/xA9zK9owYmFqrQgxsRA96E4vw/xuakSXUsKqL1yd1zp4lnX2tw8m9xohRW+SpyI+5OZEiCIEydruQlNuFDZM77mUDfSLU4c4UQh4WMzpMP2dYjeA3V9/bBpW/J8bjOZR638/By1HgNMVACBHXGwcBnKs6NOoK998g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Mon, 23 Dec
 2024 15:25:52 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 15:25:52 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "sashal@kernel.org" <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 6.12] wifi: iwlwifi: be less noisy if the NIC is dead in
 S3
Thread-Topic: [PATCH 6.12] wifi: iwlwifi: be less noisy if the NIC is dead in
 S3
Thread-Index: AQHbVUf0rYi/Tako40yFRNFoTT8JS7Lz81aA
Date: Mon, 23 Dec 2024 15:25:52 +0000
Message-ID: <cd8f5928ae96fa55965f07276d3a359605c2db98.camel@intel.com>
References: <20241223093130-c43ea648ac07fcc0@stable.kernel.org>
In-Reply-To: <20241223093130-c43ea648ac07fcc0@stable.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|SA1PR11MB6735:EE_
x-ms-office365-filtering-correlation-id: fbc8bead-5fe8-488c-81ad-08dd23661621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cllMV0gyNUJSYkZqaTZwMWNrUmUydGI4cXJoYkl1OCs1RmtyVG80WWw3NlB4?=
 =?utf-8?B?cUNYNGpQeTJnK0Z3ejg1SzZQVHV6NklSb0gyQVh3b0Z1c2JHU294OXdrRU42?=
 =?utf-8?B?MTJBcDFYSlFPb3RzbHV1RFdmUzkyUHY3Sm54UDRIVVZaRjNYS1lEclpEemZN?=
 =?utf-8?B?VmVPWDV6ZldKZElzQnNZWnhvaERqRnJCR2k0MGxMeExvd09DYytNbUN5QWpx?=
 =?utf-8?B?L3JiT1FtVVRSMmVudno4c2l5Q3czLzJZVlMrd0dQcGFRMVQvQ1pnbVFoUWIr?=
 =?utf-8?B?QTdmSGxuV1RSMjJoaHpiQXZPaTRZSWVDTEQzV2RzZGRPbnpubnZoSzkxcmht?=
 =?utf-8?B?dCtETTZ3VzZTWm1wYVJiT2JRWFZNSmRhQ2pBOGE5QnNaVDVCelZQODByYXdv?=
 =?utf-8?B?TituR2RaYnl0QUoxekx5MURaTVBRVjJGQTJWUG5HREMyeThkcW5qZ2F2dW1u?=
 =?utf-8?B?Q1BFOENQYWZuYWFJc1o0d2t2bVVhbkRJRnlzdGcvcDJRcS92SmxMc2NWK01Z?=
 =?utf-8?B?cFF6ckQwRm1JOEFGbWNxK2F5SGl4Nnp3ZFR2WU83OEJSYzVKZy9iQUFsYjVD?=
 =?utf-8?B?cXUyQituWnRJNUU4eGNIa0NhaFJicmVKMDdROFpNYlhiai9yWjgyQlRUblF3?=
 =?utf-8?B?QzNGZ2NWMjBoRXRkTXpqcVhSSWFYQUJ4SElkS1FVVkE5amhXNCtxaFFaNktE?=
 =?utf-8?B?Q0lrWEU1NWZLS3lPU25TZVQwN3Z5UndFbU5jTzZUTUdIQUFVYTFmek10eXp5?=
 =?utf-8?B?bUNsNXR5eGl2MTRTc1YyWi9hVTBtdGVBdTNWaXprRklKU3NBWmtVTGgrSVhL?=
 =?utf-8?B?V3Y2bTN2S3QxNlpnem5WZXNhNkZWRW5kbEN5OUd4MWpwUnJPaWl2VEE4Rmdz?=
 =?utf-8?B?UGVhZitYYW9pbldKUVhzTG5PT01OMkYxamI5bmNQUC9HSzhEZElZMndUR0FP?=
 =?utf-8?B?ZnFyWFpTYlVDak5WM3FCU1JrK2pXV0Q1ejQvMHFzNkdST0RxMVd4ekJzSWxS?=
 =?utf-8?B?K1pNQ1QwYmdjNU5uQnRpL1YzOUhoQVJqbXZQMXVrakRpdE4rK2VwdGV3cVVp?=
 =?utf-8?B?VFAyYlcvMDlFSDRnaXNxUmw0NnEzRjl6ZmQ0TUtBYkxyOTJsbVc1dGRDbjg5?=
 =?utf-8?B?aUpGb0ZBbVFWU284eFFWODJUWGh2UWJNQkptai91aWlGdzZuS0N5YzQ5d1VN?=
 =?utf-8?B?QkllK0JLd1NxTG1HY0RLUHcwcnB0RUg5TWltb3ZWMGhhaXBsK2RSTG5Mcnhm?=
 =?utf-8?B?TVpuTEdnY0Mrdy9tT0RlRlYxb3FLTTU4SytFVnRubVFoS3BXcGlqVEhmL2px?=
 =?utf-8?B?OGpOajBLczBXTnNJUFF6NDBiZUFDU2x1YWw1MGR4eDZjYksrbWdMNHN4cmdF?=
 =?utf-8?B?MGVKV3djVyt6WVBaYWdZNkhPdVlsNEJsSTIzQnBuWXpoa2tQamduSWsvL1NP?=
 =?utf-8?B?cmNMeHVORStQcTNzMjhabXJpU2cySWNoVHNPeG5NRkJZQXY4cDlmQ1Z5S25P?=
 =?utf-8?B?MVNWQVA2WnVnOHZ4Y0ptaEVrRTNUTUV2dVU2bVJ2TGx3LzZhM1l1Rm9vanBG?=
 =?utf-8?B?OHM5ZUVDMUhRUXptaXJRRHRLS3dGeFBTa1ljUXp4ZXdMYS95allIdXVSR0ZV?=
 =?utf-8?B?NnBRRnhVajBXNHMxNnhQQnNRb2M4ek1KelBMWnllWU1XN0dsaGZ2aEt3RHpy?=
 =?utf-8?B?bGJyanR1a2J2Uk5Ga04wUmhZNS9xSHA4cDQ3VTcwZmlwT0NESXpQczArOHg3?=
 =?utf-8?B?WWw4aTEycFZOSjN5cGZ2WmVFMFJteGI2alBCS253NVlmZ01Na0FscDVFN1Bu?=
 =?utf-8?B?T0pkcXZZVmVRemJpTFlmZ0tubkN3TjFKNk5SWmdqVEVmYXFqc3pwZHVpMzNU?=
 =?utf-8?B?SWlIcDdpbEVnRnNGMU9ldW9LTlI0NnZNZlNqMWpPVVFrTVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUk3NTRNNnYzK3p1cHlBWm1BbG9xbDVtNE9nb1lyeXZBcUdoejhLaDVKMXE1?=
 =?utf-8?B?bW12UWRhcGg2V0o3TE5uSjJJZ0hRODJVQUJ2STh3L0NLblBtWjQyWjdjVmN5?=
 =?utf-8?B?Ui9majB3K09CamR5ZFNyNTlzWEpqR0lpandQNzRuL3Bpc0tiZ2o1Q2ZLbnla?=
 =?utf-8?B?azRZWFpncVgwcHhaYnZJenUwYTZKSzNrdDIzRDh1REFoNWF4ME10MlorR2lq?=
 =?utf-8?B?RytWT1krRWFxbXNIUHkvZjloV3Z1OUZ2LzZCRHl3SVNTR3E5RklndmdlZyts?=
 =?utf-8?B?QTJnbTFEcDFMeTdQWUlsYkZIdFowN1IyWkNXVTgyc24yTUx3N05NRHQ2YXA1?=
 =?utf-8?B?N0tWd3F0V1lKLzBUak02b0IrVXBNRDF4K29YbmdLaTFHWWZTZjhRRWdxQndt?=
 =?utf-8?B?NmxUN1YxY2l5YytFL1dmM0VoMlRsbWh1aktoTTlKdm5pRDI3OG1zWWhaZlE1?=
 =?utf-8?B?OXZRVCt4SDZkdndJS1c2cE5oUW1LWXVYdnM3VEZNVG1Ddk9lT3V0WkZ6Y3Vs?=
 =?utf-8?B?aGNrNmg4L1NNMXdVWHlXd1JKbTl3K0Njb3pPT0ZZWVFQbWlXQVlxWmhlSDlW?=
 =?utf-8?B?ZVJwMWc0ODFISHVzRlhhQjhhMG8xb0R5YUMyWmlURDhtdEhHcDYrN1RKY1Fl?=
 =?utf-8?B?bnVyMG55Wmp3V3d3UGc4SURxaEYyQUJ5L1kyNE1FMjBuNjZNY1QzbG44RmZ1?=
 =?utf-8?B?ZGxoSG9uYUp1a3Vlc2NGa0dCSDUxZzRBK0VmRzJDTFBacmZpZzQzZjhPcUxE?=
 =?utf-8?B?SUpvamwveVdQV2xkU0Z0MkNvMzdETU1BU1phK0tSSHl3SHVzcWFlTDkrbVRE?=
 =?utf-8?B?b252cE1LZlNzVFRNTWw2N0E2WG9obEEzQ1hYcllzbUtGaGkxZjNxclJJNURx?=
 =?utf-8?B?Z1RhbkhmQ1g3b1g0Ly9YWm4xQkNIckRuVElEM2dsdE1JQklJaTVwQklJR01q?=
 =?utf-8?B?eFNRdS9HYU5yb2RrWkFMcG5laWd3akdjYmVIajVieHRPdndsZGpuZ3BMNHdT?=
 =?utf-8?B?T3JaNkoyeG9GRTgwdnRNbDMxM2R2NU5EdFhtVndyNDdEYlh2WC91QkxEWmlt?=
 =?utf-8?B?OWdDVVR4U3Q3Y3FPMFZYQ3hZblhudGRaRlZmaGkvV3BRQ3Yvd3VtWlQ2clJX?=
 =?utf-8?B?YzV4dCtJM3doRjduVmpqbjJubG1IYTlrU0grOFVTTUNxVHYzNFRVVU9SN2NY?=
 =?utf-8?B?cWxjYXZVdFNJRXBUMEJoYWNJaUFLVjZ0akhCdmZRd2QzdlZHTDlHZ3J1Sjl6?=
 =?utf-8?B?eVJKMG16WFNLMUxSRk5CNVVlZmUzNXJJdW5la3MzYWNaamxmaXVtSkNFbFhV?=
 =?utf-8?B?RXlHaFRsTm5OQnlGSitWanRTYTJZQ1I5U2gvMDJiekxVQ0k1MzcwNzBGTFdn?=
 =?utf-8?B?OTNyekhFOVZRNVN6cHc3ellOZk83ZWp5UkNueFgzUDE0bS9QMnpub3IyV01S?=
 =?utf-8?B?YndURWp3dDNwdzVoSkFTeGE0U2VhZEVYeEVYNDhQaVhBSS9ObkFrTU1VUDlh?=
 =?utf-8?B?ZnMyTTltV0N0VXpDRUYxc21DL1FMa0djR091SkkrSms1THdScE9YM01MbjlB?=
 =?utf-8?B?emNBa01WN2hCNU81dGxGTFdPQ3RvdktKdU9ESmdzRmNuV0tDMVN0MFBpT0Zi?=
 =?utf-8?B?ZUhDTkZMcVVjc0FEcHRzR2crKzVwUWM3WWdvaUd4VjNHZUhnTTJYcU5ab1Ny?=
 =?utf-8?B?QWVKVVVsTVNZVEZQVWxmMjJoMDlVNG5tTEFXMVJXc1B2Y096OVNNVUNsSTFi?=
 =?utf-8?B?QzhwclBKdXhnQU5UVUtoYUVBMHZCMDFBcFU3b1ducTlwK2VJSzI2dnQ0UE5F?=
 =?utf-8?B?Y1FoYVJVNjczUzRXU256NkdyQng1L2NmaUVwNUR1dEJ5TStrby8xTzJ2UlRq?=
 =?utf-8?B?dS9MYmNySC9EMXEvdVBoZE5Hd0xNT3lST1VkQVkyYmlOZVlud0xPa2JrblQv?=
 =?utf-8?B?YkRSeU15aE5WbVE0SDRUeVp6UldUbUZlK3EyM1YxM3FmR2xjN1JaNi9BNHVo?=
 =?utf-8?B?TFV2UEVyY2ZnUjIxZTdvTE5TU0ExSDJBRUhNR1JpTjBsd0c2SHRYVS9yOTdS?=
 =?utf-8?B?d1NId2NzTGFWLzB5dDl6REZWV3l3ZWZLR3NyTTc1cHRrZlNVbDJCN0lEc2Jh?=
 =?utf-8?B?VTJpQnEyRHcvODMvSEJRYXhkWFh0QnYwSXJoUm85eFFRU1R1Uk9DMmVVc3Fr?=
 =?utf-8?Q?kmkeS+C9AzDUvjDZzfUEqIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C547152A74D5345A5F0B880AF3C4725@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc8bead-5fe8-488c-81ad-08dd23661621
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 15:25:52.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoqP/giLFuo3OpjA6+mZaqOyzQA+mMg8lDAZ4/ha7X/Px9c0x3JXPbWU8xoFZfj9er5claNAfJKnC8rZmrShbGJuNkCBKcJjgNa1xVjgXys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEyLTIzIGF0IDA5OjM1IC0wNTAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
WyBTYXNoYSdzIGJhY2twb3J0IGhlbHBlciBib3QgXQ0KPiANCj4gSGksDQo+IA0KPiBUaGUgdXBz
dHJlYW0gY29tbWl0IFNIQTEgcHJvdmlkZWQgaXMgY29ycmVjdDoNCj4gMDU3MmI3NzE1ZmZkMmNh
YzIwYWFjMDAzMzM3MDZmMzA5NDAyODE4MA0KPiANCj4gDQo+IFN0YXR1cyBpbiBuZXdlciBrZXJu
ZWwgdHJlZXM6DQo+IDYuMTIueSB8IE5vdCBmb3VuZA0KPiANCj4gTm90ZTogVGhlIHBhdGNoIGRp
ZmZlcnMgZnJvbSB0aGUgdXBzdHJlYW0gY29tbWl0Og0KDQpUaGlzIGlzIHRydWUuDQpUaGUgb3Jp
Z2luYWwgcGF0Y2ggbmVlZHMgYSBjbGVhbnVwIHBhdGNoIHRoYXQgbW92ZXMgaXdsX212bV9ydF9z
dGF0dXMNCnRvIGFub3RoZXIgZmlsZSBhbmQgcmVuYW1lcyB0aGUgZnVuY3Rpb24uIFRoaXMgZXhw
bGFpbnMgdGhlIGRpZmZlcmVudA0KYmV0d2VlbiBib3RoIHZlcnNpb25zIG9mIHRoZSBwYXRjaC4N
CkkgYWxzbyBhZGRlZCB0aGUgbGluayB0byB0aGUgYnVnemlsbGEgdGhhdCB3YXMgb3BlbmVkIGFm
dGVyIHRoZSBwYXRjaA0Kd2FzIGFscmVhZHkgb24gaXRzIHdheSB1cHN0cmVhbS4NCg0KPiAtLS0N
Cj4gMTrCoCAwNTcyYjc3MTVmZmQgISAxOsKgIGIxMGZmYzA4ZThiYSB3aWZpOiBpd2x3aWZpOiBi
ZSBsZXNzIG5vaXN5IGlmDQo+IHRoZSBOSUMgaXMgZGVhZCBpbiBTMw0KPiDCoMKgwqAgQEAgTWV0
YWRhdGENCj4gwqDCoMKgwqDCoCAjIyBDb21taXQgbWVzc2FnZSAjIw0KPiDCoMKgwqDCoMKgwqDC
oMKgIHdpZmk6IGl3bHdpZmk6IGJlIGxlc3Mgbm9pc3kgaWYgdGhlIE5JQyBpcyBkZWFkIGluIFMz
DQo+IMKgwqDCoMKgIA0KPiDCoMKgwqAgK8KgwqDCoCBjb21taXQgMDU3MmI3NzE1ZmZkMmNhYzIw
YWFjMDAzMzM3MDZmMzA5NDAyODE4MCB1cHN0cmVhbQ0KPiDCoMKgwqAgKw0KPiDCoMKgwqDCoMKg
wqDCoMKgIElmIHRoZSBOSUMgaXMgZGVhZCB1cG9uIHJlc3VtZSwgdHJ5IHRvIGNhdGNoIHRoZSBl
cnJvcg0KPiBlYXJsaWVyIGFuZCBleGl0DQo+IMKgwqDCoMKgwqDCoMKgwqAgZWFybGllci4gV2Un
bGwgcHJpbnQgbGVzcyBlcnJvciBtZXNzYWdlcyBhbmQgZ2V0IHRvIHRoZSBzYW1lDQo+IHJlY292
ZXJ5DQo+IMKgwqDCoMKgwqDCoMKgwqAgcGF0aCBhcyBiZWZvcmU6IHJlbG9hZCB0aGUgZmlybXdh
cmUuDQo+IMKgwqDCoCBAQCBDb21taXQgbWVzc2FnZQ0KPiDCoMKgwqDCoMKgwqDCoMKgIFNpZ25l
ZC1vZmYtYnk6IE1pcmkgS29yZW5ibGl0DQo+IDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRl
bC5jb20+DQo+IMKgwqDCoMKgwqDCoMKgwqAgTGluazoNCj4gaHR0cHM6Ly9wYXRjaC5tc2dpZC5s
aW5rLzIwMjQxMDI4MTM1MjE1LjNhMTg2ODIyNjFlNS5JMThmMzM2YTQ1MzczNzhhNGMxYTg1Mzdk
NzI0NmNlZTFmYzgyYjQyY0BjaGFuZ2VpZA0KPiDCoMKgwqDCoMKgwqDCoMKgIFNpZ25lZC1vZmYt
Ynk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KPiDCoMKgwqAgLQ0K
PiDCoMKgwqAgLSAjIyBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2R1bXAu
YyAjIw0KPiDCoMKgwqAgLUBAIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncv
ZHVtcC5jOiBib29sDQo+IGl3bF9md3J0X3JlYWRfZXJyX3RhYmxlKHN0cnVjdCBpd2xfdHJhbnMg
KnRyYW5zLCB1MzIgYmFzZSwgdTMyDQo+ICplcnJfaWQpDQo+IMKgwqDCoCAtwqAJCS8qIGNmLiBz
dHJ1Y3QgaXdsX2Vycm9yX2V2ZW50X3RhYmxlICovDQo+IMKgwqDCoCAtwqAJCXUzMiB2YWxpZDsN
Cj4gwqDCoMKgIC3CoAkJX19sZTMyIGVycl9pZDsNCj4gwqDCoMKgIC0tCX0gZXJyX2luZm87DQo+
IMKgwqDCoCAtKwl9IGVycl9pbmZvID0ge307DQo+IMKgwqDCoCAtKwlpbnQgcmV0Ow0KPiDCoMKg
wqAgLSANCj4gwqDCoMKgIC3CoAlpZiAoIWJhc2UpDQo+IMKgwqDCoCAtwqAJCXJldHVybiBmYWxz
ZTsNCj4gwqDCoMKgIC0gDQo+IMKgwqDCoCAtLQlpd2xfdHJhbnNfcmVhZF9tZW1fYnl0ZXModHJh
bnMsIGJhc2UsDQo+IMKgwqDCoCAtLQkJCQkgJmVycl9pbmZvLCBzaXplb2YoZXJyX2luZm8pKTsN
Cj4gwqDCoMKgIC0rCXJldCA9IGl3bF90cmFuc19yZWFkX21lbV9ieXRlcyh0cmFucywgYmFzZSwN
Cj4gwqDCoMKgIC0rCQkJCcKgwqDCoMKgwqDCoCAmZXJyX2luZm8sIHNpemVvZihlcnJfaW5mbykp
Ow0KPiDCoMKgwqAgLSsNCj4gwqDCoMKgIC0rCWlmIChyZXQpDQo+IMKgwqDCoCAtKwkJcmV0dXJu
IHRydWU7DQo+IMKgwqDCoCAtKw0KPiDCoMKgwqAgLcKgCWlmIChlcnJfaW5mby52YWxpZCAmJiBl
cnJfaWQpDQo+IMKgwqDCoCAtwqAJCSplcnJfaWQgPSBsZTMyX3RvX2NwdShlcnJfaW5mby5lcnJf
aWQpOw0KPiDCoMKgwqAgLSANCj4gwqDCoMKgICvCoMKgwqAgQ2xvc2VzOiBodHRwczovL2J1Z3pp
bGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxOTU5Nw0KPiDCoMKgwqDCoCANCj4gwqDC
oMKgwqDCoCAjIyBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5o
ICMjDQo+IMKgwqDCoMKgIEBAIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXds
LXRyYW5zLmg6IGludA0KPiBpd2xfdHJhbnNfcmVhZF9jb25maWczMihzdHJ1Y3QgaXdsX3RyYW5z
ICp0cmFucywgdTMyIG9mcywNCj4gwqDCoMKgIEBAIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvaXdsLXRyYW5zLmg6IGludA0KPiBpd2xfdHJhbnNfcmVhZF9jb25maWczMihzdHJ1
DQo+IMKgwqDCoMKgwqDCoAkJCcKgwqDCoCB1NjQgc3JjX2FkZHIsIHUzMiBieXRlX2NudCk7DQo+
IMKgwqDCoMKgIA0KPiDCoMKgwqDCoMKgICMjIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL2QzLmMgIyMNCj4gwqDCoMKgIC1AQCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL212bS9kMy5jOiBzdGF0aWMgdm9pZA0KPiBpd2xfbXZtX2QzX2Rpc2Nvbm5lY3Rf
aXRlcih2b2lkICpkYXRhLCB1OCAqbWFjLA0KPiDCoMKgwqAgLcKgCQlpZWVlODAyMTFfcmVzdW1l
X2Rpc2Nvbm5lY3QodmlmKTsNCj4gwqDCoMKgIC0gfQ0KPiDCoMKgwqAgK0BAIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmM6IHN0YXRpYyBib29sDQo+IGl3bF9tdm1f
cnRfc3RhdHVzKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCB1MzIgYmFzZSwgdTMyICplcnJfaWQp
DQo+IMKgwqDCoCArwqAJCS8qIGNmLiBzdHJ1Y3QgaXdsX2Vycm9yX2V2ZW50X3RhYmxlICovDQo+
IMKgwqDCoCArwqAJCXUzMiB2YWxpZDsNCj4gwqDCoMKgICvCoAkJX19sZTMyIGVycl9pZDsNCj4g
wqDCoMKgICstCX0gZXJyX2luZm87DQo+IMKgwqDCoCArKwl9IGVycl9pbmZvID0ge307DQo+IMKg
wqDCoCArKwlpbnQgcmV0Ow0KPiDCoMKgwqAgKyANCj4gwqDCoMKgICvCoAlpZiAoIWJhc2UpDQo+
IMKgwqDCoCArwqAJCXJldHVybiBmYWxzZTsNCj4gwqDCoMKgICsgDQo+IMKgwqDCoCArLQlpd2xf
dHJhbnNfcmVhZF9tZW1fYnl0ZXModHJhbnMsIGJhc2UsDQo+IMKgwqDCoCArLQkJCQkgJmVycl9p
bmZvLCBzaXplb2YoZXJyX2luZm8pKTsNCj4gwqDCoMKgICsrCXJldCA9IGl3bF90cmFuc19yZWFk
X21lbV9ieXRlcyh0cmFucywgYmFzZSwNCj4gwqDCoMKgICsrCQkJCcKgwqDCoMKgwqDCoCAmZXJy
X2luZm8sIHNpemVvZihlcnJfaW5mbykpOw0KPiDCoMKgwqAgKysNCj4gwqDCoMKgICsrCWlmIChy
ZXQpDQo+IMKgwqDCoCArKwkJcmV0dXJuIHRydWU7DQo+IMKgwqDCoCArKw0KPiDCoMKgwqAgK8Kg
CWlmIChlcnJfaW5mby52YWxpZCAmJiBlcnJfaWQpDQo+IMKgwqDCoCArwqAJCSplcnJfaWQgPSBs
ZTMyX3RvX2NwdShlcnJfaW5mby5lcnJfaWQpOw0KPiDCoMKgwqDCoMKgIA0KPiDCoMKgwqAgLS0N
Cj4gwqDCoMKgIC0gc3RhdGljIGJvb2wgaXdsX212bV9jaGVja19ydF9zdGF0dXMoc3RydWN0IGl3
bF9tdm0gKm12bSwNCj4gwqDCoMKgIC3CoAkJCQnCoMKgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2
aWYpDQo+IMKgwqDCoCAtIHsNCj4gwqDCoMKgwqAgQEAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vZDMuYzogaW50DQo+IGl3bF9tdm1fZmFzdF9yZXN1bWUoc3RydWN0IGl3
bF9tdm0gKm12bSkNCj4gwqDCoMKgwqDCoMKgCWl3bF9md19kYmdfcmVhZF9kM19kZWJ1Z19kYXRh
KCZtdm0tPmZ3cnQpOw0KPiDCoMKgwqDCoMKgIA0KPiAtLS0NCj4gDQo+IFJlc3VsdHMgb2YgdGVz
dGluZyBvbiB2YXJpb3VzIGJyYW5jaGVzOg0KPiANCj4gPiBCcmFuY2jCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IFBhdGNoIEFwcGx5IHwgQnVpbGQgVGVzdCB8DQo+ID4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tfA0K
PiA+IHN0YWJsZS9saW51eC02LjEyLnnCoMKgwqDCoMKgwqAgfMKgIFN1Y2Nlc3PCoMKgwqAgfMKg
IFN1Y2Nlc3PCoMKgIHwNCg0K

