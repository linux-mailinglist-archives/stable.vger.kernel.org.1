Return-Path: <stable+bounces-83484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6031D99AA7B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642D61C20D82
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA41BDA95;
	Fri, 11 Oct 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqXZFnNr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F5199234;
	Fri, 11 Oct 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668303; cv=fail; b=Md2p1v05O3sfnftH8MlqU60j2Lda1aqssx0+GAwCo3ehMEu2I0uHndpAGRLU85XhGeLXsoSWQ6pMRS4RQwKMBNnbg0y6hCxjDyUmne5wGFKEbp2b7Vw2PvlMpnPCwzTZykrNsihZ3zq8wVAGg7yVjPif5QeyezKanmTWRNN47eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668303; c=relaxed/simple;
	bh=OASpoQCD6uQqVkLh2TUgyGoXFFVYTsDj65+4q/uKRFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mx8ZC6VayPIf+4NsSx9N4cACvsnn/P8ZE/sNLXvvnHNoP9cvcj62VgGwsfS1h5U8Mych0AM+Ym8HUl7VdKaLENyWo4Y/mpWXcgnQJ4X7PZBgkVCEAZX0pHVPJ4sI+Flpbr20wnjUOLiAN57cnNE5P5xLKwGlcmtBDei0ovKz4xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqXZFnNr; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728668301; x=1760204301;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OASpoQCD6uQqVkLh2TUgyGoXFFVYTsDj65+4q/uKRFw=;
  b=bqXZFnNrEnCenyeiF1jGd9v9FLfZFaxOYMyxZ7sAM063ZZeDOkQtnzqy
   5wi1T0lNnzXfTXQZ5IGDzbRkaYvq8W9yuBrNO0V5yfnz/UtGp2TCEoycM
   pt8pTDww9fYoQ0XLdWKZqiDHmWaOj7hVX99qGdbO7FWtJbXOIM52K3BQd
   YO7rssqfGw7l/fv1AxrKEx7ooihVrcS4VJ+Y5RbpeDIkXSDpc/h33rBiN
   dov8qT4n56oGKa8pYC4Nb2+b+/2XmtijFG2Te08PKSXB5KaMUv4f0YKIX
   vF8AQzisL7d1VXDcX2oYcTOCHqZpeS6CgtAC4d4f0y6HWW7/4JwjtioGd
   w==;
