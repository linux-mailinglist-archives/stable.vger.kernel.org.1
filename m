Return-Path: <stable+bounces-40321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E18AB672
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 23:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF4DB21F4F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03461137779;
	Fri, 19 Apr 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aR6BXleM"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7049137778;
	Fri, 19 Apr 2024 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562241; cv=fail; b=kEoypyJSUqYaXwvAAva/6cQfvH0HgdNrsCRew1m3v89MKq/yCt2HqYxOK9Kdd41oaPfChScFJDQtGePQJWq2mudEnAsYYr+1+CF5G4mIfug3YJI6wPC6PJaNxlu2R/XowfFm3vQ4HMeAjUcSkJdxL9/YUQweQV/oSQUzM0CIRhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562241; c=relaxed/simple;
	bh=8C36fyke2XVz5l+w3beS3U82+jyuVFP5QDX+I5XFfUs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cC03w4XJXJ56tmqatleFaflDUCkIuT58j+K0qcQtP6MHtNcB6eJppCaujFGGaANRxPi0s03M7WWsU2H5+bc3lNLoLo9v632dqgKXeJSs91LFDW5nimp8OzZgM8JKjuKMiLlcFPAkeuZUrN4y9PvcgWWTN9Qr5kAmu2wPtyeZjA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aR6BXleM; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwXodqawBAsjmxyCXouusb8Yx3Q4RMSJXdP3sXWjAI8690CtCjKqK7ftVZANVmA+/dccsJP+fAW6EIrRd0XVUTmVxvvYubCHGgdXTMD9ecSmYWQ6CF6DfrWlM49lFtFYb28vGjSH2YDkgYI9xYjKOBWKnhmnObwXpDO2jIN/2ThCn1rfUT1D2gMHhLOndIi2Bfwhc0gCmkcSKLMDF6XIKTGwzgb0gDz25jis34SeonT+hX0XHRzU7ncWwm8735dZJKERhsATIeHUU9g/BBHCD/HSOIPdXZe6afUPrAnO8jxqf5HqmtsRkaUEaeWcA76zESBbEl39dzJ3Ozw747XGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwlzGIJ6hzjeRHKwLRBHKleVsIY6T3EDamdiaqoHq8g=;
 b=oFMp/pivwRbCa8aChIeVf0Rymkeu6sYRWp73LfrmZnDIqU4oQsSM0qmgzh/at01yBFJLqVEXOixdiHVpeZ453zT1dg7YNjbU85c5wMZPBr8sUBmq1dzihgxL8eWZZZXuzx1PnJtViCuPx4Vd5cDJ2MWD89kco9DYjGnAi99oKhd9TmdTV9x1LHO3HzjFI1XocSYmenmTNEZEHQtD2YD2ETyqiN2RWc/JukRH0M/uZ60easKd8wbFW8ozW/6P7Y8uu5vOvXcBIhwt7CVE4bxx1sWufSyZYEXVz2i1in91EwLVt21T0IoDF1PTTWYKq0NZp/EmIZ6d6u+Xf+ZSQAHmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwlzGIJ6hzjeRHKwLRBHKleVsIY6T3EDamdiaqoHq8g=;
 b=aR6BXleMofZfgNPgBHLan1y4WKom4oarvk+/uM01wm4uNLMsI01HcWEyTfNNu+4VQjhNZ6UA3sltDJjpR7RcpiKh4pHAFVltfIfIftds2tcJ9NCqb7b3662H62nyA4ufv3M23r8NY+L6k3UpH+P/XFDdu6IuePkA5WtbOslmrOCu56ek+gSenHGmmMCQ3KvO0wYZSrqJUuDrP17Ht9lajNw7v71R7/CbRoeMGvgWVikKnUxlYEJajLMwrNhSaAU0QHWnr5HNHE09cqCoT5PFWQZv9xVmYl7J6NgX1/ETOCZIxWhZ8SdLecyw9Is4xCcg87iw4mebuw/uvQnnsj08ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 21:30:36 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 21:30:36 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net v2 0/4] Fix isolation of broadcast traffic and unmatched unicast traffic with MACsec offload
