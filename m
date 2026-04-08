Return-Path: <stable+bounces-233936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHv4MQZ91mk0FwgAu9opvQ
	(envelope-from <stable+bounces-233936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:06:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A33BEAB7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 256BF306A8F9
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2582EAD1B;
	Wed,  8 Apr 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvw7966Z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA530E834
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663916; cv=fail; b=FgH/tBL5a57dFdZb2+qw8xwZKEWuK8i+icD0w0gxr/zvcK3L9nOqVE6sqzTEUzImLW+x+sqTQwDHAulrnndSm391qLnty6HU9QU4xXZ7B9Rn4lD8nxBC4FjkQWielaYOpa2WHPznuSEI+Iw5p893Hauz0/Q29G2KdLvOutxD8S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663916; c=relaxed/simple;
	bh=QGa6kYfio+rW602Cjja9lVuBfCSdFBtwikyNHDUxSrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6SYfxZH9TIblLkfzx6O7QQoLEVVvreW3ZrhHUV587DfjdbF0piXDYnvI3WGY+uCZd8yKHF0ewmGdpbD62JnJjjG+YTgROYM50eCU8HrZ/VyotJFwOQlSisrwduMlM4CiUfVoiZZZpkDnXCIS9o6y/Vp4RhyXpdNt38NgJcgCz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvw7966Z; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775663914; x=1807199914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QGa6kYfio+rW602Cjja9lVuBfCSdFBtwikyNHDUxSrY=;
  b=nvw7966ZEhtpgpD9qOa5gr/04pVz4cSehMUTCPtC+vXUHBlBFpjVmD1+
   bYHsCfb7CSIE3rVG0mSX2Jv4GLdfL1qN5Nm7uhm6H9tt3zmLIrsPbYqIq
   iIbyvZoGxjGOoymnpXebn147UEjjfTjbi9lmOkQPgsz2GcgTeZ87ytMOF
   n5FP6q+x8XiOC8HqBeUlW5t/yZ0M0ZzmqMSXxOVMpV2VWUs+L9h/RYvvn
   Pqf8ckZorGSSgBd4vPSzeSxVx2s5Vskg1603vhAbsragpNKPtwtTd3S11
   c8El187rV8kHIZAfWr/XS3SEq+ICDY+dAuJMz7D2cHuu8fJfya7M3OAOj
   g==;
X-CSE-ConnectionGUID: U3KCHKRpRTSqA3bMHt6GgA==
X-CSE-MsgGUID: ddN/00RVRHi7mlz/Sm/UAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88035987"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="88035987"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 08:58:11 -0700
X-CSE-ConnectionGUID: btx/152iQqS1Wx1SymuqMg==
X-CSE-MsgGUID: LTj7MvDtSv26w4Th3ev0MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="225332857"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 08:58:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:58:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 08:58:11 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:58:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBERf4SmZBWbHCaxty1AVGLimszynaXAAYPA5+Y6nc9B3S3slmOBMxWTCwAx2tgQUXRQbIYPRU0nxvThd9QWx4WXYNiwyC8F9BuYkcSAE/SYim6kRBoxlo6ZVt1HWunMY3PZI/gCDLMTtAUg+xnpLR6r2Nq/1LJwxgLydV96y6HYtkWFjUzoUTwlu573A6/O2NNX+1f2zBWCaLT6F5oaWh4DXiKa1cQBPqCdOweMFmz0S7pl8uNlFTPbC51ci8Eq0hdcFES6iZmDmElx4D7vVJu8xN2TzFZuO/K1sMsDT4vBQGrWkKhygz6Z7aaoFWSoFwfxBtmhOUpBmMUXZ6fW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICXjaYM6vRD/lS7gVzWYc8dNKSYeRCM0De/xvJpvdSY=;
 b=XH9WDl7ArG/HeSuWVnFwl39iQSlxIAWCA1J3Gpm+NyEeiLZziA+c5XEkVnGPNlXKehw+cWq5V0qaYXZFcRkVGzm9fxftXydNIVH62SNWh9GGcu+kQIyw/+RDqLI35KlHOuiaZvqGdfqvrIFusnj1q5V5QY9vWPmAXim8tvW+qHQ9AOzNEuIqZ1UxumuagQOTOGykQOL4pT60YFORZGmqEjj8KQSx504+qm08y0up6tyt/roQ36P3SvLRLSBgAT9reIYqsbzugjsCQsP3ompyXUJfvvu7SMDMTntJDuH46PDPypxk64lPdKOMdImLkIrE0xyCJquiSUJKq6LYXgFD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 15:58:06 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 15:58:06 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 3/4] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on
 allocation failure
