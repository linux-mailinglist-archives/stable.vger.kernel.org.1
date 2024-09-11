Return-Path: <stable+bounces-75879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AE9758D5
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68831286A4A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787311B0131;
	Wed, 11 Sep 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ggdBrKym"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588A1AE87E;
	Wed, 11 Sep 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073762; cv=fail; b=FrGAVGmPKF7aYWzVirxM6Kel7KOrbpAg3daw09urUhi/CVvVLSatkIEdHQ3njT+SgVsRCAniNYpKZ4BTE+VT8I5NzT/cpeIJBvU+MqONXu+zAZ6YN+jL3Tdgtzfdt5ttLrxex9ztH632bwWbh63MrGRtokTte5hUh+3sRDSNK6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073762; c=relaxed/simple;
	bh=dQDcrWZjW0L9mCHFt6jBwM3C5j4RMPEpipq+S6KJ6PQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HmFqecV8clYsmMDpPkIU8zWZ9Inin2ieaUywZgxMjOtdPD9Zs2Yajv1/nGOyHdVCvyfgBWaLvdDlYR2m5te/i9aZS2tCI2sU7B8H8jjBW7SiksFJAj1NdEP8FYA+AWE+D4FCvF1X3r35X80vjzJqMgjNC9wWgIA20rdsRnCOZTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ggdBrKym; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw/F3zQszzcFXaz/IPwAgMlHk86GpKkpgonMBMx5GF+DfpCXtnQig3sjU6zNBiaPeOXK1YxBCVkQQNXHp4rVyx4zwSN/voc26tCyTJ/8Rm+GexfBRGUPuKYgBzaTlFDcewhDZsJtW5F/4yVUftJu/IHGhO9U2CpvNQ6AW8RMR3h3Wmb9vzgVuGUbkJquOBOn2hae3J1I0b3+5VvQG1fqvmHMaMJBc++0bDp+OZw2f/AL7gwfI3d2U+uiMzEXaLM+utKOfB/Wdi7XwRNCfFst+Wo2f8pr7Pw5A4oxf2JraVIE4V6wC3Gz6iEZsSeBxDxHCLPB0hz/O73t7CcrLr25gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQDcrWZjW0L9mCHFt6jBwM3C5j4RMPEpipq+S6KJ6PQ=;
 b=CMToVF7ankRqov7TGzElkq6yUI18YccSIBuCwcsyPure0D/BF9ahnBzK6sr+oT1vTKwMQA4MPp9d/uBh91EtbSEsARkT0rN5bJRjoBbuHuhihZ7jdujXH/P/oqrx002oiy72IDO9cWeudtQi+CjQ4b6pdKMelGRSkkp8A7s8ixzUWWM1IFBTj7qc7zM9DjxItHFOqzPZqOYbKEHXcl6O/rN9E3GPEx5kEdU2vWl4vNDd/a/NJl3IlCgWZ2cxG4eVW3nu7G0vbMbJmmzMiNra9rKE/SNAc5NYa4F3Sw4pdFjxPKSVvWQrSpMLEvKz7thj8isjTy8q/GYxof8Jrw68dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQDcrWZjW0L9mCHFt6jBwM3C5j4RMPEpipq+S6KJ6PQ=;
 b=ggdBrKymga69yeYgMmXA+3myrQLOcLbobco8fkO79kGGyadcTAc3gLdQMl/hSvUxEzYxdYuWY4SJ6l9lgSalDSs7oFIBtspZc5o6jb2vD8Ld9UGMQGC1jKpyeKX9WZOwrIfVtN44zmA3Dxd/dlNzoYC5KXV5jzaadWoIiW3sanaIUkGWVgqvu2Q5G2L0ty8r1deJsWiy0QHFUEs4z5f6zsXvmktt2bKqynsGfrUkH8EjU6aq1Mul+8FAPjkuIZcykCwp3Jsv2rbIkMJxh+cnB8xrpxNh1PHj4JgPDcGKz5Zi+RtcBfrRKQlDeapbjsqJtNpi451GsoBVvpAYnAjsLA==
Received: from DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::11)
 by PA2PR10MB8698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:55:56 +0000
