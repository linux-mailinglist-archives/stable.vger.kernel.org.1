Return-Path: <stable+bounces-53362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E608490D150
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B931C240C6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB87019FA7A;
	Tue, 18 Jun 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5PHX+8O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36619F495;
	Tue, 18 Jun 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716101; cv=fail; b=KpJreTIY2Ym5j/j6JD4nFFCsOyD/FjA5eWPXnQfMbF9al4fEVH11rpGY1cByNmHEkuClW7dcPdIZXuG4eWYHpCBMnXHp0jioAr10E+1LXbkIoPrhYsFc6CWy3UBH2KQZrWV6qX3xRvfu+JJJ8kd9JlurfDr4xKXmGDTIfpphang=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716101; c=relaxed/simple;
	bh=MobmdaFdN1dF5+vrJevMC01BDfRgWW1ADOw5NzxZsd4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QEfDg098rco4v1zYQJp7YrCLgep4ywXGOlqbAsNsFjdWXgBH/eCEoolA1gs1hc/i2ttOVHYlInNyUsuSLINK/vXWydXVUws3FMgYuRb9kCO5WvlMsCZVOeeFf3zp5YIsORZro5biM8u6e/52A9zbzH6qLWqxi/egeyiyJFeGMIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5PHX+8O; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716100; x=1750252100;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MobmdaFdN1dF5+vrJevMC01BDfRgWW1ADOw5NzxZsd4=;
  b=c5PHX+8OSr2cBTNDrt4iiZbd1FKkmDEEqLn6YP2o6mxSV21brRjHQeD/
   wRdOOAVHHJEdfEPKs226mfQB1GAewoV54D6f3NYSlX2U8i/D9QKizI2dt
   suN0/W74xCRaTl3cUi7pfVP9Num6MN6zIVm1TnPo96LoRxFAofMI7xiwN
   5s3I0bvFcUcfjmJRtppyB0miElfmOr7PSyoA6Swoqgic/q7JadN3k69EU
   DZKFLIVL4VE6KJoyF1JdDmC56nBk/F/ldEEHMQROhtNHpsPU/jdt1CZOF
   eoShwiZ5Q/zC5WK5qxRHYyBs9KmghK379doTiFWP49HxJ0czCiSVTX/XF
   Q==;
X-CSE-ConnectionGUID: aPfdZQFISlOwF5gJXlQphQ==
X-CSE-MsgGUID: 7SIymQfaQri5cQ+nC2z6eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="18505503"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="18505503"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:08:19 -0700
X-CSE-ConnectionGUID: McUuLKaoRLC6h5LnfFmFQA==
X-CSE-MsgGUID: 8zrbVgbSSXOgzb4iVYanpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72292730"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 06:08:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 06:08:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 06:08:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 06:08:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4HL87xjP2sLCGEBi1D9LeaZs+9VKqfQg0hX7Di1IRLeNJkUKcHZs/+uhhob1tl4tAuM3lIN+CBL+LAd00rWbnGmrTF4MCVxAefDIqQMmZw9Qf5F060rJdxf6K5wEyb2rdl5+VA3a5cRXAk+Vnyo4Y9uJ/lvy1HHkB+AHYVB0Ek3tudQUgAJEAZuxgXIVqV8eA2vxrg66Ot2LKC8zpPg1NlTGC/8cyY3rpdbgNMTY483KMEhUmyfwPlEfBSGq1dUj7XqqF8fXyqMtBqUjMW8gLh2+21uid6a2jXpe2mbrUE6Iw01Y/ikrvgNSTu2MsA+AQtWzpm4XWRDYA1usOrS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSHdLR1J9LFCLMxAe6hPCEmDXRrVshKy6IUsrrTKl7s=;
 b=YnNFtkLZfVwLL6avSNP8+NJByMNiIsEO5XzdKg3do8IvjHTgs8bJ/QQVpwUNOFlJ1vUaalj+zyDFVDQ1KoTGKRZLcR/30tHROThaRWzDeomoQ+tj98Fv23wZWQdH9jIR5JDrSnRp5epdBxYvPgG2EHBQVYeVrRauCTmCtY6D09CRfifiru8sc8aNridyOTilsX05ruESsRW3GJyAQQtWI1o8gMJ45mLfXXHL2M5PMne4rxLnimxRD3MApQM8nV17lcgzT1chr8bvr0UZ/tcCbk0Xl3jcsmDUtGDkAAlSsczU+ZizU0QOP3txG78ADNQXaEbSGhBge8yP7nX01NNgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:08:09 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:08:06 +0000
Message-ID: <65081be3-0097-49bb-a28a-f50c733d6eca@intel.com>
Date: Tue, 18 Jun 2024 15:07:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: stmmac: Assign configured channel value
 to EXTTS event
