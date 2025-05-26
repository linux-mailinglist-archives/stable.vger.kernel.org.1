Return-Path: <stable+bounces-146393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20001AC449C
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CEC17846C
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAC423E35F;
	Mon, 26 May 2025 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxNyN7OT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472A1F4CB5
	for <stable@vger.kernel.org>; Mon, 26 May 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293723; cv=fail; b=dLqcpqovvUqfFQJbg6SlUZ5XoD1Nt9pBCLXb+Us1FVEK4PXP95wEFQMjQuhWE89PWI+9ND61HMHSPktN/7NoPG7TxZWet9/SQLTh4BxjNDqNP5gO8m9LUXxOL71Z1fE+I61AkFbXcvYmGsT5TEu/QfUc/4FXm3lmMXoi8rX343E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293723; c=relaxed/simple;
	bh=PhQmjEmcg2rMubfAU9CKnr/fMm2+Vn5FxjNnssLHp+8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Aa44FDtrPooEr83Os9sLdzIcE4FRuouneDnMMJx3+z/gMPiVV4kTp+gDLzlPGkaSpr2UbMt7G8hVxadjP9ZeO/LcpEhmgve4xS2cqFqIX7kWhKkdagfSYybeFvnS3I+ooREBNV21qpBLyPP1UWWkDNifMHUws5ZGlGwJiDWakyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxNyN7OT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748293722; x=1779829722;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=PhQmjEmcg2rMubfAU9CKnr/fMm2+Vn5FxjNnssLHp+8=;
  b=gxNyN7OTAi91ufV/bm0xWA57hg7UIWRoRayzQjrId7HEx9OoHaM26d2+
   +3NQxIqUzUc/1fzaXXmKEkPoJhXhGyMb1ArWMjEEOVbw9ybd8MuTMyJt5
   5MFCeEaTESJt+NBaYU8A2kNuLZ5CH4FmbfjgK/P+NEppXtOEOAw652sGj
   aJ0Ib+EY4mIDwfxd8/xe8B78HwT00/7sWLOtSmc1qNrX2m/Erhw6hTU4j
   PX/lBHSDtVJvOvNvKvD1yOzE5ep2SoiSxE3SBGrAUx05uxE7PdatvoDRT
   /1iBfZlzvZWlc20aludxRYHD8TUSWIz3cQChBEaK7LQPgo2zPBZLqEqju
   Q==;
X-CSE-ConnectionGUID: jMJOwhM8SHOfVVnDnm4ZNg==
X-CSE-MsgGUID: 0Wcqa8xoTBOPDytRcci5Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="61678885"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="61678885"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 14:08:40 -0700
X-CSE-ConnectionGUID: MH0WbwVkS0mspX6XWC/QBw==
X-CSE-MsgGUID: +HpVFb0hQCOSwVD7oUoteQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="147668915"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 14:08:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 14:08:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 14:08:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.64)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 14:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8EYS6W1lh1Jt7CS+wQyqyvlSbb8im8mPbeV+zbqwh34VN3i5Z1JmtRJ3Z+rT6Jo3es3AickmfeETsbIfA2c6VsHqmkAqc6d6HoFmIOqF7rBdTgyO7wnlsxORkIj8ZZiy+OpklDburQS8qDMnPKaDmxg0pRpreN9NGqOCutSiEfCrWEB3tYgCWb9QL6+0XzfrFak8AGfPJzjrdSaNj1DnUM2zjWPnCUwS7UB6glVyWytxXFqiNTMYo5H7+5ZvxNH49k2+R6kWtAYrMzleF212bAVCAzUgHEO6iCsRT//QxIy9WmEmpI3GYKii6DWRZBmlLjr0ZQdty9JzI9Tbc/kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbpfo9x6yreeoswc0vUjrVu1eluLDUFkjRWCOJyhj4o=;
 b=jEwAfUFg+OhY+sKFVrEAYp/6URfHLLKxTsSu+/cQn3rSRdEoj+PBSM7rfSSLiSIHwxkdFwLGdz29dAeixMz3ObioU8cXSkI4xUi4wH25agljfOnubKGFe9wb53Amo1ImYd5q5ezjt+61Giw5Z2My44T/Plnc3UqDHLLtuPtLvHZH0PzUBf0IiKiHIIeRx1QHuHh4fEZYGjDk5bsKS4gRWS9SErQkhZHbNTdx/RSj35jnimY/FMgtYl3gjXE+sw0gP20tzWhw/wZ846uSTVRYyjR1txe+/z3kUjI7KDdMoGTE4uFV9rBZ37av+W0ioROFHCBhoQzoHUdOSbdllD6qaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 21:08:08 +0000
