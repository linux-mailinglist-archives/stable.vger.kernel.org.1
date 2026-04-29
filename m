Return-Path: <stable+bounces-241880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFP3FC0B8mmElwEAu9opvQ
	(envelope-from <stable+bounces-241880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:01:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1900149466E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B1AC3060C5F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE33FB069;
	Wed, 29 Apr 2026 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lj7Ny5/g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0A396B7F;
	Wed, 29 Apr 2026 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467201; cv=fail; b=N98VN6nQqVs0m9RhE9Tvs0C3Rq/7DacXKet58eato+dK1FdKPlPVyu/jwqQXRt2xx0HweJSZaOQ5uUGkLlBh2XRLpPTGt5U3MBIslk79BopFUNdILXti2Ti/cc34JyBX13rYRFdaEtHHO4S4gKIhyyXB6psnw+1F2Pxm4ZZqroQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467201; c=relaxed/simple;
	bh=Qa3aZ8rbvlm8dZZk02gZwbHwdHp5BAqayr7YEgtK1ds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S1pAsW0CF2gyqckK2fz85yI18zOlWf7iaqt6gZ0T5LvtjNnu5OQbHDis3zBfB4A6C8FrftJ/othuwlaeGciWEnItWLpI4GkMAtgZZgckSI+neJihiQc9VC4gwcuRuu5KSchdJf9Ci2rzDQGBi0DgOdEwN47896phDypDY3Hfows=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lj7Ny5/g; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777467201; x=1809003201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qa3aZ8rbvlm8dZZk02gZwbHwdHp5BAqayr7YEgtK1ds=;
  b=Lj7Ny5/gWiqbkWwlXkgNF3j+0OvGVlmbCkh3Zvvv2NWvTvxfF5mkP0qD
   cYnkxEh7OlFrpM7Amu+rDiEZzy/jFYpxKwobZQ81rBSW6iXaUCgnrXfMj
   YFK8Rn3Y66kfaeUGEKTWfu80y0faMgxnO4BiKM3fL2WQ0S0kbx5ZV8thE
   O4Oj/iNescvpApwUk6Xnm/pMzYsw4eLGoVtjKQOesYq3horDXaSKsx30Y
   sPJLTG4oOpn70efST/2IbQ+Tr/vq/Q2BWzQ2O8cG0wXOvJrd5s/JpRE3Q
   NgdgLuHUtLEQiePGjYQrAEfBosWxxfyQ0VOoTYr7KkQJDcV2ljLnGpsPf
   g==;
X-CSE-ConnectionGUID: UjGtOKQCQEq3ZZ9UYj7GbA==
X-CSE-MsgGUID: BW+SyxHmS6+3F/XhOTADGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82000649"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="82000649"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:53:20 -0700
X-CSE-ConnectionGUID: UvZiRB94T+qmmdCkHw6kvg==
X-CSE-MsgGUID: xnsaQElWSA6JlHNs2f1EtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="227751568"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:53:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 05:53:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 05:53:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 05:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd/vCNGogqzEVVd89/R5cF/yfYubfNRo9HWIZ12Vd1+/6tIyYKbcvj5EBxG5oNXbm+uyR9QETnuO1BzPaMKIfzuny3jGsj/LLfSuUk7DJ+qZdAZ4Hc+9jDaCMz0aw/cCf9P1+AixoAfZ3UgZ3Tfa5hCzy9yW7kacVaV/DSFuNi3OZ8Igf0U+wGqN66K0mTB3gYhmgK2CCmLeJrMU16g8HQqsXcO1mUxw5SKo/tNIabrRLg3x3jxlE88XZ+I2La6AUsSVGxf82Duu358v0FxE6RZ7E52xnbHwIRlpOt2RXyrfManfSs4I2bbCOtJR8B0yMQXBjafksQIH5XDSYLy6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnjBKOOuN+auyUmJPh3yy2NJy8kAv43auy7IVIu6xp4=;
 b=TUdoZwVBYcw4ap2GayLBpfKvL+dEElsQyNFFPP3erWk8bQqFiIZwEVDWYaR7wNhMIVq8+qgAdktyshIKpghKP0ecFUbaKD/qAqgeBt0byQ+yYLYgrxKHbjUrNDOEM9B+R1dr0ojp/AXPn/7q7iovmd/HpM67YhHwJFX0wO03hOpmHKWdFBJO/hjp4sqISGOqC6+elJ9yNif7CB9lM8qyDxaqAp1tyHE0faZUC93TpNb7PXpuv6iQgA2cI7KsKpOldjI7Qi/UKdQDcGbl7ccZAsJnRCzQJhUaG9kNtuF+xQ0o7+rHV6jaESGWPvJcrF0RMDoLRoET+c+ifi4ZKWlKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 12:53:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 12:53:15 +0000
Message-ID: <28fa50ea-1296-4cc0-b414-cb128e65b632@intel.com>
Date: Wed, 29 Apr 2026 14:53:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/4] iavf: send MAC change request synchronously
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <aleksandr.loktionov@intel.com>,
	<jacob.e.keller@intel.com>, <horms@kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <stable@vger.kernel.org>
