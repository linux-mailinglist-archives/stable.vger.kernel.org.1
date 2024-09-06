Return-Path: <stable+bounces-73794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9096F703
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830D91C21329
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811BE1D172D;
	Fri,  6 Sep 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E26o43iF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E26o43iF"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABC1D2F51;
	Fri,  6 Sep 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633345; cv=fail; b=og3tERqhkVGLxRndJ0HOXfnqzGIGimjiy9gQVIBTrLKP/QCwYvc0HOaaQL6ZuwQTRliyRYQYw6gCEjWnQ12LqSjrOWOIiv9PVIzTQzhSHCJ7As6SsO6XKrcq2jTY9f+4vHYIPcSJOoc81ziZrxibdtcr13dZaX/pOYjVhT7IjeE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633345; c=relaxed/simple;
	bh=ok84vCGCr6+xV3q2zkMjZatX/Nerkn7trbWEP1E5xjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTd/6xZ/OGoNfo6RydXs/fvU9ni3vl85W8XAQMJhktjGUterDlXV7JePRr6u12v7PE/dUFmQaP2YAs/6rMVuStzVk26c4fqaXUqTLBYCQobqpqyc3y14ZtYmxr6r++Ncu/4bLYOwGRRDgi5kkpCufhPWFPFQ3olt1nPbZI0mhT0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E26o43iF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E26o43iF; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nSW5H2g5MYrKr0EOSFphs8NLCwLmncnKRmlXMvd6PSM1SOV+tlJGx7tt8BxVkf9ACiTnoNxZCPiv1gZkIkptQpKqho5HWEOUpHgqj0MtopSRc3FZDKUMP5jgAqPw+5zft9RFo2HchfJZjxmQS/b5FkrrZ8dDSyWakda21Z1yYYgMAiZttbSXileYnI0UTzP175X4XVCKkH8CUEB1sC3r9NYtPYe57z8KR4TAPQpA90CNBtybw+sUp3VIaghmj8B6SkIvc1I4rdNvlIbmsa+bhXPs7K2u5Y1u+Fu/h/5Yo0TmwfJ3eMupO3j2KhPtzkrLoZe/ojWciFFFkTERxkVs7A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YivPNErdfo1YMzHEN4oVbaBY1psH3yB+yAG1kp4xGlk=;
 b=i0XCLTO0Mus1Gw7a16J5cCUeWXVf0HBqzCJS4GVVr+2Gt7vO0kerNl43Nghn/+uqQAiiN9dDk1kN2lKnRlCZaf9NBQ/d4kwDgaLPbEYkW0WdhzJUNFT/ZaU7Jsah3WC+B+gA8QWPFSrMZFAHBtcgmvHjxoIraFRzxIUai9ZgBiwJbxrHEIo6Q2uK+cBxOXIubMNcft025Vw7Xp1y3XTF3yW6F+nZkQ5JaWO+6ctLXbjAXK+7dQKHNwyVkr13jMhNcvrCKdlQMvrxqGmjJNAh9T6QUjAYyXJDh81SQCkT131JzuLP82ajEiZcppN88C4ofuSe/94KnhbCUq3c0Mn1Ag==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YivPNErdfo1YMzHEN4oVbaBY1psH3yB+yAG1kp4xGlk=;
 b=E26o43iFxGb4zNiVNk4BZM4h7+UFXhMvmTVi6knkUrkDZJ6Ligequl1D9KkGzQH86HxDLGKb+yDvyqv9prj7ZyQzwG18uRTSgXp+xsAqmbOEGXlQhwflqa8zc3T1tGfXiTmXAG2dMmsjLuK775i+NroUhWicyExNOMUuW9mG/b0=
