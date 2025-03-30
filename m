Return-Path: <stable+bounces-127023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A384DA75B1A
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 19:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5FF1888FA3
	for <lists+stable@lfdr.de>; Sun, 30 Mar 2025 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6B1CDA3F;
	Sun, 30 Mar 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myxmeowG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AE8F6C
	for <stable@vger.kernel.org>; Sun, 30 Mar 2025 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354016; cv=fail; b=IjYh/7DG1s4GjkLabi7SXPdtuD5IpZxbbqsJouGOzXLSTghfhSEvFoljWAKP93igwOfhnF7r1Mg+niuVk1lMlTAOKgD+GseuaQhLdK2/oSt9J3Wf6yTPh80u7kpq75PHYW+RnFdIMwQmk4fUMjjvP62xOSlGOiurkV0ccSlUoek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354016; c=relaxed/simple;
	bh=4+f9FQlz44/bZ45p45KEragT8EAmw1dTmrVK/5c4UQ0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U/CVIGxG66UZEJi48al31k8j9wRy/Jyesuij1SPbf+ZUAceFtDjw8x1MOR3n7KI9S7OTWcdQr86pyIL8UNqdbqBlkmhgu3cvAZPB9ECgOUm8CxPDmcuagvzehrUeq2iO7/ugzgPzpFqEgOIkY+VL7svEFDAoJfRrzpt4t6P8hvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myxmeowG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743354014; x=1774890014;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4+f9FQlz44/bZ45p45KEragT8EAmw1dTmrVK/5c4UQ0=;
  b=myxmeowGNYOJq+zSQMF0cl+3nmz/x8qV3oknXEDNGwWQctOPsqjoVudR
   ys5ys7aCk8odGmRt3ZubGQrFfubPoGFbZgCghATTq1HqIQK2xVS2D4GHC
   vLgFqHZjuo5UF/2t+eTwv2SkidS+z3AfBwDq9wBiPOWn+VuwvCOTJHF0i
   hgINEYax6qTRzkJP0y45UGakxUwSNFaA0BVUWIM55JKCopsO2JKnmGQZU
   /h0kFyA1xWLhQyzxH5MJRvwVRRgshWNlrueOrFCy1PVSd+7z86y9gifDi
   C7xr462ZU3AFxx4mb1lvTTkxaeUhxdtbVbEQY9YTTg2m/Mwtpv94fqPKv
   A==;
X-CSE-ConnectionGUID: sTSjWYXDQqelxA24tAbhBg==
X-CSE-MsgGUID: l+JHwzosQq2Fa2FsKtm3fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="62185431"
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="62185431"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 10:00:14 -0700
X-CSE-ConnectionGUID: wUpsmeylQDG9r6FXMrGWcQ==
X-CSE-MsgGUID: cJ4wxwUSQ3CPy9DSNRyeKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="126365358"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 10:00:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 30 Mar 2025 10:00:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 30 Mar 2025 10:00:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 30 Mar 2025 10:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfrSLo4uQMcHi+VWIzc9tE7sv94FOYWNHgh8EX0lI8fTyTzNNDQ8wxXjkubKmf8klS/WfcfjrqTMnZPQg7UUQRKy/5qEcrxwKc7sm35anifqUvSFbAHMCXXxfD1FipQH26D922byf2Ng7i/rZXcAcmqRWwGUXtf2dBVaS4Hqax4k4N10KcNRqja1+nwMLadQg4EKYbqbfBkAAz0coKNZU6ZMSYRb1iaN+i/h2K97SkFyphmMidQtWi5HS26LhL33btcBegZ7+p7wdMg2FpbxtQz+faGtQyRWcdAloZqOijCCrjewC+812yuNPe4rZXKpzHurKXb67/F5NGLSTbJyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftXs5vmFBCr2pE+TEN2g02O+N6uHGytVuYz4Nr5LciQ=;
 b=vNgSvjPG5x6thkJd3aASXSdOy1sm3nt59bw4VlbmmeqFBNuu10pGW9GeP4wXZFzbuVmDr6QRa0RuVZ539IXk/QsGnieJZ/0ui+fHhwA0ukXhd26XTHdKh9PFf+oCL2X0Fp+yKZT4YXYv2ePjVU2eNbyR4N63fMusuCrKhUEApROPFaSRN/kdFgDP5F/D7DT27MEIO2PT5TIArHk9FeXi6493WdrrRuCeH+6FaYUd79il4EDIfBolLMPgQ+mLOL6aEmMrScwRdHIfD2mng5Hc66eXUOWxqWYibbQtcpWfbzAAXjW7MAYMqbH82Ts9wYG0lT4UGLEyQrMCOhh24Y6cHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sun, 30 Mar
 2025 16:59:29 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%4]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 16:59:29 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: Kenneth Graunke <kenneth@whitecape.org>, <stable@vger.kernel.org>,
	"Rodrigo Vivi" <rodrigo.vivi@intel.com>
