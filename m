Return-Path: <stable+bounces-240519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EnqEYBQ6mkhxgIAu9opvQ
	(envelope-from <stable+bounces-240519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:01:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 024BC4553F1
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE4D83054902
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47862384231;
	Thu, 23 Apr 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAuhEt5s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DD3822BB
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962250; cv=fail; b=a6FYDLYl7cUsrgj1NlAc2Lpg5YEvf4LAWiFzjMi7Tc8sQtjmukiYx1VOMUxABaD6eQ1Mo6nHX79CoyAmjhM2FP73P+sixvZcCox4jmgXRiU4zqC3IPWCYfYLvIyBxB8Ep+RCFzHXEXuXAUVCW7CBHzcawA9pSS8ASQQCSSMbya0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962250; c=relaxed/simple;
	bh=xsL2f+z3v7aY+W1czzUH01YH9K+we1g/9dXbt1hAVAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtlRfN9mDWywmolv5tWIWKavhAKIBsoqAxXVoYAse36hbhMf8w39gwhdA7XKG5U86oTuCcIK5rNg9MDdLsGY8UCEL+gF+JQVX0DDbcgiS9yuM3M4sD0QQRt9kxNt6hvxE7+V+h8eBb3k8vCrrvMwipqVFIEyATN4YmdOddi0qMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAuhEt5s; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776962248; x=1808498248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xsL2f+z3v7aY+W1czzUH01YH9K+we1g/9dXbt1hAVAc=;
  b=dAuhEt5saJVJZwRZD5bpRPVypxZl588P+fX7VcfvoK9Xt8U+xIv+yaFp
   cGP+95Vessa8ApwTc3sS5mqQ0EL3r+ZRmfjB3WC1PJf3PgMJnkE6+uo0o
   vsCEzkTSXuxQckJy1RCwhZbxZe06e/PydLx0Ivmid6TNpV2V/s9lIwc2N
   BMCSu7/XOsfOaE2xaw//S81TQpF/CGOFyRp1c4JizOSmoeFHMS1Mv4TYm
   fo7F47KxS1w1/2b99+Q9nNlwAVhwG1cr9EVz3WzvWXSowY+qReTbotoF+
   E1uC1LLPlR3Oz4P1kQg5HbqyWlfxQOIx6O3JtLoXPWMWPwUCZObI4t2rt
   A==;
X-CSE-ConnectionGUID: xpuUKHhDTcKFE2CzPhDpHQ==
X-CSE-MsgGUID: WdZ/mSQpSoehyMaNOcEHTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88547585"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="88547585"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 09:37:27 -0700
X-CSE-ConnectionGUID: b5wbVtG6SCOdCvv1dRF7/Q==
X-CSE-MsgGUID: fzc5mG70S7SEJKg/0Oh0zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="263102050"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 09:37:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 09:37:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 09:37:26 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 09:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpiMVnsMEwD6a6BHw2gqD64pYigGSOoGzfJRjW/Ty/bFPa5AmlHzkDsrkHifkxtgQ03Ay0uUQK0BW8+DlWEIQCLq1KHsqorv3GI+2xEM2IpIaDLUM6yXvAyDTdSiyNChRDKyg7IIOuSqoN+10MDWrEM36t6GMEQ49TcyE7K6+zfvACo6myZyH+22vWzlIxSZ7qeF0S/X/oxgrJV1qvbg8s8ClUWtHiBvKcii9PxhhYq37CXLnCOjtWT91vp2ZB75FokHLNzpvBjadzMZy7Mr7XlSOX4WJQ7yiASw8FLCBXluOJO8GCEl2+NOXFk33UaFyG1Xxaei/ASSkOb720KG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edRJh+szeYTEuOaASdzVMMvbTQqiPXl/hIeLbpeQvp8=;
 b=LKAjffmM7JL7ZAYkfO+Fwg+sxh50gK5P0vcACJ4EUav2b+MV3ODYW4RHg/pue0GKdyprRJPXHqapJdEAI39PKoo81FB4ycGMNyaNfstiprAJjr9dQlVq0E+sZLXew6IFFRP6lOx7fHm3O8PkbKsbfCL4/Af0vArnB2l02N7ta16uSDxZ256fQQY2/JYaGMD3IO1WXvdYl2kL8W3IbxIJBzkdbgMxlow8D5KeJHXtaOTuArtauglOcW8jX/8vB8bPEHLquvWUF3iGBxk18n7aEVvGQWYRdOc10KPQKOoGD7LLrM66FDm+vrtmK0ET+MM67Tz+jauOMpw54VtNzjuPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 16:37:23 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::c347:79e5:a47b:f3a2]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::c347:79e5:a47b:f3a2%5]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 16:37:22 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: Matt Vollrath <tactii@gmail.com>, "intel-wired-lan@osuosl.org"
	<intel-wired-lan@osuosl.org>
CC: Kohei Enju <kohei@enjuk.jp>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on
 probe failure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on
 probe failure
