Return-Path: <stable+bounces-194570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB6FC50A94
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 07:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D31114E6F3A
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 06:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FB2DC322;
	Wed, 12 Nov 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bbm6mPuy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD472DC78F;
	Wed, 12 Nov 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927215; cv=fail; b=aGE/DWx/0PPEt0CC4acOUmnCOyci/dSR00LWVWHLTrQBLm9gMv36I7TAR9F/7WFWUi0SG8mRDcWP/yfbH7Un+wDeAE0ZkmKOIGITPVq2kbTJAsfl7uJHBOS7eerIiDkXt7c+1dH6zPt/MAL7q7rfMPMo7/4DVZspY6aZRW4+PI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927215; c=relaxed/simple;
	bh=k3MwpVBL0daMhBLnbHi8++1ZT4JJ1A5mk8zu7CytfqE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eFXBi8CHMb6yY7DkbTfVM5j4nPPY42GODErTfCl9xBEpI1hUHsH81beLKH3VCk5/WQu7Szw9K5OYF/ejzW1fgFL22Etj44Gd5h5B6e1UJ2WiDb9nnPqXHq2sUKWh5H5gjUSCxHH/dnxOvP7l9i8rfi/rQsfOrwByLZNGh6c0o4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bbm6mPuy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762927213; x=1794463213;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=k3MwpVBL0daMhBLnbHi8++1ZT4JJ1A5mk8zu7CytfqE=;
  b=Bbm6mPuyekyZfyTMSR+5CqAAJFrp2R8nyhRE3Y+q7QTRX1LD/5AYiNxt
   6iJ1qpOPnpKcaiFyG1//N24Ew/w365EY1XKjRLc7Z+/y/OQGQhqaux/TE
   nGn/jvehU5TYMzPXEDRmDERjuvnZDahOkrMxeqZPq+9shOgwbVF2+oxNC
   kiZX6EEFTlE4nOJXe2Fobj/jerNg+aA8+s/e/2Ov8TT984E4GtrjDRx1s
   UlshsUjuxxEaqy0bpxijWKAMXu7055TrD1fUizuKSgrneIMjOShLFV8Uy
   MEDsvaSsvW2TxDCFpjEKj6YlWeYYz4OHYGytEJE7jEWI2+09m3ofMzP8c
   A==;
X-CSE-ConnectionGUID: vkoOAx/NQXSCP3V4MrCHEQ==
X-CSE-MsgGUID: a7b3gvCVTWWQzelKJGncAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64919700"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64919700"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:00:08 -0800
X-CSE-ConnectionGUID: KWWmdLyPR6G0XvzPx6HfIw==
X-CSE-MsgGUID: 5zK9TzYRTj6cwr1Ve4zIKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="188393706"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 22:00:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 22:00:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 22:00:04 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 22:00:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nroZ7kVNIT1qMBvzGMeCgXUY63FzaGpk/WeOmfETqvu/HmzDVC7sx7ghwc3BT3uQR3aBu5eL/yrnD8t9l23/rRuldqNcRrTGEXNkT8jePxmZXCZJ8AtyRAvfoZopF5szZBo7lHa7OMXWZBZ8cwk/BecQwa52stVPS0BDIgHbtxXsA2+qxrJbxTGesw+k6RmGqYFtmkP5ls/xoNFuWnovEx17gKmXtOveGnh48z52iEy7JHEZa6+Qob476ce337KPSMNB+rLANKoy80cfqB5tj7r/IPx2URW4nJeUWAf9Ld3DXb/vJXUwksb4IyfAaelazZ4KYJYcffXAWImH+/UjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFSIsiYMBKo96/Ep69Noz+GKnkM9anDv4rTE9Mp1WRg=;
 b=qEXvXPtbkwcdAOZups0cAv4CKrjjDp3v20CRPrHiGLCKHpV5S9jeokqITekxg4EJ6Cx+FRseuRQgyOt8cStpcVvboqJCkKSpBudxeOymPOCoK/Qnr8c/CR3gahDAQ9OdxmI+gXJFngMafXaGcnkos7IZCG+6x55Wtn+y/uJkSiNV+W3uXo5ndtFOZqvm3SDTRs46byUVkeEqdwbkUpFlZpCCnCo9osJoGaoq9i0JwU6obRTejKRq3gv+J/SCNJO/TeNg/YxSs6Up7UUQa5GfUL2cH17STu979Vmgu9IU35CXDnxxeTbRCZ6ukfkshLOsSPQX2GT+CtIpOf8EjF6bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:00:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:00:02 +0000
Date: Wed, 12 Nov 2025 13:59:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <sdf@fomichev.me>,
	<atenart@kernel.org>, <kuniyu@google.com>, <yajun.deng@linux.dev>,
	<gregkh@suse.de>, <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, Ma Ke <make24@iscas.ac.cn>,
	<stable@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] net: Fix error handling in netdev_register_kobject
Message-ID: <202511121347.b3f6c2a3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251107080117.15099-1-make24@iscas.ac.cn>
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: ea82fba9-9312-4ad3-e139-08de21b0b813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aPZTAvMJT8mlMmxLKlDRpwqzk+n6cvJKa1ZLoksltIrj0acRamuJzdf2muV5?=
 =?us-ascii?Q?LMyqASdA48CxqdLgcuWRay+6RRVVwkfOsfppxfr6Jple0AIUDSsPBPDe3Syc?=
 =?us-ascii?Q?Ixl3es2VMzvG4D5FrYf6GLORzZWFKTPC5IucmHNVkLiSKLInHd+dt2JzZb2r?=
 =?us-ascii?Q?zaJVWdDrIq03yvfHcBc2tZJ05lKEx4IEpXU9eXxcroyn4DqRnqxRp5nWyjNP?=
 =?us-ascii?Q?inSE8VKtV7t2TKM0xErSPkcOM7N4fSTgk6k/dunMCJlsCJqe1ji929zT5Eb7?=
 =?us-ascii?Q?hoF9/XJxzwKBWVfH/VLiw+DdPOFNjzwhyf/MwNrB9krnLz/JMrziZo0kRqz7?=
 =?us-ascii?Q?gbkuEK7XRSaujxkKQtbIXmFJm+UuE0Wm9cZtuQNZgM+gfuk7S8bIKsBX3UmC?=
 =?us-ascii?Q?9jiSns+QnD38oK3H3O5/5rNfS7LTU7RMHafkeb6wwBPIN3SngpeprXCcUAhO?=
 =?us-ascii?Q?WKZKPROAUbm/FiCTL1wLf6HtuIxPMnjXSgTUZbR6813FBFs+0+eGbyu3GBv1?=
 =?us-ascii?Q?i1qNNJFmcVrtFXts7VZbB3mSBUMO7c21ctisXCrDP0MpY7OqziK5SAe5ez6X?=
 =?us-ascii?Q?1FnVFgZwfDU2KVCJz0Eaf2f3hdkTfck0QC0i8tYTepeSucY+22RKsWqk6Rqb?=
 =?us-ascii?Q?2jDBAGAPt+/kV5sN3mrQlbFkKEUiSSYpznqC3kmfnPxAygTBwC/kb0+669RQ?=
 =?us-ascii?Q?aLkqNWgD5Xl8bMIJOrLyewwlc8WGZJAGb3sJwl/mUTXXDqRXd4YPlds34ztP?=
 =?us-ascii?Q?8A99ZcJEYUUVwb5bQWgaNHBgfzt8+Tdf/fCR/u1tgpPsUtRIZjsqVd2HA4HD?=
 =?us-ascii?Q?PH/YRok5OCCKt+dOBjYe+m/PYcSAYVxMTILDq0CBjqdh5YLudgET1+dMxARo?=
 =?us-ascii?Q?dMZK+sI/19LnyhsoMCl5k2Qz4owRZExelHsODdQjtYvkVFh+ecT0Lbn0/hoX?=
 =?us-ascii?Q?27uhn+ShK6HPJdfdq9kGsItp/5X9UTx+5VlxHqDazP+VpNpLX4Z2Pagrdhbn?=
 =?us-ascii?Q?cQ6J7DUR7TUh4/6sgkP9ExKpodAOKPOPgF9zQp/t27zeQQKx45LgYmf3SYZ1?=
 =?us-ascii?Q?/0LQx2anSglETPl6A0d4CufTOqOQjlyWeJ6pT/0ebx6IbSh/KddMzzUXCsOB?=
 =?us-ascii?Q?inl82LfcEfyrhWyNOyU4Fo1mRMKwXnNfHc1qLFF5r8vH6JaeRArY1bKb4zTT?=
 =?us-ascii?Q?GjICN/+oRpTtqzQVTvi2qpmeVhhLlD6H7zV6dOZsiDzDgCDYR19tvzWS0eWO?=
 =?us-ascii?Q?PXjhTHrSkx3+7lOjBF3zWgKxWc2t/8jiFSIxHIPMT+alAlWeyMKZFpj8KNI3?=
 =?us-ascii?Q?INIX994tnnQ/crytCSFPnaqDqUM0KVBjtBSztLcVyqbVbsaMWBb+jgKaX8fy?=
 =?us-ascii?Q?CgLS+74ocUemkGsIycMndxYp4vgigWhsZRnOAV+pcfw8XXkktw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G5IrA8JpVmhUFOY1HgqI7eRNJG85kt4BZBwF2bhbF3W0w0g2u2tlIRJ+uJ1X?=
 =?us-ascii?Q?YgJ72CwBgwcr675oaNWzPSiftMSoTn3kdSIB6Dp25+lo6qGcqO74fou94rgT?=
 =?us-ascii?Q?NHjeVaFNEikXf/95OFmSFkBWPxZRT29mrIg6xSnl/BHOsRuLGMPmbUmRrKFx?=
 =?us-ascii?Q?w1z0g5mQcCcQFcikGrESQ96ATKe8vqu/U43UPqD7p9twhQbbDav3VFA8nsaO?=
 =?us-ascii?Q?6rvuJNIrTs2JKov/jotLty/3ScxXLfq9l9A8j2D/q+GYHhn5UjNU+1IuEdCN?=
 =?us-ascii?Q?p+P6XJiP/ssTKidbAPirKlNKrKp0vsFeNm9Tbh7MBq4YBtEJo8aoDvFtwFRm?=
 =?us-ascii?Q?GxDrc5q3U5JI7u/BEf8ICXs+jgXL8wKxkwpDz3lle+RrG05BYK35U4r6uAyt?=
 =?us-ascii?Q?s8zFdG0qbhYUrultyL1p4IHUZnwwUDP+TnLzKYnSq0gmPEWjWSBXqjxuyVVV?=
 =?us-ascii?Q?2L4fwSGMm8U2AxFL5nS/DavFLKiQPirHvUepyWk97uCqRtslInGH11GJPFhY?=
 =?us-ascii?Q?s/0FJskikKiaUhUVHxwfMM7t0EnC8L5m6j3e0HTw5w1A1JFHncQWcTTeORk2?=
 =?us-ascii?Q?O4PjwXqpTcGwcZwZdU51ExPOUFKHIv6TGQiyKg8Rxyhm2kodfE9kMXkUVGjg?=
 =?us-ascii?Q?fAKlBWn2hNpJcv5MZe/VnkH3lzpCUHjvbAqPtJg88WR9lmO1As9YS9ZvvVID?=
 =?us-ascii?Q?xx5pGGmlq0pu7Wlyu81Jf9nw9vH+wVkwnlNUCYDcmd6he8s79gQu+eWOuPjW?=
 =?us-ascii?Q?PbUQV0AvQ6tgTBIngXoXArm4fj1WPwh0jDYPoT8MDIFeyZ1PmemKNshi1J+P?=
 =?us-ascii?Q?q5aiWZel29lRoIaUGdnM18exJmBBPF25qGaqLQtr9P+juB23AeqPSF5p9kv7?=
 =?us-ascii?Q?8DLR6okyjQO4W7p4MjboSfV7v6fVFi6Z1fhBGVjrSK3npycQOrgolLAch89X?=
 =?us-ascii?Q?rWHktBkdlKMhuzYC8qDPERXoC82+wVMe9GbpLj1KUjFPgnrfzQhBSsnXNVBf?=
 =?us-ascii?Q?iy/ODhY4rTIFS3TTv1VodrXj6cKWCMxr82pPsNxZak/qC9Zn8rYKHlo7FqfM?=
 =?us-ascii?Q?xQcwx7gqA57ZFcbpAMyML/h+irAVL8CH+KYz/DtiDLkayfC98Immd0zAcyEe?=
 =?us-ascii?Q?jbjWjrrifqJAx7wOzMdDQiudNVyBIFY/ZHR7cRWmKNR2oFyUMZ4yFgZYq7/M?=
 =?us-ascii?Q?TqiXQELNGnlGspnEj0PwIIQQ1haNskQpuh20TT4/jKqmVrlj7hkLDwkqR97Y?=
 =?us-ascii?Q?Srn2aHBVSNF06oYZbgOpZ73L56S2r6Uywbp47QrVDIxYOquDxEozCvhS8OV5?=
 =?us-ascii?Q?PKkim/dwaRbfYfT/ZNo0NfKADTMmu3FNiP6Vx89ywt5yUoldMyZwjotpVEKP?=
 =?us-ascii?Q?yzsiDEN53K1fA00lIAPFLXAOjtjarbMlaAdxYUxtxgBmH7mVK2vPrBz7RIx1?=
 =?us-ascii?Q?+5oLw7Av3q6GjfOKgGUD/O64HjjoTXdoOtVPznPOnkASs4z9xQ7xQT3XpeHE?=
 =?us-ascii?Q?nE1fE+9ZUGUGkQa7xlygmUaMbOq0W/orfkK5fT+aTxRoA7ZEN4D6wPOILCgy?=
 =?us-ascii?Q?nTe7N1FJhPIBomJ5mJ8zlJPrKvrtx5XnGxhpPRkUPfER3u9ibwml2u1NfdAD?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea82fba9-9312-4ad3-e139-08de21b0b813
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:00:02.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoRqYpBGMcZSyXs0mriyLD5EflHVcS30h0sDHERcBtbJ6DxjCnL2i/eleR2iFKWgH3I9YXp+UTevVb+C1TsBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "BUG_kmalloc-#k:Object_corrupt" on:

