Return-Path: <stable+bounces-158449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E92AE6F08
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 20:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986581BC4F8E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B0B2E7632;
	Tue, 24 Jun 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kr14/E6k"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012001.outbound.protection.outlook.com [52.101.71.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E92E764E;
	Tue, 24 Jun 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791529; cv=fail; b=DbZ1tHw7w5pORS9T0inznM0CVqBfak1LgyIhJ9XbZiE7Bb7VYh9rH9PnM2D17Hnfx+UdqWGRgkfGCqNE5M1AXqB4oLBDPYrHJxmDryeWgQgCJPgedSzlmNknQOyp/RJdGHJ1096/xs8/sZ+xMfuQCbMRXvZcER28XbCpSSgdh0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791529; c=relaxed/simple;
	bh=KV60q+vh2IvFY6dxytTpQ+saX95LLAEFk3y1/gH/GRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJV9FHmAq7dC9och8pAuHxPWbL5ULN4+2lzGsphJPD8QA3JGKqzVi/7DQ3B/KExH9fHFX4LlDDR4ER6dHshOIU955bvTU2UOpUniuiVJOmE5yW1hR6iNmF8gajrVIzZnicYV/CYdJ9bti/cslvK2dUqHc1jEfokUCTBD8yMslKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kr14/E6k reason="signature verification failed"; arc=fail smtp.client-ip=52.101.71.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbzFi/a5neZyKsY6S0TiJ74a1lcnSDKcZzPRZMUAw4RvqrB76dHvpE1JwaB3xxqz9tz9ngZ37DFSHBw8y1rOn9QobvnfeeKMkB4hVQtZLj9M/luSgx+AXN7NXIYUHrH5n7kC0XgzuyOACucHRcbX/qXdla/jkD1DjXX5UiGTSiFSytHnTyPkLuOte4dZek5c+0ap+/myx8T/fw+D9zfsfy8+JNP8YnlJSv3BzwelYy6o4IzInsHuCtp1aBj7a8NZbLrTfzwvjoMphFuV+RzZcpS3EIOq+bxj64zByMv9dc9UWSbDI/GybSZSSNz1VOtzxie+mIj92JkluKJgkVguFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIQe0nTd7MrWPAt0NFtCI6vjaSnm+C3/drwF3FVOeu0=;
 b=cGzibwhPflsQxB1yL9XnJrhZ69mUNrsnCKBO0almC92mku/JJF9KE1U5K1r0Vw0bGu3s1bjP4Es6GHfD0RDt3qJDvFS+1zYwHELKbHCufFb/TH2I8/T/eJZvFBHPLwZRFAj2xI1XbocCTsWE8PHmH4UhOwVgE76fBCR2AVZnlW2cRbJrQpRLPw3hRoXmvVf0x3GebeYsKDOeNdHhU8xxonzUTX77kF3Pnow8VA+B6x/twr7qateW0RQQsqxv4RUQdVMOG6J9AynxtCseWK7bVryjCMyeFn2g7SK5rRN4YlIRmgHxhGNboQ8Lrm8MOPfP8rSQkp8cxgphpDdbg5/eUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIQe0nTd7MrWPAt0NFtCI6vjaSnm+C3/drwF3FVOeu0=;
 b=Kr14/E6k5McOLHoEagbXe+KSpCM6jF1THnGv5kr+Q+DAjEQS+swNAN7LgcymqCAgu3UxTpFQ/tNYpHYLhkeZ0n/aPrniKMJDb+aIcNySQXyZJKMpDv5V/tYfj7Y400lZspntUtKiYGKbCrZXlaoAKImaElfXGmK11a1Heau9r9uL23OlEoPWTCLbsUwjPdFhvd9q5QS/bhyILf3Pi09LxXhlfF9bjDluIc1Q4pK+r3c2bP3zloPBCyO8InjBsYrzpduOKFbcXCmD7YSAnxcQTsJSJw/7cBMTaBDdAJ/fpteuwtW/SDYOivm42BNH49bN8Mcc6suaFQ/6P+kRTygV1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7912.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 18:58:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 18:58:44 +0000
