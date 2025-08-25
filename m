Return-Path: <stable+bounces-172851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2320B33F3D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B230169ACD
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76457225390;
	Mon, 25 Aug 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NYou2pCF"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB81FBCB1;
	Mon, 25 Aug 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124490; cv=fail; b=V/3vJrc+0oFJMhERHyBvdZFLwTQ5/0OJwjfTZCuAHMvl5zbAixL8mE8dTxY0o7Q3Y/SyftlKwKgPATqRZsRM5K4rbedk4ayAqlkBIZYCLsMyNRSqWtM0T+BJMG54AMo7kfJlGU9NllqVRIyPXjdKakRaHFz+IwcUwfX8zNhEokA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124490; c=relaxed/simple;
	bh=uHhvOgLzLHdXMxqSeEyVTm4tb1Q2Qv22OhA7C73pPSM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FKMAtC5dqfLdKyPohfV3PkWNxJdEHKa3HKwJmCbPu5aMbYwf2V1sW3iIbylTH3csrjbNLpd7ty383NCmdb48L0/PLxt6pu2MlDDuw2ymb3IqbENDnKKxfXWlu6/hO0RLxanRZ6xeAALVUiy1pv1CLQNhjKUtwazM6vaVVHXJbJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NYou2pCF; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgjFRGG9HTcgDTdask01urFrNpcC4pEa2Ytk+LaYjl9Fbs8ZRNn0XN8E+nu7HshN/f6C3kmD+AT7uUDob7z6QnF+v5kvI14ceJ9+cA685SN2HHWjTA6Fr0jS5ROkLHJ1BShlN30RnyMl4I5eYFI8q8+apFVq+gluvoWMZe85rVe/VpPE9qzSzsxKVM8hNwtDsiVE3wolDoFv7KrhtXeqiy8XWEHpfMNnPfyl4hPXb7Q9HEz+0GTl/QK86BT+DFlMW4uU5gui4SQHuY6U7ChlNxieVTlK3dOKp4x7I4g+7LPByOzGFV1j+oDP3QgLtmx0QZ2+2rvylBDt9QT4ZutsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHhvOgLzLHdXMxqSeEyVTm4tb1Q2Qv22OhA7C73pPSM=;
 b=L94+f7jMS0oB0DSfKmmunBwSy7L2V1/u0Ls3wosI4BO6OHWZWLYqQNYfE0GKSjvSTCAYhVT0UJxYfzQ1MPPdrmqU8KL8PgzlHjHXRids2nRnx9jaYypA2YacO70kbmmYcBnWQWTOUU0TPj0N8D8MtJeTleLuWLK5IqPTpMGuiUjzMO6g1eaXyPAWlXv8kYH5HGXBueIWzvQUKJ8UEWWZqu+jjbXlbwckb4AB2j5MIw/bAATnrgnpiJQ6rQ1IYPrG4bRFNO4ijHJmAVyTECmkq+EYxRxBiEydqmVN6ijWU1uzi8xicDnffBpP1tFQIKrPcvdNa8gcyWOuVdKnplZOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHhvOgLzLHdXMxqSeEyVTm4tb1Q2Qv22OhA7C73pPSM=;
 b=NYou2pCFuXjvkbwTXi3MERCeZLUuE41L7lUjjRegJqH1l/RYFB+xTZ36X0qjLxHevCUwJWWNhMYV9cX82yG8Ju0DMoBXvad5Ib6JIgcuXxInsK86QzZ7n1EnwqWivupRHG+v4auGpvFxa1UzkzvXpuBUSqoj9lagrz3aWyJOfUjF9jHnwENgNDZ4K5aBs5el/lNfnlZiKAFd2hVLAGkG3426uzx1L8nVHrKZtUuZRBzXDMHSwMOzI+nnzOWNrf0Gc78iphtFdlgWetqQrwNcd2Jt4hpttKzxGpXJ8eGT+f7+eDl/d6OibXpy/vJZif5BQFayf1H/xV6FIMyreK/93A==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 12:21:24 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:21:24 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "Balamanikandan.Gunasundar@microchip.com"
	<Balamanikandan.Gunasundar@microchip.com>, "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "richard@nod.at" <richard@nod.at>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"bbrezillon@kernel.org" <bbrezillon@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read setup
 timing
Thread-Topic: [PATCH v2] mtd: nand: raw: atmel: Respect tAR, tCLR in read
 setup timing
