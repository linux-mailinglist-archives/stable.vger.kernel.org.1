Return-Path: <stable+bounces-161649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D3FB01B8F
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5C13B00C3
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CEF28C02C;
	Fri, 11 Jul 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="GrDlkGDq"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B211E5729;
	Fri, 11 Jul 2025 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235926; cv=fail; b=EOlqLOWeef2Je4U/0jAksVsqSon/dRK6yYPlw/Ola/WzrqHHw7OcWR/A+LPkX9Nzy3Wg6d5K/n10bnz75Gxqw6tL+rW8jTNV4k1xXT3C9LAAc6CVSing/HedMmXqZ/n4tw8kLQH6l6Gt9iT6+K5PPynAODVmyTau//pyC7fPMaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235926; c=relaxed/simple;
	bh=eu+/VXj8EEj6fDefO7UeEIL/X0DwT4lTVMp6TCSIFf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViJk6M9xnuVNwn/GI9IHmZk+I44CO99e94cwWVi/GikJAnC1I3rgZSL857yqXYNcf+TekMWtf79vBzeOepCfe0X9rHeTFOHYeUotNPJkfy+XwPiL4VZRmOA51QZ8obA/aWV4n8vRddJRhQM/xv4IhNYWrsovkvvlHkgQ5mymsKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=GrDlkGDq; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGQWgsCIQfPaiReZDWwlt9ibM6autw6QOSa/PiwfIhQ/cg2eRClcxWT2pUU2suunjfuobO4t0k4+89OHzRYeobqtYdF1wsWHOWQfigFOU8Tg4dVLxGHzpZBtU4SNXw9NqLoVPHeUnHgsXDzwL5f/5jNXv7gH9yY2xc1snQhZqllBRh2q+GrXk0XggBgmE+OkmBhb8OLFbI8pqRZIGs7hCunXgOecQRkaJ2N5a5U1kDcBmSZbEdiVH0CpgzySO4ON0Vv+sW+GwNZXRdBbCQ3KstfIUH0tYZNirRd+TtJir8NhFt3FNrBGKJ8qn8n2dUlKPvZwraCjwJHKBY/OAplzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu+/VXj8EEj6fDefO7UeEIL/X0DwT4lTVMp6TCSIFf8=;
 b=P6lJeuNT25y0FMcVEB/VjuGTshAh62ZjrFEAhCYQLBEJif0ZUaE1zAVFyCzYoRrBL15BbhKv8kQyVTjIRIyBg3ww4tn56SRKqN6Hej0xVP6tCBZNW57NzpJ+evh6jMC5QjBtSmoVfYzPxK3MehPKDwf4uPd/iAe/c/xGVzgSOm9IyDvdGmyDPHiyxlUjxDE1q/WoHNKk9mXb43V9V2AntjEKixow7M9xm6VQCsgH96n9kmorjOzO423Y5LbEk6zSiQUPfWjMpRRALKngXaOhBKRCZV61T+f/hSntjHeAmJnSRUu2OJg4s+/UkSgVTQxoDYWvVV0vNNwekxDTMjDaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=innosonix.de smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu+/VXj8EEj6fDefO7UeEIL/X0DwT4lTVMp6TCSIFf8=;
 b=GrDlkGDq0WDS4kaOZPOk7it+CptzrK03RRzpv1TOXUwdAgmEwEcbqtVNqEnizX77ND1PtifMn33peJr2Bamn+rzczp92exBOR+0OIMOmhCywmsbBnw8cWSKgHhMkAqm7mc/SfN/brHmGMJ4XnkbMo8ByTVDhfTb0VPDjMEHNeLQ=