References: <20260429102426.210750-1-jtornosm@redhat.com>
 <20260429102426.210750-4-jtornosm@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260429102426.210750-4-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:803:14::41) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CYXPR11MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c33e018-b700-448a-0b0a-08dea5ee472d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZMNUEAHcTFxutWsD3EHMoHGJ+UW+CFuu43/I9OaYrE8F5SvreBho5YdbQFSrCp03vT7KPM4GJjRvom5ycoFvz3pNT2s2425VDGc/KMzAGPHijSNLt4lcKSb84DpdXyYwU1ZA1jopcc4jz/rPR1P5tY5x7/CVhbOtsuszf7nlvo7+Gr1LPVmorgmKntsf8CDTZvhlSijLK3kVMAb75jujO2ykseZA/5FXKAF1B1Wy+RZL/mY9J10/nDTfwK9PH1SyiKcnFvJdMAWGu34bgmOW/8v+GCSbj+oxio+xxoDQ2tz30kXYZejxalpH0aWnGApNQK2yMjeW13NPlQy+cPLYh0h17lXj0MXVZ6gITJIZg4x5Y939lxyQcvczgW+tI9eifoi/LZ44m4gtYgep/WkdbHWMX/JAcLjwZGfiMH+XaGLAwwmge1+9tk5v1/xnQ3dfJl8cfEq9J6l2bFfCJwpxOjAqIRlmcHP/lo1CvePsnUBkmmFUoZ8NU1PeZSPgze/qx2LpSoUp1BnJoUei5EJW9CBF/3quyd97TUUwS6tevXVmgB9RDjTWXsqWMNnnG5thtlPOeHucV9dDH6uSzoj+RLX4ei2+xqioAmGXUb5Z0a7WFRBBtgUUlbGhoOBEnlFhUSd7atXwg5b2Jo4c5ufozqZ7PkUQFzrWmElLFL0EFLB8p2JaK/BiFWUDegcQ8KbTGpCY4aF8ym6AnqLjWW8L9zk+A6Bs0AwCNuvGeSiqihk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmM1emR4NEdJVmZDeXpVTkN1bkJWQXVGamJSMHVMRmRSYVExVzZDYXYvUlNI?=
 =?utf-8?B?OWI1akFsTGRoR1BGVFkvQ1lxWW9EWnJuV09OdlVDUUFGVnlKMDdQMWdhVmNV?=
 =?utf-8?B?c0pDamFEdDR0NGE5Unl4a0xKeE5oaXIvWm9ELysyc2Z1NUhPOEVEazFhNkk5?=
 =?utf-8?B?NUF1aEY0MmJqbmUvdXJhZW43ek4xc1ltaXE5K1gzMGU4OVNNZTZucCthbGpP?=
 =?utf-8?B?TzhaWnNmV241THV1Tk5ZdmZHZEJlYk9qeTJlcTlKNzczby9DM0dHT1lSSmJy?=
 =?utf-8?B?UlUwZ0hsb2hEMkdQZWgyUWY1VSs2UjFOUktKTDhOV25VcEsrdFZjcG1YSG9l?=
 =?utf-8?B?cWgwYjE4N1cwNlVTNHJ1K0V0WHFEOVliSWtMMk9SY2JIK0tKbGV1Tyt5U0xC?=
 =?utf-8?B?Sit2NmQ2RFcvQXV0bm16Sy8wVVJtRFNIZ2NsbXBSYVljV2FlakRPYUIrbkdQ?=
 =?utf-8?B?OU9lUHJGTURKMFRoTFhLa3JjdVlMc3oreFBUWHV2NUdkQVVoVnRkdlU4czBn?=
 =?utf-8?B?SGlpSXkzcDZLMnRuL0E4SFF0NXVWNGJUMnJBOUd1Y1YvbWFEYWwyRHV1Vi94?=
 =?utf-8?B?eTk4K1pFMXRGaWhPY3hDMENodEoxV1RJYlkxN0x4RVJzYTNqUGU3dEFEem1L?=
 =?utf-8?B?N2JDa1IySGJHek5pb0J1TFVRNHV0WWxQNnd1ZXcyK1ZOWjF3MzZMR1ZXaEwy?=
 =?utf-8?B?M3h5ZlNRWnhiTmJZLzhvaGlnV3B1RjIzOGwrcHo5UWhaMXNUTnlMZTBwMzli?=
 =?utf-8?B?NGxUOVF5cFZzaDBFdE5YWllTZnhvQTNVWUl1Nkpnc3JkbUx5dFJBREprOWEz?=
 =?utf-8?B?b3k3dWlEZzF3Nk5ud2x5TVc2NmxXL1dWdTArbTlPWkd5cUwrbHVaZ2VqWGJH?=
 =?utf-8?B?bnJWUFFPZXNpSEhldk5wdFVYOW9mSmkyUUhWUnZ5czVRMFh2eTZyem9UenVN?=
 =?utf-8?B?V3BFZEFWUk93aTNPMUM0RW9VdGtIb05lYzlZZGJVT0U2Q2piaHF0MGJmT1Mr?=
 =?utf-8?B?TC9SalpZSUYyODlQcDRKL2FlQkZuRDNJRmdqL3B2YnBKdER3Y1NZZXJUOFF2?=
 =?utf-8?B?allrWW5PZUhtdWZxK1lTUi81WjgvOTNESW4wRGd2UFB6V2hKR3dwa1VCVkRD?=
 =?utf-8?B?Tk9DcE54OG9kbElQc0FLWDUwNURqa1lpM1BiMy9qdnM3WDExZkFiWU1xS1Vn?=
 =?utf-8?B?bEtxZjF6Yy9uSU50TFBsL2o2dGMyZFk4VVhydnBOODNpZ1dDRXNRU09Temhk?=
 =?utf-8?B?bm9SeEVzU2NVYTR2K0RUSmhPQ1lTM0w5ZC81MVRhUzdxeVBaOFJKRk51V1BB?=
 =?utf-8?B?c0ZoMFFTRU9iTDRTMFBLemZKTFhXc0h5amlMbTdvTUYzYXFvVnhHSEFKWHdu?=
 =?utf-8?B?VVFxcGo4ZWU4SVNLZEZGeG1hTEJvUkhGRm1BR3kxek1PZnV5M0pYYVVuZUdD?=
 =?utf-8?B?ZnhZQlA5Q0dsa29jMWpRbE8rVEJkZzR6RTUxOURTd0RNc2Q4bmtNK3lnWE8x?=
 =?utf-8?B?VWwzbXpaWEdDdXE5OFRMVnlUZWdNci84ZkxvYjllRk1xQlR3d0FpMDYycVVF?=
 =?utf-8?B?c1dmVDFTOGZQbjBzRk5kRnhzUzVRU21iNk04dUNIdWppMlBIT0YxUENycklt?=
 =?utf-8?B?cnFHT2JSc0JkL3dmelFrNGxsRDFyU0QyNFo5TURNYjFRaUlFU1BXc1ZRM0Vz?=
 =?utf-8?B?RGNyMDN5Tm1KYkJWbnNEYXJaclp6WWVCZWRSRWUxN09UV3EvbGhMV1k1a0pK?=
 =?utf-8?B?RHIvTCs0UGtXc3ZuMHVlNXdHSUpZQmlzbEJnMElWYjZvcldtUmVVUmdZTTkx?=
 =?utf-8?B?emVaUjlNbWxwa1FEdTNWVVdXU0xld3lOVWQxWFQ4SmZuOHJkdjV6dFZWeWVl?=
 =?utf-8?B?UjJ0U0FUYXZkSXZ3Y1hJY0lZeUxBVkttWDJUZWI4RlVOQXMvYzR0MWhSTWgr?=
 =?utf-8?B?UllOSlpXc2RQR3lqOVpob3BkZnVYbjdvRGlORWFUNDhySGk5MFhCeVBIdlIr?=
 =?utf-8?B?c09rQWZFSEpESXhrZkN0RHNOUzdKSjB2emJpS2Y2aTZXYkovN2E5cFhGRWJZ?=
 =?utf-8?B?TXNwL1d4SlpTRXFXZ1FqTFFGTlI4VXBjSE9lOHpCNTR3anBLWk1yaUtwSW56?=
 =?utf-8?B?MjVOV2dPRVk0a1N1ZWNUaWdKZStlSXZra2d0OUd1MTlUWE96czdWSWhCdExI?=
 =?utf-8?B?MVplUDVUVUpzZE5RdUZaaUNCL3RCdnNlVGJwVm5HSGlLTEtMNGRxTEgzdWtT?=
 =?utf-8?B?K3ZZTXVVZTYySEJJdFhueHVkaStLbWswelZ4UVd3OVN1TWpvdURPRHZLRExS?=
 =?utf-8?B?YWNEQzFrZ0tVUUZhK09nMjRxbC9GajkrV3JTM3lTek1LbTN4UU9abVJBVkN1?=
 =?utf-8?Q?2XVeuzkjfCMrGcnE=3D?=