Received: from SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f]) by SJ0PR11MB4845.namprd11.prod.outlook.com
 ([fe80::8900:d137:e757:ac9f%2]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 21:08:08 +0000
From: Imre Deak <imre.deak@intel.com>
To: <stable@vger.kernel.org>
CC: Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.14.y] drm/i915/dp: Fix determining SST/MST mode during MTP TU state computation
Date: Tue, 27 May 2025 00:08:02 +0300
Message-ID: <20250526210802.2275116-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0038.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::22) To SJ0PR11MB4845.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4845:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5a1b5c-2aba-4bc7-5d04-08dd9c9969c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q3COU37bdRODReTmGPvtj/0L1W1NFVETkynSZnBF0U1TumW4EjJuiTm00l8u?=
 =?us-ascii?Q?pFe3VVnGWbTOyVFVbgiUyupmtB0no0UvPU//9EbAQFBneEk/iF0+EOF+UBHp?=
 =?us-ascii?Q?U4cTDpHoCBYSIe/go5QooXlOynGw/sK/+aOz66XmAuavOp/BoBCaonfwar7l?=
 =?us-ascii?Q?27mgnDqnbMASWxk26hrfIRq6L32fC7p/n0PgNUEvKeFW6gDPfrtF+yteUEkB?=
 =?us-ascii?Q?T/O4gtFKMBV7QRyrtP0WINf/qDlmJNcY0uxu/g0rudXpRzK9ZVuP48RA9+am?=
 =?us-ascii?Q?ei3ikdyL0PMba4XN8AB9FMzTKX98sLHDv1gsaVLMAX0roF+Kj3gK1HFPCjpD?=
 =?us-ascii?Q?fWImdDUF3xZvfHLqLRcLAJhRAoDpJIpLDCvLlBw5AVKK5aqep1vWUCvywTQk?=
 =?us-ascii?Q?vlC3RqhMyw6ud2c9KO7qNXG59qMj0xsRjEaYUpeSf/0IZFIPTeEe8MyoGqcm?=
 =?us-ascii?Q?l3IqJUQMOVkpVsY7g0cSZEHw8szjBmkq4DpnZYHEfmq9TSO3PrBmZqG1wfVA?=
 =?us-ascii?Q?h38qzFgqgSUIAFWqFgMpBsitJBsyDCe+vYKa2G5Br4zy/pnHBkLgaPw9NtEo?=
 =?us-ascii?Q?I6MFgi7b7CJOGLi2hYVwcXZPBp4yP/oIQMz001PuOZsSCnDQmLlXJI5OrvKW?=
 =?us-ascii?Q?UCIdTQUt83CPfhsT3CWogzC8E1uBquE94RLVTwoHMlnaOMz0fHcPi3Cj1EEa?=
 =?us-ascii?Q?Cc64tfAU36Y5VKsc/eNlwuzKDyZKm+jaH2ODlVIqAz4Hwh68pKBd2gLUECl1?=
 =?us-ascii?Q?TJqh4SevMPXPB3DEbQZJ049l2qyAB7HrFJvcVDyEj7+mnI1ZfkdYa7XwuU2h?=
 =?us-ascii?Q?mV4zw9R/6sabWOGdxh+v8qmgPHBgnDyvPYMDy8UbS995/D8UtVP6gYkaYN8l?=
 =?us-ascii?Q?Dgw+/AMdUNAakWCRNRNg5Ht7/iTr67s/Esqc6bW8wD8D6sYYUQdGJL3o+CCT?=
 =?us-ascii?Q?oxDKUYSDWXaS6+FYvvDzbNAM1sfIdimfECURsMz662/gBbndLR3+lpdvTfqF?=
 =?us-ascii?Q?2BIy4VcMnNSMM7/ya6lWQejVTPGRcQ/O8sOSyfhjo3RF1rr4wfcS35SIO79n?=
 =?us-ascii?Q?gRcrcIYRn5qUFGiKiY5m/CYg0xtoa91BMYgIWsf3065GXpO1V1z+PY2Xgphn?=
 =?us-ascii?Q?1EsU8yaLkVViyj4I+zilSEW8DdZ8+MA3gJLlxpPSCVE6a774xs8j9WpLP4Ka?=
 =?us-ascii?Q?uc1qwMHcYlhRoT+SywRFS0kaTKZXVHC3nKZtoHOg+uE3B643tbBum9a89CBg?=
 =?us-ascii?Q?EOTf/surXUg+zrLO3uLHU6FzSmem1n6GeiIIFOaKpyjk4QIWhdmKYPwdLI/0?=
 =?us-ascii?Q?M2QW/3Ow5CPaKqBZuyjJiXqvN+3/kDyfU8Ve0XpXROyQoBFgLpKVDfQUVEXk?=
 =?us-ascii?Q?C06WLHg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4845.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PqaPgsJfybiw8i7aDsRo+hrhsyzshE6XtZ71zQCDUJmqtzTdU9by+RlAJFwc?=
 =?us-ascii?Q?yw2R2geqAWkhZPZzfQQBKSn19qLFiCqifZ/cPZQcd2uryn/Qhazo0AwT8TzU?=
 =?us-ascii?Q?GxK5NYNEh1v0fHdN1uq6aqNgVKgOL5LzxFgd9pbX2iyvg8dxeCqKgPrkepl+?=
 =?us-ascii?Q?oCq18t8rvKUqqNn/7FbcSjiZ0L2MSctLTQOX/Xdocj+CSCzeVpGcqjAKuSbG?=
 =?us-ascii?Q?loU9vwoABKMdNnEX6YgJJhyzaTOmyUODPiv6sXViSHmm8X3HQZRVgEBXm0k/?=
 =?us-ascii?Q?jlGfAmJLgOZWHtOt5WCheYSCbDg1/MCQ8+91O+rC7Zfw9R4rwqldlNZYsmRM?=
 =?us-ascii?Q?EIYFDRPsWni0wq9FJJQaLAWHV4CNhLivjNwHdpny3/y7kqUii84y7EPYArt6?=
 =?us-ascii?Q?GKD5ShvamO3fR1EYoFivsAZR/kEGwD7aOrx8Lke/5svQe0vU1MUFOKRdS5gT?=
 =?us-ascii?Q?fGrzFRcb4kS0Vdk6OkNnIYk23tUCnz3Kch7zuFsODrkhItJUrZ1LOZv5OyhS?=
 =?us-ascii?Q?D7KovOelQMBF7tWcnhO54KEL7Ohk5l+EyRr9UWTmorxuAqINb46tGbiVmzQW?=
 =?us-ascii?Q?cXchDnO8B+PKT+ZQwiPv2c1Klch63oBl0mRNt5gRTn1T7g5tDfRu4xpB+W9K?=
 =?us-ascii?Q?BMHhKNW6fZ18G8zyMmuSnkareKcUY4hsY1qqmPv89x1BRnkGLZMTYkxIFBXY?=
 =?us-ascii?Q?mCYy959PdxWM6kUO30hSt3trCmRMiBMsQFrQTK1pK0pPk6j/3YRQwXtB4Lmq?=
 =?us-ascii?Q?83O5UrYe6eJK7iVX8/zkKFqXZDauaieYHh6N/BiJ8TLyU51AlshdUOSapFoW?=
 =?us-ascii?Q?ALPuM6+SEBhZxjQysrt67Ep5Y0t6QdNesDM2uvTWR9Rsa79lNwmbdjDj9adx?=
 =?us-ascii?Q?A0I2Qkjnlo+xUnJy5DdqHc4spxDrPTQjFBuOZxhhZMugvTnk3ADL9p/Z2nrF?=
 =?us-ascii?Q?w+ktoz2ijmsTjo7BCTgj6fepmfTH5IC1kimIiBGBX2buaJ7n1w6q/i2fR3nY?=
 =?us-ascii?Q?Ync9SFXbW6B+0mFbV8ZDfYGyctxAy7dM859S3ViF/1yh24HeS3sBj9pomKLs?=
 =?us-ascii?Q?bUn3EsxoMZLhFmDuHLy98WUU76pIPsKMJ9k64Dj0knIba7AvSfAGY38wdk5W?=
 =?us-ascii?Q?IIM9NZ/TjrPxXunRvfdRMWf3FiRGZ768cleIOkf/aQm4bj5mCSW2upDwMkOu?=
 =?us-ascii?Q?bIc0hMwd36LYlhaUK93gl7vL585uFzApu+e36BJ4G1YF6/FFG+Ru/M1UcpRh?=
 =?us-ascii?Q?fXEs3z1jxf4m5rlFbn5xkRSLmImVYwWBmg4dzturm4yOydjrqq/HoM5G5rbp?=
 =?us-ascii?Q?UmUVM7kIvrvxO0ROGwifRNU6zmbQb6MICP8MiLfzVMXxV+1YPwdGV1UlUBHl?=
 =?us-ascii?Q?KXviAhsPl1I0Z9uf1HAh0/q0hP7Kjojty8kX28TGgbuR/A9fWEW5sfX5T49R?=
 =?us-ascii?Q?xwPR3LZO680gdbMaEElUpp6JnapAdi1JQq7MLUKV8AgmXlLI6bZfeOiR2TpM?=
 =?us-ascii?Q?bNpScmDGjYDBj/vdhkG1yXFyzqC9dAWOvfUYx9PLHYRwfFIs+5ZkkaReH1bc?=
 =?us-ascii?Q?ZOd3TiBLjon5aoO2HSiJXa3v6Tw4v/uwxzKlBcTW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a1b5c-2aba-4bc7-5d04-08dd9c9969c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 21:08:07.9573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4ZiwQIKwRbmMCMWc9tPIG4L5JQHuR88n8XgjqVmuc1QDoGSt520wQey+pYsEMkREA4zNANXuZg1dCIUROdQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com

