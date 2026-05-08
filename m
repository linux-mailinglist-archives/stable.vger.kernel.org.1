Return-Path: <stable+bounces-244692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNasBPGV/WmXgAAAu9opvQ
	(envelope-from <stable+bounces-244692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D04F3490
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26EE73037D5A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24036DA03;
	Fri,  8 May 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEf58viU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C930347524;
	Fri,  8 May 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226453; cv=fail; b=DSay8gGLJSPDtupIhwWt3Nu8IDhY9qLsOV8nkZmKdxpltiCb88FV5BKzUAne9PGJC/2e/39uss15yXtcrK0sP+YWXbQVxQhNjZAZZU8fdX3vsOyD6egfwv9GyxLtYSP35M6pu502TMc99rtWRaiyNn9G+9aVY0/NBjWTvAJvY88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226453; c=relaxed/simple;
	bh=2mbgiuTFLw6YnRu8qDkJ9ofSGGnQ2SepTowFCcLZlF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uM1YhUWMXx9oCjM7RTocJuGeXXI156NpFYROC54FU3OI7z5fMjZuPzMEqFq5KTCtlSD9z+1a+ahQkliPd5wp+1exFy4idHGvb7UtEtw4Gz/O/XI8HdgBKJ3PWmot5Z0+z2KPBRdFduYA0ThSxdAIYpXXQ4fX8kh46IX3UI2eY9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEf58viU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778226452; x=1809762452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2mbgiuTFLw6YnRu8qDkJ9ofSGGnQ2SepTowFCcLZlF0=;
  b=HEf58viUZbSTwAwWPbTK1uPLiu9u1wB9tpmR+26AyImkF3zeWlcwmhId
   PxT4uDB50SjyYUx4SgWPCwTsrUJqJ8gZuoq3q101nvZXQtA/glWdo02I7
   /9u7ysVf7Nnc8a3e+HMKA4Jc9W3H2nR7N45QNNjQbZHFuMESlA0UlPowe
   QXRnYj+/bHovL848TdGeq34q95GMDpS3vcyPwqtzpQLS4P1PniaBr+QJI
   2Ia2MCobJma1JbgIDGl9d2tfFU95LGWFh59lQ2QJlHvle2M8nb5nKro1g
   v5kpHugHppt+hsFwjuzEL74EUDm4KWHmFYZ3HBPeqQQ+BxwTHhyz5UfM+
   Q==;
X-CSE-ConnectionGUID: L0BEReP/Q4Sai3Z3UANXOA==
X-CSE-MsgGUID: AsSKmpoUSxSMQHLZmYodZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78335890"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="78335890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:47:31 -0700
X-CSE-ConnectionGUID: EGSSpopaTciWcp2dOmX3Qw==
X-CSE-MsgGUID: u1E+84/yST+kGrCm+UHXWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="235713598"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:47:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:47:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 00:47:30 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYUmmPcrUu0YyAgbAPtguGpFxhDu4hn+yN6s2hHOvi1006vjO46rX3EQFJzKPoUpojR09vbCdB5TTWf7pQnXZ3g3j0rJwwZT580rojw3/dPlWtKHuOrxHOyjcJKkmpWRd/JdFVn+6TRNgVUjnRjxFCZwphx0FC8ZfgT/wcuVqyI02sZD+n8qG2x80EBXdSfIHnSnZL+cMmUbwgkcjM0AYNBcZPNJSP2kGzCRDyBWGJvU1z80hOUly4bCQArhmWSZA04aHRJFKH7+44C0qP8G2xcNc7NcKuyV5CzKfkurU2uxBegtXkBV+Qo1Dmxjvl5P3rN9MeUqV4+Uce9WG8QiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKjTZjgSKnEqdFixTRyE4maRZz1Qr0ZNIFYQ+c8rTos=;
 b=byzaSKeVZ1ILu2CAzyG0WKwdPCAFMQ+UyuPExNwtuikD99xInBRC/j6CiUj6yUvyLwx/NCp4KM6B42d+NPbYa1qvRVfdzDD4t7OuIXha5w3mn7QDQSHCoOk2bvXycTmKRDRbojic7eyt4I6cmxujD91hxvkVUGt885K6qbvWppNZ85HFmduAzZlrTUNHF0v6lcmT+p8zlMuitbFPrNtAc7oizOWModp4GXiz8hsgTR8b/Uic7aFdCA0lprOFXiD4/szrbcXzhveC1GB2kUostLaB1NP59VgvglpQpmIjiK0YKNwsRwEWqhMSuDiP3CEUkLReMm/XpBu2aEPTotY6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 07:47:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:47:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com"
	<praan@google.com>, "kees@kernel.org" <kees@kernel.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jamien@nvidia.com" <jamien@nvidia.com>
Subject: RE: [PATCH rc v4 5/5] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Thread-Topic: [PATCH rc v4 5/5] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Thread-Index: AQHc16juiyY0wwRZpUygib44aRP7M7YDzaog
Date: Fri, 8 May 2026 07:47:22 +0000
Message-ID: <BN9PR11MB52767C87673D2DF9AB737E7B8C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <bb1aa2d0d1fabadb76dfef9ea9cf44f4a96c65be.1777446969.git.nicolinc@nvidia.com>
In-Reply-To: <bb1aa2d0d1fabadb76dfef9ea9cf44f4a96c65be.1777446969.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4697:EE_
x-ms-office365-filtering-correlation-id: 4e25b347-89b6-4356-0819-08deacd60a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 01AOnaLsswEYvSLEydOyTZ3GkWxRjwFT+7w8386RPFt4aHS+RluE2b01lt8+G4m/noF/jpxCFiXdhWcZkXXlF65I7DV+Ai7NJKMPML9UAePcRO5fXRjx7GFhbbEFUzJbARn5thdS3k5ezC/2SQiRzGRG9dEfnB3Z4+9c6axyxVPm1kfrlinW54VtM3PBrnHXz3C90YzAtx9qb//9hxqHXvz2RUAz/AGEpezFSYI6b8/VtaUJzqjosb1MFxYPwxs5u8GUxa5SoTIIWwJ4TbzySXJfH4b0y8D6j6PxVrXMnqMYccsn4ZYUfXYd99Lkx3deHOC5isOfPiS+RixApLUnvi7HdKzuqAmxb1h4/rML0FBxFe/sMd3UK8DV+3aD6iiciKx5dRfeO+Ok7vt+NW1AFME/5XBQVFP113OP1X68apZfVaLZpb2Pe6qwg2xbw/AvCyFm62syv+fwXqYCmYSgebaB1zKyHKVIE1IwIM6TAEaBB+Fp8TlmmkH9rnwNwLcrG6cgk6p3PpZqmPSlDqDNk1Iwi0kjXJVUeVNitoutimi/ytoId75+zdGQRv+YWHPnXBQZNpp9XTRvToUCEzYUgJMXmX0Qxe4I+ocRlbX7haFcwlKdiFrWcJf7NY7z/n8iBF5b7GkagvGIofHKgHejP1pWJb5gzZyMTfESmQ96NjHAIQ79icTDTuQqUcFj/FLPd2WyZpUMLSxNkWp/Q9Y6EA/wAUOn3nSsgP/KA4RbJtQaJCHzhtcUEv6J4Jd6pa8y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aDYC54Yaug4HrMuj7nszZDEu9dhhmqpUSt7Z8XumaMaUSE5i0f1fcZw0u/uV?=
 =?us-ascii?Q?ysNqY1fGcYS44nV+1MLcgCVLUe6HlQasdJO/bpg8MWho1F1TiziN4676zBhJ?=
 =?us-ascii?Q?gkEKqO90KlV5dwPfaFeG5PWUn9xLiDtBZRD7dR99nu+czapoBz1I4tATz53o?=
 =?us-ascii?Q?RegqKuMu+wd++V+8g680lOFY02BYImGx38NgGx/O1tGrEFghb+Qnq2AVGBGz?=
 =?us-ascii?Q?n6ymuWbaA7s3lXIoBvke1mcO96caZzZ/QZSxjqs/RefU59prp9Hy3j7lbZgF?=
 =?us-ascii?Q?xlNCZ8EDRU1JWSvJcgPMy//plOxZ1t4Pt0j1hzza8vR6l37ugp0JLWRYf8Eq?=
 =?us-ascii?Q?ZgK4aLFBCR6DyVM6rTooYnyEW4VPIfUD2WM2eY1fQRNeMkF4TtpBztuNu2jl?=
 =?us-ascii?Q?OMcEeo7NSIN1bANo5RkguLyW2hGYCss6WHApK7RFyOEyZpcOuYE0VlTZnn+X?=
 =?us-ascii?Q?lZBPmzwnZ1Bc35rzXvWMEBfcKLe4vYaaYUbNCPxibRbWOC8kjKrT2kzUSKaZ?=
 =?us-ascii?Q?+NtYHa+dqU908oapkVTOGtZVTPLXcqqYxI2o6DlMJOaYSiIUs/9RUPnmeqyP?=
 =?us-ascii?Q?bKgB07Jv2Z6a/3NOYrzCh6kwtbaWG3iyY7EK5RIZPke9HIFfzmWSHG2Bxj/I?=
 =?us-ascii?Q?4t6LSvBAps9DNyn1+3/VxroSM9dTGNHcr9vylgdbgFUudjeDeVOUpILu7ZZa?=
 =?us-ascii?Q?8ocXVJDnewOIeOx4Dw5AW7YWv2/RpatjU5yM0rdyluMSAK8QUGb7p7JwWn7p?=
 =?us-ascii?Q?C6CLKzhr3R5+zuyRLWfatinxGQro2l69RDFq1E4KNZG/x/89WwuE+N4xfAtk?=
 =?us-ascii?Q?lLoeqjF1MpAb6wJBxIW2vnpwnVpOErO71mBCgFpTFwLnxehP/xDbb6A0VdWd?=
 =?us-ascii?Q?Btmfc3tT20tYlsECwmpdnUXfkuMJFvbNImHc1xQLb3fzknAn/kfl7mf8ogQu?=
 =?us-ascii?Q?AyRsRlzj+B84bO7zgBVaa+xCTJ3dqWpbwBgeM9a3NGgQoEjg4PFb4SsbHhNB?=
 =?us-ascii?Q?Ad6SDMOlnDna83BhdxdLezL2jdflOxNISlpGb5ezVDYIgnqufRChHpcmQ3/G?=
 =?us-ascii?Q?oclK3kXamqmeUoDAFLaTwKPyhGca2Z+LM3nVA2/ONloq/NOeMk2bIYVkhJOV?=
 =?us-ascii?Q?3LjfyQTNXFabDYrW66CpfypauaKGE0rOP/n0gEs2+reKrrwmrGsEV4ExYQ5J?=
 =?us-ascii?Q?ZZ8+Baaxzx7DqC2qmtQyW+IlWAONZb3c9hlsVO/P7d1SaVIz6WDiR4Vr+j/9?=
 =?us-ascii?Q?2tYuwXga61S401yP9O2+uKZgSSMn5YpLvuE87izqWkVXvo+Olt+mVkjI2rQO?=
 =?us-ascii?Q?NiAYc9BCk26AFhrtL6ggGkVZzIBcFOldntSDN5urfzntkfZ4nt6i3AdQAJ1u?=
 =?us-ascii?Q?O+Zweopsrrpzldq9vVuJFI46y+6Ghw82PAyftStNny2Vs251dWiIXyVIByH9?=
 =?us-ascii?Q?Jv5gdkMstOv1EXrUxbuftFHIAdPZ84pgYFhkO8Ra+Hv95XVD6FTE8F7/vI46?=
 =?us-ascii?Q?qxcQG3G677pOP9BQ2ikSg84bOncTf8VlkXI1dGzE0hs0Gp4+1TRS5jQg6wBh?=
 =?us-ascii?Q?kkZjpLKj0v5aDq+tCRSBVCORV39EUXqkUE5Bz31RV/LVi7YeYzin1QV6JMJ1?=
 =?us-ascii?Q?3wLz2GNhMf9g2AWWk4Rej8kZkXZ7iFGnqZ+OH9VpJUnA+Yzm1wuA/6cHaaxS?=
 =?us-ascii?Q?1beOK6a2nVGyjNwecfvBo07oGXwXevAfB86OEBWr8Y9opLy5Fmu47017vk4m?=
 =?us-ascii?Q?rmhdGh9w8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YFJBrWbkaQTYEq8/jSLYueAx2gxM+K9iVwVMFqNM7yacpsYOEiypW7m9qGlGL270DN+Q2+4DcJFjM4rxytMmneHkygJYnBVKt2z7X+dX8vy1qPOcWWNkYGoJeqNpr+E/6JciS0QeqxgElZYhxfeNAMDRGn8XZrSvV9EbMXRCkG77JNAVYexLsESWWUPcDgg80FQgeU8CAKSmf6I8FMeqyDdiMmqq1x8qpsv2SFazJYcG/rw+CzDRIwrmUasY+aDzPOlcK/Gg8MB48jW9kcKjsHvy5qpNuwrnj1dXvrEtcSMJLaVdse43etx37SDIOQNaMqUtkuTmBBNRW0RocE/5hA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e25b347-89b6-4356-0819-08deacd60a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:47:22.8065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUDmD7vnSSqyNdv57naCEQp7qNJH6BZEOOmPAm058GzVNvecGPKopatTnO3IS6cPHrlfCzxUplfKqHnzEs+Hag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 761D04F3490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BN9PR11MB5276.namprd11.prod.outlook.com:mid,nvidia.com:email,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.tian@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 29, 2026 3:21 PM
>=20
> arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so
> it's
> natural to decide whether the kdump kernel must adopt the crashed kernel'=
s
> stream table.
>=20
> Given that memremap is used to adopt the old stream table, set this optio=
n
> only on a coherent SMMU.
>=20
> And make sure SMMU isn't in Service Failure Mode.
>=20
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU
> is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with nits:

>=20
> +static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device
> *smmu)
> +{
> +	u32 gerror, gerrorn, active;
> +
> +	/*
> +	 * If SMMU is already active in kdump case, there could be in-flight
> DMA
> +	 * from devices initiated by the crashed kernel.
> +	 */
> +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) &
> CR0_SMMUEN))
> +		return;

Above comment is for the entire function. for the check here the comment
should be that no in-fly DMA to require adoption due to SMMU disabled.

> +
> +	/* For now, only support a coherent SMMU that works with
> MEMREMAP_WB */
> +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
> +		dev_warn(smmu->dev,
> +			 "kdump: non-coherent SMMU can't adopt stream
> table\n");

"can't adopt stream table so SMMU will be reset to block all DMAs"


