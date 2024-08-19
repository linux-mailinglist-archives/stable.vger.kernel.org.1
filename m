Return-Path: <stable+bounces-69605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7624956EAF
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AF7B23F0E
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7353D0A9;
	Mon, 19 Aug 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BkZrr26T"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD23BBCC;
	Mon, 19 Aug 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081098; cv=fail; b=auKHbITIKihJevUA+EUwi+z9PJwlvtS0yHMeKrKa6/fEdhsNk0Vh+oHrUSN1YVbHDYK+UsJ6DDPv2H99+o/ER069+yVru0lAWT4kaILQXROs6H0qRkxcXSU2WbQAZPriCe59o1MGQonfM6LOGQPhT0BiZic/1KVxb1RThVmB6vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081098; c=relaxed/simple;
	bh=xT4oMXROmCJPMAK8gQLpWoP77+vk++yOYNZ8UKrjpF0=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=LCvSC8eEytXdHosaWNyrvsV2+hKIly12B2v2MiEuSJiY05LpI9rhCW78iEYaonkPJFZQyAyWzVXSlwiVPGfi9z0GH0OueyxVKrE2L13CYQ7v9YJSsw1AEm8+PakNcp+anWEyGAA/PR5yJWTgXGJhmGfNnjuybQbWpLhTwNIDhYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BkZrr26T; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNZlvXiK0+plnM9e7q/2R7VFslK5oorrbP/9dGGaP0CTMBnmml5k8EpJJXA8RzWxigFTnWTgVnNxH+jXUWucvfvsFAnK4Fp1k6QfHzwHnQwo2QJQrqoy7ufE5BCktFAW4+MzO/kqF5xzosbTWhOz1TK/GiYOMr/CR8zF0OIuUCOxI+D4sIQCcNavjuNunGmBLQyYxlsga7W14+b7LEObi0kBGF9GU/xfgX+z3UWZiyFAQ96sGhkfStO6IUMXUS80UARz6BVjpZaFjeGQzjrOEzBFUWZQBvoftuhXXyZsOULIKX0cNZsk3TanEAceaOOkTftznZE5Y8KzDoCBYArNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlMzO7tYNc/Z28oizVFpyU4Aj72vP543gy7yQsCl2e8=;
 b=NrenKIKQwE2hDJlw4TinWChEyJASwed3pvmJZc9wRSFPhGrvtdSZXEwcUqpPV4uuFX1EEcz5GHjayxDNQM8ES8sXHD4eI5JnP2vPw1EI5/0ADAKsgBUgs4dGNNyqbf/gLY1b4QKq6tid2Xe5xY+Tf+nUzUKoZ/u97uoVP/R4TBRiphRBvqGFeZ22TmV1+orzd7oTGBAdRjd2gFIpXB3BWYr6TcYLbtYrmJ9XTC2nHSaCbsAMv4wpk/72wOaO3zhfkPInV1thM6KomkDpp5R8JWwHA1CM75/yTzmYoC3zhcQ8coRcMG2Mh9QyFWA0wALU7DGJtUkFCcE6Fr5BBxMb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlMzO7tYNc/Z28oizVFpyU4Aj72vP543gy7yQsCl2e8=;
 b=BkZrr26TfzoZbM43jzX2gRE7YW+TwpuZuPk8zLQmspIUr/JJIgV7FjpEfAkwg229+RJ0/Hl0ZUyvEuLEkym+jqH6rSMzAcbFFO3rPoktEooZNvfOverOwwC4CBUB0Xq3AVeHTtgmAZzY8dN6f4GAuRu2GUSd4tGDBl/wZNQqgAHUAcO8brJSZq29WhJ6gWuS3n6FNvoo+Glykg3dwhDFq1jBrsKxlGgwi/ze/QAG0r+DBrcxslrad+pdy1MezPje2xgX8jecivaIB+lFcOOwgwk0j6NASG7YBjJnclX/d6xQNXeETYUgEbvtK4nuvppAx4yuNVPyqqX20yfabu5RAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 15:24:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:24:54 +0000
