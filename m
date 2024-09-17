Return-Path: <stable+bounces-76562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4197ACD2
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566331F22944
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62A15535A;
	Tue, 17 Sep 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h7MQeVni"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C22905;
	Tue, 17 Sep 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726561529; cv=fail; b=tJVJxvV9Os+q4D2fKRUlW8dFzKPZ4drbPmssNfrrUiURgfp9R+7/4A5GyFemCedtpIjqqGW5yMbW8kn/UEjHIcWzRjB7nfLrZ+9iWJXrpvhaV/yHLXrKfXE3Z7yEL9umcGHVRnVas2fDUj8SRl+tCxc2/im8lcKIjU07X4o+Pzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726561529; c=relaxed/simple;
	bh=SPfMYJ3HiR3koxHbTSXiIeXz6+uunuF7uklZLLfcpks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5N35QF+POjw2dkXzDSrVtwFmnMYApp0OE83N5gFX+wICyxqpvo4LfnWlu2OOq4/AoBbA6NGSVdHfR4wahTSuAYQSNR/mH9LyY9qOybcD095ihTSHPv5J5JhL7GSRXjMgaPnsiosPqBX0W2HkfrvIws+dGalJ5sItaJCAlJMGGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h7MQeVni; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGaGPjLVPNk27Yxi2DGnUfD/fDPdoJrjxLK7UMiCv3YVGYy1cCzPrd0Nyb4daubDGTZHbMan5ae1IbA1330H03SHZwL1YKfD7uHiNgaomAZ3d9WTrBaHhUghBDKZTU/KD8UHlxQy9Mu58bWMHPgHl58iptN/7nVKq0Nl24lh9TQkYJ91qjxKYMQXHF99SBhDjqt3fD41ZL+1iXsnulLNQAP07T5hWUjNGc7DL1Yd8CEYcMQuRwGqx5hFDmg45h3noKZe9oInKaQwpXiMjpqwID5/Y55zbsK3WUisZ4XpIvuDHRf1vb9NtBJ0cshbQcOiFBQ0LwzHQSSDoTsbNDzhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPfMYJ3HiR3koxHbTSXiIeXz6+uunuF7uklZLLfcpks=;
 b=W5JM+QwsWh1bCAz++MSYpRqDF14k31A9zzn6dLxg8m7VlO911YkJ2C7kx116Lmx5g3LM9wHjCpGP1zSVOfX3P/JV41EpE2rrg6FAj3UsTfiMSLIV+7k3l4bBL4N08BW3FZVnbzk0HwIrSVuGfQQZa3K2/MEIZniIuYhpXb9cXuX815xPlRjyISrAxaG7Aot3HwBrhhBmjPl2XwWuVPmVuadEcXxQT8t6dyjQQ0Fz06WEswyFPgdMo+vAMo1cH2ohnag5HAwuh7vRBxxlz2V24+ELVUF5zz31aa9lyvsk0mlyFreKSb7vPdquwDGr148QV7Zl0KD6xvPHXJuY7EQT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPfMYJ3HiR3koxHbTSXiIeXz6+uunuF7uklZLLfcpks=;
 b=h7MQeVnizbtIiUFS5O8ijjn9hAetDl+ytrS8gfrYcpUX1tIv0noQTRRG1l/2gjgJZ/ZUu9fnPjrMMWtN8gufGHoY0+G2YmCWv2CWQ653u3/RGiMdjKxc3wmNqg20bvtQd2Xac7KiRSEys/3BcGsDfGUxXl8QR9Lo92oHpY4ETRzZNYWqbpRqS73DAq9TMb3fF91RSdFpNFvaGk8oWam9a1J9rnGppcREK8OcCwqDmQgE241/TWH1l5/PCaWGLYQw/iiwTZFBIqkt18izXWwVT6rPiuyLu36Qnm1KJe6iJpEWYg7HVNamhjthVSirdaPe9ivGOvTUiJcbpoYdSQ4kEQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA1PR10MB8405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 08:25:19 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 08:25:19 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "gur.stavi@huawei.com" <gur.stavi@huawei.com>