Date: Fri, 19 Apr 2024 14:30:15 -0700
Message-ID: <20240419213033.400467-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3254dd-9b72-434b-16d2-08dc60b7f37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gb2Otn3ZSAgsAgf3RAlDAEUfieq5BMWvsZdaH39njR01C7YvjBSgKmoWOqO?=
 =?us-ascii?Q?Uzo0kMe6PV+Tqfkxkty4ZgIVXgQg7tPc3Emxy2oyFX6PGivPOFiJka6Q0vMe?=
 =?us-ascii?Q?d3IxQy0I16Jl5uHiWBZopHMMRWbdLxkP1ybml5xU5xRNQMscoBhRoyhEEA1d?=
 =?us-ascii?Q?IOGW4drkBEL0CAMOO7gyT/E9GMgZ9Z5m8goWid46gbxxB2ZPxzkiIwqhtAtq?=
 =?us-ascii?Q?DGZ7zjBeSleH+8Q2qlZ6oQ9AB7OMPpRsjIL6ln1UMVxlqYhtURLufqChGmhE?=
 =?us-ascii?Q?Vb3weXOLF/8Ac43Uk3PsdQvJ/9vHiw+AeyiUVD5+3mesBJ4LqPzsWEBQXJgL?=
 =?us-ascii?Q?jiw0fV7P+le9EDmU92ggrtREmVqe5Cu3MLGJXCD54P5ho9bxBSOXeOO2f4Ug?=
 =?us-ascii?Q?kj2HZGSZUw8CekEGsdqfxkDh5vpXaPKA5oo4adEQzmktdILEjqtDa78c8Zwx?=
 =?us-ascii?Q?WUJHl9DQGA2xaJpdggN4eJqIN3TXf24aQRFXg5E+NltFRksZ5dZ5JDO92beG?=
 =?us-ascii?Q?5G6XIEFN1FYydh+LQ7//IR09PFVHeuDYIASPYWtZ5SAZu2uJXbUfj+59NGHk?=
 =?us-ascii?Q?9rJ52KGOQJQHzuW+oqT9XU2czXyzNg/1Q+1AEljyKvrnEduMRYQH3eyOGINa?=
 =?us-ascii?Q?+jAQSv+PgInl6TWutsWuhncx+CJIRow/UZeFt955GmCcmfvnPaZVIVn72G6J?=
 =?us-ascii?Q?Y4ORZLrGDVxJzPxXTpX4Xu6Hxd4e8S1XHP4ol+EudZrcdZsOa5/Y7461WKuf?=
 =?us-ascii?Q?xgOsWQKb40zU3P3U+/Rg9w5LAaqK0CIedtQliFECiIpQodSqSlGKAEIb++aP?=
 =?us-ascii?Q?d1/t4SYw/jBQsvU2fj17IbHQxfqEWV64/zhuYRqRyF4YE+PTilYE/61D9FJq?=
 =?us-ascii?Q?58pdGpVzpfOVwe+2+5uSbQcJNXYfpGDN/3+5q8FjIv8zDEa8meYzR11b5ahd?=
 =?us-ascii?Q?OJOhTUKlfwJgenn9YrN2VS6NeVyHuRH9vQEhRI3Uwq6zXAQ3ttaXtmbR+Vsx?=
 =?us-ascii?Q?6VDeEPhCQjL1y/oeuX/kAAA6oymWrlp6eiRSkiiZPEAhlTaqlbdACEpibXFP?=
 =?us-ascii?Q?pFSqbCof3m8w4pTYpQ2xySRqa/mqTlIw82eNAbp3DixpYzzDypq/ES0IP1JY?=
 =?us-ascii?Q?PAfS84KFT2yK3B1aZOHriD73PxVPcET4fnSbYXcn9ermn4CvfLPBzLVsRzym?=
 =?us-ascii?Q?5aAFhvB7uZYyXLMmgN6a8+WeSF9g1LmwPeyJ+hsD1droSA+X0r0RBPWS/sBa?=
 =?us-ascii?Q?3m9bk/QRo3lrb1mTkbdq+J1wTAFQ1CPGBmu9Xv9tMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OndOOf9PT5WWO5Q31sofram4lA0uEHwSjsNt/xQ2sNCU14y1StV62ddRW79W?=
 =?us-ascii?Q?ViQ05K3q4Z/KBqW2sxkYA2kj+aCObFWfrty4M62H/lnM8RdkQQlk1p4YQbT8?=
 =?us-ascii?Q?Pkptewxr35j3nlyDKXKr+hhttPatoRTy7PWytyVLAGlNKjt5DoiCauHzUJTz?=
 =?us-ascii?Q?k9Aw/gGj6XFTJDLbCd47c+auGCoemXfYe/XFMVnxYcfP2zQLQRrgZeK4Afbq?=
 =?us-ascii?Q?6w44Ob+DykDJUsExWacbahAreEM0eaoWDDZFhSiV/awzsjQf6mm32e+Etz84?=
 =?us-ascii?Q?3Nw7ihPGgE/CUtGIFdl9vAAJ+aLdiOZW7ThPUdaog4lCEkKw3qKxtCdWG/eV?=
 =?us-ascii?Q?yGCgj1NQk5Ndshpd3iRrX/+gwPR6Osj+yslrT8ggKpOj+ZVk/WBPCkGrGmDo?=
 =?us-ascii?Q?Hn2LDe7WgRGoMAden0uyQacP6NuhY9/+vPAEzegFUvojvXI8wgFTXo/E4nGT?=
 =?us-ascii?Q?g4wpxVuKOYRQ4/PHZM9JDsejnKkhbF2dffxaDMvf+eAE38vEo8PvNtlcs1f/?=
 =?us-ascii?Q?3QZlCA64Vy9lQn3x1hXII9qg4o2gsNc6IPgiz6ITq+AQh/QP6t8qQYnB6fkw?=
 =?us-ascii?Q?ypxC1h34tmV8QOtmkeyZp6CAMMApWUlMSGz/E8ygE6kx5XNfGfY//FgbgYHC?=
 =?us-ascii?Q?bULC6Kbq6EHK2EJJ82OgH3xavLtg4N5Hc4dFbWtL8B69QgzI/kiZjESh+J0J?=
 =?us-ascii?Q?baJ48a6sv/F3c/uE+A5xMnYk03YyU5hNrsdcxyWq6o4ADRyKACI71SG9dcj9?=
 =?us-ascii?Q?z/+tMPjyeykWmg0tFLP5nTxxCn+f19M99dT27dY9xdXzFBPFb3kzZXdD8mhG?=
 =?us-ascii?Q?fVlUgqOjez4s2Xe21hm1upkAQ1vm+Yx0EjTFhyimncWMDVjn3kxYHsCHI2+z?=
 =?us-ascii?Q?rnjTJoCRBx6NEd7687s/USzKKHnxji2RAoXk2dc9C38IY4XSz5O85FSOFqMN?=
 =?us-ascii?Q?XHQ1bjSMbp750kbYe5ItPDFZPMAtTRoQGBp+pEzh1KRJIuTUO1oSMf7pkoXF?=
 =?us-ascii?Q?U62E2L/feUngsF4XipF80NklMdT5ZZhKnkaLKKAAHoZe+HRW61Mn0yVS1AGw?=
 =?us-ascii?Q?D3WoExWb3JpvUTLJgCqTj7DJAS06Iq1Q3Pt4oX6H6A7e68M1WtbOw4EBsV8v?=
 =?us-ascii?Q?7qNQlKk/YhC5O9eDRy2whduYigZDXqdwlTz2l6PeVA2o2DQE68DJ9Jt+FLgw?=
 =?us-ascii?Q?WpQLiq6kxV/XbjE1im0yYKp/9BXL5MKdEQbUiu9iLOc5z17VfKBS1wX5i+gg?=
 =?us-ascii?Q?bL+cfUWCwPehNLdAP+kt8o24PQ0pnywzvgaWYGIM82WGvKlAGhKmaM6k+IEI?=
 =?us-ascii?Q?8FmDVSw5cZTmvfBlG0Hh3B24M1dR/muRzmuqblTFRnWMDpZyUwuWooIKLKwy?=
 =?us-ascii?Q?pD8chWzhSWWiqNx4Ep1Y6j1KjYS2bW1BNDdzVNYOA8kbBAIZgqE0VxjhjISY?=
 =?us-ascii?Q?2aFOM+/MyVM7HcqdBGqM7ODyfRg8BcB46Wzh8i4WnFoAjFDzIATvDHwNJ253?=
 =?us-ascii?Q?mP9mq8Bud654i2YC7DGEt1/wYkJgzawL3kAKuik+u1nbKku1q00mNn3u+JE3?=
 =?us-ascii?Q?TlJ+U6sXQlFUD1NBNOkOQykGvGe7Z8VvAhsFILBkOBhmfM4QMhjdI0ykCTnw?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3254dd-9b72-434b-16d2-08dc60b7f37c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 21:30:36.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBnqaDDMFtEj1pYtEEqn+GpCm0PG5VgjTU5pFsHg/Wz+7CGVJ1Pp1JBqtwkXlCqBYYaHPsuD27Zww1RIxHXdMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

