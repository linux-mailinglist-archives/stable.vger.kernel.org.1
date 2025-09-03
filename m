Return-Path: <stable+bounces-177587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090CB418CF
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CA95E46E4
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5F2EBDD9;
	Wed,  3 Sep 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="sqYZgDEz"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D32EC55D
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888821; cv=fail; b=icEPbgJDSJWK7zPxMD215m1V/2WmdW204dYTQg170lJr7l/If8RSweZ/ZbGUkdW6Z5H3uS91RW4CL5Bd4NKsm1DTkXRGpNqo/A2/5N8BSCECwkzyUnsvY/fw6MOBPV3LzcG0g2ZWP1CzTNxef5jtjHXx8zIzCeIReNjjbcPCCjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888821; c=relaxed/simple;
	bh=gjqA+qO8TWUIH4Uyvas32meS8KkvwLZDlhO3z+AL8l8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QX81zxr7QNSYWjEVtCH+4gxC9XEGJiwrpUNtg3IWWD2pvpBiphU8vL59x+XKwm3GIYixgUzpzW9lYzl0LJfYi0/RJNxNnw82lVB07+s6m7wR9MKdSsRDIDm1xhnzoChxhjFUlzTNzWLVvWcCRKDhsnbUqCUcdOvSEV6H8pp8stU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=sqYZgDEz; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO4cTAKkQlPkh3pXsD7NvBzfQ2W7omAEkpIZW9nPbuDdYHVRTmEeZQNTiW9f2lRReAjD4LxpwWQs+VcBw+YUyty+KciqN96oNxcKyxPKhKyFO4w1y3buy1toVSYwF4p0LF5haLVGFVCHydG8q+PA9BZQkLMzVkcxQwDcETW/5nmEEKfQl/0wVot8gA3FnbLS89YUipFiRhiB/LQeo7t2nsU3IrLsmLHyXA2dwUX2XdN8j5NhtG78LtsEBgzMzDvdgEVYlgVxX2C1eHt+bw2p9OQxTj5d/M+5wtbqDA7W11FyIIc/tsI0vQtw/XJzl99hycpQFhvm/DshYyOeH3p1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQPpLtHM7Qx6u5Iht5CJ4F27QxkFWaSQMuFlglR0c1M=;
 b=ifabcIpidtGh5fjWX6JIMN+vkscTBE3ANZx5cvNyIlgt9qcX/Hz352gTGN0DQo6IMvZstYCLjBR+LwxonrBGgOUWtcv8J+WA6VJmPOYFcndkA0mTmo4owzXDhbVn7WmymBBvvlUnnZjSeAB78GjY2I8OJvKy5Hms0Wl+iI3UtahErhDNpOt3/si8dsLU9LFtTmygqUo/R8KFY8XJ63uSjJ0lMbwYDK224WO3vE0ITOI7ASseHu0d10Ay6Z7W8pCIIhCuWzKFLDec3SK87DTfHrT1I9tvRjdbk5llT9vFnPFdjPPPhm2eimnxoI6f0ZiFFfb0JB0ug7ST1vw0yHnWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQPpLtHM7Qx6u5Iht5CJ4F27QxkFWaSQMuFlglR0c1M=;
 b=sqYZgDEzhtlv8P/9ucy1VZo63SyffuO+YG8L0DynplNClynY8OxGa6ouxltP8XvfmNslT2tD90Ox4jQ4+hOD3q/7xExwllQAy0TxrlU/nQZAu/1mEYBHG9HS1fUshakVxGMOTKEigCE+2pYdPQi+ol3S1foNBdvUih1fI93HOYdNXhgsTeMbh4+lZ4jk80QVXxv7yRDIm0HTkzQNEwz6cjNSpSaYXt8dBlWZsqQ0VysOO0dbOkZfgkvuu+JPbE/wdqaQa4W46wW257YfzPEgu4oAWuAttmt4Qrg2Z/ZcFk8nKMm6tKhVffqCMrDEllrqwnHT+w+eKjL7Qn3yf5ZUGA==
