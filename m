Return-Path: <stable+bounces-194868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58623C6148A
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 521FB4E3FEC
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAF2D3ECF;
	Sun, 16 Nov 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NlwyIpFq"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B12D3A89;
	Sun, 16 Nov 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763295278; cv=fail; b=HBm9stHF/fklxdjeUQQEYX3OgQvSu0aW/PB2mUrGGqnk7f/An/vz6yIvxflIKksql38hOzTduaAcxzOjoW1X9gO7VXzILVFCl1OWtbpNlIRnW66BvCTEIaSe3tahDz2imp3vDi3xXByugEXKt1qvAeJ2s9n+sEC/rrVXok7nXJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763295278; c=relaxed/simple;
	bh=jGkJUTKj4TgtxWQeF2wT459T/PKxnU5COVcYasHJ9no=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6CyO0tgwzYVeCM6mO3ecBLRPOnCU204q7l7biMBgHfot1+Br5vu2i6fnDJjWW+dP2ZDzntXvkBjESkiljm0sL3GqT3WeLT/7DDavBbUBHr6FUhM72ijQNEc48iZEnft5+GaNHRJ571sqc41CncR0v8Z5W/SUBnE0qeTsa4f/Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NlwyIpFq; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9udvuqb1aXbCBIGgmGvwcDTQP3RWmsLY9e+1y8Q3uRSGjwQsO+N1un9dl6FQdIjyutdAghWPRk/47LPosLytszQMXfvNcID70jyYfHOHa/5CpUqUmE617G7plDnlh7LPdALAKB9+hqq0tGrTwAmhRYOPax9iwpcQ9rs6tDpS2TX22kI3JXpRNeF9WNSVR33hdCDRg8lotvO0i8VVYNCtrBRMgSAdGyWwZhz3csO7k4YVIgXY6aV2xHN3lfy8Si8IBFTmiIPvfXFL5A+pIJlt+3WUvjOU3tlY8W5jC0DpJwdgGqmeeMZsfFErO2VaXVPywup5UQCBiAoFpXweC2c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovcIHk2ihf2E8LOVUHzXD/6s3PuNaO5K5z0ZarSZ85U=;
 b=J45psnqJQSmeBb3b3P7vqeLjjH9Tq80OdFmmQnOURanJgPTu9oi+DSGtp/mx0yOWGQHUcy5gQvRJuUl42b0G2imNQDEvHv30cUPOOtFPY09drUWUH4mYBCggrSeknlpdM6TDISmfQVjuKHaOBiTA6OTCs6mu7OU4uSuwDBxtyt4TR/Vu+THj9aRcDpGqxrjciyaG+MJbOHdW387597EFTzllALmxl/bfCXv9l8HTFIgsOKpjYDWvLaZL9J2eMQpJSEtNqo3NaU1fQpO0WW9O7HncRMlpnUn6dWroNiVqgI/R25a88HyxV62jvhzikQStoUR66IByvydn9e0Uh4Rr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovcIHk2ihf2E8LOVUHzXD/6s3PuNaO5K5z0ZarSZ85U=;
 b=NlwyIpFq5n6c4Axq6GD7WEUWPpIsHiWqVjdi25wzTe6C6rvWQJaoykYuuoxyguP8DfOOMOKhf1gJRMjnBtz0hcrX3zGw52tDN/T+AjdqMq0OUrCj1+eFdALhtBKqP45BJX5ogK+hAdweIK8afxL0peaDwOtBaIBBwxrB1iA5OuvhJRqeBcflifrghFs7jqOpBwtSDbHSdgoGYBUfjgM0OfEfyPmhnZGrgGC/5ejsEcK/zvYoeT83UAypvKMkHxMKVVTzRPmG/KrieSa+UEw1xRBV7AnV1imoACxTJ5ugUKfBt576ueX1UBobthj4fbnBb+ZcN1ogSZi3rZNXwdmdBg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sun, 16 Nov
 2025 12:14:32 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9320.019; Sun, 16 Nov 2025
 12:14:32 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
	<rostedt@goodmis.org>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter
	<jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Derek
 Barbosa <debarbos@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH printk v2 0/2] Fix reported suspend failures
Thread-Topic: [PATCH printk v2 0/2] Fix reported suspend failures
Thread-Index: AQHcVLccuDY+hVXB+0OA46xicE48n7T1O0Ew
Date: Sun, 16 Nov 2025 12:14:31 +0000
Message-ID:
 <DB9PR04MB8429BD6BD32FD6A9A90F7E2792C8A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