Date: Tue, 24 Jun 2025 14:58:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Steffen =?iso-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Cc: stable@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmem: imx-ocotp: fix MAC address byte length
Message-ID: <aFr1X5mhZxQpLiUv@lizhi-Precision-Tower-5810>
References: <20250623171003.1875027-1-steffen@innosonix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623171003.1875027-1-steffen@innosonix.de>
X-ClientProxiedBy: AS4P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ac3d4c-7309-4e47-674b-08ddb3512495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|7053199007|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?R/f/idw4vqs/yW5Dllkbk274xbFPH0qv3V8pq/YHKwbYWjbrWPlHVV7ac6?=
 =?iso-8859-1?Q?1stA2+HKBlehgraRLZzXfOAFMjP5iF1O94hwE9sooSTSBVxx68G/bgS8uT?=
 =?iso-8859-1?Q?ZMV/KwxZJDu61dy/jGCasP/ZuG8+k/YY+f97H+nxuOHJ1tv4R+zO8TdExj?=
 =?iso-8859-1?Q?2F+na2khIQ+lifCm5gnDV8jQbyqIogRCLDM2P4rhuLWxHcXI7yXBU+pqZu?=
 =?iso-8859-1?Q?P2S6VExe+b4qIxWB9uFctUl5m8q8nX1ScRQr2xWrcIwXODt1jxQQ7qxntD?=
 =?iso-8859-1?Q?U17JGMQm9OZiFKrf9lrnRoC5odTYJhjIDF4Z8anlDBC4iDLjrl1BU9GCpL?=
 =?iso-8859-1?Q?O3y9G1wqCpEllb/ZOO9NNsOOh/ZOV9FHQhxA0zdMA4Sv6flKpAcP4OoYIN?=
 =?iso-8859-1?Q?cTH89cDbYk+mSE5sy2v/cELmEGKyL1y+xJyitRq+GHn+P/yUSOGNfGZgkL?=
 =?iso-8859-1?Q?J/Ai194hFLUtjrC882hOSfbmJewMNZoSyc0OZJlVDigLabQCaewRpV9q9a?=
 =?iso-8859-1?Q?t0HZ2+lmz13OfHA6uW1L0jn7Ep/Gk9f0NrXguj9ot6dewo53KOqavW2cMj?=
 =?iso-8859-1?Q?u/ofxCv7w5LSdb6NUo6KgHHunoKS3XDZ++3Z949f5iBrDF/5+frdhNIvF0?=
 =?iso-8859-1?Q?B6BSzA1KKSUcJgJ8lMo5D6dCVBxXecRBRGt8J07bxi9k2oxjGXf5ZiK3x3?=
 =?iso-8859-1?Q?DLUV83TwsNyjm+ErRU+zCVIiZQePLmjb4TcBU7kyQyR13oTfoWzps4PKOt?=
 =?iso-8859-1?Q?kqcolUeKBPAm2xLR4ZxCJHRZNyW93NVEMskVT3KNPfevEn89i3S7ONHgtb?=
 =?iso-8859-1?Q?rXo9BiwzrnGDpk/87NLNN7scRQ0lPRLoCNfF0/uj5H63qJo+7Ou/+46b2u?=
 =?iso-8859-1?Q?MGvqsvthP1atZhwQQdWx6aMOE2nOv3d0rXVf9MqV1fFvm6eq7FWjvu69L2?=
 =?iso-8859-1?Q?rskgCg6mCrB1W/AgRhAVuYB0Jm5yRaj6dW4qEIzuWnSKQRD2ipRJKLC+BD?=
 =?iso-8859-1?Q?D2Jpe405SDmPonDdheCH4smTLxampQvDMkpfmY9ol9e8YiRYceQUX2u8BR?=
 =?iso-8859-1?Q?7ZMN00OhMpWdiBkWZqB2RciyORx9Ady1zwVJi7OHkp61toPLjIO2VJD1h6?=
 =?iso-8859-1?Q?jwe2T8h4I78LqvmJTXm87NyJ7c+qO5WKnO6XsBkvDKoU8wwS/Acvf2uhkd?=
 =?iso-8859-1?Q?LeIVlOHb4jI6GP+aGcLhbq8yhE6JAJETkcV4+2VTx6U1MLs9qCSTlKeJG5?=
 =?iso-8859-1?Q?CRvGdZ93g2ZD8YMkVdV95JO7L00lrNszQFPzm5RIkf1s89okZ2kvxi5VA1?=
 =?iso-8859-1?Q?1CHgliHVUqlWbcehPZIeYF/VXWvi0LnwmsAbtX1mZeHqOEG9FZ6pTK0KLC?=
 =?iso-8859-1?Q?2c1pJvU7Mi0ByW12XP7M6Bm3Lx51Kv9sUcsoKoezoxcNdno0Yq/BB8WdAT?=
 =?iso-8859-1?Q?43fqdXKQV9/X3nvgv1KMZUiPylKszcvRhLIn/x8M0h4yHgcaKVNwoOkj4D?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(7053199007)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?xf3zDpgkUxofuxnIyKt04AUvqg0yJv99Z5rsdQMA8Iap1o0J1vmlcWv5++?=
 =?iso-8859-1?Q?W9u0RjDAtunfhl6Jew7hYZlKjjGV4ShOafe3AYmU3lEV9YOZkaBcDmn0u+?=
 =?iso-8859-1?Q?3udPY5PX3DzyPKiIIha6c6ghzdRJkKOnwwZLM2xfBAJWw9mtjeq3dwQNws?=
 =?iso-8859-1?Q?fADlOGVJHs9kI5xCWRZ4Yn1NSDAx/kbkUXasC/BtiAfAcp0juLRlGObqxb?=
 =?iso-8859-1?Q?78tDEPMRWGdXgTPuiTAXWVbZOLrUsa8T+UW8GB55iA+XCVgX/vYOKJ/6S8?=
 =?iso-8859-1?Q?eJ2X7DXDnIGr4+UvoTvPTBpny6GNVTRRYTx0XExTV5GKXZhlIkzNpYDIde?=
 =?iso-8859-1?Q?BL+ZWIhyhR9YTw0/YJQ5Sz1BM+V238PWxhBH+pPXqYg4u36ZqP8wiA6DPe?=
 =?iso-8859-1?Q?73TBV0eP7O3F8W6aCSPDCjVJb5A3m1/Z56G21Ca1GEvkGyMt2tADcUxLJy?=
 =?iso-8859-1?Q?Zq635dgzCptZ9UnZCP/h9+JwLkzaTDYxk2Ux9fAWz5eVl7dYO9I7vIr3ou?=
 =?iso-8859-1?Q?RIc5rA5CiTLv/br1UkPxDmbNH0whIPfGVpToFJa2eweCPcrufmNB/yMY2O?=
 =?iso-8859-1?Q?+itrCWiIBHAHlGCCE5Lg4oLeAvqiPpNJ73X07NqyJJ4ui4YDBOKCsnkOTV?=
 =?iso-8859-1?Q?CDqYRLEB7Kqa0pnXG6DvhzDOJP0ZeHTc/N1oJ9FWTHbNrCkJLLAEg3KXZM?=
 =?iso-8859-1?Q?tbNU+DttdQyc3ax8zila4CM9jQSFZ3vW10+yr5uLLKdpoK5OEN8fWG2BWf?=
 =?iso-8859-1?Q?OdmtNKqu4xui2tAi++fyzs7JU2xM8sAAlckuIKD81OR8BQzcyitQIGOWkK?=
 =?iso-8859-1?Q?k6cHuZD6YI3ruIFb91z5kjJ+24wUjQPUNQCD/Fk8rQj2WSQIFSsCwVMXVV?=
 =?iso-8859-1?Q?dpk5kV/kCRytGBRCUzeakbKz7LJQ/hbVf/bVR5KmCqnB8st2EvKZxGQCg7?=
 =?iso-8859-1?Q?MAVXDsYQeb51QhMDcnkTKeuBzapgnMWKrHQngetV0co2L+AwFK+QuKWbRg?=
 =?iso-8859-1?Q?6caTQ28mE2gRCBTVvx+jUOMzjK3UIK+b0A2Le5YVoFf02bS4Gr1LZH0v56?=
 =?iso-8859-1?Q?+Kz6MXe0kOjTCTPI9wJvPqyNdW6cBTGWDMuyc3Vvw7iureduL4fkm5mpzZ?=
 =?iso-8859-1?Q?pQyLEBUUCOymgVHehdM7uJ35/GoUIAoAH5J9pQEX5eGGuz53VZK7pOMgf7?=
 =?iso-8859-1?Q?r7hZ1EPC/SN+E4MGGefamrgkajkcpQXqxqRdONZwhOnVgb0XJRAmiwWzcd?=
 =?iso-8859-1?Q?yLluwqITIV0YHgPPg2Cu9j+4g8dBuw7gg7RxpJ8LgUbk0s41BcOQk+e93X?=
 =?iso-8859-1?Q?po8WwAD+WSLF6dSxtwTsg00fbVOMlFxH0sApnIHkyzM1U/vu7ZGI7mHtMC?=
 =?iso-8859-1?Q?3MSvw6QqU9WZQhhRwtG+axiavVTWEK0iH/5JW1BxtUjFoAqDW7etTwE3gL?=
 =?iso-8859-1?Q?5AXLrw90dw1m/Hwhp+gjU+uP/dxkH7y0WjS+lQPJXqOqSRUXDVpmL6NFf0?=
 =?iso-8859-1?Q?USC5KEdhiYTKJHeztv8383nzx9U56kRpbX6I8mV0UN4dRSmFVvvqeO/M4u?=
 =?iso-8859-1?Q?FsCBufSvItMC2dWJ6CxWDapVuTu01xxOScWkedf/u60AFcNzR2UnMD1o0N?=
 =?iso-8859-1?Q?4Oh7yv8XdMUkBrqOpD3+4pbwocpnCEFOsW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ac3d4c-7309-4e47-674b-08ddb3512495
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 18:58:44.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eL9VqDIRV5/HwSWpV0IeXPueRsUT0IXrdNhG3h2zX5ZKIXzeAeamyGQRFOKUbEev+O75u/hFQgJC+PELxr3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7912

