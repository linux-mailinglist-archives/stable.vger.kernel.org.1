Return-Path: <stable+bounces-139688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E38AA947B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02A316487A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DD02505AF;
	Mon,  5 May 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="IWHK0ISN"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012010.outbound.protection.outlook.com [52.101.71.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603C17A314;
	Mon,  5 May 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451594; cv=fail; b=hbZSW1lrhTmw72xGRGvD8lSHNFLE8FYv3PQxftv4e2dsNT9mtOeqisALyKNxZNk1bzASHxxSU3K7I0zwFvyffwf60+3r8H3RPrdUpTo18tW4JiAkO0rCEOXJk8VpJ/LWfCfm68EHKuTiv1foJ7usXwdscSWeQy8lRyRyuLCRDig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451594; c=relaxed/simple;
	bh=pB5EgZ/4Xlk7QYYwL0WvJuVM25MPYTgDLt6AN1Ka0og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RFS3muPuY7nKFJ1R8sHnvV4ZH+WBOU4P1NJNoylcHOwHBSQRJaRBkG3EcqSEzv1WzC7NFIjHlpksU8ZLZ28geGLM2KGza0ECI9tTv4EF1Wg3m7Y+v7LfKTVw/rWL73u2mfhwIDQwuBla5kX9sVPPO2ZQCs+U00xyj5XdsyBFAqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=IWHK0ISN; arc=fail smtp.client-ip=52.101.71.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0/yPyvlqUjCOtIkzEvcQ6anwS17lId1g05G/LTYduZ6v3ghGBLZDfnXE3umxTBbk+hxAeDfmypLUV4Lyhm5eRretJ9meBireSj5/fgajkEyimJQPRcxFW83MtJh4aVFw52yDmQreHP/7q2IRCwVwLF6oGFnBhrZ62CINwOv8x0mjrFNthUtfLyT+yojIP9ncwIGdwKnGvtH0sNk34y5PhvTp59autoGP1Vg7gZoQ9KSzSlgcdxUdyiDm0T4yDnaxXbybaYQkN/Ut+dHDG1ZdYW8RKKj7eraouWmSEyXQU74BH5r5DFKEC98dQ/IyNJjF+KpXiWkVv66apf/GWdgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB5EgZ/4Xlk7QYYwL0WvJuVM25MPYTgDLt6AN1Ka0og=;
 b=fBrODmwQde+6pcN+tstqLDgOLSb7RuHVpY+Q/bbEetNCZ37byL6K5SYb95W8mw333K9JxaYY764Qj95SkaYiaFqGNqgl9TXM1cQ0wxIK/9sdLOw1lfazGA1Vec2531+IAuQ32iOyL9JChFCdMnJBFKhirImpb/m0FaA+OxdAdvt+IoijVyD/P9AIJozdFOCTysI80egvN6StIncZYUxxa4FhAWXjEQm7iThMA/VsobkKr+3mmqOk4zeUkSYy5Lcs1aB5q62nM8u0YcxSH1dgLDHsXsnK3D20jJRrqFXHa2iTo2Dltl5avmsRsjSf8HRAqSyTE2c4MC/htsjpWrwCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB5EgZ/4Xlk7QYYwL0WvJuVM25MPYTgDLt6AN1Ka0og=;
 b=IWHK0ISNBafhaqE9o8+/sSQWTNy3879GeT/TLDooc5rpYkGsBRiqhPnglPZMPDdmD+mUiZHUPMNRw0Y3qoXoYqdyxB1I2AhE0gCscTFB66bUMGpqLLzkgmcMCAkkcbAsomCo7PONj8qfbmy3M+CwJgCT7C6XlWYWS71a80LD/NC1itkblbZh/IMX7gck4d+v/QHqu9No74BOcbofGGRMcfMIBqVbknB9xFcEfcWvxmvElB0g3Mz6vg3O91utMvOXPOXs+LGcomHDKK5S/gvrAgUaKhS2iTvsA6OjcHzlP8H/iKQrNVRRQmoLNl6GEXdLofi7T9az3efal/fDpJsSzg==
Received: from AM0PR07MB6196.eurprd07.prod.outlook.com (2603:10a6:208:ed::33)
 by DB9PR07MB7707.eurprd07.prod.outlook.com (2603:10a6:10:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:26:28 +0000
Received: from AM0PR07MB6196.eurprd07.prod.outlook.com
 ([fe80::7cb7:ff63:d358:1a]) by AM0PR07MB6196.eurprd07.prod.outlook.com
 ([fe80::7cb7:ff63:d358:1a%3]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 13:26:28 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>
Subject: Re: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core:
 Stop using of_property_read_bool() for non-boolean properties")
Thread-Topic: Please apply to v6.14.x commit 6eab70345799 ("ASoC: soc-core:
 Stop using of_property_read_bool() for non-boolean properties")
Thread-Index: AQHbvbOoGcwIJ5UPFEydyowymEMNyrPEArmAgAAEe4A=
Date: Mon, 5 May 2025 13:26:28 +0000
Message-ID: <0c6076ce-cdfa-4c6f-86c5-c5226ace8559@cs-soprasteria.com>
References: <7fb43b27-8e61-4f87-b28b-8c8c24eb7f75@cs-soprasteria.com>
 <2025050556-blurred-graves-b443@gregkh>
In-Reply-To: <2025050556-blurred-graves-b443@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB6196:EE_|DB9PR07MB7707:EE_
x-ms-office365-filtering-correlation-id: 3f802ea1-ee62-400b-b388-08dd8bd87119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0loWWM0a1lXZUcwN1gwd1pMdlBQTTdidkxNVTVCclB4c1hYSnNXU2lJMEpa?=
 =?utf-8?B?NXdxelZrTFhBSThtNlZMSXJSeFd2Q3pLM1VybngvbHhPSGFWMHdDQkNoMnBJ?=
 =?utf-8?B?U2ZQM2grUkpDK3hERXE1ZEZpazIwbHR1bkhVN1BqbUxnUUFaRTdlRGgxYXRt?=
 =?utf-8?B?Yk5paGxqelVVTXNCaFNUUDdyL1M3U2J0aTdoUDAzQkZmUGtCU1BPOG5aUjdV?=
 =?utf-8?B?YXNIKzJZNzNhdHJOTXlycU1vUjBKMUFrdGdtV1ltNkUzYzc5Umx2aThhQmJY?=
 =?utf-8?B?Z0tXekFpU3BBdEdvckZyNE9YR1k2eHdybFZlN2hoR1IyVXphSXFHNkxaeDFF?=
 =?utf-8?B?SjIrQ1BlR1Zza29OS2RIeDVNT3pheTRldGw3MEh1YVVEMGZXa1RwVXEweEwv?=
 =?utf-8?B?YzQvdmpqRzNQZk5uR2hSeGNzSVJjb2pSMFBQbDg2ajUzQWNvR0N4SUxGOFBp?=
 =?utf-8?B?aFMwckdrTXhKcFYxRm1YYSsrdk5xMmROY0FoYXlWVUc3Q0VLNUtEeWFhWGFZ?=
 =?utf-8?B?VU1HRXJtaGRZdXBPRURVOE51dyt6OTdTdG52VXluVXIvOWQyMTkvSG5pbVk3?=
 =?utf-8?B?YXZhamRqTVhpM3hHYk9xV1NyVFl2Rm5OelRGSGR3VzNRd0ZnT2RySk11SXNt?=
 =?utf-8?B?U2JwODc5VzdldGp1QTdUSGRyNW02ZGhxN2RjRnlSTzRjc0VLZlVYamp0czBD?=
 =?utf-8?B?NWRObG54UVFXWElVaEFsOVNOQUd0cTZMZHVRaW5ZaEVaYnhJSDl6c25MVHdE?=
 =?utf-8?B?Q0h3UVFLb1BGQ3hMVWJjamlFdXh2S25QZGk2RER1UE90ei9wdTRNRlorWE54?=
 =?utf-8?B?YVV1L1dpcTQrSnQrUmVWaWNaZ0g0S2d1MjkvY295WXlkRGJ0V0oxVW03Y0RU?=
 =?utf-8?B?czczWk9yd3VaZDRpMzNEYnoyUStiWG85UGo5MVZOUDc0QUpYeFk3WkZwdStt?=
 =?utf-8?B?WVRqV2tnMEk0S0ZjbHJQQ2M3blR3VGhCdVZHOVhHVW1FR05EV1oxMXdHZjhj?=
 =?utf-8?B?RCt2WkY3QWh4N3EzK2RtUTZBQlE3WFFpc2ZoWkdhNUNMbm41cnVOSlBEelRO?=
 =?utf-8?B?QzU3bkFVSmEzbjk2YmdtdDNVUGJCSndILzNOTHMzMmpEdTNPekRudWpBQVhL?=
 =?utf-8?B?cUVTbktkeVRxL2xjNmxzWDZuVzZSYy85ODVBYTRJTFlKRk9YZlhVUWF1ejV4?=
 =?utf-8?B?dExIQXhrdUY1cFJVMitIQ09HZndQUVFGcW4xN2RaNjd5ZzVPM3hPU3k5bmta?=
 =?utf-8?B?Vm5VS3RWU1A3MkdNd0NZckZyRXQxNzZ4SkJLbjlHYWVJdWR0VVFKRkFTOVE5?=
 =?utf-8?B?S294RDZUZnZhdzJ2eGZWOE82MXJjcTR6Mm80MlFSWkdYaW1KcjBIWDdnYmRE?=
 =?utf-8?B?K0VpKzVFN1ZqWG5nSDljRTE1UTllU1Y0c3R6M2VIRmhES2pELzA3aERqMXBo?=
 =?utf-8?B?ellpTnp4Um1MV2hRaThtSTR0bjlQMEhTcDBEK1NNLzA5S1NMOTlTWkZRcGMz?=
 =?utf-8?B?ZE9ENTE4Tm1LRkNCcTIvZnhDTjI5WnR2eGhpcHpnVEtEcDlSZ3J3UFR3VGpB?=
 =?utf-8?B?LzZBWUd2eHJRZ2xkZnhIcnY4blFKeWRLQzB3MFJNTXNQMkFrMW9leFF2aGRv?=
 =?utf-8?B?ODlKbWs0Ujh1ZHc5TDE2RHh1WGhHVFNnODRSbno2THFEM29vdWU1T1MyeU9I?=
 =?utf-8?B?UFZQZ2ljK3lhd05KbXZsMVB0QTdKcENqdWNVMHhVUTR4c2lPVmNURm16V1Rk?=
 =?utf-8?B?QTkzejFjYjJnU2Z3cVBWRFd1aDB0VkVwUS9aOUUvVnFDQzV4UkVtMmxTQVZo?=
 =?utf-8?B?K1pvZGF0YW9UUHZVZnoybUdSMCs2ZkVIQlp5S1pjRFZOT0xKSnM0djd3bjF5?=
 =?utf-8?B?aTJFV2YxNHdYeGRHaldpaXExTVQ3dUpzYkJLLzhzdE5kZ0I0V21PV3o2RHhr?=
 =?utf-8?B?NXZIUHhSZXlJRG9vUDd4b3ZjMjRUT3Foakdldy84TFg5QnhxUHplYUw3NDlk?=
 =?utf-8?B?WW42THRqczhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB6196.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUZGYUhmWjI5azJEMlVVd294Y3dQd2MxbENMUUYwZW5ab2F5K1o3YldkQVZI?=
 =?utf-8?B?SjdpalFoQmtmRjliNnVxSllsZ3pCdHN1bTZocUVkeWVyczVmOSt3MUxSdzFq?=
 =?utf-8?B?b2tmZzFsN0hkRkhYTWs4RkF2UVo1ZEg2elNQeTRZR0d5eFN4MzA4NERYdGlJ?=
 =?utf-8?B?SGhKWkx6bkhzSW5iVHVXMHRkSld2RHp1amRIVlhxelVYQXRPenVEQmlEeldX?=
 =?utf-8?B?bC9yUVYyM2p1Z2ExdGUvS2M5QlhIR1hSSXBoYm4xbzdwZm5LaHVQc3BjS1BP?=
 =?utf-8?B?Y3VWVjYwRmRwYVh3YU9VRDVPL1ZrNisxZGpoUjJSc3lOeVhydmdJUlo5ZEFi?=
 =?utf-8?B?UTM1eGJVV1lzd2NjeU5jZUFOVXluYnNkT2tWblh1Nm9MaitVeURMTytCRlcv?=
 =?utf-8?B?YTVJYjREU1R6bW9MdnpiMG1YVzZTN0lZMXBlbWt2c2lUUE5JMWF0RUdZQ3hq?=
 =?utf-8?B?MTN6U2syR0J4S1lwZGZrcjlQU3lQelBuOHNZYkpOaUFBSmhHeG9LTDhRUnZP?=
 =?utf-8?B?OG1hOGp4azBOMlNTQUZIaHlZeXBPSmxTRlVVd3NrTE1mbkxlSVFzRWdrRGpw?=
 =?utf-8?B?NjZwdmtwcDAzc1lwOU52RjhJSk9JZStPeGtnNEhDVlZFNzNzMkczSzhuM1hl?=
 =?utf-8?B?TmpTa1VvYWphVWhlY3lRMXBIMmVSbm1yWUt5Snc4ZE8vR3pHcVlER0Vza2Ew?=
 =?utf-8?B?WFE3Y1dHWVF5SUNBaXlhSHkrS3FEREF0MmthVkplaDB5TG9mNm9UU1lWekpt?=
 =?utf-8?B?NmhBQmFMdDJEVGhTb0loODBxaU9GeVROelhWNDJ5TFJza1NYbERscXowNitP?=
 =?utf-8?B?NXRJZytVbU5SVkVFZ0ZPVDNNQms4NlBZNEpjR0lMRnU3WFVvbG9KeGU3WlpU?=
 =?utf-8?B?WDJ3cTNmUTlSQ1Y1eEw2Q2U4NUxraGszWWs0WUxiOHJ6bDRMZGsxbGpudHJX?=
 =?utf-8?B?cG5LTEtjWG9PbVFVL1Q0ZzhQNDMvb0RSUWlOOUR6MHFENlUrbi85eWJ6UUVN?=
 =?utf-8?B?Sk1KR2FNOHFCU3VzWkZIejJNcVlycmJ0dGx4U2g1MEx5djU5RlBCRjNmRWRv?=
 =?utf-8?B?TE5tWngrNzRXWmpiOU5pUjR6TWkreGV6VDlzV3NISXd3dHN1TjhEVTlMSWRx?=
 =?utf-8?B?STVCaXpzWmFXT3Z3STVEeUswcWNqelBldTloYnMwODNGQWFKeTBLa21QMzZI?=
 =?utf-8?B?UWxYNHFtcDEwVitGazZnM043R1daSGVWR2dYZzZQclRTZ3RRaGpwdllnYkVa?=
 =?utf-8?B?dHc2L3dqRjQ4eDRtTk1LL1RaVnd4M3B2MG5PMmhSY056RTJidGphaDJYdUFX?=
 =?utf-8?B?amlUamRHNFE1MlVodUg0dlVFNnFtY1lZR09LWHlzcWhWMU9PVENWVk41dDBo?=
 =?utf-8?B?MFBwQ2JxSW5vWFJUZzIxcjhUaFJZYmY5eU5JUkNielMxZHlyUTBZWjkyZmpz?=
 =?utf-8?B?NGxtUlFSZTBjR0w2SVJRelJ4Y1gvcCt4Ykdxbzh6blV3VWZhWDk2QXBQdjVL?=
 =?utf-8?B?VzFuOTRKaHJCZGVrQ3Z6eGM3TkxEWjAxT0JBclk4dkZRWlhZVVo1MkVXb3ps?=
 =?utf-8?B?VlQ3YU0ycVZIbEJmd2RQUHdZQjEyN2xjZVU3V1NuTzMydzVjUmh6ajVVRHVP?=
 =?utf-8?B?Z2NxN1ZDcG5raHQxbm1pT0k2Ukl2cVlDYkl2ajZnSVpha3Q0VTFORmd3QkY1?=
 =?utf-8?B?S1FQS3NobDB3di9ZNm9DVHhQaUIrR0tQQXZkdVJQSytkaW9sN3hvMGU3UVBh?=
 =?utf-8?B?NFNCRFpMcDFzYXllQlV6YWhPMVlyZkdzVk1VUjI4THByREVOTUxUOHRFWlNT?=
 =?utf-8?B?b2RiSDh2MUhuRWRXSEo4YTdKZk9Vc3IxdG5GQXREQXZmQmh1TlFDeEliTnFZ?=
 =?utf-8?B?ZXpFWmZJK1JNQ05CS05iNUlKT09Dc09VMjNkMyt1MnRPSGxoZVVEUDdmQjBU?=
 =?utf-8?B?Vkl6bWs0T1ZxaHowMmRMZTZSeTdkZHgwU3Z1MVhyOExiYmdjRjA0bmF5NGVE?=
 =?utf-8?B?OXd4b3NxMEhyd3Z1TmFLSUU5TG0yZ0VSM1hETlVUaWVHSXE2Q1dhUmh2bGRw?=
 =?utf-8?B?eGR1R0FOYjF1UWNYbVBMcGI2Z3ROcTlQVnZLbkUwQmY4ZHpMQWd1R0h1WU1B?=
 =?utf-8?B?ckRKRjhxUTJEUlhjcmFLWGFRMS9RUkFqd08zNHRzd2I3ZURxdjhWYlpRUHJD?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC5FAB6E7A9BF4FA0960568EEFADB87@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB6196.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f802ea1-ee62-400b-b388-08dd8bd87119
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 13:26:28.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opwkJ64q/8nvazTSUeWYfWdBN8/cIF91rmL6vueMwgOXZ6KGvCLJqjJ7kkpdErAGuP9wVudwRbjqiJz2SFBP+iBIEC9PzCPmshacZZaVwtzo61x+L3JGMs58hvoZot2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7707
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB6196.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DB9PR07MB7707.eurprd07.prod.outlook.com

DQoNCkxlIDA1LzA1LzIwMjUgw6AgMTU6MTAsIEdyZWcgS3JvYWgtSGFydG1hbiBhIMOpY3JpdMKg
Og0KPiBPbiBNb24sIE1heSAwNSwgMjAyNSBhdCAxMTo0ODo0NUFNICswMDAwLCBMRVJPWSBDaHJp
c3RvcGhlIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gQ291bGQgeW91IHBsZWFzZSBhcHBseSBjb21t
aXQgNmVhYjcwMzQ1Nzk5ICgiQVNvQzogc29jLWNvcmU6IFN0b3AgdXNpbmcNCj4+IG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbCgpIGZvciBub24tYm9vbGVhbiBwcm9wZXJ0aWVzIikgdG8gdjYuMTQueCBp
biBvcmRlcg0KPj4gdG8gc2lsZW5jZSB3YXJuaW5ncyBpbnRyb2R1Y2VkIGluIHY2LjE0IGJ5IGNv
bW1pdCBjMTQxZWNjM2NlY2QgKCJvZjoNCj4+IFdhcm4gd2hlbiBvZl9wcm9wZXJ0eV9yZWFkX2Jv
b2woKSBpcyB1c2VkIG9uIG5vbi1ib29sZWFuIHByb3BlcnRpZXMiKQ0KPiANCj4gV2hhdCBhYm91
dCA2LjEyLnkgYW5kIDYuNi55IGFzIHdlbGw/ICBJdCdzIGluIHRoZSBmb2xsb3dpbmcgcmVsZWFz
ZWQNCj4ga2VybmVsczoNCj4gCTYuNi44NCA2LjEyLjIwIDYuMTMuOCA2LjE0DQo+IA0KDQpBaCAh
IGl0IGhhcyBiZWVuIGFwcGxpZWQgdG8gc3RhYmxlIHZlcnNpb25zIGFsbHRob3VnaCBpdCBkb2Vz
bid0IGNhcnJ5IGEgDQpGaXhlczogdGFnLg0KDQpTbyB5ZXMgdGhlICdmaXgnIHRvIEFTb0Mgc2hv
dWxkIHRoZW4gYmUgYXBwbGllZCBhcyB3ZWxsIHRvIHN0YWJsZSANCnZlcnNpb25zIHRvIGF2b2lk
IHRoZSB3YXJuaW5nLg0KDQpOb3RlIHRoYXQgaXQgZG9lc24ndCBjaGVycnktcGljayBjbGVhbmx5
IHRvIDYuNi44NCwgeW91J2xsIGZpcnN0IG5lZWQgDQpjb21taXQgNjlkZDE1YThlZjBhICgiQVNv
QzogVXNlIG9mX3Byb3BlcnR5X3JlYWRfYm9vbCgpIikNCg0KQ2hyaXN0b3BoZQ0K

