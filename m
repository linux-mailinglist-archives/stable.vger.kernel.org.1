Return-Path: <stable+bounces-52210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2956908E3E
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA61F26886
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351615E5BC;
	Fri, 14 Jun 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="foNA0PW6"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C015FA85;
	Fri, 14 Jun 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377614; cv=fail; b=fvlZHVZQtKZPYgRJZVP9AVARdfQJbhpqXi2xGmlaAZGlMsHDseOAcJSdewqGt9pzXgXiOax+wCGXbsZt+ReFMxQ0TCMu6tZJu5scIYmwbP5yXL9r1qfyOq5kxDjkiF6ssEGeTZIXAtLPdu+LIHQRAhD0cfl/QdVyEN1ErTYFgp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377614; c=relaxed/simple;
	bh=lqtrkXlvB6jaUeagoDImeO+zJ9efDlRCxo22YvWLl1I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=IdGrOWE1T14P9yFLOopKkaERDd2h9JI45dRe3AYZgU/EI/uJU0uV6hMGa4t8uld+WtI2gSwiHBbBFvHHYT0j41QhXigCiZ8OjmdBGlxgfrk6aPm6anHNYcVlKiCbwG5kKnA9YOTeBgRxDpgkMfZY93WeXSQExcgkL2A4qM7v73k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=foNA0PW6; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmOEsNs7tN//OmBg8oPEAHyWLKi3s05wjDObBsELvN0XEbufry1KoRBKUcPOwZJ2+jXo2nQ2y8PsofRVU7ZKYDaldHrnFjYZsvxgm1iXtTZo/Kffeh3r4BA/yflpFXi/kD9ofySW7gr/twh/x4BAwkdlnfjYj5wI8MvaRCgx9m6jOjAhBDqDCYykLS+TekfnbvTtU1L7xgRpUAFUehuQ1PruTpp5LyjvE0D4okdiPKPSoi5DVzTxpmSGrJruJaiR+m2bIhHRthvMgizE718TvJnPKDfiQ4uJ+szTiFQgfKCfXCHdZ54p14dZP3vGYvhtJZucacgQNNhYg5QGWhE/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmybNA8zmvr+zpolJ79ZdwLTD04iZ97to7G4XKMaQU4=;
 b=UXlF0xPGqJmt/hfOnPEDqka8NAfBGtBHwC657ue0OshlEGnRxIu9qzfMMAsOZ39o7+NxmZaFYQMlWJbazou0ShCM/O0dUj/NxBF/8kJIFOGer3eLoSF7q4M8Sj7Vq8ejpOnAOa8eIUnVzzK3TXpKqBNVIPxP1a//khcawNLb7OglQQiBZeB9+7NBx/N3knbpcONLiA/xA6Xp35+pNNA81N/6z2PlmAk8SkxWiEPAnp7JSuENudWuqeJih7nCUFFOivklFBd99E0QA59qVjnLI+PUsN6ecNNYC9gOB2xhP52I1z3xTBejLaC28bB9v1m8Fz+WqBySRUE+wn31bY4MZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmybNA8zmvr+zpolJ79ZdwLTD04iZ97to7G4XKMaQU4=;
 b=foNA0PW6fdUsGhp8yL2ZpKE52wawoPnEDVnf9WHNVyu9ORTUzChH8Ap4hmPPrqaTaEa/Aac7RL+1eBG9c2xH4fvQ+CR2jpasLCIFWa7u0FFgekC+xzfqKbBYN4SNIsM2JwAwVlkBgj/bzSvWaHqpRpRlfeu/JS7rrIHT8eU8aRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10971.eurprd04.prod.outlook.com (2603:10a6:150:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:06:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:06:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/9] arm64: dts: imx8qm: add subsystem lvds and mipi