Received: from GVXPR02MB8399.eurprd02.prod.outlook.com (2603:10a6:150:3::19)
 by GVX0PFEBDBBB39A.eurprd02.prod.outlook.com (2603:10a6:158:401::b26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:40:14 +0000
Received: from GVXPR02MB8399.eurprd02.prod.outlook.com
 ([fe80::e6cc:a47a:35a2:f6d2]) by GVXPR02MB8399.eurprd02.prod.outlook.com
 ([fe80::e6cc:a47a:35a2:f6d2%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:40:14 +0000
From: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, Akendo <akendo@akendo.eu>
Subject: [PATCH] net/mlx5: HWS, change error flow on matcher disconnect
Thread-Topic: [PATCH] net/mlx5: HWS, change error flow on matcher disconnect
Thread-Index: AQHcHK5drFycEP/iQEy4jdIh+0riLQ==
Date: Wed, 3 Sep 2025 08:40:13 +0000
Message-ID: <20250903083947.41213-1-sujana.subramaniam@sap.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR02MB8399:EE_|GVX0PFEBDBBB39A:EE_
x-ms-office365-filtering-correlation-id: 1c112e2d-ad63-4604-5d1b-08ddeac58066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sUiUVB+M4UFNkE0SMH7YJfH3nE9aibHO/OaZQ5yyEml4jQyeCgt1HbuWgn?=
 =?iso-8859-1?Q?X1cujewgKLOy1c32dyQAOwfqs7NKtwJnuie8XYApJBQqUZtxaE9DB9QRnA?=
 =?iso-8859-1?Q?BjJc5/EiuG11TZGUxMoaLeU6TbfwkuqulJfsPwssDXeYEc4NIoWS6oTzYs?=
 =?iso-8859-1?Q?xO0vWentNYRJGnpFS6viVBt68MLwTaoBXveVpT4VmV658kDYdQCAZ4S/0Y?=
 =?iso-8859-1?Q?4bPK8oZz0hfscRnxEIiV9HyOJeKtGs9t3p1ZNbIcmbldfbBxpb27jfzQX1?=
 =?iso-8859-1?Q?WCxqQDSAlgBJN8t0f6fWldNF/x99OFRPRJQkXvexClXLPCXgRtqbZh4keE?=
 =?iso-8859-1?Q?GYdruWSt/KrSK3HsUlD4LazAeKMjjBkBmU7b/rqzroiv4Zc29iqpEo9pQE?=
 =?iso-8859-1?Q?fft/SLxP7DA5R9WD76B7lsm3cqp8lzA3WRZstC33AP7T4Os18LdntA/vk/?=
 =?iso-8859-1?Q?nqnG710eIjOn+cdGM8RsU3nvliAVzztjlt/C2JuyQ0TUseoGDdk2sWjpdh?=
 =?iso-8859-1?Q?G12vNU2VvavOH4qe7mMlmQqiUdC++Sz3I2sNamrR6kUeAt6ftaL1xM1LaE?=
 =?iso-8859-1?Q?u49bLaUtODIHMgFPZe4otUjLRspDOKvZMr8DwAPfTUle5DzTKpgkFlVaLw?=
 =?iso-8859-1?Q?bsNWGEyt+AF+XQ0nDo6baA/XlJVJpG9QTZ5gV78VwogX6EEz49DMwnMQ7q?=
 =?iso-8859-1?Q?g0KSNuNZ27l7WciEEZqhwdJX3p49BxM1e8ywKxiYKG6Rs4acJAQzUhSKek?=
 =?iso-8859-1?Q?Hj1y9t8899dmxupouW0xfCo4hwaNSH2lZCp2EnrLSnQSjJDwVAiWW8ywnM?=
 =?iso-8859-1?Q?vQnGltukhqOfrSfuQ74EF+N6cu45LH676V20RcU/n1epsv0dxL1B65Vpt+?=
 =?iso-8859-1?Q?imCf29Q8/wYibPICuGTF7agE/I2ulMzD9K7o7fzXrNVY9zXQTu5R0EHIca?=
 =?iso-8859-1?Q?LbaSGUNsO12U7kPVkbIjCGZBzp2LCjXQO4I3WsT5XkOmIR9ZvTeBvqCvKf?=
 =?iso-8859-1?Q?8yoOIiIYwy6OeS3mb4WTzxs6qQvh9M1Uk8XteuXnMIlozDxXQaSugeaYXl?=
 =?iso-8859-1?Q?0SW3Agxzuum3IvkN7iXIrjWtSiskWBStxxWk909Mmd5hPQsPOw5n2Bm7ia?=
 =?iso-8859-1?Q?Vqi2BGELc4+N3nr+WOLC9nwLxGHzXykecOvZZKV3dnFQdqQGrCZ6KcXP6d?=
 =?iso-8859-1?Q?OXanC2v3yy4VZZcQZLhM5Gz4MCSoQHeZhpzCH6XMKDkxqdLr/CmyWJU346?=
 =?iso-8859-1?Q?G7OfEfnWUgbqukBKWzF1yEKhdGuPcFEK02HfKCPIXb5RpvNAFbVLvjqTQ+?=
 =?iso-8859-1?Q?grhEOK+SABbHQqlpMGlBQa4Y6e/SyPcKG4FCZUyUnAhCyLKqKyGLfrbxWq?=
 =?iso-8859-1?Q?/xJzT15MP6db5uSLxPRgwTokEg778UDKim0py44UjPLSvb7Bwqrm86lluA?=
 =?iso-8859-1?Q?cdImW+g9he2jW4tz/EyERxUnejq0pTAO7xMW870BfdOwN3iLRfVxEGlbJf?=
 =?iso-8859-1?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR02MB8399.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?35TFxYOf2Qy080SKfjCQBcuGbJs8hUngzCMrMyRuFcyUWTWznohz6Q5A5c?=
 =?iso-8859-1?Q?D8EaFudeoqLHtYt23UJy5ZhLWC8czf0igig94anzvK0LCvGNA9YrOuroga?=
 =?iso-8859-1?Q?aINcMCLbPvClP5dwG0ePi8lph9DUleYbNQFvNB7DdiYhAtTCDbueJFPp10?=
 =?iso-8859-1?Q?umOo5TwlrbF0pLZ0Oy5Cv9UpBfhN1wxpRy/UX/JRIwAbjnEPjOrrzeYxCM?=
 =?iso-8859-1?Q?must38a2CAkrAyVoBB16LHtT9HXX8cMw/7egsPaC3a8S17+SWVi5edhhYM?=
 =?iso-8859-1?Q?pzasPz/hZclTxlpWS4XRsJ8pirULoQ14p2jg7QNlyvAY2Jdvi5/34iq3VX?=
 =?iso-8859-1?Q?N6a6L978D6JJJxNxVKgcS1W/F7WvDUyexmFKtZqUFWfIDbTvIU6/IjJn4x?=
 =?iso-8859-1?Q?eAXkIOv5TX+voy/oJxKJiwtfkU8EHjkezzFcpSe5FW4vnrkp5A9ol41DVf?=
 =?iso-8859-1?Q?UDzpnrnr2qwJcZc78dOaVzX2UdS5cb7B6nmz5JxSGKnMn7B47FaWLGRz3U?=
 =?iso-8859-1?Q?JNZVSZDdrHVTx9rEVTGw3OtJVJmewrOBxi63X8/H42Tk9qyQh77eP8usLU?=
 =?iso-8859-1?Q?kNPCR6YzDUce9HetmsM1D6PavBTBVWlIsKBlUxIjiHpSpHMRk5lvu7+eax?=
 =?iso-8859-1?Q?qvpqedm7LE5uaE/8nCG39pAYyOjIdVpx5eym5KPRFlgS/YbidGneufmygw?=
 =?iso-8859-1?Q?qS4DDWp1NUKE9t0kYdwhQQRP+CploitlZX69S3rzU5fXRxpiPDskQVp2cY?=
 =?iso-8859-1?Q?C1x6qKxD9641Yp14+71JjJaEfxZWt59HxxnoL1LVANRPidVWjbLRxLwmmE?=
 =?iso-8859-1?Q?wCQgWubYrvIUMMEyVubcv1Bsl0Ci3a0KN3rDHfOTBlIHy1RFIj2KI7dD4q?=
 =?iso-8859-1?Q?2Gdu/EUeRwnqXR7vbz5PRMgKVkKc9YQhZLM2EgiEF84zIzm3OGuw0M4QJb?=
 =?iso-8859-1?Q?hTfgvP9P/F5/hlami1qNh+Vw5twKVT+7l1hn2NLZ4NI+ujlYu5FXIvnF46?=
 =?iso-8859-1?Q?WcDeoHpocj6GfSh+xqN4eN/Q47y/UyWOQeI0UF70OdbKNBeoPq8uQ7vDPM?=
 =?iso-8859-1?Q?y8wjWNhGjxPC+O1l66h6Bg3MOhc0ANjg5LK3+BehcLm9uJQ1zHFuCbp0qd?=
 =?iso-8859-1?Q?umQQ/c6YNLnI2Ffso5TR7RXsqwkIKZKc5pilgDc/tLuimlJrWV2ww3KKsE?=
 =?iso-8859-1?Q?VOgJi8zO1acGvoR9Kllw77CKQWYZnLLnrndG6Rb3jNtyJ8PjiFN44P/3Z/?=
 =?iso-8859-1?Q?WDVP5iIdMDZ5drXhdVJY9oZLNHSwxKLl0ofjh0zZEk3y9CfBCbMwEqdJGC?=
 =?iso-8859-1?Q?fTeEfWfdPAwOW2Bi6R8U3c0OSXWy6Ud06ac8UvHlEnBFKkO6IzxurGlpr1?=
 =?iso-8859-1?Q?w98jwZQn0HOdW9/+XuBdqZWxlJ+FFwXtP1pnbsc/pyHjdXOiZjpf8Twf2V?=
 =?iso-8859-1?Q?40LWn9KJfN627DYxrI0I9bRSEHy2QHWGs6qphKtBXI0exaYAPtujcIxArD?=
 =?iso-8859-1?Q?mRRmo54nECMIuxpCW0+2v8KSxg11vcypO8Nt6Wid5yQMXVuXPJgbrTbrIY?=
 =?iso-8859-1?Q?wsCttKUg6vJJr3MMnJombC2a6kaPwcQUHoKHASz538atAG9FgkERGK4yPP?=
 =?iso-8859-1?Q?4t//CuEeV5kNO8GJl3O5ROswvNyv8IEQTj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB8399.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c112e2d-ad63-4604-5d1b-08ddeac58066
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 08:40:13.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHye2ede3hFhr19fuWbCX9qcM57ghvMztk5GjhMYUJI4Q/ds8KVPh+GWzhofmdiu0mQx121pALNRih+2ohDnscDalYKfVZK/777Ug3fnksA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PFEBDBBB39A

From: SujanaSubr <sujana.subramaniam@sap.com>=0A=
=0A=
[ Upstream commit 1ce840c7a659aa53a31ef49f0271b4fd0dc10296 ]=0A=
=0A=
Currently, when firmware failure occurs during matcher disconnect flow,=0A=
the error flow of the function reconnects the matcher back and returns=0A=
an error, which continues running the calling function and eventually=0A=
frees the matcher that is being disconnected.=0A=
This leads to a case where we have a freed matcher on the matchers list,=0A=
which in turn leads to use-after-free and eventual crash.=0A=
=0A=
This patch fixes that by not trying to reconnect the matcher back when=0A=
some FW command fails during disconnect.=0A=
=0A=
Note that we're dealing here with FW error. We can't overcome this=0A=
problem. This might lead to bad steering state (e.g. wrong connection=0A=
between matchers), and will also lead to resource leakage, as it is=0A=
the case with any other error handling during resource destruction.=0A=
=0A=
However, the goal here is to allow the driver to continue and not crash=0A=
the machine with use-after-free error.=0A=
=0A=
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>=0A=
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>=0A=
Reviewed-by: Mark Bloch <mbloch@nvidia.com>=0A=
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>=0A=
Link: https://patch.msgid.link/20250102181415.1477316-7-tariqt@nvidia.com=
=0A=
Signed-off-by: Jakub Kicinski <kuba@kernel.org>=0A=
Signed-off-by: Sasha Levin <sashal@kernel.org>=0A=
=0A=
Signed-off-by: Akendo <akendo@akendo.eu>=0A=
Signed-off-by: SujanaSubr <sujana.subramaniam@sap.com>=0A=
---=0A=
 .../mlx5/core/steering/hws/mlx5hws_matcher.c  | 24 +++++++------------=0A=
 1 file changed, 8 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_m=
atcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_mat=
cher.c=0A=
index 61a1155d4b4f..ce541c60c5b4 100644=0A=
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.=
c=0A=
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.=
c=0A=
@@ -165,14 +165,14 @@ static int hws_matcher_disconnect(struct mlx5hws_matc=
her *matcher)=0A=
 						    next->match_ste.rtc_0_id,=0A=
 						    next->match_ste.rtc_1_id);=0A=
 		if (ret) {=0A=
-			mlx5hws_err(tbl->ctx, "Failed to disconnect matcher\n");=0A=
-			goto matcher_reconnect;=0A=
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect matcher\n");=
=0A=
+			return ret;=0A=
 		}=0A=
 	} else {=0A=
 		ret =3D mlx5hws_table_connect_to_miss_table(tbl, tbl->default_miss.miss_=
tbl);=0A=
 		if (ret) {=0A=
-			mlx5hws_err(tbl->ctx, "Failed to disconnect last matcher\n");=0A=
-			goto matcher_reconnect;=0A=
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect last matcher\n=
");=0A=
+			return ret;=0A=
 		}=0A=
 	}=0A=
 =0A=
@@ -180,27 +180,19 @@ static int hws_matcher_disconnect(struct mlx5hws_matc=
her *matcher)=0A=
 	if (prev_ft_id =3D=3D tbl->ft_id) {=0A=
 		ret =3D mlx5hws_table_update_connected_miss_tables(tbl);=0A=
 		if (ret) {=0A=
-			mlx5hws_err(tbl->ctx, "Fatal error, failed to update connected miss tab=
le\n");=0A=
-			goto matcher_reconnect;=0A=
+			mlx5hws_err(tbl->ctx,=0A=
+				    "Fatal error, failed to update connected miss table\n");=0A=
+			return ret;=0A=
 		}=0A=
 	}=0A=
 =0A=
 	ret =3D mlx5hws_table_ft_set_default_next_ft(tbl, prev_ft_id);=0A=
 	if (ret) {=0A=
 		mlx5hws_err(tbl->ctx, "Fatal error, failed to restore matcher ft default=
 miss\n");=0A=
-		goto matcher_reconnect;=0A=
+		return ret;=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
-=0A=
-matcher_reconnect:=0A=
-	if (list_empty(&tbl->matchers_list) || !prev)=0A=
-		list_add(&matcher->list_node, &tbl->matchers_list);=0A=
-	else=0A=
-		/* insert after prev matcher */=0A=
-		list_add(&matcher->list_node, &prev->list_node);=0A=
-=0A=
-	return ret;=0A=
 }=0A=
 =0A=
 static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,=
=0A=
-- =0A=
2.39.5 (Apple Git-154)=0A=
=0A=