X-CSE-ConnectionGUID: 2VPMLw0ORZaDBm4/J7KtNg==
X-CSE-MsgGUID: JH22F1sXQUCTxTa41K1t7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28205152"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28205152"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:38:16 -0700
X-CSE-ConnectionGUID: e1zojBwVRL6t9AL2EUZatw==
X-CSE-MsgGUID: SjJcORP0T8ecs7gQo91NSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76981915"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 10:38:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:38:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:38:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 10:38:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 10:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGogbWz1+DeTifu7ETK/qvZ+sdUMtXmOFDKB/XS8LJ2eiQLd2deCWVszg6z6HndIUFlmhaT9begxGHzkn2wPf7x9OdoJYpUJmi9r3cU+Q5010wMU5cF5gGBQUlbDb9yybjPdus6kvwPuurBw79XAAt/HRIUKJnWbQryK3cxFtWt9QqZXp8g2jg6VgMGbaTvhVHJyS2FBQQXn5ZeN75vJSlf7GqQj12iCYEGbbbTGZJXn4Qa+MZZ7PRAmWy/ZFP/5oUL7/ikltwCcPDTRb9tsYltG6yJ2AujU9otW3VdravD2DpaE2NMUI8RvKbFa59ekadPeVGUhB4f4Guwt3aUg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH6w91nAU51QUqzVeOiRID0i/WbueFJVT5Su/ERkuXE=;
 b=dUb2EDDmrgA7bS0gQHRzuWJlmb6mu4P7FnnXtqX5ch1fv+vvdaDI5leTlS+Od9Z+x+92mVQQ6DISJyv53CycL9yiS7v1MxxP4bR9PP8/Nutk8xWu4VkZj8ZwSvlzusof/JvPlzMgXwFCewCGm8ExMaZKwAjC62E5Mu/J7oRvDf5xvwLM3UM89blEH3oadcIf3HSCJmb64chmtoHnMC05EmdM/Ye8J+niheEwGumQE3fWIWNSX1SQ6iN22AynEv47EEqaXp/VSMvRfW8YQC0CLfb8t8i8GI++Pw0hp7P/YQ5ulC+K8zZ4rAWAlOxdAfej9BSh1QZ264mEcmK3sse1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4851.namprd11.prod.outlook.com (2603:10b6:303:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 17:38:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 17:38:09 +0000
Date: Fri, 11 Oct 2024 10:38:06 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, <stable@vger.kernel.org>, Zijun Hu
	<zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>, Gregory Price
	<gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Message-ID: <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: fc51a177-db19-4db0-d9cf-08dcea1b78d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvY5KE8ZXEBmOGfXBNQUnlv6DkS3GJWT5+QoQjDvZuH6FbLRzM5PtfkGDafP?=
 =?us-ascii?Q?fsUYDS5hmjY8aIA3NWNdopNjugVtLqAtx/IanXrm2S9jkXG1/HamFP5xT/f0?=
 =?us-ascii?Q?7ZF3OgeiWoGcT1jwkqkijP7/j9YdFT7TajT5TIscEaCYO53h5zStDR6qEGzY?=
 =?us-ascii?Q?BIBaeloE+pFD0eAmmhLG7hpNm+2AFJIM2Lrzs+uFSzenVVjdvFQiXUr/LExK?=
 =?us-ascii?Q?SQzDAYYcef2YtBWVrX6g7ooIjtwBiM1KE/toM4KVrzEJvk1IGrFVJe7opv7l?=
 =?us-ascii?Q?xBgBHBB9l7vHUqgoJHOWcU9no5xYnEGOJMsgZTFMLG0k6DfrXHpvy5pkGlrD?=
 =?us-ascii?Q?gVaIl++1eLZltUbgZJkwMC/WHIiAt0KomKKDgip2yK9+mZPh3WcWKGqIvVPb?=
 =?us-ascii?Q?6ppU+mbwy/CqGps4clwvtL5PiSkKyXbvJOxkSghQKgH0jDdOoUMOW1MdVhLK?=
 =?us-ascii?Q?Qnnl8pLFNHBja00Aia89Q4lB+h0zVwHqN/znpsofMSU/EiUCCAlHi/aPUVmj?=
 =?us-ascii?Q?dlkooUkgq+TOGLqUngrCRCRDXE4p0FDkBq9/ImMR0YkORlyfB/XGv0pUMaWX?=
 =?us-ascii?Q?BBlake2/rSwxi6oNBlFmKWQ0uKCQ7A+cFzoMfqgTbolSSQup6ybMsth+u/Tr?=
 =?us-ascii?Q?WZssviHgCpL58guY+I+wJx95FNkLj4IJAeBLJNArjHYWNbEkVN/Itvd9D/8G?=
 =?us-ascii?Q?f/DDbdF+3At+61nQ3aoJVbYlF+PLz3DhmLSwc2Gk+n4APvV58wpLbuECoIhK?=
 =?us-ascii?Q?aF0y3Dsi91AqPQSCl3jd/C9mzSyunwZ9skYQRVYfKy+FiALI0JSi6UUmfXf2?=
 =?us-ascii?Q?tnIg26z4Yu7DIrAkRVxrR/qsTCr1s6n3EK7chTXhDtlvRnRGfk21zaksI8Am?=
 =?us-ascii?Q?AhoBaj/TgclR8QP/suDWdlaq5dfsckh4XkatF6OImEWBRCrr5Sv7HtpIutqq?=
 =?us-ascii?Q?Cb1Uny2OxmgmSNYkbj9dERIZyWgkw3zD3NSAud+lDfwyy7aoyC98ULQNlVzY?=
 =?us-ascii?Q?5vZyn5rwn+xeu1O/8ScGSfwL1/OBqdcZ1XDvihS/H+CQd4VRqvaBnAj4EZ4D?=
 =?us-ascii?Q?ZhswhBQg6EAgb+vAE9ugEZ4qKG4qWLDC3wfRA/gzU1+LLPS8kiRmdukY73ko?=
 =?us-ascii?Q?Z+zYIEUWfHw7cz02LO8PQTUOExBRoFWEQWJe+WdmYcFTKTaFuG1n8f3TtsDT?=
 =?us-ascii?Q?I5kJ0o5GPOvNbiMGdYtn8lCCIvViANXp3MfuJsFEijyEeIcY53pqx0qcczQU?=
 =?us-ascii?Q?47XrlUc2gMjFwPxcJPRi1LocuT60J7kMAIzbWOguQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SyABOrqT07aGYeUmcV78ELqFiCLve7cN3bOTwuUu7V4zQ9khNF1zFpGV7YBE?=
 =?us-ascii?Q?lhdVOxmWvunBHrVf9UEs6i9lQYD9JAEZiRStQiHCLajsmUIxmoLm932sZz2Z?=
 =?us-ascii?Q?mN1+bOHRB5ESp493KqkhqQafXUht8ncbzbSPWFGXAh/0tGbH/OYD7TzbbpvJ?=
 =?us-ascii?Q?rapaOL70rMIDIW1MVwIsj4926PrSNaprTtIDHrRTz3A1e0ZUmcWe6/NNeO3x?=
 =?us-ascii?Q?n8D+aipUuFuvq/IqAYZ1enwskbtG8eNORPrxU7henbvKWa3NRQM90pwXR0S8?=
 =?us-ascii?Q?2L1uzVG8GBaIsVXuxIxcjHQNmFRSP5C3Cgt1jv22aMSdDydGwLqQc3LG3M4f?=
 =?us-ascii?Q?xUVvYF4eQ5XtYiukI9hma0xTNhLyvFZumELmfvFFvqB9TkgmRsyo3OjLOZtl?=
 =?us-ascii?Q?SFxsAz4rWlgzjdFtX2ee8UDjPXqcLSz5K/Fek/KXrYZ36DQ1Imur9Ok55al7?=
 =?us-ascii?Q?FLJlhqY8s3l3bwhg/GGRlI/tyy/pjP6GW1m3CUzxi3aTp4KN2PkVwEWdoRTC?=
 =?us-ascii?Q?nU8oUMHsfBRdIg87STJ6I9scrKMaSDHekaCX3Iv29YStIqtyWVf15aUXAfhg?=
 =?us-ascii?Q?uI65VVGb19HW4i9sHfwFyU9ZcpqgbF+YGtM6fmd/Tq7LKNaiIOyc221ktZqD?=
 =?us-ascii?Q?eO4VFYw4MCJZImjbpj2HJzkFvCi0TEBeFm1iUD5vNHS5VCFaECMITidP1Hro?=
 =?us-ascii?Q?JxjrjsQymp7PJ3FyJiVmPeohvX0dyGPKxtjIXlFkjR3Merqh8FZarBoj2r/n?=
 =?us-ascii?Q?eJhFRJ4vzp/D3diFPaIxRNU+/L0qErtSDWKtlHGmkxTcXaVlgeEP2j6o0tuw?=
 =?us-ascii?Q?+pVoB/JKHZqRbgVKCgTeoWROKd7BX1UgDdMMflwD6wzLI33OaILlyDz0LfoK?=
 =?us-ascii?Q?WIu9Gn0/ly58M5P7aEGxnSBc4qUWe1f5p3JyOT80n5iUK9W0uxynOt/omzdi?=
 =?us-ascii?Q?OqjHhVCgeY+ARZIaqKt3gRz/O3DA9YcA2w7MbD0YtE9QN9ZD6qkr4g3PVgmP?=
 =?us-ascii?Q?HnrnwllZLEi4LBQzhZ151OYS13AMZAzfBrCYkzwcuZ+G4sVCW6jkQLFDkBkB?=
 =?us-ascii?Q?6g2uwmPlENgv7mCDrlHZmmoKy7IxQ9Jwogu3YtY3LdmVOzfrX8n2Wip9smFt?=
 =?us-ascii?Q?bUziQJHFB5WdR5Vldw7rRtw61N8SY/CN6AUaV1dZqYiOgmDafMdMJAcz8HiE?=
 =?us-ascii?Q?5pMrcZfwi2StQLNINN6Ojz7LLlwxXLgiHFux+2tK308wbF1LBh5/6GosDCCu?=
 =?us-ascii?Q?V3Ft06YvV5eAOCzWOj+kvr2JJx2Hfpil1rmzKpanR1dViZIgFQlpL/d/9HU8?=
 =?us-ascii?Q?BzrM24m7dDfzgaVlceLDq6nct6cxmLVjzlgMEoIspgIR8ii67UXezkHwyzGg?=
 =?us-ascii?Q?97npKdUFr1Ds+q0j2SKGQO5risDah4aZ4pfGVTaqyiexcfLUxOdZT+YXglth?=
 =?us-ascii?Q?/rOV3rdmj+1Wy8fonTEZfXsUO5FbTNQfnMUBC9PHeUs6U2JAPg4HV/U0AvxK?=
 =?us-ascii?Q?6hbo0BXJ2kR3UFmQXYEGAVKkgsJhRHGRJlTgQF2d26g5iW4AnnodX28ssUL2?=
 =?us-ascii?Q?0eBATDweANXE6uVkou/jyApethX7NjluvUDO66MCg7ElNA3EP6GMQwUSgMKn?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc51a177-db19-4db0-d9cf-08dcea1b78d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:38:09.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsslTJAxWfZruF/iMXK8QFlGzNedDdfN5Z8p9Xm+W63uAY3bg5oagsf3358wKDcMb8195xbNiSgEuBEXBGbr9xCQExdliunt8zuAWpK4oCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4851
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> Hi Dan,
> 
> 
> I think this is the same issue one of the patches in type2 support tries 
> to deal with:
> 
> 
> https://lore.kernel.org/linux-cxl/20240907081836.5801-1-alejandro.lucero-palau@amd.com/T/#m9357a559c1a3cc7869ecce44a1801d51518d106e
> 
> 
> If this fixes that situation, I guess I can drop that one from v4 which 
> is ready to be sent.
> 
> 
> The other problem I try to fix in that patch, the endpoint not being 
> there when that code tries to use it, it is likely not needed either, 
> although I have a trivial fix for it now instead of that ugly loop with 
> delays. The solution is to add PROBE_FORCE_SYNCHRONOUS as probe_type for 
> the cxl_mem_driver which implies the device_add will only return when 
> the device is really created. Maybe that is worth it for other potential 
> situations suffering the delayed creation.

I am skeptical that PROBE_FORCE_SYNCRONOUS is a fix for any
device-readiness bug. Some other assumption is violated if that is
required.

For the type-2 case I did have an EPROBE_DEFER in my initial RFC on the
assumption that an accelerator driver might want to wait until CXL is
initialized before the base accelerator proceeds. However, if
accelerator drivers behave the same as the cxl_pci driver and are ok
with asynchronus arrival of CXL functionality then no deferral is
needed.

Otherwise, the only motivation for synchronous probing I can think of
would be to have more predictable naming of kernel objects. So yes, I
would be curious to understand what scenarios probe deferral is still
needed.

