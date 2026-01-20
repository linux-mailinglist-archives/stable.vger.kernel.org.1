Return-Path: <stable+bounces-210588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEfoAlfpb2m+UQAAu9opvQ
	(envelope-from <stable+bounces-210588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:45:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B021F4BB29
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F7308C0161
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9243D6667;
	Tue, 20 Jan 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMl/k37u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5B410D04
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934427; cv=fail; b=OeVhQBdqhBHGB4vZV1YgY4iHr4yCdycBgrUlQpYE2MrMim03m18Ff9oqA2ueXmgpSMu3Gmj/7+wPIBMlBL5K1L8Lxdr/L+dRtxTSsD0g8F0KaiMbVhrVUP+skv2BMImHOiI18wkEc6ea7srbQehbCFFDLhWV/ny/pdAelWmjYSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934427; c=relaxed/simple;
	bh=dE7W5bOou2xpNhRwCT/MqppN0e+UXgbTMsQJ54NrzIc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dDucsxyUkYbwckR5vninoNsqXLt2AaWjM4GrXlR1OHzcaa2Qbxhmv5/5JTNyH8AHCjM+2sLgN6AEFdB7zyruM6UXps3zRVLuC3PSycGUg8K5pdZ7w2kIcaNbVPQd2Aqh8nIiFViwwNii+QG75RgMjsSmpiIVowJWQwxh9CwK/mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMl/k37u; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768934426; x=1800470426;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dE7W5bOou2xpNhRwCT/MqppN0e+UXgbTMsQJ54NrzIc=;
  b=QMl/k37u8h9jmLcJ6Zb87iqq0b2ojSX6jPoyfslXQK0z1eoThHQCqy6S
   PrHkoLy+CroZBlqVsEJtkWAw6yJScX1jAx4TbZR6BXvDolr0hra8VUgQg
   n/dhlyMwdDDrA85c/J7IazIGHgK9gLcPDXz/kuzMNfz6u12csf2Ct6nGY
   hZEVEjLhElTDIAN2VMJM8xopNJARD1ccexJ+3KO1Z9MMVjaope1XK2eUO
   S1lnRwOnFdFZ4UvceC5BJQO4XuWZmbkT4JEOIXSN7z9HG3AB1zyad/0mm
   GTalXiz/eZ0j/HQskTgYfNTD9/YL/8k/ZR1s9hBkRH7Im8qLIqyC25Oh6
   Q==;
X-CSE-ConnectionGUID: rPoX/g9TRB29hez6mxWTcA==
X-CSE-MsgGUID: yj/RzK3GRIexd5bllIP1dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70244972"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70244972"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 10:40:25 -0800
X-CSE-ConnectionGUID: EHbOHBG9TPyaBudbBZRWVw==
X-CSE-MsgGUID: BgrO1MomT7eGCMGg1AGAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210654902"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 10:40:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 10:40:24 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 10:40:24 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 10:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKa5IwyyrtS/OIGq+PCd9V8NCFfTpZTa6Z+xp31HjzvuP6QAeplyasp1laQUmb7DRecLjqaJFXeMHlYIcSSoy1TgRI6iO41s2kOk335KG5WR9CpbDXkYUI4rp7TYYrq/eiDacpqPRvXmOcre/waJvP25NDZeToYKNOTSd1P8TjYk+bMmq/bYKwMeDf6qmiWFRrGePwGhCkf/ng47rXAwa5vfPVSBfNcdDA6swz9XoBv4ZvNHwSXtAs0lH6f5dWUUA4ljerVfoJR5lHOTQJmt/9WOaaaUsAa+77uqE2LUba37orX5VhGx2H/bXfHetloHlwVyYti6FpT8MXFN6/J6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmtCJJoHoog2GUFmt0+I0zPCjNTwONJfyVkSxgizf/Q=;
 b=jArlLMQVIJ1gb+tTeplfeZoVY3xCLjE5r4gJFR63/ZvJ0J4BWe+ulSJnLa5SOTMRIPtjCSvHjLjJXXYs+ZVxGwCY+EZPV9vsqHN7N0oxFv1z6YGuDiF3N/q6LUyTf4RAC+U+/elM+ve+4QDF821fDCrcdomsWMANT7Aq9GdLtO5O8bUJta4IsFndtT8bZ/Duww/fiJQK43yhEiuP/U3sziz+qjuokOieBzPeT7DMmbFwYLtU8+xrJl6rlt6+CJz0748cj9L9+wrCBu7HpL0WmTewRVUF5tmBwMADRNEad+6VpC/r7vNZn1Lpfm6u/jwTSgaUp8lVYKuXA1Y9KEm4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 18:40:21 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 18:40:20 +0000
Date: Tue, 20 Jan 2026 10:40:18 -0800
From: Matt Roper <matthew.d.roper@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <intel-xe@lists.freedesktop.org>, <kernel-dev@igalia.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
Message-ID: <20260120184018.GL458797@mdroper-desk1.amr.corp.intel.com>
References: <20260116095040.49335-1-tvrtko.ursulin@igalia.com>
 <20260116164624.GE458813@mdroper-desk1.amr.corp.intel.com>
 <69008123-6899-49e4-9a30-b1cbff279ee4@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69008123-6899-49e4-9a30-b1cbff279ee4@igalia.com>
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|LV8PR11MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: e518d3a8-f39b-4582-598b-08de58535d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pf02Aj60HHSUb3YRzMoV7TVdLGl6mUYu+T6hEAx5fAyjrPbkYx+19Pr3SW?=
 =?iso-8859-1?Q?6ef8GeBHaa/p08rWhxwbCKZkzX55MW8YmJDuaAkgj/xPtQXpx4NDg+2QAS?=
 =?iso-8859-1?Q?6mcM29oIRruZFt2B4lp2ikSb6E7teDan2sEKBg8fxzhF+b+HEDrVqS01XA?=
 =?iso-8859-1?Q?LwNUBpZ+IOioPcY/jbJLFRO78xvZV1vS3KGVq8Sx8VwntwRqojbA+feAvo?=
 =?iso-8859-1?Q?spLYJ3f0jnXT9oPu8ikl8IHs8KwSXH0v47a09i1RD2V5yzm/UyaOytmKZk?=
 =?iso-8859-1?Q?xmyPG+f0pnoJaEb7ishF4TcD6vnaG+ioWO7M7QXjFeH7Wr2o91NK8D6MBS?=
 =?iso-8859-1?Q?EZ+nQAtvqBRd/YWy9kmbUhqhSSEJtBweazECdYBEiENPdL6VkG0aYtxFU9?=
 =?iso-8859-1?Q?mKFAVQjXklu1kubFTpqptB0WKRxdLBizoCFGqNjVAuUpO3rx8ifDWAaKVd?=
 =?iso-8859-1?Q?P6pH5W0y2RpHJovFFvThIkZWMqczPoePBwQc00E1YmdZar00kku3D6MPuc?=
 =?iso-8859-1?Q?RLeJD+pQA7xRPgJXElJd+L89vlnGl3hBKNbBJsujsM5goweI3wiXV6yi2V?=
 =?iso-8859-1?Q?HPA+mT4LrW3uLRaEseVVogNd7Kell8bK055DxoXJvnm15UOXZAt3OtyY2H?=
 =?iso-8859-1?Q?XJpjmFp3aqwt99/nzeQRutRE0kZ4Sv5snbxrEiDclJ2G8H1qF8aDmfhUmK?=
 =?iso-8859-1?Q?kFXFD4PRsBdLuVIGLc7lOACA9Ud40MJNqgJgdbt61/GXclEm75eaS4IZ/j?=
 =?iso-8859-1?Q?LWKor6+48ffr+MKus+Ppb6JMdlYy/EJ4DQunWHkGJ2Y5ZD61CB7i52Oh/R?=
 =?iso-8859-1?Q?rJIqg82+SXKUQT0L/NglvEyUCrcrhwVqSRykH85H1N2xK6HyAVAjP5RBWx?=
 =?iso-8859-1?Q?aBEb8BUuwsMDmQUWe1Q/86ph65NGnNJwpoBOWpAJj78jOuymG+r/IJDKTw?=
 =?iso-8859-1?Q?B4EQ+RxpMq7XsoGIFqhHkUwYEugJZIpKV85S0Nbz0ajcuCZmC8haXIpDyU?=
 =?iso-8859-1?Q?yYCn2xZDwPDX6BKpi7jM1NVBe9mEj/Pusx5Ll8vYlqXdkkUr2wMEqb0dxI?=
 =?iso-8859-1?Q?+ZlsurAYxNX1hv+cBMdRNw59FNtDglFD3TbwJuA52VlNKTkQrPoWT4mNE5?=
 =?iso-8859-1?Q?xLRTvtq+rWHYaUZ2gxLhZh1AajzTTDyGlamWIcycM2jf0SL3aU0qbuZTU3?=
 =?iso-8859-1?Q?oF+5NJDIXBOmKOw1xr37qEhqP/Qg5JIYwMDGIxnUVE3hF7MOrbTnDaqz2g?=
 =?iso-8859-1?Q?uOyet2nsxdOnUZo3//8qFLJhoNA3MS1hbRk/Xj8B1LpR1udBetrgwkN4XR?=
 =?iso-8859-1?Q?VnJVe/hswUd6+zFh69pQi5HvjTVigZ5RCzAtTCa8HH/jykDCqFFfQ1She6?=
 =?iso-8859-1?Q?yzjbm27TW6A8/ot39u15cKmRCOfCPhGp+4PX5J4B1I07349AeOack5x3kZ?=
 =?iso-8859-1?Q?0OhRXGdrlIuYH7CADfPhMQsfJRWuEr5fTKQD97Z+gf45KDb8Bb+DjkyQQ2?=
 =?iso-8859-1?Q?4Q9uNlb436TEJW08EzYJStuDIKaDKfaZSb1epnBM15PJFs73XVaftkf1QC?=
 =?iso-8859-1?Q?GeeZN8kDF4hqNxv9YC1hQxI/x+Rw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8182.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mdScOqLNh37JXuNMoklZbdtjr6iA5Cx5xUkwpiOTIHWmN7tUsyO2AGFGip?=
 =?iso-8859-1?Q?6tFt876o0AUfLSaKlFsf37fB81J9d/PjDLd26kcresqOv4BHQ5TsdGkBsX?=
 =?iso-8859-1?Q?ELlwIgczQgZDPjJdj92LFgrCT3sadm4AsRraKKsn4X6BewQJFjJugyYb4Y?=
 =?iso-8859-1?Q?JJvIZE08A2X+dh+0HZzg6bXjKpt+8FdhbkMrpeafBpcC5SfqBkOs0YIx8J?=
 =?iso-8859-1?Q?I8hOMhBuwGwIDqLjjhFCLhvRiJCj9ckHguEHq9jXND5T99xCcAG68kQWow?=
 =?iso-8859-1?Q?ZUK+qFXW2LbvcggkmwHehhPGkf3O1XTM/71+RxjSfYs3bi4xf4UauU/TKi?=
 =?iso-8859-1?Q?RmkkLP/IFGqFxXWykb1OlEciyAYg/1dBp1T3jjiiEa16KR8lHzEN06VXgE?=
 =?iso-8859-1?Q?QQK1vvbfb/1VJfmP5xXqK+V7zI1KYmGKS26RntPGFBM1DDvaRFp3fBPG9p?=
 =?iso-8859-1?Q?f4kpvCFmOnBPMDTW8XpdNp/t2OtPtcEth+YAPc8yonKSYBLdQlUzB5kSa7?=
 =?iso-8859-1?Q?izyG/vlufQ/PK/gzxF0HALwFd2IPwCHWQGM3ZSyf6BKbmxShCitnHbm3Oy?=
 =?iso-8859-1?Q?JmqAkUHi8J7AkoIBYB68CAANyHntiDyvpqvUKMMEfT7Gjco8N96PRebAOd?=
 =?iso-8859-1?Q?+2tEOz0dd9bvIie7nvdRT+r4ICO8LPwhdSowmhfojtLeNFXwsDdVO/knqy?=
 =?iso-8859-1?Q?zdnQCgv2e1Y/Vsa5sqrWLu3CoyQ7L4Y+CQtjzsNDGrkUu3ZHAwkQFnlUoT?=
 =?iso-8859-1?Q?k4Ia9Bnrv2McV1uZaIAUl9T8JsmdEuw0LzaX9jsQmTiL6og00U6HYQayhx?=
 =?iso-8859-1?Q?vfi4ZT8FLd6MTGiWUUvPabRtVGTDY0yPv+Zdq1r1GrsFCjCtx4guOERna2?=
 =?iso-8859-1?Q?P1O8mbZpo7cJ8z7LDRrae47stOq7as91q0IEu7TH1NolerQirlvoF7smqJ?=
 =?iso-8859-1?Q?uDLhgWbW7EE/daRhrAvNIWpe/rQmywSCRzYbmLUgNkUT54MsWz7SoWUZCI?=
 =?iso-8859-1?Q?McgyUPns/8BeVjm100pVtJvCIJEx+ptB985eo37WIV7NmG9LERYdQfCeVs?=
 =?iso-8859-1?Q?lbmLYi7m59SwxoJN2AknkEnkeKIaFp7YB5JqrrCzWprmtdNK4tdpwO8gA1?=
 =?iso-8859-1?Q?58OBbjvzLOeLJ8A9r3+P3Y8Ero1efikoTLv+uY2hSP/C6VOSSAqOeOICAN?=
 =?iso-8859-1?Q?i24LZ19+LYV4cnh+wcBlDylu9N//Xw8TNPVd3hYeJkkPsQtN0nI5DuFqnV?=
 =?iso-8859-1?Q?zNMn++vvwQzIazecrXbm+0eUeBijQ34PEXK6MnfW5hPUQYf8oVRYnXWimF?=
 =?iso-8859-1?Q?0zBDbRVMNp61Rbz6meMtWiY9icg0bfbsweyOghsgoVSffDeMOOY86khWsk?=
 =?iso-8859-1?Q?ciuyl2fg1zmyJHQak6QJXJsnxELOmlH1+BZnjLz5OrBL79ctkQOEi75IUG?=
 =?iso-8859-1?Q?FXj+OoiDBKhpKC1cXzcUxLkaVLiiNH8QjKq6oHdMWAUog4sutRq4mMgpTL?=
 =?iso-8859-1?Q?OsZrLI4pXm8ozEoja5CUtXBVZxq5y5/PsWfYy1vcg5PYEvpaK59x13uiCP?=
 =?iso-8859-1?Q?ZroWIFkn46o1JKbua9ebWGcKJDxBcc3atNM7x1DknqyS3BLUVj/7phTIrg?=
 =?iso-8859-1?Q?mFvdnZmj61Q/Y8pnzPXbj/0rQsMk+bGK2vNaqXYQg/+lUZC8l3P/kUExa1?=
 =?iso-8859-1?Q?JEz+xUuiWMgoAP1X51iDSwartauOdDwW89rkmUw7xguedua70k9DtlR+cA?=
 =?iso-8859-1?Q?OkJUP8j3oJhG8kt5qeDxfGMU6nc17CEIHnYBQk2GY+pCpCYwXWvUgzaD1F?=
 =?iso-8859-1?Q?jc7xBPh5NDdSfibMCij0O/Lsgnrk8ck=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e518d3a8-f39b-4582-598b-08de58535d72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 18:40:20.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDVuK7zskQOPuwlSm9+h+4CeHNFjz3C5KytT0pW34ZJV1i+b9K6fPxahx8HfcPQwpTEYdXUR88juOlcKu9HHGGcT/aeYyWY0j/MuEPxa8OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210588-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,gitlab.freedesktop.org:url,intel.com:email,intel.com:dkim,igalia.com:email,mdroper-desk1.amr.corp.intel.com:mid];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.d.roper@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B021F4BB29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 01:34:02PM +0000, Tvrtko Ursulin wrote:
> 
> On 16/01/2026 16:46, Matt Roper wrote:
> > On Fri, Jan 16, 2026 at 09:50:40AM +0000, Tvrtko Ursulin wrote:
> > > It looks I mistyped CS_DEBUG_MODE2 as CS_DEBUG_MODE1 when adding the
> > > workaround. Fix it.
> > 
> > This matches the explanation of "option 1" for the workaround, but I'm
> > wondering if we want/need this workaround at all.  Option 1 is to write
> > the CS_DEBUG_MODE2 register (as you're doing here), but Option 2 is to
> > do a constant cache invalidation (PIPE_CONTROL[DW1][Bit3]) during
> > top-of-pipe invalidation and it looks like we already do that in general
> > in emit_pipe_invalidate(), so it seems like we're implementing both
> > options at the same time.  It looks like there's similar redundancy in
> > i915 as well...
> > 
> > Are you seeing the programming of the correct register here actually
> > change/fix anything?  If so, does just deleting the programming of the
> > wrong register without programming the right one also fix the issue?
> 
> So far the off-line reports from people doing the testing appear to suggest
> this fix indeed, well, fixes it.
> 
> If that is confirmed we will need to add:
> 
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/13630

I don't think we should mark an Xe change as fixing a general mesa
ticket since Xe is the wrong driver to be using on gen12 platforms. We'd
need an i915 fix instead for that (and i915 is already using the correct
CS_DEBUG_MODE2 register so I guess there must be some other factor
involved as well).

> 
> As to your wider conundrum - could it be that preemption is at play? When
> done from the indirect context the workaround will trigger after preemption,
> unlike when done from emit_pipe_invalidate(). So perhaps "Option 1" and
> "Option 2" you mention miss that angle?

Possibly.  I just read through the old internal history on this
workaround and it sounds like the expectation is that the underlying
issue this was originally added for would only happen when both RCS+POCS
(i.e., the POSH command streamer) are in use, which isn't something
that's relevant to Linux.  So most likely the problems you're stumbling
over some different issue than what Wa_18022495364 was initially
intended for, but it turns out that the register programming for Option
1 also solves this new issue, whereas Option 2 does not.

Anyway, your change to fix the register name is correct, so

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

> 
> Regards,
> 
> Tvrtko
> 
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
> > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.18+
> > > ---
> > >   drivers/gpu/drm/xe/xe_lrc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> > > index 70eae7d03a27..44f112df4eb2 100644
> > > --- a/drivers/gpu/drm/xe/xe_lrc.c
> > > +++ b/drivers/gpu/drm/xe/xe_lrc.c
> > > @@ -1200,7 +1200,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
> > >   		return -ENOSPC;
> > >   	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
> > > -	*cmd++ = CS_DEBUG_MODE1(0).addr;
> > > +	*cmd++ = CS_DEBUG_MODE2(0).addr;
> > >   	*cmd++ = _MASKED_BIT_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
> > >   	return cmd - batch;
> > > -- 
> > > 2.52.0
> > > 
> > 
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation

