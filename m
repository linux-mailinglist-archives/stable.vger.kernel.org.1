Return-Path: <stable+bounces-236113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKy1Lon83GlJYwkAu9opvQ
	(envelope-from <stable+bounces-236113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E23ED4B4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 120173012232
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965EE3DBD70;
	Mon, 13 Apr 2026 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GY0SbMga"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1E3DAC13
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090202; cv=fail; b=muYMUex9tlEIbMXMG+fksfR+Fx0liIb9xXt6xHlsycUtVTB1e+S/6zhTLDKWmUc2dACvLqfmFJFaiSQo7EtKZicAnoxL0vbWPSx8DkO/sP0DGDYggHA+9xUAIxjwFev4wfGtW4k+aqXoiWFBHVzIlyB55vN6jckKfcyx9nt1HWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090202; c=relaxed/simple;
	bh=naQhvXXHVz/SKOp8ym1I6JQPOY3eBG0lMdqnMKRf6QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X70oWrfFJNeqy+7BrdXGfL2fqQOakDYky3hG91qwezc37Dx8bwr4fihQyjn4aFFAHtfx+vWTaVXCTEg5nkA5KSAaAUJSNeGndhafnBxmDi27LDLCSKn1apJpkn15qEsYf+Lf/HxOr7rKSmfBbAnEEQ7cz6rI69T6ABNakVVTDbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GY0SbMga; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776090199; x=1807626199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=naQhvXXHVz/SKOp8ym1I6JQPOY3eBG0lMdqnMKRf6QM=;
  b=GY0SbMgatOPDQgZEmIIx2mbK/h1hCtPdtD+Eegb5S/OFeJwl6eRCOT1Y
   hDS5Qr+yadUCL9rrG29MZYoSfqXVuA3jd8xU55XcrvNjJjroS5ZKE5gxg
   HHgnMpqrWQkEErnqL/q0Uz+ERpK7AlSnl3AOHbNn1jVsykDLXSHMUbeHi
   kzIUdCKy5Sr7hPk8w88Avf+i9gPY9RLEP5SMTsBmCfHjva/Ih/jV3DVeF
   ec2z6Zuaaleb9bQhBZHDBomOCP2GwKqLW3VirnZBBIzLpnfIDw5ZedEDs
   pY3AqgukEbhknIAOgA8sDbkRNZeWn3fkCtOvjkWhCJ3Yz+VS/K6r+KZsC
   w==;
X-CSE-ConnectionGUID: ThPX0+a8Tx64Uoee4IXLwg==
X-CSE-MsgGUID: NvdgvTgeT360Pc7StUi27A==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="102483640"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="102483640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 07:23:18 -0700
X-CSE-ConnectionGUID: lwzyvKh7Q7WHbXH//zopbA==
X-CSE-MsgGUID: nM5EsphERDGpcRBLXrO1eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="225074953"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 07:23:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 07:23:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 07:23:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 07:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQibTsSrUKWeld7RCi/VFS02pvk8+73LtxTShSYuO6DSwOPj8uQaL/kXZ96irX9GxssUVMdGoF3htbjS1GIr//VrECPI2hDuL8qAJg6b3lxGcyWb7LMUObuyfBdBM5wwTJ040jiSU9jgpWuinzNjsXNeCHI6VeafzQFJFyfNNN+yKECRv9D+5tfcYdJhbyEv/CtajrOX+R/M+maoeeciKRzf7DqC2AmKPHdiWOb2cnb3GseJoXJx8Hc9cSePf1r+Y1UNZ7f9tzxSAuzAKMrfCSEvJHebnHlCus/GbX2eUVClPqSFo68q1UYpwKHtw6NPcJ98eqDRNycMaaKaqEl9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaIi/3CVlfiQuXU061YJv4PHHUHWFLlgzIdy/WeNLpc=;
 b=PMMjUScU95P42NmQAwmuyaWxrtvL4etw+ID0s+nCDs9xs0jki1HUxKjnvxihzv3he6HIJwy/I025tGir2cP2Wp8vmWj/7X/TKsdTpz8/hSUqtCcnapFLMnvIk8ybKBcPtulDshLpakiMIj8lHr4mktvZZCmICE721mVtq8wdLqwZiTcEbdkGiWjIQicTUk9YInK2nkZKlgn3dMYbBZpe9rONHUprmIiKHAeM07FjnIQxNtbw1cduiQahkHnJZxnzXUfYWCC5GdEKIPdXIOdhv4yOq/gHtmCmb04R43tn6d735VgMw6K6ION4eP/FfAX1cnvO9zYAR8alpluiSgNLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.18; Mon, 13 Apr
 2026 14:23:07 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9eab:962:806:3794%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 14:23:07 +0000
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
To: <stable@vger.kernel.org>
CC: Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Karas
	<krzysztof.karas@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 5.10.y] drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat
Date: Mon, 13 Apr 2026 16:23:03 +0200
Message-ID: <20260413142303.8908-1-sebastian.brzezinka@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041355-police-panorama-d0e7@gregkh>
References: <2026041355-police-panorama-d0e7@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0036.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::25) To MW4PR11MB6909.namprd11.prod.outlook.com
 (2603:10b6:303:224::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6909:EE_|CY8PR11MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: bd39bcc9-f3ce-4a5b-c10e-08de99682e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18096099002|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: MF37fuvMdyE0ZJ2T4TQGP2VBSe723XL5Ntm2Aba+dMR/YcH//nQsQ52FF9HcdQZ/k1MtN6E1aAtTIpS0XTs7DFhFr3iRtcDPGHUtxLadeNDzA3fKqs6a80slHl1EJz/CmzDwpwTdi0lz9xQyutp8rBIPaPnklb/JVFfNSRI5qs+zfnSFWac7Bsoz7yz7r/5iAomfBkU28M0dL+HcofO47zBOxRMNPji2Umrd0fy3y2UePCeQl+J8zM4+stQaaUxq1qA+SeaD07NE1GHLYConyK3Pjvr14dVuPqHc/ny6DjXMShBPjzTMbHJlCHgI2/r9oROnvHBVnksQrciJ3l3irbK65zYNU618DjAPoeXFyr+9akGGTP0qTgr09hKz6vMXW69/6PX1Zcx/OD3A1k7ZCB1GJO4sdXQjPfyZl6ug83o1y6rdaz/cHqp/ZUT/57skSadSmry4XYJUJYW2hgTi2zwbluRUIIoRj7KPfsM6ejPSPkOKV57ZE+HICWRw21BfB34Fe5wnqCt42OPCISyJyxmTRRXW2UcFmAcJAScmOQd0ZUSXF1Gi5yFhl/lAcm9g5pLcVrRjtwt8Y6BHe2Ffq5KvAddVV31MR488BD8AcZfHqPpsBO8qEqHbXV/LL1KNBqonRpvBo4Q2AKwzzb0GDWuHHVFTht9046OTwrhABTdM2U2N9mTQ60KhXfCPHaBY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6909.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18096099002)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBBjTRts3XL2czEI7ZmRvfw0STxLp/Hzb7nK4m08oSCB5OIIZzCc17npV96l?=
 =?us-ascii?Q?zIlutUvvTe4Ua840CQ6P4yCLSxJNTX2OFaVv/Z28mxzwTRD/axS5dmu/rzoC?=
 =?us-ascii?Q?TlAt4pD7a9FbJZhrh9riZYYjnHtcHnmgTVpoTMu2ugQc1aSEQpwaljgaPZrn?=
 =?us-ascii?Q?aTqamsuDBulW7D5Dik19eGkgY/6Drswd2uExisbwfA4QhKMJkPJ5s6c5/n8s?=
 =?us-ascii?Q?syIrfsbPQ0PuByT4UdwRnEmlw2xLaXg7nH8x5Sh8AxL63CiTikSNF4vX6nAG?=
 =?us-ascii?Q?Js5iVy8cUoUIStupdW97rBt75UH7/d/Y5tITJuMVNlMlWB/f3L6HFReB245+?=
 =?us-ascii?Q?UJMVihCKc1tjj8IHkDtnwd5xRLKMZ8v61YblkEocp31Jqllf7Iv9DeoGwqq4?=
 =?us-ascii?Q?3lphTZkw/6BsUrIW3btGtXthoI/COoTFKaOIIrGJPP4B2NTrTqhhP9YKlaLn?=
 =?us-ascii?Q?MSh+2zEzCQDoQ+T5aCK/oczieOZVdLpS5auEyNX9zwqxMaqCQgw2gbkKxUCw?=
 =?us-ascii?Q?x2umtdnAe/Z8OBdMb3JyfRpJ/Xnr2VokeNm5lOZpwcNDU9FLbVnCNLVchEQk?=
 =?us-ascii?Q?Z0EYuMhH/O5OKKdPJATI2uPjY/qIYmS7F6vDeUvRXwCLAvmfLPHD8mDQ7FRl?=
 =?us-ascii?Q?coiuWhdbSahR7fKplH/k5NcZLpCed5DQwc5m9IidIasMyrhv9OJlDz8SwAOr?=
 =?us-ascii?Q?blBdNq+IzbTddX0OH14VSFl9ZxrM4NxGh6q5rqdYkhkxUGcqEnqOF7yg2iVd?=
 =?us-ascii?Q?3Fan61eB8jZ7Wo/v6xxwUXGvI7gKKczU1LoyOeM6pV+ZOicx2LZfwormwf+b?=
 =?us-ascii?Q?knDUNEyKZfZmsq4usOaJEXGVngcxOTIxJrq3V+mNMlgS78szZ9kLgqG+18zf?=
 =?us-ascii?Q?bsk75nIXUxsGUCeUnlfYzsCt0+fMJBRpJXb78JpwC7XStd6kjvDKoiryNmxm?=
 =?us-ascii?Q?NuWXdg3W8RGmnPcIlJ7MrLz0PcvP4YS6WuN+eS3S8NTdMRrYr6Rnz0XLLjes?=
 =?us-ascii?Q?yayZ9v+asRPE1LetFGQ64XXB2jHc2OYFcCtDO56GbwTC/Vp2q7iR6egA1IR8?=
 =?us-ascii?Q?UYCoz3gYgiW3vKSMRtpcQyw4ZAx/2+Cec+h4JYoxR20cdUJXy92m7+fdgWNq?=
 =?us-ascii?Q?B64uGGBv9bYz3qqULm2mzim9g4Qhd/9ItywCvUISpSaeG6RS8THmFB0Va4QV?=
 =?us-ascii?Q?R3xtrIReM6reZVjo+8Mg9dfrX2wXeLX9V/2D6eRKogRLibr55qECafmnBraS?=
 =?us-ascii?Q?+X6EcqFGEIOzyl53qMnbn9MeB/Ix0VodmlavC0c+q0hmlMgGqmm0KpA6fnVH?=
 =?us-ascii?Q?mnQImqr2geWLnoQVfTxZeCefITVO+59ZgJ8P3s7Z0sJ2MZe1YVp2iP9GqtLq?=
 =?us-ascii?Q?ln5bOeYevh0PwvJNUFLSERVsrjaGSXIxczSdvl2FzzSMUZFTgsdSuc0ckcGn?=
 =?us-ascii?Q?iz/xMhL5mtdmaZP0BxxwTPaN4qpqCL6c+aeUtZF/jLTBUlRoyhc0jOdl346U?=
 =?us-ascii?Q?/kiAFzsEXAkDqG9eYrLUCIoGBBGKxxf6qw97HMNdU5YrjDBPEsKC1RpgF/JE?=
 =?us-ascii?Q?BsTzK1ZMg6il7sD9y7vXHACoJDDcIZCRPV6zt4GVHJfsopjC4ZR8pSpyrKEW?=
 =?us-ascii?Q?4Pt+woTZ+yZJc27PN/dRImtNu0A2QPhpUx/BwgonOY8pZcz5uRxgFBgkttBx?=
 =?us-ascii?Q?GDYY/OWksYNy40TpN5+XMv5on+5OW90LQXE5BVeDzshafnSTqgjUnDN4vCfE?=
 =?us-ascii?Q?ED0iLdgeF3ZfyOKB8GeIsBYrZ84dIQc=3D?=
X-Exchange-RoutingPolicyChecked: CAf3YXXY0WQy4tzTH1x5xdHFD2jhu83z1znEutSIKrZZbwGmUh1lNMusAWMzcgldV5Hon0OuA8lphOmlDZ/sRR1h5jyQoC4i9vlIQRW7WwhY+maQ5HP54Ti5GRMqXhWcur7prqHikeVZY2Xjj5W8TXsnspCCMonwPeUVBkPz9ds4kcG2tFEI8Jub4WyE8eP79F04ISXCdFleldoB/IklcR2E5RnP6XKPN9Ea1FkjX+65QrO6GnL+dP8YrnEUVjmFQHoJfXA83Wferd8JkKOp56hgi9TMISWpiQnaSCoK8e4VUs/h3NCwc5aLVRPxWeafX+GI/IX5RhG4rqrrMSoL3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd39bcc9-f3ce-4a5b-c10e-08de99682e96
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:23:07.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4jvMb8ejxdMQcGWB0JM/SoilnCE0ZkMRV+BAVCr1DXVkhuF8aDcyteabNYFJ1hwmWactmzVn4pek8HphkaMZ0EWjPmTaenn6TUp/Pp6Qok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-236113-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sebastian.brzezinka@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 407E23ED4B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A use-after-free / refcount underflow is possible when the heartbeat
worker and intel_engine_park_heartbeat() race to release the same
engine->heartbeat.systole request.

The heartbeat worker reads engine->heartbeat.systole and calls
i915_request_put() on it when the request is complete, but clears
the pointer in a separate, non-atomic step. Concurrently, a request
retirement on another CPU can drop the engine wakeref to zero, triggering
__engine_park() -> intel_engine_park_heartbeat(). If the heartbeat
timer is pending at that point, cancel_delayed_work() returns true and
intel_engine_park_heartbeat() reads the stale non-NULL systole pointer
and calls i915_request_put() on it again, causing a refcount underflow:

```
<4> [487.221889] Workqueue: i915-unordered engine_retire [i915]
<4> [487.222640] RIP: 0010:refcount_warn_saturate+0x68/0xb0
...
<4> [487.222707] Call Trace:
<4> [487.222711]  <TASK>
<4> [487.222716]  intel_engine_park_heartbeat.part.0+0x6f/0x80 [i915]
<4> [487.223115]  intel_engine_park_heartbeat+0x25/0x40 [i915]
<4> [487.223566]  __engine_park+0xb9/0x650 [i915]
<4> [487.223973]  ____intel_wakeref_put_last+0x2e/0xb0 [i915]
<4> [487.224408]  __intel_wakeref_put_last+0x72/0x90 [i915]
<4> [487.224797]  intel_context_exit_engine+0x7c/0x80 [i915]
<4> [487.225238]  intel_context_exit+0xf1/0x1b0 [i915]
<4> [487.225695]  i915_request_retire.part.0+0x1b9/0x530 [i915]
<4> [487.226178]  i915_request_retire+0x1c/0x40 [i915]
<4> [487.226625]  engine_retire+0x122/0x180 [i915]
<4> [487.227037]  process_one_work+0x239/0x760
<4> [487.227060]  worker_thread+0x200/0x3f0
<4> [487.227068]  ? __pfx_worker_thread+0x10/0x10
<4> [487.227075]  kthread+0x10d/0x150
<4> [487.227083]  ? __pfx_kthread+0x10/0x10
<4> [487.227092]  ret_from_fork+0x3d4/0x480
<4> [487.227099]  ? __pfx_kthread+0x10/0x10
<4> [487.227107]  ret_from_fork_asm+0x1a/0x30
<4> [487.227141]  </TASK>
```

Fix this by replacing the non-atomic pointer read + separate clear with
xchg() in both racing paths. xchg() is a single indivisible hardware
instruction that atomically reads the old pointer and writes NULL. This
guarantees only one of the two concurrent callers obtains the non-NULL
pointer and performs the put, the other gets NULL and skips it.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15880
Fixes: 058179e72e09 ("drm/i915/gt: Replace hangcheck by heartbeats")
Cc: <stable@vger.kernel.org> # v5.5+
Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/d4c1c14255688dd07cc8044973c4f032a8d1559e.1775038106.git.sebastian.brzezinka@intel.com
(cherry picked from commit 13238dc0ee4f9ab8dafa2cca7295736191ae2f42)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit 4c71fd099513bfa8acab529b626e1f0097b76061)
---
 .../gpu/drm/i915/gt/intel_engine_heartbeat.c  | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index 5067d0524d4b..780e29fa4aee 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -70,10 +70,12 @@ static void heartbeat(struct work_struct *wrk)
 	/* Just in case everything has gone horribly wrong, give it a kick */
 	intel_engine_flush_submission(engine);
 