Received: from DU7P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::32)
 by PR3PR08MB5579.eurprd08.prod.outlook.com (2603:10a6:102:8c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Fri, 6 Sep
 2024 14:35:36 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::da) by DU7P191CA0007.outlook.office365.com
 (2603:10a6:10:54e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 14:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 6 Sep 2024 14:35:34 +0000
Received: ("Tessian outbound 6d35f8653bd9:v437"); Fri, 06 Sep 2024 14:35:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4c37e21414665bed
X-CR-MTA-TID: 64aa7808
Received: from L824ab7407aaf.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E7761424-037F-4858-A9AE-E9051E8B5CAD.1;
	Fri, 06 Sep 2024 14:35:24 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L824ab7407aaf.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 06 Sep 2024 14:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZWvhnYHhzKJryrhGJWoJ9P2vFYkZ54oM0qCOwct0DMudt0sjpg0gBUB37x9FmiqzqThd4PAXE//LRfY2W1PDWrMsJDnUmPbs7zRn6HC6cbRaFoW0kJp1s6nbIhma82NhTK7ogDEfRw2z1MKB4wH7jWBkVmriCcgsQjHe7q3PlpFVivUzmZ5RTuMzHg0Cvd8nwtKgL8xl3Pa1hoCu/WU5ZiZegHQ8vk1VkWnrwF9giRkS0Ut02i/4/UBFWeDLzr83twu1azjARBR20UE8JrWIzIRNE9EttuUjOUQAwtGFffsqSBtE8FeTYf2tqqoU41SlXuHlZDNVBs4S5FGAbAE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YivPNErdfo1YMzHEN4oVbaBY1psH3yB+yAG1kp4xGlk=;
 b=sEInPD9okDmF67uJbeI1q3sY+XjKAVk1x+cEpDG6HScPSwJsyT8wTu0rjSIAZdN8TC31UrxmWAMOdd2Vibaspn3tFDig9RnarJvCcurKlNyB+MnohFKFcrE/zq2Ysel7W6rL6hGnbKaiXiDz3/OUDt4JeACtAAD1w1m5BZsRh1eQG73GEbiNgJ0GSgZlPVvfD3NE5OwR1kzXwAgGKS61ggn+flZVPxFdIprj58mh73T3GxZ01iZyG6p23HIeghFltc0Stjg2GZ1skAhZgK3EmlMohdFsVhhx85d34d5NzR4WllyCCp8a1Hp3vNA1TzAwRIPbFZL0AoRu/xj4bEQdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YivPNErdfo1YMzHEN4oVbaBY1psH3yB+yAG1kp4xGlk=;
 b=E26o43iFxGb4zNiVNk4BZM4h7+UFXhMvmTVi6knkUrkDZJ6Ligequl1D9KkGzQH86HxDLGKb+yDvyqv9prj7ZyQzwG18uRTSgXp+xsAqmbOEGXlQhwflqa8zc3T1tGfXiTmXAG2dMmsjLuK775i+NroUhWicyExNOMUuW9mG/b0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by VI0PR08MB10581.eurprd08.prod.outlook.com (2603:10a6:800:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16; Fri, 6 Sep
 2024 14:35:20 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d7e:3788:b094:b809%6]) with mapi id 15.20.7939.016; Fri, 6 Sep 2024
 14:35:20 +0000
