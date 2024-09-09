Return-Path: <stable+bounces-73994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A2971505
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA61C22F93
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871E1B3F0A;
	Mon,  9 Sep 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S55gVMNL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S55gVMNL"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28801AD3EF;
	Mon,  9 Sep 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876857; cv=fail; b=HotGhrsaBwD6qp4jF++DKzSBijEBq+7KTeLMjPBTZ6p9mK2BVvjYyNoI7jWUhJcoqbT+rTbOtrtdHl9xfOHf9+uYCLaN1fHZMUQrvGYh+ejvkt4dGQR1EXvm5qy77cRZVqTPjm24pEvPV369sGLz0vvuo/QW5lZ15L4QCAddzyU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876857; c=relaxed/simple;
	bh=ge2HhZLbJrwDfdm2M6D1ZiUlIwkj5qrvBTv9bds0/W0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3rfpaPM5Yk8Do9lWpMaEuwZXyofKsHcbdIpnhHSIrjMcz7tq3X0LvL++ZAvh7CkTBfKLX0MQ+kLI4Tnem6ScdAyIoWBGv1qfTz2Wllbv9azF/dM1XIvkmn3D9yrrVCKQ/FegY8n8QyD8W0qyQXer5HvLHfNKpx0vP762b3Bc/0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S55gVMNL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S55gVMNL; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S+NussZec075NIsN3QKUnZjbSF/eiWERbGbiKc1DZtzWK7WlJhvcH0TxhUqcm89YpLzLj2bauDJqNF1sxan5lrHr5a1iN9sqXw+1FDHkJT/CuClrkbfRrUP4ZbyNTB0F9xSRjUdvi62fN9v1CbRWtMHv7GveEnXgd9DnmRwWHsAnc9FKZlA0gNtVpwQzUolq5E6HDR4+5tyz7SMhmsldGk/fUuMiuWqgbwwI2QG/4XqY6zUmvlDsDkKoAtV95ES1RUJhsDSMUhwqI50cpXfnNNsKIBbvVkQiGKiVhBSyOhzpQg++F81bObRwp8yQrjGQydaMzsWqr+eDRIsYXkMDuw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nv+DKDtP++1KJvQWZ6YCUwLyMjj44CLNFzIoiBEtP4=;
 b=YJoSV13YjR610osukQAnHxtvFo6D424ETQeZA5LpP+DtSyiN43/VPfeyqPe3dbwn/et2dMi07fBlozhKNlj7wzHNm+iNYVJVEe2GrGb+tDw5sI52Nk3YXYDDKZu0b9S+vQffs0vGoEfuddNxZFAsXx2jYA+U5XoHOcK+Q6oPL6Y7aT0E41XDNVdqPUrloD8k8WiSh+fyfF71ojKLo5ca0DV/4OtJV6mlAnN3F0LrxWaE5eO7rjL5f963v1OZ//iaRH+wM0lyL0VLtzBMaE10gJx21mZlE7lwo2HAddBXHeZK5+r0299LqdcZQj1Qvsv81Tab+m0V/vY0D+75T2yLYw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nv+DKDtP++1KJvQWZ6YCUwLyMjj44CLNFzIoiBEtP4=;
 b=S55gVMNLoUPxVP7Bi7Ipt8VnZX1qCdUbFh+xt3lR1EFy3AjMM+BZZMn30FRVR32XkMCSAAyzmjopgrJwbZL8iGFh5/+UCxVDZ9jy4MA5OnVWBIJ4ddGvEuqY1kET4WY/CKeKebOg+a3Xz5aWlBhnk+5s5iWvZarCgproQNd3OE0=
