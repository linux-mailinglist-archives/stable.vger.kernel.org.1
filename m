Return-Path: <stable+bounces-136500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F0FA99F49
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 05:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44364428C6
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 03:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FE1B392B;
	Thu, 24 Apr 2025 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxLhZWNr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E21BC07B
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745464058; cv=fail; b=pPRUQ0R3rXWhrD9mAfYzqNVwQ2Glri3BzUMv+1gq50CAkBYPGqAKC1EtnBnthOdKCUUbKmPg05a+YfephXwpYCn9/w9/5OBMt7aN/nrm1fQaQSHxEeOEq65YQ/huatHgcn5HH5KV+YjFgjt3sZ4MVzcEOJMIDXw/Z6aiAghtvlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745464058; c=relaxed/simple;
	bh=K4EPqF+5sj57Cg5h2QmdOW1RN0yL6gIHdGYPOOpqrX0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cDjajw2j9Ibtduy5HJlMXtIuKZpyLYrUDUsyXH03Sw3h4DQYhrfkAuPJiRVnqHOZq0woQQaCaN2YkvNdQbDm1UKlgK4m8ENkCvIwAUryG+hfrA0jjN2qr7BGTNBfmwSnkulX+tlv9TsYvFa0yyN+Sakicac8rzrWGGh+q6NgR24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxLhZWNr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745464057; x=1777000057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K4EPqF+5sj57Cg5h2QmdOW1RN0yL6gIHdGYPOOpqrX0=;
  b=mxLhZWNrJPNGnyA18DCGa5ejZO/XI9i+UgyAhy7Vn5Y+wU/kai6ecfrl
   n2zfucFmVYJbpfdV6Qma+zx/ZDCZs/6RXFK2TpX1UdKWBjW27oUGt8VON
   dSW3T2AvhHf6vWL4PapnD+5KYvLVu0T9UmdTFe0664K2VHhqf5lXyK3E8
   BF3RK5ViL4bZ3heUuiYSO7/wXalpqfBuzKDa/JKL1Pdz6YTlKO+I4MrYd
   Q24pBH0FsleaFmX1YViNOkkn8m7A7At4sz8zU7LIOiHZ+Lam6SIxdMlsx
   P2z7jCYJUxeV0Eg/SlOzMxEMHiGT1Wfk6Tnq8E63oTJG+ubNPwiH3dhQM
   A==;
X-CSE-ConnectionGUID: LXbA4e20TkuP8GGZIT5oOA==
X-CSE-MsgGUID: cqlUEIP4TG6/+zjXXw9oUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="49744111"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="49744111"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:07:36 -0700
X-CSE-ConnectionGUID: s042kPbbRMm9N7u6bwjDww==
X-CSE-MsgGUID: Nn0sez06S6KmJB5AmjKYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137484829"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:07:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 20:07:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 20:07:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 20:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnvrgMIWBtLiAQfmfWSzAYtdrszyM4TPM8oubbm+oEhDIxkLHpLiSWI3FrYy8XjhoEFv/7JHhzLIs3BE1qu8vE/35iboYIwqgtzTV8sqAT1EbWq5PMF8jXOFrR9opby4dHJwSe8G7Mv9Ng9uAKcomwcIxT6LyiOUrl8NcV9dznQbfSlKsCHkGLuNy0TyrODTOeBggA+gUc5OQ9DtSkNWeFUBUUu+q/i15mllEgX6WaA4jRYjUovujRD3OjiksnGvbNGWao8COE81IJA+fxazdDG0k3/I9zNtEpBtAwRHW8XB3LUj0EWP1ngmsHliq/ahrmuNDAwF1Zo96vyywb3NUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MyN4XWR5pu+cOnn5sbUKYjSeDdTfMq3+pcxkx2zwvA=;
 b=FDjA+lF/qhCxRcbVBlKm8WaO2NlSJfFIzDXadV/PlkyXmN5PEsrcta5Dv+d7RAJeQQdue1ymYMlM8YDWL+MTlgiMtnCxtm86uUktLLBu6VSJqoyGFxJWkqhBa7ZwYmjHx1VGoyUtbFrxukB/yP5JGa+F6pW5JOK9S60oEa+2zf+VpO0TT9C2Buo6gwOtff0jHdFonp+coKWWW6ZecIdzC4Qxp0LHBymvkVgNVt0p41d75SINf2TTSStATxmg8lPZ0/HdTNqryyDDP4/acIf24fBMxg710xcCOcdH1Ve/BP4vUag4u0/CAapdl1aoVAa9ODqWwtYvnqesyDdULbiEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:07:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 03:07:32 +0000