Date: Fri, 14 Jun 2024 11:06:24 -0400
Message-Id: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHBcbGYC/3XMyw6CMBCF4Vchs7amM9KCrnwP48JCK7PgYosNh
 vDuFjaaGJfnJN8/Q7CebYBTNoO3kQP3XRqHXQZVc+vuVnCdNpCkXGqpBbdT+WhFPQbxDEYcK6V
 qMs4q0pDQ4K3jaQtermk3HMbev7Z+xPX9m4oopFBaFYRG547UuZuGfdW3sIYifWGUP5gSLsoyx
 wJRO4MfvCzLG7xljPDnAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=4094;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lqtrkXlvB6jaUeagoDImeO+zJ9efDlRCxo22YvWLl1I=;
 b=FdccWVwDV3Huv6LxzzYFssoabAjKovae9e/S7kXZLRXdYSRzxedBmDPHz3Fv0qA0UD0ZoesuL
 jzUsa+ekYJUBqG7XKgSVSIkyDb2BfC1/AyKNazGIWOt3GowJeHmULLb
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10971:EE_
X-MS-Office365-Filtering-Correlation-Id: 17768ead-5fb4-4939-2929-08dc8c839cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndWTE0rblNaRWs0bjRleFN5eHhQYnNPYVQ2dDN0Qk1UUlFjSkcxVGJIWkxT?=
 =?utf-8?B?TVBrcllVUmQ1M1V0M3kwMzRPZXpJRWFoOGZtRFNWL1p2V2huZUdDUzRoWTBy?=
 =?utf-8?B?QmZoN1NhK005QmZJZUN6NExxT2VFMXVRY3BEYyt1Y2hhcktKQVRXVGVGNU9C?=
 =?utf-8?B?V254dzVINDNBTlVQbnhMcVIyRFI3eVh6Z0JBUmxtR3Q3SUxScjJGVWxBU2xk?=
 =?utf-8?B?eDlISHl0OGVQOWJlZmVvdEFBOWxvRmVick51QVBXYUI5SForclREVXJUd0g3?=
 =?utf-8?B?bFU4eTZnbE93K3JzWllWMjdCd2NmZDdmWWRMWkJBOUk5SW9iVXR3MnphclRB?=
 =?utf-8?B?eG11dFQ4cHdZSjhiL096VzJ6SElqdGtKYWdUOHRNeGVvRXhlZzFOQ1JPUm5X?=
 =?utf-8?B?Mnp3Qk05RGFiclRSSllTMW16c1BPTzJ4SjNGdE5NdlpuMDJORVdQQmpMR25t?=
 =?utf-8?B?RUR4Sk5xek03UXhaU3BsaEcyTnpuaDhJVDNadFNEYlR5b0tUS0tZbWZlNE03?=
 =?utf-8?B?MmlhU0RpcTR1ell0anJMeEo4aWZnV0VEdSt1KzBON1VmWjBQOWRYYWZOWDR6?=
 =?utf-8?B?S0NvYkVneUJ1akwvSm1xR0U4dDVZWFJzNlNTbjN3S1lQZE5CYjR2dklobCs4?=
 =?utf-8?B?UTU3MFJqNTN2cnJ2L1NicWVza2t3Tkk2bk1vY0ZkcG16UGp5M2NybmgvU3RK?=
 =?utf-8?B?enlPL0lNUkxiMmpmTWZzNk9sd0ttZmh5Z0RFVDcweWJoQ210UFoydU9sNHVM?=
 =?utf-8?B?citNYVY0ZkpHU0crWXFBZHNDbUI5enhsV2lIc2VTcTF1NVpZNUN5OHNCMXNh?=
 =?utf-8?B?cERpbitPRjR3aStQMjVjMjBFLzdjbS95QnA0WkdtNzhHUFJNdXB0Q1JqRUhQ?=
 =?utf-8?B?Y25qdjJ5K043ckt0Zng0ZG1vMlJnRlZJaUhycGYwVlBWOFRmK2tmUTllYkFy?=
 =?utf-8?B?YTYvSFhVa3Y4alpwTUdKbVRKUElzRkhZLzBMOWY1SUhlbU1YY0twRUhNV0JY?=
 =?utf-8?B?ejVmdzcwbUExV2FGQ1kxWDhRaGJUMjBqSnpDOTc2dzRMeUhRT0dqSlRiOW5Q?=
 =?utf-8?B?ZUM0bnJVM2JjMno2aGxsZlIrQTkzUTZYQkR2S3IxN2VScXBYWFVWVEo2YXo3?=
 =?utf-8?B?THdVamZFS0ZJM2IwMDY1QUN4U1B2VkxSMjVUaDdMbE1rcXJ3NWFkUFBaS1RK?=
 =?utf-8?B?SngvWUdvNnFnVGYwTE9yS0xUeEIzNFp2NXdiYU0rZkN3NkQ3a2JiQkdaclBE?=
 =?utf-8?B?ZmUveU5kSnA0SEEvZ2gzZWwxODZ3KzdBbkVRWXRwT2p0N3RyNUJ4OW4vbS8x?=
 =?utf-8?B?U2lkQmE5ZWt5Rm15UGtJTnFNUjVOSVNQcG85cmloL2Z4THRydEVmYVVhVElX?=
 =?utf-8?B?QWhXanlHSXpsbzQ3OU12ZTg0aEY2ckFsczg4KzRtWFRNZWluMXFUcVFqZ0xS?=
 =?utf-8?B?Y2JVeXZvS0Z3R3N6SFdpYVNTa0N0L0FZUnFkZjJkZWt3ZlgyaGNWbGM3MnpN?=
 =?utf-8?B?UFZGQmwrTVdlME1BOTlweXZEOGFSL2QwNzkvK2FZVFo4L1d1THRKajdva3Fk?=
 =?utf-8?B?RWsza0s2ZzRCcmtESE5xcVRheVhOaDc5RHJQdUpqaGhkVi9mWW1KQ2VUVlZO?=
 =?utf-8?B?d1M2ZGR4Z1JCenNnS1FOblN3bjhNTW5QZ1Rzc0ZFSi9KVTBYQ0FMcGV6YXpY?=
 =?utf-8?B?bUN2dnFIYVVVU0N3U1BsMERwOUNiRWlJSTlQZmdFWFUxZXR6dDBHVXVxOUIz?=
 =?utf-8?Q?jKkVjbbbCUMc6+odAJOTDg7QGwMP+obYYcgmrD8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25Zdmw3eVJJbHJJWVF0MDBselVRWDNGaEluZVYxWnV2QStUbXFVOHZUb3hC?=
 =?utf-8?B?ZzZFSmh3N3I1c3dqMmhmcndldkU0WmJueDNVQUFheGpPMGpoM1VKb09pT2ZK?=
 =?utf-8?B?cEdRdjlVS0ZTUmVQQlF4SVE5QkJGRlBSd0ZvbFZtSUpGdDBiUDkzU015Ulhk?=
 =?utf-8?B?bDhsUjFzOXp0YkVvdWFKZEpkK0orYzl4NnlCK0xOVkg4MGtCMk0vNHAwblMz?=
 =?utf-8?B?cUdnOTdGRzcrbHRncFFSdnVJNWpUM215dG9jSjNBd1prYW5tbEw4WWgvY2pv?=
 =?utf-8?B?aHlVMHljaERabnRqQTRmeTloazRpV3Z5SlJqdzFDTnJPK0hPRkZiWnlJbWMv?=
 =?utf-8?B?cnplMjk4dzNGZ0tDbFlTMHdtRWM4Zk9SYXRvcDBQZVNGZmpIRk41OFhVWGpx?=
 =?utf-8?B?ZXh5alAzNGV5Um9ERVYrUnVTejA3YTZDVW1PZVFxNGZmR1FqdzZrK00wUk1a?=
 =?utf-8?B?WGw4Rkgrenl5K2dEV3RGQWp4WXZVSm5KbFJGdzVTN2xnUG5rQU1LajZEYndQ?=
 =?utf-8?B?ZnZnUGpkcEx0dlo5ZmwrazcvbTJvWVVpb240VkRVRTRsYXZtR0QwSTY4TUNC?=
 =?utf-8?B?V0JRakpzdDdDMlozOEY2MW5ZTjNMOXd0OWdaVW5kS3I4eCtoQVg4Uy9SRXdQ?=
 =?utf-8?B?TUdWdXA0cFVDdmlsVktSdVk3cVNMWG8vUm5ESklxT2hKbDc3L2pEejZSUDY4?=
 =?utf-8?B?Z3BmdnlkdGJORURYQ053N09uNzQwK2xTRDlxc3Z5TDlCSk83aGpMSVJiMElC?=
 =?utf-8?B?b05ISWNtZDU2ZGNPa1NXMG1kdkRFc0doSlZqV01JU05hUDRuc0ovdUJtR1M2?=
 =?utf-8?B?RFRpeWcvNjZaNC8waFFTbm84eGcxRWhDT2FmZE1NTzVwVEY4bytyeXp5RHA4?=
 =?utf-8?B?L1FrSzh4U0kzcFFDWjRpOFlUUW1uOUVIZWlVZUVzdnluTW56dTllclI2dnRh?=
 =?utf-8?B?SGNHZFVpeHg2NGI3OVVhV2dvSDFraHZPdTNYQXdjdi9RVXg5WFV5K3VOdFlq?=
 =?utf-8?B?dkNXZGJIZnhmQ0JkdFNjaExPL3lzUXFpdHY1djNRZkd1SHNrOTdEQWNuWkFW?=
 =?utf-8?B?SzFqNVhSWVZFaVl0aFRGZFdlOEFYZVBIcXdCZlNjK05YYW5HZlFSNWlsb0RO?=
 =?utf-8?B?OCs1c21xcUs4M0RSZEFNeDdFMytrZy9ybWZUNFpNMThTUGMzOE84LzM1Z0VL?=
 =?utf-8?B?YWtxdnVOc3BJKzRjeWJVZnFtNHBuaWYzd1VTWnFlZm8xT1kvaGJ3eDlQN3c0?=
 =?utf-8?B?K2I1RFhOVHEwdkQ4Q0p2NWNuR1phbEEya3NEVVoxcUpIa1NMWWpybnVJRjRQ?=
 =?utf-8?B?OUlmbDFMS3pSemM5TktGVDNObVZycDUzQjh3Q1hObldoNE5hUzVlcWhuNUVu?=
 =?utf-8?B?WjljRnRYN0hpUE1zckdab3pWNlVFc3lDWmpQTXJvWDVnYXpLK3hwaDAxRlg3?=
 =?utf-8?B?MFJ3QUVadGUzdVljMTYwM3d5OWV2SFYzc05FeTlvbm9NVlVHUXd1Y25VMnph?=
 =?utf-8?B?U2twS2dyVDhJcXd5ZVpsTlRiY2JFUmg0dXFwTlB3a1hFU2RaY3RCaFpxbjZV?=
 =?utf-8?B?VEtzQ2tORU0yY0M0L29CN05aZzFXTWIvK1FUWEI3Q1V4aW8xbzNLNVNzdTZu?=
 =?utf-8?B?UG1OR1JTUWhQcHdzdjlRMlJjNzVBOFdYK1JkVEU4TzVnalVwbHpSTCtYMEZG?=
 =?utf-8?B?SFpuZ2J5TmsyZXNyRDh0ckdQbnRFMFlKMjlqSlVsRFhrWlYySVNGeThXQTFU?=
 =?utf-8?B?OU5Td0ZmdlJlZm5hSE5Dd0laTk1LMGVuckhneHF3SUEyOUdCRGsvbWVQdWdE?=
 =?utf-8?B?OWJjdzlZL0VBbEhMSlk1b2Y5cnp2TktjZ3l5OUovOXZtR1VONDNZNXJNbnVx?=
 =?utf-8?B?dTNicXg5eWtlYzE4aUxDb0xrRjR3Vjl0SGRaRkxqMUhJYUlhcVFHUFpHbTRD?=
 =?utf-8?B?ZXgrcThxOFVmZ1VaMXAzY2dtVjRyYXVlN3R3L3pGWkdGL2pHVnN0cUlWOWFX?=
 =?utf-8?B?Tmtid2J1MEdoSEZHUmtmbW5ZVnRMY2o3bkNCWHQybVdPVm5VbGRtQXlteldH?=
 =?utf-8?B?aHYwYW5vbGtpcVM4RVN1U0J2TmIyU0oxOXlSdExPRHFQSlBzWWdPUk83cjFu?=
 =?utf-8?Q?t/Q4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17768ead-5fb4-4939-2929-08dc8c839cb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:06:47.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZTbiJMH88a98aTrt970Z/bFTKoW24fwg3t261eGnUrpnD7umHEK4x9L8umnA08G2szOnKTiTeQxfqiRcBGcCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10971

