Return-Path: <stable+bounces-42802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069128B7BFF
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264431C237BA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B88173322;
	Tue, 30 Apr 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaOukIBU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC9128375
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491752; cv=fail; b=XgWC0RSYR30Q1odZU/MYV0nhhUkNcv0d0Pwnm2bKhE8IpLYPvmF5y7HpIdt2dcvH1R1mwQbVGxTBF64A7UWhoWyEMrm6pHy5FrLI9RQUw2V2we2f9+FSGNrcVrK+ynAd4aJbh+5J9fcNqYJzdaLZDqnTXfRoJ9EtNph5ksW0VDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491752; c=relaxed/simple;
	bh=KA+7zeYcE5Bb8GDcLM1ld1zmym1nPJymf67APNFpaf0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rVP2CMOGMjjwRoMq0xGqBOlM/KF4jA4t0RJiYZU2ghMpxiLdxmCsQks2CYwjsQacxZ/zbBgcgwdaaS5fXF3Tzy0/kcereCzIMWuvymk3TVlcyasdLb4JSJGUzb+o3jkC06G3+O3axh26EuXT23/vjh2OSo0CVOyCQH46RoQz3vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaOukIBU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714491749; x=1746027749;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KA+7zeYcE5Bb8GDcLM1ld1zmym1nPJymf67APNFpaf0=;
  b=EaOukIBUbk5K3GlVOCbCyMMcYhkPLoJf/eDa66foNvDPZJ1yG9MOQrDS
   V9W4dV4aZIvyi9uuhvPAUKGpxnXfJsLXTvu8hyB0QL4oNx9oyFH5OCgKx
   MqynOP4dtTruQd9ZKUknVEhaQJWzJtVaJuJcUUODucPc4Zv2xpOmjti0x
   QIyH+sb13q7CN72eG3x94woSKFufU+MUxJH0xcO0xBd3+WPFtGiTivxU/
   c2myNASE60kjxrDGAINiDsJih4FRQLH9WVoK9AZ3CVEFDhRuus+O+3t+g
   qCDDraywLSsWOR/laA33ULujQRqpUo12QTSvlhPPl1+T5OhWtgsGArtZF
   g==;
X-CSE-ConnectionGUID: M2Map+R0Tyevt4rJiZptMA==
X-CSE-MsgGUID: C2mbhy2VS3uhBHOkxcR3hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10744233"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10744233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:42:27 -0700
X-CSE-ConnectionGUID: /cIlDmkHTMuAOdMF334M/A==
X-CSE-MsgGUID: wnzOgFalQQO9ejPYz4A40w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="49716868"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 08:42:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 08:42:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 08:42:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 08:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpXrZKRckWjXKV1hD4IAvHAQjprenxoHGE//W+1+yytqN1qDdg78TBed7q2IN7hogB0clbH4pEb0e2jBhAC8OyC4SfGX4B33uJDA9Ftmpi1T+jWTNlTdwj5N03/l/K2ZwnuprbKLzkxO2JIeEDtgC5VI5tzTV/BPvHIRqheigauHbbipLOjjxuSd3N7F/MCYua7aQ+XoqLgICyh6oFVzMDdCmD86kBRKsF8vEgY8WPFal4OtBpXWQnTCPo+9Xy9kFdaic1Qescx+xsXfkR2YPUBwzRuni6N1XgL+P/5vZoPzOgKMOqaDZll+U4QBu6l/Ndgys01LtFa9OFquXP27FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cETpvfQqw/guT3BBeRFnjBNStl8mNP/Yk1ntJ79+9A=;
 b=O7O9YEzGAp3v5K9tU45sVWEe7Lk9RSEcshUZrtjzqXJePN5uU8VLJLO34szus5w2Q1+bgZ5GMwHHxMMob5Vu0+XsRU+V2BbvQ5GIag/2SNZxmOie3hLy+JRyL45nA9Dean3k+UEzkJknGJtc223XvNDxsThuX0fA5oicwYBCpwJCv6v/pgyqUHo9k2nup1BNZXCElqFOJzlpOvkXupS+PbOLvPRDsmAj/LFug+/0bKKDc6pSjbhn7pLUsonP6Hb3Ma6Yj6dnlL4LnD1Vp2QdLDCxCLcmDKt0/ZkDfnLt2j1b2MOAkH8kZVMuO3pwh/GQnuHFLANzOA2/SzqFVtIMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Tue, 30 Apr
 2024 15:42:24 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.7544.023; Tue, 30 Apr 2024
 15:42:24 +0000