To: Oleksij Rempel <o.rempel@pengutronix.de>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: <stable@vger.kernel.org>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Tan Tee Min <tee.min.tan@intel.com>, "Wong Vee
 Khee" <vee.khee.wong@linux.intel.com>
References: <20240618073821.619751-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240618073821.619751-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0265.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::32) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e4c877-4476-49f2-9f09-08dc8f97b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFltNHdNQXJBTjZUdWVob2xYeStVakdWNE9JMnZ5bFZLRy9XMFFMWDFnbjk0?=
 =?utf-8?B?YWQ5YWRmL05YSXN5Zk9QMVpleXk5VFU5bXNiaTJoTzArL0lZZk1BT2FINWZD?=
 =?utf-8?B?MGJUQXZkR01LZzFDVUk0SVBuTE94YmZ6TFhCc05wdlpWSW15ZmRBOGN4Y2pS?=
 =?utf-8?B?dU9YdWk0V1h2akpDV3RWYkREMjVYRzE3dXNKeVRVbnVHbUFZTXpUM2FsU1M3?=
 =?utf-8?B?dkxKNGQ1RUZLd1dVaGFZRGl0UlQ0d3hZMzl5L05aWGpRL2UxTWhjMVlkRnBU?=
 =?utf-8?B?anA3cHROMFAzTDBGMkdwUGhabThFMmZ0MmZCWDdDdVVwTmJyY2hDNHo5K0FO?=
 =?utf-8?B?eEFiVENVU2pUZmc4dE1nR0JPbnd4R0YzbnRYYytYTGgwcmY1VXkxWGxOU1pp?=
 =?utf-8?B?eE1POUxVamFxcE9KRjNVZjI5WUJlZXByN01TOTM2N2tRQi9naUZyYWk0ZGtS?=
 =?utf-8?B?a2Q2QXNudzhKbDI3cTFIRGl6NDRQVGhCblFHYlVNbkpqSS9TL0ZROGxqQ1Jl?=
 =?utf-8?B?RFVUNERzRjZ6UDIxRUFCMXArekdTZXAzaEVXZTNkTCs3YVgweVVldlU5T1JP?=
 =?utf-8?B?cGNHYUlaV1BqMVlILzhrUGNCZW1QVFcvOGdQNjc4K3pLQzh2N1RnekRqNlFH?=
 =?utf-8?B?VVpLWmhNdjdHc3U2Z21ZR1hBQVViT29jYWgzSlpLdzJ0ejJ3aW81dzh4NFFu?=
 =?utf-8?B?bnNxU0lEakowVmJZRGc4VW1uZ3RIdDBzZ3YyWXo1Skd0RUlyL3c3dnlyQk51?=
 =?utf-8?B?MDFVcDd1bzlVeDdpdDBSWG81aGk3bVlVOG5mbFVGb29LbXlqTENVc0xUYzNG?=
 =?utf-8?B?R2pkMmo0WnFJZHFnWU5DalM2dDFSdVVSN2x6MVpqK1NwOHdtYTU0ZWJ4WGVH?=
 =?utf-8?B?L0xudWtEVmdjNXAxWXhaZ1Fjb1lyaDhCc0Z1TjVxK3pLT2xiV1lkUlZ4Vlg0?=
 =?utf-8?B?YUprb0pjeCt4WWhOR3FnVnZObVpNWmpITEJLdHB4d1NLS1QvdWVqc2QvYUtJ?=
 =?utf-8?B?Q3N5MGcrejNKMWVPRUxWZzRnUmRlY0w5aXpjaVlIejkxQXBCYk1FU2tKcit4?=
 =?utf-8?B?RHdyZTdwbFBZYXlNSk8yNXA4bjFtSUVzTEN5U2NhcjZ2ZWE2OFVkNTZEdDVl?=
 =?utf-8?B?WVdJUFN1bzNNR1drcy8zYVhKbGxGVEZvclpzSDhoRlkxVGJaakRicUpOM3RY?=
 =?utf-8?B?Q1hXYURHanRKMmdvUlk3ejlPZ0t0TkR4Z0txSGN3MUdSalhhU3RwQTR3MUdM?=
 =?utf-8?B?c0lxVmVoTlJOMW9ScjlSVW42WXdVVDJEUXVvZ2JGN3Q2YzM3aTRxUFdRYkw3?=
 =?utf-8?B?bkVYb3V5SngwV1RvT3ZId1lUcDlDY0ZIMTFyS0RGcndFSnptOER0K3VOOEQ0?=
 =?utf-8?B?VUl0YWFrQ25SWDFFc2VQcjY5V1FudThRRlYrUWdtMWdzclROZW05b3dTMEtw?=
 =?utf-8?B?Q3FBaFlYMTJZRUhWQUZEVmhTRHI4WVEzWFJDVDg5ZDZORnBOaEZIaVhzbWZk?=
 =?utf-8?B?TU95Zm9odUU5VllrdFd1TVVTNjl5N1VleCsyeVF3cDcyR1lpdjBhOEZhMG84?=
 =?utf-8?B?WE8vYmxyTGQvVEhpcEJVdDNHdjVhZldkbVlMaGkybmVrbjdOc3pIZllEQ2Nw?=
 =?utf-8?B?b1BtWnBWZ3BOWFozRm14OTZPZFpGTCtSeUt1akJvUk1BMkFtVGk1UHNYWU5s?=
 =?utf-8?B?TXMrdGZRSHg3aXpvblM5VFNTOFZ3M2l6NGJCNnVrU3p2YlQxUzA0cWxoaWlp?=
 =?utf-8?Q?LxpOdavmjP0D3CvnO5CLCpIuRREXQ7+KGww6rkd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3Bqc2J1Y1ZmMHFCQ1V5MXpEUysvWHRIU2ZPeitOM25tb0VMeG1hOGRrR0Jt?=
 =?utf-8?B?UzlOYmRMSWZBOVd1OEhHdmRydVdmQnVtTmlQMER1MGNzMzRDMXczd0lLWCs5?=
 =?utf-8?B?c20xYWdVZEFkckpydytUWDhPZlpMZGxDWk9XOTJFTFFEUzdDbnNMYXF1bTlM?=
 =?utf-8?B?R1lQUm8xU2E4WmgvT0t6Z1FFeVhWVkRyU1BzeU5FZ3ZpaDhsaHRIZDVHY3g1?=
 =?utf-8?B?OVg4ZVNqVG1qRDRaWHo4ZUVwbmY4clp3djZHOUo2c0pBUVJ4ajhmKzRoOWhj?=
 =?utf-8?B?K2xSeVN2bUowR3VHeCtqMGhZZlp3VnZRU25MQXdYckxkN2Z5bVAxRElKR1FW?=
 =?utf-8?B?cUZzTG5NeVVrNFlZVHlkNEpsZjhvenA1OEs2cS9VSFNZMFdrdGF5MVBWN3hv?=
 =?utf-8?B?UGowUU1TbXo4MlpOT014UHEySWtSNWhRNDgySlA5RExmRXNDVUhiSEZkZmxi?=
 =?utf-8?B?WURmVysvREp6L2ozNkpacW5WTFhwY3BuVHRpb1NFQkZmZ3VNamVBNS90NnZ0?=
 =?utf-8?B?eng3TDR3NFBBYXFuRldqdjA2dmJ0YmpyTmRIeS9sYTZPanQyeVJlMUdPVDJi?=
 =?utf-8?B?eHpLajBJOG0rQmtmMnA1em4zbHZRNXA3SXRvb1g4RVg0SlB3LzJoUGI5ejhD?=
 =?utf-8?B?T3diQVpwNHJOdVFWZUR6M29PUTcveGNKc3RFV3ZPdmoraTRCbWFRbVBHaTYx?=
 =?utf-8?B?d3F3cW9BdldMbzdBTDFBaG9zTUNlZmxOZmJhN1BLdG1rOEpjVXVxcDNMd2Qy?=
 =?utf-8?B?emxiQjBoNWttZ1ZMRnplWm5UNVJXL2dDOWxINnN6RXZhaWF4YnQ5UjdpYStu?=
 =?utf-8?B?QkdzdGlJNlNDZ0wzZWlCOWhobm4zQ09LWFlGY29kbHVTSWVFYzNXbW9IZEhZ?=
 =?utf-8?B?RWpUV1pLV1FJaXlqVGtRUlZjRXA5blhWNHM5dnJzMHpLb2FadHUxN3V2UVZq?=
 =?utf-8?B?NksxQjNOTndOMVd6Njd1YTU1dDZtaDd3OVhmWXkxN1paaE1mbEJ6SlViM2FO?=
 =?utf-8?B?cm1lR2dtbVFsNUptckpJRVhWR2xybXpPUWRhazhpQnpVbklWdHF5UDJqVlkx?=
 =?utf-8?B?T2NoQ1Q4UnlYYXpUeG5UOXpmSzN6anNPdEZrbEhqMDBFazFJSzdKN1lOSzBq?=
 =?utf-8?B?d2ZNSzBKelNITjlnUHNvS3gydFRBUW9LVEMvb1FQZFFlU3JmQTJDYXVqNmFz?=
 =?utf-8?B?SkcwS1cxVjVuTDNuVTI4SisweGpLZ1FnTFl5RWZlOGJIV1VMbE9Tb1NUaksz?=
 =?utf-8?B?UVV1MTlUL2dvOWlBMmFjcFhGSy9MNEhjWGhrNEVhVjg4RmdWYi9JSlhkajJp?=
 =?utf-8?B?UU1MeFNFdS9pbU1HZ21TWDVuQ2lVc3NUbmJucHZTNEZ5Wkc2b2E5YW80a1Rm?=
 =?utf-8?B?c1BDa1JEWGlyU0xpZEhnbXZJWDJWR3NFNm92MjhScDY1MUdNVUE3L2ZVemZi?=
 =?utf-8?B?WFFONCtpL01zQVFJMUdwTXlsc0tyZ2lFUUEyaG5IR2ZEQWUrZVRmS2VXaTdy?=
 =?utf-8?B?ZG1WZkVPSGV6YTJYMVZWT1VtbEh2MU5YK3MrV3Y1RHI5OWd6dC83eWpFYkho?=
 =?utf-8?B?RDNuNDh5RjhQc0VGd0RKTnYySmd1R2dXaVJWVDczcDRMOEhhSTRNaFJSQ2Yx?=
 =?utf-8?B?bUs4UkJWdkEvOTB1K1grRi8yYU8ydC9DOE5LUFFEZ0F0UXBja3BYSnUyZGoy?=
 =?utf-8?B?cFVrNmJxSFMrSnNKNnV6Ty8rWFRKaWRSRmRVSEZkMnRsUGFGdEY2R0s2Y2Nl?=
 =?utf-8?B?T041dDMydGhENDRiYWdoei9rTlBaR2RJZUk5SWdUMk4xUm5DUWJITE92VGg3?=
 =?utf-8?B?ZWlOZFFvQnltZDRpL0RpaWRucVBmVmw2T2dsN1Y1bzk2RWJJNlVaYVA0NGlv?=
 =?utf-8?B?d0ZjdFA2djIwOGVYQ0RWaHpueTNOUmd5QjNBZ1RRbTM0dWFNRU5TbE9HTG5T?=
 =?utf-8?B?Rjg4MmFFanppNUF2SkRrWkREdXVzM0k3NW5NSXpUM3NaT2daL2tiTFk4empx?=
 =?utf-8?B?VXNwdHBkMTBPZXRDVGhSQWpXUUR0SnhDNmVMcTk3d0w0L0ZDQnNCSlMya0VF?=
 =?utf-8?B?cE5YRi9seXVQcXc2VjkvdHVoNk15bTUrSTRyUlhNZzBaVXJkMFc5d3A5NURD?=
 =?utf-8?Q?NY829sImdyGfaKd7RzYTPCCV4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e4c877-4476-49f2-9f09-08dc8f97b1ad
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:08:06.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywpmOg/i3mkDMxa3eHBcSo9ZAkvUC9cVzWm4157edTsrVkwE8MTJVeerjsm1Od+NAxr22+NVLSFGNT0CLFxfZJXFX4gx4rUzAO8gzh6Iej4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com



