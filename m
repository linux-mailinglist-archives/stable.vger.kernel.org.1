Return-Path: <stable+bounces-225321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBCWJ3EetGlLhQAAu9opvQ
	(envelope-from <stable+bounces-225321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:25:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC93284E98
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AED831850B1
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3C3A0E93;
	Fri, 13 Mar 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iqgzL1qB";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iqgzL1qB"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021104.outbound.protection.outlook.com [52.101.70.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13538E106;
	Fri, 13 Mar 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411664; cv=fail; b=KlSK23yKnxCFBF+672iUpbREhjRQS3PmPV1bTYPKku3RatvUONr1Ww/6ZUOjXdzPI7aLfgV3v6blOWxECjxLeVR6EJWGr+4/etY9V7T6TTfKYg5luUJhg8RqjCl04pnMATKSycMG2Y4iNstm7b6C29g4zOXKIrq1BM+RZrGPOrg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411664; c=relaxed/simple;
	bh=i7XOoTXVDJd9N2UNyVZ18TOJeKvb4v4+2+1/lZfk1ec=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aCAlrtilzsZ0A+sT+3sarD/Brpe2sM3HTR1cZisR9vd/ErWITACJkPyawJv9srw11S+i4oL3olc0aL0q29M4XFzV5HmWZxd+5qX0AN5xdlel/H3SA4jMjQU7Iw2HhTVw0OungI+mmy8kZRiaDAZGv+9Er6qvraHLKSHJ9fcotqo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=iqgzL1qB; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=iqgzL1qB; arc=fail smtp.client-ip=52.101.70.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c7xRMuOuyZAHR5Xt1cWEshh9cnn25zDwCjCs6ekkaOvS5ErcgyZH7yEd+jVoUerSUxeK/YRbgRantzG8u5Nuq3R3+eWmp87VymdSweJXDUq4sNR4uGAnIcgnM3cx/4H7mVVRc6FRteJROpYMui5Nlxw7jMM52XOkpISIfgpZfJJPSQqo8dfRsrh4A8C2BFfDn7YywqlOR4eEs6y+aBZgjv00U+VYaSxjEQR0kxodm4yJwn4ZVG5BAH59Ezp7lmVnvkcTSYf8KpoTRmjJnl1kouyrI9jYfnvWp+FFTteOVMduwSOz3c1EnKyPo7CqxHfPhYB9R4ZC+4mbAH2AlanqCw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GPzGl7mziPTTcNGK/8NUy5ErlggvHkOppiPrM994xk=;
 b=RG3OgaOyenuS50Bx61Ah8+HN8vJInoWJgHq3fCw4AIn0JLvCqaCl0/v+phpTc+j5G/M5d7jQer2+LDFCXoha+ZouZaiH/AipKjxW9hRaVWvI2WXhcUMi0jC9y7T8fe3bXOSoSnOwsANZkBugkIgndIaGku0wGgdtwjicoCtNfSuTp2GpC0ZRmQ9Vn/iu/Eu5D6OPAEZliXzkdGpLiAJoRGqTpoLQQkDD5Btv3qpLr0Tu5FVviNWhqdgcawJ09z2fSDBTP5UJiq5xBbyVFN6YKSzhkvcrkUQ/k4gjLh5u+uyBkDNnoonwD+8+E39Lqlx3NNg8BTTrJW8UKPg5mPLAew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GPzGl7mziPTTcNGK/8NUy5ErlggvHkOppiPrM994xk=;
 b=iqgzL1qBflAHy0BFEWFY3YcRvXm2nkH0pOKOQUVmjPrdgl2ZVFV7zTnowqusiHW0oumi7rIngqaYr1dnAC3puE0wE2cs2qBw68ZbyVYcaiFXlnySXFyM9sWtq5e1c0YRLqszoOM9vvXksqqYQc6iOmnSgflXiWt0IMTiTUsEG3w=
Received: from DU6P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::12)
 by PA6PR04MB11714.eurprd04.prod.outlook.com (2603:10a6:102:526::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 14:20:48 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::7b) by DU6P191CA0012.outlook.office365.com
 (2603:10a6:10:540::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 14:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:20:59 +0000
Received: from emails-1215738-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-180.eu-west-1.compute.internal [10.20.5.180])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id D262C80C98;
	Fri, 13 Mar 2026 14:20:59 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Fri Mar 13 14:20:53 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgWh+UGCFJV4wqOl4Q276hBBMlvuOHP6OZboN8Yh7EFE9YO/BbN3NKARX3E+rybLJgGN3b2pCaKj1knYAvZq4fWph9LBTQ8CTw3h7RcCAU1IzGsB2ZWV35OLb98rSxl1tBm27xudHayy1hhNLB2I6uG4BlmK208BJarxSr9qIZsl5qwcHYb35hEqTL89JMFFr98i4ceo30JOoVGwwx4j+0BRWXr3dLhQ8flKbkLRGn5CCzGYpAx7Tr/4LsH75sDPxv4HbYo1KOXgNJkr/g/yeVjEsf8ktYm8uHZmH5MhcBoM7nK7gJ17kq6PpbIgJEv2JLgqkIZqOdj+1i6xZKfM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GPzGl7mziPTTcNGK/8NUy5ErlggvHkOppiPrM994xk=;
 b=dhZpKZmBbbY0hKDdNBAr+0WmSlbEGdesuR8nwQci9zKag6wFOd1T1UiEZEa7ypb8qrhffsrBmqdoxFhROBLGOc2UKtnS8XO53x5Qj9EqEbFpPqAbyGLXuEfHBSGUHx8ubVNKnniHLx0VPmkQFIf58zjzkwEbyxgDbZcr7MHOeuDmPbLfmcU2TAQqvG/CC0iKVeCxDCLyEyTzWtX/Bkl4QULewmnTTUqTZ00gXYeCfQfXGLyox9wboDAUhIg7yW5awNy3uRNDWNNJ7AqLcUEyuJDEsIDR0/rsDcg/WnZcuUTMSHp6r03oSmVbsjsZz+mAwWYVyLI31EcShfQewudCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GPzGl7mziPTTcNGK/8NUy5ErlggvHkOppiPrM994xk=;
 b=iqgzL1qBflAHy0BFEWFY3YcRvXm2nkH0pOKOQUVmjPrdgl2ZVFV7zTnowqusiHW0oumi7rIngqaYr1dnAC3puE0wE2cs2qBw68ZbyVYcaiFXlnySXFyM9sWtq5e1c0YRLqszoOM9vvXksqqYQc6iOmnSgflXiWt0IMTiTUsEG3w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 14:20:48 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 14:20:36 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v4 00/10] arm64: dts: lx2160a: fix pinmux issues, update
 SolidRun boards
