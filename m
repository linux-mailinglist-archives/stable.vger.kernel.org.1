Return-Path: <stable+bounces-120195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4856A4CFD8
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 01:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277767A5562
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 00:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EE6EB7C;
	Tue,  4 Mar 2025 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nh4i4ut+"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B807A92E;
	Tue,  4 Mar 2025 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047445; cv=fail; b=BKSrUnPHHCd01/wdX3UM2LdRzjG1VVLBqkty6NalcXXU6PfApC3r6rcrg8IaDUYHqiFn9EWEXRqBsBhQHYcW+dvqrTo2lfOxu90sVVSHOCC2ZB2HQ0qeTEFnpeTucFT7mteKNiV0qiSa1QIMLzQoGz4LXmgs13t1pIMX84NOi90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047445; c=relaxed/simple;
	bh=AhDpt/gbUHxDqS0kr21v9tf67t67Myk0Pyb76T1bYfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3R/l7wY/rk9NYFR8rxixLvnPBo4E3QxEKOl0XeICAtqqinEXxk34qQ+ispira6kMaUi/BjQBfxue0GFTt7C/HNf5rGT/EkqvrDm7DHkQf6HNXayQ9/bfIqFkDeAB/r1GJC3gq9IfZLNXFc4xTWA0tTAvopJPlX3y0Kp1bHu83A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nh4i4ut+; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl48HyfP2x1KGzX87HiEE12BWsdxfvfN+ukNwrr8F6ST1W9N5pveiT+0MBUslWYLmTQNhQQKFKpjW2QvS2THywZxW9xoVwZsPYp+zdvvez/MRbcmBJYUXXfeogDG1Ho6yc2iFwNH+QIvfuErKj7vxoJi8fPAIgEGxrNDWSUqET0fW5SV/vnnm+BmzzzEh8ptjnUAdnZerPuejnkJZoiLZZIRQGtL/vTjEil0/uHcs91hNmRwIFTxnnFLuCI0O+RIz3GcHsxc8CigrzkoiHeumGRUmJlU8fgPxh0g+gL0+NNX8NGMHotRHH/+ptgGQcIwrEnS88ax4Om4bAhYnJdn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHZNPLsTcmf8Jd/WWkaI9jf8sEwDXn4SIfT4rmn/nbg=;
 b=puDeuwTJwUF9zI29Iis10Au/NFemRsvn3I+pOz2AJN2TwOQ92XLHg92hvK62tlvQI3ZTTDs90ASbMjK2dM1aXd6E1QM1xp41mBjaS53LJ6Bp20dUJOXsSflCzYHg8xZoxGLi734J+WG7uqBkXPJXPVGczvW7XjS1AI3tU9djKSmOJ2DYBzQ5U8H3d2w5vfL9sKW9WkU5hi3kzq0jVgrTc97V1Dr5JB0acbPKNBGLNuOsn+jJtoV5Rj39WRi1g9mRR64WlibHsSAkIxmFsZ9WlAESGYwzYpTU+ZGZukrYm4lpzsxHR8J42ixyg1UmTwuWXmEMssiMP9DqdkQXaYJlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHZNPLsTcmf8Jd/WWkaI9jf8sEwDXn4SIfT4rmn/nbg=;
 b=nh4i4ut+fgTKY757EvX4e9YZAzHns9vR5QOQpiU38jmt2l+5AxaXAhh1gjMXHNaoufkgp7pzYWRqsCethWyKfRR9m7AFvughMsD0PJBaiMVhbfXIXFvnMe5VfTzSb/GcrUSyfyEXeRoSx6N6WHCkIeWZW8jK+yEcfS54p5aJNvwfL2sr5CdoU427BO58jB+52oGifgD2v9cUdh8i/tI3p9rxgPTYqCbxBvkPT4WNcNlNEyr2PHnngu2XXwC6VN9RqbQhMlBckQsXD6aDUjMdjGjfxjqyB/jdKHovpM8eXrmut/n5CcCNoEq26GGPlAuduqpaRA6xvKgzyIJE2soMzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 00:17:19 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:17:19 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata
