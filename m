Return-Path: <stable+bounces-75884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 606EA97590E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFE1B25A2D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375E1B0131;
	Wed, 11 Sep 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xAEnyICK"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E651AC8B2;
	Wed, 11 Sep 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074556; cv=fail; b=tvAxLSiv+EUrkKqFh9dYl9Djr4ZjcC0aU01T/1JiZ6/Mnj7O4hmiIDBoeqvNaaaiAaZ35b8TZ0YDVwkbedux5nLlZUHAurRIoLdJILW+JRUAl81zcpdm7Uy5M3Ws7bh+rXjDlIH+q9CrEYgdA9ZKq4eOIMNXx3xdaNS6Xr2cjkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074556; c=relaxed/simple;
	bh=VwXZhCwiwnDdKWKoBKlPILxYzmQFRzWlvnzqBUFv8c4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6lldgqqrgqg0EmripKZ3tabBF4NLvC4gm5T+A+AVt/iZIv1e4g9iCuiZWDvPuhIWmj3Tj7rJMdjrGflvRMq7Vfn2W/9rdu1kJKzWTXJCQ7YLSry61lHL1Yd2CaWeEvlMcJXzKaHwFkrDeGIf6KgGQDZ1KJCvWdoVIiGeX7iDeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xAEnyICK; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I47Y3/sW8HJe4Q3qvfsrsuPMFTfECyNUXAfIFuXibuQpyYQ4sH2dP3sYDgDksX9HIf0CaL+9qDeBDTrAm7LjV9TXMTKa1JNlYQutOCVcwR44vpmB5iHzUee1e++znQo9rUP3wpaARKW5bHBRdTMiPcWOm957RjbqhoA3+MSt0WY0tfgJqeG4BoViq4iON1k5YfTkrGAv4THpiUg4RlN/UPCHemeJfETd7BWU0uAiR4YPt+2AHR3e0OXAS7HBcoewDl5uUPIv+VApQNERGBymniAVJwj9MQqQyHQ0/++t0FOCbE9dBl9SW0BELPe1DIlw2cd+ts1LeMwt0bji99KMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwXZhCwiwnDdKWKoBKlPILxYzmQFRzWlvnzqBUFv8c4=;
 b=SCo21k+d9/tCN5wjTRT0Rre5G/p56hCBDkMq/tiLKpvvYwbCxXih4R+sv5Vgr7gvLVK9zJ/71J1yervYWtg7W0x3vLJK/QVPd4XvaCSW8QaZ3b2vCx2vfcidSVi1Q1Nfk/V4Q0wCBchL9DvEKPlMlvVPKwfQKTv9NK98Tj58oI9+0197srnfasKBa2FnjfjTZWNiEMCO/Gh8V+YXIpojoZw/brMv7eFyjvIHS5Zc1cETW4oQcBvZg4yYXgiLQayJE/3fJKwb3sGYLjtS/7uGOcohuD7d3NcCGiVFhYOacaRIyVg35OW9GsSqeMrd90I1yHmnVNr6pcIWUdOOkCG0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwXZhCwiwnDdKWKoBKlPILxYzmQFRzWlvnzqBUFv8c4=;
 b=xAEnyICKp3yPEAoIfTd1SlFxl0JwXE5aujt3qdqXuFv8oMIHQek7FEg31QdBRRFQj8JRxVodd/y9c80zRRlM0sSrkkBFYp9lBROC3VObZJ+Nqpu6R5H3YRIFjvERkDseGMziPPxKXAaXRSpCJLAu5SwK/q3wJzQ+3H12u/3q8uFwmiW7t/B/jT+OEnCjm96BDJ0yKOa/SUE+OILCdHuCCMicBJOFjiNHX9o5qpHFoFvZWHJGI6DD0GU8SOyWkHUl2/Qxdow6zRHIoYuiVX+iJkjUvX2wrk/FzwZmeLln0Q3wtxoYWhQAEuMA2pvB+IYdNMgarWL8sJaxefBI8jsEIA==
Received: from DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::11)
 by GV1PR10MB8441.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 17:09:10 +0000