In-Reply-To: <20251113160351.113031-1-john.ogness@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|AS5PR04MB10059:EE_
x-ms-office365-filtering-correlation-id: 6387019d-2552-4ca6-b1c8-08de2509b318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l3ZPdkQZk3rLvkHxDuWFg1z+CBiO0Ij8URYLjsa20AypuLfA9I0g8aL+JTev?=
 =?us-ascii?Q?khW82H1tza3cMr3tI1xx3SRE0PDtVEurqCPp7hVS4yGqotWnRbTLKhxW5iQv?=
 =?us-ascii?Q?RZCCjnO68b2Q95U08wx/PezHC9F1NvjPG2sKMiezX1Qpq7UI3/GWvBbQSeM/?=
 =?us-ascii?Q?IXZTP6rcxpCcCP85nRtg0dEi1bMjgyDeuAD0k4wdfF6JJ5uYx76zQd1qFIYX?=
 =?us-ascii?Q?E6ul8jEgm/3pHJKTfHw8oOwqDuB0K5SgWKe6rx8t3TyekZp9D5ekuCM5vZq/?=
 =?us-ascii?Q?EJ0Brs7iMliATvxHmefT3jgNoJdkU5eGelhcyceAoBSlMx+g/6gdQanG6jNi?=
 =?us-ascii?Q?N4g/ETT8trvcII7Ltn5hEgGjiV3bgzfwkS96vCANkf28iXr0B4LOAbm2ZVBv?=
 =?us-ascii?Q?nLOjMJDGvOZBR7ALCusEmUjLe2cRxwRRFSs6MMtpz1zQ+/jaUkZHwJ1qgDPT?=
 =?us-ascii?Q?x0J+d6aPASA5Y3MBV+72RncFqdv3yFI1AE5B2n5dL/m6tQR85y4b8lgxhog0?=
 =?us-ascii?Q?A1Np8RuqbIvMlo9wt/0wuHFLq3jfo4nTB0+94a2z3Ji3Pvc3a8lolcfP9WFV?=
 =?us-ascii?Q?KF4/Kj02l14JWoKjGjUOkGGQ0DxagwqmAT15TSCWuwehWndQT9e5p5so0WoE?=
 =?us-ascii?Q?m9Ub9VfSgKi6x7804BcUk9dVvZ92U9TAllaj+OTGPtWwe2y2yOaWRpv7RO6d?=
 =?us-ascii?Q?UpVZ1pQX+9SDtNZXnFsMGukyunhzDgJ5VAusDcIUUvGROYGnwqBuJ/mvKBaF?=
 =?us-ascii?Q?6zMieL3P3s3e5HHGrqS1YHQRH3HarZ7txMnCmWsCOFK6YGlneCQUi3A1/+SR?=
 =?us-ascii?Q?n0YUqHMiC2xJh7RhTmH3yC3zrM5/qfi4YpTZMNWLmHwFR8ciivwmLqi3BCE6?=
 =?us-ascii?Q?MiUX4UlehrYE2OJFARmH/rouHloRVgCNF0tLEoLjOViaRiglb4LTDfiy/+Uw?=
 =?us-ascii?Q?k6cTeqmTLZ61nRXP3aAN6ArLQKMhMiuEWNhYRb5FyLAHNi1Cr40gitVsO7sf?=
 =?us-ascii?Q?nN9d2NS0CD/wMB0kCkZP+vDaL0F1fpULPFcb0eUBIHSa5tqy/O9bF5UkgzyU?=
 =?us-ascii?Q?Lcy5f1Gu8mpa0p3Vm3q6Ac6UMj2kY85SyfpO7DMMK8mBFXHXroOL/Zpnum6m?=
 =?us-ascii?Q?puU0N/V9UZzFpMzuMOGL7KTZZvYkRlG5rk9Ed+Bm+LI8qOeYV3PpApgemi13?=
 =?us-ascii?Q?dQIw7yNO3CCKN8gM+mt8KrjQXW0ga/cNPL/ahHvlFtE6SamhQ3fTwvErglT0?=
 =?us-ascii?Q?beW0aQI+cz9QclU3qGW/YL4kOZMWU1hUT5+gV61imlHmVrFEGAEC1bcKP3NP?=
 =?us-ascii?Q?1G5GTVliITmn6l7WAQRYngGUNBv5eHri0FyipSwbhZieQ21pDpEy9o3pQB6J?=
 =?us-ascii?Q?g53H7c7uvxUI60xYaRL9BwBIRjMFyhd+kACUnP6kqWfLoalH5wjGcuHCuCpI?=
 =?us-ascii?Q?mwdTbD/iAKCCNrM18QAkwEPlXKGKk2hvSrAhvSkpLN+KkMtda9PAYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yR0jPY98JVpKti36fg62jyhJH1WgLCEPk1My71GBNqsKpthsmiYw/D3rKCRr?=
 =?us-ascii?Q?cmopTacBCGoi0b+08e9lpBbozNsAJVb9AR7qt6rkTdnZ7c8t2IIOGFBvKQiN?=
 =?us-ascii?Q?ttZQTiak5Udz7aNkrxYaIkaCsyEV3bO0lUBo0clbO4HsJiyZyYozxngqvhoD?=
 =?us-ascii?Q?mxWvxFfETX26CeSmjcThW0HKDz+II1lGMkcYo+YgJxVGg/t4v2PtCXvKJ8IG?=
 =?us-ascii?Q?WflsKBVrQ4dICsuwNqi6uV5MZuKtBPZdvnH6kAOEn2AEkEjtD8Cn68hQ7An+?=
 =?us-ascii?Q?7b/SB9m+LwlrwpCel+vy2Dbt2mZpcOWSPKx9X8CDpgEVpJiGGWpCKZbxleo8?=
 =?us-ascii?Q?3MxPCepeDA8XABZCa4BBHHa1XLC93ZBeM81xj6Kslilcs44DKaKP0oAtO+Rz?=
 =?us-ascii?Q?Ude3DTsAl6sIZqeewX32Wy9nsD0rBA9pOmX5v/P/p/whDh3AC+RFw8nizbr9?=
 =?us-ascii?Q?jZlW8Kci0uCNje50PsZYCmltcewN0iduwo1XxbBAvAfhlfeuVkQIcac0Jutv?=
 =?us-ascii?Q?z/oSAKEtOVmv4HXeJQGUkczWxBP7toFbTqgbwZqMMH2bKk200JgTzgb1x6cF?=
 =?us-ascii?Q?qND8JzfWMfJvbnWIZxgZNCTOce5Ua3EX8gkG+CMeIteaILq4E0woJ1M6zohD?=
 =?us-ascii?Q?bFofAQd9ZeNNSqFMqA5tHoS4nRfX0aDxR8rxq8vSAcpL0dN5iAJYgM2NxDJ/?=
 =?us-ascii?Q?X1GaXD6rMJ2MZPxfClkxZeSK28XpFhnZou/qj2wNn6euVPh1zbS+YCp2xIRn?=
 =?us-ascii?Q?M+Acg9w7R3snFO+FBKEa/NfsqHRCBRRYCnD7UFlET0BMP7vAWb3Oh51P9b7S?=
 =?us-ascii?Q?DZ7oDMoq54fn0vSMYPyLuI8TRP285GA14gdlbxOcfswXaFgeGqVKAH4VLgCs?=
 =?us-ascii?Q?gEFwCRAgrzeLK3ni14VuyvE60q2PoDqyZJFP5VQ9LNzyr3PPRC3UWvOJVAHW?=
 =?us-ascii?Q?/hghDpewySXWw92NqKhKY066mc3Wd2gxHx23vBYdW8ntNXVY08VAsrHcTc2e?=
 =?us-ascii?Q?kexh7AVgSU2UZAmCyFnSA309iUPT1zCAFTDxEler+fRvJYiTvgSNUUsE/nab?=
 =?us-ascii?Q?mEcJd2/G/bDlpM6Q7TklXTPW9DZ8tUfGWHF9rtWhZ4fkd/iryEvyOzNdqbKP?=
 =?us-ascii?Q?IcMKq+R1rRyue6dBf9gp3pwjZiSG3pCAOc3olOnaN+hbsUXcVWf5/+aqaS9m?=
 =?us-ascii?Q?n93RqnjnQEcf+nKm6Jh1iBJQNHm1XeObL0pWQrnDaakNXWzmrAmwa+8ABPvz?=
 =?us-ascii?Q?MyoHSfdzadwIn0P4/Y4igKRMeFYQvz3C1iHObVNYyNdCigqgPVul8R05nU4M?=
 =?us-ascii?Q?QjJ2TeN04DEa8cSnZyvXCZnhNZjYTm0fs7VFvepInyHP+4zj+L2Qfh+QtKwG?=
 =?us-ascii?Q?HQbznrDsQocg1jMFSgXDdbaIB7CY6/9+R9zRmToxv303/1+2STlS3Yw3382X?=
 =?us-ascii?Q?dbCEQdxnlAMhm/XF0FVdYRHiOM3aE6J66EJrVg0OuYjL5SBUwUamqAVMoYap?=
 =?us-ascii?Q?NTcgD9HUcTJgvHuXVaHEMfOWCnEaV/vveyINc+9jo+c3g4c5zK9s60Ax3dmh?=
 =?us-ascii?Q?ImNX5Sptxuu6WZCD0oQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6387019d-2552-4ca6-b1c8-08de2509b318
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 12:14:32.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RklqLHeoC1aJYCRLF10MPdr37ZWjf+vwp57XfX0P1Q4gPWVvX1i21FFhi1yJy7hcrRN7qT+i2K/0xzgndmAbAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059