Thread-Topic: [PATCH 3/4] drm/xe: Fix bo leak in xe_dma_buf_init_obj() on
 allocation failure
Thread-Index: AQHcxswLGfbTuFGPsUyn0eME3HUjurXUm8uAgACqzwA=
Date: Wed, 8 Apr 2026 15:58:06 +0000
Message-ID: <DM4PR11MB545631685E1E7994F737E904EA5B2@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260407201542.3396317-1-shuicheng.lin@intel.com>
 <20260407201542.3396317-4-shuicheng.lin@intel.com>
 <adXhDcGmLytjuTUB@gsse-cloud1.jf.intel.com>
In-Reply-To: <adXhDcGmLytjuTUB@gsse-cloud1.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|CH3PR11MB8657:EE_
x-ms-office365-filtering-correlation-id: 53272dfd-0b63-4e16-4eb2-08de95879fa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: k+XY8i0HAjpDXyo0CiKtTjXUjHf4BKtYhue6OoMgmbLhoapS2seCsYNyEmBWVPF0lvD1C8l5iRAw+v8/C2gwbrVwKKU6f0ALmroFOKBR9wIs9IDIriYAi91gCmCxP/bDGnjmWsV17PPownf/NvTvn4iY+ym2te5E7QY7Pyqh2/96olxTu0d+l5YbdgXUi0qPDM6baWNJ8JluP6Ez3P5h1GeZOBLUly2WhGlXKCZIjlyEFUfUB+eDohluscePMnEOqIojKcNUZT5A13NLaRg3P+1w2LqBnVfF2bvQBocIwUantnFfreJtNXeWZHen3mzS46Bv6pojHwUTOcB0Ymafmq9Fnm5Sz3o5GlUkPYp+6xmwLGv0S3/oO5QfiJH7/uJO0iSlLpVgG7B3gKhr13Hozdq5CmSLC6B7A+5tRTDVRzMrisp1/7JFy0HK85WOwEdDtlnhqu6Cfh3e6O50rIGJV3uvBfqwASpMZ6EXtK+qnbPJvwYZYzBY3mhDGET9OVOU7SHJy6MvcosfmOxuXPRgGU4ixEKvHdvD/+d3WobxSUajb37UkYg/7YbaUBkbehE/oTKVNMcG7VIovIhIVmWEweGCgNm9/MXuX61xNO26B75J9fTT5ovveEjwB7T520eDe63Qjc6bTyyHKghPVXGi7hWoEAAz3bej+euhV/aWm4i3+1x5eeF2hdMt8J4ydvSHEpgTc8n+7buUef9zW85Wgem++s8YhFJg+VyWMVjyjZ0ttI0LjmqGB6YNNwEKYyJ3BoupeXAq2CLLIA17J3feXaKRv3ALe4QWFwGqMpnahZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/sVilTyG/vhjb80fbra41uoFFFj0IUlfqAIWSSj0juaoldB+m6V5ArxB53I?=
 =?us-ascii?Q?3Gk7OFb/iZWu9oKub+USMzVZoWMOpXKQFR6iPmxHUfLkzGoQRxsj/4z9uSJ3?=
 =?us-ascii?Q?ssLtsSS7MrHIEIr8gqQNMaP/lHKK2C7VAt57hUDmmndwOMVST6svJtVNDqCP?=
 =?us-ascii?Q?QcHObP4gtGiABK35+wEZVr0Ci2/8V66WbuLThcTnBcSsjCeqrRzdlQLZ2/2V?=
 =?us-ascii?Q?BjnJ+qggDQpfgNdRz67SnCYh3/46vN2cgEGwHjiPeOVb+Fglm8w/UxAlBG5a?=
 =?us-ascii?Q?PF5HNHe5rgj63yWu0u4A7Cs423KjEIQgevuQzqRd5ThyWsbvqQ1/5KxWC6zF?=
 =?us-ascii?Q?G95Lp5z+p/R1kNrdaG77JXcleNZOX4V+qghQFD4r8dCcAWQ241OF3sAM2Zqu?=
 =?us-ascii?Q?qXJOqj/8MdUcMC/FQAfAOa4cTldk7oKs6Fbgebq5krI/E0QIkzTNwTicVJ+0?=
 =?us-ascii?Q?cJ/mqf7OdeDr935DN4zaDtmIVG+nYhaUlKWSp6qddrNHSnPa+5dZNst1lEMp?=
 =?us-ascii?Q?VyVnNWLs5wUeMItwVrpuPjeV2hPVgHAFMx9W4qZypg6ezt6IePLZsjaPH9g2?=
 =?us-ascii?Q?bT6BUrTzvW8WKZKZxCzmQ3RyyD2jCyN6XsMoTUpDi3AIw+4fEiJxnjC56KcB?=
 =?us-ascii?Q?KzcYMg+3FSQiB+C9YS3h4beqUTGhmqhMsIT+kQ6Ij1QISeLkxJQxZfPVlDoJ?=
 =?us-ascii?Q?eIf5/Ttnh/gpCGfakLo67aiZFjX90+BNlzMbNhDZzBnuB4KkLXxNBeut3A/3?=
 =?us-ascii?Q?P/0IdPKvXbLmiZF0nuI+7l3fWOHM3jfxuE7SFXcPD/ORz0VTZ/P0FjOZObDN?=
 =?us-ascii?Q?/roX5CruoxYkLv1oPycdPGXRB1YGZ4WnUPg0QKvlRWj3J8SA1zbqNqjh47FB?=
 =?us-ascii?Q?92X3lCgX2C5DWzHHX06M1HAZIr42CX040ld7G+gPr1dr9hXi4dOhQ3g1F31L?=
 =?us-ascii?Q?4jcePNuoUz6eDpWApCiiJCip7JfvpgANa+Ye4pGRJrwd29LDwNyA74QFwka+?=
 =?us-ascii?Q?xMjPjMCxOSHPt53lU7mX3Xqh7OPpNuP+SvD7ySIxDtZgGacwJ35v1FDHPwVW?=
 =?us-ascii?Q?32F5OJUvkvoO/tj6kBKD6jjirydlejzlv/Nr4w6PdkPRWQ43neKVbBQax+Q0?=
 =?us-ascii?Q?Mv/JdMXA5JuknYgLzIUe0SnYszlfSxg1fyfjnTXVt+wcCKkAPYmeEw4fAADg?=
 =?us-ascii?Q?sIthcauNLquogxBhOIAsXRWec4wv8GqvLdk4h9iRMk29ySx+g6vYmJT1RzO9?=
 =?us-ascii?Q?lD2JEuy64rGhaKFm+Uky4hzVFI75JfCdzeWjK6pLboSivGJSAlJi8TbrGWto?=
 =?us-ascii?Q?n+Cz3elAJSv0WxNvq7i1Gt9fqVRCcwa3prYIhYET4YVBOtNeN4DQxatJomFg?=
 =?us-ascii?Q?ol7/fvV6dN+J21is0iNI0se6OluOKrVYLLiD5txWBBCKfrtQ6Wuoo74LshCa?=
 =?us-ascii?Q?0FZeSTKrH++tT7G30MhgUG9sVVQR6bZuGwTI6P9FN0r1hoXASca+S3fpY9Os?=
 =?us-ascii?Q?643aEmfTWy6IaDExdbZwFBKP1wrcEIW5z3U8QIswvmhfejSExjOs0ygcpdJd?=
 =?us-ascii?Q?ni22OJ7AgEX8lxopLk2aegf0oNFp9uA7pUMNoOyzS+tD6J3/rjm1iq5zaTUL?=
 =?us-ascii?Q?qSf0dspBwmhznfljrpVpiFxKzAx4Buop1lc+KQ+GNxk1SAGlKu89m1y8P8v9?=
 =?us-ascii?Q?/+ZqOVtGCAz4I7YHzr0iyPUkdMswGj/nPUHR+xDHlZbRA9O0CrBzBnq8EThG?=
 =?us-ascii?Q?w2PzPHsa/Wwq+sPfsEIuE/e+c0oBF6RH8/rycZndxmIl3nGazEzBwguUEMZx?=