Thread-Index: AQHcEpNMap6XZeIVvkickt5PeawpyLRzOl4AgAAWBYA=
Date: Mon, 25 Aug 2025 12:21:24 +0000
Message-ID: <3d0259caac9925e3d5dd3dd27a6785b2a2e82c0b.camel@siemens.com>
References: <20250821120106.346869-1-alexander.sverdlin@siemens.com>
	 <20250825-uneven-barman-7f932d0ca964@thorsis.com>
In-Reply-To: <20250825-uneven-barman-7f932d0ca964@thorsis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9169:EE_
x-ms-office365-filtering-correlation-id: d681e1d0-054c-4d59-5130-08dde3d1e870
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzVpQ3ZhTjRhOFJGZmpNSGpueEVQSjQrM0lwa2praXVSTXJvOEhmdDFWMGNO?=
 =?utf-8?B?UXNPbm9XakR5WHc5bDJuV3QxcU9oSlFIV1hmTzNWVEYzTExiTCtGdVBOenFx?=
 =?utf-8?B?QTFrS0cxUUNmZjlUR0xKc3VsaG11RGhaZENKczc3NktqK0syZGJ1YVY1eFV3?=
 =?utf-8?B?anVzYW1rb1lCK0hLbzVOcE9UUWkxYmh6dnIrMENzdXdWL0s0MFBLTmtHOUZG?=
 =?utf-8?B?NGpYR052UFlxcVFkS1RFWXZMeC9UdGN6bnNkSGx5VmJmVmM3YlREbDBHY29P?=
 =?utf-8?B?SEdmUWNxQytQWXgzZlNJQWVSQWJOZy9TbTBZdVVDWThMOUs5SzZ0eDhIQ0pN?=
 =?utf-8?B?M21QbzVFZ25sc2x0SFZaaERaNitLWjczUWxCN2xBblorTjZ2Mk13eVgxUHU5?=
 =?utf-8?B?ejhYdE1teXE5V2pqTmJVZ2dlWlR2TzdneDVCdVVGRG9lTkRmQzc1K2xpOFBj?=
 =?utf-8?B?ak1ZbDRSTUphOWVzMFN0SW83b0Z2Ny9XdXhab2NPTitHaytHbFRuWGsvZ2hK?=
 =?utf-8?B?bnFJa2g0VkFBVDV6V0VNanVoRWE5Y20zYm9DZDFhUkFzQXBWSEdLdUFTbG1z?=
 =?utf-8?B?cVZsd2c2OVNGS2F1MnJueERDUFRDSnh1RkNBbnNEMlpOU3NiUUdRRTJDMGEy?=
 =?utf-8?B?WHZZSEdjdFp3Qm9TdHhTTGJzcnJlRmNiajBJTERaWHdzNVlIWDFiMGlZNDRZ?=
 =?utf-8?B?ZDAzMWtLUTlRSC9meEx1QkViVzJFSU5oY1NhTnkzTFF2ZnFwQ3BPWXQxUlZX?=
 =?utf-8?B?SENKb1owblhXdGl3NTYyQmRpUXdpdFlnVW5LRWc3YmFveHIvQyt5TnRBREJn?=
 =?utf-8?B?b05JelpJcFRKOEtmVkdIMWllWVp5Y0tMczJkNVF2YVFSRzRoWlpxOWQwVE1G?=
 =?utf-8?B?ZUhZYWRQdmtsUDFlVWREZFk2cGVlK2UvaVI4RWtjQm1td2RYU29qTklwUXBS?=
 =?utf-8?B?OFlmZU1jMXZ2ejVDTUs2NDJEcGIxR0syYjVkdkxDY2VuTVhJQitUMXJRWmEw?=
 =?utf-8?B?U09rVjdCMGx3TnBOWEdLQVlKVGNGR2p5eXp0Q2hPN0RWVU5UdVNmenE1SVBI?=
 =?utf-8?B?bzYxdGFxZTJwYmxPUmlmYmpEZk8xdHBqU2pqSUZ2UEQzMDFxSWdrUU82Smhw?=
 =?utf-8?B?NUZFcWY1aDVWbHJqRTVVMVJaWEYvdGt3RWRTbmdhMWE0K21vdTlzZ3BnNExF?=
 =?utf-8?B?K2tXaDZ2d1JxWFJ1NjVzUHE2YVR3VDB2SHV4OTNhNDZLVzNqS2hOYWJjZEJX?=
 =?utf-8?B?bms3a3FvdldabDlMUVg0U2FaQjhDUEhuNWtOMU9nRWFLUnUrZ0tFeGlnSmNq?=
 =?utf-8?B?aEQ1MlhTMndHelRoWXJsUG4rYkFKL2N4RzVBTFlLTGphN3d1VHFmNms4TXN5?=
 =?utf-8?B?MWJnT1FPRWliMkFtQ2JkN0dpQURwM0xvamU2VWltWG1iQjQ2NVNFRmkyN2xa?=
 =?utf-8?B?YnFsRG9DZDdheXM2ait4eFhsVTRVNjdodjk3OTJMcWFQTUNXb1BWQTdtYTNG?=
 =?utf-8?B?bkZQVmtLVWtDa3hJZWpUZXkxYXhLUXpYQXl4eTViT1ppMDB6Q2RQRlhDalFq?=
 =?utf-8?B?Mjg1WmwxdHMwQ1RiK3hFQk1kNE92QXhVR253U2JSenNqZE9vdGE4TnRkaUlR?=
 =?utf-8?B?SWx4VlQxT2FoVlRvZlJOSnVJNnI4MVB5bnZUSGRzWERKODhEZDl0ZWllc2NZ?=
 =?utf-8?B?ZmlCSkI4R2IzdjJ2NnJCQVRBTFFyVjBWQlJaaTJDd3ZjRUdUM3NrOUFzWEVo?=
 =?utf-8?B?QTJjZDhQbnRiVzEzdlFraXpUQlVjRjBobHZOQm9XTzJPN0tXZTlYMDhCY1E4?=
 =?utf-8?B?UzdkU0RncXlMNHc1WjBsV0h1UzdEQlhOVVZENzNxdFFmVTh6aXdPWUs3ZDhP?=
 =?utf-8?B?dUVpOUs4cnlrVW5zdnNxL0JDbkhUYzFWOXhMT0ErSDYrMC80U0N4YXJNdkNt?=
 =?utf-8?Q?0ZOj/hSiZkXdadNpBVhunuaK4YdQBg7R?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTBWbXIxRFFOQWxmU2JVMGo2M3hlVWYzU2hoazd2eTlubmhubC9ZRG9HYXlE?=
 =?utf-8?B?NmlBV1U5YUNzTlZtTklXRm5mOGdQRlp6RUZaT2F5a2d1TmRwaHpWYkJPTzBT?=
 =?utf-8?B?aG9QaFRxSFowSTJpdEFYYmZETkt1V05tZXZ3ZU5wb1EzbkNDTG05dUx3SDhP?=
 =?utf-8?B?bVFMd3FTbG03NGF0Z2Evc0EwRmdWS0x5VzhtOFNMU0ZLL05IQzRGSzNocG5n?=
 =?utf-8?B?cUs0QU1wQWxlSDdjV3pqYjMzTnZtVE10V1RsT1pFTDNUbCtBdERERUFGQ2M4?=
 =?utf-8?B?R1ZtSWs3TVVjd1VqT1hFTUMrbFd1N3pxOW5aOUxwNjdnZytJYTc0OWIvamxk?=
 =?utf-8?B?dUhwWWgyak1aeUw2Z09XSXdKNFk0THFRQy9aYUNJdmE2L1VtMGlpaFAvOXY5?=
 =?utf-8?B?aVFXRTJTQ1Nsd0lqSU51WDEvblZFYlBKc0xBM1RlalJxeThiRi9RdEdOL3RL?=
 =?utf-8?B?SjE5bUphNUp5VXcrcUc2WG83bUEvSGVPbDkxZTFVQnJhMXlsejN6Y25aR2pQ?=
 =?utf-8?B?UUY5MHZlSGhVUXMwaHRvRkpMcXpYTGNsNUs4Q3FiNW9ZRk1LTkhmT0FSMVBU?=
 =?utf-8?B?LzFBYnVWOU5mOG5LZXVRcVVMRjI5NDRCd2V4RTN5U2NPeWRobG5icnAxYVkw?=
 =?utf-8?B?UlNqR3Y5TE13Z2VTWEkvdDdGaldHT05KRmYwREhLNG0yRVkzZlBZRXFlRmRB?=
 =?utf-8?B?MjBTZkt4NjdTNnI5Vkt2dXF4UDN1TEVMdkJLN0tTdHBrYzVseW5URGQ1SlVn?=
 =?utf-8?B?bFhrOTE4MXdKM3laS3NaVEgyM1cvbWprdno3WTF6dmRxMVBNNTNZZFdiNkZH?=
 =?utf-8?B?Q29vSnh6VFh5SlZ4aGl6TGRIeS80QUJyeTdWcEZQNUV2TUpQQng0cVl1SWp4?=
 =?utf-8?B?SVdHa21nUUZnZlZ1U3k4cy82Y0JVNWJENnE4R05aellRZzdtbzVDY0FIVWN5?=
 =?utf-8?B?dWxsbFdOUk1EQ2VsZDlialNGRjRCY1ZYRGE2MDdFSUkwanRHL1gzSE9QaHNt?=
 =?utf-8?B?ckpkVDM3RWVKQ2JBN0U1RFp1bnNPNllHSHZCcXEyQzRjQU9PUUk3VWpaM2Rv?=
 =?utf-8?B?dVl0ZTdKL0t1NVpsTzhkR1BZUkZ3RWtQc2tlaWZDR3ZzRGw3dEQ3TFJpbkdF?=
 =?utf-8?B?RGFIUGZPRXE4UnhRWkwwUUJHcmR6RXlkd25SbnBIQTNZQjVsVlVBbmNTMVlx?=
 =?utf-8?B?YXJQb3FkM1BYbUtGaUFWd21ZMGxBak1BOElMQVBVY01VTEhDNG1qUlJublVz?=
 =?utf-8?B?c0xNWXE3ZUxCYlE1UUI5VlAxWHhGU2kxMkp0WXdSMTBjSDlqcGhDcGkrZE1N?=
 =?utf-8?B?NDE3WS9hUE1TYzhTL0lNc0g4aTY4ekNEWURvUFh0SUJiWFIyQU9mZjMvMndB?=
 =?utf-8?B?N01NRHpCVXNQYnVaNnhTTHhwVE5ySHhqeDZWdkRnUFQ3Kzh5NzgwU1l5bWZ0?=
 =?utf-8?B?TjVzK2dJbG9ULzJDQzNNWURWM29rWUdhRUZTdGw1OWg5VFVVYlVLaUQweFlM?=
 =?utf-8?B?VnJuTDlHQUhSejJZUnhGaGtGSXN1RlFJL205UFMxMXZaZ1RWRlpBZ2VQdmdt?=
 =?utf-8?B?aUtiOVpCM01CcFR6YjA5WnVTMEk3UzdSb3FBczN4M0k5eElGUUVBODRmN3lD?=
 =?utf-8?B?M2Fid2pvL0pmZndjTEpzRFFDVi8rb1puYzhEQjhzUERlM1p5VDVCUnJxZE5t?=
 =?utf-8?B?N0ttVld6MWpiQ0VXTW1rWWg5V1FOanRxdnY4UXNYUnRtcVdQaUJBVWErRGFX?=
 =?utf-8?B?eklwWS9HV2xsMytyOGU3RS9xOHdoeFRnVXg5VjNUUlo1T3BlMWxMaTJUcUJP?=
 =?utf-8?B?eTU5eFlwMnl1TDVCRUQzZG9FczRkQ25sR0NINUtML1NkdGRBQ2dlL0o2eDh2?=
 =?utf-8?B?RzF3L2NtMDZwUTJJWXNZdmpVcTZVcEZoeWZOaHhMS0QyQ2xVOUowQmdMREFm?=
 =?utf-8?B?ZVNUWWVCOTFnYWpFMHJoaVk2bThFNFBhMm51OXJSSEp2SjRSYUF4TWh6aTQ3?=
 =?utf-8?B?dzNxWUpnaEt0ZFc5bWZJYkNaY2FlSzMvem1sMitIZ3dJZzJoUnJJK0ZHSW5o?=
 =?utf-8?B?VFl5WDY2NlZEQ0IrcCt0dEZNM25zdmRkcnA2SHMwb21vRGJ3OWtTdUlMeGlr?=
 =?utf-8?B?b252UVpZdVZWZGdCZjFNQVVIVU5sQzRDNHBQY0ZuZTRvNEsvTWFCanRRaSs3?=
 =?utf-8?Q?lVecP2Uh78UySdS0t3WK0ac=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EE36111E4308249806ED69D3B683AD9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d681e1d0-054c-4d59-5130-08dde3d1e870
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 12:21:24.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbnhJiqxQXmtwSXABsNJ5PrHYDkaOGRbJuGCKgFJDWtO5cgvcGf6FJobV2OYXtvOxSx09Eq2AUt+tv2I2gIFyoFBHmsPtbKhq35AFD00YoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9169

