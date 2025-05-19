Return-Path: <stable+bounces-144893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81954ABC758
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 20:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD054A2642
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E11F12FC;
	Mon, 19 May 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akCErf+v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB01E47CC
	for <stable@vger.kernel.org>; Mon, 19 May 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747680371; cv=fail; b=GFRHz4Mryw0ZaNjSYfFmqctI+6Gv+1ocmMaCNnws0XGD4Zq1KjYdjMrRIy1NoBq7TRt+rnovnOS3E3TYiMzX8QZJAdaFSMpcKcNFToQX1RMWeUCrnHRAYdZVudtoHDOACdyMe2JeiGqzZrbDtUIcrEfe3ObyQFc/3Y1+IfJjurQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747680371; c=relaxed/simple;
	bh=lnrtcs4YCBWhR5tfd2b7rCn11xUJYb1C3pbLnJrSMbc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PT5fVeiST23gIVzXjiKVUqHuXTTXNqezDI3y6YiDWHkS1Kx3KjSXZS6j4Wl1FNn9HfrZbmN2s9jJyLwPUTZUydsX/c4jf30f1xYzK/UmZ1vyeYwwqhlpKG0nv636jU8ZKoZ5d/Hjq3iQLK79MVRFYZ0Rm6JYN8ErFhY+u9PCaBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akCErf+v; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747680370; x=1779216370;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lnrtcs4YCBWhR5tfd2b7rCn11xUJYb1C3pbLnJrSMbc=;
  b=akCErf+vEzbx9V1uKRQJceUc8unmMbfbN/J28NZ+TRRZhCvW+TgnCssX
   +8tM29uOohroxCIt0Zknxzjp5ueB0gYac0pFYcFJ65h2cNAiP19IvfuF+
   jvEmzSVSwXB270xs7YVd6mpILB8ClmAYbYH7UayDJb/jfTsTZQAyVEZQN
   XF687HhS3VpIOhBj6r15B9M91BKRFN32qs0C240WJ6OQcb9YYX1kvI4FS
   YcmzW7yPUnSBpCnYluftkh9ka7/2MviFIEfEiXwFzCYd6y1upkupQNB0G
   XEAkRdLpHxnOqKEUn6dgqjCaO5BD9p2pVGAW8txL+Y7RAhTs9HgKhlmtk
   Q==;
X-CSE-ConnectionGUID: DfgsSxLgSb6Fhoycfy4xsA==
X-CSE-MsgGUID: 1Vl9tC9VQUif3RJ3VD5Xcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="53267233"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="53267233"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 11:46:08 -0700
X-CSE-ConnectionGUID: 0/FItxDRR1ycNHDzyMsOKw==
X-CSE-MsgGUID: kVFkIPBRRMGuIlzmPpLrkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139358884"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 11:46:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 11:46:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 11:46:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 11:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Upt2XD6iANtgGjgfxDME8Agu4NBpt9+05Bq0+dLg2Vbvi6o5DuzcLMF+6ZsjVz/iSS7Xga89g70g7aOvQfRyEes0VxTIj3JVQT7/WdS0/ttwPSJLce+IQfifXcEGPguh1PvrWLLvF6GIVI2wV3oTuTs3G7rUCNAXd8W+/S7vqbTiPCFA8W5/o25/dgdBce64JaEm6dgI4Hm5PHvldMDSCvPiVu31tX10osTO2HXo1X/PCaQsBoGSUo5q20t+KKK7TcuDD+jhdVwSEce563RtI/dLoHl9RjY1lXWAl9XCoDEGsPfa3eHetds4uDN6BfgjdSQEju9SGLulK+kdMGfWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBP+IkUWvFZijjlwOop7wJwXLgiCjIf103Fwvtm4cB0=;
 b=xvhIvy3/emAHTUL3M1tzqn/Rqx56bok2jsxHlvBdRQRMUxn14G2XQ1pq+TGLJ1OMq9wyiHWoF3ieyDqSW01zgpmYm3woqZeNDkXL9j7BODUYwoKHRxOi8xOxrJUEAR1wBxPBrJcdaXSfYlKZqyDSJlmAOPYL/WV4k5W3A+2sZrrp8esM+0uojpLREoDk86bog4Cgh0OrbVSJpd8vm++oKwyT0/9hPuuSKOok5bibEeylQLRNJj+19xbarlDJV+FyfPXrbssrNXIHBWiJJmmSeFlQ65KXlRDoWXitLdL8DeGBPtOEuMmUSwmsNzRkh48AWHRYD2SbkwctZtsrLhVyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by DM4PR11MB7256.namprd11.prod.outlook.com (2603:10b6:8:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Mon, 19 May
 2025 18:46:03 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%6]) with mapi id 15.20.8746.029; Mon, 19 May 2025
 18:46:03 +0000