Message-ID: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
Date: Mon, 19 Aug 2024 17:24:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] remoteproc: k3-r5: Fix error handling when power-up failed
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-remoteproc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Apurva Nandan <a-nandan@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: d233b758-e25f-4472-a004-08dcc063137b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkJSV1FKV2IvM3M4MU9wWTRnVmFlbnFobGt3c3IxbkpmaUp3SnNoR0JyK3FF?=
 =?utf-8?B?ejVhWTZyM282T3BGeEV4Z3haNXlITjcwaEhBTDVmeEYvY2Q3cU55cHNlK0Y1?=
 =?utf-8?B?V0VzSG9WeVYyZzhwWWxtSDJ6TFFIVzJXY3FDZjJnb1FMNXNRbXdqT3FocHNJ?=
 =?utf-8?B?QjlENWxYdCtySVJOZ0xKUHgrdUVheEZWelpkdE5HRGRXcUxFZ1JTTkxZcXFF?=
 =?utf-8?B?d25RdWZtK3NNSFY2RXhSOUoyd3YrcVpQRFA1VTNvNkl2eVlVY3pqeThLN0dO?=
 =?utf-8?B?WGdBNkkydjE2SENaTy8xRVVYdHZKRjVRYmlOZjBBbEpYajdCd3JZWXdXZ010?=
 =?utf-8?B?RlFsbGxxUXBlN3JFWThhd2s4dnptYmNRN3IxcFczcGpmeTNoVmU4S1IvazJB?=
 =?utf-8?B?WUFtNVJiNkdCNmc4ZGdWbXJjeXY2OEVhbXlEc0VGSTN3S2F1UDBER3NIdHQz?=
 =?utf-8?B?KzR5dnBtR0R1YmNQRm00cDVvWXMzWnVoL29UN0RwS1VwbDYvUGlqUkpSUnJx?=
 =?utf-8?B?TkIwWUdEM0c5UU9KOTd1TnRkVldDR01ic0ltTjRyTVk1SVdsY29nNytxS3R6?=
 =?utf-8?B?OGJudFBvb0ZsY3ZnMmpoenhKUGVHT21nYXdYcEZBTitQbUwyNGRpZ0QrZTdk?=
 =?utf-8?B?eWZMNTk4RGswOWpuTXZoWUdlT2xMK0tjVXJVWE1tamI2b2ZuTWxOczQvZTZh?=
 =?utf-8?B?LzBqNHBRMGE3dnlxeDJNcEFlZ3QyUitlbmV5ZW5oK0hEamc0TlI3eUNXMi9l?=
 =?utf-8?B?Y3ZxV1J2MlpyZGZRTkNITCtEUXRmT0dMY2FNaTA4N3c1L3d3ZDNWbUhVcndt?=
 =?utf-8?B?Mk5Eaktud090dElBZFZTeTBUQXg2OHFwQjRzMm1pMWhjZDR2SVFoakNQeFVa?=
 =?utf-8?B?dGt6cGE1OHNFNWdjQ2Nsd0FIcVlRd0EzSjB1VmtlU3NiRTU5eHBKb0RCQ0lQ?=
 =?utf-8?B?WGdhcytBT1B0SmxINHo1Vk5mWnB4WndQRldqdFI0M01ua3Jkc3owVGhzMW1y?=
 =?utf-8?B?bzRkRlFnamxyMGVHUXppUXpHejh1bHg1Y0EwVThNOU9TdG8wOGxMN0xCZnZO?=
 =?utf-8?B?aFVXYmtLQjU3Sms0RWFCZ1EzM3RDcWlFSEZQMDZoY29ndExXQjZYdlh5dVRD?=
 =?utf-8?B?ZEUxOTN3QmpzZWRhSGgrNmJOVzNGdkhNbnc3bzRuVFA1RTN4cytuVWtwbFhS?=
 =?utf-8?B?c1RPb0thNEN2SUpNaytYL0NKQWY1SVRQYWZ6cFREMHhVbDNNWTR3VHdkSWVi?=
 =?utf-8?B?NEhiR3pxMmV1NTdMWFJtbFlUQ3NOWG0wdnphcTVNdmlKRUFEeVRZdnJVNWpl?=
 =?utf-8?B?M2s4Q3JBY2NLQWVhQnVVd0pHSFJNbytjTERySDFxb1l2VE1IeXJRYlNRTEJT?=
 =?utf-8?B?RC9FeW1lOG1BbFd5VGl1UlZNK29YUTM3YnJONlBHdXpKak1RbmtKMC9MQTJm?=
 =?utf-8?B?elNvN0NnYTdzLy9BdGhzZXZLOTlYRVpCUk5lbnA0b1lBY1dZSDZ1Q3NqcFZz?=
 =?utf-8?B?TzZxUGNpczFoNVhjS1BMTFJWUlJPTlZBZ240L05ST3BOTzFIVFYvd3MzNmdI?=
 =?utf-8?B?Q0JObU1NWFo3UmlNSXVXZ0plNmdva1RSektHMVpQYitlWnpsa2xhb3AxdElE?=
 =?utf-8?B?aDQxcVlZVnpNLzFNSDV1bmFvaTArSVRLMFlnQVdIZjVVRnBiTHJWT1hBeGFz?=
 =?utf-8?B?cDZkZ1ZrcDNlNS85NkdxWjNQUWRzODVEU1lnODJUVW41TWZ3MDZSZGsyRVZN?=
 =?utf-8?B?UUFiNmlnOGhXRVg4VmFiUzBhb1MwaHp3TFpDYWwyWVVRZ2w1WU1PalROem9J?=
 =?utf-8?B?RXlLc0FCbkQzSWFrSHB1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUFUMDlvTktVU1JRTVJMeFFlcVdmaHVqUER3Sis5YUVMdzJ1TGFQejVGczdy?=
 =?utf-8?B?ZE5udlFSby9kVkEyaWh6YkFha05tWkxOeU9xTXU3c256cU84bGs5NUJ1Vm95?=
 =?utf-8?B?ZVV2dzU0WCsyRENMQnYxbmN2bHFMTTIxdDRCbHEzUFJETFh4dlc0OEMvOFlm?=
 =?utf-8?B?RVBVbnhHTnVaSEtBT09FcGJNMFd2MWFMWWF6V0t2QnRMbDNCL2dmYVlFdkdQ?=
 =?utf-8?B?emo1QUFWWDBRbU4rOWkzNnJRaG9rbnVwS2ZPMVl2alFkaW5YSlpkZ21NOUF4?=
 =?utf-8?B?bTNMTkJldGtXOFkwRmZSZUdSOVc0RWh0a3BJYk5ZWU1CY3hvaVZUNkYyVWtM?=
 =?utf-8?B?eG9lM0pDLzBKTW1jVFUyYzFFcWt6QnhvOVZBVml2UXE3cFp3TnhvamVOMStE?=
 =?utf-8?B?Ykh5K29zRWN1aDd6S3VoUXFZZGFobEFjWnhHZ1paTkRrUkp5dDZUeXRUL25K?=
 =?utf-8?B?NmNKbDlibXZuU2QxZ3lnNEZJaG5ySTFuc3FnVGI0MGNsREladS9UN0pIUE1X?=
 =?utf-8?B?T0VaNDhURndmNThrRVRYRll0aVI5V0tBaDdBS3RhOXE3K0pjWmFzOVhVdkFZ?=
 =?utf-8?B?TG5ZQUN0WHFsbVdnUFIvSzZ0MVYwQ1lpV052ZHJWdnhrWldUeFB3RHBLTzFt?=
 =?utf-8?B?MFZMaXduZHZMdVBVMWtpbGRGVVV1SjBlODBXbkFCR3lwMTBzMDVwcklqNkFH?=
 =?utf-8?B?dS9MQ2x5ckNzZkpJUkI1akI5WTF6Y3hDU2hwLzEzVDRhSndHUHJtbXVwdytv?=
 =?utf-8?B?Q2FuK3lNY1RQM0hNT1Frd3lmMGhUSGQrZzZ2SmtsQk50VUJXUE4zaEVEaEE1?=
 =?utf-8?B?OFNJbTBTRFNIdzc3NUovR3Eyb2VrRkNyOG16cjBZVks5dFJ2Q1NmZmE3TWVK?=
 =?utf-8?B?QlVLQWcrck9xVnFTanB3VXVYbHlqSk1odjYrUW5ROGcyYjFESjdiVHlXcHhL?=
 =?utf-8?B?Nko2R3pwOEJ0U2srSm45Yy92Y204NldncU8yOTY0aHBsbDF6Wi9WL0NqNnZk?=
 =?utf-8?B?WjdiL0JQSi92MjdKQUs5NkcrTTkrS0VtSjdqN2c3elY5cnJ4Umt0djVxVTBt?=
 =?utf-8?B?SWhCcmRoK2hsMU1PcUtMS08vbC9rdnhxSkFtUGZ4TkFVTTZQYmZVTTB5MEo1?=
 =?utf-8?B?Yk1tNjRHVy9DcFEzaEtGdG5idTB1cGxSbVBpQ3dWSE9QT0duTmZaRFdQSnpK?=
 =?utf-8?B?TGNET1hqL0l0SlRCdHhQTjE2TnBTMXdyVXVPM21IaFF1NGk3ZzhVYndMczVv?=
 =?utf-8?B?SUd4SlRadkV3c0lYYlJXRGhrUlFRNmR1clNSZlpDbWNpdVdBeFNaUWhKd2ZP?=
 =?utf-8?B?TEg2TFh0NXRvUXhOOHIzVzhvdDJrL1djUDQ4UVRVeHdPTjZUVkVEVC9jcjFO?=
 =?utf-8?B?RjdaMS9lSDA4K1NERXM3SVp5RURnbkx5MGZLZStXUjVSSnhWeS8rTlQ4ZGhT?=
 =?utf-8?B?WWxmUTFXcFZJRCswUmFZU0VYeERDTWhuNWpJaFhmRUhMMndGQ1Z5RjN5U3A1?=
 =?utf-8?B?Wno5S2xtOWJYcW9nZVIzczZiY2tkZU5QcnFuWnpxcm9EeTJ0VStha3F5SytZ?=
 =?utf-8?B?WmpXWVYzRm5GeGVFOWZibGxwTTU0MEduSlNiVHhFV3FnQXppYUt5dHpBUGtl?=
 =?utf-8?B?d2NuSjRWSkFqdStNRGYvNTdraXUydWxFYUhycG5rS3ovS3VDVlRPbUQ1aHBh?=
 =?utf-8?B?SWVoZDhWL2xDZG1vWDQyMVBWeEt1L0dPQW1rblYyOTl6OWVWS1NtSGY0dmZN?=
 =?utf-8?B?S0QxNWdpdGIvclNBN1o3OHZlbllNR25ZODVVK09jNGVxQmxZQXRlU0xGRjQ4?=
 =?utf-8?B?eGlqOTBwcS9BTkxSSE9qdDJVWjlpbzBHVnkyS2RLdldzbXFyMlNwMjZkTzE0?=
 =?utf-8?B?RlNHVVNaZjYrVGZIYlBJVDlaUHVEVUsvVVB1SS9VcUYweXluaE5MMWpEUFNO?=
 =?utf-8?B?SW5Od2NueEhvaDBkTTR0QVFhM2h3Z0N1czRWb0o5N2Z5M1BaUytiRVkwaFpp?=
 =?utf-8?B?aDRNa2ZuUG9CSzFaQmQvUlhXdDFRMWo3NWUvSkNrVHA3YjcrZUozcjNzVVRK?=
 =?utf-8?B?bzJaa0hJTytXS0lwSmN2UmFqbVI4bHdXdmUzeFMyWjJWR3EvekIrY28wOG5k?=
 =?utf-8?B?dkxuVVFMcVp5YTNpZFhFb0NEZm5mWi9XS0w0dFAyUHNaclhpSU9WbUxCYmo3?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d233b758-e25f-4472-a004-08dcc063137b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:24:54.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsvQI+Sb6PAmCvE3pQ0ymxcfIo4gzYcPbzDn/yLeNlJEt0+cmcgE86Ww8ayxOAO0V2ObL8Y9CQSkEW6KDLiZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5662

From: Jan Kiszka <jan.kiszka@siemens.com>

By simply bailing out, the driver was violating its rule and internal
assumptions that either both or no rproc should be initialized. E.g.,
this could cause the first core to be available but not the second one,
leading to crashes on its shutdown later on while trying to dereference
that second instance.

Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 39a47540c590..eb09d2e9b32a 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 			dev_err(dev,
 				"Timed out waiting for %s core to power up!\n",
 				rproc->name);
-			return ret;
+			goto err_powerup;
 		}
 	}
 
@@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		}
 	}
 
+err_powerup:
 	rproc_del(rproc);
 err_add:
 	k3_r5_reserved_mem_exit(kproc);
-- 
2.43.0

