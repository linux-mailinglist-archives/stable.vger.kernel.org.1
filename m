Return-Path: <stable+bounces-89540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6F9B9B00
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 00:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E294B1F21FD8
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3B01D14E9;
	Fri,  1 Nov 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebSWQ+x3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70E1D041B
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502014; cv=fail; b=QiLY+1zEFessEmEOgK8/BEkq+Bb+26J6Dogrp+Y6FdIBBs/+H96IUCmN6bM93E31I00uCW5kWGjsGI7qIQDxjdNPkj/qGpgOiyTWOB4mfM/UkQ1tu/gjsmwhjhnCasEYJ4FYsSl5a3hSd7WCbI/xYvt8kUNA8/oSVrQ4ILwShgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502014; c=relaxed/simple;
	bh=XYDpI+UFeZcbvb8IdJaGKiwzjBbaxUt2MqnvnUhUX6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TlSZ+8itZbM+16bV+0P7eFXcOqet1tUrZuvn6oU54AZQyMdV5OEJeTZbKlDeMEaZbSzIT74JfO81GFOnjsZogTCnswKH7SNdYiFQEiWq8mSmbFQY3pioDIhervSvNUqofH4p3UFzOktpJ721EU6ncAttrlSViQNlKrED9F0DfXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebSWQ+x3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730502013; x=1762038013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XYDpI+UFeZcbvb8IdJaGKiwzjBbaxUt2MqnvnUhUX6U=;
  b=ebSWQ+x3IKl7NJHfqs32Z0gWkQYU3H/j4FgpUZ4y/7lRoyXYtbedCYHZ
   mNHepxfGHVB8UZCEWCralYL/lh6XH90sMN3xH6JZSPAL8Okkx4+gn1Srr
   dhiVDsZRNH/jSkN0GZVrNao4IqJy4bQLSvuG+JJ5sWwpEzLqt3wGD5mPK
   T7Y/1/TleN0aG3QhNmE81O5hpwP0TCPEdnnJH2jFsq7UnUamfJTFJMZ98
   HnOhLU/6MPmUrF725XeThBxbgLuQFazYSXKGi0opT5qy2R6S5l7V2DmcG
   8mUu5nrVs0HLnbgoqqX6hGZ96h3FUvW0fhB7zjnXEeTjHIGDoTiIBlnXT
   Q==;
X-CSE-ConnectionGUID: SxvgtT02TCqHsFZRQZtV2g==
X-CSE-MsgGUID: kox+KfhLTMqWhKiYm12Klw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30389594"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="30389594"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 16:00:12 -0700
X-CSE-ConnectionGUID: f91wYVItQSSNzMYj5XE84w==
X-CSE-MsgGUID: iQF97a3VRhyacFpyZRnu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="88230559"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 16:00:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 16:00:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 16:00:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 16:00:11 -0700
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 23:00:06 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%4]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 23:00:06 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Singh, Tarun K"
	<tarun.k.singh@intel.com>
Subject: RE: [PATCH iwl-net v2 2/2] idpf: fix idpf_vc_core_init error path
Thread-Topic: [PATCH iwl-net v2 2/2] idpf: fix idpf_vc_core_init error path
Thread-Index: AQHbJw1GRis+gK+EPEyd9ono///A+LKjFUZg
Date: Fri, 1 Nov 2024 23:00:06 +0000
Message-ID: <MW4PR11MB5911A82DB0CBE070519439C9BA562@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
 <20241025183843.34678-3-pavan.kumar.linga@intel.com>