Received: from DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35b0:fbf1:3693:3ba2]) by DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35b0:fbf1:3693:3ba2%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 16:55:56 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Topic: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Index: AQHbBFjNdrluTsjNlkqTR6odzDTPnbJSxpkAgAAHpIA=
Date: Wed, 11 Sep 2024 16:55:56 +0000
Message-ID: <9976228b12417fd3a71f00bd23000e17c1e16a3f.camel@siemens.com>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
	 <20240911162834.6ta45exyhbggujwl@skbuf>
In-Reply-To: <20240911162834.6ta45exyhbggujwl@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6876:EE_|PA2PR10MB8698:EE_
x-ms-office365-filtering-correlation-id: ad8b6f16-c04f-4609-eba2-08dcd2829b01
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUh1eFRPTnJxK01Ob2ZMenMvYUU4dEllNURDdVIrYnZ1Vjg1TDl3ajVFM00r?=
 =?utf-8?B?ZlZqUTZURXhYRUxic2xtNzg2WHY3a2RVQkoycHZDVEp3bUR4WnN0blhuQU9j?=
 =?utf-8?B?MDdlTWRrbm95UENJZE95cW9sSDhid1h1OWE5TjJ6eHFRNkJjYW9adThxeXIw?=
 =?utf-8?B?WU5nZUU0TEtvL1NJbXdod2JWcExIb3YvaC9NcWYySzJPRUFSUTJNZlcvUnVx?=
 =?utf-8?B?THBuZW1CTVR3QkU5TTFGSGR1T1d1eENMa0tHMnRGUzNxOGxMTTBWTWswQ3cy?=
 =?utf-8?B?RWhTMVdGYndtMUVmRC95bFV6azR0dWp5R2c2YUpOSFFBSGhrQmQ5eTVhU0Vj?=
 =?utf-8?B?cjNLVVU3OEVtRlBPWnFnNmQ0QlR2Snd4M1dlV3JDZW54eU8yTldiUzNnTkJ0?=
 =?utf-8?B?VUVyc2s3T3c5UFlIR3AxTDByOHZkd0tPRFBZRDRqNTVmc1RYbG14Tkt3YkNz?=
 =?utf-8?B?S0MxRDA5U3BhWkdmQzg4STB4b2xrL2laWXFQUkdhNy9qTzliUE04OE5Wc2Ro?=
 =?utf-8?B?OC9RaVJubWsvNldDQkRteWxyN3JqNnBCU0hTSVpZcktldmtWS2IwU1dMcEZl?=
 =?utf-8?B?a1RVVW5hNW5uYisxN3YwMTlRQnh6RmRJdyt5bGNqMGM5OFFiM1lqZ3RYRFRZ?=
 =?utf-8?B?TTZRTFVEOWxaNmpJVjdoQ3FvSXF4L28vb1NhYU85dENFWmVEQ0hlNjZ6Z0lo?=
 =?utf-8?B?dGp0bUhKYktscE03cmVrTU5TU3FGYU5KS21majE3L1hEamZnYnJxMGNWd0NU?=
 =?utf-8?B?b1lYbjVZT21NcWxLT1E4Y1FxQkpxcHFPZTd5T2ZsZmRYKzJwbEdBUUp3cC83?=
 =?utf-8?B?a1FiTzV4OGV6NjFpd25IbEk5NlZUdkRNZ08vK3loTk5JelBJQ1BEQVJLWVdM?=
 =?utf-8?B?YVRGUUEzN1hhNzVhZzFjZkN4OTlhRnFOekhXNjhYeEMwV28wWTRKaHdvblRz?=
 =?utf-8?B?Yy9MQlN0cUtrcllTTVZmQ2s1N1dXZC9aNTdJNDdMdys4RnFQY2JDKzl5cGFo?=
 =?utf-8?B?VlhqOXlEd3J0WExydzQ5dCtSdkZ4SFlKQUM1cGR6NE9XVzFoQkJKcS9nMHZX?=
 =?utf-8?B?eGJ5YlRXUGhkd25sV1BnSmNIcnFqbG53YTA3N1NKMmFJWWkyNXV5SGxRMXhm?=
 =?utf-8?B?VVZ2SFB6NFFJeURMeWY5REl3NjFJd2hINWVqaTFkMHZodVNINU1UUXMvSkRH?=
 =?utf-8?B?V29nWENjTVFvb1pxTXF0NHd3V1l0QmNqKzczREtLNlZKOS9NSXN0ZzE3TkNB?=
 =?utf-8?B?ZU5sNEZ2OVUrVWd4bWsrc29saDQ1dUp1aTRhMXJ3eFB0Zm5SbXRoOHR6alhj?=
 =?utf-8?B?Qnorbk5BYmk3Uzl3ZS8wWDJzaGw5K1NGbi92ekxrYVdzWDB6d3ZlZDBGRzg3?=
 =?utf-8?B?cXY1ano1bjZNaGxNSnowQnZXaXFmaU1XS3lXaXdDQWZPUEpHd1BuS205RGU1?=
 =?utf-8?B?cFh1T1dCdWhYZjE2TnBNeWIzS0Q2cFFRM0ZOdnMwNDh4eTJkYzFSSzhkYzFx?=
 =?utf-8?B?cFY3TXg5WE9CL2drWUVOSUkwR0E0eE1NaTRGL0VDZGNZUk1WYkdidDhJWk1h?=
 =?utf-8?B?alJqb3kzYkpVNHlpbWdNRzVGQmxYMmFtdloySjFMaEcvd0Rld0pESDZ6QlRR?=
 =?utf-8?B?S3cxZkhDV3dNaGJ1OVVvRzF5TEdRTWZVTk1nNlNJT2ZFVU9FTm5OUUpDSnBS?=
 =?utf-8?B?WDFZaU9vYW5DcnJGNU04TVVJbnI0S1hjZW5QTXNTYzlhdGFObDFoSzNnS2N3?=
 =?utf-8?B?RU9CUUNON3MwMTM3YmhaRDl3dTNXUks4VC9LckkyWnNyY0JWeTE1Sk9ESHRW?=
 =?utf-8?Q?/fWKHL3YZLy7yB465K5glTo/+GFA4Kq1py3is=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXkvb3cwMkdReHJkblhJN29EWnZzamM5UUhmMmFuUnFwejdsRmdQWDNmUFVn?=
 =?utf-8?B?N01JQ2lodURtOXR2ZTBnZXoyemZPUGtUMGR5Z01mRCtld1F0aS9zSmxVeDNK?=
 =?utf-8?B?UnEyVXNNVW15aXpJMUNqa2tiOXMza2RCR0xmWWRrVjlEVlBVUCtDeHNHT3A0?=
 =?utf-8?B?MWpJN2xDV2ZicHk1Wmd1b1RteXlrK21RTFR3Q1M3VHc0LzhzWDRGb2RJcHR5?=
 =?utf-8?B?VFNnQ0dvVHk0NVpURCt5SUcrdVRYdTFsL3ovTnlJcTBhOXR1ek13WWRDYlJP?=
 =?utf-8?B?YjRVRk9JV0lycjBhM0s4ZG40eThkR2ZOYTRLZUxuMEp5OWlzZGFJSjBlYzJx?=
 =?utf-8?B?ekhzM21NQU5JRVJkdkluRFZCV3hCNDBJMlg4cU5JL0xSNVZ5cEwrdHJpR0Y1?=
 =?utf-8?B?VlhqZHJKZzJLenN5WlFTeGk4L2xSY3Q2bFRDRW5lMmZsOCtlUExhQ1lsVG1Z?=
 =?utf-8?B?SjFFS3RaMDl4VXNnY3JvOFAwQU5XczBqYW1rdW5IdGlnOTFuSi9kalhvY0hv?=
 =?utf-8?B?TGU0bXR3MUNwQ1JndUZGR2xvRjFZaW8xQmF6a295TzJKMVFyM0VOVUtzbG9H?=
 =?utf-8?B?Qnpodk9EbTg1NUEzelhKeHIvS1laTHNaREN3VHN0eHpRQ0YwMzZlMGxxWTRu?=
 =?utf-8?B?VVJFVzhqaDEwRWR2aEVLOGh4NG9IN3daRWcwTnJqYndCMHZUL2hDc1czOHhH?=
 =?utf-8?B?b3hDeGZEbFRmb0U3R2ExYWplWk9jNE4zcGFuRHhYVmx0YW00RERVekZTckxR?=
 =?utf-8?B?b0c4MjZkVGx4cmxNMnJzUDM1a0pSZ0c4M2NrMGJXN2NDY0tjd01IQXNBV1No?=
 =?utf-8?B?WldpT3l4b3JiRXc1Lzhmai9LdS9pdGpveHoyalc4MnNuMnBDbDZZR0lsdm4y?=
 =?utf-8?B?c0h3bjgwWXhKNVg5d01WWDFVWEVzeU5Hd1FKQS95bldkQm5XUnkzK1ZScG5q?=
 =?utf-8?B?VGQ5cHZIQk1JVU9IbmtYOWp5bGJxWEpuVnNFSk5Eek5jNkV3TGRnM05oQ2dk?=
 =?utf-8?B?ajNHc0JxYkcvYlFzNFJOZ3ZQTUxTWm1oTFltRVBzSmVwRG1qTkxUQ2FHcHpn?=
 =?utf-8?B?cnhiaHd4cnRyclVPZ3JYTU9NYXpwUExmNUFiM1lmRHBBN2tla21JbmtJb0Y3?=
 =?utf-8?B?dklKMUp6Y3JZM05MTFpRTndsdU1ZQXB3K3dFODUyN3A3ajBTU0wzakZUWmhB?=
 =?utf-8?B?NjBqQTNZOXczZ1VwYjdheUtSRlFxSDhrWTVhVzZFa2IyTzVhcHFucExEUldT?=
 =?utf-8?B?VE4yaVUzeXIvRDFmblhQK1dOQTdvc08wUFpsNEFWVWZvaHJ1dUJ3c2p4YTA3?=
 =?utf-8?B?ZjJqSHZ0T3R3UW4xK1UrOGMwYjFKdGlVZ0RvcGdCRTZMZUdyTE9sZXFpaUtC?=
 =?utf-8?B?Q0NkdTFabDVyVUNNZEFpdWNSNW5rTGhDRXJzSmZESkJLQmlNbHlMRVVXVjFt?=
 =?utf-8?B?VDNjUlJNNGtCWFRiUjc0TjdHd2g5eU1NT2YremhsVUdMemMxV0V1SVdwTlhu?=
 =?utf-8?B?bExnRkVzZ3gyM3NkRkg1cWRYNVFLeGRZVmlXZmF2UGQ1YWFPNGN5V0s3MDZn?=
 =?utf-8?B?c2JpUkxyY3pza01jV2FnVWp4bU5xc2ZEWUNvS01aLzlFSUFIbThFQ3ZWTGhM?=
 =?utf-8?B?SVJNdHhBdGlabFg3VFpxWWhJSzdvSkEvQ0dWNGNhTFRXNXN2Wk5PQTk1Zk90?=
 =?utf-8?B?L0ttMnh2LzBEbGkyT0plRndSRFhsMm9KT0c3UDNxWUJseGNmVUlSYTF1aXAv?=
 =?utf-8?B?Wmg5V2UyZWY0cjFVK0g0ZkpsRE9Ia3cxbXNZamkzdGpDcWcwZ0hqTXdKQktD?=
 =?utf-8?B?elpzQllVN2hpV1Nsais0OUtXMDgzRVNXNFJ1ZEZlM0V4WlNYVmJDZUV0QWtM?=
 =?utf-8?B?aURIOUlScGhqRC80WXJiK1JhaFBTckVKVG92R3h4bjlMM2ZGZVJMSHh1aWtX?=
 =?utf-8?B?bTY1RHJSaldxVUlRR0RqSGFZZ05CUmwvY2RqU2h4cmsycVJEZWJiZGJGTUFq?=
 =?utf-8?B?cVA4MVo1Y2pQalNVbFh0Q1Q5blM5M3M4R1dUTXRTN28xdks5N1B1RHRhdEM3?=
 =?utf-8?B?UUpZV3QrUkxUcHlZUGRFZUc2bkNyMzBEcW1DN05aKy9raTQvOUh0T1lLQ1JT?=
 =?utf-8?B?NHpOUXkyQjJRbWNDaGJqU01wRVlKSnRzR2QwcmNQMGRqaUorU2FjMUE3RnVz?=
 =?utf-8?Q?3rPBq3LMHpReJTTJEgrfYGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27D0618A51551E41AB8210DB784EE849@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8b6f16-c04f-4609-eba2-08dcd2829b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 16:55:56.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGxSvVk0GgN85DjXygzt+xQsLp8QMGtwV0+TwrXT2S3+abw7IMwInyKVu2RaAbANGVl8tfpFThyqP1NZQ9t5gYb7rKLu9yq+XUDE7L0Ac6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8698