Message-ID: <16240db1-e85e-47e6-9adc-505a140a7efd@intel.com>
Date: Mon, 19 May 2025 11:46:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14.y] drm/xe/gsc: do not flush the GSC worker from the
 reset path
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
References: <20250514095358-3685068562756ee9@stable.kernel.org>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <20250514095358-3685068562756ee9@stable.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To PH7PR11MB7605.namprd11.prod.outlook.com
 (2603:10b6:510:277::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7605:EE_|DM4PR11MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: c4270f6b-4d94-4140-c4be-08dd9705682c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVN4aFVWNGdja29jVDRqNktBbFd1T1RCZ1drWnNFeTBGQkJwV3V0NlhjUldL?=
 =?utf-8?B?dlBUbjhjQmZMMDlYOXUvTWxhemowY0lqLzJUU0s0RzJzR09qN3Z1Z2RtZy9j?=
 =?utf-8?B?R3Z5UTFDWkozZDA5UG9Md01ERUpyVTFpa05ic1hyOUNtMXZNL0pYQWgwbEs0?=
 =?utf-8?B?Y3VOZ1NhNGRIT2NMVm85ZEYzSGxXaFdUQ0x6L2F4eUZhejJ3L1pya0ZuQ3BI?=
 =?utf-8?B?Qkt2YzEzQ3ZZUjRUOXFWMHhmbi9GSjAwQW85czU5blJ3VnMwSkx2aFNzck15?=
 =?utf-8?B?TE9lQit0N0IwRzE4cVRIL21zT0RRdkt2aGZrZGY5NDk5NExpODRuOHVCWDc5?=
 =?utf-8?B?dWVmWUYxWmIxSFl5QzhvN0lYalRCVElhc05UQjdSVFpCRkg4T2FVaWJzKzI5?=
 =?utf-8?B?SEU5ODNFVzRJTGRKcDl3ZDRlMHZFVnN1alk4cm9jWkszS0U3cTduR01Xc3Zo?=
 =?utf-8?B?dEFCTkNOUXZ2dkdTMWVuR1ZwaW1PSTRxTVhnWFVyaDNnVHEvaXhaUDJrN0FD?=
 =?utf-8?B?YXRlSitHMVBPbmFFRVhuZHdnREFVWXVhVFdpQ3RsdVo1ODBraHRkeVZXc2do?=
 =?utf-8?B?NjBkTkREU040Y1I2ajRVZ1dna2RYZS9lRHIvTG1EZ0tCSm1Xd3JMWHFUZTVi?=
 =?utf-8?B?T1dvWENwb0pNVkJqTldKUUtoMk4zTlRlYncrOGFJYnovSTdnNTVGbEcyZkFX?=
 =?utf-8?B?RzIzNTA0Y2FKUUhiTWhMRjdNSld2bXplZzg3UTR6RTNncFAwY3RoMmE2TmI0?=
 =?utf-8?B?QjIvTkNCN0ZvMmdiQTgxNUhaTU1GdElOalU2ajVqUDh3d08wakZ5dDlNMEll?=
 =?utf-8?B?cmVydWh0TEt5QjFQWVRGWUlWMlRKNUtHbmlmdlAxL1hWODlLK09iU2xaSDQ1?=
 =?utf-8?B?NzNIaGNzS3p1bXVFVWFkUGwzNDBkNDFFMmRYTWdMYVk0QTEvajN0ZzhIZkxy?=
 =?utf-8?B?YWpOV1hxdS9malpyOFBLN1d1dU0zaExaZGlwTlA0Yk0wTXhRaUtkMnY4WmJM?=
 =?utf-8?B?T0ZKTG16bCtKUVd2c0orcTVXTmZRb1h1VXpnRkw2TDh4SzEweGZSc0EyT0dG?=
 =?utf-8?B?ZXRkd2gvbFNDMWZDVVFUSjEzd0ZkUnh4eTNQblRTY2UwWGZ2bEQyeVBndzI0?=
 =?utf-8?B?c1h4UksrNTkwYnVQdG9sTTViY3FQb1hTZnVkaDIvVDM0cXFMVXZwazdjbS9m?=
 =?utf-8?B?U1ZacjNsSmRPMGloNHFNUTZvRnUyYzdnR0s0ZTJOdWtwVit2Y2F6RjkzeW9m?=
 =?utf-8?B?TWQvTWtkMWNsNVBJQmc4bEFBV0ZCYlhYeTZVMWtoenN3VzYwSldsWXN5cTJv?=
 =?utf-8?B?NjY3Z1NMejFJSDgreEQ4K0ZXalFaekl4dDJCNEwzY0puZWlsaENyb29PMm9P?=
 =?utf-8?B?NDYxRjNSV0Z0MHlBVUwwazA0UDZEQXUyUDcreVVGYjlDbUlWTnFIZWxnOVcx?=
 =?utf-8?B?cnUySWlhODFFRm5rS245SkVTQmZKbGIySG94YkZGQnZMNjNvWXZnRzd6akZl?=
 =?utf-8?B?Wk84THdKeGpDenl6aFdLU2FSS2RMSW0xczhFaGE0ZElIRGxIWVBIRGxOVE4x?=
 =?utf-8?B?MUtiWldyOVo3ZVo5MVlrRXJGQ2NUODNNcWV2Ykgzd3hweVRGV0NHcHE3UEtT?=
 =?utf-8?B?M2tFOHMzOGU2OWptYytycFBLK0xmOGF3c1N5ZmN3Z01kNWhrTFVUbGFRTHFp?=
 =?utf-8?B?SkJ1bFpiNFFMV0c3WWwvS1NCWG5md2hGK1ZIM29EU3FNdWtKeTZyQVIzZk5s?=
 =?utf-8?B?c21PRHZnY20rUE9mOWNTM1BZNVR5ZGZOSEZWQmlEWDlHMEdJaCtZeXFEQUph?=
 =?utf-8?B?aEtXeEJjNXFjRWZMYnNQNDhiWGdHMXFTZWdxWFpvWmdjTVdjb2tMcUMvNGR3?=
 =?utf-8?B?VjhidVZJY283bnpBVEpGY0ZWSlNhR0pvYkl6dzkvRnloM1JNbUR2ZGUvWkhR?=
 =?utf-8?Q?w/db/QQUgbg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Fod3k0U1dZTkxQaUMwM0lqSFpianhUdTdNUnFlWVNKV2tTbTNYVi9NWmxo?=
 =?utf-8?B?ek5ROVljRFlHb1RjLzQ2bmJ1N2c3TG9IM1lsV2k4Z2Y0aGNNY0c3N0R5emZJ?=
 =?utf-8?B?Tml0ZlU1ZVVaQ1dNamlIM0V4U3VzaitjN1JtOW5Ra3Q3WVplNDZ5S1lWTWNj?=
 =?utf-8?B?VWdMVjhxbHYzRkQzaHM5dlkvNFNhVkxvTEZKcy9iUEluaDJsZ3pGNFhqenk3?=
 =?utf-8?B?RWpRbWdiOWp1bmxJTlV3UWVqR1hQVkpCTG90ZDk2MncwS1l1VXhiWFhybUdi?=
 =?utf-8?B?ZTI2YnNORVRydFFwclUzOW51b0krTU9PTlNYbGM0a3pQL1o5NDNkRjFLODNM?=
 =?utf-8?B?amYramQxdUxOdjhFRFJvMmdUTWp3T0JNR0l1K2RKeHlyZDhDRnFtVHp6ZXpK?=
 =?utf-8?B?U01UK3RLMktVc1pjSWZyWHNuVjUxM2VuK0hLbGxFbDFYdTRqcnpYVW00eXpM?=
 =?utf-8?B?dzJnQVBtL2ZYbjhGYWNib2FnYVJmNE54SzB3RjJqOGpSRVMzWXVVWjhWZWxa?=
 =?utf-8?B?QkJzYVdZVlZXaEppZDZ4L2UvUmFHYWJHUFBuRHdGaENvbXJXZkpiNHhwZWZE?=
 =?utf-8?B?dkR0Q1JTeDV5cWEyZnZPa0pEZWhXOS9Hejl6RWJWSUtHWDBxeVRINDJwUHRP?=
 =?utf-8?B?WmtaN1lpOFVOdEhnM0hycXA0WTNRL2hDdTVXK3JrL215QmtKbmNuR3BlTG1Q?=
 =?utf-8?B?S3A1UVlML3VYZXp1MHJrVnhSbWxZY05NUm5CdlRBWmloaWFGZW9EZ0l0dmpm?=
 =?utf-8?B?djRMcHJpclVLcUFreUhtalhPKzQ2d1Y4MjFZRFNIbW02cHFTRGdZbkk0Qk1W?=
 =?utf-8?B?aE5Takt3S0hsaW96Zjl1Q2JKVTUxVG1EcWdlazhINXhkekxjb3R3cjIwVHQz?=
 =?utf-8?B?V3FNOWkyQm1TQ05xT1l1enhKR1plRCtqSXBrTTdxVHpEc085UTU1K2lQcGZH?=
 =?utf-8?B?eEZBdXdvOGJJTXhXY2FpUzF5OUN1VHRaczR5TUkvY1N0cHVJMmpEOW5kQU9C?=
 =?utf-8?B?STIxYWpvWHRhc2VNRS85aGxmU0xnM3B3NFQ5ZzhuNVMxRFFLVFJGQzlsd2lI?=
 =?utf-8?B?S3pjQ3V3ZFR3S0IyRlhlMm9rU0ZzREd6eGtjUE9RVU50R0c2a2VVd0ZCVklI?=
 =?utf-8?B?cEZTL0RlUXRkRGVPV3JFekVuQkpjQ1ZtcFR4bzVRRityZ29EMUxyMFlvR21B?=
 =?utf-8?B?QmpOSWx6bjM4V0dBNEpHT0gvMEoyV09NR2xxdnN4VkVqSjBEdTlrUEhUWG1q?=
 =?utf-8?B?WFR3cnhxdHBMYkJ0TGxlQkpvUksvaXVteitEckFLQ3lsRHEzZm1sOC9zcDda?=
 =?utf-8?B?RHF4Qk5lelpmSUF1YS9RbWJiaVQ3QmhaZER0QS9BSmFpSUZqU0phZTd4aW02?=
 =?utf-8?B?RUI5T081aXlKcXlQb3RlSWU4c010Qmo5NzNiekRidjVWUEd1cWdTeUJtelJH?=
 =?utf-8?B?UWpUZm9ZMExPQnFFRTIzbTV2ekdVOGtjN1NFaDlDME5ZZ2had1VBZHdJY0xs?=
 =?utf-8?B?WTY2Z3IvRyt6N2FOVTdaRU9pcTZJV3BITmcyQm1rcGdjdkpzZ1Nib2RuUVpw?=
 =?utf-8?B?SE8zR1ovbUlJK2JWLzJObW5nUCtqVmJ6M1p6ZTlVRzdKN2NqWVB4blRpRk4w?=
 =?utf-8?B?bnJwSUpKb2FML01RVWxRSTN4VmpOZWpXZ2dSM05Yc1d6T2YxNVEvb29RWWVL?=
 =?utf-8?B?cGs0VnFBbVg5cFZUQjUwQ05uUWFxZUxrN0phcWIxTlZMbkQ2dklseHcxWlJT?=
 =?utf-8?B?cUhteHFNSGwrZzF4UmlPSGR1VDBKRzI0SGhlSXR6UHRpbkNBTjJaa3VwNWQ4?=
 =?utf-8?B?dTdNTkYyRXB2dDVDN3ZQNDJySWhEaW1xS0hvSzl6MUhQaFcvelpHNTdMT29T?=
 =?utf-8?B?bWh0YjR3QVhRcnFSelVZYW5PcU1qQ1p4V2QvaU5YeklwZTdZN1c0Zy8yL2Rq?=
 =?utf-8?B?dGVidWlKLzVldVJOY2toajR3SzByYTNpcm12QWw1a1lBL1lvSHZLOGxvaW0w?=
 =?utf-8?B?NDVWa1FobFZDNjMwSmFGUkdZcXdRa3pzeHdneHY4OVNocW1CTFpZb0VxR2xo?=
 =?utf-8?B?Z3AvUFlNd1lIeG1xbzJEYVVyZjFNWFk3ZVVqS2F1cHpLOTlaczRERXlaeVNo?=
 =?utf-8?B?UXcvdzZnd1o0RytXZXg2eUswb0hyZ2xzcnY4UWdZelc5YmJGQ1doUHlqQURt?=
 =?utf-8?Q?sIRyYhdeJnmakI03JOoKXps=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4270f6b-4d94-4140-c4be-08dd9705682c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:46:03.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYm4Ppwkba20ffaXxLJwJ+YegaGMLgQteAh/BbZus0XLpYkrLQF157PAHo/BANJ95yPbGqsmljh35c6u5BOm52bL0hTImI5ozu3Jqk8vo8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7256
X-OriginatorOrg: intel.com

Hi,

On 5/14/2025 1:13 PM, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it

Not sure what the issue is here, the patch does have a "cherry picked 
from" line with the correct commit, as seen in the diff below. Do I need 
to add something else?

Thanks,
Daniele

>
> Found matching upstream commit: 03552d8ac0afcc080c339faa0b726e2c0e9361cb
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  03552d8ac0afc ! 1:  ec3abfe7a63b2 drm/xe/gsc: do not flush the GSC worker from the reset path
>      @@ Commit message
>           Link: https://lore.kernel.org/r/20250502155104.2201469-1-daniele.ceraolospurio@intel.com
>           (cherry picked from commit 12370bfcc4f0bdf70279ec5b570eb298963422b5)
>           Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>      +    (cherry picked from commit 03552d8ac0afcc080c339faa0b726e2c0e9361cb)
>       
>        ## drivers/gpu/drm/xe/xe_gsc.c ##
>      -@@ drivers/gpu/drm/xe/xe_gsc.c: void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc)
>      - 		flush_work(&gsc->work);
>      +@@ drivers/gpu/drm/xe/xe_gsc.c: void xe_gsc_remove(struct xe_gsc *gsc)
>      + 	xe_gsc_proxy_remove(gsc);
>        }
>        
>       +void xe_gsc_stop_prepare(struct xe_gsc *gsc)
>      @@ drivers/gpu/drm/xe/xe_gsc.h: struct xe_hw_engine;
>        void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc);
>       +void xe_gsc_stop_prepare(struct xe_gsc *gsc);
>        void xe_gsc_load_start(struct xe_gsc *gsc);
>      + void xe_gsc_remove(struct xe_gsc *gsc);
>        void xe_gsc_hwe_irq_handler(struct xe_hw_engine *hwe, u16 intr_vec);
>      -
>       
>        ## drivers/gpu/drm/xe/xe_gsc_proxy.c ##
>       @@ drivers/gpu/drm/xe/xe_gsc_proxy.c: bool xe_gsc_proxy_init_done(struct xe_gsc *gsc)
>      @@ drivers/gpu/drm/xe/xe_gsc_proxy.c: bool xe_gsc_proxy_init_done(struct xe_gsc *gs
>       
>        ## drivers/gpu/drm/xe/xe_gsc_proxy.h ##
>       @@ drivers/gpu/drm/xe/xe_gsc_proxy.h: struct xe_gsc;
>      -
>        int xe_gsc_proxy_init(struct xe_gsc *gsc);
>        bool xe_gsc_proxy_init_done(struct xe_gsc *gsc);
>      + void xe_gsc_proxy_remove(struct xe_gsc *gsc);
>       +int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc);
>        int xe_gsc_proxy_start(struct xe_gsc *gsc);
>        
>      @@ drivers/gpu/drm/xe/xe_uc.h: int xe_uc_reset_prepare(struct xe_uc *uc);
>       +void xe_uc_suspend_prepare(struct xe_uc *uc);
>        int xe_uc_suspend(struct xe_uc *uc);
>        int xe_uc_sanitize_reset(struct xe_uc *uc);
>      - void xe_uc_declare_wedged(struct xe_uc *uc);
>      + void xe_uc_remove(struct xe_uc *uc);
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.14.y       |  Success    |  Success   |


