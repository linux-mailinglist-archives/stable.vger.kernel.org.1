Return-Path: <stable+bounces-244575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OObOA5ih/Gn2SAAAu9opvQ
	(envelope-from <stable+bounces-244575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:28:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90F4EA2C0
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D19A13012D71
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A736A008;
	Thu,  7 May 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyX3TdcS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693F3EDAAD
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164114; cv=fail; b=uF6b/9hw+0aAsm/p5EJdWZlq9aWNZW38GUuFaSfIVY9g53QVO9TlnwmG7/1X7WYYuTifk6/6WNoatrcbIY/WHs1DevrSew69QnWtd9oU2bt+fwbOmyw8IFtlWa/fARshlcSaX6q9Jjfj+OH8qi6OiSqDyM3JaZQAAXmI1XjPQHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164114; c=relaxed/simple;
	bh=eHBPUVytVQU4RWs49eUUH4BHgHKcLgUFRuG8PC+SOAU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o31tfl4im4BuliC7ZUFFqGkWtwI4+UYjCMwUS1nKs02PBFKCCAriIHQsXh9HO1ADu2T/Ih7fT2Ja6r54TFIPFLmmIhc+L4OUG2nkYeJAYA8SwyhXvaYyatvEjHMUBSNdQ6hUY7WopBr3e4jYAv8cmpZu7vskEGE76fwPAGexmnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyX3TdcS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778164113; x=1809700113;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eHBPUVytVQU4RWs49eUUH4BHgHKcLgUFRuG8PC+SOAU=;
  b=lyX3TdcS/KPJhoiKcTORPSs1jCv7YXC9YruTCVD7gUD683Pu1CU3cXtx
   giBRRubezAOWfgvUmFmfvDn7JVo/Gm+LK4KW7yUXo5whbiFehpO3Y/JIZ
   31Wg5PppFS3ML64//H6CbnhurjKEp+i39eEZQaH0UQ6qYk0aZfy6C8hu9
   p1xIQuiZA98Zq9y2ECSk29NwMTYlBxXDT5aRLg4rUsy8b2RUv2Sq0h41q
   EsLHkN+cLlCMyn0vWVEPssqf+pHrOIGMSpfA1fH3jnG7kGgJyuQ9J7aOV
   vjOJGWOBt8jlsWvX7lxtsTtq2jnnhYLuQYNVBcjua2UYgMXIXpdvoZGmV
   Q==;
X-CSE-ConnectionGUID: WDWJBqnLR8i0oBT8pEvkhQ==
X-CSE-MsgGUID: 8wokzuxgRIWxKDX3TfcrJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81684844"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="81684844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:28:32 -0700
X-CSE-ConnectionGUID: vAKk/4eaQF2Q7L1m5xUAxQ==
X-CSE-MsgGUID: A+agSAKlSiKm07V0nQOlZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="236739030"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:28:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 07:28:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 07:28:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 07:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRUa6T9/QuoW8b/dI/s/DQyOGaSt6DfAN5wThPjEfx/vatZWx8/LhHagNNNdQjxBci809g8NOlvf37jOp1cS0Y2uJ5PmD8IxDsqVG3M5wv2sFi4KOJn2mKTxZxVrvifCle5y4nzn/PFqUdFsa3MmlE5ibC12Sd1ROkMSnRcElltnhh2Uzq2FfEhINECAOwSShPuMdGfRQ5TK406jFI97j87Bcc6x1Q4cpGytbQlYA61fIMRo4OkwRLCAhAoUtLQo3UUfFfv0LCuEYEo3nsO5DtwpyAEuUhX9WG40zywWGoO7afM3NWyF9kDfrW77xlrQccAmz/ZTZgD/yauEgcG8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKkIypq3TlKPdRJCAJuLrFtLLR/G6mRLh8AK7TPMR3E=;
 b=S0x/r6lk0OSrX/HhtiThYxEJdOAwTofzXLCDcH8lCSwKiKf653s3e+QGZvyS7BcUGJJEvogz/DHmJ0EejpU+geFmdZP2NaqrJSOpbgerCZ/v+KMpS9/mKkZO0KhLkSGzeAGOAS+w3mqEAgODP+g1ERq3BDPFfQiVSkZBXhorTSHVRkR2PAZpmYPv7zEI96ofTaVxjRVSF2aKLFp7isNH0Kz+KZGN3+rCveGns/CLxzkEYye0/FxhF6+I6EzaWZP3VflDiaveXeqeR6OTa5GqrlBlWMhNjE4098IjiIJ1wONEYtAQrhTpdDAbVJZ63O6jJu2P39A83AaXU8mjHhIkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:28:28 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 14:28:28 +0000
Date: Thu, 7 May 2026 07:28:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Ramesh Adhikari <adhikari.resume@gmail.com>,
	<intel-xe@lists.freedesktop.org>, <rodrigo.vivi@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Add bounds check for num_binds to prevent
 memory exhaustion
Message-ID: <afyhiigGVX3skCfF@gsse-cloud1.jf.intel.com>
References: <20260507055352.61017-1-adhikari.resume@gmail.com>
 <8bad8080780f3a1c2c45cc1385322edf09284414.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bad8080780f3a1c2c45cc1385322edf09284414.camel@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: ea19994b-b408-49c7-73b5-08deac44e7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PhJIoUVj2vKXzqbgrIw/7fyI2/4lOj/yfjW7g1cTgYY3MSFMHierbQHXeIadw5+MWmOebAsJCDSVbiDw/zL46glYD/PHcIrE05IXT+PdbJoZWyICBkQDCN/Q31JVs7V16BZk0rSB0nRAzLMJrcdhdGU0+F2rDa+7VIYwOSZ+1c+uq3ah5PxjGztHuGnxKrsMFMgE75GwJ5/oEc1fH2IxkAjfBomrjNTcUP91VEOJ/fv3TNE/isSGcM1pvcxirU9wvcRFAU+s1naypVUfePzVL7z7YIvAWKti1y8JVontNmkRzZ4Bo3wqB/UQc8ZKaWWExJ528qK5xSTd6rd6YY15WpZlZuhbRulPdDaAtoHplbi4riDSBZYyRN5RIpDGMgJNffsGvCmtlOlwXlU39wIm0PLVwvAHalo0zS9HBLPDFbYeVPp/BkV6pJxDK4Nur6pkiuZ3zx8bEBMbsmLfaA9ulwByNwmOunf8WEoLKliGcLPgyhpEBMFhy18Ux+Zd8HfJNWAGUI7lD1k5J0V54t9Zm6O6eiZ9dN5MaE2iLSDU4axc1ckj+raHEiaU9nmBBL8XSmUpHAxIl+6bZnPlDHcynvv4omYxHiLDmAQfaJQiH9wyWUOcmhfVEmZ80OdPL7E1cmDxltuiYpnqwynTVxx7jgZDPDgfCwTP5U9o1dIma16wyz5H5edpDC8F0vxlX3Tu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GcbVStC6b/Bt0oHU+66m1KZKWLKoEId4uLM/BMuGqMg3KUY2JkIUJpYHm/?=
 =?iso-8859-1?Q?gGO5eJpsUo37uGJ+ZjFITmgkkYdryU52gPE1glvF5HQZQMFADVEllNeLWH?=
 =?iso-8859-1?Q?/nqgpUyhdy+2rRsc7fYcehr0TgnvD4KSylQ5472mRLf8QUV40XGE2VWJS5?=
 =?iso-8859-1?Q?JOlwPcI46QB3M6sGRvJRXLgKqrZyibgVGVZXcz5TK/+4UciHePbbMhaY8P?=
 =?iso-8859-1?Q?U8HkW3VZH63aBV0qVC295t6NDuQeZU9FKGvwnIU7XXDyYHoRl/yr49/M8F?=
 =?iso-8859-1?Q?Z4sceust2m+ymxlbPKlr7upAUTpp3n8lMrY3++Fsfd+Faw9PvEsRO5n78K?=
 =?iso-8859-1?Q?495tvfHhLaSYI2PL4faMkdkBVUIW0m0qS2y+3jlQnXc+6RXfykd0Q0FlMN?=
 =?iso-8859-1?Q?JaE4iSZ9f/NLCKd8KdL5Kp2K5I78Za7xt6KVIxtmqJwVGne+Hv1zixHrCa?=
 =?iso-8859-1?Q?MhY+aOoyi/4TZqkFR6hRt7csS4xeRdofBnsVk2yLIssXylqzZgdzC9hNMX?=
 =?iso-8859-1?Q?xjtH6UczH7GDRA1/TteaUBDIbRLvDTdPsAAkk7S4bCCIec3/NnpN/iGQiL?=
 =?iso-8859-1?Q?A4GbgQzMAfDBfT/HLQlN4sgo/BXZhVaUxgC9pnimWE2w8KxsNIEMRwde3f?=
 =?iso-8859-1?Q?6oIEc3U6bVfw88L6OYAOjbx1zHq16nVKAKEBjhHvq+sqZ8sjk8IU+w6fHz?=
 =?iso-8859-1?Q?EC04v7WX8p7WaJHpWR2sxgHzfuMoL4CTvEvIRk9fWN2Xr0H7fbpyfOevdc?=
 =?iso-8859-1?Q?HF+hnxq7Oj/jDMy5gxLGPTWisPBNSWPbVc649bxqwwf0uvkC6mj2l4d1k9?=
 =?iso-8859-1?Q?jpU6MOvR7n4FfHKUI1fRYvxo4P89uoZFLVlVpmlG1f4irmzEljE7dG/4nu?=
 =?iso-8859-1?Q?0yoTkR4y/JQLIIMe5z4trPs6GtAynxIESUWEYS8sXcq6I/pLj1UzIPWURZ?=
 =?iso-8859-1?Q?Knjz8nbUFJVOUGVVoj2ezSR0awS5CB82fUMGql3SnlEVKlj63zMgQRz/ut?=
 =?iso-8859-1?Q?cnfOLT5EozX+1mEqvD+P6jxHmDWhL5e0vNsJiZwTYHdHpRJIz0GGQt+1KT?=
 =?iso-8859-1?Q?YWz+Fb9lbdGGSnhUkYcHyeYN3ME01aF2nOGiNUED5UR1n9w1Vkcfrj6bK9?=
 =?iso-8859-1?Q?TRfvq8vejOz+nDeCgqAaZNKtWfY1O2LRRc+BzD3Jc9KEEYV4176PVAtOt1?=
 =?iso-8859-1?Q?JWmJn8B7ynxZ9PyeODnyKO2Lk6X4NtBisFg4oYZ82GrdAfDT3jTp/LdP5A?=
 =?iso-8859-1?Q?hk9k77RJEO8ZOJO8AIdvrX072E8yzba/z/VIbJ39rAndlUt7/tz2BfvY1b?=
 =?iso-8859-1?Q?vVEZbplwC6yJiHJlCbg/NznP4ybHFyYhTmmBNdf2PtKwHXPavzIzeZy/Gt?=
 =?iso-8859-1?Q?lNZ+KO7TN81+xmSyAWn/JLB/LMtX5epxKLpUBjAHQpbCfgl3QdylY7aoZ8?=
 =?iso-8859-1?Q?XQnNx4dNeGAL2C/LquKqjC/cbGwuDw0TFhuJksRecAQT6q7I0PD/tuUAX9?=
 =?iso-8859-1?Q?q3C92QAZWgmq0p6d/kIa1EHriOuPf9AZnCAWP6L4LzEkkn5rAkkuhzYEJR?=
 =?iso-8859-1?Q?xnZK4EQq7loSOV0SXc8B9rGT0BiobZX2iUPWvbIVYohJbbmmp6X2N9F3Z4?=
 =?iso-8859-1?Q?hSO2QRVhtdGN1vzz/7VTwqpQ/lflKvO/i9bmRVNT5HjP9kdswa1B9u/M7C?=
 =?iso-8859-1?Q?5qNZ5Ql9a/MwnqqIsgKqaiKylascpFcvGnkb1l9ydhEoZEssFwnL+vSdb8?=
 =?iso-8859-1?Q?M1QHhOvMv6ynGuLoKxMdRDvyDHqY30dgGuoKUb/TMlYD+9QUbUItEzk3Oh?=
 =?iso-8859-1?Q?Fymw0TxelzKLinFi+bYXO+eSL6gRfds=3D?=
X-Exchange-RoutingPolicyChecked: gJYnhwHZlaCkOHzW6g+y9c+cD4loWNp1PjeforDBRiI/N0ntAUv/fQWYS0Ey6GEPsNk49F4baNwypDkQ2UodVq2Vbkb9JeJ31QPEUTYZ3Gm2xwMUDAQ762eyrS0SyElY6ccueo6ZgpexDQGMMgZ0KD+W9uFZyiiUSCYlMN4DU13/79c0sLuQj593+tXIClgAjvLlyGqxvpKeU+nZaD0rcL/1NLa2ekVnV4k7yU+il9s7Grj9Zgs3npGDg+KDB+NJQZO10RKMZs09CNVteJiRzq4iRtOwc7wsQbmtuQ3rGc7mq/+35wmNImpriabID078mLci+P1R6avGgMofsja55g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea19994b-b408-49c7-73b5-08deac44e7f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:28:28.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BqfxSYTYpSIQdMQaYJaz9UlvdP2rYwEUozLv78VbG1Hcr1eHfb0yuAaWFKDCWYtmjxs5ahUainI3UOVGPnotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BC90F4EA2C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244575-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:47:07AM +0200, Thomas Hellström wrote:
> On Thu, 2026-05-07 at 11:23 +0530, Ramesh Adhikari wrote:
> > The xe_vm_bind_ioctl function accepts user-controlled num_binds
> > without
> > bounds checking, allowing arbitrarily large memory allocations. This
> > follows the same vulnerability pattern that was fixed for num_syncs
> > in
> > commit 8e461304009d ("drm/xe: Limit num_syncs to prevent huge
> > allocations").
> > 
> > Add DRM_XE_MAX_BINDS (2048) limit and validate num_binds before
> > allocation.
> > 
> > v2: Increased limit from 1024 to 2048 based on Mesa source analysis:
> >     - Mesa's maximum usage: 960 binds (conformance test dEQP-VK)
> >     - Confirmed by Intel Mesa developer in commit ba6bbdc
> 
> Please use the standard way of referring to commits.
> 
> This is the maximum usage in the conformance suite. That commit does
> not mention maximum usage for applications in the wild, for which we
> can't have any regressions. 
> 

I still think 1k, 2k to artifically too low. The Vk interface for array
of binds doesn't have a limit nor do sync interface either. In case of
sync I believe we found a typical max usage of of something like 10 but
set artifical limit to 1k just be paranoid. I'd up the limit beyond 1k
or 2k to prevent seemly valid use cases from forcing a split fallback in
user space. Even if each individual bind maps to 4k internal (usually
this just a handfull of bytes for the PTE writes) - 2k binds would 8M of
temporary memory. Ofc we can increase this future but I really don't see
the downside of starting with something larger now.

Matt

> 
> >     - 2048 provides 2.13x safety margin while limiting allocation to
> > 64KB
> >     - Prevents unbounded allocation (attacker could send 268M binds =
> > 18.8GB)
> 
> Referring to my previous email, it actually looks like most if not all
> allocations in this path use __GFP_ACCOUNT | __GFP_RETRY_MAYFAIL |
> __GFP_NOWARN, Did you actually verify that a malicious bind
> significantly can exceed the cgroup limits?
> 
> 
> > 
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: Ramesh <adhikari.resume@gmail.com>
> > ---
> >  drivers/gpu/drm/xe/xe_vm.c | 5 +++++
> >  include/uapi/drm/xe_drm.h  | 1 +
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index a717a2b8dea..1ff66874f43 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -3841,6 +3841,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *file)
> >  		return -EINVAL;
> >  
> >  	err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
> > +
> > +	if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS)) {
> > +		err = -EINVAL;
> 
> If we end up concluding that this is indeed needed, we should return 
> -ENOBUFS here to trigger a graceful retry.
> 
> Thanks,
> Thomas
> 
> 
> > +		goto put_vm;
> > +	}
> >  	if (err)
> >  		goto put_vm;
> >  
> > diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> > index ae2fda23ce7..e666b73c81d 100644
> > --- a/include/uapi/drm/xe_drm.h
> > +++ b/include/uapi/drm/xe_drm.h
> > @@ -1606,6 +1606,7 @@ struct drm_xe_exec {
> >  	__u32 exec_queue_id;
> >  
> >  #define DRM_XE_MAX_SYNCS 1024
> > +#define DRM_XE_MAX_BINDS 2048
> >  	/** @num_syncs: Amount of struct drm_xe_sync in array. */
> >  	__u32 num_syncs;
> >  