SGkgQWxleGFuZGVyLA0KDQpPbiBNb24sIDIwMjUtMDgtMjUgYXQgMTM6MDIgKzAyMDAsIEFsZXhh
bmRlciBEYWhsIHdyb3RlOg0KPiA+IEhhdmluZyBzZXR1cCB0aW1lIDAgdmlvbGF0ZXMgdEFSLCB0
Q0xSIG9mIHNvbWUgY2hpcHMsIGZvciBpbnN0YW5jZQ0KPiA+IFRPU0hJQkEgVEM1OE5WRzJTM0VU
QUkwIGNhbm5vdCBiZSBkZXRlY3RlZCBzdWNjZXNzZnVsbHkgKGZpcnN0IElEIGJ5dGUNCj4gPiBi
ZWluZyByZWFkIGR1cGxpY2F0ZWQsIGkuZS4gOTggOTggZGMgOTAgMTUgNzYgMTQgMDMgaW5zdGVh
ZCBvZg0KPiA+IDk4IGRjIDkwIDE1IDc2IC4uLikuDQo+ID4gDQo+ID4gQXRtZWwgQXBwbGljYXRp
b24gTm90ZXMgcG9zdHVsYXRlZCAxIGN5Y2xlIE5SRF9TRVRVUCB3aXRob3V0IGV4cGxhbmF0aW9u
DQo+ID4gWzFdLCBidXQgaXQgbG9va3MgbW9yZSBhcHByb3ByaWF0ZSB0byBqdXN0IGNhbGN1bGF0
ZSBzZXR1cCB0aW1lIHByb3Blcmx5Lg0KPiA+IA0KPiA+IFsxXSBMaW5rOiBodHRwczovL3d3MS5t
aWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL01QVTMyL0FwcGxp
Y2F0aW9uTm90ZXMvQXBwbGljYXRpb25Ob3Rlcy9kb2M2MjU1LnBkZg0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IGY5Y2UyZWRkZjE3NiAoIm10ZDogbmFuZDogYXRt
ZWw6IEFkZCAtPnNldHVwX2RhdGFfaW50ZXJmYWNlKCkgaG9va3MiKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0K
PiANCj4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIgRGFobCA8YWRhQHRob3JzaXMuY29tPg0KPiANCj4g
VGhyZXcgdGhpcyBvbiB0b3Agb2YgNi4xMi4zOS1ydDExIGFuZCB0ZXN0ZWQgb24gdHdvIGN1c3Rv
bSBwbGF0Zm9ybXMNCj4gYm90aCB3aXRoIGEgU3BhbnNpb24gUzM0TUwwMkcxIFNMQyAyR0JpdCBm
bGFzaCBjaGlwLCBidXQgd2l0aA0KPiBkaWZmZXJlbnQgU29DcyAoc2FtYTVkMiwgc2FtOXg2MCku
wqAgV2UgaGFkIGRpZmZpY3VsdGllcyB3aXRoIHRoZQ0KPiB0aW1pbmcgb2YgdGhvc2UgTkFORCBm
bGFzaCBjaGlwcyBpbiB0aGUgcGFzdCBhbmQgSSB3YW50ZWQgdG8gbWFrZSBzdXJlDQo+IHRoaXMg
cGF0Y2ggZG9lcyBub3QgYnJlYWsgb3VyIHNldHVwLsKgIFNlZW1zIGZpbmUgaW4gYSBxdWljayB0
ZXN0LA0KPiByZWFkaW5nIGFuZCB3cml0aW5nIGFuZCByZWFkaW5nIGJhY2sgaXMgc3VjY2Vzc2Z1
bC4NCg0KdGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIQ0KDQpEbyB5b3Ugc2VlIGFuIG9wcG9y
dHVuaXR5IHRvIGRyb3AgdGhlIGRvd25zdHJlYW0gdGltaW5nIHF1aXJrcyB3aXRoIG15IHBhdGNo
Pw0KSSBhY3R1YWxseSBoYXZlIGFub3RoZXIgcGF0Y2ggcmVsYXRlZCB0byB0aW1pbmdzLCBidXQg
aXQncyBiYXNlZCBvbiBjb2RlLXJldmlldw0Kb25seSBhbmQgdGhlIHRoZW9yZXRpY2FsIGlzc3Vl
IG5ldmVyIG1hbmlmZXN0ZWQgaXRzZWxmIGluIHByYWN0aWNlIG9uIG91ciBzaWRlLi4uDQooaXQn
cyBhYm91dCBtaXNzaW5nIG5kZWxheSBhdCB0aGUgZW5kIG9mIGF0bWVsX3NtY19uYW5kX2V4ZWNf
aW5zdHIoKSkNCg0KUmVnYXJkcywNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==