Some device drivers support devices that enable them to annotate whether a
Rx skb refers to a packet that was processed by the MACsec offloading
functionality of the device. Logic in the Rx handling for MACsec offload
does not utilize this information to preemptively avoid forwarding to the
macsec netdev currently. Because of this, things like multicast messages or
unicast messages with an unmatched destination address such as ARP requests
are forwarded to the macsec netdev whether the message received was MACsec
encrypted or not. The goal of this patch series is to improve the Rx
handling for MACsec offload for devices capable of annotating skbs received
that were decrypted by the NIC offload for MACsec.

Here is a summary of the issue that occurs with the existing logic today.

    * The current design of the MACsec offload handling path tries to use
      "best guess" mechanisms for determining whether a packet associated
      with the currently handled skb in the datapath was processed via HW
      offload
    * The best guess mechanism uses the following heuristic logic (in order of
      precedence)
      - Check if header destination MAC address matches MACsec netdev MAC
        address -> forward to MACsec port
      - Check if packet is multicast traffic -> forward to MACsec port
      - MACsec security channel was able to be looked up from skb offload
        context (mlx5 only) -> forward to MACsec port
    * Problem: plaintext traffic can potentially solicit a MACsec encrypted
      response from the offload device
      - Core aspect of MACsec is that it identifies unauthorized LAN connections
        and excludes them from communication
        + This behavior can be seen when not enabling offload for MACsec
      - The offload behavior violates this principle in MACsec

