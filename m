Return-Path: <stable+bounces-116662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D4A39353
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 07:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9E16E041
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B31B3950;
	Tue, 18 Feb 2025 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NTq6BfWL"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC161A5BAB;
	Tue, 18 Feb 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739858933; cv=fail; b=ntE+p5uK75WY9ZV7ee3+n2+QPF21rg8aAljETxkVvOChMXD++a/tcLjU40r48A1mz8FOaG4/qe8AGHQjIRR309YOo8asNuF2/rdPRlFpXD+KUFCon63Z2U9AihCFUPp0tjp3UfoSJZ8hrUikxnsWLbl8KRbdfItlGkRyeAnySfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739858933; c=relaxed/simple;
	bh=t36sVAzNIWCNUyI4Z7Upy3vvuGqyM4XEBhrz4ACBGOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otf/HQ3aIcwInbbKC2VocRQUcWQCJ7H3KfYDQ0Ot+u2UtVcAEEU0ifHuz9pQuw7KUxine/JH+4AhxBN/+HB5LB+eFiK+0Z+OUzu9Y/qang52nnEGsxeRS3Fc/iRA6oeXDFy5WBRm0gj1lPPeUyxXFSedgI7oxauKUkXsfon1XXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NTq6BfWL; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksEJuA2EJG3aBVMh76vt8FuTnIUpHetamaYNy/W7TVb0Zejhd3YL0+u+FX4sjOkw98wy/cxueWxKD0MypCobwoNHM13Jnvjz8QwHEka8ZK1IZlTcJ1IuCPO0TLYbUCHlnXqsKipnIhDZH4jvcMB9Wub5B47MtFCJFpFwq/cnNUG9uyQ4C/mC60LblHvTkZY8tnutXxYgW0doLTX+0BR2tXnyGHckpKKNcDBBsO7ehg0C37ZU7Co6q4CmeMXQTBTw2jC63C93Crwf/Q1cQJ8VTZm4ibrme5sDJhddEzDNxd+aL4Owb8ptShQzNh89fmH+wbtvcxmWxjvGDOFG5Hln/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t36sVAzNIWCNUyI4Z7Upy3vvuGqyM4XEBhrz4ACBGOw=;
 b=iK9DgsXKjQ0dwYEj0UZBDu/cAzxr0saJ64JgUMBNinJtVOIIyRDkHdlWJICjuvcOdypnqVop3yfOjxGpbpZ073ZKXbYb/xsJbvpkgmnoDMOlnPd7qqcvsvxRNRweOI18eVzOfBnV9JdZs6t9u9lJy3ZBw700LK8pCold4wzsnOPj76mf7q6QdvsokzN8f+vAfOY8pM8so9DVCObP3dyVzSxZWZ21Zk/HD1r+wEihzNL5WLT8MmO69p0+wRpQTNJV1qODvZbxbYZqFwdOJf9l0+i9KS75d458WZGG6QwceuxcjdS58fQuk+B7nF1+TmEGZWs0YsaSm4koa49q9khy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t36sVAzNIWCNUyI4Z7Upy3vvuGqyM4XEBhrz4ACBGOw=;
 b=NTq6BfWLi8wRB2mA+hy+ZQlwXt+h3jIJBsEhbNRg2SBtWiyL9iqKDfVYwSFFbMT2Vynp7iRR3vH9HaqubHYN564UMDI/2Uhbc2jnoQ5obZO1df5pEp5EyZpnRR3cYnt3jhYuGbzPX5C8LFRnQXLuU7F7N+fSMWBINAhrPpu2jaLTQcKLLR6MW1pMcd9ExlSgjDl7KuEeZaYIJ1RgCqEZZDS79X8CfM5e9BN0S16yV+uWMEZNjga6tGWQHswf5CQaWTk71XftVhAeUoWrCIx0Yz/w3EHWcGvLLo2V52j8H6/txJnoWD+0DdbW7nluThD3qchY6bqoCpIE0RJlNjXpXQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8770.eurprd04.prod.outlook.com (2603:10a6:20b:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 06:08:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Tue, 18 Feb 2025
 06:08:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgSIxXCrhXQUTvUaf5YMAXyCn+7NLeKmAgADXyvCAAD3KAIAABkPQ
Date: Tue, 18 Feb 2025 06:08:48 +0000
Message-ID:
 <PAXPR04MB851032041A21AC65C0C77EB588FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <Z7M1hQIYZGWAZsOT@mev-dev.igk.intel.com>
 <PAXPR04MB8510AA1D5B596B4382873A9F88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <Z7QeXnBE0iBNFQYL@mev-dev.igk.intel.com>
In-Reply-To: <Z7QeXnBE0iBNFQYL@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8770:EE_
x-ms-office365-filtering-correlation-id: 7a1614a4-9c16-48d5-cd94-08dd4fe2b57d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TmpSQmo3Z0FyMGNMYWNGVUNyY1BVV2o1aEZQWHpoRG1Oam9KQk9QbDd1MFVO?=
 =?gb2312?B?Q1NjcW1kNjFUbzYxT1NDR0NJVDlLWk43UmRmcUpIdW8ySlZVTWRDVEJ2bVBI?=
 =?gb2312?B?TXZRSERVZjlnT3hiN2pLUG05YlRqQkRQY0ZxM3dsRkxlZUJlZ0tSQ0NvSzQw?=
 =?gb2312?B?cXRjVFJLRkVUZGYxRFJlZGRkNXI5VWF1WlNKVU8zSlNSVllKaE9YbnBRVFNs?=
 =?gb2312?B?SDNkQXZZSCtDaVoxMERVakZkOWFOdzBBS2J5MU1ITDViN2g1NFdjajlwaTFv?=
 =?gb2312?B?NkgrUU5YZ0ZPSjdOSm9HUVhSK1V2b1RIMzdDWEd3a0U5M1Q1Mm1hRUgxRTV1?=
 =?gb2312?B?Y1dRNFFLZFJrOFNqVnpBRVhXUFpqTjY0TmJ1VW9wejIvSld2a0k3RWtOdUNP?=
 =?gb2312?B?MFdic0N1U1UrZks0dmhLcStXamtRRGx1enpMYzdaVFdvK2s3TmZpOXVkczRU?=
 =?gb2312?B?em1weFllaXJDWkpvbmdpSFlETGwxMmpEVXYrRXcvQ3RlRzZCYkVoVkJrUVRp?=
 =?gb2312?B?NWEvVFlmTmY3TkRJT1gwemQxUHkvUWVIN2d2UnlDa2tOZVhscUJINnJsUVNq?=
 =?gb2312?B?NGZ4TkJHRGNwTzJ3UUl2Y2FQRTFrSmdJNVBoMXVsWUFzTVgxbnByWXZyZ2hn?=
 =?gb2312?B?QzM1Yk5BQ2R4NVhBb0tKTDdtdlZwdHh5N283aFJXc0J1WFBNM1A1SW5teGIw?=
 =?gb2312?B?WlQ0SnhFMVNGUlhMQnJYWU9SVDdjSGdZRW1wNktsbk12TVV2ZThpQmprdWlK?=
 =?gb2312?B?RkIwc0h0NURZN1RoTlRia0J2UlhOWHRkbmhRaStyTmx5bmU2MjUySjh6ZTFU?=
 =?gb2312?B?bmdBN0JiYlVxNFFUc1dtMERYRE1aVkZSZWh2a0w5NFdTMFFtWEUybUhxbUJl?=
 =?gb2312?B?TGVoejF5U2xFSmdGaXFhcEFxU0QvNFA3THhzRG53SXVZbk1RbEdsTjBHZC9U?=
 =?gb2312?B?ZnpMUUZpeUFIckhLMTNzTHhJL0Eway9HMW50MituN2dndXVjKzRyV0xkV0dF?=
 =?gb2312?B?cjhHYS9hdEVpZzJYem9Xa0RYWHM1RmFVbjJUUTVXazlWc1hHK3R3RGJpdnFE?=
 =?gb2312?B?dVhhK25ac2VyM0dMOGc5Umd4bm1ZOFZDdERzOVZMeDJmMnJkQldsQ29IbFdC?=
 =?gb2312?B?Y2YwYzJQbFV4bHdHUjdnOHBjbitZR2JCaE5lblM3WUlnUXArY1pCeS8zOGdI?=
 =?gb2312?B?M2U1UmpOQllzVCt1K25GeUpaeTFOMjhPSldIVGxKTjZnNTROM0JrVE9PTmlS?=
 =?gb2312?B?SVlSdTZJNzZEbWFBQmRucHB3Y3A1akdFRVl0dW80WmVFaVlLUy9sTWZrblNI?=
 =?gb2312?B?VUxHdDVscGE5djlVbnBIbmlqVHkvVjB1MjlaYWovQ29FcHVnQnhsaW1oSlZP?=
 =?gb2312?B?Tmt5UnRBYU9BbDU5ZTFPRnh4U1B0TXU3LzZzaG9QaUVscW0rWTUwSVJJQmpM?=
 =?gb2312?B?Yk4xUFlVRmdtK2psaUVIRFBHVW5jd0t3Y0x5VFluNy9Ma3hod1ltZFVLZlY3?=
 =?gb2312?B?d2lvVTN3U1gxZk9WRkdHKzNHbkY3aEc0SEM4eC9GYXBJcW9peVNyeWowUlB4?=
 =?gb2312?B?SnZxaEorNUdrWkM4dmJpNm80WUJ0T2hIaEk0WlBRNWJtckZhc1ZJVkd2Nk11?=
 =?gb2312?B?dTR1S09LRzZQNFRscUtTUlIzdWxlaUp3YzR2NnJ4cDhMd1VreHI0NGNWMEZ2?=
 =?gb2312?B?dmxPZVhMOWlMUjhXQ0ptcXdPZUhOM0gxSTVFd3FReDF3VllRdTljR1VFQk5O?=
 =?gb2312?B?clI3UDFQSkNZcWlBVWpsUjFHaisvK1ZiWWY2ME4yTm1RSEJSOHRpQ0NLckE1?=
 =?gb2312?B?ck9GV1JjTkl0Q21BbEZoNmNsNC9KUTNnUEpuS1lLbU40TEtycUpuYWEydk9m?=
 =?gb2312?B?UXNhOW9kT3B3ajdobVJsR3JuUlhXK09hTXJHUjA3dm5Ub2hBczNOSmplQmVl?=
 =?gb2312?Q?rzMbLGZnet6SIox1mW/c07A0gzRGJkEr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aC9JTXhXNktoYnRBSnhEZUo5Si9teGtWN2plU1ZVUmtkNzgyNWovVUMyUzlh?=
 =?gb2312?B?aTFobmk2OXZGeWg5Z0p2N2FnbGpQbVJDREd4d3AzQzc2Yit6ZWYxUEhQZ1l1?=
 =?gb2312?B?bzhkTkFzQ01pQng1ZUhiNW1VQnhGSG1vSUN2aGlnMFp4RGtnZ1phSzM0T3Vk?=
 =?gb2312?B?Wkw3QUVmanBIYmJxdFgzeW92V2EzT0FwWTg2b0hiZjB5bzNKd1cxdFk4eUgy?=
 =?gb2312?B?T01KWUxTS1MrZHdaSmlIQW81TmdQSHRZM2ROUW5EV2hYaVJGWk8wZWZ6dGg3?=
 =?gb2312?B?cDVvaGFyVk0vTVZqNm1Cbk4wVXdldlVheG9ZYjN4aHBXQjR5bEZ3YUV4VEFN?=
 =?gb2312?B?WU8wUEd3R01jKzFpWEFYNW5JUnJlem0wOTFJcjZOaHYzSkMxZGwzcm9SbkNn?=
 =?gb2312?B?ck9VRzZHM2QwR3hDd0dhNU9HRFZnNmczaFQwQUVtOEdybGRqTEZPUDJVWDFx?=
 =?gb2312?B?VmFPNkRublcrMGVHZUJiVmRrQTNqUEhDVXpkOTZ4TXY4c001TEFvWi92Z2ZJ?=
 =?gb2312?B?M3lodXVCS1VLY2tNQ3BZL2QwcFlCTVpFMHl4N1E1dGVsNTNWWGFhTTA0aVpl?=
 =?gb2312?B?RUtuOHhoOVRUVzVLQkVYNmRTb21BWHJ4YzYwbUFaRnZvWDRZMUltdjFHMTdQ?=
 =?gb2312?B?TVlEMjNqZUFyZzRCVjBsZkFqMDFveGFEalFpcEptamFUZEVORGY0U01uRTQy?=
 =?gb2312?B?M2o5TTFmSkt3K1lmSG9Yd1F4cVpQOXVJN0trK056WTJDd2h6bGxGMllFd3dk?=
 =?gb2312?B?Y05LNlVHQzQvKzQ5NXhoUnNBQzRFT0plaVQrOVFCM2kwSEFsaWlsSWdZT2o1?=
 =?gb2312?B?UENzdnlGYllZdFZZOUg2dEhnZ2RzRHo2RXkrajN2TnUzM0JhRnFjdWlVWmJz?=
 =?gb2312?B?UkloVHVYMXdLcDd4a0txaUNPV2Q4WHNNU2FIOVVHUmozbERnSHZjeVNDbHdz?=
 =?gb2312?B?cHJjOUZ4UVFWNURnS2c1UDhkZURWcy9hVkRLWUJCMVBzek9TWjVUZHVUeTkw?=
 =?gb2312?B?MEw2Yml0Q3kwUk1EV3k0bldxQkY2TERoZWdsd2hJakJmcUdXaWpUSExyRjdm?=
 =?gb2312?B?MXRGeWtNZ2ZMNmV1ZFdoYTVQSkxOUUZCYlZhU0FHWTRJVkVEOVpwY2grcm81?=
 =?gb2312?B?RmhEbS9iVlFsMEpJWCtIVnRjYnZtejlGQWRudit0eUJwRm1sVXJWN3dMK3Zz?=
 =?gb2312?B?cjd0TGRBYU9wZ3huTm5hNCsxam5qM1ZHanJmQ25BNGRmSUJVZmNGZ0tGYWVI?=
 =?gb2312?B?ek55WTZ6OVVHa1ZkSTRuMXl5UExDTHBoQlI2SkRkRnZjTEppZUxrOFpYd2Ni?=
 =?gb2312?B?OC9IQW9oMjJ1WHJXZCtZVStJczVVb1JZV2dVbS9mQnYvMU0vbi84ejNzT3pR?=
 =?gb2312?B?ME5XTXdGdDV6N2pIQkdlZHgzMGpMQ0V5VE43QWV5STYvanVlRXdPU01nY1dU?=
 =?gb2312?B?WnV1cEljSVF0aEFuWUJNQlBpNWRKVGs0ZUZpQ21uK1NjQmZHeVhCOUYzV0w3?=
 =?gb2312?B?TlJIcExqK3dRNWtTSlBZemNWQmRiWG93bHFFbldBSitCMXdJNFUyd2lOVllL?=
 =?gb2312?B?NGg0NkkxdGZTZEdKSzIyMzQ4T0h2ejJUcllRNFZNclZZN1hnMEc1N2FGOU0r?=
 =?gb2312?B?RVNyNmxZb2xUMnVycTRMSUVvSU5VTlYxMzBJUEUrNFZORU8wNkplSDlVSWYx?=
 =?gb2312?B?UzlTOTNDVGdNWWVYL2ZhNkY4ejh2U1VyV2pJKzZvZ2lkRk94QjJVejJqQ1F1?=
 =?gb2312?B?ZzVqNmJwYTcyODdueXBUMFhCKzJXWms3d1J5eVQ3blJuTW96WFg3ckV4aGhD?=
 =?gb2312?B?L1o0ZU1pTjZVbUwxSE5MZG5QOUUrRU4wWEpQRTVMYkRBRDFBamg5aEJjN2E0?=
 =?gb2312?B?RHYxVWxIQ2dDekJZWUwxdmMva0lGaEZEejR1TVdyVklub2czeFJSeXRrUlFm?=
 =?gb2312?B?MUV5SEtUa3FhTlBabDgzVGJIUEJpbnFjQlMyUTdROFpkay92a2dSU2l1cFh0?=
 =?gb2312?B?enRTa3NqSGVyeldqQWo3Ym8yZWNiSGdCc2dWWFoxZW05ZVllT01ZODBZcGM5?=
 =?gb2312?B?SFBSSmFlZVNCYWpvRG02dUdWTU83MjJ5VlVvSDU3STMvVmg0L2Y5ZmhJZk9r?=
 =?gb2312?Q?ebOY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1614a4-9c16-48d5-cd94-08dd4fe2b57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 06:08:48.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ly6XCQlXfXA0QkX2QQFm9FXztjU0a8Nkanidvuk/SYaSEGKcH3JnyBl4tJhpCi2p1xn2QO/MCjiRN9EYiJIrCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwgU3dpYXRrb3dza2kg
PG1pY2hhbC5zd2lhdGtvd3NraUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IDIwMjXE6jLUwjE4
yNUgMTM6NDUNCj4gVG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogTWljaGFs
IFN3aWF0a293c2tpIDxtaWNoYWwuc3dpYXRrb3dza2lAbGludXguaW50ZWwuY29tPjsgQ2xhdWRp
dSBNYW5vaWwNCj4gPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPjsNCj4gQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAu
Y29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBJ
b2FuYSBDaW9ybmVpIDxpb2FuYS5jaW9ybmVpQG54cC5jb20+OyBZLkIuIEx1DQo+IDx5YW5nYm8u
bHVAbnhwLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgMS84XSBuZXQ6IGVuZXRjOiBmaXggdGhlIG9mZi1i
eS1vbmUgaXNzdWUgaW4NCj4gZW5ldGNfbWFwX3R4X2J1ZmZzKCkNCj4gDQo+IE9uIFR1ZSwgRmVi
IDE4LCAyMDI1IGF0IDAyOjExOjEyQU0gKzAwMDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiBG
aXhlczogZDRmZDA0MDRjMWM5ICgiZW5ldGM6IEludHJvZHVjZSBiYXNpYyBQRiBhbmQgVkYgRU5F
VEMgZXRoZXJuZXQNCj4gPiA+IGRyaXZlcnMiKQ0KPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGMuYyB8IDQgKystLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gPiBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gPiA+IGluZGV4IDZh
NmZjODE5ZGZkZS4uZjdiYzJmYzMzYTc2IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+ID4gPiBAQCAtMzcyLDEz
ICszNzIsMTMgQEAgc3RhdGljIGludCBlbmV0Y19tYXBfdHhfYnVmZnMoc3RydWN0DQo+IGVuZXRj
X2Jkcg0KPiA+ID4gKnR4X3JpbmcsIHN0cnVjdCBza19idWZmICpza2IpDQo+ID4gPiA+ICBkbWFf
ZXJyOg0KPiA+ID4gPiAgCWRldl9lcnIodHhfcmluZy0+ZGV2LCAiRE1BIG1hcCBlcnJvciIpOw0K
PiA+ID4gPg0KPiA+ID4gPiAtCWRvIHsNCj4gPiA+ID4gKwl3aGlsZSAoY291bnQtLSkgew0KPiA+
ID4gPiAgCQl0eF9zd2JkID0gJnR4X3JpbmctPnR4X3N3YmRbaV07DQo+ID4gPiA+ICAJCWVuZXRj
X2ZyZWVfdHhfZnJhbWUodHhfcmluZywgdHhfc3diZCk7DQo+ID4gPiA+ICAJCWlmIChpID09IDAp
DQo+ID4gPiA+ICAJCQlpID0gdHhfcmluZy0+YmRfY291bnQ7DQo+ID4gPiA+ICAJCWktLTsNCj4g
PiA+ID4gLQl9IHdoaWxlIChjb3VudC0tKTsNCj4gPiA+ID4gKwl9Ow0KPiA+ID4NCj4gPiA+IElu
IGVuZXRjX2xzb19od19vZmZsb2FkKCkgdGhpcyBpcyBmaXhlZCBieSAtLWNvdW50IGluc3RlYWQg
b2YgY2hhbmdpbmcNCj4gPiA+IHRvIHdoaWxlIGFuZCBjb3VudC0tLCBtYXliZSBmb2xsb3cgdGhp
cyBzY2hlbWUsIG9yIGV2ZW50IGJldHRlciBjYWxsDQo+ID4gPiBoZWxwZXIgZnVuY3Rpb24gdG8g
Zml4IGluIG9uZSBwbGFjZS4NCj4gPg0KPiA+IFRoZSBzaXR1YXRpb24gaXMgc2xpZ2h0bHkgZGlm
ZmVyZW50IGluIGVuZXRjX21hcF90eF9idWZmcygpLCB0aGUgY291bnQNCj4gPiBtYXkgYmUgMCB3
aGVuIHRoZSBlcnJvciBvY2N1cnMuIEJ1dCBpbiBlbmV0Y19sc29faHdfb2ZmbG9hZCgpLCB0aGUN
Cj4gPiBjb3VudCB3aWxsIG5vdCBiZSAwIHdoZW4gdGhlIGVycm9yIG9jY3Vycy4NCj4gDQo+IFJp
Z2h0LCBkaWRuJ3Qgc2VlIHRoYXQsIHNvcnJ5Lg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+IFRoZSBz
YW1lIHByb2JsZW0gaXMgcHJvYmFibHkgaW4gZW5ldGNfbWFwX3R4X3Rzb19idWZmcygpLg0KPiA+
ID4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlcmUgaXMgbm8gc3VjaCBwcm9ibGVtIGluIGVuZXRjX21h
cF90eF90c29fYnVmZnMoKSwNCj4gPiBiZWNhdXNlIHRoZSBpbmRleCAnaScgaGFzIGJlZW4gaW5j
cmVhc2VkIGJlZm9yZSB0aGUgZXJyb3Igb2NjdXJzLA0KPiA+IGJ1dCB0aGUgY291bnQgaXMgbm90
IGluY3JlYXNlZCwgc28gdGhlIGFjdHVhbCAnY291bnQnIGlzIGNvdW50ICsgMS4NCj4gPg0KPiAN
Cj4gQnV0IHlvdSBjYW4gcmVhY2ggdGhlIGVycm9yIGNvZGUganVtcGluZyB0byBsYWJlbCAiZXJy
X2NoYWluZWRfYmQiIHdoZXJlDQo+IGJvdGggaSBhbmQgY291bnQgaXMgaW5jcmVhc2VkLiBJc24n
dCBpdCBhIHByb2JsZW0/DQo+IA0KWW91IGFyZSByaWdodCwgSSBpZ25vcmVkIHRoaXMgbGFiZWwu
IEkgd2lsbCBhZGQgYSBzZXBhcmF0ZSBwYXRjaCB0byBmaXggdGhpcyBpc3N1ZS4NClRoYW5rcy4N
Cg0KPiBCVFcsIG5vdCBpbmNyZWFzaW5nIGkgYW5kIGNvdW50IGluIG9uZSBwbGFjZSBsb29rcyBs
aWtlIHVubmVjZXNzYXJ5DQo+IGNvbXBsaWNhdGlvbiA7KSAuDQo+IA0K

