Return-Path: <stable+bounces-206260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E6D03D7A
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30199309915C
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849D35FF46;
	Thu,  8 Jan 2026 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m21jptEo"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971035FF55;
	Thu,  8 Jan 2026 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858114; cv=fail; b=gIrMgsG9seiJ8R2AKsj7Eg3mqs03KZJqbX0nm+eeXm1xzZI7z6clsIpZ5RK2Bm9w+dLgiXG/1VqTqb1bpawfV+LN6wF48GdpMLY4VCX/ZjtBszl4C6wLmROjNbOu1xK9pXZ1ZtEFdOWDMy6iJ0XxmLhyYrOTVOPPeZ5dhGTwr4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858114; c=relaxed/simple;
	bh=seDhMHLf62cbMXhbB4/9QR3/T1MJPFK/cVXj8km5hro=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=T+1zUhL/U0FTWy3HWeX59qB+rAcMD+GSEWgfchTXlw6q2duJ+HzaDbyNDuKtenySKQOSPT29btDD/ho8tVDWOd+cB4bBcvTa3PlrKc4jABeY/2z/yOrAVd1OOr5ryywpEOIv+ZkGxvN+V0CKFKkY++MeDrMAGmqBbOe9epZwFzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m21jptEo; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqr6/iezK9LZZCFtZM4hToXGGDgJ+xFouBhqOysrkfbWJfEzLwsJD0mAgcGWq4NdH7Y/do7wuOCSUtMpfl95pInHMRqwtna439v+6Xw2dfAiZWOuHEmC7LyIgl0iMwbz8/2gea+xBfCKKoUgVY26RwMLTC7+UZEUS+R1sPoElDstWVIRPi2uwOTcRAIhU6wO4faPYcP70EsnnJc8EJwHBLm+CWNCoIH2sRt4A4l6V3dYo3naSs1L49fR+83Wlnei8311uVBhAJd/Nv6ZKOokmBWKjBcbarSxdyL2BoJ5XSdXnyXWJC3yx4PKWqTkQbGDirH+ssWB85z1bAJCNUbbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqIVabKyoOJpUn5lJut7VZQ7xg9+f1VVppmGH2aEGp4=;
 b=bMfWdS8zpxGqaqdIyTfxDPOnj67pbvk9omSG/aXNp0QuDLFHwnbyqJW6Kks2oS8ZN1SUFyFfOvC9s6DR8p4/8lj7lqV4k0UxAkITqqrZ0ZX90OP/1dAMaOcU5n4UarPWw5ioPAcv4qqfF6bQk1qwi8MHyWbswGiqvw4lHjCUyf4G4i5UDgl/kcyK+FhASpmioVo7SR7yhYy3shY5UAWk4hu4X1vUHopHoGKDdUyEvEP56IqCJiFmb1v5Amq47d/Uz2EK9PMG8rkxM1O+nqUta8BXqu1cc1RG6H6nPuSOgAzHtj884hUaxHEQ4IsEWidpb8A7NFwTcCWl80COu0RBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqIVabKyoOJpUn5lJut7VZQ7xg9+f1VVppmGH2aEGp4=;
 b=m21jptEoGhs7s8sHog0LEIEUPERdrk0cwlTcT5wVvDqLadPWuhD4pCElo9xTT2OmJasqxYlCoJxgIA6IiQUxdcGUL26MQ3GgARxn7OFo9Bdc3A8YGosQL02sN24W6Z7nKcOdKKMXAwzEUPaOaEOpd0f4hxEhCzitoqhGbnMOlcQtNoxDKlsSyRWX30OEhAGjihx74rf0hmWkXZUDCGWYhiyGj5Xodb8wqBB84SnWS77bqgoqd1gdQe6cLymvII7qowl3fa8irz1GSrR3H31Fy7Rbd0IkaX6DpPf2jXUxeujrjdkUXGoxjGhmF6oRALgBxGLwqt2xOzK0fbFA2C+pMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 07:41:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 07:41:45 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 0/4] Some fix patches for uvc gadget function
