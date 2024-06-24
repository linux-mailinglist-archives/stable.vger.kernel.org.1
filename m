Return-Path: <stable+bounces-55022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21530914FEF
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900351F22FA7
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E42143C5C;
	Mon, 24 Jun 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUaZsZuS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879013EA72;
	Mon, 24 Jun 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239397; cv=fail; b=PyHT41MRQpR6PC1I6iV5KjNY7tzEoYDAQLiS/qVMXFdv4v4APDlhJXGmoyTCixdXmhBuAp8rbUqA819COVSfXc38je7g5waV21pPs9A1ZhCElTMQZs46FPXNdGLiXapI/6yImLuSa32O0Z49A9uTOXyYydm9UNqWWaJPcU4kiQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239397; c=relaxed/simple;
	bh=X0VCMZY4BaJ3+9KoxtxZeSwhRV7W+Oqkw7GaRz4fWDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HG5GW0Ai7nCago1wgJKsIk9yZb25nXO9ForsbwKkEaj+HaEsfn7k5zJGzRXYGl9J5PEVWEKnFoOqUW1tLPUgSX8GCnIrBb809RVlR4/MnSufPlNuA9VPPaGXrM9RjaEdqe50e3qVT9fMSvoxkm7RWtn3lRE75O5Bl2fAIR9jMq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUaZsZuS; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719239396; x=1750775396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X0VCMZY4BaJ3+9KoxtxZeSwhRV7W+Oqkw7GaRz4fWDQ=;
  b=PUaZsZuSZbcttIFrIGtOsiKf/n6HpA3T/t/vlXgr8cqDP62ku+KklX2B
   WZu0VVy8R1/wpogAKmYCBqCFPUxxhadTLjfErF9hETzQZlCqri5JzV/xj
   5yxfBXg/7iAf8H7MAVIgiFXIMYkW3fjsStCqavjyRPnJuqMCpbcNCF1tQ
   M0cr4256mj4sSt2DIoXM5yUpjt57mmV6jt8QEexYInGHNmzg7FkaXKUAn
   8mdXw3a2j9S/RKS6EUPiQb/QU0Ic6z9+XKrc6HEv4zcTgsQaRJfVkVHU2
   p69agan9baR0TZtB4r+4v35oG32u+x9Q3iN7R6Kh/DHyJh7Z3F1a1fgCs
   A==;