CC: "Mark-MC.Lee@mediatek.com" <Mark-MC.Lee@mediatek.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>, "dqfext@gmail.com"
	<dqfext@gmail.com>, "nbd@nbd.name" <nbd@nbd.name>, "davem@davemloft.net"
	<davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "arinc.unal@arinc9.com"
	<arinc.unal@arinc9.com>, "edumazet@google.com" <edumazet@google.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "razor@blackwall.org"
	<razor@blackwall.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "roopa@nvidia.com"
	<roopa@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"sean.wang@mediatek.com" <sean.wang@mediatek.com>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Topic: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Index: AQHbA4Hagboir6ZjOEqxQ/L/+DWWZ7JbqzoAgAAEBAA=
Date: Tue, 17 Sep 2024 08:25:19 +0000
Message-ID: <c7a52a818c1ae49ad7e44bb82fcea53d7f53d6e0.camel@siemens.com>
References: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
	 <20240917081056.1644806-1-gur.stavi@huawei.com>
In-Reply-To: <20240917081056.1644806-1-gur.stavi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA1PR10MB8405:EE_
x-ms-office365-filtering-correlation-id: 5ab360c2-e538-411c-2ec8-08dcd6f24417
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGg2WXJBTVdtT1Fub0ozWWlFWkN2R2czZ0dpeWpZMmlacWhScG02di9xSjAx?=
 =?utf-8?B?RmtCUzU5Z1R6SGZaVGw1Rkc0ei9oN3dXZlJMZ29xbVpHbUQrbHRENlQyTWNR?=
 =?utf-8?B?VVVvU1RITHhqUll2aU82NkowcEVlaGlIMWxUWlhkMGRuY0RLR3QrbDc4VHpJ?=
 =?utf-8?B?SW1hL1RVbXlFSXVTV0E3dFEzVnpIczVmdHFob2tBcHRVbVZaYmtDbjhET2ZE?=
 =?utf-8?B?RExiYWxOcWk3TmxlWURraWhEd3JZTm9YMWFnN0syaERmNHVlNTh4UUluVjEz?=
 =?utf-8?B?STJmbGlFeXp6MmpJU2JrQjg2YVhRK1k4b1dUSU9zOGt4azJqQUVFM1dDSUN1?=
 =?utf-8?B?UjlacERzL0hwZmYxNXVObVBaYXJBM3FBdXRCVDBLUWFqOElEYVg1S1BzeTh6?=
 =?utf-8?B?cVdYZVBkYWljLzBVeVJpcjlKYUhWR2ZINlpSdmpmNk41c3RZZEJ2aWZ4dy84?=
 =?utf-8?B?UENhZ2U4V3F2VlRBT1JnRUQ1djFrWXQxbmRrc1VjNGd5dmd0eUJ0WStLUFZa?=
 =?utf-8?B?aCtEZEpZbmdvWHpHRTkyWEY3RHNzUFY5N2g0K0VQTS9VUkEyb1FHSHpYV255?=
 =?utf-8?B?UjhNY1B1NDJNZmRhcWZmbWhocHJoUmlXKzhGZTVGenprMk43d2JHekZOMWFz?=
 =?utf-8?B?TWhBRmhvQWNoYU1OMS92SlhsZk4vWVpCRmQ3QnBsQ1FlTy9Jd3JSSitOMksz?=
 =?utf-8?B?bmxYUDNtOXdvYnZza0pRSjNLREVhN0NpaUFjalF3NTlubzNrczNNQVdrbTJk?=
 =?utf-8?B?S0xWR2lGNyt4TGhrV0FwUlh3aWExdHh5ZDBrdGVLdkgyUVVlekt2UVdmclox?=
 =?utf-8?B?eFpibHhrYkpwT3Jrd2k3Z1hMK0JwQWFSQ3V5a0UwR1R1cWxMVm5Gc0F6Uy9R?=
 =?utf-8?B?RzlQLzNXanpsc3c5Ris2ZHBPNCtlNkp2QnBZZTkyQWg0WkpwZnQ1eE9KdXpq?=
 =?utf-8?B?UFRzVTByTGk1VDNYMWNSazh3V1V4SDQvQ0hBbUNsUWgycm1mNmRpT1c3TGVB?=
 =?utf-8?B?ZVJxSlNTVElPWVNPZ1dsLzlvNnZQVFRrZzJ3eWhCL053bWU3ZEZkN1JMck5p?=
 =?utf-8?B?eFNETGZQZU5lbndzd0xjSVRtZFNkSk93OXhMYmd2YlZWUkoyY3RWcXFCV3ZG?=
 =?utf-8?B?Nkh3bkNVWEYydXUxQ1VsOEdMNnVrNldSMUtoUEdaaUdHMWt0T3JSNGpnN1Zy?=
 =?utf-8?B?QmdnVE4zWG1FZ0x2Z0tWeVA0U3Z3blQzVzhxcVFHelp1N3JKcDhXUUIxRlRa?=
 =?utf-8?B?dGlsSmNpbCtzaW9veFhBdFI3SHpVbnlUc0tFYzJlOEJUSjd0b0JCS29XQ0RZ?=
 =?utf-8?B?ZWl1VnVSQ1J6Z1Juc0E5MFZ4emFCbnE0Wkw1OUMzN3JZQURpZlpPODBIbURv?=
 =?utf-8?B?WmRmSlNYTUYvVzg4K0J3dUc2eWg0U2dFQVlhMnFGN0pETTFsNVhZaGFvQjh3?=
 =?utf-8?B?NU1ySU1uRjEzRWNjY0lEc3lzT0kzWXRaaVpxeFZMSllwQ014V2VHZ1dMTElM?=
 =?utf-8?B?Nm5oSlJGREVuV2NrbCt5bzVoVHphR001Y2g0ekJTeUNkMjZXWmt0ajVQVncv?=
 =?utf-8?B?R0FLZ2ZWNXhRU244YTFqZk1JZU1YZTltckxSVVk2ZXNRNFB2MGpLYTZQNFo5?=
 =?utf-8?B?bWRtcG15K1BvM2hEalFVR1c5amZNMGpXSzJIeVdpTVdoWXJYVzJjTnhlNldM?=
 =?utf-8?B?akZYalZBWUxPa25UUi8rZnEzZ3FaR3l4d3pyY3FHQnc4cHM4bkJDOUNYUm1I?=
 =?utf-8?B?S3hBMVBrbGxKaENacmFabFdaNnNxTFNYTTNzTkNRaHlPQ2V2MEtyeDY3ckl6?=
 =?utf-8?Q?HxiPSU9lnLTQnfhXOFJnwvLmdWnsR+nB4hedE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEJLZ2tBcnN5b0s0VVd6WVNrRTRFVmNnRXY0SHVhRTJ5T21NdENPN3d5cFZr?=
 =?utf-8?B?TmVhenNUL2VyNUJIL3NTdzM0NHNGeXlCZFRRczZMc2RDTG9oQzJsVTBVb2lm?=
 =?utf-8?B?VHR4YVdJUHJMVE00eUdrV2pOcVJCZkMxaGNLRFd5cjdkQ2Y2cUtFbW0rbFd6?=
 =?utf-8?B?OXhXZUlLc2RwemY4aGh1aHIybm50QWRlT2haNERDUDU1dllrL0ZaRmZRMFVP?=
 =?utf-8?B?eVF2ZmVsZnlIZkZNQTZVZ0hiNk9kSXJ4bEdFZHBaekdGaklsK21IVjNEYVpQ?=
 =?utf-8?B?OHB2d2dLM2RYak5Kay83YXFYVlR3UVFlallnVjYxUmRZMU9qWEdhKytvTUYr?=
 =?utf-8?B?ZGxHekN3WEVDOEo2bTQ3cmNCdVVyU05KRjZPSW5oa3RhWExzTVBnRFhpc2l3?=
 =?utf-8?B?dVF4cHZxRVBhdzNSUzVmUVMyTjJJbDZWQzVTY3NmNUpUN1ZVbUxMLy96Qkty?=
 =?utf-8?B?Qm5wZXR3Um51VkR4dU8rWnpnd2o2dXRpWkpMWXZ1M201RCtsdWllYW9PaE1T?=
 =?utf-8?B?ZFY5ZnAzaVdRekdoYXZjQnhIckcwWFYxTjdkb3loM05xMHNhMVZ1ZjR1bkUz?=
 =?utf-8?B?dXFnWDVrdjE4V2VZRGZkRGlzelpJcGtmL2dCa1duVTZ4aTdwQ2duTTV6YkhJ?=
 =?utf-8?B?d092VFVpcVdLaG9TMmE0S0VoemkrWmNvWWd3Nmcyb1BCTzdZMnNnQnhCNDgz?=
 =?utf-8?B?OU43b3FMSFNvOUxJUnJZNWlFc1RrWXVSYVk2OHlBZFM5MTdFWEhqek9YbDdM?=
 =?utf-8?B?V2ZIMVFBeTY1aGpWUm5TZDBKU2xYc3B1K3pBdS9aazhXUXdRYWRFSVpiYkJi?=
 =?utf-8?B?cDhxR0F2M21wR0I4d1AxdzRNVC9IWGtzNzNxRk5OQ1I4L2MwV3lDMHlqVDZC?=
 =?utf-8?B?b01QZ2hJb25QVEtJNENMdk0xMnNqTXhobHl0MzdHM0JBbTY2TTRXdEJya25I?=
 =?utf-8?B?eTlMM2k0eGhjL1ZuUjB3UEloQVNWTVJudDJ5Z2tUZlFKMk10VllSZVkrVzg2?=
 =?utf-8?B?ZmpuTkpOMkVCOWdUcnMrSlVCSDBxeFJqbTVuQmVFWmVSZ1JGT1FDbFlKdkp3?=
 =?utf-8?B?bVEyN2RlT1NydVhGTlhpZmlvbU5VcnRmK2F2U3lyekdLMnFhMVd0OGR4Sm5o?=
 =?utf-8?B?QlVhM3VJd2daUzhERUhKWkppdStTZzVWakExdjVIRXB3NU5UWVdxbmJEL1JV?=
 =?utf-8?B?ZGM1Z0VwMVpZRlMreWx3ejdSbmJISkFUY3pNM2dLb2l6NzFQUFlObm9QSWRI?=
 =?utf-8?B?Mmh3TWNyV0Z2NWcvTVNSUmllcWViZVR6Njd3bmtkUUxMbjhrU2gwYnVweG5C?=
 =?utf-8?B?QTNFdHhHeGx0d1dqWmdVTVdQcUtOcFU5S1RjWC9ua2NwM3c4U3NqWHNyZVAz?=
 =?utf-8?B?a1ZwUit4MWlrQkJIVmVRdjNGMmRKK0R2enI0QXNQdHZZenNsTHVYL21makh6?=
 =?utf-8?B?QlVnWWVhSGZOZ3p3czkzSXc2elM1ODN2d05lM0Vvc1VDdEsyVFQ0Z3NxNlVG?=
 =?utf-8?B?YWMxLy9Yd1VvWmNKRFZuY3NwbTNvZVl1NnVWNlBzaXRMN1NTNXBZd2xQSGw0?=
 =?utf-8?B?MmxBbWhsZGVib05HSlowVDJDV0o0NzArRUtCTUFWOVdJeDFjYWQwMFR4RTM4?=
 =?utf-8?B?L205YjZoZmlZNjZ6ZkxYTExmZERxR2xPVGpYeUQwdHpHbjVhOTVzR2Q3UVJS?=
 =?utf-8?B?N2dSTnBZWTB1cmhnRmJZWGJ2OGQ4bjJkNWlhODV0eWsxRkY3WVBFTjdxR1lp?=
 =?utf-8?B?V2Uvdk9TQTVVY3E4Q2tDZVRhZENiWnlPdDZwZ3BVaGJ0Rkx4MnVQcEpZNnFa?=
 =?utf-8?B?VWxLZlhYZGxLN0lnZjNQWW9sYmlGK1k4OWFaejRJWm4vQk1IcVI0MXRFRnN4?=
 =?utf-8?B?a09NTmJYeTh4R2dyRWhKSmoxTG9ScTcwZnR6ampKVVhFZ0Y0U0UwM2hiK0Mr?=
 =?utf-8?B?TjlEaGEyZ2JzT0twL2ozaXJaT0pJSkJUS3Y1SGxCYWZxRmY4M2V6dlArd0M1?=
 =?utf-8?B?MzVna0lmZXkxUkQ5R3RIZllKVHdmSmpGWFA2S0NGdG9YK3RZWDQ3bTBmaWN0?=
 =?utf-8?B?Mlo2QkNkNy9HZ2QwSm5MdndNZWZLd01nSjB5dXhvTS9uY092VTQza1B0UHFj?=
 =?utf-8?B?TFlOaEl4bm5TYmNWMVBUQVh4RWxDLzV2WWY2MFk5d2p1Q3hVRkFySi9HN0ZB?=
 =?utf-8?Q?W8VfG4zcj9UaCmf6IlFCNc4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98FE272977A60E499939FEC4C01E656E@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab360c2-e538-411c-2ec8-08dcd6f24417
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 08:25:19.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k85K+62/mNKuKQbNx/Q/uKBb/UlQIpECL0Q30IPMd2Hdi4Rxwr3VNlJ3yUEzBC5yrzuh5/vdChLgo7ixoXrt7P8LCxQhAMOr0t2GMwGKt1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8405