Date: Tue, 30 Apr 2024 15:42:13 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: "Zeng, Oak" <oak.zeng@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
Message-ID: <ZjERVdJYRq+Fl4X3@DUT025-TGLU.fm.intel.com>
References: <20240426233236.2077378-1-matthew.brost@intel.com>
 <SA1PR11MB69916393B52812A5D25302D9921B2@SA1PR11MB6991.namprd11.prod.outlook.com>
 <Zi/WSRbYmpZtELhK@DUT025-TGLU.fm.intel.com>
 <SA1PR11MB69916539EB7B6F7DD49E2214921A2@SA1PR11MB6991.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR11MB69916539EB7B6F7DD49E2214921A2@SA1PR11MB6991.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 74673814-0ed8-401d-1502-08dc692c2156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?e4LZHyCMHrtkhqT4Zik/D8m1cnPi9bXobIzxRMsJ/UosXR3iOCB6OJhXEA?=
 =?iso-8859-1?Q?7m93glBgv2Dl0q/xqY2JOCp6ihMVe+P/6+LFVtskK+pvztLuUFv5QU35ZW?=
 =?iso-8859-1?Q?0YcKR50RGDya6f1eBLbWnnrL3calbA+zBt//dzOWMSR28R+5LEX7FDAVlc?=
 =?iso-8859-1?Q?0aZAYieRZaAZfMxYGN9KH2vx0EgdcTPJ+9cerzNNXD6ldO4IOatk5cnVQQ?=
 =?iso-8859-1?Q?kiAoGo1NqfGVX9xtLEEB4CYDJxyiBWH+VH6hYBZRD3eYs27X4J/i+DG12m?=
 =?iso-8859-1?Q?r944ZPpGYhadTwHwvmYvuAVNYQGbzYRjBr7p73ZTE33BpCInuPJv98CdGH?=
 =?iso-8859-1?Q?vO/teoN/lJOYSAcUHnqtteDyK7uD4vJaa2tBYFgAPHOjxeHkOZVXNdx8mc?=
 =?iso-8859-1?Q?ox1EbF54DxzB1AD/FcsPqZsdFAwxIPytkAq3wfS6JpFGUmABWl41qXJFB5?=
 =?iso-8859-1?Q?Nz35IUHCaNCeze/+PfKQyWDhES1Uu3Iu7/+/0Vbt5KH1mQAIn/oEVpkCl9?=
 =?iso-8859-1?Q?3994KYWgFap23/WoaMROYAk/qInO3Bk7EmflyQOWwQDD9AhH2X/7mCFZwP?=
 =?iso-8859-1?Q?7I8KgLeM5/fO/dUDDTDXRw8CboJOWa1iuGJEfWdmwqxMJWXpNbl1uUQ50Z?=
 =?iso-8859-1?Q?Dj8wSZz7tpqmMjVScB7aM/WcSXyXNQx715IWa5slZrfjTACYzEnaS7am6U?=
 =?iso-8859-1?Q?++1e+vIbuJA+ZwbR0Tc/Hs9rm9ddNPLBWtBok5zW6iDk2wc/jITsyeREAk?=
 =?iso-8859-1?Q?0alghX79+b9nxwoyYaWgv/K55Tvw1cKZiVYRsKDS9W6isYCtGaj5g888z8?=
 =?iso-8859-1?Q?TsxWmT5nXc/zOTH9Ue28xt6fS2ArzTjdDTpYMqsMOUwflZbzf1V00UONGk?=
 =?iso-8859-1?Q?PN2A/xr/XR0GzQnU13OlZPE09hosxPY83yRRjlc2whqOuf4m4bIRzapEfN?=
 =?iso-8859-1?Q?cRvcKGyooZLgDNi/L2XakVAXPR+QyuJJ6pJ3FlbH8N4nfcftCPlStXxliZ?=
 =?iso-8859-1?Q?YUvFwkU0kWefmZjGRVdR5XAb1lJ6olE2HpP1wmYbdcAz5XsWjubtZvJtyG?=
 =?iso-8859-1?Q?3aQDuCmIoofxGIkIIT0HNfgG0YDuLZybelFnBOWP//bduhzkYLSBhVEFNn?=
 =?iso-8859-1?Q?m/ZawMY7k2qSNdspQkhWuU2Y9f2+enOKz+uVoZ15NLu3DsTLOqj/Us5Ph6?=
 =?iso-8859-1?Q?cfkVC7yrMTMN0zzqI6HpYBmhu8h6DxJdvCpINHh2VXdt0NFayfUs4xTlCV?=
 =?iso-8859-1?Q?jETqGOPgWe+Dh7ikB/GQ54Qru8DURVuNyWz+sTrp0+BPJc+WSsxRnFDfQ6?=
 =?iso-8859-1?Q?G4yvf0wCO8xXIVOMnj9IMXYyKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jib1RIx2TNdSThU5PEFF/pnXeG988Y2D02aUtqo0fJmLB9dFzG3gWgTsRb?=
 =?iso-8859-1?Q?geGCuQT+3Pnd4kOUsCzoNlGIGTiN0Ll4lGEVHhkJc2WAAqVWBfALA7r/Hs?=
 =?iso-8859-1?Q?DIKIrkuC1EXfQLPBRPjzbtL1pkMU9Vzhz9N1ydn7KI3brCysX1zQv/JJjl?=
 =?iso-8859-1?Q?8BX5TQdfbLvjiPIKJ6JCv/dGjJQu1GpEon5EgExUdfK/k1IKioL8QxQtpo?=
 =?iso-8859-1?Q?9yzm+FNvuRp+cWTEyjfLggfn6H3AWsVBtdxgGC7j13NmhmupOHnyHyb62m?=
 =?iso-8859-1?Q?Rdiqxr5GFBcIgKjd8DYO0ajDaJUT6L+gApPdKXHmPDQdlGPonDUjQq2+HY?=
 =?iso-8859-1?Q?3sISiUjtvZUizvm+UsSYFNezAkMrvTRzPhLiu3uSY8n8qwigUTSmGCFJva?=
 =?iso-8859-1?Q?QBUE185oS0q1VHNHxblvNDabAuARz+i5ASQGiNBSms733M+GrEAXp+N76B?=
 =?iso-8859-1?Q?2dhUxuvgBwRjowJ5CxcW2MC8G2Wzjt7DyFRjLehUm/Qm1lYqVcxQTSUGBo?=
 =?iso-8859-1?Q?ZW5bhy3z2Y7q4pflXy4cr+rgPe/12sOrcn1XeXlvnPLvcAfeOns3JOD+XJ?=
 =?iso-8859-1?Q?Sw6vbVMNsSm/hateRfC9bq1btGhqOkPXz/2/U81ajHdNViVwJmHqWhdico?=
 =?iso-8859-1?Q?aB9ovS7rdiTP6NhmJ28Ln+OJlDubZXTNpcOXo4tQnW/BywCHYqPeRKRcma?=
 =?iso-8859-1?Q?470QYZ2YG9gxvZZ+cvdczGLamEbYOvkpUr7lnDQjRiQvlGA2RD/5GbqTiF?=
 =?iso-8859-1?Q?Wa4cORoPI7VPJWh+xxbbMwtM+cFpvS4q+oP0POoSGzIdB0/J5/6JVAuPfJ?=
 =?iso-8859-1?Q?f+lnYUPx5IsciEyzbn6s9QEcNMrPKhsN69iVfNpLm1j0K2WkksEGKoWgna?=
 =?iso-8859-1?Q?u5EjQxAxr1xtuC+Iswb1t7NeS19NbENoEFBJ65SjbXm/wxGOKrzdCN3u7l?=
 =?iso-8859-1?Q?DhXJW4NMhH2GxyztQPT8FdmxdtLaXDh3MgBDn4aDUb9RL+2V8YxT1jixCx?=
 =?iso-8859-1?Q?KoquGG280q40UCLAd1NTyKSEW4wjXF1wHe15datj/OeW1qmnV9vB7cyabr?=
 =?iso-8859-1?Q?MWVsLjR0gECo7vCcAOfRejRd2fUR+z3wsXmGQEGSl2L5jYWOor9bvVBI+A?=
 =?iso-8859-1?Q?cjriZBFwgJGIXyu4tbTOvf/NPO8W9zO0uXpyz/5y6t684yN9IzQq5wjPhb?=
 =?iso-8859-1?Q?MRmGUQnK0POb9X/Oovcx9QkWbHtzU+G8Gul7F/8YrZaoDYaVlPZzJSHgqj?=
 =?iso-8859-1?Q?3g6sLJFaLsnVbsVs8VFuSC1ko1t3oBqSQ8/4fHIJNoG26O+CZ9+At8Wr09?=
 =?iso-8859-1?Q?1FpcCpClxLaNFXWn7BuOcDGBpufZCnBaWAoc+yBPVQMUIAMiuBeYOxtk1I?=
 =?iso-8859-1?Q?FombOFGCNKg8CEcIbvlJ5kg16SwnJiIppUe9KKeDhPIxbJcvRmUO8pNmN0?=
 =?iso-8859-1?Q?avvWPrzxXGl8bFrYWEdO3uxOlBDy3bg3RTqiLE89XoUfRiW07JkpEwqMgK?=
 =?iso-8859-1?Q?UZcHQ1QA0Kw7vTQF79y9MecZ+zka6A0XeMBNdO6XlD72WTgVyVogrE8bFl?=
 =?iso-8859-1?Q?NJkpUeyzNkmBzODeTiSHtIj9gPZ8h1azrGNaikWAi13Xa9nJ1ucnDlaYKz?=
 =?iso-8859-1?Q?JMkn/cPL+IyY6VVSIQWjm6AjvGJktwRu+G3iAfTDzCvh6qzjb53oQeZA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74673814-0ed8-401d-1502-08dc692c2156
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:42:24.0128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRF0i9LWzkRyFa5eQr9gCABA0qHwRHDjtfrq50p+5lDEVfG1CSW2MfT6YVntKYsOXspYYt9dOSU2oQuvzBzhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 09:11:42AM -0600, Zeng, Oak wrote:
> 
> 
> > -----Original Message-----
> > From: Brost, Matthew <matthew.brost@intel.com>
> > Sent: Monday, April 29, 2024 1:18 PM
> > To: Zeng, Oak <oak.zeng@intel.com>
> > Cc: intel-xe@lists.freedesktop.org; Thomas Hellström
> > <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> > Subject: Re: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
> > 
> > On Mon, Apr 29, 2024 at 07:55:22AM -0600, Zeng, Oak wrote:
> > > Hi Matt
> > >
> > > > -----Original Message-----
> > > > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of
> > > > Matthew Brost
> > > > Sent: Friday, April 26, 2024 7:33 PM
> > > > To: intel-xe@lists.freedesktop.org
> > > > Cc: Brost, Matthew <matthew.brost@intel.com>; Thomas Hellström
> > > > <thomas.hellstrom@linux.intel.com>; stable@vger.kernel.org
> > > > Subject: [PATCH] drm/xe: Unmap userptr in MMU invalidation notifier
> > > >
> > > > To be secure, when a userptr is invalidated the pages should be dma
> > > > unmapped ensuring the device can no longer touch the invalidated pages.
> > > >
> > > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > > > Fixes: 12f4b58a37f4 ("drm/xe: Use hmm_range_fault to populate user
> > > > pages")
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Cc: stable@vger.kernel.org # 6.8
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > ---
> > > >  drivers/gpu/drm/xe/xe_vm.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > > index dfd31b346021..964a5b4d47d8 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > @@ -637,6 +637,9 @@ static bool vma_userptr_invalidate(struct
> > > > mmu_interval_notifier *mni,
> > > >  		XE_WARN_ON(err);
> > > >  	}
> > > >
> > > > +	if (userptr->sg)
> > > > +		xe_hmm_userptr_free_sg(uvma);
> > >
> > > Just some thoughts here. I think when we introduce system allocator,
> > above should be made conditional. We should dma unmap userptr only for
> > normal userptr but not for userptr created for system allocator (fault usrptr
> > in the system allocator series). Because for system allocator the dma-
> > unmapping would be part of the garbage collector and vma destroy process.
> > Right?
> > >
> > 
> > I don't think it should be conditional. In any case when a CPU address
> > is invalidated we need to ensure the dma mapping (IOMMU mapping) is
> > also invalid to ensure no path to the old (invalidate) pages exists.
> 
> I understand for both normal userptr and fault userptr we need to dma unmap.
> 
> I was saying, for fault userptr, the dma unmap would be done in the garbage collector codes (we destroy fault userptr vma there and dma unmap along with vam destroy), so we don't need dma unmap in your above codes. It would something like this:
> 

I understand what you are suggesting, but no this is always needed.

> If (userptr && not fault userptr)
> 	Dma-unmap sg
> 

With what you suggest, there is a window between the MMU notifier
completing and garbage collector running in which the dma-mapping is
valid. This is not allowed per the security model. Thus we need always
invalidate dma-addresses in the notifier.

Matt

> If (fault userptr)
> 	Trigger garbage collector - this will deal with dma-unmap
> 
> 
> Oak 
> 
> 
> > This is an extra security that must be enforced. With removing the dma
> > mapping, in theory rouge accesses from the GPU could still access the
> > old pages.
> > 
> > Matt
> > 
> > > Oak
> > >
> > > > +
> > > >  	trace_xe_vma_userptr_invalidate_complete(vma);
> > > >
> > > >  	return true;
> > > > --
> > > > 2.34.1
> > >

