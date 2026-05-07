Return-Path: <stable+bounces-244571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB8OJy+U/Gn3RQAAu9opvQ
	(envelope-from <stable+bounces-244571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:31:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AB4E948F
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F313044F3D
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2683F0779;
	Thu,  7 May 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YOxMpHcB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YOxMpHcB"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB213F7871;
	Thu,  7 May 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160410; cv=fail; b=UZrLw8bJTuQOHlQkCfghmYHOENTZCigCQd1iRgL5ggtOvbequcSEqH9UUS47hVjnWbf14H7v/WHcHj/bmy9zIDAPViiSS1Rk4uiM+PLPb5zGZretamdvQP50YiXh3bzX/bXebO4VjI/2DCFe+NatsCf1vDU+29Tl4ZD++TEvQp8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160410; c=relaxed/simple;
	bh=AmiUK3EuE5YD9UUfVcewlJalZnUwK6v0qdk105bEWgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLGq1AOaFZnlOCfnAOFK8xFzjd470BnXHzSUf4MNEtGV2G0VX0j+81PXxCzBWFHdLp2gsEZTrEom1mzkMMBS+75CoH0feIdd8FrcyVlR3awBBsNx0SR/FnMLayavZ9tdAjjgi+heQfvUhv3vgukj/rMSFYjjMya+eClqJayCG2o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YOxMpHcB; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YOxMpHcB; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NIEyuUWlAzJAeAZlXB3YK76lqXrU5Mm8q1oYZEBQJICNgRXvU+5G1sr7+Ngt2HRqgLmlCO9Ar2Qs9NVZkZpA0p3GRVvB137E3V3XOn1B79KXVtnCfTYEwpzPZgJGaeGCoyqssZEuaOfMS6triXOqYEFUOV4QQWGS2jjWN10sLgRmSzEWUjWckS5BpumQspTJwzPeuPAJr/c9hscNYBL6XGr1lrDk25zMdgOpmfBxiyXHTKZaTSuH4ioqLgnkOcNudzBfn7xjoI1pzM09Ym9O/8zXBzxRI2SzAHnjA8QCfYXGwM9y92+WqUU7PIHi2I48CTiG6KRA/v/7Uoo71wYtYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t64Ct/v67j0YfcF3ZZKYA7JOJ18QnhX2mCxAWQIEk00=;
 b=aymd+oQDu461JaUIXlb2LXrVO88+pih2zUcJTSmr9e9wcjZaS0aRcgXoKt0r/TOrSSuWl7ApyFz975zCzntPY5OElIVQYUTAc4Irv8yCSHwTiVSRHVMZw5IAhhH1JyIznAWgjRnNCbYWfBC4gbHnQZfQyAvjPqtvLkHi+lqazvKzVwvSprqMi355iSa1aU/dUzRmj0JM7SGfcvbu0Q460qIGN4AntKwWxJe/XViRTvaClyj9f38smDkct0od0VXnoDz9h7tXk+RXni3LbOyHnUDdLzPzdNR1iRge8vnb7M1q8zXBppu1tYjJ90G5tcOQUk9FelNA9l18IdViUXYbLQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t64Ct/v67j0YfcF3ZZKYA7JOJ18QnhX2mCxAWQIEk00=;
 b=YOxMpHcBz9MgYouhnd+Tt4AxVe+nuCO2e0NtRJ2UhcJ/mzdTwD/fWZEVPgvIpjJuj8lQgg1bAu0F/uA19t7zHAx+BE72wf7wE4heotaYDMRYSTrslfi4dfy2DzcCBSZihpbw9oaBLRdoMxzqf2U4mgfCbz2bFBdjrlNaokI/F/M=
Received: from AM0P309CA0015.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::15)
 by AS4PR08MB7950.eurprd08.prod.outlook.com (2603:10a6:20b:576::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 13:26:36 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::62) by AM0P309CA0015.outlook.office365.com
 (2603:10a6:20b:28f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.12 via Frontend Transport; Thu,
 7 May 2026 13:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Thu, 7 May 2026 13:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiN7JYBWBAAFrGXXpZtwiC+NZUovHHSGOUWPCkKpdCFpQPRMZbsagyCs6WicO9IzONp0iKdPdQAofOv0rui3iFo6lZW62Z65ho27owZhCT8TDfJshKaFZVltkzZuCK5KPmB//sb0taGR4hm4NbHC/n66TuFC1z8GNNQboX/3fc2KsbSyvTLqTZtpox0eHChYslJe2DN/djDm1KT9eAYG3DysCobIzRl5M2ayb6uIz4328PUZG020YBYh+xAjE5lBXYN/ns/g3cOm3sFjnKgPiEkKZHx3Y5FLdqiOIvpId/lt/5HKT/9u/feP0KzLoleBK5WObnTYP27eEdl0fZndFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t64Ct/v67j0YfcF3ZZKYA7JOJ18QnhX2mCxAWQIEk00=;
 b=na9Xat9AA//pN5WQA1sjq7ZNuLxdjRFPtscyS2CnMPS+y9ZDRNzUj7MVnwdde7202X5+IiVWf/IuG01wqHBbXSeAN4Lca4f/G4bx9it9EQJ7cucgg3ywq+lTuLMBq9JKsk1PcuiJvMuxfEmaBfskvmdKy19Dz26BV30XhzLAEO5p2DzZQ75RODNfMMv479LwYMMDgoo2KBNRq0/AH/HM1VHtska3BqGDX2y1c3DN0W1OR+FBhBmH51AR492Gz9z2QvTGqAVYIU1Ztwz0SEebHVawMzM2WHn9X9r1pvNH4miP8t10o164TNFnLdXbIbzkIJ018RcUj4CvzQidJzNQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t64Ct/v67j0YfcF3ZZKYA7JOJ18QnhX2mCxAWQIEk00=;
 b=YOxMpHcBz9MgYouhnd+Tt4AxVe+nuCO2e0NtRJ2UhcJ/mzdTwD/fWZEVPgvIpjJuj8lQgg1bAu0F/uA19t7zHAx+BE72wf7wE4heotaYDMRYSTrslfi4dfy2DzcCBSZihpbw9oaBLRdoMxzqf2U4mgfCbz2bFBdjrlNaokI/F/M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11778.eurprd08.prod.outlook.com (2603:10a6:20b:747::5)
 by AS8PR08MB10223.eurprd08.prod.outlook.com (2603:10a6:20b:629::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:25:32 +0000
Received: from AM0PR08MB11778.eurprd08.prod.outlook.com
 ([fe80::a5dd:8b63:e253:18c]) by AM0PR08MB11778.eurprd08.prod.outlook.com
 ([fe80::a5dd:8b63:e253:18c%7]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 13:25:32 +0000
Date: Thu, 7 May 2026 14:25:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Joonwon Kang <joonwonkang@google.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, stable@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v4] mailbox: Make mbox_send_message() return error code
 when tx fails
Message-ID: <20260507-large-wren-of-protection-93bb75@sudeepholla>
References: <20260421104652.211276-1-joonwonkang@google.com>
 <20260421104652.211276-2-joonwonkang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421104652.211276-2-joonwonkang@google.com>
X-ClientProxiedBy: PR3P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::9) To AM0PR08MB11778.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB11778:EE_|AS8PR08MB10223:EE_|AM3PEPF00009BA1:EE_|AS4PR08MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: f0412134-d989-41e3-cc05-08deac3c43a5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 Sc9576FpLKXx2Os6TgEehlP5XR5mQTbZtelNQ899hCp7qAAFdooImrlRu7Ve6QpymtRzDVY4E+BiGaetLsioPnfWCER9SHALCJNst37cFIWZ8Rk06CfdupomLUj0B9W4Kc08OEOnLG6WX1ksODZnLW9gBnLjyhw5ZWeLdvVicevqkccRHlk65PZf3CallICeWoOcCn2+TooeO4bKHFDH4WqanFakZ2SnnaONp8QtR9r/99ElmrdA0lIK+roU9NJU10nkzXEfzbrSwdEcFb86dwetd++p8Ok0f4aDDLkpyIwH/ijMJRnppnfNNzMq8dqirxNXQ7ArEvb0+AN6zK4d0HXuAwNgXHnRZDlKkEwAtF8uQP+2B4oDdtkvHJPmPPyLP6juzcvkS/F1W0Kda728vNij9v+yfWsO4aQdAZcjjgE3iqjMmfpm6abY1eWaiRmrN0JotplFyeUeeIks/AxVofqD9yIOS/Q/jxHEAnKUe25IM4490gPb2/GQtCcyYFmxmtUr5mbeebnEFB95m7TN6KrF6br5csKpOgL8xaaUwgaf24c6rOg2Y1Z7xEy3SuHD1G7n7MelKpppz/eCCnOE61Qf3m7X3x1HPKYd8XEDSFutGJPAhxIqitv1IMWA1eZc//XohEukXxqlzjM+LxjkRBTxTOJ+tTQH/9afotn+q8Zg3junAMNu3vhXpOr2GKcO
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11778.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 uv+jHeQTL6WEG0Y4t4wzoiau4BOzq5D3aK9nAFowcQ0L1+fm8xnEjR+W7rJCXzyyYj3XwzS1yq4ss08g8/vp2znOJl2JFLQghdT/7rOQr8fNVSu8U+0iBU9JuTzSgjNY5aP5XrbKg4XHeZj3+/yVr4hKguYuMyEqSWq93ZIpuGsazt6/gncJjP9nZ4AiE7zopE2As6VldXakNaLmmYmJjiyhchzxoazeP2IduzvGWsu4NPw6uwK9t8RIUw5csijMAd25xJwxyL7toStcnG+XBjiERKSnL+RANm784V/4RnnPExDV+6TqJEvSeQZXsVLpKAaiUFbT5nbO/0VAMhQ/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10223
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb9302c8-31c8-4a44-35d0-08deac3c1d72
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6cArJhSNoTBV1/WUDgkjDcIBJN1seXILVJUlOFK6qNz9E7KMQ7JRyOzHAvmfRepGLOF6QVYTUGXLDFHXi1VenTD/OWD7OaAk/arycFRgE/s0d9CO+FzNszLVtkYDRRZyPvTceNhhK+Gzs2ECz9cqLK1zg9W61PaD+pP8jj4LDiIGms/zUyDjZiV8XMOuj4I+PUy5aYWKJufl6SuyFcKGvnVW/ah3s9mYW4uP4tr8bfhYmTIkPq01h/i4fJFukXeG2yDWj0i8g6Wx9TWl3ALTPtEssmfvpYnqifwsMjl05VrRSzhFfkcgH2+l62jm97MxRuqZwbP9iYOmJcM3n05Pe4llkP+KQE3ZPRmsSr4QCyAc+eONsJyKjXES+727gpAuzl0vHsInDISOzQVza7aG6IA3+eGhVe4Z8E6kqYudrZ8C+njwZWmxC9469301NSxEvMiAo5NKZuTfWB0dpkECyJmd6HvdpugUbvHJpPjFXdlTVq0rA0aCiRslFVzW7ZrMpzCzZ+LnGJfgJ2CJQpUW/IWK4axcCcTYnVuv+1z9OAvOvl9RtiFvbdNUHraLLpkA/B1FrW+gwGbGrB6lRhdS3WGRsJJMqgbd30HgGFfbQ6h5ZNKupvZ9XEC7BD0zbfug39tXCI51ZBm9vpVdq6qQoI4NhucEQMMuVSAAsRyFKIX0cOdzjEG5gFbs4/0vxzD9OA7+1gMNU+A5elJsadQaHBKdcZ1w/U/Lr3SPk6D0Wio=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2d5fE9LRpuVFWDOXH3xFEz4yC8jExx0SoMlfypsK3SZDyiih9pDbwmSlocOMG7JvgMIYFlceElpCA6Rpuckw/2Y0KcpRgFiQO5GZLHA9KpEEt9QEeppmoBiXFPZDJaGBgvkiUXH+oiPGEbGvCOzOSLNLW3CIS2moNlZpv0aTxYMZPreRWPBxoz+3mo8cUCPPYLpYEtEhfINa4McPni1+Xx02ShXQcbArkXPpI9xzx3EgKYPtBFdK43y/7AXsQuoOWFgZOvmV/etzI6TnUB1/t5gq1AogKj3dl4WVWd1jlVu0avQOxIvfqTbn9JfYK1pPqSn4X65bvzELxkstO6KqIiuKFWUxRVRK1coNlteeVlMMuTbKnPOQvv3Q4ZjRidbq7cYkI5jqepaFowyCtlvRb9dPZwEOS5kxfgMqLEcqMOB7w3dVHhWfWzw4C+BeLino
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:26:36.5203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0412134-d989-41e3-cc05-08deac3c43a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7950
X-Rspamd-Queue-Id: 1B5AB4E948F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244571-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,arm.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 10:46:52AM +0000, Joonwon Kang wrote:
> When the mailbox controller failed transmitting message, the error code
> was only passed to the client's tx done handler and not to
> mbox_send_message() in blocking mode. For this reason, the function could
> return a false success. This commit resolves the issue by introducing the
> tx status and checking it before mbox_send_message() returns.
>
`tx_complete` and `tx_status` are per-channel, not per-message. Although
`mbox_send_message()` can queue multiple messages, all blocking callers wait
on the same completion, so a completion is not associated with the thread or
message that triggered it.

This creates two issues:

1. Concurrent blocking senders can consume each other’s completions. When
   message A completes, `tx_tick()` may submit message B, then set
   `chan->tx_status` and complete the shared completion. Any waiter may wake,
   including B’s sender, which can return while B is still in flight. It
   happens even w/o this change but with possibly wrong return value after
   this change.

2. `tx_status` can be stale or overwritten. Since it is a single channel field
   written just before `complete()`, a second(possibly fast) `tx_tick()` can
   update it before the first awakened sender reads it. Because `msg_submit()`
   happens before status publication, the next message can complete before the
   previous status is observed if the controller re-enters `tx_tick()` for the
   same channel.

We need to see if there are other issue that needs fixing before you can
propagate the tx error code. Let me know if I am missing something.

-- 
Regards,
Sudeep