On 18.06.2024 09:38, Oleksij Rempel wrote:
> Assign the configured channel value to the EXTTS event in the timestamp
> interrupt handler. Without assigning the correct channel, applications
> like ts2phc will refuse to accept the event, resulting in errors such
> as:
> ...
> ts2phc[656.834]: config item end1.ts2phc.pin_index is 0
> ts2phc[656.834]: config item end1.ts2phc.channel is 3
> ts2phc[656.834]: config item end1.ts2phc.extts_polarity is 2
> ts2phc[656.834]: config item end1.ts2phc.extts_correction is 0
> ...
> ts2phc[656.862]: extts on unexpected channel
> ts2phc[658.141]: extts on unexpected channel
> ts2phc[659.140]: extts on unexpected channel
> 
> Fixes: f4da56529da60 ("net: stmmac: Add support for external trigger timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index f05bd757dfe52..5ef52ef2698fb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -218,6 +218,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
>  {
>  	u32 num_snapshot, ts_status, tsync_int;
>  	struct ptp_clock_event event;
> +	u32 acr_value, channel;
>  	unsigned long flags;
>  	u64 ptp_time;
>  	int i;
> @@ -243,12 +244,15 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
>  	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
>  		       GMAC_TIMESTAMP_ATSNS_SHIFT;
>  
> +	acr_value = readl(priv->ptpaddr + PTP_ACR);
> +	channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
> +
>  	for (i = 0; i < num_snapshot; i++) {
>  		read_lock_irqsave(&priv->ptp_lock, flags);
>  		get_ptptime(priv->ptpaddr, &ptp_time);
>  		read_unlock_irqrestore(&priv->ptp_lock, flags);
>  		event.type = PTP_CLOCK_EXTTS;
> -		event.index = 0;
> +		event.index = channel;
>  		event.timestamp = ptp_time;
>  		ptp_clock_event(priv->ptp_clock, &event);
>  	}