Date: Fri, 6 Sep 2024 15:35:06 +0100
From: Szabolcs Nagy <szabolcs.nagy@arm.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	arefev@swemel.ru, alexander.duyck@gmail.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, Felix Fietkau <nbd@nbd.name>,
	Mark Brown <broonie@kernel.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>, nd@arm.com
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <ZtsTGp9FounnxZaN@arm.com>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|VI0PR08MB10581:EE_|DB5PEPF00014B91:EE_|PR3PR08MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7028bc-0d04-443e-53e3-08dcce812ae9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cnQ5a3RUSUxobFFXZm5CUzNkNEUyZ1pyZzF5VHNOOXB3S1owb2svWUZMRGF1?=
 =?utf-8?B?RWdSbk15eXR0Lzc3NEc5UmJkTU1oeGNEcTJGZDA1QUR0QjBNTDQyeXYyOWkw?=
 =?utf-8?B?Rm00RXdSczZ6dmZMTzM0cTRtenpjRUhkK2xpNHRGcmRaSytScUJxR05OTG0z?=
 =?utf-8?B?Qk1IVTVuMlJXcWd1Vy9sa0lqWnc4RkZvRC9IK2hEbHNSNEZpb0RZSU44aUhh?=
 =?utf-8?B?MGUySWgvdk1FbXRMdWJVRnowVDdvMG1qQWtrRUUrbmZHYWlXaDV0cCt0V2VU?=
 =?utf-8?B?cGErY1JSeEJqUkpmS2R2TVMxOUQrUnFDYVY3OTRWZXY2RFNzRGRTYXRxUzV2?=
 =?utf-8?B?WkJ0ekJXeGU3Mm50bTZTOEozNGlLNXFGZmRmQk9Xb3IrSzlYVGVwTGwrNG00?=
 =?utf-8?B?NWdmSTVqTFNYcEhzb2dURnppY1h1N1BWbUx4Zlp6Q0ZhSUhjdnVNMDFQdndJ?=
 =?utf-8?B?VDl4VzNtaHpOUFl4NFE2LytkMGRWejFLa2pzWnRyNW81R1JhenFvZDlwbTJh?=
 =?utf-8?B?cmhoWG5TNzRNK1p2TzFEY1BxaGE3aUR3V01pckwzeW9WYXVpVzJKVTRHWlMr?=
 =?utf-8?B?OHE4UXU0OWRpNWY2KzdiWnV2Ykl5Q1hMV2JuSVR6LzJ4QjZsUnF2RExuR3pS?=
 =?utf-8?B?WklMRi8wQTJIaEo4emFMaXhRYUcvR2RIOGRyd2VrKytkVjNrYkdTVXQvYXpo?=
 =?utf-8?B?NHhkQm1nR3JseDhCbEV3VTZ0OVBiZ3ltUVZUeVc4b1pxYjFzWlNhK1VDUy9j?=
 =?utf-8?B?THFpYUJ1RjBkWHRoSjhaMVFST0ZxQ0ZnOVQ2OVJUNThrN2Z4SWdvU0RJN0lN?=
 =?utf-8?B?TnhieXlSd3BsQVdSd1FMU3h0M1k4L3phVDNJNWtOVlc5SG9xekxiNHA1YVlC?=
 =?utf-8?B?Y2M4M3RSaUJ5REZHSmluZGxLSEEwTTE1K1dISnNKM2h4UXppYmFwc2NTbjNV?=
 =?utf-8?B?a3RqY252Rm5IVUx4M2xPcm5aNzRhS3V3RElWVk4zaWpXNVM5YlhkcDk2RVVM?=
 =?utf-8?B?WHl5WG5ENnhscXlnNTRJaGk0MVlLUVBlRXVSOW8wNGhuVUUyeVEzNUhwZGVY?=
 =?utf-8?B?ZnMvSHRBNXl0R2xodi9SSkQzUWZTSWpwdUUvdSthNXptV1JmNEZlcmlDOHJn?=
 =?utf-8?B?L2lFUFVTZlZLNWVBcHBaTzYyRXlNREtVQk9SSzl2bkJYZ2FpSEZLUTZTS01q?=
 =?utf-8?B?ZllYZXpUNm16ZHhqbE5CQk40WEc0Q3dYS2RNcjR4bEM2dU91M0dmQmxPNDZ1?=
 =?utf-8?B?WXcvMDdrdHRGQ01IY0g4SzAwMktEQlFWN005UEQyU2VIcjl2ZnRyOTFES0cw?=
 =?utf-8?B?VmV5dHlQYjJBb2piQ0VwTzA0UzJYamZ3VGV3Z1RXY3JGVlBPRGtGTC9pWE9L?=
 =?utf-8?B?dWg1N09rc2lOdE1GMGdOeW5oL0RRL2o3YVdMTW00M0NwUjN4UlU4TnAyZndn?=
 =?utf-8?B?S24zaFJFUnBqblpLZTNVMkpLRnd3VEF3OUFONGtING5XcjZQVkNFbFF5SWtE?=
 =?utf-8?B?ZnQvNkZLbVdyUGxxZlpoTGtWV0NGNkJ2RGQwWmtFWFd2Qm9CeE1CUGNORnJl?=
 =?utf-8?B?VmlpVGZzOUlBVlJxOU5lcWJlSFc3MFZpSlBRclFYd01IWVNGeXBCR2RMSlE5?=
 =?utf-8?B?QzZNd3lFd0M4aGJHR2JvUk9YQk02dTFlcUpodEZZeGNVNHFEckFZalgrRitH?=
 =?utf-8?B?YWRBZWpwK1IyNCtSVVlKejA5ZEk4bm1MK3ZrdVdoL0Q0U09GN2JESTRaeWNK?=
 =?utf-8?Q?htpetnqNKuxSM9TlVQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10581
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:2cc::19];domain=DB9PR08MB7179.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	140987ce-cc69-4abf-09f9-08dcce812223
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU9JSEk3M1FFRGg3VnV0U3lDd25ZbWE0OUk5UmRiNzlzWDJwd2VRSWJIOWp2?=
 =?utf-8?B?cE8wL1FBZXlCVXN2TmN5VHc1ZWNURmYxdGQvSmlCMnZaM012aTRWd3BEZWtX?=
 =?utf-8?B?UzhMUUV6UmRkMjFwdVdBTi8zdXZVM0NYdm1xQmQzUFRFbGRoT0s3RnZYU2s1?=
 =?utf-8?B?czFpYUo1NDZzdlQyMVkxY3FqSzBGYzl4MW5ha3JFbzAwYXRobnBkd1FYeWJT?=
 =?utf-8?B?TGJFbCtlU3IzK3FMcDZZYUNOU3Q5RklhellZblkyMXJYRktrampobXFIU0ha?=
 =?utf-8?B?ZThKdzdML3FpMmdUQ0RBR1EwZkp3LzB0eGlWdFlOTkpzdzZkZmFtb0toKzVo?=
 =?utf-8?B?YXRjQkNtQzlCQ1VhWDlqcm13TndMREltb0JkY3NIekhOMEpWVWVvMkpNekI3?=
 =?utf-8?B?N0hmQzl0M0JhUStGb0JVbmc1Y0FwaWRzeXArSENCSFNUZTRoTzBCRmRrYWdG?=
 =?utf-8?B?TVE1U2I3aFF0UmprdGJVclRYekhtdXdXcXBld3JBUEVMMHpYRlVCMERZMzhl?=
 =?utf-8?B?bityRldsRmdYZU1zcnNpM1M2R3R4S0ozcExnOXVHeDMxQnVtVVR2Szc1ZDVG?=
 =?utf-8?B?bWdaZHFCYzY2dG9hS3hJMjJoMDV1Y0EzbUk3TFhETFpOMHhVWEV0cWVabllF?=
 =?utf-8?B?VTY0dW5kK0EwNllvRHQwY2pPRjlZL3NlQk0yYVI3SE5lVk10emZleWlqVy9v?=
 =?utf-8?B?R2QzRlpaYnpwQ0E1MDFlT2g1czhsMlVlQ2plMStpNWhUU3NiWUxCYlZ3bHJQ?=
 =?utf-8?B?WmVzb1pESFMrRyt3SEh3bEY0UzJuNkh5N1BhUmx1WWxFaFIzRmI5TEJHNzRE?=
 =?utf-8?B?Z0JleVRFbVdqaTBYSms3SzFFenFnS1djcVhXMzk0UmpkMDZYditJRlFYZHg1?=
 =?utf-8?B?cGRLdGZMWG9IL0kvTzhvYThIazFucGJLdTFzT1BmMmRjTGU0RHNLN2t0TDdw?=
 =?utf-8?B?VVpxb3NvOHpvaFpDQ252bi83THJoNzl1b2o2OVNpVHduR3YvZXo4UDhXUXY5?=
 =?utf-8?B?NlFGam9vWlU5NzkrK0pid0FCVElDVkpzaUZVNytyemVFRElORVBtS25wVC8x?=
 =?utf-8?B?R0E4S2VmY05MelY5SitBRUhvRTFod082dDJUUXYwcVl1MlRPbUdmdEgreHE4?=
 =?utf-8?B?KzMvZUd2U1htZkxaeURlcXBwekZBa0MwQS9TN2dHQTBjWDVXOFp4QjdJZHdK?=
 =?utf-8?B?MENjTUNldXhaWVJXR0F1cnNRaWRkZDg4dDR3MlJUSWxmV1llSGRQMjdpYUtD?=
 =?utf-8?B?WUM4Qm9CbnVlTU9sS1VZVFpLV20wUyswejNMMmUya0J0YW9nZXNjVzd4dXRC?=
 =?utf-8?B?WktmdnRBL2lDNkg3QUVVZjgvREJKWUVHVkNoaWxWWjF2dnZBWHBQRTVhdmdL?=
 =?utf-8?B?ZGRwYVF2eWhJUkwxQ0JKdUJuRWVNbjF6ajhJZDBYOXNKWlRQOXdJd05iNFl2?=
 =?utf-8?B?REIyd0dmZWd6bUFyQUVQRlFtL0puaFgvQ1FKN2dtL0dxYXpIYWJ5d0E0cmdH?=
 =?utf-8?B?ZUJsdzdsclh3V3phUXFxbWdWQkxqc2VnZU5CdjFvYStsNXBpN3BlbmgzaXJB?=
 =?utf-8?B?Umg0ZEZBMDRLKy9QSVBZbzMyelhJSzVHSXV6blFHeVZ3Nk1VUS9tMEk1RHk5?=
 =?utf-8?B?ZXdRREt2eGhBa2pLZk1NMW5GUitiVmtsMmJjOTkrUnp4S1daSHg0eEw2SGsx?=
 =?utf-8?B?b1JsOTl6bDhtMGlxUE5IME43cTNIYTlRNHMvY0tXelhmdWU3SWVkRnI1K1Z2?=
 =?utf-8?B?aXdOWlhOVnN0aUJmM0RxMXhRb0I2NmU2YlNxb1Z6Zmd3Q00vNERDNlJiZm4v?=
 =?utf-8?B?d1RzMGlSdytmdTRXUHZ0SGdnZVV6TmN0OFpkaEdGUzErZUxHWEZuM1VucTRn?=
 =?utf-8?Q?z1KzkV0Rjg1cc?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:35:34.5492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7028bc-0d04-443e-53e3-08dcce812ae9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5579