-	rq = engine->heartbeat.systole;
-	if (rq && i915_request_completed(rq)) {
-		i915_request_put(rq);
-		engine->heartbeat.systole = NULL;
+	rq = xchg(&engine->heartbeat.systole, NULL);
+	if (rq) {
+		if (i915_request_completed(rq))
+			i915_request_put(rq);
+		else
+			engine->heartbeat.systole = rq;
 	}
 
 	if (!intel_engine_pm_get_if_awake(engine))
@@ -153,8 +155,11 @@ static void heartbeat(struct work_struct *wrk)
 unlock:
 	mutex_unlock(&ce->timeline->mutex);
 out:
-	if (!next_heartbeat(engine))
-		i915_request_put(fetch_and_zero(&engine->heartbeat.systole));
+	if (!next_heartbeat(engine)) {
+		rq = xchg(&engine->heartbeat.systole, NULL);
+		if (rq)
+			i915_request_put(rq);
+	}
 	intel_engine_pm_put(engine);
 }
 
@@ -168,8 +173,13 @@ void intel_engine_unpark_heartbeat(struct intel_engine_cs *engine)
 
 void intel_engine_park_heartbeat(struct intel_engine_cs *engine)
 {
-	if (cancel_delayed_work(&engine->heartbeat.work))
-		i915_request_put(fetch_and_zero(&engine->heartbeat.systole));
+	if (cancel_delayed_work(&engine->heartbeat.work)) {
+		struct i915_request *rq;
+
+		rq = xchg(&engine->heartbeat.systole, NULL);
+		if (rq)
+			i915_request_put(rq);
+	}
 }
 
 void intel_engine_init_heartbeat(struct intel_engine_cs *engine)
-- 
2.53.0