Subject: [CI] drm/xe: Invalidate L3 read-only cachelines for geometry streams too
Date: Sun, 30 Mar 2025 12:59:23 -0400
Message-ID: <20250330165923.56410-1-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: bfead87c-d1b6-4ab6-f4f0-08dd6fac3c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?95jr8y2bou4I/F5ikzZNoID2HcltgHZqBq9Q4+Kfl41txro9ZTVe3b8iRqvM?=
 =?us-ascii?Q?YCq5pvEXjhCQEa3dT/Xqn6f0RNoCOguA2XEekF8QBas4+sXYCq+m5fV3+3Ii?=
 =?us-ascii?Q?xa8BVmz1MNFQAhHMqbq0b8k+bGiS9AtkCpMPneYajV8DR+pmxbota2bI8094?=
 =?us-ascii?Q?sJhUT0vaa3qHejdOkQ46/RDD+LeeDl+NFAl6VFysTAlRnx7reL0ubY5iL1ob?=
 =?us-ascii?Q?HULfwcO0y7awKIw53wvaDF/GuobjJX5NsthnYMSm2Zf2VmnXuu+BItiiGAqf?=
 =?us-ascii?Q?9hRdETgLw3/CURkGOf7CtBHhxII4liQhGMCIa0U6MOw0JpUkEQ8/uuB29A/5?=
 =?us-ascii?Q?274yUooo6hzYpLT9S9CZ/6T++/dujKKkFJpKyneqkVmkjcEESqJf8L4MssC6?=
 =?us-ascii?Q?Q6JzS4dneUktTA9SBR3PvbIBL82ARLZ/ro939OvqblAszsuEhoYZ9ngR7UtS?=
 =?us-ascii?Q?k2qiYweAoJw83oRBVDHbleD/I2mtI7COtimEMBTqeshqOrnUSyOs4q0MgNup?=
 =?us-ascii?Q?3iVPMpBqz7LuIqkLqoJ7p31QF0FrpDSUYIlol36QPd6PF2SrJiFUVaH/gwsa?=
 =?us-ascii?Q?mFPyHwPZkrkEP5ZIDhfLG1Yj9T0yjw+2CgnQJowGRmMPikkdWaWgJ03cflB8?=
 =?us-ascii?Q?z6nW9iiw7Iak4ZvYeyKqgpb0FVQRUH1ZpG+OdOzxI+P7Ji8KyRXTT1648Qks?=
 =?us-ascii?Q?HBk0msWQVGaGFX2BICW1ihG6jViIXalIG+90jNiEep3UsxLvU7W8lCtc1/U3?=
 =?us-ascii?Q?rGTuDjSX2LTo3EjDwzbugtKHRmY1H0fhaTjxfJE4/Rn+1nqyPdxCn+EP5HJd?=
 =?us-ascii?Q?sBgUwWnGpgDB4YfgDaFyos14fmpbBjza1982Rp3F8PsmM8KWG4fO/S5Dyi3Y?=
 =?us-ascii?Q?mdcy9sBteUx1eABOX8qGYP83ftLDyNFFl7sYutojojPaGqX9YtuTfkmqIuzC?=
 =?us-ascii?Q?rmVr4zMEQMRucDH1X2iNXNf8f+FWrFWrFD026mtQKf7mMeIp3wNI+CGfcvxP?=
 =?us-ascii?Q?iues8BJgp6GOxlUtfOtIMRQmdgCOGhmJUhbk+SR+110sWDnwUmf6kUijErPh?=
 =?us-ascii?Q?LYAl+x9x3G7qiJ596l7A+iBtfptEuzl+fDyFiaZA3HJjhco4XTDQ9wVRnrKp?=
 =?us-ascii?Q?dzA/cPE1BB4ht/5x4tzsfe7RFWz7/mgRq6FQOtAHYGkssyqfm1z/3AKQSCa2?=
 =?us-ascii?Q?5Gqd4h6u2JCjs7jxzRzHlh7wRIthHnW7oGgioC0OP0U71N6M5i48qCM5JIuM?=
 =?us-ascii?Q?QTwzShqowk+sPsXH1RygAZ4vvRIXgorF5/DFDjBxxZ54chxbfUQsJTQUiFfg?=
 =?us-ascii?Q?Pl+Eav5LkHJorFpTeT7S+MhEP8O1+EVQ0kA2004/H3u5vw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRx9/E3Wr5uQpNDJ1LFDN40YxNNDTzMATSvjogU7KFrX6mFzHoGLzeT3Hv+i?=
 =?us-ascii?Q?lfaRvWzS+tcgLNm/qohGKOZzYfonqoExDnrFbrFP9593l3V93uAuFyFXjhVn?=
 =?us-ascii?Q?6zZThMky0zdH1/tJ4zAipKvL+j14m8+fynQj4V0e8H+xGGNrYSlMFwZNQwk3?=
 =?us-ascii?Q?iwXKjoffr5sicJCfldFj55DaVx83cYf8QyUY5ViEtOPIh2ph1nc+O7N2ld72?=
 =?us-ascii?Q?2Ql363S3vHTOyGM3FJhDnMXEpOv0C65IEk4JgY9gWty1/5OhfTmYz7fruy4s?=
 =?us-ascii?Q?PmEDGlSPppm2dcv8jlmnb4/4h1mWGW/7KaMqY3ybNgI14pIWKCc7uUkH67H+?=
 =?us-ascii?Q?YbNHe0TzQoKG9bRtWEkV+rs7P58GCw5OiMTmX2cakPDZhKmREGjkPES4mpwJ?=
 =?us-ascii?Q?qOJikHxCDNrQ0KVy8lONE1BPWRmvcQ+qWdF9RGO5U2Je+at8iafWfxxrf74g?=
 =?us-ascii?Q?D/a1FWSE8xPKkii+MUpGcpzSYATUQa1+U7qMYid93n/sQ37RC/iFIZdn0eg1?=
 =?us-ascii?Q?LTaae15dyDzhgMKn4ePKgOGWVPLqDGD9NWRRa1L/hElB0bMCuTQ92u8+mkez?=
 =?us-ascii?Q?S+4/UTH0cfJOc1TtdUWQ+hL40UjCX6m+2V9M5V4qSx9MvwK+Us7/h4oDkzcB?=
 =?us-ascii?Q?ybBhu+e/MXbp9eQaxpRf0M3S7kLpmt/QcZT0Km6mX6LpgFVJ8ayH7ThqRmGF?=
 =?us-ascii?Q?POjqMefb6+i5IT+8eRz2YiKfFV+d+t1XLBUK5T41xEOZ25VCG5mDoySenDfK?=
 =?us-ascii?Q?35wc0wUxmNY5rjumfLKPQoipqLsma3lJpUUHbAYKaTxD4+dDkf2Lxg14rYX0?=
 =?us-ascii?Q?xg25u3x5qR56u0MYZYAIRAYAfgBpYfsunceT/WBVkNmUuCi0YlHAHnLNOuOD?=
 =?us-ascii?Q?NcBlb/caxtHJqYcy5Sp9zX3LKQeiPfsEBepj31ehu7k6xaAPsXUITQnwqWNw?=
 =?us-ascii?Q?0yUudGCPaED3hV9Ngm2FuC5HcqZbLpJIfky0+kFmNImbxbkprhrdSQj8Exb7?=
 =?us-ascii?Q?wgpA+FvTlg/ibVBRtUgfF+GxHY0r0aYI+NDo9/C0C+eQ8vNpc5M+ExPbxkSF?=
 =?us-ascii?Q?qVOnLxG4/eF+lzz7ipUK47+HT1YJ7PtStFIod0IXSF/f7DXVNRO+Kkea7F9P?=
 =?us-ascii?Q?aj7NOe49dXYDhzulcPMDbOhx1g2LUaC8o8tQiAw0sEcWK8jgdneI4Uk0k6I5?=
 =?us-ascii?Q?zNO/qY8B+ytWdF1rEBKNaOtv4Fp2cgFO5ReYNCjY5yEsELXzwFS8tpzpe8Vm?=
 =?us-ascii?Q?rkn5+w5JABnb0PDmUHKgkNGvkMwU1Jg1I1kBkAR2H1Z/vAb0AA5Ge67LTWno?=
 =?us-ascii?Q?q3GH8lhR9Yq3/lB1gmjQGBIH96rNZUgqdhxY/n/+Oa+z/X6bK01YZVYobXNY?=
 =?us-ascii?Q?MFqvm1Haz731okzLbPSkfeCAmUfQTCBQxhhXyUD6p2UpPi1oFoiCfOpguHyM?=
 =?us-ascii?Q?Q4tSecPUx5NcTdg1oCKXgEVVaihdJaAdCCi0cUPUgm51tBm1UEEU9v2zWI/9?=
 =?us-ascii?Q?UyMjunMJMVOeW83jV/zuHOmO4pA/5cBYKzetrji+e1uRB6rqZvDAAO6c3oKT?=
 =?us-ascii?Q?p7FbqjIOrzWj2Fb7irO2QT85DEhx5gqzoqgK5kBeO2nZQW5HJiWHGed30vQp?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfead87c-d1b6-4ab6-f4f0-08dd6fac3c0c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 16:59:29.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3yIs9lwhwjel3qaVGK09OVYBgYmpTYdUkQmruIqsrhfTX8RsCkr061HK/OKsEneCoW3J7ZqPJQnT1RZqMmUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com