Thread-Index: AQHcxqnOHoBAiZCNMEu7xq2HmxlYe7Xs8LMQ
Date: Thu, 23 Apr 2026 16:37:22 +0000
Message-ID: <SA3PR11MB7527B5F9ED814B7F96ACD956A02A2@SA3PR11MB7527.namprd11.prod.outlook.com>
References: <20260407161447.43645-1-tactii@gmail.com>
In-Reply-To: <20260407161447.43645-1-tactii@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7527:EE_|SJ0PR11MB5023:EE_
x-ms-office365-filtering-correlation-id: 95d151fa-ba62-468f-8fd0-08dea1569859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3/Lzk0mjjmJP93gia/FHSSEW6GtBTs5P23xPu3+NL7Vjy47J4L/c82tOfNVm2A43TOLgX8QxAtbRGTmiGXP50d6YjnihgFJ/wAmmWd194IN/CLE54sU2mdW4eLzKHoR0eiTTP9NUR/Y9+3qLOsp7RgcavUs+6iYavXe5NEg362+uhgnNmN0yizxtOamK48jKUqbZmjvCLszzRwxV56jx73QZbW8c8ZOWPfxnaDBLThNDFCoIJmuS7JgZb1kdGArG3gbsdx0HGdbGtoUzo/DiBDkbUppuTSKU66fRdA3BZLsRvRWZORB7CX8+pzU4tOKt2EgsqWHpq7qqbzqUiyR+syQRN+koKy/Mn8E90xGSC+BM81iuN7UDoaisOuI2KwztZ1NT6QkXhZFrjRwJTaORKnZcuBRw6IJIri68pFXgscAboCvNNHORgsxvIcqr0036cTXHESLsE3g+T0Lk9iB7vrF/1ZAFwas+UfwoLukNbRzG4H+DKZa+vVLe1Gc/P/QoFAYT4EjCg8eZwFf3Lv3G+qizUVc6P547nQZRf3xOxYzrBQ7ZCPdqT/ZNRos7/VkRmxVGAam13UkzcsmqUdVXlnSvkJiVOHrYs2FdcDnM5KoPpUCSUZRHgHF0hXvkReB6gq3pSbuK7bhC19TGNd+HqDG08dMSpzd3Cp6TybxFpvDiDtWQXN/8mCSq54dkuK+EDV0ubWlsj5pu3z7JL/N4gBZ3gzo3OSlxh65xTMcRFKE821xQ+6v3Fz++JjCxKcGeRrbrC4us8+yQuR42EggV60UEnCKQvj8LTf9xEeG/WBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K5xdifsrtzSq65c8fprQuFgsDCSMua8smhSjaSbKydwbDHAR3qvQGM3RmYXw?=
 =?us-ascii?Q?Gf6VJ5NJOcqMvk/HQEtTT90HoFRY1fDJE4GpqwwyrjYWoL71n247c2RtnqzN?=
 =?us-ascii?Q?PPBHfdWrYcUR6P3AtPHkxAWgYADKnK/cCw4xo6qNgRA2wLGMBQW7StGNlqT0?=
 =?us-ascii?Q?WDOtF7L38qOGtFr5jSYUeKDt3g/3/FwHayhLxOte9+FV+vRhcF9kypjoHh7T?=
 =?us-ascii?Q?MOi20CJUnKUrw3O8DMqWOQuwXTczQ7SMdjQLvf95OsQ4zJ5s6CMcSpAFmZRw?=
 =?us-ascii?Q?Ynh7KoNOSpVHXgkqr7IpBDBYyWn3p5b2TMzVngGL/GORYOWrPfD/X+PnPD42?=
 =?us-ascii?Q?E+J83ebNN57NqUPQGz10hWRp0he0Y6cwh7L6vr+mWCk2R987L6uvEV5/Nisn?=
 =?us-ascii?Q?QpaEk+NjleszdC3hpxU7dD14HTh3jAuEjRKfPbWQr9i5mEeHd1Qj0DhRHqGg?=
 =?us-ascii?Q?u6zMkYc0iqokaYLeygGglKptpGtZVUUz2DzFpXUtMqBGOUHu33PuQkpuQrbs?=
 =?us-ascii?Q?HXj6VYGKZhRSwG2n0MnK8BY5ALyphLT6b11SFVGI+hLtsOu1L2eiGd2OSfYS?=
 =?us-ascii?Q?y/mRDjEtBjjIm7rEJQjMBQ8Dz8Z3OPib9oJ45tXmsMQ56LwZUoQlOO4yvOpn?=
 =?us-ascii?Q?XPybUkWaKeN/fUYDplqiWGB1V3meCLJXAqSFE791pCN1FhSPmLGkY0qteClS?=
 =?us-ascii?Q?lt5/MvpWSo9lkaETRNGMEU50jKe3I/LPr0c0LKl0JV7T66DvsxLlSU/mDKqD?=
 =?us-ascii?Q?gylxfRcn/PzJfQjKgeO/uDXjmxHK2BSgBi2dQi2Qv2mY0JEPtAaAg9M0h67l?=
 =?us-ascii?Q?sUR3RIKo1Jy31kLdgZazDdpsI/IMbE3Y4NSozBBSywq4GBsj4H7Q89mWSqmn?=
 =?us-ascii?Q?lyl44wrVKXCEnGH2Pgt5bXI20d3CyxGYO63VmJreq2WlRycMho1RYvWi5hJe?=
 =?us-ascii?Q?otQxvvdFfRKt2QD5nTsHLNkp1pdWYBu68Bng1tOJRkc/UJJ708GCqpqidCQG?=
 =?us-ascii?Q?f6h/qgywZtnIVgTDR7ZODXdmY1HHGqGnlB4LaB0XCG2gb8ekUpK4ngXM3rdI?=
 =?us-ascii?Q?lMZLygaJ7yKZtYdOCYmxvn7vnD2rpQnVY/SIJIPKLjz7ZUg+wo7SPuDs6rEp?=
 =?us-ascii?Q?AfDsXYy89PndORjZ0kWRtABaIEst+jFrAaZFTEJPUrb7wzWsjx41yVbwGHO8?=
 =?us-ascii?Q?FhcwLfT6gWMjZteD2g/X0POLiT+A7/PkMxGpGYJ7/Zfu8qKxpSOZK+vEhgAS?=
 =?us-ascii?Q?ZkrYlAe0sJlvb8V3xF/yRIroX9YK0iBr37dBd9o11vQt8OVmOm7jhNCUs8k5?=
 =?us-ascii?Q?qAsSLhUuHArH/gZqI3x74u+dKQ4Z/aiiiP5xfZ+ztJhTMMtMiLOoMrqAIg10?=
 =?us-ascii?Q?BJ5YaKGTEzYVrdhAwZA/QnsbnAjVu2xpyeongwlpvEHtilOVGLoqqVNjlLpV?=
 =?us-ascii?Q?MudQFeI6xzS26QdKDV7z5ds3QynIpdwCJHufm80c9fDbNlgdJ8TLU84Voo7v?=
 =?us-ascii?Q?i1QJgFkz8t2qGA/0WCe3Fn5IJ5zAAUsQQPBaDK2064BlpomNU/6j5Uv94CDf?=
 =?us-ascii?Q?QeP57LCHkevPxHiWb6d7VxYx7SOiEpeFR3q+aQaUA0JiBdrxmDYVGhvslO1g?=
 =?us-ascii?Q?MuXeWBSet7r15ricme54weiJZXD572Js16ckJzW81u0k/QyZ0Q92f8w8Ke9J?=
 =?us-ascii?Q?T3WbbwPjnCSfuM62wLjoArDdgTtxYiDflbJbbAMlG6Oe36nS4gruW5HfXbWc?=
 =?us-ascii?Q?NtqPI2VBIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BhUxJ0TBPOLQNHYYQSnZO7kM9owBLsODvN8Yd//KohKx9bnFyLRbQerwOSkrUnzBFd0JidN1EYgQ0O5XORGFIyetUktXkDXaFaaFXj8Bqmf1BvoltTOLXun6vC4ggyN39I2d6E5d5X5eEXOEpvUtcSv40j0w5KSOD8yPN4v2238zvDrf0PZq/CUHKVymFAnaCiMVPoWasv7Gtx0N0edR3e5uqDysOUsCy8+kJMEi49S9xBNXuUrICUEF7/T7AwGTx73vStEH0kWIeokMOEohRPgyc0Fdyl5tVMKPnnKI5wX1or5M2U6nQVpHjBMVQhQan3HUKMK7kwTTigG6Nfe5Gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d151fa-ba62-468f-8fd0-08dea1569859
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 16:37:22.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DX64ZKSi+PqnhEzDAQao0DXp90qXCBxMNutT//F2Q3rqlFfpV5ZZOgWfGbTzb9xAYPRSATrYPo5CFecrpAhsXwe5XE5CNSLa7bgG+PlxUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240519-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,osuosl.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email,enjuk.jp:email];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunithax.d.mekala@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 024BC4553F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
att Vollrath
> Sent: Tuesday, April 7, 2026 9:15 AM
> To: intel-wired-lan@osuosl.org
> Cc: Matt Vollrath <tactii@gmail.com>; Kohei Enju <kohei@enjuk.jp>; stable=
@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on p=
robe failure
>
> PTP pin structs are allocated early in probe, but never cleaned up.
>
> Fix this by calling i40e_ptp_free_pins in the error path.
>
> To support this, i40e_ptp_free_pins is added to the header and
> pin_config is correctly nullified after being freed.
>
> This has been an issue since i40e_ptp_alloc_pins was introduced.
>
> Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization=
 clock")
> Reported-by: Kohei Enju <kohei@enjuk.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