Date: Wed, 23 Apr 2025 20:07:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: <stable@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, Cedric Xing <cedric.xing@intel.com>,
	<x86@kernel.org>
Subject: Re: [PATCH] configfs-tsm-report: Fix NULL dereference of tsm_ops
Message-ID: <6809aaf1c7e44_71fe29494@dwillia2-xfh.jf.intel.com.notmuch>
References: <174544207062.2555330.2729112107050724843.stgit@dwillia2-xfh.jf.intel.com>
 <7f1c8e94-9be7-4ff7-a2a4-063edce48c96@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f1c8e94-9be7-4ff7-a2a4-063edce48c96@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eb8123-f4b7-4cf6-8e40-08dd82dd27c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rUuSFN9iIR4Zc76xSpD9Ak8dMTnLi2l5kIa5lVPjxUvG+iyaq8W1osnDC4y7?=
 =?us-ascii?Q?mbKBeVbJs5+RaDYAfVXR4iW9eYnr7AiR2nZw73tKDaQF8j+R6vcmt0p5q7c2?=
 =?us-ascii?Q?jqziUBYMZVLGmbntg+1enbRHILkdMMCYE/nlgLF/lNTiNlusOTkW9zetykOo?=
 =?us-ascii?Q?3ws4hYj/ZfhFAoemgAajXGTGqO90iyLUK2uns8fcrYZ3sEIe149zafWmsokJ?=
 =?us-ascii?Q?iz26xifNObKN1ZCS+yDm+H36xnocPBe2hGnBgbMpPqjhJ6q4Dtdq1lmET4m6?=
 =?us-ascii?Q?aYNf3Q3l1CVx293QasLcrkQouKZFOl2DkXI48zE016EwCRp3h7ujtwR8BrEI?=
 =?us-ascii?Q?zxiJtHsJKNXNFiJsK2cgksOUWdyMLlCuJxS4YvEbepQC2P8gZdbbQrHuOBHU?=
 =?us-ascii?Q?Aw2EXq8mT0jkCdf1dOC2Ac54zApOYFsII7mvnJh5KF44AaVLKuXS1Kjg/Z4V?=
 =?us-ascii?Q?mAMHmDsYyWR0fSQxSHoiBzwZUGE/czWDDb5bYzlNUSEFDtKcn3kUHU13IEj2?=
 =?us-ascii?Q?bvlhIAIHS8KWcMvOKDH1MzPAulmtAbczIvXl9EoLd6kklGKwjodRhLbFbXje?=
 =?us-ascii?Q?EOc5wMfbx42Byop9dhzdhfgkOtmg/QqaBoR40TtI2Y+Z4iZBkb/1axWlguyl?=
 =?us-ascii?Q?YW1RvIxuMBq265o7pSFXIn1oQTpgVA+yAGcBHd60k1wDGeHZvyOO2gf041o1?=
 =?us-ascii?Q?DFHUibhcPPkealdqw7J0rJNnZb1aF+c9ZvPdjKXrX8MgELGGxqxpHMrkW0zc?=
 =?us-ascii?Q?FjDr+lw4IoHhKC43efrFamx/+pDZk/nAuVx9EODUwt78Mh4n7ht4esIHjKE4?=
 =?us-ascii?Q?E04CiI0QqCkxGIruPhsBgJ9xV5d2zHN8wzF+n+f7gP5ar8EGfuy+569Cxf9n?=
 =?us-ascii?Q?vNfIhKQEDzae2MtgI2O/BohikIJuGE9lFCBJ2ZBjtle+G4YdK7in9SkLL83M?=
 =?us-ascii?Q?ymp+jL7VuSckktyKvtRefpgQcFCrXKNZV6fQ6+ZmMh7sRcCVoxrpcmFqkmXH?=
 =?us-ascii?Q?ObGmH5r5iAPD8RxMVKbWYo3EDW4Cwpq3UbX9d8J/XkXd8DPENzMSCnxYqkC5?=
 =?us-ascii?Q?l37TI5QwzfrREWoYKUX7tKfiLenWRlCsov6e8EOi5y8AjZ2s6qgmUkyLjFNb?=
 =?us-ascii?Q?48hnMBv7FniNMP48PEF4VA5NJupryf67/KEipztmCZCIZ3eGWyCrS00z4dVo?=
 =?us-ascii?Q?7byZNXc+Prj/PbpA5VZikclCUaXKy9FEpcjTQ2I+7dIuw9gpmFvJ59LliI03?=
 =?us-ascii?Q?h5CWmqk8fChWVX+fWsOFEObBW+75f3NkyCq70XQfNmKvM2k++KlEskY1JUet?=
 =?us-ascii?Q?MsRCDTXkgiC6NXm7We8QHPKx242y7vSE9/W739CNlBarCbspQtiNqhadZjF8?=
 =?us-ascii?Q?czbYO9qFB8v8//DacrtgYwK/jQm66i9MBfNgOZdOtncx3Xm9ACKwGqNnxI1U?=
 =?us-ascii?Q?GYwCwdmYZV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qb+5dyd9p7QVacMKjdsPKTZoihQ2+0b/nGXiD4mio9ZbxIQlxhQsKJKnxPTM?=
 =?us-ascii?Q?O3o2c/Z5tThzmOjQGpFD5VZnllJEhBr1zHL2hh4Uzc90jPtUuVASBf9P2Qpx?=
 =?us-ascii?Q?GukiraGavP90l+iXpJKgXsvEltVwZGA4ygVLg0WtY6bc369PbnG9V3IR1IGf?=
 =?us-ascii?Q?nJYNaDG0Jhm6T+DfbUsL8zDLRGn1Ge5Xti483CsfU1EMseY4tdYN67/Tmoj/?=
 =?us-ascii?Q?oA+XeXQSl/ZOaApJoWApwiX3/pvyO9g5mM4EBsMzKkIaR+cPr8zwTEVYPZI2?=
 =?us-ascii?Q?Xx5xxOHRIpf3DxRuCZSaKk1gItgKJ35zsZ2WeKaDe/iqM5AJAOQ9VNSsd8nk?=
 =?us-ascii?Q?hmKo/bRqRbzIhUhvij7bNIZbQb0AuKIox98k+T1CJECcPzSAV5gxbD3qbXfw?=
 =?us-ascii?Q?KFL2nj52CLuZ6ifyihTPWsGVWQ7STuZA8XXDMrvwqlEVIF3yyTvsJwnbzCHX?=
 =?us-ascii?Q?VgA/ig8/I+JnZCTm3pI5cz+9mX1kFJCcVPnNHGwC5/4Mr8UC35a1b1bxlH4F?=
 =?us-ascii?Q?ECBBX24Ip+hQQckf0td7uV5cngGQROfz21gHYJ5Al69fa/IXyNuciuinWz5t?=
 =?us-ascii?Q?ZjTR2UphIHyV5eVaAg/Z+U+jMcSWnooIG+synCrTPszUqSfaDQTOrueCebYS?=
 =?us-ascii?Q?gcdcppoTI1dJcrYHIVnjhedzkWLtK1rHPo7ih1hyNPwLAtxo5165e1oP/TYV?=
 =?us-ascii?Q?YSj3wP0SK0+69hDj9vld23uQcqe4Zmq4sGPLrS+tyrOgr6nnKv1Arynp+oke?=
 =?us-ascii?Q?3Evnr52dNjjkfw66H9jcy4qqEjbZWTAXgKBE9IFnPclqa2DjyIrqvocOk8L4?=
 =?us-ascii?Q?FjVdwZDIuBzkMj/0wsPSYhH+NraAqtD8/tCOx/Hp0X9T+QxQP35kUKAIPOvv?=
 =?us-ascii?Q?Tw1WEt8VT/+uMjIiqRrH4id8Crq/67ewjhgps2B7NmOcGM5VSCrkhA/jKH5g?=
 =?us-ascii?Q?W/kKfqFfMZbtXb1Orc7bcezkJ8dU5ubUn3kcQj0WRoJJdPaZ5WAw2wnfsO2v?=
 =?us-ascii?Q?jerzclNwUgZim5mVMtoxxSXsv/ORU7LLDULf5OddIln7jLmSReUkBmFXaduy?=
 =?us-ascii?Q?tToZ+wpwpXh6uhZ4xJjtrtLcOwwg3VBE4sfE5PbSRqjaY5QjJwETGOVRk8bS?=
 =?us-ascii?Q?8IE6s4jkfk3EQZgWdOYMNQVv0+P0HgZCPKOKq0um7ws8SD3clwhkeUVqnak5?=
 =?us-ascii?Q?WIPZU6VHv9Brv3t0Olz7xzbjr35Xpu6lxtFVr9UzbYGYQBkj0IZn0LlYQN4q?=
 =?us-ascii?Q?KfjhDRukKga+Hp+g19RzDWuyr/qqlvp+ZPVoWwDx54+O5ojrzEhGnf3UJXyD?=
 =?us-ascii?Q?PeDDQZ52hQ7tsGiBn1rGYqqx96yV19+PKNG0Afz8HpzwYqGDrsTkq/t7VESQ?=
 =?us-ascii?Q?mwqfKMVLHIYfHxWAl7oGIYkyjsk+6Y4SU6GyMxpJnCdxDmSNXa9uGrFQgQgg?=
 =?us-ascii?Q?DqWyF4Myx4Yl0VzSFnurIX+cU6DBfU30c1milZBNgPdjeJI2VFApZblAKiEl?=
 =?us-ascii?Q?r6Dfjna+SBcSfGlIO55SBMNkeTGK2oWtIqODZ4D4tgG5IxqdZim3lUfPctqJ?=
 =?us-ascii?Q?j+Aw4IgMxVEhaSMxaGqWJ8ne48B8f/56xZmsLWVOda6V2n4O9FN5CAuplAJy?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb8123-f4b7-4cf6-8e40-08dd82dd27c5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:07:32.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRvR9UwgrNotgtiw2JFEwreS6fZipkV3c92O/ZGmyPWCM+spFf6BIjHyv2LKWOngpMtSbBMusEfRzeyIw/FIjAHXw6nx94kXzSwtfToOL8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

