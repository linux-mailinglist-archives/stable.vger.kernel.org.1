Return-Path: <stable+bounces-200769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E91CB4D52
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 07:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43081300E3CC
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765FD19E7F7;
	Thu, 11 Dec 2025 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pi+n29Qp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33197FC0A
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765432892; cv=fail; b=LMwp+AFoyT3+/O7fpziNkPKonuCra/caQZU3VIYhsMHW9SZA9HYRFWQLmWLcfxZJY6o4vNHj7Asr7Anuz9UcwERXnsQoBvrJQBHKjj8VNbN+yrKWnZ/M33cDMmrpiWiC1XK14/fqW4iak0KIOdlV66kjHFdySKcIQIVNRwiSwUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765432892; c=relaxed/simple;
	bh=DVXxR0f1qjKBSHseKZURE//T1E+ub8w+eTIr1DCMt+8=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=RH2RP+lQzgQ1kOevyuRKoG5zjXM8jHlEq9/kHwfaok1nsgRPiSA+d4qjEI6LBTeNQJR2HrR7dxHRjRuagQLaq8/PVtHqNnYoB4mhJIXsXdVu73/4Zud1ipWF787zVLXDqH1BtntULboW/W10V0lBRPa3LWPOWliT0CLLaeejStY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pi+n29Qp; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB4kUsL2374791
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=seekXBSiQZETdWXbBzz1
	VQT/ati+JRgPbPFPBRakL4w=; b=pi+n29Qp1nF/svcvlcAIbMZRS4L30sFu9gQw
	3azA71K/cLUbYa47qqKhvyzOKXJtxksO+PAxiD7+lcLwbjU9sbvHLNLXzwk7Ijyk
	SSzeB/CEXcr4aEB/svQm+sSV1RxUdr32W7HWt4BLs/s37JIWJH8ACsfJC0+Fd8/k
	zMf6RzER6WlPTxnrPfDeKYk3VN+Twgme5cw1cGb+nj8SSAVJqddnbZipScvXx1f7
	sel8N/b/9pIaKQkg9osHib8mUowS+cOTt66sfF1n1CuVfLPQ7OMOhFPasnC9rSBI
	SbJXtm8a/0us4N08xUAy5rfOPcfDAncvDNBl2DgPHJb9lajbVA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ay07hsmaw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:01:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJchANTilJz1mp06nf7rtalWEz1E9iFNRZa9k+qL8+Yq/eVhjUm6/nzi5rWbF8xBCgyvp+1/1YEu6i+GaSjqCkZOn/u6okThCLW7aPJw9ZsCsxxN+qsE/WynhwptfxFAPnaoBicoa7S7V5WvppeQ2yXN0c0K1XahieOdqK7cQGtnRCQovvEPUZbJEm8jXuNEPWBl90io4N3GtT//T8IjVLFy2J1h/Wa6ZeypoDRWXB/vWZxLSbah0MKTMrlyr5oS0o2JCacGqv+1OUaKxIVGj7K4nzE2VNuqz0rKy5wUDp8Js1QlSpdJPKOoy5Y7xVgqpRqUm9a85YVEyQV4uoBR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seekXBSiQZETdWXbBzz1VQT/ati+JRgPbPFPBRakL4w=;
 b=oDwQjXwx7SAHTrMGvkt/RGtQMs3S8y/YZ0TJYT/mH50kBppaUOslVYdeFTkJx9egHRNBy5PW5Wv+HrEsfEKGBCDARI7SfwOUWKO/SgQDUdIdL0qNO8waQsc8QjDRuNVLbve9ja+eQ7yUGH/oZnJbX0q8WkP8lbN4yC6OdKWFqTHKvRJypQOQWtq1bhVrD4k6OLYrn6s1eKWTx6iuudOKUOZfw+4IfXh0w+XRIGIMmsgtkm8CRd/K43D64cP6d/CdrZrSmJe9tR3lMPovHVyd2h2ky08+qiWS19x94/vQMgAbSbXwAKtYqPx25T78r/GtPseeApv/SFa77LldZmfKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by SA1PR11MB8796.namprd11.prod.outlook.com (2603:10b6:806:467::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 06:01:19 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:01:19 +0000
Message-ID: <e349d73b-43d3-4f4e-b5d5-44df0c91f8f4@windriver.com>
Date: Thu, 11 Dec 2025 14:01:12 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: "Zhang, Liyin (CN)" <liyin.zhang.cn@windriver.com>
Subject: Request to backport net/lan743x crashkernel fix to 6.1, 6.6, and 6.12
 branches.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0085.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::9) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|SA1PR11MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b2f46b-8fc4-4e37-82c7-08de387ab433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHFsQVF2NE02cHE2UXlHbEM3MW8rUjBvdU1GZkprRmxTb01YelhPOTB6cjY3?=
 =?utf-8?B?UTltd0xmWTROY2ZxWVdTSHY0S1lwMkNiL0pCc1prSURBRzZEWG5aY24xUElY?=
 =?utf-8?B?V0tuVkhKc1luT0JFNStXcmdDdk5OZkNTR1h0Z054Y1g1dkZTd2ZNaGcybStU?=
 =?utf-8?B?TG14RmxYRmh1S0JVUDFoNkp3QlZaQWxpck4vTUtjRWF4V3Y2K3Npcklya0xH?=
 =?utf-8?B?ZUpmcUZkYWtNaFFpRGhOMUJpY1NRYjNVb3RpS1JzTWo5YXBScmpwY2xoYVZM?=
 =?utf-8?B?Y21pb0VHTmV4SEFoajJUbTBGdGxMT2lwMk5tSmFNanh3cHlZcjNyeHFxYXR6?=
 =?utf-8?B?THBqeHRmSjFjWlZXcG81N3B2bnVGVlFvNkk3UUMrN2FXMXZRMHdzLzNjbWdZ?=
 =?utf-8?B?bVBDV1FFVXBWdXBaWWxFOXhDK2V1Mi8xalE2OGIzOXcwaVpMaHNXZS9YS3FP?=
 =?utf-8?B?NVZGUEUwL3BaVXAxN05VeFAvWVZOOVN0akZPZGdyOUFnbWdBVFVsQytIb1cr?=
 =?utf-8?B?b29OVU5tUVVVYVM5bjNTK2E4cVQ4bVFIUWZZaVp1Vy93SGN4aFljM3hJQXJr?=
 =?utf-8?B?V0hwL2lNbmEvK1N2VEJ6SHRSSTV3b2FEQW5KSWRSYW14L1YvZzFvUW4xbndq?=
 =?utf-8?B?eWJWSHFQaWJxemttUDhmOXprK1h1enFNN2JoMEZHay9XZjZ3dTBuWXdzYmpB?=
 =?utf-8?B?OUtPa0JyNndYd05zTnJrbGdVN0MrYkJBUjBNN0h1N0dkUGdhaEQvdTA4L3B2?=
 =?utf-8?B?YW0xY25weEdBUXpMVEtiRVd4bUJwaWljK0ljT2lCZHNPcUZVQVFCZ1pSeHQx?=
 =?utf-8?B?cEorKzdyNjZnKy9vdXlxWHRpY2hUMVdvWVA2S21WSVY0eTB0V2NYVG1NWWd5?=
 =?utf-8?B?YU9RRzFFMnVXSFN4b3JhdUJaamcrcEo3YmFwMHFERWtsanJ5N2MxUTNtMW5M?=
 =?utf-8?B?ZXJ0NG9vaWtUN0NoZm5zdGo0aWQ0Zk9KaXpJRklPcWVyU2dMU0dPWUhmczUx?=
 =?utf-8?B?bkR6Qjg0QXYwUVMxYk80b1JIdHg2UERpRE5lbWVYRUlOZUNzZUkrOHg1NHVH?=
 =?utf-8?B?dmp0RmFoNGdIK3pSeEY0eGRia1BxNXpmVXZ5MUdVMzVjcXFzT1dNMFFjai9a?=
 =?utf-8?B?UnhscU9VUjBWVXQ5cUhmTG5KcmdzblUvaGZ2ZWpZSk41cXpUN1NOU2dZWXlm?=
 =?utf-8?B?S3Zrb3ozSmUzYS9SbzJRdytYZkxUZ08zdXc4T2czZG9kTUJVRjBJeG1XRWlv?=
 =?utf-8?B?Unc0aTFuU20rY1E2dW1EVHVLQWRYL25IajZDVnpvZDBvZGpIb0pzKzJYNE1u?=
 =?utf-8?B?RXBveU5TY2VLeXQ0eHlzYUZrYlNhanE3dzlHbXpKdlM5bmdwVHUrbmxTUW1r?=
 =?utf-8?B?TG8yajJGT3lmZFdIZG84T3J6aHRqSVQ5L2VHbnZLVWdXUkZTQnhqaGMrK1Yz?=
 =?utf-8?B?NzlrdTZzaHl4UU1iYUMrQVlRelpNc0ZFNkp1aFBPSlhTaUthWFUvaVJKVlgz?=
 =?utf-8?B?eXdJWVZxT0JKY1RDQVBMUXFFUCtNclNaTjdwdVRTd1VNU3NLZDRyalJQTFR0?=
 =?utf-8?B?ME0vYjRYWndSMHlMNkFTV1RYbHBNRG9xQzFMNWVuZDNxUGp2b2pZTER3VTBy?=
 =?utf-8?B?dFJIQU4rdjZyaEt1WC92ckNoODNDYmRsZTd2YTV0a3Jnc00wK2JwVm5FZjZu?=
 =?utf-8?B?WS91bVNMc01IQVB4WXBCcHFJQVRrMGtCZEUvZmpVdXErZnlnRGIxZStZRDB4?=
 =?utf-8?B?WWtkcnZucmE2VGxmUzV1WS9aa2FldERSbXVzUytQY1dYalVZWlRlVFNaUWF4?=
 =?utf-8?B?dXdQdHFFT3JnVjBIREFoV3hKaW1ZNE1GeTVyTElhNThCZEU1K3A0T2FzWnQ5?=
 =?utf-8?B?aUhyeWl5Q3pNZGFpZitncEo0TkRPeVA0c252ZG5XTGx6M1k4SnVyUURneTRH?=
 =?utf-8?B?L3hvd3lRRDJRdHFkSTNCcGc2SWx6RTljaEkwcE9peUIzdXowNHlJSFZKWUc3?=
 =?utf-8?B?d3Z5NFN6NVpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ZJcGprUnQ4YzZXRUFEaWF0NURnb29PekY0WnZoc1FHR015bHpxWmdWNUd0?=
 =?utf-8?B?N1FIK1crVEt2TXF2VHBnTHl0d2MvSEFHRU5xYy9MUWh2TktueVg2WkRRSzMw?=
 =?utf-8?B?eTFEVGpnc3VlV1A2RklMQ3U0a1V6M1I1QmE5enViZjJQZTNOejBWTkxzbkZl?=
 =?utf-8?B?eHUzd0JmU09KUTZyWUNyR2RkektpNDRYZ0NqVVNPVEZqMW9JRnhEbEtYcWh4?=
 =?utf-8?B?U1lLK3hmMDhndGkxL3hWRU9RSXFHZmRlUFp2NUJJTTNNMHh6T01kLzNIRlRn?=
 =?utf-8?B?Z1haanZ5WTlPVm1KZ1dYRXN2OUVqdktCbVUxcGVVZVFHa1VLRzhVK0orZjlN?=
 =?utf-8?B?eGc0aWRvekdUZXlqMWtNT0ozdzJhbUdITG1tTTIvS1l1T2UwenBBL2pKcnUx?=
 =?utf-8?B?MG8xMnlTeGI4QkU3NGNBb2RXS2VOVDdPSEFEc3k2b0pFekhXd0NwbFVmMEhI?=
 =?utf-8?B?M0VYcXBIWlZTUWFERnhJWTBUN1A5RGR3YWFoTVgzYXNtWWhJMEM4cG93bUVa?=
 =?utf-8?B?QmNpSmZ0ZWNoWk1YS1ZaMHlubi9KdUh1bTJyZHJLOVVFNnhQZndrNTRGbGZt?=
 =?utf-8?B?T29KRW5BOFozeStMMVprSHQ3a3VEbEJyN20vUi91YldXL3ZHY2RhUHd4a3pn?=
 =?utf-8?B?ck5vR3NDOERSRFlpaDVSc3VBQ0J4L0IrTHRQdWRuV2prV1FPcDRSaUxoY2Ft?=
 =?utf-8?B?ZytmSGNBY2VNb0p4cmRZVGY1c1Ztakw5aUo2ZU9ud0NFaEpVS3hxSVJ0TVVl?=
 =?utf-8?B?TDBVRFdxWm1mdW9ScWIraGdBYXRaL0ppOEFKcmxjeFNEVEw1N2Vza2liNHlK?=
 =?utf-8?B?WEhCQWc4YnV0YUQybDV1NE90WTdJbE9EQkJFUGtocWpsZE5UWUxYOEVmcjJU?=
 =?utf-8?B?RktZSUYrcDQ4WGpqY1NNcjJuVG15L1A3andjZlV3UXFQV2F4aFVOYnhzUUhx?=
 =?utf-8?B?T3dIMnFramp3cXYydlRkTGwvM2VRdlJDNHl4em1NSEsxRWo5L2laOVgvSUlJ?=
 =?utf-8?B?QWpZS3ltU1dyN2RNYSttNUd2bUF1alB5YmZEQ3Z0RXhtNG5QQXZHRXVVdklI?=
 =?utf-8?B?RFQyaHoxVGlweWNXY05mZW92RXdnRHV4TUFBNmVmdjdkYVg4MWlXa0h4eEpV?=
 =?utf-8?B?VzM0L2wwUW0ybGVpVndDN2UzU1ZZZElPNjZXUmhQVDNuQ3phbGRkTytmYk5G?=
 =?utf-8?B?YzlHTkRsSnlqOXhONzdmRVE2QWVabGU2R1RHSVI2YjBWVDdSRmVSakJuM1hJ?=
 =?utf-8?B?dmoycmNmU0p0REgwTDV3b253SzNST0d3VUE5d1RLc2tXb3ZZOHJUQk55WGVW?=
 =?utf-8?B?Z1dlNUFsNlQ4ZDh5R05jdVFpYyt1aGphdjRhOW9GYjZEZGVndXh1Z1hIa0FI?=
 =?utf-8?B?NlpwSDNGNWF4by9tbWlBeXdnK0tIUmtZUGowWjBKeUovMDZUWks4ZFV4amVv?=
 =?utf-8?B?VC9RaGhZN1VkcURzaUJmK1JRTksvSHBCY3g3citISjN4ZnB0QzlBSGE5eXFP?=
 =?utf-8?B?MHpuMXhZWmdmb3N6eDVSTkZXbEtudC91QXVKaE8vRWs4TXhYYUNZd0pTNE54?=
 =?utf-8?B?a0NyTUNZRndGK25vV3ZXUHVZKzEwZUVseERkNDNWWm84VllxNVVPVmMrNkVS?=
 =?utf-8?B?QnVFTEFya2paSE1EcVNPSGs0MTc2d3VBNVFHQjJIMEUxdUtSbUhhKy84eEFR?=
 =?utf-8?B?aCsrS1Q4dUEwVnEwQURGUkUrdU9HLzI1QTlsd0FEcHhTbmdqcFRoRTAySmtT?=
 =?utf-8?B?QnFPWUJqc1hGQ0hIM0pMMXpnKzBOVnNncU42NFdmRm5MVVF6cE5COUpxSy93?=
 =?utf-8?B?QVBoM0JsWStJcTlGdk9JN1FtTTBxR1hxejA2MjZtTFgzWXhxaGFXc21ZUjhW?=
 =?utf-8?B?RDIvOFlFUUErRHhQMnpLTTduczJJOHJDZUJMTnhOQVJBb0c3T0RTYnFkbFlp?=
 =?utf-8?B?VVcwM1h1WGVMYWlBUXZOSHRWcmUzYmxvREhkb0J2aDNZcExrNm1yYjlFbEIw?=
 =?utf-8?B?YUpmT1FSRzZwWE5pbmxDaG5EcXVaZFpGVzlnY0JLM0JxRjV6anNXQTlYT0pz?=
 =?utf-8?B?SmdHYzljWFZSL2RpNUxQL0pURW16ODdFR2l0aDdkbCt2TndoWFVDVzFPaDly?=
 =?utf-8?B?eWo5RFdlVFc1Qm53eTVZUW1Hd3lYOTVGTklhQ1d4R2tXVUtFSzA2WUxzM3Vp?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b2f46b-8fc4-4e37-82c7-08de387ab433
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:01:19.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFLyJu+KoVN7rA31HcLKmeGO0R6VXjvHs1VHTQCdmG8EQxiyRwfHCKvKRHpltWJrSxIbNOSE1BaUPSoxxqZI8OOlaNt5dVO/pCA82EQOyVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8796
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA0MSBTYWx0ZWRfX64ZzOYnpy/3q
 Qd88ZiM/3y7oWlAvVLw1ymm14TxOfZwkdh+XofTnt7OJXW/2OtUoty3K0SptBtgL4w3boERv3OQ
 rt9a9hvvICbH0xYw6hlfKvR8qBTLsB4DjzDae600bXW9ODJvspf4gCPnQzOoD7iyqe/Gd1Denwx
 4b7/OTn1EKzBtJpRNYzo10OyEjTzLJ9Iced9ygNAUpGZTgD8q1lyP26Q5ZInJp4YvJH/M9WH6yx
 N5hqOntvqDFOYvBAgRgzaw7XPMwMZxY7x0vn1Qzkidh6wy4EFhQGX7Qj60SyZAIiQFAvDcV3wrb
 ReKX6HbwtJQfPj/vDX4NIJjC2i1Kq0JXAU9Ev8VhKZOzHIv4/pGAprSEdLiUlcAawPz092Cll/Q
 zZzcPC8RA9X1BGQtg2IqfT5j2zb//Q==
