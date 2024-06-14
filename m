Return-Path: <stable+bounces-52211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965CE908E53
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638781C22CE8
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A31A38D3;
	Fri, 14 Jun 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nLXWQHbT"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC71A38C6;
	Fri, 14 Jun 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377641; cv=fail; b=IZ6WzdbpP5Fcw6T2PahCYhz7f2HGB955y8a3uUul+E6gTO5K1MziR5GAgsChuVtZkNOs6grdH04CMaiQqK3heqF1pGSvQYR392YWki5gqOcdLgVoS/aU2xLyAev5YNs3bjzP5Ara+nD2QEUuMOrWwD7phpKafbhPZB+/L88gYaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377641; c=relaxed/simple;
	bh=x/N9UKbuC1PtJqldK9l4xcfA2yq5Uz//yB04e42/deM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JM4Ix8H5ZIW3c66y3ypELqWza3u5xd4laPXf4hfLsHZDl49A3tusQzWE4qRXzTBM3MT4oHoCCcQWbZQeOLqQ8OjC2HEP0UB5SV/vVuapaTaz0pEjzyP8Z69m5/s3AxaIgv0v343MpAInl7Wd6/7mYtqqrUA60Hczo1WiG66kYNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nLXWQHbT; arc=fail smtp.client-ip=40.107.6.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqvF2DKeXqAxRC2scF5Lqw5MKgvyRdNb+hw2Prn16uQyPxxcly2G+5lHvoMWWaFz3NG8Wa/CvURXcE8Qk+L/X0KGJqbLsH3p0gAt8du3OxJXg+yNMsedz1aehkCQfKcwAIc5Uwh0bua1UUH4J30fsaDHmIyj/D0mwX251XBltkRdZ2Lgk0U8plYByQZ35OqAEPRtY0GwLuy/G3PtKESauz92/wqe7lziqsFhNgE9BSgxMdoQyAgnNMlHyV5GjwLNZ3hPowSgslIx/sAFXBID+xU8zBjOulwxTIi1msCr6NlLf0rBmlWBU4NrX6K3FKz4zzDXqdkOsBa3YSbdNTb0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+3he17Q1UKFPYHjVKWKfzmbNcSbTss13TaJlIsutKg=;
 b=n5EjaRJYiK/VmPlp5C1Vid0ZyO7HUjXayy+s/rRrEpunqdONOD6JbdZfkTOAyiFJ5I+a7zlGp/Lm8tvLQbAgvTXtYhiXkBUII1UMuSRuK9aIqWV+AnsPMK0rn7rfRC/DEK0rpGGdPXPEwK9z6+BtjKBXyBNz43R+yIFFlATjcjGtO5I2sTkKU2n2EorTeN+mX9WnFzO+5qjZPh44SxgfNPBPbNCOwr44RNm+b2BUfP1a1GIsMtMBLCE2NcMZcq8ckDSkCqJzxPHeIgvW7NUrCaACOPUzA1E6JxhYxFp6p6jmwnplO665Mw6oJ8aSCAD3qke5MCD+1OLg4JM2E0A2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+3he17Q1UKFPYHjVKWKfzmbNcSbTss13TaJlIsutKg=;
 b=nLXWQHbTUjZmE55IcQtEbML2eNoQg1GKfqHQhw9B9Gdbzai5Y30w4NqOerdrNVDjgyOJb29/my5pScsSmrQ4xYpdL3qofwQzX+sazn64ieN+5EAOvQOAgRnLUe0ztBau86vq4yftkILLQCMLOr/czRXjJFkWrzTLhu5hPIQpNo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:07:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:07:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:32 -0400