> -----Original Message-----
> From: John Ogness <john.ogness@linutronix.de>
> Sent: Friday, November 14, 2025 12:04 AM
> To: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>; Steven Rostedt
> <rostedt@goodmis.org>; Sherry Sun <sherry.sun@nxp.com>; Jacky Bai
> <ping.bai@nxp.com>; Jon Hunter <jonathanh@nvidia.com>; Thierry Reding
> <thierry.reding@gmail.com>; Derek Barbosa <debarbos@redhat.com>; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH printk v2 0/2] Fix reported suspend failures
>
> This is v2 of a series to address multiple reports [0][1] (+ 2 offlist) o=
f suspend
> failing when NBCON console drivers are in use. With the help of NXP and
> NVIDIA we were able to isolate the problem and verify the fix.
>
> v1 is here [2].
>
> The first NBCON drivers appeared in 6.13, so currently there is no LTS ke=
rnel
> that requires this series. But it should go into 6.17.x and 6.18.
>
> The changes since v1:
>
> - For printk_trigger_flush() add support for all flush types
>   that are available. This will prevent printk_trigger_flush()
>   from trying to inappropriately queue irq_work after this
>   series is applied.
>
> - Add WARN_ON_ONCE() to the printk irq_work queueing functions
>   in case they are called when irq_work is blocked. There
>   should never be (and currently are no) such callers, but
>   these functions are externally available.
>