I believe this behavior is a security bug since applications utilizing
MACsec could be exploited using this behavior, and the correct way to
resolve this is by having the hardware correctly indicate whether MACsec
offload occurred for the packet or not. In the patches in this series, I
leave a warning for when the problematic path occurs because I cannot
figure out a secure way to fix the security issue that applies to the core
MACsec offload handling in the Rx path without breaking MACsec offload for
other vendors.

Shown at the bottom is an example use case where plaintext traffic sent to
a physical port of a NIC configured for MACsec offload is unable to be
handled correctly by the software stack when the NIC provides awareness to
the kernel about whether the received packet is MACsec traffic or not. In
this specific example, plaintext ARP requests are being responded with
MACsec encrypted ARP replies (which leads to routing information being
unable to be built for the requester).

    Side 1

      ip link del macsec0
      ip address flush mlx5_1
      ip address add 1.1.1.1/24 dev mlx5_1
      ip link set dev mlx5_1 up
      ip link add link mlx5_1 macsec0 type macsec sci 1 encrypt on
      ip link set dev macsec0 address 00:11:22:33:44:66
      ip macsec offload macsec0 mac
      ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
      ip macsec add macsec0 rx sci 2 on
      ip macsec add macsec0 rx sci 2 sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
      ip address flush macsec0
      ip address add 2.2.2.1/24 dev macsec0
      ip link set dev macsec0 up

      # macsec0 enters promiscuous mode.
      # This enables all traffic received on macsec_vlan to be processed by
      # the macsec offload rx datapath. This however means that traffic
      # meant to be received by mlx5_1 will be incorrectly steered to
      # macsec0 as well.

      ip link add link macsec0 name macsec_vlan type vlan id 1
      ip link set dev macsec_vlan address 00:11:22:33:44:88
      ip address flush macsec_vlan
      ip address add 3.3.3.1/24 dev macsec_vlan
      ip link set dev macsec_vlan up

    Side 2

      ip link del macsec0
      ip address flush mlx5_1
      ip address add 1.1.1.2/24 dev mlx5_1
      ip link set dev mlx5_1 up
      ip link add link mlx5_1 macsec0 type macsec sci 2 encrypt on
      ip link set dev macsec0 address 00:11:22:33:44:77
      ip macsec offload macsec0 mac
      ip macsec add macsec0 tx sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
      ip macsec add macsec0 rx sci 1 on
      ip macsec add macsec0 rx sci 1 sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
      ip address flush macsec0
      ip address add 2.2.2.2/24 dev macsec0
      ip link set dev macsec0 up

      # macsec0 enters promiscuous mode.
      # This enables all traffic received on macsec_vlan to be processed by
      # the macsec offload rx datapath. This however means that traffic
      # meant to be received by mlx5_1 will be incorrectly steered to
      # macsec0 as well.

      ip link add link macsec0 name macsec_vlan type vlan id 1
      ip link set dev macsec_vlan address 00:11:22:33:44:99
      ip address flush macsec_vlan
      ip address add 3.3.3.2/24 dev macsec_vlan
      ip link set dev macsec_vlan up

    Side 1

      ping -I mlx5_1 1.1.1.2
      PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
      From 1.1.1.1 icmp_seq=1 Destination Host Unreachable
      ping: sendmsg: No route to host
      From 1.1.1.1 icmp_seq=2 Destination Host Unreachable
      From 1.1.1.1 icmp_seq=3 Destination Host Unreachable

