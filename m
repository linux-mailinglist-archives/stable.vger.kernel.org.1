Return-Path: <stable+bounces-226610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG71NUWRuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:37:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796B2AFDD9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCAF1319A61E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2134D3A4F46;
	Tue, 17 Mar 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBmg3MbV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16183F7E84
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767459; cv=fail; b=iGIbXd7yI+f7RS1dnzen+yhBnBDX6K7Ls4ZoeurMsggdGlhg4yI9wK37iWAGW4S6tFYWlf/ORQqx8ZRkD278WzleT71hxnMOyrnSXPl69KiuRLjg8c5TalPfeqxZh9dPNNsr5+XnnTzASmYoueLLCI4HzM85h+mQgM55gDlGehY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767459; c=relaxed/simple;
	bh=bANkUhlg6YYnKC5AbTprIQJWhCSGNfbb13tA1mFR3PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YYz7IkKf7pQRiXTvYPnztppkz2BQvNyQO6mb4LAldn1BCtZ0PmORlVJNZubCoQ4f7ZSJ0E2QddYahUkeLiRKNxMAemgPYiG9r0b2iEvK8RedBzCUc0mDz6hwUaOf6K4+m190Y8xQh1vtJVlbotGOPtXgnxbIMKokygabeZaGHxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBmg3MbV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773767458; x=1805303458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bANkUhlg6YYnKC5AbTprIQJWhCSGNfbb13tA1mFR3PI=;
  b=YBmg3MbVFGTxDRdfAOYUVGnptkSDpxD7Qq0CDnn74xOx9upyiWZJwJ4v
   BTwPdSAIatOlJbVkfEIwiiMlnmhqYq3dl+uDsc5RfoT+IoN11PHTxkmWv
   K8kU3FlvwB77607A35GrB9WNeLB0DvqBruUl93umvH2ky9XIuME5aKvKd
   ARdkXQYTybQIvlL90+IoqPf9cQSuLVVpzHPmSF3+PrZZiVKwMY5sQkqJF
   GJG7sRIqz0+QmoHY7Dh0UX5J7hWmzQKn/tIWcLUeks/uKRi9aYTTIPhFO
   tJaq+aT/uTVyxfoZ/gZfcPm7Nm9rvfQeqc49c1dFlS8v1SSlNlNI/74vo
   A==;
X-CSE-ConnectionGUID: kQfDnVJgSoeJaiMRgFDQ2w==
X-CSE-MsgGUID: +4P33oCjQyuZW/kkav7DOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86282154"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="86282154"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:10:57 -0700
X-CSE-ConnectionGUID: 7nH9s2HbSx2iCTjmz55SVQ==
X-CSE-MsgGUID: ddaY2s23TXS1dxztKVlOQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="219432033"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:10:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:10:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 10:10:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXxSmpBTyAfGM4v6llEfmOHxYm2Xl21/5Y7pLDACxLsdcmsoSd9kqfFFZyPAg1npnvlNRN4ugb580IQT/zteLFcHxvxAIeJNJt0dtRWgViyE9bpnwk/l3d65bLP2lJYzcEa7A4ZJam5WoF99P0as2j/X1mcGgcAOa34OykKut37rsszuOlvfrjufNFSoW2UhPQbJlHJL+g9xmgbnIrAuVkcp/jtJwU0nFFBPRRGmZTJJBpCz9r/mMdu6KXDMNOqsPfjW2Zfq9FwOCB8fwMx4YEyXeTKEu2MMEL5BbENOQsP8YE9sUYbKB/0Sm+wjUvlpLfIMDF3uXQeOBRUKE4NajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bANkUhlg6YYnKC5AbTprIQJWhCSGNfbb13tA1mFR3PI=;
 b=KNj6wQvzGHqtDGZ3lTaCwpvgcXCgy9Emv9L2+LVPw0xUrhMm7/HeNMbbIvYuK/aNvgFscPXDBJrDNG7u+6mL2BQxpJTrFHgGDApOgt0BOXDmVWbFgtsF6gFXt3Q/SwETkhqJdJ8kNwA3jASXy68ucUvf4V2b9PBbNKtmJJ0qP2szECi2RdxHBLgQyOe927kDHCMGMNk5nl0BFzWnqxez9Td0vKQfSSdeyYP6K8/QuMMdPEDG4r5WZwEOyoRGHNIQ2kNWMzzmJXKu9hX4JcRzUKC5bLB4B9eq0AJkMnNQUVkP6KXlOdCXTP9F+m5KVGsfNBbo+uEQklTMKdSnxm8Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:10:53 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:10:53 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "Brost, Matthew" <matthew.brost@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially initialized
 sync on parse" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Thread-Index: AQHctgPgECEJeu0MVEWd50ZolA7oKrWy6OSAgAACNQCAAAjCQA==
Date: Tue, 17 Mar 2026 17:10:53 +0000
Message-ID: <DM4PR11MB5456067D5FE7F51042296C41EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <2026031732-size-unfasten-2bf3@gregkh>
 <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031748-huskiness-autistic-5186@gregkh>