Sathyanarayanan Kuppuswamy wrote:
> 
> On 4/23/25 2:01 PM, Dan Williams wrote:
> > Unlike sysfs, the lifetime of configfs objects is controlled by
> > userspace. There is no mechanism for the kernel to find and delete all
> > created config-items. Instead, the configfs-tsm-report mechanism has an
> > expectation that tsm_unregister() can happen at any time and cause
> > established config-item access to start failing.
> >
> > That expectation is not fully satisfied. While tsm_report_read(),
> > tsm_report_{is,is_bin}_visible(), and tsm_report_make_item() safely fail
> > if tsm_ops have been unregistered, tsm_report_privlevel_store()
> > tsm_report_provider_show() fail to check for ops registration. Add the
> > missing checks for tsm_ops having been removed.
> >
> > Now, in supporting the ability for tsm_unregister() to always succeed,
> > it leaves the problem of what to do with lingering config-items. The
> > expectation is that the admin that arranges for the ->remove() (unbind)
> > of the ${tsm_arch}-guest driver is also responsible for deletion of all
> > open config-items. Until that deletion happens, ->probe() (reload /
> > bind) of the ${tsm_arch}-guest driver fails.
> >
> > This allows for emergency shutdown / revocation of attestation
> > interfaces, and requires coordinated restart.
> >
> > Fixes: 70e6f7e2b985 ("configfs-tsm: Introduce a shared ABI for attestation reports")
> > Cc: stable@vger.kernel.org
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Sami Mujawar <sami.mujawar@arm.com>
> > Cc: Borislav Petkov (AMD) <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reported-by: Cedric Xing <cedric.xing@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> 
> Looks good to me
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan 
> <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks!

[..]
> >   static const struct config_item_type tsm_reports_type = {
> > @@ -459,6 +478,11 @@ int tsm_register(const struct tsm_ops *ops, void *priv)
> >   		return -EBUSY;
> >   	}
> >   
> > +	if (atomic_read(&provider.count)) {
> > +		pr_err("configfs/tsm not empty\n");
> 
> 
> Nit: I think adding the provider ops name will make the debug log clear.

Recall though that the ->name field is a tsm_ops property. At this point
tsm_ops is already unregistered. Even if we kept the name around by
strdup() at register time the name does not help solving the conflict,
only rmdir of the created configs-item unblocks the next registration.

