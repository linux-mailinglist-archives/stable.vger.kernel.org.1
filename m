Return-Path: <stable+bounces-206090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A88CFBD7A
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 04:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81427304227D
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423CA2139C9;
	Wed,  7 Jan 2026 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoIgE96v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57E1DFDA1
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756742; cv=fail; b=oUOdViedPSH0KzEJOfmJjIFIs1CLUK2ESxxi/6641mkyBmtnz0r/q52MlrB4hLKeJ579qXCpGqXDxZbCJM12nzVHa6bsBh6keILels6rS/PqwjK5JNaoPpkvM/NSRbjiCq9sRtXDaOXAYQiUjUfG+EYAYbJ/LURCTuMqbMr7LiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756742; c=relaxed/simple;
	bh=3Z+OFr/bFP/7pabfkCs6+sjenZMuH2DCnCoAJC7Jf60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IjoFWxMIY1qoWpyGuuTCH2inc1lshGa9lHdfJkmC7n8rEUaxMM0k+M5qBOZwr5z78Hzg+M+Kw7jq669eCdWu5X/Nmw3tizTfCLgLQwxlQfEw8wR5tja5Z7GDyKbebgk+A75nIrMpcAiuPoYyxcyLaRPV9OiA1aJVYjOwRUvrjD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoIgE96v; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767756740; x=1799292740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Z+OFr/bFP/7pabfkCs6+sjenZMuH2DCnCoAJC7Jf60=;
  b=YoIgE96v5D6bJEgKdXIRqD1PkmrcMIHfNDYEBPdwp13AoRAbF7Z4YnKE
   MNG/iOkD8leMn5rzQfk64Hq9m8Ls566cMHTCnNlyRcliHpQYWK89vs/sL
   srIiCMm/DKZ7+l0FKELNdreARKADhKGwtkvTfmVqLbAYU0YL8Zqb/rtLV
   BIqX5wY9z4hu8sCC0UwNLfj5kKIBOI9UhBWHk7DQSIELBWH7XBAZVw9Ly
   I6PMv9D9gKd6m+6Su9C+yshkh73okQe+um8Y+z5t4GRFawTOEEDqaAqSW
   zQVbZ8NBpwktrLyOaa/XPFJWdrZW72qRsgdpd8CHU7sWYJ1mP5vsC0q9/
   A==;
X-CSE-ConnectionGUID: pAfuj8hyRzejutE1X0wPrg==
X-CSE-MsgGUID: Qag2nlsiS3GIunh2GaPBVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72756367"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="72756367"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 19:32:19 -0800
X-CSE-ConnectionGUID: qnEU1r5CRVq9ZO1CQag1WA==
X-CSE-MsgGUID: 4Vwk0oneQnmmq+soPZw6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="202868808"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 19:32:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 19:32:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 6 Jan 2026 19:32:19 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 6 Jan 2026 19:32:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scrEs7cHJ/yOmRAMV3YAuD+6bVJ6SrjSJsj14Cs8SWiatJuPRsHIwo8v+WPKbhzs4/iKDXk2kp6naam00tW0iymS0wELDOj1lMDLlD9HLuVeCvlLI6MLzDhELt6Gp2FI7Wt6jUSbM3SFJCBMlItEtVKKkoKS6HHEeqlDlgc0Smkj4KUbmW/BiLihJbVUjsXFo42e/lHxnFKDZ2e+eO5GDiAtB7oHznV6Qlvu+L5PZeuUPbUEY/2eL6oS6nLkNeItlFgemKCD9ucqkui7JsaTobdYdG0p8TE1Rcx1X0T38nu21C17WCF3+2IX9GPrg0ZpgU0ftUty3fwN/PngW1AkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IORlROLzqE5SmJ7CnqC7rmHbaxuoqyeVoHKo1alfH/c=;
 b=vqBjFU++g7exsidxP70Zj8Izh7NDSPD3BV0GfWu4slXdVOfCaQ6B01oz9kFRGrMbTb+FT5FDMJNMm5F+A6DF9LIrahUhjwahZZ5xZNE+eo76hQljwZDhYdJtZOlPzLGK1Rm8tBvZw1pCU1i1uymEJSLjWZgR5gDSODA2WRFHFwjQgBvys4nPmNDDO5+vOfX9XLUkbdlZ9wYGZblBI3K4dU73SfnZcEc0m82aQxib6jTbTl6oFdAJQ559zen8dNgi/fNqvV6xyvHn1wcQ4fBOGYvFd+FQMOtj8EvVlV4/49frMiIq2cHPSMXBVRLC7M6YOTj7UiGTmtk+BXMg1q3APA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7711.namprd11.prod.outlook.com (2603:10b6:510:291::6)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 03:32:15 +0000