SGVsbG8gR3VyIQ0KDQpPbiBUdWUsIDIwMjQtMDktMTcgYXQgMTE6MTAgKzAzMDAsIEd1ciBTdGF2
aSB3cm90ZToNCj4gPiBAQCAtMTU5NCwxMCArMTU5MiwxMSBAQCB2b2lkIGRzYV9zd2l0Y2hfc2h1
dGRvd24oc3RydWN0IGRzYV9zd2l0Y2ggKmRzKQ0KPiA+IMKgwqAJfQ0KPiA+IA0KPiA+IMKgwqAJ
LyogRGlzY29ubmVjdCBmcm9tIGZ1cnRoZXIgbmV0ZGV2aWNlIG5vdGlmaWVycyBvbiB0aGUgY29u
ZHVpdCwNCj4gPiAtCSAqIHNpbmNlIG5ldGRldl91c2VzX2RzYSgpIHdpbGwgbm93IHJldHVybiBm
YWxzZS4NCj4gPiArCSAqIGZyb20gbm93IG9uLCBuZXRkZXZfdXNlc19kc2FfY3VycmVudGx5KCkg
d2lsbCByZXR1cm4gZmFsc2UuDQo+ID4gwqDCoAkgKi8NCj4gPiDCoMKgCWRzYV9zd2l0Y2hfZm9y
X2VhY2hfY3B1X3BvcnQoZHAsIGRzKQ0KPiA+IC0JCWRwLT5jb25kdWl0LT5kc2FfcHRyID0gTlVM
TDsNCj4gPiArCQlyY3VfYXNzaWduX3BvaW50ZXIoZHAtPmNvbmR1aXQtPmRzYV9wdHIsIE5VTEwp
Ow0KPiA+ICsJc3luY2hyb25pemVfcmN1KCk7DQo+ID4gDQo+ID4gwqDCoAlydG5sX3VubG9jaygp
Ow0KPiA+IMKgIG91dDoNCj4gDQo+IEhpLCBJIGFtIGEgbmV3YmllIGhlcmUuIFRoYW5rcyBmb3Ig
dGhlIG9wcG9ydHVuaXR5IGZvciBsZWFybmluZyBtb3JlDQo+IGFib3V0IHJjdS4NCj4gV291bGRu
J3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIGNhbGwgc3luY2hyb25pemVfcmN1IGFmdGVyIHJ0bmxf
dW5sb2NrPw0KDQpUaGlzIGlzIGluZGVlZCBhIHF1ZXN0aW9uIHdoaWNoIGlzIHVzdWFsbHkgcmVz
b2x2ZWQgb3RoZXIgd2F5IGFyb3VuZA0KKG1ha2luZyBsb2NrZWQgc2VjdGlvbiBzaG9ydGVyKSwg
YnV0IGluIHRoaXMgcGFydGljdWxhciBjYXNlIEkgdGhvdWdodCB0aGF0Og0KLSB3ZSBhY3R1YWxs
eSBkb24ndCBuZWVkIGdpdmluZyBydG5sIGxvY2sgc29vbmVyLCB3aGljaCB3b3VsZCBwb3RlbnRp
YWxseQ0KICBtYWtlIHN5bmNocm9uaXplX3JjdSgpIGNhbGwgbG9uZ2VyIChpZiBhbm90aGVyIHRo
cmVhZCBtYW5hZ2VzIHRvIHdha2UgdXANCiAgYW5kIGNsYWltIHRoZSBydG5sIGxvY2sgYmVmb3Jl
IHN5bmNocm9uaXplX3JjdSgpKQ0KLSB3ZSBhcmUgaW4gc2h1dGRvd24gcGhhc2UsIHdlIGRvbid0
IG5lZWQgdG8gbWluaW1pemUgbG9jayBjb250ZW50aW9uLCB3ZQ0KICBuZWVkIHRvIG1pbmltaXpl
IHRoZSBvdmVyYWxsIHNodXRkb3duIHRpbWUNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNp
ZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

