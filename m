Return-Path: <stable+bounces-238487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAcNAX8w4ml22gAAu9opvQ
	(envelope-from <stable+bounces-238487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:07:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248741B6F4
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD4C3033538
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261F2264C0;
	Fri, 17 Apr 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPwQjLYe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB52AEE1;
	Fri, 17 Apr 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431147; cv=fail; b=Bkkv+MqXEC++R26R3nnv9Pqt+yj+ZLIXYTqVkwRWQO85UCR4dZJmb+tn/DCIdhvzGnJW3UvNz3lYVa4AFT+3pByWPMnPoZURHxnXAnPkkwn/vAv+r0fN17wXM8EiZHAtQU4MhDkrCHi0jTQHtz+wv6D616BHwNOLm4K/7MpaS6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431147; c=relaxed/simple;
	bh=oA71TmPT3XDeJxP8BJRrQp4ChSqL39Wq1DJ5moPiVjg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uDUX7rso+YJew9OmPE7w2EC906J81MkRIpC6AVloYnNrTLp+V7/NGlGH08xqMQiuYEhlHoPRS9/bXJr/1Y9Y22XLkDFg92XrtsTd0BS3Z73ZWvhSPnx/C3px2rISG+iU5a8WPcbs5w8BEvv4d7bYv7TJsqSOwvdITU99TlBDkPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPwQjLYe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776431145; x=1807967145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oA71TmPT3XDeJxP8BJRrQp4ChSqL39Wq1DJ5moPiVjg=;
  b=WPwQjLYezp4TzpLg5ej6bez2E+QDoWvMYsYOyqxIb3i0VLZqvnOFxhJ/
   sl/FxC4Fk5o96jr/owmiMsE+4ozcdtd4ASnSUi95msNfnASlsJWsjFg6X
   K1DqqlddY+s+OoxBu1ayyvaeU6TMNE8USwHCo0OX7LsIKF58yWl4b6qXr
   AcpS6LJ+5B3XBVJH/DNp5AiD/SB1WHC7MTddJd63Ylypq4y+YuYctY7e1
   OMPtyxZcZ+AlbKl3YkZV/suMO3b5GoCOmnoYj4umq/8xOfB0hUDfBq9Ej
   lVRoVwJaY9HeVznkTEv41IphaSdKIGTEoIxnJb7eCWMPHTqA9A4/3FPg4
   Q==;
X-CSE-ConnectionGUID: 6E0cWIR2RYO1Lcc3X7QIsg==
X-CSE-MsgGUID: mpEGS98cSwmeocJw8buejQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88825272"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="88825272"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 06:05:44 -0700
X-CSE-ConnectionGUID: FNvfQbYCTQS2D2CTohKsAw==
X-CSE-MsgGUID: GlAuquNAT429pagsBu9OQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="226687028"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 06:05:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 06:05:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 06:05:44 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 06:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P97H2+na3BtJKRmAesftqQm/I6AIRYnJY9fwYBOJrcWfFJ1YeqNs23GU7VvDORVn1SsSacdGoFCFJEVv8CeJ8IFF2gazP1sJ7H7hUdmDI4yOxmARzkAtMGBjCcpn3VSPuauGjjow+SQsD1xMd+JrDl4fXaOyeytaA+QCFInavzmABaqyuHKFZsNKE+YkX6aNn5/gTcG8rPQG3Je2xe0M1a8wJ7fPY7N9maaOhtNO+Yhc6YqmVF3ruGt3ECmamRy8+IrUIjMYvYRH8kmI8enGEip/lbFgOx9nstWXwj4vxMofUDFmJpHkEdPEwJTjXh2AQwdHyXyFADaNxaUwlcI7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvnTFIfBdBoVnlN4FglFdsa2S5DNGlFcxnxcgoxzUWI=;
 b=fNoxYXBBonHWD+YSsMZCl3l2wTYMq1n2N82gTPq03moTwhFcHpQt2YP3lbD+YTQWw5Jmof5LE7zYeIyhIMZYmts6ifX1JVvPvfgfgNWcaL8RLK4zNqjmDSbW19Eiy2S3pT0vlkCLwWPfgHg236RiLfI+qNAViFe2o8VY/g6qf07ypZSDJGTOahz1EmhUw/YE+zPjkmVlkHvXo7xI9wbV3BPrm0nDH27Q9LQKbthSgPTPZm4xdH5np/5FecoXdW5Pf3m9aSAayLtQNNtD7tRvuTXcbQEiqaYoUSr23MDm3u6W4GaFf8YVfE1hL80Sszx4GDNnCAeo6wLcHw5Ldrbz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:05:39 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 13:05:39 +0000
Message-ID: <d04d7827-f990-45ac-aadb-4079ab270159@intel.com>
Date: Fri, 17 Apr 2026 15:05:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/5] iavf: send MAC change request synchronously
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260414110006.124286-1-jtornosm@redhat.com>
 <20260414110006.124286-4-jtornosm@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260414110006.124286-4-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:8::17)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e41454-18c5-46bc-b309-08de9c8205f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TdWhbXmMoszHNHQzCh60iZDIzf6xUtYX3s4MOkZxeSjR6uLyjRyxlpjf7+S6pxPzHD92m7JWLkbRVsUewUQjvBtCCJexZ3Tk8Aumi383iKFFANDyym2rH0ihp55iPBUB3p+86bHY1hxIX55ltBqLpafz4aw62lbTf8slBB1mRSXpEjiVDnctM62Mj8kiJTZbLpgk3pAvNWPAnfpMNnC6BkQKB1tMfc3iI1Y6bKQneK3NyTVuLzsFdkcWPH3zG2RCM36tGqL0e8F5K2JB8juMA0BUlAx4Rn+v6Kj/0nL8Bdf0Z53fnrqgXeak6aQ4Nm379wDIICfijgYV1bNfmfiHK6BAbSwe0aKjdIHnXR7TRrpqd3N2z1SKP05gBPBT77Q6RMaZwHXiXALx/148JXE5ydiV+GtK0rSkFlv9yNtrZWpETYySZ5MBphxJadcHsmvxb4hHisEyRTQmbNbzs/DAqqtUV+K955eqN+CYG7UMdW0EWLOWyuH08P6lXop9Y72d9GDaihK89Uiut0YpKueDGDuzM/KKzBTgWJQbXz6e0r6rS4rwCCvCnPwo5n3cWvmwTlQ0jvoqzDFFcP+vDyprQbJIg+ZpmEnxTicZ8yDK6+s+Bs1BcGLQoKIeSEDAkMOU8CQieYxf/zfJEfzPzHBd4lQqEYFQuWbxIiHSMZ5PUknqbdHJ7a97uTXp3+USk7VXtNz8m0YNdP/YG5+7xarMvxotyiNmfCDDeeJQj/Vmmtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09TVmR1cloyelJNRy9BRzY2SDF1TDFkcUVVQ05YVk95SDlEZ3c3VWp1dDBF?=
 =?utf-8?B?QTJQNENYeHBBS3d2cWh6Vjh2VmNDZUFVVkw3Q3UwQ1Q3c25MeVN3ZXRobWEv?=
 =?utf-8?B?T1huR08vd1p3TnFvb1o2cHorVkNDdU92N3VwTkFHa3Q2ZVlKdzlDN0JJVDdU?=
 =?utf-8?B?T3hQNVpvVVpFbEZkWmwybXlmTjN5NldjY2JtbDY1NG5YMVRJTDFDM2ZmTFlW?=
 =?utf-8?B?RFdYSWQ5WEp3VFRDclkxWlU2Y3g4cFZsNkVBTG44UkxJVnUwK1RXSGdsT1k3?=
 =?utf-8?B?dVFwaEQ5Uk03bHpZMGRUTWpRb0lVVGdYRDNyQklJNExmOW5GZGV6cEsxWGdN?=
 =?utf-8?B?aDhSUTM4WEtCdXlLaEI3a21XZ3p1TnF1cGd4M0VvcXUwMW10aEpFSVlLNHha?=
 =?utf-8?B?enBVL3lZMjIxUXY3UFVqaWpvU1o3K0RadzR2YUdVOVNDL0JOYno2STV0cXZo?=
 =?utf-8?B?UUNpQXMxVWZZM3BPc0dmYkRjT3kvMVVmOUdRd0thbUdDbndhRXE1a3dNYnZR?=
 =?utf-8?B?c2kvbzkzQXVWakVhVjZHTTRRQnEvb1d2YWkrd0NUMkF1TE9GdVFLai9ZWnkw?=
 =?utf-8?B?QzlmcWZXM21vdUFLWi9ZYUdqN08xUHVQL3gwYTIyWWVjdDB2VCtpL3hLNnc5?=
 =?utf-8?B?SE43NUxrd2RGeHdIN0o2RXpwb3BSb1hpNEpCYU84Wk5naFZoc0swbnZZNGNQ?=
 =?utf-8?B?M3NQRnFFZnNWWlBDTzdWN2txV0tFWFZUdTJ0QnNvYTlrQUJETWp4T1c3SFlQ?=
 =?utf-8?B?VUtyU01qUnlZcDRkdUNLZzluRFJkOG9tejZsYm1KU015WnhDaFRFUUQvczRP?=
 =?utf-8?B?ai9TVUtkWW9Tbk4yOUwwKy8wTnRYM0hXQ1drY3FYWFQ1TzlSNXl5WTB6Z2w2?=
 =?utf-8?B?Q3gwUkM2UFJqeEcyeHpsS0MxbUp1NkFMZWtQbDdOQnU5TDNDK2hZNlFvbnBX?=
 =?utf-8?B?eDNsRTFic2VNelVpbnB1Syt1eTNFaDdrYlcvbFpDc0NVaHI3cVlQVkgzajg3?=
 =?utf-8?B?YUNPQ1NvakkyTzRTUFVPUVRFWkM0NTdIbURnUXZZWEx3bDR4UHg2aWZ1Q2dB?=
 =?utf-8?B?RTFNZ2dvZG1JSGNUTm1QSGJnelp1UEZZT3lMWE5YWGgvQ0tEdVBSdVk1S242?=
 =?utf-8?B?SE9GN0xPLzc1MHJ6am9qS1ZSRFI2aW85Z1dpalpia2xaYklOazl6WU9wZmxl?=
 =?utf-8?B?ZmZBK3dOVlhjMW5RTUU2WWQwY0hMemZSbkdmU09Ba0dRakI5b0JJUDZweXBT?=
 =?utf-8?B?OHJBZ0svR1FxN0hRVGlmN0M0aFBoVjVlV0hGSTUwUEhSRzZYZWcwMnNtYzk4?=
 =?utf-8?B?Y2RSaVoyQWtJSUVrMXkrTjh3M2E4TWlISGRVWTlxNDdiWTZDWjExSHEvNzBl?=
 =?utf-8?B?SDBOTGhBc1l3UmZGVmxoT1NjNkpiU1VrWGl1d1JyK0hsbEhiWnpFTVUxYUNt?=
 =?utf-8?B?VzE4K1BsOU5SZU0rZktKR3pUODd2UU4zNjgydUVwWEQ4emp3bnpob29mR0dE?=
 =?utf-8?B?RU9GU3NEZlB2RTBINGVhK3NaZ05RNzhjZFFMeFZpaDgrREFsZjV2b3AvM0N3?=
 =?utf-8?B?R0YwRTNGbTI0QVE0aktJZUVZQnhRL0VtT1pyWjJDMnNFM1ZkT2M3RGRETUxF?=
 =?utf-8?B?YmI3TTZqbzFRdWtxUzN0YzdoV0pjK3BjeWI4M3ZoWVRoYUpNNy9nNVpVSnIw?=
 =?utf-8?B?N1V5YU90Ykk2cEdPOWNUelZRNERiRklZcllWalQrVFBMSW5sRFg2KzB6aHNS?=
 =?utf-8?B?Q0tlWFpTNDlMMlBEVGYwaXFVNy9mSjF4V1pqVkpkVi9QUG1vcXJnd3d6NXVU?=
 =?utf-8?B?UEozVGp1NnJxcTFGVTdmaitUUU8xQ2I2eGdFTzN5L1NqRjZNcUpReFNOSjdv?=
 =?utf-8?B?UEc4ZkpnL0IrTk1ZODdRaG1rNGhveWo0THQxSk8xdGNRNkhDU0tFVmpsazB0?=
 =?utf-8?B?MkZaK09rQXJlT1Ava0xYUDJ1Yy96WkdNQ0ZDcktDajVRY0srQ0JDdFFNdldV?=
 =?utf-8?B?VEtLWjNSNzIwbFJvT1MrREozU3hnRFNsWXVRbXl0QTZ2c0lrM0U3OEFLTS92?=
 =?utf-8?B?K0pzbCt2WlZvU2RyYlRwZGYrVWttSWtuSUhQQndwZ1NxNDQ0bnZ0Z1NPdDBN?=
 =?utf-8?B?WVBobEt4ZGRKc3lDUGJ3UzVYc2pFdmlkb0JoRnZIVEhTQU1pRk5lRStSY0lH?=
 =?utf-8?B?cWNyTmVIcWFqZzhHdW9UejRLSGZMd2liVDM0TSsvbG9Mb0llVW5neVJCN3Aw?=
 =?utf-8?B?TnNJNjUzb1JENmdmRXFkZTY5T2pTMGh1TGN0UWx3OUgvU0ZobDBzemlEbmYr?=
 =?utf-8?B?eEJaTDJmZXI3Y0xieWZ0eVk4elVQS2VBd2RLWHJZRnlDWUk1cS9RQmdSd1h4?=
 =?utf-8?Q?cgpro8xysDEvX1u0=3D?=