Date: Tue,  4 Mar 2025 02:16:28 +0200
Message-ID: <20250304001629.4094176-3-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304001629.4094176-1-andrei.botila@oss.nxp.com>
References: <20250304001629.4094176-1-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::38) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 867da228-21aa-4152-cc86-08dd5ab1ed84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDVsdFBvZkd2aVBldDhFOHVlemZ1RDRSOGZ2Y21qRkN3UUFnbHgzUlM0Q0xW?=
 =?utf-8?B?TlVRcHpsc0gyVXpSUTJGNW5Dc2dkU3ZvS1RHR1FZUk9IR25ON0MvQlp5WHhW?=
 =?utf-8?B?Y2VhNDBxQ2p3akhjWUNpY3RpWmw2V2NpVlkwU2xraVJIaW1IOXp3ci9SRktu?=
 =?utf-8?B?WEhWMEVma1pkdjA0dlIwKzAvMXJ1WElMWkYvQzRTMnVmTnpXNkJNdUR4TWxJ?=
 =?utf-8?B?TzN0L2ZuWWVPYk1VR2tMcWs4aXd2K0RTUzBZbDJZN3FQYVFBdGFxUmxUUjZL?=
 =?utf-8?B?K1lXbFE0ZGg0UVFvVmxBbTdRWGJqYTVmR2dNci91K0VNd1NSRkVtQmN2K1Ux?=
 =?utf-8?B?enVpRGZoR1dSc3FkK0s0TDlpOHlkUFpiMW5IZFIyNSsyK3FsZEVkZjRXSHMv?=
 =?utf-8?B?TTZQRjFJMm9mQTF3TTRlTmlpY1ZWc0dLV3IwSFJHUVpoSTNTK29mR2pqVDM0?=
 =?utf-8?B?Zkgya01qT3dVZDBJQVhCMHVmeFhtNk5zK0JiNEprMkJKZlNza3hCbFRmd2pQ?=
 =?utf-8?B?NHZuVVR5ZDdBcmJSTFo3aDg0ZGxhSDlaNjVkSG93NmsrbmpFblRTdE5FdWlF?=
 =?utf-8?B?RVo1WVVDL1VOV3JmN3dyWnljU1pNcU1KQ1dkcDVZNnpvT0o3N1VQb3pqME5r?=
 =?utf-8?B?dElXb2JSYlI0WU1PaVFpMyttdStqc1RGK3pQOFV6cUZoMXd4clN0MVkyWU5C?=
 =?utf-8?B?ZVhSSjR1VlJiSy8rWnlTeUFlanJIUFdOL2MyN0pqRmxQUUVmSkszU1hWaEwv?=
 =?utf-8?B?SFRQQkJ5K0N1eElNekhXckJTM3J1a0NjSGtpMXRCUk8waXZlQXI0VmVpd241?=
 =?utf-8?B?R0xRNXpqcG5WeEtQaU5la1EzaVlVWnRrTVVnbSt1Ykh1Mkw4MjhsbHlLajZC?=
 =?utf-8?B?cUI1aVhYUEVTYlBxdkpkU1NLYy90TFJlU3huYStramljUGFVVVprVzVzVHkx?=
 =?utf-8?B?OGxzS1Blem0yL1VaOTJiRFE5V3E3ZXA4d3doUjh1QXU3YzA3TUFxeXZET1Zo?=
 =?utf-8?B?dG1OTTA4V05sbkkzOUtxZjI4QUlWUUFoTFd0c0VRYnVCa2J1VS9pNy9BSHB5?=
 =?utf-8?B?ZElYQ0ZFKzVadGFJYk1KQnBHS25mK2Q2eFd4N0xqTTBPSDNOMnpCL1NsU0NN?=
 =?utf-8?B?ZjhHa2RKTG5WZGtvYnVETnIzY1dndlJyT1BxMEpYSS9MbGhTdVY2Mjh5bWFT?=
 =?utf-8?B?STM1eC8wYkR0TjdVRVQ3L3NTSm5ucXNhZWNEN2s2akZlaGRIMm0wK3IwVCtY?=
 =?utf-8?B?K25zclBTRVhHZmtUQTJ4dWxwbkdZR1NManpnbHY1em02R3dMQlVZUVhKdGcz?=
 =?utf-8?B?K3BCMlNKV21HMFJJeFdKVFdGUUdUSjBKTlg1bjlTSjNMRHVFQ0lzSTgrakZl?=
 =?utf-8?B?U0I4SkY3TFE1STExalR3bUhjSEd2WTlnSzV4UW5SZDE1VUFyUnZ6VmdsTXo3?=
 =?utf-8?B?RG1BWENLTERmK3lwUG9kRjJ5Y2ZkaTJqUDQ2M09SK3FjZW5qV2NvRVByL1Fi?=
 =?utf-8?B?ZTdua1JzWnBzbnBTSFdiUzljVlVwK2dwcDdZQ0RmV1Q3a3hsTlZoK2lrMmlY?=
 =?utf-8?B?NmpxdWMzb1R5bGk0TVZucHlCdDdBWUVCR1VuNUZKemh6ZEZRWWEycDBVV01Z?=
 =?utf-8?B?VWN6U1VXUGE2Z3J2TnpCVnAyLzMxQnJwY2RmaDFkTmpCaCtGUzR3c21IVTBO?=
 =?utf-8?B?dERDRzF3TFBtS0VkZ3pSL3doUXpjSWNMekY5dWo1bk9XSThReEpIZVhweTdE?=
 =?utf-8?B?Q3MyT3BCZ0NyWXZsaU04WXhhSHIwUUVzcWgzZDNDM0xFZTUzUnloS0t3Nlho?=
 =?utf-8?B?MTFKRC9KYzUxQUlRQy91bWNodWw1UklhQlkra3JkVjVQQ0tHQWpIM0N2MlZn?=
 =?utf-8?Q?BbW155dRVYB6G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVvaGdaYVlua2s3MWl2UVBMbENPV05Lck1vWGZyZ2UxVmxMRkFNR0NsNkhj?=
 =?utf-8?B?d083R3VHVTdrdUtxT2xZL2sxb200VjFUbWE5N3I1c2pZUG5WNWcvZmpySStC?=
 =?utf-8?B?SEM3ZUZ6UUJoNzRuaWg4UWt1RnNtR2JCWjIyN0t2UE83N1hsMnFFS3N5eVg3?=
 =?utf-8?B?elY5NjFGN2p4L1RWQkVoRnVjLzdQYytCYXVQZDZqWFRUbUZ2Q0dSRDFrYkdZ?=
 =?utf-8?B?eFI1eVhwdFJCaE1zRE4zR01tT1dRbWErY2hzMmErUW1ZWkhzRWJKTnhzYWRS?=
 =?utf-8?B?UEhUVGFkeTZtd25rTFlvalRaODhiUHN5Wm9hOXJZZFdNMHZrdHpLd0I3czBu?=
 =?utf-8?B?dVF2UEJqZ25idThsWHB6YkJLUE5UT1lYNlpWYzRYWEk3VCs1dzIybUs0ejlM?=
 =?utf-8?B?M1FyVFNUVmRXZzJkN1Qvd3NBM0pWNWVuZnBha2h1L2VTSE10aGxtS2tlc1gw?=
 =?utf-8?B?aERsOVgrR3M2WEZ0V0dWR0FxNko3WlcySFV0cDFhbUFJWG1tSjNQL256REta?=
 =?utf-8?B?S29vMUlBUDNHS1pYV0ZXOEFpcnc1aFdEcGJwUXF0aUQzcWpmKy9ic005SFhU?=
 =?utf-8?B?ZVI1cE4zS2xKdCtHOHRvMXZWVmU4clY3UlUyOEpjUlFUMFh1K1BranpMWHN1?=
 =?utf-8?B?L3h6a0JkQXRLakhEOE0xd2xaeTFzNFpkOU9KQzZscGFlTkVKK1hiUExCNUhT?=
 =?utf-8?B?cjArbG9Qakw5N2tKZkZWblVLOFVYRTFyVnc2RWlIV0hsc2RDWVA3WXNUeFRU?=
 =?utf-8?B?d2I4Y1ZsS1ZoaThCZnZRbytPc281aVVCMGQyVllzdUZHbTFxWmJhb3lDT3Qr?=
 =?utf-8?B?RlNHQ1hPSG96Skg4QWoxYnVocDloWnpGZHJyNTJvUkJEYkcrdVJTQldrbTFD?=
 =?utf-8?B?UWFpWG12WHNIU0l1M0V1ZFZuNVJzTmJaeUlHM1lWSTNSMWswYUQ5RVhnMlIw?=
 =?utf-8?B?VG5PVk13ejFRdmhFMktxMzJuVDJUckw2bktyckVHeGgrVFhpTElERmlvVHl2?=
 =?utf-8?B?cVJSTkNHMHEvL3VFQ3pjU2JaVFdlTHB4SzVJeTB5dkZXcG81L0trYUphRW1k?=
 =?utf-8?B?ODdack9BbFZHc0p6WGxzY2ZoZ1d2MTh1MVlCWFZoTS9rSEo0UU5aaVczYlhu?=
 =?utf-8?B?T1J5VjhlRVlQV2tIVW1wQ2VyMko1UFNrZHpCNlVGUHVxOUR1cm5oNGFNeklu?=
 =?utf-8?B?YVFWNm9wRXZFY1VGd3BJYkhPVkh6QVBOYjlaeUR4OHpGTjFjM29Ed3JmcG94?=
 =?utf-8?B?SzcyUjFyM2g3ZXNpQWlPZW5lcHU3MHp2d0pnWHo4TklWT3ZNcjRFTFJkNXpw?=
 =?utf-8?B?dzZVZjhCOXZ4L1FLSG52ZmdKeE8xcFVWdW5YRlorbnpoaDA3SW5CeTdHMC9V?=
 =?utf-8?B?NDh2c3FWTTJUd0htVG9wSHdiUjlBdjVGRSs2aWx5bW92RGQvY2RXRFk0c25G?=
 =?utf-8?B?TTZPRElhNERwSyszbjY1VjFMcldhVkZ0WUJkdmNwMWIzeXRZbS9Ia3pVakRy?=
 =?utf-8?B?anRxSnB1Y2lHazU1MjQ1eGxlZ01RWGg0dUZxRVFLSDVLRnRtZXFaMFlqTkhu?=
 =?utf-8?B?L2U1RVB1endnRHlqNmtDZ002Z0hLWVdTOXhXbHdSbEJZL0JIQTRxd2xPWGJq?=
 =?utf-8?B?aENram9ZeTBvN1RNeUFWb1NyUUtzK3NOMGtuYjFwRERlUUhpblR6bDZPaXhS?=
 =?utf-8?B?Q2k2N25qc3QvaFJvZHBwTi9PVXlPSzRmVUhEWjJwUDgyQVVEbE5KVXhYRTZ4?=
 =?utf-8?B?U08xWDJnMGphSVdremRlTXdKM0JOZ0NmN3VnL0Z6d2N6cC9kc2JuLzl1d0hH?=
 =?utf-8?B?NytwbXphRGtsVU1jYUVmRDB5Y2xGOVNaK2NGRWpFdXlTUGZoVkR5cmdXc0Uw?=
 =?utf-8?B?UmZzOHkrUDhTclI1cmRUNEpyUGlGc1RDYkpVbUxMTU8rTTB0Mm5kYmtZM05Z?=
 =?utf-8?B?R290dFhXL2dHb1Yvc2cvYmhmTmx6eSsrMWJQMGlmNFJjRjRqd3JmbUxESW96?=
 =?utf-8?B?UnBVOWFTTENOYmg2QnNhayt4UzJFZGRKbGduOHJUYlB5YW56ZW9pejFGejFX?=
 =?utf-8?B?akVHNVNqL3ZaNzNKdmVaV0UySTNmZWIyUmp1aWdiQUcvOTB3VjRHMHVxVFhw?=
 =?utf-8?Q?yrKAKKzyCzEjZ3f5DvQSkv0M3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867da228-21aa-4152-cc86-08dd5ab1ed84
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:17:19.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9HEbEc56GXK+XGHtMjFmj5oc07Ahhr5/xIgc2IE1ia+7NoPIRbqdksp0h5KdiJHQgmTnr03OjBjGVs+Q4g6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763