In-Reply-To: <20241025183843.34678-3-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|CH3PR11MB8592:EE_
x-ms-office365-filtering-correlation-id: d0df2b24-e12a-4dae-75c3-08dcfac8ed96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jInTRS+Z+FgvlCxA+jH1mH/jDDywr11kLP3mHDo5SLbm1V4ycDfLbnBNezwe?=
 =?us-ascii?Q?P+WwQhiAwZ7kV7LFCt7/h37el9uG07GFOpsTknNRKhJUL06dTERGDt+cSY4b?=
 =?us-ascii?Q?yxL5Z18KFFudDNzrgOlD3WuAbKajqXKYArm31/fM8zMrGKjUL1rvMZcJN+Qq?=
 =?us-ascii?Q?/ui1/+A4lvAtAaYNTrSdN2RhPAJgAq86ynxI8auKeU1B23fPv+27kcNmf1TF?=
 =?us-ascii?Q?bL/nENUVwZYn2APdeTgcR9ijbn/4cP1Y3UUkNNjPr+iJQwdqoFM6vLS1YYtM?=
 =?us-ascii?Q?46z4KblL0LwbYj5x7OdrlkjIEGQaMmKZUI1oSbsrlYZPjxCZvxOt9ucWcUC8?=
 =?us-ascii?Q?8y87FVLRdA04JQFAVkBukGZHDOjaS6KP62sBSgerMYDMDzhVVPVONBQRpgjJ?=
 =?us-ascii?Q?lBrpkDK2lLT/NQI1HT2LJXJubVonyNYUo8MIMLWYCi3scTylP5B4Pf45v0uF?=
 =?us-ascii?Q?njHOhh1PvFQJQP/wpjpJzm/gfhYIPR2G0V3d0hfy59N9LcBglKzduwMksyu8?=
 =?us-ascii?Q?xEb3UBcID3iOsf9MK8xpkKojjzQnjA9QXoTea6cRgwdBbjfTeoWwsBHVMcHG?=
 =?us-ascii?Q?r5l27O9i6MI6BeX/AqwphDYEQCJSwYegFkCHgXqGJr8tENJkZormBtHcKYTM?=
 =?us-ascii?Q?W6vzkX2+3Cx4njLzEO2uXzQmqPm/5WrrYfrTWsuN/UxpzX/y+xjkC1yZOSw9?=
 =?us-ascii?Q?zmBWmVhFw74+gBLlCnhfJTSibY61oUX6IFA/duftL7prZZTnPzFFQUGbB+pf?=
 =?us-ascii?Q?H0hPxjFaySVq9Q6tIKNm7u7hrXDgdnIpLsndcXnV4ZazCyRTVQKgsMxgZetz?=
 =?us-ascii?Q?FSv0J8hSLSQfXpmtUaYiXDJ6Y+eimJ/KKu1s5lvWuN8yCjEh7oXuoGA23h7o?=
 =?us-ascii?Q?Bs8VWqKyxgEjaogT2WiKIf5/jELKgee9OPukhaTEFMwCErnNFr1T8etvHSXP?=
 =?us-ascii?Q?SdryPARPzXPnPo7Amb78l6H+OtuO1b4qicYuXRYhNGJyTymscl4ODFkkMGHh?=
 =?us-ascii?Q?W9U7Qv+RnmCDMoTxFBj6dacD9yE5JudlZklZlsGhPGGyciSTNnNsouUgjAfS?=
 =?us-ascii?Q?ZwMK7jFuzGBaw2sX5FtMYP1siEQY7VAdyZ6G8ph5D6Gvgi80Nnu61Cse1ANj?=
 =?us-ascii?Q?+1ek7c2RYCnT4XNKiBYUCq0mklLMB0ZOfy4O0uZ61jx6wYFcG9zd2jdtppLm?=
 =?us-ascii?Q?xcVEDxjp62/VRk1xR2E0De95RtiFEkLQ8vjTb+Bt5fbDBrOpjf8+WdUIV94f?=
 =?us-ascii?Q?/WEKrwOOJ14vXGbkDyEhvZNBSk29TSNxvo864w8pwCab8M6duFSZgQPf3Sk4?=
 =?us-ascii?Q?2mhsHj/v2oKNjd0ULEO94aDjzcpkn4ncDhmdCgBpzMnSqyujEDbYPqzHK7mi?=
 =?us-ascii?Q?M7abHWc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FbAwHwbJBnEszEskySxT9ke+L4YgJJ/BYu/IokIP4a5vWMtZBoCxN5OmFKdM?=
 =?us-ascii?Q?GjMbvPgT3kcY1vK+45w6utKeXuu2wyRVvOUzccBn+AOUcVKV4bDOnGolfjjC?=
 =?us-ascii?Q?X3pUp5eqpt1t9I5qFYN1ucT4yQDgUtpitbGrfVubnogZRMmR6HVNF4CP2yLA?=
 =?us-ascii?Q?cO6nG0USDVUx0St1vj5FqfTOK2b5yGg2YTmFHTcgYNg9otJiJLPkap9cl3C6?=
 =?us-ascii?Q?P9n3F/Bzpoj2PF2DhIs9W6WOFJz4j034Kc8vj2c7ODkXmLD0UgbIun5vQ3r9?=
 =?us-ascii?Q?u7d6YpRJacL0nw4B7Jg9fwrTV7oQSOsV0Ub8ne9WsAo2H6yrixHjg9I0fJGn?=
 =?us-ascii?Q?+j0MXydr8kFkc82s3hMNwZdeWCyCinTibcgfh7PuxE3ljMaoQLdZThI9QcAJ?=
 =?us-ascii?Q?ajZ9xAiXzrtFfTSDx8ZEMgJ/PcwiN86tyWGSDKQ9FqPAM5IPrNj6DXF8CY+d?=
 =?us-ascii?Q?6HnEuHL8qaZ9/eVu4JPKVqy009r9cj/5nG3bwB+P2slMkzKOfF2SLyIdypPm?=
 =?us-ascii?Q?4gkyuoUhprhVEHLVr4GJcd1mrzNJTY6moliLAq81m2zk0pl/dop3OypDAYeD?=
 =?us-ascii?Q?ZfS1435Pew431w4S5/bO08AyOSFtXuYW3j7DKikB70iNfg7AvfJc+h5m5aXY?=
 =?us-ascii?Q?Ndl5DCAV1A2g5XYih14PaArGqsN88d2da0nYrAmFKq05mkGUaPgRIPdipZAa?=
 =?us-ascii?Q?soXn54uYgRxppnRDQlFC9dd69nBFSVgohsys0V82FrNUQR1Wl99RTHKZkAa5?=
 =?us-ascii?Q?MXPGHP0pBsXvvFbespwIX3YFcdrrkEpz7Sm36pJ5FVloL6lQyEhnHoY447/W?=
 =?us-ascii?Q?NW11wR8zfnQdqLeF4/8Z2VQwJBOJjo9mcgC+Lvp7rpKi+WB7QH5bJOKdL8bZ?=
 =?us-ascii?Q?+jeqVfXvWOwPIUn5UByBnOPeGN9NWUCr6cC4E/Osiatx4lWIf61NUCDLc2nF?=
 =?us-ascii?Q?jsBSrJoMsNI1/OaLFRaoik8eooG7oTIsdQ+61ccdlA+IMBhZ2kpkje0aM/iF?=
 =?us-ascii?Q?6JbUAL5yFvYvoEmwr8TPTbCbHqx0V3J22/PHyKjUH5PcKeOTwMuNW2Gs9kZP?=
 =?us-ascii?Q?X5xeWEej55+bXYXPKeoHFPQgU2DIyYxqf8eAc16O/nXhRcN50XTBzJStpVR9?=
 =?us-ascii?Q?NtlSaA6OlrUrf4aPIXZT0+3mDkaYknDXgNmFrYSufPDOQPCQE1WfwN157sjR?=
 =?us-ascii?Q?1+bFkU5Ks+IC3ixugvJESa49XTvEPbOTMJTFp6+KB1wEFYLx/NPVl/+//PMg?=
 =?us-ascii?Q?FzEGlqFyc0uL3RAommDY1WomFRQosQ4SAmtyNrCQLJ+5Wpywn7VZXacgb+97?=
 =?us-ascii?Q?DnOmmz8nBHH7XbNK7CSM1cwd4/FuE8NvYwM3mEpyZkSa7xsQjY+O0grkQArt?=
 =?us-ascii?Q?J232xx1WQleLtIgI8j25rBXV3geS6ecFdTm81EWCsPWUTzf2Zd1+9qzDNgKL?=
 =?us-ascii?Q?gpEdqJf1VRiHQ2dBF7jnomQCsDWvFt+UXYvnSi24ps3PpeFGtD6F/D1NoUaU?=
 =?us-ascii?Q?w3H5qVLLZg3kScBLTmjtgIjjqdMto/Rv3DtUvhnkdRfmIzDJmanYrfH2gWv7?=
 =?us-ascii?Q?8d4CSShTUNpYm8WOekrv5/QUtezLU5jA7rW8x5wJZaI8kp+WZvYr9Oj7Ef5A?=
 =?us-ascii?Q?yA=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyY3vk4oA4UYWooRF34sHeheARjQdYWVVX3UC4rbI+AP+yMtB/WKwRbcLYLjL1c2hbiCblrWhvXAu71PruxJ03363V/Y94W4oaAG4wtCrkVhzHkt6PdAGJR7N4uT+25CT3b1SLpfGUAbHqEbp28DHc899hyaE9ur9gpUujuzH7T0UGFEmfmh/gox30J9usaOWQ1odldLhL4yNwJ7aZutAEXUz1k2639upX5l++wnY2liiZ6dED1raEN7NXCV8hSBbmUp0tix8nR2l2oXxbIoPSwn1ml2OE0t8IBG85qwy6Nj8IU/LVcnqLVT6eKJz+rfHz3H7PT+AxyERZDwxbzqbw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtSz/MPSGuOvFY0VFwwbDrWdy4wn6rdGHF0GLdC+i+4=;
 b=aamsxFoZitUP/F9ZxknbnU0lxIgCXwrkRBUGgJZb3n0h24KM6qiMIVAzAH9VNDWGB4VuYW5qZxXlkeYLbjOOIQLqbsw3uetdPvzkmzcy3leJC+2PA4oMNWc1ykoR7x1JC5dfyA00LwCTq5/bGb4W4s89uupCQgw/MSpbFXYgN3+DYiAmTR6rbPI/iGexHMLWwKmRaVimHjawV6wO6K3drex2OLqveILozXDarJZJvPPP2lTvtCdjxLiKoDz/MWk0yf2fkUjyf9U0HkLK3pci4V1EFo6ZDUZ5+er8I3gTqPI+FcXSzYSRlV14hDgcZ4zjnWqWpVyFFo8kDtZhMfWtfg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR11MB5911.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: d0df2b24-e12a-4dae-75c3-08dcfac8ed96