In-Reply-To: <2026031748-huskiness-autistic-5186@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|SJ1PR11MB6178:EE_
x-ms-office365-filtering-correlation-id: ea5c20b5-fecc-42c0-1487-08de8448254f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 5f/V+F14gnHKxNCXjm5LQL7VluRRnQKOtfCQraBaPLEF1sDmhgO0wlUp4lQcDgtQb0wMoBLclag1NIWXjus2uABkSR2Ojrw18JTYSlkeCHYG5rnb9O6i49Bl2L3n+byOdUjRqAY24IKYIHXcpLsRG1wiO8MFJrLI4h1Fi9AcE0jT5jjlDM8s0yoJWky1zVQ0xEbmWYTuHV6cDqcTLGGFyVSfbkoj2ZhdvPI7ePnuBo7siGJ/TYcBx6BPMOGK6qE2w8J9YHVtE689BXN9NBfZZG2u2DCQCWF4pO9BIueUn+Co+WKC/qWlUYtMdF40284jzydbJ0aoEzkJloKfUcH4dyml95kloNiq3s0qveBy63j872zWflCABwcQY42/rHNHSZq0JIbOrLbyfC48MNpqPxo60qvzNN0d3bnefdxkntx1309iO4LFxygguiSNJJaMGz4ue3koxi06LZbU/tXxWM+CHMiaP37dcV+rKhku2RcqQb/qUym+lPKhgC3jsLEsAnGg291BKxRngQ6QhKJV6kF2yVbG9tMJP8yLweh1X6ziXqGQV4Rq+eeQVHNE5STY61LysmiOtCHCDtsB7rRzw6Rk+frTNOMZnTzBFyDhp+o7tMyVdhdEUbgtbOiauShs8zVK8XQXnmLy/st7L5YpXjuAtDoEHWJak9vZAzOyASoOqbX9aOvALR2i1WgC06bNNLhQ4dAGewjR3R3qZ72fNsXiQSN4yIH6u4CaZITDi0+bpnfesWwKED1ceV51GmcJ3UpdGMBVX5Z1lTzAke0xNMBRD+rCKHTY2Q1wTpCQHHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5456.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rVwQbOF7TpW8PNN8APbfLgspQN4SystBdXicg5hr1UoUfacD3nZ+tNf4vMJh?=
 =?us-ascii?Q?JvjakO/zfYR898cHhrwzpDuXvI9m7UmMt7FECYWVZ+751OHpSr3TKHyrPm4y?=
 =?us-ascii?Q?IXCQ5rvbxhrOn7j3krIAgrM3Dezbi/uTdtDuKIBuX4SxwhCamZ03Q6X/0Can?=
 =?us-ascii?Q?FIlfXjSXaNHt0kCu8kag8wHPBMpspu8oWQ9F1NO9WUxoIqNMitMFasg28E9s?=
 =?us-ascii?Q?ay/scDHTdxQZMSKptV52tQ3tb91oHQ0mE1/ym66qfFpiTXAt/E+Vi1H4WZc7?=
 =?us-ascii?Q?9pbQk7nlCW63HAZ3zU4HIZL3bBWvhJy0AYEYXihSK3NEeTnZVMW73Gteinc9?=
 =?us-ascii?Q?zRW7+1k4/yraJ6Hg4RQMFjJbFhO7ofySpH6OOxfCf3SXGZ6C9TYTh6Jk3FAI?=
 =?us-ascii?Q?+RN/6SwbhZQp3GP7C5ADPa2K52+WXGtwpGojVnunJ558ccc79GUidTk3NWfL?=
 =?us-ascii?Q?qumdxs/MRaMgHh4WXHCS+eCFfIZPfpVuT7+cGrnaWUvECTGIK2WFmGcMuhOa?=
 =?us-ascii?Q?VmfJTFCuRjPn0cpWnhyFv2BXEip7VeD7RwTrvBzKMZWcjztX0a1hTqsb9Ts/?=
 =?us-ascii?Q?qqCmjPfgHpTdjYLqpOOMnco4J0cAPFrZOdeZsAz9Io+fP89wUh0nKCZQWKGM?=
 =?us-ascii?Q?WBeGPAqy6qNb+TQXdoBfPeEVCZIYGw4/3BOofBR5hdYXQwQtLuDiim4juG3g?=
 =?us-ascii?Q?TQm21a8Wv7r+64UhjBKayCyMBw2ZrLeBBealrlTYYFWkTm+/0oAfyCQJqC/H?=
 =?us-ascii?Q?CNFl3SXPxEMJbtUuWm/v9gpRyCFUmno1xYD9lFVST3jO7FAsUwn78B77uO4F?=
 =?us-ascii?Q?FEplGXS9BO8ZXf1XBDKt9JB2BwB0biYsBbdDltgyEXaH2XiEMNw+w0wwCjlr?=
 =?us-ascii?Q?pQBrUPtayWs2UHdu4zTmtFHuUMfLeE6ZY7pytkV8x+HtSoCFoWieXO1nOT1E?=
 =?us-ascii?Q?jNP/Ie5bBY/UjOfJnIVc0qpMMds7ZFYsjQPNa0cZ5564xYxloLGvvq7PJfiH?=
 =?us-ascii?Q?Thj8L7VAuqbGCtOKckI6bY8ftMhj0TxkCNPKkCo6MAgwYNAeuKwtn3KW6cyN?=
 =?us-ascii?Q?L0I9JpL574ePicJcDgYWiKDAIzrJY3aaVspIZVE098/sAAukW38qCiGBKjB0?=
 =?us-ascii?Q?nInulu3dA0DT5/vXDft/u0/G0EZt4hWYqMDLR0Ek4zEE1M4kNp5rXGZC8mjS?=
 =?us-ascii?Q?y6hvK7TZg1lzTyQlrFRXfRvpIPuF8SoboU0l4KtTfG/7wBZaGk7uve0VF4wu?=
 =?us-ascii?Q?DTbJBcMe5NIfRcV1X+lU6i4C3l+m5LQ3Xm4LP7zXcjLa1EiEr/CfS5J9BPmk?=
 =?us-ascii?Q?Rsl4/WhDXAbywBQ8Y6aUOFxjCzLfd5+rCl1tg9vxaG/unWQYrJ6WelQD2lHm?=
 =?us-ascii?Q?p5kjcM1X5O1VFJ5WbeLO2lDLSaF89sYmu8Di0PN+E/2jGcyHqS1dRODkp0gD?=
 =?us-ascii?Q?WaWfTeT87w8Fmr9djxFfhz5cwD9TljXj5842yjXeABFQzaKs9BCJBsBRH7EZ?=
 =?us-ascii?Q?T7okw7klW9Jo3FBtdlgweuZsMQwQmniDpOKog+GzITENCoz2bMtHT1OBzT0x?=
 =?us-ascii?Q?AXlIcX2PUlmAJRK1r52cJ3R3M64SXup/Q+MwpTvI2Dg6lZvEvgGRNjFhdFDk?=
 =?us-ascii?Q?LGcCtDMjBA2TKVvnMLg/5N4TG+afXGP9Fji5oKyt1KcTCXGcezqbXp1cQy+u?=
 =?us-ascii?Q?83chidZYs8jTTrTc2tX9860p7C66fLR5BxbFz887t8yjT2QfIF1Za5ejN/Uv?=
 =?us-ascii?Q?Szwafglwng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vqPoxSKul63KzJiCEMWNMB1T4CbIQX6EpVcwxzg0PGavFXPk8J7j74hhDxI6oyaMAfWQpRNIBYqoXtzZ5hhoNAceCJWXPga/LjT3BRtJUFi4+YzI1IYeQ+TjE/j9Mi0VjjrLW2/Mjpz9Ic+2PpZQ3LABpztal48O1J9c9JnRtwSgd4kGBUYX9GMA43ph0tgi491tMKE6LfON3wIQXZ5bqSaCf1gjtFT9zjjNKdnMu+Vih1nU06lcVOYTnCRK+A621k6fJaLCOXPD0KdgHmJa5mP5r2sACUcb9WVjetJ+Wi/3+qKCjca/0RUI/jRWn/XTlUwEIVL1hZ/lCjZtgyi14g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5c20b5-fecc-42c0-1487-08de8448254f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:10:53.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMKM8rMf3hmr30BvCOFEVb+fnzBMS6qVFW+zVt93oyWZ5I2MSQ6J8psddw3AzW/VJ9jns3MQ9ayFCdNF2a6tIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226610-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuicheng.lin@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4796B2AFDD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 9:32 AM greg k-h wrote:
> On Tue, Mar 17, 2026 at 04:27:46PM +0000, Lin, Shuicheng wrote:
> > On Tue, Mar 17, 2026 4:48 AM gregkh wrote:
> > > The patch below does not apply to the 6.12-stable tree.
> > > If someone wants it applied there, or to any other stable or
> > > longterm tree, then please email the backport, including the
> > > original git commit id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following
> commands:
> > >
> > > git fetch
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> > > linux-6.12.y git checkout FETCH_HEAD git cherry-pick -x
> > > 1bfd7575092420ba5a0b944953c95b74a5646ff8
> > > # <resolve conflicts, build, test, etc.> git commit -s git
> > > send-email --to '<stable@vger.kernel.org>' --in-reply-to
> > > '2026031732-size-unfasten- 2bf3@gregkh' --subject-prefix 'PATCH 6.12.=
y'
> HEAD^..
> >
> > I cannot reproduce the failure with upper cmd.
> > The patch could be applied successfully without conflict.
> > Anyway, I follow the instructions re-send the patch.
> > Let me know if it still has issue.
>=20
> Try building it after it is applied and notice how it breaks the build :(

I tried to do it, and it could build successfully.
I checked the code and cannot find what will cause the build failure.
Could you please share me the failure signature?
Thanks.

Shuicheng

>=20
> thanks,
>=20
> greg k-h