Received: from DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35b0:fbf1:3693:3ba2]) by DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35b0:fbf1:3693:3ba2%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 17:09:08 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Topic: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Index: AQHbBFjNdrluTsjNlkqTR6odzDTPnbJSxpkAgAAHpICAAAJigIAAAU0A
Date: Wed, 11 Sep 2024 17:09:08 +0000
Message-ID: <7b9dc2a2494c2af62cd37e506bbad73a44819c36.camel@siemens.com>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
	 <20240911162834.6ta45exyhbggujwl@skbuf>
	 <9976228b12417fd3a71f00bd23000e17c1e16a3f.camel@siemens.com>
	 <06f6c7d6f1e812c862af892f89d56d74b69995f9.camel@siemens.com>
In-Reply-To: <06f6c7d6f1e812c862af892f89d56d74b69995f9.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6876:EE_|GV1PR10MB8441:EE_
x-ms-office365-filtering-correlation-id: fc1b4906-34ad-4416-c6e7-08dcd2847301
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1dBa2o2QVNpTmxsTVBZWDNKYUNXV0RORmlMQi9aeVNaZFJaa3dlRzNzVEdB?=
 =?utf-8?B?ZWJIOE8yU2JNV3ZSZGlYeklvK0lZVG5CcEV4N0NsZkVNZFNwY3hoMzU1TldS?=
 =?utf-8?B?K0JpaUNqbTBZMGhwQTBtQlE2bmRUUzE1TS9UUHNwVVB0R096cU5BcDlXTjR6?=
 =?utf-8?B?QVI3VXFHL3hUWGk2cHJ5aVdMYVEvbjRXVDRtSzZPVHBpTUMvN29Lb1lVZ2JT?=
 =?utf-8?B?dkFhMnd1WS8vQktxczdodkRkeFJtUkV6UzFXcVJHZUx5Z2IyYVZsZlZZT2l3?=
 =?utf-8?B?OVozMzhTL2R2OWRtVUJER2sxZ0JXcVVCZWhFdXlmYzd1dVJwampGZ2lEcGpn?=
 =?utf-8?B?VklCWGhGMjVmZnBuK0FSOGRnNTMrMVJIT0RKUVN5akl5cHlpNFp2MHVHL1Iz?=
 =?utf-8?B?UEl0TkZJZ2p0am93SlJGa3RBMGRKTGpXb05mOXVYS3hNWHQ3cU9MeUVSVkVR?=
 =?utf-8?B?UVZnOURUMTVDQVhtOFNHQlZXeE5oU3doMTBWcEU0TmxveHMxdWtVa2c4ZmpG?=
 =?utf-8?B?dkJxbDM4b3dKbU9Kb3VyTHcrbjk4eHNDUHdLN3h5eFVZQjJuNWQ5LzYyRWRt?=
 =?utf-8?B?ZGhkRnM1bHJlc0tRUDRDL0RCZ3JFZkhTQTRIMlVwMGVQbVBZdEdzWFVURkI0?=
 =?utf-8?B?ZnVaUHRnMUZJWkZubVBJS1NXV2J6VFBJM0pHeEozVGU2ODJ5bCtXaURhbmll?=
 =?utf-8?B?cFBPaFBNTDllbW4rTjVxa3NubjFOUTFJeTBwb3FxSHBXUGxmdzROUS82bHBz?=
 =?utf-8?B?bngvZXArdk1DV2t5cStMZy9Eb1dYSENZVW5zYU5oUmpDb0hXTk94eGFLSU9T?=
 =?utf-8?B?V0lTVWlGeHRkZmdTNWpKYUVkM0JaMkJHNTFXdFkvTVBhSTNpODUyNHlVa1g0?=
 =?utf-8?B?enROWTZlb1gyaURWRWdVUXNuM2Z4Wk5OaC9KQXhyWmMrdHNxY21xVDRRa1E2?=
 =?utf-8?B?cjhmNXNJZnZ5N3VLRFJWcVMvWmNudDJvUjBaenZJc0RiSHJuTkI4SVl1NGdZ?=
 =?utf-8?B?dEpNbXR2eEdGRythQjMrVjEzMkpSODVjTlkwK1VHMlltQ3gzamhLdCtKZlFS?=
 =?utf-8?B?MU9OdlB3SDNYTms3TXgvMTBIbXkwNTdnck1WSkQ0WXNmWDVBTjJpMktBYVg1?=
 =?utf-8?B?N0xVcWhYZnlnYW03SWZRUzdibERET2dpYVBlcWtqYlprVlRRUnlBYm9ieVRL?=
 =?utf-8?B?QzJ0OUEvb0N1ZFpZbm9MbXJTMVZPYnlyd1lpbjdWSzN1V3FIZWJSUzRjdmRl?=
 =?utf-8?B?djFyUEtVVy9vdFU4elBLaFgrR0lUbERjdks5WkZIQVVlbGVFWW1rME9lZWZZ?=
 =?utf-8?B?MnI4Y3hWcjFONWUvS2IwdW9DUTNnZS9MTGpJM0NQZm9IYnpHT1ZJWjA2T24w?=
 =?utf-8?B?Z1d5SXV2ZXlTZDRnNEx3eFhRcXdTU3lUVnR4K2dVdFE3bm9ORk52LzNpMjd4?=
 =?utf-8?B?UkY0dVVIVWM3QnFHbHZpTHJoWUc3T0JiZ2dFT0swbG9wRll1eE9oa1JZdVVF?=
 =?utf-8?B?U2RZSE0rMzVkcW9zMXJwUEhTY3BDMGJ2L2pCM0NSeXBiNVA2U3hRdUMxN202?=
 =?utf-8?B?azF0T1l6QzZmY2w1bmlYeDZadGpWKzhqK0MzWWxUUzRhSThNc0laRDd0b1E1?=
 =?utf-8?B?OTFpRDdQSnVWZmpkMjVBWnBXU0FQbmFxSjRvZWF3N1hxUDlKWnNWbmU3MjJh?=
 =?utf-8?B?SkExTDdZOTVnMVRwcGFaeGN3ejlJNmUzYTdzRkJ2ajNJMjRlcjJId0Vqdmll?=
 =?utf-8?B?bEdRTW9rK1RLK3QyUERyMDZLQmNoQjc2OTMxZ3hOWUxIQmNuR0VPNEh1aGVm?=
 =?utf-8?Q?OUjiVrcZpVjKp0L3aG5lcGlmPK0dASaknihNg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHFUZzNwRnRwNHA5cnlvSnFVL2dWTXFPWVdVY1lxUEpkdHNXeE5meXY4Y0Zn?=
 =?utf-8?B?NCszTGdQcHE3TzVCajN4OFQ2bEExQWh2N2REMW5OektGUjROSEQwNkI5VkFE?=
 =?utf-8?B?ZU1FQW1GdjZScGEyWDRlaGlsYld0c1NsdHdZQnhualZNSS9EY1YwbUlWSFpq?=
 =?utf-8?B?MFNvMFlWcnIvM1RZMVV6ek1MZDU5ZlNUc1dkQ1pPZTRzRjJCQUlqVjVLRFZ4?=
 =?utf-8?B?ZlQrUHhGT29RMDBmS2xGZlJrTE5ucHdjM1BJVk5VQ2VRR24xNGcrWTZuNzZY?=
 =?utf-8?B?bU9PekVac04vdEsyUTMvMkpKRkgxTFU4NU1xRDd4bkRsNVRnZTBWWXpwQ3pY?=
 =?utf-8?B?U2RxSjVqREg1ZjQ2dlNKYlhJOGhWR0hKdXFXc1BtdHBRd3ZINDRCQ2ZnSWV0?=
 =?utf-8?B?WjhXY2Rzb2ZKY1pWb0FKVXNCTzZGVFl3YnJRbWM0NFRDWU12bmJRbUZHd0Vv?=
 =?utf-8?B?cjZJWTBQMlkzb0NzNS93S0k5TzF0WG11MmgvMmNib3hUYmI1bW5PK1NOWWpP?=
 =?utf-8?B?cW1EdGZGcWtBRWdtN08zREdoTFAyZFgxVEc5WGpTSVZvdmNLV0QrM2dVclVW?=
 =?utf-8?B?QWVhdGZSTEgzUDF5VmR2NG5NaUo4RzRmQ0duMFcvT0VGS0VqZGF3czVvQW5l?=
 =?utf-8?B?U1F0NU9XdnoxSkJqcTBqWThBejNSZjBzMkxVT3JiR21ucmJoaExQZ2k2VVkw?=
 =?utf-8?B?VVNqUDhwUVYzTm1IQWZyVmNHaGhKYy81L1IyVVNLTlBtMVoxb014SzVsaERD?=
 =?utf-8?B?Vi9CUTZtR2dDajM1Mi90ZVNKSm5mQk5ZS0piT3htUjFRa2Y4T25ETG9jWlBS?=
 =?utf-8?B?Z2VFV0wzZzB4L2xSZE1CR2xqVUlpWEo3NGpLZkNZcCtMclRLcmw1dUdhQVlJ?=
 =?utf-8?B?UmZpeCtYRG9zTytObmRqTlVzTzd6QnREV1I4MnBYWERoeGlWSThiQTJtZ1l4?=
 =?utf-8?B?RzlvNDRSWnRoZTkrOFYxeWFIVEJ2RTlGSGZOK0c4L2x3QjNualJRQnZJR2JP?=
 =?utf-8?B?VmJBMVNnWGdtRGtJQ0ZoaXVDWitkd1drZkxEYjNxYytZVW52NjB5WjJqdjVY?=
 =?utf-8?B?Mjh1SUJsT2dUSnlySXRWREZwQk1YcW1UNzhYV21RcGEyTUtvSlMrZDRrdjA5?=
 =?utf-8?B?OUVnN2tRVTZNM0w0SXlGdkdOSnJiMFp1SjFZd0FndjExNVFJWXEwMFAvVzB3?=
 =?utf-8?B?WUlwY3lVS0hqcEoxNFBreUVtZTFpc0RoMkM4RUY4dVNGU3VyYVA3dG9KOHA2?=
 =?utf-8?B?d0xKS1ZwcEJOK2NTTVB3NTM0Nk01b1FUeE9uZ0lZNnNkTWxPQjY0VVcyTDRZ?=
 =?utf-8?B?SnlvMjRNc2xZQnh4dkJ6blRDeENSTmFhaDBiY2haU0hOZFVGR0FVbzVpdWp6?=
 =?utf-8?B?dThTZExGazIzVTl2ekdtbXVlLzM5RVo2SzdPSThiajN1enVoR2RLZXRYWndJ?=
 =?utf-8?B?VmE4VWdlZE4waG1NUmtxMWVhcjB6cEM1MFhiODZDTzJoRC81RzBIRkdIQ3h5?=
 =?utf-8?B?UmI5bEZaWlA4aUFBbmM5dDN1WnhuMkt2RU93SGlzcVVobU94UVFpQ1BRV3JB?=
 =?utf-8?B?VHRBV1hNN3NBZTRUSkNSUDh0Q2xpYTZGeUJiMkszRm5HZUNtZytNZ2RpUnJ6?=
 =?utf-8?B?dHp0N1VmUVk4Z3hMOExpK292elNEOE1jZ29CWXhweEJubmlFWGtJMGZvQ2Jq?=
 =?utf-8?B?TlJVbVVyMGo1YS80UmFaMDdDaTF1azEzWWRIZzMyZm83cVJoQjB1bTVEVTZ1?=
 =?utf-8?B?ZEpDUGVjeVJkY2FGOFE4ZWZvZ29uVU9BbncrWElaZ3QycUJqeExlU29wVGtZ?=
 =?utf-8?B?Y29BVHMzejdoSGhpR1JjLzl0YVZqSGg2LzdsMERNMTVJSFBkODZ3R2hFRElj?=
 =?utf-8?B?aW1SVURrVGx6b1J1QjlJTWdRYjFTdHFnL3FmZGdiWWZwNDJocTZLRXZrMTBS?=
 =?utf-8?B?QkdQZXdOcU9lMUhCbEVPRjA5d3hsWXZROGh5M3RRbktqUjZray8yWjZhQjZr?=
 =?utf-8?B?cmNWRVJzSi95Nmt2R1lrYWszdGZGRlEvQ0s1NEdkQVBNV3Z6TXN4UElGZ3d5?=
 =?utf-8?B?bEh6d0dHSnJWSGJJZjZiR2tjQUdDRlZ5QjZ6b1R0TmhCY2Y1Q1hOaXl1RVRZ?=
 =?utf-8?B?WnRBOHpJOHNXZFRBK0NJSVNHS3FuRmhIdVBITVlJV1krS3RqTkpocDVtbjdP?=
 =?utf-8?Q?6CtwSHQDigHfAcNas2OjjNg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D2AE1A633BE04DB2E204069AFA1525@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1b4906-34ad-4416-c6e7-08dcd2847301
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 17:09:08.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sQHqJzU8LDUmFOcsGQnMvTkRMaUPtHb+CvYu1r+zwL1ruTO8RyBgcjPvGyINsmL0H8Vg/avtiS/1rVFqbNkhz1zwZDbpMS2GyQK9HYj+Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8441