X-Exchange-RoutingPolicyChecked: t1y0IrBmsz4c9bgwAUS1GTTJBw/Jdj8IfHMT1ksXaQwkSAjeVJUbutiTEWmZ+0QQKhVr6icBL/5hKv7fxEmgmi25lusIaaN+be3YWSN9uN1lMQsDTd3HYZoBk2LwNLBLdd6L84VrW/bU12mye/pV7DJbViJwCEN6W584dcRkqhysckXSWmV5MJhkVg+fgqLMT1WwcZS1rYsUYSFaBieNedEytOxkHA8p9H5dqbDNG+0h5/Xpym+Yp87+QIB5Pcu/KnB9UWioMKtlBFIOuo85V7Fgg+RSRT1istsIw3lBz2i/K0Bt+AG/OBXyF7CtU2F/n+NxKfnAUbxKylcv97uqNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e41454-18c5-46bc-b309-08de9c8205f8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:05:39.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sk5vstQtSPyQAH+srgDKS3WT6mnE5mxHZQrmsKjRKMy/bOaqm1UjIbij38WYFHBzq/rtZA3ngNMQHZP5qklt4CHAeClEujtJLh04mkIFgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238487-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8248741B6F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[-Jesse]

Thank you very much for working on this!
I see that we are going in good direction.
Please find some feedback inline.