SGVsbG8gVmxhZGltaXIhDQoNCk9uIFdlZCwgMjAyNC0wOS0xMSBhdCAxOToyOCArMDMwMCwgVmxh
ZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiBPbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAwNDo0MDowM1BN
ICswMjAwLCBBLiBTdmVyZGxpbiB3cm90ZToNCj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4g
PGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBkc2Ffc3dpdGNoX3No
dXRkb3duKCkgZG9lc24ndCBicmluZyBkb3duIGFueSBwb3J0cywgYnV0IG9ubHkgZGlzY29ubmVj
dHMNCj4gPiBzbGF2ZXMgZnJvbSBtYXN0ZXIuIFBhY2tldHMgc3RpbGwgY29tZSBhZnRlcndhcmRz
IGludG8gbWFzdGVyIHBvcnQgYW5kIHRoZQ0KPiA+IHBvcnRzIGFyZSBiZWluZyBwb2xsZWQgZm9y
IGxpbmsgc3RhdHVzLiBUaGlzIGxlYWRzIHRvIGNyYXNoZXM6DQo+ID4gDQo+ID4gVW5hYmxlIHRv
IGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVz
cyAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gQ1BVOiAwIFBJRDogNDQyIENvbW06IGt3b3JrZXIvMDoz
IFRhaW50ZWQ6IEcgTyA2LjEuOTkrICMxDQo+ID4gV29ya3F1ZXVlOiBldmVudHNfcG93ZXJfZWZm
aWNpZW50IHBoeV9zdGF0ZV9tYWNoaW5lDQo+ID4gcGMgOiBsYW45MzAzX21kaW9fcGh5X3JlYWQN
Cj4gPiBsciA6IGxhbjkzMDNfcGh5X3JlYWQNCj4gPiBDYWxsIHRyYWNlOg0KPiA+IMKgIGxhbjkz
MDNfbWRpb19waHlfcmVhZA0KPiA+IMKgIGxhbjkzMDNfcGh5X3JlYWQNCj4gPiDCoCBkc2Ffc2xh
dmVfcGh5X3JlYWQNCj4gPiDCoCBfX21kaW9idXNfcmVhZA0KPiA+IMKgIG1kaW9idXNfcmVhZA0K
PiA+IMKgIGdlbnBoeV91cGRhdGVfbGluaw0KPiA+IMKgIGdlbnBoeV9yZWFkX3N0YXR1cw0KPiA+
IMKgIHBoeV9jaGVja19saW5rX3N0YXR1cw0KPiA+IMKgIHBoeV9zdGF0ZV9tYWNoaW5lDQo+ID4g
wqAgcHJvY2Vzc19vbmVfd29yaw0KPiA+IMKgIHdvcmtlcl90aHJlYWQNCj4gPiANCj4gPiBDYWxs
IGxhbjkzMDNfcmVtb3ZlKCkgaW5zdGVhZCB0byByZWFsbHkgdW5yZWdpc3RlciBhbGwgcG9ydHMg
YmVmb3JlIHplcm9pbmcNCj4gPiBkcnZkYXRhIGFuZCBkc2FfcHRyLg0KPiA+IA0KPiA+IEZpeGVz
OiAwNjUwYmY1MmIzMWYgKCJuZXQ6IGRzYTogYmUgY29tcGF0aWJsZSB3aXRoIG1hc3RlcnMgd2hp
Y2ggdW5yZWdpc3RlciBvbiBzaHV0ZG93biIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVy
ZGxpbkBzaWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCBkcml2ZXJzL25ldC9kc2EvbGFuOTMw
My1jb3JlLmMgfCAyICstDQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9sYW45
MzAzLWNvcmUuYyBiL2RyaXZlcnMvbmV0L2RzYS9sYW45MzAzLWNvcmUuYw0KPiA+IGluZGV4IDI2
ODk0OTkzOTYzNi4uZWNkNTA3MzU1ZjUxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Rz
YS9sYW45MzAzLWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9sYW45MzAzLWNvcmUu
Yw0KPiA+IEBAIC0xNDc3LDcgKzE0NzcsNyBAQCBFWFBPUlRfU1lNQk9MKGxhbjkzMDNfcmVtb3Zl
KTsNCj4gPiDCoCANCj4gPiDCoCB2b2lkIGxhbjkzMDNfc2h1dGRvd24oc3RydWN0IGxhbjkzMDMg
KmNoaXApDQo+ID4gwqAgew0KPiA+IC0JZHNhX3N3aXRjaF9zaHV0ZG93bihjaGlwLT5kcyk7DQo+
ID4gKwlsYW45MzAzX3JlbW92ZShjaGlwKTsNCj4gPiDCoCB9DQo+ID4gwqAgRVhQT1JUX1NZTUJP
TChsYW45MzAzX3NodXRkb3duKTsNCj4gPiDCoCANCj4gPiAtLSANCj4gPiAyLjQ2LjANCj4gPiAN
Cj4gDQo+IFlvdSd2ZSBzYWlkIGhlcmUgdGhhdCBhIHNpbWlsYXIgY2hhbmdlIHN0aWxsIGRvZXMg
bm90IHByb3RlY3QgYWdhaW5zdA0KPiBwYWNrZXRzIHJlY2VpdmVkIGFmdGVyIHNodXRkb3duOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYzVlMGU2NzQwMDgxNmQ2OGU2YmY5MGI0
YTk5OWJmYTI4YzU5MDQzYi5jYW1lbEBzaWVtZW5zLmNvbS8NCj4gDQo+IFRoZSBkaWZmZXJlbmNl
IGJldHdlZW4gdGhhdCBhbmQgdGhpcyBpcyB0aGUgZXh0cmEgbGFuOTMwM19kaXNhYmxlX3Byb2Nl
c3NpbmdfcG9ydCgpDQo+IGNhbGxzIGhlcmUuIEJ1dCB3aGlsZSB0aGF0IGRvZXMgZGlzYWJsZSBS
WCBvbiBzd2l0Y2ggcG9ydHMsIGl0IHN0aWxsIGRvZXNuJ3Qgd2FpdA0KPiBmb3IgcGVuZGluZyBS
WCBmcmFtZXMgdG8gYmUgcHJvY2Vzc2VkLiBTbyB0aGUgcmFjZSBpcyBzdGlsbCBvcGVuLiBObz8N
Cg0KVGhpcyBwYXRjaCBhZGRyZXNzZXMgdGhlIHJhY2Ugb2YgemVyb2luZyBkcnZkYXRhIGluDQoN
CnN0YXRpYyB2b2lkIGxhbjkzMDNfbWRpb19zaHV0ZG93bihzdHJ1Y3QgbWRpb19kZXZpY2UgKm1k
aW9kZXYpDQp7DQogICAgICAgIHN0cnVjdCBsYW45MzAzX21kaW8gKnN3X2RldiA9IGRldl9nZXRf
ZHJ2ZGF0YSgmbWRpb2Rldi0+ZGV2KTsNCiAgICAgICAgDQogICAgICAgIGlmICghc3dfZGV2KQ0K
ICAgICAgICAgICAgICAgIHJldHVybjsNCiANCiAgICAgICAgbGFuOTMwM19zaHV0ZG93bigmc3df
ZGV2LT5jaGlwKTsNCiAgICAgICAgDQogICAgICAgIGRldl9zZXRfZHJ2ZGF0YSgmbWRpb2Rldi0+
ZGV2LCBOVUxMKTsNCn0NCg0KdmVyc3VzIA0KDQpzdGF0aWMgaW50IGxhbjkzMDNfbWRpb19waHlf
cmVhZChzdHJ1Y3QgbGFuOTMwMyAqY2hpcCwgaW50IHBoeSwgIGludCByZWcpDQp7DQogICAgICAg
IHN0cnVjdCBsYW45MzAzX21kaW8gKnN3X2RldiA9IGRldl9nZXRfZHJ2ZGF0YShjaGlwLT5kZXYp
Ow0KDQp3aGF0IHlvdSByZWZlciB0byBpcyBhbm90aGVyIHJhY2UsIHplcm9pbmcgb2YgZHNhX3B0
ciBpbiBzdHJ1Y3QgbmV0X2RldmljZSB2ZXJzdXMNCnRoZSB3aG9sZSBuZXR3b3JrIHN0YWNrLCB3
aGljaCBJIGFkZHJlc3NlZCBpbg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjQw
OTEwMTMwMzIxLjMzNzE1NC0yLWFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbS8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