Add subsystem lvds and mipi. Add pwm and i2c in lvds and mipi.
imx8qm-mek:
- add remove-proc
- fixed gpio number error for vmmc
- add usb3 and typec
- add pwm and i2c in lvds and mipi

DTB_CHECK warning fixed by seperate patches.
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/fsl,imx8qm-cdns3.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/cdns,usb3.yaml#

** binding fix patch:  https://lore.kernel.org/imx/20240606161509.3201080-1-Frank.Li@nxp.com/T/#u

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: interrupt-controller@56240000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#

** binding fix patch: https://lore.kernel.org/imx/20240528071141.92003-1-alexander.stein@ew.tq-group.com/T/#me3425d580ba9a086866c3053ef854810ac7a0ef6

arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pwm@56244000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/imx-pwm.yaml#

** binding fix patch: https://lore.kernel.org/imx/dc9accba-78af-45ec-a516-b89f2d4f4b03@kernel.org/T/#t 

	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-0: power-domains: [[15, 278], [15, 297]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#
arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: imx8qm-cm4-1: power-domains: [[15, 298], [15, 317]] is too short

** binding fix patch: https://lore.kernel.org/imx/20240606150030.3067015-1-Frank.Li@nxp.com/T/#u

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in
- Add imx8qm-ss-mipi.dtsi to overwrite mipi lpcg clock setting
- Fixed order in imx8-ss-mipi0.dtsi
- lpcg arg0 have to use clock indices, insteand of index, so keep current change
- lvds1 and mipi1 keep current file name to algin exist naming conversion
- Link to v2: https://lore.kernel.org/r/20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com

Changes in v2:
    Changes in v2:
    - split common lvds and mipi part to seperate dtsi file.
    - num-interpolated-steps = <100>
    - irq-steer add "fsl,imx8qm-irqsteer"
    - using mux-controller
    - move address-cells common dtsi
- Link to v1: https://lore.kernel.org/r/20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com

---
Frank Li (9):
      arm64: dts: imx8: add basic lvds0 and lvds1 subsystem
      arm64: dts: imx8qm: add lvds subsystem
      arm64: dts: imx8: add basic mipi subsystem
      arm64: dts: imx8qm: add mipi subsystem
      arm64: dts: imx8qm-mek: add cm4 remote-proc and related memory region
      arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
      arm64: dts: imx8qm-mek: add i2c in mipi[0,1] subsystem
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc
      arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes

 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi  |  63 +++++
 arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi  | 114 +++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi  | 130 ++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi  | 138 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts      | 280 +++++++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi |  77 ++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi |  19 ++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         |  27 +++
 8 files changed, 847 insertions(+), 1 deletion(-)
---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-imx8qm-dts-usb-9c55d2bfe526

Best regards,
---
Frank Li <Frank.Li@nxp.com>


