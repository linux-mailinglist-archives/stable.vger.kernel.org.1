Return-Path: <stable+bounces-40750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2868AF65F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C521C22670
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8C13FD71;
	Tue, 23 Apr 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZ6mF+F1"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3F13E895;
	Tue, 23 Apr 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896011; cv=fail; b=lwB6qKwnO7t3IBycjN81JEvKMHSfV+9GQfUlK60ha70uCYRVEWB4nUjUV6pngxXsJVHZrXuQO3hqOYjFq1llPy4ignK8M8y5ZNTHIiGUs8Ve2vKgrYY5cKMHS0WIH10JVgjOa9gCAxfeYk1bW+wtgj1nyw4xm4NfOJ47kKQH2I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896011; c=relaxed/simple;
	bh=bzJcpOSnPrkI0iX4BYfnoEr2eBD/rbPMrScMvu/NdT4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WyyLF+s1vlQMAd0EtgwyJjIyl1+SvBIyloT7xB0CUapN5F5zlebACkmNjSxsIZxQ3NzrAfdLctvT94nfccRA4uRmrQTOUkvdv5ujZby//J+vVee4npvhr4x2QdATy/iRGh/xjeJJvTzlPm2AcKbQddOze5ni0jI+IfA0AbGGcMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PZ6mF+F1; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2X/PY9M1kYC40nLJGXwL0IVfT2yQdSkEISTqFkDVwEL+9yPDJkokamxplIn/PMX6t0EKvNCwLeYk7etUTE7n5YMjLUTMenvRY6imzPq96y7uibgXT7hAKuHDDV8n11p5VHc4voskbyCTG1QrMy4YjfDbsu/mt93MKwUzXoCAB/K7Y1iWLUis/CPBppEJStKizMlPyM8Kpf7o6+OyeKFkyanXnMCt3cb33rJN7NWXQBciwnoGKAYEr+0L3soVF8AiJbO8rhvyyXiOdxWZ8nDaUqa5JjRETP1NV6P6lxyicGkIW11o6wTuvpNobC+eBvqIzMLqw3D5bDsvjfVljTqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aN+fgBIB9Ps3+rOKkrTw1kFIjWYXrP4hqxCPgGchg4=;
 b=YyyqaAFIM2Ih3X4n/iwxzKACjweHGUiHQFMlbzVJ6RSEu0hmP7BkfYz1vxlvRzowUEpblJ6ooNSwZcth03PxiC8x0Lgkmtqu8T5o/qJHrUY4KNM0TfqNf0DulBIvobiHIqObIorf0WFX1EMxp45zH0FHuar8Hn2XxU1yhsIXCDhng1C+okxHaOSdS9rL2NohlE3wUUH3kI3bZu5Nx8ucSRMkSw8q8oR3+XyzSNnweYmVq+Q96ui51GqBW4CmSe5IpB08hCTyOJd4LdcsjpVWL+ryDpMyawFEbEtuUWvoj892WGv7ftEqp0UqZlGVGUYIJVAWl9bzU9hCLWQg1jH+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aN+fgBIB9Ps3+rOKkrTw1kFIjWYXrP4hqxCPgGchg4=;
 b=PZ6mF+F11TKOyNlbLfB3eH7ngAxKa+A1ZTEnEBOD0CaiXaIPZycWsNgI45oH2HfSbTFoVNJJfbwKoyomGuvz3jhJ21o+GPFQ4IsZEhpr9KlqvCZSUleZGRlCvcPxMAtKMynW8Yc+HzSo1j/nuurQqoTLMiliioff6/qLo1tVToH1YB3h+BLNTilT+2hauDM/qeIh1ah1Iry/wNxeyaOSNlBdrmjSdAr4QltjBTTbCJihDkO4APWevXVWkqW39eOzb1F7N8UmzRYbpTl1OsO3EmltfXa39iZMCiGMZ8PwhdDl1Wh9V8s9l/tJu4GdC5BYN1TNzl1vpHq7sD8OpCJV1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:13:24 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:13:24 +0000
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
Subject: [PATCH net v3 0/4] Fix isolation of broadcast traffic and unmatched unicast traffic with MACsec offload
Date: Tue, 23 Apr 2024 11:13:01 -0700
Message-ID: <20240423181319.115860-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b3c4af-49fa-4b56-bebe-08dc63c110fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x82GgUZlb4vYjCMwCJKmLH2JRbvz7fF9dlUbzGM4kGBshl/P28yX15e5fhp5?=
 =?us-ascii?Q?Ro0j7cooqUdQlw8i03/aTQC+/akTO4fvZfEuBIZnzEBatr5sjPLGFumBniix?=
 =?us-ascii?Q?rAIYnm5PiKmiDWH7/O5qIemeDjYUv4r2al2vV+eCO0eBWqqmA5HSq7kMqhpC?=
 =?us-ascii?Q?ApgMj6jkBZMQXBVg40/8HuXRO9Ww4XWlvz69mS4Hhxty6k01gP8PQHe2oXv1?=
 =?us-ascii?Q?qnyicGfPUBgAetGajmSiUx6zyiziHUfiqZgbAdcKSJ7Z1RA8y4TcJGuSwurs?=
 =?us-ascii?Q?Zn1ySN6ia0JpjwAO9T1j+SsP08f+cqYdY6fSuh50q9sc9+ebcf6l8Cwds0PL?=
 =?us-ascii?Q?2lGsiFvQobWScNk8z02tkEQNMU6LEBavMKSFdNIfPKr4mBd7TgtGsFwx5soI?=
 =?us-ascii?Q?TFfqUVfRKE8GzchJxfGLu/NrtdQKq19qgeVmg8eQskawOa/6azxBtnGoq8nC?=
 =?us-ascii?Q?BQnnM6/QwRHju5QBPvG7/2xEIloyMhslvXwXgLhyIgnO+CMYtavvxIen++zO?=
 =?us-ascii?Q?MGybXxXTo098GSgsibXbcPAOiWTyhf9idslnTYQR3OJ4/7E3nUyVC97Tzgj8?=
 =?us-ascii?Q?bAapu+R51FpneApRMVuMb9neA4NhDLkozx1l1xA0Sa0Rdff1i9YM6ffBJ+/x?=
 =?us-ascii?Q?zG1hJIsTkVaMDWTnP7aDpKHYHyLoK9uLRklI5/a0ak1S9ElO6W0eYh1VNptf?=
 =?us-ascii?Q?0eNqwOpDYpaNVKGHFY3X+GMSZB/OfY1bkb1e2PI/tkV4IGwAAa6QzTC6CleM?=
 =?us-ascii?Q?4mnXl4bLDdk9/gbqxd7iQBvVyw/tzT5sH/2dokAC1Ogx2z4H9xplPlX7D92m?=
 =?us-ascii?Q?NnLXtkfijvprBeXBsekXlzQNWkVDX/b2nfQNod9egjd5P6PQ/V7Vb9Y2o1c8?=
 =?us-ascii?Q?eiRCzhX1pKZwjoNHhCArrqMEuSh9xUgrNqUdRQsPIZUU/y3EJZ2TW4XvNhLi?=
 =?us-ascii?Q?Xp6UXIlKagOmLMlywsIEH2iByXYng1U+Epe4E06qKDWwIXr55/BGLCrqSB6R?=
 =?us-ascii?Q?eAexa5DwXTDuzrjLdYjnhJxjLVCJgWek+j+k7q1yx0lL2slO99VrQiP1BUnv?=
 =?us-ascii?Q?TlcMTE+gm7hSvt5WzEvXUmiqA8lE3y0CuiWmg4t0hjdCukzGpsoCP7ICZBwQ?=
 =?us-ascii?Q?i4TI2juvDjXln6RKZDGOwFHn2rJEvjg9U/hAXxJOO8oQwhRyRc+vdGCtM7bm?=
 =?us-ascii?Q?LSwQ57/MhTYeP5BfBLnxwaTHrlljvqVwrqx/TSWrnjZB/UCrqBMdivLndeXH?=
 =?us-ascii?Q?H78WfzmTcl8iiTMrkWS4A58dqXbuFhyTBIEpOiYSIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3iXY6nOLcY2d9VxobIt9Gm/YAYD2Oj9oYyx/bacj0U7+4Gx40PWfn5vHGgol?=
 =?us-ascii?Q?7XImp6iFJqTa5CRHN4iIkMrFlKgvBbki5lgw6pNqu/yt4qXEbnGndCgSLCfo?=
 =?us-ascii?Q?cDCCsyiWIiIX/QH/GLxiRDArHaVpUXs9lVSbh57X75rvDLvkRPIkYsImVqvw?=
 =?us-ascii?Q?6NYheIj3g4bDHqPFaUll795ZVVMYR1Z529zASDWuRdaeNTU3SJFwHlKhmIPy?=
 =?us-ascii?Q?hGaxZeRIWgZjF5DrerqhVrnvawbGsKPh47x//W+DHOATrv6m2ZdLW7cTB6yX?=
 =?us-ascii?Q?k1BxuxuG635sSnF/vWO6iM+bh+SIWnTEypSUuRkq1HcGqmCCLek0aGLny8Qh?=
 =?us-ascii?Q?dS5CtfAGGg0pUndyR8MMafoAmzi/rsMBbmuknvfunJ6WhYefNKVuD96KtfAU?=
 =?us-ascii?Q?b3E+CtyZAWrl8CFvw6BCktsE1DfhUIHW2t3SsP2sss0H28Xoodovf1Hfn+U3?=
 =?us-ascii?Q?NkexYB7ylYjlMYwlcSsLBmCpZ4MBEYEqvmYdIlwcJXEvvBJcEX+YNpvNGWHH?=
 =?us-ascii?Q?kkqV++p22bG5PebMJKdKLC/d2oQiQ9T0xu1/xTQMNel39+iKd0b+UxKShfM9?=
 =?us-ascii?Q?LLjGWvHjoBUQqtqweQ4I9pXBpBPIiiI5CNYHy17MpUBNpHC/rGwvl3MoB0PC?=
 =?us-ascii?Q?Bw6O96/cIQDvJ9E7nGalf/E47FvQAqIqXC40I5IAlgo57lSJU/mcaMZX35kl?=
 =?us-ascii?Q?DvnZXgO1s6pseTTvCtf4ImMiRzVsKwECWqKFeI42theIuk2gx+vK7+zGggUX?=
 =?us-ascii?Q?Vt+V/zW+mp9UZlT0Yc9AOlaJ/sh/0wPPVwCI1nHZw80FvF6A9viuI91K/dyx?=
 =?us-ascii?Q?aRXAbAKSDYEHJ008Zhlql0Q/N3pGepa+WuET494COh8WlSzmohZB2cBwQrSe?=
 =?us-ascii?Q?rOxXqREz2ZI0b3U3yLjL3aaSQhNgwH2cvIJZW1hsWgTMt7rgyaG15DU/x6py?=
 =?us-ascii?Q?fADiGHN7JTaIiODZC8RutVykou2QH6JNNerTPAFX1AKoq6Q+VaJWnxFXGNeK?=
 =?us-ascii?Q?VZrRjV4M8Tz9uWQK9hQqVQxG0nWJuNqGDeyTuPGUcLY/C2+OFiY2iCCzBLib?=
 =?us-ascii?Q?Z6H8qfP3J5d2lC9BtsxMfRj7psjwjCQGrcX/LjIlyzQr3Fgd55bDL63L4YHn?=
 =?us-ascii?Q?3zojLg3bLuRBIf3eDhm6wHT/EzKEU6HjYRXk9HU94nGm7MPP+lGmW6Qj35JB?=
 =?us-ascii?Q?df1VeJdA2gaub+jxSj8ywMQgC/jhLXc8TLoeKiy9zL16jSsan5l5epgyRM3S?=
 =?us-ascii?Q?gvAJpcU/w7cadONgq0dI/LPIC7cxO5AZ2G4LBJBB+M4m/m2zZDsLk+0SjX1P?=
 =?us-ascii?Q?d9VQdv7bo+dwpI7fOehn3tRXJ77Po/DGtxOkTPn8ODtXJ+UBPRKNu9E9hsHg?=
 =?us-ascii?Q?UNzftPaRIuAB0zI+nATsSOSqA9bfwFu9gok3ZOuU0/c+ns3ZUq+PVtouDXWx?=
 =?us-ascii?Q?N1Fl+zjQxj+iTHtEL0SOHC93WGTHVmKM52gcXmHUsN6jfZHAKEXv47YbWLiv?=
 =?us-ascii?Q?73tKjH+u/OEjqftlD9QX4tShWJS1si8cjCUGlBp6i6C1abLFWav9x1y9zXJs?=
 =?us-ascii?Q?BueRwQ7hvQfECpdtE2O5d7ORNI1s/HGqCi2GCC4qqNra9JEWEUOryV0dVf2z?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b3c4af-49fa-4b56-bebe-08dc63c110fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:13:24.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WtMaERakG2yxMXe0H8xv6RQP2zC3l6PuwYuh7P1IEXPQgGmKIgYdPoXl+SYUKVa5MSnV2Nu699TvMJQakrlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

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

  v2->v3:
    * Made dev paramater const for eth_skb_pkt_type helper as suggested by Sabrina
      Dubroca <sd@queasysnail.net>
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
Link: https://lore.kernel.org/netdev/20240419213033.400467-5-rrameshbabu@nvidia.com/
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
 include/linux/etherdevice.h                   | 25 ++++++++++
 include/net/macsec.h                          |  2 +
 net/ethernet/eth.c                            | 12 +----
 5 files changed, 65 insertions(+), 21 deletions(-)

-- 
2.42.0


