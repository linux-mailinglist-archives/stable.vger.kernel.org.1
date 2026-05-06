Return-Path: <stable+bounces-244450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMXrNVKq+2myewMAu9opvQ
	(envelope-from <stable+bounces-244450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:53:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4B4E06E2
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 22:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BB05300C0EC
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF83B19BC;
	Wed,  6 May 2026 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBc+4Fe8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB33B2FD4;
	Wed,  6 May 2026 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100806; cv=fail; b=ojL5hAQZNiZEjSgFhU8xb1ZN9WgNNuA8OwTBoQRp7LOhGSoWfwR2sWO6utwyrKzpLElM5szFBl3kILyXIxOA9Pg1/8VdiL4mJb7jTGCxfBKKLrrCcGWHy2zucp/bkLOpBpzxnur8zJ3cv0P1zM/BTwthamCqzPsb//SmpWfIzMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100806; c=relaxed/simple;
	bh=MthdYdwy+YrLQuzIC3Er8SAaGEa3JZjvYG6MaUac4GA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HOlrujumx32XcRko+jE7ryeabjPP8/c9WpE1Q7k8Gld22b71WTJlR2W+D+8Yp38mR7EsLqcdmaOp8RoC1/SRZfzZYiJT0l6IxSoMZe4WFnNNi0Bfc2o6yQIhbd9U70fawiPN/wmE2glQVH5LlFUzobJwCwYoHdAZOFCiqf8PApg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBc+4Fe8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778100805; x=1809636805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MthdYdwy+YrLQuzIC3Er8SAaGEa3JZjvYG6MaUac4GA=;
  b=CBc+4Fe8BJadt90zbciUqvuaR3e6RlW3oyKlt8gW0KWepsSyCJh513QX
   zV1YKk2FyVktPTbyALyon+u3StnXLBtiZre/15nQOxKqnh7GhyhiXG+w9
   AttOsf3z6zSpSOTyl2Z+XtMvRnpVmQoX3cYOV0eF/irrfLEBbygLezfp4
   HEy1z/ad+Vj6nRiHVp/drF05QodGlB7b/QIiluuk0kyQNFE85BWPzQQCI
   bwjnHPdgOdm0oDq0Zzqbeq22CyxKZ+2OkM4pznZubkk10V7eyiZMM1obg
   m+paxScHgZPfSj+5VAR9Ssr1Wxq4QAabZMOggvvif5unyry99rpPxdLJp
   A==;
X-CSE-ConnectionGUID: P03CNJfBQ7Kye2gOaeWz2A==
X-CSE-MsgGUID: wHgPo8MWTlOjxHs3gaG3Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78937151"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78937151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:53:24 -0700
X-CSE-ConnectionGUID: /w5rcOr+SoSld6bv5++Rrw==
X-CSE-MsgGUID: GQIraOHoQC6V3kn8SWtsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="231724288"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:53:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:53:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 13:53:23 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 13:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWPnlBxVFhcjgN+P16D1cX/73HfKZHeWw4w12j5IfxY8nRRCknS7y0DEu5/Bb5YhGvnOYglc8PsSGdisdRxhnxiNeejxAg/Qz635xapKT1II6zm6rKiFAUqhFSRp2IDkVGs4ecW1UeOTNbHjHItsIX19O1uJjIbHmFyLnmHmEyPnEsBz88fslvt8Foxry/a8Nb7BzrUCSTJxco//UWS44xjvo5wu9jh+80+PEM6oidV3/ID5qEngFY5xwH1ZiApahF3D6kzI/nDfk+pv0vLpjNVFoNGECoxHrHcReU2s6C92r7B+hkgoerWZDVH9BTWnnCNXUOvgaOlmbNT1xfhygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbC9GL8iRYNBykOLBEB10iVfcswymMvTXWlkD6nJdbk=;
 b=gzjAdYGLFhZVgJjgUgBUf9ISijTIxfxDsQAvf7lo9XUIkiwkVXriXWZw8UQEO4NwA//m/H6nUx6N/9n1Pr1/kxj1hoiJUG8Cf00cxly6QryJopxkxdOr7kCfzjE2c850DHyFECcbIMdSIemdvPL9gdqihrtg4+py5pc1aE5ht3BfC2EerkjowwCi3wCGeCb/8USo/mo3aMCa2ZJaHrTHWjCMGYHiUEelXrcPvHpNw5bBfja5LIl0cuTmKLuKKgFzAcS5QmDXT9TbcwUqKxoeA/uSeo4VyZiXVZgQBua2UZGa/HLVZ5kMw7v8ApfYr7iVL0joaPzGCSZLx3Yf4ygxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:53:17 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:53:17 +0000
Message-ID: <329453de-c300-441e-934c-cef7682fd55a@intel.com>
Date: Wed, 6 May 2026 13:53:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/13] i40e: keep q_vectors array in sync with channel
 count changes
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Willem de Bruijn <willemb@google.com>,
	Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: <netdev@vger.kernel.org>, <stable@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Sunitha Mekala <sunithax.d.mekala@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
 <20260504-jk-iwl-net-2026-05-04-v1-3-a222a88bd962@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-3-a222a88bd962@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 88324340-1296-48fb-86d4-08deabb17f32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: KGxuk18akhg/IK9amfeI38ZFTNcWrDSxidaRPS+H6aaqr4GdjmbgsIg0/yfcysDB3VRVUBO71z8lX7pLY3pTNfs60Mt/EjWXxm5y5KJN1RIk47SFT6zl8trdjygMDa4RMVkfygDdZC5ge945kGKNN3fUucRESqPcSZ8L5M3tOlh1ICOySL/Pz0xW4eC/OxutdfKtI+oUwnjLv9bv3jkvHlDfuHu+A33/+5+1ik7u/kk10/+8mEyocayaLa7xGdQHFHqRzhIWO7IIWobozL1yjRY2otyHk/QrdOWdbqDa98o7pyvXncdg5ArJOqd5gvfposjIbPA1nF/hcpPhSRwSVVw6s025U979s9CTO65O0Mppb/oiEEJbjZz/6TvAAc9tDfbTT5FnMBAuI2QhuVLVxu2rIynK64sEYMdBJYXby8EbNfM3hZnDeFSQQrZxegkxHWiTKsFdaTGi74+AsFrVkHvG1ATZ7PuQiSPoO3gvuQz4Kgr75ZC2i8p/KNGcn9kRhh6AWWUqm48KftuQDDaohahldChnGtO0odPJLSE9wLSGJoanrVB8WNSfcUDjyunzhNqEG3n6v43EOWlkVVvC+5D22LaJaB73ykG6C6oNvXIuYObml5AK4iVDB8DgbOT4IItjLVUk5wrmt1KiiMoigoNlXJUKsyBtXfEZYQ3Mgd/LTBr3jD/trY2PqraNFqnbRM/JtjJegcr3nfNbI9XSqJxbab2RWPF5GWdtJ67Q2f1VhJTEw5KjQkKTbxf1Kra8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZySXdxeHp0TGVXa1NDZjVKVkhVSkhnSUZNTjhYc2pjTGxNNXMrVkVFTzE4?=
 =?utf-8?B?S1NyZGl1MkVTRndlY2NVWUpHWUkvdVFwRXNIQzJ6MDA0SFF4dTBaYU5GbmVB?=
 =?utf-8?B?OEdBdzZVRS9abElSWDZuck5JTFMvNlpoTC9CUDhQUmhNMitsdjRzRndydHZ0?=
 =?utf-8?B?YmR1RUdIU2ZmOTNtT1BMSEp6SDNzZnRPN1gyY0ZPMSttbVZPUFAwRXhzNkVr?=
 =?utf-8?B?NU5LTU0reTRpMDZ0alV6cGJGaFBCZ0prRSszOXZyblJSQzYrM3luc05DRDFZ?=
 =?utf-8?B?ZytaUmFLTkpub0hjb1Y3SzViamlDUFgxWVVNcnFCdk9uSUdhNXd4cjd4SXpV?=
 =?utf-8?B?bmV0MGR4VHlKNkU2blI5VjRaR2VQOS9uOFdNcGx6ZU93bkliLzFlQ3pYcXlm?=
 =?utf-8?B?cDBvWlVmbi80RkdkM1dPU0RTY2YwSTVnMnk0NjdaN1o3ZllXY1prd2VMZmJM?=
 =?utf-8?B?SkYxeFZuL1pMOUZkTWQvVjFsem1SMFJEQ1hLS0E1T2l1VHZIYy9XcTJnNTh6?=
 =?utf-8?B?aG9ZTUZVRzJhREIwUzFUN09lbkE3TlhxTzcyekRFeGhrMHpGQlhYeHBFT1Ns?=
 =?utf-8?B?VVBCN0JYNDV3TjRsUTNSQnB3L1pHM3B3bUxxVmxIbERadlVlVzNobUllT0VE?=
 =?utf-8?B?YUF5Y1h3cU8vdU9nblloZUpKZW92TndmWnN5R1NYMkV6eFFJUVlUM2dqRFhL?=
 =?utf-8?B?d1IrVVVIVFJUQzlOVlhNNml2cjVJb0tETHptTmpzcVpkZDBPWGh0NHBSREIw?=
 =?utf-8?B?VW5Jcm1qNkdXZDRRaG92b0Y1OWw0N1hVdUlaZWNyUWw4bE0yMEY2cXZJQlhu?=
 =?utf-8?B?NndlT2NjUmw1QTNHSFRjRGhZemEyOHkvSWN5YVVLYnJJWDN5UlVNQUF6RDJ5?=
 =?utf-8?B?NkdmK3BlbGl4QmttbzFSNXM3ZzBRaGhlYURIS1NQRTlqY1h2ejFlZlI4UEh6?=
 =?utf-8?B?YURtNVYrVnBuN0cyZ1RLb2M1SkJzZHFpN1h3bzBoNFBlSndWZHR4TXZETFRt?=
 =?utf-8?B?cUJpRW1KSWQrZHJRQTZjTm1FYzBBQVV5bit6bWpId3R3c1JjYnBSUmVTU0Ns?=
 =?utf-8?B?cEswd3BMRHp4QnhOYzBMYzAxTVhXS1FabSt6MTBnVi9MclQ3RmQ3VERQcUxP?=
 =?utf-8?B?U25sTzRXdTNXWllmRGhMQmx6QlFBZXl3djJqY0J1UFJPVGU3elEvM2RuZmMy?=
 =?utf-8?B?eXRTT0lqYndTUWo0ZlNBeTBWVnRobjN4djh5ZFh3UEI2T0d6VzdGdWRuWnVE?=
 =?utf-8?B?a05HclRxWXJqUnJNTE1leUloL1RlYUY1MENvS1oxYnVsZmJMWFVSYm1EeFVi?=
 =?utf-8?B?T3gyRjV4UmJHbUgxSktLTytGVWhyK3hVOGY2VEFtN2hGQmlxczlmSlowWW9N?=
 =?utf-8?B?aFNTRlFxQnJybHdhWHJlWExsckp4cmJWSlk2LzgrS1U2VU5MeFpXenJkU05X?=
 =?utf-8?B?ZkFCR3A4cXdwRkpVNkVyRUVVT3U0K0xBY3VQQi95NTNyY1IzZDVyQ1BFQTB1?=
 =?utf-8?B?YU0xUFFwdHdUUC9NQXJ4Y3NDUm9FTUp1WUJhWWc4OU5HaDY3c0N0a2Z6T0pC?=
 =?utf-8?B?SE5raWZadzRtTGk2ZjVsYUVCOVcvV2ZDRDRPNVNaLzJIQ1J4eFZsaXlLS1hy?=
 =?utf-8?B?SldlQUJhdUdVOVZjYjJobC9hK21sR0J5TUNRSEpCY24vU3EzRFhMWFhmK2Ew?=
 =?utf-8?B?R0E5Q2xmTnpyR1hHYUt6MWFBSUVzbHNUQ1IrL0E2OTlqSEZhblFTeHh1Nnpp?=
 =?utf-8?B?WDZWcGRTc1RxaklRWk5rTXJQdWpVaG9qTmh2YkNKK2ZmejAzeWYwOGVrdDhm?=
 =?utf-8?B?TURXR3pWOXFleGJ1YVBiUjIzRHdyb2k1ZVJTNG5DaXVTbysySjB3bzJtM0E1?=
 =?utf-8?B?dXYzbkozc1FubFJIYTllV1BTa0xsUkdmUVdiTlh2OWVwZHFaTVBFSXE2UUxo?=
 =?utf-8?B?SG9TM3FqczVRYXdITGludmRURjJnM1phK241Vmt4ODJ6U2toVUs1R1pYNnY2?=
 =?utf-8?B?YklHeEMzYjU2WWlLYnB1V0RTc0xWdzdKMXQyckZ3eFlwMkpmQkpNSU4xTVM3?=
 =?utf-8?B?cXhoTEJQOEtYTzN3L0swVmExbkJiR3p5amNqOElka0szSmI2aE84V2RGSjZt?=
 =?utf-8?B?SngwT2F5ekF6S2gvR2RUbkcvZ3JwdENKSXoyZXlLbnU3YVg0NXRuRHZaVk1S?=
 =?utf-8?B?SmNsY0F0MjlmOWdoMGRlM1ZXcUs4VlZYNVh4MFNqdDMxSlZCekQzaExFa3RY?=
 =?utf-8?B?dWMwdWZQdFZlNTVCaXNXZ09sSkdLQlpWQ1BUU0J2a0F1SzExbGFzV1M0cVhj?=
 =?utf-8?B?cm5RWDlXdk5qOGVJeUowNGhSRi85RmJwZktaa0VVdXJ5UERNUWNVeTE4RFFo?=
 =?utf-8?Q?eO+lBJPxAj6sozIs=3D?=