For this V2 patch set, I have verified it works on i.MX platforms, thanks f=
or the fix.
Tested-by: Sherry Sun <sherry.sun@nxp.com>

Best Regards
Sherry

> John Ogness
>
> [0]
> https://lore.ke/
> rnel.org%2Flkml%2F80b020fc-c18a-4da4-b222-
> 16da1cab2f4c%40nvidia.com&data=3D05%7C02%7Csherry.sun%40nxp.com%7C
> 9cfc62ea070640d33aaa08de22ce3d98%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638986466358701215%7CUnknown%7CTWFpbGZsb3d8eyJ
> FbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DSvtsyYrKyzA4syX%2Fju
> hhKS6vFf8kVPLgR%2FaeMZEfmDQ%3D&reserved=3D0
> [1]
> https://lore.ke/
> rnel.org%2Flkml%2FDB9PR04MB8429E7DDF2D93C2695DE401D92C4A%40DB
> 9PR04MB8429.eurprd04.prod.outlook.com&data=3D05%7C02%7Csherry.sun%4
> 0nxp.com%7C9cfc62ea070640d33aaa08de22ce3d98%7C686ea1d3bc2b4c6fa9
> 2cd99c5c301635%7C0%7C0%7C638986466358740800%7CUnknown%7CTWFp
> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Daw9PKics
> 81DBClwWFsavyPS4XcHqGvxC53rUtd%2Fu7yE%3D&reserved=3D0
> [2]
> https://lore.ke/
> rnel.org%2Flkml%2F20251111144328.887159-1-
> john.ogness%40linutronix.de&data=3D05%7C02%7Csherry.sun%40nxp.com%7C
> 9cfc62ea070640d33aaa08de22ce3d98%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638986466358781709%7CUnknown%7CTWFpbGZsb3d8eyJ
> FbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DJXLraqSBF2HnRs8FmN
> wbBPu9nlyvnDSzx%2BU0AOML0Do%3D&reserved=3D0
>
> John Ogness (2):
>   printk: Allow printk_trigger_flush() to flush all types
>   printk: Avoid scheduling irq_work on suspend
>
>  kernel/printk/internal.h |  8 ++--
>  kernel/printk/nbcon.c    |  9 ++++-
>  kernel/printk/printk.c   | 81 ++++++++++++++++++++++++++++++++--------
>  3 files changed, 78 insertions(+), 20 deletions(-)
>
>
> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
> --
> 2.47.3