Received: from PH0PR11MB7711.namprd11.prod.outlook.com
 ([fe80::8c82:8ec0:f48f:b823]) by PH0PR11MB7711.namprd11.prod.outlook.com
 ([fe80::8c82:8ec0:f48f:b823%4]) with mapi id 15.20.9478.005; Wed, 7 Jan 2026
 03:32:15 +0000
From: "Alvi, Arselan" <arselan.alvi@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting
 functions
Thread-Topic: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting
 functions
Thread-Index: AQHcf2uqRhWvGej4REKDRt7CFPctzrVGDXPM
Date: Wed, 7 Jan 2026 03:32:15 +0000
Message-ID: <PH0PR11MB7711D37732D3B716A1BBC51F9584A@PH0PR11MB7711.namprd11.prod.outlook.com>
References: <20260107002154.1934332-1-matthew.brost@intel.com>
In-Reply-To: <20260107002154.1934332-1-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7711:EE_|IA0PR11MB7935:EE_
x-ms-office365-filtering-correlation-id: 1ec88d9e-d3af-4b92-d6c2-08de4d9d5a77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PJ4Cf7EZZdfKXQnkogD4sp+lXr+YhcIrMh89aJXDH0r2EmHMKLlz63RdKK6L?=
 =?us-ascii?Q?MiqO/+BAOmkoTlGO/LBOO2iSPhLNQbLXzysma+7lYsOgZQuggzZXFfbAW79z?=
 =?us-ascii?Q?5PwoYtqXh9Tz+3y1ax+yMrWQZmXvZrjd2rRCfOa8fpHwTuGarAhfq8c8p8Zj?=
 =?us-ascii?Q?tMsBrPe4D5jP2eo7Ne9p2t/806OxlR0yTTEPVCZEzjzuVCZ4D3Twu99H4Zvv?=
 =?us-ascii?Q?zsN5UVhVYA9K5C5oPGqGN/1xwbFltMGXU/5QddtLxeRrQpdErO2nXvnnmHEk?=
 =?us-ascii?Q?VRML+ebXU06Ei+TUzRTlZmUcCpGpzyoW0DsMJhPSyiCweQzOy5v+/J2xgiI2?=
 =?us-ascii?Q?kLT1Sso1JdEHqe2dI+opMOqjQ9aXK9Kuh/kzyOwJ9PrC57S5El95YbAVK8bx?=
 =?us-ascii?Q?GKFhUxIwPZSz+Nqj/jKMxmkjLSq/hYj8uVtrHQSXoe6zuLA7eeQwwzRgnaDm?=
 =?us-ascii?Q?8aCl+nag7tBDoXiSjRlR7eATwRefry6Wxm6RQgsEHXsSITo79FaaSHLpl33Z?=
 =?us-ascii?Q?jyEUFNacwV+DSuEyd7/SqjRIpWhnnooSHEGAG3hxVSBHBLXB33fZrUGCvQzJ?=
 =?us-ascii?Q?EdFnstWYvjOH2KmrJWsFrJRRXl4Mv3buFIJ1eFixGIE21UCBdQp2nIc8ySvO?=
 =?us-ascii?Q?IoSjTG01WLyMaLBFHk/zS4vW2oOzOXxJBMMmUKS0wmvjcNj2fP3HK6ACjNOx?=
 =?us-ascii?Q?d7Wp1pfTa0lJz66HG4jR90SCkpBjo2ZpEZ3xn7YUZyDl5h8Me/NUuLtwl/+y?=
 =?us-ascii?Q?l5gVtwpp8hRfOC5aME0pBr62whqmHXUrCrONziWM/QdK0A4mTI3r+emhiDhv?=
 =?us-ascii?Q?Sj7FiDUbwRx0Gk33eZauOdjMRWrJ/XSyOemFDBoxP6JwFhYLnhNtdUDDxzw+?=
 =?us-ascii?Q?qQrvRLEtRJlQuQ/oVp8u/7OFv9YALnzMxM2sshcLgjilRwv54gCdp+e+AbX4?=
 =?us-ascii?Q?Fvd3b8la1uRI5Mwe4KO8PtQYLZQUAd6JpX1LQ6XNQtFBsRPc4rZyB0Cdu607?=
 =?us-ascii?Q?6tg76hgdoIbjHQI52CtsGu8yeFHp+K1DpwK+/ZNwwjOpQHr8E9MiIWmAJy7z?=
 =?us-ascii?Q?gl1q0kpiOawjuk9iAWMMvYIBlgDryf/BvgWEpEQ46J7fR/FRzPWLGj3G25v7?=
 =?us-ascii?Q?QRnlI3QsiKBCJKmeV3NX1AMsE6tGiv/SMm43bGQWDR+sZ8BpBCJrv1Q/ySo4?=
 =?us-ascii?Q?1mX3cjIydl98PkL5L23isjLq4Kz38MdoFzuUEc0/YKmBm20CMcdO4gwRkwNf?=
 =?us-ascii?Q?wH5xzeYJ6aqfnEONa9jYToXAiDrXmJNCY29sLOoOiOaarYkFJ3obCEVnjzi0?=
 =?us-ascii?Q?dNokD2UIspKxyHDXkwgzuEoSnk6H08MBvmsgDbP6UvCVSxSbl5LCEHLejUrf?=
 =?us-ascii?Q?yE71rsPF/5saJVxIhpvbsUToDJvBiZmVyD+3LAiceeFEHcpE0bdwart/NpIt?=
 =?us-ascii?Q?7JWj51J93v+KcQXm8W7ESnXXFpVOqMx1x/F9srWQ5aEl+h8qH1JCmH0QRFaC?=
 =?us-ascii?Q?CfOI9ALWoyUn3zlix2PAH+A2KSyritdWnVmw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7711.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gHWboNZth4ZWvzLwtBbYhY2ACA5T7HIBAXSFVYoMuME8dVKdWEEq6rH4rr8R?=
 =?us-ascii?Q?uJJY57yLyycu34fG2200uoB2H6tchA2+s9dE2MYRbowjMreR8Orf/X3ddMRe?=
 =?us-ascii?Q?wpOnSa6bmioBJ3FMlrhk29nqrpCGz3CodLF/L/xhtoCguWH2Nn0qVXAGD+Ty?=
 =?us-ascii?Q?vJ/fqpl3Df9rBMbiFIEiaC8f3cJ+4ciint3bkgvjUEekh7wPasmPKPUD/63N?=
 =?us-ascii?Q?AerIlvqeOibfISBO5USWhYJaG3E/C21tfOQs2uEfKyD54WtohxIQuJUhFAw0?=
 =?us-ascii?Q?HI1agSji6t/X7VngmwIUr9NI/WfC/P2eDL+GVM9mIrhlYzdFhStTNVkE2L9a?=
 =?us-ascii?Q?a6hdidupAQdJxvR/pEDzH99z31+dZDBOCuuLP/S9Qjg95u6Rnyfjz88QrcdE?=
 =?us-ascii?Q?GAghaE2evLPYI9R6nt+Rct/jXCLINn8m4e4W4F1zhMtSetxiiVeqQ0FbKhk9?=
 =?us-ascii?Q?N54j6lFfCljpZVjT5wi3d0h/X/js0y/CXMj82puZCi/yj82wIYd3GRYN716U?=
 =?us-ascii?Q?BZddK/+WemeMmFaBmlG41/TS81ss303Y9XL9JclehjyEH5GTaYsYfaWXn5a4?=
 =?us-ascii?Q?UMCiB//3N6nlYVXXNo+MMJglOlFrj9Z3NVxPqmoEUFBtwzxWkRHmf6RrkRe4?=
 =?us-ascii?Q?sp2TGwZNLUyAFNhSCllqC6TsjEJLlkem3Y221mxFQ49IiuFhEyyurVN9sxzK?=
 =?us-ascii?Q?SXmUsS3HYvNEni4oOgX69pSRnn0Vjp6ShvcmH9cyCGxC9F4tmsE/tL2xv85R?=
 =?us-ascii?Q?GV6JJKxmfXyxIABtul87kiLfupSQ+lgAFWu/6gLyeKR+bRkipatp4y0I03kc?=
 =?us-ascii?Q?yI+XeA4f1c/cI+GvAcBtD4kTvo1Yf9P2veZNvyqjmjev45LYVY2JvRMso1CJ?=
 =?us-ascii?Q?5o9ScnGMFR+l1RKPrim+lAhGljNCCUfflUX8Ym4vFkWu+BhHjz4SXHVgYBFI?=
 =?us-ascii?Q?Kk+hD1k2ibDFm1A32PU35bf4ClxOo3WgYCXixQs4jpRn2rIF19HUm4RARpnz?=
 =?us-ascii?Q?nOmWhZ1kbDQjG33fCfPVbjvGeiu0OPQgh8Uv1R7bxW0JSUpUIOYMIyNjzvK+?=
 =?us-ascii?Q?sITRsbhLvdQarNQ0uq4nfP1bHAvmThJ0xsyIkdLG0QBob5NwifnAColGNgRg?=
 =?us-ascii?Q?AIj/N1R5Au+BFn0s8ww7L/NXYJMXcorXDdogniGm5qoqM0IXC1pT/4jTlFEk?=
 =?us-ascii?Q?UVC/tEkMWvct1EZiwQcsnLWlBzoPe4IcRwxkUfLfiv39wk293TDu3LdBfYgy?=
 =?us-ascii?Q?YFFy0i7CK1wkS3FH0eWCmDt/ncNB2V3Wqq40xb7oqQKbMi0s1rhhusBfldml?=
 =?us-ascii?Q?+8NcA23XHo5b1HF58TzDZ+kBi3jK3/uRPGWeozNUdV9EFneocDk4KGRRWRgf?=
 =?us-ascii?Q?YDQ0esGfYshSuQrjiyYl0MdXd6AA1QlaKRRCicSfsgwZqu+B0EZQpyoU/Iwi?=
 =?us-ascii?Q?3BWLXAvh9LrK1vSezTe12adkI2eUVgCS3oBMqYs3zGlGP0ymXsV5is83byH2?=
 =?us-ascii?Q?kNpr/YrZPsNM6fMdxaq6uL4d87OZ1mjE9kCwt4VmiDcZua0E5r17+IAepEDt?=
 =?us-ascii?Q?ifaj3RovyStR/cTV476GMz1A2Wjn8b/xKY57laOkizdSZODpbptov4V9ATqS?=
 =?us-ascii?Q?LFReE6OxRYoDWta1ZKOuQCzYfZkvGO2ayCO17oQhyQJmUCCHhc1CkoHfTsXZ?=
 =?us-ascii?Q?nMSm7jigexA87J9YUWDgTeVfJmB5m/15tyC4hQzDW+DQKX83B1Y9w8PWMfMA?=
 =?us-ascii?Q?TC1CrGtaIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec88d9e-d3af-4b92-d6c2-08de4d9d5a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 03:32:15.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8pZ50jrO2ZSGL80AiDthsFRlc+clHdi8bRScRr92b63ODdbieokbqP0EF493ow5puApnttJoEQzu4lFZR7Brw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
