Return-Path: <stable+bounces-179305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A045FB53B67
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D83E5A83DA
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A892336CC76;
	Thu, 11 Sep 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kQlI26P1";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="kQlI26P1"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022098.outbound.protection.outlook.com [52.101.66.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE736C080;
	Thu, 11 Sep 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.98
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615333; cv=fail; b=obZqbv+X/BqxR0DOJA/7JHBdMebDm6zBuD5ns1OOvxHu5R8wiiI0vavDqqx7fdVVCbMb1ZzYJR/g50pi0zPWypQI/TMsSJ0L4wBm5IhvYWI2smQ1QPqj4pSU3bcczCyHxlfiL13ymoz7HGY5/yGUpvqsv+sN3hHq1iUxIDHR3cA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615333; c=relaxed/simple;
	bh=ChDSZAVKq2KHh7R9y5OO6XY3m72Onuu8UTJW0SgPfF4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NsD5tj37P2buUPjXLfSGW9T1aUAW0wqYp7hf+EUPUGHGgVXxFfReSLPzMSbj97558Epu1O+bM+GObpHxRDJlcOqWnic9RLSjxZ6wVdd4Y+xv/Bny4xTkgNzyoi0YS5hEkeyq/6KbEQaV8+KW6LKjPYNmklKWtrSIAeNYDLe4xv8=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kQlI26P1; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=kQlI26P1; arc=fail smtp.client-ip=52.101.66.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hq2etmVoNqHh9ka3rtWahIXyiJiVHmUFHjKx+AajOxwnUAmjv1cRtWMsFBGVx0pIhMp8TfwQNXsGCFXTn/N64tfb4a6Ol0AS40paXmfCrqchPv/+3x2rgbi+VjecB84Lywo44GsweHf0yKw3jT/FEOS4J2BH7v45RAZI4LLLzgXP05A8vpiqwOa0123bKVWgOG8WohvmvAlJcS60r9DClZynsnvlMB1LIKida+Y0P8UCbzUpog0cRSD9ReGnDWM7wUPMg1zd07xh3nE7bDdCWgRHWw9Dz9Vfyitw4KT1CwxHFGnLP68P2fMeLPmqQukzdwM4jyFrofPSHIXLTioNuA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/EtxG9Bd6E5lMT5KoVshpp1EgNSx21D1psZmn4BXd4=;
 b=dg6NLcjZganUMC6szmNMqMG9KGF3UBj3M1mDPlcZIYJhdIPGFc1fR68YAEFbVcMCWAyYJn8JzGW0JuQg5nyXJl4SUDVFB8kEBLULmnVfbhWMmO8+ykgCN2yv/rfP1vx8AX1pvW1AOA1lTtvMh2gWjEgdsBmmlKGUzHsL8m2klFw+N6ZvUxgW2j/5OeFFW8WPFXnGOVrIv1kBOcb2599MeK8ufsVTyAFmFvweqLEcWAtmfo9evabmTf4uPkip/oDEnGeigXteWWTH2J3Pa4P5dgpSRai93D+Aev+Qb4cNFeEzPja8BUHa/DGxN+pQfkxGhD6ebVSoL1NTfNshNSajsA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/EtxG9Bd6E5lMT5KoVshpp1EgNSx21D1psZmn4BXd4=;
 b=kQlI26P1hEz43tK6D4VgA0tJzGCK9kXbEhsl1tJvsg+Be+DPvZkIIsdOueTDyB/LeCBKDgFmX3T5qGaeZIS8kha28AjSw/C+kldqj21m11ZCcZWBsi3A3XHwLUT7MEXzv/QJWfKRU/QPDZ+yPUeyjisu+QyIsG5XjaVhM15z+Z4=