X-Exchange-RoutingPolicyChecked: b89cOqBbC0+sZjrIYGjOZ3lfomawLBOjQYtqbNJmI9G4Od/shRvcoGz8hBpn0E1+ODT0eOxTsErIdarOjCakhipEe3mrpsvQ5x9zfY4rttBY0EGqWlGmnSW1RjtDPcmAL/QpVITjusdP3/6dnNJqIRyrxttxmrQUKLeFxRLg/arqFqCbjnWida3wz+iwAVIHboi3z5ZxS4kgZi2MGj5D6tNlbWNHO8mF8z3uWFbGM9dQ0WzOFojR4Xbjfb7hn89e+ItFtgnACkmaae2H6RcWvQIGLWHuwOaTTsBFCd2xHwdxqugPDNnsiibMG1vtxt5hDzB56MJFM/VYykOSqdL8FQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88324340-1296-48fb-86d4-08deabb17f32
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:53:16.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVs3CCELQoxlakzkEc8WDMe9TzSvnW5T9H7GbsvMbmECOKZUA/ZpE/r2GOqCxQzGjHCNK73mCZkIPlXAhkaYDFj8N1GV8vOv/rPmCZGWT+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 93F4B4E06E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,napi_threaded.py:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 10:14 PM, Jacob Keller wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> For the main VSI, i40e_set_num_rings_in_vsi() always derives
> num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
> the user requested channel count in vsi->req_queue_pairs and the queue
> setup path uses that value for the effective number of queue pairs.
> 
> This leaves queue and vector counts out of sync after shrinking channel
> count via ethtool -L. The active queue configuration is reduced, but the
> VSI still keeps the full PF-sized q_vector topology.
> 
> That mismatch breaks reconfiguration flows which rely on vector/NAPI
> state matching the effective channel configuration. In particular,
> toggling /sys/class/net/<dev>/threaded after reducing the channel count
> can hang, and later channel-count changes can fail because VSI reinit
> does not rebuild q_vectors to match the new vector count.
> 
> Fix this by making the main VSI num_q_vectors follow the effective
> requested channel count, capped by the available MSI-X vectors. Update
> i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays when channel
> count changes.
> 
> Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
> retains its full queue capacity.
> 
> Selftest napi_threaded.py was originally used when Jakub reported hang
> on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
> i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
> identity and threaded settings survive q_vector reallocation across
> channel-count changes. This is achieved by using netif_napi_add_config()
> when configuring q_vectors.
> 
> $ export NETIF=ens259f1np1
> $ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
> TAP version 13
> 1..3
> ok 1 napi_threaded.napi_init
> ok 2 napi_threaded.change_num_queues
> ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> [Jake: use min() and clamp() as suggested by Simon on Intel Wired LAN]
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Sashiko points out some possible issues that might need to be addressed:

>  drivers/net/ethernet/intel/i40e/i40e_main.c | 34 ++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6d4f9218dc68..23156015ed86 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11403,10 +11403,14 @@ static void i40e_service_timer(struct timer_list *t)
>  static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  {
>  	struct i40e_pf *pf = vsi->back;
> +	u16 qps;
>  
>  	switch (vsi->type) {
>  	case I40E_VSI_MAIN:
>  		vsi->alloc_queue_pairs = pf->num_lan_qps;
> +		qps = vsi->req_queue_pairs ?
> +		      min(vsi->req_queue_pairs, pf->num_lan_qps) :
> +		      pf->num_lan_qps;
>  		if (!vsi->num_tx_desc)
>  			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
> @@ -11414,7 +11418,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>  			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>  						 I40E_REQ_DESCRIPTOR_MULTIPLE);
>  		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
> -			vsi->num_q_vectors = pf->num_lan_msix;
> +			vsi->num_q_vectors = clamp(qps, 1, pf->num_lan_msix);
>  		else
>  			vsi->num_q_vectors = 1;
>  
> @@ -11503,6 +11507,7 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
>  
>  err_vectors:
>  	kfree(vsi->tx_rings);
> +	vsi->tx_rings = NULL;
>  	return ret;
>  }
>  
> @@ -12043,7 +12048,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
>  	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
>  
>  	if (vsi->netdev)
> -		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
> +		netif_napi_add_config(vsi->netdev, &q_vector->napi,
> +				      i40e_napi_poll, v_idx);
>  
>  	/* tie q_vector and vsi together */
>  	vsi->q_vectors[v_idx] = q_vector;
> @@ -14264,12 +14270,27 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  
>  	pf = vsi->back;
>  
> +	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
> +		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
> +		vsi->base_vector = 0;
> +	}
> +