X-Proofpoint-ORIG-GUID: VF6QxxLRw6-judLHu5T12rXgqZZQuVbS
X-Proofpoint-GUID: VF6QxxLRw6-judLHu5T12rXgqZZQuVbS
X-Authority-Analysis: v=2.4 cv=dbyNHHXe c=1 sm=1 tr=0 ts=693a5e32 cx=c_pps
 a=ThMr3hCQx13Nvzo14U/9jA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=6ReVYlNrknkcCv_BwLAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512110041

Hi,

The following patch has already been merged into mainline (master) and 
the linux-6.12.y stable branch:
net: lan743x: Allocate rings outside ZONE_DMA (commit 
8a8f3f4991761a70834fe6719d09e9fd338a766e)
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8a8f3f4991761a70834fe6719d09e9fd338a766e
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.17.y&id=8a8f3f4991761a70834fe6719d09e9fd338a766e

I believe this patch should be backported. Our customer is experiencing 
an issue where a Microchip LAN7430 NIC fails to work in a crashkernel 
environment.
Because the driver uses the ZONE_DMA flag, memory allocation fails when 
crashkernel reserves memory — preventing the card from functioning, 
especially when they try to transfer the VMcore file over network.

We are using older kernel versions and request that this fix be applied 
to the following branches:
linux-6.1.y
linux-6.6.y
linux-6.12.y
Could you please help backport this fix?

Thank you for your time and support.

Best regards,
Liyin