X-OriginatorOrg: intel.com

Tested-by: Arselan Alvi <arselan.alvi@intel.com>

________________________________________
From: Brost, Matthew <matthew.brost@intel.com>
Sent: Tuesday, January 6, 2026 4:21 PM
To: intel-xe@lists.freedesktop.org
Cc: Alvi, Arselan; stable@vger.kernel.org
Subject: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting funct=
ions

Page accounting can change via the shrinker without calling
xe_ttm_tt_unpopulate(), but those paths already update accounting
through the xe_ttm_tt_account_*() helpers.

Move the page count tracepoints into xe_ttm_tt_account_add() and
xe_ttm_tt_account_subtract() so accounting updates are recorded
consistently, regardless of whether pages are populated, unpopulated,
or reclaimed via the shrinker.

This avoids missing page count updates and keeps global accounting
balanced across all TT lifecycle paths.

Cc: stable@vger.kernel.org
Fixes: ce3d39fae3d3 ("drm/xe/bo: add GPU memory trace points")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 8b6474cd3eaf..33afaee38f48 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -432,6 +432,9 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
        return xe_tt->sg;
 }

+static void update_global_total_pages(struct ttm_device *ttm_dev,
+                                     long num_pages);
+
 /*
  * Account ttm pages against the device shrinker's shrinkable and
  * purgeable counts.
@@ -440,6 +443,7 @@ static void xe_ttm_tt_account_add(struct xe_device *xe,=
 struct ttm_tt *tt)
 {
        struct xe_ttm_tt *xe_tt =3D container_of(tt, struct xe_ttm_tt, ttm)=
;

+       update_global_total_pages(&xe->ttm, tt->num_pages);
        if (xe_tt->purgeable)
                xe_shrinker_mod_pages(xe->mem.shrinker, 0, tt->num_pages);
        else
@@ -450,6 +454,7 @@ static void xe_ttm_tt_account_subtract(struct xe_device=
 *xe, struct ttm_tt *tt)
 {
        struct xe_ttm_tt *xe_tt =3D container_of(tt, struct xe_ttm_tt, ttm)=
;

+       update_global_total_pages(&xe->ttm, -(long)tt->num_pages);
        if (xe_tt->purgeable)
                xe_shrinker_mod_pages(xe->mem.shrinker, 0, -(long)tt->num_p=
ages);
        else
@@ -575,7 +580,6 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_de=
v, struct ttm_tt *tt,

        xe_tt->purgeable =3D false;
        xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt);
-       update_global_total_pages(ttm_dev, tt->num_pages);

        return 0;
 }
@@ -592,7 +596,6 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm=
_dev, struct ttm_tt *tt)

        ttm_pool_free(&ttm_dev->pool, tt);
        xe_ttm_tt_account_subtract(xe, tt);
-       update_global_total_pages(ttm_dev, -(long)tt->num_pages);
 }

 static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *t=
t)
--
2.34.1


