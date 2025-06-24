Return-Path: <stable+bounces-158342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5591AE5F79
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058AE405F0C
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF825C815;
	Tue, 24 Jun 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9+ydUAd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0C25BF02;
	Tue, 24 Jun 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754031; cv=fail; b=TM6acLQZ42b4eHyTW83TFAmoTsGGtrZCXPnHpL5gxy1TdhkNjiC4VJV9m+w5uROQVzZMVmFpaEPdRYOLunW68Vh3CPTlj9ZqHcPiXEH32PP3EM3+klKuuT4ktniiFy3oGHxF826fdTjgrCKEKv3KFIrkeSZWatkKg9+oqwXJY7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754031; c=relaxed/simple;
	bh=flKZR7yuyG2DiLmvLEzIfNFYWNL+PMNry40dPfL7mls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqntkKUpzDGtIiJXeKPKuZUMHfnNVp5NyQ8IV2pIqvJoV1hdWGIBh7qXmKVcwrX6lrKWX82zEvc3UM7X7fdwFcqBvKqNO7P3XoaEyUcdDYDULftOAeBsliprVGt95eh6zI6XEFuxO14qCHNMgzSStbd5FaFR0eiEQSlXTzzdY1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9+ydUAd; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750754030; x=1782290030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=flKZR7yuyG2DiLmvLEzIfNFYWNL+PMNry40dPfL7mls=;
  b=O9+ydUAdr8Vkan/lvHunKH8yok6SUYV7vklihbp7AEH4J68kSlsrUgoh
   MIHP/3WI7JaLpBW/OkXCjrPcR/VVxz4+aj7GKSJZlY7C+R87ie63qdQ2N
   D/X7++Q1qWU5Lh7anwBMgtyFVJv8SJxApzoOS0mJtf5HQ7l5RI+6L6H3H
   /vRL447GydQKlaTM7m/RV5mvF4jJ/OXfTbbtgBe28uTWLT9UgpISzp0Vf
   hjEGgr8nRqIrweLVKdH3em4itnjZvcx0NqW5UpPIPhtOijF+ixOVyk+5R
   vQVikPSSuQkvSUdXxiTd4IOVioDQWd2atdTxmYDSy0qBc0YmRPeGHLVgv
   A==;
X-CSE-ConnectionGUID: CV092h8NRvCqbyHTC2rHYw==
X-CSE-MsgGUID: vDGRVZFbSpeXLg19ALbRVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53120170"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="53120170"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:33:50 -0700
X-CSE-ConnectionGUID: haltH1zlS+SXHItWB7IX2g==
X-CSE-MsgGUID: 8CYa4MZPRuiG2vGkQHSiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151604333"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:33:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:33:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:33:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxIZ8wJJWoDBDRlCNHwn+dqNJRebq1jlquch21dxytfoDZaHlZWAP5xdDMXWLkHBQJS3xP4iFcOpmE9L02svV+CGLal5eDJpM7ixhfo2z/f3iIJxXDnLy4NpqsLp6hd5KT8G0PQJMypPaLMCnTIlwVrp8wIznZv3deRlqCqe53l9DmnWQxUWfSze20/OydXl3KkVsgqQExFaukJF9pWQjJ0bFFQH+PuHuELpOGx6danJAaAaImAtw5EsYD06yULB8POnsRJJgBAgiGwqjneD6+YqUIQOImYzHZlwADdI+JSCNg6Onc7EAQu0559feDM4fKKWegK2kIlRTXv8oupkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flKZR7yuyG2DiLmvLEzIfNFYWNL+PMNry40dPfL7mls=;
 b=gdTiWUfvJor1d9BBXgxsc9xHoht5utciEZ6TcF4Igi2I82ELAeMeoK/VahqWAB6Gd7wI3sTxGlmeq1kCMBmnN0qrqyfH0+a2hIZYrINQtuu/hEo6FaExruZW3EDd1jAC4cVrQeETTZlrAjS9Byag5oNh8uSgkbp9dp/NpXl0VxZaS9QsEY0sUu0VWK/ececB6LTGSh27OjnBK747D0oS7kkM6iJwaEzcdMOK9KgVnUEvM3o/jPeOZGrDwxqLRyq5nQgxwrWoudtMQ7cL4hwERbdc4kzGQpYjSyZgbLJ8sz4r9tDTcADLQDVtuceLP0fsXE2dIkux8EYdi6jXUxp7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:33:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:33:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Enable ATS before cache tag assignment