The 07/29/2024 16:10, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
> for GSO packets.
> 
> The function already checks that a checksum requested with
> VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> this might not hold for segs after segmentation.
> 
> Syzkaller demonstrated to reach this warning in skb_checksum_help
> 
> 	offset = skb_checksum_start_offset(skb);
> 	ret = -EINVAL;
> 	if (WARN_ON_ONCE(offset >= skb_headlen(skb)))
> 
> By injecting a TSO packet:
> 
> WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_help+0x3d0/0x5b0
>  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
>  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
>  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
>  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
>  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
>  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
>  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
>  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
>  xmit_one net/core/dev.c:3595 [inline]
>  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
>  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
>  packet_snd net/packet/af_packet.c:3073 [inline]
> 
> The geometry of the bad input packet at tcp_gso_segment:
> 
> [   52.003050][ T8403] skb len=12202 headroom=244 headlen=12093 tailroom=0
> [   52.003050][ T8403] mac=(168,24) mac_len=24 net=(192,52) trans=244
> [   52.003050][ T8403] shinfo(txflags=0 nr_frags=1 gso(size=1552 type=3 segs=0))
> [   52.003050][ T8403] csum(0x60000c7 start=199 offset=1536
> ip_summed=3 complete_sw=0 valid=0 level=0)
> 
> Mitigate with stricter input validation.
> 
> csum_offset: for GSO packets, deduce the correct value from gso_type.
> This is already done for USO. Extend it to TSO. Let UFO be:
> udp[46]_ufo_fragment ignores these fields and always computes the
> checksum in software.
> 
> csum_start: finding the real offset requires parsing to the transport
> header. Do not add a parser, use existing segmentation parsing. Thanks
> to SKB_GSO_DODGY, that also catches bad packets that are hw offloaded.
> Again test both TSO and USO. Do not test UFO for the above reason, and
> do not test UDP tunnel offload.
> 
> GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
> CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO transmit
> from devices with no checksum offload"), but then still these fields
> are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
> need to test for ip_summed == CHECKSUM_PARTIAL first.
> 
> This revises an existing fix mentioned in the Fixes tag, which broke
> small packets with GSO offload, as detected by kselftests.
> 
> Link: https://syzkaller.appspot.com/bug?extid=e1db31216c789f552871
> Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@kernel.org
> Fixes: e269d79c7d35 ("net: missing check virtio")
> Cc: stable@vger.kernel.org
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> v1->v2
>   - skb_transport_header instead of skb->transport_header (edumazet@)
>   - typo: migitate -> mitigate
> ---