X-CSE-ConnectionGUID: SDEYdFioQwCybRkqfaLHAA==
X-CSE-MsgGUID: MSmBabLTTPuX9t584V/03w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12214385"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="12214385"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:29:55 -0700
X-CSE-ConnectionGUID: yNO0cW40RsGfkmwonkKCQQ==
X-CSE-MsgGUID: S20A8NMgT6S8bpvSpgLirQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48264094"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 07:29:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 07:29:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 07:29:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 07:29:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/OWob/uxa+blr/C4+1FN9dL519X1TB2m1B2XelE6qQrvTm60bUK06171TkneALxBGJpehqpbxEEbmUxPNIi4I5b7WAT6KkOzHcXUsuhCX0X73k5SmvRv+Mh/x8fo0mr0ZpBAEBJ+yOLUpUNm4QPhsWZ9xAmS4xReSbYoaq1ct+zMsp9w7AFWz94QQVSdECrRNL1bKBZksnN8Rnc15zu4JDcmBSzc0smUy51VzcIU0WKl65XKhgPsTVKxniA6kvk7Dl+CjwAnIpjWwgGQpd7vyx+V0O/2NJMn3WTRxAC4mC9RaPY5+YTb61SyV31hOtLbtXZ3i0RcOh/UOO+ViybAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8FFZhloUeftoHMl5VBhx5w/wPQhjFJNrgBDuU+2GlY=;
 b=JHs8uKWjGye+NC+EdNC64Lr62ekKDJVUS8FiHp7VUdqH161kokwKx76/G0rEDhViKaeRU/9nPbNdKo268hLE7rBubE+SjEQ94J1tkqHV7Z32ywrSh8AZBg0o9xCx5VNo5wXDNvXoDsmUPmOmhBX9qICap3j5oBYJ2Yq8yoMybEs3vaE5Orcn5A+2dbuC2zYU4gMl489j9bJg98rCWrzjeHXYDaL9f1Oubr4JIPzT0SIgAmFubfT0UKVN9tcrQ9RiJsNnHV6FIRpzKsVfoq5Nuh0jrUoPVQiMP/PfMYB0gDdNt7dDFqIjpnynkdmZECI/XPjh1uS7ZcQDU63ds6MCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by PH0PR11MB5951.namprd11.prod.outlook.com (2603:10b6:510:145::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:29:52 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7677.030; Mon, 24 Jun 2024
 14:29:51 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "Wu, Wentong" <wentong.wu@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Chen, Jason Z"
	<jason.z.chen@intel.com>
Subject: RE: [PATCH v3 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Thread-Topic: [PATCH v3 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Thread-Index: AQHaxjqbEYOjsFYhhkWsdmv3oDBNALHW+N0Q
Date: Mon, 24 Jun 2024 14:29:51 +0000
Message-ID: <PH7PR11MB760513EA18085ECE635A6606E5D42@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
 <20240624132849.4174494-3-wentong.wu@intel.com>
In-Reply-To: <20240624132849.4174494-3-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|PH0PR11MB5951:EE_
x-ms-office365-filtering-correlation-id: 0cafc26c-3e49-4e4a-af7d-08dc945a1c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?PnYpe4ziMaw/T4B+9m8i9ry9KeHuwJnJIPvngB1Yq1aQjepMQIPY073CtfWY?=
 =?us-ascii?Q?/fet6dShf1GExM3L4YlLwC4kbqzkVAU1rrJtmuq49sPZKeY6PlcfbokhAtom?=
 =?us-ascii?Q?U1oe8vQEBYMn/syVy+eiI4nCA9OLdjMezaXQUPOOhpAD8SkI+JlWyxXWtZZZ?=
 =?us-ascii?Q?SFx6sgACobXStX22yBKKSQBlS6qQnUKAsgtrt1WQ1sr5WVMCFgfiZJe9hH48?=
 =?us-ascii?Q?Qe+Ti5W77gGbaaEZL+MDllHdc+4zVffQjRl2LDAtBLIP7q4MXwCEHY22V2ec?=
 =?us-ascii?Q?b1WNFN+rDog6JU+d4Hlzp+RfUMze/2NgMQOx3ATISKx45iBpcJ0RFsj/Vb8A?=
 =?us-ascii?Q?oqH8JdFcYq0NCE8yAZ1rzK/afqodActPLP5Gs4wUdf4ZIMfIjnyJ+vghpc1M?=
 =?us-ascii?Q?c6b+YcLr5jx9WE25w+/GxA1ZRbzM6noklR92cUF8dIq1FQCwARkdyYdl1wis?=
 =?us-ascii?Q?SRgrPKUc8ya+u+V0cCcN3iLEwOSrDGQuKvdAcYcWDzkOBSSFumtUnMJIPhlP?=
 =?us-ascii?Q?VUjaTbVurqmXdfdsbJeqevnKA4ErqGkmxwT0UExCJRP8FaqGCeCwfRku0j0D?=
 =?us-ascii?Q?DCXzKgunGB6+96n/Rnyx1atzZEGoA7AWsjLlIuCxOhjwVF4ftVlHK0yqnMcf?=
 =?us-ascii?Q?MTMa7umhrlY7svNwcq4PQdLs0wdATKsh/HfXCCJbyyxyHjaWIAQnZmkCsy22?=
 =?us-ascii?Q?E4eBjnkz0g32RtgJ+LyHUIp/nz4gdy0DJKIDr3k2QImJzJyFxiGEMIbXIMT4?=
 =?us-ascii?Q?sWCW0GoKA3UvfkO7r+pzV+QZbHrOF3mS8j/H31V4h+PQth9x1LfxTRFvrFL+?=
 =?us-ascii?Q?XmuArSr24UTdiM5Igsw0GwkrJOjc9T0u8tAp3RvwRLfZj34/DxDUeMs+Y6Fu?=
 =?us-ascii?Q?VJYn+bQYYpoN+k60O9PaVZLlzvNkxuwgQN0L7ltDn8ltqMdhemVYxb0YljK9?=
 =?us-ascii?Q?nVQy1jgmQXl3/A3rI2AtrHJVM8zpbp5ji+1UaBSdsA8wI6VbXPZ/LaM21DIO?=
 =?us-ascii?Q?Ukx51T9qNny+ZQAfH4jTKr+yRgA9QepdiG2k77iNDJuMoV9MGGEqEVD94Egn?=
 =?us-ascii?Q?BbYUdwyLH1fi6qNyYegJh6S0Hlfj1pBtVabTYtTmp/MN6lZOwgYIovlna8Uw?=
 =?us-ascii?Q?q/6FbSO08PfevuNo91DlD0TPFu/dLi/UlUFtCikEE2RKsK7lhpE+ms/Plqk0?=
 =?us-ascii?Q?5bDumT91E4fPITES1RVu359XveCeX2A9gntJeZeeagX8fExp4RbXgSpIyBoz?=
 =?us-ascii?Q?mieRnKoSTFtdpXWp64zPkhJvbvQwZ7tdoviY/xJj5bZlNitk7Vzg/TM0B64O?=
 =?us-ascii?Q?AcYd6KtvQvxxghkGn7kNLWlEmE1wOZ0uPFD8jH25QuvPd+iMoYuHN4FrZJdp?=
 =?us-ascii?Q?2h+tq7Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?keLKd3jgQHcA30zN4s7/W28WYiMbjI52uw/Tok4nSTY5MSCjvRqHyxfbYZi7?=
 =?us-ascii?Q?mddvmDBgwlFo2jRbFiYzM3Q0t/+BE2OCIiqdq2sE6LFl1mS+qgCW71PfGhS7?=
 =?us-ascii?Q?g1ZO/s+h+vBx49qLe56RhzTuyzjW54RNp3ksf09P2HDRLkU2mO7m3AymIg3H?=
 =?us-ascii?Q?pdw6o+BrFndpbO3aEzWJ9JAXLiAQGzjWtv50pLyg/wEREKi1DGxyvqMQw2Rf?=
 =?us-ascii?Q?6wvyTqKzIXKj7Snv/UARMuT+IXMcRGyFvXQ/k3v5wPyhfLQYEb/ilUso3lse?=
 =?us-ascii?Q?IR99sUSetAzer7wxfHPR2LCqz/hnpCAuLOzlM8zi+3thc/G2ZYQwtcoBW3WW?=
 =?us-ascii?Q?tYk0vHH7t4rXkqonoDsuDta2qln5wRqfygV3lHs5PNMXu5aBaSvlQgSSftLd?=
 =?us-ascii?Q?FhG/CF5JXB8qfIRQjzOcaOtn2lt9dAvKIfVzrk6I45vD+VyH8E8qpjYwwSST?=
 =?us-ascii?Q?7V66y/ZkB4HNoXkMsWfqKeyh/2352BMCNTQJiEzW2suOvqInhS0CI1+YwJo2?=
 =?us-ascii?Q?ELufUOCrDPN447DmVjM60Vk+B4qzDbpms8Z2XgwmedY3z2HpZRz2XDJ0x2Lm?=
 =?us-ascii?Q?Bksh2zWsIu6yt/NGna8cnjDBH4oKb4igU9HyQtQxORtRZqAy1ZwyjCbUg7fR?=
 =?us-ascii?Q?dPAKVwKwFdQe0dKDUgT7Q6kRCo1b7XGzgRMbJ/bc1AY8IUQBAcGCHULR12lI?=
 =?us-ascii?Q?WetQzLonyMMZyiM3qPk1m+b1c3AKFYi2YMp4m2gvOM6KgYN8T1CwX51ajV0G?=
 =?us-ascii?Q?rPM0UnFot6i8VCZEmNT/WCQLDbgePLKgoVaqjcJ54UTeJcXJxicgM2v+4zM4?=
 =?us-ascii?Q?Er194Az/y3IayLXOWmwWBILfqpICr4LFO/e5thCBXo/EWXsx+Zt4+R0U+orX?=
 =?us-ascii?Q?UNQ6R6OBt7sgeB46Q/SIYe369ZKQSJOqoKCcBbswqjcElb7s4Nx+EgNfZ1bf?=
 =?us-ascii?Q?vD8ZzANArnk8IbqqYJO7oMHGu7Qunl4A42jjp64U9LqN/R1KBuUPK9Qijm5u?=
 =?us-ascii?Q?gM+wNcnDmUzc7XlFfum/QA+U7/rhHfAEKIiOUg2p6vHQ++s6b03/kDuRXb8b?=
 =?us-ascii?Q?JGZ6+mk6GHg4duAXtdM9BLVUY61mug8Np+Q8BW/c4e0CzHY+8P7BNgrT7KPV?=
 =?us-ascii?Q?OwRswCmdRzHBP71n4dh3/wmjuSDC4tAZejCL3x7ivxvC1EmOFZ5pLBdCcg1J?=
 =?us-ascii?Q?+zSihR9ZDSM0aVZLrSXywED0OE1qQLU3v62U6qLl+gsZCjgsowJHPyYtYjaO?=
 =?us-ascii?Q?FHjM7JNn26vGjRorr2h9+gZTkYiX3AK2x4pD0GEZpI4hbtEVODl7Bp2AAavL?=
 =?us-ascii?Q?Z5X9dQkLPMgGFpsDPdBOOuGv7ugkZ4VQWxK4wKQ1PtjOyoADXMQtnR2qDLXH?=
 =?us-ascii?Q?p3jYpKfHsVNKfXlvf2IfVkcCUOguRHzLy3VDwgkWsYJemSpkAjbXg/tYGOMD?=
 =?us-ascii?Q?O3nGhhRhFNMXwt0D71qUEtKNgHa9btMrEbdTT2CxVcL0ZF72JkLQMcubtZV8?=
 =?us-ascii?Q?B18BVhYTZPIMV6Vmf/5spSe/0qCXHQUDCYD8pmmUDyFrfCCbgIJzE6Sh9Na/?=
 =?us-ascii?Q?65xDsAs7Exl7APnzPUr7hLsw7y9KOOy+0miMPGJm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cafc26c-3e49-4e4a-af7d-08dc945a1c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 14:29:51.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdqrAtx5IXvsr5fSMQLrZW2D458BMQAEBEUHUzeBsdtMaejARHugg95lk1q3YdcgCEuVJ4TL4qrGWh6LYr0Jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5951
X-OriginatorOrg: intel.com

> Constructing the SPI transfer command as per the specific request.

Please provide "Why" , this is not straight forward to understand, also des=
erves a comment in code.

>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8+
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Tested-by: Jason Chen <jason.z.chen@intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> 5f3195636e53..26387e2f1dd7 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void
> *obuf, void *ibuf, size_t len)
>  		return ret;
>  	}
>=20
> -	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> +	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : NULL, len);
>  	if (ret)
>  		return ret;
>=20
> --
> 2.34.1