x-ms-exchange-antispam-messagedata-1: zhRYM4rmpIo6XA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qPNt3TcZBD0IUs15OswEs0HDExm5CYtgq1qCZal3HefadcIwLq7XdoGj7+v0ifxqRqCuupfzeviq4g/+5Jj+eEYKevAkSW2QDut43Zh0yPhbSbK7BgvKOcnLfHOz7VPulQOrbwbb5thYCj+3oa8bcgWxlbnLKhCpQ4HX12jA3KESz28lUs5hxpNduXy3Jf7/j+AV3hp+iFk0rFABNfdf/siZTqp4JvvxsiUl859412HCPaS6dwGRm9OOJd+RjWm1OZOt7wnb7/1vr69qN5xfnHs5xI9i3w51ma2/Mtm43Zc3aI/ptu2sgmGvtvP4NRXtuLVhtLahd69Vo1pQSyoPPQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53272dfd-0b63-4e16-4eb2-08de95879fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 15:58:06.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MT5qrrXReH7peiL1sYCBB6OW5XMhyhBtuY5YzeAeu6NrV3vDZGi0RnD3VaAOdIro3MY+TL3Ksz3RIpXsnMHvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233936-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 465A33BEAB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 10:01 PM Matthew Brost wrote:
> On Tue, Apr 07, 2026 at 08:15:41PM +0000, Shuicheng Lin wrote:
> > When drm_gpuvm_resv_object_alloc() fails, the pre-allocated storage bo
> > is not freed. Add xe_bo_free(storage) before returning the error.
> >
> > Fixes: eb289a5f6cc6 ("drm/xe: Convert xe_dma_buf.c for exhaustive
> > eviction")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_dma_buf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > b/drivers/gpu/drm/xe/xe_dma_buf.c index 7f9602b3363d..24d9d82426b9
> > 100644
> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > @@ -271,8 +271,10 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct
> xe_bo *storage,
> >  	int ret =3D 0;
> >
> >  	dummy_obj =3D drm_gpuvm_resv_object_alloc(&xe->drm);
> > -	if (!dummy_obj)
> > +	if (!dummy_obj) {
>=20
> I know the comment at caller says 'Errors here will take care of freeing =
the bo.'
>=20
> But I'm not sure that is right sematic as this patch alone won't free the=
 BO give
> this line not seen in this diff:
>=20
> 296         return ret ? ERR_PTR(ret) : &bo->ttm.base;
>=20
> So IMO we make the caller own the freeing of the BO here.

xe_dma_buf_init_obj() calls xe_bo_init_locked(), which frees the BO on erro=
r.
Therefore, xe_dma_buf_init_obj() must also free the BO on its error paths.
Otherwise, since xe_gem_prime_import() cannot distinguish whether the failu=
re originated from xe_dma_buf_init_obj() or from xe_bo_init_locked(), it ca=
nnot safely decide whether the BO should be freed.

On success, ownership of the BO is transferred to the drm_gem_object.

How about add some comments in this function like below?

+/*
+ * Takes ownership of @storage: on success it is transferred to the return=
ed
+ * drm_gem_object; on failure it is freed before returning the error.
+ * This matches the contract of xe_bo_init_locked() which frees @storage o=
n
+ * its error paths, so callers need not (and must not) free @storage after
+ * this call.
+ */
 static struct drm_gem_object *
 xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
                    struct dma_buf *dma_buf)

Shuicheng

>=20
> Matt
>=20
> > +		xe_bo_free(storage);
> >  		return ERR_PTR(-ENOMEM);
> > +	}
> >
> >  	dummy_obj->resv =3D resv;
> >  	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {},
> > ret) {
> > --
> > 2.43.0
> >