It says:
> 
> Does vsi->base_vector need to be cleared unconditionally?
> If the hardware falls back to legacy/MSI mode, the I40E_FLAG_MSIX_ENA flag is
> false, which leaves vsi->base_vector with a stale non-zero value.
> Subsequent calls to i40e_vsi_setup_vectors() check if (vsi->base_vector) and
> unconditionally return -EEXIST, which causes the VSI reinitialization to
> fail and the VSI to be destroyed.

I'm not sure this is an issue. base_vector should only be non-zero when
MSIX is enabled, so this will clear it to 0 in that case. In MSI or
Legacy mode it will already be zero so it doesn't need to be cleared.
When switching modes we have to go through this function to
reinitialize, so we should clear it.

It might nomimally make more sense to always clear the value to ensure
its zero regardless if it ever got a stale value, but I don't think its
actually required.


>  	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
>  	i40e_vsi_clear_rings(vsi);
>  
> -	i40e_vsi_free_arrays(vsi, false);
> +	i40e_vsi_free_q_vectors(vsi);
> +	i40e_vsi_free_arrays(vsi, true);

Sashiko says:

> Can this result in a use-after-free on the ring structures?
> The i40e_vsi_clear_rings() function passes the ring structures to kfree_rcu().
> Immediately after, i40e_vsi_free_q_vectors() iterates over the q_vector->tx
> list, which still points to these RCU-freed rings, and attempts to modify
> them.