From: Kenneth Graunke <kenneth@whitecape.org>

Historically, the Vertex Fetcher unit has not been an L3 client.  That
meant that, when a buffer containing vertex data was written to, it was
necessary to issue a PIPE_CONTROL::VF Cache Invalidate to invalidate any
VF L2 cachelines associated with that buffer, so the new value would be
properly read from memory.

Since Tigerlake and later, VERTEX_BUFFER_STATE and 3DSTATE_INDEX_BUFFER
have included an "L3 Bypass Enable" bit which userspace drivers can set
to request that the vertex fetcher unit snoop L3.  However, unlike most
true L3 clients, the "VF Cache Invalidate" bit continues to only
invalidate the VF L2 cache - and not any associated L3 lines.

To handle that, PIPE_CONTROL has a new "L3 Read Only Cache Invalidation
Bit", which according to the docs, "controls the invalidation of the
Geometry streams cached in L3 cache at the top of the pipe."  In other
words, the vertex and index buffer data that gets cached in L3 when
"L3 Bypass Disable" is set.

Mesa always sets L3 Bypass Disable so that the VF unit snoops L3, and
whenever it issues a VF Cache Invalidate, it also issues a L3 Read Only
Cache Invalidate so that both L2 and L3 vertex data is invalidated.

xe is issuing VF cache invalidates too (which handles cases like CPU
writes to a buffer between GPU batches).  Because userspace may enable
L3 snooping, it needs to issue an L3 Read Only Cache Invalidate as well.