Thread-Topic: [PATCH 1/1] iommu/vt-d: Enable ATS before cache tag assignment
Thread-Index: AQHb4aoQ6YVrx8ppsku04j/r7dtmQrQSAO+A
Date: Tue, 24 Jun 2025 08:33:29 +0000
Message-ID: <BN9PR11MB5276371ACFE0B5CEAAA021C88C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250620060802.3036137-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250620060802.3036137-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8448:EE_
x-ms-office365-filtering-correlation-id: 8a5a9b20-0d77-4761-aacf-08ddb2f9cbd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JWdO82alwx/xfbVstBT/kvK88YdiRfewvyLhI7fCgML1P5lqbNnbP6Gf6dPl?=
 =?us-ascii?Q?1MaKPOgpGIcgVJlFrQMdndowfMgbi3bXcWfBIV3XyUM/0vIHjEcYymJfFwqo?=
 =?us-ascii?Q?vZSeXASqiwkPp8UNe0sQBAF3t0TyYLuzEx0bkB/Ff+dBJ6Ykk7E5J7WeuQSm?=
 =?us-ascii?Q?q+F6Dgp1XnsA9oDmmoKDKAM+Et/36Tr32B2Govdw3+0izCebOf+G4B7BmxAP?=
 =?us-ascii?Q?TMEOMwcrNU+Y11+zksVV1qCpvzTRIRebJj1q3bfCErszlySRIc60th+RpDZQ?=
 =?us-ascii?Q?SlbOVYuraWbJSU705up6Rh4G6PcWd4AuzhYXlwqwbUAi/3l38BUItY4O7yXL?=
 =?us-ascii?Q?g90ONSVJvtS2LosksMQbubyeY/d3yvF7mfBaeG4YK1mMPZfKEY9/36AZFrsm?=
 =?us-ascii?Q?MYE08SnGb4tX9mFzstbj+RyFLLLaIRJapsxrY4uZ91EbxbTCkl5iF94i541P?=
 =?us-ascii?Q?OXMdDriatEWclVKG1jqFa86N2P+cQOehZU/lSEPgLvLOdsL6XOmsjEbPRkuO?=
 =?us-ascii?Q?X8m9vflzK3V8FWMmw21UIRoyzIeHTgJnuXYFGy6Mxe/Bd8PhkiHoaGK+4eZk?=
 =?us-ascii?Q?Y/cAoESf4OBe+0ZLA2M3jkbk/29PygK661YqDEmAuaW1oo5ofM/Y+jSYCVDd?=
 =?us-ascii?Q?Dl1US8/2cEZ7qEXDhR+2w0QttjHIBkxDAF4YycVA9O6p7URhnZxGhazYFs9O?=
 =?us-ascii?Q?k1M60df99yttMahY7UcghaAQu7V6eEHiPQMMm8wtshhk5Ej4gQo1IxQXhztb?=
 =?us-ascii?Q?ty31hr4RcYBTW4Cd0PbYxdRDc7P3rDoPZLAr11Z6h5fYYyNbderKMuhlEMxS?=
 =?us-ascii?Q?gtNro90ZeIRfZRopub6WlYJfV1VhgVP8DV6rLoV4dT+isAes5msHaVQPC8sO?=
 =?us-ascii?Q?hQnrTeJ7q7edA/cJmXMMKw+No11SXwOR/wbh047o1/sAI9BjG2o5hxoJji5i?=
 =?us-ascii?Q?Y5KSbDKc26AzojrCsv2yaUx7FA8PzFYF78KHEPt9lz3BdVhAi7VNasd59z1b?=
 =?us-ascii?Q?G7a5z855B7tY4uMnCZPQiTg07w/F9u0v0NSTbHpCY2PwVkrEGCIupa1hVVD6?=
 =?us-ascii?Q?aabMOGlLyVm3SDw/mjp2JwR9m9s2G4Wspwf2vOOVlEQiU4UuLIc4hZP1vIdM?=
 =?us-ascii?Q?/Hv7fKGB3vW6/Ta2wteZFsO6qb2pgDOuo+dSyKLKSwGdBS6+qMG/AT2CC1G4?=
 =?us-ascii?Q?0M93Hnp/sAODf4oA9Fw2FwuNSE7jV3wFz9xpre2rTtG2p0jFXBq3IM+B1wTt?=
 =?us-ascii?Q?bK8SnunLukHpftDSx5sAZjXPc5xNoNKpfsdJdleXAwqi5GeHjrbFTl4ojYDD?=
 =?us-ascii?Q?sJjFpT6uz/YIpifOe6kiZUP3OSmV4w0QBM1lsrFvpHyLjFd4NX7OQI9qPi56?=
 =?us-ascii?Q?Koo61X/gT/W4ABq/alBqu9mahZxpeWiEpwSUuvE6FocYVKYGCQsXEXxsExc7?=
 =?us-ascii?Q?8c8FyEoQYpdt+pNyV8Q35kGpbVwK8ozL/An1cJWHsW/xK6+qMTB3pg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gnRuk7sKmd3/ktFsKnzPpn1P3AlnoQ5KpaecrgW8RpkZDukTfi0PNH8T85HD?=
 =?us-ascii?Q?tf0LGrgT2L30o+bNUtbooDd9LQs3b1wiGZHqx/W6nj+niZdjtp8OBp9BFmeY?=
 =?us-ascii?Q?RWr+zDOK/3llobUvI7eUZ3RMYIpYqTbIdpW+WfG+XrI2WTvcOJWtt0V2z4Y1?=
 =?us-ascii?Q?+CagjTIwX6YD8TGF7rhzfMA4kVOvZFnAFqhRkgMKecwaozyBIgzZaEkfmc0W?=
 =?us-ascii?Q?xrNG1nHE/NJZXYOf/a2HDXX30OT6/kY1GMgg+isTekjbHrbM8e1VTODLInKf?=
 =?us-ascii?Q?77YJ4JWecmEL1yeAJYUUP2kWcVj/Rl7MMX2JBU6q6qDJIWANt2Q5c+8MPDGt?=
 =?us-ascii?Q?pGZIEX/sxI77v8Bi4CIibm0d4zV3lAxWDxu0sRRCiTBlrPXKNoTIoBAOcBi3?=
 =?us-ascii?Q?iPn8LOWPGvduXDpdo4PswcgUSnENSJtPK5fnDNp/SyDtF3KhhKw88FjkLggq?=
 =?us-ascii?Q?Qi+0yb8sbmGaH5usf3cq+xOwh6RatF5KBWRqJ8tZVAUCopQuPdGSVQCNlyDI?=
 =?us-ascii?Q?8YircreNEx+xDAspTwgPtt69y3/BIN98I5s/a2o9/ucxZSRTnFXud5oRGaoX?=
 =?us-ascii?Q?Wp/FC8JNg6I31z71dxQ+nrTqvvVySlwmmK2Vw+hh/g+qQ23z3dtmJCUO6WgH?=
 =?us-ascii?Q?omiHINCCy3SMZuI8XTZYSmxZl8R4jQGf20+9lsjZ2Knnq0KUGlz3Te7qFPas?=
 =?us-ascii?Q?7EDcEaMgXuBDMx62BHVXWHuuW4o1vMi2wx37ue4WOefRmE2I+Dx2mi6NnSIp?=
 =?us-ascii?Q?Lh7mzJ523IWTQhriCZuTjqvFFvkT7M4N8yS6lFbAFp8FlFSF/2w4zmnX3dWM?=
 =?us-ascii?Q?wm4M1CfS4PB875YVn6s4NsajTU3Fr9hIPYjQweQ21gQX+stKiHBlcTL4kBL8?=
 =?us-ascii?Q?W6cPz5fqp2mH2xH+fDwrCHCUpg7jZdRPYvRbarMweXkBc00RqZWH6hGUy1s7?=
 =?us-ascii?Q?zsFiBnz0t4mbDm3n2y1sHARmXWybwEHpSm/iYeM5gLmXKvwnoRSgpZ2shSaE?=
 =?us-ascii?Q?KyzTBMDktcBOhenykKQRnZtuKcANm50fvqDQKX0evO/WTbxPxsKgP2B96Vho?=
 =?us-ascii?Q?xdp7HEa19E+oYXceVH7c4rQf4XzldWqpbFqsa5L6rd/6cjKjJk1wOOZBPC/f?=
 =?us-ascii?Q?CzLaFgGpsaZsX6Xa8aSuCQP2ojzKSXtaLnVzCFrwee+eDzuEsi3IW4MXBLvJ?=
 =?us-ascii?Q?WvJ/n88A0+AT9TxBUF3YK7WRDpNlBL9HKWXakesUQGr94g/lYaL3aSFf0Fb+?=
 =?us-ascii?Q?2tMGslSnFqNsmufJdn7IC7aFx2pHDlu64S7w1QPlMS5OQ0K0tDua4dvPtPsj?=
 =?us-ascii?Q?qA6MXJfSBwiPTmQkUbkH3ekkrVkp3kpQm8RnchKMXhdTPHPgcW/92LuCrkQX?=
 =?us-ascii?Q?HTFDKM5KeT9FVX0HKNTtKImLifWeXbCekSaVRdbcJ3QKq9nQ5rNxSNExxZaC?=
 =?us-ascii?Q?RHMhCYDeoVtxiEeSoxIPX2m5dl279aDkdwACV/F2y/FeOj0Lozi8n26Bi2pD?=
 =?us-ascii?Q?iy44UAWWSw+6iPqIGcRP/Ez1SJHIO58Y08TB/rE+pCL8+JZ69pw2E3PLa899?=
 =?us-ascii?Q?dE8Y+9JJaNB5Sthji7P6sI1HoNhX7ArYIscmf1P/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a9b20-0d77-4761-aacf-08ddb2f9cbd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:33:29.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MueJG7P5NqNmyNdMOfvDt/QZpDcowIqfJWxy5Aj3SJHODxuO3mLR7E0hl4C30g3Rki+j1JO/9v2pLT/um175Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, June 20, 2025 2:08 PM
>=20
> Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
> failure") placed the enabling of ATS in the probe_finalize callback. This
> occurs after the default domain attachment, which is when the ATS cache
> tag is assigned. Consequently, the device TLB cache tag is missed when th=
e
> domain is attached, leading to the device TLB not being invalidated in th=
e
> iommu_unmap paths.
>=20
> Fix it by moving the ATS enabling to the default domain attachment path,
> ensuring ATS is enabled before the cache tag assignment.

this means ATS will never be enabled for drivers with driver_managed_dma
set to '1', as they don't expect their devices attached to the default doma=
in
automatically.

does it make more sense sticking to current way (enabling ATS in
probe_finalize) and assigning cache tag for device tlb at that point?

