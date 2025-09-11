Return-Path: <stable+bounces-179304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1FB53B62
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C905A5D18
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A736998E;
	Thu, 11 Sep 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="B+DzG7jl";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="B+DzG7jl"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020141.outbound.protection.outlook.com [52.101.69.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5636933E;
	Thu, 11 Sep 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.141
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615327; cv=fail; b=QZX1XY5CbLzN3bzjqy4rNN7YWhtRThG2hiC9VwiftGp5xVRpfAf9l1iOFonIhq6+ToUQMdM1CoOmfy+mjflp2e/xfwVHIts4cDoo80PV2n0HeT3XU8+KzWAUDfgxneC9sosI3unw6vh2HwM3Oc3KWXnL1yzWPMyELh/gv9Cdf30=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615327; c=relaxed/simple;
	bh=G35NUprFqeDXYWgNAW7DPuJkiyeG9ljwnXlSXIipz7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hgqgpSSB3OSoYbU2gWjVlpZEtI3QB/wZXajO/lPQQdoUPE++KYYmoBbO9H9T7iFUZ7le/Q1h9utTliYuomKzyTeHulIs4bKhcHvZDLwzHxRjhw81d4E32M53vK5Kz21z8Dg95sX87iTaOuDwfRUpQFdnashIJtqFVV9AI0sfcXA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=B+DzG7jl; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=B+DzG7jl; arc=fail smtp.client-ip=52.101.69.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=plliCel5bih/Lp2pZC9IvJNVFAf/R2IjJjZP6yc22iU7B/EJJuLZpu20CwM7XeZyKtJ0NAXMJgFGMjj+3wNhkJSfM9dMCdjzFI0QPlVs1i4PabfZO4SQseGTTv1wjTz5lMdaugo5HKC3ADK8DNciIwQZSS7qxPrZE2to4kNyraLOjOuDv7UzM7yWIBxdSnHp5/JnbasF9/O2YuFadK4BJ5hxjcSOl1lYDI8fiaLejXRX43Bg0WuUZVJl9YN9xjvdexag9Ok0Wy/N3o0aHy6Evz0SQ/KAnxIhMtXdxo7x8LW4cDaN6jH0PWP+Osh7mWUdr92gTm+Cf/tQvAPqPVgUyQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Ny5W1yK4qEYJiMXX/H3rCEEOJW5tAiQG4f/O6uuR4=;
 b=bl4slTQ0yhveclcJoU6u4yXLydW6UVznO5n6JFYWQ4onoKjk1OaRLkINEiq+c2nCUluwLv8YeiY7vR5MZKLXBIw9i0cUgnrOitxf6PdPqRxBFMW5ZSouURX+rDxr2QNPQuQDa7QNL78SQn5+nUNiq2Mshx2VlHQhd6brpCNFCOpxdn5XpTUbPvsV+F4tTqZVFKVJQIOm3rB+SlllfH17tbMsDn6/d2tXc4YMj6O1kgZZtFp/VgxMceS150MRmxRFXif6CbFCnfNPrVUT8MXrXR/sIPTEpCN+FdrI9AtTz70GQeqjfHclY8L3XZMKLwGCStHWFl4RnF4pEV0hqDV8Wg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Ny5W1yK4qEYJiMXX/H3rCEEOJW5tAiQG4f/O6uuR4=;
 b=B+DzG7jlsGh5TLaIYF7dxqtOiKlu7LqWExMtxPI7diQRETiHYM1JxMVuzObyNfOUz5hEkwhREvOrzytXlJ06oiq9tTeRT1mptfsmKZcxfQzTYd2b+Pl5HySxKZDC6nXvdv5XD8wK5xkT4JbxgEPin0U9AWBv9z8frmD0IMXpl7k=
Received: from AS8P189CA0039.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:458::11)
 by VI1PR04MB6798.eurprd04.prod.outlook.com (2603:10a6:803:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 18:28:39 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:20b:458:cafe::7a) by AS8P189CA0039.outlook.office365.com
 (2603:10a6:20b:458::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 18:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 18:28:39 +0000
Received: from emails-1836632-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 0635980018;
	Thu, 11 Sep 2025 18:28:39 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757615318; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=59Ny5W1yK4qEYJiMXX/H3rCEEOJW5tAiQG4f/O6uuR4=;
 b=QnPYqkzdhkcO+LeCUdmrlSEeO1LtMlVOv3iAq2e+b4CrWdvZ8HBZPlsS5x2JoBIYqZmjt
 QloSaUO3NfD/bBZ4+azdULFqXcT/1lxlaud5lHXTM2zj85wyPTynCt039sRKTlVOX0hLL2c
 RRSzlQ1Nq+HwWvlOKJjmf8saOt+n050=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757615318;
 b=YCFpDDsoC4tRmaHjQjiv44npV9773h3DwbtnhImalZ7DuRailqDkcrGInthCOAfWaTZ8I
 hide9b4GXfldjuk7HzgGDR/7zoGxkvuBUjUqycLOnCiV+Qu+yT/kCzHa1DKS7dO3+bC78hM
 MCwA4grQTrKBbZZD5+DSK1vBLuyzfgU=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0i8e1Mrcbsqn1e9kj9TChZ9k+AFfibhGAjaB63QF6le0hKlR0WoQHr27+Ruc/Cqp8DPii+fOPG+Izhw8uqbqaXPJroOyEZa3OCciQOmLqpDEKvz1Io/y7ki/qGoS9Zy/HRXGQdKBDLY7bwqHGxmA/nGAOu3SdMiciGaVepQCmRW83zHlLKM3glnt61G2jC8/uYf/T9uzg4Sd/m2F0QmERpfLmG/OQBUMVMWYOoDvIXvoXZcs3ZDhVpGuoIMrF1hKfBc1OyDmaBVjh0Vyk7geQQNjoredh4bwrABwWSmP6y4KDJDytGnHYKlONsHk7oaxYJeVUjHeOWeFzFWwUQVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Ny5W1yK4qEYJiMXX/H3rCEEOJW5tAiQG4f/O6uuR4=;
 b=O3D+eP0E3tuTqfLGHSOgMsInp8Q1Ibk6D5ceIVj9bs4oazYSYQ4GEV4EVi24U5kdaDwvVJhDOYUHmTEceDhOdnYIrySYnEHgOdxJ/KtXY9WZT62LkwIN8rpBrQli4wyyJWMUdiEwxCKOqajFnB4fwwZ5RlkgE/oHzvU3Npk+HjA1pVj4gI9I1BWNWWPhQ+NkXlov92KKzUcpJM8zzAAe3XOrpFuHKtlhPveNZxmPauq/m9hKK4RxBLVzjPCaZ8ByN7mf6vJDgfKuGpttXwmO5uHsD+vn/qGwdD+EtYumfUX2BSs2Rsl5FgSKNigS30TZoEX5Jooycw3iFz2Xn8Ol4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Ny5W1yK4qEYJiMXX/H3rCEEOJW5tAiQG4f/O6uuR4=;
 b=B+DzG7jlsGh5TLaIYF7dxqtOiKlu7LqWExMtxPI7diQRETiHYM1JxMVuzObyNfOUz5hEkwhREvOrzytXlJ06oiq9tTeRT1mptfsmKZcxfQzTYd2b+Pl5HySxKZDC6nXvdv5XD8wK5xkT4JbxgEPin0U9AWBv9z8frmD0IMXpl7k=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB11488.eurprd04.prod.outlook.com (2603:10a6:150:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:28:31 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 18:28:31 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 20:28:06 +0200
Subject: [PATCH v2 3/4] arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
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
	PAXPR04MB8749:EE_|GV1PR04MB11488:EE_|AM3PEPF0000A79B:EE_|VI1PR04MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 145e5774-fd64-46d4-276f-08ddf1610749
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RDQ4dmZmYUc1eE96MGNXblB5djhQZ0U0SllzNnJiSEwzZGhCWDIxWnlvcERU?=
 =?utf-8?B?ZVlLdXVDQmI3SThRYlZ0S1Bla1EwUnRYOG0zeGFKRzdLTUsyektISFhBVysz?=
 =?utf-8?B?dUo1RnEvQjBVWk52UVR6RWdNWHlWTkQzbXFCeG15ekVTZVU0elFRVW5va3NB?=
 =?utf-8?B?VWMvSmZBWmFEUGlad0RTN0wvWFhJclc0WG8xQVhXOVhsa1p3clM4L09RdlAv?=
 =?utf-8?B?dUVJaWJLNkxnVk52NmJobTluQVVjaUEwczVSVXJlRkx6dEI4cUtPMk5ROHc4?=
 =?utf-8?B?bHhPRURtUnhJNHRpTmRTdkxTM2NUNTJzL2Vxd0JJVU51RHNjRFlZNlA0Wkdl?=
 =?utf-8?B?bDJKTkUzemU4YUZmY2R0ei9kaVREZUIyaDdXdUpyVEI0WWtwNmZLODVPRVlL?=
 =?utf-8?B?dXVLa2pGTTI4MldmUUJWVXBZZVRkRWJ1WHNsd041dkxoUmx3UWhRYzZENnM2?=
 =?utf-8?B?ell2K21FWHJJL3dVelIvQkFsdllqZ1JEV09aSnFySlNtOGdyZnA2M3JVVjVw?=
 =?utf-8?B?VDBMemZaQUE5OWlaRThDTXlCa2V3UFIzUXhLWnpobGNsYU1lMzdSNEEwVGZ5?=
 =?utf-8?B?WHdOVlZLQ0VSb09aVFdCakJBTC8vN1NNQlNaVmk3bUpzdVlQdllaeHNzYkI4?=
 =?utf-8?B?a0ZZL1V0dUt2aW1WRzFwVng4L25ORHBlZmJaVnhWZWd6eXR4VlcwODArT1BL?=
 =?utf-8?B?SnBTSVhTZ3lodTNoUTB0ZWRpbGdHWm8zb016TFRicEZsTElWS3B0WWI3QXZp?=
 =?utf-8?B?cDJkc0puelRpRDJIWUs1cS85UExaMVBvWUVuaFBpa1Jsd2hNSXRzb1Q3RVEz?=
 =?utf-8?B?enNsVzdZU2lEUzhPdjRWYlNCWVRMeHZwUUlUNjArc2FqNHRQSHhjZjE2a3RG?=
 =?utf-8?B?M0NKUlFtVWlQOE9IUDA3YVR1VGFWK3JLdVhGSk1oNzJIVElwSUlYdU5icDg4?=
 =?utf-8?B?b1JlQytUYk5ITVFDVmtDbUxpdmxZUHdtL2xNTkhVREFUZG1ZMm40SzVQYXAv?=
 =?utf-8?B?M2I3aU5nQXNLSWpwRjdUYzFBL2tlUExTdy9yYzIrdEdlbkFBWU9UT05sQmNL?=
 =?utf-8?B?cXVHL0FmNTRWbUhSVHpJcVlZd2libUh4K212eVhHcG4rdHNsS3dCRG12K1JC?=
 =?utf-8?B?blV1OUVSQ09CQmRhOVVvajMrME1nNlBQNEo2WDlORFFHOTcwZHRER2tURFpz?=
 =?utf-8?B?WFUxcW1HdXlLemtjNlBvb0pTUHN5RHRDclEybFRBWURIeXd2MjZOZWMzL3Rz?=
 =?utf-8?B?a3lvODFIYVF5bkNIRUFWZjRuZDNzL0dCT1EvTjdUUDdubGFSNUxpaW1HVk1D?=
 =?utf-8?B?V1VBOXRpVlFRZ0tLQU5wUVBjMkVIeDVVS1d4N3kyN2pRYm9WUm1ma0daYmRw?=
 =?utf-8?B?bkxxR0dwQVlYTVRaVnpuek9zMlpEWFdmQVhnblJWWWpxSXFlcmlmMitDOC9Y?=
 =?utf-8?B?M3Z5aEN1SDliM0pVby9nV0NiMWJzUCs3VVhwc2tCUFdXajNaV2xTc3dvQ3Qr?=
 =?utf-8?B?NTFra1BYNFpyTXp6S1dRcGg2djg1N25nTXovb20zajJSNUx3dUVJRCtRQ0h1?=
 =?utf-8?B?N09IcW13a29CSDRqYXJ6UW53VDVUc2lrTlpZSWtHRmJ5ZS9BbEFMcWVBQ2RN?=
 =?utf-8?B?dEdhNUlPbW1HOEZ0UFM2RWhXY3dTblo3S25jNDRTeDdPSm9HVmpvaTByNUVk?=
 =?utf-8?B?WHA2QWV1eXYrQUZrZHcrU091WUhKV0hOWkVRQmdhYWxZQU53OFVHeUlCSlhG?=
 =?utf-8?B?d0lhaUZJNU11a3NBeUM1eGpVajQ5d2xMWXpjNHhTakxrTzdmdzUvbHVHY08r?=
 =?utf-8?B?RzZtRFVTRkNyYXN5RU5saTQyNU5zQTFpM1ZBUmx6cmI1R2NmV1BhaXg3c1Jt?=
 =?utf-8?B?MkZVWnNheENuTFp4ckxrQkpoRUdTZ2lteVoxMEN5LzZyVjB3QmNuMHoxTWNQ?=
 =?utf-8?Q?bE/Ay+OmvRw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11488
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 94aedf25c89445d8897370df6b5a95cd:solidrun,office365_emails,sent,inline:747356389351dbbf289619dd077559e8
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d554aa6e-6870-466a-db0f-08ddf16102a7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|7416014|14060799003|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUxVckN6NDhSM1BobXVvcDBRQ3NHa2hOTjlUaHlUWm8zeC9jbVpNVVU2Z1Ri?=
 =?utf-8?B?WHIvWjVtWEs2VU1SeXZtb3pqMzdaU3prK0d3TUdDQzR3azZUSGtPOVF3QlJK?=
 =?utf-8?B?bVdqQmp3a0lvNjQ4TVl5WDNkV2ZidTJPL3F1L3RYTTNsN0VlNFVBeXNMamJL?=
 =?utf-8?B?TWFYVWJXSE1EOVowYUJZRjlVTWJtMThaR1J4b0lqNDE2ZmhMMmUvcXFRN0RT?=
 =?utf-8?B?cTI3MjBTWWdWUXZwT09vLy85OTNiWThZb0hsQUZJTEVLOEIrbWhLQjcrbnQx?=
 =?utf-8?B?eXppaHBiSjY3NjB2Zm5SNmFkRzZTc3pHazYwdGczTGpML3ZLSlhxWjZaZmVP?=
 =?utf-8?B?WG4wdEJFdk9FQnkxVElrcllrMERtT3pzU0tkY1pRd2Q0Zmh2Zkt6RXV4TzV3?=
 =?utf-8?B?OFJrQVVrczUzMjJGQWhKU2kzUnlrdG1tSklNV3JYNjRLMkxkRGZPRWtMUXBr?=
 =?utf-8?B?VzJQa0h1U3FiUjJydDZCcVU0bStBNDZ5NVBhNTYzanRLZXNXWFpZaWU5dGlv?=
 =?utf-8?B?VzV3eUplb29ENFpVWFI5K0orNkhpUlhYcG1EWENWejROT0crdlAwNC8zQTlu?=
 =?utf-8?B?NnhVNjYyanNuYmQzMGhuTXJ6MUc5VHF2SHFPZ3BmTUhmZTNBMTF5ZDRsOTlO?=
 =?utf-8?B?V09LcXFIZUF0Vmk0NlhNSnl1a1VzM1lIMU80TmZrdlFVY0c2V0VkWU4wKzVY?=
 =?utf-8?B?ck1pMTdLaU9DaXIwcFN3V3hXYzU5eE0zTUxuVXJka3FKN1duK2l6NE5yTGNa?=
 =?utf-8?B?TFFkYXQwYVIyV1VWbXIxaGlPZkp6NENVT2RWWm5QNkJmNnVucDYwNUdKTjBu?=
 =?utf-8?B?Mk9wOGxlc3hYdWdCdFFWbmliRkxqdVE4ZWhyeVBLQUx0clEwMnZCVDBTT2hL?=
 =?utf-8?B?OFBzT3QvRjJkWnNIYVo2RFhDVjJicHdpc25qOVRwMDhrM2VIakJ2dFh5NlNX?=
 =?utf-8?B?SjFBa3UwWDF4dXdwMWJpZmZCSlpsRUxHY0ZxbU5KSGY5bEUxWXRIQllNOWtz?=
 =?utf-8?B?SG1raUFhSXZ6U0l1Y3gzS3hmSzVnY2hCRXVOalh3NjUvczZzczg5VDJzQW5R?=
 =?utf-8?B?MDdFMlpRRkZzWVN5OGo4cUtjNmlhL2ZVYmZPV1dGdjIrVGxmektEb20xSzJB?=
 =?utf-8?B?VTVacys0SjV6WldpRGN1WlNwYnFLSkRuNVpUWStDY1JuT0tqOTg4OUxheXIy?=
 =?utf-8?B?RnZzSVBqWktKSFVYQjNwdlBlK2ZVZDBMUHFxbm1jTTQrcGZqZlJqZ0VRQXkz?=
 =?utf-8?B?dmxqSXpHckF3S3ZBTTJyQ3ZpcFIzczhjZ2ZCWVhmRnVVU1RVMlFLUHJScWJx?=
 =?utf-8?B?RW1MYzZwWUdvZVovZFFSMS9HVXBkQkZGYnpsWjNBOFhBQ1ZKRHVYNHUycFNC?=
 =?utf-8?B?RnNzclNFeEUzZGUrb3lpUWdBYmpBWjlRMmJUektMK29jM01VZ0hVdGtlSTVG?=
 =?utf-8?B?bkFRRUlGZCtaaVpMbDA3VFhpZVplZXBTek5Ib0c3U3A3UTZ4MHlSUWNKQkRy?=
 =?utf-8?B?MkZ3L1hUZ0xsZXhuOTZMNU1GRThPOUtCYmxDMVl1Vm8vUUpJVVFPSHpSWmJR?=
 =?utf-8?B?K3dFcDgzKzZKL2xOUHkrQXFJT2FTZVFRNGRnemZyRjBtaXo5ZkFPT0RzeHlK?=
 =?utf-8?B?aHpmck15NmJJeDlmS2ZPQVMvSDdsNVMwczlZL01MYWFtUG1XK0lmV0ptdzVa?=
 =?utf-8?B?YmhCNmRiZmlGL2RTc3JVdk9nTS9pVEhOOTJWQzVrSnFzdGVjVVhxY1NtMGtY?=
 =?utf-8?B?YUd1U0RJU0ZYNXEvODUvcUtHeDlNd3RRZkxnRGhLQS92R3V1VmFrbkZuS3lK?=
 =?utf-8?B?NFdoeU5tRnJJRXpWYmtManVYZmxCQ2JtbFIyNVJ5K3NzbHJCMmpSOTBnZHRH?=
 =?utf-8?B?Tzlld1AzMXQrNmhieDBlcDg3Q3dsNCtZUTRWNC9CUk1FNHBCdGd1Q2ZrUVo4?=
 =?utf-8?B?SVlKS1lxL2pHVmJDZnk5VjF0bEJ3YnJEZXlyMUZRZjMyVkVZUG9lUG1XTEQ5?=
 =?utf-8?B?TXhaUlkvc0JsR1pLWjZVNy9BZkVtYlJNTU9tVjN1dTVYaWxHRWhSUURiYnc2?=
 =?utf-8?Q?uK/BmR?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(376014)(7416014)(14060799003)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:28:39.1924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145e5774-fd64-46d4-276f-08ddf1610749
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6798

The mvebu-comphy driver does not currently know how to pass correct
lane-count to ATF while configuring the serdes lanes.

This causes the system to hard reset during reconfiguration, if a pci
card is present and has established a link during bootloader.

Remove the comphy handles from the respective pci nodes to avoid runtime
reconfiguration, relying solely on bootloader configuration - while
avoiding the hard reset.

When bootloader has configured the lanes correctly, the pci ports are
functional under Linux.

This issue may be addressed in the comphy driver at a future point.

Fixes: e9ff907f4076 ("arm64: dts: add description for solidrun cn9132 cex7 module and clearfog board")
Cc: <stable@vger.kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 115c55d73786e2b9265e1caa4c62ee26f498fb41..6f237d3542b9102695f8a48457f43340da994a2c 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -413,7 +413,13 @@ fixed-link {
 /* SRDS #0,#1,#2,#3 - PCIe */
 &cp0_pcie0 {
 	num-lanes = <4>;
-	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	/*
+	 * The mvebu-comphy driver does not currently know how to pass correct
+	 * lane-count to ATF while configuring the serdes lanes.
+	 * Rely on bootloader configuration only.
+	 *
+	 * phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	 */
 	status = "okay";
 };
 
@@ -475,7 +481,13 @@ &cp1_eth0 {
 /* SRDS #0,#1 - PCIe */
 &cp1_pcie0 {
 	num-lanes = <2>;
-	phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	/*
+	 * The mvebu-comphy driver does not currently know how to pass correct
+	 * lane-count to ATF while configuring the serdes lanes.
+	 * Rely on bootloader configuration only.
+	 *
+	 * phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	 */
 	status = "okay";
 };
 

-- 
2.51.0