I think this is correct, and we'll need to free this in order of
i40e_free_q_vectors -> i40e_vsi_clear_rings -> i40e_vsi_free_arrays.

It does seem like the q_vectors maintain their pointers to the rings and
the i40e_for_each_ring would access the values. The i40e_vsi_clear_rings
function does assign the pointers to NULL, but those don't appear to be
the same pointers checked by in q_vector.

I will note that there is at least one other teardown flow that also
appears incorrect and calls i40e_vsi_clear_rings first before calling
i40e_vsi_free_q_vectors: the teardown flow of i40e_vsi_setup().

This needs to be addressed, so this patch should be dropped from the series.

>  	i40e_set_num_rings_in_vsi(vsi);
> -	ret = i40e_vsi_alloc_arrays(vsi, false);
> +
> +	ret = i40e_vsi_alloc_arrays(vsi, true);
> +	if (ret)
> +		goto err_vsi;
> +
> +	/* Rebuild q_vectors during VSI reinit because the effective channel
> +	 * count may change num_q_vectors. Keep vector topology aligned with the
> +	 * queue configuration after ethtool's .set_channels() callback.
> +	 */
> +	ret = i40e_vsi_setup_vectors(vsi);
>  	if (ret)
>  		goto err_vsi;
>  


Finally sashiko says this:

> Is it possible for the dynamic reallocation of vsi->num_q_vectors to cause
> irq_pile fragmentation?
> Because i40e_get_lump() requires a contiguous block of vectors, reducing
> the channel count and later increasing it might fail if another VSI
> (such as a Macvlan interface) allocated vectors from the freed hole in
> the meantime.
> If this contiguous allocation fails, i40e_vsi_reinit_setup() aborts and
> destroys the VSI, which could render the interface unusable until a driver
> reload.
> Also, if i40e_vsi_setup_vectors() fails here and jumps to err_vsi, will the
> driver skip unregister_netdev()?
> The err_vsi label is placed after the err_rings block, which skips cleaning up
> the netdev. The code then falls through to i40e_vsi_clear() which frees the
> VSI memory.
> Could this leave the active net_device registered in the kernel with a
> dangling pointer to the freed VSI memory?


I'm not sure exactly what its trying to say here since it seems like a
few jumbled issues. However, I suspect even if the fragmentation issue
is real it shouldn't be solved by this fix.

The issue with the err_vsi also I am not certain is real. The function
returns NULL when it fails to reinit, and that will stop probe or
rebuild. It is likely that this entire chunk of code is flawed and
should be redone, but I think that is also out-of-scope for this fix.

Still, we need a new verison that fixes the use-after-free from
q_vectors function.