> @@ -1067,26 +1107,13 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>   		return -EADDRNOTAVAIL;
>   
>   	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>   	if (ret)
>   		return ret;
>   
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,

this was the only waiter on this waitqueue, please remove it entriely

> -					       iavf_is_mac_set_handled(netdev, addr->sa_data),
> -					       msecs_to_jiffies(2500));
> -
> -	/* If ret < 0 then it means wait was interrupted.
> -	 * If ret == 0 then it means we got a timeout.
> -	 * else it means we got response for set MAC from PF,
> -	 * check if netdev MAC was updated to requested MAC,
> -	 * if yes then set MAC succeeded otherwise it failed return -EACCES
> -	 */
> -	if (ret < 0)
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret)
>   		return ret;
>   
> -	if (!ret)
> -		return -EAGAIN;
> -
>   	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
>   		return -EACCES;
>   

[..]

> +/**
> + * iavf_virtchnl_done - Check if virtchnl operation completed
> + * @adapter: board private structure
> + * @condition: optional callback for custom completion check
> + *   (takes priority)
> + * @cond_data: context data for callback
> + * @v_opcode: virtchnl opcode value we're waiting for if no condition
> + *   configured (typically VIRTCHNL_OP_UNKNOWN), if condition not used
> + *
> + * Checks completion status. Callback takes priority if provided. Otherwise
> + * waits for current_op to reach v_opcode (typically VIRTCHNL_OP_UNKNOWN
> + * after completion).
> + *
> + * Return: true if operation completed
> + */
> +static inline bool iavf_virtchnl_done(struct iavf_adapter *adapter,
> +				      bool (*condition)(struct iavf_adapter *, const void *),
> +				      const void *cond_data,
> +				      enum virtchnl_ops v_opcode)
> +{
> +	if (condition)
> +		return condition(adapter, cond_data);
> +
> +	return adapter->current_op == v_opcode;
> +}

