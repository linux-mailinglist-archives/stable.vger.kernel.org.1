Return-Path: <stable+bounces-172321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB4B31093
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241D67AA547
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1602E889F;
	Fri, 22 Aug 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U+yBo6l4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U+yBo6l4"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF4285C8D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848143; cv=fail; b=pthr1J6op5XGLVA2D5lUzT1o0s3z5mq6qioSLrMNCHgZnVc+SuejFahoiGT0DHqD+AgQpH1aBdTfIAfDyoVia5yQfif8GWG+LanqK2fE4jXqYOhBC1PAQ3yCqALJSFHDYNmBlxgu3OWGKn3qtnI2LJD6CUNsslGAZU8Fr9BiSwE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848143; c=relaxed/simple;
	bh=hbsAc/YBUQNAVzkoVHj/VlIruFr7n7BQO34iMkuRDzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPRbpRFVgrPKsCai5TyjdibaM/jtSFze59s84Mfu7jQgfa0EAhYFlV28xY5j3/G+FfDk0F1gg4XCCz/jhpT6GP4VkjpkPfqvO5/LUhMfgLkymVIm3RZwm8xX7ZLcWOBGXRUsGB13TMD0iA0Ftlfo01YUslzUhlELipFZi+d2IsE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U+yBo6l4; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U+yBo6l4; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Rx6xuqqvsQOhIXQsEdDUcdWHP/gCFuXaHfl0WrnbQfRu9m/C4knqxdB65QqE9FCnlxUKN35CdbqogS1c5qN/8u7a48dm/H1VTn/d3WfbZ0WEjRz7IqgtGGEwdaWTA3EFhNURxlRU/Peebr6LbO9/x+JrjTlAzEGbZnK/8p1oQUGJfLED0CGoTiyutKOsLY0mOkoXHYhXd8rjpSDavJajbJiGUM42IT1wcXjdLGfxBSbcAK9pWHkK++l9xWGHRmUzI56falzn2lOlXueAoVor3wQ/4fIgxnLu/oZKOR0o9ALIGfG9zZ+t18hHapJAqXjpat9JdT2iZ8gU6TlRvSEIfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2BFxj24hm5yTMEHXOvzbVi6z7YJPhhSBKi0kBuNYtI=;
 b=RA3qsLexVZNWJV5kdevrDnyl5tzxXKlUbHB+v06DqZK5qQ2OhV5CU1ObMEOrxEPGKTr9fbI9z7q5x34//As3yt2eB8ID7iIAOV1idwDu5fMAwl5ZiVKYx5l0IBpKSAqK1z/ONNrZ7RXZp/vKzaFdWBuxPuyYG19IXaPw5sQFY0u+buNaxOaTOtK4e3hfWX1QJrTIzO6fyg3ug/cDjppw2dhEMxNmykJWAVlrAicjMkNgEdtNTpGyzUQQ0D2OnoVKZiyBm28PnHS5DqOsgP2ME3TPpEK4fqXKEdXlt2A+TI4/8br14VkFTlYxFWsC1Hql1GgLjUJkRumA/FQ91yRRew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2BFxj24hm5yTMEHXOvzbVi6z7YJPhhSBKi0kBuNYtI=;
 b=U+yBo6l49KulR8eaA576je8Sg62QSornSCWLiqqQACbhpaYFkShZ1kVdbk0PjmF2rpcMMbB1DUYqoFwYhXQCIHoWg+YvxyZ2lLQKLZr0vYSHJNEw3Z2zqfcPhinDnQ5cgh4Dd7K5SM3vW/nfILu7zScfxNHf21G//dMazktSLPc=
Received: from DU2P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::33)
 by AS2PR08MB8926.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Fri, 22 Aug
 2025 07:35:36 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::21) by DU2P250CA0028.outlook.office365.com
 (2603:10a6:10:231::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 07:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Fri, 22 Aug 2025 07:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B03mW+kytFpkwQ4Bf8xJbc8oywD0eILH2Y3m775zWXUWUkhctlHjI3Y0ihiF67Zi/0H4sHjE23hLFWkpEwWbFAk0Iu9lEKpX00AI6v7ISO+S/6oSeQjcu9afx8T8BahKtPI5bOC8FXUo1HuJW/xu1SRPoLCnJffVocKLSvySrDLC4C+tfkemSmqDAEUA3eUd2Zfac9RJzVuk/uE4Kk2TIjViawmabFj+JsWMTLRM1YsOFzpNAs+XzzQdr6Gw/wTpnXaRBUqmecwnONxldN8klPWBoRXu6cr736kp7sqJwgD44+nfDo/8Ja4Z6ds55y7q1bl7MmWDGE/oZMzcXQYJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2BFxj24hm5yTMEHXOvzbVi6z7YJPhhSBKi0kBuNYtI=;
 b=NRZ/MCkA2LBzHMQWqezVpTapEqomXvgDSpQOneQ5+C6fMGCTQEXckqv+CfXGiFj5u8ijnZPr5bR7bNC+wLlnqU+iZ7FK+RScrQz75smGFeZTVw23Ww/yxjn2BZkIrWoE6JZJlkL3yiVXcY1eF4hvFthD4Hh83mhONcavDjegs+SGbFrrdnsYhrPcajiTF7mgiOkVFtAEcHvvB5Q0hfpKvsoTO1OrvuEmIZNJGqbWSmljihSnp2S5y0a/mL3yStCfU75RKBSyflOkg+lbzGRDpwqHHCuyhTJ/Q7t/SaMngg2WT8be5y16NdkMiCLhyYfjR44oWDsSFZZM6zFlyOWsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2BFxj24hm5yTMEHXOvzbVi6z7YJPhhSBKi0kBuNYtI=;
 b=U+yBo6l49KulR8eaA576je8Sg62QSornSCWLiqqQACbhpaYFkShZ1kVdbk0PjmF2rpcMMbB1DUYqoFwYhXQCIHoWg+YvxyZ2lLQKLZr0vYSHJNEw3Z2zqfcPhinDnQ5cgh4Dd7K5SM3vW/nfILu7zScfxNHf21G//dMazktSLPc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM9PR08MB6660.eurprd08.prod.outlook.com (2603:10a6:20b:305::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 07:35:01 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:35:01 +0000
Message-ID: <a68e4e65-883a-4625-bebf-da4569ccda7c@arm.com>
Date: Fri, 22 Aug 2025 13:04:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: fix the address passed to notifier on
 testing young
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 stable@vger.kernel.org
References: <20250822063318.11644-1-richard.weiyang@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250822063318.11644-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM9PR08MB6660:EE_|DB5PEPF00014B99:EE_|AS2PR08MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: fd41c7b0-92f5-4e8b-97e6-08dde14e7bb3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?R01vaFdTZG16RC9BMnVTS0tnakJ1Uk4zSzBOc0tOTnAzN2VGSGlmb1RBOUtR?=
 =?utf-8?B?SjR3Ukkvbk50d01PNFRPY0pkaWxoVVpoM1VpY1NhZ2wrNExpUjNTWWptQVho?=
 =?utf-8?B?TXdHMlZ3T2xtdjBTUkNQUUlvby8xK3VMZjYrcFlzU0drUGI0bUdTQktmeVlH?=
 =?utf-8?B?M1A0c3lpc1ZqNFdDd2JzZHBmekl1UFBQUFVnSFRVRWM4MS9vUWQzcDR1MlVk?=
 =?utf-8?B?aWd0dlk2eU9FNEVZNzFJMVc3RWtHWUR1KzMzeFVqU2ZLcXhqZDE2RzVsYXdt?=
 =?utf-8?B?ZlF1STROc0h0UExOS1pEMGw1RjFoVDJyYVoxdGI2OEFoRzdNTFFDMG90UTZq?=
 =?utf-8?B?OHovSng1UFNRTUdVUlRvS010K3VJNU81aFpoclEwK09vSUhxVGFSRVVWU2NF?=
 =?utf-8?B?aXN1Uk00cmJ4SjB3Rm80V0lXd3hGMTN4OVdFMW8xMk1BaFpxR3hmN3V4TnNY?=
 =?utf-8?B?MlBxL3pOY1JRR3lRd0srdEJSbXNFOG1oQmx6eHV5V2hBWEtzV2lEaUl0dmU2?=
 =?utf-8?B?dVJ3SEwxTTByY1FDUys2Mk5JMllzWkc4algwWklUODZyM25ibGRUMnZCVnRp?=
 =?utf-8?B?WVRsK0M2dVRJcFJTV1lTcG1YWU52dTI4TU83RWRyWEVlczFpTmhjUGxneGd0?=
 =?utf-8?B?WU9WV3RMTmlUQ1cvaU5TU3FmeUhmZDNTU2Fvd2VNanp4Yk1wM2xDdUMyVzBX?=
 =?utf-8?B?UlZwSlJqU3hLM0Iyd1dSdlA3Q2E3TGQrTldDYThYbm9sRkRRbFhlQ1NkcEZz?=
 =?utf-8?B?UUZXeGJ0cU4rREs0WmIrRjhpdTNscTNaS0hHWnZaWWI4QmF0ekxsd09hTDBF?=
 =?utf-8?B?Z0VLRjVqNC9Bc05aMFZ1YzBhTFA2Q2VFRVZsMkdYVzJNdnRkdjY0YWZ5bHBt?=
 =?utf-8?B?cnRIRkswc1VMS3RMbWlqTUVxMUtrR1VVaVQ4b2hmZVVrZTA0Nk8rd3NiY2tW?=
 =?utf-8?B?SHloRmhrc1B5QUk0YldvTEZLdzFkM29mVDU5RXV4ZW5VcTUwZVJPTXZvOGt5?=
 =?utf-8?B?NnpKZUN3RFBHL0d1Z09RdkdoS3FYc1Rjakk3SFJ4VUFmYm5oTW8zZGxxMldM?=
 =?utf-8?B?WEJ0b2ZjVWlFR2ZPeTc3U1VYNUwvOVYwRWV5aEhXNFVLMUhoREZQUzdEVktT?=
 =?utf-8?B?N3NZT0s3dERNMG1NNnROdjFXc0FPUC80cUhOSmdpTWR4SXp5V2tMTWdXcW4y?=
 =?utf-8?B?VDlpeUhEb05lRFZza09hc2xEdldBRjA1TkFIcUlaQU1WV2JkVGFsNlJLT1px?=
 =?utf-8?B?RWlDMFIvaHRUa29Qc0lLVWJhRi9OVjdnV0R4L3UvcmRoK0hsSVhMNnBha1hG?=
 =?utf-8?B?WXIrZUdWSHdsL05NcVNSZi9YQzE4dnR3MXg1R3RoY1BRR0g5dXBhVGRhN1JG?=
 =?utf-8?B?QWxaVjhpTkU5eGd1MXFJR0k4NDR5KzQ4R0ZrZDVtcEJEak1PYlg1eFFOTTNN?=
 =?utf-8?B?Vkw0aUYwZ2lzSnc3eHlxSUdJbTVlZUhZSVc0YXVLU0V1aDQwTng3Z0tSRHZR?=
 =?utf-8?B?YStuMktqMlBTVS9NZ0RMdk5pM0huaVpxUmxYcjRGcVR0QTNRV3RYK0ZXeWRr?=
 =?utf-8?B?SVJIdXdVYy9hbUhNcVBNZkkrd2tDb0l5SWNXQk1VMTBMMG1iNS9LQkFDZ1Iz?=
 =?utf-8?B?dWlYRUlyT1UrdlhCTXkzbkoxbmNENmxzYnNTOWhwMDM2N2Z4bmwvYThkak1q?=
 =?utf-8?B?b1Ntblo1WjNrTHBCeCtyTC95R21HRjNTUHMzWUhVMmxmckhFQVZiTTZsVDl6?=
 =?utf-8?B?NmtabnFybUVFQWw4ZjZDdlYvNU1QU2MzMlpNdFdudmQwem5WdVg5QnF1OHJ0?=
 =?utf-8?B?QmJBSVBycEZERnByOGM3MW5abmdwZWlzeURXeHBCZmxxeU5ZOVJrOG5vWHNv?=
 =?utf-8?B?eWo5RHF4T3YrRHpYZnNURUlmK21RTmVwTklaeHlEWE8wb3c9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6660
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e45ce1c6-03cb-4b0d-d9b7-08dde14e6667
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|35042699022|1800799024|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2h3eFZaRWF2VWdGblZPWWpXMzZxbS9LaFd1bnlOMHordE53ZTJaQ3dPaUkw?=
 =?utf-8?B?b3ExekwyQkxCRjlSRGlCMFg0YXV3TUM4RmtGanBFRkdrYUdIaFllVkVJTlJx?=
 =?utf-8?B?dHg5ZDB2YnRqMU9ZT2djVkk4VEtoMktOV01ySHdoQWdFc0NNZFpDWUo5MkNW?=
 =?utf-8?B?SGREd1ZISTFUSm82b1dhalRaNTl2K2ZCbkVPWmdvWDg0TWpXR2F6S2xDVG0z?=
 =?utf-8?B?UXFEeEh6eGpqbkJSTHAzMTBDTjY4U0ZVNDBSbGFMTzk3dzJnUXhkMUlCdW9D?=
 =?utf-8?B?bWJCcHVpSjNCeHMvSTI4aWcwWmdOR0IzNlhiMVpiQjBhRC9mNHBRZVY4QzIw?=
 =?utf-8?B?YzRFakplblgxYWIvRW5LNHBwRHh1ZXhFLyt2NFNENU4zc0lHSjNPN3poWGYw?=
 =?utf-8?B?UTNkTmRWVmZWUTFXeVJ3NFhGZ2ozbG81a0JyUzFyVE9MY1BhN1VvN21RWFlW?=
 =?utf-8?B?R29YQzA1c3U1bWxWak9SRG9odllDMFplaWc5SnpiR3I0enhzQ0lFRytFODJt?=
 =?utf-8?B?NHp1cThNL2szS1kvTnNwMEdrcnZYQnFCNkM4cWpLV0NuT0QzZnhUdXFOL0pj?=
 =?utf-8?B?YXZZVDlycEduSlRaR01ISzJJTC9hVkl5S3Fnb0dZY1RCZTRGQmtlRG93dDda?=
 =?utf-8?B?M3BFK3lMQmYxRGpmaU02RkhQaXZ3TmdNWTBSMk9LKzh5UGpTTEhXTkcyTHVY?=
 =?utf-8?B?blJkWGFjQkRqWndOd0crRFkzMVFGWFpialhZZ2MvZXJmMnY2cGdCcUgyVFI5?=
 =?utf-8?B?ZHNuSVpHajg1RkZsL2tIelpqQWRtU2RwVFc1aFIvWUpBczFvK1EvUFlleWsz?=
 =?utf-8?B?OEtZbEZjcjl0RTl1UW5vL0ZhUkpoS2Y3NUF2c2VQZDNzM2VSU003MFBjWFBj?=
 =?utf-8?B?MDNmQi9wZUFtSERjei9nVnJ1MGxqS1VxTGQyQ1BhRTIwVllpUXdoVm01ZVQ0?=
 =?utf-8?B?ZDNDNmV1cmtDMW9kRDlFV2pMcGlZdDRRM1d3TFJpV2NibHZJQ2pKMEs3MkNF?=
 =?utf-8?B?UjdWUlpnbnhxUTNmNHVYeDQzN0d4bWY2M0xIM1N3U0MzdS81RzhFTC9NZGJ6?=
 =?utf-8?B?c1M5Rmd2endnSkNGU1ZRT200cTZRcEVJYW4vT3RUWU03c2dWSWJkVUhDSTJT?=
 =?utf-8?B?algrdGg3bzhuaHRGSmRlQU41WXh4cHN1ZmdTZTczb2ozOTdOcXk3TjUxUDVo?=
 =?utf-8?B?T2RQc2E2U2VybjkyZXV5Q1F1bWtjOTNxdmJqV29XK1p1cW9YMU0xaHZFeGZx?=
 =?utf-8?B?K1kwMFkxNmh1NW1wQjJWVDNRbFhXeUdpTCtZNnlzd3hvTUljSFdteUlTVlRy?=
 =?utf-8?B?VHM5bit5NFQvMVBRT0lvK2FCczlMaDNTMHpaQkRtWi91c0xrZCs5eG4zTGpT?=
 =?utf-8?B?YWxGZUYwWWJUTnF1MXRDSGxEbXF4czdBUklwTjBTbmlBdzBPeDZiT0ovY0R6?=
 =?utf-8?B?N1I2WVM1NncwMy9zR3lOd1k4VHAvVExLMnQ4R1kzUnF3MHl1emNIRk1OaGto?=
 =?utf-8?B?WmkwdmZJbDA2WHpIMVhhNnFHM2MyYU1jWkIxalJwY1ZiSERleHJpb0sxYVZ4?=
 =?utf-8?B?ZjhLeXdUN2FWbkw4S0ZDTmZqOUV3cWtsVUYrR2FUZ1E4TjRXYWl3eXkzSjU3?=
 =?utf-8?B?b29wcHJlMG0vd0xscVBUUHFsSzNmUmYyV1YwSzRnQ0Y3OXZBU0pRWVV4Z0ZF?=
 =?utf-8?B?T2NYK2FkUFUxZkNXdEtyUzdDOHJKam1KZlkzWExpbUVhc2ZIcTg4MktaMzZF?=
 =?utf-8?B?YUh5VHE5R2JsNXZKdzNhY0V3YXBlY1ZFbzNBSFFwRGhOU1JOUWttYjgzd1hJ?=
 =?utf-8?B?bnFoRlprUjhyL3ZvbzZnOVU4UzdvSlpsL0NXZi9LY3NYa0pLc2plTi9jNXVP?=
 =?utf-8?B?bTU1ZGRpU2pnakRWN2hBbDdYMmhua1d2VUxNamkyay8xQk8yUUNsdUtoenZH?=
 =?utf-8?B?OVdKS2FoOW9nN01kR1VSRmxYdVN4c2xSQVFoSy9jTGtuWS9sMHowWkFDU3VE?=
 =?utf-8?B?SkhQM0hUMUljSzJ6OHFkeDJHQ2liMXAvQml5S1dVeWhFZjU2MlZtWUcvVTZD?=
 =?utf-8?Q?ZDGS+L?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(35042699022)(1800799024)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:35:35.4002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd41c7b0-92f5-4e8b-97e6-08dde14e7bb3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8926


On 22/08/25 12:03 pm, Wei Yang wrote:
> Commit 8ee53820edfd ("thp: mmu_notifier_test_young") introduced
> mmu_notifier_test_young(), but we should pass the address need to test.
> In xxx_scan_pmd(), the actual iteration address is "_address" not
> "address". We seem to misuse the variable on the very beginning.
>
> Change it to the right one.
>
> Fixes: 8ee53820edfd ("thp: mmu_notifier_test_young")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> CC: <stable@vger.kernel.org>
>
> ---
> The original commit 8ee53820edfd is at 2011.
> Then the code is moved to khugepaged.c in commit b46e756f5e470 ("thp:
> extract khugepaged from mm/huge_memory.c") in 2022.
> ---
>   mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 24e18a7f8a93..b000942250d1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1418,7 +1418,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>               if (cc->is_khugepaged &&
>                   (pte_young(pteval) || folio_test_young(folio) ||
>                    folio_test_referenced(folio) || mmu_notifier_test_youn=
g(vma->vm_mm,
> -                                                                  addres=
s)))
> +                                                                  _addre=
ss)))
>                       referenced++;
>       }
>       if (!writable) {

Wow, I have gone through this code so many times and never noticed this.

Reviewed-by: Dev Jain <dev.jain@arm.com>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