T24gV2VkLCAyMDI0LTA5LTExIGF0IDE5OjA0ICswMjAwLCBBbGV4YW5kZXIgU3ZlcmRsaW4gd3Jv
dGU6DQo+ID4gPiBUaGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoYXQgYW5kIHRoaXMgaXMgdGhlIGV4
dHJhIGxhbjkzMDNfZGlzYWJsZV9wcm9jZXNzaW5nX3BvcnQoKQ0KPiA+ID4gY2FsbHMgaGVyZS4g
QnV0IHdoaWxlIHRoYXQgZG9lcyBkaXNhYmxlIFJYIG9uIHN3aXRjaCBwb3J0cywgaXQgc3RpbGwg
ZG9lc24ndCB3YWl0DQo+ID4gPiBmb3IgcGVuZGluZyBSWCBmcmFtZXMgdG8gYmUgcHJvY2Vzc2Vk
LiBTbyB0aGUgcmFjZSBpcyBzdGlsbCBvcGVuLiBObz8NCj4gDQo+IGJlc2lkZXMgZnJvbSB0aGUg
YmVsb3csIEkndmUgZXhwZWN0ZWQgdGhpcyBxdWVzdGlvbi4uLiBJbiB0aGUgbWVhbndoaWxlIEkn
dmUgdGVzdGVkDQo+IG12ODhlNnh4eCBkcml2ZXIsIGJ1dCBpdCAoYWNjaWRlbnRhbGx5KSBoYXMg
bm8gTURJTyByYWNlIHZzIHNodXRkb3duLg0KPiBBZnRlciBzb21lIHNoYWxsb3cgcmV2aWV3IG9m
IHRoZSBkcml2ZXJzIEkgZGlkbid0IGZpbmQgZGV2X2dldF9kcnZkYXRhIDw9IG1kaW9fcmVhZA0K
PiBwYXR0ZXJuIHRoZXJlZm9yZSBJJ3ZlIHBvc3RlZCB0aGlzIHRlc3RlZCBwYXRjaC4NCj4gDQo+
IElmIHlvdSdkIHByZWZlciB0byBzb2x2ZSB0aGlzIGNlbnRyYWxseSBmb3IgYWxsIGRyaXZlcnMs
IEkgY2FuIHRlc3QgeW91ciBwYXRjaCBmcm9tDQo+IHRoZSBNRElPLWRydmRhdGEgUG9WLg0KDQpC
dXQgdGhpcyB3b3VsZCBtZWFuIHRocm93aW5nIGF3YXkgdGhlIHdob2xlDQoibmV0OiBkc2E6IGJl
IGNvbXBhdGlibGUgd2l0aCBtYXN0ZXJzIHdoaWNoIHVucmVnaXN0ZXIgb24gc2h1dGRvd24iIHdv
cms/DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5j
b20NCg==