after seeing this and patch 5, I think that the changes to combine the
two polling functions together are too big for "a preparation for fix"
type of change - so I agree with others that this should be scoped out
off this series

that stands for iavf_virtchnl_done() too - there is no caller that wants
"some opcode" in patches 1-4

and it will be possible to just pass "wanted_opcode" as the current 
param "const void *" of condition()

> +
> +/**
> + * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response
> + * @adapter: board private structure
> + * @condition: optional callback to check if desired response received
> + *   (takes priority)
> + * @cond_data: context data passed to condition callback
> + * @v_opcode: virtchnl opcode value to wait for if no condition configured
> + *   (typically VIRTCHNL_OP_UNKNOWN), if condition, not used
> + * @timeout_ms: maximum time to wait in milliseconds
> + *
> + * Polls admin queue and processes all messages until condition returns true
> + * or timeout expires. If condition is NULL, waits for current_op to become
> + * v_opcode (typically VIRTCHNL_OP_UNKNOWN after operation completes).
> + * Caller must hold netdev_lock. This can sleep for up to timeout_ms while
> + * polling hardware.
> + *
> + * Return: 0 on success (condition met), -EAGAIN on timeout or error
> + */
> +int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
> +				bool (*condition)(struct iavf_adapter *, const void *),

please add v_op from below as a param