Subject: [PATCH v3 8/9] arm64: dts: imx8qm-mek: fix gpio number for
 reg_usdhc2_vmmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-8-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, stable@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=907;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=x/N9UKbuC1PtJqldK9l4xcfA2yq5Uz//yB04e42/deM=;
 b=Gpq15OFzLOo7ay+0u8pIHshB5mhKP3WI5JvKkRWXx5mwzDY0f9h/JOTiGiBorqLi+nSZaji1G
 diqqmbwjr4uBHoqNKS8gYBe+juYQgxpdgR5oqjTF9bDyEDUclsUb7NC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e096678-a062-43a3-b292-08dc8c83adad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjZ5R2l6VXZVL1VKaUZmN0xnWXd5YVVqVStmMENJNURqbVU0TUl4SUpHaTN0?=
 =?utf-8?B?Z1hXSUt3V0xyMGdnVXhxdUUzOU9LUW5FeTFTNHppa1ljZGdxdXl6Njk2V0Ns?=
 =?utf-8?B?eGRGbFc2dllCbHEybk1DcnJmL2pwaWZIL3ZGd3JkZzlJbThPU0M2SEJVa1dG?=
 =?utf-8?B?d1lnNkRONVZKOVhQdE1ha2JWOHJaVWdHZVhxL2tYYVNLMk54TThJUmhpRis2?=
 =?utf-8?B?cWtHWlAwdUd1aGpMNEUvNmdXN2U1a2NMZE5UTXA4ZWQrb1U0TjVmR2R4M2ZQ?=
 =?utf-8?B?ZmV6NXZvU0RwTVRRSFpON3ZNZlkyT0NDSnpFcXp2MW5CbWJuQkdZeEt6QUI3?=
 =?utf-8?B?L3ZJNXdZZmo3WHhjWVZYaVlsditTRmwza09hSU1VYktNRzQyc2I0WTdMd3FU?=
 =?utf-8?B?V1BQYTUrdmNMR0FHRHQxZTlUUUltcHRjNjlVb2hDK0hqN1pZWEQyKzZuQWhk?=
 =?utf-8?B?UC9OZkFQRHdseTlPQ01RZnlhNXlUUmlGeWRNd1dUaDF4S29MNk5nWE9URVB4?=
 =?utf-8?B?Ty96SXE0YUR4VnZUZVNXcmxOZ0FlY2txQ1k0QWVmeDVCbWVmV0Myak9yUnZZ?=
 =?utf-8?B?TkV6MEw5ekhTdk9mODBzc3hGR0NkdlZyZUxyMzZWT20yUEZjNGFxVEtEUW1B?=
 =?utf-8?B?dUszU252Y0JJNVVIRTNWV0J4VVlJWnI4V2tyVXpwakNmWG45OHl1OXR6VHcw?=
 =?utf-8?B?Qi9QQkljK2piYmgzOXczdHUvK2tZalh5UG5xZ0xHajlQdzRjOE5sNStsZzFm?=
 =?utf-8?B?b1RFU3JLZ1RqeW9wWk5nVjRqck5NVDFtU0dEYVFDdFpRMFVoM2JVQ3FvUkhC?=
 =?utf-8?B?L2xXcmY2WnF3YmdLQXJtNlYxS3diaXQwYjdDVitRUE0rUCtZMzNLaWlxdUIz?=
 =?utf-8?B?a2ZweEh0dDlNMU1KZ0JLTjdWbE9qTGFrclZrSlNpcXUwQzJVQS9DM05WWVcv?=
 =?utf-8?B?c25uWExveVo2NkxxOFo3bTVsckoreVRkWHVQUmlpdEVnSllDcU1BVlJZVTlq?=
 =?utf-8?B?ZnNjVEZBWG80NlB6TDFtZVdNblhtaE1sVlJ1M3Z2OTEyTDkrS2szZTd4SzFC?=
 =?utf-8?B?UjRtdWJIUXg5Sk9hT1NCQnNGeXFML1FoOCsrMVFCTm93bFZQQ2s2OVZ2dnZC?=
 =?utf-8?B?VnhLSTBGTVBjam4yS1lhVi9PUEpzVkdZMVFHVWVEZ0tXVnNSdmZqVDVwQnF4?=
 =?utf-8?B?YWNtaWNaT25XL3RmaERIWG1CcUV3TXRZaWpNN00rNVAyZ0JjL09aajJWWXdS?=
 =?utf-8?B?bjBsSTFiNUgxd3JJYkdyVWNpaEl4UFdTMnN0Q1lFb05wMk10ekkra0JyVXo5?=
 =?utf-8?B?WVpyWGdab1JNMjgvdW8yZDZKTy9ncWI3S1ZTNXJUTDc1a1VCeUt4dGZXd29n?=
 =?utf-8?B?QXlxdFFjWXhNSGlKMEVnUnp4RzhiZnpRTW9ORmd0M1dSMFo5VFZ0bXBGckpP?=
 =?utf-8?B?Tm9hY3Bpd2JQU2VDc25CbGNJMVliK1V3b3pIa1dyclBxMmJTanZnM3NicTk3?=
 =?utf-8?B?aWp5QnJqZG9RRVNra0FUQk9TaU90aHd0YU5YZm90WkcwcStkaDhPWUtLbG5q?=
 =?utf-8?B?MGxoRnlYMDdjUFZLSEhINkRZbzNPR2tzaEVuNmFQbjFZK3Y0ZEtVTFhqV0ZN?=
 =?utf-8?B?RWlOQ3BLQUY0OVVqelJYbXFFN0hRei9kZEpUU05SMlpwVlRWbUthU0RTdi9P?=
 =?utf-8?B?UEpObmZmdG9CQlExcnJ3d3BtZVdqWkQ3S0Q0cFZWN2lEelFwZWRBOWtpQUZi?=
 =?utf-8?B?dUxUTDhuZTlxR25qOHg4R2lNL0c0NmJPSnhOME15WUs2NjdkM1hFV0tDdlEr?=
 =?utf-8?Q?BeSLlkAji/UuY/2h368DXfNyIAacD9UNEZifU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFpQXEyUy9BTWIwWXVnMG1yWi94czdOWWFpTlZ5d3FGYUdRYnB5VE11RVpW?=
 =?utf-8?B?emJydWx4NFovY2cxZVlHTTNrSTRsZVFaS2RHMk9KNm9QT3FVYzh1MFNUT0Ra?=
 =?utf-8?B?RTZCL1JwQlBCUHZLWFlPcGxidFh2RFNUcWhuVTZIY1ljRHN2SVVmQSsvYnUw?=
 =?utf-8?B?dHJ1MVA3bEovWmxmcGRTMGd5V3hZclpUUWtRTXBmTThUbStTK3BvT0h6cjBM?=
 =?utf-8?B?R3p2ZGF6YTdPT2c5NWczZWNjanhYY1BLTEhRbWxjdjZEWmJHMzhES0xuZ3h1?=
 =?utf-8?B?dnV6d09meGlLUmtsWUw0S0podFllb2ZrUkNxL3h4UC9qL1hzdVhmeTlrUG44?=
 =?utf-8?B?QzJSa0hYeHR1azIzMC8vdlI2MDF2RnIxcG1nMzVkLzMwdVVxeTVtUFNLM0Fk?=
 =?utf-8?B?NUV1QWRzcG5tQnZjQXI3RzZobjFSTzZhWW1TazZEckJ1dVh2bVkwSi9yM21L?=
 =?utf-8?B?cERzcTBaZ3dLUnBQbVp5d2VBbkZpMVd4SVRFbGJucWJ5K3BGVWlnV3FBVWlC?=
 =?utf-8?B?bkUzQW82TDJHdnZoeExKcUkydlA0ZjZwWHR0SS93Rk1FQUh3ZENyOHFBM3R1?=
 =?utf-8?B?LzgxQUt1ZWl1c0kxTklOeVhTd0cwampxSHNRUjY2TC9WSmtlNnBqNW9ydEtI?=
 =?utf-8?B?UzN6VElNTU5XR3B6bE9YSXRSOFBuVFU5a0p0VTZqb3F2TTNOSktJbXMyTmc0?=
 =?utf-8?B?eFA4SVBJTjhwZUE2OEUzOENVUnBNcVZibGJCb1c5czlLTkF2aUtJYlRHNlB3?=
 =?utf-8?B?UXJZUkg4bTMxWFlvYmhROXNaWVlCN2xpTCs2cU1jTmtVRXFmZXFZOFB1QVVr?=
 =?utf-8?B?WVhjMk5HRHFuM0JHOG9xL1lJSjZYMWI1ZTZPSktNS3dsb2R3Vkh6UnRDb0hQ?=
 =?utf-8?B?VVdEL1NDS3Q4dnA4Uis5SXpic2NKSk40bkt2R0NFMHh2TWRQUk9yMm50WWRU?=
 =?utf-8?B?MUN1MnNRS3RYaDl4aUJaUUZZazhkdTVhWGhYWUxHU2wrZWpKeG1VTVo5VEJB?=
 =?utf-8?B?OElOekF0REFldHQvckJaeEo0V2Q4UzdaenBCU2RZNlZ3eE1COUdTOVVEZ1pK?=
 =?utf-8?B?cVFNZUtHN2pMT3Y3K1grVjJ0cy9MN0V4UWlhUnVkYncwbUNTUXFhRExhQ1FE?=
 =?utf-8?B?VjJoQ3dzUEx0ck91TEt1TENuV1hzcC9IdmhMV1BlbDRVUWdwSElZRjN0UkRO?=
 =?utf-8?B?K2U5Q0pxazlpZEU4NUNaUlo0eEJMUDkyTFp2K2NtVHorQVdVUjhvWlBFQ2Nz?=
 =?utf-8?B?M2ZsOUdiMHBudGk2NWpjMnJ1NHJXVVNnZE40MHZ3L204QlhRMHdENm1XOHlx?=
 =?utf-8?B?NDQzTGkrL1pHa1lFRUZaQWNveWZLeHVIUmZpWEMvWVlySkVkeGQ0K2NsMC9M?=
 =?utf-8?B?eGthWFpMWWVjUWFZNklyUndyZ0ZrK1cvQVN6NStuWWM4a1ZnYmN3YjJnMzF5?=
 =?utf-8?B?cUtXb3BndndhUXJGdjlaY0FYZWY2VTNzOEVJdkVIMWNza0svNk1WV0hCRnpy?=
 =?utf-8?B?OCsyQm05dnVpcFVuTGdGb1dlOFNSOTYxSnVBYm5XT0RtQzlTY0ZuSW9CUVU4?=
 =?utf-8?B?YlNzcWdqWVdRczRZamNVUVlWT2xIZjFvV2twcDB3U0gwQnB6b1VJek5pZnh6?=
 =?utf-8?B?eE00Z3FscEMrQnp2OFlHWmkrUDVPSG1FV2c5UENjU1pKZVNzUmNoOXp0QTZV?=
 =?utf-8?B?ZVRmN0lzQUZQR3kzK2JmTDU3RzBQNS9jNURlMm1rZk10Ym9CVER6RjYyTStT?=
 =?utf-8?B?Vk5pK2pyVldwMkVpeVh6a2VrMDVOTDhOc2NobmMwbHMyc1hKVVYxeTZOeXRE?=
 =?utf-8?B?UUVGaWN0cENGczRSWjZGMk1BNEVxRzdWMUg0M2N0N0FpbVJ4S0cvZlkvNnVT?=
 =?utf-8?B?Q0ROZlhrYnNQTk9hSlBKZ2g0K2Z2NjVZOG5NbmtONXZsOVUwMXU1akpvTGJp?=
 =?utf-8?B?bExIcDVTVXhUTDhCWjhVWis1QkNsdG1DeGZsYkJpcVArTjQ1Z3dSb3ZVc29U?=
 =?utf-8?B?Qk1SZUZrUzZjYzdESjRXWWFsRk9rV1NjZGJ6MFBUZGZkNmNTNjNLTVhMaU1w?=
 =?utf-8?B?LytOWk5VME1qTXRjR1VzbXE4N2dseTVONVBIbG5MaWtxdlFTa2JJQlBlR0h0?=
 =?utf-8?Q?0ka0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e096678-a062-43a3-b292-08dc8c83adad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:07:16.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4MeI/qzCZ75PJeGtvWCqhiL81FBzWs32zV3LRnRcjjCbxDEzqCrmPf8OCR186CRFEmiQLpUhi8NX48zfFkjUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

The gpio in "reg_usdhc2_vmmc" should be 7 instead of 19.

Cc: stable@vger.kernel.org
Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index e3a653be7dacc..8ab75cc5b9aff 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -114,7 +114,7 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		regulator-name = "SD1_SPWR";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
-		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		gpio = <&lsio_gpio4 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 

-- 
2.34.1