Received: from DUZPR01CA0256.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::16) by GV4PR04MB11731.eurprd04.prod.outlook.com
 (2603:10a6:150:2db::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Thu, 11 Sep
 2025 18:28:40 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::3) by DUZPR01CA0256.outlook.office365.com
 (2603:10a6:10:4b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Thu,
 11 Sep 2025 18:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 18:28:40 +0000
Received: from emails-1836632-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 386727FFC6;
	Thu, 11 Sep 2025 18:28:40 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757615320; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=V/EtxG9Bd6E5lMT5KoVshpp1EgNSx21D1psZmn4BXd4=;
 b=Cj7UnbFyocciBOpEOSQcD+hepCENLu5cCdOsvYUgvYnLNDXpBpVwD/pSX005kV394LM4s
 H2t3m7i7okvmFeWq/Gtg68t37Q9yZb5lLweGyR8x2R2Z2MrcOChAca5IHDOXZatfF6ZAK5z
 zUdTLuuPeNOuitWTJSwPBS0Tfms8t9I=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757615320;
 b=FDs8WudkPWcP87sBHLYIgj5zwoRHy68d3+N6CJGMgOEbPR7hAkfa73e0amcJmNc/YADId
 GKkrJ4MAJHur6Z0HHbahulVPwoqIR5UvVlIBudxq9JuBbjf4ER3BC19Za8cJ1UW4B0BFN5h
 7nzPQzmjS5i6rjzMHuGhhwWaQcUkAk0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q72242WbLBSvcNBZGRdjKSkJn9g1M+Mp86jq+UEeEk8MTjmb2lvu4KE7XXsiA3y8CuoM/g9xsg5d9Yn2bP+G/2vVBxQGUj4b40EiBvF1ZPu5L11CELmk9vTvVCsxwL8sYrk3T2ZqBoJJejtg03lAaUX/aA1cfM5BHK286tuD6E5oJZB/I9l0XAgTQb26+PaWPqUcliRGDYoXC3MbK/iHG1B2LZih1Y6jIAC0+e2mGJLTit2fMYfn1zJbuF3hj/XcX+2O1TS5q3lfjUsXNAq2rNnbTpofxWUzPjTdtDFkFsmWFzCWNeqe6WC4yG6Bi8lngdMbeVt6fUmdaeHJbJCC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/EtxG9Bd6E5lMT5KoVshpp1EgNSx21D1psZmn4BXd4=;
 b=qQ42lbApytF+S+ynkobZTkhIJx7DBtqKRh62n14I7EOwy4vjZemYB5wAZqmAPEQlDZmm+KI2J+qrFvgFqfucay6c+R0FOp7ICEUAVRqjYM0edrHw8Kd3RUCAwH2IvfnbaHBZcn4UTlR8KXiY6ySIfQ7jGX+0/G2K+SuPLVgQODriTfJCqp87DVJlsh5rUvv7WtpeHDRpwCtYj22xdPwHfiZbewjleHU4BhsgzPWhsy//Q+et13TZ9vN0DVKxgiklFi/t75cmeF5RkDMfvwMURGDKdLASg3DHWT2/WzU5Yirkj9sgHE0/qGtHNoiHAHSxT6w3ovPS7fm56xG3Qo4sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/EtxG9Bd6E5lMT5KoVshpp1EgNSx21D1psZmn4BXd4=;
 b=kQlI26P1hEz43tK6D4VgA0tJzGCK9kXbEhsl1tJvsg+Be+DPvZkIIsdOueTDyB/LeCBKDgFmX3T5qGaeZIS8kha28AjSw/C+kldqj21m11ZCcZWBsi3A3XHwLUT7MEXzv/QJWfKRU/QPDZ+yPUeyjisu+QyIsG5XjaVhM15z+Z4=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV1PR04MB11488.eurprd04.prod.outlook.com (2603:10a6:150:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 18:28:29 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 18:28:29 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 20:28:04 +0200
Subject: [PATCH v2 1/4] arm64: dts: marvell: cn913x-solidrun: fix sata
 ports status
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-cn913x-sr-fix-sata-v2-1-0d79319105f8@solid-run.com>
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
	PAXPR04MB8749:EE_|GV1PR04MB11488:EE_|DU2PEPF00028D09:EE_|GV4PR04MB11731:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ce2e84-bf85-4102-c22f-08ddf16107e6
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZW5pbGpmVEsyZnFxTHFYZlNKcWhQTjNvNmZPSm0rckRjbUFIRXBRYU94NkdK?=
 =?utf-8?B?bWVWaHZpcmtpcWFTV05PWUFNYXVjZnRuRkpIYWM0WnFCM3ltY05vdjZON01W?=
 =?utf-8?B?d1I4TkhMRGZDM0xaZ1B0OU1lMlBJZGRQMExydHNVVnJ6aGlZcit1WHVLaFlj?=
 =?utf-8?B?UzB2YlRUOVBYNTZyNDF2cFJrVzRrMXJ2eUNNZHk2ditIb2IxUU5UM1phcEcr?=
 =?utf-8?B?cVdMZkJ1SWZNSlA2aXBTeGZhZE1udTlyS2QzR3JDS2dBWSs5Ly9CekVHVksz?=
 =?utf-8?B?VXNUeHhFY2ltdGp1Q2h6aTkzbEdIZWFCQTV1K05DUjZ3cFFOWFF5ZjhYbnhF?=
 =?utf-8?B?QmpDNTN2SEZ4RnFucWNZV2J1WkhKa0VHODFFaG9hYVY3eWdraHFvakpGSFpV?=
 =?utf-8?B?SWorcnpTN1lKN0NXUnpXZ2ovcDBFbjdMcTZjK0VRY2FkcnZIWGorTDFQWjg4?=
 =?utf-8?B?b25iTGVoVlFrU3FNK0dCQmFZcVV4alJ1WnJYYkR4ZFltZ3FNMnI5VTh4b0NP?=
 =?utf-8?B?c3NRMTRFQ0Jid1JzcExSUWRHdFc1M0pLSGNYZEhHa0NZOHlqWDVkOU1XRVgv?=
 =?utf-8?B?SnptcC9GQ0FrMk9jY2pxa2tiZ3FnUjZVQjFsWk8yVFI0bm9IUGZlWFZ3c3lF?=
 =?utf-8?B?LzFWN0VURGJZZUVLSVhqZkJKM2IweFRvVDg5Nk55T3hTSVozWjY0TDl2OEla?=
 =?utf-8?B?bUZoUlVqQ2hPdlJyalVuekZ4RTNPWGhLczJQbndSMzVQWXNwUTY5WUExN3dn?=
 =?utf-8?B?bkFwMTJmbUVoRFhkUkpRcWdCdVc4NUc1L3ZISENXbEZnMWZ1a2lyK2JidDR4?=
 =?utf-8?B?QVNScFF4TC9XNVpNVEhRR0I3TXZjMys2STZPNTJlMU4rb29Jd3BtaHhKZVhS?=
 =?utf-8?B?ZHdNem5rNlFuZVBycEp4amZDaUZWcFhuekRVUXB4Y3dYQkowcFFJdVRRUzRh?=
 =?utf-8?B?SjM5VmROWGN0aEZ1S25leEhRZ1Buck1ZWkZVamVUN2YvejFWaU9DMExlWjVJ?=
 =?utf-8?B?WGdwSUI2VVBSa3pnbzFDWWpjT1NWUGh4WlEreWF0RzRLQW1JbHltU20yYnNi?=
 =?utf-8?B?NzMzZmhxcTcrMHEvSFpmYTVpcGFmdnRLLzV2eVVkWElvekJFNnpGM3luNkdk?=
 =?utf-8?B?YkR3OTVzOXh5S2lMM25sOFRhUDcrZWhQeG51ZEg1Y0oxMmFKaERzTXpyd2pv?=
 =?utf-8?B?dUYxTkl5K3laSjB1S3d0czRHN0l0QThkVmpZNU9WMnVwcnZNWEQrdDNleVkw?=
 =?utf-8?B?Z3h1dDlvQlduL0l5QW1SZXkycGZ5dUczMHRHYVc0b0t5U0laNUw5clB3TTU2?=
 =?utf-8?B?RVlVc29iZTdRNDRIazNQdGJqbUZ5aTRvMUtrRWllLzBrMTlKd3kvRW90NGlM?=
 =?utf-8?B?Ykc3NjB1RG1RRXlLWit3UUtncTZpRGRkLzFlQlJRZkRnNThsVWpiaWRuZTdG?=
 =?utf-8?B?czlaRWlJLzNySlp5ME1ZUUNFdU9SZFpwMVUyM25NSXNTTW1KdnVXZnhHc0RW?=
 =?utf-8?B?RFpDTDZLNEs1QTZCSk1BR2ZWa2xjMmRiWktYUk9ROTd4S2t4T0RCMGd0Zms3?=
 =?utf-8?B?ODlPODJWajAvM0x0OFRPYmtnN2hEbXJWajJSWGRTWWoxZEtFbzZ6WW1jU3Ux?=
 =?utf-8?B?Y2wxbGF3emV1ZkMydk83clF0dllSNVJmRWI5QjJoejM4dUkxSnQ0Tk5WYWJh?=
 =?utf-8?B?cE15NzFmdW5Cck5rY1F2bm5jb3kvWkp0REp4ekJnOXM4Vy9zQmhGdGwybVFF?=
 =?utf-8?B?S2NUZkpoL05WVDVpT01kNllnM3VubTlBWHN2b2dSZTlBUGdUOHgvN3Y1d2JU?=
 =?utf-8?B?c1NMR3lSWlJ6NnJDV3FPYzQ4UHFDejVoZjRnT291ZDIzeXJFNk9iQU92L2xF?=
 =?utf-8?B?a3ZmT1oyQ0s0N3oxS1ZwZWhXMExQL1VhWE41REduTS9wamM5ZHFTczRRc2VT?=
 =?utf-8?Q?uIL+rjKnrHU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11488
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a670764f38e8486a9aeb7437dba1840e:solidrun,office365_emails,sent,inline:747356389351dbbf289619dd077559e8
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3198b82d-3ed9-4e3c-171d-08ddf1610163
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|35042699022|14060799003|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHhwejRPeXZFVjIwcGt5UEFiMDdBTE96cHZtYS92M2lmQ3hXeWN0SUwzZ2p5?=
 =?utf-8?B?anFOM2M2VkM0cER5QUR0aEQyeDN1dGFuUUpTZk1BRkdLdlhZZExhTkFvWmNK?=
 =?utf-8?B?VEhFdkJBZmtCWWlBYkxNU0lvMmJ4aEttdGhIOE1ydklXeVpaRTVWZjN5aUJh?=
 =?utf-8?B?UlEraExkU3VRdXZrUGJtTmM5dUVCNG5LYVFOcHNKWjFHUUYyeEs3ZEFVVUdz?=
 =?utf-8?B?UnJ2MTJpZFVYZGlCUlZtcWFqQ1ZnOFkyR25RSEVuRlMyQ3BwNGh3ZzkrNGp0?=
 =?utf-8?B?S3M0bHcrdFpEdGxla3hLRUR3RTBYaDg3dGl0TjAxc1VRYk8xSDNUY2xGbjNF?=
 =?utf-8?B?dHkycHkvWGczZE5PdnN2T281MDRjZDBmMXZoOUdpTGVqTklxMURLQ1p6TS83?=
 =?utf-8?B?NlhtQ1VmUlFhWDBlc2lJdUV4V09aZEc0UWdEdkFKNTY3ZEZuR3VxZmUrY1A3?=
 =?utf-8?B?aFkzaDBVdmVhelU0WGxTZEF5ZHdrU3RWbWJzYVZYbndxSTF4WHJqMW9yN25V?=
 =?utf-8?B?d09oNFJRT3pvMFhDeEJCRCtQdVU5K0VzTnpSVlE3NnBUMDY5bHp2ODVKbjNY?=
 =?utf-8?B?U3Y1dlQ4aDl5eElEcFZHdUVDL3BYQzU4YlpkUS93bGVXQnhkNW41cEhWTUhh?=
 =?utf-8?B?MlFYSzZpQzUzWWV0c2JRM20vV2VOTHpxZDFwS2NPVUJQTUVlSUtyRmdrNDdy?=
 =?utf-8?B?NjNkaGNWbGpBeVVaYWpjd2prdjBFZjRMd0l4RVJYdE1FNE93cU4vL2YreTdY?=
 =?utf-8?B?c0ViOUxpYzdoNElUQ21hNll1SlZsNVpmUGZNNWhzRHRWYi9NK2xGL0U1ZElY?=
 =?utf-8?B?MXY5bDA3UWpGemR5NnBuN25oYkJHaW5sTHlGTytlaHpXbzZHTzFGMTRXM0xJ?=
 =?utf-8?B?VEZiNzdVT0dDQVAwSnJ1NmZXZXU0S0tYNVFzeHY1UU1INGg2ajI4YUhiaDZC?=
 =?utf-8?B?aGpoMkdYVHB0S0FzenVPQnBqSFZJSkt3ODRBOUN1cC9pdXJpWXp6eTRUUlJE?=
 =?utf-8?B?L3JodTN0d1FPRUppK1Z6TjZscDFKTXJ5MGNGckpvczZ5UU1PRXM4UjFtdGVa?=
 =?utf-8?B?SW0vcVRZeW1RQjlnaWxkWVgzQnhlRWpQSVM4TkJteXp6N3k5WnFrQjZCakFF?=
 =?utf-8?B?Qm8yVW5yRmVQZXhHMDI0ZXRTR1pGT3I3ME1LM3hEL095QlBsc3AyVUc1YXRF?=
 =?utf-8?B?T09hay9SUzh6QWp5TXNUMW1oZHhSNVRpRU10MGQ3QURWQkpOaURYQTJ5dThi?=
 =?utf-8?B?elhuVTVTdUp3dlREQkhpdGhQalhPU2cyZHhhVlJSUUZCMUQvZnRteTI1M0E2?=
 =?utf-8?B?bzhCSk5mSnhSc3lobURGV0VrazkyWFB6ZWZBUE1kVk9ReEZCOWhkYjVQQ0sv?=
 =?utf-8?B?bFJoRStNL0R4cktnU3JUdDU2cXhOT01XQ3FudUZWdnRaSHlHcCtEeE80U0NQ?=
 =?utf-8?B?OHZ0QlhSbFhUN2MvNXd6QTVrQmwwakJud3ovZEltQytML3JBVkRxTCtJRVdm?=
 =?utf-8?B?UWZLWTNMcXZGbE1CeU1MTjJRazlMNVlML2Rwd2JKeG9tQTBWRlhmTmp2MERP?=
 =?utf-8?B?bmFjR1QyWGJWS0EwSUZZcmg5RlJ1R01GdkhvajF5YndlYVhuWDdhQ0RFV0J6?=
 =?utf-8?B?ZFowMXZaK1RkSHZKejZnMS9URlBsbHBwUWNLTTlDckFMVGhGdDBEMUkrMmc0?=
 =?utf-8?B?dXFkTDBXbUVRU2JKVTd6WkprTjdRUDJ0eGZTemNrZFRNKzVWSFlMb1k2Nklv?=
 =?utf-8?B?c2ZIaUpWdGhyQ1laY1U3a2VreENrRkt1ZWtIUUJuRlF4ZG45ODJJRWZUcEND?=
 =?utf-8?B?S3V2QThYdzAyTkFvMmdsN0ljazhkMmg2MmUvSDdDbEZMd0FlWkh2SmozaWtX?=
 =?utf-8?B?SDlhbUwza3BSdFBpSlhGa2VzQUxWcFhPS2dCUnRXZTZqVllDQTZGaklaWk9t?=
 =?utf-8?B?c0MxNFAzMHd6TzJnSHBQd3VDd1VvVVNaeTdZaXlEYnhYR0VLNGR2ZW5SNkJG?=
 =?utf-8?B?Wm1WTlJMSlQrcVJ5c0ZiR1pjNFZCUE1kVHpkL3JvdmZ6c2JpVFlKRGw3MWV6?=
 =?utf-8?Q?LrfGfw?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(35042699022)(14060799003)(82310400026)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 18:28:40.2686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ce2e84-bf85-4102-c22f-08ddf16107e6
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11731

Commit "arm64: dts: marvell: only enable complete sata nodes" changed
armada-cp11x.dtsi disabling all sata ports status by default.

The author missed some dts which relied on the dtsi enabling all ports,
and just disabled unused ones instead.

Update dts for SolidRun cn913x based boards to enable the available
ports, rather than disabling the unvavailable one.

Further according to dt bindings the serdes phys are to be specified in
the port node, not the controller node.
Move those phys properties accordingly in clearfog base/pro/solidwan.

Fixes: 30023876aef4 ("arm64: dts: marvell: only enable complete sata nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 7 ++++---
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 6 ++++--
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 6 ++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
index ad0ab34b66028c53b8a18b3e8ee0c0aec869759f..bd42bfbe408bbe2a4d58dbd40204bcfb3c126312 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -152,11 +152,12 @@ expander0_pins: cp0-expander0-pins {
 
 /* SRDS #0 - SATA on M.2 connector */
 &cp0_sata0 {
-	phys = <&cp0_comphy0 1>;
 	status = "okay";
 
-	/* only port 1 is available */
-	/delete-node/ sata-port@0;
+	sata-port@1 {
+		phys = <&cp0_comphy0 1>;
+		status = "okay";
+	};
 };
 
 /* microSD */
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
index 47234d0858dd2195bb1485f25768ad3c757b7ac2..338853d3b179bb5cb742e975bb830fdb9d62d4cc 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -563,11 +563,13 @@ &cp1_rtc {
 
 /* SRDS #1 - SATA on M.2 (J44) */
 &cp1_sata0 {
-	phys = <&cp1_comphy1 0>;
 	status = "okay";
 
 	/* only port 0 is available */
-	/delete-node/ sata-port@1;
+	sata-port@0 {
+		phys = <&cp1_comphy1 0>;
+		status = "okay";
+	};
 };
 
 &cp1_syscon0 {
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 0f53745a6fa0d8cbd3ab9cdc28a972ed748c275f..115c55d73786e2b9265e1caa4c62ee26f498fb41 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -512,10 +512,9 @@ &cp1_sata0 {
 	status = "okay";
 
 	/* only port 1 is available */
-	/delete-node/ sata-port@0;
-
 	sata-port@1 {
 		phys = <&cp1_comphy3 1>;
+		status = "okay";
 	};
 };
 
@@ -631,9 +630,8 @@ &cp2_sata0 {
 	status = "okay";
 
 	/* only port 1 is available */
-	/delete-node/ sata-port@0;
-
 	sata-port@1 {
+		status = "okay";
 		phys = <&cp2_comphy3 1>;
 	};
 };

-- 
2.51.0