commit: 6e383382971f4573e29f0e85c6e5667c8f5f46d6 ("[PATCH] net: Fix error handling in netdev_register_kobject")
url: https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-Fix-error-handling-in-netdev_register_kobject/20251107-160348
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 6fc33710cd6c55397e606eeb544bdf56ee87aae5
patch link: https://lore.kernel.org/all/20251107080117.15099-1-make24@iscas.ac.cn/
patch subject: [PATCH] net: Fix error handling in netdev_register_kobject

in testcase: boot

config: i386-randconfig-014-20251110
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511121347.b3f6c2a3-lkp@intel.com


[  OK  ] Started /etc/rc.local Compatibility.
LKP: ttyS0: 250: skip deploy intel ucode as no ucode is specified
[   15.199659] rc.local[250]: LKP: stdout: 250: skip deploy intel ucode as no ucode is specified
[   15.508990][    T1] [Poison overwritten] 0xf5e12370-0xf5e12370 @offset=9072. First byte 0x6a instead of 0x6b
[   15.511968][    T1] =============================================================================
[   15.514232][    T1] BUG kmalloc-2k (Tainted: G S                 ): Object corrupt
[   15.516308][    T1] -----------------------------------------------------------------------------
[   15.516308][    T1]
[   15.519187][    T1] Allocated in alloc_netdev_mqs+0x7d/0x470 age=517 cpu=1 pid=191
[   15.521218][    T1]  __slab_alloc+0x53/0x80
[   15.522561][    T1]  __kvmalloc_node_noprof (kbuild/src/consumer/mm/slub.c:4846 kbuild/src/consumer/mm/slub.c:5268 kbuild/src/consumer/mm/slub.c:5641 kbuild/src/consumer/mm/slub.c:7100)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251112/202511121347.b3f6c2a3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