Received: from DUZPR01CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::19) by AM0PR03MB6241.eurprd03.prod.outlook.com
 (2603:10a6:20b:156::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 12:11:59 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::86) by DUZPR01CA0096.outlook.office365.com
 (2603:10a6:10:4bb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 12:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 12:11:58 +0000
Received: from n9w6sw14.localnet (192.168.54.39) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 14:11:57 +0200
From: Christian Eggers <ceggers@arri.de>
To: Steffen =?ISO-8859-1?Q?B=E4tz?= <steffen@innosonix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: Srinivas Kandagatla <srini@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmem: imx: Swap only the first 6 bytes of the MAC address
Date: Fri, 11 Jul 2025 14:11:57 +0200
Message-ID: <2192511.9o76ZdvQCi@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAOMZO5BNgGao-+B_K8+7juBXTHVKr72NCRRk5NMpr2ew=t0+aQ@mail.gmail.com>
References: <20250711120110.12885-1-ceggers@arri.de>
 <20250711120110.12885-3-ceggers@arri.de>
 <CAOMZO5BNgGao-+B_K8+7juBXTHVKr72NCRRk5NMpr2ew=t0+aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|AM0PR03MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: d87f4ce2-ce9e-4bbb-b738-08ddc07422a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V09pR3p1cXozQWRmNkVmTmtyT1FTcExvdzh3cXpiaXpZd0hOeStoYmw3T2NZ?=
 =?utf-8?B?ZkZiZVBVUXFkK2E5ZzJsQTZweUVKZjNSK3ZjdnQvcDhZbDhyWFBmNWFsT1ZJ?=
 =?utf-8?B?cnBlMllYOFpTQnVIRmFHTUFvd2Q4cTZnanh0RjZpUDJWd1p6TUNNSWU3Y08z?=
 =?utf-8?B?QzQyQnJGS2s1QzcyaGJaRmF0b29wYnZtMU9ydFRMN3BML0VsMFhCWDNNZzVB?=
 =?utf-8?B?SHhLa3dhaEl4dXlsek1DczVMZE5SQ2FYNXpUdlpKWGFvVFB5RWxoaFFqWSs5?=
 =?utf-8?B?WkJwcnJBaHRPSlBYUUsxUTZrbUtQZjhNSDUrTGxqNWNVSTIxamNpZjhCamFy?=
 =?utf-8?B?enhFeXBoS2lhU1lxa0hqVmJmR1loMW4rT3FoRWNNVXVSZnpEeDZOUzBLZW90?=
 =?utf-8?B?SS8zMmJWWFdWTHBubk1COUFxRFlWUnMwUXlHN012QzRGZ2pIbUN6aithUUI3?=
 =?utf-8?B?ZGJ2N3UrUnNaMDMwc0pOSXpBTUVJOU1sbkxGclNKbGg0OXZFU3BNTVRZN1k3?=
 =?utf-8?B?S3FSRFlJSG51NEt2ZTJEd3JiZmhpVXp0SlAwdi9KaGZKZDdNZFhBaWErSUZo?=
 =?utf-8?B?ZVV6WU5EVUNqR1kveGhwazN0ODc5M0I1SFIzT1hDc3lHU2plMEdBTTJRaGpO?=
 =?utf-8?B?QWxFc2hVd3FGb1BqMGxsclI2dC96RTZUYTAvL3NJYXNpUEh5NFJaZ0hUTWhi?=
 =?utf-8?B?U1Z5WHJkRFpDZitEQmZlbGx5TkswamNseFFEUEFUc2JiOWp0Y3V6NVFlYkxj?=
 =?utf-8?B?dnJlUklEOW5zT09FSWJlOFhJTGxtOXVvRXl0T2lFUjA1Mkg3QU1RWDdqZVJJ?=
 =?utf-8?B?WlllaVJ5amlQS2JnMzhjRzlEUUoyc3lOdEUvSkY5R29wSW0vNnNTbXFwa3hK?=
 =?utf-8?B?RXRSV1N3UC9yWnNHcVZENW1Qc3NsY0phNDlhRDNuLy9qYyszLzhGaXZxQXlx?=
 =?utf-8?B?eGYrZjBtM0JJOGMyUjhWY3BDbWlnLzY2dDMvOHBod2VIc0F3OU1DdDA1L0ZJ?=
 =?utf-8?B?NWpqaEI1T2NYdlk4VHVQOExhYnRmaTAvY3ZUMnlFM2RGNXo5Wi9INFhyZWE3?=
 =?utf-8?B?WlpaWktNV3RUWGxac3VBRllad2k0amNQYWo5SXZ5TGJyUHBXRGlUOHRnMUVY?=
 =?utf-8?B?T3VpU2R5dWIwV1IvaFg1MmtXdmNKSklLc2FqMXpGMnpIQ2tRN2NSRy9VZEFx?=
 =?utf-8?B?MDVEYXJHZVpWV0ZVV2szVkZjNVFnNHFlSnQ4VjQyL1NDVE84YkwvMDB1Qy83?=
 =?utf-8?B?Rmp1aWlkQUxsZmZYbnZLUDlFcncxOStrQ0hlejdTMiszeUJnT0cvWDQrc296?=
 =?utf-8?B?dERMWjNyMmd4RVQ3Q2hZNjdHaXhZRUVPa0g1RE9FdnhTZkh6M2hwc1BLRVc4?=
 =?utf-8?B?WG1BeC9QRHR6allZdStNOWF4a2cyQXoxbExTdFdnbkRjTlViMFV1RnlJeUNv?=
 =?utf-8?B?Nk9JVFA4eHMwVW1wNmUyS2w4VjNsUEFISm1Dblk2dEJVL1YvQTNWcjhYcm1K?=
 =?utf-8?B?Vmp2TXF1QWZ2WG9pY1JqV3puTTNHY0RUY1dyVVFHOFY1ZUxLZy9IdmMvQlN3?=
 =?utf-8?B?TFFMaGloV3pqOFpKRHE3bk5tL2tpWlY4YzdvZG9UU1NXYTRYWDJiS2p1OFIv?=
 =?utf-8?B?OUxsVEM1ZFZub1psdTI3WWQ1RTBTSjRVZnpwSTgxVFgzZFJKVDFpY1dMUWZx?=
 =?utf-8?B?dHptVk5lUlNVTVVGQ0lqdUZzeTYzRVdZaDNMWmtUd3dvT3YzV0tRQ3lzdm5K?=
 =?utf-8?B?ckduTWlNUHFFQnBUaHRacjhscXBHdy9sQzhnN0RiOUt2Q1dPRlZJL2hMV1Vl?=
 =?utf-8?B?NXFhYXJ1MThDcEZTZGNjQlR6elJnZ0k0VFpEWW8vVTd6VjI5N2Z0SHNjUzdD?=
 =?utf-8?B?dDdzbkRJSEl0ODlzd1p0a2hvMDBUa2djeWVyclJGbzB3Mm9oRUpLSS9pTm1V?=
 =?utf-8?B?WStmNHFtUU1uNG11YlNwZ0Vhcm81Vmg0d1VMZm45UkJRcW9xYW9VdVhsM3Yx?=
 =?utf-8?B?dzNEaGx2QmtUMGQ3Vjd5eGtmVk5MeDVGQzRHRGhrMkZHTUxBSEVUWnNYbGNv?=
 =?utf-8?Q?JtvEXu?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:11:58.5843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87f4ce2-ce9e-4bbb-b738-08ddc07422a6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6241

Hi Fabio, hi Steffen,

On Friday, 11 July 2025, 14:05:16 CEST, Fabio Estevam wrote:
> Hi Christian,
>=20
> On Fri, Jul 11, 2025 at 9:01=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > Since commit 55d4980ce55b ("nvmem: core: support specifying both: cell
> > raw data & post read lengths"), the aligned length (e.g. '8' instead of
> > '6') is passed to the read_post_process callback. This causes that the 2
> > bytes following the MAC address in the ocotp are swapped to the
> > beginning of the address. As a result, an invalid MAC address is
> > returned and to make it even worse, this address can be equal on boards
> > with the same OUI vendor prefix.
> >
> > Fixes: 55d4980ce55b ("nvmem: core: support specifying both: cell raw da=
ta & post read lengths")
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > Cc: stable@vger.kernel.org
> > ---
> > Tested on i.MX6ULL, but I assume that this is also required for.
> > imx-ocotp-ele.c (i.MX93).
>=20
> Steffen has recently sent a similar fix:
>=20
> https://lore.kernel.org/linux-arm-kernel/20250708101206.70793-1-steffen@i=
nnosonix.de/
>=20
> Does this work for you?
your patch does obviously the same as mine. So the answer is 'yes'

regards,
Christian