Fixes significant flickering in Firefox on Meteorlake, which was writing
to vertex buffers via the CPU between batches; the missing L3 Read Only
invalidates were causing the vertex fetcher to read stale data from L3.

References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4460
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |  1 +
 drivers/gpu/drm/xe/xe_ring_ops.c                  | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
index a255946b6f77..8cfcd3360896 100644
--- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
@@ -41,6 +41,7 @@
 
 #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
 
+#define	  PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	BIT(10)	/* gen12 */
 #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)	/* gen12 */
 
 #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29)
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 917fc16de866..a7582b097ae6 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -137,7 +137,8 @@ emit_pipe_control(u32 *dw, int i, u32 bit_group_0, u32 bit_group_1, u32 offset,
 static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
 				int i)
 {
-	u32 flags = PIPE_CONTROL_CS_STALL |
+	u32 flags0 = 0;
+	u32 flags1 = PIPE_CONTROL_CS_STALL |
 		PIPE_CONTROL_COMMAND_CACHE_INVALIDATE |
 		PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE |
 		PIPE_CONTROL_TEXTURE_CACHE_INVALIDATE |
@@ -148,11 +149,15 @@ static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
 		PIPE_CONTROL_STORE_DATA_INDEX;
 
 	if (invalidate_tlb)
-		flags |= PIPE_CONTROL_TLB_INVALIDATE;
+		flags1 |= PIPE_CONTROL_TLB_INVALIDATE;
 
-	flags &= ~mask_flags;
+	flags1 &= ~mask_flags;
 
-	return emit_pipe_control(dw, i, 0, flags, LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
+	if (flags1 & PIPE_CONTROL_VF_CACHE_INVALIDATE)
+		flags0 |= PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
+
+	return emit_pipe_control(dw, i, flags0, flags1,
+				 LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
 }
 
 static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,
-- 
2.49.0