nit: I would also name the params instead of using plain types, not sure
how easy it will be for kdoc... (so no pressure for that)

> +				const void *cond_data,
> +				enum virtchnl_ops v_opcode,
> +				unsigned int timeout_ms)
> +{
> +	struct iavf_hw *hw = &adapter->hw;
> +	struct iavf_arq_event_info event;
> +	enum virtchnl_ops v_op;
> +	enum iavf_status v_ret;
> +	unsigned long timeout;
> +	u16 pending;
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf)
> +		return -ENOMEM;
> +
> +	timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	do {
> +		if (iavf_virtchnl_done(adapter, condition, cond_data, v_opcode)) {
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		ret = iavf_clean_arq_element(hw, &event, &pending);
> +		if (!ret) {
> +			v_op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);

comment about condition() signature:
I believe that condition() should take this @v_op

sidenote for patch5:
...@v_op instead of looking at adapter->current_op

> +			v_ret = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
> +
> +			iavf_virtchnl_completion(adapter, v_op, v_ret,
> +						 event.msg_buf, event.msg_len);
> +
> +			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
> +
> +			if (pending)
> +				continue;

please incorporate the condition() check with iavf_clean_arq_element()
response (to avoid processing all subsequent VC messages if condition()
was met already)

it's fine to pass 0 as "v_op" to condition() when there is no VC msg yet

> +		}
> +
> +		usleep_range(50, 75);
> +	} while (time_before(jiffies, timeout));
> +
> +	if (iavf_virtchnl_done(adapter, condition, cond_data, v_opcode))
> +		ret = 0;
> +	else
> +		ret = -EAGAIN;

please change into just one call to condition(), and don't sleep between
the call and time_before() check (that will resolve my v2 concern)

> +
> +out:
> +	kfree(event.msg_buf);
> +	return ret;
> +}


