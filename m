Return-Path: <stable+bounces-219595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPsjKazpnmk/XwQAu9opvQ
	(envelope-from <stable+bounces-219595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:23:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083B197397
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC289303748D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513893ACF06;
	Wed, 25 Feb 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WaXKpFf1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D203ACEF5;
	Wed, 25 Feb 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022185; cv=fail; b=QCyKMUpDTx3+YIhju333TF9U07r0fxIsUrOP8motbQQyxe7i0fQv6ARZzeuRXM9GTK4Zqmdm6bOSCmiHAd6MbCjVIBFXQ3h+p6vcYnd4fiID9qbU8TSMXUaRwhqGrybl6qEo2HDjekNk5htg1a/LfdTdSg6uXOibElIvkdchUIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022185; c=relaxed/simple;
	bh=7D4hbXFiMnUTOf6R+Y5ry0Fm8LpUjiVWz0TQED9I+YE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFTUwKjgY7BpG8gAbZVLcE9x2IZ/FwmC1IM+vDAjJPTnPALv7f+p8IV2fEpQGZnYfZLfRhE1BQXJ7vL6il7+bPjq1n8mKeOfoApjPyXUGWLizyBKfRvTmvPiTKU8ST1CD3fPG75lton2Oo1XigbrHx2Cp5O57B6fCRpDgNaiijo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WaXKpFf1; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OMGVhm1089092;
	Wed, 25 Feb 2026 04:22:53 -0800
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020122.outbound.protection.outlook.com [52.101.85.122])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chmmn9kay-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 04:22:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPZSVjUwZnidPF+uex6CzAiDwsCUk4Cia+cwfA61RC8pRPWashDJL0GFRXOkB/GwPIn0+8bJxW40m/sD1W9tNhslsBKRITO5iJLrIi44AWqEcizN46bv857zuZkfUdhzGixpyg9V+zfL0osr8Fga0KmumOaknQv5przNU/Rs5Z8zXC8GDPcY8aH81D7f3XKCc6X4VU1uc1VAbv9TbIJ+80WJ+T4kQAMRHlhfmDWlWDsMVXMkrnJNsEFlLwCQDGvyjbY6aduKM5T/O2sS6i24KgGGmHN7C5bIBIwSKy4ee/OExoD/urcse7vEIrGnrcFlVhw9X8UDQ+LIby5I1NDQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4hbXFiMnUTOf6R+Y5ry0Fm8LpUjiVWz0TQED9I+YE=;
 b=EU44NwwejzOD5xQjqhzuK3y39SO+GJfNgvx/57lgSlvN1TP8XOOMinSUJS0V+Rzp6V7qmewQOfdhVS2R2gdwGFEYy9AnpGgVuWwDCWi1IQdN8OIAHABHz0be/KXaikOc/PFIyQLBfd9xmQN6k4wYmDFyi4l0wEyk9qdi3DCgkXE85o1gYuMuU14pIk9+wDQleyFX02tT6SGVL6p2ClRl/YeCzflSJkonap7hqotYYCU8KoN1F135+8kf1cs0JhzBYG8ETwN2XVnrZh+//dypaRIRK3HQ68IFexH1GxmF11UOpTI44OXCeyuT8PJyJGvTVKqSo7eYkCVZvsNM/697zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4hbXFiMnUTOf6R+Y5ry0Fm8LpUjiVWz0TQED9I+YE=;
 b=WaXKpFf1WsZcfGyje0zX3rAhUFPi67gM6eVO/vg26iMGo52FgYLJmsFzBQUmNdx7QsmLf87eBKEFWMH18cq+SnvAGllxgitsq9AbiyresGdzZWv1vh2D9nQ2DGm5OU+tCfqaQGunkqeYvnXvDrrdzZ8qWIkWQ1y6TEx0NkMt1v0=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by SA1PR18MB6068.namprd18.prod.outlook.com (2603:10b6:806:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 12:22:50 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 12:22:50 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index: AQHcpVsOKxOBWB2/y0CrIf5i5ji46rWTMV0AgAAk+IA=
Date: Wed, 25 Feb 2026 12:22:50 +0000
Message-ID:
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225050154-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|SA1PR18MB6068:EE_
x-ms-office365-filtering-correlation-id: 45ca508c-7699-4dfe-1e13-08de746897f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 ZvLHxxrXfST/eyEMBdD382KAPJw6SKdmTG8+A3AtbNsr9qtHPlaGSo1Yfu4BChm7dP/X6STrQ0tOGY9L1PxpZOu6iieSeO+mnDaogTw961j4tjtlBko7WaiVtJMVZc44yP+/5GEYNh9fHbeZAT3Y3w+56wPeAPHpu0PHYSRkInnhHGsip0B8/wdQU/Z1GeK7vSwbyK6BV9JGtl0o6JFb2htd19p0J8lfzPa2U16uupegfUc1/m7jPAIrDhYvNw3E7fBV+SDZQOtYNzSpinX+WotPr9zoiV33cDFy/m8EOP30bGcHhGVyn1oxwKdDueTzoljLK1gAx+J6Mg3sjeiA+RgNapP5fMnW3t55/2cJeh6yE1HXpwtLgkEQiAXLhx1aNDEGwB4651r8jtfUogxs8jjHJ4pHqdtFDq2ASKHWIEAt2iFfx4CMrQEYMkazEwYrQtfskybYbox+6rYKkOsOjTyubbBbE6hh/DKEfV8IuTdyOzwLp/olx/Mygy6rF0JmyqC93BE1pL5uTTTojqG5EVGtKCMvu1ky5Qve3AiUXSm1EUPsV5pAnuuGmFQl96VVSQQ84Q26TDrOlVPt1KJEJDQsiRcUL395e0iZdbEPlYxJYHYt4vtuxXvgvCN2zPwX8V6nDFqmXGPamrQict+B45zKg6xGv0VuaYe7rAqY+zQukfGBDolr3J7qU02sPZScdFT/8rPJfFnIZby4XqTVqwXGYXzz+AUV9JaxNWx1G3Rh1fleRvoF6Wywi9az5JnQ80V4p5jZLDTF601hmxFkizRrhQW/+RnetV7VtEQfNr4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkk4a25ZdDNJUmZSWDBsZnVWVGMyMmhBOWplM0FoQ3JsV25nNUh2TU1LK01G?=
 =?utf-8?B?R0VkbHlSZVo5ZENmSnl0VnBvNklTQW1uMTd3REovQnR5NEQyNExHd1oxaHBL?=
 =?utf-8?B?OExXWGRiaEJQc05GU3hTRGlRMDNDUUlrampqWmlMZ1FJM2Ntd3g1R3gyVEhT?=
 =?utf-8?B?c0U3T3MwVlM2Z01lTHBFS0hlTUNoWm1LKzFLTWdDeUtNaDNXK1RKWDRyTURj?=
 =?utf-8?B?ZzlWc3pXMS9jNm9nTy9MKzhITjJwZ1ZlMGQ0dms5V3VRcERncHFKMy9sOVQ5?=
 =?utf-8?B?M0V0Z0RsazBtdFF0QWMyK3FCZkgvNUMzbTdFZzZxUXEraTZ0dURIY0Z6ZTZ1?=
 =?utf-8?B?QXp5NDBnYjRHcjNzNEtQUWI4SE5HTmttN2ZzUlBlVkxSSjZZeDd0SU5ib09l?=
 =?utf-8?B?RHh0NGxVQ0tXRXo2NmQ0QjFQU0lxVWZySmI3eXF3U2Z4aEpRTGpKZ1lwWlMy?=
 =?utf-8?B?Zm1FTzF5dXJXcDNuU2dnMS9ZeXV3dHhhcnpwRFluTDI1U09aMzlzU2RNYUpD?=
 =?utf-8?B?QUlwRVJaU3dVU0dqcVlPUUVSYzQ2N2EySTVQNHM1WnZqanM5Q0I5clRIUWZt?=
 =?utf-8?B?Y0Q2M0lqdXZ5dXEyT0RuL24wWEdXQ3krMVY5ekZhOVMzRVo3bW1UNHplZ0E1?=
 =?utf-8?B?b0hYWFBIakZEMU9leGd0eFBQQm9KemUydWI3SysyaDR0OU10cWFITWp1elJ5?=
 =?utf-8?B?cUlodVNmdU93akQ0SXVialkrQkRKYVNFNWNJODExSGRaRGZqdjY2MzlJVWpK?=
 =?utf-8?B?SlVFY1ZoWWpBNmM1SlMvNTZ0NE50OGJFbXdXYS9nSk8zbjBFTFNaYmZqc0ph?=
 =?utf-8?B?UlgyRUJtZk0yQy9nK3dQYkJCVEkyVGFXNEZ5d1VNMGV5dUVQMkh0YmhTSDF1?=
 =?utf-8?B?ZzBycGdHbGg2QytQeHRXdGtnd05VM1A1Q2ZyK2J1UVFPUFkxYVFkTi9YbHpl?=
 =?utf-8?B?c0pTbHh3OThURkFNVEoyUjNnLzVOcnFEYm9LRjJjNzlXeGhOU3RWekh2S0FQ?=
 =?utf-8?B?RkdIbGFHNkprb2pkOG93SXMyU1owMDA3QytxZitYU25LS1JUcEl3cURMMzFT?=
 =?utf-8?B?QjlOdE1NMEs2T054N0k3SW56RW53OUtGRU0vV0pDaU9iY0VuOEFkbW1PUVcr?=
 =?utf-8?B?WUszTFQ5VGpNbTYvcHh4SmdZVTVpU2NML2NnZ2M0V01KQkdrY2t0NlFidjFh?=
 =?utf-8?B?MXhPZEdKTlNYQkhXR2tpaStlVFloZFRUYzJ0eHRjVW53MWVoWDg1eTc1YXVS?=
 =?utf-8?B?Unh0TDJLcm5WQ3lVdzNsTi80dE5ZOHl6N0xyU3RRanMydnZ1QysxaURZK0JB?=
 =?utf-8?B?K284MmdZVnZ0NGJZNGlEU3BDRm9pdXlicy9mTlB5UzN4aDZGSzdwd2dibVFp?=
 =?utf-8?B?SWlQZGI1VFFuR2xnUzg0eEVOUXRRQXdUWlBKckVseUVrdFk0TitnNTJHS3E1?=
 =?utf-8?B?eUxIaXdGeDJIUWZjNVhPdzdyY25RZCtiY1N5ZFJuQWhXVzJyY041dlB5c0lN?=
 =?utf-8?B?NmVIUmdkRVdrK0J2ODZ2KzZHRHdHYUVMQjVaQktHaEFPcjZOQ05vckdEeFJt?=
 =?utf-8?B?WGxxQ0h4UCttQ1QwazQyYVJacStYQlc1dVBBMWUxcWZtelU4WjQrcWkzTWhQ?=
 =?utf-8?B?bDJXb2pObnplR3NNUDQvZlZ5c1RPTnk4YnlzMFhKcGxQL29PQjg0QkhnMWJS?=
 =?utf-8?B?NlUxaXJIbjhneUtRTmZ1SEo0NUFRYjRVUVNiSDZiU1hhbGY0RlhYUWJNdlJJ?=
 =?utf-8?B?UkxycmM4S1VVbTAvRWVpVVBHU3FtanhEbVV6QTNKUXdkQmJjWG4ySGluUmlp?=
 =?utf-8?B?L0NFSDFRNVQ5bXRQdGlGU2VPNDUzdmxlbTlndlkxZWY0UmJJdkkrWFg4QjNX?=
 =?utf-8?B?Y2cxUVZ4Ym5RYkg4MWZPOE9Sa3J2Qkl4MHVLcE81ZHp6aGFTUi9JRlg1ellO?=
 =?utf-8?B?QnE2OHAwdVI5bFI2dkZyK2dML3J2bjZpVi93T3dhK3UzdEJXQWNzcUFnV0tz?=
 =?utf-8?B?S0kwczZzcUJWcDczL1VFK2FETkw2VEVIcGhWN1g2aWtEVVpCU3o3dnZOS0x5?=
 =?utf-8?B?NVFEYXhBbGUxTW9Ed1hjbml4a1VJUnI1R2EwOU1UanBVa2kzMVg0bWFTWXJy?=
 =?utf-8?B?RDVrVTAyU0lxeFcxOWhMZk91eVAranYzSDhoMHoyRXRwUHBKcmVmN1NNOEtP?=
 =?utf-8?B?TUJhWERSMjRScVFNRC8yWnNUZmVuZzU2Q084L1Fmck5qL1BiQnlCcS9ML0xr?=
 =?utf-8?B?TVVxdjJ4MTRrelE2aUdReWhZRTZDZk90bWRPaHdqd3kyb0ZTRFFsQmxkTGVh?=
 =?utf-8?Q?1lixQq6PT/IgrDWCGk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ca508c-7699-4dfe-1e13-08de746897f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 12:22:50.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaI2jiIhOgoZQRdQ5t0+lIP7gacKpLrSWm/hH0dMXtjl7SvWnTJTNFSZkB3dTVTANhmuHFHYoDt/S72OhzwcjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6068
X-Authority-Analysis: v=2.4 cv=KrJAGGWN c=1 sm=1 tr=0 ts=699ee99d cx=c_pps
 a=Qdo7Ea4lwGWRD8/XiwST5A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=8HSx3qUl58l0xsFJnJMA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Vph0MQMAW5UWe2GMvmFm188DBpq1yy6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMSBTYWx0ZWRfX1btcTmTGrM0v
 WP0b0hQqd/wBP6kwFfRW/54TYJrnSH6kcJlBuN4Dh8TXpYaRA5O8IjOHEfAPfvdbMbU2bZHwC7E
 SKRq9H4+RMnoimxTRf+w8yK6av+QCAwb9MaJ1W1mmcadplNk3ZWuGViWAI/ZlHu4W6K/V0t2zbU
 4OTiB3LmEcyO/w3Jroj02O3T364GiBjwxMfKuaqwOiHI2HjCcdREoML+ezBtQcnOng41oP4RFRt
 iSXHf/yS3J0g8TIpthbXo/yLqHEjoYtvB3pNMlkXbX9Ynnt9ZTlJEdEpQEOfu7ZjEMVw43t9SSX
 OGSKjTvwUUuLwd+m3gikruByPXqiwhqpoFkQSUb5vNUjbAKbJY7Id0EETZ+UuvGAyY/je5etEN9
 Ws95MoxlAQW0XxaIS6XHpZVpAyuIVIoTQlU18pnqlRqmT9ol/+xdQwffbqnjR0IACLgnAp9KKOU
 6ibZudFzqdimLmbC/fg==
X-Proofpoint-ORIG-GUID: Vph0MQMAW5UWe2GMvmFm188DBpq1yy6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219595-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,BY1PR18MB6374.namprd18.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2083B197397
X-Rspamd-Action: no action

PiBPbiBUdWUsIEZlYiAyNCwgMjAyNiBhdCAxMjoyODo0OVBNICswNTMwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiBSZXBsYWNlIGhhcmRjb2RlZCBSU1MgbWF4IGtleSBzaXplIGxpbWl0IHdp
dGggTkVUREVWX1JTU19LRVlfTEVOIHRvDQo+ID4gYWxpZ24gd2l0aCBrZXJuZWwncyBzdGFuZGFy
ZCBSU1Mga2V5IGxlbmd0aC4gQWRkIHZhbGlkYXRpb24gZm9yIFJTUw0KPiA+IGtleSBzaXplIGFn
YWluc3Qgc3BlYyBtaW5pbXVtICg0MCBieXRlcykgYW5kIGRyaXZlciBtYXhpbXVtLiBXaGVuDQo+
ID4gdmFsaWRhdGlvbiBmYWlscywgZ3JhY2VmdWxseSBkaXNhYmxlIFJTUyBmZWF0dXJlcyBhbmQg
Y29udGludWUNCj4gPiBpbml0aWFsaXphdGlvbiByYXRoZXIgdGhhbiBmYWlsaW5nIGNvbXBsZXRl
bHkuDQo+ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiAzZjdk
OWMxOTY0ZmMgKCJ2aXJ0aW9fbmV0OiBBZGQgaGFzaF9rZXlfbGVuZ3RoIGNoZWNrIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gDQo+
IC0tLSBzaG91bGQgY29tZSBoZXJlIGJlZm9yZSBjaGFuZ2Vsb2cuDQo+IA0KPiA+IHYzOg0KPiA+
IC0gTW92ZWQgUlNTIGtleSB2YWxpZGF0aW9uIGNoZWNrcyB0byB2aXJ0bmV0X3ZhbGlkYXRlLg0K
PiA+IC0gQWRkIGZpeGVzOiB0YWcgYW5kIENDIC1zdGFibGUNCj4gPiB2NDoNCj4gPiAtIFVzZSBO
RVRERVZfUlNTX0tFWV9MRU4gaW5zdGVhZCBvZiB0eXBlX21heCBmb3IgdGhlIG1heGltdW0gcnNz
IGtleQ0KPiBzaXplLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAz
NCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgaW5k
ZXgNCj4gPiBkYjg4ZGNhZWZiMjAuLmVlZWZlOGFiYzEyMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMN
Cj4gPiBAQCAtMzgxLDggKzM4MSw2IEBAIHN0cnVjdCByZWNlaXZlX3F1ZXVlIHsNCj4gPiAgCXN0
cnVjdCB4ZHBfYnVmZiAqKnhza19idWZmczsNCj4gPiAgfTsNCj4gPg0KPiA+IC0jZGVmaW5lIFZJ
UlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSAgICAgNDANCj4gPiAtDQo+ID4gIC8qIENvbnRyb2wg
VlEgYnVmZmVyczogcHJvdGVjdGVkIGJ5IHRoZSBydG5sIGxvY2sgKi8gIHN0cnVjdA0KPiA+IGNv
bnRyb2xfYnVmIHsNCj4gPiAgCXN0cnVjdCB2aXJ0aW9fbmV0X2N0cmxfaGRyIGhkcjsNCj4gPiBA
QCAtNDg2LDcgKzQ4NCw3IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gew0KPiA+DQo+ID4gIAkvKiBN
dXN0IGJlIGxhc3QgYXMgaXQgZW5kcyBpbiBhIGZsZXhpYmxlLWFycmF5IG1lbWJlci4gKi8NCj4g
PiAgCVRSQUlMSU5HX09WRVJMQVAoc3RydWN0IHZpcnRpb19uZXRfcnNzX2NvbmZpZ190cmFpbGVy
LCByc3NfdHJhaWxlciwNCj4gaGFzaF9rZXlfZGF0YSwNCj4gPiAtCQl1OCByc3NfaGFzaF9rZXlf
ZGF0YVtWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkVdOw0KPiA+ICsJCXU4IHJzc19oYXNoX2tl
eV9kYXRhW05FVERFVl9SU1NfS0VZX0xFTl07DQo+ID4gIAkpOw0KPiA+ICB9Ow0KPiA+ICBzdGF0
aWNfYXNzZXJ0KG9mZnNldG9mKHN0cnVjdCB2aXJ0bmV0X2luZm8sDQo+ID4gcnNzX3RyYWlsZXIu
aGFzaF9rZXlfZGF0YSkgPT0gQEAgLTY2MjcsNiArNjYyNSwyOSBAQCBzdGF0aWMgaW50DQo+IHZp
cnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpDQo+ID4gIAkJX192aXJ0
aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9TVEFOREJZKTsNCj4gPiAgCX0NCj4gPg0K
PiA+ICsJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTKSB8fA0K
PiA+ICsJICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBP
UlQpKSB7DQo+ID4gKwkJdTgga2V5X3N6ID0gdmlydGlvX2NyZWFkOCh2ZGV2LA0KPiA+ICsJCQkJ
CSAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLA0KPiA+ICsJCQkJCQkgICByc3Nf
bWF4X2tleV9zaXplKSk7DQo+ID4gKwkJLyogU3BlYyByZXF1aXJlcyBhdCBsZWFzdCA0MCBieXRl
cyAqLyAjZGVmaW5lDQo+ID4gK1ZJUlRJT19ORVRfUlNTX01JTl9LRVlfU0laRSA0MA0KPiA+ICsJ
CWlmIChrZXlfc3ogPCBWSVJUSU9fTkVUX1JTU19NSU5fS0VZX1NJWkUpIHsNCj4gPiArCQkJZGV2
X3dhcm4oJnZkZXYtPmRldiwNCj4gPiArCQkJCSAicnNzX21heF9rZXlfc2l6ZT0ldSBpcyBsZXNz
IHRoYW4gc3BlYw0KPiBtaW5pbXVtICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ICsJCQkJIGtl
eV9zeiwgVklSVElPX05FVF9SU1NfTUlOX0tFWV9TSVpFKTsNCj4gPiArCQkJX192aXJ0aW9fY2xl
YXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9SU1MpOw0KPiA+ICsJCQlfX3ZpcnRpb19jbGVhcl9i
aXQodmRldiwNCj4gVklSVElPX05FVF9GX0hBU0hfUkVQT1JUKTsNCj4gPiArCQl9DQo+ID4gKwkJ
aWYgKGtleV9zeiA+IE5FVERFVl9SU1NfS0VZX0xFTikgew0KPiA+ICsJCQlkZXZfd2FybigmdmRl
di0+ZGV2LA0KPiA+ICsJCQkJICJyc3NfbWF4X2tleV9zaXplPSV1IGV4Y2VlZHMgZHJpdmVyIGxp
bWl0DQo+ICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ICsJCQkJIGtleV9zeiwgTkVUREVWX1JT
U19LRVlfTEVOKTsNCj4gPiArCQkJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRf
Rl9SU1MpOw0KPiA+ICsJCQlfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwNCj4gVklSVElPX05FVF9G
X0hBU0hfUkVQT1JUKTsNCj4gDQo+IHlvdSBmbGlwcGVkIHRoZSBsb2dpYyBoZXJlIGFuZCBpdCBt
YWtlcyBubyBzZW5zZSBub3cuDQo+IA0KPiBEaWQgeW91IHRlc3QgdGhpcyBwYXRoPw0KWWVzLCB0
ZXN0ZWQgd2l0aCBNYXJ2ZWxsJ3MgT2N0ZW9uIGRldmljZS4NCj4gDQo+IA0KPiBTbyBpZiBkZXZp
Y2UgaXMgcG93ZXJmdWwgYW5kIHN1cHBvcnRzIGEgdmVyeSBiaWcga2V5IHNpemUgdGhlbi4uLg0K
PiB3ZSBkaXNhYmxlIHRoZSBmZWF0dXJlPyBob3cgZG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQpUaGUg
aW50ZW50IGlzbuKAmXQgdG8gZGlzYWJsZSB0aGUgZmVhdHVyZSBvbiBjYXBhYmxlIGRldmljZXMs
IGJ1dCB0byBlbnN1cmUgdGhlIGRyaXZlciBuZXZlciBhZHZlcnRpc2VzDQpzdXBwb3J0IGZvciBS
U1Mga2V5IHNpemVzIGxhcmdlciB0aGFuIHdoYXQgdGhlIG5ldCBkZXZpY2UgY2FuIGFjdHVhbGx5
IGhhbmRsZS4gRXZlbiBpZiBhIGRldmljZSByZXBvcnRzDQphIHZlcnkgbGFyZ2Uga2V5IHNpemUs
IHRoZSBkcml2ZXIgaXMgY29uc3RyYWluZWQgYnkgTkVUREVWX1JTU19LRVlfTEVOLCBzaW5jZSBu
ZXRkZXZfcnNzX2tleV9maWxsKCkgZW5mb3JjZXM6DQpCVUdfT04obGVuID4gc2l6ZW9mKG5ldGRl
dl9yc3Nfa2V5KSk7DQoNCj4gDQo+IA0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gIAly
ZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTY4MzksMTMgKzY4NjAsNiBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UNCj4gKnZkZXYpDQo+ID4gIAlp
ZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpIHsNCj4gPiAgCQl2aS0+
cnNzX2tleV9zaXplID0NCj4gPiAgCQkJdmlydGlvX2NyZWFkOCh2ZGV2LCBvZmZzZXRvZihzdHJ1
Y3QgdmlydGlvX25ldF9jb25maWcsDQo+IHJzc19tYXhfa2V5X3NpemUpKTsNCj4gPiAtCQlpZiAo
dmktPnJzc19rZXlfc2l6ZSA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSkgew0KPiA+IC0J
CQlkZXZfZXJyKCZ2ZGV2LT5kZXYsICJyc3NfbWF4X2tleV9zaXplPSV1IGV4Y2VlZHMNCj4gdGhl
IGxpbWl0ICV1LlxuIiwNCj4gPiAtCQkJCXZpLT5yc3Nfa2V5X3NpemUsDQo+IFZJUlRJT19ORVRf
UlNTX01BWF9LRVlfU0laRSk7DQo+ID4gLQkJCWVyciA9IC1FSU5WQUw7DQo+ID4gLQkJCWdvdG8g
ZnJlZTsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+ICAJCXZpLT5yc3NfaGFzaF90eXBlc19zdXBwb3J0
ZWQgPQ0KPiA+ICAJCSAgICB2aXJ0aW9fY3JlYWQzMih2ZGV2LCBvZmZzZXRvZihzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcsDQo+IHN1cHBvcnRlZF9oYXNoX3R5cGVzKSk7DQo+ID4gIAkJdmktPnJz
c19oYXNoX3R5cGVzX3N1cHBvcnRlZCAmPQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQoNCg==