Date: Fri, 13 Mar 2026 15:20:41 +0100
Message-Id: <20260313-lx2160-sd-cd-v4-0-aabcf230fbff@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkdtGkC/23PQWrDMBAF0KsErTNlNCMpVle9R8jC1siJILGD1
 IqU4LtXNnQTsvwD//HnqUrMKRb1uXuqHGsqaZ5aMPudCpd+OkdI0rIiJIeMBq4P0g6hCAQB9qx
 9hyxdL6pV7jmO6bFxx1PLl1S+5/y76VWvVzUyBWvJAmtHYPqmdB0G8H4Mxgn3juWrzNckkH+mj
 zDf1CpV2tpthsWDfplRCTS0ecHJ4M3g8B3A/8CbPyoDgsRoLLFDjOMrsCzLHyDCR40rAQAA
X-Change-ID: 20260304-lx2160-sd-cd-39319803d8ad
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM9PR04MB8355:EE_|DB1PEPF000509E7:EE_|PA6PR04MB11714:EE_
X-MS-Office365-Filtering-Correlation-Id: 729efe02-339a-4cc9-38c3-08de810bc010
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 zL1pTKbwFKvdKLf8uASfdrNrgLD1ovTGyh4HC0ZAZSu6lE5t0W9O3Ht9HzBCvjBq5LUe3ZzwiHP82/5YIzgURNq++3+1lN15tp0G45Gbb9hmf71PVAkI+nJ3tQvrf24BAItvbHsBmubBC67NGOfhubCs93dApQBEZqh5+ejsdcWWof0TeS65XwgPY9vutsd8qNZVk26H3DW1xT5/q2IgIPaLreuUOsYrvNhfODk+tvlrCKnLEZIQYMSIiA+ou9y75f4a+eZx34j5ShDxrW8RD6r7fTej+J+w7Sm0TeluDUmYarDCkBLoIslknbcSmaQmSJ1ZXQ5/8WVreXSGulUwpLJ8kjKZUhbpINoldXBLluJgBlenBqPR9ybZU1IMnvUUUUvBN69zB3fdAqnfkZdCmnU/hUR907S2Wgiqs1HWCNN0pSgcs+APwabdjoijsVqnTMoFzoacbT8JeKiRsSpzL7Rewzin4IslinsKhJ1Ywt1A7IB3BcuhZKX5+6SAGtp9ghfgY/x3epC9PnP/F2F+kE0I/9r0pqmtI4XIeIwx+ehSOP87o6Kg6f9nnkbdOgxTeLERadsuwcarlO6FWP+J6qvtZcgIqNDC3J882ryDXvrsTVc5UNJ7XNpVA4NFK4I4UNcnZlIEiuEiDSZz+R03Dw2NGRwJTplcJtZIigDDjDwAh4tCaI0oeCblY3xXDeJQZkz5/y4VPOu9QF1TcIl6SmbVYNjbGjKy988Q+4pdsRZbIfNF3grV2EIwB75IaJlL
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 wI8gWY2JeZLp3fR0al66rc/CXW6tU8pcXszstRq8lrzMqICSj5lg0fs2PTQMM7kEq91fUioUvt42Cb6qk0x0JvLfIdqhhZp4rHLGAPNwg0cGKkMKlY1Asik0oDeQGckr+rv/Mu/O3/DHe00HRhktxgDkkNkqXuNd/SK6tmpoIDJKV50GDR6u4luuwtmum29S6LF9W4zx3NBWaEdofyPMzRq3bxNFd8OnYZbS3/C+nORMWoj52S4isrPCr6nNrlMegJcAKP/g9/2QDcAc4/m4b/aeWSUnr7i6mcEdL3KroO6TkgnV2whe71/PosDFqyK1Q2goeIAQvDMhayiRLI0QkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d56c5a366eff4ee2a5edd6ec67c5c3f2:solidrun,office365_emails,sent,inline:952c2005d0ac146f0096286976e8bdc7
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79258ab9-ddb2-42e1-c898-08de810bb1af
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|7416014|376014|1800799024|36860700016|14060799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8s9yYecMrqBYNPn5YluvLAPXQpPDX/tIs6mTdPd8Ws1tLNHlj42eOfBjrJPULsZ9923fB1WK8B1RsGWFvmwhVFQyBdh1Vrk55566t2TCxSpZgotRfOB1CUE8bo60qhS70pwcemA3YadC4cf2wwbxViv4CgHGKGcVSA+J0GhpcPLkSDJ6WXP8bJzH69pLmq+q7e9d/2jS542GpWaLD3bH92LVJT7y4YEuKijngqo9XrU5LB3I9sABiYT7eWRPtC25xvRCWHHJj7hAMCseO3eGCwRjwaqM/l0iZqy0kbYghgDhJrfSurrgj/oxdJSNGXPNYZOsZyGoZFWAdZAJ6gsFIO9HT5zz6WbNguDaDvAct7bD3HOjcSFGLMXF+ae8k+IVE2olHIIbsT/AkpgaC07ZTTe5bH/xy/VTK3OmUPu8UTEZGVkbsG8v7mnSU2Wyzp/Pa9uwNU76yTtlgLxqvOaO4HSzyJFlO0NUN2mtmmEVlvAh4OM9gYO9mbkEw6FG8kD9HmvDyZQ6HqxxjFMlDZsB2iTOnx/mlnqX853lw3RWwoUpZ1dkaZSJqW0TW+1WpFyaYEW+03UG9EQpfcxx+7y8fWyV4Y0oS6rzXF+96I2IrEqB7QGtSGlsx4y5eb0kPpU13t6loWCC43biFJIQh/WdPxezwuW6tHLXTR02QhwXBZXLQvjmlgAtiXxC4A7Qg549rYrMbfYNczEGDwGbFPAd4eSxMZArFlA2wm5UW1dTIM4=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(7416014)(376014)(1800799024)(36860700016)(14060799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wbHfxPdqVqXyoZeNNNY65WhdR3pd61lepI71zFT6S/mIJzNvSaDtqGOQD+5NUort71PachGC0lSPQCPCB72GRLdcm/CnPqMv94Kbhs4WJooxa31EmMTIWoEWTi5A+recf7/TsfRWlQhqsa0tEOn1AfGain/XILEN3NctokP0TKuQUWeUIEQW5UVBJhxWo/E7ASZafvQpgd/wFpHcyKMi7LGdm2Kq0GISxMQ8RA+HzOKx2cRVLWSFIUqDJ8Luf8Kw+0J1qihYoXXG/Fb4O0IKGI8+hTIZg6rqzVHU9q1s4jQMpPDex+wms90aHIvHI2tp+ONiDWq3vfBSzERCwMBkUabho8kGgBrQ0xA7ZvJjpaQTfCYOPviDqTGj2agLynjcWs8SWWflWqFAa39QpnO1Tpuj2QQtq9TXUMxVN5Tw2zdhSqgJfsSUEEsoIyJG0Wo7
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:20:59.9652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729efe02-339a-4cc9-38c3-08de810bc010
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11714
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225321-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,solid-run.com:mid,solidrn.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0BC93284E98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a bug with microsd card-detect & gpios pinmux on SolidRun
LX2160A Clearfog-CX & Honeycomb, and LX2162A Clearfog.

Then make small additions to SolidRun board descriptions..

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- separated each logical change into its own commit, improving
  readability for reviewers.
- Link to v3: https://lore.kernel.org/r/20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com

Changes in v3:
- added separate patch providing all pinmux nodes for RCWSR12 register
- abandoned revert strategy, implement minimal fix for solidrun boards
  only.
- Link to v2: https://lore.kernel.org/r/20250714-lx2160-sd-cd-v2-1-603c6db94b60@solid-run.com

Changes in v2:
- changed to revert problematic commit, workaround is large effort
- Link to v1: https://lore.kernel.org/r/f32c5525-3162-4acd-880c-99fc46d3a63d@solid-run.com

---
Josua Mayer (10):
      arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix usd-cd & gpio pinmux
      arm64: dts: lx2160a: change i2c0 (iic1) pinmux mask to one bit
      arm64: dts: lx2160a: remove duplicate pinmux nodes
      arm64: dts: lx2160a: rename pinmux nodes for readability
      arm64: dts: lx2160a: add sda gpio references for i2c bus recovery
      arm64: dts: lx2160a: change zeros to hexadecimal in pinmux nodes
      arm64: dts: lx2160a: complete pinmux for rcwsr12 configuration word
      arm64: dts: lx2160a-cex7: add rtc alias
      arm64: dts: lx2162a-sr-som: add crypto & rtc aliases, model
      arm64: dts: lx2162a-clearfog: set sfp connector leds function and source

 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  10 +-
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |   2 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 183 ++++++++++++++++-----
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  10 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  19 ++-
 5 files changed, 180 insertions(+), 44 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260304-lx2160-sd-cd-39319803d8ad

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