Changes:

  v1->v2:
    * Fixed series subject to detail the issue being fixed
    * Removed strange characters from cover letter
    * Added comment in example that illustrates the impact involving
      promiscuous mode
    * Added patch for generalizing packet type detection
    * Added Fixes: tags and targeting net
    * Removed pointless warning in the heuristic Rx path for macsec offload
    * Applied small refactor in Rx path offload to minimize scope of rx_sc
      local variable

Link: https://github.com/Binary-Eater/macsec-rx-offload/blob/trunk/MACsec_violation_in_core_stack_offload_rx_handling.pdf
Link: https://lore.kernel.org/netdev/20240419011740.333714-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/netdev/87r0l25y1c.fsf@nvidia.com/
Link: https://lore.kernel.org/netdev/20231116182900.46052-1-rrameshbabu@nvidia.com/
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
Rahul Rameshbabu (4):
  macsec: Enable devices to advertise whether they update sk_buff md_dst
    during offloads
  ethernet: Add helper for assigning packet type when dest address does
    not match device address
  macsec: Detect if Rx skb is macsec-related for offloading devices that
    update md_dst
  net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for
    MACsec

 .../mellanox/mlx5/core/en_accel/macsec.c      |  1 +
 drivers/net/macsec.c                          | 46 +++++++++++++++----
 include/linux/etherdevice.h                   | 24 ++++++++++
 include/net/macsec.h                          |  2 +
 net/ethernet/eth.c                            | 12 +----
 5 files changed, 64 insertions(+), 21 deletions(-)

-- 
2.42.0