Received: from AM6P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::28)
 by GV1PR08MB8356.eurprd08.prod.outlook.com (2603:10a6:150:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 10:14:02 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:209:8b:cafe::ee) by AM6P191CA0015.outlook.office365.com
 (2603:10a6:209:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Mon, 9 Sep 2024 10:14:02 +0000
Received: ("Tessian outbound ecaad94cfc52:v437"); Mon, 09 Sep 2024 10:14:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 786fd33702e9630f
X-CR-MTA-TID: 64aa7808
Received: from Ld34b547036a1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 63255B82-4549-4961-82C0-E2435EE5EEDC.1;
	Mon, 09 Sep 2024 10:13:54 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld34b547036a1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 09 Sep 2024 10:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvqJE688naTJ9wWFBShcQ+NoCELabujCzn7VbDjuJgQogv2W0i71FgGSdUM8H0R9vDd1FQRHfAzPWDNJJNJra8DzSE6p2ZGeRQmdEcQDd8ASvjwi/zSo2jvWYDpPi3IWX/m/W/mLA/vWzTGoVR5z8zIdNnDWXTYBURF6LBMC3dzoW7mTMgbtGJk1JrdVNg59mEntczaiJefKbnKcZiwfY8ZtryOWiNY5FdORL/nlHmJVjsXBRXOHjEkiPPZoCUsRHbdmVSmUFvESMIsKSDEsdzxAIQcelCmebpu63ciH31P9nyS7TOw9nPsW86er50k1V/m7PnYkN9JOaGJyCHEnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nv+DKDtP++1KJvQWZ6YCUwLyMjj44CLNFzIoiBEtP4=;
 b=xfWBQxxQCXusVGseQJ18E03ifi7UOdqrTzeXBHFl3UEfJmh2auQfqQ42WCOutZPM8JJQKO+f4d6jtkrLQWb3PXQ8CoATJErRdhdoxAMr+STcQ0HPBx0NaVtRdn+AbZvvImUhCnYi3A6Z9biZz5HGGOGPMb0RoHFJB5FrI6F3QNHaS2p07wXsotV/AwX9E9EbeQKh5djaqUaLfDjmcbYt14a7dkgF7dCkFN9ax9/vxuFXs8aCQHYTQTHXl8fxCaT/5XiRH3e+8T4XIiDmR5xh5sahoqVJNx16tOPcdL4NNjtfyx+u0cxJLJPgOmfum30lAD6UOFbzLbUIx7jRtk0snQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nv+DKDtP++1KJvQWZ6YCUwLyMjj44CLNFzIoiBEtP4=;
 b=S55gVMNLoUPxVP7Bi7Ipt8VnZX1qCdUbFh+xt3lR1EFy3AjMM+BZZMn30FRVR32XkMCSAAyzmjopgrJwbZL8iGFh5/+UCxVDZ9jy4MA5OnVWBIJ4ddGvEuqY1kET4WY/CKeKebOg+a3Xz5aWlBhnk+5s5iWvZarCgproQNd3OE0=
Received: from AM6PR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::16) by PAVPR08MB9556.eurprd08.prod.outlook.com
 (2603:10a6:102:311::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 10:13:44 +0000
Received: from AM2PEPF0001C70C.eurprd05.prod.outlook.com
 (2603:10a6:20b:e0:cafe::8) by AM6PR01CA0039.outlook.office365.com
 (2603:10a6:20b:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM2PEPF0001C70C.mail.protection.outlook.com (10.167.16.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:13:41 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 10:13:40 +0000
Received: from arm.com (10.32.114.149) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Sep 2024 10:13:40 +0000
Date: Mon, 9 Sep 2024 11:13:38 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<netdev@vger.kernel.org>, <nsz@port70.net>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
	<arefev@swemel.ru>, <alexander.duyck@gmail.com>, <willemb@google.com>,
	<stable@vger.kernel.org>, <jakub@cloudflare.com>, <nbd@nbd.name>,
	<broonie@kernel.org>, <yury.khrustalev@arm.com>, <nd@arm.com>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <Zt7KUrWB4xNSk95A@arm.com>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM2PEPF0001C70C:EE_|PAVPR08MB9556:EE_|AM2PEPF0001C709:EE_|GV1PR08MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: e041b62a-48af-42ae-31f5-08dcd0b820db
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?bswUkAvPLQ8yd0HvJW3ry80WisWbF+Uoa2kUjMIY5WFeaq62KttSdX7H4g2P?=
 =?us-ascii?Q?VTl+Oa+hp49L2nvRnZnuDIf+/Dt1TO9J2NFrp0TZiWb+1o6lNR/5Gi5iSGgp?=
 =?us-ascii?Q?NjxjrWrObKtEZhunbmp2oil26A27wPY4Z4VvxLaxc1gbMcqeuos8pxVAqTb4?=
 =?us-ascii?Q?nx6VwicRbbXymLk3YBhh6kiLTpZTqTP1f+XAvriOL45nVZ1X8w4zRumLIuGI?=
 =?us-ascii?Q?sbqXjJVnETJtHYBcCW8Qdnm/UzkrmoAQCNZn0rvGgmLhTlM10iBUpiLVDtn3?=
 =?us-ascii?Q?43nWjqCULsWXCMwe0QGNZuyYEK7yUpO4VLlhcKb2PRDxQwLSbbj7VZeviEs+?=
 =?us-ascii?Q?4obBXpuuxBuUTzMRRWOvSSQrsZ81BPuiQfBx6PLFMgKxNGc2OAACndJkTzCv?=
 =?us-ascii?Q?hkefQkFAmGI4b5UqrUG8lLQ8Ddn5g5CeFS1j3qgMC+j6a62pIqG7rXOU8OL4?=
 =?us-ascii?Q?SLbDvYNyj/7yE4nYTnOL6Vzb2GYXa7FehZ0k8xdE1P0YLoRhgvinNUKqkzIa?=
 =?us-ascii?Q?tSHi9dqGmQdJfzKmzZBiujH93g3jHZN2kNopPGZ+8CnBuW2dv6oeHT9Q84yy?=
 =?us-ascii?Q?yrO2kYcP/sXbj0N1p2zHzQNR059mxAnMhB7Ts0v5j21h2PCthF89ctyW9oGG?=
 =?us-ascii?Q?l/ShOcvNM1j3ch0hMBNcipvaQ557dpfkJXW2QlkNXaiE9eX72C8/P5IEmVj3?=
 =?us-ascii?Q?uJtAs1qHaWyexK97s0+TfrAxrj7lEhG6EPIksdTd0DcNbWT3HEz6VYjyQP8D?=
 =?us-ascii?Q?ZHQcu7ICqPFQzUkf9ShoLFLjQgY4RJl34W/MqW40si5XeRRPcP2ZAg1+uiBd?=
 =?us-ascii?Q?4PqzOzZxD2zSGKGf79G65EfHmGl4orlDits9RCIFczVknSb68lybbXCWOTNe?=
 =?us-ascii?Q?V92TcJrM7WI7Msf+lpHRWhRw4JrdAmgAqauQccb6OLx+CwqdL59U+lbKzB2A?=
 =?us-ascii?Q?K19ssm2ItVSOQ16+I1rvNChpgyGQvOHbvbl3vKUMtck4yJCgpqgHATiHMukG?=
 =?us-ascii?Q?JcwIq4Iz7aOfY8P7DMtyC6O9psGUImD605sJmal9KgdhXZNHzHbxS3ZGu3w5?=
 =?us-ascii?Q?8C0hhENFQ+eHXaiiib+B2SZf8mWg+J5M9rNKzCrOe/LlxxJptMIZI0hl6dKC?=
 =?us-ascii?Q?T/PfVLwXmvkotv3g6SHO81Oflp8XbX6r/LfjwwixSnvbLZnEUGLZkRbO+nOp?=
 =?us-ascii?Q?mP/cPJGoqaV7ecLYuJTg5p2h6lrDzEwRMM2ki7tN+azw26l6Ckh/7J8s/d+5?=
 =?us-ascii?Q?zCPiELV/2R4+MLdiwENRYAgJnTsVSWnd8ZtEJISlfwLB0Jk6ituOBu+KPTlw?=
 =?us-ascii?Q?EsDAEZJWkbZxMMGtSfDPMsYRFr3BRg5bopUmKb3guQvyWpRv5WLgeZjMZyfY?=
 =?us-ascii?Q?2FpjjEkyfBtpFM5JjoWJ1AmgEfAT?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9556
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:e0::16];domain=AM6PR01CA0039.eurprd01.prod.exchangelabs.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4642daf1-f723-4606-dddf-08dcd0b814a5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkBuuFoxCQj6clnuWtehFhcMD6bd7BdDd7sszcVZ4wIXEG4qk9UchWn3cyqo?=
 =?us-ascii?Q?2z6gY4RIKSY3L1cl0WBeQ48tmWLk8oLKt9Vh7VkpvGYl9gktkeDhmCSQ9uOP?=
 =?us-ascii?Q?D3REf4SkT/COfN9AgDqv/0iWbaHZdIqrsHSBD5LTQtumx7WrLMqDgbhyfEBy?=
 =?us-ascii?Q?GJswb3bp1/ft9lBq6vy1GA1tX2rF5QR74G4hCU8I39Z5W75h/GpY0cT8B3ng?=
 =?us-ascii?Q?b113Fbu7W29AuMK1cTrXcS0rehCzXEJC4v4pUswVecJ+7AJcxy624GxIsBtQ?=
 =?us-ascii?Q?sYXVmp5vq3ycrc2iv8gZWnHXdxwK0rQ5GR3mNI/CrI5sboq3Rz0lTiR1ftD/?=
 =?us-ascii?Q?1Mr2aMOZnvyEfr5VCmCRczYnBoOeQGfMRr50QBzQXtf9c77kvULFLTE2jxPp?=
 =?us-ascii?Q?W2UTqjUqoOtpoyRg+4Qiu9vHWQyDktKItjDP60L+cMWyFgXSrQC0MSIzJvGc?=
 =?us-ascii?Q?rA2OGsu+1hIjvgStniQvFHE68lprxDiKNXSOy64q0JWOOGBQ0MHMepBWgmsJ?=
 =?us-ascii?Q?+DjI7SDbl9VgXS2npA+Q/F8u62LZMqG998WvBy8KOKhnUAXC1TYJnVh0XBL3?=
 =?us-ascii?Q?VqVgQjV3xBJ8w/0ZjOZ6iHr1SceEmgo28krLigxgN6ebMftdkUAQgWG+iNyg?=
 =?us-ascii?Q?WtSKwTHaU+du6AFjiqqJeDfSPBCzh1Z1SSkpY2VBGSMr3pBG31xNeWf3C8TB?=
 =?us-ascii?Q?oiRXirvLDKQg4QUPdCLM9x7nAaxM9NOqP01+tsR0J9E7r9Ygs0itcIftvy4x?=
 =?us-ascii?Q?I3TChLsIPwzZhnN0COpGgGL2DTqz0G1k0yYQWo07Nybj06tw4RKvNTF9mYCK?=
 =?us-ascii?Q?8wEVEBHrLW2UzmwhIqMFBb0edLnE8aLwxerfnIL7XEsf7zoJcfCAtIV3xgyk?=
 =?us-ascii?Q?SK00pW7XTBiTm9QC7U5RJN9OD0+QPcOFPWt3qwu8Bl013lsck7r/ex9yvSon?=
 =?us-ascii?Q?18BSOZbLN4+ow4X8iUty0XBke0spE6hP7EyPhLKOre5yqwOnAsx11UYqRHuo?=
 =?us-ascii?Q?JA8sXGDghd+qnQBExVNgxwdff2OMn8LBG0NwKyqJ/bqBAANqvrtMALsCJ7sW?=
 =?us-ascii?Q?SGQOHbKbSE6GfMUqZZRJZs/FyBMiTqwLVPm6kLN8u3Pt6s8EywlqFAQX/GI+?=
 =?us-ascii?Q?TAidgLkdAme2evPQvPE8ZE1PGXRlEiMI+GRKW4ehCFY98wG4r7rfT1SiYvQD?=
 =?us-ascii?Q?rCSHcTNlE6JA4Hmem9Bj0a7x1ACR0t95cZIfG2hNzi8qEgjvP4vsvRaGB7ky?=
 =?us-ascii?Q?+nCIkxvu7o12AStv43GOu8SvI67s4ll4MsW5TQOZMaz7mp4iKvTf4AlcX/Uh?=
 =?us-ascii?Q?j63iWaX+eo+DzXLuUZFOrLn5hustNRm2JMIJTv6wErT1da6S1brlCulxDnlj?=
 =?us-ascii?Q?kHR2SvwOKeKcTe7hp/78Fh1mL4Bq?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:14:02.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e041b62a-48af-42ae-31f5-08dcd0b820db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8356

On Fri, Sep 06, 2024 at 11:52:34AM -0400, Willem de Bruijn wrote:
> Szabolcs Nagy wrote:
> > The 07/29/2024 16:10, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
> > > for GSO packets.
> > >
> > > The function already checks that a checksum requested with
> > > VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
> > > this might not hold for segs after segmentation.
> > >
> > > Syzkaller demonstrated to reach this warning in skb_checksum_help
> > >
> > >   offset =3D skb_checksum_start_offset(skb);
> > >   ret =3D -EINVAL;
> > >   if (WARN_ON_ONCE(offset >=3D skb_headlen(skb)))
> > >
> > > By injecting a TSO packet:
> > >
> > > WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_help+0x=
3d0/0x5b0
> > >  ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
> > >  ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
> > >  __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
> > >  iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
> > >  ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
> > >  __gre_xmit net/ipv4/ip_gre.c:469 [inline]
> > >  ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
> > >  __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
> > >  netdev_start_xmit include/linux/netdevice.h:4864 [inline]
> > >  xmit_one net/core/dev.c:3595 [inline]
> > >  dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
> > >  __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
> > >  packet_snd net/packet/af_packet.c:3073 [inline]
> > >
> > > The geometry of the bad input packet at tcp_gso_segment:
> > >
> > > [   52.003050][ T8403] skb len=3D12202 headroom=3D244 headlen=3D12093=
 tailroom=3D0
> > > [   52.003050][ T8403] mac=3D(168,24) mac_len=3D24 net=3D(192,52) tra=
ns=3D244
> > > [   52.003050][ T8403] shinfo(txflags=3D0 nr_frags=3D1 gso(size=3D155=
2 type=3D3 segs=3D0))
> > > [   52.003050][ T8403] csum(0x60000c7 start=3D199 offset=3D1536
> > > ip_summed=3D3 complete_sw=3D0 valid=3D0 level=3D0)
> > >
> > > Mitigate with stricter input validation.
> > >
> > > csum_offset: for GSO packets, deduce the correct value from gso_type.
> > > This is already done for USO. Extend it to TSO. Let UFO be:
> > > udp[46]_ufo_fragment ignores these fields and always computes the
> > > checksum in software.
> > >
> > > csum_start: finding the real offset requires parsing to the transport
> > > header. Do not add a parser, use existing segmentation parsing. Thank=
s
> > > to SKB_GSO_DODGY, that also catches bad packets that are hw offloaded=
.
> > > Again test both TSO and USO. Do not test UFO for the above reason, an=
d
> > > do not test UDP tunnel offload.
> > >
> > > GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
> > > CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO transmit
> > > from devices with no checksum offload"), but then still these fields
> > > are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
> > > need to test for ip_summed =3D=3D CHECKSUM_PARTIAL first.
> > >
> > > This revises an existing fix mentioned in the Fixes tag, which broke
> > > small packets with GSO offload, as detected by kselftests.
> > >
> > > Link: https://syzkaller.appspot.com/bug?extid=3De1db31216c789f552871
> > > Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@ke=
rnel.org
> > > Fixes: e269d79c7d35 ("net: missing check virtio")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > >
> > > ---
> > >
> > > v1->v2
> > >   - skb_transport_header instead of skb->transport_header (edumazet@)
> > >   - typo: migitate -> mitigate
> > > ---
> >
> > this breaks booting from nfs root on an arm64 fvp
> > model for me.
> >
> > i see two fixup commits
> >
> > commit 30b03f2a0592eee1267298298eac9dd655f55ab2
> > Author:     Jakub Sitnicki <jakub@cloudflare.com>
> > AuthorDate: 2024-08-08 11:56:22 +0200
> > Commit:     Jakub Kicinski <kuba@kernel.org>
> > CommitDate: 2024-08-09 21:58:08 -0700
> >
> >     udp: Fall back to software USO if IPv6 extension headers are presen=
t
> >
> > and
> >
> > commit b128ed5ab27330deeeaf51ea8bb69f1442a96f7f
> > Author:     Felix Fietkau <nbd@nbd.name>
> > AuthorDate: 2024-08-19 17:06:21 +0200
> > Commit:     Jakub Kicinski <kuba@kernel.org>
> > CommitDate: 2024-08-21 17:15:05 -0700
> >
> >     udp: fix receiving fraglist GSO packets
> >
> > but they don't fix the issue for me,
> > at the boot console i see
> >
> > ...
> > [    3.686846] Sending DHCP requests ., OK
> > [    3.687302] IP-Config: Got DHCP answer from 172.20.51.254, my addres=
s is 172.20.51.1
> > [    3.687423] IP-Config: Complete:
> > [    3.687482]      device=3Deth0, hwaddr=3Dea:0d:79:71:af:cd, ipaddr=
=3D172.20.51.1, mask=3D255.255.255.0, gw=3D172.20.51.254
> > [    3.687631]      host=3D172.20.51.1, domain=3D, nis-domain=3D(none)
> > [    3.687719]      bootserver=3D172.20.51.254, rootserver=3D10.2.80.41=
, rootpath=3D
> > [    3.687771]      nameserver0=3D172.20.51.254, nameserver1=3D172.20.5=
1.252, nameserver2=3D172.20.51.251
> > [    3.689075] clk: Disabling unused clocks
> > [    3.689167] PM: genpd: Disabling unused power domains
> > [    3.689258] ALSA device list:
> > [    3.689330]   No soundcards found.
> > [    3.716297] VFS: Mounted root (nfs4 filesystem) on device 0:24.
> > [    3.716843] devtmpfs: mounted
> > [    3.734352] Freeing unused kernel memory: 10112K
> > [    3.735178] Run /sbin/init as init process
> > [    3.743770] eth0: bad gso: type: 1, size: 1440
> > [    3.744186] eth0: bad gso: type: 1, size: 1440
> > ...
> > [  154.610991] eth0: bad gso: type: 1, size: 1440
> > [  185.330941] nfs: server 10.2.80.41 not responding, still trying
> > ...
> >
> > the "bad gso" message keeps repeating and init
> > is not executed.
> >
> > if i revert the 3 patches above on 6.11-rc6 then
> > init runs without "bad gso" error.
> >
> > this affects testing the arm64-gcs patches on
> > top of 6.11-rc3 and 6.11-rc6
> >
> > not sure if this is an fvp or kernel bug.
>
> Thanks for the report, sorry that you're encountering this breakage.
>
> Makes sense that this commit introduced it
>
>         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>                                   virtio_is_little_endian(vi->vdev))) {
>                 net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>                                      dev->name, hdr->hdr.gso_type,
>                                      hdr->hdr.gso_size);
>                 goto frame_err;
>         }
>
> Type 1 is VIRTIO_NET_HDR_GSO_TCPV4
>
> Most likely this application is inserting a packet with flag
> VIRTIO_NET_HDR_F_NEEDS_CSUM and a wrong csum_start. Or is requesting
> TSO without checksum offload at all. In which case the kernel goes out
> of its way to find the right offset, but may fail.
>
> Which nfs-client is this? I'd like to take a look at the sourcecode.
>
> Unfortunately the kernel warning lacks a few useful pieces of data,
> such as the other virtio_net_hdr fields and the packet length.

fwiw, this is not nfs specific: if you boot a system with this kernel,
them most network operations will fail (e.g. scp-ing something on this
system or trying to curl or wget something from within) with the above
mentioned error eth0: bad gso: type: 1, size: 1440

Kind regards,
Yury


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

