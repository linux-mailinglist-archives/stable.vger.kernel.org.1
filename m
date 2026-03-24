Return-Path: <stable+bounces-230034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAayHEXYwWkaXQQAu9opvQ
	(envelope-from <stable+bounces-230034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:18:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2DA2FF822
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D3983034525
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD11DEFE0;
	Tue, 24 Mar 2026 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DJi9Z5kM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB601F2B88;
	Tue, 24 Mar 2026 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311448; cv=fail; b=SMMt8rsyCc3fhGUKyIWxMok/xIxOuM26MlRLCKQQLm7C1JXXsbPyLEC384Dl+1uTxOYtHlPGYjRTTSFXpyaCXeyBhjdV5x9dgivz0YIAMCnd+BHpgnPCDg89gHGH8f2H92b5riJ3P0jyQw2dWPlYSoWf5MkP4P743xmLOHallwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311448; c=relaxed/simple;
	bh=IrA1IO0Z7ff/ZTKoExrrDjMoGyOVcYvhxNiZT15cMJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HL1bQYPVRNxMcDVHjtcJIWAnEzkbiFFGehsxXxaCE4V9o9zVF2mize5EC6u3U5jPbzSzcGGUD653EcCG1xMzyN11x0YZ6p2TXcNzXBmYl/nwyJVPd9Lsoo57I0V8WTd7lOc9tcHUNiWD+NB8frJA1LsgsuSF3vwzr0kj/pFZPTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DJi9Z5kM; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFNjNa657656;
	Tue, 24 Mar 2026 00:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=IrA1IO0Z7ff/ZTKoExrrDjMoGyOVcYvhxNiZT15cMJU=; b=DJi9Z5kM
	JmZoUGpeR6IUfXg5EOpU1Sj6LqDk+M3POqUFVoutL9xWRay/hxDz2WIr5w+HOPsM
	42JrfBnKlPP1ajV7FUIKLjPHohoqxcA8Mme937+tyocb65jrN5krpEyGJiMquWOE
	P+UOvbvopuhZ/4aAvOrwR3dp14OvOFxShMv3dRxQySfP2p9xwtMKejeJybJazRLV
	wZzX9BLLxNdv67TvS/biNGI7pvN3an0hHCn6Sbzxhd2ZfG/9BKcx9ZTfOBMRMJnK
	KGXnXaFqDhmupfS0tAdYb10CF9cM5G8h6YfyaSUf4FsGrUYis4g5Z0y2WPbZdsAT
	P3xcOfaBfXCL7w==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumgs60-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 00:17:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WswhWhB8I6EMHx5uS+m5Q7YgbKsqRyrycl4K8vJ2sfvtyggSFjN6qn28WCG4daxN/Idv8iL89yX44cB0EECMuciKMsaV+UEAAzAd2ZzyX5AXpSuqRxSYzYCGd4FxGznOvyhQ0lsU/rm7q9R7JryEZkXWlutBYIi0VFnctR1+4U6U69Bm6swL7EycHNZAoWsHO4FiDS9Lk9OfcAPFoU78hPK8aY1+nGpEFnRj74zzYqPJuVROKVKCskr5SkiuBn7UEAxU2wSjapTYq6mVidVo62Y0zKR1AH9DG7vYEG5WQovj2Vnd2Z8l7nr2uTmv64Xnqb6qKb4ctTMNse8JxMR6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrA1IO0Z7ff/ZTKoExrrDjMoGyOVcYvhxNiZT15cMJU=;
 b=kZjbCohyQjVZBQ71pgtc8mwkpvDSilCLKvVsZSYFjPQIAcI2NvNGG+kn+cvJ5eBSt8VThzuMjNcrHAZ837RbHsfRfROjmDij7MPupKkhEcXOt0FKmYgpn6X/lmW+bcvZ0oX8Bqe+Q4344u4cCo7huu1O8+y0VGHLZw1NNFoSsrUG+SNrnWng/8P5eXADJsAt28uhOK5wI/N954eiOAMtM0V1Q7BY+hOctkMyI9cjg7DQfdw3+Qm+2m7zxMYK1XeYz7zXFpH8gBp7KQzXmvFzdRY1QGgGo0lqV0sbhLfM3R95wnlSpPTOPgpXZsAmpVWdeAYumTW53Wz7Yw9YuXbFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5170.namprd15.prod.outlook.com (2603:10b6:303:198::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 00:17:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 00:17:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "zilin@seu.edu.cn" <zilin@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Topic: [PATCH v4 1/2] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Index: AQHcuyOQtFpMKTtn20e9WV4ORGmDhA==
Date: Tue, 24 Mar 2026 00:17:13 +0000
Message-ID: <0eae7f18fc1598284b28bc9ec372f6906c382f4d.camel@ibm.com>
References: <20260321080130.1292216-1-zilin@seu.edu.cn>
	 <20260321080130.1292216-2-zilin@seu.edu.cn>
In-Reply-To: <20260321080130.1292216-2-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5170:EE_
x-ms-office365-filtering-correlation-id: c2a0deb2-5d2b-496a-dca5-08de893ab32d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 sbciM1wn6pL3XFmSI1Vl/RHEAvYnpGXWU9ZliO1/2+953VQxDLw8Fe+HxJX+3nCIWYLsQo/LSKoG5jcqY2d+cPxJZ5Kq7kqoi5suqCkHyp8dblkyFGmhWhgcP5nOOUWUErjMyS2dPIXn0sqFPcUGeiY6ruYwyogE/Dh1NRtqcmZl/1RQmycLx150HvWfzyYsxLp33krgm8e7EDilvdfqQtU2OYpZU/xzHGdWe2Je8241X0IGsg50IjDtk+BunRdpc3fPGVASGKD8xGE0BuGxngQ7apzixAIVtWGsHFKuaT02eZnCXNZURR+PiMxYS2Nbtu6ZOVHjlzacBdT2wrdymJDWWc6thZ8vqQ2rX/upfPQBacctW/hrGfqPaJnApaxUwva70/duOmuaCPoNzJEOj46rFUKZiC4GpQ/pVMxrOlC/DdUinTfyV8UI+DVEp5l9B8rJPn1MSq+EPgyEB3sQv/v+HX+Fwyg1W3WhFnlVbqX438PyH9wvX396gs/vPYNcg03npTkr6XPJWEi8IgcdcZ3jkbe6n3DGSjo+YDzuGHkNVgIcxGuaQ+1W1Q9jcw1iOTZfbORZ9Ch2CEnMcttTd0Qu0SsaXuDREyyngyS+Efhbv8ZwwCu+GB7q0XYCGm1RhkIJDbjSnqbz4T0axgG0bKOP5kls/+YcFUGjzcFZSZpffpf1JjVZXMie32cMxj+7auKZtwVAdo906zP9jANUK68zqVAHNxN5E1z6FB7ZLFdLV52y/+qVispv1lcRPHUB9jZqfwHp3kL1X9olynP6QvUHUDrPBvI02lqcZIt2sME=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXZYNVc4RkZ5dXVVUHB5aENFN2orVi9vNm41ZUpSTUptMURZZGpZTjZtN1Zy?=
 =?utf-8?B?N1lDNEFBLzNjbk9zV2Z4eUJ3aHVxdmdodkx4RmxxelJ6bDM2V0w1akpBMWxV?=
 =?utf-8?B?STM3cVRDMWZHai9WeG92dkhaRC9peWt5TWtrMUhvOEk2QlA0SGMrdkEwNjNX?=
 =?utf-8?B?NVZQTFR1ajM4M1UySE1DM3I3OE1YWTNpNmJZMWo0clZyMk5LbTZadU8rdWgw?=
 =?utf-8?B?VXdSakwzVnJCcGIrWFBOWm1tWGtma3plL0pKYjN3NTZZVGd2bGFjNXFzR2xk?=
 =?utf-8?B?OFIvRXpMOWdNcmxucmRoMmZCRFdlMjEvYjE1TjdyRHNJS3IwNERRcUNLZkg1?=
 =?utf-8?B?V3VDR2ROUkpncGtoajZFZitwZTk4MVY4RVl5V3VUVkF5K000Y0VTRFJtN0Fm?=
 =?utf-8?B?RmNiMU1menZIb0c1WktKRXVLMkhrUUlVY09GMWZQaEdSSXlKS0hqOUdyNHpq?=
 =?utf-8?B?MDNNYTJyaDZubWJodTJGZmd4Y0EyRVpNdFVRdTJPRkRjU3VhM1M4Z0tZTDg2?=
 =?utf-8?B?QW41Y0Y4MmhINkRWR0cxZUdzVTh1aU1VYUdkQ2xPaWQxREhraVl2TklLUWpi?=
 =?utf-8?B?cGhSU2RTSDBJQ09UYTY2Qk9HNE9OQkxEM0s0c1Z0UjJPL0VjY3dqWVJKWE5H?=
 =?utf-8?B?a0E4eUE3K1JsK2dMOFFZelM3dlJ3NENyK2xJNy9RVW82MWRiSExLelZzNmlw?=
 =?utf-8?B?OGJlYUxkdVROOXRld0VBWVREVjhOVjJESE56bzN6ZmRVcWEyaVMxdEU2WjZL?=
 =?utf-8?B?UHFYZytJQ3VzcHRtalppVnlnOXhWTkJwSmo3VmhBNC80SDIyRU5lcWdESkJR?=
 =?utf-8?B?TndsWXJxVGw1Y1JHblgvMXhoQzBObGJXRmVGL0xQVDZaN290dFNpUHBZUWN6?=
 =?utf-8?B?K3UzQnNSckUxaXR2dWd4NXN1QTYyK3lxOUpKRGhDUDZGSHVlcjkwYWw1aVBj?=
 =?utf-8?B?ZGdaSWMvd1pXeWZacUFwVDFRaVpDQm9sTnMrTllYMzlJYWVUYUFKT0VrZmoy?=
 =?utf-8?B?R255dmdXWDBFV2pGMGNLNGRpenYxMktaaXhLSW1WSHdZNCtMSnFrQzVkb1RK?=
 =?utf-8?B?WTZVSXNGOGFkSjAwNk56ZjRRQmZYSGVrbXFqb2NBa1ZZM2NxNWs3aWNmbUU1?=
 =?utf-8?B?TUduamg4dmNibjQvdUl6cXNSdWNKZDJrRlMxZEFxbng1ejRrU2REc1RDMVhj?=
 =?utf-8?B?cExFMnFYUFRTNFF3cmc1aDBRYnlVUUlYN3Y3RWREeUN1S0k5eG1WYlpqOEoy?=
 =?utf-8?B?SHl5eUl3NitzSlZIM3hTVW5CWGxreUNQNlJKdXJmUlFva041eWlJU2RwWWxD?=
 =?utf-8?B?aUt6NEJEelB1OW01ejMxNk1WbFppZjh1MzFFMDQ5bFZLMURMdmNPWng2c3RV?=
 =?utf-8?B?MFVobU9FcUU0Nlp4YUE2REp0eE1LSFQ4YzBiSThGeTlxbFNGclBpc3o5K09E?=
 =?utf-8?B?NjFBN2F4cGJJN1c0QVJoeEhPc01LZFdMcmhxTHhCZEN5enpjbUhpVGFlVG1H?=
 =?utf-8?B?a1FaS2tRT0dOREJpbjF4aG05dzFMd3dBR3dBV3l0dFFidm1iMlFIa0xaNkYy?=
 =?utf-8?B?MVBuRkVKZmV1SkVzVWpvYUp1WXQ4dVZVK0ttSlBZVldUTHlLemNKYzh6UXdz?=
 =?utf-8?B?VGw4MzBYL2U0QjFXVTJCbmhubjY3Q2twU1NXZWpOVlFLWkNiMVlIOTJNMmFn?=
 =?utf-8?B?VHBjaUZnNXduV01LR3pYWTRCbCtwYVlqaGlGL0F5b0xqd2xuSlg3TlRBcWc4?=
 =?utf-8?B?NWtFTVNjakw2U2pSZUZjUVVEWExqSzJQKzFqU05nZFJDTFkxT3Y4ajZ1Q1NT?=
 =?utf-8?B?eVp6L3FUNmFXQStKVVRnTjBtU1AvbE03TndxUytxTHAveHdoN25rTzNLcVBn?=
 =?utf-8?B?M25Hbk1ZQlhMbkNvaEZCcU8vaDJzcTZRTXkrNDZOT05ZS3NvYThoY0FQTjVt?=
 =?utf-8?B?Uzg0VGVacVg5RzgvZXdlcGUrMjhYR1haRXdKUGg4WFV2cFlhSFBwVGc2eE5F?=
 =?utf-8?B?Vk1VMHNRM2NqUnpuUjB2S09XREhtK0REYS9EaDlFVXZxNU8weEJHcU5rdHVZ?=
 =?utf-8?B?WDdIelV4bGE0REFUWTVQaGlMYmdXOFJTTlhmZ1BDZnpGZ2NOVkNFUHVTZ3M5?=
 =?utf-8?B?NkxCbGhOeTV5RlYwdWI4K2ZWMzZMeFZmTEtxV0gyRXMwSWZLNC9HejBYcEpx?=
 =?utf-8?B?UTlIeW5yQkY4b0g4TTlwQ3lVU0ZNNFFxeVhCdGQ4QTV5VUk0SXd6aW11N1Ny?=
 =?utf-8?B?ZjgvUC9SQ0hkb3pDalpIa3F5a0cyd1l1MFh2Uk9qTVkzcWtzcmxDTjNhMVlr?=
 =?utf-8?B?OHc4MHVSTTNUOE5vY1hYVUM2RTVxSW1Wcnp5OWhnaXZZcjVjM3o4SURPTEQ0?=
 =?utf-8?Q?5reAQQw1I+RnH4NXpaUPYyAIkvi/xKv5jGAZi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5548C618DBA19E44B71AD08C7879C008@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	C/Zhtpdw12LZ7khueh9k2mHWLcxVWm2K8r/FE/l8CQsQ/GRmI+oIyDwcw23s6votQpryvSSqC77LD9aaRmtqN4w+usTuIHmdrsTIbhDa4kXiGsvsDSeAgRSKBOjH8aRljGU7ZyXZBo7W3swWP/2MmHFNX8+zO6xo6GhX9lhYxtnO2Gq8lIVtXCY4c2xZicGmJrAkhHNtwuyJiSWN+VIKZzIF6zSOG3FJBTsxgugV3fob7HOy9P+PKBmWbuu3Ulfn3gVWnpxDP2vU+hwQGdC+cMnxDr4CfaGwOYzuvioFzR97AFYz6YMw5+N+arlwt3HyVoEUiqGHfvVbc9lOv6g0cA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a0deb2-5d2b-496a-dca5-08de893ab32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 00:17:14.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzkvw94Qj6ehTCpV0Z4Wvuo2HoADhf3G+HbJT9cmsvOtk1eaIfCCrMhWsGpeusRsCTKOASrwnja2E6o90zyt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5170
X-Proofpoint-GUID: vwayWQg-V-wO2XDSJILSoFDzzjzehISc
X-Proofpoint-ORIG-GUID: vwayWQg-V-wO2XDSJILSoFDzzjzehISc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE3NiBTYWx0ZWRfXx3IP4mUS3+Nh
 xevIWfguj3Ue+xTkRBTBPrMinMF4qXhXHG3ZN9cxGoUHkOxuRStl/aJHQLNFM/pMIM/4CgZzpt/
 edN0B2Wyk+x3iHMD48y3msvlIRiyUt6WmvB0lBysGnZGU6E8i869ung9BRZrVvdWmYrHC7H0FIJ
 YBbIvDLP2e5oNHVjN1q9kLnCLQQKi1XvIQlYrNW+xhmZNSzOA9v7lGocNo+3284riWg1v/1UO5d
 oaV11scKXB/cp2rBtVwMJObhzQ4JA9mkTDeqo7SkySLRoRdvOegZ0TEwoTjkCBPWU3QeMBqu73u
 umy6jW6pf5OtRFQzxjd8tpD6/yPz0hdvYez/3XWTuMCTib8IQEjBrIpTke1JV1u7RMRe8x9KUB4
 dWxpK2kqiDy5MiOn+4MgWoZGODZG4ef9hu31UBBpVOnQvW2C8fPWtDqap0dIlCpfJXs4cqmRytY
 XvYdFfH8WZe0Fnkyl3w==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c1d80c cx=c_pps
 a=uUHWVSNqngVEOHorB6lHdQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=xD50IcysifFGzd2GruEA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230176
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dubeyko.com:email,seu.edu.cn:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230034-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0C2DA2FF822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDE2OjAxICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBo
ZnNwbHVzX2ZpbGxfc3VwZXIoKSBjYWxscyBoZnNfZmluZF9pbml0KCkgdG8gaW5pdGlhbGl6ZSBh
IHNlYXJjaA0KPiBzdHJ1Y3R1cmUsIHdoaWNoIGFjcXVpcmVzIHRyZWUtPnRyZWVfbG9jay4gSWYg
dGhlIHN1YnNlcXVlbnQgY2FsbCB0bw0KPiBoZnNwbHVzX2NhdF9idWlsZF9rZXkoKSBmYWlscywg
dGhlIGZ1bmN0aW9uIGp1bXBzIHRvIHRoZSBvdXRfcHV0X3Jvb3QNCj4gZXJyb3IgbGFiZWwgd2l0
aG91dCByZWxlYXNpbmcgdGhlIGxvY2suIFRoZSBsYXRlciBjbGVhbnVwIHBhdGggdGhlbg0KPiBm
cmVlcyB0aGUgdHJlZSBkYXRhIHN0cnVjdHVyZSB3aXRoIHRoZSBsb2NrIHN0aWxsIGhlbGQsIHRy
aWdnZXJpbmcgYQ0KPiBoZWxkIGxvY2sgZnJlZWQgd2FybmluZy4NCj4gDQo+IEZpeCB0aGlzIGJ5
IGFkZGluZyB0aGUgbWlzc2luZyBoZnNfZmluZF9leGl0KCZmZCkgY2FsbCBiZWZvcmUganVtcGlu
Zw0KPiB0byB0aGUgb3V0X3B1dF9yb290IGVycm9yIGxhYmVsLiBUaGlzIGVuc3VyZXMgdGhhdCB0
cmVlLT50cmVlX2xvY2sgaXMNCj4gcHJvcGVybHkgcmVsZWFzZWQgb24gdGhlIGVycm9yIHBhdGgu
DQo+IA0KPiBUaGUgYnVnIHdhcyBvcmlnaW5hbGx5IGRldGVjdGVkIG9uIHY2LjEzLXJjMSB1c2lu
ZyBhbiBleHBlcmltZW50YWwNCj4gc3RhdGljIGFuYWx5c2lzIHRvb2wgd2UgYXJlIGRldmVsb3Bp
bmcsIGFuZCB3ZSBoYXZlIHZlcmlmaWVkIHRoYXQgdGhlDQo+IGlzc3VlIHBlcnNpc3RzIGluIHRo
ZSBsYXRlc3QgbWFpbmxpbmUga2VybmVsLiBUaGUgdG9vbCBpcyBzcGVjaWZpY2FsbHkNCj4gZGVz
aWduZWQgdG8gZGV0ZWN0IG1lbW9yeSBtYW5hZ2VtZW50IGlzc3Vlcy4gSXQgaXMgY3VycmVudGx5
IHVuZGVyIGFjdGl2ZQ0KPiBkZXZlbG9wbWVudCBhbmQgbm90IHlldCBwdWJsaWNseSBhdmFpbGFi
bGUuDQo+IA0KPiBXZSBjb25maXJtZWQgdGhlIGJ1ZyBieSBydW50aW1lIHRlc3RpbmcgdW5kZXIg
UUVNVSB3aXRoIHg4Nl82NCBkZWZjb25maWcsDQo+IGxvY2tkZXAgZW5hYmxlZCwgYW5kIENPTkZJ
R19IRlNQTFVTX0ZTPXkuIFRvIHRyaWdnZXIgdGhlIGVycm9yIHBhdGgsIHdlDQo+IHVzZWQgR0RC
IHRvIGR5bmFtaWNhbGx5IHNocmluayB0aGUgbWF4X3VuaXN0cl9sZW4gcGFyYW1ldGVyIHRvIDEg
YmVmb3JlDQo+IGhmc3BsdXNfYXNjMnVuaSgpIGlzIGNhbGxlZC4gVGhpcyBmb3JjZXMgaGZzcGx1
c19hc2MydW5pKCkgdG8gbmF0dXJhbGx5DQo+IHJldHVybiAtRU5BTUVUT09MT05HLCB3aGljaCBw
cm9wYWdhdGVzIHRvIGhmc3BsdXNfY2F0X2J1aWxkX2tleSgpIGFuZA0KPiBleGVyY2lzZXMgdGhl
IGZhdWx0eSBlcnJvciBwYXRoLiBUaGUgZm9sbG93aW5nIHdhcm5pbmcgd2FzIG9ic2VydmVkDQo+
IGR1cmluZyBtb3VudDoNCj4gDQo+IAk9PT09PT09PT09PT09PT09PT09PT09PT09DQo+IAlXQVJO
SU5HOiBoZWxkIGxvY2sgZnJlZWQhDQo+IAk3LjAuMC1yYzMtMDAwMTYtZ2I0ZjBkZDMxNGIzOSAj
NCBOb3QgdGFpbnRlZA0KPiAJLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAJbW91bnQvMTc0
IGlzIGZyZWVpbmcgbWVtb3J5IGZmZmY4ODgxMDNmOTIwMDAtZmZmZjg4ODEwM2Y5MmZmZiwgd2l0
aCBhIGxvY2sgc3RpbGwgaGVsZCB0aGVyZSENCj4gCWZmZmY4ODgxMDNmOTIwYjAgKCZ0cmVlLT50
cmVlX2xvY2speysuKy59LXs0OjR9LCBhdDogaGZzcGx1c19maW5kX2luaXQrMHgxNTQvMHgxZTAN
Cj4gCTIgbG9ja3MgaGVsZCBieSBtb3VudC8xNzQ6DQo+IAkjMDogZmZmZjg4ODEwM2Y5NjBlMCAo
JnR5cGUtPnNfdW1vdW50X2tleSM0Mi8xKXsrLisufS17NDo0fSwgYXQ6IGFsbG9jX3N1cGVyLmNv
bnN0cHJvcC4wKzB4MTY3LzB4YTQwDQo+IAkjMTogZmZmZjg4ODEwM2Y5MjBiMCAoJnRyZWUtPnRy
ZWVfbG9jayl7Ky4rLn0tezQ6NH0sIGF0OiBoZnNwbHVzX2ZpbmRfaW5pdCsweDE1NC8weDFlMA0K
PiANCj4gCXN0YWNrIGJhY2t0cmFjZToNCj4gCUNQVTogMiBVSUQ6IDAgUElEOiAxNzQgQ29tbTog
bW91bnQgTm90IHRhaW50ZWQgNy4wLjAtcmMzLTAwMDE2LWdiNGYwZGQzMTRiMzkgIzQgUFJFRU1Q
VChsYXp5KQ0KPiAJSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwg
MjAwOSksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAxNA0KPiAJQ2FsbCBUcmFjZToNCj4gCTxUQVNL
Pg0KPiAJZHVtcF9zdGFja19sdmwrMHg4Mi8weGQwDQo+IAlkZWJ1Z19jaGVja19ub19sb2Nrc19m
cmVlZCsweDEzYS8weDE4MA0KPiAJa2ZyZWUrMHgxNmIvMHg1MTANCj4gCT8gaGZzcGx1c19maWxs
X3N1cGVyKzB4Y2I0LzB4MThhMA0KPiAJaGZzcGx1c19maWxsX3N1cGVyKzB4Y2I0LzB4MThhMA0K
PiAJPyBfX3BmeF9oZnNwbHVzX2ZpbGxfc3VwZXIrMHgxMC8weDEwDQo+IAk/IHNyc29fcmV0dXJu
X3RodW5rKzB4NS8weDVmDQo+IAk/IGJkZXZfb3BlbisweDY1Zi8weGMzMA0KPiAJPyBzcnNvX3Jl
dHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBwb2ludGVyKzB4NGNlLzB4YmYwDQo+IAk/IHRyYWNl
X2NvbnRlbnRpb25fZW5kKzB4MTFjLzB4MTUwDQo+IAk/IF9fcGZ4X3BvaW50ZXIrMHgxMC8weDEw
DQo+IAk/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQo+IAk/IGJkZXZfb3BlbisweDc5Yi8w
eGMzMA0KPiAJPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBzcnNvX3JldHVybl90
aHVuaysweDUvMHg1Zg0KPiAJPyB2c25wcmludGYrMHg2ZGEvMHgxMjcwDQo+IAk/IHNyc29fcmV0
dXJuX3RodW5rKzB4NS8weDVmDQo+IAk/IF9fbXV0ZXhfdW5sb2NrX3Nsb3dwYXRoKzB4MTU3LzB4
NzQwDQo+IAk/IF9fcGZ4X3ZzbnByaW50ZisweDEwLzB4MTANCj4gCT8gc3Jzb19yZXR1cm5fdGh1
bmsrMHg1LzB4NWYNCj4gCT8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYNCj4gCT8gbWFya19o
ZWxkX2xvY2tzKzB4NDkvMHg4MA0KPiAJPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJ
PyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBpcnFlbnRyeV9leGl0KzB4MTdiLzB4
NWUwDQo+IAk/IHRyYWNlX2lycV9kaXNhYmxlLmNvbnN0cHJvcC4wKzB4MTE2LzB4MTUwDQo+IAk/
IF9fcGZ4X2hmc3BsdXNfZmlsbF9zdXBlcisweDEwLzB4MTANCj4gCT8gX19wZnhfaGZzcGx1c19m
aWxsX3N1cGVyKzB4MTAvMHgxMA0KPiAJZ2V0X3RyZWVfYmRldl9mbGFncysweDMwMi8weDU4MA0K
PiAJPyBfX3BmeF9nZXRfdHJlZV9iZGV2X2ZsYWdzKzB4MTAvMHgxMA0KPiAJPyB2ZnNfcGFyc2Vf
ZnNfcXN0cisweDEyOS8weDFhMA0KPiAJPyBfX3BmeF92ZnNfcGFyc2VfZnNfcXN0cisweDMvMHgx
MA0KPiAJdmZzX2dldF90cmVlKzB4ODkvMHgzMjANCj4gCWZjX21vdW50KzB4MTAvMHgxZDANCj4g
CXBhdGhfbW91bnQrMHg1YzUvMHgyMWMwDQo+IAk/IF9fcGZ4X3BhdGhfbW91bnQrMHgxMC8weDEw
DQo+IAk/IHRyYWNlX2lycV9lbmFibGUuY29uc3Rwcm9wLjArMHgxMTYvMHgxNTANCj4gCT8gdHJh
Y2VfaXJxX2VuYWJsZS5jb25zdHByb3AuMCsweDExNi8weDE1MA0KPiAJPyBzcnNvX3JldHVybl90
aHVuaysweDUvMHg1Zg0KPiAJPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBrbWVt
X2NhY2hlX2ZyZWUrMHgzMDcvMHg1NDANCj4gCT8gdXNlcl9wYXRoX2F0KzB4NTEvMHg2MA0KPiAJ
PyBfX3g2NF9zeXNfbW91bnQrMHgyMTIvMHgyODANCj4gCT8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1
LzB4NWYNCj4gCV9feDY0X3N5c19tb3VudCsweDIxMi8weDI4MA0KPiAJPyBfX3BmeF9fX3g2NF9z
eXNfbW91bnQrMHgxMC8weDEwDQo+IAk/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQo+IAk/
IHRyYWNlX2lycV9lbmFibGUuY29uc3Rwcm9wLjArMHgxMTYvMHgxNTANCj4gCT8gc3Jzb19yZXR1
cm5fdGh1bmsrMHg1LzB4NWYNCj4gCWRvX3N5c2NhbGxfNjQrMHgxMTEvMHg2ODANCj4gCWVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YNCj4gCVJJUDogMDAzMzoweDdmZmFj
YWQ1NWVhZQ0KPiAJQ29kZTogNDggOGIgMGQgODUgMWYgMGYgMDAgZjcgZDggNjQgODkgMDEgNDgg
ODMgYzggZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgZjMgMGYgMWUgZmEg
NDkgODkgY2EgYjggYTUgMDAgMDAgOA0KPiAJUlNQOiAwMDJiOjAwMDA3ZmZmMWFiNTU3MTggRUZM
QUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBhNQ0KPiAJUkFYOiBmZmZmZmZm
ZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDA3ZmZhY2FkNTVlYWUNCj4g
CVJEWDogMDAwMDU1NzQwYzY0ZTViMCBSU0k6IDAwMDA1NTc0MGM2NGU2MzAgUkRJOiAwMDAwNTU3
NDBjNjUxYWIwDQo+IAlSQlA6IDAwMDA1NTc0MGM2NGUzODAgUjA4OiAwMDAwMDAwMDAwMDAwMDAw
IFIwOTogMDAwMDAwMDAwMDAwMDAwMQ0KPiAJUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAw
MDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gCVIxMzogMDAwMDU1NzQwYzY0
ZTViMCBSMTQ6IDAwMDA1NTc0MGM2NTFhYjAgUjE1OiAwMDAwNTU3NDBjNjRlMzgwDQo+IAk8L1RB
U0s+DQo+IA0KPiBBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCB0aGUgd2FybmluZyBubyBsb25n
ZXIgYXBwZWFycy4NCj4gDQo+IEZpeGVzOiA4OWFjOWI0ZDNkMWEgKCJoZnNwbHVzOiBmaXggbG9u
Z25hbWUgaGFuZGxpbmciKQ0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQt
b2ZmLWJ5OiBaaWxpbiBHdWFuIDx6aWxpbkBzZXUuZWR1LmNuPg0KPiAtLS0NCj4gIGZzL2hmc3Bs
dXMvc3VwZXIuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2Zz
L2hmc3BsdXMvc3VwZXIuYw0KPiBpbmRleCA3MjI5YThhZTg5ZjkuLmYzOTZmZWUxOWFiOCAxMDA2
NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIu
Yw0KPiBAQCAtNTY5LDggKzU2OSwxMCBAQCBzdGF0aWMgaW50IGhmc3BsdXNfZmlsbF9zdXBlcihz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ICAJaWYgKGVy
cikNCj4gIAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ICAJZXJyID0gaGZzcGx1c19jYXRfYnVpbGRf
a2V5KHNiLCBmZC5zZWFyY2hfa2V5LCBIRlNQTFVTX1JPT1RfQ05JRCwgJnN0cik7DQo+IC0JaWYg
KHVubGlrZWx5KGVyciA8IDApKQ0KPiArCWlmICh1bmxpa2VseShlcnIgPCAwKSkgew0KPiArCQlo
ZnNfZmluZF9leGl0KCZmZCk7DQo+ICAJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiArCX0NCj4gIAlp
ZiAoIWhmc19icmVjX3JlYWQoJmZkLCAmZW50cnksIHNpemVvZihlbnRyeSkpKSB7DQo+ICAJCWhm
c19maW5kX2V4aXQoJmZkKTsNCj4gIAkJaWYgKGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYoSEZT
UExVU19GT0xERVIpKSB7DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2
IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KDQpUaGUgeGZzdGVzdHMgZGlkbid0IHJldmVh
bGVkIGFueSBuZXcgaXNzdWVzLg0KDQpUZXN0ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xh
dmFAZHViZXlrby5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K