x-ms-exchange-crosstenant-originalarrivaltime: 01 Nov 2024 23:00:06.5873 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 3VB7PtvE47CEjz7FcoSSTEiFxPpxHeVDcWA6ebRCz5tfwqlg3vkDRbrQls09UXFurcloMSKvUXI8LObX8FJ3aWW03JPT6vtNwOHdwH5gm2o=
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR11MB8592
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> -----Original Message-----
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Sent: Friday, October 25, 2024 11:39 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; horms@kernel.org; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>; stable@vger.kernel.org; Singh, Tarun K
> <tarun.k.singh@intel.com>
> Subject: [PATCH iwl-net v2 2/2] idpf: fix idpf_vc_core_init error path
>
> In an event where the platform running the device control plane
> is rebooted, reset is detected on the driver. It releases
> all the resources and waits for the reset to complete. Once the
> reset is done, it tries to build the resources back. At this
> time if the device control plane is not yet started, then
> the driver timeouts on the virtchnl message and retries to
> establish the mailbox again.
>
> In the retry flow, mailbox is deinitialized but the mailbox
> workqueue is still alive and polling for the mailbox message.
> This results in accessing the released control queue leading to
> null-ptr-deref. Fix it by unrolling the work queue cancellation
> and mailbox deinitialization in the reverse order which they got
> initialized.
>
> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Cc: stable@vger.kernel.org # 6.9+
> Reviewed-by: Tarun K Singh <tarun.k.singh@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
> v2:
>  - remove changes which are not fixes for the actual issue from this patc=
h
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c      | 1 +
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index c3848e10e7db..b4fbb99bfad2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>