TJA1120B/TJA1121B can achieve a stable operation of SGMII after
a startup event by putting the SGMII PCS into power down mode and
restart afterwards.

It is necessary to put the SGMII PCS into power down mode and back up.

Cc: stable@vger.kernel.org
Fixes: f1fe5dff2b8a ("net: phy: nxp-c45-tja11xx: add TJA1120 support")
Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index e083b1a714fd..d142e0a02327 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -114,6 +114,9 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SGMII_BASIC_CONTROL	0xB000
+#define SGMII_LPM			BIT(11)
+
 #define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
 #define EXTENDED_CNT_EN			BIT(15)
 #define VEND1_MONITOR_STATUS		0xAC80
@@ -1598,11 +1601,11 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 	return 0;
 }
 
-/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 */
+/* Errata: ES_TJA1120 and ES_TJA1121 Rev. 1.0 — 28 November 2024 Section 3.1 & 3.2 */
 static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 {
+	bool macsec_ability, sgmii_ability;
 	int silicon_version, sample_type;
-	bool macsec_ability;
 	int phy_abilities;
 	int ret = 0;
 
@@ -1619,6 +1622,7 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
 				     VEND1_PORT_ABILITIES);
 	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	sgmii_ability = !!(phy_abilities & SGMII_ABILITY);
 	if ((!macsec_ability && silicon_version == 2) ||
 	    (macsec_ability && silicon_version == 1)) {
 		/* TJA1120/TJA1121 PHY configuration errata workaround.
@@ -1639,6 +1643,18 @@ static void nxp_c45_tja1120_errata(struct phy_device *phydev)
 
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F8, 0x0);
 		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x01F9, 0x0);
+
+		if (sgmii_ability) {
+			/* TJA1120B/TJA1121B SGMII PCS restart errata workaround.
+			 * Put SGMII PCS into power down mode and back up.
+			 */
+			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 VEND1_SGMII_BASIC_CONTROL,
+					 SGMII_LPM);
+			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					   VEND1_SGMII_BASIC_CONTROL,
+					   SGMII_LPM);
+		}
 	}
 }
 
-- 
2.48.1