On Mon, Jun 23, 2025 at 07:09:55PM +0200, Steffen Bätz wrote:
> The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
> extension of the "mac-address" cell from 6 to 8 bytes due to word_size
> of 4 bytes.
>
> Thus, the required byte swap for the mac-address of the full buffer length,
> caused an trucation of the read mac-address.
> From the original address 70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14
>
> After swapping only the first 6 bytes, the mac-address is correctly passed
> to the upper layers.

suggested commit message:

The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
extension of the "mac-address" cell from 6 to 8 bytes due to word_size
of 4 bytes. This led to a required byte swap of the full buffer length,
which caused truncation of the mac-address when read.

Previously, the mac-address was incorrectly truncated from 70:B3:D5:14:E9:0E
to 00:00:70:B3:D5:14.

Fix the issue by swapping only the first 6 bytes to correctly pass the
mac-address to the upper layers.

>
> Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Steffen Bätz <steffen@innosonix.de>
> ---
> v3:
> - replace magic number 6 with ETH_ALEN
> - Fix misleading indentation and properly group 'mac-address' statements
> v2:
> - Add Cc: stable@vger.kernel.org as requested by Greg KH's patch bot
>  drivers/nvmem/imx-ocotp-ele.c | 6 +++++-
>  drivers/nvmem/imx-ocotp.c     | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
> index ca6dd71d8a2e..9ef01c91dfa6 100644
> --- a/drivers/nvmem/imx-ocotp-ele.c
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/if_ether.h>	/* ETH_ALEN */
>
>  enum fuse_type {
>  	FUSE_FSB = BIT(0),
> @@ -118,9 +119,12 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
>  	int i;
>
>  	/* Deal with some post processing of nvmem cell data */
> -	if (id && !strcmp(id, "mac-address"))
> +	if (id && !strcmp(id, "mac-address")) {
> +		if (bytes > ETH_ALEN)
> +			bytes = ETH_ALEN;

bytes = min(bytes, ETH_ALEN);

Frank

>  		for (i = 0; i < bytes / 2; i++)
>  			swap(buf[i], buf[bytes - i - 1]);
> +	}
>
>  	return 0;
>  }
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 79dd4fda0329..1343cafc37cc 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/if_ether.h>	/* ETH_ALEN */
>
>  #define IMX_OCOTP_OFFSET_B0W0		0x400 /* Offset from base address of the
>  					       * OTP Bank0 Word0
> @@ -227,9 +228,12 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
>  	int i;
>
>  	/* Deal with some post processing of nvmem cell data */
> -	if (id && !strcmp(id, "mac-address"))
> +	if (id && !strcmp(id, "mac-address")) {
> +		if (bytes > ETH_ALEN)
> +			bytes = ETH_ALEN;
>  		for (i = 0; i < bytes / 2; i++)
>  			swap(buf[i], buf[bytes - i - 1]);
> +	}
>
>  	return 0;
>  }
> --
> 2.43.0
>
>
> --
>
>
> *innosonix GmbH*
> Hauptstr. 35
> 96482 Ahorn
> central: +49 9561 7459980
> www.innosonix.de <http://www.innosonix.de>
>
> innosonix GmbH
> Geschäftsführer:
> Markus Bätz, Steffen Bätz
> USt.-IdNr / VAT-Nr.: DE266020313
> EORI-Nr.:
> DE240121536680271
> HRB 5192 Coburg
> WEEE-Reg.-Nr. DE88021242