X-Exchange-RoutingPolicyChecked: Ko68GY3g2eDpifo2n+LPs63x+6NCfGwrZ2s2NTvnwlucxoULv78SDXqXLbADyz8XOMqrvscMniVqeFPplf2TxtlrrZm3fIvRH/qGGz5Z3ljKWrNvIuJMGWAb48PMGy2R6PxaYIUindVjUKyUNgL9tqn+s9hoQDImzJKYuV3swmA/VpM00s7jGG1TPBUmJ5F3HbIiwQimnpDmCYRy6Sodhq9P+w58Y81k1Egm5Bd+K7XXV0H0YILm6kCRX729yuF2DjZ9eAFTO2BVAIijpzk1FwOyKXjdK43jfvm/02Z+aOoKDERW2FAXwFqcDH11fXFvfK56athtqYJAic4R3GrD8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c33e018-b700-448a-0b0a-08dea5ee472d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:53:15.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N39wBBNTKOLqMFKmbYq9DENTMjRtLeU7nEQuqn40wlBMeFQGNuSEFTDgtcJnkQzdDLQ5WK33gXH8iLXWclAt7oR+ZFAnAhwGeqYvuC7pKOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8754
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1900149466E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241880-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[intel.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[przemyslaw.kitszel.intel.com:query timed out,jtornosm.redhat.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/29/26 12:24, Jose Ignacio Tornos Martinez wrote:
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), iavf_set_mac() is called with the netdev instance lock
> already held.
> 
> The function queues a MAC address change request via
> iavf_replace_primary_mac() and then waits for completion. However, in
> the current flow, the actual virtchnl message is sent by the watchdog
> task, which also needs to acquire the netdev lock to run. Additionally,
> the adminq_task which processes virtchnl responses also needs the netdev
> lock.
> 
> This creates a deadlock scenario:
> 1. iavf_set_mac() holds netdev lock and waits for MAC change
> 2. Watchdog needs netdev lock to send the request -> blocked
> 3. Even if request is sent, adminq_task needs netdev lock to process
>     PF response -> blocked
> 4. MAC change times out after 2.5 seconds
> 5. iavf_set_mac() returns -EAGAIN
> 
> This particularly affects VFs during bonding setup when multiple VFs are
> enslaved in quick succession.
> 
> Fix by implementing a synchronous MAC change operation similar to the
> approach used in commit fdadbf6e84c4 ("iavf: fix incorrect reset handling
> in callbacks").
> 
> The solution:
> 1. Send the virtchnl ADD_ETH_ADDR message directly (not via watchdog)
> 2. Poll the admin queue hardware directly for responses
> 3. Process all received messages (including non-MAC messages)
> 4. Return when MAC change completes or times out
> 
> A new generic function iavf_poll_virtchnl_response() is introduced that
> can be reused for any future synchronous virtchnl operations. It takes a
> callback to check completion, allowing flexible condition checking.
> 
> This allows the operation to complete synchronously while holding
> netdev_lock, without relying on watchdog or adminq_task. The function
> can sleep for up to 2.5 seconds polling hardware, but this is acceptable
> since netdev_lock is per-device and only serializes operations on the
> same interface.
> 
> To support this, change iavf_add_ether_addrs() to return an error code
> instead of void, allowing callers to detect failures. Additionally,
> export iavf_mac_add_reject() to enable proper rollback on local failures
> (timeouts, send errors) - PF rejections are already handled automatically
> by iavf_virtchnl_completion().
> 
> Remove vc_waitqueue entirely because iavf_set_mac was the only waiter on
> this waitqueue and after the changes it is not needed.
> 
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


thank you very much!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