this breaks booting from nfs root on an arm64 fvp
model for me.

i see two fixup commits

commit 30b03f2a0592eee1267298298eac9dd655f55ab2
Author:     Jakub Sitnicki <jakub@cloudflare.com>
AuthorDate: 2024-08-08 11:56:22 +0200
Commit:     Jakub Kicinski <kuba@kernel.org>
CommitDate: 2024-08-09 21:58:08 -0700

    udp: Fall back to software USO if IPv6 extension headers are present

and

commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
Author:     Felix Fietkau <nbd@nbd.name>
AuthorDate: 2024-08-19 17:06:21 +0200
Commit:     Jakub Kicinski <kuba@kernel.org>
CommitDate: 2024-08-21 17:15:05 -0700

    udp: fix receiving fraglist GSO packets

but they don't fix the issue for me,
at the boot console i see

...
[    3.686846] Sending DHCP requests ., OK
[    3.687302] IP-Config: Got DHCP answer from 172.20.51.254, my address is 172.20.51.1
[    3.687423] IP-Config: Complete:
[    3.687482]      device=eth0, hwaddr=ea:0d:79:71:af:cd, ipaddr=172.20.51.1, mask=255.255.255.0, gw=172.20.51.254
[    3.687631]      host=172.20.51.1, domain=, nis-domain=(none)
[    3.687719]      bootserver=172.20.51.254, rootserver=10.2.80.41, rootpath=
[    3.687771]      nameserver0=172.20.51.254, nameserver1=172.20.51.252, nameserver2=172.20.51.251
[    3.689075] clk: Disabling unused clocks
[    3.689167] PM: genpd: Disabling unused power domains
[    3.689258] ALSA device list:
[    3.689330]   No soundcards found.
[    3.716297] VFS: Mounted root (nfs4 filesystem) on device 0:24.
[    3.716843] devtmpfs: mounted
[    3.734352] Freeing unused kernel memory: 10112K
[    3.735178] Run /sbin/init as init process
[    3.743770] eth0: bad gso: type: 1, size: 1440
[    3.744186] eth0: bad gso: type: 1, size: 1440
...
[  154.610991] eth0: bad gso: type: 1, size: 1440
[  185.330941] nfs: server 10.2.80.41 not responding, still trying
...

the "bad gso" message keeps repeating and init
is not executed.

if i revert the 3 patches above on 6.11-rc6 then
init runs without "bad gso" error.

this affects testing the arm64-gcs patches on
top of 6.11-rc3 and 6.11-rc6

not sure if this is an fvp or kernel bug.