Date: Thu, 08 Jan 2026 15:43:01 +0800
Message-Id: <20260108-uvc-gadget-fix-patch-v1-0-8b571e5033cc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZgX2kC/x2MQQqAIBAAvxJ7bsGUovpKdNh0s72UaEUg/T3pO
 AwzGRJH4QRjlSHyLUmOvUBTV2A32j2juMKgle5Uo3q8bouenOcTV3kw0Gk3JGqHoTNGL0sLJQ2
 Ri/y30/y+Hx3MdmdmAAAA
X-Change-ID: 20260108-uvc-gadget-fix-patch-aa5996332bb5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: jun.li@nxp.com, imx@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767858202; l=1213;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=seDhMHLf62cbMXhbB4/9QR3/T1MJPFK/cVXj8km5hro=;
 b=5dR6MP7bTz14rVYAsnpgs4Su2IEjh/5qyvgJ+iD0OvmTlmSOuaxaRBuAfv/YX7gKwFjjYb0X4
 dXYKVhGraaECYhT636YfJ4JuTcl7ck5vnDTJFbOWM/4aeBsLy0DmLHN
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 93838c07-bb1d-4a17-f526-08de4e895fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTVyaHhGdktzV0hhcGRHNDU1NlZqRTRRbWxZc0FsK1JIM3lhMk1oeU90R2FN?=
 =?utf-8?B?WEZXUURCdU5WUW5GVXZmUVg3djJXc0ZGSVE0T1V2UHpvZFRiOWVMamJvNVFP?=
 =?utf-8?B?SHgwZkZSZ2t5R2xwd255WnhqbENsTDlzeGlVSmQ2OUk5UmtHSTZFcnRqdHpY?=
 =?utf-8?B?T1EyMVJZa3NjdHB5VnBhRFlSeE4xWWZFMk5MNEFCbnV4Mzd1Vk1KY0x2MGZL?=
 =?utf-8?B?QVp6b3lSc1p6T0tUZDBxWW9lbjZheTE5U053Wlk0L0FTN1dNcnR3UGJOOWNC?=
 =?utf-8?B?QnFDQjJOZVNLc1BkaDNVdFY3ejhCTUFnbWIzYWtyK1BDcm9SMjR6S2FLZzFv?=
 =?utf-8?B?UWlYdDB3ZkVDcUF4ZnZpTUpoc2QwTXMzeHZtdDJsMVR5MXJGNnZWMFlkNWtP?=
 =?utf-8?B?TVRBeFZyVGo1ZUlGNVdERW1yUU41YnpBRktOUXhPK1d3dnJ4dnhVR0dDTnhz?=
 =?utf-8?B?VlNuUkIxYmdRV3k0aW01L21iTlE5S0c0Tnc5MWxiV3NrbGtpUDJtc3d4QlMz?=
 =?utf-8?B?UDNhWGJUT1NjV20zMDN2N1dVbWNaUGhCRVB4dW9jOVlTcS9oQjlZdDA2OXpX?=
 =?utf-8?B?eE1vMFNZVkNSY3NOOU5DMGxXaGh3TG1ObEx3QjhNZE5vQlRNSzBBQjlrSlpl?=
 =?utf-8?B?VDVpMm84QVRjTTZrY3E5VlIxNkFZOXBwNnJhRnNBZlY3S29VRFJFTS9lUnhp?=
 =?utf-8?B?NFg5TWxxN1BabW56TkpXcGM1aGhrZElhbGFiS2lTRnRWbzVveXY1Vm1GTXJ1?=
 =?utf-8?B?MWY4Q2JZeHd5OWIyN2EzN29uVFFGbVJYejZWY1BqTi9UeFp5NXJGdXZvMjhR?=
 =?utf-8?B?cldhNTNBVkJrcCt5bk5nT0Zqc1hkOTh5QzdUamlTQVJPN0VaN0RqZjJvV21l?=
 =?utf-8?B?clAzWm9YQTkxQXhsVjBScm16S0YyRHV1WGRGdkFxcmhzZnFrZlExcy9MdjBn?=
 =?utf-8?B?YTdhRmhiY0prdmNsb2xVQlNSQ0F4czE0N1QyWmpOMFpIQ3FwczZsSFlhekxX?=
 =?utf-8?B?NXkrVThJcFlkYUV2Qk0ydG9sZUN0TTZ1VENTU3RydXM1bGRXcGY0YnA4czJj?=
 =?utf-8?B?UlNlbnZVMW0zem0vWUNLL0w2cTE0UUMyVUlyUy90eEdaVjFabW8vN0pqeG9o?=
 =?utf-8?B?MjJuN3pUQ1RCdDlmank3Y281T2ZOOG5CK2VaaEJiU2k1cmtTbDA3cVpvT2dM?=
 =?utf-8?B?S2pMdTkwbzFZdm5oN0tyd3hQRFh6RTVyOW5GVWYvLzdKUEo1WmNUUW50OWRW?=
 =?utf-8?B?NkxMN0g1SFc0NSs4YVRxMDZDM1N2SDFzeFljSzJCaXpiaHdjYjVaNmNLYlZh?=
 =?utf-8?B?NFRIMWZLYnlEUTlQL0lPUmxXU2k5STBOTHlxeExuRHdXWEswb0RNMVNVNXBT?=
 =?utf-8?B?NExhOWtDY3Q5WVFkNURycWVKSm9DVUxiMFlRZG1DVVl4aUJYeWhZREQ3bTJM?=
 =?utf-8?B?Ny9POEJxbGVvRjJPZk9CYks3ZEs3cmE4ak5iNVREbnErNkpBZ0pSUWNnYm9Q?=
 =?utf-8?B?RlFWSWxMRm03Yy9OalpVRjM4RUJ2cHR1SDFSRHA1dE8zeWZIeW8xR1JLdkQ3?=
 =?utf-8?B?M1QveGxUcis1YjVReFFVbDJkWEl3S2FVczUwc2RZWEFzc0VpNkYwOWNZbmZB?=
 =?utf-8?B?bDB6aUV4Z3RpYUREOVc4UEx6R1BxMlVQM2F5M2RFMXFhQ3Myd3hHT0JYVkdz?=
 =?utf-8?B?b3cvek85MUJyMWZxQlZYa2Zvb0lMUmpsdUJ0NW9VdTZrWjFXUDRZdWFsZXJH?=
 =?utf-8?B?czk4ZUZrN204T1o1Zmc1Zml0K05BcGZMTDlzUU1YRkdUSFcwOGhuNG9kRE5J?=
 =?utf-8?B?QzFZWUdQcTViVGIva0FncWhtODk0cWl5T0FvUklZeVhYTnpEVzlHbytORThN?=
 =?utf-8?B?YXRWcFBaaW16clFrZUJaTDVIYkdBdHpSenBBUDVhTlc4bzFNN0JHaGdlVW9I?=
 =?utf-8?B?RUp2SEpNa0JGN2VxUWNRUVVueVl2eGptRWVoSTlDeWlLOUYrRXdXaElhRlRj?=
 =?utf-8?B?OFV5S2ZlL1hQdVlkUXRuRXZLVytOVEhWbUpHYzZYTm92R0pKN3NQUFpBOUJF?=
 =?utf-8?Q?pJdL6D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnllMWJyd1BNYWdnUjNQYjgxTFk1aUhJT25zQm1ZRXpBTEFuUW1TUytPUGM3?=
 =?utf-8?B?T2RtM1g5dGVLLzJlQm9EcWdmdGk4eGFDZ1JLd2l3K2NJRzRnZi83a2Uwam9N?=
 =?utf-8?B?djQ1ZzhsZ1ZvZk03eG0yK3d6ZlppK3hRamhnazJNTzNXZVVHakVKUmlwSGcr?=
 =?utf-8?B?TFZma2R3WHk2MjVRZ2MyUzU0WUhwdHowVWlLZEpOQm10V0swWWNOTWdpa3BG?=
 =?utf-8?B?Q1FtT1IvVHh0eitFMURBazYwZFcrRzR1VUJBYXJFb3oxaHJFa2M2VGVzbno2?=
 =?utf-8?B?ZjhWSWpCWndGSW5wR3VmK3QxRnBwUDlzSUduRzFRY3pua1F1M1Q0S0Q1U05i?=
 =?utf-8?B?eDBKVlBqdTRvdHpSa2JKTWZ1QmhCUm9wYjdXdGJDR3IvZm1NbUVqbDQxcjl3?=
 =?utf-8?B?WHVqRzBUeVkvYzJHRHNqNGVXa3N4NHp3b2FiNzNham03Wk5SdENVWFVxUDdG?=
 =?utf-8?B?SEptRW0rbE5qQW5TZzRiTFZpSklZQzAvanJNb1FFaEgxc0RPQW5DRjV5emFr?=
 =?utf-8?B?L241UnVyaVJ4Y2ovaTBEYTdvQnNUOWRZM044b1NKUUN1WHFuclNuck9ENDdV?=
 =?utf-8?B?aWtMbVF5UEZ1eHhlUm90ZjlBTTgza3dCak0vVmxVUXpmanVBY1diNktJbVVI?=
 =?utf-8?B?RjFMYzcrTGNWb3V0clRFQ0NKN3JFZ1hTMGVaMzNTNER3MDZURFRFem5TcllX?=
 =?utf-8?B?UDJTREROWUlCU01md2hjUlJaN1Y0bTk2alF4YzNFNGlQR0ZZYkJQYVRsb01G?=
 =?utf-8?B?U21uV3lsa1g4Rlp3QnNVMGhRaDROTWdGcjViQ2ZmYVR4cTg4UHdUcCtEMFBx?=
 =?utf-8?B?MXo2em9OdWRPUVV1eHhJc2ZaaDNKTS9Hckl2RXJXYmtJRHVMbEJPS1gwcVd5?=
 =?utf-8?B?cVl2SWlKKzU2bUlrYVdvcVdpTFdzam9uTnpvVGMrR3RyMDBDd3hJNmJUbXZa?=
 =?utf-8?B?LzQwRkdtakxhdzB1ZXpnTEl6aFVacnNweHJ0RWdQNDY3MlZYdEdhTS9RbzY1?=
 =?utf-8?B?TGhycUg3N2pvdzlyNlhwbTJCcW9YaGwvcG5jb1p1VTdvcG9uZDhHcDdjWU9F?=
 =?utf-8?B?UHpra3NQWmExblFSZTdCdUtuQnNYQ3lydFRJZ1B4dXQxUUc4ZDF6VzM2Sko3?=
 =?utf-8?B?MGRCeUV5Y2FLc1RSd0NtTnk3M05FWDZ3aENqVW9SbGJmTXAyaFhqWmFFMkpo?=
 =?utf-8?B?VTI1YzdWbW5iN3lONkdaeGNvSzQxMWVMS0dRdC9EeWRDajhyMlZvdHArVWl2?=
 =?utf-8?B?bWhlNzZjVXNrZm40MEY5Vnp3clJTQm5Cdmk1SUU0cHhCWmNiL0V3aTlyRS9H?=
 =?utf-8?B?dldQV3hFTnhaV25rbUlDR1VOd0hLTnR5NzdBV2VYbFFuWUFIeWhiZ28ramEw?=
 =?utf-8?B?VENlSHd1ZEFoekJqUVVNcW52ZlQwdDYrR2tIQXplN1ZzN3NHZlZPNTJNeUpI?=
 =?utf-8?B?TDkxb0k0aFBDR0tBN1hYTGFSbGtJQlB2S3NVbTJtYm1EV2VYdGVRRXdqTnpq?=
 =?utf-8?B?RXRDZmg3eFNaRUJWcGpsMkcyNFYwSjd5VVNkU012Uzk3TzZWa3J6UGtiR3ZF?=
 =?utf-8?B?b0p6ZHBYdXdYUWFPcU1sMzNKdXpISGp5YlpRUUk0VnU1QWtrdTRjVGNjRFlC?=
 =?utf-8?B?UE5Lakdld3hJaTdkL2xFQVRzS2NWYmhGSnpsakRpVExmUHEyazhvbHZXdHcx?=
 =?utf-8?B?Rm1kRGxON3Q0dStVK0hIMTkzdElGeUhoQzBvVEtpbG5rNHJ0TGdwWHQyUkFY?=
 =?utf-8?B?NEd3bnNoWmRLU1ZBMUpWTEt6a3AxR1o4SUtHTFdUNFh5Q1V5NnRXZFE2Uzdm?=
 =?utf-8?B?RmVoWW16MlU2V2RwL0xGQm1tWkRpTUxiU1UydWU4R3c1WjhFV0E5dWQ1UkxY?=
 =?utf-8?B?OWxucGJJUlRGR3lSMFN3QUdSRHQ4U3M2RE10dXRBYTc4T1ZUajN0YzNmWmtX?=
 =?utf-8?B?Q1hGaEQyanVCTkI3RmI1RjRycWFTQVlBM1J6RE1JUU42N2dSLzRXN05EVmlF?=
 =?utf-8?B?UVpKRDBMUE5JTnM4YjAyaDNMSVd1c05ZWUFYaFNFMWI5M01CT3hXTDRMcWVu?=
 =?utf-8?B?VkNJc0hEOWpHa3ZXNHR5Y3dNZ0RLR0laWXdGUnAxVHdXYXV5Y0xmcHpqZHdm?=
 =?utf-8?B?UGYvckw4ajd5Vjh3bThPa0tIL21LQjZyNk9OaG5uUzdVa2hFcjc0ZFM5eFJw?=
 =?utf-8?B?TDRhOUp6V3lTSUc5VWxVNTlxQ2ZOTFZWZVdJa1FmWWZWcVR4QlFvVitwTUtL?=
 =?utf-8?B?OFdTckpoNUNzWHZrNC80RVlkelBoN210MUxGTTVnMUZBTXk2Rk9EejAxdEtr?=
 =?utf-8?B?VWpDNmQ3U3NBcms2d0NOZ0xZcEVZZmJoeVFnSmxPeUVkd2VqUzBQZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93838c07-bb1d-4a17-f526-08de4e895fad
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:41:45.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpjk7Yfe9ODWRRxE7qrYRJeHAA87ngMimaEIl7kphFvnHT0aY75CHiBCWSfKYJVFUgNTiaTN1AxLx8W6LWS/UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

Recenly when test uvc gadget function I find some YUYV pixel format
720p and 1080p stream can't output normally. However, small resulution
and MJPEG format stream works fine. The first patch#1 is to fix the issue.

Patch#2 and #3 are small fix or improvement.

For patch#4: it's a workaround for a long-term issue in videobuf2. With
it, many device can work well and not solely based on the SG allocation
method.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
Xu Yang (4):
      usb: gadget: uvc: fix req_payload_size calculation
      usb: gadget: uvc: fix interval_duration calculation
      usb: gadget: uvc: improve error handling in uvcg_video_init()
      usb: gadget: uvc: retry vb2_reqbufs() with vb_vmalloc_memops if use_sg fail

 drivers/usb/gadget/function/f_uvc.c     |  4 ++++
 drivers/usb/gadget/function/uvc.h       |  3 ++-
 drivers/usb/gadget/function/uvc_queue.c | 23 +++++++++++++++++++----
 drivers/usb/gadget/function/uvc_video.c | 14 +++++++-------
 4 files changed, 32 insertions(+), 12 deletions(-)
---
base-commit: 56a512a9b4107079f68701e7d55da8507eb963d9
change-id: 20260108-uvc-gadget-fix-patch-aa5996332bb5

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>