commit 732b87a409667a370b87955c518e5d004de740b5 upstream.

Determining the SST/MST mode during state computation must be done based
on the output type stored in the CRTC state, which in turn is set once
based on the modeset connector's SST vs. MST type and will not change as
long as the connector is using the CRTC. OTOH the MST mode indicated by
the given connector's intel_dp::is_mst flag can change independently of
the above output type, based on what sink is at any moment plugged to
the connector.

Fix the state computation accordingly.

Cc: Jani Nikula <jani.nikula@intel.com>
Fixes: f6971d7427c2 ("drm/i915/mst: adapt intel_dp_mtp_tu_compute_config() for 128b/132b SST")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4607
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250507151953.251846-1-imre.deak@intel.com
(cherry picked from commit 0f45696ddb2b901fbf15cb8d2e89767be481d59f)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 732b87a409667a370b87955c518e5d004de740b5)
References: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14218
[Rebased on v6.14.8 and added References link. (Imre)]
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 86d6185fda50a..8a6135b179d3b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -221,6 +221,7 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 		to_intel_connector(conn_state->connector);
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
+	bool is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
 	fixed20_12 pbn_div;
 	int bpp, slots = -EINVAL;
 	int dsc_slice_count = 0;
@@ -271,7 +272,7 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 					 link_bpp_x16,
 					 &crtc_state->dp_m_n);
 
-		if (intel_dp->is_mst) {
+		if (is_mst) {
 			int remote_bw_overhead;
 			int remote_tu;
 			fixed20_12 pbn;
-- 
2.44.2


