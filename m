Return-Path: <stable+bounces-179302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AACB53B5D
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622255A5A4B
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178736932A;
	Thu, 11 Sep 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hFI2Q9HT";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hFI2Q9HT"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020099.outbound.protection.outlook.com [52.101.69.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4A1DA55;
	Thu, 11 Sep 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.99
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615323; cv=fail; b=OaygUnUdsNfZVeoLiT4kOClCFlmTh9W4tt8YiXvspWu3JD2gXcJ3lnGYSk4iPcNmHMxrl/V76HUzkuT0gloFcwk1nDT7d919z3jnPT+O4p9XcXkJ0XxpgUYi/7SNseuj6k/fdrn36XS1kRVI+UJj4cc0PDGF6u8faoiKq3Nn6VM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615323; c=relaxed/simple;
	bh=blmcNPHJFXJjShpCEbqry8uQs7Y885Xbh1VL0XZT/Vs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lEE8oGTUiYR9KUBrDsAx7csv+OPCdaXurX6lvbKsCcMhHwLgrLMZj5UzH1QZjcfZzaKf1ZwXx29MnSw3TK9hdLlY7K9U7GfUJboozQmnxsSwg6qoKrnNtWtRGS2WoPqGfLXUHoqWiDwvHeOPIKzGG4/9lL/W+b4j1WgWufLevHI=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hFI2Q9HT; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hFI2Q9HT; arc=fail smtp.client-ip=52.101.69.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UZ92mKI4Vsh3Vgt1gJ2WlvTYl+S/rUdC6KFFNhdgRmwPkXaw1IKzb1myQUzPdQgIf+P/df05xVFaPHi/fCtomzhZ5/h1a7+GP4Y3Oo1t/m8Ipj22sI9on64JWKsz7ZQTrDgrzILYvf4T9sItNFbB4zReqNguJbq099TubzTHS78V1wYohas5IiAxuRz+TFlEomQpBHu7DcrMnxlfmy1ECTfgKPqrD/mxoe0PYnwCUwa5bIgkeJtPvYo8LrntFBlIjyW93C3LnNzAKFApvcJhjZob+HanDgzw3LF8uNdeq9CzfmVkC+PM5Ww0rLy4onDulT4/pJHZKxytBGjlCT3ocQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZLh3rZF38/8Z1loAHqmU7Sbs/uLhNH5+hdhmeytFfk=;
 b=dyV1JLYvT8sGmwpsWOBc9ox26/pyuDfL1fEByDsoQxPoAxT7FwDyhA+BHejybXpuALMZ0T+iR/+Is/U+T7rRDDek3cC8YqaEmur9V+x5mfRvmePsGqR1skoI7BNVreh7pcqh+qVy1Qzice++NgkrNiBsH+o2NBqmQA6Hd6LNqZldWZeScn+udEdYQoHz1Ad5XewktAOE3GRWcoRCHSOqN3zEy8jaE/hlUiTYxlaka/ilELXo+fLt85oP+T20g37SahNoUvsNlwvzhgojPGrkhCQkCkYma2SewoZXnRg/HkBPoiCbDUeCFmqUGA9YydeCF8pXlzjyrjWiAjbsbla4uw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZLh3rZF38/8Z1loAHqmU7Sbs/uLhNH5+hdhmeytFfk=;
 b=hFI2Q9HTlVgOTy9pXTheCd8fZF7FwLAXQd8xr0lOi/IGMtpeynRbfwTkrXzZBc92BisNlzjss3QCBnfEuSh4uMOHt7ULu+RxxUWSowoUAhqyffeVmIU2Gk0zrZTFDJnlQTO774XHP79bMFJdXq6qtwuRBt+1PvH4yAJqEtFmWJY=
Received: from DU6P191CA0032.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::19)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 18:28:38 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::53) by DU6P191CA0032.outlook.office365.com
 (2603:10a6:10:53f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Thu,
 11 Sep 2025 18:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 18:28:38 +0000
Received: from emails-3513810-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E549980610;
	Thu, 11 Sep 2025 18:28:37 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757615317; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=SZLh3rZF38/8Z1loAHqmU7Sbs/uLhNH5+hdhmeytFfk=;
 b=JdPSA/aKNLR/PcxuQxR2ZQVHCqxPSGveY2+gT41oBYuvkCAo1wLiO12/DBMpTKaRFXFcs
 V/Qnw+ygLQ1gJzuEIZnNjN6ph7L5iDaKT+K2o1B1M2n2oGI7Qw5E38yayfzMOjNmHeHE8UX
 ncVyNA9K7MTQu0wKzKfGE0omZYeM/K8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757615317;
 b=hC/Qw7occPzklxfMDHrJYufz9nDAIIgmuSQ/6LGuY1HexpPiZxZ7f+hFv2tGUP7hLkO4N
 gn5l6fM5hwsJxWp3szIKrbRrAD55cHHEZCa0fz4sVfUu/Ck1KTGfobFzTAqmRsZ7wHkJacj
 I/JXO1vYemDJLREDTkcLHJqW9hne6H8=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjaXMFlcWzPzRV5oVybdt9GaCKZ5CdgU1nMv5U82LGb2dlVIgWV0AsxnCezVwnXSKMdfgZw6FpGnUa1e6+9/BflvDIDV4qPGVYGF3W6HyhJNKUYClcbZkkk73NsBOjt1Ayncxmp0XhOkiO7WwPhQoBZvNKvGP/7STXTcpONiTGM/yzPN1kNsjrkrAsNHHi65xUYJ+Y+CRPm/0xplTGl3OJa918LASx14orlI5rFeMOV6k2HjyHa+0V1AH26BpbEU8J4OG8RvGrF1yFhH6HTF4DAUPoZ8UA1+Cc0Vkm+JbIvt1ow9g8fWt+a27BtL9Mph8UksbjxNvEiDWPglLJXTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZLh3rZF38/8Z1loAHqmU7Sbs/uLhNH5+hdhmeytFfk=;
 b=ATo0/eIv3eDHJ8ZrVKF6jxFfmRvDvf/Fvi3nYEYQFL4wl8NzHyHct3hkqsDVtT57socRLcOsHq2EddIFN1L3QZYwf/qjeBaX3GPQFPTpcw61ITpu+W24D4ILojgQC82Vlfd1ZyTAusVYcbbdOHLWX/5DgOXGDRWNBnvoCoZsE99yLb2Q8Ol/UWKYXfXdXHNlPczIMH4OCGIAgSJl/F6+wWfi6oO5W9Tg7bqELUN14vWP1JyES4rs2IzpMKtf3kBF+XjXaUDSgDRwkC+wlLDXMDLJI5DHcO3MxdGtsatMzi8mHvm0Dt0QIYtbUVXeQEKSwOTQRoTxPB4LUfxIbINAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZLh3rZF38/8Z1loAHqmU7Sbs/uLhNH5+hdhmeytFfk=;
 b=hFI2Q9HTlVgOTy9pXTheCd8fZF7FwLAXQd8xr0lOi/IGMtpeynRbfwTkrXzZBc92BisNlzjss3QCBnfEuSh4uMOHt7ULu+RxxUWSowoUAhqyffeVmIU2Gk0zrZTFDJnlQTO774XHP79bMFJdXq6qtwuRBt+1PvH4yAJqEtFmWJY=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB11488.eurprd04.prod.outlook.com (2603:10a6:150:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:28:30 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 18:28:30 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 20:28:05 +0200
Subject: [PATCH v2 2/4] arm64: dts: marvell: cn9132-clearfog: disable eMMC
 high-speed modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-cn913x-sr-fix-sata-v2-2-0d79319105f8@solid-run.com>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
In-Reply-To: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|GV1PR04MB11488:EE_|DB1PEPF000509E2:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6750ac-bffe-4ec1-41cb-08ddf161069c
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aWlhOFhkd0tkOW5kWnltNnpwNU5EWGI3L3J0V0gwUTFNMUtrdlNkLzc2ZlhO?=
 =?utf-8?B?NDA4ZUFLK2p1TStZWktVUUpuZVRzMDJVZ05PTEpoRlJ4MWlvWE44aG5UU2Y2?=
 =?utf-8?B?Um1oTC9rZWtRTzBNamtUekN5K1pDRGtETVM0OEc5Qi9aY00vdTFNbC8yaUk4?=
 =?utf-8?B?YTBIVmFkazZnWnp5ZkRuNytqaFV6QWtzV1hZSUlBRVlENlpRV0VZRmJqRks2?=
 =?utf-8?B?Z1FTYzRFa1pkSDMrR3QvYkZVK3NEMUJuVlNHd1ZZVDVFU2dZTGV3YTlJaWlN?=
 =?utf-8?B?VzBNcGE1S2Y1NkZ0cmxOb1k0RVBOWmNEWlUyYVo1eG1wMW93S0RJaERDRDg2?=
 =?utf-8?B?bWFYTm1PYzE2VjZqZVVjZUFMd25MRUE0VjBtaVR2bzNGK2ZVQkVIcUJPYWFo?=
 =?utf-8?B?RDYzblRpR09LWnJKYzNTRWltSk9xNHZXU3BaNk1WMEdjMHIybkVRTnVWTE1z?=
 =?utf-8?B?WVgxQTRvaktnaWVVbDQvWFF6b3dSdGJJVXM4bzNBcWVGNTZpV250SjJEQ3N4?=
 =?utf-8?B?U1FrRmxlTHlTZlhVWUI0cWxJalcvTjJkUzJSbWpITVpTdkxmVnViNXR6b1FK?=
 =?utf-8?B?TDRkMUdlWCtvU0ZQYmZvVEpDd0RtaTQvczgrakk5V09TL2VEUE5wUTJHYnd6?=
 =?utf-8?B?Q1k1WFNvTEhtUTVEOE9OUjdzVzcwZnFHaEN1YytLaURBbmpsZGk5Q3dnNzcx?=
 =?utf-8?B?Vmt2blhqaG40MFFmM2hjcWpFTW9EVlNyY3pvZnA4VzIxc0RqMGZPS0x5S1Fy?=
 =?utf-8?B?TnJ1TjIyVUVBMy9CeWJKTWJSWjhYMGlMY3BsVkZHQmxkZnFoQzQ3WFdBWmRD?=
 =?utf-8?B?UlMzaGNKRHNHbXl0NE9DT25HZTFueEFRbW9taThwVHlpbnBUUWpCQ3BuRHBD?=
 =?utf-8?B?N3o2NW13ZWg1WStOdWk1Z1pzbmpybDFweFcvS05OY3A1SXB0ZVhLNlhSOEdL?=
 =?utf-8?B?cEgvWEw2OGJZTVAyOWtBYmFrZ1dpWDlGdDIzRDhmSmxCMDkvSHpzMC9SenN1?=
 =?utf-8?B?Mld1WG9CVFJ0c2xMUk1WK2xWc2pjVm1hbzZpV1VzdGlKYVkybENqRmZIUGNJ?=
 =?utf-8?B?UHY2TTBqTmJqdGJHZ0E5RzJia0hybmh1aVhhZGRSYjRjUkFrODE1aUJGSjRC?=
 =?utf-8?B?SFBSZVNiVW9Hay9xWGN2NDJ6Q2dUYlNqVU92ZCtQNTBFVEYyYWVkTVQvdTRM?=
 =?utf-8?B?ZUZvZnN4eitDbUpnQS9jcFFiQ1l0MGZaRFFRNkFWMFVyQW5vSmFFVEVNM1E3?=
 =?utf-8?B?ZktMV3daeDBPTGI3bk5meDlTZnpCcEtEeVNYdFBacXJ5RGdHZzNvc0RieWdy?=
 =?utf-8?B?Rk1wY0V1Y212SHo3SGFqTTBXRXpPaHNpTlVELzVMSUV2clpoL2J5RU00bWdp?=
 =?utf-8?B?bTRGa1VsUzhhaVdhUXNwdkVmTlVQbzdhcSthVGw4NC9HNkZLOXZuaytrbVZM?=
 =?utf-8?B?YUpNVm5HWk83THhtRVAwVXFjNDdtVk0yTTJ2UjMwWnJGSkVIbll1S1JFV0I5?=
 =?utf-8?B?cGRVNDB0VmljTmptdndEdG0zRlVTOCt1N04wWHBxT0dnMWdtWkRrTUJZREUv?=
 =?utf-8?B?K3hUeU1MUHVRZ3JCL0F1VU83eFRXWjdLTFhsRFR3QVVZV2tVM3RPL1VYcnBE?=
 =?utf-8?B?Q1dhTGNFbG1NT0tSOUVqbTNUMklhc0VXSHFFK2o5ak1BdHBvajNYWXg2UStz?=
 =?utf-8?B?MGJ3anQ2R3BMM1VuY1hUUjhwUFNzckp0YkhLditxR1h3NkhpUFBpL3Z4RVZj?=
 =?utf-8?B?aHJwWG13WHlCeVovQ1JCRUE3c2M5WnBQZnpIaGxUakRBRzArdUtQMXM0L2h6?=
 =?utf-8?B?QU9YZjRza2JjRWRmbzJJTFdpYjdCeXFmYlhrRmdvK1EwTlZONzNxMXRDVVo4?=
 =?utf-8?B?VWRpVWxjd1JtZ0NnNWwwdWt3TU1WdWVNZWZzVUJOdWRZcVFVTXRoRkt2eWRG?=
 =?utf-8?Q?GBFHuCXwLeA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11488
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 483ef9a1543c40a69ba62379326dea43:solidrun,office365_emails,sent,inline:747356389351dbbf289619dd077559e8
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	88fde693-9432-42bc-fd26-08ddf1610202
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|14060799003|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGZmTXdmSDVOTzJEaU9ZV1FNU0w4K0x4eHMwS3hpOGhMMHEzdzl0ZzVmNDJF?=
 =?utf-8?B?R2s0MjE3SytvOVhTL3JmUkpyRVQvbHhGYzlsZTliVkE0M0NFaUJhZVlaQllV?=
 =?utf-8?B?anlqUXhGM1YrSk1iVUJmUm9Mb1FaaSs0YkdiTGExU2ZjNE5lU0plZGExSHFn?=
 =?utf-8?B?THJWTnYzaUZ0L05Kb1JqSlByTFFTcDNqTU9ZK3pvWkMwM2lXWFgzU1dYbkp2?=
 =?utf-8?B?S1JxVGU4cGlMU1dpZjN6bXBCWnRRTlgzNjdscWF6QU96dXdyVFY4MkRmNHFR?=
 =?utf-8?B?K0xLeitXZEVGTnJ4U2JpZ2JWay9PVktKNmhUYSt5S3FaY29XRm9uaEZsOUd1?=
 =?utf-8?B?UFZ2TFR0cGowR2xUNTRvU3JMYk13YlpBbisyTFJJTUVFU3g0UWpXUmpORmhT?=
 =?utf-8?B?Q0xtS1c0aTExQVpNa3M5VnJnRVZYb1pTT3l2SGE0Z250SmxncDNqb0VKY1dt?=
 =?utf-8?B?Q3d3YThpZ05XWDVLeWY0VnFSL3JJaVpQM1RTeHQ1T21sRlhVVXFxWnVwUTFa?=
 =?utf-8?B?SjlOTHc5R1NPbVlabkhvdHBzNnlYcFpMbmN5cXMwSE5SQkZhbHJuSGRTWDNk?=
 =?utf-8?B?aTM0WVo5UFBMVnZWeDFLb3dXZHRreG5xeEFCRmdzbnNySkt4bjIzKytTVWhw?=
 =?utf-8?B?enI0azY1WFhFNjEwdit6LzMxbk9kNW5oS0xZMGgrQmkxWTZWY1FsVzFyYTR6?=
 =?utf-8?B?cUtPd3dqRmNNZXUySHc0MGtOL0FEajVjNDRVN25QV3I2SnhyMy9uU2NSR25v?=
 =?utf-8?B?aElzcFlURFVYd0FDNG8vZWNYTkJJeHFZQlRlNFhqWTNLdGlDeXRaYnhRWjlu?=
 =?utf-8?B?QWVKNk1FY1ZkRjFZU2NtNTRGTDF4Ynd4djF1L1kvbGw4aVF2ZzBqUnZZdmYr?=
 =?utf-8?B?RXlTQnBGZTdtK2l4c0t2ZXFwOXpzeVdZMGF1Q3N4Qy82THZxZjJXZHRwcG5t?=
 =?utf-8?B?UzVFWU5jd2x2YjQ3N1NSS2g2czlFVWZPV056RE53RkdOVjNzbDI0YUR4MklL?=
 =?utf-8?B?MDdoby9BZXJNcWpVS0lMV0hROTBBYld3RTNGd0ZySVhrWEZINHQzV0lFcVRL?=
 =?utf-8?B?MnZRWVdtK2F3K2hPZkdnR1NoZitUdkVzbnZ0bWh1WXU1aFpPbU5Gc3F2T0k3?=
 =?utf-8?B?S3hvSlRuQ2F1TDNaTTNYVlQ5Y3oxNUovS0sxK1Z0enF5RDVndEYraW9yZ2E0?=
 =?utf-8?B?YXFOd0xVaFE2UUZQUlJjYjBZVmhFei95QUhhc1ZLSGZrRW5IT3VSZjVaalRL?=
 =?utf-8?B?NGYrYmMzMmtiUzlLc00vMm55eU16dXc2blZkdkdQd3ExU05ocndWVDk1UHlX?=
 =?utf-8?B?cFR0aXRISjZEbDRHbTBhUDBXVndUeFVmQnUvUkR6ekRVUXMwSHkrV2hFQlhD?=
 =?utf-8?B?Q3N2MWk0QXYwOHl2SldMd2NHRzlvN0FMcG9OSGRNOTNDY3ZSVjVlR3A4SGta?=
 =?utf-8?B?ZDBaU3VqM04yNGZ1SVNjVzVZT0hIeVpWRFliaWs1aE1nN0NvU24vajNXbnZZ?=
 =?utf-8?B?dTJTYVFSVndZZDZkaERpTVhhTGVLS3pSZlhmUERoK1pXbGI1R0U3MFR5YS9a?=
 =?utf-8?B?czZmOGlZYTFoUTdsYUJEL1hQR1M2Y1JqRFlJWXprMDJtVFRGWG45cEhvaU5R?=
 =?utf-8?B?MEptam9DeTdObVVkelJFbXFZTFZBY2E0S2JaelpFdWJvby9nWFN1KzFYWTZq?=
 =?utf-8?B?T3VDcDRnNXdIampITVRFWTFub1l1bW8vUzJSbUx5OFdneldDVm94bXpjK2Mv?=
 =?utf-8?B?aGJkdHp6NUZSU1JzODdnKzlMMmV6NSt4MHJxU0k1dlNDZE5WR0Q1KzNzSmJI?=
 =?utf-8?B?QUgzbTUzbjhucllMNW5ZeUJoY3N5dm5ITU52S2V1RGJTQ2pncktOZ1NTWnU1?=
 =?utf-8?B?OTRxU0ExczNzem9jQ2xzYVpweGhBODFLNVRqT0EwbjVPNGw5TVlmeUx2czM2?=
 =?utf-8?B?MkhLaHN2M0tvYmlrOTRNbnhlRnN4Zll5Y2g4bGd5V2UxN09rRlJhcmtmQW1o?=
 =?utf-8?B?N3N4eE4rNUpZUGE5N25XVE9lQlhuUm80T0h5T3ZLenZjMFNqL2NJQ0hheXkv?=
 =?utf-8?Q?ZUdpcc?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(14060799003)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:28:38.1073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6750ac-bffe-4ec1-41cb-08ddf161069c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

Similar to MacchiatoBIN the high-speed modes are unstable on the CN9132
CEX-7 module, leading to failed transactions under normal use.

Disable all high-speed modes including UHS.

Additionally add no-sdio and non-removable properties as appropriate for
eMMC.

Fixes: e9ff907f4076 ("arm64: dts: add description for solidrun cn9132 cex7 module and clearfog board")
Cc: <stable@vger.kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
index afc041c1c448c3e49e1c35d817e91e75db6cfad6..bb2bb47fd77c12f1461b5b9f6ef5567a32cc0153 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
@@ -137,6 +137,14 @@ &ap_sdhci0 {
 	pinctrl-0 = <&ap_mmc0_pins>;
 	pinctrl-names = "default";
 	vqmmc-supply = <&v_1_8>;
+	/*
+	 * Not stable in HS modes - phy needs "more calibration", so disable
+	 * UHS (by preventing voltage switch), SDR104, SDR50 and DDR50 modes.
+	 */
+	no-1-8-v;
+	no-sd;
+	no-sdio;
+	non-removable;
 	status = "okay";
 };
 

-- 
2.51.0



